/* ============================================================================
   e-Factura (SIA SFS) prin API - legatura facturilor WMS cu e-Factura

   TDB_EFACTURA           - o linie per factura WMS (TDB_INVOICES) trimisa prin
                            API: identificatorul nostru din AdditionalInformation
                            (API_ID), seria/numarul atribuite de e-Factura si
                            ultimul status cunoscut (EF_STATUS):
                               -1 trimisa, inca negasita in e-Factura
                                0 draft (Facturi noi)   1 semnata de furnizor
                                2 refuzata de cumparator 3 acceptata de cumparator
                                5 anulata de furnizor    6 arhivata
                                7 trimisa la cumparator  8 semnata de cumparator
                               10 transportata
   SP_EFACTURA_SET_NUMBER - rezultatul sincronizarii: statusul in TDB_EFACTURA si
                            "SERIA NUMAR" in TDB_INVOICES.FACTURANO (acelasi format
                            pe care il tasta operatorul, ex. EBM 000108617).
   TS_API_CONFIG          - BASE_URL / USERNAME / PASSWORD, cate un set per firma
                            emitenta (TDB_DOCS.DT): API_CODE = 'EFACTURA_<DT>'.
                            Fiecare firma are propriul utilizator API in e-Factura.
                            Parolele NU stau in script - se completeaza din
                            Setari > Configurari API.

   Folosit de sources\classes\EFactura\EFacturaManager.pas.

   Scriptul doar ADAUGA obiecte noi; tabelele existente nu se modifica (de aceea
   nu exista FK spre TDB_INVOICES - stergerea facturilor trimise o blocheaza WMS).

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_EFACTURA')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TDB_EFACTURA (
             INVOICEID      INTEGER NOT NULL,
             DOCID          INTEGER NOT NULL,
             API_ID         VARCHAR(40) NOT NULL,
             REQUEST_ID     VARCHAR(40),
             SERIA          VARCHAR(10),
             EF_NUMBER      VARCHAR(20),
             EF_STATUS      SMALLINT DEFAULT -1 NOT NULL,
             EF_STATUS_DATE TIMESTAMP,
             SENT_AT        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             SENT_BY        INTEGER,
             XML_SENT       BLOB SUB_TYPE TEXT,
             LAST_ERROR     VARCHAR(1024),
             UPDATED_AT     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CONSTRAINT PK_TDB_EFACTURA PRIMARY KEY (INVOICEID)
         )';
END^

COMMIT^

/* --- 2. Indecsi ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UNQ_TDB_EFACTURA_API_ID')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UNQ_TDB_EFACTURA_API_ID ON TDB_EFACTURA (API_ID)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TDB_EFACTURA_DOCID')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TDB_EFACTURA_DOCID ON TDB_EFACTURA (DOCID)';
END^

COMMIT^

/* --- 3. Trigger ---------------------------------------------------------- */
CREATE OR ALTER TRIGGER TDB_EFACTURA_BU FOR TDB_EFACTURA
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
END^

/* --- 4. Procedura -------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_EFACTURA_SET_NUMBER (
    INVOICEID INTEGER,
    SERIA     VARCHAR(10),
    EF_NUMBER VARCHAR(20),
    EF_STATUS SMALLINT)
AS
DECLARE VARIABLE V_DOCID INTEGER;
DECLARE VARIABLE V_OLD_NO VARCHAR(64);
DECLARE VARIABLE V_NEW_NO VARCHAR(64);
DECLARE VARIABLE V_CANCELED SMALLINT;
BEGIN
    SELECT DOCID FROM TDB_EFACTURA WHERE INVOICEID = :INVOICEID INTO :V_DOCID;
    IF (V_DOCID IS NULL) THEN
        EXCEPTION ERR_INVALID_INVOICE '<MSG>Factura nu a fost trimisa in e-Factura.</MSG>';

    UPDATE TDB_EFACTURA
       SET SERIA = NULLIF(TRIM(:SERIA), ''),
           EF_NUMBER = NULLIF(TRIM(:EF_NUMBER), ''),
           EF_STATUS = :EF_STATUS,
           EF_STATUS_DATE = CURRENT_TIMESTAMP,
           LAST_ERROR = NULL
     WHERE INVOICEID = :INVOICEID;

    /* inca fara serie/numar (factura in procesare) - doar statusul */
    IF (COALESCE(TRIM(:SERIA), '') = '' OR COALESCE(TRIM(:EF_NUMBER), '') = '') THEN
        EXIT;

    SELECT FACTURANO, FLG_CANCELED FROM TDB_INVOICES
     WHERE DOCID = :V_DOCID AND INVOICEID = :INVOICEID
      INTO :V_OLD_NO, :V_CANCELED;
    IF (V_CANCELED = 1) THEN
        EXIT;

    V_NEW_NO = TRIM(:SERIA) || ' ' || TRIM(:EF_NUMBER);
    IF (COALESCE(TRIM(V_OLD_NO), '') = '') THEN
        UPDATE TDB_INVOICES SET FACTURANO = :V_NEW_NO
         WHERE DOCID = :V_DOCID AND INVOICEID = :INVOICEID;
    ELSE IF (REPLACE(V_OLD_NO, ' ', '') <> REPLACE(V_NEW_NO, ' ', '')) THEN
        EXCEPTION ERR_INVALID_INVOICE '<MSG>Factura are deja numarul ' || TRIM(V_OLD_NO) ||
            ', dar e-Factura a atribuit ' || V_NEW_NO || '.</MSG>';
END^

COMMIT^

/* --- 5. Configurare API, cate un set per firma emitenta -------------------
   (nu suprascrie valorile existente)                                        */

/* 5a. migrare: prima varianta a scriptului folosea un singur API_CODE = 'EFACTURA' */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'EFACTURA_307225')) THEN
        UPDATE TS_API_CONFIG SET API_CODE = 'EFACTURA_307225'
         WHERE API_CODE = 'EFACTURA' AND SUPPLIERID = 307225;
END^

/* 5b. PRIME STORE SRL (DT 307225) */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_307225' AND PARAM_NAME = 'BASE_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_307225', 'BASE_URL', 'https://efactura-api.sfs.md/Service.svc', 307225,
                'SIA e-Factura (SFS); firma emitenta PRIME STORE SRL', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_307225' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_307225', 'USERNAME', 'efactura_prime_api', 307225,
                'Utilizator API creat de director in e-Factura', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_307225' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_307225', 'PASSWORD', NULL, 307225,
                'Se completeaza din Setari > Configurari API', 'SYSTEM');
END^

/* 5c. Solutii Comerciale SRL (DT 316910) */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_316910' AND PARAM_NAME = 'BASE_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_316910', 'BASE_URL', 'https://efactura-api.sfs.md/Service.svc', 316910,
                'SIA e-Factura (SFS); firma emitenta Solutii Comerciale SRL', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_316910' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_316910', 'USERNAME', 'efactura_api', 316910,
                'Utilizator API creat de director in e-Factura', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'EFACTURA_316910' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('EFACTURA_316910', 'PASSWORD', NULL, 316910,
                'Se completeaza din Setari > Configurari API', 'SYSTEM');
END^

SET TERM ; ^

COMMIT;

/* --- 6. Drepturi (WMS se conecteaza ca SYSDBA, dar rolul SWN e folosit de scripturile noi) */
GRANT SELECT, UPDATE ON TDB_EFACTURA TO PROCEDURE SP_EFACTURA_SET_NUMBER;
GRANT SELECT, UPDATE ON TDB_INVOICES TO PROCEDURE SP_EFACTURA_SET_NUMBER;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TDB_EFACTURA TO SWN;
GRANT EXECUTE ON PROCEDURE SP_EFACTURA_SET_NUMBER TO SWN;

COMMIT;

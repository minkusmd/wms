/* ============================================================================
   Fisa companiei proprii / subdiviziunii (forma "Companie / subdiviziune",
   sources/classes/Company/frmCompanyCardDialog.pas) - ca "Organizatii" din 1C.

   Datele existente raman unde sint:
     TS_CUSTOMER        - denumirea scurta; firmele proprii = CUSTOMER_TYPE_ID 4002,
                          folderul 5209 "COMPANII PROPRII";
     TS_CUST_INFO       - IDNO (IDEN_NUMBER), cod TVA (VAT_NUMBER), director (CHIEF),
                          contabil (ACCOUNTANT), adresele (ADDRESS, ADDRESS2), WEBPAGE;
     TS_CUST_ACCOUNTS   - conturile bancare (ACCOUNTNUMBER = IBAN, BANKACCOUNT = BIC
                          din TS_BANKS);
     TS_CUST_STAMP      - logo, stampila, semnaturile (BLOB-uri PNG/BMP);
     TS_CUST_1C         - codurile 1C ale subdiviziunii; DT = persoana juridica.

   Nou: TS_CUST_COMPANY (1:1 cu TS_CUSTOMER) - datele de la ASP / SFS / BNS care
   nu au loc in tabelele de mai sus:
     COMPANY_KIND    1 = persoana juridica, 2 = subdiviziune, 3 = intreprinzator individual
     PARENT_FIRMAID  subdiviziunea -> persoana juridica (firma proprie, 4002)
     FULL_NAME       denumirea completa din registrul de stat
     ORG_FORM, CFOJ  forma organizatorico-juridica (text + cod CFOJ)
     CFP             forma de proprietate (cod CFP)
     CAEM_MAIN, CAEM_LIST  activitatea principala si celelalte coduri CAEM
     CUATM           codul unitatii administrativ-teritoriale
     CUIIO           codul din Registrul statistic (BNS)
     REG_DATE, REG_AUTHORITY  inregistrarea de stat
     VAT_PAYER, VAT_REG_DATE  platitor TVA si data inregistrarii
     SFS_OFFICE      subdiviziunea teritoriala a SFS
     SUBDIV_CODE     codul subdiviziunii atribuit de SFS (pentru COMPANY_KIND = 2)
     CAPITAL_SOCIAL, FOUNDERS, CHIEF_POSITION, CASHIER, NOTE
   Telefonul si e-mailul raman in TS_CUST_PHONES / TS_CUST_EMAILS, adresele in
   TS_CUST_ADDR (7663 juridica, 7662 fizica) - de acolo le iau rapoartele.

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ----------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TS_CUST_COMPANY')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TS_CUST_COMPANY (
             CUSTOMERID      INTEGER NOT NULL,
             COMPANY_KIND    SMALLINT DEFAULT 1 NOT NULL,
             PARENT_FIRMAID  INTEGER,
             FULL_NAME       VARCHAR(512),
             ORG_FORM        VARCHAR(128),
             CFOJ            VARCHAR(8),
             CFP             VARCHAR(8),
             CAEM_MAIN       VARCHAR(16),
             CAEM_LIST       VARCHAR(2000),
             CUATM           VARCHAR(16),
             CUIIO           VARCHAR(16),
             REG_DATE        DATE,
             REG_AUTHORITY   VARCHAR(255),
             VAT_PAYER       SMALLINT DEFAULT 0 NOT NULL,
             VAT_REG_DATE    DATE,
             SFS_OFFICE      VARCHAR(255),
             SUBDIV_CODE     VARCHAR(16),
             CAPITAL_SOCIAL  NUMERIC(18, 2),
             FOUNDERS        VARCHAR(4000),
             CHIEF_POSITION  VARCHAR(64),
             CASHIER         VARCHAR(64),
             NOTE            VARCHAR(1024),
             CREATED_AT      TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CREATED_BY      INTEGER,
             UPDATED_AT      TIMESTAMP,
             UPDATED_BY      INTEGER,
             CONSTRAINT PK_TS_CUST_COMPANY PRIMARY KEY (CUSTOMERID),
             CONSTRAINT FK_TS_CUST_COMPANY_CUST FOREIGN KEY (CUSTOMERID)
                 REFERENCES TS_CUSTOMER (CUSTOMERID) ON DELETE CASCADE,
             CONSTRAINT FK_TS_CUST_COMPANY_PARENT FOREIGN KEY (PARENT_FIRMAID)
                 REFERENCES TS_CUSTOMER (CUSTOMERID),
             CONSTRAINT CHK_TS_CUST_COMPANY_KIND CHECK (COMPANY_KIND IN (1, 2, 3)),
             CONSTRAINT CHK_TS_CUST_COMPANY_VAT CHECK (VAT_PAYER IN (0, 1)),
             CONSTRAINT CHK_TS_CUST_COMPANY_PARENT CHECK (PARENT_FIRMAID IS NULL OR PARENT_FIRMAID <> CUSTOMERID)
         )';
END^

COMMIT WORK^

/* --- 2. Indecsi ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TS_CUST_COMPANY_PARENT')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TS_CUST_COMPANY_PARENT ON TS_CUST_COMPANY (PARENT_FIRMAID)';
END^

COMMIT WORK^

/* --- 3. Trigger: cine si cand a modificat -------------------------------- */
CREATE OR ALTER TRIGGER TRG_TS_CUST_COMPANY_BIU FOR TS_CUST_COMPANY
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
    IF (INSERTING) THEN
        NEW.CREATED_BY = COALESCE(NEW.CREATED_BY, CAST(RDB$GET_CONTEXT('USER_SESSION', 'UserID') AS INTEGER));
    ELSE
    BEGIN
        NEW.UPDATED_AT = CURRENT_TIMESTAMP;
        NEW.UPDATED_BY = CAST(RDB$GET_CONTEXT('USER_SESSION', 'UserID') AS INTEGER);
    END
    IF (NEW.COMPANY_KIND <> 2) THEN
    BEGIN
        NEW.PARENT_FIRMAID = NULL;
        NEW.SUBDIV_CODE = NULL;
    END
END^

COMMIT WORK^

/* --- 4. Completarea pentru firmele proprii existente --------------------- */
/* Un rand pentru fiecare firma 4002 fara fisa; subdiviziunea = cele care au in
   TS_CUST_1C o alta persoana juridica (DT). Denumirea completa ramane goala si
   se completeaza din forma (butonul "Din registru"). */
EXECUTE BLOCK AS
BEGIN
    INSERT INTO TS_CUST_COMPANY (CUSTOMERID, COMPANY_KIND, PARENT_FIRMAID, VAT_PAYER)
    SELECT C.CUSTOMERID,
           IIF(EXISTS(SELECT 1 FROM TS_CUST_1C X WHERE X.CUSTOMERID = C.CUSTOMERID
                      AND X.DT IS NOT NULL AND X.DT <> C.CUSTOMERID), 2, 1),
           (SELECT FIRST 1 X.DT FROM TS_CUST_1C X WHERE X.CUSTOMERID = C.CUSTOMERID
            AND X.DT IS NOT NULL AND X.DT <> C.CUSTOMERID),
           IIF(COALESCE(TRIM(I.VAT_NUMBER), '') <> '', 1, 0)
    FROM TS_CUSTOMER C
    LEFT JOIN TS_CUST_INFO I ON I.CUSTOMERID = C.CUSTOMERID
    WHERE C.CUSTOMER_TYPE_ID = 4002 AND C.FLG_FOLDER = 0
      AND NOT EXISTS(SELECT 1 FROM TS_CUST_COMPANY F WHERE F.CUSTOMERID = C.CUSTOMERID);
END^

COMMIT WORK^

SET TERM ; ^

/* --- 5. Drepturi --------------------------------------------------------- */
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TS_CUST_COMPANY TO SWN;

COMMIT WORK;

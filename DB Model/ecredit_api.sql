/* ============================================================================
   eCredit (Easy Credit, https://api.ecredit.md) - depunerea cererilor de credit
   din WMS: sources/classes/ECredit/ECreditApiUnit.pas (clientul API) si
   frmFinantareEditorDialog.pas (editorul cererii), deschis din "Oferte" cu
   click dreapta pe document -> "Cerere de finantare / eCredit...".

   1. TWEB_CERERE_FINANTARE - coloane noi:
        EMAIL                    e-mailul solicitantului (Request_v4.CaMail)
        ECREDIT_URN              numarul cererii la eCredit (9 cifre)
        ECREDIT_PRODUCT_ID/NAME  produsul de credit ales (ECM_ShopProducts)
        ECREDIT_FIRST_PAY_DATE   data primei rate (FirstInstallmentDate)
        ECREDIT_LAST_NAME, ECREDIT_FIRST_NAME, ECREDIT_FATHER_NAME
                                 numele despartit, asa cum il cere API-ul
        ECREDIT_REQ_STATUS       RequestStatus (New / Approved / Rejected / ...)
        ECREDIT_DOC_STATUS       DocumentStatus (Currently At Shop / ...)
        ECREDIT_MESSAGE          mesajul eCredit (URNStatus_v9.Message)
        ECREDIT_INSTALLMENT      rata lunara calculata de eCredit
        ECREDIT_SENT_AT          cind a fost depusa cererea
        ECREDIT_CHECKED_AT       ultima interogare a statutului
        ECREDIT_FILES_URL        lista fisierelor trimise (copia buletinului) la
                                 partener.ecredit.md - detail.destination.url
        ECREDIT_FILES_AT         cind au fost trimise fisierele
   2. TDB_ECREDIT_LOG - jurnalul apelurilor API (cererea si raspunsul JSON,
      parola e mascata de client).
   3. TS_API_CONFIG, API_CODE = 'ECREDIT' - parametrii de acces. Valorile se
      completeaza din WMS (Setari > Configurari API):
        BASE_URL        https://api.ecredit.md (REST gateway; mediul in path,
                        apoi numele serviciului SOAP: /TEST/ECM_ShopProducts)
        ENVIRONMENT     TEST sau PRODUCTION
        USERNAME        contul magazinului in Easy Credit Core System - merge in
        PASSWORD        corpul JSON in PRODUCTION ("oricare credentiale active
                        utilizate de magazine")
        TEST_USERNAME   contul UAT dat de eCredit pentru corpul JSON in TEST
        TEST_PASSWORD   (MTadmin; parola actuala e in chat-ul cu eCredit, R. Costin)
        BASIC_USER      contul pentru antetul HTTP Basic al gateway-ului api.ecredit.md
        BASIC_PASSWORD  (eCredit: "Acces la endpoint-urile api.ecredit.md - User
                        partener.ecredit.md", parola din chat); gol = USERNAME / PASSWORD
        REQUEST_METHOD  Request_v3 (recomandat de eCredit) sau Request_v4
        SHOP_ID         ShopID-ul magazinului pentru Request_v4 (optional)
        SHOP_GROUP_ID   ShopGroupID pentru ECM_ShopProducts (optional)
        FILES_URL       https://partener.ecredit.md (API-ul de fisiere)
        SHOP_CONTACT    persoana de contact a magazinului la trimiterea
        SHOP_EMAIL      fisierelor (optional; ShopContact 3..35 caractere,
        SHOP_PHONE      ShopPhone 0XXXXXXXX)
      Mediile Core System: UAT https://tst.ecmoldova.cloud:8081 (web) / :8082
      (soap); productie https://w81.ecredit.md:8081 / :8082 (acces restrictionat).
   4. Comanda "cu 1 click" cu plata in credit creeaza din start un stub in
      TWEB_CERERE_FINANTARE (nume, telefon, suma) si cererea din cos il
      completeaza in loc sa deschida o comanda noua - modificarile sint in
      finantare_weborder_faza2.sql (WEB_CREATE_TRANSACTION_PHONE2 si
      SP_WEB_REGISTER_FINANTARE); acel script se re-ruleaza DUPA acesta.

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Coloanele noi din TWEB_CERERE_FINANTARE ------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'EMAIL')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD EMAIL VARCHAR(255)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_URN')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_URN VARCHAR(16)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_PRODUCT_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_PRODUCT_ID INTEGER';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_PRODUCT_NAME')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_PRODUCT_NAME VARCHAR(128)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_FIRST_PAY_DATE')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_FIRST_PAY_DATE DATE';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_LAST_NAME')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_LAST_NAME VARCHAR(64)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_FIRST_NAME')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_FIRST_NAME VARCHAR(64)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_FATHER_NAME')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_FATHER_NAME VARCHAR(64)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_REQ_STATUS')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_REQ_STATUS VARCHAR(64)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_DOC_STATUS')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_DOC_STATUS VARCHAR(64)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_MESSAGE')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_MESSAGE VARCHAR(1024)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_INSTALLMENT')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_INSTALLMENT NUMERIC(15, 2)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_SENT_AT')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_SENT_AT TIMESTAMP';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_CHECKED_AT')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_CHECKED_AT TIMESTAMP';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_FILES_URL')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_FILES_URL VARCHAR(512)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE' AND RDB$FIELD_NAME = 'ECREDIT_FILES_AT')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD ECREDIT_FILES_AT TIMESTAMP';
END^

/* --- 2. Jurnalul apelurilor API ------------------------------------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_ECREDIT_LOG')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TDB_ECREDIT_LOG (
             ID             BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
             DOCID          INTEGER NOT NULL,
             URN            VARCHAR(16),
             ACTION         VARCHAR(32) NOT NULL,
             HTTP_CODE      INTEGER,
             REQUEST_JSON   BLOB SUB_TYPE TEXT,
             RESPONSE_JSON  BLOB SUB_TYPE TEXT,
             ERROR_TEXT     VARCHAR(2000),
             CREATED_AT     TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CREATED_BY     INTEGER,
             CONSTRAINT PK_TDB_ECREDIT_LOG PRIMARY KEY (ID)
         )';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TDB_ECREDIT_LOG_DOCID')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TDB_ECREDIT_LOG_DOCID ON TDB_ECREDIT_LOG (DOCID)';
END^

COMMENT ON TABLE TDB_ECREDIT_LOG IS 'Jurnalul apelurilor API eCredit (api.ecredit.md) facute din WMS pentru cererile de finantare'^
COMMENT ON COLUMN TDB_ECREDIT_LOG.ACTION IS 'REQUEST / STATUS / CANCEL / PREAPPROVED / CALC / PRODUCTS'^
COMMENT ON COLUMN TDB_ECREDIT_LOG.DOCID IS 'TWEB_CERERE_FINANTARE.DOCID (oferta, comanda web sau cererea 1791)'^

/* --- 3. Parametrii de acces (nu suprascrie valorile existente) ------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'BASE_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'BASE_URL', 'https://api.ecredit.md', 21618,
                'Fara segmentul de mediu; clientul adauga /TEST sau /PRODUCTION', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'USERNAME', '', 21618,
                'Login-ul API Easy Credit (campul Login din JSON)', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'PASSWORD', '', 21618, 'Parola API Easy Credit', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'ENVIRONMENT')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'ENVIRONMENT', 'TEST', 21618,
                'TEST sau PRODUCTION', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'SHOP_ID')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'SHOP_ID', '', 21618,
                'ShopID-ul magazinului (Request_v4); gol = magazinul implicit al contului', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'SHOP_GROUP_ID')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'SHOP_GROUP_ID', '', 21618,
                'ShopGroupID pentru lista de produse (ECM_ShopProducts); optional', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'BASIC_USER')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'BASIC_USER', 'partener.ecredit.md', 21618,
                'Contul HTTP Basic al gateway-ului api.ecredit.md (dat de eCredit)', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'BASIC_PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'BASIC_PASSWORD', '', 21618,
                'Parola HTTP Basic a gateway-ului (din chat-ul cu eCredit); se completeaza din WMS', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'TEST_USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'TEST_USERNAME', 'MTadmin', 21618,
                'Contul UAT dat de eCredit; merge in corpul JSON cind ENVIRONMENT = TEST', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'TEST_PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'TEST_PASSWORD', '', 21618,
                'Parola actuala a contului UAT MTadmin (din chat-ul cu eCredit); se completeaza din WMS', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'REQUEST_METHOD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'REQUEST_METHOD', 'Request_v3', 21618,
                'Metoda de depunere a cererii: Request_v3 (recomandat de eCredit) sau Request_v4', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'FILES_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'FILES_URL', 'https://partener.ecredit.md', 21618,
                'API-ul de fisiere (copia buletinului): POST /api/{ENV}/files/upload', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'SHOP_CONTACT')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'SHOP_CONTACT', '', 21618,
                'Persoana de contact a magazinului la trimiterea fisierelor (3..35 caractere; optional)', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'SHOP_EMAIL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'SHOP_EMAIL', '', 21618,
                'E-mailul magazinului la trimiterea fisierelor (optional)', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ECREDIT' AND PARAM_NAME = 'SHOP_PHONE')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ECREDIT', 'SHOP_PHONE', '', 21618,
                'Telefonul magazinului la trimiterea fisierelor, 0XXXXXXXX (optional)', 'SYSTEM');
END^

SET TERM ; ^

/* --- 4. Drepturi --------------------------------------------------------- */
GRANT SELECT, INSERT, UPDATE, DELETE ON TDB_ECREDIT_LOG TO SWN;

COMMIT;

/* Dupa acest script se re-ruleaza finantare_weborder_faza2.sql (procedurile
   WEB_CREATE_TRANSACTION_PHONE2 si SP_WEB_REGISTER_FINANTARE modificate). */

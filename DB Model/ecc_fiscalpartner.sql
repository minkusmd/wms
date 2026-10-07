/* ============================================================================
   ECC Fiscal Partner (casa de marcat virtuala) - faza 2: SCHEMA.
   Plan: Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md
   Cod WMS: sources/FiscalPrinter/ECC/ (ECCApiClient, ECCConfigUnit,
            ECCTransactionStore, frmECCDiagnosticDialog)

   FP_DEVICES.DEVICE_TYPE   0 = MCC Tremol prin ZFPLab (tot ce exista azi)
                            1 = ECC Fiscal Partner; parametrii casei stau in
                                TS_API_CONFIG sub FP_DEVICES.ECC_API_CODE
                                (BASE_URL, API_KEY, POS_ID, POS_NAME, CASHIER_NAME, TAX_*)
   TDB_DOCS_RECEIPT.ECC_TRANS_ID - bonul ECC din care provine rindul
   TFP_ECC_CASHIER          - utilizator WMS / sofer -> casier ECC
                              (CASHIER_NAME pentru bonuri, CASHIER_ID pentru livrare)
   TFP_ECC_TRANSACTION      - jurnalul tuturor cererilor catre ECC. Rindul se
                              COMITE INAINTE de POST: TRANS_ID (UUID generat de
                              WMS) e si id-ul bonului in ECC, deci dupa o cadere
                              rezultatul se afla cu GET /receipt/{id} fara a
                              emite bonul de doua ori.
        KIND   1 = bon fiscal, 2 = bon de serviciu (depunere / retragere),
               3 = raport X, 4 = raport Z, 5 = comanda pe terminalul smart,
               6 = comanda de livrare
        STATE  0 = nou (in jurnal, netrimis), 1 = trimis (acceptat, se asteapta
               rezultatul), 2 = gata (emis in ECC), 3 = eroare definitiva,
               4 = anulat
        SOURCE_TYPE  0 = fara, 1 = factura WMS, 2 = bon POS, 3 = plata ecomm maib,
               4 = plata MIA, 5 = livrare, 6 = diagnostic
        FLG_REGISTERED  1 = rezultatul e inregistrat in WMS (TDB_DOCS_RECEIPT /
               incasare). STATE = 2 cu FLG_REGISTERED = 0 = de finalizat in WMS.

   Un singur bon activ (STATE 0/1/2) per sursa: UQ_TFP_ECC_TRANS_SOURCE
   (index partial, Firebird 5) - protectia contra dublei fiscalizari a aceleiasi
   plati online / aceluiasi bon POS.

   Script RE-RULABIL. Testat 24 sep 2026 pe o baza locala Firebird 5 cu stub-uri
   (creare, re-rulare, constringeri, index partial, triggere).
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Generator -------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$GENERATORS
                   WHERE TRIM(RDB$GENERATOR_NAME) = 'GEN_TFP_ECC_CASHIER_ID')) THEN
        EXECUTE STATEMENT 'CREATE SEQUENCE GEN_TFP_ECC_CASHIER_ID';
END^

/* --- 2. FP_DEVICES: tipul aparatului + legatura spre TS_API_CONFIG ------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'FP_DEVICES'
                     AND TRIM(RDB$FIELD_NAME) = 'DEVICE_TYPE')) THEN
        EXECUTE STATEMENT 'ALTER TABLE FP_DEVICES ADD DEVICE_TYPE SMALLINT DEFAULT 0 NOT NULL';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'FP_DEVICES'
                     AND TRIM(RDB$FIELD_NAME) = 'ECC_API_CODE')) THEN
        EXECUTE STATEMENT 'ALTER TABLE FP_DEVICES ADD ECC_API_CODE VARCHAR(30)';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'CHK_FP_DEVICES_TYPE')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE FP_DEVICES ADD CONSTRAINT CHK_FP_DEVICES_TYPE
             CHECK (DEVICE_TYPE IN (0, 1)
                    AND (DEVICE_TYPE = 0 OR ECC_API_CODE IS NOT NULL))';
END^

/* --- 3. TDB_DOCS_RECEIPT: legatura cu bonul ECC ------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_DOCS_RECEIPT'
                     AND TRIM(RDB$FIELD_NAME) = 'ECC_TRANS_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS_RECEIPT ADD ECC_TRANS_ID VARCHAR(36)';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TDB_DOCS_RECEIPT_ECC')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TDB_DOCS_RECEIPT_ECC ON TDB_DOCS_RECEIPT (ECC_TRANS_ID)';
END^

/* --- 4. TFP_ECC_CASHIER -------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TFP_ECC_CASHIER')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TFP_ECC_CASHIER (
             CASHIER_ROWID  INTEGER NOT NULL,
             API_CODE       VARCHAR(30) NOT NULL,    /* casa ECC (TS_API_CONFIG) */
             USERID         INTEGER,                 /* utilizator WMS           */
             DRIVERID       INTEGER,                 /* sofer (TS_CUSTOMER)      */
             CASHIER_NAME   VARCHAR(100) NOT NULL,   /* numele din ECC > Casieri */
             CASHIER_ID     VARCHAR(36),             /* UUID, cerut la livrare   */
             FLG_ACTIVE     SMALLINT DEFAULT 1 NOT NULL,
             NOTE           VARCHAR(256),
             CONSTRAINT PK_TFP_ECC_CASHIER PRIMARY KEY (CASHIER_ROWID),
             CONSTRAINT FK_TFP_ECC_CASHIER_USER FOREIGN KEY (USERID)
                 REFERENCES TS_USERS (USERID),
             CONSTRAINT FK_TFP_ECC_CASHIER_DRIVER FOREIGN KEY (DRIVERID)
                 REFERENCES TS_CUSTOMER (CUSTOMERID),
             CONSTRAINT CHK_TFP_ECC_CASHIER_ONE CHECK (USERID IS NULL OR DRIVERID IS NULL))';
END^

/* un utilizator / sofer are un singur casier per casa */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TFP_ECC_CASHIER_USER')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TFP_ECC_CASHIER_USER ON TFP_ECC_CASHIER (API_CODE, USERID)
             WHERE USERID IS NOT NULL';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TFP_ECC_CASHIER_DRIVER')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TFP_ECC_CASHIER_DRIVER ON TFP_ECC_CASHIER (API_CODE, DRIVERID)
             WHERE DRIVERID IS NOT NULL';
END^

/* --- 5. TFP_ECC_TRANSACTION ---------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TFP_ECC_TRANSACTION')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TFP_ECC_TRANSACTION (
             TRANS_ID           VARCHAR(36) NOT NULL,   /* UUID = id-ul din ECC     */
             API_CODE           VARCHAR(30) NOT NULL,
             FP_ID              INTEGER,
             FIRMA_ID           INTEGER,
             KIND               SMALLINT NOT NULL,
             STATE              SMALLINT DEFAULT 0 NOT NULL,
             FLG_REGISTERED     SMALLINT DEFAULT 0 NOT NULL,
             SOURCE_TYPE        SMALLINT DEFAULT 0 NOT NULL,
             SOURCE_REF         VARCHAR(64),            /* SALE_ID, TRANSACTIONID...*/
             DOCID              INTEGER,                /* factura / documentul WMS */
             SUMA               NUMERIC(15,2),
             PAY_TYPE           SMALLINT,               /* tipul ECC principal      */
             CASHIER_NAME       VARCHAR(100),
             ATTEMPTS           SMALLINT DEFAULT 0 NOT NULL,
             ORDER_STATUS       VARCHAR(20),            /* terminal smart / livrare */
             RECEIPT_NUMBER     INTEGER,                /* number                   */
             Z_NUMBER           INTEGER,                /* z_report_number / number */
             NUMBER_FROM_FIRST  INTEGER,
             ECC_DATETIME       TIMESTAMP,
             MEV_LINK           VARCHAR(255),
             DOC_FILE_NAME      VARCHAR(100),
             ERROR_MSG          VARCHAR(1000),
             REQUEST_JSON       BLOB SUB_TYPE TEXT,
             RESPONSE_JSON      BLOB SUB_TYPE TEXT,
             DOC_PNG            BLOB SUB_TYPE BINARY,
             USERID             INTEGER,
             CREATED_AT         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             UPDATED_AT         TIMESTAMP,
             CONSTRAINT PK_TFP_ECC_TRANSACTION PRIMARY KEY (TRANS_ID),
             CONSTRAINT FK_TFP_ECC_TRANS_FP FOREIGN KEY (FP_ID)
                 REFERENCES FP_DEVICES (FP_ID),
             CONSTRAINT FK_TFP_ECC_TRANS_DOC FOREIGN KEY (DOCID)
                 REFERENCES TDB_DOCS (DOCID),
             CONSTRAINT FK_TFP_ECC_TRANS_USER FOREIGN KEY (USERID)
                 REFERENCES TS_USERS (USERID),
             CONSTRAINT CHK_TFP_ECC_TRANS_KIND CHECK (KIND BETWEEN 1 AND 6),
             CONSTRAINT CHK_TFP_ECC_TRANS_STATE CHECK (STATE BETWEEN 0 AND 4),
             CONSTRAINT CHK_TFP_ECC_TRANS_SOURCE CHECK (SOURCE_TYPE BETWEEN 0 AND 6))';
END^

EXECUTE BLOCK AS
BEGIN
    /* cereri de finalizat: trimise fara rezultat sau emise dar neinregistrate */
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TFP_ECC_TRANS_STATE')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TFP_ECC_TRANS_STATE ON TFP_ECC_TRANSACTION (STATE, FLG_REGISTERED)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TFP_ECC_TRANS_CREATED')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TFP_ECC_TRANS_CREATED ON TFP_ECC_TRANSACTION (CREATED_AT)';

    /* un singur bon fiscal / comanda activa per sursa (plata online, bon POS...) */
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TFP_ECC_TRANS_SOURCE')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TFP_ECC_TRANS_SOURCE
             ON TFP_ECC_TRANSACTION (SOURCE_TYPE, SOURCE_REF)
             WHERE KIND IN (1, 5, 6) AND STATE IN (0, 1, 2)
               AND SOURCE_TYPE IN (1, 2, 3, 4, 5) AND SOURCE_REF IS NOT NULL';
END^

/* tabelele create prin EXECUTE STATEMENT devin vizibile triggerelor abia dupa commit */
COMMIT^

/* --- 6. Triggere ---------------------------------------------------------- */
CREATE OR ALTER TRIGGER TRG_TFP_ECC_CASHIER_BI FOR TFP_ECC_CASHIER
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.CASHIER_ROWID IS NULL OR NEW.CASHIER_ROWID <= 0) THEN
        NEW.CASHIER_ROWID = NEXT VALUE FOR GEN_TFP_ECC_CASHIER_ID;
    NEW.API_CODE = UPPER(TRIM(NEW.API_CODE));
END^

CREATE OR ALTER TRIGGER TRG_TFP_ECC_CASHIER_BU FOR TFP_ECC_CASHIER
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    NEW.API_CODE = UPPER(TRIM(NEW.API_CODE));
END^

CREATE OR ALTER TRIGGER TRG_TFP_ECC_TRANS_BI FOR TFP_ECC_TRANSACTION
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    NEW.TRANS_ID = LOWER(TRIM(NEW.TRANS_ID));
    NEW.API_CODE = UPPER(TRIM(NEW.API_CODE));
    IF (NEW.USERID IS NULL) THEN
        NEW.USERID = CAST(NULLIF(RDB$GET_CONTEXT('USER_SESSION', 'UserID'), '') AS INTEGER);
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
END^

CREATE OR ALTER TRIGGER TRG_TFP_ECC_TRANS_BU FOR TFP_ECC_TRANSACTION
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    /* un bon emis (2) nu mai poate redeveni nou / trimis / eroare */
    IF (OLD.STATE = 2 AND NEW.STATE IN (0, 1, 3)) THEN
        NEW.STATE = OLD.STATE;
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
END^

SET TERM ; ^

/* --- 7. Drepturi ---------------------------------------------------------- */
GRANT USAGE ON SEQUENCE GEN_TFP_ECC_CASHIER_ID TO TRIGGER TRG_TFP_ECC_CASHIER_BI;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TFP_ECC_CASHIER TO SWN;
GRANT USAGE ON SEQUENCE GEN_TFP_ECC_CASHIER_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TFP_ECC_TRANSACTION TO SWN;

COMMIT;

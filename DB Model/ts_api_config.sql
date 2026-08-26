/* ============================================================================
   TS_API_CONFIG - parametrii si credentialele API-urilor externe

   Inlocuieste credentialele hardcodate in codul Delphi. O linie = un parametru
   al unui API, identificat prin (API_CODE, PARAM_NAME):

       API_CODE = 'ULTRA_ESHOP'  ->  BASE_URL / USERNAME / PASSWORD
                                     (https://eshop.ultra.md/api, furnizor 202294)

   Citit din WMS de TfrmGoodsForeignCodeDlg.LoadUltraApiConfig
   (sources\classes\Goods\frmGoodsForeignCodeDialog.pas).

   Parolele se pastreaza in clar: aceleasi credentiale stau si in pipeline-ul
   python (ultra2_config.py), iar API-ul le cere in clar la /auth/token.
   Accesul se limiteaza prin drepturi pe tabela - NU se da GRANT lui WEBUSER.

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   Seed-ul NU suprascrie valorile existente (o parola schimbata ramane).
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TS_API_CONFIG')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TS_API_CONFIG (
             CONFIGID    INTEGER NOT NULL,
             API_CODE    VARCHAR(30) NOT NULL,
             PARAM_NAME  VARCHAR(50) NOT NULL,
             PARAM_VALUE VARCHAR(255),
             SUPPLIERID  INTEGER,
             FLG_ACTIVE  SMALLINT DEFAULT 1 NOT NULL,
             NOTE        VARCHAR(256),
             UPDATED_AT  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             UPDATED_BY  VARCHAR(64)
         )';
END^

/* --- 2. Coloane (pentru baze unde tabela exista deja) -------------------- */
EXECUTE BLOCK AS
DECLARE VARIABLE CNT INTEGER;
BEGIN
    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_API_CONFIG'
        AND TRIM(RDB$FIELD_NAME) = 'SUPPLIERID' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_API_CONFIG ADD SUPPLIERID INTEGER';

    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_API_CONFIG'
        AND TRIM(RDB$FIELD_NAME) = 'NOTE' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_API_CONFIG ADD NOTE VARCHAR(256)';

    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_API_CONFIG'
        AND TRIM(RDB$FIELD_NAME) = 'UPDATED_BY' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_API_CONFIG ADD UPDATED_BY VARCHAR(64)';
END^

/* --- 3. Cheia primara ---------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TS_API_CONFIG'
                     AND RDB$CONSTRAINT_TYPE = 'PRIMARY KEY')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_API_CONFIG ADD CONSTRAINT PK_TS_API_CONFIG PRIMARY KEY (CONFIGID)';
END^

/* --- 4. Indecsi ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UNQ_TS_API_CONFIG_PARAM')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UNQ_TS_API_CONFIG_PARAM ON TS_API_CONFIG (API_CODE, PARAM_NAME)';
END^

/* --- 5. Generator + triggere -------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$GENERATORS
                   WHERE TRIM(RDB$GENERATOR_NAME) = 'SQ_TS_API_CONFIG_ID')) THEN
        EXECUTE STATEMENT 'CREATE GENERATOR SQ_TS_API_CONFIG_ID';
END^

CREATE OR ALTER TRIGGER TS_API_CONFIG_BI FOR TS_API_CONFIG
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.CONFIGID IS NULL) THEN
        NEW.CONFIGID = GEN_ID(SQ_TS_API_CONFIG_ID, 1);
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
    IF (NEW.UPDATED_BY IS NULL) THEN
        NEW.UPDATED_BY = CURRENT_USER;
END^

CREATE OR ALTER TRIGGER TS_API_CONFIG_BU FOR TS_API_CONFIG
ACTIVE BEFORE UPDATE POSITION 0
AS
BEGIN
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
    IF (NEW.UPDATED_BY IS NULL OR NEW.UPDATED_BY = OLD.UPDATED_BY) THEN
        NEW.UPDATED_BY = CURRENT_USER;
END^

/* --- 6. Seed Ultra.md eShop (nu suprascrie valorile existente) ------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'ULTRA_ESHOP' AND PARAM_NAME = 'BASE_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ULTRA_ESHOP', 'BASE_URL', 'https://eshop.ultra.md/api', 202294,
                'Prefixul /api nu apare in documentatia v1.1', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'ULTRA_ESHOP' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ULTRA_ESHOP', 'USERNAME', 'duca@uno.md', 202294,
                'Acelasi cont ca pipeline-ul python ultra2_*', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'ULTRA_ESHOP' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('ULTRA_ESHOP', 'PASSWORD', 'Furnizor123', 202294, NULL, 'SYSTEM');
END^

/* --- 7. Seed SCOP / Triomac (nu suprascrie valorile existente) ------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'SCOP' AND PARAM_NAME = 'BASE_URL')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('SCOP', 'BASE_URL', 'https://api.scop.md', 209280,
                'Clientul adauga singur prefixul /api la cereri', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'SCOP' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('SCOP', 'USERNAME', 'marketing@fantastic.md', 209280,
                'Autentificarea SCOP se face pe e-mail', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'SCOP' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('SCOP', 'PASSWORD', 'Gama654!!', 209280, NULL, 'SYSTEM');
END^

/* --- 8. Seed DMLink (nu suprascrie valorile existente) --------------------
   DMLink nu se apeleaza prin HTTP din WMS, ci prin B2BDMLInk.dll (proiectul
   sources\b2b.api\dmlink\B2BDMLInkDLL.dproj); adresa serviciului este in DLL,
   deci nu exista BASE_URL. DLL_PATH e optional: fara cale, se cauta langa
   SWN.exe. */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'DMLINK' AND PARAM_NAME = 'USERNAME')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('DMLINK', 'USERNAME', 'duca.al@gmail.com', 229466,
                'Autentificarea DMLink se face pe e-mail', 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'DMLINK' AND PARAM_NAME = 'PASSWORD')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('DMLINK', 'PASSWORD', 'Uno2025!@', 229466, NULL, 'SYSTEM');

    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'DMLINK' AND PARAM_NAME = 'DLL_PATH')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, NOTE, UPDATED_BY)
        VALUES ('DMLINK', 'DLL_PATH', 'B2BDMLInk.dll', 229466,
                'Fara cale = se cauta in directorul SWN.exe', 'SYSTEM');
END^

SET TERM ; ^

COMMIT;

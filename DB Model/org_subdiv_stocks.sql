/* ============================================================================
   Organizatii -> subdiviziuni -> depozite + depozitele mobile ale curierilor
   Plan: Documents/plan-organizatii-depozite-mobile-2026-10-18.md
   Pe baza: Documents/plan-depozite-subdiviziuni-2026-10-02.md (pasii 1, 2, 5)
            Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md (9B, 9D)

   Structura:
     Organizatia      TS_CUSTOMER 4002 + TS_CUST_COMPANY.COMPANY_KIND = 1
      +- Subdiviziune TS_CUST_COMPANY.COMPANY_KIND = 2, PARENT_FIRMAID = organizatia
      |   +- depozitele ei   TS_STOCKS.FIRMAID = subdiviziunea, STOCK_KIND = 1
      +- depozitele mobile   TS_STOCKS.FIRMAID = organizatia,   STOCK_KIND = 2
          (masina curierului: TS_STOCK_VEHICLE; TS_COURIER.STOCKID -> depozit)

   Stocul ramane in TS_GOODS_STOCK (DT, DTDEP, GOODSID): intr-o masina comuna
   fiecare subdiviziune are soldul ei. Marfa subdiviziunii A se vinde de B numai
   dupa un transfer intre subdiviziuni (DT <> CT, acelasi depozit).

   Nou:
     TS_STOCKS          FIRMAID     proprietarul (NULL = comun / sistem)
                        CODE        codul depozitului in cadrul proprietarului
                        STOCK_KIND  1 stationar, 2 mobil (masina)
                        FLAGS bit 3 arhivat (nu primeste documente noi)
     TS_STOCKS_FIRM_MAP corespondenta depozit vechi -> depozit nou al firmei
     TS_STOCK_VEHICLE   datele masinii (1:1 cu depozitul mobil)
     FN_FIRM_ORG        organizatia unei firme proprii
     FN_STOCK_ALLOWED   regula: poate firma sa foloseasca depozitul?
     SP_STOCK_CHECK_DOC + triggerele pe TDB_DOCS / TDB_JURNAL care o aplica
                        documentelor datate >= 01.10.2026 (data de bascula).

   Efect imediat dupa rulare: niciunul. Toate depozitele existente au
   FIRMAID = NULL (comune), iar o firma fara depozite proprii poate folosi
   depozitele comune. Regula incepe sa lucreze cand se completeaza FIRMAID.

   Partenerii externi (CT/DT care nu e firma proprie) NU sint verificati aici;
   regula "partener extern -> depozit -1" din planul din 02.10 se activeaza
   separat, dupa ce dialogurile WMS nu mai pun depozitul implicit 43.

   Script RE-RULABIL. Firebird 5.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Coloane noi in TS_STOCKS ----------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TS_STOCKS' AND RDB$FIELD_NAME = 'FIRMAID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_STOCKS ADD FIRMAID INTEGER';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TS_STOCKS' AND RDB$FIELD_NAME = 'CODE')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_STOCKS ADD CODE VARCHAR(16)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TS_STOCKS' AND RDB$FIELD_NAME = 'STOCK_KIND')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_STOCKS ADD STOCK_KIND SMALLINT DEFAULT 1 NOT NULL';
END^

COMMIT WORK^

/* --- 2. Tabele noi ------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    /* corespondenta folosita la bascula, la implicite si la rapoartele care
       trec peste data de bascula (planul din 02.10, pasul 2) */
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_STOCKS_FIRM_MAP')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TS_STOCKS_FIRM_MAP (
             FIRMAID       INTEGER NOT NULL,
             OLD_STOCKID   INTEGER NOT NULL,
             NEW_STOCKID   INTEGER NOT NULL,
             DATA_BASCULA  DATE NOT NULL,
             UPDATED_AT    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             UPDATED_BY    INTEGER,
             CONSTRAINT PK_TS_STOCKS_FIRM_MAP PRIMARY KEY (FIRMAID, OLD_STOCKID),
             CONSTRAINT CHK_TS_STOCKS_FIRM_MAP CHECK (OLD_STOCKID <> NEW_STOCKID)
         )';

    /* masina = depozitul mobil; curierul care o conduce ramane in TS_COURIER.STOCKID */
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_STOCK_VEHICLE')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TS_STOCK_VEHICLE (
             STOCKID      INTEGER NOT NULL,
             PLATE_NO     VARCHAR(16),
             MODEL        VARCHAR(64),
             CAPACITY_KG  INTEGER,
             FLG_ACTIVE   SMALLINT DEFAULT 1 NOT NULL,
             NOTE         VARCHAR(512),
             UPDATED_AT   TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             UPDATED_BY   INTEGER,
             CONSTRAINT PK_TS_STOCK_VEHICLE PRIMARY KEY (STOCKID),
             CONSTRAINT CHK_TS_STOCK_VEHICLE_ACTIVE CHECK (FLG_ACTIVE IN (0, 1))
         )';
END^

COMMIT WORK^

/* --- 3. Constrangeri si indecsi ------------------------------------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE RDB$CONSTRAINT_NAME = 'CHK_TS_STOCKS_KIND')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_STOCKS ADD CONSTRAINT CHK_TS_STOCKS_KIND CHECK (STOCK_KIND IN (1, 2))';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TS_STOCKS_FIRMID')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TS_STOCKS_FIRMID ON TS_STOCKS (FIRMAID)';

    /* acelasi cod "01" poate exista la mai multe firme; NULL-urile nu se ciocnesc */
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'UNQ_TS_STOCKS_FIRM_CODE')) THEN
        EXECUTE STATEMENT 'CREATE UNIQUE INDEX UNQ_TS_STOCKS_FIRM_CODE ON TS_STOCKS (FIRMAID, CODE)';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TS_STOCKS_FIRM_MAP_NEW')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TS_STOCKS_FIRM_MAP_NEW ON TS_STOCKS_FIRM_MAP (NEW_STOCKID)';
END^

COMMIT WORK^

/* --- 4. Depozitele mobile existente -------------------------------------- */
/* masinile create de SP_COURIER_CREATE_STOCK stau in folderul 146 "Depozite
   mobile"; proprietarul (FIRMAID = organizatia) se completeaza de utilizator */
UPDATE TS_STOCKS SET STOCK_KIND = 2
WHERE PARENTID = 146 AND COALESCE(FLG_FOLDER, 0) = 0 AND STOCK_KIND <> 2^

COMMIT WORK^

/* --- 5. Exceptia --------------------------------------------------------- */
CREATE OR ALTER EXCEPTION ERR_STOCK_NOT_ALLOWED 'Depozitul nu poate fi folosit de aceasta firma'^

COMMIT WORK^

/* --- 6. Functii ---------------------------------------------------------- */

/* Organizatia (persoana juridica) unei firme proprii: subdiviziunea -> parintele,
   orice alta firma -> ea insasi (inclusiv cele fara fisa TS_CUST_COMPANY). */
CREATE OR ALTER FUNCTION FN_FIRM_ORG (
    A_FIRMID INTEGER)
RETURNS INTEGER
AS
DECLARE VARIABLE V_ORG INTEGER;
BEGIN
    IF (A_FIRMID IS NULL) THEN
        RETURN NULL;

    SELECT IIF(COMPANY_KIND = 2 AND PARENT_FIRMAID IS NOT NULL, PARENT_FIRMAID, CUSTOMERID)
    FROM TS_CUST_COMPANY
    WHERE CUSTOMERID = :A_FIRMID
    INTO :V_ORG;

    RETURN COALESCE(V_ORG, A_FIRMID);
END^

/* Poate firma A_FIRMID sa foloseasca depozitul A_STOCKID? 1 = da, 0 = nu.
     -1 / NULL                          -> da (fara depozit);
     depozit inexistent sau arhivat     -> nu;
     comun (FIRMAID NULL)               -> da, daca firma nu are depozite proprii
                                           (regula de tranzitie din planul din 02.10);
     mobil (STOCK_KIND 2)               -> da, daca e al organizatiei firmei;
     stationar (STOCK_KIND 1)           -> da, daca e chiar al firmei. */
CREATE OR ALTER FUNCTION FN_STOCK_ALLOWED (
    A_FIRMID INTEGER,
    A_STOCKID INTEGER)
RETURNS SMALLINT
AS
DECLARE VARIABLE V_OWNER INTEGER;
DECLARE VARIABLE V_KIND SMALLINT;
DECLARE VARIABLE V_FLAGS INTEGER;
DECLARE VARIABLE V_FOUND SMALLINT = 0;
BEGIN
    IF (A_STOCKID IS NULL OR A_STOCKID = -1 OR A_FIRMID IS NULL) THEN
        RETURN 1;

    SELECT FIRMAID, STOCK_KIND, COALESCE(FLAGS, 0), 1
    FROM TS_STOCKS
    WHERE STOCKID = :A_STOCKID
    INTO :V_OWNER, :V_KIND, :V_FLAGS, :V_FOUND;

    IF (V_FOUND = 0) THEN
        RETURN 0;

    IF (GET_FLG_VALUE(V_FLAGS, 3) = 1) THEN /* arhivat */
        RETURN 0;

    IF (V_OWNER IS NULL) THEN
        RETURN IIF(EXISTS(SELECT 1 FROM TS_STOCKS S
                          WHERE S.FIRMAID = :A_FIRMID AND S.STOCK_KIND = 1
                            AND COALESCE(S.FLG_FOLDER, 0) = 0
                            AND GET_FLG_VALUE(COALESCE(S.FLAGS, 0), 3) = 0), 0, 1);

    IF (V_KIND = 2) THEN
        RETURN IIF(V_OWNER = FN_FIRM_ORG(A_FIRMID), 1, 0);

    RETURN IIF(V_OWNER = A_FIRMID, 1, 0);
END^

COMMIT WORK^

/* --- 7. Verificarea documentelor ----------------------------------------- */

/* Verifica o pereche (firma, depozit) pe ambele laturi ale documentului.
   Se verifica doar latura unde firma e proprie (CUSTOMER_TYPE_ID = 4002).
   Documentele datate inainte de bascula nu se verifica (istoria ramane cum e). */
CREATE OR ALTER PROCEDURE SP_STOCK_CHECK_DOC (
    A_DATA TIMESTAMP,
    A_DT INTEGER,
    A_DTDEP INTEGER,
    A_CT INTEGER,
    A_CTDEP INTEGER)
AS
DECLARE VARIABLE C_BASCULA DATE = '2026-10-01';
DECLARE VARIABLE V_TYPE INTEGER;
BEGIN
    IF (A_DATA IS NOT NULL AND A_DATA < C_BASCULA) THEN
        EXIT;

    IF (A_DT IS NOT NULL AND COALESCE(A_DTDEP, -1) <> -1) THEN
    BEGIN
        V_TYPE = NULL;
        SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID = :A_DT INTO :V_TYPE;
        IF (V_TYPE = 4002 AND FN_STOCK_ALLOWED(A_DT, A_DTDEP) = 0) THEN
            EXCEPTION ERR_STOCK_NOT_ALLOWED
                'Depozitul ' || A_DTDEP || ' nu poate fi folosit de firma ' || A_DT;
    END

    IF (A_CT IS NOT NULL AND COALESCE(A_CTDEP, -1) <> -1) THEN
    BEGIN
        V_TYPE = NULL;
        SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID = :A_CT INTO :V_TYPE;
        IF (V_TYPE = 4002 AND FN_STOCK_ALLOWED(A_CT, A_CTDEP) = 0) THEN
            EXCEPTION ERR_STOCK_NOT_ALLOWED
                'Depozitul ' || A_CTDEP || ' nu poate fi folosit de firma ' || A_CT;
    END
END^

CREATE OR ALTER TRIGGER TRG_TDB_DOCS_STOCK_CHK FOR TDB_DOCS
ACTIVE BEFORE INSERT OR UPDATE POSITION 900
AS
BEGIN
    /* Verificam daca ne trebuie trigerii (bascula / migrarea ii opresc) */
    IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
        EXIT;

    IF (UPDATING) THEN
        IF ((NEW.DT IS NOT DISTINCT FROM OLD.DT) AND (NEW.CT IS NOT DISTINCT FROM OLD.CT) AND
            (NEW.DTDEP IS NOT DISTINCT FROM OLD.DTDEP) AND (NEW.CTDEP IS NOT DISTINCT FROM OLD.CTDEP) AND
            (NEW.DATA IS NOT DISTINCT FROM OLD.DATA)) THEN
            EXIT;

    EXECUTE PROCEDURE SP_STOCK_CHECK_DOC(NEW.DATA, NEW.DT, NEW.DTDEP, NEW.CT, NEW.CTDEP);
END^

/* liniile pot avea alt depozit decit antetul - se verifica fiecare */
CREATE OR ALTER TRIGGER TRG_TDB_JURNAL_STOCK_CHK FOR TDB_JURNAL
ACTIVE BEFORE INSERT OR UPDATE POSITION 900
AS
DECLARE VARIABLE V_DATA TIMESTAMP;
DECLARE VARIABLE V_DT INTEGER;
DECLARE VARIABLE V_CT INTEGER;
BEGIN
    IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
        EXIT;

    IF (UPDATING) THEN
        IF ((NEW.DOCID IS NOT DISTINCT FROM OLD.DOCID) AND
            (NEW.DTDEP IS NOT DISTINCT FROM OLD.DTDEP) AND
            (NEW.CTDEP IS NOT DISTINCT FROM OLD.CTDEP)) THEN
            EXIT;

    SELECT DATA, DT, CT FROM TDB_DOCS WHERE DOCID = NEW.DOCID
    INTO :V_DATA, :V_DT, :V_CT;

    EXECUTE PROCEDURE SP_STOCK_CHECK_DOC(:V_DATA, :V_DT, NEW.DTDEP, :V_CT, NEW.CTDEP);
END^

COMMIT WORK^

/* --- 8. Triggere: proprietarul depozitului si audit ---------------------- */

/* proprietarul trebuie sa fie firma proprie; depozitul mobil apartine
   organizatiei (nu unei subdiviziuni), ca sa-l poata folosi toate subdiviziunile */
CREATE OR ALTER TRIGGER TRG_TS_STOCKS_FIRM_BIU FOR TS_STOCKS
ACTIVE BEFORE INSERT OR UPDATE POSITION 10
AS
DECLARE VARIABLE V_TYPE INTEGER;
BEGIN
    IF (NEW.STOCK_KIND IS NULL) THEN
        NEW.STOCK_KIND = 1;

    IF (NEW.CODE IS NOT NULL) THEN
        NEW.CODE = NULLIF(TRIM(NEW.CODE), '');

    IF (NEW.FIRMAID IS NULL) THEN
        EXIT;

    IF (UPDATING) THEN
        IF ((NEW.FIRMAID IS NOT DISTINCT FROM OLD.FIRMAID) AND
            (NEW.STOCK_KIND IS NOT DISTINCT FROM OLD.STOCK_KIND)) THEN
            EXIT;

    SELECT CUSTOMER_TYPE_ID FROM TS_CUSTOMER WHERE CUSTOMERID = NEW.FIRMAID INTO :V_TYPE;
    IF (V_TYPE IS DISTINCT FROM 4002) THEN
        EXCEPTION ERR_STOCK_NOT_ALLOWED
            'Proprietarul depozitului trebuie sa fie o firma proprie (' || NEW.FIRMAID || ')';

    IF (NEW.STOCK_KIND = 2 AND FN_FIRM_ORG(NEW.FIRMAID) <> NEW.FIRMAID) THEN
        EXCEPTION ERR_STOCK_NOT_ALLOWED
            'Depozitul mobil apartine organizatiei, nu subdiviziunii (' || NEW.FIRMAID || ')';
END^

CREATE OR ALTER TRIGGER TRG_TS_STOCKS_FIRM_MAP_BIU FOR TS_STOCKS_FIRM_MAP
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
    NEW.UPDATED_BY = CAST(RDB$GET_CONTEXT('USER_SESSION', 'UserID') AS INTEGER);
END^

CREATE OR ALTER TRIGGER TRG_TS_STOCK_VEHICLE_BIU FOR TS_STOCK_VEHICLE
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TS_STOCKS WHERE STOCKID = NEW.STOCKID AND STOCK_KIND = 2)) THEN
        EXCEPTION ERR_STOCK_NOT_ALLOWED
            'Datele masinii se leaga doar de un depozit mobil (' || NEW.STOCKID || ')';

    NEW.PLATE_NO = UPPER(NULLIF(TRIM(NEW.PLATE_NO), ''));
    NEW.UPDATED_AT = CURRENT_TIMESTAMP;
    NEW.UPDATED_BY = CAST(RDB$GET_CONTEXT('USER_SESSION', 'UserID') AS INTEGER);
END^

COMMIT WORK^

/* --- 9. Chei straine (la final, ca tabelele sa existe deja) -------------- */
EXECUTE BLOCK AS
DECLARE VARIABLE FK_NAME VARCHAR(63);
DECLARE VARIABLE FK_SQL VARCHAR(512);
BEGIN
    FOR SELECT N, S FROM (
            SELECT 'FK_TS_STOCKS_FIRM' AS N, 'ALTER TABLE TS_STOCKS ADD CONSTRAINT FK_TS_STOCKS_FIRM FOREIGN KEY (FIRMAID) REFERENCES TS_CUSTOMER (CUSTOMERID)' AS S FROM RDB$DATABASE
  UNION ALL SELECT 'FK_TS_STOCKS_FIRM_MAP_FIRM', 'ALTER TABLE TS_STOCKS_FIRM_MAP ADD CONSTRAINT FK_TS_STOCKS_FIRM_MAP_FIRM FOREIGN KEY (FIRMAID) REFERENCES TS_CUSTOMER (CUSTOMERID)' FROM RDB$DATABASE
  UNION ALL SELECT 'FK_TS_STOCKS_FIRM_MAP_OLD', 'ALTER TABLE TS_STOCKS_FIRM_MAP ADD CONSTRAINT FK_TS_STOCKS_FIRM_MAP_OLD FOREIGN KEY (OLD_STOCKID) REFERENCES TS_STOCKS (STOCKID)' FROM RDB$DATABASE
  UNION ALL SELECT 'FK_TS_STOCKS_FIRM_MAP_NEW', 'ALTER TABLE TS_STOCKS_FIRM_MAP ADD CONSTRAINT FK_TS_STOCKS_FIRM_MAP_NEW FOREIGN KEY (NEW_STOCKID) REFERENCES TS_STOCKS (STOCKID)' FROM RDB$DATABASE
  UNION ALL SELECT 'FK_TS_STOCK_VEHICLE_STOCK', 'ALTER TABLE TS_STOCK_VEHICLE ADD CONSTRAINT FK_TS_STOCK_VEHICLE_STOCK FOREIGN KEY (STOCKID) REFERENCES TS_STOCKS (STOCKID) ON DELETE CASCADE' FROM RDB$DATABASE
        ) INTO :FK_NAME, :FK_SQL
    DO
        IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS WHERE RDB$CONSTRAINT_NAME = :FK_NAME)) THEN
            EXECUTE STATEMENT :FK_SQL;
END^

COMMIT WORK^

SET TERM ; ^

/* --- 10. Drepturi -------------------------------------------------------- */
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TS_STOCKS_FIRM_MAP TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TS_STOCK_VEHICLE TO SWN;
GRANT EXECUTE ON FUNCTION FN_FIRM_ORG TO PUBLIC;
GRANT EXECUTE ON FUNCTION FN_STOCK_ALLOWED TO PUBLIC;
GRANT EXECUTE ON PROCEDURE SP_STOCK_CHECK_DOC TO PUBLIC;
GRANT SELECT ON TS_CUST_COMPANY TO FUNCTION FN_FIRM_ORG;
GRANT SELECT ON TS_STOCKS TO FUNCTION FN_STOCK_ALLOWED;
GRANT SELECT ON TS_CUSTOMER TO PROCEDURE SP_STOCK_CHECK_DOC;
GRANT EXECUTE ON FUNCTION FN_STOCK_ALLOWED TO PROCEDURE SP_STOCK_CHECK_DOC;
GRANT EXECUTE ON FUNCTION FN_FIRM_ORG TO FUNCTION FN_STOCK_ALLOWED;
GRANT EXECUTE ON PROCEDURE SP_STOCK_CHECK_DOC TO TRIGGER TRG_TDB_DOCS_STOCK_CHK;
GRANT EXECUTE ON PROCEDURE SP_STOCK_CHECK_DOC TO TRIGGER TRG_TDB_JURNAL_STOCK_CHK;
GRANT SELECT ON TDB_DOCS TO TRIGGER TRG_TDB_JURNAL_STOCK_CHK;
GRANT SELECT ON TS_CUSTOMER TO TRIGGER TRG_TS_STOCKS_FIRM_BIU;
GRANT EXECUTE ON FUNCTION FN_FIRM_ORG TO TRIGGER TRG_TS_STOCKS_FIRM_BIU;
GRANT SELECT ON TS_STOCKS TO TRIGGER TRG_TS_STOCK_VEHICLE_BIU;

COMMIT WORK;

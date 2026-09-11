/* ============================================================================
   TS_GOODS_SERVICE - servicii adiacente produselor
   NEURON Grup SRL, septembrie 2026

   Leaga un SERVICIU din nomenclator (un rand TS_GOODS - de regula din mapa
   SERVICII, tip 323, UM "serviciu") de:
     - un TIP de produs (GOODSTYPEID): se aplica tuturor produselor cu
       TS_GOODS.WEBGOODSTYPE_ID = GOODSTYPEID
       (ex. "Set software" pentru laptopuri, PC, all-in-one);
     - un PRODUS concret (GOODSID): pret propriu sau anularea regulii de pe tip
       (ex. montaj dulap 1.5 m = 500 lei, dulap 2 m = 1200 lei).
   Exact unul dintre GOODSTYPEID / GOODSID e completat (CK_TS_GOODS_SERVICE_SCOPE).

   Rezolvare (SP_GET_GOODS_SERVICES) pentru un produs:
     - se iau regulile tipului lui si regulile lui proprii;
     - pentru acelasi serviciu, regula de pe PRODUS bate regula de pe TIP;
     - FLG_DISABLED = 1 pe produs ascunde serviciul mostenit de la tip.

   Pretul serviciului, in moneda ceruta (moneda documentului / comenzii):
     a) regula de produs cu PRICE sau PRICE_PERCENT completat isi defineste
        singura pretul; altfel pretul vine de pe regula de tip;
     b) PRICE (+ CURRENCYID, implicit MDL) daca e completat;
        altfel pretul standard al serviciului din TS_GOODS_PRICE, pe coloana de
        pret ceruta (1-4 -> PRICE1, 5 -> PRICE5, 6 -> PRICE6, ca in
        GET_GOODS_PRICE); coloana goala sau 0 -> PRICE1;
     c) + PRICE_PERCENT % din pretul produsului (parametrul GOODS_PRICE; daca
        e NULL, pretul produsului din TS_GOODS_PRICE pe aceeasi coloana);
     d) in MDL rezultatul se rotunjeste cu ROUND_MONEY, in valuta la 2 zecimale.

   In documente serviciul e o linie NORMALA TDB_JURNAL (ajunge in facturi,
   bonuri fiscale, rapoarte). Coloana noua TDB_JURNAL.SERVICE_FOR_GOODSID arata
   produsul caruia ii apartine linia de serviciu. GOODSCOMPLECT_ID NU se
   refoloseste: face parte din logica de complecte (triggere + ~150 proceduri).

   Script RE-RULABIL: nu sterge nimic si nu pierde date la a doua rulare.
   ATENTIE: sectiunea 7 (FK spre TS_GOODS / TS_GOODS_TYPE) poate esua cu
   "object in use" daca tabelele sunt folosite de alte conexiuni. In acest caz
   restul scriptului e deja aplicat; sectiunea 7 se reruleaza cand nu lucreaza
   nimeni.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ------------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TS_GOODS_SERVICE')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TS_GOODS_SERVICE (
             GSID             INTEGER NOT NULL,
             GOODSTYPEID      INTEGER,
             GOODSID          INTEGER,
             SERVICE_GOODSID  INTEGER NOT NULL,
             PRICE            NUMERIC(15,2),
             CURRENCYID       INTEGER,
             PRICE_PERCENT    NUMERIC(9,3),
             FLG_DEFAULT      SMALLINT DEFAULT 0,
             FLG_REQUIRED     SMALLINT DEFAULT 0,
             FLG_DISABLED     SMALLINT DEFAULT 0,
             ORDERNO          INTEGER DEFAULT 0,
             NOTE             VARCHAR(256),
             CREATED_BY       INTEGER,
             CREATED_DATE     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
             CONSTRAINT PK_TS_GOODS_SERVICE PRIMARY KEY (GSID),
             CONSTRAINT CK_TS_GOODS_SERVICE_SCOPE CHECK (
                 (GOODSTYPEID IS NOT NULL AND GOODSID IS NULL) OR
                 (GOODSTYPEID IS NULL AND GOODSID IS NOT NULL))
         )';
END^

COMMIT^

/* --- 2. Generator + triggere ----------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$GENERATORS
                   WHERE TRIM(RDB$GENERATOR_NAME) = 'SQ_TS_GOODS_SERVICE_ID')) THEN
        EXECUTE STATEMENT 'CREATE SEQUENCE SQ_TS_GOODS_SERVICE_ID';
END^

COMMIT^

CREATE OR ALTER TRIGGER TRG_TS_GOODS_SERVICE_BI FOR TS_GOODS_SERVICE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.GSID IS NULL) THEN
        NEW.GSID = NEXT VALUE FOR SQ_TS_GOODS_SERVICE_ID;
    IF (NEW.CREATED_BY IS NULL) THEN
        NEW.CREATED_BY = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    NEW.CREATED_DATE = CURRENT_TIMESTAMP;
END^

CREATE OR ALTER TRIGGER TRG_TS_GOODS_SERVICE_BIU FOR TS_GOODS_SERVICE
ACTIVE BEFORE INSERT OR UPDATE POSITION 1
AS
BEGIN
    NEW.FLG_DEFAULT  = COALESCE(NEW.FLG_DEFAULT, 0);
    NEW.FLG_REQUIRED = COALESCE(NEW.FLG_REQUIRED, 0);
    NEW.FLG_DISABLED = COALESCE(NEW.FLG_DISABLED, 0);
    NEW.ORDERNO      = COALESCE(NEW.ORDERNO, 0);

    /* un serviciu obligatoriu e mereu si bifat implicit */
    IF (NEW.FLG_REQUIRED = 1) THEN
        NEW.FLG_DEFAULT = 1;

    /* pret fara moneda = MDL */
    IF (NEW.PRICE IS NOT NULL AND NEW.CURRENCYID IS NULL) THEN
        NEW.CURRENCYID = 498;

    IF (NEW.GOODSID = NEW.SERVICE_GOODSID) THEN
        EXCEPTION ERR_GENERAL_ERROR '<MSG>Produsul nu poate fi propriul lui serviciu.</MSG>';

    IF (NEW.PRICE < 0 OR NEW.PRICE_PERCENT < 0) THEN
        EXCEPTION ERR_GENERAL_ERROR '<MSG>Pretul si procentul serviciului nu pot fi negative.</MSG>';
END^

/* --- 3. Indecsi unici (partiali, Firebird 5) -------------------------------
   Un serviciu apare o singura data pe un tip si o singura data pe un produs. */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TS_GOODS_SERVICE_TYPE')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TS_GOODS_SERVICE_TYPE ON TS_GOODS_SERVICE
             (GOODSTYPEID, SERVICE_GOODSID) WHERE GOODSTYPEID IS NOT NULL';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TS_GOODS_SERVICE_GOODS')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TS_GOODS_SERVICE_GOODS ON TS_GOODS_SERVICE
             (GOODSID, SERVICE_GOODSID) WHERE GOODSID IS NOT NULL';
END^

COMMIT^

/* --- 4. TDB_JURNAL: legatura linie de serviciu -> produs -------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_JURNAL'
                     AND TRIM(RDB$FIELD_NAME) = 'SERVICE_FOR_GOODSID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_JURNAL ADD SERVICE_FOR_GOODSID INTEGER';
END^

COMMIT^

/* --- 5. Procedura de rezolvare --------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_GET_GOODS_SERVICES (
    GOODSID      INTEGER,
    PRICE_COLUMN INTEGER,
    CURRENCYID   INTEGER,
    GOODS_PRICE  DOUBLE PRECISION)
RETURNS (
    SERVICE_GOODSID INTEGER,
    TITLE           TYPE OF COLUMN TS_GOODS.TITLE,
    UMID            INTEGER,
    VAT             INTEGER,
    PRICE           NUMERIC(18,2),
    FLG_DEFAULT     SMALLINT,
    FLG_REQUIRED    SMALLINT,
    ORDERNO         INTEGER,
    RULE_SOURCE     SMALLINT,   /* 1 = regula de pe tip, 2 = regula de pe produs */
    GSID            INTEGER)
AS
    DECLARE VARIABLE GTID    INTEGER;
    DECLARE VARIABLE PC      INTEGER;
    DECLARE VARIABLE BASE    DOUBLE PRECISION;
    DECLARE VARIABLE T_ID    INTEGER;
    DECLARE VARIABLE T_PRICE NUMERIC(15,2);
    DECLARE VARIABLE T_CUR   INTEGER;
    DECLARE VARIABLE T_PCT   NUMERIC(9,3);
    DECLARE VARIABLE T_DEF   SMALLINT;
    DECLARE VARIABLE T_REQ   SMALLINT;
    DECLARE VARIABLE T_DIS   SMALLINT;
    DECLARE VARIABLE T_ORD   INTEGER;
    DECLARE VARIABLE P_ID    INTEGER;
    DECLARE VARIABLE P_PRICE NUMERIC(15,2);
    DECLARE VARIABLE P_CUR   INTEGER;
    DECLARE VARIABLE P_PCT   NUMERIC(9,3);
    DECLARE VARIABLE P_DEF   SMALLINT;
    DECLARE VARIABLE P_REQ   SMALLINT;
    DECLARE VARIABLE P_DIS   SMALLINT;
    DECLARE VARIABLE P_ORD   INTEGER;
    DECLARE VARIABLE R_PRICE NUMERIC(15,2);
    DECLARE VARIABLE R_CUR   INTEGER;
    DECLARE VARIABLE R_PCT   NUMERIC(9,3);
    DECLARE VARIABLE AMOUNT  DOUBLE PRECISION;

    /* Pretul standard al unui articol din TS_GOODS_PRICE, convertit in ACUR.
       Maparea coloanelor copiaza GET_GOODS_PRICE: 5 -> PRICE5, 6 -> PRICE6,
       restul -> PRICE1. Coloana goala sau 0 cade pe PRICE1. */
    DECLARE FUNCTION STD_PRICE (AGOODSID INTEGER, APC INTEGER, ACUR INTEGER)
        RETURNS DOUBLE PRECISION
    AS
        DECLARE VARIABLE P  DOUBLE PRECISION;
        DECLARE VARIABLE C  INTEGER;
        DECLARE VARIABLE P1 DOUBLE PRECISION;
        DECLARE VARIABLE C1 INTEGER;
    BEGIN
        SELECT CASE :APC WHEN 5 THEN gp.PRICE5 WHEN 6 THEN gp.PRICE6 ELSE gp.PRICE1 END,
               CASE :APC WHEN 5 THEN gp.CURRENCY5ID WHEN 6 THEN gp.CURRENCY6ID ELSE gp.CURRENCY1ID END,
               gp.PRICE1, gp.CURRENCY1ID
          FROM TS_GOODS_PRICE gp
         WHERE gp.GOODSID = :AGOODSID
          INTO :P, :C, :P1, :C1;
        IF (COALESCE(P, 0) = 0) THEN
        BEGIN
            P = P1;
            C = C1;
        END
        IF (P IS NULL) THEN
            RETURN NULL;
        RETURN CONVERT_AMOUNT(P, COALESCE(C, 498), ACUR);
    END
BEGIN
    IF (CURRENCYID IS NULL) THEN
        CURRENCYID = 498;
    PC = COALESCE(PRICE_COLUMN, 1);
    BASE = GOODS_PRICE;

    SELECT g.WEBGOODSTYPE_ID FROM TS_GOODS g WHERE g.GOODSID = :GOODSID INTO :GTID;

    FOR SELECT DISTINCT s.SERVICE_GOODSID
          FROM TS_GOODS_SERVICE s
         WHERE s.GOODSID = :GOODSID OR s.GOODSTYPEID = :GTID
          INTO :SERVICE_GOODSID
    DO
    BEGIN
        /* SELECT ... INTO fara rezultat nu goleste variabilele -> reset manual */
        T_ID = NULL; T_PRICE = NULL; T_CUR = NULL; T_PCT = NULL;
        T_DEF = 0; T_REQ = 0; T_DIS = 0; T_ORD = 0;
        P_ID = NULL; P_PRICE = NULL; P_CUR = NULL; P_PCT = NULL;
        P_DEF = 0; P_REQ = 0; P_DIS = 0; P_ORD = 0;

        SELECT s.GSID, s.PRICE, s.CURRENCYID, s.PRICE_PERCENT,
               s.FLG_DEFAULT, s.FLG_REQUIRED, s.FLG_DISABLED, s.ORDERNO
          FROM TS_GOODS_SERVICE s
         WHERE s.GOODSTYPEID = :GTID AND s.SERVICE_GOODSID = :SERVICE_GOODSID
          INTO :T_ID, :T_PRICE, :T_CUR, :T_PCT, :T_DEF, :T_REQ, :T_DIS, :T_ORD;

        SELECT s.GSID, s.PRICE, s.CURRENCYID, s.PRICE_PERCENT,
               s.FLG_DEFAULT, s.FLG_REQUIRED, s.FLG_DISABLED, s.ORDERNO
          FROM TS_GOODS_SERVICE s
         WHERE s.GOODSID = :GOODSID AND s.SERVICE_GOODSID = :SERVICE_GOODSID
          INTO :P_ID, :P_PRICE, :P_CUR, :P_PCT, :P_DEF, :P_REQ, :P_DIS, :P_ORD;

        IF (P_ID IS NOT NULL) THEN
        BEGIN
            RULE_SOURCE = 2;
            GSID = P_ID;
            IF (P_DIS = 1) THEN
                CONTINUE;
            FLG_DEFAULT = P_DEF;
            FLG_REQUIRED = P_REQ;
            ORDERNO = P_ORD;
            IF (P_PRICE IS NOT NULL OR P_PCT IS NOT NULL) THEN
            BEGIN
                R_PRICE = P_PRICE;
                R_CUR = P_CUR;
                R_PCT = COALESCE(P_PCT, 0);
            END
            ELSE
            BEGIN
                R_PRICE = T_PRICE;
                R_CUR = T_CUR;
                R_PCT = COALESCE(T_PCT, 0);
            END
        END
        ELSE
        BEGIN
            RULE_SOURCE = 1;
            GSID = T_ID;
            IF (T_DIS = 1) THEN
                CONTINUE;
            FLG_DEFAULT = T_DEF;
            FLG_REQUIRED = T_REQ;
            ORDERNO = T_ORD;
            R_PRICE = T_PRICE;
            R_CUR = T_CUR;
            R_PCT = COALESCE(T_PCT, 0);
        END

        IF (R_PRICE IS NOT NULL) THEN
            AMOUNT = CONVERT_AMOUNT(R_PRICE, COALESCE(R_CUR, 498), CURRENCYID);
        ELSE
            AMOUNT = COALESCE(STD_PRICE(SERVICE_GOODSID, PC, CURRENCYID), 0);

        IF (R_PCT <> 0) THEN
        BEGIN
            IF (BASE IS NULL) THEN
                BASE = COALESCE(STD_PRICE(GOODSID, PC, CURRENCYID), 0);
            AMOUNT = AMOUNT + BASE * R_PCT / 100;
        END

        IF (CURRENCYID = 498) THEN
            PRICE = ROUND_MONEY(AMOUNT, 498);
        ELSE
            PRICE = ROUND(AMOUNT, 2);

        TITLE = NULL; UMID = NULL; VAT = NULL;
        SELECT g.TITLE, g.UMID, g.VAT FROM TS_GOODS g
         WHERE g.GOODSID = :SERVICE_GOODSID
          INTO :TITLE, :UMID, :VAT;

        SUSPEND;
    END
END^

SET TERM ; ^

COMMIT;

/* --- 6. Drepturi (acelasi model ca WEB_GOODS_PACHETE) ----------------------- */
GRANT SELECT ON TS_GOODS_SERVICE TO PROCEDURE SP_GET_GOODS_SERVICES;
GRANT SELECT ON TS_GOODS TO PROCEDURE SP_GET_GOODS_SERVICES;
GRANT SELECT ON TS_GOODS_PRICE TO PROCEDURE SP_GET_GOODS_SERVICES;
GRANT EXECUTE ON FUNCTION CONVERT_AMOUNT TO PROCEDURE SP_GET_GOODS_SERVICES;
GRANT EXECUTE ON FUNCTION ROUND_MONEY TO PROCEDURE SP_GET_GOODS_SERVICES;
GRANT USAGE ON SEQUENCE SQ_TS_GOODS_SERVICE_ID TO TRIGGER TRG_TS_GOODS_SERVICE_BI;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TS_GOODS_SERVICE TO SWN;
GRANT USAGE ON SEQUENCE SQ_TS_GOODS_SERVICE_ID TO SWN;
GRANT EXECUTE ON PROCEDURE SP_GET_GOODS_SERVICES TO SWN;

GRANT SELECT ON TS_GOODS_SERVICE TO WEBUSER;
GRANT EXECUTE ON PROCEDURE SP_GET_GOODS_SERVICES TO WEBUSER;

COMMIT;

/* --- 7. Chei straine (pot cere acces exclusiv - vezi antetul) -------------- */
SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'FK_TS_GOODS_SERVICE_TYPE')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_GOODS_SERVICE ADD CONSTRAINT FK_TS_GOODS_SERVICE_TYPE
             FOREIGN KEY (GOODSTYPEID) REFERENCES TS_GOODS_TYPE (GOODSTYPEID)
             ON DELETE CASCADE';
END^

COMMIT^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'FK_TS_GOODS_SERVICE_GOODS')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_GOODS_SERVICE ADD CONSTRAINT FK_TS_GOODS_SERVICE_GOODS
             FOREIGN KEY (GOODSID) REFERENCES TS_GOODS (GOODSID)
             ON DELETE CASCADE';
END^

COMMIT^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'FK_TS_GOODS_SERVICE_SVC')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_GOODS_SERVICE ADD CONSTRAINT FK_TS_GOODS_SERVICE_SVC
             FOREIGN KEY (SERVICE_GOODSID) REFERENCES TS_GOODS (GOODSID)
             ON DELETE CASCADE';
END^

COMMIT^

SET TERM ; ^

/* --- Verificare -------------------------------------------------------------
   SELECT * FROM SP_GET_GOODS_SERVICES(<GOODSID>, 1, 498, NULL)
    ORDER BY ORDERNO, TITLE;
   ---------------------------------------------------------------------------- */

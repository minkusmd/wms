/* ============================================================================
   POS (Point of Sale) - vinzari din magazin cu casa. Iteratia 1: SCHEMA.
   Frame WMS: frame133POSUnit (TS_DOCTYPES.TABSHEETINDEX = 133).
   Plan complet: Documents/pos-plan-2026-09-20.md

   Testat 20 sep 2026 pe o baza locala cu stub-uri (creare, re-rulare,
   constringeri, cascada, triggere de ID). Incluse: POS_FIND_GOODS(_EX), SP_POS_SHIFT_OPEN/_CLOSE/_SUMMARY,
   SP_POS_CASH_MOVE, SP_POS_CLOSE_SALE, SP_POS_REGISTER_RECEIPT.
   Urmeaza (faza 7): SP_POS_RETURN_SALE.
   ATENTIE: SP_POS_CLOSE_SALE a fost testata doar pe stub-uri locale, NU cu
   triggerele reale de pe TDB_DOCS / TDB_JURNAL / TDB_SN / TDB_PARTS.

   Principiu: cosul (bonul deschis / in asteptare) traieste in TPOS_SALE +
   TPOS_SALE_ITEM si NU atinge stocul. La incasare, SP_POS_CLOSE_SALE creeaza
   intr-o singura tranzactie lantul existent: Vinzare 107 -> Factura 112 ->
   incasari 116 (numerar) / 120 (card, QR) -> TDB_DOCS_RECEIPT.

   TPOS_TERMINAL      - casa: firma + statie de lucru + aparat fiscal + depozit
   TPOS_SHIFT         - tura casierului (o singura tura deschisa per casa)
   TPOS_CASH_MOVE     - intrari / iesiri de numerar in afara vinzarilor
   TPOS_SALE          - bonul POS. STATEID: 0 = deschis, 1 = in asteptare,
                        2 = incasat, 3 = anulat, 4 = returnat (total/partial)
   TPOS_SALE_ITEM     - liniile bonului pina la incasare (dupa = TDB_JURNAL)
   TPOS_SALE_PAYMENT  - platile bonului (plata mixta); PAY_CODE = codul stabil
                        din TS_SYSS.VALUE_STR (PAY_CASH, PAY_POS, PAY_QR_MIA)
                        + POS_VOUCHER, POS_CASHBACK

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Generatoare ------------------------------------------------------ */
EXECUTE BLOCK AS
    DECLARE G VARCHAR(63);
BEGIN
    FOR SELECT N FROM (
            SELECT 'GEN_TPOS_TERMINAL_ID' N FROM RDB$DATABASE UNION ALL
            SELECT 'GEN_TPOS_SHIFT_ID'      FROM RDB$DATABASE UNION ALL
            SELECT 'GEN_TPOS_CASH_MOVE_ID'  FROM RDB$DATABASE UNION ALL
            SELECT 'GEN_TPOS_SALE_ID'       FROM RDB$DATABASE UNION ALL
            SELECT 'GEN_TPOS_SALE_ITEM_ID'  FROM RDB$DATABASE UNION ALL
            SELECT 'GEN_TPOS_SALE_PAY_ID'   FROM RDB$DATABASE)
        INTO :G
    DO
        IF (NOT EXISTS(SELECT 1 FROM RDB$GENERATORS
                       WHERE TRIM(RDB$GENERATOR_NAME) = :G)) THEN
            EXECUTE STATEMENT 'CREATE SEQUENCE ' || :G;
END^

/* --- 1a. Exceptia modulului ----------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$EXCEPTIONS WHERE TRIM(RDB$EXCEPTION_NAME) = 'ERR_POS')) THEN
        EXECUTE STATEMENT 'CREATE EXCEPTION ERR_POS ''Eroare POS''';
END^

/* --- 2. Tabele ----------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_TERMINAL')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_TERMINAL (
             POS_ID             INTEGER NOT NULL,
             TITLE              VARCHAR(128) NOT NULL,
             FIRMA_ID           INTEGER NOT NULL,   /* TDB_DOCS.DT        */
             STOCKID            INTEGER NOT NULL,   /* TDB_DOCS.DTDEP     */
             WS_ID              INTEGER,            /* WS_WORK_STATIONS   */
             FP_ID              INTEGER,            /* FP_DEVICES         */
             DEFAULT_CUSTOMERID INTEGER NOT NULL,   /* clientul anonim    */
             PRICE_COLUMN       INTEGER DEFAULT 1 NOT NULL,
             MAX_DISCOUNT_P     SMALLINT DEFAULT 0 NOT NULL,
             FLG_ENABLED        SMALLINT DEFAULT 1 NOT NULL,
             CREATED_AT         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CONSTRAINT PK_TPOS_TERMINAL PRIMARY KEY (POS_ID),
             CONSTRAINT FK_TPOS_TERMINAL_FP FOREIGN KEY (FP_ID)
                 REFERENCES FP_DEVICES (FP_ID),
             CONSTRAINT FK_TPOS_TERMINAL_WS FOREIGN KEY (WS_ID)
                 REFERENCES WS_WORK_STATIONS (WS_ID))';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_SHIFT')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_SHIFT (
             SHIFT_ID        INTEGER NOT NULL,
             POS_ID          INTEGER NOT NULL,
             USERID          INTEGER NOT NULL,
             OPENED_AT       TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CLOSED_AT       TIMESTAMP,
             CLOSED_BY       INTEGER,
             OPEN_CASH       NUMERIC(15,2) DEFAULT 0 NOT NULL,
             EXPECTED_CASH   NUMERIC(15,2),   /* calculat la inchidere   */
             COUNTED_CASH    NUMERIC(15,2),   /* numarat de casier       */
             Z_NUMBER        INTEGER,         /* nr. raportului Z        */
             COMMENTS        VARCHAR(1024),
             CONSTRAINT PK_TPOS_SHIFT PRIMARY KEY (SHIFT_ID),
             CONSTRAINT FK_TPOS_SHIFT_POS FOREIGN KEY (POS_ID)
                 REFERENCES TPOS_TERMINAL (POS_ID))';
END^

/* o singura tura deschisa per casa (index partial - Firebird 5) */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'UQ_TPOS_SHIFT_OPEN')) THEN
        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TPOS_SHIFT_OPEN ON TPOS_SHIFT (POS_ID)
             WHERE CLOSED_AT IS NULL';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_CASH_MOVE')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_CASH_MOVE (
             MOVE_ID     INTEGER NOT NULL,
             SHIFT_ID    INTEGER NOT NULL,
             KIND        SMALLINT NOT NULL,       /* 1 = intrare, -1 = iesire */
             SUMA        NUMERIC(15,2) NOT NULL,
             REASON      VARCHAR(256),
             DOCID       INTEGER,                 /* 116 / 117, daca se genereaza */
             USERID      INTEGER NOT NULL,
             CREATED_AT  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CONSTRAINT PK_TPOS_CASH_MOVE PRIMARY KEY (MOVE_ID),
             CONSTRAINT FK_TPOS_CASH_MOVE_SHIFT FOREIGN KEY (SHIFT_ID)
                 REFERENCES TPOS_SHIFT (SHIFT_ID),
             CONSTRAINT CK_TPOS_CASH_MOVE_KIND CHECK (KIND IN (1, -1)),
             CONSTRAINT CK_TPOS_CASH_MOVE_SUMA CHECK (SUMA > 0))';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_SALE')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_SALE (
             SALE_ID           INTEGER NOT NULL,
             POS_ID            INTEGER NOT NULL,
             SHIFT_ID          INTEGER NOT NULL,
             STATEID           SMALLINT DEFAULT 0 NOT NULL,
             CUSTOMERID        INTEGER NOT NULL,
             SOURCE_DOCID      INTEGER,   /* document existent care se incaseaza */
             RASHOD_DOCID      INTEGER,   /* 107, completat la incasare          */
             FACTURA_DOCID     INTEGER,   /* 112, completat la incasare          */
             RETURN_OF_SALE_ID INTEGER,   /* bonul original, pentru retur        */
             TOTAL             NUMERIC(15,2) DEFAULT 0 NOT NULL,
             DISCOUNT_SUMA     NUMERIC(15,2) DEFAULT 0 NOT NULL,
             PROMO_CODE        VARCHAR(64),
             PARK_NOTE         VARCHAR(256),
             CREATED_BY        INTEGER NOT NULL,
             CREATED_AT        TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             PAID_AT           TIMESTAMP,
             CONSTRAINT PK_TPOS_SALE PRIMARY KEY (SALE_ID),
             CONSTRAINT FK_TPOS_SALE_POS FOREIGN KEY (POS_ID)
                 REFERENCES TPOS_TERMINAL (POS_ID),
             CONSTRAINT FK_TPOS_SALE_SHIFT FOREIGN KEY (SHIFT_ID)
                 REFERENCES TPOS_SHIFT (SHIFT_ID),
             CONSTRAINT FK_TPOS_SALE_RETURN FOREIGN KEY (RETURN_OF_SALE_ID)
                 REFERENCES TPOS_SALE (SALE_ID),
             CONSTRAINT CK_TPOS_SALE_STATE CHECK (STATEID BETWEEN 0 AND 4))';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_SALE_ITEM')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_SALE_ITEM (
             ITEM_ID             INTEGER NOT NULL,
             SALE_ID             INTEGER NOT NULL,
             ORDERNO             INTEGER DEFAULT 0 NOT NULL,
             GOODSID             INTEGER NOT NULL,
             QTY                 NUMERIC(15,3) DEFAULT 1 NOT NULL,
             PRICE               NUMERIC(15,2) NOT NULL,   /* MDL, cu TVA */
             DISCOUNT_P          SMALLINT DEFAULT 0 NOT NULL,
             DISCOUNT_SUMA       NUMERIC(15,2) DEFAULT 0 NOT NULL,
             SUMA                NUMERIC(15,2) NOT NULL,
             SN                  VARCHAR(128),             /* TS_GOODS.SERIAL_TYPE_ID = 4403 */
             SCANNED_CODE        VARCHAR(128),
             SERVICE_FOR_ITEM_ID INTEGER,                  /* servicii adiacente */
             CONSTRAINT PK_TPOS_SALE_ITEM PRIMARY KEY (ITEM_ID),
             CONSTRAINT FK_TPOS_SALE_ITEM_SALE FOREIGN KEY (SALE_ID)
                 REFERENCES TPOS_SALE (SALE_ID) ON DELETE CASCADE,
             CONSTRAINT CK_TPOS_SALE_ITEM_QTY CHECK (QTY > 0))';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TPOS_SALE_PAYMENT')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TPOS_SALE_PAYMENT (
             PAY_ID        INTEGER NOT NULL,
             SALE_ID       INTEGER NOT NULL,
             PAY_CODE      VARCHAR(32) NOT NULL,
             SUMA          NUMERIC(15,2) NOT NULL,  /* cit acopera din bon     */
             TENDERED      NUMERIC(15,2),           /* cit a dat clientul      */
             CHANGE_SUMA   NUMERIC(15,2) DEFAULT 0 NOT NULL,
             PRIHOD_DOCID  INTEGER,                 /* 116 sau 120             */
             EXT_REF       VARCHAR(128),            /* RRN / QRID / cod voucher */
             CREATED_AT    TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
             CONSTRAINT PK_TPOS_SALE_PAYMENT PRIMARY KEY (PAY_ID),
             CONSTRAINT FK_TPOS_SALE_PAYMENT_SALE FOREIGN KEY (SALE_ID)
                 REFERENCES TPOS_SALE (SALE_ID) ON DELETE CASCADE,
             CONSTRAINT CK_TPOS_SALE_PAYMENT_SUMA CHECK (SUMA <> 0))';
END^

/* --- 3. Indecsi ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TPOS_SALE_STATE')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TPOS_SALE_STATE ON TPOS_SALE (POS_ID, STATEID)';
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TPOS_SALE_RASHOD')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TPOS_SALE_RASHOD ON TPOS_SALE (RASHOD_DOCID)';

    /* cautarea dupa cod de bare: PK-ul TS_GOODS_BARCODE incepe cu GOODSID,
       deci nu ajuta la cautarea dupa BARCODE */
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TS_GOODS_BARCODE_BC')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TS_GOODS_BARCODE_BC ON TS_GOODS_BARCODE (BARCODE)';
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDEX_SEGMENTS S
                   JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
                   WHERE TRIM(I.RDB$RELATION_NAME) = 'TS_GOODS_FOREIGN'
                     AND TRIM(S.RDB$FIELD_NAME) = 'BARCODE'
                     AND S.RDB$FIELD_POSITION = 0)) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TS_GOODS_FOREIGN_BC ON TS_GOODS_FOREIGN (BARCODE)';
END^

/* --- 4. Ajustari la tabelele existente ----------------------------------- */
/* Bonul fiscal afla de tura, casa si bonul POS. Coloane nullable: fluxul
   clasic (frmReceiptPrintDialogV2 / SP_CREATE_RECEIPT3) ramine neschimbat. */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_DOCS_RECEIPT'
                     AND TRIM(RDB$FIELD_NAME) = 'SALE_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS_RECEIPT ADD SALE_ID INTEGER';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_DOCS_RECEIPT'
                     AND TRIM(RDB$FIELD_NAME) = 'SHIFT_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS_RECEIPT ADD SHIFT_ID INTEGER';
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TDB_DOCS_RECEIPT'
                     AND TRIM(RDB$FIELD_NAME) = 'FP_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS_RECEIPT ADD FP_ID INTEGER';
END^

/* NEINCLUS INTENTIONAT (decizie separata, vezi planul, sectiunea 3.3):
   TDB_DOCS_RECEIPT.NUMAR_BON este SMALLINT si face parte din PK
   (DOCID, NUMAR_BON). Azi maximul din baza e 999, deci limita de 32767 e
   doar latenta; cu un POS care emite multe bonuri pe zi poate deveni reala.
   Largirea la INTEGER cere recrearea PK-ului si a VW_DOCS_RECEIPT, deci
   merge intr-un script propriu, doar daca se decide. */

/* --- 5a. Cautarea produsului la casa -------------------------------------- */
/* Ordinea: cod de bare propriu -> cod de bare furnizor -> GOODSID -> cod exact
   -> denumire (toate cuvintele, doar produse cu stoc la casa).
   MATCH_KIND: 1, 2, 3, 4, 5. */
CREATE OR ALTER PROCEDURE POS_FIND_GOODS (
    ATEXT   VARCHAR(128),
    APOS_ID INTEGER)
RETURNS (
    GOODSID        INTEGER,
    TITLE          VARCHAR(1020),
    CODE           VARCHAR(255),
    SERIAL_TYPE_ID INTEGER,
    MATCH_KIND     SMALLINT)
AS
    DECLARE FIRMA_ID INTEGER;
    DECLARE STOCKID  INTEGER;
    DECLARE TXT      VARCHAR(130);
    DECLARE W        VARCHAR(130);
    DECLARE P        INTEGER;
    DECLARE COND     VARCHAR(4000);
    DECLARE NUM      INTEGER;
    DECLARE FOUND    SMALLINT;
BEGIN
    TXT = TRIM(COALESCE(:ATEXT, ''));
    IF (TXT = '') THEN EXIT;

    SELECT FIRMA_ID, STOCKID FROM TPOS_TERMINAL
    WHERE POS_ID = :APOS_ID
    INTO :FIRMA_ID, :STOCKID;
    IF (FIRMA_ID IS NULL) THEN EXIT;

    FOUND = 0;

    /* 1. cod de bare propriu */
    FOR SELECT G.GOODSID, G.TITLE, G.CODE, G.SERIAL_TYPE_ID
        FROM TS_GOODS_BARCODE B
        JOIN TS_GOODS G ON G.GOODSID = B.GOODSID
        WHERE B.BARCODE = :TXT AND G.FLG_FOLDER = 0
        INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID
    DO BEGIN MATCH_KIND = 1; FOUND = 1; SUSPEND; END

    /* 2. cod de bare al furnizorului */
    IF (FOUND = 0) THEN
        FOR SELECT DISTINCT G.GOODSID, G.TITLE, G.CODE, G.SERIAL_TYPE_ID
            FROM TS_GOODS_FOREIGN F
            JOIN TS_GOODS G ON G.GOODSID = F.GOODSID
            WHERE F.BARCODE = :TXT AND G.FLG_FOLDER = 0
            INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID
        DO BEGIN MATCH_KIND = 2; FOUND = 1; SUSPEND; END

    /* 3. GOODSID (etichete interne / cod tastat) */
    IF (FOUND = 0 AND TXT SIMILAR TO '[0-9]{1,9}') THEN
    BEGIN
        NUM = CAST(TXT AS INTEGER);
        FOR SELECT G.GOODSID, G.TITLE, G.CODE, G.SERIAL_TYPE_ID
            FROM TS_GOODS G
            WHERE G.GOODSID = :NUM AND G.FLG_FOLDER = 0
            INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID
        DO BEGIN MATCH_KIND = 3; FOUND = 1; SUSPEND; END
    END

    /* 4. cod exact */
    IF (FOUND = 0) THEN
        FOR SELECT FIRST 50 G.GOODSID, G.TITLE, G.CODE, G.SERIAL_TYPE_ID
            FROM TS_GOODS G
            WHERE UPPER(G.CODE) = UPPER(:TXT) AND G.FLG_FOLDER = 0
            INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID
        DO BEGIN MATCH_KIND = 4; FOUND = 1; SUSPEND; END

    /* 5. denumire / cod: toate cuvintele. Apostroful e scos din text, deci
          cuvintele pot fi lipite in SQL fara risc de injectie. */
    IF (FOUND = 0 AND CHAR_LENGTH(TXT) >= 3) THEN
    BEGIN
        COND = '';
        TXT = TRIM(REPLACE(TXT, '''', ' '));
        WHILE (TXT <> '') DO
        BEGIN
            P = POSITION(' ' IN TXT);
            IF (P = 0) THEN
            BEGIN
                W = TXT;
                TXT = '';
            END
            ELSE
            BEGIN
                W = SUBSTRING(TXT FROM 1 FOR P - 1);
                TXT = TRIM(SUBSTRING(TXT FROM P + 1));
            END
            IF (W <> '') THEN
                COND = COND || ' AND (G.TITLE CONTAINING ''' || W ||
                       ''' OR G.CODE CONTAINING ''' || W || ''')';
        END

        FOR EXECUTE STATEMENT
            'SELECT FIRST 50 G.GOODSID, G.TITLE, G.CODE, G.SERIAL_TYPE_ID
             FROM TS_GOODS G
             WHERE G.FLG_FOLDER = 0' || COND || '
               AND EXISTS(SELECT 1 FROM TS_GOODS_STOCK S
                          WHERE S.GOODSID = G.GOODSID AND S.DTDEP = ' || :STOCKID || '
                            AND S.DT = ' || :FIRMA_ID || ' AND S.QTY > 0)
             ORDER BY G.TITLE'
            INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID
        DO BEGIN MATCH_KIND = 5; SUSPEND; END
    END
END^

/* Acelasi rezultat + pretul (coloana casei, MDL) si stocul la casa. */
CREATE OR ALTER PROCEDURE POS_FIND_GOODS_EX (
    ATEXT   VARCHAR(128),
    APOS_ID INTEGER)
RETURNS (
    GOODSID        INTEGER,
    TITLE          VARCHAR(1020),
    CODE           VARCHAR(255),
    PRICE_MDL      NUMERIC(15,2),
    STOCK_QTY      NUMERIC(15,3),
    SERIAL_TYPE_ID INTEGER,
    MATCH_KIND     SMALLINT)
AS
    DECLARE FIRMA_ID     INTEGER;
    DECLARE STOCKID      INTEGER;
    DECLARE PRICE_COLUMN INTEGER;
BEGIN
    SELECT FIRMA_ID, STOCKID, PRICE_COLUMN FROM TPOS_TERMINAL
    WHERE POS_ID = :APOS_ID
    INTO :FIRMA_ID, :STOCKID, :PRICE_COLUMN;

    FOR SELECT F.GOODSID, F.TITLE, F.CODE, F.SERIAL_TYPE_ID, F.MATCH_KIND
        FROM POS_FIND_GOODS(:ATEXT, :APOS_ID) F
        INTO :GOODSID, :TITLE, :CODE, :SERIAL_TYPE_ID, :MATCH_KIND
    DO
    BEGIN
        PRICE_MDL = NULL;
        SELECT PRICE_MDL FROM GET_GOODS_PRICE(:GOODSID, :PRICE_COLUMN, 498)
        INTO :PRICE_MDL;

        SELECT COALESCE(SUM(S.QTY), 0) FROM TS_GOODS_STOCK S
        WHERE S.GOODSID = :GOODSID AND S.DTDEP = :STOCKID AND S.DT = :FIRMA_ID
        INTO :STOCK_QTY;

        SUSPEND;
    END
END^

/* --- 5b. Ture ------------------------------------------------------------- */
/* Numerarul asteptat in sertar = numerar la deschidere
                                  + platile PAY_CASH ale bonurilor incasate (SUMA = cit
                                    acopera din bon, restul e deja scazut; retururile
                                    sint plati negative)
                                  + intrari - iesiri din TPOS_CASH_MOVE. */
CREATE OR ALTER PROCEDURE SP_POS_SHIFT_SUMMARY (
    ASHIFT_ID INTEGER)
RETURNS (
    OPEN_CASH     NUMERIC(15,2),
    CASH_SALES    NUMERIC(15,2),
    CARD_SALES    NUMERIC(15,2),
    OTHER_SALES   NUMERIC(15,2),
    CASH_IN       NUMERIC(15,2),
    CASH_OUT      NUMERIC(15,2),
    EXPECTED_CASH NUMERIC(15,2),
    SALES_COUNT   INTEGER,
    OPEN_COUNT    INTEGER,
    PARKED_COUNT  INTEGER)
AS
BEGIN
    SELECT OPEN_CASH FROM TPOS_SHIFT WHERE SHIFT_ID = :ASHIFT_ID INTO :OPEN_CASH;
    IF (OPEN_CASH IS NULL) THEN
        EXCEPTION ERR_POS 'Tura ' || COALESCE(:ASHIFT_ID, 0) || ' nu exista.';

    SELECT COALESCE(SUM(IIF(P.PAY_CODE = 'PAY_CASH', P.SUMA, 0)), 0),
           COALESCE(SUM(IIF(P.PAY_CODE = 'PAY_POS', P.SUMA, 0)), 0),
           COALESCE(SUM(IIF(P.PAY_CODE NOT IN ('PAY_CASH', 'PAY_POS'), P.SUMA, 0)), 0)
    FROM TPOS_SALE S
    JOIN TPOS_SALE_PAYMENT P ON P.SALE_ID = S.SALE_ID
    WHERE S.SHIFT_ID = :ASHIFT_ID AND S.STATEID IN (2, 4)
    INTO :CASH_SALES, :CARD_SALES, :OTHER_SALES;

    SELECT COALESCE(SUM(IIF(KIND = 1, SUMA, 0)), 0),
           COALESCE(SUM(IIF(KIND = -1, SUMA, 0)), 0)
    FROM TPOS_CASH_MOVE
    WHERE SHIFT_ID = :ASHIFT_ID
    INTO :CASH_IN, :CASH_OUT;

    SELECT COALESCE(SUM(IIF(STATEID IN (2, 4), 1, 0)), 0),
           COALESCE(SUM(IIF(STATEID = 0, 1, 0)), 0),
           COALESCE(SUM(IIF(STATEID = 1, 1, 0)), 0)
    FROM TPOS_SALE
    WHERE SHIFT_ID = :ASHIFT_ID
    INTO :SALES_COUNT, :OPEN_COUNT, :PARKED_COUNT;

    EXPECTED_CASH = OPEN_CASH + CASH_SALES + CASH_IN - CASH_OUT;
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE SP_POS_SHIFT_OPEN (
    APOS_ID    INTEGER,
    AOPEN_CASH NUMERIC(15,2))
RETURNS (
    SHIFT_ID INTEGER)
AS
    DECLARE USERID INTEGER;
BEGIN
    USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    IF (USERID IS NULL) THEN
        EXCEPTION ERR_POS 'Utilizatorul curent nu este cunoscut (USER_SESSION.UserID).';
    IF (NOT EXISTS(SELECT 1 FROM TPOS_TERMINAL WHERE POS_ID = :APOS_ID AND FLG_ENABLED = 1)) THEN
        EXCEPTION ERR_POS 'Casa ' || COALESCE(:APOS_ID, 0) || ' nu exista sau este dezactivata.';
    IF (COALESCE(AOPEN_CASH, -1) < 0) THEN
        EXCEPTION ERR_POS 'Numerarul la deschidere nu poate fi negativ.';
    IF (EXISTS(SELECT 1 FROM TPOS_SHIFT WHERE POS_ID = :APOS_ID AND CLOSED_AT IS NULL)) THEN
        EXCEPTION ERR_POS 'Casa are deja o tura deschisa.';

    INSERT INTO TPOS_SHIFT (POS_ID, USERID, OPEN_CASH)
    VALUES (:APOS_ID, :USERID, :AOPEN_CASH)
    RETURNING SHIFT_ID INTO :SHIFT_ID;
    SUSPEND;
END^

CREATE OR ALTER PROCEDURE SP_POS_CASH_MOVE (
    ASHIFT_ID INTEGER,
    AKIND     SMALLINT,
    ASUMA     NUMERIC(15,2),
    AREASON   VARCHAR(256))
RETURNS (
    MOVE_ID INTEGER)
AS
    DECLARE USERID   INTEGER;
    DECLARE EXPECTED NUMERIC(15,2);
BEGIN
    USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    IF (USERID IS NULL) THEN
        EXCEPTION ERR_POS 'Utilizatorul curent nu este cunoscut (USER_SESSION.UserID).';
    IF (NOT EXISTS(SELECT 1 FROM TPOS_SHIFT WHERE SHIFT_ID = :ASHIFT_ID AND CLOSED_AT IS NULL)) THEN
        EXCEPTION ERR_POS 'Tura este inchisa - miscarile de numerar nu mai sint permise.';
    IF (AKIND NOT IN (1, -1)) THEN
        EXCEPTION ERR_POS 'Tip de miscare necunoscut.';
    IF (COALESCE(ASUMA, 0) <= 0) THEN
        EXCEPTION ERR_POS 'Suma trebuie sa fie mai mare ca zero.';
    IF (TRIM(COALESCE(AREASON, '')) = '') THEN
        EXCEPTION ERR_POS 'Indicati motivul miscarii de numerar.';

    IF (AKIND = -1) THEN
    BEGIN
        SELECT EXPECTED_CASH FROM SP_POS_SHIFT_SUMMARY(:ASHIFT_ID) INTO :EXPECTED;
        IF (ASUMA > EXPECTED) THEN
            EXCEPTION ERR_POS 'In sertar sint doar ' || :EXPECTED || ' lei.';
    END

    INSERT INTO TPOS_CASH_MOVE (SHIFT_ID, KIND, SUMA, REASON, USERID)
    VALUES (:ASHIFT_ID, :AKIND, :ASUMA, TRIM(:AREASON), :USERID)
    RETURNING MOVE_ID INTO :MOVE_ID;
    SUSPEND;
END^

/* Inchiderea se face DUPA raportul Z al aparatului; AZ_NUMBER = numarul lui. */
CREATE OR ALTER PROCEDURE SP_POS_SHIFT_CLOSE (
    ASHIFT_ID     INTEGER,
    ACOUNTED_CASH NUMERIC(15,2),
    AZ_NUMBER     INTEGER,
    ACOMMENTS     VARCHAR(1024))
RETURNS (
    EXPECTED_CASH NUMERIC(15,2),
    DIFF_CASH     NUMERIC(15,2))
AS
    DECLARE USERID     INTEGER;
    DECLARE OPEN_COUNT INTEGER;
BEGIN
    USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    IF (USERID IS NULL) THEN
        EXCEPTION ERR_POS 'Utilizatorul curent nu este cunoscut (USER_SESSION.UserID).';
    IF (NOT EXISTS(SELECT 1 FROM TPOS_SHIFT WHERE SHIFT_ID = :ASHIFT_ID AND CLOSED_AT IS NULL)) THEN
        EXCEPTION ERR_POS 'Tura este deja inchisa sau nu exista.';
    IF (COALESCE(ACOUNTED_CASH, -1) < 0) THEN
        EXCEPTION ERR_POS 'Introduceti numerarul numarat in sertar.';

    SELECT EXPECTED_CASH, OPEN_COUNT FROM SP_POS_SHIFT_SUMMARY(:ASHIFT_ID)
    INTO :EXPECTED_CASH, :OPEN_COUNT;
    IF (OPEN_COUNT > 0) THEN
        EXCEPTION ERR_POS 'Tura are ' || :OPEN_COUNT || ' bonuri deschise. Incasati-le sau anulati-le.';

    DIFF_CASH = ACOUNTED_CASH - EXPECTED_CASH;
    IF (DIFF_CASH <> 0 AND TRIM(COALESCE(ACOMMENTS, '')) = '') THEN
        EXCEPTION ERR_POS 'Diferenta de casa ' || :DIFF_CASH || ' lei: completati explicatia.';

    UPDATE TPOS_SHIFT
    SET CLOSED_AT = CURRENT_TIMESTAMP,
        CLOSED_BY = :USERID,
        EXPECTED_CASH = :EXPECTED_CASH,
        COUNTED_CASH = :ACOUNTED_CASH,
        Z_NUMBER = :AZ_NUMBER,
        COMMENTS = NULLIF(TRIM(COALESCE(:ACOMMENTS, '')), '')
    WHERE SHIFT_ID = :ASHIFT_ID;
    SUSPEND;
END^

/* --- 5c. Incasarea --------------------------------------------------------- */
/* Analitica de plata (TDB_DOCS.DTSC) dupa codul stabil din TS_SYSS.VALUE_STR. */
CREATE OR ALTER PROCEDURE POS_GET_PAY_ANALYTIC (
    APAY_CODE VARCHAR(32))
RETURNS (
    DTSC INTEGER)
AS
BEGIN
    DTSC = NULL;
    SELECT FIRST 1 SYSSID FROM TS_SYSS
    WHERE PARENTID = 26 AND VALUE_STR = :APAY_CODE
    INTO :DTSC;
    SUSPEND;
END^

/* Creeaza lantul de documente al bonului POS, in tranzactia apelantului:
     Vinzare 107 (+ linii, partide FIFO, seriale) -> Factura fiscala 112 ->
     cite o incasare per plata: 116 (PAY_CASH) sau 120 (PAY_POS, PAY_QR_MIA),
     cu parintele 107 si analitica din codul platii.
   NU scrie TDB_DOCS_RECEIPT si NU schimba starea bonului: apelantul tipareste
   bonul fiscal si abia apoi cheama SP_POS_REGISTER_RECEIPT + COMMIT. Daca
   tiparirea esueaza, apelantul face ROLLBACK si nu ramine nimic in baza.

   Liniile cu acelasi produs se cumuleaza intr-o linie de jurnal (cheia
   TDB_JURNAL nu permite acelasi produs de doua ori), deci trebuie sa aiba
   acelasi pret net. */
CREATE OR ALTER PROCEDURE SP_POS_CLOSE_SALE (
    ASALE_ID INTEGER)
RETURNS (
    RASHOD_DOCID  INTEGER,
    FACTURA_DOCID INTEGER)
AS
    DECLARE USERID        INTEGER;
    DECLARE POS_ID        INTEGER;
    DECLARE SHIFT_ID      INTEGER;
    DECLARE STATEID       SMALLINT;
    DECLARE CUSTOMERID    INTEGER;
    DECLARE FIRMA_ID      INTEGER;
    DECLARE STOCKID       INTEGER;
    DECLARE ITEMS_SUMA    NUMERIC(15,2);
    DECLARE PAY_SUMA      NUMERIC(15,2);
    DECLARE RATEUSD       DOUBLE PRECISION;
    DECLARE SC2           INTEGER;
    DECLARE DEF_DTSC      INTEGER;
    DECLARE MAIN_DTSC     INTEGER;
    DECLARE GOODSID       INTEGER;
    DECLARE QTY           NUMERIC(15,3);
    DECLARE SUMA          NUMERIC(15,2);
    DECLARE PRICE         NUMERIC(15,2);
    DECLARE UMID          INTEGER;
    DECLARE WARRANTY      INTEGER;
    DECLARE SERIAL_TYPE   INTEGER;
    DECLARE TITLE         VARCHAR(255);
    DECLARE SN_COUNT      INTEGER;
    DECLARE SN_FOUND      INTEGER;
    DECLARE SN_STOCK      VARCHAR(128);
    DECLARE SN            VARCHAR(128);
    DECLARE COUNTRYID     INTEGER;
    DECLARE VENDORID      INTEGER;
    DECLARE PARTNO        VARCHAR(128);
    DECLARE PART_QTY      NUMERIC(15,3);
    DECLARE LEFT_QTY      NUMERIC(15,3);
    DECLARE TAKE_QTY      NUMERIC(15,3);
    DECLARE PAY_ID        INTEGER;
    DECLARE PAY_CODE      VARCHAR(32);
    DECLARE PAY_DOCTYPE   INTEGER;
    DECLARE PAY_DTSC      INTEGER;
    DECLARE PAY_DOCID     INTEGER;
BEGIN
    USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    IF (USERID IS NULL) THEN
        EXCEPTION ERR_POS 'Utilizatorul curent nu este cunoscut (USER_SESSION.UserID).';

    SELECT S.POS_ID, S.SHIFT_ID, S.STATEID, S.CUSTOMERID, T.FIRMA_ID, T.STOCKID
    FROM TPOS_SALE S
    JOIN TPOS_TERMINAL T ON T.POS_ID = S.POS_ID
    WHERE S.SALE_ID = :ASALE_ID
    INTO :POS_ID, :SHIFT_ID, :STATEID, :CUSTOMERID, :FIRMA_ID, :STOCKID;

    IF (POS_ID IS NULL) THEN
        EXCEPTION ERR_POS 'Bonul ' || COALESCE(:ASALE_ID, 0) || ' nu exista.';
    IF (STATEID NOT IN (0, 1)) THEN
        EXCEPTION ERR_POS 'Bonul este deja incasat sau anulat.';
    IF (EXISTS(SELECT 1 FROM TPOS_SALE WHERE SALE_ID = :ASALE_ID AND RASHOD_DOCID IS NOT NULL)) THEN
        EXCEPTION ERR_POS 'Pentru acest bon documentele sint deja create.';
    IF (NOT EXISTS(SELECT 1 FROM TPOS_SHIFT WHERE SHIFT_ID = :SHIFT_ID AND CLOSED_AT IS NULL)) THEN
        EXCEPTION ERR_POS 'Tura bonului este inchisa.';

    SELECT COALESCE(SUM(SUMA), 0) FROM TPOS_SALE_ITEM WHERE SALE_ID = :ASALE_ID INTO :ITEMS_SUMA;
    SELECT COALESCE(SUM(SUMA), 0) FROM TPOS_SALE_PAYMENT WHERE SALE_ID = :ASALE_ID INTO :PAY_SUMA;
    IF (ITEMS_SUMA <= 0) THEN
        EXCEPTION ERR_POS 'Bonul este gol.';
    IF (ITEMS_SUMA <> PAY_SUMA) THEN
        EXCEPTION ERR_POS 'Platile (' || :PAY_SUMA || ') nu acopera exact bonul (' || :ITEMS_SUMA || ').';
    IF (EXISTS(SELECT 1 FROM TPOS_SALE_PAYMENT
               WHERE SALE_ID = :ASALE_ID AND PAY_CODE NOT IN ('PAY_CASH', 'PAY_POS', 'PAY_QR_MIA'))) THEN
        EXCEPTION ERR_POS 'Tip de plata neacceptat inca la casa (voucher / cashback = faza 5).';
    IF (EXISTS(SELECT 1 FROM TPOS_SALE_PAYMENT WHERE SALE_ID = :ASALE_ID AND SUMA <= 0)) THEN
        EXCEPTION ERR_POS 'Plata cu suma negativa sau zero.';

    /* documentele inlantuite se modifica in aceeasi tranzactie */
    RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

    SELECT TRANSFER_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :RATEUSD;
    SELECT SC, DTSC FROM TS_DOCTYPES_DEFVALUES
    WHERE DOCTYPEID = 107 AND FIRMA = :FIRMA_ID
    INTO :SC2, :DEF_DTSC;

    /* analitica vinzarii = cea a platii celei mai mari */
    SELECT FIRST 1 PAY_CODE FROM TPOS_SALE_PAYMENT
    WHERE SALE_ID = :ASALE_ID
    ORDER BY SUMA DESC, PAY_ID
    INTO :PAY_CODE;
    SELECT DTSC FROM POS_GET_PAY_ANALYTIC(:PAY_CODE) INTO :MAIN_DTSC;
    MAIN_DTSC = COALESCE(MAIN_DTSC, DEF_DTSC, -1);

    /* --- Vinzare 107 ------------------------------------------------------ */
    RASHOD_DOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;
    INSERT INTO TDB_DOCS (DOCID, DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, RATE, CREATED_BY,
                          DOCTYPEID, RATEUSD, SC2, FLAGS, RESPONSIBLE_USERID)
    VALUES (:RASHOD_DOCID, :FIRMA_ID, :CUSTOMERID, :STOCKID, -1, :MAIN_DTSC, 498, 1, :USERID,
            107, COALESCE(:RATEUSD, 1), COALESCE(:SC2, -1), SET_FLG_VALUE(0, 1, 1) /* FLG_ACNT */, :USERID);

    FOR SELECT I.GOODSID, SUM(I.QTY), SUM(I.SUMA), G.UMID, G.WARRANTY, G.SERIAL_TYPE_ID,
               CAST(SUBSTRING(G.TITLE FROM 1 FOR 255) AS VARCHAR(255)),
               SUM(IIF(TRIM(COALESCE(I.SN, '')) <> '', 1, 0))
        FROM TPOS_SALE_ITEM I
        JOIN TS_GOODS G ON G.GOODSID = I.GOODSID
        WHERE I.SALE_ID = :ASALE_ID
        GROUP BY I.GOODSID, G.UMID, G.WARRANTY, G.SERIAL_TYPE_ID, 7
        INTO :GOODSID, :QTY, :SUMA, :UMID, :WARRANTY, :SERIAL_TYPE, :TITLE, :SN_COUNT
    DO
    BEGIN
        PRICE = SUMA / QTY;
        IF (PRICE * QTY <> SUMA) THEN
            EXCEPTION ERR_POS 'Produsul "' || :TITLE || '" apare in bon cu preturi diferite sau suma nu se imparte exact la cantitate.';

        INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE,
                                WARRANTY, STOCK_QTY, FLAGS)
        VALUES (:RASHOD_DOCID, :STOCKID, -1, -1, :GOODSID, :QTY, :UMID, :PRICE,
                COALESCE(:WARRANTY, 0), 0, 1);

        /* seriale: cite unul per bucata, fiecare trebuie sa fie disponibil la depozitul casei */
        IF (SERIAL_TYPE = 4403) THEN
        BEGIN
            IF (SN_COUNT <> QTY) THEN
                EXCEPTION ERR_POS 'Produsul "' || :TITLE || '" se vinde cu numar de serie pe fiecare bucata.';
            FOR SELECT TRIM(I.SN) FROM TPOS_SALE_ITEM I
                WHERE I.SALE_ID = :ASALE_ID AND I.GOODSID = :GOODSID
                INTO :SN
            DO
            BEGIN
                SELECT COUNT(*), MAX(A.COUNTRYID), MAX(A.VENDORID), MAX(TRIM(A.SN))
                FROM GET_AVAILABLE_SN(:FIRMA_ID, :GOODSID) A
                WHERE A.STOCKID = :STOCKID AND UPPER(TRIM(A.SN)) = UPPER(:SN)
                INTO :SN_FOUND, :COUNTRYID, :VENDORID, :SN_STOCK;
                IF (SN_FOUND = 0) THEN
                    EXCEPTION ERR_POS 'Serialul ' || :SN || ' nu este disponibil la depozitul casei ("' || :TITLE || '").';
                /* in document se scrie serialul exact cum e in stoc, nu cum a fost tastat */
                SN = SN_STOCK;

                INSERT INTO TDB_SN (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMPLECT_SN,
                                    VENDORWARRANTY, OWNWARRANTY, CREATED_BY, SUMA_ACCIZE, COUNTRYID, VENDORID)
                VALUES (:RASHOD_DOCID, :STOCKID, -1, -1, :GOODSID, :SN, 'none',
                        COALESCE(:WARRANTY, 0), COALESCE(:WARRANTY, 0), :USERID, 0, :COUNTRYID, :VENDORID);
            END
            EXECUTE PROCEDURE UPDATE_JURNAL_FROM_SN(:RASHOD_DOCID, :STOCKID, -1, -1, :GOODSID);
        END

        /* partide: alocare automata, in ordinea intoarsa de GET_AVAILABLE_PARTS */
        IF (SERIAL_TYPE = 4402) THEN
        BEGIN
            LEFT_QTY = QTY;
            FOR SELECT A.PARTNO, A.QTY, A.COUNTRYID, A.VENDORID
                FROM GET_AVAILABLE_PARTS(:FIRMA_ID, :GOODSID) A
                WHERE A.STOCKID = :STOCKID AND A.QTY > 0
                INTO :PARTNO, :PART_QTY, :COUNTRYID, :VENDORID
            DO
            BEGIN
                IF (LEFT_QTY > 0) THEN
                BEGIN
                    TAKE_QTY = MINVALUE(LEFT_QTY, PART_QTY);
                    INSERT INTO TDB_PARTS (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, PARTNO, COMPLECT_SN,
                                           VENDORWARRANTY, OWNWARRANTY, QTY, CREATED_BY, SUMA_ACCIZE,
                                           COUNTRYID, VENDORID)
                    VALUES (:RASHOD_DOCID, :STOCKID, -1, -1, :GOODSID, :PARTNO, 'none',
                            COALESCE(:WARRANTY, 0), COALESCE(:WARRANTY, 0), :TAKE_QTY, :USERID, 0,
                            :COUNTRYID, :VENDORID);
                    LEFT_QTY = LEFT_QTY - TAKE_QTY;
                END
            END
            IF (LEFT_QTY > 0) THEN
                EXCEPTION ERR_POS 'Partide insuficiente la depozitul casei pentru "' || :TITLE || '": lipsesc ' || :LEFT_QTY || '.';
            EXECUTE PROCEDURE UPDATE_JURNAL_FROM_PARTS(:RASHOD_DOCID, :STOCKID, -1, -1, :GOODSID);
        END
    END

    /* --- Factura fiscala 112 (ca in SP_CREATE_RECEIPT3) -------------------- */
    INSERT INTO TDB_DOCS (DT, CT, DTDEP, CTDEP, DTSC, SUMA, CURRENCYID, RATE, PARENTDOCID,
                          DOCTYPEID, FLAGS, RATEUSD)
    SELECT DT, CT, DTDEP, CTDEP, DTSC, SUMA, 498, RATE, :RASHOD_DOCID,
           112, SET_FLG_VALUE(FLAGS, 1, 1), RATEUSD
    FROM TDB_DOCS
    WHERE DOCID = :RASHOD_DOCID
    RETURNING DOCID INTO :FACTURA_DOCID;

    INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE,
                            WARRANTY, STOCK_QTY, COST, FLAGS)
    SELECT :FACTURA_DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE,
           WARRANTY, STOCK_QTY, COST, FLAGS
    FROM TDB_JURNAL
    WHERE DOCID = :RASHOD_DOCID;

    /* --- Incasarile: una per plata ----------------------------------------- */
    FOR SELECT P.PAY_ID, P.PAY_CODE, P.SUMA
        FROM TPOS_SALE_PAYMENT P
        WHERE P.SALE_ID = :ASALE_ID
        ORDER BY P.PAY_ID
        INTO :PAY_ID, :PAY_CODE, :SUMA
    DO
    BEGIN
        PAY_DOCTYPE = IIF(PAY_CODE = 'PAY_CASH', 116, 120);
        SELECT DTSC FROM POS_GET_PAY_ANALYTIC(:PAY_CODE) INTO :PAY_DTSC;

        INSERT INTO TDB_DOCS (DT, CT, DTSC, SUMA, CURRENCYID, RATE, PARENTDOCID, DOCTYPEID, FLAGS, RATEUSD)
        SELECT DT, CT, COALESCE(:PAY_DTSC, DTSC), :SUMA, 498, RATE, :RASHOD_DOCID, :PAY_DOCTYPE,
               SET_FLG_VALUE(2, 10, 1) /* FLG_ACNT + FLG_CLOSED */, RATEUSD
        FROM TDB_DOCS
        WHERE DOCID = :RASHOD_DOCID
        RETURNING DOCID INTO :PAY_DOCID;

        UPDATE TPOS_SALE_PAYMENT SET PRIHOD_DOCID = :PAY_DOCID WHERE PAY_ID = :PAY_ID;
    END

    UPDATE TPOS_SALE
    SET RASHOD_DOCID = :RASHOD_DOCID,
        FACTURA_DOCID = :FACTURA_DOCID,
        TOTAL = :ITEMS_SUMA,
        DISCOUNT_SUMA = (SELECT COALESCE(SUM(DISCOUNT_SUMA), 0) FROM TPOS_SALE_ITEM WHERE SALE_ID = :ASALE_ID)
    WHERE SALE_ID = :ASALE_ID;

    SUSPEND;
END^

/* Dupa ce aparatul fiscal a inchis bonul: leaga bonul de factura fiscala 112
   (TDB_DOCS_RECEIPT.DOCID = factura) si marcheaza bonul POS ca incasat. */
CREATE OR ALTER PROCEDURE SP_POS_REGISTER_RECEIPT (
    ASALE_ID             INTEGER,
    ANUMAR_BON           INTEGER,
    ADATA_ELIBERARII     TIMESTAMP,
    AFLG_PERSOANA_JURIDICA SMALLINT)
AS
    DECLARE USERID        INTEGER;
    DECLARE FACTURA_DOCID INTEGER;
    DECLARE RASHOD_DOCID  INTEGER;
    DECLARE SHIFT_ID      INTEGER;
    DECLARE FP_ID         INTEGER;
    DECLARE TOTAL         NUMERIC(15,2);
    DECLARE STATEID       SMALLINT;
    DECLARE MAIN_PRIHOD   INTEGER;
    DECLARE HAS_CASH      SMALLINT;
    DECLARE TMPFLAGS      INTEGER;
    DECLARE PAY_DOCID     INTEGER;
    DECLARE TXT           VARCHAR(32);
BEGIN
    USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    IF (USERID IS NULL) THEN
        EXCEPTION ERR_POS 'Utilizatorul curent nu este cunoscut (USER_SESSION.UserID).';

    SELECT S.FACTURA_DOCID, S.RASHOD_DOCID, S.SHIFT_ID, S.TOTAL, S.STATEID, T.FP_ID
    FROM TPOS_SALE S
    JOIN TPOS_TERMINAL T ON T.POS_ID = S.POS_ID
    WHERE S.SALE_ID = :ASALE_ID
    INTO :FACTURA_DOCID, :RASHOD_DOCID, :SHIFT_ID, :TOTAL, :STATEID, :FP_ID;

    IF (FACTURA_DOCID IS NULL) THEN
        EXCEPTION ERR_POS 'Pentru bonul ' || COALESCE(:ASALE_ID, 0) || ' nu sint create documentele.';
    IF (STATEID NOT IN (0, 1)) THEN
        EXCEPTION ERR_POS 'Bonul este deja inregistrat.';
    IF (COALESCE(ANUMAR_BON, 0) <= 0 OR ANUMAR_BON > 32767) THEN
        EXCEPTION ERR_POS 'Numar de bon fiscal invalid: ' || COALESCE(:ANUMAR_BON, 0) || '.';

    RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

    SELECT FIRST 1 PRIHOD_DOCID FROM TPOS_SALE_PAYMENT
    WHERE SALE_ID = :ASALE_ID
    ORDER BY SUMA DESC, PAY_ID
    INTO :MAIN_PRIHOD;
    HAS_CASH = IIF(EXISTS(SELECT 1 FROM TPOS_SALE_PAYMENT
                          WHERE SALE_ID = :ASALE_ID AND PAY_CODE = 'PAY_CASH'), 1, 0);

    TMPFLAGS = 0;
    TMPFLAGS = SET_FLG_VALUE(:TMPFLAGS, 0, COALESCE(:AFLG_PERSOANA_JURIDICA, 0));
    TMPFLAGS = SET_FLG_VALUE(:TMPFLAGS, 2, :HAS_CASH);

    INSERT INTO TDB_DOCS_RECEIPT (DOCID, NUMAR_BON, FLAGS, DATA_ELIBERARII, USERID, SUMA, PRIHOD_DOCID,
                                  SALE_ID, SHIFT_ID, FP_ID)
    VALUES (:FACTURA_DOCID, :ANUMAR_BON, :TMPFLAGS, :ADATA_ELIBERARII, :USERID, :TOTAL, :MAIN_PRIHOD,
            :ASALE_ID, :SHIFT_ID, :FP_ID);

    TXT = EXTRACT(DAY FROM :ADATA_ELIBERARII) || '.' || EXTRACT(MONTH FROM :ADATA_ELIBERARII) || '.' ||
          EXTRACT(YEAR FROM :ADATA_ELIBERARII);
    FOR SELECT PRIHOD_DOCID FROM TPOS_SALE_PAYMENT
        WHERE SALE_ID = :ASALE_ID AND PRIHOD_DOCID IS NOT NULL
        INTO :PAY_DOCID
    DO
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:PAY_DOCID, 'SYSTEM',
            'POS: bon fiscal Nr.' || :ANUMAR_BON || ' din ' || :TXT || ', total bon=' || :TOTAL || ' lei.');

    UPDATE TPOS_SALE
    SET STATEID = 2, PAID_AT = CURRENT_TIMESTAMP
    WHERE SALE_ID = :ASALE_ID;
END^

/* --- 5. Triggere de ID --------------------------------------------------- */
CREATE OR ALTER TRIGGER TRG_TPOS_TERMINAL_BI FOR TPOS_TERMINAL
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.POS_ID IS NULL OR NEW.POS_ID <= 0) THEN
        NEW.POS_ID = NEXT VALUE FOR GEN_TPOS_TERMINAL_ID;
END^

CREATE OR ALTER TRIGGER TRG_TPOS_SHIFT_BI FOR TPOS_SHIFT
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.SHIFT_ID IS NULL OR NEW.SHIFT_ID <= 0) THEN
        NEW.SHIFT_ID = NEXT VALUE FOR GEN_TPOS_SHIFT_ID;
END^

CREATE OR ALTER TRIGGER TRG_TPOS_CASH_MOVE_BI FOR TPOS_CASH_MOVE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.MOVE_ID IS NULL OR NEW.MOVE_ID <= 0) THEN
        NEW.MOVE_ID = NEXT VALUE FOR GEN_TPOS_CASH_MOVE_ID;
END^

CREATE OR ALTER TRIGGER TRG_TPOS_SALE_BI FOR TPOS_SALE
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.SALE_ID IS NULL OR NEW.SALE_ID <= 0) THEN
        NEW.SALE_ID = NEXT VALUE FOR GEN_TPOS_SALE_ID;
END^

CREATE OR ALTER TRIGGER TRG_TPOS_SALE_ITEM_BI FOR TPOS_SALE_ITEM
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.ITEM_ID IS NULL OR NEW.ITEM_ID <= 0) THEN
        NEW.ITEM_ID = NEXT VALUE FOR GEN_TPOS_SALE_ITEM_ID;
END^

CREATE OR ALTER TRIGGER TRG_TPOS_SALE_PAYMENT_BI FOR TPOS_SALE_PAYMENT
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.PAY_ID IS NULL OR NEW.PAY_ID <= 0) THEN
        NEW.PAY_ID = NEXT VALUE FOR GEN_TPOS_SALE_PAY_ID;
END^

SET TERM ; ^

COMMIT;

/* --- 6. Drepturi --------------------------------------------------------- */
GRANT USAGE ON SEQUENCE GEN_TPOS_TERMINAL_ID TO TRIGGER TRG_TPOS_TERMINAL_BI;
GRANT USAGE ON SEQUENCE GEN_TPOS_SHIFT_ID TO TRIGGER TRG_TPOS_SHIFT_BI;
GRANT USAGE ON SEQUENCE GEN_TPOS_CASH_MOVE_ID TO TRIGGER TRG_TPOS_CASH_MOVE_BI;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_ID TO TRIGGER TRG_TPOS_SALE_BI;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_ITEM_ID TO TRIGGER TRG_TPOS_SALE_ITEM_BI;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_PAY_ID TO TRIGGER TRG_TPOS_SALE_PAYMENT_BI;
GRANT SELECT ON TPOS_TERMINAL TO PROCEDURE POS_FIND_GOODS;
GRANT SELECT ON TS_GOODS TO PROCEDURE POS_FIND_GOODS;
GRANT SELECT ON TS_GOODS_BARCODE TO PROCEDURE POS_FIND_GOODS;
GRANT SELECT ON TS_GOODS_FOREIGN TO PROCEDURE POS_FIND_GOODS;
GRANT SELECT ON TS_GOODS_STOCK TO PROCEDURE POS_FIND_GOODS;
GRANT SELECT ON TPOS_TERMINAL TO PROCEDURE POS_FIND_GOODS_EX;
GRANT SELECT ON TS_GOODS_STOCK TO PROCEDURE POS_FIND_GOODS_EX;
GRANT EXECUTE ON PROCEDURE POS_FIND_GOODS TO PROCEDURE POS_FIND_GOODS_EX;
GRANT EXECUTE ON PROCEDURE GET_GOODS_PRICE TO PROCEDURE POS_FIND_GOODS_EX;
GRANT EXECUTE ON PROCEDURE POS_FIND_GOODS TO SWN;
GRANT EXECUTE ON PROCEDURE POS_FIND_GOODS_EX TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_SHIFT_SUMMARY TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_SHIFT_OPEN TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_CASH_MOVE TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_SHIFT_CLOSE TO SWN;
GRANT SELECT ON TPOS_SHIFT TO PROCEDURE SP_POS_SHIFT_SUMMARY;
GRANT SELECT ON TPOS_SALE TO PROCEDURE SP_POS_SHIFT_SUMMARY;
GRANT SELECT ON TPOS_SALE_PAYMENT TO PROCEDURE SP_POS_SHIFT_SUMMARY;
GRANT SELECT ON TPOS_CASH_MOVE TO PROCEDURE SP_POS_SHIFT_SUMMARY;
GRANT SELECT ON TPOS_TERMINAL TO PROCEDURE SP_POS_SHIFT_OPEN;
GRANT SELECT, INSERT ON TPOS_SHIFT TO PROCEDURE SP_POS_SHIFT_OPEN;
GRANT SELECT ON TPOS_SHIFT TO PROCEDURE SP_POS_CASH_MOVE;
GRANT SELECT, INSERT ON TPOS_CASH_MOVE TO PROCEDURE SP_POS_CASH_MOVE;
GRANT EXECUTE ON PROCEDURE SP_POS_SHIFT_SUMMARY TO PROCEDURE SP_POS_CASH_MOVE;
GRANT SELECT, UPDATE ON TPOS_SHIFT TO PROCEDURE SP_POS_SHIFT_CLOSE;
GRANT EXECUTE ON PROCEDURE SP_POS_SHIFT_SUMMARY TO PROCEDURE SP_POS_SHIFT_CLOSE;
GRANT EXECUTE ON PROCEDURE POS_GET_PAY_ANALYTIC TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_CLOSE_SALE TO SWN;
GRANT EXECUTE ON PROCEDURE SP_POS_REGISTER_RECEIPT TO SWN;
GRANT SELECT ON TS_SYSS TO PROCEDURE POS_GET_PAY_ANALYTIC;
GRANT EXECUTE ON PROCEDURE POS_GET_PAY_ANALYTIC TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TPOS_TERMINAL TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TPOS_SHIFT TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, UPDATE ON TPOS_SALE TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TPOS_SALE_ITEM TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, UPDATE ON TPOS_SALE_PAYMENT TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TS_GOODS TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TS_CURRENCY TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TS_DOCTYPES_DEFVALUES TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, INSERT ON TDB_DOCS TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, INSERT ON TDB_JURNAL TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, INSERT ON TDB_SN TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT, INSERT ON TDB_PARTS TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT USAGE ON SEQUENCE SQ_TDB_DOCS_DOCID TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT EXECUTE ON PROCEDURE GET_AVAILABLE_SN TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT EXECUTE ON PROCEDURE GET_AVAILABLE_PARTS TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT EXECUTE ON PROCEDURE UPDATE_JURNAL_FROM_SN TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT EXECUTE ON PROCEDURE UPDATE_JURNAL_FROM_PARTS TO PROCEDURE SP_POS_CLOSE_SALE;
GRANT SELECT ON TPOS_TERMINAL TO PROCEDURE SP_POS_REGISTER_RECEIPT;
GRANT SELECT, UPDATE ON TPOS_SALE TO PROCEDURE SP_POS_REGISTER_RECEIPT;
GRANT SELECT ON TPOS_SALE_PAYMENT TO PROCEDURE SP_POS_REGISTER_RECEIPT;
GRANT SELECT, INSERT ON TDB_DOCS_RECEIPT TO PROCEDURE SP_POS_REGISTER_RECEIPT;
GRANT EXECUTE ON PROCEDURE SP_ADD_DOC_COMMENTS TO PROCEDURE SP_POS_REGISTER_RECEIPT;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_TERMINAL TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_TERMINAL_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_SHIFT TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_SHIFT_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_CASH_MOVE TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_CASH_MOVE_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_SALE TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_SALE_ITEM TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_ITEM_ID TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON TPOS_SALE_PAYMENT TO SWN;
GRANT USAGE ON SEQUENCE GEN_TPOS_SALE_PAY_ID TO SWN;

COMMIT;

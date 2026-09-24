/* ============================================================================
   Datele comenzii web in TDB_DEALS, in campuri separate - 23 sep 2026

   La crearea unei comenzi web (cos: WEB_CREATE_TRANSACTION3, plata cu cardul:
   WEB_CREATE_TRANSACTION2_ECOMM, "1 click": WEB_CREATE_TRANSACTION_PHONE2) se scriu
   in deal-ul comenzii:
     CONTACT_NAME, PHONE, DELIVERY_ADDRESS, DELIVERY_NOTE  (coloane existente)
     PAYMENT_METHOD                                         (coloana noua)
     UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM (coloane noi)

   Cum:
     - deal-ul se creeaza deja la INSERT in TDB_DOCS (trigger TDB_DOCS_AI_DEAL), deci
       in procedura exista cind se ajunge la sfirsitul ei;
     - SP_DEAL_SET_WEB_ORDER_INFO scrie campurile; o eroare a ei se jurnalizeaza in
       TDB_DEAL_LOG si NU opreste comanda;
     - UTM-ul complet (first/last touch) il scrie site-ul DUPA comanda in TWEB_ORDER_UTM,
       pentru toate tipurile de comanda -> trigger TWEB_ORDER_UTM_AIU_DEAL (last touch,
       altfel first touch). WEB_CREATE_TRANSACTION3 mai trimite si singur UTM-ul;
     - la "1 click" site-ul lipeste la adresa " | COMENTARIU: ..." si " | UTM: ...";
       procedura le separa: comentariul -> DELIVERY_NOTE, UTM-ul se ignora (vine din
       TWEB_ORDER_UTM).

   Cele trei proceduri de mai jos sint copia EXACTA a celor de pe SW la 23 sep 2026
   (extrase cu isql -x), cu un singur apel adaugat - blocul marcat "Deal:". Daca intre
   timp cineva le-a modificat pe SW, modificarile trebuie reportate aici inainte de rulare.

   Script RE-RULABIL. La sfirsit: completarea deal-urilor existente (optional).
   ============================================================================ */

SET TERM ^ ;

/* --- 1. coloanele noi ------------------------------------------------------ */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'PAYMENT_METHOD')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD PAYMENT_METHOD VARCHAR(60)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'UTM_SOURCE')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD UTM_SOURCE VARCHAR(255)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'UTM_MEDIUM')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD UTM_MEDIUM VARCHAR(255)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'UTM_CAMPAIGN')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD UTM_CAMPAIGN VARCHAR(255)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'UTM_CONTENT')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD UTM_CONTENT VARCHAR(255)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TDB_DEALS' AND RDB$FIELD_NAME = 'UTM_TERM')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TDB_DEALS ADD UTM_TERM VARCHAR(255)';
END^

SET TERM ; ^
COMMIT;
SET TERM ^ ;

/* --- 2. metoda de plata ca text ---------------------------------------------
   'CART'     (WEB_CREATE_TRANSACTION3 / 2_ECOMM, TWEB_TRANSACTION.PAYMENT_TYPE):
              0 credit, 1 numerar, 2 card la livrare, 3 card online, 4 cont spre plata
              (helpers/CheckoutOrder.php::PAYMENTS pe site)
   'ONECLICK' (WEB_CREATE_TRANSACTION_PHONE2): 0 la primire, 1 credit, 2 MIA QR      */
CREATE OR ALTER FUNCTION FN_DEAL_WEB_PAYMENT_METHOD (
    A_SOURCE VARCHAR(16),
    A_TYPE   INTEGER)
RETURNS VARCHAR(60)
AS
BEGIN
  IF (A_TYPE IS NULL) THEN RETURN NULL;
  IF (A_SOURCE = 'ONECLICK') THEN
    RETURN DECODE(A_TYPE, 0, 'La primire', 1, 'Credit', 2, 'MIA QR', 'Cod ' || A_TYPE);
  RETURN DECODE(A_TYPE, 0, 'Credit', 1, 'Numerar la livrare', 2, 'Card la livrare',
                        3, 'Card online', 4, 'Cont spre plata', 'Cod ' || A_TYPE);
END^

/* --- 3. valoarea unei linii "Eticheta: valoare" din comentariile documentului -- */
CREATE OR ALTER FUNCTION FN_DEAL_COMMENT_VALUE (
    A_TEXT  VARCHAR(8000),
    A_LABEL VARCHAR(60))
RETURNS VARCHAR(1000)
AS
DECLARE V_POS INTEGER;
DECLARE V_END INTEGER;
DECLARE V_PART VARCHAR(1000);
BEGIN
  IF (A_TEXT IS NULL OR A_LABEL IS NULL) THEN RETURN NULL;
  V_POS = POSITION(UPPER(A_LABEL) IN UPPER(A_TEXT));
  IF (V_POS = 0) THEN RETURN NULL;
  V_PART = SUBSTRING(A_TEXT FROM V_POS + CHAR_LENGTH(A_LABEL) FOR 1000);
  V_END = POSITION(ASCII_CHAR(10) IN V_PART);
  IF (V_END > 0) THEN V_PART = SUBSTRING(V_PART FROM 1 FOR V_END - 1);
  RETURN NULLIF(TRIM(REPLACE(V_PART, ASCII_CHAR(13), '')), '');
END^

/* --- 4. scrierea in deal ------------------------------------------------------
   A_OVERWRITE = 1: valorile nenule inlocuiesc ce este in deal (crearea comenzii);
   A_OVERWRITE = 0: se completeaza doar campurile goale (completarea istoricului).
   UTM-ul se scrie ca grup (toate 5 odata), ca sa nu se amestece doua vizite.
   Nu arunca niciodata exceptii - comanda de pe site nu are voie sa cada din cauza deal-ului. */
CREATE OR ALTER PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO (
    A_DOCID          INTEGER,
    A_NAME           VARCHAR(255),
    A_PHONE          VARCHAR(255),
    A_ADDRESS        VARCHAR(1000),
    A_CITYID         INTEGER,
    A_PAYMENT_METHOD VARCHAR(60),
    A_UTM_SOURCE     VARCHAR(255),
    A_UTM_MEDIUM     VARCHAR(255),
    A_UTM_CAMPAIGN   VARCHAR(255),
    A_UTM_CONTENT    VARCHAR(255),
    A_UTM_TERM       VARCHAR(255),
    A_OVERWRITE      SMALLINT = 1)
SQL SECURITY DEFINER
AS
DECLARE V_DEAL BIGINT;
DECLARE V_NAME VARCHAR(255);
DECLARE V_PHONE VARCHAR(255);
DECLARE V_ADDRESS VARCHAR(1000);
DECLARE V_NOTE VARCHAR(1000);
DECLARE V_CITY VARCHAR(255);
DECLARE V_PAY VARCHAR(60);
DECLARE V_HAS_UTM SMALLINT;
DECLARE V_POS INTEGER;
BEGIN
  V_NAME = NULLIF(TRIM(A_NAME), '');
  V_PHONE = NULLIF(TRIM(A_PHONE), '');
  V_PAY = NULLIF(TRIM(A_PAYMENT_METHOD), '');
  V_ADDRESS = TRIM(COALESCE(A_ADDRESS, ''));
  V_NOTE = NULL;

  /* "1 click": ADRESA | COMENTARIU: ... | UTM: src=... */
  V_POS = POSITION(' | UTM: ' IN V_ADDRESS);
  IF (V_POS > 0) THEN V_ADDRESS = TRIM(SUBSTRING(V_ADDRESS FROM 1 FOR V_POS - 1));
  IF (LEFT(V_ADDRESS, 5) = 'UTM: ') THEN V_ADDRESS = '';
  V_POS = POSITION(' | COMENTARIU: ' IN V_ADDRESS);
  IF (V_POS > 0) THEN
  BEGIN
    V_NOTE = NULLIF(TRIM(SUBSTRING(V_ADDRESS FROM V_POS + 15)), '');
    V_ADDRESS = TRIM(SUBSTRING(V_ADDRESS FROM 1 FOR V_POS - 1));
  END
  ELSE IF (LEFT(V_ADDRESS, 12) = 'COMENTARIU: ') THEN
  BEGIN
    V_NOTE = NULLIF(TRIM(SUBSTRING(V_ADDRESS FROM 13)), '');
    V_ADDRESS = '';
  END

  /* localitatea din nomenclator (checkout-ul din cos o trimite separat) */
  IF (A_CITYID IS NOT NULL) THEN
    SELECT NULLIF(TRIM(TITLE), '') FROM TS_SYSS WHERE SYSSID = :A_CITYID INTO :V_CITY;
  IF (V_CITY IS NOT NULL AND POSITION(UPPER(V_CITY) IN UPPER(V_ADDRESS)) = 0) THEN
    V_ADDRESS = IIF(V_ADDRESS = '', V_CITY, V_ADDRESS || ', ' || V_CITY);
  V_ADDRESS = NULLIF(V_ADDRESS, '');

  V_HAS_UTM = IIF(COALESCE(NULLIF(TRIM(A_UTM_SOURCE), ''), NULLIF(TRIM(A_UTM_MEDIUM), ''),
                           NULLIF(TRIM(A_UTM_CAMPAIGN), ''), NULLIF(TRIM(A_UTM_CONTENT), ''),
                           NULLIF(TRIM(A_UTM_TERM), '')) IS NULL, 0, 1);

  FOR SELECT DEAL_ID FROM TDB_DEAL_DOCS WHERE DOCID = :A_DOCID INTO :V_DEAL
  DO
    UPDATE TDB_DEALS SET
      CONTACT_NAME = IIF(:V_NAME IS NOT NULL AND (:A_OVERWRITE = 1 OR CONTACT_NAME IS NULL),
                         LEFT(:V_NAME, 120), CONTACT_NAME),
      PHONE = IIF(:V_PHONE IS NOT NULL AND (:A_OVERWRITE = 1 OR PHONE IS NULL),
                  LEFT(:V_PHONE, 40), PHONE),
      DELIVERY_ADDRESS = IIF(:V_ADDRESS IS NOT NULL AND (:A_OVERWRITE = 1 OR DELIVERY_ADDRESS IS NULL),
                             LEFT(:V_ADDRESS, 500), DELIVERY_ADDRESS),
      DELIVERY_NOTE = IIF(:V_NOTE IS NOT NULL AND (:A_OVERWRITE = 1 OR DELIVERY_NOTE IS NULL),
                          LEFT(:V_NOTE, 300), DELIVERY_NOTE),
      PAYMENT_METHOD = IIF(:V_PAY IS NOT NULL AND (:A_OVERWRITE = 1 OR PAYMENT_METHOD IS NULL),
                           :V_PAY, PAYMENT_METHOD),
      UTM_SOURCE = IIF(:V_HAS_UTM = 1 AND (:A_OVERWRITE = 1 OR COALESCE(UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM) IS NULL),
                       NULLIF(TRIM(LEFT(:A_UTM_SOURCE, 255)), ''), UTM_SOURCE),
      UTM_MEDIUM = IIF(:V_HAS_UTM = 1 AND (:A_OVERWRITE = 1 OR COALESCE(UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM) IS NULL),
                       NULLIF(TRIM(LEFT(:A_UTM_MEDIUM, 255)), ''), UTM_MEDIUM),
      UTM_CAMPAIGN = IIF(:V_HAS_UTM = 1 AND (:A_OVERWRITE = 1 OR COALESCE(UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM) IS NULL),
                         NULLIF(TRIM(LEFT(:A_UTM_CAMPAIGN, 255)), ''), UTM_CAMPAIGN),
      UTM_CONTENT = IIF(:V_HAS_UTM = 1 AND (:A_OVERWRITE = 1 OR COALESCE(UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM) IS NULL),
                        NULLIF(TRIM(LEFT(:A_UTM_CONTENT, 255)), ''), UTM_CONTENT),
      UTM_TERM = IIF(:V_HAS_UTM = 1 AND (:A_OVERWRITE = 1 OR COALESCE(UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM) IS NULL),
                     NULLIF(TRIM(LEFT(:A_UTM_TERM, 255)), ''), UTM_TERM)
    WHERE DEAL_ID = :V_DEAL;

  WHEN ANY DO
    EXECUTE PROCEDURE SP_DEAL_LOG_ERROR('SP_DEAL_SET_WEB_ORDER_INFO', :A_DOCID, :V_DEAL,
      GDSCODE, SQLSTATE, LEFT(RDB$ERROR(MESSAGE), 1000));
END^

/* --- 5. UTM-ul complet scris de site dupa comanda (toate tipurile de comanda) --- */
CREATE OR ALTER TRIGGER TWEB_ORDER_UTM_AIU_DEAL FOR TWEB_ORDER_UTM
ACTIVE AFTER INSERT OR UPDATE POSITION 900
SQL SECURITY DEFINER
AS
BEGIN
  /* last touch (sursa ultimei vizite), altfel first touch - ca in OrderUtmTracker pe site */
  IF (COALESCE(NULLIF(NEW.LAST_UTM_SOURCE, ''), NULLIF(NEW.LAST_UTM_MEDIUM, ''),
               NULLIF(NEW.LAST_UTM_CAMPAIGN, '')) IS NOT NULL) THEN
    EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(NEW.DOCID, NULL, NULL, NULL, NULL, NULL,
      NEW.LAST_UTM_SOURCE, NEW.LAST_UTM_MEDIUM, NEW.LAST_UTM_CAMPAIGN,
      NEW.LAST_UTM_CONTENT, NEW.LAST_UTM_TERM, 1);
  ELSE
    EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(NEW.DOCID, NULL, NULL, NULL, NULL, NULL,
      NEW.FIRST_UTM_SOURCE, NEW.FIRST_UTM_MEDIUM, NEW.FIRST_UTM_CAMPAIGN,
      NEW.FIRST_UTM_CONTENT, NEW.FIRST_UTM_TERM, 1);
  WHEN ANY DO
    EXECUTE PROCEDURE SP_DEAL_LOG_ERROR('TWEB_ORDER_UTM_AIU', NEW.DOCID, NULL,
      GDSCODE, SQLSTATE, LEFT(RDB$ERROR(MESSAGE), 1000));
END^

/* --- 6. completarea deal-urilor existente (comenzi web de la A_FROM incoace) ---
   Doar campurile goale (A_OVERWRITE = 0). Intoarce numarul de comenzi parcurse. */
CREATE OR ALTER PROCEDURE SP_DEAL_WEB_ORDER_INFO_BACKFILL (
    A_FROM DATE)
RETURNS (
    ORDERS_DONE INTEGER)
SQL SECURITY DEFINER
AS
DECLARE V_DOCID INTEGER;
DECLARE V_NAME VARCHAR(255);
DECLARE V_PHONE VARCHAR(255);
DECLARE V_ADDRESS VARCHAR(1000);
DECLARE V_CITYID INTEGER;
DECLARE V_DELIVERY_TYPE INTEGER;
DECLARE V_PAYMENT_TYPE INTEGER;
DECLARE V_PAY VARCHAR(60);
DECLARE V_TEXT VARCHAR(8000);
DECLARE V_FOUND SMALLINT;
DECLARE U_SOURCE VARCHAR(255);
DECLARE U_MEDIUM VARCHAR(255);
DECLARE U_CAMPAIGN VARCHAR(255);
DECLARE U_CONTENT VARCHAR(255);
DECLARE U_TERM VARCHAR(255);
BEGIN
  ORDERS_DONE = 0;
  FOR SELECT D.DOCID
      FROM TDB_DOCS D
      WHERE D.DOCTYPEID = 134 AND D.DATA >= :A_FROM
        AND EXISTS(SELECT 1 FROM TDB_DEAL_DOCS DD WHERE DD.DOCID = D.DOCID)
      INTO :V_DOCID
  DO
  BEGIN
    V_NAME = NULL; V_PHONE = NULL; V_ADDRESS = NULL; V_CITYID = NULL; V_PAY = NULL;
    U_SOURCE = NULL; U_MEDIUM = NULL; U_CAMPAIGN = NULL; U_CONTENT = NULL; U_TERM = NULL;

    /* cos / card online */
    V_FOUND = 0;
    FOR SELECT FIRST 1 FULLNAME, PHONES, ADDRESS, CITYID, DELIVERY_TYPE, PAYMENT_TYPE
        FROM TWEB_TRANSACTION WHERE DOCID = :V_DOCID
        INTO :V_NAME, :V_PHONE, :V_ADDRESS, :V_CITYID, :V_DELIVERY_TYPE, :V_PAYMENT_TYPE
    DO
    BEGIN
      V_FOUND = 1;
      IF (V_DELIVERY_TYPE = 1) THEN
      BEGIN
        V_ADDRESS = 'Ridicare din magazin';
        V_CITYID = NULL;
      END
      V_PAY = FN_DEAL_WEB_PAYMENT_METHOD('CART', :V_PAYMENT_TYPE);
    END

    /* "1 click": datele sint doar in comentariile documentului */
    IF (V_FOUND = 0) THEN
    BEGIN
      V_TEXT = NULL;
      SELECT FIRST 1 CAST(SUBSTRING(COMMENTS FROM 1 FOR 8000) AS VARCHAR(8000))
      FROM TDB_DOCS_PROPS WHERE DOCID = :V_DOCID
      INTO :V_TEXT;
      V_NAME = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Client: ');
      V_PHONE = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Telefon: ');
      V_ADDRESS = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'adresa de livrare: ');
      V_PAY = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Metoda de plata: ');
      IF (UPPER(V_PAY) = 'ACHITA LA PRIMIRE') THEN V_PAY = 'La primire';
      ELSE IF (UPPER(V_PAY) = 'CREDIT') THEN V_PAY = 'Credit';
      ELSE IF (UPPER(V_PAY) = 'MIA') THEN V_PAY = 'MIA QR';
    END

    /* UTM: atribuirea completa a site-ului, altfel ce a primit WEB_CREATE_TRANSACTION3 */
    SELECT FIRST 1
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_SOURCE, FIRST_UTM_SOURCE),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_MEDIUM, FIRST_UTM_MEDIUM),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_CAMPAIGN, FIRST_UTM_CAMPAIGN),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_CONTENT, FIRST_UTM_CONTENT),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_TERM, FIRST_UTM_TERM)
    FROM TWEB_ORDER_UTM WHERE DOCID = :V_DOCID
    INTO :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM;
    IF (COALESCE(NULLIF(U_SOURCE, ''), NULLIF(U_MEDIUM, ''), NULLIF(U_CAMPAIGN, ''),
                 NULLIF(U_CONTENT, ''), NULLIF(U_TERM, '')) IS NULL) THEN
      SELECT FIRST 1 UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM
      FROM TDB_DOCS_UTM WHERE DOCID = :V_DOCID
      INTO :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM;

    EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:V_DOCID, :V_NAME, :V_PHONE, :V_ADDRESS, :V_CITYID, :V_PAY,
      :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM, 0);
    ORDERS_DONE = ORDERS_DONE + 1;
  END
  SUSPEND;
END^

SET TERM ; ^
COMMIT;

/* --- 7. procedurile de comanda ale site-ului (copie SW 23.09.2026 + blocul "Deal:") --- */
SET TERM ^ ;

CREATE OR ALTER PROCEDURE WEB_CREATE_TRANSACTION3 (FIRMA DM_INTEGER_NN,
CUSTOMERID DM_INTEGER_NN,
DELIVERY_TYPE DM_SMALLINT,
PAYMENT_TYPE DM_SMALLINT,
FULLNAME DM_VARCHAR255,
PHONES DM_VARCHAR255,
DISTRICTID DM_INTEGER,
CITYID DM_INTEGER,
ADDRESS DM_VARCHAR255,
SELF_PICKUP_SHOPID DM_INTEGER,
SO_FULLNAME DM_VARCHAR255,
SO_PHONES DM_VARCHAR255,
TRANSPORTERID DM_INTEGER,
TRANSPORT_GOODSID DM_INTEGER,
COMMENTS DM_BLOBTEXT,
SHOPCARTGUID DM_VARCHAR60 NOT NULL,
FLG_CURRENCY_USD DM_BOOLEAN_NN,
FLG_USER_PRICE_COLUMN DM_BOOLEAN_NN,
USER_PRICE_COLUMN DM_INTEGER,
FLG_USE_CASHBACK DM_INTEGER,
CASHBACK_USED_AMOUNT DM_PRICE = 0,
PROMO_CODE DM_VARCHAR32 = '',
OPERATOR DM_VARCHAR128 = '',
REFERRER DM_VARCHAR512 = null,
UTM_SOURCE DM_VARCHAR128 = null,
UTM_MEDIUM DM_VARCHAR128 = null,
UTM_CAMPAIGN DM_VARCHAR128 = null,
UTM_CONTENT DM_VARCHAR128 = null,
UTM_TERM DM_VARCHAR128 = null,
CLIENT_IP DM_VARCHAR16 = '0.0.0.1')
RETURNS (DOCID DM_INTEGER)
AS 
-- Defaults document
    DECLARE DT           DM_INTEGER;
    DECLARE DTDEP        DM_INTEGER;
    DECLARE CTDEP        DM_INTEGER;
    DECLARE DTSC         DM_INTEGER;
    DECLARE SC2          DM_INTEGER;
    -- Valute
    DECLARE CURRENCYID   DM_INTEGER;
    DECLARE RATE         DM_PRICE;
    DECLARE RATEUSD      DM_PRICE;
    -- Produs curent (cursor)
    DECLARE GOODSID      DM_INTEGER;
    DECLARE QTY          DM_QTY;
    DECLARE UMID         DM_INTEGER;
    DECLARE WARRANTY     DM_INTEGER;
    DECLARE GOODSPRICE   DM_PRICE;
    -- Colonita de preturi
    DECLARE WEB_PRICE_COLUMN DM_PRICECOLUMN;
    -- Calcule financiare
    DECLARE FLG_ACNT         DM_BOOLEAN_NN;
    DECLARE IS_FREE_DELIVERY DM_BOOLEAN;
    DECLARE DELIVERY_PRICE   DM_AMOUNT;
    DECLARE ORDER_AMOUNT     DM_AMOUNT;
    DECLARE PROMOCODE_DISCOUNT DM_AMOUNT;
BEGIN
    /* ================================================================
       WEB_CREATE_TRANSACTION3
       Creează o comandă WEB din coșul de cumpărături al clientului.
       Suportă: valută USD, colonițe client, promo code, cashback,
                livrare la domiciliu, SMS notificare.
       ================================================================ */

    /* --- Contextul sesiunii web ------------------------------------ */
    RDB$SET_CONTEXT('USER_SESSION',    'UserID',            9);
    RDB$SET_CONTEXT('USER_TRANSACTION','RequireModifyDOC',  1);

    /* --- Verificare coș activ ------------------------------------- */
    IF (NOT EXISTS (
        SELECT 1 FROM TWEB_SHOP_CART
        WHERE SHOP_CART_ID = :SHOPCARTGUID
          AND CUSTOMERID   = :CUSTOMERID
    )) THEN
        EXIT; -- coș inexistent sau aparținând altui client

    /* ================================================================
       SECȚIUNEA 1: Inițializare parametri document
       ================================================================ */

    DOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;

    /* Toate comenzile web se creează ca "sciot na oplatu" (achitare) */
    FLG_ACNT = 1;

    /* Firma activă în funcție de dată (migrare entitate juridică) */
--    FIRMA = IIF(CURRENT_DATE >= '17.09.2024', 307225, 218482);
    FIRMA = 316910;
    /* Curs USD curent */
    SELECT IIF(:FLG_ACNT = 1, TRANSFER_RATE, EXCHANGE_RATE)
    FROM TS_CURRENCY WHERE CURRENCYID = 840
    INTO :RATEUSD;

    /* Valori implicite pentru tipul de document 134 */
    SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
    FROM TS_DOCTYPES_DEFVALUES
    WHERE DOCTYPEID = 134 AND FIRMA = :FIRMA
    INTO :DT, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :SC2;

    /* Suprascrie valuta dacă clientul a ales USD */
    IF (FLG_CURRENCY_USD = 1) THEN
        CURRENCYID = 840;

    /* Colonița de prețuri a clientului (întotdeauna din profil) */
    SELECT PRICECOLUMN FROM TS_CUST_INFO
    WHERE CUSTOMERID = :CUSTOMERID
    INTO :WEB_PRICE_COLUMN;

    IF (WEB_PRICE_COLUMN IS NULL) THEN
        WEB_PRICE_COLUMN = 1;

    /* Curs valutar pentru valuta documentului */
    SELECT IIF(:FLG_ACNT = 1, TRANSFER_RATE, EXCHANGE_RATE)
    FROM TS_CURRENCY WHERE CURRENCYID = :CURRENCYID
    INTO :RATE;

    /* ================================================================
       SECȚIUNEA 2: Creare header document + UTM
       ================================================================ */

    INSERT INTO TDB_DOCS (
        DOCID, DT, CT, DTDEP, CTDEP, DTSC,
        CURRENCYID, RATE, CREATED_BY, DOCTYPEID,
        RATEUSD, SC2, FLAGS
    ) VALUES (
        :DOCID, :DT, :CUSTOMERID, :DTDEP, :CTDEP, :DTSC,
        :CURRENCYID, :RATE, 9, 134,
        :RATEUSD, :SC2,
        SET_FLG_VALUE(SET_FLG_VALUE(0, 1, :FLG_ACNT), 18, 1)
    );

    IF (:COMMENTS IS NOT NULL) THEN
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', :COMMENTS);

    INSERT INTO TDB_DOCS_UTM (
        DOCID, REFERRER,
        UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM,
        DATE_CAPTURED
    ) VALUES (
        :DOCID, :REFERRER,
        :UTM_SOURCE, :UTM_MEDIUM, :UTM_CAMPAIGN, :UTM_CONTENT, :UTM_TERM,
        CURRENT_TIMESTAMP
    );

    /* ================================================================
       SECȚIUNEA 3: Linii jurnal — produse din coș
       ================================================================ */

    FOR
        SELECT W.GOODSID, W.QTY, G.UMID, G.WARRANTY
        FROM TWEB_SHOP_CART W
        JOIN TS_GOODS G ON G.GOODSID = W.GOODSID
        WHERE W.SHOP_CART_ID = :SHOPCARTGUID
          AND W.CUSTOMERID   = :CUSTOMERID
        INTO :GOODSID, :QTY, :UMID, :WARRANTY
    DO
    BEGIN
        IF (:QTY <= 0) THEN continue; -- sari produsele cu cantitate invalidă

        /* Colonița produsului din catalog web (dacă nu s-a forțat cea a clientului) */
        IF (FLG_USER_PRICE_COLUMN = 0) THEN
            SELECT COALESCE(CUSTOM_PRICE_COLUMN, 1)
            FROM WEB_GET_CATALOG_TREE_BY_GOODSID(:GOODSID, 5213)
            INTO :WEB_PRICE_COLUMN;

        SELECT PRICE_MDL
        FROM GET_GOODS_PRICE(:GOODSID, :WEB_PRICE_COLUMN, :CURRENCYID)
        INTO :GOODSPRICE;

        INSERT INTO TDB_JURNAL (
            DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID,
            GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS
        ) VALUES (
            :DOCID, :DTDEP, :CTDEP, -1,
            :GOODSID, :QTY, :UMID, :GOODSPRICE, :WARRANTY, 0, 1
        );
    END

    /* ================================================================
       SECȚIUNEA 4: Ajustări financiare
       ================================================================ */

    /* 4a. Reducere cod promoțional */
    SELECT DISCOUNT
    FROM SP_MK_APPLY_PROMOCODE_AUTHUSER(:PROMO_CODE, :CUSTOMERID)
    INTO :PROMOCODE_DISCOUNT;

    IF (COALESCE(:PROMOCODE_DISCOUNT, 0) > 0) THEN
        INSERT INTO TDB_JURNAL (
            DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID,
            GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS
        ) VALUES (
            :DOCID, :DTDEP, :CTDEP, -1,
            368756, 1, :UMID, -1 * :PROMOCODE_DISCOUNT, :WARRANTY, 0, 1
        );

    /* 4b. Cost livrare (doar DELIVERY_TYPE = 2: livrare la domiciliu) */
    IF (DELIVERY_TYPE = 2) THEN
    BEGIN
        SELECT SUM(SUMA) FROM TDB_JURNAL
        WHERE DOCID = :DOCID
        INTO :ORDER_AMOUNT;

        SELECT ISFREEDELIVERY, GOODS_PRICE_LEI
        FROM WEB_GET_DELIVERY_FIRMS(5213, :DISTRICTID, :CITYID, :ORDER_AMOUNT)
        INTO :IS_FREE_DELIVERY, :DELIVERY_PRICE;

        INSERT INTO TDB_JURNAL (
            DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID,
            GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS
        ) VALUES (
            :DOCID, :DTDEP, :CTDEP, -1,
            :TRANSPORT_GOODSID, 1, 1, :DELIVERY_PRICE, 0, 0, 1
        );
    END

    /* 4c. Utilizare cashback */
    IF (COALESCE(:CASHBACK_USED_AMOUNT, 0) > 0) THEN
        EXECUTE PROCEDURE SP_USE_CASHBACK(
            :DOCID, :DTDEP, :CTDEP, :CASHBACK_USED_AMOUNT
        );

    /* ================================================================
       SECȚIUNEA 5: Înregistrare tranzacție web
       ================================================================ */

    INSERT INTO TWEB_TRANSACTION (
        CUSTOMERID, DELIVERY_TYPE, PAYMENT_TYPE,
        FULLNAME, PHONES, DISTRICTID, CITYID, ADDRESS,
        SELF_PICKUP_SHOPID, SO_FULLNAME, SO_PHONES,
        TRANSPORTERID, TRANSPORT_GOODSID,
        DOCID, CURRENCYID
    ) VALUES (
        :CUSTOMERID, :DELIVERY_TYPE, :PAYMENT_TYPE,
        :FULLNAME, :PHONES, :DISTRICTID, :CITYID, :ADDRESS,
        :SELF_PICKUP_SHOPID, :SO_FULLNAME, :SO_PHONES,
        :TRANSPORTERID, :TRANSPORT_GOODSID,
        :DOCID, :CURRENCYID
    );

    /* Deal: datele comenzii in campuri separate (23.09.2026) */
    EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :FULLNAME, :PHONES,
        IIF(:DELIVERY_TYPE = 1, 'Ridicare din magazin', :ADDRESS),
        IIF(:DELIVERY_TYPE = 1, NULL, :CITYID),
        FN_DEAL_WEB_PAYMENT_METHOD('CART', :PAYMENT_TYPE),
        :UTM_SOURCE, :UTM_MEDIUM, :UTM_CAMPAIGN, :UTM_CONTENT, :UTM_TERM, 1);

    /* ================================================================
       SECȚIUNEA 6: Cleanup + notificări
       ================================================================ */

    /* Golire coș după plasarea comenzii */
    DELETE FROM TWEB_SHOP_CART
    WHERE SHOP_CART_ID = :SHOPCARTGUID
      AND CUSTOMERID   = :CUSTOMERID;

    /* Eveniment intern pentru procesare DT */
    EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:FIRMA, 6, '', :DOCID, 9);

    /* SMS confirmare — text adaptat în funcție de zi (luni = revenire luni) */
    INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT, SOURCE_TABLE)
    VALUES (
        :PHONES,
        'Internet magazin [www.fantastic.md~Comanda](https://www.fantastic.md~Comanda) d-stra nr.' || :DOCID
        || IIF(
            EXTRACT(WEEKDAY FROM CURRENT_DATE - 1) = 0,
            ' se prelucreaza.~Luni va vom apela pentru detalii.',
            ' se prelucreaza.~In curind un operator va va apela pentru detalii.'
        )
        || '~Va Multumim!~Pentru informatii suplimentare apelati 022 90-30-90',
        4
    );

    SUSPEND;
END ^

CREATE OR ALTER PROCEDURE WEB_CREATE_TRANSACTION2_ECOMM (FIRMA DM_INTEGER_NN,
CUSTOMERID DM_INTEGER_NN,
DELIVERY_TYPE DM_SMALLINT,
PAYMENT_TYPE DM_SMALLINT,
FULLNAME DM_VARCHAR255,
PHONES DM_VARCHAR255,
DISTRICTID DM_INTEGER,
CITYID DM_INTEGER,
ADDRESS DM_VARCHAR255,
SELF_PICKUP_SHOPID DM_INTEGER,
SO_FULLNAME DM_VARCHAR255,
SO_PHONES DM_VARCHAR255,
TRANSPORTERID DM_INTEGER,
TRANSPORT_GOODSID DM_INTEGER,
COMMENTS DM_BLOBTEXT,
SHOPCARTGUID DM_VARCHAR60,
FLG_USE_CASHBACK DM_INTEGER,
CASHBACK_USED_AMOUNT DM_PRICE = 0,
CLIENT_IP DM_VARCHAR16 default '0.0.0.1')
RETURNS (DOCID DM_INTEGER)
AS 
declare variable DT DM_INTEGER;
declare variable DTDEP DM_INTEGER;
declare variable CTDEP DM_INTEGER;
declare variable DTSC DM_INTEGER;
declare variable CURRENCYID DM_INTEGER;
declare variable RATE DM_PRICE;
declare variable SC2 DM_INTEGER;
declare variable FLG_ACNT DM_BOOLEAN_NN;
declare variable RATEUSD DM_PRICE;
declare variable GOODSID DM_INTEGER;
declare variable QTY DM_QTY;
declare variable UMID DM_INTEGER;
declare variable WARRANTY DM_INTEGER;
declare variable GOODSPRICE DM_PRICE;
declare variable WEB_PRICE_COLUMN DM_PRICECOLUMN;
declare IS_FREE_DELIVERY DM_BOOLEAN;
declare ORDER_AMOUNT dm_amount;
declare DELIVERY_PRICE DM_AMOUNT;
BEGIN


     /* create user enviroment Web User */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9);
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

--          if (current_date>='08.09.2024') then
--            :firma = 307225;
--          else
            :FIRMA = 316910;

          DOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;

          /* Sciot na oplatu */
          FLG_ACNT = IIF(PAYMENT_TYPE = 2, 1, 0);

          /* get USD rate */
          SELECT IIF(:FLG_ACNT = 1, TRANSFER_RATE, EXCHANGE_RATE)
          FROM TS_CURRENCY
          WHERE CURRENCYID = 840
          INTO :RATEUSD;

          /* get document defaults */
          SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
          FROM TS_DOCTYPES_DEFVALUES
          WHERE DOCTYPEID = 134 AND
                FIRMA = :FIRMA
          INTO :DT, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :SC2;

          /* get default currency info */
          SELECT IIF(:FLG_ACNT = 1, TRANSFER_RATE, EXCHANGE_RATE)
          FROM TS_CURRENCY
          WHERE CURRENCYID = :CURRENCYID
          INTO :RATE;

          /* create Doc */
          INSERT INTO TDB_DOCS (DOCID, DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, RATE, CREATED_BY, DOCTYPEID, RATEUSD, SC2, FLAGS)
          VALUES (:DOCID, :DT, :CUSTOMERID, :DTDEP, :CTDEP, 5114 /*оплата банковской картой - ecomm*/, :CURRENCYID, :RATE, 9, 134, :RATEUSD, :SC2,
                  set_flg_value(SET_FLG_VALUE(0, 1, :FLG_ACNT), 18, 1));

/* debug */

--            insert into tdb_debug (text) values (
--            'docid='||:docid||', shop_cart_id: '|| :shopcartguid||', goods list: '||(select list(goodsid) from tweb_shop_cart_ecomm where shop_cart_id=:shopcartguid)||' customerid = '|| :customerid
--            );
/* end debug */
          /* insert goods, set FLG_ACTIVE(0)=1 */
          FOR SELECT GOODSID, QTY,
                     (SELECT UMID
                      FROM TS_GOODS
                      WHERE TS_GOODS.GOODSID = TWEB_SHOP_CART_ECOMM.GOODSID),
                     /* UMID */
                     (SELECT WARRANTY
                      FROM TS_GOODS
                      WHERE TS_GOODS.GOODSID = TWEB_SHOP_CART_ECOMM.GOODSID) /* WARRANTY */
              FROM TWEB_SHOP_CART_ECOMM
              WHERE SHOP_CART_ID = :SHOPCARTGUID AND
                    CUSTOMERID = :CUSTOMERID
              INTO :GOODSID, :QTY, :UMID, :WARRANTY
          DO
          BEGIN
               WEB_PRICE_COLUMN = 4;

               /* get price */
               SELECT PRICE_MDL
               FROM GET_GOODS_PRICE(:GOODSID, :WEB_PRICE_COLUMN, :CURRENCYID)
               INTO :GOODSPRICE;

               INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS)
               VALUES (:DOCID, :DTDEP, :CTDEP, -1, :GOODSID, :QTY, :UMID, :GOODSPRICE, :WARRANTY, 0, 1);

               EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'GOODSID: #', :GOODSID || ', Pret = '||round(:goodsPrice,2) ||', Valuta: '||:currencyid);
          END

--          if (row_count=0) then
--            insert into tdb_debug (text) values (
--            'rows_affected=0; shop_cart_id: '|| :shopcartguid||',  customerid = '|| :customerid
--            );


--          if (:flg_use_cashback=1) then
--          begin
             if (coalesce(:cashback_used_amount, 0)>0) then
               execute procedure sp_use_cashback (:docid, :dtdep, :ctdep, :cashback_used_amount);
--    )
--                   INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS)
--                   VALUES (:DOCID, :DTDEP, :CTDEP, -1, 201028 /* cashback */  , 1, 1, -1 * :cashback_used_amount, 0, 0, 1);
--
--                   insert into tdb_docs_cashback_used (docid, cashback_used) values (:docid, :cashback_used_amount);
--          end

          /* Adaugam pozitie LIVRARE */
          IF (DELIVERY_TYPE = 2) THEN
          begin
               SELECT SUMA FROM TDB_DOCS WHERE DOCID=:DOCID INTO :ORDER_AMOUNT;
               select ISFREEDELIVERY, GOODS_PRICE_LEI from WEB_GET_DELIVERY_FIRMS (5213, :DISTRICTID, :CITYID, :ORDER_AMOUNT) INTO :IS_FREE_DELIVERY, :DELIVERY_PRICE;

               INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS)
               VALUES (:DOCID, :DTDEP, :CTDEP, -1, :TRANSPORT_GOODSID, 1, 1, :DELIVERY_PRICE, /* PRICE */
                       0, 0, 1);
          end

          /* create transaction */
          INSERT INTO TWEB_TRANSACTION (CUSTOMERID, DELIVERY_TYPE, PAYMENT_TYPE, FULLNAME, PHONES, DISTRICTID, CITYID, ADDRESS,
                                        SELF_PICKUP_SHOPID, SO_FULLNAME, SO_PHONES, TRANSPORTERID, TRANSPORT_GOODSID, DOCID)
          VALUES (:CUSTOMERID, :DELIVERY_TYPE, :PAYMENT_TYPE, :FULLNAME, :PHONES, :DISTRICTID, :CITYID, :ADDRESS, :SELF_PICKUP_SHOPID,
                  :SO_FULLNAME, :SO_PHONES, :TRANSPORTERID, :TRANSPORT_GOODSID, :DOCID);

          /* Deal: datele comenzii in campuri separate (23.09.2026); UTM-ul vine din TWEB_ORDER_UTM */
          EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :FULLNAME, :PHONES,
              IIF(:DELIVERY_TYPE = 1, 'Ridicare din magazin', :ADDRESS),
              IIF(:DELIVERY_TYPE = 1, NULL, :CITYID),
              FN_DEAL_WEB_PAYMENT_METHOD('CART', :PAYMENT_TYPE),
              NULL, NULL, NULL, NULL, NULL, 1);

          /* create DOC comments */
          if (:comments is null) then
              :COMMENTS = 'ACHITAT CU CARD ONLINE DE PE SITE!';
          IF (:COMMENTS IS NOT NULL) THEN
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', :COMMENTS);

          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'FULLNAME: ', coalesce(:FULLNAME,''));
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'TELEFON: ', coalesce(:PHONES,''));
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'ADDRESS: ', coalesce(:ADDRESS, ''));

          if (:cityid is not null) then
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'CITY: ', coalesce((SELECT TITLE FROM TS_SYSS WHERE SYSSID=:CITYID), ''));

          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'TIPUL LIVRARII: ',  IIF(:DELIVERY_TYPE = 1, 'Ridica din magazin', 'Prin curier'));
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'flg_use_cashback:', coalesce(:flg_use_cashback, 0));
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'Cashback reducere:', coalesce(:cashback_used_amount, 0));

          /* update phone number */
          update or insert into ts_cust_phones
          (customerid, phonenumber, phonetypeid)
          values (:customerid, coalesce(:SO_phones, :phones), 7468)
          matching (customerid, phonenumber);

          /* cleanup */
          /* remove goods from customer's Shop Cart */
          DELETE FROM TWEB_SHOP_CART_ECOMM
          WHERE SHOP_CART_ID = :SHOPCARTGUID AND CUSTOMERID = :CUSTOMERID;

          /* notify Event */
          EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:FIRMA, 6, '', :DOCID, 9);

          INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT, SOURCE_TABLE)
          VALUES (:PHONES, 'Internet magazin FANTASTIC.MD.~Comanda d-stra nr.' || :DOCID ||
                   ' este in procesare. ~In curind operatorul va apela pentru detalii.~Pentru informatii suplimentare ne puteti contacta la telefonul (079)903090. ~Va multumim!',
              4);



          SUSPEND;
END ^

CREATE OR ALTER PROCEDURE WEB_CREATE_TRANSACTION_PHONE2 (USERFULLNAME DM_VARCHAR128 NOT NULL,
USERPHONE DM_VARCHAR10 NOT NULL,
FLG_CURRENCY_USD DM_BOOLEAN_NN,
FLG_USER_PRICE_COLUMN DM_INTEGER,
CUSTOMERID DM_INTEGER_NN,
DELIVERY_ADRESS DM_VARCHAR255 = '',
PAYMENT_TYPE DM_INTEGER = 0,
USERIP DM_VARCHAR32 = '0.0.0.1')
RETURNS (DOCID DM_INTEGER)
AS 
declare variable DT DM_INTEGER;
declare variable DTDEP DM_INTEGER;
declare variable CTDEP DM_INTEGER;
declare variable DTSC DM_INTEGER;
declare variable CURRENCYID DM_INTEGER;
declare variable RATE DM_PRICE;
declare variable SC2 DM_INTEGER;
declare variable RATEUSD DM_PRICE;
declare variable WEB_PRICE_COLUMN DM_PRICECOLUMN;
declare variable UMID DM_INTEGER;
declare variable WARRANTY DM_INTEGER;
declare variable GOODSPRICE DM_PRICE;
declare variable SUMA_DOC DM_PRICE;
declare variable CURRENCY_NAME DM_VARCHAR16;
declare variable GOODS_NAME DM_VARCHAR2048;
declare goodslist dm_blobtext;
declare gid dm_integer;
declare QTY DM_INTEGER;
declare goods_list dm_blobtext;
BEGIN
     /* 26.05.2014 - JOHN */
     /* WEB */
     /* "Cumpara online prin telefon" */
     /* Creaza un Web-Zakaz pe Persoana Fizica cu info despre client */
--     if (:userIp in ('0.0.0.0') ) then
--     begin
--       DOCID = -1;
--       exit;
--     end

     if (flg_user_price_column>1) then
       flg_user_price_column = 1;

     /* create user enviroment Web User */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9);
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);
     if ((select count(customerid) from get_customers_by_phone(:userphone))=1) then
     begin
        select first 1 customerid from get_customers_by_phone(:userphone) into :customerid;
     end
     /* get USD rate */
     SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :RATEUSD;

     IF (CUSTOMERID=-1) THEN CUSTOMERID = 286; /* PERSOANA FIZICA */
     else
     begin
        select ci.pricecolumn from ts_cust_info ci where customerid = :customerid into :web_price_column;
     end

     /* get document defaults */
     SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
     FROM TS_DOCTYPES_DEFVALUES
     WHERE DOCTYPEID = 134 AND FIRMA = 316910
     INTO :DT, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :SC2;

     :CTDEP = -1;

     IF (FLG_CURRENCY_USD = 1 AND CUSTOMERID <> 286) THEN CURRENCYID = 840;
         WEB_PRICE_COLUMN = 1;

     /* get default currency info */
     SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :CURRENCYID INTO :RATE;

     /* create Doc */
     INSERT INTO TDB_DOCS (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, RATE, CREATED_BY, DOCTYPEID, RATEUSD, SC2, FLAGS)
     VALUES (:DT, :CUSTOMERID, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :RATE, 9, 134, :RATEUSD, :SC2, 0)
     RETURNING DOCID INTO :DOCID;

     :goods_list = '<table width=1000px>' ||
     '<tr>
       <td width="20%">Cod</td>
       <td width="65%">Produs</td>
       <td width="15%">Cant</td>
      </tr>';

     for select goodsid, qty from tmp$goodsqty into :gid, :qty do
     begin
         if (:qty>0) then
         begin
         SELECT CUSTOM_PRICE_COLUMN
         FROM WEB_GET_CATALOG_TREE_BY_GOODSID(:gid, 5213)
         INTO :WEB_PRICE_COLUMN;

         IF (WEB_PRICE_COLUMN IS NULL) THEN WEB_PRICE_COLUMN = 1;
    
         IF (FLG_USER_PRICE_COLUMN = 1 AND CUSTOMERID <> 286) THEN
         BEGIN
              SELECT PRICECOLUMN
              FROM TS_CUST_INFO
              WHERE CUSTOMERID=:CUSTOMERID
              INTO :WEB_PRICE_COLUMN;
    
              if ((:WEB_PRICE_COLUMN IS NULL) or (:web_price_column<4)) then WEB_PRICE_COLUMN = 1;
         END

         SELECT UMID, WARRANTY, title
         FROM TS_GOODS
         WHERE GOODSID = :gid
         INTO :UMID, :WARRANTY, :GOODS_NAME;

         /* get price */
         SELECT PRICE_MDL
         FROM GET_GOODS_PRICE(:gid, :WEB_PRICE_COLUMN, :CURRENCYID)
         INTO :GOODSPRICE;
    
         INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS)
         VALUES (:DOCID, :DTDEP, :CTDEP , -1, :gid, :QTY, :UMID, :GOODSPRICE, :WARRANTY, 0, 1);

        :goods_list = :goods_list || '<tr><td>' || :gid ||'</td><td>'||:goods_name||'</td><td style="text-align:right">'||:qty||'</td></tr>';

         :goodslist = coalesce(:goodslist,'')||'<BR>['||coalesce(:gid,-1)||']-'||substring(coalesce(:GOODS_NAME, '') from 1 for 100)||'<BR>Cant: '||coalesce(:qty, 0);
       end
     end
     :goods_list = :goods_list ||'</table>';
     /* create DOC comments */
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'COMANDA CU 1 CLICK');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Client: ' || :USERFULLNAME);
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Telefon: ' || :USERPHONE);
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'adresa de livrare: ' || :delivery_adress);
     if (payment_type = 0) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: Achita la primire');
     if (payment_type = 1) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: CREDIT');
     if (payment_type = 2) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: MIA');

     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'IP:' || :userip);

     /* Deal: datele comenzii in campuri separate (23.09.2026); UTM-ul vine din TWEB_ORDER_UTM */
     EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :USERFULLNAME, :USERPHONE,
         :DELIVERY_ADRESS, NULL,
         FN_DEAL_WEB_PAYMENT_METHOD('ONECLICK', :PAYMENT_TYPE),
         NULL, NULL, NULL, NULL, NULL, 1);


     /* notify Event */
     EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:dt, 6, '', :DOCID, 9);

     /* Send SMS clientului */
          INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT, SOURCE_TABLE)
          VALUES (:userphone,
                                    'Internet magazin FANTASTIC.MD~Comanda d-stra nr.' || :DOCID || ' este in procesare.~In curind operatorul va apela pentru detalii.~Pentru informatii suplimentare ne puteti contacta la telefonul (079)903090. ~Va multumim!',
                  4);

     select suma, c.TITLE from tdb_docs d
     inner join ts_currency C on c.CURRENCYID=d.CURRENCYID
     where docid=:docid
     into :suma_doc, :currency_name;

     /* 05.08.2014 - Scrisoare la administratie */
     EXECUTE PROCEDURE SP_CREATE_MAIL_TO_SEND('web@fantastic.md','','Web comanda intr-un click',
                                              'Web comanda intr-un click. Data('||current_timestamp ||')<br><br>Client: <b>' || :USERFULLNAME || '</b><br/>' ||
                                              'Telefon: <b>' || :USERPHONE || '</b><br><br>' ||
                                              'Documentul generat: <b>' || :DOCID || '</b><br>'||
                                              'Suma documentului: <b>'||round(:suma_doc,2)||' '||:currency_name||'</b><br>'||
                                              'Produs: '||coalesce(:goods_list, '---'));

     delete from tmp$goodsqty;

   suspend;
END ^

SET TERM ; ^
COMMIT;

/* --- 8. drepturi: procedurile de comanda ruleaza cu drepturile lor proprii ------ */
GRANT EXECUTE ON PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO TO PROCEDURE WEB_CREATE_TRANSACTION3;
GRANT EXECUTE ON PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO TO PROCEDURE WEB_CREATE_TRANSACTION2_ECOMM;
GRANT EXECUTE ON PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO TO PROCEDURE WEB_CREATE_TRANSACTION_PHONE2;
GRANT EXECUTE ON FUNCTION FN_DEAL_WEB_PAYMENT_METHOD TO PROCEDURE WEB_CREATE_TRANSACTION3;
GRANT EXECUTE ON FUNCTION FN_DEAL_WEB_PAYMENT_METHOD TO PROCEDURE WEB_CREATE_TRANSACTION2_ECOMM;
GRANT EXECUTE ON FUNCTION FN_DEAL_WEB_PAYMENT_METHOD TO PROCEDURE WEB_CREATE_TRANSACTION_PHONE2;
GRANT EXECUTE ON PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO TO USER SWN;
GRANT EXECUTE ON PROCEDURE SP_DEAL_WEB_ORDER_INFO_BACKFILL TO USER SWN;
COMMIT;

/* --- 9. completarea deal-urilor existente (comenzile web din 2026) ----------------
   Doar campurile goale. Se poate rula separat, oricind: */
SELECT ORDERS_DONE FROM SP_DEAL_WEB_ORDER_INFO_BACKFILL('2026-01-01');
COMMIT;

/* ============================================================================
   Reducere de bun venit la prima comanda de pe site (popup "Cadou de bun venit")

   Vizitatorul neautentificat vede pe site un popup de inregistrare (telefon,
   parola). Dupa crearea contului primeste dreptul la o reducere procentuala
   (implicit 5%) la PRIMA comanda de pe site, valabila un numar de zile
   (implicit 30). Reducerea se aplica doar produselor:
     - fara actiune promotionala activa (W_GET_DISCOUNT_VALUE = 0) si
     - cu marja peste MIN_MARGIN % (implicit 18; site-ul o trimite din
       profilul de brand, signupOffer.minMargin). Marja = aceeasi ca in
       etichetele feed-ului Meta (FacebookFeed::marginLabels): pe rindul activ
       cel mai ieftin din TS_GOODS_FOREIGN, cost = PRICE0 (achizitie) sau, daca
       lipseste, PRICE7 (indicativ), in lei; marja% = (PRICE1 - cost) / PRICE1.
       Produsele fara cost nu primesc reducere.
   De aceea pe site textul e "pina la 5%".

   TWEB_SIGNUP_OFFER - dreptul la reducere, un rind per client:
       CUSTOMERID        clientul (TS_CUST_WEB / TS_CUSTOMER)
       SITEID            site-ul pe care s-a inregistrat (TWEB_SITE)
       DISCOUNT_PERCENT  procentul acordat
       CREATED_DATE / EXPIRES_DATE
       USED_DOCID / USED_DATE / USED_AMOUNT  comanda in care s-a folosit
       IP, SOURCE        de unde a venit inregistrarea (POPUP)

   WEB_SIGNUP_OFFER_MARGIN(GOODSID)
       marja procentuala a produsului (formula de mai sus), NULL fara cost.
   WEB_SIGNUP_OFFER_STATUS(CUSTOMERID, SHOP_CART_ID, MIN_MARGIN)
       starea dreptului + reducerea estimata pe cosul curent (TWEB_SHOP_CART),
       pentru pagina de finalizare. STATUS: OK / NONE / USED / EXPIRED /
       HAS_ORDERS (clientul are deja o comanda web, DOCTYPEID 134).
   WEB_SIGNUP_OFFER_APPLY(DOCID, CUSTOMERID, MIN_MARGIN)
       dupa WEB_CREATE_TRANSACTION3: recalculeaza reducerea pe liniile
       documentului, o scrie ca linie negativa pe serviciul 368756 (exact ca
       reducerea codului promotional din WEB_CREATE_TRANSACTION3) si marcheaza
       dreptul ca folosit. Idempotenta: a doua apelare pe acelasi document nu
       mai insereaza nimic. Totalul documentului (TDB_DOCS.SUMA) se reface prin
       trigger-ele de pe TDB_JURNAL, ca la linia promo.

   Apelate de site (utilizatorul WEBUSER). Fara acest script site-ul nu arata
   popup-ul (helpers/SignupOffer.php verifica existenta tabelei si a
   procedurilor).

   Script RE-RULABIL (14.10.2026; 15.10.2026: pragul de marja MIN_MARGIN).
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ------------------------------------------------------------ */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_SIGNUP_OFFER')) THEN
        EXECUTE STATEMENT '
            CREATE TABLE TWEB_SIGNUP_OFFER (
                CUSTOMERID        INTEGER       NOT NULL,
                SITEID            INTEGER,
                DISCOUNT_PERCENT  NUMERIC(5,2)  DEFAULT 5 NOT NULL,
                CREATED_DATE      TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
                EXPIRES_DATE      DATE          NOT NULL,
                USED_DOCID        INTEGER,
                USED_DATE         TIMESTAMP,
                USED_AMOUNT       NUMERIC(15,2),
                IP                VARCHAR(45),
                SOURCE            VARCHAR(32)   DEFAULT ''POPUP'',
                CONSTRAINT PK_TWEB_SIGNUP_OFFER PRIMARY KEY (CUSTOMERID)
            )';
END^

COMMIT^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IDX_TWEB_SIGNUP_OFFER_USED')) THEN
        EXECUTE STATEMENT 'CREATE INDEX IDX_TWEB_SIGNUP_OFFER_USED ON TWEB_SIGNUP_OFFER (USED_DOCID)';
END^

COMMIT^

/* --- 2. Marja produsului (ca FacebookFeed::marginLabels) ------------------ */
CREATE OR ALTER PROCEDURE WEB_SIGNUP_OFFER_MARGIN (
    GOODSID INTEGER)
RETURNS (
    PRICE_MDL  NUMERIC(15,2),
    COST_MDL   NUMERIC(15,2),
    MARGIN_PCT NUMERIC(9,2))
AS
BEGIN
    PRICE_MDL = NULL; COST_MDL = NULL; MARGIN_PCT = NULL;
    SELECT FIRST 1 GF.PRICE1,
           IIF(GF.PRICE0 > 0,
               GF.PRICE0 * (SELECT C.TRANSFER_RATE FROM TS_CURRENCY C WHERE C.CURRENCYID = GF.CURRENCY0ID),
               GF.PRICE7 * (SELECT C.TRANSFER_RATE FROM TS_CURRENCY C WHERE C.CURRENCYID = GF.CURRENCY7ID))
    FROM TS_GOODS_FOREIGN GF
    WHERE GF.GOODSID = :GOODSID AND GET_FLG_VALUE(GF.FLAGS, 3) = 1 AND GF.PRICE1 > 0
    ORDER BY GF.PRICE1
    INTO :PRICE_MDL, :COST_MDL;

    IF (COALESCE(PRICE_MDL, 0) > 0 AND COALESCE(COST_MDL, 0) > 0) THEN
        MARGIN_PCT = ROUND((PRICE_MDL - COST_MDL) / PRICE_MDL * 100, 2);
    SUSPEND;
END^

/* --- 3. Starea + reducerea estimata pe cos -------------------------------- */
CREATE OR ALTER PROCEDURE WEB_SIGNUP_OFFER_STATUS (
    CUSTOMERID   INTEGER,
    SHOP_CART_ID VARCHAR(60) = NULL,
    MIN_MARGIN   NUMERIC(9,2) = 18)
RETURNS (
    STATUS           VARCHAR(16),
    DISCOUNT_PERCENT NUMERIC(5,2),
    EXPIRES_DATE     DATE,
    ELIGIBLE_SUM     NUMERIC(15,2),
    DISCOUNT         NUMERIC(15,2))
AS
    DECLARE VARIABLE USED_DOCID INTEGER;
    DECLARE VARIABLE GOODSID    INTEGER;
    DECLARE VARIABLE QTY        NUMERIC(15,3);
    DECLARE VARIABLE PRICE      NUMERIC(15,2);
    DECLARE VARIABLE PROMO      NUMERIC(15,2);
    DECLARE VARIABLE MARGIN     NUMERIC(9,2);
BEGIN
    STATUS = 'NONE';
    ELIGIBLE_SUM = 0;
    DISCOUNT = 0;

    SELECT O.DISCOUNT_PERCENT, O.EXPIRES_DATE, O.USED_DOCID
    FROM TWEB_SIGNUP_OFFER O
    WHERE O.CUSTOMERID = :CUSTOMERID
    INTO :DISCOUNT_PERCENT, :EXPIRES_DATE, :USED_DOCID;

    IF (ROW_COUNT = 0) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    IF (USED_DOCID IS NOT NULL) THEN
        STATUS = 'USED';
    ELSE IF (EXPIRES_DATE < CURRENT_DATE) THEN
        STATUS = 'EXPIRED';
    ELSE IF (EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID)) THEN
        STATUS = 'HAS_ORDERS';
    ELSE
        STATUS = 'OK';

    IF (STATUS <> 'OK') THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Cosul clientului: cel indicat (SHOP_CART_ID) sau, ca in
       SP_MK_APPLY_PROMOCODE_AUTHUSER, toate rindurile lui cu MAX(QTY) pe produs.
       Doar produsele de pe site (TWEB_CACHE_GOODS) fara actiune promotionala activa
       si cu marja peste MIN_MARGIN. */
    FOR SELECT C.GOODSID, MAX(C.QTY)
        FROM TWEB_SHOP_CART C
        WHERE C.CUSTOMERID = :CUSTOMERID
          AND (:SHOP_CART_ID IS NULL OR C.SHOP_CART_ID = :SHOP_CART_ID)
          AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS G WHERE G.GOODSID = C.GOODSID)
        GROUP BY C.GOODSID
        INTO :GOODSID, :QTY
    DO
    BEGIN
        IF (COALESCE(QTY, 0) <= 0) THEN QTY = 1;

        PROMO = 0;
        SELECT DISCOUNT_VALUE FROM W_GET_DISCOUNT_VALUE(:GOODSID) INTO :PROMO;
        IF (COALESCE(PROMO, 0) > 0) THEN CONTINUE;

        MARGIN = NULL;
        SELECT MARGIN_PCT FROM WEB_SIGNUP_OFFER_MARGIN(:GOODSID) INTO :MARGIN;
        IF (MARGIN IS NULL OR MARGIN <= COALESCE(:MIN_MARGIN, 0)) THEN CONTINUE;

        PRICE = 0;
        SELECT PRICE_MDL FROM GET_GOODS_PRICE(:GOODSID, 1, 498) INTO :PRICE;
        IF (COALESCE(PRICE, 0) <= 0) THEN CONTINUE;

        ELIGIBLE_SUM = ELIGIBLE_SUM + PRICE * QTY;
    END

    DISCOUNT = ROUND(ELIGIBLE_SUM * DISCOUNT_PERCENT / 100, 2);
    SUSPEND;
END^

/* --- 4. Aplicarea pe comanda ---------------------------------------------- */
CREATE OR ALTER PROCEDURE WEB_SIGNUP_OFFER_APPLY (
    DOCID      INTEGER,
    CUSTOMERID INTEGER,
    MIN_MARGIN NUMERIC(9,2) = 18)
RETURNS (
    STATUS   VARCHAR(16),
    DISCOUNT NUMERIC(15,2))
AS
    DECLARE VARIABLE PERCENT      NUMERIC(5,2);
    DECLARE VARIABLE EXPIRES_DATE DATE;
    DECLARE VARIABLE USED_DOCID   INTEGER;
    DECLARE VARIABLE GOODSID      INTEGER;
    DECLARE VARIABLE QTY          NUMERIC(15,3);
    DECLARE VARIABLE PRICE        NUMERIC(15,2);
    DECLARE VARIABLE PROMO        NUMERIC(15,2);
    DECLARE VARIABLE MARGIN       NUMERIC(9,2);
    DECLARE VARIABLE ELIGIBLE_SUM NUMERIC(15,2);
    DECLARE VARIABLE DTDEP        INTEGER;
    DECLARE VARIABLE CTDEP        INTEGER;
    DECLARE VARIABLE WARRANTY     INTEGER;
    DECLARE VARIABLE UMID         INTEGER;
BEGIN
    STATUS = 'NONE';
    DISCOUNT = 0;

    SELECT O.DISCOUNT_PERCENT, O.EXPIRES_DATE, O.USED_DOCID
    FROM TWEB_SIGNUP_OFFER O
    WHERE O.CUSTOMERID = :CUSTOMERID
    INTO :PERCENT, :EXPIRES_DATE, :USED_DOCID;

    IF (ROW_COUNT = 0) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Idempotent: deja aplicata pe acest document */
    IF (USED_DOCID = DOCID) THEN
    BEGIN
        STATUS = 'ALREADY';
        SELECT COALESCE(-1 * SUM(J.SUMA), 0) FROM TDB_JURNAL J
        WHERE J.DOCID = :DOCID AND J.GOODSID = 368756
        INTO :DISCOUNT;
        SUSPEND;
        EXIT;
    END

    IF (USED_DOCID IS NOT NULL) THEN
        STATUS = 'USED';
    ELSE IF (EXPIRES_DATE < CURRENT_DATE) THEN
        STATUS = 'EXPIRED';
    ELSE IF (NOT EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCID = :DOCID AND D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID)) THEN
        STATUS = 'NOT_FOUND';
    ELSE IF (EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID AND D.DOCID <> :DOCID)) THEN
        STATUS = 'HAS_ORDERS';
    ELSE
        STATUS = 'OK';

    IF (STATUS <> 'OK') THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Liniile comenzii: produsele de pe site, fara actiune promotionala activa,
       cu marja peste MIN_MARGIN, la pretul si cantitatea din document */
    ELIGIBLE_SUM = 0;
    FOR SELECT J.GOODSID, J.QTY, J.PRICE, J.DTDEP, J.CTDEP, J.WARRANTY
        FROM TDB_JURNAL J
        WHERE J.DOCID = :DOCID
          AND J.QTY > 0 AND J.PRICE > 0
          AND J.GOODSID <> 368756
          AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS G WHERE G.GOODSID = J.GOODSID)
        INTO :GOODSID, :QTY, :PRICE, :DTDEP, :CTDEP, :WARRANTY
    DO
    BEGIN
        PROMO = 0;
        SELECT DISCOUNT_VALUE FROM W_GET_DISCOUNT_VALUE(:GOODSID) INTO :PROMO;
        IF (COALESCE(PROMO, 0) > 0) THEN CONTINUE;
        MARGIN = NULL;
        SELECT MARGIN_PCT FROM WEB_SIGNUP_OFFER_MARGIN(:GOODSID) INTO :MARGIN;
        IF (MARGIN IS NULL OR MARGIN <= COALESCE(:MIN_MARGIN, 0)) THEN CONTINUE;
        ELIGIBLE_SUM = ELIGIBLE_SUM + PRICE * QTY;
    END

    DISCOUNT = ROUND(ELIGIBLE_SUM * PERCENT / 100, 2);
    IF (DISCOUNT <= 0) THEN
    BEGIN
        STATUS = 'NOTHING';
        SUSPEND;
        EXIT;
    END

    /* Depozitele si garantia - ca la liniile deja scrise de WEB_CREATE_TRANSACTION3 */
    SELECT FIRST 1 J.DTDEP, J.CTDEP, J.WARRANTY FROM TDB_JURNAL J
    WHERE J.DOCID = :DOCID
    INTO :DTDEP, :CTDEP, :WARRANTY;

    UMID = NULL;
    SELECT G.UMID FROM TS_GOODS G WHERE G.GOODSID = 368756 INTO :UMID;
    IF (UMID IS NULL) THEN UMID = 1;

    INSERT INTO TDB_JURNAL (
        DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID,
        GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS
    ) VALUES (
        :DOCID, :DTDEP, :CTDEP, -1,
        368756, 1, :UMID, -1 * :DISCOUNT, COALESCE(:WARRANTY, 0), 0, 1
    );

    UPDATE TWEB_SIGNUP_OFFER O
    SET O.USED_DOCID = :DOCID, O.USED_DATE = CURRENT_TIMESTAMP, O.USED_AMOUNT = :DISCOUNT
    WHERE O.CUSTOMERID = :CUSTOMERID;

    SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* --- 5. Drepturi ---------------------------------------------------------- */
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_MARGIN TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_MARGIN TO SWN;
GRANT SELECT, INSERT, UPDATE ON TWEB_SIGNUP_OFFER TO WEBUSER;
GRANT SELECT, INSERT, UPDATE, DELETE ON TWEB_SIGNUP_OFFER TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_STATUS TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_APPLY TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_STATUS TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_SIGNUP_OFFER_APPLY TO SWN;

/* Procedurile apelate din interior trebuie sa fie accesibile WEBUSER-ului
   (de regula sint deja, fiind folosite de site). */
GRANT EXECUTE ON PROCEDURE W_GET_DISCOUNT_VALUE TO WEBUSER;
GRANT EXECUTE ON PROCEDURE GET_GOODS_PRICE TO WEBUSER;
GRANT SELECT ON TS_GOODS_FOREIGN TO WEBUSER;
GRANT SELECT ON TS_CURRENCY TO WEBUSER;

COMMIT;

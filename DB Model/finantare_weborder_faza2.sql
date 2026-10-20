/* ============================================================================
   Unificarea Cererii de finantare (1791) cu Web-Order (134) - FAZA 2 (baza de date)
   NEURON Grup SRL, 10 octombrie 2026
   Plan: Documents/plan-unificare-finantare-weborder-2026-10-09.md

   CONDITII INAINTE DE RULARE
     1. Faza 0 rulata (DB Model/finantare_weborder_faza0.sql): PAY_INVOICE + comutatorul
        TS_API_CONFIG WEB_ORDERS / FIN_AS_WEBORDER = '0'.
     2. Noul SWN.exe (faza 1: fila "Credit" in Web-Order) instalat la toti operatorii.
   Scriptul NU porneste comutatorul. Dupa rulare totul merge ca inainte, cu exceptia
   analiticii de plata (punctul B). Comanda pe credit porneste abia cind
   FIN_AS_WEBORDER = '1' (Setari > Configurari API in WMS); oprirea se face tot de acolo,
   fara redeploy.

   CE FACE
   A. Functii noi (SQL SECURITY DEFINER):
      FN_PAY_DTSC, FN_PAY_IS_CREDIT, FN_WEB_PAYMENT_CODE, FN_FIN_AS_WEBORDER, FN_PHONE_LAST8.
   B. WEB_CREATE_TRANSACTION3 si WEB_CREATE_TRANSACTION_PHONE2 pun TDB_DOCS.DTSC dupa plata
      aleasa pe site (PAY_CASH / PAY_POS / PAY_INVOICE / PAY_QR_MIA / PAY_CREDIT ...).
      Inainte toate comenzile aveau DTSC = PAY_NONE. WEB_CREATE_TRANSACTION2_ECOMM pune deja
      5114 (PAY_ECOMM) si nu se schimba.
   C. SP_WEB_REGISTER_FINANTARE:
      - cu comutatorul 0: neschimbata (creeaza 1791);
      - cu comutatorul 1: creeaza Web-Order 134 cu DTSC PAY_CREDIT0 / PAY_CREDIT si dosarul
        in TWEB_CERERE_FINANTARE;
      - D3: daca site-ul trimite lista de produse (A_GOODSIDS) si exista o comanda 134
        deschisa din ultimele 72 h, pe credit, fara dosar, pe acelasi telefon si cu
        aceleasi produse, dosarul se ataseaza la ea in loc sa se creeze o comanda noua;
      - parametri noi la sfarsit, cu valori implicite (apelul de azi al site-ului ramane valid):
        A_GOODSIDS (coduri separate prin virgula), A_CUSTOMERID (clientul logat).
   D. SP_ADD_GOODS_FINANTARE: nu dubleaza un produs deja existent in document (cazul D3).
   E. Deal-uri:
      - SP_DEAL_ATTACH_DOC: comanda 134 venita din formularul de credit primeste deal-ul
        FINANCE_REQUEST (PAY_NONE + FIN_REQUESTED). "1 click" cu credit: deal SITE_CART_ORDER
        cu PAY_NONE;
      - SP_DEAL_RECALC_STATES: FIN_REQUESTED si cind comanda 134 are DTSC de credit, nu doar
        cind deal-ul contine un 1791;
      - TDB_DOCS_AU_DEAL: recalculeaza deal-ul si cind se schimba TDB_DOCS.DTSC.
   F. SP_TELEGRAM_BUILD_TEXT: o comanda 134 cu dosar apare ca "Comanda pe credit", cu suma,
      termenul, avansul si rata.

   Nu se schimba SP_DOCS_GET_MODIFY_FLAG. Verificarea dreptului in TRG_TDB_DOCS_BU0 e oricum
   fortata (requireModifyDOC = 1), iar userul 9 adauga deja linii pe 134 ("1 click").

   Script RE-RULABIL (CREATE OR ALTER). Testat pe o copie locala a schemei SW
   (C:\Temp\fintest\SWMETA.FDB). Procedurile sint copiate exact din SW, 10 oct 2026; daca
   intre timp s-au schimbat pe SW, regenerati scriptul.
   ============================================================================ */

SET TERM ^ ;

/* ---------- A. Functii ---------- */

/* SYSSID-ul analiticii de plata dupa cod (TS_SYSS grupa 26, VALUE_STR = PAY_*) */
CREATE OR ALTER FUNCTION FN_PAY_DTSC (A_CODE VARCHAR(32))
RETURNS INTEGER
SQL SECURITY DEFINER
AS
DECLARE V_ID INTEGER;
BEGIN
  IF (NULLIF(TRIM(A_CODE), '') IS NULL) THEN RETURN NULL;
  SELECT FIRST 1 SYSSID FROM TS_SYSS
   WHERE PARENTID = 26 AND VALUE_STR = TRIM(:A_CODE)
    INTO :V_ID;
  RETURN V_ID;
END^

/* 1 = analitica de plata e un credit (PAY_CREDIT0 / PAY_CREDIT) */
CREATE OR ALTER FUNCTION FN_PAY_IS_CREDIT (A_DTSC INTEGER)
RETURNS SMALLINT
SQL SECURITY DEFINER
AS
BEGIN
  IF (A_DTSC IS NULL) THEN RETURN 0;
  IF (EXISTS(SELECT 1 FROM TS_SYSS
              WHERE SYSSID = :A_DTSC AND PARENTID = 26
                AND VALUE_STR IN ('PAY_CREDIT0', 'PAY_CREDIT'))) THEN
    RETURN 1;
  RETURN 0;
END^

/* Codul PAY_* pentru plata aleasa pe site; aceleasi coduri de tip ca FN_DEAL_WEB_PAYMENT_METHOD */
CREATE OR ALTER FUNCTION FN_WEB_PAYMENT_CODE (A_SOURCE VARCHAR(16), A_TYPE INTEGER)
RETURNS VARCHAR(32)
SQL SECURITY DEFINER
AS
BEGIN
  IF (A_TYPE IS NULL) THEN RETURN NULL;
  IF (A_SOURCE = 'ONECLICK') THEN
    RETURN DECODE(A_TYPE, 0, 'PAY_CASH', 1, 'PAY_CREDIT', 2, 'PAY_QR_MIA', NULL);
  RETURN DECODE(A_TYPE, 0, 'PAY_CREDIT', 1, 'PAY_CASH', 2, 'PAY_POS', 3, 'PAY_ECOMM',
                        4, 'PAY_INVOICE', 5, 'PAY_QR_MIA', NULL);
END^

/* Comutatorul fazei 2: 1 = cererea de credit de pe site devine Web-Order 134 */
CREATE OR ALTER FUNCTION FN_FIN_AS_WEBORDER
RETURNS SMALLINT
SQL SECURITY DEFINER
AS
DECLARE V VARCHAR(255);
BEGIN
  SELECT FIRST 1 TRIM(PARAM_VALUE) FROM TS_API_CONFIG
   WHERE API_CODE = 'WEB_ORDERS' AND PARAM_NAME = 'FIN_AS_WEBORDER' AND FLG_ACTIVE = 1
    INTO :V;
  RETURN IIF(V = '1', 1, 0);
END^

/* Ultimele 8 cifre ale unui telefon (fara +373 / 0 / spatii / liniute): cheia de comparare */
CREATE OR ALTER FUNCTION FN_PHONE_LAST8 (A_PHONE VARCHAR(255))
RETURNS VARCHAR(8)
SQL SECURITY DEFINER
AS
DECLARE I INTEGER = 1;
DECLARE C CHAR(1);
DECLARE D VARCHAR(255) = '';
BEGIN
  IF (A_PHONE IS NULL) THEN RETURN NULL;
  WHILE (I <= CHAR_LENGTH(A_PHONE)) DO
  BEGIN
    C = SUBSTRING(A_PHONE FROM I FOR 1);
    IF (C BETWEEN '0' AND '9') THEN D = D || C;
    I = I + 1;
  END
  IF (CHAR_LENGTH(D) < 8) THEN RETURN NULL;
  RETURN RIGHT(D, 8);
END^

/* ---------- B. Analitica de plata pe comenzile din cos si "1 click" ---------- */

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

    /* Analitica de plata = plata aleasa pe site (TS_SYSS grupa 26, PAY_*); 10.10.2026 */
    DTSC = COALESCE(FN_PAY_DTSC(FN_WEB_PAYMENT_CODE('CART', :PAYMENT_TYPE)), :DTSC);

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

     /* Analitica de plata = plata aleasa (0 la primire, 1 credit, 2 MIA); 10.10.2026.
        Cu PAY_CREDIT deal-ul primeste FIN_REQUESTED (SP_DEAL_RECALC_STATES). */
     DTSC = COALESCE(FN_PAY_DTSC(FN_WEB_PAYMENT_CODE('ONECLICK', :PAYMENT_TYPE)), :DTSC);

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

     /* Plata in credit (20.10.2026): cererea de finantare se creeaza din start, doar cu
        numele, telefonul si suma; operatorul o completeaza din "Oferte" (click dreapta ->
        "Cerere de finantare / eCredit...") si o depune la eCredit. Vezi DB Model/ecredit_api.sql. */
     if (payment_type = 1 and not exists (select 1 from TWEB_CERERE_FINANTARE f where f.DOCID = :DOCID)) then
       INSERT INTO TWEB_CERERE_FINANTARE (DOCID, CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII,
                                          CONTACT_TELEFON, FLG_COPY_BY_FAX)
       VALUES (:DOCID, COALESCE(:suma_doc, 0), NULL, COALESCE(:USERFULLNAME, ''), '', '',
               COALESCE(:USERPHONE, ''), 0);

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

/* ---------- C. Cererea de credit de pe site ---------- */

CREATE OR ALTER PROCEDURE SP_WEB_REGISTER_FINANTARE (CREDIT_SUMA DM_PRICE NOT NULL,
CREDIT_PERIOADA DM_INTEGER_NN,
NPP DM_VARCHAR128 NOT NULL,
IDEN DM_VARCHAR16 NOT NULL,
DATA_NASTERII DM_VARCHAR10 NOT NULL,
CONTACT_TELEFON DM_VARCHAR255 NOT NULL,
FLG_COPY_BY_FAX DM_BOOLEAN_NN,
SCAN1 DM_BLOBIMAGE,
SCAN2 DM_BLOBIMAGE,
AVANS DM_PRICE = 0,
PLATA_LUNARA DM_PRICE = 0,
CREDIT_TYPE DM_VARCHAR32 = '',
ORG_ID DM_INTEGER = -1,
DELIVERYADDRESS DM_VARCHAR255 = '',
A_GOODSIDS VARCHAR(1000) = '',
A_CUSTOMERID INTEGER = -1)
RETURNS (DOCID DM_INTEGER)
SQL SECURITY DEFINER
AS 
declare variable TIP_CREDIT varchar(128);
declare variable V_FIRMA integer = 316910; /* firma comenzilor web, ca in WEB_CREATE_TRANSACTION3 / _PHONE2 */
declare variable V_DT integer;
declare variable V_DTDEP integer;
declare variable V_CTDEP integer;
declare variable V_DEF_DTSC integer;
declare variable V_CURRENCYID integer;
declare variable V_SC2 integer;
declare variable V_RATE double precision;
declare variable V_RATEUSD double precision;
declare variable V_DTSC integer;
declare variable V_PHONE8 varchar(8);
declare variable V_CAND integer;
declare variable V_LIST varchar(1010);
declare variable V_POS integer;
declare variable V_ITEM varchar(1010);
declare variable V_MISSING integer;
declare variable V_ATTACHED smallint = 0;
BEGIN
     /* pentru aceasta procedure trebuie UserContext de create */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9); /* WebUser */
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

     /* ================================================================
        Comutatorul FIN_AS_WEBORDER = 0: Cerere de finantare 1791 (codul de pina la 10.10.2026)
        ================================================================ */
     IF (FN_FIN_AS_WEBORDER() = 0) THEN
     BEGIN

    --    in autonomous transaction do
    --        insert into tdb_debug (text) values ('1. Cerere de finantare. Start.');

        /* create DOC, WebUser, FLG_ACNT */
        INSERT INTO TDB_DOCS
        (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, FLAGS)
        VALUES
        (316910 /* SOLUTII COMERCIALE SRL, 18.09.2026; inainte: iif(current_date>='17.09.2024', 307225, 218482) */, 286, 43, 43, 5108, 498, 1791, 9, 1, NULL, 2)
        RETURNING DOCID INTO :DOCID;

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('2. Cerere de finantare. creat document nou. DocID:'||:DOCID);

        select title from ts_finance_customer where uid=:org_id into :tip_credit;
        :tip_credit = coalesce(:tip_credit, 'NONE');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('3. Cerere de finantare. tip_credit: '||:tip_credit);

        /* create DOC comments */
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                             'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('4. Cerere de finantare. adaugam inregistrarea in tabelul TWEB_CRERE_FINANTARE.');

        /* create details */
        INSERT INTO TWEB_CERERE_FINANTARE
        (
         DOCID,
         CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
         FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
        )
        VALUES
        (
         :DOCID,
         :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
         :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
        );

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('5. Cerere de finantare. Adaugat cu succes.');


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('6. Cerere de finantare. Trimite scrisoare pe web@fantastic.md.');
        /* create EMail */
        INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
        VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),'Cerere de finantare de la '||coalesce(:NPP, ''),
                'Cerere de finantare din partea lui '||:NPP||'<br>'||
                'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
                'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
                'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
                'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
                'Tip credit: '||:tip_credit ||
                '<br><br>Contactati clientul!');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('7. Cerere de finantare. Generam eveniment.');

        /* create event */
        EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(316910,7,:NPP,:DOCID,9); /* WebUser */

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('8. Cerere de finantare. Trimitem SMS pe numarul de telefon :contact_telefon');

        insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
        values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

         SUSPEND;
         EXIT;
     END

     /* ================================================================
        Comutatorul = 1: comanda Web-Order 134 cu plata pe credit; dosarul ramine
        in TWEB_CERERE_FINANTARE (fila "Credit" din WMS)
        ================================================================ */
     V_DTSC = FN_PAY_DTSC(IIF(COALESCE(TRIM(:CREDIT_TYPE), '') SIMILAR TO '0+([.,]0+)?',
                              'PAY_CREDIT0', 'PAY_CREDIT'));

     select title from ts_finance_customer where uid=:org_id into :tip_credit;
     :tip_credit = coalesce(:tip_credit, 'NONE');

     /* D3: credit cerut din "1 click" si apoi prin formular -> dosarul merge pe comanda existenta.
        Conditii: 134 de pe site, deschisa, nestearsa, din ultimele 72 h, pe credit (analitica
        sau metoda de plata din deal), fara dosar, acelasi telefon (ultimele 8 cifre), si contine
        toate produsele cererii. Fara lista de produse (site-ul vechi) -> mereu comanda noua. */
     DOCID = NULL;
     V_PHONE8 = FN_PHONE_LAST8(:CONTACT_TELEFON);
     IF (COALESCE(TRIM(:A_GOODSIDS), '') <> '' AND V_PHONE8 IS NOT NULL) THEN
     BEGIN
         FOR SELECT D.DOCID
               FROM TDB_DOCS D
              WHERE D.DOCTYPEID = 134
                AND D.CREATED_BY = 9
                AND D.DELETED_DATE IS NULL
                AND COALESCE(GET_FLG_VALUE(D.FLAGS, 10), 0) = 0
                AND D.CREATED_DATE >= DATEADD(-72 HOUR TO CURRENT_TIMESTAMP)
                AND NOT EXISTS (SELECT 1 FROM TWEB_CERERE_FINANTARE F
                                 WHERE F.DOCID = D.DOCID
                                   AND COALESCE(F.IDEN, '') <> '')  /* stub-ul de la "1 click" (fara IDNP) se completeaza */
                AND (FN_PAY_IS_CREDIT(D.DTSC) = 1
                     OR EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                                  JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                                 WHERE DD.DOCID = D.DOCID
                                   AND UPPER(TRIM(DL.PAYMENT_METHOD)) STARTING WITH 'CREDIT'))
                AND (EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                               JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                              WHERE DD.DOCID = D.DOCID AND FN_PHONE_LAST8(DL.PHONE) = :V_PHONE8)
                     OR EXISTS (SELECT 1 FROM TWEB_TRANSACTION T
                                 WHERE T.DOCID = D.DOCID AND FN_PHONE_LAST8(T.PHONES) = :V_PHONE8))
              ORDER BY D.DOCID DESC
               INTO :V_CAND
         DO
         BEGIN
             /* toate produsele cererii trebuie sa fie deja in comanda */
             V_MISSING = 0;
             V_LIST = TRIM(:A_GOODSIDS) || ',';
             WHILE (V_LIST <> '' AND V_MISSING = 0) DO
             BEGIN
                 V_POS = POSITION(',' IN V_LIST);
                 V_ITEM = TRIM(SUBSTRING(V_LIST FROM 1 FOR V_POS - 1));
                 V_LIST = SUBSTRING(V_LIST FROM V_POS + 1);
                 IF (V_ITEM SIMILAR TO '[0-9]+') THEN
                     IF (NOT EXISTS (SELECT 1 FROM TDB_JURNAL J
                                      WHERE J.DOCID = :V_CAND AND J.GOODSID = CAST(:V_ITEM AS INTEGER))) THEN
                         V_MISSING = 1;
             END
             IF (V_MISSING = 0) THEN
             BEGIN
                 DOCID = V_CAND;
                 LEAVE;
             END
         END
     END

     IF (DOCID IS NOT NULL) THEN
     BEGIN
         /* comanda exista deja: devine comanda pe credit cu dosar */
         V_ATTACHED = 1;
         UPDATE TDB_DOCS SET DTSC = :V_DTSC
          WHERE DOCID = :DOCID AND :V_DTSC IS NOT NULL AND DTSC IS DISTINCT FROM :V_DTSC;
         SELECT DT FROM TDB_DOCS WHERE DOCID = :DOCID INTO :V_DT;
         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB',
             'Clientul a completat si formularul de credit: dosarul a fost atasat la aceasta comanda.');
     END
     ELSE
     BEGIN
         /* comanda noua: valorile implicite ale Web-Order-ului pentru firma web */
         SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
           FROM TS_DOCTYPES_DEFVALUES
          WHERE DOCTYPEID = 134 AND FIRMA = :V_FIRMA
           INTO :V_DT, :V_DTDEP, :V_CTDEP, :V_DEF_DTSC, :V_CURRENCYID, :V_SC2;
         V_DT = COALESCE(V_DT, V_FIRMA);
         V_DTDEP = COALESCE(V_DTDEP, 43);
         V_CTDEP = COALESCE(V_CTDEP, 43);
         V_CURRENCYID = COALESCE(V_CURRENCYID, 498);
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :V_CURRENCYID INTO :V_RATE;
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :V_RATEUSD;

         /* SP_DEAL_ATTACH_DOC (trigger-ul TDB_DOCS_AI_DEAL) citeste sursa: deal FINANCE_REQUEST */
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', 'FINANCE_REQUEST');
         INSERT INTO TDB_DOCS
         (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, SC2, FLAGS)
         VALUES
         (:V_DT, IIF(COALESCE(:A_CUSTOMERID, -1) > 0, :A_CUSTOMERID, 286), :V_DTDEP, :V_CTDEP,
          COALESCE(:V_DTSC, :V_DEF_DTSC, 5108), :V_CURRENCYID, 134, 9, COALESCE(:V_RATE, 1), :V_RATEUSD,
          :V_SC2, 2)
         RETURNING DOCID INTO :DOCID;
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', NULL);

         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'COMANDA PE CREDIT (formularul de credit)');
     END

     /* comentariile cererii (ca la 1791) */
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                          'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);

     /* dosarul de credit; UPDATE OR INSERT - comanda "1 click" cu plata in credit are deja un stub
        (WEB_CREATE_TRANSACTION_PHONE2), care se completeaza aici */
     UPDATE OR INSERT INTO TWEB_CERERE_FINANTARE
     (
      DOCID,
      CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
      FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
     )
     VALUES
     (
      :DOCID,
      :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
      :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
     )
     MATCHING (DOCID);

     /* datele comenzii in deal (nume, telefon, adresa, plata; UTM-ul din TWEB_ORDER_UTM).
        La comanda existenta (D3) nu se suprascrie ce a venit din "1 click". */
     EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :NPP, :CONTACT_TELEFON,
         NULLIF(TRIM(:DeliveryAddress), ''), NULL, 'Credit', NULL, NULL, NULL, NULL, NULL,
         IIF(:V_ATTACHED = 1, 0, 1));

     /* e-mail */
     INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
     VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),
             'Comanda pe credit #' || :DOCID || ' de la '||coalesce(:NPP, ''),
             IIF(:V_ATTACHED = 1, 'Dosar de credit atasat la comanda existenta #' || :DOCID || '<br>',
                                  'Comanda pe credit (Web-Order) #' || :DOCID || '<br>') ||
             'Cerere de finantare din partea lui '||:NPP||'<br>'||
             'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
             'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
             'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
             'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
             'Tip credit: '||:tip_credit ||
             '<br><br>Contactati clientul!');

     /* eveniment 7 = cerere de credit (sunetul si reincarcarea in WMS: frame24 si frame51) */
     EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(COALESCE(:V_DT, :V_FIRMA), 7, :NPP, :DOCID, 9); /* WebUser */

     insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
     values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

     SUSPEND;
END ^

/* ---------- D. Produsele cererii de credit ---------- */

CREATE OR ALTER PROCEDURE SP_ADD_GOODS_FINANTARE (DOCID DM_INTEGER,
GOODSID DM_INTEGER,
QTY DM_QTY,
PRICE DM_PRICE)
SQL SECURITY DEFINER
AS 
declare UMID DM_INTEGER;
declare WARANTY DM_INTEGER;
declare V_CREDIT_TYPE DM_VARCHAR32;
declare V_PRICE_CREDIT0 DM_AMOUNT;
declare V_PRICE_SITE DM_PRICE;
begin
  /* Procedure Text */
  /* pentru aceasta procedure trebuie UserContext de create */
  rdb$set_context('USER_SESSION', 'UserID', 9);/* WebUser */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  select UMID, G.WARRANTY
  from TS_GOODS G
  where GOODSID = :GOODSID
  into :UMID, :WARANTY;

  V_PRICE_SITE = :PRICE;

  /* credit 0%: se finanteaza pretul de rate, care poate depasi pretul cash
     (acopera comisionul bancii). Acelasi calcul ca optiunea 0% din
     WEB_GET_GOODS_CREDIT_MONTLY_RATE, rotunjit ca pe site. */
  select trim(F.CREDIT_TYPE)
  from TWEB_CERERE_FINANTARE F
  where F.DOCID = :DOCID
  into :V_CREDIT_TYPE;

  if (:V_CREDIT_TYPE similar to '0+([.,]0+)?') then
  begin
    select C.PRICE_MDL
    from GET_GOODS_PRICE_CREDIT0(:GOODSID) C
    into :V_PRICE_CREDIT0;

    if (coalesce(:V_PRICE_CREDIT0, 0) > 0) then
      PRICE = round(:V_PRICE_CREDIT0, 0);
  end

  /* dosarul a fost atasat la o comanda existenta care are deja produsul (D3, 10.10.2026) */
  if (exists(select 1 from TDB_JURNAL J where J.DOCID = :DOCID and J.GOODSID = :GOODSID)) then
    exit;

  insert into TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, WARRANTY, STOCK_QTY)
  values (:DOCID, 43, -1, -1, :GOODSID, :umid, :qty,  :PRICE, :WARANTY, 0);

  insert into tdb_debug(text)
  values ('Cerere finantare nr '||:DOCID||','||
          'Goodsid='||:GoodsID||', '||
          'QTY='||:qty||', '||
          'PRICE='||:price||
          iif(:PRICE is distinct from :V_PRICE_SITE,
              ', credit 0% (pret site='||coalesce(:V_PRICE_SITE, 0)||')', '')
  );
end ^

/* ---------- E. Deal-uri ---------- */

CREATE OR ALTER PROCEDURE SP_DEAL_ATTACH_DOC (A_DOCID INTEGER,
A_USER_ID INTEGER = NULL)
RETURNS (O_DEAL_ID BIGINT,
O_ACTION VARCHAR(16) CHARACTER SET UTF8)
SQL SECURITY DEFINER
AS 
DECLARE V_TYPE INTEGER;
DECLARE V_PARENT INTEGER;
DECLARE V_DELETED TIMESTAMP;
DECLARE V_CUR INTEGER;
DECLARE V_NEXT INTEGER;
DECLARE V_LVL INTEGER;
DECLARE V_ROOT INTEGER;
DECLARE V_STOP INTEGER;
DECLARE V_RTYPE INTEGER;
DECLARE V_CT INTEGER;
DECLARE V_CURRENCYID INTEGER;
DECLARE V_OPERATOR INTEGER;
DECLARE V_DATA TIMESTAMP;
DECLARE V_NAME VARCHAR(120);
DECLARE V_PHONE VARCHAR(40);
DECLARE V_REF VARCHAR(64);
DECLARE V_INS SMALLINT;
DECLARE V_LINK VARCHAR(32);
DECLARE V_RDTSC INTEGER;
DECLARE V_CREDIT SMALLINT;
BEGIN
    O_DEAL_ID = NULL;
    O_ACTION = 'SKIP';

    SELECT DOCTYPEID, PARENTDOCID, DELETED_DATE FROM TDB_DOCS WHERE DOCID = :A_DOCID
    INTO :V_TYPE, :V_PARENT, :V_DELETED;

    IF (V_TYPE IS NULL OR V_DELETED IS NOT NULL) THEN EXIT;
    IF (V_TYPE NOT IN (101, 107, 110, 112, 115, 116, 117, 119, 120, 126, 128, 134, 1199, 1791)) THEN EXIT;

    SELECT MIN(DEAL_ID) FROM TDB_DEAL_DOCS WHERE DOCID = :A_DOCID INTO :O_DEAL_ID;
    IF (O_DEAL_ID IS NOT NULL) THEN
    BEGIN
        O_ACTION = 'EXISTS';
        EXIT;
    END

    /* urcam: cautam un deal; retinem cel mai de sus document "radacina" */
    V_ROOT = NULL;
    IF (V_TYPE IN (134, 1791, 115, 101, 107)) THEN V_ROOT = A_DOCID;
    V_CUR = V_PARENT;
    IF (V_CUR = A_DOCID) THEN V_CUR = NULL;
    V_LVL = 0;
    WHILE (V_CUR IS NOT NULL AND V_LVL < 10 AND O_DEAL_ID IS NULL) DO
    BEGIN
        V_RTYPE = NULL;  V_NEXT = NULL;  V_DELETED = NULL;
        SELECT DOCTYPEID, PARENTDOCID, DELETED_DATE FROM TDB_DOCS WHERE DOCID = :V_CUR
        INTO :V_RTYPE, :V_NEXT, :V_DELETED;
        IF (V_RTYPE IS NULL) THEN
            V_CUR = NULL;                      /* parintele nu exista = capat de lant */
        ELSE
        BEGIN
            SELECT MIN(DEAL_ID) FROM TDB_DEAL_DOCS WHERE DOCID = :V_CUR INTO :O_DEAL_ID;
            IF (O_DEAL_ID IS NULL) THEN
            BEGIN
                IF (V_DELETED IS NULL AND V_RTYPE IN (134, 1791, 115, 101, 107)) THEN
                    V_ROOT = V_CUR;
                IF (V_NEXT = V_CUR) THEN V_NEXT = NULL;
                V_CUR = V_NEXT;
            END
        END
        V_LVL = V_LVL + 1;
    END

    V_STOP = NULL;
    IF (O_DEAL_ID IS NOT NULL) THEN
        O_ACTION = 'BOUND';
    ELSE
    BEGIN
        IF (V_ROOT IS NULL) THEN               /* plata / factura / retur fara lant */
        BEGIN
            IF (V_TYPE IN (116, 120)) THEN
            BEGIN
                EXECUTE PROCEDURE SP_DEAL_MATCH_PAYMENT(:A_DOCID, :A_USER_ID)
                    RETURNING_VALUES :O_DEAL_ID, :V_LVL;
                IF (O_DEAL_ID IS NOT NULL) THEN O_ACTION = 'MATCHED';
            END
            EXIT;
        END

        SELECT d.DOCTYPEID, d.CT, d.CURRENCYID, COALESCE(d.RESPONSIBLE_USERID, d.CREATED_BY), d.DATA, d.DTSC
        FROM TDB_DOCS d WHERE d.DOCID = :V_ROOT
        INTO :V_RTYPE, :V_CT, :V_CURRENCYID, :V_OPERATOR, :V_DATA, :V_RDTSC;
        V_CREDIT = FN_PAY_IS_CREDIT(:V_RDTSC);

        V_NAME = NULL;
        SELECT LEFT(COALESCE(NULLIF(TRIM(c.DISPLAYNAME), ''), TRIM(c.NAME)), 120)
        FROM TS_CUSTOMER c WHERE c.CUSTOMERID = :V_CT
        INTO :V_NAME;

        IF (NOT EXISTS(SELECT 1 FROM TS_CUSTOMER c WHERE c.CUSTOMERID = :V_CT)) THEN
        BEGIN
            EXECUTE PROCEDURE SP_DEAL_LOG_ERROR('ATTACH_NO_CUSTOMER', :A_DOCID, NULL, NULL, NULL,
                'Documentul radacina ' || :V_ROOT || ' are CT=' || COALESCE(:V_CT, -1) ||
                ' care nu exista in TS_CUSTOMER');
            EXIT;
        END

        V_PHONE = NULL;
        SELECT FIRST 1 LEFT(TRIM(p.PHONENUMBER), 40) FROM TDB_DOCS_PHONES p
        WHERE p.DOCID = :V_ROOT AND NULLIF(TRIM(p.PHONENUMBER), '') IS NOT NULL
        INTO :V_PHONE;

        V_REF = CAST(V_ROOT AS VARCHAR(64));
        V_OPERATOR = COALESCE(V_OPERATOR, A_USER_ID);

        IF (V_RTYPE = 134 AND V_CREDIT = 1
            AND RDB$GET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE') = 'FINANCE_REQUEST') THEN
            /* comanda pe credit din formularul de credit (SP_WEB_REGISTER_FINANTARE, FIN_AS_WEBORDER = 1):
               acelasi deal ca o cerere de finantare - PAY_NONE + FIN_REQUESTED */
            SELECT O_DEAL_ID FROM SP_DEAL_CREATE_FROM_FIN_REQUEST(
                :V_REF, :V_CT, :V_NAME, :V_PHONE, NULL, NULL, NULL, NULL, NULL, :V_OPERATOR, NULL)
            INTO :O_DEAL_ID;
        ELSE IF (V_RTYPE = 134) THEN
        BEGIN
            SELECT O_DEAL_ID FROM SP_DEAL_CREATE_FROM_SITE_CART(
                :V_REF, :V_CT, :V_NAME, :V_PHONE, NULL, NULL, NULL, :V_CURRENCYID, :V_OPERATOR, NULL)
            INTO :O_DEAL_ID;
            /* plata pe credit ("1 click" cu credit): banii vin de la banca, nu de la client */
            IF (V_CREDIT = 1) THEN
                UPDATE TDB_DEALS
                   SET PAY_STATE_ID = (SELECT STATE_ID FROM SP_DEAL_GET_STATE_ID('PAY_NONE'))
                 WHERE DEAL_ID = :O_DEAL_ID;
        END
        ELSE IF (V_RTYPE = 1791) THEN
            SELECT O_DEAL_ID FROM SP_DEAL_CREATE_FROM_FIN_REQUEST(
                :V_REF, :V_CT, :V_NAME, :V_PHONE, NULL, NULL, NULL, NULL, NULL, :V_OPERATOR, NULL)
            INTO :O_DEAL_ID;
        ELSE IF (V_RTYPE = 115) THEN
            SELECT O_DEAL_ID FROM SP_DEAL_CREATE_MANUAL_OFFER(
                :V_REF, :V_CT, :V_NAME, :V_PHONE, NULL, :V_CURRENCYID, :V_OPERATOR, NULL, NULL)
            INTO :O_DEAL_ID;
        ELSE
            SELECT O_DEAL_ID FROM SP_DEAL_CREATE_DIRECT_SALE(
                :V_REF, :V_CT, :V_NAME, :V_PHONE, NULL, :V_CURRENCYID, :V_OPERATOR, NULL)
            INTO :O_DEAL_ID;

        /* deal-ul incepe la data documentului radacina (conteaza la backfill) */
        UPDATE TDB_DEALS SET CREATED_AT = :V_DATA
        WHERE DEAL_ID = :O_DEAL_ID AND :V_DATA IS NOT NULL AND :V_DATA < CREATED_AT;

        V_STOP = V_ROOT;
        O_ACTION = 'CREATED';
    END

    /* legam documentul si verigile nelegate de deasupra lui */
    V_CUR = A_DOCID;
    V_LVL = 0;
    WHILE (V_CUR IS NOT NULL AND V_LVL <= 10) DO
    BEGIN
        V_RTYPE = NULL;  V_NEXT = NULL;  V_DELETED = NULL;
        IF (EXISTS(SELECT 1 FROM TDB_DEAL_DOCS WHERE DEAL_ID = :O_DEAL_ID AND DOCID = :V_CUR)) THEN
            V_CUR = NULL;
        ELSE
        BEGIN
            SELECT DOCTYPEID, PARENTDOCID, DELETED_DATE FROM TDB_DOCS WHERE DOCID = :V_CUR
            INTO :V_RTYPE, :V_NEXT, :V_DELETED;
            IF (V_RTYPE IS NULL) THEN
                V_CUR = NULL;
            ELSE
            BEGIN
                IF (V_DELETED IS NULL AND V_RTYPE IN
                    (101, 107, 110, 112, 115, 116, 117, 119, 120, 126, 128, 134, 1199, 1791)) THEN
                    SELECT IS_INSERTED, USED_LINK_TYPE
                    FROM SP_DEAL_BIND_DOC(:O_DEAL_ID, :V_CUR, NULL, :A_USER_ID, NULL)
                    INTO :V_INS, :V_LINK;
                IF (V_CUR = V_STOP OR V_NEXT = V_CUR) THEN V_NEXT = NULL;
                V_CUR = V_NEXT;
            END
        END
        V_LVL = V_LVL + 1;
    END

    EXECUTE PROCEDURE SP_DEAL_RECALC_STATES(:O_DEAL_ID, :A_USER_ID);
END ^

CREATE OR ALTER PROCEDURE SP_DEAL_RECALC_STATES (A_DEAL_ID BIGINT,
A_USER_ID INTEGER = NULL)
SQL SECURITY DEFINER
AS 
DECLARE V_FLAGS INTEGER;
DECLARE V_PIPE INTEGER;
DECLARE V_PAY INTEGER;
DECLARE V_FIN INTEGER;
DECLARE V_DLV INTEGER;
DECLARE V_CLOSED_AT TIMESTAMP;
DECLARE V_CLOSED_RESULT VARCHAR(16);
DECLARE V_PHONE VARCHAR(40);
DECLARE V_ADDRESS VARCHAR(500);
DECLARE V_PIPE_CODE VARCHAR(32);
DECLARE V_PIPE_SORT INTEGER;
DECLARE V_PIPE_FINAL SMALLINT;
DECLARE V_PIPE_CANCEL SMALLINT;
DECLARE V_PAY_CODE VARCHAR(32);
DECLARE V_FIN_CODE VARCHAR(32);
DECLARE V_DLV_CODE VARCHAR(32);
DECLARE V_DLV_SORT INTEGER;
DECLARE V_DLV_FINAL SMALLINT;
DECLARE N_TOTAL INTEGER;
DECLARE N_LIVE INTEGER;
DECLARE N_WORK INTEGER;
DECLARE N_SALE INTEGER;
DECLARE N_FIN INTEGER;
DECLARE S_SALE DOUBLE PRECISION;
DECLARE S_PROFORMA DOUBLE PRECISION;
DECLARE S_PAID DOUBLE PRECISION;
DECLARE S_TOTAL DOUBLE PRECISION;
DECLARE N_DLV_ROWS INTEGER;
DECLARE N_DLV_SENT INTEGER;
DECLARE V_NEW_CODE VARCHAR(32);
DECLARE V_NEW_ID INTEGER;
DECLARE V_NEW_SORT INTEGER;
DECLARE V_NEW_PHONE VARCHAR(40);
DECLARE V_NEW_ADDRESS VARCHAR(500);
DECLARE V_DTSC_C0 INTEGER;
DECLARE V_DTSC_C INTEGER;
BEGIN
    SELECT d.FLAGS, d.PIPE_STATE_ID, d.PAY_STATE_ID, d.FIN_STATE_ID, d.DLV_STATE_ID,
           d.CLOSED_AT, d.CLOSED_RESULT, d.PHONE, d.DELIVERY_ADDRESS
    FROM TDB_DEALS d WHERE d.DEAL_ID = :A_DEAL_ID
    INTO :V_FLAGS, :V_PIPE, :V_PAY, :V_FIN, :V_DLV,
         :V_CLOSED_AT, :V_CLOSED_RESULT, :V_PHONE, :V_ADDRESS;

    IF (V_PIPE IS NULL) THEN EXIT;
    /* comanda 134 cu analitica de credit = cerere de finantare (unificarea 1791 -> 134) */
    V_DTSC_C0 = FN_PAY_DTSC('PAY_CREDIT0');
    V_DTSC_C = FN_PAY_DTSC('PAY_CREDIT');
    V_FLAGS = COALESCE(V_FLAGS, 0);

    /* documentele deal-ului */
    SELECT COUNT(*),
           SUM(CASE WHEN d.DELETED_DATE IS NULL THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID IN (115, 101) THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID = 107 THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND (d.DOCTYPEID = 1791
                    OR (d.DOCTYPEID = 134 AND d.DTSC IN (:V_DTSC_C0, :V_DTSC_C))) THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NOT NULL THEN 0
                    WHEN d.DOCTYPEID = 107 THEN  d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1)
                    WHEN d.DOCTYPEID = 110 THEN -d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1)
                    ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID = 101
                    THEN d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1) ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NOT NULL THEN 0
                    WHEN d.DOCTYPEID IN (116, 120)
                        THEN  COALESCE(dd.LINK_SUM, d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1))
                    WHEN d.DOCTYPEID IN (117, 119, 1199)
                        THEN -COALESCE(dd.LINK_SUM, d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1))
                    ELSE 0 END)
    FROM TDB_DEAL_DOCS dd
    JOIN TDB_DOCS d ON d.DOCID = dd.DOCID
    WHERE dd.DEAL_ID = :A_DEAL_ID
    INTO :N_TOTAL, :N_LIVE, :N_WORK, :N_SALE, :N_FIN, :S_SALE, :S_PROFORMA, :S_PAID;

    N_TOTAL = COALESCE(N_TOTAL, 0);  N_LIVE = COALESCE(N_LIVE, 0);
    N_WORK = COALESCE(N_WORK, 0);    N_SALE = COALESCE(N_SALE, 0);
    N_FIN = COALESCE(N_FIN, 0);
    S_SALE = COALESCE(S_SALE, 0);    S_PROFORMA = COALESCE(S_PROFORMA, 0);
    S_PAID = COALESCE(S_PAID, 0);

    /* livrare + date de contact lipsa */
    SELECT COUNT(*),
           SUM(CASE WHEN dl.TRANSMIS_CURIER IS NOT NULL
                      OR NULLIF(TRIM(dl.AWB), '') IS NOT NULL THEN 1 ELSE 0 END),
           MAX(NULLIF(TRIM(dl.DELIVERY_ADDRESS), ''))
    FROM TDB_DEAL_DOCS dd
    JOIN TDB_DOCS d ON d.DOCID = dd.DOCID AND d.DELETED_DATE IS NULL
    JOIN TDB_DOCS_DELIVERY dl ON dl.DOCID = d.DOCID
    WHERE dd.DEAL_ID = :A_DEAL_ID
    INTO :N_DLV_ROWS, :N_DLV_SENT, :V_NEW_ADDRESS;
    N_DLV_ROWS = COALESCE(N_DLV_ROWS, 0);  N_DLV_SENT = COALESCE(N_DLV_SENT, 0);

    IF (V_ADDRESS IS NULL AND V_NEW_ADDRESS IS NOT NULL) THEN
        UPDATE TDB_DEALS SET DELIVERY_ADDRESS = LEFT(:V_NEW_ADDRESS, 500)
        WHERE DEAL_ID = :A_DEAL_ID;

    IF (V_PHONE IS NULL) THEN
    BEGIN
        SELECT FIRST 1 LEFT(TRIM(p.PHONENUMBER), 40)
        FROM TDB_DEAL_DOCS dd
        JOIN TDB_DOCS_PHONES p ON p.DOCID = dd.DOCID
        WHERE dd.DEAL_ID = :A_DEAL_ID AND NULLIF(TRIM(p.PHONENUMBER), '') IS NOT NULL
        ORDER BY dd.DOCID
        INTO :V_NEW_PHONE;
        IF (V_NEW_PHONE IS NOT NULL) THEN
            UPDATE TDB_DEALS SET PHONE = :V_NEW_PHONE WHERE DEAL_ID = :A_DEAL_ID;
    END

    IF (V_PHONE IS NULL AND V_NEW_PHONE IS NULL) THEN
        EXECUTE PROCEDURE SP_DEAL_SYNC_CONTACT(:A_DEAL_ID);

    SELECT CODE FROM TS_DEAL_STATES WHERE STATE_ID = :V_PAY INTO :V_PAY_CODE;
    SELECT CODE FROM TS_DEAL_STATES WHERE STATE_ID = :V_FIN INTO :V_FIN_CODE;

    /* ---- FIN ---- */
    IF (BIN_AND(V_FLAGS, 4) = 0 AND N_FIN > 0
        AND (V_FIN_CODE IS NULL OR V_FIN_CODE = 'FIN_NONE')) THEN
    BEGIN
        SELECT STATE_ID FROM SP_DEAL_GET_STATE_ID('FIN_REQUESTED') INTO :V_NEW_ID;
        EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'FIN', :V_NEW_ID, :A_USER_ID, 'AUTO');
        V_FIN_CODE = 'FIN_REQUESTED';
    END

    /* ---- PAY ---- */
    IF (BIN_AND(V_FLAGS, 2) = 0) THEN
    BEGIN
        S_TOTAL = CASE WHEN S_SALE <> 0 THEN S_SALE ELSE S_PROFORMA END;
        V_NEW_CODE = NULL;
        IF (S_PAID > 0.005) THEN
            V_NEW_CODE = CASE WHEN S_TOTAL > 0.005 AND S_PAID >= S_TOTAL - 0.005
                              THEN 'PAY_PAID' ELSE 'PAY_PARTIAL' END;
        ELSE IF (V_PAY_CODE IS NULL OR V_PAY_CODE IN ('PAY_PARTIAL', 'PAY_PAID')) THEN
            V_NEW_CODE = 'PAY_WAITING';
        /* PAY_NONE / PAY_WAITING / PAY_FAILED fara incasari raman cum sunt */

        IF (V_NEW_CODE IS NOT NULL AND V_NEW_CODE IS DISTINCT FROM V_PAY_CODE) THEN
        BEGIN
            SELECT STATE_ID FROM SP_DEAL_GET_STATE_ID(:V_NEW_CODE) INTO :V_NEW_ID;
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'PAY', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_PAY_CODE = V_NEW_CODE;
        END
    END

    /* ---- DLV: doar inainte, niciodata peste o stare finala sau DLV_FAILED ---- */
    SELECT CODE, SORT_ORDER, IS_FINAL FROM TS_DEAL_STATES WHERE STATE_ID = :V_DLV
    INTO :V_DLV_CODE, :V_DLV_SORT, :V_DLV_FINAL;

    IF (BIN_AND(V_FLAGS, 8) = 0 AND N_DLV_ROWS > 0 AND COALESCE(V_DLV_FINAL, 0) = 0) THEN
    BEGIN
        V_NEW_CODE = CASE WHEN N_DLV_SENT > 0 THEN 'DLV_IN_TRANSIT' ELSE 'DLV_PREPARING' END;
        V_NEW_ID = NULL;
        SELECT STATE_ID, SORT_ORDER FROM TS_DEAL_STATES
        WHERE CODE = :V_NEW_CODE AND IS_ACTIVE = 1
        INTO :V_NEW_ID, :V_NEW_SORT;
        IF (V_NEW_ID IS NOT NULL AND V_NEW_SORT > COALESCE(V_DLV_SORT, 0)) THEN
        BEGIN
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'DLV', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_DLV_CODE = V_NEW_CODE;
        END
    END

    /* ---- PIPE ---- */
    SELECT CODE, SORT_ORDER, IS_FINAL, IS_CANCEL FROM TS_DEAL_STATES WHERE STATE_ID = :V_PIPE
    INTO :V_PIPE_CODE, :V_PIPE_SORT, :V_PIPE_FINAL, :V_PIPE_CANCEL;

    IF (BIN_AND(V_FLAGS, 1) = 0 AND COALESCE(V_PIPE_FINAL, 0) = 0) THEN
    BEGIN
        IF (N_LIVE = 0) THEN               /* toate sterse (si fizic: N_TOTAL = 0) */
            V_NEW_CODE = 'PIPE_CANCELLED_BY_SHOP';
        ELSE IF (V_DLV_CODE = 'DLV_DELIVERED') THEN
            V_NEW_CODE = 'PIPE_DELIVERED';
        ELSE IF (V_DLV_CODE = 'DLV_IN_TRANSIT') THEN
            V_NEW_CODE = 'PIPE_ON_DELIVERY';
        ELSE IF (N_SALE > 0) THEN
            V_NEW_CODE = 'PIPE_READY_TO_SHIP';
        ELSE IF (N_WORK > 0) THEN
            V_NEW_CODE = 'PIPE_IN_WORK';
        ELSE
            V_NEW_CODE = 'PIPE_WAITING_CHECK';

        V_NEW_ID = NULL;
        SELECT STATE_ID, SORT_ORDER FROM TS_DEAL_STATES
        WHERE CODE = :V_NEW_CODE AND IS_ACTIVE = 1
        INTO :V_NEW_ID, :V_NEW_SORT;

        /* etapa avanseaza automat DOAR inainte: o etapa aleasa de om in
           documentul WMS (ex. "In lucru" pe un Web-Order) nu e readusa inapoi,
           iar documentele noi o duc mai departe (vanzare -> gata de expediere) */
        IF (V_NEW_ID IS NOT NULL AND V_NEW_CODE IS DISTINCT FROM V_PIPE_CODE
            AND V_NEW_SORT > COALESCE(V_PIPE_SORT, 0)) THEN
        BEGIN
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'PIPE', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_PIPE_CODE = V_NEW_CODE;
            SELECT IS_CANCEL FROM TS_DEAL_STATES WHERE STATE_ID = :V_NEW_ID INTO :V_PIPE_CANCEL;
        END
    END

    /* ---- inchidere / redeschidere ---- */
    IF (COALESCE(V_PIPE_CANCEL, 0) = 1) THEN
    BEGIN
        IF (V_CLOSED_AT IS NULL) THEN
            UPDATE TDB_DEALS SET CLOSED_AT = CURRENT_TIMESTAMP, CLOSED_RESULT = 'CANCEL',
                                 UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
            WHERE DEAL_ID = :A_DEAL_ID;
    END
    ELSE IF (V_PIPE_CODE = 'PIPE_DELIVERED'
             AND (V_PAY_CODE = 'PAY_PAID' OR V_FIN_CODE = 'FIN_DISBURSED')) THEN
    BEGIN
        IF (V_CLOSED_AT IS NULL) THEN
            UPDATE TDB_DEALS SET CLOSED_AT = CURRENT_TIMESTAMP, CLOSED_RESULT = 'SUCCESS',
                                 UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
            WHERE DEAL_ID = :A_DEAL_ID;
    END
    ELSE IF (V_CLOSED_AT IS NOT NULL AND V_CLOSED_RESULT IN ('SUCCESS', 'CANCEL')) THEN
        UPDATE TDB_DEALS SET CLOSED_AT = NULL, CLOSED_RESULT = NULL,
                             UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
        WHERE DEAL_ID = :A_DEAL_ID;
END ^

CREATE OR ALTER TRIGGER TDB_DOCS_AU_DEAL FOR TDB_DOCS 
ACTIVE AFTER UPDATE POSITION 900 
SQL SECURITY DEFINER
AS
DECLARE V_DEAL BIGINT;
DECLARE V_ACTION VARCHAR(16);
DECLARE V_FOUND SMALLINT;
BEGIN
    IF (NEW.DOCTYPEID IN (101, 107, 110, 112, 115, 116, 117, 119, 120, 126, 128, 134, 1199, 1791)
        AND (NEW.SUMA IS DISTINCT FROM OLD.SUMA
             OR NEW.RATE IS DISTINCT FROM OLD.RATE
             OR NEW.DELETED_DATE IS DISTINCT FROM OLD.DELETED_DATE
             OR NEW.PARENTDOCID IS DISTINCT FROM OLD.PARENTDOCID
             OR NEW.DOCTYPEID IS DISTINCT FROM OLD.DOCTYPEID
             OR NEW.STATEID IS DISTINCT FROM OLD.STATEID
             OR NEW.DTSC IS DISTINCT FROM OLD.DTSC)) THEN
    BEGIN
        V_FOUND = 0;
        FOR SELECT DEAL_ID FROM TDB_DEAL_DOCS WHERE DOCID = NEW.DOCID INTO :V_DEAL
        DO
        BEGIN
            V_FOUND = 1;
            EXECUTE PROCEDURE SP_DEAL_RECALC_STATES(:V_DEAL, NULL);
        END
        IF (V_FOUND = 0 AND NEW.DELETED_DATE IS NULL) THEN
            EXECUTE PROCEDURE SP_DEAL_ATTACH_DOC(NEW.DOCID, NEW.CREATED_BY)
                RETURNING_VALUES :V_DEAL, :V_ACTION;
        /* tranzitie: cat timp WMS mai scrie TDB_DOCS.STATEID (de scos la DROP STATEID) */
        IF (NEW.STATEID IS DISTINCT FROM OLD.STATEID AND NEW.DOCTYPEID IN (115, 134, 1791)) THEN
            EXECUTE PROCEDURE SP_DEAL_APPLY_DOC_STATE(NEW.DOCID, NULL, 'DOCSTATE', 0);
        WHEN ANY DO
            EXECUTE PROCEDURE SP_DEAL_LOG_ERROR('TDB_DOCS_AU_DEAL', NEW.DOCID, NULL,
                GDSCODE, SQLSTATE, LEFT(RDB$ERROR(MESSAGE), 1000));
    END
END ^

/* ---------- F. Mesajul Telegram ---------- */

CREATE OR ALTER PROCEDURE SP_TELEGRAM_BUILD_TEXT (SOURCE_TABLE INTEGER,
SOURCE_ID INTEGER)
RETURNS (MSG_TEXT VARCHAR(4096) CHARACTER SET UTF8,
PARSE_MODE VARCHAR(10) CHARACTER SET UTF8)
SQL SECURITY DEFINER
AS 
DECLARE NL CHAR(1);
DECLARE V_DOCTYPE INTEGER;
DECLARE V_SUMA NUMERIC(18,4);
DECLARE V_CUR VARCHAR(64);
DECLARE V_FIRMA VARCHAR(1024);
DECLARE V_DELETED TIMESTAMP;
DECLARE V_NAME VARCHAR(1024);
DECLARE V_PHONE VARCHAR(1024);
DECLARE V_PAY VARCHAR(1024);
DECLARE V_ADDR VARCHAR(1024);
DECLARE V_UTM VARCHAR(1024);
DECLARE V_CREDIT NUMERIC(18,4);
DECLARE V_MONTHS INTEGER;
DECLARE V_AVANS NUMERIC(18,4);
DECLARE V_LUNAR NUMERIC(18,4);
DECLARE V_TITLE VARCHAR(1024);
DECLARE V_QTY NUMERIC(18,4);
DECLARE V_LSUMA NUMERIC(18,4);
DECLARE V_N INTEGER = 0;
DECLARE V_TOTAL_LINES INTEGER;
BEGIN
  NL = ASCII_CHAR(10);
  MSG_TEXT = NULL;
  PARSE_MODE = 'HTML';

  IF (SOURCE_TABLE IN (134, 1791)) THEN
  BEGIN
    SELECT D.DOCTYPEID, D.SUMA, C.TITLE, F.NAME, D.DELETED_DATE
      FROM TDB_DOCS D
      LEFT JOIN TS_CURRENCY C ON C.CURRENCYID = D.CURRENCYID
      LEFT JOIN TS_CUSTOMER F ON F.CUSTOMERID = D.DT
     WHERE D.DOCID = :SOURCE_ID
      INTO :V_DOCTYPE, :V_SUMA, :V_CUR, :V_FIRMA, :V_DELETED;

    IF (V_DOCTYPE IS NULL OR V_DELETED IS NOT NULL) THEN
    BEGIN
      SUSPEND;
      EXIT;
    END

    /* contactul: deal-ul documentului (sincronizat din cos / "Cumpara acum") */
    SELECT FIRST 1 NULLIF(TRIM(DL.CONTACT_NAME), ''), NULLIF(TRIM(DL.PHONE), ''),
           NULLIF(TRIM(DL.PAYMENT_METHOD), ''), NULLIF(TRIM(DL.DELIVERY_ADDRESS), ''),
           NULLIF(TRIM(DL.UTM_SOURCE), '') || COALESCE(' / ' || NULLIF(TRIM(DL.UTM_CAMPAIGN), ''), '')
      FROM TDB_DEAL_DOCS DD
      JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
     WHERE DD.DOCID = :SOURCE_ID
     ORDER BY DD.DEAL_ID
      INTO :V_NAME, :V_PHONE, :V_PAY, :V_ADDR, :V_UTM;

    IF (V_DOCTYPE = 134) THEN
    BEGIN
      SELECT FIRST 1 COALESCE(NULLIF(TRIM(T.FULLNAME), ''), :V_NAME),
             COALESCE(NULLIF(TRIM(T.PHONES), ''), :V_PHONE)
        FROM RDB$DATABASE
        LEFT JOIN TWEB_TRANSACTION T ON T.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE;

      /* comanda pe credit cu dosar (FIN_AS_WEBORDER = 1): clientul si creditul din dosar */
      SELECT FIRST 1 COALESCE(:V_NAME, NULLIF(TRIM(CF.NPP), '')),
             COALESCE(:V_PHONE, NULLIF(TRIM(CF.CONTACT_TELEFON), '')),
             CF.CREDIT_SUMA, CF.CREDIT_PERIOADA, CF.AVANS, CF.PLATA_LUNARA
        FROM TWEB_CERERE_FINANTARE CF
       WHERE CF.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE, :V_CREDIT, :V_MONTHS, :V_AVANS, :V_LUNAR;

      IF (V_CREDIT IS NOT NULL) THEN
        MSG_TEXT = _UTF8 X'F09F92B3' || ' <b>Comanda pe credit de pe site #' || SOURCE_ID || '</b>';
      ELSE
        MSG_TEXT = _UTF8 X'F09F9B92' || ' <b>Comanda noua de pe site #' || SOURCE_ID || '</b>';
    END
    ELSE
    BEGIN
      SELECT FIRST 1 COALESCE(NULLIF(TRIM(CF.NPP), ''), :V_NAME),
             COALESCE(NULLIF(TRIM(CF.CONTACT_TELEFON), ''), :V_PHONE),
             CF.CREDIT_SUMA, CF.CREDIT_PERIOADA, CF.AVANS, CF.PLATA_LUNARA
        FROM RDB$DATABASE
        LEFT JOIN TWEB_CERERE_FINANTARE CF ON CF.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE, :V_CREDIT, :V_MONTHS, :V_AVANS, :V_LUNAR;

      MSG_TEXT = _UTF8 X'F09F92B3' || ' <b>Cerere de finantare #' || SOURCE_ID || '</b>';
    END

    IF (V_FIRMA IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Firma: ' || FN_TELEGRAM_HTML(V_FIRMA);
    IF (V_NAME IS NOT NULL OR V_PHONE IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Client: <b>' || FN_TELEGRAM_HTML(COALESCE(V_NAME, '-')) || '</b>'
                 || COALESCE(', <code>' || FN_TELEGRAM_HTML(V_PHONE) || '</code>', '');
    IF (V_DOCTYPE = 134 AND V_PAY IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Plata: ' || FN_TELEGRAM_HTML(V_PAY);
    IF (V_DOCTYPE = 134 AND V_ADDR IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Adresa: ' || FN_TELEGRAM_HTML(V_ADDR);
    IF (V_CREDIT IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Credit: ' || FN_TELEGRAM_MONEY(V_CREDIT) || ' ' || COALESCE(V_CUR, '')
                 || COALESCE(', ' || V_MONTHS || ' luni', '')
                 || IIF(COALESCE(V_AVANS, 0) <> 0, ', avans ' || FN_TELEGRAM_MONEY(V_AVANS), '')
                 || IIF(COALESCE(V_LUNAR, 0) <> 0, ', lunar ' || FN_TELEGRAM_MONEY(V_LUNAR), '');

    SELECT COUNT(*) FROM TDB_JURNAL J WHERE J.DOCID = :SOURCE_ID INTO :V_TOTAL_LINES;
    IF (V_TOTAL_LINES > 0) THEN
    BEGIN
      MSG_TEXT = MSG_TEXT || NL;
      FOR SELECT FIRST 10 G.TITLE, J.QTY, J.SUMA
            FROM TDB_JURNAL J
            JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
           WHERE J.DOCID = :SOURCE_ID
           ORDER BY J.SUMA DESC
          INTO :V_TITLE, :V_QTY, :V_LSUMA
      DO
      BEGIN
        V_N = V_N + 1;
        MSG_TEXT = MSG_TEXT || NL || _UTF8 X'E280A2' || ' ' || FN_TELEGRAM_HTML(LEFT(TRIM(V_TITLE), 150))
                   || IIF(V_QTY <> 1, ' x ' || FN_TELEGRAM_MONEY(V_QTY), '')
                   || ' - ' || FN_TELEGRAM_MONEY(V_LSUMA);
      END
      IF (V_TOTAL_LINES > V_N) THEN
        MSG_TEXT = MSG_TEXT || NL || '... inca ' || (V_TOTAL_LINES - V_N) || ' pozitii';
    END

    MSG_TEXT = MSG_TEXT || NL || NL || 'Total: <b>' || FN_TELEGRAM_MONEY(V_SUMA) || ' ' || COALESCE(V_CUR, '') || '</b>';
    IF (V_UTM IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Sursa: ' || FN_TELEGRAM_HTML(V_UTM);
  END

  SUSPEND;
END ^

SET TERM ; ^

/* ---------- Drepturi ---------- */
GRANT EXECUTE ON FUNCTION FN_PAY_DTSC TO PROCEDURE WEB_CREATE_TRANSACTION3;
GRANT EXECUTE ON FUNCTION FN_PAY_DTSC TO PROCEDURE WEB_CREATE_TRANSACTION_PHONE2;
GRANT EXECUTE ON FUNCTION FN_WEB_PAYMENT_CODE TO PROCEDURE WEB_CREATE_TRANSACTION3;
GRANT EXECUTE ON FUNCTION FN_WEB_PAYMENT_CODE TO PROCEDURE WEB_CREATE_TRANSACTION_PHONE2;
GRANT EXECUTE ON FUNCTION FN_PAY_DTSC TO PUBLIC;
GRANT EXECUTE ON FUNCTION FN_PAY_IS_CREDIT TO PUBLIC;
GRANT EXECUTE ON FUNCTION FN_WEB_PAYMENT_CODE TO PUBLIC;
GRANT EXECUTE ON FUNCTION FN_FIN_AS_WEBORDER TO PUBLIC;
GRANT EXECUTE ON FUNCTION FN_PHONE_LAST8 TO PUBLIC;
GRANT EXECUTE ON PROCEDURE SP_WEB_REGISTER_FINANTARE TO USER WEBUSER;
GRANT EXECUTE ON PROCEDURE SP_ADD_GOODS_FINANTARE TO USER WEBUSER;

COMMIT;

/* ---------- Verificare dupa rulare ----------
   SELECT FN_FIN_AS_WEBORDER(), FN_PAY_DTSC('PAY_CREDIT0'), FN_PAY_DTSC('PAY_INVOICE') FROM RDB$DATABASE;
   -- comenzile noi din cos / "1 click" au DTSC dupa plata:
   SELECT D.DOCID, D.DTSC, S.VALUE_STR FROM TDB_DOCS D LEFT JOIN TS_SYSS S ON S.SYSSID = D.DTSC
    WHERE D.DOCTYPEID = 134 ORDER BY D.DOCID DESC ROWS 20;

   Pornire (dupa ce site-ul e pregatit, faza 3):
   UPDATE TS_API_CONFIG SET PARAM_VALUE = '1' WHERE API_CODE = 'WEB_ORDERS' AND PARAM_NAME = 'FIN_AS_WEBORDER';
   Oprire: aceeasi comanda cu '0'.

   ---------- Optional: analitica pe comenzile 134 din 2026 deja create ----------
   Doar unde DTSC = PAY_NONE (5108), dupa metoda de plata din deal. Rulati separat, la cerere.

   UPDATE TDB_DOCS D SET D.DTSC = (
       SELECT FN_PAY_DTSC(CASE UPPER(TRIM(DL.PAYMENT_METHOD))
                WHEN 'CREDIT' THEN 'PAY_CREDIT' WHEN 'NUMERAR LA LIVRARE' THEN 'PAY_CASH'
                WHEN 'LA PRIMIRE' THEN 'PAY_CASH' WHEN 'CARD LA LIVRARE' THEN 'PAY_POS'
                WHEN 'CARD ONLINE' THEN 'PAY_ECOMM' WHEN 'CONT SPRE PLATA' THEN 'PAY_INVOICE'
                WHEN 'MIA QR' THEN 'PAY_QR_MIA' END)
         FROM TDB_DEAL_DOCS DD JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
        WHERE DD.DOCID = D.DOCID ROWS 1)
    WHERE D.DOCTYPEID = 134 AND D.DTSC = 5108 AND D.CREATED_DATE >= '2026-01-01'
      AND EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                   WHERE DD.DOCID = D.DOCID AND NULLIF(TRIM(DL.PAYMENT_METHOD), '') IS NOT NULL);
*/

/* ============================================================================
   web_delivery_firms_zone.sql

   Problema (10.10.2026, comanda 2181469): pe fantastic.md livrarea in
   or. Chisinau ajungea uneori in Web-Order cu 200 lei si cu produsul-serviciu
   122293, desi clientul vedea alt tarif la finalizare.

   Cauza: pretul livrarii se calcula in doua locuri diferite.
     - Pagina de finalizare (helpers/CheckoutOrder::deliveryQuote) arata pretul
       din WEB_GET_DELIVERY_PRICE, adica din TWEB_DELIVERY_ZONE.
     - WEB_CREATE_TRANSACTION3 / WEB_CREATE_TRANSACTION2_ECOMM scriu in document
       pretul din WEB_GET_DELIVERY_FIRMS, care avea o grila veche, hardcodata:
         * pretul de pornire 200;
         * or. Chisinau cu ORDER_AMOUNT <= 500  -> pretul lui 122293 x 2
           (122293 costa azi 100 -> 200 lei; inainte, cand costa 60 -> 120);
         * or. Chisinau cu ORDER_AMOUNT > 1000  -> pretul lui 122293;
         * in afara or. Chisinau (si suburbiile!) -> pretul lui 122294 (150).
       Iar produsul-serviciu (GOODSID, devenit TRANSPORT_GOODSID si linia din
       document) venea din TWEB_DELIVERY_LOCATIONS: 122293 pentru tot raionul 101.

   Acest script:
     1. zona CHISINAU trece pe produsul-serviciu 173080 "Livrare CHISINAU,
        1-2 zile" (60 lei) in loc de 122293 "Livrare or. Chisinau" (100 lei);
     2. TWEB_DELIVERY_ZONE primeste regula comenzilor mici (cererea
        proprietarului, 10.10.2026): SMALL_ORDER_MAX / SMALL_ORDER_FACTOR -
        comanda de produse <= SMALL_ORDER_MAX lei plateste tariful zonei x
        SMALL_ORDER_FACTOR. Chisinau: <= 500 lei -> 173080 x 2. Regula e in
        tabela, deci o citesc la fel cosul, documentul si pagina /livrare;
     3. WEB_GET_DELIVERY_PRICE aplica regula (aceeasi semnatura);
     4. rescrie WEB_GET_DELIVERY_FIRMS (aceeasi semnatura): transportatorul,
        termenele si titlurile raman din TWEB_DELIVERY_LOCATIONS, dar produsul-
        serviciu si pretul vin din zona (TWEB_DELIVERY_ZONE) prin
        WEB_GET_DELIVERY_PRICE - deci documentul primeste exact ce vede clientul
        pe site.

   Efect pe zone (preturile de azi, grila 1):
     Chisinau  : 173080 = 60 lei, 120 lei la comenzi <= 500 lei
                 (era 122293: 100, sau 200 sub 500 lei)
     Suburbii  : 182874 = 120 lei  (era 122293 cu pretul lui 122294: 150)
     Moldova   : 122294 = 150 lei  (neschimbat)
   GET_OPENED_WAYBILLS recunoaste deja 173080 ca livrare.

   Idempotent: poate fi rulat de mai multe ori.

   Rulare: isql -user SYSDBA -password <parola> -ch UTF8 "<host>/3050:SW" -i web_delivery_firms_zone.sql
============================================================================ */

/* --- 1. zona Chisinau pe 173080 ------------------------------------------- */

UPDATE TWEB_DELIVERY_ZONE SET GOODSID = 173080
 WHERE CODE = 'CHISINAU' AND GOODSID <> 173080;

COMMIT;

/* --- 2. regula comenzilor mici -------------------------------------------- */

SET TERM ^ ;

EXECUTE BLOCK
AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_DELIVERY_ZONE' AND RDB$FIELD_NAME = 'SMALL_ORDER_MAX')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_DELIVERY_ZONE ADD SMALL_ORDER_MAX DM_PRICE';

  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TWEB_DELIVERY_ZONE' AND RDB$FIELD_NAME = 'SMALL_ORDER_FACTOR')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_DELIVERY_ZONE ADD SMALL_ORDER_FACTOR DM_PRICE';
END^

SET TERM ; ^

COMMIT;

COMMENT ON COLUMN TWEB_DELIVERY_ZONE.SMALL_ORDER_MAX    IS 'Comanda de produse <= aceasta suma (MDL) plateste tariful x SMALL_ORDER_FACTOR; NULL = fara regula';
COMMENT ON COLUMN TWEB_DELIVERY_ZONE.SMALL_ORDER_FACTOR IS 'Multiplicatorul tarifului pentru comenzile mici (2 = tarif dublu)';

UPDATE TWEB_DELIVERY_ZONE SET SMALL_ORDER_MAX = 500, SMALL_ORDER_FACTOR = 2
 WHERE CODE = 'CHISINAU' AND SMALL_ORDER_MAX IS NULL;

COMMIT;

/* --- 3. WEB_GET_DELIVERY_PRICE cu regula comenzilor mici ------------------ */

SET TERM ^ ;

ALTER PROCEDURE WEB_GET_DELIVERY_PRICE (
    GOODS_QTY    DM_INTEGER,
    DISTRICTID   DM_INTEGER,
    CITYID       DM_INTEGER,
    ORDER_AMOUNT DM_PRICE)
RETURNS (
    GOODS_PRICE_LEI DM_PRICE,
    ISFREEDELIVERY  DM_INTEGER)
AS
  DECLARE VARIABLE ZONE_CODE VARCHAR(20);
  DECLARE VARIABLE ZONE_GOODSID INTEGER;
  DECLARE VARIABLE FREE_FROM DM_PRICE;
  DECLARE VARIABLE SMALL_MAX DM_PRICE;
  DECLARE VARIABLE SMALL_FACTOR DM_PRICE;
BEGIN
  /* Zona dupa raion/localitate:
       101 = mun. Chisinau; 2000 = or. Chisinau, 3668..3674 = sectoarele lui;
       restul localitatilor din 101 = suburbii; orice alt raion = restul Moldovei. */
  ZONE_CODE = 'MOLDOVA';
  IF (:DISTRICTID = 101) THEN
    ZONE_CODE = IIF(:CITYID IN (2000, 3668, 3669, 3670, 3671, 3672, 3673, 3674), 'CHISINAU', 'SUBURBII');

  ZONE_GOODSID = NULL;
  FREE_FROM = NULL;
  SMALL_MAX = NULL;
  SMALL_FACTOR = NULL;
  SELECT FIRST 1 Z.GOODSID, Z.FREE_FROM_AMOUNT, Z.SMALL_ORDER_MAX, Z.SMALL_ORDER_FACTOR
    FROM TWEB_DELIVERY_ZONE Z
   WHERE Z.CODE = :ZONE_CODE
    INTO :ZONE_GOODSID, :FREE_FROM, :SMALL_MAX, :SMALL_FACTOR;

  GOODS_PRICE_LEI = 0;
  ISFREEDELIVERY = 0;

  /* Zona nedefinita: pret 0 + ISFREEDELIVERY = 0 => site-ul scrie
     "se confirma de operator" (comportamentul existent in cos). */
  IF (ZONE_GOODSID IS NULL) THEN
  BEGIN
    SUSPEND;
    EXIT;
  END

  SELECT P.PRICE FROM GET_GOODS_PRICE(:ZONE_GOODSID, 1, 498) P INTO :GOODS_PRICE_LEI;
  IF (GOODS_PRICE_LEI IS NULL) THEN GOODS_PRICE_LEI = 0;

  IF ((FREE_FROM IS NOT NULL) AND (:ORDER_AMOUNT >= FREE_FROM)) THEN
  BEGIN
    GOODS_PRICE_LEI = 0;
    ISFREEDELIVERY = 1;
  END
  ELSE
  BEGIN
    /* semantica veche: tarif 0 pe produsul-serviciu = livrare gratuita */
    ISFREEDELIVERY = IIF(GOODS_PRICE_LEI = 0, 1, 0);

    /* comanda mica: tariful zonei x factor (Chisinau <= 500 lei -> x 2) */
    IF ((SMALL_MAX IS NOT NULL) AND (SMALL_FACTOR IS NOT NULL) AND (:ORDER_AMOUNT <= SMALL_MAX)) THEN
      GOODS_PRICE_LEI = ROUND(GOODS_PRICE_LEI * SMALL_FACTOR, 2);
  END

  SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* --- 4. WEB_GET_DELIVERY_FIRMS din zona ----------------------------------- */

SET TERM ^ ;

ALTER PROCEDURE WEB_GET_DELIVERY_FIRMS (
    FIRMAID      DM_INTEGER_NN,
    DISTRICTID   DM_INTEGER_NN,
    CITYID       DM_INTEGER_NN,
    ORDER_AMOUNT DM_PRICE)
RETURNS (
    CUSTOMERID          DM_INTEGER,
    GOODSID             DM_INTEGER,
    TIME_UNIT           DM_INTEGER,
    TIME_MIN            DM_INTEGER,
    TIME_MAX            DM_INTEGER,
    COMMENTS_ROM        DM_VARCHAR255,
    COMMENTS_RUS        DM_VARCHAR255,
    GOODS_PRICE_LEI     DM_PRICE,
    TRANSPORT_TITLE_ROM DM_VARCHAR255,
    TRANSPORT_TITLE_RUS DM_VARCHAR255,
    TRANSPORT_DSC_ROM   DM_VARCHAR255,
    TRANSPORT_DSC_RUS   DM_VARCHAR255,
    TITLE_ROM           DM_VARCHAR255,
    TITLE_RUS           DM_VARCHAR255,
    ISFREEDELIVERY      DM_INTEGER)
AS
  DECLARE VARIABLE ZONE_CODE VARCHAR(20);
  DECLARE VARIABLE ZONE_GOODSID INTEGER;
  DECLARE VARIABLE ZONE_PRICE DM_PRICE;
  DECLARE VARIABLE ZONE_FREE DM_INTEGER;
BEGIN
  /* Transportatorii localitatii (sau ai raionului, CITYID = -1) raman din
     TWEB_DELIVERY_LOCATIONS. Produsul-serviciu si tariful vin din zona, la fel
     ca pe site (WEB_GET_DELIVERY_PRICE), ca documentul sa aiba exact pretul
     aratat clientului. Regula zonei e aceeasi ca in WEB_GET_DELIVERY_PRICE:
     101 = mun. Chisinau; 2000 = or. Chisinau, 3668..3674 = sectoarele lui;
     restul localitatilor din 101 = suburbii; orice alt raion = restul Moldovei. */
  ZONE_CODE = 'MOLDOVA';
  IF (:DISTRICTID = 101) THEN
    ZONE_CODE = IIF(:CITYID IN (2000, 3668, 3669, 3670, 3671, 3672, 3673, 3674), 'CHISINAU', 'SUBURBII');

  ZONE_GOODSID = NULL;
  SELECT FIRST 1 Z.GOODSID FROM TWEB_DELIVERY_ZONE Z
   WHERE Z.CODE = :ZONE_CODE
    INTO :ZONE_GOODSID;

  ZONE_PRICE = 0;
  ZONE_FREE = 0;
  SELECT P.GOODS_PRICE_LEI, P.ISFREEDELIVERY
    FROM WEB_GET_DELIVERY_PRICE(1, :DISTRICTID, :CITYID, :ORDER_AMOUNT) P
    INTO :ZONE_PRICE, :ZONE_FREE;

  FOR
    SELECT L.CUSTOMERID, L.GOODSID, L.TIME_UNIT, L.TIME_MIN, L.TIME_MAX,
           L.COMMENTS_ROM, L.COMMENTS_RUS,
           F.TITLE_ROM, F.TITLE_RUS, F.DESCRIPTION_ROM, F.DESCRIPTION_RUS,
           L.TITLE_ROM, L.TITLE_RUS
      FROM TWEB_DELIVERY_LOCATIONS L
      JOIN TWEB_DELIVERY_FIRMS F ON F.FIRMAID = L.FIRMAID AND F.CUSTOMERID = L.CUSTOMERID
     WHERE L.FIRMAID = :FIRMAID
       AND L.DISTRICTID = :DISTRICTID
       AND (L.CITYID = :CITYID OR L.CITYID = -1)
      INTO :CUSTOMERID, :GOODSID, :TIME_UNIT, :TIME_MIN, :TIME_MAX,
           :COMMENTS_ROM, :COMMENTS_RUS,
           :TRANSPORT_TITLE_ROM, :TRANSPORT_TITLE_RUS, :TRANSPORT_DSC_ROM, :TRANSPORT_DSC_RUS,
           :TITLE_ROM, :TITLE_RUS
  DO
  BEGIN
    /* zona nedefinita: ramane produsul din TWEB_DELIVERY_LOCATIONS, pret 0
       (site-ul scrie "se confirma de operator") */
    GOODSID = COALESCE(:ZONE_GOODSID, :GOODSID);
    GOODS_PRICE_LEI = COALESCE(:ZONE_PRICE, 0);
    ISFREEDELIVERY = COALESCE(:ZONE_FREE, 0);
    SUSPEND;
  END
END^

SET TERM ; ^

COMMIT;

/* --- verificare ------------------------------------------------------------
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 101, 2000,  108);  -- Chisinau, comanda mica -> 173080 / 120 / 0
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 101, 2000,  500);  -- Chisinau, la prag      -> 173080 / 120 / 0
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 101, 2000,  501);  -- Chisinau, peste prag   -> 173080 / 60 / 0
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 101, 2000, 3000);  -- Chisinau              -> 173080 / 60 / 0
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 101, 2024,  500);  -- suburbii              -> 182874 / 120 / 0
SELECT GOODSID, GOODS_PRICE_LEI, ISFREEDELIVERY FROM WEB_GET_DELIVERY_FIRMS(5213, 107,   -1,  500);  -- raion                 -> 122294 / 150 / 0
SELECT * FROM WEB_GET_DELIVERY_PRICE(1, 101, 2000, 108);                                             -- site: aceeasi suma
--------------------------------------------------------------------------- */

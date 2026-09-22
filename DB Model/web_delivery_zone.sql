/* ============================================================================
   web_delivery_zone.sql

   Scop: o singura sursa de adevar pentru tarifele de livrare ale site-ului
   fantastic.md. Pana acum WEB_GET_DELIVERY_PRICE (apelata din cos) avea
   produsele-serviciu hardcodate si niciun prag de gratuitate, iar pagina
   /livrare si pagina de produs aveau cifre scrise de mana, care nu mai
   corespundeau ("de la 100 lei" pe produs, 150 lei in cos, nimic pe pagina).

   Acest script:
     1. creeaza tabela TWEB_DELIVERY_ZONE (3 zone: CHISINAU / SUBURBII / MOLDOVA)
        cu produsul-serviciu al zonei (pretul lui, grila 1 in MDL, este tariful)
        si pragul sumei comenzii de la care livrarea e gratuita;
     2. o populeaza cu grila PROPUSA (vezi mai jos) - pragurile pot fi ajustate
        direct in tabela, fara sa se schimbe codul;
     3. rescrie WEB_GET_DELIVERY_PRICE ca sa citeasca din tabela (aceeasi
        semnatura, cosul nu se schimba);
     4. (OPTIONAL, comentat) actualizeaza preturile produselor-serviciu la
        valorile propuse - alternativ se schimba din WMS, editorul de produse.

   Site-ul (fantastic.web/models/WebDeliveryZone.php) citeste aceeasi tabela;
   daca tabela lipseste, cade pe cele 3 produse-serviciu fara praguri, deci
   pagina si cosul raman consecvente si inainte, si dupa rularea scriptului.

   Grila propusa (analiza pietei, 16.09.2026: pandashop, enter, smadshop,
   neocomputer, xstore, smart, atehno):
     Zona            | Tarif | Gratuit de la | Piata
     Chisinau        |  50   |  1000 lei     | 50 lei / gratuit >= 1000 (pandashop, enter, smadshop)
     Suburbii        | 100   |  3000 lei     | 89-150 lei (smadshop, pandashop)
     Restul Moldovei | 100   |  3000 lei     | 90-150 lei, gratuit de la 1500-5000 (enter, neocomputer, smadshop)
   Azi: 60 / 100 / 150 lei fix, fara gratuitate.

   Idempotent: poate fi rulat de mai multe ori (CREATE conditionat, UPDATE OR
   INSERT, ALTER PROCEDURE).

   Rulare: isql -user SYSDBA -password <parola> -ch UTF8 "<host>/3050:SW" -i web_delivery_zone.sql
============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK
AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_DELIVERY_ZONE')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_DELIVERY_ZONE (
         ZONEID           INTEGER      NOT NULL,
         CODE             VARCHAR(20)  NOT NULL,
         GOODSID          INTEGER      NOT NULL,
         FREE_FROM_AMOUNT DM_PRICE,
         MAX_WEIGHT_KG    INTEGER,
         ORDERNO          INTEGER      DEFAULT 0 NOT NULL,
         TITLE_ROM        VARCHAR(100),
         TITLE_RUS        VARCHAR(100),
         CONSTRAINT PK_TWEB_DELIVERY_ZONE PRIMARY KEY (ZONEID),
         CONSTRAINT UQ_TWEB_DELIVERY_ZONE_CODE UNIQUE (CODE)
       )';
END^

SET TERM ; ^

COMMIT;

COMMENT ON TABLE  TWEB_DELIVERY_ZONE IS 'Zonele de livrare ale site-ului: tarif = pretul produsului-serviciu (grila 1, MDL), prag de gratuitate pe suma comenzii';
COMMENT ON COLUMN TWEB_DELIVERY_ZONE.CODE             IS 'CHISINAU / SUBURBII / MOLDOVA - folosit de WEB_GET_DELIVERY_PRICE si de site';
COMMENT ON COLUMN TWEB_DELIVERY_ZONE.GOODSID          IS 'Produsul-serviciu "Livrare ..." al carui pret (GET_GOODS_PRICE grila 1) este tariful zonei';
COMMENT ON COLUMN TWEB_DELIVERY_ZONE.FREE_FROM_AMOUNT IS 'Suma comenzii (MDL) de la care livrarea e gratuita; NULL = niciodata';
COMMENT ON COLUMN TWEB_DELIVERY_ZONE.MAX_WEIGHT_KG    IS 'Informativ: limita de greutate pentru tariful standard (peste - tarif individual)';

COMMIT;

/* --- 2. grila propusa ------------------------------------------------------ */

UPDATE OR INSERT INTO TWEB_DELIVERY_ZONE (ZONEID, CODE, GOODSID, FREE_FROM_AMOUNT, MAX_WEIGHT_KG, ORDERNO, TITLE_ROM, TITLE_RUS)
VALUES (1, 'CHISINAU', 122293, 1000, 40, 1, 'Chisinau', 'Кишинёв')
MATCHING (ZONEID);

UPDATE OR INSERT INTO TWEB_DELIVERY_ZONE (ZONEID, CODE, GOODSID, FREE_FROM_AMOUNT, MAX_WEIGHT_KG, ORDERNO, TITLE_ROM, TITLE_RUS)
VALUES (2, 'SUBURBII', 182874, 3000, 40, 2, 'Suburbiile Chisinaului', 'Пригороды Кишинёва')
MATCHING (ZONEID);

UPDATE OR INSERT INTO TWEB_DELIVERY_ZONE (ZONEID, CODE, GOODSID, FREE_FROM_AMOUNT, MAX_WEIGHT_KG, ORDERNO, TITLE_ROM, TITLE_RUS)
VALUES (3, 'MOLDOVA', 122294, 3000, 40, 3, 'Restul Moldovei', 'Вся Молдова')
MATCHING (ZONEID);

COMMIT;

/* --- 3. procedura citeste din tabela ------------------------------------- */

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
BEGIN
  /* Zona dupa raion/localitate:
       101 = mun. Chisinau; 2000 = or. Chisinau, 3668..3674 = sectoarele lui;
       restul localitatilor din 101 = suburbii; orice alt raion = restul Moldovei. */
  ZONE_CODE = 'MOLDOVA';
  IF (:DISTRICTID = 101) THEN
    ZONE_CODE = IIF(:CITYID IN (2000, 3668, 3669, 3670, 3671, 3672, 3673, 3674), 'CHISINAU', 'SUBURBII');

  ZONE_GOODSID = NULL;
  FREE_FROM = NULL;
  SELECT FIRST 1 Z.GOODSID, Z.FREE_FROM_AMOUNT
    FROM TWEB_DELIVERY_ZONE Z
   WHERE Z.CODE = :ZONE_CODE
    INTO :ZONE_GOODSID, :FREE_FROM;

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
    /* semantica veche: tarif 0 pe produsul-serviciu = livrare gratuita */
    ISFREEDELIVERY = IIF(GOODS_PRICE_LEI = 0, 1, 0);

  SUSPEND;
END^

SET TERM ; ^

COMMIT;

/* --- 4. OPTIONAL: tarifele propuse pe produsele-serviciu ------------------
   Pretul zonei este PRICE1 al produsului-serviciu (furnizorul cu flg_in_price,
   asa cum il citeste GET_GOODS_PRICE). Recomandat: se schimba din WMS, in
   editorul de produse, la 122293 (Chisinau: 60 -> 50) si 122294 (Moldova:
   150 -> 100). 182874 (suburbii) ramane 100.
   Daca se prefera SQL, decomenteaza dupa ce verifici ca fiecare produs are
   un singur rand activ in TS_GOODS_FOREIGN:

UPDATE TS_GOODS_FOREIGN SET PRICE1 = 50  WHERE GOODSID = 122293 AND GET_FLG_VALUE(FLAGS, 3) = 1;
UPDATE TS_GOODS_FOREIGN SET PRICE1 = 100 WHERE GOODSID = 122294 AND GET_FLG_VALUE(FLAGS, 3) = 1;
COMMIT;
--------------------------------------------------------------------------- */

/* --- verificare ------------------------------------------------------------
SELECT Z.CODE, Z.FREE_FROM_AMOUNT, (SELECT P.PRICE FROM GET_GOODS_PRICE(Z.GOODSID, 1, 498) P) AS PRICE
  FROM TWEB_DELIVERY_ZONE Z ORDER BY Z.ORDERNO;
SELECT * FROM WEB_GET_DELIVERY_PRICE(1, 101, 2000,  999);   -- Chisinau sub prag  -> 50 / 0
SELECT * FROM WEB_GET_DELIVERY_PRICE(1, 101, 2000, 1000);   -- Chisinau la prag   ->  0 / 1
SELECT * FROM WEB_GET_DELIVERY_PRICE(1, 101, 3700, 2999);   -- suburbii sub prag  -> 100 / 0
SELECT * FROM WEB_GET_DELIVERY_PRICE(1, 107,   -1, 3000);   -- Cahul la prag      ->  0 / 1
--------------------------------------------------------------------------- */

/* ------------------------------------------------------------------------
   Marirea coloanelor de 512 caractere din pricelist (2 oct 2026)

   Domeniul DM_VARCHAR512 e declarat VARCHAR(512) CHARACTER SET UTF8, dar are
   doar 512 OCTETI (RDB$FIELD_LENGTH = 512 in loc de 2048) - probabil ramas dintr-o
   conversie veche de set de caractere. In UTF8 Firebird rezerva 4 octeti pe
   caracter, deci coloanele pe acest domeniu primesc de fapt doar 128 de
   caractere ("string right truncation, expected length 128").
   A aparut la importul Triomac (SCOP): categoria "HEALTH & BEAUTY (...) / HAIR
   STRAIGHTENERS (...) / ..." are 131 de caractere.

   Scriptul muta pe un tip propriu, cu adevarat de 512 caractere (2048 octeti),
   doar coloanele din fluxul de pricelist:
     TS_PRICELIST_ITEMS.SUPPLIER_CATEGORY
     TS_PRICELIST_ITEMS.PRODUCT_LINK
     TS_PRICELIST_ITEMS_DESCRIPTION.PRODUCT_CATEGORIES
   Niciuna nu e in vreun index. Datele existente nu se ating (marire de tip).

   Apoi recreeaza VW_TS_PRICELIST_ITEMS cu aceeasi sursa (copiata de pe SW la
   2 oct 2026): coloanele view-ului iau tipul coloanei de baza; fara asta, o
   valoare de peste 128 de caractere ar da aceeasi eroare la citirea prin view.
   ALTER VIEW pastreaza triggerele view-ului (BI/BU/BD/AU) si drepturile.

   NU se repara aici domeniul DM_VARCHAR512 in sine: il folosesc 82 de coloane,
   107 parametri de proceduri si 63 de proceduri, plus cheile primare
   PK_TS_GOODS_FOREIGN si PK_TWEB_URL_REDIRECT (la aceasta din urma cheia de
   2 x 512 caractere UTF8 ar depasi limita de cheie de index la pagina de 16K).

   Reluabil: rularea repetata nu schimba nimic.
   Dupa rulare, importurile pot scrie categoria intreaga (Triomac taie inca la
   128 - se poate ridica la 512 in TriomacPriceListUnit).
   Revenire: nu e necesara (doar mareste); tipul vechi nu se poate restabili
   daca exista deja valori de peste 128 de caractere.
   ------------------------------------------------------------------------ */

ALTER TABLE TS_PRICELIST_ITEMS ALTER COLUMN SUPPLIER_CATEGORY TYPE VARCHAR(512) CHARACTER SET UTF8;
ALTER TABLE TS_PRICELIST_ITEMS ALTER COLUMN PRODUCT_LINK TYPE VARCHAR(512) CHARACTER SET UTF8;
ALTER TABLE TS_PRICELIST_ITEMS_DESCRIPTION ALTER COLUMN PRODUCT_CATEGORIES TYPE VARCHAR(512) CHARACTER SET UTF8;
COMMIT;

CREATE OR ALTER VIEW VW_TS_PRICELIST_ITEMS (
    PLID,
    SUPPLIERID,
    SUPPLIER_GOODS_CODE,
    GOODSID,
    SUPPLIER_GOODS_NAME,
    STOCK_QTY,
    FLAGS,
    FLG_EPP,
    PRICE0,
    CURRENCY0ID,
    PRICE3,
    CURRENCY3ID,
    CURRENCY3_NAME,
    PRICE7,
    CURRENCY7ID,
    CURRENCY7_NAME,
    WARANTY,
    SUPPLIER_GOODS_BRAND,
    SUPPLIER_GOODS_MODEL,
    SUPPLIER_GOODSTYPE,
    GOODSTYPEID,
    GOODSTYPE_NAME,
    SYSTEM_VENDORID,
    SYSTEM_VENDOR_NAME,
    PARENTGOODSID,
    PARENTGOODS_NAME,
    SYSTEM_UMID,
    SUPPLIER_CATEGORY,
    TITLE,
    WEBGOODSTYPE_ID,
    WEBGOODSTYPE_NAME,
    CODE,
    BASE_PARAM,
    CODE_RU,
    BASE_PARAM_RU,
    DETAILS,
    VENDOR_ID,
    VENDOR_NAME,
    COMPATIBILITATE,
    FLG_PREORDER,
    PRODUCT_LINK,
    TVA)
AS
select PLI.PLID,
       pl.supplierid,
       PLI.SUPPLIER_GOODS_CODE,
       GF.GOODSID,
       PLI.SUPPLIER_GOODS_NAME,
       PLI.STOCK_QTY,
       gf.FLAGS,
       get_flg_value(GF.flags, 4), /* flg_epp */
       pli.price0,
       pli.currency0id,
       PLI.PRICE3,
       PLI.CURRENCY3ID,
       (select title from ts_currency where currencyid = pli.currency3id),
       PLI.PRICE7,
       PLI.CURRENCY7ID,
       (select title from ts_currency where currencyid = pli.currency7id),
       PLI.WARANTY,
       PLI.supplier_goods_BRAND,
       PLI.supplier_goods_MODEL,
       PLI.supplier_GOODSTYPE,
       PLI.GOODSTYPEID,
       (select TITLE from TS_GOODS_TYPE where GOODSTYPEID = PLI.GOODSTYPEID) GOODSTYPE_NAME,
       PLI.SYSTEM_VENDORID,
       (select TITLE from TS_SYSS where SYSSID = PLI.SYSTEM_VENDORID) SYSTEM_VENDOR_NAME,
       pli.parentgoodsid,
       SUBSTRING(G1.title FROM 1 FOR 150),
       g.UMID,
       SUPPLIER_CATEGORY,

        g.title,
        g.WEBGOODSTYPE_ID,
        (select title from ts_goods_type gt where gt.goodstypeid=g.webgoodstype_id),
        g.code,
        g.base_param,
        g.code_ru,
        g.base_param_ru,
        g.details,
        G.vendor_id,
        (select title from ts_syss where syssid = g.vendor_id),
        PLI.COMPATIBILITATE,
        pli.flg_preorder,
        pli.product_link,
        pli.tva
from TS_PRICELIST_ITEMS PLI
join ts_pricelists pl on pl.plid = pli.plid
left outer join TS_GOODS_FOREIGN GF on (GF.GOODS_CODE = pLi.SUPPLIER_GOODS_CODE and gf.customerid = pl.supplierid)
left outer join ts_goods g on g.goodsid = gf.goodsid
left outer join ts_goods g1 on g1.goodsid = pli.parentgoodsid
left outer join ts_goods_type gt on gt.goodstypeid = g.webgoodstype_id;
COMMIT;

/* Verificare: toate randurile trebuie sa aiba CHAR_LEN = 512 si BYTES = 2048
SELECT TRIM(RF.RDB$RELATION_NAME) TBL, TRIM(RF.RDB$FIELD_NAME) COL,
       F.RDB$CHARACTER_LENGTH CHAR_LEN, F.RDB$FIELD_LENGTH BYTES
FROM RDB$RELATION_FIELDS RF
JOIN RDB$FIELDS F ON F.RDB$FIELD_NAME = RF.RDB$FIELD_SOURCE
WHERE (RF.RDB$RELATION_NAME IN ('TS_PRICELIST_ITEMS', 'VW_TS_PRICELIST_ITEMS')
       AND RF.RDB$FIELD_NAME IN ('SUPPLIER_CATEGORY', 'PRODUCT_LINK'))
   OR (RF.RDB$RELATION_NAME = 'TS_PRICELIST_ITEMS_DESCRIPTION' AND RF.RDB$FIELD_NAME = 'PRODUCT_CATEGORIES');
*/

/* ============================================================================
   Nomenclatorul de produse (frmGoods): mapa se aduce pe portii, nu toata odata

   Problema: intr-o mapa cu multe produse (415725: 12.329, 105676: 6.528 ...)
   grid-ul incarca toate rindurile. SP_GET_TS_GOODS_M1 calcula pentru FIECARE
   rind ~15 subinterogari (stocuri, flaguri, marja) INAINTE de sortare, pentru
   ca ORDER BY-ul folosea QTY_AVAILABLE; apoi WMS (cxGrid in modul obisnuit)
   citea toate rindurile (TITLE/CODE/DETAILS late) si le tinea in memorie.
   Masurat pe SW, mapa 415725: toata procedura 5,7 s; primele 200 de rinduri
   tot 1,1 s (sortarea cerea calculul complet).

   SP_GET_TS_GOODS_M1(DT, SOURCE_PARENTID, FLG_ONLY_IN_PRICE, A_SEARCH = NULL)
       FOR SELECT-ul citeste si sorteaza doar coloanele din TS_GOODS plus cheile
       de sortare (get_flg_in_price, PRICE1_LEI din GET_GOODS_PRICE - 0,2 s pe
       12.329 rinduri); stocurile, flagurile calculate, denumirile, marja si
       preturile se calculeaza in corpul DO, adica doar pentru rindurile cerute
       de client (fetch). Coloanele de iesire si valorile lor sint neschimbate.
       Ordinea noua in mapa: FLG_FOLDER DESC, FLG_IN_PRICE DESC, PRICE1_LEI ASC
       (fara pret la sfirsit), ORDERNO, TITLE.
       A_SEARCH: cuvinte separate prin spatiu, toate trebuie sa apara (CONTAINING)
       in TITLE / CODE / CODE_RU / BASE_PARAM / BASE_PARAM_RU / DETAILS / GOODSID.
       Apelantii vechi cu 2-3 parametri (SP_IMPORT_GOODS_CONCURENTS,
       SP_PEREOTENCA_IMPORT_ITERATE2) merg neschimbati.

   SP_GET_TS_GOODS
       in modurile 1/2 (mapa, mapa parintelui) transmite SEARCH_MASK catre M1;
       WMS trimite acolo textul din panoul Find al grid-ului in modul rapid.
       Restul modurilor neschimbate.

   In WMS (frmGoods, acelasi commit): IBCQueryGoods.FetchRows = 200 cu FetchAll =
   False, "Fast mode" (GridMode) implicit pornit, sortarea pe coloana si cautarea
   din panoul Find se fac pe server, operatiile pe rindurile selectate citesc
   prin bookmark-uri. Scriptul merge si cu WMS-ul vechi (doar ordinea se schimba).

   Generat de C:/Temp/fintest/goods/gen_goods_lazy.py din sursele live SW;
   echivalenta cu versiunea veche verificata pe SW doar prin citire
   (test_goods_lazy.py, EXECUTE BLOCK vs procedura). Rollback alaturi.

   Re-rulabil. Firebird 5.
   NEURON Grup SRL, 24 octombrie 2026
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_GET_TS_GOODS_M1 (DT DM_INTEGER_NN,
SOURCE_PARENTID DM_INTEGER_NN,
FLG_ONLY_IN_PRICE DM_BOOLEAN = 0,
A_SEARCH VARCHAR(255) CHARACTER SET UTF8 = NULL)
RETURNS (GOODSID DM_INTEGER,
PARENTID DM_INTEGER,
FLG_FOLDER DM_BOOLEAN,
BASE_PARAM TYPE OF COLUMN TS_GOODS.BASE_PARAM,
BASE_PARAM_RU TYPE OF COLUMN TS_GOODS.BASE_PARAM,
CODE TYPE OF COLUMN TS_GOODS.CODE,
CODE_RU TYPE OF COLUMN TS_GOODS.CODE,
TITLE TYPE OF COLUMN TS_GOODS.TITLE,
DETAILS TYPE OF COLUMN TS_GOODS.DETAILS,
FLG_SOCIAL DM_BOOLEAN,
FLG_OLD DM_BOOLEAN,
FLG_REQUIRE_CERTIFICAT DM_BOOLEAN,
FLG_BEST_PRICE DM_BOOLEAN,
FLG_PRICE_NBM DM_BOOLEAN,
FLG_PROMO DM_BOOLEAN,
FLG_NEW DM_BOOLEAN,
FLG_PRICE_FORCED DM_BOOLEAN,
FLG_DISCOUNT DM_BOOLEAN,
FLG_FORCED_ADDON DM_INTEGER,
FLG_SUPPLIER_PROMO DM_INTEGER,
FLG_WEB_HIDE_COMPLECT_ITEMS DM_INTEGER,
FLG_PREORDER DM_INTEGER,
WARRANTY DM_INTEGER,
GOODS_ACNT_ID DM_INTEGER,
GOODS_TYPE_ID DM_INTEGER,
GOODS_TYPE_NAME DM_VARCHAR255,
WEBGOODSTYPE_ID DM_INTEGER,
WEBGOODSTYPE_TITLE DM_VARCHAR60,
WEBGOODSTYPE_TITLE_RU DM_VARCHAR60,
VENDOR_ID DM_INTEGER,
USERID DM_INTEGER,
UMID DM_INTEGER,
SERIAL_TYPE_ID DM_INTEGER,
ORDERNO DM_INTEGER,
USER_FULLNAME DM_VARCHAR512,
CREATE_DATE DM_DATETIME,
NAMEACNT DM_VARCHAR255,
PRICE0 DM_PRICE,
PRICE1 DM_PRICE,
PRICE2 DM_PRICE,
PRICE3 DM_PRICE,
PRICE4 DM_PRICE,
PRICE5 DM_PRICE,
PRICE6 DM_PRICE,
PRICE7 DM_PRICE,
PRICE1_LEI DM_PRICE,
PRICE2_LEI DM_PRICE,
PRICE3_LEI DM_PRICE,
PRICE4_LEI DM_PRICE,
PRICE5_LEI DM_PRICE,
PRICE6_LEI DM_PRICE,
PRICE7_LEI DM_PRICE,
CURRENCYID DM_INTEGER,
VENDOR DM_VARCHAR255,
UM_TITLE DM_VARCHAR255,
QTY_ACCOUNT DM_QTY,
QTY_AVAILABLE DM_QTY,
QTY_RESERVE DM_QTY,
QTY_RMA DM_QTY,
QTY_INTERNAL DM_QTY,
QTY_FRANCIZE DM_QTY,
QTY_FILIALE DM_QTY,
QTY_TRANSIT DM_QTY,
GOODS_IMAGE_INDEX DM_INTEGER,
MINQTY DM_QTY,
DELIVERY_TYPEID DM_INTEGER,
DELIVERY_TYPENAME TYPE OF COLUMN TS_SYSS.TITLE,
VAT DM_INTEGER,
CASHBACK_PERCENT DM_AMOUNT,
COLORID DM_INTEGER,
COLOR_NAME_RO TYPE OF COLUMN TS_SYSS.TITLE,
COLOR_NAME_RU TYPE OF COLUMN TS_SYSS.VALUE_STR,
TEMPLATEID DM_INTEGER,
ATTRIBUTES DM_INTEGER,
MARGIN17 DM_AMOUNT,
RELATED_KEY DM_VARCHAR128,
PGT_ID DM_INTEGER)
AS
DECLARE VARIABLE V_PRICE_SORT DM_PRICE;
DECLARE VARIABLE V_WORDS VARCHAR(256) CHARACTER SET UTF8;
DECLARE VARIABLE V_WORD VARCHAR(255) CHARACTER SET UTF8;
DECLARE VARIABLE V_TEXT VARCHAR(8191) CHARACTER SET UTF8;
DECLARE VARIABLE V_POS INTEGER;
DECLARE VARIABLE V_MATCH SMALLINT;
BEGIN
     /* Produsele unei mape pentru nomenclator (frmGoods, SP_GET_TS_GOODS modurile 1/2).
        24.10.2026: FOR SELECT-ul citeste si sorteaza doar coloanele ieftine din TS_GOODS
        plus cheile de sortare (FLG_IN_PRICE, PRICE1_LEI). Stocurile, flagurile calculate,
        denumirile din nomenclatoare, marja si preturile se calculeaza in corpul DO, adica
        abia cind rindul e cerut (fetch) de client. Cu FetchAll = False in WMS primele 200 de
        rinduri costa doar sortarea usoara + 200 de rinduri grele, nu toata mapa.
        Ordinea in mapa: mapele intii, apoi FLG_IN_PRICE DESC, PRICE1_LEI ASC (fara pret la
        sfirsit), ORDERNO, TITLE. Inainte: FLG_FOLDER, QTY_AVAILABLE DESC, FLG_IN_PRICE DESC,
        ORDERNO, TITLE.
        A_SEARCH (optional): cuvinte separate prin spatiu; rindul ramine daca TOATE se gasesc
        (CONTAINING, fara litere mari/mici) in TITLE, CODE, CODE_RU, BASE_PARAM, BASE_PARAM_RU,
        DETAILS sau GOODSID - "cauta in mapa" din panoul Find al grid-ului in modul rapid.
        Coloanele de iesire si valorile lor sint identice cu versiunea veche. */
:flg_only_in_price = 0;
     V_WORDS = NULLIF(TRIM(COALESCE(:A_SEARCH, '')), '');
     FOR
        SELECT
              TS_GOODS.GOODSID,
              TS_GOODS.PARENTID,
              TS_GOODS.FLG_FOLDER,
              TS_GOODS.BASE_PARAM,
              TS_GOODS.BASE_PARAM_RU,
              TS_GOODS.CODE,
              TS_GOODS.CODE_RU,
              TS_GOODS.TITLE,
              TS_GOODS.DETAILS,
              GET_FLG_VALUE(TS_GOODS.FLAGS,1), /* FLG_SOCIAL */
              GET_FLG_VALUE(TS_GOODS.FLAGS,2), /* FLG_OLD */
              GET_FLG_VALUE(TS_GOODS.FLAGS,4), /* FLG_REQUIRE_CERTIFICAT */
              get_flg_value(ts_goods.flags,5), /* flg_best_price */
              GET_FLG_VALUE(TS_GOODS.FLAGS,6), /* FLG_PRICE_RRP */
              -- FLG_PRICE_FORCED. !!! se arata numai din 5213; si cheie de sortare
              get_flg_in_price(ts_goods.goodsid) AS FLG_IN_PRICE_SORT,
              get_flg_value(ts_goods.flags, 11), /* FLG_WEB_HIDE_COMPLECT_ITEMS, */
              IIF(FLG_FOLDER=0,TS_GOODS.WARRANTY,NULL),
              TS_GOODS.GOODS_ACNT_ID,
              TS_GOODS.GOODS_TYPE_ID,
              TS_GOODS.WEBGOODSTYPE_ID,
              TS_GOODS.VENDOR_ID,
              TS_GOODS.USERID,
              TS_GOODS.UMID,
              TS_GOODS.SERIAL_TYPE_ID,
              TS_GOODS.ORDERNO,
              TS_GOODS.DATA,
              /* Image index */
              IIF(FLG_FOLDER=1,1,GOODS_TYPE_ID), /* GOODS_IMAGE_INDEX: 1=Folder, other = GOODS_TYPE_ID */
              /* internal usage only */
              TS_GOODS.minqty,
              TS_GOODS.DELIVERY_TYPEID,
              vat,
              cashback_percent,
              colorid,
              templateid,
              attributes,
              related_key,
              pgt_id,
              /* cheia de sortare pe pret: PRICE1_LEI (get_goods_price, grila 1, lei) */
              IIF(FLG_FOLDER=0, (SELECT P.PRICE_MDL FROM GET_GOODS_PRICE(TS_GOODS.GOODSID, 1, 498) P), NULL) AS PRICE_SORT
        FROM TS_GOODS
        WHERE PARENTID = :SOURCE_PARENTID and
        iif ( (:flg_only_in_price = 1),
                (get_flg_in_price(ts_goods.goodsid) = 1) or
                ((SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,1,TS_GOODS.GOODSID)) <> 0) or
                ((SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,2,TS_GOODS.GOODSID)) <> 0) or
                (FLG_FOLDER = 1),
                (1=1)
            )
        ORDER BY FLG_FOLDER DESC, FLG_IN_PRICE_SORT DESC, PRICE_SORT ASC NULLS LAST, ORDERNO, TITLE
        INTO
            :GOODSID,
            :PARENTID,
            :FLG_FOLDER,
            :BASE_PARAM,
            :BASE_PARAM_RU,
            :CODE,
            :CODE_RU,
            :TITLE,
            :DETAILS,
            :FLG_SOCIAL,
            :FLG_OLD,
            :FLG_REQUIRE_CERTIFICAT,
            :flg_best_price,
            :FLG_PRICE_NBM,
            :FLG_PRICE_FORCED,
            :FLG_WEB_HIDE_COMPLECT_ITEMS,
            :WARRANTY,
            :GOODS_ACNT_ID,
            :GOODS_TYPE_ID,
            :WEBGOODSTYPE_ID,
            :VENDOR_ID,
            :USERID,
            :UMID,
            :SERIAL_TYPE_ID,
            :ORDERNO,
            :CREATE_DATE,
            :GOODS_IMAGE_INDEX,
            :minqty,
            :DELIVERY_TYPEID,
            :vat,
            :cashback_percent,
            :colorid,
            :templateid,
            :attributes,
            :related_key,
            :pgt_id,
            :V_PRICE_SORT
     DO
     BEGIN
          /* cautare in mapa: toate cuvintele trebuie sa se gaseasca */
          IF (V_WORDS IS NOT NULL) THEN
          BEGIN
              V_TEXT = COALESCE(:TITLE, '') || ' ' || COALESCE(:CODE, '') || ' ' || COALESCE(:CODE_RU, '') || ' ' ||
                       COALESCE(:BASE_PARAM, '') || ' ' || COALESCE(:BASE_PARAM_RU, '') || ' ' ||
                       COALESCE(:DETAILS, '') || ' ' || :GOODSID;
              V_MATCH = 1;
              V_WORD = V_WORDS || ' ';
              WHILE (V_MATCH = 1 AND V_WORD <> '') DO
              BEGIN
                  V_POS = POSITION(' ' IN V_WORD);
                  IF (V_POS > 1) THEN
                      IF (NOT (V_TEXT CONTAINING SUBSTRING(V_WORD FROM 1 FOR V_POS - 1))) THEN
                          V_MATCH = 0;
                  V_WORD = SUBSTRING(V_WORD FROM V_POS + 1);
              END
              IF (V_MATCH = 0) THEN CONTINUE;
          END

          /* coloanele grele: calculate doar pentru rindurile care ajung la client */
          FLG_PROMO = iif (exists(select goodsid from tweb_pa_goods pa
                                 inner join tweb_promos p on p.promoactionid=pa.promoactionid and
                                                             current_date between p.start_date and p.end_date and get_flg_value(p.flags, 0) = 1
                          where pa.goodsid = :goodsid),1,0);
          FLG_NEW = get_flg_new(:goodsid);
          FLG_DISCOUNT = get_flg_goods_discount(:goodsid);
          FLG_FORCED_ADDON = get_flg_available_qty(:goodsid); /* FLG_AVAILABLE_QTY */
          FLG_SUPPLIER_PROMO = get_flg_supplier_action(:goodsid); /* FLG_SUPPLIER_ACTION */
          FLG_PREORDER = get_flg_preorder(:goodsid);
          GOODS_TYPE_NAME = (SELECT TITLE FROM TS_SYSS WHERE TS_SYSS.SYSSID=:GOODS_TYPE_ID);
          WEBGOODSTYPE_TITLE = IIF(:WEBGOODSTYPE_ID=-1,NULL, (SELECT TITLE FROM TS_GOODS_TYPE WHERE TS_GOODS_TYPE.GOODSTYPEID = :WEBGOODSTYPE_ID) );
          WEBGOODSTYPE_TITLE_RU = IIF(:WEBGOODSTYPE_ID=-1,NULL, (SELECT TS_GOODS_TYPE.title_rus FROM TS_GOODS_TYPE WHERE TS_GOODS_TYPE.GOODSTYPEID = :WEBGOODSTYPE_ID) );
          USER_FULLNAME = (SELECT FULL_NAME FROM TS_USERS WHERE (USERID=:USERID));
          NAMEACNT = IIF(:FLG_FOLDER=0,(SELECT NAMEACNT FROM TS_GOODS_ACNT WHERE (GOODS_ACNT_ID=:GOODS_ACNT_ID)),NULL);
          VENDOR = IIF(:FLG_FOLDER=0,(SELECT TITLE FROM TS_SYSS WHERE (SYSSID=:VENDOR_ID)),NULL);
          UM_TITLE = IIF(:FLG_FOLDER=0,(SELECT TITLE FROM TS_UM WHERE (UMID=:UMID)),NULL);
          QTY_ACCOUNT = IIF(:GOODS_ACNT_ID<>-1,COALESCE((SELECT SUM(QTY_ACCOUNT) FROM TS_GOODS_ACNT_STOCK WHERE (GOODS_ACNT_ID=:GOODS_ACNT_ID)),0),NULL);
          /* QTY's */
          QTY_AVAILABLE = IIF(:FLG_FOLDER=0,(SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,1,:GOODSID)),NULL);
          QTY_RESERVE = IIF(:FLG_FOLDER=0,(SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,3,:GOODSID)),NULL);
          QTY_RMA = IIF(:FLG_FOLDER=0,(SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,3,:GOODSID)),NULL);
          QTY_INTERNAL = IIF(:FLG_FOLDER=0,(SELECT amount FROM SP_GOODS_STOCK_ROOT_QTY(:DT,2,:GOODSID)),NULL);
          /* Disponibilitatea marfii dupa Filiale */
          QTY_FILIALE = IIF(:FLG_FOLDER=0,
                           (SELECT COALESCE(SUM(QTY),0)
                                   FROM TS_GOODS_STOCK S1
                                   INNER JOIN (SELECT STOCKID FROM TS_STOCKS WHERE (get_FLG_VALUE(flags,0)=1)) S2 ON (S2.STOCKID=S1.DTDEP)
                                   INNER JOIN (SELECT CUSTOMERID FROM TS_CUSTOMER WHERE (CUSTOMER_TYPE_ID=4002)) S3 ON (S3.CUSTOMERID=S1.DT)
                                   WHERE (GOODSID=:GOODSID)
                           )
                           ,NULL);
          /* Disponibilitatea marfii dupa Francize*/
          QTY_FRANCIZE = IIF(:FLG_FOLDER=0,
                           (SELECT COALESCE(SUM(QTY),0)
                                   FROM TS_GOODS_STOCK S1
                                   INNER JOIN (SELECT STOCKID FROM TS_STOCKS WHERE (get_FLG_VALUE(flags,0)=1)) S2 ON (S2.STOCKID=S1.DTDEP)
                                   INNER JOIN (SELECT CUSTOMERID FROM TS_CUSTOMER WHERE (CUSTOMER_TYPE_ID=4004)) S3 ON (S3.CUSTOMERID=S1.DT)
                                   WHERE (GOODSID=:GOODSID)
                           )
                           ,NULL);
          /* QTY_TRANSIT */
          QTY_TRANSIT = IIF(:FLG_FOLDER=0,(SELECT AMOUNT FROM SP_GOODS_STOCK_TRANSIT_QTY(:DT,:GOODSID)),NULL);
          DELIVERY_TYPENAME = (SELECT TITLE FROM TS_SYSS WHERE SYSSID=:DELIVERY_TYPEID);
          COLOR_NAME_RO = (select title from ts_syss where syssid=:colorid);
          COLOR_NAME_RU = (select value_str from ts_syss where syssid=:colorid);
          MARGIN17 = get_goods_margin(:goodsid);

          :price4 = 0;
          :price4_lei = 0;
          :price7 = 0;
          :price7_LEI = 0;
          select price, price_mdl, currencyid from get_goods_price(:goodsid, 1, 498) into :price4, :price4_LEI, :currencyid;
          select price, price_mdl from get_goods_price7(:goodsid, 840) into :price7, :price7_LEI;
          /* preturile originale a produsului */
          :price1 = iif(FLG_FOLDER=0, :price4, null);
          :price2 = iif(FLG_FOLDER=0, :price4, null);
          :price3 = iif(FLG_FOLDER=0, :price4, null);
          :price4 = iif(FLG_FOLDER=0, :price4, null);
          :price5 = iif(FLG_FOLDER=0, :price4, null);
          :price6 = iif(FLG_FOLDER=0, :price4, null);
          :price7 = iif(FLG_FOLDER=0, :price7, null);
--          /* preturile in lei, curs Exchange */
          :PRICE1_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE2_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE3_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE4_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE5_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE6_LEI = iif(FLG_FOLDER=0, :price4_lei, null);
          :PRICE7_LEI = iif(FLG_FOLDER=0, :price7_lei, null);
          suspend;
    END
END ^

CREATE OR ALTER PROCEDURE SP_GET_TS_GOODS (SELECT_MODE DM_INTEGER,
DT DM_INTEGER_NN,
SOURCE_PARENTID DM_INTEGER,
SEARCH_MASK DM_VARCHAR2048,
FLG_ONLY_IN_PRICE DM_BOOLEAN = 0)
RETURNS (GOODSID DM_INTEGER,
PARENTID DM_INTEGER,
FLG_FOLDER DM_BOOLEAN,
BASE_PARAM TYPE OF COLUMN TS_GOODS.BASE_PARAM,
BASE_PARAM_RU TYPE OF COLUMN TS_GOODS.BASE_PARAM,
CODE TYPE OF COLUMN TS_GOODS.CODE,
CODE_RU TYPE OF COLUMN TS_GOODS.CODE,
TITLE TYPE OF COLUMN TS_GOODS.TITLE,
DETAILS TYPE OF COLUMN TS_GOODS.DETAILS,
FLG_SOCIAL DM_BOOLEAN,
FLG_OLD DM_BOOLEAN,
FLG_REQUIRE_CERTIFICAT DM_BOOLEAN,
FLG_BEST_PRICE DM_BOOLEAN,
FLG_PRICE_NBM DM_BOOLEAN,
FLG_PROMO DM_BOOLEAN,
FLG_NEW DM_BOOLEAN,
FLG_PRICE_FORCED DM_BOOLEAN,
FLG_DISCOUNT DM_BOOLEAN,
FLG_FORCED_ADDON DM_INTEGER,
FLG_SUPPLIER_PROMO DM_INTEGER,
FLG_WEB_HIDE_COMPLECT_ITEMS DM_INTEGER,
FLG_PREORDER DM_INTEGER,
WARRANTY DM_INTEGER,
GOODS_ACNT_ID DM_INTEGER,
GOODS_TYPE_ID DM_INTEGER,
GOODS_TYPE_NAME DM_VARCHAR255,
WEBGOODSTYPE_ID DM_INTEGER,
WEBGOODSTYPE_TITLE DM_VARCHAR128,
WEBGOODSTYPE_TITLE_RU DM_VARCHAR128,
VENDOR_ID DM_INTEGER,
USERID DM_INTEGER,
UMID DM_INTEGER,
SERIAL_TYPE_ID DM_INTEGER,
ORDERNO DM_INTEGER,
USER_FULLNAME DM_VARCHAR512,
CREATE_DATE DM_DATETIME,
NAMEACNT DM_VARCHAR255,
PRICE0 DM_PRICE,
PRICE1 DM_PRICE,
PRICE2 DM_PRICE,
PRICE3 DM_PRICE,
PRICE4 DM_PRICE,
PRICE5 DM_PRICE,
PRICE6 DM_PRICE,
PRICE7 DM_PRICE,
PRICE1_LEI DM_PRICE,
PRICE2_LEI DM_PRICE,
PRICE3_LEI DM_PRICE,
PRICE4_LEI DM_PRICE,
PRICE5_LEI DM_PRICE,
PRICE6_LEI DM_PRICE,
PRICE7_LEI DM_PRICE,
PRICE1_USD DM_PRICE,
PRICE2_USD DM_PRICE,
PRICE3_USD DM_PRICE,
PRICE4_USD DM_PRICE,
PRICE5_USD DM_PRICE,
PRICE6_USD DM_PRICE,
PRICE7_USD DM_PRICE,
CURRENCYID DM_INTEGER,
VENDOR DM_VARCHAR255,
UM_TITLE DM_VARCHAR255,
QTY_ACCOUNT DM_QTY,
QTY_AVAILABLE DM_QTY,
QTY_RESERVE DM_QTY,
QTY_RMA DM_QTY,
QTY_INTERNAL DM_QTY,
QTY_FRANCIZE DM_QTY,
QTY_FILIALE DM_QTY,
QTY_TRANSIT DM_QTY,
GOODS_IMAGE_INDEX DM_INTEGER,
DELIVERY_TYPEID DM_INTEGER,
DELIVERY_TYPENAME TYPE OF COLUMN TS_SYSS.TITLE,
VAT DM_INTEGER,
CASHBACK_PERCENT DM_AMOUNT,
COLORID DM_INTEGER,
COLOR_NAME_RO TYPE OF COLUMN TS_SYSS.TITLE,
COLOR_NAME_RU TYPE OF COLUMN TS_SYSS.VALUE_STR,
TEMPLATEID DM_INTEGER,
ATTRIBUTES DM_INTEGER,
MARGIN17 DM_AMOUNT,
RELATED_KEY DM_VARCHAR128,
PGT_ID DM_INTEGER)
AS
BEGIN
     /* SELECT BY PARENT or PARENT of PARENT */
     IF ((SELECT_MODE=1) OR (SELECT_MODE=2)) THEN
     FOR
        SELECT
              GOODSID, PARENTID, FLG_FOLDER, CODE, code_ru,  TITLE, DETAILS, BASE_PARAM, BASE_PARAM_RU,
              FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, flg_best_price, FLG_PRICE_NBM,
              FLG_PROMO, FLG_NEW,  FLG_PRICE_FORCED, FLG_DISCOUNT, FLG_FORCED_ADDON, FLG_SUPPLIER_PROMO, FLG_WEB_HIDE_COMPLECT_ITEMS,
              FLG_PREORDER,
              WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, VENDOR_ID, USERID, UMID,
              SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT,
              PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,
              PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,

--              PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD,
              CURRENCYID,
              WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU,
              VENDOR, UM_TITLE, QTY_ACCOUNT,
              QTY_AVAILABLE, QTY_RESERVE, QTY_RMA, QTY_INTERNAL, QTY_FRANCIZE, QTY_FILIALE, QTY_TRANSIT,
              GOODS_IMAGE_INDEX, DELIVERY_TYPEID, DELIVERY_TYPENAME,
              vat, cashback_percent, colorid,  color_name_ro, color_name_ru, templateid, attributes, margin17, related_key,
              pgt_id
        FROM
            SP_GET_TS_GOODS_M1(:DT,IIF(:SELECT_MODE=1,:SOURCE_PARENTID,(SELECT PARENTID FROM TS_GOODS WHERE GOODSID=:SOURCE_PARENTID)), :flg_only_in_price,
                               :SEARCH_MASK /* 24.10.2026: cautare in mapa (modul rapid din frmGoods); NULL = toata mapa */)
--        order by FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE
        INTO
              :GOODSID, :PARENTID, :FLG_FOLDER, :CODE, :code_ru,  :TITLE, :DETAILS, :BASE_PARAM, :BASE_PARAM_RU,
              :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFICAT, :flg_best_price, :FLG_PRICE_NBM,
              :FLG_PROMO, :FLG_NEW, :FLG_PRICE_FORCED, :FLG_DISCOUNT,:flg_forced_addon, :FLG_SUPPLIER_PROMO, :FLG_WEB_HIDE_COMPLECT_ITEMS,
              :FLG_PREORDER,
              :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :VENDOR_ID, :USERID, :UMID,
              :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CREATE_DATE, :NAMEACNT,
              :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,

--              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD,
              :CURRENCYID,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU,
              :VENDOR, :UM_TITLE, :QTY_ACCOUNT,
              :QTY_AVAILABLE, :QTY_RESERVE, :QTY_RMA, :QTY_INTERNAL, :QTY_FRANCIZE, :QTY_FILIALE, :QTY_TRANSIT,
              :GOODS_IMAGE_INDEX, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :vat, :cashback_percent, :colorid,
              :color_name_ro, :color_name_ru, :templateid, :attributes, :margin17, :related_key, :pgt_id

        DO
        begin

          SUSPEND;
        end
     ELSE
     /* SELECT by SEARCH CONDITION */
     IF (SELECT_MODE=3) THEN
     FOR
        SELECT
              GOODSID, PARENTID, FLG_FOLDER, CODE, CODE_RU, TITLE, DETAILS, BASE_PARAM, BASE_PARAM_RU,
              FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, flg_best_price, FLG_PRICE_NBM,
              FLG_PROMO, FLG_NEW, FLG_PRICE_FORCED, FLG_DISCOUNT, flg_forced_addon, FLG_SUPPLIER_PROMO, FLG_WEB_HIDE_COMPLECT_ITEMS,
              FLG_PREORDER,
              WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, VENDOR_ID, USERID, UMID,
              SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT,
              PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,
              PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,

              PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD,
              CURRENCYID,
              WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU,
              VENDOR, UM_TITLE, QTY_ACCOUNT,
              QTY_AVAILABLE, QTY_RESERVE, QTY_RMA, QTY_INTERNAL, QTY_FRANCIZE, QTY_FILIALE, QTY_TRANSIT,
              GOODS_IMAGE_INDEX, DELIVERY_TYPEID, DELIVERY_TYPENAME, vat, cashback_percent, colorid,
              color_name_ro, color_name_ru, templateid, attributes, margin17, related_key, pgt_id
        FROM
            SP_GET_TS_GOODS_M3(:DT,:SEARCH_MASK)
--        order by FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE
        INTO
              :GOODSID, :PARENTID, :FLG_FOLDER, :CODE, :code_ru,  :TITLE, :DETAILS, :BASE_PARAM, :BASE_PARAM_RU,
              :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFICAT, :flg_best_price, :FLG_PRICE_NBM,
              :FLG_PROMO, :FLG_NEW, :FLG_PRICE_FORCED, :FLG_DISCOUNT, :flg_forced_addon, :flg_supplier_promo, :FLG_WEB_HIDE_COMPLECT_ITEMS,
              :FLG_PREORDER,
              :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :VENDOR_ID, :USERID, :UMID,
              :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CREATE_DATE, :NAMEACNT,
              :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,

              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD,
              :CURRENCYID,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU,
              :VENDOR, :UM_TITLE, :QTY_ACCOUNT,
              :QTY_AVAILABLE, :QTY_RESERVE, :QTY_RMA, :QTY_INTERNAL, :QTY_FRANCIZE, :QTY_FILIALE, :QTY_TRANSIT,
              :GOODS_IMAGE_INDEX, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :vat, :cashback_percent, :colorid,
              :color_name_ro, :color_name_ru, :templateid, :attributes, :margin17, :related_key, :pgt_id
        DO
          SUSPEND;
        ELSE
        /* SELECT by SEARCH CONDITION FOREIGN_GOODS_CODE*/
        IF (SELECT_MODE=5) THEN
        FOR
        SELECT
              GOODSID, PARENTID, FLG_FOLDER, CODE, CODE_RU, TITLE, DETAILS, BASE_PARAM, BASE_PARAM_RU,
              FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, flg_best_price, FLG_PRICE_NBM,
              FLG_PROMO, FLG_NEW, FLG_PRICE_FORCED, FLG_DISCOUNT, flg_forced_addon, FLG_SUPPLIER_PROMO, FLG_WEB_HIDE_COMPLECT_ITEMS,
              FLG_PREORDER,
              WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, VENDOR_ID, USERID, UMID,
              SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT,
              PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,
              PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,

              PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD,
              CURRENCYID,
              WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU,
              VENDOR, UM_TITLE, QTY_ACCOUNT,
              QTY_AVAILABLE, QTY_RESERVE, QTY_RMA, QTY_INTERNAL, QTY_FRANCIZE, QTY_FILIALE, QTY_TRANSIT,
              GOODS_IMAGE_INDEX, DELIVERY_TYPEID, DELIVERY_TYPENAME, vat, cashback_percent, colorid,
              color_name_ro, color_name_ru, templateid, attributes, margin17, related_key, pgt_id
        FROM
            SP_GET_TS_GOODS_M5(:DT,:SEARCH_MASK)
--        order by FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE
        INTO
              :GOODSID, :PARENTID, :FLG_FOLDER, :CODE, :code_ru,  :TITLE, :DETAILS, :BASE_PARAM, :BASE_PARAM_RU,
              :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFICAT, :flg_best_price, :FLG_PRICE_NBM,
              :FLG_PROMO, :FLG_NEW, :FLG_PRICE_FORCED, :FLG_DISCOUNT, :flg_forced_addon, :flg_supplier_promo, :FLG_WEB_HIDE_COMPLECT_ITEMS,
              :FLG_PREORDER,
              :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :VENDOR_ID, :USERID, :UMID,
              :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CREATE_DATE, :NAMEACNT,
              :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,

              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD,
              :CURRENCYID,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU,
              :VENDOR, :UM_TITLE, :QTY_ACCOUNT,
              :QTY_AVAILABLE, :QTY_RESERVE, :QTY_RMA, :QTY_INTERNAL, :QTY_FRANCIZE, :QTY_FILIALE, :QTY_TRANSIT,
              :GOODS_IMAGE_INDEX, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :vat, :cashback_percent, :colorid,
              :color_name_ro, :color_name_ru, :templateid, :attributes, :margin17, :related_key, :pgt_id
        DO
          SUSPEND;
     ELSE
     /* SELECT RECURSIVE by Available QTY for PARENTED children */
     IF (SELECT_MODE=4) THEN
     FOR
        SELECT
              GOODSID, PARENTID, FLG_FOLDER, CODE, CODE_RU, TITLE, DETAILS, BASE_PARAM, BASE_PARAM_RU,
              FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, flg_best_price, FLG_PRICE_NBM,
              FLG_PROMO, FLG_NEW, FLG_PRICE_FORCED, FLG_DISCOUNT, FLG_FORCED_ADDON, flg_supplier_promo, FLG_WEB_HIDE_COMPLECT_ITEMS,
              FLG_PREORDER,
              WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, VENDOR_ID, USERID, UMID,
              SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT,
              PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,
              PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,

              PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD,
              CURRENCYID,
              WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU,

              VENDOR, UM_TITLE, QTY_ACCOUNT,
              QTY_AVAILABLE, QTY_RESERVE, QTY_RMA, QTY_INTERNAL, QTY_FRANCIZE, QTY_FILIALE, QTY_TRANSIT,
              GOODS_IMAGE_INDEX, DELIVERY_TYPEID, DELIVERY_TYPENAME, vat,cashback_percent, colorid,
              color_name_ro, color_name_ru, templateid, attributes, margin17, related_key, pgt_id
        FROM
             SP_GET_TS_GOODS_M4(:DT,:SOURCE_PARENTID)
        WHERE
             /*$$IBEC$$ (QTY_AVAILABLE>0) or (QTY_FILIALE>0) OR (QTY_FRANCIZE>0) $$IBEC$$*/
             FLG_PRICE_FORCED = 1
--        order by FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE
        INTO
              :GOODSID, :PARENTID, :FLG_FOLDER, :CODE, :CODE_RU, :TITLE, :DETAILS, :BASE_PARAM, :BASE_PARAM_RU,
              :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFICAT, :flg_best_price, :FLG_PRICE_NBM,
              :FLG_PROMO, :FLG_NEW, :FLG_PRICE_FORCED, :FLG_DISCOUNT, :FLG_FORCED_ADDON, :flg_supplier_promo, :FLG_WEB_HIDE_COMPLECT_ITEMS,
              :FLG_PREORDER,
              :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :VENDOR_ID, :USERID, :UMID,
              :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :create_date,  :NAMEACNT,
              :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,

              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD,
              :CURRENCYID,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU,
              :VENDOR, :UM_TITLE, :QTY_ACCOUNT,
              :QTY_AVAILABLE, :QTY_RESERVE, :QTY_RMA, :QTY_INTERNAL, :QTY_FRANCIZE, :QTY_FILIALE, :QTY_TRANSIT,
              :GOODS_IMAGE_INDEX, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :vat, :cashback_percent, :colorid,
              :color_name_ro, :color_name_ru, :templateid, :attributes, :margin17, :related_key, :pgt_id
        DO
          SUSPEND;
        else
        /* SELECT by SEARCH CONDITION FOREIGN_GOODS_CODE*/
        IF (SELECT_MODE=6) THEN
        FOR
        SELECT
              GOODSID, PARENTID, FLG_FOLDER, CODE, CODE_RU, TITLE, DETAILS, BASE_PARAM, BASE_PARAM_RU,
              FLG_SOCIAL, FLG_OLD, FLG_REQUIRE_CERTIFICAT, flg_best_price, FLG_PRICE_NBM,
              FLG_PROMO, FLG_NEW, FLG_PRICE_FORCED, FLG_DISCOUNT, flg_forced_addon, FLG_SUPPLIER_PROMO, FLG_WEB_HIDE_COMPLECT_ITEMS,
              FLG_PREORDER,
              WARRANTY, GOODS_ACNT_ID, GOODS_TYPE_ID, GOODS_TYPE_NAME, VENDOR_ID, USERID, UMID,
              SERIAL_TYPE_ID, ORDERNO, USER_FULLNAME, CREATE_DATE, NAMEACNT,
              PRICE0, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7,
              PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,

              PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD, PRICE6_USD, PRICE7_USD,
              CURRENCYID,
              WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE, WEBGOODSTYPE_TITLE_RU,
              VENDOR, UM_TITLE, QTY_ACCOUNT,
              QTY_AVAILABLE, QTY_RESERVE, QTY_RMA, QTY_INTERNAL, QTY_FRANCIZE, QTY_FILIALE, QTY_TRANSIT,
              GOODS_IMAGE_INDEX, DELIVERY_TYPEID, DELIVERY_TYPENAME, vat, cashback_percent, colorid,
              color_name_ro, color_name_ru, templateid, attributes, margin17, related_key, pgt_id
        FROM
            SP_GET_TS_GOODS_M6(:DT,:SEARCH_MASK)
            order by rel_qty desc, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC
--        order by FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE
        INTO
              :GOODSID, :PARENTID, :FLG_FOLDER, :CODE, :code_ru,  :TITLE, :DETAILS, :BASE_PARAM, :BASE_PARAM_RU,
              :FLG_SOCIAL, :FLG_OLD, :FLG_REQUIRE_CERTIFICAT, :flg_best_price, :FLG_PRICE_NBM,
              :FLG_PROMO, :FLG_NEW, :FLG_PRICE_FORCED, :FLG_DISCOUNT, :flg_forced_addon, :flg_supplier_promo, :FLG_WEB_HIDE_COMPLECT_ITEMS,
              :FLG_PREORDER,
              :WARRANTY, :GOODS_ACNT_ID, :GOODS_TYPE_ID, :GOODS_TYPE_NAME, :VENDOR_ID, :USERID, :UMID,
              :SERIAL_TYPE_ID, :ORDERNO, :USER_FULLNAME, :CREATE_DATE, :NAMEACNT,
              :PRICE0, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI, :PRICE7_LEI,

              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD, :PRICE6_USD, :PRICE7_USD,
              :CURRENCYID,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE, :WEBGOODSTYPE_TITLE_RU,
              :VENDOR, :UM_TITLE, :QTY_ACCOUNT,
              :QTY_AVAILABLE, :QTY_RESERVE, :QTY_RMA, :QTY_INTERNAL, :QTY_FRANCIZE, :QTY_FILIALE, :QTY_TRANSIT,
              :GOODS_IMAGE_INDEX, :DELIVERY_TYPEID, :DELIVERY_TYPENAME, :vat, :cashback_percent, :colorid,
              :color_name_ro, :color_name_ru, :templateid, :attributes, :margin17, :related_key, :pgt_id
        DO
          SUSPEND;



END ^

SET TERM ; ^

COMMIT;

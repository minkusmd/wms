/* ============================================================================
   web_product_rrp_price3.sql

   Scop: pe pagina de produs de pe fantastic.md, cand PRICE3 (RRP-ul real din
   TS_GOODS_FOREIGN al furnizorului activ) e mai mare decit pretul de vinzare
   si flg_epp (bitul 4 din TS_GOODS_FOREIGN.FLAGS) nu este 1, se afiseaza
   PRICE3_LEI ca "pret vechi" taiat.

   Problema gasita: in WEB_GET_GOODS_MIN_INFO, linia
       :price3_lei = :price4_lei;
   face ca azi PRICE3_LEI sa fie mereu identic cu PRICE1_LEI (nu e RRP real).
   Acest script:
     1. adauga output-ul FLG_EPP la WEB_GET_GOODS_MIN_INFO si calculeaza
        PRICE3_LEI / PRICE3_USD din TS_GOODS_FOREIGN.PRICE3 al aceluiasi
        furnizor "cistigator" folosit deja pentru PRICE1_LEI
        (flg_in_price=1, PRICE1 minim);
     2. propaga FLG_EPP prin W_V2_GET_GOODS_INFO_FULL (procedura folosita de
        fantastic.web/models/GoodsInfoFull.php).

   E idempotent: ALTER PROCEDURE redefineste intreaga procedura, deci poate fi
   rulat de mai multe ori fara efecte secundare.

   Rulare: isql -user SYSDBA -password <parola> "<host>/3050:SW" -i web_product_rrp_price3.sql
============================================================================ */

SET TERM ^ ;

ALTER PROCEDURE WEB_GET_GOODS_MIN_INFO (
    AGOODSID INTEGER)
RETURNS (
    GOODSID INTEGER,
    PARENTID INTEGER,
    FLG_FOLDER DM_BOOLEAN,
    BASE_PARAM TYPE OF COLUMN TS_GOODS.BASE_PARAM,
    CODE TYPE OF COLUMN TS_GOODS.CODE,
    BASE_PARAM_RU TYPE OF COLUMN TS_GOODS.BASE_PARAM,
    CODE_RU TYPE OF COLUMN TS_GOODS.CODE,
    TITLE TYPE OF COLUMN TS_GOODS.TITLE,
    DETAILS TYPE OF COLUMN TS_GOODS.DETAILS,
    WARRANTY INTEGER,
    WEBGOODSTYPE_ID INTEGER,
    WEBGOODSTYPE_TITLE_ROM TYPE OF COLUMN TS_GOODS_TYPE.TITLE,
    WEBGOODSTYPE_TITLE_RUS TYPE OF COLUMN TS_GOODS_TYPE.TITLE_RUS,
    VENDOR_ID INTEGER,
    VENDOR TYPE OF COLUMN TS_SYSS.TITLE,
    ORDERNO INTEGER,
    IMAGE_COUNT INTEGER,
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
    VIDEO_COUNT INTEGER,
    HAS_DESCRIPTION DM_BOOLEAN,
    FREE_DELIVERY DM_BOOLEAN,
    FLG_TO_NPSC DM_BOOLEAN,
    WEBTITLE_ROM DM_VARCHAR2048,
    WEBTITLE_RUS DM_VARCHAR2048,
    FLG_BEST_PRICE DM_BOOLEAN,
    LABEL_RO DM_VARCHAR255,
    LABEL_RU DM_VARCHAR255,
    GOODS_TYPE_ID INTEGER,
    COLORID INTEGER,
    COLOR_NAME_RO DM_VARCHAR255,
    COLOR_NAME_RU DM_VARCHAR255,
    CASHBACK_VALUE DM_AMOUNT,
    FLG_CREDIT03 DM_BOOLEAN,
    FLG_CREDIT05 DM_BOOLEAN,
    FLG_CREDIT06 DM_BOOLEAN,
    FLG_CREDIT012 DM_BOOLEAN,
    FLG_PREORDER INTEGER,
    WEB_SHORTTITLE_ROM DM_VARCHAR1024,
    WEB_SHORTTITLE_RUS DM_VARCHAR1024,
    LABEL_RO_URL DM_VARCHAR255,
    LABEL_RU_URL DM_VARCHAR255,
    FLG_EPP INTEGER)
AS
declare ip dm_varchar32;
declare flags dm_integer;
declare rrp_price3 dm_price;
declare rrp_currency3id dm_integer;
declare rrp_flags dm_integer;
begin
  /* Exchange rate for Price_USD */
  select g.goodsid, g.parentid, g.flg_folder, substring(g.base_param from 1 for 255), substring(g.code from 1 for 255),
         substring(g.base_param_ru from 1 for 255), substring(g.code_ru from 1 for 255),
         substring(g.title from 1 for 255), substring(g.details from 1 for 255),
         iif(g.flg_folder = 0, g.warranty, null), g.webgoodstype_id, ts_goods_type.title, ts_goods_type.title_rus,
         g.vendor_id, iif(g.flg_folder = 0,
         (select title
          from ts_syss
          where (syssid = g.vendor_id)), null), g.orderno,
         (select count(goods_image_id)
          from ts_goods_image
          where ts_goods_image.goodsid = g.goodsid),

         /* VIDEO Count */
         (select count(videoid)
          from ts_goods_youtube_video
          where ts_goods_youtube_video.goodsid = g.goodsid),

         /* has Description */
         iif(exists(select ts_goods_descriptions.goodsid
                    from ts_goods_descriptions
                    where ts_goods_descriptions.goodsid = g.goodsid) or exists(select goodsid
                                                                               from ts_goods_dsc
                                                                               where ts_goods_dsc.goodsid = g.goodsid and
                                                                                     ts_goods_dsc.description is not null), 1, 0),
         /* FLG_DELIVERY */
         iif(delivery_typeid = 7513, 1, 0),
         --           COALESCE((SELECT DT_AVIABILITY FROM TDB_GOODS_STOCK_WEB WHERE TDB_GOODS_STOCK_WEB.GOODSID=G.GOODSID),0),
         get_flg_value(g.flags, 8), /* FLG_TO_NPSC */
         get_flg_best_price(g.goodsid), /* FLG_BEST_PRICE */
         g.goods_type_id, g.colorid, s.title, s.value_str
  from ts_goods g
  --          LEFT OUTER JOIN TS_GOODS_PRICE ON (TS_GOODS_PRICE.GOODSID = G.GOODSID)
  --          INNER JOIN TS_CURRENCY ON (TS_CURRENCY.CURRENCYID=TS_GOODS_PRICE.CURRENCYID)
  inner join ts_goods_type on (ts_goods_type.goodstypeid = g.webgoodstype_id)
  left outer join ts_syss s on syssid = g.colorid
  where g.goodsid = :agoodsid
  into :goodsid, :parentid, :flg_folder, :base_param, :code, :base_param_ru, :code_ru, :title, :details, :warranty,
       :webgoodstype_id, :webgoodstype_title_rom, :webgoodstype_title_rus, :vendor_id, :vendor, :orderno, :image_count,
       :video_count, :has_description, :free_delivery, --:AVIABILITY,
       :flg_to_npsc, :flg_best_price, :goods_type_id, :colorid, :color_name_ro, :color_name_ru;

  :webtitle_rom = substring(get_goods_name(:webgoodstype_title_rom, :vendor, :code, :base_param, :details, :color_name_ro) from 1 for 512);
  :web_shorttitle_rom = substring(get_goods_name(:webgoodstype_title_rom, :vendor, :code, :base_param, '', :color_name_ro) from 1 for 255);
  if (coalesce(:code_ru, '') = '') then :code_ru = :code;
  if (coalesce(:base_param_ru, '') = '') then :base_param_ru = :base_param;

  :webtitle_rus = substring(get_goods_name(:webgoodstype_title_rus, :vendor, :code_ru, :base_param_ru, :details, :color_name_ro) from 1 for 512);
  :web_shorttitle_rus = substring(get_goods_name(:webgoodstype_title_rus, :vendor, :code_ru, :base_param_ru, '', :color_name_ru) from 1 for 512);

  select price, price_mdl, flags
  from get_goods_price(:agoodsid, 1, 498)
  into :price4_usd, :price4_lei, :flags;

  :flg_preorder = get_flg_value(:flags, 6);
  select price, price_mdl
  from get_goods_price(:agoodsid, 5, 498)
  into :price5_usd, :price5_lei;

  /* preturile originale a produsului */
  :price1_usd = convert_amount(:price4_lei, 498, 840);
  :price2_usd = :price1_usd;
  :price3_usd = :price1_usd;
  :price4_usd = :price1_usd;
  :price5_usd = convert_amount(:price5_lei, 498, 840);

  /* preturile in lei, curs Exchange */
  :price1_lei = :price4_lei;
  :price2_lei = :price4_lei;
  :price3_lei = :price4_lei;
  :price4_lei = :price4_lei;
  :price5_lei = :price5_lei;

  /* RRP real (PRICE3): dintre furnizorii activi (flg_in_price=1, bit 3),
     luam cel cu PRICE3 cel mai mare dupa convertirea in MDL - nu neaparat
     acelasi furnizor care cistiga pe PRICE1 (unii nu au deloc PRICE3 setat) */
  :flg_epp = 0;
  select first 1 gf.price3, gf.currency3id, gf.flags
  from TS_GOODS_FOREIGN gf
  where gf.goodsid = :agoodsid and get_flg_value(gf.flags, 3) = 1 and gf.price3 > 0
  order by convert_amount(gf.price3, gf.currency3id, 498) desc
  into :rrp_price3, :rrp_currency3id, :rrp_flags;

  if (:rrp_price3 is not null and :rrp_price3 > 0) then
  begin
    :price3_lei = convert_amount(:rrp_price3, :rrp_currency3id, 498);
    :price3_usd = convert_amount(:rrp_price3, :rrp_currency3id, 840);
    :flg_epp = get_flg_value(:rrp_flags, 4);
  end

  select price_mdl
  from get_goods_price(:agoodsid, 6, 498)
  into :price6_lei;
  select price_mdl
  from get_goods_price7(:agoodsid, 498)
  into :price7_lei;

  select first 1 pag.label_ro, pag.label_ru, pag.label_ro_url, pag.label_ru_url
  from tweb_pa_goods pag
  join tweb_promos p on p.promoactionid = pag.promoactionid
  where current_date between start_date and end_date and
        get_flg_value(p.flags, 0) = 1 and
        goodsid = :agoodsid
  into :label_ro, :label_ru, :label_ro_url, :label_ru_url;

  /* pentru ip-urile care scaneaza dam preturi marite */
  ip = rdb$get_context('USER_TRANSACTION', 'CUSTOMER_IP');
  if ((:ip <> '') and (exists(select ip
                              from ts_ip_blacklist
                              where ip = :ip))) then
  begin
    :price1_lei = round(:price1_lei * 1.05, 0);
    :price4_lei = :price1_lei;
  end

  :cashback_value = get_cashback_percent(:goodsid) / 100 * :price1_lei;

  :flg_credit03 = 0; --iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.04, 1, 0);
  :flg_credit05 = 0; --iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.06, 1, 0);
  :flg_credit06 = 0; --iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.12, 1, 0);
  :flg_credit012 = 0; --iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.35, 1, 0);

  if (:goodsid is not null) then suspend;
end
^

ALTER PROCEDURE W_V2_GET_GOODS_INFO_FULL (
    FIRMA INTEGER,
    GOODSID INTEGER)
RETURNS (
    WEB_CATALOG_L3_ID INTEGER,
    VENDOR_ID INTEGER,
    VENDOR DM_VARCHAR60,
    WEBGOODSTYPE_ID INTEGER,
    WEBGOODSTYPE_TITLE_ROM DM_VARCHAR128,
    WEBGOODSTYPE_TITLE_RUS DM_VARCHAR128,
    BASE_PARAM DM_VARCHAR512,
    BASE_PARAM_RU DM_VARCHAR512,
    CODE DM_VARCHAR1024,
    CODE_RU DM_VARCHAR1024,
    TITLE DM_VARCHAR2048,
    DETAILS DM_VARCHAR2048,
    WARRANTY INTEGER,
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
    FLG_PROMO DM_BOOLEAN,
    FLG_NEW DM_BOOLEAN,
    FLG_PRICE_FORCED DM_BOOLEAN,
    FLG_HAS_DESCRIPTION DM_BOOLEAN,
    IMAGE_COUNT INTEGER,
    VIDEO_COUNT INTEGER,
    PSEUDO_DISCOUNT INTEGER,
    VENDOR_URL DM_VARCHAR128,
    PROMO_DAYS_COUNT INTEGER,
    NEW_DAYS_COUNT INTEGER,
    FLG_HAS_DESC_BUTTONS INTEGER,
    PRODUCT_DSC_RUS DM_BLOBTEXT,
    ACTIUNI_LISTA DM_VARCHAR60,
    FILTERID INTEGER,
    FILTERPARAMID INTEGER,
    FILTER_VALUE_ROM DM_VARCHAR2048,
    FILTER_VALUE_RUS DM_VARCHAR2048,
    FILTER_VALUE_ORDERNO INTEGER,
    PRODUCT_DSC_ROM DM_BLOBTEXT,
    FLG_TO_NPSC DM_BOOLEAN,
    PRICE_COLUMN INTEGER,
    META_TITLE_RO TYPE OF COLUMN TWEB_GOODS.META_TITLE_RO,
    META_TITLE_RU TYPE OF COLUMN TWEB_GOODS.META_TITLE_RU,
    META_DESC_RO TYPE OF COLUMN TWEB_GOODS.META_DESC_RO,
    META_DESC_RU TYPE OF COLUMN TWEB_GOODS.META_DESC_RU,
    META_KEY_RO TYPE OF COLUMN TWEB_GOODS.META_KEY_RO,
    META_KEY_RU TYPE OF COLUMN TWEB_GOODS.META_KEY_RU,
    DISCOUNT_VALUE INTEGER,
    WEBTITLE_ROM DM_VARCHAR2048,
    WEBTITLE_RUS DM_VARCHAR2048,
    FLG_DISCOUNT_TYPE DM_BOOLEAN,
    FLG_DISCOUNT_AS_AMOUNT DM_BOOLEAN,
    DISCOUNT_VALUE_MDL INTEGER,
    DISCOUNT_TYPEID INTEGER,
    CASHBACK_VALUE DM_AMOUNT,
    FLG_BEST_PRICE DM_BOOLEAN,
    LABEL_RO DM_VARCHAR128,
    LABEL_RU DM_VARCHAR128,
    FLG_CREDIT03 DM_BOOLEAN,
    FLG_CREDIT05 DM_BOOLEAN,
    FLG_CREDIT06 DM_BOOLEAN,
    FLG_CREDIT012 DM_BOOLEAN,
    FLG_PREORDER DM_BOOLEAN,
    LABEL_RO_URL DM_VARCHAR255,
    LABEL_RU_URL DM_VARCHAR255,
    FLG_EPP INTEGER)
AS
declare variable tmpGOODSID DM_INTEGER;
declare variable tmpGOODS_PARENTID DM_INTEGER;
BEGIN
     /* 25.06.2013 - JOHN */
     /* Web Catalog cu 3 nivele */

     FILTERID = NULL;
     FILTERPARAMID = NULL;
     FILTER_VALUE_ROM = NULL;
     FILTER_VALUE_RUS = NULL;
     FILTER_VALUE_ORDERNO = NULL;

     /* get goods info */
     SELECT A.GOODSID,
            A.BASE_PARAM,
            A.BASE_PARAM_RU,
            A.CODE,
            A.CODE_RU,
            A.TITLE,
            A.DETAILS,
            A.WARRANTY,
            A.WEBGOODSTYPE_ID, A.WEBGOODSTYPE_TITLE_ROM, A.WEBGOODSTYPE_TITLE_RUS,
            A.VENDOR_ID, A.VENDOR,
            IMAGE_COUNT,
            PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI, PRICE7_LEI,
            PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD,
            HAS_DESCRIPTION, /*$$IBEC$$ AVIABILITY, $$IBEC$$*/
            IIF(VENDOR_ID=-1,'',(SELECT VALUE_STR FROM TS_SYSS WHERE SYSSID=VENDOR_ID)),
            IIF(EXISTS(SELECT FILTER_BUTTON_ID FROM TS_GOODS_DESC_BUTTONS WHERE GOODSID = :GOODSID),1,0),
            (SELECT COUNT(VIDEOID) FROM TS_GOODS_YOUTUBE_VIDEO WHERE TS_GOODS_YOUTUBE_VIDEO.GOODSID=:GOODSID),
            A.PARENTID, FLG_TO_NPSC, webtitle_rom, webtitle_rus, flg_best_price, LABEL_RO, LABEL_RU, flg_credit03, flg_credit05, flg_credit06, flg_credit012, flg_preorder,
            label_ro_url, label_ru_url, FLG_EPP
     FROM WEB_GET_GOODS_MIN_INFO(:GOODSID) A

     INTO
         :tmpGOODSID,
         :BASE_PARAM, :base_param_ru, :CODE, :code_ru, :TITLE, :DETAILS, :WARRANTY,
         :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE_ROM, :WEBGOODSTYPE_TITLE_RUS, :VENDOR_ID, :VENDOR,
         :IMAGE_COUNT,
         :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :price6_lei, :price7_lei,
         :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD,
         :FLG_HAS_DESCRIPTION, /*$$IBEC$$ :AVIABILITY, $$IBEC$$*/
         :VENDOR_URL,
         :FLG_HAS_DESC_BUTTONS, :VIDEO_COUNT,
         :tmpGOODS_PARENTID,
         :FLG_TO_NPSC, :webtitle_rom, :webtitle_rus, :flg_best_price,
         :LABEL_RO, :LABEL_RU,
         :flg_credit03, :flg_credit05, :flg_credit06, :flg_credit012, :flg_preorder, :label_ro_url, :label_ru_url,
         :FLG_EPP;

        select discount_value from w_get_discount_value(:goodsid)
          into :discount_value;

        :discount_value_mdl = :discount_value;

     IF (tmpGOODSID IS NULL) THEN EXIT;

     /* Flags */
     FLG_PROMO =        IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=1) ),1,0);
     FLG_NEW =          IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=2) ),1,0);
     FLG_PRICE_FORCED = IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID in (3, 5)) ),1,0);
     PSEUDO_DISCOUNT =  COALESCE((SELECT VALUE_INT FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=4) ),0);

     /* WEB CATALOG */
     WEB_CATALOG_L3_ID = NULL;

     SELECT FIRST 1 L3.CATALOGID, L3.custom_price_column
     FROM TWEB_CATALOG_ITEMS
     INNER JOIN TWEB_CATALOG L3 ON (L3.CATALOGID=TWEB_CATALOG_ITEMS.CATALOGID AND L3.DT=:FIRMA AND GET_FLG_VALUE(L3.FLAGS,0)=1)
     WHERE GOODSPARENTID=:tmpGOODS_PARENTID
     INTO :WEB_CATALOG_L3_ID, :price_column;

     ACTIUNI_LISTA = NULL;
     SELECT LIST(distinct pa.PROMOACTIONID), max(get_flg_value(pa.flags, 2)), max(get_flg_value(pa.flags, 3)), max(discount_typeid) FROM TWEB_PA_GOODS pa
     inner join tweb_promos p on p.promoactionid=pa.promoactionid and current_date >= cast(p.start_date as date) and
                                  current_date <= cast(p.end_date as date) and get_flg_value(p.flags,0) = 1
     inner join tdb_goods_flags gf on gf.goodsid=pa.goodsid and gf.flagtypeid = 3 and gf.dt = 5213
     WHERE pa.GOODSID=:GOODSID
     INTO :ACTIUNI_LISTA, :flg_discount_type, :flg_discount_as_amount, :discount_typeid;

     /* Promo days left count */
     PROMO_DAYS_COUNT = 0;
     IF (FLG_PROMO=1) THEN
     BEGIN
          SELECT 14
          FROM TDB_GOODS_FLAGS
          WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (FLAGTYPEID=1) AND (DT=:FIRMA) /* PROMO */
          INTO :PROMO_DAYS_COUNT;
     END

     /* New Goods days left count */
     NEW_DAYS_COUNT = 0;
     IF (FLG_NEW=1) THEN
     BEGIN
          SELECT 14
          FROM TDB_GOODS_FLAGS
          WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (FLAGTYPEID=2) AND (DT=:FIRMA) /* NEW */
          INTO :NEW_DAYS_COUNT;
     END

     /* Product DSC */
     SELECT DESCRIPTION, DESCRIPTION_RO FROM TS_GOODS_DSC WHERE GOODSID=:GOODSID
     INTO :PRODUCT_DSC_RUS, :PRODUCT_DSC_ROM;

     /* 25.01.2018 - Minchevici */
     /* Denumire si meta tags */
     select goodsname_ro, goodsname_ru from get_goods_names(:GOODSID) into :webtitle_rom, :webtitle_rus;

     select
          meta_title_ro, meta_title_ru, meta_desc_ro, meta_desc_ru, meta_key_ro, meta_key_ru
     from tweb_goods
     where goodsid=:goodsid
     into :meta_title_ro, :meta_title_ru, :meta_desc_ro, :meta_desc_ru, :meta_key_ro, :meta_key_ru;

     :cashback_value = get_cashback_percent(:goodsid) / 100 * :price1_lei;

     SUSPEND;
END
^

SET TERM ; ^

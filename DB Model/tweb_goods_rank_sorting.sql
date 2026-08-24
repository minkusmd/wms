/* ============================================================================
   Sortarea catalogului dupa relevanta in loc de pret crescator

   Modifica doua proceduri:

     GET_GOODS_LIST_BY_CATALOG_F   - decide ordinea si paginarea (48/pagina)
     GET_GOODS_LIST_BY_CATALOG_V2  - doar pasa mai departe noul parametru

   Parametrul nou SORT_MODE (implicit 'rank'):

       'rank'        - ordinea din TWEB_GOODS_RANK.RANK_NO (relevanta cu
                       intercalarea treptelor de pret) - noul comportament
                       implicit al site-ului
       'price_asc'   - pret crescator  (vechiul comportament)
       'price_desc'  - pret descrescator

   Parametrul are DEFAULT, deci apelurile existente cu 3 argumente raman
   valide si primesc automat ordinea dupa relevanta.

   PLASA DE SIGURANTA: daca TWEB_GOODS_RANK este inca goala (scriptul rulat
   dar WEB_CALC_GOODS_RANK neexecutat), RANK_NO lipseste, COALESCE da
   999999999 pentru toate produsele si ordinea revine exact la pretul
   crescator de dinainte. Deci nu exista fereastra in care catalogul sa arate
   aiurea.

   Ruleaza DUPA tweb_goods_rank.sql.
   Script RE-RULABIL (CREATE OR ALTER).
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Ordinea si paginarea -------------------------------------------- */
CREATE OR ALTER PROCEDURE GET_GOODS_LIST_BY_CATALOG_F (
    CATALOGID DM_INTEGER,
    WEB_FILTER_PARAMS DM_VARCHAR1024,
    PAGENO DM_INTEGER,
    SORT_MODE VARCHAR(16) DEFAULT 'rank')
RETURNS (
    GOODSID DM_INTEGER,
    PRICE DM_AMOUNT)
AS
declare SQL dm_blobtext;
declare RECORDS_PER_PAGE dm_integer;
declare STARTROWS dm_integer;
declare TOROWS dm_integer;
declare GOODS_COUNT dm_integer;
declare PAGE_COUNT dm_integer;
declare ORDER_CLAUSE varchar(128);
begin
  PAGENO = coalesce(PAGENO, 1);
  PAGENO = iif(PAGENO < 1, 1, PAGENO);
  SORT_MODE = lower(coalesce(SORT_MODE, 'rank'));
  RECORDS_PER_PAGE = 48;

  /* umple tmp$filters conform filtrelor din URL */
  select goods_count, pages_count
  from PREPARE_GOODS_LIST_BY_CATALOG(:CATALOGID, :WEB_FILTER_PARAMS)
  into :GOODS_COUNT, :PAGE_COUNT;

  STARTROWS = RECORDS_PER_PAGE * (PAGENO - 1) + 1;
  TOROWS    = RECORDS_PER_PAGE * PAGENO;

  if (SORT_MODE = 'price_asc') then
    ORDER_CLAUSE = ' order by price, goodsid ';
  else if (SORT_MODE = 'price_desc') then
    ORDER_CLAUSE = ' order by price desc, goodsid ';
  else
    /* implicit: relevanta; pretul ramine doar criteriu de departajare */
    ORDER_CLAUSE = ' order by rank_no, price, goodsid ';

  SQL = 'select goodsid, price from (
             select distinct f.goodsid,
                    convert_amount(gp.price1, gp.currency1id, 498) price,
                    coalesce(r.rank_no, 999999999) rank_no
             from tmp$filters f
             join ts_goods_price gp on gp.goodsid = f.goodsid
             left join tweb_goods_rank r on r.catalogid = ' || :CATALOGID || '
                                        and r.goodsid = f.goodsid
         )' || :ORDER_CLAUSE || '
         rows ' || :STARTROWS || ' to ' || :TOROWS;

  for execute statement :SQL
      into :GOODSID, :PRICE
  do
  begin
    suspend;
  end
end^

/* --- 2. Lista completa de produse (doar pasa SORT_MODE mai departe) ----- */
CREATE OR ALTER PROCEDURE GET_GOODS_LIST_BY_CATALOG_V2 (
    CATALOGID DM_INTEGER_NN,
    WEB_FILTER_PARAMS DM_VARCHAR1024,
    PAGENO DM_INTEGER,
    SORT_MODE VARCHAR(16) DEFAULT 'rank')
RETURNS (
    GOODSID DM_INTEGER,
    VENDOR_ID DM_INTEGER,
    VENDOR DM_VARCHAR60,
    WEBGOODSTYPE_ID DM_INTEGER,
    WEBGOODSTYPE_TITLE_ROM DM_VARCHAR255,
    WEBGOODSTYPE_TITLE_RUS DM_VARCHAR255,
    BASE_PARAM DM_VARCHAR1024,
    CODE DM_VARCHAR2048,
    TITLE DM_VARCHAR2048,
    DETAILS DM_VARCHAR2048,
    WARRANTY DM_INTEGER,
    PRICE1_LEI DM_PRICE,
    PRICE2_LEI DM_PRICE,
    PRICE3_LEI DM_PRICE,
    PRICE4_LEI DM_PRICE,
    PRICE5_LEI DM_PRICE,
    PRICE6_LEI DM_PRICE,
    PRICE1_USD DM_PRICE,
    PRICE2_USD DM_PRICE,
    PRICE3_USD DM_PRICE,
    PRICE4_USD DM_PRICE,
    PRICE5_USD DM_PRICE,
    FLG_PROMO DM_BOOLEAN,
    FLG_NEW DM_BOOLEAN,
    FLG_PRICE_FORCED DM_BOOLEAN,
    FLG_HASIMAGE DM_BOOLEAN,
    FLG_HAS_DESCRIPTION DM_BOOLEAN,
    FLG_FREE_DELIVERY DM_BOOLEAN,
    FILTERID DM_INTEGER,
    FILTERPARAMID DM_INTEGER,
    FILTER_VALUE_ROM DM_VARCHAR2048,
    FILTER_VALUE_RUS DM_VARCHAR2048,
    FILTER_VALUE_ORDERNO DM_INTEGER,
    PSEUDO_DISCOUNT DM_INTEGER,
    ACTIUNI_LISTA DM_VARCHAR60,
    WEB_CATALOG_L3_ID DM_INTEGER,
    WEB_CATALOG_L1_ORDERNO DM_INTEGER,
    WEB_CATALOG_L2_ORDERNO DM_INTEGER,
    WEB_CATALOG_L3_ORDERNO DM_INTEGER,
    FLG_TO_NPSC DM_BOOLEAN,
    CUSTOM_PRICE_COLUMN DM_PRICECOLUMN,
    DISCOUNT_VALUE DM_INTEGER,
    FLG_DISCOUNT_TYPE DM_BOOLEAN,
    FLG_DISCOUNT_AS_AMOUNT DM_BOOLEAN,
    DISCOUNT_VALUE_MDL DM_INTEGER,
    DISCOUNT_TYPEID DM_INTEGER,
    WEBNAME_ROM DM_VARCHAR1024,
    WEBNAME_RUS DM_VARCHAR1024,
    CASHBACK_VALUE DM_AMOUNT,
    FLG_BEST_PRICE DM_BOOLEAN,
    WEB_SHORTTITLE_ROM DM_VARCHAR1024,
    WEB_SHORTTITLE_RUS DM_VARCHAR1024,
    FLG_CREDIT0 DM_BOOLEAN)
AS
declare SQL               varchar(2048);
declare PARENTGOODSIDLIST varchar(2048);
declare FILTERSLIST       varchar(1024);
declare GOODSPARENTID     DM_INTEGER;
declare HASDATA           DM_BOOLEAN;
declare MIN_PRICE         DM_AMOUNT;
declare MAX_PRICE         DM_AMOUNT;
declare CNT_FILTERS       DM_INTEGER;
declare page_count dm_integer;
declare RECORDSTOSKIP     DM_INTEGER;
declare tmp_cnt dm_integer;
declare firma dm_integer;
declare goods_count dm_integer;
begin
  for select goodsid from get_goods_list_by_catalog_f(:catalogid, :web_filter_params, :pageno, :sort_mode) into :goodsid do
  begin
          /* get goods info */
          SELECT BASE_PARAM, CODE, TITLE, DETAILS, WARRANTY,
                 WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE_ROM, WEBGOODSTYPE_TITLE_RUS, VENDOR_ID, VENDOR,
                 IIF(IMAGE_COUNT>0,1,0),
                 PRICE1_LEI, PRICE2_LEI, PRICE3_LEI, PRICE4_LEI, PRICE5_LEI, PRICE6_LEI,
                 PRICE1_USD, PRICE2_USD, PRICE3_USD, PRICE4_USD, PRICE5_USD,
                 HAS_DESCRIPTION, FREE_DELIVERY,/*$$IBEC$$  AVIABILITY, $$IBEC$$*/ FLG_TO_NPSC, webtitle_rom, webtitle_rus, flg_best_price,
                web_shorttitle_rom, web_shorttitle_rus
          FROM WEB_GET_GOODS_MIN_INFO(:GOODSID)
          INTO
              :BASE_PARAM, :CODE, :TITLE, :DETAILS, :WARRANTY,
              :WEBGOODSTYPE_ID, :WEBGOODSTYPE_TITLE_ROM, :WEBGOODSTYPE_TITLE_RUS, :VENDOR_ID, :VENDOR,
              :FLG_HASIMAGE,
              :PRICE1_LEI, :PRICE2_LEI, :PRICE3_LEI, :PRICE4_LEI, :PRICE5_LEI, :PRICE6_LEI,
              :PRICE1_USD, :PRICE2_USD, :PRICE3_USD, :PRICE4_USD, :PRICE5_USD,
              :FLG_HAS_DESCRIPTION, :FLG_FREE_DELIVERY, /*$$IBEC$$ :AVIABILITY, $$IBEC$$*/ :FLG_TO_NPSC, :webname_rom, :webname_rus, :flg_best_price,
              :web_shorttitle_rom, :web_shorttitle_rus;


          /* calcul discount */
          discount_value = 0;
          select discount_value from w_get_discount_value(:goodsid)
          into :discount_value;

          :discount_value_mdl = :discount_value;

          /* Flags */
          FLG_PROMO =        IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=1) ),1,0);
          FLG_NEW =          IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=2) ),1,0);
          FLG_PRICE_FORCED = IIF(EXISTS(SELECT GOODSID FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID in (3, 5)) ),1,0);
          PSEUDO_DISCOUNT =  COALESCE((SELECT VALUE_INT FROM TDB_GOODS_FLAGS WHERE (TDB_GOODS_FLAGS.GOODSID=:GOODSID) AND (DT=:FIRMA) AND (FLAGTYPEID=4) ),0);
          if (exists(select * from WEB_GET_GOODS_CREDIT_MONTLY_RATE(:goodsid) where LOANPERCENT = 0)) then
             FLG_CREDIT0 = 1;
          else
             FLG_CREDIT0 = 0;

          /* lista Actiunile in care participa produsul, conform Firmei */
          ACTIUNI_LISTA = NULL;
          SELECT LIST(pa.PROMOACTIONID), max(get_flg_value(pa.flags, 2)), max(get_flg_value(pa.flags, 3)), max(pa.discount_typeid) FROM TWEB_PA_GOODS pa
              inner join tdb_goods_flags gf on gf.goodsid=pa.goodsid and gf.flagtypeid = 3
              inner join tweb_promos p on
                    (p.promoactionid=pa.promoactionid) and
                    (current_date >= cast(p.start_date as date)) and
                    (current_date <= cast(p.end_date as date)) and
                    (get_flg_value(p.flags,0) = 1)
              WHERE pa.GOODSID=:GOODSID INTO :ACTIUNI_LISTA, :flg_discount_type, :flg_discount_as_amount, :discount_typeid;

          :cashback_value = get_cashback_percent(:goodsid) / 100 * :price4_lei;

          IF (filtersList IS NULL OR filtersList='10') THEN SUSPEND;
          ELSE
          BEGIN
               HasData=0;
               FOR
                  /* scoatem filtrele si valorilor lor */
                  SELECT
                         gd.FILTERID,
                         gd.FILTERPARAMID,
                         fp.PARAM_VALUE,
                         fp.PARAM_VALUE_RUS,
                         fp.ORDERNO
                  FROM TS_GOODS_DESCRIPTIONS gd
                  INNER JOIN TS_FILTER_PARAMS fp ON (fp.FILTERID=gd.FILTERID AND fp.FILTERPARAMID=gd.FILTERPARAMID)
                  WHERE GOODSID=:GOODSID
                  INTO :FILTERID, :FILTERPARAMID, :FILTER_VALUE_ROM, :FILTER_VALUE_RUS, :FILTER_VALUE_ORDERNO
               DO
               BEGIN

                    HasData=1;
                    SUSPEND;
               END
               IF (HasData=0) THEN
               begin
                   SUSPEND;
               end
          END
--        suspend;
     END


end
^

SET TERM ; ^

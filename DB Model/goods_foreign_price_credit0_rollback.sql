/* ---------------------------------------------------------------------------
   ROLLBACK pentru goods_foreign_price_credit0.sql
   Restaureaza definitiile din 21 august 2026, dinaintea introducerii pretului
   de rate 6 luni 0%. Ordinea conteaza: intii view-ul si procedurile inceteaza
   sa mai foloseasca PRICE_CREDIT0, apoi coloana calculata poate fi stearsa.
   Triggerele view-ului nu au fost modificate, deci nu apar aici.
   --------------------------------------------------------------------------- */

/* 1. View-ul fara PRICE_CREDIT0 --------------------------------------------- */
CREATE OR ALTER VIEW VW_TS_GOODS_FOREIGN (
  GOODSID, CUSTOMERID, DISPLAYNAME, GOODS_CODE, BARCODE, GOODS_TITLE, URL,
  FLG_SUPPLIER_PROMO, FLG_IN_PROMO, FLG_AVAILABLE_QTY, FLG_SUPPLIER_PRIORITY,
  FLG_IN_PRICE, FLG_EPP, FLG_PREORDER, FLG_DRP,
  PRICE0, CURRENCY0ID, CURRENCY0_NAME,
  PRICE1, CURRENCY1ID,
  PRICE2, CURRENCY2ID,
  PRICE3, CURRENCY3ID,
  PRICE4, PRICE4MDL, CURRENCY4ID, CURRENCY4_NAME,
  PRICE5, PRICE5LEI, CURRENCY5ID,
  PRICE6, PRICE6LEI, CURRENCY6ID,
  PRICE7, CURRENCY7ID, CURRENCY7_NAME, PRICE7LEI,
  PROMO_PRICE7, PROMO_CURRENCY7ID, PROMO_CURRENCY7_NAME, PROMO_PRICE7LEI,
  ORD_PRICE7, ORD_CURRENCY7ID,
  LAST_PRICE_DATE, PERCENT47, DIFF47, PRICE6_MDL,
  MARGIN5, MARGIN6, RCP, RCC
) AS
select GOODSID,
       CUSTOMERID,
       (select DISPLAYNAME
        from TS_CUSTOMER C
        where C.CUSTOMERID = GF.CUSTOMERID),
       GOODS_CODE,
       BARCODE,
       GOODS_TITLE,
       URL,
       (select RESULT
        from IS_GOODSID_IN_SUPPLIER_PROMO(GF.CUSTOMERID, GOODSID)) FLG_SUPPLIER_PROMO,
       iif(exists(select B.GOODSID
                  from TWEB_PA_GOODS B
                  inner join TWEB_PROMOS A on (A.PROMOACTIONID = B.PROMOACTIONID) and
                        GET_FLG_VALUE(A.FLAGS, 0) = 1 and
                        current_date between A.START_DATE and A.END_DATE
                  where B.GOODSID = GF.GOODSID), 1, 0) FLG_IN_PROMO,
       GET_FLG_VALUE(FLAGS, 1) FLG_AVAILABLE_QTY,
       GET_FLG_VALUE(FLAGS, 2) FLG_SUPPLIER_PRIORITY,
       GET_FLG_VALUE(FLAGS, 3) FLG_IN_PRICE,
--       GET_FLG_VALUE(FLAGS, 4) FLG_RRP,
       iif (PRICE3>0, 1, 0) FLG_RRP,
--       GET_FLG_VALUE(FLAGS, 5) FLG_CREDIT03,
       GET_FLG_VALUE(FLAGS, 6) FLG_PREORDER,
--       GET_FLG_VALUE(FLAGS, 7) FLG_CREDIT05,
       GET_FLG_VALUE(FLAGS, 8) FLG_DRP,
       PRICE0,
       CURRENCY0ID,
       (select TITLE
        from TS_CURRENCY
        where CURRENCYID = CURRENCY0ID) CURRENCY0_NAME,
       PRICE1,
       CURRENCY1ID,
       PRICE2,
       CURRENCY2ID,
       PRICE3,
       CURRENCY3ID,
       PRICE4,
--       CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498),
       iif(CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498) < 50, round(CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498), 1), CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498)) PRIME4MDL,
       --       round(convert_amount(price4, currency4id, 498)) price4MDL,
       CURRENCY4ID,
       (select TITLE
        from TS_CURRENCY
        where CURRENCYID = CURRENCY4ID) CURRENCY4_NAME,
       PRICE5,
       round(PRICE5 * (select EXCHANGE_RATE
                       from TS_CURRENCY
                       where CURRENCYID = CURRENCY4ID), 0) PRICE5_LEI,
       CURRENCY5ID,
       PRICE6,
       round(PRICE6 * (select EXCHANGE_RATE
                       from TS_CURRENCY
                       where CURRENCYID = CURRENCY7ID), 0) PRICE6_LEI,
       CURRENCY6ID,
       PRICE7,
       CURRENCY7ID,
       (select TITLE
        from TS_CURRENCY
        where CURRENCYID = CURRENCY7ID) CURRENCY7_NAME,
       round(PRICE7 * (select EXCHANGE_RATE
                       from TS_CURRENCY
                       where CURRENCYID = CURRENCY7ID), 0) PRICE7_MDL,

       promo_price7,
       promo_currency7id,
       (select TITLE
        from TS_CURRENCY
        where CURRENCYID = CURRENCY7ID) PROMO_CURRENCY7_NAME,
              round(PROMO_PRICE7 * (select EXCHANGE_RATE
                       from TS_CURRENCY
                       where CURRENCYID = PROMO_CURRENCY7ID), 0) PROMO_PRICE7_MDL,
       ORD_PRICE7,
       ORD_CURRENCY7ID,
       LAST_PRICE_DATE,
       iif(round(CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498)) = 0, 0, round((1 - (PRICE7 * (select EXCHANGE_RATE
                                                                                         from TS_CURRENCY
                                                                                         where CURRENCYID = CURRENCY7ID) / round(CONVERT_AMOUNT(PRICE1, coalesce(CURRENCY1ID, 498), 498)))) * 100, 2)) PERCENT47,
       round(round(CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498)) - PRICE7 * (select EXCHANGE_RATE
                                                                         from TS_CURRENCY
                                                                         where CURRENCYID = CURRENCY7ID), 2) DIFF47,
       round(PRICE6 * (select EXCHANGE_RATE
                       from TS_CURRENCY
                       where CURRENCYID = CURRENCY7ID), 0) PRICE6_MDL,
       MARGIN5,
       MARGIN6,
       RCP,
       RCC
from TS_GOODS_FOREIGN GF
order by GOODS_TITLE;

COMMIT;

/* 2. Procedurile ------------------------------------------------------------ */
SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_GOODS_FOREIGN (
  AGOODSID DM_INTEGER
)
RETURNS (
  GOODSID DM_INTEGER,
  CUSTOMERID DM_INTEGER,
  CUSTOMER_NAME VARCHAR(512),
  GOODS_CODE VARCHAR(512),
  BARCODE VARCHAR(128),
  GOODS_TITLE VARCHAR(2048),
  URL VARCHAR(512),
  FLG_SUPPLIER_PROMO DM_INTEGER,
  FLG_IN_PROMO DM_INTEGER,
  FLG_AVAILABLE_QTY DM_INTEGER,
  FLG_SUPPLIER_PRIORITY DM_INTEGER,
  FLG_IN_PRICE DM_INTEGER,
  FLG_RRP DM_INTEGER,
  FLG_PREORDER DM_INTEGER,
  FLG_DRP DM_INTEGER,
  PRICE0 DM_AMOUNT,
  CURRENCY0ID DM_INTEGER,
  CURRENCY0_NAME DM_VARCHAR16,
  PRICE1 DM_AMOUNT,
  CURRENCY1ID DM_INTEGER,
  PRICE2 DM_AMOUNT,
  CURRENCY2ID DM_INTEGER,
  PRICE3 DM_AMOUNT,
  CURRENCY3ID DM_INTEGER,
  PRICE4 DM_AMOUNT,
  PRICE4MDL DM_AMOUNT,
  CURRENCY4ID DM_INTEGER,
  CURRENCY4_NAME DM_VARCHAR16,
  PRICE5 DM_AMOUNT,
  PRICE5_LEI DM_AMOUNT,
  CURRENCY5ID DM_INTEGER,
  PRICE6 DM_AMOUNT,
  PRICE6_LEI DM_AMOUNT,
  CURRENCY6ID DM_INTEGER,
  PRICE7 DM_AMOUNT,
  CURRENCY7ID DM_INTEGER,
  CURRENCY7_NAME DM_VARCHAR16,
  PRICE7_LEI DM_AMOUNT,
  ORD_PRICE7 DM_AMOUNT,
  ORD_CURRENCY7ID DM_INTEGER,
  LAST_PRICE_DATE DM_DATETIME,
  LAST_PRICE7_DATE DM_DATETIME,
  PERCENT47 DM_AMOUNT,
  DIFF47 DM_AMOUNT,
  PRICE6_MDL DM_AMOUNT,
  FLG_MIN_PURCHAISE_PRICE DM_BOOLEAN,
  MARGIN5 DM_AMOUNT,
  MARGIN6 DM_AMOUNT,
  PRICE2_MDL DM_AMOUNT,
  PRICE3_MDL DM_AMOUNT,
  RCP DM_AMOUNT,
  RCC DM_INTEGER,
  RCC_NAME DM_VARCHAR10
)
AS
declare min_goodsid dm_integer;
declare min_customerid dm_integer;
declare min_goods_code dm_varchar512;
declare min_price6_mdl dm_amount;
BEGIN
  FOR
    select GOODSID,
           CUSTOMERID,
           (select DISPLAYNAME from TS_CUSTOMER C where C.CUSTOMERID = GF.CUSTOMERID) customer_name,
           GOODS_CODE,
           BARCODE,
           GOODS_TITLE,
           URL,
           (select result from IS_GOODSID_IN_SUPPLIER_PROMO(gf.customerid, goodsid)) FLG_SUPPLIER_PROMO,
           iif(exists(select b.goodsid
            from TWEB_PA_GOODS B
            inner join TWEB_PROMOS A on (A.PROMOACTIONID = B.PROMOACTIONID) and
                GET_FLG_VALUE(A.FLAGS, 0) = 1 and
                current_date between A.START_DATE and A.END_DATE
            where B.GOODSID = gf.GOODSID), 1, 0) FLG_IN_PROMO,
           GET_FLG_VALUE(FLAGS, 1) FLG_AVAILABLE_QTY,
           GET_FLG_VALUE(FLAGS, 2) FLG_SUPPLIER_PRIORITY,
           GET_FLG_VALUE(FLAGS, 3) FLG_IN_PRICE,
           GET_FLG_VALUE(FLAGS, 4) FLG_RRP,
--           GET_FLG_VALUE(FLAGS, 5) FLG_CREDIT03,
           GET_FLG_VALUE(FLAGS, 6) FLG_PREORDER,
           GET_FLG_VALUE(FLAGS, 7) FLG_DRP,
--           GET_FLG_VALUE(FLAGS, 8) FLG_CREDIT012,
           PRICE0,
           CURRENCY0ID,
           (select TITLE from TS_CURRENCY where CURRENCYID = CURRENCY0ID) CURRENCY0_NAME,
            PRICE1,
            currency1id,
            PRICE2,
            currency2id,
            PRICE3,
            currency3id,
           price4,
--           iif (convert_amount(price4, currency4id, 498) < 50, round(convert_amount(price4, currency4id, 498), 1), convert_amount(price4, currency4id, 498, 0)) prime4mdl,
           round(convert_amount(price4, currency4id, 498)) price4MDL,
           currency4id,
           (select TITLE from TS_CURRENCY where CURRENCYID = currency4id) CURRENCY4_NAME,
           PRICE5,
           round(PRICE5 * (select exchange_rate from ts_currency where currencyid = currency5id), 0) PRICE5_LEI,
           currency5id,
           PRICE6,
           round(PRICE6 * (select exchange_rate from ts_currency where currencyid = currency6id), 0) PRICE6_LEI,
           currency6id,
           PRICE7,
           CURRENCY7ID,
           (select TITLE from TS_CURRENCY where CURRENCYID = CURRENCY7ID) CURRENCY7_NAME,
           round(PRICE7 * (select exchange_rate from ts_currency where currencyid = currency7id), 0) PRICE7_MDL,
           ORD_PRICE7,
           ORD_CURRENCY7ID,
           LAST_PRICE_DATE,
           LAST_PRICE7_DATE,
           IIF(round(convert_amount(price1, currency1id, 498)) = 0,
            0,
            round((1 - (PRICE7 * (select exchange_rate from ts_currency where currencyid = currency7id) / round(convert_amount(price1, currency1id, 498)))) * 100,2)
           ) PERCENT47,
           round(round(convert_amount(price1, currency1id, 498)) - convert_amount(PRICE7, currency7id, 498,1), 2) DIFF47,
           round(PRICE6 * (select exchange_rate from ts_currency where currencyid = currency7id),0) PRICE6_MDL,
           margin5,
           margin6,
           rcp,
           rcc,
           (select title from ts_currency where currencyid = rcc)
    from TS_GOODS_FOREIGN GF
    where goodsid = :agoodsid
    order by GOODS_TITLE
    INTO :GOODSID,
         :CUSTOMERID,
         :CUSTOMER_NAME,
         :GOODS_CODE,
         :BARCODE,
         :GOODS_TITLE,
         :URL,
         :FLG_SUPPLIER_PROMO,
         :FLG_IN_PROMO,
         :FLG_AVAILABLE_QTY,
         :FLG_SUPPLIER_PRIORITY,
         :FLG_IN_PRICE,
         :FLG_RRP,
--         :FLG_CREDIT03,
         :FLG_PREORDER,
--         :FLG_CREDIT05,
         :FLG_DRP,
         :PRICE0,
         :CURRENCY0ID,
         :CURRENCY0_NAME,
         :PRICE1,
         :CURRENCY1ID,
         :PRICE2,
         :CURRENCY2ID,
         :PRICE3,
         :CURRENCY3ID,
         :PRICE4,
         :PRICE4MDL,
         :CURRENCY4ID,
         :CURRENCY4_NAME,
         :PRICE5,
         :PRICE5_LEI,
         :currency5id,
         :PRICE6,
         :PRICE6_LEI,
         :currency6id,
         :PRICE7,
         :CURRENCY7ID,
         :CURRENCY7_NAME,
         :PRICE7_LEI,
         :ORD_PRICE7,
         :ORD_CURRENCY7ID,
         :LAST_PRICE_DATE,
         :LAST_PRICE7_DATE,
         :PERCENT47,
         :DIFF47,
         :PRICE6_MDL,
         :margin5,
         :margin6,
         :rcp,
         :rcc,
         :rcc_name
  DO
  BEGIN

    :min_customerid = -1;
    :min_goodsid = -1;
    :min_goods_code = -1;
    :min_price6_mdl = -1;

    begin
        /* gasim toate pamele pina la root a produsului */
        insert into tmp$goodsqty(goodsid)
        select goodsid  from get_ts_goods_path(:goodsid);

        select first 1 CUSTOMERID, GF.GOODSID, GF.GOODS_CODE,
        min(convert_amount(GF.PRICE6, gf.currency6id,  498)) price6lei
        from vw_TS_GOODS_FOREIGN GF join(select goodsid, min(A.PRICE6LEI) PRICE6LEI
                                      from VW_TS_GOODS_FOREIGN A
                                      where A.GOODSID = :GOODSID and
                                            A.FLG_IN_PRICE = 1
                                      group by goodsid
                                            ) B on (B.PRICE6LEI = gf.PRICE6LEI and b.goodsid = gf.goodsid)
        where GF.FLG_IN_PRICE = 1 and gf.goodsid = :goodsid
        group by CUSTOMERID, GOODSID, GOODS_CODE
        into :min_customerid, :min_goodsid, :min_goods_code, :min_price6_mdl;
        when any do
        begin
           /* de gasit furnizorul prioritar */
           exception err_general_error 'goodsid=#'||:goodsid;
        end
    end

    :price2_mdl = convert_amount(:price2, :currency2ID, 498);
    :price3_mdl = convert_amount(:price3, :currency3ID, 498);

    if ((:customerid = :min_customerid) and (:goodsid = :min_goodsid) and (:goods_code = :min_goods_code)) then
      :flg_min_purchaise_price = 1;
    else
      :flg_min_purchaise_price = 0;

    begin


        SUSPEND;
        when any do
        begin
          exception err_general_error 'goodsid=#' || :goodsid;
        end
    end
  END
END^

CREATE OR ALTER PROCEDURE WEB_GET_GOODS_CREDIT_MONTLY_RATE (
  GOODSID DM_INTEGER
)
RETURNS (
  LOANMONTHS DM_INTEGER,
  LOANPERCENT DM_AMOUNT,
  LOANRATE DM_AMOUNT,
  INSURANCE DM_AMOUNT
)
AS
declare price1_lei dm_amount;
declare price7_lei dm_amount;
declare price0 dm_amount;
declare price7 dm_amount;
begin
  select price_mdl
  from get_goods_price(:goodsid, 1, 498)
  into :price1_lei;

  select price_mdl
  from get_goods_price7(:goodsid, 498)
  into :price7_lei;

  /* 12 luni 0% */

--  if (iif(iif(((:price7_lei > 0) and (:price0 > 0)), (:price7 / :price0), 0) > 1.26, 1, 0) = 1) then begin
--    :loanmonths = 12;
--    :loanpercent = 0;
--
--    :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--    :insurance = 0;
--    suspend;
--  end
--
--  /* 6 luni 0% */
--  if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.18, 1, 0) = 1) then
--  begin
--      :loanmonths = 6;
--      :loanpercent = 0;
--      :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--      :insurance = 0;
--      suspend;
--  end
--
--  /* 4 luni 0% */
--      if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.15, 1, 0) = 1) then
--    begin
--    :loanmonths = 4;
--    :loanpercent = 0;
--    :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--    :insurance = 0;
--    suspend;
--  end
--
--  /* 3 luni 0% */
--    if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.10, 1, 0) = 1) then
--  begin
--    :loanmonths = 4;
--    :loanpercent = 0;
--
--    :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--    :insurance = 0;
--    suspend;
--  end

 /******************** 1% *****************************/
--
--  /* 3 luni 1% */
--  begin
--  :loanmonths = 3;
--  :loanpercent = 1;
--  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--  :insurance = 0;
--  suspend;
--  end
--
--  /* 4 luni 1% */
----    if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.06, 1, 0) = 1) then
--    begin
--      :loanmonths = 4;
--      :loanpercent = 1;
--      :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--      insurance = 0;
--      suspend;
--    end
--
--  /* 5 luni 0% */
----  if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.06, 1, 0) = 1) then begin
--      :loanmonths = 5;
--      :loanpercent = 1;
--      :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--      insurance = 0;
--      suspend;
----  end
--  /* 7 luni 0% */
----    if (iif(iif(:price7_lei > 0, (:price1_lei / :price7_lei), 0) > 1.16, 1, 0) = 1) then begin
--  :loanmonths = 7;
--  :loanpercent = 1;
--  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--  :insurance = 0;
--   suspend;
--  --  end
--
--  /* 12 luni cu dobinda */
--  :loanmonths = 13;
--  :loanpercent = 1;
--  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--  :insurance = 0;
--  suspend;

  /*************************** 2%  ****************************/
  /* 12 luni cu dobinda */
  :loanmonths = 12;
  :loanpercent = 2;
  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
  :insurance = 0;
  suspend;

  /* 24 luni cu dobinda */
  :loanmonths = 24;
  :loanpercent = 2;
  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
  :insurance = 0;
  suspend;

  /* 36 luni cu dobinda */
  :loanmonths = 36;
  :loanpercent = 2;
  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
  :insurance = 0;
  suspend;

    /* 48 luni cu dobinda */
  :loanmonths = 48;
  :loanpercent = 2;
  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
  :insurance = 0;
  suspend;

--  /* 48 luni cu dobinda */
--  :loanmonths = 48;
--  :loanpercent = 2;
--  :loanrate = monthlyrate(price1_lei, :loanmonths, :loanpercent);
--  :insurance = 0;
--  suspend;

end^

SET TERM ; ^

COMMIT;

DROP PROCEDURE GET_GOODS_PRICE_CREDIT0;

COMMIT;

/* 3. Coloana revine la starea initiala: simpla coloana de date, goala -------- */
SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
             WHERE RDB$RELATION_NAME = 'TS_GOODS_FOREIGN'
               AND RDB$FIELD_NAME = 'PRICE_CREDIT0')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_GOODS_FOREIGN DROP PRICE_CREDIT0';
END^

SET TERM ; ^

COMMIT;

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_GOODS_FOREIGN'
                   AND RDB$FIELD_NAME = 'PRICE_CREDIT0')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_GOODS_FOREIGN ADD PRICE_CREDIT0 DM_AMOUNT';
END^

SET TERM ; ^

COMMIT;

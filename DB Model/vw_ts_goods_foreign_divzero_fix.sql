/* ============================================================================
   VW_TS_GOODS_FOREIGN - corectie "Floating-point divide by zero" (21 sep 2026)

   Simptom in WMS: la editarea unui cod de furnizor (ex. bifarea FLG_IN_PRICE la
   produsul 392061, furnizor 206074) apare "Arithmetic exception, numeric overflow,
   or string truncation - Floating-point divide by zero". Mesajul e unul singur in
   Firebird; "string truncation" e doar antetul generic, eroarea reala e impartirea.

   Cauza: coloana calculata PERCENT47 era protejata doar pentru PRICE4 = 0, dar
   imparte la round(PRICE1 in lei). Orice rind cu PRICE4 <> 0 si PRICE1 = 0 facea
   sa pice ORICE SELECT din view care atinge rindul (grila, refresh dupa salvare).
   La 21 sep 2026 erau 2190 de astfel de rinduri, toate in afara pricelist-ului
   (PRICE4 ramas de la ultima evaluare, PRICE1 = 0).

   Corectie: PERCENT47 = 0 si cind impartitorul (PRICE1 in lei) este 0. Restul
   view-ului este neschimbat (definitia de mai jos e cea din baza SW, extrasa cu
   RDB$VIEW_SOURCE). CREATE OR ALTER pastreaza triggerele view-ului si drepturile.

   Script RE-RULABIL.
   ============================================================================ */

CREATE OR ALTER VIEW VW_TS_GOODS_FOREIGN (
    GOODSID, CUSTOMERID, DISPLAYNAME, GOODS_CODE, BARCODE, GOODS_TITLE, URL, FLG_SUPPLIER_PROMO,
    FLG_IN_PROMO, FLG_AVAILABLE_QTY, FLG_SUPPLIER_PRIORITY, FLG_IN_PRICE, FLG_EPP, FLG_PREORDER,
    FLG_DRP, PRICE0, CURRENCY0ID, CURRENCY0_NAME, PRICE1, CURRENCY1ID, PRICE2, CURRENCY2ID, PRICE3,
    CURRENCY3ID, PRICE4, PRICE4MDL, CURRENCY4ID, CURRENCY4_NAME, PRICE5, PRICE5LEI, CURRENCY5ID,
    PRICE6, PRICE6LEI, CURRENCY6ID, PRICE7, CURRENCY7ID, CURRENCY7_NAME, PRICE7LEI, PROMO_PRICE7,
    PROMO_CURRENCY7ID, PROMO_CURRENCY7_NAME, PROMO_PRICE7LEI, ORD_PRICE7, ORD_CURRENCY7ID,
    LAST_PRICE_DATE, PERCENT47, DIFF47, PRICE6_MDL, MARGIN5, MARGIN6, RCP, RCC, PRICE_CREDIT0)
AS
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
       iif(round(CONVERT_AMOUNT(PRICE4, CURRENCY4ID, 498)) = 0
           /* impartitorul real este PRICE1: fara aceasta conditie view-ul dadea
              "divide by zero" la articolele cu PRICE4 <> 0 si PRICE1 = 0 */
           or round(CONVERT_AMOUNT(PRICE1, coalesce(CURRENCY1ID, 498), 498)) = 0, 0, round((1 - (PRICE7 * (select EXCHANGE_RATE
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
       RCC,
       PRICE_CREDIT0
from TS_GOODS_FOREIGN GF
order by GOODS_TITLE;

COMMIT;

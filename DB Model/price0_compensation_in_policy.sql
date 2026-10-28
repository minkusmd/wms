/* ------------------------------------------------------------------------
   Compensarea marjei doar in politica de preturi (21 oct 2026)

   Decizia userului (21 oct 2026): coeficientul de compensare (x1.05 la furnizorii
   cu PRICE0 < PRICE7: Ultra 202294, Accent 198, Comitek 1455, AIEA 74995,
   Elcore 225846) traieste DOAR in formulele regulilor politicii de preturi
   (TPRICE_GOODSTYPE, coloana 6, de ex. "((:vprice0 * 1.05) * 1.02)"), adica
   acolo unde se vede si se editeaza in WMS ("Politica de preturi"). Orice alta
   copie a coeficientului se elimina:

     1. regulile proprii ale furnizorilor compensati, inserate de price0_global.sql
        (pasul 7c), NU aveau furnizorul in TPRICE_SUPPLIERS, deci editorul nu le
        arata (250 de reguli in 250 de politici) desi GETGOODSFORMULABYRULES le
        aplica -> se adauga perechile (politica, furnizor) lipsa, ca regulile sa
        fie vizibile si editabile;
     2. GET_GOODS_COST nu mai inmulteste PRICE0 cu factorul furnizorului; parametrul
        WITH_FACTOR ramine in semnatura (ignorat) ca apelurile din WMS
        (frmPriceTypesUnit) si din proceduri sa nu se schimbe;
     3. GET_GOODS_PRICE_CREDIT0 (pretul in rate 0%) si UPDATE_COMPLECTPRICES
        (PRICE0 al setului) folosesc costul real, fara factor;
     4. coloana calculata TS_GOODS_FOREIGN.PRICE_CREDIT0 fara factor;
     5. tabela TPRICE_SUPPLIER_COST se sterge.

   Triggerul TS_GOODS_FOREIGN_BIU si regulile (formulele) NU se ating: PRICE6/PRICE1
   ramin identice. Se schimba doar pretul in rate 0% (PRICE_CREDIT0 scade acolo unde
   cost x 1.16 depasea PRICE1 numai datorita factorului) si PRICE0 al seturilor la
   urmatorul UPDATE_COMPLECTPRICES.

   Atentie (comportament existent): stergerea unui furnizor din politica
   (TPRICE_SUPPLIERS_BD) ii sterge si regulile proprii din acea politica.

   Script re-rulabil. Revenire: price0_compensation_in_policy_rollback.sql
   ------------------------------------------------------------------------ */

SET TERM ^ ;

/* 1. Furnizorii cu reguli proprii devin vizibili in politica ---------------- */
INSERT INTO TPRICE_SUPPLIERS (PGT_ID, SUPPLIERID)
SELECT DISTINCT T.PGT_ID, T.SUPPLIERID
FROM TPRICE_GOODSTYPE T
JOIN TPRICE P ON P.PGT_ID = T.PGT_ID
WHERE T.SUPPLIERID IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM TPRICE_SUPPLIERS S
                  WHERE S.PGT_ID = T.PGT_ID AND S.SUPPLIERID = T.SUPPLIERID)^

COMMIT^

/* 2. Costul produsului fara factorul furnizorului --------------------------- */
CREATE OR ALTER PROCEDURE GET_GOODS_COST (GOODSID DM_INTEGER,
TOCURRENCYID DM_INTEGER,
WITH_FACTOR DM_INTEGER)
RETURNS (PRICE DM_PRICE,
PRICE_MDL DM_PRICE,
CURRENCYID DM_INTEGER)
AS
begin
  /* Ca GET_GOODS_PRICE7, dar costul fiecarui rand = PRICE0 daca GF_USE_PRICE0,
     altfel PRICE7. Minimul dintre furnizorii in pret.
     21.10.2026: WITH_FACTOR nu mai are efect (compensarea marjei sta doar in
     formulele politicii de preturi); parametrul ramine pentru apelurile existente. */
  :price = 0;
  :price_mdl = null;
  :currencyid = :tocurrencyid;

  select min(iif(GF_USE_PRICE0(gf.PRICE0, gf.CURRENCY0ID, gf.PRICE7, gf.CURRENCY7ID) = 1,
                 gf.PRICE0 * (select c.transfer_rate from ts_currency c where c.currencyid = coalesce(gf.currency0id, gf.currency7id)),
                 gf.PRICE7 * (select c.transfer_rate from ts_currency c where c.currencyid = gf.currency7id)))
  from TS_GOODS_FOREIGN gf
  where gf.GOODSID = :GOODSID and get_flg_value(gf.flags, 3) = 1
  into :PRICE_MDL;

  /* niciun furnizor in pret: ultimul rand cu pret (ca GET_GOODS_PRICE7) */
  if (:PRICE_MDL is null) then
    select first 1
           iif(GF_USE_PRICE0(gf.PRICE0, gf.CURRENCY0ID, gf.PRICE7, gf.CURRENCY7ID) = 1,
               gf.PRICE0 * (select c.transfer_rate from ts_currency c where c.currencyid = coalesce(gf.currency0id, gf.currency7id)),
               gf.PRICE7 * (select c.transfer_rate from ts_currency c where c.currencyid = gf.currency7id))
    from TS_GOODS_FOREIGN gf
    where gf.GOODSID = :GOODSID and gf.PRICE7 > 0
    order by gf.LAST_PRICE_DATE desc
    into :PRICE_MDL;

  if (:PRICE_MDL is null) then
  begin
    :PRICE_MDL = 0;
    suspend;
    exit;
  end

  if (:tocurrencyid <> 498) then
    select round(:PRICE_MDL / TRANSFER_RATE, 2) from TS_CURRENCY where CURRENCYID = :TOCURRENCYID into :PRICE;
  else
    :PRICE = round(:PRICE_MDL);

  suspend;
end^

/* 3. Pretul in rate 0% si seturile pe costul real --------------------------- */
CREATE OR ALTER PROCEDURE GET_GOODS_PRICE_CREDIT0 (GOODSID DM_INTEGER)
RETURNS (PRICE_MDL DM_AMOUNT)
AS
declare price1_lei dm_amount;
declare cost_lei dm_amount;
declare c_cost_markup dm_amount;
begin
  /* adaosul minim peste cost care acopera comisionul bancii la ratele 0% */
  c_cost_markup = 1.16;

  PRICE_MDL = 0;
  price1_lei = 0;
  cost_lei = 0;

  /* pretul cash de site */
  select price_mdl
  from get_goods_price(:GOODSID, 1, 498)
  into :price1_lei;

  /* 21.10.2026: costul = PRICE0 (cu garda GF_USE_PRICE0), altfel PRICE7; fara factor */
  select price_mdl
  from get_goods_cost(:GOODSID, 498, 0)
  into :cost_lei;

  price1_lei = coalesce(:price1_lei, 0);
  cost_lei = coalesce(:cost_lei, 0);

  /* fara pret cash nu exista nici oferta in rate */
  if (:price1_lei > 0) then
    PRICE_MDL = maxvalue(:price1_lei, round(:cost_lei * :c_cost_markup, 0));

  if (PRICE_MDL is null) then
    PRICE_MDL = 0;

  suspend;
end^

CREATE OR ALTER PROCEDURE UPDATE_COMPLECTPRICES (COMPLECTGOODSID DM_INTEGER)
AS
begin
  update ts_goods_foreign gf set
            price3 = (select sum(convert_amount((select price from get_goods_price(c.goodsid,  1, 498)), 498, 840, 1) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            price4 = (select sum((select price_mdl from get_goods_price(c.goodsid,  4, gf.currency4id)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            price5 = (select sum((select price_mdl from get_goods_price(c.goodsid,  5, gf.currency5id)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            price6 = (select sum((select price_mdl from get_goods_price(c.goodsid,  6, gf.currency6id)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            ord_price7 = (select sum((select price_mdl from get_goods_price7(c.goodsid, 498)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            /* 21.10.2026: costul setului din PRICE0 al componentelor (cu garda), fara factor de furnizor */
            price0 = (select sum((select price_mdl from get_goods_cost(c.goodsid, 498, 0)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
            currency0id = 498,
            currency1id = 498,
            currency3id = 840,
            currency4id = 498,
            currency5id = 498,
            currency6id = 498,
            ord_currency7id = 498
    where goodsid = :complectgoodsid;
end^

COMMIT^

/* 4. Pretul in rate 0% pe rand de furnizor, fara factor --------------------- */
ALTER TABLE TS_GOODS_FOREIGN ALTER PRICE_CREDIT0 COMPUTED BY (
  maxvalue(coalesce(PRICE1, 0),
           round(iif(GF_USE_PRICE0(PRICE0, CURRENCY0ID, PRICE7, CURRENCY7ID) = 1,
                     PRICE0 * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = coalesce(CURRENCY0ID, CURRENCY7ID)),
                     coalesce(PRICE7, 0) * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = CURRENCY7ID))
                 * 1.16, 0)))^

COMMIT^

/* 5. Tabela cu factorul pe furnizor dispare --------------------------------- */
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPRICE_SUPPLIER_COST')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPRICE_SUPPLIER_COST';
END^

COMMIT^

SET TERM ; ^

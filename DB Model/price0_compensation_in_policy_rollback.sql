/* ------------------------------------------------------------------------
   Revenire pentru price0_compensation_in_policy.sql (21 oct 2026)

   Readuce factorul de compensare pe furnizor in afara politicii, exact ca in
   price0_global.sql (19 oct 2026): tabela TPRICE_SUPPLIER_COST cu factorii 1.05,
   GET_GOODS_COST cu WITH_FACTOR activ, GET_GOODS_PRICE_CREDIT0 si
   UPDATE_COMPLECTPRICES pe costul cu factor, coloana calculata PRICE_CREDIT0
   cu factor. Textele obiectelor sint copiate din price0_global.sql.

   NU sterge perechile (politica, furnizor) adaugate in TPRICE_SUPPLIERS:
   triggerul TPRICE_SUPPLIERS_BD ar sterge odata cu ele si regulile proprii ale
   furnizorilor (compensarea din formule). Perechile sint inofensive si corecte.

   Script re-rulabil.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

/* 1. Factorul de compensare pe furnizor ------------------------------------- */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPRICE_SUPPLIER_COST')) THEN
    EXECUTE STATEMENT 'CREATE TABLE TPRICE_SUPPLIER_COST (
      SUPPLIERID DM_INTEGER NOT NULL,
      COST_FACTOR DM_AMOUNT DEFAULT 1 NOT NULL,
      NOTE DM_VARCHAR255,
      CONSTRAINT PK_TPRICE_SUPPLIER_COST PRIMARY KEY (SUPPLIERID))';
END^

COMMIT^

/* furnizorii cu PRICE0 < PRICE7; factorul = compensarea marjei (decizia userului: 5%) */
UPDATE OR INSERT INTO TPRICE_SUPPLIER_COST (SUPPLIERID, COST_FACTOR, NOTE)
VALUES (202294, 1.05, 'ULTRA DISTRIBUTION: PRICE7/PRICE0 ~1.039 (oct 2026)') MATCHING (SUPPLIERID)^
UPDATE OR INSERT INTO TPRICE_SUPPLIER_COST (SUPPLIERID, COST_FACTOR, NOTE)
VALUES (198, 1.05, 'ACCENT ELECTRONIC: PRICE7/PRICE0 ~1.059 (oct 2026)') MATCHING (SUPPLIERID)^
UPDATE OR INSERT INTO TPRICE_SUPPLIER_COST (SUPPLIERID, COST_FACTOR, NOTE)
VALUES (1455, 1.05, 'COMITEK: PRICE7/PRICE0 ~1.053 (oct 2026)') MATCHING (SUPPLIERID)^
UPDATE OR INSERT INTO TPRICE_SUPPLIER_COST (SUPPLIERID, COST_FACTOR, NOTE)
VALUES (74995, 1.05, 'AIEA: PRICE7/PRICE0 ~1.044 (oct 2026)') MATCHING (SUPPLIERID)^
UPDATE OR INSERT INTO TPRICE_SUPPLIER_COST (SUPPLIERID, COST_FACTOR, NOTE)
VALUES (225846, 1.05, 'ELCORE DISTRIBUTION: PRICE7/PRICE0 ~1.047 (oct 2026)') MATCHING (SUPPLIERID)^

/* 2. Costul cu factorul furnizorului ---------------------------------------- */
CREATE OR ALTER PROCEDURE GET_GOODS_COST (GOODSID DM_INTEGER,
TOCURRENCYID DM_INTEGER,
WITH_FACTOR DM_INTEGER)
RETURNS (PRICE DM_PRICE,
PRICE_MDL DM_PRICE,
CURRENCYID DM_INTEGER)
AS
begin
  /* Ca GET_GOODS_PRICE7, dar costul fiecarui rand = PRICE0 daca GF_USE_PRICE0,
     altfel PRICE7. WITH_FACTOR = 1: PRICE0 inmultit cu factorul furnizorului
     (TPRICE_SUPPLIER_COST) - cost comparabil cu vechiul PRICE7 (rate, seturi);
     WITH_FACTOR = 0: costul real (marja). Minimul dintre furnizorii in pret. */
  :price = 0;
  :price_mdl = null;
  :currencyid = :tocurrencyid;

  select min(iif(GF_USE_PRICE0(gf.PRICE0, gf.CURRENCY0ID, gf.PRICE7, gf.CURRENCY7ID) = 1,
                 gf.PRICE0 * (select c.transfer_rate from ts_currency c where c.currencyid = coalesce(gf.currency0id, gf.currency7id))
                   * iif(:WITH_FACTOR = 1, coalesce((select s.COST_FACTOR from TPRICE_SUPPLIER_COST s where s.SUPPLIERID = gf.CUSTOMERID), 1), 1),
                 gf.PRICE7 * (select c.transfer_rate from ts_currency c where c.currencyid = gf.currency7id)))
  from TS_GOODS_FOREIGN gf
  where gf.GOODSID = :GOODSID and get_flg_value(gf.flags, 3) = 1
  into :PRICE_MDL;

  /* niciun furnizor in pret: ultimul rand cu pret (ca GET_GOODS_PRICE7) */
  if (:PRICE_MDL is null) then
    select first 1
           iif(GF_USE_PRICE0(gf.PRICE0, gf.CURRENCY0ID, gf.PRICE7, gf.CURRENCY7ID) = 1,
               gf.PRICE0 * (select c.transfer_rate from ts_currency c where c.currencyid = coalesce(gf.currency0id, gf.currency7id))
                 * iif(:WITH_FACTOR = 1, coalesce((select s.COST_FACTOR from TPRICE_SUPPLIER_COST s where s.SUPPLIERID = gf.CUSTOMERID), 1), 1),
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

/* 3. Rate 0% si seturi pe costul cu factor ---------------------------------- */
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

  /* 18.10.2026: costul = PRICE0 (cu garda) x factorul furnizorului, altfel PRICE7 */
  select price_mdl
  from get_goods_cost(:GOODSID, 498, 1)
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
            /* 18.10.2026: costul setului din PRICE0 al componentelor (cu factorul furnizorului) */
            price0 = (select sum((select price_mdl from get_goods_cost(c.goodsid, 498, 1)) * qty) from ts_complecte c where c.parentgoods_id=:complectgoodsid and c.qty>0),
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

/* 4. Coloana calculata cu factor -------------------------------------------- */
ALTER TABLE TS_GOODS_FOREIGN ALTER PRICE_CREDIT0 COMPUTED BY (
  maxvalue(coalesce(PRICE1, 0),
           round(iif(GF_USE_PRICE0(PRICE0, CURRENCY0ID, PRICE7, CURRENCY7ID) = 1,
                     PRICE0 * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = coalesce(CURRENCY0ID, CURRENCY7ID))
                       * coalesce((select COST_FACTOR from TPRICE_SUPPLIER_COST where SUPPLIERID = CUSTOMERID), 1),
                     coalesce(PRICE7, 0) * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = CURRENCY7ID))
                 * 1.16, 0)))^

COMMIT^

/* 5. Drepturi --------------------------------------------------------------- */
GRANT SELECT ON TPRICE_SUPPLIER_COST TO PUBLIC^

COMMIT^

SET TERM ; ^

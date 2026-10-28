/* ------------------------------------------------------------------------
   Politica de preturi calculata integral din PRICE0 (18 oct 2026)

   Inlocuieste price0_suppliers.sql (3 oct 2026: PRICE0 doar la 198/202294/1455,
   fara compensare). Deciziile userului (17-18 oct 2026):

     - baza formulelor coloanei 6 = PRICE0 la TOTI furnizorii, daca PRICE0 > 0,
       PRICE7 > 0 si 85% <= PRICE0/PRICE7 <= 150% (comparat in USD); altfel PRICE7
       (functia GF_USE_PRICE0, folosita si de pretul in rate / marja);
     - la furnizorii cu PRICE0 < PRICE7 (Ultra, Accent, Comitek, AIEA, Elcore) marja
       se compenseaza IN FORMULA regulilor: :vprice7 -> (:vprice0 * 1.05); factorul
       sta in TPRICE_SUPPLIER_COST; daca garda cade, formula compensata se aplica
       peste PRICE7 (+5%) - acceptat;
     - regulile acestor furnizori modificate manual dupa 3 oct (compensare facuta de
       mina) revin la coeficientul dinainte de 3 oct si apoi primesc x1.05; regulile
       create dupa 3 oct se sterg (politica primeste copia regulii generale x1.05);
     - pretul in rate 0% = max(pret, cost * 1.16), cost = PRICE0 * factorul
       furnizorului (garda) sau PRICE7; marja si flagul credit 0% pe costul PRICE0;
     - seturile (UPDATE_COMPLECTPRICES) primesc si PRICE0 = suma costurilor.

   Regulile se rescriu toate: in coloana 6 nu mai ramane :vprice7
   (CALCGOODSFORMULACOLUMN6 intelege ambele variabile, cu aceeasi baza).
   Copia regulilor: TPRICE_GOODSTYPE_BAK_20261018 (se face o singura data).
   Script re-rulabil. Efectul pe preturi apare la urmatorul UPDATE al fiecarui
   rand (recalcul: "Recalcula preturile" / UPDATE_PRICES_WITH_RULE).
   Revenire: price0_global_rollback.sql
   ------------------------------------------------------------------------ */

SET TERM ^ ;

/* istoricul regulilor (TPRICE_GOODSTYPE_AI/AU) cere UserID in context */
EXECUTE BLOCK AS
BEGIN
  IF (RDB$GET_CONTEXT('USER_SESSION', 'UserID') IS NULL) THEN
    RDB$SET_CONTEXT('USER_SESSION', 'UserID', 1);
END^

/* 1. Factorul de compensare pe furnizor ------------------------------------- */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPRICE_SUPPLIER_COST')) THEN
    EXECUTE STATEMENT 'CREATE TABLE TPRICE_SUPPLIER_COST (
      SUPPLIERID DM_INTEGER NOT NULL,
      COST_FACTOR DM_AMOUNT DEFAULT 1 NOT NULL,
      NOTE DM_VARCHAR255,
      CONSTRAINT PK_TPRICE_SUPPLIER_COST PRIMARY KEY (SUPPLIERID))';
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPRICE_GOODSTYPE_BAK_20261018')) THEN
    EXECUTE STATEMENT 'CREATE TABLE TPRICE_GOODSTYPE_BAK_20261018 (
      PGT_ID DM_INTEGER NOT NULL,
      PRICECOLUMN DM_INTEGER NOT NULL,
      MIN_VALUE DM_INTEGER NOT NULL,
      MAX_VALUE DM_INTEGER,
      FORMULA DM_VARCHAR512,
      SUPPLIERID DM_INTEGER NOT NULL,
      MIN_MARGIN DM_INTEGER,
      ROUND_UP DM_NUMERIC,
      ADJUST DM_INTEGER,
      MIN_MARGIN_PERCENT DM_AMOUNT)';
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

/* copia regulilor, o singura data (rularile urmatoare nu o suprascriu) */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM TPRICE_GOODSTYPE_BAK_20261018)) THEN
    INSERT INTO TPRICE_GOODSTYPE_BAK_20261018 (PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, SUPPLIERID,
                                               MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT)
    SELECT PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, SUPPLIERID,
           MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT
    FROM TPRICE_GOODSTYPE;
END^

COMMIT^

/* 2. Garda PRICE0 ----------------------------------------------------------- */
CREATE OR ALTER FUNCTION GF_USE_PRICE0 (PRICE0 DM_AMOUNT, CURRENCY0ID DM_INTEGER,
                                        PRICE7 DM_AMOUNT, CURRENCY7ID DM_INTEGER)
RETURNS SMALLINT
AS
declare B0 DM_AMOUNT;
declare B7 DM_AMOUNT;
begin
  /* 1 = PRICE0 (achizitie) e baza de calcul; 0 = PRICE7 (indicativ).
     PRICE0 se crede doar intre 85% si 150% din PRICE7, comparat in USD:
     sub 85% / peste 150% e de regula alta valuta sau un import gresit (Teocom). */
  if (coalesce(:PRICE0, 0) <= 0 or coalesce(:PRICE7, 0) <= 0) then
    return 0;
  :B7 = CONVERT_AMOUNT(:PRICE7, :CURRENCY7ID, 840, 1);
  :B0 = CONVERT_AMOUNT(:PRICE0, coalesce(:CURRENCY0ID, :CURRENCY7ID), 840, 1);
  return iif(:B0 > 0 and :B7 > 0 and :B0 >= :B7 * 0.85 and :B0 <= :B7 * 1.5, 1, 0);
end^

/* 3. Formula coloanei 6: :vprice0 si :vprice7 primesc aceeasi baza ---------- */
CREATE OR ALTER FUNCTION CALCGOODSFORMULACOLUMN6 (FORMULA DM_VARCHAR255,
PRICE_USD DM_AMOUNT,
MIN_MARGIN DM_AMOUNT,
MIN_MARGIN_PERCENT DM_AMOUNT)
RETURNS DM_AMOUNT
AS
declare tmp_value dm_amount;
begin
  :tmp_value = 0;
  /* 18.10.2026: baza (PRICE0 sau PRICE7, aleasa in TS_GOODS_FOREIGN_BIU) */
  :FORMULA = replace(:FORMULA, ':vprice0', :PRICE_USD);
  :FORMULA = replace(:FORMULA, ':vprice7', :PRICE_USD);
   begin
     execute statement 'select round('||:formula||', 2) from rdb$database' into :tmp_value;
     return :tmp_value;
   end
   when any do
      exception err_general_error 'Formula: '||coalesce(:formula, 'nan')||' baza='||coalesce(:price_usd, 'null');
end^

/* 4. Costul pe produs (marja, pretul in rate, seturi) ----------------------- */
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

CREATE OR ALTER FUNCTION GET_GOODS_MARGIN (GOODSID DM_INTEGER)
RETURNS DM_AMOUNT
AS
declare PRICE1 DM_AMOUNT;
declare COST0 DM_AMOUNT;
begin
  /* 18.10.2026: marja pe costul real (PRICE0 cu garda), nu pe PRICE7 */
  select PRICE_MDL
  from GET_GOODS_PRICE(:GOODSID, 1, 498)
  into :PRICE1;
  select PRICE_MDL
  from GET_GOODS_COST(:GOODSID, 498, 0)
  into :COST0;
  if (COST0 <= 0) then
    return 0;
  else
    return round(((:PRICE1 / :COST0) -1) *100, 2);
end^

CREATE OR ALTER FUNCTION GET_FLG_CREDIT0 (GOODSID DM_INTEGER)
RETURNS INTEGER
AS
declare PRICE1 DM_AMOUNT;
declare COST0 DM_AMOUNT;
begin
  /* 18.10.2026: costul real (PRICE0 cu garda) in loc de PRICE7; conditia neschimbata */
  select PRICE_MDL
  from GET_GOODS_PRICE(:GOODSID, 1, 498)
  into :PRICE1;
  select PRICE_MDL
  from GET_GOODS_COST(:GOODSID, 498, 0)
  into :COST0;
  if (COST0 <= 0) then
    return 0;
  else
    return iif((:PRICE1 / :COST0) * 100 < 3, 0, 1);
end^

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

/* 5. Pretul in rate 0% pe rand de furnizor ---------------------------------- */
ALTER TABLE TS_GOODS_FOREIGN ALTER PRICE_CREDIT0 COMPUTED BY (
  maxvalue(coalesce(PRICE1, 0),
           round(iif(GF_USE_PRICE0(PRICE0, CURRENCY0ID, PRICE7, CURRENCY7ID) = 1,
                     PRICE0 * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = coalesce(CURRENCY0ID, CURRENCY7ID))
                       * coalesce((select COST_FACTOR from TPRICE_SUPPLIER_COST where SUPPLIERID = CUSTOMERID), 1),
                     coalesce(PRICE7, 0) * (select EXCHANGE_RATE from TS_CURRENCY where CURRENCYID = CURRENCY7ID))
                 * 1.16, 0)))^

COMMIT^

/* 6. Triggerul de calcul ---------------------------------------------------- */
CREATE OR ALTER TRIGGER TS_GOODS_FOREIGN_BIU FOR TS_GOODS_FOREIGN
ACTIVE BEFORE INSERT OR UPDATE POSITION 5
as
declare TMPPRICE4 DM_AMOUNT;
declare TMPCURRENCY4ID DM_INTEGER;
declare LISTOFPROMOACTIONID DM_VARCHAR1024;--declare usd_rate dm_amount;
declare MIN_MARGIN DM_AMOUNT;
declare MIN_MARGIN_PERCENT DM_AMOUNT;
declare RULESID DM_INTEGER;
declare FORMULA DM_VARCHAR255;
declare TMPPRICE DM_AMOUNT;--declare pret2 dm_amount;
declare TMPPRICE7_USD DM_AMOUNT;
declare FLG_PROMO DM_BOOLEAN;
declare PROMOACTIONIDS DM_VARCHAR255;
declare pgt_cnt dm_integer;
declare list_pgt_id dm_varchar128;
/* 18.10.2026 - baza coloanei 6 din PRICE0 la toti furnizorii (GF_USE_PRICE0) */
declare BASE7_USD DM_AMOUNT;
declare FLG_USE_PRICE0 DM_BOOLEAN;
begin
  /* Trigger text */
  if (rdb$get_context('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') then
    exit;
  new.PRICE2 = 0;
  new.PRICE8 = 0;/* max(pret4, pret6 + maargine) */

  :FLG_PROMO = 0;
  :LISTOFPROMOACTIONID = '';
  begin
    /* pretul 0 lei se seteaza in cazul unei promotii fictive */
    :TMPPRICE4 = 0;
    :TMPCURRENCY4ID = 498;
    :FLG_PROMO = 0;
    select PRICE, CURRENCYID
    from SP_CALCULATE_PRICES_BY_PROMO(new.GOODSID, new.CUSTOMERID)
    into :TMPPRICE4, :TMPCURRENCY4ID;
    /* daca nimic nu s-a intors se presupune ca produsul e in promotie fake si preturile nu trebuie schimbate! */
    if (:TMPPRICE4 > 0) then
    begin
      :FLG_PROMO = 1;
      new.PRICE2 = :TMPPRICE4;
      new.CURRENCY2ID = :TMPCURRENCY4ID;
      new.PRICE5 = CONVERT_AMOUNT(new.PRICE2, new.CURRENCY2ID, new.CURRENCY5ID);
      new.PRICE6 = CONVERT_AMOUNT(new.PRICE2, new.CURRENCY2ID, new.CURRENCY6ID);
    end
    when any do
    begin
      select list(P.PROMOACTIONID)
      from TWEB_PA_GOODS PAG
      join TWEB_PROMOS P on P.PROMOACTIONID = PAG.PROMOACTIONID and
            GET_FLG_VALUE(P.FLAGS, 0) = 1
      where PAG.GOODSID = new.GOODSID
      into :PROMOACTIONIDS;

      if (:LISTOFPROMOACTIONID = '') then
        :LISTOFPROMOACTIONID = ' Produsul #' || new.GOODSID || ', in promotiile (' || :PROMOACTIONIDS || ')';
      else
        :LISTOFPROMOACTIONID = :LISTOFPROMOACTIONID || ascii_char(13) || ascii_char(10) || ' Produsul #' || new.GOODSID || ', in promotiile(' || :PROMOACTIONIDS || ')';
    end

  end

  new.PROMO_PRICE7 = null;
  new.PROMO_CURRENCY7ID = null;

  select coalesce(PRICE7, 0), coalesce(CURRENCY7ID, 840)
  from GET_PROMO_PRICE7(new.GOODSID, new.CUSTOMERID)
  into new.PROMO_PRICE7, new.PROMO_CURRENCY7ID;

  if (octet_length(:LISTOFPROMOACTIONID) > 0) then
    exception ERR_GENERAL_ERROR :LISTOFPROMOACTIONID;

  /* calculul pretului coloanei 7 in $ */
  --    :price7usd = convert_amount(new.price7,  new.currency7id,  840);
  --    select transfer_rate from ts_currency where currencyid=840 into :usd_rate;

  /*  Daca produsul e in stoc la furnizor  */
  /*  FLG_IN_PRICE = 1                     */
  if (GET_FLG_VALUE(new.FLAGS, 3) = 1) then
  begin
    :RULESID = -1;
    select count(distinct c.PGT_ID), list(c.pgt_id)
         from TWEB_CATALOG C
         inner join TWEB_CATALOG_ITEMS I on I.CATALOGID = C.CATALOGID and
               C.PGT_ID > 0
         inner join TS_GOODS G on G.PARENTID = I.GOODSPARENTID and
               G.GOODSID = new.GOODSID
    into :pgt_cnt, :list_pgt_id;
    if ((:pgt_cnt) > 1) then
      exception ERR_GENERAL_ERROR 'Eroare! Pentru acest produs ' || new.goodsid || ' sunt mai multe politici de pret! [' || :list_pgt_id;

    select distinct c.PGT_ID
    from TWEB_CATALOG C
    inner join TWEB_CATALOG_ITEMS I on I.CATALOGID = C.CATALOGID and
          C.PGT_ID > 0
    inner join TS_GOODS G on G.PARENTID = I.GOODSPARENTID and
          G.GOODSID = new.GOODSID
    into :RULESID;

    /* daca e promotie si este price7 atunci il setam ca valoare implicita */
    /* 19.02.2024 */
    if (new.PROMO_PRICE7 > 0) then
    begin
      new.PRICE7 = new.PROMO_PRICE7;
      new.CURRENCY7ID = new.PROMO_CURRENCY7ID;
    end
    else
    begin
      new.PROMO_PRICE7 = 0;
      new.PROMO_CURRENCY7ID = 0;

      new.PRICE7 = new.ORD_PRICE7;
      new.CURRENCY7ID = new.ORD_CURRENCY7ID;
    end
   /* -------------------------------------------------------------------- */

    if (FLG_PROMO = 0) then
    begin
      if ((GET_FLG_VALUE(new.FLAGS, 7) = 0) or (new.PRICE6 = 0)) then
      /* daca nu este setat Diler Recomented Price - FLG_DRP sau produsul nu are pret 6*/
      begin
        new.PRICE6 = 0;

        :TMPPRICE7_USD = CONVERT_AMOUNT(new.PRICE7, new.CURRENCY7ID, 840, 0);

        /* 18.10.2026: baza pret6 = PRICE0 (achizitie) la toti furnizorii, daca
           GF_USE_PRICE0 (PRICE0 intre 85% si 150% din PRICE7, in USD); altfel PRICE7.
           Compensarea furnizorilor cu PRICE0 < PRICE7 e in formulele lor
           (:vprice0 * factor, TPRICE_SUPPLIER_COST). PRICE7 = 0 -> baza 0, ca inainte. */
        :BASE7_USD = CONVERT_AMOUNT(new.PRICE7, new.CURRENCY7ID, 840, 1);
        :FLG_USE_PRICE0 = GF_USE_PRICE0(new.PRICE0, new.CURRENCY0ID, new.PRICE7, new.CURRENCY7ID);
        if (:FLG_USE_PRICE0 = 1) then
          :TMPPRICE = CONVERT_AMOUNT(new.PRICE0, coalesce(new.CURRENCY0ID, new.CURRENCY7ID), 840, 1);
        else
          :TMPPRICE = :BASE7_USD;

        select FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
        from GETGOODSFORMULABYRULES(:RULESID, 6, new.CUSTOMERID, :TMPPRICE)
        into :FORMULA, :MIN_MARGIN, :MIN_MARGIN_PERCENT;

        if (row_count = 0) then
          exception ERR_GENERAL_ERROR 'No rules found! rulesid=' || :RULESID;
        new.PRICE6 = CONVERT_AMOUNT(CALCGOODSFORMULACOLUMN6(:FORMULA, :TMPPRICE, :MIN_MARGIN, :MIN_MARGIN_PERCENT),
                                    840, new.CURRENCY6ID, 1);
      end
    end

    /* calculul pret4 din pret4, numai din pret6 */
    new.PRICE4 = 0;

    :TMPPRICE = CONVERT_AMOUNT(new.PRICE6, new.CURRENCY6ID, 840, 1);
    select FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
    from GETGOODSFORMULABYRULES(:RULESID, 4, new.CUSTOMERID, :TMPPRICE)
    into :FORMULA, :MIN_MARGIN, :MIN_MARGIN_PERCENT;

    if (coalesce(:FORMULA, '') = '') then
      exception ERR_GENERAL_ERROR 'Nu este formula de calcul! goodsid=' || new.GOODSID || ', rules:' || :RULESID || ', customerid:' || new.CUSTOMERID || ', price:' || :TMPPRICE;
    if (coalesce(:TMPPRICE, -1) = -1) then
      exception ERR_GENERAL_ERROR 'Nu este pret pentru calcul! goodsid=' || new.GOODSID;
    select CONVERT_AMOUNT(PRICE4, 840, new.CURRENCY4ID, 1), PRICE8
    from CALCGOODSFORMULACOLUMN4(:FORMULA, :TMPPRICE, CONVERT_AMOUNT(new.PRICE6, new.CURRENCY6ID, 840), CONVERT_AMOUNT(new.PRICE6, new.CURRENCY6ID, 840), :MIN_MARGIN, :MIN_MARGIN_PERCENT)
    into new.PRICE4, new.PRICE8;

    /* calculul pret1 din pret4, pret2, pret3 */
    /* pret RRP */
    new.PRICE3 = coalesce(new.PRICE3, 0);

    /* pret8 se calcula marginea la pret6 */
    if (new.PRICE2 > 0) then
      new.PRICE1 = CONVERT_AMOUNT(new.PRICE2, new.CURRENCY2ID, new.CURRENCY1ID, 1);
    else
    begin
      /* 18.10.2026: PRICE8 e NULL cind regula coloanei 4 n-are marja minima (CALCGOODSFORMULACOLUMN4);
         maxvalue(NULL, ...) dadea PRICE1 = NULL si exceptie in CALCGOODSFORMULACOLUMN5 -> atunci PRICE4 */
      if ( (new.PRICE3 > 0) and (get_flg_value(new.flags, 4) = 1) ) then
        new.PRICE1 = maxvalue(coalesce(CONVERT_AMOUNT(new.PRICE8, 840, coalesce(new.CURRENCY1ID, 498), 1),
                                       CONVERT_AMOUNT(new.PRICE4, new.CURRENCY4ID, coalesce(new.CURRENCY1ID, 498), 1)),
                              CONVERT_AMOUNT(new.PRICE3, new.CURRENCY3ID, coalesce(new.CURRENCY1ID, 498), 1));
      else
        new.PRICE1 = CONVERT_AMOUNT(new.PRICE4, new.CURRENCY4ID, new.CURRENCY1ID, 1);
    end

    if (FLG_PROMO = 0) then
    begin
      /* calculat pret5 */
      new.PRICE5 = 0;
      select FORMULA, MIN_MARGIN, MIN_MARGIN_PERCENT
      from GETGOODSFORMULABYRULES(:RULESID, 5, new.CUSTOMERID, :TMPPRICE)
      into :FORMULA, :MIN_MARGIN, :MIN_MARGIN_PERCENT;
      new.PRICE5 = CALCGOODSFORMULACOLUMN5(:FORMULA, new.PRICE1, new.PRICE6, new.CURRENCY6ID);
      new.PRICE5 = CONVERT_AMOUNT(new.PRICE5, 840, new.CURRENCY5ID, 1);
    end

  end

  /* modificat data ultimilor modificari pentru Pret1 si Pret7 */
  /* 05.01.2022 Sergiu */
  if (new.PRICE1 <> old.PRICE1) then
    new.LAST_PRICE_DATE = localtimestamp;
  if (new.PRICE7 <> old.PRICE7) then
    new.LAST_PRICE7_DATE = localtimestamp;
  /* daca nu se introduce price0 el trebuie sa fie egal cu price7 */
  if (new.price0=0) then new.price0 = new.price7;
end^

COMMIT^

/* 7. Regulile coloanei 6 ---------------------------------------------------- */
EXECUTE BLOCK AS
declare SUP DM_INTEGER;
declare PGT DM_INTEGER;
declare FACTOR DM_AMOUNT;
declare W VARCHAR(40);
begin
  /* 7a. Compensarea facuta de mina dupa 3 oct (cand PRICE0 a devenit baza la
     Accent / Ultra / Comitek): coeficientul revine la cel dinainte de 3 oct
     (din TPRICE_GOODSTYPE_HISTORY), apoi primeste factorul la pasul 7d.
     Fiecare rand se schimba doar daca formula e exact cea de azi (18 oct). */
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 2 and MIN_VALUE = 0 and FORMULA = ':vprice7*1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.03' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 3 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.00' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 4 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.01' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 6 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.01' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 7 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.03' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 8 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.00' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 17 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.03';
  update TPRICE_GOODSTYPE set FORMULA = '(:vprice7)' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 43 and MIN_VALUE = 0 and FORMULA = '(:vprice7*1.03)';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.0' where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 44 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  update TPRICE_GOODSTYPE set FORMULA = '(:vprice7 *1.0)' where PRICECOLUMN = 6 and SUPPLIERID = 1455 and PGT_ID = 6 and MIN_VALUE = 0 and FORMULA = '(:vprice7 *1.03)';
  update TPRICE_GOODSTYPE set FORMULA = ':vprice7 * 1.02' where PRICECOLUMN = 6 and SUPPLIERID = 1455 and PGT_ID = 89 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.05';
  update TPRICE_GOODSTYPE set FORMULA = '(:vprice7 * 1.04)' where PRICECOLUMN = 6 and SUPPLIERID = 225846 and PGT_ID = 6 and MIN_VALUE = 0 and FORMULA = '(:vprice7 * 1.09)';

  /* 7b. Regulile create dupa 3 oct (pina atunci furnizorul folosea regula generala
     a politicii): se sterg; la 7c politica primeste copia regulii generale. */
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 87 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 88 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 89 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 198 and PGT_ID = 173 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 2 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 3 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 4 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 6 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 7 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 38 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.02';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 43 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.03';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 44 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 87 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 88 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 89 and MIN_VALUE = 0 and FORMULA = ':vprice7 *1.05';
  delete from TPRICE_GOODSTYPE where PRICECOLUMN = 6 and SUPPLIERID = 202294 and PGT_ID = 173 and MIN_VALUE = 0 and FORMULA = ':vprice7 * 1.04';

  /* 7c. Furnizorii compensati primesc regula proprie in fiecare politica in care au
     produse (orice rand TS_GOODS_FOREIGN, si cele scoase din pret) si nu au inca:
     copia regulilor generale ale politicii (aceleasi intervale si marje). */
  for select SUPPLIERID from TPRICE_SUPPLIER_COST where COST_FACTOR <> 1 into :SUP do
    for select distinct c.PGT_ID
        from TS_GOODS_FOREIGN f
        join TS_GOODS g on g.GOODSID = f.GOODSID
        join TWEB_CATALOG_ITEMS i on i.GOODSPARENTID = g.PARENTID
        join TWEB_CATALOG c on c.CATALOGID = i.CATALOGID and c.PGT_ID > 0
        where f.CUSTOMERID = :SUP
        into :PGT do
      if (not exists(select 1 from TPRICE_GOODSTYPE t where t.PGT_ID = :PGT and t.SUPPLIERID = :SUP)) then
        insert into TPRICE_GOODSTYPE (PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, SUPPLIERID,
                                      MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT)
        select PGT_ID, PRICECOLUMN, MIN_VALUE, MAX_VALUE, FORMULA, :SUP,
               MIN_MARGIN, ROUND_UP, ADJUST, MIN_MARGIN_PERCENT
        from TPRICE_GOODSTYPE
        where PGT_ID = :PGT and PRICECOLUMN = 6 and SUPPLIERID = -1;

  /* 7d. Compensarea: baza din formula -> (:vprice0 * factor). Formulele care au deja
     "(:vprice0 * " sint compensate (re-rulare) si nu se ating. */
  for select SUPPLIERID, COST_FACTOR from TPRICE_SUPPLIER_COST where COST_FACTOR <> 1 into :SUP, :FACTOR do
  begin
    :W = trim(trailing '0' from cast(cast(:FACTOR as numeric(9,4)) as varchar(20)));
    :W = '(:vprice0 * ' || :W || ')';
    update TPRICE_GOODSTYPE
    set FORMULA = replace(FORMULA, ':vprice7', :W)
    where PRICECOLUMN = 6 and SUPPLIERID = :SUP and FORMULA like '%:vprice7%';
    update TPRICE_GOODSTYPE
    set FORMULA = replace(FORMULA, ':vprice0', :W)
    where PRICECOLUMN = 6 and SUPPLIERID = :SUP and FORMULA like '%:vprice0%'
          and FORMULA not like '%(:vprice0 * %';
  end

  /* 7e. Toate celelalte reguli: doar numele variabilei (PRICE0 = PRICE7 la acesti
     furnizori, pretul nu se schimba). */
  update TPRICE_GOODSTYPE
  set FORMULA = replace(FORMULA, ':vprice7', ':vprice0')
  where PRICECOLUMN = 6 and FORMULA like '%:vprice7%';
end^

COMMIT^

/* 8. Drepturi --------------------------------------------------------------- */
GRANT SELECT ON TPRICE_SUPPLIER_COST TO PUBLIC^
GRANT EXECUTE ON FUNCTION GF_USE_PRICE0 TO PUBLIC^
GRANT EXECUTE ON PROCEDURE GET_GOODS_COST TO PUBLIC^

COMMIT^

SET TERM ; ^

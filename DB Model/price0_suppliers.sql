/* ------------------------------------------------------------------------
   Politica de preturi din PRICE0 - doar Accent, Ultra Distribution, Comitek (3 oct 2026)

   Inlocuieste regula din price0_pricing.sql (2 oct 2026), care era globala si
   majora rezultatul cu 5%. Algoritmul cerut de user:

     - furnizorii 198 ACCENT ELECTRONIC, 202294 ULTRA DISTRIBUTION, 1455 COMITEK:
       baza formulelor = PRICE0, daca PRICE0 > 0 si PRICE0 nu e mai mic cu peste 15%
       decat PRICE7 (PRICE0 >= 85% din PRICE7, comparat in USD); altfel PRICE7;
       produsele fara PRICE7 (Ultra pe RRP, 334 pe 3 oct) raman pe calculul de azi;
     - toti ceilalti furnizori: baza = PRICE7 (ca inainte de 2 oct);
     - fara majorarea de +5% (ex. Ultra 108551: ceil(65.75) = 66, nu 69.30).

   Toate calculele raman in triggerul TS_GOODS_FOREIGN_BIU; formulele din
   TPRICE_GOODSTYPE nu se schimba (:vprice7 primeste baza aleasa).
   Efectul apare la urmatorul UPDATE al fiecarui rand (reevaluare, editare sau
   recalcul: "Recalcula preturile" / UPDATE_PRICES_WITH_RULE).
   Revenire: price0_suppliers_rollback.sql (= triggerul din 2 oct)
   ------------------------------------------------------------------------ */

SET TERM ^ ;

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
/* 03.10.2026 - baza coloanei 6 din PRICE0, doar Accent / Ultra / Comitek */
declare BASE7_USD DM_AMOUNT;
declare BASE0_USD DM_AMOUNT;
declare FLG_USE_PRICE0 DM_BOOLEAN;
declare C_PRICE0_MIN_RATIO DM_AMOUNT = 0.85; /* PRICE0 mai mic cu peste 15% decat PRICE7 -> PRICE7 */
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

        /* 03.10.2026: la Accent (198), Ultra Distribution (202294) si Comitek (1455)
           baza pret6 = PRICE0 (achizitie) daca PRICE0 > 0 si PRICE0 >= 85% din PRICE7,
           altfel PRICE7 (indicativ); la ceilalti furnizori PRICE7; comparat in USD */
        :BASE7_USD = CONVERT_AMOUNT(new.PRICE7, new.CURRENCY7ID, 840, 1);
        :BASE0_USD = 0;
        if (new.CUSTOMERID in (198, 202294, 1455) and coalesce(new.PRICE0, 0) > 0) then
          :BASE0_USD = CONVERT_AMOUNT(new.PRICE0, coalesce(new.CURRENCY0ID, new.CURRENCY7ID), 840, 1);
        /* PRICE7 = 0 (ex. Ultra pe RRP, fara pret indicativ): PRICE0 ramas din urma nu e baza */
        :FLG_USE_PRICE0 = iif(:BASE0_USD > 0 and
                              :BASE7_USD > 0 and
                              :BASE0_USD >= :BASE7_USD * :C_PRICE0_MIN_RATIO, 1, 0);
        :TMPPRICE = iif(:FLG_USE_PRICE0 = 1, :BASE0_USD, :BASE7_USD);

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
      if ( (new.PRICE3 > 0) and (get_flg_value(new.flags, 4) = 1) ) then
        new.PRICE1 = maxvalue(CONVERT_AMOUNT(new.PRICE8, 840, coalesce(new.CURRENCY1ID, 498), 1), CONVERT_AMOUNT(new.PRICE3, new.CURRENCY3ID, coalesce(new.CURRENCY1ID, 498), 1));
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

SET TERM ; ^

COMMIT;

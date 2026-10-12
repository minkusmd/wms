/*
  TDB_GOODS_FLAGS: FLG_PRICE (FLAGTYPEID = 5) pe firma reala a stocului + procedura
  de completare a tuturor flagurilor calculate.

  Problema (10 oct 2026):
  - TRG_TS_GOODS_STOCK_AU0 scria FLG_PRICE mereu cu DT = 5213, oricare ar fi firma
    (TS_GOODS_STOCK.DT) care are stocul, si doar pentru firmele cu
    TS_CUSTOMER.WEB_STOCK_BIT_INDEX (238300, 307225 etc. erau sarite);
    PKG_GOODS.UPDATE_GOODS_FLAGTYPE la fel (5213 fix);
  - sarcina SWNService "ustanovka FLG_PRICE" (SP_SET_PRICE_FLAG) stergea toate
    FLG_PRICE ale firmelor din TWEB_MAGAZINE (5213), iar inserarea la loc era
    comentata -> pe SW nu exista niciun rind FLAGTYPEID = 5;
  - TRG_TS_GOODS_AI0 punea la fiecare produs nou FLG_PRICE = 0 pentru firma din
    TWEB_MAGAZINE (5213), desi produsul nou nu are stoc.

  Regulile (de unde se completeaza fiecare flag):
  1 FLG_PROMO        - manual (frmGoods -> WEB_SETUP_GOODS_FLAG2, reevaluare frame40
                       -> TDB_GOODS_PRICE_SET_ALL_FLAG), DT = 5213. Nu se calculeaza.
  2 FLG_NEW          - TRG_TS_GOODS_AI0 la crearea produsului (14 zile, trigger BI),
                       manual / reevaluare. DT = 5213. Nu se calculeaza; procedura
                       completeaza doar START_DATE lipsa si, la cerere, sterge expiratele.
  3 FLG_PRICE_FORCED - exista TS_GOODS_FOREIGN cu bitul 3 (FLG_IN_PRICE) = 1
                       (TRG_TS_GOODS_FOREIGN_AU, TS_GOODS_FOREIGN_AD,
                       RECALC_FORCED_FLAG). Comun pentru toate firmele: DT = 5213.
  4 FLG_DISCOUNT     - manual (WEB_SETUP_GOODS_FLAG2), DT = 5213. Nu se calculeaza.
  5 FLG_PRICE        - stocul firmei DT pe depozitele vizibile pentru vinzare
                       (TS_STOCKS.FLAGS bitul 0) > 0 -> rind (DT, GOODSID, 5, VALUE_INT = 1);
                       fara stoc -> rindul se sterge. Pentru fiecare firma
                       TS_CUSTOMER.PARENTID = 5209. DT = firma reala (DIN ACEST SCRIPT).

  Ce face scriptul:
  - SP_GOODS_FLAG_STOCK(P_DT, P_GOODSID): regula 5 pentru o pereche firma-produs;
  - SP_GOODS_FLAGS_FILL(P_DT, P_CLEAN_EXPIRED): completeaza tot tabelul (5 pe toate
    firmele sau doar pe P_DT, 3 din furnizori, START_DATE lipsa la 2; cu
    P_CLEAN_EXPIRED = 1 sterge 1/2/4 cu END_DATE trecut). Intoarce numarul de rinduri;
  - TRG_TS_GOODS_STOCK_AU0: FLG_PRICE pe NEW.DT (si OLD.DT), si la stergerea stocului;
  - TRG_TS_GOODS_AI0: fara FLG_PRICE = 0 la produsul nou (restul neschimbat);
  - PKG_GOODS.UPDATE_GOODS_FLAGTYPE: pe firmele reale (nefolosita azi, aliniata);
  - SP_SET_PRICE_FLAG / SP_SET_PRICE_FLAG2: in loc de stergere -> SP_GOODS_FLAGS_FILL,
    apoi SP_WEB_CREATE_CACHE_GOODS ca inainte.

  ATENTIE la site: cititorii FLG_PRICE (SP_WEB_CREATE_CACHE_GOODS, GET_FLG_IN_PRICE,
  W_V2_*, WEB_GET_*) filtreaza DT = 5213, deci vad acum doar stocul firmei 5213
  (azi 35 de produse, din care 32 fara FLG_PRICE_FORCED - vor aparea pe site).
  Stocul celorlalte firme ramine in tabel pe DT-ul lor, fara efect pe site.

  Se poate rula repetat. Revenire: goods_flags_real_dt_rollback.sql
  Dupa rulare (o data): EXECUTE PROCEDURE SP_GOODS_FLAGS_FILL(NULL, 0); COMMIT;
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_GOODS_FLAG_STOCK (
    P_DT DM_INTEGER,
    P_GOODSID DM_INTEGER)
AS
declare variable QTY DM_QTY;
begin
  /* 10.10.2026: FLG_PRICE (5) pentru firma reala P_DT (TS_CUSTOMER.PARENTID = 5209):
     stoc > 0 pe depozitele vizibile -> VALUE_INT = 1, altfel rindul se sterge */
  if (P_DT is null or P_GOODSID is null) then
    exit;
  if (not exists(select 1
                 from TS_CUSTOMER
                 where CUSTOMERID = :P_DT and
                       PARENTID = 5209)) then
    exit;

  select coalesce(sum(GS.QTY), 0)
  from TS_GOODS_STOCK GS
  inner join TS_STOCKS S on (S.STOCKID = GS.DTDEP and GET_FLG_VALUE(S.FLAGS, 0) = 1) /* stoc vizibil pentru vinzare */
  where GS.DT = :P_DT and
        GS.GOODSID = :P_GOODSID
  into :QTY;

  if (QTY > 0) then
  begin
    /* scriem doar daca se schimba ceva - triggerul ruleaza la fiecare miscare de stoc */
    if (not exists(select 1
                   from TDB_GOODS_FLAGS
                   where DT = :P_DT and
                         GOODSID = :P_GOODSID and
                         FLAGTYPEID = 5 and
                         VALUE_INT = 1)) then
      update or insert into TDB_GOODS_FLAGS (DT, GOODSID, FLAGTYPEID, VALUE_INT)
      values (:P_DT, :P_GOODSID, 5, 1)
      matching (DT, GOODSID, FLAGTYPEID);
  end
  else
    delete from TDB_GOODS_FLAGS
    where DT = :P_DT and
          GOODSID = :P_GOODSID and
          FLAGTYPEID = 5;
end^

CREATE OR ALTER PROCEDURE SP_GOODS_FLAGS_FILL (
    P_DT DM_INTEGER = NULL,
    P_CLEAN_EXPIRED DM_INTEGER = 0)
RETURNS (
    STOCK_SET INTEGER,
    STOCK_DEL INTEGER,
    FORCED_SET INTEGER,
    FORCED_DEL INTEGER,
    DATES_SET INTEGER,
    EXPIRED_DEL INTEGER)
AS
begin
  /* 10.10.2026: completeaza TDB_GOODS_FLAGS din sursele lor (vezi
     DB Model/goods_flags_real_dt.sql). P_DT = NULL - toate firmele
     TS_CUSTOMER.PARENTID = 5209; P_CLEAN_EXPIRED = 1 - sterge PROMO/NEW/DISCOUNT
     cu END_DATE trecut */
  STOCK_SET = 0;
  STOCK_DEL = 0;
  FORCED_SET = 0;
  FORCED_DEL = 0;
  DATES_SET = 0;
  EXPIRED_DEL = 0;

  /* 5 FLG_PRICE - stocul pe firma reala */
  merge into TDB_GOODS_FLAGS T
  using (select GS.DT, GS.GOODSID
         from TS_GOODS_STOCK GS
         inner join TS_STOCKS S on (S.STOCKID = GS.DTDEP and GET_FLG_VALUE(S.FLAGS, 0) = 1)
         inner join TS_CUSTOMER C on (C.CUSTOMERID = GS.DT and C.PARENTID = 5209)
         where (:P_DT is null or GS.DT = :P_DT)
         group by GS.DT, GS.GOODSID
         having sum(GS.QTY) > 0) SRC
  on (T.DT = SRC.DT and T.GOODSID = SRC.GOODSID and T.FLAGTYPEID = 5)
  when matched and (T.VALUE_INT is distinct from 1) then
      update set T.VALUE_INT = 1
  when not matched then
      insert (DT, GOODSID, FLAGTYPEID, VALUE_INT)
      values (SRC.DT, SRC.GOODSID, 5, 1);
  STOCK_SET = row_count;

  delete from TDB_GOODS_FLAGS F
  where F.FLAGTYPEID = 5 and
        (:P_DT is null or F.DT = :P_DT) and
        exists(select 1
               from TS_CUSTOMER C
               where C.CUSTOMERID = F.DT and
                     C.PARENTID = 5209) and
        (select coalesce(sum(GS.QTY), 0)
         from TS_GOODS_STOCK GS
         inner join TS_STOCKS S on (S.STOCKID = GS.DTDEP and GET_FLG_VALUE(S.FLAGS, 0) = 1)
         where GS.DT = F.DT and
               GS.GOODSID = F.GOODSID) <= 0;
  STOCK_DEL = row_count;

  /* flagurile comune (DT = 5213) */
  if (P_DT is null or P_DT = 5213) then
  begin
    /* 3 FLG_PRICE_FORCED - produsul e in pricelistul unui furnizor (FLG_IN_PRICE) */
    merge into TDB_GOODS_FLAGS T
    using (select distinct GF.GOODSID
           from TS_GOODS_FOREIGN GF
           where GET_FLG_VALUE(GF.FLAGS, 3) = 1) SRC
    on (T.DT = 5213 and T.GOODSID = SRC.GOODSID and T.FLAGTYPEID = 3)
    when not matched then
        insert (DT, GOODSID, FLAGTYPEID)
        values (5213, SRC.GOODSID, 3);
    FORCED_SET = row_count;

    delete from TDB_GOODS_FLAGS F
    where F.FLAGTYPEID = 3 and
          not exists(select 1
                     from TS_GOODS_FOREIGN GF
                     where GF.GOODSID = F.GOODSID and
                           GET_FLG_VALUE(GF.FLAGS, 3) = 1);
    FORCED_DEL = row_count;

    /* 2 FLG_NEW - inceputul perioadei lipsa (perioada implicita din trigger: 14 zile) */
    update TDB_GOODS_FLAGS
    set START_DATE = coalesce(END_DATE - 14, current_date)
    where FLAGTYPEID = 2 and
          START_DATE is null;
    DATES_SET = row_count;

    /* 1 PROMO, 2 NEW, 4 DISCOUNT - perioada expirata */
    if (P_CLEAN_EXPIRED = 1) then
    begin
      delete from TDB_GOODS_FLAGS
      where FLAGTYPEID in (1, 2, 4) and
            END_DATE < current_date;
      EXPIRED_DEL = row_count;
    end
  end
end^

CREATE OR ALTER TRIGGER TRG_TS_GOODS_STOCK_AU0 FOR TS_GOODS_STOCK
ACTIVE AFTER INSERT OR UPDATE OR DELETE POSITION 0
AS
begin
     /* Verificam daca ne trebuie trigerii  */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS')='YES') THEN EXIT;
     /*-----------------------------------------------------------------------*/

     /* JOHN. Pentru WEB: FLG_PRICE (TDB_GOODS_FLAGS.FLAGTYPEID = 5) dupa disponibilitatea
        marfii pe depozitele vizibile pentru vinzare */
     /* 10.10.2026: pe firma reala a stocului (DT), nu pe 5213; pentru toate firmele
        TS_CUSTOMER.PARENTID = 5209 (nu mai depinde de WEB_STOCK_BIT_INDEX);
        se recalculeaza si la stergerea rindului de stoc */

     IF (DELETING) THEN
     BEGIN
          EXECUTE PROCEDURE SP_GOODS_FLAG_STOCK(OLD.DT, OLD.GOODSID);
          EXIT;
     END

     /* doar TRANSIT_QTY s-a schimbat - FLG_PRICE nu se schimba */
     IF (UPDATING AND OLD.DT = NEW.DT AND OLD.DTDEP = NEW.DTDEP AND
         OLD.GOODSID = NEW.GOODSID AND OLD.QTY IS NOT DISTINCT FROM NEW.QTY) THEN EXIT;

     EXECUTE PROCEDURE SP_GOODS_FLAG_STOCK(NEW.DT, NEW.GOODSID);

     IF (UPDATING) THEN
       IF (OLD.DT IS DISTINCT FROM NEW.DT OR OLD.GOODSID IS DISTINCT FROM NEW.GOODSID) THEN
         EXECUTE PROCEDURE SP_GOODS_FLAG_STOCK(OLD.DT, OLD.GOODSID);
end^

CREATE OR ALTER TRIGGER TRG_TS_GOODS_AI0 FOR TS_GOODS
ACTIVE AFTER INSERT POSITION 0
AS
DECLARE VARIABLE USER_ID INTEGER;
BEGIN
  -- Dezactivare triger daca este setat in context
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;

  -- Actualizare dictionar pentru noul titlu
  EXECUTE PROCEDURE UPDATE_GOODS_DICTIONARY(NEW.GOODSID, 0);

  -- FLG_NEW (DT NULL -> 5213 in TRG_TDB_GOODS_FLAGS_BI0)
  INSERT INTO TDB_GOODS_FLAGS (
      DT,
      GOODSID,
      FLAGTYPEID,
      VALUE_INT
  )
  VALUES (
      NULL,
      NEW.GOODSID,
      2,
      60
  );

  -- 10.10.2026: nu mai punem FLG_PRICE = 0 pentru firmele din TWEB_MAGAZINE -
  -- produsul nou nu are stoc; FLG_PRICE il pune TRG_TS_GOODS_STOCK_AU0 pe firma reala

  -- Daca este folder si are template, logam in istoric
  IF (NEW.FLG_FOLDER = 1) THEN
  BEGIN
    :USER_ID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    INSERT INTO TLOG_GOODSFOLDER_TEMPLATES (
        GOODSID,
        TEMPLATEID,
        USERID,
        CREATED_DATE
    )
    VALUES (
        NEW.GOODSID,
        NEW.TEMPLATEID,
        :USER_ID,
        LOCALTIMESTAMP
    );
  END
END^

RECREATE PACKAGE BODY PKG_GOODS
AS
begin
  /* SET_FLG_NEW */
  procedure SET_FLG_NEW (
      GOODSID DM_INTEGER,
      FLAGVALUE DM_INTEGER)
  as
  begin
    if (:FLAGVALUE = 1) then
    begin
      update or insert into TDB_GOODS_FLAGS (GOODSID, FLAGTYPEID, START_DATE, END_DATE)
      values (:GOODSID, 2, current_date, current_date + 30)
      matching (GOODSID, FLAGTYPEID);
    end
    else
    begin
      if (not exists(select *
                     from TS_GOODS_FOREIGN
                     where GOODSID = :GOODSID and
                           GET_FLG_VALUE(FLAGS, 3) = 1)) then
        delete from TDB_GOODS_FLAGS
        where GOODSID = :GOODSID and
              FLAGTYPEID = 2;
    end
  end

  procedure SET_FLG_HUGEQTY (
      GOODSID DM_INTEGER,
      SUPPLIER_GOODS_CODE DM_VARCHAR32,
      SUPPLIERID DM_INTEGER,
      FLAGVALUE DM_INTEGER)
  as
  begin
    update TS_GOODS_FOREIGN
    set FLAGS = SET_FLG_VALUE(FLAGS, 1, :FLAGVALUE)
    where GOODSID = :GOODSID and
          GOODS_CODE = :SUPPLIER_GOODS_CODE and
          CUSTOMERID = :SUPPLIERID;
  end

  procedure UPDATE_GOODS_FLAGTYPE (
      GOODSID DM_INTEGER,
      DEP DM_INTEGER)
  as
  declare V_DT DM_INTEGER;
  begin
    /* 10.10.2026: FLG_PRICE pe firmele reale care au stoc pe depozitul DEP (nu pe 5213) */
    for select distinct GS.DT
        from TS_GOODS_STOCK GS
        where GS.GOODSID = :GOODSID and
              GS.DTDEP = :DEP
        into :V_DT
    do
      execute procedure SP_GOODS_FLAG_STOCK(:V_DT, :GOODSID);
  end

end^

CREATE OR ALTER PROCEDURE SP_SET_PRICE_FLAG
AS
declare variable V_STOCK_SET INTEGER;
declare variable V_STOCK_DEL INTEGER;
declare variable V_FORCED_SET INTEGER;
declare variable V_FORCED_DEL INTEGER;
declare variable V_DATES_SET INTEGER;
declare variable V_EXPIRED_DEL INTEGER;
begin
     /* 24.12.2013 - JOHN */
     /* Seteaza FLG_PRICE in tabelul TDB_GOODS_FLAGS in baza disponibilitatii produsului */
     /* in stoc */

     /* 10.10.2026: inainte stergea FLG_PRICE pentru firmele din TWEB_MAGAZINE, iar
        inserarea la loc era comentata (tabelul ramanea fara FLAGTYPEID = 5).
        Acum recalculeaza flagurile din sursele lor, pe firma reala */
     EXECUTE PROCEDURE SP_GOODS_FLAGS_FILL(NULL, 0)
       RETURNING_VALUES :V_STOCK_SET, :V_STOCK_DEL, :V_FORCED_SET, :V_FORCED_DEL, :V_DATES_SET, :V_EXPIRED_DEL;

     /* 02.07.2013 - JOHN */
     /* dupa recalcularea de mai sus, la unele produse se poate schimba visibilitatea */
     /* actualizam web cache-ul de produse */
     EXECUTE PROCEDURE SP_WEB_CREATE_CACHE_GOODS;
end^

CREATE OR ALTER PROCEDURE SP_SET_PRICE_FLAG2
AS
declare variable V_STOCK_SET INTEGER;
declare variable V_STOCK_DEL INTEGER;
declare variable V_FORCED_SET INTEGER;
declare variable V_FORCED_DEL INTEGER;
declare variable V_DATES_SET INTEGER;
declare variable V_EXPIRED_DEL INTEGER;
begin
     /* 24.12.2013 - JOHN */
     /* Seteaza FLG_PRICE in tabelul TDB_GOODS_FLAGS in baza disponibilitatii produsului */
     /* in stoc */

     /* 10.10.2026: inainte punea VALUE_INT = 0 la FLG_PRICE pentru firmele din
        TWEB_MAGAZINE, fara sa-l mai seteze inapoi. Acum - ca SP_SET_PRICE_FLAG */
     EXECUTE PROCEDURE SP_GOODS_FLAGS_FILL(NULL, 0)
       RETURNING_VALUES :V_STOCK_SET, :V_STOCK_DEL, :V_FORCED_SET, :V_FORCED_DEL, :V_DATES_SET, :V_EXPIRED_DEL;

     /* 02.07.2013 - JOHN */
     /* actualizam web cache-ul de produse */
     EXECUTE PROCEDURE SP_WEB_CREATE_CACHE_GOODS;
end^

SET TERM ; ^

COMMIT;

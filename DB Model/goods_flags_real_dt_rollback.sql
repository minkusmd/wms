/*
  Revenire pentru goods_flags_real_dt.sql: sursele de pe SW din 10 oct 2026
  (comentariile transcrise fara diacritice / chirilice, codul identic).
  Procedurile noi SP_GOODS_FLAGS_FILL / SP_GOODS_FLAG_STOCK se sterg la sfirsit.
  Rindurile FLAGTYPEID = 5 scrise pe firmele reale raman; le sterge (daca e nevoie):
    DELETE FROM TDB_GOODS_FLAGS WHERE FLAGTYPEID = 5 AND DT <> 5213;
*/

SET TERM ^ ;

CREATE OR ALTER TRIGGER TRG_TS_GOODS_STOCK_AU0 FOR TS_GOODS_STOCK
ACTIVE AFTER UPDATE OR INSERT POSITION 0
AS
declare variable tmpSUM DM_QTY;
declare variable bitValue DM_BOOLEAN;
declare variable oldDT_AVIABILITY DM_QTY;
declare variable bitIndex DM_INTEGER;
begin
     /* Verificam daca ne trebuie trigerii  */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS')='YES') THEN EXIT;
     /*-----------------------------------------------------------------------*/


     /* JOHN. Pentru WEB. */
     /* Setam biturile in dependenta de disponibilitatea marfii pe firma in tabelul TDB_GOODS_STOCK_WEB */
     /* luam firma si numai depozitele care lucreaza cu magazinele */
     /* Fiecare firma are presetat bitul de lucru  */

     bitValue = 0; /* no stock */

     /* get bit index for current DT */
     SELECT WEB_STOCK_BIT_INDEX FROM TS_CUSTOMER WHERE CUSTOMERID = NEW.DT INTO :bitIndex;
     IF (bitIndex IS NULL OR bitIndex=-1) THEN EXIT;


     SELECT COALESCE(SUM(QTY),0)
     FROM TS_GOODS_STOCK
     INNER JOIN TS_STOCKS ON (TS_GOODS_STOCK.DTDEP=TS_STOCKS.STOCKID AND GET_FLG_VALUE(TS_STOCKS.FLAGS,0)=1) /* stock visibil pentru vinzare */
     WHERE TS_GOODS_STOCK.DT=NEW.DT AND TS_GOODS_STOCK.GOODSID=NEW.GOODSID
     INTO :tmpSUM;

     /* daca marfa e in stoc trebuie setat flagul pentru web */
     IF (tmpSUM>0) THEN
     BEGIN
        bitValue = 1; /* in stock */
        update or insert into tdb_goods_flags (dt, goodsid, flagtypeid, value_int)
        values (5213, NEW.goodsid, 5, 1)
        matching (dt, goodsid, flagtypeid);

     END
     ELSE
     BEGIN
        delete from tdb_goods_flags
        where dt = 5213 and
            goodsid = NEW.goodsid and
            flagtypeid = 5;
     END
end^

CREATE OR ALTER TRIGGER TRG_TS_GOODS_AI0 FOR TS_GOODS
ACTIVE AFTER INSERT POSITION 0
AS
DECLARE VARIABLE DT DM_INTEGER;
DECLARE VARIABLE USER_ID INTEGER;
BEGIN
  -- Dezactivare triger daca este setat in context
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;

  -- Actualizare dictionar pentru noul titlu
  EXECUTE PROCEDURE UPDATE_GOODS_DICTIONARY(NEW.GOODSID, 0);

  -- Inserare flag global (ID necunoscut, posibil sistem)
  INSERT INTO TDB_GOODS_FLAGS (
      DT,
      GOODSID,
      FLAGTYPEID,
      VALUE_INT
  )
  VALUES (
      NULL,  -- sau initializeaza DT cu un ID daca este necesar
      NEW.GOODSID,
      2,
      60
  );

  -- Inserare flag implicit 0 pentru fiecare firma din TWEB_MAGAZINE
  FOR SELECT DISTINCT FIRMAID FROM TWEB_MAGAZINE INTO :DT DO
  BEGIN
    INSERT INTO TDB_GOODS_FLAGS (
        DT,
        GOODSID,
        FLAGTYPEID,
        VALUE_INT
    )
    VALUES (
        :DT,
        NEW.GOODSID,
        5,
        0
    );
  END

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
  declare QTY DM_QTY;
  begin

    select coalesce(sum(QTY), 0)
    from TS_GOODS_STOCK GS
    join TS_STOCKS S on S.STOCKID = GS.DTDEP and
          GET_FLG_VALUE(FLAGS, 0) = 1
    where GS.GOODSID = :GOODSID and
          GS.DTDEP = :DEP
    into :QTY;
    if (:QTY <= 0) then
      delete from TDB_GOODS_FLAGS
      where DT = 5213 and
            GOODSID = :GOODSID and
            FLAGTYPEID = 5;
    else
      update or insert into TDB_GOODS_FLAGS (DT, GOODSID, FLAGTYPEID, VALUE_INT)
      values (5213, :GOODSID, 5, 1)
      matching (DT, GOODSID, FLAGTYPEID);
  end

end^

CREATE OR ALTER PROCEDURE SP_SET_PRICE_FLAG
AS
declare variable DT integer;
declare variable TMPCUSTLIST DM_BLOBTEXT;
declare variable TMPSTOCKLIST DM_BLOBTEXT;
declare variable TMPGOODSID DM_INTEGER;
BEGIN
     /* 24.12.2013 - JOHN */
     /* Seteaza FLG_PRICE in tabelul TDB_GOODS_FLAGS in baza disponibilitatii produsului */
     /* in stoc */

     /* luam lista de depozite spre vinzare */
     SELECT LIST(STOCKID) FROM TS_STOCKS WHERE PARENTID = 1
     INTO :tmpStockList;

     /* trece prin toate magazinele web */
     FOR
        SELECT DISTINCT FIRMAID
        FROM TWEB_MAGAZINE
        INTO :DT
     DO
       BEGIN
            /* resetam FLG_PRICE */
            delete from tdb_goods_flags where flagtypeid in (0, 5) and dt=:dt;
     END

     /* 02.07.2013 - JOHN */
     /* dupa recalcularea de mai sus, la unele produse se poate schimba visibilitatea */
     /* actualizam web cache-ul de produse */
     EXECUTE PROCEDURE SP_WEB_CREATE_CACHE_GOODS;
END^

CREATE OR ALTER PROCEDURE SP_SET_PRICE_FLAG2
AS
DECLARE VARIABLE DT INTEGER;
declare variable tmpCustList DM_BLOBTEXT;
declare variable tmpStockList DM_BLOBTEXT;
declare variable tmpGOODSID DM_INTEGER;
BEGIN
     /* 24.12.2013 - JOHN */
     /* Seteaza FLG_PRICE in tabelul TDB_GOODS_FLAGS in baza disponibilitatii produsului */
     /* in stoc */

     /* luam lista de depozite spre vinzare */
     SELECT LIST(STOCKID) FROM TS_STOCKS WHERE PARENTID = 1
     INTO :tmpStockList;

     /* trece prin toate magazinele web */
     FOR
        SELECT DISTINCT FIRMAID
        FROM TWEB_MAGAZINE
        INTO :DT
     DO
       BEGIN
            /* resetam FLG_PRICE */
            UPDATE TDB_GOODS_FLAGS
            SET VALUE_INT = 0
            WHERE DT = :DT AND FLAGTYPEID = 5 /* flg_price */ ;
     END

     /* 02.07.2013 - JOHN */
     /* dupa recalcularea de mai sus, la unele produse se poate schimba visibilitatea */
     /* actualizam web cache-ul de produse */
     EXECUTE PROCEDURE SP_WEB_CREATE_CACHE_GOODS;
END^

SET TERM ; ^

COMMIT;

DROP PROCEDURE SP_GOODS_FLAGS_FILL;
DROP PROCEDURE SP_GOODS_FLAG_STOCK;
COMMIT;

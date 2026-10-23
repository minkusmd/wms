/* ROLLBACK pentru weborder_to_offer.sql: corpurile originale de pe SW (23 oct 2026)
   si stergerea procedurii SP_WEBORDER_TO_OFFER. Garda din TRG_TDB_DOCS_BU0 dispare. */

SET TERM ^ ;

CREATE OR ALTER TRIGGER TRG_TDB_DOCS_BU0 FOR TDB_DOCS 
ACTIVE BEFORE UPDATE POSITION 0 
AS
declare variable currentUserID DM_INTEGER;
declare variable requireModifyDOC DM_BOOLEAN;
declare variable allowModifyDoc DM_BOOLEAN;
declare variable FLG_CLOSED DM_BOOLEAN;
declare variable new_FLG_CLOSED DM_BOOLEAN;
declare variable old_FLG_CLOSED DM_BOOLEAN;
declare variable old_FLG_EXPORTED DM_BOOLEAN;
declare variable FLG_CLOSE_CHANGED DM_BOOLEAN;
DECLARE VARIABLE TMPBODY DM_BLOBTEXT;
DECLARE VARIABLE FULLNAME TYPE OF COLUMN TS_USERS.FULL_NAME;
DECLARE VARIABLE DEBUGTXT DM_BLOBTEXT;
DECLARE VARIABLE DATA DM_DATE;
DECLARE VARIABLE DT_NAME TYPE OF COLUMN TS_CUSTOMER.NAME;
DECLARE VARIABLE old_CT_NAME TYPE OF COLUMN TS_CUSTOMER.NAME;
DECLARE VARIABLE NEW_CT_NAME TYPE OF COLUMN TS_CUSTOMER.NAME;
DECLARE VARIABLE CT DM_INTEGER;

declare variable CONTRACT_CURRENCYID DM_INTEGER;

BEGIN
     /* Verificam daca ne trebuie trigerii  */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS')='YES') THEN EXIT;
     /*-----------------------------------------------------------------------*/
     requireModifyDOC = COALESCE(RDB$GET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC'),0);
--     if (requireModifyDoc=0) then
--        exception err_general_error 'Nu aveti dreptul de a modifica documentul!';

--       new.ctsc = coalesce(new.ctsc, -1);
          if ( (:CURRENTUSERID<>204) and (new.dt<>old.dt) and not (new.doctypeid in (115, 134, 120)) ) then
     exception ERR_GENERAL_ERROR 'Schimbarea firmei este interzisa';
--     nu se poate in peremeshenie de facut suma >60000lei
/*     if ( (new.doctypeid=114) and (new.suma>59999) ) then
       exception ERR_PEREMESHENIE_MORE120;*/

     new_FLG_CLOSED = COALESCE(GET_FLG_VALUE(NEW.FLAGS,10),0);
     old_flg_closed = COALESCE(GET_FLG_VALUE(old.FLAGS,10),0);
     currentUserID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
     requireModifyDOC = COALESCE(RDB$GET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC'),0);
     FLG_CLOSED = COALESCE(GET_FLG_VALUE(NEW.FLAGS,10),0); /* 10 - FLG_CLOSED */
     FLG_CLOSE_CHANGED = IIF(FLG_CLOSED<>COALESCE(GET_FLG_VALUE(OLD.FLAGS,10),0),1,0);
     old_FLG_EXPORTED = COALESCE(GET_FLG_VALUE(OLD.FLAGS,11),0);

     /* Verificam daca Userul are dreptul pentru modificarea documentului */
     allowModifyDoc = (
                       SELECT Z.FLG_HAS_MODIFY_FLAG
                       FROM SP_DOCS_GET_MODIFY_FLAG(NEW.DOCTYPEID,:currentUserID) Z
                      );

    /* daca se schimba FLG_CLOSE atunci nu-l luam in consideratie */
--     IF (FLG_CLOSE_CHANGED=1) THEN FLG_CLOSED = 0;
--     if ((requireModifyDOC=0) or (allowModifyDoc=0))  then
--     begin
--       if ((NEW.DATA+56 <= CURRENT_DATE) and (new.doctypeid in (106, 107, 110, 112, 2016, 116,117)) ) then
--         EXCEPTION err_doc_modify_denied;
--     end
     requireModifyDOC=1;
     IF (NOT ((allowModifyDoc=1 and FLG_CLOSED=0) OR (requireModifyDOC=1)))
       THEN EXCEPTION ERR_DOC_MODIFY_DENIED '<DOCID>'||NEW.DOCID||'</DOCID><MSG>OLD.FLG_CLOSED='||:old_flg_closed||', NEW.FLG_CLOSED='||:new_flg_closed||', FLG_CLOSE_CHANGED='||:FLG_CLOSE_CHANGED||
       ', FLG_CLOSED='||:FLG_CLOSED||', REQUIREMODIFYDOC='||:REQUIREMODIFYDOC||', allowmodifyDoc='||:allowmodifydoc ||'requiredModifyDoc='||:REQUIREMODIFYDOC||' </MSG>';

     /* fiecare document trebuie sa aiba pemisiune */
     /* 1. la modificare */
     /* 2. sa nu fie inchis FLG_CLOSED=0 */
     /* 3. sau se cere modificae fortata "requireModifyDOC" */

     /* DEBUG */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DEBUG')=1) THEN
     BEGIN
          debugTXT = 'DOCS_BEFORE_UPDATE: DOCID='||COALESCE(NEW.DOCID,'NULL')||'
DOCTYPEID='||COALESCE(NEW.DOCTYPEID,'NULL')||' ('||COALESCE((SELECT TITLE FROM TS_DOCTYPES WHERE TS_DOCTYPES.DOCTYPEID=NEW.DOCTYPEID),'NULL')||')'||'
requireModifyDOC='||COALESCE(:requireModifyDOC,'NULL')||'
NEW.FLG_CLOSED='||COALESCE(:FLG_CLOSED,'NULL')||'
OLD.FLG_CLOSED='||COALESCE(GET_FLG_VALUE(OLD.FLAGS,10),'NULL')||'
FLG_CLOSE_CHANGED='||COALESCE(:FLG_CLOSE_CHANGED,'NULL')||'
allowModifyDoc='||COALESCE(:allowModifyDoc,'NULL');

--          INSERT INTO TDB_DEBUG (TEXT) VALUES (:debugTXT);
     END


     /* NEW 19.08.2013 - JOHN */
     /* Daca pentru firma utilizatorului, la moment, este setat modul de acces Partial, */
     /* toate documentele primesc FLG_ACNT=1 */
     IF ((SELECT IS_PARTIAL_LOCKED FROM SP_IS_DB_PARTIAL_LOCKED(:CURRENTUSERID))=1) THEN
     BEGIN
          NEW.FLAGS = SET_FLG_VALUE(NEW.FLAGS, 1, 1); /* FLG_ACNT = 1 */
     END



     /* de aici triggeru ruleaza in mod obisnuit */
     IF (NEW.PARENTDOCID IS NULL) THEN NEW.PARENTDOCID = -1;


     if ((get_flg_value((select flags from ts_doctypes where doctypeid = new.doctypeid), 3) = 1) or (exists(select docid from tdb_jurnal where docid = new.docid))) then
      begin
          select sum(sumavat) from tdb_jurnal j where docid = new.docid and j.goodscomplect_id = -1 into NEW.VAT;
          new.vat = coalesce(new.vat, 0);
      end
      else
          SELECT VAT FROM GET_VAT_BY_CUSTOMER(new.dt,  new.CT, 0,  coalesce(NEW.SUMA, 0), coalesce(new.contractid, -1))
            INTO NEW.VAT;

     /* JOHN. 06.07.2012 */
     /* Contractele. Daca se aplica contract la document, se impune in document valuta din contract */
       new.contractid = coalesce(new.contractid, -1);
     IF (NEW.CONTRACTID = -1 AND NEW.CONTRACTID<>OLD.CONTRACTID) THEN
     BEGIN
          SELECT CURRENCYID
          FROM TDB_CONTRACTS
          WHERE CONTRACTID=NEW.CONTRACTID
          INTO :CONTRACT_CURRENCYID;

          IF (CONTRACT_CURRENCYID IS NOT NULL) THEN NEW.CURRENCYID = CONTRACT_CURRENCYID;
     END
   --new.flags = set_FLG_VALUE(new.flags, 1, 1);

     IF (NEW.DATA < CURRENT_DATE -30) THEN
     BEGIN
          SELECT DATA, DT_NAME, CT, CT_NAME
          FROM VW_TDB_DOCS      
          WHERE DOCID = NEW.DOCID
          INTO :DATA, :DT_NAME, :CT, :NEW_CT_NAME;

          SELECT CT_NAME
          FROM VW_TDB_DOCS
          WHERE DOCID = old.DOCID
          INTO :OLD_CT_NAME;

          SELECT U.FULL_NAME
          FROM TS_USERS U
          WHERE U.USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID')
          INTO :FULLNAME;



          TMPBODY = 'Document <b>#' || NEW.DOCID || '</b> a fost modificat cu o data mai mica de 30 zile de la ziua curenta. Data crearii:'
                    || NEW.CREATED_DATE || ', data veche a documentului: ' || old.DATA ||', data noua:'||new.data||', <BR>Suma documentului vechi:'||old.suma||'<BR>Suma noua:'||new.suma
                    || '" Contragent vechi: "' || old_CT_NAME ||', contragent nou:'|| :new_ct_name|| '",  <BR>de catre ' || FULLNAME;
          if (old.suma<>new.suma) then
          EXECUTE PROCEDURE SP_CREATE_MAIL_TO_SEND('s.minchevici@fantastic.md', '', 'Document modificat cu data < 30zile! - ' || FULLNAME, TMPBODY);
     END
END ^

CREATE OR ALTER PROCEDURE SP_APPLY_CASHBACK (DOCID DM_INTEGER,
FLG_FORCED DM_BOOLEAN = 0)
AS 
declare docdate dm_date;
declare cashback dm_amount;
declare goodsid dm_integer;
declare customerid dm_integer;
declare viaShopCart dm_integer;
declare cashback_amount dm_amount;
declare customer_typeid dm_integer;
declare doctypeid dm_integer;
declare UID dm_integer;
declare available_cashback dm_amount;
declare web_docid dm_integer;
declare current_cashback dm_amount;
declare weborder_amount dm_amount;
declare web_date dm_date;
begin
  select doctypeid, ct, get_flg_value(flags, 18) from tdb_docs where docid = :docid into :doctypeid, :customerid, :viaShopCart;

  :viashopcart = iif( (coalesce(:viashopcart, 0) = 1) or (flg_forced = 1), 1, 0) ;

  select c.customer_type_id from ts_customer c where customerid = :customerid into :customer_typeid;

  if ((:viashopcart = 1) and (:customer_typeid <> 4013)) then
  begin
    select data, ct from tdb_docs where docid=:docid into :docdate, :customerid;

    for select goodsid, sum(suma) * (get_cashback_percent(goodsid) / 100) from tdb_jurnal j
    where j.docid=:docid
    group by 1
    into :goodsid, :cashback
    do
    begin
       if (:cashback > 0) then
       begin
           update or insert into tdb_docs_cashback (docid, goodsid, cashback, valid_until, register_date)
           values (:docid, :goodsid, :cashback, :docdate + 180, :docdate+14)
           matching (docid, goodsid);
       end
    end

   /* in functie de rashod corectam cashbackul aplicat */
   if (exists(select * from tdb_jurnal j
        join tdb_docs d on d.docid = j.docid and d.docid = :docid and goodsid = 201028 )) then
   begin

       select z.cashback from get_available_cashback(:customerid) z into :available_cashback;
       if (:available_cashback > 0) then
       begin
         :web_docid = -1;
         :weborder_amount = 0;
         select sum(suma) from tdb_jurnal j where (docid = :docid) and (j.goodscomplect_id=-1) and (goodsid <> 201028) into :weborder_amount;
         select i.docid, i.data from SP_DOCS_INSPECTOR(:docid) i where doctypeid = 134 and i.flg_webshop_order=1 into :web_docid, :web_date;

         if (:web_docid>-1) then
         begin
               update or insert into tdb_docs_cashback_used (docid, cashback_used)
               values (:web_docid, GET_CASHBACK4ORDER(:web_date, :weborder_amount, :available_cashback))
               matching (docid);

              :current_cashback = 0;
              select sum(suma) from tdb_jurnal where docid = :docid and goodsid = 201028 into :current_cashback;
              if (abs(:current_cashback) <> abs(:available_cashback)) then
                  insert into email_messages (email, subject, body)
                  values ('salut@fantastic.md', 'Cashback difera!!!', 'la aplicarea cashbackului au aparut divergente: rashod docid: '|| :docid || ' cashback este = '||:current_cashback ||
                  ' in weborder docid=' || :web_docid ||' casback este ='|| :available_cashback);
         end
       end
   end
  end
end ^

CREATE OR ALTER PROCEDURE SP_CANCEL_CASHBACK (FDOCID DM_INTEGER)
AS 
declare CONFIG_DOCID DM_INTEGER;
declare RASHOD_DOCID DM_INTEGER;
begin
  :CONFIG_DOCID = -1;
  :RASHOD_DOCID = -1;

  for select DOCID
      from TDB_DOCS
      where PARENTDOCID = :FDOCID and
            DOCTYPEID = 115
      into :CONFIG_DOCID
  do
  begin
    if (:CONFIG_DOCID > -1) then
    begin
      select DOCID
      from TDB_DOCS
      where PARENTDOCID = :CONFIG_DOCID and
            DOCTYPEID = 107 and
            SUMA > 0
      into :RASHOD_DOCID;
      if (:RASHOD_DOCID > -1) then
      begin
        exception ERR_CANT_DELETE_DOCUMENT;
      end
      else
      begin
        delete from TDB_DOCS_CASHBACK_USED
        where DOCID = :FDOCID;
      end
    end
  end

end ^

CREATE OR ALTER PROCEDURE SP_CREATE_RASHOD (OLD_DOCID INTEGER)
RETURNS (RASHDOCID INTEGER)
AS 
DECLARE VARIABLE NEW_DOCID INTEGER;
DECLARE VARIABLE DTDEP INTEGER;
DECLARE VARIABLE CTDEP INTEGER;
DECLARE VARIABLE GOODSCOMPLECT_ID INTEGER;
DECLARE VARIABLE GOODSID INTEGER;
DECLARE VARIABLE UMID INTEGER;
DECLARE VARIABLE QTY DM_QTY;
DECLARE VARIABLE PRICE DOUBLE PRECISION ;
DECLARE VARIABLE SUMA DOUBLE PRECISION;
DECLARE VARIABLE SUMAVAT DOUBLE PRECISION;
DECLARE VARIABLE WARRANTY SMALLINT;
--DECLARE VARIABLE STOCK_QTY INTEGER;
DECLARE VARIABLE COST DOUBLE PRECISION ;
DECLARE VARIABLE FLAGS INTEGER;
DECLARE VARIABLE DT DM_INTEGER;
DECLARE VARIABLE USERID DM_INTEGER;
DECLARE VARIABLE COMMENTS TYPE OF COLUMN TDB_DOCS_PROPS.COMMENTS;
DECLARE VARIABLE INBAZA TYPE OF COLUMN TDB_DOCS_PROPS.INBAZA;
declare variable scetDOCID DM_INTEGER;
declare variable scetSUMA DM_PRICE;
declare variable docSUMA DM_PRICE;
declare variable parent_doctypeid dm_integer;
declare created_by dm_integer;
BEGIN

  /* 10.02.2012 */
  /* Permitem modificarea documentelor inlantuite */
  RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);


  SELECT DT, CREATED_BY, SUMA
  FROM TDB_DOCS
  WHERE DOCID = :old_docid
  INTO :DT, :USERID, :docSUMA;

  /* daca document cu acest cod de document exista in doctypeid=107 exception */
  IF (EXISTS(SELECT DOCID
             FROM TDB_DOCS
             WHERE DOCTYPEID = 107 AND
                   TDB_DOCS.PARENTDOCID = :old_docid)) THEN
  BEGIN
    EXCEPTION ERR_DOC_EXISTS;
  END

  /* 09.01.2012 */
  /* daca FLG_ACNT=1, si suma documentului este mai mare dekit suma din Scet Factura generata din acest document */
  /* atunci eroare */
  SELECT DOCID, SUMA
  FROM TDB_DOCS
  WHERE (PARENTDOCID=:old_docid) AND (DOCTYPEID=112)
  INTO :scetDOCID, :scetSUMA;

  IF (scetDOCID IS NOT NULL AND docSUMA>scetSUMA) THEN EXCEPTION ERR_RASHOD_ERROR '<MSG>Suma documentului este mai mare decit suma din factura!</MSG>';



  /* FIX: 02.04.2014 - Migram si contractul din document */
  /* cream documentul */
  INSERT INTO TDB_DOCS (
      DT,
      CT,
      DTDEP,
      CTDEP,
      DTSC,
      CTSC,
      SUMA,
      VAT,
      CURRENCYID,
      DISCOUNT,
      RATE,
      CREATED_DATE,
      CREATED_BY,
      DELETED_DATE,
      DELETED_BY,
      PARENTDOCID,
      ACC$MASK,
      DOCTYPEID,
      FLAGS,
      RATEUSD,
      CONTRACTID,
      responsible_userid
      )
  SELECT DT, CT, DTDEP, CTDEP, DTSC, CTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE, CREATED_DATE,
         CREATED_BY, DELETED_DATE, DELETED_BY, :old_docid, ACC$MASK, 107 /* RASHOD */ ,
         SET_FLG_VALUE(FLAGS, 1, 1) /* FLG_ACNT needed */ , RATEUSD, CONTRACTID,
         iif(coalesce(responsible_userid, 0) = 0, rdb$get_context('USER_SESSION', 'UserID'), responsible_userid)
  FROM TDB_DOCS
  WHERE DOCID = :old_docid
  RETURNING DOCID
  INTO :NEW_DOCID;


  /* produsele */
  FOR SELECT DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY,
             COST, FLAGS, created_by
      FROM TDB_JURNAL
      WHERE DOCID = :old_docid AND
            ((GOODSCOMPLECT_ID = -1))
      INTO :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :UMID, :QTY, :PRICE, :SUMA, :SUMAVAT,
           :WARRANTY, :COST, :FLAGS, :created_by
  DO
  BEGIN
    :FLAGS = SET_FLG_VALUE(:FLAGS, 2, 0);
    :CREATED_BY = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
    INSERT INTO TDB_JURNAL (
        DOCID,
        DTDEP,
        CTDEP,
        GOODSCOMPLECT_ID,
        GOODSID,
        UMID,
        QTY,
        PRICE,
        SUMA,
        SUMAVAT,
        WARRANTY,
        STOCK_QTY,
        COST,
        FLAGS,
        created_by)
    VALUES (:NEW_DOCID,
            :DTDEP,
            :CTDEP,
            :GOODSCOMPLECT_ID,
            :GOODSID,
            :UMID,
            :QTY,
            :PRICE,
            :SUMA,
            :SUMAVAT,
            :WARRANTY,
            COALESCE(
                               (SELECT SUM(QTY)
                                       FROM TS_GOODS_STOCK S1
                                       INNER JOIN (SELECT STOCKID FROM TS_STOCKS WHERE (PARENTID=1)) S2 ON (S2.STOCKID=S1.DTDEP)
                                       INNER JOIN (SELECT CUSTOMERID FROM TS_CUSTOMER WHERE (CUSTOMER_TYPE_ID=4002)) S3 ON (S3.CUSTOMERID=S1.DT)
                                       WHERE (S1.GOODSID=:GOODSID)
                               ),0) - :qty,
            :COST,
            :FLAGS,
            :created_by);
  END
  RASHDOCID = :NEW_DOCID;

  /* set FLG_INVOICE=7 */
  UPDATE TDB_DOCS
  SET
    stateid = 2, /* Confirmarea clientului */
    FLAGS = SET_FLG_VALUE(FLAGS, 7, 1)
  WHERE DOCID = :old_docid;

  /* inchidem documentul parinte */
  select doctypeid from tdb_docs where docid=:old_docid into :parent_doctypeid;
  if (:parent_doctypeid = 134) then
      update tdb_docs set flags=set_FLG_VALUE(flags, 10,1) where docid=:old_docid;

  /* aducem comentariile din documentul initial */
  INSERT INTO TDB_DOCS_PROPS (DOCID,INBAZA,COMMENTS)
  SELECT :NEW_DOCID, INBAZA, COMMENTS FROM TDB_DOCS_PROPS WHERE DOCID = :old_docid;

  /* 24.09.2026 - livrarea: din parinte sau, daca parintele nu are, din primul
     document de mai sus din lant (Oferta -> Proforma -> Rezerva) */
  EXECUTE PROCEDURE SP_DOC_COPY_DELIVERY(:old_docid, :NEW_DOCID);

  /* create event Rashod=1 */
  EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:DT, 1, '', :NEW_DOCID, :USERID);

  RDB$SET_CONTEXT('USER_SESSION', 'RequireModifyDOC', 0);


  SUSPEND;

END ^

CREATE OR ALTER PROCEDURE WEB_SET_DOC_PAYMENT_ANALYTIC (A_DOCID INTEGER,
A_CODE VARCHAR(32) CHARACTER SET UTF8)
RETURNS (O_DTSC INTEGER)
SQL SECURITY DEFINER
AS 
BEGIN
    O_DTSC = NULL;
    SELECT FIRST 1 SYSSID FROM TS_SYSS
    WHERE PARENTID = 26 AND VALUE_STR = TRIM(:A_CODE)
    INTO :O_DTSC;
    IF (O_DTSC IS NULL) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9);
    RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);
    UPDATE TDB_DOCS SET DTSC = :O_DTSC
    WHERE DOCID = :A_DOCID AND DOCTYPEID IN (134, 1791) AND CREATED_BY = 9
      AND DELETED_DATE IS NULL AND DTSC IS DISTINCT FROM :O_DTSC;
    IF (ROW_COUNT = 0) THEN
        O_DTSC = NULL;
    SUSPEND;
END ^

CREATE OR ALTER PROCEDURE WEB_SIGNUP_OFFER_STATUS (CUSTOMERID INTEGER,
SHOP_CART_ID VARCHAR(60) CHARACTER SET UTF8 = NULL,
MIN_MARGIN NUMERIC(9, 2) = 18)
RETURNS (STATUS VARCHAR(16) CHARACTER SET UTF8,
DISCOUNT_PERCENT NUMERIC(5, 2),
EXPIRES_DATE DATE,
ELIGIBLE_SUM NUMERIC(15, 2),
DISCOUNT NUMERIC(15, 2))
AS 
DECLARE VARIABLE USED_DOCID INTEGER;
    DECLARE VARIABLE GOODSID    INTEGER;
    DECLARE VARIABLE QTY        NUMERIC(15,3);
    DECLARE VARIABLE PRICE      NUMERIC(15,2);
    DECLARE VARIABLE PROMO      NUMERIC(15,2);
    DECLARE VARIABLE MARGIN     NUMERIC(9,2);
BEGIN
    STATUS = 'NONE';
    ELIGIBLE_SUM = 0;
    DISCOUNT = 0;

    SELECT O.DISCOUNT_PERCENT, O.EXPIRES_DATE, O.USED_DOCID
    FROM TWEB_SIGNUP_OFFER O
    WHERE O.CUSTOMERID = :CUSTOMERID
    INTO :DISCOUNT_PERCENT, :EXPIRES_DATE, :USED_DOCID;

    IF (ROW_COUNT = 0) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    IF (USED_DOCID IS NOT NULL) THEN
        STATUS = 'USED';
    ELSE IF (EXPIRES_DATE < CURRENT_DATE) THEN
        STATUS = 'EXPIRED';
    ELSE IF (EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID)) THEN
        STATUS = 'HAS_ORDERS';
    ELSE
        STATUS = 'OK';

    IF (STATUS <> 'OK') THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Cosul clientului: cel indicat (SHOP_CART_ID) sau, ca in
       SP_MK_APPLY_PROMOCODE_AUTHUSER, toate rindurile lui cu MAX(QTY) pe produs.
       Doar produsele de pe site (TWEB_CACHE_GOODS) fara actiune promotionala activa
       si cu marja peste MIN_MARGIN. */
    FOR SELECT C.GOODSID, MAX(C.QTY)
        FROM TWEB_SHOP_CART C
        WHERE C.CUSTOMERID = :CUSTOMERID
          AND (:SHOP_CART_ID IS NULL OR C.SHOP_CART_ID = :SHOP_CART_ID)
          AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS G WHERE G.GOODSID = C.GOODSID)
        GROUP BY C.GOODSID
        INTO :GOODSID, :QTY
    DO
    BEGIN
        IF (COALESCE(QTY, 0) <= 0) THEN QTY = 1;

        PROMO = 0;
        SELECT DISCOUNT_VALUE FROM W_GET_DISCOUNT_VALUE(:GOODSID) INTO :PROMO;
        IF (COALESCE(PROMO, 0) > 0) THEN CONTINUE;

        MARGIN = NULL;
        SELECT MARGIN_PCT FROM WEB_SIGNUP_OFFER_MARGIN(:GOODSID) INTO :MARGIN;
        IF (MARGIN IS NULL OR MARGIN <= COALESCE(:MIN_MARGIN, 0)) THEN CONTINUE;

        PRICE = 0;
        SELECT PRICE_MDL FROM GET_GOODS_PRICE(:GOODSID, 1, 498) INTO :PRICE;
        IF (COALESCE(PRICE, 0) <= 0) THEN CONTINUE;

        ELIGIBLE_SUM = ELIGIBLE_SUM + PRICE * QTY;
    END

    DISCOUNT = ROUND(ELIGIBLE_SUM * DISCOUNT_PERCENT / 100, 2);
    SUSPEND;
END ^

CREATE OR ALTER PROCEDURE WEB_SIGNUP_OFFER_APPLY (DOCID INTEGER,
CUSTOMERID INTEGER,
MIN_MARGIN NUMERIC(9, 2) = 18)
RETURNS (STATUS VARCHAR(16) CHARACTER SET UTF8,
DISCOUNT NUMERIC(15, 2))
AS 
DECLARE VARIABLE PERCENT      NUMERIC(5,2);
    DECLARE VARIABLE EXPIRES_DATE DATE;
    DECLARE VARIABLE USED_DOCID   INTEGER;
    DECLARE VARIABLE GOODSID      INTEGER;
    DECLARE VARIABLE QTY          NUMERIC(15,3);
    DECLARE VARIABLE PRICE        NUMERIC(15,2);
    DECLARE VARIABLE PROMO        NUMERIC(15,2);
    DECLARE VARIABLE MARGIN       NUMERIC(9,2);
    DECLARE VARIABLE ELIGIBLE_SUM NUMERIC(15,2);
    DECLARE VARIABLE DTDEP        INTEGER;
    DECLARE VARIABLE CTDEP        INTEGER;
    DECLARE VARIABLE WARRANTY     INTEGER;
    DECLARE VARIABLE UMID         INTEGER;
BEGIN
    STATUS = 'NONE';
    DISCOUNT = 0;

    SELECT O.DISCOUNT_PERCENT, O.EXPIRES_DATE, O.USED_DOCID
    FROM TWEB_SIGNUP_OFFER O
    WHERE O.CUSTOMERID = :CUSTOMERID
    INTO :PERCENT, :EXPIRES_DATE, :USED_DOCID;

    IF (ROW_COUNT = 0) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Idempotent: deja aplicata pe acest document */
    IF (USED_DOCID = DOCID) THEN
    BEGIN
        STATUS = 'ALREADY';
        SELECT COALESCE(-1 * SUM(J.SUMA), 0) FROM TDB_JURNAL J
        WHERE J.DOCID = :DOCID AND J.GOODSID = 368756
        INTO :DISCOUNT;
        SUSPEND;
        EXIT;
    END

    IF (USED_DOCID IS NOT NULL) THEN
        STATUS = 'USED';
    ELSE IF (EXPIRES_DATE < CURRENT_DATE) THEN
        STATUS = 'EXPIRED';
    ELSE IF (NOT EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCID = :DOCID AND D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID)) THEN
        STATUS = 'NOT_FOUND';
    ELSE IF (EXISTS (SELECT 1 FROM TDB_DOCS D WHERE D.DOCTYPEID = 134 AND D.CT = :CUSTOMERID AND D.DOCID <> :DOCID)) THEN
        STATUS = 'HAS_ORDERS';
    ELSE
        STATUS = 'OK';

    IF (STATUS <> 'OK') THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* Liniile comenzii: produsele de pe site, fara actiune promotionala activa,
       cu marja peste MIN_MARGIN, la pretul si cantitatea din document */
    ELIGIBLE_SUM = 0;
    FOR SELECT J.GOODSID, J.QTY, J.PRICE, J.DTDEP, J.CTDEP, J.WARRANTY
        FROM TDB_JURNAL J
        WHERE J.DOCID = :DOCID
          AND J.QTY > 0 AND J.PRICE > 0
          AND J.GOODSID <> 368756
          AND EXISTS (SELECT 1 FROM TWEB_CACHE_GOODS G WHERE G.GOODSID = J.GOODSID)
        INTO :GOODSID, :QTY, :PRICE, :DTDEP, :CTDEP, :WARRANTY
    DO
    BEGIN
        PROMO = 0;
        SELECT DISCOUNT_VALUE FROM W_GET_DISCOUNT_VALUE(:GOODSID) INTO :PROMO;
        IF (COALESCE(PROMO, 0) > 0) THEN CONTINUE;
        MARGIN = NULL;
        SELECT MARGIN_PCT FROM WEB_SIGNUP_OFFER_MARGIN(:GOODSID) INTO :MARGIN;
        IF (MARGIN IS NULL OR MARGIN <= COALESCE(:MIN_MARGIN, 0)) THEN CONTINUE;
        ELIGIBLE_SUM = ELIGIBLE_SUM + PRICE * QTY;
    END

    DISCOUNT = ROUND(ELIGIBLE_SUM * PERCENT / 100, 2);
    IF (DISCOUNT <= 0) THEN
    BEGIN
        STATUS = 'NOTHING';
        SUSPEND;
        EXIT;
    END

    /* Depozitele si garantia - ca la liniile deja scrise de WEB_CREATE_TRANSACTION3 */
    SELECT FIRST 1 J.DTDEP, J.CTDEP, J.WARRANTY FROM TDB_JURNAL J
    WHERE J.DOCID = :DOCID
    INTO :DTDEP, :CTDEP, :WARRANTY;

    UMID = NULL;
    SELECT G.UMID FROM TS_GOODS G WHERE G.GOODSID = 368756 INTO :UMID;
    IF (UMID IS NULL) THEN UMID = 1;

    INSERT INTO TDB_JURNAL (
        DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID,
        GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS
    ) VALUES (
        :DOCID, :DTDEP, :CTDEP, -1,
        368756, 1, :UMID, -1 * :DISCOUNT, COALESCE(:WARRANTY, 0), 0, 1
    );

    UPDATE TWEB_SIGNUP_OFFER O
    SET O.USED_DOCID = :DOCID, O.USED_DATE = CURRENT_TIMESTAMP, O.USED_AMOUNT = :DISCOUNT
    WHERE O.CUSTOMERID = :CUSTOMERID;

    SUSPEND;
END ^

CREATE OR ALTER PROCEDURE SP_WEB_REGISTER_FINANTARE (CREDIT_SUMA DM_PRICE NOT NULL,
CREDIT_PERIOADA DM_INTEGER_NN,
NPP DM_VARCHAR128 NOT NULL,
IDEN DM_VARCHAR16 NOT NULL,
DATA_NASTERII DM_VARCHAR10 NOT NULL,
CONTACT_TELEFON DM_VARCHAR255 NOT NULL,
FLG_COPY_BY_FAX DM_BOOLEAN_NN,
SCAN1 DM_BLOBIMAGE,
SCAN2 DM_BLOBIMAGE,
AVANS DM_PRICE = 0,
PLATA_LUNARA DM_PRICE = 0,
CREDIT_TYPE DM_VARCHAR32 = '',
ORG_ID DM_INTEGER = -1,
DELIVERYADDRESS DM_VARCHAR255 = '',
A_GOODSIDS VARCHAR(1000) CHARACTER SET UTF8 = '',
A_CUSTOMERID INTEGER = -1)
RETURNS (DOCID DM_INTEGER)
SQL SECURITY DEFINER
AS 
declare variable TIP_CREDIT varchar(128);
declare variable V_FIRMA integer = 316910; /* firma comenzilor web, ca in WEB_CREATE_TRANSACTION3 / _PHONE2 */
declare variable V_DT integer;
declare variable V_DTDEP integer;
declare variable V_CTDEP integer;
declare variable V_DEF_DTSC integer;
declare variable V_CURRENCYID integer;
declare variable V_SC2 integer;
declare variable V_RATE double precision;
declare variable V_RATEUSD double precision;
declare variable V_DTSC integer;
declare variable V_PHONE8 varchar(8);
declare variable V_CAND integer;
declare variable V_LIST varchar(1010);
declare variable V_POS integer;
declare variable V_ITEM varchar(1010);
declare variable V_MISSING integer;
declare variable V_ATTACHED smallint = 0;
BEGIN
     /* pentru aceasta procedure trebuie UserContext de create */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9); /* WebUser */
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

     /* ================================================================
        Comutatorul FIN_AS_WEBORDER = 0: Cerere de finantare 1791 (codul de pina la 10.10.2026)
        ================================================================ */
     IF (FN_FIN_AS_WEBORDER() = 0) THEN
     BEGIN

    --    in autonomous transaction do
    --        insert into tdb_debug (text) values ('1. Cerere de finantare. Start.');

        /* create DOC, WebUser, FLG_ACNT */
        INSERT INTO TDB_DOCS
        (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, FLAGS)
        VALUES
        (316910 /* SOLUTII COMERCIALE SRL, 18.09.2026; inainte: iif(current_date>='17.09.2024', 307225, 218482) */, 286, 43, 43, 5108, 498, 1791, 9, 1, NULL, 2)
        RETURNING DOCID INTO :DOCID;

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('2. Cerere de finantare. creat document nou. DocID:'||:DOCID);

        select title from ts_finance_customer where uid=:org_id into :tip_credit;
        :tip_credit = coalesce(:tip_credit, 'NONE');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('3. Cerere de finantare. tip_credit: '||:tip_credit);

        /* create DOC comments */
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                             'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('4. Cerere de finantare. adaugam inregistrarea in tabelul TWEB_CRERE_FINANTARE.');

        /* create details */
        INSERT INTO TWEB_CERERE_FINANTARE
        (
         DOCID,
         CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
         FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
        )
        VALUES
        (
         :DOCID,
         :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
         :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
        );

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('5. Cerere de finantare. Adaugat cu succes.');


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('6. Cerere de finantare. Trimite scrisoare pe web@fantastic.md.');
        /* create EMail */
        INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
        VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),'Cerere de finantare de la '||coalesce(:NPP, ''),
                'Cerere de finantare din partea lui '||:NPP||'<br>'||
                'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
                'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
                'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
                'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
                'Tip credit: '||:tip_credit ||
                '<br><br>Contactati clientul!');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('7. Cerere de finantare. Generam eveniment.');

        /* create event */
        EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(316910,7,:NPP,:DOCID,9); /* WebUser */

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('8. Cerere de finantare. Trimitem SMS pe numarul de telefon :contact_telefon');

        insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
        values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

         SUSPEND;
         EXIT;
     END

     /* ================================================================
        Comutatorul = 1: comanda Web-Order 134 cu plata pe credit; dosarul ramine
        in TWEB_CERERE_FINANTARE (fila "Credit" din WMS)
        ================================================================ */
     V_DTSC = FN_PAY_DTSC(IIF(COALESCE(TRIM(:CREDIT_TYPE), '') SIMILAR TO '0+([.,]0+)?',
                              'PAY_CREDIT0', 'PAY_CREDIT'));

     select title from ts_finance_customer where uid=:org_id into :tip_credit;
     :tip_credit = coalesce(:tip_credit, 'NONE');

     /* D3: credit cerut din "1 click" si apoi prin formular -> dosarul merge pe comanda existenta.
        Conditii: 134 de pe site, deschisa, nestearsa, din ultimele 72 h, pe credit (analitica
        sau metoda de plata din deal), fara dosar, acelasi telefon (ultimele 8 cifre), si contine
        toate produsele cererii. Fara lista de produse (site-ul vechi) -> mereu comanda noua. */
     DOCID = NULL;
     V_PHONE8 = FN_PHONE_LAST8(:CONTACT_TELEFON);
     IF (COALESCE(TRIM(:A_GOODSIDS), '') <> '' AND V_PHONE8 IS NOT NULL) THEN
     BEGIN
         FOR SELECT D.DOCID
               FROM TDB_DOCS D
              WHERE D.DOCTYPEID = 134
                AND D.CREATED_BY = 9
                AND D.DELETED_DATE IS NULL
                AND COALESCE(GET_FLG_VALUE(D.FLAGS, 10), 0) = 0
                AND D.CREATED_DATE >= DATEADD(-72 HOUR TO CURRENT_TIMESTAMP)
                AND NOT EXISTS (SELECT 1 FROM TWEB_CERERE_FINANTARE F
                                 WHERE F.DOCID = D.DOCID
                                   AND COALESCE(F.IDEN, '') <> '')  /* stub-ul de la "1 click" (fara IDNP) se completeaza */
                AND (FN_PAY_IS_CREDIT(D.DTSC) = 1
                     OR EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                                  JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                                 WHERE DD.DOCID = D.DOCID
                                   AND UPPER(TRIM(DL.PAYMENT_METHOD)) STARTING WITH 'CREDIT'))
                AND (EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                               JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                              WHERE DD.DOCID = D.DOCID AND FN_PHONE_LAST8(DL.PHONE) = :V_PHONE8)
                     OR EXISTS (SELECT 1 FROM TWEB_TRANSACTION T
                                 WHERE T.DOCID = D.DOCID AND FN_PHONE_LAST8(T.PHONES) = :V_PHONE8))
              ORDER BY D.DOCID DESC
               INTO :V_CAND
         DO
         BEGIN
             /* toate produsele cererii trebuie sa fie deja in comanda */
             V_MISSING = 0;
             V_LIST = TRIM(:A_GOODSIDS) || ',';
             WHILE (V_LIST <> '' AND V_MISSING = 0) DO
             BEGIN
                 V_POS = POSITION(',' IN V_LIST);
                 V_ITEM = TRIM(SUBSTRING(V_LIST FROM 1 FOR V_POS - 1));
                 V_LIST = SUBSTRING(V_LIST FROM V_POS + 1);
                 IF (V_ITEM SIMILAR TO '[0-9]+') THEN
                     IF (NOT EXISTS (SELECT 1 FROM TDB_JURNAL J
                                      WHERE J.DOCID = :V_CAND AND J.GOODSID = CAST(:V_ITEM AS INTEGER))) THEN
                         V_MISSING = 1;
             END
             IF (V_MISSING = 0) THEN
             BEGIN
                 DOCID = V_CAND;
                 LEAVE;
             END
         END
     END

     IF (DOCID IS NOT NULL) THEN
     BEGIN
         /* comanda exista deja: devine comanda pe credit cu dosar */
         V_ATTACHED = 1;
         UPDATE TDB_DOCS SET DTSC = :V_DTSC
          WHERE DOCID = :DOCID AND :V_DTSC IS NOT NULL AND DTSC IS DISTINCT FROM :V_DTSC;
         SELECT DT FROM TDB_DOCS WHERE DOCID = :DOCID INTO :V_DT;
         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB',
             'Clientul a completat si formularul de credit: dosarul a fost atasat la aceasta comanda.');
     END
     ELSE
     BEGIN
         /* comanda noua: valorile implicite ale Web-Order-ului pentru firma web */
         SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
           FROM TS_DOCTYPES_DEFVALUES
          WHERE DOCTYPEID = 134 AND FIRMA = :V_FIRMA
           INTO :V_DT, :V_DTDEP, :V_CTDEP, :V_DEF_DTSC, :V_CURRENCYID, :V_SC2;
         V_DT = COALESCE(V_DT, V_FIRMA);
         V_DTDEP = COALESCE(V_DTDEP, 43);
         V_CTDEP = COALESCE(V_CTDEP, 43);
         V_CURRENCYID = COALESCE(V_CURRENCYID, 498);
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :V_CURRENCYID INTO :V_RATE;
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :V_RATEUSD;

         /* SP_DEAL_ATTACH_DOC (trigger-ul TDB_DOCS_AI_DEAL) citeste sursa: deal FINANCE_REQUEST */
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', 'FINANCE_REQUEST');
         INSERT INTO TDB_DOCS
         (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, SC2, FLAGS)
         VALUES
         (:V_DT, IIF(COALESCE(:A_CUSTOMERID, -1) > 0, :A_CUSTOMERID, 286), :V_DTDEP, :V_CTDEP,
          COALESCE(:V_DTSC, :V_DEF_DTSC, 5108), :V_CURRENCYID, 134, 9, COALESCE(:V_RATE, 1), :V_RATEUSD,
          :V_SC2, 2)
         RETURNING DOCID INTO :DOCID;
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', NULL);

         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'COMANDA PE CREDIT (formularul de credit)');
     END

     /* comentariile cererii (ca la 1791) */
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                          'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);

     /* dosarul de credit; UPDATE OR INSERT - comanda "1 click" cu plata in credit are deja un stub
        (WEB_CREATE_TRANSACTION_PHONE2), care se completeaza aici */
     UPDATE OR INSERT INTO TWEB_CERERE_FINANTARE
     (
      DOCID,
      CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
      FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
     )
     VALUES
     (
      :DOCID,
      :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
      :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
     )
     MATCHING (DOCID);

     /* datele comenzii in deal (nume, telefon, adresa, plata; UTM-ul din TWEB_ORDER_UTM).
        La comanda existenta (D3) nu se suprascrie ce a venit din "1 click". */
     EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :NPP, :CONTACT_TELEFON,
         NULLIF(TRIM(:DeliveryAddress), ''), NULL, 'Credit', NULL, NULL, NULL, NULL, NULL,
         IIF(:V_ATTACHED = 1, 0, 1));

     /* e-mail */
     INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
     VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),
             'Comanda pe credit #' || :DOCID || ' de la '||coalesce(:NPP, ''),
             IIF(:V_ATTACHED = 1, 'Dosar de credit atasat la comanda existenta #' || :DOCID || '<br>',
                                  'Comanda pe credit (Web-Order) #' || :DOCID || '<br>') ||
             'Cerere de finantare din partea lui '||:NPP||'<br>'||
             'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
             'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
             'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
             'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
             'Tip credit: '||:tip_credit ||
             '<br><br>Contactati clientul!');

     /* eveniment 7 = cerere de credit (sunetul si reincarcarea in WMS: frame24 si frame51) */
     EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(COALESCE(:V_DT, :V_FIRMA), 7, :NPP, :DOCID, 9); /* WebUser */

     insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
     values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

     SUSPEND;
END ^

CREATE OR ALTER PROCEDURE SP_DEAL_RECALC_STATES (A_DEAL_ID BIGINT,
A_USER_ID INTEGER = NULL)
SQL SECURITY DEFINER
AS 
DECLARE V_FLAGS INTEGER;
DECLARE V_PIPE INTEGER;
DECLARE V_PAY INTEGER;
DECLARE V_FIN INTEGER;
DECLARE V_DLV INTEGER;
DECLARE V_CLOSED_AT TIMESTAMP;
DECLARE V_CLOSED_RESULT VARCHAR(16);
DECLARE V_PHONE VARCHAR(40);
DECLARE V_ADDRESS VARCHAR(500);
DECLARE V_PIPE_CODE VARCHAR(32);
DECLARE V_PIPE_SORT INTEGER;
DECLARE V_PIPE_FINAL SMALLINT;
DECLARE V_PIPE_CANCEL SMALLINT;
DECLARE V_PAY_CODE VARCHAR(32);
DECLARE V_FIN_CODE VARCHAR(32);
DECLARE V_DLV_CODE VARCHAR(32);
DECLARE V_DLV_SORT INTEGER;
DECLARE V_DLV_FINAL SMALLINT;
DECLARE N_TOTAL INTEGER;
DECLARE N_LIVE INTEGER;
DECLARE N_WORK INTEGER;
DECLARE N_SALE INTEGER;
DECLARE N_FIN INTEGER;
DECLARE S_SALE DOUBLE PRECISION;
DECLARE S_PROFORMA DOUBLE PRECISION;
DECLARE S_PAID DOUBLE PRECISION;
DECLARE S_TOTAL DOUBLE PRECISION;
DECLARE N_DLV_ROWS INTEGER;
DECLARE N_DLV_SENT INTEGER;
DECLARE V_NEW_CODE VARCHAR(32);
DECLARE V_NEW_ID INTEGER;
DECLARE V_NEW_SORT INTEGER;
DECLARE V_NEW_PHONE VARCHAR(40);
DECLARE V_NEW_ADDRESS VARCHAR(500);
DECLARE V_DTSC_C0 INTEGER;
DECLARE V_DTSC_C INTEGER;
BEGIN
    SELECT d.FLAGS, d.PIPE_STATE_ID, d.PAY_STATE_ID, d.FIN_STATE_ID, d.DLV_STATE_ID,
           d.CLOSED_AT, d.CLOSED_RESULT, d.PHONE, d.DELIVERY_ADDRESS
    FROM TDB_DEALS d WHERE d.DEAL_ID = :A_DEAL_ID
    INTO :V_FLAGS, :V_PIPE, :V_PAY, :V_FIN, :V_DLV,
         :V_CLOSED_AT, :V_CLOSED_RESULT, :V_PHONE, :V_ADDRESS;

    IF (V_PIPE IS NULL) THEN EXIT;
    /* comanda 134 cu analitica de credit = cerere de finantare (unificarea 1791 -> 134) */
    V_DTSC_C0 = FN_PAY_DTSC('PAY_CREDIT0');
    V_DTSC_C = FN_PAY_DTSC('PAY_CREDIT');
    V_FLAGS = COALESCE(V_FLAGS, 0);

    /* documentele deal-ului */
    SELECT COUNT(*),
           SUM(CASE WHEN d.DELETED_DATE IS NULL THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID IN (115, 101) THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID = 107 THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND (d.DOCTYPEID = 1791
                    OR (d.DOCTYPEID = 134 AND d.DTSC IN (:V_DTSC_C0, :V_DTSC_C))) THEN 1 ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NOT NULL THEN 0
                    WHEN d.DOCTYPEID = 107 THEN  d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1)
                    WHEN d.DOCTYPEID = 110 THEN -d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1)
                    ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NULL AND d.DOCTYPEID = 101
                    THEN d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1) ELSE 0 END),
           SUM(CASE WHEN d.DELETED_DATE IS NOT NULL THEN 0
                    WHEN d.DOCTYPEID IN (116, 120)
                        THEN  COALESCE(dd.LINK_SUM, d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1))
                    WHEN d.DOCTYPEID IN (117, 119, 1199)
                        THEN -COALESCE(dd.LINK_SUM, d.SUMA * COALESCE(NULLIF(d.RATE, 0), 1))
                    ELSE 0 END)
    FROM TDB_DEAL_DOCS dd
    JOIN TDB_DOCS d ON d.DOCID = dd.DOCID
    WHERE dd.DEAL_ID = :A_DEAL_ID
    INTO :N_TOTAL, :N_LIVE, :N_WORK, :N_SALE, :N_FIN, :S_SALE, :S_PROFORMA, :S_PAID;

    N_TOTAL = COALESCE(N_TOTAL, 0);  N_LIVE = COALESCE(N_LIVE, 0);
    N_WORK = COALESCE(N_WORK, 0);    N_SALE = COALESCE(N_SALE, 0);
    N_FIN = COALESCE(N_FIN, 0);
    S_SALE = COALESCE(S_SALE, 0);    S_PROFORMA = COALESCE(S_PROFORMA, 0);
    S_PAID = COALESCE(S_PAID, 0);

    /* livrare + date de contact lipsa */
    SELECT COUNT(*),
           SUM(CASE WHEN dl.TRANSMIS_CURIER IS NOT NULL
                      OR NULLIF(TRIM(dl.AWB), '') IS NOT NULL THEN 1 ELSE 0 END),
           MAX(NULLIF(TRIM(dl.DELIVERY_ADDRESS), ''))
    FROM TDB_DEAL_DOCS dd
    JOIN TDB_DOCS d ON d.DOCID = dd.DOCID AND d.DELETED_DATE IS NULL
    JOIN TDB_DOCS_DELIVERY dl ON dl.DOCID = d.DOCID
    WHERE dd.DEAL_ID = :A_DEAL_ID
    INTO :N_DLV_ROWS, :N_DLV_SENT, :V_NEW_ADDRESS;
    N_DLV_ROWS = COALESCE(N_DLV_ROWS, 0);  N_DLV_SENT = COALESCE(N_DLV_SENT, 0);

    IF (V_ADDRESS IS NULL AND V_NEW_ADDRESS IS NOT NULL) THEN
        UPDATE TDB_DEALS SET DELIVERY_ADDRESS = LEFT(:V_NEW_ADDRESS, 500)
        WHERE DEAL_ID = :A_DEAL_ID;

    IF (V_PHONE IS NULL) THEN
    BEGIN
        SELECT FIRST 1 LEFT(TRIM(p.PHONENUMBER), 40)
        FROM TDB_DEAL_DOCS dd
        JOIN TDB_DOCS_PHONES p ON p.DOCID = dd.DOCID
        WHERE dd.DEAL_ID = :A_DEAL_ID AND NULLIF(TRIM(p.PHONENUMBER), '') IS NOT NULL
        ORDER BY dd.DOCID
        INTO :V_NEW_PHONE;
        IF (V_NEW_PHONE IS NOT NULL) THEN
            UPDATE TDB_DEALS SET PHONE = :V_NEW_PHONE WHERE DEAL_ID = :A_DEAL_ID;
    END

    IF (V_PHONE IS NULL AND V_NEW_PHONE IS NULL) THEN
        EXECUTE PROCEDURE SP_DEAL_SYNC_CONTACT(:A_DEAL_ID);

    SELECT CODE FROM TS_DEAL_STATES WHERE STATE_ID = :V_PAY INTO :V_PAY_CODE;
    SELECT CODE FROM TS_DEAL_STATES WHERE STATE_ID = :V_FIN INTO :V_FIN_CODE;

    /* ---- FIN ---- */
    IF (BIN_AND(V_FLAGS, 4) = 0 AND N_FIN > 0
        AND (V_FIN_CODE IS NULL OR V_FIN_CODE = 'FIN_NONE')) THEN
    BEGIN
        SELECT STATE_ID FROM SP_DEAL_GET_STATE_ID('FIN_REQUESTED') INTO :V_NEW_ID;
        EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'FIN', :V_NEW_ID, :A_USER_ID, 'AUTO');
        V_FIN_CODE = 'FIN_REQUESTED';
    END

    /* ---- PAY ---- */
    IF (BIN_AND(V_FLAGS, 2) = 0) THEN
    BEGIN
        S_TOTAL = CASE WHEN S_SALE <> 0 THEN S_SALE ELSE S_PROFORMA END;
        V_NEW_CODE = NULL;
        IF (S_PAID > 0.005) THEN
            V_NEW_CODE = CASE WHEN S_TOTAL > 0.005 AND S_PAID >= S_TOTAL - 0.005
                              THEN 'PAY_PAID' ELSE 'PAY_PARTIAL' END;
        ELSE IF (V_PAY_CODE IS NULL OR V_PAY_CODE IN ('PAY_PARTIAL', 'PAY_PAID')) THEN
            V_NEW_CODE = 'PAY_WAITING';
        /* PAY_NONE / PAY_WAITING / PAY_FAILED fara incasari raman cum sunt */

        IF (V_NEW_CODE IS NOT NULL AND V_NEW_CODE IS DISTINCT FROM V_PAY_CODE) THEN
        BEGIN
            SELECT STATE_ID FROM SP_DEAL_GET_STATE_ID(:V_NEW_CODE) INTO :V_NEW_ID;
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'PAY', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_PAY_CODE = V_NEW_CODE;
        END
    END

    /* ---- DLV: doar inainte, niciodata peste o stare finala sau DLV_FAILED ---- */
    SELECT CODE, SORT_ORDER, IS_FINAL FROM TS_DEAL_STATES WHERE STATE_ID = :V_DLV
    INTO :V_DLV_CODE, :V_DLV_SORT, :V_DLV_FINAL;

    IF (BIN_AND(V_FLAGS, 8) = 0 AND N_DLV_ROWS > 0 AND COALESCE(V_DLV_FINAL, 0) = 0) THEN
    BEGIN
        V_NEW_CODE = CASE WHEN N_DLV_SENT > 0 THEN 'DLV_IN_TRANSIT' ELSE 'DLV_PREPARING' END;
        V_NEW_ID = NULL;
        SELECT STATE_ID, SORT_ORDER FROM TS_DEAL_STATES
        WHERE CODE = :V_NEW_CODE AND IS_ACTIVE = 1
        INTO :V_NEW_ID, :V_NEW_SORT;
        IF (V_NEW_ID IS NOT NULL AND V_NEW_SORT > COALESCE(V_DLV_SORT, 0)) THEN
        BEGIN
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'DLV', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_DLV_CODE = V_NEW_CODE;
        END
    END

    /* ---- PIPE ---- */
    SELECT CODE, SORT_ORDER, IS_FINAL, IS_CANCEL FROM TS_DEAL_STATES WHERE STATE_ID = :V_PIPE
    INTO :V_PIPE_CODE, :V_PIPE_SORT, :V_PIPE_FINAL, :V_PIPE_CANCEL;

    IF (BIN_AND(V_FLAGS, 1) = 0 AND COALESCE(V_PIPE_FINAL, 0) = 0) THEN
    BEGIN
        IF (N_LIVE = 0) THEN               /* toate sterse (si fizic: N_TOTAL = 0) */
            V_NEW_CODE = 'PIPE_CANCELLED_BY_SHOP';
        ELSE IF (V_DLV_CODE = 'DLV_DELIVERED') THEN
            V_NEW_CODE = 'PIPE_DELIVERED';
        ELSE IF (V_DLV_CODE = 'DLV_IN_TRANSIT') THEN
            V_NEW_CODE = 'PIPE_ON_DELIVERY';
        ELSE IF (N_SALE > 0) THEN
            V_NEW_CODE = 'PIPE_READY_TO_SHIP';
        ELSE IF (N_WORK > 0) THEN
            V_NEW_CODE = 'PIPE_IN_WORK';
        ELSE
            V_NEW_CODE = 'PIPE_WAITING_CHECK';

        V_NEW_ID = NULL;
        SELECT STATE_ID, SORT_ORDER FROM TS_DEAL_STATES
        WHERE CODE = :V_NEW_CODE AND IS_ACTIVE = 1
        INTO :V_NEW_ID, :V_NEW_SORT;

        /* etapa avanseaza automat DOAR inainte: o etapa aleasa de om in
           documentul WMS (ex. "In lucru" pe un Web-Order) nu e readusa inapoi,
           iar documentele noi o duc mai departe (vanzare -> gata de expediere) */
        IF (V_NEW_ID IS NOT NULL AND V_NEW_CODE IS DISTINCT FROM V_PIPE_CODE
            AND V_NEW_SORT > COALESCE(V_PIPE_SORT, 0)) THEN
        BEGIN
            EXECUTE PROCEDURE SP_DEAL_APPLY_STATE(:A_DEAL_ID, 'PIPE', :V_NEW_ID, :A_USER_ID, 'AUTO');
            V_PIPE_CODE = V_NEW_CODE;
            SELECT IS_CANCEL FROM TS_DEAL_STATES WHERE STATE_ID = :V_NEW_ID INTO :V_PIPE_CANCEL;
        END
    END

    /* ---- inchidere / redeschidere ---- */
    IF (COALESCE(V_PIPE_CANCEL, 0) = 1) THEN
    BEGIN
        IF (V_CLOSED_AT IS NULL) THEN
            UPDATE TDB_DEALS SET CLOSED_AT = CURRENT_TIMESTAMP, CLOSED_RESULT = 'CANCEL',
                                 UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
            WHERE DEAL_ID = :A_DEAL_ID;
    END
    ELSE IF (V_PIPE_CODE = 'PIPE_DELIVERED'
             AND (V_PAY_CODE = 'PAY_PAID' OR V_FIN_CODE = 'FIN_DISBURSED')) THEN
    BEGIN
        IF (V_CLOSED_AT IS NULL) THEN
            UPDATE TDB_DEALS SET CLOSED_AT = CURRENT_TIMESTAMP, CLOSED_RESULT = 'SUCCESS',
                                 UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
            WHERE DEAL_ID = :A_DEAL_ID;
    END
    ELSE IF (V_CLOSED_AT IS NOT NULL AND V_CLOSED_RESULT IN ('SUCCESS', 'CANCEL')) THEN
        UPDATE TDB_DEALS SET CLOSED_AT = NULL, CLOSED_RESULT = NULL,
                             UPDATED_AT = CURRENT_TIMESTAMP, UPDATED_BY = :A_USER_ID
        WHERE DEAL_ID = :A_DEAL_ID;
END ^

CREATE OR ALTER PROCEDURE SP_DEAL_SYNC_CONTACT (A_DEAL_ID BIGINT)
SQL SECURITY DEFINER
AS 
DECLARE V_CONTACTID INTEGER;
DECLARE V_NAME VARCHAR(120);
DECLARE V_PHONE VARCHAR(40);
DECLARE V_ADDRESS VARCHAR(500);
DECLARE N_NAME VARCHAR(255);
DECLARE N_PHONE VARCHAR(255);
DECLARE N_ADDRESS VARCHAR(255);
DECLARE V_TEXT VARCHAR(4000);
DECLARE V_UP VARCHAR(4000);
DECLARE V_POS INTEGER;
DECLARE V_END INTEGER;
DECLARE V_PART VARCHAR(255);
BEGIN
    SELECT CONTACTID, CONTACT_NAME, PHONE, DELIVERY_ADDRESS FROM TDB_DEALS
    WHERE DEAL_ID = :A_DEAL_ID
    INTO :V_CONTACTID, :V_NAME, :V_PHONE, :V_ADDRESS;
    IF (V_CONTACTID IS NULL) THEN EXIT;
    IF (V_PHONE IS NOT NULL AND V_ADDRESS IS NOT NULL AND V_CONTACTID <> 286) THEN EXIT;

    /* 1. checkout-ul din cos */
    SELECT FIRST 1 NULLIF(TRIM(t.FULLNAME), ''), NULLIF(TRIM(t.PHONES), ''), NULLIF(TRIM(t.ADDRESS), '')
    FROM TDB_DEAL_DOCS dd
    JOIN TWEB_TRANSACTION t ON t.DOCID = dd.DOCID
    WHERE dd.DEAL_ID = :A_DEAL_ID
    ORDER BY dd.DOCID
    INTO :N_NAME, :N_PHONE, :N_ADDRESS;

    /* 2. comentariile Web-Order-ului ("Cumpara acum") */
    IF (N_PHONE IS NULL OR N_NAME IS NULL) THEN
    BEGIN
        V_TEXT = NULL;
        SELECT FIRST 1 CAST(SUBSTRING(pr.COMMENTS FROM 1 FOR 4000) AS VARCHAR(4000))
        FROM TDB_DEAL_DOCS dd
        JOIN TDB_DOCS d ON d.DOCID = dd.DOCID AND d.DOCTYPEID = 134
        JOIN TDB_DOCS_PROPS pr ON pr.DOCID = dd.DOCID
        WHERE dd.DEAL_ID = :A_DEAL_ID
        ORDER BY dd.DOCID
        INTO :V_TEXT;

        IF (V_TEXT IS NOT NULL) THEN
        BEGIN
            V_UP = UPPER(V_TEXT);
            IF (N_PHONE IS NULL) THEN
            BEGIN
                V_POS = POSITION('TELEFON: ' IN V_UP);
                IF (V_POS > 0) THEN
                BEGIN
                    V_PART = SUBSTRING(V_TEXT FROM V_POS + 9 FOR 60);
                    V_END = POSITION(ASCII_CHAR(10) IN V_PART);
                    IF (V_END > 0) THEN V_PART = SUBSTRING(V_PART FROM 1 FOR V_END - 1);
                    V_PART = TRIM(REPLACE(V_PART, ASCII_CHAR(13), ''));
                    N_PHONE = NULLIF(V_PART, '');
                END
            END
            IF (N_NAME IS NULL) THEN
            BEGIN
                V_POS = POSITION('CLIENT: ' IN V_UP);
                IF (V_POS > 0) THEN
                BEGIN
                    V_PART = SUBSTRING(V_TEXT FROM V_POS + 8 FOR 120);
                    V_END = POSITION(ASCII_CHAR(10) IN V_PART);
                    IF (V_END > 0) THEN V_PART = SUBSTRING(V_PART FROM 1 FOR V_END - 1);
                    V_PART = TRIM(REPLACE(V_PART, ASCII_CHAR(13), ''));
                    N_NAME = NULLIF(V_PART, '');
                END
            END
        END
    END

    UPDATE TDB_DEALS
    SET PHONE = COALESCE(PHONE, LEFT(:N_PHONE, 40)),
        DELIVERY_ADDRESS = COALESCE(DELIVERY_ADDRESS, LEFT(:N_ADDRESS, 500)),
        CONTACT_NAME = CASE WHEN :N_NAME IS NOT NULL AND (CONTACT_NAME IS NULL OR CONTACTID = 286)
                            THEN LEFT(:N_NAME, 120) ELSE CONTACT_NAME END
    WHERE DEAL_ID = :A_DEAL_ID
      AND (   (PHONE IS NULL AND :N_PHONE IS NOT NULL)
           OR (DELIVERY_ADDRESS IS NULL AND :N_ADDRESS IS NOT NULL)
           OR (:N_NAME IS NOT NULL AND (CONTACT_NAME IS NULL OR CONTACTID = 286)
               AND CONTACT_NAME IS DISTINCT FROM LEFT(:N_NAME, 120)));
END ^

CREATE OR ALTER PROCEDURE SP_DEAL_WEB_ORDER_INFO_BACKFILL (A_FROM DATE)
RETURNS (ORDERS_DONE INTEGER)
SQL SECURITY DEFINER
AS 
DECLARE V_DOCID INTEGER;
DECLARE V_NAME VARCHAR(255);
DECLARE V_PHONE VARCHAR(255);
DECLARE V_ADDRESS VARCHAR(1000);
DECLARE V_CITYID INTEGER;
DECLARE V_DELIVERY_TYPE INTEGER;
DECLARE V_PAYMENT_TYPE INTEGER;
DECLARE V_PAY VARCHAR(60);
DECLARE V_TEXT VARCHAR(8000);
DECLARE V_FOUND SMALLINT;
DECLARE U_SOURCE VARCHAR(255);
DECLARE U_MEDIUM VARCHAR(255);
DECLARE U_CAMPAIGN VARCHAR(255);
DECLARE U_CONTENT VARCHAR(255);
DECLARE U_TERM VARCHAR(255);
BEGIN
  ORDERS_DONE = 0;
  FOR SELECT D.DOCID
      FROM TDB_DOCS D
      WHERE D.DOCTYPEID = 134 AND D.DATA >= :A_FROM
        AND EXISTS(SELECT 1 FROM TDB_DEAL_DOCS DD WHERE DD.DOCID = D.DOCID)
      INTO :V_DOCID
  DO
  BEGIN
    V_NAME = NULL; V_PHONE = NULL; V_ADDRESS = NULL; V_CITYID = NULL; V_PAY = NULL;
    U_SOURCE = NULL; U_MEDIUM = NULL; U_CAMPAIGN = NULL; U_CONTENT = NULL; U_TERM = NULL;

    /* cos / card online */
    V_FOUND = 0;
    FOR SELECT FIRST 1 FULLNAME, PHONES, ADDRESS, CITYID, DELIVERY_TYPE, PAYMENT_TYPE
        FROM TWEB_TRANSACTION WHERE DOCID = :V_DOCID
        INTO :V_NAME, :V_PHONE, :V_ADDRESS, :V_CITYID, :V_DELIVERY_TYPE, :V_PAYMENT_TYPE
    DO
    BEGIN
      V_FOUND = 1;
      IF (V_DELIVERY_TYPE = 1) THEN
      BEGIN
        V_ADDRESS = 'Ridicare din magazin';
        V_CITYID = NULL;
      END
      V_PAY = FN_DEAL_WEB_PAYMENT_METHOD('CART', :V_PAYMENT_TYPE);
    END

    /* "1 click": datele sint doar in comentariile documentului */
    IF (V_FOUND = 0) THEN
    BEGIN
      V_TEXT = NULL;
      SELECT FIRST 1 CAST(SUBSTRING(COMMENTS FROM 1 FOR 8000) AS VARCHAR(8000))
      FROM TDB_DOCS_PROPS WHERE DOCID = :V_DOCID
      INTO :V_TEXT;
      V_NAME = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Client: ');
      V_PHONE = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Telefon: ');
      V_ADDRESS = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'adresa de livrare: ');
      V_PAY = FN_DEAL_COMMENT_VALUE(:V_TEXT, 'Metoda de plata: ');
      IF (UPPER(V_PAY) = 'ACHITA LA PRIMIRE') THEN V_PAY = 'La primire';
      ELSE IF (UPPER(V_PAY) = 'CREDIT') THEN V_PAY = 'Credit';
      ELSE IF (UPPER(V_PAY) = 'MIA') THEN V_PAY = 'MIA QR';
    END

    /* UTM: atribuirea completa a site-ului, altfel ce a primit WEB_CREATE_TRANSACTION3 */
    SELECT FIRST 1
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_SOURCE, FIRST_UTM_SOURCE),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_MEDIUM, FIRST_UTM_MEDIUM),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_CAMPAIGN, FIRST_UTM_CAMPAIGN),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_CONTENT, FIRST_UTM_CONTENT),
        IIF(COALESCE(NULLIF(LAST_UTM_SOURCE, ''), NULLIF(LAST_UTM_MEDIUM, ''), NULLIF(LAST_UTM_CAMPAIGN, '')) IS NOT NULL, LAST_UTM_TERM, FIRST_UTM_TERM)
    FROM TWEB_ORDER_UTM WHERE DOCID = :V_DOCID
    INTO :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM;
    IF (COALESCE(NULLIF(U_SOURCE, ''), NULLIF(U_MEDIUM, ''), NULLIF(U_CAMPAIGN, ''),
                 NULLIF(U_CONTENT, ''), NULLIF(U_TERM, '')) IS NULL) THEN
      SELECT FIRST 1 UTM_SOURCE, UTM_MEDIUM, UTM_CAMPAIGN, UTM_CONTENT, UTM_TERM
      FROM TDB_DOCS_UTM WHERE DOCID = :V_DOCID
      INTO :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM;

    EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:V_DOCID, :V_NAME, :V_PHONE, :V_ADDRESS, :V_CITYID, :V_PAY,
      :U_SOURCE, :U_MEDIUM, :U_CAMPAIGN, :U_CONTENT, :U_TERM, 0);
    ORDERS_DONE = ORDERS_DONE + 1;
  END
  SUSPEND;
END ^

CREATE OR ALTER PROCEDURE SP_TELEGRAM_BUILD_TEXT (SOURCE_TABLE INTEGER,
SOURCE_ID INTEGER)
RETURNS (MSG_TEXT VARCHAR(4096) CHARACTER SET UTF8,
PARSE_MODE VARCHAR(10) CHARACTER SET UTF8)
SQL SECURITY DEFINER
AS 
DECLARE NL CHAR(1);
DECLARE V_DOCTYPE INTEGER;
DECLARE V_SUMA NUMERIC(18,4);
DECLARE V_CUR VARCHAR(64);
DECLARE V_FIRMA VARCHAR(1024);
DECLARE V_DELETED TIMESTAMP;
DECLARE V_NAME VARCHAR(1024);
DECLARE V_PHONE VARCHAR(1024);
DECLARE V_PAY VARCHAR(1024);
DECLARE V_ADDR VARCHAR(1024);
DECLARE V_UTM VARCHAR(1024);
DECLARE V_CREDIT NUMERIC(18,4);
DECLARE V_MONTHS INTEGER;
DECLARE V_AVANS NUMERIC(18,4);
DECLARE V_LUNAR NUMERIC(18,4);
DECLARE V_TITLE VARCHAR(1024);
DECLARE V_QTY NUMERIC(18,4);
DECLARE V_LSUMA NUMERIC(18,4);
DECLARE V_N INTEGER = 0;
DECLARE V_TOTAL_LINES INTEGER;
BEGIN
  NL = ASCII_CHAR(10);
  MSG_TEXT = NULL;
  PARSE_MODE = 'HTML';

  IF (SOURCE_TABLE IN (134, 1791)) THEN
  BEGIN
    SELECT D.DOCTYPEID, D.SUMA, C.TITLE, F.NAME, D.DELETED_DATE
      FROM TDB_DOCS D
      LEFT JOIN TS_CURRENCY C ON C.CURRENCYID = D.CURRENCYID
      LEFT JOIN TS_CUSTOMER F ON F.CUSTOMERID = D.DT
     WHERE D.DOCID = :SOURCE_ID
      INTO :V_DOCTYPE, :V_SUMA, :V_CUR, :V_FIRMA, :V_DELETED;

    IF (V_DOCTYPE IS NULL OR V_DELETED IS NOT NULL) THEN
    BEGIN
      SUSPEND;
      EXIT;
    END

    /* contactul: deal-ul documentului (sincronizat din cos / "Cumpara acum") */
    SELECT FIRST 1 NULLIF(TRIM(DL.CONTACT_NAME), ''), NULLIF(TRIM(DL.PHONE), ''),
           NULLIF(TRIM(DL.PAYMENT_METHOD), ''), NULLIF(TRIM(DL.DELIVERY_ADDRESS), ''),
           NULLIF(TRIM(DL.UTM_SOURCE), '') || COALESCE(' / ' || NULLIF(TRIM(DL.UTM_CAMPAIGN), ''), '')
      FROM TDB_DEAL_DOCS DD
      JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
     WHERE DD.DOCID = :SOURCE_ID
     ORDER BY DD.DEAL_ID
      INTO :V_NAME, :V_PHONE, :V_PAY, :V_ADDR, :V_UTM;

    IF (V_DOCTYPE = 134) THEN
    BEGIN
      SELECT FIRST 1 COALESCE(NULLIF(TRIM(T.FULLNAME), ''), :V_NAME),
             COALESCE(NULLIF(TRIM(T.PHONES), ''), :V_PHONE)
        FROM RDB$DATABASE
        LEFT JOIN TWEB_TRANSACTION T ON T.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE;

      /* comanda pe credit cu dosar (FIN_AS_WEBORDER = 1): clientul si creditul din dosar */
      SELECT FIRST 1 COALESCE(:V_NAME, NULLIF(TRIM(CF.NPP), '')),
             COALESCE(:V_PHONE, NULLIF(TRIM(CF.CONTACT_TELEFON), '')),
             CF.CREDIT_SUMA, CF.CREDIT_PERIOADA, CF.AVANS, CF.PLATA_LUNARA
        FROM TWEB_CERERE_FINANTARE CF
       WHERE CF.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE, :V_CREDIT, :V_MONTHS, :V_AVANS, :V_LUNAR;

      IF (V_CREDIT IS NOT NULL) THEN
        MSG_TEXT = _UTF8 X'F09F92B3' || ' <b>Comanda pe credit de pe site #' || SOURCE_ID || '</b>';
      ELSE
        MSG_TEXT = _UTF8 X'F09F9B92' || ' <b>Comanda noua de pe site #' || SOURCE_ID || '</b>';
    END
    ELSE
    BEGIN
      SELECT FIRST 1 COALESCE(NULLIF(TRIM(CF.NPP), ''), :V_NAME),
             COALESCE(NULLIF(TRIM(CF.CONTACT_TELEFON), ''), :V_PHONE),
             CF.CREDIT_SUMA, CF.CREDIT_PERIOADA, CF.AVANS, CF.PLATA_LUNARA
        FROM RDB$DATABASE
        LEFT JOIN TWEB_CERERE_FINANTARE CF ON CF.DOCID = :SOURCE_ID
        INTO :V_NAME, :V_PHONE, :V_CREDIT, :V_MONTHS, :V_AVANS, :V_LUNAR;

      MSG_TEXT = _UTF8 X'F09F92B3' || ' <b>Cerere de finantare #' || SOURCE_ID || '</b>';
    END

    IF (V_FIRMA IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Firma: ' || FN_TELEGRAM_HTML(V_FIRMA);
    IF (V_NAME IS NOT NULL OR V_PHONE IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Client: <b>' || FN_TELEGRAM_HTML(COALESCE(V_NAME, '-')) || '</b>'
                 || COALESCE(', <code>' || FN_TELEGRAM_HTML(V_PHONE) || '</code>', '');
    IF (V_DOCTYPE = 134 AND V_PAY IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Plata: ' || FN_TELEGRAM_HTML(V_PAY);
    IF (V_DOCTYPE = 134 AND V_ADDR IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Adresa: ' || FN_TELEGRAM_HTML(V_ADDR);
    IF (V_CREDIT IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Credit: ' || FN_TELEGRAM_MONEY(V_CREDIT) || ' ' || COALESCE(V_CUR, '')
                 || COALESCE(', ' || V_MONTHS || ' luni', '')
                 || IIF(COALESCE(V_AVANS, 0) <> 0, ', avans ' || FN_TELEGRAM_MONEY(V_AVANS), '')
                 || IIF(COALESCE(V_LUNAR, 0) <> 0, ', lunar ' || FN_TELEGRAM_MONEY(V_LUNAR), '');

    SELECT COUNT(*) FROM TDB_JURNAL J WHERE J.DOCID = :SOURCE_ID INTO :V_TOTAL_LINES;
    IF (V_TOTAL_LINES > 0) THEN
    BEGIN
      MSG_TEXT = MSG_TEXT || NL;
      FOR SELECT FIRST 10 G.TITLE, J.QTY, J.SUMA
            FROM TDB_JURNAL J
            JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
           WHERE J.DOCID = :SOURCE_ID
           ORDER BY J.SUMA DESC
          INTO :V_TITLE, :V_QTY, :V_LSUMA
      DO
      BEGIN
        V_N = V_N + 1;
        MSG_TEXT = MSG_TEXT || NL || _UTF8 X'E280A2' || ' ' || FN_TELEGRAM_HTML(LEFT(TRIM(V_TITLE), 150))
                   || IIF(V_QTY <> 1, ' x ' || FN_TELEGRAM_MONEY(V_QTY), '')
                   || ' - ' || FN_TELEGRAM_MONEY(V_LSUMA);
      END
      IF (V_TOTAL_LINES > V_N) THEN
        MSG_TEXT = MSG_TEXT || NL || '... inca ' || (V_TOTAL_LINES - V_N) || ' pozitii';
    END

    MSG_TEXT = MSG_TEXT || NL || NL || 'Total: <b>' || FN_TELEGRAM_MONEY(V_SUMA) || ' ' || COALESCE(V_CUR, '') || '</b>';
    IF (V_UTM IS NOT NULL) THEN
      MSG_TEXT = MSG_TEXT || NL || 'Sursa: ' || FN_TELEGRAM_HTML(V_UTM);
  END

  SUSPEND;
END ^

SET TERM ; ^

DROP PROCEDURE SP_WEBORDER_TO_OFFER;

COMMIT;

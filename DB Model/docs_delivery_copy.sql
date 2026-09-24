/*
  Copierea datelor de livrare (TDB_DOCS_DELIVERY) in documentele create din
  alt document: Oferta -> Proforma / Rezerva / Vindut prin partener, si mai
  departe pe lant (Proforma -> Rezerva).

  Problema (24 sep 2026):
    - SP_CREATE_PROFORMA_INVOICE (101) si SP_CREATE_VINZARE_PARTENER (3425)
      nu copiau livrarea deloc;
    - SP_CREATE_RASHOD (107) o copia doar din parintele direct, deci
      Oferta -> Proforma -> Rezerva pierdea livrarea la proforma.

  Solutia:
    SP_DOC_COPY_DELIVERY(A_SRC_DOCID, A_NEW_DOCID) - cauta, urcand pe
    PARENTDOCID de la A_SRC_DOCID (max 10 niveluri), primul document care
    are rand in TDB_DOCS_DELIVERY si il copiaza in A_NEW_DOCID. Nu suprascrie:
    daca documentul nou are deja livrare, nu face nimic.
    Cele 3 proceduri de creare o apeleaza la final.

  Corpurile procedurilor sunt copia EXACTA a celor de pe SW din 24 sep 2026
  (RDB$PROCEDURE_SOURCE), cu singura modificare marcata "24.09.2026".
  Daca procedurile se schimba pe SW inainte de rulare - reextrage-le.

  Scriptul e repetabil. La final: completarea retroactiva (doar documentele
  101/107/3425 din 2026 fara livrare; la 24 sep erau 6).
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_DOC_COPY_DELIVERY (
    A_SRC_DOCID INTEGER,
    A_NEW_DOCID INTEGER)
AS
DECLARE V_CUR INTEGER;
DECLARE V_PARENT INTEGER;
DECLARE V_LVL INTEGER;
BEGIN
    IF (A_SRC_DOCID IS NULL OR A_NEW_DOCID IS NULL OR A_SRC_DOCID = A_NEW_DOCID) THEN EXIT;
    IF (EXISTS(SELECT 1 FROM TDB_DOCS_DELIVERY WHERE DOCID = :A_NEW_DOCID)) THEN EXIT;

    V_CUR = A_SRC_DOCID;
    V_LVL = 0;
    WHILE (V_CUR IS NOT NULL AND V_LVL < 10) DO
    BEGIN
        IF (EXISTS(SELECT 1 FROM TDB_DOCS_DELIVERY WHERE DOCID = :V_CUR)) THEN
        BEGIN
            INSERT INTO TDB_DOCS_DELIVERY (DOCID, COURIERID, DELIVERY_ADDRESS,
                                           DELIVERY_TIME, DELIVERY_DATE, FLG_CASHONDELIVERY,
                                           FLG_INVOICE_ONDELIVERY, TRANSMIS_CURIER, AWB,
                                           FLAGS, DRIVERID, CITYID, DISTRICTID, COMMENTS,
                                           STATEID, PHONE_NUMBER, RAMBURS)
            SELECT :A_NEW_DOCID, COURIERID, DELIVERY_ADDRESS, DELIVERY_TIME, DELIVERY_DATE,
                   FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY, TRANSMIS_CURIER, AWB, FLAGS,
                   DRIVERID, CITYID, DISTRICTID, COMMENTS, STATEID, PHONE_NUMBER, RAMBURS
            FROM TDB_DOCS_DELIVERY
            WHERE DOCID = :V_CUR;
            EXIT;
        END

        /* "fara parinte" = PARENTDOCID catre un DOCID inexistent -> V_PARENT ramane NULL */
        V_PARENT = NULL;
        SELECT PARENTDOCID FROM TDB_DOCS WHERE DOCID = :V_CUR INTO :V_PARENT;
        IF (V_PARENT = V_CUR OR V_PARENT = A_NEW_DOCID) THEN EXIT;
        V_CUR = V_PARENT;
        V_LVL = V_LVL + 1;
    END
END^

/* ------------------------------------------------------------------------- */
/* 107 Rezerva / Vanzare                                                      */
/* ------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_CREATE_RASHOD (
    OLD_DOCID INTEGER)
RETURNS (
    RASHDOCID INTEGER)
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

END^

/* ------------------------------------------------------------------------- */
/* 101 Proforma                                                               */
/* ------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_CREATE_PROFORMA_INVOICE (
    DOCID INTEGER)
AS
declare variable DOCTYPEID integer;
declare variable NEWDOCID  integer;
declare variable DT        DM_INTEGER;
declare variable CT        DM_INTEGER;
declare variable COMMENTS  type of column TDB_DOCS_PROPS.COMMENTS;
declare variable INBAZA    type of column TDB_DOCS_PROPS.INBAZA;
begin
  if (exists(select CURRENCYID
             from TDB_DOCS
             where DOCID = :DOCID and
                   CURRENCYID = 498)) then begin
    rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);
    DOCTYPEID = 101;/*  SCHET NA OPLATU */
    NEWDOCID = next value for SQ_TDB_DOCS_DOCID;

    /* 1. cream document  */
    insert into TDB_DOCS (DOCID, data, DT, CT, DTDEP, CTDEP, DTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE, CREATED_DATE, CREATED_BY,
                          DELETED_DATE, DELETED_BY, PARENTDOCID, ACC$MASK, DOCTYPEID, FLAGS, RATEUSD, CONTRACTID, responsible_userid)
    select :NEWDOCID, current_timestamp, DT, CT, DTDEP, CTDEP, DTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE, current_timestamp,
           CREATED_BY, DELETED_DATE, DELETED_BY, DOCID, ACC$MASK, :DOCTYPEID, SET_FLG_VALUE(0, 1, 1) /* FLG_ACNT=1 */ , RATEUSD,
           CONTRACTID, iif(coalesce(responsible_userid, 0) = 0, rdb$get_context('USER_SESSION', 'UserID'), responsible_userid)
    from TDB_DOCS
    where DOCID = :DOCID;

    /* aducem produsele */

    insert into TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST,
                            FLAGS)
    select :NEWDOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST, SET_FLG_VALUE(FLAGS, 1, 1) /* 1 - FLG_ACNT */
    from TDB_JURNAL
    where DOCID = :DOCID;

    --    select discount_sum from TDB_DOCS_ADDONS where docid=:docid

    /* punem conturile de decontare implicite a firmelor */
    select DT, CT
    from TDB_DOCS
    where DOCID = :DOCID
    into :DT, :CT;

    insert into TDB_DOCS_RECHIZITE (DOCID, DT_CD, CT_CD)
    values (:NEWDOCID, (select first 1 ACCOUNTNUMBER
                        from TS_CUST_ACCOUNTS
                        where DEFAULT_ACCOUNT = 1 and
                              CUSTOMERID = :DT), (select first 1 ACCOUNTNUMBER
                                                  from TS_CUST_ACCOUNTS
                                                  where DEFAULT_ACCOUNT = 1 and
                                                        CUSTOMERID = :CT));

    --  /* aducem comentariile din documentul initial */
    --  SELECT INBAZA, COMMENTS
    --  FROM TDB_DOCS_PROPS
    --  WHERE DOCID = :DOCID
    --  INTO :INBAZA, :COMMENTS;

    insert into TDB_DOCS_PROPS (DOCID, INBAZA, COMMENTS)
    select :NEWDOCID, INBAZA, COMMENTS
    from TDB_DOCS_PROPS
    where DOCID = :DOCID;

    /* 24.09.2026 - livrarea din documentul initial (sau de mai sus din lant) */
    execute procedure SP_DOC_COPY_DELIVERY(:DOCID, :NEWDOCID);

    update TDB_DOCS
    set STATEID = 1
    where DOCID = :DOCID;

  end
  else exception ERR_CURRENCY_MUSTBE_MDL;
end^

/* ------------------------------------------------------------------------- */
/* 3425 Vindut prin partener                                                  */
/* ------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_CREATE_VINZARE_PARTENER (
    OLD_DOCID INTEGER)
RETURNS (
    RASHDOCID INTEGER)
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
--DECLARE VARIABLE COMMENTS TYPE OF COLUMN TDB_DOCS_PROPS.COMMENTS;
--DECLARE VARIABLE INBAZA TYPE OF COLUMN TDB_DOCS_PROPS.INBAZA;
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

  /* daca document cu acest cod de document exista in doctypeid=129 exception */
  IF (EXISTS(SELECT DOCID
             FROM TDB_DOCS
             WHERE DOCTYPEID = 3425 AND
                   TDB_DOCS.PARENTDOCID = :old_docid)) THEN
  BEGIN
    EXCEPTION ERR_DOC_EXISTS;
  END

--  /* 09.01.2012 */
--  /* daca FLG_ACNT=1, si suma documentului este mai mare dekit suma din Scet Factura generata din acest document */
--  /* atunci eroare */
--  SELECT DOCID, SUMA
--  FROM TDB_DOCS
--  WHERE (PARENTDOCID=:old_docid) AND (DOCTYPEID=112)
--  INTO :scetDOCID, :scetSUMA;
--
--  IF (scetDOCID IS NOT NULL AND docSUMA>scetSUMA) THEN EXCEPTION ERR_RASHOD_ERROR '<MSG>Suma documentului este mai mare decit suma din factura!</MSG>';



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
         CREATED_BY, DELETED_DATE, DELETED_BY, :old_docid, ACC$MASK, 3425,
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

--  /* set FLG_INVOICE=7 */
--  UPDATE TDB_DOCS
--  SET
--    stateid = 2, /* Confirmarea clientului */
--    FLAGS = SET_FLG_VALUE(FLAGS, 7, 1)
--  WHERE DOCID = :old_docid;

  /* inchidem documentul parinte */
  select doctypeid from tdb_docs where docid=:old_docid into :parent_doctypeid;
  if (:parent_doctypeid in (134, 115)) then
      update tdb_docs set flags=set_FLG_VALUE(flags, 10,1) where docid=:old_docid;

  /* aducem comentariile din documentul initial */
  INSERT INTO TDB_DOCS_PROPS (DOCID,INBAZA,COMMENTS)
  SELECT :NEW_DOCID, INBAZA, COMMENTS FROM TDB_DOCS_PROPS WHERE DOCID = :old_docid;

  /* 24.09.2026 - livrarea din documentul initial (sau de mai sus din lant) */
  EXECUTE PROCEDURE SP_DOC_COPY_DELIVERY(:old_docid, :NEW_DOCID);

  /* create event Rashod=1 */
  EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:DT, 1, '', :NEW_DOCID, :USERID);

  RDB$SET_CONTEXT('USER_SESSION', 'RequireModifyDOC', 0);


  SUSPEND;

END^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE SP_DOC_COPY_DELIVERY TO PROCEDURE SP_CREATE_RASHOD;
GRANT EXECUTE ON PROCEDURE SP_DOC_COPY_DELIVERY TO PROCEDURE SP_CREATE_PROFORMA_INVOICE;
GRANT EXECUTE ON PROCEDURE SP_DOC_COPY_DELIVERY TO PROCEDURE SP_CREATE_VINZARE_PARTENER;
GRANT SELECT, INSERT ON TDB_DOCS_DELIVERY TO PROCEDURE SP_DOC_COPY_DELIVERY;
GRANT SELECT ON TDB_DOCS TO PROCEDURE SP_DOC_COPY_DELIVERY;

COMMIT;

/* ------------------------------------------------------------------------- */
/* Completare retroactiva: documentele 101/107/3425 din 2026 fara livrare,    */
/* al caror lant are livrare. Nu suprascrie nimic.                            */
/* ------------------------------------------------------------------------- */
SET TERM ^ ;
EXECUTE BLOCK RETURNS (N_COPIED INTEGER)
AS
DECLARE V_DOCID INTEGER;
DECLARE V_PARENT INTEGER;
BEGIN
    N_COPIED = 0;
    FOR SELECT d.DOCID, d.PARENTDOCID FROM TDB_DOCS d
        WHERE d.DOCTYPEID IN (101, 107, 3425)
          AND d.DELETED_DATE IS NULL
          AND d.CREATED_DATE >= '2026-01-01'
          AND NOT EXISTS (SELECT 1 FROM TDB_DOCS_DELIVERY x WHERE x.DOCID = d.DOCID)
        INTO :V_DOCID, :V_PARENT
    DO
    BEGIN
        EXECUTE PROCEDURE SP_DOC_COPY_DELIVERY(:V_PARENT, :V_DOCID);
        IF (EXISTS(SELECT 1 FROM TDB_DOCS_DELIVERY WHERE DOCID = :V_DOCID)) THEN
            N_COPIED = N_COPIED + 1;
    END
    SUSPEND;
END^
SET TERM ; ^

COMMIT;

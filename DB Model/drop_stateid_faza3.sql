/* ============================================================================
   Eliminarea TDB_DOCS.STATEID - faza 3 (DISTRUCTIV): coloana iese din baza
   NEURON Grup SRL, 28 octombrie 2026
   Plan: Documents/plan-eliminare-stateid-2026-09-18.md (faza 3)
   Generat din sursele de pe SW (isql -x, 28.10.2026) de gen_drop_stateid.py;
   fisier UTF-8 (SP_CREATE_TENDER are text chirilic) -> rulati cu  isql -ch UTF8.

   CONDITII, in aceasta ordine:
     1. backup complet al bazei SW (gbak / nbackup) facut de DBA;
     2. NICIUN SWN.exe din versiunile de dinainte de 18.09.2026 nu mai ruleaza:
        exe-urile vechi inca scriu STATEID prin VW_TDB_DOCS si ar primi eroare;
     3. operatorii deconectati (se modifica VW_TDB_DOCS si triggerele TDB_DOCS).

   Scriptul:
     0. arhiveaza in TARC_DOCS_STATES starile ne-implicite puse dupa 18.09.2026;
     1. rescrie procedurile care puneau starea (1 / 2 / 8 / 37 / 38) fara STATEID;
     2. TDB_DOCS_AU_DEAL fara copierea starii in deal, TDB_DOCS_AU0 fara STATEID in
        jurnal, TRG_TDB_DOCS_BI fara starea implicita, VW_TDB_DOCS_BI / _BU fara STATEID;
     3. sterge procedurile de tranzitie SP_DEAL_MIGRATE_DOC_STATES / SP_DEAL_APPLY_DOC_STATE;
     4. VW_TDB_DOCS fara STATEID / STATE_NAME;
     5. sterge FK_TDB_DOCS_11 (spre TS_DOCTYPES_STATES) si coloana TDB_DOCS.STATEID.
   Raman: TS_DOCTYPES_STATES (dictionar / arhiva), GET_DEFAULT_STATE, TLOG_DOCS_STATES (gol).
   Re-rulabil: pasii 3 si 5 verifica intai existenta obiectelor.
   Revenire: DB Model/drop_stateid_faza3_rollback.sql (starile vin din TARC_DOCS_STATES;
   starea implicita 8 nu era arhivata si ramane NULL).
   ============================================================================ */

SET TERM ^ ;

/* --- 0. Arhiva starilor puse dupa 18.09.2026 -------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
               WHERE RDB$RELATION_NAME = 'TDB_DOCS' AND RDB$FIELD_NAME = 'STATEID')) THEN
        EXECUTE STATEMENT
            'INSERT INTO TARC_DOCS_STATES (DOCID, DOCTYPEID, STATEID, TITLE)
             SELECT d.DOCID, d.DOCTYPEID, d.STATEID, s.TITLE
             FROM TDB_DOCS d
             LEFT JOIN TS_DOCTYPES_STATES s ON s.STATEID = d.STATEID
             WHERE d.STATEID IS NOT NULL AND d.STATEID <> 8
               AND NOT EXISTS(SELECT 1 FROM TARC_DOCS_STATES a WHERE a.DOCID = d.DOCID)';
END^

COMMIT^

/* --- 1. Proceduri fara STATEID ---------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_CANCEL_REZERVATION_GOODS (DOCID DM_INTEGER,
GOODSID DM_INTEGER,
QTY DM_QTY = 0)
AS 
declare newdocid dm_integer;
begin
    RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

    if (not exists(select * from tdb_docs where parentdocid = :docid and doctypeid = 3297)) then
    begin
        :newdocid = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;
        insert into TDB_DOCS (DOCID, data, DT, CT, DTDEP, CTDEP, DTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE,
                              PARENTDOCID, ACC$MASK, DOCTYPEID, FLAGS, RATEUSD, SC2, CONTRACTID, CTSC, TIPOPERID,
                              created_date)
        select :NEWDOCID, current_timestamp, DT, CT, DTDEP, CTDEP, DTSC, abs(SUMA), abs(VAT), CURRENCYID, DISCOUNT, RATE,
                :DOCID, 0, 3297, FLAGS, RATEUSD, SC2, CONTRACTID, CTSC, TIPOPERID, current_timestamp from tdb_docs where docid = :docid;
    end
    else
    begin
        select docid from tdb_docs where parentdocid = :docid and doctypeid = 3297 into :newdocid;
    end
        /*  */
      if (not EXISTS(select * from tdb_jurnal where docid = :newdocid and goodsid = :goodsid)) then
      begin
        insert into TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST, FLAGS,
                                PRICE_COLUMN, DISCOUNT_P, DISCOUNT_SUMA, SUMA_SERVICII)
        select :NEWDOCID, j.DTDEP, j.CTDEP, j.GOODSCOMPLECT_ID, j.GOODSID, j.UMID, j.qty, abs(j.PRICE), abs(j.SUMA), abs(j.SUMAVAT), j.WARRANTY, j.STOCK_QTY, j.COST, j.FLAGS, j.PRICE_COLUMN,
                j.DISCOUNT_P, j.DISCOUNT_SUMA, j.SUMA_SERVICII
        from TDB_JURNAL J
        join ts_goods g on g.goodsid = j.goodsid and g.goods_type_id in (4201, 4203)
        where j.docid = :docid and j.goodsid = :goodsid;
      end

end ^

COMMIT^

CREATE OR ALTER PROCEDURE SP_CLOSE_WEBZAKAZ (DOCID DM_INTEGER_NN,
USERID DM_INTEGER)
AS 
declare DTSC DM_INTEGER;
declare CURRENT_USER_ID DM_INTEGER;
begin
  /* Setam valoarea FLG_CLOSED=10 in 1 */
  /* avem nevoie de modificare in lant a documentelor posibil inchise */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  select SYSSID
  from TS_SYSS
  where PARENTID = 26 and
        VALUE_INT = :USERID
  into :DTSC;

  DTSC = coalesce(:DTSC, 5137);
  /* cine inchide: sesiunea WMS, altfel parametrul */
  CURRENT_USER_ID = coalesce(rdb$get_context('USER_SESSION', 'UserID'), :USERID);

  update TDB_DOCS D
  set FLAGS = SET_FLG_VALUE(FLAGS, 10, 1),
      D.RESPONSIBLE_USERID = iif(coalesce(D.RESPONSIBLE_USERID, -1) <= 0, :CURRENT_USER_ID, D.RESPONSIBLE_USERID)
  where DOCID = :DOCID;
end ^

COMMIT^

CREATE OR ALTER PROCEDURE SP_CREATE_CONFIGURATOR (SOURCE_DOCID DM_INTEGER_NN,
CUSTOM_USERID DM_INTEGER,
CUSTOM_COMMENTS DM_BLOBTEXT)
RETURNS (CONFIGDOCID DM_INTEGER)
AS 
declare variable NEW_DOCTYPEID DM_INTEGER;
declare variable sourceDoc_DocTypeID DM_INTEGER;
declare variable tmpCurrentUserID DM_INTEGER;
declare variable tmpCurrentUserName type of column TS_USERS.FULL_NAME;
declare flags dm_integer;
declare dtsc dm_integer;
BEGIN
     CONFIGDOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;
     NEW_DOCTYPEID = 115; /* configurator */

     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

     select syssid from ts_syss where parentid = 26 and value_int = RDB$GET_CONTEXT('USER_SESSION', 'UserID') into :dtsc;

     :dtsc = coalesce(:dtsc, 5137);

     /* get doc props */

     SELECT DOCTYPEID, flags
     FROM TDB_DOCS
     WHERE DOCID=:SOURCE_DOCID
     INTO :sourceDoc_DocTypeID, :flags;

     :flags = set_flg_value(:flags, 10, 0);

     /* copy Doc  */
     INSERT INTO TDB_DOCS (DOCID,DATA,DT,CT,DTDEP,CTDEP,DTSC, ctsc, SUMA, VAT,CURRENCYID,DISCOUNT,RATE,RATEUSD,
                           CREATED_BY,PARENTDOCID,ACC$MASK,DOCTYPEID,FLAGS,SC2, responsible_userid)
     SELECT :CONFIGDOCID,CURRENT_TIMESTAMP,DT,CT,DTDEP,CTDEP,DTSC, ctsc, SUMA, VAT,CURRENCYID,DISCOUNT,RATE,RATEUSD,
            CREATED_BY,:SOURCE_DOCID,ACC$MASK,:NEW_DOCTYPEID, :flags, SC2, responsible_userid
     FROM TDB_DOCS
     WHERE DOCID=:SOURCE_DOCID;

     /* comentariile vechi */
     insert into TDB_DOCS_PROPS (DOCID, INBAZA, COMMENTS)
     select :CONFIGDOCID, INBAZA, COMMENTS
     from TDB_DOCS_PROPS
     where docid=:source_docid;

     /* copy Jurnal */
     INSERT INTO TDB_JURNAL (DOCID,DTDEP,CTDEP,GOODSCOMPLECT_ID,GOODSID,UMID,QTY,PRICE,SUMA,SUMAVAT,
                             WARRANTY,STOCK_QTY,COST,FLAGS)
     SELECT :CONFIGDOCID,DTDEP,-1,GOODSCOMPLECT_ID,GOODSID,UMID,QTY,PRICE,SUMA,SUMAVAT,
            WARRANTY,STOCK_QTY,COST,1
     FROM TDB_JURNAL
     WHERE (DOCID=:SOURCE_DOCID);

     /* doc comments */
     IF (CUSTOM_COMMENTS IS NOT NULL AND CHAR_LENGTH(TRIM(CUSTOM_COMMENTS))>0) THEN
     BEGIN
          tmpCurrentUserID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
          SELECT FULL_NAME FROM TS_USERS WHERE USERID = :tmpCurrentUserID INTO :tmpCurrentUserName;
          EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:CONFIGDOCID, :tmpCurrentUserName, :CUSTOM_COMMENTS);
     END

     /* Config from Cerere de finantare */
     IF (sourceDoc_DocTypeID=1791) THEN
     BEGIN
          /* close document */
          /* avem nevoie de modificare in lant a documentelor posibil inchise */
          RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

          UPDATE TDB_DOCS d
          SET FLAGS = SET_FLG_VALUE(FLAGS, 10, 1)
          WHERE DOCID=:SOURCE_DOCID;
     END

     /* return */
     SUSPEND;
END ^

COMMIT^

CREATE OR ALTER PROCEDURE SP_CREATE_PKO (DOCID DM_INTEGER,
CURRENCYID DM_INTEGER,
FLG_ACNT DM_BOOLEAN,
RATE DM_PRICE,
SUMA DM_PRICE,
FLGCASHRECEIPTANALITICS DM_INTEGER)
AS 
declare variable DOCTYPEID DM_INTEGER;
declare variable tmpFLAGS DM_INTEGER;
BEGIN
     DOCTYPEID = 116; /* PKO */
     tmpFLAGS = 0;
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS, 1, :FLG_ACNT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS, 10, 1); /* FLG_CLOSED */

     INSERT INTO TDB_DOCS
           (DT, CT, DTDEP, CTDEP, DTSC, SUMA, CURRENCYID, RATE, PARENTDOCID, DOCTYPEID, FLAGS, RATEUSD)
     SELECT DT, CT, DTDEP, CTDEP, DTSC, :SUMA, :CURRENCYID, :RATE, DOCID, :DOCTYPEID, :tmpFLAGS, RATEUSD
    FROM TDB_DOCS
    WHERE DOCID = :DOCID;

END ^

COMMIT^

CREATE OR ALTER PROCEDURE SP_CREATE_PROFORMA_INVOICE (DOCID INTEGER)
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

  end
  else exception ERR_CURRENCY_MUSTBE_MDL;
end ^

COMMIT^

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
declare variable parent_created_by dm_integer;
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
    FLAGS = SET_FLG_VALUE(FLAGS, 7, 1)
  WHERE DOCID = :old_docid;

  /* inchidem documentul parinte */
  /* 23.10.2026: si comanda web mutata in Oferte (115 cu CREATED_BY = 9) se inchide la vinzare,
     ca Web-Order-ul; ofertele manuale ramin deschise, ca pina acum */
  select doctypeid, created_by from tdb_docs where docid=:old_docid into :parent_doctypeid, :parent_created_by;
  if ((:parent_doctypeid = 134) or (:parent_doctypeid = 115 and :parent_created_by = 9)) then
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

COMMIT^

CREATE OR ALTER PROCEDURE SP_CREATE_TENDER (DOCID INTEGER)
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
    DOCTYPEID = 3310;/*  ТЕНДЕР */
    NEWDOCID = next value for SQ_TDB_DOCS_DOCID;

    /* 1. cream document  */
    insert into TDB_DOCS (DOCID, data, DT, CT, DTDEP, CTDEP, DTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE, CREATED_DATE, CREATED_BY,
                          DELETED_DATE, DELETED_BY, PARENTDOCID, ACC$MASK, DOCTYPEID, FLAGS, RATEUSD, CONTRACTID)
    select :NEWDOCID, current_timestamp, DT, CT, DTDEP, CTDEP, DTSC, SUMA, VAT, CURRENCYID, DISCOUNT, RATE, current_timestamp,
           CREATED_BY, DELETED_DATE, DELETED_BY, DOCID, ACC$MASK, :DOCTYPEID, SET_FLG_VALUE(0, 1, 1) /* FLG_ACNT=1 */ , RATEUSD,
           CONTRACTID
    from TDB_DOCS
    where DOCID = :DOCID;

--    /* aducem produsele */
--
--    insert into TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST,
--                            FLAGS)
--    select :NEWDOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST, SET_FLG_VALUE(FLAGS, 1, 1) /* 1 - FLG_ACNT */
--    from TDB_JURNAL
--    where DOCID = :DOCID;

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

  end
  else exception ERR_CURRENCY_MUSTBE_MDL;
end ^

COMMIT^

CREATE OR ALTER PROCEDURE SP_WEBORDER_TO_OFFER (A_DOCID DM_INTEGER_NN,
A_USERID DM_INTEGER = NULL,
A_COMMENTS DM_BLOBTEXT = NULL)
RETURNS (DOCID DM_INTEGER)
AS 
DECLARE VARIABLE V_TYPE DM_INTEGER;
DECLARE VARIABLE V_DELETED TIMESTAMP;
DECLARE VARIABLE V_FLAGS DM_INTEGER;
DECLARE VARIABLE V_USER DM_INTEGER;
DECLARE VARIABLE V_USERNAME TYPE OF COLUMN TS_USERS.FULL_NAME;
BEGIN
    DOCID = NULL;
    SELECT DOCTYPEID, DELETED_DATE, FLAGS
    FROM TDB_DOCS WHERE DOCID = :A_DOCID
    INTO :V_TYPE, :V_DELETED, :V_FLAGS;

    IF (V_TYPE IS NULL) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Documentul ' || :A_DOCID || ' nu exista.';
    IF (V_TYPE = 115) THEN
    BEGIN
        DOCID = A_DOCID;    /* deja mutat (dublu click / al doilea operator) */
        SUSPEND;
        EXIT;
    END
    IF (V_TYPE <> 134) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Documentul ' || :A_DOCID || ' nu este Web-Order (tip ' || :V_TYPE || ').';
    IF (V_DELETED IS NOT NULL) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Comanda ' || :A_DOCID || ' este stearsa.';
    IF (COALESCE(GET_FLG_VALUE(V_FLAGS, 10), 0) = 1) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Comanda ' || :A_DOCID || ' este inchisa (prelucrata sau refuzata) si nu se muta in Oferte. Deschideti-o intii (Shift+F9).';

    V_USER = COALESCE(:A_USERID, RDB$GET_CONTEXT('USER_SESSION', 'UserID'));

    RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);
    RDB$SET_CONTEXT('USER_TRANSACTION', 'WEBORDER_CONVERT', 1);
    UPDATE TDB_DOCS D
       SET D.DOCTYPEID = 115,
           D.DATA = CURRENT_TIMESTAMP,
           D.RESPONSIBLE_USERID = IIF(COALESCE(D.RESPONSIBLE_USERID, -1) <= 0, :V_USER, D.RESPONSIBLE_USERID)
     WHERE D.DOCID = :A_DOCID;
    RDB$SET_CONTEXT('USER_TRANSACTION', 'WEBORDER_CONVERT', NULL);

    IF (A_COMMENTS IS NOT NULL AND CHAR_LENGTH(TRIM(A_COMMENTS)) > 0) THEN
    BEGIN
        SELECT FULL_NAME FROM TS_USERS WHERE USERID = :V_USER INTO :V_USERNAME;
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:A_DOCID, COALESCE(:V_USERNAME, 'WMS'), :A_COMMENTS);
    END

    EXECUTE PROCEDURE SP_LOG_CREATE_NEW(:A_DOCID, :V_USER, 'Web-Order mutat in Oferte (DOCTYPEID 134 -> 115)', 0, 0, 115);

    DOCID = A_DOCID;
    SUSPEND;
END ^

COMMIT^

/* --- 2. Triggere fara STATEID ------------------------------------------------------ */
CREATE OR ALTER TRIGGER TDB_DOCS_AU_DEAL FOR TDB_DOCS 
ACTIVE AFTER UPDATE POSITION 900 
SQL SECURITY DEFINER
AS
DECLARE V_DEAL BIGINT;
DECLARE V_ACTION VARCHAR(16);
DECLARE V_FOUND SMALLINT;
BEGIN
    IF (NEW.DOCTYPEID IN (101, 107, 110, 112, 115, 116, 117, 119, 120, 126, 128, 134, 1199, 1791)
        AND (NEW.SUMA IS DISTINCT FROM OLD.SUMA
             OR NEW.RATE IS DISTINCT FROM OLD.RATE
             OR NEW.DELETED_DATE IS DISTINCT FROM OLD.DELETED_DATE
             OR NEW.PARENTDOCID IS DISTINCT FROM OLD.PARENTDOCID
             OR NEW.DOCTYPEID IS DISTINCT FROM OLD.DOCTYPEID
             OR NEW.DTSC IS DISTINCT FROM OLD.DTSC)) THEN
    BEGIN
        V_FOUND = 0;
        FOR SELECT DEAL_ID FROM TDB_DEAL_DOCS WHERE DOCID = NEW.DOCID INTO :V_DEAL
        DO
        BEGIN
            V_FOUND = 1;
            EXECUTE PROCEDURE SP_DEAL_RECALC_STATES(:V_DEAL, NULL);
        END
        IF (V_FOUND = 0 AND NEW.DELETED_DATE IS NULL) THEN
            EXECUTE PROCEDURE SP_DEAL_ATTACH_DOC(NEW.DOCID, NEW.CREATED_BY)
                RETURNING_VALUES :V_DEAL, :V_ACTION;
        WHEN ANY DO
            EXECUTE PROCEDURE SP_DEAL_LOG_ERROR('TDB_DOCS_AU_DEAL', NEW.DOCID, NULL,
                GDSCODE, SQLSTATE, LEFT(RDB$ERROR(MESSAGE), 1000));
    END
END ^

COMMIT^

CREATE OR ALTER TRIGGER TDB_DOCS_AU0 FOR TDB_DOCS 
ACTIVE AFTER UPDATE POSITION 0 
AS
DECLARE VARIABLE OLD_FLG_CLOSED DM_BOOLEAN;
DECLARE VARIABLE OLD_FLG_SHIP DM_BOOLEAN;
DECLARE VARIABLE NEW_FLG_CLOSED DM_BOOLEAN;
DECLARE VARIABLE NEW_FLG_SHIP DM_BOOLEAN;
DECLARE VARIABLE OLD_FLG_ACNT DM_BOOLEAN;
DECLARE VARIABLE NEW_FLG_ACNT DM_BOOLEAN;
DECLARE VARIABLE NEW_FLG_SEND DM_BOOLEAN; /* 4 */
DECLARE VARIABLE OLD_FLG_SEND DM_BOOLEAN; /* 4 */
DECLARE VARIABLE NEW_FLG_RECEIVE DM_BOOLEAN; /* 5 */
DECLARE VARIABLE OLD_FLG_RECEIVE DM_BOOLEAN;
DECLARE VARIABLE GOODSID DM_INTEGER;
DECLARE VARIABLE DTDEP DM_INTEGER;
DECLARE VARIABLE NEW_FLG_EXPORTED DM_BOOLEAN; /* 11 */
DECLARE VARIABLE OLD_FLG_EXPORTED DM_BOOLEAN; /* 11 */
DECLARE VARIABLE QTY DM_QTY;
DECLARE VARIABLE PRICE DM_PRICE;

DECLARE VARIABLE CURRENTUSERID DM_INTEGER;
declare variable requireModifyDOC DM_BOOLEAN;
declare variable debugTXT DM_BLOBTEXT;
declare variable k dm_amount;

declare variable CONTRACT_PRICE_COLUMN DM_INTEGER;

BEGIN
     /* Verificam daca ne trebuie trigerii  */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS')='YES') THEN EXIT;


     CURRENTUSERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
     requireModifyDOC = RDB$GET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC');

     IF (((NEW.CURRENCYID <> OLD.CURRENCYID) OR (NEW.RATE <> OLD.RATE) OR (NEW.RATEUSD<>OLD.RATEUSD)) and (not new.doctypeid in (106, 109))) THEN
     BEGIN
          /* TO DO */
          k = new.rateusd / old.rateusd;
          update tdb_jurnal set price = round(price * :k, 2), suma = round(suma * :k, 2), sumavat = round(sumavat * :k, 2) where docid=new.docid;
     END


     IF (NEW.CURRENCYID <> OLD.CURRENCYID) THEN
     BEGIN
               UPDATE TDB_JURNAL J
               SET --COST = (select cost from SP_GET_COST_COMPLECT (new.DOCID, j.goodsid)),
                   /* COST = NewPrice*NewRate (este tot timpul in LEI) */
                   PRICE = CAST(PRICE AS DOUBLE PRECISION) * CAST(OLD.RATE AS DOUBLE PRECISION) / CAST(NEW.RATE AS DOUBLE PRECISION) /* = NewPrice */
               WHERE DOCID = NEW.DOCID;

     END
     IF (NEW.CURRENCYID = OLD.CURRENCYID AND NEW.RATE <> OLD.RATE) THEN
     BEGIN
          UPDATE TDB_JURNAL j
          set --cost = (select cost from SP_GET_COST_COMPLECT (new.DOCID, j.goodsid)),
          --SET COST = CAST(PRICE AS DOUBLE PRECISION) * CAST(NEW.RATE AS DOUBLE PRECISION),
              FLAGS = SET_FLG_VALUE(FLAGS, 1, GET_FLG_VALUE(NEW.FLAGS, 1))
          WHERE DOCID = NEW.DOCID;

     END

     /* Logam schimbarile de FLG_CLOSED=10 si FLG_SHIP=0 */
     OLD_FLG_SHIP = GET_FLG_VALUE(OLD.FLAGS, 0);
     OLD_FLG_CLOSED = GET_FLG_VALUE(OLD.FLAGS, 10);
     NEW_FLG_SHIP = GET_FLG_VALUE(NEW.FLAGS, 0);
     NEW_FLG_CLOSED = GET_FLG_VALUE(NEW.FLAGS, 10);
     OLD_FLG_ACNT = GET_FLG_VALUE(OLD.FLAGS, 1);
     NEW_FLG_ACNT = GET_FLG_VALUE(NEW.FLAGS, 1);

     NEW_FLG_SEND = GET_FLG_VALUE(NEW.FLAGS, 4);
     OLD_FLG_SEND = GET_FLG_VALUE(OLD.FLAGS, 4);

     NEW_FLG_RECEIVE = GET_FLG_VALUE(NEW.FLAGS, 5);
     OLD_FLG_RECEIVE = GET_FLG_VALUE(OLD.FLAGS, 5);

     NEW_FLG_EXPORTED = GET_FLG_VALUE(NEW.FLAGS, 11);
     OLD_FLG_EXPORTED = GET_FLG_VALUE(OLD.FLAGS, 11);


     /* daca se schimba FLG_ACNT, aceasta trebuie reflectata si in TDB_JURNAL pentru calculul qty_acnt */
     IF (NEW_FLG_ACNT <> OLD_FLG_ACNT) THEN
          UPDATE TDB_JURNAL
          SET FLAGS = SET_FLG_VALUE(FLAGS, 1, :NEW_FLG_ACNT)
          WHERE DOCID = NEW.DOCID;

     IF (NEW_FLG_SHIP <> OLD_FLG_SHIP) THEN
          EXECUTE PROCEDURE SP_LOG_CREATE_NEW(NEW.DOCID, CURRENTUSERID, 'User changed FLG_SHIP to ' || :NEW_FLG_SHIP);
     IF (NEW_FLG_CLOSED <> OLD_FLG_CLOSED) THEN
          EXECUTE PROCEDURE SP_LOG_CREATE_NEW(NEW.DOCID, CURRENTUSERID, 'User changed FLG_CLOSED to ' || :NEW_FLG_CLOSED);

     IF (NEW_FLG_SEND <> OLD_FLG_SEND) THEN
          EXECUTE PROCEDURE SP_LOG_CREATE_NEW(NEW.DOCID, CURRENTUSERID, 'User changed FLG_SEND to ' || :NEW_FLG_SEND);

     IF (NEW_FLG_RECEIVE <> OLD_FLG_RECEIVE) THEN
          EXECUTE PROCEDURE SP_LOG_CREATE_NEW(NEW.DOCID, CURRENTUSERID, 'User changed FLG_RECEIVE to ' || :NEW_FLG_RECEIVE);


     IF (NEW_FLG_EXPORTED <> OLD_FLG_EXPORTED) THEN
          EXECUTE PROCEDURE SP_LOG_CREATE_NEW(NEW.DOCID, CURRENTUSERID, 'User changed FLG_EXPORTED to ' || :NEW_FLG_EXPORTED);



     EXECUTE PROCEDURE SP_LOG_CREATE_NEW(OLD.DOCID,
                                         RDB$GET_CONTEXT('USER_SESSION', 'UserID'),
                                         'User updated  document (TDB_DOCS), dataOLD=' || OLD.DATA || ', dataNEW=' || NEW.DATA ||
                                         ', suma' || OLD.SUMA || ', rate=' || OLD.RATE || ', rateusd=' || OLD.RATEUSD ||
                                         'currencyid=' || OLD.CURRENCYID || ', dt=' || OLD.DT || ', ct=' || OLD.CT || ', dtdep=' || OLD.DTDEP || ', ctdep=' ||
                                         OLD.CTDEP || ', sc2=' || OLD.SC2 ||', flg_acnt=' || GET_FLG_VALUE(OLD.FLAGS, 1) || ', old parentdocid='||old.parentdocid || 'old dtsc='|| old.dtsc || ', old.ctsc='||old.ctsc ||
                                         ' new suma' || NEW.SUMA || ', NEW rate=' || NEW.RATE || ', new rateusd=' || NEW.RATEUSD || 'new currencyid=' ||
                                         NEW.CURRENCYID || ', new dt=' || NEW.DT || ', ct=' || NEW.CT || ', dtdep=' || NEW.DTDEP || ', new ctdep=' ||
                                         NEW.CTDEP || ', new sc2=' || NEW.SC2 || ', new. flg_acnt=' || GET_FLG_VALUE(NEW.FLAGS, 1)||', doctypeid='||new.doctypeid || 'new dtsc='|| new.dtsc || ', new.ctsc='||new.ctsc ||
                                         'new parentdocid='||new.parentdocid ,
                                         old.suma, new.suma, new.doctypeid);

     IF (NEW.DOCTYPEID=114) THEN
     BEGIN
          IF ((OLD_FLG_CLOSED = 0) AND (NEW_FLG_CLOSED = 1)) THEN
          BEGIN
               RDB$SET_CONTEXT('USER_SESSION', 'DOCS_114_CLOSED', 1);
               UPDATE TDB_JURNAL SET QTY = QTY WHERE DOCID = NEW.DOCID;

               --  EXECUTE PROCEDURE SPM_MODIFY_TRANSIT_QTY(NEW.DOCID, 1);
               RDB$SET_CONTEXT('USER_SESSION', 'DOCS_114_CLOSED', 0);
           END

           IF ((OLD_FLG_CLOSED = 1) AND (NEW_FLG_CLOSED = 0)) THEN
           BEGIN
                RDB$SET_CONTEXT('USER_SESSION', 'DOCS_114_ANULAT', 1);
                UPDATE TDB_JURNAL SET QTY = QTY WHERE DOCID = NEW.DOCID;
                --    EXECUTE PROCEDURE SPM_MODIFY_TRANSIT_QTY(NEW.DOCID, 0);
                RDB$SET_CONTEXT('USER_SESSION', 'DOCS_114_ANULAT', 0);
           END
     END

     /* daca e sborca si so modificat pretul trebui modificat si in rashod (adica documentul parent */
     IF ((NEW.SUMA <> OLD.SUMA) AND (NEW.DOCTYPEID = 113) AND (NEW.PARENTDOCID<>-1) AND ((SELECT DOCTYPEID FROM TDB_DOCS WHERE DOCID=NEW.PARENTDOCID)=107) ) THEN
     BEGIN
          FOR
             SELECT DTDEP, GOODSID, QTY, PRICE
             FROM TDB_JURNAL
             WHERE DOCID = NEW.DOCID AND GOODSCOMPLECT_ID = -1
             INTO :DTDEP, :GOODSID, :QTY, :PRICE
          DO
          BEGIN
               UPDATE TDB_JURNAL SET QTY = :QTY, PRICE = :PRICE
               WHERE DOCID = NEW.PARENTDOCID AND DTDEP = :DTDEP AND GOODSID = :GOODSID;
          END
     END


     /* JOHN. 06.07.2012 */
     /* Contractele. Daca se aplica contract la document, se impune in document valuta si colonita de preturi din contract */
     IF (NEW.CONTRACTID IS NOT NULL AND NEW.CONTRACTID<>OLD.CONTRACTID) THEN
     BEGIN
          SELECT PRICE_COLUMN
          FROM TDB_CONTRACTS
          WHERE CONTRACTID=NEW.CONTRACTID
          INTO :CONTRACT_PRICE_COLUMN;
          if (:new.doctypeid not in (1455, 106, 109, 1506,126)) then
            IF (CONTRACT_PRICE_COLUMN IS NOT NULL) THEN EXECUTE PROCEDURE APPLY_PRICE_GOODSCOMPLECT(NEW.DOCID, NULL,:CONTRACT_PRICE_COLUMN);
     END

     /* 11.03.2014 - JOHN */
     /* Fixarea cantitatilor pe contabilitate la "Peremeshenie" intre diferite firme */
     /* La inchiderea "Scet-Factura", daca firma (CT) este in lista firmelor 1C, se genereaza "Prihod Tovara" */
     /* !!! Daca documentul se deschide, atunci "Prihod Tovara" se sterge. */
     IF (NEW.DOCTYPEID=112 AND NEW_FLG_CLOSED <> OLD_FLG_CLOSED AND NEW_FLG_CLOSED=1) THEN
     BEGIN
          /* verificam daca DT si CT exista in lista firmelor din 1C */
          /* si firma lor de baza nu coincide */
          IF (EXISTS(
                     SELECT 1
                     FROM TS_CUST_1C DT_1C
                     INNER JOIN TS_CUST_1C CT_1C ON CT_1C.CUSTOMERID = NEW.CT
                     WHERE (DT_1C.CUSTOMERID=NEW.DT) AND (DT_1C.FIRMA_COD<>CT_1C.FIRMA_COD)
                    )
              )
          THEN
          begin
               EXECUTE PROCEDURE SP_SYNC_112_TO_109(NEW.DOCID);
          end

     END

      if (new.doctypeid in (122, 123, 3269, 118)) then
      begin
        execute procedure sp_create_mail_to_send('sergiu@fantastic.md', '', 'Document modificat in '|| (select title from ts_doctypes where doctypeid = new.doctypeid),
        'document: ' ||new.docid ||ascii_char(13)||ascii_char(10)||
        'de catre utilizatorul: ' || (select u.full_name from ts_users u where userid = :CURRENTUSERID));
      end

END ^

COMMIT^

CREATE OR ALTER TRIGGER TRG_TDB_DOCS_BI FOR TDB_DOCS 
ACTIVE BEFORE INSERT POSITION 0 
AS
    DECLARE VARIABLE TMPBODY DM_BLOBTEXT;
    DECLARE VARIABLE FULLNAME TYPE OF COLUMN TS_USERS.FULL_NAME;
    DECLARE VARIABLE DEBUGTXT DM_BLOBTEXT;
    DECLARE VARIABLE DATA DM_DATE;
    DECLARE VARIABLE DT_NAME TYPE OF COLUMN TS_CUSTOMER.NAME;
    DECLARE VARIABLE CT_NAME TYPE OF COLUMN TS_CUSTOMER.NAME;
    DECLARE VARIABLE CT DM_INTEGER;
BEGIN
  /* Verificam daca ne trebuie trigerii  */
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;
  /*-----------------------------------------------------------------------*/

  IF (RDB$GET_CONTEXT('USER_SESSION', 'DEBUG') = 1) THEN
  BEGIN
    DEBUGTXT = 'DOCS_BEFORE_INSERT: DOCID=' || COALESCE(NEW.DOCID, 'NULL') ||
               ' DOCTYPEID=' || COALESCE(NEW.DOCTYPEID, 'NULL') || ' (' || COALESCE((SELECT TITLE
                                                                    FROM TS_DOCTYPES
                                                                    WHERE TS_DOCTYPES.DOCTYPEID = NEW.DOCTYPEID), 'NULL') || ')';

    --    INSERT INTO TDB_DEBUG (TEXT)    VALUES (:DEBUGTXT);
  END
  new.contractid = coalesce(new.contractid, -1);
--  new.docno = coalesce(new.docno, -1);
  NEW.CTSC = COALESCE(NEW.CTSC, -1);
  /* DocID by generator*/
  IF (NEW.DOCID IS NULL) THEN NEW.DOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;
  /* When document was created */
  NEW.CREATED_DATE = CURRENT_TIMESTAMP;

  IF (NEW.DATA IS NULL) THEN NEW.DATA = CURRENT_TIMESTAMP;

  IF (((NEW.DATA < (CURRENT_DATE - 7)) AND (NEW.DOCTYPEID IN (/* 106,*/ 107, 110, 112, 2016, 116, 117)))
    and (RDB$GET_CONTEXT('USER_SESSION', 'UserID')<>204)) THEN
    EXCEPTION ERR_GENERAL_ERROR 'Eroare la crearea documentului cu o data mai mica decit data curenta - 7 zile';

  IF (NEW.CREATED_BY IS NULL) THEN NEW.CREATED_BY = RDB$GET_CONTEXT('USER_SESSION', 'UserID');
  /* When document was last modified */

  /* Default CT */
  IF (NEW.CT IS NULL) THEN NEW.CT = -1;

  /* Default Stock */
  IF (NEW.DTDEP IS NULL) THEN NEW.DTDEP = -1;
  IF (NEW.CTDEP IS NULL) THEN NEW.CTDEP = -1;

  /* Default Analitica */
  IF (NEW.SC2 IS NULL) THEN NEW.SC2 = -1;
  IF (NEW.DTSC IS NULL) THEN NEW.DTSC = -1;

  /* Defaults */
  IF (NEW.DELETED_BY IS NULL) THEN NEW.DELETED_BY = -1;
  --IF (NEW.DELETED_DATE IS NULL) THEN NEW.DELETED_DATE = '01.01.1901';

  /* Sums */
  IF (NEW.SUMA IS NULL) THEN
    NEW.SUMA = 0;
  IF (NEW.RATE IS NULL) THEN
    NEW.RATE = 1;
  IF (NEW.RATEUSD IS NULL) THEN
    NEW.RATEUSD = (SELECT EXCHANGE_RATE
                   FROM TS_CURRENCY
                   WHERE TS_CURRENCY.CURRENCYID = 840);
  IF (NEW.DISCOUNT IS NULL) THEN
    NEW.DISCOUNT = 0;

  /* Flags */
  IF (NEW.FLAGS IS NULL) THEN NEW.FLAGS = 0;

  /*  daca e vinzare atunci flg_salary=1 */
  if (new.doctypeid =107) then new.flags = set_FLG_VALUE(new.flags, 14,1);

  /* ParentDocID */
  IF (NEW.PARENTDOCID IS NULL) THEN NEW.PARENTDOCID = -1;

  /* Security */
  IF (NEW.ACC$MASK IS NULL) THEN NEW.ACC$MASK = 0;

  /* Calc DocNO based on DocTypeID */
--  SELECT COALESCE(DOCNO, -1) FROM GETDOCNOBYDOCTYPE(NEW.DOCTYPEID) INTO NEW.DOCNO;
--  new.docno = coalesce(new.docno, -1);
  /* Calcul TVA */
  if ((get_flg_value((select flags from ts_doctypes where doctypeid = new.doctypeid), 3) = 1) or (exists(select docid from tdb_jurnal where docid = new.docid))) then
  begin
    select sum(sumavat) from tdb_jurnal j where docid = new.docid and j.goodscomplect_id = -1 into NEW.VAT;
    new.vat = coalesce(new.vat, 0);
  end
  else
      SELECT VAT FROM GET_VAT_BY_CUSTOMER(new.dt,  new.CT, 0,  NEW.SUMA, coalesce(new.contractid, -1))
        INTO NEW.VAT;

  new.vat = coalesce(new.vat, new.suma/6);

--  if (new.doctypeid = 112) then
--  begin
--   if (iif(exists(select J.docid from tdb_jurnal J where J.docid = new.docid and j.goodsid in (122293, 173080, 182874, 179913, 188324)), 1,
--     iif(exists(select J.docid from tdb_jurnal J where J.docid = new.docid and j.goodsid in (122294)), 2, 0)) > 0) then
--   begin
--      new.stateid = 5; /* delivery */
--   end
--   else
--      new.stateid = 4; /* self pickup */
--  end
--
  IF (NEW.DATA < CURRENT_DATE - 30) THEN
  BEGIN
    SELECT DATA, DT_NAME, CT, CT_NAME
    FROM VW_TDB_DOCS
    WHERE DOCID = NEW.DOCID
    INTO :DATA, :DT_NAME, :CT, :CT_NAME;

    SELECT U.FULL_NAME
    FROM TS_USERS U
    WHERE U.USERID = RDB$GET_CONTEXT('USER_SESSION', 'UserID')
    INTO :FULLNAME;


    TMPBODY = 'Document <b>#' || NEW.DOCID || '</b> a fost creat cu o data mai mica de 30 zile de la ziua curenta. Data crearii:' ||
                NEW.CREATED_DATE || ', data documentului: ' || NEW.DATA || '" Contragent: "' ||
                COALESCE(CT_NAME, '[lipseste]') || '",  de catre ' || FULLNAME;

    EXECUTE PROCEDURE SP_CREATE_MAIL_TO_SEND('s.minchevici@fantastic.md', '', 'Document creat cu data < 30zile! - ' || FULLNAME, TMPBODY);
  END

END ^

COMMIT^

CREATE OR ALTER TRIGGER VW_TDB_DOCS_BI FOR VW_TDB_DOCS 
ACTIVE BEFORE INSERT POSITION 0 
AS
DECLARE VARIABLE tmpFLAGS dm_integer;
BEGIN
     /* prepare FLAGS value */
     tmpFLAGS = 0;
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,0,COALESCE(NEW.FLG_SHIP,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,1,COALESCE(NEW.FLG_ACNT,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,2,COALESCE(NEW.FLG_DEL,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,3,COALESCE(NEW.FLG_PROTECTED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,4,COALESCE(NEW.FLG_SEND,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,5,COALESCE(NEW.FLG_RECEIVE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,6,COALESCE(NEW.FLG_PAID,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,7,COALESCE(NEW.FLG_INVOICE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,8,COALESCE(NEW.FLG_GOODS_ARRIVAL,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,9,COALESCE(NEW.FLG_READY,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,10,COALESCE(NEW.FLG_CLOSED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,11,COALESCE(NEW.FLG_EXPORTED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,12,COALESCE(NEW.FLG_child,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,13,COALESCE(NEW.FLG_NEW_CEC,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,14,COALESCE(NEW.FLG_SALARY,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,15,COALESCE(NEW.FLG_UPDATE_DATE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,16,COALESCE(NEW.FLG_FURNITURE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,17,COALESCE(NEW.FLG_CASHBACK,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,18,COALESCE(NEW.FLG_WEBSHOP_ORDER,0));

     if (NEW.RATEUSD IS NULL) then
     SELECT C.exchange_rate FROM ts_currency C WHERE CURRENCYID=840 INTO NEW.RATEUSD;

  INSERT INTO TDB_DOCS (
    DOCID,
    DATA,
    DT,
    CT,
    DTDEP,
    CTDEP,
    DTSC,
    CTSC,
    SC2,
    SUMA,
    VAT,
    CURRENCYID,
    DISCOUNT,
    RATE,
    RATEUSD,
    CREATED_DATE,
    CREATED_BY,
    DELETED_DATE,
    DELETED_BY,
    PARENTDOCID,
    ACC$MASK,
    DOCTYPEID,
    FLAGS,
    CONTRACTID,
    responsible_userid)
  VALUES (
    NEW.DOCID,
    NEW.DATA,
    NEW.DT,
    NEW.CT,
    NEW.DTDEP,
    NEW.CTDEP,
    NEW.DTSC,
    NEW.CTSC,
    NEW.SC2,
    NEW.SUMA,
    NEW.VAT,
    NEW.CURRENCYID,
    NEW.DISCOUNT,
    NEW.RATE,
    NEW.rateusd, 
    NEW.CREATED_DATE,
    NEW.CREATED_BY,
    NEW.DELETED_DATE,
    NEW.DELETED_BY,
    NEW.PARENTDOCID,
    NEW.ACC$MASK,
    NEW.DOCTYPEID,
    :tmpFLAGS,
    NEW.CONTRACTID,
    new.responsible_userid);
END ^

COMMIT^

CREATE OR ALTER TRIGGER VW_TDB_DOCS_BU FOR VW_TDB_DOCS 
ACTIVE BEFORE UPDATE POSITION 0 
AS
declare variable tmpFLAGS dm_integer;
BEGIN
     /* prepare FLAGS value */
     tmpFLAGS = 0;
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,0,COALESCE(NEW.FLG_SHIP,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,1,COALESCE(NEW.FLG_ACNT,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,2,COALESCE(NEW.FLG_DEL,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,3,COALESCE(NEW.FLG_PROTECTED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,4,COALESCE(NEW.FLG_SEND,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,5,COALESCE(NEW.FLG_RECEIVE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,6,COALESCE(NEW.FLG_PAID,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,7,COALESCE(NEW.FLG_INVOICE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,8,COALESCE(NEW.FLG_GOODS_ARRIVAL,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,9,COALESCE(NEW.FLG_READY,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,10,COALESCE(NEW.FLG_CLOSED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,11,COALESCE(NEW.FLG_EXPORTED,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,12,COALESCE(NEW.FLG_CHILD,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,13,COALESCE(NEW.FLG_NEW_CEC,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,14,COALESCE(NEW.FLG_SALARY,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,15,COALESCE(NEW.FLG_UPDATE_DATE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,16,COALESCE(NEW.FLG_FURNITURE,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,17,COALESCE(NEW.FLG_CASHBACK,0));
     tmpFLAGS = SET_FLG_VALUE(:tmpFLAGS,18,COALESCE(NEW.FLG_WEBSHOP_ORDER,0));


  UPDATE TDB_DOCS
  SET
      DATA = NEW.DATA,
      DT = NEW.DT,
      CT = NEW.CT,
      DTDEP = NEW.DTDEP,
      CTDEP = NEW.CTDEP,
      DTSC = NEW.DTSC,
      CTSC = NEW.CTSC,
      SC2 = NEW.SC2,
      SUMA = NEW.SUMA,
      VAT = NEW.VAT,
      CURRENCYID = NEW.CURRENCYID,
      DISCOUNT = NEW.DISCOUNT,
      RATE = NEW.RATE,
      RATEUSD = NEW.RATEUSD,
      CREATED_DATE = NEW.CREATED_DATE,
      CREATED_BY = NEW.CREATED_BY,
      DELETED_DATE = NEW.DELETED_DATE,
      DELETED_BY = NEW.DELETED_BY,
      PARENTDOCID = coalesce(NEW.PARENTDOCID,-1),
      ACC$MASK = NEW.ACC$MASK,
      DOCTYPEID = NEW.DOCTYPEID,
      FLAGS = :tmpFLAGS,
      CONTRACTID = COALESCE(NEW.CONTRACTID,-1),
      responsible_userid = new.responsible_userid
  WHERE
      (DOCID = OLD.DOCID);

END ^

COMMIT^

/* --- 3. Procedurile de tranzitie (stare veche -> deal) -------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (EXISTS(SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = 'SP_DEAL_MIGRATE_DOC_STATES')) THEN
        EXECUTE STATEMENT 'DROP PROCEDURE SP_DEAL_MIGRATE_DOC_STATES';
END^

COMMIT^

EXECUTE BLOCK AS
BEGIN
    IF (EXISTS(SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = 'SP_DEAL_APPLY_DOC_STATE')) THEN
        EXECUTE STATEMENT 'DROP PROCEDURE SP_DEAL_APPLY_DOC_STATE';
END^

COMMIT^

SET TERM ; ^

/* --- 4. VW_TDB_DOCS fara STATEID / STATE_NAME (triggerele si drepturile raman) ------- */
CREATE OR ALTER VIEW VW_TDB_DOCS (DOCID, DATA, DT, DT_NAME, CT, CT_NAME, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, DTSC, DTSC_NAME, CTSC, CTSC_NAME, SC2, SC2_NAME, SUMA, VAT, CURRENCYID, CURRENCY_NAME, DISCOUNT, RATE, RATEUSD, FLG_SHIP, FLG_ACNT, FLG_DEL, FLG_PROTECTED, FLG_SEND, FLG_RECEIVE, FLG_PAID, FLG_INVOICE, FLG_GOODS_ARRIVAL, FLG_READY, FLG_CLOSED, FLG_EXPORTED, FLG_CHILD, FLG_NEW_CEC, FLG_SALARY, FLG_UPDATE_DATE, FLG_FURNITURE, FLG_CASHBACK, FLG_WEBSHOP_ORDER, CREATED_DATE, CREATED_BY, CREATED_BY_NAME, DELETED_DATE, DELETED_BY, DELETED_BY_NAME, PARENTDOCID, ACC$MASK, DOCTYPEID, DOCTYPE_NAME, CONTRACTID, CONTRACT_CODE, CONTRACT_SIGN_DATE, CONTRACT_CURRENCYID, CONTRACT_TYPE_TITLE, CONTRACT_PRICECOLUMN, FLG_WITH_DELIVERY, PHONELIST, FLG_HAS_REZERVA, FLG_HAS_PROFORMA, RESPONSIBLE_USERID, RESPONSIBLE_USERNAME) AS
SELECT
    D.DOCID,
    D.DATA,
    D.DT,
    (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (CUSTOMERID=D.DT)),
    D.CT,
    (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (CUSTOMERID=D.CT)),
    D.DTDEP,
    (SELECT TITLE FROM TS_STOCKS WHERE (STOCKID=D.DTDEP)),
    D.CTDEP,
    (SELECT TITLE FROM TS_STOCKS WHERE (STOCKID=D.CTDEP)),
    D.DTSC,
    (SELECT TITLE FROM TS_SYSS WHERE (TS_SYSS.SYSSID=D.DTSC)),
    D.CTSC,
    (SELECT TITLE FROM TS_SYSS WHERE (TS_SYSS.SYSSID=D.CTSC)),
    D.SC2,
    /* SC2 */
    (SELECT TITLE FROM TS_ANALYTICS WHERE ANALITICAID=SC2),

    D.SUMA,
    D.VAT,
    D.CURRENCYID,
    (SELECT SHORTNAME FROM TS_CURRENCY WHERE (TS_CURRENCY.CURRENCYID=D.CURRENCYID)),
    D.DISCOUNT,
    D.RATE,
    D.RATEUSD,
    GET_FLG_VALUE(D.FLAGS,0), /* FLG_SHIP */
    GET_FLG_VALUE(D.FLAGS,1), /* FLG_ACNT */
    GET_FLG_VALUE(D.FLAGS,2), /* FLG_DEL */
    GET_FLG_VALUE(D.FLAGS,3), /* FLG_PROTECTED */
    GET_FLG_VALUE(D.FLAGS,4), /* FLG_SEND */
    GET_FLG_VALUE(D.FLAGS,5), /* FLG_RECEIVE */
    GET_FLG_VALUE(D.FLAGS,6), /* FLG_PAID */
    GET_FLG_VALUE(D.FLAGS,7), /* FLG_INVOICE */
    GET_FLG_VALUE(D.FLAGS,8), /* FLG_GOODS_ARRIVAL */
    GET_FLG_VALUE(D.FLAGS,9), /* FLG_READY */
    GET_FLG_VALUE(D.FLAGS,10), /* FLG_CLOSED */
    GET_FLG_VALUE(D.FLAGS,11), /* FLG_EXPORTED */
    GET_FLG_VALUE(D.FLAGS,12), /* FLG_CHILD */
    GET_FLG_VALUE(D.FLAGS,13), /* FLG_NEW_CEC */
    GET_FLG_VALUE(d.FLAGS,14), /* FLG_SALARY */
    GET_FLG_VALUE(d.FLAGS,15), /* FLG_UPDATE_DATE */
    GET_FLG_VALUE(d.FLAGS,16), /* FLG_FURNITURE */
    GET_FLG_VALUE(d.FLAGS,17), /* FLG_CASHBACK */
    GET_FLG_VALUE(d.FLAGS,18), /* FLG_WEBSHOP_ORDER */

    D.CREATED_DATE,
    D.CREATED_BY,
    (SELECT FULL_NAME FROM TS_USERS WHERE (USERID=D.CREATED_BY)),
    D.DELETED_DATE,
    D.DELETED_BY,
    IIF(D.DELETED_BY IS NULL,NULL,(SELECT LOGIN_NAME FROM TS_USERS WHERE (USERID=DELETED_BY))),
    IIF(D.PARENTDOCID=-1, NULL, D.PARENTDOCID),
    D.ACC$MASK,
    D.DOCTYPEID,
    (SELECT TITLE FROM TS_DOCTYPES WHERE (TS_DOCTYPES.DOCTYPEID=D.DOCTYPEID)),
    D.CONTRACTID,
    C.CODE,
    C.SIGN_DATE,
    C.CURRENCYID,
    CT.TITLE,
    IIF(C.PRICE_COLUMN IS NULL,1,C.PRICE_COLUMN),
    iif(exists(select J.docid from tdb_jurnal J where J.docid=D.docid and J.goodsid in (122293, 173080, 182874, 179913, 188324)), 1,
    iif(exists(select J.docid from tdb_jurnal J where J.docid=D.docid and J.goodsid in (122294)), 2, 0)) FLG_WITH_DELIVERY,
    get_all_customer_phone(d.ct),
    iif (doctypeid = 115, iif((exists(select * from tdb_docs dd where dd.doctypeid = 107 and dd.parentdocid = d.docid)), 1, 0), 0) flg_has_rezerva,
    iif (doctypeid = 115, iif((exists(select * from tdb_docs dd where dd.doctypeid = 101 and dd.parentdocid = d.docid)), 1, 0), 0) flg_has_proforma,
    d.responsible_userid,
    (select full_name from ts_users u where u.userid = d.responsible_userid)
FROM TDB_DOCS D
LEFT OUTER JOIN TDB_CONTRACTS C ON (C.CONTRACTID=D.CONTRACTID)
LEFT OUTER JOIN TS_CONTRACT_TYPES CT ON (CT.CONTRACTTYPEID=C.CONTRACT_TYPE);

COMMIT;

/* --- 5. FK spre dictionarul de stari si coloana ------------------------------------- */
SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
               WHERE RDB$RELATION_NAME = 'TDB_DOCS' AND RDB$CONSTRAINT_NAME = 'FK_TDB_DOCS_11')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS DROP CONSTRAINT FK_TDB_DOCS_11';
END^

COMMIT^

EXECUTE BLOCK AS
BEGIN
    IF (EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
               WHERE RDB$RELATION_NAME = 'TDB_DOCS' AND RDB$FIELD_NAME = 'STATEID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TDB_DOCS DROP STATEID';
END^

COMMIT^

SET TERM ; ^

/* Verificare: trebuie sa intoarca 0 randuri
SELECT RDB$DEPENDENT_NAME FROM RDB$DEPENDENCIES
 WHERE RDB$DEPENDED_ON_NAME IN ('TDB_DOCS', 'VW_TDB_DOCS') AND RDB$FIELD_NAME IN ('STATEID', 'STATE_NAME');
*/

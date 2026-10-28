/*
  26.10.2026 - seriile (numerele de serie, TDB_SN) din "Intrare marfa" (DOCTYPEID 106)
  devin disponibile pentru vinzare imediat, chiar daca documentul nu e inchis
  (FLG_CLOSED = bitul 10 din TDB_DOCS.FLAGS) - aceeasi regula ca la partide
  (available_parts_open_receipts.sql, 09.10.2026), care a schimbat doar TDB_PARTS.

  Proceduri modificate (sursele luate din SW pe 26.10.2026):
    GET_SN_DEP_GOODS   - alegerea seriilor in documente (TMP_SN): frmSelectSNDialog,
                         frmSelectSNParentedDialog, frm52ZamenaTovaraSelectSNDialog
    GET_AVAILABLE_SN   - dialogul "serii disponibile" (frmGoodsAviableSerialsNumbersDialog),
                         SP_POS_CLOSE_SALE, CHECK_VOUCHER_CODE

  Singura schimbare fata de versiunile din baza este in primul bloc (intrari si
  retururi cu semnul plus):
    inainte: AND GET_FLG_VALUE(tdb_docs.FLAGS, 10)=1
    acum:    AND (GET_FLG_VALUE(tdb_docs.FLAGS, 10)=1 OR TDB_DOCS.DOCTYPEID = 106)

  Nu se schimba (nu cer document inchis la intrari):
    GET_SN_DEP_GOODS_EX        - verificarea din trigger-ul TDB_SN_BI0 la salvarea vinzarii
    GET_SN_DEP_GOODS_REALIZARE - tip 50
    GET_SN_DEP                 - nefolosita
  Restul tipurilor din bloc raman ca inainte - doar inchise. Semnatura procedurilor nu
  se schimba (dependentele SP_POS_CLOSE_SALE, CHECK_VOUCHER_CODE raman valide), scriptul
  se poate rula repetat.
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_SN_DEP_GOODS (
    GOODSID INTEGER,
    DTDEP INTEGER,
    DT INTEGER,
    DATA DATE)
AS
DECLARE VARIABLE SN VARCHAR(60);
DECLARE VARIABLE COUNTRYID DM_INTEGER;
DECLARE VARIABLE VENDORID DM_INTEGER;
BEGIN
  /* 26.10.2026 - Intrare marfa (106) se ia in calcul si neinchisa (ca GET_PARTS_DEP_GOODS) */
  DELETE FROM TMP_SN
  WHERE 1 = 1;

  FOR SELECT SN, COUNTRYID, VENDORID
      FROM (/* prihod sau vozvrat cu semnul plus */
      SELECT DTDEP, SN, 1 CANT, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            DTDEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND (GET_FLG_VALUE(tdb_docs.FLAGS,  10)=1 /* Document inchis */
                                   OR TDB_DOCS.DOCTYPEID = 106) /* Intrare marfa - si neinchisa */ AND
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 3) = 1)) AND
                                                           GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 4) = 1) AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /* sborca daca e complect cantitatea in plus */
      SELECT DTDEP, SN, 1, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            DTDEP = :DTDEP AND
            S.GOODSCOMPLECT_ID = -1 AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID = 113 /* SBORKA */ AND
                              GET_FLG_VALUE(FLAGS, 10) = 1 /* FLG_CLOSED () */ AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /* peremeshenie poluciateli in plus */
      SELECT CTDEP, SN, 1 CANT, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            CTDEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE CT = :DT AND
                              GET_FLG_VALUE(FLAGS, 10) = 1 AND
                              /* daca marfa se transmite din alte filiale pina ce nu ajunge si nu e primita adica inchis documentul nu trebuie sa apara seriile in cele  */
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 5) = 1) AND
                                                           TS_DOCTYPES.TABSHEETINDEX > -1)) AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /* rashoduri si vozvtraturi in minus */
      SELECT DTDEP, SN, -1 CANT, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            DTDEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 3) = 1)) AND
                                                           GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 4) = 0 AND
                                                           DOCTYPEID <> 113) AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /* sborka daca nu e complect spisuim marfa */
      SELECT DTDEP, SN, -1, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            DTDEP = :DTDEP AND
            S.GOODSCOMPLECT_ID > -1 AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID = 113 AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /*  peremesheni otpraviteli in minus */
      SELECT DTDEP, SN, -1, COUNTRYID, VENDORID
      FROM TDB_SN S
      WHERE GOODSID = :GOODSID AND
            DTDEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE (GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 5) = 1) AND
                                                           CAST(DATA AS DATE) <= :DATA))

      UNION ALL
      /*  double jurnal dt part*/
      SELECT DT_DEP, DT_IDENT, -1, DT_COUNTRYID, DT_VENDORID
      FROM TDB_JURNAL_SP S
      WHERE DT_GOODSID = :GOODSID AND
            DT_DEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE (GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 10) = 1)) AND
                              CAST(DATA AS DATE) <= :DATA)
      UNION ALL
      /*  double jurnal ct part*/
      SELECT CT_DEP, CT_IDENT, 1, CT_COUNTRYID, CT_VENDORID
      FROM TDB_JURNAL_SP S
      WHERE CT_GOODSID = :GOODSID AND
            CT_DEP = :DTDEP AND
            S.DOCID IN (SELECT DOCID
                        FROM TDB_DOCS
                        WHERE DT = :DT AND
                              TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                     FROM TS_DOCTYPES
                                                     WHERE (GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 10) = 1)) AND
                              CAST(DATA AS DATE) <= :DATA)

      )
      GROUP BY DTDEP, SN, COUNTRYID, VENDORID
      HAVING SUM(CANT) > 0
      INTO :SN, :COUNTRYID, :VENDORID
  DO
  BEGIN
    INSERT INTO TMP_SN (SN, COUNTRYID, VENDORID)
    VALUES (:SN, :COUNTRYID, :VENDORID);
  END
END^

SET TERM ; ^

COMMIT;


SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_AVAILABLE_SN (
    FIRMA DM_INTEGER_NN,
    GOODSID DM_INTEGER_NN)
RETURNS (
    STOCKID DM_INTEGER,
    SN DM_VARCHAR60,
    COUNTRYID DM_INTEGER,
    VENDORID DM_INTEGER)
AS
BEGIN
     /* 18.03.2014 - JOHN */
     /* Intoarce lista de numere de serie libere pentru produsul indicat */
     /* !!! Se iau in consideratie toate depozitele */
     /* 26.10.2026 - Intrare marfa (106) se ia in calcul si neinchisa (ca GET_AVAILABLE_PARTS) */

--     DELETE FROM TMP_GLOBAL_SN WHERE 1 = 1;
--
--     INSERT INTO TMP_GLOBAL_SN
--     SELECT DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMPLECT_SN, VENDORWARRANTY, OWNWARRANTY, CREATED_BY, SUMA_ACCIZE, COUNTRYID, VENDORID, CREATED_DATE
--     FROM TDB_SN
--     WHERE GOODSID = :GOODSID AND EXISTS(SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0 AND (CTDEP=STOCKID OR DTDEP=STOCKID));

     FOR
        SELECT DTDEP, SN, COUNTRYID, VENDORID
        FROM
        (
         /* prihod sau vozvrat cu semnul plus */
         SELECT DTDEP, SN, 1 CANT, COUNTRYID, VENDORID
         FROM TDB_SN S
         WHERE GOODSID = :GOODSID
               AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND (GET_FLG_VALUE(tdb_docs.FLAGS, 10)=1 -- Document inchis
                                          OR TDB_DOCS.DOCTYPEID = 106) -- Intrare marfa - si neinchisa
                                     AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                                FROM TS_DOCTYPES
                                                                WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,3) = 1
                                                                      AND GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 4) = 1
                                                               )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                              )
         UNION ALL

         /* sborca daca e complect cantitatea in plus */
         SELECT DTDEP, SN, 1, COUNTRYID, VENDORID
         FROM TDB_SN S
         WHERE GOODSID = :GOODSID
               AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.GOODSCOMPLECT_ID = -1
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND TDB_DOCS.DOCTYPEID = 113 /* SBORKA */
                                     AND GET_FLG_VALUE(FLAGS, 10) = 1 /* FLG_CLOSED () */
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                              )
        UNION ALL
        /* peremeshenie poluciateli in plus */
        SELECT CTDEP, SN, 1 CANT, COUNTRYID, VENDORID
        FROM TDB_SN S
        WHERE GOODSID = :GOODSID
              AND CTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE CT = :FIRMA
                                    AND GET_FLG_VALUE(FLAGS, 10) = 1
                                    /* daca marfa se transmite din alte filiale pina ce nu ajunge si nu e primita adica inchis documentul nu trebuie sa apara seriile in cele  */
                                    AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                               FROM TS_DOCTYPES
                                                               WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,5) = 1
                                                                     AND TS_DOCTYPES.TABSHEETINDEX > -1
                                                              )
                                    AND CAST(DATA AS DATE) <= CURRENT_DATE
                             )
        UNION ALL

        /* rashoduri si vozvtraturi in minus */
        SELECT DTDEP, SN, -1 CANT, COUNTRYID, VENDORID
        FROM TDB_SN S
        WHERE GOODSID = :GOODSID
              AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE DT = :FIRMA
                                    AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                               FROM TS_DOCTYPES
                                                               WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,3) = 1
                                                                     AND GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 4) = 0
                                                                     AND DOCTYPEID <> 113
                                                              )
                                    AND CAST(DATA AS DATE) <= CURRENT_DATE
                             )
        UNION ALL

        /* sborka daca nu e complect spisuim marfa */
        SELECT DTDEP, SN, -1, COUNTRYID, VENDORID
        FROM TDB_SN S
        WHERE GOODSID = :GOODSID
              AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.GOODSCOMPLECT_ID > -1
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE DT = :FIRMA
                                    AND TDB_DOCS.DOCTYPEID = 113
                                    AND CAST(DATA AS DATE) <= CURRENT_DATE
                             )
        UNION ALL

        /*  peremesheni otpraviteli in minus */
        SELECT DTDEP, SN, -1, COUNTRYID, VENDORID
        FROM TDB_SN S
        WHERE GOODSID = :GOODSID
              AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE DT = :FIRMA
                                    AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                               FROM TS_DOCTYPES
                                                               WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,5)=1
                                                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                                                              )
                             )
        UNION ALL

        /*  double jurnal dt part*/
        SELECT DT_DEP, DT_IDENT, -1, DT_COUNTRYID, DT_VENDORID
        FROM TDB_JURNAL_SP S
        WHERE DT_GOODSID = :GOODSID
              AND DT_DEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE DT = :FIRMA
                                    AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                               FROM TS_DOCTYPES
                                                               WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,10)=1
                                                              )
                                    AND CAST(DATA AS DATE) <= CURRENT_DATE
                             )
        UNION ALL

        /*  double jurnal ct part*/
        SELECT CT_DEP, CT_IDENT, 1, CT_COUNTRYID, CT_VENDORID
        FROM TDB_JURNAL_SP S
        WHERE CT_GOODSID = :GOODSID
              AND CT_DEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
              AND S.DOCID IN (SELECT DOCID
                              FROM TDB_DOCS
                              WHERE DT = :FIRMA
                                    AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                               FROM TS_DOCTYPES
                                                               WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,10)=1
                                                              )
                                    AND CAST(DATA AS DATE) <= CURRENT_DATE
                             )
       )
       GROUP BY DTDEP, SN, COUNTRYID, VENDORID
       HAVING SUM(CANT) > 0
       INTO :STOCKID, :SN, :COUNTRYID, :VENDORID
     DO
       SUSPEND;
END^

SET TERM ; ^

COMMIT;

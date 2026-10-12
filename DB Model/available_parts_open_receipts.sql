/*
  09.10.2026 - seriile/partidele din "Intrare marfa" (DOCTYPEID 106, evidenta
  operativa) devin disponibile pentru vinzare imediat, chiar daca documentul
  nu e inchis (FLG_CLOSED = bitul 10 din TDB_DOCS.FLAGS).

  Proceduri modificate:
    GET_AVAILABLE_PARTS  - dialogul "partide disponibile" (frmGoodsAviablePartNumbersDialog)
    GET_PARTS_DEP_GOODS  - alegerea seriilor in documente (TMP_PARTS)

  Singura schimbare fata de versiunile din baza este in primul bloc (intrari si
  retururi cu semnul plus):
    inainte: AND GET_FLG_VALUE(FLAGS, 10)=1
    acum:    AND (GET_FLG_VALUE(FLAGS, 10)=1 OR TDB_DOCS.DOCTYPEID = 106)
  GET_PARTS_DEP_GOODS_REALIZARE nu cere document inchis - nu se schimba.

  Restul tipurilor din bloc (110, 122, 124, 125, 127, 130, 1249, 1757) raman
  ca inainte - doar inchise. Semnatura procedurilor nu se schimba, scriptul se
  poate rula repetat.
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_AVAILABLE_PARTS (
    FIRMA DM_INTEGER_NN,
    GOODSID DM_INTEGER_NN)
RETURNS (
    STOCKID DM_INTEGER,
    PARTNO DM_VARCHAR60,
    QTY DM_QTY,
    COUNTRYID DM_INTEGER,
    VENDORID DM_INTEGER)
AS
BEGIN
     /* 17.03.2014 - JOHN */
     /* Intoarce lista de numere de partida libere pentru produsul indicat */
     /* !!! Se iau in consideratie toate depozitele */
     /* 09.10.2026 - Intrare marfa (106) se ia in calcul si neinchisa */

     FOR
        SELECT
              DTDEP, PARTNO, SUM(QTY) QTY, COUNTRYID, VENDORID
        FROM
        (
         /* prihod sau vozvrat cu semnul plus */

         SELECT DTDEP, PARTNO, QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
         WHERE GOODSID = :GOODSID
               AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND (GET_FLG_VALUE(FLAGS, 10)=1 -- Document inchis
                                          OR TDB_DOCS.DOCTYPEID = 106) -- Intrare marfa - si neinchisa
                                     AND
                                     TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                            FROM TS_DOCTYPES
                                                            WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,3)=1 AND GET_FLG_VALUE(TS_DOCTYPES.FLAGS,4)=1
                                                           )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                               )
         UNION ALL

         /* sborca daca e complect cantitatea in plus */
         SELECT DTDEP, PARTNO, QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
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
         SELECT CTDEP, PARTNO, QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
         WHERE GOODSID = :GOODSID
               AND CTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE CT = :FIRMA
                                     AND GET_FLG_VALUE(FLAGS, 10) = 1
                                     /* daca marfa se transmite din alte filiale pina ce nu ajunge si nu e primita adica inchis documentul nu trebuie sa apara seriile in cele  */
                                     AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                                FROM TS_DOCTYPES
                                                                WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 5) = 1) AND TS_DOCTYPES.TABSHEETINDEX > -1)
                                                               )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                               )

         UNION ALL

         /* rashoduri si vozvtraturi in minus */
         SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
         WHERE GOODSID = :GOODSID
               AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                                FROM TS_DOCTYPES
                                                                WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,3) = 1 AND GET_FLG_VALUE(TS_DOCTYPES.FLAGS,4)=0 AND DOCTYPEID <> 113
                                                               )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                               )

         UNION ALL

         /* sborka daca nu e complect spisuim marfa */
         SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
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
         SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
         FROM TDB_PARTS S
         WHERE GOODSID = :GOODSID
               AND DTDEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                               AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                          FROM TS_DOCTYPES
                                                          WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,5)=1
                                                         )
                               AND CAST(DATA AS DATE) <= CURRENT_DATE
                              )
         UNION ALL

         /*  double jurnal dt part*/
         SELECT DT_DEP, DT_IDENT, -1, dt_COUNTRYID, dt_VENDORID
         FROM TDB_JURNAL_SP S
         WHERE DT_GOODSID = :GOODSID
               AND DT_DEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                                FROM TS_DOCTYPES
                                                                WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,10) = 1
                                                                )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                              )

         UNION ALL

         /*  double jurnal ct part*/
         SELECT CT_DEP, CT_IDENT, 1, Ct_COUNTRYID, Ct_VENDORID
         FROM TDB_JURNAL_SP S
         WHERE CT_GOODSID = :GOODSID
               AND CT_DEP IN (SELECT STOCKID FROM TS_STOCKS WHERE FLG_FOLDER=0)
               AND S.DOCID IN (SELECT DOCID
                               FROM TDB_DOCS
                               WHERE DT = :FIRMA
                                     AND TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                                                FROM TS_DOCTYPES
                                                                WHERE GET_FLG_VALUE(TS_DOCTYPES.FLAGS,10) = 1
                                                               )
                                     AND CAST(DATA AS DATE) <= CURRENT_DATE
                              )
        )
        GROUP BY DTDEP, PARTNO, COUNTRYID, VENDORID
        HAVING SUM(QTY) > 0
        INTO
            :STOCKID, :PARTNO, :QTY, :COUNTRYID, :VENDORID
     DO
       SUSPEND;

END^

SET TERM ; ^

COMMIT;


/* Aceeasi regula si pentru alegerea seriilor in documentele de vinzare
   (frmSelectPartNumbersDialog, frmSelectPartNumbersParentedDialog,
   frm52ZamenaTovaraSelectPartNoDialog). Schimbare doar in primul bloc. */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE GET_PARTS_DEP_GOODS (
    GOODSID DM_INTEGER,
    DTDEP DM_INTEGER,
    DT DM_INTEGER,
    DATA DM_DATE)
AS
DECLARE VARIABLE PARTNO DM_VARCHAR60;
DECLARE VARIABLE QTY DM_QTY;
DECLARE VARIABLE COUNTRYID DM_INTEGER;
DECLARE VARIABLE VENDORID DM_INTEGER;
BEGIN
  /* 09.10.2026 - Intrare marfa (106) se ia in calcul si neinchisa */
  DELETE FROM TMP_PARTS;
  FOR SELECT PARTNO, SUM(QTY) QTY, COUNTRYID, VENDORID
      FROM (/* prihod sau vozvrat cu semnul plus */

SELECT DTDEP, partno,  qty, COUNTRYID, VENDORID
FROM TDB_PARTS S
WHERE GOODSID = :GOODSID AND
      DTDEP = :DTDEP AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE DT = :DT AND (GET_FLG_VALUE(FLAGS, 10)=1 /* Document inchis */
                                     OR TDB_DOCS.DOCTYPEID = 106) /* Intrare marfa - si neinchisa */ and
                        TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                               FROM TS_DOCTYPES
                                               WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 3) = 1)) AND
                                                     GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 4) = 1) AND
                        CAST(DATA AS DATE) <= :DATA)
UNION ALL
/* sborca daca e complect cantitatea in plus */
SELECT DTDEP, PARTNO, QTY, COUNTRYID, VENDORID
FROM TDB_PARTS S
WHERE GOODSID = :GOODSID AND
      DTDEP = :DTDEP AND
      S.GOODSCOMPLECT_ID = -1 AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE DT = :DT AND
                        TDB_DOCS.DOCTYPEID = 113 /* SBORKA */ AND
                        GET_FLG_VALUE(FLAGS, 10) = 1 /* FLG_CLOSED () */ AND
                        CAST(DATA AS DATE) <= :DATA)
UNION ALL  /* peremeshenie poluciateli in plus */
SELECT CTDEP, PARTNO, QTY, COUNTRYID, VENDORID
FROM TDB_PARTS S
WHERE GOODSID = :GOODSID AND
      CTDEP = :DTDEP AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE CT = :DT AND
                        GET_FLG_VALUE(FLAGS, 10) = 1 and
                        /* daca marfa se transmite din alte filiale pina ce nu ajunge si nu e primita adica inchis documentul nu trebuie sa apara seriile in cele  */
                        TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                               FROM TS_DOCTYPES
                                               WHERE ((GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 5) = 1) AND
                                                     TS_DOCTYPES.TABSHEETINDEX > -1)) AND
                        CAST(DATA AS DATE) <= :DATA)
UNION ALL /* rashoduri si vozvtraturi in minus */
SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
FROM TDB_PARTS S
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
UNION ALL /* sborka daca nu e complect spisuim marfa */
SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
FROM TDB_PARTS S
WHERE GOODSID = :GOODSID AND
      DTDEP = :DTDEP AND
      S.GOODSCOMPLECT_ID > -1 AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE DT = :DT AND
                        TDB_DOCS.DOCTYPEID = 113 AND
                        CAST(DATA AS DATE) <= :DATA)
UNION ALL /*  peremesheni otpraviteli in minus */
SELECT DTDEP, PARTNO, -QTY, COUNTRYID, VENDORID
FROM TDB_PARTS S
WHERE GOODSID = :GOODSID AND
      DTDEP = :DTDEP AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE DT = :DT AND
                        TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                               FROM TS_DOCTYPES
                                               WHERE (GET_FLG_VALUE(TS_DOCTYPES.FLAGS, 5) = 1) AND
                                                     CAST(DATA AS DATE) <= :DATA))
UNION ALL /*  double jurnal dt part*/
SELECT DT_DEP, DT_IDENT, -1, dt_COUNTRYID, dt_VENDORID
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
UNION ALL /*  double jurnal ct part*/
SELECT CT_DEP, CT_IDENT, 1, Ct_COUNTRYID, Ct_VENDORID
FROM TDB_JURNAL_SP S
WHERE CT_GOODSID = :GOODSID AND
      CT_DEP = :DTDEP AND
      S.DOCID IN (SELECT DOCID
                  FROM TDB_DOCS
                  WHERE DT = :DT AND
                        TDB_DOCS.DOCTYPEID IN (SELECT TS_DOCTYPES.DOCTYPEID
                                               FROM TS_DOCTYPES
                                               WHERE (GET_FLG_VALUE (TS_DOCTYPES.FLAGS, 10) = 1)) AND
                                                     CAST(DATA AS DATE) <= :DATA)


      )
      GROUP BY DTDEP, PARTNO, COUNTRYID, VENDORID
      HAVING SUM(QTY) > 0
      INTO :PARTNO, :QTY, :COUNTRYID, :VENDORID
  DO
  BEGIN
    INSERT INTO TMP_PARTS (PARTNO, QTY, COUNTRYID, VENDORID)
    VALUES (:PARTNO, :QTY, :COUNTRYID, :VENDORID);
  END
END^

SET TERM ; ^

COMMIT;

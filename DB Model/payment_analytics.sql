/* ============================================================================
   Analitici de plata - TS_SYSS, grupa 26 "Analitica client (DTSC, CTSC)"
   NEURON Grup SRL, 18 septembrie 2026

   Valorile cu VALUE_INT > 0 din grupa 26 apar in lista "Analitica" a documentelor
   (SP_GET_ANALITICS_DTSC) si se salveaza in TDB_DOCS.DTSC.

   Existau deja:  5108 Fara analitica (implicita), 5114 Ecomm, 5117 POS Terminal.
   Se adauga:     QR MIA, Numerar, Credit 0%, Credit cu dobanda.

   VALUE_STR = cod stabil al analiticii (PAY_*), ca procedurile / site-ul sa o
   gaseasca dupa cod, nu dupa un SYSSID scris in cod:
       SELECT SYSSID FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_QR_MIA'

   Script RE-RULABIL: nu dubleaza valorile, nu schimba SYSSID-urile existente.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    /* codurile valorilor existente (erau fara VALUE_STR) */
    UPDATE TS_SYSS SET VALUE_STR = 'PAY_NONE'  WHERE SYSSID = 5108 AND PARENTID = 26 AND VALUE_STR IS NULL;
    UPDATE TS_SYSS SET VALUE_STR = 'PAY_ECOMM' WHERE SYSSID = 5114 AND PARENTID = 26 AND VALUE_STR IS NULL;
    UPDATE TS_SYSS SET VALUE_STR = 'PAY_POS'   WHERE SYSSID = 5117 AND PARENTID = 26 AND VALUE_STR IS NULL;

    /* valorile noi (SYSSID din SQ_TS_SYSS_SYSSID, prin TRG_TS_SYSS_BI) */
    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_QR_MIA')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'QR MIA', 'PAY_QR_MIA', 1, 0);

    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_CASH')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'Numerar', 'PAY_CASH', 1, 0);

    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_CREDIT0')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'Credit 0%', 'PAY_CREDIT0', 1, 0);

    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_CREDIT')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'Credit cu dobanda', 'PAY_CREDIT', 1, 0);
END^

/* Site-ul pune analitica de plata pe documentul creat de el (Web-Order 134 sau
   cerere de finantare 1791), dupa cod: PAY_QR_MIA la plata MIA QR confirmata,
   PAY_CREDIT0 / PAY_CREDIT la cererea de credit. Documentele create din el
   (oferta, vanzare, incasare) copiaza DTSC de la parinte.
   Doar documentele web (CREATED_BY = 9) si nesterse. SQL SECURITY DEFINER:
   WEBUSER nu are nevoie de drept de UPDATE pe TDB_DOCS. */
CREATE OR ALTER PROCEDURE WEB_SET_DOC_PAYMENT_ANALYTIC (
    A_DOCID INTEGER,
    A_CODE  VARCHAR(32))
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
END^

SET TERM ; ^

COMMIT;

GRANT EXECUTE ON PROCEDURE WEB_SET_DOC_PAYMENT_ANALYTIC TO WEBUSER;
COMMIT;

SELECT s.SYSSID, s.TITLE, t.VALUE_STR FROM SP_GET_ANALITICS_DTSC s
JOIN TS_SYSS t ON t.SYSSID = s.SYSSID
ORDER BY 1;

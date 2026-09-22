/* ============================================================================
   Statistica zilnica a apelurilor primite.

   Intervalul A_DATE_FROM..A_DATE_TO este inclusiv. Procedura intoarce cate un
   rand pentru fiecare zi, inclusiv pentru zilele fara apeluri.

   CALL_STATEID:
     1 = preluat de operatorul randului
     2 = pierdut
     3 = preluat de alt operator

   CALLS_TOTAL include toate apelurile primite din istoric. Din acest motiv,
   apelurile in curs, respinse sau neterminate pot face ca TOTAL sa fie mai mare
   decat MISSED + ANSWERED.
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_PHONE_CALLS_DAILY_STATS (
    A_DATE_FROM DATE,
    A_DATE_TO   DATE)
RETURNS (
    CALL_DATE      DATE,
    CALLS_TOTAL    INTEGER,
    CALLS_MISSED   INTEGER,
    CALLS_ANSWERED INTEGER)
SQL SECURITY DEFINER
AS
DECLARE VARIABLE V_CALL_DATE DATE;
DECLARE VARIABLE V_TOTAL INTEGER;
DECLARE VARIABLE V_MISSED INTEGER;
DECLARE VARIABLE V_ANSWERED INTEGER;
BEGIN
    IF (A_DATE_FROM IS NULL OR A_DATE_TO IS NULL OR A_DATE_FROM > A_DATE_TO) THEN
        EXIT;

    CALL_DATE = A_DATE_FROM;

    FOR SELECT
            CAST(H.DATA AS DATE),
            COUNT(*),
            COALESCE(SUM(IIF(H.CALL_STATEID = 2, 1, 0)), 0),
            COALESCE(SUM(IIF(H.CALL_STATEID IN (1, 3), 1, 0)), 0)
        FROM TS_PHONE_CALLS_HISTORY H
        WHERE H.CALLTYPEID = 0
          AND H.DATA >= :A_DATE_FROM
          AND H.DATA < DATEADD(1 DAY TO :A_DATE_TO)
        GROUP BY CAST(H.DATA AS DATE)
        ORDER BY CAST(H.DATA AS DATE)
        INTO :V_CALL_DATE, :V_TOTAL, :V_MISSED, :V_ANSWERED
    DO
    BEGIN
        WHILE (CALL_DATE < V_CALL_DATE) DO
        BEGIN
            CALLS_TOTAL = 0;
            CALLS_MISSED = 0;
            CALLS_ANSWERED = 0;
            SUSPEND;
            CALL_DATE = DATEADD(1 DAY TO CALL_DATE);
        END

        CALLS_TOTAL = V_TOTAL;
        CALLS_MISSED = V_MISSED;
        CALLS_ANSWERED = V_ANSWERED;
        SUSPEND;
        CALL_DATE = DATEADD(1 DAY TO CALL_DATE);
    END

    WHILE (CALL_DATE <= A_DATE_TO) DO
    BEGIN
        CALLS_TOTAL = 0;
        CALLS_MISSED = 0;
        CALLS_ANSWERED = 0;
        SUSPEND;
        CALL_DATE = DATEADD(1 DAY TO CALL_DATE);
    END
END^

SET TERM ; ^

COMMIT;

/* Exemplu:
   SELECT *
   FROM SP_PHONE_CALLS_DAILY_STATS(DATE '2026-09-01', DATE '2026-09-30');
*/
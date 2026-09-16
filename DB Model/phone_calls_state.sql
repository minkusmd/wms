/* ============================================================================
   Starea apelurilor telefonice (TS_PHONE_CALLS_HISTORY) - stratul 1

   Problema: un apel de intrare sunat in grup si preluat de ALT operator
   ramanea la operatorul curent "pierdut", pentru ca tabela nu avea stare de
   apel - "pierdut" se deducea din lipsa inregistrarii WAV.

   Coloane noi in TS_PHONE_CALLS_HISTORY:
     CALL_STATEID   0 = in curs
                    1 = preluat (de operatorul randului)
                    2 = pierdut / fara raspuns
                    3 = preluat de alt operator (vezi LINKED_CALLID)
                    4 = respins (operatorul a apasat "Ocupat")
                    5 = neterminat (aplicatia s-a inchis in timpul apelului)
     ENDED_AT       cand s-a incheiat apelul
     LINKED_CALLID  randul colegului care a preluat apelul (pentru starea 3)

   Proceduri:
     SP_PHONE_CALL_SET_STATE(CALLID, STATEID)  - apelata de WMS la OnBye
     SP_PHONE_CALL_RESOLVE_MISSED(CALLID)      - coreleaza "pierdut" cu un apel
                                                 preluat de alt operator (acelasi
                                                 numar, +/- 90 s) -> starea 3
     SP_PHONE_CALLS_MAINTENANCE                - de programat in SWNService
                                                 (ex. la 10 min): inchide randurile
                                                 ramase "in curs" si re-coreleaza
                                                 ultimele 2 zile

   VW_TS_PHONE_CALLS_HISTORY primeste coloanele noi la sfarsit.

   Script RE-RULABIL. Completarea istoricului (sectiunea 7) atinge doar
   randurile cu CALL_STATEID = 0 mai vechi de 2 ore, deci la re-rulare nu
   schimba nimic. Pe ~200.000 de randuri dureaza sub un minut.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Coloane ---------------------------------------------------------- */
EXECUTE BLOCK AS
DECLARE VARIABLE CNT INTEGER;
BEGIN
    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_PHONE_CALLS_HISTORY'
        AND TRIM(RDB$FIELD_NAME) = 'CALL_STATEID' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_PHONE_CALLS_HISTORY ADD CALL_STATEID SMALLINT DEFAULT 0 NOT NULL';

    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_PHONE_CALLS_HISTORY'
        AND TRIM(RDB$FIELD_NAME) = 'ENDED_AT' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_PHONE_CALLS_HISTORY ADD ENDED_AT TIMESTAMP';

    SELECT COUNT(*) FROM RDB$RELATION_FIELDS
      WHERE TRIM(RDB$RELATION_NAME) = 'TS_PHONE_CALLS_HISTORY'
        AND TRIM(RDB$FIELD_NAME) = 'LINKED_CALLID' INTO :CNT;
    IF (CNT = 0) THEN
        EXECUTE STATEMENT 'ALTER TABLE TS_PHONE_CALLS_HISTORY ADD LINKED_CALLID INTEGER';
END^

COMMIT WORK^

/* --- 2. Constrangere + index --------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'CHK_TS_PHONE_CALLS_HIST_STATE')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TS_PHONE_CALLS_HISTORY ADD CONSTRAINT CHK_TS_PHONE_CALLS_HIST_STATE
             CHECK (CALL_STATEID IN (0, 1, 2, 3, 4, 5))';

    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TS_PHONE_CALLS_HIST_PHONE')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TS_PHONE_CALLS_HIST_PHONE ON TS_PHONE_CALLS_HISTORY (PHONENUMBER, DATA)';
END^

COMMIT WORK^

/* --- 3. Corelarea "pierdut" -> "preluat de alt operator" ----------------- */
/* CALLID dat: rezolva randul respectiv si, daca el e un apel preluat, randurile
   "pierdute" ale colegilor legate de el. CALLID NULL: ultimele 2 zile.
   Dovada ca un apel a fost preluat: CALL_STATEID = 1 sau are inregistrare WAV
   (randurile vechi, dinaintea acestei coloane). */
CREATE OR ALTER PROCEDURE SP_PHONE_CALL_RESOLVE_MISSED (
    CALLID INTEGER = NULL,
    WINDOW_SEC INTEGER = 90
)
AS
DECLARE VARIABLE ID INTEGER;
DECLARE VARIABLE PHONE VARCHAR(64);
DECLARE VARIABLE USR INTEGER;
DECLARE VARIABLE DT TIMESTAMP;
DECLARE VARIABLE ST SMALLINT;
DECLARE VARIABLE OTHER_ID INTEGER;
BEGIN
    IF (WINDOW_SEC IS NULL) THEN WINDOW_SEC = 90;

    FOR SELECT H.CALLID, H.PHONENUMBER, H.USERID, H.DATA, H.CALL_STATEID
        FROM TS_PHONE_CALLS_HISTORY H
        WHERE H.CALLTYPEID = 0
          AND ((:CALLID IS NOT NULL AND H.CALLID = :CALLID)
            OR (:CALLID IS NULL AND H.CALL_STATEID = 2
                AND H.DATA >= DATEADD(-2 DAY TO CURRENT_TIMESTAMP)))
        INTO :ID, :PHONE, :USR, :DT, :ST
    DO
    BEGIN
        IF (ST = 2) THEN
        BEGIN
            /* pierdut la mine -> a raspuns un coleg? */
            SELECT FIRST 1 O.CALLID
            FROM TS_PHONE_CALLS_HISTORY O
            WHERE O.CALLTYPEID = 0
              AND O.PHONENUMBER = :PHONE
              AND O.USERID <> :USR
              AND O.DATA BETWEEN DATEADD(-:WINDOW_SEC SECOND TO :DT)
                             AND DATEADD( :WINDOW_SEC SECOND TO :DT)
              AND (O.CALL_STATEID = 1
                   OR EXISTS(SELECT 1 FROM TS_PHONE_CALLS_REGISTER R WHERE R.CALLID = O.CALLID))
            ORDER BY ABS(DATEDIFF(SECOND FROM :DT TO O.DATA))
            INTO :OTHER_ID;

            IF (OTHER_ID IS NOT NULL) THEN
                UPDATE TS_PHONE_CALLS_HISTORY
                SET CALL_STATEID = 3, LINKED_CALLID = :OTHER_ID
                WHERE CALLID = :ID;
            OTHER_ID = NULL;
        END
        ELSE IF (ST = 1) THEN
        BEGIN
            /* preluat de mine -> colegii la care a sunat raman "pierdut"? */
            UPDATE TS_PHONE_CALLS_HISTORY O
            SET O.CALL_STATEID = 3, O.LINKED_CALLID = :ID
            WHERE O.CALLTYPEID = 0
              AND O.CALL_STATEID = 2
              AND O.PHONENUMBER = :PHONE
              AND O.USERID <> :USR
              AND O.DATA BETWEEN DATEADD(-:WINDOW_SEC SECOND TO :DT)
                             AND DATEADD( :WINDOW_SEC SECOND TO :DT);
        END
    END
END^

/* --- 4. Setarea starii la OnBye (apelata din WMS) ------------------------ */
CREATE OR ALTER PROCEDURE SP_PHONE_CALL_SET_STATE (
    CALLID INTEGER,
    STATEID SMALLINT
)
AS
BEGIN
    UPDATE TS_PHONE_CALLS_HISTORY
    SET CALL_STATEID = :STATEID,
        ENDED_AT = CURRENT_TIMESTAMP
    WHERE CALLID = :CALLID
      AND CALL_STATEID IN (0, 2);   /* nu suprascriem o stare deja rezolvata (3) */

    IF (STATEID IN (1, 2)) THEN
        EXECUTE PROCEDURE SP_PHONE_CALL_RESOLVE_MISSED(:CALLID);
END^

/* --- 5. Intretinere periodica (SWNService) ------------------------------- */
CREATE OR ALTER PROCEDURE SP_PHONE_CALLS_MAINTENANCE
AS
BEGIN
    /* randuri ramase "in curs" mai mult de 2 ore: aplicatia s-a inchis / a cazut.
       Cu WAV = a fost preluat; fara = neterminat (apel de iesire fara raspuns
       intra tot aici, nu il putem deosebi retroactiv). */
    UPDATE TS_PHONE_CALLS_HISTORY H
    SET H.CALL_STATEID = IIF(EXISTS(SELECT 1 FROM TS_PHONE_CALLS_REGISTER R WHERE R.CALLID = H.CALLID), 1, 5),
        H.ENDED_AT = COALESCE(H.ENDED_AT, H.DATA)
    WHERE H.CALL_STATEID = 0
      AND H.DATA < DATEADD(-2 HOUR TO CURRENT_TIMESTAMP);

    /* apelurile de intrare "neterminate" fara WAV sunt de fapt pierdute */
    UPDATE TS_PHONE_CALLS_HISTORY H
    SET H.CALL_STATEID = 2
    WHERE H.CALL_STATEID = 5 AND H.CALLTYPEID = 0
      AND H.DATA >= DATEADD(-2 DAY TO CURRENT_TIMESTAMP);

    EXECUTE PROCEDURE SP_PHONE_CALL_RESOLVE_MISSED(NULL);
END^

/* --- 6. Vederea (coloanele existente raman neschimbate, se adauga la final) */
CREATE OR ALTER VIEW VW_TS_PHONE_CALLS_HISTORY (
    CALLID, USERID, USER_NAME, DATA, CALLTYPEID, PHONENUMBER, DOCID,
    CUSTOMERID, CUSTOMER_NAME, NICKNAME,
    CALL_STATEID, CALL_STATE_NAME, LINKED_CALLID, ANSWERED_BY, ENDED_AT
)
AS
SELECT
    P.CALLID,
    P.USERID,
    U.FIRST_NAME || ' ' || U.LAST_NAME,
    P.DATA,
    P.CALLTYPEID,
    P.PHONENUMBER,
    P.DOCID,
    P.CUSTOMERID,
    C.DISPLAYNAME,
    P.NICKNAME,
    P.CALL_STATEID,
    CASE P.CALL_STATEID
        WHEN 0 THEN 'In curs'
        WHEN 1 THEN 'Preluat'
        WHEN 2 THEN IIF(P.CALLTYPEID = 0, 'Pierdut', 'Fara raspuns')
        WHEN 3 THEN 'Preluat de coleg'
        WHEN 4 THEN 'Respins'
        WHEN 5 THEN 'Neterminat'
    END,
    P.LINKED_CALLID,
    (SELECT LU.FULL_NAME FROM TS_PHONE_CALLS_HISTORY L
       JOIN TS_USERS LU ON LU.USERID = L.USERID
      WHERE L.CALLID = P.LINKED_CALLID),
    P.ENDED_AT
FROM TS_PHONE_CALLS_HISTORY P
LEFT OUTER JOIN TS_CUSTOMER C ON C.CUSTOMERID = P.CUSTOMERID
INNER JOIN TS_USERS U ON U.USERID = P.USERID^

COMMIT WORK^

/* --- 7. Completarea istoricului (o singura data; re-rularea nu schimba nimic) */
EXECUTE BLOCK AS
BEGIN
    /* tot ce e mai vechi de 2 ore si nu are stare: WAV = preluat, altfel pierdut */
    UPDATE TS_PHONE_CALLS_HISTORY H
    SET H.CALL_STATEID = IIF(EXISTS(SELECT 1 FROM TS_PHONE_CALLS_REGISTER R WHERE R.CALLID = H.CALLID), 1, 2),
        H.ENDED_AT = H.DATA
    WHERE H.CALL_STATEID = 0
      AND H.DATA < DATEADD(-2 HOUR TO CURRENT_TIMESTAMP);

    /* corelarea pe tot istoricul: pierdut la unul, preluat la altul in +/- 90 s */
    UPDATE TS_PHONE_CALLS_HISTORY H
    SET H.CALL_STATEID = 3,
        H.LINKED_CALLID = (SELECT FIRST 1 O.CALLID FROM TS_PHONE_CALLS_HISTORY O
                           WHERE O.CALLTYPEID = 0 AND O.PHONENUMBER = H.PHONENUMBER AND O.USERID <> H.USERID
                             AND O.DATA BETWEEN DATEADD(-90 SECOND TO H.DATA) AND DATEADD(90 SECOND TO H.DATA)
                             AND O.CALL_STATEID = 1
                           ORDER BY ABS(DATEDIFF(SECOND FROM H.DATA TO O.DATA)))
    WHERE H.CALLTYPEID = 0
      AND H.CALL_STATEID = 2
      AND H.LINKED_CALLID IS NULL
      AND EXISTS(SELECT 1 FROM TS_PHONE_CALLS_HISTORY O
                 WHERE O.CALLTYPEID = 0 AND O.PHONENUMBER = H.PHONENUMBER AND O.USERID <> H.USERID
                   AND O.DATA BETWEEN DATEADD(-90 SECOND TO H.DATA) AND DATEADD(90 SECOND TO H.DATA)
                   AND O.CALL_STATEID = 1);
END^

SET TERM ; ^

COMMIT;

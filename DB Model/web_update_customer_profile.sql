/* ============================================================================
   Pagina "Contul meu" de pe site (/contul-meu): salvarea datelor personale

   WEB_UPDATE_CUSTOMER_INFO (vechea procedura, apelata pina acum de site)
   salva de fapt doar data nasterii si adauga telefonul mobil ca numar nou:
   liniile pentru adresa/oras erau comentate, telefonul fix nu se scria deloc,
   iar numele si e-mailul nu se puteau schimba din pagina.

   WEB_UPDATE_CUSTOMER_PROFILE(CUSTOMERID, SITEID, FULL_NAME, EMAIL,
                               BIRTH_DATE, CITY_ID, ADDRESS, MOBILE, LAND_PHONE)
     RESULT:
       OK            totul salvat
       EMAIL_EXISTS  e-mailul e deja folosit de alt cont activ al aceluiasi
                     site (TS_CUST_WEB.LOGIN sau TS_CUST_WEB.EMAIL) - nimic
                     nu se salveaza
       NOT_FOUND     clientul nu are cont web
     - FULL_NAME -> TS_CUSTOMER.NAME (doar daca difera: trigger-ul AU reface
       dictionarul clientului);
     - EMAIL -> TS_CUST_WEB.EMAIL; LOGIN-ul se schimba si el daca era vechiul
       e-mail sau login-ul sintetic guest_<tel>@... din popup-ul "Cadou de bun
       venit" (altfel clientul nu s-ar mai putea autentifica cu e-mailul nou);
       in TS_CUST_EMAILS randul cu vechiul e-mail se inlocuieste, iar daca nu
       exista se adauga unul nou;
     - BIRTH_DATE / CITY_ID / ADDRESS -> TS_CUST_INFO;
     - MOBILE (tip 7468) / LAND_PHONE (tip 7470) -> TS_CUST_PHONES: un numar
       deja existent nu se dubleaza; daca clientul are exact un numar de acel
       tip, acela se inlocuieste; altfel se adauga. Gol = nu se atinge.
     Parametrii goi ('' / NULL) pentru nume si e-mail lasa valoarea veche.

   Apelata de site (utilizatorul WEBUSER), models/User::updateUserProfile.
   Pina la rularea scriptului site-ul foloseste vechea procedura si arata
   numele si e-mailul doar in citire.

   Script RE-RULABIL (15.10.2026).
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE (
    CUSTOMERID INTEGER,
    SITEID     INTEGER,
    FULL_NAME  VARCHAR(255),
    EMAIL      VARCHAR(60),
    BIRTH_DATE DATE,
    CITY_ID    INTEGER,
    ADDRESS    VARCHAR(255),
    MOBILE     VARCHAR(16),
    LAND_PHONE VARCHAR(16))
RETURNS (
    RESULT VARCHAR(16))
AS
    DECLARE VARIABLE OLD_EMAIL VARCHAR(128);
    DECLARE VARIABLE OLD_LOGIN VARCHAR(60);
    DECLARE VARIABLE CNT       INTEGER;
BEGIN
    FULL_NAME  = NULLIF(TRIM(FULL_NAME), '');
    EMAIL      = NULLIF(LOWER(TRIM(EMAIL)), '');
    ADDRESS    = TRIM(COALESCE(ADDRESS, ''));
    MOBILE     = NULLIF(TRIM(MOBILE), '');
    LAND_PHONE = NULLIF(TRIM(LAND_PHONE), '');

    OLD_EMAIL = NULL;
    OLD_LOGIN = NULL;
    SELECT FIRST 1 TRIM(W.EMAIL), TRIM(W.LOGIN)
      FROM TS_CUST_WEB W
     WHERE W.CUSTOMERID = :CUSTOMERID
      INTO :OLD_EMAIL, :OLD_LOGIN;
    IF (OLD_LOGIN IS NULL) THEN
    BEGIN
        RESULT = 'NOT_FOUND';
        SUSPEND;
        EXIT;
    END

    /* e-mailul nou nu are voie sa fie login-ul / e-mailul altui cont activ */
    IF (EMAIL IS NOT NULL AND LOWER(COALESCE(OLD_EMAIL, '')) <> EMAIL) THEN
    BEGIN
        IF (EXISTS (SELECT 1 FROM TS_CUST_WEB W
                     WHERE W.CUSTOMERID <> :CUSTOMERID
                       AND W.FLG_ENABLED = 1
                       AND (:SITEID IS NULL OR W.SITEID = :SITEID)
                       AND (LOWER(W.LOGIN) = :EMAIL OR LOWER(W.EMAIL) = :EMAIL))) THEN
        BEGIN
            RESULT = 'EMAIL_EXISTS';
            SUSPEND;
            EXIT;
        END

        UPDATE TS_CUST_WEB W
           SET W.EMAIL = :EMAIL,
               W.LOGIN = IIF(LOWER(W.LOGIN) = LOWER(COALESCE(:OLD_EMAIL, ''))
                             OR LOWER(W.LOGIN) STARTING WITH 'guest_',
                             :EMAIL, W.LOGIN)
         WHERE W.CUSTOMERID = :CUSTOMERID;

        UPDATE TS_CUST_EMAILS E
           SET E.EMAIL = :EMAIL
         WHERE E.CUSTOMERID = :CUSTOMERID
           AND LOWER(E.EMAIL) = LOWER(COALESCE(:OLD_EMAIL, ''));
        IF (ROW_COUNT = 0 AND NOT EXISTS (SELECT 1 FROM TS_CUST_EMAILS E
                                           WHERE E.CUSTOMERID = :CUSTOMERID
                                             AND LOWER(E.EMAIL) = :EMAIL)) THEN
            INSERT INTO TS_CUST_EMAILS (EMAIL, CUSTOMERID) VALUES (:EMAIL, :CUSTOMERID);
    END

    IF (FULL_NAME IS NOT NULL) THEN
        UPDATE TS_CUSTOMER C
           SET C.NAME = :FULL_NAME
         WHERE C.CUSTOMERID = :CUSTOMERID
           AND C.NAME IS DISTINCT FROM :FULL_NAME;

    UPDATE OR INSERT INTO TS_CUST_INFO (CUSTOMERID, BIRTH_DATE, CITY_ID, ADDRESS)
    VALUES (:CUSTOMERID, :BIRTH_DATE, :CITY_ID, :ADDRESS)
    MATCHING (CUSTOMERID);

    /* telefon mobil (7468) */
    IF (MOBILE IS NOT NULL AND NOT EXISTS (SELECT 1 FROM TS_CUST_PHONES P
                                            WHERE P.CUSTOMERID = :CUSTOMERID
                                              AND P.PHONETYPEID = 7468
                                              AND P.PHONENUMBER = :MOBILE)) THEN
    BEGIN
        SELECT COUNT(*) FROM TS_CUST_PHONES P
         WHERE P.CUSTOMERID = :CUSTOMERID AND P.PHONETYPEID = 7468
          INTO :CNT;
        IF (CNT = 1) THEN
            UPDATE TS_CUST_PHONES P SET P.PHONENUMBER = :MOBILE
             WHERE P.CUSTOMERID = :CUSTOMERID AND P.PHONETYPEID = 7468;
        ELSE
            INSERT INTO TS_CUST_PHONES (CUSTOMERID, PHONETYPEID, PHONENUMBER)
            VALUES (:CUSTOMERID, 7468, :MOBILE);
    END

    /* telefon fix (7470) */
    IF (LAND_PHONE IS NOT NULL AND NOT EXISTS (SELECT 1 FROM TS_CUST_PHONES P
                                                WHERE P.CUSTOMERID = :CUSTOMERID
                                                  AND P.PHONETYPEID = 7470
                                                  AND P.PHONENUMBER = :LAND_PHONE)) THEN
    BEGIN
        SELECT COUNT(*) FROM TS_CUST_PHONES P
         WHERE P.CUSTOMERID = :CUSTOMERID AND P.PHONETYPEID = 7470
          INTO :CNT;
        IF (CNT = 1) THEN
            UPDATE TS_CUST_PHONES P SET P.PHONENUMBER = :LAND_PHONE
             WHERE P.CUSTOMERID = :CUSTOMERID AND P.PHONETYPEID = 7470;
        ELSE
            INSERT INTO TS_CUST_PHONES (CUSTOMERID, PHONETYPEID, PHONENUMBER)
            VALUES (:CUSTOMERID, 7470, :LAND_PHONE);
    END

    RESULT = 'OK';
    SUSPEND;
END^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE TO SWN;

/* Tabelele scrise de procedura (de regula WEBUSER le are deja). */
GRANT SELECT, UPDATE ON TS_CUST_WEB TO PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE;
GRANT SELECT, INSERT, UPDATE ON TS_CUST_EMAILS TO PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE;
GRANT SELECT, UPDATE ON TS_CUSTOMER TO PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE;
GRANT SELECT, INSERT, UPDATE ON TS_CUST_INFO TO PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE;
GRANT SELECT, INSERT, UPDATE ON TS_CUST_PHONES TO PROCEDURE WEB_UPDATE_CUSTOMER_PROFILE;

COMMIT;

/* ============================================================================
   Utilizatorul WMS tehnic "CurieriWMS" - autorul documentelor create din
   aplicatia soferilor (Intrare marfa 106 la inchiderea preluarii).
   Decizia proprietarului (2026-10-10): utilizator nou, cu perioada deschisa.

   Se ruleaza DUPA dispatch_logistics.sql. Script RE-RULABIL.

   - Grupul "CurieriWMS (tehnic)": fara drepturi (STRUCTURE_MASK = 0, FLAGS = 0).
     GROUPID se alege explicit intre 1 si 31: perioadele (TDB_OPEN_PERIODS.ACC$MASK,
     INTEGER) au cate un bit pe grup, iar generatorul grupurilor e deja peste 31.
     Se ia primul GROUPID nefolosit al carui bit nu apare in nicio perioada.
   - Utilizatorul "CurieriWMS": parola = hash aleator, deci nimeni nu se poate
     autentifica cu el in SWN.exe; nu e in lista fixa (1, 9, 204, 196) din
     GET_QUICK_ACCESS_PERIOD, accesul la perioada vine din grup.
   - Perioada "CurieriWMS (tehnic)": 2026-01-01 .. 2027-12-31, doar bitul grupului.
     Se prelungeste ca celelalte perioade (DATA2).
   - TS_DISPATCH_SETTINGS: firma operativa 316910 (SOLUTII COMERCIALE), depozitul
     de baza 43, WEB_USERID = utilizatorul tehnic, folderul depozitelor masinilor
     146 "Depozite mobile" (decizia proprietarului 2026-10-10). Depozitul de baza
     si utilizatorul se pot schimba din WMS (Dispecerat > Curieri...).
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
DECLARE VARIABLE V_GROUP INTEGER;
DECLARE VARIABLE V_USERID INTEGER;
DECLARE VARIABLE V_I INTEGER = 1;
DECLARE VARIABLE V_BIT INTEGER;
BEGIN
    /* 1. grupul tehnic */
    SELECT FIRST 1 GROUPID FROM TS_USER_GROUPS WHERE NAME = 'CurieriWMS (tehnic)' INTO :V_GROUP;
    IF (V_GROUP IS NULL) THEN
    BEGIN
        WHILE (V_I <= 31 AND V_GROUP IS NULL) DO
        BEGIN
            V_BIT = BIN_SHL(1, V_I - 1);
            IF (NOT EXISTS(SELECT 1 FROM TS_USER_GROUPS WHERE GROUPID = :V_I)
                AND NOT EXISTS(SELECT 1 FROM TS_USER_GROUP_LINKS WHERE GROUPID = :V_I)
                AND NOT EXISTS(SELECT 1 FROM TDB_OPEN_PERIODS WHERE BIN_AND(COALESCE(ACC$MASK, 0), :V_BIT) <> 0)) THEN
                V_GROUP = V_I;
            V_I = V_I + 1;
        END
        IF (V_GROUP IS NULL) THEN
            EXCEPTION ERR_GENERAL_ERROR 'Nu exista un GROUPID liber intre 1 si 31 pentru grupul tehnic CurieriWMS';
        INSERT INTO TS_USER_GROUPS (GROUPID, NAME, STRUCTURE_MASK, FLAGS)
        VALUES (:V_GROUP, 'CurieriWMS (tehnic)', 0, 0);
    END

    /* 2. utilizatorul tehnic (parola aleatoare: nu se poate autentifica) */
    SELECT FIRST 1 USERID FROM TS_USERS WHERE UPPER(LOGIN_NAME) = 'CURIERIWMS' INTO :V_USERID;
    IF (V_USERID IS NULL) THEN
        INSERT INTO TS_USERS (LOGIN_NAME, FIRST_NAME, LAST_NAME, FULL_NAME, DESCRIPTION, BIRTHDAY,
                              PASSWORD_HASH, FLAGS, CUSTOMERID)
        VALUES ('CurieriWMS', 'CurieriWMS', 'Aplicatia soferilor', 'CurieriWMS (aplicatia soferilor)',
                'Utilizator tehnic: autorul documentelor create din aplicatia soferilor. Nu se autentifica.',
                DATE '2000-01-01',
                LEFT(LOWER(HEX_ENCODE(CRYPT_HASH(UUID_TO_CHAR(GEN_UUID()) USING SHA256))), 32),
                0, -1)
        RETURNING USERID INTO :V_USERID;

    /* 3. membru al grupului tehnic */
    IF (NOT EXISTS(SELECT 1 FROM TS_USER_GROUP_LINKS WHERE USERID = :V_USERID AND GROUPID = :V_GROUP)) THEN
        INSERT INTO TS_USER_GROUP_LINKS (USERID, GROUPID) VALUES (:V_USERID, :V_GROUP);

    /* 4. perioada deschisa doar pentru grupul tehnic */
    IF (NOT EXISTS(SELECT 1 FROM TDB_OPEN_PERIODS WHERE DESCRIPTION = 'CurieriWMS (tehnic)')) THEN
        INSERT INTO TDB_OPEN_PERIODS (DATA1, DATA2, ACC$MASK, DESCRIPTION)
        VALUES (DATE '2026-01-01', DATE '2027-12-31', BIN_SHL(1, :V_GROUP - 1), 'CurieriWMS (tehnic)');

    /* 5. setarile dispeceratului pentru firma operativa: depozitul de baza 43,
          utilizatorul tehnic, folderul depozitelor masinilor 146 "Depozite mobile" */
    UPDATE OR INSERT INTO TS_DISPATCH_SETTINGS (FIRMAID, BASE_STOCKID, WEB_USERID, COURIER_STOCK_FOLDERID)
    VALUES (316910, 43, :V_USERID, 146)
    MATCHING (FIRMAID);
END^

SET TERM ; ^

COMMIT;

/* Verificare (dupa rulare): CAN_WORK = 1 pentru utilizatorul tehnic */
/*
SELECT U.USERID, G.GROUPID, P.DATA1, P.DATA2, P.ACC$MASK
FROM TS_USERS U
JOIN TS_USER_GROUP_LINKS L ON L.USERID = U.USERID
JOIN TS_USER_GROUPS G ON G.GROUPID = L.GROUPID
JOIN TDB_OPEN_PERIODS P ON BIN_AND(P.ACC$MASK, BIN_SHL(1, G.GROUPID - 1)) <> 0
WHERE UPPER(U.LOGIN_NAME) = 'CURIERIWMS';
*/

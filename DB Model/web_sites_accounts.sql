/*
  Site-urile web (fantastic.md, tehnomarket.md, viitoarele satelite) si conturile
  clientilor separate pe site.

  Problema: TS_CUST_WEB (contul de pe site: LOGIN + PASSWORD_HASH) nu stie pe ce
  site a fost creat. Cu aceeasi baza SW, un client inregistrat pe fantastic.md se
  putea autentifica pe tehnomarket.md, iar inregistrarea cu acelasi e-mail era
  refuzata. La fel login-ul social (TS_SM_USERS) si conturile de invitat create la
  comanda rapida.

  Ce face scriptul:
    1. TWEB_SITE                  - lista site-urilor: cod (= cheia brandului din
                                    config/brands/<cod>.php), domeniu, firma din ERP pe
                                    care intra comenzile, mapele din TS_CUSTOMER in care
                                    se creeaza clientii site-ului.
    2. TS_CUST_WEB.SITEID         - site-ul contului; conturile existente = 1 (fantastic).
                                    Index (SITEID, LOGIN). LOGIN NU e unic nici azi
                                    (24 414 conturi, 24 196 login-uri distincte), de aceea
                                    nu se pune unicitate; o verifica site-ul la inregistrare.
    3. TS_SM_USERS.SITEID         - login-ul social (Google/Facebook), la fel.
    4. VW_TS_CUST_WEB             - view-ul folosit de WMS (frmCustomerWebDlg) primeste
                                    coloana SITEID; triggerele lui o scriu (implicit 1).
    5. WEB_CREATE_NEW_CUSTOMER4   - ca WEB_CREATE_NEW_CUSTOMER3, plus SITEID: contul
                                    primeste site-ul, clientul intra in mapa site-ului.
    6. CREATE_CUSTOMER_WEB_CREDENTIALS2 - contul de invitat (comanda rapida), pe site:
                                    telefonul se cauta doar printre clientii fara cont pe
                                    alt site, iar un client care are deja cont pe acest
                                    site nu mai primeste unul.
    7. CHECK_IF_CUSTOMER_EXISTS2  - verificarea "e deja inregistrat" (abonari), pe site.
    8. Mapele TS_CUSTOMER pentru tehnomarket ("Din Internet - Tehnomarket" si
       "Persoane fizice - Tehnomarket"), create dupa modelul mapelor 99 si 247386.

  Procedurile vechi (…3, CREATE_CUSTOMER_WEB_CREDENTIALS, CHECK_IF_CUSTOMER_EXISTS)
  ramin neschimbate: site-ul le mai foloseste pina la rularea acestui script
  (detecteaza coloana TS_CUST_WEB.SITEID), apoi trece singur pe cele noi.

  Ce NU separa scriptul: clientul din ERP (TS_CUSTOMER) ramine comun. Comenzile
  rapide care cauta clientul dupa telefon in proceduri (WEB_CREATE_TRANSACTION_PHONE2
  etc.) leaga in continuare comanda de clientul gasit dupa telefon, indiferent de site.

  Re-rulabil. Firebird 5.
  NEURON Grup SRL, 4 octombrie 2026
*/

SET TERM ^ ;

/* ------------------------------------------------------------------ 1. TWEB_SITE */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_SITE')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_SITE (
         SITEID             DM_INTEGER NOT NULL,
         CODE               DM_VARCHAR32 NOT NULL,
         NAME               DM_VARCHAR128,
         DOMAIN             DM_VARCHAR128,
         FIRMA              DM_INTEGER,
         CUSTOMER_FOLDERID  DM_INTEGER DEFAULT 99 NOT NULL,
         GUEST_FOLDERID     DM_INTEGER DEFAULT 247386 NOT NULL,
         FLG_ACTIVE         DM_BOOLEAN_NN DEFAULT 1,
         CONSTRAINT PK_TWEB_SITE PRIMARY KEY (SITEID),
         CONSTRAINT UNQ_TWEB_SITE_CODE UNIQUE (CODE)
       )';
END ^

SET TERM ; ^
COMMIT;

COMMENT ON TABLE TWEB_SITE IS 'Site-urile web care lucreaza pe aceasta baza (fantastic.md, tehnomarket.md, ...)';
COMMENT ON COLUMN TWEB_SITE.CODE IS 'Cheia brandului din fantastic.web/config/brands/<cod>.php';
COMMENT ON COLUMN TWEB_SITE.FIRMA IS 'Firma (TS_CUSTOMER) pe care intra comenzile site-ului';
COMMENT ON COLUMN TWEB_SITE.CUSTOMER_FOLDERID IS 'Mapa TS_CUSTOMER in care se creeaza clientii inregistrati pe site';
COMMENT ON COLUMN TWEB_SITE.GUEST_FOLDERID IS 'Mapa TS_CUSTOMER in care se creeaza clientii de la comanda rapida';
COMMIT;

UPDATE OR INSERT INTO TWEB_SITE (SITEID, CODE, NAME, DOMAIN, FIRMA)
VALUES (1, 'fantastic', 'Fantastic.md', 'www.fantastic.md', 316910)
MATCHING (SITEID);

UPDATE OR INSERT INTO TWEB_SITE (SITEID, CODE, NAME, DOMAIN, FIRMA)
VALUES (2, 'tehnomarket', 'Tehnomarket.md', 'www.tehnomarket.md', 317087)
MATCHING (SITEID);
COMMIT;

/* ------------------------------------------------------------------ 8. mapele tehnomarket */
SET TERM ^ ;

/* Fiecare site in afara de fantastic.md (1) care inca foloseste mapele comune primeste
   mapele lui: "Din Internet - <Nume>" (dupa modelul mapei 99) si
   "PERSOANA FIZICE - <NUME>" (dupa modelul mapei 247386). Un site adaugat ulterior in
   TWEB_SITE le primeste la urmatoarea rulare a scriptului. */
EXECUTE BLOCK AS
  DECLARE VARIABLE SITE_ID   DM_INTEGER;
  DECLARE VARIABLE SITE_NAME DM_VARCHAR128;
  DECLARE VARIABLE FOLDER_ID DM_INTEGER;
  DECLARE VARIABLE F_NAME    DM_VARCHAR255;
  DECLARE VARIABLE P_ID      DM_INTEGER;
  DECLARE VARIABLE P_TYPE    DM_INTEGER;
  DECLARE VARIABLE P_STATUS  DM_INTEGER;
BEGIN
  FOR SELECT SITEID, COALESCE(NULLIF(TRIM(NAME), ''), CODE) FROM TWEB_SITE
       WHERE SITEID <> 1 AND (CUSTOMER_FOLDERID = 99 OR GUEST_FOLDERID = 247386)
        INTO :SITE_ID, :SITE_NAME
  DO
  BEGIN
    /* clientii inregistrati */
    F_NAME = 'Din Internet - ' || :SITE_NAME;
    FOLDER_ID = NULL;
    SELECT FIRST 1 CUSTOMERID FROM TS_CUSTOMER WHERE FLG_FOLDER = 1 AND NAME = :F_NAME INTO :FOLDER_ID;
    IF (FOLDER_ID IS NULL) THEN
    BEGIN
      SELECT PARENTID, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID FROM TS_CUSTOMER WHERE CUSTOMERID = 99
        INTO :P_ID, :P_TYPE, :P_STATUS;
      INSERT INTO TS_CUSTOMER (PARENTID, FLG_FOLDER, NAME, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID, USERID)
      VALUES (:P_ID, 1, :F_NAME, :P_TYPE, :P_STATUS, 9)
      RETURNING CUSTOMERID INTO :FOLDER_ID;
    END
    UPDATE TWEB_SITE SET CUSTOMER_FOLDERID = :FOLDER_ID WHERE SITEID = :SITE_ID AND CUSTOMER_FOLDERID = 99;

    /* clientii de la comanda rapida */
    F_NAME = 'PERSOANA FIZICE - ' || UPPER(:SITE_NAME);
    FOLDER_ID = NULL;
    SELECT FIRST 1 CUSTOMERID FROM TS_CUSTOMER WHERE FLG_FOLDER = 1 AND NAME = :F_NAME INTO :FOLDER_ID;
    IF (FOLDER_ID IS NULL) THEN
    BEGIN
      SELECT PARENTID, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID FROM TS_CUSTOMER WHERE CUSTOMERID = 247386
        INTO :P_ID, :P_TYPE, :P_STATUS;
      INSERT INTO TS_CUSTOMER (PARENTID, FLG_FOLDER, NAME, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID, USERID)
      VALUES (:P_ID, 1, :F_NAME, :P_TYPE, :P_STATUS, 9)
      RETURNING CUSTOMERID INTO :FOLDER_ID;
    END
    UPDATE TWEB_SITE SET GUEST_FOLDERID = :FOLDER_ID WHERE SITEID = :SITE_ID AND GUEST_FOLDERID = 247386;
  END
END ^

/* ------------------------------------------------------------------ 2. TS_CUST_WEB.SITEID */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_CUST_WEB' AND RDB$FIELD_NAME = 'SITEID')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_CUST_WEB ADD SITEID DM_INTEGER DEFAULT 1 NOT NULL';
END ^

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                 WHERE RDB$RELATION_NAME = 'TS_CUST_WEB' AND RDB$CONSTRAINT_NAME = 'FK_TS_CUST_WEB_SITE')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_CUST_WEB ADD CONSTRAINT FK_TS_CUST_WEB_SITE
                         FOREIGN KEY (SITEID) REFERENCES TWEB_SITE (SITEID)';
  IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'TS_CUST_WEB_IDX_SITE_LOGIN')) THEN
    EXECUTE STATEMENT 'CREATE INDEX TS_CUST_WEB_IDX_SITE_LOGIN ON TS_CUST_WEB (SITEID, LOGIN)';
END ^

/* ------------------------------------------------------------------ 3. TS_SM_USERS.SITEID */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_SM_USERS' AND RDB$FIELD_NAME = 'SITEID')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_SM_USERS ADD SITEID DM_INTEGER DEFAULT 1 NOT NULL';
END ^

SET TERM ; ^
COMMIT;

COMMENT ON COLUMN TS_CUST_WEB.SITEID IS 'Site-ul pe care a fost creat contul (TWEB_SITE); 1 = fantastic.md';
COMMENT ON COLUMN TS_SM_USERS.SITEID IS 'Site-ul pe care s-a facut login-ul social (TWEB_SITE); 1 = fantastic.md';
COMMIT;

/* ------------------------------------------------------------------ 4. VW_TS_CUST_WEB */
CREATE OR ALTER VIEW VW_TS_CUST_WEB (
    CUSTOMERID, LOGIN, PASSWORD_HASH, EMAIL, REG_DATE, PREFFERED_LANGUAGE, FLG_ENABLED,
    FLG_NO_COMERCIALS, FLG_VIEW_REAL_STOCKS, FLG_NPSC, FLG_EDIT_GOODS, FLG_NO_FACEBOOK,
    FLG_NO_CHAT, FLG_PRICE_BY_CLIENT, FLG_PRICE_USD, FLG_NO_CREDIT, FLG_NO_ADDS_GOODS,
    SITEID)
AS
SELECT
    CUSTOMERID,
    LOGIN,
    PASSWORD_HASH,
    EMAIL,
    REG_DATE,
    PREFFERED_LANGUAGE,
    FLG_ENABLED,
    GET_FLG_VALUE(FLAGS,0),
    GET_FLG_VALUE(FLAGS,1),
    GET_FLG_VALUE(FLAGS,2),
    GET_FLG_VALUE(FLAGS,3),
    GET_FLG_VALUE(FLAGS,4), -- FLG_NO_FACEBOOK
    GET_FLG_VALUE(FLAGS,5), -- FLG_NO_CHAT
    GET_FLG_VALUE(FLAGS,6), -- FLG_PRICE_BY_CLIENT
    GET_FLG_VALUE(FLAGS,7), -- FLG_PRICE_USD
    GET_FLG_VALUE(FLAGS,8), -- FLG_NO_CREDIT
    GET_FLG_VALUE(FLAGS,9), -- FLG_NO_ADDS_GOODS
    SITEID
FROM TS_CUST_WEB;
COMMIT;

SET TERM ^ ;

CREATE OR ALTER TRIGGER VW_TS_CUST_WEB_BI FOR VW_TS_CUST_WEB
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable tmpFLAGS DM_INTEGER;
BEGIN
     tmpFLAGS = 0;
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,0, NEW.FLG_NO_COMERCIALS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,1, NEW.FLG_VIEW_REAL_STOCKS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,2, NEW.FLG_NPSC);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,3, NEW.FLG_EDIT_GOODS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,4, NEW.FLG_NO_FACEBOOK);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,5, NEW.FLG_NO_CHAT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,6, NEW.FLG_PRICE_BY_CLIENT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,7, NEW.FLG_PRICE_USD);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,8, NEW.FLG_NO_CREDIT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,9, NEW.FLG_NO_ADDS_GOODS);

  INSERT INTO TS_CUST_WEB (
    CUSTOMERID,
    LOGIN,
    EMAIL,
    PASSWORD_HASH,
    REG_DATE,
    PREFFERED_LANGUAGE,
    FLG_ENABLED,
    FLAGS,
    SITEID)
  VALUES (
    NEW.CUSTOMERID,
    NEW.LOGIN,
    NEW.EMAIL,
    NEW.PASSWORD_HASH,
    NEW.REG_DATE,
    NEW.PREFFERED_LANGUAGE,
    NEW.FLG_ENABLED,
    :tmpFLAGS,
    COALESCE(NEW.SITEID, 1));
END ^

CREATE OR ALTER TRIGGER VW_TS_CUST_WEB_BU FOR VW_TS_CUST_WEB
ACTIVE BEFORE UPDATE POSITION 0
AS
declare variable tmpFLAGS DM_INTEGER;
BEGIN
     tmpFLAGS = 0;
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,0, NEW.FLG_NO_COMERCIALS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,1, NEW.FLG_VIEW_REAL_STOCKS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,2, NEW.FLG_NPSC);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,3, NEW.FLG_EDIT_GOODS);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,4, NEW.FLG_NO_FACEBOOK);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,5, NEW.FLG_NO_CHAT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,6, NEW.FLG_PRICE_BY_CLIENT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,7, NEW.FLG_PRICE_USD);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,8, NEW.FLG_NO_CREDIT);
     tmpFLAGS = SET_FLG_VALUE(tmpFLAGS,9, NEW.FLG_NO_ADDS_GOODS);

     UPDATE or INSERT into TS_CUST_WEB (CUSTOMERID, LOGIN, EMAIL, PASSWORD_HASH, REG_DATE, PREFFERED_LANGUAGE, FLG_ENABLED, FLAGS, SITEID)
     values(NEW.CUSTOMERID,NEW.LOGIN, NEW.EMAIL, NEW.PASSWORD_HASH,NEW.REG_DATE,new.PREFFERED_LANGUAGE,NEW.FLG_ENABLED,:tmpFLAGS, COALESCE(NEW.SITEID, OLD.SITEID, 1))
     matching (customerid);
END ^

/* ------------------------------------------------------------------ 5. WEB_CREATE_NEW_CUSTOMER4 */
CREATE OR ALTER PROCEDURE WEB_CREATE_NEW_CUSTOMER4 (
    EMAIL            DM_VARCHAR60 NOT NULL,
    FULL_NAME        DM_VARCHAR128 NOT NULL,
    PASS_HASH        DM_VARCHAR60 NOT NULL,
    PHONE_MOBILE     DM_VARCHAR60 NOT NULL,
    PHONE_LAND       DM_VARCHAR60 NOT NULL,
    FLG_NEWS         DM_BOOLEAN_NN,
    FLG_LANG_RUSSIAN DM_BOOLEAN_NN,
    SITEID           DM_INTEGER = 1)
RETURNS (CUSTOMERID DM_INTEGER)
AS
  declare variable TMPFLAGS DM_INTEGER;
  declare variable FOLDERID DM_INTEGER;
begin
  /* Ca WEB_CREATE_NEW_CUSTOMER3, dar contul si clientul apartin site-ului :SITEID. */
  SELECT CUSTOMER_FOLDERID FROM TWEB_SITE WHERE SITEID = :SITEID INTO :FOLDERID;
  FOLDERID = COALESCE(:FOLDERID, 99);

  /* 1. create Customer record, into folder-ul site-ului ("(99) Internet" pentru fantastic) */
  insert into TS_CUSTOMER (PARENTID, FLG_FOLDER, PREFIXNAME, NAME, SUFIXNAME, CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID, USERID)
  values (:FOLDERID, 0, null, :FULL_NAME, null, 4010, 4101, 9)
  returning CUSTOMERID
  into :CUSTOMERID;

  /* 2. create Web-Login record */
  insert into TS_CUST_WEB (CUSTOMERID, LOGIN, PASSWORD_HASH, FLG_ENABLED, EMAIL, SITEID)
  values (:CUSTOMERID, :EMAIL, :PASS_HASH, 1, :EMAIL, :SITEID);

  /* 3. create Customer Info record */
  TMPFLAGS = 0;
  TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 0, :FLG_LANG_RUSSIAN);
  TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 1, :FLG_NEWS);

  insert into TS_CUST_INFO (CUSTOMERID, REZIDENT, CITY_ID, FLAGS)
  values (:CUSTOMERID, 'R', 2000, :TMPFLAGS);/* Chisinau=2000 */

  if (:PHONE_MOBILE is not null) then begin
    insert into TS_CUST_PHONES (CUSTOMERID, PHONETYPEID, PHONENUMBER)
    values (:CUSTOMERID, 7468, :PHONE_MOBILE);
  end
  else begin
    if (exists(select *
               from TS_CUST_PHONES
               where PHONENUMBER = :PHONE_MOBILE)) then exception ERR_WRONG_CUSTOMER_PHONE;
  end

  insert into TS_CUST_EMAILS (CUSTOMERID, EMAIL)
  values (:CUSTOMERID, :EMAIL);

  if (coalesce(:PHONE_LAND, '') <> '') then begin
    insert into TS_CUST_PHONES (CUSTOMERID, PHONETYPEID, PHONENUMBER)
    values (:CUSTOMERID, 7470, :PHONE_LAND);
  end

  suspend;
end ^

/* ------------------------------------------------------------------ 6. CREATE_CUSTOMER_WEB_CREDENTIALS2 */
CREATE OR ALTER PROCEDURE CREATE_CUSTOMER_WEB_CREDENTIALS2 (
    CUSTOMER_NAME        DM_VARCHAR255,
    CUSTOMER_PHONENUMBER DM_VARCHAR16,
    CUSTOMER_EMAIL       DM_VARCHAR128,
    SITEID               DM_INTEGER = 1)
RETURNS (
    CUSTOMERID        DM_INTEGER,
    CUSTOMER_PASSWORD DM_VARCHAR16,
    CUSTOMER_TOKEN    DM_VARCHAR32)
AS
  declare variable FOLDERID DM_INTEGER;
begin
   /* Ca CREATE_CUSTOMER_WEB_CREDENTIALS, dar pe site: telefonul se cauta doar printre
      clientii care nu au cont pe ALT site (un client al fantastic.md nu devine
      clientul tehnomarket.md), clientul nou intra in mapa site-ului, iar un client
      care are deja cont pe acest site nu mai primeste altul. */
   :customerid = -1;
   select first 1 cp.customerid
     from ts_cust_phones cp
    where cp.phonenumber = :customer_phonenumber
      and not exists (select 1 from ts_cust_web w
                       where w.customerid = cp.customerid and w.siteid <> :siteid)
     into :customerid;

   if (customerid = -1) then
   begin
       SELECT GUEST_FOLDERID FROM TWEB_SITE WHERE SITEID = :SITEID INTO :FOLDERID;
       FOLDERID = COALESCE(:FOLDERID, 247386);

       :CUSTOMERID = NEXT VALUE FOR SQ_TS_CUSTOMER_CUSTOMERID;
       insert into TS_CUSTOMER (CUSTOMERID, PARENTID, FLG_FOLDER, PREFIXNAME, NAME, SUFIXNAME, ORG_PARENT_ID, CUSTOMER_TYPE_ID,
                                CUSTOMER_STATUS_ID, VAT, ORDERNO, WEB_STOCK_BIT_INDEX, USERID, FLAGS, CREATED, GENDER)
       values (:CUSTOMERID, :FOLDERID, 0, '', upper(:customer_name), '', -1, 4010,
               4101, 20, 0, -1, 9, 0, current_timestamp, NULL);
       insert into TS_CUST_PHONES (CUSTOMERID, PHONENUMBER, comment, PHONETYPEID, FLAGS)
       values (:CUSTOMERID, :customer_PHONENUMBER, null, 7468, 0);

        insert into ts_cust_emails (email, customerid, unsubscribed, created_date, unsubscribe_date, flg_confirmed)
        values (:customer_email, :customerid, 0, localtimestamp, null, 0);
   end
   else
   begin
      /* update customer_name */
      update ts_customer set name = upper(:customer_name) where customerid = :customerid;
   end

   update or insert into ts_cust_info (customerid, pricecolumn) values (:customerid, 1);

  :customer_password = substring(lpad(cast((rand() * 10000) as integer), 4, '0') from 1 for 4);
  :customer_token = hash(:customerid || :customer_password);

  if (not exists (select 1 from ts_cust_web w where w.customerid = :customerid)) then
    insert into ts_cust_web (customerid, login, password_hash, reg_date, flg_enabled, email, phone_number, preffered_language, token, siteid) values
    (:customerid, :customer_email, hash(:customer_password), current_timestamp, 1, :customer_email, :customer_phonenumber, 'RO', :customer_token, :siteid);

  suspend;
end ^

/* ------------------------------------------------------------------ 7. CHECK_IF_CUSTOMER_EXISTS2 */
CREATE OR ALTER PROCEDURE CHECK_IF_CUSTOMER_EXISTS2 (
    LANG           DM_VARCHAR3 NOT NULL,
    CUSTOMER_NAME  DM_VARCHAR128,
    CUSTOMER_PHONE DM_VARCHAR16,
    CUSTOMER_EMAIL DM_VARCHAR128,
    SITEID         DM_INTEGER = 1)
RETURNS (
    CUSTOMERID DM_INTEGER,
    ERROR      DM_VARCHAR255)
AS
begin
   /* Ca CHECK_IF_CUSTOMER_EXISTS, dar doar printre conturile site-ului :SITEID. */
   :customerid = -1;
   :error = '';
   :customer_phone = lpad(trim(:customer_phone), 9, '0');

   select first 1 cw.customerid from ts_cust_web cw
    where cw.phone_number = :customer_phone and cw.flg_enabled = 1 and cw.siteid = :siteid
     into :customerid;

   if (:customerid > 0) then
   begin
     if (upper(:lang)='RO') then :error = 'Utilizator cu asa numar de telefon este deja inregistrat!';
     else :error = 'Этот пользователь уже зарегистрирован';
     suspend;
     exit;
   end

   :customerid = -1;
   select first 1 cw.customerid from ts_cust_web cw
    where lower(cw.email) = lower(:customer_email) and cw.flg_enabled = 1 and cw.siteid = :siteid
     into :customerid;

   if (:customerid > 0) then
   begin
     if (upper(:lang)='RO') then :error = 'Utilizator cu as email este deja inregistrat!';
     else :error = 'Этот пользователь уже зарегистрирован';
     suspend;
     exit;
   end
   suspend;
end ^

SET TERM ; ^
COMMIT;

/* drepturi pentru userul site-ului, ca la procedurile vechi */
GRANT SELECT, INSERT, UPDATE ON TWEB_SITE TO SWN;
GRANT SELECT ON TWEB_SITE TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_CREATE_NEW_CUSTOMER4 TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_CREATE_NEW_CUSTOMER4 TO SWN;
GRANT EXECUTE ON PROCEDURE CREATE_CUSTOMER_WEB_CREDENTIALS2 TO WEBUSER;
GRANT EXECUTE ON PROCEDURE CHECK_IF_CUSTOMER_EXISTS2 TO WEBUSER;
COMMIT;

/* ============================================================================
   Clientul comenzilor de pe site identificat / creat dupa numarul de telefon

   Pina acum vizitatorul neautentificat ajungea pe comanda ca 286 (PERSOANA FIZICA):
   "Comanda acum" (1 click) lua clientul doar daca telefonul avea exact un client,
   iar formularul de credit nu cauta deloc. Operatorul crea clientul de mina.

   SP_WEB_FIND_OR_CREATE_CUSTOMER(A_PHONE, A_NAME, A_IDEN, A_BIRTH_DATE, A_ADDRESS, A_CREATE)
       -> CUSTOMERID, CREATED, PHONE
       Telefonul se aduce la forma nationala 0XXXXXXXX (prefixul 373 se scoate,
       8 cifre primesc 0 in fata) si se cauta in TS_CUST_PHONES (si formele
       "373...", "+373...", ultimele 8 cifre). La mai multi clienti pe acelasi
       numar: intai cel cu nume real (nu "CLIENT ..."), apoi cel mai nou.
       Daca nu exista se creeaza ca la CREATE_CUSTOMER_WEB_CREDENTIALS (mapa
       247386 PERSOANA FIZICE, tip 4010, utilizatorul 9, telefon mobil 7468,
       TS_CUST_INFO cu PRICECOLUMN 1). Numele implicit: "CLIENT <telefon>".
       Un "CLIENT <telefon>" provizoriu gasit primeste numele real si, daca au
       venit, IDNP-ul / data nasterii / adresa (doar unde lipsesc).
       Fara telefon utilizabil (sub 5 cifre) intoarce CUSTOMERID NULL.

   WEB_CREATE_TRANSACTION_PHONE2 ("Comanda acum" / 1 click)
       pentru CUSTOMERID <= 0 (neautentificat): clientul dupa telefon, altfel
       client nou "CLIENT <telefon>" cu telefonul atasat.
       Corectie: stub-ul cererii de finantare la plata in credit (20.10.2026)
       punea NULL in TWEB_CERERE_FINANTARE.CREDIT_PERIOADA (DM_INTEGER_NN), deci
       orice "Comanda acum" pe credit pica cu validation error; acum 0 luni.

   SP_WEB_REGISTER_FINANTARE (formularul de credit, FIN_AS_WEBORDER = 1)
       pentru A_CUSTOMERID <= 0: clientul dupa telefon, altfel client nou cu
       numele din formular (NPP), IDNP (IDEN), data nasterii (DATA_NASTERII,
       dd.mm.yyyy) si, daca e livrare, adresa (DELIVERYADDRESS fara sufixul
       UTM / COMENTARIU) in TS_CUST_INFO.ADDRESS. Comanda noua se face pe acest
       client; la atasarea dosarului pe o comanda "1 click" (D3) comanda ramasa
       pe 286 trece pe clientul identificat. Ramura FIN_AS_WEBORDER = 0 (1791)
       neschimbata.

   Sursele procedurilor modificate: cele live din SW (24.10.2026) + inlocuirile
   din C:/Temp/fintest/webcust/gen_webcust.py (verificate cu assert).
   Testat pe copia locala D:/FBTest/fintest/SWMETA.FDB (test_webcust.py).
   Rollback: web_customer_by_phone_rollback.sql.

   Re-rulabil. Firebird 5.
   NEURON Grup SRL, 24 octombrie 2026
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_WEB_FIND_OR_CREATE_CUSTOMER (
    A_PHONE VARCHAR(255) CHARACTER SET UTF8,
    A_NAME VARCHAR(255) CHARACTER SET UTF8 = NULL,
    A_IDEN VARCHAR(32) CHARACTER SET UTF8 = NULL,
    A_BIRTH_DATE VARCHAR(20) CHARACTER SET UTF8 = NULL,
    A_ADDRESS VARCHAR(1000) CHARACTER SET UTF8 = NULL,
    A_CREATE SMALLINT = 1)
RETURNS (
    CUSTOMERID INTEGER,
    CREATED SMALLINT,
    PHONE VARCHAR(16) CHARACTER SET UTF8)
SQL SECURITY DEFINER
AS
DECLARE V_RAW VARCHAR(255);
DECLARE V_DIGITS VARCHAR(255) = '';
DECLARE V_I INTEGER = 1;
DECLARE V_C CHAR(1);
DECLARE V_LAST8 VARCHAR(8);
DECLARE V_NAME VARCHAR(255);
DECLARE V_IDEN VARCHAR(32);
DECLARE V_BD DATE;
DECLARE V_BD_TXT VARCHAR(20);
DECLARE V_ADDR VARCHAR(1000);
DECLARE V_POS INTEGER;
DECLARE V_OLD_NAME VARCHAR(255);
DECLARE V_PLACEHOLDER SMALLINT = 0;
BEGIN
    /* Clientul unei comenzi de pe site identificat dupa telefon (24.10.2026).
       Apelata din WEB_CREATE_TRANSACTION_PHONE2 ("Comanda acum" / 1 click) si din
       SP_WEB_REGISTER_FINANTARE (formularul de credit) pentru vizitatorul neautentificat.
         - telefonul se aduce la forma nationala 0XXXXXXXX (ca normalizeMdMobilePhone din site);
         - se cauta in TS_CUST_PHONES; la mai multi clienti pe acelasi numar se prefera cel cu
           nume real (nu "CLIENT <telefon>"), apoi cel mai nou;
         - un client provizoriu "CLIENT <telefon>" gasit primeste numele real si datele din
           formularul de credit (IDNP, data nasterii, adresa), daca au venit;
         - daca nu exista si A_CREATE = 1 se creeaza ca la CREATE_CUSTOMER_WEB_CREDENTIALS:
           mapa 247386 (PERSOANA FIZICE), persoana fizica (4010), utilizatorul 9 (WEB SITE),
           telefon mobil (7468), TS_CUST_INFO cu PRICECOLUMN 1 + IDNP / data nasterii / adresa.
       Numele implicit: "CLIENT <telefon>". Fara telefon utilizabil intoarce CUSTOMERID NULL. */
    CUSTOMERID = NULL;
    CREATED = 0;
    PHONE = NULL;

    V_RAW = NULLIF(TRIM(COALESCE(A_PHONE, '')), '');
    IF (V_RAW IS NULL) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* 1. doar cifrele; prefixul de tara 373 se scoate; 8 cifre -> 0 in fata */
    WHILE (V_I <= CHAR_LENGTH(V_RAW)) DO
    BEGIN
        V_C = SUBSTRING(V_RAW FROM V_I FOR 1);
        IF (V_C BETWEEN '0' AND '9') THEN V_DIGITS = V_DIGITS || V_C;
        V_I = V_I + 1;
    END
    IF (V_DIGITS STARTING WITH '373' AND CHAR_LENGTH(V_DIGITS) >= 11) THEN
        V_DIGITS = SUBSTRING(V_DIGITS FROM 4);
    IF (CHAR_LENGTH(V_DIGITS) = 8) THEN
        V_DIGITS = '0' || V_DIGITS;
    IF (CHAR_LENGTH(V_DIGITS) < 5 OR CHAR_LENGTH(V_DIGITS) > 16) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END
    PHONE = V_DIGITS;
    V_LAST8 = IIF(CHAR_LENGTH(V_DIGITS) >= 8, RIGHT(V_DIGITS, 8), NULL);

    /* 2. cautare dupa formele uzuale (indexul TS_CUST_PHONES_IDX2 pe PHONENUMBER) */
    SELECT FIRST 1 CP.CUSTOMERID, C.NAME
      FROM TS_CUST_PHONES CP
      JOIN TS_CUSTOMER C ON C.CUSTOMERID = CP.CUSTOMERID
     WHERE CP.PHONENUMBER IN (:V_DIGITS, LEFT(:V_RAW, 16), '373' || :V_LAST8, '+373' || :V_LAST8, :V_LAST8)
       AND COALESCE(C.FLG_FOLDER, 0) = 0
     ORDER BY IIF(UPPER(C.NAME) STARTING WITH 'CLIENT', 1, 0), CP.CUSTOMERID DESC
      INTO :CUSTOMERID, :V_OLD_NAME;

    /* 3. datele din formular */
    V_NAME = NULLIF(TRIM(COALESCE(A_NAME, '')), '');
    V_IDEN = LEFT(NULLIF(TRIM(COALESCE(A_IDEN, '')), ''), 32);
    V_BD_TXT = NULLIF(TRIM(COALESCE(A_BIRTH_DATE, '')), '');
    BEGIN
        IF (V_BD_TXT SIMILAR TO '[0-9]{2}[.][0-9]{2}[.][0-9]{4}') THEN
            V_BD = CAST(SUBSTRING(V_BD_TXT FROM 7 FOR 4) || '-' || SUBSTRING(V_BD_TXT FROM 4 FOR 2)
                        || '-' || SUBSTRING(V_BD_TXT FROM 1 FOR 2) AS DATE);
        ELSE IF (V_BD_TXT SIMILAR TO '[0-9]{4}\-[0-9]{2}\-[0-9]{2}' ESCAPE '\') THEN
            V_BD = CAST(V_BD_TXT AS DATE);
        IF (V_BD IS NOT NULL AND (V_BD < DATE '1900-01-01' OR V_BD > CURRENT_DATE)) THEN
            V_BD = NULL;
    WHEN ANY DO
        V_BD = NULL;
    END
    /* adresa de livrare asa cum o trimite site-ul: ADRESA | COMENTARIU: ... | UTM: ... */
    V_ADDR = TRIM(COALESCE(A_ADDRESS, ''));
    V_POS = POSITION(' | UTM: ' IN V_ADDR);
    IF (V_POS > 0) THEN V_ADDR = TRIM(SUBSTRING(V_ADDR FROM 1 FOR V_POS - 1));
    IF (LEFT(V_ADDR, 5) = 'UTM: ') THEN V_ADDR = '';
    V_POS = POSITION(' | COMENTARIU: ' IN V_ADDR);
    IF (V_POS > 0) THEN V_ADDR = TRIM(SUBSTRING(V_ADDR FROM 1 FOR V_POS - 1));
    IF (LEFT(V_ADDR, 12) = 'COMENTARIU: ') THEN V_ADDR = '';
    V_ADDR = LEFT(NULLIF(V_ADDR, ''), 255);

    IF (CUSTOMERID IS NOT NULL) THEN
    BEGIN
        /* client gasit; "CLIENT <telefon>" provizoriu -> numele real + datele din formular */
        V_PLACEHOLDER = IIF(UPPER(TRIM(COALESCE(V_OLD_NAME, ''))) STARTING WITH 'CLIENT'
                            AND V_LAST8 IS NOT NULL
                            AND POSITION(V_LAST8 IN COALESCE(V_OLD_NAME, '')) > 0, 1, 0);
        IF (V_PLACEHOLDER = 1) THEN
        BEGIN
            IF (V_NAME IS NOT NULL AND UPPER(V_NAME) NOT STARTING WITH 'CLIENT') THEN
                UPDATE TS_CUSTOMER SET NAME = UPPER(:V_NAME) WHERE CUSTOMERID = :CUSTOMERID;
            IF (COALESCE(V_IDEN, V_ADDR) IS NOT NULL OR V_BD IS NOT NULL) THEN
            BEGIN
                IF (EXISTS (SELECT 1 FROM TS_CUST_INFO WHERE CUSTOMERID = :CUSTOMERID)) THEN
                    UPDATE TS_CUST_INFO
                       SET IDEN_NUMBER = COALESCE(NULLIF(TRIM(IDEN_NUMBER), ''), :V_IDEN),
                           BIRTH_DATE = COALESCE(BIRTH_DATE, :V_BD),
                           ADDRESS = COALESCE(NULLIF(TRIM(ADDRESS), ''), :V_ADDR)
                     WHERE CUSTOMERID = :CUSTOMERID;
                ELSE
                    INSERT INTO TS_CUST_INFO (CUSTOMERID, PRICECOLUMN, IDEN_NUMBER, BIRTH_DATE, ADDRESS)
                    VALUES (:CUSTOMERID, 1, :V_IDEN, :V_BD, :V_ADDR);
            END
        END
        SUSPEND;
        EXIT;
    END

    IF (COALESCE(A_CREATE, 1) = 0) THEN
    BEGIN
        SUSPEND;
        EXIT;
    END

    /* 4. client nou */
    CUSTOMERID = NEXT VALUE FOR SQ_TS_CUSTOMER_CUSTOMERID;
    INSERT INTO TS_CUSTOMER (CUSTOMERID, PARENTID, FLG_FOLDER, PREFIXNAME, NAME, SUFIXNAME, ORG_PARENT_ID,
                             CUSTOMER_TYPE_ID, CUSTOMER_STATUS_ID, VAT, ORDERNO, WEB_STOCK_BIT_INDEX,
                             USERID, FLAGS, CREATED, GENDER)
    VALUES (:CUSTOMERID, 247386, 0, '', UPPER(COALESCE(:V_NAME, 'CLIENT ' || :V_DIGITS)), '', -1,
            4010, 4101, 20, 0, -1,
            9, 0, CURRENT_TIMESTAMP, NULL);
    INSERT INTO TS_CUST_PHONES (CUSTOMERID, PHONENUMBER, COMMENT, PHONETYPEID, FLAGS)
    VALUES (:CUSTOMERID, :V_DIGITS, NULL, 7468, 0);
    INSERT INTO TS_CUST_INFO (CUSTOMERID, PRICECOLUMN, IDEN_NUMBER, BIRTH_DATE, ADDRESS)
    VALUES (:CUSTOMERID, 1, :V_IDEN, :V_BD, :V_ADDR);
    CREATED = 1;
    SUSPEND;
END ^

CREATE OR ALTER PROCEDURE WEB_CREATE_TRANSACTION_PHONE2 (USERFULLNAME DM_VARCHAR128 NOT NULL,
USERPHONE DM_VARCHAR10 NOT NULL,
FLG_CURRENCY_USD DM_BOOLEAN_NN,
FLG_USER_PRICE_COLUMN DM_INTEGER,
CUSTOMERID DM_INTEGER_NN,
DELIVERY_ADRESS DM_VARCHAR255 = '',
PAYMENT_TYPE DM_INTEGER = 0,
USERIP DM_VARCHAR32 = '0.0.0.1')
RETURNS (DOCID DM_INTEGER)
AS
declare variable DT DM_INTEGER;
declare variable DTDEP DM_INTEGER;
declare variable CTDEP DM_INTEGER;
declare variable DTSC DM_INTEGER;
declare variable CURRENCYID DM_INTEGER;
declare variable RATE DM_PRICE;
declare variable SC2 DM_INTEGER;
declare variable RATEUSD DM_PRICE;
declare variable WEB_PRICE_COLUMN DM_PRICECOLUMN;
declare variable UMID DM_INTEGER;
declare variable WARRANTY DM_INTEGER;
declare variable GOODSPRICE DM_PRICE;
declare variable SUMA_DOC DM_PRICE;
declare variable CURRENCY_NAME DM_VARCHAR16;
declare variable GOODS_NAME DM_VARCHAR2048;
declare goodslist dm_blobtext;
declare gid dm_integer;
declare QTY DM_INTEGER;
declare goods_list dm_blobtext;
declare web_customerid dm_integer;
BEGIN
     /* 26.05.2014 - JOHN */
     /* WEB */
     /* "Cumpara online prin telefon" */
     /* Creaza un Web-Zakaz pe Persoana Fizica cu info despre client */
--     if (:userIp in ('0.0.0.0') ) then
--     begin
--       DOCID = -1;
--       exit;
--     end

     if (flg_user_price_column>1) then
       flg_user_price_column = 1;

     /* create user enviroment Web User */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9);
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);
     /* Vizitatorul neautentificat (24.10.2026): clientul se cauta dupa telefon; daca nu
        exista se creeaza "CLIENT <telefon>" cu telefonul atasat (SP_WEB_FIND_OR_CREATE_CUSTOMER).
        Inainte: doar daca telefonul avea exact un client, altfel 286 (PERSOANA FIZICA). */
     if (coalesce(:customerid, -1) <= 0) then
     begin
        web_customerid = -1;
        select coalesce(customerid, -1) from SP_WEB_FIND_OR_CREATE_CUSTOMER(:userphone, null, null, null, null, 1)
          into :web_customerid;
        customerid = coalesce(:web_customerid, -1); /* parametrul e NOT NULL (DM_INTEGER_NN) */
     end
     /* get USD rate */
     SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :RATEUSD;

     IF (CUSTOMERID=-1) THEN CUSTOMERID = 286; /* PERSOANA FIZICA */
     else
     begin
        select ci.pricecolumn from ts_cust_info ci where customerid = :customerid into :web_price_column;
     end

     /* get document defaults */
     SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
     FROM TS_DOCTYPES_DEFVALUES
     WHERE DOCTYPEID = 134 AND FIRMA = 316910
     INTO :DT, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :SC2;

     /* Analitica de plata = plata aleasa (0 la primire, 1 credit, 2 MIA); 10.10.2026.
        Cu PAY_CREDIT deal-ul primeste FIN_REQUESTED (SP_DEAL_RECALC_STATES). */
     DTSC = COALESCE(FN_PAY_DTSC(FN_WEB_PAYMENT_CODE('ONECLICK', :PAYMENT_TYPE)), :DTSC);

     :CTDEP = -1;

     IF (FLG_CURRENCY_USD = 1 AND CUSTOMERID <> 286) THEN CURRENCYID = 840;
         WEB_PRICE_COLUMN = 1;

     /* get default currency info */
     SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :CURRENCYID INTO :RATE;

     /* create Doc */
     INSERT INTO TDB_DOCS (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, RATE, CREATED_BY, DOCTYPEID, RATEUSD, SC2, FLAGS)
     VALUES (:DT, :CUSTOMERID, :DTDEP, :CTDEP, :DTSC, :CURRENCYID, :RATE, 9, 134, :RATEUSD, :SC2, 0)
     RETURNING DOCID INTO :DOCID;

     :goods_list = '<table width=1000px>' ||
     '<tr>
       <td width="20%">Cod</td>
       <td width="65%">Produs</td>
       <td width="15%">Cant</td>
      </tr>';

     for select goodsid, qty from tmp$goodsqty into :gid, :qty do
     begin
         if (:qty>0) then
         begin
         SELECT CUSTOM_PRICE_COLUMN
         FROM WEB_GET_CATALOG_TREE_BY_GOODSID(:gid, 5213)
         INTO :WEB_PRICE_COLUMN;

         IF (WEB_PRICE_COLUMN IS NULL) THEN WEB_PRICE_COLUMN = 1;
    
         IF (FLG_USER_PRICE_COLUMN = 1 AND CUSTOMERID <> 286) THEN
         BEGIN
              SELECT PRICECOLUMN
              FROM TS_CUST_INFO
              WHERE CUSTOMERID=:CUSTOMERID
              INTO :WEB_PRICE_COLUMN;
    
              if ((:WEB_PRICE_COLUMN IS NULL) or (:web_price_column<4)) then WEB_PRICE_COLUMN = 1;
         END

         SELECT UMID, WARRANTY, title
         FROM TS_GOODS
         WHERE GOODSID = :gid
         INTO :UMID, :WARRANTY, :GOODS_NAME;

         /* get price */
         SELECT PRICE_MDL
         FROM GET_GOODS_PRICE(:gid, :WEB_PRICE_COLUMN, :CURRENCYID)
         INTO :GOODSPRICE;
    
         INSERT INTO TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, QTY, UMID, PRICE, WARRANTY, STOCK_QTY, FLAGS)
         VALUES (:DOCID, :DTDEP, :CTDEP , -1, :gid, :QTY, :UMID, :GOODSPRICE, :WARRANTY, 0, 1);

        :goods_list = :goods_list || '<tr><td>' || :gid ||'</td><td>'||:goods_name||'</td><td style="text-align:right">'||:qty||'</td></tr>';

         :goodslist = coalesce(:goodslist,'')||'<BR>['||coalesce(:gid,-1)||']-'||substring(coalesce(:GOODS_NAME, '') from 1 for 100)||'<BR>Cant: '||coalesce(:qty, 0);
       end
     end
     :goods_list = :goods_list ||'</table>';
     /* create DOC comments */
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'COMANDA CU 1 CLICK');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Client: ' || :USERFULLNAME);
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Telefon: ' || :USERPHONE);
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'adresa de livrare: ' || :delivery_adress);
     if (payment_type = 0) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: Achita la primire');
     if (payment_type = 1) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: CREDIT');
     if (payment_type = 2) then
       EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Metoda de plata: MIA');

     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'IP:' || :userip);

     /* Deal: datele comenzii in campuri separate (23.09.2026); UTM-ul vine din TWEB_ORDER_UTM */
     EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :USERFULLNAME, :USERPHONE,
         :DELIVERY_ADRESS, NULL,
         FN_DEAL_WEB_PAYMENT_METHOD('ONECLICK', :PAYMENT_TYPE),
         NULL, NULL, NULL, NULL, NULL, 1);


     /* notify Event */
     EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:dt, 6, '', :DOCID, 9);

     /* Send SMS clientului */
          INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT, SOURCE_TABLE)
          VALUES (:userphone,
                                    'Internet magazin FANTASTIC.MD~Comanda d-stra nr.' || :DOCID || ' este in procesare.~In curind operatorul va apela pentru detalii.~Pentru informatii suplimentare ne puteti contacta la telefonul (079)903090. ~Va multumim!',
                  4);

     select suma, c.TITLE from tdb_docs d
     inner join ts_currency C on c.CURRENCYID=d.CURRENCYID
     where docid=:docid
     into :suma_doc, :currency_name;

     /* Plata in credit (20.10.2026): cererea de finantare se creeaza din start, doar cu
        numele, telefonul si suma; operatorul o completeaza din "Oferte" (click dreapta ->
        "Cerere de finantare / eCredit...") si o depune la eCredit. Vezi DB Model/ecredit_api.sql. */
     if (payment_type = 1 and not exists (select 1 from TWEB_CERERE_FINANTARE f where f.DOCID = :DOCID)) then
       INSERT INTO TWEB_CERERE_FINANTARE (DOCID, CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII,
                                          CONTACT_TELEFON, FLG_COPY_BY_FAX)
       VALUES (:DOCID, COALESCE(:suma_doc, 0), 0 /* NOT NULL; cu NULL comanda pe credit pica (fix 24.10.2026) */, COALESCE(:USERFULLNAME, ''), '', '',
               COALESCE(:USERPHONE, ''), 0);

     /* 05.08.2014 - Scrisoare la administratie */
     EXECUTE PROCEDURE SP_CREATE_MAIL_TO_SEND('web@fantastic.md','','Web comanda intr-un click',
                                              'Web comanda intr-un click. Data('||current_timestamp ||')<br><br>Client: <b>' || :USERFULLNAME || '</b><br/>' ||
                                              'Telefon: <b>' || :USERPHONE || '</b><br><br>' ||
                                              'Documentul generat: <b>' || :DOCID || '</b><br>'||
                                              'Suma documentului: <b>'||round(:suma_doc,2)||' '||:currency_name||'</b><br>'||
                                              'Produs: '||coalesce(:goods_list, '---'));

     delete from tmp$goodsqty;

   suspend;
END ^

CREATE OR ALTER PROCEDURE SP_WEB_REGISTER_FINANTARE (CREDIT_SUMA DM_PRICE NOT NULL,
CREDIT_PERIOADA DM_INTEGER_NN,
NPP DM_VARCHAR128 NOT NULL,
IDEN DM_VARCHAR16 NOT NULL,
DATA_NASTERII DM_VARCHAR10 NOT NULL,
CONTACT_TELEFON DM_VARCHAR255 NOT NULL,
FLG_COPY_BY_FAX DM_BOOLEAN_NN,
SCAN1 DM_BLOBIMAGE,
SCAN2 DM_BLOBIMAGE,
AVANS DM_PRICE = 0,
PLATA_LUNARA DM_PRICE = 0,
CREDIT_TYPE DM_VARCHAR32 = '',
ORG_ID DM_INTEGER = -1,
DELIVERYADDRESS DM_VARCHAR255 = '',
A_GOODSIDS VARCHAR(1000) CHARACTER SET UTF8 = '',
A_CUSTOMERID INTEGER = -1)
RETURNS (DOCID DM_INTEGER)
SQL SECURITY DEFINER
AS
declare variable TIP_CREDIT varchar(128);
declare variable V_FIRMA integer = 316910; /* firma comenzilor web, ca in WEB_CREATE_TRANSACTION3 / _PHONE2 */
declare variable V_DT integer;
declare variable V_DTDEP integer;
declare variable V_CTDEP integer;
declare variable V_DEF_DTSC integer;
declare variable V_CURRENCYID integer;
declare variable V_SC2 integer;
declare variable V_RATE double precision;
declare variable V_RATEUSD double precision;
declare variable V_DTSC integer;
declare variable V_PHONE8 varchar(8);
declare variable V_CAND integer;
declare variable V_LIST varchar(1010);
declare variable V_POS integer;
declare variable V_ITEM varchar(1010);
declare variable V_MISSING integer;
declare variable V_ATTACHED smallint = 0;
declare variable V_CUSTOMERID integer;
BEGIN
     /* pentru aceasta procedure trebuie UserContext de create */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9); /* WebUser */
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

     /* ================================================================
        Comutatorul FIN_AS_WEBORDER = 0: Cerere de finantare 1791 (codul de pina la 10.10.2026)
        ================================================================ */
     IF (FN_FIN_AS_WEBORDER() = 0) THEN
     BEGIN

    --    in autonomous transaction do
    --        insert into tdb_debug (text) values ('1. Cerere de finantare. Start.');

        /* create DOC, WebUser, FLG_ACNT */
        INSERT INTO TDB_DOCS
        (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, FLAGS)
        VALUES
        (316910 /* SOLUTII COMERCIALE SRL, 18.09.2026; inainte: iif(current_date>='17.09.2024', 307225, 218482) */, 286, 43, 43, 5108, 498, 1791, 9, 1, NULL, 2)
        RETURNING DOCID INTO :DOCID;

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('2. Cerere de finantare. creat document nou. DocID:'||:DOCID);

        select title from ts_finance_customer where uid=:org_id into :tip_credit;
        :tip_credit = coalesce(:tip_credit, 'NONE');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('3. Cerere de finantare. tip_credit: '||:tip_credit);

        /* create DOC comments */
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                             'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
        EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('4. Cerere de finantare. adaugam inregistrarea in tabelul TWEB_CRERE_FINANTARE.');

        /* create details */
        INSERT INTO TWEB_CERERE_FINANTARE
        (
         DOCID,
         CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
         FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
        )
        VALUES
        (
         :DOCID,
         :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
         :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
        );

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('5. Cerere de finantare. Adaugat cu succes.');


    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('6. Cerere de finantare. Trimite scrisoare pe web@fantastic.md.');
        /* create EMail */
        INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
        VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),'Cerere de finantare de la '||coalesce(:NPP, ''),
                'Cerere de finantare din partea lui '||:NPP||'<br>'||
                'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
                'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
                'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
                'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
                'Tip credit: '||:tip_credit ||
                '<br><br>Contactati clientul!');

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('7. Cerere de finantare. Generam eveniment.');

        /* create event */
        EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(316910,7,:NPP,:DOCID,9); /* WebUser */

    --    in autonomous transaction do
    --    insert into tdb_debug (text) values ('8. Cerere de finantare. Trimitem SMS pe numarul de telefon :contact_telefon');

        insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
        values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

         SUSPEND;
         EXIT;
     END

     /* ================================================================
        Comutatorul = 1: comanda Web-Order 134 cu plata pe credit; dosarul ramine
        in TWEB_CERERE_FINANTARE (fila "Credit" din WMS)
        ================================================================ */
     V_DTSC = FN_PAY_DTSC(IIF(COALESCE(TRIM(:CREDIT_TYPE), '') SIMILAR TO '0+([.,]0+)?',
                              'PAY_CREDIT0', 'PAY_CREDIT'));

     select title from ts_finance_customer where uid=:org_id into :tip_credit;
     :tip_credit = coalesce(:tip_credit, 'NONE');

     /* D3: credit cerut din "1 click" si apoi prin formular -> dosarul merge pe comanda existenta.
        Conditii: 134 de pe site, deschisa, nestearsa, din ultimele 72 h, pe credit (analitica
        sau metoda de plata din deal), fara dosar, acelasi telefon (ultimele 8 cifre), si contine
        toate produsele cererii. Fara lista de produse (site-ul vechi) -> mereu comanda noua. */
     DOCID = NULL;
     V_PHONE8 = FN_PHONE_LAST8(:CONTACT_TELEFON);

     /* Clientul comenzii (24.10.2026): cel autentificat; altfel cautat dupa telefon, iar daca
        nu exista se creeaza cu numele din formular, IDNP-ul, data nasterii si adresa de livrare
        (SP_WEB_FIND_OR_CREATE_CUSTOMER). Un "CLIENT <telefon>" provizoriu de la "1 click" primeste
        aceleasi date. Inainte comanda ramanea pe 286 (PERSOANA FIZICA). */
     V_CUSTOMERID = IIF(COALESCE(:A_CUSTOMERID, -1) > 0, :A_CUSTOMERID, NULL);
     IF (V_CUSTOMERID IS NULL) THEN
         SELECT CUSTOMERID
           FROM SP_WEB_FIND_OR_CREATE_CUSTOMER(:CONTACT_TELEFON, :NPP, :IDEN, :DATA_NASTERII, :DELIVERYADDRESS, 1)
           INTO :V_CUSTOMERID;
     IF (COALESCE(TRIM(:A_GOODSIDS), '') <> '' AND V_PHONE8 IS NOT NULL) THEN
     BEGIN
         FOR SELECT D.DOCID
               FROM TDB_DOCS D
              WHERE D.DOCTYPEID IN (134, 115) /* 23.10.2026: si comanda deja mutata in Oferte */
                AND D.CREATED_BY = 9
                AND D.DELETED_DATE IS NULL
                AND COALESCE(GET_FLG_VALUE(D.FLAGS, 10), 0) = 0
                AND D.CREATED_DATE >= DATEADD(-72 HOUR TO CURRENT_TIMESTAMP)
                AND NOT EXISTS (SELECT 1 FROM TWEB_CERERE_FINANTARE F
                                 WHERE F.DOCID = D.DOCID
                                   AND COALESCE(F.IDEN, '') <> '')  /* stub-ul de la "1 click" (fara IDNP) se completeaza */
                AND (FN_PAY_IS_CREDIT(D.DTSC) = 1
                     OR EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                                  JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                                 WHERE DD.DOCID = D.DOCID
                                   AND UPPER(TRIM(DL.PAYMENT_METHOD)) STARTING WITH 'CREDIT'))
                AND (EXISTS (SELECT 1 FROM TDB_DEAL_DOCS DD
                               JOIN TDB_DEALS DL ON DL.DEAL_ID = DD.DEAL_ID
                              WHERE DD.DOCID = D.DOCID AND FN_PHONE_LAST8(DL.PHONE) = :V_PHONE8)
                     OR EXISTS (SELECT 1 FROM TWEB_TRANSACTION T
                                 WHERE T.DOCID = D.DOCID AND FN_PHONE_LAST8(T.PHONES) = :V_PHONE8))
              ORDER BY D.DOCID DESC
               INTO :V_CAND
         DO
         BEGIN
             /* toate produsele cererii trebuie sa fie deja in comanda */
             V_MISSING = 0;
             V_LIST = TRIM(:A_GOODSIDS) || ',';
             WHILE (V_LIST <> '' AND V_MISSING = 0) DO
             BEGIN
                 V_POS = POSITION(',' IN V_LIST);
                 V_ITEM = TRIM(SUBSTRING(V_LIST FROM 1 FOR V_POS - 1));
                 V_LIST = SUBSTRING(V_LIST FROM V_POS + 1);
                 IF (V_ITEM SIMILAR TO '[0-9]+') THEN
                     IF (NOT EXISTS (SELECT 1 FROM TDB_JURNAL J
                                      WHERE J.DOCID = :V_CAND AND J.GOODSID = CAST(:V_ITEM AS INTEGER))) THEN
                         V_MISSING = 1;
             END
             IF (V_MISSING = 0) THEN
             BEGIN
                 DOCID = V_CAND;
                 LEAVE;
             END
         END
     END

     IF (DOCID IS NOT NULL) THEN
     BEGIN
         /* comanda exista deja: devine comanda pe credit cu dosar */
         V_ATTACHED = 1;
         UPDATE TDB_DOCS SET DTSC = :V_DTSC
          WHERE DOCID = :DOCID AND :V_DTSC IS NOT NULL AND DTSC IS DISTINCT FROM :V_DTSC;
         /* comanda "1 click" ramasa pe PERSOANA FIZICA primeste clientul identificat acum */
         UPDATE TDB_DOCS SET CT = :V_CUSTOMERID
          WHERE DOCID = :DOCID AND CT = 286 AND :V_CUSTOMERID IS NOT NULL;
         SELECT DT FROM TDB_DOCS WHERE DOCID = :DOCID INTO :V_DT;
         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB',
             'Clientul a completat si formularul de credit: dosarul a fost atasat la aceasta comanda.');
     END
     ELSE
     BEGIN
         /* comanda noua: valorile implicite ale Web-Order-ului pentru firma web */
         SELECT DT, DTDEP, CTDEP, DTSC, CURRENCYID, SC
           FROM TS_DOCTYPES_DEFVALUES
          WHERE DOCTYPEID = 134 AND FIRMA = :V_FIRMA
           INTO :V_DT, :V_DTDEP, :V_CTDEP, :V_DEF_DTSC, :V_CURRENCYID, :V_SC2;
         V_DT = COALESCE(V_DT, V_FIRMA);
         V_DTDEP = COALESCE(V_DTDEP, 43);
         V_CTDEP = COALESCE(V_CTDEP, 43);
         V_CURRENCYID = COALESCE(V_CURRENCYID, 498);
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = :V_CURRENCYID INTO :V_RATE;
         SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840 INTO :V_RATEUSD;

         /* SP_DEAL_ATTACH_DOC (trigger-ul TDB_DOCS_AI_DEAL) citeste sursa: deal FINANCE_REQUEST */
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', 'FINANCE_REQUEST');
         INSERT INTO TDB_DOCS
         (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, SC2, FLAGS)
         VALUES
         (:V_DT, COALESCE(:V_CUSTOMERID, 286), :V_DTDEP, :V_CTDEP,
          COALESCE(:V_DTSC, :V_DEF_DTSC, 5108), :V_CURRENCYID, 134, 9, COALESCE(:V_RATE, 1), :V_RATEUSD,
          :V_SC2, 2)
         RETURNING DOCID INTO :DOCID;
         RDB$SET_CONTEXT('USER_TRANSACTION', 'DEAL_SOURCE', NULL);

         EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'COMANDA PE CREDIT (formularul de credit)');
     END

     /* comentariile cererii (ca la 1791) */
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Cerere de finantare: ' || :NPP || ', ' || ROUND(COALESCE(:CREDIT_SUMA,0),2) || ' MDL.');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'INDP: ' || coalesce(:IDEN, 'nu a fost introdus')|| ',  '||' Data nasterii: '||  coalesce(:data_nasterii, 'nu a introdus data nasterii')  || ' ' ||
                                                          'Telefon: ' || coalesce(:CONTACT_TELEFON, 'Nu are indicat nr de telefon'));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Tip credit: '|| coalesce(:credit_type, '0')||'%'||',  Numarul de luni: '|| round(coalesce(:credit_perioada,0)));
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Avans: ' || Round(coalesce(:AVANS,0)) || '  Plata Lunara: '|| round(coalesce(:plata_lunara,0))||' MDL');
     EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:DOCID, 'WEB', 'Adresa de livrare: '||:DeliveryAddress);

     /* dosarul de credit; UPDATE OR INSERT - comanda "1 click" cu plata in credit are deja un stub
        (WEB_CREATE_TRANSACTION_PHONE2), care se completeaza aici */
     UPDATE OR INSERT INTO TWEB_CERERE_FINANTARE
     (
      DOCID,
      CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON,
      FLG_COPY_BY_FAX, SCAN1, SCAN2, avans, plata_lunara, org_id, credit_type
     )
     VALUES
     (
      :DOCID,
      :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, :DATA_NASTERII, :CONTACT_TELEFON,
      :FLG_COPY_BY_FAX, :SCAN1, :SCAN2, :avans, :plata_lunara, :org_id, nullif(trim(:credit_type), '')
     )
     MATCHING (DOCID);

     /* datele comenzii in deal (nume, telefon, adresa, plata; UTM-ul din TWEB_ORDER_UTM).
        La comanda existenta (D3) nu se suprascrie ce a venit din "1 click". */
     EXECUTE PROCEDURE SP_DEAL_SET_WEB_ORDER_INFO(:DOCID, :NPP, :CONTACT_TELEFON,
         NULLIF(TRIM(:DeliveryAddress), ''), NULL, 'Credit', NULL, NULL, NULL, NULL, NULL,
         IIF(:V_ATTACHED = 1, 0, 1));

     /* e-mail */
     INSERT INTO EMAIL_MESSAGES (EMAIL, SUBJECT, "BODY")
     VALUES (coalesce((select title from ts_syss where syssid=907),'web@fantastic.md'),
             'Comanda pe credit #' || :DOCID || ' de la '||coalesce(:NPP, ''),
             IIF(:V_ATTACHED = 1, 'Dosar de credit atasat la comanda existenta #' || :DOCID || '<br>',
                                  'Comanda pe credit (Web-Order) #' || :DOCID || '<br>') ||
             'Cerere de finantare din partea lui '||:NPP||'<br>'||
             'Suma='||round(coalesce(:CREDIT_SUMA,0), 2)||'lei.<br>'||
             'Plata lunara:'||round(coalesce(:plata_lunara,0), 2)||'lei <br> '||
             'Avans:'||round(coalesce(:avans,0), 2)||'lei.<br>'||
             'Perioada:'||round(coalesce(:credit_perioada,0), 2)|| ' luni. <br>'||
             'Tip credit: '||:tip_credit ||
             '<br><br>Contactati clientul!');

     /* eveniment 7 = cerere de credit (sunetul si reincarcarea in WMS: frame24 si frame51) */
     EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(COALESCE(:V_DT, :V_FIRMA), 7, :NPP, :DOCID, 9); /* WebUser */

     insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
     values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

     SUSPEND;
END ^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE SP_WEB_FIND_OR_CREATE_CUSTOMER TO USER WEBUSER;
GRANT EXECUTE ON PROCEDURE SP_WEB_FIND_OR_CREATE_CUSTOMER TO USER SWN;
GRANT EXECUTE ON PROCEDURE SP_WEB_FIND_OR_CREATE_CUSTOMER TO PROCEDURE WEB_CREATE_TRANSACTION_PHONE2;
GRANT EXECUTE ON PROCEDURE SP_WEB_FIND_OR_CREATE_CUSTOMER TO PROCEDURE SP_WEB_REGISTER_FINANTARE;

COMMIT;

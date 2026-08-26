/* -----------------------------------------------------------------------------
   RP_GET_CUSTOMER_HEADER

   Analog al procedurii RP_GET_DOCS_HEADER, dar pentru un client:
   primeste CUSTOMERID si intoarce intr-un singur rand toate datele
   "de antet" ale clientului:
     - identificare (nume, tip, status, flag-uri furnizor/cumparator)
     - contacte (telefon fix, mobil, lista completa de telefoane, email, web)
     - adrese (adresa juridica, adresa fizica, adresa din TS_CUST_INFO)
     - date juridice (cod fiscal IDEN_NUMBER, cod TVA VAT_NUMBER, rezident,
       conducator, contabil, platitor TVA)
     - date bancare (cont, IBAN, cod banca, denumire banca, SWIFT, adresa bancii)

   Parametri:
     FCUSTOMERID     - clientul cerut
     FACCOUNTNUMBER  - optional: contul bancar concret care trebuie intors.
                       Daca este NULL se ia contul implicit
                       (DEFAULT_ACCOUNT = 1), iar in lipsa lui - primul cont.

   Observatii:
     - tipurile de telefon din TS_SYSS: 7470 = Telefon stationar,
       7468 = Telefon mobil (tipul 7472 folosit in RP_GET_DOCS_HEADER pentru
       fax NU exista in TS_SYSS, de aceea nu este preluat aici);
     - tipurile de adresa din TS_SYSS: 7662 = Adresa fizica,
       7663 = Adresa juridica;
     - procedura intoarce intotdeauna maximum un rand; daca clientul nu
       exista, nu intoarce nimic.

   Scriptul poate fi rulat repetat (CREATE OR ALTER).
   ----------------------------------------------------------------------------- */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE RP_GET_CUSTOMER_HEADER (
    FCUSTOMERID DM_INTEGER,
    FACCOUNTNUMBER DM_VARCHAR32 = NULL)
RETURNS (
    CUSTOMERID integer,
    PARENTID integer,
    FLG_FOLDER smallint,
    PREFIXNAME varchar(10),
    NAME varchar(255),
    SUFIXNAME varchar(10),
    DISPLAYNAME varchar(277),
    ORG_PARENT_ID integer,
    CUSTOMER_TYPE_ID integer,
    CUSTOMER_TYPE_TITLE varchar(1024),
    CUSTOMER_STATUS_ID integer,
    CUSTOMER_STATUS_TITLE varchar(1024),
    FLG_FURNIZOR integer,
    FLG_CUMPARATOR integer,
    PRICECOLUMN smallint,
    RRP_DISCOUNT DM_AMOUNT,
    BIRTH_DATE date,
    GENDER char(1),
    USERID integer,
    USER_NAME varchar(121),
    /* contacte */
    TELEFON1 DM_VARCHAR128,
    MOBILE DM_VARCHAR128,
    PHONELIST varchar(1024),
    EMAIL varchar(255),
    WEBPAGE varchar(255),
    /* adrese */
    ADDRESS varchar(255),
    ADDRESS2 varchar(255),
    CITY_ID integer,
    CITY_TITLE varchar(1024),
    ADDRESS_JURIDIC varchar(2307),
    ADDRESS_FIZIC varchar(2307),
    /* date juridice */
    IDEN_NUMBER varchar(32),
    VAT_NUMBER varchar(32),
    FLG_VAT smallint,
    REZIDENT char(1),
    CHIEF varchar(32),
    ACCOUNTANT varchar(32),
    /* date bancare */
    ACCOUNTNUMBER varchar(32),
    ACCOUNTNAME varchar(60),
    IBAN varchar(32),
    BANKACCOUNT varchar(32),
    BANKNAME varchar(255),
    BANK_SWIFT varchar(32),
    BANK_ADDRESS varchar(255),
    DEFAULT_ACCOUNT smallint)
AS
BEGIN
  FOR
    select C.CUSTOMERID,
           C.PARENTID,
           C.FLG_FOLDER,
           C.PREFIXNAME,
           C.NAME,
           C.SUFIXNAME,
           C.DISPLAYNAME,
           C.ORG_PARENT_ID,
           C.CUSTOMER_TYPE_ID,
           C.CUSTOMER_TYPE_TITLE,
           C.CUSTOMER_STATUS_ID,
           C.CUSTOMER_STATUS_TITLE,
           C.FLG_FURNIZOR,
           C.FLG_CUMPARATOR,
           C.PRICECOLUMN,
           C.RRP_DISCOUNT,
           C.BIRTH_DATE,
           C.GENDER,
           C.USERID,
           C.USER_NAME,

           /* contacte */
           GET_CUSTOMER_PHONE(C.CUSTOMERID, 7470) TELEFON1,
           GET_CUSTOMER_PHONE(C.CUSTOMERID, 7468) MOBILE,
           cast((select list(P.PHONENUMBER, ', ')
                 from TS_CUST_PHONES P
                 where P.CUSTOMERID = C.CUSTOMERID) as varchar(1024)) PHONELIST,
           C.EMAIL,
           C.WEBPAGE,

           /* adrese */
           C.ADDRESS,
           C.ADDRESS2,
           C.CITY_ID,
           C.CITY_TITLE,
           (select first 1 AJ.FULL_ADDRESS
            from VW_TS_CUST_ADDR AJ
            where AJ.CUSTOMERID = C.CUSTOMERID and
                  AJ.ADDRTYPEID = 7663
            order by AJ.ADDRID) ADDRESS_JURIDIC,
           (select first 1 AF.FULL_ADDRESS
            from VW_TS_CUST_ADDR AF
            where AF.CUSTOMERID = C.CUSTOMERID and
                  AF.ADDRTYPEID = 7662
            order by AF.ADDRID) ADDRESS_FIZIC,

           /* date juridice */
           C.IDEN_NUMBER,
           C.VAT_NUMBER,
           C.VAT,
           C.REZIDENT,
           C.CHIEF,
           C.ACCOUNTANT,

           /* date bancare */
           ACC.ACCOUNTNUMBER,
           ACC.ACCOUNTNAME,
           ACC.IBAN,
           ACC.BANKACCOUNT,
           B.BANKNAME,
           B.SWIFT_BIC,
           B.ADDRESS,
           ACC.DEFAULT_ACCOUNT

    from VW_TS_CUSTOMER C
    left outer join TS_CUST_ACCOUNTS ACC on (ACC.CUSTOMERID = C.CUSTOMERID and
          ACC.ACCOUNTNUMBER = coalesce(:FACCOUNTNUMBER,
              (select first 1 D.ACCOUNTNUMBER
               from TS_CUST_ACCOUNTS D
               where D.CUSTOMERID = C.CUSTOMERID
               order by D.DEFAULT_ACCOUNT desc, D.ACCOUNTNUMBER)))
    left outer join TS_BANKS B on (B.BANKACCOUNT = ACC.BANKACCOUNT)
    where C.CUSTOMERID = :FCUSTOMERID
    INTO :CUSTOMERID,
         :PARENTID,
         :FLG_FOLDER,
         :PREFIXNAME,
         :NAME,
         :SUFIXNAME,
         :DISPLAYNAME,
         :ORG_PARENT_ID,
         :CUSTOMER_TYPE_ID,
         :CUSTOMER_TYPE_TITLE,
         :CUSTOMER_STATUS_ID,
         :CUSTOMER_STATUS_TITLE,
         :FLG_FURNIZOR,
         :FLG_CUMPARATOR,
         :PRICECOLUMN,
         :RRP_DISCOUNT,
         :BIRTH_DATE,
         :GENDER,
         :USERID,
         :USER_NAME,
         :TELEFON1,
         :MOBILE,
         :PHONELIST,
         :EMAIL,
         :WEBPAGE,
         :ADDRESS,
         :ADDRESS2,
         :CITY_ID,
         :CITY_TITLE,
         :ADDRESS_JURIDIC,
         :ADDRESS_FIZIC,
         :IDEN_NUMBER,
         :VAT_NUMBER,
         :FLG_VAT,
         :REZIDENT,
         :CHIEF,
         :ACCOUNTANT,
         :ACCOUNTNUMBER,
         :ACCOUNTNAME,
         :IBAN,
         :BANKACCOUNT,
         :BANKNAME,
         :BANK_SWIFT,
         :BANK_ADDRESS,
         :DEFAULT_ACCOUNT
  DO
  BEGIN
    SUSPEND;
  END
END^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE RP_GET_CUSTOMER_HEADER TO PUBLIC;

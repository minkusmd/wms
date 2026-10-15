/* ============================================================================
   SELECT_CUSTOMERS - cautarea rapida de clienti (frmCustomersDlg, "Nomenclator clienti")
   NEURON Grup SRL, 13 octombrie 2026

   Problema: la o cautare cu ~10 000 de rezultate (ex. "ION") primul ecran venea in 2,8 s:
     - pentru fiecare client gasit procedura facea un SELECT DISTINCT ... ORDER BY pe
       VW_TS_CUSTOMER (telefoane, e-mail, 4 subselecturi pe rind);
     - WMS punea ORDER BY peste toata procedura -> serverul calcula si sorta toti clientii
       inainte de primul rind.
   Acum (tipurile 3, 5, 6, 7, 8, 9): ID-urile se sorteaza o data dupa nume, se pastreaza primii
   ALIMIT (implicit 1000), iar rindul complet se citeste doar pentru ei. Iesirea noua
   TOTAL_FOUND = numarul total de clienti gasiti (WMS arata "primii 1000 din N").
   Rasfoirea pe foldere (tipurile 1, 2, 4) e copiata neschimbata.

   Parametru nou ALIMIT (la sfarsit, cu valoare implicita) si iesire noua TOTAL_FOUND: nicio
   alta procedura / view nu depinde de SELECT_CUSTOMERS (RDB$DEPENDENCIES, 13.10.2026); in cod o
   foloseste doar frmCustomersDlg (SELECT A.* ...).
   Generat din sursa de pe SW din 13.10.2026; testat pe o copie locala a schemei.
   Script RE-RULABIL (CREATE OR ALTER).
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SELECT_CUSTOMERS (
    APARENTID DM_INTEGER_NN,
    ASELECTTYPE DM_INTEGER_NN DEFAULT 1,
    ACUSTOMWHERE DM_VARCHAR255 DEFAULT '',
    ALIMIT INTEGER DEFAULT 1000)
RETURNS (
    CUSTOMERID DM_INTEGER,
    PARENTID DM_INTEGER,
    FLG_FOLDER DM_BOOLEAN,
    PREFIXNAME DM_VARCHAR10,
    NAME DM_VARCHAR255,
    SUFIXNAME DM_VARCHAR10,
    DISPLAYNAME DM_VARCHAR280,
    ORG_PARENT_ID DM_INTEGER,
    CUSTOMER_TYPE_ID DM_INTEGER,
    CUSTOMER_STATUS_ID DM_INTEGER,
    VAT DM_SMALLINT,
    ORDERNO DM_INTEGER,
    CHIEF DM_VARCHAR128,
    ACCOUNTANT DM_VARCHAR128,
    TELEFON1 DM_VARCHAR128,
    TELEFON2 DM_VARCHAR128,
    MOBILE DM_VARCHAR128,
    FAX DM_VARCHAR128,
    IDEN_NUMBER DM_VARCHAR128,
    VAT_NUMBER DM_VARCHAR128,
    EMAIL DM_VARCHAR255,
    ADDRESS DM_VARCHAR1024,
    ADDRESS2 DM_VARCHAR1024,
    REZIDENT DM_CHAR1,
    CITY_ID DM_INTEGER,
    ACCOUNTNUMBER DM_VARCHAR128,
    PRICECOLUMN DM_SMALLINT,
    CUSTOMER_TYPE_TITLE DM_VARCHAR60,
    CUSTOMER_STATUS_TITLE DM_VARCHAR60,
    CITY_TITLE DM_VARCHAR60,
    USERID DM_INTEGER,
    USER_NAME DM_VARCHAR512,
    BIRTH_DATE DM_DATE,
    IMAGE_INDEX DM_INTEGER,
    WEBPAGE DM_VARCHAR255,
    GENDER CHAR(1),
    FLG_FURNIZOR DM_INTEGER,
    FLG_CUMPARATOR DM_INTEGER,
    RRP_DISCOUNT DM_AMOUNT,
    TOTAL_FOUND INTEGER)
AS
declare variable v_id integer;
declare variable v_sql varchar(2000);
declare variable v_src varchar(500);
begin
  /*
       ASelectType cases:
       1: select from current group
       2: select upper group
       3: select from "ACustomWhere" condition
       4: NEW. select only customer
       5: telefon, 6/7: IDNO, 8: cautare avansata, 9: e-mail

     Cautarea (3, 5-9), 13.10.2026: intii doar ID-urile, sortate o data dupa nume si limitate
     la ALIMIT (implicit 1000); abia apoi rindul complet din VW_TS_CUSTOMER, doar pentru cei
     returnati. TOTAL_FOUND = citi clienti s-au gasit in total (WMS spune cind lista e taiata).
     Inainte: cite un SELECT DISTINCT ... ORDER BY pe view pentru fiecare client gasit, plus
     ORDER BY peste toata procedura in WMS -> 2,8 s pina la primul rind la ~10 000 de clienti.
     Rasfoirea (1, 2, 4) e neschimbata. TELEFON2 a fost mereu NULL.
  */
  total_found = null;
  if (coalesce(alimit, 0) <= 0) then
    alimit = 1000;

  if (aselecttype in (3, 5, 6, 7, 8, 9)) then
  begin
    if (aselecttype = 3) then
    begin
      /* conditia vine din WMS si foloseste coloanele view-ului (si VW_TS_CUSTOMER.CUSTOMERID),
         deci view-ul ramine fara alias; se citesc doar coloanele din conditie + NAME */
      v_sql = 'SELECT FIRST ' || alimit || ' CUSTOMERID, COUNT(*) OVER () FROM VW_TS_CUSTOMER WHERE '
              || acustomwhere || ' AND (FLG_FOLDER = 0) AND (CUSTOMERID <> -1) ORDER BY NAME';
      for execute statement v_sql
          into :v_id, :total_found
      do
      begin
        select
            customerid, parentid, flg_folder, prefixname, name, sufixname, displayname,
            org_parent_id, customer_type_id, customer_status_id, vat, orderno, chief, accountant,
            telefon1, NULL, mobile, fax, iden_number, vat_number, email, address, address2,
            rezident, city_id, accountnumber, pricecolumn, customer_type_title,
            customer_status_title, city_title, userid, user_name, birth_date, image_index, webpage,
            gender, flg_furnizor, flg_cumparator, rrp_discount
        from vw_ts_customer
        where customerid = :v_id
        into
            :customerid, :parentid, :flg_folder, :prefixname, :name, :sufixname, :displayname,
            :org_parent_id, :customer_type_id, :customer_status_id, :vat, :orderno, :chief,
            :accountant, :telefon1, :telefon2, :mobile, :fax, :iden_number, :vat_number, :email,
            :address, :address2, :rezident, :city_id, :accountnumber, :pricecolumn,
            :customer_type_title, :customer_status_title, :city_title, :userid, :user_name,
            :birth_date, :image_index, :webpage, :gender, :flg_furnizor, :flg_cumparator,
            :rrp_discount;
        suspend;
      end
    end
    else
    begin
      if (aselecttype = 5) then
        v_src = 'SELECT DISTINCT CUSTOMERID FROM TS_CUST_PHONES WHERE PHONENUMBER CONTAINING :W';
      else if (aselecttype in (6, 7)) then
        v_src = 'SELECT DISTINCT CUSTOMERID FROM TS_CUST_INFO WHERE IDEN_NUMBER = :W';
      else if (aselecttype = 8) then
        v_src = 'SELECT CUSTOMERID FROM SP_ADVANCED_CUSTOMER_SEARCH(:W)';
      else
        v_src = 'SELECT CUSTOMERID FROM TS_CUST_EMAILS WHERE EMAIL LIKE LOWER(:W)'
                || ' UNION SELECT CUSTOMERID FROM TS_CUST_WEB WHERE EMAIL LIKE LOWER(:W)';

      v_sql = 'SELECT FIRST ' || alimit || ' C.CUSTOMERID, COUNT(*) OVER () FROM (' || v_src || ') S'
              || ' JOIN TS_CUSTOMER C ON C.CUSTOMERID = S.CUSTOMERID WHERE C.FLG_FOLDER = 0 ORDER BY C.NAME';
      for execute statement (v_sql) (W := acustomwhere)
          into :v_id, :total_found
      do
      begin
        select
            customerid, parentid, flg_folder, prefixname, name, sufixname, displayname,
            org_parent_id, customer_type_id, customer_status_id, vat, orderno, chief, accountant,
            telefon1, NULL, mobile, fax, iden_number, vat_number, email, address, address2,
            rezident, city_id, accountnumber, pricecolumn, customer_type_title,
            customer_status_title, city_title, userid, user_name, birth_date, image_index, webpage,
            gender, flg_furnizor, flg_cumparator, rrp_discount
        from vw_ts_customer
        where customerid = :v_id
        into
            :customerid, :parentid, :flg_folder, :prefixname, :name, :sufixname, :displayname,
            :org_parent_id, :customer_type_id, :customer_status_id, :vat, :orderno, :chief,
            :accountant, :telefon1, :telefon2, :mobile, :fax, :iden_number, :vat_number, :email,
            :address, :address2, :rezident, :city_id, :accountnumber, :pricecolumn,
            :customer_type_title, :customer_status_title, :city_title, :userid, :user_name,
            :birth_date, :image_index, :webpage, :gender, :flg_furnizor, :flg_cumparator,
            :rrp_discount;
        suspend;
      end
    end
  end
  else
  if (aselecttype = 2 or aselecttype = 1) then
  begin

    if (aselecttype = 2) then
      select
          parentid
      from ts_customer
      where (customerid = :aparentid)
      into :aparentid;

    /* select only folders */
    for select
            customerid, parentid, flg_folder, prefixname, name, sufixname, displayname, org_parent_id, customer_type_id,
            customer_status_id, vat, orderno, chief, accountant, telefon1, mobile, fax, iden_number, vat_number, email,
            address, address2, rezident, city_id, accountnumber, pricecolumn, customer_type_title,
            customer_status_title, city_title, userid, user_name, birth_date, image_index, gender, flg_furnizor, flg_cumparator,
            rrp_discount
        from vw_ts_customer
        where (parentid = :aparentid) and
              (flg_folder = 1) and
              (customerid <> -1)
        order by orderno, name
        into :customerid, :parentid, :flg_folder, :prefixname, :name, :sufixname, :displayname, :org_parent_id,
             :customer_type_id, :customer_status_id, :vat, :orderno, :chief, :accountant, :telefon1, :mobile, :fax,
             :iden_number, :vat_number, :email, :address, :address2, :rezident, :city_id, :accountnumber, :pricecolumn,
             :customer_type_title, :customer_status_title, :city_title, :userid, :user_name, :birth_date, :image_index,
             :gender, :flg_furnizor, :flg_cumparator, :rrp_discount
    do
      suspend;

    /* select only customers */
    for select
            customerid, parentid, flg_folder, prefixname, name, sufixname, displayname, org_parent_id, customer_type_id,
            customer_status_id, vat, orderno, chief, accountant, telefon1, mobile, fax, iden_number, vat_number, email,
            address, address2, rezident, city_id, accountnumber, pricecolumn, customer_type_title,
            customer_status_title, city_title, userid, user_name, birth_date, image_index, webpage, gender, flg_furnizor, flg_cumparator,
            rrp_discount
        from vw_ts_customer
        where (parentid = :aparentid) and
              (flg_folder = 0) and
              (customerid <> -1)
        order by name
        into :customerid, :parentid, :flg_folder, :prefixname, :name, :sufixname, :displayname, :org_parent_id,
             :customer_type_id, :customer_status_id, :vat, :orderno, :chief, :accountant, :telefon1, :mobile, :fax,
             :iden_number, :vat_number, :email, :address, :address2, :rezident, :city_id, :accountnumber, :pricecolumn,
             :customer_type_title, :customer_status_title, :city_title, :userid, :user_name, :birth_date, :image_index,
             :webpage, :gender, :flg_furnizor, :flg_cumparator, :rrp_discount
    do
      suspend;

  end
  else
  if (aselecttype = 4) then
  begin
    for select
            customerid, parentid, flg_folder, prefixname, name, sufixname, displayname, org_parent_id, customer_type_id,
            customer_status_id, vat, orderno, chief, accountant, telefon1, mobile, fax, iden_number, vat_number, email,
            address, address2, rezident, city_id, accountnumber, pricecolumn, customer_type_title,
            customer_status_title, city_title, userid, user_name, birth_date, image_index, webpage, gender, flg_furnizor, flg_cumparator,
            rrp_discount
        from vw_ts_customer
        where (customerid = :aparentid) and
              (flg_folder = 0) and
              (customerid <> -1)
        order by name
        into :customerid, :parentid, :flg_folder, :prefixname, :name, :sufixname, :displayname, :org_parent_id,
             :customer_type_id, :customer_status_id, :vat, :orderno, :chief, :accountant, :telefon1, :mobile, :fax,
             :iden_number, :vat_number, :email, :address, :address2, :rezident, :city_id, :accountnumber, :pricecolumn,
             :customer_type_title, :customer_status_title, :city_title, :userid, :user_name, :birth_date, :image_index,
             :webpage, :gender, :flg_furnizor, :flg_cumparator, :rrp_discount
    do
      suspend;
  end
end^

SET TERM ; ^

COMMIT;

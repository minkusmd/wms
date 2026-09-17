/*
  Cerere de finantare cu credit 0%: pretul liniilor de produs se calculeaza din
  pretul de rate GET_GOODS_PRICE_CREDIT0 (= pretul optiunii 0% din widgetul de pe
  site), nu din pretul cash trimis de site, care poate fi mai mic.

  1. TWEB_CERERE_FINANTARE.CREDIT_TYPE - procentul creditului ales de client
     ('0' = 0%); pina acum ajungea doar in comentariul documentului.
  2. SP_WEB_REGISTER_FINANTARE salveaza CREDIT_TYPE.
  3. SP_ADD_GOODS_FINANTARE: daca cererea e 0%, PRICE = GET_GOODS_PRICE_CREDIT0.
     Pentru celelalte tipuri de credit pretul ramane cel trimis de site.

  Re-rulabil. Rollback: finantare_credit0_price_rollback.sql
*/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE'
                   AND RDB$FIELD_NAME = 'CREDIT_TYPE')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD CREDIT_TYPE DM_VARCHAR32';
END ^

SET TERM ; ^

COMMIT;

SET TERM ^ ;

ALTER PROCEDURE SP_WEB_REGISTER_FINANTARE (CREDIT_SUMA DM_PRICE NOT NULL,
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
DELIVERYADDRESS DM_VARCHAR255 = '')
RETURNS (DOCID DM_INTEGER)
AS 
declare variable TIP_CREDIT varchar(128);
BEGIN
     /* pentru aceasta procedure trebuie UserContext de create */
     RDB$SET_CONTEXT('USER_SESSION', 'UserID', 9); /* WebUser */
     RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

--    in autonomous transaction do
--        insert into tdb_debug (text) values ('1. Cerere de finantare. Start.');

    /* create DOC, WebUser, FLG_ACNT */
    INSERT INTO TDB_DOCS
    (DT, CT, DTDEP, CTDEP, DTSC, CURRENCYID, DOCTYPEID, CREATED_BY, RATE, RATEUSD, FLAGS)
    VALUES
    (iif(current_date>='17.09.2024', 307225, 218482), 286, 43, 43, 5108, 498, 1791, 9, 1, NULL, 2)
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
    EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(218482,7,:NPP,:DOCID,9); /* WebUser */

--    in autonomous transaction do
--    insert into tdb_debug (text) values ('8. Cerere de finantare. Trimitem SMS pe numarul de telefon :contact_telefon');

    insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
    values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

    SUSPEND;
END ^

ALTER PROCEDURE SP_ADD_GOODS_FINANTARE (DOCID DM_INTEGER,
GOODSID DM_INTEGER,
QTY DM_QTY,
PRICE DM_PRICE)
AS 
declare UMID DM_INTEGER;
declare WARANTY DM_INTEGER;
declare V_CREDIT_TYPE DM_VARCHAR32;
declare V_PRICE_CREDIT0 DM_AMOUNT;
declare V_PRICE_SITE DM_PRICE;
begin
  /* Procedure Text */
  /* pentru aceasta procedure trebuie UserContext de create */
  rdb$set_context('USER_SESSION', 'UserID', 9);/* WebUser */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  select UMID, G.WARRANTY
  from TS_GOODS G
  where GOODSID = :GOODSID
  into :UMID, :WARANTY;

  V_PRICE_SITE = :PRICE;

  /* credit 0%: se finanteaza pretul de rate, care poate depasi pretul cash
     (acopera comisionul bancii). Acelasi calcul ca optiunea 0% din
     WEB_GET_GOODS_CREDIT_MONTLY_RATE, rotunjit ca pe site. */
  select trim(F.CREDIT_TYPE)
  from TWEB_CERERE_FINANTARE F
  where F.DOCID = :DOCID
  into :V_CREDIT_TYPE;

  if (:V_CREDIT_TYPE similar to '0+([.,]0+)?') then
  begin
    select C.PRICE_MDL
    from GET_GOODS_PRICE_CREDIT0(:GOODSID) C
    into :V_PRICE_CREDIT0;

    if (coalesce(:V_PRICE_CREDIT0, 0) > 0) then
      PRICE = round(:V_PRICE_CREDIT0, 0);
  end

  insert into TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID, QTY, PRICE, WARRANTY, STOCK_QTY)
  values (:DOCID, 43, -1, -1, :GOODSID, :umid, :qty,  :PRICE, :WARANTY, 0);

  insert into tdb_debug(text)
  values ('Cerere finantare nr '||:DOCID||','||
          'Goodsid='||:GoodsID||', '||
          'QTY='||:qty||', '||
          'PRICE='||:price||
          iif(:PRICE is distinct from :V_PRICE_SITE,
              ', credit 0% (pret site='||coalesce(:V_PRICE_SITE, 0)||')', '')
  );
end ^

SET TERM ; ^

GRANT SELECT ON TWEB_CERERE_FINANTARE TO PROCEDURE SP_ADD_GOODS_FINANTARE;
GRANT EXECUTE ON PROCEDURE GET_GOODS_PRICE_CREDIT0 TO PROCEDURE SP_ADD_GOODS_FINANTARE;

COMMIT;

/* SP_WEB_REGISTER_FINANTARE - cererile de finantare de pe site trec pe firma 316910
   (SOLUTII COMERCIALE SRL), la fel ca WEB_CREATE_TRANSACTION3 / _PHONE2 / _ECOMM.
   Modificari: DT-ul documentului 1791 si firma din PROC_CREATE_DT_EVENT (218482 -> 316910).
   Necesita randul (1791, 316910) in TS_DOCTYPES_DEFVALUES (exista din 17.09.2026).
   NEURON Grup SRL, 18 septembrie 2026 */

SET TERM ^ ;

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
    EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(316910,7,:NPP,:DOCID,9); /* WebUser; inainte 218482 */

--    in autonomous transaction do
--    insert into tdb_debug (text) values ('8. Cerere de finantare. Trimitem SMS pe numarul de telefon :contact_telefon');

    insert into SMS_MESSAGES (PHONE, SMS_TEXT, CREATED_BY)
    values (:CONTACT_TELEFON, 'Cererea de finantare a fost primita. Transmiteti pe email-ul salut@fantastic.md copia buletinului de identitate scanat ambele parti. In scurt timp veti fi contactat de operatori pentru detalii. Va multumim! Fantastic.md', 9);

    SUSPEND;
END ^

SET TERM ; ^
COMMIT;

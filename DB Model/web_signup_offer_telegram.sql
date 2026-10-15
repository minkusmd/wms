/* ============================================================================
   Notificare Telegram la fiecare inregistrare noua din popup-ul "Cadou de bun
   venit" de pe site (web_signup_offer.sql, tabela TWEB_SIGNUP_OFFER).

   Triggerul TWEB_SIGNUP_OFFER_AI_TELEGRAM pune in coada (SP_TELEGRAM_SEND,
   telegram_messages.sql) un mesaj pe canalul WEB_ORDERS - chat-ul "Online ::
   Fantastic" (-396162298), acelasi in care ajung comenzile de pe site - cu
   numarul de telefon al clientului, data si ora inregistrarii, procentul si
   data expirarii reducerii. Il trimite SWNService (TSWNTelegramService).

   Telefonul: TS_CUST_WEB.PHONE_NUMBER (pus de CREATE_CUSTOMER_WEB_CREDENTIALS2),
   altfel primul numar din TS_CUST_PHONES.

   Ca TDB_DOCS_AI_TELEGRAM: SQL SECURITY DEFINER (site-ul scrie ca WEBUSER),
   orice eroare la notificare e inghitita - inregistrarea nu trebuie sa cada
   din cauza Telegramului.

   Necesita: web_signup_offer.sql si telegram_messages.sql rulate.
   Script RE-RULABIL (15.10.2026).
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER TRIGGER TWEB_SIGNUP_OFFER_AI_TELEGRAM FOR TWEB_SIGNUP_OFFER
ACTIVE AFTER INSERT POSITION 950
SQL SECURITY DEFINER
AS
  DECLARE VARIABLE V_PHONE   VARCHAR(60);
  DECLARE VARIABLE V_NAME    VARCHAR(255);
  DECLARE VARIABLE V_TS      TIMESTAMP;
  DECLARE VARIABLE V_WHEN    VARCHAR(20);
  DECLARE VARIABLE V_EXPIRES VARCHAR(10);
  DECLARE VARIABLE V_PERCENT VARCHAR(10);
  DECLARE VARIABLE NL        CHAR(1);
  DECLARE VARIABLE MSG       VARCHAR(1024);
BEGIN
  NL = ASCII_CHAR(10);

  V_PHONE = NULL;
  SELECT FIRST 1 W.PHONE_NUMBER FROM TS_CUST_WEB W
  WHERE W.CUSTOMERID = NEW.CUSTOMERID AND COALESCE(W.PHONE_NUMBER, '') <> ''
  INTO :V_PHONE;
  IF (V_PHONE IS NULL) THEN
    SELECT FIRST 1 P.PHONENUMBER FROM TS_CUST_PHONES P
    WHERE P.CUSTOMERID = NEW.CUSTOMERID
    ORDER BY P.PHONETYPEID
    INTO :V_PHONE;

  V_NAME = NULL;
  SELECT C.NAME FROM TS_CUSTOMER C WHERE C.CUSTOMERID = NEW.CUSTOMERID INTO :V_NAME;

  /* data si ora inregistrarii: DD.MM.YYYY HH:MM */
  V_TS = COALESCE(NEW.CREATED_DATE, CURRENT_TIMESTAMP);
  V_WHEN = LPAD(EXTRACT(DAY FROM V_TS), 2, '0') || '.' || LPAD(EXTRACT(MONTH FROM V_TS), 2, '0') || '.'
        || EXTRACT(YEAR FROM V_TS) || ' '
        || LPAD(EXTRACT(HOUR FROM V_TS), 2, '0') || ':' || LPAD(EXTRACT(MINUTE FROM V_TS), 2, '0');
  V_EXPIRES = LPAD(EXTRACT(DAY FROM NEW.EXPIRES_DATE), 2, '0') || '.'
           || LPAD(EXTRACT(MONTH FROM NEW.EXPIRES_DATE), 2, '0') || '.' || EXTRACT(YEAR FROM NEW.EXPIRES_DATE);
  /* 5.00 -> 5, 7.50 -> 7.5 */
  V_PERCENT = TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM CAST(NEW.DISCOUNT_PERCENT AS VARCHAR(10))));

  MSG = _UTF8 X'F09F8E81' || ' <b>Inregistrare noua din popup (reducere ' || V_PERCENT || '%)</b>'
     || NL || 'Telefon: <code>' || FN_TELEGRAM_HTML(COALESCE(V_PHONE, '-')) || '</code>'
     || NL || 'Data: ' || V_WHEN
     || NL || 'Client #' || NEW.CUSTOMERID || COALESCE(' ' || FN_TELEGRAM_HTML(V_NAME), '')
     || NL || 'Reducerea e valabila pina pe ' || V_EXPIRES || ' (prima comanda)';

  EXECUTE PROCEDURE SP_TELEGRAM_SEND('WEB_ORDERS', :MSG, 'HTML', -1, NEW.CUSTOMERID, 10);

  WHEN ANY DO
  BEGIN
  END
END^

SET TERM ; ^

COMMIT;

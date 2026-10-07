/* Rollback pentru telegram_messages.sql (3.10.2026).

   Scoate legaturile cu obiectele existente (trigger pe TDB_DOCS, alerta din
   TRG_SMS_MESSAGES_AU0 - corpul original de pe SW, citit 3.10.2026).
   Tabelele TELEGRAM_* si TS_API_CONFIG (TELEGRAM) raman; pentru stergerea lor
   completa decomenteaza blocul de la final. */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$TRIGGERS WHERE RDB$TRIGGER_NAME = 'TDB_DOCS_AI_TELEGRAM')) THEN
    EXECUTE STATEMENT 'DROP TRIGGER TDB_DOCS_AI_TELEGRAM';
END^

CREATE OR ALTER TRIGGER TRG_SMS_MESSAGES_AU0 FOR SMS_MESSAGES
ACTIVE AFTER UPDATE POSITION 0
AS
BEGIN
     /* Verificam daca ne trebuie trigerii  */
     IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS')='YES') THEN EXIT;
     /*-----------------------------------------------------------------------*/

     /* daca nu s-a expediat SMS, notificam administratia */
     IF (OLD.RETRY_COUNT<=3 AND OLD.FLG_SENT=0 and old.sent_status <> 0) THEN
     BEGIN
          INSERT INTO EMAIL_MESSAGES (EMAIL,SUBJECT, "BODY",SOURCE_TABLE)
          VALUES ('sergiu@fantastic.md','SYSTEM ALERT - Nu pot trimite SMS','Nu pot trimite SMS la numarul '||OLD.PHONE||'. Verificati contragentul sau daca sunt bani pentru SMS-uri.',4);
     END
END^

SET TERM ; ^

COMMIT;

/* Stergere completa (optional):
DROP PROCEDURE SP_TELEGRAM_BUILD_TEXT;
DROP PROCEDURE SP_TELEGRAM_SEND;
DROP FUNCTION FN_TELEGRAM_MONEY;
DROP FUNCTION FN_TELEGRAM_HTML;
DROP TABLE TELEGRAM_MESSAGES;
DROP TABLE TELEGRAM_CHANNELS;
DROP SEQUENCE SQ_TELEGRAM_MESSAGES_ID;
DELETE FROM TS_API_CONFIG WHERE API_CODE = 'TELEGRAM';
COMMIT;
*/

/* Canalul Telegram PRICELISTS - rezultatul importurilor de preturi din WMSParsers
   (Parsers/ParserRunnerUnit.NotifyParserRun): un mesaj pe rulare cu fiecare job de pret.
   Erorile parserelor merg in canalul ERRORS. SOURCE_TABLE = -30 in TELEGRAM_MESSAGES.

   Chat-ul = cel al canalului WEB_ORDERS ("Online :: Fantastic"); se poate schimba din
   WMS: Setari > Notificari Telegram. Script repetabil (3.10.2026). */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM TELEGRAM_CHANNELS WHERE CHANNEL_CODE = 'PRICELISTS')) THEN
    INSERT INTO TELEGRAM_CHANNELS (CHANNEL_CODE, TITLE, CHAT_ID, FLG_ACTIVE, NOTE)
    SELECT 'PRICELISTS', 'Importuri de preturi (WMSParsers)',
           (SELECT CHAT_ID FROM TELEGRAM_CHANNELS WHERE CHANNEL_CODE = 'WEB_ORDERS'), 1,
           'Rezultatul rularilor WMSParsers (pricelisturi API, preturi h-t.md / maximum.md)'
      FROM RDB$DATABASE;
END^

SET TERM ; ^

COMMIT;

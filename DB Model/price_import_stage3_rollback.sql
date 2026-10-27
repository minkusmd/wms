/* ============================================================================
   Rollback pentru price_import_stage3.sql (PriceImport, etapa 3 - botul Telegram).
   Fisierele salvate pe disc (PriceImport/data/inbox) raman. Script RE-RULABIL (28.10.2026).
   ============================================================================ */

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_FILE_RULE')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPI_FILE_RULE';
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_INBOX_FILE')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPI_INBOX_FILE';
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_BOT_USER')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPI_BOT_USER';
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_BOT_STATE')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPI_BOT_STATE';
END^
SET TERM ; ^
COMMIT;

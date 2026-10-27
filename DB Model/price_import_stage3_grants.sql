/* ============================================================================
   Drepturile utilizatorului PRICEIMPORT pentru etapa 3 (botul Telegram). Dupa price_import_stage3.sql,
   de DBA, ca SYSDBA. Re-rulabil (28.10.2026).
   ============================================================================ */

GRANT SELECT ON TPI_BOT_USER TO USER PRICEIMPORT;
GRANT SELECT, INSERT, UPDATE ON TPI_INBOX_FILE TO USER PRICEIMPORT;
GRANT SELECT, INSERT, UPDATE ON TPI_FILE_RULE TO USER PRICEIMPORT;
GRANT SELECT, INSERT, UPDATE, DELETE ON TPI_BOT_STATE TO USER PRICEIMPORT;

COMMIT;

/* ============================================================================
   Drepturile utilizatorului PRICEIMPORT pentru etapa 4a (potrivirea produselor). Dupa price_import_stage4.sql,
   de DBA, ca SYSDBA. Re-rulabil (28.10.2026). Legatura se face doar prin SP_PI_LINK_GOODS (DEFINER):
   serviciul nu primeste INSERT pe TS_GOODS_FOREIGN.
   ============================================================================ */

GRANT SELECT, INSERT, UPDATE ON TPI_MATCH_CANDIDATE TO USER PRICEIMPORT;
GRANT EXECUTE ON PROCEDURE SP_PI_LINK_GOODS TO USER PRICEIMPORT;
GRANT SELECT ON TS_SYSS TO USER PRICEIMPORT;

COMMIT;

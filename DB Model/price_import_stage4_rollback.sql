/* ============================================================================
   Rollback pentru price_import_stage4.sql (PriceImport, etapa 4a - potrivirea produselor).
   Legaturile deja facute in TS_GOODS_FOREIGN raman (sint rinduri WMS obisnuite).
   Script RE-RULABIL (28.10.2026).
   ============================================================================ */

SET TERM ^ ;
EXECUTE BLOCK AS
BEGIN
  IF (EXISTS (SELECT 1 FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = 'SP_PI_LINK_GOODS')) THEN
    EXECUTE STATEMENT 'DROP PROCEDURE SP_PI_LINK_GOODS';
  IF (EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_MATCH_CANDIDATE')) THEN
    EXECUTE STATEMENT 'DROP TABLE TPI_MATCH_CANDIDATE';
END^
SET TERM ; ^
COMMIT;

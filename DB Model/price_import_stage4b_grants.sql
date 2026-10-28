/* ============================================================================
   Drepturile utilizatorului PRICEIMPORT pentru etapa 4b (continutul produselor). Dupa
   price_import_stage4b.sql, de DBA, ca SYSDBA. Re-rulabil (28.10.2026).
   Staging-ul (TS_PRICELIST_ITEMS_DESCRIPTION / _IMAGES) il scrie serviciul direct; in productie
   (TS_GOODS_IMAGE / TS_GOODS_DSC) ajunge doar prin SP_PI_CONTENT_TRANSFER (DEFINER).
   ============================================================================ */

GRANT SELECT, INSERT, UPDATE, DELETE ON TS_PRICELIST_ITEMS_DESCRIPTION TO USER PRICEIMPORT;
GRANT SELECT, INSERT, UPDATE, DELETE ON TS_PRICELIST_ITEMS_IMAGES TO USER PRICEIMPORT;
GRANT SELECT, INSERT, UPDATE ON TPI_CONTENT_RUN TO USER PRICEIMPORT;
GRANT EXECUTE ON PROCEDURE SP_PI_CONTENT_TRANSFER TO USER PRICEIMPORT;
/* doar existenta: imaginile se descarca pentru produsele care nu au niciuna */
GRANT SELECT ON TS_GOODS_IMAGE TO USER PRICEIMPORT;

COMMIT;

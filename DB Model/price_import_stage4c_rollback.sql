/* ============================================================================
   Rollback pentru price_import_stage4c.sql: cei 5 furnizori revin pe 'external_plid' (serviciul citeste
   din nou pricelistul creat de WMSParsers / frame78). Datele de acces ACCENT din TS_API_CONFIG raman
   (nu strica nimic; se sterg manual daca e nevoie). Re-rulabil (28.10.2026).
   ============================================================================ */

UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'external_plid', NOTE = 'Accent (WMSParsers / frame78)' WHERE SUPPLIERID = 198;
UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'external_plid', NOTE = 'DMLink (WMSParsers)' WHERE SUPPLIERID = 229466;
UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'external_plid', NOTE = 'Olis Grup (WMSParsers)' WHERE SUPPLIERID = 251465;
UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'external_plid', NOTE = 'NexDistribution (WMSParsers)' WHERE SUPPLIERID = 275640;
UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'external_plid', NOTE = 'Triomac (WMSParsers)' WHERE SUPPLIERID = 209280;

COMMIT;

SELECT SUPPLIERID, ADAPTER_CODE, NOTE FROM TPI_SUPPLIER ORDER BY SUPPLIERID;

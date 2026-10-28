/* ============================================================================
   PriceImport - etapa 4c: cei 5 furnizori din WMSParsers trec pe adaptoarele Python native
   Plan: Documents/plan-import-automat-pricelisturi-2026-10-27.md. Cere price_import_stage1..4.sql.

     198     Accent Electronic   accent    (b2brestful.accent.md:8090)
     229466  DMLink              dmlink    (b2b.dmlink.md)
     251465  Olis Grup           olisgrup  (price.muncitorul.md)
     275640  NexDistribution     nex       (api.nexdistribution.md)
     209280  Triomac (SCOP)      triomac   (scop.md/api/partner/v2)

   Pina acum TPI_SUPPLIER.ADAPTER_CODE = 'external_plid': serviciul citea pricelistul creat de
   WMSParsers / frame78. Dupa script serviciul descarca singur, scrie pricelistul (TS_PRICELISTS,
   FLAGS = 2) doar cind aplica, apoi face reevaluarile. Descrierile si imaginile raman la
   WMSParsers / frame78 pina la etapa 4b.

   Accent: datele de acces erau scrise in cod (ApiAccentUnit.pas, TApiAccent.Connect); aici ajung in
   TS_API_CONFIG, API_CODE = 'ACCENT'. Inainte de rulare inlocuiti __ACCENT_PASSWORD__ cu valoarea
   "userpassword" din TApiAccent.Connect. Daca ramine neinlocuit, Accent nu se muta (ramine external_plid).

   Script RE-RULABIL (28.10.2026). Rollback: price_import_stage4c_rollback.sql
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
  DECLARE PWD VARCHAR(100) = '__ACCENT_PASSWORD__';
BEGIN
  UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
  VALUES ('ACCENT', 'USERNAME', 'Fantastic.APIUser', 198, 1,
          'Login b2brestful.accent.md (POST /loginuser/getid, userlogin)', 'SYSTEM')
  MATCHING (API_CODE, PARAM_NAME);

  UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
  VALUES ('ACCENT', 'BASE_URL', 'http://b2brestful.accent.md:8090', 198, 1,
          'Rutele /loginuser/getid si /hard/{guid}/catalogandstock/0', 'SYSTEM')
  MATCHING (API_CODE, PARAM_NAME);

  IF (PWD <> '__ACCENT_PASSWORD__') THEN
    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('ACCENT', 'PASSWORD', :PWD, 198, 1, 'userpassword (hash-ul trimis de API, nu parola contului)', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);

  IF (EXISTS (SELECT 1 FROM TS_API_CONFIG WHERE API_CODE = 'ACCENT' AND PARAM_NAME = 'PASSWORD'
                                        AND FLG_ACTIVE = 1 AND COALESCE(PARAM_VALUE, '') <> '')) THEN
    UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'accent', NOTE = 'Accent - adaptor Python nativ (b2brestful.accent.md)'
     WHERE SUPPLIERID = 198;

  UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'dmlink', NOTE = 'DMLink - adaptor Python nativ (b2b.dmlink.md)'
   WHERE SUPPLIERID = 229466;
  UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'olisgrup', NOTE = 'Olis Grup - adaptor Python nativ (price.muncitorul.md)'
   WHERE SUPPLIERID = 251465;
  UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'nex', NOTE = 'NexDistribution - adaptor Python nativ (api.nexdistribution.md)'
   WHERE SUPPLIERID = 275640;
  UPDATE TPI_SUPPLIER SET ADAPTER_CODE = 'triomac', NOTE = 'Triomac - adaptor Python nativ (scop.md, API SCOP v2)'
   WHERE SUPPLIERID = 209280;
END^

SET TERM ; ^

COMMIT;

/* verificare */
SELECT SUPPLIERID, ADAPTER_CODE, NOTE FROM TPI_SUPPLIER ORDER BY SUPPLIERID;
SELECT API_CODE, PARAM_NAME, FLG_ACTIVE, IIF(PARAM_NAME = 'PASSWORD', '***', PARAM_VALUE) AS PARAM_VALUE
  FROM TS_API_CONFIG WHERE API_CODE = 'ACCENT' ORDER BY PARAM_NAME;

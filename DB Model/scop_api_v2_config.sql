/* ============================================================================
   SCOP B2B (TRIOMAC SRL, furnizor 209280) - API de parteneri v2, 17 oct 2026

   Vechiul API (https://api.scop.md, login cu e-mail + parola) e inlocuit de
   https://scop.md/api/partner/v2 cu cheie + secret (scop.md, Cabinet > Integrare).
   Folosit de:
     SCOPAPIClientUnit (sources\b2b.api\scop)      - clientul;
     TriomacPriceListUnit (frame78 + WMSParsers)    - pricelist + descrieri + imagini;
     frmGoodsForeignCodeDlg.GetScopProductStock     - stocul produsului selectat.

   Ce face (se poate rula de mai multe ori):
     API_KEY, API_SECRET - adaugate sau actualizate;
     BASE_URL            - mutat pe https://scop.md/api/partner/v2;
     USERNAME, PASSWORD  - dezactivate (FLG_ACTIVE = 0), nu sterse.
   Secretul se poate schimba ulterior din WMS: Setari > Configurari API.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('SCOP', 'API_KEY', 'scop_uxvnr7yps5n5uo80gkevvcjp', 209280, 1,
            'Cheia API de parteneri v2 (scop.md, Cabinet > Integrare)', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);

    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('SCOP', 'API_SECRET', 'GcmOmuyBe4kZkiT5T9xuziCN0wftRGC3c9Z2FjEGdkplT6fm', 209280, 1,
            'Secretul se schimba pe token (30 min) prin POST /auth/token', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);

    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('SCOP', 'BASE_URL', 'https://scop.md/api/partner/v2', 209280, 1,
            'API de parteneri v2; rutele /auth/token, /catalog/...', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);

    /* login-ul vechi pe e-mail nu mai e folosit */
    UPDATE TS_API_CONFIG
       SET FLG_ACTIVE = 0,
           NOTE = 'API vechi api.scop.md - inlocuit de API_KEY / API_SECRET (17 oct 2026)'
     WHERE API_CODE = 'SCOP'
       AND PARAM_NAME IN ('USERNAME', 'PASSWORD')
       AND FLG_ACTIVE = 1;
END^

SET TERM ; ^

COMMIT;

/* verificare */
SELECT API_CODE, PARAM_NAME, FLG_ACTIVE,
       IIF(PARAM_NAME = 'API_SECRET', '***', PARAM_VALUE) AS PARAM_VALUE
  FROM TS_API_CONFIG
 WHERE API_CODE = 'SCOP'
 ORDER BY FLG_ACTIVE DESC, PARAM_NAME;

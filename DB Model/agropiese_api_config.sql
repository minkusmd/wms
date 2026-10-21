/* ============================================================================
   AgroPiese TGR Grup (furnizor 14805) - API B2B angro.agropiese.md, 20 oct 2026

   GET https://angro.agropiese.md/api/v1/products?api_token=...&page-length=500&page=N
   Folosit de:
     AgroPiesePriceListUnit (sources\frameUtils\78 - Pricelist) - pricelist + descrieri
       (caracteristicile RO/RU) + imagini, din frame78 (butonul API al furnizorului si
       butonul de continut).

   Ce face (se poate rula de mai multe ori):
     API_TOKEN - adaugat sau actualizat;
     BASE_URL  - https://angro.agropiese.md/api/v1 (optional; lipsa = aceeasi valoare).
   Tokenul se poate schimba ulterior din WMS: Setari > Configurari API.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('AGROPIESE', 'API_TOKEN', 'lLH2c6kEX2elWtDZBSLmiUF9evOox2z3kEh7WXuxp4h3zHl8Oj74qTUWHjlB', 14805, 1,
            'Tokenul API B2B angro.agropiese.md (parametrul api_token din URL)', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);

    UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, SUPPLIERID, FLG_ACTIVE, NOTE, UPDATED_BY)
    VALUES ('AGROPIESE', 'BASE_URL', 'https://angro.agropiese.md/api/v1', 14805, 1,
            'Ruta /products, paginare Laravel (page-length 20..500)', 'SYSTEM')
    MATCHING (API_CODE, PARAM_NAME);
END^

SET TERM ; ^

COMMIT;

/* verificare */
SELECT API_CODE, PARAM_NAME, FLG_ACTIVE,
       IIF(PARAM_NAME = 'API_TOKEN', '***', PARAM_VALUE) AS PARAM_VALUE
  FROM TS_API_CONFIG
 WHERE API_CODE = 'AGROPIESE'
 ORDER BY PARAM_NAME;

/* ############################################################################
   CADUC - NU MAI RULATI ACEST SCRIPT (20.08.2026)

   Designul de aici (coloanele FLG_VIRTUAL_CATALOG / VIRTUAL_FILTERID /
   VIRTUAL_FILTERPARAMIDS pe TWEB_CATALOG) NU a fost niciodata aplicat pe baza
   SW: cele trei coloane nu exista, iar bitul 13 din TWEB_CATALOG.FLAGS
   (expus ca FLG_VIRTUAL_CATALOG in VW_TWEB_CATALOG) nu este setat pe niciun
   rand.

   Mapele virtuale au fost implementate altfel - o mapa virtuala este un rand
   in tabela TWEB_CATALOG_VIRTUAL, ceea ce permite mai multe mape per nod:
     - DDL initial : fantastic.web\docs\sql\tweb_catalog_virtual.sql
     - imagine, FLG_TILE, view updatable pentru WMS si arborele pe 4 niveluri:
                     DB Model\tweb_catalog_level4.sql
     - cod site     : fantastic.web\models\CatalogVirtualFolder.php

   Pastrat doar ca referinta istorica.
   ############################################################################ */

/* ============================================================================
   Mape virtuale in webcatalog (pattern vechi TWEB_CATALOG).
   Adauga pe TWEB_CATALOG un flag + un filtru fix (TS_FILTERS) dupa care
   site-ul filtreaza produsele categoriei.

   Re-rulabil: adauga coloanele doar daca lipsesc.
   Ruleaza pe baza SW. Dupa rulare -> RECREEAZA view-ul VW_TWEB_CATALOG
   (vezi sectiunea de la final) ca WMS sa poata scrie cele 3 coloane.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CATALOG'
                   AND RDB$FIELD_NAME = 'FLG_VIRTUAL_CATALOG')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE TWEB_CATALOG ADD FLG_VIRTUAL_CATALOG SMALLINT DEFAULT 0 NOT NULL';

  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CATALOG'
                   AND RDB$FIELD_NAME = 'VIRTUAL_FILTERID')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE TWEB_CATALOG ADD VIRTUAL_FILTERID INTEGER';

  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CATALOG'
                   AND RDB$FIELD_NAME = 'VIRTUAL_FILTERPARAMIDS')) THEN
    EXECUTE STATEMENT
      'ALTER TABLE TWEB_CATALOG ADD VIRTUAL_FILTERPARAMIDS VARCHAR(200)';
END^

SET TERM ; ^

COMMIT;

/* ----------------------------------------------------------------------------
   Semantica:
     FLG_VIRTUAL_CATALOG = 1  -> nodul e mapa virtuala; site-ul pre-aplica filtrul.
     VIRTUAL_FILTERID         -> TS_FILTERS.FILTERID  (atributul, ex. 1739 = Gen)
     VIRTUAL_FILTERPARAMIDS   -> CSV de TS_FILTER_PARAMS.FILTERPARAMID
                                 (ex. '30236' Masculin, sau '30236,30238')
   String filtru site: '<FILTERID>(<paramid>[,<paramid>...]);'  ex. '1739(30236);'
   ---------------------------------------------------------------------------- */

/* ----------------------------------------------------------------------------
   ATENTIE DBA: RECREARE VIEW VW_TWEB_CATALOG
   WMS scrie prin VW_TWEB_CATALOG (INSERT/UPDATE). Cele 3 coloane noi trebuie
   adaugate in SELECT-ul view-ului si view-ul sa ramana actualizabil, altfel
   WMS da eroare la salvarea nodului.

   Pasi:
     1. Extrage definitia curenta:
          SELECT RDB$VIEW_SOURCE FROM RDB$RELATIONS WHERE RDB$RELATION_NAME='VW_TWEB_CATALOG';
     2. Adauga in lista de coloane:  T.FLG_VIRTUAL_CATALOG, T.VIRTUAL_FILTERID, T.VIRTUAL_FILTERPARAMIDS
     3. CREATE OR ALTER VIEW VW_TWEB_CATALOG (...coloane... , FLG_VIRTUAL_CATALOG,
          VIRTUAL_FILTERID, VIRTUAL_FILTERPARAMIDS) AS SELECT ... ;
     4. GRANT SELECT ON TWEB_CATALOG (sau pe view) TO WEBUSER daca e nevoie.
   ---------------------------------------------------------------------------- */

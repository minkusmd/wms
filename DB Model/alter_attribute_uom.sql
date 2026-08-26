/* ============================================================================
   WMS - Unitate de masura pe ATRIBUT (bilingv).

   TS_ATTRIBUTE.UOM_RO / UOM_RU - unitatea de masura a atributului
   (ex. ml, g, buc si echivalentele RU). Valorile raman text curat ("50"); UM-ul se
   lipeste doar la AFISARE (grila produs, preview, denumire compusa).

   Re-rulabil. A se rula pe baza SW (dupa alter_multi_value_attributes.sql).
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_ATTRIBUTE'
                   AND RDB$FIELD_NAME = 'UOM_RO')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_ATTRIBUTE ADD UOM_RO VARCHAR(64)';
END^

EXECUTE BLOCK AS BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_ATTRIBUTE'
                   AND RDB$FIELD_NAME = 'UOM_RU')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_ATTRIBUTE ADD UOM_RU VARCHAR(64)';
END^

SET TERM ; ^

COMMIT;

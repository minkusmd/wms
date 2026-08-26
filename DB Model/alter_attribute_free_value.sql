/* ============================================================================
   WMS - Atribute cu VALOARE LIBERA (ex. "Numarul de pagini" la carti)

   - TS_ATTRIBUTE.FLG_FREE_VALUE : valoarea atributului se introduce manual pe
                                   fiecare produs, fara inregistrari in
                                   dictionarul TS_ATTRIBUTE_VALUE.

   Diferenta fata de atributele obisnuite (ex. "Culoare"): pentru acestea din
   urma valorile vin din TS_ATTRIBUTE_VALUE si se aleg dintr-o lista. Pentru
   atributele cu FLG_FREE_VALUE = 1 lista nu se mai deschide deloc - UI-ul duce
   direct la dialogul de introducere manuala, iar adaugarea de valori in
   dictionar este blocata.

   Stocarea NU se schimba: valoarea ajunge tot in TS_GOODS_ATTRIBUTE.VALUE_RO /
   VALUE_RU ca text, deci compunerea denumirii si restul logicii raman la fel.

   Migrare: toate atributele existente raman cu FLG_FREE_VALUE = 0, adica
   se comporta exact ca inainte. Flagul se bifeaza manual, per atribut.

   Re-rulabil. A se rula pe baza SW (dupa new_attributes_system.sql +
   alter_goods_attribute_value_text.sql + alter_multi_value_attributes.sql).

   ATENTIE: acest script trebuie rulat INAINTE de instalarea versiunii noi de
   SWN.exe - frameGoodsAttributes citeste FLG_FREE_VALUE cu lista explicita de
   coloane si pe baza veche interogarea ar esua cu "Column unknown".
   ============================================================================ */

SET TERM ^ ;

/* FLG_FREE_VALUE pe TS_ATTRIBUTE */
EXECUTE BLOCK AS BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_ATTRIBUTE'
                   AND RDB$FIELD_NAME = 'FLG_FREE_VALUE')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_ATTRIBUTE ADD FLG_FREE_VALUE SMALLINT DEFAULT 0';
END^

SET TERM ; ^

COMMIT;

UPDATE TS_ATTRIBUTE SET FLG_FREE_VALUE = 0 WHERE FLG_FREE_VALUE IS NULL;
COMMIT;

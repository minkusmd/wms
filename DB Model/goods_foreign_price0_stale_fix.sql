/* ------------------------------------------------------------------------
   TS_GOODS_FOREIGN - PRICE0 ramas din urma la produsele scoase din pricelist
   (19 oct 2026)

   La Accent (198), Ultra Distribution (202294) si Comitek (1455) triggerul
   TS_GOODS_FOREIGN_BIU ia baza pretului 6 din PRICE0 cand PRICE0 >= 85% din
   PRICE7. Rindurile iesite din pricelist (in mare parte Ultra, 2025) au PRICE0
   in lei cu CURRENCY0ID = 840 (ex. 203902: 10499 "USD" fata de PRICE7 555 USD).
   Cand produsul revine in pricelist, CLOSE_REEVALUARE cade ("Formula: nan",
   peste 10000 USD nu exista interval in reguli) sau calculeaza din lei.

   Corectie: PRICE0 > 150% din ORD_PRICE7 (in USD) la produsele NE-in pricelist
   (FLG_IN_PRICE, bit 3 = 0) -> PRICE0 = ORD_PRICE7, CURRENCY0ID = ORD_CURRENCY7ID
   (costul necunoscut = pretul indicativ, ca la "if new.price0 = 0" din trigger).
   La 19 oct 2026: 6948 rinduri (198: 5, 1455: 19, 202294: 6924); produsele din
   pricelist nu sint atinse (0 rinduri cu FLG_IN_PRICE = 1).
   Script re-rulabil (a doua rulare nu mai gaseste nimic).
   Copia valorilor vechi: TS_GOODS_FOREIGN_P0_BAK_20261019.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                 WHERE RDB$RELATION_NAME = 'TS_GOODS_FOREIGN_P0_BAK_20261019')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TS_GOODS_FOREIGN_P0_BAK_20261019 (
         GOODSID DM_INTEGER, CUSTOMERID DM_INTEGER, GOODS_CODE VARCHAR(512),
         PRICE0 DM_AMOUNT, CURRENCY0ID DM_INTEGER, SAVED_AT TIMESTAMP)';
END^

SET TERM ; ^

COMMIT;

INSERT INTO TS_GOODS_FOREIGN_P0_BAK_20261019
  (GOODSID, CUSTOMERID, GOODS_CODE, PRICE0, CURRENCY0ID, SAVED_AT)
SELECT GF.GOODSID, GF.CUSTOMERID, GF.GOODS_CODE, GF.PRICE0, GF.CURRENCY0ID, CURRENT_TIMESTAMP
FROM TS_GOODS_FOREIGN GF
WHERE GF.CUSTOMERID IN (198, 202294, 1455) AND
      BIN_AND(GF.FLAGS, 8) = 0 AND
      GF.PRICE0 > 0 AND
      GF.ORD_PRICE7 > 0 AND
      CONVERT_AMOUNT(GF.PRICE0, COALESCE(GF.CURRENCY0ID, GF.ORD_CURRENCY7ID), 840, 1) >
        1.5 * CONVERT_AMOUNT(GF.ORD_PRICE7, GF.ORD_CURRENCY7ID, 840, 1);

UPDATE TS_GOODS_FOREIGN GF
SET GF.PRICE0 = GF.ORD_PRICE7,
    GF.CURRENCY0ID = GF.ORD_CURRENCY7ID
WHERE GF.CUSTOMERID IN (198, 202294, 1455) AND
      BIN_AND(GF.FLAGS, 8) = 0 AND
      GF.PRICE0 > 0 AND
      GF.ORD_PRICE7 > 0 AND
      CONVERT_AMOUNT(GF.PRICE0, COALESCE(GF.CURRENCY0ID, GF.ORD_CURRENCY7ID), 840, 1) >
        1.5 * CONVERT_AMOUNT(GF.ORD_PRICE7, GF.ORD_CURRENCY7ID, 840, 1);

COMMIT;

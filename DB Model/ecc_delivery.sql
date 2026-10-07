/* ============================================================================
   ECC Fiscal Partner - faza 7 (livrare prin curieri). Completare la
   ecc_fiscalpartner.sql, care trebuie sa fie rulat inainte.

   TFP_ECC_CASHIER.POS_ID - dispozitivul (telefonul) curierului in ECC, trimis ca
   posId in POST /delivery. Gol = se foloseste POS_ID-ul casei din TS_API_CONFIG.
   Un rind "curier ECC" = API_CODE + DRIVERID (curierul = COURIERID din livrare,
   TS_CUSTOMER) + CASHIER_ID (UUID-ul casierului din ECC) + POS_ID.

   Script RE-RULABIL.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TFP_ECC_CASHIER'
                     AND TRIM(RDB$FIELD_NAME) = 'POS_ID')) THEN
        EXECUTE STATEMENT 'ALTER TABLE TFP_ECC_CASHIER ADD POS_ID VARCHAR(36)';
END^

SET TERM ; ^

COMMIT;

/* ============================================================================
   Unificarea Cererii de finantare (1791) cu Web-Order (134) - FAZA 0 (pregatire)
   NEURON Grup SRL, 10 octombrie 2026
   Plan: Documents/plan-unificare-finantare-weborder-2026-10-09.md

   1. Analitica de plata PAY_INVOICE ("Cont spre plata") in TS_SYSS grupa 26,
      ca procedurile de comanda sa poata pune DTSC si pentru "cont spre plata".
   2. Comutatorul FIN_AS_WEBORDER in TS_API_CONFIG (API_CODE = 'WEB_ORDERS'):
        0 = cererea de credit de pe site creeaza 1791 (ca azi);
        1 = cererea de credit creeaza o comanda 134 cu plata pe credit (faza 2).
      Se schimba din WMS: Setari > Configurari API, fara redeploy.
      Il citesc: SP_WEB_REGISTER_FINANTARE (faza 2) si frame51 in WMS
      (cu 1, "Cerere de finantare" devine arhiva doar pentru citire).

   Script RE-RULABIL: nu dubleaza randurile, nu schimba valoarea comutatorului
   daca exista deja. Nu are efect asupra site-ului pana la faza 2.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    /* 1. Analitica "Cont spre plata" (SYSSID din SQ_TS_SYSS_SYSSID, prin TRG_TS_SYSS_BI) */
    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_INVOICE')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'Cont spre plata', 'PAY_INVOICE', 1, 0);

    /* 2. Comutatorul, oprit (UPDATED_AT il completeaza TS_API_CONFIG_BI) */
    IF (NOT EXISTS(SELECT 1 FROM TS_API_CONFIG
                   WHERE API_CODE = 'WEB_ORDERS' AND PARAM_NAME = 'FIN_AS_WEBORDER')) THEN
        INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, FLG_ACTIVE, NOTE)
        VALUES ('WEB_ORDERS', 'FIN_AS_WEBORDER', '0', 1,
                '1 = cererea de credit de pe site devine Web-Order 134 cu plata pe credit; 0 = Cerere de finantare 1791');
END^

SET TERM ; ^

COMMIT;

/* Verificare:
   SELECT SYSSID, TITLE, VALUE_STR FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR STARTING WITH 'PAY_';
   SELECT API_CODE, PARAM_NAME, PARAM_VALUE, FLG_ACTIVE FROM TS_API_CONFIG WHERE API_CODE = 'WEB_ORDERS';
*/

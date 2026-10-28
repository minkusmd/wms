/* ============================================================================
   Analitici de plata MIA - doua variante (TS_SYSS, PARENTID = 26)
   NEURON Grup SRL, 15 octombrie 2026

   Pina acum exista o singura analitica "QR MIA" (PAY_QR_MIA). Plata MIA vine
   insa pe doua cai:
     - PAY_QR_MIA      "QR MIA site"         - clientul plateste pe site / prin
                                               link-ul QR trimis (maib, Victoriabank).
                                               Codul ramine acelasi: il folosesc
                                               WEB_MIA_VB_CONFIRM, FN_WEB_PAYMENT_CODE
                                               si site-ul (PaymentAnalytic::QR_MIA).
     - PAY_QR_MIA_POS  "QR MIA POS Terminal" - plata MIA la terminalul POS din
                                               magazin (si butonul QR din modulul POS).

   Documentele care au deja analitica "QR MIA" (SYSSID 9535) raman pe ea, adica
   pe varianta "site"; cele platite la terminal se corecteaza manual daca e nevoie.

   Script RE-RULABIL: nu dubleaza valoarea, nu schimba SYSSID-urile existente.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    UPDATE TS_SYSS SET TITLE = 'QR MIA site'
    WHERE PARENTID = 26 AND VALUE_STR = 'PAY_QR_MIA' AND TITLE = 'QR MIA';

    IF (NOT EXISTS(SELECT 1 FROM TS_SYSS WHERE PARENTID = 26 AND VALUE_STR = 'PAY_QR_MIA_POS')) THEN
        INSERT INTO TS_SYSS (PARENTID, TITLE, VALUE_STR, VALUE_INT, VALUE_INT_TYPE)
        VALUES (26, 'QR MIA POS Terminal', 'PAY_QR_MIA_POS', 1, 0);
END^

SET TERM ; ^

COMMIT;

SELECT s.SYSSID, s.TITLE, t.VALUE_STR FROM SP_GET_ANALITICS_DTSC s
JOIN TS_SYSS t ON t.SYSSID = s.SYSSID
ORDER BY 1;

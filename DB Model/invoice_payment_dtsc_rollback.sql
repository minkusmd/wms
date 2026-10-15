/*
  Revenire pentru invoice_payment_dtsc.sql: scoate triggerul, procedura si functia.
  Analiticile deja scrise pe facturi raman (DTSC e informativ); pentru a le readuce
  la "Fara analitica" pe o perioada, ruleaza separat, de exemplu:
    UPDATE TDB_DOCS SET DTSC = 5108 WHERE DOCTYPEID = 112 AND DATA >= DATE '2026-10-12' ...
*/

DROP TRIGGER TDB_DOCS_BI_PAY_DTSC;
DROP PROCEDURE SP_INVOICE_PAYMENT_DTSC_FILL;
DROP FUNCTION FN_INVOICE_PAYMENT_DTSC;
COMMIT;

/*
  Cerere de finantare (document 1791): numele fisierelor incarcate de client
  ca si copie a buletinului.

  TWEB_CERERE_FINANTARE.SCAN1 / SCAN2 pastreaza doar continutul fisierului, deci
  din WMS nu se vede daca in blob e o imagine sau un PDF. Coloanele noi tin numele
  original al fisierului (cu extensie), asa cum l-a incarcat clientul pe site:

    SCAN1_NAME - numele fisierului din SCAN1 (buletin, fata)
    SCAN2_NAME - numele fisierului din SCAN2 (buletin, verso)

  Le completeaza site-ul (fantastic.web, TdbJurnal::save) printr-un UPDATE dupa
  SP_WEB_REGISTER_FINANTARE; procedura nu se modifica. Cererile vechi raman cu NULL.
  Le citeste WMS in frame51ZaiavkaCreditUnit (fila "Client info").

  Ordinea: scriptul se ruleaza INAINTE de instalarea noului SWN.exe (frame-ul 51
  selecteaza coloanele). Site-ul functioneaza si inainte, si dupa rulare.

  Re-rulabil.
  NEURON Grup SRL, 1 octombrie 2026
*/

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE'
                   AND RDB$FIELD_NAME = 'SCAN1_NAME')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD SCAN1_NAME DM_VARCHAR255';

  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_CERERE_FINANTARE'
                   AND RDB$FIELD_NAME = 'SCAN2_NAME')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_CERERE_FINANTARE ADD SCAN2_NAME DM_VARCHAR255';
END ^

SET TERM ; ^

COMMIT;

COMMENT ON COLUMN TWEB_CERERE_FINANTARE.SCAN1_NAME IS 'Numele fisierului din SCAN1 (buletin, fata), cu extensie';
COMMENT ON COLUMN TWEB_CERERE_FINANTARE.SCAN2_NAME IS 'Numele fisierului din SCAN2 (buletin, verso), cu extensie';

COMMIT;

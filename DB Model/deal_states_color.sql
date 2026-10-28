/* ============================================================================
   WMS - Culoarea starilor de deal (TS_DEAL_STATES.COLOR)

   - TS_DEAL_STATES.COLOR VARCHAR(7) : culoarea starii in format '#RRGGBB'
                                       (ca in HTML - aceeasi valoare se poate
                                       folosi si pe site / CurieriWMS).

   In gridurile documentelor din WMS (Oferte, Proforma, Vinzari, Factura,
   Web-Order, casa, banca) coloana "Stare deal" deseneaza inaintea textului un
   cerculet in aceasta culoare (SWNDealsUnit.AddDealColumns). Starea afisata
   este TDB_DEALS.PIPE_STATE_ID (voronka generala).

   COLOR NULL -> culoare implicita in WMS: gri = IS_CANCEL, verde = IS_SUCCESS,
   albastru = restul. WMS citeste culorile o data pe sesiune: dupa schimbarea
   unei culori, utilizatorii o vad la urmatoarea pornire a SWN.exe.

   Re-rulabil; UPDATE-urile completeaza doar culorile inca nesetate (COLOR IS
   NULL), deci nu suprascriu culorile schimbate ulterior manual.
   SWN.exe merge si fara acest script (verifica existenta coloanei).
   Rollback: deal_states_color_rollback.sql
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK AS BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TS_DEAL_STATES'
                   AND RDB$FIELD_NAME = 'COLOR')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_DEAL_STATES ADD COLOR VARCHAR(7)';
END^

SET TERM ; ^

COMMIT;

/* PIPE - voronka generala (afisata in gridurile documentelor) */
UPDATE TS_DEAL_STATES SET COLOR = '#FB8C00' WHERE CODE = 'PIPE_WAITING_CHECK'       AND COLOR IS NULL;  /* portocaliu */
UPDATE TS_DEAL_STATES SET COLOR = '#FDD835' WHERE CODE = 'PIPE_CHECKING'            AND COLOR IS NULL;  /* galben */
UPDATE TS_DEAL_STATES SET COLOR = '#1E88E5' WHERE CODE = 'PIPE_IN_WORK'             AND COLOR IS NULL;  /* albastru */
UPDATE TS_DEAL_STATES SET COLOR = '#8E24AA' WHERE CODE = 'PIPE_BACKORDER_4_6W'      AND COLOR IS NULL;  /* violet */
UPDATE TS_DEAL_STATES SET COLOR = '#00ACC1' WHERE CODE = 'PIPE_READY_TO_SHIP'       AND COLOR IS NULL;  /* turcoaz */
UPDATE TS_DEAL_STATES SET COLOR = '#3949AB' WHERE CODE = 'PIPE_ON_DELIVERY'         AND COLOR IS NULL;  /* indigo */
UPDATE TS_DEAL_STATES SET COLOR = '#43A047' WHERE CODE = 'PIPE_DELIVERED'           AND COLOR IS NULL;  /* verde */
UPDATE TS_DEAL_STATES SET COLOR = '#9E9E9E' WHERE CODE = 'PIPE_CANCELLED_BY_CLIENT' AND COLOR IS NULL;  /* gri */
UPDATE TS_DEAL_STATES SET COLOR = '#616161' WHERE CODE = 'PIPE_CANCELLED_BY_SHOP'   AND COLOR IS NULL;  /* gri inchis */
UPDATE TS_DEAL_STATES SET COLOR = '#E53935' WHERE CODE = 'PIPE_DELIVERY_FAILED'     AND COLOR IS NULL;  /* rosu */

/* PAY - plata */
UPDATE TS_DEAL_STATES SET COLOR = '#BDBDBD' WHERE CODE = 'PAY_NONE'    AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#FB8C00' WHERE CODE = 'PAY_WAITING' AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#FDD835' WHERE CODE = 'PAY_PARTIAL' AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#43A047' WHERE CODE = 'PAY_PAID'    AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#E53935' WHERE CODE = 'PAY_FAILED'  AND COLOR IS NULL;

/* FIN - credit / finantare */
UPDATE TS_DEAL_STATES SET COLOR = '#BDBDBD' WHERE CODE = 'FIN_NONE'            AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#FB8C00' WHERE CODE = 'FIN_REQUESTED'       AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#FDD835' WHERE CODE = 'FIN_IN_REVIEW'       AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#7CB342' WHERE CODE = 'FIN_APPROVED'        AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#43A047' WHERE CODE = 'FIN_CONTRACT_SIGNED' AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#2E7D32' WHERE CODE = 'FIN_DISBURSED'       AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#E53935' WHERE CODE = 'FIN_DECLINED'        AND COLOR IS NULL;

/* DLV - livrare */
UPDATE TS_DEAL_STATES SET COLOR = '#BDBDBD' WHERE CODE = 'DLV_NONE'       AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#8D6E63' WHERE CODE = 'DLV_PICKUP'     AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#FDD835' WHERE CODE = 'DLV_PREPARING'  AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#3949AB' WHERE CODE = 'DLV_IN_TRANSIT' AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#43A047' WHERE CODE = 'DLV_DELIVERED'  AND COLOR IS NULL;
UPDATE TS_DEAL_STATES SET COLOR = '#E53935' WHERE CODE = 'DLV_FAILED'     AND COLOR IS NULL;

COMMIT;

/* verificare */
SELECT GROUP_CODE, CODE, TITLE_RO, COLOR FROM TS_DEAL_STATES ORDER BY GROUP_CODE, SORT_ORDER;

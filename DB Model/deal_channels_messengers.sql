/* ============================================================================
   Canale noi de deal (TS_DEAL_REASONS, grupa CHANNEL)
   NEURON Grup SRL, 28 octombrie 2026

   Adauga canalul "Messengers (Viber, WhatsApp)", asezat in lista dupa "Chat"
   (SORT_ORDER 20). Re-rulabil (MATCHING (CODE)). "Online-chat" (CH_ONLINE_CHAT)
   a fost adaugat si apoi sters la cererea userului (28.10.2026).
   Revenire: UPDATE TS_DEAL_REASONS SET IS_ACTIVE = 0
             WHERE CODE = 'CH_MESSENGERS';
   (nu DELETE daca vreun deal are deja CHANNEL_ID pe el)
   ============================================================================ */

UPDATE OR INSERT INTO TS_DEAL_REASONS (GROUP_CODE, CODE, TITLE_RO, SORT_ORDER, IS_ACTIVE)
VALUES ('CHANNEL', 'CH_MESSENGERS', 'Messengers (Viber, WhatsApp)', 22, 1) MATCHING (CODE);

COMMIT;

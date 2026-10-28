/* Rollback pentru deal_states_color.sql: scoate TS_DEAL_STATES.COLOR.
   SWN.exe continua sa mearga (revine la culorile implicite). Re-rulabil. */

SET TERM ^ ;

EXECUTE BLOCK AS BEGIN
  IF (EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
             WHERE RDB$RELATION_NAME = 'TS_DEAL_STATES'
               AND RDB$FIELD_NAME = 'COLOR')) THEN
    EXECUTE STATEMENT 'ALTER TABLE TS_DEAL_STATES DROP COLOR';
END^

SET TERM ; ^

COMMIT;

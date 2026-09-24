/* ============================================================================
   SP_OPEN_WEBZAKAZ - redeschiderea unei comenzi web (Web-Order 134) - 23 sep 2026

   Perechea lui SP_CLOSE_WEBZAKAZ: scoate bitul 10 (FLG_CLOSED) din TDB_DOCS.FLAGS,
   dupa tiparul SP_OPEN_PKO / SP_OPEN_KBP.

   Apelata din WMS la Shift+F9 pe frame-ul Web-Order (Tframe24WebZakaz.DoOpenDocument).
   Ca la inchidere, se seteaza contextul RequireModifyDOC: trigger-ele de pe TDB_DOCS
   nu permit altfel modificarea unui document inchis.

   Script RE-RULABIL.
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_OPEN_WEBZAKAZ (
    DOCID DM_INTEGER_NN)
AS
begin
  /* avem nevoie de modificare in lant a documentelor posibil inchise */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  /* Setam valoarea FLG_CLOSED=10 in 0 */
  update TDB_DOCS
  set FLAGS = SET_FLG_VALUE(FLAGS, 10, 0)
  where DOCID = :DOCID;
end^

SET TERM ; ^

COMMIT;

/* aceleasi drepturi ca SP_CLOSE_WEBZAKAZ */
GRANT EXECUTE ON PROCEDURE SP_OPEN_WEBZAKAZ TO SWN;
GRANT EXECUTE ON PROCEDURE SP_OPEN_WEBZAKAZ TO WEBUSER;

COMMIT;

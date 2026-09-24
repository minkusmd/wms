/* ============================================================================
   SP_CLOSE_WEBZAKAZ - responsabilul NU se mai suprascrie la inchidere (22 sep 2026)

   Simptom: la inchiderea unei comenzi web (Web-Order 134) RESPONSIBLE_USERID devenea
   "WEB SITE" (utilizatorul 9) peste orice utilizator real.

   Cauza: vechea expresie
       RESPONSIBLE_USERID = iif(RESPONSIBLE_USERID = 0, <utilizatorul curent>, CREATED_BY)
   punea CREATED_BY (= 9, WEB SITE, la toate comenzile de pe site) de fiecare data cind
   responsabilul nu era exact 0 - adica aproape intotdeauna. Nici NULL nu era tratat
   (NULL = 0 e fals -> tot CREATED_BY).

   Regula noua (aceeasi ca in WMS la deschidere / crearea ofertei):
     - responsabil gol (NULL, 0 sau -1) -> utilizatorul curent (cel care inchide);
     - responsabil existent -> ramine neschimbat.
   Restul procedurii (FLG_CLOSED, RequireModifyDOC) e neschimbat; variabilele DTSC/STATEID
   erau citite si nefolosite - pastrate ca sa nu schimbam nimic altceva.

   Script RE-RULABIL.
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_CLOSE_WEBZAKAZ (
    DOCID  DM_INTEGER_NN,
    USERID DM_INTEGER)
AS
declare DTSC DM_INTEGER;
declare STATEID DM_INTEGER;
declare CURRENT_USER_ID DM_INTEGER;
begin
  /* Setam valoarea FLG_CLOSED=10 in 1 */
  /* avem nevoie de modificare in lant a documentelor posibil inchise */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  select SYSSID
  from TS_SYSS
  where PARENTID = 26 and
        VALUE_INT = :USERID
  into :DTSC;

  DTSC = coalesce(:DTSC, 5137);
  select STATEID
  from TDB_DOCS
  where DOCID = :DOCID
  into :STATEID;

  /* cine inchide: sesiunea WMS, altfel parametrul */
  CURRENT_USER_ID = coalesce(rdb$get_context('USER_SESSION', 'UserID'), :USERID);

  update TDB_DOCS D
  set FLAGS = SET_FLG_VALUE(FLAGS, 10, 1),
      D.RESPONSIBLE_USERID = iif(coalesce(D.RESPONSIBLE_USERID, -1) <= 0, :CURRENT_USER_ID, D.RESPONSIBLE_USERID)
  where DOCID = :DOCID;
end^

SET TERM ; ^

COMMIT;

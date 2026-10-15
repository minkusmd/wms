/*
  Factura fiscala (112): analitica de plata (TDB_DOCS.DTSC, TS_SYSS grupa 26, coduri PAY_*)
  completata automat la creare + procedura de completare pentru facturile existente.

  Problema (12 oct 2026): in frame25 (Facturi fiscale - eliberate) coloana "plata" (DTSC) arata
  aproape mereu "Fara analitica" - in ultimele 90 de zile 228 din 233 de facturi. Factura se
  creeaza din rezerva 107, iar aceea are si ea PAY_NONE; plata e in incasarile (116 PKO /
  120 incasare pe cont) legate de rezerva sau de acelasi deal.

  De unde se ia DTSC pentru factura (FN_INVOICE_PAYMENT_DTSC, pornind de la PARENTDOCID):
  1. lantul de parinti (rezerva 107 -> 115 / 101 ..., max 5 nivele): prima analitica de plata
     (PAY_*, alta decit PAY_NONE);
  2. altfel incasarile 116/120 nesterse - copiii parintelui sau documentele din acelasi deal,
     cea mai mare suma: analitica lor de plata; fara analitica 116 = PAY_CASH (numerar),
     120 = PAY_INVOICE (transfer) - aceeasi regula ca in coloana "Plata" (PAY_INFO) din WMS.
  Simulat pe SW 12 oct 2026 pe cele 233 de facturi din 90 de zile: 171 primesc analitica
  (125 numerar, 27 transfer, 13 POS, 5 Ecomm, 1 Credit 0%), 62 raman fara (nu au incasare).

  Ce face scriptul:
  - FN_INVOICE_PAYMENT_DTSC(P_PARENTDOCID) - regula de mai sus, intoarce SYSSID sau NULL;
  - TDB_DOCS_BI_PAY_DTSC - la crearea facturii 112 fara analitica (NULL / -1 / PAY_NONE)
    pune DTSC din regula; o analitica aleasa explicit nu se schimba; orice eroare a regulii
    e ignorata (nu blocheaza crearea facturii);
  - SP_INVOICE_PAYMENT_DTSC_FILL(P_DAYS) - completeaza facturile din ultimele P_DAYS zile
    ramase fara analitica (si cele la care incasarea a venit dupa factura). Daca sesiunea
    nu are UserID (isql, SWNService), ruleaza ca utilizatorul de sistem 9, ca sa treaca
    de GET_QUICK_ACCESS_PERIOD; facturile din perioade inchise se numara in SKIPPED.

  DTSC pe 112 nu intra in DAYLY_REPORT (acolo se filtreaza doar 116/120/117/118/119/1199) si
  nici in procedurile SP_DEAL_*. Schimbarea DTSC pe o factura din deal recalculeaza starile
  deal-ului (TDB_DOCS_AU_DEAL) - fara efect, DTSC nu e folosit acolo.

  Se poate rula repetat. Revenire: invoice_payment_dtsc_rollback.sql
  Dupa rulare (o data):  EXECUTE PROCEDURE SP_INVOICE_PAYMENT_DTSC_FILL(90); COMMIT;
  Recomandat in SWNService o data pe zi:  SP_INVOICE_PAYMENT_DTSC_FILL (implicit 30 zile).
*/

SET TERM ^ ;

CREATE OR ALTER FUNCTION FN_INVOICE_PAYMENT_DTSC (
    P_PARENTDOCID DM_INTEGER)
RETURNS INTEGER
AS
declare V_DOC INTEGER;
declare V_NEXT INTEGER;
declare V_LVL INTEGER;
declare V_DTSC INTEGER;
declare V_CODE VARCHAR(60);
begin
  /* 12.10.2026: analitica de plata pentru factura 112 creata din P_PARENTDOCID
     (vezi DB Model/invoice_payment_dtsc.sql) */
  if (coalesce(P_PARENTDOCID, -1) <= 0) then
    return null;

  /* 1. lantul de parinti */
  V_DOC = P_PARENTDOCID;
  V_LVL = 0;
  while (V_DOC > 0 and V_LVL < 5) do
  begin
    V_NEXT = null;
    V_DTSC = null;
    select D.PARENTDOCID, S.SYSSID
    from TDB_DOCS D
    left join TS_SYSS S on (S.SYSSID = D.DTSC and S.PARENTID = 26 and
                            S.VALUE_STR starting with 'PAY_' and S.VALUE_STR <> 'PAY_NONE')
    where D.DOCID = :V_DOC
    into :V_NEXT, :V_DTSC;
    if (V_DTSC is not null) then
      return V_DTSC;
    if (V_NEXT is null or V_NEXT = V_DOC) then
      leave;
    V_DOC = V_NEXT;
    V_LVL = V_LVL + 1;
  end

  /* 2. incasarile parintelui / din acelasi deal, cea mai mare suma */
  V_CODE = null;
  select first 1 coalesce(S.VALUE_STR, iif(P.DOCTYPEID = 116, 'PAY_CASH', 'PAY_INVOICE'))
  from (select PD.DOCTYPEID, PD.DTSC, PD.SUMA * PD.RATE AMOUNT
        from TDB_DOCS PD
        where PD.PARENTDOCID = :P_PARENTDOCID and
              PD.DOCTYPEID in (116, 120) and
              PD.DELETED_DATE is null
        union
        select PD.DOCTYPEID, PD.DTSC, PD.SUMA * PD.RATE
        from TDB_DEAL_DOCS A
        inner join TDB_DEAL_DOCS B on (B.DEAL_ID = A.DEAL_ID)
        inner join TDB_DOCS PD on (PD.DOCID = B.DOCID)
        where A.DOCID = :P_PARENTDOCID and
              PD.DOCTYPEID in (116, 120) and
              PD.DELETED_DATE is null) P
  left join TS_SYSS S on (S.SYSSID = P.DTSC and S.PARENTID = 26 and
                          S.VALUE_STR starting with 'PAY_' and S.VALUE_STR <> 'PAY_NONE')
  order by P.AMOUNT desc
  into :V_CODE;

  if (V_CODE is null) then
    return null;

  V_DTSC = null;
  select first 1 SYSSID
  from TS_SYSS
  where PARENTID = 26 and
        VALUE_STR = :V_CODE
  into :V_DTSC;
  return V_DTSC;
end^

CREATE OR ALTER TRIGGER TDB_DOCS_BI_PAY_DTSC FOR TDB_DOCS
ACTIVE BEFORE INSERT POSITION 10
AS
declare V_DTSC INTEGER;
begin
  /* 12.10.2026: factura fiscala 112 fara analitica primeste analitica de plata din
     lantul de parinti / incasari (FN_INVOICE_PAYMENT_DTSC). Ruleaza dupa TRG_TDB_DOCS_BI
     (pozitia 0, care pune DTSC = -1 si PARENTDOCID = -1 implicit) */
  if (rdb$get_context('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') then
    exit;

  if (NEW.DOCTYPEID = 112 and coalesce(NEW.PARENTDOCID, -1) > 0 and
      (NEW.DTSC is null or NEW.DTSC = -1 or
       exists(select 1
              from TS_SYSS
              where SYSSID = NEW.DTSC and
                    VALUE_STR = 'PAY_NONE'))) then
  begin
    V_DTSC = FN_INVOICE_PAYMENT_DTSC(NEW.PARENTDOCID);
    if (V_DTSC is not null) then
      NEW.DTSC = V_DTSC;
    when any do
    begin
      /* analitica e doar informativa - nu blocam crearea facturii */
    end
  end
end^

CREATE OR ALTER PROCEDURE SP_INVOICE_PAYMENT_DTSC_FILL (
    P_DAYS INTEGER = 30)
RETURNS (
    UPDATED INTEGER,
    NOT_FOUND INTEGER,
    SKIPPED INTEGER)
AS
declare V_DOCID INTEGER;
declare V_PARENT INTEGER;
declare V_DATA TIMESTAMP;
declare V_DTSC INTEGER;
declare V_CAN INTEGER;
declare V_USER VARCHAR(255);
begin
  /* 12.10.2026: completeaza analitica de plata la facturile 112 din ultimele P_DAYS zile
     ramase fara analitica (vezi DB Model/invoice_payment_dtsc.sql) */
  UPDATED = 0;
  NOT_FOUND = 0;
  SKIPPED = 0;

  /* fara utilizator in sesiune (isql, SWNService) - ca utilizatorul de sistem 9 */
  V_USER = rdb$get_context('USER_SESSION', 'UserID');
  if (V_USER is null) then
    rdb$set_context('USER_SESSION', 'UserID', 9);

  begin
    for select D.DOCID, D.PARENTDOCID, D.DATA
        from TDB_DOCS D
        left join TS_SYSS S on (S.SYSSID = D.DTSC)
        where D.DOCTYPEID = 112 and
              D.DELETED_DATE is null and
              D.PARENTDOCID > 0 and
              D.DATA >= current_date - :P_DAYS and
              (D.DTSC is null or D.DTSC = -1 or S.VALUE_STR = 'PAY_NONE')
        into :V_DOCID, :V_PARENT, :V_DATA
    do
    begin
      V_DTSC = FN_INVOICE_PAYMENT_DTSC(:V_PARENT);
      if (V_DTSC is null) then
        NOT_FOUND = NOT_FOUND + 1;
      else
      begin
        V_CAN = 0;
        select CAN_WORK from GET_QUICK_ACCESS_PERIOD(:V_DATA) into :V_CAN;
        if (coalesce(V_CAN, 0) = 0) then
          SKIPPED = SKIPPED + 1;
        else
        begin
          update TDB_DOCS
          set DTSC = :V_DTSC
          where DOCID = :V_DOCID;
          UPDATED = UPDATED + 1;
          when any do
            SKIPPED = SKIPPED + 1;
        end
      end
    end

    when any do
    begin
      if (V_USER is null) then
        rdb$set_context('USER_SESSION', 'UserID', null);
      exception;
    end
  end

  if (V_USER is null) then
    rdb$set_context('USER_SESSION', 'UserID', null);
end^

SET TERM ; ^

COMMIT;

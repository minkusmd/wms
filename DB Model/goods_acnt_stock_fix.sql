/* ============================================================================
   Stocul contabil TS_GOODS_ACNT_STOCK.QTY_ACCOUNT - corectarea derivei

   Analiza (19.09.2026): pe firma 307225 suma stocata era -1220, iar din
   TDB_JURNAL rezulta -1118; zeci de pozitii (DT, GOODS_ACNT_ID) difereau.
   Cauze:
     1. TDB_JURNAL_ACNT_AIUD ia GOODS_ACNT_ID din TS_GOODS la momentul operatiei.
        Cand produsul e relegat la alta denumire de contabilitate, stocul deja
        inregistrat ramane pe denumirea veche (nimeni nu-l muta).
     2. Schimbarea DT sau DOCTYPEID pe TDB_DOCS nu muta cantitatile liniilor.
     3. SP_MERGE_GOODS seta DISSABLE_TRIGGERS='YES' inainte de o verificare care
        arunca exceptie si nu-l mai reseta; contextul USER_SESSION nu se anuleaza
        la rollback, deci triggerele ramaneau oprite pe toata sesiunea WMS.
        In plus, liniile treceau pe produsul nou fara mutarea stocului contabil.
     4. Triggerul citea suma, apoi scria suma noua (EXECUTE STATEMENT +
        UPDATE OR INSERT) in loc de un update atomic QTY = QTY + x.

   Regula de calcul (neschimbata): linia conteaza daca tipul documentului are
   bitul 6 (FLG_Invoice_acnt) in TS_DOCTYPES.FLAGS si firma DT are
   TS_CUSTOMER.VAT > 0; semnul e '+' daca bitul 4 e setat, altfel '-'.
   (azi: 109/1421 = +, 112/131 = -)

   Ce face scriptul:
     - FN_ACNT_STOCK_SIGN   - regula de mai sus intr-un singur loc (1 / -1 / 0)
     - SP_ACNT_STOCK_ADD    - QTY_ACCOUNT = QTY_ACCOUNT + x (atomic)
     - TDB_JURNAL_ACNT_AIUD - rescris pe cele doua de mai sus
     - TDB_DOCS_AU_ACNT     - NOU: muta cantitatile la schimbarea DT / DOCTYPEID
     - TS_GOODS_AU_ACNT     - NOU: muta cantitatile la schimbarea GOODS_ACNT_ID
     - MERGE_GOODS_ACNT     - opreste TS_GOODS_AU_ACNT (muta singur soldurile)
     - SP_MERGE_GOODS       - DISSABLE_TRIGGERS resetat la eroare + mutarea stocului
     - RECALC_ALL_STOCK_ACNT - aceeasi regula ca triggerul (inainte: lista fixa
                               de tipuri, fara conditia TVA)
     - la final: recalcularea completa a stocului contabil (realiniere)

   Ramane de stiut:
     - schimbarea TS_CUSTOMER.VAT a unei firme sau a bitilor 4/6 dintr-un tip de
       document NU se propaga automat -> dupa asa ceva rulati
       EXECUTE PROCEDURE RECALC_ALL_STOCK_ACNT;
     - SP_MERGE_CUSTOMERS muta stocul contabil gresit (pune pe fiecare rand suma
       tuturor randurilor ambelor firme); la unirea a doua FIRME rulati dupa ea
       RECALC_ALL_STOCK_ACNT. Procedura nu e modificata aici.

   Script RE-RULABIL. Se ruleaza ca SYSDBA, cand nu lucreaza nimeni in WMS
   (recalcularea de la final dureaza cateva minute si blocheaza tabela).
   ============================================================================ */

SET TERM ^ ;

/* ---------------------------------------------------------------------------
   1. Regula: semnul cu care o linie a documentului intra in stocul contabil
   --------------------------------------------------------------------------- */
CREATE OR ALTER FUNCTION FN_ACNT_STOCK_SIGN (
    ADOCTYPEID INTEGER,
    ADT INTEGER)
RETURNS SMALLINT
AS
DECLARE VARIABLE V_FLAGS TYPE OF COLUMN TS_DOCTYPES.FLAGS;
DECLARE VARIABLE V_VAT TYPE OF COLUMN TS_CUSTOMER.VAT;
BEGIN
  IF ((ADOCTYPEID IS NULL) OR (ADT IS NULL)) THEN
    RETURN 0;

  SELECT FLAGS FROM TS_DOCTYPES WHERE DOCTYPEID = :ADOCTYPEID INTO :V_FLAGS;
  IF (GET_FLG_VALUE(V_FLAGS, 6) = 0) THEN /* FLG_Invoice_acnt */
    RETURN 0;

  SELECT VAT FROM TS_CUSTOMER WHERE CUSTOMERID = :ADT INTO :V_VAT;
  IF (COALESCE(V_VAT, 0) <= 0) THEN
    RETURN 0;

  RETURN IIF(GET_FLG_VALUE(V_FLAGS, 4) = 1, 1, -1);
END^

/* ---------------------------------------------------------------------------
   2. Adaugarea atomica in stocul contabil
   --------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_ACNT_STOCK_ADD (
    ADT INTEGER,
    AGOODS_ACNT_ID INTEGER,
    AQTY DM_QTY)
AS
BEGIN
  IF ((ADT IS NULL) OR (AGOODS_ACNT_ID IS NULL) OR (COALESCE(AQTY, 0) = 0)) THEN
    EXIT;

  UPDATE TS_GOODS_ACNT_STOCK
     SET QTY_ACCOUNT = COALESCE(QTY_ACCOUNT, 0) + :AQTY
   WHERE DT = :ADT AND GOODS_ACNT_ID = :AGOODS_ACNT_ID;

  IF (ROW_COUNT = 0) THEN
    INSERT INTO TS_GOODS_ACNT_STOCK (DT, GOODS_ACNT_ID, QTY_ACCOUNT)
    VALUES (:ADT, :AGOODS_ACNT_ID, :AQTY);
END^

/* ---------------------------------------------------------------------------
   3. Triggerul pe liniile documentelor
   --------------------------------------------------------------------------- */
CREATE OR ALTER TRIGGER TDB_JURNAL_ACNT_AIUD FOR TDB_JURNAL
ACTIVE AFTER INSERT OR UPDATE OR DELETE POSITION 2
AS
DECLARE VARIABLE V_DT INTEGER;
DECLARE VARIABLE V_DOCTYPEID INTEGER;
DECLARE VARIABLE V_SIGN SMALLINT;
DECLARE VARIABLE V_GA INTEGER;
BEGIN
  /* Verificam daca ne trebuie trigerii  */
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;

  /* modificarile care nu ating cantitatea (pret, flaguri, SET QTY = QTY) */
  IF (UPDATING) THEN
    IF ((NEW.DOCID IS NOT DISTINCT FROM OLD.DOCID) AND
        (NEW.GOODSID IS NOT DISTINCT FROM OLD.GOODSID) AND
        (NEW.QTY IS NOT DISTINCT FROM OLD.QTY)) THEN
      EXIT;

  /* scoatem linia veche */
  IF (UPDATING OR DELETING) THEN
  BEGIN
    V_DT = NULL;
    V_DOCTYPEID = NULL;
    SELECT DT, DOCTYPEID FROM TDB_DOCS WHERE DOCID = OLD.DOCID
      INTO :V_DT, :V_DOCTYPEID;
    V_SIGN = FN_ACNT_STOCK_SIGN(V_DOCTYPEID, V_DT);
    IF (V_SIGN <> 0) THEN
    BEGIN
      V_GA = NULL;
      SELECT GOODS_ACNT_ID FROM TS_GOODS WHERE GOODSID = OLD.GOODSID INTO :V_GA;
      EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(:V_DT, :V_GA, -:V_SIGN * COALESCE(OLD.QTY, 0));
    END
  END

  /* adaugam linia noua */
  IF (INSERTING OR UPDATING) THEN
  BEGIN
    V_DT = NULL;
    V_DOCTYPEID = NULL;
    SELECT DT, DOCTYPEID FROM TDB_DOCS WHERE DOCID = NEW.DOCID
      INTO :V_DT, :V_DOCTYPEID;
    V_SIGN = FN_ACNT_STOCK_SIGN(V_DOCTYPEID, V_DT);
    IF (V_SIGN <> 0) THEN
    BEGIN
      V_GA = NULL;
      SELECT GOODS_ACNT_ID FROM TS_GOODS WHERE GOODSID = NEW.GOODSID INTO :V_GA;
      EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(:V_DT, :V_GA, :V_SIGN * COALESCE(NEW.QTY, 0));
    END
  END
END^

/* ---------------------------------------------------------------------------
   4. Schimbarea firmei (DT) sau a tipului documentului
   --------------------------------------------------------------------------- */
CREATE OR ALTER TRIGGER TDB_DOCS_AU_ACNT FOR TDB_DOCS
ACTIVE AFTER UPDATE POSITION 950
AS
DECLARE VARIABLE V_OLD_SIGN SMALLINT;
DECLARE VARIABLE V_NEW_SIGN SMALLINT;
DECLARE VARIABLE V_GA INTEGER;
DECLARE VARIABLE V_QTY DM_QTY;
BEGIN
  /* Verificam daca ne trebuie trigerii  */
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;

  IF ((NEW.DT IS NOT DISTINCT FROM OLD.DT) AND
      (NEW.DOCTYPEID IS NOT DISTINCT FROM OLD.DOCTYPEID)) THEN
    EXIT;

  V_OLD_SIGN = FN_ACNT_STOCK_SIGN(OLD.DOCTYPEID, OLD.DT);
  V_NEW_SIGN = FN_ACNT_STOCK_SIGN(NEW.DOCTYPEID, NEW.DT);

  IF ((V_OLD_SIGN = V_NEW_SIGN) AND (NEW.DT IS NOT DISTINCT FROM OLD.DT)) THEN
    EXIT;

  FOR SELECT G.GOODS_ACNT_ID, SUM(J.QTY)
        FROM TDB_JURNAL J
        JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
       WHERE J.DOCID = NEW.DOCID
       GROUP BY G.GOODS_ACNT_ID
        INTO :V_GA, :V_QTY
  DO
  BEGIN
    EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(OLD.DT, :V_GA, -:V_OLD_SIGN * :V_QTY);
    EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(NEW.DT, :V_GA, :V_NEW_SIGN * :V_QTY);
  END
END^

/* ---------------------------------------------------------------------------
   5. Relegarea produsului la alta denumire de contabilitate
      MERGE_GOODS_ACNT muta singur soldurile si opreste acest trigger prin
      contextul de tranzactie ACNT_STOCK_SKIP_GOODS.
   --------------------------------------------------------------------------- */
CREATE OR ALTER TRIGGER TS_GOODS_AU_ACNT FOR TS_GOODS
ACTIVE AFTER UPDATE POSITION 950
AS
DECLARE VARIABLE V_DT INTEGER;
DECLARE VARIABLE V_QTY DM_QTY;
BEGIN
  /* Verificam daca ne trebuie trigerii  */
  IF (RDB$GET_CONTEXT('USER_SESSION', 'DISSABLE_TRIGGERS') = 'YES') THEN
    EXIT;

  IF (RDB$GET_CONTEXT('USER_TRANSACTION', 'ACNT_STOCK_SKIP_GOODS') = '1') THEN
    EXIT;

  IF (NEW.GOODS_ACNT_ID IS NOT DISTINCT FROM OLD.GOODS_ACNT_ID) THEN
    EXIT;

  FOR SELECT D.DT, SUM(J.QTY * FN_ACNT_STOCK_SIGN(D.DOCTYPEID, D.DT))
        FROM TDB_JURNAL J
        JOIN TDB_DOCS D ON D.DOCID = J.DOCID
        JOIN TS_DOCTYPES T ON T.DOCTYPEID = D.DOCTYPEID
       WHERE J.GOODSID = NEW.GOODSID
         AND GET_FLG_VALUE(T.FLAGS, 6) = 1
       GROUP BY D.DT
        INTO :V_DT, :V_QTY
  DO
  BEGIN
    EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(:V_DT, OLD.GOODS_ACNT_ID, -:V_QTY);
    EXECUTE PROCEDURE SP_ACNT_STOCK_ADD(:V_DT, NEW.GOODS_ACNT_ID, :V_QTY);
  END
END^

/* ---------------------------------------------------------------------------
   6. MERGE_GOODS_ACNT - aceeasi procedura ca in merge_goods_acnt.sql, plus
      oprirea TS_GOODS_AU_ACNT la pasul 1 (soldurile se muta integral la pasul 2)
   --------------------------------------------------------------------------- */
CREATE OR ALTER EXCEPTION E_MERGE_GOODS_ACNT
  'Unirea denumirilor de contabilitate nu este posibila.'^

CREATE OR ALTER PROCEDURE MERGE_GOODS_ACNT (
    OLD_GOODS_ACNT_ID INTEGER,
    NEW_GOODS_ACNT_ID INTEGER)
AS
DECLARE VARIABLE V_DT INTEGER;
DECLARE VARIABLE V_QTY NUMERIC(18,4);
BEGIN
  IF ((OLD_GOODS_ACNT_ID IS NULL) OR (NEW_GOODS_ACNT_ID IS NULL)) THEN
    EXCEPTION E_MERGE_GOODS_ACNT 'Codurile pentru unire nu sunt indicate.';

  IF (OLD_GOODS_ACNT_ID = NEW_GOODS_ACNT_ID) THEN
    EXIT;

  IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_ACNT
                  WHERE GOODS_ACNT_ID = :OLD_GOODS_ACNT_ID)) THEN
    EXCEPTION E_MERGE_GOODS_ACNT 'Denumirea veche nu exista in nomenclator.';

  IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_ACNT
                  WHERE GOODS_ACNT_ID = :NEW_GOODS_ACNT_ID)) THEN
    EXCEPTION E_MERGE_GOODS_ACNT 'Denumirea noua nu exista in nomenclator.';

  IF (EXISTS(SELECT 1 FROM TS_GOODS_ACNT
              WHERE GOODS_ACNT_ID IN (:OLD_GOODS_ACNT_ID, :NEW_GOODS_ACNT_ID)
                AND FLG_FOLDER = 1)) THEN
    EXCEPTION E_MERGE_GOODS_ACNT 'Mapele nu pot fi unite.';

  /* 1. produsele trec pe denumirea noua; TS_GOODS_AU_ACNT nu muta stocul,
        fiindca soldurile se muta integral la pasul 2 */
  RDB$SET_CONTEXT('USER_TRANSACTION', 'ACNT_STOCK_SKIP_GOODS', '1');
  BEGIN
    UPDATE TS_GOODS
       SET GOODS_ACNT_ID = :NEW_GOODS_ACNT_ID
     WHERE GOODS_ACNT_ID = :OLD_GOODS_ACNT_ID;
    WHEN ANY DO
    BEGIN
      RDB$SET_CONTEXT('USER_TRANSACTION', 'ACNT_STOCK_SKIP_GOODS', NULL);
      EXCEPTION;
    END
  END
  RDB$SET_CONTEXT('USER_TRANSACTION', 'ACNT_STOCK_SKIP_GOODS', NULL);

  /* 2. soldurile contabile - PK este (GOODS_ACNT_ID, DT), deci se cumuleaza */
  FOR SELECT DT, QTY_ACCOUNT
        FROM TS_GOODS_ACNT_STOCK
       WHERE GOODS_ACNT_ID = :OLD_GOODS_ACNT_ID
        INTO :V_DT, :V_QTY
  DO
  BEGIN
    IF (EXISTS(SELECT 1 FROM TS_GOODS_ACNT_STOCK
                WHERE GOODS_ACNT_ID = :NEW_GOODS_ACNT_ID AND DT = :V_DT)) THEN
      UPDATE TS_GOODS_ACNT_STOCK
         SET QTY_ACCOUNT = COALESCE(QTY_ACCOUNT, 0) + COALESCE(:V_QTY, 0)
       WHERE GOODS_ACNT_ID = :NEW_GOODS_ACNT_ID AND DT = :V_DT;
    ELSE
      INSERT INTO TS_GOODS_ACNT_STOCK (GOODS_ACNT_ID, DT, QTY_ACCOUNT)
      VALUES (:NEW_GOODS_ACNT_ID, :V_DT, COALESCE(:V_QTY, 0));
  END

  DELETE FROM TS_GOODS_ACNT_STOCK
   WHERE GOODS_ACNT_ID = :OLD_GOODS_ACNT_ID;

  /* 3. tabela istorica (nu exista pe toate bazele) */
  IF (EXISTS(SELECT 1 FROM RDB$RELATIONS
              WHERE RDB$RELATION_NAME = 'TMP_SLD_ACNT2012')) THEN
    EXECUTE STATEMENT ('UPDATE TMP_SLD_ACNT2012 SET GOODS_ACNT_ID = ? WHERE GOODS_ACNT_ID = ?')
      (:NEW_GOODS_ACNT_ID, :OLD_GOODS_ACNT_ID);

  /* 4. subordonatele - altfel trigerul TRG_TS_GOODS_ACNT_BD0 blocheaza stergerea */
  UPDATE TS_GOODS_ACNT
     SET PARENTID = :NEW_GOODS_ACNT_ID
   WHERE PARENTID = :OLD_GOODS_ACNT_ID;

  /* 5. stergerea din nomenclator */
  DELETE FROM TS_GOODS_ACNT
   WHERE GOODS_ACNT_ID = :OLD_GOODS_ACNT_ID;
END^

/* ---------------------------------------------------------------------------
   7. SP_MERGE_GOODS - sursa din baza SW (19.09.2026) cu trei modificari
      marcate "19.09.2026": DISSABLE_TRIGGERS dupa verificare, reset la eroare,
      mutarea stocului contabil intre denumirile celor doua produse
   --------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE SP_MERGE_GOODS (
    GOODSID_OLD DM_INTEGER,
    GOODSID_NEW DM_INTEGER)
AS
declare GOODS_CODE_OLD DM_VARCHAR512;
declare GOODS_CODE_NEW DM_VARCHAR512;
declare SUPPLIERID_OLD DM_INTEGER;
declare SUPPLIERID_NEW DM_INTEGER;
declare GOODS_TITLE DM_VARCHAR2048;
declare PRICE1 DM_AMOUNT;
declare PRICE2 DM_AMOUNT;
declare PRICE3 DM_AMOUNT;
declare PRICE4 DM_AMOUNT;
declare PRICE5 DM_AMOUNT;
declare PRICE6 DM_AMOUNT;
declare PRICE7 DM_AMOUNT;
declare ORD_PRICE7 DM_AMOUNT;

declare CURRENCY1ID DM_INTEGER;
declare CURRENCY2ID DM_INTEGER;
declare CURRENCY3ID DM_INTEGER;
declare CURRENCY4ID DM_INTEGER;
declare CURRENCY5ID DM_INTEGER;
declare CURRENCY6ID DM_INTEGER;
declare CURRENCY7ID DM_INTEGER;
declare ORD_CURRENCY7ID DM_INTEGER;
declare FLAGS DM_INTEGER;
declare V_GA_OLD DM_INTEGER;
declare V_GA_NEW DM_INTEGER;
declare V_DT DM_INTEGER;
declare V_QTY DM_QTY;
begin
  /* UPD: 13.05.2014 - JOHN */
  /* Facem verificari inainte de unirea produselor */
  /* 1. Produsele trebuie sa aiba acelas tip de evidenta */
  if ((select iif(T1 = T2, 1, 0)
       from (select (select SERIAL_TYPE_ID
                     from TS_GOODS
                     where GOODSID = :GOODSID_OLD) T1,
                     (select SERIAL_TYPE_ID
                      from TS_GOODS
                      where GOODSID = :GOODSID_NEW) T2
             from RDB$DATABASE)) = 0) then
    exception ERR_GENERAL_ERROR '<MSG>Produsele au tip de evidenta diferit!</MSG>';

  /* 19.09.2026: DISSABLE_TRIGGERS se seteaza abia dupa verificari, iar la orice
     eroare se reseteaza (blocul WHEN ANY de la sfarsit) - altfel ramanea 'YES'
     pe toata sesiunea WMS si triggerele nu mai rulau */
  rdb$set_context('USER_SESSION', 'DISSABLE_TRIGGERS', 'YES');
  begin

  /* pentru concatenarea produselor avem nevoie de permisiunea de modificarea documentelor */
  rdb$set_context('USER_TRANSACTION', 'RequireModifyDOC', 1);

  delete from TDB_GOODS_FLAGS
  where GOODSID = :GOODSID_OLD;

  delete from TDB_GOODS_PRICE
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_DESCRIPTIONS
  where GOODSID = :GOODSID_OLD;

  update MK_JURNAL_CASHBACK
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  /* 19.09.2026: liniile trec pe produsul nou cu triggerele oprite, deci stocul
     contabil se muta aici, daca produsele au denumiri de contabilitate diferite */
  select GOODS_ACNT_ID from TS_GOODS where GOODSID = :GOODSID_OLD into :V_GA_OLD;
  select GOODS_ACNT_ID from TS_GOODS where GOODSID = :GOODSID_NEW into :V_GA_NEW;
  if (V_GA_OLD is distinct from V_GA_NEW) then
    for select D.DT, sum(J.QTY * FN_ACNT_STOCK_SIGN(D.DOCTYPEID, D.DT))
        from TDB_JURNAL J
        join TDB_DOCS D on D.DOCID = J.DOCID
        join TS_DOCTYPES T on T.DOCTYPEID = D.DOCTYPEID
        where J.GOODSID = :GOODSID_OLD
          and GET_FLG_VALUE(T.FLAGS, 6) = 1
        group by D.DT
        into :V_DT, :V_QTY
    do
    begin
      execute procedure SP_ACNT_STOCK_ADD(:V_DT, :V_GA_OLD, -:V_QTY);
      execute procedure SP_ACNT_STOCK_ADD(:V_DT, :V_GA_NEW, :V_QTY);
    end

  update TDB_JURNAL
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD order by DOCID desc;

  update tdb_jurnal_sp j
  set j.dt_goodsid=:goodsid_new
  where dt_goodsid = :goodsid_old;

  update tdb_jurnal_sp j
  set j.ct_goodsid=:goodsid_new
  where ct_goodsid = :goodsid_old;


  update TS_COMPLECTE
  set TS_COMPLECTE.GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TS_GOODS_CERTIFICATES
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TS_GOODS_COMPATIBLE
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_DSC
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_FILTERS
  where GOODSID = :GOODSID_OLD;

  GOODS_CODE_OLD = '';
  GOODS_CODE_NEW = '';
  SUPPLIERID_OLD = -1;
  SUPPLIERID_NEW = -1;

  for select distinct GOODS_CODE, CUSTOMERID, GOODS_TITLE, CURRENCY1ID, CURRENCY2ID, CURRENCY3ID, CURRENCY5ID,
                      CURRENCY6ID, PRICE1, PRICE2, PRICE3, PRICE4, PRICE5, PRICE6, PRICE7, ORD_PRICE7, CURRENCY4ID,
                      CURRENCY7ID, ORD_CURRENCY7ID, FLAGS
      from TS_GOODS_FOREIGN
      where GOODSID in (:GOODSID_OLD, :GOODSID_NEW)
      into :GOODS_CODE_OLD, :SUPPLIERID_OLD, :GOODS_TITLE, :CURRENCY1ID, :CURRENCY2ID, :CURRENCY3ID, :CURRENCY5ID,
           :CURRENCY6ID, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7, :ORD_PRICE7, :CURRENCY4ID,
           :CURRENCY7ID, :ORD_CURRENCY7ID, :FLAGS
  do
  begin
    update or insert into TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, CURRENCY1ID, CURRENCY2ID,
                                            CURRENCY3ID, CURRENCY5ID, CURRENCY6ID, PRICE1, PRICE2, PRICE3, PRICE4,
                                            PRICE5, PRICE6, PRICE7, ORD_PRICE7, CURRENCY4ID, CURRENCY7ID,
                                            ORD_CURRENCY7ID, FLAGS)
    values (:GOODSID_NEW, :SUPPLIERID_OLD, :GOODS_CODE_OLD, :GOODS_TITLE, :CURRENCY1ID, :CURRENCY2ID, :CURRENCY3ID,
            :CURRENCY5ID, :CURRENCY6ID, :PRICE1, :PRICE2, :PRICE3, :PRICE4, :PRICE5, :PRICE6, :PRICE7, :ORD_PRICE7,
            :CURRENCY4ID, :CURRENCY7ID, :ORD_CURRENCY7ID, :FLAGS)
    matching (GOODSID, CUSTOMERID, GOODS_CODE);
  end

  update TLOG_GOODS_FOREIGN
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_FOREIGN
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_IMAGE
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_PRICE
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_PRICE_HISTORY
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS_STOCK
  where GOODSID = :GOODSID_OLD;

  update TS_GOODS_YOUTUBE_VIDEO
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TS_KIT_TEMPLATE_ITEMS
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TWEB_SHOP_CART
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  delete from TWEB_PA_GOODS
  where GOODSID = :GOODSID_OLD;

  update TLOG_GOODS_FOREIGN
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TDB_DOCS_CASHBACK A
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  update TWEB_SHOP_CART_ECOMM
  set GOODSID = :GOODSID_NEW
  where GOODSID = :GOODSID_OLD;

  delete from TS_GOODS
  where GOODSID = :GOODSID_OLD;

  insert into tweb_goods_redirect(goodsid_old, goodsid_new, redirect_code)
  values (:goodsid_old, :goodsid_new, 301);

    when any do
    begin
      rdb$set_context('USER_SESSION', 'DISSABLE_TRIGGERS', 'NO');
      exception;
    end
  end

  rdb$set_context('USER_SESSION', 'DISSABLE_TRIGGERS', 'NO');

end
^

/* ---------------------------------------------------------------------------
   8. Recalcularea completa - aceeasi regula ca FN_ACNT_STOCK_SIGN, scrisa cu
      JOIN-uri (mult mai rapid decat functia apelata pe fiecare linie)
   --------------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE RECALC_ALL_STOCK_ACNT
AS
DECLARE VARIABLE DT INTEGER;
DECLARE VARIABLE GOODS_ACNT_ID INTEGER;
DECLARE VARIABLE QTY DM_QTY;
BEGIN
  UPDATE TS_GOODS_ACNT_STOCK SA
     SET SA.QTY_ACCOUNT = 0
   WHERE SA.QTY_ACCOUNT IS DISTINCT FROM 0;

  FOR SELECT D.DT, G.GOODS_ACNT_ID,
             SUM(IIF(GET_FLG_VALUE(T.FLAGS, 4) = 1, J.QTY, -J.QTY))
        FROM TS_DOCTYPES T
        JOIN TDB_DOCS D ON D.DOCTYPEID = T.DOCTYPEID
        JOIN TS_CUSTOMER C ON C.CUSTOMERID = D.DT AND COALESCE(C.VAT, 0) > 0
        JOIN TDB_JURNAL J ON J.DOCID = D.DOCID
        JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
       WHERE GET_FLG_VALUE(T.FLAGS, 6) = 1
         AND G.GOODS_ACNT_ID IS NOT NULL
       GROUP BY D.DT, G.GOODS_ACNT_ID
      HAVING SUM(IIF(GET_FLG_VALUE(T.FLAGS, 4) = 1, J.QTY, -J.QTY)) <> 0
        INTO :DT, :GOODS_ACNT_ID, :QTY
  DO
  BEGIN
    UPDATE OR INSERT INTO TS_GOODS_ACNT_STOCK (DT, GOODS_ACNT_ID, QTY_ACCOUNT)
    VALUES (:DT, :GOODS_ACNT_ID, :QTY)
    MATCHING (DT, GOODS_ACNT_ID);
  END
END^

SET TERM ; ^

/* ---------------------------------------------------------------------------
   9. Drepturi (WMS lucreaza ca SWN / SYSDBA, site-ul ca WEBUSER - ambele
      insereaza in TDB_JURNAL si TDB_DOCS)
   --------------------------------------------------------------------------- */
GRANT EXECUTE ON FUNCTION FN_ACNT_STOCK_SIGN TO PUBLIC;
GRANT EXECUTE ON PROCEDURE SP_ACNT_STOCK_ADD TO PUBLIC;
GRANT SELECT ON TS_DOCTYPES TO FUNCTION FN_ACNT_STOCK_SIGN;
GRANT SELECT ON TS_CUSTOMER TO FUNCTION FN_ACNT_STOCK_SIGN;
GRANT SELECT, INSERT, UPDATE ON TS_GOODS_ACNT_STOCK TO PROCEDURE SP_ACNT_STOCK_ADD;
GRANT EXECUTE ON PROCEDURE MERGE_GOODS_ACNT TO PUBLIC;

COMMIT;

/* ---------------------------------------------------------------------------
   10. Realinierea stocului contabil cu TDB_JURNAL (cateva minute)
   --------------------------------------------------------------------------- */
EXECUTE PROCEDURE RECALC_ALL_STOCK_ACNT;
COMMIT;

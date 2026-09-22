/* ------------------------------------------------------------------
   MERGE_GOODS_ACNT - unirea a doua denumiri de contabilitate.

   Toate referintele spre OLD_GOODS_ACNT_ID sunt trecute pe
   NEW_GOODS_ACNT_ID, dupa care inregistrarea veche se sterge din
   nomenclatorul TS_GOODS_ACNT.

   Tabelele care refera TS_GOODS_ACNT.GOODS_ACNT_ID:
     TS_GOODS.GOODS_ACNT_ID            (FK, ON DELETE RESTRICT)
     TS_GOODS_ACNT_STOCK.GOODS_ACNT_ID (FK, PK = GOODS_ACNT_ID + DT)
     TMP_SLD_ACNT2012.GOODS_ACNT_ID    (fara FK, poate lipsi)
     TS_GOODS_ACNT.PARENTID            (subordonatele)

   Script repetabil.
   ------------------------------------------------------------------ */

SET TERM ^ ;

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

  /* 1. produsele trec pe denumirea noua; TS_GOODS_AU_ACNT (goods_acnt_stock_fix.sql)
        nu muta stocul, fiindca soldurile se muta integral la pasul 2 */
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

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE MERGE_GOODS_ACNT TO PUBLIC;

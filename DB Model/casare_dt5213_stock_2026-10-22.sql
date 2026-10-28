/*
  Act de casare (DOCTYPEID = 129) pentru firma DT = 5213 (FANTASTIC.ONLINE)
  cu toata marfa care are stoc fizic > 0 (TS_GOODS_STOCK.QTY > 0) pe DT 5213.
  22.10.2026

  Ce face, la fel ca aplicatia (frame26AktSpisania + frmSelectGoodsToAddDialog):
   - antetul prin VW_TDB_DOCS (DOCID din SQ_TDB_DOCS_DOCID, valori din
     SP_GET_DOCTYPE_DEFAULTS(129, 5213): SC2 = -1, CURRENCYID = 498, FLG_ACNT = 0);
   - cate un rand prin VW_TDB_JURNAL pentru fiecare (DTDEP, GOODSID) cu stoc > 0,
     QTY = stocul curent, FLG_ACTIVE = 1, FLG_READY = 0, CTDEP = -1;
   - preturile ca butonul "1 grila": APPLY_PRICE_GOODSCOMPLECT(DOCID, NULL, 1).
  Stocul fizic scade chiar la inserarea randurilor (TDB_JURNAL_INS_QTY, tipul 129
  are FLG_INVOICE). Documentul ramane DESCHIS: inainte de "Inchide document"
  (SP_CLOSE_AKTSPISANIA) trebuie alese seriile/partidele fiecarui rand in WMS.

  Antetul are un singur depozit (HDR_DTDEP); fiecare rand pastreaza depozitul sau.

  Repetabil: daca exista deja un act 129 deschis pe DT 5213 creat azi de
  userul 204 cu randuri, blocul se opreste fara sa scrie nimic.
  Un singur EXECUTE BLOCK = o singura instructiune: orice eroare anuleaza tot.

  DRY_RUN = 1 -> face totul, apoi arunca exceptie cu rezultatul (rollback complet).
  DRY_RUN = 0 -> scrie efectiv.
*/

SET TERM ^ ;

EXECUTE BLOCK
RETURNS (
  NEW_DOCID INTEGER,
  NROWS INTEGER,
  SUMQTY NUMERIC(18,4),
  DOC_SUMA NUMERIC(18,2))
AS
  DECLARE DRY_RUN INTEGER = 0;
  DECLARE FIRMA INTEGER = 5213;
  DECLARE HDR_DTDEP INTEGER = 127;
  DECLARE USERID INTEGER = 204;
  DECLARE EXP_ROWS INTEGER;
  DECLARE EXP_QTY NUMERIC(18,4);
  DECLARE LEFT_POS INTEGER;
  DECLARE V_DTDEP INTEGER;
  DECLARE V_GOODSID INTEGER;
  DECLARE V_QTY NUMERIC(18,4);
  DECLARE V_UMID INTEGER;
  DECLARE V_WARRANTY INTEGER;
BEGIN
  IF (EXISTS(SELECT 1 FROM TDB_DOCS d
             WHERE d.DOCTYPEID = 129 AND d.DT = :FIRMA AND d.CREATED_BY = :USERID
               AND d.CREATED_DATE >= CURRENT_DATE AND d.DELETED_DATE IS NULL
               AND GET_FLG_VALUE(d.FLAGS, 10) = 0
               AND EXISTS(SELECT 1 FROM TDB_JURNAL j WHERE j.DOCID = d.DOCID))) THEN
    EXCEPTION ERR_GENERAL_ERROR 'Actul de casare pentru DT 5213 a fost deja creat azi';

  /* triggerele (GET_QUICK_ACCESS_PERIOD, CREATED_BY, jurnalul de log) cer userul in context */
  RDB$SET_CONTEXT('USER_SESSION', 'UserID', :USERID);

  SELECT COUNT(*), COALESCE(SUM(s.QTY), 0)
  FROM TS_GOODS_STOCK s
  WHERE s.DT = :FIRMA AND s.QTY > 0
  INTO :EXP_ROWS, :EXP_QTY;

  IF (EXP_ROWS = 0) THEN
    EXCEPTION ERR_GENERAL_ERROR 'Pe DT 5213 nu exista stoc > 0';

  NEW_DOCID = NEXT VALUE FOR SQ_TDB_DOCS_DOCID;

  INSERT INTO VW_TDB_DOCS (DOCID, DATA, DT, CT, DTDEP, CTDEP, DTSC, CTSC, SC2,
    SUMA, VAT, CURRENCYID, DISCOUNT, RATE, RATEUSD, FLG_ACNT, FLG_CLOSED,
    CREATED_BY, PARENTDOCID, ACC$MASK, DOCTYPEID, CONTRACTID)
  VALUES (:NEW_DOCID, CURRENT_TIMESTAMP, :FIRMA, -1, :HDR_DTDEP, -1, -1, -1, -1,
    0, 0, 498, 0, 1, (SELECT EXCHANGE_RATE FROM TS_CURRENCY WHERE CURRENCYID = 840), 0, 0,
    :USERID, -1, 0, 129, -1);

  FOR SELECT s.DTDEP, s.GOODSID, s.QTY, g.UMID, COALESCE(g.WARRANTY, 0)
      FROM TS_GOODS_STOCK s
      JOIN TS_GOODS g ON g.GOODSID = s.GOODSID
      WHERE s.DT = :FIRMA AND s.QTY > 0
      ORDER BY s.DTDEP, s.GOODSID
      INTO :V_DTDEP, :V_GOODSID, :V_QTY, :V_UMID, :V_WARRANTY
  DO
    INSERT INTO VW_TDB_JURNAL (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, UMID,
      QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY, COST,
      FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE, FLG_RETURNED_GOODS, SUMA_SERVICII)
    VALUES (:NEW_DOCID, :V_DTDEP, -1, -1, :V_GOODSID, :V_UMID,
      :V_QTY, 0, 0, 0, :V_WARRANTY, 0, 0,
      1, 0, 0, 0, 0, 0);

  /* preturile dupa grila 1, ca in aplicatie */
  EXECUTE PROCEDURE APPLY_PRICE_GOODSCOMPLECT(:NEW_DOCID, NULL, 1);

  /* verificari */
  SELECT COUNT(*), COALESCE(SUM(j.QTY), 0)
  FROM TDB_JURNAL j
  WHERE j.DOCID = :NEW_DOCID
  INTO :NROWS, :SUMQTY;

  SELECT COUNT(*) FROM TS_GOODS_STOCK s WHERE s.DT = :FIRMA AND s.QTY > 0
  INTO :LEFT_POS;

  SELECT SUMA FROM TDB_DOCS WHERE DOCID = :NEW_DOCID INTO :DOC_SUMA;

  IF (NROWS <> EXP_ROWS OR SUMQTY <> EXP_QTY OR LEFT_POS <> 0) THEN
    EXCEPTION ERR_GENERAL_ERROR 'Verificare esuata: randuri ' || NROWS || '/' || EXP_ROWS ||
      ', cantitate ' || SUMQTY || '/' || EXP_QTY || ', ramas stoc > 0: ' || LEFT_POS;

  RDB$SET_CONTEXT('USER_SESSION', 'UserID', NULL);

  IF (DRY_RUN = 1) THEN
    EXCEPTION ERR_GENERAL_ERROR 'DRY RUN OK (rollback): DOCID ' || NEW_DOCID || ', randuri ' || NROWS ||
      ', cantitate ' || SUMQTY || ', suma ' || DOC_SUMA || ', ramas stoc > 0: ' || LEFT_POS;

  SUSPEND;
END^

SET TERM ; ^

COMMIT;

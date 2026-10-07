/* ------------------------------------------------------------------------
   DMLink (229466) - pricelist corectat din PLID 6019 (3 oct 2026)

   Importul API vechi (PLID 6009, 6019) a scris preturile inversat:
     PRICE0 = nprice (mereu 0), PRICE3 = sprice (USD), PRICE7 = rprice (lei, marcat 840)
   -> reevaluarile din ele opresc CLOSE_REEVALUARE ("goodscode: YNDX-00053E ...":
   12 499 lei ca USD, politica 150 nu are formula pentru suma asta).

   Conventia pricelisturilor DMLink: PRICE0 = PRICE7 = sprice (840), PRICE3 = rprice (498).

   Scriptul NU modifica 6019 (UPDATE pe TS_PRICELIST_ITEMS porneste triggerul care
   scrie in TS_GOODS_FOREIGN); creeaza un pricelist nou, copie a lui 6019 cu
   preturile puse corect. Dupa rulare: reevaluarea se face din pricelistul nou,
   iar 6009 / 6019 si reevaluarile 2181128, 2181203, 2181205, 2181206 se sterg din WMS.

   Repetabil: daca exista deja un pricelist corectat din 6019, nu face nimic.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

EXECUTE BLOCK
RETURNS (NEW_PLID INTEGER, ITEMS INTEGER)
AS
DECLARE SRC_PLID INTEGER = 6019;
DECLARE MARK VARCHAR(100) = 'Import automat DMLink API (corectat din 6019)';
BEGIN
  ITEMS = 0;
  SELECT FIRST 1 PLID FROM TS_PRICELISTS
  WHERE SUPPLIERID = 229466 AND MENTIUNI = :MARK
  INTO :NEW_PLID;
  IF (NEW_PLID IS NOT NULL) THEN
  BEGIN
    SUSPEND;
    EXIT;
  END

  INSERT INTO TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, FLAGS, MENTIUNI)
  SELECT SUPPLIERID, PRICE_CATEGORYID, FLAGS, :MARK
  FROM TS_PRICELISTS WHERE PLID = :SRC_PLID
  RETURNING PLID INTO :NEW_PLID;

  INSERT INTO TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, GOODSID, SUPPLIER_GOODS_NAME, STOCK_QTY, FLAGS,
    PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, WARANTY, SUPPLIER_GOODS_BRAND,
    SUPPLIER_GOODS_MODEL, SUPPLIER_GOODSTYPE, GOODSTYPEID, SYSTEM_VENDORID, PARENTGOODSID,
    SUPPLIER_CATEGORY, COMPATIBILITATE, FLG_PREORDER, TVA, PRODUCT_LINK)
  SELECT :NEW_PLID, I.SUPPLIER_GOODS_CODE, I.GOODSID, I.SUPPLIER_GOODS_NAME, I.STOCK_QTY, I.FLAGS,
    I.PRICE3, 840,          /* PRICE0 = sprice (USD) */
    I.PRICE7, 498,          /* PRICE3 = rprice (lei) */
    I.PRICE3, 840,          /* PRICE7 = sprice (USD) */
    I.WARANTY, I.SUPPLIER_GOODS_BRAND,
    I.SUPPLIER_GOODS_MODEL, I.SUPPLIER_GOODSTYPE, I.GOODSTYPEID, I.SYSTEM_VENDORID, I.PARENTGOODSID,
    I.SUPPLIER_CATEGORY, I.COMPATIBILITATE, I.FLG_PREORDER, I.TVA, I.PRODUCT_LINK
  FROM TS_PRICELIST_ITEMS I
  WHERE I.PLID = :SRC_PLID;
  ITEMS = ROW_COUNT;

  SUSPEND;
END^

SET TERM ; ^

COMMIT;

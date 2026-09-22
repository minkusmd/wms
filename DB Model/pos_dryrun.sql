/* ============================================================================
   POS - PROBA pe baza reala, FARA URME: totul se face intr-o singura tranzactie
   care se termina cu ROLLBACK.

   Scop: SP_POS_CLOSE_SALE / SP_POS_REGISTER_RECEIPT au fost testate doar pe o
   baza locala cu stub-uri. Aici ruleaza cu triggerele reale de pe TDB_DOCS,
   TDB_JURNAL, TDB_PARTS, TDB_SN.

   Ce face: creeaza o casa + tura temporare, alege un produs cu evidenta pe
   partide care are stoc la depozit, il vinde (1 buc, numerar), inregistreaza
   un bon fictiv si afiseaza documentele rezultate. Apoi ROLLBACK.

   Ramin consumate doar valori de generatoare (DOCID-uri sarite) - inofensiv.
   POST_EVENT-urile si e-mailurile din triggere nu pleaca, fiindca nu exista COMMIT.

   De ajustat inainte de rulare, daca e cazul: FIRMA_ID, STOCKID, USERID.
   ============================================================================ */

SET TERM ^ ;

EXECUTE BLOCK
RETURNS (
    STEP VARCHAR(40),
    INFO VARCHAR(400))
AS
    DECLARE FIRMA_ID   INTEGER = 307225;
    DECLARE STOCKID    INTEGER = 43;
    DECLARE USERID     INTEGER = 204;
    DECLARE CUSTOMERID INTEGER;
    DECLARE POS_ID     INTEGER;
    DECLARE SHIFT_ID   INTEGER;
    DECLARE SALE_ID    INTEGER;
    DECLARE GOODSID    INTEGER;
    DECLARE PRICE      NUMERIC(15,2);
    DECLARE RASHOD     INTEGER;
    DECLARE FACTURA    INTEGER;
BEGIN
    RDB$SET_CONTEXT('USER_SESSION', 'UserID', :USERID);

    /* clientul: cel de pe ultima vinzare a firmei (doar pentru proba) */
    SELECT FIRST 1 CT FROM TDB_DOCS
    WHERE DOCTYPEID = 107 AND DT = :FIRMA_ID AND DELETED_DATE IS NULL
    ORDER BY DOCID DESC
    INTO :CUSTOMERID;

    /* un produs pe partide, cu stoc la depozit si cu pret */
    FOR SELECT FIRST 20 S.GOODSID
        FROM TS_GOODS_STOCK S
        JOIN TS_GOODS G ON G.GOODSID = S.GOODSID
        WHERE S.DT = :FIRMA_ID AND S.DTDEP = :STOCKID AND S.QTY >= 1
          AND G.SERIAL_TYPE_ID = 4402 AND G.FLG_FOLDER = 0
        INTO :GOODSID
    DO
    BEGIN
        PRICE = NULL;
        SELECT PRICE_MDL FROM GET_GOODS_PRICE(:GOODSID, 1, 498) INTO :PRICE;
        IF (COALESCE(PRICE, 0) > 0
            AND EXISTS(SELECT 1 FROM GET_AVAILABLE_PARTS(:FIRMA_ID, :GOODSID) A
                       WHERE A.STOCKID = :STOCKID AND A.QTY >= 1)) THEN
            LEAVE;
        GOODSID = NULL;
    END

    STEP = 'intrare';
    INFO = 'client=' || COALESCE(CUSTOMERID, -1) || ' produs=' || COALESCE(GOODSID, -1) || ' pret=' || COALESCE(PRICE, 0);
    SUSPEND;
    IF (CUSTOMERID IS NULL OR GOODSID IS NULL) THEN
    BEGIN
        STEP = 'STOP';
        INFO = 'Nu am gasit client sau produs potrivit pentru proba.';
        SUSPEND;
        EXIT;
    END

    INSERT INTO TPOS_TERMINAL (TITLE, FIRMA_ID, STOCKID, DEFAULT_CUSTOMERID)
    VALUES ('PROBA - se sterge la rollback', :FIRMA_ID, :STOCKID, :CUSTOMERID)
    RETURNING POS_ID INTO :POS_ID;

    SELECT SHIFT_ID FROM SP_POS_SHIFT_OPEN(:POS_ID, 0) INTO :SHIFT_ID;

    INSERT INTO TPOS_SALE (POS_ID, SHIFT_ID, CUSTOMERID, CREATED_BY)
    VALUES (:POS_ID, :SHIFT_ID, :CUSTOMERID, :USERID)
    RETURNING SALE_ID INTO :SALE_ID;
    INSERT INTO TPOS_SALE_ITEM (SALE_ID, GOODSID, QTY, PRICE, SUMA) VALUES (:SALE_ID, :GOODSID, 1, :PRICE, :PRICE);
    INSERT INTO TPOS_SALE_PAYMENT (SALE_ID, PAY_CODE, SUMA, TENDERED) VALUES (:SALE_ID, 'PAY_CASH', :PRICE, :PRICE);

    SELECT RASHOD_DOCID, FACTURA_DOCID FROM SP_POS_CLOSE_SALE(:SALE_ID) INTO :RASHOD, :FACTURA;
    STEP = 'SP_POS_CLOSE_SALE';
    INFO = 'vinzare 107=' || :RASHOD || ' factura 112=' || :FACTURA;
    SUSPEND;

    FOR SELECT 'doc ' || DOCTYPEID,
               'docid=' || DOCID || ' parinte=' || COALESCE(PARENTDOCID, -1) || ' suma=' || SUMA ||
               ' tva=' || COALESCE(VAT, 0) || ' dtsc=' || COALESCE(DTSC, -1) || ' flags=' || COALESCE(FLAGS, 0)
        FROM TDB_DOCS
        WHERE DOCID = :RASHOD OR PARENTDOCID = :RASHOD
        ORDER BY DOCID
        INTO :STEP, :INFO
    DO SUSPEND;

    FOR SELECT 'jurnal ' || DOCID,
               'produs=' || GOODSID || ' cant=' || QTY || ' pret=' || PRICE || ' suma=' || SUMA ||
               ' flags=' || COALESCE(FLAGS, 0) || ' (bit 2 = FLG_READY: ' || GET_FLG_VALUE(FLAGS, 2) || ')'
        FROM TDB_JURNAL
        WHERE DOCID IN (:RASHOD, :FACTURA)
        ORDER BY DOCID
        INTO :STEP, :INFO
    DO SUSPEND;

    FOR SELECT 'partida', 'partno=' || PARTNO || ' cant=' || QTY
        FROM TDB_PARTS WHERE DOCID = :RASHOD
        INTO :STEP, :INFO
    DO SUSPEND;

    EXECUTE PROCEDURE SP_POS_REGISTER_RECEIPT(:SALE_ID, 1, CURRENT_TIMESTAMP, 0);
    FOR SELECT 'bon', 'factura=' || DOCID || ' nr=' || NUMAR_BON || ' suma=' || SUMA ||
               ' incasare=' || PRIHOD_DOCID || ' flags=' || FLAGS
        FROM TDB_DOCS_RECEIPT WHERE SALE_ID = :SALE_ID
        INTO :STEP, :INFO
    DO SUSPEND;

    FOR SELECT 'linii bon fiscal', TRIM(NAMEACNT) || ' | cant=' || QTY || ' pret=' || PRICE || ' tva=' || SUMAVAT
        FROM GET_GOODS_FOR_RECEIPT(:FACTURA)
        INTO :STEP, :INFO
    DO SUSPEND;

    FOR SELECT 'sumar tura', 'numerar=' || CASH_SALES || ' asteptat=' || EXPECTED_CASH || ' bonuri=' || SALES_COUNT
        FROM SP_POS_SHIFT_SUMMARY(:SHIFT_ID)
        INTO :STEP, :INFO
    DO SUSPEND;

    STEP = 'GATA';
    INFO = 'Urmeaza ROLLBACK - in baza nu ramine nimic.';
    SUSPEND;
END^

SET TERM ; ^

ROLLBACK;

/* ============================================================================
   Reevaluare din pretul de pe site-ul furnizorului (parser zilnic, ex. h-t.md,
   furnizor 262735).

   Furnizorul trimite pricelist o data pe luna, dar pe site preturile se schimba
   zilnic. Parserul citeste pretul de pe site pentru articolele active
   (FLG_IN_PRICE = bitul 3 din TS_GOODS_FOREIGN.FLAGS = 1) si creeaza o
   reevaluare obisnuita (DOCTYPEID = 1414), pe care o inchide cu CLOSE_REEVALUARE.

   SP_SITE_REEVAL_ADD_ITEM adauga o pozitie in reevaluare:
     PRICE3 = pretul de pe site - TS_CUSTOMER.RRP_DISCOUNT %, cu aceeasi rotunjire
              ca ADJUST_RRP_REEVALUATION: ceil(round(p - abs(p / 100 * procent))).
              De aceea ADJUST_RRP_REEVALUATION NU se mai apeleaza pe acest document
              (ar scadea procentul a doua oara).
     restul (PRICE0, PRICE4, PRICE7 = ORD_PRICE7, valute, cod de bare, flagurile
              2 = promo furnizor, 3 = in pricelist, 4 = EPP, 6 = pre-comanda) se
              copiaza de pe articol, pentru ca CLOSE_REEVALUARE le rescrie pe toate.

   Pretul de vinzare (PRICE1) si toate protectiile ramin in triggerul
   TS_GOODS_FOREIGN_BIU, care ruleaza la UPDATE-ul facut de CLOSE_REEVALUARE.

   Script RE-RULABIL.
   ============================================================================ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_SITE_REEVAL_ADD_ITEM (
    ADOCID      INTEGER,
    AGOODSID    INTEGER,
    AGOODS_CODE VARCHAR(128),
    ASITE_PRICE NUMERIC(15,2))
RETURNS (
    OLD_PRICE3 NUMERIC(15,2),
    NEW_PRICE3 NUMERIC(15,2))
AS
    DECLARE CUSTOMERID  INTEGER;
    DECLARE DOCTYPEID   INTEGER;
    DECLARE DOCFLAGS    INTEGER;
    DECLARE PCT         DOUBLE PRECISION;
    DECLARE FOUND       INTEGER;
    DECLARE PRICE0      DOUBLE PRECISION;
    DECLARE CURRENCY0ID INTEGER;
    DECLARE PRICE4      DOUBLE PRECISION;
    DECLARE CURRENCY4ID INTEGER;
    DECLARE PRICE7      DOUBLE PRECISION;
    DECLARE CURRENCY7ID INTEGER;
    DECLARE BARCODE     VARCHAR(128);
    DECLARE GFFLAGS     INTEGER;
BEGIN
    SELECT CT, DOCTYPEID, FLAGS FROM TDB_DOCS WHERE DOCID = :ADOCID
    INTO :CUSTOMERID, :DOCTYPEID, :DOCFLAGS;
    IF (CUSTOMERID IS NULL OR DOCTYPEID <> 1414) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Documentul ' || COALESCE(:ADOCID, 0) || ' nu este o reevaluare.';
    IF (GET_FLG_VALUE(DOCFLAGS, 10) = 1) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Reevaluarea ' || :ADOCID || ' este deja inchisa.';
    IF (COALESCE(ASITE_PRICE, 0) <= 0) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Pret de site invalid pentru ' || COALESCE(:AGOODS_CODE, '?') || '.';

    SELECT COUNT(*), MAX(GF.PRICE3), MAX(GF.PRICE0), MAX(GF.CURRENCY0ID), MAX(GF.PRICE4), MAX(GF.CURRENCY4ID),
           MAX(GF.ORD_PRICE7), MAX(GF.ORD_CURRENCY7ID), MAX(GF.BARCODE), MAX(GF.FLAGS)
    FROM TS_GOODS_FOREIGN GF
    WHERE GF.CUSTOMERID = :CUSTOMERID AND GF.GOODSID = :AGOODSID AND GF.GOODS_CODE = :AGOODS_CODE
    INTO :FOUND, :OLD_PRICE3, :PRICE0, :CURRENCY0ID, :PRICE4, :CURRENCY4ID,
         :PRICE7, :CURRENCY7ID, :BARCODE, :GFFLAGS;
    IF (FOUND <> 1) THEN
        EXCEPTION ERR_GENERAL_ERROR 'Articolul ' || COALESCE(:AGOODS_CODE, '?') || ' (produs ' ||
            COALESCE(:AGOODSID, 0) || ') nu exista o singura data la furnizorul ' || :CUSTOMERID || '.';

    SELECT COALESCE(RRP_DISCOUNT, 0) FROM TS_CUSTOMER WHERE CUSTOMERID = :CUSTOMERID INTO :PCT;
    PCT = COALESCE(PCT, 0);

    /* aceeasi formula ca in ADJUST_RRP_REEVALUATION */
    NEW_PRICE3 = CEIL(ROUND(ASITE_PRICE - ABS(ASITE_PRICE / 100 * PCT)));
    OLD_PRICE3 = COALESCE(OLD_PRICE3, 0);

    INSERT INTO TDB_GOODS_PRICE (DOCID, GOODSID, SUPPLIER_GOODS_CODE, PRICE0, CURRENCYID, PRICE3, CURRENCY3ID,
                                 PRICE4, CURRENCY4ID, PRICE7, CURRENCY7ID, BARCODE, FLAGS)
    VALUES (:ADOCID, :AGOODSID, :AGOODS_CODE, COALESCE(:PRICE0, 0), COALESCE(:CURRENCY0ID, 498), :NEW_PRICE3, 498,
            COALESCE(:PRICE4, 0), COALESCE(:CURRENCY4ID, 498), COALESCE(:PRICE7, 0), COALESCE(:CURRENCY7ID, 498),
            :BARCODE,
            /* bitii 2 (promo furnizor), 3 (in pricelist), 4 (EPP), 6 (pre-comanda) - aceleasi pozitii
               in TS_GOODS_FOREIGN.FLAGS si in TDB_GOODS_PRICE.FLAGS */
            BIN_AND(COALESCE(:GFFLAGS, 0), 4 + 8 + 16 + 64));

    SUSPEND;
END^

SET TERM ; ^

COMMIT;

GRANT EXECUTE ON PROCEDURE SP_SITE_REEVAL_ADD_ITEM TO SWN;
GRANT SELECT ON TDB_DOCS TO PROCEDURE SP_SITE_REEVAL_ADD_ITEM;
GRANT SELECT ON TS_GOODS_FOREIGN TO PROCEDURE SP_SITE_REEVAL_ADD_ITEM;
GRANT SELECT ON TS_CUSTOMER TO PROCEDURE SP_SITE_REEVAL_ADD_ITEM;
GRANT INSERT ON TDB_GOODS_PRICE TO PROCEDURE SP_SITE_REEVAL_ADD_ITEM;

COMMIT;

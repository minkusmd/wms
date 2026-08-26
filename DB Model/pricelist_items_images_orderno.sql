/* ------------------------------------------------------------------------
   TS_PRICELIST_ITEMS_IMAGES: coloana ORDERNO (ordinea imaginilor in galerie)
   ------------------------------------------------------------------------

   Context
   -------
   Tabela TS_PRICELIST_ITEMS_IMAGES nu are nicio coloana de ordine: cheia ei
   e (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL), iar singurul indiciu de
   ordine era PROCESS_DATE. In Firebird CURRENT_TIMESTAMP are rezolutie de
   ~15 ms, deci mai multe imagini ale aceluiasi produs primesc frecvent
   acelasi PROCESS_DATE - ordinea lor devine nedeterminata.

   Consumatorii (scriptul care copiaza pozele in TS_GOODS_IMAGE, grid-ul din
   frame-ul 78) citeau tabela fara ORDER BY, deci luau ordinea fizica din
   baza. Trigger-ul de pe TS_GOODS_IMAGE atribuie ORDERNO = MAX+1 la fiecare
   insert, iar site-ul ia imaginea principala dupa cel mai mic ORDERNO -
   asa ca imaginea principala ajungea sa fie una aleatorie. Aceeasi problema
   a fost tratata pentru Ultra.md in reimport_ultra_images_order.sql.

   Scriptul e re-rulabil.
   ------------------------------------------------------------------------ */


/* === 1. Coloana ORDERNO ================================================== */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                   WHERE RDB$RELATION_NAME = 'TS_PRICELIST_ITEMS_IMAGES'
                     AND RDB$FIELD_NAME    = 'ORDERNO')) THEN
        EXECUTE STATEMENT
            'ALTER TABLE TS_PRICELIST_ITEMS_IMAGES ADD ORDERNO INTEGER';
END^

SET TERM ; ^

COMMIT;


/* === 2. Index pe (SUPPLIERID, SUPPLIER_GOODS_CODE) =======================

   Toate interogarile filtreaza pe aceste doua coloane; indexul ajuta atat
   importul, cat si scriptul de reparare a ordinii. */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE RDB$INDEX_NAME = 'TS_PRICELIST_ITEMS_IMAGES_IDX1')) THEN
        EXECUTE STATEMENT
            'CREATE INDEX TS_PRICELIST_ITEMS_IMAGES_IDX1 ' ||
            'ON TS_PRICELIST_ITEMS_IMAGES (SUPPLIERID, SUPPLIER_GOODS_CODE)';
END^

SET TERM ; ^

COMMIT;


/* === 3. Backfill pentru randurile existente ==============================

   ATENTIE: acesta e doar un punct de plecare, NU o reparare. Reface ordinea
   din PROCESS_DATE (+ IMAGE_URL ca departajare stabila), deci pentru
   produsele unde scraper-ul a scris deja pozele amestecate ordinea ramane
   gresita - acelea se repara cu fix_maximum_image_order.py (reciteste
   pagina furnizorului si rescrie ORDERNO aici si in TS_GOODS_IMAGE).

   Se completeaza doar randurile cu ORDERNO NULL, deci se poate rula oricand. */

SET TERM ^ ;

EXECUTE BLOCK AS
DECLARE VARIABLE SUP     INTEGER;
DECLARE VARIABLE CODE    VARCHAR(512);
DECLARE VARIABLE URL     VARCHAR(2048);
DECLARE VARIABLE PREV_S  INTEGER;
DECLARE VARIABLE PREV_C  VARCHAR(512);
DECLARE VARIABLE N       INTEGER;
BEGIN
    PREV_S = NULL;
    PREV_C = NULL;
    N = 0;

    FOR SELECT SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL
        FROM TS_PRICELIST_ITEMS_IMAGES
        WHERE ORDERNO IS NULL
        ORDER BY SUPPLIERID, SUPPLIER_GOODS_CODE, PROCESS_DATE, IMAGE_URL
        INTO :SUP, :CODE, :URL
    DO
    BEGIN
        IF ((PREV_S IS DISTINCT FROM SUP) OR (PREV_C IS DISTINCT FROM CODE)) THEN
        BEGIN
            PREV_S = SUP;
            PREV_C = CODE;
            /* daca produsul are deja randuri numerotate, continuam de acolo */
            SELECT COALESCE(MAX(ORDERNO), 0)
            FROM TS_PRICELIST_ITEMS_IMAGES
            WHERE SUPPLIERID = :SUP AND SUPPLIER_GOODS_CODE = :CODE
            INTO :N;
        END

        N = N + 1;

        UPDATE TS_PRICELIST_ITEMS_IMAGES
        SET ORDERNO = :N
        WHERE SUPPLIERID = :SUP
          AND SUPPLIER_GOODS_CODE = :CODE
          AND IMAGE_URL = :URL;
    END
END^

SET TERM ; ^

COMMIT;


/* === 4. Verificare ======================================================= */

SELECT COUNT(*) AS FARA_ORDERNO FROM TS_PRICELIST_ITEMS_IMAGES WHERE ORDERNO IS NULL;

SELECT SUPPLIERID, COUNT(*) AS NR_IMAGINI, MIN(ORDERNO) AS MIN_ORD, MAX(ORDERNO) AS MAX_ORD
FROM TS_PRICELIST_ITEMS_IMAGES
GROUP BY SUPPLIERID
ORDER BY 1;

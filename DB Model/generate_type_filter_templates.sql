/* ------------------------------------------------------------------------
   Etapa 2 din plan_migrare_atribute_in_filtre.md
   Genereaza sabloanele de filtre pe tip de produs, din datele existente.

   Regula: intra in sablon filtrele folosite de cel putin PRAG_PCT % dintre
   produsele tipului care au MACAR UN filtru completat. Baza de calcul e
   importanta: la tipul 8 sunt 1.637 produse, dar doar 772 au filtre - raportarea
   la 1.637 ar injumatati acoperirea si ar taia filtre reale.

   Randurile generate primesc FLG_AUTO = 1. La re-rulare:
     - randurile FLG_AUTO = 1 se recalculeaza (sau se sterg daca au cazut sub prag);
     - randurile FLG_AUTO = 0 (revizuite/adaugate manual) NU se ating.
   Asta face scriptul re-rulabil fara sa distruga munca operatorilor.

   FLG_RECOMMENDED se pune automat la filtrele cu acoperire >= PRAG_RECOMANDAT %:
   sunt caracteristicile pe care aproape toate produsele tipului le au deja, deci
   lipsa lor la un produs nou merita semnalata.

   Tipuri procesate: cele din lista TIPURI de mai jos (pilot: 8, 297, 324).
   Pentru toate tipurile, inlocuieste conditia cu: WHERE 1 = 1.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

EXECUTE BLOCK AS
DECLARE VARIABLE PRAG_PCT          NUMERIC(5,1) = 20.0;
DECLARE VARIABLE PRAG_RECOMANDAT   NUMERIC(5,1) = 80.0;
DECLARE VARIABLE TIP               INTEGER;
DECLARE VARIABLE BAZA              INTEGER;
DECLARE VARIABLE FID               INTEGER;
DECLARE VARIABLE PCT               NUMERIC(5,1);
DECLARE VARIABLE ORD               INTEGER;
BEGIN
    FOR SELECT gt.GOODSTYPEID
        FROM TS_GOODS_TYPE gt
        WHERE gt.GOODSTYPEID IN (8, 297, 324)     /* <-- lista tipurilor */
        INTO :TIP
    DO
    BEGIN
        /* cate produse ale tipului au macar un filtru */
        SELECT COUNT(*)
          FROM TS_GOODS g
         WHERE g.WEBGOODSTYPE_ID = :TIP
           AND EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf WHERE gf.GOODSID = g.GOODSID)
          INTO :BAZA;

        IF (COALESCE(:BAZA, 0) = 0) THEN
            /* tip fara date - nu inventam sablon */
            CONTINUE;

        /* stergem propunerile automate vechi; cele manuale raman */
        DELETE FROM TS_GOODS_TYPE_FILTERS t
         WHERE t.GOODSTYPEID = :TIP AND COALESCE(t.FLG_AUTO, 0) = 1;

        ORD = 0;

        FOR SELECT gf.FILTERID,
                   CAST(100.0 * COUNT(DISTINCT gf.GOODSID) / :BAZA AS NUMERIC(5,1))
              FROM TS_GOODS_FILTERS gf
              JOIN TS_GOODS g ON g.GOODSID = gf.GOODSID
             WHERE g.WEBGOODSTYPE_ID = :TIP
             GROUP BY gf.FILTERID
            HAVING 100.0 * COUNT(DISTINCT gf.GOODSID) / :BAZA >= :PRAG_PCT
             ORDER BY 2 DESC
              INTO :FID, :PCT
        DO
        BEGIN
            /* daca operatorul a pus deja randul manual, il lasam in pace */
            IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_TYPE_FILTERS t
                            WHERE t.GOODSTYPEID = :TIP AND t.FILTERID = :FID)) THEN
            BEGIN
                ORD = :ORD + 1;
                INSERT INTO TS_GOODS_TYPE_FILTERS
                       (GOODSTYPEID, FILTERID, ORDERNO, FLG_RECOMMENDED,
                        FLG_AUTO, COVERAGE_PCT)
                VALUES (:TIP, :FID, :ORD,
                        IIF(:PCT >= :PRAG_RECOMANDAT, 1, 0), 1, :PCT);
            END
        END
    END
END^

SET TERM ; ^

COMMIT;


/* === Verificare ======================================================== */

SELECT t.GOODSTYPEID, gt.TITLE,
       COUNT(*) AS FILTRE_IN_SABLON,
       SUM(t.FLG_RECOMMENDED) AS DIN_CARE_RECOMANDATE
FROM TS_GOODS_TYPE_FILTERS t
JOIN TS_GOODS_TYPE gt ON gt.GOODSTYPEID = t.GOODSTYPEID
GROUP BY 1, 2
ORDER BY 1;

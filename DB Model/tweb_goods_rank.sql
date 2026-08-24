/* ============================================================================
   TWEB_GOODS_RANK - ordinea de relevanta a produselor in catalogul fantastic.md

   PROBLEMA REZOLVATA
   ------------------
   Pana acum catalogul era sortat rigid dupa pretul crescator
   (GET_GOODS_LIST_BY_CATALOG_F: "order by price"), asa ca vizitatorul vedea
   mereu doar produsele ieftine si comanda pe acelea, iar cosul mediu scade.

   SOLUTIA
   -------
   O tabela materializata cu un scor de relevanta per (CATALOGID, GOODSID),
   recalculata noaptea de WEB_CALC_GOODS_RANK (rulata prin SWNService).
   Procedurile de catalog sorteaza dupa RANK_NO in loc de pret.

   RANK_NO nu este pozitia bruta dupa scor, ci o intercalare pe 3 trepte de
   pret (PRICE_TIER = tertilele pretului in categorie):

       pozitia 1 -> treapta MEDIE   (tier 2)
       pozitia 2 -> treapta SCUMPA  (tier 3)
       pozitia 3 -> treapta IEFTINA (tier 1)
       pozitia 4 -> treapta MEDIE   ... si tot asa

   In interiorul fiecarei trepte produsele stau in ordinea scorului. Asa
   clientul vede din primul ecran un amestec de preturi, cu segmentul mediu
   si cel scump primele, iar produsele ieftine raman vizibile fara sa domine.

   PONDERILE SCORULUI (calibrate pe datele reale din baza SW, august 2026)
   ----------------------------------------------------------------------
   Acoperirea semnalelor in catalog (45.966 produse):
       vinzari ultimele 180 zile ....  ~9%   -> nu poate fi singurul criteriu
       adaugari in cos ..............  ~18%
       imagine ......................  ~90%
       stoc fizic ...................  ~0,8% (model "la comanda")
       recenzii .....................   0%   (tabela inca goala)
       TWEB_CLICK_LOG ............... inutilizabil - GOODSID nu s-a scris
                                       niciodata, iar logarea e oprita din 2025

   De aceea stocul da BONUS, nu penalizare (altfel 99% din catalog ar cadea),
   iar pentru coada lunga fara semnale decid calitatea fisei si zgomotul
   determinist NOISE, care inlocuieste ordinea dupa pret.

       0.30  rulaj 180 zile      (percent_rank in categorie)
       0.10  bucati 180 zile
       0.15  adaugari in cos 365 zile
       0.08  marja
       0.07  are imagine
       0.05  are descriere
       0.05  promo sau noutate
       0.05  are stoc fizic
       0.05  rating bayesian (0 daca nu are recenzii)
       0.10  NOISE determinist - stabil intre pagini, dar rupe ordinea dupa pret
       ----
       1.00

   Normalizarea se face IN INTERIORUL categoriei (PARTITION BY CATALOGID).
   Altfel accesoriile ieftine, vindute in mii de bucati, ar bate tehnica in
   toate listele.

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. Tabela ---------------------------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TWEB_GOODS_RANK')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TWEB_GOODS_RANK (
             CATALOGID  INTEGER NOT NULL,
             GOODSID    INTEGER NOT NULL,
             SCORE      DOUBLE PRECISION DEFAULT 0 NOT NULL,
             PRICE_TIER SMALLINT DEFAULT 2 NOT NULL,
             RANK_NO    INTEGER DEFAULT 999999999 NOT NULL,
             CALC_DATE  TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
         )';
END^

/* --- 2. Cheia primara si indecsii --------------------------------------- */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE TRIM(RDB$CONSTRAINT_NAME) = 'PK_TWEB_GOODS_RANK')) THEN
        EXECUTE STATEMENT
        'ALTER TABLE TWEB_GOODS_RANK
             ADD CONSTRAINT PK_TWEB_GOODS_RANK PRIMARY KEY (CATALOGID, GOODSID)';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TWEB_GOODS_RANK_ORDER')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TWEB_GOODS_RANK_ORDER ON TWEB_GOODS_RANK (CATALOGID, RANK_NO)';
END^

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE TRIM(RDB$INDEX_NAME) = 'IDX_TWEB_GOODS_RANK_GOODS')) THEN
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TWEB_GOODS_RANK_GOODS ON TWEB_GOODS_RANK (GOODSID)';
END^

/* --- 3. Recalcularea scorului ------------------------------------------- */
CREATE OR ALTER PROCEDURE WEB_CALC_GOODS_RANK
RETURNS (
    ROWS_WRITTEN INTEGER)
AS
BEGIN
  ROWS_WRITTEN = 0;

  DELETE FROM TWEB_GOODS_RANK;

  INSERT INTO TWEB_GOODS_RANK (CATALOGID, GOODSID, SCORE, PRICE_TIER, RANK_NO, CALC_DATE)
  SELECT
      s.CATALOGID,
      s.GOODSID,
      s.SCORE,
      s.PRICE_TIER,
      /* intercalarea treptelor de pret: medie, scumpa, ieftina, medie, ... */
      (ROW_NUMBER() OVER (PARTITION BY s.CATALOGID, s.PRICE_TIER
                          ORDER BY s.SCORE DESC, s.GOODSID) - 1) * 3
      + CASE s.PRICE_TIER WHEN 2 THEN 1 WHEN 3 THEN 2 ELSE 3 END,
      CURRENT_TIMESTAMP
  FROM (
      SELECT
          n.CATALOGID,
          n.GOODSID,
          n.PRICE_TIER,
            0.30 * n.P_TURNOVER
          + 0.10 * n.P_UNITS
          + 0.15 * n.P_CART
          + 0.08 * n.P_MARGIN
          + 0.07 * n.HAS_IMAGE
          + 0.05 * n.HAS_DESCR
          + 0.05 * n.FLG_PROMO_NEW
          + 0.05 * n.IN_STOCK
          + 0.05 * n.RATING_SCORE
          + 0.10 * n.NOISE  AS SCORE
      FROM (
          SELECT
              b.CATALOGID,
              b.GOODSID,
              NTILE(3)       OVER (PARTITION BY b.CATALOGID ORDER BY b.PRICE)     AS PRICE_TIER,
              PERCENT_RANK() OVER (PARTITION BY b.CATALOGID ORDER BY b.TURNOVER)  AS P_TURNOVER,
              PERCENT_RANK() OVER (PARTITION BY b.CATALOGID ORDER BY b.UNITS)     AS P_UNITS,
              PERCENT_RANK() OVER (PARTITION BY b.CATALOGID ORDER BY b.CART_ADDS) AS P_CART,
              PERCENT_RANK() OVER (PARTITION BY b.CATALOGID ORDER BY b.MARGIN)    AS P_MARGIN,
              b.HAS_IMAGE,
              b.HAS_DESCR,
              b.FLG_PROMO_NEW,
              b.IN_STOCK,
              b.RATING_SCORE,
              b.NOISE
          FROM (
              SELECT
                  ci.CATALOGID,
                  cg.GOODSID,
                  CONVERT_AMOUNT(gp.PRICE1, gp.CURRENCY1ID, 498)      AS PRICE,
                  COALESCE(sl.TURNOVER, 0)                            AS TURNOVER,
                  COALESCE(sl.UNITS, 0)                               AS UNITS,
                  COALESCE(ct.ADDS, 0)                                AS CART_ADDS,
                  /* marja procentuala; fara vinzari nu avem informatie -> 0.
                     CAST-ul la DOUBLE e obligatoriu: impartirea intre doua
                     NUMERIC in Firebird pastreaza scale-ul mic si trunchiaza
                     rezultatul (0.9 in loc de 0.949). */
                  CASE WHEN COALESCE(sl.TURNOVER, 0) > 0
                       THEN CAST(COALESCE(sl.PROFIT, 0) AS DOUBLE PRECISION)
                            / sl.TURNOVER
                       ELSE 0 END                                     AS MARGIN,
                  IIF(EXISTS(SELECT 1 FROM TS_GOODS_IMAGE gi
                             WHERE gi.GOODSID = cg.GOODSID), 1, 0)    AS HAS_IMAGE,
                  IIF(EXISTS(SELECT 1 FROM TS_GOODS_DESCRIPTIONS gd
                             WHERE gd.GOODSID = cg.GOODSID)
                      OR EXISTS(SELECT 1 FROM TS_GOODS_DSC gs
                                WHERE gs.GOODSID = cg.GOODSID
                                  AND gs.DESCRIPTION IS NOT NULL), 1, 0) AS HAS_DESCR,
                  IIF(COALESCE(cg.FLG_PROMO, 0) = 1
                      OR COALESCE(cg.FLG_NEW, 0) = 1, 1, 0)           AS FLG_PROMO_NEW,
                  IIF(EXISTS(SELECT 1 FROM TS_GOODS_STOCK st
                             WHERE st.GOODSID = cg.GOODSID
                               AND st.QTY > 0), 1, 0)                 AS IN_STOCK,
                  /* medie bayesiana, prior 3.8 cu greutatea a 5 recenzii */
                  CASE WHEN COALESCE(ra.REVIEW_COUNT, 0) > 0
                       THEN CAST(ra.RATING_VALUE * ra.REVIEW_COUNT + 19
                                 AS DOUBLE PRECISION)
                            / (ra.REVIEW_COUNT + 5) / 5
                       ELSE 0 END                                     AS RATING_SCORE,
                  /* zgomot determinist 0..1 - acelasi la fiecare recalculare */
                  CAST(MOD(CAST(cg.GOODSID AS BIGINT) * 7919, 1000)
                       AS DOUBLE PRECISION) / 1000                    AS NOISE
              FROM TWEB_CATALOG_ITEMS ci
              JOIN TWEB_CACHE_GOODS cg ON cg.PARENTID = ci.GOODSPARENTID
              JOIN TS_GOODS_PRICE gp   ON gp.GOODSID  = cg.GOODSID
              LEFT JOIN (
                  SELECT j.GOODSID,
                         SUM(j.SUMA)            AS TURNOVER,
                         SUM(j.QTY)             AS UNITS,
                         SUM(j.SUMA - j.COST)   AS PROFIT
                  FROM TDB_JURNAL j
                  JOIN TDB_DOCS d ON d.DOCID = j.DOCID
                  WHERE d.DOCTYPEID IN (107, 112, 134, 115, 3425)
                    AND d.DATA >= CURRENT_DATE - 180
                    AND d.DELETED_DATE IS NULL
                  GROUP BY j.GOODSID
              ) sl ON sl.GOODSID = cg.GOODSID
              LEFT JOIN (
                  SELECT GOODSID, COUNT(*) AS ADDS
                  FROM TWEB_SHOP_CART
                  WHERE CREATED_DATE >= CURRENT_DATE - 365
                  GROUP BY GOODSID
              ) ct ON ct.GOODSID = cg.GOODSID
              LEFT JOIN VW_GOODS_RATING_AGGREGATE ra ON ra.GOODSID = cg.GOODSID
              WHERE GET_FLG_VALUE(ci.FLAGS, 1) = 0
                AND cg.GOODSID > 0
          ) b
      ) n
  ) s;

  SELECT COUNT(*) FROM TWEB_GOODS_RANK INTO :ROWS_WRITTEN;
  SUSPEND;
END^

SET TERM ; ^

/* ============================================================================
   DUPA RULARE
   -----------
   1) Prima populare a tabelei (dureaza cateva minute pe ~46.000 produse):

          EXECUTE PROCEDURE WEB_CALC_GOODS_RANK;
          COMMIT;

   2) Verificare rapida - primele 12 pozitii dintr-o categorie trebuie sa
      alterneze treptele de pret 2, 3, 1, 2, 3, 1, ...

          SELECT FIRST 12 RANK_NO, PRICE_TIER, GOODSID, SCORE
          FROM TWEB_GOODS_RANK
          WHERE CATALOGID = <id categorie L3>
          ORDER BY RANK_NO;

   3) Programarea recalcularii nocturne se face din SWNServiceManager:
      task nou de tip StoredProcedure = WEB_CALC_GOODS_RANK,
      CalendarTarget zilnic, RunMode trmExactTime (ex. 04:00).

   4) Sortarea propriu-zisa a catalogului se schimba prin scriptul separat
      tweb_goods_rank_sorting.sql (modifica GET_GOODS_LIST_BY_CATALOG_F si
      GET_GOODS_LIST_BY_CATALOG_V2). Ruleaza-l DUPA acest script si dupa
      prima populare a tabelei.
   ============================================================================ */

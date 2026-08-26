/* ------------------------------------------------------------------------
   Stergerea imaginilor produselor Ultra.md (furnizor 202294)
   ------------------------------------------------------------------------

   Masurat pe SW la 22.08.2026:

     52.566  produse Ultra au imagini in TS_GOODS_IMAGE
    230.264  imagini in total
     11.497  dintre produse sunt legate SI de alt furnizor (imaginile lor pot
             sa nu fi venit de la Ultra)
      9.917  sunt singurele pe care formularul 111 le poate reimporta, fiindca
             interogarea lui cere GET_FLG_VALUE(gf.FLAGS, 3) = 1 (in pricelist)

   ATENTIE: daca stergi toate cele 52.566, aproximativ 42.600 de produse raman
   FARA imagini definitiv - formularul 111 nu le va lua inapoi, pentru ca nu
   sunt in pricelist. Varianta sigura este sectiunea B.
   ------------------------------------------------------------------------ */


/* ========================================================================
   1. SELECT de verificare - ce si cat se sterge (rulabil oricand, read-only)
   ======================================================================== */

/* 1a. Totalurile pe cele trei variante */
SELECT
    (SELECT COUNT(*) FROM TS_GOODS_IMAGE gi
      WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
                   WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294)
    ) AS IMAGINI_VARIANTA_A_TOATE,
    (SELECT COUNT(*) FROM TS_GOODS_IMAGE gi
      WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
                   WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294
                     AND GET_FLG_VALUE(gf.FLAGS, 3) = 1)
    ) AS IMAGINI_VARIANTA_B_REIMPORTABILE,
    (SELECT COUNT(*) FROM TS_GOODS_IMAGE gi
      WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
                   WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294)
        AND NOT EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN g2
                       WHERE g2.GOODSID = gi.GOODSID AND g2.CUSTOMERID <> 202294)
    ) AS IMAGINI_VARIANTA_C_DOAR_ULTRA
FROM RDB$DATABASE;

/* 1b. Lista produselor vizate (primele 100), ca sa vezi concret ce se atinge */
SELECT FIRST 100
       gf.GOODSID,
       gf.GOODS_CODE,
       g.TITLE,
       (SELECT COUNT(*) FROM TS_GOODS_IMAGE gi WHERE gi.GOODSID = gf.GOODSID) AS NR_IMAGINI,
       GET_FLG_VALUE(gf.FLAGS, 3) AS IN_PRICELIST
FROM TS_GOODS_FOREIGN gf
JOIN TS_GOODS g ON g.GOODSID = gf.GOODSID
WHERE gf.CUSTOMERID = 202294
  AND EXISTS(SELECT 1 FROM TS_GOODS_IMAGE gi WHERE gi.GOODSID = gf.GOODSID)
ORDER BY gf.GOODSID;


/* ========================================================================
   2. DELETE - alege O SINGURA varianta
   ========================================================================

   Nu rula nimic din sectiunea asta fara sa fi rulat intai 1a: sunt date de
   productie si nu exista undo. Dupa stergere, imaginile se recupereaza doar
   reimportand din formularul 111 (Ultra.md), ceea ce dureaza ore.

   Cache-ul TWEB_CACHE_GOODS_IMAGE se curata singur prin triggerul
   TS_GOODS_IMAGE_AIUD. Cache-ul Yii (cheile SpWebGoodsImageGet_*) expira
   singur, dar poate fi golit manual pentru efect imediat. */


/* --- VARIANTA A: chiar TOATE imaginile produselor Ultra (52.566 produse) ---
   Foloseste-o doar daca chiar vrei sa golesti tot, stiind ca ~42.600 produse
   raman fara imagini pana cand cineva le reimporta din alta sursa. */

-- DELETE FROM TS_GOODS_IMAGE gi
--  WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
--               WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294);
-- COMMIT;


/* --- VARIANTA B (RECOMANDATA): doar produsele pe care formularul 111 le poate
   aduce inapoi - cele din pricelist (9.917 produse).
   Asta este si varianta folosita pentru corectarea ORDERNO; pe portii se
   gaseste in reimport_ultra_images_order.sql. */

-- DELETE FROM TS_GOODS_IMAGE gi
--  WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
--               WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294
--                 AND GET_FLG_VALUE(gf.FLAGS, 3) = 1);
-- COMMIT;


/* --- VARIANTA C: toate produsele Ultra, dar fara cele care apartin SI altui
   furnizor (11.497 produse excluse). Utila daca vrei sa nu atingi imagini care
   probabil nu au venit de la Ultra. */

-- DELETE FROM TS_GOODS_IMAGE gi
--  WHERE EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN gf
--               WHERE gf.GOODSID = gi.GOODSID AND gf.CUSTOMERID = 202294)
--    AND NOT EXISTS(SELECT 1 FROM TS_GOODS_FOREIGN g2
--                   WHERE g2.GOODSID = gi.GOODSID AND g2.CUSTOMERID <> 202294);
-- COMMIT;

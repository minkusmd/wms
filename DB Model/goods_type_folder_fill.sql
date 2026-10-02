/* ------------------------------------------------------------------------
   TS_GOODS_TYPE.GOODS_FOLDERID - completare dupa produse (1 oct 2026)

   Regula: pentru fiecare tip de produs (TS_GOODS_TYPE.GOODSTYPEID =
   TS_GOODS.WEBGOODSTYPE_ID) se numara produsele pe folderul in care se afla
   (TS_GOODS.PARENTID, doar parinti cu FLG_FOLDER = 1); folderul cu cele mai
   multe produse devine GOODS_FOLDERID. La egalitate castiga folderul cu cel
   mai nou produs (MAX(GOODSID)).

   Se completeaza DOAR tipurile cu GOODS_FOLDERID IS NULL - valorile puse
   manual raman neatinse; scriptul poate fi rulat repetat.
   Stare SW la 1 oct 2026: 3126 tipuri, 11 cu folder; scriptul completeaza
   3035, raman 80 fara produse (NULL).

   Triggerul TS_GOODS_TYPE_AU apeleaza UPDATE_GOODS_DICTIONARY pentru fiecare
   produs al tipului la orice UPDATE (~307 000 apeluri aici), iar procedura nu
   foloseste GOODS_FOLDERID - de aceea e dezactivat pe durata UPDATE-ului.

   Revenire (daca e nevoie): UPDATE TS_GOODS_TYPE SET GOODS_FOLDERID = NULL
   WHERE GOODSTYPEID NOT IN (330, 481, 2151, 2202, 2235, 2841, 3718, 3730,
                             3760, 3798, 3801);
   (cele 11 tipuri care aveau folder inainte de script)
   ------------------------------------------------------------------------ */

ALTER TRIGGER TS_GOODS_TYPE_AU INACTIVE;
COMMIT;

UPDATE TS_GOODS_TYPE GT
SET GT.GOODS_FOLDERID = (
    SELECT FIRST 1 G.PARENTID
    FROM TS_GOODS G
    JOIN TS_GOODS P ON P.GOODSID = G.PARENTID AND P.FLG_FOLDER = 1
    WHERE G.WEBGOODSTYPE_ID = GT.GOODSTYPEID
      AND COALESCE(G.FLG_FOLDER, 0) = 0
    GROUP BY G.PARENTID
    ORDER BY COUNT(*) DESC, MAX(G.GOODSID) DESC)
WHERE GT.GOODS_FOLDERID IS NULL
  AND EXISTS (
    SELECT 1
    FROM TS_GOODS G
    JOIN TS_GOODS P ON P.GOODSID = G.PARENTID AND P.FLG_FOLDER = 1
    WHERE G.WEBGOODSTYPE_ID = GT.GOODSTYPEID
      AND COALESCE(G.FLG_FOLDER, 0) = 0);
COMMIT;

ALTER TRIGGER TS_GOODS_TYPE_AU ACTIVE;
COMMIT;

/* Tipul 3718 "Micro inverter" avea manual folderul 320158, unde nu are niciun
   produs; dupa regula e 390596 (2 produse). Aliniat la cererea userului. */
UPDATE TS_GOODS_TYPE SET GOODS_FOLDERID = 390596 WHERE GOODSTYPEID = 3718;
COMMIT;

/* Verificare:
SELECT COUNT(*) TOTAL, COUNT(GOODS_FOLDERID) WITH_FOLDER FROM TS_GOODS_TYPE;
*/

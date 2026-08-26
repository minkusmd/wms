/* ------------------------------------------------------------------------
   Imagini Ultra.md (furnizor 202294): index lipsa + reimport pentru ORDERNO
   ------------------------------------------------------------------------

   Context
   -------
   Frame-ul 111 (frame111UltraUnit.pas) citea imaginile din TAPI_ULTRA_IMAGES
   cu "select * ... where goods_uuid = :uuid", fara ORDER BY. Tabela nu are
   nicio coloana de ordine si nici macar un index, deci randurile veneau in
   ordinea fizica din baza, adica amestecate. Trigger-ul TRG_TS_GOODS_IMAGE_BI0
   atribuie ORDERNO = MAX+1 la fiecare insert, iar SP_WEB_GET_GOODS_IMAGE si
   catalogul iau imaginea principala dupa cel mai mic ORDERNO - asa ca imaginea
   principala ajungea sa fie una aleatorie (a 2-a, a 3-a etc.).

   Codul e corectat (imaginile se sorteaza dupa numarul din numele fisierului,
   "<cod>_<nr>.<ext>", si se pastreaza o singura varianta de format per numar),
   dar produsele importate INAINTE de corectura au deja ORDERNO gresit in
   TS_GOODS_IMAGE. Blob-urile salvate nu pastreaza numele fisierului sursa,
   deci ORDERNO nu poate fi recalculat - singura reparatie este reimportul.
   ------------------------------------------------------------------------ */


/* === 1. Index pe TAPI_ULTRA_IMAGES (recomandat, independent de reimport) ===

   TAPI_ULTRA_IMAGES (~331.000 randuri) nu are niciun index, deci fiecare
   "where goods_uuid = :uuid" din formular face scan complet. Indexul
   accelereaza atat importul de imagini, cat si scriptul de mai jos.
   Blocul e re-rulabil. */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$INDICES
                   WHERE RDB$INDEX_NAME = 'TAPI_ULTRA_IMAGES_IDX1')) THEN
        EXECUTE STATEMENT
            'CREATE INDEX TAPI_ULTRA_IMAGES_IDX1 ON TAPI_ULTRA_IMAGES (GOODS_UUID)';
END^

SET TERM ; ^

COMMIT;


/* === 2. Reimportul produselor cu ORDERNO gresit ===========================

   Procedura
   ---------
   a) rulezi blocul DELETE de mai jos (o portie de produse);
   b) in WMS deschizi frame-ul Ultra.md (111) si apesi butonul de import -
      interogarea formularului ia exact produsele fara imagini si le reincarca
      in ordinea corecta;
   c) repeti (a) si (b) pana cand numaratoarea de la final da 0.

   ATENTIE
   -------
   - Este DML pe baza de productie: intre (a) si finalul lui (b) produsele din
     portie raman FARA imagini pe site. De aceea se lucreaza pe portii si, de
     preferinta, in afara orelor de varf.
   - Volumul la 21.08.2026: cel mult 9.887 produse (masurat: produse Ultra din
     pricelist care au deja imagini in TS_GOODS_IMAGE si o intrare in
     TAPI_ULTRA_NOMENCLATURE). Reimportul descarca toate imaginile din nou de
     la CDN, deci dureaza ore.
   - Numarul exact (sectiunea 3) se poate obtine abia DUPA crearea indexului de
     la sectiunea 1: fara index interogarea depaseste 10 minute.
   - Se sterg doar produsele care (a) sunt legate de furnizorul 202294,
     (b) au flagul 3 (in pricelist) - adica exact filtrul formularului - si
     (c) au imagini disponibile in TAPI_ULTRA_IMAGES. Fara conditia (c) un
     produs ar ramane definitiv fara imagini.
   - Cache-ul web TWEB_CACHE_GOODS_IMAGE e intretinut de triggerul
     TS_GOODS_IMAGE_AIUD; cache-ul Yii pentru imagini (cheile
     SpWebGoodsImageGet_*) expira singur, dar poate fi golit manual pentru
     efect imediat.
   - Marimea portiei (FIRST 2000) se poate ajusta; DELETE-ul face un scan pe
     TS_GOODS_IMAGE, deci portiile prea mici inseamna mai multe scanari. */

DELETE FROM TS_GOODS_IMAGE
WHERE GOODSID IN (
    SELECT FIRST 2000 x.GOODSID FROM (
        SELECT gf.GOODSID
        FROM TS_GOODS_FOREIGN gf
        JOIN TAPI_ULTRA_NOMENCLATURE n ON n.CODE = gf.GOODS_CODE
        WHERE gf.CUSTOMERID = 202294
          AND GET_FLG_VALUE(gf.FLAGS, 3) = 1
          AND EXISTS(SELECT 1 FROM TAPI_ULTRA_IMAGES i WHERE i.GOODS_UUID = n.UUID)
          AND EXISTS(SELECT 1 FROM TS_GOODS_IMAGE g2 WHERE g2.GOODSID = gf.GOODSID)
        GROUP BY 1) x);

COMMIT;


/* === 3. Cate produse au mai ramas de reimportat =========================== */

SELECT COUNT(*) AS RAMASE FROM (
    SELECT gf.GOODSID
    FROM TS_GOODS_FOREIGN gf
    JOIN TAPI_ULTRA_NOMENCLATURE n ON n.CODE = gf.GOODS_CODE
    WHERE gf.CUSTOMERID = 202294
      AND GET_FLG_VALUE(gf.FLAGS, 3) = 1
      AND EXISTS(SELECT 1 FROM TAPI_ULTRA_IMAGES i WHERE i.GOODS_UUID = n.UUID)
      AND EXISTS(SELECT 1 FROM TS_GOODS_IMAGE g2 WHERE g2.GOODSID = gf.GOODSID)
    GROUP BY 1) y;

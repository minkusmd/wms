/* ------------------------------------------------------------------------
   TS_GOODS_IMAGE: chei duplicate (GOODSID, GOODS_IMAGE_ID) + REINDEX_GOODS_IMAGES
   ------------------------------------------------------------------------

   Simptom (6 oct 2026, frame78 - copierea continutului Dehome 261523 la produse):

     Multiple source records cannot match the same target during MERGE
     At procedure 'REINDEX_GOODS_IMAGES' line: 4, col: 3
     At trigger 'TS_GOODS_AD' line: 8, col: 3
     At trigger 'TS_GOODS_DSC_AI' line: 5, col: 5

   Cauza
   -----
   - PK_TS_GOODS_IMAGE (GOODSID, GOODS_IMAGE_ID) este inactiv (RDB$INDEX_INACTIVE = 3),
     deci unicitatea nu e impusa. Pe SW sint 23 de chei duplicate (1009 rinduri):
       * 19 produse Dehome cu 8..120 de copii ale ACELEIASI imagini, toate cu
         GOODS_IMAGE_ID = 1, inserate de o singura instructiune la 08.09.2026 08:31:21;
       * 4 produse vechi (199625, 204680, 241150, 281133) cu doua imagini DIFERITE
         pe acelasi GOODS_IMAGE_ID.
   - TS_GOODS_AD este de fapt AFTER UPDATE OR DELETE pe TS_GOODS si cheama
     REINDEX_GOODS_IMAGES la ORICE update al produsului (pret, denumire,
     CONTENT_MODIFIED pus de TS_GOODS_DSC_AI etc.).
   - MERGE-ul din procedura leaga tinta de sursa dupa (GOODSID, GOODS_IMAGE_ID);
     la o cheie duplicata un rind-tinta se potriveste cu mai multe rinduri-sursa
     si Firebird 5 arunca eroarea. Efect: la aceste 23 de produse pica orice
     UPDATE pe TS_GOODS, nu doar copierea descrierii.

   Ce face scriptul (re-rulabil)
   -----------------------------
   1. REINDEX_GOODS_IMAGES leaga rindurile dupa RDB$DB_KEY - nu mai poate da
      eroarea, iar o cheie duplicata se repara singura la urmatorul apel.
   2. Sterge copiile identice (acelasi GOODSID + GOODS_IMAGE_ID + IMAGE_HASH +
      lungime), pastrind rindul cu cel mai mic ORDERNO.
   3. Renumeroteaza GOODS_IMAGE_ID la produsele ramase cu chei duplicate
      (imagini diferite pe acelasi numar) - nu se sterge nimic.
   4. Verificare: trebuie sa intoarca 0. Daca nu e 0 (o alta conexiune tinea
      inca vechea versiune a procedurii), scriptul se ruleaza inca o data.

   TWEB_CACHE_GOODS_IMAGE: trigger-ul TS_GOODS_IMAGE_AIUD o intretine dupa
   (GOODSID, IMAGEID), deci la o cheie duplicata rindurile ei nu pot fi corecte
   (si dupa renumerotarea de la pasul 3 pot lipsi). Tabela nu e citita de nimic:
   in RDB$DEPENDENCIES apar doar trigger-ele care scriu in ea, iar in WMS si in
   fantastic.web nu exista nicio referinta (verificat 6 oct 2026).

   Copiile sterse ocupa ~470 MB de BLOB-uri; spatiul devine refolosibil in fisierul bazei.
   ------------------------------------------------------------------------ */


/* === 1. REINDEX_GOODS_IMAGES fara potrivire dupa cheia duplicabila =========

   t.GOODSID = s.GOODSID ramine in conditie ca tinta sa fie citita prin indexul
   FK_TS_GOODS_IMAGE_1 (ca si pina acum), nu prin scan complet. */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE REINDEX_GOODS_IMAGES (GOODSID DM_INTEGER)
AS
BEGIN
  MERGE INTO TS_GOODS_IMAGE t
  USING (
    SELECT
        GOODSID,
        RDB$DB_KEY AS DBK,
        GOODS_IMAGE_ID AS OLD_ID,
        ROW_NUMBER() OVER (PARTITION BY GOODSID
                           ORDER BY GOODS_IMAGE_ID, ORDERNO, CREATED_DATE) AS NEW_ID
    FROM TS_GOODS_IMAGE
    where goodsid = :goodsid
  ) s
  ON (t.GOODSID = s.GOODSID AND t.RDB$DB_KEY = s.DBK)
  WHEN MATCHED AND (s.OLD_ID IS DISTINCT FROM s.NEW_ID) THEN
    UPDATE SET t.GOODS_IMAGE_ID = s.NEW_ID, flg_need2recreate = 1;
END^

SET TERM ; ^

COMMIT;


/* === 2. Copiile identice ale aceleiasi imagini =============================

   Se sterg doar rindurile care au, in acelasi produs si pe acelasi
   GOODS_IMAGE_ID, un rind cu aceeasi imagine si ORDERNO mai mic (la egalitate -
   RDB$DB_KEY mai mic). Rindul cu ORDERNO minim nu se sterge niciodata.

   Trigger-ul TS_GOODS_IMAGE_AIUD scoate la DELETE rindul (GOODSID, IMAGEID) din
   TWEB_CACHE_GOODS_IMAGE, inclusiv pe cel al imaginii pastrate - de aceea
   rindul ramas e atins la final (UPDATE fara schimbare), ceea ce il pune la loc. */

SET TERM ^ ;

EXECUTE BLOCK RETURNS (GOODSID INTEGER, GOODS_IMAGE_ID INTEGER, STERSE INTEGER, RAMASE INTEGER)
AS
BEGIN
  FOR SELECT GOODSID, GOODS_IMAGE_ID
      FROM TS_GOODS_IMAGE
      GROUP BY GOODSID, GOODS_IMAGE_ID
      HAVING COUNT(*) > 1
      INTO :GOODSID, :GOODS_IMAGE_ID
  DO
  BEGIN
    DELETE FROM TS_GOODS_IMAGE d
    WHERE d.GOODSID = :GOODSID AND d.GOODS_IMAGE_ID = :GOODS_IMAGE_ID
      AND EXISTS(SELECT 1 FROM TS_GOODS_IMAGE k
                 WHERE k.GOODSID = d.GOODSID
                   AND k.GOODS_IMAGE_ID = d.GOODS_IMAGE_ID
                   AND k.IMAGE_HASH = d.IMAGE_HASH
                   AND OCTET_LENGTH(k.IMAGE) = OCTET_LENGTH(d.IMAGE)
                   AND (COALESCE(k.ORDERNO, 0) < COALESCE(d.ORDERNO, 0)
                        OR (COALESCE(k.ORDERNO, 0) = COALESCE(d.ORDERNO, 0)
                            AND k.RDB$DB_KEY < d.RDB$DB_KEY)));
    STERSE = ROW_COUNT;

    IF (STERSE > 0) THEN
      UPDATE TS_GOODS_IMAGE SET FLAGS = FLAGS
      WHERE GOODSID = :GOODSID AND GOODS_IMAGE_ID = :GOODS_IMAGE_ID;

    SELECT COUNT(*) FROM TS_GOODS_IMAGE
    WHERE GOODSID = :GOODSID AND GOODS_IMAGE_ID = :GOODS_IMAGE_ID
    INTO :RAMASE;

    SUSPEND;
  END
END^

SET TERM ; ^

COMMIT;


/* === 3. Imagini diferite pe acelasi GOODS_IMAGE_ID: renumerotare =========== */

SET TERM ^ ;

EXECUTE BLOCK RETURNS (GOODSID INTEGER, IMAGINI INTEGER)
AS
BEGIN
  FOR SELECT DISTINCT GOODSID
      FROM (SELECT GOODSID FROM TS_GOODS_IMAGE
            GROUP BY GOODSID, GOODS_IMAGE_ID
            HAVING COUNT(*) > 1)
      INTO :GOODSID
  DO
  BEGIN
    EXECUTE PROCEDURE REINDEX_GOODS_IMAGES(:GOODSID);

    SELECT COUNT(*) FROM TS_GOODS_IMAGE WHERE GOODSID = :GOODSID INTO :IMAGINI;
    SUSPEND;
  END
END^

SET TERM ; ^

COMMIT;


/* === 4. Verificare: trebuie sa fie 0 ======================================= */

SELECT COUNT(*) AS CHEI_DUPLICATE FROM (
    SELECT GOODSID FROM TS_GOODS_IMAGE
    GROUP BY GOODSID, GOODS_IMAGE_ID
    HAVING COUNT(*) > 1) x;


/* === 5. Optional (DBA): reactivarea cheii primare ==========================

   Dupa pasul 4 = 0 indexul poate fi reactivat, ca dublurile sa nu mai poata
   aparea:

       ALTER INDEX PK_TS_GOODS_IMAGE ACTIVE;

   De cintarit inainte: REINDEX_GOODS_IMAGES renumeroteaza pe loc (ex. 1,3,4 ->
   1,2,3) si cu indexul unic activ ordinea de prelucrare a rindurilor conteaza;
   daca MERGE-ul ar muta 4 -> 3 inaintea lui 3 -> 2, ar da incalcare de cheie la
   orice UPDATE al produsului. Ordinea vine din sortarea ferestrei (crescator
   dupa GOODS_IMAGE_ID), dar nu e garantata de motor - de testat pe o copie. */

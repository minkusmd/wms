/* Promo pe grupe definite doar prin excluderi ("tot, cu exceptia...").
   Simptom 24.09.2026: FANTAMAS (GG_ID 63, 3%) dadea "Cod promo invalid" la orice cos.
   Se ruleaza pe SW; daca ALTER da "object in use", restart php-fpm si rulare imediata
   (conexiunile persistente tin procedurile deschise). */

SET TERM ^ ;

ALTER PROCEDURE SP_MK_GET_SHOPCART_GG_BY_USER (
    CUSTOMERID DM_VARCHAR60,
    GG_ID DM_INTEGER)
RETURNS (
    GOODSID DM_INTEGER)
AS
declare variable tmpGOODSID DM_INTEGER;
declare variable tmpGOODSID2 DM_INTEGER;
declare variable tmpFLG_FOLDER DM_BOOLEAN;
declare goodstype_cnt int;
declare vendor_cnt int;
BEGIN
     /* 23.06.2014 - JOHN */
     /* MARKETING - ACTIUNI */
     /* Intoarce lista de produse din Grupa de produse (GG_ID) join cu cos */
     /* Daca nu este indicata grupa de produse, intoarcem produsele din cos */
     IF(GG_ID IS NULL) THEN
     BEGIN
          FOR
             SELECT DISTINCT GOODSID FROM TWEB_SHOP_CART s WHERE s.customerid = :customerid INTO :GOODSID
          DO
            SUSPEND;
     END

     DELETE FROM TMP_GOODS;
     /* 24.09.2026: grupa definita DOAR prin excluderi (ex. promo FANTAMAS, GG_ID 63:
        "tot, cu exceptia tipurilor 31/474/8/9"). Fara nicio regula de includere setul
        de pornire era gol, excluderile nu aveau ce scoate, iar reducerea iesea 0 -
        pe site "Cod promo invalid". Pornim atunci de la tot cosul; excluderile de
        mai jos se aplica neschimbat. O grupa fara nicio regula ramine goala. */
     IF (NOT EXISTS (SELECT 1 FROM MK_GG_GOODS   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND NOT EXISTS (SELECT 1 FROM MK_GG_TYPES   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND NOT EXISTS (SELECT 1 FROM MK_GG_VENDORS X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND (EXISTS (SELECT 1 FROM MK_GG_GOODS   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1)
              OR EXISTS (SELECT 1 FROM MK_GG_TYPES   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1)
              OR EXISTS (SELECT 1 FROM MK_GG_VENDORS X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1))) THEN
       INSERT INTO TMP_GOODS (GOODSID)
       SELECT DISTINCT C.GOODSID FROM TWEB_SHOP_CART C WHERE C.CUSTOMERID = :CUSTOMERID;

     /* A - Include -> adaugam produsele */
     /* 1. MK_GG_GOODS - mapele cu produse sau produsele */
     /* 1.A include */
     FOR
        SELECT GGG.GOODSID, G.FLG_FOLDER FROM MK_GG_GOODS GGG
        INNER JOIN TS_GOODS G ON G.GOODSID=GGG.GOODSID
        WHERE (GGG.GG_ID = :GG_ID) AND (GGG.FLG_EXCLUDE=0)
        INTO :tmpGOODSID, :tmpFLG_FOLDER
     DO
       BEGIN
            IF (tmpFLG_FOLDER=1) THEN
            BEGIN
                 /* adaugam toate produsele din mapa */
                 INSERT INTO TMP_GOODS (GOODSID)
                 SELECT A.GOODSID
                 FROM sp_get_goods_from_folders(:tmpGOODSID) A
                 INNER JOIN tweb_shop_cart J ON J.customerid=:customerid AND J.GOODSID=A.GOODSID;
            END
            ELSE
            BEGIN
                 /* adaugam doar produsul ales */
                 INSERT INTO TMP_GOODS (GOODSID)
                 SELECT GOODSID
                 FROM tweb_shop_cart
                 WHERE customerid = :customerid AND GOODSID=:tmpGOODSID;
            END
       END

     /* 2. MK_GG_TYPES - tipurile de produse */
     /* adaugam toate produsele conform tipului de produse sau update la cele curente din lista de produse indicate separat */
     select count(*) from mk_gg_types ggt where ggt.gg_id = :gg_id into :goodstype_cnt;
     if (:goodstype_cnt>0) then begin
        for SELECT J.GOODSID
            FROM tweb_shop_cart J
            INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
            INNER JOIN MK_GG_TYPES GGT ON GGT.GG_ID = :GG_ID AND GGT.GOODSTYPEID = G.WEBGOODSTYPE_ID AND GGT.FLG_EXCLUDE=0
            WHERE J.customerid = :customerid into :goodsid do
        begin
                UPDATE OR INSERT INTO TMP_GOODS (GOODSID)
                VALUES (:GOODSID)
                MATCHING (GOODSID);
        end
     end

     /* 3. MK_GG_VENDORS - producatorii de produse */
     select count(*) from mk_gg_vendors ggv where gg_id = :gg_id into :vendor_cnt;
     if (:vendor_cnt>0) then
     begin
            /* adaugam toate produsele din cos cu brandul indicat in promotie */
            /* in cazul din este indicat doar VendorID pentru promotia data */

        merge into tmp_goods t
         using (select distinct j.goodsid from tweb_shop_cart j
             inner join ts_goods g on g.goodsid = j.goodsid
             inner join mk_gg_vendors ggv on ggv.gg_id = :gg_id and ggv.vendorid = g.vendor_id and ggv.flg_exclude=0
             where j.customerid=:customerid) as z
         on (t.goodsid = z.goodsid)
         when not matched then insert (goodsid) values(z.goodsid);

        merge into tmp_goods t
         using (select distinct j.goodsid from tweb_shop_cart j
             inner join ts_goods g on g.goodsid = j.goodsid
             inner join mk_gg_vendors ggv on ggv.gg_id = :gg_id and ggv.vendorid = g.vendor_id and ggv.flg_exclude=1
             where j.customerid=:customerid) as z
         on (t.goodsid = z.goodsid)
         when matched then delete;



--         insert into tmp_goods (goodsid)
--         select j.goodsid
--         from tweb_shop_cart j
--         inner join ts_goods g on g.goodsid = j.goodsid
--         inner join mk_gg_vendors ggv on ggv.gg_id = :gg_id and ggv.vendorid = g.vendor_id and ggv.flg_exclude=0
--         where j.customerid=:customerid;


--         delete from tmp_goods t
--         where not exists (
--             SELECT J.GOODSID
--             FROM tweb_shop_cart J
--             INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
--             INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=1
--             WHERE J.customerid=:customerid
--             );
     end

     /* B - Exclude -> scoatem produsele */
     /* MK_GG_GOODS - Exclude */
     FOR
        SELECT GGG.GOODSID, G.FLG_FOLDER
        FROM MK_GG_GOODS GGG
        INNER JOIN TS_GOODS G ON G.GOODSID=GGG.GOODSID
        WHERE (GGG.GG_ID = :GG_ID) AND (GGG.FLG_EXCLUDE=1)
        INTO :tmpGOODSID, :tmpFLG_FOLDER
     DO
       BEGIN
            IF (tmpFLG_FOLDER=1) THEN
            BEGIN
                 FOR
                    SELECT GOODSID
                    FROM sp_get_goods_from_folders(:tmpGOODSID) A
                    INTO :tmpGOODSID2
                 DO
                   DELETE FROM TMP_GOODS WHERE GOODSID = :tmpGOODSID2;
            END
            ELSE
            BEGIN
                 DELETE FROM TMP_GOODS WHERE GOODSID = :tmpGOODSID;
            END
       END

     /* MK_GG_TYPES - Exclude tipurile de produse */
     DELETE FROM TMP_GOODS WHERE exists
     (SELECT J.GOODSID
      FROM tweb_shop_cart J
      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
      INNER JOIN MK_GG_TYPES GGT ON GGT.GG_ID = :GG_ID AND GGT.GOODSTYPEID = G.WEBGOODSTYPE_ID AND GGT.FLG_EXCLUDE=1
      WHERE J.customerid = :customerid and j.goodsid = tmp_goods.goodsid
     );

     /* 3. MK_GG_VENDORS Exclude producatorii de produse */
--     DELETE FROM TMP_GOODS TG WHERE GOODSID IN
--     (SELECT J.GOODSID
--      FROM TDB_JURNAL J
--      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
--      INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=1
--      WHERE J.DOCID=:DOCID
--     );


       /* OPTIMIZAT 22/09/2019  - Sergiu*/
     DELETE FROM TMP_GOODS TG
     WHERE EXISTS (
      SELECT J.GOODSID
      FROM tweb_shop_cart J
      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
      INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=1
      WHERE J.customerid = :customerid and G.GOODSID=TG.GOODSID);


     /* intoarcem datele */
     FOR
        SELECT DISTINCT GOODSID FROM TMP_GOODS INTO :GOODSID
     DO 
        SUSPEND;

END^

ALTER PROCEDURE SP_MK_GET_SHOPCART_GROUP_GOODS (
    SHOP_CART_ID DM_VARCHAR60,
    GG_ID DM_INTEGER)
RETURNS (
    GOODSID DM_INTEGER)
AS
declare variable tmpGOODSID DM_INTEGER;
declare variable tmpGOODSID2 DM_INTEGER;
declare variable tmpFLG_FOLDER DM_BOOLEAN;
declare goodstype_cnt int;
declare vendor_cnt int;
BEGIN
     /* 23.06.2014 - JOHN */
     /* MARKETING - ACTIUNI */
     /* Intoarce lista de produse din Grupa de produse (GG_ID) join cu cos */

     /* Daca nu este indicata grupa de produse, intoarcem produsele din cos */
     IF(GG_ID IS NULL) THEN
     BEGIN
          FOR
             SELECT DISTINCT GOODSID
             FROM TWEB_SHOP_CART s
             WHERE s.shop_cart_id = :shop_cart_id
             INTO :GOODSID
          DO
            SUSPEND;
     END

     DELETE FROM TMP_GOODS;
     /* 24.09.2026: grupa definita DOAR prin excluderi (ex. promo FANTAMAS, GG_ID 63:
        "tot, cu exceptia tipurilor 31/474/8/9"). Fara nicio regula de includere setul
        de pornire era gol, excluderile nu aveau ce scoate, iar reducerea iesea 0 -
        pe site "Cod promo invalid". Pornim atunci de la tot cosul; excluderile de
        mai jos se aplica neschimbat. O grupa fara nicio regula ramine goala. */
     IF (NOT EXISTS (SELECT 1 FROM MK_GG_GOODS   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND NOT EXISTS (SELECT 1 FROM MK_GG_TYPES   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND NOT EXISTS (SELECT 1 FROM MK_GG_VENDORS X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 0)
         AND (EXISTS (SELECT 1 FROM MK_GG_GOODS   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1)
              OR EXISTS (SELECT 1 FROM MK_GG_TYPES   X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1)
              OR EXISTS (SELECT 1 FROM MK_GG_VENDORS X WHERE X.GG_ID = :GG_ID AND X.FLG_EXCLUDE = 1))) THEN
       INSERT INTO TMP_GOODS (GOODSID)
       SELECT DISTINCT C.GOODSID FROM TWEB_SHOP_CART C WHERE C.SHOP_CART_ID = :SHOP_CART_ID;

     /* A - Include -> adaugam produsele */
     /* 1. MK_GG_GOODS - mapele cu produse sau produsele */
     /* 1.A include */
     FOR
        SELECT GGG.GOODSID, G.FLG_FOLDER
        FROM MK_GG_GOODS GGG
        INNER JOIN TS_GOODS G ON G.GOODSID=GGG.GOODSID
        WHERE (GGG.GG_ID = :GG_ID) AND (GGG.FLG_EXCLUDE=0)
        INTO :tmpGOODSID, :tmpFLG_FOLDER
     DO
       BEGIN
            IF (tmpFLG_FOLDER=1) THEN
            BEGIN
                 INSERT INTO TMP_GOODS (GOODSID)
                 SELECT A.GOODSID
                 FROM sp_get_goods_from_folders(:tmpGOODSID) A
                 INNER JOIN tweb_shop_cart J ON J.shop_cart_id=:shop_cart_id AND J.GOODSID=A.GOODSID;
            END
            ELSE
            BEGIN
                 INSERT INTO TMP_GOODS (GOODSID)
                 SELECT GOODSID
                 FROM tweb_shop_cart
                 WHERE shop_cart_id=:shop_cart_id AND GOODSID=:tmpGOODSID;
            END
       END

     /* 2. MK_GG_TYPES - tipurile de produse */
     /* adaugam toate produsele conform tipului de produse sau update la cele curente din lista de produse indicate separat */
     select count(*) from mk_gg_types ggt where ggt.gg_id = :gg_id into :goodstype_cnt;
     if (:goodstype_cnt>0) then begin
        for SELECT J.GOODSID
            FROM tweb_shop_cart J
            INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
            INNER JOIN MK_GG_TYPES GGT ON GGT.GG_ID = :GG_ID AND GGT.GOODSTYPEID = G.WEBGOODSTYPE_ID AND GGT.FLG_EXCLUDE=0
            WHERE J.shop_cart_id=:shop_cart_id into :goodsid do
        begin
                UPDATE OR INSERT INTO TMP_GOODS (GOODSID)
                VALUES (:GOODSID)
                MATCHING (GOODSID);
        end
     end

     /* 3. MK_GG_VENDORS - producatorii de produse */
     select count(*) from mk_gg_vendors ggv where gg_id = :gg_id and ggv.flg_exclude = 0 into :vendor_cnt; /* 24.09.2026: doar regulile de includere */
     if (:vendor_cnt>0) then
     begin
         delete from tmp_goods t
         where not exists (
             SELECT J.GOODSID
             FROM tweb_shop_cart J
             INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
             INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=0
             WHERE J.shop_cart_id=:shop_cart_id
             );

--
--         INSERT INTO TMP_GOODS (GOODSID)
--         SELECT J.GOODSID
--         FROM tweb_shop_cart J
--         INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
--         INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=0
--         WHERE J.shop_cart_id=:shop_cart_id;
     end

     /* B - Exclude -> scoatem produsele */
     /* MK_GG_GOODS - Exclude */
     FOR
        SELECT GGG.GOODSID, G.FLG_FOLDER
        FROM MK_GG_GOODS GGG
        INNER JOIN TS_GOODS G ON G.GOODSID=GGG.GOODSID
        WHERE (GGG.GG_ID = :GG_ID) AND (GGG.FLG_EXCLUDE=1)
        INTO :tmpGOODSID, :tmpFLG_FOLDER
     DO
       BEGIN
            IF (tmpFLG_FOLDER=1) THEN
            BEGIN
                 FOR
                    SELECT GOODSID
                    FROM sp_get_goods_from_folders(:tmpGOODSID) A
                    INTO :tmpGOODSID2
                 DO
                   DELETE FROM TMP_GOODS WHERE GOODSID = :tmpGOODSID2;
            END
            ELSE
            BEGIN
                 DELETE FROM TMP_GOODS WHERE GOODSID = :tmpGOODSID;
            END
       END

     /* MK_GG_TYPES - Exclude tipurile de produse */
     DELETE FROM TMP_GOODS WHERE exists
     (SELECT J.GOODSID
      FROM tweb_shop_cart J
      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
      INNER JOIN MK_GG_TYPES GGT ON GGT.GG_ID = :GG_ID AND GGT.GOODSTYPEID = G.WEBGOODSTYPE_ID AND GGT.FLG_EXCLUDE=1
      WHERE J.shop_cart_id = :shop_cart_id and j.goodsid = tmp_goods.goodsid
     );

     /* 3. MK_GG_VENDORS Exclude producatorii de produse */
--     DELETE FROM TMP_GOODS TG WHERE GOODSID IN
--     (SELECT J.GOODSID
--      FROM TDB_JURNAL J
--      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
--      INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=1
--      WHERE J.DOCID=:DOCID
--     );


       /* OPTIMIZAT 22/09/2019  - Sergiu*/
     DELETE FROM TMP_GOODS TG
     WHERE EXISTS (
      SELECT J.GOODSID
      FROM tweb_shop_cart J
      INNER JOIN TS_GOODS G ON G.GOODSID = J.GOODSID
      INNER JOIN MK_GG_VENDORS GGV ON GGV.GG_ID = :GG_ID AND GGV.VENDORID = G.VENDOR_ID AND GGV.FLG_EXCLUDE=1
      WHERE J.shop_cart_id=:shop_cart_id and G.GOODSID=TG.GOODSID);


     /* intoarcem datele */
     FOR
        SELECT DISTINCT GOODSID FROM TMP_GOODS INTO :GOODSID
     DO 
        SUSPEND;

END^

SET TERM ; ^

COMMIT;

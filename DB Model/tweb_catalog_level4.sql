/* ============================================================================
   Nivelul 4 in catalogul web + tile-uri pe pagina categoriei

   Contine tot ce tine de baza de date pentru:
     1. SP_REBUILD_CATALOG_LEVEL    - recalculeaza TWEB_CATALOG.CATALOG_LEVEL
     2. TWEB_CATALOG_VIRTUAL_IMAGE  - imaginea unei mape virtuale (tile)
     3. TWEB_CATALOG_VIRTUAL.FLAGS  - bit 1 = FLG_TILE
     4. VW_TWEB_CATALOG_VIRTUAL     - view updatable pentru WMS (Delphi/IBDAC)
     5. WEB_GET_CATALOG_TREE4       - arborele de catalog pe 4 niveluri

   Context:
   - Adancimea vine din TWEB_CATALOG.PARENTID; NU se adauga coloane noi in
     TWEB_CATALOG. Nodurile-link folosesc FLG_GROUP_IS_LINK (FLAGS bit 9) +
     URL_RO / URL_RU, toate existente.
   - Indexul IDX_TWEB_CATALOG_PARENTID_DT (PARENTID, DT) exista deja - SP-ul
     nou face 4 bucle imbricate si depinde de el.
   - WEB_GET_CATALOG_TREE3_V2 ramane NEATINSA (fallback pentru site).
   - DB Model\tweb_catalog_virtual_flag.sql este CADUC: coloanele
     VIRTUAL_FILTERID / VIRTUAL_FILTERPARAMIDS nu au fost create niciodata,
     iar mapele virtuale traiesc in tabela TWEB_CATALOG_VIRTUAL
     (DDL initial: fantastic.web\docs\sql\tweb_catalog_virtual.sql).

   Script RE-RULABIL: se poate executa de mai multe ori fara efecte adverse.
   Se ruleaza ca SYSDBA.
   ============================================================================ */

SET TERM ^ ;

/* --- 1. SP_REBUILD_CATALOG_LEVEL ----------------------------------------
   TWEB_CATALOG.CATALOG_LEVEL este denormalizat si azi este stale (184 randuri
   NULL). Site-ul NU se bazeaza pe el - adancimea rezulta din pozitia in
   WEB_GET_CATALOG_TREE4. Coloana ramane doar pentru administrare/rapoarte.
   Se apeleaza din WMS dupa mutarea unui nod si dintr-o sarcina SWNService. */
CREATE OR ALTER PROCEDURE SP_REBUILD_CATALOG_LEVEL
RETURNS (UPDATED_COUNT DM_INTEGER)
AS
DECLARE VARIABLE CID DM_INTEGER;
DECLARE VARIABLE LVL DM_INTEGER;
BEGIN
    UPDATED_COUNT = 0;

    FOR WITH RECURSIVE TREE AS (
            SELECT CATALOGID, 1 AS LVL
            FROM TWEB_CATALOG
            WHERE PARENTID = 0
          UNION ALL
            SELECT C.CATALOGID, T.LVL + 1
            FROM TWEB_CATALOG C
            JOIN TREE T ON T.CATALOGID = C.PARENTID
        )
        SELECT CATALOGID, LVL FROM TREE
        INTO :CID, :LVL
    DO
    BEGIN
        /* CATALOG_LEVEL nu participa la recursie, deci update-ul din bucla
           nu afecteaza cursorul */
        UPDATE TWEB_CATALOG
           SET CATALOG_LEVEL = :LVL
         WHERE CATALOGID = :CID
           AND COALESCE(CATALOG_LEVEL, -1) <> :LVL;

        UPDATED_COUNT = UPDATED_COUNT + ROW_COUNT;
    END

    SUSPEND;
END^

SET TERM ; ^

/* Migrare initiala: coloana e stale pe bazele existente. Idempotent - la a
   doua rulare UPDATED_COUNT este 0. Nodul-santinela ROOT (CATALOGID = -1) se
   auto-referentiaza si ramane pe nivelul 0. */
EXECUTE PROCEDURE SP_REBUILD_CATALOG_LEVEL;

COMMIT;

SET TERM ^ ;

/* --- 2. TWEB_CATALOG_VIRTUAL (pentru baze unde inca nu exista) -----------
   Tabela a fost creata initial de DBA dupa
   fantastic.web\docs\sql\tweb_catalog_virtual.sql. Blocul de mai jos o
   recreeaza doar daca lipseste, ca scriptul sa fie autonom. */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TWEB_CATALOG_VIRTUAL')) THEN
    BEGIN
        EXECUTE STATEMENT
        'CREATE TABLE TWEB_CATALOG_VIRTUAL (
             ID                   INTEGER NOT NULL,
             CATALOGID            INTEGER NOT NULL,
             TITLE_ROM            VARCHAR(120) NOT NULL,
             TITLE_RUS            VARCHAR(120),
             H1_ROM               VARCHAR(250),
             H1_RUS               VARCHAR(250),
             REWRITE_URL          VARCHAR(120) NOT NULL,
             FILTERID             INTEGER NOT NULL,
             FILTERPARAMIDS       VARCHAR(200) NOT NULL,
             ORDERNO              INTEGER DEFAULT 0,
             FLAGS                INTEGER DEFAULT 1 NOT NULL,
             META_TITLE_ROM       VARCHAR(250),
             META_TITLE_RUS       VARCHAR(250),
             META_DESCRIPTION_ROM VARCHAR(500),
             META_DESCRIPTION_RUS VARCHAR(500),
             SEO_TEXT_ROM         BLOB SUB_TYPE TEXT,
             SEO_TEXT_RUS         BLOB SUB_TYPE TEXT,
             CONSTRAINT PK_TWEB_CATALOG_VIRTUAL PRIMARY KEY (ID)
         )';

        EXECUTE STATEMENT
        'CREATE UNIQUE INDEX UQ_TWEB_CAT_VIRT_SLUG ON TWEB_CATALOG_VIRTUAL (CATALOGID, REWRITE_URL)';
        EXECUTE STATEMENT
        'CREATE INDEX IDX_TWEB_CAT_VIRT_CATALOG ON TWEB_CATALOG_VIRTUAL (CATALOGID)';
    END

    IF (NOT EXISTS(SELECT 1 FROM RDB$GENERATORS
                   WHERE TRIM(RDB$GENERATOR_NAME) = 'GEN_TWEB_CATALOG_VIRTUAL_ID')) THEN
        EXECUTE STATEMENT 'CREATE GENERATOR GEN_TWEB_CATALOG_VIRTUAL_ID';
END^

CREATE OR ALTER TRIGGER TWEB_CATALOG_VIRTUAL_BI FOR TWEB_CATALOG_VIRTUAL
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
    IF (NEW.ID IS NULL) THEN
        NEW.ID = GEN_ID(GEN_TWEB_CATALOG_VIRTUAL_ID, 1);
END^

/* --- 3. TWEB_CATALOG_VIRTUAL_IMAGE --------------------------------------
   Oglinda lui TWEB_CATALOG_IMAGE, cu aceleasi domenii. Tabel LATERAL, nu
   coloana in TWEB_CATALOG_VIRTUAL: CatalogVirtualFolder::getByCatalog()
   face SELECT pe toate coloanele si cache-uieste randurile in Redis 24h,
   iar un BLOB inline ar umfla cache-ul la fiecare request.
     IMAGE     - iconita mica (rezervat, simetrie cu TWEB_CATALOG_IMAGE)
     BIG_IMAGE - imaginea tile-ului (sursa pentru 'virtual_catalog_image') */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE TRIM(RDB$RELATION_NAME) = 'TWEB_CATALOG_VIRTUAL_IMAGE')) THEN
        EXECUTE STATEMENT
        'CREATE TABLE TWEB_CATALOG_VIRTUAL_IMAGE (
             VIRTUALID      DM_INTEGER_NN,
             IMAGE          DM_BLOBIMAGE,
             IMAGE_HASH     DM_VARCHAR32,
             BIG_IMAGE      DM_BLOBIMAGE,
             BIG_IMAGE_HASH DM_VARCHAR32,
             CONSTRAINT PK_TWEB_CATALOG_VIRTUAL_IMAGE PRIMARY KEY (VIRTUALID)
         )';
END^

/* Hash-urile se calculeaza in DB, exact ca la TWEB_CATALOG_IMAGE_BU:
   site-ul le foloseste in numele fisierului webp pentru cache-busting. */
CREATE OR ALTER TRIGGER TWEB_CATALOG_VIRTUAL_IMAGE_BU FOR TWEB_CATALOG_VIRTUAL_IMAGE
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
    NEW.IMAGE_HASH     = HASH(NEW.IMAGE);
    NEW.BIG_IMAGE_HASH = HASH(NEW.BIG_IMAGE);
END^

/* --- 4. TWEB_CATALOG_VIRTUAL.FLAGS: bit 1 = FLG_TILE --------------------
   bit 0 = FLG_ENABLED (mapa e activa, are URL propriu si pagina proprie)
   bit 1 = FLG_TILE    (mapa apare in grila de tile-uri a categoriei-parinte)
   Randurile existente au FLAGS = 1; le ridicam si bitul de tile, ca sa se
   comporte ca inainte (erau afisate ca pastile). */
EXECUTE BLOCK AS
BEGIN
    UPDATE TWEB_CATALOG_VIRTUAL
       SET FLAGS = BIN_OR(FLAGS, 2)
     WHERE BIN_AND(FLAGS, 1) = 1
       AND BIN_AND(FLAGS, 2) = 0;
END^

SET TERM ; ^
COMMIT;

/* --- 5. VW_TWEB_CATALOG_VIRTUAL -----------------------------------------
   View updatable pentru WMS, dupa conventia VW_* din proiect: expune FLAGS
   explodat in FLG_* si primeste INSERT/UPDATE/DELETE prin triggere, exact ca
   VW_TWEB_CATALOG. Site-ul citeste tabela direct, nu view-ul.
   FILTER_NAME si HAS_IMAGE sunt read-only (triggerele le ignora). */
CREATE OR ALTER VIEW VW_TWEB_CATALOG_VIRTUAL (
    ID, CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
    FILTERID, FILTERPARAMIDS, ORDERNO, FLG_ENABLED, FLG_TILE,
    META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS,
    SEO_TEXT_ROM, SEO_TEXT_RUS, FILTER_NAME, HAS_IMAGE)
AS
SELECT
    V.ID,
    V.CATALOGID,
    V.TITLE_ROM,
    V.TITLE_RUS,
    V.H1_ROM,
    V.H1_RUS,
    V.REWRITE_URL,
    V.FILTERID,
    V.FILTERPARAMIDS,
    V.ORDERNO,
    GET_FLG_VALUE(V.FLAGS, 0),
    GET_FLG_VALUE(V.FLAGS, 1),
    V.META_TITLE_ROM,
    V.META_TITLE_RUS,
    V.META_DESCRIPTION_ROM,
    V.META_DESCRIPTION_RUS,
    V.SEO_TEXT_ROM,
    V.SEO_TEXT_RUS,
    (SELECT F.FILTERNAME FROM TS_FILTERS F WHERE F.FILTERID = V.FILTERID),
    IIF(EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL_IMAGE I
               WHERE I.VIRTUALID = V.ID AND OCTET_LENGTH(I.BIG_IMAGE) > 0), 1, 0)
FROM TWEB_CATALOG_VIRTUAL V;

COMMIT;

SET TERM ^ ;

CREATE OR ALTER TRIGGER VW_TWEB_CATALOG_VIRTUAL_BI FOR VW_TWEB_CATALOG_VIRTUAL
ACTIVE BEFORE INSERT POSITION 0
AS
DECLARE VARIABLE TMPFLAGS DM_INTEGER;
BEGIN
    TMPFLAGS = 0;
    TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 0, COALESCE(NEW.FLG_ENABLED, 1));
    TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 1, COALESCE(NEW.FLG_TILE, 1));

    INSERT INTO TWEB_CATALOG_VIRTUAL (
        ID, CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
        FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
        META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM,
        META_DESCRIPTION_RUS, SEO_TEXT_ROM, SEO_TEXT_RUS)
    VALUES (
        NEW.ID, NEW.CATALOGID, NEW.TITLE_ROM, NEW.TITLE_RUS, NEW.H1_ROM,
        NEW.H1_RUS, NEW.REWRITE_URL, NEW.FILTERID, NEW.FILTERPARAMIDS,
        COALESCE(NEW.ORDERNO, 0), :TMPFLAGS,
        NEW.META_TITLE_ROM, NEW.META_TITLE_RUS, NEW.META_DESCRIPTION_ROM,
        NEW.META_DESCRIPTION_RUS, NEW.SEO_TEXT_ROM, NEW.SEO_TEXT_RUS);
END^

CREATE OR ALTER TRIGGER VW_TWEB_CATALOG_VIRTUAL_BU FOR VW_TWEB_CATALOG_VIRTUAL
ACTIVE BEFORE UPDATE POSITION 0
AS
DECLARE VARIABLE TMPFLAGS DM_INTEGER;
BEGIN
    SELECT FLAGS FROM TWEB_CATALOG_VIRTUAL WHERE ID = OLD.ID INTO :TMPFLAGS;
    TMPFLAGS = COALESCE(TMPFLAGS, 0);
    TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 0, COALESCE(NEW.FLG_ENABLED, 0));
    TMPFLAGS = SET_FLG_VALUE(TMPFLAGS, 1, COALESCE(NEW.FLG_TILE, 0));

    UPDATE TWEB_CATALOG_VIRTUAL SET
        CATALOGID            = NEW.CATALOGID,
        TITLE_ROM            = NEW.TITLE_ROM,
        TITLE_RUS            = NEW.TITLE_RUS,
        H1_ROM               = NEW.H1_ROM,
        H1_RUS               = NEW.H1_RUS,
        REWRITE_URL          = NEW.REWRITE_URL,
        FILTERID             = NEW.FILTERID,
        FILTERPARAMIDS       = NEW.FILTERPARAMIDS,
        ORDERNO              = COALESCE(NEW.ORDERNO, 0),
        FLAGS                = :TMPFLAGS,
        META_TITLE_ROM       = NEW.META_TITLE_ROM,
        META_TITLE_RUS       = NEW.META_TITLE_RUS,
        META_DESCRIPTION_ROM = NEW.META_DESCRIPTION_ROM,
        META_DESCRIPTION_RUS = NEW.META_DESCRIPTION_RUS,
        SEO_TEXT_ROM         = NEW.SEO_TEXT_ROM,
        SEO_TEXT_RUS         = NEW.SEO_TEXT_RUS
    WHERE ID = OLD.ID;
END^

CREATE OR ALTER TRIGGER VW_TWEB_CATALOG_VIRTUAL_BD FOR VW_TWEB_CATALOG_VIRTUAL
ACTIVE BEFORE DELETE POSITION 0
AS
BEGIN
    DELETE FROM TWEB_CATALOG_VIRTUAL_IMAGE WHERE VIRTUALID = OLD.ID;
    DELETE FROM TWEB_CATALOG_VIRTUAL WHERE ID = OLD.ID;
END^

SET TERM ; ^
COMMIT;

/* --- 6. Drepturi pentru utilizatorul web --------------------------------
   Site-ul are nevoie doar de SELECT; administrarea se face din WMS. */
GRANT SELECT ON TWEB_CATALOG_VIRTUAL       TO WEBUSER;
GRANT SELECT ON TWEB_CATALOG_VIRTUAL_IMAGE TO WEBUSER;
COMMIT;

SET TERM ^ ;

/* --- 7. WEB_GET_CATALOG_TREE4 -------------------------------------------
   Copie a lui WEB_GET_CATALOG_TREE3_V2 cu o a patra bucla (PARENTID =
   LEVEL3_ID). WEB_GET_CATALOG_TREE3_V2 ramane neatinsa.

   FORMA REZULTATULUI - doua feluri de randuri pentru fiecare nod de nivel 3:
     LEVEL4_ID IS NULL     -> randul categoriei insasi (ca in V2)
     LEVEL4_ID IS NOT NULL -> o subcategorie de nivel 4 a acelei categorii
   Randurile aceluiasi nod de nivel 3 sunt intotdeauna consecutive, cu randul
   categoriei primul.

   REGULI DE EMITERE (in V2 un nod de nivel 3 cu 0 produse era eliminat, ceea
   ce ar face invizibil un parinte pur-navigational):
     nivel 3 se emite daca are produse SAU are cel putin un copil vizibil de
             nivel 4 SAU este nod-link
     nivel 4 se emite daca are produse SAU este nod-link
   Nodul-link (FLAGS bit 9 = FLG_GROUP_IS_LINK) nu are nevoie de mape in
   TWEB_CATALOG_ITEMS - duce la URL_RO / URL_RU.
   ------------------------------------------------------------------------ */
CREATE OR ALTER PROCEDURE WEB_GET_CATALOG_TREE4 (
    FIRMA DM_INTEGER_NN)
RETURNS (
    LEVEL1_ID                      DM_INTEGER,
    LEVEL1_TITLE                   DM_VARCHAR60,
    LEVEL1_TITLE_RUS               DM_VARCHAR60,
    LEVEL1_ORDERNO                 DM_INTEGER,
    LEVEL1_IMAGE                   DM_BLOBIMAGE,
    LEVEL1_FLG_PROMO               DM_INTEGER,
    LEVEL1_FLG_NEW                 DM_INTEGER,
    LEVEL2_ID                      DM_INTEGER,
    LEVEL2_TITLE                   DM_VARCHAR60,
    LEVEL2_TITLE_RUS               DM_VARCHAR60,
    LEVEL2_ORDERNO                 DM_INTEGER,
    LEVEL2_REWRITE_URL_ROM         DM_VARCHAR255,
    LEVEL2_REWRITE_URL_RUS         DM_VARCHAR255,
    LEVEL2_FLG_PROMO               DM_INTEGER,
    LEVEL2_FLG_NEW                 DM_INTEGER,
    LEVEL3_ID                      DM_INTEGER,
    LEVEL3_TITLE                   DM_VARCHAR60,
    LEVEL3_TITLE_RUS               DM_VARCHAR60,
    LEVEL3_ORDERNO                 DM_INTEGER,
    LEVEL3_FLG_PROMO               DM_INTEGER,
    LEVEL3_FLG_NEW                 DM_INTEGER,
    FLG_CUSTOM_PRICE_COLUMN        DM_BOOLEAN,
    CUSTOM_PRICE_COLUMN            DM_PRICECOLUMN,
    GOODS_COUNT                    DM_INTEGER,
    GOODS_NEW                      DM_INTEGER,
    FLG_VIEWMODE_VITRINA           DM_BOOLEAN,
    REWRITE_URL_ROM                DM_VARCHAR255,
    REWRITE_URL_RUS                DM_VARCHAR255,
    HAS_ALSOBUY_GOODS              DM_BOOLEAN,
    LEVEL3_HAS_IMAGE               DM_BOOLEAN,
    LEVEL3_META_TITLE_RO           DM_VARCHAR255,
    LEVEL3_META_TITLE_RU           DM_VARCHAR255,
    LEVEL3_META_DESCRIPTION_RO     DM_VARCHAR1024,
    LEVEL3_META_DESCRIPTION_RU     DM_VARCHAR1024,
    LEVEL3_FLG_GROUP_IS_LINK       DM_INTEGER,
    LEVEL3_URL_RO                  DM_VARCHAR255,
    LEVEL3_URL_RU                  DM_VARCHAR255,
    LEVEL3_HAS_CHILDREN            DM_BOOLEAN,
    LEVEL4_ID                      DM_INTEGER,
    LEVEL4_TITLE                   DM_VARCHAR60,
    LEVEL4_TITLE_RUS               DM_VARCHAR60,
    LEVEL4_ORDERNO                 DM_INTEGER,
    LEVEL4_REWRITE_URL_ROM         DM_VARCHAR255,
    LEVEL4_REWRITE_URL_RUS         DM_VARCHAR255,
    LEVEL4_FLG_PROMO               DM_INTEGER,
    LEVEL4_FLG_NEW                 DM_INTEGER,
    LEVEL4_FLG_GROUP_IS_LINK       DM_INTEGER,
    LEVEL4_URL_RO                  DM_VARCHAR255,
    LEVEL4_URL_RU                  DM_VARCHAR255,
    LEVEL4_HAS_IMAGE               DM_BOOLEAN,
    LEVEL4_HAS_ALSOBUY_GOODS       DM_BOOLEAN,
    LEVEL4_GOODS_COUNT             DM_INTEGER,
    LEVEL4_GOODS_NEW               DM_INTEGER,
    LEVEL4_FLG_CUSTOM_PRICE_COLUMN DM_BOOLEAN,
    LEVEL4_CUSTOM_PRICE_COLUMN     DM_PRICECOLUMN,
    LEVEL4_FLG_VIEWMODE_VITRINA    DM_BOOLEAN,
    LEVEL4_META_TITLE_RO           DM_VARCHAR255,
    LEVEL4_META_TITLE_RU           DM_VARCHAR255,
    LEVEL4_META_DESCRIPTION_RO     DM_VARCHAR1024,
    LEVEL4_META_DESCRIPTION_RU     DM_VARCHAR1024)
AS
DECLARE VARIABLE TMPINDEXLIST DM_VARCHAR1024;
DECLARE VARIABLE CHILDLIST    DM_VARCHAR1024;
DECLARE VARIABLE CHILDID      DM_INTEGER;
DECLARE VARIABLE CHILDLINK    DM_INTEGER;
BEGIN
  /* LEVEL 1 */
  FOR SELECT CATALOG.CATALOGID, CATALOG.TITLE, CATALOG.TITLE_RUS,
             CATALOG.ORDERNO, CIMAGES.IMAGE,
             GET_FLG_VALUE(CATALOG.FLAGS, 7),
             GET_FLG_VALUE(CATALOG.FLAGS, 8)
      FROM TWEB_CATALOG CATALOG
      LEFT OUTER JOIN TWEB_CATALOG_IMAGE CIMAGES ON CIMAGES.CATALOGID = CATALOG.CATALOGID
      WHERE (CATALOG.PARENTID = 0)
            AND (CATALOG.DT = :FIRMA)
            AND (GET_FLG_VALUE(CATALOG.FLAGS, 0) = 1) /* FLG_ENABLED */
      ORDER BY CATALOG.ORDERNO
      INTO :LEVEL1_ID, :LEVEL1_TITLE, :LEVEL1_TITLE_RUS, :LEVEL1_ORDERNO,
           :LEVEL1_IMAGE, :LEVEL1_FLG_PROMO, :LEVEL1_FLG_NEW
  DO
    /* LEVEL 2 */
    FOR SELECT CATALOGID, TITLE, TITLE_RUS, ORDERNO,
               COALESCE(REWRITE_URL_ROM, ''), COALESCE(REWRITE_URL_RUS, ''),
               GET_FLG_VALUE(FLAGS, 7),
               GET_FLG_VALUE(FLAGS, 8)
        FROM TWEB_CATALOG
        WHERE (PARENTID = :LEVEL1_ID)
              AND (DT = :FIRMA)
              AND (GET_FLG_VALUE(FLAGS, 0) = 1) /* FLG_ENABLED */
        ORDER BY ORDERNO
        INTO :LEVEL2_ID, :LEVEL2_TITLE, :LEVEL2_TITLE_RUS, :LEVEL2_ORDERNO,
             :LEVEL2_REWRITE_URL_ROM, :LEVEL2_REWRITE_URL_RUS,
             :LEVEL2_FLG_PROMO, :LEVEL2_FLG_NEW
    DO
      /* LEVEL 3 */
      FOR SELECT CATALOGID, TITLE, TITLE_RUS, ORDERNO,
                 GET_FLG_VALUE(FLAGS, 4),
                 CUSTOM_PRICE_COLUMN,
                 1, /* FLG_VIEWMODE_VITRINA - hardcodat, ca in V2 */
                 REWRITE_URL_ROM, REWRITE_URL_RUS,
                 IIF(EXISTS(SELECT GOODSID FROM TWEB_CATALOG_ALSOBUY A
                            WHERE A.CATALOGID = TWEB_CATALOG.CATALOGID), 1, 0),
                 CAST(IIF(EXISTS(SELECT 1 FROM TWEB_CATALOG_IMAGE I
                                 WHERE I.CATALOGID = TWEB_CATALOG.CATALOGID), 1, 0) AS INTEGER),
                 GET_FLG_VALUE(FLAGS, 7),
                 GET_FLG_VALUE(FLAGS, 8),
                 GET_FLG_VALUE(FLAGS, 9),
                 URL_RO, URL_RU
          FROM TWEB_CATALOG
          WHERE (PARENTID = :LEVEL2_ID)
                AND (DT = :FIRMA)
                AND (GET_FLG_VALUE(FLAGS, 0) = 1) /* FLG_ENABLED */
          ORDER BY ORDERNO
          INTO :LEVEL3_ID, :LEVEL3_TITLE, :LEVEL3_TITLE_RUS, :LEVEL3_ORDERNO,
               :FLG_CUSTOM_PRICE_COLUMN, :CUSTOM_PRICE_COLUMN,
               :FLG_VIEWMODE_VITRINA, :REWRITE_URL_ROM, :REWRITE_URL_RUS,
               :HAS_ALSOBUY_GOODS, :LEVEL3_HAS_IMAGE, :LEVEL3_FLG_PROMO,
               :LEVEL3_FLG_NEW, :LEVEL3_FLG_GROUP_IS_LINK,
               :LEVEL3_URL_RO, :LEVEL3_URL_RU
      DO
      BEGIN
        /* produsele nodului de nivel 3 */
        TMPINDEXLIST = NULL;
        SELECT LIST(GOODSPARENTID, ',')
        FROM TWEB_CATALOG_ITEMS
        WHERE TWEB_CATALOG_ITEMS.CATALOGID = :LEVEL3_ID
              AND GET_FLG_VALUE(FLAGS, 1) = 0
        INTO :TMPINDEXLIST;

        GOODS_COUNT = 0;
        GOODS_NEW = 0;

        IF (TMPINDEXLIST IS NOT NULL) THEN
        BEGIN
          SELECT (SELECT COUNT(G1.GOODSID)
                  FROM TWEB_CACHE_GOODS G1
                  INNER JOIN SPLIT(:TMPINDEXLIST) Z1 ON Z1.ID = G1.PARENTID),
                 (SELECT COUNT(G2.GOODSID)
                  FROM TWEB_CACHE_GOODS G2
                  INNER JOIN SPLIT(:TMPINDEXLIST) Z2 ON Z2.ID = G2.PARENTID
                          AND G2.FLG_NEW = 1)
          FROM RDB$DATABASE
          INTO :GOODS_COUNT, :GOODS_NEW;
        END

        LEVEL3_META_TITLE_RO = NULL;
        LEVEL3_META_TITLE_RU = NULL;
        LEVEL3_META_DESCRIPTION_RO = NULL;
        LEVEL3_META_DESCRIPTION_RU = NULL;
        SELECT META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION_RO, META_DESCRIPTION_RU
        FROM TWEB_CATALOG_SEO
        WHERE CATALOGID = :LEVEL3_ID
        INTO :LEVEL3_META_TITLE_RO, :LEVEL3_META_TITLE_RU,
             :LEVEL3_META_DESCRIPTION_RO, :LEVEL3_META_DESCRIPTION_RU;

        /* are cel putin un copil vizibil de nivel 4? (EXISTS, nu COUNT) */
        LEVEL3_HAS_CHILDREN = 0;
        FOR SELECT C4.CATALOGID, GET_FLG_VALUE(C4.FLAGS, 9)
            FROM TWEB_CATALOG C4
            WHERE (C4.PARENTID = :LEVEL3_ID)
                  AND (C4.DT = :FIRMA)
                  AND (GET_FLG_VALUE(C4.FLAGS, 0) = 1)
            INTO :CHILDID, :CHILDLINK
        DO
        BEGIN
          IF (LEVEL3_HAS_CHILDREN = 0) THEN
          BEGIN
            IF (CHILDLINK = 1) THEN
              LEVEL3_HAS_CHILDREN = 1;
            ELSE
            BEGIN
              CHILDLIST = NULL;
              SELECT LIST(GOODSPARENTID, ',')
              FROM TWEB_CATALOG_ITEMS
              WHERE TWEB_CATALOG_ITEMS.CATALOGID = :CHILDID
                    AND GET_FLG_VALUE(FLAGS, 1) = 0
              INTO :CHILDLIST;

              IF (CHILDLIST IS NOT NULL) THEN
              BEGIN
                IF (EXISTS(SELECT 1 FROM TWEB_CACHE_GOODS G
                           INNER JOIN SPLIT(:CHILDLIST) Z ON Z.ID = G.PARENTID)) THEN
                  LEVEL3_HAS_CHILDREN = 1;
              END
            END
          END
        END

        /* --- randul categoriei insasi (LEVEL4_ID IS NULL) --- */
        LEVEL4_ID = NULL;
        LEVEL4_TITLE = NULL;
        LEVEL4_TITLE_RUS = NULL;
        LEVEL4_ORDERNO = NULL;
        LEVEL4_REWRITE_URL_ROM = NULL;
        LEVEL4_REWRITE_URL_RUS = NULL;
        LEVEL4_FLG_PROMO = NULL;
        LEVEL4_FLG_NEW = NULL;
        LEVEL4_FLG_GROUP_IS_LINK = NULL;
        LEVEL4_URL_RO = NULL;
        LEVEL4_URL_RU = NULL;
        LEVEL4_HAS_IMAGE = NULL;
        LEVEL4_HAS_ALSOBUY_GOODS = NULL;
        LEVEL4_GOODS_COUNT = NULL;
        LEVEL4_GOODS_NEW = NULL;
        LEVEL4_FLG_CUSTOM_PRICE_COLUMN = NULL;
        LEVEL4_CUSTOM_PRICE_COLUMN = NULL;
        LEVEL4_FLG_VIEWMODE_VITRINA = NULL;
        LEVEL4_META_TITLE_RO = NULL;
        LEVEL4_META_TITLE_RU = NULL;
        LEVEL4_META_DESCRIPTION_RO = NULL;
        LEVEL4_META_DESCRIPTION_RU = NULL;

        IF ((GOODS_COUNT > 0)
            OR (LEVEL3_HAS_CHILDREN = 1)
            OR (LEVEL3_FLG_GROUP_IS_LINK = 1)) THEN
          SUSPEND;

        /* --- LEVEL 4 --- */
        FOR SELECT CATALOGID, TITLE, TITLE_RUS, ORDERNO,
                   COALESCE(REWRITE_URL_ROM, ''), COALESCE(REWRITE_URL_RUS, ''),
                   GET_FLG_VALUE(FLAGS, 7),
                   GET_FLG_VALUE(FLAGS, 8),
                   GET_FLG_VALUE(FLAGS, 9),
                   URL_RO, URL_RU,
                   CAST(IIF(EXISTS(SELECT 1 FROM TWEB_CATALOG_IMAGE I
                                   WHERE I.CATALOGID = TWEB_CATALOG.CATALOGID), 1, 0) AS INTEGER),
                   IIF(EXISTS(SELECT GOODSID FROM TWEB_CATALOG_ALSOBUY A
                              WHERE A.CATALOGID = TWEB_CATALOG.CATALOGID), 1, 0),
                   GET_FLG_VALUE(FLAGS, 4),
                   CUSTOM_PRICE_COLUMN,
                   1 /* FLG_VIEWMODE_VITRINA - la fel ca la nivelul 3 */
            FROM TWEB_CATALOG
            WHERE (PARENTID = :LEVEL3_ID)
                  AND (DT = :FIRMA)
                  AND (GET_FLG_VALUE(FLAGS, 0) = 1)
            ORDER BY ORDERNO
            INTO :LEVEL4_ID, :LEVEL4_TITLE, :LEVEL4_TITLE_RUS, :LEVEL4_ORDERNO,
                 :LEVEL4_REWRITE_URL_ROM, :LEVEL4_REWRITE_URL_RUS,
                 :LEVEL4_FLG_PROMO, :LEVEL4_FLG_NEW, :LEVEL4_FLG_GROUP_IS_LINK,
                 :LEVEL4_URL_RO, :LEVEL4_URL_RU, :LEVEL4_HAS_IMAGE,
                 :LEVEL4_HAS_ALSOBUY_GOODS, :LEVEL4_FLG_CUSTOM_PRICE_COLUMN,
                 :LEVEL4_CUSTOM_PRICE_COLUMN, :LEVEL4_FLG_VIEWMODE_VITRINA
        DO
        BEGIN
          CHILDLIST = NULL;
          SELECT LIST(GOODSPARENTID, ',')
          FROM TWEB_CATALOG_ITEMS
          WHERE TWEB_CATALOG_ITEMS.CATALOGID = :LEVEL4_ID
                AND GET_FLG_VALUE(FLAGS, 1) = 0
          INTO :CHILDLIST;

          LEVEL4_GOODS_COUNT = 0;
          LEVEL4_GOODS_NEW = 0;

          IF (CHILDLIST IS NOT NULL) THEN
          BEGIN
            SELECT (SELECT COUNT(G1.GOODSID)
                    FROM TWEB_CACHE_GOODS G1
                    INNER JOIN SPLIT(:CHILDLIST) Z1 ON Z1.ID = G1.PARENTID),
                   (SELECT COUNT(G2.GOODSID)
                    FROM TWEB_CACHE_GOODS G2
                    INNER JOIN SPLIT(:CHILDLIST) Z2 ON Z2.ID = G2.PARENTID
                            AND G2.FLG_NEW = 1)
            FROM RDB$DATABASE
            INTO :LEVEL4_GOODS_COUNT, :LEVEL4_GOODS_NEW;
          END

          LEVEL4_META_TITLE_RO = NULL;
          LEVEL4_META_TITLE_RU = NULL;
          LEVEL4_META_DESCRIPTION_RO = NULL;
          LEVEL4_META_DESCRIPTION_RU = NULL;
          SELECT META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION_RO, META_DESCRIPTION_RU
          FROM TWEB_CATALOG_SEO
          WHERE CATALOGID = :LEVEL4_ID
          INTO :LEVEL4_META_TITLE_RO, :LEVEL4_META_TITLE_RU,
               :LEVEL4_META_DESCRIPTION_RO, :LEVEL4_META_DESCRIPTION_RU;

          IF ((LEVEL4_GOODS_COUNT > 0) OR (LEVEL4_FLG_GROUP_IS_LINK = 1)) THEN
            SUSPEND;
        END
      END
END^

SET TERM ; ^
COMMIT;

/* Site-ul ruleaza ca WEBUSER si nu are drepturi directe pe tabelele de
   catalog - procedura le primeste explicit, ca WEB_GET_CATALOG_TREE3_V2. */
GRANT SELECT  ON TWEB_CATALOG         TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT SELECT  ON TWEB_CATALOG_IMAGE   TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT SELECT  ON TWEB_CATALOG_ITEMS   TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT SELECT  ON TWEB_CATALOG_SEO     TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT SELECT  ON TWEB_CATALOG_ALSOBUY TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT SELECT  ON TWEB_CACHE_GOODS     TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT EXECUTE ON PROCEDURE SPLIT      TO PROCEDURE WEB_GET_CATALOG_TREE4;
GRANT EXECUTE ON PROCEDURE WEB_GET_CATALOG_TREE4 TO WEBUSER;
COMMIT;

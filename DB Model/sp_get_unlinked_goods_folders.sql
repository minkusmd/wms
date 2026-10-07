/*
  SP_GET_UNLINKED_GOODS_FOLDERS
  Mapele din TS_GOODS (FLG_FOLDER = 1) care nu sunt legate de nicio mapa
  din TWEB_CATALOG (nu exista rand in TWEB_CATALOG_ITEMS cu GOODSPARENTID = mapa).

  Site-ul ia produsele dupa parintele direct (TS_GOODS.PARENTID =
  TWEB_CATALOG_ITEMS.GOODSPARENTID), deci produsele dintr-o submapa nelegata
  nu apar pe site chiar daca mapa-parinte e legata.

  Parametru:
    I_ONLY_WITH_GOODS = 1 -> doar mapele care contin direct produse (implicit)
                        0 -> toate mapele nelegate (si cele doar cu submape / goale)

  Iesire:
    GOODSID          - id-ul mapei
    PARENTID         - mapa-parinte
    TITLE            - denumirea mapei
    FOLDER_PATH      - calea completa "Radacina / ... / Mapa"
    GOODS_CNT        - produse direct in mapa
    STOCK_GOODS_CNT  - dintre ele, cu stoc > 0 (TS_GOODS_STOCK.QTY)
    SUBFOLDERS_CNT   - submape directe
    PARENT_LINKED    - 1 daca vreun stramos e legat in TWEB_CATALOG

  Exemplu:
    SELECT * FROM SP_GET_UNLINKED_GOODS_FOLDERS(1)
    ORDER BY STOCK_GOODS_CNT DESC, GOODS_CNT DESC;
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_GET_UNLINKED_GOODS_FOLDERS (
    I_ONLY_WITH_GOODS SMALLINT = 1)
RETURNS (
    GOODSID          INTEGER,
    PARENTID         INTEGER,
    TITLE            VARCHAR(2048),
    FOLDER_PATH      VARCHAR(4000),
    GOODS_CNT        INTEGER,
    STOCK_GOODS_CNT  INTEGER,
    SUBFOLDERS_CNT   INTEGER,
    PARENT_LINKED    SMALLINT)
AS
DECLARE VARIABLE V_ID     INTEGER;
DECLARE VARIABLE V_PARENT INTEGER;
DECLARE VARIABLE V_TITLE  VARCHAR(2048);
DECLARE VARIABLE V_DEPTH  INTEGER;
BEGIN
  FOR
    SELECT F.GOODSID, F.PARENTID, F.TITLE,
           (SELECT COUNT(*) FROM TS_GOODS G
             WHERE G.PARENTID = F.GOODSID AND COALESCE(G.FLG_FOLDER, 0) = 0),
           (SELECT COUNT(*) FROM TS_GOODS G
             WHERE G.PARENTID = F.GOODSID AND COALESCE(G.FLG_FOLDER, 0) = 0
               AND EXISTS (SELECT 1 FROM TS_GOODS_STOCK S
                            WHERE S.GOODSID = G.GOODSID AND S.QTY > 0)),
           (SELECT COUNT(*) FROM TS_GOODS G
             WHERE G.PARENTID = F.GOODSID AND G.FLG_FOLDER = 1)
      FROM TS_GOODS F
     WHERE F.FLG_FOLDER = 1
       AND NOT EXISTS (SELECT 1 FROM TWEB_CATALOG_ITEMS I
                        WHERE I.GOODSPARENTID = F.GOODSID)
      INTO :GOODSID, :PARENTID, :TITLE,
           :GOODS_CNT, :STOCK_GOODS_CNT, :SUBFOLDERS_CNT
  DO
  BEGIN
    IF (COALESCE(I_ONLY_WITH_GOODS, 1) = 0 OR GOODS_CNT > 0) THEN
    BEGIN
      /* calea completa + verificarea stramosilor legati */
      FOLDER_PATH = TRIM(TITLE);
      PARENT_LINKED = 0;
      V_PARENT = PARENTID;
      V_DEPTH = 0;
      WHILE (V_PARENT IS NOT NULL AND V_PARENT <> 0 AND V_DEPTH < 50) DO
      BEGIN
        V_ID = NULL;
        SELECT P.GOODSID, P.PARENTID, P.TITLE
          FROM TS_GOODS P
         WHERE P.GOODSID = :V_PARENT
          INTO :V_ID, :V_PARENT, :V_TITLE;
        IF (V_ID IS NULL) THEN
          LEAVE;
        IF (CHAR_LENGTH(FOLDER_PATH) < 3900) THEN
          FOLDER_PATH = TRIM(V_TITLE) || ' / ' || FOLDER_PATH;
        IF (PARENT_LINKED = 0 AND
            EXISTS (SELECT 1 FROM TWEB_CATALOG_ITEMS I
                     WHERE I.GOODSPARENTID = :V_ID)) THEN
          PARENT_LINKED = 1;
        V_DEPTH = V_DEPTH + 1;
      END
      SUSPEND;
    END
  END
END^

SET TERM ; ^

COMMENT ON PROCEDURE SP_GET_UNLINKED_GOODS_FOLDERS IS
  'Mapele TS_GOODS nelegate in TWEB_CATALOG (TWEB_CATALOG_ITEMS.GOODSPARENTID)';

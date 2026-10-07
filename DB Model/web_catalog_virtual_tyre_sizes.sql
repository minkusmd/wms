/* ------------------------------------------------------------------------
   Mape virtuale de nivel 4 pentru "Piese auto / Anvelope / Anvelope auto"
   (TWEB_CATALOG.CATALOGID = 1940): cate o mapa pentru fiecare marime de
   anvelopa, dupa blocul de linkuri SEO de pe
   https://www.pandashop.md/ro/catalog/auto_electronics/tires_and_wheels/tyres/

   Fiecare mapa are trei atribute, combinate cu SI:
       1247 Latime + 1259 Inaltime profil + 1249 Diametru
   FILTERID = primul atribut, FILTERPARAMIDS = "<latime>;1259(<inaltime>);1249(<diametru>)"
   (formatul e descris in frmWebCatalogVirtualFolderEditorDialog.pas si in
   fantastic.web/models/CatalogVirtualFolder.php).

   Mapele se creeaza INACTIVE (FLAGS = 0). Se activeaza din WMS (Web Catalog >
   Mape virtuale) DUPA ce site-ul are versiunea care intelege mai multe
   atribute - altfel pagina ar arata toata categoria.

   Scriptul e RE-RULABIL: o mapa se adauga doar daca slug-ul ei lipseste.
   Fisier UTF-8 fara BOM - se ruleaza cu:  isql -ch UTF8 ... -i <fisier>
   ------------------------------------------------------------------------ */

SET TERM ^ ;

/* 185/65 R15 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-185-65-r15')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '185' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '65 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R15' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '185/65 R15', '185/65 R15',
            'Anvelope 185/65 R15', 'Шины 185/65 R15', 'anvelope-185-65-r15',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 10, 0,
            'Anvelope 185/65 R15 – preț bun, rate 0% | Fantastic.md',
            'Шины 185/65 R15 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 185/65 R15 pentru autoturisme compacte și de oraș: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 185/65 R15 для компактных и городских автомобилей: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 195/65 R15 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-195-65-r15')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '195' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '65 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R15' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '195/65 R15', '195/65 R15',
            'Anvelope 195/65 R15', 'Шины 195/65 R15', 'anvelope-195-65-r15',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 11, 0,
            'Anvelope 195/65 R15 – preț bun, rate 0% | Fantastic.md',
            'Шины 195/65 R15 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 195/65 R15 pentru autoturisme compacte și de familie: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 195/65 R15 для компактных и семейных автомобилей: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 205/55 R16 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-205-55-r16')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '205' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '55 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R16' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '205/55 R16', '205/55 R16',
            'Anvelope 205/55 R16', 'Шины 205/55 R16', 'anvelope-205-55-r16',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 12, 0,
            'Anvelope 205/55 R16 – preț bun, rate 0% | Fantastic.md',
            'Шины 205/55 R16 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 205/55 R16 pentru autoturisme de clasă compactă și medie: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 205/55 R16 для автомобилей компактного и среднего класса: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 205/60 R16 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-205-60-r16')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '205' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '60 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R16' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '205/60 R16', '205/60 R16',
            'Anvelope 205/60 R16', 'Шины 205/60 R16', 'anvelope-205-60-r16',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 13, 0,
            'Anvelope 205/60 R16 – preț bun, rate 0% | Fantastic.md',
            'Шины 205/60 R16 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 205/60 R16 pentru autoturisme de clasă medie și crossovere: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 205/60 R16 для автомобилей среднего класса и кроссоверов: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 215/65 R16 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-215-65-r16')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '215' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '65 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R16' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '215/65 R16', '215/65 R16',
            'Anvelope 215/65 R16', 'Шины 215/65 R16', 'anvelope-215-65-r16',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 14, 0,
            'Anvelope 215/65 R16 – preț bun, rate 0% | Fantastic.md',
            'Шины 215/65 R16 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 215/65 R16 pentru crossovere și SUV-uri compacte: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 215/65 R16 для кроссоверов и компактных внедорожников: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 215/55 R17 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-215-55-r17')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '215' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '55 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R17' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '215/55 R17', '215/55 R17',
            'Anvelope 215/55 R17', 'Шины 215/55 R17', 'anvelope-215-55-r17',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 15, 0,
            'Anvelope 215/55 R17 – preț bun, rate 0% | Fantastic.md',
            'Шины 215/55 R17 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 215/55 R17 pentru sedanuri și crossovere compacte: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 215/55 R17 для седанов и компактных кроссоверов: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 215/60 R17 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-215-60-r17')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '215' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '60 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R17' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '215/60 R17', '215/60 R17',
            'Anvelope 215/60 R17', 'Шины 215/60 R17', 'anvelope-215-60-r17',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 16, 0,
            'Anvelope 215/60 R17 – preț bun, rate 0% | Fantastic.md',
            'Шины 215/60 R17 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 215/60 R17 pentru crossovere și SUV-uri de familie: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 215/60 R17 для семейных кроссоверов и внедорожников: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 225/45 R17 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-225-45-r17')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '225' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '45 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R17' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '225/45 R17', '225/45 R17',
            'Anvelope 225/45 R17', 'Шины 225/45 R17', 'anvelope-225-45-r17',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 17, 0,
            'Anvelope 225/45 R17 – preț bun, rate 0% | Fantastic.md',
            'Шины 225/45 R17 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 225/45 R17 pentru sedanuri și hatchback-uri sportive: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 225/45 R17 для спортивных седанов и хэтчбеков: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 225/50 R17 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-225-50-r17')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '225' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '50 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R17' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '225/50 R17', '225/50 R17',
            'Anvelope 225/50 R17', 'Шины 225/50 R17', 'anvelope-225-50-r17',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 18, 0,
            'Anvelope 225/50 R17 – preț bun, rate 0% | Fantastic.md',
            'Шины 225/50 R17 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 225/50 R17 pentru sedanuri de clasă medie și business: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 225/50 R17 для седанов среднего и бизнес-класса: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 225/55 R17 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-225-55-r17')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '225' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '55 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R17' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '225/55 R17', '225/55 R17',
            'Anvelope 225/55 R17', 'Шины 225/55 R17', 'anvelope-225-55-r17',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 19, 0,
            'Anvelope 225/55 R17 – preț bun, rate 0% | Fantastic.md',
            'Шины 225/55 R17 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 225/55 R17 pentru sedanuri mari și crossovere: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 225/55 R17 для больших седанов и кроссоверов: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 235/45 R18 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-235-45-r18')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '235' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '45 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R18' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '235/45 R18', '235/45 R18',
            'Anvelope 235/45 R18', 'Шины 235/45 R18', 'anvelope-235-45-r18',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 20, 0,
            'Anvelope 235/45 R18 – preț bun, rate 0% | Fantastic.md',
            'Шины 235/45 R18 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 235/45 R18 pentru sedanuri și coupe-uri de clasă superioară: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 235/45 R18 для седанов и купе высокого класса: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 235/60 R18 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-235-60-r18')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '235' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '60 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R18' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '235/60 R18', '235/60 R18',
            'Anvelope 235/60 R18', 'Шины 235/60 R18', 'anvelope-235-60-r18',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 21, 0,
            'Anvelope 235/60 R18 – preț bun, rate 0% | Fantastic.md',
            'Шины 235/60 R18 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 235/60 R18 pentru SUV-uri de clasă medie: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 235/60 R18 для внедорожников среднего класса: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 245/45 R18 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-245-45-r18')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '245' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '45 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R18' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '245/45 R18', '245/45 R18',
            'Anvelope 245/45 R18', 'Шины 245/45 R18', 'anvelope-245-45-r18',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 22, 0,
            'Anvelope 245/45 R18 – preț bun, rate 0% | Fantastic.md',
            'Шины 245/45 R18 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 245/45 R18 pentru sedanuri premium și sportive: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 245/45 R18 для премиальных и спортивных седанов: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 235/50 R19 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-235-50-r19')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '235' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '50 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R19' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '235/50 R19', '235/50 R19',
            'Anvelope 235/50 R19', 'Шины 235/50 R19', 'anvelope-235-50-r19',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 23, 0,
            'Anvelope 235/50 R19 – preț bun, rate 0% | Fantastic.md',
            'Шины 235/50 R19 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 235/50 R19 pentru crossovere și SUV-uri moderne: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 235/50 R19 для современных кроссоверов и внедорожников: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 235/55 R19 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-235-55-r19')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '235' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '55 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R19' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '235/55 R19', '235/55 R19',
            'Anvelope 235/55 R19', 'Шины 235/55 R19', 'anvelope-235-55-r19',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 24, 0,
            'Anvelope 235/55 R19 – preț bun, rate 0% | Fantastic.md',
            'Шины 235/55 R19 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 235/55 R19 pentru SUV-uri și crossovere premium: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 235/55 R19 для премиальных кроссоверов и внедорожников: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

/* 195/55 R20 */
EXECUTE BLOCK AS
DECLARE W INTEGER;
DECLARE H INTEGER;
DECLARE D INTEGER;
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM TWEB_CATALOG_VIRTUAL
                   WHERE CATALOGID = 1940 AND REWRITE_URL = 'anvelope-195-55-r20')) THEN
    BEGIN
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1247 AND TRIM(PARAM_VALUE) = '195' INTO :W;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1259 AND TRIM(PARAM_VALUE) = '55 %' INTO :H;
        SELECT MIN(FILTERPARAMID) FROM TS_FILTER_PARAMS
         WHERE FILTERID = 1249 AND TRIM(PARAM_VALUE) = 'R20' INTO :D;

        INSERT INTO TWEB_CATALOG_VIRTUAL (
            CATALOGID, TITLE_ROM, TITLE_RUS, H1_ROM, H1_RUS, REWRITE_URL,
            FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS,
            META_TITLE_ROM, META_TITLE_RUS, META_DESCRIPTION_ROM, META_DESCRIPTION_RUS)
        VALUES (
            1940, '195/55 R20', '195/55 R20',
            'Anvelope 195/55 R20', 'Шины 195/55 R20', 'anvelope-195-55-r20',
            1247, :W || ';1259(' || :H || ');1249(' || :D || ')', 25, 0,
            'Anvelope 195/55 R20 – preț bun, rate 0% | Fantastic.md',
            'Шины 195/55 R20 – цены, рассрочка 0% | Fantastic.md',
            'Anvelope 195/55 R20 pentru crossovere electrice și hibride: vară, iarnă și all-season. Rate 0%, garanție și livrare rapidă în Moldova – Fantastic.md.',
            'Шины 195/55 R20 для электрических и гибридных кроссоверов: летние, зимние и всесезонные. Рассрочка 0%, гарантия, быстрая доставка по Молдове – Fantastic.md.');
    END
END^

SET TERM ; ^

COMMIT;

/* === Verificare ========================================================= */
SELECT ID, TITLE_ROM, REWRITE_URL, FILTERID, FILTERPARAMIDS, ORDERNO, FLAGS
FROM TWEB_CATALOG_VIRTUAL
WHERE CATALOGID = 1940
ORDER BY ORDERNO, ID;
/* asteptat: cele 3 mape de sezon existente + 16 mape de marimi (FLAGS = 0) */

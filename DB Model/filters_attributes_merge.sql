/* ------------------------------------------------------------------------
   Etapa 1 din plan_migrare_atribute_in_filtre.md
   Filtrele preiau functionalul atributelor.

   Ce face scriptul:
     1. adauga pe TS_FILTERS coloanele-flag care existau doar pe TS_ATTRIBUTE;
     2. creeaza TS_GOODS_TYPE_FILTERS - sablonul de filtre al unui tip de produs
        (legatura N:M, fiindca un filtru e folosit in medie de 7 tipuri, maxim 394).

   Scriptul e RE-RULABIL: fiecare obiect se creeaza doar daca lipseste.
   Nu modifica si nu sterge date existente - doar adauga.

   Firebird 5.0.4 de pe 192.168.106.254 NU accepta "CREATE TABLE IF NOT EXISTS",
   de aceea totul trece prin EXECUTE BLOCK cu verificare in RDB$.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

/* === 1. Coloane noi pe TS_FILTERS ====================================== */

EXECUTE BLOCK AS
DECLARE VARIABLE SQL_TEXT VARCHAR(512);
DECLARE VARIABLE COL VARCHAR(31);
DECLARE VARIABLE DEF VARCHAR(128);
BEGIN
    FOR SELECT * FROM (
            /* 0 = doar caracteristica afisata, nu apare ca filtru pe site */
            SELECT 'FLG_FILTERABLE' AS C, 'SMALLINT DEFAULT 1'   AS D FROM RDB$DATABASE
      UNION ALL SELECT 'FLG_VARIATION',    'SMALLINT DEFAULT 0'       FROM RDB$DATABASE
      UNION ALL SELECT 'FLG_IN_NAME',      'SMALLINT DEFAULT 0'       FROM RDB$DATABASE
      UNION ALL SELECT 'FLG_MULTI',        'SMALLINT DEFAULT 0'       FROM RDB$DATABASE
      UNION ALL SELECT 'FLG_FREE_VALUE',   'SMALLINT DEFAULT 0'       FROM RDB$DATABASE
      UNION ALL SELECT 'UOM_RO',           'VARCHAR(64)'              FROM RDB$DATABASE
      UNION ALL SELECT 'UOM_RU',           'VARCHAR(64)'              FROM RDB$DATABASE
      UNION ALL SELECT 'DEFAULT_PARAMID',  'INTEGER'                  FROM RDB$DATABASE
        ) INTO :COL, :DEF
    DO
    BEGIN
        IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                       WHERE RDB$RELATION_NAME = 'TS_FILTERS'
                         AND RDB$FIELD_NAME = :COL)) THEN
        BEGIN
            SQL_TEXT = 'ALTER TABLE TS_FILTERS ADD ' || :COL || ' ' || :DEF;
            EXECUTE STATEMENT :SQL_TEXT;
        END
    END
END^


/* === 2. Sablonul de filtre pe tip de produs ============================= */

EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS
                   WHERE RDB$RELATION_NAME = 'TS_GOODS_TYPE_FILTERS')) THEN
        EXECUTE STATEMENT
            'CREATE TABLE TS_GOODS_TYPE_FILTERS (
                 GOODSTYPEID     INTEGER  NOT NULL,
                 FILTERID        INTEGER  NOT NULL,
                 ORDERNO         INTEGER,
                 FLG_RECOMMENDED SMALLINT DEFAULT 0,
                 FLG_AUTO        SMALLINT DEFAULT 0,
                 COVERAGE_PCT    NUMERIC(5,1),
                 CREATED_BY      INTEGER,
                 CREATED_DATE    TIMESTAMP)';
END^

SET TERM ; ^

COMMIT;

SET TERM ^ ;

/* cheia primara */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE RDB$RELATION_NAME = 'TS_GOODS_TYPE_FILTERS'
                     AND RDB$CONSTRAINT_TYPE = 'PRIMARY KEY')) THEN
        EXECUTE STATEMENT
            'ALTER TABLE TS_GOODS_TYPE_FILTERS
                 ADD CONSTRAINT PK_TS_GOODS_TYPE_FILTERS
                 PRIMARY KEY (GOODSTYPEID, FILTERID)';
END^

/* chei straine */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE RDB$CONSTRAINT_NAME = 'FK_TS_GTF_GOODSTYPE')) THEN
        EXECUTE STATEMENT
            'ALTER TABLE TS_GOODS_TYPE_FILTERS
                 ADD CONSTRAINT FK_TS_GTF_GOODSTYPE
                 FOREIGN KEY (GOODSTYPEID) REFERENCES TS_GOODS_TYPE (GOODSTYPEID)
                 ON DELETE CASCADE';

    IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_CONSTRAINTS
                   WHERE RDB$CONSTRAINT_NAME = 'FK_TS_GTF_FILTER')) THEN
        EXECUTE STATEMENT
            'ALTER TABLE TS_GOODS_TYPE_FILTERS
                 ADD CONSTRAINT FK_TS_GTF_FILTER
                 FOREIGN KEY (FILTERID) REFERENCES TS_FILTERS (FILTERID)
                 ON DELETE CASCADE';
END^

/* index pentru intrebarea inversa: in ce tipuri apare filtrul X
   (FK-ul pe FILTERID creeaza deja un index, deci nu mai adaugam altul) */

/* trigger: completeaza automat autorul si data */
EXECUTE BLOCK AS
BEGIN
    IF (NOT EXISTS(SELECT 1 FROM RDB$TRIGGERS
                   WHERE RDB$TRIGGER_NAME = 'TRG_TS_GOODS_TYPE_FILTERS_BI')) THEN
        EXECUTE STATEMENT
            'CREATE TRIGGER TRG_TS_GOODS_TYPE_FILTERS_BI FOR TS_GOODS_TYPE_FILTERS
             ACTIVE BEFORE INSERT POSITION 0
             AS
             BEGIN
                 IF (NEW.CREATED_DATE IS NULL) THEN
                     NEW.CREATED_DATE = CURRENT_TIMESTAMP;
                 IF (NEW.CREATED_BY IS NULL) THEN
                     NEW.CREATED_BY = COALESCE(
                         RDB$GET_CONTEXT(''USER_SESSION'', ''UserID''), 204);
                 IF (NEW.ORDERNO IS NULL) THEN
                     SELECT COALESCE(MAX(ORDERNO), 0) + 1
                       FROM TS_GOODS_TYPE_FILTERS
                      WHERE GOODSTYPEID = NEW.GOODSTYPEID
                       INTO NEW.ORDERNO;
             END';
END^

SET TERM ; ^

COMMIT;


/* === 3. Verificare ===================================================== */

SELECT COUNT(*) AS COLOANE_NOI_PE_TS_FILTERS
FROM RDB$RELATION_FIELDS
WHERE RDB$RELATION_NAME = 'TS_FILTERS'
  AND RDB$FIELD_NAME IN ('FLG_FILTERABLE','FLG_VARIATION','FLG_IN_NAME','FLG_MULTI',
                         'FLG_FREE_VALUE','UOM_RO','UOM_RU','DEFAULT_PARAMID');
/* asteptat: 8 */

SELECT COUNT(*) AS TABELA_SABLON
FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_GOODS_TYPE_FILTERS';
/* asteptat: 1 */

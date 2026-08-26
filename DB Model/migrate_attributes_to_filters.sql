/* ------------------------------------------------------------------------
   Etapa 3 din plan_migrare_atribute_in_filtre.md
   Muta cele 17 atribute (prototip) in sistemul de filtre.

   Se migreaza DOAR atributele care au continut: macar o valoare in dictionar
   sau macar o valoare pusa pe un produs. Cele complet goale (`teswt` si cele 6
   ale tipului 1678, create de proba) se ignora - nu are rost sa umplem
   dictionarul de filtre cu ele.

   Alegerea filtrului tinta, in ordine:
     1. un filtru cu ACELASI nume, DEJA folosit la produsele aceluiasi tip
        (asa nu confundam `Culoare` de la un tip cu alt `Culoare` - in baza sunt
        37 de filtre cu acest nume si 113 cu numele `Tip`);
     2. daca nu exista, se creeaza un filtru nou.

   Scriptul e RE-RULABIL: fiecare inserare e protejata de un test de existenta.

   Punctul sensibil (R2 din plan): TS_GOODS_ATTRIBUTE tine valoarea ca TEXT, iar
   TS_GOODS_FILTERS tine FILTERPARAMID. Pentru fiecare valoare de produs se cauta
   parametrul dupa text si, daca lipseste, se creeaza. Volumul e mic (13 randuri),
   deci rezultatul se verifica manual la final.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

EXECUTE BLOCK AS
DECLARE VARIABLE AID    INTEGER;
DECLARE VARIABLE TIP    INTEGER;
DECLARE VARIABLE N_RO   VARCHAR(256);
DECLARE VARIABLE N_RU   VARCHAR(256);
DECLARE VARIABLE F_MULTI    SMALLINT;
DECLARE VARIABLE F_INNAME   SMALLINT;
DECLARE VARIABLE F_VAR      SMALLINT;
DECLARE VARIABLE F_REC      SMALLINT;
DECLARE VARIABLE U_RO   VARCHAR(64);
DECLARE VARIABLE U_RU   VARCHAR(64);
DECLARE VARIABLE FID    INTEGER;
DECLARE VARIABLE PID    INTEGER;
DECLARE VARIABLE GID    INTEGER;
DECLARE VARIABLE V_RO   VARCHAR(256);
DECLARE VARIABLE V_RU   VARCHAR(256);
DECLARE VARIABLE UID    INTEGER;
DECLARE VARIABLE ORD    INTEGER;
BEGIN
    /* TS_FILTER_PARAMS.CREATED_BY si TS_GOODS_FILTERS.CREATEDBY sunt NOT NULL,
       iar triggerul le ia din contextul sesiunii - care lipseste cand scriptul
       ruleaza din isql. Folosim acelasi fallback ca restul bazei (204). */
    UID = CAST(COALESCE(RDB$GET_CONTEXT('USER_SESSION', 'UserID'), '204') AS INTEGER);
    FOR SELECT a.ATTRID, a.GOODS_TYPE_ID, a.NAME_RO, a.NAME_RU,
               COALESCE(a.FLG_MULTI, 0), COALESCE(a.FLG_IN_NAME, 0),
               COALESCE(a.FLG_VARIATION, 0), COALESCE(a.FLG_RECOMMENDED, 0),
               a.UOM_RO, a.UOM_RU
          FROM TS_ATTRIBUTE a
         WHERE (EXISTS(SELECT 1 FROM TS_ATTRIBUTE_VALUE v  WHERE v.ATTRID  = a.ATTRID)
             OR EXISTS(SELECT 1 FROM TS_GOODS_ATTRIBUTE ga WHERE ga.ATTRID = a.ATTRID))
           AND a.NAME_RO IS NOT NULL
          INTO :AID, :TIP, :N_RO, :N_RU, :F_MULTI, :F_INNAME, :F_VAR, :F_REC, :U_RO, :U_RU
    DO
    BEGIN
        /* 1. filtru omonim deja folosit la acest tip de produs */
        SELECT MIN(f.FILTERID)
          FROM TS_FILTERS f
         WHERE UPPER(TRIM(f.FILTERNAME)) = UPPER(TRIM(:N_RO))
           AND COALESCE(f.FLG_FOLDER, 0) = 0
           AND EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf
                      JOIN TS_GOODS g ON g.GOODSID = gf.GOODSID
                       WHERE gf.FILTERID = f.FILTERID
                         AND g.WEBGOODSTYPE_ID = :TIP)
          INTO :FID;

        IF (FID IS NULL) THEN
        BEGIN
            INSERT INTO TS_FILTERS (FILTERNAME, FILTERNAME_RUS, FLG_FOLDER, PARENTID,
                                    FLG_FILTERABLE, FLG_MULTI, FLG_IN_NAME,
                                    FLG_VARIATION, UOM_RO, UOM_RU)
            VALUES (:N_RO, COALESCE(:N_RU, :N_RO), 0, 0,
                    1, :F_MULTI, :F_INNAME, :F_VAR, :U_RO, :U_RU)
            RETURNING FILTERID INTO :FID;
        END
        ELSE
        BEGIN
            /* filtru existent: doar completam flag-urile care lipsesc, nu suprascriem */
            UPDATE TS_FILTERS
               SET FLG_MULTI     = COALESCE(FLG_MULTI, :F_MULTI),
                   FLG_IN_NAME   = COALESCE(FLG_IN_NAME, :F_INNAME),
                   FLG_VARIATION = COALESCE(FLG_VARIATION, :F_VAR),
                   UOM_RO        = COALESCE(UOM_RO, :U_RO),
                   UOM_RU        = COALESCE(UOM_RU, :U_RU)
             WHERE FILTERID = :FID;
        END

        /* 2. dictionarul de valori */
        FOR SELECT v.VALUE_RO, v.VALUE_RU
              FROM TS_ATTRIBUTE_VALUE v
             WHERE v.ATTRID = :AID AND v.VALUE_RO IS NOT NULL
              INTO :V_RO, :V_RU
        DO
        BEGIN
            IF (NOT EXISTS(SELECT 1 FROM TS_FILTER_PARAMS p
                            WHERE p.FILTERID = :FID
                              AND UPPER(TRIM(p.PARAM_VALUE)) = UPPER(TRIM(:V_RO)))) THEN
                INSERT INTO TS_FILTER_PARAMS (FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY)
                VALUES (:FID, :V_RO, COALESCE(:V_RU, :V_RO), :UID);
        END

        /* 3. valorile puse pe produse (text -> FILTERPARAMID) */
        FOR SELECT ga.GOODSID, ga.VALUE_RO, ga.VALUE_RU
              FROM TS_GOODS_ATTRIBUTE ga
             WHERE ga.ATTRID = :AID AND ga.VALUE_RO IS NOT NULL
              INTO :GID, :V_RO, :V_RU
        DO
        BEGIN
            SELECT MIN(p.FILTERPARAMID)
              FROM TS_FILTER_PARAMS p
             WHERE p.FILTERID = :FID
               AND UPPER(TRIM(p.PARAM_VALUE)) = UPPER(TRIM(:V_RO))
              INTO :PID;

            IF (PID IS NULL) THEN
                INSERT INTO TS_FILTER_PARAMS (FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY)
                VALUES (:FID, :V_RO, COALESCE(:V_RU, :V_RO), :UID)
                RETURNING FILTERPARAMID INTO :PID;

            IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_FILTERS gf
                            WHERE gf.GOODSID = :GID
                              AND gf.FILTERID = :FID
                              AND gf.FILTERPARAMID = :PID)) THEN
            BEGIN
                SELECT COALESCE(MAX(gf.ORDERNO), 0) + 1
                  FROM TS_GOODS_FILTERS gf
                 WHERE gf.GOODSID = :GID AND gf.FILTERID = :FID
                  INTO :ORD;

                INSERT INTO TS_GOODS_FILTERS
                       (GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY)
                VALUES (:GID, :FID, :PID, :ORD, 0, :UID);
            END
        END

        /* 4. filtrul intra in sablonul tipului; FLG_AUTO = 0 -> generatorul nu-l atinge */
        IF (NOT EXISTS(SELECT 1 FROM TS_GOODS_TYPE_FILTERS t
                        WHERE t.GOODSTYPEID = :TIP AND t.FILTERID = :FID)) THEN
            INSERT INTO TS_GOODS_TYPE_FILTERS
                   (GOODSTYPEID, FILTERID, FLG_RECOMMENDED, FLG_AUTO)
            VALUES (:TIP, :FID, :F_REC, 0);
    END
END^

SET TERM ; ^

COMMIT;


/* === Verificare ======================================================== */

/* Fiecare atribut cu continut trebuie sa aiba acum un filtru corespondent */
SELECT a.ATTRID, a.GOODS_TYPE_ID, a.NAME_RO,
       (SELECT COUNT(*) FROM TS_GOODS_ATTRIBUTE ga WHERE ga.ATTRID = a.ATTRID) VALORI_ATRIBUT,
       (SELECT COUNT(*) FROM TS_GOODS_TYPE_FILTERS t
         JOIN TS_FILTERS f ON f.FILTERID = t.FILTERID
        WHERE t.GOODSTYPEID = a.GOODS_TYPE_ID
          AND UPPER(TRIM(f.FILTERNAME)) = UPPER(TRIM(a.NAME_RO))) IN_SABLON
FROM TS_ATTRIBUTE a
WHERE EXISTS(SELECT 1 FROM TS_ATTRIBUTE_VALUE v  WHERE v.ATTRID  = a.ATTRID)
   OR EXISTS(SELECT 1 FROM TS_GOODS_ATTRIBUTE ga WHERE ga.ATTRID = a.ATTRID)
ORDER BY a.GOODS_TYPE_ID, a.ATTRID;

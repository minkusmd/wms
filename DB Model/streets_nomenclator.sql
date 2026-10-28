/* ============================================================================
   streets_nomenclator.sql

   Scop: nomenclatorul strazilor pentru adresa de livrare. In or. Chisinau
   strada se alege obligatoriu din lista (nu text liber), iar sectorul NU il
   alege clientul: se deduce din strada si numarul casei. Vezi prototipul
   Documents/forma-adresa-livrare-2026-10-24.html. Pana acum baza nu avea
   strazi deloc: adresa era TS_SYSS (raion PARENTID=3, localitate PARENTID=2)
   + un camp text de 128 de caractere.

   Acest script:
     1. creeaza tabelele
          TS_STREETS         strada, legata de localitatea din TS_SYSS, cu
                             sectorul principal (cel cu cele mai multe case);
          TS_STREET_SECTORS  prin ce sectoare trece strada (85 de strazi trec
                             prin mai multe: str. Ismail = Centru, Ciocana, Riscani);
          TS_STREET_HOUSES   casele (numar + sector + coordonate) - din ele se
                             afla sectorul la strazile din mai multe sectoare si
                             adresa dupa locatia GPS a telefonului;
     2. secventa SQ_TS_STREETS + triggere;
     3. view-ul VW_TS_STREETS (lista pentru site/WMS);
     4. procedurile
          SP_STREET_SECTOR(STREETID, HOUSENO)  -> SECTORID, HOW
          WEB_NEAREST_HOUSE(LAT, LON, MAX_M)   -> cea mai apropiata casa;
     5. importa 851 de strazi ale or. Chisinau (CITYID = 2000) si
        941 de legaturi strada-sector.
   Casele (28668) sint in scriptul separat streets_houses.sql - rulati-l
   DUPA acesta.

   Sursa datelor: OpenStreetMap (Overpass API, 24.10.2026):
     - strazile cu nume (highway=*, fara alei pietonale/poteci) din granita
       or. Chisinau (relatia OSM 1748490) - ID 1..805;
     - adresele caselor (addr:street + addr:housenumber), impartite pe
       sectoarele administrative (relatiile 1813306 Botanica, 1813297 Buiucani,
       58512 Centru, 1813315 Ciocana, 1813316 Riscani); strazile care apar doar
       in adrese, fara drum cartografiat, au ID 806..851.
   Datele OSM sint sub licenta ODbL: pe site trebuie mentiunea
   "(c) OpenStreetMap contributors" (ex. linga lista de strazi).

   TS_STREETS:
     STREET_TYPE  tipul complet, ca in OSM: Strada, Stradela, Bulevardul,
                  Soseaua, Piata (cu diacritice)
     SHORT_TYPE   prescurtarea afisata: str., str-la, bd., sos., p-ta
     TITLE        denumirea fara tip: "Ismail", "Calea Iesilor"
     TITLE_RUS    denumirea rusa din OSM (name:ru), poate lipsi
     SECTORID     sectorul principal - folosit cind numarul casei lipseste
     SRC_NAME     numele complet din sursa ("Strada Ismail") - cheia de
                  resincronizare cu OSM
     IS_ACTIVE    0 = ascunsa din lista (nu se sterge: comenzile vechi o refera)
   TS_STREET_HOUSES:
     HOUSENO      numarul cum e scris ("100/2", "1/A")
     HOUSE_KEY    numarul normalizat (litere mici, fara spatii) - cheia
     HOUSE_NUM    numarul de la inceput (100/2 -> 100), pentru vecinul cel
                  mai apropiat pe aceeasi parte a strazii (aceeasi paritate)
     LAT, LON     centrul cladirii (WGS84)

   Sectoarele sint localitatile-sector din TS_SYSS ale mun. Chisinau
   (3668 Ciocana, 3669 Buiucani, 3670 Botanica, 3671 Centru, 3674 Riscani);
   in comanda, CITYID = sectorul, ca pina acum. Posta Veche (3673) si
   Telecentru (3672) nu sint sectoare administrative, deci nu apar aici.

   Fara FK spre TS_SYSS (tabela fierbinte, FK-ul cere acces exclusiv la ea);
   FK doar intre tabelele noi.

   STREETID-urile importate sint fixe (1..851) si coincid cu streetId din
   prototip. Strazile adaugate ulterior din WMS primesc ID din SQ_TS_STREETS
   (repornita peste maxim).

   Re-rulabil: CREATE conditionat, UPDATE OR INSERT ... MATCHING. ATENTIE: la
   re-rulare, denumirile corectate manual pentru ID-urile 1..851 revin
   la cele din OSM.

   Fisierul este UTF-8 (denumiri cu diacritice si in rusa) - rulati cu -ch UTF8:
   isql -user SYSDBA -password <parola> -ch UTF8 "<host>/3050:SW" -i streets_nomenclator.sql
   isql -user SYSDBA -password <parola> -ch UTF8 "<host>/3050:SW" -i streets_houses.sql
   Anulare: streets_nomenclator_rollback.sql
============================================================================ */

SET TERM ^ ;

/* --- 1. Tabele + secventa ------------------------------------------------ */
EXECUTE BLOCK
AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_STREETS')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TS_STREETS (
         STREETID     INTEGER      NOT NULL,
         CITYID       INTEGER      NOT NULL,
         STREET_TYPE  VARCHAR(20)  NOT NULL,
         SHORT_TYPE   VARCHAR(10)  NOT NULL,
         TITLE        VARCHAR(100) NOT NULL,
         TITLE_RUS    VARCHAR(150),
         SECTORID     INTEGER,
         SRC_NAME     VARCHAR(150),
         IS_ACTIVE    SMALLINT     DEFAULT 1 NOT NULL,
         CREATED_AT   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
         CONSTRAINT PK_TS_STREETS PRIMARY KEY (STREETID),
         CONSTRAINT UQ_TS_STREETS_NAME UNIQUE (CITYID, STREET_TYPE, TITLE),
         CONSTRAINT CHK_TS_STREETS_ACTIVE CHECK (IS_ACTIVE IN (0, 1))
       )';

  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_STREET_SECTORS')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TS_STREET_SECTORS (
         STREETID  INTEGER NOT NULL,
         SECTORID  INTEGER NOT NULL,
         CONSTRAINT PK_TS_STREET_SECTORS PRIMARY KEY (STREETID, SECTORID),
         CONSTRAINT FK_TS_STREET_SECTORS_STREET FOREIGN KEY (STREETID)
           REFERENCES TS_STREETS (STREETID) ON DELETE CASCADE
       )';

  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TS_STREET_HOUSES')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TS_STREET_HOUSES (
         STREETID   INTEGER      NOT NULL,
         HOUSE_KEY  VARCHAR(20)  NOT NULL,
         HOUSENO    VARCHAR(20)  NOT NULL,
         HOUSE_NUM  INTEGER,
         SECTORID   INTEGER      NOT NULL,
         LAT        NUMERIC(9,6),
         LON        NUMERIC(9,6),
         CONSTRAINT PK_TS_STREET_HOUSES PRIMARY KEY (STREETID, HOUSE_KEY),
         CONSTRAINT FK_TS_STREET_HOUSES_STREET FOREIGN KEY (STREETID)
           REFERENCES TS_STREETS (STREETID) ON DELETE CASCADE
       )';

  IF (NOT EXISTS (SELECT 1 FROM RDB$INDICES WHERE RDB$INDEX_NAME = 'IX_TS_STREET_HOUSES_LAT')) THEN
    EXECUTE STATEMENT 'CREATE INDEX IX_TS_STREET_HOUSES_LAT ON TS_STREET_HOUSES (LAT)';

  IF (NOT EXISTS (SELECT 1 FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = 'SQ_TS_STREETS')) THEN
    EXECUTE STATEMENT 'CREATE SEQUENCE SQ_TS_STREETS';
END^

/* tabelele create prin EXECUTE STATEMENT devin vizibile triggerelor abia dupa commit */
COMMIT^

/* --- 2. Triggere + view -------------------------------------------------- */
CREATE OR ALTER TRIGGER TRG_TS_STREETS_BI FOR TS_STREETS
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
BEGIN
  IF (NEW.STREETID IS NULL) THEN NEW.STREETID = NEXT VALUE FOR SQ_TS_STREETS;
  NEW.TITLE = TRIM(NEW.TITLE);
  NEW.TITLE_RUS = NULLIF(TRIM(NEW.TITLE_RUS), '');
END^

/* cheia si numarul se calculeaza din HOUSENO si la adaugarea manuala din WMS */
CREATE OR ALTER TRIGGER TRG_TS_STREET_HOUSES_BI FOR TS_STREET_HOUSES
ACTIVE BEFORE INSERT OR UPDATE POSITION 0
AS
  DECLARE VARIABLE I INTEGER;
  DECLARE VARIABLE C CHAR(1);
BEGIN
  NEW.HOUSENO = TRIM(NEW.HOUSENO);
  NEW.HOUSE_KEY = REPLACE(LOWER(NEW.HOUSENO), ' ', '');
  NEW.HOUSE_NUM = NULL;
  I = 1;
  WHILE (I <= CHAR_LENGTH(NEW.HOUSE_KEY)) DO
  BEGIN
    C = SUBSTRING(NEW.HOUSE_KEY FROM I FOR 1);
    IF (C NOT BETWEEN '0' AND '9') THEN LEAVE;
    NEW.HOUSE_NUM = COALESCE(NEW.HOUSE_NUM, 0) * 10 + CAST(C AS INTEGER);
    I = I + 1;
  END
END^

CREATE OR ALTER VIEW VW_TS_STREETS (
  STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, FULL_TITLE, SECTORID, SECTORS
) AS
SELECT S.STREETID, S.CITYID, S.STREET_TYPE, S.SHORT_TYPE, S.TITLE, S.TITLE_RUS,
       S.SHORT_TYPE || ' ' || S.TITLE, S.SECTORID,
       CAST((SELECT LIST(SS.SECTORID) FROM TS_STREET_SECTORS SS WHERE SS.STREETID = S.STREETID) AS VARCHAR(100))
FROM TS_STREETS S
WHERE S.IS_ACTIVE = 1^

/* --- 3. Proceduri -------------------------------------------------------- */

/* Sectorul adresei. HOW:
     STRADA    strada e intr-un singur sector;
     CASA      casa exista in TS_STREET_HOUSES;
     VECIN     casa cu numarul cel mai apropiat, intii pe aceeasi parte a
               strazii (aceeasi paritate);
     PRINCIPAL fara numar sau fara case cunoscute: TS_STREETS.SECTORID. */
CREATE OR ALTER PROCEDURE SP_STREET_SECTOR (
  STREETID INTEGER,
  HOUSENO  VARCHAR(20))
RETURNS (
  SECTORID INTEGER,
  HOW      VARCHAR(10))
AS
  DECLARE VARIABLE K VARCHAR(20);
  DECLARE VARIABLE N INTEGER;
  DECLARE VARIABLE I INTEGER;
  DECLARE VARIABLE C CHAR(1);
BEGIN
  SECTORID = NULL;
  HOW = NULL;

  IF ((SELECT COUNT(*) FROM TS_STREET_SECTORS WHERE STREETID = :STREETID) = 1) THEN
  BEGIN
    SELECT SECTORID FROM TS_STREET_SECTORS WHERE STREETID = :STREETID INTO :SECTORID;
    HOW = 'STRADA';
    SUSPEND;
    EXIT;
  END

  K = REPLACE(LOWER(TRIM(COALESCE(:HOUSENO, ''))), ' ', '');
  IF (K <> '') THEN
  BEGIN
    SELECT FIRST 1 SECTORID FROM TS_STREET_HOUSES
    WHERE STREETID = :STREETID AND HOUSE_KEY = :K
    INTO :SECTORID;
    IF (SECTORID IS NOT NULL) THEN
    BEGIN
      HOW = 'CASA';
      SUSPEND;
      EXIT;
    END

    /* numarul de la inceput: "12/3A" -> 12 */
    N = NULL;
    I = 1;
    WHILE (I <= CHAR_LENGTH(K)) DO
    BEGIN
      C = SUBSTRING(K FROM I FOR 1);
      IF (C NOT BETWEEN '0' AND '9') THEN LEAVE;
      N = COALESCE(N, 0) * 10 + CAST(C AS INTEGER);
      I = I + 1;
    END

    IF (N IS NOT NULL) THEN
    BEGIN
      SELECT FIRST 1 SECTORID FROM TS_STREET_HOUSES
      WHERE STREETID = :STREETID AND HOUSE_NUM IS NOT NULL
      ORDER BY IIF(MOD(HOUSE_NUM, 2) = MOD(:N, 2), 0, 1), ABS(HOUSE_NUM - :N)
      INTO :SECTORID;
      IF (SECTORID IS NOT NULL) THEN
      BEGIN
        HOW = 'VECIN';
        SUSPEND;
        EXIT;
      END
    END
  END

  SELECT SECTORID FROM TS_STREETS WHERE STREETID = :STREETID INTO :SECTORID;
  IF (SECTORID IS NOT NULL) THEN HOW = 'PRINCIPAL';
  SUSPEND;
END^

/* Cea mai apropiata casa cunoscuta de punctul GPS (telefonul clientului),
   cel mult MAX_M metri; nimic daca nu e niciuna (ex. in afara Chisinaului). */
CREATE OR ALTER PROCEDURE WEB_NEAREST_HOUSE (
  LAT   DOUBLE PRECISION,
  LON   DOUBLE PRECISION,
  MAX_M INTEGER = 150)
RETURNS (
  STREETID   INTEGER,
  FULL_TITLE VARCHAR(120),
  HOUSENO    VARCHAR(20),
  SECTORID   INTEGER,
  DIST_M     INTEGER)
AS
  DECLARE VARIABLE K    DOUBLE PRECISION;
  DECLARE VARIABLE DLAT DOUBLE PRECISION;
  DECLARE VARIABLE DLON DOUBLE PRECISION;
BEGIN
  K = COS(:LAT * PI() / 180);
  /* in dialectul 3, INTEGER / 111320.0 ar fi NUMERIC cu o zecimala (= 0) */
  DLAT = CAST(:MAX_M AS DOUBLE PRECISION) / 111320;
  DLON = DLAT / K;
  SELECT FIRST 1 H.STREETID, S.SHORT_TYPE || ' ' || S.TITLE, H.HOUSENO, H.SECTORID,
         CAST(SQRT(POWER((H.LAT - :LAT) * 111320, 2) + POWER((H.LON - :LON) * 111320 * :K, 2)) AS INTEGER)
  FROM TS_STREET_HOUSES H
  JOIN TS_STREETS S ON S.STREETID = H.STREETID AND S.IS_ACTIVE = 1
  WHERE H.LAT BETWEEN :LAT - :DLAT AND :LAT + :DLAT
    AND H.LON BETWEEN :LON - :DLON AND :LON + :DLON
  ORDER BY 5
  INTO :STREETID, :FULL_TITLE, :HOUSENO, :SECTORID, :DIST_M;
  IF (STREETID IS NOT NULL AND DIST_M <= MAX_M) THEN SUSPEND;
END^

COMMIT^

SET TERM ; ^

/* --- 4. Import: strazile or. Chisinau (851) -------------------------------- */
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (1, 2000, 'Stradela', 'str-la', '1 Balcani', '1-й Балканский переулок', 3669, 'Stradela 1 Balcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (2, 2000, 'Stradela', 'str-la', '1 Carierei', '1-й Кариерный переулок', 3674, 'Stradela 1 Carierei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (3, 2000, 'Stradela', 'str-la', '1 Caucaz', '1-й Кавказский переулок', 3671, 'Stradela 1 Caucaz') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (4, 2000, 'Stradela', 'str-la', '1 Ciocârliei', '1-й переулок Чокырлией', 3671, 'Stradela 1 Ciocârliei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (5, 2000, 'Stradela', 'str-la', '1 Ciocîrliei', '1-й переулок Н. Смокинэ', 3671, 'Stradela 1 Ciocîrliei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (6, 2000, 'Stradela', 'str-la', '1 Circului', '1-й переулок Чиркулуй', 3674, 'Stradela 1 Circului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (7, 2000, 'Stradela', 'str-la', '1 Cramei', '1-й переулок Крамей', 3674, 'Stradela 1 Cramei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (8, 2000, 'Stradela', 'str-la', '1 Drumul Schinoasei', '2-й переулок Друмул Скиноасей', 3671, 'Stradela 1 Drumul Schinoasei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (9, 2000, 'Stradela', 'str-la', '1 Florării', '1-й переулок Флорэрий', 3674, 'Stradela 1 Florării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (10, 2000, 'Stradela', 'str-la', '1 Lvov', '1-й Львовский переулок', 3670, 'Stradela 1 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (11, 2000, 'Stradela', 'str-la', '1 Mihail Lermontov', '1-й переулок Лермонтова', 3671, 'Stradela 1 Mihail Lermontov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (12, 2000, 'Stradela', 'str-la', '1 Nichita Smochină', '1-й переулок Никиты Смокинэ', 3671, 'Stradela 1 Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (13, 2000, 'Stradela', 'str-la', '1 Olga Vrabie', NULL, 3674, 'Stradela 1 Olga Vrabie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (14, 2000, 'Stradela', 'str-la', '1 Petricani', NULL, 3674, 'Stradela 1 Petricani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (15, 2000, 'Stradela', 'str-la', '1 Pictor Ion Jumati', NULL, 3670, 'Stradela 1 Pictor Ion Jumati') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (16, 2000, 'Stradela', 'str-la', '1 Pietrăriei', '1-ый переулок Пьетрэрией', 3674, 'Stradela 1 Pietrăriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (17, 2000, 'Stradela', 'str-la', '2 Aerodromului', NULL, 3674, 'Stradela 2 Aerodromului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (18, 2000, 'Stradela', 'str-la', '2 Carierei', '2-й Кариерный переулок', 3674, 'Stradela 2 Carierei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (19, 2000, 'Stradela', 'str-la', '2 Caucaz', '2-й Кавказский переулок', 3671, 'Stradela 2 Caucaz') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (20, 2000, 'Stradela', 'str-la', '2 Ciocârliei', '2-й переулок Чокирлией', 3671, 'Stradela 2 Ciocârliei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (21, 2000, 'Stradela', 'str-la', '2 Circului', '2-ой переулок Чиркулуй', 3674, 'Stradela 2 Circului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (22, 2000, 'Stradela', 'str-la', '2 Cramei', '2-й переулок Крамей', 3674, 'Stradela 2 Cramei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (23, 2000, 'Stradela', 'str-la', '2 Florării', '2-й переулок Флорэрий', 3674, 'Stradela 2 Florării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (24, 2000, 'Stradela', 'str-la', '2 Lvov', '2-й Львовский переулок', 3670, 'Stradela 2 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (25, 2000, 'Stradela', 'str-la', '2 Molocanilor', '2-й переулок Молоканилор', 3671, 'Stradela 2 Molocanilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (26, 2000, 'Stradela', 'str-la', '2 Muncești', '2-й переулок Мунчешть', 3670, 'Stradela 2 Muncești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (27, 2000, 'Stradela', 'str-la', '2 Nichita Smochină', '2-й переулок Никиты Смокинэ', 3671, 'Stradela 2 Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (28, 2000, 'Stradela', 'str-la', '2 Olga Vrabie', NULL, 3674, 'Stradela 2 Olga Vrabie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (29, 2000, 'Stradela', 'str-la', '2 Petricani', '2-й Петриканский переулок', 3674, 'Stradela 2 Petricani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (30, 2000, 'Stradela', 'str-la', '2 Pietrăriei', '2-ой переулок Пьетрэрией', 3674, 'Stradela 2 Pietrăriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (31, 2000, 'Stradela', 'str-la', '2 Praga', NULL, 3670, 'Stradela 2 Praga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (32, 2000, 'Strada', 'str.', '27 Martie 1918', 'улица 27 Марта 1918', 3669, 'Strada 27 Martie 1918') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (33, 2000, 'Stradela', 'str-la', '3 Caucaz', '3-й Кавказский переулок', 3671, 'Stradela 3 Caucaz') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (34, 2000, 'Stradela', 'str-la', '3 Circului', '3-й переулок Чиркулуй', 3674, 'Stradela 3 Circului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (35, 2000, 'Stradela', 'str-la', '3 Cramei', '3-й переулок Крамей', 3674, 'Stradela 3 Cramei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (36, 2000, 'Stradela', 'str-la', '3 Lvov', '3-й Львовский переулок', 3670, 'Stradela 3 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (37, 2000, 'Stradela', 'str-la', '3 Nichita Smochină', '3-й переулок Никиты Смокинэ', 3671, 'Stradela 3 Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (38, 2000, 'Stradela', 'str-la', '3 Sihastrului', NULL, 3671, 'Stradela 3 Sihastrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (39, 2000, 'Strada', 'str.', '31 August 1989', 'улица 31 Августа 1989', 3671, 'Strada 31 August 1989') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (40, 2000, 'Stradela', 'str-la', '31 August 1989', 'переулок 31 Августа 1989', 3671, 'Stradela 31 August 1989') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (41, 2000, 'Stradela', 'str-la', '4 Lvov', '4-й Львовский переулок', 3670, 'Stradela 4 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (42, 2000, 'Stradela', 'str-la', '4 Nichita Smochină', '4-й переулок Никиты Смокинэ', 3671, 'Stradela 4 Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (43, 2000, 'Stradela', 'str-la', '4 Sihastrului', '4-й переулок Сихаструлуй', 3671, 'Stradela 4 Sihastrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (44, 2000, 'Stradela', 'str-la', '5 Lvov', '5-й Львовский переулок', 3670, 'Stradela 5 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (45, 2000, 'Stradela', 'str-la', '5 Pedologul', NULL, 3671, 'Stradela 5 Pedologul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (46, 2000, 'Stradela', 'str-la', '6 Lvov', '6-й Львовский переулок', 3670, 'Stradela 6 Lvov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (47, 2000, 'Stradela', 'str-la', '6 Odesa', '6-й Одесский переулок', 3671, 'Stradela 6 Odesa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (48, 2000, 'Stradela', 'str-la', '6 Pedologul', NULL, 3671, 'Stradela 6 Pedologul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (49, 2000, 'Stradela', 'str-la', '7 Pedologul', NULL, 3671, 'Stradela 7 Pedologul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (50, 2000, 'Strada', 'str.', '8 Martie', 'улица 8 Марта', 3674, 'Strada 8 Martie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (51, 2000, 'Strada', 'str.', 'Academician Andrei Saharov', 'улица Академика Андрея Сахарова', 3674, 'Strada Academician Andrei Saharov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (52, 2000, 'Strada', 'str.', 'Academician Eugen Coșeriu', 'улица Академика Эуджена Кошериу', 3674, 'Strada Academician Eugen Coșeriu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (53, 2000, 'Strada', 'str.', 'Academician Iachim Grosul', 'улица Академика Якима Гросула', 3671, 'Strada Academician Iachim Grosul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (54, 2000, 'Strada', 'str.', 'Academician Natalia Gheorghiu', 'улица Академика Натальи Георгиу', 3671, 'Strada Academician Natalia Gheorghiu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (55, 2000, 'Strada', 'str.', 'Academician Nicolae Corlăteanu', 'улица Академика Николая Корлэтяну', 3674, 'Strada Academician Nicolae Corlăteanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (56, 2000, 'Strada', 'str.', 'Academician Sergiu Rădăuțanu', 'улица Академика Сергея Рэдэуцану', 3674, 'Strada Academician Sergiu Rădăuțanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (57, 2000, 'Strada', 'str.', 'Academician Silviu Berejan', 'улица Академика Силвиу Бережан', 3674, 'Strada Academician Silviu Berejan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (58, 2000, 'Strada', 'str.', 'Academiei', 'Академическая улица', 3671, 'Strada Academiei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (59, 2000, 'Stradela', 'str-la', 'Actor Chiril Știrbu', 'переулок Актёра Кирилла Штирбу', 3671, 'Stradela Actor Chiril Știrbu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (60, 2000, 'Strada', 'str.', 'Aerodromului', 'Аэродромная улица', 3674, 'Strada Aerodromului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (61, 2000, 'Strada', 'str.', 'Aerogării', 'улица Аерогэрий', 3670, 'Strada Aerogării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (62, 2000, 'Strada', 'str.', 'Aeroport', 'Мунчештское шоссе', 3670, 'Strada Aeroport') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (63, 2000, 'Strada', 'str.', 'Agnesa Roșca', 'улица Агнеса Рошка', 3671, 'Strada Agnesa Roșca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (64, 2000, 'Strada', 'str.', 'Alba Iulia', 'улица Алба Юлия', 3669, 'Strada Alba Iulia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (65, 2000, 'Strada', 'str.', 'Albișoara', 'улица Албишоара', 3674, 'Strada Albișoara') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (66, 2000, 'Strada', 'str.', 'Albița', 'улица Албица', 3670, 'Strada Albița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (67, 2000, 'Strada', 'str.', 'Albăstrele', 'улица Албэстреле', 3668, 'Strada Albăstrele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (68, 2000, 'Strada', 'str.', 'Alcedar', 'улица Алчедар', 3668, 'Strada Alcedar') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (69, 2000, 'Strada', 'str.', 'Alecu Russo', 'улица Алеку Руссо', 3668, 'Strada Alecu Russo') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (70, 2000, 'Strada', 'str.', 'Aleea Gării', 'улица Вокзальная аллея', 3671, 'Strada Aleea Gării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (71, 2000, 'Strada', 'str.', 'Alessandro Bernardazzi', 'улица Алессандро Бернардацци', 3671, 'Strada Alessandro Bernardazzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (72, 2000, 'Strada', 'str.', 'Alexandr Pușkin', 'улица Александра Пушкина', 3674, 'Strada Alexandr Pușkin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (73, 2000, 'Strada', 'str.', 'Alexandru Boldur', 'улица Александру Болдур', 3670, 'Strada Alexandru Boldur') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (74, 2000, 'Strada', 'str.', 'Alexandru Botezatu', 'улица Александру Ботезату', 3674, 'Strada Alexandru Botezatu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (75, 2000, 'Strada', 'str.', 'Alexandru cel Bun', 'улица Александру чел Бун', 3674, 'Strada Alexandru cel Bun') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (76, 2000, 'Strada', 'str.', 'Alexandru Cosmescu', 'улица Александра Козмеску', 3671, 'Strada Alexandru Cosmescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (77, 2000, 'Strada', 'str.', 'Alexandru Cristea', 'улица Александру Кристя', 3670, 'Strada Alexandru Cristea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (78, 2000, 'Strada', 'str.', 'Alexandru Donici', 'улица Александру Донича', 3669, 'Strada Alexandru Donici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (79, 2000, 'Strada', 'str.', 'Alexandru Hâjdeu', 'улица Александра Хыждеу', 3674, 'Strada Alexandru Hâjdeu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (80, 2000, 'Strada', 'str.', 'Alexandru Lăpușneanu', 'улица Александра Лэпушняну', 3669, 'Strada Alexandru Lăpușneanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (81, 2000, 'Strada', 'str.', 'Alexandru Marinescu', 'улица Александру Маринеску', 3669, 'Strada Alexandru Marinescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (82, 2000, 'Strada', 'str.', 'Alexandru Negru-Vodă', 'улица Александру Негру-Водэ', 3670, 'Strada Alexandru Negru-Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (83, 2000, 'Strada', 'str.', 'Alexandru Plămădeală', 'улица Александру Плэмэдялэ', 3669, 'Strada Alexandru Plămădeală') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (84, 2000, 'Strada', 'str.', 'Alexandru Vlăhuță', 'улица Александру Влахуцэ', 3674, 'Strada Alexandru Vlăhuță') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (85, 2000, 'Strada', 'str.', 'Alexandru Xenopol', 'улица Александра Ксенопола', 3669, 'Strada Alexandru Xenopol') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (86, 2000, 'Strada', 'str.', 'Alexei Belski', 'улица Алексея Бельского', 3674, 'Strada Alexei Belski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (87, 2000, 'Strada', 'str.', 'Alexei Mateevici', 'улица Алексея Матеевича', 3671, 'Strada Alexei Mateevici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (88, 2000, 'Strada', 'str.', 'Alexei Șciusev', 'улица Алексея Щусева', 3669, 'Strada Alexei Șciusev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (89, 2000, 'Strada', 'str.', 'Aluniș', 'улица Алуниш', 3669, 'Strada Aluniș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (90, 2000, 'Strada', 'str.', 'Anatol Corobceanu', 'улица Анатолия Коробчану', 3669, 'Strada Anatol Corobceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (91, 2000, 'Strada', 'str.', 'Anatol Popovici', 'улица Анатола Поповича', 3670, 'Strada Anatol Popovici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (92, 2000, 'Strada', 'str.', 'Andrei Ciurunga', 'улица Андрея Чурунга', 3674, 'Strada Andrei Ciurunga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (93, 2000, 'Strada', 'str.', 'Andrei Doga', 'улица Андрея Доги', 3674, 'Strada Andrei Doga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (94, 2000, 'Stradela', 'str-la', 'Andrei Doga', 'переулок Андрея Доги', 3674, 'Stradela Andrei Doga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (95, 2000, 'Strada', 'str.', 'Andrei Izbaș', 'улица Андрея Избаша', 3668, 'Strada Andrei Izbaș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (96, 2000, 'Strada', 'str.', 'Andrei Lupan', 'улица Андрея Лупана', 3674, 'Strada Andrei Lupan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (97, 2000, 'Strada', 'str.', 'Andrei Mureșanu', 'улица Андрея Мурешану', 3670, 'Strada Andrei Mureșanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (98, 2000, 'Strada', 'str.', 'Andrei Tupolev', 'улица Андрея Туполева', 3670, 'Strada Andrei Tupolev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (99, 2000, 'Strada', 'str.', 'Anestiade', 'улица Анестиаде', 3671, 'Strada Anestiade') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (100, 2000, 'Strada', 'str.', 'Angela Păduraru', 'улица Анжелы Пэдурару', 3669, 'Strada Angela Păduraru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (101, 2000, 'Stradela', 'str-la', 'Angela Păduraru', 'переулок Анжелы Пэдурару', 3669, 'Stradela Angela Păduraru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (102, 2000, 'Strada', 'str.', 'Ankara', 'улица Анкара', 3674, 'Strada Ankara') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (103, 2000, 'Strada', 'str.', 'Anton Ablov', 'улица Антона Аблова', 3671, 'Strada Anton Ablov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (104, 2000, 'Strada', 'str.', 'Anton Crihan', 'улица Антона Крихана', 3671, 'Strada Anton Crihan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (105, 2000, 'Strada', 'str.', 'Anton Pann', 'улица Антона Панна', 3674, 'Strada Anton Pann') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (106, 2000, 'Strada', 'str.', 'Arborilor', 'улица Арборилор', 3671, 'Strada Arborilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (107, 2000, 'Stradela', 'str-la', 'Arborilor', 'переулок Арборилор', 3671, 'Stradela Arborilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (108, 2000, 'Strada', 'str.', 'Arhanghel Mihail', 'улица Архангела Михаила', 3674, 'Strada Arhanghel Mihail') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (109, 2000, 'Strada', 'str.', 'Arheolog Ion Casian Suruceanu', 'улица Археолога Иона Касяна Суручану', 3671, 'Strada Arheolog Ion Casian Suruceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (110, 2000, 'Strada', 'str.', 'Arheolog Ion Casian-Suruceanu', 'улица Археолог Ион Касиан Суручану', 3671, 'Strada Arheolog Ion Casian-Suruceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (111, 2000, 'Strada', 'str.', 'Arionești', 'улица Арионешть', 3668, 'Strada Arionești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (112, 2000, 'Strada', 'str.', 'Armenească', 'Армянская улица', 3671, 'Strada Armenească') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (113, 2000, 'Strada', 'str.', 'Armoniei', 'улица Армонией', 3668, 'Strada Armoniei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (114, 2000, 'Strada', 'str.', 'Aron Pumnul', 'улица Арона Пумнула', 3670, 'Strada Aron Pumnul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (115, 2000, 'Stradela', 'str-la', 'Aron Pumnul', 'переулок Арона Пумнула', 3670, 'Stradela Aron Pumnul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (116, 2000, 'Strada', 'str.', 'Arțarului', 'улица Арцарулуй', 3671, 'Strada Arțarului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (117, 2000, 'Strada', 'str.', 'Astronauților', 'улица Астронавтов', 3670, 'Strada Astronauților') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (118, 2000, 'Strada', 'str.', 'Astronom Nicolae Donici', 'улица Астронома Николая Донича', 3674, 'Strada Astronom Nicolae Donici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (119, 2000, 'Strada', 'str.', 'Aurel David', 'улица Аурела Давида', 3671, 'Strada Aurel David') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (120, 2000, 'Strada', 'str.', 'Aurel Vlaicu', 'улица Аурела Влайку', 3671, 'Strada Aurel Vlaicu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (121, 2000, 'Strada', 'str.', 'Ave-Maria', 'улица Аве Мария', 3668, 'Strada Ave-Maria') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (122, 2000, 'Strada', 'str.', 'Aviatorilor', 'улица Авиаторов', 3670, 'Strada Aviatorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (123, 2000, 'Strada', 'str.', 'Avicenna', 'улица Авиценна', 3671, 'Strada Avicenna') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (124, 2000, 'Stradela', 'str-la', 'Avicenna', 'переулок Авиценна', 3671, 'Stradela Avicenna') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (125, 2000, 'Strada', 'str.', 'Avocat Eugenia Crușevan', 'улица Эуджения Крушеван', 3671, 'Strada Avocat Eugenia Crușevan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (126, 2000, 'Strada', 'str.', 'Avram Iancu', 'улица Аврама Янку', 3674, 'Strada Avram Iancu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (127, 2000, 'Strada', 'str.', 'Așhabad', 'Ашхабадская улица', 3670, 'Strada Așhabad') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (128, 2000, 'Strada', 'str.', 'Bacău', 'улица Бакэу', 3669, 'Strada Bacău') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (129, 2000, 'Strada', 'str.', 'Baku', 'Бакинская улица', 3670, 'Strada Baku') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (130, 2000, 'Șoseaua', 'șos.', 'Balcani', 'Балканское шоссе', 3669, 'Șoseaua Balcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (131, 2000, 'Șoseaua', 'șos.', 'Balcani - Centura Chișinăului', 'Балканское шоссе', 3669, 'Șoseaua Balcani - Centura Chișinăului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (132, 2000, 'Strada', 'str.', 'Banatului', 'улица Банатулуй', 3670, 'Strada Banatului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (133, 2000, 'Strada', 'str.', 'Barbu Lăutaru', 'улица Барбу Лэутару', 3669, 'Strada Barbu Lăutaru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (134, 2000, 'Strada', 'str.', 'Bariera Orhei', 'улица Барьера Орхей', 3674, 'Strada Bariera Orhei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (135, 2000, 'Strada', 'str.', 'Bariera Sculeni', 'улица Барьера Скулень', 3669, 'Strada Bariera Sculeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (136, 2000, 'Strada', 'str.', 'Basarabilor', 'улица Басарабилор', 3669, 'Strada Basarabilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (137, 2000, 'Strada', 'str.', 'Bazinului', 'улица Базинулуй', 3671, 'Strada Bazinului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (138, 2000, 'Strada', 'str.', 'Belgrad', 'Белградская улица', 3670, 'Strada Belgrad') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (139, 2000, 'Strada', 'str.', 'Belșugului', 'улица Белшугулуй', 3671, 'Strada Belșugului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (140, 2000, 'Strada', 'str.', 'Bisericii', 'улица Бисеричий', 3669, 'Strada Bisericii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (141, 2000, 'Stradela', 'str-la', 'Bisericii', NULL, 3669, 'Stradela Bisericii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (142, 2000, 'Strada', 'str.', 'Bogdan Petriceicu Hașdeu', 'улица Богдана Петричейку Хашдеу', 3674, 'Strada Bogdan Petriceicu Hașdeu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (143, 2000, 'Strada', 'str.', 'Bogdan-Voievod', 'улица Богдан Воевод', 3674, 'Strada Bogdan-Voievod') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (144, 2000, 'Strada', 'str.', 'Botanica Veche', 'улица Ботаника Веке', 3670, 'Strada Botanica Veche') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (145, 2000, 'Strada', 'str.', 'Boteaza', 'улица Ботяза', 3670, 'Strada Boteaza') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (146, 2000, 'Strada', 'str.', 'Braniștii', 'улица Браништий', 3674, 'Strada Braniștii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (147, 2000, 'Strada', 'str.', 'Brăila', 'улица Брэила', 3671, 'Strada Brăila') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (148, 2000, 'Strada', 'str.', 'Bucovina', 'улица Буковина', 3668, 'Strada Bucovina') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (149, 2000, 'Strada', 'str.', 'București', 'улица Букурешть', 3671, 'Strada București') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (150, 2000, 'Strada', 'str.', 'Bucuriei', 'улица Букурией', 3669, 'Strada Bucuriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (151, 2000, 'Strada', 'str.', 'Budești', 'улица Будешть', 3668, 'Strada Budești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (152, 2000, 'Strada', 'str.', 'Budăi', 'улица Будэй', 3668, 'Strada Budăi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (153, 2000, 'Strada', 'str.', 'Bugeacului', 'улица Буджакулуй', 3671, 'Strada Bugeacului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (154, 2000, 'Strada', 'str.', 'Buiucani', 'Боюканская улица', 3669, 'Strada Buiucani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (155, 2000, 'Strada', 'str.', 'Bujorilor', 'улица Бужорилор', 3671, 'Strada Bujorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (156, 2000, 'Strada', 'str.', 'Bulboaca', 'улица Булбоака', 3668, 'Strada Bulboaca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (157, 2000, 'Strada', 'str.', 'Bulbocica', 'Улица Булбочка', 3674, 'Strada Bulbocica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (158, 2000, 'Stradela', 'str-la', 'Bulbocica', 'Переулок Булбочка', 3674, 'Stradela Bulbocica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (159, 2000, 'Strada', 'str.', 'Bulgară', 'Болгарская улица', 3671, 'Strada Bulgară') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (160, 2000, 'Strada', 'str.', 'Buna Vestire', 'улица Буна Вестире', 3674, 'Strada Buna Vestire') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (161, 2000, 'Strada', 'str.', 'Burebista', 'улица Буребиста', 3670, 'Strada Burebista') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (162, 2000, 'Stradela', 'str-la', 'Burebista', 'переулок Буребиста', 3670, 'Stradela Burebista') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (163, 2000, 'Strada', 'str.', 'Busuiocești', 'улица Бусуёчешть', 3670, 'Strada Busuiocești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (164, 2000, 'Strada', 'str.', 'Butuceni', 'улица Бутучень', 3668, 'Strada Butuceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (165, 2000, 'Strada', 'str.', 'Butucului', 'улица Бутукулуй', 3670, 'Strada Butucului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (166, 2000, 'Strada', 'str.', 'Băcioii Noi', 'Новобачойская улица', 3670, 'Strada Băcioii Noi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (167, 2000, 'Stradela', 'str-la', 'Băcioii Noi', 'переулок Бэчоий Ной', 3670, 'Stradela Băcioii Noi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (168, 2000, 'Strada', 'str.', 'Băltagi', 'улица Балтажи', 3671, 'Strada Băltagi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (169, 2000, 'Strada', 'str.', 'Bălănescu', 'улица Бэлэнеску', 3674, 'Strada Bălănescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (170, 2000, 'Strada', 'str.', 'Bălți', 'Бельцкая улица', 3674, 'Strada Bălți') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (171, 2000, 'Strada', 'str.', 'Cahul', 'Кагульская улица', 3674, 'Strada Cahul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (172, 2000, 'Strada', 'str.', 'Caișilor', 'улица Каишилор', 3669, 'Strada Caișilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (173, 2000, 'Strada', 'str.', 'Calea Basarabiei', 'улица Каля Басарабией', 3671, 'Strada Calea Basarabiei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (174, 2000, 'Strada', 'str.', 'Calea Dacilor', 'улица Каля Дачилор', 3668, 'Strada Calea Dacilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (175, 2000, 'Strada', 'str.', 'Calea Ghidighici', 'улица Каля Гидигичулуй', 3669, 'Strada Calea Ghidighici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (176, 2000, 'Strada', 'str.', 'Calea Ieșilor', 'улица Каля Ешилор', 3669, 'Strada Calea Ieșilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (177, 2000, 'Strada', 'str.', 'Calea Moșilor', 'улица Каля Мошилор', 3674, 'Strada Calea Moșilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (178, 2000, 'Strada', 'str.', 'Calea Orheiului', 'улица Каля Орхеюлуй', 3674, 'Strada Calea Orheiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (179, 2000, 'Strada', 'str.', 'Calea Trușenilor', 'улица Каля Трушенилор', 3669, 'Strada Calea Trușenilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (180, 2000, 'Strada', 'str.', 'Camenița', 'улица Каменица', 3671, 'Strada Camenița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (181, 2000, 'Strada', 'str.', 'Cantonului', 'улица Кантонулуй', 3669, 'Strada Cantonului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (182, 2000, 'Strada', 'str.', 'Capricorn', 'улица Каприкорн', 3671, 'Strada Capricorn') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (183, 2000, 'Strada', 'str.', 'Carierei', 'Карьерная улица', 3674, 'Strada Carierei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (184, 2000, 'Strada', 'str.', 'Caucaz', 'Кавказская улица', 3671, 'Strada Caucaz') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (185, 2000, 'Strada', 'str.', 'Cernica', 'улица Черника', 3671, 'Strada Cernica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (186, 2000, 'Strada', 'str.', 'Cernăuți', 'Черновицкая улица', 3670, 'Strada Cernăuți') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (187, 2000, 'Strada', 'str.', 'Cetatea Albă', 'улица Четатя Албэ', 3670, 'Strada Cetatea Albă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (188, 2000, 'Strada', 'str.', 'Cetatea Chilia', 'улица Четатя Килия', 3670, 'Strada Cetatea Chilia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (189, 2000, 'Strada', 'str.', 'Cetinii', 'улица Четиний', 3670, 'Strada Cetinii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (190, 2000, 'Strada', 'str.', 'Ceucari', 'улица Чеукарь', 3674, 'Strada Ceucari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (191, 2000, 'Strada', 'str.', 'Chișinău', 'улица Кишинэулуй', 3670, 'Strada Chișinău') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (192, 2000, 'Strada', 'str.', 'Chițcani', 'улица Кицкань', 3671, 'Strada Chițcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (193, 2000, 'Strada', 'str.', 'Cimbrului', 'улица Чимбрулуй', 3671, 'Strada Cimbrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (194, 2000, 'Strada', 'str.', 'Ciocana', 'улица Чокана', 3668, 'Strada Ciocana') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (195, 2000, 'Strada', 'str.', 'Ciocârliei', 'улица Чокырлией', 3671, 'Strada Ciocârliei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (196, 2000, 'Strada', 'str.', 'Cioricești', 'улица Чоричешть', 3670, 'Strada Cioricești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (197, 2000, 'Strada', 'str.', 'Ciprian Porumbescu', 'улица Чиприана Порумбеску', 3669, 'Strada Ciprian Porumbescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (198, 2000, 'Strada', 'str.', 'Circului', 'Улица Чиркулуй', 3674, 'Strada Circului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (199, 2000, 'Strada', 'str.', 'Cireșilor', 'улица Чирешилор', 3671, 'Strada Cireșilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (200, 2000, 'Strada', 'str.', 'Ciuflea', 'улица Чуфля', 3671, 'Strada Ciuflea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (201, 2000, 'Strada', 'str.', 'Cișmele', 'улица Чишмеле', 3671, 'Strada Cișmele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (202, 2000, 'Strada', 'str.', 'Clopotniței', 'улица Клопотницей', 3670, 'Strada Clopotniței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (203, 2000, 'Strada', 'str.', 'Cocieri', 'улица Кочиерь', 3671, 'Strada Cocieri') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (204, 2000, 'Strada', 'str.', 'Codrilor', 'улица Кодрилор', 3669, 'Strada Codrilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (205, 2000, 'Strada', 'str.', 'Codrul Cosminului', 'улица Кодрул Косминулуй', 3668, 'Strada Codrul Cosminului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (206, 2000, 'Strada', 'str.', 'Cojocarilor', 'улица Кожокарилор', 3674, 'Strada Cojocarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (207, 2000, 'Strada', 'str.', 'Colina Pușkin', 'улица Пушкинская горка', 3674, 'Strada Colina Pușkin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (208, 2000, 'Strada', 'str.', 'Colina Verde', 'улица Колина Верде', 3671, 'Strada Colina Verde') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (209, 2000, 'Strada', 'str.', 'Colonița', 'улица Колоница', 3668, 'Strada Colonița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (210, 2000, 'Stradela', 'str-la', 'Colonița', 'переулок Колоница', 3668, 'Stradela Colonița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (211, 2000, 'Strada', 'str.', 'Columna', 'улица Колумна', 3669, 'Strada Columna') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (212, 2000, 'Strada', 'str.', 'Constantin Brâncoveanu', 'улица Константина Брынковяну', 3674, 'Strada Constantin Brâncoveanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (213, 2000, 'Strada', 'str.', 'Constantin Brâncuși', 'улица Константина Бранкузи', 3670, 'Strada Constantin Brâncuși') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (214, 2000, 'Strada', 'str.', 'Constantin Constantinov', 'улица Константина Константинова', 3674, 'Strada Constantin Constantinov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (215, 2000, 'Bulevardul', 'bd.', 'Constantin Negruzzi', 'бульвар Константина Негруцци', 3671, 'Bulevardul Constantin Negruzzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (216, 2000, 'Stradela', 'str-la', 'Constantin Negruzzi', 'переулок Константина Негруцци', 3671, 'Stradela Constantin Negruzzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (217, 2000, 'Strada', 'str.', 'Constantin Stamati', 'улица Константина Стамати', 3674, 'Strada Constantin Stamati') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (218, 2000, 'Strada', 'str.', 'Constantin Stere', 'улица Константина Стере', 3669, 'Strada Constantin Stere') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (219, 2000, 'Strada', 'str.', 'Constantin Tănase', 'улица Константина Тэнасе', 3674, 'Strada Constantin Tănase') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (220, 2000, 'Strada', 'str.', 'Constantin Vârnav', 'улица Константина Вырнава', 3671, 'Strada Constantin Vârnav') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (221, 2000, 'Stradela', 'str-la', 'Constantin Vârnav', 'переулок Константина Вырнава', 3671, 'Stradela Constantin Vârnav') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (222, 2000, 'Strada', 'str.', 'Constituției', 'улица Конституции', 3669, 'Strada Constituției') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (223, 2000, 'Strada', 'str.', 'Constructorilor', 'улица Конструкторилор', 3674, 'Strada Constructorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (224, 2000, 'Strada', 'str.', 'Copăceni', 'улица Копэчень', 3671, 'Strada Copăceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (225, 2000, 'Strada', 'str.', 'Cornești', 'улица Корнешть', 3674, 'Strada Cornești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (226, 2000, 'Strada', 'str.', 'Cornului', 'улица Корнулуй', 3669, 'Strada Cornului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (227, 2000, 'Strada', 'str.', 'Cosașilor', 'улица Косашилор', 3670, 'Strada Cosașilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (228, 2000, 'Strada', 'str.', 'Costești', 'улица Костешть', 3671, 'Strada Costești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (229, 2000, 'Strada', 'str.', 'Costiujeni', 'Костюженская улица', 3670, 'Strada Costiujeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (230, 2000, 'Strada', 'str.', 'Coșnița', 'улица Кошница', 3671, 'Strada Coșnița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (231, 2000, 'Strada', 'str.', 'Cramei', 'улица Крамей', 3674, 'Strada Cramei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (232, 2000, 'Strada', 'str.', 'Crinilor', 'улица Кринилор', 3671, 'Strada Crinilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (233, 2000, 'Strada', 'str.', 'Crisana', 'улица Кришанэ', 3670, 'Strada Crisana') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (234, 2000, 'Strada', 'str.', 'Cristești', 'улица Кристешть', 3671, 'Strada Cristești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (235, 2000, 'Strada', 'str.', 'Cristofor Columb', 'улица Христофора Колумба', 3670, 'Strada Cristofor Columb') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (236, 2000, 'Strada', 'str.', 'Criuleni', 'улица Криулень', 3674, 'Strada Criuleni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (237, 2000, 'Stradela', 'str-la', 'Criuleni', 'переулок Криулень', 3674, 'Stradela Criuleni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (238, 2000, 'Strada', 'str.', 'Crizantemelor', 'улица Кризантемелор', 3671, 'Strada Crizantemelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (239, 2000, 'Strada', 'str.', 'Crângului', 'улица Крынгулуй', 3674, 'Strada Crângului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (240, 2000, 'Strada', 'str.', 'Cucorilor', 'улица Кукорилор', 3674, 'Strada Cucorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (241, 2000, 'Bulevardul', 'bd.', 'Cuza-Vodă', 'проспект Куза Водэ', 3670, 'Bulevardul Cuza-Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (242, 2000, 'Strada', 'str.', 'Călugăreni', 'улица Кэлугэрень', 3668, 'Strada Călugăreni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (243, 2000, 'Strada', 'str.', 'Călușari', 'улица Кэлушарь', 3674, 'Strada Călușari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (244, 2000, 'Strada', 'str.', 'Călărași', 'Каларашская улица', 3669, 'Strada Călărași') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (245, 2000, 'Stradela', 'str-la', 'Călărași', 'Каларашский переулок', 3669, 'Stradela Călărași') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (246, 2000, 'Strada', 'str.', 'Călătorilor', 'улица Кэлэторилор', 3668, 'Strada Călătorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (247, 2000, 'Stradela', 'str-la', 'Călătorilor', 'переулок Кэлэторилор', 3668, 'Stradela Călătorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (248, 2000, 'Strada', 'str.', 'Căpriana', 'улица Кэприяна', 3674, 'Strada Căpriana') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (249, 2000, 'Strada', 'str.', 'Cărbunari', 'улица Кэрбунарь', 3671, 'Strada Cărbunari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (250, 2000, 'Strada', 'str.', 'Cărămidarilor', 'улица Кэрэмидарилор', 3668, 'Strada Cărămidarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (251, 2000, 'Stradela', 'str-la', 'Cărămidarilor', 'переулок Кэрэмидарилор', 3668, 'Stradela Cărămidarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (252, 2000, 'Strada', 'str.', 'Cărăușilor', 'улица Кэрэушилор', 3674, 'Strada Cărăușilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (253, 2000, 'Strada', 'str.', 'Căușeni', 'Каушанская улица', 3670, 'Strada Căușeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (254, 2000, 'Bulevardul', 'bd.', 'Dacia', 'бульвар Дачия', 3670, 'Bulevardul Dacia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (255, 2000, 'Strada', 'str.', 'Daniil Ciugureanu', 'улица Даниила Чугуряну', 3670, 'Strada Daniil Ciugureanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (256, 2000, 'Strada', 'str.', 'Dante Alighieri', 'улица Данте', 3670, 'Strada Dante Alighieri') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (257, 2000, 'Strada', 'str.', 'Danubius', 'улица Данубиус', 3670, 'Strada Danubius') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (258, 2000, 'Strada', 'str.', 'Dealul Cucului', 'улица Дялул Кукулуй', 3671, 'Strada Dealul Cucului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (259, 2000, 'Strada', 'str.', 'Dealul Morilor', 'улица Дялул Морилор', 3669, 'Strada Dealul Morilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (260, 2000, 'Bulevardul', 'bd.', 'Decebal', 'проспект Дечебал', 3670, 'Bulevardul Decebal') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (261, 2000, 'Strada', 'str.', 'Decembriștilor', 'улица Декабристов', 3670, 'Strada Decembriștilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (262, 2000, 'Strada', 'str.', 'Dimineții', 'улица Диминеций', 3670, 'Strada Dimineții') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (263, 2000, 'Bulevardul', 'bd.', 'Dimitrie Cantemir', 'проспект Дмитрия Кантемира', 3671, 'Bulevardul Dimitrie Cantemir') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (264, 2000, 'Piața', 'p-ța', 'Dimitrie Cantemir', 'площадь Дмитрия Кантемира', 3669, 'Piața Dimitrie Cantemir') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (265, 2000, 'Strada', 'str.', 'Dinu Lipatti', 'улица Дину Липатти', 3670, 'Strada Dinu Lipatti') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (266, 2000, 'Stradela', 'str-la', 'Dinu Lipatti', 'переулок Дину Липатти', 3670, 'Stradela Dinu Lipatti') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (267, 2000, 'Strada', 'str.', 'Dobrușa', 'улица Добруша', 3670, 'Strada Dobrușa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (268, 2000, 'Strada', 'str.', 'Doctor Tudor Strișcă', 'улица Доктор Тудора Стришкэ', 3671, 'Strada Doctor Tudor Strișcă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (269, 2000, 'Strada', 'str.', 'Doina', 'улица Дойна', 3674, 'Strada Doina') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (270, 2000, 'Stradela', 'str-la', 'Doina', 'переулок Дойна', 3674, 'Stradela Doina') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (271, 2000, 'Strada', 'str.', 'Doina și Ion Aldea-Teodorovici', 'улица Дойны и Иона Алдя-Теодоровича', 3669, 'Strada Doina și Ion Aldea-Teodorovici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (272, 2000, 'Strada', 'str.', 'Dominte Timonu', 'улица Доминте Тимону', 3669, 'Strada Dominte Timonu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (273, 2000, 'Strada', 'str.', 'Domniței', 'улица Домницей', 3674, 'Strada Domniței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (274, 2000, 'Strada', 'str.', 'Dorobanți', 'улица Доробанци', 3670, 'Strada Dorobanți') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (275, 2000, 'Strada', 'str.', 'Dragomirna', 'улица Драгомирна', 3669, 'Strada Dragomirna') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (276, 2000, 'Stradela', 'str-la', 'Dragomirna', 'переулок Драгомирна', 3669, 'Stradela Dragomirna') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (277, 2000, 'Strada', 'str.', 'Drumul Băcioiului', 'улица Друмул Бэчоюлуй', 3670, 'Strada Drumul Băcioiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (278, 2000, 'Strada', 'str.', 'Drumul Crucii', 'улица Друмул Кручий', 3669, 'Strada Drumul Crucii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (279, 2000, 'Strada', 'str.', 'Drumul Schinoasei', 'улица Друмул Скиноасей', 3671, 'Strada Drumul Schinoasei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (280, 2000, 'Strada', 'str.', 'Drumul Taberei', 'улица Друмул Таберей', 3669, 'Strada Drumul Taberei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (281, 2000, 'Strada', 'str.', 'Drumul Viilor', 'улица Друмул Виилор', 3671, 'Strada Drumul Viilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (282, 2000, 'Strada', 'str.', 'Dubăsari', 'Дубоссарская улица', 3674, 'Strada Dubăsari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (283, 2000, 'Strada', 'str.', 'Dumbrava Roșie', 'улица Думбрава Рошие', 3668, 'Strada Dumbrava Roșie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (284, 2000, 'Strada', 'str.', 'Dumbravei', NULL, 3668, 'Strada Dumbravei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (285, 2000, 'Strada', 'str.', 'Dumbrăvii', 'улица Думбрэвий', 3671, 'Strada Dumbrăvii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (286, 2000, 'Stradela', 'str-la', 'Dumbrăvii', 'переулок Думбрэвий', 3671, 'Stradela Dumbrăvii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (287, 2000, 'Strada', 'str.', 'Duminica Mare', 'улица Думиника Маре', 3670, 'Strada Duminica Mare') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (288, 2000, 'Strada', 'str.', 'Dumitru Caraciobanu', 'улица Думитру Карачобану', 3669, 'Strada Dumitru Caraciobanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (289, 2000, 'Strada', 'str.', 'Dumitru Gheorghiță', 'улица Дмитрия Георгицэ', 3674, 'Strada Dumitru Gheorghiță') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (290, 2000, 'Strada', 'str.', 'Dumitru Moruzi', 'улица Думитру Морузи', 3671, 'Strada Dumitru Moruzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (291, 2000, 'Strada', 'str.', 'Dumitru Râșcanu', 'улица Думитру Рышкану', 3674, 'Strada Dumitru Râșcanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (292, 2000, 'Strada', 'str.', 'Durlești', 'улица Дурлешть', 3669, 'Strada Durlești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (293, 2000, 'Strada', 'str.', 'Dâmbului', 'улица Дымбулуй', 3671, 'Strada Dâmbului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (294, 2000, 'Strada', 'str.', 'Dîmbului', 'улица Дымбулуй', 3671, 'Strada Dîmbului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (295, 2000, 'Strada', 'str.', 'Ecaterina Teodoroiu', 'улица Екатерины Теодорою', 3674, 'Strada Ecaterina Teodoroiu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (296, 2000, 'Strada', 'str.', 'Elena Alistar', 'улица Елены Алистар', 3670, 'Strada Elena Alistar') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (297, 2000, 'Strada', 'str.', 'Emil Loteanu', 'улица Эмиля Лотяну', 3674, 'Strada Emil Loteanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (298, 2000, 'Strada', 'str.', 'Eroii Neamului', 'улица Эроий Нямулуй', 3668, 'Strada Eroii Neamului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (299, 2000, 'Strada', 'str.', 'Eugen Coca', 'улица Евгения Коки', 3669, 'Strada Eugen Coca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (300, 2000, 'Strada', 'str.', 'Eugen Doga', 'улица Евгения Доги', 3674, 'Strada Eugen Doga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (301, 2000, 'Strada', 'str.', 'Eugen Popușoi', 'улица Эуджен Попушой', 3670, 'Strada Eugen Popușoi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (302, 2000, 'Strada', 'str.', 'Eugen Russev', 'улица Евгения Руссева', 3674, 'Strada Eugen Russev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (303, 2000, 'Strada', 'str.', 'Fantalului', 'улица Фанталулуй', 3674, 'Strada Fantalului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (304, 2000, 'Strada', 'str.', 'Fecioarei', 'улица Фечиоарей', 3671, 'Strada Fecioarei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (305, 2000, 'Strada', 'str.', 'Feredeului', 'улица Фередеулуй', 3674, 'Strada Feredeului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (306, 2000, 'Strada', 'str.', 'Feroviarilor', 'улица Феровиарилор', 3669, 'Strada Feroviarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (307, 2000, 'Strada', 'str.', 'Fierarilor', 'улица Ферарилор', 3671, 'Strada Fierarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (308, 2000, 'Stradela', 'str-la', 'Fierarilor', 'переулок Ферарилор', 3671, 'Stradela Fierarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (309, 2000, 'Strada', 'str.', 'Fiodor Tolbuhin', 'улица Фёдора Толбухина', 3674, 'Strada Fiodor Tolbuhin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (310, 2000, 'Strada', 'str.', 'Floreni', 'улица Флорень', 3668, 'Strada Floreni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (311, 2000, 'Strada', 'str.', 'Florești', 'улица Флорешть', 3669, 'Strada Florești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (312, 2000, 'Strada', 'str.', 'Florica Niță', 'улица Флорика Ницэ', 3674, 'Strada Florica Niță') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (313, 2000, 'Strada', 'str.', 'Florile Dalbe', 'улица Флориле Далбе', 3669, 'Strada Florile Dalbe') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (314, 2000, 'Strada', 'str.', 'Florilor', 'улица Флорилор', 3674, 'Strada Florilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (315, 2000, 'Strada', 'str.', 'Focșani', 'улица Фокшань', 3671, 'Strada Focșani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (316, 2000, 'Strada', 'str.', 'Frații Apostol', 'улица Фокшань', 3671, 'Strada Frații Apostol') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (317, 2000, 'Strada', 'str.', 'Frumoasa', 'улица Фрумоаса', 3671, 'Strada Frumoasa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (318, 2000, 'Strada', 'str.', 'Frumușica', 'улица Фрумушика', 3670, 'Strada Frumușica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (319, 2000, 'Strada', 'str.', 'Fulgulești', 'улица Фулгулешть', 3670, 'Strada Fulgulești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (320, 2000, 'Strada', 'str.', 'Fîntînilor', 'улица Фынтынилор', 3670, 'Strada Fîntînilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (321, 2000, 'Strada', 'str.', 'Făurești', 'улица Фэурешть', 3668, 'Strada Făurești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (322, 2000, 'Strada', 'str.', 'Galați', 'улица Галац', 3671, 'Strada Galați') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (323, 2000, 'Strada', 'str.', 'Galbenă', 'улица Галбена', 3671, 'Strada Galbenă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (324, 2000, 'Strada', 'str.', 'Garoafelor', 'улица Гароафелор', 3671, 'Strada Garoafelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (325, 2000, 'Strada', 'str.', 'Gavriil Musicescu', 'улица Гавриила Музическу', 3669, 'Strada Gavriil Musicescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (326, 2000, 'Strada', 'str.', 'Geamănă', 'улица Джаманэ', 3671, 'Strada Geamănă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (327, 2000, 'Strada', 'str.', 'George Coșbuc', 'улица Джордже Кошбука', 3674, 'Strada George Coșbuc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (328, 2000, 'Strada', 'str.', 'George Călinescu', 'улица Джордже Кэлинеску', 3669, 'Strada George Călinescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (329, 2000, 'Strada', 'str.', 'George Enescu', 'улица Джордже Энеску', 3669, 'Strada George Enescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (330, 2000, 'Strada', 'str.', 'George Meniuc', 'улица Джордже Менюка', 3671, 'Strada George Meniuc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (331, 2000, 'Strada', 'str.', 'George Topârceanu', 'улица Джордже Топырчану', 3669, 'Strada George Topârceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (332, 2000, 'Strada', 'str.', 'Ghenadie Iablocikin', 'улица Геннадия Яблочкина', 3669, 'Strada Ghenadie Iablocikin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (333, 2000, 'Strada', 'str.', 'Gheorge Bezviconi', 'улица Георге Безвикони', 3670, 'Strada Gheorge Bezviconi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (334, 2000, 'Strada', 'str.', 'Gheorghe Asachi', 'улица Георге Асаки', 3671, 'Strada Gheorghe Asachi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (335, 2000, 'Strada', 'str.', 'Gheorghe Bacovia', 'улица Георге Баковия', 3671, 'Strada Gheorghe Bacovia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (336, 2000, 'Strada', 'str.', 'Gheorghe Cașu', 'улица Георге Кашу', 3671, 'Strada Gheorghe Cașu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (337, 2000, 'Strada', 'str.', 'Gheorghe Codreanu', 'улица Георге Кодряну', 3669, 'Strada Gheorghe Codreanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (338, 2000, 'Strada', 'str.', 'Gheorghe Crișan', 'улица Георге Кришан', 3670, 'Strada Gheorghe Crișan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (339, 2000, 'Stradela', 'str-la', 'Gheorghe Cucereanu', NULL, 3670, 'Stradela Gheorghe Cucereanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (340, 2000, 'Strada', 'str.', 'Gheorghe Ghimpu', 'улица Георге Гимпу', 3668, 'Strada Gheorghe Ghimpu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (341, 2000, 'Strada', 'str.', 'Gheorghe Madan', 'улица Георге Мадана', 3674, 'Strada Gheorghe Madan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (342, 2000, 'Strada', 'str.', 'Gheorghe Malarciuc', 'улица Георгия Маларчука', 3671, 'Strada Gheorghe Malarciuc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (343, 2000, 'Strada', 'str.', 'Gheorghe Tofan', 'улица Георге Тофан', 3669, 'Strada Gheorghe Tofan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (344, 2000, 'Strada', 'str.', 'Gheorghe Tudor', 'улица Георге Тудор', 3671, 'Strada Gheorghe Tudor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (345, 2000, 'Stradela', 'str-la', 'Gherman Pântea', 'переулок Г. Пынтя', 3674, 'Stradela Gherman Pântea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (346, 2000, 'Strada', 'str.', 'Ghica-Vodă', 'улица Гика-Водэ', 3670, 'Strada Ghica-Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (347, 2000, 'Stradela', 'str-la', 'Ghica-Vodă', 'переулок Гика-Водэ', 3670, 'Stradela Ghica-Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (348, 2000, 'Strada', 'str.', 'Ghidighici', 'улица Гидигич', 3669, 'Strada Ghidighici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (349, 2000, 'Strada', 'str.', 'Ghioceilor', 'улица Гиочеилор', 3669, 'Strada Ghioceilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (350, 2000, 'Strada', 'str.', 'Ginta Latină', 'улица Джинта Латинэ', 3668, 'Strada Ginta Latină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (351, 2000, 'Strada', 'str.', 'Golia', 'улица Голия', 3669, 'Strada Golia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (352, 2000, 'Strada', 'str.', 'Grenoble', 'улица Гренобля', 3671, 'Strada Grenoble') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (353, 2000, 'Strada', 'str.', 'Grigore Alexandrescu', 'улица Григория Александреску', 3669, 'Strada Grigore Alexandrescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (354, 2000, 'Strada', 'str.', 'Grigore Ureche', 'улица Григоре Уреке', 3674, 'Strada Grigore Ureche') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (355, 2000, 'Aleea', 'al.', 'Grigore Vieru', NULL, 3674, 'Aleea Grigore Vieru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (356, 2000, 'Bulevardul', 'bd.', 'Grigore Vieru', 'Бульвар Григоре Виеру', 3674, 'Bulevardul Grigore Vieru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (357, 2000, 'Strada', 'str.', 'Griviței', 'улица Гривицей', 3671, 'Strada Griviței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (358, 2000, 'Strada', 'str.', 'Grîului', 'улица Грыулуй', 3669, 'Strada Grîului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (359, 2000, 'Strada', 'str.', 'Grădina Botanică', 'улица Грэдина Ботаникэ', 3670, 'Strada Grădina Botanică') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (360, 2000, 'Strada', 'str.', 'Grădinarilor', 'улица Грэдинарилор', 3674, 'Strada Grădinarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (361, 2000, 'Strada', 'str.', 'Grădinilor', 'улица Грэдинелор', 3674, 'Strada Grădinilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (362, 2000, 'Strada', 'str.', 'Grătiești', 'улица Грэтиешть', 3674, 'Strada Grătiești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (363, 2000, 'Strada', 'str.', 'Gura Văii', 'улица Гура Вэий', 3674, 'Strada Gura Văii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (364, 2000, 'Strada', 'str.', 'Gârliței', 'улица Гырлицей', 3671, 'Strada Gârliței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (365, 2000, 'Strada', 'str.', 'Gîrlei', 'улица Гырлей', 3671, 'Strada Gîrlei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (366, 2000, 'Piața', 'p-ța', 'Gării', 'Вокзальная площадь', 3671, 'Piața Gării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (367, 2000, 'Strada', 'str.', 'Gării', 'Вокзальная улица', 3671, 'Strada Gării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (368, 2000, 'Strada', 'str.', 'Habad Liubavici', 'улица Хабад Любавич', 3674, 'Strada Habad Liubavici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (369, 2000, 'Strada', 'str.', 'Haiducilor', 'улица Хайдучилор', 3671, 'Strada Haiducilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (370, 2000, 'Strada', 'str.', 'Haiducul Bujor', 'улица Хайдукул Бужор', 3668, 'Strada Haiducul Bujor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (371, 2000, 'Strada', 'str.', 'Haiducul Tobultoc', 'улица Хайдукул Тобулток', 3669, 'Strada Haiducul Tobultoc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (372, 2000, 'Strada', 'str.', 'Haltei', 'улица Халтей', 3671, 'Strada Haltei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (373, 2000, 'Stradela', 'str-la', 'Haltei', 'переулок Халтей', 3671, 'Stradela Haltei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (374, 2000, 'Strada', 'str.', 'Hanul Morii', 'улица Ханул Морий', 3670, 'Strada Hanul Morii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (375, 2000, 'Stradela', 'str-la', 'Hanul Morii', 'переулок Ханул Морий', 3670, 'Stradela Hanul Morii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (376, 2000, 'Strada', 'str.', 'Henri Coandă', 'улица Анри Коандэ', 3669, 'Strada Henri Coandă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (377, 2000, 'Strada', 'str.', 'Hipodromului', 'улица Хиподромулуй', 3674, 'Strada Hipodromului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (378, 2000, 'Strada', 'str.', 'Horea', 'улица В. Хоря', 3670, 'Strada Horea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (379, 2000, 'Strada', 'str.', 'Hotarul Satului', 'улица Хотарул Сатулуй', 3670, 'Strada Hotarul Satului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (380, 2000, 'Strada', 'str.', 'Hotin', 'улица Хотин', 3674, 'Strada Hotin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (381, 2000, 'Strada', 'str.', 'Hristo Botev', 'улица Христо Ботева', 3670, 'Strada Hristo Botev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (382, 2000, 'Strada', 'str.', 'Hrușca', 'улица Хрушка', 3671, 'Strada Hrușca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (383, 2000, 'Stradela', 'str-la', 'Hrușca', 'переулок Хрушка', 3671, 'Stradela Hrușca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (384, 2000, 'Strada', 'str.', 'Humulești', 'улица Хумулешть', 3669, 'Strada Humulești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (385, 2000, 'Șoseaua', 'șos.', 'Hâncești', 'Хынчештское шоссе', 3671, 'Șoseaua Hâncești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (386, 2000, 'Strada', 'str.', 'Iacob Hîncu', 'улица Якоба Хынку', 3674, 'Strada Iacob Hîncu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (387, 2000, 'Strada', 'str.', 'Ialoveni', 'Яловенская улица', 3671, 'Strada Ialoveni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (388, 2000, 'Strada', 'str.', 'Iazului', 'улица Язулуй', 3674, 'Strada Iazului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (389, 2000, 'Strada', 'str.', 'Ierusalim', 'Иерусалимская улица', 3674, 'Strada Ierusalim') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (390, 2000, 'Strada', 'str.', 'Igor Ciorbă', 'улица Игоря Чорбэ', 3670, 'Strada Igor Ciorbă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (391, 2000, 'Strada', 'str.', 'Igor Vieru', 'улица Игоря Виеру', 3668, 'Strada Igor Vieru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (392, 2000, 'Strada', 'str.', 'Ihil Șraibman', 'улица Ихила Шрайбмана', 3674, 'Strada Ihil Șraibman') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (393, 2000, 'Strada', 'str.', 'Ilia Repin', 'улица Ильи Репина', 3668, 'Strada Ilia Repin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (394, 2000, 'Strada', 'str.', 'Ilie Coșanu', 'улица Илие Кошану', 3668, 'Strada Ilie Coșanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (395, 2000, 'Strada', 'str.', 'Ilie Fulga', 'улица Илие Фулга', 3668, 'Strada Ilie Fulga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (396, 2000, 'Strada', 'str.', 'Ilie Untilă', 'улица Академика И. Унтилэ', 3671, 'Strada Ilie Untilă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (397, 2000, 'Strada', 'str.', 'Imașului', 'улица Имашулуй', 3670, 'Strada Imașului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (398, 2000, 'Stradela', 'str-la', 'Imașului', 'переулок Имашулуй', 3670, 'Stradela Imașului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (399, 2000, 'Piața', 'p-ța', 'Independenței', 'площадь Индепенденцей', 3671, 'Piața Independenței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (400, 2000, 'Strada', 'str.', 'Independenței', 'улица Индепенденцей', 3670, 'Strada Independenței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (401, 2000, 'Strada', 'str.', 'Industrială', 'Индустриальная улица', 3668, 'Strada Industrială') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (402, 2000, 'Strada', 'str.', 'Inești', 'улица Инешть', 3669, 'Strada Inești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (403, 2000, 'Strada', 'str.', 'Ioan Botezătorul', 'улица Иоана Ботезэторула', 3674, 'Strada Ioan Botezătorul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (404, 2000, 'Stradela', 'str-la', 'Ioan Botezătorul', 'переулок Иоана Ботезэторула', 3674, 'Stradela Ioan Botezătorul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (405, 2000, 'Strada', 'str.', 'Ioan Livescu', 'улица Иоана Ливеску', 3669, 'Strada Ioan Livescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (406, 2000, 'Strada', 'str.', 'Ioan Vodă Viteazul', 'улица Иоан Водэ Витязул', 3670, 'Strada Ioan Vodă Viteazul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (407, 2000, 'Strada', 'str.', 'Ioana Radu', 'улица Иоана Раду', 3669, 'Strada Ioana Radu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (408, 2000, 'Strada', 'str.', 'Ion Buzdugan', 'улица Ион Буздуган', 3669, 'Strada Ion Buzdugan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (409, 2000, 'Strada', 'str.', 'Ion Callimachi', 'улица Иона Каллимаки', 3669, 'Strada Ion Callimachi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (410, 2000, 'Strada', 'str.', 'Ion Cloșca', 'улица Иона Клошки', 3670, 'Strada Ion Cloșca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (411, 2000, 'Strada', 'str.', 'Ion Creangă', 'улица Иона Крянгэ', 3669, 'Strada Ion Creangă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (412, 2000, 'Strada', 'str.', 'Ion Doncev', 'улица Иона Дончева', 3674, 'Strada Ion Doncev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (413, 2000, 'Strada', 'str.', 'Ion Ganea', 'улица Иона Гани', 3671, 'Strada Ion Ganea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (414, 2000, 'Strada', 'str.', 'Ion Inculeț', 'улица Иона Инкулец', 3671, 'Strada Ion Inculeț') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (415, 2000, 'Strada', 'str.', 'Ion Luca Caragiale', 'улица Иона Лука Караджале', 3669, 'Strada Ion Luca Caragiale') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (416, 2000, 'Strada', 'str.', 'Ion Neculce', 'улица Иона Некулче', 3669, 'Strada Ion Neculce') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (417, 2000, 'Strada', 'str.', 'Ion Nistor', 'улица Иона Нистора', 3671, 'Strada Ion Nistor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (418, 2000, 'Strada', 'str.', 'Ion Pelivan', 'улица Иона Пеливана', 3669, 'Strada Ion Pelivan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (419, 2000, 'Strada', 'str.', 'Ion Pruncul', 'улица Прункул', 3674, 'Strada Ion Pruncul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (420, 2000, 'Strada', 'str.', 'Ion Vasilenco', 'улица Иона Василенко', 3671, 'Strada Ion Vasilenco') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (421, 2000, 'Strada', 'str.', 'Ion Vatamanu', 'переулок Иона Ватаману', 3671, 'Strada Ion Vatamanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (422, 2000, 'Stradela', 'str-la', 'Ion Vatamanu', 'переулок Иона Ватаману', 3671, 'Stradela Ion Vatamanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (423, 2000, 'Strada', 'str.', 'Ipate Soroceanu', 'улица Ипате Сорочану', 3671, 'Strada Ipate Soroceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (424, 2000, 'Stradela', 'str-la', 'Ipate Soroceanu', 'переулок Ип. Сорочану', 3671, 'Stradela Ipate Soroceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (425, 2000, 'Strada', 'str.', 'Ipotești', 'улица Ипотешть', 3674, 'Strada Ipotești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (426, 2000, 'Strada', 'str.', 'Irișilor', 'улица Иришилор', 3668, 'Strada Irișilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (427, 2000, 'Strada', 'str.', 'Ismail', 'Измаильская улица', 3671, 'Strada Ismail') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (428, 2000, 'Strada', 'str.', 'Istra', 'улица Истра', 3670, 'Strada Istra') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (429, 2000, 'Piața', 'p-ța', 'Iulius Cezar', 'площадь Юлия Цезаря', 3670, 'Piața Iulius Cezar') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (430, 2000, 'Bulevardul', 'bd.', 'Iuri Gagarin', 'проспект Гагарина', 3671, 'Bulevardul Iuri Gagarin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (431, 2000, 'Strada', 'str.', 'Iurie Babei', 'улица Юрие Бабей', 3670, 'Strada Iurie Babei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (432, 2000, 'Strada', 'str.', 'Ivan Zaikin', 'улица Ивана Заикина', 3674, 'Strada Ivan Zaikin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (433, 2000, 'Strada', 'str.', 'Ișnovăț', 'улица Ишновэц', 3668, 'Strada Ișnovăț') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (434, 2000, 'Strada', 'str.', 'Junimea', 'улица Жунимя', 3674, 'Strada Junimea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (435, 2000, 'Strada', 'str.', 'Kiev', 'Киевская улица', 3674, 'Strada Kiev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (436, 2000, 'Strada', 'str.', 'Lacului', 'улица Лакулуй', 3671, 'Strada Lacului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (437, 2000, 'Strada', 'str.', 'Lalelelor', 'улица Лалелелор', 3674, 'Strada Lalelelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (438, 2000, 'Strada', 'str.', 'Lech Kaczynski', 'улица Леха Качиньского', 3671, 'Strada Lech Kaczynski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (439, 2000, 'Strada', 'str.', 'Leușeni', 'улица Леушень', 3670, 'Strada Leușeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (440, 2000, 'Strada', 'str.', 'Lev Tolstoi', 'улица Льва Толстого', 3671, 'Strada Lev Tolstoi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (441, 2000, 'Strada', 'str.', 'Lidia Istrati', 'улица Лидии Истрати', 3674, 'Strada Lidia Istrati') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (442, 2000, 'Strada', 'str.', 'Liliacului', 'улица Лилякулуй', 3674, 'Strada Liliacului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (443, 2000, 'Strada', 'str.', 'Lipcani', 'Липканская улица', 3669, 'Strada Lipcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (444, 2000, 'Stradela', 'str-la', 'Lipcani', 'Липканский переулок', 3669, 'Stradela Lipcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (445, 2000, 'Strada', 'str.', 'Lisabona', 'Лиссабонская улица', 3669, 'Strada Lisabona') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (446, 2000, 'Strada', 'str.', 'Liuba Dumitriu', 'улица Любы Думитриу', 3670, 'Strada Liuba Dumitriu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (447, 2000, 'Strada', 'str.', 'Liviu Damian', 'улица Ливиу Дамиан', 3674, 'Strada Liviu Damian') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (448, 2000, 'Stradela', 'str-la', 'Liviu Damian', 'переулок Ливиу Дамьяна', 3674, 'Stradela Liviu Damian') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (449, 2000, 'Strada', 'str.', 'Liviu Deleanu', 'улица Ливиу Деляну', 3669, 'Strada Liviu Deleanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (450, 2000, 'Strada', 'str.', 'Liviu Rebreanu', 'улица Ливиу Ребряну', 3668, 'Strada Liviu Rebreanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (451, 2000, 'Stradela', 'str-la', 'Liviu Rebreanu', 'переулок Ливиу Ребряну', 3668, 'Stradela Liviu Rebreanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (452, 2000, 'Strada', 'str.', 'Lucian Blaga', 'улица Лучиана Благи', 3671, 'Strada Lucian Blaga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (453, 2000, 'Strada', 'str.', 'Lunca Bâcului', 'улица Лунка Быкулуй', 3668, 'Strada Lunca Bâcului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (454, 2000, 'Strada', 'str.', 'Luncii', 'улица Лунчий', 3674, 'Strada Luncii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (455, 2000, 'Strada', 'str.', 'Lămăiței', 'улица Лэмыицей', 3671, 'Strada Lămăiței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (456, 2000, 'Strada', 'str.', 'Lăpușnei', 'улица Лапушней', 3671, 'Strada Lăpușnei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (457, 2000, 'Strada', 'str.', 'Macilor', 'улица Мачилор', 3674, 'Strada Macilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (458, 2000, 'Strada', 'str.', 'Magda Isanos', 'улица Магда Исанос', 3674, 'Strada Magda Isanos') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (459, 2000, 'Strada', 'str.', 'Malina Mare', 'улица Большая Малина', 3671, 'Strada Malina Mare') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (460, 2000, 'Strada', 'str.', 'Maramureș', 'улица Марамуреш', 3670, 'Strada Maramureș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (461, 2000, 'Piața', 'p-ța', 'Marea Adunare Națională', 'Площадь Великого Национального Собрания', 3669, 'Piața Marea Adunare Națională') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (462, 2000, 'Strada', 'str.', 'Maria Cebotari', 'улица Марии Чеботарь', 3669, 'Strada Maria Cebotari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (463, 2000, 'Strada', 'str.', 'Maria Drăgan', 'улица Марии Дрэган', 3668, 'Strada Maria Drăgan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (464, 2000, 'Strada', 'str.', 'Maria Lătărețu', 'улица Марии Лэтэрецу (М. Мусоргского)', 3669, 'Strada Maria Lătărețu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (465, 2000, 'Strada', 'str.', 'Maria Tănase', 'улица Марии Тэнасе', 3669, 'Strada Maria Tănase') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (466, 2000, 'Strada', 'str.', 'Matei Basarab', 'улица Матея Басараба', 3674, 'Strada Matei Basarab') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (467, 2000, 'Strada', 'str.', 'Matei Milo', 'улица Матея Милло', 3670, 'Strada Matei Milo') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (468, 2000, 'Strada', 'str.', 'Mazililor', 'улица Мазилилор', 3670, 'Strada Mazililor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (469, 2000, 'Strada', 'str.', 'Melestiu', 'улица Мелестиу', 3670, 'Strada Melestiu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (470, 2000, 'Stradela', 'str-la', 'Melestiu', 'переулок Мелестиу', 3671, 'Stradela Melestiu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (471, 2000, 'Strada', 'str.', 'Memoriei', 'улица Меморией', 3674, 'Strada Memoriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (472, 2000, 'Strada', 'str.', 'Mereni', 'улица Мерень', 3668, 'Strada Mereni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (473, 2000, 'Stradela', 'str-la', 'Mereni', 'переулок Мерень', 3668, 'Stradela Mereni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (474, 2000, 'Strada', 'str.', 'Mereșeni', 'улица Мерешень', 3671, 'Strada Mereșeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (475, 2000, 'Strada', 'str.', 'Mesager', 'улица Месаджер', 3669, 'Strada Mesager') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (476, 2000, 'Strada', 'str.', 'Meșteru Manole', 'улица Мештерул Маноле', 3668, 'Strada Meșteru Manole') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (477, 2000, 'Strada', 'str.', 'Meșterul Manole', 'улица Мештерул Маноле', 3668, 'Strada Meșterul Manole') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (478, 2000, 'Strada', 'str.', 'Mihai Eminescu', 'улица Михая Эминеску', 3671, 'Strada Mihai Eminescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (479, 2000, 'Strada', 'str.', 'Mihai Viteazul', 'улица Михая Витязула', 3669, 'Strada Mihai Viteazul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (480, 2000, 'Strada', 'str.', 'Mihail Ciachir', 'улица Михаила Чакира', 3671, 'Strada Mihail Ciachir') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (481, 2000, 'Strada', 'str.', 'Mihail Grebencea', 'улица Михаила Гребенча', 3670, 'Strada Mihail Grebencea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (482, 2000, 'Strada', 'str.', 'Mihail Kogălniceanu', 'улица Михаила Когэлничану', 3671, 'Strada Mihail Kogălniceanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (483, 2000, 'Strada', 'str.', 'Mihail Lermontov', 'улица Михаила Лермонтова', 3671, 'Strada Mihail Lermontov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (484, 2000, 'Strada', 'str.', 'Mihail Lomonosov', 'улица Михаила Ломоносова', 3671, 'Strada Mihail Lomonosov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (485, 2000, 'Strada', 'str.', 'Mihail Sadoveanu', 'улица Михаила Садовяну', 3668, 'Strada Mihail Sadoveanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (486, 2000, 'Strada', 'str.', 'Milano', 'улица Милано', 3669, 'Strada Milano') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (487, 2000, 'Strada', 'str.', 'Milești', 'улица Милешть', 3671, 'Strada Milești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (488, 2000, 'Strada', 'str.', 'Minsk', 'Минская улица', 3670, 'Strada Minsk') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (489, 2000, 'Strada', 'str.', 'Miorița', 'улица Миорица', 3671, 'Strada Miorița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (490, 2000, 'Bulevardul', 'bd.', 'Mircea cel Bătrân', 'Бульвар Мирча чел Бэтрын', 3668, 'Bulevardul Mircea cel Bătrân') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (491, 2000, 'Strada', 'str.', 'Mircea Eliade', 'улица Мирча Элиаде', 3671, 'Strada Mircea Eliade') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (492, 2000, 'Strada', 'str.', 'Mircești', 'улица Мирчешть', 3674, 'Strada Mircești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (493, 2000, 'Strada', 'str.', 'Miron Costin', 'улица Мирона Костина', 3674, 'Strada Miron Costin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (494, 2000, 'Strada', 'str.', 'Mitropolit Dosoftei', 'Улица Митрополита Дософтея', 3669, 'Strada Mitropolit Dosoftei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (495, 2000, 'Strada', 'str.', 'Mitropolit Gavriil Bănulescu-Bodoni', 'улица Митрополита Гавриила Бэнулеску-Бодони', 3669, 'Strada Mitropolit Gavriil Bănulescu-Bodoni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (496, 2000, 'Strada', 'str.', 'Mitropolit Gurie Grosu', 'улица Митрополита Гурие Гросу', 3671, 'Strada Mitropolit Gurie Grosu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (497, 2000, 'Strada', 'str.', 'Mitropolit Petru Movilă', 'улица Митрополит Петру Мовилэ', 3669, 'Strada Mitropolit Petru Movilă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (498, 2000, 'Strada', 'str.', 'Mitropolit Varlaam', 'улица Митрополита Варлаама', 3671, 'Strada Mitropolit Varlaam') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (499, 2000, 'Strada', 'str.', 'Moara Roșie', 'улица Моара Рошие', 3674, 'Strada Moara Roșie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (500, 2000, 'Strada', 'str.', 'Moldovița', 'улица Молдовица', 3674, 'Strada Moldovița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (501, 2000, 'Stradela', 'str-la', 'Moldovița', 'переулок Молдовица', 3671, 'Stradela Moldovița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (502, 2000, 'Strada', 'str.', 'Montana', 'улица Монтанэ', 3674, 'Strada Montana') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (503, 2000, 'Bulevardul', 'bd.', 'Moscova', 'Московский проспект', 3674, 'Bulevardul Moscova') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (504, 2000, 'Strada', 'str.', 'Movila lui Burcel', 'улица Мовила луй Бурчел', 3674, 'Strada Movila lui Burcel') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (505, 2000, 'Strada', 'str.', 'Movileni', 'улица Мовилень', 3668, 'Strada Movileni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (506, 2000, 'Stradela', 'str-la', 'Movileni', 'переулок Мовилень', 3668, 'Stradela Movileni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (507, 2000, 'Stradela', 'str-la', 'Muncești', 'переулок Мунчешть', 3670, 'Stradela Muncești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (508, 2000, 'Șoseaua', 'șos.', 'Muncești', 'Мунчештское шоссе', 3670, 'Șoseaua Muncești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (509, 2000, 'Strada', 'str.', 'Murelor', 'улица Мурелор', 3669, 'Strada Murelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (510, 2000, 'Strada', 'str.', 'Muzelor', 'улица Музелор', 3670, 'Strada Muzelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (511, 2000, 'Strada', 'str.', 'Mușatinilor', 'улица Мушатинилор', 3669, 'Strada Mușatinilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (512, 2000, 'Strada', 'str.', 'Măcieșilor', 'улица Мачиесилор', 3671, 'Strada Măcieșilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (513, 2000, 'Strada', 'str.', 'Mălina Mică', 'улица Малая Малина', 3671, 'Strada Mălina Mică') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (514, 2000, 'Stradela', 'str-la', 'Mălina Mică', 'переулок Малая Малина', 3671, 'Stradela Mălina Mică') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (515, 2000, 'Strada', 'str.', 'Mălăiești', 'улица Мэлэешть', 3668, 'Strada Mălăiești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (516, 2000, 'Strada', 'str.', 'Mărășești', 'улица Мэрэшешть', 3671, 'Strada Mărășești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (517, 2000, 'Strada', 'str.', 'Mărțișor', 'улица Мэрцишор', 3671, 'Strada Mărțișor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (518, 2000, 'Strada', 'str.', 'Măzărachi', 'улица Мэзэраки', 3674, 'Strada Măzărachi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (519, 2000, 'Strada', 'str.', 'Nadejda Russo', 'улица Надежды Руссо', 3674, 'Strada Nadejda Russo') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (520, 2000, 'Strada', 'str.', 'Navigatorilor', 'улица Навигаторов', 3670, 'Strada Navigatorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (521, 2000, 'Strada', 'str.', 'Negreșteni', 'улица Негрештень', 3671, 'Strada Negreșteni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (522, 2000, 'Strada', 'str.', 'Negureni', 'улица Негурень', 3671, 'Strada Negureni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (523, 2000, 'Strada', 'str.', 'Nichita Smochină', 'улица Никиты Смокинэ', 3671, 'Strada Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (524, 2000, 'Stradela', 'str-la', 'Nichita Smochină', 'переулок Н. Смокинэ', 3671, 'Stradela Nichita Smochină') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (525, 2000, 'Strada', 'str.', 'Nichita Stănescu', 'улица Никиты Стэнеску', 3670, 'Strada Nichita Stănescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (526, 2000, 'Strada', 'str.', 'Nicolae Bălcescu', 'улица Николае Бэлческу', 3669, 'Strada Nicolae Bălcescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (527, 2000, 'Strada', 'str.', 'Nicolae Costin', 'Улица Николае Костина', 3669, 'Strada Nicolae Costin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (528, 2000, 'Strada', 'str.', 'Nicolae Dimo', 'улица Николая Димо', 3674, 'Strada Nicolae Dimo') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (529, 2000, 'Strada', 'str.', 'Nicolae Grigorescu', 'улица Николае Григореску', 3668, 'Strada Nicolae Grigorescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (530, 2000, 'Strada', 'str.', 'Nicolae Grădescu', 'улица Николае Грэдеску', 3670, 'Strada Nicolae Grădescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (531, 2000, 'Strada', 'str.', 'Nicolae Iorga', 'улица Николае Йорга', 3669, 'Strada Nicolae Iorga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (532, 2000, 'Strada', 'str.', 'Nicolae Milescu Spătaru', 'улица Николае Милеску Спэтару', 3668, 'Strada Nicolae Milescu Spătaru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (533, 2000, 'Strada', 'str.', 'Nicolae Milescu Spătarul', 'улица Николае Милеску Спэтару', 3668, 'Strada Nicolae Milescu Spătarul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (534, 2000, 'Stradela', 'str-la', 'Nicolae Milescu Spătarul', NULL, 3668, 'Stradela Nicolae Milescu Spătarul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (535, 2000, 'Strada', 'str.', 'Nicolae Moroșanu', 'улица Николая Морошану', 3671, 'Strada Nicolae Moroșanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (536, 2000, 'Strada', 'str.', 'Nicolae Sclifos', 'улица Николая Склифос', 3671, 'Strada Nicolae Sclifos') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (537, 2000, 'Strada', 'str.', 'Nicolae Starostenco', 'улица Николая Старостенко', 3671, 'Strada Nicolae Starostenco') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (538, 2000, 'Strada', 'str.', 'Nicolae Sulac', 'улица Николае Сулака', 3668, 'Strada Nicolae Sulac') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (539, 2000, 'Strada', 'str.', 'Nicolae Testemițanu', 'улица Николае Тестемицану', 3671, 'Strada Nicolae Testemițanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (540, 2000, 'Strada', 'str.', 'Nicolae Titulescu', 'улица Николае Титулеску', 3670, 'Strada Nicolae Titulescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (541, 2000, 'Strada', 'str.', 'Nicolai Pirogov', 'улица Николая Пирогова', 3671, 'Strada Nicolai Pirogov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (542, 2000, 'Strada', 'str.', 'Nikolai Berzarin', 'улица Николая Берзарина', 3674, 'Strada Nikolai Berzarin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (543, 2000, 'Strada', 'str.', 'Nikolai Zelinski', 'улица Николая Зелинского', 3670, 'Strada Nikolai Zelinski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (544, 2000, 'Strada', 'str.', 'Nucarilor', 'улица Нукарилор', 3671, 'Strada Nucarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (545, 2000, 'Stradela', 'str-la', 'Nucarilor', 'переулок Нукарилор', 3671, 'Stradela Nucarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (546, 2000, 'Strada', 'str.', 'Nuferilor', 'улица Нуферилор', 3670, 'Strada Nuferilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (547, 2000, 'Strada', 'str.', 'Octavian Goga', 'улица Октавиана Гоги', 3674, 'Strada Octavian Goga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (548, 2000, 'Strada', 'str.', 'Odesa', 'Одесская улица', 3671, 'Strada Odesa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (549, 2000, 'Strada', 'str.', 'Oituz', 'улица Оитуз', 3671, 'Strada Oituz') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (550, 2000, 'Strada', 'str.', 'Olga Vrabie', 'улица Ольги Врабие', 3674, 'Strada Olga Vrabie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (551, 2000, 'Strada', 'str.', 'Onești', 'улица Онешть', 3671, 'Strada Onești') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (552, 2000, 'Strada', 'str.', 'Onisifor Ghibu', 'улица Онисифора Гибу', 3669, 'Strada Onisifor Ghibu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (553, 2000, 'Strada', 'str.', 'Operațiunea Iași-Chișinău', 'улица Ясско-Кишинёвской операцией', 3674, 'Strada Operațiunea Iași-Chișinău') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (554, 2000, 'Strada', 'str.', 'Otopeni', 'улица Отопень', 3670, 'Strada Otopeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (555, 2000, 'Strada', 'str.', 'Otovasca', 'улица Отоваска', 3668, 'Strada Otovasca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (556, 2000, 'Strada', 'str.', 'Pajurii', 'улица Пажурий', 3674, 'Strada Pajurii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (557, 2000, 'Strada', 'str.', 'Pandurilor', 'улица Пандурилор', 3670, 'Strada Pandurilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (558, 2000, 'Strada', 'str.', 'Pantelimon Erhan', 'улица Пантелеймона Ерхана', 3670, 'Strada Pantelimon Erhan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (559, 2000, 'Piața', 'p-ța', 'Pantelimon Halippa', 'Площадь Пантелимон Халиппа', 3671, 'Piața Pantelimon Halippa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (560, 2000, 'Strada', 'str.', 'Pantelimon Halippa', 'улица Пантелеймона Халиппы', 3671, 'Strada Pantelimon Halippa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (561, 2000, 'Strada', 'str.', 'Parascovia Didîc', 'улица Прасковьи Дидыка', 3671, 'Strada Parascovia Didîc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (562, 2000, 'Stradela', 'str-la', 'Parcului', NULL, 3671, 'Stradela Parcului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (563, 2000, 'Strada', 'str.', 'Paris', 'Парижская улица', 3669, 'Strada Paris') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (564, 2000, 'Strada', 'str.', 'Paul Gore', 'улица Паула Горе', 3670, 'Strada Paul Gore') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (565, 2000, 'Strada', 'str.', 'Pavel Barbălat', 'улица Павла Барбэлата', 3674, 'Strada Pavel Barbălat') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (566, 2000, 'Strada', 'str.', 'Pavel Boțu', 'улица Павла Боцу', 3671, 'Strada Pavel Boțu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (567, 2000, 'Strada', 'str.', 'Pașcani', 'улица Пашкань', 3671, 'Strada Pașcani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (568, 2000, 'Strada', 'str.', 'Pedologul', NULL, 3671, 'Strada Pedologul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (569, 2000, 'Strada', 'str.', 'Perilor', 'улица Перилор', 3669, 'Strada Perilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (570, 2000, 'Strada', 'str.', 'Pescărușilor', 'улица Пескэрушилор', 3674, 'Strada Pescărușilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (571, 2000, 'Strada', 'str.', 'Petre Osmătescu', 'улица Петре Осмэтеску', 3670, 'Strada Petre Osmătescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (572, 2000, 'Strada', 'str.', 'Petre Ștefănucă', 'улица Петре Штефэнукэ', 3669, 'Strada Petre Ștefănucă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (573, 2000, 'Strada', 'str.', 'Petricani', 'Петриканская улица', 3674, 'Strada Petricani') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (574, 2000, 'Strada', 'str.', 'Petrodava', 'улица Петродава', 3668, 'Strada Petrodava') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (575, 2000, 'Strada', 'str.', 'Petru Leșcenco', 'улица Петра Лещенко', 3674, 'Strada Petru Leșcenco') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (576, 2000, 'Stradela', 'str-la', 'Petru Leșcenco', 'переулок Петра Лесченко', 3674, 'Stradela Petru Leșcenco') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (577, 2000, 'Strada', 'str.', 'Petru Maior', 'улица Петру Майор', 3674, 'Strada Petru Maior') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (578, 2000, 'Strada', 'str.', 'Petru Rareș', 'улица Петра Рареша', 3674, 'Strada Petru Rareș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (579, 2000, 'Strada', 'str.', 'Petru Ungureanu', 'улица Петре Унгуряну', 3670, 'Strada Petru Ungureanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (580, 2000, 'Strada', 'str.', 'Petru Zadnipru', 'улица Петру Заднипру', 3668, 'Strada Petru Zadnipru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (581, 2000, 'Strada', 'str.', 'Piața Veche', 'улица Пяца Веке', 3674, 'Strada Piața Veche') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (582, 2000, 'Strada', 'str.', 'Pictor Ion Jumati', 'улица Художника Иона Жумати', 3670, 'Strada Pictor Ion Jumati') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (583, 2000, 'Strada', 'str.', 'Pictor Mihai Grecu', 'улица Михая Греку', 3671, 'Strada Pictor Mihai Grecu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (584, 2000, 'Stradela', 'str-la', 'Pictor Mihai Grecu', 'переулок Михая Греку', 3671, 'Stradela Pictor Mihai Grecu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (585, 2000, 'Strada', 'str.', 'Pietrarilor', 'улица Пьетрарилор', 3671, 'Strada Pietrarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (586, 2000, 'Strada', 'str.', 'Pietrăriei', 'улица Пьетрэрией', 3674, 'Strada Pietrăriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (587, 2000, 'Strada', 'str.', 'Piotr Ceaikovski', 'улица Петра Чайковского', 3669, 'Strada Piotr Ceaikovski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (588, 2000, 'Strada', 'str.', 'Pitulicii', 'улица Питуличий', 3674, 'Strada Pitulicii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (589, 2000, 'Strada', 'str.', 'Plaiului', 'улица Плаюлуй', 3670, 'Strada Plaiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (590, 2000, 'Stradela', 'str-la', 'Plaiului', 'переулок Плаюлуй', 3670, 'Stradela Plaiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (591, 2000, 'Strada', 'str.', 'Plopilor', 'улица Плопилор', 3670, 'Strada Plopilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (592, 2000, 'Strada', 'str.', 'Plugarilor', 'улица Плугарилор', 3668, 'Strada Plugarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (593, 2000, 'Strada', 'str.', 'Poamei', 'улица Поамей', 3670, 'Strada Poamei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (594, 2000, 'Strada', 'str.', 'Podgorenilor', 'улица Подгоренилор', 3674, 'Strada Podgorenilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (595, 2000, 'Strada', 'str.', 'Podișului', 'улица Подишулуй', 3670, 'Strada Podișului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (596, 2000, 'Strada', 'str.', 'Podul de Flori', 'улица Подул де Флорь', 3670, 'Strada Podul de Flori') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (597, 2000, 'Strada', 'str.', 'Podul Înalt', 'улица Подул Ыналт', 3668, 'Strada Podul Înalt') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (598, 2000, 'Strada', 'str.', 'Poienilor', 'улица Поенилор', 3668, 'Strada Poienilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (599, 2000, 'Strada', 'str.', 'Pompierilor', NULL, 3670, 'Strada Pompierilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (600, 2000, 'Strada', 'str.', 'Porumbiței', 'улица Порумбицей', 3671, 'Strada Porumbiței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (601, 2000, 'Strada', 'str.', 'Porumbrele', 'улица Порумбреле', 3669, 'Strada Porumbrele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (602, 2000, 'Strada', 'str.', 'Poștei', 'улица Поштей', 3674, 'Strada Poștei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (603, 2000, 'Stradela', 'str-la', 'Poștei', 'переулок Поштей', 3674, 'Stradela Poștei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (604, 2000, 'Strada', 'str.', 'Praga', 'улица Прага', 3670, 'Strada Praga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (605, 2000, 'Strada', 'str.', 'Prigoreni', 'улица Пригорень', 3670, 'Strada Prigoreni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (606, 2000, 'Strada', 'str.', 'Primar Carol Schmidt', 'улица Примара Карла Шмидта', 3671, 'Strada Primar Carol Schmidt') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (607, 2000, 'Strada', 'str.', 'Primar Gherman Pântea', 'улица Примар Германа Пынти', 3674, 'Strada Primar Gherman Pântea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (608, 2000, 'Stradela', 'str-la', 'Primar Gherman Pântea', 'переулок Г. Пынтя', 3674, 'Stradela Primar Gherman Pântea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (609, 2000, 'Strada', 'str.', 'Primar Gherman Pîntea', 'улица Германа Пынти', 3674, 'Strada Primar Gherman Pîntea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (610, 2000, 'Strada', 'str.', 'Primăverii', 'Весенняя улица', 3669, 'Strada Primăverii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (611, 2000, 'Strada', 'str.', 'Profesor Ion Dumeniuc', 'улица Профессор Ион Думенюк', 3668, 'Strada Profesor Ion Dumeniuc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (612, 2000, 'Strada', 'str.', 'Protoiereu Mihail Berezovschi', 'улица Михаила Березовского', 3671, 'Strada Protoiereu Mihail Berezovschi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (613, 2000, 'Strada', 'str.', 'Prunului', 'улица Прунулуй', 3669, 'Strada Prunului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (614, 2000, 'Strada', 'str.', 'Puhoi', 'улица Пухой', 3670, 'Strada Puhoi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (615, 2000, 'Strada', 'str.', 'Putnei', 'улица Путней', 3674, 'Strada Putnei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (616, 2000, 'Strada', 'str.', 'Pădurii', 'Лесная улица', 3670, 'Strada Pădurii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (617, 2000, 'Stradela', 'str-la', 'Pădurii', 'переулок Пэдурий', 3670, 'Stradela Pădurii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (618, 2000, 'Strada', 'str.', 'Pășunilor', 'улица Пэшунилор', 3670, 'Strada Pășunilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (619, 2000, 'Strada', 'str.', 'Rabbi Țirelson', 'улица Раввина Цирельсон', 3674, 'Strada Rabbi Țirelson') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (620, 2000, 'Strada', 'str.', 'Rabbi Țirilson', 'улица Раввина Цирельсон', 3674, 'Strada Rabbi Țirilson') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (621, 2000, 'Strada', 'str.', 'Rariștei', 'улица Рариштей', 3669, 'Strada Rariștei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (622, 2000, 'Strada', 'str.', 'Ratuș', 'улица Ратуш', 3668, 'Strada Ratuș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (623, 2000, 'Bulevardul', 'bd.', 'Renașterii Naționale', 'проспект Ренаштерий Национале', 3674, 'Bulevardul Renașterii Naționale') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (624, 2000, 'Piața', 'p-ța', 'Renașterii Naționale', 'площадь Национального Возрождения', 3674, 'Piața Renașterii Naționale') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (625, 2000, 'Strada', 'str.', 'Revaca', 'улица Ревака', 3670, 'Strada Revaca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (626, 2000, 'Strada', 'str.', 'Riga', 'Рижская улица', 3670, 'Strada Riga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (627, 2000, 'Strada', 'str.', 'Robbie Williams', 'Улица Робби Уильямс', 3671, 'Strada Robbie Williams') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (628, 2000, 'Strada', 'str.', 'Roguleni', 'улица Рогулень', 3671, 'Strada Roguleni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (629, 2000, 'Strada', 'str.', 'Romantica', 'улица Романтика', 3671, 'Strada Romantica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (630, 2000, 'Stradela', 'str-la', 'Romantica', 'переулок Романтика', 3671, 'Stradela Romantica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (631, 2000, 'Strada', 'str.', 'Romană', 'улица Романэ', 3674, 'Strada Romană') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (632, 2000, 'Strada', 'str.', 'Rovinari', 'улица Ровинарь', 3671, 'Strada Rovinari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (633, 2000, 'Strada', 'str.', 'Roșiori', 'улица Рошиорь', 3669, 'Strada Roșiori') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (634, 2000, 'Strada', 'str.', 'Rândunele', 'улица Рындунеле', 3671, 'Strada Rândunele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (635, 2000, 'Strada', 'str.', 'Rîndunele', 'улица Рындунеле', 3671, 'Strada Rîndunele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (636, 2000, 'Strada', 'str.', 'Salcâmilor', 'улица Салкымилор', 3670, 'Strada Salcâmilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (637, 2000, 'Strada', 'str.', 'Sargidava', 'улица Сарджидава', 3668, 'Strada Sargidava') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (638, 2000, 'Strada', 'str.', 'Sarmizegetusa', 'улица Сармизеджетуса', 3670, 'Strada Sarmizegetusa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (639, 2000, 'Strada', 'str.', 'Schinoasa', 'улица Скиноаса', 3671, 'Strada Schinoasa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (640, 2000, 'Stradela', 'str-la', 'Schinoșica', '1-й переулок Друмул Скиноасей', 3671, 'Stradela Schinoșica') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (641, 2000, 'Strada', 'str.', 'Schitului', 'улица Скитулуй', 3669, 'Strada Schitului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (642, 2000, 'Strada', 'str.', 'Scoreni', 'улица Скорень', 3671, 'Strada Scoreni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (643, 2000, 'Strada', 'str.', 'Scutari', 'улица Скутарь', 3670, 'Strada Scutari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (644, 2000, 'Strada', 'str.', 'Semion Timoșenko', 'улица Семёна Тимошенко', 3674, 'Strada Semion Timoșenko') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (645, 2000, 'Strada', 'str.', 'Serghei Lazo', 'улица Сергея Лазо', 3669, 'Strada Serghei Lazo') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (646, 2000, 'Strada', 'str.', 'Serghei Lunchevici', 'улица Сергея Лункевича', 3669, 'Strada Serghei Lunchevici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (647, 2000, 'Strada', 'str.', 'Serghei Rahmaninov', 'улица Сергея Рахманинова', 3669, 'Strada Serghei Rahmaninov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (648, 2000, 'Strada', 'str.', 'Sergiu Coipan', 'улица Серджиу Койпана', 3674, 'Strada Sergiu Coipan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (649, 2000, 'Strada', 'str.', 'Sergiu Rădăuțanu', 'улица Серджиу Рэдэуцану', 3671, 'Strada Sergiu Rădăuțanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (650, 2000, 'Strada', 'str.', 'Sfatul Țării', 'улица Сфатул Цэрий', 3669, 'Strada Sfatul Țării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (651, 2000, 'Strada', 'str.', 'Sfânta Treime', 'улица Святой Троицы', 3670, 'Strada Sfânta Treime') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (652, 2000, 'Strada', 'str.', 'Sfânta Vineri', 'улица Сфынта Винерь', 3671, 'Strada Sfânta Vineri') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (653, 2000, 'Stradela', 'str-la', 'Sfânta Vineri', 'переулок Сфынта Винерь', 3671, 'Stradela Sfânta Vineri') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (654, 2000, 'Strada', 'str.', 'Sfântul Andrei', 'улица Святого Андрея', 3674, 'Strada Sfântul Andrei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (655, 2000, 'Stradela', 'str-la', 'Sfântul Andrei', 'переулок Святого Андрея', 3674, 'Stradela Sfântul Andrei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (656, 2000, 'Strada', 'str.', 'Sfântul Gheorghe', 'улица Святого Георгия', 3674, 'Strada Sfântul Gheorghe') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (657, 2000, 'Strada', 'str.', 'Sfântul Ilie', 'улица Святого Илии', 3674, 'Strada Sfântul Ilie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (658, 2000, 'Strada', 'str.', 'Sfântul Petru', 'улица Святого Апостола Павла', 3674, 'Strada Sfântul Petru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (659, 2000, 'Strada', 'str.', 'Sfînta Parascheva', NULL, 3668, 'Strada Sfînta Parascheva') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (660, 2000, 'Strada', 'str.', 'Sfîntul Gheorghe', NULL, 3674, 'Strada Sfîntul Gheorghe') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (661, 2000, 'Strada', 'str.', 'Sihastrului', 'улица Сихаструлуй', 3671, 'Strada Sihastrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (662, 2000, 'Strada', 'str.', 'Simeon Murafa', 'улица Симеона Мурафы', 3670, 'Strada Simeon Murafa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (663, 2000, 'Strada', 'str.', 'Soarelui', 'улица Соарелуй', 3670, 'Strada Soarelui') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (664, 2000, 'Strada', 'str.', 'Socilor', 'улица Сочилор', 3671, 'Strada Socilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (665, 2000, 'Strada', 'str.', 'Socoleni', 'улица Соколень', 3674, 'Strada Socoleni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (666, 2000, 'Strada', 'str.', 'Sofia', 'улица София', 3670, 'Strada Sofia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (667, 2000, 'Strada', 'str.', 'Solidarității', 'улица Солидаритэций', 3674, 'Strada Solidarității') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (668, 2000, 'Strada', 'str.', 'Spartacus', 'улица Спартакус', 3674, 'Strada Spartacus') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (669, 2000, 'Strada', 'str.', 'Speranța', 'улица Сперанца', 3668, 'Strada Speranța') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (670, 2000, 'Strada', 'str.', 'Speranței', 'улица Сперанцей', 3671, 'Strada Speranței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (671, 2000, 'Strada', 'str.', 'Spicului', 'улица Спикулуй', 3671, 'Strada Spicului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (672, 2000, 'Strada', 'str.', 'Sprâncenoaia', 'улица Спрынченоая', 3671, 'Strada Sprâncenoaia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (673, 2000, 'Strada', 'str.', 'Stejarilor', 'улица Стежарилор', 3668, 'Strada Stejarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (674, 2000, 'Strada', 'str.', 'Stejarului', NULL, 3668, 'Strada Stejarului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (675, 2000, 'Stradela', 'str-la', 'Stejăreni', 'переулок Стежэрень', 3671, 'Stradela Stejăreni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (676, 2000, 'Strada', 'str.', 'Stolniceni', 'улица Столничень', 3670, 'Strada Stolniceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (677, 2000, 'Strada', 'str.', 'Strășeni', 'улица Стрэшень', 3674, 'Strada Strășeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (678, 2000, 'Strada', 'str.', 'Studenților', 'Студенческая улица', 3674, 'Strada Studenților') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (679, 2000, 'Stradela', 'str-la', 'Studenților', 'Студенческий переулок', 3674, 'Stradela Studenților') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (680, 2000, 'Strada', 'str.', 'Suceava', 'улица Сучава', 3669, 'Strada Suceava') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (681, 2000, 'Strada', 'str.', 'Sucevița', 'улица Сучевица', 3669, 'Strada Sucevița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (682, 2000, 'Strada', 'str.', 'Suruceni', 'улица Суручень', 3671, 'Strada Suruceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (683, 2000, 'Strada', 'str.', 'Sârbească', 'Сербская улица', 3674, 'Strada Sârbească') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (684, 2000, 'Strada', 'str.', 'Sălcuța', 'улица Сэлкуца', 3669, 'Strada Sălcuța') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (685, 2000, 'Strada', 'str.', 'Sărăteni', 'улица Сэрэтень', 3671, 'Strada Sărăteni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (686, 2000, 'Strada', 'str.', 'Tadeuș Malinovschi', 'улица Тадеуша Малиновского', 3671, 'Strada Tadeuș Malinovschi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (687, 2000, 'Strada', 'str.', 'Tamara Ceban', 'улица Тамары Чебан', 3669, 'Strada Tamara Ceban') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (688, 2000, 'Strada', 'str.', 'Tatarbunar', 'улица Татарбунар', 3671, 'Strada Tatarbunar') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (689, 2000, 'Strada', 'str.', 'Tașkent', 'Ташкентская улица', 3670, 'Strada Tașkent') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (690, 2000, 'Stradela', 'str-la', 'Teatrului', 'Театральный переулок', 3669, 'Stradela Teatrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (691, 2000, 'Strada', 'str.', 'Tecuci', 'улица Текуч', 3671, 'Strada Tecuci') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (692, 2000, 'Strada', 'str.', 'Teilor', 'улица Теилор', 3670, 'Strada Teilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (693, 2000, 'Strada', 'str.', 'Teodor Aman', 'улица Теодора Амана', 3671, 'Strada Teodor Aman') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (694, 2000, 'Strada', 'str.', 'Teodor Malai', NULL, 3671, 'Strada Teodor Malai') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (695, 2000, 'Strada', 'str.', 'Tighina', 'улица Тигина', 3671, 'Strada Tighina') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (696, 2000, 'Strada', 'str.', 'Timiș', 'улица Тимиш', 3671, 'Strada Timiș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (697, 2000, 'Strada', 'str.', 'Timișoara', 'улица Тимишоара', 3674, 'Strada Timișoara') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (698, 2000, 'Strada', 'str.', 'Tiras', 'улица Тирас', 3670, 'Strada Tiras') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (699, 2000, 'Strada', 'str.', 'Tiraspol', 'Тираспольская улица', 3671, 'Strada Tiraspol') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (700, 2000, 'Strada', 'str.', 'Tisa', 'улица Тиса', 3671, 'Strada Tisa') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (701, 2000, 'Strada', 'str.', 'Titu Maiorescu', 'улица Титу Майореску', 3674, 'Strada Titu Maiorescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (702, 2000, 'Strada', 'str.', 'Toamnei', 'улица Тоамней', 3669, 'Strada Toamnei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (703, 2000, 'Strada', 'str.', 'Toma Ciorbă', 'улица Тома Чорбэ', 3669, 'Strada Toma Ciorbă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (704, 2000, 'Strada', 'str.', 'Tomis', 'улица Томиш', 3670, 'Strada Tomis') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (705, 2000, 'Strada', 'str.', 'Toporașilor', 'улица Топорашилор', 3669, 'Strada Toporașilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (706, 2000, 'Strada', 'str.', 'Torino', 'улица Торино', 3669, 'Strada Torino') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (707, 2000, 'Bulevardul', 'bd.', 'Traian', 'проспект Траян', 3670, 'Bulevardul Traian') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (708, 2000, 'Strada', 'str.', 'Trandafirilor', 'улица Трандафирилор', 3670, 'Strada Trandafirilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (709, 2000, 'Strada', 'str.', 'Transnistria', 'улица Транснистрия', 3668, 'Strada Transnistria') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (710, 2000, 'Strada', 'str.', 'Trei Crai', 'улица Трей Край', 3669, 'Strada Trei Crai') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (711, 2000, 'Strada', 'str.', 'Tricolorului', 'улица Триколора', 3669, 'Strada Tricolorului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (712, 2000, 'Strada', 'str.', 'Trifan Baltă', 'улица Трифана Балтэ', 3671, 'Strada Trifan Baltă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (713, 2000, 'Strada', 'str.', 'Trușeni', 'улица Трушень', 3669, 'Strada Trușeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (714, 2000, 'Strada', 'str.', 'Tudor Panfile', 'улица Тудора Панфиле', 3674, 'Strada Tudor Panfile') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (715, 2000, 'Strada', 'str.', 'Tudor Vladimirescu', 'улица Тудора Владимиреску', 3674, 'Strada Tudor Vladimirescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (716, 2000, 'Strada', 'str.', 'Turturele', 'улица Туртуреле', 3671, 'Strada Turturele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (717, 2000, 'Strada', 'str.', 'Târgoviște', 'улица Тырговиште', 3668, 'Strada Târgoviște') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (718, 2000, 'Strada', 'str.', 'Tăbăcăria Nouă', 'улица Тэбэкэрия Ноуэ', 3670, 'Strada Tăbăcăria Nouă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (719, 2000, 'Strada', 'str.', 'Tăbăcăria Veche', 'улица Тэбэкэрия Веке', 3671, 'Strada Tăbăcăria Veche') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (720, 2000, 'Piața', 'p-ța', 'Unirea Principatelor', NULL, 3669, 'Piața Unirea Principatelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (721, 2000, 'Strada', 'str.', 'Universității', 'Университетская улица', 3671, 'Strada Universității') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (722, 2000, 'Strada', 'str.', 'Uzinelor', 'Заводская улица', 3668, 'Strada Uzinelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (723, 2000, 'Stradela', 'str-la', 'Uzinelor', 'переулок Узинелор', 3668, 'Stradela Uzinelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (724, 2000, 'Stradela', 'str-la', 'V. Cheltuiala', 'переулок В. Келтуяла', 3671, 'Stradela V. Cheltuiala') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (725, 2000, 'Strada', 'str.', 'Vadul Bâcului', 'улица Вадул Быкулуй', 3670, 'Strada Vadul Bâcului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (726, 2000, 'Strada', 'str.', 'Vadul lui Vodă', 'Вадул-луй-Водская улица', 3668, 'Strada Vadul lui Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (727, 2000, 'Strada', 'str.', 'Valea Albă', 'улица Валя Албэ', 3674, 'Strada Valea Albă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (728, 2000, 'Strada', 'str.', 'Valea Bîcului', 'улица Валя Быкулуй', 3670, 'Strada Valea Bîcului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (729, 2000, 'Strada', 'str.', 'Valea Crucii', 'улица Валя Кручий', 3670, 'Strada Valea Crucii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (730, 2000, 'Strada', 'str.', 'Valea Dicescu', 'улица Валя Дическу', 3671, 'Strada Valea Dicescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (731, 2000, 'Strada', 'str.', 'Valea Podului', 'улица Валя Подулуй', 3671, 'Strada Valea Podului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (732, 2000, 'Strada', 'str.', 'Valea Rădiului', 'улица Валеа Рэдюлуй', 3671, 'Strada Valea Rădiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (733, 2000, 'Strada', 'str.', 'Valea Trandafirilor', 'улица Валя Трандафирилор', 3671, 'Strada Valea Trandafirilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (734, 2000, 'Strada', 'str.', 'Valentin Guțu', 'улица Валентина Гуцу', 3671, 'Strada Valentin Guțu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (735, 2000, 'Strada', 'str.', 'Valentin Roșca', 'улица Валентина Рошки', 3674, 'Strada Valentin Roșca') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (736, 2000, 'Strada', 'str.', 'Valentin Zarzăr', NULL, 3670, 'Strada Valentin Zarzăr') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (737, 2000, 'Stradela', 'str-la', 'Valentin Zarzăr', 'переулок Валентина Зарзара', 3670, 'Stradela Valentin Zarzăr') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (738, 2000, 'Strada', 'str.', 'Valeri Cicalov', 'улица Валерия Чкалова', 3670, 'Strada Valeri Cicalov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (739, 2000, 'Strada', 'str.', 'Valeriu Cupcea', 'улица Валерия Купчи', 3671, 'Strada Valeriu Cupcea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (740, 2000, 'Strada', 'str.', 'Valeriu Dumbravă', 'улица Валериу Думбравэ', 3668, 'Strada Valeriu Dumbravă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (741, 2000, 'Strada', 'str.', 'Varnița', 'улица Варница', 3668, 'Strada Varnița') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (742, 2000, 'Strada', 'str.', 'Varșovia', 'Варшавская улица', 3670, 'Strada Varșovia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (743, 2000, 'Strada', 'str.', 'Vasile Alecsandri', 'улица Василе Александри', 3671, 'Strada Vasile Alecsandri') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (744, 2000, 'Strada', 'str.', 'Vasile Badiu', 'улица Василе Бадю', 3674, 'Strada Vasile Badiu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (745, 2000, 'Strada', 'str.', 'Vasile Cheltuială', 'улица Василе Келтуялэ', 3671, 'Strada Vasile Cheltuială') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (746, 2000, 'Strada', 'str.', 'Vasile Coroban', 'улица Василия Коробана', 3669, 'Strada Vasile Coroban') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (747, 2000, 'Strada', 'str.', 'Vasile Kovtun', 'улица В. Ковтуна', 3671, 'Strada Vasile Kovtun') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (748, 2000, 'Stradela', 'str-la', 'Vasile Kovtun', 'переулок В. Ковтуна', 3671, 'Stradela Vasile Kovtun') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (749, 2000, 'Strada', 'str.', 'Vasile Lupu', 'улица Василе Лупу', 3669, 'Strada Vasile Lupu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (750, 2000, 'Strada', 'str.', 'Vasile Pogor', 'улица Василе Погор', 3669, 'Strada Vasile Pogor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (751, 2000, 'Strada', 'str.', 'Vasile Stroiescu', 'улица Василия Строеску', 3669, 'Strada Vasile Stroiescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (752, 2000, 'Strada', 'str.', 'Vasile Vărzaru', 'улица Василе Вэрзару', 3668, 'Strada Vasile Vărzaru') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (753, 2000, 'Strada', 'str.', 'Vasile Țepordei', NULL, 3674, 'Strada Vasile Țepordei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (754, 2000, 'Strada', 'str.', 'Vasili Dokuceaev', 'улица Василия Докучаева', 3671, 'Strada Vasili Dokuceaev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (755, 2000, 'Strada', 'str.', 'Vasilie Harea', 'улица Василия Харя', 3674, 'Strada Vasilie Harea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (756, 2000, 'Strada', 'str.', 'Vaslui', 'улица Васлуй', 3668, 'Strada Vaslui') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (757, 2000, 'Strada', 'str.', 'Veronica Micle', 'улица Вероники Микле', 3671, 'Strada Veronica Micle') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (758, 2000, 'Strada', 'str.', 'Victor Crăsescu', 'улица Виктора Крэсеску', 3674, 'Strada Victor Crăsescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (759, 2000, 'Stradela', 'str-la', 'Victor Crăsescu', 'переулок Виктора Крэсеску', 3674, 'Stradela Victor Crăsescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (760, 2000, 'Strada', 'str.', 'Victoriei', NULL, 3668, 'Strada Victoriei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (761, 2000, 'Strada', 'str.', 'Vierul', 'улица Виеру', 3671, 'Strada Vierul') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (762, 2000, 'Strada', 'str.', 'Viilor', 'улица Виилор', 3670, 'Strada Viilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (763, 2000, 'Strada', 'str.', 'Virtuții', 'улица Виртуций', 3669, 'Strada Virtuții') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (764, 2000, 'Strada', 'str.', 'Vissarion Belinski', 'улица Виссариона Белинского', 3669, 'Strada Vissarion Belinski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (765, 2000, 'Strada', 'str.', 'Visterniceni', 'Улица Вистерничень', 3674, 'Strada Visterniceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (766, 2000, 'Strada', 'str.', 'Vitalie Tulnic', 'улица Виталия Тулника', 3670, 'Strada Vitalie Tulnic') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (767, 2000, 'Strada', 'str.', 'Vișinilor', 'улица Вишинилор', 3669, 'Strada Vișinilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (768, 2000, 'Strada', 'str.', 'Vlad Ioviță', 'улица Влада Ловицэ', 3670, 'Strada Vlad Ioviță') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (769, 2000, 'Strada', 'str.', 'Vlad Țepeș', 'улица Влада Цепеша', 3671, 'Strada Vlad Țepeș') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (770, 2000, 'Strada', 'str.', 'Vladimir Buzescu', 'улица Владимира Бузеску', 3668, 'Strada Vladimir Buzescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (771, 2000, 'Stradela', 'str-la', 'Vladimir Komarov', 'переулок Владимира Комарова', 3674, 'Stradela Vladimir Komarov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (772, 2000, 'Strada', 'str.', 'Vladimir Korolenko', 'улица Владимира Короленко', 3671, 'Strada Vladimir Korolenko') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (773, 2000, 'Strada', 'str.', 'Vladimir Maiakovski', 'улица Владимира Маяковского', 3668, 'Strada Vladimir Maiakovski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (774, 2000, 'Strada', 'str.', 'Vlaicu Pârcălab', 'улица Влайку Пыркэлаб', 3671, 'Strada Vlaicu Pârcălab') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (775, 2000, 'Strada', 'str.', 'Voievozilor', 'улица Воевозилор', 3669, 'Strada Voievozilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (776, 2000, 'Strada', 'str.', 'Voluntar Filip Lupașcu', NULL, 3674, 'Strada Voluntar Filip Lupașcu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (777, 2000, 'Strada', 'str.', 'Voluntar Grigore Vîrtosu', 'улица Гр. Выртосу', 3674, 'Strada Voluntar Grigore Vîrtosu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (778, 2000, 'Strada', 'str.', 'Voluntarilor', 'улица Волунтарилор', 3668, 'Strada Voluntarilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (779, 2000, 'Strada', 'str.', 'Vorniceni', 'улица Ворничень', 3670, 'Strada Vorniceni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (780, 2000, 'Strada', 'str.', 'Vovințeni', 'улица Вовинцень', 3669, 'Strada Vovințeni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (781, 2000, 'Strada', 'str.', 'Vâlcele', 'улица Вылчеле', 3671, 'Strada Vâlcele') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (782, 2000, 'Strada', 'str.', 'Vâlcov', 'улица Вылков', 3670, 'Strada Vâlcov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (783, 2000, 'Strada', 'str.', 'Vânătorilor', 'улица Вынэторилор', 3671, 'Strada Vânătorilor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (784, 2000, 'Strada', 'str.', 'Văleni', 'улица Вэлень', 3671, 'Strada Văleni') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (785, 2000, 'Strada', 'str.', 'Zagreb', 'Загребская улица', 3670, 'Strada Zagreb') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (786, 2000, 'Strada', 'str.', 'Zaim', 'улица Заим', 3671, 'Strada Zaim') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (787, 2000, 'Strada', 'str.', 'Zamfir Arbore', 'улица Замфира Арборе', 3674, 'Strada Zamfir Arbore') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (788, 2000, 'Strada', 'str.', 'Zamolxe', 'улица Замолксе', 3674, 'Strada Zamolxe') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (789, 2000, 'Strada', 'str.', 'Zimbrului', 'улица Зимбрулуй', 3674, 'Strada Zimbrului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (790, 2000, 'Strada', 'str.', 'Zmeurei', 'улица Змеурей', 3670, 'Strada Zmeurei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (791, 2000, 'Strada', 'str.', 'Zodiac', 'улица Зодиак', 3671, 'Strada Zodiac') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (792, 2000, 'Stradela', 'str-la', 'Zoporjie', NULL, 3671, 'Stradela Zoporjie') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (793, 2000, 'Strada', 'str.', 'Zăvoiului', 'улица Зэвоюлуй', 3669, 'Strada Zăvoiului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (794, 2000, 'Strada', 'str.', 'Învierii', 'улица Ынвиерий', 3670, 'Strada Învierii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (795, 2000, 'Strada', 'str.', 'Înălțării', 'улица Ынэлцэрий', 3670, 'Strada Înălțării') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (796, 2000, 'Strada', 'str.', 'Șoimari', 'улица Шоймарь', 3670, 'Strada Șoimari') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (797, 2000, 'Bulevardul', 'bd.', 'Ștefan cel Mare și Sfânt', 'бульвар Штефан чел Маре ши Сфынт', 3669, 'Bulevardul Ștefan cel Mare și Sfânt') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (798, 2000, 'Strada', 'str.', 'Ștefan Ciobanu', 'улица Штефана Чобану', 3670, 'Strada Ștefan Ciobanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (799, 2000, 'Strada', 'str.', 'Ștefan Holban', 'улица Штефана Холбана', 3670, 'Strada Ștefan Holban') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (800, 2000, 'Strada', 'str.', 'Ștefan Luchian', 'улица Штефана Лукьяна', 3669, 'Strada Ștefan Luchian') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (801, 2000, 'Strada', 'str.', 'Ștefan Neaga', 'улица Степана Няги', 3669, 'Strada Ștefan Neaga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (802, 2000, 'Stradela', 'str-la', 'Ștefan Neaga', 'переулок Степана Няги', 3669, 'Stradela Ștefan Neaga') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (803, 2000, 'Strada', 'str.', 'Țarinei', 'улица Цариней', 3669, 'Strada Țarinei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (804, 2000, 'Strada', 'str.', 'Țarinii', 'улица Цариний', 3669, 'Strada Țarinii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (805, 2000, 'Strada', 'str.', 'Țicau', 'улица Цикэу', 3670, 'Strada Țicau') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (806, 2000, 'Strada', 'str.', 'Al. Hîjdeu', NULL, 3674, 'Strada Al. Hîjdeu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (807, 2000, 'Strada', 'str.', 'Alecu Donici', NULL, 3669, 'Strada Alecu Donici') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (808, 2000, 'Strada', 'str.', 'Alexandru Bernardazzi', NULL, 3671, 'Strada Alexandru Bernardazzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (809, 2000, 'Strada', 'str.', 'Avocat Eugenia Grușevan', NULL, 3671, 'Strada Avocat Eugenia Grușevan') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (810, 2000, 'Strada', 'str.', 'Bacu', NULL, 3670, 'Strada Bacu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (811, 2000, 'Strada', 'str.', 'Bucovinei', NULL, 3668, 'Strada Bucovinei') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (812, 2000, 'Strada', 'str.', 'C. Virnav', NULL, 3671, 'Strada C. Virnav') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (813, 2000, 'Strada', 'str.', 'Dante', NULL, 3670, 'Strada Dante') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (814, 2000, 'Strada', 'str.', 'Diminiței', NULL, 3670, 'Strada Diminiței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (815, 2000, 'Strada', 'str.', 'Dimitrie Moruzi', NULL, 3670, 'Strada Dimitrie Moruzi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (816, 2000, 'Strada', 'str.', 'Domnie Timonu', NULL, 3669, 'Strada Domnie Timonu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (817, 2000, 'Strada', 'str.', 'George Bacovia', NULL, 3671, 'Strada George Bacovia') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (818, 2000, 'Strada', 'str.', 'Gheorghe Bezviconi', NULL, 3670, 'Strada Gheorghe Bezviconi') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (819, 2000, 'Strada', 'str.', 'Gheorghe Meniuc', NULL, 3671, 'Strada Gheorghe Meniuc') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (820, 2000, 'Strada', 'str.', 'Ion Inchuleț', NULL, 3671, 'Strada Ion Inchuleț') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (821, 2000, 'Strada', 'str.', 'L. Damian', NULL, 3674, 'Strada L. Damian') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (822, 2000, 'Strada', 'str.', 'Lămâiței', NULL, 3671, 'Strada Lămâiței') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (823, 2000, 'Strada', 'str.', 'Liuba Dimitriu', NULL, 3670, 'Strada Liuba Dimitriu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (824, 2000, 'Strada', 'str.', 'Maria Lătărețu (Musorgski)', NULL, 3669, 'Strada Maria Lătărețu (Musorgski)') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (825, 2000, 'Strada', 'str.', 'Mihail Ceachir', NULL, 3671, 'Strada Mihail Ceachir') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (826, 2000, 'Strada', 'str.', 'Mitropolitul Petru Movilă', NULL, 3669, 'Strada Mitropolitul Petru Movilă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (827, 2000, 'Strada', 'str.', 'Mitropolitul Varlaam', NULL, 3671, 'Strada Mitropolitul Varlaam') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (828, 2000, 'Strada', 'str.', 'Nicolae Anestiade', NULL, 3671, 'Strada Nicolae Anestiade') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (829, 2000, 'Strada', 'str.', 'Nicolae H. Costin', NULL, 3669, 'Strada Nicolae H. Costin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (830, 2000, 'Strada', 'str.', 'Nicolai Zelinski', NULL, 3670, 'Strada Nicolai Zelinski') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (831, 2000, 'Strada', 'str.', 'Otovaska', NULL, 3668, 'Strada Otovaska') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (832, 2000, 'Strada', 'str.', 'Petre Ungureanu', NULL, 3670, 'Strada Petre Ungureanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (833, 2000, 'Strada', 'str.', 'Poienelor', NULL, 3668, 'Strada Poienelor') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (834, 2000, 'Strada', 'str.', 'Rariștii', NULL, 3669, 'Strada Rariștii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (835, 2000, 'Strada', 'str.', 'Tallin', NULL, 3670, 'Strada Tallin') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (836, 2000, 'Strada', 'str.', 'Tamara Ciobanu', NULL, 3669, 'Strada Tamara Ciobanu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (837, 2000, 'Strada', 'str.', 'V. Belinskii', NULL, 3669, 'Strada V. Belinskii') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (838, 2000, 'Strada', 'str.', 'V. Crăsescu', NULL, 3674, 'Strada V. Crăsescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (839, 2000, 'Strada', 'str.', 'Valea Rediului', NULL, 3671, 'Strada Valea Rediului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (840, 2000, 'Strada', 'str.', 'Valeri Cikalov', NULL, 3670, 'Strada Valeri Cikalov') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (841, 2000, 'Strada', 'str.', 'Vasile Harea', NULL, 3674, 'Strada Vasile Harea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (842, 2000, 'Strada', 'str.', 'Vasile Stroescu', NULL, 3669, 'Strada Vasile Stroescu') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (843, 2000, 'Strada', 'str.', 'Vasilii Dokuceaev', NULL, 3671, 'Strada Vasilii Dokuceaev') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (844, 2000, 'Strada', 'str.', 'Vintilă Horea', NULL, 3670, 'Strada Vintilă Horea') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (845, 2000, 'Stradela', 'str-la', '1 Aerodromului', NULL, 3674, 'Stradela 1 Aerodromului') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (846, 2000, 'Stradela', 'str-la', 'Avicena', NULL, 3671, 'Stradela Avicena') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (847, 2000, 'Stradela', 'str-la', 'Dinu Lipati', NULL, 3670, 'Stradela Dinu Lipati') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (848, 2000, 'Stradela', 'str-la', 'Florării 1', NULL, 3674, 'Stradela Florării 1') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (849, 2000, 'Stradela', 'str-la', 'Florării 2', NULL, 3674, 'Stradela Florării 2') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (850, 2000, 'Stradela', 'str-la', 'Ghica Vodă;Stradela Ghica-Vodă', NULL, 3670, 'Stradela Ghica Vodă;Stradela Ghica-Vodă') MATCHING (STREETID);
UPDATE OR INSERT INTO TS_STREETS (STREETID, CITYID, STREET_TYPE, SHORT_TYPE, TITLE, TITLE_RUS, SECTORID, SRC_NAME) VALUES (851, 2000, 'Stradela', 'str-la', 'Zaporojie', NULL, 3671, 'Stradela Zaporojie') MATCHING (STREETID);

COMMIT;

/* --- 5. Import: sectoarele strazilor (941) ------------------------------- */
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (1, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (2, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (3, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (4, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (5, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (6, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (7, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (8, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (9, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (9, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (10, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (11, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (12, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (13, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (14, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (15, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (16, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (17, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (18, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (19, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (20, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (21, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (22, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (23, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (24, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (25, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (26, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (27, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (28, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (29, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (30, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (31, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (32, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (33, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (34, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (35, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (36, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (37, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (38, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (39, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (39, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (40, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (41, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (42, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (43, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (44, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (45, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (46, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (47, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (48, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (49, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (50, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (51, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (52, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (53, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (54, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (54, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (55, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (56, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (57, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (58, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (59, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (60, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (61, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (62, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (63, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (64, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (65, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (65, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (65, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (66, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (67, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (68, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (69, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (69, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (70, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (70, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (71, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (72, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (72, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (72, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (73, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (74, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (75, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (75, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (76, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (77, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (78, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (79, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (80, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (81, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (82, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (83, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (83, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (84, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (85, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (86, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (87, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (87, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (88, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (88, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (89, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (90, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (91, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (92, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (93, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (94, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (95, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (96, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (97, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (98, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (99, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (100, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (101, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (102, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (103, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (104, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (105, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (106, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (106, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (107, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (108, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (109, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (110, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (111, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (112, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (112, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (113, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (114, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (115, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (116, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (117, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (118, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (119, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (120, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (121, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (122, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (123, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (124, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (125, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (126, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (126, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (127, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (128, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (129, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (130, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (130, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (131, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (131, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (132, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (133, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (134, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (135, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (136, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (137, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (138, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (139, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (140, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (141, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (142, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (143, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (144, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (145, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (146, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (147, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (148, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (149, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (149, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (150, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (151, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (152, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (153, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (154, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (155, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (156, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (157, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (158, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (159, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (159, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (160, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (161, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (161, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (162, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (163, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (164, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (165, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (166, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (167, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (168, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (169, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (169, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (170, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (171, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (172, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (173, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (173, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (174, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (175, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (176, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (177, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (177, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (178, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (179, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (180, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (181, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (181, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (182, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (183, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (184, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (185, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (186, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (187, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (188, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (189, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (190, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (191, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (192, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (193, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (194, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (195, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (196, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (197, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (198, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (199, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (200, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (201, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (202, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (203, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (204, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (205, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (206, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (207, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (208, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (209, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (210, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (211, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (211, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (211, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (212, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (213, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (214, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (215, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (216, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (217, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (218, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (219, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (220, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (221, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (222, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (223, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (223, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (224, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (224, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (225, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (226, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (227, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (228, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (229, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (229, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (230, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (231, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (232, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (233, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (234, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (235, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (236, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (237, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (238, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (239, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (240, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (241, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (242, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (243, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (244, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (245, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (246, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (247, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (248, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (249, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (250, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (251, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (252, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (253, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (254, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (254, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (255, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (256, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (257, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (258, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (258, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (259, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (260, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (261, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (262, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (263, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (263, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (264, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (265, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (266, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (267, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (268, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (268, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (269, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (270, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (271, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (272, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (273, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (274, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (275, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (275, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (276, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (277, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (278, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (279, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (280, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (281, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (282, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (283, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (284, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (285, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (286, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (287, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (288, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (289, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (290, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (290, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (291, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (292, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (293, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (294, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (295, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (296, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (297, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (298, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (299, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (300, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (300, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (301, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (302, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (303, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (304, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (305, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (306, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (307, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (308, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (309, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (310, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (311, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (312, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (313, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (314, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (315, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (316, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (317, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (318, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (319, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (320, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (320, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (321, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (322, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (323, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (324, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (325, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (326, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (327, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (327, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (328, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (329, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (330, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (331, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (332, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (333, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (334, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (335, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (336, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (337, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (337, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (338, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (338, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (339, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (340, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (341, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (342, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (343, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (344, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (345, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (346, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (347, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (348, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (349, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (349, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (350, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (351, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (352, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (352, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (353, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (354, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (354, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (355, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (356, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (357, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (358, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (359, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (359, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (360, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (361, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (362, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (363, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (364, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (365, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (366, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (367, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (368, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (368, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (369, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (370, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (371, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (372, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (373, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (374, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (375, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (376, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (377, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (378, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (379, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (380, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (381, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (381, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (382, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (383, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (384, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (385, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (386, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (387, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (388, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (389, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (390, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (391, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (392, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (393, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (394, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (395, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (396, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (397, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (398, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (399, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (399, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (400, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (400, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (401, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (402, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (403, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (404, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (405, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (406, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (407, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (408, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (409, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (410, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (411, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (411, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (412, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (413, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (414, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (415, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (416, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (417, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (418, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (419, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (419, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (420, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (421, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (422, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (423, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (424, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (425, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (426, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (427, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (427, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (427, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (428, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (429, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (430, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (430, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (431, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (432, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (433, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (434, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (435, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (436, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (436, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (437, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (438, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (439, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (440, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (441, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (442, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (443, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (444, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (445, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (446, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (447, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (448, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (449, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (450, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (451, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (452, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (453, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (454, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (455, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (456, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (457, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (458, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (459, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (460, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (461, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (461, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (462, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (462, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (463, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (464, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (465, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (466, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (467, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (468, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (469, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (469, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (470, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (471, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (472, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (473, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (474, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (475, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (476, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (477, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (478, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (478, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (479, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (479, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (480, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (481, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (482, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (482, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (483, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (484, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (485, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (485, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (486, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (487, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (488, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (489, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (490, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (491, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (492, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (493, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (494, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (495, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (495, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (496, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (497, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (498, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (499, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (500, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (501, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (502, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (503, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (504, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (505, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (506, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (507, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (508, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (508, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (509, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (510, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (511, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (512, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (513, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (514, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (515, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (516, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (517, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (518, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (519, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (520, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (521, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (521, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (522, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (523, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (524, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (525, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (526, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (527, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (528, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (528, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (529, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (530, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (531, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (532, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (533, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (534, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (535, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (536, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (537, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (538, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (539, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (540, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (541, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (542, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (543, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (544, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (545, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (546, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (547, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (548, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (548, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (549, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (550, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (551, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (552, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (553, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (554, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (555, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (556, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (557, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (558, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (559, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (560, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (561, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (562, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (562, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (563, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (564, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (565, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (566, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (567, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (568, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (569, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (570, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (570, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (571, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (572, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (573, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (573, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (574, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (575, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (576, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (577, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (578, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (579, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (579, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (580, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (581, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (582, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (583, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (584, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (585, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (586, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (586, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (587, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (588, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (589, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (590, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (591, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (592, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (593, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (594, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (595, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (596, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (597, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (598, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (599, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (600, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (601, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (602, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (603, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (604, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (605, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (606, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (607, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (608, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (609, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (610, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (611, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (612, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (613, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (614, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (615, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (616, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (617, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (618, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (619, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (620, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (621, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (622, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (623, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (624, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (625, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (626, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (627, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (628, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (629, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (630, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (631, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (632, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (633, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (634, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (635, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (636, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (637, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (638, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (639, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (640, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (641, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (642, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (643, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (644, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (645, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (645, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (646, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (647, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (648, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (649, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (650, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (650, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (651, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (652, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (653, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (654, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (655, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (655, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (656, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (657, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (658, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (659, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (660, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (661, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (662, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (663, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (664, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (665, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (666, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (667, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (668, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (669, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (670, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (671, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (671, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (672, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (673, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (674, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (675, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (676, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (677, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (678, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (678, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (679, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (680, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (681, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (682, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (683, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (684, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (685, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (686, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (687, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (688, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (689, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (690, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (691, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (692, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (692, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (693, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (694, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (695, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (695, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (696, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (697, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (698, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (699, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (700, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (701, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (702, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (703, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (704, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (705, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (706, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (707, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (708, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (709, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (710, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (711, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (712, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (713, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (714, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (715, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (715, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (715, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (716, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (717, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (718, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (719, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (719, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (720, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (721, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (722, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (723, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (724, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (725, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (725, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (726, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (726, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (727, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (728, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (729, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (730, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (731, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (732, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (733, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (733, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (734, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (735, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (736, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (737, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (738, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (739, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (740, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (741, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (742, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (743, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (743, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (744, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (745, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (746, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (747, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (748, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (749, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (750, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (751, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (752, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (753, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (754, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (755, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (756, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (757, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (758, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (759, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (760, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (761, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (762, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (763, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (764, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (765, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (766, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (767, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (768, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (769, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (770, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (771, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (772, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (773, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (774, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (775, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (776, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (777, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (778, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (779, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (780, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (781, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (782, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (783, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (784, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (785, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (786, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (787, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (788, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (789, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (790, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (791, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (792, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (792, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (793, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (794, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (795, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (796, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (797, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (797, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (798, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (799, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (800, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (801, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (802, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (803, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (804, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (805, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (806, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (807, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (808, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (809, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (810, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (811, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (812, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (813, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (814, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (815, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (815, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (816, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (817, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (818, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (819, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (820, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (821, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (822, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (823, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (824, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (825, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (826, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (827, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (828, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (829, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (830, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (831, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (832, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (832, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (833, 3668) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (834, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (835, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (836, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (837, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (838, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (839, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (840, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (841, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (842, 3669) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (843, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (844, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (845, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (846, 3671) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (847, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (848, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (849, 3674) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (850, 3670) MATCHING (STREETID, SECTORID);
UPDATE OR INSERT INTO TS_STREET_SECTORS (STREETID, SECTORID) VALUES (851, 3671) MATCHING (STREETID, SECTORID);

COMMIT;

/* --- 6. Secventa peste ID-urile importate ------------------------------- */
SET TERM ^ ;

EXECUTE BLOCK
AS
  DECLARE VARIABLE M INTEGER;
BEGIN
  SELECT COALESCE(MAX(STREETID), 0) FROM TS_STREETS INTO :M;
  IF (GEN_ID(SQ_TS_STREETS, 0) < M) THEN
    /* in Firebird 4+ RESTART WITH n face ca NEXT VALUE sa intoarca chiar n */
    EXECUTE STATEMENT 'ALTER SEQUENCE SQ_TS_STREETS RESTART WITH ' || (M + 1);
END^

SET TERM ; ^

COMMIT;

/* --- Verificare --------------------------------------------------------- */
SELECT COUNT(*) AS STRAZI, (SELECT COUNT(*) FROM TS_STREET_SECTORS) AS LEGATURI_SECTOR
FROM TS_STREETS WHERE CITYID = 2000;
-- asteptat: 851 / 941; urmeaza streets_houses.sql

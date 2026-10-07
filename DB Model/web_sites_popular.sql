/*
  Brandurile populare si categoriile populare de pe prima pagina, separate pe site.

  Pina acum ambele liste erau comune bazei: ce alegea WMS aparea si pe fantastic.md,
  si pe tehnomarket.md. Acum fiecare rind are SITEID (TWEB_SITE), iar fiecare site
  isi citeste doar rindurile lui.

  Ce face scriptul:
    1. TWEB_SITE                 - daca lipseste (altfel o creeaza web_sites_accounts.sql).
    2. TWEB_POPULAR_BRANDS       - se creeaza cu SITEID (scriptul web_popular_brands.sql, inca
                                   nerulat, e inlocuit de acesta); daca exista deja fara
                                   SITEID, primeste coloana, iar cheia primara devine
                                   (SITEID, BRANDID).
    3. TWEB_POPULAR_CATEGORIES   - SITEID (implicit 1 = fantastic), cheia primara
                                   (SITEID, CATALOGID). Categoriile marcate "popular" in
                                   TWEB_CATALOG (bitul 12 din FLAGS) primesc rind pentru
                                   site-ul 1, ca lista fantastic.md sa ramina aceeasi.
    4. WEB_GET_POPULAR_CATEGORIES2(SITEID) - categoriile populare ale unui site, din tabela
                                   (nu din bitul 12, care ramine doar pentru fantastic.md).

  Dupa script: WMS, dialogurile "Branduri populare" si "Categorii populare" au un
  selector de site; fantastic.web citeste pe SITEID (PopularBrands, PopularCategories).
  Inainte de script codul detecteaza lipsa coloanei si se poarta ca pina acum.

  Re-rulabil. Firebird 5.
  NEURON Grup SRL, 4 octombrie 2026
*/

SET TERM ^ ;

/* ------------------------------------------------------------------ 1. TWEB_SITE */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_SITE')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_SITE (
         SITEID             DM_INTEGER NOT NULL,
         CODE               DM_VARCHAR32 NOT NULL,
         NAME               DM_VARCHAR128,
         DOMAIN             DM_VARCHAR128,
         FIRMA              DM_INTEGER,
         CUSTOMER_FOLDERID  DM_INTEGER DEFAULT 99 NOT NULL,
         GUEST_FOLDERID     DM_INTEGER DEFAULT 247386 NOT NULL,
         FLG_ACTIVE         DM_BOOLEAN_NN DEFAULT 1,
         CONSTRAINT PK_TWEB_SITE PRIMARY KEY (SITEID),
         CONSTRAINT UNQ_TWEB_SITE_CODE UNIQUE (CODE)
       )';
END ^

SET TERM ; ^
COMMIT;

UPDATE OR INSERT INTO TWEB_SITE (SITEID, CODE, NAME, DOMAIN, FIRMA)
VALUES (1, 'fantastic', 'Fantastic.md', 'www.fantastic.md', 316910)
MATCHING (SITEID);
UPDATE OR INSERT INTO TWEB_SITE (SITEID, CODE, NAME, DOMAIN, FIRMA)
VALUES (2, 'tehnomarket', 'Tehnomarket.md', 'www.tehnomarket.md', 317087)
MATCHING (SITEID);
COMMIT;

GRANT SELECT, INSERT, UPDATE ON TWEB_SITE TO SWN;
GRANT SELECT ON TWEB_SITE TO WEBUSER;
COMMIT;

SET TERM ^ ;

/* ------------------------------------------------------------------ 2. TWEB_POPULAR_BRANDS */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_POPULAR_BRANDS')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_POPULAR_BRANDS (
         SITEID       DM_INTEGER DEFAULT 1 NOT NULL,
         BRANDID      DM_INTEGER NOT NULL,
         ORDERNO      DM_INTEGER,
         CREATED_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
         CONSTRAINT PK_TWEB_POPULAR_BRANDS PRIMARY KEY (SITEID, BRANDID),
         CONSTRAINT FK_TWEB_POPULAR_BRANDS_SYSS FOREIGN KEY (BRANDID)
           REFERENCES TS_SYSS (SYSSID) ON DELETE CASCADE,
         CONSTRAINT FK_TWEB_POPULAR_BRANDS_SITE FOREIGN KEY (SITEID)
           REFERENCES TWEB_SITE (SITEID)
       )';
  ELSE IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                      WHERE RDB$RELATION_NAME = 'TWEB_POPULAR_BRANDS' AND RDB$FIELD_NAME = 'SITEID')) THEN
  BEGIN
    /* tabela creata de web_popular_brands.sql, fara site */
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_BRANDS ADD SITEID DM_INTEGER DEFAULT 1 NOT NULL';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_BRANDS DROP CONSTRAINT PK_TWEB_POPULAR_BRANDS';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_BRANDS ADD CONSTRAINT PK_TWEB_POPULAR_BRANDS PRIMARY KEY (SITEID, BRANDID)';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_BRANDS ADD CONSTRAINT FK_TWEB_POPULAR_BRANDS_SITE
                         FOREIGN KEY (SITEID) REFERENCES TWEB_SITE (SITEID)';
  END
END ^

/* ------------------------------------------------------------------ 3. TWEB_POPULAR_CATEGORIES */
EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS(SELECT 1 FROM RDB$RELATION_FIELDS
                 WHERE RDB$RELATION_NAME = 'TWEB_POPULAR_CATEGORIES' AND RDB$FIELD_NAME = 'SITEID')) THEN
  BEGIN
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_CATEGORIES ADD SITEID DM_INTEGER DEFAULT 1 NOT NULL';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_CATEGORIES DROP CONSTRAINT PK_TWEB_POPULAR_CATEGORIES';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_CATEGORIES ADD CONSTRAINT PK_TWEB_POPULAR_CATEGORIES PRIMARY KEY (SITEID, CATALOGID)';
    EXECUTE STATEMENT 'ALTER TABLE TWEB_POPULAR_CATEGORIES ADD CONSTRAINT FK_TWEB_POPULAR_CATEGORIES_SITE
                         FOREIGN KEY (SITEID) REFERENCES TWEB_SITE (SITEID)';
  END
END ^

SET TERM ; ^
COMMIT;

COMMENT ON COLUMN TWEB_POPULAR_BRANDS.SITEID IS 'Site-ul (TWEB_SITE) pe a carui prima pagina apare brandul';
COMMENT ON COLUMN TWEB_POPULAR_CATEGORIES.SITEID IS 'Site-ul (TWEB_SITE) pe a carui prima pagina apare categoria';
COMMIT;

/* categoriile marcate "popular" in catalog, fara rind in tabela, primesc rind pentru fantastic.md */
INSERT INTO TWEB_POPULAR_CATEGORIES (SITEID, CATALOGID, ORDERNO, CATEGORY_DISCOUNT)
SELECT 1, C.CATALOGID, NULL, NULL
  FROM TWEB_CATALOG C
 WHERE GET_FLG_VALUE(C.FLAGS, 12) = 1
   AND NOT EXISTS (SELECT 1 FROM TWEB_POPULAR_CATEGORIES P WHERE P.SITEID = 1 AND P.CATALOGID = C.CATALOGID);
COMMIT;

/* ------------------------------------------------------------------ 4. WEB_GET_POPULAR_CATEGORIES2 */
SET TERM ^ ;

CREATE OR ALTER PROCEDURE WEB_GET_POPULAR_CATEGORIES2 (
    SITEID DM_INTEGER = 1)
RETURNS (
    CATALOGID         DM_INTEGER,
    CATALOG_NAME_RO   DM_VARCHAR255,
    CATALOG_NAME_RU   DM_VARCHAR255,
    CATALOG_IMAGE     DM_BLOBIMAGE,
    URL_RO            DM_VARCHAR512,
    URL_RU            DM_VARCHAR512,
    CATEGORY_DISCOUNT DM_INTEGER)
AS
begin
  /* Ca WEB_GET_POPULAR_CATEGORIES, dar lista vine din TWEB_POPULAR_CATEGORIES a
     site-ului, nu din bitul 12 al catalogului (care e comun tuturor site-urilor). */
  for select P.CATALOGID, C.TITLE, C.TITLE_RUS, C.URL_RO, C.URL_RU, P.CATEGORY_DISCOUNT
        from TWEB_POPULAR_CATEGORIES P
        join TWEB_CATALOG C on C.CATALOGID = P.CATALOGID
       where P.SITEID = :SITEID
       order by P.ORDERNO nulls last, C.ORDERNO
        into :CATALOGID, :CATALOG_NAME_RO, :CATALOG_NAME_RU, :URL_RO, :URL_RU, :CATEGORY_DISCOUNT
  do
  begin
     CATALOG_IMAGE = NULL;
     select I.BIG_IMAGE from TWEB_CATALOG_IMAGE I where I.CATALOGID = :CATALOGID into :CATALOG_IMAGE;
     suspend;
  end
end ^

SET TERM ; ^
COMMIT;

GRANT SELECT ON TWEB_POPULAR_BRANDS TO WEBUSER;
GRANT SELECT ON TWEB_POPULAR_CATEGORIES TO WEBUSER;
GRANT SELECT, INSERT, UPDATE, DELETE ON TWEB_POPULAR_BRANDS TO SWN;
GRANT SELECT, INSERT, UPDATE, DELETE ON TWEB_POPULAR_CATEGORIES TO SWN;
GRANT EXECUTE ON PROCEDURE WEB_GET_POPULAR_CATEGORIES2 TO WEBUSER;
COMMIT;

/* Brandurile populare de pe prima pagina fantastic.md (blocul de dupa slider).

   WMS: dialogul "Branduri populare" (frmWebPopularBrandsDialog, meniul de dupa
   "Categorii populare") scrie aici lista si ordinea.
   Site: fantastic.web/models/PopularBrands.php ia intii brandurile de aici, in ordinea
   ORDERNO, apoi completeaza automat pina la 12 dupa suma scorurilor TWEB_GOODS_RANK.
   Un brand fara logo in TS_BRANDS_IMAGE nu apare pe site (nici cel ales aici).

   BRANDID = TS_SYSS.SYSSID = TS_GOODS.VENDOR_ID = TS_BRANDS_IMAGE.BRANDID.
   Site-ul se conecteaza ca WEBUSER - de aici GRANT-ul.

   Script repetabil: se poate rula de mai multe ori (29.09.2026). */

SET TERM ^ ;

EXECUTE BLOCK AS
BEGIN
  IF (NOT EXISTS (SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TWEB_POPULAR_BRANDS')) THEN
    EXECUTE STATEMENT
      'CREATE TABLE TWEB_POPULAR_BRANDS (
         BRANDID      DM_INTEGER NOT NULL,
         ORDERNO      DM_INTEGER,
         CREATED_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
         CONSTRAINT PK_TWEB_POPULAR_BRANDS PRIMARY KEY (BRANDID),
         CONSTRAINT FK_TWEB_POPULAR_BRANDS_SYSS FOREIGN KEY (BRANDID)
           REFERENCES TS_SYSS (SYSSID) ON DELETE CASCADE
       )';
END^

SET TERM ; ^

COMMIT;

GRANT SELECT ON TWEB_POPULAR_BRANDS TO WEBUSER;

COMMIT;

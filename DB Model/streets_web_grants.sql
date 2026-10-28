/* ============================================================================
   streets_web_grants.sql

   Drepturile site-ului (utilizatorul WEBUSER) pe nomenclatorul strazilor
   (streets_nomenclator.sql + streets_houses.sql, deja rulate pe SW).

   Fara ele checkout-ul de pe fantastic.md nu vede strazile:
     "no permission for SELECT access to TABLE TS_STREETS Effective user is WEBUSER"
   iar blocul de adresa ramane cu strada scrisa liber (fara lista, fara GPS,
   fara sectorul dedus din strada + numar).

   Site-ul (fantastic.web: models/TsStreets.php) foloseste:
     VW_TS_STREETS                 lista strazilor pe localitate
     TS_STREETS                    localitatea strazii (adresa dupa GPS)
     SP_STREET_SECTOR(STREETID, HOUSENO)  sectorul adresei -> CITYID in comanda
     WEB_NEAREST_HOUSE(LAT, LON, MAX_M)   cea mai apropiata casa de telefon

   Procedurile primesc si ele drept de citire pe tabelele pe care le folosesc,
   ca sa mearga indiferent de proprietarul lor.

   Re-rulabil (un GRANT existent nu da eroare).
   isql -user SYSDBA -password <parola> "<host>/3050:SW" -i streets_web_grants.sql
============================================================================ */

GRANT SELECT ON TS_STREETS TO WEBUSER;
GRANT SELECT ON TS_STREET_SECTORS TO WEBUSER;
GRANT SELECT ON TS_STREET_HOUSES TO WEBUSER;
GRANT SELECT ON VW_TS_STREETS TO WEBUSER;
GRANT EXECUTE ON PROCEDURE SP_STREET_SECTOR TO WEBUSER;
GRANT EXECUTE ON PROCEDURE WEB_NEAREST_HOUSE TO WEBUSER;

GRANT SELECT ON TS_STREETS TO PROCEDURE SP_STREET_SECTOR;
GRANT SELECT ON TS_STREET_SECTORS TO PROCEDURE SP_STREET_SECTOR;
GRANT SELECT ON TS_STREET_HOUSES TO PROCEDURE SP_STREET_SECTOR;
GRANT SELECT ON TS_STREETS TO PROCEDURE WEB_NEAREST_HOUSE;
GRANT SELECT ON TS_STREET_HOUSES TO PROCEDURE WEB_NEAREST_HOUSE;

GRANT SELECT ON TS_STREETS TO VIEW VW_TS_STREETS;
GRANT SELECT ON TS_STREET_SECTORS TO VIEW VW_TS_STREETS;

COMMIT;

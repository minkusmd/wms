/* ============================================================================
   Drepturi pentru SP_GOODS_FLAG_STOCK (modificata 10.10.2026: FLG_PRICE pe firma
   reala a stocului). Procedura e apelata de triggerul TRG_TS_GOODS_STOCK_AU0 la
   orice miscare de stoc si de pachetul PKG_GOODS, dar EXECUTE il avea doar SYSDBA.

   Efect pe productie (12.10.2026): comenzile de pe site (utilizatorul WEBUSER)
   cadeau la /shop-cart-order/place cu
     "no permission for EXECUTE access to PROCEDURE SP_GOODS_FLAG_STOCK".
   WMS nu era afectat (se conecteaza ca SYSDBA).

   Drepturile se dau obiectelor care apeleaza procedura (trigger, pachet) si
   procedurii insesi pe tabelele ei - astfel merge pentru orice utilizator care
   misca stocul. GRANT-urile sint re-rulabile.
   ============================================================================ */

/* cine apeleaza procedura */
GRANT EXECUTE ON PROCEDURE SP_GOODS_FLAG_STOCK TO TRIGGER TRG_TS_GOODS_STOCK_AU0;
GRANT EXECUTE ON PROCEDURE SP_GOODS_FLAG_STOCK TO PACKAGE PKG_GOODS;
GRANT EXECUTE ON PROCEDURE SP_GOODS_FLAG_STOCK TO WEBUSER;
GRANT EXECUTE ON PROCEDURE SP_GOODS_FLAG_STOCK TO SWN;

/* ce foloseste procedura */
GRANT SELECT ON TS_CUSTOMER TO PROCEDURE SP_GOODS_FLAG_STOCK;
GRANT SELECT ON TS_GOODS_STOCK TO PROCEDURE SP_GOODS_FLAG_STOCK;
GRANT SELECT ON TS_STOCKS TO PROCEDURE SP_GOODS_FLAG_STOCK;
GRANT SELECT, INSERT, UPDATE, DELETE ON TDB_GOODS_FLAGS TO PROCEDURE SP_GOODS_FLAG_STOCK;

COMMIT;

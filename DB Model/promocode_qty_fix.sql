/* ======================================================================
   Cod promotional: reducerea se calcula pentru o singura unitate din
   fiecare produs, indiferent de cantitatea din cos (22 sep 2026).

   SP_MK_APPLY_PROMOCODE          - suma afisata in cos (site, oaspeti);
   SP_MK_APPLY_PROMOCODE_AUTHUSER - suma scazuta in comanda de
                                    WEB_CREATE_TRANSACTION3 (linia 368756).

   Ambele adunau price_mdl * procent pentru fiecare GOODSID din cos; acum
   inmultesc si cu QTY. La reducerea fixa (DISCOUNT_VALUE) comportamentul
   ramane pe produs, nu pe bucata - asa cum era.

   Semnatura procedurilor nu se schimba (WEB_CREATE_TRANSACTION3 depinde
   de SP_MK_APPLY_PROMOCODE_AUTHUSER). Scriptul se poate rula de mai multe ori.
   ====================================================================== */

SET TERM ^ ;

ALTER PROCEDURE SP_MK_APPLY_PROMOCODE (
    PROMOCODE DM_VARCHAR32,
    SHOP_CART_ID DM_VARCHAR60)
RETURNS (
    DISCOUNT DM_AMOUNT)
AS
declare gg_id dm_integer;
declare goodsid dm_integer;
declare DISCOUNT_PERCENT dm_amount;
declare DISCOUNT_VALUE dm_amount;
declare price dm_amount;
declare qty dm_qty;
begin
  select M.gg_id, M.DISCOUNT_VALUE, M.DISCOUNT_PERCENT
  from MK_PROMO_TICKETS M
  where upper(M.TICKET_CODE) = upper(:PROMOCODE) and
        current_date between cast(DATA1 as date) and cast(DATA2 as date) and
        GET_FLG_VALUE(FLAGS, 1) = 1
  into :gg_id, :DISCOUNT_VALUE, :DISCOUNT_PERCENT;

  /* initializa discount value = 0 */
  :discount = 0;
  for select Z.GOODSID
  from SP_MK_GET_SHOPCART_GROUP_GOODS(:SHOP_CART_ID, :gg_id) Z
  join TS_GOODS G on G.GOODSID = Z.GOODSID into :goodsid do
  begin
     select price_mdl from get_goods_price(:goodsid, 1, 498) into :price;
     if (coalesce(:discount_percent, 0) > 0) then
     begin
        /* cantitatea produsului in acest cos (22.09.2026) */
        select coalesce(sum(C.QTY), 1) from TWEB_SHOP_CART C
        where C.SHOP_CART_ID = :SHOP_CART_ID and C.GOODSID = :goodsid
        into :qty;
        if (coalesce(:qty, 0) <= 0) then qty = 1;
        :discount = :discount + (:price * :qty * :discount_percent / 100);
     end
     else
     begin
       :discount = :discount + :discount_value;
     end
  end

  suspend;
end^

ALTER PROCEDURE SP_MK_APPLY_PROMOCODE_AUTHUSER (
    PROMOCODE DM_VARCHAR32,
    CUSTOMERID DM_VARCHAR60)
RETURNS (
    DISCOUNT DM_AMOUNT)
AS
declare gg_id dm_integer;
declare goodsid dm_integer;
declare DISCOUNT_PERCENT dm_amount;
declare DISCOUNT_VALUE dm_amount;
declare price dm_amount;
declare qty dm_qty;
begin
  /* initializa discount value = 0 */
  :discount = 0;

  /* verific daca promocode este active si poate fi utilizat mai departe */
  select M.gg_id, M.DISCOUNT_VALUE, M.DISCOUNT_PERCENT
  from MK_PROMO_TICKETS M
  where upper(M.TICKET_CODE) = upper(:PROMOCODE) and
        current_date between cast(DATA1 as date) and cast(DATA2 as date) and
        GET_FLG_VALUE(FLAGS, 1) = 1
  into :gg_id, :DISCOUNT_VALUE, :DISCOUNT_PERCENT;

  /* gasim toate produsele conform promotiei care se regasesc in cos */
  /* calculam suma reducerii care trebuie aplicata peste cos */
  for select g.GOODSID
  from SP_MK_GET_SHOPCART_GG_BY_USER(:customerid, :gg_id) Z
  join TS_GOODS G on G.GOODSID = Z.GOODSID into :goodsid do
  begin
     select price_mdl from get_goods_price(:goodsid, 1, 498) into :price;
     if (coalesce(:discount_percent, 0) > 0) then
     begin
        /* cantitatea produsului in cosul clientului (22.09.2026). MAX, nu SUM:
           clientul poate avea randuri ramase in alte cosuri (alt SHOP_CART_ID)
           pentru acelasi produs, iar procedura nu primeste cosul comenzii. */
        select coalesce(max(C.QTY), 1) from TWEB_SHOP_CART C
        where C.CUSTOMERID = :customerid and C.GOODSID = :goodsid
        into :qty;
        if (coalesce(:qty, 0) <= 0) then qty = 1;
        :discount = :discount + (:price * :qty * :discount_percent / 100);
     end
     else
     begin
       :discount = :discount + :discount_value;
     end
  end

  /* return discount */
  suspend;
end^

SET TERM ; ^

COMMIT;

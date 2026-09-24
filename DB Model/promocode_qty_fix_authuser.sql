/* Partea 2 din promocode_qty_fix.sql - doar SP_MK_APPLY_PROMOCODE_AUTHUSER
   (reducerea din comanda, apelata de WEB_CREATE_TRANSACTION3). */

SET TERM ^ ;

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

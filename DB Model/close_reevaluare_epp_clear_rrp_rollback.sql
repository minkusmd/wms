/* ------------------------------------------------------------------------
   Rollback pentru close_reevaluare_epp_clear_rrp.sql: readuce CLOSE_REEVALUARE
   la versiunea din 2 oct 2026 (close_reevaluare_epp_keep_rrp.sql) - produsul pe
   RRP fara RRP in reevaluare pastreaza RRP-ul din TS_GOODS_FOREIGN.
   ------------------------------------------------------------------------ */

SET TERM ^ ;

CREATE OR ALTER PROCEDURE CLOSE_REEVALUARE (DOCID DM_INTEGER)
AS
declare CUSTOMERID DM_INTEGER;
declare GOODSID dm_integer;
declare SUPPLIER_GOODS_CODE dm_varchar128;
declare price0 dm_amount;
declare price3 dm_amount;
declare PRICE4 dm_amount;
declare PRICE7 dm_amount;
declare CURRENCY0ID dm_integer;
declare CURRENCY3ID dm_integer;
declare CURRENCY4ID dm_integer;
declare CURRENCY7ID dm_integer;
declare FLG_PRICE_FORCED dm_integer;
declare barcode dm_varchar32;
declare FLG_supplier_promo dm_integer;
declare flg_epp dm_integer;
declare flg_pre_order dm_boolean;
declare sql dm_blobtext;
begin
  select CT from TDB_DOCS where DOCID = :DOCID into :CUSTOMERID;

  for select d.GOODSID,
             d.SUPPLIER_GOODS_CODE,
             d.price0,
             d.PRICE3,
             d.PRICE4,
             d.PRICE7,
             d.currency0id,
             d.currency3id,
             d.CURRENCY4ID,
             d.CURRENCY7ID,
             D.FLG_PRICE_FORCED,
             d.flg_supplier_promo,
             d.flg_epp,
             d.flg_pre_order,
             d.barcode
      from VW_TDB_GOODS_PRICE5213 D
--      join ts_goods_foreign gf on gf.goods_code=d.supplier_goods_code and gf.customerid = :customerid
      where DOCID = :DOCID
      into :GOODSID, :SUPPLIER_GOODS_CODE, :price0, :PRICE3, :PRICE4, :PRICE7, :currency0id, :CURRENCY3ID, :CURRENCY4ID,
           :CURRENCY7ID, :FLG_PRICE_FORCED, :flg_supplier_promo, :flg_epp, :flg_pre_order, :barcode
  do
  begin
    /* 02.10.2026: produs pe RRP (flg_epp) fara RRP in pricelist - nu mai aruncam
       err_epp_without_pricevalue; costul (price0) si indicativul (price7) se
       actualizeaza, RRP-ul (price3/currency3id) ramane cel din TS_GOODS_FOREIGN */
    begin
      begin
        update TS_GOODS_FOREIGN
        set
          FLAGS = set_flg_value(set_flg_value(SET_FLG_VALUE(FLAGS, 3, iif (:FLG_PRICE_FORCED = 1, '1', '0')), 6, :flg_pre_order), 4, :flg_epp),
          price3 = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, price3, :price3),
          currency3id = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, currency3id, :currency3id),
          price4 = coalesce(:price4, 0),
          currency4id = coalesce(:currency4id, :currency7id),
          ord_price7 = :price7,
          ord_currency7id = :currency7id,
          barcode = iif (coalesce(:barcode, '') = '', barcode, :barcode),
          last_price_date = current_timestamp
        where GOODSID = :GOODSID and
            CUSTOMERID = :CUSTOMERID and
            GOODS_CODE = :SUPPLIER_GOODS_CODE;
      when any do
        exception err_general_error 'goodscode: '|| :SUPPLIER_GOODS_CODE|| '['||SQLstate||']' ||' - '|| GDSCODE;
      end

      if (coalesce(:price0, 0) = 0) then
          update TS_GOODS_FOREIGN
          set
              FLAGS = set_flg_value(SET_FLG_VALUE(FLAGS, 2, iif(:FLG_SUPPLIER_PROMO = 1, iif(:FLG_PRICE_FORCED = 1, '1','0'), '0')), 4, :flg_epp),
              currency0id = :currency7id,
              price3 = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, price3, :price3),
              currency3id = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, currency3id, :currency3id),
              price4 = coalesce(:price4, 0),
              currency4id = coalesce(:currency4id, :currency7id),
              ord_price7 = :price7,
              ord_currency7id = :currency7id,
              barcode = iif (coalesce(:barcode, '') ='', barcode, :barcode),
              last_price_date = current_timestamp
          where GOODSID = :GOODSID and
                CUSTOMERID = :CUSTOMERID and
                GOODS_CODE = :SUPPLIER_GOODS_CODE;
      else
          update TS_GOODS_FOREIGN
          set
              FLAGS = set_flg_value(SET_FLG_VALUE(FLAGS, 2, iif(:FLG_SUPPLIER_PROMO = 1, iif(:FLG_PRICE_FORCED = 1, '1','0'), '0')), 4, :flg_epp),
              price0 = :price0,
              currency0id = :currency7id,
              price3 = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, price3, :price3),
              currency3id = iif(:flg_epp = 1 and coalesce(:price3, 0) = 0, currency3id, :currency3id),
              price4 = coalesce(:price4, 0),
              currency4id = coalesce(:currency4id, :currency7id),
              ord_price7 = :price7,
              ord_currency7id = :currency7id,
              barcode = iif (coalesce(:barcode, '') ='', barcode, :barcode),
              last_price_date = current_timestamp
          where GOODSID = :GOODSID and
                CUSTOMERID = :CUSTOMERID and
                GOODS_CODE = :SUPPLIER_GOODS_CODE;


       execute procedure pkg_goods.set_flg_new(:goodsid,  2);
    end
  end


  RDB$SET_CONTEXT('USER_TRANSACTION', 'RequireModifyDOC', 1);

  update tdb_docs set flags = set_flg_value(flags, 10, 1) where docid = :docid;

end^

SET TERM ; ^

COMMIT;

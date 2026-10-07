/*
  Revenire la SP_WEB_CREATE_CACHE_GOODS de dinainte de web_create_cache_goods_diff.sql
  (corpul activ de pe SW la 7 oct 2026, fara blocul vechi comentat):
  MERGE care rescrie toate rindurile + DELETE dupa LASTUPDATE.
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_WEB_CREATE_CACHE_GOODS
AS
declare variable Current_Datetime Dm_Datetime;
begin
  Current_Datetime = current_timestamp;

  merge into Tweb_Cache_Goods as Target
  using (select distinct A.Goodsid,
                         (select Parentid
                          from Ts_Goods
                          where Ts_Goods.Goodsid = A.Goodsid) Parentid, iif(exists(select Goodsid
                                                                                   from Tdb_Goods_Flags B
                                                                                   where B.Goodsid = A.Goodsid and
                                                                                         Dt = 5213 and
                                                                                         Flagtypeid = 2), 1, 0) Flg_New, iif(exists(select Goodsid
                                                                                                                                      from Tdb_Goods_Flags B
                                                                                                                                      where B.Goodsid = A.Goodsid and
                                                                                                                                            Dt = 5213 and
                                                                                                                                            Flagtypeid = 1), 1, 0) Flg_Promo,

                         lower(substring(coalesce(G.Base_Param, '') || ' ' || coalesce(G.Code, '') || ' ' || coalesce(G.Details, '') || ' ' || coalesce(Vendor.Title, '') || ' ' || coalesce(Gt.Title, '') || ' ' || coalesce(Gt.Title_Rus, '') || ' ' || coalesce(Gt.Search_Keys, '') from 1 for 1024)) Search_Words,
                         G.Webgoodstype_Id Webgoodstypeid
         from Tdb_Goods_Flags A
         inner join Ts_Goods G on (G.Goodsid = A.Goodsid)
         inner join Ts_Syss Vendor on (Vendor.Syssid = G.Vendor_Id)
         inner join Ts_Goods_Type Gt on (Gt.Goodstypeid = G.Webgoodstype_Id)
         where A.Dt = 5213 and
               (((Flagtypeid = 5) and
               (A.Value_Int = 1)) /* FLG_PRICE */
               or (Flagtypeid = 3))) as Src
  on Target.Goodsid = Src.Goodsid
  when not matched then
      insert (Goodsid, Parentid, Flg_New, Flg_Promo, Search_Words, Webgoodstypeid, Lastupdate)
      values (Src.Goodsid, Src.Parentid, Src.Flg_New, Src.Flg_Promo, Src.Search_Words, Src.Webgoodstypeid,
              :Current_Datetime)
  when matched  then
      update set Target.Parentid = Src.Parentid,
                 Target.Flg_New = Src.Flg_New,
                 Target.Flg_Promo = Src.Flg_Promo,
                 Target.Search_Words = Src.Search_Words,
                 Target.Webgoodstypeid = Src.Webgoodstypeid,
                 Target.Lastupdate = :Current_Datetime;

  delete from tweb_cache_goods
  where Lastupdate < :Current_Datetime;

  /* fortam site-ul sa reciteasca toate datele */
  delete from Tweb_Cache_Tickets
  where Ticket_Name <> '';
end^

SET TERM ; ^

COMMIT;

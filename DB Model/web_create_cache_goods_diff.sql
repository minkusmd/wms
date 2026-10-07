/*
  SP_WEB_CREATE_CACHE_GOODS - scrie in TWEB_CACHE_GOODS doar rindurile schimbate.

  Problema (7 oct 2026): sarcina SWNService "установка FLG_PRICE для товаров"
  (SP_SET_PRICE_FLAG -> SP_WEB_CREATE_CACHE_GOODS) cadea cu
    deadlock / update conflicts with concurrent update
    At procedure 'SP_WEB_CREATE_CACHE_GOODS' line: 62 (MERGE)
  MERGE-ul vechi facea UPDATE pe TOATE rindurile cache-ului la fiecare rulare
  (WHEN MATCHED fara conditie + LASTUPDATE = acum, apoi DELETE dupa LASTUPDATE):
  ~49 200 de rinduri, din care de regula se schimba 0-10. Orice alta tranzactie
  care atingea in acel moment un singur produs din cache (triggerii TDB_GOODS_FLAGS
  -> SP_WEB_UPDATE_GOODS_CACHE_STATE / TRG_TDB_GOODS_FLAGS_AD0, reevaluarile,
  sau a doua sarcina care reconstruieste acelasi cache: SP_WEB_CREATE_CACHE_GOODS
  direct / SP_SET_PRICE_FLAG2) intra in conflict, iar doua reconstruiri in paralel
  se blocau reciproc (deadlock).

  Acum:
  - WHEN MATCHED AND <ceva difera> -> se actualizeaza doar rindurile schimbate
    (LASTUPDATE devine data reala a schimbarii);
  - rindurile care nu mai sint in sursa se sterg prin NOT EXISTS cu aceleasi
    conditii ca sursa (inainte: dupa LASTUPDATE < inceputul rularii);
  - restul neschimbat (sursa, coloanele, golirea TWEB_CACHE_TICKETS).
  Verificat in citire pe SW 7 oct 2026: sursa 49 206 produse; noul MERGE ar
  actualiza 1 rind, ar insera 0, ar sterge 0 (vechiul rescria 49 206).

  Se poate rula repetat. Revenire: web_create_cache_goods_diff_rollback.sql
*/

SET TERM ^ ;

CREATE OR ALTER PROCEDURE SP_WEB_CREATE_CACHE_GOODS
AS
declare variable Current_Datetime Dm_Datetime;
begin
  /* 25.06.2013 - JOHN: lista de produse pentru cache-ul site-ului */
  /* 20.09.2016 - SERGIU: trecut pe MERGE (delete strica tabela tweb_cache_goods) */
  /* 07.10.2026: se scriu doar diferentele - vezi DB Model/web_create_cache_goods_diff.sql */

  Current_Datetime = current_timestamp;

  merge into Tweb_Cache_Goods as Target
  using (select distinct A.Goodsid,
                         (select Parentid
                          from Ts_Goods
                          where Ts_Goods.Goodsid = A.Goodsid) Parentid,
                         iif(exists(select Goodsid
                                    from Tdb_Goods_Flags B
                                    where B.Goodsid = A.Goodsid and
                                          Dt = 5213 and
                                          Flagtypeid = 2), 1, 0) Flg_New,
                         iif(exists(select Goodsid
                                    from Tdb_Goods_Flags B
                                    where B.Goodsid = A.Goodsid and
                                          Dt = 5213 and
                                          Flagtypeid = 1), 1, 0) Flg_Promo,
                         lower(substring(coalesce(G.Base_Param, '') || ' ' || coalesce(G.Code, '') || ' ' ||
                                         coalesce(G.Details, '') || ' ' || coalesce(Vendor.Title, '') || ' ' ||
                                         coalesce(Gt.Title, '') || ' ' || coalesce(Gt.Title_Rus, '') || ' ' ||
                                         coalesce(Gt.Search_Keys, '') from 1 for 1024)) Search_Words,
                         G.Webgoodstype_Id Webgoodstypeid
         from Tdb_Goods_Flags A
         inner join Ts_Goods G on (G.Goodsid = A.Goodsid)
         inner join Ts_Syss Vendor on (Vendor.Syssid = G.Vendor_Id)
         inner join Ts_Goods_Type Gt on (Gt.Goodstypeid = G.Webgoodstype_Id)
         where A.Dt = 5213 and
               (((A.Flagtypeid = 5) and (A.Value_Int = 1)) /* FLG_PRICE */
                or (A.Flagtypeid = 3))                     /* FLG_PRICE_FORCED */
        ) as Src
  on Target.Goodsid = Src.Goodsid
  when matched and (Target.Parentid is distinct from Src.Parentid or
                    Target.Flg_New is distinct from Src.Flg_New or
                    Target.Flg_Promo is distinct from Src.Flg_Promo or
                    Target.Search_Words is distinct from Src.Search_Words or
                    Target.Webgoodstypeid is distinct from Src.Webgoodstypeid) then
      update set Target.Parentid = Src.Parentid,
                 Target.Flg_New = Src.Flg_New,
                 Target.Flg_Promo = Src.Flg_Promo,
                 Target.Search_Words = Src.Search_Words,
                 Target.Webgoodstypeid = Src.Webgoodstypeid,
                 Target.Lastupdate = :Current_Datetime
  when not matched then
      insert (Goodsid, Parentid, Flg_New, Flg_Promo, Search_Words, Webgoodstypeid, Lastupdate)
      values (Src.Goodsid, Src.Parentid, Src.Flg_New, Src.Flg_Promo, Src.Search_Words, Src.Webgoodstypeid,
              :Current_Datetime);

  /* produsele care nu mai indeplinesc conditiile sursei (aceleasi join-uri) */
  delete from Tweb_Cache_Goods C
  where not exists(select 1
                   from Tdb_Goods_Flags A
                   inner join Ts_Goods G on (G.Goodsid = A.Goodsid)
                   inner join Ts_Syss Vendor on (Vendor.Syssid = G.Vendor_Id)
                   inner join Ts_Goods_Type Gt on (Gt.Goodstypeid = G.Webgoodstype_Id)
                   where A.Goodsid = C.Goodsid and
                         A.Dt = 5213 and
                         (((A.Flagtypeid = 5) and (A.Value_Int = 1)) or (A.Flagtypeid = 3)));

  /* fortam site-ul sa reciteasca toate datele */
  delete from Tweb_Cache_Tickets
  where Ticket_Name <> '';
end^

SET TERM ; ^

COMMIT;

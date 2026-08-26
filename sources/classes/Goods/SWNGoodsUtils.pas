unit SWNGoodsUtils;

interface

uses
    SWNConst, SWNUtils, IBC, System.SysUtils;

function GetGoodsPrice(AGoodsID: Integer; APriceColumn: integer): Double;

procedure GenerateSeoData(GoodsID: Integer; Transaction: TIBCTransaction);

function GenerateGoodsTitle(GoodsType: string; VendorName: string; Model: string; BaseParam: string;
    Details: string): string;

implementation

uses
    SWNCommonDialogs, DataModuleDB;

function GetGoodsPrice(AGoodsID: Integer; APriceColumn: integer): Double;
var
    Query: TIBCQuery;
begin
    Result := 0;
    Query := TIBCQuery.Create(nil);
    try
        dmDB.OpenQuery(Query,
            'select price, pricemdl from get_goods_price(:goodsid, :pricecolumn, :currencyid', [AGoodsID,
            APriceColumn, 840]);
        result := Query.FieldByName('PRICE').AsFloat;
    finally
        Query.Free;
    end;
end;

procedure GenerateSeoData(GoodsID: Integer; Transaction: TIBCTransaction);
var
    query: TIBCQuery;
begin
    query := TIBCQuery.Create(nil);
    try
        query.SQL.Text := 'EXECUTE PROCEDURE SP_SEO_GENERATE_DATA(:GOODSID)';
        query.ParamByName('GOODSID').AsInteger := GoodsID;
        query.Transaction := Transaction;
        try
            query.ExecSQL;
        except
            on e: Exception do
            begin
                Transaction.Rollback;
                raise;
            end;
        end;
    finally
        query.Free;
    end;
end;

function GenerateGoodsTitle(GoodsType: string; VendorName: string; Model: string; BaseParam: string;
    Details: string): string;
var
//    Params: string;
    q: TIBCQuery;
begin
    Result := '';
//    Params := Trim(Params) + iif(Trim(Model) = '', '', ' ' + Trim(Model));
//    Params := Trim(Params) + iif(Trim(BaseParam) = '', '', ', ' + Trim(BaseParam));
//    Params := Trim(Params) + iif(Trim(Details) = '', '', ', ' + Details);
//
//    Result := GoodsType + iif(VendorName = '', '', ' ' + VendorName) +
//    iif(Trim(Params) = '', '', ' ' + Params);
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Add('select gengoodssystemname(:goodstype, :vendorname, :model, :baseparam, :details) title from rdb$database');
        q.ParamByName('goodstype').AsString := GoodsType;
        q.ParamByName('vendorname').AsString := VendorName;
        q.ParamByName('model').AsString := Model;
        q.ParamByName('baseparam').AsString := BaseParam;
        q.ParamByName('details').AsString := Details;
        q.Open;
        Result := q.FieldByName('title').AsString;
    finally
        q.Free;
    end;
end;



end.


unit ApiAccentUnit;

interface

uses
  Classes,
  Generics.Collections,
  IdHTTP,
  SysUtils,
  IBC,
  IdFTP,
  cxProgressBar;

type
  TAccentProductRecord = record
    RootName: string;
    FolderName: string;
    VendorName: string;
    InternalID: integer;
    ParentCode: string;
    ProductCode: string;
    ProductTitle: string;
    ProductPriceOnline: double;
    ProductPricePromo: double;
    ProductPricePromoValute: string;
    ProductPriceIndicativ: double;
    ProductCost: Currency;
    ProductQty: double;
    ProductOQty: double;
    Margin: double;
    MarginRRP: double;
    InPriceList: integer;
    ImagesList: string;
    GoodsType: string;
  end;

  TProductPropertyRecord = record
    Id: integer;
    Hardcode: integer;
    PropertyCode: string;
    PropertyNameRus: string;
    PropertyNameRom: string;
    PropertyValue: string;
    PropertyParentCode: string;
    WebVisible: string;
    Description: string;
    DescriptionRom: string;
    TagName: string;
    TagNameRus: string;
    TagNameRom: string;
    SortOrder: string;
    TransactdionID: integer;
  end;

  TOnSyncSaveRecord = procedure(AIndex: integer) of object;

  TApiAccent = class
  private
    FUserName: string;
    FPassword: string;
    AccentProductList: TList<TAccentProductRecord>;
    AccentProductRecord: TAccentProductRecord;
    FConnection: TIBCConnection;
    FFlgImportWithRRP: boolean;
    FRateUsd: Currency;
    FGuid: string;
    FJSONBody: string;
    FOnSyncSaveRecord: TOnSyncSaveRecord;
  protected
    IdHTTP: TIdHttp;
  public
    constructor Create(AConnection: TIBCConnection; ARateUsd: Currency; AFlgImportWithRRP: boolean);
    destructor Destroy; override;
    function Connect: boolean;
    procedure GetJSONProducts;
    procedure ParseJSON;
    procedure GeneratePriceList(PriceCategoryID: integer);
    function SaveImageFromFtpToStream(IdFtp: TIdFtp; FilePath: string; ErrorList: TSTringlist): TMemoryStream;

    class function iif(Condition: boolean; TrueValue, FalseValue: Variant): Variant;
    class function nullcoalesce(Value: Variant; DefaultValue: Variant): Variant;

    procedure SavePriceToDB(Connection: TIBCConnection; var ProgressBar: TcxProgressBar);
    property OnSyncSaveRecord: TOnSyncSaveRecord read FOnSyncSaveRecord write FOnSyncSaveRecord;

  end;

implementation

uses
  System.IOUtils, System.JSON, System.Variants;

class function TApiAccent.iif(Condition: boolean; TrueValue, FalseValue: Variant): Variant;
begin
  if Condition then
    Result := TrueValue
  else
    Result := FalseValue;
end;

class function TApiAccent.nullcoalesce(Value: Variant; DefaultValue: Variant): Variant;
begin
  Result := iif(VarIsNull(Value), DefaultValue, Value);
end;

{ TApiAccent }

function TApiAccent.Connect: boolean;
var
  s: string;
  Resp_Json: string;
  RequestJson: TStream;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  st: string;
  tokenID: string;
begin
  Result := false;
  s := '{';
  s := s + '"userlogin": "Fantastic.APIUser",';
  s := s + '"userpassword": "D1519F75556D1D689C3C24C721CCFF9C"';
  s := s + '}';
  RequestJson := TStringStream.Create(s);
  RequestJson.Position := 0;
  try
    IdHTTP.Request.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
    IdHTTP.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
    IdHTTP.Request.ContentType := 'application/json; charset=UTF-8';
    IdHTTP.Request.CharSet := 'utf-8';

    Resp_Json := IdHTTP.Post('http://b2brestful.accent.md:8090/loginuser/getid', RequestJson);
  finally
    RequestJson.Free;
  end;

  st := Resp_Json;
  JSonObject := TJSONObject.Create;
  try
    JSonValue := JSonObject.ParseJSONValue(st);
    FGuid := (JSonValue as TJSONObject).Get('guid').JSonValue.Value;
    Result := True;
  finally
    JSonObject.Free;
  end;
end;

constructor TApiAccent.Create(AConnection: TIBCConnection; ARateUsd: Currency; AFlgImportWithRRP: boolean);
begin
  AccentProductList := TList<TAccentProductRecord>.Create;
  FConnection := AConnection;
  IdHTTP := TIdHttp.Create;
  FRateUsd := ARateUsd;
  FFlgImportWithRRP := AFlgImportWithRRP;
end;

destructor TApiAccent.Destroy;
begin
  AccentProductList.Free;
  inherited;
end;

procedure TApiAccent.GetJSONProducts;
var
  s: string;
  Req_Json: TStream;
begin
  Req_Json := TStringStream.Create(s);
  Req_Json.Position := 0;
  try
    IdHTTP.Request.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
    IdHTTP.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
    IdHTTP.Request.ContentType := 'application/json; charset=UTF-8';
    IdHTTP.Request.CharSet := 'utf-8';

    FJSONBody := IdHTTP.Post('http://b2brestful.accent.md:8090/hard/' + FGuid + '/catalogandstock/0', Req_Json);
  finally
    Req_Json.Free;
  end;
end;

procedure TApiAccent.ParseJSON;
var
  AProduct: TJSONObject;
  s: string;
  aPair: TJSONPair;
  InternalID: integer;
  GoodsCode: string;
  GoodsName: string;
  j: integer;
  JSONArray: TJSONArray;
  LJsonValue: TJSONValue;
  LItem: TJSONValue;
  N: integer;
  OnlinePrice: string;
  ParentCode: string;
  Price: string;
  Cost: string;
  FolderName: string;
  I: integer;
  IdHTTPGoods: TIdHttp;
  InPriceList: integer;
  IsFolder: string;
  MaxTransaction: integer;
  OQty: string;
  PromoPrice: string;
  PromoPriceValute: string;
  Qty: string;
  RootName: string;
  StockQty: string;
  TransactionID: integer;
  VendorName: string;
  ImagesList: string;
  GoodsType: string;
begin
  // clear list of objects
  for I := 0 to AccentProductList.Count - 1 do
    AccentProductList.Delete(0);

  JSONArray := TJSONArray.Create;
  JSONArray := TJSONArray(TJSONObject.ParseJSONValue(FJSONBody));
  TFile.WriteAllText('accent.json', FJSONBody, TEncoding.UTF8);

  IsFolder := '0';
  MaxTransaction := 0;
  for LJsonValue in JSONArray do
  begin
    AProduct := TJSONObject(LJsonValue);
      // initialization variables
    IsFolder := '0';
    GoodsCode := '';
    GoodsName := '';
    Price := '';
    OnlinePrice := '';
    ParentCode := '';
    StockQty := '';
    VendorName := '';
    TransactionID := -1;
    Cost := '0';
    Qty := '0';
    OQty := '0';
    RootName := '';
    FolderName := '';
    PromoPrice := '';
    PromoPriceValute := '';
    InPriceList := 0;
    ImagesList := '';
    GoodsType := '';

    for j := 0 to AProduct.Size - 1 do
    begin
      aPair := AProduct.Get(j);
      s := aPair.JsonString.Value;

      if s = 'isfolder' then
        IsFolder := '1';
      if s = 'code' then
        InternalID := aPair.JSonValue.Value.ToInteger
      else if s = 'hardnum' then
        GoodsCode := aPair.JSonValue.Value
      else if s = 'hardname' then
        GoodsName := aPair.JSonValue.Value
      else if s = 'hardtypename' then
        GoodsType := aPair.JSonValue.Value
      else if s = 'dprice1' then
        Price := aPair.JSonValue.Value
      else if s = 'price' then
        Cost := aPair.JSonValue.Value
      else if s = 'onlineprice' then
        OnlinePrice := aPair.JSonValue.Value
      else if s = 'parentcode' then
        ParentCode := aPair.JSonValue.Value
      else if s = 'placeqty' then
        StockQty := aPair.JSonValue.Value
      else if s = 'producername' then
        VendorName := aPair.JSonValue.Value
      else if s = 'transaction_id' then
        TransactionID := aPair.JSonValue.Value.ToInteger
      else if s = 'qty' then
        Qty := aPair.JSonValue.Value
      else if s = 'oqty' then
        OQty := aPair.JSonValue.Value
      else if s = 'rootname' then
        RootName := aPair.JSonValue.Value
      else if s = 'foldername' then
        FolderName := aPair.JSonValue.Value
      else if s = 'promoprice' then
        PromoPrice := aPair.JSonValue.Value
      else if s = 'promopricevalute' then
        PromoPriceValute := aPair.JSonValue.Value
      else if s = 'inpricelist' then
        InPriceList := StrToIntDef(aPair.JSonValue.Value, 0)
      else if s = 'imagesList' then
        ImagesList := aPair.JSonValue.Value;

    end;

    if MaxTransaction < TransactionID then
      MaxTransaction := TransactionID;

    if not ((GoodsCode = 'null') or (GoodsCode = '')) then
    begin
      if (Qty <> '0') {or (OQty <> '0')} then
      begin
        AccentProductRecord.RootName := RootName;
        AccentProductRecord.FolderName := FolderName;
        AccentProductRecord.VendorName := VendorName;
        AccentProductRecord.InternalID := InternalID;
        AccentProductRecord.ProductCode := GoodsCode;
        AccentProductRecord.ProductTitle := GoodsName;
        AccentProductRecord.GoodsType := GoodsType;
        AccentProductRecord.ProductPriceOnline := strtofloatdef(OnlinePrice, 0);
        AccentProductRecord.ProductPricePromo := strtofloatdef(PromoPrice, 0);
        AccentProductRecord.ProductPricePromoValute := PromoPriceValute;
        AccentProductRecord.ProductPriceIndicativ := strtofloatdef(Price, 0);
        AccentProductRecord.ProductCost := strtofloatdef(Cost, 0);
        AccentProductRecord.ParentCode := ParentCode;
        AccentProductRecord.ProductQty := strtofloatdef(Qty, 0);
        AccentProductRecord.ProductOQty := strtofloatdef(OQty, 0);

        if (strtofloatdef(OnlinePrice, 0) > 0) and (strtofloatdef(Price, 0) > 0) then
          AccentProductRecord.Margin := (-1 * (1 - (strtofloatdef(OnlinePrice, 0) / FRateUsd / strtofloatdef(Price, 0))) * 100)
        else
          AccentProductRecord.Margin := 0;

        if (strtofloatdef(OnlinePrice, 0) > 0) and (strtofloatdef(Cost, 0) > 0) then
          AccentProductRecord.MarginRRP := (-1 * (1 - (strtofloatdef(OnlinePrice, 0) / FRateUsd / strtofloatdef(Cost, 0))) * 100)
        else
          AccentProductRecord.MarginRRP := 0;

        AccentProductRecord.InPriceList := InPriceList;
        AccentProductRecord.ImagesList := ImagesList;

        if (Qty > '0') {or (OQty = '-1')} then
          AccentProductList.Add(AccentProductRecord);
      end;
    end;
  end;
end;

procedure TApiAccent.GeneratePriceList(PriceCategoryID: integer);
var
  I: integer;
  PLID: integer;
  q: TIBCQuery;
  IBCTrLocal: TIBCTransaction;
begin
  q := TIBCQuery.Create(nil);
  IBCTrLocal := TIBCTransaction.Create(nil);

  try
    IBCTrLocal.DefaultConnection := fConnection;

    {$REGION 'Master record to ts_pricelist'}
    if not IBCTrLocal.Active then
      IBCTrLocal.StartTransaction;

    q.Transaction := IBCTrLocal;
    q.Connection := FConnection;
    q.AutoCommit := false;
    q.SQL.Clear;
    q.SQL.Add('insert into TS_PRICELISTS (SUPPLIERID,');
    q.SQL.Add('PRICE_CATEGORYID');
    q.SQL.Add(')');
    q.SQL.Add('values (:SUPPLIERID,');
    q.SQL.Add(':PRICE_CATEGORYID');
    q.SQL.Add(')');
    q.SQL.Add('returning PLID');

    q.ParamByName('SUPPLIERID').AsInteger := 198;
    q.ParamByName('PRICE_CATEGORYID').AsInteger := PriceCategoryID;
    q.Options.ReturnParams := True;
    q.ParamCheck := True;
    q.Execute;

    PLID := q.ParamByName('RET_PLID').AsInteger;
    IBCTrLocal.Commit;
    {$endregion}

    if not IBCTrLocal.Active then
      IBCTrLocal.StartTransaction;

    {$REGION 'Prepare detail table for inserting'}
    q.SQL.Clear;
    q.SQL.Add('insert into TS_PRICELIST_ITEMS (PLID,');
    q.SQL.Add('SUPPLIER_GOODS_CODE,');
    q.SQL.Add('SUPPLIER_GOODS_NAME,');

//    if FFlgImportWithRRP then
//    begin
    q.SQL.Add('PRICE3,');
    q.SQL.Add('CURRENCY3ID,');
//    end;

    q.SQL.Add('PRICE7,');
    q.SQL.Add('CURRENCY7ID,');
    q.SQL.Add('PRICE0,');
    q.SQL.Add('CURRENCY0ID)');

    q.SQL.Add('values (:PLID,');
    q.SQL.Add(':SUPPLIER_GOODS_CODE,');
    q.SQL.Add(':SUPPLIER_GOODS_NAME,');

//    if FFlgImportWithRRP then
//    begin
    q.SQL.Add(':PRICE3,');

//    end;
    q.SQL.Add(':CURRENCY3ID,');

    q.SQL.Add(':PRICE7,');
    q.SQL.Add(':CURRENCY7ID,');
    q.SQL.Add(':PRICE0,');
    q.SQL.Add(':CURRENCY0ID)');
    {$endregion}

    {$region 'Add value from product list'}
    for I := 0 to AccentProductList.Count - 1 do
    begin
      // daca este cantitate in care din stocuri atunci adaugam produsul in price
      if (AccentProductList[I].ProductQty > 0) then
      begin
        q.ParamByName('PLID').AsInteger := PLID;
        q.ParamByName('SUPPLIER_GOODS_CODE').Value := AccentProductList[I].ProductCode;
        q.ParamByName('SUPPLIER_GOODS_NAME').Value := AccentProductList[I].ProductTitle;

//        if FFlgImportWithRRP then
//        begin
        q.ParamByName('PRICE3').AsFloat := iif(AccentProductList[I].ProductPricePromo = 0, AccentProductList[I].ProductPriceOnline,
          AccentProductList[I].ProductPricePromo);
//        end;
        q.ParamByName('CURRENCY3ID').AsInteger := 498;

        q.ParamByName('PRICE7').AsFloat := iif(AccentProductList[I].ProductPriceIndicativ = 0, 0, AccentProductList[I].ProductPriceIndicativ);
        q.ParamByName('CURRENCY7ID').AsInteger := 840;

        q.ParamByName('PRICE0').AsFloat := iif(AccentProductList[I].ProductCost = 0, 0, AccentProductList[I].ProductCost);
        q.ParamByName('CURRENCY0ID').AsInteger := 840;

        q.ExecSQL;
      end;
    end;
    {$endregion}

    IBCTrLocal.Commit;
  finally
    q.Free;
    IBCTrLocal.Free;
  end;
end;

function TApiAccent.SaveImageFromFtpToStream(IdFtp: TIdFtp; FilePath: string; ErrorList: TSTringlist): TMemoryStream;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    try
      IdFtp.get(FilePath, ms);
    except
      on E: Exception do
      begin
        if Assigned(ErrorList) then
          ErrorList.Add('Ошибка скачивания файла: ' + E.Message);
      end;
    end;
    ms.Position := 0;
    Result := ms;
  finally
    ms.Free;
  end;
end;

procedure TApiAccent.SavePriceToDB(Connection: TIBCConnection; var ProgressBar: TcxProgressBar);
var
  q: TIBCQuery;
  tr: TIBCTransaction;
begin
  q := TIBCQuery.Create(nil);
  tr := TIBCTransaction.Create(nil);
  try
    q.AutoCommit := false;
    tr.DefaultConnection := Connection;
    tr.Params.Add('nowait');
    tr.Params.Add('read_committed');

    tr.StartTransaction;
    q.Transaction := tr;
    q.SQL.Add('delete from tapi_accent_nomeclature');
    q.Execute;

    q.SQL.Clear;
    q.SQL.Add('insert into tapi_accent_nomeclature (rootname, foldername, vendorname, internalid, parent_code, product_code,');
    q.SQL.Add('product_title, product_price_online, product_price_promo,');
    q.SQL.Add('product_price_promo_valute, product_price_indicativ, product_cost, product_qty,');
    q.SQL.Add('margin, margin_rrp, inpricelist, imageslist)');
    q.SQL.Add('values (:rootname, :foldername, :vendorname, :internalid, :parent_code, :product_code, :product_title,');
    q.SQL.Add(':product_price_online, :product_price_promo, :product_price_promo_valute, :product_price_indicativ,');
    q.SQL.Add(':product_cost, :product_qty, :margin, :margin_rrp, :inpricelist, :imageslist)');
    q.Prepare;

    ProgressBar.Position := 0;
    ProgressBar.Properties.Min := 0;
    ProgressBar.Properties.Max := AccentProductList.Count - 1;

    for var I := 0 to AccentProductList.Count - 1 do
    begin
      begin
        q.ParamByName('internalid').AsInteger := AccentProductList[I].InternalID;
        q.ParamByName('rootname').AsString := AccentProductList[I].RootName;
        q.ParamByName('foldername').AsString := AccentProductList[I].FolderName;
        q.ParamByName('vendorname').AsString := AccentProductList[I].VendorName;
        q.ParamByName('parent_code').AsString := AccentProductList[I].ParentCode;
        q.ParamByName('product_code').AsString := AccentProductList[I].ProductCode;
        q.ParamByName('product_title').AsString := AccentProductList[I].ProductTitle;
        q.ParamByName('product_price_online').AsFloat := AccentProductList[I].ProductPriceOnline;
        q.ParamByName('product_price_promo').AsFloat := AccentProductList[I].ProductPricePromo;
        q.ParamByName('product_price_promo_valute').AsString := AccentProductList[I].ProductPricePromoValute;
        q.ParamByName('product_price_indicativ').AsFloat := AccentProductList[I].ProductPriceIndicativ;
        q.ParamByName('product_cost').AsFloat := AccentProductList[I].ProductCost;
        q.ParamByName('product_qty').AsFloat := AccentProductList[I].ProductQty + AccentProductList[I].ProductOQty;
        q.ParamByName('margin').AsFloat := AccentProductList[I].Margin;
        q.ParamByName('margin_rrp').AsFloat := AccentProductList[I].MarginRRP;
        q.ParamByName('inpricelist').AsInteger := AccentProductList[I].InPriceList;
        q.ParamByName('imageslist').AsString := AccentProductList[I].ImagesList;
        q.ExecSQL();

        if Assigned(FOnSyncSaveRecord) then
          FOnSyncSaveRecord(I);
      end;
    end;
    tr.Commit;
  finally
    tr.Free;
    q.Free;
  end;
end;

end.


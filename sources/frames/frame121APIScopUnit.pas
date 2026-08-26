unit frame121APIScopUnit;
{
  ИНВЕНТАРИЗАЦИЯ. Инвентаризация
  DocTypeID = 1968
  Frame Index = 80
}

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.UITypes, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxCheckBox, cxCurrencyEdit,
    cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSplitter,
    cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS,
    cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator,
    cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
    dxDateRanges, dxSpreadSheetReportDesignerActions,
    dxSpreadSheetConditionalFormattingRulesActions, dxSpreadSheetActions,
    dxPrinting, System.Actions, Vcl.ActnList, dxActions, System.ImageList,
    Vcl.ImgList, cxImageList, dxScrollbarAnnotations, Vcl.StdCtrls,
    System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
    Vcl.ExtActns, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
    IdHTTP, System.JSON, Data.DBXJSON, cxContainer, cxTextEdit, cxMaskEdit,
    cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc,
    Vcl.Menus, cxButtons, cxPC, cxProgressBar, ApiAccentUnit, cxImage,
    System.Generics.Collections, cxCalendar, dxUIAClasses, IdAuthentication,
    dxGDIPlusClasses;

const
    supplierid = 209280;

type
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

    Tframe121ApiScop = class(TSWNBaseFrame)
        IdHTTP1: TIdHTTP;
        IBCQueryPriceCategories: TIBCQuery;
        IBCDataSourcePriceCategories: TIBCDataSource;
        IBCTrLocal: TIBCTransaction;
        IBCQueryCurrencyUSD: TIBCQuery;
        NetHTTPClient1: TNetHTTPClient;
        NetHTTPRequest1: TNetHTTPRequest;
        IBCQueryGoods: TIBCQuery;
        IBCDataSourceGoods: TIBCDataSource;
        IBCQuerySupplierGoods: TIBCQuery;
        IBCDataSourceSupplierGoods: TIBCDataSource;
        IBCSQL1: TIBCSQL;
        cxPageControl1: TcxPageControl;
        tsPriceList: TcxTabSheet;
        lcbPriceCategory: TcxLookupComboBox;
        cxLabel3: TcxLabel;
        btnGetPriceList: TButton;
        cxPageControl2: TcxPageControl;
        tbsPricelist: TcxTabSheet;
        cxGrid1: TcxGrid;
        cxGrid1TableView1: TcxGridTableView;
        cxGrid1TableView1_PROMODESCRIPTION: TcxGridColumn;
        cxGrid1TableView1_PROMOSTART: TcxGridColumn;
        cxGrid1TableView1_PROMOFINISH: TcxGridColumn;
        cxGrid1TableView1_ROOTNAME: TcxGridColumn;
        cxGrid1TableView1_FOLDERNAME: TcxGridColumn;
        cxGrid1TableView1_VENDORNAME: TcxGridColumn;
        cxGrid1TableView1_INPRICELIST: TcxGridColumn;
        cxGrid1TableView1_GOODS_CODE: TcxGridColumn;
        cxGrid1TableView1_GOODSNAME: TcxGridColumn;
        cxGrid1TableView1_PRICE3: TcxGridColumn;
        cxGrid1TableView1_promoprice: TcxGridColumn;
        cxGrid1TableView1_promopricevalute: TcxGridColumn;
        cxGrid1TableView1_PRICE7: TcxGridColumn;
        cxGrid1TableView1_COST: TcxGridColumn;
        cxGrid1TableView1_PARENT_CODE: TcxGridColumn;
        cxGrid1TableView1_QTY: TcxGridColumn;
        cxGrid1TableView1_OQTY: TcxGridColumn;
        cxGrid1TableView1_MARGIN: TcxGridColumn;
        cxGrid1TableView1_MARGIN_RRP: TcxGridColumn;
        cxGrid1TableView1_IMAGESLIST: TcxGridColumn;
        cxGrid1Level1: TcxGridLevel;
        cxTabSheet1: TcxTabSheet;
        cxGrid5: TcxGrid;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
        cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
        cxGridLevel2: TcxGridLevel;
        cxButton1: TcxButton;
        cxImage1: TcxImage;
        btnLoadFromFile: TButton;
        btnSave: TButton;
        Memo2: TMemo;
        IBCQueryParser: TIBCQuery;
        IBCDataSourceParser: TIBCDataSource;
        cxProgressBar2: TcxProgressBar;
        IBCQueryParseSupplierGoods: TIBCQuery;
        IBCDataSourceParseSupplierGoods: TIBCDataSource;
        Memo1: TMemo;
        procedure btnGetPriceListClick(Sender: TObject);
        procedure btnLoadFromFileClick(Sender: TObject);
        procedure btnSaveClick(Sender: TObject);
        procedure cxGrid1TableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxTabSheet1Show(Sender: TObject);
        procedure cxButton1Click(Sender: TObject);
    private
{ Private declarations }
//    fLastGoodsFolderID: Integer;
        guid: string;
        JSONBody: string;
        ProductPropertiesList: TList<TProductPropertyRecord>;

        procedure GetToken;
        procedure GetCatalogItems(PageNo: integer);
        procedure ParseCatalog;
        procedure ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
        procedure LoadGridDataFromFile(const FileName: string);
        procedure SaveGridDataToFile(const FileName: string);
        procedure GetImages;
        function GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
    protected    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DeleteRecord; override;
        procedure GeneratePriceList(PriceCategoryID: Integer);
        procedure PrepareData;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;
        procedure SetupSecurityItems; override;
    public    { Public declarations }

        procedure SetupDefaultFocus; override;
        procedure SaveDescriptionToDB(Connection: TIBCConnection);
        procedure SaveToParseTable;
    end;

implementation

{$R *.dfm}

uses
    SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
    DataModuleAdditions, SWNValueStorageUnit, IdFTP, Vcl.Imaging.pngimage,
    WebpHelpers, Winapi.GDIPOBJ, Vcl.Imaging.jpeg, System.IOUtils, libwebp,
    Vcl.Imaging.GIFImg, Vcl.WebpImage, Vcl.Clipbrd, IdHeaderList,
    IdGlobalProtocols, System.Diagnostics;

procedure Tframe121ApiScop.SaveGridDataToFile(const FileName: string);
var
    Stream: TFileStream;
begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
        cxGrid1TableView1.DataController.SaveToStream(Stream);
    finally
        Stream.Free;
    end;
end;

procedure Tframe121ApiScop.LoadGridDataFromFile(const FileName: string);
var
    Stream: TFileStream;
begin
    if FileExists(FileName) then
    begin
        Stream := TFileStream.Create(FileName, fmOpenRead);
        try
            cxGrid1TableView1.DataController.LoadFromStream(Stream);
        finally
            Stream.Free;
        end;
    end;
end;

procedure Tframe121ApiScop.btnGetPriceListClick(Sender: TObject);
var
    w: TStopWatch;
begin
    cxPageControl2.ActivePage := tbsPricelist;
    Application.ProcessMessages;
    screen.Cursor := crHourGlass;
    try
        GetToken;
        w := TStopwatch.Create.StartNew;
        GetCatalogItems(1);
        application.processMessages;
        if IBCQueryPriceCategories.RecordCount > 0 then
            lcbPriceCategory.EditValue := IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger;

        GeneratePriceList(lcbPriceCategory.EditValue);
        application.processMessages;
        SaveToParseTable;
        application.processMessages;
        GetImages;
        application.processMessages;
        w.Stop;
    finally
        screen.Cursor := crDefault;
    end;

end;

procedure Tframe121ApiScop.btnLoadFromFileClick(Sender: TObject);
begin
    inherited;
    LoadGridDataFromFile('triomac.dat');
end;

procedure Tframe121ApiScop.btnSaveClick(Sender: TObject);
begin
    inherited;
    SaveGridDataToFile('triomac.dat');
end;

procedure Tframe121ApiScop.GetToken;
var
    s: string;
    Resp_Json: string;
    Req_Json: TStream;
    JSonObject: TJSONObject;
    JSonValue: TJSONValue;
    st: string;
    tokenID: string;
begin
    s := '{';
    s := s + '"email": "marketing@fantastic.md",';
    s := s + '"password": "Gama654!!"';
    s := s + '}';
    Req_Json := TStringStream.Create(s);
    Req_Json.Position := 0;
    try
        IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
        IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
        IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
        IdHTTP1.Request.CharSet := 'utf-8';
        Resp_Json := IdHTTP1.Post('https://api.scop.md/api/account/login', Req_Json);
    finally
        Req_Json.Free;
    end;

    st := Resp_Json;
    JSonObject := TJSONObject.Create;
    try
        JSonValue := JSonObject.ParseJSONValue(st);
        guid := (JSonValue as TJSONObject).Get('accessToken').JSonValue.Value;
    finally
        JSonObject.Free;
    end;
end;

procedure Tframe121ApiScop.GetCatalogItems(PageNo: integer);
const
    Limit = 500;
var
    s: string;
    Req_Json: TStream;
    idHeaderList: TidHeaderList;
    JSonObject: TJSONObject;
    JSonValue: TJSonValue;
    Pages: Variant;
begin

    s := '{';
    s := s + '"accessToken": "' + guid + '",';
    s := s + '"Page": "' + PageNo.ToString + '",';
    s := s + '"Limit": "' + Limit.ToString + '"';
    s := s + '}';
    Req_Json := TStringStream.Create(s);
    Req_Json.Position := 0;
    try
        IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
        IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
        IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
        idHeaderList := TidHeaderList.Create(QuotePlain);
        try
            idHeaderList.AddValue('Authorization', 'Bearer ' + guid);
            IdHTTP1.Request.CustomHeaders := idHeaderList;
            IdHTTP1.Request.CharSet := 'utf-8';

            JSONBody := IdHTTP1.Post('https://api.scop.md/api/shop-products', Req_Json);
            var Strings: TStringList;
            var FileName: string;
            FileName := 'd:\b2b.scop\output.json';

            Strings := TStringList.Create;
            try
                Strings.Text := JSONBody;
                Strings.SaveToFile(FileName, TEncoding.UTF8);
            finally
                Strings.Free;
            end;
        finally
            idHeaderList.Free;
        end;
    finally
        Req_Json.Free;
    end;

    {
      complete data on grid
    }

    var ItemsArray: TJSONArray;
    var Item: TJSONObject;
    var Name, sku, Description: string;
    var Price, RRPPrice: string;
    var RRPCurrency, Currency: string;
    var ImageURL, brand: string;
    var N: Integer;
    var qty: string;

    JSonObject := TJSONObject.Create;
    cxGrid1TableView1.BeginUpdate;
    try
        JSonValue := JSonObject.ParseJSONValue(JSONBody);
        Pages := (JSonValue as TJSONObject).Get('pages').JSonValue.Value;

        cxProgressBar2.Position := PageNo;
        cxProgressBar2.Properties.Min := 0;
        cxprogressbar2.Properties.Max := Pages;
        Application.ProcessMessages;

        ItemsArray := JSonValue.GetValue<TJSONArray>('items');
        for var i := 0 to (ItemsArray.Count - 1) do
        begin
            Item := ItemsArray.Items[i] as TJSONObject;

              // Извлечение имени товара
            Name := Item.GetValue<string>('name');
            try
                sku := Item.GetValue<string>('sku');
            except
                on E: Exception do
                begin
                    Memo2.Lines.Add('*** SKU Empty, Name: ' + Name + #13#10 + E.Message);
                    Continue;
                end;
            end;

            qty := Item.GetValue<string>('stockQuantity');

            Description := Item.GetValue<string>('description');

              // Извлечение цены
            Price := Item.GetValue<TJSONObject>('calculatedProductPrice').GetValue<string>('priceUsd');
            Currency := 'USD';
            try
              RRPPrice := Item.GetValue<TJSONObject>('rrpPrice').GetValue<string>('value');
            except
              RRPPrice := '0';
            end;
            try
              RRPCurrency := Item.GetValue<TJSONObject>('rrpPrice').GetValue<string>('currency');
            except
              RRPCurrency := '498';
            end;

            brand := Item.GetValue<TJSONObject>('brand').GetValue<string>('name');

              // Извлечение URL изображения
            try
                ImageURL := Item.GetValue<TJSONArray>('images').Items[0].Value;
            except
                on e: exception do
                begin
                    ImageURL := '';
                    Memo2.Lines.Add('*** ImageUrl Empty, Name: ' + Name + #13#10 + E.Message);
                end;
            end;

            if StrToIntDef(qty, 0) > 0 then
            begin
                N := cxGrid1TableView1.DataController.AppendRecord;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_GOODSNAME.Index] := Name;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_GOODS_CODE.Index] := sku;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PRICE3.Index] := RRPPrice;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PRICE7.Index] := Price;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_VENDORNAME.Index] := brand;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_IMAGESLIST.Index] := ImageURL;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_QTY.Index] := qty;
                cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_INPRICELIST.Index] := 1;
                cxGrid1TableView1.DataController.Post;
                Application.ProcessMessages;
            end;
        end
    finally
        cxGrid1TableView1.EndUpdate;
        JSonObject.Free;
    end;

    if (PageNo < Pages) then
    begin
        inc(PageNo);
        GetCatalogItems(PageNo);
    end;
end;

procedure Tframe121ApiScop.ParseCatalog;
var
    AProduct: TJSONObject;
    s: string;
    aPair: TJSONPair;
    GoodsCode: string;
    GoodsName: string;
    j: Integer;
    JSONArray: TJSONArray;
    LJsonValue: TJSONValue;
//  LItem: TJSONValue;
    N: Integer;
    OnlinePrice: string;
    ParentCode: string;
    Price: string;
    Cost: string;
    foldername: string;
    I: Integer;
//  IdHTTPGoods: TIdHTTP;
    inpricelist: Integer;
    IsFolder: string;
    MaxTransaction: Integer;
    oqty: string;
    promoprice: string;
    promopricevalute: string;
    qty: string;
    rootname: string;
    StockQty: string;
    TransactionID: Integer;
    VendorName: string;
    imagesList: string;
    ErrorStr: string;
    promodescription: string;
    promofinish: string;
    promostart: string;
begin
    ErrorStr := '';
    IBCQueryCurrencyUSD.Open;
    for I := 0 to cxGrid1TableView1.DataController.RecordCount - 1 do
        cxGrid1TableView1.DataController.DeleteRecord(0);

//  JSONArray := TJSONArray.Create;
    JSONArray := TJSONArray(TJSONObject.ParseJSONValue(JSONBody));
    cxGrid1TableView1.BeginUpdate;
    IsFolder := '0';
    MaxTransaction := 0;
    cxGrid1TableView1.BeginUpdate;
    try
        for LJsonValue in JSONArray do
        begin
            AProduct := TJSONObject(LJsonValue);
            for j := 0 to AProduct.Count - 1 do
            begin
                aPair := AProduct.Pairs[j];
                s := aPair.JsonString.Value;
//                if s = 'isfolder' then
//                    IsFolder := '1';
                if s = 'hardnum' then
                    GoodsCode := aPair.JsonValue.Value
                else if s = 'hardname' then
                    GoodsName := aPair.JsonValue.Value
                else if s = 'dprice1' then
                    Price := aPair.JsonValue.Value
                else if s = 'price' then
                    Cost := aPair.JsonValue.Value
                else if s = 'onlineprice' then
                    OnlinePrice := aPair.JsonValue.Value
                else if s = 'parentcode' then
                    ParentCode := aPair.JsonValue.Value
                else if s = 'placeqty' then
                    StockQty := aPair.JsonValue.Value
                else if s = 'producername' then
                    VendorName := aPair.JsonValue.Value
                else if s = 'transaction_id' then
                    TransactionID := aPair.JsonValue.Value.ToInteger
                else if s = 'qty' then
                    qty := aPair.JsonValue.Value
                else if s = 'oqty' then
                    oqty := aPair.JsonValue.Value
                else if s = 'rootname' then
                    rootname := aPair.JsonValue.Value
                else if s = 'foldername' then
                    foldername := aPair.JsonValue.Value
                else if s = 'promoprice' then
                    promoprice := aPair.JsonValue.Value
                else if s = 'promodescription' then
                    promodescription := aPair.JsonValue.Value
                else if s = 'promopricevalute' then
                    promopricevalute := aPair.JsonValue.Value
                else if s = 'promostartdate' then
                    promostart := aPair.JsonValue.Value
                else if s = 'promofinishdate' then
                    promofinish := aPair.JsonValue.Value
                else if s = 'inpricelist' then
                begin
                    try
                        inpricelist := aPair.JsonValue.Value.ToInteger;
                    except
                        on e: Exception do
                        begin
                            inpricelist := 0;
                            ErrorStr := ErrorStr + #13#10 + GoodsCode + ' - ' + 'inpricelist, ' + E.Message;
                            ;
                        end;
                    end;
                end
                else if s = 'imagesList' then
                    imagesList := aPair.JsonValue.Value;

            end;

            if (MaxTransaction < TransactionID) then
                MaxTransaction := TransactionID;

      // (IsFolder = 'null') and

            if not ((GoodsCode = 'null') or (GoodsCode = '')) then
            begin
                if (qty <> '0') or (oqty <> '0') then
                begin
                    N := cxGrid1TableView1.DataController.AppendRecord;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_ROOTNAME.Index] := rootname;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_FOLDERNAME.Index] := foldername;

                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_VENDORNAME.Index] := VendorName;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_GOODS_CODE.Index] := GoodsCode;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_GOODSNAME.Index] := GoodsName;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PRICE3.Index] := strtofloatdef(OnlinePrice, 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_promoprice.Index] := promoprice;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_promopricevalute.Index] := promopricevalute;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PRICE7.Index] := strtofloatdef(Price, 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_COST.Index] := strtofloatdef(Cost, 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PARENT_CODE.Index] := ParentCode;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PROMODESCRIPTION.Index] := promodescription;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PROMOSTART.Index] := promostart;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_PROMOFINISH.Index] := promofinish;

                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_QTY.Index] := strtofloatdef(qty, 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_OQTY.Index] := strtofloatdef(oqty, 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_MARGIN.Index] := iif((strtofloatdef(OnlinePrice, 0) > 0) and (strtofloatdef(Price, 0) > 0), (-1 * (1 - (strtofloatdef(OnlinePrice, 0) / (IBCQueryCurrencyUSD.fieldbyname('transfer_rate').AsFloat) / strtofloatdef(Price, 0))) * 100), 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_MARGIN_RRP.Index] := iif((strtofloatdef(OnlinePrice, 0) > 0) and (strtofloatdef(Cost, 0) > 0), (-1 * (1 - (strtofloatdef(OnlinePrice, 0) / (IBCQueryCurrencyUSD.fieldbyname('transfer_rate').AsFloat) / strtofloatdef(Cost, 0))) * 100), 0);
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_INPRICELIST.Index] := inpricelist;
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_IMAGESLIST.Index] := imagesList;
                end;
            end;
            GoodsCode := '';
            GoodsName := '';
            Price := '';
            Cost := '';
        end;
    finally
        cxGrid1TableView1.EndUpdate;
    end;

    if ErrorStr <> '' then
    begin
        ShowMessage(ErrorStr);
    end;

//    lbMaxTr.Caption := Format('Max transaction: %d', [MaxTransaction]);
    cxGrid1TableView1.EndUpdate;
end;

procedure Tframe121ApiScop.DeleteRecord;
begin
end;

procedure Tframe121ApiScop.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    IBCQueryPriceCategories.Close;
    IBCQueryCurrencyUSD.Close;
    IBCQueryGoods.Close;

    CloseExternalData;
//     // 1. De scos la griduri event handles for OnFocusedRecordChanged
//   cxGridDocsTable.OnFocusedRecordChanged := nil;

//
//     // 2. De deconectat sursele de date de la griduri
//   cxGridDocsTable.DataController.DataSource := nil;
//   cxGridInventDBTableView.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe121ApiScop.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

    IBCQueryPriceCategories.Close;
    IBCQueryPriceCategories.ParamByName('customerid').AsInteger := 209280; // triomac
    IBCQueryPriceCategories.Open;

    IBCQueryCurrencyUSD.Open;
//  IBCQueryGoods.Open;
end;

function Tframe121ApiScop.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [];
end;

function Tframe121ApiScop.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe121ApiScop.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
//   if fSECURITY_CanNew then
//      Result := Result + [fbtADD];
//   if fSECURITY_CanEdit or fSECURITY_CanView then
//      Result := Result + [fbtMODIFY];
//   if fSECURITY_CanDelete then
//      Result := Result + [fbtDELETE];
end;

function Tframe121ApiScop.InitFrameID: Integer;
begin
    // Api Triomac
    Result := 121
end;

procedure Tframe121ApiScop.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe121ApiScop.RefreshData;
begin
    inherited;
//     IBCQueryGoods.Refresh;
end;

procedure Tframe121ApiScop.SaveDescriptionToDB(Connection: TIBCConnection);
var
    q: TIBCSQL;
begin
    q := TIBCSQL.Create(nil);
    try
        q.Transaction := IBCTrLocal;
        IBCTrLocal.StartTransaction;
        q.SQL.Add('insert into tapi_accent_products_properties (id, hardcode, property_code, property_name_rus, property_name_rom,');
        q.SQL.Add('property_value, property_parent_code, web_visible, description,');
        q.SQL.Add('description_rom, tag_name, tag_name_rus, tag_name_rom, sort_order,');
        q.SQL.Add('transactionid)');
        q.SQL.Add('values (:id, :hardcode, :property_code, :property_name_rus, :property_name_rom, :property_value, :property_parent_code,');
        q.SQL.Add(':web_visible, :description, :description_rom, :tag_name, :tag_name_rus, :tag_name_rom, :sort_order,');
        q.SQL.Add(':transactionid)');
        q.Prepare;

        for var I := 0 to ProductPropertiesList.Count - 1 do
        begin
            q.ParamByName('id').AsString := ProductPropertiesList[I].id.ToString;
            q.ParamByName('hardcode').AsString := ProductPropertiesList[I].hardcode.ToString;
            q.ParamByName('property_code').AsString := ProductPropertiesList[I].PropertyCode;
            q.ParamByName('property_name_rus').AsString := ProductPropertiesList[I].PropertyNameRus;
            q.ParamByName('property_name_rom').AsString := ProductPropertiesList[I].PropertyNameRom;
            q.ParamByName('property_value').AsString := ProductPropertiesList[I].PropertyValue;
            q.ParamByName('property_parent_code').AsString := ProductPropertiesList[I].PropertyParentCode;
            q.ParamByName('web_visible').AsString := ProductPropertiesList[I].WebVisible;
            q.ParamByName('description').AsString := ProductPropertiesList[I].Description;
            q.ParamByName('description_rom').AsString := ProductPropertiesList[I].DescriptionRom;
            q.ParamByName('tag_name').AsString := ProductPropertiesList[I].TagName;
            q.ParamByName('tag_name_rus').AsString := ProductPropertiesList[I].TagNameRus;
            q.ParamByName('tag_name_rom').AsString := ProductPropertiesList[I].TagNameRom;
            q.ParamByName('sort_order').AsString := ProductPropertiesList[I].SortOrder;
            q.ParamByName('transactionid').AsString := ProductPropertiesList[I].TransactdionID.ToString;

            try
                q.Execute;
            except
                on E: Exception do
                    raise;
            end;
        end;
        ibctrLocal.Commit;
    finally
        q.Free;
    end;
end;

procedure Tframe121ApiScop.SaveFrameStates;
begin
    try
        AppUserConfigStorage.OpenSection(Self.Name);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe121ApiScop.SetupDefaultFocus;
begin

end;

procedure Tframe121ApiScop.SetupSecurityItems;
begin
//   fSECURITY_CanView := True;
//   fSECURITY_CanNew := True;
//   fSECURITY_CanEdit := True;
//   fSECURITY_CanDelete := True;
end;

procedure Tframe121ApiScop.GeneratePriceList(PriceCategoryID: Integer);
var
    GoodsCode: string;
    i: Integer;
    OQty: Integer;
    PLID: Integer;
    q: TIBCQuery;
    Qty: Integer;
begin
    q := TIBCQuery.Create(Self);
    try
    {$REGION 'Add new record to PriceList and commit'}
        if not IBCTrLocal.Active then
            IBCTrLocal.StartTransaction;

        q.Transaction := IBCTrLocal;
        q.AutoCommit := False;
        q.SQL.Clear;
        q.SQL.Add('insert into TS_PRICELISTS (SUPPLIERID,');
        q.SQL.Add('PRICE_CATEGORYID');
        q.SQL.Add(')');
        q.SQL.Add('values (:SUPPLIERID,');
        q.SQL.Add(':PRICE_CATEGORYID');
        q.SQL.Add(')');
        q.SQL.Add('returning PLID');

        q.ParamByName('SUPPLIERID').AsInteger := 209280; // triomac
        q.ParamByName('PRICE_CATEGORYID').AsInteger := PriceCategoryID;
        q.Options.ReturnParams := True;
        q.ParamCheck := True;
        q.Execute;

        PLID := q.ParamByName('RET_PLID').AsInteger;
        IBCTrLocal.Commit;
    {$ENDREGION}

        if not IBCTrLocal.Active then
            IBCTrLocal.StartTransaction;
    {$REGION 'Creating sql for add in ts_pricelist_items'}
        q.SQL.Clear;
        q.SQL.Add('insert into TS_PRICELIST_ITEMS (PLID,');
        q.SQL.Add('SUPPLIER_GOODS_CODE,');
        q.SQL.Add('SUPPLIER_GOODS_NAME,');

    // adicem intodeauna preturile recomandate de la furnizor
//    if cbRRP.Checked then
//    begin
        q.SQL.Add('PRICE3,');
        q.SQL.Add('CURRENCY3ID,');
//    end;

        q.SQL.Add('PRICE7,');
        q.SQL.Add('CURRENCY7ID,');
        q.SQL.Add('PRICE0,');
        q.SQL.Add('FLG_PREORDER,');
        q.SQL.Add('CURRENCY0ID)');
    {$endregion}

        q.SQL.Add('values (:PLID,');
        q.SQL.Add(':SUPPLIER_GOODS_CODE,');
        q.SQL.Add(':SUPPLIER_GOODS_NAME,');

//    if cbRRP.Checked then
//    begin
        q.SQL.Add(':PRICE3,');
        q.SQL.Add(':CURRENCY3ID,');
//    end;
        q.SQL.Add(':PRICE7,');
        q.SQL.Add(':CURRENCY7ID,');
        q.SQL.Add(':PRICE0,');
        q.SQL.Add(':FLG_PREORDER,');
        q.SQL.Add(':CURRENCY0ID)');

        for i := 0 to cxGrid1TableView1.DataController.RecordCount - 1 do
        begin
            with cxGrid1TableView1.DataController do
            begin
//                OQty := Values[FilteredRecordIndex[i], cxGrid1TableView1_OQTY.Index];
//                Qty := Values[FilteredRecordIndex[i], cxGrid1TableView1_QTY.Index];
                GoodsCode := cxGrid1TableView1.DataController.Values[cxGrid1TableView1.DataController.FilteredRecordIndex[i], cxGrid1TableView1_GOODS_CODE.Index];

                Qty := cxGrid1TableView1.DataController.Values[FilteredRecordIndex[i], cxGrid1TableView1_INPRICELIST.Index];

                if (Qty = 1) then
                begin
                    q.ParamByName('PLID').AsInteger := PLID;
                    q.ParamByName('SUPPLIER_GOODS_CODE').Value := GoodsCode;
                    q.ParamByName('SUPPLIER_GOODS_NAME').Value := Values[FilteredRecordIndex[i], cxGrid1TableView1_GOODSNAME.Index];
//                    q.ParamByName('FLG_PREORDER').AsInteger := 0;
//          if cbRRP.Checked then
//          begin
                    q.ParamByName('PRICE3').AsFloat := Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE3.Index];
//                    if q.ParamByName('PRICE3').AsFloat > 0 then
//                        q.ParamByName('CURRENCY3ID').AsInteger := 498
//                    else
                    q.ParamByName('CURRENCY3ID').AsInteger := 498;
//          end;

                    q.ParamByName('PRICE7').AsFloat := Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE7.Index];
                    q.ParamByName('CURRENCY7ID').AsInteger := 840;

                    q.ParamByName('PRICE0').AsFloat := Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE7.Index];
                    q.ParamByName('CURRENCY0ID').AsInteger := 840;

                    try
                        q.ExecSQL;
                    except
                        on e: Exception do
                        begin
                            continue;
                        end;
                    end;
                end;
            end;
        end;
        IBCTrLocal.Commit;
    finally
        q.Free;
    end;
end;

procedure Tframe121ApiScop.ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
var
    Image: TGraphic;
    PNGImage: TPngImage;
//  MemoryStream: TMemoryStream;
begin
    Image := nil;
    PNGImage := nil;
//  MemoryStream := nil;

    try
    // Create appropriate TGraphic based on the file extension
        if SameText(ExtractFileExt(ASourceFileName), '.jpg') or SameText(ExtractFileExt(ASourceFileName), '.jpeg') then
            Image := TJPEGImage.Create
        else if SameText(ExtractFileExt(ASourceFileName), '.gif') then
            Image := TGIFImage.Create
//    else if SameText(ExtractFileExt(ASourceFileName), '.webp') then
//      Image := TWebPImage.Create
        else if SameText(ExtractFileExt(ASourceFileName), '.bmp') then
            Image := TBitmap.Create
        else
            raise Exception.CreateFmt('Unsupported file extension: %s', [ExtractFileExt(ASourceFileName)]);

    // Load image from file
        Image.LoadFromFile(ASourceFileName);

    // Create PNG image and assign loaded image to it
        PNGImage := TPngImage.CreateBlank(COLOR_RGB, 8, Image.Width, Image.Height);
        PNGImage.Canvas.Draw(0, 0, Image);
        PNGImage.SaveToFile('tmp.png');
    // Save PNG image to file using a TMemoryStream
//    MemoryStream := TMemoryStream.Create;
//    PNGImage.SaveToStream(MemoryStream);
//    MemoryStream.SaveToFile(ADestFileName);
    finally
        Image.Free;
        PNGImage.Free;
//    MemoryStream.Free;
    end;
end;

procedure Tframe121ApiScop.cxButton1Click(Sender: TObject);
begin
    GetImages;
end;

function Tframe121ApiScop.GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select goodsid from ts_goods_foreign where customerid = :customerid and goods_code = :goods_code';
        q.ParamByName('goods_code').AsString := GoodsCode;
        q.ParamByName('customerid').AsInteger := SupplierID;
        q.Open;
    finally
        if q.RecordCount > 0 then
            Result := q.FieldByName('goodsid').AsInteger
        else
            Result := -1;
        q.Free;
    end;
end;

procedure Tframe121ApiScop.GetImages;
var
    ImageFileNameList: TStringList;
    GoodsID: Integer;
    ms: TMemoryStream;
    ibcsql: TIBCSQL;
    ibcsqlPrice: TIBCSQL;
    trUpdate: TIBCTransaction;
    s: string;
    Response: IHTTPResponse;
    UrlArray: TArray<string>;
    p: string;
    GoodsNotFoundCount: integer;
begin
    ImageFileNameList := TStringList.Create;
    IBCQueryParseSupplierGoods.Open;
    ImageFileNameList.Delimiter := ';';
    ibcsql := TIBCSQL.Create(nil);
    trUpdate := TIBCTransaction.Create(nil);

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    ibcsql.transaction := trUpdate;
    GoodsNotFoundCount := 0;
    var GoodsFound := 0;
    memo1.Lines.Clear;
    try
        if not trUpdate.Active then
            trUpdate.StartTransaction;

        cxProgressBar2.properties.Min := 0;
        cxProgressBar2.properties.Max := IBCQueryParseSupplierGoods.RecordCount;
        while not IBCQueryParseSupplierGoods.eof do
        begin
            GoodsID := GetGoodsID(IBCQueryParseSupplierGoods.FieldByName('goods_code').AsString, IBCQueryParseSupplierGoods.FieldByName('supplierid').AsInteger);
            if GoodsID = -1 then
            begin
                IBCQueryParseSupplierGoods.Next;
                inc(GoodsNotFoundCount);
                Memo2.Lines.Add('Error: ' + IBCQueryParseSupplierGoods.FieldByName('goods_code').AsString);
                Continue;
            end;

            s := IBCQueryParseSupplierGoods.FieldByName('images').AsString;
            UrlArray := s.Split([';']);
            ImageFileNameList.Clear;
            for p in UrlArray do
                ImageFileNameList.Add(p);

            dmdb.ExecuteQuery('delete from ts_goods_image where goodsid = :goodsid', [GoodsID]);

            ibcsql.AutoCommit := false;
            inc(GoodsFound);
            for var j := 0 to ImageFileNameList.Count - 1 do
            begin
                ms := TMemoryStream.Create;
                try
                    try
                        s := ImageFileNameList[j];
                        Response := NetHttpClient1.Get(ImageFileNameList[j]);
                        if Response.StatusCode = 200 then
                        begin
                            var pngImage := TdxSmartImage.Create;
                            try
                                ms.LoadFromStream(Response.ContentStream);
                                ms.Position := 0;
                                cxImage1.Picture.LoadFromStream(ms);

                                var bitmap := TBitmap.Create;
                                try
                                    bitmap.Assign(cxImage1.Picture.Graphic);
                                    pngImage := TdxSmartImage.CreateFromBitmap(bitmap);
                                    var PNGImageStream := TMemoryStream.Create;
                                    try
                                        pngImage.SaveToStreamByCodec(PNGImageStream, TdxImageDataFormat.dxImagePng);
                                        PNGImageStream.Position := 0;
                                        PNGImageStream.SaveToFile('tmp.png');
                                    finally
                                        PNGImageStream.Free;
                                    end;
                                    application.ProcessMessages;
                                finally
                                    bitmap.Free;
                                end;
                            finally
                                pngImage.Free;
                            end;

                            ibcsql.sql.Clear;
                            ibcsql.sql.add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
                            ibcsql.sql.add('values (:goodsid, :image, :flg_need2recreate)');
                            ibcsql.Prepare;

                            ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
                            ibcsql.ParamByName('image').LoadFromFile('tmp.png', ftBlob);
                            ibcsql.ParamByName('flg_need2recreate').Asinteger := 1;
                            ibcsql.Execute;
                        end
                        else
                            memo1.lines.add('Bad response: ' + GoodsID.ToString + ';  Response code: ' + Response.StatusCode.ToString);
                    except
                        memo1.lines.add('Error on GoodsID: ' + GoodsID.ToString + ';  Path: ' + ImageFileNameList[j]);
                        Continue;
                    end;

                    Application.ProcessMessages;
                finally
                    ms.Free;
                end;
            end;
            cxProgressBar2.Position := IBCQueryParseSupplierGoods.RecNo;
            Memo1.Lines.Add('added images for goods: ' + GoodsID.ToString);
            Application.ProcessMessages;
            IBCQueryParseSupplierGoods.Next;
        end;
        trUpdate.Commit;
        Memo1.Lines.Add('Not linked goods: ' + GoodsNotFoundCount.ToString);
        Memo1.Lines.Add('UpdatedGoods: ' + GoodsFound.ToString);
    finally
        ibcsql.Free;
        trUpdate.Free;
        ImageFileNameList.Free;
    end;
end;

procedure Tframe121ApiScop.cxGrid1TableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    inherited;
    if ARecord.Values[cxGrid1TableView1_COST.Index] >= ARecord.Values[cxGrid1TableView1_PRICE7.Index] then
    begin
        AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure Tframe121ApiScop.cxTabSheet1Show(Sender: TObject);
begin
    inherited;
    if not IBCQuerySupplierGoods.Active then
        IBCQuerySupplierGoods.Open
    else
        IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe121ApiScop.PrepareData;
begin
//    ibcqueryGoods.Close;
//
//    if ckbNoImage.Checked then
//        ibcquerygoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
//    else
//        IBCQueryGoods.MacroByName('FlgNoImage').Value := '';
//
//    if ckbInPrice.Checked then
//        ibcquerygoods.MacroByName('FlgInPrice').Value := ' and get_flg_in_price(goodsid)=1'
//    else
//        IBCQueryGoods.MacroByName('FlgInPrice').Value := '';
//
//    ibcqueryGoods.Open;

    IBCDataSourcePriceCategories.DataSet.Open;
    IBCQueryParseSupplierGoods.Open;

end;

procedure Tframe121ApiScop.SaveToParseTable;
var
    GoodsCode: string;
    TableView: TcxGridDBTableView;
    ImagePath: string;
    q: TIBCQuery;
begin
    if not ibctrLocal.Active then
        IBCTrLocal.StartTransaction;

    q := TIBCQuery.Create(nil);
    q.AutoCommit := False;
    try
        q.Transaction := IBCTrLocal;
        q.SQL.Text := 'update or insert into tparse_supplier_goods (supplierid, goods_code, images) values(:supplierid, :goods_code, :image) matching (supplierid, goods_code)';
        q.Prepare;
        for var I := 0 to cxGrid1TableView1.DataController.RecordCount - 1 do
        begin
            ImagePath := cxGrid1TableView1.DataController.Values[cxGrid1TableView1.DataController.FilteredRecordIndex[I], cxGrid1TableView1_IMAGESLIST.Index];

            if ImagePath <> '' then
            begin
                GoodsCode := cxGrid1TableView1.DataController.Values[cxGrid1TableView1.DataController.FilteredRecordIndex[I], cxGrid1TableView1_GOODS_CODE.Index];

                q.ParamByName('goods_code').AsString := GoodsCode;

                q.ParamByName('Image').AsString := ImagePath;
                q.ParamByName('supplierid').AsInteger := SupplierID;
                q.ExecSQL;
                Memo2.Lines.add('Goods Code: ' + GoodsCode);
            end;
            application.ProcessMessages;
        end;

        if ibctrLocal.Active then
            ibctrlocal.Commit;
    finally
        q.Free;
    end;
end;

end.


unit frame91APIAccentUnit;
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
    cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox, cxCurrencyEdit,
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
    Generics.Collections, cxCalendar, dxUIAClasses, AccentAuthService;

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

    Tframe91APIAccent = class(TSWNBaseFrame)
        IdHTTP1: TIdHTTP;
        IBCQueryPriceCategories: TIBCQuery;
        IBCDataSourcePriceCategories: TIBCDataSource;
        IBCTrLocal: TIBCTransaction;
        IBCQueryCurrencyUSD: TIBCQuery;
        cxPageControl1: TcxPageControl;
        tsPriceList: TcxTabSheet;
        lcbPriceCategory: TcxLookupComboBox;
        cxLabel3: TcxLabel;
        Button1: TButton;
        cbRRP: TcxCheckBox;
        lbMaxTr: TcxLabel;
        btnGetPriceList: TButton;
        cxTabSheet2: TcxTabSheet;
        Panel1: TPanel;
        btnStart: TcxButton;
        ckbNoImage: TcxCheckBox;
        ckbInPrice: TcxCheckBox;
        btnStop: TcxButton;
        cxLabel1: TcxLabel;
        lbTime: TcxLabel;
        cxProgressBar1: TcxProgressBar;
        IBCQueryGoods: TIBCQuery;
        IBCDataSourceGoods: TIBCDataSource;
        cxGrid2DBTableView1: TcxGridDBTableView;
        cxGrid2Level1: TcxGridLevel;
        cxGrid2: TcxGrid;
        cxGrid2DBTableView1Column1: TcxGridDBColumn;
        cxGrid2DBTableView1Column2: TcxGridDBColumn;
        cxGrid2DBTableView1Column3: TcxGridDBColumn;
        cxGrid2DBTableView1Column4: TcxGridDBColumn;
        Button3: TButton;
        btnGeneratePrice: TButton;
        btnLoadImages: TButton;
        cxPageControl2: TcxPageControl;
        tbsPricelist: TcxTabSheet;
        cxGrid1: TcxGrid;
        cxGrid1TableView1: TcxGridTableView;
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
        tsImages: TcxTabSheet;
        IBCQueryImages: TIBCQuery;
        cxGrid3DBTableView1: TcxGridDBTableView;
        cxGrid3Level1: TcxGridLevel;
        cxGrid3: TcxGrid;
        IBCDataSourceImages: TIBCDataSource;
        cxGrid3DBTableView1GOODSID: TcxGridDBColumn;
        cxGrid3DBTableView1GOODS_CODE: TcxGridDBColumn;
        cxGrid3DBTableView1IMAGESLIST: TcxGridDBColumn;
        cxImage1: TcxImage;
        Memo1: TMemo;
        btnLoadCaracteristics: TButton;
        IBCQueryProperties: TIBCQuery;
        IBCDataSourceProperties: TIBCDataSource;
        tbsProperties: TcxTabSheet;
        cxGrid4: TcxGrid;
        cxGridDBTableView1: TcxGridDBTableView;
        cxGridDBColumn1: TcxGridDBColumn;
        cxGridDBColumn2: TcxGridDBColumn;
        cxGridDBColumn3: TcxGridDBColumn;
        cxGridLevel1: TcxGridLevel;
        cxProgressBar2: TcxProgressBar;
        cxGrid1TableView1_PROMODESCRIPTION: TcxGridColumn;
        cxGrid1TableView1_PROMOSTART: TcxGridColumn;
        cxGrid1TableView1_PROMOFINISH: TcxGridColumn;
        cxTabSheet1: TcxTabSheet;
        cxGrid5DBTableView1: TcxGridDBTableView;
        cxGrid5Level1: TcxGridLevel;
        cxGrid5: TcxGrid;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager1: TdxBarManager;
        dxBarManager1Bar1: TdxBar;
        bbGenerateWebPromotion: TdxBarButton;
        bbSaveData: TdxBarButton;
        bbLoadData: TdxBarButton;
        cxGrid1TableView1_WARRANTY: TcxGridColumn;
        procedure btnLoadCaracteristicsClick(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure btnGetPriceListClick(Sender: TObject);
        procedure btnStartClick(Sender: TObject);
        procedure Button3Click(Sender: TObject);
        procedure btnGeneratePriceClick(Sender: TObject);
        procedure btnLoadImagesClick(Sender: TObject);
        procedure cxGrid1TableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure DoSyncSaveRecord(AIndex: integer);
        procedure bbGenerateWebPromotionClick(Sender: TObject);
        procedure bbLoadDataClick(Sender: TObject);
        procedure bbSaveDataClick(Sender: TObject);
    private
        FBaseUrl: string;
        FUserLogin: string;
        FUserPassword: string;
{ Private declarations }
//    fLastGoodsFolderID: Integer;
        myApiAccent: TApiAccent;
        GUID: string;
        JSONBody: string;
        ProductPropertiesList: TList<TProductPropertyRecord>;

        procedure ClearProcutPropertiesList;

        procedure ConnectToAccent;
        procedure GetAccentImages;
        procedure GetCatalogItems;
        procedure ParseCatalog;
        procedure ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
        procedure ShowPropertiesTab;
        procedure GetApiAccentProperties(InternalID: integer);
        function GetGoodsID(CustomerID: Integer; GoodsCode: string): Integer;
        procedure ParseAccentProperties;
        procedure LoadGridDataFromFile(const FileName: string);
        procedure SaveGridDataToFile(const FileName: string);
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

        procedure AddSelecteditemstoWEbPromotion;
        procedure SetupDefaultFocus; override;
        procedure SaveDescriptionToDB(Connection: TIBCConnection);
// TODO: EnsureTodayGuid
////        procedure ConnectToAccent(out AGuid: string); // implementare concretă
////        function FetchGuidFromApi(out AGuid: string): Boolean;
//      function EnsureTodayGuid: string;
    end;

implementation

{$R *.dfm}

uses
    SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
    DataModuleAdditions, SWNValueStorageUnit, IdFTP, Vcl.Imaging.pngimage,
    WebpHelpers, Winapi.GDIPOBJ, Vcl.Imaging.jpeg, System.IOUtils, libwebp,
    Vcl.Imaging.GIFImg, Vcl.WebpImage, Vcl.Clipbrd, uSelectPromotionDialog,
    AccentGuidRepo;

procedure Tframe91APIAccent.AddSelecteditemstoWEbPromotion;
var
    Curerency7ID: Integer;
    Price0: string;
    Currency0ID: Integer;
    Currency3ID: Integer;
    GoodsCode: string;
    Price3: string;
    Price7: string;
    RateUSD: double;
    ARecordIndex: integer;
begin

    var d := TfrmSelectPromotionDlg.Create(self, dmdb.IBCConnection, dmdb.IBCTrDefaultSelect, IBCTrLocal);
    try
        if (d.ShowModal = mrOK) then
        begin
            var PromoActionID := d.PromoActionID;
            RateUSD := dmdb.GetCurrencyRate(840);

            var IBCSQL := TIBCSQL.Create(nil);
            IBCSQL.Transaction := ibctrLocal;
            IBCSQL.SQL.Clear;
            IBCSQL.sql.add('INSERT INTO VW_TWEB_PA_GOODS');
            IBCSQL.sql.add('(PROMOACTIONID, GOODSID, PRICE4, OLD_PRICE4, CURRENCYID,  DISCOUNT_VALUE,');
            IBCSQL.sql.add('FLG_FREEZE_PRICES,  FLG_DISCOUNT_TYPE, flg_show_discount_as_amount, orderno,');
            IBCSQL.sql.add('discount_typeid, discount_value_mdl, discount_percent, cashback_percent, supplierid, supplier_name,');
            IBCSQL.sql.add('label_ro, label_ru, goods_code)');
            IBCSQL.sql.add('VALUES');
            IBCSQL.sql.add('(:PROMOACTIONID, :GOODSID, :PRICE4, :OLD_PRICE4, :CURRENCYID,  :DISCOUNT_VALUE,');
            IBCSQL.sql.add(':FLG_FREEZE_PRICES, :FLG_DISCOUNT_TYPE, :flg_show_discount_as_amount, :orderno,');
            IBCSQL.sql.add(':discount_typeid, :discount_value_mdl, :discount_percent, :cashback_percent, :supplierid, :supplier_name,');
            IBCSQL.sql.add(':label_ro, :label_ru, :goods_code)');

            IBCSQL.Prepare;

            for var I := 0 to cxGrid1TableView1.Controller.SelectedRowCount - 1 do
            begin
                ARecordIndex := cxGrid1TableView1.Controller.SelectedRecords[I].RecordIndex;
                with cxGrid1TableView1.DataController do
                begin
                    GoodsCode := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_GOODS_CODE.Index];
                    Price0 := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_COST.Index];
                    Currency0ID := 840;
                    Price7 := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_PRICE7.Index];
                    Curerency7ID := 840;
                    if cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_promoprice.Index] > 0 then
                    begin
                      Price3 := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_promoprice.Index] / RateUSD;
                    end
                    else
                      Price3 := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_PRICE3.Index] / RateUSD;

                    Currency3ID := 840;

                    IBCSQL.ParamByName('promoactionid').AsInteger := PromoActionID;
                    IBCSQL.ParamByName('GOODSID').AsInteger := GetGoodsID(198, GoodsCode);
                    IBCSQL.ParamByName('PRICE4').AsString := FloatToStr(StrToFloat(Price3));
                    IBCSQL.ParamByName('OLD_PRICE4').AsString := cxGrid1TableView1.DataController.Values[ARecordIndex, cxGrid1TableView1_PRICE3.Index] / RateUSD;

                    IBCSQL.ParamByName('CURRENCYID').AsInteger := 840;
                    IBCSQL.ParamByName('DISCOUNT_VALUE').Value := 0;
                    IBCSQL.ParamByName('FLG_FREEZE_PRICES').AsInteger := 0;
                    IBCSQL.ParamByName('FLG_DISCOUNT_TYPE').AsInteger := 1;
                    IBCSQL.ParamByName('flg_show_discount_as_amount').AsInteger := 1;
                    IBCSQL.ParamByName('orderno').AsInteger := 0;
                    IBCSQL.ParamByName('discount_typeid').value := 0;
                    IBCSQL.ParamByName('discount_value_mdl').Value := 0;
                    IBCSQL.ParamByName('discount_percent').Value := 0;
                    IBCSQL.ParamByName('cashback_percent').Value := 0;
                    IBCSQL.ParamByName('supplierid').AsInteger := 198; // accent
                    IBCSQL.ParamByName('supplier_name').AsString := 'ACCENT ELECTRONIC SA';
                    IBCSQL.ParamByName('label_ro').AsString := '';
                    IBCSQL.ParamByName('label_ru').AsString := '';
                    IBCSQL.ParamByName('goods_code').AsString := GoodsCode;

                    IBCSQL.Execute;
                end;

            end;
        end;
    finally

    end;

end;

procedure Tframe91APIAccent.btnLoadCaracteristicsClick(Sender: TObject);
begin
//    ConnectToAccent(GUID);
    ShowPropertiesTab;
    SaveDescriptionToDB(dmdb.IBCConnection);
end;

procedure Tframe91APIAccent.btnStartClick(Sender: TObject);
begin
    PrepareData;
end;

procedure Tframe91APIAccent.Button1Click(Sender: TObject);
begin
    GeneratePriceList(lcbPriceCategory.EditValue);
end;

procedure Tframe91APIAccent.btnGetPriceListClick(Sender: TObject);
var
    Api: IAccentAuthService;
    Repo: TAccentGuidRepo;
begin
    cxPageControl2.ActivePage := tbsPricelist;
    Application.ProcessMessages;
    screen.Cursor := crHourGlass;
    try

//  // serviciu API (reutilizabil, fără UI)
//       Api := TAccentAuthService.Create('http://b2brestful.accent.md:8090', 'Fantastic.APIUser', 'D1519F75556D1D689C3C24C721CCFF9C');
//
//  // repo DB – injectezi conexiunea/transacția ta existente
//        Repo := TAccentGuidRepo.Create(dmdb.IBCConnection, dmdb.IBCTrDefaultSelect);
//        try
//            Guid := Repo.EnsureTodayGuid(Api);
//
//        finally
//            Repo.Free;
//        end;

        ConnectToAccent;

        GetCatalogItems;
        ParseCatalog;
    finally
        screen.Cursor := crDefault;
    end;

//    screen.Cursor := crHourGlass;
//    try
//        if assigned(myApiAccent) then
//        begin
//            myApiAccent.Connect;
//            myApiAccent.GetJSONProducts;
//            myApiAccent.ParseJSON;
//
//            myApiAccent.OnSyncSaveRecord := DoSyncSaveRecord;
//            TThread.CreateAnonymousThread(
//                procedure
//                begin
//                    myApiAccent.SavePriceToDB(dmdb.IBCConnection, cxProgressBar2);
//                end).Start;
//        end;
//    finally
//        screen.Cursor := crDefault;
//    end;

    IBCQueryPriceCategories.Close;
    IBCQueryPriceCategories.ParamByName('customerid').AsInteger := 198;
    IBCQueryPriceCategories.Open;

    if IBCQueryPriceCategories.RecordCount > 0 then
        lcbPriceCategory.EditValue := IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger;

end;

procedure Tframe91APIAccent.Button3Click(Sender: TObject);
begin
    screen.Cursor := crHourGlass;
    try
        if assigned(myApiAccent) then
        begin
            myApiAccent.Connect;
            myApiAccent.GetJSONProducts;
            myApiAccent.ParseJSON;

            myApiAccent.OnSyncSaveRecord := DoSyncSaveRecord;
            TThread.CreateAnonymousThread(
                procedure
                begin
                    myApiAccent.SavePriceToDB(dmdb.IBCConnection, cxProgressBar2);
                end).Start;
        end;
    finally
        screen.Cursor := crDefault;
    end;
end;

procedure Tframe91APIAccent.bbGenerateWebPromotionClick(Sender: TObject);
begin
    inherited;
    AddSelecteditemstoWEbPromotion;
end;

procedure Tframe91APIAccent.bbLoadDataClick(Sender: TObject);
begin
    LoadGridDataFromFile('Accent.dat');
end;

procedure Tframe91APIAccent.bbSaveDataClick(Sender: TObject);
begin
    inherited;
    SaveGridDataToFile('accent.dat');
end;

procedure Tframe91APIAccent.LoadGridDataFromFile(const FileName: string);
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

procedure Tframe91APIAccent.SaveGridDataToFile(const FileName: string);
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

procedure Tframe91APIAccent.btnGeneratePriceClick(Sender: TObject);
begin
    if assigned(myApiAccent) then
    begin
        myApiAccent.GeneratePriceList(IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger);
    end;
end;

procedure Tframe91APIAccent.btnLoadImagesClick(Sender: TObject);
begin
    inherited;
    cxPageControl2.ActivePage := tsImages;
    GetAccentImages;
end;

procedure Tframe91APIAccent.ClearProcutPropertiesList;
begin
    if Assigned(ProductPropertiesList) then
        for var j := 0 to ProductPropertiesList.Count - 1 do
            ProductPropertiesList.Delete(j);
end;

// TODO: ConnectToAccent
procedure Tframe91APIAccent.ConnectToAccent;
var
  s: string;
  Resp_Json: string;
  Req_Json: TStream;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  st: string;
  tokenID: string;
begin
  if (GUID = '') then
  begin
      s := '{';
      s := s + '"userlogin": "Fantastic.APIUser",';
      s := s + '"userpassword": "D1519F75556D1D689C3C24C721CCFF9C"';
      s := s + '}';
      Req_Json := TStringStream.Create(s);
      Req_Json.Position := 0;
      try
          IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
          IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
          IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
          IdHTTP1.Request.CharSet := 'utf-8';
          Resp_Json := IdHTTP1.Post('http://b2brestful.accent.md:8090/loginuser/getid', Req_Json);
      finally
          Req_Json.Free;
      end;

      st := Resp_Json;
      JSonObject := TJSONObject.Create;
      try
          JSonValue := JSonObject.ParseJSONValue(st);
          guid := (JSonValue as TJSONObject).Get('guid').JSonValue.Value;
          dmdb.SaveCurrentUID(guid);
      finally
          JSonObject.Free;
      end;
  end
end;

procedure Tframe91APIAccent.GetCatalogItems;
var
    s: string;
    Req_Json: TStream;
begin
    Req_Json := TStringStream.Create(s);
    Req_Json.Position := 0;
    try
        IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
        IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
        IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
        IdHTTP1.Request.CharSet := 'utf-8';

        JSONBody := IdHTTP1.Post('http://b2brestful.accent.md:8090/hard/' + guid + '/catalogandstock/0', Req_Json);
    finally
        Req_Json.Free;
    end;
end;

procedure Tframe91APIAccent.ParseCatalog;
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
    warranty: string;
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
                if s = 'isfolder' then
                    IsFolder := '1';
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
                    imagesList := aPair.JsonValue.Value
                else if s = 'warrantyname' then
                begin
                    warranty := aPair.JsonValue.Value;
                    warranty := ExtractNumbers(warranty);
                end;

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
                    cxGrid1TableView1.DataController.Values[N, cxGrid1TableView1_WARRANTY.Index] := warranty
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

    lbMaxTr.Caption := Format('Max transaction: %d', [MaxTransaction]);
    cxGrid1TableView1.EndUpdate;
end;

procedure Tframe91APIAccent.DeleteRecord;
begin
end;

procedure Tframe91APIAccent.DoFrameHide;
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

    if Assigned(myApiAccent) then
        FreeAndNil(myApiAccent);

    if Assigned(ProductPropertiesList) then
        ProductPropertiesList.Free;

    inherited;
end;

procedure Tframe91APIAccent.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQueryPriceCategories.Open;
    IBCQueryCurrencyUSD.Open;
//  IBCQueryGoods.Open;

    myApiAccent := TApiAccent.Create(dmdb.IBCConnection, dmdb.GetCurrencyExchangeValue(840, True), false);

    ProductPropertiesList := TList<TProductPropertyRecord>.Create;
end;

procedure Tframe91APIAccent.DoSyncSaveRecord(AIndex: integer);
begin
    cxProgressBar2.Position := AIndex;
//  Application.ProcessMessages;
end;

function Tframe91APIAccent.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [];
end;

function Tframe91APIAccent.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe91APIAccent.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
//   if fSECURITY_CanNew then
//      Result := Result + [fbtADD];
//   if fSECURITY_CanEdit or fSECURITY_CanView then
//      Result := Result + [fbtMODIFY];
//   if fSECURITY_CanDelete then
//      Result := Result + [fbtDELETE];
end;

function Tframe91APIAccent.InitFrameID: Integer;
begin
    // Api Accent
    Result := 91
end;

procedure Tframe91APIAccent.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe91APIAccent.RefreshData;
begin
    inherited;
//     IBCQueryGoods.Refresh;
end;

procedure Tframe91APIAccent.SaveDescriptionToDB(Connection: TIBCConnection);
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

procedure Tframe91APIAccent.SaveFrameStates;
begin
    try
        AppUserConfigStorage.OpenSection(Self.Name);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe91APIAccent.SetupDefaultFocus;
begin

end;

procedure Tframe91APIAccent.SetupSecurityItems;
begin
//   fSECURITY_CanView := True;
//   fSECURITY_CanNew := True;
//   fSECURITY_CanEdit := True;
//   fSECURITY_CanDelete := True;
end;

procedure Tframe91APIAccent.GeneratePriceList(PriceCategoryID: Integer);
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

        q.ParamByName('SUPPLIERID').AsInteger := 198;
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
        q.SQL.Add('SUPPLIER_GOODS_BRAND,');

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
        q.SQL.Add('CURRENCY0ID, ');
        q.SQL.Add('SUPPLIER_CATEGORY, ');
        q.SQL.Add('WARANTY)');
    {$endregion}

        q.SQL.Add('values (:PLID,');
        q.SQL.Add(':SUPPLIER_GOODS_CODE,');
        q.SQL.Add(':SUPPLIER_GOODS_NAME,');
        q.SQL.Add(':SUPPLIER_GOODS_BRAND, ');

//    if cbRRP.Checked then
//    begin
        q.SQL.Add(':PRICE3,');
        q.SQL.Add(':CURRENCY3ID,');
//    end;
        q.SQL.Add(':PRICE7,');
        q.SQL.Add(':CURRENCY7ID,');
        q.SQL.Add(':PRICE0,');
        q.SQL.Add(':FLG_PREORDER,');
        q.SQL.Add(':CURRENCY0ID, ');
        q.SQL.Add(':SUPPLIER_CATEGORY, ');
        q.SQL.Add(':WARANTY)');

        for i := 0 to cxGrid1TableView1.DataController.RecordCount - 1 do
        begin
            with cxGrid1TableView1.DataController do
            begin
                OQty := Values[FilteredRecordIndex[i], cxGrid1TableView1_OQTY.Index];
                Qty := Values[FilteredRecordIndex[i], cxGrid1TableView1_QTY.Index];
                GoodsCode := cxGrid1TableView1.DataController.Values[cxGrid1TableView1.DataController.FilteredRecordIndex[i], cxGrid1TableView1_GOODS_CODE.Index];

                if (OQty = -1) and (Qty = 0) then
                    q.ParamByName('FLG_PREORDER').AsInteger := 1
                else
                    q.ParamByName('FLG_PREORDER').AsInteger := 0;

                if (Qty > 0) or ((Qty = 0) and (OQty > 0)) then
                begin
                    q.ParamByName('PLID').AsInteger := PLID;
                    q.ParamByName('SUPPLIER_GOODS_CODE').Value := GoodsCode;
                    q.ParamByName('SUPPLIER_GOODS_NAME').Value := Values[FilteredRecordIndex[i], cxGrid1TableView1_GOODSNAME.Index];
                    q.parambyname('SUPPLIER_GOODS_BRAND').Value := Values[FilteredRecordIndex[i], cxGrid1TableView1_VENDORNAME.Index];
                    q.ParamByName('PRICE3').AsFloat := iif(Values[FilteredRecordIndex[i], cxGrid1TableView1_PROMOPRICE.Index] = 'null', Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE3.Index], Values[FilteredRecordIndex[i], cxGrid1TableView1_PROMOPRICE.Index]);

                    if q.ParamByName('PRICE3').AsFloat > 0 then
                        q.ParamByName('CURRENCY3ID').AsInteger := 498
                    else
                        q.ParamByName('CURRENCY3ID').AsInteger := -1;

                    q.ParamByName('PRICE7').AsFloat := iif(Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE7.Index] = 0, 0, Double(Values[FilteredRecordIndex[i], cxGrid1TableView1_PRICE7.Index]));
                    q.ParamByName('CURRENCY7ID').AsInteger := 840;

                    q.ParamByName('PRICE0').AsFloat := iif(Values[FilteredRecordIndex[i], cxGrid1TableView1_COST.Index] = 0, 0, Double(Values[FilteredRecordIndex[i], cxGrid1TableView1_COST.Index]));
                    q.ParamByName('CURRENCY0ID').AsInteger := 840;
                    q.ParamByName('SUPPLIER_CATEGORY').AsString := Values[FilteredRecordIndex[i], cxGrid1TableView1_ROOTNAME.Index];

                    q.ParamByName('WARANTY').Value := iif(VarToStr(Values[FilteredRecordIndex[i], cxGrid1TableView1_WARRANTY.Index]) = '', 0, Values[FilteredRecordIndex[i], cxGrid1TableView1_WARRANTY.Index]);
                    q.ExecSQL;
                end;
            end;
        end;
        IBCTrLocal.Commit;
    finally
        q.Free;
    end;
end;

procedure Tframe91APIAccent.GetAccentImages;
var
    ImageFileNameList: TSTringlist;
    GoodsID: Integer;
    idFTP: TIdFTP;
    ms: TMemoryStream;
    ibcsql: TIBCSQL;
    trUpdate: TIBCTransaction;
begin
    ImageFileNameList := TSTringList.Create;
    ibcsql := Tibcsql.Create(nil);
    trUpdate := TIBCTransaction.Create(nil);
    idFTP := TidFTP.Create(nil);

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    ibcsql.transaction := trUpdate;
    IBCQueryImages.Close;
    IBCQueryImages.Open;
    memo1.Lines.Clear;
//  ibcqueryImages.First;
    try
//    idFTP.Disconnect;
        idFTP.Host := '195.22.237.108';
        idFTP.Username := 'anonymous';
    // IdFTP1.Password := 'a@fantastic.md';
        idFTP.Passive := True;
        idFTP.Connect;
        trUpdate.StartTransaction;

        ibcsql.sql.add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
        ibcsql.sql.add('values (:goodsid, :image, :flg_need2recreate)');
        ibcsql.Prepare;

        while not ibcqueryimages.eof do
        begin
            ImageFileNameList.CommaText := ibcqueryimages.FieldByName('imageslist').AsString;
            GoodsID := ibcqueryimages.FieldByName('goodsid').AsInteger;
            ibcsql.AutoCommit := false;
            for var j := 0 to ImageFileNameList.Count - 1 do
            begin
                ms := TMemoryStream.Create;
                try
                    try
                        idFTP.Get('/aeimages/' + ImageFileNameList[j], ms);
                        ms.Position := 0;
                        cxImage1.Picture.LoadFromStream(ms);
                        cxImage1.Picture.SaveToFile('tmp.jpg');
                        ConvertImageToPngEx('tmp.jpg', 'tmp.png');

                        ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
//            TBlobField(ibcsql.ParamByName('image')).LoadFromFile('tmp.png');
                        ibcsql.ParamByName('image').LoadFromFile('tmp.png', ftBlob);
                        ibcsql.ParamByName('flg_need2recreate').Asinteger := 1;
                        ibcsql.Execute;
                    except
                        memo1.lines.add('GoodsID: ' + GoodsID.ToString + '  Path: /aeimages/' + ImageFileNameList[j]);
                        Continue;
                    end;

                    Application.ProcessMessages;
                finally
                    ms.Free;
                end;
            end;
            ibcqueryimages.Next;
        end;
        trUpdate.Commit;
    finally
        ibcsql.Free;
        trUpdate.Free;
        ImageFileNameList.Free;
        idFTP.Free;
    end;
end;

procedure Tframe91APIAccent.ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
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

procedure Tframe91APIAccent.cxGrid1TableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    inherited;
    if ARecord.Values[cxGrid1TableView1_COST.Index] >= ARecord.Values[cxGrid1TableView1_PRICE7.Index] then
    begin
        AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure Tframe91APIAccent.ShowPropertiesTab;
begin
    cxPageControl2.ActivePage := tbsProperties;
  // clear
    ClearProcutPropertiesList;

    if IBCQueryProperties.Active then
        IBCQueryProperties.Refresh
    else
        IBCQueryProperties.Open;

    while not IBCQueryProperties.Eof do
    begin
        GetApiAccentProperties(IBCQueryProperties.FieldByName('internalid').AsInteger);
        ParseAccentProperties;
        IBCQueryProperties.Next;
    end;
end;

procedure Tframe91APIAccent.GetApiAccentProperties(InternalID: integer);
var
    s: string;
    Req_Json: TStream;
begin
    Req_Json := TStringStream.Create(s);
    Req_Json.Position := 0;
    try
        IdHTTP1.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
        IdHTTP1.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
        IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
        IdHTTP1.Request.CharSet := 'utf-8';

        JSONBody := IdHTTP1.Post('http://b2brestful.accent.md:8090/hardproperty/' + guid + '/productid/' + InternalID.ToString, Req_Json);
    finally
        Req_Json.Free;
    end;
end;

function Tframe91APIAccent.GetGoodsID(CustomerID: Integer; GoodsCode: string): Integer;
begin
    Result := -1;

    var q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select goodsid from ts_goods_foreign where customerid = :customerid and goods_code = :goods_code';
        q.parambyname('customerid').AsInteger := CustomerID;
        q.parambyname('goods_code').Asstring := GoodsCode;
        q.Open;
        result := q.fieldbyname('goodsid').AsInteger;
    finally
        q.Free;
    end;
end;

procedure Tframe91APIAccent.ParseAccentProperties;
var
    JSONArray: TJSONArray;
    LJsonValue: TJSONValue;
    AProduct: TJSONObject;
    aPair: TJSONPair;
    PropertyName: string;
    PropertyValue: string;
    s: string;
    ProductProperty: TProductPropertyRecord;
begin
    JSONArray := TJSONArray.Create;
    JSONArray := TJSONArray(TJSONObject.ParseJSONValue(JSONBody));

    for LJsonValue in JSONArray do
    begin
        Application.ProcessMessages;
        AProduct := TJSONObject(LJsonValue);
        for var j := 0 to AProduct.Count - 1 do
        begin
            aPair := AProduct.Pairs[j];
            PropertyName := aPair.JsonString.Value;

            if PropertyName.ToLower = 'id'.ToLower then
                ProductProperty.Id := aPair.JsonValue.Value.ToInteger;
            if PropertyName.ToLower = 'hardcode'.ToLower then
                ProductProperty.Hardcode := aPair.JsonValue.Value.ToInteger;
            if PropertyName.ToLower = 'propertyNameRus'.ToLower then
                ProductProperty.PropertyNameRus := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'propertyNameRom'.ToLower then
                ProductProperty.PropertyNameRom := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'propertyValue'.ToLower then
                ProductProperty.PropertyValue := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'propertyParentCode'.ToLower then
                ProductProperty.PropertyParentCode := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'WebVisible'.ToLower then
                ProductProperty.WebVisible := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'Description'.ToLower then
                ProductProperty.Description := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'DescriptionRom'.ToLower then
                ProductProperty.DescriptionRom := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'TagName'.ToLower then
                ProductProperty.TagName := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'TagNameRus'.ToLower then
                ProductProperty.TagNameRus := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'TagNameRom'.ToLower then
                ProductProperty.TagNameRom := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'sortOrder'.ToLower then
                ProductProperty.SortOrder := aPair.JsonValue.Value;
            if PropertyName.ToLower = 'transactionid'.ToLower then
                ProductProperty.TransactdionID := StrToIntDef(aPair.JsonValue.Value, -1);
        end;

        ProductPropertiesList.Add(ProductProperty);

    end;
end;

procedure Tframe91APIAccent.PrepareData;
begin
    ibcqueryGoods.Close;

    if ckbNoImage.Checked then
        ibcquerygoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
    else
        IBCQueryGoods.MacroByName('FlgNoImage').Value := '';

    if ckbInPrice.Checked then
        ibcquerygoods.MacroByName('FlgInPrice').Value := ' and get_flg_in_price(goodsid)=1'
    else
        IBCQueryGoods.MacroByName('FlgInPrice').Value := '';

    ibcqueryGoods.Open;

end;

// TODO: EnsureTodayGuid
//// TODO: FetchGuidFromApi
////function Tframe91APIAccent.FetchGuidFromApi(out AGuid: string): Boolean;
////var
////  Req, Resp: string;
////  SS: TStringStream;
////  JV: TJSONValue;
////begin
////  Result := False;
////  AGuid := '';
////
////  Req := '{' + '"userlogin":"Fantastic.APIUser",' + '"userpassword":"D1519F75556D1D689C3C24C721CCFF9C"' + '}';
////
////  SS := TStringStream.Create(Req, TEncoding.UTF8);
////  try
////      IdHTTP1.Request.ContentType := 'application/json; charset=UTF-8';
////      IdHTTP1.Request.Accept := 'application/json';
////
////      Resp := IdHTTP1.Post('http://b2brestful.accent.md:8090/loginuser/getid', SS);
////  finally
////      SS.Free;
////  end;
////
////  JV := TJSONObject.ParseJSONValue(Resp);
////  try
////      if (JV is TJSONObject) and (TJSONObject(JV).TryGetValue<string>('guid', AGuid)) then
////          Result := (AGuid <> '');
////  finally
////      JV.Free;
////  end;
////end;
//
////procedure Tframe91APIAccent.ConnectToAccent(out AGuid: string);
////begin
////    if not FetchGuidFromApi(AGuid) then
////        raise Exception.Create('Autentificare Accent eșuată.');
////end;
//
//function Tframe91APIAccent.EnsureTodayGuid: string;
//var
//  Svc: IAccentAuthService;
//begin
//// fallback default-uri (le poți scoate, dacă le setezi din exterior)
//  if FBaseUrl = '' then
//      FBaseUrl := 'http://b2brestful.accent.md:8090';
//  if FUserLogin = '' then
//      FUserLogin := 'Fantastic.APIUser';
//  if FUserPassword = '' then
//      FUserPassword := 'D1519F75556D1D689C3C24C721CCFF9C';
//
//// serviciu local (fără UI) – poate fi folosit și în alte module
//  Svc := TAccentAuthService.Create(FBaseUrl, FUserLogin, FUserPassword);
//
//// Lasă data-module-ul să decidă: ia din tabel sau ia din API și apoi salvează
//  Result := dmdb.EnsureTodayGuid(Svc);
//end;

end.


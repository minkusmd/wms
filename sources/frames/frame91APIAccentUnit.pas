unit frame91APIAccentUnit;
{
  INVENTARIERE. Inventariere
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

    // Baza pentru firele de lucru Accent: conexiune proprie la baza (TIBCConnection nu e
    // thread-safe, dmDB.IBCConnection nu se foloseste din fir), progres si jurnal prin Queue.
    // Firele descendente fac commit la fiecare cCommitBatch produse.
    TAccentDBThread = class(TThread)
    private
        FOnLog: TProc<string>;
        FOnProgress: TProc<Integer, Integer>;
        FErrors: TStringList;
    protected
        FConnection: TIBCConnection;
        FSelectSQL: string;
        FProcessedCount: Integer;
        FErrorMessage: string;
        procedure Log(AMessage: string);
        procedure AddError(AMessage: string);
        procedure Progress(APosition, AMax: Integer);
    public
        constructor Create(ASourceConnection: TIBCConnection; const ASelectSQL: string);
        destructor Destroy; override;
        property OnLog: TProc<string> write FOnLog;
        property OnProgress: TProc<Integer, Integer> write FOnProgress;
        property ProcessedCount: Integer read FProcessedCount;
        property ErrorMessage: string read FErrorMessage;
        // erorile pe produs / imagine; se citesc dupa terminarea firului
        property Errors: TStringList read FErrors;
    end;

    // Imaginile Accent de pe FTP -> ts_goods_image
    TAccentImagesThread = class(TAccentDBThread)
    private
        FSavedImagesCount: Integer;
        procedure ConvertToPng(ASource, ADest: TStream);
    protected
        procedure Execute; override;
    public
        property SavedImagesCount: Integer read FSavedImagesCount;
    end;

    // Caracteristicile Accent (API hardproperty) -> tapi_accent_products_properties
    TAccentPropertiesThread = class(TAccentDBThread)
    private
        FGuid: string;
        FSavedPropertiesCount: Integer;
        procedure ParseProperties(const AJSON: string; AList: TList<TProductPropertyRecord>);
    protected
        procedure Execute; override;
    public
        constructor Create(ASourceConnection: TIBCConnection; const ASelectSQL, AGuid: string);
        property SavedPropertiesCount: Integer read FSavedPropertiesCount;
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
        FImagesThread: TAccentImagesThread;
        FLoadImagesCaption: string;
        FPropertiesThread: TAccentPropertiesThread;
        FLoadCaracteristicsCaption: string;
        procedure ImagesThreadTerminate(Sender: TObject);
        procedure PropertiesThreadTerminate(Sender: TObject);
        procedure ShowWorkerProgress(APosition, AMax: Integer);
        procedure StopWorkerThreads;

        procedure ConnectToAccent;
        procedure GetAccentImages;
        procedure GetCatalogItems;
        procedure ParseCatalog;
        function GetGoodsID(CustomerID: Integer; GoodsCode: string): Integer;
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
        procedure SaveDescriptionToDB;
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

const
    cCommitBatch = 10;
    cMaxErrorsShown = 20;
    cAccentFtpHost = '195.22.237.108';
    cAccentFtpImagesPath = '/aeimages/';
    cAccentApiUrl = 'http://b2brestful.accent.md:8090';

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
    cxPageControl2.ActivePage := tbsProperties;
    SaveDescriptionToDB;
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
    StopWorkerThreads;

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

    inherited;
end;

procedure Tframe91APIAccent.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQueryPriceCategories.Open;
    IBCQueryCurrencyUSD.Open;
//  IBCQueryGoods.Open;

    myApiAccent := TApiAccent.Create(dmdb.IBCConnection, dmdb.GetCurrencyExchangeValue(840, True), false);
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

procedure Tframe91APIAccent.SaveDescriptionToDB;
begin
    // a doua apasare in timpul descarcarii = oprire; produsele procesate deja raman salvate
    if Assigned(FPropertiesThread) then
    begin
        FPropertiesThread.Terminate;
        btnLoadCaracteristics.Enabled := False;
        Exit;
    end;

    // ambele fire folosesc cxProgressBar2 - nu le pornim in paralel
    if Assigned(FImagesThread) then
    begin
        ShowMessage('Se descarca imaginile. Asteptati finalizarea sau opriti descarcarea.');
        Exit;
    end;

    ConnectToAccent;

    IBCQueryProperties.Close;
    IBCQueryProperties.Open;
    cxProgressBar2.Position := 0;

    FPropertiesThread := TAccentPropertiesThread.Create(dmdb.IBCConnection, IBCQueryProperties.SQL.Text, GUID);
    FPropertiesThread.OnProgress := ShowWorkerProgress;
    FPropertiesThread.OnTerminate := PropertiesThreadTerminate;

    FLoadCaracteristicsCaption := btnLoadCaracteristics.Caption;
    btnLoadCaracteristics.Caption := 'Stop';
    FPropertiesThread.Start;
end;

procedure Tframe91APIAccent.PropertiesThreadTerminate(Sender: TObject);
var
    Thread: TAccentPropertiesThread;
    Msg: string;
begin
    Thread := Sender as TAccentPropertiesThread;
    FPropertiesThread := nil;

    btnLoadCaracteristics.Caption := FLoadCaracteristicsCaption;
    btnLoadCaracteristics.Enabled := True;

    Msg := Format('Caracteristici: produse procesate %d, caracteristici salvate %d, erori %d',
        [Thread.ProcessedCount, Thread.SavedPropertiesCount, Thread.Errors.Count]);
    if Thread.ErrorMessage <> '' then
        Msg := Msg + sLineBreak + 'Eroare: ' + Thread.ErrorMessage;
    if Thread.FatalException is Exception then
        Msg := Msg + sLineBreak + 'Eroare: ' + Exception(Thread.FatalException).Message;
    for var I := 0 to Thread.Errors.Count - 1 do
    begin
        if I = cMaxErrorsShown then
        begin
            Msg := Msg + sLineBreak + '...';
            Break;
        end;
        Msg := Msg + sLineBreak + Thread.Errors[I];
    end;

    // firul nu poate fi eliberat din propriul OnTerminate (WaitFor s-ar bloca);
    // mesajul se afiseaza tot dupa, ca firul sa nu ramana blocat in Synchronize
    TThread.ForceQueue(nil,
        procedure
        begin
            Thread.Free;
            ShowMessage(Msg);
        end);
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

{ TAccentDBThread }

constructor TAccentDBThread.Create(ASourceConnection: TIBCConnection; const ASelectSQL: string);
begin
    inherited Create(True);
    FreeOnTerminate := False;
    FSelectSQL := ASelectSQL;
    FErrors := TStringList.Create;

    // copie a parametrilor conexiunii principale, fara evenimentele ei (ating dmDB / UI)
    FConnection := TIBCConnection.Create(nil);
    FConnection.Assign(ASourceConnection);
    FConnection.LoginPrompt := False;
    FConnection.ConnectDialog := nil;
    FConnection.OnError := nil;
    FConnection.OnLogin := nil;
    FConnection.BeforeConnect := nil;
    FConnection.AfterConnect := nil;
    FConnection.BeforeDisconnect := nil;
    FConnection.AfterDisconnect := nil;
end;

destructor TAccentDBThread.Destroy;
begin
    inherited;    // asteapta terminarea firului
    FConnection.Free;
    FErrors.Free;
end;

procedure TAccentDBThread.Log(AMessage: string);
begin
    if Assigned(FOnLog) then
        Queue(
            procedure
            begin
                FOnLog(AMessage);
            end);
end;

procedure TAccentDBThread.AddError(AMessage: string);
begin
    FErrors.Add(AMessage);
    Log(AMessage);
end;

procedure TAccentDBThread.Progress(APosition, AMax: Integer);
begin
    if Assigned(FOnProgress) then
        Queue(
            procedure
            begin
                FOnProgress(APosition, AMax);
            end);
end;

{ TAccentImagesThread }

// Converteste imaginea in PNG fara controale VCL si fara fisiere temporare.
// TBitmap.Assign si TPngImage.Assign(TBitmap) lucreaza prin handle-uri GDI (GetDIBits),
// fara TCanvas, deci pot fi apelate din firul secundar.
procedure TAccentImagesThread.ConvertToPng(ASource, ADest: TStream);
var
    Signature: array[0..3] of Byte;
    Graphic: TGraphic;
    Bitmap: TBitmap;
    Png: TPngImage;
begin
    FillChar(Signature, SizeOf(Signature), 0);
    ASource.Position := 0;
    ASource.Read(Signature, SizeOf(Signature));
    ASource.Position := 0;

    // PNG - se salveaza asa cum a venit
    if (Signature[0] = $89) and (Signature[1] = $50) and (Signature[2] = $4E) and (Signature[3] = $47) then
    begin
        ADest.CopyFrom(ASource, 0);
        Exit;
    end;

    if (Signature[0] = $FF) and (Signature[1] = $D8) then
        Graphic := TJPEGImage.Create
    else if (Signature[0] = Ord('G')) and (Signature[1] = Ord('I')) and (Signature[2] = Ord('F')) then
        Graphic := TGIFImage.Create
    else if (Signature[0] = Ord('B')) and (Signature[1] = Ord('M')) then
        Graphic := TBitmap.Create
    else
        raise Exception.CreateFmt('Format de imagine nesuportat (%.2x %.2x %.2x %.2x)', [Signature[0], Signature[1], Signature[2], Signature[3]]);

    Bitmap := TBitmap.Create;
    Png := TPngImage.Create;
    try
        Graphic.LoadFromStream(ASource);
        Bitmap.Assign(Graphic);
        Png.Assign(Bitmap);
        Png.SaveToStream(ADest);
    finally
        Png.Free;
        Bitmap.Free;
        Graphic.Free;
    end;
end;

procedure TAccentImagesThread.Execute;
var
    Items: TList<TPair<Integer, string>>;
    ImageFileNameList: TStringList;
    msSource: TMemoryStream;
    msPng: TMemoryStream;
    trUpdate: TIBCTransaction;
    qImages: TIBCQuery;
    ibcsql: TIBCSQL;
    idFTP: TIdFTP;
    GoodsID: Integer;
    FileName: string;
begin
    NameThreadForDebugging('AccentImages');

    Items := TList<TPair<Integer, string>>.Create;
    ImageFileNameList := TStringList.Create;
    msSource := TMemoryStream.Create;
    msPng := TMemoryStream.Create;
    trUpdate := TIBCTransaction.Create(nil);
    qImages := TIBCQuery.Create(nil);
    ibcsql := TIBCSQL.Create(nil);
    idFTP := TIdFTP.Create(nil);
    try
        try
            FConnection.Connect;
            trUpdate.DefaultConnection := FConnection;

            // lista produselor fara imagini se citeste integral, ca sa nu tinem cursorul
            // deschis peste commit-urile de mai jos
            qImages.Connection := FConnection;
            qImages.Transaction := trUpdate;
            qImages.SQL.Text := FSelectSQL;
            trUpdate.StartTransaction;
            qImages.Open;
            while not qImages.Eof do
            begin
                Items.Add(TPair<Integer, string>.Create(qImages.FieldByName('goodsid').AsInteger, qImages.FieldByName('imageslist').AsString));
                qImages.Next;
            end;
            qImages.Close;
            trUpdate.Commit;

            Progress(0, Items.Count);
            Log(Format('Produse fara imagini: %d', [Items.Count]));

            idFTP.Host := cAccentFtpHost;
            idFTP.Username := 'anonymous';
            idFTP.Passive := True;
            idFTP.ConnectTimeout := 30000;
            idFTP.ReadTimeout := 60000;
            idFTP.Connect;

            ibcsql.Connection := FConnection;
            ibcsql.Transaction := trUpdate;
            ibcsql.AutoCommit := False;
            ibcsql.SQL.Add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
            ibcsql.SQL.Add('values (:goodsid, :image, :flg_need2recreate)');

            for var I := 0 to Items.Count - 1 do
            begin
                if Terminated then
                    Break;

                if not trUpdate.Active then
                    trUpdate.StartTransaction;
                if not ibcsql.Prepared then
                    ibcsql.Prepare;

                GoodsID := Items[I].Key;
                ImageFileNameList.CommaText := Items[I].Value;
                for var j := 0 to ImageFileNameList.Count - 1 do
                begin
                    FileName := cAccentFtpImagesPath + ImageFileNameList[j];
                    try
                        if not idFTP.Connected then
                            idFTP.Connect;
                        msSource.Clear;
                        idFTP.Get(FileName, msSource);
                        msPng.Clear;
                        ConvertToPng(msSource, msPng);
                        msPng.Position := 0;

                        ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
                        ibcsql.ParamByName('image').LoadFromStream(msPng, ftBlob);
                        ibcsql.ParamByName('flg_need2recreate').AsInteger := 1;
                        ibcsql.Execute;
                        Inc(FSavedImagesCount);
                    except
                        on E: Exception do
                            AddError('GoodsID: ' + GoodsID.ToString + '  Path: ' + FileName + '  ' + E.Message);
                    end;
                end;

                Inc(FProcessedCount);
                if FProcessedCount mod cCommitBatch = 0 then
                    trUpdate.Commit;
                Progress(FProcessedCount, Items.Count);
            end;

            // restul sub cCommitBatch; la Stop produsele deja procesate raman salvate
            if trUpdate.Active then
                trUpdate.Commit;
        except
            on E: Exception do
            begin
                FErrorMessage := E.Message;
                try
                    if trUpdate.Active then
                        trUpdate.Rollback;
                except
                    // conexiunea poate fi deja cazuta
                end;
            end;
        end;
    finally
        try
            if idFTP.Connected then
                idFTP.Disconnect;
        except
            // conexiunea FTP poate fi deja cazuta
        end;
        idFTP.Free;
        ibcsql.Free;
        qImages.Free;
        trUpdate.Free;
        msPng.Free;
        msSource.Free;
        ImageFileNameList.Free;
        Items.Free;
        FConnection.Disconnect;
    end;
end;

{ TAccentPropertiesThread }

constructor TAccentPropertiesThread.Create(ASourceConnection: TIBCConnection; const ASelectSQL, AGuid: string);
begin
    inherited Create(ASourceConnection, ASelectSQL);
    FGuid := AGuid;
end;

procedure TAccentPropertiesThread.ParseProperties(const AJSON: string; AList: TList<TProductPropertyRecord>);
var
    JSONValue: TJSONValue;
    Item: TJSONValue;
    Pair: TJSONPair;
    PropertyName: string;
    Rec: TProductPropertyRecord;
begin
    AList.Clear;
    JSONValue := TJSONObject.ParseJSONValue(AJSON);
    try
        if not (JSONValue is TJSONArray) then
            raise Exception.Create('Raspuns API neasteptat: ' + Copy(AJSON, 1, 200));

        for Item in TJSONArray(JSONValue) do
        begin
            if not (Item is TJSONObject) then
                Continue;

            // fiecare caracteristica de la zero - campurile lipsa nu se preiau de la cea precedenta
            Rec := Default(TProductPropertyRecord);
            for var j := 0 to TJSONObject(Item).Count - 1 do
            begin
                Pair := TJSONObject(Item).Pairs[j];
                PropertyName := Pair.JsonString.Value;

                if SameText(PropertyName, 'id') then
                    Rec.Id := Pair.JsonValue.Value.ToInteger
                else if SameText(PropertyName, 'hardcode') then
                    Rec.Hardcode := Pair.JsonValue.Value.ToInteger
                else if SameText(PropertyName, 'propertyNameRus') then
                    Rec.PropertyNameRus := Pair.JsonValue.Value
                else if SameText(PropertyName, 'propertyNameRom') then
                    Rec.PropertyNameRom := Pair.JsonValue.Value
                else if SameText(PropertyName, 'propertyValue') then
                    Rec.PropertyValue := Pair.JsonValue.Value
                else if SameText(PropertyName, 'propertyParentCode') then
                    Rec.PropertyParentCode := Pair.JsonValue.Value
                else if SameText(PropertyName, 'WebVisible') then
                    Rec.WebVisible := Pair.JsonValue.Value
                else if SameText(PropertyName, 'Description') then
                    Rec.Description := Pair.JsonValue.Value
                else if SameText(PropertyName, 'DescriptionRom') then
                    Rec.DescriptionRom := Pair.JsonValue.Value
                else if SameText(PropertyName, 'TagName') then
                    Rec.TagName := Pair.JsonValue.Value
                else if SameText(PropertyName, 'TagNameRus') then
                    Rec.TagNameRus := Pair.JsonValue.Value
                else if SameText(PropertyName, 'TagNameRom') then
                    Rec.TagNameRom := Pair.JsonValue.Value
                else if SameText(PropertyName, 'sortOrder') then
                    Rec.SortOrder := Pair.JsonValue.Value
                else if SameText(PropertyName, 'transactionid') then
                    Rec.TransactdionID := StrToIntDef(Pair.JsonValue.Value, -1);
            end;
            AList.Add(Rec);
        end;
    finally
        JSONValue.Free;
    end;
end;

procedure TAccentPropertiesThread.Execute;
const
    cProductSavepoint = 'ACCENT_PRODUCT';
var
    Items: TList<Integer>;
    Properties: TList<TProductPropertyRecord>;
    trUpdate: TIBCTransaction;
    qProducts: TIBCQuery;
    ibcsql: TIBCSQL;
    idHTTP: TIdHTTP;
    Request: TStringStream;
    InternalID: Integer;
    JSON: string;
begin
    NameThreadForDebugging('AccentProperties');

    Items := TList<Integer>.Create;
    Properties := TList<TProductPropertyRecord>.Create;
    trUpdate := TIBCTransaction.Create(nil);
    qProducts := TIBCQuery.Create(nil);
    ibcsql := TIBCSQL.Create(nil);
    idHTTP := TIdHTTP.Create(nil);
    Request := TStringStream.Create('');
    try
        try
            FConnection.Connect;
            trUpdate.DefaultConnection := FConnection;

            // lista produselor se citeste integral, ca sa nu tinem cursorul deschis peste commit-uri
            qProducts.Connection := FConnection;
            qProducts.Transaction := trUpdate;
            qProducts.SQL.Text := FSelectSQL;
            trUpdate.StartTransaction;
            qProducts.Open;
            while not qProducts.Eof do
            begin
                Items.Add(qProducts.FieldByName('internalid').AsInteger);
                qProducts.Next;
            end;
            qProducts.Close;
            trUpdate.Commit;

            Progress(0, Items.Count);

            idHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
            idHTTP.Request.Accept := 'application/json, text/javascript, */*; q=0.01';
            idHTTP.Request.ContentType := 'application/json; charset=UTF-8';
            idHTTP.Request.CharSet := 'utf-8';
            idHTTP.ConnectTimeout := 30000;
            idHTTP.ReadTimeout := 60000;

            ibcsql.Connection := FConnection;
            ibcsql.Transaction := trUpdate;
            ibcsql.AutoCommit := False;
            ibcsql.SQL.Add('insert into tapi_accent_products_properties (id, hardcode, property_code, property_name_rus, property_name_rom,');
            ibcsql.SQL.Add('property_value, property_parent_code, web_visible, description,');
            ibcsql.SQL.Add('description_rom, tag_name, tag_name_rus, tag_name_rom, sort_order,');
            ibcsql.SQL.Add('transactionid)');
            ibcsql.SQL.Add('values (:id, :hardcode, :property_code, :property_name_rus, :property_name_rom, :property_value, :property_parent_code,');
            ibcsql.SQL.Add(':web_visible, :description, :description_rom, :tag_name, :tag_name_rus, :tag_name_rom, :sort_order,');
            ibcsql.SQL.Add(':transactionid)');

            for var I := 0 to Items.Count - 1 do
            begin
                if Terminated then
                    Break;

                if not trUpdate.Active then
                    trUpdate.StartTransaction;
                if not ibcsql.Prepared then
                    ibcsql.Prepare;

                InternalID := Items[I];
                try
                    Request.Position := 0;
                    JSON := idHTTP.Post(cAccentApiUrl + '/hardproperty/' + FGuid + '/productid/' + InternalID.ToString, Request);
                    ParseProperties(JSON, Properties);

                    // caracteristicile unui produs se salveaza toate sau niciuna
                    trUpdate.StartSavepoint(cProductSavepoint);
                    try
                        for var P in Properties do
                        begin
                            ibcsql.ParamByName('id').AsString := P.Id.ToString;
                            ibcsql.ParamByName('hardcode').AsString := P.Hardcode.ToString;
                            ibcsql.ParamByName('property_code').AsString := P.PropertyCode;
                            ibcsql.ParamByName('property_name_rus').AsString := P.PropertyNameRus;
                            ibcsql.ParamByName('property_name_rom').AsString := P.PropertyNameRom;
                            ibcsql.ParamByName('property_value').AsString := P.PropertyValue;
                            ibcsql.ParamByName('property_parent_code').AsString := P.PropertyParentCode;
                            ibcsql.ParamByName('web_visible').AsString := P.WebVisible;
                            ibcsql.ParamByName('description').AsString := P.Description;
                            ibcsql.ParamByName('description_rom').AsString := P.DescriptionRom;
                            ibcsql.ParamByName('tag_name').AsString := P.TagName;
                            ibcsql.ParamByName('tag_name_rus').AsString := P.TagNameRus;
                            ibcsql.ParamByName('tag_name_rom').AsString := P.TagNameRom;
                            ibcsql.ParamByName('sort_order').AsString := P.SortOrder;
                            ibcsql.ParamByName('transactionid').AsString := P.TransactdionID.ToString;
                            ibcsql.Execute;
                        end;
                        trUpdate.ReleaseSavepoint(cProductSavepoint);
                    except
                        trUpdate.RollbackSavepoint(cProductSavepoint);
                        raise;
                    end;
                    Inc(FSavedPropertiesCount, Properties.Count);
                except
                    on E: Exception do
                        AddError('InternalID: ' + InternalID.ToString + '  ' + E.Message);
                end;

                Inc(FProcessedCount);
                if FProcessedCount mod cCommitBatch = 0 then
                    trUpdate.Commit;
                Progress(FProcessedCount, Items.Count);
            end;

            // restul sub cCommitBatch; la Stop produsele deja procesate raman salvate
            if trUpdate.Active then
                trUpdate.Commit;
        except
            on E: Exception do
            begin
                FErrorMessage := E.Message;
                try
                    if trUpdate.Active then
                        trUpdate.Rollback;
                except
                    // conexiunea poate fi deja cazuta
                end;
            end;
        end;
    finally
        Request.Free;
        idHTTP.Free;
        ibcsql.Free;
        qProducts.Free;
        trUpdate.Free;
        Properties.Free;
        Items.Free;
        FConnection.Disconnect;
    end;
end;

{ Tframe91APIAccent - imagini }

procedure Tframe91APIAccent.GetAccentImages;
begin
    // a doua apasare in timpul descarcarii = oprire; produsele procesate deja raman salvate
    if Assigned(FImagesThread) then
    begin
        FImagesThread.Terminate;
        btnLoadImages.Enabled := False;
        Memo1.Lines.Add('Oprire solicitata...');
        Exit;
    end;

    // ambele fire folosesc cxProgressBar2 - nu le pornim in paralel
    if Assigned(FPropertiesThread) then
    begin
        ShowMessage('Se descarca caracteristicile. Asteptati finalizarea sau opriti descarcarea.');
        Exit;
    end;

    IBCQueryImages.Close;
    IBCQueryImages.Open;
    Memo1.Lines.Clear;
    cxProgressBar2.Position := 0;

    FImagesThread := TAccentImagesThread.Create(dmdb.IBCConnection, IBCQueryImages.SQL.Text);
    FImagesThread.OnLog :=
        procedure(AMessage: string)
        begin
            Memo1.Lines.Add(AMessage);
        end;
    FImagesThread.OnProgress := ShowWorkerProgress;
    FImagesThread.OnTerminate := ImagesThreadTerminate;

    FLoadImagesCaption := btnLoadImages.Caption;
    btnLoadImages.Caption := 'Stop';
    FImagesThread.Start;
end;

procedure Tframe91APIAccent.ImagesThreadTerminate(Sender: TObject);
var
    Thread: TAccentImagesThread;
begin
    Thread := Sender as TAccentImagesThread;
    FImagesThread := nil;

    if Thread.ErrorMessage <> '' then
        Memo1.Lines.Add('Eroare: ' + Thread.ErrorMessage);
    if Thread.FatalException is Exception then
        Memo1.Lines.Add('Eroare: ' + Exception(Thread.FatalException).Message);
    Memo1.Lines.Add(Format('Gata. Produse procesate: %d, imagini salvate: %d', [Thread.ProcessedCount, Thread.SavedImagesCount]));

    btnLoadImages.Caption := FLoadImagesCaption;
    btnLoadImages.Enabled := True;

    // raman in lista doar produsele care inca nu au imagini
    IBCQueryImages.Close;
    IBCQueryImages.Open;

    // firul nu poate fi eliberat din propriul OnTerminate (WaitFor s-ar bloca) - il eliberam dupa
    TThread.ForceQueue(nil,
        procedure
        begin
            Thread.Free;
        end);
end;

procedure Tframe91APIAccent.ShowWorkerProgress(APosition, AMax: Integer);
begin
    cxProgressBar2.Properties.Max := AMax;
    cxProgressBar2.Position := APosition;
end;

procedure Tframe91APIAccent.StopWorkerThreads;

    procedure StopThread(AThread: TThread);
    begin
        if not Assigned(AThread) then
            Exit;
        AThread.OnTerminate := nil;
        AThread.Terminate;
        AThread.WaitFor;
        AThread.Free;
    end;

begin
    StopThread(FImagesThread);
    FImagesThread := nil;
    StopThread(FPropertiesThread);
    FPropertiesThread := nil;
end;

procedure Tframe91APIAccent.cxGrid1TableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    inherited;
    if ARecord.Values[cxGrid1TableView1_COST.Index] >= ARecord.Values[cxGrid1TableView1_PRICE7.Index] then
    begin
        AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
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


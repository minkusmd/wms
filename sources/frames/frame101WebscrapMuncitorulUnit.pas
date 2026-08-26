unit frame101WebscrapMuncitorulUnit;

// Muncitorul.md Parser
// Frame Index = 101

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  System.UITypes,
  Dialogs,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxGraphics,
  DB,
  cxDBData,
  cxGrid,
  dxBar,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  Vcl.ExtCtrls,
  DBAccess,
  IBC,
  Vcl.StdCtrls,
  cxGridDBBandedTableView,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCheckBox,
  cxCurrencyEdit,
  cxLabel,
  dxBarBuiltInMenu,
  MemDS,
  cxClasses,
  cxGridBandedTableView,
  cxGridTableView,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridDBTableView,
  cxGridCustomView,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  Vcl.Menus,
  cxButtons,
  MSHTML,
  cxContainer,
  MuncitorulParserUnit,
  dxmdaset,
  cxPC,
  SynEdit,
  SynEditHighlighter,
  SynEditCodeFolding,
  SynHighlighterPython,
  SynEditPythonBehaviour,
  dxUIAClasses,
  cxTextEdit,
  Vcl.Grids,
  Vcl.DBGrids,
  CRGrid;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe101WebScrapMuncitorul = class(TSWNBaseFrame)
    dxBarManager1: TdxBarManager;
    cxGridPopupMenu: TcxGridPopupMenu;
    pmPopupMenuDoc: TdxBarPopupMenu;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    bbDocComments: TdxBarButton;
    bbCustomerDebts: TdxBarButton;
    dxBarButton1: TdxBarButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCSQLGoods: TIBCSQL;
    dxMemData1: TdxMemData;
    dxMemData1Code: TStringField;
    dxMemData1Titlu: TStringField;
    dxMemData1pret_online: TFloatField;
    dxMemData1pret_vinz: TFloatField;
    DataSource1: TDataSource;
    dxMemData1stoc: TStringField;
    cxPageControl1: TcxPageControl;
    tsImages: TcxTabSheet;
    tsPromotii: TcxTabSheet;
    Panel2: TPanel;
    cbNoImages: TcxCheckBox;
    cbFLG_IN_PRICE: TcxCheckBox;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxGridMuncitorulGoods: TcxGrid;
    cxGridMuncitorulGoodsDBTableView1: TcxGridDBTableView;
    cxGridMuncitorulGoodsDBTableView1GOODSID: TcxGridDBColumn;
    cxGridMuncitorulGoodsDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridMuncitorulGoodsDBTableView1_GOODS_TITLE: TcxGridDBColumn;
    cxGridMuncitorulGoodsDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridMuncitorulGoodsLevel1: TcxGridLevel;
    Memo1: TMemo;
    cxButton4: TcxButton;
    Memo2: TMemo;
    SynEdit1: TSynEdit;
    cxTabSheet1: TcxTabSheet;
    cxTextEdit1: TcxTextEdit;
    btnLoadJSON: TcxButton;
    Memo3: TMemo;
    cxButton5: TcxButton;
    dxMemProducts: TdxMemData;
    dxMemImages: TdxMemData;
    dxMemFeatures: TdxMemData;
    dsMemProducts: TDataSource;
    dsMemImages: TDataSource;
    dsMemFeatures: TDataSource;
    cxGridImages: TcxGrid;
    cxGridImagesDBTableView1: TcxGridDBTableView;
    cxGridLevelImages: TcxGridLevel;
    cxGridFeatures: TcxGrid;
    cxGridFeaturesDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridMuncitorulGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbNoImagesPropertiesChange(Sender: TObject);
    procedure cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure btnLoadJSONClick(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private    { Private declarations }
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
    plid: Integer;
    Doc: IHTMLDocument2;
    Body: OleVariant;

    procedure AddNewPriceList(CustomerID: Integer);
    procedure AddNewPricelistItem(goodscode: string; goodsname: string; price3: double; currency3id: integer; price7:
      double; currency7id: integer; stoc: string);
    procedure CreateMuncitorulPriceList(dxMemData1: TdxMemData);
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure LoadDom(htmlcode: string);
    procedure LoadPage(URL: string; var HtmlStrings: TStringList);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;

    procedure SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
    procedure SaveFrameStates; override;
    procedure SaveImageToDB(ImageURL: string);

    procedure SetupSecurityItems; override;

  public    { Public declarations }
    procedure WhenParseProduct(AProduct: TWebProduct);
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
    procedure ParseDetailPage(var DescriptionRo: string);
    procedure SetFlgInPrice(CustomerID: Integer; Goods_Code: string);
    procedure ParseMuncitorulNew(const AProductCode: string);
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNDBErrors, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNValueStorageUnit,
  frmCerereDePlataDBDialog, frmCerereDePlataDialog, frmCustomerCurrentDebtsDialog, frmMuncitorulProgressUnit,
  System.IOUtils,
  System.JSON,
  System.Variants,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Winapi.ActiveX,
  muncitorul.Data;

{$R *.dfm}

procedure Tframe101WebScrapMuncitorul.AddNewPriceList(CustomerID: Integer);
var
  query: TIBCSQL;
begin
  query := TIBCSQL.Create(nil);
  try
    query.Transaction := dmdb.IBCTrDefaultUpdate;
    query.SQL.Clear;
    query.SQL.Add('INSERT INTO TS_PRICELISTS (plid, supplierid, price_categoryid, data)');
    query.SQL.Add('values (NULL, :customerid, -1, current_timestamp)');
    query.SQL.Add('returning plid ');
    query.ParamByName('customerid').AsInteger := CustomerID;
    with TParam(query.Params.Add) do
    begin
      ParamType := ptResult;
      DataType := ftLargeint;
      Name := 'RET_PLID';
    end;
    try
      query.Execute;
      plid := query.ParamByName('ret_plid').Value;
      if dmDB.IBCTrDefaultUpdate.Active then
        dmdb.IBCTrDefaultUpdate.Commit;
    except
      if dmDB.IBCTrDefaultUpdate.Active then
        dmdb.IBCTrDefaultUpdate.Rollback;
    end;
  finally
    query.Free;
  end;
end;

procedure Tframe101WebScrapMuncitorul.AddNewPricelistItem(goodscode: string; goodsname: string; price3: double;
  currency3id: integer; price7: double; currency7id: integer; stoc: string);
var
  query: TIBCSQL;
begin
  try
    query := TIBCSQL.Create(nil);
    query.AutoCommit := false;
    query.Transaction := dmdb.IBCTrDefaultUpdate;
    query.Transaction.StartTransaction;
    try
      query.SQL.Clear;
      query.SQL.Add('INSERT INTO TS_PRICELIST_items (plid, supplier_goods_code, supplier_goods_name, price3, currency3id, price7, currency7id, stock_qty)');
      query.SQL.Add('values (:plid, :goods_code, :goods_name, :price3, :currency3id, :price7, :currency7id, :stoc)');
      try
        query.ParamByName('plid').AsInteger := plid;
        query.ParamByName('goods_code').AsString := goodscode;
        query.ParamByName('goods_name').AsString := goodsname;
        query.ParamByName('price3').AsFloat := price3;
        query.ParamByName('currency3id').AsInteger := currency3id;
        query.ParamByName('price7').AsFloat := price7;
        query.ParamByName('currency7id').AsInteger := currency7id;
        query.ParamByName('stoc').AsString := stoc;
        query.Execute;
        query.Transaction.Commit;
      except
        on E: Exception do
        begin
          if dmdb.IBCTrDefaultUpdate.Active then
            dmdb.IBCTrDefaultUpdate.Rollback;
        end;
      end;
    finally
      query.Transaction.Free;
    end;
  finally

  end;
end;

function DownloadJsonFromUrl(const AURL: string): string;
var
  HttpClient: TNetHTTPClient;
  Response: IHTTPResponse;
begin
  Result := '';
  HttpClient := TNetHTTPClient.Create(nil);
  try
    HttpClient.ConnectionTimeout := 15000;
    HttpClient.ResponseTimeout   := 30000;
    HttpClient.AcceptEncoding     := 'gzip, deflate';
    HttpClient.UserAgent          :=
      'Mozilla/5.0 (compatible; FantasticMD/1.0)';

    Response := HttpClient.Get(AURL);

    if Response.StatusCode = 200 then
      Result := Response.ContentAsString(TEncoding.UTF8)
    else
      raise Exception.CreateFmt(
        'HTTP error %d: %s', [Response.StatusCode, Response.StatusText]);
  finally
    HttpClient.Free;
  end;
end;

procedure Tframe101WebScrapMuncitorul.btnLoadJSONClick(Sender: TObject);
//var
//  Loader: TJsonDownloader;
//  JsonData: string;
begin
  try
    Memo3.Lines.Text := DownloadJsonFromUrl('https://price.muncitorul.md/api/products.json');
  except
    on E: Exception do
      ShowMessage('Eroare: ' + E.Message);
  end;
end;

procedure Tframe101WebScrapMuncitorul.cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFLG_IN_PRICE.Checked then
  begin
    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := 'AND GET_FLG_VALUE(GF.FLAGS, 3) = 1';
  end
  else
    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := '';
  ibcquery1.Open;
end;

procedure Tframe101WebScrapMuncitorul.cbNoImagesPropertiesChange(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbNoImages.Checked then
  begin
    ibcquery1.MacroByName('HasNoImage').Value := 'and not exists(select * ' + 'from TS_GOODS_IMAGE GI ' +
      'where GI.GOODSID = GF.GOODSID and ' + '      coalesce(octet_length(GI.IMAGE), 0) > 0)';
  end
  else
    ibcquery1.MacroByName('HasNoImage').Value := '';
  ibcquery1.Open;
end;

procedure Tframe101WebScrapMuncitorul.CreateMuncitorulPriceList(dxMemData1: TdxMemData);
begin

  dxMemData1.DisableControls;
  dxMemData1.First;

  // Olisgrup SRL
  try
    AddNewPriceList(251465);

    if not dmdb.IBCTrDefaultUpdate.Active then
      dmdb.IBCTrDefaultUpdate.StartTransaction;

    dxMemData1.First;

    while not dxMemData1.Eof do
    begin
      AddNewPricelistItem(dxMemData1Code.Value, dxMemData1Titlu.Value, dxMemData1pret_online.Value, 498,
        dxMemData1pret_vinz.Value, 498, dxMemData1stoc.Value);
      dxMemData1.Next;
      Application.ProcessMessages;
    end;

    if dmdb.IBCTrDefaultUpdate.Active then
      dmdb.IBCTrDefaultUpdate.Commit;
  except
    if dmdb.IBCTrDefaultUpdate.Active then
      dmdb.IBCTrDefaultUpdate.Rollback;
  end;
  dxMemData1.EnableControls;
end;

procedure Tframe101WebScrapMuncitorul.CreateNewRecord;
begin
end;

procedure Tframe101WebScrapMuncitorul.ParseMuncitorulNew(const AProductCode: string);
var
  p: TMuncitorulParser;
  ProductUrlRo: string;
  ProductUrlRu: string;
  LProductCode: string;
begin
  LProductCode := AProductCode;
  p := TMuncitorulParser.Create(format('https://muncitorul.md/ro/search?search=%s', [LProductCode]));
  try
    p.ProductCode := LProductCode;
//    p.OnParseProduct := WhenParseProduct;
//    p.OnParseSearch := WhenParseSearch;
    p.ParseSearchResult(ProductUrlRo, ProductUrlRu);
  finally
    FreeAndNil(p);
  end;

  p := TMuncitorulParser.Create(ProductUrlRo);
  try
    p.ProductCode := LProductCode;
    p.OnParseProduct := WhenParseProduct;
    p.ParseDetailPage;
  finally
    FreeAndNil(p);
  end;
end;

procedure Tframe101WebScrapMuncitorul.WhenParseProduct(AProduct: TWebProduct);
var
  i: Integer;
begin
  Memo1.Lines.Add('Product Code: ' + AProduct.ProductCode);
  Memo1.Lines.Add('Product price: ' + AProduct.ProductPrice);
  Memo1.Lines.Add('Images:');
  for i := 0 to AProduct.ImageList.Count - 1 do
  begin
    Memo1.Lines.Add(AProduct.ImageList[i]);
    SaveImageToDB(AProduct.ImageList[i]);
    SaveDescriptionToDB(AProduct.DescriptionRo, AProduct.DescriptionRu);
  end;
  Memo1.Lines.Add('Description Ro:');
  Memo1.Lines.Add(AProduct.DescriptionRo);
end;

procedure Tframe101WebScrapMuncitorul.cxButton1Click(Sender: TObject);
var
  p: TMuncitorulParser;
  ProductUrlRo: string;
  ProductUrlRu: string;
  LProductCode: string;
begin
  Memo1.Lines.Clear;
  while not IBCQuery1.Eof do
  begin
    LProductCode := IBCQuery1.FieldByName('goods_code').AsString;
    p := TMuncitorulParser.Create(format('https://muncitorul.md/ro/search?search=%s', [LProductCode]));
    try
      p.ProductCode := LProductCode;
      p.OnParseProduct := WhenParseProduct;
//    p.OnParseSearch := WhenParseSearch;
      p.ParseSearchResult(ProductUrlRo, ProductUrlRu);
    finally
      FreeAndNil(p);
    end;

    p := TMuncitorulParser.Create(ProductUrlRo);
    try
      p.ProductCode := LProductCode;
      p.OnParseProduct := WhenParseProduct;
      p.ParseDetailPage;
    finally
      FreeAndNil(p);
    end;

    ibcquery1.Next;

    Application.ProcessMessages;
  end;
end;
//var
//  Parser: TMuncitorulParser;
//  url: string;
//  ImageStream: TMemoryStream;
//  ImagePath: string;
//  jpegImage: TJPEGImage;
//  bmpImage: TBitMap;
//  DescriptionRo: string;
//  I: Integer;
//  imgExt: string;
//  pngImage: TPngImage;
//  ProductdetailInfo: TProductDetailInfo;
//  ProductDetailUrl: string;
//begin
////  ibcquery1.First;
//  while not IBCQuery1.Eof do begin
//
//
//    url := 'https://muncitorul.md/ro/search/?search=VOR57339';
//    Parser := TMuncitorulParser.Create(Self, url);
//    ImageStream := TMemoryStream.Create;
//    try
//      ImagePath := '';
//      Parser.DoParse;
//      ImagePath := Trim(Parser.ImagePath);
//      ProductDetailUrl := trim(Parser.ProductDetailUrl);
//
////      DescriptionRo := Trim(Parser.DescriptionRO);
//      if ProductDetailUrl<>'' then begin
//        ProductdetailInfo := GetProductDetailInfo(ProductDetailUrl);
//        if (trim(ProductdetailInfo.DescriptionRo) <> '') then begin
//          if not IBCtrLocalUpdate.Active then
//            IBCtrLocalUpdate.StartTransaction;
//          try
//            IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').AsInteger;
//            IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := ProductdetailInfo.DescriptionRo;
//            IBCSQLGoods.Execute;
//            IBCtrLocalUpdate.Commit;
//          except
//            IBCtrLocalUpdate.Rollback;
//          end;
//        end;
//      end;
//
//      (*TODO: extracted code
//      // convert image to png
//      pngImage := TPngImage.Create;
//      jpegImage := TJPEGImage.Create;
//
//      if ImagePath <> '' then begin
//        NetHTTPClient1.Get(ImagePath, ImageStream);
//        Application.ProcessMessages;
//
//        ImageStream.Position := 0;
//        imgExt := TPath.GetExtension(ImagePath);
//        if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
//          try
//            ImageStream.SaveToFile('tmp.jpeg');
//            jpegImage.loadfromFile('tmp.jpeg');
//          except
//            on e: Exception do begin
//              IBCQuery1.Next;
//              Continue;
//            end;
//          end;
//        end;
//
//        if imgExt = '.png' then begin
//          ImageStream.SaveToFile('tmp.png');
//          pngImage := TPngImage.Create;
//          pngImage.loadfromFile('tmp.png');
//        end;
//
//        bmpImage := TBitMap.Create;
//        try
//          bmpImage.Assign(jpegImage);
//          try
//            if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
//              pngImage.Assign(bmpImage);
//              pngImage.SaveToFile('tmp.png');
//            end;
//          except
//          end;
//        finally
//          bmpImage.Free;
//        end;
//      *)
//      for I := 0 to imageList do
//        GetImage(ImageStream, ImagePath);
//
//        if not IBCtrLocalUpdate.Active then
//          IBCtrLocalUpdate.StartTransaction;
//        try
//          IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').ASInteger;
//          IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
//          IBCSQL1.Execute;
//          IBCtrLocalUpdate.Commit;
//          DeleteFile('tmp.png');
//        except
//          IBCtrLocalUpdate.Rollback;
//        end;
//
//        // daca am gasit linkul nu mai alergam prin ciclu
////        break;
//      end;
//    finally
//      Application.ProcessMessages;
//      FreeAndNil(jpegImage);
//      FreeAndNil(pngImage);
//      ImageStream.Free;
//      Parser.Free;
//    end;
//    IBCQuery1.Next;
//    break;
//  end;
//end;

procedure Tframe101WebScrapMuncitorul.cxButton2Click(Sender: TObject);
begin
  inherited;
  while not ibcquery1.Eof do
  begin
    SetFlgInPrice(251465, ibcquery1.FieldByName('GOODS_CODE').AsString);
    ibcquery1.Next;
  end;

end;

procedure Tframe101WebScrapMuncitorul.cxButton3Click(Sender: TObject);
var
  Code: string;
  dialog: TOpenDialog;
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  pret_online: string;
  pret_vinz: string;
  Value: TJSONValue;
  StringList: TStringlist;
  titlu: string;
begin
  dialog := TOpenDialog.Create(self);
  StringList := TStringlist.Create;

  try
    dialog.DefaultExt := '*.json';
    dxMemData1.Open;
    dxMemData1.DisableControls;
    while not dxMemData1.Eof do
      dxMemData1.Delete;

//    dxMemData1.ClearFields;
//    dxMemData1.EmptyDataSet

    if dialog.Execute then
    begin
      StringList.LoadFromFile(dialog.FileName);
      JSONArray := TJSONObject.ParseJSONValue(StringList.Text) as TJSONArray;
      try
        for var i := 0 to JSONArray.count - 1 do
        begin
          Value := JSONArray.Items[i];
          dxMemData1.Append;
          dxMemData1Code.Value := (Value as TJSONObject).GetValue('code').Value;
          dxMemData1Titlu.Value := (Value as TJSONObject).GetValue('titlu').Value;
          dxMemData1Pret_vinz.Value := (Value as TJSONObject).GetValue('pret_vinz').Value.ToDouble;
          dxMemData1Pret_online.Value := (Value as TJSONObject).GetValue('pret_online').Value.ToDouble;
          dxMemData1Stoc.Value := (Value as TJSONObject).GetValue('stoc').Value;
          dxMemData1.Post;
        end;
      finally
        JSONArray.Free;
      end;

    end;
    dxMemData1.EnableControls;
    Application.ProcessMessages;
    CreateMuncitorulPriceList(dxMemData1);
  finally
    StringList.Free;
    dialog.Free;
  end;
end;

procedure Tframe101WebScrapMuncitorul.cxButton4Click(Sender: TObject);
begin
//  GetPythonEngine.ExecString(UTF8Encode(SynEdit1.Text));
end;

procedure Tframe101WebScrapMuncitorul.cxButton5Click(Sender: TObject);
begin
  inherited;
  var d:=TfrmMuncitorulProgressDlg.Create(self);

  try
    d.ShowModal;
  finally
    d.Free;
  end;


//  LoadMuncitorulProductsToCxGrid(
//  cxGridProducts,
//  cxGridImages,
//  cxGridFeatures,
//  dmdb.IBCConnection,
//  dmdb.IBCTrDefaultSelect,
//  dmdb.IBCTrDefaultUpdate
//);

//  LoadMuncitorulProductsToMemData(dxMemProducts, dxMemImages, dxMemFeatures, dmdb.ibcconnection, dmdb.IBCTrDefaultSelect, dmdb.IBCTrDefaultUpdate);
//  ShowMessage('Produsele au fost încărcate în TdxMemData.');

//var
//  MuncData: TMuncitorulData;
//  JsonStr: string;
//begin
//  JsonStr := Memo1.Lines.Text; // de exemplu, JSON în Memo
//  MuncData := TMuncitorulData.Create;
//  try
//    MuncData.LoadFromJson(JsonStr);
//
//    // Poți lega la grid-uri:
//    DataSourceProducts.DataSet := MuncData.Products;
//    DataSourceImages.DataSet := MuncData.Images;
//    DataSourceFeatures.DataSet := MuncData.Features;
//  finally
//    MuncData.Free;
//  end;

end;

procedure Tframe101WebScrapMuncitorul.cxGridMuncitorulGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridMuncitorulGoodsDBTableView1, Key, Shift);
end;

procedure Tframe101WebScrapMuncitorul.DeleteRecord;
begin
end;

procedure Tframe101WebScrapMuncitorul.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe101WebScrapMuncitorul.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  IBCQuery1.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  SelectionChanged;
end;

function Tframe101WebScrapMuncitorul.GetCurrentSearchContext: TSearchContextValue;
begin
end;

function Tframe101WebScrapMuncitorul.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe101WebScrapMuncitorul.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
end;

function Tframe101WebScrapMuncitorul.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

procedure Tframe101WebScrapMuncitorul.GetParamsListForReport(const ParamsList: TStringList);
begin
//    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe101WebScrapMuncitorul.GetParamValueForReport(const ParamName: string): Variant;
begin
//    if ParamName = 'FAST_MONEY_TRANSFER' then
//    begin
//        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
//            Result := '1'
//        else
//            Result := '0';
//    end;
end;

procedure Tframe101WebScrapMuncitorul.LoadDom(htmlcode: string);
var
  v: OleVariant;
begin
  Doc := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  Doc.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := htmlcode;
  Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  Body := Doc.body;
end;

procedure Tframe101WebScrapMuncitorul.LoadPage(URL: string; var HtmlStrings: TStringList);
var
  MS: TMemoryStream;
  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.GET(URL, MS);
    MS.Position := 0;
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    freeAndNil(NetHTTPClient);
  end;
end;

function Tframe101WebScrapMuncitorul.GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
var
  detail: TProductDetailInfo;
  htmlbody: TSTringlist;
begin
  htmlbody := TStringlist.Create;
  try
    LoadPage(ProductDetailUrl, htmlbody);
    loadDom(htmlbody.Text);
    ParseDetailPage(result.DescriptionRo);
  finally
    htmlbody.Free;
  end;
end;

function Tframe101WebScrapMuncitorul.InitFrameID: Integer;
begin
  Result := 101;
end;

procedure Tframe101WebScrapMuncitorul.ModifyRecord;
begin
end;

procedure Tframe101WebScrapMuncitorul.ParseDetailPage(var DescriptionRo: string);
var
  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  cc: Integer;
  dd: IHTMLElement;
  i, k: Integer;
  s: string;
  j: Integer;
  cnt: integer;
begin
  allDivs := Body.All.Tags('div');
  s := '';
//  ImagePath := '';
  for j := 0 to allDivs.Length - 1 do
  begin
    cc := 0;
    if (allDivs.item(j).ClassName = 'sidebar-right') then
    begin
      Elements := allDivs.item(j).getElementsByTagName('div');
      cnt := Elements.Length - 1;
      for i := 0 to (Elements.Length - 1) do
      begin
//        // get imagelink
//        if (Elements.item(i).ClassName = 'img_link') then begin
//          aHrefTags := Elements.item(i).getElementsByTagName('a');
//          if aHrefTags.Length > 0 then begin
//            s := aHrefTags.item(0).href;
//            ProductDetailUrl := s;
//          end;
//
//          aHrefTags := Elements.item(i).getElementsByTagName('img');
//          if aHrefTags.Length > 0 then begin
//            s := aHrefTags.item(0).href;
//            s := Copy(s, pos('&image=', s) + 7, length(s));
//            s := 'https://muncitorul.md' + s;
//            ImagePath := s;
//          end;
//        end;
        // DescriptionRO
        s := Elements.item(i).id;
        if (Elements.item(i).id = 'item_view_desc') then
        begin

          if (cc > 0) then
            DescriptionRo := Elements.item(i).InnerText;
          inc(cc);
        end;
      end;
    end;
  end;
end;

procedure Tframe101WebScrapMuncitorul.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe101WebScrapMuncitorul.SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
begin
  if (trim(DescriptionRo) <> '') or (trim(DescriptionRu) <> '') then
  begin
    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;
    try
      IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').AsInteger;
      IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := DescriptionRo;
      IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := DescriptionRu;
      IBCSQLGoods.Execute;
      IBCtrLocalUpdate.Commit;
    except
      IBCtrLocalUpdate.Rollback;
    end;
  end;
end;

procedure Tframe101WebScrapMuncitorul.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;
end;

procedure Tframe101WebScrapMuncitorul.SaveImageToDB(ImageURL: string);
var
  imagePath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  imgExt: string;
  pngImage: TPngImage;
begin
  ImageStream := TMemoryStream.Create;
  pngImage := TPngImage.Create;
  jpegImage := TJPEGImage.Create;

  imagePath := Trim(ImageURL);
  try
    if imagePath <> '' then
    begin
      NetHTTPClient1.Get(imagePath, ImageStream);
      Application.ProcessMessages;

      ImageStream.Position := 0;
      imgExt := TPath.GetExtension(imagePath);
      if (imgExt = '.jpeg') or (imgExt = '.jpg') then
      begin
        try
          ImageStream.SaveToFile('tmp.jpeg');
          jpegImage.loadfromFile('tmp.jpeg');
        except
          on e: Exception do
          begin
            IBCQuery1.Next;
          end;
        end;
      end;

      if imgExt = '.png' then
      begin
        ImageStream.SaveToFile('tmp.png');
        pngImage := TPngImage.Create;
        pngImage.loadfromFile('tmp.png');
      end;

      bmpImage := TBitMap.Create;
      try
        bmpImage.Assign(jpegImage);
        try
          if (imgExt = '.jpeg') or (imgExt = '.jpg') then
          begin
            pngImage.Assign(bmpImage);
            pngImage.SaveToFile('tmp.png');
          end;
        except
        end;
      finally
        bmpImage.Free;
      end;

      if not IBCtrLocalUpdate.Active then
        IBCtrLocalUpdate.StartTransaction;
      try
        IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').ASInteger;
        IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
        IBCSQL1.Execute;
        IBCtrLocalUpdate.Commit;
        DeleteFile('tmp.png');
      except
        IBCtrLocalUpdate.Rollback;
      end;
    end;
  finally
    Application.ProcessMessages;
    FreeAndNil(jpegImage);
    FreeAndNil(pngImage);
    ImageStream.Free;
  end;
end;

procedure Tframe101WebScrapMuncitorul.SelectionChanged;
begin
  // doc
  ButtonStateChanged(fbtADD, False);
  ButtonStateChanged(fbtMODIFY, False);
  ButtonStateChanged(fbtDELETE, False);
end;

procedure Tframe101WebScrapMuncitorul.SetFlgInPrice(CustomerID: Integer; Goods_Code: string);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(nil);
  try
    query.SQL.Text :=
      'update ts_goods_foreign set flags = set_flg_value(flags, 3, 1) where customerid = :customerid and goods_code = :goods_code';
    query.Transaction := IBCtrLocalUpdate;
    query.ParamByName('customerid').AsInteger := CustomerID;
    query.ParamByName('goods_code').AsString := Goods_Code;
    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;

    query.Execute;
    IBCtrLocalUpdate.Commit;
  finally
    query.Free;
  end;
end;

procedure Tframe101WebScrapMuncitorul.SetupSecurityItems;
begin
  inherited;
end;

procedure Tframe101WebScrapMuncitorul.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


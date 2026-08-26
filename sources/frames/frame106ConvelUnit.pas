unit frame106ConvelUnit;

// Volta.md Parser
// Frame Index = 105

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, Vcl.ExtCtrls, DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, Vcl.Menus, cxButtons, MSHTML, cxContainer,
  Vcl.ComCtrls, cxPC, cxTextEdit, cxMemo, System.Generics.Collections, dxUIAClasses;

const
  SupplierID = 229005;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  TConvelPriceInfo = record
    goods_code: string;
    goods_title: string;
    goods_url: string;
    goods_brand: string;
    goods_price: string;
  end;

  Tframe106Convel = class(TSWNBaseFrame)
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCSQLGoods: TIBCSQL;
    IBCSQLDelete: TIBCSQL;
    cxPageControl1: TcxPageControl;
    tbPriceList: TcxTabSheet;
    tsImages: TcxTabSheet;
    cxGridVolta: TcxGrid;
    cxGridVoltaDBTableView1: TcxGridDBTableView;
    cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn;
    cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridVoltaLevel1: TcxGridLevel;
    Panel1: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Panel2: TPanel;
    cxButton1: TcxButton;
    cbFlgNoImage: TCheckBox;
    cbFlgInPRICE: TCheckBox;
    cbUpdateAllImages: TCheckBox;
    cxButton2: TcxButton;
    ProgressBar1: TProgressBar;
    cxButton3: TcxButton;
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbNoImagesPropertiesChange(Sender: TObject);
    procedure cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

    Doc: IHTMLDocument2;
    d: HTMLLIElement;
    Body: OleVariant;
    HttpClient: THTTPClient;
    function ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;

    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure LoadDom(htmlcode: string);
    procedure LoadPage(url: string; var HtmlStrings: TStringList);
    procedure ParsePriceList;
    procedure SaveToDB(PriceList: TList<TConvelPriceInfo>);

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

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems; override;

  public    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
    procedure ParseDetailPage(var DescriptionRo: string);
    procedure SaveData(GoodsID: Integer; ProductName, ProductStockInfo, ProductDescriptionRo,
      ProductDescriptionRu, ProductImageUrl: string);
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.IOUtils, System.Variants,
  Winapi.ActiveX, frmVoltaParserUnit, frmConvelParserUnit;

{$R *.dfm}

procedure Tframe106Convel.cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
//  ibcquery1.Close;
//  if cbFlgInPRICE.Checked then begin
//    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := 'AND GET_FLG_VALUE(GF.FLAGS, 3) = 1';
//  end
//  else
//    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := '';
//  ibcquery1.Open;
end;

procedure Tframe106Convel.cbNoImagesPropertiesChange(Sender: TObject);
begin
  inherited;
//  ibcquery1.Close;
//  if cbFlgNoImage.Checked then begin
//    ibcquery1.MacroByName('HasNoImage').Value := 'and not exists(select * from TS_GOODS_IMAGE GI where GI.GOODSID = GF.GOODSID and coalesce(octet_length(GI.IMAGE), 0) > 0)';
//  end
//  else
//    ibcquery1.MacroByName('HasNoImage').Value := '';
//  ibcquery1.Open;
end;

function Tframe106Convel.ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;
var
  elCount: Integer;
  Elements: OleVariant;
  I: Integer;
  atag: OleVariant;
  imagepath: string;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  pngImage: TPngImage;
  PngImageStream: TMemoryStream;
begin
  PngImageStream := TMemoryStream.Create;

  try
    ImageStream.Position := 0;
    ImageStream.SaveToFile('bomba.jpeg');
    jpegImage := TJPEGImage.Create;
    bmpImage := TBitMap.Create;
    pngImage := TPngImage.Create;
    try
      jpegImage.loadfromFile('bomba.jpeg');
      bmpImage.Assign(jpegImage);
      pngImage.Assign(bmpImage);
      pngImage.SaveToStream(PngImageStream);
    finally
      jpegImage.Free;
      bmpImage.Free;
      pngImage.Free;
    end;
    result := PngImageStream;
  finally

  end;
end;

procedure Tframe106Convel.CreateNewRecord;
begin
end;

procedure Tframe106Convel.cxButton1Click(Sender: TObject);
var
  goodsUrl: string;
  cp: TConvelParser;
begin
//  IBCConnection1.Connect;
  IBCQuery1.Open;
  ProgressBar1.Max := ibcquery1.RecordCount;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  while not IBCQuery1.eof do
  begin
    goodsUrl := format('http://convel.md/index.php?productID=%s', [IBCQuery1.FieldByName('goods_code').AsString]);
    cp := TConvelParser.Create(Self, goodsUrl);
    try
      cp.DoParse;
      if (cp.ProductName <> '') and (cp.ImageUrl <> '') then
      begin
        try
          SaveData(IBCQuery1.FieldByName('goodsid').AsInteger, cp.ProductName, cp.ProductStockInfo,
            cp.ProductDescriptionRo, cp.ProductDescriptionRu, cp.ImageUrl);
          Application.ProcessMessages;
        except
          on e: Exception do

        end;
      end;

    finally
      FreeAndNil(cp);
    end;
    ProgressBar1.Position := ProgressBar1.Position + 1;
    IBCQuery1.Next;
  end;
end;

procedure Tframe106Convel.cxButton2Click(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgNoImage.Checked then
    IBCQuery1.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  else
    IBCQuery1.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then
    ibcquery1.MacroByName('FlgInPrice').Value := ' and get_flg_in_price(gf.goodsid) = 1'
  else
    ibcquery1.MacroByName('FlgInPrice').Value := '';

  ibcquery1.ParamByName('supplierid').AsInteger := supplierID;
  ibcquery1.Open;
end;

procedure Tframe106Convel.cxButton3Click(Sender: TObject);
var
  htmlbody: TStringList;
begin
  htmlbody := TStringlist.Create;
  try
    LoadPage('https://convel.md/?go=price_list', htmlbody);
    LoadDom(htmlbody.text);
    Application.ProcessMessages;
    sleep(50);
    ParsePriceList;
  finally
    htmlbody.Free;
  end;
end;

procedure Tframe106Convel.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe106Convel.DeleteRecord;
begin
end;

procedure Tframe106Convel.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe106Convel.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  IBCQuery1.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;

     // 4. Selection update
  SelectionChanged;
end;

function Tframe106Convel.GetCurrentSearchContext: TSearchContextValue;
begin
end;

function Tframe106Convel.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe106Convel.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
end;

function Tframe106Convel.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

procedure Tframe106Convel.GetParamsListForReport(const ParamsList: TStringList);
begin
//    ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe106Convel.GetParamValueForReport(const ParamName: string): Variant;
begin
//    if ParamName = 'FAST_MONEY_TRANSFER' then
//    begin
//        if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
//            Result := '1'
//        else
//            Result := '0';
//    end;
end;

procedure Tframe106Convel.LoadDom(htmlcode: string);
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

procedure Tframe106Convel.LoadPage(URL: string; var HtmlStrings: TStringList);
var
  MS: TMemoryStream;
  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10136';
    NetHTTPClient.GET(URL, MS);
    MS.Position := 0;
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    FreeAndNil(NetHTTPClient);
  end;
end;

function Tframe106Convel.GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
var
  detail: TProductDetailInfo;
  htmlbody: TStringList;
begin
  htmlbody := TStringList.Create;
  try
    LoadPage(ProductDetailUrl, htmlbody);
    LoadDom(htmlbody.Text);
    ParseDetailPage(result.DescriptionRo);
  finally
    htmlbody.Free;
  end;
end;

function Tframe106Convel.InitFrameID: Integer;
begin
  Result := 106;
end;

procedure Tframe106Convel.ModifyRecord;
begin
end;

procedure Tframe106Convel.ParseDetailPage(var DescriptionRo: string);
var
  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  cc: Integer;
  dd: IHTMLElement;
  i, k: Integer;
  s: string;
  j: Integer;
  cnt: Integer;
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
        // DescriptionRO
        s := Elements.item(i).id;
        if (Elements.item(i).id = 'item_view_desc') then
        begin

          if (cc > 0) then
            DescriptionRo := Elements.item(i).InnerText;
          Inc(cc);
        end;
      end;
    end;
  end;
end;

procedure Tframe106Convel.ParsePriceList;
var
  allDivs: OleVariant;
  cc: integer;
  Elements: OleVariant;
  td: OleVariant;
  tr: OleVariant;
  i, j, k: integer;
  PriceList: TList<TConvelPriceInfo>;
  ConvelInfo: TConvelPriceInfo;
begin
  allDivs := Body.All.Tags('table');

  PriceList := TList<TConvelPriceInfo>.Create;
  var s := '';
//  ImagePath := '';
  try
    for j := 0 to allDivs.Length - 1 do
    begin
      cc := 0;
      if (allDivs.item(j).ClassName = 'table table-striped') then
      begin
        tr := allDivs.item(j).getElementsByTagName('tr');
        for I := 0 to (tr.Length - 1) do
        begin
          td := tr.item(I).getElementsByTagName('td');
          for  k := 0 to td.length-1 do
          begin
            if td.item(k).ClassName='td_pricelist' then
            begin
              if k=0 then
              begin
                ConvelInfo.goods_code := td.item(k).innerText;
                continue;
              end;

              if k=1 then
              begin
                ConvelInfo.goods_url := stringreplace(td.item(1).getElementsByTagName('a').item(0).href, 'about:', 'https://convel.md/', []);
                ConvelInfo.goods_title := td.item(k).innerText;;
                continue;
              end;

              if k=2 then
              begin
                ConvelInfo.goods_brand := td.item(k).innerText;;
                Continue;
              end;
              if k=3 then
              begin
                ConvelInfo.goods_price := trim(StringReplace(td.item(k).innerText, 'MDL', '', []));
                continue
              end;
            end;
          end;
          if convelinfo.goods_code<>'' then
            PriceList.Add(ConvelInfo);
        end;
      end;
    end;

    if PriceList.Count>0 then
      SaveToDB(PriceList);

  finally
    //  ImagePath.Free;
    PriceList.Free;
  end;


end;

procedure Tframe106Convel.WhenPopupMenuPopup;
begin

end;

procedure Tframe106Convel.ReadFrameStates;
begin
end;

procedure Tframe106Convel.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe106Convel.SaveData(GoodsID: Integer; ProductName, ProductStockInfo,
  ProductDescriptionRo, ProductDescriptionRu, ProductImageUrl: string);
var
  ms: TMemoryStream;
  ibcsql: TIBCSQL;
begin
  ms := TMemoryStream.Create;
  httpClient := THttpClient.Create;
  ibcsql := TIBCSQL.Create(nil);
  try
    ibcsql.AutoCommit := False;
    NetHttpClient1.Get(ProductImageUrl, ms);

    ms.Position := 0;
    ms := ConvertImageToPNG(ms);
    ibcsql.SQL.Add('update or insert into TS_GOODS_IMAGE (GOODSID, goods_image_id, IMAGE) values (:GOODSID, 1, :IMAGE) matching (goodsid, goods_image_id)');
    ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
    ibcsql.ParamByName('Image').LoadFromStream(ms, ftBlob);
    ibcsql.Transaction := IBCtrLocalUpdate;

    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;
    ibcsql.Execute;

    ibcsql.SQL.Clear;
    ibcsql.SQL.Add('update or insert into  TS_GOODS_DSC (goodsid, description_ro) values(:goodsid, :desc_ro) matching (goodsid)');
    ibcsql.ParamByName('desc_ro').AsString := ProductDescriptionRo;
    ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
    ibcsql.Execute;

    ibcsql.SQL.Clear;
    ibcsql.SQL.Add('update or insert into  TS_GOODS (goodsid, code, code_ru) values(:goodsid, :code, :code) matching (goodsid)');
    ibcsql.ParamByName('code').AsString := ProductName;
    ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
    ibcsql.Execute;

    if IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.Commit;
  finally
    ibcsql.Free;
    ms.Free;
  end;
end;

procedure Tframe106Convel.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;
end;

procedure Tframe106Convel.SaveToDB(PriceList: TList<TConvelPriceInfo>);
var
  PLID: Integer;
  Query: TIBCQuery;
begin
  // Add record to table TS_PriceLists
  Query := TIBCQuery.Create(nil);
  IBCtrLocalUpdate := TIBCTransaction.Create(nil);

  try
    IBCtrLocalUpdate.DefaultConnection := dmdb.IBCConnection;

    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;

    Query.Transaction := IBCtrLocalUpdate;
    Query.Connection := dmdb.IBCConnection;
    Query.AutoCommit := false;
    Query.SQL.Clear;
    Query.SQL.Add('insert into TS_PRICELISTS (SUPPLIERID,');
    Query.SQL.Add('PRICE_CATEGORYID');
    Query.SQL.Add(')');
    Query.SQL.Add('values (:SUPPLIERID,');
    Query.SQL.Add(':PRICE_CATEGORYID');
    Query.SQL.Add(')');
    Query.SQL.Add('returning PLID');

    Query.ParamByName('SUPPLIERID').AsInteger := 229005;
    Query.ParamByName('PRICE_CATEGORYID').AsInteger := 34; // Generala
    Query.Options.ReturnParams := True;
    Query.ParamCheck := True;
    Query.Execute;

    PLID := Query.ParamByName('RET_PLID').AsInteger;
    IBCtrLocalUpdate.Commit;

  // add items to TS_PriceList_Items


    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;

    Query.SQL.Clear;
    Query.SQL.Add('insert into TS_PRICELIST_ITEMS (PLID,');
    Query.SQL.Add('SUPPLIER_GOODS_CODE,');
    Query.SQL.Add('SUPPLIER_GOODS_NAME,');

    Query.SQL.Add('PRICE3,');
    Query.SQL.Add('CURRENCY3ID,');

    Query.SQL.Add('PRICE7,');
    Query.SQL.Add('CURRENCY7ID,');
    Query.SQL.Add('PRICE0,');
    Query.SQL.Add('CURRENCY0ID)');

     // values
    Query.SQL.Add('values (:PLID,');
    Query.SQL.Add(':SUPPLIER_GOODS_CODE,');
    Query.SQL.Add(':SUPPLIER_GOODS_NAME,');

    Query.SQL.Add(':PRICE3,');
    Query.SQL.Add(':CURRENCY3ID,');
    Query.SQL.Add(':PRICE7,');
    Query.SQL.Add(':CURRENCY7ID,');
    Query.SQL.Add(':PRICE0,');
    Query.SQL.Add(':CURRENCY0ID)');

    for var i := 0 to PriceList.Count-1 do
    begin
      // daca este cantitate in care din stocuri atunci adaugam produsul in price

      Query.ParamByName('PLID').AsInteger := PLID;
      Query.ParamByName('SUPPLIER_GOODS_CODE').Value := PriceList[i].goods_code;
      Query.ParamByName('SUPPLIER_GOODS_NAME').Value := PriceList[i].goods_title;

      Query.ParamByName('PRICE3').AsString := Pricelist[i].goods_price;
      Query.ParamByName('CURRENCY3ID').AsInteger := 498;

      Query.ParamByName('PRICE7').AsFloat := StrToFloat(Pricelist[i].goods_price) / 1.10;
      Query.ParamByName('CURRENCY7ID').AsInteger := 498;

      Query.ParamByName('PRICE0').AsFloat := StrToFloat(Pricelist[i].goods_price) / 1.10;
      Query.ParamByName('CURRENCY0ID').AsInteger := 498;

      Query.ExecSQL;

    end;

    IBCtrLocalUpdate.Commit;
    MessageDlg('Lista de preturi a fost generata cu succes!', mtInformation, [mbOK], 0);

  finally
    Query.Free;
    IBCtrLocalUpdate.Free;
  end;
end;

procedure Tframe106Convel.SelectionChanged;
var
  fDocNew, fDocModify, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin
  fDocNew := fSYS_Add;     // New Document + Security
  fDocModify := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fCalcComs := False;

  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocModify);
  ButtonStateChanged(fbtDELETE, fDocDelete);
end;

procedure Tframe106Convel.SetupSecurityItems;
begin
  inherited;
end;

procedure Tframe106Convel.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


unit frame108LumeaInstrumentelorUnit;

// Lumeainstrumentelor.md Parser
// Frame Index = 108

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB,
  cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls,
  DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, dxBarBuiltInMenu,
  MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.Menus, cxButtons, MSHTML, cxContainer, Vcl.ComCtrls, MuncitorulParserUnit, dxUIAClasses;

const
  SupplierID = 281330;
  SearchUrl = 'https://lumeainstrumentelor.md/search?controller=search&orderby=position&orderway=desc&search-cat-select=0&search_query=%s&submit_search=';

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe108LumeaInstrumentelor = class(TSWNBaseFrame)
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCSQLGoods: TIBCSQL;
    cxGridSupplierGoods: TcxGrid;
    cxGridSupplierGoodsDBTableView1: TcxGridDBTableView;
    cxGridSupplierGoodsDBTableView1GOODSID: TcxGridDBColumn;
    cxGridSupplierGoodsDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridSupplierGoodsDBTableView1_GOODS_TITLE: TcxGridDBColumn;
    cxGridSupplierGoodsDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridSupplierGoodsLevel1: TcxGridLevel;
    Panel1: TPanel;
    Memo1: TMemo;
    Panel2: TPanel;
    cxButton1: TcxButton;
    cbFlgNoImage: TCheckBox;
    cbFlgInPRICE: TCheckBox;
    Label1: TLabel;
    IBCSQLDelete: TIBCSQL;
    cbUpdateAllImages: TCheckBox;
    cxButton2: TcxButton;
    ProgressBar1: TProgressBar;
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridSupplierGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbNoImagesPropertiesChange(Sender: TObject);
    procedure cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private    { Private declarations }
    Doc: IHTMLDocument2;
    Body: OleVariant;
    HttpClient: THTTPClient;
    htmlSource: TstringList;
    FDocumentProductPage: IHTMLDocument2;
    FDocumentBody: OleVariant;

    function ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;
    procedure DoParse(ProductCode: string);

    procedure LoadDom(htmlcode: string);
    procedure LoadPage(url: string; var HtmlStrings: TStringList);

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
    function PrepareGoodsCode(SearchString: string): string;
    procedure RefreshData; override;
    procedure SaveImageToDB(ImageURL: string);
    procedure SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);

  public    { Public declarations }
    procedure WhenParseProduct(AProduct: TWebProduct);
    function GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
    procedure ParseDetailPage(var DescriptionRo: string);
    procedure SaveData(GoodsID: Integer; ProductName, ProductStockInfo, ProductDescriptionRo, ProductDescriptionRu, ProductImageUrl: string);
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors,
  SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  System.IOUtils, System.Variants, Winapi.ActiveX,
  frame101WebscrapMuncitorulUnit,
  System.RegularExpressions;

{$R *.dfm}

procedure Tframe108LumeaInstrumentelor.cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgInPRICE.Checked then begin
    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := 'AND GET_FLG_VALUE(GF.FLAGS, 3) = 1';
  end
  else
    ibcquery1.MacroByName('HasFLG_IN_PRICE').Value := '';
  ibcquery1.Open;
end;

procedure Tframe108LumeaInstrumentelor.WhenParseProduct(AProduct: TWebProduct);
var
  i: Integer;
begin

end;

procedure Tframe108LumeaInstrumentelor.SaveImageToDB(ImageURL: string);
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
    if imagePath <> '' then begin
      NetHTTPClient1.Get(imagePath, ImageStream);
      Application.ProcessMessages;

      ImageStream.Position := 0;
      imgExt := TPath.GetExtension(imagePath);
      if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
        try
          ImageStream.SaveToFile('tmp.jpeg');
          jpegImage.loadfromFile('tmp.jpeg');
        except
          on e: Exception do begin
            IBCQuery1.Next;
            Memo1.Lines.Add(E.Message);
          end;
        end;
      end;

      if imgExt = '.png' then begin
        ImageStream.SaveToFile('tmp.png');
        pngImage := TPngImage.Create;
        pngImage.loadfromFile('tmp.png');
      end;

      bmpImage := TBitMap.Create;
      try
        bmpImage.Assign(jpegImage);
        try
          if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
            pngImage.Assign(bmpImage);
            pngImage.SaveToFile('tmp.png');
          end;
        except on e: Exception do begin
          Memo1.Lines.Add(e.Message);
        end;
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
      except on e: Exception do begin
        Memo1.LInes.Add(e.Message);
        IBCtrLocalUpdate.Rollback;
      end;
      end;
    end;
  finally
    Application.ProcessMessages;
    FreeAndNil(jpegImage);
    FreeAndNil(pngImage);
    ImageStream.Free;
  end;
end;

procedure Tframe108LumeaInstrumentelor.SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
begin
  if (trim(DescriptionRo) <> '') or (trim(DescriptionRu) <> '') then begin
    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;
    try
      IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').AsInteger;
      IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := DescriptionRo;
      IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := iif(DescriptionRu = '', DescriptionRo, DescriptionRu);
      IBCSQLGoods.Execute;
      IBCtrLocalUpdate.Commit;
    except
      IBCtrLocalUpdate.Rollback;
    end;
  end;
end;

procedure Tframe108LumeaInstrumentelor.cbNoImagesPropertiesChange(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgNoImage.Checked then begin
    ibcquery1.MacroByName('HasNoImage').Value := 'and not exists(select * from TS_GOODS_IMAGE GI where GI.GOODSID = GF.GOODSID and coalesce(octet_length(GI.IMAGE), 0) > 0)';
  end
  else
    ibcquery1.MacroByName('HasNoImage').Value := '';
  ibcquery1.Open;
end;

function Tframe108LumeaInstrumentelor.ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;
var
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  pngImage: TPngImage;
  PngImageStream: TMemoryStream;
begin
  PngImageStream := TMemoryStream.Create;

  try
    ImageStream.Position := 0;
    ImageStream.SaveToFile('tmp.jpeg');
    jpegImage := TJPEGImage.Create;
    bmpImage := TBitMap.Create;
    pngImage := TPngImage.Create;
    try
      jpegImage.loadfromFile('tmp.jpeg');
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

procedure Tframe108LumeaInstrumentelor.CreateNewRecord;
begin
end;

procedure Tframe108LumeaInstrumentelor.cxButton2Click(Sender: TObject);
begin
  ibcquery1.Close;
  if cbFlgNoImage.Checked then begin
    IBCQuery1.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    IBCQuery1.MacroByName('FlgNoImage').Value := '';

  ibcquery1.ParamByName('supplierid').AsInteger := SupplierID;
  ibcquery1.Open;

end;

function ExtractNumbers(const s: string): TArray<string>;
var
    regex: TRegEx;
    match: TMatch;
    matches: TMatchCollection;
    i: Integer;
begin
    Result := nil;
    i := 0;
    regex := TRegEx.Create('\d+');
    matches := regex.Matches(s);
    if matches.Count > 0 then
    begin
        SetLength(Result, matches.Count);
        for match in matches do
        begin
            Result[i] := match.Value;
            Inc(i);
        end;
    end;
end;

procedure Tframe108LumeaInstrumentelor.DoParse(ProductCode: string);
var
  ms: TMemoryStream;
  vs, vp: OleVariant;
  alldivs: OleVariant;
  cc: Integer;
  el2: OleVariant;
  elements: OleVariant;
  I: Integer;
  ImageList: TStringList;
  j: Integer;
  ProductUrl: string;
  s: string;
  k: Integer;
  ProductDescription: string;
  ProductPageURL: string;
begin
//  ProductCode := 'HECHT 1289';
//  productCode := ExtractNumbers(ProductCode)[0];
  Memo1.Lines.Add('Product code: '+ProductCode);
  ms := TMemoryStream.Create;
  try
    NetHTTPClient1.Get(format('https://lumeainstrumentelor.md/search?controller=search&orderby=position&orderway=desc&search-cat-select=0&search_query=%s&submit_search=', [StringReplace(ProductCode, ' ', '+', [])]), ms);
    ms.Position := 0;
    htmlSource.LoadfromStream(ms);
  finally
    ms.free;
  end;
  FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  FDocumentProductPage.designMode := 'on';
  vs := VarArrayCreate([0, 0], varVariant);
  vs[0] := htmlSource.Text;
  FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
  FDocumentBody := FDocumentProductPage.body;


  alldivs := FDocumentBody.All.Tags('a');
  for j := 0 to alldivs.Length - 1 do begin
    if alldivs.item(j).classname = 'product_img_link' then begin
      ProductPageURL := alldivs.item(j).href;
      break;
    end;
  end;

  // product detail page
  if (ProductPageURL <> '') then begin
    ms := TMemoryStream.Create;
    try
  //    NetHTTPClient1.Get('https://lumeainstrumentelor.md/hecht-1289-masina-de-gaurit-cu-acumulator.html?search_query=HECHT+1289&results=1', ms);
      NetHTTPClient1.Get(ProductPageURL, ms);
      ms.Position := 0;
      htmlSource.LoadfromStream(ms);
    finally
      ms.free;
    end;

    FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    FDocumentProductPage.designMode := 'on';
    vp := VarArrayCreate([0, 0], varVariant);
    vp[0] := htmlSource.Text;
    FDocumentProductPage.Write(PSafeArray(TVarData(vp).VArray)); // write data from IdHTTP
    FDocumentBody := FDocumentProductPage.body;

    alldivs := FDocumentBody.All.Tags('ul');
    s := '';
    for j := 0 to alldivs.Length - 1 do begin
      cc := 0;
      if (alldivs.item(j).ID = 'thumbs_list_frame') then begin
        elements := alldivs.item(j).getElementsByTagName('li');
        ImageList := TStringList.create;
        try
          for k := 0 to elements.Length - 1 do begin
            s := string(elements.item(k).OuterHTML);
            if string(elements.item(k).id).Contains('thumbnail') then begin
              el2 := elements.item(k).getElementsByTagName('a');
              ImageList.Add(el2.item(0).href);
              Memo1.Lines.add(el2.item(0).href);
              SaveImageToDB(el2.item(0).href);
            end;
          end;
        finally
          ImageList.Free;
        end;
        Break;
      end;
    end;

    alldivs := FDocumentBody.All.Tags('div');
    for I := 0 to alldivs.length - 1 do begin
      if string(alldivs.item(I).ID).contains('short_description_content') then begin
        ProductDescription := alldivs.item(I).InnerText;
        SaveDescriptionToDB(ProductDescription, ProductDescription);
        Break;
      end;
//      if string(alldivs.item(i).ClassName).contains('rte') then begin
//        ProductDescription := ProductDescription +'<br>' + alldivs.item(i).innerText;
//        Break;
//      end;
    end;
    Memo1.Lines.Add(ProductDescription);
    MEmo1.Lines.Add('-------------------------------------------------------------------');
  end;

end;

procedure Tframe108LumeaInstrumentelor.cxButton1Click(Sender: TObject);
var
  parser: TLumeaInstrumentelorParser;
  LProductCode: string;
  ProductUrlRo: string;
  ProductUrlRu: string;
begin
  ProgressBar1.Max := ibcquery1.RecordCount;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  while not IBCQuery1.Eof do begin
    DoParse(ibcquery1.FieldByName('GOODS_CODE').AsString);
    IBCQuery1.Next;
    ProgressBar1.Position := ProgressBar1.Position + 1;
    Application.ProcessMessages;


//    if ibcquery1.RecNo > 1 then
//      break;
  end;
end;

procedure Tframe108LumeaInstrumentelor.cxGridSupplierGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridSupplierGoodsDBTableView1, Key, Shift);
end;

procedure Tframe108LumeaInstrumentelor.DeleteRecord;
begin

end;

procedure Tframe108LumeaInstrumentelor.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;
  if assigned(htmlSource) then
    htmlSource.Free;
  inherited;
end;

procedure Tframe108LumeaInstrumentelor.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  // 1. Legam grid-urile de datasource-sele
  cxGridSupplierGoodsDBTableView1.DataController.DataSource := IBCDataSource1;
  IBCQuery1.Open;
  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;
  HtmlSource := TStringlist.Create;
end;

function Tframe108LumeaInstrumentelor.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe108LumeaInstrumentelor.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
  Result := [];
end;

function Tframe108LumeaInstrumentelor.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

procedure Tframe108LumeaInstrumentelor.LoadDom(htmlcode: string);
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

procedure Tframe108LumeaInstrumentelor.LoadPage(URL: string; var HtmlStrings: TStringList);
var
  MS: TMemoryStream;
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
    FreeAndNil(NetHTTPClient);
  end;
end;

function Tframe108LumeaInstrumentelor.GetProductDetailInfo(ProductDetailUrl: string): TProductDetailInfo;
var
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

function Tframe108LumeaInstrumentelor.InitFrameID: Integer;
begin
  Result := 108;
end;

procedure Tframe108LumeaInstrumentelor.ModifyRecord;
begin
  Exit;
end;

procedure Tframe108LumeaInstrumentelor.ParseDetailPage(var DescriptionRo: string);
var
  allDivs, Elements: OleVariant;
  cc: Integer;
  i, j: Integer;
  productUrl: string;
  s: string;
begin
  allDivs := Body.All.Tags('a');
  s := '';
//  ImagePath := '';
  for j := 0 to allDivs.Length - 1 do begin
    cc := 0;
    if (allDivs.item(j).ClassName = 'product_img_link') then begin
        // DescriptionRO
      productUrl := Elements.item(i).href;
      break;
    end;
  end;

//  ParseProductPage(productURL);
end;

function Tframe108LumeaInstrumentelor.PrepareGoodsCode(SearchString: string): string;
begin
  Result := StringReplace(SearchString, ' ', '+', []);
end;

procedure Tframe108LumeaInstrumentelor.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe108LumeaInstrumentelor.SaveData(GoodsID: Integer; ProductName, ProductStockInfo, ProductDescriptionRo, ProductDescriptionRu, ProductImageUrl: string);
var
  ms: TMemoryStream;
  ibcsql: TIBCSQL;
begin
  ms := TMemoryStream.Create;
  ibcsql := TIBCSQL.Create(nil);
  try
    ibcsql.AutoCommit := False;
    HttpClient.Get(ProductImageUrl, ms);

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

end.


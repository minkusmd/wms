unit frame109SnaigeUnit;

// snaige.md parser
// Frame Index = 109

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
  Vcl.Menus, cxButtons, MSHTML, cxContainer, Vcl.ComCtrls, dxUIAClasses;

const
  SupplierID = 74995;   // AIEA

type
  Tframe109SnaigeAPI = class(TSWNBaseFrame)
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
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
    procedure cxButton2Click(Sender: TObject);
  private    { Private declarations }
    Doc: IHTMLDocument2;
//    Body: OleVariant;
//    HttpClient: THTTPClient;
    htmlSource: TStringList;
    FDocumentProductPage: IHTMLDocument2;
    FDocumentBody: OleVariant;
// TODO: ConvertImageToPNG
//  function ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;

    procedure DoParse(ProductCode: string);
    procedure SaveImageToDB(ImageURL: string);
    procedure SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure DeleteRecord; override;
    procedure RefreshData; override;

  public    { Public declarations }
// TODO: SaveData
//  procedure SaveData(ProductDescriptionRo, ProductDescriptionRu, ProductImageUrl:
//      string);
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors,
  SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  System.IOUtils, System.Variants, Winapi.ActiveX, frmParsersUnit;

{$R *.dfm}

procedure Tframe109SnaigeAPI.DoParse(ProductCode: string);
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
//  ProductCode := '39445';
  ms := TMemoryStream.Create;
  try
    NetHTTPClient1.Get(format('https://snaige.md/index.php?route=product/search&search=%s', [ProductCode]), ms);
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

  alldivs := FDocumentBody.All.Tags('div');
  for j := 0 to alldivs.Length - 1 do begin
    if string(alldivs.item(j).ClassName).Contains('product-thumb') then begin
      elements := alldivs.item(j).getElementsByTagName('a');
      if elements.Length > 0 then begin
        ProductPageURL := elements.item(0).href;
        Memo1.Lines.Add(ProductPageURL);
        Break;
      end;
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
//    Memo1.Lines.Clear;
    FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    FDocumentProductPage.designMode := 'on';
    vp := VarArrayCreate([0, 0], varVariant);
    vp[0] := htmlSource.Text;
    FDocumentProductPage.Write(PSafeArray(TVarData(vp).VArray)); // write data from IdHTTP
    FDocumentBody := FDocumentProductPage.body;

    alldivs := FDocumentBody.All.Tags('div');
    s := '';
    for j := 0 to alldivs.Length - 1 do begin
      cc := 0;
      if (alldivs.item(j).ClassName = 'productbg') then begin
        el2 := alldivs.item(j).getElementsByTagName('a');
        ImageList := TStringList.create;
        try
          for I := 0 to el2.Length - 1 do begin
            if el2.item(I).ClassName = 'thumbnail' then begin
              ImageList.Add(UTF8Encode(el2.item(I).href));
              Memo1.Lines.add(UTF8Encode(el2.item(I).href));
              SaveImageToDB(UTF8Encode(el2.item(I).href));
              Break;
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
      if string(alldivs.item(I).ID).contains('tab-specification') then begin
        ProductDescription := UTF8Decode(alldivs.item(I).InnerHTML);
        Break;
      end;
    end;
    Memo1.Lines.Add(ProductDescription);
    SaveDescriptionToDB(ProductDescription, ProductDescription);
  end;
end;

procedure Tframe109SnaigeAPI.cxButton1Click(Sender: TObject);
var
  goodsUrl: string;
  cp: TCatolParser;
begin
//  IBCConnection1.Connect;
  IBCQueryGoods.Open;
  ProgressBar1.Max := IBCQueryGoods.RecordCount;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  while not IBCQueryGoods.eof do begin
    DoParse(IBCQueryGoods.FieldByName('goods_code').AsString);
    ProgressBar1.Position := ProgressBar1.Position + 1;
    IBCQueryGoods.Next;
    Application.ProcessMessages;
//    Break;
  end;
end;

procedure Tframe109SnaigeAPI.cxButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryGoods.Close;
  if cbFlgNoImage.Checked then begin
    IBCQueryGoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    IBCQueryGoods.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then begin
    IBCQueryGoods.MacroByName('FlgInPrice').Value := ' and get_flg_value(flags,3)=1'
  end
  else
    IBCQueryGoods.MacroByName('FlgInPrice').Value := '';

  IBCQueryGoods.ParamByName('supplierid').AsInteger := SupplierID;
  IBCQueryGoods.Open;
end;

procedure Tframe109SnaigeAPI.cxGridSupplierGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridSupplierGoodsDBTableView1, Key, Shift);
end;

procedure Tframe109SnaigeAPI.DeleteRecord;
begin

end;

procedure Tframe109SnaigeAPI.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQueryGoods.Close;
  if Assigned(htmlSource) then
    htmlSource.Free;

  inherited;
end;

procedure Tframe109SnaigeAPI.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  // 1. Legam grid-urile de datasource-sele
  cxGridSupplierGoodsDBTableView1.DataController.DataSource := IBCDataSourceGoods;
  IBCQueryGoods.Open;
  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
//  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;
  htmlSource := TStringList.Create;
end;

function Tframe109SnaigeAPI.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe109SnaigeAPI.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
  Result := [];
end;

function Tframe109SnaigeAPI.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe109SnaigeAPI.InitFrameID: Integer;
begin
  Result := 109;
  NetHTTPClient1.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
//  NetHTTPClient1.ContentType := '';
  NetHTTPClient1.AcceptCharSet := 'UTF-8';
end;

procedure Tframe109SnaigeAPI.RefreshData;
begin
  inherited;
  IBCQueryGoods.Refresh;
end;

procedure Tframe109SnaigeAPI.SaveImageToDB(ImageURL: string);
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
            IBCQueryGoods.Next;
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
        except
          on e: Exception do begin
            Memo1.Lines.Add(e.Message);
          end;
        end;
      finally
        bmpImage.Free;
      end;

      if not IBCtrLocalUpdate.Active then
        IBCtrLocalUpdate.StartTransaction;
      try
        IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').ASInteger;
        IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
        IBCSQL1.Execute;
        IBCtrLocalUpdate.Commit;
        DeleteFile('tmp.png');
      except
        on e: Exception do begin
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

procedure Tframe109SnaigeAPI.SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
begin
  if (Trim(DescriptionRo) <> '') or (Trim(DescriptionRu) <> '') then begin
    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;
    try
      IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
      IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := DescriptionRo;
      IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := iif(DescriptionRu = '', DescriptionRo, DescriptionRu);
      IBCSQLGoods.Execute;
      IBCtrLocalUpdate.Commit;
    except
      IBCtrLocalUpdate.Rollback;
    end;
  end;
end;

end.


unit frame107CatolUnit;

// Volta.md Parser
// Frame Index = 105

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
  swnImages, Vcl.Menus, cxButtons, MSHTML, cxContainer, Vcl.ComCtrls, dxUIAClasses;


const
  SupplierID = 159948;

type

  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe107Catol = class(TSWNBaseFrame)
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
    btnStop: TButton;
    procedure btnStopClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridSupplierGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbNoImagesPropertiesChange(Sender: TObject);
    procedure cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private    { Private declarations }
    Doc: IHTMLDocument2;
//    Body: OleVariant;
//    HttpClient: THTTPClient;
    htmlSource: TStringList;
    FDocumentProductPage: IHTMLDocument2;
    FDocumentBody: OleVariant;
    flgWorking: Boolean;
// TODO: ConvertImageToPNG
//  function ConvertImageToPNG(ImageStream: TMemoryStream): TMemoryStream;

    procedure DoParse(ProductCode: String);
    procedure SaveImageToDB1(ImageURL: string; UpdateTransaction: TibcTransaction);
    procedure SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
    procedure CallbackImage(S: string);
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

procedure Tframe107Catol.btnStopClick(Sender: TObject);
begin
  inherited;
  flgWorking := false;
  btnStop.Enabled := False;
end;

procedure Tframe107Catol.CallbackImage(S: string);
begin
  Memo1.Lines.Add(s);
end;

procedure Tframe107Catol.cbFLG_IN_PRICEPropertiesEditValueChanged(Sender: TObject);
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

procedure Tframe107Catol.cbNoImagesPropertiesChange(Sender: TObject);
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

procedure Tframe107Catol.CreateNewRecord;
begin
end;

procedure Tframe107Catol.DoParse(ProductCode:String);
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
  swnImages1: TswnImages;
begin
//  ProductCode := '39445';
  ms := TMemoryStream.Create;
  try
    NetHTTPClient1.Get(format('https://catollux.md/ru/?match=all&subcats=Y&pcode_from_q=Y&pshort=Y&pfull=Y&pname=Y&pkeywords=Y&search_performed=Y&q=%s&dispatch=products.search', [ProductCode]), ms);
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
    if alldivs.item(j).classname = 'ut2-gl__image' then
    begin
      elements := alldivs.item(j).getElementsByTagName('a');
      ProductPageURL := elements.item(0).href;
      Memo1.Lines.Add(ProductPageURL);
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
//    Memo1.Lines.Clear;
//        for j := 0 to alldivs.Length - 1 do begin
//          Memo1.Lines.Add(alldivs.item(j).ClassName);
//        end;
//    exit;
    for j := 0 to alldivs.Length - 1 do begin
      cc := 0;
      s := alldivs.item(j).ClassName;
      if alldivs.item(j).ClassName= 'ty-product-img cm-preview-wrapper' then begin
        elements := alldivs.item(j).getElementsByTagName('a');
        for i:=0 to elements.length - 1 do begin
          if elements.item(i).ClassName = 'cm-image-previewer cm-previewer ty-previewer' then begin
            ImageList := TStringList.create;
            try
//              for k := 0 to elements.Length - 1 do begin
                  el2 := elements.item(i).getElementsByTagName('img');
                  ImageList.Add(elements.item(i).src);
                  Memo1.Lines.add(elements.item(i).src);
                  swnImages1 := TswnImages.Create;
                  swnImages1.SaveFileToPng(ibctrlocalupdate, IBCQuery1.FieldByName('GOODSID').AsInteger, elements.item(i).src, 'tmp.png', CallbackImage);
                  swnImages1.Free;
            finally
              ImageList.Free;
            end;
            Break;
          end;
        end;
      end;
    end;

    alldivs := FDocumentBody.All.Tags('div');
    for i := 0 to alldivs.length-1 do begin
      if string(alldivs.item(i).ID).contains('owl-item active') then begin
        ProductDescription := alldivs.item(i).InnerText;

        Break;
      end;
    end;
    Memo1.Lines.Add(ProductDescription);
    SaveDescriptionToDB(ProductDescription, ProductDescription);
  end;
end;

procedure Tframe107Catol.cxButton1Click(Sender: TObject);
var
  goodsUrl: string;
  cp: TCatolParser;
begin
//  IBCConnection1.Connect;
  btnStop.Enabled := True;
  flgWorking := True;
  IBCQuery1.Open;
  ProgressBar1.Max := ibcquery1.RecordCount;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  while (not IBCQuery1.Eof) and flgWorking do begin
    DoParse(ibcquery1.FieldByName('goods_code').AsString);
    ProgressBar1.Position := ProgressBar1.Position + 1;
    IBCQuery1.Next;
    Application.ProcessMessages;
  end;
end;

procedure Tframe107Catol.cxButton2Click(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgNoImage.Checked then begin
    IBCQuery1.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    IBCQuery1.MacroByName('FlgNoImage').Value := '';
  if cbFlgInPRICE.Checked then
    IBCQuery1.MacroByName('FlgInPrice').Value := 'and get_flg_in_price(goodsid)=1'
  else
    IBCQuery1.MacroByName('FlgInPrice').Value := '';

  ibcquery1.ParamByName('supplierid').AsInteger := SupplierID;
  ibcquery1.Open;
end;

procedure Tframe107Catol.cxGridSupplierGoodsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridSupplierGoodsDBTableView1, Key, Shift);
end;

procedure Tframe107Catol.DeleteRecord;
begin

end;

procedure Tframe107Catol.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;
  if Assigned(htmlSource) then
    htmlSource.Free;

  inherited;
end;

procedure Tframe107Catol.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  // 1. Legam grid-urile de datasource-sele
  cxGridSupplierGoodsDBTableView1.DataController.DataSource := IBCDataSource1;
  IBCQuery1.Open;
  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;
  htmlSource := TStringlist.Create;
end;

function Tframe107Catol.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe107Catol.GetFilterFields: TFrameFilterFields;
begin
//    Result := [ffDate, ffCustomer];
  Result := [];
end;

function Tframe107Catol.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe107Catol.InitFrameID: Integer;
begin
  Result := 107;
end;

procedure Tframe107Catol.ModifyRecord;
begin
  Exit;
end;

procedure Tframe107Catol.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

// TODO: SaveData
//procedure Tframe107Catol.SaveData(ProductDescriptionRo, ProductDescriptionRu,
//  ProductImageUrl: string);
//var
//ms: TMemoryStream;
//ibcsql: TIBCSQL;
//begin
//ms := TMemoryStream.Create;
//ibcsql := TIBCSQL.Create(nil);
//try
//  ibcsql.AutoCommit := False;
//  HttpClient.Get(ProductImageUrl, ms);
//
//  ms.Position := 0;
//  ms := ConvertImageToPNG(ms);
//  ibcsql.SQL.Add('update or insert into TS_GOODS_IMAGE (GOODSID, goods_image_id, IMAGE) values (:GOODSID, 1, :IMAGE) matching (goodsid, goods_image_id)');
//  ibcsql.ParamByName('goodsid').AsInteger := IBCQuery1.FieldByName('goodsid').AsInteger;
//  ibcsql.ParamByName('Image').LoadFromStream(ms, ftBlob);
//  ibcsql.Transaction := IBCtrLocalUpdate;
//
//  if not IBCtrLocalUpdate.Active then
//    IBCtrLocalUpdate.StartTransaction;
//  ibcsql.Execute;
//
//  ibcsql.SQL.Clear;
//  ibcsql.SQL.Add('update or insert into  TS_GOODS_DSC (goodsid, description_ro) values(:goodsid, :desc_ro) matching (goodsid)');
//  ibcsql.ParamByName('desc_ro').AsString := ProductDescriptionRo;
//  ibcsql.ParamByName('goodsid').AsInteger := IBCQuery1.FieldByName('goodsid').AsInteger;
//  ibcsql.Execute;
//
////    ibcsql.SQL.Clear;
////    ibcsql.SQL.Add('update or insert into  TS_GOODS (goodsid, code, code_ru) values(:goodsid, :code, :code) matching (goodsid)');
////    ibcsql.ParamByName('code').AsString := ProductName;
////    ibcsql.ParamByName('goodsid').AsInteger := IBCQuery1.FieldByName('goodsid').AsInteger;
////    ibcsql.Execute;
//
//  if IBCtrLocalUpdate.Active then
//    IBCtrLocalUpdate.Commit;
//finally
//  ibcsql.Free;
//  ms.Free;
//end;
//end;

procedure Tframe107Catol.SaveImageToDB1(ImageURL: string; UpdateTransaction: TibcTransaction);
var
  imagePath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  ibcSQL: TIBCSQL;
  imgExt: string;
  pngImage: TPngImage;
begin
  ImageStream := TMemoryStream.Create;
  pngImage := TPngImage.Create;
  jpegImage := TJPEGImage.Create;
  ibcSQL := TIBCSQL.Create(nil);
  imagePath := Trim(ImageURL);
  try
    ibcsql.sql.text := 'insert into ts_goods_image (goodsid, image) ' +
                       'values(:goodsid, :image)';
    ibcsql.Transaction := UpdateTransaction;
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

      if not UpdateTransaction.Active then
        UpdateTransaction.StartTransaction;
      try
        IBCSQL.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').ASInteger;
        IBCSQL.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
        IBCSQL.Execute;
        UpdateTransaction.Commit;
        DeleteFile('tmp.png');
      except on e: Exception do begin
        Memo1.LInes.Add(e.Message);
        UpdateTransaction.Rollback;
      end;
      end;
    end;
  finally
    Application.ProcessMessages;
    FreeAndNil(jpegImage);
    FreeAndNil(pngImage);
    ImageStream.Free;
    ibcsql.free;
  end;
end;

procedure Tframe107Catol.SaveDescriptionToDB(DescriptionRo, DescriptionRu: string);
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


end.

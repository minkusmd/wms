unit frame110BombaUnit;

// Bomba.md Parser
// Frame Index = 110

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
  Vcl.Menus, cxButtons, MSHTML, cxContainer, dxUIAClasses;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe110BombaAPI = class(TSWNBaseFrame)
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCSQLGoods: TIBCSQL;
    cxGridVolta: TcxGrid;
    cxGridVoltaDBTableView1: TcxGridDBTableView;
    cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn;
    cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn;
    cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridVoltaLevel1: TcxGridLevel;
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
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton2Click(Sender: TObject);
  private    { Private declarations }
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

    Doc: IHTMLDocument2;
//    d: HTMLLIElement;
    Body: OleVariant;

// TODO: WhenDocGrid_FocusedRecordChanged
//  procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure SaveImagesToDB(var ImageStream: TMemoryStream; ImagesUrl: TStringList);
// TODO: SaveDescriptionToDB
//  procedure SaveDescriptionToDB(Parser: TVoltaParser; ProductDetailUrl: string);
    procedure DeleteCurrentImageFromDB(ImagesUrl: TStringList);
    procedure DoParseStep(AMessage: string);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    procedure RefreshData; override;

  public    { Public declarations }
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors,
  SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  System.IOUtils, System.Variants, Winapi.ActiveX, frmVoltaParserUnit,
  Vcl.WebpImage, Winapi.GDIPOBJ, WebpHelpers, libwebp, uLoadProductImages;

{$R *.dfm}

procedure Tframe110BombaAPI.Button1Click(Sender: TObject);
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Nethttpclient1.Get(format('https://bomba.md/ro/product/%s/', ['473282']), ms);
    ms.Position := 0;
    Memo1.Lines.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;

procedure Tframe110BombaAPI.DoParseStep(AMessage: string);
begin
  Memo1.Lines.Add(AMessage);
end;

procedure Tframe110BombaAPI.cxButton1Click(Sender: TObject);
var
  ProductImages: TLoadBombaProductImages;
begin
  while not IBCQuery1.Eof do begin
    ProductImages := TLoadBombaProductImages.Create(dmdb.IBCConnection);
    productimages.OnParseStep := DoParseStep;
    ProductImages.LoadImages(IBCQuery1.FieldByName('GOODSID').AsInteger, IBCQuery1.FieldByName('GOODS_CODE').AsString);
    Memo1.Lines.Add('------------------------------------------');
    IBCQuery1.Next;
    ibcquery1.last;
    Application.ProcessMessages;
  end;
end;

procedure Tframe110BombaAPI.cxButton2Click(Sender: TObject);
begin
  inherited;
  ibcquery1.Close;
  if cbFlgNoImage.Checked then begin
    IBCQuery1.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    IBCQuery1.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then begin
    IBCQuery1.MacroByName('FlgInPrice').Value := ' and get_flg_value(flags,3)=1';
  end
  else
    IBCQuery1.MacroByName('FlgInPrice').Value := '';


  ibcquery1.Open;
end;

procedure Tframe110BombaAPI.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe110BombaAPI.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe110BombaAPI.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

function Tframe110BombaAPI.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe110BombaAPI.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe110BombaAPI.InitFrameID: Integer;
begin
  Result := 110;
end;

procedure Tframe110BombaAPI.DeleteCurrentImageFromDB(ImagesUrl: TStringList);
begin
  if (cbUpdateAllImages.Checked and (ImagesUrl.Count - 1 > 0)) then
  begin
    // daca sunt imagini pe site atunci stergem imaginile locale
    Memo1.Lines.Add('delete current images...');
    if not IBCSQLDelete.Transaction.Active then
      IBCSQLDelete.Transaction.StartTransaction;
    ibcsqldelete.SQL.Text := 'delete from ts_goods_image where goodsid = :goodsid';
    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
    ibcsqlDelete.Execute;
    ibcsqldelete.SQL.Text := 'delete from ts_goods_dsc where goodsid = :goodsid';
    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
    ibcsqlDelete.Execute;
    ibcsqlDelete.Transaction.Commit;
  end;
end;

// TODO: SaveDescriptionToDB
//procedure Tframe110BombaAPI.SaveDescriptionToDB(Parser: TVoltaParser; ProductDetailUrl: string);
//begin
//if ProductDetailUrl <> '' then
//begin
//  Parser.DoParseDetailPageRO(ProductDetailUrl);
//  ProductDetailUrl := StringReplace(ProductDetailUrl, 'https://volta.md', 'https://volta.md/ru', []);
//  Parser.DoParseDetailPageRU(ProductDetailUrl);
//  if (Trim(Parser.DescriptionRo) <> '') then
//  begin
//    if not IBCtrLocalUpdate.Active then
//      IBCtrLocalUpdate.StartTransaction;
//    try
//      IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').AsInteger;
//      IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := UTF8ToString(Parser.DescriptionRO);
//      IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := UTF8ToString(Parser.DescriptionRU);
//      Memo1.Lines.Add('Add descriptions...');
//      IBCSQLGoods.Execute;
//      IBCtrLocalUpdate.Commit;
//    except
//      IBCtrLocalUpdate.Rollback;
//    end;
//  end;
//end
//else
//  Memo1.Lines.Add('Product: ' + IBCQuery1.FieldByName('GOODS_CODE').AsString + ' not found on www.volta.md...');
//end;

procedure Tframe110BombaAPI.SaveImagesToDB(var ImageStream: TMemoryStream; ImagesUrl: TStringList);
var
  I: Integer;
  pngImage: TPngImage;
  jpegImage: TJPEGImage;
  webpImage: TWebpImage;
  imgExt: string;
  fs: TFileStream;
  dat: PByte;
  bmp: TGPBitmap;
  bmpImage: TBitmap;
begin
  for I := 0 to ImagesUrl.Count - 1 do
  begin
    // convert image to png
    pngImage := TPngImage.Create;
    jpegImage := TJPEGImage.Create;
    webpImage := TWebpImage.Create(Panel2);
    //
    try
      if ImagesUrl[I] <> '' then
      begin
        NetHTTPClient1.Get(ImagesUrl[I], ImageStream);
        Application.ProcessMessages;
        ImageStream.Position := 0;
        imgExt := TPath.GetExtension(ImagesUrl[I]).tolower;
        if (imgExt = '.jpeg') or (imgExt = '.jpg') then
        begin
          try
            ImageStream.SaveToFile('tmp.jpeg');
            jpegImage := TJPEGImage.Create;
            jpegImage.loadfromFile('tmp.jpeg');
          except
            on e: Exception do
            begin
              IBCQuery1.Next;
              Continue;
            end;
          end;
        end;
        if imgExt = '.png' then
        begin
          ImageStream.SaveToFile('tmp.png');
          //              pngImage := TPngImage.Create;
          pngImage.loadfromFile('tmp.png');
        end;
        if imgExt = '.webp' then
        begin
          ImageStream.SaveToFile('tmp.webp');
          fs := TFileStream.Create('tmp.webp', fmOpenRead);
          WebpDecode(ImageStream, dat, bmp);
          bmp.Save('tmp.png', gPNG);
          bmp.Free;
          WebPFree(dat);
          fs.Free;
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
      FreeAndNil(jpegImage);
      FreeAndNil(pngImage);
    end;
  end;
end;

procedure Tframe110BombaAPI.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe110BombaAPI.SelectionChanged;
var
  fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin

  ButtonStateChanged(fbtADD, false);
  ButtonStateChanged(fbtMODIFY, false);
  ButtonStateChanged(fbtDELETE, false);
end;

end.


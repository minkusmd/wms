unit frame116ComputerUniverseUnit;

// EuroTerm Parser
// Frame Index = 116

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
  cxTextEdit, cxGroupBox, dxUIAClasses;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe116ComputerUniverse = class(TSWNBaseFrame)
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
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
    btnStart: TcxButton;
    Label1: TLabel;
    IBCSQLDelete: TIBCSQL;
    cxGroupBox1: TcxGroupBox;
    ckbFlgNoDescription: TCheckBox;
    cbFlgNoImage: TCheckBox;
    cbFlgInPRICE: TCheckBox;
    btnOpenDataSet: TcxButton;
    procedure Button1Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOpenDataSetClick(Sender: TObject);
  private    { Private declarations }
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

//    Doc: IHTMLDocument2;
//    d: HTMLLIElement;
    Body: OleVariant;

// TODO: WhenDocGrid_FocusedRecordChanged
//  procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
//    procedure SaveImagesToDB(var ImageStream: TMemoryStream; ImagesUrl: TStringList);
// TODO: SaveDescriptionToDB
//  procedure SaveDescriptionToDB(Parser: TVoltaParser; ProductDetailUrl: string);
//    procedure DeleteCurrentImageFromDB(ImagesUrl: TStringList);
//    procedure DoWebParseSync(AMessage: string);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    procedure RefreshData; override;

  public    { Public declarations }
    procedure ParseDetailPage(GoodsID: Integer);

  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit,
  SWNSecurity, SWNSecurityFlags, frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog,
  frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.IOUtils, System.Variants,
  Winapi.ActiveX, frmVoltaParserUnit, Vcl.WebpImage, Winapi.GDIPOBJ, WebpHelpers, libwebp,
  {uLoadProductImages,} WebProductImagesUnit, SWNParseUtils;

{$R *.dfm}

procedure Tframe116ComputerUniverse.Button1Click(Sender: TObject);
begin

end;
//procedure Tframe113EuroTerm.DoWebParseSync(AMessage: string);
//begin
//  Memo1.Lines.Add(AMessage);
//end;

procedure Tframe116ComputerUniverse.btnStartClick(Sender: TObject);
var
  a1Elements: OleVariant;
  bmpImage: TBitMap;
  divElements: OleVariant;
  fExt: string;
  jpegImage: TJPEGImage;
  ms: TMemoryStream;
  pngImage: TPNGImage;
  ps: TSWNParse;
  Specifications: string;
  SpecificationList: TStringList;
  I: Integer;
  J: Integer;
begin

  while not IBCQueryGoods.Eof do
  begin
    SpecificationList := TStringList.Create;
    ps := TSWNParse.Create;
    try
      ps.LoadPage(format('https://www.computeruniverse.net/ru/p/%s', [IBCQueryGoods.FieldByName('GOODS_CODE').AsString]));
      Body := ps.LoadDom;
      sleep(3000);
      divElements := Body.GetElementsbyTagName('div');
      ShowMessage(IntToStr(divElements.Length - 1));
      for I := 0 to divElements.Length - 1 do
      begin
        if divElements.items(I).ClassName = 'specification__list' then
        begin
          a1Elements := divElements.items(I).GetElementbyTagName('li');
          for J := 0 to a1Elements.Length - 1 do
          begin
            if (a1Elements.items(J).ClassName = 'flex w-full') then
            begin
              SpecificationList.Add(a1Elements.items(J).OuterHTML);
            end;
          end;
        end;
      end;

      Memo1.Lines.Add(SpecificationList.Text);
    finally
      ps.Free;
      SpecificationList.Free;
    end;

//      IBCQueryGoods.Next;
    IBCQueryGoods.Last;
    Application.ProcessMessages;
  end;
end;

procedure Tframe116ComputerUniverse.btnOpenDataSetClick(Sender: TObject);
begin
  inherited;
  ibcqueryGoods.Close;
  if cbFlgNoImage.Checked then
  begin
    ibcqueryGoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
  end
  else
    ibcqueryGoods.MacroByName('FlgNoImage').Value := '';

  if cbFlgInPRICE.Checked then
  begin
    ibcqueryGoods.MacroByName('FlgInPrice').Value := ' and get_flg_value(flags,3)=1';
  end
  else
    ibcqueryGoods.MacroByName('FlgInPrice').Value := '';

  if ckbFlgNoDescription.Checked then
  begin
    ibcqueryGoods.MacroByName('FlgNoDescription').Value := ' and ';
  end
  else
    ibcqueryGoods.MacroByName('FlgInPrice').Value := '';

  ibcqueryGoods.Open;
end;

procedure Tframe116ComputerUniverse.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe116ComputerUniverse.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  ibcqueryGoods.Close;

  inherited;
end;

procedure Tframe116ComputerUniverse.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  ibcqueryGoods.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  Memo1.Lines.Clear;

     // 4. Selection update
  SelectionChanged;
end;

function Tframe116ComputerUniverse.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe116ComputerUniverse.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe116ComputerUniverse.InitFrameID: Integer;
begin
  Result := 116;
end;

//procedure Tframe113EuroTerm.DeleteCurrentImageFromDB(ImagesUrl: TStringList);
//begin
//  if (cbUpdateAllImages.Checked and (ImagesUrl.Count - 1 > 0)) then begin
//    // daca sunt imagini pe site atunci stergem imaginile locale
//    Memo1.Lines.Add('delete current images...');
//    if not IBCSQLDelete.Transaction.Active then
//      IBCSQLDelete.Transaction.StartTransaction;
//    ibcsqldelete.SQL.Text := 'delete from ts_goods_image where goodsid = :goodsid';
//    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
//    ibcsqlDelete.Execute;
//    ibcsqldelete.SQL.Text := 'delete from ts_goods_dsc where goodsid = :goodsid';
//    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
//    ibcsqlDelete.Execute;
//    ibcsqlDelete.Transaction.Commit;
//  end;
//end;

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

//procedure Tframe113EuroTerm.SaveImagesToDB(var ImageStream: TMemoryStream; ImagesUrl: TStringList);
//var
//  I: Integer;
//  pngImage: TPngImage;
//  jpegImage: TJPEGImage;
//  webpImage: TWebpImage;
//  imgExt: string;
//  fs: TFileStream;
//  dat: PByte;
//  bmp: TGPBitmap;
//  bmpImage: TBitmap;
//begin
//  for I := 0 to ImagesUrl.Count - 1 do begin
//    // convert image to png
//    pngImage := TPngImage.Create;
//    jpegImage := TJPEGImage.Create;
//    webpImage := TWebpImage.Create(Panel2);
//    //
//    try
//      if ImagesUrl[I] <> '' then begin
//        NetHTTPClient1.Get(ImagesUrl[I], ImageStream);
//        Application.ProcessMessages;
//        ImageStream.Position := 0;
//        imgExt := TPath.GetExtension(ImagesUrl[I]).tolower;
//        if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
//          try
//            ImageStream.SaveToFile('tmp.jpeg');
//            jpegImage := TJPEGImage.Create;
//            jpegImage.loadfromFile('tmp.jpeg');
//          except
//            on e: Exception do begin
//              IBCQuery1.Next;
//              Continue;
//            end;
//          end;
//        end;
//        if imgExt = '.png' then begin
//          ImageStream.SaveToFile('tmp.png');
//          //              pngImage := TPngImage.Create;
//          pngImage.loadfromFile('tmp.png');
//        end;
//        if imgExt = '.webp' then begin
//          ImageStream.SaveToFile('tmp.webp');
//          fs := TFileStream.Create('tmp.webp', fmOpenRead);
//          WebpDecode(ImageStream, dat, bmp);
//          bmp.Save('tmp.png', gPNG);
//          bmp.Free;
//          WebPFree(dat);
//          fs.Free;
//        end;
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
//      end;
//    finally
//      FreeAndNil(jpegImage);
//      FreeAndNil(pngImage);
//    end;
//  end;
//end;

procedure Tframe116ComputerUniverse.RefreshData;
begin
  inherited;
  ibcqueryGoods.Refresh;
end;

procedure Tframe116ComputerUniverse.SelectionChanged;
begin

  ButtonStateChanged(fbtADD, false);
  ButtonStateChanged(fbtMODIFY, false);
  ButtonStateChanged(fbtDELETE, false);
end;

{ THikokiProductImages }
//procedure TWebProductImages.ParseDetailPage(GoodsID: Integer);
procedure Tframe116ComputerUniverse.parseDetailPage(GoodsID: Integer);
var
  elCount: Integer;
  Elements: OleVariant;
  I: Integer;
  atag: OleVariant;
  imagepath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJpegImage;
  bmpImage: TBitMap;
  pngImage: TPNGImage;
begin
  ImageStream := TMemoryStream.Create;

  try
    Elements := Body.All.Tags('a');
    elCount := Elements.Length - 1;
    for I := 0 to elCount do
    begin
      atag := Elements.item(I);
//            if Assigned(fOnParseStep) then
//              fOnParseStep(string(atag.ClassName));
      if atag.ClassName = 'cloud-zoom' then
      begin
        imagepath := StringReplace(atag.href, 'about:', 'https://hikoki.md', []);
//            if Assigned(fOnWebParseSync) then
//              fOnWebParseSync(imagepath);

        ImageStream.Clear;
//                httpclient.Get(imagepath, ImageStream);
        ImageStream.Position := 0;
        ImageStream.SaveToFile('ProductImage.jpeg');
        jpegImage := TJPEGImage.Create;
        bmpImage := TBitMap.Create;
        pngImage := TPNGImage.Create;
        try
          try
            jpegImage.loadfromFile('ProductImage.jpeg');
            bmpImage.Assign(jpegImage);
            pngImage.Assign(bmpImage);
            pngImage.SaveToFile('ProductImage.png');
          except
//                      if Assigned(fOnWebParseSync) then
//                        fOnWebParseSync('Error on loading jpeg');
          end;
        finally
          jpegImage.Free;
          bmpImage.Free;
          pngImage.Free;
        end;
//                IBCQueryGoodsImage.ParamByName('GOODSID').AsInteger := FGoodsID;
//                IBCQueryGoodsImage.ParamByName('IMAGE').LoadFromFile('ProductImage.png', ftBlob);
//                IBCQueryGoodsImage.Execute;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

end.


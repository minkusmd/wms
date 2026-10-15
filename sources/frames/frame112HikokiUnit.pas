unit frame112HikokiUnit;

// Hikoki image parser
// Frame Index = 112

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls,
  DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox,
  cxCurrencyEdit, cxLabel, dxBarBuiltInMenu, MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Vcl.Menus, cxButtons, MSHTML, cxContainer, Vcl.ComCtrls, dxUIAClasses;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

//  THikokiProductImages = class(TWebProductImages)
//    public
//    procedure ParseDetailPage(GoodsID: Integer); override;
//  end;

  Tframe112Hikoki = class(TSWNBaseFrame)
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
    ibcquerygoodsforeign: TIBCQuery;
    IBCQueryGoodsImage: TIBCQuery;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
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
    procedure DoWebParseSync(AMessage: string);

  protected    { Protected declarations }
    function InitFrameID: Integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    procedure RefreshData; override;

  public    { Public declarations }
    procedure LoadDom(HtmlSource: string);
    procedure ParseDetailPage(GoodsID: Integer);
    function ParseDetailProductPage(AGoodsID: integer): TStringList;

  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog, frmCerereDePlataDBDialog, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, System.IOUtils, System.Variants, Winapi.ActiveX, frmVoltaParserUnit, Vcl.WebpImage,
  Winapi.GDIPOBJ, WebpHelpers, libwebp, {uLoadProductImages,} WebProductImagesUnit;

{$R *.dfm}

procedure Tframe112Hikoki.Button1Click(Sender: TObject);
var
  htmlsource: TStringList;
  ms: TMemoryStream;
  ImagePathList: TStringList;
begin
  ibcquerygoodsforeign.Close;
  ibcquerygoodsforeign.FetchAll := true;
  ibcquerygoodsforeign.Open;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := ibcquerygoodsforeign.RecordCount - 1;
  Label2.Caption := format('%d records', [ibcquerygoodsforeign.RecordCount - 1]);
  ImagePathList := TStringlist.Create;
  htmlsource := TStringList.Create;
  try
    while not ibcquerygoodsforeign.Eof do begin
      ms := TMemoryStream.Create;
      try
        Nethttpclient1.Get(ibcquerygoodsforeign.fieldbyname('url').AsString, ms);
        ms.Position := 0;
        htmlsource.loadfromstream(ms);
      // Load htmlsouce into DOM
        LoadDom(htmlsource.Text);
        ImagePathList := ParseDetailProductPage(ibcquerygoodsforeign.FieldByName('goodsid').AsInteger);
        ProgressBar1.Position := ibcquerygoodsforeign.RecNo;
        Application.ProcessMessages;
      finally
        ms.Free;
      end;
      ibcquerygoodsforeign.next;
      application.ProcessMessages;
    end;
  finally
    FreeAndNil(htmlsource);
    FreeAndNil(ImagePathList);
  end;
end;

procedure Tframe112Hikoki.DoWebParseSync(AMessage: string);
begin
//  Memo1.Lines.Add(AMessage);
end;

procedure Tframe112Hikoki.cxButton1Click(Sender: TObject);
var
  ProductImages: TWebProductImages;
begin
  while not IBCQuery1.Eof do begin
    ProductImages := TWebProductImages.Create(dmdb.IBCConnection);
    ProductImages.OnWebParseSync := DoWebParseSync;

    IBCQuery1.Next;
    Application.ProcessMessages;
  end;
end;

procedure Tframe112Hikoki.cxButton2Click(Sender: TObject);
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

procedure Tframe112Hikoki.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe112Hikoki.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe112Hikoki.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele

  IBCQuery1.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // 4. Selection update
  SelectionChanged;
end;

function Tframe112Hikoki.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe112Hikoki.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe112Hikoki.InitFrameID: Integer;
begin
  Result := 112;
end;

procedure Tframe112Hikoki.DeleteCurrentImageFromDB(ImagesUrl: TStringList);
begin
  if (cbUpdateAllImages.Checked and (ImagesUrl.Count - 1 > 0)) then begin
    // daca sunt imagini pe site atunci stergem imaginile locale

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

procedure Tframe112Hikoki.LoadDom(HtmlSource: string);
var
  v: OleVariant;
begin
  Doc := coHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  Doc.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := HtmlSource;
  Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  body := Doc.body;
end;

procedure Tframe112Hikoki.SaveImagesToDB(var ImageStream: TMemoryStream; ImagesUrl: TStringList);
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
  for I := 0 to ImagesUrl.Count - 1 do begin
    // convert image to png
    pngImage := TPngImage.Create;
    jpegImage := TJPEGImage.Create;
    webpImage := TWebpImage.Create(Panel2);
    //
    try
      if ImagesUrl[I] <> '' then begin
        NetHTTPClient1.Get(ImagesUrl[I], ImageStream);
        Application.ProcessMessages;
        ImageStream.Position := 0;
        imgExt := TPath.GetExtension(ImagesUrl[I]).tolower;
        if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
          try
            ImageStream.SaveToFile('tmp.jpeg');
            jpegImage := TJPEGImage.Create;
            jpegImage.loadfromFile('tmp.jpeg');
          except
            on e: Exception do begin
              IBCQuery1.Next;
              Continue;
            end;
          end;
        end;
        if imgExt = '.png' then begin
          ImageStream.SaveToFile('tmp.png');
          //              pngImage := TPngImage.Create;
          pngImage.loadfromFile('tmp.png');
        end;
        if imgExt = '.webp' then begin
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
            if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
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

procedure Tframe112Hikoki.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe112Hikoki.SelectionChanged;
var
  fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin

  ButtonStateChanged(fbtADD, false);
  ButtonStateChanged(fbtMODIFY, false);
  ButtonStateChanged(fbtDELETE, false);
end;

{ THikokiProductImages }
//procedure TWebProductImages.ParseDetailPage(GoodsID: Integer);
procedure Tframe112Hikoki.parseDetailPage(GoodsID: Integer);
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
    for I := 0 to elCount do begin
      atag := Elements.item(I);
      if atag.ClassName = 'cloud-zoom' then begin
        imagepath := StringReplace(atag.href, 'about:', 'https://hikoki.md', []);
        ImageStream.Clear;
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

          end;
        finally
          jpegImage.Free;
          bmpImage.Free;
          pngImage.Free;
        end;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

function Tframe112Hikoki.ParseDetailProductPage(AGoodsID: integer): TStringList;
var
  elCount: Integer;
  Elements: OleVariant;
  I: Integer;
  atag: OleVariant;
  imagepath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJpegImage;
  bmpImage: TBitMap;
  ImageTag: OleVariant;
  imgTag: OleVariant;
  pngImage: TPNGImage;
  imgExt: string;
  fs: TFileStream;
  dat: PByte;
  bmp: TGPBitmap;
begin
  ImageStream := TMemoryStream.Create;
  try
    Elements := Body.All.Tags('div');
    elCount := Elements.Length - 1;

    for I := 0 to elCount do begin
      if not IBCtrLocalUpdate.Active then
        ibctrlocalupdate.Starttransaction;

      atag := Elements.item(I);

      if atag.ClassName = 'product-slider__thumbnails__img' then begin
        ImageTag := atag.GetElementsByTagName('img');

        imagepath := ImageTag.item(0).src;
        imagepath := stringreplace(imagepath, 'i.simpalsmedia.com/thumbor/100x0/', '', []);
        ImageStream.Clear;

        nethttpclient1.Get(imagepath, ImageStream);
        ImageStream.Position := 0;
        ImageStream.SaveToFile('hikoki.jpeg');

        jpegImage := TJPEGImage.Create;
        bmpImage := TBitMap.Create;
        pngImage := TPNGImage.Create;
        imgExt := TPath.GetExtension(imagepath.tolower);
        if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
          try
            ImageStream.SaveToFile('tmp.jpeg');
            jpegImage := TJPEGImage.Create;
            jpegImage.loadfromFile('tmp.jpeg');
          except
            on e: Exception do begin
              IBCQuery1.Next;
              Continue;
            end;
          end;
        end;
        if imgExt = '.png' then begin
          ImageStream.SaveToFile('tmp.png');
          //              pngImage := TPngImage.Create;
          pngImage.loadfromFile('tmp.png');
        end;
        if imgExt = '.webp' then begin
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
            if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
              pngImage.Assign(bmpImage);
              pngImage.SaveToFile('tmp.png');
            end;
          except
          end;
        finally
          bmpImage.Free;
        end;

        IBCQueryGoodsImage.ParamByName('GOODSID').AsInteger := AGoodsID;
        IBCQueryGoodsImage.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);

        IBCQueryGoodsImage.Execute;
        IBCQueryGoodsImage.Transaction.Commit;
        Memo1.Lines.Add('goodsid: ' + AGoodsID.ToString + '-' + imagepath + ' done with success!');
      end;
    end;

    if (imagepath = '') then begin
      // nu a fost gasit in div.
      // cautam singura imagine
      Elements := Body.All.Tags('a');
      elCount := Elements.Length - 1;
      for I := 0 to elCount do begin
        atag := Elements.item(I);

        if atag.ClassName = 'js-product-image current' then begin
          if not IBCtrLocalUpdate.Active then
            ibctrlocalupdate.Starttransaction;

          imagepath := atag.href;

//          imagepath := ImageTag.item(0).src;
//          imagepath := stringreplace(imagepath, 'i.simpalsmedia.com/thumbor/100x0/', '', []);
          ImageStream.Clear;

          nethttpclient1.Get(imagepath, ImageStream);
          ImageStream.Position := 0;
          ImageStream.SaveToFile('hikoki.jpeg');

          jpegImage := TJPEGImage.Create;
          bmpImage := TBitMap.Create;
          pngImage := TPNGImage.Create;
          imgExt := TPath.GetExtension(imagepath.tolower);
          if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
            try
              ImageStream.SaveToFile('tmp.jpeg');
              jpegImage := TJPEGImage.Create;
              jpegImage.loadfromFile('tmp.jpeg');
            except
              on e: Exception do begin
                IBCQuery1.Next;
                Continue;
              end;
            end;
          end;
          if imgExt = '.png' then begin
            ImageStream.SaveToFile('tmp.png');
          //              pngImage := TPngImage.Create;
            pngImage.loadfromFile('tmp.png');
          end;
          if imgExt = '.webp' then begin
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
              if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
                pngImage.Assign(bmpImage);
                pngImage.SaveToFile('tmp.png');
              end;
            except
            end;
          finally
            bmpImage.Free;
          end;

          IBCQueryGoodsImage.ParamByName('GOODSID').AsInteger := AGoodsID;
          IBCQueryGoodsImage.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);

          IBCQueryGoodsImage.Execute;
          IBCQueryGoodsImage.Transaction.Commit;
          Memo1.Lines.Add('goodsid: ' + AGoodsID.ToString + '-' + imagepath + ' done with success!');
        end;
      end;
    end;

  finally
    ImageStream.Free;
  end;
end;

end.


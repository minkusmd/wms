unit frame115MegaComUnit;

// EuroTerm Parser
// Frame Index = 115

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls,
  DBAccess, IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox,
  cxCurrencyEdit, cxLabel, dxBarBuiltInMenu, MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, Vcl.Menus, cxButtons, MSHTML, cxContainer,
  cxTextEdit, dxUIAClasses;

type
  TProductDetailInfo = record
    cpf: string;
    DescriptionRo: string;
    Category: string;
    Brand: string;
    Model: string;
  end;

  Tframe115Megacom = class(TSWNBaseFrame)
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
    procedure Button1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton2Click(Sender: TObject);
  private    { Private declarations }
    fRunning: Boolean;         // cxButton1 ruleaza importul de imagini
    fStopRequested: Boolean;   // al doilea click pe cxButton1 ("Stop")
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

//    Doc: IHTMLDocument2;
//    d: HTMLLIElement;
    Body: OleVariant;

    function FindProductPage(AHttp: TObject; const ACode: string; out AUrl, AHtml: string): Boolean;
    function SaveGoodsImages(AGoodsID: Integer; const AUrls: TArray<string>;
      const AData: TArray<TBytes>): Integer;

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
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
  frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog, frmCerereDePlataDBDialog, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, System.IOUtils, System.Variants, Winapi.ActiveX, frmVoltaParserUnit, Vcl.WebpImage,
  Winapi.GDIPOBJ, WebpHelpers, libwebp, uLoadProductImages, WebProductImagesUnit, SWNParseUtils,
  System.RegularExpressions, System.NetEncoding, System.Math, MamicoContentUnit;

{$R *.dfm}

{ ---------------------------------------------------------------------------- }
{ megacom.md (Megacomservice SRL, CustomerID 254422) - tema WooCommerce "Elessi"  }
{                                                                                }
{ Cautare:  https://megacom.md/?s=<cod>&post_type=product                        }
{           rezultatele sint in div.nasa-archive-product-warp, fiecare produs    }
{           cu data-href="https://megacom.md/product/<slug>/"                    }
{ Produs:   SKU in <span class="sku">, galeria in blocurile                      }
{           div.nasa-item-main-image-wrap data-key="N" (0 = imaginea principala) }
{           cu imaginea intreaga in data-full_href; blocul se termina la         }
{           nasa-thumb-wrap (miniaturile). Restul paginii are imaginile          }
{           produselor recomandate - nu se citesc.                               }
{ ---------------------------------------------------------------------------- }

const
  cMegacomBase = 'https://megacom.md';
  cMegacomMaxResults = 5;         // cite rezultate ale cautarii se verifica
  cMegacomDelayMs = 300;          // pauza intre produse, ca sa nu incarcam site-ul
  cRxOpt = [roIgnoreCase, roSingleLine];

function HtmlDecodeUrl(const S: string): string;
begin
  Result := StringReplace(S, '&#038;', '&', [rfReplaceAll]);
  Result := StringReplace(Result, '&amp;', '&', [rfReplaceAll]);
end;

function NormCode(const S: string): string;
begin
  Result := UpperCase(StringReplace(Trim(S), ' ', '', [rfReplaceAll]));
end;

// link-urile produselor din pagina de rezultate, in ordinea de pe site
function MegacomSearchLinks(const AHtml: string): TArray<string>;
var
  Seg: string;
  P: Integer;
  M: TMatch;
  L: TStringList;
begin
  Seg := AHtml;
  P := Pos('nasa-archive-product-warp', Seg);
  if P > 0 then
    Seg := Copy(Seg, P, MaxInt);
  L := TStringList.Create;
  try
    for M in TRegEx.Matches(Seg, 'data-href="(https://megacom\.md/product/[^"]+)"', cRxOpt) do
      if L.IndexOf(HtmlDecodeUrl(M.Groups[1].Value)) < 0 then
        L.Add(HtmlDecodeUrl(M.Groups[1].Value));
    Result := L.ToStringArray;
  finally
    L.Free;
  end;
end;

function MegacomIsProductPage(const AHtml: string): Boolean;
begin
  Result := (Pos('nasa-item-main-image-wrap', AHtml) > 0) and (Pos('class="sku"', AHtml) > 0);
end;

function MegacomSku(const AHtml: string): string;
var
  M: TMatch;
begin
  M := TRegEx.Match(AHtml, 'class="sku"[^>]*>\s*([^<]+?)\s*<', cRxOpt);
  if M.Success then
    Result := Trim(M.Groups[1].Value)
  else
    Result := '';
end;

// imaginile intregi ale galeriei, in ordinea de pe site (prima = principala)
function MegacomParseGallery(const AHtml: string): TArray<string>;
var
  Seg: string;
  PStart, PEnd: Integer;
  M: TMatch;
  L: TStringList;
  Url: string;
begin
  Result := nil;
  PStart := Pos('nasa-item-main-image-wrap', AHtml);
  if PStart = 0 then
    Exit;
  Seg := Copy(AHtml, PStart, MaxInt);
  PEnd := Pos('nasa-thumb-wrap', Seg);
  if PEnd > 0 then
    Seg := Copy(Seg, 1, PEnd - 1);

  L := TStringList.Create;
  try
    for M in TRegEx.Matches(Seg, 'data-full_href="([^"]+)"', cRxOpt) do
    begin
      Url := HtmlDecodeUrl(M.Groups[1].Value);
      if L.IndexOf(Url) < 0 then
        L.Add(Url);
    end;
    // tema mai veche: doar data-large_image
    if L.Count = 0 then
      for M in TRegEx.Matches(Seg, 'data-large_image="([^"]+)"', cRxOpt) do
      begin
        Url := HtmlDecodeUrl(M.Groups[1].Value);
        if L.IndexOf(Url) < 0 then
          L.Add(Url);
      end;
    Result := L.ToStringArray;
  finally
    L.Free;
  end;
end;

// imagine descarcata (JPG/PNG/WebP) -> PNG, formatul din TS_GOODS_IMAGE
function ImageBytesToPng(const ABytes: TBytes; APng: TMemoryStream): Boolean;
var
  Raw: TMemoryStream;
  Wic: TWICImage;
  WebpData: PByte;
  GpBmp: TGPBitmap;
begin
  Result := False;
  APng.Clear;
  if Length(ABytes) = 0 then
    Exit;
  Raw := TMemoryStream.Create;
  try
    Raw.WriteBuffer(ABytes[0], Length(ABytes));

    // 1. WIC citeste JPG/PNG si WebP (cind codecul WebP e instalat in Windows)
    Wic := TWICImage.Create;
    try
      try
        Raw.Position := 0;
        Wic.LoadFromStream(Raw);
        Wic.ImageFormat := wifPng;
        Wic.SaveToStream(APng);
        Result := APng.Size > 0;
      except
        APng.Clear;
      end;
    finally
      Wic.Free;
    end;

    // 2. WebP fara codec in Windows: libwebp -> GDI+ -> PNG
    if not Result then
    begin
      WebpData := nil;
      GpBmp := nil;
      try
        try
          WebpDecode(Raw, WebpData, GpBmp);
          if Assigned(GpBmp) and (GpBmp.GetWidth > 0) then
          begin
            GpBmp.Save(TStreamAdapter.Create(APng, soReference), gPNG);
            Result := APng.Size > 0;
          end;
        except
          APng.Clear;
        end;
      finally
        GpBmp.Free;
        if WebpData <> nil then
          WebPFree(WebpData);
      end;
    end;
    APng.Position := 0;
  finally
    Raw.Free;
  end;
end;

procedure Tframe115Megacom.Button1Click(Sender: TObject);
begin

end;
//procedure Tframe113EuroTerm.DoWebParseSync(AMessage: string);
//begin
//  Memo1.Lines.Add(AMessage);
//end;

{ Cauta produsul pe megacom.md dupa codul furnizorului. Pagina e acceptata daca SKU-ul ei
  e egal cu codul; altfel, doar daca e singurul rezultat si codul apare in pagina. }
function Tframe115Megacom.FindProductPage(AHttp: TObject; const ACode: string;
  out AUrl, AHtml: string): Boolean;
var
  SearchUrl, Html, Link: string;
  Links: TArray<string>;
  I: Integer;
begin
  Result := False;
  AUrl := '';
  AHtml := '';

  SearchUrl := cMegacomBase + '/?s=' + TNetEncoding.URL.Encode(ACode) + '&post_type=product';
  Html := ContentGetPage(AHttp, SearchUrl);

  // un singur rezultat: WooCommerce poate duce direct pe pagina produsului
  if MegacomIsProductPage(Html) and (NormCode(MegacomSku(Html)) = NormCode(ACode)) then
  begin
    AUrl := SearchUrl;
    AHtml := Html;
    Exit(True);
  end;

  Links := MegacomSearchLinks(Html);
  for I := 0 to Min(High(Links), cMegacomMaxResults - 1) do
  begin
    Link := Links[I];
    Html := ContentGetPage(AHttp, Link);
    if not MegacomIsProductPage(Html) then
      Continue;
    if (NormCode(MegacomSku(Html)) = NormCode(ACode))
      or ((Length(Links) = 1) and (Pos(NormCode(ACode), UpperCase(Html)) > 0)) then
    begin
      AUrl := Link;
      AHtml := Html;
      Exit(True);
    end;
  end;
end;

{ Scrie imaginile in TS_GOODS_IMAGE, in ordinea galeriei: triggerul pune ORDERNO = MAX+1,
  iar site-ul ia ca principala imaginea cu ORDERNO minim - deci prima inserata.
  Cu "Sincronizeaza toate imaginile" cele existente se sterg in aceeasi tranzactie. }
function Tframe115Megacom.SaveGoodsImages(AGoodsID: Integer; const AUrls: TArray<string>;
  const AData: TArray<TBytes>): Integer;
var
  Png: TMemoryStream;
  I: Integer;
begin
  Result := 0;
  Png := TMemoryStream.Create;
  try
    if not IBCtrLocalUpdate.Active then
      IBCtrLocalUpdate.StartTransaction;
    try
      if cbUpdateAllImages.Checked then
      begin
        IBCSQLDelete.ParamByName('GOODSID').AsInteger := AGoodsID;
        IBCSQLDelete.Execute;
      end;

      for I := 0 to High(AUrls) do
      begin
        if not ImageBytesToPng(AData[I], Png) then
        begin
          Memo1.Lines.Add('    imaginea nu a putut fi convertita: ' + AUrls[I]);
          Continue;
        end;
        IBCSQL1.ParamByName('GOODSID').AsInteger := AGoodsID;
        IBCSQL1.ParamByName('IMAGE').LoadFromStream(Png, ftBlob);
        IBCSQL1.Execute;
        Inc(Result);
      end;

      // nicio imagine valida: nu stergem nimic din ce exista
      if Result = 0 then
        IBCtrLocalUpdate.Rollback
      else
        IBCtrLocalUpdate.Commit;
    except
      IBCtrLocalUpdate.Rollback;
      raise;
    end;
  finally
    Png.Free;
  end;
end;

{ Aduce imaginile de pe megacom.md pentru produsele din lista (TS_GOODS_FOREIGN al
  furnizorului 254422, cu filtrele din panou) si le adauga in TS_GOODS_IMAGE.
  Al doilea click pe buton opreste rularea dupa produsul curent. }
procedure Tframe115Megacom.cxButton1Click(Sender: TObject);
var
  Http: TObject;
  GoodsID, I, Saved: Integer;
  Code, Url, Html, Mode: string;
  Urls: TArray<string>;
  Data: TArray<TBytes>;
  CntDone, CntNotFound, CntNoImages, CntSkipped, CntImages, CntErrors: Integer;
  HasImages, Fetched: Boolean;
  QExisting: TIBCQuery;
begin
  if fRunning then
  begin
    fStopRequested := True;
    Memo1.Lines.Add('Oprire ceruta - se termina produsul curent...');
    Exit;
  end;

  if not IBCQuery1.Active then
    cxButton2Click(Sender);
  if IBCQuery1.IsEmpty then
  begin
    Memo1.Lines.Add('Lista de produse e goala.');
    Exit;
  end;

  fRunning := True;
  fStopRequested := False;
  cxButton1.Caption := 'Stop';
  cxButton2.Enabled := False;
  CntDone := 0; CntNotFound := 0; CntNoImages := 0; CntSkipped := 0; CntImages := 0; CntErrors := 0;

  Http := CreateContentHttp;
  QExisting := TIBCQuery.Create(nil);
  try
    QExisting.Connection := dmDB.IBCConnection;
    QExisting.SQL.Text := 'select count(*) from TS_GOODS_IMAGE where GOODSID = :GOODSID';

    if cbUpdateAllImages.Checked then
      Mode := 'imaginile existente se inlocuiesc'
    else
      Mode := 'produsele cu imagini se sar';
    Memo1.Lines.Add(Format('Start: %d produse, %s', [IBCQuery1.RecordCount, Mode]));

    IBCQuery1.DisableControls;
    try
      IBCQuery1.First;
      while not IBCQuery1.Eof and not fStopRequested do
      begin
        GoodsID := IBCQuery1.FieldByName('GOODSID').AsInteger;
        Code := Trim(IBCQuery1.FieldByName('GOODS_CODE').AsString);
        Inc(CntDone);
        Fetched := False;

        // Continue dintr-un try..finally executa finally: Next ruleaza o singura data
        try
        try
          if Code = '' then
          begin
            Inc(CntSkipped);
            Memo1.Lines.Add(Format('%d: fara cod de furnizor - sarit', [GoodsID]));
            Continue;
          end;

          if not cbUpdateAllImages.Checked then
          begin
            QExisting.ParamByName('GOODSID').AsInteger := GoodsID;
            QExisting.Open;
            HasImages := QExisting.Fields[0].AsInteger > 0;
            QExisting.Close;
            if HasImages then
            begin
              Inc(CntSkipped);
              Continue;
            end;
          end;

          Fetched := True;
          if not FindProductPage(Http, Code, Url, Html) then
          begin
            Inc(CntNotFound);
            Memo1.Lines.Add(Format('%d %s: nu a fost gasit pe megacom.md', [GoodsID, Code]));
            Continue;
          end;

          Urls := MegacomParseGallery(Html);
          if Length(Urls) = 0 then
          begin
            Inc(CntNoImages);
            Memo1.Lines.Add(Format('%d %s: pagina fara imagini - %s', [GoodsID, Code, Url]));
            Continue;
          end;

          SetLength(Data, Length(Urls));
          for I := 0 to High(Urls) do
          begin
            Data[I] := ContentGetBytes(Http, Urls[I]);
            Application.ProcessMessages;
          end;

          Saved := SaveGoodsImages(GoodsID, Urls, Data);
          Inc(CntImages, Saved);
          Memo1.Lines.Add(Format('%d %s: %d/%d imagini salvate - %s',
            [GoodsID, Code, Saved, Length(Urls), Url]));
        except
          on E: Exception do
          begin
            Inc(CntErrors);
            Memo1.Lines.Add(Format('%d %s: EROARE %s', [GoodsID, Code, E.Message]));
          end;
        end;
        finally
          IBCQuery1.Next;
          Application.ProcessMessages;
          if Fetched then
            Sleep(cMegacomDelayMs);
        end;
      end;
    finally
      IBCQuery1.EnableControls;
    end;
  finally
    QExisting.Free;
    Http.Free;
    fRunning := False;
    cxButton1.Caption := 'Start';
    cxButton2.Enabled := True;
  end;

  if fStopRequested then
    Mode := 'Oprit'
  else
    Mode := 'Gata';
  Memo1.Lines.Add(Format('%s: %d parcurse, %d imagini salvate, %d negasite, %d fara imagini, ' +
    '%d sarite, %d erori', [Mode, CntDone, CntImages, CntNotFound, CntNoImages, CntSkipped,
    CntErrors]));
end;

procedure Tframe115Megacom.cxButton2Click(Sender: TObject);
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

procedure Tframe115Megacom.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe115Megacom.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQuery1.Close;

  inherited;
end;

procedure Tframe115Megacom.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

function Tframe115Megacom.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsNONE];
end;

function Tframe115Megacom.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
//    if fSYS_Add then
//        Result := Result + [fbtADD];
//    if fSYS_Edit or fSYS_View then
//        Result := Result + [fbtMODIFY];
//    if fSYS_Delete then
//        Result := Result + [fbtDELETE];
end;

function Tframe115Megacom.InitFrameID: Integer;
begin
  Result := 115;
end;


procedure Tframe115Megacom.RefreshData;
begin
  inherited;
  IBCQuery1.Refresh;
end;

procedure Tframe115Megacom.SelectionChanged;
begin

  ButtonStateChanged(fbtADD, false);
  ButtonStateChanged(fbtMODIFY, false);
  ButtonStateChanged(fbtDELETE, false);
end;

{ THikokiProductImages }
//procedure TWebProductImages.ParseDetailPage(GoodsID: Integer);
procedure Tframe115Megacom.parseDetailPage(GoodsID: Integer);
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
//            if Assigned(fOnParseStep) then
//              fOnParseStep(string(atag.ClassName));
      if atag.ClassName = 'cloud-zoom' then begin
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


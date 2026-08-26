unit frame123DehomeUnit;

interface

uses
  DBAccess, IBC, MSHTML, MemDS, SWNBaseFrameUnit, SWNDataFiltering, cxButtons, cxClasses, cxContainer, cxControls,
  cxCustomData, cxDBData, cxData, cxDataStorage, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView,
  cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridTableView, cxImage, cxLookAndFeelPainters, cxLookAndFeels,
  cxMemo, cxNavigator, cxStyles, cxTextEdit, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses,
  Data.DB,
  System.Classes,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.Net.URLClient,
  System.SysUtils,
  System.Variants,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,

  Vcl.Menus,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows;

const
  HOSTNAME = 'https://technodom.md';
  SEARCH_URL_TEMPLATE = 'https://www.technodom.md/index.php?route=product/search&search=%s';
  IMAGE_SIZE_SMALL = '228x228';
  IMAGE_SIZE_LARGE = '800x800';
  PROCESS_DELAY_MS = 100;
  HTTP_SUCCESS = 200;

type
  TImageFormat = (ifUnknown, ifJPEG, ifPNG, ifGIF, ifBMP, ifWEBP);

  Tframe123Dehome = class(TSWNBaseFrame)
    IBCQuerySupplierGoods: TIBCQuery;
    IBCDataSourceSupplierGoods: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxButton1: TcxButton;
    NetHTTPClient1: TNetHTTPClient;
    IBCSQL1: TIBCSQL;
    IBCtrLocalUpdate: TIBCTransaction;
    IBCQuery1: TIBCQuery;
    cxImage1: TcxImage;
    cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn;
    cxMemo1: TcxMemo;
    procedure cxButton1Click(Sender: TObject);
  private
    FDocumentBody: OleVariant;

    // HTTP and Image Operations
    function LoadImageFromURL(const AUrl: string): TMemoryStream;
    procedure SaveImageToDB(const AImageStream: TMemoryStream; AGoodsId: Integer);
    function ConvertImageToPNG(const AInputStream: TMemoryStream): TMemoryStream;
    function IdentifyImageFormat(const AStream: TStream): TImageFormat;

    // HTML Parsing
    function LoadHTMLDocument(const AUrl: string): IHTMLDocument2;
    function ExtractImageUrl(const ADocument: IHTMLDocument2): string;

    // Logging and Error Handling
    procedure LogError(const AMessage: string);
    procedure LogInfo(const AMessage: string);
  protected
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
  public
    procedure ProcessProduct(const AGoodsCode: string);
    procedure ProcessAllProducts;
  end;

implementation

uses
  ComObj,
  System.Math,
  Vcl.ComCtrls,
  Vcl.Graphics,
  Vcl.Imaging.GIFImg,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Vcl.OleAuto,
  Winapi.ActiveX;

{$R *.dfm}

{ Tframe123Dehome }

procedure Tframe123Dehome.cxButton1Click(Sender: TObject);
begin
  ProcessAllProducts;
end;

procedure Tframe123Dehome.ProcessAllProducts;
var
  GoodsCode: string;
  ProcessedCount: Integer;
begin
  ProcessedCount := 0;
  IBCQuerySupplierGoods.First;

  while not IBCQuerySupplierGoods.Eof do
  begin
    try
      GoodsCode := IBCQuerySupplierGoods.FieldByName('goods_code').AsString;
      ProcessProduct(GoodsCode);
      Inc(ProcessedCount);

      LogInfo(Format('Processed %d products', [ProcessedCount]));
    except
      on E: Exception do
        LogError(Format('Error processing goods code %s: %s', [GoodsCode, E.Message]));
    end;

    IBCQuerySupplierGoods.Next;
    Application.ProcessMessages;
    Sleep(PROCESS_DELAY_MS);
  end;

  LogInfo(Format('Processing complete. Total: %d products', [ProcessedCount]));
end;

procedure Tframe123Dehome.ProcessProduct(const AGoodsCode: string);
var
  HTMLDoc: IHTMLDocument2;
  ImageUrl: string;
  ImageStream: TMemoryStream;
  PNGStream: TMemoryStream;
  GoodsId: Integer;
begin
  if Trim(AGoodsCode) = '' then
  begin
    LogError('Empty goods code provided');
    Exit;
  end;

  try
    // Load and parse HTML document
    HTMLDoc := LoadHTMLDocument(Format(SEARCH_URL_TEMPLATE, [AGoodsCode]));
    if not Assigned(HTMLDoc) then
    begin
      LogError(Format('Failed to load HTML for goods code: %s', [AGoodsCode]));
      Exit;
    end;

    // Extract image URL
    ImageUrl := ExtractImageUrl(HTMLDoc);
    if ImageUrl = '' then
    begin
      LogError(Format('No image found for goods code: %s', [AGoodsCode]));
      Exit;
    end;

    // Convert image size to larger version
    ImageUrl := StringReplace(ImageUrl, IMAGE_SIZE_SMALL, IMAGE_SIZE_LARGE, [rfReplaceAll]);

    // Download image
    ImageStream := LoadImageFromURL(ImageUrl);
    try
      if not Assigned(ImageStream) then
      begin
        LogError(Format('Failed to download image from: %s', [ImageUrl]));
        Exit;
      end;

      // Convert to PNG (optional, based on requirements)
      PNGStream := ConvertImageToPNG(ImageStream);
      try
        GoodsId := IBCQuerySupplierGoods.FieldByName('goodsid').AsInteger;
        SaveImageToDB(PNGStream, GoodsId);
        LogInfo(Format('Successfully saved image for goods ID: %d', [GoodsId]));
      finally
        PNGStream.Free;
      end;
    finally
      ImageStream.Free;
    end;

    Application.ProcessMessages;
  except
    on E: Exception do
      LogError(Format('Error in ProcessProduct for %s: %s', [AGoodsCode, E.Message]));
  end;
end;

function Tframe123Dehome.LoadHTMLDocument(const AUrl: string): IHTMLDocument2;
var
  MemStream: TMemoryStream;
  HTMLSource: TStringList;
  SafeArray: OleVariant;
begin
  Result := nil;
  MemStream := TMemoryStream.Create;
  HTMLSource := TStringList.Create;
  try
    try
      NetHTTPClient1.Get(AUrl, MemStream);
      MemStream.Position := 0;
      HTMLSource.LoadFromStream(MemStream);

      Result := CoHTMLDocument.Create as IHTMLDocument2;
      Result.designMode := 'on';

      SafeArray := VarArrayCreate([0, 0], varVariant);
      SafeArray[0] := HTMLSource.Text;
      Result.Write(PSafeArray(TVarData(SafeArray).VArray));
    except
      on E: Exception do
      begin
        LogError(Format('Failed to load HTML document from %s: %s', [AUrl, E.Message]));
        Result := nil;
      end;
    end;
  finally
    MemStream.Free;
    HTMLSource.Free;
  end;
end;

function Tframe123Dehome.ExtractImageUrl(const ADocument: IHTMLDocument2): string;
var
  DocumentBody: OleVariant;
  AllDivs: OleVariant;
  Elements: OleVariant;
  DivIndex, ElementIndex: Integer;
  ClassName: string;
  ImgElements: OleVariant;
begin
  Result := '';

  if not Assigned(ADocument) then
    Exit;

  try
    DocumentBody := ADocument.body as IHTMLElement;
    AllDivs := DocumentBody.All.Tags('div');

    for DivIndex := 0 to AllDivs.Length - 1 do
    begin
      ClassName := VarToStr(AllDivs.item(DivIndex).ClassName);

      if Pos('product-thumb transition', ClassName) > 0 then
      begin
        Elements := AllDivs.item(DivIndex).getElementsByTagName('a');

        if Elements.length > 0 then
        begin
          for ElementIndex := 0 to Elements.Length - 1 do
          begin
            ImgElements := Elements.item(ElementIndex).getElementsByTagName('img');

            if ImgElements.Length > 0 then
            begin
              Result := VarToStr(ImgElements.item(0).getAttribute('src'));

              // Log for debugging
              cxMemo1.Lines.Text := VarToStr(Elements.item(ElementIndex).innerHTML);
              Exit;
            end;
          end;
        end;
      end;
    end;
  except
    on E: Exception do
      LogError(Format('Error extracting image URL: %s', [E.Message]));
  end;
end;

function Tframe123Dehome.LoadImageFromURL(const AUrl: string): TMemoryStream;
var
  HttpClient: THttpClient;
  HttpResponse: IHTTPResponse;
begin
  Result := nil;

  if Trim(AUrl) = '' then
  begin
    LogError('Empty URL provided to LoadImageFromURL');
    Exit;
  end;

  HttpClient := THttpClient.Create;
  try
    try
      HttpResponse := HttpClient.Get(AUrl);

      if HttpResponse.StatusCode = HTTP_SUCCESS then
      begin
        Result := TMemoryStream.Create;
        Result.CopyFrom(HttpResponse.ContentStream, 0);
        Result.Position := 0;
      end
      else
        LogError(Format('HTTP request failed with status code: %d', [HttpResponse.StatusCode]));
    except
      on E: Exception do
      begin
        FreeAndNil(Result);
        LogError(Format('Failed to load image from URL %s: %s', [AUrl, E.Message]));
      end;
    end;
  finally
    HttpClient.Free;
  end;
end;

procedure Tframe123Dehome.SaveImageToDB(const AImageStream: TMemoryStream; AGoodsId: Integer);
begin
  if not Assigned(AImageStream) then
  begin
    LogError('Image stream is not assigned');
    Exit;
  end;

  if AImageStream.Size = 0 then
  begin
    LogError('Image stream is empty');
    Exit;
  end;

  try
    if not IBCSQL1.Transaction.Active then
      IBCSQL1.Transaction.StartTransaction;

    try
      AImageStream.Position := 0;
      IBCSQL1.ParamByName('goodsid').AsInteger := AGoodsId;
      IBCSQL1.ParamByName('image').LoadFromStream(AImageStream, ftBlob);
      IBCSQL1.Execute;

      IBCSQL1.Transaction.Commit;
    except
      on E: Exception do
      begin
        if IBCSQL1.Transaction.Active then
          IBCSQL1.Transaction.Rollback;
        raise;
      end;
    end;
  except
    on E: Exception do
      LogError(Format('Failed to save image for goods ID %d: %s', [AGoodsId, E.Message]));
  end;
end;

function Tframe123Dehome.ConvertImageToPNG(const AInputStream: TMemoryStream): TMemoryStream;
var
  ImageFormat: TImageFormat;
  SourceGraphic: TGraphic;
  PNGImage: TPngImage;
  TempBitmap: TBitmap;
begin
  Result := nil;

  if not Assigned(AInputStream) then
  begin
    LogError('Input stream is not assigned');
    Exit;
  end;

  AInputStream.Position := 0;
  ImageFormat := IdentifyImageFormat(AInputStream);

  if ImageFormat = ifUnknown then
  begin
    LogError('Unknown or unsupported image format');
    Exit;
  end;

  SourceGraphic := nil;
  PNGImage := TPngImage.Create;
  try
    try
      // Create appropriate graphic object based on format
      case ImageFormat of
        ifJPEG: SourceGraphic := TJPEGImage.Create;
        ifPNG:  SourceGraphic := TPNGImage.Create;
        ifGIF:  SourceGraphic := TGIFImage.Create;
        ifBMP:  SourceGraphic := TBitmap.Create;
      else
        raise Exception.Create('Unsupported image format for conversion');
      end;

      AInputStream.Position := 0;
      SourceGraphic.LoadFromStream(AInputStream);

      // If already PNG, just copy
      if SourceGraphic is TPngImage then
      begin
        Result := TMemoryStream.Create;
        Result.CopyFrom(AInputStream, 0);
        Result.Position := 0;
      end
      else
      begin
        // Convert to PNG
        TempBitmap := TBitmap.Create;
        try
          TempBitmap.Assign(SourceGraphic);
          PNGImage.Assign(TempBitmap);

          Result := TMemoryStream.Create;
          PNGImage.SaveToStream(Result);
          Result.Position := 0;
        finally
          TempBitmap.Free;
        end;
      end;
    except
      on E: Exception do
      begin
        FreeAndNil(Result);
        LogError(Format('Error converting image to PNG: %s', [E.Message]));
      end;
    end;
  finally
    if Assigned(SourceGraphic) then
      SourceGraphic.Free;
    PNGImage.Free;
  end;
end;

function Tframe123Dehome.IdentifyImageFormat(const AStream: TStream): TImageFormat;
var
  Header: array[0..11] of Byte;
  BytesRead: Integer;
begin
  Result := ifUnknown;

  if not Assigned(AStream) then
    Exit;

  AStream.Position := 0;
  BytesRead := AStream.Read(Header, SizeOf(Header));

  if BytesRead < SizeOf(Header) then
    Exit;

  // JPEG
  if (Header[0] = $FF) and (Header[1] = $D8) then
    Result := ifJPEG
  // PNG
  else if (Header[0] = $89) and (Header[1] = $50) and
          (Header[2] = $4E) and (Header[3] = $47) then
    Result := ifPNG
  // GIF
  else if (Header[0] = $47) and (Header[1] = $49) and (Header[2] = $46) then
    Result := ifGIF
  // BMP
  else if (Header[0] = $42) and (Header[1] = $4D) then
    Result := ifBMP
  // WEBP
  else if (Header[0] = $52) and (Header[1] = $49) and (Header[2] = $46) and
          (Header[3] = $46) and (Header[8] = $57) and (Header[9] = $45) and
          (Header[10] = $42) and (Header[11] = $50) then
    Result := ifWEBP;

  AStream.Position := 0;
end;

procedure Tframe123Dehome.LogError(const AMessage: string);
begin
  cxMemo1.Lines.Add(Format('[ERROR] %s: %s', [TimeToStr(Now), AMessage]));
end;

procedure Tframe123Dehome.LogInfo(const AMessage: string);
begin
  cxMemo1.Lines.Add(Format('[INFO] %s: %s', [TimeToStr(Now), AMessage]));
end;

{ Frame lifecycle methods }

function Tframe123Dehome.InitFrameID: Integer;
begin
  Result := 123;
end;

procedure Tframe123Dehome.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;
  IBCQuerySupplierGoods.Open;
end;

procedure Tframe123Dehome.DoFrameHide;
begin
  inherited;
  IBCQuerySupplierGoods.Close;
end;

function Tframe123Dehome.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

procedure Tframe123Dehome.RefreshData;
begin
  IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe123Dehome.DeleteRecord;
begin
  inherited;
end;

function Tframe123Dehome.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [];
end;

function Tframe123Dehome.GetFilterFields: TFrameFilterFields;
begin
  Result := [];
end;

procedure Tframe123Dehome.SaveFrameStates;
begin
  inherited;
end;

procedure Tframe123Dehome.ReadFrameStates;
begin
  inherited;
end;

end.

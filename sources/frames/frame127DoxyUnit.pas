unit frame127DoxyUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    SWNBaseFrameUnit, SWNDataFiltering, cxGraphics, dxUIAClasses, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
    cxGrid, DBAccess, IBC, MemDS, Vcl.Menus, Vcl.StdCtrls, cxButtons,
    System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
    cxContainer, cxImage, Vcl.ExtCtrls, cxTextEdit, cxMemo, System.JSON;

const
    hostname = 'https://doxyterra.md';
    SUPPLIERID = 1455;

type
    Tframe127Doxy = class(TSWNBaseFrame)
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
    NetHTTPClient2: TNetHTTPClient;
    cxButton2: TcxButton;
        procedure cxButton1Click(Sender: TObject);

    private
        FDocumentBody: OleVariant;
        procedure LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
        procedure SaveImageToDB(const MemoryStream: TMemoryStream);
        procedure ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
        function IdentifyImageFormat(const Stream: TStream): string;
    protected
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DeleteRecord; override;
        function GetProductDetailPage(ResponseContent: string): string;
        procedure PrepareData;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;

    public
        procedure DoParse(GoodsCode: string);
        function GetProductDetail(AUrl: string): string;
    end;

implementation

uses
    MSHTML, Vcl.ComCtrls, Winapi.ActiveX, Vcl.OleAuto, dxGDIPlusClasses,
    Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.WebpImage,
    ComObj, SWNUtils, System.Win.IEInterfaces;

{$R *.dfm}

procedure Tframe127Doxy.cxButton1Click(Sender: TObject);
begin
//    while not IBCQuerySupplierGoods.Eof do
//    begin
//        DoParse(IBCQuerySupplierGoods.fieldbyname('goods_code').AsString);
//        IBCQuerySupplierGoods.Next;
//        application.ProcessMessages;
//        sleep(100);
//    end;
    DoParse('32563');
end;

procedure Tframe127Doxy.DeleteRecord;
begin
    inherited;

end;

procedure Tframe127Doxy.DoFrameHide;
begin
    inherited;
    IBCQuerySupplierGoods.Close;
end;

procedure Tframe127Doxy.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQuerySupplierGoods.Close;
    IBCQuerySupplierGoods.ParamByName('customerid').AsInteger := SUPPLIERID;
    IBCQuerySupplierGoods.open;
end;

procedure Tframe127Doxy.LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
var
    HttpClient: THttpClient;
    HttpResponse: IHTTPResponse;
begin
  // Create an HTTP client instance
    HttpClient := THttpClient.Create;
    ImageStream := TMemoryStream.Create;
    try
        try
      // Send a GET request to the URL
            HttpResponse := HttpClient.Get(URL);

      // Check if the response is successful
            if HttpResponse.StatusCode = 200 then
            begin
        // Copy the response content to the stream
                ImageStream.CopyFrom(HttpResponse.ContentStream, HttpResponse.ContentStream.Size);

        // Reset the stream position to the beginning
                ImageStream.Position := 0;
            end
            else
                raise Exception.CreateFmt('Failed to load image. HTTP Status Code: %d', [HttpResponse.StatusCode]);
        except
            on E: Exception do
            begin
        // Free the stream and re-raise the exception if an error occurs
                FreeAndNil(ImageStream);
                raise Exception.CreateFmt('Failed to load image from URL: %s', [E.Message]);
            end;
        end;
    finally
    // Free the HTTP client instance
        HttpClient.Free;
    end;
end;

procedure Tframe127Doxy.SaveImageToDB(const MemoryStream: TMemoryStream);
var
    b: TBitmap;
    JpegImage: TJPegImage;
    Bitmap: TBitMap;
    PngImage: TPNGImage;
begin
    if not Assigned(MemoryStream) then
        raise Exception.Create('MemoryStream is not assigned.');

    JpegImage := TJPEGImage.Create;
    PngImage := TPngImage.Create;
    Bitmap := TBitmap.Create;
    try
//    MemoryStream.Position := 0;
        try
            JpegImage.LoadFromStream(MemoryStream);

            // Convertim in Bitmap
            Bitmap.Assign(JpegImage);

            // Salvam Bitmap in MemoryStream
            Bitmap.SaveToStream(MemoryStream);
            MemoryStream.Position := 0;  // Resetam pozitia fluxului

            // Incarcam Bitmap in PNG
            PngImage.Assign(Bitmap);

            // Salvam PNG in fisier
            PngImage.SaveToStream(MemoryStream);

        except
            on e: Exception do
            begin
                cxMemo1.Lines.Add('Error' + e.Message);
                JpegImage.Free;
                PngImage.Free;
                Bitmap.Free;
            end;
        end;

        try
        // Start a transaction if necessary
            if not IBCSQL1.Transaction.Active then
                IBCSQL1.Transaction.StartTransaction;

        // Save the MemoryStream content to the query field
            MemoryStream.Position := 0;
            ibcsql1.ParamByName('goodsid').AsInteger := IBCQuerySupplierGoods.FieldByName('goodsid').AsInteger;
            IBCSQL1.ParamByName('image').LoadFromStream(MemoryStream, ftBlob);

            ibcsql1.Execute;

        // Commit the transaction
            IBCSQL1.Transaction.Commit;
        except
            on E: Exception do
            begin
          // Rollback the transaction in case of an error
                if IBCSQL1.Transaction.Active then
                    IBCSQL1.Transaction.Rollback;

                raise Exception.CreateFmt('Failed to save image to query: %s', [E.Message]);
            end;
        end;

    finally
        JpegImage.Free;
        PngImage.Free;
        Bitmap.Free;
    end;
end;

procedure Tframe127Doxy.DoParse(GoodsCode: string);
var
    FDocumentProductPage: IHTMLDocument2;
    vs, vp: OleVariant;
    alldivs: OleVariant;
    Body: OleVariant;
    elements: OleVariant;
    bigImageUrl: string;
    DataHref: string;
    k: integer;
    len: integer;
    ProductUrl: string;
    Response: IHTTPResponse;
    Response1: IHTTPResponse;
    ResponseContent: string;
    s: string;
begin
    NetHttpClient1.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
    NetHttpClient1.CustomHeaders['X-Requested-With'] := 'XMLHttpRequest';
    NetHttpClient1.CustomHeaders['Accept'] := 'application/json, text/javascript, */*; q=0.01';

    Response := NetHTTPClient1.Get(format('https://doxyterra.md/ro/catalog/search/?q=%s', [GoodsCode]));
    if Response.GetStatusCode = 200 then
        ResponseContent := Response.ContentAsString(TEncoding.UTF8)
    else
        ShowMessage('Eroare: ' + Response.GetStatusCode.ToString);

    ProductUrl:=GetProductDetailPage(ResponseContent);
    productURL := DecodeEscapedUnicode(productURL);
    productURL := productUrl.Replace('about:', 'https://doxyterra.md', []);


    // parsam pagina produsului si gasim imaginile produsului
    FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    vs := VarArrayCreate([0, 0], varVariant);
    s := GetProductDetail(ProductURL);
    vs[0] := s;
    FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
    Body := FDocumentProductPage.body as IHTMLElement;

    alldivs := Body.All.Tags('ul');
    for var j := 0 to integer(alldivs.Length) - 1 do
    begin
        if string(alldivs.item(j).ClassName).Contains('gallery__thumbnails-list') then
        begin
            elements := alldivs.item(j).getElementsByTagName('li');
            if elements.length > 0 then
            for k := 0 to elements.Length - 1 do
            begin
                DataHref := Elements.item(k).item(0).getAttribute('data-href');
                bigImageUrl := DataHref;
                var ImageStream := TMemoryStream.Create;
                try
                    LoadImageFromURL(bigImageUrl, ImageStream);
                    SaveImageToDB(ImageStream);
                finally
                    ImageStream.Free;
                end;
                Application.ProcessMessages;
            end;
        end;
    end;
end;

function Tframe127Doxy.IdentifyImageFormat(const Stream: TStream): string;
var
    Header: array[0..11] of Byte;
begin
    Result := '';
    Stream.Position := 0; // Ensure the stream is at the beginning
    if Stream.Read(Header, SizeOf(Header)) < SizeOf(Header) then
        Exit; // Invalid stream or too small to detect

  // Check for JPEG
    if (Header[0] = $FF) and (Header[1] = $D8) then
        Result := 'jpeg'
  // Check for PNG
    else if (Header[0] = $89) and (Header[1] = $50) and (Header[2] = $4E) and (Header[3] = $47) then
        Result := 'png'
  // Check for GIF
    else if (Header[0] = $47) and (Header[1] = $49) and (Header[2] = $46) then
        Result := 'gif'
  // Check for BMP
    else if (Header[0] = $42) and (Header[1] = $4D) then
        Result := 'bmp'
  // Check for WEBP
    else if (Header[0] = $52) and (Header[1] = $49) and (Header[2] = $46) and (Header[3] = $46) and (Header[8] = $57) and (Header[9] = $45) and (Header[10] = $42) and (Header[11] = $50) then
        Result := 'webp';
end;

procedure Tframe127Doxy.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
var
    ImageFormat: string;
    Graphic: TGraphic;
    PNGImage: TPngImage;
begin
    if not Assigned(InputStream) then
        raise Exception.Create('Input stream is not assigned.');
    if not Assigned(OutputStream) then
        raise Exception.Create('Output stream is not assigned.');

    InputStream.Position := 0; // Reset stream to start
    ImageFormat := IdentifyImageFormat(InputStream);

    if ImageFormat = '' then
        Exit;  // Unsupported format

    Graphic := nil;
    try
    // Load the appropriate TGraphic class based on format
        if ImageFormat = 'jpeg' then
            Graphic := TJpegImage.Create
        else if ImageFormat = 'png' then
            Graphic := TPngImage.Create
        else if ImageFormat = 'gif' then
            Graphic := TGIFImage.Create
        else if ImageFormat = 'bmp' then
            Graphic := TBitmap.Create;
    // else if ImageFormat = 'webp' then
    //   Graphic := TWebPImage.Create(Panel1); // WebP support

        InputStream.Position := 0; // Reset stream to start
        Graphic.LoadFromStream(InputStream);

    // If the image is already a PNG with transparency, just save it as is
        if Graphic is TPngImage then
        begin
            PNGImage := TPngImage(Graphic);  // Cast directly to TPngImage
            OutputStream.Clear;
            PNGImage.SaveToStream(OutputStream);
        end
        else
        begin
      // Convert to PNG while preserving transparency (if applicable)
            PNGImage := TPngImage.Create;
            try
        // Assign graphic directly to PNGImage
                PNGImage.Assign(Graphic);

        // Create alpha channel (preserve transparency)
//        PNGImage.CreateAlpha;

        // Save the PNG with transparency
                OutputStream.Clear;
                PNGImage.SaveToStream(OutputStream);
            finally
                PNGImage.Free;
            end;
        end;
    finally
        Graphic.Free;
    end;
end;

function Tframe127Doxy.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe127Doxy.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe127Doxy.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe127Doxy.GetProductDetail(AUrl: string): string;
var
  NetHTTPClient: TNetHTTPClient;
  ResponseStream: TStringStream;
  ResponseContent: string;
begin
  Result := '';
  NetHTTPClient := TNetHTTPClient.Create(nil);
  try
    // Permite decomprimarea automată a răspunsurilor
    NetHTTPClient.AutomaticDecompression := [THTTPCompressionMethod.Any];

    // Setează anteturile pentru a imita un browser
    NetHTTPClient.CustomHeaders['User-Agent'] :=
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
    NetHTTPClient.CustomHeaders['Accept'] :=
      'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
    NetHTTPClient.CustomHeaders['Accept-Language'] := 'en-US,en;q=0.9';

    // Nu seta manual 'Accept-Encoding' pentru a permite gestionarea automată

    // Creează un stream pentru a citi răspunsul
    ResponseStream := TStringStream.Create('', TEncoding.UTF8);
    try
      // Trimiterea cererii GET
      NetHTTPClient.Get(AUrl, ResponseStream);
      ResponseStream.Position := 0;
      ResponseContent := ResponseStream.DataString;
      cxMemo1.LInes.Text := ResponseContent;
      Result := cxMemo1.LInes.Text;
      // Acum, ResponseContent conține întregul HTML al paginii
      // Poți continua procesarea, de exemplu, cu IHTMLDocument2
    finally
      ResponseStream.Free;
    end;
  finally
    NetHTTPClient.Free;
  end;
end;

function Tframe127Doxy.GetProductDetailPage(ResponseContent: string): string;
var
    URL: string;
    FDocumentProductPage: IHTMLDocument2;
    vs, vp: OleVariant;
    alldivs: OleVariant;
    elements: OleVariant;
    bigImageUrl: string;
    k: integer;
    len: integer;
    ProductUrl: string;
    Response: IHTTPResponse;
begin
    URL := '';
    FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    vs := VarArrayCreate([0, 0], varVariant);
    vs[0] := ResponseContent;
    FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
    FDocumentBody := FDocumentProductPage.body as IHTMLElement;
    //
    alldivs := FDocumentBody.All.Tags('div');
    for var j := 0 to integer(alldivs.Length) - 1 do
    begin
        if string(alldivs.item(j).ClassName).Contains('catalogCard-title') then
        begin
            elements := alldivs.item(j).getElementsByTagName('a');
            if Integer(elements.Length)>0 then
            begin
                // get src attribute
                URL := elements.item(0).href;
                break;
            end;
        end;
    end;
    Result := URL;
end;

function Tframe127Doxy.InitFrameID: Integer;
begin
    Result := 127;
end;

procedure Tframe127Doxy.PrepareData;
begin

end;

procedure Tframe127Doxy.ReadFrameStates;
begin
    inherited;

end;

procedure Tframe127Doxy.RefreshData;
begin
    IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe127Doxy.SaveFrameStates;
begin
    inherited;

end;

end.


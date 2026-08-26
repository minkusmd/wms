unit frame120ATehnoUnit;

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
    cxContainer, cxImage, Vcl.ExtCtrls, cxTextEdit, cxMemo;

type
    Tframe120ATehno = class(TSWNBaseFrame)
        IBCQueryATehnoGoods: TIBCQuery;
        IBCDataSourceATehnoGoods: TIBCDataSource;
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
        Button1: TButton;
        procedure Button1Click(Sender: TObject);
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
        procedure PrepareData;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;

    public
        procedure DoParse(GoodsCode: string);
    end;

implementation

uses
    MSHTML, Vcl.ComCtrls, Winapi.ActiveX, Vcl.OleAuto, dxGDIPlusClasses,
    Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.WebpImage,
    DataModuleDB, SWNUtils, System.JSON;

{$R *.dfm}

procedure Tframe120ATehno.Button1Click(Sender: TObject);
begin
    inherited;
    dmdb.ExecuteQuery('execute procedure CLEAN_ATEHNO_GOODSNAME', []);
end;

{ Tframe120ATehno }

procedure Tframe120ATehno.cxButton1Click(Sender: TObject);
begin
    while not IBCQueryATehnoGoods.Eof do
    begin
//        DoParse('9857902346399');
//        IBCQueryATehnoGoods.Last;
        DoParse(IBCQueryATehnoGoods.fieldbyname('goods_code').AsString);
        IBCQueryATehnoGoods.Next;
        application.ProcessMessages;
    end;
end;

procedure Tframe120ATehno.DeleteRecord;
begin
    inherited;

end;

procedure Tframe120ATehno.DoFrameHide;
begin
    inherited;
    IBCQueryATehnoGoods.Close;
end;

procedure Tframe120ATehno.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQueryATehnoGoods.open;
end;

procedure Tframe120ATehno.LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
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

procedure Tframe120ATehno.SaveImageToDB(const MemoryStream: TMemoryStream);
var
    b: TBitmap;
begin
    if not Assigned(MemoryStream) then
        raise Exception.Create('MemoryStream is not assigned.');

    cxImage1.Picture.LoadFromStream(MemoryStream);
    b := TBitmap.Create;
    try
        b.Assign(cxImage1.Picture.Bitmap);
        var pngImage := TdxpngImage.Create;
        try
            pngImage.Assign(b);
            MemoryStream.Position := 0;
            pngImage.SaveToStream(MemoryStream);
        finally
            pngImage.Free;
        end;
    finally
        b.Free;
    end;

    try
    // Start a transaction if necessary
        if not IBCSQL1.Transaction.Active then
            IBCSQL1.Transaction.StartTransaction;

    // Save the MemoryStream content to the query field
        MemoryStream.Position := 0;
        ibcsql1.ParamByName('goodsid').AsInteger := IBCQueryATehnoGoods.FieldByName('goodsid').AsInteger;
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
end;

procedure Tframe120ATehno.DoParse(GoodsCode: string);
var
    htmlSource: TStringList;
    FDocumentProductPage: IHTMLDocument2;
    vs, vp: OleVariant;
    vsd, vpd: OleVariant;
    alldivs: OleVariant;
    elements: OleVariant;
    thumbImageUrl: string;
    bigImageUrl: string;
    li_cnt: Integer;
    ResponseContent: string;
    Response: IHTTPResponse;
    productURL: string;
    JsonObject: TJSONObject;
    JsonString: string;
    ProductsHTML: string;
begin
    var ms := TMemoryStream.Create;
    htmlSource := TStringList.Create;
    try
        NetHttpClient1.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        NetHttpClient1.CustomHeaders['X-Requested-With'] := 'XMLHttpRequest';
        NetHttpClient1.CustomHeaders['Accept'] := 'application/json, text/javascript, */*; q=0.01';
        NetHttpClient1.CustomHeaders['Referer'] := 'https://atehno.md/';
        NetHttpClient1.CustomHeaders['Origin'] := 'https://atehno.md';

        Response := NetHTTPClient1.Get(format('https://atehno.md/search/catalog?keywords=%s&mode=simple', [GoodsCode]));
    // Обработка ответа
        if Response.StatusCode = 200 then
        begin
        // DecodeEscapedUnicode
            ResponseContent := (Response.ContentAsString(TEncoding.UTF8));
          // Здесь можно обработать JSON-ответ
//          ShowMessage(ResponseContent);
        end
        else
        begin
            ShowMessage('Ошибка: ' + Response.StatusCode.ToString);
        end;

        JsonObject := TJSONObject.ParseJSONValue(ResponseContent) as TJSONObject;

        if Assigned(JsonObject) then
        try
            ProductsHTML := JsonObject.GetValue<string>('products');
        finally
            JsonObject.Free;
        end;

        ms.Position := 0;
        htmlSource.Text := ProductsHTML;

        FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
//        FDocumentProductPage.designMode := 'on';
        vs := VarArrayCreate([0, 0], varVariant);
        vs[0] := htmlSource.Text;
        FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
        FDocumentBody := FDocumentProductPage.Body;
    finally
        ms.Free;
        htmlSource.Free;
    end;

    alldivs := FDocumentBody.All.Tags('a');

    li_cnt := Integer(alldivs.length) - 1;
    if (li_cnt >= 0) then
    begin
        productURL := alldivs.item(0).href;
    end;

    NetHttpClient1.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
    NetHttpClient1.CustomHeaders['X-Requested-With'] := 'XMLHttpRequest';
    NetHttpClient1.CustomHeaders['Accept'] := 'application/json, text/javascript, */*; q=0.01';
    NetHttpClient1.CustomHeaders['Referer'] := 'https://atehno.md/';
    NetHttpClient1.CustomHeaders['Origin'] := 'https://atehno.md';

    if productURL <> '' then
    begin

        Response := NetHTTPClient1.Get(productURL);
    // Обработка ответа
        if Response.StatusCode = 200 then
        begin
            ResponseContent := (Response.ContentAsString(TEncoding.UTF8));
        end
        else
        begin
            ShowMessage('Ошибка: ' + Response.StatusCode.ToString);
        end;

        FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
        vsd := VarArrayCreate([0, 0], varVariant);
        vsd[0] := ResponseContent;
        FDocumentProductPage.Write(PSafeArray(TVarData(vsd).VArray)); // write data from IdHTTP
        FDocumentBody := FDocumentProductPage.Body;

        alldivs := FDocumentBody.All.Tags('ul');

        for var j := 0 to integer(alldivs.Length) - 1 do
        begin
            if string(alldivs.item(j).ClassName)='bxslider product-carousel' then
            begin
                elements := alldivs.item(j).getElementsByTagName('a');
                if elements.Length > 0 then
                begin
                    for var k := 0 to integer(elements.Length)-1 do
                    begin
                        thumbImageUrl := elements.item(k).getElementsByTagName('img').item(0).src;

                        bigImageUrl := StringReplace(thumbImageUrl, 'thumb_500x500_', '', []);

                        if (bigImageUrl <> '') then
                        begin
                            var ImageStream := TMemoryStream.Create;
                            try
                                LoadImageFromURL(bigImageUrl, ImageStream);
                                var PNGImageStream := TMemoryStream.Create;
                                try
                                    ConvertImageToPNG(ImageStream, PNGImageStream);
                                    PNGImageStream.Position := 0;
                                    cxImage1.Picture.LoadFromStream(PNGImageStream);
                                    application.ProcessMessages;
                                    SaveImageToDB(PNGImageStream);
                                finally
                                    PNGImageStream.Free;
                                end;
                            finally
                                ImageStream.Free;
                            end;
                            Application.ProcessMessages;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function Tframe120ATehno.IdentifyImageFormat(const Stream: TStream): string;
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

procedure Tframe120ATehno.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
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
        Exit;
//        raise Exception.Create('Unsupported or unrecognized image format.');

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
//    else if ImageFormat = 'webp' then
//      Graphic := TWebPImage.Create(Panel1); // WebP support from Vcl.Imaging.WebP

        InputStream.Position := 0; // Reset stream to start
        Graphic.LoadFromStream(InputStream);

    // Convert the image to PNG
        PNGImage := TPngImage.Create;
        var Bitmap := TBitmap.Create;
        try
            Bitmap.Assign(Graphic);
            PNGImage.Assign(Bitmap);
            PNGImage.SaveToStream(OutputStream);
        finally
            PNGImage.Free;
            Bitmap.free;
        end;
    finally
        Graphic.Free;
    end;
end;

function Tframe120ATehno.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe120ATehno.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe120ATehno.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe120ATehno.InitFrameID: Integer;
begin
    Result := 120;
end;

procedure Tframe120ATehno.PrepareData;
begin

end;

procedure Tframe120ATehno.ReadFrameStates;
begin
    inherited;

end;

procedure Tframe120ATehno.RefreshData;
begin
    inherited;

end;

procedure Tframe120ATehno.SaveFrameStates;
begin
    inherited;

end;

end.


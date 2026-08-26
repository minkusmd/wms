unit frame124HiTechUnit;

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

const
    hostname = 'https://technodom.md';

type
    Tframe124HiTech = class(TSWNBaseFrame)
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
    ComObj;

{$R *.dfm}

{ Tframe120ATehno }

procedure Tframe124HiTech.cxButton1Click(Sender: TObject);
begin
    while not IBCQuerySupplierGoods.Eof do
    begin
        DoParse(IBCQuerySupplierGoods.fieldbyname('goods_code').AsString);
        IBCQuerySupplierGoods.Next;
        application.ProcessMessages;
        sleep(100);
//        IBCQuerySupplierGoods.Last;
    end;
end;

procedure Tframe124HiTech.DeleteRecord;
begin
    inherited;

end;

procedure Tframe124HiTech.DoFrameHide;
begin
    inherited;
    IBCQuerySupplierGoods.Close;
end;

procedure Tframe124HiTech.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQuerySupplierGoods.open;
end;

procedure Tframe124HiTech.LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
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

procedure Tframe124HiTech.SaveImageToDB(const MemoryStream: TMemoryStream);
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

            // Переводим в Bitmap
            Bitmap.Assign(JpegImage);

            // Сохраняем Bitmap в MemoryStream
            Bitmap.SaveToStream(MemoryStream);
            MemoryStream.Position := 0;  // Обнуляем позицию потока

            // Загружаем Bitmap в PNG
            PngImage.Assign(Bitmap);

            // Сохраняем PNG в файл
            PngImage.SaveToStream(MemoryStream);

        except on e: Exception do
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
//    cxImage1.Picture.LoadFromStream(MemoryStream);
//    Application.ProcessMessages;
//    MemoryStream.Position := 0;
//    TdxPNGImage(cxImage1.Picture).SaveToStream(MemoryStream);

//
//    b := TBitmap.Create;
//    try
//        b.Assign(cxImage1.Picture.Graphic);
//
//        var pngImage := TdxPNGImage.Create;
//        try
//            pngImage.Assign(b);
//            MemoryStream.Position := 0;
//            pngImage.SaveToStream(MemoryStream);
//        finally
//            pngImage.Free;
//        end;
//    finally
//        b.Free;
//    end;


end;

procedure Tframe124HiTech.DoParse(GoodsCode: string);
var
    htmlSource: TStringList;
    FDocumentProductPage: IHTMLDocument2;
    vs, vp: OleVariant;
    alldivs: OleVariant;
    elements: OleVariant;
    bigImageUrl: string;
    k: integer;
    len: integer;
begin
    var ms := TMemoryStream.Create;
    htmlSource := TStringList.Create;
    try
        NetHTTPClient1.Get(format('https://www.technodom.md/index.php?route=product/search&search=%s', [GoodsCode]), ms);
        ms.Position := 0;
        htmlSource.LoadfromStream(ms);

        FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
        FDocumentProductPage.designMode := 'on';
        vs := VarArrayCreate([0, 0], varVariant);
        vs[0] := htmlSource.Text;
//        cxmemo1.lines.text := htmlSource.Text;
        FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
        FDocumentBody := FDocumentProductPage.body as IHTMLElement;
    finally
        ms.free;
        htmlSource.Free;
    end;
    alldivs := FDocumentBody.All.Tags('div');
    for var j := 0 to integer(alldivs.Length) - 1 do
    begin
        if string(alldivs.item(j).ClassName).Contains('product-thumb transition') then
        begin
            elements := alldivs.item(j).getElementsByTagName('a');
            if elements.length > 0 then
                for k := 0 to elements.Length - 1 do
                begin
//                if (elements.item(k).ClassName='product-thumb transition') then
//                begin

                    len := elements.item(k).getElementsByTagName('img').Length;
                    cxmemo1.lines.text := elements.item(k).innerHTML;
                    bigImageUrl := elements.item(k).getElementsByTagName('img').item(0).getAttribute('src');
                    bigImageUrl := StringReplace(bigImageUrl, '228x228', '800x800', []);
                    var ImageStream := TMemoryStream.Create;
                    try
                        LoadImageFromURL(bigImageUrl, ImageStream);
                        var PNGImageStream := TMemoryStream.Create;
                        try
//                            ConvertImageToPNG(ImageStream, PNGImageStream);
                            SaveImageToDB(ImageStream);
                        finally
                            PNGImageStream.Free;
                        end;
                    finally
                        ImageStream.Free;
                    end;
                    Application.ProcessMessages;
                    Break;
//                end;
                end;
        end;
    end;
end;

function Tframe124HiTech.IdentifyImageFormat(const Stream: TStream): string;
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

//procedure Tframe122Samsonite.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
//var
//    ImageFormat: string;
//    Graphic: TGraphic;
//    PNGImage: TPngImage;
//begin
//    if not Assigned(InputStream) then
//        raise Exception.Create('Input stream is not assigned.');
//    if not Assigned(OutputStream) then
//        raise Exception.Create('Output stream is not assigned.');
//
//    InputStream.Position := 0; // Reset stream to start
//    ImageFormat := IdentifyImageFormat(InputStream);
//
//    if ImageFormat = '' then
//      Exit;
////        raise Exception.Create('Unsupported or unrecognized image format.');
//
//    Graphic := nil;
//    try
//    // Load the appropriate TGraphic class based on format
//        if ImageFormat = 'jpeg' then
//            Graphic := TJpegImage.Create
//        else if ImageFormat = 'png' then
//            Graphic := TPngImage.Create
//        else if ImageFormat = 'gif' then
//            Graphic := TGIFImage.Create
//        else if ImageFormat = 'bmp' then
//            Graphic := TBitmap.Create;
////    else if ImageFormat = 'webp' then
////      Graphic := TWebPImage.Create(Panel1); // WebP support from Vcl.Imaging.WebP
//
//        InputStream.Position := 0; // Reset stream to start
//        Graphic.LoadFromStream(InputStream);
//
//    // Convert the image to PNG
//        PNGImage := TPngImage.Create;
//        var Bitmap := TBitmap.Create;
//        try
//            Bitmap.Assign(Graphic);
//            PNGImage.Assign(Bitmap);
//            PNGImage.CreateAlpha;
//            PNGImage.SaveToStream(OutputStream);
//        finally
//            PNGImage.Free;
//            Bitmap.free;
//        end;
//    finally
//        Graphic.Free;
//    end;
//end;

procedure Tframe124HiTech.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
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

function Tframe124HiTech.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe124HiTech.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe124HiTech.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe124HiTech.InitFrameID: Integer;
begin
    Result := 124;
end;

procedure Tframe124HiTech.PrepareData;
begin

end;

procedure Tframe124HiTech.ReadFrameStates;
begin
    inherited;

end;

procedure Tframe124HiTech.RefreshData;
begin
    IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe124HiTech.SaveFrameStates;
begin
    inherited;

end;

end.


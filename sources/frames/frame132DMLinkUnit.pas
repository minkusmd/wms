unit frame132DMLinkUnit;

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
    cxContainer, cxImage, Vcl.ExtCtrls, cxTextEdit, cxMemo, cxProgressBar, dmlink.api;

const
    hostname = 'https://api.nexdistribution.md';

type
    Tframe132DMLink = class(TSWNBaseFrame)
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
        Memo1: TcxMemo;
        cxProgressBar2: TcxProgressBar;
    Button1: TButton;
        procedure Button1Click(Sender: TObject);
        procedure cxButton1Click(Sender: TObject);

    private
        FDocumentBody: OleVariant;
        procedure LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
        procedure SaveImageToDB(const MemoryStream: TMemoryStream);
        procedure ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
        function IdentifyImageFormat(const Stream: TStream): string;
        procedure GetImages;
        function GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;

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
// TODO: DoParse
//      procedure DoParse(GoodsCode: string);
    end;

implementation

uses
  ComObj, DMLinkAPIClientUnit, DataModuleDB, MSHTML, dxGDIPlusClasses,
  Vcl.ComCtrls,
  Vcl.Imaging.GIFImg,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage,
  Vcl.OleAuto,
  Vcl.WebpImage,
  Winapi.ActiveX;

{$R *.dfm}

procedure Tframe132DMLink.Button1Click(Sender: TObject);
begin
  inherited;
  var dmlinkapi := TDMLinkAPI.Create;
  try
    if dmlinkapi.Login('duca.al@gmail.com', 'Uno2025!@') then
      memo1.lines.text := dmlinkapi.GetProducts;
  finally
    dmlinkapi.Free;
  end;
end;

{ Tframe120ATehno }

function Tframe132DMLink.GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select goodsid from ts_goods_foreign where customerid = :customerid and goods_code = :goods_code';
        q.ParamByName('goods_code').AsString := GoodsCode;
        q.ParamByName('customerid').AsInteger := SupplierID;
        q.Open;
    finally
        if q.RecordCount > 0 then
            Result := q.FieldByName('goodsid').AsInteger
        else
            Result := -1;
        q.Free;
    end;
end;

procedure Tframe132DMLink.GetImages;
var
    ImageFileNameList: TStringList;
    GoodsID: Integer;
    ms: TMemoryStream;
    ibcsql: TIBCSQL;
    ibcsqlPrice: TIBCSQL;
    trUpdate: TIBCTransaction;
    s: string;
    Response: IHTTPResponse;
    UrlArray: TArray<string>;
    p: string;
    GoodsNotFoundCount: integer;
begin
    ImageFileNameList := TStringList.Create;
    IBCQuerySupplierGoods.Open;
    ImageFileNameList.Delimiter := ';';
    ibcsql := TIBCSQL.Create(nil);
    trUpdate := TIBCTransaction.Create(nil);

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    ibcsql.transaction := trUpdate;
    GoodsNotFoundCount := 0;
    var GoodsFound := 0;
    memo1.Lines.Clear;
    try
        if not trUpdate.Active then
            trUpdate.StartTransaction;

        cxProgressBar2.properties.Min := 0;
        cxProgressBar2.properties.Max := IBCQuerySupplierGoods.RecordCount;
        while not IBCQuerySupplierGoods.eof do
        begin
            GoodsID := GetGoodsID(IBCQuerySupplierGoods.FieldByName('goods_code').AsString, IBCQuerySupplierGoods.FieldByName('supplierid').AsInteger);
            if GoodsID = -1 then
            begin
                IBCQuerySupplierGoods.Next;
                inc(GoodsNotFoundCount);
                Memo1.Lines.Add('Error: ' + IBCQuerySupplierGoods.FieldByName('goods_code').AsString);
                Continue;
            end;

            s := IBCQuerySupplierGoods.FieldByName('images').AsString;
            UrlArray := s.Split([';']);
            ImageFileNameList.Clear;
            for p in UrlArray do
                ImageFileNameList.Add(p);

            dmdb.ExecuteQuery('delete from ts_goods_image where goodsid = :goodsid', [GoodsID]);

            ibcsql.AutoCommit := false;
            inc(GoodsFound);
            for var j := 0 to ImageFileNameList.Count - 1 do
            begin
                ms := TMemoryStream.Create;
                try
                    try
                        s := ImageFileNameList[j];
                        Response := NetHttpClient1.Get(ImageFileNameList[j]);
                        if Response.StatusCode = 200 then
                        begin
                            var pngImage := TdxSmartImage.Create;
                            try
                                ms.LoadFromStream(Response.ContentStream);
                                ms.Position := 0;
                                cxImage1.Picture.LoadFromStream(ms);

                                var bitmap := TBitmap.Create;
                                try
                                    bitmap.Assign(cxImage1.Picture.Graphic);
                                    pngImage := TdxSmartImage.CreateFromBitmap(bitmap);
                                    var PNGImageStream := TMemoryStream.Create;
                                    try
                                        pngImage.SaveToStreamByCodec(PNGImageStream, TdxImageDataFormat.dxImagePng);
                                        PNGImageStream.Position := 0;
                                        PNGImageStream.SaveToFile('tmp.png');
                                    finally
                                        PNGImageStream.Free;
                                    end;
                                    application.ProcessMessages;
                                finally
                                    bitmap.Free;
                                end;
                            finally
                                pngImage.Free;
                            end;

                            ibcsql.sql.Clear;
                            ibcsql.sql.add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
                            ibcsql.sql.add('values (:goodsid, :image, :flg_need2recreate)');
                            ibcsql.Prepare;

                            ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
                            ibcsql.ParamByName('image').LoadFromFile('tmp.png', ftBlob);
                            ibcsql.ParamByName('flg_need2recreate').Asinteger := 1;
                            ibcsql.Execute;
                        end
                        else
                            memo1.lines.add('Bad response: ' + GoodsID.ToString + ';  Response code: ' + Response.StatusCode.ToString);
                    except
                        memo1.lines.add('Error on GoodsID: ' + GoodsID.ToString + ';  Path: ' + ImageFileNameList[j]);
                        Continue;
                    end;

                    Application.ProcessMessages;
                finally
                    ms.Free;
                end;
            end;
            cxProgressBar2.Position := IBCQuerySupplierGoods.RecNo;
            Memo1.Lines.Add('added images for goods: ' + GoodsID.ToString);
            Application.ProcessMessages;
            IBCQuerySupplierGoods.Next;
        end;
        trUpdate.Commit;
        Memo1.Lines.Add('Not linked goods: ' + GoodsNotFoundCount.ToString);
        Memo1.Lines.Add('UpdatedGoods: ' + GoodsFound.ToString);
    finally
        ibcsql.Free;
        trUpdate.Free;
        ImageFileNameList.Free;
    end;
end;

procedure Tframe132DMLink.cxButton1Click(Sender: TObject);
begin
    GetImages;

//    while not IBCQuerySupplierGoods.Eof do
//    begin
//        DoParse(IBCQuerySupplierGoods.fieldbyname('goods_code').AsString);
//        IBCQuerySupplierGoods.Next;
//        application.ProcessMessages;
//    end;
end;

procedure Tframe132DMLink.DeleteRecord;
begin
    inherited;

end;

procedure Tframe132DMLink.DoFrameHide;
begin
    inherited;
    IBCQuerySupplierGoods.Close;
end;

procedure Tframe132DMLink.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQuerySupplierGoods.open;
end;

procedure Tframe132DMLink.LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
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

procedure Tframe132DMLink.SaveImageToDB(const MemoryStream: TMemoryStream);
var
    b: TBitmap;
begin
    if not Assigned(MemoryStream) then
        raise Exception.Create('MemoryStream is not assigned.');

    cxImage1.Picture.LoadFromStream(MemoryStream);
    Application.ProcessMessages;
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
end;

// TODO: DoParse
//procedure Tframe125NexDistribution.DoParse(GoodsCode: string);
//var
//  htmlSource: TStringList;
//  FDocumentProductPage: IHTMLDocument2;
//  vs, vp: OleVariant;
//  alldivs: OleVariant;
//  elements: OleVariant;
//  bigImageUrl: string;
//  k: integer;
//  len: integer;
//begin
//  var ms := TMemoryStream.Create;
//  htmlSource := TStringList.Create;
//  try
//      NetHTTPClient1.Get(format('https://samsonite.md/cautare/?global-search=%s', [GoodsCode]), ms);
//      ms.Position := 0;
//      htmlSource.LoadfromStream(ms);
//
//      FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
//      FDocumentProductPage.designMode := 'on';
//      vs := VarArrayCreate([0, 0], varVariant);
//      vs[0] := htmlSource.Text;
////        cxmemo1.lines.text := htmlSource.Text;
//      FDocumentProductPage.Write(PSafeArray(TVarData(vs).VArray)); // write data from IdHTTP
//      FDocumentBody := FDocumentProductPage.body as IHTMLElement;
//  finally
//      ms.free;
//      htmlSource.Free;
//  end;
//  alldivs := FDocumentBody.All.Tags('div');
//  for var j := 0 to integer(alldivs.Length) - 1 do
//  begin
//      if string(alldivs.item(j).ClassName).Contains('product-tile__image') then
//      begin
//          elements := alldivs.item(j).getElementsByTagName('a');
//          if elements.length>0 then
//          for k := 0 to elements.Length-1 do
//          begin
//              if (elements.item(k).ClassName='product-tile-link') then
//              begin
//                  len := elements.item(k).getElementsByTagName('img').Length;
//                  cxmemo1.lines.text := elements.item(k).innerHTML;
//                  bigImageUrl := hostname + elements.item(k).getElementsByTagName('img').item(0).getAttribute('data-src');
//                  var ImageStream := TMemoryStream.Create;
//                  try
//                      LoadImageFromURL(bigImageUrl, ImageStream);
//                      var PNGImageStream := TMemoryStream.Create;
//                      try
//                          ConvertImageToPNG(ImageStream, PNGImageStream);
//                          SaveImageToDB(ImageStream);
////                             ConvertImageToPNG(ImageStream, PNGImageStream);
////                            SaveImageToDB(PNGImageStream);
//                      finally
//                          PNGImageStream.Free;
//                      end;
//                  finally
//                      ImageStream.Free;
//                  end;
//                  Application.ProcessMessages;
//                  sleep(1000);
//                  Break;
//              end;
//          end;
//      end;
//  end;
//end;

function Tframe132DMLink.IdentifyImageFormat(const Stream: TStream): string;
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

procedure Tframe132DMLink.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
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
                PNGImage.CreateAlpha;

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

function Tframe132DMLink.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe132DMLink.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe132DMLink.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe132DMLink.InitFrameID: Integer;
begin
    Result := 132;
end;

procedure Tframe132DMLink.PrepareData;
begin

end;

procedure Tframe132DMLink.ReadFrameStates;
begin
    inherited;

end;

procedure Tframe132DMLink.RefreshData;
begin
    IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe132DMLink.SaveFrameStates;
begin
    inherited;

end;

end.


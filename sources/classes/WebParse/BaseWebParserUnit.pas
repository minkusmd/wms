unit BaseWebParserUnit;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Imaging.pngimage,
  System.Net.HttpClient, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.WebpImage, System.Net.HttpClientComponent;

type
  TBaseWebParser = class
  private
    FHttpClient: TNetHTTPClient;
    procedure LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
    procedure ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
  public
    constructor Create;
    destructor Destroy; override;

    // Metoda de baza pentru incarcarea paginii
    function LoadPage(const URL: string): string; virtual;

    // Salveaza imaginea in format PNG
    procedure SaveImageToPNG(const ImageURL: string; const SavePath: string);

    // Procedura de parsare suprascrisa
    procedure ParsePage(const PageContent: string); virtual; abstract;
    // identificarea imaginii
    function IdentifyImageFormat(const Stream: TStream): string;
  end;

implementation

{ TBaseWebParser }

constructor TBaseWebParser.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
end;

destructor TBaseWebParser.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TBaseWebParser.IdentifyImageFormat(const Stream: TStream): string;
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
    else if (Header[0] = $52) and (Header[1] = $49) and (Header[2] = $46) and (Header[3] = $46) and (Header[8] = $57) and (Header
        [9] = $45) and (Header[10] = $42) and (Header[11] = $50) then
        Result := 'webp';
end;

procedure TBaseWebParser.LoadImageFromURL(const URL: string; out ImageStream: TMemoryStream);
var
  HttpResponse: IHTTPResponse;
begin
  ImageStream := TMemoryStream.Create;
  try
    HttpResponse := FHttpClient.Get(URL);
    if HttpResponse.StatusCode = 200 then
      ImageStream.CopyFrom(HttpResponse.ContentStream, HttpResponse.ContentStream.Size);
  except
    on E: Exception do
      raise Exception.CreateFmt('Error loading image from URL: %s', [E.Message]);
  end;
end;

procedure TBaseWebParser.ConvertImageToPNG(const InputStream: TMemoryStream; out OutputStream: TMemoryStream);
var
  Graphic: TGraphic;
  PNGImage: TPngImage;
  ImageFormat: string;
begin
  InputStream.Position := 0;
  ImageFormat := IdentifyImageFormat(InputStream);

  if ImageFormat = 'jpeg' then
    Graphic := TJpegImage.Create
  else if ImageFormat = 'png' then
    Graphic := TPngImage.Create
  else if ImageFormat = 'gif' then
    Graphic := TGIFImage.Create
  else if ImageFormat = 'bmp' then
    Graphic := TBitmap.Create
  else
    raise Exception.Create('Unsupported image format');

  try
    InputStream.Position := 0;
    Graphic.LoadFromStream(InputStream);

    PNGImage := TPngImage.Create;
    try
      PNGImage.Assign(Graphic);
      PNGImage.CreateAlpha;
      OutputStream.Clear;
      PNGImage.SaveToStream(OutputStream);
    finally
      PNGImage.Free;
    end;
  finally
    Graphic.Free;
  end;
end;

function TBaseWebParser.LoadPage(const URL: string): string;
var
  HttpResponse: IHTTPResponse;
begin
  try
    HttpResponse := FHttpClient.Get(URL);
    if HttpResponse.StatusCode = 200 then
      Result := HttpResponse.ContentAsString()
    else
      raise Exception.Create('Error loading page');
  except
    on E: Exception do
      raise Exception.CreateFmt('Error loading page from URL: %s', [E.Message]);
  end;
end;

procedure TBaseWebParser.SaveImageToPNG(const ImageURL: string; const SavePath: string);
var
  ImageStream, PNGStream: TMemoryStream;
begin
  ImageStream := TMemoryStream.Create;
  PNGStream := TMemoryStream.Create;
  try
    LoadImageFromURL(ImageURL, ImageStream);
    ConvertImageToPNG(ImageStream, PNGStream);
    PNGStream.SaveToFile(SavePath);
  finally
    ImageStream.Free;
    PNGStream.Free;
  end;
end;


end.


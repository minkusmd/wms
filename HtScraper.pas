unit HtScraper;

{ Extrage din h-t.md poza și datele unui produs, căutându-l după cod.

  Site-ul (CS-Cart) generează paginile de căutare și de produs direct pe server,
  deci un simplu client HTTP înlocuiește Selenium + ChromeDriver din scriptul
  Python. Când o căutare are un singur rezultat, site-ul redirecționează către
  pagina produsului, iar clientul HTTP urmează redirect-ul. }

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient;

const
  cDefaultBaseUrl = 'https://h-t.md/md/';

type
  EScraperError = class(Exception);

  TProductInfo = record
    Code: string;
    Title: string;
    Price: string;
    ImageUrl: string;
  end;

  THtScraper = class
  private
    FBaseUrl: string;
    FHttp: THTTPClient;
    FComInitialized: Boolean;
    function GetHtml(const AUrl: string): string;
  public
    constructor Create(const ABaseUrl: string = cDefaultBaseUrl);
    destructor Destroy; override;

    /// Caută produsul după cod. False dacă nu există sau nu are imagine.
    function FindProduct(const ACode: string; out AProduct: TProductInfo): Boolean;

    /// Descarcă imaginea de la AImageUrl și o scrie în AOutput ca PNG.
    procedure DownloadAsPng(const AImageUrl: string; AOutput: TStream);

    /// Parsează o pagină HTML de produs sau de rezultate (public pentru teste).
    class function ParsePage(const AHtml, ACode: string;
      out AProduct: TProductInfo): Boolean;
  end;

implementation

uses
  System.StrUtils, System.NetEncoding, System.RegularExpressions,
  Winapi.Windows, Winapi.ActiveX, Vcl.Graphics;

const
  cSearchQuery = '?match=all&subcats=Y&pcode_from_q=Y&pshort=N&pfull=N&pname=Y' +
    '&pkeywords=Y&search_performed=Y&dispatch=products.search&q=';
  cUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
    '(KHTML, like Gecko) Chrome/124.0 Safari/537.36';
  cRxOptions = [roIgnoreCase, roSingleLine];

{ ---- Helpere de parsare HTML ---- }

/// Clasa CSS ca token întreg: ty-price nu trebuie să potrivească ty-price-num.
function ClassToken(const AName: string): string;
begin
  Result := '(?<![\w-])' + AName + '(?![\w-])';
end;

function FirstGroup(const AText, APattern: string): string;
var
  M: TMatch;
begin
  M := TRegEx.Match(AText, APattern, cRxOptions);
  if M.Success then
    Result := M.Groups[1].Value
  else
    Result := '';
end;

/// Restul textului începând de la marker (sau '' dacă markerul lipsește).
function After(const AText, AMarker: string): string;
var
  P: Integer;
begin
  P := AText.IndexOf(AMarker);
  if P < 0 then
    Result := ''
  else
    Result := AText.Substring(P);
end;

/// Elimină tag-urile, decodează entitățile HTML și normalizează spațiile.
function HtmlText(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, '<[^>]*>', ' ');
  // TNetEncoding.HTML nu decodează &nbsp; (prețurile de pe site îl folosesc)
  Result := TNetEncoding.HTML.Decode(Result.Replace('&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]))
    .Replace(#$00A0, ' ');
  Result := TRegEx.Replace(Result, '\s+', ' ').Trim;
end;

function AttrValue(const ATag, AName: string): string;
begin
  Result := TNetEncoding.HTML.Decode(
    FirstGroup(ATag, '(?<![\w-])' + AName + '\s*=\s*"([^"]*)"'));
end;

/// URL-ul primei imagini ty-pict din fragment. Pe paginile de listă imaginea
/// vine în atribute de lazy-load (data-lazy_src / data-src), nu în src.
function ExtractImageUrl(const AHtml: string): string;
var
  Tag, AttrName: string;
begin
  Result := '';
  Tag := TRegEx.Match(AHtml, '<img\b[^>]*' + ClassToken('ty-pict') + '[^>]*>',
    cRxOptions).Value;
  if Tag = '' then
    Exit;
  for AttrName in ['data-lazy_src', 'data-src', 'src'] do
  begin
    Result := AttrValue(Tag, AttrName).Trim;
    if (Result <> '') and not Result.StartsWith('data:') then
      Exit;
  end;
  Result := '';
end;

function ExtractPrice(const AHtml: string): string;
begin
  Result := HtmlText(FirstGroup(AHtml,
    'class="(?:[^"]*\s)?ty-price(?:\s[^"]*)?"[^>]*>\s*<bdi>(.*?)</bdi>'));
end;

function BlockMatchesCode(const ABlock, ACode: string): Boolean;
var
  Sku: string;
begin
  Sku := HtmlText(FirstGroup(ABlock, ClassToken('ty-sku-item') +
    '.*?<span\b[^>]*' + ClassToken('ty-control-group__item') + '[^>]*>(.*?)</span>'));
  if Sku <> '' then
    Result := ContainsText(Sku, ACode)
  else
    Result := ContainsText(HtmlText(ABlock), ACode);
end;

function ParseProductPage(const AHtml: string; var AProduct: TProductInfo): Boolean;
begin
  AProduct.Title := HtmlText(FirstGroup(AHtml,
    '<h1\b[^>]*' + ClassToken('ty-product-block-title') + '[^>]*>(.*?)</h1>'));
  AProduct.Price := ExtractPrice(After(AHtml, 'ty-product-block__price-actual'));
  AProduct.ImageUrl := ExtractImageUrl(After(AHtml, 'ty-product-block__img-wrapper'));
  Result := AProduct.ImageUrl <> '';
end;

function ParseSearchList(const AHtml, ACode: string; var AProduct: TProductInfo): Boolean;
var
  Starts: TMatchCollection;
  I, BlockEnd: Integer;
  Block, ImageUrl: string;
begin
  Result := False;
  Starts := TRegEx.Matches(AHtml, 'class="[^"]*' + ClassToken('ty-grid-list__item'),
    cRxOptions);
  for I := 0 to Starts.Count - 1 do
  begin
    if I < Starts.Count - 1 then
      BlockEnd := Starts[I + 1].Index
    else
      BlockEnd := Length(AHtml) + 1;
    Block := Copy(AHtml, Starts[I].Index, BlockEnd - Starts[I].Index);
    if not BlockMatchesCode(Block, ACode) then
      Continue;
    ImageUrl := ExtractImageUrl(Block);
    if ImageUrl = '' then
      Continue;
    AProduct.ImageUrl := ImageUrl;
    AProduct.Title := HtmlText(FirstGroup(Block,
      '<a\b[^>]*' + ClassToken('product-title') + '[^>]*>(.*?)</a>'));
    AProduct.Price := ExtractPrice(Block);
    Exit(True);
  end;
end;

{ ---- Helpere URL ---- }

/// Codifică procentual caracterele non-ASCII și spațiile (ex. nume de fișiere
/// cu chirilice în URL-urile imaginilor). '%' rămâne neschimbat.
function EscapeUrl(const AUrl: string): string;
const
  cUnsafe: set of Byte = [Ord('"'), Ord('<'), Ord('>'), Ord('\'), Ord('^'),
    Ord('`'), Ord('{'), Ord('|'), Ord('}')];
var
  B: Byte;
begin
  Result := '';
  for B in TEncoding.UTF8.GetBytes(AUrl) do
    if (B > 127) or (B <= 32) or (B in cUnsafe) then
      Result := Result + '%' + IntToHex(B, 2)
    else
      Result := Result + Char(B);
end;

function ResolveUrl(const ABaseUrl, AUrl: string): string;
var
  Scheme, Host: string;
  P: Integer;
begin
  if AUrl.StartsWith('http://', True) or AUrl.StartsWith('https://', True) then
    Exit(AUrl);
  P := ABaseUrl.IndexOf('://');
  Scheme := ABaseUrl.Substring(0, P);
  Host := ABaseUrl.Substring(P + 3);
  if Host.Contains('/') then
    Host := Host.Substring(0, Host.IndexOf('/'));
  if AUrl.StartsWith('//') then
    Result := Scheme + ':' + AUrl
  else if AUrl.StartsWith('/') then
    Result := Scheme + '://' + Host + AUrl
  else
    Result := ABaseUrl + AUrl;
end;

{ THtScraper }

constructor THtScraper.Create(const ABaseUrl: string);
begin
  inherited Create;
  FBaseUrl := ABaseUrl;
  if not FBaseUrl.EndsWith('/') then
    FBaseUrl := FBaseUrl + '/';
  // WIC (folosit la conversia în PNG) cere COM inițializat pe thread-ul curent.
  // S_FALSE = deja inițializat, dar și atunci trebuie un CoUninitialize pereche.
  FComInitialized := Succeeded(CoInitializeEx(nil, COINIT_APARTMENTTHREADED));
  FHttp := THTTPClient.Create;
  FHttp.UserAgent := cUserAgent;
  FHttp.ConnectionTimeout := 10000;
  FHttp.ResponseTimeout := 30000;
  FHttp.CustomHeaders['Accept-Language'] := 'ro,ru;q=0.8,en;q=0.5';
end;

destructor THtScraper.Destroy;
begin
  FHttp.Free;
  if FComInitialized then
    CoUninitialize;
  inherited;
end;

function THtScraper.GetHtml(const AUrl: string): string;
var
  Response: IHTTPResponse;
begin
  Response := FHttp.Get(AUrl);
  if Response.StatusCode <> 200 then
    raise EScraperError.CreateFmt('HTTP %d la %s', [Response.StatusCode, AUrl]);
  Result := Response.ContentAsString(TEncoding.UTF8);
end;

class function THtScraper.ParsePage(const AHtml, ACode: string;
  out AProduct: TProductInfo): Boolean;
begin
  AProduct := Default(TProductInfo);
  AProduct.Code := ACode;
  // Pagina de produs (rezultat unic după redirect) vs. lista de rezultate.
  // Nu se încearcă ambele: pagina de produs conține și liste de produse
  // similare, care ar putea da potriviri false.
  if TRegEx.IsMatch(AHtml, '<h1\b[^>]*' + ClassToken('ty-product-block-title'),
    cRxOptions) then
    Result := ParseProductPage(AHtml, AProduct)
  else
    Result := ParseSearchList(AHtml, ACode, AProduct);
end;

function THtScraper.FindProduct(const ACode: string;
  out AProduct: TProductInfo): Boolean;
begin
  Result := ParsePage(GetHtml(FBaseUrl + cSearchQuery + TNetEncoding.URL.Encode(ACode)),
    ACode, AProduct);
  if Result then
    AProduct.ImageUrl := ResolveUrl(FBaseUrl, AProduct.ImageUrl);
end;

procedure THtScraper.DownloadAsPng(const AImageUrl: string; AOutput: TStream);
var
  Raw: TMemoryStream;
  Response: IHTTPResponse;
  Image: TWICImage;
begin
  Raw := TMemoryStream.Create;
  try
    Response := FHttp.Get(EscapeUrl(AImageUrl), Raw);
    if Response.StatusCode <> 200 then
      raise EScraperError.CreateFmt('HTTP %d la %s', [Response.StatusCode, AImageUrl]);
    Raw.Position := 0;
    Image := TWICImage.Create;
    try
      Image.LoadFromStream(Raw);
      Image.ImageFormat := wifPng;
      Image.SaveToStream(AOutput);
    finally
      Image.Free;
    end;
  finally
    Raw.Free;
  end;
end;

end.

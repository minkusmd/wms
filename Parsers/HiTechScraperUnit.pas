unit HiTechScraperUnit;

{ Cauta un produs pe h-t.md (Hi-Tech Moldova) dupa codul furnizorului si
  intoarce titlul, pretul si poza principala.

  Site-ul (CS-Cart) genereaza paginile de cautare si de produs pe server, deci
  este de ajuns un client HTTP - nu este nevoie de browser sau de MSHTML. Cand
  cautarea are un singur rezultat, site-ul redirectioneaza catre pagina
  produsului, iar clientul HTTP urmeaza redirectul. }

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient;

const
  cHiTechBaseUrl = 'https://h-t.md/md/';

type
  EHiTechScraperError = class(Exception);

  TProductInfo = record
    Code: string;
    Title: string;
    Price: string;
    ImageUrl: string;
  end;

  THiTechScraper = class
  private
    FBaseUrl: string;
    FHttp: THTTPClient;
    FComInitialized: Boolean;
    function GetHtml(const AUrl: string): string;
  public
    constructor Create(const ABaseUrl: string = cHiTechBaseUrl);
    destructor Destroy; override;

    // Cauta produsul dupa cod. False daca nu exista sau nu are poza.
    function FindProduct(const ACode: string; out AProduct: TProductInfo): Boolean;

    // Pretul de vinzare afisat pe site (MDL). Spre deosebire de FindProduct nu cere poza,
    // dar cere ca pe pagina / in blocul gasit codul (SKU) sa fie EXACT ACode - la preturi
    // o potrivire aproximativa ar insemna pretul altui produs.
    // False = produsul nu a fost gasit, codul nu corespunde sau pretul nu e un numar pozitiv.
    function FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean;

    // Descarca poza de la AImageUrl si o scrie in AOutput ca PNG.
    procedure DownloadAsPng(const AImageUrl: string; AOutput: TStream);
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

{ Helpere de parsare HTML }

// Clasa CSS ca token intreg: ty-price nu trebuie sa potriveasca ty-price-num.
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

// Restul textului incepand de la marker (sau '' daca markerul lipseste).
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

// Elimina tagurile, decodeaza entitatile HTML si normalizeaza spatiile.
function HtmlText(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, '<[^>]*>', ' ');
  // TNetEncoding.HTML nu decodeaza &nbsp; (preturile de pe site il folosesc)
  Result := TNetEncoding.HTML.Decode(Result.Replace('&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]))
    .Replace(#$00A0, ' ');
  Result := TRegEx.Replace(Result, '\s+', ' ').Trim;
end;

function AttrValue(const ATag, AName: string): string;
begin
  Result := TNetEncoding.HTML.Decode(
    FirstGroup(ATag, '(?<![\w-])' + AName + '\s*=\s*"([^"]*)"'));
end;

// URL-ul primei poze ty-pict din fragment. In paginile de lista poza vine in
// atribute de lazy-load (data-lazy_src / data-src), nu in src.
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

function ExtractSku(const ABlock: string): string;
begin
  Result := Trim(HtmlText(FirstGroup(ABlock, ClassToken('ty-sku-item') +
    '.*?<span\b[^>]*' + ClassToken('ty-control-group__item') + '[^>]*>(.*?)</span>')));
end;

// "5 999 MDL", "1&nbsp;559", "999.50" -> numar. Separatorul de mii poate fi spatiu,
// spatiu nedespartitor sau apostrof; zecimalele, daca exista, sint dupa ultimul '.' sau ','.
function ParsePriceText(const AText: string; out APrice: Currency): Boolean;
var
  Clean: string;
  Ch: Char;
  P: Integer;
  FS: TFormatSettings;
begin
  APrice := 0;
  Clean := '';
  for Ch in AText do
    if CharInSet(Ch, ['0'..'9', '.', ',']) then
      Clean := Clean + Ch;
  if Clean = '' then
    Exit(False);
  // ultimul separator urmat de 1-2 cifre = zecimale; orice alt separator = mii
  P := LastDelimiter('.,', Clean);
  if (P > 0) and (Length(Clean) - P in [1, 2]) then
    Clean := StringReplace(StringReplace(Copy(Clean, 1, P - 1), '.', '', [rfReplaceAll]), ',', '', [rfReplaceAll]) +
      '.' + Copy(Clean, P + 1, MaxInt)
  else
    Clean := StringReplace(StringReplace(Clean, '.', '', [rfReplaceAll]), ',', '', [rfReplaceAll]);
  FS := TFormatSettings.Invariant;
  Result := TryStrToCurr(Clean, APrice, FS) and (APrice > 0);
end;

// Pretul si titlul produsului cu SKU = ACode, din pagina de produs sau din lista de rezultate.
function ParsePriceFromPage(const AHtml, ACode: string; out APriceText, ATitle: string): Boolean;
var
  Starts: TMatchCollection;
  I, BlockEnd: Integer;
  Block: string;
begin
  Result := False;
  APriceText := '';
  ATitle := '';
  if TRegEx.IsMatch(AHtml, '<h1\b[^>]*' + ClassToken('ty-product-block-title'), cRxOptions) then
  begin
    if not SameText(ExtractSku(AHtml), Trim(ACode)) then
      Exit;
    ATitle := HtmlText(FirstGroup(AHtml,
      '<h1\b[^>]*' + ClassToken('ty-product-block-title') + '[^>]*>(.*?)</h1>'));
    APriceText := ExtractPrice(After(AHtml, 'ty-product-block__price-actual'));
    Exit(APriceText <> '');
  end;

  Starts := TRegEx.Matches(AHtml, 'class="[^"]*' + ClassToken('ty-grid-list__item'), cRxOptions);
  for I := 0 to Starts.Count - 1 do
  begin
    if I < Starts.Count - 1 then
      BlockEnd := Starts[I + 1].Index
    else
      BlockEnd := Length(AHtml) + 1;
    Block := Copy(AHtml, Starts[I].Index, BlockEnd - Starts[I].Index);
    if not SameText(ExtractSku(Block), Trim(ACode)) then
      Continue;
    ATitle := HtmlText(FirstGroup(Block,
      '<a\b[^>]*' + ClassToken('product-title') + '[^>]*>(.*?)</a>'));
    APriceText := ExtractPrice(Block);
    Exit(APriceText <> '');
  end;
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

function ParsePage(const AHtml, ACode: string; out AProduct: TProductInfo): Boolean;
begin
  AProduct := Default(TProductInfo);
  AProduct.Code := ACode;
  // Pagina de produs (rezultat unic, dupa redirect) sau lista de rezultate.
  // Nu se incearca ambele: pagina de produs contine si liste de produse
  // similare, care ar putea da potriviri false.
  if TRegEx.IsMatch(AHtml, '<h1\b[^>]*' + ClassToken('ty-product-block-title'),
    cRxOptions) then
    Result := ParseProductPage(AHtml, AProduct)
  else
    Result := ParseSearchList(AHtml, ACode, AProduct);
end;

{ Helpere URL }

// Codifica procentual caracterele non-ASCII si spatiile (de ex. nume de fisiere
// cu chirilice in URL-urile pozelor). '%' ramane neschimbat.
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

{ THiTechScraper }

constructor THiTechScraper.Create(const ABaseUrl: string);
begin
  inherited Create;
  FBaseUrl := ABaseUrl;
  if not FBaseUrl.EndsWith('/') then
    FBaseUrl := FBaseUrl + '/';
  // WIC (folosit la conversia in PNG) cere COM initializat pe threadul curent.
  // S_FALSE = deja initializat, dar si atunci trebuie un CoUninitialize pereche.
  FComInitialized := Succeeded(CoInitializeEx(nil, COINIT_APARTMENTTHREADED));
  FHttp := THTTPClient.Create;
  FHttp.UserAgent := cUserAgent;
  FHttp.ConnectionTimeout := 10000;
  FHttp.ResponseTimeout := 30000;
  FHttp.CustomHeaders['Accept-Language'] := 'ro,ru;q=0.8,en;q=0.5';
end;

destructor THiTechScraper.Destroy;
begin
  FHttp.Free;
  if FComInitialized then
    CoUninitialize;
  inherited;
end;

function THiTechScraper.GetHtml(const AUrl: string): string;
var
  Response: IHTTPResponse;
begin
  Response := FHttp.Get(AUrl);
  if Response.StatusCode <> 200 then
    raise EHiTechScraperError.CreateFmt('HTTP %d la %s', [Response.StatusCode, AUrl]);
  Result := Response.ContentAsString(TEncoding.UTF8);
end;

function THiTechScraper.FindProduct(const ACode: string;
  out AProduct: TProductInfo): Boolean;
begin
  Result := ParsePage(GetHtml(FBaseUrl + cSearchQuery + TNetEncoding.URL.Encode(ACode)),
    ACode, AProduct);
  if Result then
    AProduct.ImageUrl := ResolveUrl(FBaseUrl, AProduct.ImageUrl);
end;

function THiTechScraper.FindPrice(const ACode: string; out APrice: Currency;
  out ATitle: string): Boolean;
var
  PriceText: string;
begin
  APrice := 0;
  Result := ParsePriceFromPage(GetHtml(FBaseUrl + cSearchQuery + TNetEncoding.URL.Encode(ACode)),
    ACode, PriceText, ATitle) and ParsePriceText(PriceText, APrice);
end;

procedure THiTechScraper.DownloadAsPng(const AImageUrl: string; AOutput: TStream);
var
  Raw: TMemoryStream;
  Response: IHTTPResponse;
  Image: TWICImage;
begin
  Raw := TMemoryStream.Create;
  try
    Response := FHttp.Get(EscapeUrl(AImageUrl), Raw);
    if Response.StatusCode <> 200 then
      raise EHiTechScraperError.CreateFmt('HTTP %d la %s', [Response.StatusCode, AImageUrl]);
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

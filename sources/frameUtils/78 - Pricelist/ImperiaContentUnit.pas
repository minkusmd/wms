unit ImperiaContentUnit;

{
  Continut produse de la furnizorul imperia.md (CustomerID 74852), analog cu MamicoContentUnit.

  Pentru fiecare articol din pricelist:
    1. cautare pe site dupa SUPPLIER_GOODS_CODE:
         https://imperia.md/index.php?route=product/search&search=<cod>
       rezultatele sint blocuri "product-thumb"; se deschid pe rind (max. cMaxCandidates) si se
       accepta primul produs al carui cod coincide: <meta itemprop="sku"> = cod, sau codul apare
       in titlul produsului (la Milwaukee SKU-ul e numarul de articol, iar in pricelist vine
       modelul, ex. M18FCS552-0 / 4933493587);
       daca nu se gaseste si PRODUCT_LINK e un link imperia.md, se foloseste acela;
    2. pagina RU se ia din <link hreflang="ru">, pagina RO e cea gasita (cautarea da /ro/);
    3. imaginile: caile originale image/catalog/... din blocul "main-image-wrapper" (fara
       miniaturile image/cache/...), in ordinea din pagina -> TS_PRICELIST_ITEMS_IMAGES (PNG);
    4. descrierea: <div class="description" itemprop="description"> (contine si tabelul de
       specificatii), curatata de atributele de stil, RO si RU -> TS_PRICELIST_ITEMS_DESCRIPTION.

  Firele de lucru, coada, salvarea si fereastra de progres sint cele din MamicoContentUnit
  (TMamicoContentLoader.RunForPriceItemsEx).
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, MamicoContentUnit;

const
  cImperiaSupplierID = 74852;

type
  TImperiaContentLoader = class
  public
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
  end;

// functii pure de parsare (pot fi testate pe HTML salvat)
function ImperiaSearchResults(const AHtml: string): TArray<string>;
function ImperiaPageMatchesCode(const AHtml, ACode: string): Boolean;
function ImperiaAlternateUrl(const AHtml, AHrefLang: string): string;
function ImperiaParseGallery(const AHtml: string): TArray<string>;
function ImperiaParseDescription(const AHtml: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding;

const
  cBaseUrl = 'https://imperia.md/';
  cRx = [roIgnoreCase, roSingleLine];
  cMaxCandidates = 5;

// doar literele si cifrele, majuscule - "M18 FCS552-0" = "M18FCS5520"
function NormCode(const S: string): string;
var
  C: Char;
begin
  Result := '';
  for C in UpperCase(S) do
    if CharInSet(C, ['A'..'Z', '0'..'9']) then
      Result := Result + C;
end;

// codifica o cale relativa din site (poate contine spatii, chirilice, "=", paranteze)
function EncodePath(const APath: string): string;
var
  Bytes: TBytes;
  B: Byte;
begin
  Result := '';
  Bytes := TEncoding.UTF8.GetBytes(APath);
  for B in Bytes do
    if (B in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('0')..Ord('9')]) or
       (AnsiChar(B) in ['-', '_', '.', '~', '/', '(', ')']) then
      Result := Result + Char(B)
    else
      Result := Result + '%' + IntToHex(B, 2);
end;

function AbsoluteUrl(const AUrl: string): string;
var
  U: string;
begin
  U := TNetEncoding.HTML.Decode(AUrl);
  if U.StartsWith('http', True) then
    Result := U
  else
    Result := cBaseUrl + EncodePath(U.TrimLeft(['/']));
end;

function ImperiaSearchResults(const AHtml: string): TArray<string>;
var
  M: TMatch;
  List: TStringList;
  Url: string;
begin
  List := TStringList.Create;
  try
    for M in TRegEx.Matches(AHtml, 'class="product-thumb.*?<a\s+href="([^"]+)"', cRx) do
    begin
      Url := AbsoluteUrl(M.Groups[1].Value);
      if List.IndexOf(Url) < 0 then
        List.Add(Url);
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function ImperiaPageMatchesCode(const AHtml, ACode: string): Boolean;
var
  M: TMatch;
  Code, Title: string;
begin
  Code := NormCode(ACode);
  if Code = '' then
    Exit(False);
  M := TRegEx.Match(AHtml, '<meta\s+itemprop="sku"\s+content="([^"]*)"', cRx);
  if M.Success and (NormCode(M.Groups[1].Value) = Code) then
    Exit(True);
  // titlul produsului: <li class="active"> din breadcrumb, altfel <title>
  M := TRegEx.Match(AHtml, '<ul class="breadcrumb">.*?<li class="active">(.*?)</li>', cRx);
  if not M.Success then
    M := TRegEx.Match(AHtml, '<title>(.*?)</title>', cRx);
  Title := '';
  if M.Success then
    Title := NormCode(TNetEncoding.HTML.Decode(M.Groups[1].Value));
  // coduri scurte (sub 5 caractere) pot aparea intimplator in alt titlu - doar SKU exact
  Result := (Length(Code) >= 5) and (Pos(Code, Title) > 0);
end;

function ImperiaAlternateUrl(const AHtml, AHrefLang: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(AHtml, '<link[^>]*\bhreflang="' + AHrefLang + '"[^>]*\bhref="([^"]+)"', cRx);
  if not M.Success then
    M := TRegEx.Match(AHtml, '<link[^>]*\bhref="([^"]+)"[^>]*\bhreflang="' + AHrefLang + '"', cRx);
  if M.Success then
    Result := TNetEncoding.HTML.Decode(M.Groups[1].Value);
end;

function ImperiaParseGallery(const AHtml: string): TArray<string>;
var
  Html, Url: string;
  P, Q: Integer;
  M: TMatch;
  List: TStringList;
begin
  // blocul imaginilor produsului: de la "main-image-wrapper" pina la blocul de parteneri
  // (dupa el urmeaza produse recomandate cu imaginile lor)
  Html := '';
  P := Pos('main-image-wrapper', AHtml);
  if P > 0 then
  begin
    Q := Pos('partnersBlock', Copy(AHtml, P, MaxInt));
    if Q > 0 then
      Html := Copy(AHtml, P, Q)
    else
      Html := Copy(AHtml, P, 20000);
  end;

  List := TStringList.Create;
  try
    // doar imaginile originale (image/catalog/...), nu miniaturile image/cache/...
    for M in TRegEx.Matches(Html,
      '(?:src|href|data-[\w-]+)="((?:https://imperia\.md/)?image/catalog/[^"]+?\.(?:jpe?g|png|gif|webp))"', cRx) do
    begin
      Url := AbsoluteUrl(M.Groups[1].Value);
      if List.IndexOf(Url) < 0 then
        List.Add(Url);
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function ImperiaParseDescription(const AHtml: string): string;
var
  M: TMatch;
begin
  Result := '';
  // se termina la butonul "arata tot" din interiorul blocului
  M := TRegEx.Match(AHtml,
    '<div\s+class="description"\s+itemprop="description">(.*?)(?:<button\s+type="button">\s*<i\s+class="ion-chevron-down"|</div>\s*<div\s+class="check-item-availability)', cRx);
  if not M.Success then
    Exit;
  Result := M.Groups[1].Value;
  // imaginile din descriere (steaguri etc.) si fonturile editorului nu ne trebuie
  Result := TRegEx.Replace(Result, '<img\b[^>]*>', '', cRx);
  Result := TRegEx.Replace(Result, '</?(?:font|span)\b[^>]*>', '', cRx);
  Result := TRegEx.Replace(Result,
    '\s(?:data-[\w-]+|class|style|id|face|color|title|itemprop|itemscope|itemtype)(?:="[^"]*")?', '', cRx);
  Result := TRegEx.Replace(Result, '<h1\b', '<h3', cRx);
  Result := TRegEx.Replace(Result, '</h1>', '</h3>', cRx);
  Result := TRegEx.Replace(Result, '<p>\s*(?:<br\s*/?>|&nbsp;)?\s*</p>', '', cRx);
  Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
end;

{ TImperiaContentLoader }

class function TImperiaContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  R: TMamicoItemResult;
  Html, Search, HtmlRu, UrlRu, Link: string;
  Links: TArray<string>;
  Found: Boolean;
  I: Integer;
begin
  R := TMamicoItemResult.Create(ACode);
  Result := R;
  Found := False;
  Html := '';

  // 1. cautarea pe site dupa cod, verificarea fiecarui candidat
  try
    Search := ContentGetPage(AHttp, cBaseUrl + 'index.php?route=product/search&search=' +
      TNetEncoding.URL.Encode(ACode));
    Links := ImperiaSearchResults(Search);
    for I := 0 to High(Links) do
    begin
      if I >= cMaxCandidates then
        Break;
      Html := ContentGetPage(AHttp, Links[I]);
      if ImperiaPageMatchesCode(Html, ACode) then
      begin
        Found := True;
        Break;
      end;
    end;
    if not Found and (Length(Links) > 0) then
      R.Log.Add(Format('  %s: %d rezultate la cautare, niciunul cu acest cod', [ACode, Length(Links)]));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  // 2. link-ul din pricelist, daca e unul de pe imperia.md
  Link := Trim(AProductLink);
  if not Found and (Pos('imperia.md', LowerCase(Link)) > 0) then
  try
    Html := ContentGetPage(AHttp, Link);
    Found := Pos('itemprop="description"', Html) > 0;
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la PRODUCT_LINK: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe imperia.md', [ACode]));
    Exit;
  end;

  // 3. pagina RU (cea gasita e RO)
  HtmlRu := '';
  UrlRu := ImperiaAlternateUrl(Html, 'ru');
  if UrlRu <> '' then
  try
    HtmlRu := ContentGetPage(AHttp, AbsoluteUrl(UrlRu));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;

  R.DescRo := ImperiaParseDescription(Html);
  if HtmlRu <> '' then
    R.DescRu := ImperiaParseDescription(HtmlRu);

  // 4. imaginile - descarcate aici, convertite in PNG la salvare (firul principal)
  R.ImageUrls := ImperiaParseGallery(Html);
  SetLength(R.ImageData, Length(R.ImageUrls));
  for I := 0 to High(R.ImageUrls) do
  begin
    R.ImageData[I] := ContentGetBytes(AHttp, R.ImageUrls[I]);
    if Length(R.ImageData[I]) = 0 then
      R.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, R.ImageUrls[I]]));
  end;

  R.Found := (Length(R.ImageUrls) > 0) or (R.DescRo <> '') or (R.DescRu <> '');
  if not R.Found then
    R.Log.Add(Format('%s: pagina fara imagini si fara descriere', [ACode]));
end;

function ImperiaFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TImperiaContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TImperiaContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, ImperiaFetch, 'imperia.md');
end;

end.

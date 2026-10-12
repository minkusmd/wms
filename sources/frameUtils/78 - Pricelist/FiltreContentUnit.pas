unit FiltreContentUnit;

{
  Continut produse de la furnizorul LUMEA FILTRELOR (CustomerID 298776, filtre.md),
  analog cu MamicoContentUnit / ImperiaContentUnit.

  Pentru fiecare articol din pricelist:
    1. cautare pe site (OpenCart) dupa SUPPLIER_GOODS_CODE:
         https://filtre.md/index.php?route=product/search&search=<cod>
       link-urile rezultatelor se iau din <h4 class="product-name"><a href="...">;
       se deschid pe rind (max. cMaxCandidates) si se accepta primul produs al carui cod
       coincide exact: "Cod produs: <span>cod</span>" sau "model" din JSON-LD
       (codurile au zerouri in fata - 0000102 - deci comparatia e exacta, nu normalizata);
       daca nu se gaseste si PRODUCT_LINK e un link filtre.md, se foloseste acela;
    2. pagina gasita e RO; pagina RU se ia din <link hreflang="ru">;
    3. imaginile: blocul "product-image-main" (imaginea principala + "additional-images"),
       in ordinea din pagina; din image/cache/catalog/...-700x700.jpg se descarca originalul
       image/catalog/....jpg (daca originalul lipseste - varianta din cache);
       caile contin chirilice si spatii, deci se codifica doar pentru cererea HTTP;
    4. descrierea: tab-ul "tab-description" (HTML din editor, curatat de stiluri) +
       tabelul din tab-ul "tab-specification", cind exista; RO si RU.

  Firele de lucru, coada, salvarea si fereastra de progres sint cele din MamicoContentUnit
  (TMamicoContentLoader.RunForPriceItemsEx).
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, MamicoContentUnit;

const
  cFiltreSupplierID = 298776;

type
  TFiltreContentLoader = class
  public
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
  end;

// functii pure de parsare (pot fi testate pe HTML salvat)
function FiltreSearchResults(const AHtml: string): TArray<string>;
function FiltrePageMatchesCode(const AHtml, ACode: string): Boolean;
function FiltreAlternateUrl(const AHtml, AHrefLang: string): string;
// originalele (image/catalog/...) si, pe aceleasi pozitii, varianta din cache vazuta in pagina
function FiltreParseGallery(const AHtml: string; out ACacheUrls: TArray<string>): TArray<string>;
function FiltreParseDescription(const AHtml: string): string;
function FiltreEncodeUrl(const AUrl: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding;

const
  cBaseUrl = 'https://filtre.md/';
  cRx = [roIgnoreCase, roSingleLine];
  cMaxCandidates = 5;

// URL-ul pentru cererea HTTP: chirilicele, spatiile etc. -> %XX (UTF-8);
// secventele %XX deja codificate din pagina raman cum sint
function FiltreEncodeUrl(const AUrl: string): string;
const
  cHex = ['0'..'9', 'A'..'F', 'a'..'f'];
var
  U, Part: string;
  I, N: Integer;
  C: Char;
  B: Byte;
begin
  U := TNetEncoding.HTML.Decode(Trim(AUrl));
  Result := '';
  I := 1;
  while I <= Length(U) do
  begin
    C := U[I];
    N := 1;
    if (C = '%') and (I + 2 <= Length(U)) and CharInSet(U[I + 1], cHex) and CharInSet(U[I + 2], cHex) then
    begin
      Result := Result + Copy(U, I, 3);
      N := 3;
    end
    else if (Ord(C) > 32) and (Ord(C) < 127) and
      not CharInSet(C, ['%', '"', '<', '>', '`', '{', '}', '|', '\', '^']) then
      Result := Result + C
    else
    begin
      // perechile surogat (caractere in afara BMP) se codifica impreuna
      if (Ord(C) >= $D800) and (Ord(C) <= $DBFF) and (I < Length(U)) then
        N := 2;
      Part := Copy(U, I, N);
      for B in TEncoding.UTF8.GetBytes(Part) do
        Result := Result + '%' + IntToHex(B, 2);
    end;
    Inc(I, N);
  end;
end;

function AbsoluteUrl(const AUrl: string): string;
var
  U: string;
begin
  U := TNetEncoding.HTML.Decode(Trim(AUrl));
  if U.StartsWith('//') then
    Result := 'https:' + U
  else if U.StartsWith('http', True) then
    Result := U
  else
    Result := cBaseUrl + U.TrimLeft(['/']);
end;

function FiltreSearchResults(const AHtml: string): TArray<string>;
var
  M: TMatch;
  List: TStringList;
  Url: string;
begin
  List := TStringList.Create;
  try
    for M in TRegEx.Matches(AHtml, '<h4\s+class="product-name">\s*<a\s+href="([^"]+)"', cRx) do
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

function FiltrePageMatchesCode(const AHtml, ACode: string): Boolean;
var
  M: TMatch;
  Code: string;
begin
  Code := Trim(ACode);
  if Code = '' then
    Exit(False);
  // "Cod produs: <span>0000102</span>" (pe pagina RU eticheta e in rusa - de aceea doar <span>)
  M := TRegEx.Match(AHtml, '<div class="product-data">.*?<li>[^<]*:\s*<span>([^<]*)</span>', cRx);
  if M.Success and SameText(Trim(TNetEncoding.HTML.Decode(M.Groups[1].Value)), Code) then
    Exit(True);
  // JSON-LD: "model": "0000102"
  M := TRegEx.Match(AHtml, '"model"\s*:\s*"([^"]*)"', cRx);
  Result := M.Success and SameText(Trim(M.Groups[1].Value), Code);
end;

function FiltreAlternateUrl(const AHtml, AHrefLang: string): string;
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

function FiltreParseGallery(const AHtml: string; out ACacheUrls: TArray<string>): TArray<string>;
var
  Html, Url, Orig: string;
  P, Q: Integer;
  M: TMatch;
  List, Cache: TStringList;
begin
  // blocul imaginilor: de la "product-image-main" pina la "product-info-main"
  // (dupa el urmeaza descrierea si produsele recomandate cu imaginile lor)
  Html := '';
  P := Pos('product-image-main', AHtml);
  if P > 0 then
  begin
    Q := Pos('product-info-main', Copy(AHtml, P, MaxInt));
    if Q > 0 then
      Html := Copy(AHtml, P, Q)
    else
      Html := Copy(AHtml, P, 30000);
  end;

  List := TStringList.Create;
  Cache := TStringList.Create;
  try
    for M in TRegEx.Matches(Html,
      '(?:src|href|data-[\w-]+)="((?:https?://filtre\.md/|/)?image/(?:cache/)?catalog/[^"]+?\.(?:jpe?g|png|gif|webp))"', cRx) do
    begin
      Url := AbsoluteUrl(M.Groups[1].Value);
      // image/cache/catalog/...-700x700.jpg -> image/catalog/....jpg
      Orig := StringReplace(Url, '/image/cache/catalog/', '/image/catalog/', [rfIgnoreCase]);
      Orig := TRegEx.Replace(Orig, '-\d+x\d+(\.\w+)$', '$1');
      if List.IndexOf(Orig) < 0 then
      begin
        List.Add(Orig);
        Cache.Add(Url);
      end
      else if Pos('-700x700', Url) > 0 then
        // pentru rezerva preferam cea mai mare varianta din cache
        Cache[List.IndexOf(Orig)] := Url;
    end;
    Result := List.ToStringArray;
    ACacheUrls := Cache.ToStringArray;
  finally
    Cache.Free;
    List.Free;
  end;
end;

function CleanHtml(const AHtml: string): string;
begin
  Result := AHtml;
  Result := TRegEx.Replace(Result, '<(script|style|iframe)\b.*?</\1>', '', cRx);
  Result := TRegEx.Replace(Result, '<img\b[^>]*>', '', cRx);
  Result := TRegEx.Replace(Result, '<!--.*?-->', '', cRx);
  Result := TRegEx.Replace(Result, '</?(?:font|span|o:p)\b[^>]*>', '', cRx);
  Result := TRegEx.Replace(Result,
    '\s(?:data-[\w-]+|class|style|id|lang|face|color|title|align|width|height|border|' +
    'cellpadding|cellspacing|valign|dir|itemprop|itemscope|itemtype)(?:="[^"]*"|=''[^'']*'')?', '', cRx);
  Result := TRegEx.Replace(Result, '<(\w+)\s+>', '<$1>', cRx);
  Result := TRegEx.Replace(Result, '<h[12]\b', '<h3', cRx);
  Result := TRegEx.Replace(Result, '</h[12]>', '</h3>', cRx);
  Result := TRegEx.Replace(Result, '<(b|strong)>\s*</\1>', '', cRx);
  Result := TRegEx.Replace(Result, '<p>(?:\s|&nbsp;|<br\s*/?>)*</p>', '', cRx);
  Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
  // <br> ramase la final
  Result := Trim(TRegEx.Replace(Result, '(?:<br\s*/?>\s*)+$', '', cRx));
end;

function FiltreParseDescription(const AHtml: string): string;
var
  P, Q: Integer;
  Desc, Rest: string;
  M: TMatch;
begin
  Result := '';
  // tab-ul de descriere se termina unde incepe urmatorul tab (specificatii / recenzii)
  P := Pos('id="tab-description"', AHtml);
  if P > 0 then
  begin
    Rest := Copy(AHtml, P, MaxInt);
    P := Pos('>', Rest);
    Rest := Copy(Rest, P + 1, MaxInt);
    Q := Pos('<div class="tab-pane"', Rest);
    if Q > 0 then
      Desc := Copy(Rest, 1, Q - 1)
    else
    begin
      // fara alte tab-uri: pina la inchiderea blocului tab-content
      M := TRegEx.Match(Rest, '^(.*?)</div>\s*</div>\s*</div>', cRx);
      if M.Success then
        Desc := M.Groups[1].Value + '</div>'
      else
        Desc := '';
    end;
    // </div>-ul de inchidere al tab-ului
    Desc := TRegEx.Replace(Desc, '</div>\s*$', '', cRx);
    Result := CleanHtml(Desc);
  end;

  // caracteristicile (tab-ul "tab-specification" - un tabel simplu)
  P := Pos('id="tab-specification"', AHtml);
  if P > 0 then
  begin
    M := TRegEx.Match(Copy(AHtml, P, MaxInt), '<table\b.*?</table>', cRx);
    if M.Success then
      Result := Trim(Result + ' ' + CleanHtml(M.Value));
  end;
end;

{ TFiltreContentLoader }

class function TFiltreContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  R: TMamicoItemResult;
  Html, Search, HtmlRu, UrlRu, Link: string;
  Links, CacheUrls: TArray<string>;
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
      TNetEncoding.URL.Encode(Trim(ACode)));
    Links := FiltreSearchResults(Search);
    for I := 0 to High(Links) do
    begin
      if I >= cMaxCandidates then
        Break;
      Html := ContentGetPage(AHttp, FiltreEncodeUrl(Links[I]));
      if FiltrePageMatchesCode(Html, ACode) then
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

  // 2. link-ul din pricelist, daca e unul de pe filtre.md
  Link := Trim(AProductLink);
  if not Found and (Pos('filtre.md', LowerCase(Link)) > 0) then
  try
    Html := ContentGetPage(AHttp, FiltreEncodeUrl(Link));
    Found := Pos('id="tab-description"', Html) > 0;
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la PRODUCT_LINK: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe filtre.md', [ACode]));
    Exit;
  end;

  // 3. pagina RU (cea gasita e RO)
  HtmlRu := '';
  UrlRu := FiltreAlternateUrl(Html, 'ru');
  if UrlRu <> '' then
  try
    HtmlRu := ContentGetPage(AHttp, FiltreEncodeUrl(AbsoluteUrl(UrlRu)));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;

  R.DescRo := FiltreParseDescription(Html);
  if HtmlRu <> '' then
    R.DescRu := FiltreParseDescription(HtmlRu);

  // 4. imaginile - originalul, iar daca lipseste varianta din cache;
  // convertite in PNG la salvare (firul principal)
  R.ImageUrls := FiltreParseGallery(Html, CacheUrls);
  SetLength(R.ImageData, Length(R.ImageUrls));
  for I := 0 to High(R.ImageUrls) do
  begin
    R.ImageData[I] := ContentGetBytes(AHttp, FiltreEncodeUrl(R.ImageUrls[I]));
    if (Length(R.ImageData[I]) = 0) and (CacheUrls[I] <> R.ImageUrls[I]) then
    begin
      R.ImageData[I] := ContentGetBytes(AHttp, FiltreEncodeUrl(CacheUrls[I]));
      if Length(R.ImageData[I]) > 0 then
        R.ImageUrls[I] := CacheUrls[I];
    end;
    if Length(R.ImageData[I]) = 0 then
      R.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, R.ImageUrls[I]]));
  end;

  R.Found := (Length(R.ImageUrls) > 0) or (R.DescRo <> '') or (R.DescRu <> '');
  if not R.Found then
    R.Log.Add(Format('%s: pagina fara imagini si fara descriere', [ACode]));
end;

function FiltreFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TFiltreContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TFiltreContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, FiltreFetch, 'filtre.md');
end;

end.

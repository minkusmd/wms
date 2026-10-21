unit PernaMeaContentUnit;

{
  Continut si stoc de la furnizorul PERNAMEA S.R.L. (CustomerID 307501, pernamea.md),
  analog cu FiltreContentUnit / AloContentUnit. Folosit de frame78 (Caracteristici si imagini)
  si de frmGoodsForeignCodeDlg (butonul API furnizor - stocul).

  Fapte despre pernamea.md (verificate 18 oct 2026):
    - cautarea https://pernamea.md/search?s=<cod> potriveste doar codul exact: codul gasit
      raspunde cu 302 direct pe pagina produsului, altfel 200 cu "niciun rezultat" (codul partial
      AK.10625 nu gaseste AK.106255); candidatii din rezultate se verifica oricum dupa cod;
    - codul furnizorului (SUPPLIER_GOODS_CODE, ex. NK.114015) e in <div class="cod-item">;
      sku din JSON-LD e ID-ul intern al site-ului (9423), nu codul;
    - JSON-LD Product: image[] (galeria, WebP din upfiles/goods-items), offers.availability
      (schema.org InStock / OutOfStock / ...), offers.price (MDL), offers.url (adresa canonica);
    - disponibilitatea pe magazine (Centru, Ciocana, Botanica): lista product-availability -
      <div class="title"><a>Magazin ...</a> + <div class="item-status item-status--green|red">;
      cantitatile NU se publica;
    - descrierea: <div class="limited-text"> pina la disclaimer-ul <div class="text-item mt-4
      text-item-description"> (textul juridic, nu intra in descriere);
    - caracteristicile: randuri <div class="attr-row"> cu attr-left (nume) / attr-right (valoare),
      repetate pentru varianta mobila - se elimina dublurile;
    - pagina RU: <link hreflang="ru"> (/ru/product/...);
    - serverul e lent din cind in cind (o cerere ~28 s, uneori 500 "Request Timeout") -
      timeout mare, o reincercare si mai putine fire (cPernaMeaThreadCount).
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, MamicoContentUnit;

const
  cPernaMeaSupplierID = 307501;
  cPernaMeaThreadCount = 4;

type
  TPernaMeaStoreStock = record
    Name: string;
    Status: string;      // textul de pe site: "In stoc" / "Indisponibil"
    Available: Boolean;  // item-status--green
  end;

  TPernaMeaStock = record
    Url: string;
    Title: string;
    Code: string;
    Availability: string;  // din schema.org: InStock, OutOfStock, PreOrder...
    Price: string;
    SiteStatus: string;    // blocul "Stoc epuizat" de linga pret, daca exista
    Stores: TArray<TPernaMeaStoreStock>;
  end;

  TPernaMeaContentLoader = class
  public
    // cauta produsul dupa cod; True = gasit (AHtml = pagina RO, AUrl = adresa ei)
    class function FindProduct(AHttp: TObject; const ACode: string; out AHtml, AUrl: string;
      out ACandidates: Integer): Boolean;
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
    // stocul pentru dialogul API furnizor (firul principal); False = codul nu e pe site
    class function GetStock(const ACode: string; out AStock: TPernaMeaStock;
      out ACandidates: Integer): Boolean;
  end;

// functii pure de parsare (pot fi testate pe HTML salvat)
function PernaMeaPageCode(const AHtml: string): string;
function PernaMeaSearchResults(const AHtml: string): TArray<string>;
function PernaMeaAlternateUrl(const AHtml, AHrefLang: string): string;
function PernaMeaParseImages(const AHtml: string): TArray<string>;
function PernaMeaParseDescription(const AHtml: string): string;
function PernaMeaParseStock(const AHtml: string): TPernaMeaStock;

implementation

uses
  System.RegularExpressions, System.NetEncoding, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, AloContentUnit;

const
  cBaseUrl = 'https://pernamea.md/';
  cRx = [roIgnoreCase, roSingleLine];
  cMaxCandidates = 3;
  cResponseTimeoutMs = 90000;

function PlainText(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, '<[^>]*>', ' ');
  Result := Trim(TRegEx.Replace(TNetEncoding.HTML.Decode(Result), '\s+', ' '));
end;

// pagina cu o reincercare la 5xx / eroare de retea (serverul expira uneori cererile)
function PernaGetPage(AHttp: THTTPClient; const AUrl: string): string;
var
  Response: IHTTPResponse;
  Attempt: Integer;
begin
  Result := '';
  for Attempt := 1 to 2 do
  begin
    try
      Response := AHttp.Get(AUrl);
      if Response.StatusCode = 200 then
        Exit(Response.ContentAsString(TEncoding.UTF8));
      if (Response.StatusCode < 500) or (Attempt = 2) then
        raise Exception.CreateFmt('HTTP %d la %s', [Response.StatusCode, AUrl]);
    except
      // timeout / conexiune (ENetHTTPClientException, ENetHTTPRequestException...)
      on E: ENetException do
        if Attempt = 2 then
          raise;
    end;
    Sleep(3000);
  end;
end;

function PernaMeaPageCode(const AHtml: string): string;
var
  M: TMatch;
begin
  M := TRegEx.Match(AHtml, '<div class="cod-item[^"]*">\s*([^<]*?)\s*</div>', cRx);
  if M.Success then
    Result := Trim(TNetEncoding.HTML.Decode(M.Groups[1].Value))
  else
    Result := '';
end;

function PernaMeaSearchResults(const AHtml: string): TArray<string>;
var
  M: TMatch;
  List: TStringList;
begin
  List := TStringList.Create;
  try
    for M in TRegEx.Matches(AHtml, 'href="(https://pernamea\.md/(?:ru/)?product/[^"#?]+)"', cRx) do
      if List.IndexOf(M.Groups[1].Value) < 0 then
        List.Add(M.Groups[1].Value);
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function PernaMeaAlternateUrl(const AHtml, AHrefLang: string): string;
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

// obiectul JSON-LD de tip Product (de eliberat de apelant); nil daca lipseste
function ProductLd(const AHtml: string): TJSONObject;
var
  M: TMatch;
  V: TJSONValue;
begin
  Result := nil;
  for M in TRegEx.Matches(AHtml, '<script[^>]*application/ld\+json[^>]*>(.*?)</script>', cRx) do
    if Pos('"Product"', M.Groups[1].Value) > 0 then
    begin
      V := TJSONObject.ParseJSONValue(M.Groups[1].Value);
      if V is TJSONObject then
        Exit(TJSONObject(V));
      V.Free;
    end;
end;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if AObj = nil then
    Exit;
  V := AObj.GetValue(AName);
  if (V <> nil) and not (V is TJSONNull) and not (V is TJSONObject) and not (V is TJSONArray) then
    Result := Trim(V.Value);
end;

function PernaMeaParseImages(const AHtml: string): TArray<string>;
var
  Ld: TJSONObject;
  V, Item: TJSONValue;
  List: TStringList;
begin
  List := TStringList.Create;
  Ld := ProductLd(AHtml);
  try
    if Assigned(Ld) then
    begin
      V := Ld.GetValue('image');
      if V is TJSONArray then
      begin
        for Item in TJSONArray(V) do
          if (Item is TJSONString) and (Trim(Item.Value) <> '') and (List.IndexOf(Trim(Item.Value)) < 0) then
            List.Add(Trim(Item.Value));
      end
      else if V is TJSONString then
        List.Add(Trim(V.Value));
    end;
    Result := List.ToStringArray;
  finally
    Ld.Free;
    List.Free;
  end;
end;

// descrierea (limited-text) + caracteristicile (attr-row) intr-un tabel
function PernaMeaParseDescription(const AHtml: string): string;
var
  P, Q: Integer;
  Seg, Name, Value, Pair, Rows: string;
  Segs: TArray<string>;
  Seen: TStringList;
  ML, MR: TMatch;
  I: Integer;
begin
  Result := '';
  P := Pos('class="limited-text"', AHtml);
  if P > 0 then
  begin
    Seg := Copy(AHtml, P, MaxInt);
    Seg := Copy(Seg, Pos('>', Seg) + 1, MaxInt);
    Q := Pos('<div class="text-item mt-4 text-item-description"', Seg);
    if Q = 0 then
      Q := Pos('<a href="javascript:;" class="open-text"', Seg);
    if Q > 0 then
      Seg := Copy(Seg, 1, Q - 1)
    else
      Seg := '';
    Result := AloCleanHtml(Seg);
    // </div>-urile ramase din containerul limited-text
    Result := Trim(TRegEx.Replace(Result, '(?:\s*</div>)+\s*$', '', cRx));
  end;

  Rows := '';
  Seen := TStringList.Create;
  try
    Segs := AHtml.Split(['class="attr-row"']);
    for I := 1 to High(Segs) do
    begin
      Seg := Copy(Segs[I], 1, 3000);
      ML := TRegEx.Match(Seg, 'class="attr-left"[^>]*>(.*?)</div>', cRx);
      MR := TRegEx.Match(Seg, 'class="attr-right"[^>]*>(.*?)</div>', cRx);
      if not (ML.Success and MR.Success) then
        Continue;
      Name := PlainText(ML.Groups[1].Value);
      Value := PlainText(MR.Groups[1].Value);
      Pair := Name + #9 + Value;
      if (Name = '') or (Value = '') or (Seen.IndexOf(Pair) >= 0) then
        Continue;
      Seen.Add(Pair);
      Rows := Rows + '<tr><td>' + TNetEncoding.HTML.Encode(Name) + '</td><td>' +
        TNetEncoding.HTML.Encode(Value) + '</td></tr>';
    end;
  finally
    Seen.Free;
  end;
  if Rows <> '' then
    Result := Trim(Result + '<table>' + Rows + '</table>');
end;

function PernaMeaParseStock(const AHtml: string): TPernaMeaStock;
var
  Ld, Offers: TJSONObject;
  V: TJSONValue;
  M: TMatch;
  Store: TPernaMeaStoreStock;
  Seen: TStringList;
begin
  Result := Default(TPernaMeaStock);
  Result.Code := PernaMeaPageCode(AHtml);
  M := TRegEx.Match(AHtml, '<h1[^>]*>(.*?)</h1>', cRx);
  if M.Success then
    Result.Title := PlainText(M.Groups[1].Value);
  M := TRegEx.Match(AHtml, 'class="out-stoc[^"]*">([^<]*)<', cRx);
  if M.Success then
    Result.SiteStatus := PlainText(M.Groups[1].Value);

  Ld := ProductLd(AHtml);
  try
    if Assigned(Ld) then
    begin
      if Result.Title = '' then
        Result.Title := JStr(Ld, 'name');
      V := Ld.GetValue('offers');
      if V is TJSONArray then
        if TJSONArray(V).Count > 0 then
          V := TJSONArray(V).Items[0];
      if V is TJSONObject then
      begin
        Offers := TJSONObject(V);
        Result.Availability := JStr(Offers, 'availability');
        // https://schema.org/InStock -> InStock
        if LastDelimiter('/', Result.Availability) > 0 then
          Result.Availability := Copy(Result.Availability, LastDelimiter('/', Result.Availability) + 1, MaxInt);
        Result.Price := JStr(Offers, 'price');
        Result.Url := JStr(Offers, 'url');
      end;
    end;
  finally
    Ld.Free;
  end;

  // lista magazinelor apare de doua ori (desktop + mobil)
  Seen := TStringList.Create;
  try
    for M in TRegEx.Matches(AHtml,
      '<div class="title">\s*<a[^>]*>([^<]*)</a>.*?class="item-status\s+([\w-]*)"[^>]*>([^<]*)<', cRx) do
    begin
      Store.Name := PlainText(M.Groups[1].Value);
      if (Store.Name = '') or (Seen.IndexOf(Store.Name) >= 0) then
        Continue;
      Seen.Add(Store.Name);
      Store.Status := PlainText(M.Groups[3].Value);
      Store.Available := SameText(M.Groups[2].Value, 'item-status--green');
      Result.Stores := Result.Stores + [Store];
    end;
  finally
    Seen.Free;
  end;
end;

{ TPernaMeaContentLoader }

class function TPernaMeaContentLoader.FindProduct(AHttp: TObject; const ACode: string;
  out AHtml, AUrl: string; out ACandidates: Integer): Boolean;
var
  Http: THTTPClient;
  Html, Url: string;
  Links: TArray<string>;
  I: Integer;
begin
  Result := False;
  AHtml := '';
  AUrl := '';
  ACandidates := 0;
  Http := AHttp as THTTPClient;
  Http.HandleRedirects := True;
  if Http.ResponseTimeout < cResponseTimeoutMs then
    Http.ResponseTimeout := cResponseTimeoutMs;

  // codul exact -> redirect direct pe produs
  Html := PernaGetPage(Http, cBaseUrl + 'search?s=' + TNetEncoding.URL.Encode(Trim(ACode)));
  if SameText(PernaMeaPageCode(Html), Trim(ACode)) then
  begin
    AHtml := Html;
    AUrl := PernaMeaParseStock(Html).Url;
    Exit(True);
  end;

  Links := PernaMeaSearchResults(Html);
  ACandidates := Length(Links);
  for I := 0 to High(Links) do
  begin
    if I >= cMaxCandidates then
      Break;
    Url := Links[I];
    Html := PernaGetPage(Http, Url);
    if SameText(PernaMeaPageCode(Html), Trim(ACode)) then
    begin
      AHtml := Html;
      AUrl := Url;
      Exit(True);
    end;
  end;
end;

class function TPernaMeaContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  R: TMamicoItemResult;
  Html, HtmlRu, Url, UrlRu: string;
  Candidates, I: Integer;
  Found: Boolean;
begin
  R := TMamicoItemResult.Create(ACode);
  Result := R;
  Found := False;
  Html := '';

  // 1. cautarea dupa cod
  try
    Found := FindProduct(AHttp, ACode, Html, Url, Candidates);
    if not Found and (Candidates > 0) then
      R.Log.Add(Format('  %s: %d rezultate la cautare, niciunul cu acest cod', [ACode, Candidates]));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  // 2. link-ul din pricelist, daca e unul de pe pernamea.md
  if not Found and (Pos('pernamea.md/', LowerCase(AProductLink)) > 0) then
  try
    Html := PernaGetPage(AHttp as THTTPClient, Trim(AProductLink));
    Found := SameText(PernaMeaPageCode(Html), Trim(ACode));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la PRODUCT_LINK: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe pernamea.md', [ACode]));
    Exit;
  end;

  // 3. pagina RU
  HtmlRu := '';
  UrlRu := PernaMeaAlternateUrl(Html, 'ru');
  if UrlRu <> '' then
  try
    HtmlRu := PernaGetPage(AHttp as THTTPClient, UrlRu);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;

  R.DescRo := PernaMeaParseDescription(Html);
  if HtmlRu <> '' then
    R.DescRu := PernaMeaParseDescription(HtmlRu);

  // 4. imaginile (WebP) - convertite in PNG la salvare, pe firul principal
  R.ImageUrls := PernaMeaParseImages(Html);
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

function PernaMeaFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TPernaMeaContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TPernaMeaContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, PernaMeaFetch,
    'pernamea.md', True, -1, cPernaMeaThreadCount);
end;

class function TPernaMeaContentLoader.GetStock(const ACode: string; out AStock: TPernaMeaStock;
  out ACandidates: Integer): Boolean;
var
  Http: TObject;
  Html, Url: string;
begin
  AStock := Default(TPernaMeaStock);
  Http := CreateContentHttp;
  try
    Result := FindProduct(Http, ACode, Html, Url, ACandidates);
    if Result then
    begin
      AStock := PernaMeaParseStock(Html);
      if Url <> '' then
        AStock.Url := Url;
    end;
  finally
    Http.Free;
  end;
end;

end.

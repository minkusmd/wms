unit TinaContentUnit;

{
  Continut produse de la furnizorul TINA SRL (CustomerID 229, tina.md - produse FIRST Austria),
  analog cu PernaMeaContentUnit / FiltreContentUnit. Folosit de frame78 (Caracteristici si imagini):
  imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
  (prin TMamicoContentLoader.RunForPriceItemsEx).

  Fapte despre tina.md (verificate 19 oct 2026, Joomla + JoomShopping):
    - cautarea https://tina.md/ro/search/result?search=<text> (GET) cauta subsirul in denumire /
      cod; rezultatele sint in <div class="jshop_list_product"> pina la copyright-ul JoomShopping
      (id="mxcpr") - dupa el urmeaza modulul "PROMOTII" cu alte produse, care se ignora;
      fiecare rezultat: <h2><a href="/ro/..." title="Detail">Denumire</a></h2>;
      nimic gasit -> "Nu au fost gasite rezultate";
    - pagina produsului: <span id="product_code">002461-7</span> (= SUPPLIER_GOODS_CODE), dar
      codurile de pe site nu sint uniforme: "FA-5114-BL" pentru 005114-BL, "005120- 2" pentru
      005120-2 - se compara normalizat (TinaNormCode: fara spatii/cratime, fara prefixul FA,
      fara zerourile din fata); "005114-BL" nu gaseste nimic, "5114-BL" da - de aceea se
      incearca mai multe cereri (codul, codul fara zerouri, grupul numeric "5120");
    - galeria: <span id='list_product_image_middle'> cu <a class="lightbox" href=".../full_*.jpg">,
      prima = imaginea principala; JPG/JPEG (convertite in PNG la salvare);
    - descrierea: <div class='jshop_prod_description'> din tab-ul #tab_description (HTML cu
      <span style>, <br />); caracteristicile suplimentare (extra fields) sint de obicei goale;
    - pagina RU: <link href=".../ru/product/view/<cat>/<id>" hreflang="ru-RU">.
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, MamicoContentUnit;

const
  cTinaSupplierID = 229;
  cTinaThreadCount = 4;

type
  TTinaContentLoader = class
  public
    // cauta produsul dupa cod; True = gasit (AHtml = pagina RO, AUrl = adresa ei)
    class function FindProduct(AHttp: TObject; const ACode: string; out AHtml, AUrl: string;
      out ACandidates: Integer): Boolean;
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
  end;

// functii pure de parsare (pot fi testate pe HTML salvat)
function TinaNormCode(const ACode: string): string;
function TinaSearchQueries(const ACode: string): TArray<string>;
function TinaPageCode(const AHtml: string): string;
function TinaSearchResults(const AHtml, ACode: string): TArray<string>;
function TinaAlternateUrl(const AHtml, AHrefLang: string): string;
function TinaParseImages(const AHtml: string): TArray<string>;
function TinaParseDescription(const AHtml: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding, AloContentUnit;

const
  cBaseUrl = 'https://tina.md';
  cRx = [roIgnoreCase, roSingleLine];
  // candidati verificati (pagina descarcata) pentru fiecare cerere de cautare
  cMaxCandidates = 4;

function PlainText(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, '<[^>]*>', ' ');
  Result := Trim(TRegEx.Replace(TNetEncoding.HTML.Decode(Result), '\s+', ' '));
end;

function AbsUrl(const AUrl: string): string;
begin
  Result := Trim(TNetEncoding.HTML.Decode(AUrl));
  if Result.StartsWith('//') then
    Result := 'https:' + Result
  else if Result.StartsWith('/') then
    Result := cBaseUrl + Result;
end;

// 005114-BL / FA-5114-BL / "005120- 2" -> 5114BL / 5114BL / 51202
function TinaNormCode(const ACode: string): string;
begin
  Result := UpperCase(TRegEx.Replace(ACode, '[^0-9A-Za-z]', ''));
  if Result.StartsWith('FA') then
    Result := Copy(Result, 3, MaxInt);
  Result := TRegEx.Replace(Result, '^0+(?=.)', '');
end;

// cererile de cautare, in ordine: codul, codul fara zerourile din fata, grupul numeric
function TinaSearchQueries(const ACode: string): TArray<string>;
var
  Code, S: string;
  M: TMatch;

  procedure AddQuery(const AQuery: string);
  var
    Q: string;
  begin
    for Q in Result do
      if SameText(Q, AQuery) then
        Exit;
    if AQuery <> '' then
      Result := Result + [AQuery];
  end;

begin
  Result := nil;
  Code := Trim(ACode);
  AddQuery(Code);
  S := TRegEx.Replace(Code, '^0+(?=\d)', '');
  AddQuery(S);
  M := TRegEx.Match(S, '^\d{3,}');
  if M.Success then
    AddQuery(M.Value);
end;

function TinaPageCode(const AHtml: string): string;
var
  M: TMatch;
begin
  M := TRegEx.Match(AHtml, '<span id="product_code">\s*([^<]*?)\s*</span>', cRx);
  if M.Success then
    Result := Trim(TNetEncoding.HTML.Decode(M.Groups[1].Value))
  else
    Result := '';
end;

// link-urile produselor din rezultatele cautarii (fara modulul PROMOTII de dedesubt);
// intii cele care au codul in denumire sau in adresa
function TinaSearchResults(const AHtml, ACode: string): TArray<string>;
var
  P, Q: Integer;
  Seg, Url, Key: string;
  M: TMatch;
  First, Rest: TStringList;
begin
  Result := nil;
  P := Pos('class="jshop_list_product"', AHtml);
  if P = 0 then
    Exit;
  Seg := Copy(AHtml, P, MaxInt);
  Q := Pos('id="mxcpr"', Seg);
  if Q > 0 then
    Seg := Copy(Seg, 1, Q - 1);

  Key := TinaNormCode(ACode);
  First := TStringList.Create;
  Rest := TStringList.Create;
  try
    for M in TRegEx.Matches(Seg, '<h2>\s*<a href="([^"]+)"[^>]*>(.*?)</a>', cRx) do
    begin
      Url := AbsUrl(M.Groups[1].Value);
      if (First.IndexOf(Url) >= 0) or (Rest.IndexOf(Url) >= 0) then
        Continue;
      if (Key <> '') and ((Pos(Key, TinaNormCode(PlainText(M.Groups[2].Value))) > 0) or
        (Pos(Key, TinaNormCode(Url)) > 0)) then
        First.Add(Url)
      else
        Rest.Add(Url);
    end;
    Result := First.ToStringArray + Rest.ToStringArray;
  finally
    First.Free;
    Rest.Free;
  end;
end;

function TinaAlternateUrl(const AHtml, AHrefLang: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(AHtml, '<link[^>]*\bhreflang="' + AHrefLang + '"[^>]*\bhref="([^"]+)"', cRx);
  if not M.Success then
    M := TRegEx.Match(AHtml, '<link[^>]*\bhref="([^"]+)"[^>]*\bhreflang="' + AHrefLang + '"', cRx);
  if M.Success then
    Result := AbsUrl(M.Groups[1].Value);
end;

function TinaParseImages(const AHtml: string): TArray<string>;
var
  P, Q: Integer;
  Seg, Url: string;
  M: TMatch;
  List: TStringList;
begin
  List := TStringList.Create;
  try
    P := Pos('id=''list_product_image_middle''', AHtml);
    if P = 0 then
      P := Pos('id="list_product_image_middle"', AHtml);
    if P > 0 then
    begin
      Seg := Copy(AHtml, P, MaxInt);
      Q := Pos('</span>', Seg);
      if Q > 0 then
        Seg := Copy(Seg, 1, Q - 1);
      // imaginea mare (full_*) din lightbox
      for M in TRegEx.Matches(Seg, '<a[^>]*class="lightbox"[^>]*\bhref="([^"]+)"', cRx) do
      begin
        Url := AbsUrl(M.Groups[1].Value);
        if (Url <> '') and (List.IndexOf(Url) < 0) then
          List.Add(Url);
      end;
      // rezerva: imaginea medie, daca lipsesc link-urile lightbox
      if List.Count = 0 then
        for M in TRegEx.Matches(Seg, '<img[^>]*class="main_image"[^>]*\bsrc\s*=\s*"([^"]+)"', cRx) do
        begin
          Url := AbsUrl(M.Groups[1].Value);
          if (Url <> '') and (List.IndexOf(Url) < 0) then
            List.Add(Url);
        end;
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

// descrierea (jshop_prod_description) + caracteristicile suplimentare (extra fields) intr-un tabel
function TinaParseDescription(const AHtml: string): string;
var
  M, MN: TMatch;
  Seg, Name, Value, Rows: string;
  Q: Integer;
begin
  Result := '';
  M := TRegEx.Match(AHtml, 'class=[''"]jshop_prod_description[''"][^>]*>', cRx);
  if M.Success then
  begin
    Seg := Copy(AHtml, M.Index + M.Length, MaxInt);
    // pina la urmatorul tab (produse asemanatoare) sau butonul "Back"
    Q := Pos('<div class=''tab-pane', Seg);
    if Q = 0 then
      Q := Pos('class="button_back"', Seg);
    if Q > 0 then
      Seg := Copy(Seg, 1, Q - 1)
    else
      Seg := '';
    Result := AloCleanHtml(Seg);
    // </div>-urile de inchidere ale containerului descrierii si ale tab-ului: se scot de la
    // sfirsit doar cit timp sint mai multe </div> decit <div> (cele ale textului raman)
    // (plus <div></div> si <br /> goale de la sfirsit)
    repeat
      Result := Trim(TRegEx.Replace(Result, '(?:<div>\s*</div>|<br\s*/?>|\s)+$', '', cRx));
      if (TRegEx.Matches(Result, '</div>', cRx).Count <= TRegEx.Matches(Result, '<div\b', cRx).Count) or
        not TRegEx.IsMatch(Result, '</div>$', cRx) then
        Break;
      Result := Copy(Result, 1, Length(Result) - Length('</div>'));
    until False;
    if PlainText(Result) = '' then
      Result := '';
  end;

  Rows := '';
  M := TRegEx.Match(AHtml, '<!--EXTRA FIELDS-->(.*?)<!--END EXTRA FIELDS-->', cRx);
  if M.Success then
    for MN in TRegEx.Matches(M.Groups[1].Value,
      'class="extra_fields_name"[^>]*>(.*?)</span>.*?class="extra_fields_value"[^>]*>(.*?)</span>', cRx) do
    begin
      Name := PlainText(MN.Groups[1].Value);
      Value := PlainText(MN.Groups[2].Value);
      if Name.EndsWith(':') then
        Name := Trim(Copy(Name, 1, Length(Name) - 1));
      if (Name = '') or (Value = '') then
        Continue;
      Rows := Rows + '<tr><td>' + TNetEncoding.HTML.Encode(Name) + '</td><td>' +
        TNetEncoding.HTML.Encode(Value) + '</td></tr>';
    end;
  if Rows <> '' then
    Result := Trim(Result + '<table>' + Rows + '</table>');
end;

{ TTinaContentLoader }

class function TTinaContentLoader.FindProduct(AHttp: TObject; const ACode: string;
  out AHtml, AUrl: string; out ACandidates: Integer): Boolean;
var
  Html, Url, Key: string;
  Query: string;
  Links: TArray<string>;
  Checked: TStringList;
  I, N: Integer;
begin
  Result := False;
  AHtml := '';
  AUrl := '';
  ACandidates := 0;
  Key := TinaNormCode(ACode);
  if Key = '' then
    Exit;

  Checked := TStringList.Create;
  try
    for Query in TinaSearchQueries(ACode) do
    begin
      Html := ContentGetPage(AHttp, cBaseUrl + '/ro/search/result?search=' + TNetEncoding.URL.Encode(Query));
      Links := TinaSearchResults(Html, ACode);
      N := 0;
      for I := 0 to High(Links) do
      begin
        Url := Links[I];
        if Checked.IndexOf(Url) >= 0 then
          Continue;
        if N >= cMaxCandidates then
          Break;
        Inc(N);
        Checked.Add(Url);
        Inc(ACandidates);
        Html := ContentGetPage(AHttp, Url);
        if TinaNormCode(TinaPageCode(Html)) = Key then
        begin
          AHtml := Html;
          AUrl := Url;
          Exit(True);
        end;
      end;
    end;
  finally
    Checked.Free;
  end;
end;

class function TTinaContentLoader.FetchItem(AHttp: TObject; const ACode,
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
      R.Log.Add(Format('  %s: %d rezultate verificate la cautare, niciunul cu acest cod', [ACode, Candidates]));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  // 2. link-ul din pricelist, daca e unul de pe tina.md
  if not Found and (Pos('tina.md/', LowerCase(AProductLink)) > 0) then
  try
    Html := ContentGetPage(AHttp, Trim(AProductLink));
    Found := TinaNormCode(TinaPageCode(Html)) = TinaNormCode(ACode);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la PRODUCT_LINK: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe tina.md', [ACode]));
    Exit;
  end;

  // 3. pagina RU
  HtmlRu := '';
  UrlRu := TinaAlternateUrl(Html, 'ru-RU');
  if UrlRu = '' then
    UrlRu := TinaAlternateUrl(Html, 'ru');
  if UrlRu <> '' then
  try
    HtmlRu := ContentGetPage(AHttp, UrlRu);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;

  R.DescRo := TinaParseDescription(Html);
  if HtmlRu <> '' then
    R.DescRu := TinaParseDescription(HtmlRu);

  // 4. imaginile (JPG) - convertite in PNG la salvare, pe firul principal
  R.ImageUrls := TinaParseImages(Html);
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

function TinaFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TTinaContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TTinaContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, TinaFetch,
    'tina.md', True, -1, cTinaThreadCount);
end;

end.

unit AloContentUnit;

{
  Continut produse de la furnizorul MOBILE STOCK SRL (CustomerID 246795, alo.md),
  analog cu FiltreContentUnit / ImperiaContentUnit.

  alo.md e un magazin Nuxt pe platforma ecom.md - datele vin din API-ul JSON public
  https://admin.ecom.md/ (acelasi folosit de GetAloProductStock in frmGoodsForeignCodeDialog).
  Antetul "token" alege magazinul (fara el raspund produsele altui magazin ecom.md); tokenul
  e public in configurarea Nuxt a site-ului (TOKEN:"..."), se citeste o data inainte de pornire.

  Pentru fiecare articol din pricelist (SUPPLIER_GOODS_CODE = codul site-ului, ex. MI000026657):
    1. general/v2/search/search/?query=<cod> - cautarea e aproximativa, se accepta doar
       produsul cu "code" egal cu codul; daca nu se gaseste si PRODUCT_LINK e un link alo.md,
       slug-ul se ia din link (/product/<slug>);
    2. general/v2/product/<slug>/ cu Accept-Language ro si ru:
       - product.images[].img (rezerva: product.pictures) - galeria in ordinea site-ului (WebP);
       - product.description.description - HTML din editor (cu emoji si imagini externe,
         curatat);
       - properties[] (la radacina raspunsului) - caracteristicile pe grupe:
         grupe (unitTitle) cu details: title, title_value, title_values[], traduse dupa limba;
    3. descrierea RO / RU = descrierea curatata + caracteristicile, cite un tabel pe grupa.

  Firele de lucru, coada, salvarea (WebP -> PNG) si fereastra de progres sint cele din
  MamicoContentUnit (TMamicoContentLoader.RunForPriceItemsEx).
}

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB, IBC, MamicoContentUnit;

const
  cAloSupplierID = 246795;

type
  TAloContentLoader = class
  public
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
  end;

// functii pure de parsare (pot fi testate pe JSON salvat)
function AloParseImages(AProduct: TJSONObject): TArray<string>;
function AloParseDescription(AResponse: TJSONObject): string;
function AloCleanHtml(const AHtml: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding, System.Net.HttpClient, System.Net.URLClient;

const
  cApiUrl = 'https://admin.ecom.md/';
  cSiteUrl = 'https://alo.md/';
  // rezerva, daca tokenul nu se poate citi de pe site (17 oct 2026)
  cDefaultToken = 'xqp!pgw5bfc6KNF@chu';
  cRx = [roIgnoreCase, roSingleLine];

var
  // citit o data, pe firul principal, inainte de pornirea firelor de lucru
  GAloToken: string;

function JValue(AObj: TJSONObject; const AName: string): TJSONValue;
begin
  Result := nil;
  if Assigned(AObj) then
  begin
    Result := AObj.GetValue(AName);
    if Result is TJSONNull then
      Result := nil;
  end;
end;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if (V = nil) or (V is TJSONObject) or (V is TJSONArray) then
    Result := ''
  else
    Result := Trim(V.Value);
end;

function JArr(AObj: TJSONObject; const AName: string): TJSONArray;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONArray then
    Result := TJSONArray(V)
  else
    Result := nil;
end;

function JObj(AObj: TJSONObject; const AName: string): TJSONObject;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONObject then
    Result := TJSONObject(V)
  else
    Result := nil;
end;

function HtmlText(const AText: string): string;
begin
  Result := TNetEncoding.HTML.Encode(Trim(AText));
end;

// emoji si simbolurile decorative din descrieri (perechi surogat, U+2600..27BF, U+2B00..2BFF,
// selectorii de varianta) - nu au ce cauta in descrierea produsului de pe site
function StripEmoji(const AText: string): string;
var
  SB: TStringBuilder;
  C: Char;
begin
  SB := TStringBuilder.Create(Length(AText));
  try
    for C in AText do
      case Ord(C) of
        $D800..$DFFF, $2600..$27BF, $2B00..$2BFF, $FE0E, $FE0F, $200D, $20E3:
          ;
      else
        SB.Append(C);
      end;
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

function AloCleanHtml(const AHtml: string): string;
begin
  Result := StripEmoji(AHtml);
  Result := TRegEx.Replace(Result, '<(script|style|iframe)\b.*?</\1>', '', cRx);
  Result := TRegEx.Replace(Result, '<img\b[^>]*>', '', cRx);
  Result := TRegEx.Replace(Result, '<!--.*?-->', '', cRx);
  Result := TRegEx.Replace(Result, '</?(?:font|span|o:p)\b[^>]*>', '', cRx);
  // atributele - doar in interiorul tag-urilor (lookahead pina la ">"): fara el " Id" din
  // textul "... Ideala" se potrivea cu atributul "id" si era sters
  Result := TRegEx.Replace(Result,
    '\s(?:data-[\w-]+|class|style|id|lang|face|color|title|align|width|height|border|' +
    'cellpadding|cellspacing|valign|dir|itemprop|itemscope|itemtype)\b(?:="[^"]*"|=''[^'']*'')?' +
    '(?=[^<>]*>)', '', cRx);
  Result := TRegEx.Replace(Result, '<(\w+)\s+>', '<$1>', cRx);
  Result := TRegEx.Replace(Result, '<h[12]\b', '<h3', cRx);
  Result := TRegEx.Replace(Result, '</h[12]>', '</h3>', cRx);
  Result := TRegEx.Replace(Result, '<(b|strong)>\s*</\1>', '', cRx);
  Result := TRegEx.Replace(Result, '<(p|h3|h4|li)>(?:\s|&nbsp;|<br\s*/?>)*</\1>', '', cRx);
  Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
  Result := Trim(TRegEx.Replace(Result, '(?:<br\s*/?>\s*)+$', '', cRx));
end;

function AloParseImages(AProduct: TJSONObject): TArray<string>;
var
  Arr: TJSONArray;
  Item: TJSONValue;
  List: TStringList;
  Url: string;
begin
  List := TStringList.Create;
  try
    Arr := JArr(AProduct, 'images');
    if (Arr = nil) or (Arr.Count = 0) then
      Arr := JArr(AProduct, 'pictures');
    if Assigned(Arr) then
      for Item in Arr do
        if Item is TJSONObject then
        begin
          Url := JStr(TJSONObject(Item), 'img');
          if (Url <> '') and (List.IndexOf(Url) < 0) then
            List.Add(Url);
        end;
    // fara galerie - doar imaginea principala
    if List.Count = 0 then
    begin
      Url := JStr(AProduct, 'img');
      if Url <> '' then
        List.Add(Url);
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

// descrierea (product.description.description) + caracteristicile (properties la radacina)
function AloParseDescription(AResponse: TJSONObject): string;
var
  Product, Desc, Group, Detail: TJSONObject;
  Groups, Details, Values: TJSONArray;
  G, D, V: TJSONValue;
  SB: TStringBuilder;
  Rows, Title, Value: string;
begin
  SB := TStringBuilder.Create;
  try
    Product := JObj(AResponse, 'product');
    Desc := JObj(Product, 'description');
    SB.Append(AloCleanHtml(JStr(Desc, 'description')));

    Groups := JArr(AResponse, 'properties');
    if Assigned(Groups) then
      for G in Groups do
      begin
        if not (G is TJSONObject) then
          Continue;
        Group := TJSONObject(G);
        Details := JArr(Group, 'details');
        if Details = nil then
          Continue;
        Rows := '';
        for D in Details do
        begin
          if not (D is TJSONObject) then
            Continue;
          Detail := TJSONObject(D);
          Title := JStr(Detail, 'title');
          // valorile multiple (ex. benzile de frecventa) vin in title_values
          Value := '';
          Values := JArr(Detail, 'title_values');
          if Assigned(Values) then
            for V in Values do
              if not (V is TJSONObject) and not (V is TJSONArray) and (Trim(V.Value) <> '') then
              begin
                if Value <> '' then
                  Value := Value + ', ';
                Value := Value + Trim(V.Value);
              end;
          if Value = '' then
            Value := JStr(Detail, 'title_value');
          if (Title <> '') and (Value <> '') then
            Rows := Rows + '<tr><td>' + HtmlText(Title) + '</td><td>' + HtmlText(Value) + '</td></tr>';
        end;
        if Rows = '' then
          Continue;
        if JStr(Group, 'unitTitle') <> '' then
          SB.Append('<h4>' + HtmlText(JStr(Group, 'unitTitle')) + '</h4>');
        SB.Append('<table>' + Rows + '</table>');
      end;

    Result := Trim(SB.ToString);
  finally
    SB.Free;
  end;
end;

function GetJson(AHttp: THTTPClient; const AUrl, ALang: string): TJSONObject;
var
  Response: IHTTPResponse;
  V: TJSONValue;
begin
  Response := AHttp.Get(AUrl, nil, [TNetHeader.Create('token', GAloToken),
    TNetHeader.Create('Accept-Language', ALang), TNetHeader.Create('Accept', 'application/json')]);
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt('HTTP %d: %s', [Response.StatusCode, AUrl]);
  V := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
  if not (V is TJSONObject) then
  begin
    V.Free;
    raise Exception.Create('raspuns invalid de la API-ul ecom.md: ' + AUrl);
  end;
  Result := TJSONObject(V);
end;

// tokenul magazinului din configurarea Nuxt a paginii principale alo.md
procedure EnsureToken;
var
  Http: THTTPClient;
  Response: IHTTPResponse;
  M: TMatch;
begin
  if GAloToken <> '' then
    Exit;
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 30000;
    Http.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
    try
      Response := Http.Get(cSiteUrl);
      if Response.StatusCode = 200 then
      begin
        M := TRegEx.Match(Response.ContentAsString(TEncoding.UTF8), 'TOKEN:"([^"\\]+)"');
        if M.Success then
          GAloToken := M.Groups[1].Value;
      end;
    except
      // pagina nu s-a deschis - ramine valoarea de rezerva
    end;
  finally
    Http.Free;
  end;
  if GAloToken = '' then
    GAloToken := cDefaultToken;
end;

{ TAloContentLoader }

class function TAloContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  R: TMamicoItemResult;
  Http: THTTPClient;
  Json, JsonRu: TJSONObject;
  Item: TJSONValue;
  Products: TJSONArray;
  Slug, Url: string;
  Candidates, I: Integer;
  M: TMatch;
begin
  // apel direct, fara RunForPriceItems (care citeste tokenul inainte de pornirea firelor)
  if GAloToken = '' then
    EnsureToken;
  R := TMamicoItemResult.Create(ACode);
  Result := R;
  Http := AHttp as THTTPClient;
  Slug := '';
  Candidates := 0;

  // 1. cautarea dupa cod - doar potrivirea exacta a codului
  try
    Json := GetJson(Http, cApiUrl + 'general/v2/search/search/?query=' +
      TNetEncoding.URL.Encode(Trim(ACode)), 'ro');
    try
      Products := JArr(Json, 'products');
      if Assigned(Products) then
      begin
        Candidates := Products.Count;
        for Item in Products do
          if (Item is TJSONObject) and SameText(JStr(TJSONObject(Item), 'code'), Trim(ACode)) then
          begin
            Slug := JStr(TJSONObject(Item), 'url');
            Break;
          end;
      end;
    finally
      Json.Free;
    end;
    if (Slug = '') and (Candidates > 0) then
      R.Log.Add(Format('  %s: %d rezultate la cautare, niciunul cu acest cod', [ACode, Candidates]));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  // 2. link-ul din pricelist, daca e unul de pe alo.md
  if (Slug = '') and (Pos('alo.md', LowerCase(AProductLink)) > 0) then
  begin
    M := TRegEx.Match(AProductLink, '/product/([^/?#]+)', cRx);
    if M.Success then
      Slug := M.Groups[1].Value;
  end;

  if Slug = '' then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe alo.md', [ACode]));
    Exit;
  end;

  // 3. fisa produsului RO + RU
  Url := cApiUrl + 'general/v2/product/' + Slug + '/';
  Json := nil;
  JsonRu := nil;
  try
    try
      Json := GetJson(Http, Url, 'ro');
    except
      on E: Exception do
      begin
        R.Log.Add(Format('%s: fisa produsului: %s', [ACode, E.Message]));
        Exit;
      end;
    end;
    try
      JsonRu := GetJson(Http, Url, 'ru');
    except
      on E: Exception do
        R.Log.Add(Format('  %s: fisa RU: %s', [ACode, E.Message]));
    end;

    R.DescRo := AloParseDescription(Json);
    if Assigned(JsonRu) then
      R.DescRu := AloParseDescription(JsonRu);

    // 4. imaginile (WebP) - convertite in PNG la salvare, pe firul principal
    R.ImageUrls := AloParseImages(JObj(Json, 'product'));
  finally
    JsonRu.Free;
    Json.Free;
  end;

  SetLength(R.ImageData, Length(R.ImageUrls));
  for I := 0 to High(R.ImageUrls) do
  begin
    R.ImageData[I] := ContentGetBytes(AHttp, R.ImageUrls[I]);
    if Length(R.ImageData[I]) = 0 then
      R.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, R.ImageUrls[I]]));
  end;

  R.Found := (Length(R.ImageUrls) > 0) or (R.DescRo <> '') or (R.DescRu <> '');
  if not R.Found then
    R.Log.Add(Format('%s: produs fara imagini si fara descriere', [ACode]));
end;

function AloFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TAloContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TAloContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  EnsureToken;
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, AloFetch, 'alo.md');
end;

end.

unit MaximumPriceSourceUnit;

(* Sursa de pret pentru Maximum (maximum.md), furnizorul 229873.
  Convertit din D:\Projects\pythonProject\2025\maximum_web.py.

  Site-ul are un API JSON de sugestii la cautare:
    GET https://maximum.md/ro/products/search/suggestions?query=<cod>
    { "success": true, "total_products": {"value": 1}, "products": [
        { "_id": 6914145, "title": "...", "price": {"value": 4449.0, "unit": "lei"},
          "old_price": {"value": 5549.0} } ] }

  Diferente fata de scriptul Python:
    - raspunsul NU contine codul produsului, iar cautarea gaseste si produse care au doar cifrele
      codului in titlu (si cind e un singur rezultat, ex. 2113551 -> "TAC2113551"). De aceea se
      ia primul rezultat - cel mai potrivit dupa site - si i se deschide pagina (/ro/<_id>/):
      pretul se accepta doar daca "Cod produs" de pe pagina e exact codul cautat; altfel articolul
      ramine neschimbat (MaximumFindProduct). Scriptul lua orbeste products[0].
    - procentul de reducere nu mai e scris in cod (0.98 la scriere, 0.92 in mesajul din jurnal):
      se ia TS_CUSTOMER.RRP_DISCOUNT al furnizorului, in SupplierPriceSyncUnit.
    - articolele vin din TS_GOODS_FOREIGN cu FLG_IN_PRICE = 1, nu din ultimul pricelist.
    - FLG_EPP (bitul 4) nu se mai forteaza la fiecare scriere. *)

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, SupplierPriceSyncUnit;

type
  TMaximumProduct = record
    ID: Int64;         // "_id" - pagina: https://maximum.md/ro/<_id>/
    Price: Currency;   // 0 = fara pret
    Title: string;
  end;

  TMaximumPriceSource = class(TSupplierPriceSource)
  private
    FHttp: THTTPClient;
  public
    class function ParserName: string; override;
    class function DisplayName: string; override;
    class function SupplierID: Integer; override;
    class function DefaultDelayMs: Integer; override;
    constructor Create; override;
    destructor Destroy; override;
    function FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean; override;
  end;

// Produsele din raspunsul API-ului de sugestii, in ordinea site-ului (primul = cel mai potrivit).
// Separata de retea ca sa poata fi testata pe un JSON salvat.
function MaximumParseProducts(const AJson: string): TArray<TMaximumProduct>;
// Codul produsului de pe pagina lui: "Cod produs" (span.product-code-value), altfel "sku" din
// JSON-LD; '' = negasit.
function MaximumParsePageCode(const AHtml: string): string;

// Produsul cu codul ACode: primul rezultat al cautarii, acceptat doar daca "Cod produs" de pe
// pagina lui e exact ACode (APageHtml = pagina RO descarcata, altfel ''). La False, ATitle spune
// motivul (pentru jurnal). Fara pret (> 0) produsul nu se accepta.
function MaximumFindProduct(AHttp: THTTPClient; const ACode: string; out AProductID: Int64;
  out APrice: Currency; out ATitle: string; out APageHtml: string): Boolean;

// Cererea catre API-ul de sugestii; intoarce JSON-ul brut. Erorile de retea / HTTP <> 200 = exceptie.
function MaximumFetchSuggestions(AHttp: THTTPClient; const ACode: string): string;
// Client HTTP configurat ca pentru maximum.md. Apelantul il elibereaza.
function MaximumCreateHttp: THTTPClient;

implementation

uses
  System.JSON, System.Generics.Collections, System.NetEncoding, System.NetConsts, System.Net.URLClient,
  System.RegularExpressions;

const
  cBaseUrl = 'https://maximum.md';
  cApiUrl = cBaseUrl + '/ro/products/search/suggestions?query=';
  cUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
    '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';
  cTimeoutMs = 10000;

function MaximumCreateHttp: THTTPClient;
begin
  Result := THTTPClient.Create;
  Result.UserAgent := cUserAgent;
  Result.ConnectionTimeout := cTimeoutMs;
  Result.ResponseTimeout := cTimeoutMs;
  Result.HandleRedirects := True;
end;

function MaximumFetchSuggestions(AHttp: THTTPClient; const ACode: string): string;
var
  Response: IHTTPResponse;
begin
  Response := AHttp.Get(cApiUrl + TNetEncoding.URL.Encode(Trim(ACode)), nil,
    [TNetHeader.Create('Accept', 'application/json')]);
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt('maximum.md a raspuns cu HTTP %d', [Response.StatusCode]);
  Result := Response.ContentAsString(TEncoding.UTF8);
end;

function MaximumParseProducts(const AJson: string): TArray<TMaximumProduct>;
var
  Root, Value: TJSONValue;
  Obj, PriceObj: TJSONObject;
  Item: TJSONValue;
  PriceValue: Double;
  P: TMaximumProduct;
begin
  Result := nil;
  Root := TJSONObject.ParseJSONValue(AJson);
  if Root = nil then
    raise Exception.Create('maximum.md: raspunsul nu este JSON valid.');
  try
    if not (Root is TJSONObject) then
      Exit;
    Obj := TJSONObject(Root);
    if not Obj.GetValue<Boolean>('success', False) then
      Exit;
    Value := Obj.GetValue('products');
    if not (Value is TJSONArray) then
      Exit;
    for Item in TJSONArray(Value) do
    begin
      if not (Item is TJSONObject) then
        Continue;
      P := Default(TMaximumProduct);
      if not TJSONObject(Item).TryGetValue<Int64>('_id', P.ID) then
        P.ID := 0;
      P.Title := TJSONObject(Item).GetValue<string>('title', '');
      Value := TJSONObject(Item).GetValue('price');
      if Value is TJSONObject then
      begin
        PriceObj := TJSONObject(Value);
        if PriceObj.TryGetValue<Double>('value', PriceValue) and (PriceValue > 0) then
          P.Price := PriceValue;
      end;
      Result := Result + [P];
    end;
  finally
    Root.Free;
  end;
end;

function MaximumParsePageCode(const AHtml: string): string;
var
  M: TMatch;
begin
  M := TRegEx.Match(AHtml, 'class="product-code-value"[^>]*>\s*([^<]*?)\s*<', [roIgnoreCase]);
  if M.Success then
    Result := Trim(M.Groups[1].Value)
  else
  begin
    M := TRegEx.Match(AHtml, '"sku"\s*:\s*"([^"]*)"', [roIgnoreCase]);
    if M.Success then
      Result := Trim(M.Groups[1].Value)
    else
      Result := '';
  end;
end;

function MaximumFindProduct(AHttp: THTTPClient; const ACode: string; out AProductID: Int64;
  out APrice: Currency; out ATitle: string; out APageHtml: string): Boolean;
var
  Products: TArray<TMaximumProduct>;
  First: TMaximumProduct;
  Response: IHTTPResponse;
  PageCode: string;
begin
  Result := False;
  AProductID := 0;
  APrice := 0;
  ATitle := '';
  APageHtml := '';

  Products := MaximumParseProducts(MaximumFetchSuggestions(AHttp, ACode));
  if Length(Products) = 0 then
  begin
    ATitle := 'niciun rezultat pe maximum.md';
    Exit;
  end;
  First := Products[0];
  if First.ID <= 0 then
  begin
    ATitle := 'primul rezultat nu are _id';
    Exit;
  end;

  // primul rezultat e cel mai potrivit dupa site, dar codul se verifica pe pagina lui - si cind e
  // singurul rezultat, fiindca cautarea gaseste si produse cu cifrele codului doar in titlu
  Response := AHttp.Get(Format('%s/ro/%d/', [cBaseUrl, First.ID]));
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt('maximum.md a raspuns cu HTTP %d la pagina produsului %d',
      [Response.StatusCode, First.ID]);
  APageHtml := Response.ContentAsString(TEncoding.UTF8);
  PageCode := MaximumParsePageCode(APageHtml);
  if not SameText(PageCode, Trim(ACode)) then
  begin
    if PageCode = '' then
      ATitle := Format('%d rezultat(e), pe pagina primului (_id %d) nu s-a gasit "Cod produs"',
        [Length(Products), First.ID])
    else
      ATitle := Format('%d rezultat(e), primul (_id %d) are "Cod produs" %s', [Length(Products), First.ID, PageCode]);
    APageHtml := '';
    Exit;
  end;

  if First.Price <= 0 then
  begin
    ATitle := Format('produsul _id %d nu are pret', [First.ID]);
    Exit;
  end;

  AProductID := First.ID;
  APrice := First.Price;
  ATitle := First.Title;
  Result := True;
end;

{ TMaximumPriceSource }

class function TMaximumPriceSource.ParserName: string;
begin
  Result := 'maximum';
end;

class function TMaximumPriceSource.DisplayName: string;
begin
  Result := 'Maximum (maximum.md)';
end;

class function TMaximumPriceSource.SupplierID: Integer;
begin
  Result := 229873;
end;

class function TMaximumPriceSource.DefaultDelayMs: Integer;
begin
  Result := 500; // DELAY_SECONDS = 0.5 din scriptul Python
end;

constructor TMaximumPriceSource.Create;
begin
  inherited;
  FHttp := MaximumCreateHttp;
end;

destructor TMaximumPriceSource.Destroy;
begin
  FHttp.Free;
  inherited;
end;

function TMaximumPriceSource.FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean;
var
  ProductID: Int64;
  Page: string;
begin
  Result := MaximumFindProduct(FHttp, ACode, ProductID, APrice, ATitle, Page);
end;

end.

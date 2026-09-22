unit MaximumPriceSourceUnit;

(* Sursa de pret pentru Maximum (maximum.md), furnizorul 229873.
  Convertit din D:\Projects\pythonProject\2025\maximum_web.py.

  Site-ul are un API JSON de sugestii la cautare:
    GET https://maximum.md/ro/products/search/suggestions?query=<cod>
    { "success": true, "total_products": {"value": 1}, "products": [
        { "_id": 6914145, "title": "...", "price": {"value": 4449.0, "unit": "lei"},
          "old_price": {"value": 5549.0} } ] }

  Diferente fata de scriptul Python:
    - raspunsul NU contine codul produsului, deci nu se poate verifica identitatea. Scriptul lua
      orbeste products[0]; aici pretul se accepta doar daca raspunsul are EXACT un produs -
      cu mai multe rezultate nu stim care e al nostru si articolul ramine neschimbat.
    - procentul de reducere nu mai e scris in cod (0.98 la scriere, 0.92 in mesajul din jurnal):
      se ia TS_CUSTOMER.RRP_DISCOUNT al furnizorului, in SupplierPriceSyncUnit.
    - articolele vin din TS_GOODS_FOREIGN cu FLG_IN_PRICE = 1, nu din ultimul pricelist.
    - FLG_EPP (bitul 4) nu se mai forteaza la fiecare scriere. *)

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, SupplierPriceSyncUnit;

type
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

// Interpretarea raspunsului, separata de retea ca sa poata fi testata pe un JSON salvat.
// AProductID = "_id"-ul produsului pe maximum.md (pagina lui: https://maximum.md/ro/<_id>/).
function MaximumParseProduct(const AJson: string; out AProductID: Int64; out APrice: Currency;
  out ATitle: string): Boolean;
function MaximumParseSuggestions(const AJson: string; out APrice: Currency; out ATitle: string): Boolean;

// Cererea catre API-ul de sugestii; intoarce JSON-ul brut. Erorile de retea / HTTP <> 200 = exceptie.
function MaximumFetchSuggestions(AHttp: THTTPClient; const ACode: string): string;
// Client HTTP configurat ca pentru maximum.md. Apelantul il elibereaza.
function MaximumCreateHttp: THTTPClient;

implementation

uses
  System.JSON, System.Generics.Collections, System.NetEncoding, System.NetConsts, System.Net.URLClient;

const
  cApiUrl = 'https://maximum.md/ro/products/search/suggestions?query=';
  cUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
    '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';
  cTimeoutMs = 10000;

function MaximumParseSuggestions(const AJson: string; out APrice: Currency; out ATitle: string): Boolean;
var
  ProductID: Int64;
begin
  Result := MaximumParseProduct(AJson, ProductID, APrice, ATitle);
end;

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

function MaximumParseProduct(const AJson: string; out AProductID: Int64; out APrice: Currency;
  out ATitle: string): Boolean;
var
  Root, Value: TJSONValue;
  Obj, Product, PriceObj: TJSONObject;
  Products: TJSONArray;
  PriceValue: Double;
begin
  Result := False;
  AProductID := 0;
  APrice := 0;
  ATitle := '';
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
    Products := TJSONArray(Value);
    // exact un produs: raspunsul nu contine codul, deci altfel nu stim care e al nostru
    if Products.Count <> 1 then
      Exit;
    if not (Products.Items[0] is TJSONObject) then
      Exit;
    Product := TJSONObject(Products.Items[0]);

    Value := Product.GetValue('price');
    if not (Value is TJSONObject) then
      Exit;
    PriceObj := TJSONObject(Value);
    if not PriceObj.TryGetValue<Double>('value', PriceValue) then
      Exit;
    if PriceValue <= 0 then
      Exit;

    if not Product.TryGetValue<Int64>('_id', AProductID) then
      AProductID := 0;
    APrice := PriceValue;
    ATitle := Product.GetValue<string>('title', '');
    Result := True;
  finally
    Root.Free;
  end;
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
begin
  Result := MaximumParseSuggestions(MaximumFetchSuggestions(FHttp, ACode), APrice, ATitle);
end;

end.

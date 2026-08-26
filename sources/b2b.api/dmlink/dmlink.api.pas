unit dmlink.api;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.URLClient,
  System.Net.HttpClientComponent, System.JSON, System.Generics.Collections;

type
  TDMLinkAPI = class
  private
    FHttpClient: TNetHTTPClient;
    FToken: string;
    FUserId: string;
    FBaseURL: string;
    function SendRequest(AMethod: string; AEndpoint: string; ABody: TStringStream = nil): string;
  public
    constructor Create;
    destructor Destroy; override;

    // Autentificare
    function Login(const Email, Password: string): Boolean;

    // Produse
    function GetProducts(Limit: Integer = 0): string;
    function GetProductBySKU(const SKU: string): string;

    // Comenzi
    function CreateOrder(const Products: TDictionary<string, Integer>; const Comment: string): string;

    property Token: string read FToken;
    property UserId: string read FUserId;
  end;

implementation

{ TDMLinkAPI }

constructor TDMLinkAPI.Create;
begin
  FBaseURL := 'https://b2b.dmlink.md/api';
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.ContentType := 'application/json';
  FHttpClient.Accept := 'application/json';
end;

destructor TDMLinkAPI.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TDMLinkAPI.SendRequest(AMethod, AEndpoint: string; ABody: TStringStream): string;
var
  LResponse: IHTTPResponse;
  LURL: string;
begin
  LURL := FBaseURL + AEndpoint;

  // Adaugam Token-ul in Header daca exista (pentru V2)
  if FToken <> '' then
    FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;

  try
    if AMethod = 'POST' then
      LResponse := FHttpClient.Post(LURL, ABody)
    else
      LResponse := FHttpClient.Get(LURL);

    Result := LResponse.ContentAsString;
  except
    on E: Exception do
      raise Exception.Create('Eroare API (' + AEndpoint + '): ' + E.Message);
  end;
end;

function TDMLinkAPI.Login(const Email, Password: string): Boolean;
var
  LJSON, LResponseJSON: TJSONObject;
  LBody: TStringStream;
  LResponseStr: string;
begin
  Result := False;
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('email', Email);
    LJSON.AddPair('password', Password);

    LBody := TStringStream.Create(LJSON.ToJSON, TEncoding.UTF8);
    try
      // Autentificarea foloseste v1 conform documentatiei
      LResponseStr := SendRequest('POST', '/v1/auth/login', LBody);

      LResponseJSON := TJSONObject.ParseJSONValue(LResponseStr) as TJSONObject;
      try
        if (LResponseJSON <> nil) and (LResponseJSON.Count>0) and (not LResponseJSON.Values['token'].Value.IsEmpty) then
        begin
          FToken := LResponseJSON.GetValue<string>('token');
          FUserId := LResponseJSON.GetValue<TJSONObject>('user').GetValue<string>('userId');
          Result := True;
        end;
      finally
        LResponseJSON.Free;
      end;
    finally
      LBody.Free;
    end;
  finally
    LJSON.Free;
  end;
end;

function TDMLinkAPI.GetProducts(Limit: Integer): string;
var
  LEndpoint: string;
begin
  LEndpoint := '/v2/products';
  if Limit > 0 then
    LEndpoint := LEndpoint + '?limit=' + Limit.ToString;

  Result := SendRequest('GET', LEndpoint);
end;

function TDMLinkAPI.GetProductBySKU(const SKU: string): string;
begin
  Result := SendRequest('GET', '/v2/product/' + SKU);
end;

function TDMLinkAPI.CreateOrder(const Products: TDictionary<string, Integer>; const Comment: string): string;
var
  LJSON, LProdJSON: TJSONObject;
  LArray: TJSONArray;
  LBody: TStringStream;
  LSKU: string;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('dealerId', FUserId);
    LArray := TJSONArray.Create;

    for LSKU in Products.Keys do
    begin
      LProdJSON := TJSONObject.Create;
      LProdJSON.AddPair('sku', LSKU);
      LProdJSON.AddPair('qty', Products[LSKU].ToString);
      LArray.AddElement(LProdJSON);
    end;

    LJSON.AddPair('products', LArray);
    LJSON.AddPair('comment', Comment);

    LBody := TStringStream.Create(LJSON.ToJSON, TEncoding.UTF8);
    try
      Result := SendRequest('POST', '/v2/create/order', LBody);
    finally
      LBody.Free;
    end;
  finally
    LJSON.Free;
  end;
end;

end.

unit B2B.DMlink;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient,
  System.Net.URLClient;

type
  TB2BBrand = record
    ID: string;
    Name: string;
  end;

  TB2BCategory = record
    ID: string;
    Name: string;
    Slug: string;
    Parents: TJSONObject;
  end;

  TB2BProduct = record
    ID: string;
    Name: string;
    SKU: string;
    Slug: string;
    EAN: string;
    Color: string;
    WarrantyPeriod: Integer;
    Description: string;
    ShortDescription: string;
    RPrice: Currency;
    SPrice: Currency;
    NPrice: Currency;
    Stock: Integer;
    Transit: Integer;
    Brand: TB2BBrand;
    Category: TB2BCategory;
    Specifications: TJSONArray;
    Images: TJSONArray;
    RawJSON: string;
  end;

  TB2BDMlink = class
  private
    FHttpClient: THTTPClient;
    FToken: string;
    FBaseURL: string;
    function ParseToken(const AResponse: string): string;
    function ParseProduct(const AResponse: string; out AProduct: TB2BProduct): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function Login(const AEmail, APassword: string): Boolean;
    function GetToken: string;
    function GetProduct(const ASKU: string; out AProduct: TB2BProduct): Boolean;

    property Token: string read FToken;
    property BaseURL: string read FBaseURL write FBaseURL;
  end;

implementation

{ TB2BDMlink }

constructor TB2BDMlink.Create;
begin
  inherited;
  FHttpClient := THTTPClient.Create;
  FHttpClient.ConnectionTimeout := 30000;
  FHttpClient.ResponseTimeout := 30000;
  FBaseURL := 'https://b2b.dmlink.md/api';
  FToken := '';
end;

destructor TB2BDMlink.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TB2BDMlink.ParseToken(const AResponse: string): string;
var
  JsonObj: TJSONObject;
  JsonVal: TJSONValue;
begin
  Result := '';
  JsonObj := nil;
  try
    JsonObj := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
    if Assigned(JsonObj) then
    begin
      // Try common token field names
      if JsonObj.TryGetValue('token', JsonVal) then
        Result := JsonVal.Value
      else if JsonObj.TryGetValue('access_token', JsonVal) then
        Result := JsonVal.Value
      else if JsonObj.TryGetValue('accessToken', JsonVal) then
        Result := JsonVal.Value;
    end;
  finally
    JsonObj.Free;
  end;
end;

function TB2BDMlink.ParseProduct(const AResponse: string; out AProduct: TB2BProduct): Boolean;
var
  JsonObj, BrandObj, CategoryObj: TJSONObject;
  JsonVal: TJSONValue;
begin
  Result := False;
  FillChar(AProduct, SizeOf(AProduct), 0);
  JsonObj := nil;

  try
    JsonObj := TJSONObject.ParseJSONValue(AResponse) as TJSONObject;
    if not Assigned(JsonObj) then
      Exit;

    // Store raw JSON
    AProduct.RawJSON := AResponse;

    // Parse basic fields
    if JsonObj.TryGetValue('id', JsonVal) then
      AProduct.ID := JsonVal.Value;
    if JsonObj.TryGetValue('name', JsonVal) then
      AProduct.Name := JsonVal.Value;
    if JsonObj.TryGetValue('sku', JsonVal) then
      AProduct.SKU := JsonVal.Value;
    if JsonObj.TryGetValue('slug', JsonVal) then
      AProduct.Slug := JsonVal.Value;
    if JsonObj.TryGetValue('ean', JsonVal) then
      AProduct.EAN := JsonVal.Value;
    if JsonObj.TryGetValue('color', JsonVal) then
      AProduct.Color := JsonVal.Value;
    if JsonObj.TryGetValue('warrantyPeriod', JsonVal) then
      AProduct.WarrantyPeriod := StrToIntDef(JsonVal.Value, 0);

    // Parse nullable strings
    if JsonObj.TryGetValue('description', JsonVal) and not JsonVal.Null then
      AProduct.Description := JsonVal.Value;
    if JsonObj.TryGetValue('shortDescription', JsonVal) and not JsonVal.Null then
      AProduct.ShortDescription := JsonVal.Value;

    // Parse prices
    if JsonObj.TryGetValue('rprice', JsonVal) then
      AProduct.RPrice := StrToFloatDef(JsonVal.Value, 0);
    if JsonObj.TryGetValue('sprice', JsonVal) then
      AProduct.SPrice := StrToFloatDef(JsonVal.Value, 0);
    if JsonObj.TryGetValue('nprice', JsonVal) then
      AProduct.NPrice := StrToFloatDef(JsonVal.Value, 0);

    // Parse stock
    if JsonObj.TryGetValue('stock', JsonVal) then
      AProduct.Stock := StrToIntDef(JsonVal.Value, 0);
    if JsonObj.TryGetValue('transit', JsonVal) then
      AProduct.Transit := StrToIntDef(JsonVal.Value, 0);

    // Parse brand
    if JsonObj.TryGetValue('brand', JsonVal) and (JsonVal is TJSONObject) then
    begin
      BrandObj := JsonVal as TJSONObject;
      if BrandObj.TryGetValue('id', JsonVal) then
        AProduct.Brand.ID := JsonVal.Value;
      if BrandObj.TryGetValue('name', JsonVal) then
        AProduct.Brand.Name := JsonVal.Value;
    end;

    // Parse category
    if JsonObj.TryGetValue('category', JsonVal) and (JsonVal is TJSONObject) then
    begin
      CategoryObj := JsonVal as TJSONObject;
      if CategoryObj.TryGetValue('id', JsonVal) then
        AProduct.Category.ID := JsonVal.Value;
      if CategoryObj.TryGetValue('name', JsonVal) then
        AProduct.Category.Name := JsonVal.Value;
      if CategoryObj.TryGetValue('slug', JsonVal) then
        AProduct.Category.Slug := JsonVal.Value;
      if CategoryObj.TryGetValue('parents', JsonVal) then
        AProduct.Category.Parents := (JsonVal as TJSONObject).Clone as TJSONObject;
    end;

    // Parse arrays (keep as JSON for flexibility)
    if JsonObj.TryGetValue('specifications', JsonVal) and (JsonVal is TJSONArray) then
      AProduct.Specifications := (JsonVal as TJSONArray).Clone as TJSONArray;
    if JsonObj.TryGetValue('images', JsonVal) and (JsonVal is TJSONArray) then
      AProduct.Images := (JsonVal as TJSONArray).Clone as TJSONArray;

    Result := True;
  finally
    JsonObj.Free;
  end;
end;

function TB2BDMlink.Login(const AEmail, APassword: string): Boolean;
var
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
  RequestBody: TStringStream;
  URL: string;
begin
  Result := False;
  FToken := '';

  JsonObj := TJSONObject.Create;
  RequestBody := nil;
  try
    // Build JSON request
    JsonObj.AddPair('email', AEmail);
    JsonObj.AddPair('password', APassword);

    RequestBody := TStringStream.Create(JsonObj.ToString, TEncoding.UTF8);

    // Set headers
    FHttpClient.ContentType := 'application/json';
    FHttpClient.Accept := 'application/json';

    // Make request
    URL := FBaseURL + '/v1/auth/login';
    Response := FHttpClient.Post(URL, RequestBody);

    // Check response
    if (Response.StatusCode = 200) or (Response.StatusCode = 201) then
    begin
      FToken := ParseToken(Response.ContentAsString);
      Result := FToken <> '';

      // Set token for future requests
      if Result then
        FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;
    end;
  finally
    JsonObj.Free;
    RequestBody.Free;
  end;
end;

function TB2BDMlink.GetToken: string;
begin
  Result := FToken;
end;

function TB2BDMlink.GetProduct(const ASKU: string; out AProduct: TB2BProduct): Boolean;
var
  Response: IHTTPResponse;
  URL: string;
begin
  Result := False;

  if FToken = '' then
    Exit; // Must be logged in

  try
    // Build URL
    URL := FBaseURL + '/v2/product/' + ASKU;

    // Make request
    Response := FHttpClient.Get(URL);

    // Check response
    if Response.StatusCode = 200 then
      Result := ParseProduct(Response.ContentAsString, AProduct);
  except
    on E: Exception do
      Result := False;
  end;
end;

end.

unit DMLinkAPIClientUnit;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient, System.Net.URLClient, System.Net.HttpClientComponent;

type
  TDMLinkAPIClient = class
  private
    FHttpClient: TNetHTTPClient;
    FBaseUrlV1: string;
    FBaseUrlV2: string;
    FToken: string;
  public
    constructor Create;
    destructor Destroy; override;

    function Login(const AEmail, APassword: string): Boolean;
    function GetAllProducts(ALimit: Integer = 0): string;
    function GetProductBySKU(const ASKU: string): string;
    function CreateOrder(const ADealerId: string; const AProducts: TJSONArray; const AComment: string): string;

    property Token: string read FToken;
  end;

implementation

constructor TDMLinkAPIClient.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpClient.ContentType := 'application/json';
  FBaseUrlV1 := 'https://b2b.dmlink.md/api/v1';
  FBaseUrlV2 := 'https://b2b.dmlink.md/api/v2';
end;

destructor TDMLinkAPIClient.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TDMLinkAPIClient.Login(const AEmail, APassword: string): Boolean;
var
  LBody, LResponse: string;
  LJson, LUser: TJSONObject;
begin
  Result := False;
//  AEmail := 'duca.al@gmail.com';
//  APassword := 'Uno2025!@';
  LJson := TJSONObject.Create;
  try
    LJson.AddPair('email', AEmail);
    LJson.AddPair('password', APassword);
    LBody := LJson.ToJSON;
    LResponse := FHttpClient.Post(FBaseUrlV1 + '/auth/login', TStringStream.Create(LBody, TEncoding.UTF8)).ContentAsString;

    LJson.Free;
    LJson := TJSONObject.ParseJSONValue(LResponse) as TJSONObject;
    if Assigned(LJson) and LJson.TryGetValue('token', FToken) then
      Result := True;
  finally
    LJson.Free;
  end;
end;

function TDMLinkAPIClient.GetAllProducts(ALimit: Integer): string;
var
  LUrl: string;
begin
  if FToken = '' then
    raise Exception.Create('Token not set. Please login first.');

  LUrl := FBaseUrlV2 + '/products';
  if ALimit > 0 then
    LUrl := LUrl + '?limit=' + ALimit.ToString;

  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;
  Result := FHttpClient.Get(LUrl).ContentAsString;
end;

function TDMLinkAPIClient.GetProductBySKU(const ASKU: string): string;
begin
  if FToken = '' then
    raise Exception.Create('Token not set. Please login first.');

  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;
  Result := FHttpClient.Get(FBaseUrlV2 + '/product/' + ASKU).ContentAsString;
end;

function TDMLinkAPIClient.CreateOrder(const ADealerId: string; const AProducts: TJSONArray; const AComment: string): string;
var
  LJson: TJSONObject;
  LStream: TStringStream;
begin
  if FToken = '' then
    raise Exception.Create('Token not set. Please login first.');

  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FToken;

  LJson := TJSONObject.Create;
  try
    LJson.AddPair('dealerId', ADealerId);
    LJson.AddPair('products', AProducts);
    LJson.AddPair('comment', AComment);

    LStream := TStringStream.Create(LJson.ToJSON, TEncoding.UTF8);
    try
      Result := FHttpClient.Post(FBaseUrlV2 + '/create/order', LStream).ContentAsString;
    finally
      LStream.Free;
    end;
  finally
    LJson.Free;
  end;
end;

end.

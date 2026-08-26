unit SCOPAPIClientUnit;

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Net.HttpClient,
  System.Net.URLClient, System.DateUtils;

type
  TScopProductInfo = record
    Price: Double;
    StockQuantity: Integer;
    Available: Boolean;
    Name: String;
    SKU: String;
  end;

  TSCOPAPIClient = class
  private
    FHttpClient: THTTPClient;
    FBaseURL: string;
    FEmail: string;
    FPassword: string;
    FAccessToken: string;
    FRefreshToken: string;
    FTokenExpiry: TDateTime;

    function GetAuthHeaders: TNetHeaders;
    procedure UpdateTokens(const AAccessToken, ARefreshToken: string);
    function IsTokenValid: Boolean;
  public
    constructor Create(const AEmail, APassword: string);
    destructor Destroy; override;

    // Autentificare
    function Login: Boolean;
    function RefreshAccessToken: Boolean;

    // Obținerea informațiilor despre produs
    function GetProductInfoBySlug(const ASlug: string; out AProductInfo: TScopProductInfo): Boolean;
    function GetProductInfoBySKU(const ASKU: string; out AProductInfo: TScopProductInfo): Boolean;

    property AccessToken: string read FAccessToken;
    property BaseURL: string read FBaseURL write FBaseURL;
  end;

implementation

{ TSCOPAPIClient }

constructor TSCOPAPIClient.Create(const AEmail, APassword: string);
begin
  inherited Create;
  FHttpClient := THTTPClient.Create;
  FBaseURL := 'https://api.scop.md';
  FEmail := AEmail;
  FPassword := APassword;
  FAccessToken := '';
  FRefreshToken := '';
  FTokenExpiry := 0;
end;

destructor TSCOPAPIClient.Destroy;
begin
  FHttpClient.Free;
  inherited;
end;

function TSCOPAPIClient.GetAuthHeaders: TNetHeaders;
begin
  SetLength(Result, 2);
  Result[0] := TNetHeader.Create('Authorization', 'Bearer ' + FAccessToken);
  Result[1] := TNetHeader.Create('Content-Type', 'application/json');
end;

procedure TSCOPAPIClient.UpdateTokens(const AAccessToken, ARefreshToken: string);
begin
  FAccessToken := AAccessToken;
  FRefreshToken := ARefreshToken;
  // Token-ul este valid pentru aproximativ 1 oră
  FTokenExpiry := IncHour(Now, 1);
end;

function TSCOPAPIClient.IsTokenValid: Boolean;
begin
  Result := (FAccessToken <> '') and (Now < FTokenExpiry);
end;

function TSCOPAPIClient.Login: Boolean;
var
  LResponse: IHTTPResponse;
  LRequestBody: TJSONObject;
  LResponseJSON: TJSONObject;
  LRequestStream: TStringStream;
  LAccessToken, LRefreshToken: string;
begin
  Result := False;

  try
    // Crearea request body
    LRequestBody := TJSONObject.Create;
    try
      LRequestBody.AddPair('email', FEmail);
      LRequestBody.AddPair('password', FPassword);

      LRequestStream := TStringStream.Create(LRequestBody.ToString, TEncoding.UTF8);
      try
        // Trimiterea request-ului
        LResponse := FHttpClient.Post(
          FBaseURL + '/api/account/login',
          LRequestStream,
          nil,
          [TNetHeader.Create('Content-Type', 'application/json')]
        );

        // Verificarea răspunsului
        if LResponse.StatusCode = 200 then
        begin
          LResponseJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
          try
            if Assigned(LResponseJSON) then
            begin
              LAccessToken := LResponseJSON.GetValue<string>('accessToken', '');
              LRefreshToken := LResponseJSON.GetValue<string>('refreshToken', '');

              if (LAccessToken <> '') and (LRefreshToken <> '') then
              begin
                UpdateTokens(LAccessToken, LRefreshToken);
                Result := True;
              end;
            end;
          finally
            LResponseJSON.Free;
          end;
        end;
      finally
        LRequestStream.Free;
      end;
    finally
      LRequestBody.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Login failed: ' + E.Message);
  end;
end;

function TSCOPAPIClient.RefreshAccessToken: Boolean;
var
  LResponse: IHTTPResponse;
  LRequestBody: TJSONObject;
  LResponseJSON: TJSONObject;
  LRequestStream: TStringStream;
  LAccessToken, LRefreshToken: string;
begin
  Result := False;

  try
    LRequestBody := TJSONObject.Create;
    try
      LRequestBody.AddPair('accessToken', FAccessToken);
      LRequestBody.AddPair('refreshToken', FRefreshToken);

      LRequestStream := TStringStream.Create(LRequestBody.ToString, TEncoding.UTF8);
      try
        LResponse := FHttpClient.Post(
          FBaseURL + '/api/account/refresh-token',
          LRequestStream,
          nil,
          [TNetHeader.Create('Content-Type', 'application/json')]
        );

        if LResponse.StatusCode = 200 then
        begin
          LResponseJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
          try
            if Assigned(LResponseJSON) then
            begin
              LAccessToken := LResponseJSON.GetValue<string>('accessToken', '');
              LRefreshToken := LResponseJSON.GetValue<string>('refreshToken', '');

              if (LAccessToken <> '') and (LRefreshToken <> '') then
              begin
                UpdateTokens(LAccessToken, LRefreshToken);
                Result := True;
              end;
            end;
          finally
            LResponseJSON.Free;
          end;
        end;
      finally
        LRequestStream.Free;
      end;
    finally
      LRequestBody.Free;
    end;
  except
    on E: Exception do
      raise Exception.Create('Token refresh failed: ' + E.Message);
  end;
end;

function TSCOPAPIClient.GetProductInfoBySlug(const ASlug: string;
  out AProductInfo: TScopProductInfo): Boolean;
var
  LResponse: IHTTPResponse;
  LResponseJSON: TJSONObject;
  LPriceValue: TJSONValue;
begin
  Result := False;

  // Verificăm dacă token-ul este valid
  if not IsTokenValid then
  begin
    if not Login then
      Exit;
  end;

  try
    LResponse := FHttpClient.Get(
      FBaseURL + '/api/shop-products/' + ASlug,
      nil,
      GetAuthHeaders
    );

    if LResponse.StatusCode = 200 then
    begin
      LResponseJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
      try
        if Assigned(LResponseJSON) then
        begin
          // Extragem informațiile despre produs
          AProductInfo.Name := LResponseJSON.GetValue<string>('name', '');
          AProductInfo.SKU := LResponseJSON.GetValue<string>('sku', '');

          // Prețul poate fi string sau number în JSON
          LPriceValue := LResponseJSON.GetValue('price');
          if Assigned(LPriceValue) then
          begin
            if LPriceValue is TJSONNumber then
              AProductInfo.Price := TJSONNumber(LPriceValue).AsDouble
            else if LPriceValue is TJSONString then
              AProductInfo.Price := StrToFloatDef(LPriceValue.Value, 0);
          end
          else
            AProductInfo.Price := 0;

          AProductInfo.StockQuantity := LResponseJSON.GetValue<Integer>('stockQuantity', 0);
          AProductInfo.Available := LResponseJSON.GetValue<Boolean>('isAvailable', False);

          Result := True;
        end;
      finally
        LResponseJSON.Free;
      end;
    end
    else if LResponse.StatusCode = 401 then
    begin
      // Token expirat, reîncercăm cu refresh
      if RefreshAccessToken then
        Result := GetProductInfoBySlug(ASlug, AProductInfo);
    end;
  except
    on E: Exception do
      raise Exception.Create('Failed to get product info: ' + E.Message);
  end;
end;

function TSCOPAPIClient.GetProductInfoBySKU(const ASKU: string;
  out AProductInfo: TScopProductInfo): Boolean;
var
  LResponse: IHTTPResponse;
  LResponseJSON: TJSONObject;
  LPriceValue: TJSONValue;
begin
  Result := False;

  // Verificăm dacă token-ul este valid
  if not IsTokenValid then
  begin
    if not Login then
      Exit;
  end;

  try
    LResponse := FHttpClient.Get(
      FBaseURL + '/api/shop-products/quick/' + ASKU,
      nil,
      GetAuthHeaders
    );

    if LResponse.StatusCode = 200 then
    begin
      LResponseJSON := TJSONObject.ParseJSONValue(LResponse.ContentAsString) as TJSONObject;
      try
        if Assigned(LResponseJSON) then
        begin
          AProductInfo.Name := LResponseJSON.GetValue<string>('name', '');
          AProductInfo.SKU := LResponseJSON.GetValue<string>('sku', '');

          // Prețul poate fi string sau number în JSON
          LPriceValue := LResponseJSON.GetValue('price');
          if Assigned(LPriceValue) then
          begin
            if LPriceValue is TJSONNumber then
              AProductInfo.Price := TJSONNumber(LPriceValue).AsDouble
            else if LPriceValue is TJSONString then
              AProductInfo.Price := StrToFloatDef(LPriceValue.Value, 0);
          end
          else
            AProductInfo.Price := 0;

          AProductInfo.StockQuantity := LResponseJSON.GetValue<Integer>('stockQuantity', 0);
          AProductInfo.Available := LResponseJSON.GetValue<Boolean>('isAvailable', False);

          Result := True;
        end;
      finally
        LResponseJSON.Free;
      end;
    end
    else if LResponse.StatusCode = 401 then
    begin
      if RefreshAccessToken then
        Result := GetProductInfoBySKU(ASKU, AProductInfo);
    end;
  except
    on E: Exception do
      raise Exception.Create('Failed to get product info by SKU: ' + E.Message);
  end;
end;

end.

unit AccentAuthService;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  IdHTTP, IdSSLOpenSSL, IdCompressorZLib;

type
  // Interfața pe care o folosește restul aplicației
  IAccentAuthService = interface
    ['{F3C8F0B9-62C1-4D4C-9C9E-1F9D7E8F7C2E}']
    function FetchGuidFromApi(out AGuid: string): Boolean;
  end;

  // Implementarea concretă, reutilizabilă (fără UI)
  TAccentAuthService = class(TInterfacedObject, IAccentAuthService)
  private
    FHTTP: TIdHTTP;
    FSSL: TIdSSLIOHandlerSocketOpenSSL;
    FZLib: TIdCompressorZLib;
    FBaseUrl: string;
    FUserLogin: string;
    FUserPassword: string;
  public
    constructor Create(const ABaseUrl, AUserLogin, AUserPassword: string);
    destructor Destroy; override;

    function FetchGuidFromApi(out AGuid: string): Boolean;

    property BaseUrl: string read FBaseUrl write FBaseUrl;
    property UserLogin: string read FUserLogin write FUserLogin;
    property UserPassword: string read FUserPassword write FUserPassword;
  end;

implementation

{ TAccentAuthService }

constructor TAccentAuthService.Create(const ABaseUrl, AUserLogin, AUserPassword: string);
begin
  inherited Create;
  FBaseUrl      := ABaseUrl;
  FUserLogin    := AUserLogin;
  FUserPassword := AUserPassword;

  FSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];

  FHTTP := TIdHTTP.Create(nil);
  FHTTP.IOHandler := FSSL;
  FHTTP.HandleRedirects := True;
  FHTTP.ReadTimeout     := 15000;
  FHTTP.ConnectTimeout  := 8000;
  FHTTP.Request.UserAgent   := 'AccentAuth/1.0 (Delphi; Indy)';
  FHTTP.Request.Accept      := 'application/json';
  FHTTP.Request.ContentType := 'application/json; charset=UTF-8';

  FZLib := TIdCompressorZLib.Create(nil);
  FHTTP.Compressor := FZLib;
  FHTTP.Request.AcceptEncoding := 'gzip, deflate';
end;

destructor TAccentAuthService.Destroy;
begin
  FHTTP.Free;
  FSSL.Free;
  FZLib.Free;
  inherited;
end;

function TAccentAuthService.FetchGuidFromApi(out AGuid: string): Boolean;
var
  Body, Resp: string;
  SS: TStringStream;
  JV: TJSONValue;
  JO: TJSONObject;
begin
  Result := False;
  AGuid  := '';

  Body := Format('{"userlogin":"%s","userpassword":"%s"}',
                 [FUserLogin.Replace('"','\"'), FUserPassword.Replace('"','\"')]);

  SS := TStringStream.Create(Body, TEncoding.UTF8);
  try
    try
      Resp := FHTTP.Post(FBaseUrl + '/loginuser/getid', SS);
    except
      on E: Exception do
        Exit(False); // lasă UI/logging-ul în alt strat
    end;
  finally
    SS.Free;
  end;

  JV := TJSONObject.ParseJSONValue(Resp);
  try
    if (JV is TJSONObject) then
    begin
      JO := TJSONObject(JV);
      Result := JO.TryGetValue<string>('guid', AGuid) and (AGuid <> '');
    end;
  finally
    JV.Free;
  end;
end;

end.


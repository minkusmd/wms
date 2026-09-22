unit UltraCurrencyRateThread;

{ Verificarea cursului USD la Ultra.md la pornirea SWN.exe.

  Pornit din SWN.dpr imediat dupa dmDB.TryConnect. Un fir de executie separat:
    1. citeste credentialele din TS_API_CONFIG (API_CODE = 'ULTRA_ESHOP');
    2. se autentifica la API-ul eShop Ultra (POST /auth/token, Bearer);
    3. cere GET /product?limit=N si ia cursul din primul pret in USD
       (currency.code = 840, currency.rate). API-ul nu are un endpoint separat
       pentru valute - cursul vine in fiecare pret (vezi ultra2_parsers.py din
       pythonProject\2025);
    4. compara cu TS_CURRENCY (CURRENCYID = 840) si, daca difera, actualizeaza
       EXCHANGE_RATE si TRANSFER_RATE. BNM_RATE si DEGHEST_RATE raman neatinse,
       ca la actualizarile automate anterioare din TS_CURRENCY_HISTORY.
       Triggerul TS_CURRENCY_AU0 scrie singur istoricul in TS_CURRENCY_HISTORY,
       cu utilizatorul logat in SWN ca MODIFIED_BY.

  Firul are conexiune proprie la baza (componentele IBDAC ale dmDB nu sunt
  sigure intre fire) si nu blocheaza pornirea. Erorile nu ajung la utilizator:
  se scriu in ultra_currency.log din folderul de date al aplicatiei.

  Protectii: cursul trebuie sa fie intre cMinSaneRate si cMaxSaneRate, iar o
  diferenta de peste cMaxRelativeChange fata de TRANSFER_RATE nu se aplica
  automat (se scrie doar in jurnal) - cursul intra in toate preturile. }

interface

uses
  System.SysUtils;

// Apelat pe firul principal dupa fiecare verificare reusita a cursului (schimbat
// sau nu), ca interfata sa reciteasca TS_CURRENCY. Setat de TfrmMainForm.
var
  OnUltraUsdRateChecked: TProc;

// Porneste verificarea in fundal. Sigur de apelat oricand: orice problema e
// inghitita, pornirea aplicatiei nu depinde de Ultra.
procedure StartUltraCurrencyRateCheck;

implementation

uses
  System.Classes,
  System.Math,
  System.JSON,
  System.Generics.Collections,
  System.Net.HttpClient,
  System.Net.URLClient,
  Data.DB,
  DBAccess,
  MemDS,
  IBC,
  DataModuleDB,
  SWNValueStorageUnit;

const
  cUsdCurrencyID     = 840;
  cUltraApiCode      = 'ULTRA_ESHOP';
  cUltraDefaultURL   = 'https://eshop.ultra.md/api';
  cProductSampleSize = 5;      // cateva produse ajung: aproape fiecare are pret in USD
  cMinSaneRate       = 5.0;
  cMaxSaneRate       = 100.0;
  cMaxRelativeChange = 0.10;   // 10%
  cRateEpsilon       = 0.00001;
  cLogFileName       = 'ultra_currency.log';

  // Campurile de pret din raspunsul /product, fiecare cu currency {code, name, rate}
  cPriceFields: array[0..3] of string = ('user_price', 'price_d', 'fixed_price', 'promo_b2b');

type
  TUltraCurrencyRateThread = class(TThread)
  private
    FServer: string;
    FPort: string;
    FDatabase: string;
    FUserName: string;
    FPassword: string;
    FClientLibrary: string;
    FUserID: Integer;
    FLogFile: string;
    FFmt: TFormatSettings;
    procedure Log(const AMessage: string);
    function OpenConnection: TIBCConnection;
    function LoadApiConfig(AConn: TIBCConnection; out ABaseURL, AUser, APassword: string): Boolean;
    function FetchUltraUsdRate(const ABaseURL, AUser, APassword: string; out ARate: Double): Boolean;
    procedure ApplyRate(AConn: TIBCConnection; const ARate: Double);
  protected
    procedure Execute; override;
  public
    constructor Create(ASource: TIBCConnection; AUserID: Integer; const ALogFile: string);
  end;

function JsonNumber(AObj: TJSONObject; const AName: string; const ADefault: Double): Double;
var
  Value: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then
    Exit;
  Value := AObj.GetValue(AName);
  if Value is TJSONNumber then
    Result := TJSONNumber(Value).AsDouble
  else if Value is TJSONString then
    Result := StrToFloatDef(Value.Value, ADefault, TFormatSettings.Invariant);
end;

procedure NotifyRateChecked;
begin
  // Queue(nil, ...) nu e legat de fir, deci ruleaza si dupa ce firul s-a eliberat.
  TThread.Queue(nil,
    procedure
    begin
      if Assigned(OnUltraUsdRateChecked) then
        OnUltraUsdRateChecked();
    end);
end;

{ TUltraCurrencyRateThread }

constructor TUltraCurrencyRateThread.Create(ASource: TIBCConnection; AUserID: Integer; const ALogFile: string);
begin
  // Firul porneste abia dupa constructor (AfterConstruction), deci campurile
  // de mai jos sunt deja completate cand ruleaza Execute.
  inherited Create(False);
  FreeOnTerminate := True;

  // Copiem parametrii conexiunii principale pe firul principal; in Execute nu
  // atingem dmDB.
  FServer := ASource.Server;
  FPort := ASource.Port;
  FDatabase := ASource.Database;
  FUserName := ASource.Username;
  FPassword := ASource.Password;
  FClientLibrary := ASource.ClientLibrary;
  FUserID := AUserID;
  FLogFile := ALogFile;
  FFmt := TFormatSettings.Invariant;
end;

procedure TUltraCurrencyRateThread.Log(const AMessage: string);
var
  F: TextFile;
begin
  if FLogFile = '' then
    Exit;
  try
    AssignFile(F, FLogFile);
    if FileExists(FLogFile) then
      Append(F)
    else
      Rewrite(F);
    try
      Writeln(F, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '  ' + AMessage);
    finally
      CloseFile(F);
    end;
  except
    // jurnalul nu are voie sa opreasca verificarea
  end;
end;

function TUltraCurrencyRateThread.OpenConnection: TIBCConnection;
begin
  Result := TIBCConnection.Create(nil);
  try
    Result.ClientLibrary := FClientLibrary;
    Result.Server := FServer;
    Result.Port := FPort;
    Result.Database := FDatabase;
    Result.Username := FUserName;
    Result.Password := FPassword;
    Result.LoginPrompt := False;
    Result.Options.Charset := 'UTF8';
    Result.Options.UseUnicode := True;
    Result.Connect;
  except
    Result.Free;
    raise;
  end;
end;

procedure TUltraCurrencyRateThread.Execute;
var
  Conn: TIBCConnection;
  BaseURL, User, Password: string;
  Rate: Double;
begin
  NameThreadForDebugging('UltraCurrencyRate');
  try
    Conn := OpenConnection;
    try
      if not LoadApiConfig(Conn, BaseURL, User, Password) then
        Exit;
      if Terminated then
        Exit;

      if not FetchUltraUsdRate(BaseURL, User, Password, Rate) then
        Exit;
      if Terminated then
        Exit;

      ApplyRate(Conn, Rate);
      NotifyRateChecked;
    finally
      Conn.Free;
    end;
  except
    on E: Exception do
      Log('Eroare la verificarea cursului Ultra: ' + E.ClassName + ': ' + E.Message);
  end;
end;

function TUltraCurrencyRateThread.LoadApiConfig(AConn: TIBCConnection;
  out ABaseURL, AUser, APassword: string): Boolean;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  ParamName: string;
begin
  ABaseURL := '';
  AUser := '';
  APassword := '';

  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConn;
    Q.Connection := AConn;
    Q.Transaction := Tr;
    Q.SQL.Text := 'SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG ' +
      'WHERE API_CODE = :API_CODE AND FLG_ACTIVE = 1';
    Q.ParamByName('API_CODE').AsString := cUltraApiCode;
    Q.Open;
    while not Q.Eof do
    begin
      ParamName := UpperCase(Trim(Q.FieldByName('PARAM_NAME').AsString));
      if ParamName = 'BASE_URL' then
        ABaseURL := Trim(Q.FieldByName('PARAM_VALUE').AsString)
      else if ParamName = 'USERNAME' then
        AUser := Trim(Q.FieldByName('PARAM_VALUE').AsString)
      else if ParamName = 'PASSWORD' then
        APassword := Q.FieldByName('PARAM_VALUE').AsString;
      Q.Next;
    end;
    Q.Close;
    if Tr.Active then
      Tr.Commit;
  finally
    Q.Free;
    Tr.Free;
  end;

  if ABaseURL = '' then
    ABaseURL := cUltraDefaultURL;
  while (ABaseURL <> '') and (ABaseURL[Length(ABaseURL)] = '/') do
    SetLength(ABaseURL, Length(ABaseURL) - 1);

  Result := (AUser <> '') and (APassword <> '');
  if not Result then
    Log('Lipsesc USERNAME/PASSWORD pentru ' + cUltraApiCode +
      ' in TS_API_CONFIG - verificarea cursului a fost sarita.');
end;

function TUltraCurrencyRateThread.FetchUltraUsdRate(const ABaseURL, AUser, APassword: string;
  out ARate: Double): Boolean;
var
  Http: THTTPClient;
  Request: TJSONObject;
  Body: TStringStream;
  Response: IHTTPResponse;
  Json: TJSONValue;
  Token: string;
  Products: TJSONArray;
  Product, Price, CurrencyObj: TJSONObject;
  I, F: Integer;
begin
  Result := False;
  ARate := 0;
  Token := '';

  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 30000;

    // 1. Token
    Request := TJSONObject.Create;
    try
      Request.AddPair('username', AUser);
      Request.AddPair('password', APassword);
      Body := TStringStream.Create(Request.ToJSON, TEncoding.UTF8);
      try
        Response := Http.Post(ABaseURL + '/auth/token', Body, nil,
          [TNetHeader.Create('Content-Type', 'application/json'),
           TNetHeader.Create('Accept', 'application/json')]);
      finally
        Body.Free;
      end;
    finally
      Request.Free;
    end;

    if Response.StatusCode <> 200 then
    begin
      Log(Format('Autentificare Ultra esuata (HTTP %d): %s',
        [Response.StatusCode, Copy(Response.ContentAsString(TEncoding.UTF8), 1, 200)]));
      Exit;
    end;

    Json := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
    try
      if Json is TJSONObject then
        Token := TJSONObject(Json).GetValue<string>('access_token', '');
    finally
      Json.Free;
    end;
    if Token = '' then
    begin
      Log('Ultra nu a intors access_token.');
      Exit;
    end;

    if Terminated then
      Exit;

    // 2. Cateva produse; cursul USD e in pretul lor (currency.code = 840)
    Response := Http.Get(Format('%s/product?limit=%d', [ABaseURL, cProductSampleSize]), nil,
      [TNetHeader.Create('Authorization', 'Bearer ' + Token),
       TNetHeader.Create('Accept', 'application/json')]);

    if Response.StatusCode <> 200 then
    begin
      Log(Format('GET /product a esuat (HTTP %d): %s',
        [Response.StatusCode, Copy(Response.ContentAsString(TEncoding.UTF8), 1, 200)]));
      Exit;
    end;

    Json := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
    try
      Products := nil;
      if Json is TJSONArray then
        Products := TJSONArray(Json)
      else if (Json is TJSONObject) and (TJSONObject(Json).GetValue('data') is TJSONArray) then
        Products := TJSONArray(TJSONObject(Json).GetValue('data'));

      if Assigned(Products) then
        for I := 0 to Products.Count - 1 do
        begin
          if not (Products.Items[I] is TJSONObject) then
            Continue;
          Product := TJSONObject(Products.Items[I]);

          for F := Low(cPriceFields) to High(cPriceFields) do
          begin
            if not (Product.GetValue(cPriceFields[F]) is TJSONObject) then
              Continue;
            Price := TJSONObject(Product.GetValue(cPriceFields[F]));
            if not (Price.GetValue('currency') is TJSONObject) then
              Continue;
            CurrencyObj := TJSONObject(Price.GetValue('currency'));
            if Round(JsonNumber(CurrencyObj, 'code', 0)) <> cUsdCurrencyID then
              Continue;

            ARate := JsonNumber(CurrencyObj, 'rate', 0);
            if ARate > 0 then
              Exit(True);
          end;
        end;
    finally
      Json.Free;
    end;

    Log('Raspunsul Ultra nu contine niciun pret in USD cu curs.');
  finally
    Http.Free;
  end;
end;

procedure TUltraCurrencyRateThread.ApplyRate(AConn: TIBCConnection; const ARate: Double);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  Rate, OldExchange, OldTransfer: Double;
begin
  Rate := RoundTo(ARate, -4);
  if (Rate < cMinSaneRate) or (Rate > cMaxSaneRate) then
  begin
    Log(Format('Curs USD suspect de la Ultra (%.4f) - ignorat.', [Rate], FFmt));
    Exit;
  end;

  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConn;
    Q.Connection := AConn;
    Q.Transaction := Tr;
    Tr.StartTransaction;
    try
      // Utilizatorul logat devine MODIFIED_BY in TS_CURRENCY_HISTORY (triggerul
      // TS_CURRENCY_AU0 citeste contextul; fara el ar scrie 204).
      if FUserID > 0 then
      begin
        Q.SQL.Text := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'', ''UserID'', :UID) FROM RDB$DATABASE';
        Q.ParamByName('UID').AsString := IntToStr(FUserID);
        Q.Open;
        Q.Close;
      end;

      Q.SQL.Text := 'SELECT EXCHANGE_RATE, TRANSFER_RATE FROM TS_CURRENCY WHERE CURRENCYID = :CID';
      Q.ParamByName('CID').AsInteger := cUsdCurrencyID;
      Q.Open;
      if Q.Eof then
      begin
        Q.Close;
        Tr.Rollback;
        Log('TS_CURRENCY nu are randul pentru USD (840).');
        Exit;
      end;
      OldExchange := Q.FieldByName('EXCHANGE_RATE').AsFloat;
      OldTransfer := Q.FieldByName('TRANSFER_RATE').AsFloat;
      Q.Close;

      if (Abs(OldExchange - Rate) < cRateEpsilon) and (Abs(OldTransfer - Rate) < cRateEpsilon) then
      begin
        Tr.Commit;
        Log(Format('Curs USD neschimbat: %.4f (Ultra = TS_CURRENCY).', [Rate], FFmt));
        Exit;
      end;

      if (OldTransfer > 0) and (Abs(Rate - OldTransfer) / OldTransfer > cMaxRelativeChange) then
      begin
        Tr.Commit;
        Log(Format('Curs USD Ultra %.4f difera cu peste %d%% de TRANSFER_RATE %.4f - ' +
          'NU se actualizeaza automat, verificati manual.',
          [Rate, Round(cMaxRelativeChange * 100), OldTransfer], FFmt));
        Exit;
      end;

      Q.SQL.Text := 'UPDATE TS_CURRENCY SET EXCHANGE_RATE = :R1, TRANSFER_RATE = :R2 WHERE CURRENCYID = :CID';
      Q.ParamByName('R1').AsFloat := Rate;
      Q.ParamByName('R2').AsFloat := Rate;
      Q.ParamByName('CID').AsInteger := cUsdCurrencyID;
      Q.ExecSQL;
      Tr.Commit;

      Log(Format('Curs USD actualizat din Ultra: EXCHANGE_RATE %.4f -> %.4f, TRANSFER_RATE %.4f -> %.4f.',
        [OldExchange, Rate, OldTransfer, Rate], FFmt));
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

procedure StartUltraCurrencyRateCheck;
var
  LogFile: string;
begin
  try
    if not Assigned(dmDB) or not dmDB.IBCConnection.Connected then
      Exit;

    LogFile := '';
    if globalPATH_LOCAL_APPDATA <> '' then
      LogFile := IncludeTrailingPathDelimiter(globalPATH_LOCAL_APPDATA) + cLogFileName;

    TUltraCurrencyRateThread.Create(dmDB.IBCConnection, dmDB.CurrentUserID, LogFile);
  except
    // verificarea cursului nu are voie sa blocheze pornirea aplicatiei
  end;
end;

end.

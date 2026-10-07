unit ECCConfigUnit;

{ Configuratia unei case ECC Fiscal Partner, citita din TS_API_CONFIG.

  Un API_CODE = o casa (POS) ECC. Conventia: ECC_<FirmaID> pentru productie,
  ECC_DEMO pentru serverul de test. Parametrii (PARAM_NAME -> PARAM_VALUE):

    BASE_URL      https://demo-04.fiscalpartner.md   (fara /api/sp/v1)
    API_KEY       cheia din BackOffice ECC > API/Keys (se afiseaza mascata)
    POS_ID        identificatorul punctului de vinzare din ECC
    POS_NAME      denumirea punctului de vinzare (optional)
    CASHIER_NAME  casierul implicit; trebuie sa existe in ECC > Casieri
    TAX_20        A      litera cotei TVA 20 % din ECC > TVA Cote
    TAX_8         B
    TAX_0         D
    TAX_NONE      _      fara TVA
    (orice alt TAX_<procent>, de ex. TAX_6 / TAX_10, daca e definit in ECC)

  Terminalul bancar smart (optional, faza 5): daca TERMINAL_POS_ID e completat,
  bonurile cu plata prin card se trimit la terminal (POST /new-order-ext) in loc
  de /receipt; terminalul incaseaza cardul si emite singur bonul fiscal.
    TERMINAL_POS_ID       posId-ul terminalului in ECC
    TERMINAL_POS_NAME     denumirea lui (optional)
    TERMINAL_API_KEY      cheia terminalului, daca difera de API_KEY (optional)
    TERMINAL_TIMEOUT_SEC  cit se asteapta plata clientului (implicit 180)

  Fara niciun TAX_* se foloseste implicit A = 20 %, B = 8 %, D = 0 %, _ = fara TVA.
  Cota C nu are valoare implicita: Postman o da 6 %, fisa ECC Prime Store 10 %. }

interface

uses
  System.SysUtils, IBC, ECCApiClient;

const
  cECCApiCodePrefix = 'ECC';
  cECCDemoApiCode   = 'ECC_DEMO';

type
  TECCTaxCode = record
    Percent: Double;
    Code: string;
  end;

  TECCConfig = record
    ApiCode: string;
    BaseURL: string;
    ApiKey: string;
    PosId: string;
    PosName: string;
    CashierName: string;
    TerminalPosId: string;
    TerminalPosName: string;
    TerminalApiKey: string;
    TerminalTimeoutSec: Integer;
    TaxCodes: TArray<TECCTaxCode>;
    NoVatCode: string;
    // '' = configuratia e completa.
    function Validate: string;
    // Litera ECC pentru cota TVA (procent). Ridica exceptie daca cota nu e mapata.
    function TaxCodeFor(const AVatPercent: Double): string;
    function TaxMapText: string;
    function MaskedApiKey: string;
    function CreateClient: TECCApiClient;
    function HasTerminal: Boolean;
    // clientul pentru terminal: cheia lui daca e data, altfel cea a casei
    function CreateTerminalClient: TECCApiClient;
  end;

// Citeste configuratia; tranzactie proprie, doar citire.
function LoadECCConfig(AConn: TIBCConnection; const AApiCode: string): TECCConfig;
// Codurile API active care incep cu ECC, sortate.
function ListECCApiCodes(AConn: TIBCConnection): TArray<string>;

implementation

uses
  System.Math, MemDS, DBAccess, IBCClasses;

function ParsePercent(const AText: string; out APercent: Double): Boolean;
begin
  Result := TryStrToFloat(StringReplace(Trim(AText), ',', '.', []), APercent, TFormatSettings.Invariant);
end;

function OpenReadQuery(AConn: TIBCConnection; out ATr: TIBCTransaction): TIBCQuery;
begin
  ATr := TIBCTransaction.Create(nil);
  Result := TIBCQuery.Create(nil);
  ATr.DefaultConnection := AConn;
  ATr.IsolationLevel := iblReadOnlyReadCommitted;
  Result.Connection := AConn;
  Result.Transaction := ATr;
end;

function LoadECCConfig(AConn: TIBCConnection; const AApiCode: string): TECCConfig;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  Name, Value: string;
  Tax: TECCTaxCode;
  HasTax: Boolean;
begin
  Result := Default(TECCConfig);
  Result.ApiCode := UpperCase(Trim(AApiCode));
  HasTax := False;

  Q := OpenReadQuery(AConn, Tr);
  try
    Q.SQL.Text := 'SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG ' +
      'WHERE API_CODE = :API_CODE AND FLG_ACTIVE = 1';
    Q.ParamByName('API_CODE').AsString := Result.ApiCode;
    Q.Open;
    while not Q.Eof do
    begin
      Name := UpperCase(Trim(Q.FieldByName('PARAM_NAME').AsString));
      Value := Trim(Q.FieldByName('PARAM_VALUE').AsString);
      if Name = 'BASE_URL' then
        Result.BaseURL := Value
      else if Name = 'API_KEY' then
        Result.ApiKey := Value
      else if Name = 'POS_ID' then
        Result.PosId := Value
      else if Name = 'POS_NAME' then
        Result.PosName := Value
      else if Name = 'CASHIER_NAME' then
        Result.CashierName := Value
      else if Name = 'TERMINAL_POS_ID' then
        Result.TerminalPosId := Value
      else if Name = 'TERMINAL_POS_NAME' then
        Result.TerminalPosName := Value
      else if Name = 'TERMINAL_API_KEY' then
        Result.TerminalApiKey := Value
      else if Name = 'TERMINAL_TIMEOUT_SEC' then
        Result.TerminalTimeoutSec := StrToIntDef(Value, 0)
      else if Name = 'TAX_NONE' then
      begin
        Result.NoVatCode := Value;
        HasTax := True;
      end
      else if Name.StartsWith('TAX_') and (Value <> '') and ParsePercent(Copy(Name, 5, MaxInt), Tax.Percent) then
      begin
        Tax.Code := Value;
        Result.TaxCodes := Result.TaxCodes + [Tax];
        HasTax := True;
      end;
      Q.Next;
    end;
    Q.Close;
    if Tr.Active then
      Tr.Commit;
  finally
    Q.Free;
    Tr.Free;
  end;

  if Result.TerminalTimeoutSec <= 0 then
    Result.TerminalTimeoutSec := 180;

  if not HasTax then
  begin
    Tax.Percent := 20; Tax.Code := 'A';
    Result.TaxCodes := [Tax];
    Tax.Percent := 8; Tax.Code := 'B';
    Result.TaxCodes := Result.TaxCodes + [Tax];
    Tax.Percent := 0; Tax.Code := 'D';
    Result.TaxCodes := Result.TaxCodes + [Tax];
    Result.NoVatCode := '_';
  end;
end;

function ListECCApiCodes(AConn: TIBCConnection): TArray<string>;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Result := nil;
  Q := OpenReadQuery(AConn, Tr);
  try
    Q.SQL.Text := 'SELECT DISTINCT API_CODE FROM TS_API_CONFIG ' +
      'WHERE API_CODE STARTING WITH :P AND FLG_ACTIVE = 1 ORDER BY API_CODE';
    Q.ParamByName('P').AsString := cECCApiCodePrefix;
    Q.Open;
    while not Q.Eof do
    begin
      Result := Result + [Trim(Q.FieldByName('API_CODE').AsString)];
      Q.Next;
    end;
    Q.Close;
    if Tr.Active then
      Tr.Commit;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

{ TECCConfig }

function TECCConfig.Validate: string;
begin
  Result := '';
  if ApiCode = '' then
    Result := 'Nu e ales codul API al casei ECC.'
  else if BaseURL = '' then
    Result := Format('Lipseste BASE_URL pentru %s in Setari > Configurari API.', [ApiCode])
  else if ApiKey = '' then
    Result := Format('Lipseste API_KEY pentru %s in Setari > Configurari API.', [ApiCode])
  else if PosId = '' then
    Result := Format('Lipseste POS_ID pentru %s in Setari > Configurari API.', [ApiCode])
  else if CashierName = '' then
    Result := Format('Lipseste CASHIER_NAME pentru %s in Setari > Configurari API.', [ApiCode]);
end;

function TECCConfig.TaxCodeFor(const AVatPercent: Double): string;
var
  T: TECCTaxCode;
begin
  for T in TaxCodes do
    if SameValue(T.Percent, AVatPercent, 0.01) then
      Exit(T.Code);
  raise EECCApiError.CreateHttp(0, Format('Cota TVA %g %% nu are litera ECC. Adaugati TAX_%g in ' +
    'Setari > Configurari API pentru %s (litera din ECC > TVA Cote).', [AVatPercent, AVatPercent, ApiCode]));
end;

function TECCConfig.TaxMapText: string;
var
  T: TECCTaxCode;
begin
  Result := '';
  for T in TaxCodes do
    Result := Result + Format('%s=%g%%  ', [T.Code, T.Percent]);
  if NoVatCode <> '' then
    Result := Result + NoVatCode + '=fara TVA';
  Result := Trim(Result);
end;

function TECCConfig.MaskedApiKey: string;
begin
  if Length(ApiKey) <= 8 then
    Result := StringOfChar('*', Length(ApiKey))
  else
    Result := Copy(ApiKey, 1, 4) + '...' + Copy(ApiKey, Length(ApiKey) - 3, 4);
end;

function TECCConfig.HasTerminal: Boolean;
begin
  Result := TerminalPosId <> '';
end;

function TECCConfig.CreateTerminalClient: TECCApiClient;
var
  Err: string;
begin
  Err := Validate;
  if Err <> '' then
    raise EECCApiError.CreateHttp(0, Err);
  if TerminalApiKey <> '' then
    Result := TECCApiClient.Create(BaseURL, TerminalApiKey)
  else
    Result := TECCApiClient.Create(BaseURL, ApiKey);
end;

function TECCConfig.CreateClient: TECCApiClient;
var
  Err: string;
begin
  Err := Validate;
  if Err <> '' then
    raise EECCApiError.CreateHttp(0, Err);
  Result := TECCApiClient.Create(BaseURL, ApiKey);
end;

end.

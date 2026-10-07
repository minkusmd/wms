unit ParserJobUnit;

{ WMSParsers - notiunea de "job": o lucrare care se poate rula din fereastra sau din /auto.
  Un job de pret inveleste o sursa de pret (TSupplierPriceSource); alte joburi (imagini,
  caracteristici) isi au logica proprie. Lista joburilor este in ParserRunnerUnit.ParserJobs. }

interface

uses
  System.SysUtils, System.Classes, IBC, SupplierPriceSyncUnit;

type
  TParserRunOptions = record
    Server: string;          // serverul Firebird
    FirmaID: Integer;        // firma reevaluarii (doar joburile de pret, in modul reevaluare)
    UserID: Integer;         // utilizatorul WMS in numele caruia se scrie
    Mode: TSupplierSyncMode; // doar joburile de pret
    DelayMs: Integer;        // <= 0 = pauza implicita a jobului
    LogDir: string;
    Images: Boolean;         // joburile de pricelist API: descarca imaginile (/images:no = nu)
    Reevaluation: Boolean;   // joburile de pricelist API: cele 4 reevaluari (/reevaluare:no = nu)
    ReevaluationTest: Boolean; // /reevaluare:test - reevaluarile se fac si se anuleaza (ROLLBACK)
    Telegram: Boolean;       // rezultatul rularii in Telegram (TELEGRAM_MESSAGES); /telegram:no = nu
    class function Defaults: TParserRunOptions; static;
    // suprascrie cu /server: /firma: /user: /mode: /delay: /log: /images: /reevaluare: /telegram:
    // din linia de comanda
    procedure ReadCommandLine;
  end;

  TParserJobResult = record
    Summary: string;      // o linie pentru jurnal
    SiteSuspect: Boolean; // site-ul nu a raspuns cum trebuie -> cod de iesire 2 in /auto
  end;

  TParserJob = class
  protected
    FConnection: TIBCConnection;
    FOptions: TParserRunOptions;
    FOnLog: TSupplierSyncLogEvent;
    FCancelled: Boolean;
    procedure Log(const AMessage: string); overload;
    procedure Log(const AFormat: string; const AArgs: array of const); overload;
  public
    // numele scurt folosit in /parser: si in numele jurnalului (ex. 'maximum-content')
    class function JobName: string; virtual; abstract;
    // denumirea afisata in lista
    class function DisplayName: string; virtual; abstract;
    // denumirea scurta din mesajele Telegram (implicit DisplayName)
    class function NotifyName: string; virtual;
    // job de preturi: rezultatul lui merge si in canalul PRICELISTS ("Online :: Fantastic");
    // erorile oricarui job merg in ERRORS
    class function IsPriceJob: Boolean; virtual;
    constructor Create(AConnection: TIBCConnection; const AOptions: TParserRunOptions;
      const AOnLog: TSupplierSyncLogEvent); virtual;
    function Run: TParserJobResult; virtual; abstract;
    procedure Cancel; virtual;
    property Cancelled: Boolean read FCancelled;
  end;

  TParserJobClass = class of TParserJob;

  // Job de pret: descendentii spun doar care e sursa de pret.
  TSupplierPriceJob = class(TParserJob)
  private
    FSync: TSupplierPriceSync;
  protected
    class function SourceClass: TSupplierPriceSourceClass; virtual; abstract;
  public
    class function JobName: string; override;
    class function DisplayName: string; override;
    class function NotifyName: string; override;
    class function IsPriceJob: Boolean; override;
    function Run: TParserJobResult; override;
    procedure Cancel; override;
  end;

function CommandLineValue(const AName, ADefault: string): string;

implementation

uses
  SWNConst;

function CommandLineValue(const AName, ADefault: string): string;
var
  I: Integer;
  Prefix, S: string;
begin
  Result := ADefault;
  Prefix := '/' + AName + ':';
  for I := 1 to ParamCount do
  begin
    S := ParamStr(I);
    if SameText(Copy(S, 1, Length(Prefix)), Prefix) then
      Exit(Copy(S, Length(Prefix) + 1, MaxInt));
  end;
end;

{ TParserRunOptions }

class function TParserRunOptions.Defaults: TParserRunOptions;
begin
  Result.Server := cDATABASE_ConnectionServerDefault;
  Result.FirmaID := 307225;
  Result.UserID := 204;
  Result.Mode := hsmDirectUpdate;
  Result.DelayMs := 0;
  Result.LogDir := ExtractFilePath(ParamStr(0)) + 'logs';
  Result.Images := True;
  Result.Reevaluation := True;
  Result.ReevaluationTest := False;
  Result.Telegram := True;
end;

function IsNo(const AValue: string): Boolean;
begin
  Result := SameText(AValue, 'no') or SameText(AValue, 'nu') or (AValue = '0') or SameText(AValue, 'false');
end;

procedure TParserRunOptions.ReadCommandLine;
begin
  Server := CommandLineValue('server', Server);
  FirmaID := StrToIntDef(CommandLineValue('firma', ''), FirmaID);
  UserID := StrToIntDef(CommandLineValue('user', ''), UserID);
  if SameText(CommandLineValue('mode', ''), 'reeval') then
    Mode := hsmReevaluation
  else if SameText(CommandLineValue('mode', ''), 'direct') then
    Mode := hsmDirectUpdate;
  DelayMs := StrToIntDef(CommandLineValue('delay', ''), DelayMs);
  LogDir := CommandLineValue('log', LogDir);
  if IsNo(CommandLineValue('images', '')) then
    Images := False;
  if IsNo(CommandLineValue('reevaluare', '')) then
    Reevaluation := False;
  if SameText(CommandLineValue('reevaluare', ''), 'test') then
    ReevaluationTest := True;
  if IsNo(CommandLineValue('telegram', '')) then
    Telegram := False;
end;

{ TParserJob }

constructor TParserJob.Create(AConnection: TIBCConnection; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent);
begin
  inherited Create;
  FConnection := AConnection;
  FOptions := AOptions;
  FOnLog := AOnLog;
end;

class function TParserJob.NotifyName: string;
begin
  Result := DisplayName;
end;

class function TParserJob.IsPriceJob: Boolean;
begin
  Result := False;
end;

procedure TParserJob.Cancel;
begin
  FCancelled := True;
end;

procedure TParserJob.Log(const AMessage: string);
begin
  if Assigned(FOnLog) then
    FOnLog(AMessage);
end;

procedure TParserJob.Log(const AFormat: string; const AArgs: array of const);
begin
  Log(Format(AFormat, AArgs));
end;

{ TSupplierPriceJob }

class function TSupplierPriceJob.JobName: string;
begin
  Result := SourceClass.ParserName;
end;

class function TSupplierPriceJob.DisplayName: string;
begin
  Result := Format('Preturi %s  -  furnizor %d', [SourceClass.DisplayName, SourceClass.SupplierID]);
end;

class function TSupplierPriceJob.NotifyName: string;
begin
  Result := Format('Preturi %s (%d)', [SourceClass.DisplayName, SourceClass.SupplierID]);
end;

class function TSupplierPriceJob.IsPriceJob: Boolean;
begin
  Result := True;
end;

procedure TSupplierPriceJob.Cancel;
begin
  inherited;
  if Assigned(FSync) then
    FSync.Cancel;
end;

function TSupplierPriceJob.Run: TParserJobResult;
var
  Stats: TSupplierSyncStats;
begin
  Result := Default(TParserJobResult);
  if FOptions.Mode = hsmReevaluation then
    Log('Mod: reevaluare noua.')
  else
    Log('Mod: UPDATE direct pe PRICE3.');

  FSync := TSupplierPriceSync.Create(FConnection, SourceClass, FOptions.FirmaID, FOptions.UserID);
  try
    FSync.Mode := FOptions.Mode;
    if FOptions.DelayMs > 0 then
      FSync.RequestDelayMs := FOptions.DelayMs;
    FSync.OnLog := FOnLog;
    Stats := FSync.Run;
  finally
    FreeAndNil(FSync);
  end;

  Result.Summary := Format('active %d, gasite %d, negasite %d, erori site %d, schimbate %d, respinse %d',
    [Stats.Active, Stats.Found, Stats.NotFound, Stats.ScrapeErrors, Stats.Changed, Stats.Rejected]);
  Result.SiteSuspect := (Stats.Active > 0) and (Stats.Found * 2 < Stats.Active);
end;

end.

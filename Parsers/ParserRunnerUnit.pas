unit ParserRunnerUnit;

{ WMSParsers - lista joburilor, conectarea la baza, jurnalul in fisier si rularea unui job.
  Folosit la fel de fereastra principala si de modul automat (/auto, din Task Scheduler).

  Un job nou:
    - de pret: un descendent al TSupplierPriceSource (sursa) + un descendent de trei rinduri al
      TSupplierPriceJob mai jos + un rind in ParserJobs;
    - de alt fel (imagini, caracteristici...): un descendent al TParserJob + un rind in ParserJobs. }

interface

uses
  System.SysUtils, System.Classes, IBC, SupplierPriceSyncUnit, ParserJobUnit;

type
  // Jurnal zilnic per job: <LogDir>\<job>_YYYYMMDD.log (UTF-8, se adauga la sfirsit)
  TParserFileLog = class
  private
    FFile: TextFile;
    FOpened: Boolean;
  public
    constructor Create(const ALogDir, AJobName: string);
    destructor Destroy; override;
    procedure Write(const AMessage: string);
  end;

  THiTechPriceJob = class(TSupplierPriceJob)
  protected
    class function SourceClass: TSupplierPriceSourceClass; override;
  end;

  TMaximumPriceJob = class(TSupplierPriceJob)
  protected
    class function SourceClass: TSupplierPriceSourceClass; override;
  end;

function ParserJobs: TArray<TParserJobClass>;
function FindParserJob(const AJobName: string): TParserJobClass;

// Conexiune cu aceleasi setari ca dmDB.IBCConnection din WMS. Apelantul o elibereaza.
function CreateParserConnection(const AServer: string): TIBCConnection;

// Ruleaza un job si scrie jurnalul lui. AOnLog primeste aceleasi linii (pentru ecran).
// AJobCreated, daca e dat, primeste jobul imediat dupa creare si nil la sfirsit - fereastra il
// foloseste pentru butonul Stop. Exceptiile sint scrise in jurnal si ridicate mai departe.
function RunParserJob(AConnection: TIBCConnection; AJobClass: TParserJobClass;
  const AOptions: TParserRunOptions; const AOnLog: TSupplierSyncLogEvent;
  const AJobCreated: TProc<TParserJob> = nil): TParserJobResult;

implementation

uses
  SWNConst, HiTechPriceSourceUnit, MaximumPriceSourceUnit, MaximumContentUnit;

{ joburile de pret }

class function THiTechPriceJob.SourceClass: TSupplierPriceSourceClass;
begin
  Result := THiTechPriceSource;
end;

class function TMaximumPriceJob.SourceClass: TSupplierPriceSourceClass;
begin
  Result := TMaximumPriceSource;
end;

function ParserJobs: TArray<TParserJobClass>;
begin
  Result := [THiTechPriceJob, TMaximumPriceJob, TMaximumContentJob];
end;

function FindParserJob(const AJobName: string): TParserJobClass;
var
  C: TParserJobClass;
begin
  for C in ParserJobs do
    if SameText(C.JobName, AJobName) then
      Exit(C);
  Result := nil;
end;

{ TParserFileLog }

constructor TParserFileLog.Create(const ALogDir, AJobName: string);
var
  FileName: string;
begin
  inherited Create;
  ForceDirectories(ALogDir);
  FileName := IncludeTrailingPathDelimiter(ALogDir) + AJobName + '_' + FormatDateTime('yyyymmdd', Date) + '.log';
  AssignFile(FFile, FileName, CP_UTF8);
  if FileExists(FileName) then
    Append(FFile)
  else
    Rewrite(FFile);
  FOpened := True;
end;

destructor TParserFileLog.Destroy;
begin
  if FOpened then
    CloseFile(FFile);
  inherited;
end;

procedure TParserFileLog.Write(const AMessage: string);
begin
  if not FOpened then
    Exit;
  Writeln(FFile, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '  ' + AMessage);
  Flush(FFile);
end;

function CreateParserConnection(const AServer: string): TIBCConnection;
begin
  Result := TIBCConnection.Create(nil);
  try
    // codurile furnizorilor pot contine chirilice (Hi-Tech: "T-0000..." cu T chirilic)
    Result.Options.Charset := 'UTF8';
    Result.Options.UseUnicode := True;
    Result.Options.EnableMemos := True;
    Result.ClientLibrary := 'fbclient.dll';
    Result.LoginPrompt := False;
    Result.Database := Format('%s/%d:%s', [AServer, cDATABASE_ConnectionPortDefault, cDATABASE_DBName]);
    Result.Username := cDATABASE_UserLogin_UserName;
    Result.Password := cDATABASE_UserLogin_UserPassword;
    Result.Connected := True;
  except
    Result.Free;
    raise;
  end;
end;

function RunParserJob(AConnection: TIBCConnection; AJobClass: TParserJobClass;
  const AOptions: TParserRunOptions; const AOnLog: TSupplierSyncLogEvent;
  const AJobCreated: TProc<TParserJob>): TParserJobResult;
var
  Job: TParserJob;
  FileLog: TParserFileLog;
  JobResult: TParserJobResult;
  LogBoth: TSupplierSyncLogEvent;
  OnLogCopy: TSupplierSyncLogEvent;
begin
  JobResult := Default(TParserJobResult);
  OnLogCopy := AOnLog;
  FileLog := TParserFileLog.Create(AOptions.LogDir, AJobClass.JobName);
  try
    LogBoth :=
      procedure(const AMessage: string)
      begin
        FileLog.Write(AMessage);
        if Assigned(OnLogCopy) then
          OnLogCopy(AMessage);
      end;

    LogBoth(Format('Start %s. Server %s.', [AJobClass.DisplayName, AOptions.Server]));
    Job := AJobClass.Create(AConnection, AOptions, LogBoth);
    try
      if Assigned(AJobCreated) then
        AJobCreated(Job);
      try
        JobResult := Job.Run;
        LogBoth(Format('Sfirsit %s: %s.', [AJobClass.JobName, JobResult.Summary]));
      except
        on E: Exception do
        begin
          LogBoth('EROARE: ' + E.ClassName + ': ' + E.Message);
          raise;
        end;
      end;
    finally
      if Assigned(AJobCreated) then
        AJobCreated(nil);
      Job.Free;
    end;
  finally
    FileLog.Free;
  end;
  Result := JobResult;
end;

end.

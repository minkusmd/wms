unit ParserRunnerUnit;

{ WMSParsers - lista joburilor, conectarea la baza, jurnalul in fisier si rularea joburilor.
  Folosit la fel de fereastra principala si de modul automat (/auto, din Task Scheduler).
  Joburile alese ruleaza in paralel (RunParserJobsParallel): fiecare in firul lui, cu conexiunea lui.

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

  TParserJobOutcome = record
    JobClass: TParserJobClass;
    JobResult: TParserJobResult;
    Error: string;            // '' = jobul s-a terminat fara exceptie
    Cancelled: Boolean;       // oprit cu Stop din fereastra
  end;

// Textele Telegram (HTML) ale unei rulari: APriceText - joburile de preturi, pentru canalul
// PRICELISTS ("Online :: Fantastic"); AErrorText - erorile si site-urile suspecte, pentru ERRORS.
// '' = nimic de trimis.
procedure BuildParserTelegramTexts(const AOutcomes: TArray<TParserJobOutcome>; const AOptions: TParserRunOptions;
  out APriceText, AErrorText: string);
// Pune textele in coada TELEGRAM_MESSAGES (SP_TELEGRAM_SEND, trimise de SWNService), pe o conexiune
// noua; erorile Telegram ajung doar in jurnalul telegram_YYYYMMDD.log si in AOnLog, nu opresc nimic.
procedure NotifyParserRun(const AOutcomes: TArray<TParserJobOutcome>; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent);

function ParserJobs: TArray<TParserJobClass>;
function FindParserJob(const AJobName: string): TParserJobClass;
// "all", un nume de job, sau grupul "pricelists" (toate importurile de pricelist prin API),
// separate prin virgula; numele necunoscute ajung in AUnknown
function ExpandParserNames(const AValue: string; out AUnknown: string): TArray<TParserJobClass>;

// Conexiune cu aceleasi setari ca dmDB.IBCConnection din WMS. Apelantul o elibereaza.
function CreateParserConnection(const AServer: string): TIBCConnection;

// Ruleaza un job si scrie jurnalul lui. AOnLog primeste aceleasi linii (pentru ecran).
// AJobCreated, daca e dat, primeste jobul imediat dupa creare si nil la sfirsit - fereastra il
// foloseste pentru butonul Stop. Exceptiile sint scrise in jurnal si ridicate mai departe.
function RunParserJob(AConnection: TIBCConnection; AJobClass: TParserJobClass;
  const AOptions: TParserRunOptions; const AOnLog: TSupplierSyncLogEvent;
  const AJobCreated: TProc<TParserJob> = nil): TParserJobResult;

// Ruleaza joburile in paralel: fiecare in firul lui, cu conexiunea lui (CreateParserConnection) si
// COM initializat (conversia imaginilor). AOnLog, AJobStarted si AJobFinished sint apelate DIN FIRELE
// JOBURILOR (liniile au prefixul "[job] ") - trebuie sa fie thread-safe; AJobFinished vine inainte ca
// jobul sa fie eliberat. Firul apelant asteapta si apeleaza AOnIdle (ex. ProcessMessages in fereastra).
// Intoarce rezultatul fiecarui job, in ordinea data. La sfirsit, daca AOptions.Telegram, rezultatul
// pleaca in Telegram (NotifyParserRun).
function RunParserJobsParallel(const AClasses: TArray<TParserJobClass>; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent; const AJobStarted, AJobFinished: TProc<TParserJob>;
  const AOnIdle: TProc): TArray<TParserJobOutcome>;

implementation

uses
  Winapi.ActiveX, Data.DB, IBCClasses, SWNConst, HiTechPriceSourceUnit, MaximumPriceSourceUnit, MaximumContentUnit,
  PriceListApiJobsUnit;

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
  Result := [THiTechPriceJob, TMaximumPriceJob, TMaximumContentJob,
    TAccentPriceListJob, TDMLinkPriceListJob, TOlisGrupPriceListJob, TNexPriceListJob, TTriomacPriceListJob];
end;

function ExpandParserNames(const AValue: string; out AUnknown: string): TArray<TParserJobClass>;
var
  Names: TStringList;
  I: Integer;
  C: TParserJobClass;
  Name: string;

  procedure Add(AClass: TParserJobClass);
  var
    X: TParserJobClass;
  begin
    for X in Result do
      if X = AClass then
        Exit;
    Result := Result + [AClass];
  end;

begin
  AUnknown := '';
  Result := nil;
  Names := TStringList.Create;
  try
    Names.CommaText := AValue;
    for I := 0 to Names.Count - 1 do
    begin
      Name := Trim(Names[I]);
      if Name = '' then
        Continue;
      if SameText(Name, 'all') then
      begin
        for C in ParserJobs do
          Add(C);
      end
      else if SameText(Name, 'pricelists') then
      begin
        for C in ParserJobs do
          if C.InheritsFrom(TPriceListApiJob) then
            Add(C);
      end
      else
      begin
        C := FindParserJob(Name);
        if C = nil then
          AUnknown := Trim(AUnknown + ' ' + Name)
        else
          Add(C);
      end;
    end;
  finally
    Names.Free;
  end;
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


type
  TParserJobThread = class(TThread)
  private
    FJobClass: TParserJobClass;
    FOptions: TParserRunOptions;
    FOnLog: TSupplierSyncLogEvent;
    FJobStarted: TProc<TParserJob>;
    FJobFinished: TProc<TParserJob>;
  protected
    procedure Execute; override;
  public
    Outcome: TParserJobOutcome;
    constructor Create(AJobClass: TParserJobClass; const AOptions: TParserRunOptions;
      const AOnLog: TSupplierSyncLogEvent; const AJobStarted, AJobFinished: TProc<TParserJob>);
  end;

constructor TParserJobThread.Create(AJobClass: TParserJobClass; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent; const AJobStarted, AJobFinished: TProc<TParserJob>);
begin
  FJobClass := AJobClass;
  FOptions := AOptions;
  FOnLog := AOnLog;
  FJobStarted := AJobStarted;
  FJobFinished := AJobFinished;
  Outcome.JobClass := AJobClass;
  inherited Create(False);
  FreeOnTerminate := False;
end;

procedure TParserJobThread.Execute;
var
  Connection: TIBCConnection;
  Prefix: string;
  OnLog: TSupplierSyncLogEvent;
  JobStarted, JobFinished: TProc<TParserJob>;
  Current: TParserJob;
  Started: Boolean;
begin
  Prefix := '[' + FJobClass.JobName + '] ';
  OnLog := FOnLog;
  JobStarted := FJobStarted;
  JobFinished := FJobFinished;
  Current := nil;
  Started := False;
  CoInitialize(nil);
  try
    try
      Connection := CreateParserConnection(FOptions.Server);
      try
        Started := True;
        Outcome.JobResult := RunParserJob(Connection, FJobClass, FOptions,
          procedure(const AMessage: string)
          begin
            if Assigned(OnLog) then
              OnLog(Prefix + AMessage);
          end,
          // RunParserJob anunta jobul creat, apoi nil inainte sa-l elibereze
          procedure(AJob: TParserJob)
          begin
            if AJob <> nil then
            begin
              Current := AJob;
              if Assigned(JobStarted) then
                JobStarted(AJob);
            end
            else
            begin
              if Current <> nil then
                Outcome.Cancelled := Current.Cancelled;
              if Assigned(JobFinished) and (Current <> nil) then
                JobFinished(Current);
              Current := nil;
            end;
          end);
      finally
        Connection.Free;
      end;
    except
      on E: Exception do
      begin
        Outcome.Error := E.Message;
        // RunParserJob a scris deja eroarea jobului; o eroare de conectare nu e scrisa
        if Assigned(OnLog) and not Started then
          OnLog(Prefix + 'EROARE la conectarea la baza: ' + E.Message);
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

function RunParserJobsParallel(const AClasses: TArray<TParserJobClass>; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent; const AJobStarted, AJobFinished: TProc<TParserJob>;
  const AOnIdle: TProc): TArray<TParserJobOutcome>;
var
  Threads: TArray<TParserJobThread>;
  I: Integer;
begin
  SetLength(Threads, Length(AClasses));
  SetLength(Result, Length(AClasses));
  try
    for I := 0 to High(AClasses) do
      Threads[I] := TParserJobThread.Create(AClasses[I], AOptions, AOnLog, AJobStarted, AJobFinished);
    for I := 0 to High(Threads) do
    begin
      while not Threads[I].Finished do
      begin
        if Assigned(AOnIdle) then
          AOnIdle();
        Sleep(20);
      end;
      Result[I] := Threads[I].Outcome;
    end;
    if AOptions.Telegram then
      NotifyParserRun(Result, AOptions, AOnLog);
  finally
    for I := 0 to High(Threads) do
      if Assigned(Threads[I]) then
      begin
        Threads[I].WaitFor;
        Threads[I].Free;
      end;
  end;
end;

{ Telegram }

const
  // TELEGRAM_MESSAGES.SOURCE_TABLE pentru mesajele WMSParsers
  cTelegramSourceParsers = -30;
  cTelegramMaxText = 4000;
  cIconOk = #$2705;
  cIconError = #$274C;
  cIconWarning = #$26A0#$FE0F;
  cIconStop = #$23F9;
  cIconImport = #$D83D#$DCE5;

function HtmlEscape(const AText: string): string;
begin
  Result := StringReplace(AText, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
end;

function RunDescription(const AOptions: TParserRunOptions): string;
begin
  if FindCmdLineSwitch('auto', ['/', '-'], True) then
    Result := 'rulare automata'
  else
    Result := 'rulare manuala';
  Result := Result + ', ' + FormatDateTime('dd.mm.yyyy hh:nn', Now) + ', ' + GetEnvironmentVariable('COMPUTERNAME');
  if AOptions.ReevaluationTest then
    Result := Result + ' - TEST, reevaluarile anulate';
end;

procedure BuildParserTelegramTexts(const AOutcomes: TArray<TParserJobOutcome>; const AOptions: TParserRunOptions;
  out APriceText, AErrorText: string);
var
  O: TParserJobOutcome;
  PriceLines, ErrorLines: string;
  Name: string;
begin
  PriceLines := '';
  ErrorLines := '';
  for O in AOutcomes do
  begin
    Name := '<b>' + HtmlEscape(O.JobClass.NotifyName) + '</b>';
    if O.Error <> '' then
      ErrorLines := ErrorLines + sLineBreak + sLineBreak + cIconError + ' ' + Name + sLineBreak +
        '<code>' + HtmlEscape(Copy(O.Error, 1, 600)) + '</code>'
    else if O.JobResult.SiteSuspect and not O.Cancelled then
      ErrorLines := ErrorLines + sLineBreak + sLineBreak + cIconWarning + ' ' + Name +
        ': site-ul nu a raspuns cum trebuie (sub jumatate din articole gasite)' + sLineBreak +
        HtmlEscape(O.JobResult.Summary);

    if not O.JobClass.IsPriceJob then
      Continue;
    if O.Error <> '' then
      PriceLines := PriceLines + sLineBreak + cIconError + ' ' + Name + ': eroare, vezi grupul de erori'
    else if O.Cancelled then
      PriceLines := PriceLines + sLineBreak + cIconStop + ' ' + Name + ': oprit manual'
    else if O.JobResult.SiteSuspect then
      PriceLines := PriceLines + sLineBreak + cIconWarning + ' ' + Name + ': site suspect - ' +
        HtmlEscape(O.JobResult.Summary)
    else
      PriceLines := PriceLines + sLineBreak + cIconOk + ' ' + Name + ': ' + HtmlEscape(O.JobResult.Summary);
  end;

  APriceText := '';
  if PriceLines <> '' then
    APriceText := Copy(cIconImport + ' <b>Preturi importate</b>' + sLineBreak +
      '<i>' + HtmlEscape(RunDescription(AOptions)) + '</i>' + sLineBreak + PriceLines, 1, cTelegramMaxText);

  AErrorText := '';
  if ErrorLines <> '' then
    AErrorText := Copy(cIconWarning + ' <b>WMSParsers: erori</b>' + sLineBreak +
      '<i>' + HtmlEscape(RunDescription(AOptions)) + '</i>' + ErrorLines + sLineBreak + sLineBreak +
      'Jurnal: <code>' + HtmlEscape(AOptions.LogDir) + '</code>', 1, cTelegramMaxText);
end;

procedure NotifyParserRun(const AOutcomes: TArray<TParserJobOutcome>; const AOptions: TParserRunOptions;
  const AOnLog: TSupplierSyncLogEvent);
var
  PriceText, ErrorText: string;
  FileLog: TParserFileLog;
  Connection: TIBCConnection;
  Trans: TIBCTransaction;
  Q: TIBCQuery;

  procedure LogLine(const AMessage: string);
  begin
    FileLog.Write(AMessage);
    if Assigned(AOnLog) then
      AOnLog('[telegram] ' + AMessage);
  end;

  procedure Send(const AChannel, AText: string; APriority: Integer);
  begin
    if AText = '' then
      Exit;
    try
      Trans.StartTransaction;
      Q.ParamByName('CH').AsString := AChannel;
      Q.ParamByName('TXT').AsString := AText;
      Q.ParamByName('PR').AsInteger := APriority;
      Q.Execute;
      Trans.Commit;
      LogLine('In coada Telegram, canalul ' + AChannel + '.');
    except
      on E: Exception do
      begin
        if Trans.Active then
          Trans.Rollback;
        LogLine('Mesajul pentru ' + AChannel + ' nu a intrat in coada: ' + E.Message);
      end;
    end;
  end;

begin
  BuildParserTelegramTexts(AOutcomes, AOptions, PriceText, ErrorText);
  if (PriceText = '') and (ErrorText = '') then
    Exit;

  FileLog := TParserFileLog.Create(AOptions.LogDir, 'telegram');
  try
    try
      Connection := CreateParserConnection(AOptions.Server);
    except
      on E: Exception do
      begin
        LogLine('Fara Telegram - nu ma pot conecta la baza: ' + E.Message);
        Exit;
      end;
    end;
    Trans := TIBCTransaction.Create(nil);
    Q := TIBCQuery.Create(nil);
    try
      Trans.DefaultConnection := Connection;
      Q.Connection := Connection;
      Q.Transaction := Trans;
      Q.SQL.Text := 'EXECUTE PROCEDURE SP_TELEGRAM_SEND(:CH, :TXT, ''HTML'', ' +
        IntToStr(cTelegramSourceParsers) + ', NULL, :PR)';
      Send('ERRORS', ErrorText, 5);
      Send('PRICELISTS', PriceText, 0);
    finally
      Q.Free;
      Trans.Free;
      Connection.Free;
    end;
  finally
    FileLog.Free;
  end;
end;

end.

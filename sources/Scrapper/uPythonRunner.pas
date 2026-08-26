unit uPythonRunner;

{
  uPythonRunner.pas — Python4Delphi (P4D) version
  =================================================
  Rulează orice script Python in-process, fără subprocess, fără pipe-uri.
  Output capturat direct prin OnSendUniData (Unicode corect, zero probleme encoding).

  Instalare P4D:
    GetIt Package Manager → caută "Python4Delphi"
    sau: https://github.com/pyscripter/python4delphi

  Utilizare:
    FRunner := TPythonRunner.Create;
    FRunner.OnOutput   := procedure(const S: string) begin Memo1.Lines.Add(S) end;
    FRunner.OnFinished := procedure(Code: Integer)   begin ShowMessage('Gata!') end;
    FRunner.Run('C:\scrapers\scraping_uno_by_code.py');
}

interface

uses
  System.Classes, System.SysUtils,
  PythonEngine;

type
  TOutputProc      = reference to procedure(const Line: string);
  TFinishedProc    = reference to procedure(ExitCode: Integer);
  TScriptErrorProc = reference to procedure(const Msg: string);

  // ── Thread intern GIL-safe ────────────────────────────────────────────────
  TScriptThread = class(TPythonThread)
  private
    FScriptPath : string;
    FOnError    : TScriptErrorProc;
  public
    procedure ExecuteWithPython; override;
    property ScriptPath : string           read FScriptPath write FScriptPath;
    property OnError    : TScriptErrorProc read FOnError    write FOnError;
  end;

  TPythonRunner = class
  private
    FEngine     : TPythonEngine;
    FIO         : TPythonInputOutput;
    FThread     : TScriptThread;
    FOnOutput   : TOutputProc;
    FOnFinished : TFinishedProc;
    FExitCode   : Integer;

    // Helper — evită W1058 la fiecare apel ExecString
    procedure Exec(const Code: string);

    procedure OnSendUniData(Sender: TObject; const Data: UnicodeString);
    procedure OnThreadFinished(Sender: TObject);
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Run(const ScriptPath: string);
    procedure Cancel;
    function  IsRunning: Boolean;

    // Setează Python DLL explicit — necesar pentru venv.
    // Dacă Python e în PATH, nu e necesar.
    // Exemplu: 'C:\proj\.venv\Scripts\python312.dll'
    procedure SetPythonDLL(const DLLPath: string);

    // Adaugă un director la sys.path al interpretorului
    procedure AddToSysPath(const Dir: string);

    property ExitCode   : Integer       read FExitCode;
    property OnOutput   : TOutputProc  read FOnOutput   write FOnOutput;
    property OnFinished : TFinishedProc read FOnFinished write FOnFinished;
  end;

implementation

uses
  System.Win.Registry;
{ TScriptThread }

procedure TScriptThread.ExecuteWithPython;
begin
  try
    GetPythonEngine.ExecFile(FScriptPath);
  except
    on E: EPythonError do
    begin
      if Assigned(FOnError) then
        FOnError(E.Message);
    end;
    on E: Exception do
    begin
      if Assigned(FOnError) then
        FOnError('Eroare Delphi: ' + E.Message);
    end;
  end;
end;

{ TPythonRunner }

constructor TPythonRunner.Create;
begin
  inherited Create;
  FExitCode := 0;

  // ── TPythonEngine ─────────────────────────────────────────────────────────
  FEngine                     := TPythonEngine.Create(nil);
  FEngine.AutoLoad            := True;
  FEngine.UseLastKnownVersion := True;

  // ── TPythonInputOutput ────────────────────────────────────────────────────
  FIO               := TPythonInputOutput.Create(nil);
  FIO.UnicodeIO     := True;   // → OnSendUniData în loc de OnSendData
  FIO.RawOutput     := True;   // textul ajunge exact cum îl scrie Python
  FIO.OnSendUniData := OnSendUniData;

  // Legătura se face pe Engine (nu pe IO)
  FEngine.IO := FIO;

  // Pornim engine-ul
  try
    FEngine.LoadDll;
  except
    on E: Exception do
      raise Exception.Create(
        'Python4Delphi: nu am putut încărca Python.' + sLineBreak +
        E.Message + sLineBreak +
        'Dacă folosești venv, apelează SetPythonDLL înainte de Run.');
  end;
end;

destructor TPythonRunner.Destroy;
begin
  Cancel;
  if Assigned(FThread) then
  begin
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;
  FEngine.IO := nil;
  FreeAndNil(FIO);
  FreeAndNil(FEngine);
  inherited;
end;

function TPythonRunner.IsRunning: Boolean;
begin
  Result := Assigned(FThread) and not FThread.Finished;
end;

// ── Exec ──────────────────────────────────────────────────────────────────────
// Wrapper peste ExecString care convertește corect string → UTF-8 AnsiString.
// Evită W1058 "Implicit string cast with potential data loss" la fiecare apel.
procedure TPythonRunner.Exec(const Code: string);
begin
  FEngine.ExecString(UTF8Encode(Code));
end;

procedure TPythonRunner.SetPythonDLL(const DLLPath: string);
begin
  if IsRunning then
    raise Exception.Create('Nu poți schimba DLL-ul în timp ce rulează un script.');
  FEngine.DllPath             := ExtractFilePath(DLLPath);
  FEngine.DllName             := ExtractFileName(DLLPath);
  FEngine.AutoLoad            := False;
  FEngine.UseLastKnownVersion := False;
end;

procedure TPythonRunner.AddToSysPath(const Dir: string);
begin
  Exec(Format(
    'import sys; _p=r"%s"; (sys.path.insert(0,_p) if _p not in sys.path else None)',
    [ExcludeTrailingPathDelimiter(Dir)]   // ← d:\scrapers\ → d:\scrapers
  ));
end;

// ── OnSendUniData ─────────────────────────────────────────────────────────────
// Apelat de P4D când Python scrie pe stdout sau stderr (UnicodeIO = True).
// Data = UnicodeString — conține textul Unicode corect (ț, ș, î, â, ă etc.)
// Rulează pe thread-ul scriptului → sincronizăm pe main thread pentru UI.
procedure TPythonRunner.OnSendUniData(Sender: TObject; const Data: UnicodeString);
var
  Lines : TStringList;
  i     : Integer;
  Line  : string;
begin
  if not Assigned(FOnOutput) then Exit;

  Lines := TStringList.Create;
  try
    Lines.Text := Data;
    for i := 0 to Lines.Count - 1 do
    begin
      Line := Lines[i];
      TThread.Queue(nil, procedure begin FOnOutput(Line) end);
    end;
  finally
    Lines.Free;
  end;
end;

// ── OnThreadFinished ──────────────────────────────────────────────────────────
procedure TPythonRunner.OnThreadFinished(Sender: TObject);
var
  ExCode: Integer;
begin
  ExCode := FExitCode;
  TThread.Queue(nil, procedure
  begin
    if Assigned(FOnFinished) then
      FOnFinished(ExCode);
    FreeAndNil(FThread);
  end);
end;

// ── Run ───────────────────────────────────────────────────────────────────────
procedure TPythonRunner.Run(const ScriptPath: string);
var
  ScriptDir: string;
begin
  if IsRunning then
    raise Exception.Create('Un script Python rulează deja!');

  FreeAndNil(FThread);
  FExitCode := 0;

  // Adăugăm directorul scriptului la sys.path
  ScriptDir := ExtractFilePath(ExpandFileName(ScriptPath));
  if ScriptDir <> '' then
        AddToSysPath(ExcludeTrailingPathDelimiter(ScriptDir));  // ← fix

  FThread                 := TScriptThread.Create(True);
  FThread.FreeOnTerminate := False;
  FThread.ScriptPath      := ScriptPath;
  FThread.OnTerminate     := OnThreadFinished;
  FThread.OnError         := procedure(const Msg: string)
  begin
    FExitCode := 1;
    if Assigned(FOnOutput) then
      TThread.Queue(nil, procedure
      begin
        FOnOutput('*** EROARE Python: ' + Msg);
      end);
  end;

  FThread.Start;
end;

// ── Cancel ────────────────────────────────────────────────────────────────────
// Injectează KeyboardInterrupt în Python.
// Scriptul se oprește la prima instrucțiune Python executată după aceasta.
procedure TPythonRunner.Cancel;
begin
  if not IsRunning then Exit;
  try
    FEngine.PyErr_SetInterrupt;
  except end;
end;

end.

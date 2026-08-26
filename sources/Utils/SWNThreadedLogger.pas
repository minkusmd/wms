unit SWNThreadedLogger;

interface

uses
  System.SysUtils, System.Classes, System.SyncObjs, System.Generics.Collections;

type
  TLogLevel = (llInfo, llWarning, llError);

  TThreadedLogger = class(TThread)
  private
    FLogFilePath: string;
    FLogQueue: TThreadedQueue<string>;
    procedure WriteLog(const AMessage: string);
  protected
    procedure Execute; override;
  public
    constructor Create(const ALogFilePath: string);
    destructor Destroy; override;
    procedure Log(const ALevel: TLogLevel; const AMessage: string);
    procedure LogInfo(const AMessage: string);
    procedure LogWarning(const AMessage: string);
    procedure LogError(const AMessage: string);
  end;

implementation

constructor TThreadedLogger.Create(const ALogFilePath: string);
begin
  inherited Create(True); // Create the thread in a suspended state
  FLogFilePath := ALogFilePath;
  FLogQueue := TThreadedQueue<string>.Create(100, 1000, 100); // Create a threaded queue
  FreeOnTerminate := False; // Ensure the thread is not automatically freed
  Start; // Start the thread
end;

destructor TThreadedLogger.Destroy;
begin
  Terminate; // Signal the thread to terminate
  FLogQueue.DoShutDown; // Shut down the queue
  WaitFor; // Wait for the thread to finish
  FLogQueue.Free; // Free the queue
  inherited;
end;

procedure TThreadedLogger.Execute;
var
  LogMessage: string;
begin
  while not Terminated do
  begin
    // Dequeue log messages and write them to the file
    if FLogQueue.PopItem(LogMessage) = wrSignaled then
      WriteLog(LogMessage);
  end;
end;

procedure TThreadedLogger.WriteLog(const AMessage: string);
var
  LogFile: TextFile;
begin
  AssignFile(LogFile, FLogFilePath);
  try
    if FileExists(FLogFilePath) then
      Append(LogFile)
    else
      Rewrite(LogFile);
    Writeln(LogFile, AMessage);
  finally
    CloseFile(LogFile);
  end;
end;

procedure TThreadedLogger.Log(const ALevel: TLogLevel; const AMessage: string);
var
  LogLevelStr: string;
  FullMessage: string;
begin
  case ALevel of
    llInfo: LogLevelStr := 'INFO';
    llWarning: LogLevelStr := 'WARNING';
    llError: LogLevelStr := 'ERROR';
  end;

  FullMessage := Format('%s [%s] %s', [DateTimeToStr(Now), LogLevelStr, AMessage]);
  FLogQueue.PushItem(FullMessage); // Add the log message to the queue
end;

procedure TThreadedLogger.LogInfo(const AMessage: string);
begin
  Log(llInfo, AMessage);
end;

procedure TThreadedLogger.LogWarning(const AMessage: string);
begin
  Log(llWarning, AMessage);
end;

procedure TThreadedLogger.LogError(const AMessage: string);
begin
  Log(llError, AMessage);
end;

end.

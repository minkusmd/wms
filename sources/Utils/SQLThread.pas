unit SQLThread;

interface

uses
  System.Classes, System.SysUtils, IBC;

type
  TSQLThreadInitProc = procedure(const Query: TIBCQuery) of object;

  TSQLThreadCallbackProc = procedure(const Query: TIBCQuery) of object;

  TSQLThread = class(TThread)
  private
      { Private declarations }
    fQuery: TIBCQuery;
    fInitProc: TSQLThreadInitProc;
    fCallbackProc: TSQLThreadCallbackProc;
    procedure InitQuery;
    procedure Callback;
  public
      { Public declarations }
    procedure Execute; override;
    constructor Create(const InitCallbackProc: TSQLThreadInitProc; const CallBackProc: TSQLThreadCallbackProc); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TSQLThread }

procedure TSQLThread.Callback;
begin
  if Assigned(fCallbackProc) then
  try
    fCallbackProc(fQuery);
  except
  end;
end;

constructor TSQLThread.Create(const InitCallbackProc: TSQLThreadInitProc; const
  CallBackProc: TSQLThreadCallbackProc);
begin
  inherited Create(true);
  fQuery := TIBCQuery.Create(nil);
  FreeOnTerminate := True;
  fInitProc := InitCallbackProc;
  fCallbackProc := CallBackProc;
end;

destructor TSQLThread.Destroy;
begin
  fQuery.Free;
  inherited;
end;

procedure TSQLThread.Execute;
begin
  Synchronize(InitQuery);
  try
    fQuery.ExecSQL;
    if not fQuery.eof then
      Synchronize(Callback);
  except on e: Exception do
    begin
      raise;
    end;
  end;
end;

procedure TSQLThread.InitQuery; /// <summary>
                                /// Create sql select
                                /// Setting params if needed
                                /// </summary>
begin

  if Assigned(fInitProc) then
    fInitProc(fQuery);
end;

end.


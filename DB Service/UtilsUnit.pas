unit UtilsUnit;

interface
uses Classes, ServiceActionClass, AppSettingsClass;

type

  TTimerTickEvent = procedure of object;

  TTimerThread = class (TThread)
  private
    { private declarations }
    FOnTick: TTimerTickEvent;
    FInterval: cardinal;
  protected
    { protected declarations }
    procedure CallTickProc;
  public
    { public declarations }
    constructor Create(const IntervalMin:integer; const OnTickProc:TTimerTickEvent) ;reintroduce;
    procedure Execute;override;
  end;


  TSQLThreadOnTerminate = procedure (const Action:TServiceAction; const Error:String) of object;

  TSQLThread = class (TThread)
  private
    { private declarations }
    fAction:TServiceAction;
    fTerminateProc:TSQLThreadOnTerminate;
    fAppSettings:TSWNServiceManagerSettings;
  protected
    { protected declarations }
    fExecError:String;
    procedure CallTerminateProc;
    procedure DoSQLAction;
  public
    { public declarations }
    constructor Create(const AppSettings:TSWNServiceManagerSettings; const Action:TServiceAction; const TerminateProc:TSQLThreadOnTerminate) ;reintroduce;

    procedure Execute;override;

  end;

implementation

uses SysUtils, IBC, IBCClasses;

{ TTimerThread }

procedure TTimerThread.CallTickProc;
begin
     if Assigned(FOnTick) then FOnTick;
end;

constructor TTimerThread.Create(const IntervalMin: integer; const OnTickProc: TTimerTickEvent);
begin
     inherited Create(True);
     FInterval:=IntervalMin*60000;
     FOnTick:=OnTickProc;
     FreeOnTerminate:=True;
end;

procedure TTimerThread.Execute;
var N:cardinal;
begin
     while Not Terminated do
     begin
          N:=0;
          while (N<FInterval) and (Not Terminated) do
          begin
               Sleep(100);
               Inc(N,100);
          end;
          if Not Terminated then Synchronize(CallTickProc);
     end;
end;

{ TSQLThread }

procedure TSQLThread.CallTerminateProc;
begin
     if Assigned(fTerminateProc) then fTerminateProc(fAction,fExecError);
end;

constructor TSQLThread.Create(const AppSettings:TSWNServiceManagerSettings; const Action: TServiceAction; const TerminateProc: TSQLThreadOnTerminate);
begin
     fAppSettings:=AppSettings;
     fAction:=Action;
     fTerminateProc:=TerminateProc;
     inherited Create(false);
     FreeOnTerminate:=True;
end;

procedure TSQLThread.DoSQLAction;
var conn:TIBCConnection;
    trans:TIBCTransaction;
    query:TIBCQuery;
begin
     fExecError:='';
     // connection
     conn:=TIBCConnection.Create(nil);
     try
        conn.SQLDialect:=3;
        conn.ClientLibrary:='fbclient.dll';
        conn.Username:=fAppSettings.UserName;
        conn.Password:=fAppSettings.UserPass;
        conn.Server:=fAppSettings.Server;
        conn.Database:=fAppSettings.DBName;
        try
           conn.Connect;
           // transaction
           trans:=TIBCTransaction.Create(nil);
           try
              trans.DefaultConnection:=conn;
              trans.IsolationLevel:=iblReadCommitted;
              trans.Params.Add('nowait');
              trans.Params.Add('read_committed');
              trans.Params.Add('rec_version');
              try
                 trans.StartTransaction;
                 // query
                 query:=TIBCQuery.Create(nil);
                 try
                    query.Connection:=conn;
                    query.Transaction:=trans;
                    try
                       // 1. create user enviroment
                       query.SQL.Text:='EXECUTE PROCEDURE PROC_USER_LOGIN(:UserID)';
                       query.ParamByName('UserID').AsInteger:=fAppSettings.DBUserID;
                       query.Execute;

                       // 2. execute procedure
                       query.SQL.Text:='EXECUTE PROCEDURE '+fAction.StoredProcedure;
                       query.Execute;
                       // commit work
                       trans.Commit;
                    except on E:Exception do
                       begin
                            trans.Rollback;
                            fExecError:='Failed to execute procedure! '+E.Message;
                       end;
                    end;
                 finally
                    query.Free;
                 end;
              except on E:Exception do
                 fExecError:='Failed to start transaction! '+E.Message;
              end;
           finally
              trans.Free;
           end;
        except on E:Exception do
           fExecError:='Failed to connect! '+E.Message;
        end;
     finally
        conn.Free;
     end;
end;

procedure TSQLThread.Execute;
begin
     DoSQLAction;
     Synchronize(CallTerminateProc);
end;

end.

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

uses SysUtils, IBC, IBCClasses, ServiceJobsUnit;

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
              // TPB scris explicit (iblCustom): pentru iblReadCommitted IBDAC pune singur
              // read_consistency + NOWAIT, iar un parametru in plus da "invalid parameter in
              // transaction parameter block" (rec_version - toate sarcinile picau, 3.10.2026).
              // WAIT cu limita: o sarcina care atinge rinduri blocate de alta tranzactie (ex.
              // SP_WEB_CREATE_CACHE_GOODS vs reevaluarile care sterg TDB_GOODS_FLAGS ->
              // TWEB_CACHE_GOODS) asteapta pina la 60 s in loc sa cada imediat cu
              // "update conflicts with concurrent update"; cu read_consistency (Firebird 5)
              // instructiunea se reia singura dupa ce cealalta tranzactie se termina.
              trans.IsolationLevel:=iblCustom;
              trans.Params.Add('read_committed');
              trans.Params.Add('read_consistency');
              trans.Params.Add('write');
              trans.Params.Add('wait');
              trans.Params.Add('lock_timeout=60');
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

                       if IsServiceJob(fAction.StoredProcedure) then
                       begin
                            // 2a. job Delphi ("@NUME"): isi face singur tranzactiile scurte pe
                            //     aceeasi conexiune (contextul PROC_USER_LOGIN ramine pe conexiune)
                            trans.Commit;
                            fExecError:=RunServiceJob(fAction.StoredProcedure, conn, fAppSettings.DBUserID);
                       end
                       else
                       begin
                            // 2. execute procedure
                            query.SQL.Text:='EXECUTE PROCEDURE '+fAction.StoredProcedure;
                            query.Execute;
                            // commit work
                            trans.Commit;
                       end;
                    except on E:Exception do
                       begin
                            if trans.Active then trans.Rollback;
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

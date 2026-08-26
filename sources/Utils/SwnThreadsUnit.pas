unit SwnThreadsUnit;

interface

uses
    System.Classes;

type
    TBeforeStartProc = reference to procedure;

    TCurrencyRateChangeThread = class(TThread)
    private
        FOnBeforeStart: TBeforeStartProc;
        FOnSuccesFinished: TBeforeStartProc;
        procedure DoOnSuccesFinished;
    protected
        procedure DoOnBeforStart;
        procedure Execute; override;
    public
    /// constructor: creează thread-ul, opțional în stare suspendată
        constructor Create(CreateSuspended: Boolean = False);
        property OnBeforeStart: TBeforeStartProc read FOnBeforeStart write FOnBeforeStart;
    /// eveniment apelat după terminarea lucrului din Execute
        property OnSuccesFinished: TBeforeStartProc read FOnSuccesFinished write FOnSuccesFinished;

    end;

implementation

uses
    IBC;

{ TPriceThread }

constructor TCurrencyRateChangeThread.Create(CreateSuspended: Boolean);
begin
    inherited Create(CreateSuspended);
    FreeOnTerminate := True;  // eliberează automat obiectul după terminare
end;

procedure TCurrencyRateChangeThread.DoOnBeforStart;
begin
    if Assigned(FOnBeforeStart) then
        FOnBeforeStart;
end;

procedure TCurrencyRateChangeThread.DoOnSuccesFinished;
begin
  // apelăm handler-ul doar dacă e definit
    if Assigned(FOnSuccesFinished) then
        FOnSuccesFinished;
end;

procedure TCurrencyRateChangeThread.Execute;
var
    conn: TIBCConnection;
    q: TIBCQuery;
    tr: TIBCTransaction;
begin
    conn := TIBCConnection.Create(nil, 'Data Source=192.168.106.254;Database=sw;User ID=SYSDBA;Password=uigres321;Client Library=fbclient.dll;Login Prompt=False');
    conn.Connected := true;
    q := TIBCQuery.Create(nil);
    q.Connection := conn;
    tr := TIBCTransaction.Create(nil);
    tr.DefaultConnection := conn;
    tr.Params.Clear;
    tr.Params.Add('nowait');
    tr.Params.Add('read_committed');

    tr.StartTransaction;
    try
        q.Transaction := tr;
        q.SQL.Text := 'EXECUTE PROCEDURE RECALC_ALL_PGT';
        Queue(DoOnBeforStart);
        try
            q.Execute;
            tr.Commit;
            Queue(DoOnSuccesFinished);
        except
            begin
                tr.rollback;
                raise;
            end;
        end;
    finally
        q.Free;
        tr.Free;
        conn.Free;
    end;

end;

end.


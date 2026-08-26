unit AccentGuidRepo;

interface

uses
    System.SysUtils, IBC, // TIBCConnection, TIBCQuery, TIBCTransaction
    AccentAuthService;    // IAccentAuthService

type
    TAccentGuidRepo = class
    private
        FConn: TIBCConnection;
        FTr: TIBCTransaction;

    public
        constructor Create(AConn: TIBCConnection; ATr: TIBCTransaction);

        function TryGetTodayGuidFromTable(out AGuid: string): Boolean;
        procedure UpsertTodayGuidToTable(const AGuid: string);
        function EnsureTodayGuid(const AAuthService: IAccentAuthService): string;
        procedure TryClearTodayGuidFromTable;
    end;

implementation

uses
    System.DateUtils, IBCClasses, DataModuleDB;

{ TAccentGuidRepo }

constructor TAccentGuidRepo.Create(AConn: TIBCConnection; ATr: TIBCTransaction);
begin
    inherited Create;
    FConn := AConn;
    FTr := ATr;
end;

function TAccentGuidRepo.TryGetTodayGuidFromTable(out AGuid: string): Boolean;
var
    Q: TIBCQuery;
begin
    Result := False;
    AGuid := '';

    Q := TIBCQuery.Create(nil);
    try
        Q.Connection := FConn;
        Q.Transaction := dmdb.IBCTrDefaultSelect;
        Q.SQL.Text := 'select GUID ' + 'from TAPI_ACCENT_TRANSACTIONS ' + 'where DATA = :D';
        Q.ParamByName('D').AsDate := Date;
        Q.Open;

        if not Q.IsEmpty then
        begin
            AGuid := Q.FieldByName('GUID').AsString;
            Result := AGuid <> '';
        end;
    finally
        Q.Free;
    end;
end;

procedure TAccentGuidRepo.TryClearTodayGuidFromTable;
var
    Q: TIBCQuery;
begin
    Q := TIBCQuery.Create(nil);
    try
        Q.Connection := FConn;
        Q.Transaction := dmdb.IBCTrDefaultUpdate;
        Q.SQL.Text := 'delete from TAPI_ACCENT_TRANSACTIONS ' + 'where DATA = :D';
        Q.ParamByName('D').AsDate := Date;
        Q.ExecSQL;

    finally
        Q.Free;
    end;
end;

procedure TAccentGuidRepo.UpsertTodayGuidToTable(const AGuid: string);
var
    Q: TIBCQuery;
begin
    Q := TIBCQuery.Create(nil);
    try
        Q.Connection := FConn;
        Q.Transaction := dmdb.IBCTrDefaultUpdate;
        Q.SQL.Text := 'update or insert into TAPI_ACCENT_TRANSACTIONS (DATA, GUID) ' + 'values (:D, :G) ' + 'matching (DATA)';

        Q.ParamByName('D').AsDate := Date;
        Q.ParamByName('G').AsString := AGuid;

        Q.ExecSQL;
        if q.transaction.Active then
            Q.Transaction.Commit// sau Commit, după politica ta
    finally
        Q.Free;
    end;
end;

function TAccentGuidRepo.EnsureTodayGuid(const AAuthService: IAccentAuthService): string;
begin
  // 1) încerci din tabel
    if TryGetTodayGuidFromTable(Result) then
        Exit;

  // 2) dacă nu există, ceri din API
    if Assigned(AAuthService) and AAuthService.FetchGuidFromApi(Result) and (Result <> '') then
    begin
    // 3) salvezi și returnezi
        UpsertTodayGuidToTable(Result);
        Exit;
    end;

    raise Exception.Create('Nu s-a putut obține GUID: nici în tabel, nici din API.');
end;

end.


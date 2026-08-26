unit uPhoneSearchThread;

interface

uses
  System.Classes, System.SysUtils, System.Types,
  IBCClasses, IBC, System.Generics.Defaults, System.Generics.Collections;

type
  TPhoneSearchThread = class(TThread)
  private
    FPhoneNumber: string;
    IBCConnection: TIBCConnection;
    IBCTransaction: TIBCTransaction;
    procedure AddNewCustomer(const APhoneNumber: string);
    function FormatPhoneNumber(const APhoneNumber: string): string;
    procedure UpdateCallerInfo;
  public
    CustomerName: string;
    CustomerID: Integer;
    OnResult: TProc<string, Integer>; // callback catre UI
    constructor Create(ACreateSuspended: Boolean; const APhoneNumber: string); overload;
    destructor Destroy; override;
    procedure Execute; override;
  end;

implementation

uses
  Winapi.Windows;

{ TPhoneSearchThread }

constructor TPhoneSearchThread.Create(ACreateSuspended: Boolean; const APhoneNumber: string);
begin
  inherited Create(ACreateSuspended);
  FreeOnTerminate := False; // Setează True în afară dacă vrei auto-cleanup
  FPhoneNumber := APhoneNumber;

  IBCConnection := TIBCConnection.Create(nil);
  IBCConnection.Database := '192.168.106.254:sw';
  IBCConnection.Username := 'SYSDBA';
  IBCConnection.Password := 'uigres321';
  IBCConnection.ClientLibrary := 'fbclient.dll';
  IBCConnection.Options.CharSet := 'UTF8';
  IBCConnection.Options.UseUnicode := True;
  IBCConnection.LoginPrompt := False;
  IBCConnection.Connected := True;

  IBCTransaction := TIBCTransaction.Create(nil);
  IBCTransaction.Params.Clear;
  IBCTransaction.Params.Add('read_committed');
  IBCTransaction.Params.Add('write');
  IBCTransaction.Params.Add('nowait');
  IBCTransaction.DefaultConnection := IBCConnection;
end;

destructor TPhoneSearchThread.Destroy;
begin
  FreeAndNil(IBCTransaction);
  FreeAndNil(IBCConnection);
end;

procedure TPhoneSearchThread.Execute;
var
  Query: TIBCQuery;
  FormattedNumber: string;
begin
  try
    FormattedNumber := FormatPhoneNumber(FPhoneNumber);

    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := IBCConnection;
      Query.Transaction := IBCTransaction;
      Query.SQL.Text := 'SELECT * FROM GET_CUSTOMERS_BY_PHONE(:PHONENUMBER)';
      Query.ParamByName('PHONENUMBER').AsString := FormattedNumber;
      Query.Open;

      if not Query.IsEmpty then
      begin
        CustomerID := Query.FieldByName('CUSTOMERID').AsInteger;
        CustomerName := Query.FieldByName('NAME').AsString;
      end
      else
      begin
        AddNewCustomer(FormattedNumber);
        Exit;
      end;

      Synchronize(UpdateCallerInfo);

    finally
      Query.Free;
    end;

  except
    on E: Exception do
    begin
      OutputDebugString(PChar('Thread Exception: ' + E.Message));
    end;
  end;
end;

function TPhoneSearchThread.FormatPhoneNumber(const APhoneNumber: string): string;
var
  ResultNumber: string;
begin
  ResultNumber := APhoneNumber;

  if (Copy(ResultNumber, 1, 2) = '22') then
    ResultNumber := '0' + ResultNumber;

  if Length(ResultNumber) > 0 then
    if (ResultNumber[1] = '6') or (ResultNumber[1] = '7') then
      if ResultNumber[1] <> '0' then
        ResultNumber := '0' + ResultNumber;

  Result := ResultNumber;
end;

procedure TPhoneSearchThread.AddNewCustomer(const APhoneNumber: string);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    try
      Query.Connection := IBCConnection;
      Query.Transaction := IBCTransaction;
      Query.SQL.Text := 'SELECT CUSTOMER_NAME, CUSTOMERID FROM REG_NEW_CUSTOMER_BY_PHONE(:PHONENUMBER)';
      Query.ParamByName('PHONENUMBER').AsString := APhoneNumber;

      if not IBCTransaction.Active then
        IBCTransaction.StartTransaction;

      Query.Open;

      CustomerID := Query.FieldByName('CUSTOMERID').AsInteger;
      CustomerName := Query.FieldByName('CUSTOMER_NAME').AsString;

      IBCTransaction.Commit;

      Synchronize(UpdateCallerInfo);

    except
      on E: Exception do
      begin
        if IBCTransaction.Active then
          IBCTransaction.Rollback;
        raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TPhoneSearchThread.UpdateCallerInfo;
begin
  if Assigned(OnResult) then
    OnResult(CustomerName, CustomerID);
end;

end.


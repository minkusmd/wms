unit ECCTransactionStore;

(* Jurnalul cererilor catre casa ECC Fiscal Partner - tabela TFP_ECC_TRANSACTION
   (DB Model/ecc_fiscalpartner.sql).

   Regula de baza: rindul se scrie si se COMITE inainte de POST catre ECC.
   TRANS_ID e UUID-ul trimis ca "id" in cerere, deci dupa o cadere (WMS inchis,
   retea picata, timeout) rezultatul se afla cu GET /receipt/{id} si bonul nu se
   emite a doua oara. Fiecare metoda foloseste o tranzactie proprie, scurta,
   comisa imediat - independenta de tranzactia documentului WMS.

   Conexiunea: pe firul principal se poate da dmDB.IBCConnection; pe un fir de
   lucru se foloseste CreateOwnConnection (componentele IBDAC nu se impart intre
   fire). *)

interface

uses
  System.SysUtils, System.Classes, IBC, ECCApiClient;

const
  // TFP_ECC_TRANSACTION.KIND
  eccKindReceipt  = 1;
  eccKindService  = 2;
  eccKindXReport  = 3;
  eccKindZReport  = 4;
  eccKindOrderExt = 5;
  eccKindDelivery = 6;

  // TFP_ECC_TRANSACTION.STATE
  eccStateNew       = 0;   // in jurnal, netrimis
  eccStateSent      = 1;   // acceptat de ECC, rezultatul inca necunoscut
  eccStateDone      = 2;   // emis in ECC
  eccStateError     = 3;   // respins definitiv
  eccStateCancelled = 4;

  // TFP_ECC_TRANSACTION.SOURCE_TYPE
  eccSrcNone       = 0;
  eccSrcInvoice    = 1;
  eccSrcPOSSale    = 2;
  eccSrcEcomm      = 3;
  eccSrcMIA        = 4;
  eccSrcDelivery   = 5;
  eccSrcDiagnostic = 6;

type
  TECCTransaction = record
    TransId: string;
    ApiCode: string;
    FPID: Integer;          // 0 = NULL
    FirmaID: Integer;       // 0 = NULL
    DocID: Integer;         // 0 = NULL
    Kind: Integer;
    State: Integer;
    Registered: Boolean;
    SourceType: Integer;
    SourceRef: string;
    Suma: Currency;
    PayType: Integer;       // 0 = NULL
    CashierName: string;
    Attempts: Integer;
    OrderStatus: string;
    ReceiptNumber: Integer;
    ZNumber: Integer;
    NumberFromFirst: Integer;
    EccDateTime: TDateTime;
    MevLink: string;
    DocFileName: string;
    ErrorMsg: string;
    RequestJSON: string;
    ResponseJSON: string;
    UserID: Integer;
    CreatedAt: TDateTime;
    UpdatedAt: TDateTime;
  end;

  TECCTransactionStore = class
  private
    FConn: TIBCConnection;
    FOwnsConn: Boolean;
    procedure Exec(const ASQL: string; const ASetup: TProc<TIBCQuery>);
    procedure Select(const ASQL: string; const ASetup, ARow: TProc<TIBCQuery>);
    function ReadRow(Q: TIBCQuery): TECCTransaction;
  public
    // AOwnsConnection = True: conexiunea se elibereaza odata cu obiectul.
    constructor Create(AConn: TIBCConnection; AOwnsConnection: Boolean = False);
    destructor Destroy; override;

    // True daca DB Model/ecc_fiscalpartner.sql a fost rulat pe baza.
    class function Available(AConn: TIBCConnection): Boolean;
    // Conexiune noua cu aceiasi parametri (pentru fire de lucru). UserID ajunge
    // in contextul sesiunii, ca triggerele sa completeze USERID.
    class function CreateOwnConnection(ASource: TIBCConnection; AUserID: Integer): TIBCConnection;

    // Scrie rindul nou (STATE 0) si il comite. Ridica exceptie daca aceeasi sursa
    // are deja o tranzactie activa (UQ_TFP_ECC_TRANS_SOURCE).
    procedure AddNew(const T: TECCTransaction);
    // Cererea a fost acceptata de ECC (HTTP 202).
    procedure MarkSent(const ATransId: string);
    procedure MarkReceiptDone(const ATransId: string; const R: TECCReceipt; const AResponseJSON: string);
    procedure MarkReportDone(const ATransId: string; const R: TECCReport; const AResponseJSON: string);
    // Bon de serviciu / comanda: gata fara date de bon.
    procedure MarkDone(const ATransId: string; const AResponseJSON: string = '');
    // AFinal = True: STATE 3 (respins definitiv). False: se pastreaza starea
    // (de ex. timeout dupa 202 - ramine 1 si se verifica mai tirziu).
    procedure MarkError(const ATransId, AError: string; const AFinal: Boolean);
    procedure MarkCancelled(const ATransId, AReason: string);
    procedure SetOrderStatus(const ATransId, AOrderStatus: string);
    procedure SavePng(const ATransId: string; AStream: TStream);
    procedure MarkRegistered(const ATransId: string);
    // Leaga rindul din TDB_DOCS_RECEIPT (scris de SP_CREATE_RECEIPT3 / SP_POS_REGISTER_RECEIPT)
    // de tranzactia ECC si o marcheaza inregistrata. Rindul se gaseste dupa numar + data +
    // suma (+ DOCID daca e > 0), doar printre cele inca nelegate. Intoarce numarul de rinduri legate.
    function LinkWmsReceipt(const ATransId: string; const ADocID, ANumarBon: Integer;
      const ADataBon: TDateTime; const ASuma: Currency; const AFPID: Integer): Integer;
    // Casierul ECC al utilizatorului WMS (TFP_ECC_CASHIER); '' = se foloseste casierul implicit
    function FindCashierName(const AApiCode: string; const AUserID: Integer): string;

    function Load(const ATransId: string; out T: TECCTransaction): Boolean;
    function LoadPng(const ATransId: string; AStream: TStream): Boolean;
    // Tranzactia activa (STATE 0/1/2) a unei surse, daca exista.
    function FindActiveBySource(const ASourceType: Integer; const ASourceRef: string;
      out T: TECCTransaction): Boolean;
    // De finalizat: trimise fara rezultat (0/1) sau emise dar neinregistrate in WMS.
    // AApiCode = '' - toate casele.
    function ListPending(const AApiCode: string = ''): TArray<TECCTransaction>;
    function ListRecent(const AApiCode: string; const ACount: Integer = 50): TArray<TECCTransaction>;

    property Connection: TIBCConnection read FConn;
  end;

function ECCKindName(const AKind: Integer): string;
function ECCStateName(const AState: Integer): string;

implementation

uses
  Data.DB, DBAccess, MemDS, IBCClasses;

const
  cSelectFields =
    'SELECT TRANS_ID, API_CODE, FP_ID, FIRMA_ID, DOCID, KIND, STATE, FLG_REGISTERED, ' +
    'SOURCE_TYPE, SOURCE_REF, SUMA, PAY_TYPE, CASHIER_NAME, ATTEMPTS, ORDER_STATUS, ' +
    'RECEIPT_NUMBER, Z_NUMBER, NUMBER_FROM_FIRST, ECC_DATETIME, MEV_LINK, DOC_FILE_NAME, ' +
    'ERROR_MSG, REQUEST_JSON, RESPONSE_JSON, USERID, CREATED_AT, UPDATED_AT ' +
    'FROM TFP_ECC_TRANSACTION ';

function ECCKindName(const AKind: Integer): string;
begin
  case AKind of
    eccKindReceipt: Result := 'Bon fiscal';
    eccKindService: Result := 'Bon de serviciu';
    eccKindXReport: Result := 'Raport X';
    eccKindZReport: Result := 'Raport Z';
    eccKindOrderExt: Result := 'Comanda terminal';
    eccKindDelivery: Result := 'Livrare';
  else
    Result := IntToStr(AKind);
  end;
end;

function ECCStateName(const AState: Integer): string;
begin
  case AState of
    eccStateNew: Result := 'nou';
    eccStateSent: Result := 'trimis';
    eccStateDone: Result := 'emis';
    eccStateError: Result := 'eroare';
    eccStateCancelled: Result := 'anulat';
  else
    Result := IntToStr(AState);
  end;
end;

procedure SetInt(Q: TIBCQuery; const AName: string; const AValue: Integer);
begin
  if AValue = 0 then
  begin
    Q.ParamByName(AName).DataType := ftInteger;
    Q.ParamByName(AName).Clear;
  end
  else
    Q.ParamByName(AName).AsInteger := AValue;
end;

procedure SetStr(Q: TIBCQuery; const AName, AValue: string; const AMaxLen: Integer);
begin
  if AValue = '' then
  begin
    Q.ParamByName(AName).DataType := ftWideString;
    Q.ParamByName(AName).Clear;
  end
  else
    Q.ParamByName(AName).AsWideString := Copy(AValue, 1, AMaxLen);
end;

procedure SetMemo(Q: TIBCQuery; const AName, AValue: string);
begin
  if AValue = '' then
  begin
    Q.ParamByName(AName).DataType := ftMemo;
    Q.ParamByName(AName).Clear;
  end
  else
    Q.ParamByName(AName).AsMemo := AValue;
end;

procedure SetDateTime(Q: TIBCQuery; const AName: string; const AValue: TDateTime);
begin
  if AValue = 0 then
  begin
    Q.ParamByName(AName).DataType := ftDateTime;
    Q.ParamByName(AName).Clear;
  end
  else
    Q.ParamByName(AName).AsDateTime := AValue;
end;

// Filtrul pe casa se adauga doar cind e dat un cod: un parametru comparat cu ''
// primeste in Firebird tipul CHAR(0) si orice valoare da "string truncation".
function ApiCodeFilter(const AApiCode, AKeyword: string): string;
begin
  if Trim(AApiCode) = '' then
    Result := ''
  else
    Result := AKeyword + ' API_CODE = :API_CODE ';
end;

function NormId(const AId: string): string;
begin
  Result := LowerCase(Trim(AId));
end;

{ TECCTransactionStore }

constructor TECCTransactionStore.Create(AConn: TIBCConnection; AOwnsConnection: Boolean);
begin
  inherited Create;
  FConn := AConn;
  FOwnsConn := AOwnsConnection;
end;

destructor TECCTransactionStore.Destroy;
begin
  if FOwnsConn then
    FConn.Free;
  inherited;
end;

class function TECCTransactionStore.Available(AConn: TIBCConnection): Boolean;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConn;
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Q.Connection := AConn;
    Q.Transaction := Tr;
    Q.SQL.Text := 'SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ''TFP_ECC_TRANSACTION''';
    Q.Open;
    Result := Q.Fields[0].AsInteger > 0;
    Q.Close;
    if Tr.Active then
      Tr.Commit;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

class function TECCTransactionStore.CreateOwnConnection(ASource: TIBCConnection; AUserID: Integer): TIBCConnection;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Result := TIBCConnection.Create(nil);
  try
    Result.ClientLibrary := ASource.ClientLibrary;
    Result.Server := ASource.Server;
    Result.Port := ASource.Port;
    Result.Database := ASource.Database;
    Result.Username := ASource.Username;
    Result.Password := ASource.Password;
    Result.LoginPrompt := False;
    Result.Options.Charset := ASource.Options.Charset;
    Result.Options.UseUnicode := ASource.Options.UseUnicode;
    Result.Connect;

    if AUserID > 0 then
    begin
      Tr := TIBCTransaction.Create(nil);
      Q := TIBCQuery.Create(nil);
      try
        Tr.DefaultConnection := Result;
        Q.Connection := Result;
        Q.Transaction := Tr;
        Q.SQL.Text := 'SELECT RDB$SET_CONTEXT(''USER_SESSION'', ''UserID'', :UID) FROM RDB$DATABASE';
        Q.ParamByName('UID').AsString := IntToStr(AUserID);
        Q.Open;
        Q.Close;
        if Tr.Active then
          Tr.Commit;
      finally
        Q.Free;
        Tr.Free;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TECCTransactionStore.Exec(const ASQL: string; const ASetup: TProc<TIBCQuery>);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConn;
    Q.Connection := FConn;
    Q.Transaction := Tr;
    Q.SQL.Text := ASQL;
    Tr.StartTransaction;
    try
      if Assigned(ASetup) then
        ASetup(Q);
      Q.ExecSQL;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

procedure TECCTransactionStore.Select(const ASQL: string; const ASetup, ARow: TProc<TIBCQuery>);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConn;
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Q.Connection := FConn;
    Q.Transaction := Tr;
    Q.SQL.Text := ASQL;
    if Assigned(ASetup) then
      ASetup(Q);
    Q.Open;
    while not Q.Eof do
    begin
      ARow(Q);
      Q.Next;
    end;
    Q.Close;
    if Tr.Active then
      Tr.Commit;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

function TECCTransactionStore.ReadRow(Q: TIBCQuery): TECCTransaction;
begin
  Result := Default(TECCTransaction);
  Result.TransId := Trim(Q.FieldByName('TRANS_ID').AsString);
  Result.ApiCode := Trim(Q.FieldByName('API_CODE').AsString);
  Result.FPID := Q.FieldByName('FP_ID').AsInteger;
  Result.FirmaID := Q.FieldByName('FIRMA_ID').AsInteger;
  Result.DocID := Q.FieldByName('DOCID').AsInteger;
  Result.Kind := Q.FieldByName('KIND').AsInteger;
  Result.State := Q.FieldByName('STATE').AsInteger;
  Result.Registered := Q.FieldByName('FLG_REGISTERED').AsInteger = 1;
  Result.SourceType := Q.FieldByName('SOURCE_TYPE').AsInteger;
  Result.SourceRef := Q.FieldByName('SOURCE_REF').AsString;
  Result.Suma := Q.FieldByName('SUMA').AsCurrency;
  Result.PayType := Q.FieldByName('PAY_TYPE').AsInteger;
  Result.CashierName := Q.FieldByName('CASHIER_NAME').AsString;
  Result.Attempts := Q.FieldByName('ATTEMPTS').AsInteger;
  Result.OrderStatus := Q.FieldByName('ORDER_STATUS').AsString;
  Result.ReceiptNumber := Q.FieldByName('RECEIPT_NUMBER').AsInteger;
  Result.ZNumber := Q.FieldByName('Z_NUMBER').AsInteger;
  Result.NumberFromFirst := Q.FieldByName('NUMBER_FROM_FIRST').AsInteger;
  Result.EccDateTime := Q.FieldByName('ECC_DATETIME').AsDateTime;
  Result.MevLink := Q.FieldByName('MEV_LINK').AsString;
  Result.DocFileName := Q.FieldByName('DOC_FILE_NAME').AsString;
  Result.ErrorMsg := Q.FieldByName('ERROR_MSG').AsString;
  Result.RequestJSON := Q.FieldByName('REQUEST_JSON').AsString;
  Result.ResponseJSON := Q.FieldByName('RESPONSE_JSON').AsString;
  Result.UserID := Q.FieldByName('USERID').AsInteger;
  Result.CreatedAt := Q.FieldByName('CREATED_AT').AsDateTime;
  Result.UpdatedAt := Q.FieldByName('UPDATED_AT').AsDateTime;
end;

procedure TECCTransactionStore.AddNew(const T: TECCTransaction);
begin
  if not IsValidECCId(NormId(T.TransId)) then
    raise EECCApiError.CreateHttp(0, 'TRANS_ID invalid: ' + T.TransId);
  Exec(
    'INSERT INTO TFP_ECC_TRANSACTION (TRANS_ID, API_CODE, FP_ID, FIRMA_ID, KIND, STATE, ' +
    'SOURCE_TYPE, SOURCE_REF, DOCID, SUMA, PAY_TYPE, CASHIER_NAME, REQUEST_JSON, USERID) ' +
    'VALUES (:TRANS_ID, :API_CODE, :FP_ID, :FIRMA_ID, :KIND, 0, ' +
    ':SOURCE_TYPE, :SOURCE_REF, :DOCID, :SUMA, :PAY_TYPE, :CASHIER_NAME, :REQUEST_JSON, :USERID)',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('TRANS_ID').AsString := NormId(T.TransId);
      Q.ParamByName('API_CODE').AsString := UpperCase(Trim(T.ApiCode));
      SetInt(Q, 'FP_ID', T.FPID);
      SetInt(Q, 'FIRMA_ID', T.FirmaID);
      Q.ParamByName('KIND').AsInteger := T.Kind;
      Q.ParamByName('SOURCE_TYPE').AsInteger := T.SourceType;
      SetStr(Q, 'SOURCE_REF', T.SourceRef, 64);
      SetInt(Q, 'DOCID', T.DocID);
      Q.ParamByName('SUMA').AsCurrency := T.Suma;
      SetInt(Q, 'PAY_TYPE', T.PayType);
      SetStr(Q, 'CASHIER_NAME', T.CashierName, 100);
      SetMemo(Q, 'REQUEST_JSON', T.RequestJSON);
      SetInt(Q, 'USERID', T.UserID);
    end);
end;

procedure TECCTransactionStore.MarkSent(const ATransId: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET STATE = 1, ATTEMPTS = ATTEMPTS + 1, ERROR_MSG = NULL ' +
    'WHERE TRANS_ID = :ID AND STATE IN (0, 1)',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
    end);
end;

procedure TECCTransactionStore.MarkReceiptDone(const ATransId: string; const R: TECCReceipt;
  const AResponseJSON: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET STATE = 2, ERROR_MSG = NULL, RECEIPT_NUMBER = :NR, ' +
    'Z_NUMBER = :ZNR, NUMBER_FROM_FIRST = :NFF, ECC_DATETIME = :DT, MEV_LINK = :MEV, ' +
    'DOC_FILE_NAME = :DOC, RESPONSE_JSON = :RESP WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      Q.ParamByName('NR').AsInteger := R.Number;
      Q.ParamByName('ZNR').AsInteger := R.ZReportNumber;
      Q.ParamByName('NFF').AsInteger := R.NumberFromFirst;
      SetDateTime(Q, 'DT', R.DateTime);
      SetStr(Q, 'MEV', R.MevLink, 255);
      SetStr(Q, 'DOC', R.DocFileName, 100);
      SetMemo(Q, 'RESP', AResponseJSON);
    end);
end;

procedure TECCTransactionStore.MarkReportDone(const ATransId: string; const R: TECCReport;
  const AResponseJSON: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET STATE = 2, ERROR_MSG = NULL, Z_NUMBER = :ZNR, ' +
    'ECC_DATETIME = :DT, DOC_FILE_NAME = :DOC, SUMA = :SUMA, RESPONSE_JSON = :RESP WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      // la X, number e numarul raportului X, iar Z-ul curent vine separat
      if R.ZReportNumber > 0 then
        Q.ParamByName('ZNR').AsInteger := R.ZReportNumber
      else
        SetInt(Q, 'ZNR', R.Number);
      if R.CloseDateTime > 0 then
        SetDateTime(Q, 'DT', R.CloseDateTime)
      else
        SetDateTime(Q, 'DT', R.StartDateTime);
      SetStr(Q, 'DOC', R.DocFileName, 100);
      Q.ParamByName('SUMA').AsCurrency := R.MoneyInDrawer;
      SetMemo(Q, 'RESP', AResponseJSON);
    end);
end;

procedure TECCTransactionStore.MarkDone(const ATransId, AResponseJSON: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET STATE = 2, ERROR_MSG = NULL, ' +
    'RESPONSE_JSON = COALESCE(:RESP, RESPONSE_JSON) WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      SetMemo(Q, 'RESP', AResponseJSON);
    end);
end;

procedure TECCTransactionStore.MarkError(const ATransId, AError: string; const AFinal: Boolean);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET ERROR_MSG = :ERR, ' +
    'STATE = CASE WHEN :FIN = 1 AND STATE IN (0, 1) THEN 3 ELSE STATE END WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      SetStr(Q, 'ERR', AError, 1000);
      Q.ParamByName('FIN').AsInteger := Ord(AFinal);
    end);
end;

procedure TECCTransactionStore.MarkCancelled(const ATransId, AReason: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET STATE = 4, ERROR_MSG = :ERR WHERE TRANS_ID = :ID AND STATE <> 2',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      SetStr(Q, 'ERR', AReason, 1000);
    end);
end;

procedure TECCTransactionStore.SetOrderStatus(const ATransId, AOrderStatus: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET ORDER_STATUS = :ST WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      SetStr(Q, 'ST', AOrderStatus, 20);
    end);
end;

procedure TECCTransactionStore.SavePng(const ATransId: string; AStream: TStream);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET DOC_PNG = :PNG WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
      AStream.Position := 0;
      Q.ParamByName('PNG').LoadFromStream(AStream, ftBlob);
    end);
end;

procedure TECCTransactionStore.MarkRegistered(const ATransId: string);
begin
  Exec('UPDATE TFP_ECC_TRANSACTION SET FLG_REGISTERED = 1 WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
    end);
end;

function TECCTransactionStore.LinkWmsReceipt(const ATransId: string; const ADocID, ANumarBon: Integer;
  const ADataBon: TDateTime; const ASuma: Currency; const AFPID: Integer): Integer;
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConn;
    Q.Connection := FConn;
    Q.Transaction := Tr;
    Q.SQL.Text := 'UPDATE TDB_DOCS_RECEIPT SET ECC_TRANS_ID = :ID, FP_ID = COALESCE(FP_ID, :FP_ID) ' +
      'WHERE NUMAR_BON = :NR AND DATA_ELIBERARII = :DT AND SUMA = :SUMA AND ECC_TRANS_ID IS NULL';
    if ADocID > 0 then
      Q.SQL.Add(' AND DOCID = :DOCID');
    Tr.StartTransaction;
    try
      Q.ParamByName('ID').AsString := NormId(ATransId);
      SetInt(Q, 'FP_ID', AFPID);
      Q.ParamByName('NR').AsInteger := ANumarBon;
      Q.ParamByName('DT').AsDateTime := ADataBon;
      Q.ParamByName('SUMA').AsCurrency := ASuma;
      if ADocID > 0 then
        Q.ParamByName('DOCID').AsInteger := ADocID;
      Q.ExecSQL;
      Result := Q.RowsAffected;
      if Result > 0 then
      begin
        Q.SQL.Text := 'UPDATE TFP_ECC_TRANSACTION SET FLG_REGISTERED = 1 WHERE TRANS_ID = :ID';
        Q.ParamByName('ID').AsString := NormId(ATransId);
        Q.ExecSQL;
      end;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

function TECCTransactionStore.FindCashierName(const AApiCode: string; const AUserID: Integer): string;
var
  Name: string;
begin
  Name := '';
  if AUserID <= 0 then
    Exit('');
  Select('SELECT CASHIER_NAME FROM TFP_ECC_CASHIER WHERE API_CODE = :API_CODE AND USERID = :USERID AND FLG_ACTIVE = 1',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('API_CODE').AsString := UpperCase(Trim(AApiCode));
      Q.ParamByName('USERID').AsInteger := AUserID;
    end,
    procedure(Q: TIBCQuery)
    begin
      Name := Trim(Q.FieldByName('CASHIER_NAME').AsString);
    end);
  Result := Name;
end;

function TECCTransactionStore.Load(const ATransId: string; out T: TECCTransaction): Boolean;
var
  Found: Boolean;
  Row: TECCTransaction;
begin
  Found := False;
  Row := Default(TECCTransaction);
  Select(cSelectFields + 'WHERE TRANS_ID = :ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
    end,
    procedure(Q: TIBCQuery)
    begin
      Row := ReadRow(Q);
      Found := True;
    end);
  T := Row;
  Result := Found;
end;

function TECCTransactionStore.LoadPng(const ATransId: string; AStream: TStream): Boolean;
var
  Found: Boolean;
begin
  Found := False;
  Select('SELECT DOC_PNG FROM TFP_ECC_TRANSACTION WHERE TRANS_ID = :ID AND DOC_PNG IS NOT NULL',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ID').AsString := NormId(ATransId);
    end,
    procedure(Q: TIBCQuery)
    begin
      TBlobField(Q.FieldByName('DOC_PNG')).SaveToStream(AStream);
      Found := True;
    end);
  Result := Found;
end;

function TECCTransactionStore.FindActiveBySource(const ASourceType: Integer; const ASourceRef: string;
  out T: TECCTransaction): Boolean;
var
  Found: Boolean;
  Row: TECCTransaction;
begin
  Found := False;
  Row := Default(TECCTransaction);
  Select(cSelectFields + 'WHERE SOURCE_TYPE = :ST AND SOURCE_REF = :REF AND STATE IN (0, 1, 2) ' +
    'AND KIND IN (1, 5, 6)',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('ST').AsInteger := ASourceType;
      Q.ParamByName('REF').AsString := ASourceRef;
    end,
    procedure(Q: TIBCQuery)
    begin
      Row := ReadRow(Q);
      Found := True;
    end);
  T := Row;
  Result := Found;
end;

function TECCTransactionStore.ListPending(const AApiCode: string): TArray<TECCTransaction>;
var
  List: TArray<TECCTransaction>;
begin
  List := nil;
  Select(cSelectFields +
    'WHERE (STATE IN (0, 1) OR (STATE = 2 AND FLG_REGISTERED = 0 AND SOURCE_TYPE BETWEEN 1 AND 5)) ' +
    ApiCodeFilter(AApiCode, 'AND') + 'ORDER BY CREATED_AT',
    procedure(Q: TIBCQuery)
    begin
      if Trim(AApiCode) <> '' then
        Q.ParamByName('API_CODE').AsString := UpperCase(Trim(AApiCode));
    end,
    procedure(Q: TIBCQuery)
    begin
      List := List + [ReadRow(Q)];
    end);
  Result := List;
end;

function TECCTransactionStore.ListRecent(const AApiCode: string; const ACount: Integer): TArray<TECCTransaction>;
var
  List: TArray<TECCTransaction>;
begin
  List := nil;
  Select(StringReplace(cSelectFields, 'SELECT ', 'SELECT FIRST ' + IntToStr(ACount) + ' ', []) +
    ApiCodeFilter(AApiCode, 'WHERE') + 'ORDER BY CREATED_AT DESC',
    procedure(Q: TIBCQuery)
    begin
      if Trim(AApiCode) <> '' then
        Q.ParamByName('API_CODE').AsString := UpperCase(Trim(AApiCode));
    end,
    procedure(Q: TIBCQuery)
    begin
      List := List + [ReadRow(Q)];
    end);
  Result := List;
end;

end.

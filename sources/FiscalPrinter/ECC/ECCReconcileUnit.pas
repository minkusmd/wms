unit ECCReconcileUnit;

(* Reconcilierea casei ECC Fiscal Partner cu WMS (faza 8 din
   Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md).

   Fara VCL: o folosesc dialogul "Reconciliere ECC" din WMS si job-ul de noapte
   @ECC_RECONCILE din SWNService.

   Pentru o casa (API_CODE) si o perioada compara:
     - bonurile din ECC (GET /receipt, doar POS-ul casei si al terminalului ei);
     - jurnalul TFP_ECC_TRANSACTION (bonuri, comenzi pe terminal, livrari);
     - rindurile din TDB_DOCS_RECEIPT legate prin ECC_TRANS_ID.
   Fiecare bon primeste o clasa: in regula, doar in ECC (emis in afara WMS),
   lipsa in ECC, neinregistrat in WMS, suma diferita, reparat.
   Repararea automata (AAutoFix) face doar ce e sigur: tranzactiile ramase
   "nou/trimis" in jurnal, dar gasite in ECC, trec in "emis" cu datele bonului.
   Inregistrarea in WMS a bonurilor din facturi / POS nu se face automat (cere
   documentele WMS); cele online le inregistreaza @ECC_ONLINE. *)

interface

uses
  System.SysUtils, IBC, ECCApiClient, ECCConfigUnit, ECCTransactionStore;

type
  TECCReconcileKind = (erkOk, erkOnlyInECC, erkMissingInECC, erkNotRegistered, erkSumMismatch, erkFixed,
    erkInfo);

  TECCReconcileRow = record
    Kind: TECCReconcileKind;
    TransId: string;
    ReceiptNumber: Integer;
    ZNumber: Integer;
    DateTime: TDateTime;
    EccTotal: Currency;
    WmsTotal: Currency;
    DocID: Integer;
    SourceType: Integer;
    Note: string;
  end;

  TECCReconcileResult = record
    ApiCode: string;
    DateFrom: TDateTime;
    DateTo: TDateTime;
    Rows: TArray<TECCReconcileRow>;
    EccCount: Integer;
    EccTotal: Currency;
    JournalCount: Integer;
    JournalTotal: Currency;
    OkCount: Integer;
    ProblemCount: Integer;
    FixedCount: Integer;
    function Summary: string;
  end;

// ADateTo exclusiv. Ridica exceptie daca casa nu e configurata sau ECC nu raspunde.
function ECCReconcile(AConn: TIBCConnection; const AApiCode: string; const ADateFrom, ADateTo: TDateTime;
  const AAutoFix: Boolean): TECCReconcileResult;
// Casele ECC active din FP_DEVICES (DEVICE_TYPE = 1).
function ECCActiveApiCodes(AConn: TIBCConnection): TArray<string>;
function ECCReconcileKindName(const AKind: TECCReconcileKind): string;
function ECCSourceTypeName(const ASourceType: Integer): string;

implementation

uses
  System.Generics.Collections, System.DateUtils, Data.DB, DBAccess, MemDS, IBCClasses;

type
  TJournalRow = record
    TransId: string;
    Kind: Integer;
    State: Integer;
    SourceType: Integer;
    DocID: Integer;
    Suma: Currency;
    ReceiptNumber: Integer;
    ZNumber: Integer;
    When: TDateTime;
    WmsRows: Integer;
    WmsSuma: Currency;
  end;

function ECCReconcileKindName(const AKind: TECCReconcileKind): string;
begin
  case AKind of
    erkOk: Result := 'in regula';
    erkOnlyInECC: Result := 'doar in ECC';
    erkMissingInECC: Result := 'lipsa in ECC';
    erkNotRegistered: Result := 'neinregistrat in WMS';
    erkSumMismatch: Result := 'suma diferita';
    erkFixed: Result := 'reparat';
    erkInfo: Result := 'info';
  else
    Result := '?';
  end;
end;

function ECCSourceTypeName(const ASourceType: Integer): string;
begin
  case ASourceType of
    eccSrcInvoice: Result := 'factura';
    eccSrcPOSSale: Result := 'POS';
    eccSrcEcomm: Result := 'card online';
    eccSrcMIA: Result := 'MIA';
    eccSrcDelivery: Result := 'livrare';
    eccSrcDiagnostic: Result := 'diagnostic';
  else
    Result := '';
  end;
end;

procedure Select(AConn: TIBCConnection; const ASQL: string; const ASetup, ARow: TProc<TIBCQuery>);
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

function ECCActiveApiCodes(AConn: TIBCConnection): TArray<string>;
var
  List: TArray<string>;
begin
  List := nil;
  Select(AConn, 'SELECT DISTINCT UPPER(TRIM(ECC_API_CODE)) AS C FROM FP_DEVICES ' +
    'WHERE DEVICE_TYPE = 1 AND FLG_ENABLED = 1 AND ECC_API_CODE IS NOT NULL', nil,
    procedure(Q: TIBCQuery)
    begin
      List := List + [Q.FieldByName('C').AsString];
    end);
  Result := List;
end;

function TECCReconcileResult.Summary: string;
begin
  Result := Format('%s, %s - %s: ECC %d bonuri (%s lei), jurnal %d (%s lei); in regula %d, probleme %d, reparate %d',
    [ApiCode, FormatDateTime('dd.mm.yyyy hh:nn', DateFrom), FormatDateTime('dd.mm.yyyy hh:nn', DateTo),
     EccCount, ECCMoneyText(EccTotal), JournalCount, ECCMoneyText(JournalTotal), OkCount, ProblemCount,
     FixedCount]);
end;

function ECCReconcile(AConn: TIBCConnection; const AApiCode: string; const ADateFrom, ADateTo: TDateTime;
  const AAutoFix: Boolean): TECCReconcileResult;
var
  Config: TECCConfig;
  Client: TECCApiClient;
  Store: TECCTransactionStore;
  EccList, ForPos: TArray<TECCReceipt>;
  Rc, Fresh: TECCReceipt;
  Journal: TDictionary<string, TJournalRow>;
  SeenInEcc: TDictionary<string, Boolean>;
  J: TJournalRow;
  Row: TECCReconcileRow;
  Res: TECCReconcileResult;
  Zs: TArray<TECCReport>;
  Z: TECCReport;
  Closed: Boolean;
  Err: string;
  Code: string;
  FromDT, ToDT: TDateTime;

  procedure AddRow(const R: TECCReconcileRow);
  begin
    Res.Rows := Res.Rows + [R];
    case R.Kind of
      erkOk: Inc(Res.OkCount);
      erkFixed: Inc(Res.FixedCount);
      erkInfo: ;
    else
      Inc(Res.ProblemCount);
    end;
  end;

  function PosMatches(const APosId: string): Boolean;
  begin
    Result := SameText(APosId, Config.PosId) or
      ((Config.TerminalPosId <> '') and SameText(APosId, Config.TerminalPosId));
  end;

begin
  Res := Default(TECCReconcileResult);
  Res.ApiCode := UpperCase(Trim(AApiCode));
  Res.DateFrom := ADateFrom;
  Res.DateTo := ADateTo;
  // copii locale pentru metodele anonime
  Code := Res.ApiCode;
  FromDT := ADateFrom;
  ToDT := ADateTo;

  Config := LoadECCConfig(AConn, Res.ApiCode);
  Err := Config.Validate;
  if Err <> '' then
    raise EECCApiError.CreateHttp(0, Err);

  Client := Config.CreateClient;
  Store := TECCTransactionStore.Create(AConn);
  Journal := TDictionary<string, TJournalRow>.Create;
  SeenInEcc := TDictionary<string, Boolean>.Create;
  try
    // 1. bonurile din ECC (ale casei si ale terminalului ei)
    EccList := Client.ListReceipts(ADateFrom, IncSecond(ADateTo, -1));
    ForPos := nil;
    for Rc in EccList do
      if PosMatches(Rc.PosId) then
        ForPos := ForPos + [Rc];
    Res.EccCount := Length(ForPos);
    for Rc in ForPos do
      Res.EccTotal := Res.EccTotal + Rc.Total;

    // 2. jurnalul WMS al casei (o ora de toleranta la capete: ora bonului vine din ECC)
    Select(AConn,
      'SELECT T.TRANS_ID, T.KIND, T.STATE, T.SOURCE_TYPE, T.DOCID, T.SUMA, T.RECEIPT_NUMBER, T.Z_NUMBER, ' +
      '  COALESCE(T.ECC_DATETIME, T.CREATED_AT) AS WHEN_DT, ' +
      '  (SELECT COUNT(*) FROM TDB_DOCS_RECEIPT R WHERE R.ECC_TRANS_ID = T.TRANS_ID) AS WMS_ROWS, ' +
      '  (SELECT COALESCE(SUM(R.SUMA), 0) FROM TDB_DOCS_RECEIPT R WHERE R.ECC_TRANS_ID = T.TRANS_ID) AS WMS_SUMA ' +
      'FROM TFP_ECC_TRANSACTION T ' +
      'WHERE T.API_CODE = :C AND T.KIND IN (1, 5, 6) AND T.STATE IN (0, 1, 2) ' +
      '  AND COALESCE(T.ECC_DATETIME, T.CREATED_AT) >= :F AND COALESCE(T.ECC_DATETIME, T.CREATED_AT) < :T',
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('C').AsString := Code;
        Q.ParamByName('F').AsDateTime := IncHour(FromDT, -1);
        Q.ParamByName('T').AsDateTime := IncHour(ToDT, 1);
      end,
      procedure(Q: TIBCQuery)
      var
        R: TJournalRow;
      begin
        R.TransId := LowerCase(Trim(Q.FieldByName('TRANS_ID').AsString));
        R.Kind := Q.FieldByName('KIND').AsInteger;
        R.State := Q.FieldByName('STATE').AsInteger;
        R.SourceType := Q.FieldByName('SOURCE_TYPE').AsInteger;
        R.DocID := Q.FieldByName('DOCID').AsInteger;
        R.Suma := Q.FieldByName('SUMA').AsCurrency;
        R.ReceiptNumber := Q.FieldByName('RECEIPT_NUMBER').AsInteger;
        R.ZNumber := Q.FieldByName('Z_NUMBER').AsInteger;
        R.When := Q.FieldByName('WHEN_DT').AsDateTime;
        R.WmsRows := Q.FieldByName('WMS_ROWS').AsInteger;
        R.WmsSuma := Q.FieldByName('WMS_SUMA').AsCurrency;
        Journal.AddOrSetValue(R.TransId, R);
      end);

    // 3. fiecare bon din ECC fata de jurnal
    for Rc in ForPos do
    begin
      SeenInEcc.AddOrSetValue(LowerCase(Rc.Id), True);
      Row := Default(TECCReconcileRow);
      Row.TransId := LowerCase(Rc.Id);
      Row.ReceiptNumber := Rc.Number;
      Row.ZNumber := Rc.ZReportNumber;
      Row.DateTime := Rc.DateTime;
      Row.EccTotal := Rc.Total;

      if not Journal.TryGetValue(Row.TransId, J) then
      begin
        Row.Kind := erkOnlyInECC;
        Row.Note := 'Emis in afara WMS (interfata web ECC, terminal, alt program) - fara document WMS.';
        AddRow(Row);
        Continue;
      end;

      Inc(Res.JournalCount);
      Res.JournalTotal := Res.JournalTotal + J.Suma;
      Row.WmsTotal := J.Suma;
      Row.DocID := J.DocID;
      Row.SourceType := J.SourceType;

      if J.State <> eccStateDone then
      begin
        if AAutoFix then
        begin
          Store.MarkReceiptDone(Row.TransId, Rc, '');
          Row.Kind := erkFixed;
          Row.Note := 'In jurnal ramasese "' + ECCStateName(J.State) + '"; trecut in "emis".';
        end
        else
        begin
          Row.Kind := erkNotRegistered;
          Row.Note := 'Bonul exista in ECC, dar jurnalul a ramas "' + ECCStateName(J.State) + '".';
        end;
        AddRow(Row);
        if (J.SourceType >= eccSrcInvoice) and (J.SourceType <= eccSrcDelivery) and (J.WmsRows = 0) then
        begin
          Row.Kind := erkNotRegistered;
          Row.Note := 'Bon neinregistrat in TDB_DOCS_RECEIPT (' + ECCSourceTypeName(J.SourceType) + ').';
          AddRow(Row);
        end;
        Continue;
      end;

      if J.Suma <> Rc.Total then
      begin
        Row.Kind := erkSumMismatch;
        Row.Note := Format('Suma in jurnal %s, in ECC %s.', [ECCMoneyText(J.Suma), ECCMoneyText(Rc.Total)]);
        AddRow(Row);
        Continue;
      end;

      // diagnosticul nu se inregistreaza in WMS
      if (J.SourceType >= eccSrcInvoice) and (J.SourceType <= eccSrcDelivery) then
      begin
        if J.WmsRows = 0 then
        begin
          Row.Kind := erkNotRegistered;
          if (J.SourceType = eccSrcEcomm) or (J.SourceType = eccSrcMIA) then
            Row.Note := 'Bon online neinregistrat inca in WMS (il inregistreaza @ECC_ONLINE).'
          else
            Row.Note := 'Bon neinregistrat in TDB_DOCS_RECEIPT (' + ECCSourceTypeName(J.SourceType) + ').';
          AddRow(Row);
          Continue;
        end;
        if J.WmsSuma <> Rc.Total then
        begin
          Row.Kind := erkSumMismatch;
          Row.WmsTotal := J.WmsSuma;
          Row.Note := Format('In TDB_DOCS_RECEIPT %s, in ECC %s.', [ECCMoneyText(J.WmsSuma), ECCMoneyText(Rc.Total)]);
          AddRow(Row);
          Continue;
        end;
      end;

      Row.Kind := erkOk;
      AddRow(Row);
    end;

    // 4. jurnalul fara bon in ECC (doar cele din perioada exacta)
    for J in Journal.Values do
    begin
      if SeenInEcc.ContainsKey(J.TransId) or (J.When < ADateFrom) or (J.When >= ADateTo) then
        Continue;
      Row := Default(TECCReconcileRow);
      Row.TransId := J.TransId;
      Row.ReceiptNumber := J.ReceiptNumber;
      Row.ZNumber := J.ZNumber;
      Row.DateTime := J.When;
      Row.WmsTotal := J.Suma;
      Row.DocID := J.DocID;
      Row.SourceType := J.SourceType;
      Inc(Res.JournalCount);
      Res.JournalTotal := Res.JournalTotal + J.Suma;

      // bonul poate fi pe alt POS (ex. terminal neconfigurat) - se cauta direct dupa id
      if AAutoFix and (J.State <> eccStateDone) then
        try
          if Client.TryGetReceipt(J.TransId, Fresh) then
          begin
            Store.MarkReceiptDone(J.TransId, Fresh, Client.LastResponse);
            Row.Kind := erkFixed;
            Row.ReceiptNumber := Fresh.Number;
            Row.EccTotal := Fresh.Total;
            Row.Note := 'Gasit in ECC dupa id (alt POS / alta perioada); trecut in "emis".';
            AddRow(Row);
            Continue;
          end;
        except
          // se raporteaza mai jos
        end;

      Row.Kind := erkMissingInECC;
      if J.State = eccStateDone then
        Row.Note := 'In jurnal "emis", dar bonul nu apare in lista ECC a casei (verificati POS-ul / terminalul).'
      else
        Row.Note := 'In jurnal "' + ECCStateName(J.State) + '", fara bon in ECC: cererea nu a ajuns sau e inca in lucru.';
      AddRow(Row);
    end;

    // 5. rapoartele Z ale casei in perioada (informativ)
    for Closed := False to True do
      try
        Zs := Client.ListZReports(ADateFrom, IncSecond(ADateTo, -1), Closed, 1, 100);
        for Z in Zs do
          if (Z.PosId = '') or PosMatches(Z.PosId) then
          begin
            Row := Default(TECCReconcileRow);
            Row.Kind := erkInfo;
            Row.TransId := Z.Id;
            Row.ZNumber := Z.Number;
            Row.DateTime := Z.StartDateTime;
            Row.EccTotal := Z.Total;
            if Closed then
              Row.Note := Format('Raport Z nr. %d inchis, %d bonuri', [Z.Number, Z.Receipts])
            else
              Row.Note := Format('Raport Z nr. %d DESCHIS, %d bonuri', [Z.Number, Z.Receipts]);
            AddRow(Row);
          end;
      except
        // lista Z e informativa
      end;
  finally
    SeenInEcc.Free;
    Journal.Free;
    Store.Free;
    Client.Free;
  end;
  Result := Res;
end;

end.

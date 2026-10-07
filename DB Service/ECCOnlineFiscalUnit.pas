unit ECCOnlineFiscalUnit;

(* @ECC_ONLINE - fiscalizarea automata a platilor online pe casa ECC Fiscal Partner
   (faza 6 din Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md).

   Ruleaza in SWNService (sarcina "@ECC_ONLINE", de ex. la 5 minute). Un ciclu:
     1. finalizeaza ce a ramas din ciclurile anterioare: bonuri trimise fara
        rezultat (GET /receipt/{id}) si bonuri emise dar neinregistrate in WMS;
     2. plati MIA "Paid" fara comanda legata (DOCID gol): se raporteaza o singura
        data in jurnal ("fara document") si NU se fiscalizeaza; cind plata e legata
        de o comanda, se fiscalizeaza normal;
     3. plati noi reusite - TDB_ECOMM_TRANSACTIONS (card maib, STATUS = 1) si
        platile MIA confirmate - dupa ONLINE_FROM: bon fiscal pe casa ECC a
        firmei comenzii (FP_DEVICES DEVICE_TYPE = 1), liniile din
        GET_GOODS_FOR_RECEIPT(comanda), plata tip 7 (online / MIA).
   Platile MIA vin din view-ul VW_WEB_MIA_PAYMENTS (DB Model/mia_vb_payments.sql):
   maib (TWEB_MIA_QR_PAYMENTS) + Victoriabank (TWEB_MIA_VB_PAYMENT), cu banca in
   coloana BANK. Cit timp view-ul nu exista in baza, se citeste doar tabela maib,
   ca inainte. Referinta platii (SOURCE_REF) e identificatorul codului QR, unic
   intre banci, deci ambele raman SOURCE_TYPE = 4.
   Bonul emis se inregistreaza in TDB_DOCS_RECEIPT pe comanda web (134), legat de
   incasarea bancara 120 a comenzii daca exista deja; dialogul de bon al facturii
   urca pe lantul PARENTDOCID si vede bonul.

   Parametri in TS_API_CONFIG, API_CODE = 'ECC_ONLINE':
     ONLINE_FROM   'yyyy-mm-dd hh:nn:ss' - fara el job-ul nu fiscalizeaza nimic
     MAX_PER_RUN   cite bonuri noi pe ciclu (implicit 20)
   Protectii: jurnalul TFP_ECC_TRANSACTION se comite inainte de POST, un singur bon
   activ per plata (UQ_TFP_ECC_TRANS_SOURCE), maximum 3 incercari esuate per plata,
   suma liniilor trebuie sa fie egala cu plata. *)

interface

uses
  System.SysUtils, IBC;

procedure RunECCOnlineFiscal(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);

implementation

uses
  System.Classes, System.Generics.Collections, System.DateUtils, System.StrUtils, Data.DB, DBAccess, MemDS, IBCClasses,
  ECCApiClient, ECCConfigUnit, ECCTransactionStore;

const
  cOnlineApiCode = 'ECC_ONLINE';
  cDefaultMaxPerRun = 20;
  cMaxFailedAttempts = 3;
  cNotReceivedAfterMin = 10;    // STATE 0 fara bon in ECC dupa atitea minute = cererea nu a ajuns
  cReceiptWaitMs = 30000;
  cNoDocumentError = 'Plata MIA fara comanda legata (DOCID gol) - nu se fiscalizeaza pina nu e legata.';

  // sursa platilor MIA confirmate: REF, AMOUNT, DOCID, PAID_AT, BANK
  cMiaView = 'VW_WEB_MIA_PAYMENTS';
  cMiaSourceView = 'SELECT V.REF, V.AMOUNT, V.DOCID, V.PAID_AT, V.BANK FROM ' + cMiaView + ' V';
  cMiaSourceLegacy = 'SELECT TRIM(M.QRID) AS REF, M.AMOUNT, M.DOCID, M.UPDATED_AT AS PAID_AT, ''MAIB'' AS BANK ' +
    'FROM TWEB_MIA_QR_PAYMENTS M WHERE M.STATUS = ''Paid''';

type
  TOnlinePayment = record
    SourceType: Integer;
    SourceRef: string;
    Bank: string;          // doar la MIA: MAIB / VB
    DocID: Integer;
    FirmaID: Integer;
    Amount: Currency;
    PaidAt: TDateTime;
  end;

  TOnlineDevice = record
    FPID: Integer;
    ApiCode: string;
  end;

var
  // firma fara casa ECC -> ziua in care s-a scris deja in jurnal (o data pe zi, nu la fiecare ciclu);
  // un singur ciclu ruleaza odata (SWNService nu porneste sarcina cit e in curs)
  NoDeviceReported: TDictionary<Integer, TDate>;

type
  TECCOnlineJob = class
  private
    FConn: TIBCConnection;
    FUserID: Integer;
    FLog: TProc<string>;
    FStore: TECCTransactionStore;
    FOnlineFrom: TDateTime;
    FMaxPerRun: Integer;
    FDevices: TDictionary<Integer, TOnlineDevice>;
    FConfigs: TDictionary<string, TECCConfig>;
    FClients: TObjectDictionary<string, TECCApiClient>;
    FIssued, FPending, FErrors, FRegistered, FNoDocument: Integer;
    procedure Log(const AText: string);
    procedure Select(const ASQL: string; const ASetup, ARow: TProc<TIBCQuery>);
    function LoadSettings: Boolean;
    procedure LoadDevices;
    function GetConfig(const AApiCode: string; out AConfig: TECCConfig): Boolean;
    function GetClient(const AApiCode: string): TECCApiClient;
    function MiaSourceSQL: string;
    function LoadPayments: TArray<TOnlinePayment>;
    procedure ReportNoDocument(const P: TOnlinePayment);
    procedure Fiscalize(const P: TOnlinePayment);
    procedure FailPayment(const P: TOnlinePayment; const AApiCode, AError: string; const AFPID: Integer);
    procedure ResolvePending;
    function RegisterInWms(const ATransId: string): Boolean;
  public
    constructor Create(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
    destructor Destroy; override;
    procedure Run;
  end;

{ TECCOnlineJob }

constructor TECCOnlineJob.Create(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
begin
  inherited Create;
  FConn := AConn;
  FUserID := AUserID;
  FLog := ALog;
  FStore := TECCTransactionStore.Create(AConn);
  FDevices := TDictionary<Integer, TOnlineDevice>.Create;
  FConfigs := TDictionary<string, TECCConfig>.Create;
  FClients := TObjectDictionary<string, TECCApiClient>.Create([doOwnsValues]);
end;

destructor TECCOnlineJob.Destroy;
begin
  FClients.Free;
  FConfigs.Free;
  FDevices.Free;
  FStore.Free;
  inherited;
end;

procedure TECCOnlineJob.Log(const AText: string);
begin
  if Assigned(FLog) then
    FLog(AText);
end;

procedure TECCOnlineJob.Select(const ASQL: string; const ASetup, ARow: TProc<TIBCQuery>);
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

function TECCOnlineJob.LoadSettings: Boolean;
var
  FromText: string;
  MaxText: string;
begin
  FromText := '';
  MaxText := '';
  Select('SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG WHERE API_CODE = :C AND FLG_ACTIVE = 1',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('C').AsString := cOnlineApiCode;
    end,
    procedure(Q: TIBCQuery)
    var
      N: string;
    begin
      N := UpperCase(Trim(Q.FieldByName('PARAM_NAME').AsString));
      if N = 'ONLINE_FROM' then
        FromText := Trim(Q.FieldByName('PARAM_VALUE').AsString)
      else if N = 'MAX_PER_RUN' then
        MaxText := Trim(Q.FieldByName('PARAM_VALUE').AsString);
    end);

  FMaxPerRun := StrToIntDef(MaxText, cDefaultMaxPerRun);
  if FMaxPerRun <= 0 then
    FMaxPerRun := cDefaultMaxPerRun;

  FOnlineFrom := 0;
  if (FromText <> '') and not TryISO8601ToDate(StringReplace(FromText, ' ', 'T', []), FOnlineFrom, False) then
    FOnlineFrom := 0;
  Result := FOnlineFrom > 0;
  if not Result then
    Log('Nu se fiscalizeaza nimic: in Setari > Configurari API lipseste ' + cOnlineApiCode +
      ' / ONLINE_FROM (de ex. 2026-10-01 00:00:00) sau are alt format.');
end;

procedure TECCOnlineJob.LoadDevices;
begin
  FDevices.Clear;
  // casa ECC a firmei: rindul fara statie are prioritate (plata online nu vine de pe o statie)
  Select('SELECT FIRMA_ID, FP_ID, ECC_API_CODE FROM FP_DEVICES ' +
    'WHERE DEVICE_TYPE = 1 AND FLG_ENABLED = 1 AND ECC_API_CODE IS NOT NULL ' +
    'ORDER BY CASE WHEN WS_ID IS NULL THEN 0 ELSE 1 END, FP_ID', nil,
    procedure(Q: TIBCQuery)
    var
      D: TOnlineDevice;
      Firma: Integer;
    begin
      Firma := Q.FieldByName('FIRMA_ID').AsInteger;
      if FDevices.ContainsKey(Firma) then
        Exit;
      D.FPID := Q.FieldByName('FP_ID').AsInteger;
      D.ApiCode := UpperCase(Trim(Q.FieldByName('ECC_API_CODE').AsString));
      FDevices.Add(Firma, D);
    end);
end;

function TECCOnlineJob.GetConfig(const AApiCode: string; out AConfig: TECCConfig): Boolean;
var
  Err: string;
begin
  if not FConfigs.TryGetValue(AApiCode, AConfig) then
  begin
    AConfig := LoadECCConfig(FConn, AApiCode);
    FConfigs.Add(AApiCode, AConfig);
    Err := AConfig.Validate;
    if Err <> '' then
      Log('Casa ' + AApiCode + ': ' + Err);
  end;
  Result := AConfig.Validate = '';
end;

function TECCOnlineJob.GetClient(const AApiCode: string): TECCApiClient;
var
  Config: TECCConfig;
begin
  if not FClients.TryGetValue(AApiCode, Result) then
  begin
    if not GetConfig(AApiCode, Config) then
      Exit(nil);
    Result := Config.CreateClient;
    Result.ConnectionTimeout := 10000;
    Result.ResponseTimeout := 30000;
    FClients.Add(AApiCode, Result);
  end;
end;

// 'MAIB' / 'VB' din view -> numele din jurnal
function MiaBankName(const ABank: string): string;
begin
  if ABank = 'VB' then
    Result := 'Victoriabank'
  else if ABank = 'MAIB' then
    Result := 'maib'
  else
    Result := ABank;
end;

// View-ul comun daca exista; altfel doar tabela maib. Se verifica la fiecare ciclu:
// scriptul poate fi rulat pe baza cu serviciul pornit.
function TECCOnlineJob.MiaSourceSQL: string;
var
  HasView: Boolean;
begin
  HasView := False;
  Select('SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ''' + cMiaView + '''', nil,
    procedure(Q: TIBCQuery)
    begin
      HasView := Q.Fields[0].AsInteger > 0;
    end);
  if HasView then
    Result := cMiaSourceView
  else
    Result := cMiaSourceLegacy;
end;

function TECCOnlineJob.LoadPayments: TArray<TOnlinePayment>;
var
  List: TArray<TOnlinePayment>;
begin
  List := nil;

  // card maib (ecomm), legat mereu de comanda web
  Select(
    'SELECT TRIM(E.TRANSACTIONID) AS REF, E.AMOUNT, E.DOCID, E.REGISTERDATE, D.DT ' +
    'FROM TDB_ECOMM_TRANSACTIONS E ' +
    'INNER JOIN TDB_DOCS D ON D.DOCID = E.DOCID ' +
    'WHERE E.STATUS = 1 AND E.REGISTERDATE >= :FROM_DT ' +
    '  AND NOT EXISTS (SELECT 1 FROM TFP_ECC_TRANSACTION T WHERE T.SOURCE_TYPE = 3 ' +
    '                  AND T.SOURCE_REF = TRIM(E.TRANSACTIONID) AND T.STATE IN (0, 1, 2)) ' +
    '  AND (SELECT COUNT(*) FROM TFP_ECC_TRANSACTION T WHERE T.SOURCE_TYPE = 3 ' +
    '       AND T.SOURCE_REF = TRIM(E.TRANSACTIONID) AND T.STATE = 3) < :MAX_FAILED ' +
    'ORDER BY E.REGISTERDATE',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('FROM_DT').AsDateTime := FOnlineFrom;
      Q.ParamByName('MAX_FAILED').AsInteger := cMaxFailedAttempts;
    end,
    procedure(Q: TIBCQuery)
    var
      P: TOnlinePayment;
    begin
      P.SourceType := eccSrcEcomm;
      P.SourceRef := Q.FieldByName('REF').AsString;
      P.DocID := Q.FieldByName('DOCID').AsInteger;
      P.FirmaID := Q.FieldByName('DT').AsInteger;
      P.Amount := Q.FieldByName('AMOUNT').AsCurrency;
      P.PaidAt := Q.FieldByName('REGISTERDATE').AsDateTime;
      List := List + [P];
    end);

  // QR MIA (maib + Victoriabank): fara comanda legata se raporteaza o singura data
  Select(
    'SELECT Q.REF, Q.AMOUNT, Q.DOCID, Q.PAID_AT, Q.BANK, D.DT ' +
    'FROM (' + MiaSourceSQL + ') Q ' +
    'LEFT JOIN TDB_DOCS D ON D.DOCID = Q.DOCID ' +
    'WHERE Q.PAID_AT >= :FROM_DT ' +
    '  AND NOT EXISTS (SELECT 1 FROM TFP_ECC_TRANSACTION T WHERE T.SOURCE_TYPE = 4 ' +
    '                  AND T.SOURCE_REF = Q.REF AND T.STATE IN (0, 1, 2)) ' +
    '  AND (D.DOCID IS NOT NULL OR NOT EXISTS (SELECT 1 FROM TFP_ECC_TRANSACTION T ' +
    '       WHERE T.SOURCE_TYPE = 4 AND T.SOURCE_REF = Q.REF)) ' +
    '  AND (SELECT COUNT(*) FROM TFP_ECC_TRANSACTION T WHERE T.SOURCE_TYPE = 4 ' +
    '       AND T.SOURCE_REF = Q.REF AND T.STATE = 3) < :MAX_FAILED ' +
    'ORDER BY Q.PAID_AT',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('FROM_DT').AsDateTime := FOnlineFrom;
      Q.ParamByName('MAX_FAILED').AsInteger := cMaxFailedAttempts;
    end,
    procedure(Q: TIBCQuery)
    var
      P: TOnlinePayment;
    begin
      P.SourceType := eccSrcMIA;
      P.SourceRef := Trim(Q.FieldByName('REF').AsString);
      P.Bank := UpperCase(Trim(Q.FieldByName('BANK').AsString));
      P.DocID := Q.FieldByName('DOCID').AsInteger;   // 0 = fara comanda (LEFT JOIN)
      P.FirmaID := Q.FieldByName('DT').AsInteger;
      P.Amount := Q.FieldByName('AMOUNT').AsCurrency;
      P.PaidAt := Q.FieldByName('PAID_AT').AsDateTime;
      List := List + [P];
    end);

  Result := List;
end;

procedure TECCOnlineJob.FailPayment(const P: TOnlinePayment; const AApiCode, AError: string; const AFPID: Integer);
var
  T: TECCTransaction;
begin
  // rind de eroare definitiva: tine evidenta incercarilor (max cMaxFailedAttempts)
  T := Default(TECCTransaction);
  T.TransId := NewECCId;
  T.ApiCode := AApiCode;
  T.FPID := AFPID;
  T.FirmaID := P.FirmaID;
  T.Kind := eccKindReceipt;
  T.SourceType := P.SourceType;
  T.SourceRef := P.SourceRef;
  T.DocID := P.DocID;
  T.Suma := P.Amount;
  T.PayType := eccPayOnline;
  T.UserID := FUserID;
  FStore.AddNew(T);
  FStore.MarkError(T.TransId, AError, True);
  Inc(FErrors);
  Log(Format('EROARE plata %d/%s (comanda %d, %s lei): %s',
    [P.SourceType, P.SourceRef, P.DocID, ECCMoneyText(P.Amount), AError]));
end;

procedure TECCOnlineJob.ReportNoDocument(const P: TOnlinePayment);
var
  T: TECCTransaction;
begin
  T := Default(TECCTransaction);
  T.TransId := NewECCId;
  T.ApiCode := cOnlineApiCode;
  T.Kind := eccKindReceipt;
  T.SourceType := P.SourceType;
  T.SourceRef := P.SourceRef;
  T.Suma := P.Amount;
  T.PayType := eccPayOnline;
  T.UserID := FUserID;
  FStore.AddNew(T);
  FStore.MarkError(T.TransId, cNoDocumentError, True);
  Inc(FNoDocument);
  Log(Format('Plata MIA %s %s de %s lei din %s nu are comanda legata - nefiscalizata, de verificat manual.',
    [MiaBankName(P.Bank), P.SourceRef, ECCMoneyText(P.Amount), FormatDateTime('dd.mm.yyyy hh:nn', P.PaidAt)]));
end;

procedure TECCOnlineJob.Fiscalize(const P: TOnlinePayment);
var
  Device: TOnlineDevice;
  Config: TECCConfig;
  Client: TECCApiClient;
  Req: TECCReceiptRequest;
  T: TECCTransaction;
  Receipt: TECCReceipt;
  LineError: string;
  Final: Boolean;
  DocID: Integer;
begin
  DocID := P.DocID;   // parametrii const nu se captureaza in metode anonime
  if not FDevices.TryGetValue(P.FirmaID, Device) then
  begin
    // firma fara casa ECC: plata ramine nefiscalizata, fara rind in jurnal (se reverifica)
    if not NoDeviceReported.ContainsKey(P.FirmaID) or (NoDeviceReported[P.FirmaID] <> Date) then
    begin
      NoDeviceReported.AddOrSetValue(P.FirmaID, Date);
      Log(Format('Firma %d nu are casa ECC activa in FP_DEVICES - platile ei online nu se fiscalizeaza.',
        [P.FirmaID]));
    end;
    Exit;
  end;
  if not GetConfig(Device.ApiCode, Config) then
    Exit;
  Client := GetClient(Device.ApiCode);
  if Client = nil then
    Exit;

  // liniile comenzii web, ca la bonul din factura
  Req.Init(Config.PosId, Config.PosName, Config.CashierName);
  LineError := '';
  Select('SELECT NAMEACNT, QTY, PRICE, SUMAVAT FROM GET_GOODS_FOR_RECEIPT(:DOCID)',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('DOCID').AsInteger := DocID;
    end,
    procedure(Q: TIBCQuery)
    var
      Qty: Double;
      Price, Suma, SumaVat: Currency;
      Vat: Integer;
    begin
      if LineError <> '' then
        Exit;
      Qty := Q.FieldByName('QTY').AsFloat;
      Price := Q.FieldByName('PRICE').AsCurrency;
      Suma := ECCRoundMoney(Price * Qty);
      SumaVat := Q.FieldByName('SUMAVAT').AsCurrency;
      if (SumaVat > 0) and (Suma - SumaVat > 0) then
        Vat := Round(100 * SumaVat / (Suma - SumaVat))
      else
        Vat := 0;
      try
        Req.AddLineTotal(Trim(Q.FieldByName('NAMEACNT').AsString), Qty, Suma, Config.TaxCodeFor(Vat));
      except
        on E: Exception do
          LineError := E.Message;
      end;
    end);
  if LineError <> '' then
  begin
    FailPayment(P, Device.ApiCode, LineError, Device.FPID);
    Exit;
  end;
  if Length(Req.Articles) = 0 then
  begin
    FailPayment(P, Device.ApiCode, Format('Comanda %d nu are linii pentru bon.', [P.DocID]), Device.FPID);
    Exit;
  end;
  if Req.Total <> P.Amount then
  begin
    FailPayment(P, Device.ApiCode, Format('Suma comenzii %d (%s) difera de plata (%s) - bonul se face manual.',
      [P.DocID, ECCMoneyText(Req.Total), ECCMoneyText(P.Amount)]), Device.FPID);
    Exit;
  end;
  Req.AddPayment(eccPayOnline, P.Amount);
  LineError := Req.Validate;
  if LineError <> '' then
  begin
    FailPayment(P, Device.ApiCode, LineError, Device.FPID);
    Exit;
  end;

  // jurnalul, comis INAINTE de trimitere
  T := Default(TECCTransaction);
  T.TransId := Req.Id;
  T.ApiCode := Device.ApiCode;
  T.FPID := Device.FPID;
  T.FirmaID := P.FirmaID;
  T.Kind := eccKindReceipt;
  T.SourceType := P.SourceType;
  T.SourceRef := P.SourceRef;
  T.DocID := P.DocID;
  T.Suma := P.Amount;
  T.PayType := eccPayOnline;
  T.CashierName := Config.CashierName;
  T.RequestJSON := Req.ToJSON;
  T.UserID := FUserID;
  FStore.AddNew(T);

  try
    Client.PostReceipt(Req);
  except
    on E: Exception do
    begin
      Final := (E is EECCApiError) and (EECCApiError(E).HttpCode >= 400) and (EECCApiError(E).HttpCode < 500);
      FStore.MarkError(Req.Id, E.Message, Final);
      if Final then
      begin
        Inc(FErrors);
        Log(Format('EROARE comanda %d (%s lei): ECC a refuzat bonul: %s', [P.DocID, ECCMoneyText(P.Amount),
          E.Message]));
      end
      else
      begin
        Inc(FPending);
        Log(Format('Comanda %d: legatura cu ECC a cazut (%s); se verifica la ciclul urmator (id %s).',
          [P.DocID, E.Message, Req.Id]));
      end;
      Exit;
    end;
  end;
  FStore.MarkSent(Req.Id);

  if not Client.WaitReceipt(Req.Id, Receipt, cReceiptWaitMs, 1000) then
  begin
    Inc(FPending);
    Log(Format('Comanda %d: bonul trimis (id %s), rezultatul inca lipseste - se verifica la ciclul urmator.',
      [P.DocID, Req.Id]));
    Exit;
  end;
  FStore.MarkReceiptDone(Req.Id, Receipt, Client.LastResponse);
  Inc(FIssued);
  Log(Format('Bon ECC nr. %d (Z %d) pentru comanda %d, %s lei, plata %s %s; MEV: %s',
    [Receipt.Number, Receipt.ZReportNumber, P.DocID, ECCMoneyText(P.Amount),
     IfThen(P.SourceType = eccSrcEcomm, 'card maib', 'MIA ' + MiaBankName(P.Bank)), P.SourceRef, Receipt.MevLink]));
  RegisterInWms(Req.Id);
end;

// Rindul din TDB_DOCS_RECEIPT pe comanda web + legatura cu incasarea bancara 120, daca exista.
function TECCOnlineJob.RegisterInWms(const ATransId: string): Boolean;
var
  T: TECCTransaction;
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  PrihodDocID: Integer;
begin
  Result := False;
  if not FStore.Load(ATransId, T) or (T.State <> eccStateDone) or T.Registered then
    Exit;
  if (T.DocID <= 0) or (T.ReceiptNumber <= 0) then
  begin
    Log(Format('Bonul %s nu se poate inregistra in WMS: lipseste comanda sau numarul bonului.', [ATransId]));
    Exit;
  end;

  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConn;
    Q.Connection := FConn;
    Q.Transaction := Tr;
    Tr.StartTransaction;
    try
      PrihodDocID := 0;
      Q.SQL.Text := 'SELECT FIRST 1 DOCID FROM TDB_DOCS WHERE PARENTDOCID = :DOCID AND DOCTYPEID = 120 ' +
        'AND SUMA = :SUMA ORDER BY DOCID';
      Q.ParamByName('DOCID').AsInteger := T.DocID;
      Q.ParamByName('SUMA').AsCurrency := T.Suma;
      Q.Open;
      if not Q.Eof then
        PrihodDocID := Q.Fields[0].AsInteger;
      Q.Close;

      // FLAGS 0: persoana fizica, bon complet, fara numerar
      Q.SQL.Text := 'INSERT INTO TDB_DOCS_RECEIPT (DOCID, NUMAR_BON, FLAGS, DATA_ELIBERARII, USERID, SUMA, ' +
        'PRIHOD_DOCID, FP_ID, ECC_TRANS_ID) VALUES (:DOCID, :NR, 0, :DT, :USERID, :SUMA, :PRIHOD, :FP_ID, :ID)';
      Q.ParamByName('DOCID').AsInteger := T.DocID;
      Q.ParamByName('NR').AsInteger := T.ReceiptNumber;
      if T.EccDateTime > 0 then
        Q.ParamByName('DT').AsDateTime := T.EccDateTime
      else
        Q.ParamByName('DT').AsDateTime := Now;
      if FUserID > 0 then
        Q.ParamByName('USERID').AsInteger := FUserID
      else
      begin
        Q.ParamByName('USERID').DataType := ftInteger;
        Q.ParamByName('USERID').Clear;
      end;
      Q.ParamByName('SUMA').AsCurrency := T.Suma;
      if PrihodDocID > 0 then
        Q.ParamByName('PRIHOD').AsInteger := PrihodDocID
      else
      begin
        Q.ParamByName('PRIHOD').DataType := ftInteger;
        Q.ParamByName('PRIHOD').Clear;
      end;
      if T.FPID > 0 then
        Q.ParamByName('FP_ID').AsInteger := T.FPID
      else
      begin
        Q.ParamByName('FP_ID').DataType := ftInteger;
        Q.ParamByName('FP_ID').Clear;
      end;
      Q.ParamByName('ID').AsString := T.TransId;
      Q.ExecSQL;

      Q.SQL.Text := 'UPDATE TFP_ECC_TRANSACTION SET FLG_REGISTERED = 1 WHERE TRANS_ID = :ID';
      Q.ParamByName('ID').AsString := T.TransId;
      Q.ExecSQL;
      Tr.Commit;
      Result := True;
      Inc(FRegistered);
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        Log(Format('Bonul ECC %s (nr. %d, comanda %d) NU a fost inregistrat in WMS: %s',
          [T.TransId, T.ReceiptNumber, T.DocID, E.Message]));
      end;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

procedure TECCOnlineJob.ResolvePending;
var
  List: TArray<TECCTransaction>;
  T: TECCTransaction;
  Client: TECCApiClient;
  Receipt: TECCReceipt;
begin
  List := FStore.ListPending('');
  for T in List do
  begin
    // doar bonurile platilor online; cele din WMS / POS le rezolva casierul
    if not ((T.SourceType = eccSrcEcomm) or (T.SourceType = eccSrcMIA)) or (T.Kind <> eccKindReceipt) then
      Continue;

    if T.State = eccStateDone then
    begin
      RegisterInWms(T.TransId);
      Continue;
    end;

    Client := GetClient(T.ApiCode);
    if Client = nil then
      Continue;
    try
      if Client.TryGetReceipt(T.TransId, Receipt) then
      begin
        FStore.MarkReceiptDone(T.TransId, Receipt, Client.LastResponse);
        Inc(FIssued);
        Log(Format('Bon ECC nr. %d pentru comanda %d gasit dupa id %s (ciclu anterior).',
          [Receipt.Number, T.DocID, T.TransId]));
        RegisterInWms(T.TransId);
      end
      else if (T.State = eccStateNew) and (MinutesBetween(Now, T.CreatedAt) >= cNotReceivedAfterMin) then
      begin
        // cererea nu a ajuns niciodata la ECC: eroare definitiva -> plata se reincearca (max 3)
        FStore.MarkError(T.TransId, 'Cererea nu a ajuns la ECC (fara bon dupa ' +
          IntToStr(cNotReceivedAfterMin) + ' min).', True);
        Log(Format('Comanda %d: cererea %s nu a ajuns la ECC - se reincearca.', [T.DocID, T.TransId]));
      end
      else
        Inc(FPending);
    except
      on E: Exception do
      begin
        Inc(FPending);
        Log(Format('Verificarea bonului %s (comanda %d) a esuat: %s', [T.TransId, T.DocID, E.Message]));
      end;
    end;
  end;
end;

procedure TECCOnlineJob.Run;
var
  Payments: TArray<TOnlinePayment>;
  P: TOnlinePayment;
  Done: Integer;
begin
  if not TECCTransactionStore.Available(FConn) then
  begin
    Log('Jurnalul TFP_ECC_TRANSACTION lipseste (DB Model/ecc_fiscalpartner.sql) - job-ul nu face nimic.');
    Exit;
  end;
  if not LoadSettings then
    Exit;
  LoadDevices;

  ResolvePending;

  Payments := LoadPayments;
  Done := 0;
  for P in Payments do
  begin
    if P.DocID <= 0 then
    begin
      ReportNoDocument(P);
      Continue;
    end;
    if Done >= FMaxPerRun then
      Break;
    try
      Fiscalize(P);
    except
      on E: Exception do
      begin
        Inc(FErrors);
        Log(Format('EROARE neasteptata la plata %d/%s (comanda %d): %s: %s',
          [P.SourceType, P.SourceRef, P.DocID, E.ClassName, E.Message]));
      end;
    end;
    Inc(Done);
  end;

  if (FIssued + FPending + FErrors + FRegistered + FNoDocument) > 0 then
    Log(Format('Ciclu terminat: %d bonuri emise, %d inregistrate in WMS, %d in asteptare, %d erori, ' +
      '%d plati MIA fara comanda.', [FIssued, FRegistered, FPending, FErrors, FNoDocument]));
end;

procedure RunECCOnlineFiscal(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
var
  Job: TECCOnlineJob;
begin
  Job := TECCOnlineJob.Create(AConn, AUserID, ALog);
  try
    Job.Run;
  finally
    Job.Free;
  end;
end;

initialization
  NoDeviceReported := TDictionary<Integer, TDate>.Create;

finalization
  NoDeviceReported.Free;

end.

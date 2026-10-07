unit ECCDeliveryUnit;

(* Livrarea prin curierii ECC Fiscal Partner (faza 7 din
   Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md). Fara VCL.

   ECCSendDelivery - butonul "Trimite la curier (ECC)" din cadrul de livrare:
     doar Vinzare 107, doar plata la livrare (numerar sau card, fara credit);
     casa ECC a firmei documentului (FP_DEVICES DEVICE_TYPE = 1);
     curierul = COURIERID al livrarii, legat de casierul ECC in TFP_ECC_CASHIER
     (DRIVERID = COURIERID, CASHIER_ID, POS_ID = telefonul curierului);
     liniile din GET_GOODS_FOR_RECEIPT(107); jurnalul (KIND 6, SOURCE_TYPE 5,
     SOURCE_REF = DOCID) se comite inainte de POST /delivery.
   ECCProcessDeliveries - job-ul @ECC_DELIVERY din SWNService:
     urmareste starea livrarilor trimise (GET /delivery/{id});
     cancelled -> anulat; completed -> bonul emis de curier se cauta dupa id, apoi
     in lista bonurilor telefonului (aceeasi suma, neluat de alt rind din jurnal);
     inregistrarea in WMS, intr-o singura tranzactie: SP_CREATE_RECEIPT3 (incasare
     116 numerar / 120 card sub vinzare + factura 112 daca lipseste + rind in
     TDB_DOCS_RECEIPT), legatura ECC_TRANS_ID si FLG_REGISTERED.
     Daca suma bonului difera de comanda (curierul a scos articole), bonul se
     inregistreaza cu suma lui ca bon partial si documentele se corecteaza manual. *)

interface

uses
  System.SysUtils, IBC;

// Trimite livrarea documentului la curier. Intoarce textul pentru utilizator;
// ridica exceptie cind livrarea nu poate fi trimisa (nimic trimis).
function ECCSendDelivery(AConn: TIBCConnection; const ADocID, AUserID: Integer): string;

procedure ECCProcessDeliveries(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);

implementation

uses
  System.Classes, System.Generics.Collections, System.DateUtils, System.StrUtils, System.JSON, Data.DB, DBAccess, MemDS,
  IBCClasses, ECCApiClient, ECCConfigUnit, ECCTransactionStore;

const
  cDocTypeSale = 107;
  cNotReceivedAfterMin = 10;

type
  EECCDeliveryError = class(Exception);

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

function ECCSendDelivery(AConn: TIBCConnection; const ADocID, AUserID: Integer): string;
var
  DocType, FirmaID, ClientID, CourierID, FPID: Integer;
  FlgCash, FlgCard, FlgCredit: Boolean;
  Address, Phone, Notes, ClientName, CourierName, ApiCode: string;
  CashierId, CashierName, CourierPosId, LineError: string;
  Config: TECCConfig;
  Client: TECCApiClient;
  Store: TECCTransactionStore;
  Req: TECCReceiptRequest;
  D: TECCDeliveryInfo;
  T, Existing: TECCTransaction;
  DocID: Integer;
  Final, Found: Boolean;
begin
  DocID := ADocID;
  DocType := 0;
  FirmaID := 0;
  ClientID := 0;
  Select(AConn, 'SELECT DOCTYPEID, DT, CT FROM TDB_DOCS WHERE DOCID = :D',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('D').AsInteger := DocID;
    end,
    procedure(Q: TIBCQuery)
    begin
      DocType := Q.FieldByName('DOCTYPEID').AsInteger;
      FirmaID := Q.FieldByName('DT').AsInteger;
      ClientID := Q.FieldByName('CT').AsInteger;
    end);
  if DocType <> cDocTypeSale then
    raise EECCDeliveryError.Create('Livrarea prin curierul ECC se trimite doar din Vinzare (107); ' +
      'documentul curent are tipul ' + IntToStr(DocType) + '.');

  // livrarea
  Found := False;
  CourierID := 0;
  FlgCash := False;
  FlgCard := False;
  FlgCredit := False;
  Select(AConn, 'SELECT COURIERID, COURIER_NAME, DELIVERY_ADDRESS, PHONE_NUMBER, COMMENTS, FLG_CASHONDELIVERY, ' +
    'FLG_POS_TERMINAL, FLG_CREDIT FROM VW_TDB_DOCS_DELIVERY WHERE DOCID = :D',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('D').AsInteger := DocID;
    end,
    procedure(Q: TIBCQuery)
    begin
      Found := True;
      CourierID := Q.FieldByName('COURIERID').AsInteger;
      CourierName := Trim(Q.FieldByName('COURIER_NAME').AsString);
      Address := Trim(Q.FieldByName('DELIVERY_ADDRESS').AsString);
      Phone := Trim(Q.FieldByName('PHONE_NUMBER').AsString);
      Notes := Trim(Q.FieldByName('COMMENTS').AsString);
      FlgCash := Q.FieldByName('FLG_CASHONDELIVERY').AsInteger = 1;
      FlgCard := Q.FieldByName('FLG_POS_TERMINAL').AsInteger = 1;
      FlgCredit := Q.FieldByName('FLG_CREDIT').AsInteger = 1;
    end);
  if not Found then
    raise EECCDeliveryError.Create('Documentul nu are livrare (salvati intii datele livrarii).');
  if FlgCredit or not (FlgCash or FlgCard) then
    raise EECCDeliveryError.Create('La curierul ECC se trimit doar livrarile cu plata la livrare ' +
      '(bifati "Numerar" sau "Card bancar", fara "Credit").');
  if FlgCash and FlgCard then
    raise EECCDeliveryError.Create('Bifati un singur mod de plata la livrare: "Numerar" sau "Card bancar".');

  // casa ECC a firmei
  ApiCode := '';
  FPID := 0;
  Select(AConn, 'SELECT FIRST 1 FP_ID, ECC_API_CODE FROM FP_DEVICES WHERE FIRMA_ID = :F AND DEVICE_TYPE = 1 ' +
    'AND FLG_ENABLED = 1 AND ECC_API_CODE IS NOT NULL ORDER BY CASE WHEN WS_ID IS NULL THEN 0 ELSE 1 END, FP_ID',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('F').AsInteger := FirmaID;
    end,
    procedure(Q: TIBCQuery)
    begin
      FPID := Q.FieldByName('FP_ID').AsInteger;
      ApiCode := UpperCase(Trim(Q.FieldByName('ECC_API_CODE').AsString));
    end);
  if ApiCode = '' then
    raise EECCDeliveryError.Create('Firma documentului nu are casa ECC activa (Nomenclatoare > MCC).');
  Config := LoadECCConfig(AConn, ApiCode);
  LineError := Config.Validate;
  if LineError <> '' then
    raise EECCDeliveryError.Create(LineError);

  // curierul -> casierul ECC
  CashierId := '';
  CashierName := '';
  CourierPosId := '';
  Select(AConn, 'SELECT FIRST 1 CASHIER_ID, CASHIER_NAME, POS_ID FROM TFP_ECC_CASHIER WHERE API_CODE = :A ' +
    'AND DRIVERID = :C AND FLG_ACTIVE = 1 AND CASHIER_ID IS NOT NULL',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('A').AsString := ApiCode;
      Q.ParamByName('C').AsInteger := CourierID;
    end,
    procedure(Q: TIBCQuery)
    begin
      CashierId := Trim(Q.FieldByName('CASHIER_ID').AsString);
      CashierName := Trim(Q.FieldByName('CASHIER_NAME').AsString);
      CourierPosId := Trim(Q.FieldByName('POS_ID').AsString);
    end);
  if CashierId = '' then
    raise EECCDeliveryError.CreateFmt('Curierul "%s" nu e legat de un casier ECC al casei %s ' +
      '(Casa ECC - diagnostic > Curieri ECC).', [CourierName, ApiCode]);
  if CourierPosId = '' then
    CourierPosId := Config.PosId;

  ClientName := '';
  Select(AConn, 'SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID = :C',
    procedure(Q: TIBCQuery)
    begin
      Q.ParamByName('C').AsInteger := ClientID;
    end,
    procedure(Q: TIBCQuery)
    begin
      ClientName := Trim(Q.FieldByName('DISPLAYNAME').AsString);
    end);

  Store := TECCTransactionStore.Create(AConn);
  Client := nil;
  try
    if Store.FindActiveBySource(eccSrcDelivery, IntToStr(DocID), Existing) then
      raise EECCDeliveryError.CreateFmt('Livrarea a fost deja trimisa la curier (stare: %s, %s). ' +
        'O livrare noua se poate trimite doar dupa anularea celei vechi.',
        [ECCStateName(Existing.State), Existing.OrderStatus]);

    // liniile vinzarii
    Req.Init(CourierPosId, '', CashierName);
    LineError := '';
    Select(AConn, 'SELECT NAMEACNT, QTY, PRICE, SUMAVAT FROM GET_GOODS_FOR_RECEIPT(:D)',
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('D').AsInteger := DocID;
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
      raise EECCDeliveryError.Create(LineError);
    if Length(Req.Articles) = 0 then
      raise EECCDeliveryError.Create('Vinzarea nu are linii pentru bon.');

    D := Default(TECCDeliveryInfo);
    D.CashierId := CashierId;
    D.ClientName := ClientName;
    D.ClientPhone := Phone;
    D.Address := Address;
    D.Notes := Notes;
    if FlgCard then
      D.PaymentType := eccPayCard
    else
      D.PaymentType := eccPayCash;

    // jurnalul, comis INAINTE de trimitere
    T := Default(TECCTransaction);
    T.TransId := Req.Id;
    T.ApiCode := ApiCode;
    T.FPID := FPID;
    T.FirmaID := FirmaID;
    T.Kind := eccKindDelivery;
    T.SourceType := eccSrcDelivery;
    T.SourceRef := IntToStr(DocID);
    T.DocID := DocID;
    T.Suma := Req.Total;
    T.PayType := D.PaymentType;
    T.CashierName := CashierName;
    T.RequestJSON := Req.ToDeliveryJSON(D);
    T.UserID := AUserID;
    Store.AddNew(T);

    Client := Config.CreateClient;
    try
      Client.NewDelivery(Req, D);
    except
      on E: Exception do
      begin
        Final := (E is EECCApiError) and (EECCApiError(E).HttpCode >= 400) and (EECCApiError(E).HttpCode < 500);
        Store.MarkError(Req.Id, E.Message, Final);
        if Final then
          raise EECCDeliveryError.Create('ECC a refuzat livrarea: ' + E.Message);
        raise EECCDeliveryError.Create('Legatura cu ECC s-a intrerupt: ' + E.Message + '. Nu retrimiteti: ' +
          'livrarea se verifica automat (Casa ECC - diagnostic > Jurnal, id ' + Req.Id + ').');
      end;
    end;
    Store.MarkSent(Req.Id);
    Store.SetOrderStatus(Req.Id, 'pending');
    Result := Format('Livrarea (%s lei, plata %s) a fost trimisa curierului %s in aplicatia ECC. ' +
      'Bonul il emite curierul la predare; incasarea si bonul apar in WMS automat dupa finalizare.',
      [ECCMoneyText(Req.Total), ECCPayTypeName(D.PaymentType), CashierName]);
  finally
    Client.Free;
    Store.Free;
  end;
end;

{ ---------------- job-ul @ECC_DELIVERY ---------------- }

type
  TDeliveryJob = class
  private
    FConn: TIBCConnection;
    FUserID: Integer;
    FLog: TProc<string>;
    FStore: TECCTransactionStore;
    FClients: TObjectDictionary<string, TECCApiClient>;
    FConfigs: TDictionary<string, TECCConfig>;
    procedure Log(const AText: string);
    function GetClient(const AApiCode: string; out AConfig: TECCConfig): TECCApiClient;
    function FindReceipt(AClient: TECCApiClient; const T: TECCTransaction; out AReceipt: TECCReceipt): Boolean;
    // AEccTotal / AEccPayType = 0: se iau din RESPONSE_JSON (bon gasit intr-un ciclu anterior)
    procedure RegisterDelivery(const ATransId: string; const AEccTotal: Currency; const AEccPayType: Integer);
  public
    constructor Create(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
    destructor Destroy; override;
    procedure Run;
  end;

constructor TDeliveryJob.Create(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
begin
  inherited Create;
  FConn := AConn;
  FUserID := AUserID;
  FLog := ALog;
  FStore := TECCTransactionStore.Create(AConn);
  FClients := TObjectDictionary<string, TECCApiClient>.Create([doOwnsValues]);
  FConfigs := TDictionary<string, TECCConfig>.Create;
end;

destructor TDeliveryJob.Destroy;
begin
  FConfigs.Free;
  FClients.Free;
  FStore.Free;
  inherited;
end;

procedure TDeliveryJob.Log(const AText: string);
begin
  if Assigned(FLog) then
    FLog(AText);
end;

function TDeliveryJob.GetClient(const AApiCode: string; out AConfig: TECCConfig): TECCApiClient;
begin
  if not FConfigs.TryGetValue(AApiCode, AConfig) then
  begin
    AConfig := LoadECCConfig(FConn, AApiCode);
    FConfigs.Add(AApiCode, AConfig);
  end;
  if AConfig.Validate <> '' then
    Exit(nil);
  if not FClients.TryGetValue(AApiCode, Result) then
  begin
    Result := AConfig.CreateClient;
    Result.ConnectionTimeout := 10000;
    Result.ResponseTimeout := 30000;
    FClients.Add(AApiCode, Result);
  end;
end;

// Bonul emis de curier: intii dupa id-ul livrarii, apoi in lista bonurilor telefonului lui
// (aceeasi suma, dupa trimitere, neluat deja de alt rind din jurnal).
function TDeliveryJob.FindReceipt(AClient: TECCApiClient; const T: TECCTransaction;
  out AReceipt: TECCReceipt): Boolean;
var
  PosId: string;
  V: TJSONValue;
  List: TArray<TECCReceipt>;
  R: TECCReceipt;
  Candidates: Integer;
  Other: TECCTransaction;
begin
  if AClient.TryGetReceipt(T.TransId, AReceipt) then
    Exit(True);

  PosId := '';
  V := TJSONObject.ParseJSONValue(T.RequestJSON);
  try
    if V is TJSONObject then
      PosId := TJSONObject(V).GetValue<string>('posId', '');
  finally
    V.Free;
  end;

  Candidates := 0;
  List := AClient.ListReceipts(IncHour(T.CreatedAt, -1), Now);
  for R in List do
    if SameText(R.PosId, PosId) and (R.Total > 0) and (R.Total <= T.Suma) and
      not FStore.Load(R.Id, Other) then
    begin
      Inc(Candidates);
      AReceipt := R;
    end;
  // doar o potrivire sigura; altfel ramine pentru verificare manuala / reconciliere
  Result := Candidates = 1;
  if Candidates > 1 then
    Log(Format('Livrarea %s (doc %d): %d bonuri posibile pe telefonul curierului - de legat manual.',
      [T.TransId, T.DocID, Candidates]));
end;

procedure TDeliveryJob.RegisterDelivery(const ATransId: string; const AEccTotal: Currency; const AEccPayType: Integer);
var
  T: TECCTransaction;
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  FacturaID, TargetType: Integer;
  Numerar, Partial: Boolean;
  DT: TDateTime;
  Suma: Currency;
begin
  if not FStore.Load(ATransId, T) or (T.State <> eccStateDone) or T.Registered then
    Exit;
  if (T.DocID <= 0) or (T.ReceiptNumber <= 0) then
  begin
    Log(Format('Livrarea %s: bon fara numar / document - de inregistrat manual.', [ATransId]));
    Exit;
  end;
  // suma si tipul platii vin din bonul real (curierul poate schimba cantitati / plata)
  Suma := T.Suma;
  if AEccTotal > 0 then
    Suma := AEccTotal;
  if AEccPayType > 0 then
    T.PayType := AEccPayType
  else if T.ResponseJSON <> '' then
  begin
    var V := TJSONObject.ParseJSONValue(T.ResponseJSON);
    try
      if (V is TJSONObject) and (TJSONObject(V).GetValue('data') is TJSONObject) then
      begin
        var Rc: TECCReceipt;
        Rc.LoadFromJSON(TJSONObject(TJSONObject(V).GetValue('data')));
        if Rc.Total > 0 then
          Suma := Rc.Total;
        if Rc.PaymentType > 0 then
          T.PayType := Rc.PaymentType;
      end;
    finally
      V.Free;
    end;
  end;
  Numerar := T.PayType = eccPayCash;
  if Numerar then
    TargetType := 116
  else
    TargetType := 120;
  Partial := Suma < T.Suma;
  DT := T.EccDateTime;
  if DT = 0 then
    DT := Now;

  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConn;
    Q.Connection := FConn;
    Q.Transaction := Tr;
    Tr.StartTransaction;
    try
      FacturaID := -1;
      Q.SQL.Text := 'SELECT FIRST 1 DOCID FROM TDB_DOCS WHERE PARENTDOCID = :R AND DOCTYPEID = 112 ORDER BY DOCID';
      Q.ParamByName('R').AsInteger := T.DocID;
      Q.Open;
      if not Q.Eof then
        FacturaID := Q.Fields[0].AsInteger;
      Q.Close;

      // incasarea (116 / 120) + factura 112 daca lipseste + rindul din TDB_DOCS_RECEIPT
      Q.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RECEIPT3(:RASHOD, -1, :TT, :FACT, 0, :NR, :DT, :PART, :NUM, :SUMA)';
      Q.ParamByName('RASHOD').AsInteger := T.DocID;
      Q.ParamByName('TT').AsInteger := TargetType;
      Q.ParamByName('FACT').AsInteger := FacturaID;
      Q.ParamByName('NR').AsInteger := T.ReceiptNumber;
      Q.ParamByName('DT').AsDateTime := DT;
      Q.ParamByName('PART').AsInteger := Ord(Partial);
      Q.ParamByName('NUM').AsInteger := Ord(Numerar);
      Q.ParamByName('SUMA').AsCurrency := Suma;
      Q.ExecSQL;

      Q.SQL.Text := 'UPDATE TDB_DOCS_RECEIPT SET ECC_TRANS_ID = :ID, FP_ID = :FP WHERE NUMAR_BON = :NR ' +
        'AND DATA_ELIBERARII = :DT AND SUMA = :SUMA AND ECC_TRANS_ID IS NULL';
      Q.ParamByName('ID').AsString := T.TransId;
      if T.FPID > 0 then
        Q.ParamByName('FP').AsInteger := T.FPID
      else
      begin
        Q.ParamByName('FP').DataType := ftInteger;
        Q.ParamByName('FP').Clear;
      end;
      Q.ParamByName('NR').AsInteger := T.ReceiptNumber;
      Q.ParamByName('DT').AsDateTime := DT;
      Q.ParamByName('SUMA').AsCurrency := Suma;
      Q.ExecSQL;

      Q.SQL.Text := 'UPDATE TFP_ECC_TRANSACTION SET FLG_REGISTERED = 1 WHERE TRANS_ID = :ID';
      Q.ParamByName('ID').AsString := T.TransId;
      Q.ExecSQL;
      Tr.Commit;
      Log(Format('Livrarea doc %d: bon ECC nr. %d, %s lei, incasare %d (%s) inregistrata%s.',
        [T.DocID, T.ReceiptNumber, ECCMoneyText(Suma), TargetType, ECCPayTypeName(T.PayType),
         IfThen(Partial, ' - BON PARTIAL: curierul a incasat mai putin, corectati documentele', '')]));
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        Log(Format('Livrarea doc %d (bon %d) NU a fost inregistrata in WMS: %s', [T.DocID, T.ReceiptNumber,
          E.Message]));
      end;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

procedure TDeliveryJob.Run;
var
  Rows: TArray<TECCTransaction>;
  T: TECCTransaction;
  Config: TECCConfig;
  Client: TECCApiClient;
  Status: TECCOrderStatus;
  Receipt: TECCReceipt;
begin
  if not TECCTransactionStore.Available(FConn) then
    Exit;
  Rows := FStore.ListPending('');
  for T in Rows do
  begin
    if T.Kind <> eccKindDelivery then
      Continue;
    try
      if T.State = eccStateDone then
      begin
        RegisterDelivery(T.TransId, 0, 0);
        Continue;
      end;
      Client := GetClient(T.ApiCode, Config);
      if Client = nil then
        Continue;
      try
        Status := Client.GetDeliveryStatus(T.TransId);
      except
        on E: EECCApiError do
        begin
          // livrarea nu a ajuns niciodata la ECC
          if (E.HttpCode = 404) and (T.State = eccStateNew) and
            (MinutesBetween(Now, T.CreatedAt) >= cNotReceivedAfterMin) then
          begin
            FStore.MarkError(T.TransId, 'Livrarea nu a ajuns la ECC.', True);
            Log(Format('Livrarea doc %d nu a ajuns la ECC (id %s) - se poate retrimite.', [T.DocID, T.TransId]));
          end;
          Continue;
        end;
      end;
      if ECCOrderStatusName(Status) <> T.OrderStatus then
        FStore.SetOrderStatus(T.TransId, ECCOrderStatusName(Status));
      if T.State = eccStateNew then
        FStore.MarkSent(T.TransId);

      case Status of
        eosCancelled:
          begin
            FStore.MarkCancelled(T.TransId, 'Livrare anulata in ECC');
            Log(Format('Livrarea doc %d a fost anulata in ECC.', [T.DocID]));
          end;
        eosCompleted, eosProcessed:
          if FindReceipt(Client, T, Receipt) then
          begin
            FStore.MarkReceiptDone(T.TransId, Receipt, '');
            RegisterDelivery(T.TransId, Receipt.Total, Receipt.PaymentType);
          end
          else
            Log(Format('Livrarea doc %d e finalizata, dar bonul curierului nu a fost gasit inca.', [T.DocID]));
      end;
    except
      on E: Exception do
        Log(Format('Livrarea %s (doc %d): %s', [T.TransId, T.DocID, E.Message]));
    end;
  end;
end;

procedure ECCProcessDeliveries(AConn: TIBCConnection; const AUserID: Integer; const ALog: TProc<string>);
var
  Job: TDeliveryJob;
begin
  Job := TDeliveryJob.Create(AConn, AUserID, ALog);
  try
    Job.Run;
  finally
    Job.Free;
  end;
end;

end.

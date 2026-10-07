unit ECCApiClient;

(* Client REST pentru casa de marcat virtuala ECC Fiscal Partner (/api/sp/v1).

  Unitate fara VCL si fara acces la baza: se foloseste din fire de executie si,
  mai tarziu, din SWNService. Documentatia: colectia Postman 47125184/2sB3BGFUj4
  si Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md.

  Particularitati ale API-ului:
    - POST /receipt intoarce 202 imediat; bonul apare mai tarziu in
      GET /receipt/{id} (404 pina atunci). Id-ul (UUID) il genereaza clientul,
      deci rezultatul se poate afla oricind dupa id, fara a emite bonul de doua ori.
    - cost = price * quantity exact (pret cu 2 zecimale, cantitate cu 3).
    - erorile vin ca {"message": "...", "status": false} cu HTTP 4xx/5xx.
    - formatul sumelor urmeaza exemplele din documentatie: la /receipt
      payments[].deposit e text, la /new-order-ext e numar, la /service-receipt
      "sum" e text. *)

interface

uses
  System.SysUtils, System.Classes, System.JSON;

const
  // Tipuri de plata ECC
  eccPayCash         = 1;
  eccPayCard         = 2;
  eccPayTME          = 5;
  eccPaySubscription = 6;
  eccPayOnline       = 7;   // alt instrument de plata: online, MIA
  eccPayVoucher      = 31;
  eccPayCEC          = 32;
  eccPayTicket       = 33;
  eccPayCredit       = 81;
  eccPayLeasing      = 82;
  eccPayAdvance      = 83;
  eccPayEarnest      = 84;
  eccPayPledge       = 85;
  eccPayCompensation = 88;
  eccPayOther        = 89;

  eccReportZ = 1;
  eccReportX = 2;

  eccDocFiscalReceipt  = 'fiscal_receipt';
  eccDocServiceReceipt = 'service_receipt';
  eccDocXReport        = 'x_report';
  eccDocZReport        = 'z_report';

  eccMaxNameLength = 100;
  eccApiPath       = '/api/sp/v1';

type
  EECCApiError = class(Exception)
  private
    FHttpCode: Integer;
  public
    constructor CreateHttp(AHttpCode: Integer; const AMessage: string);
    property HttpCode: Integer read FHttpCode;
  end;

  TECCArticle = record
    Name: string;
    Quantity: Double;     // max 3 zecimale
    Price: Currency;      // max 2 zecimale
    Cost: Currency;       // Price * Quantity rotunjit la 2 zecimale
    TaxCode: string;      // litera cotei TVA definita in ECC (A, B, ... sau _)
    ProductId: string;    // optional, id din nomenclatorul ECC
  end;

  TECCPayment = record
    PayType: Integer;
    Deposit: Currency;
    // optionale - datele tranzactiei de la terminalul bancar
    Authorization: string;
    Card: string;
    PayDateTime: string;  // 'yyyy.mm.dd hh:nn:ss'
    Pan: string;
    RRN: string;
  end;

  // Comanda de livrare (modulul Delivery): bonul il emite curierul din aplicatia ECC.
  TECCDeliveryInfo = record
    CashierId: string;      // UUID-ul casierului (curierului) din ECC
    ClientName: string;
    ClientPhone: string;
    Address: string;
    Notes: string;
    PaymentType: Integer;   // eccPayCash / eccPayCard
  end;

  TECCReceiptRequest = record
    Id: string;
    PosId: string;
    PosName: string;
    CashierName: string;
    Articles: TArray<TECCArticle>;
    Payments: TArray<TECCPayment>;
    // Goleste bonul si genereaza un Id nou.
    procedure Init(const APosId, APosName, ACashierName: string);
    // Linie cu pret unitar cunoscut: cost = pret * cantitate.
    procedure AddArticle(const AName: string; const AQuantity: Double; const APrice: Currency;
      const ATaxCode: string; const AProductId: string = '');
    // Linie din WMS cunoscuta prin suma totala (pret net * cantitate, deja rotunjita).
    // Daca suma nu se imparte exact la cantitate, linia se sparge in (N-1) x pret
    // + 1 x rest, ca totalul bonului sa fie egal cu cel din document.
    procedure AddLineTotal(const AName: string; const AQuantity: Double; const ALineTotal: Currency;
      const ATaxCode: string);
    procedure AddPayment(const APayType: Integer; const ADeposit: Currency);
    function Total: Currency;
    function Deposit: Currency;
    function Change: Currency;
    // '' = bonul poate fi trimis; altfel textul erorii.
    function Validate: string;
    function ToJSON: string;
    function ToOrderExtJSON: string;
    // Id / PosId / Articles din cerere + datele livrarii. Suma = totalul articolelor.
    function ToDeliveryJSON(const D: TECCDeliveryInfo): string;
  end;

  TECCReceipt = record
    Id: string;
    PosId: string;
    ReportId: string;
    MevLink: string;
    DocFileName: string;
    DateTimeText: string;
    DateTime: TDateTime;
    Number: Integer;
    ZReportNumber: Integer;
    NumberFromFirst: Integer;
    SiaMevKey: Integer;
    Total: Currency;
    Subtotal: Currency;
    Change: Currency;
    PaymentType: Integer;
    CashierId: string;
    CashierName: string;
    PosName: string;
    procedure LoadFromJSON(AObj: TJSONObject);
  end;

  TECCReport = record
    Id: string;
    PosId: string;
    ReportType: string;        // XR / ZR
    DocFileName: string;
    Number: Integer;
    ZReportNumber: Integer;
    StartDateTime: TDateTime;
    CloseDateTime: TDateTime;  // 0 = raport Z inca deschis
    Receipts: Integer;
    Total: Currency;
    MoneyDeposited: Currency;
    MoneyWithdrawn: Currency;
    MoneyInDrawer: Currency;
    procedure LoadFromJSON(AObj: TJSONObject);
  end;

  TECCOrderStatus = (eosUnknown, eosPending, eosProcessing, eosProcessed, eosCompleted, eosCancelled);

  // True = opreste asteptarea (de ex. utilizatorul a apasat Renunta).
  TECCCancelCheck = reference to function: Boolean;

  TECCApiClient = class
  private
    FBaseURL: string;
    FApiKey: string;
    FConnectionTimeout: Integer;
    FResponseTimeout: Integer;
    FLastRequest: string;
    FLastResponse: string;
    FLastHttpCode: Integer;
    function DoRequestOnce(const AMethod, APath, ABody: string; AContent: TStream): Integer;
    function DoRequest(const AMethod, APath, ABody: string; AContent: TStream = nil): Integer;
    function RequestJSON(const AMethod, APath, ABody: string; const AOkCodes: array of Integer): TJSONObject;
    function PostForId(const APath, ABody: string): string;
    function PosBody(const APosId, APosName, ACashierName: string): TJSONObject;
  public
    // ABaseURL: https://domeniu (cu sau fara /api/sp/v1).
    constructor Create(const ABaseURL, AApiKey: string);

    function Status: Boolean;

    // Trimite bonul (202). Rezultatul se ia cu TryGetReceipt / WaitReceipt dupa R.Id.
    procedure PostReceipt(const R: TECCReceiptRequest);
    // False = bonul nu e (inca) gata (404).
    function TryGetReceipt(const AId: string; out AReceipt: TECCReceipt): Boolean;
    // Interogheaza la AIntervalMs pina la ATimeoutMs. Blocheaza firul apelant.
    function WaitReceipt(const AId: string; out AReceipt: TECCReceipt; const ATimeoutMs: Integer = 60000;
      const AIntervalMs: Integer = 500; const ACancel: TECCCancelCheck = nil): Boolean;
    function ListReceipts(const ADateFrom, ADateTo: TDateTime): TArray<TECCReceipt>;

    // ASum > 0 depunere, ASum < 0 retragere. Intoarce id-ul bonului de serviciu.
    function ServiceReceipt(const APosId, APosName, ACashierName: string; const ASum: Currency;
      const ACurrency: string = 'MDL'): string;
    // AReportType = eccReportX / eccReportZ. Intoarce id-ul raportului.
    function Report(const APosId, APosName, ACashierName: string; const AReportType: Integer): string;
    function TryGetReport(const AId: string; out AReport: TECCReport): Boolean;
    function ListZReports(const ADateFrom, ADateTo: TDateTime; const AClosed: Boolean;
      const APage: Integer = 1; const APageSize: Integer = 50): TArray<TECCReport>;

    // ADocFileName ca in raspuns ('fiscal_receipt/<id>'). Continutul e PNG.
    procedure Download(const ADocFileName: string; AContent: TStream);

    // Terminalul bancar smart.
    procedure NewOrderExt(const R: TECCReceiptRequest);
    function GetOrderExtStatus(const AId: string; out AResultText: string): TECCOrderStatus;
    procedure CancelOrderExt(const AId: string);

    // Livrare prin curier (modulul Delivery). Stari: pending / completed / cancelled.
    procedure NewDelivery(const R: TECCReceiptRequest; const D: TECCDeliveryInfo);
    function GetDeliveryStatus(const AId: string): TECCOrderStatus;
    // AStatus: 'completed' / 'cancelled'
    procedure SetDeliveryStatus(const APosId, AId, AStatus: string);

    property ConnectionTimeout: Integer read FConnectionTimeout write FConnectionTimeout;
    property ResponseTimeout: Integer read FResponseTimeout write FResponseTimeout;
    // Pentru jurnal / diagnostic.
    property LastRequest: string read FLastRequest;
    property LastResponse: string read FLastResponse;
    property LastHttpCode: Integer read FLastHttpCode;
  end;

function NewECCId: string;
function IsValidECCId(const AId: string): Boolean;
// Rotunjire comerciala la 2 zecimale (0.005 -> 0.01), fara rotunjirea bancara a lui Round.
function ECCRoundMoney(const AValue: Double): Currency;
function ECCMoneyText(const AValue: Currency): string;
function ECCPayTypeName(const APayType: Integer): string;
function ECCOrderStatusName(const AStatus: TECCOrderStatus): string;

implementation

uses
  System.Math,
  System.DateUtils,
  System.Generics.Collections,
  System.Net.HttpClient,
  System.Net.URLClient;

{ helpers }

function NewECCId: string;
var
  G: TGUID;
begin
  CreateGUID(G);
  Result := LowerCase(Copy(GUIDToString(G), 2, 36));
end;

function IsValidECCId(const AId: string): Boolean;
begin
  Result := Length(AId) = 36;
  if Result then
    try
      StringToGUID('{' + AId + '}');
    except
      Result := False;
    end;
end;

function ECCRoundMoney(const AValue: Double): Currency;
var
  Cents: Int64;
begin
  if AValue >= 0 then
    Cents := Trunc(AValue * 100 + 0.5 + 1E-7)
  else
    Cents := -Trunc(-AValue * 100 + 0.5 + 1E-7);
  Result := Cents / 100;
end;

function RoundQty(const AValue: Double): Double;
begin
  Result := Trunc(AValue * 1000 + 0.5 + 1E-7) / 1000;
end;

function ECCMoneyText(const AValue: Currency): string;
begin
  Result := FormatFloat('0.00', AValue, TFormatSettings.Invariant);
end;

function ECCPayTypeName(const APayType: Integer): string;
begin
  case APayType of
    eccPayCash: Result := 'Numerar';
    eccPayCard: Result := 'Card';
    eccPayTME: Result := 'TME';
    eccPaySubscription: Result := 'Abonament';
    eccPayOnline: Result := 'Online / MIA';
    eccPayVoucher: Result := 'Voucher';
    eccPayCEC: Result := 'CEC';
    eccPayTicket: Result := 'Tichet';
    eccPayCredit: Result := 'Credit';
    eccPayLeasing: Result := 'Leasing';
    eccPayAdvance: Result := 'Avans';
    eccPayEarnest: Result := 'Arvuna';
    eccPayPledge: Result := 'Gaj';
    eccPayCompensation: Result := 'Compensare';
    eccPayOther: Result := 'Alt mod';
  else
    Result := 'Tip ' + IntToStr(APayType);
  end;
end;

function ECCOrderStatusName(const AStatus: TECCOrderStatus): string;
begin
  case AStatus of
    eosPending: Result := 'pending';
    eosProcessing: Result := 'processing';
    eosProcessed: Result := 'processed';
    eosCompleted: Result := 'completed';
    eosCancelled: Result := 'cancelled';
  else
    Result := 'unknown';
  end;
end;

function ParseOrderStatus(const AText: string): TECCOrderStatus;
var
  S: string;
begin
  S := LowerCase(Trim(AText));
  if S = 'pending' then
    Result := eosPending
  else if S = 'processing' then
    Result := eosProcessing
  else if S = 'processed' then
    Result := eosProcessed
  else if S = 'completed' then
    Result := eosCompleted
  else if (S = 'cancelled') or (S = 'canceled') then
    Result := eosCancelled
  else
    Result := eosUnknown;
end;

function MoneyNumber(const AValue: Currency): TJSONNumber;
var
  D: Double;
begin
  D := AValue;
  Result := TJSONNumber.Create(D);
end;

// Valorile numerice vin uneori ca text ("63"), alteori ca numar.
function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if not Assigned(AObj) then
    Exit;
  V := AObj.GetValue(AName);
  if (V = nil) or (V is TJSONNull) then
    Exit;
  if V is TJSONString then
    Result := TJSONString(V).Value
  else
    Result := V.ToString;
end;

function JFloat(AObj: TJSONObject; const AName: string): Double;
var
  S: string;
begin
  S := JStr(AObj, AName);
  Result := StrToFloatDef(StringReplace(S, ',', '.', []), 0, TFormatSettings.Invariant);
end;

function JInt(AObj: TJSONObject; const AName: string): Integer;
begin
  Result := StrToIntDef(JStr(AObj, AName), 0);
end;

function JObj(AObj: TJSONObject; const AName: string): TJSONObject;
var
  V: TJSONValue;
begin
  Result := nil;
  if Assigned(AObj) then
  begin
    V := AObj.GetValue(AName);
    if V is TJSONObject then
      Result := TJSONObject(V);
  end;
end;

// '2026-02-27T17:11:50.976699+02:00' -> ora locala a serverului (Chisinau), fara conversie.
// '0001-01-01...' (data nula in Go) -> 0.
function ParseECCDateTime(const AText: string): TDateTime;
var
  Y, M, D, H, N, S: Integer;
begin
  Result := 0;
  if Length(AText) < 19 then
    Exit;
  Y := StrToIntDef(Copy(AText, 1, 4), 0);
  M := StrToIntDef(Copy(AText, 6, 2), 0);
  D := StrToIntDef(Copy(AText, 9, 2), 0);
  H := StrToIntDef(Copy(AText, 12, 2), 0);
  N := StrToIntDef(Copy(AText, 15, 2), 0);
  S := StrToIntDef(Copy(AText, 18, 2), 0);
  if Y < 1900 then
    Exit;
  if not TryEncodeDateTime(Y, M, D, H, N, S, 0, Result) then
    Result := 0;
end;

function QueryDateTime(const AValue: TDateTime): string;
begin
  // dateFrom=2025-09-14 00:00:00 -> spatiul si ':' codate
  Result := FormatDateTime('yyyy-mm-dd', AValue) + '%20' +
    StringReplace(FormatDateTime('hh:nn:ss', AValue), ':', '%3A', [rfReplaceAll]);
end;

{ EECCApiError }

constructor EECCApiError.CreateHttp(AHttpCode: Integer; const AMessage: string);
begin
  inherited Create(AMessage);
  FHttpCode := AHttpCode;
end;

{ TECCReceiptRequest }

procedure TECCReceiptRequest.Init(const APosId, APosName, ACashierName: string);
begin
  Id := NewECCId;
  PosId := APosId;
  PosName := APosName;
  CashierName := ACashierName;
  Articles := nil;
  Payments := nil;
end;

procedure TECCReceiptRequest.AddArticle(const AName: string; const AQuantity: Double; const APrice: Currency;
  const ATaxCode: string; const AProductId: string);
var
  A: TECCArticle;
begin
  A.Name := Trim(AName);
  if Length(A.Name) > eccMaxNameLength then
    A.Name := Trim(Copy(A.Name, 1, eccMaxNameLength));
  A.Quantity := RoundQty(AQuantity);
  A.Price := ECCRoundMoney(APrice);
  A.Cost := ECCRoundMoney(A.Price * A.Quantity);
  A.TaxCode := ATaxCode;
  A.ProductId := AProductId;
  Articles := Articles + [A];
end;

procedure TECCReceiptRequest.AddLineTotal(const AName: string; const AQuantity: Double;
  const ALineTotal: Currency; const ATaxCode: string);
var
  Qty: Double;
  Price, Rest: Currency;
begin
  Qty := RoundQty(AQuantity);
  if Qty <= 0 then
    raise EECCApiError.CreateHttp(0, Format('Cantitate invalida (%g) pentru "%s".', [AQuantity, AName]));

  Price := ECCRoundMoney(ALineTotal / Qty);
  if ECCRoundMoney(Price * Qty) = ALineTotal then
    AddArticle(AName, Qty, Price, ATaxCode)
  else if (Frac(Qty) = 0) and (Qty > 1) then
  begin
    // 3 x 33.33 = 99.99, dar linia din document e 100.00 -> 2 x 33.33 + 1 x 33.34
    AddArticle(AName, Qty - 1, Price, ATaxCode);
    Rest := ALineTotal - ECCRoundMoney(Price * (Qty - 1));
    AddArticle(AName, 1, Rest, ATaxCode);
  end
  else
    // cantitate fractionara care nu se imparte exact: o singura bucata la suma liniei
    AddArticle(AName, 1, ALineTotal, ATaxCode);
end;

procedure TECCReceiptRequest.AddPayment(const APayType: Integer; const ADeposit: Currency);
var
  P: TECCPayment;
begin
  P := Default(TECCPayment);
  P.PayType := APayType;
  P.Deposit := ECCRoundMoney(ADeposit);
  Payments := Payments + [P];
end;

function TECCReceiptRequest.Total: Currency;
var
  A: TECCArticle;
begin
  Result := 0;
  for A in Articles do
    Result := Result + A.Cost;
end;

function TECCReceiptRequest.Deposit: Currency;
var
  P: TECCPayment;
begin
  Result := 0;
  for P in Payments do
    Result := Result + P.Deposit;
end;

function TECCReceiptRequest.Change: Currency;
begin
  Result := Deposit - Total;
  if Result < 0 then
    Result := 0;
end;

function TECCReceiptRequest.Validate: string;
var
  A: TECCArticle;
  P: TECCPayment;
  NonCash: Currency;
begin
  Result := '';
  if not IsValidECCId(Id) then
    Exit('Id-ul tranzactiei nu e un UUID valid.');
  if Trim(PosId) = '' then
    Exit('Nu e indicat POS ID-ul casei ECC.');
  if Length(Articles) = 0 then
    Exit('Bonul nu are articole.');
  for A in Articles do
  begin
    if A.Name = '' then
      Exit('Un articol nu are denumire.');
    if A.Quantity <= 0 then
      Exit(Format('Articolul "%s" are cantitatea <= 0.', [A.Name]));
    if A.Price < 0 then
      Exit(Format('Articolul "%s" are pret negativ.', [A.Name]));
    if A.Cost <> ECCRoundMoney(A.Price * A.Quantity) then
      Exit(Format('Articolul "%s": cost %s <> pret x cantitate.', [A.Name, ECCMoneyText(A.Cost)]));
    if A.TaxCode = '' then
      Exit(Format('Articolul "%s" nu are cota TVA ECC.', [A.Name]));
  end;
  if Total <= 0 then
    Exit('Totalul bonului trebuie sa fie mai mare ca 0.');
  if Length(Payments) = 0 then
    Exit('Bonul nu are plati.');
  NonCash := 0;
  for P in Payments do
  begin
    if P.Deposit <= 0 then
      Exit('O plata are suma <= 0.');
    if P.PayType <> eccPayCash then
      NonCash := NonCash + P.Deposit;
  end;
  if Deposit < Total then
    Exit(Format('Platile (%s) sint mai mici decit totalul (%s).', [ECCMoneyText(Deposit), ECCMoneyText(Total)]));
  if NonCash > Total then
    Exit('Restul se poate da doar din numerar: platile fara numerar depasesc totalul.');
end;

function TECCReceiptRequest.ToJSON: string;
var
  Root, Obj, Sum: TJSONObject;
  Arr: TJSONArray;
  A: TECCArticle;
  P: TECCPayment;
begin
  Root := TJSONObject.Create;
  try
    Arr := TJSONArray.Create;
    Root.AddPair('articles', Arr);
    for A in Articles do
    begin
      Obj := TJSONObject.Create;
      Arr.AddElement(Obj);
      Obj.AddPair('name', A.Name);
      if A.ProductId <> '' then
        Obj.AddPair('product_id', A.ProductId);
      Obj.AddPair('quantity', TJSONNumber.Create(A.Quantity));
      Obj.AddPair('price', MoneyNumber(A.Price));
      Obj.AddPair('cost', MoneyNumber(A.Cost));
      Obj.AddPair('tax_code', A.TaxCode);
      Obj.AddPair('others', TJSONArray.Create);
    end;

    Root.AddPair('cashier_name', CashierName);
    Root.AddPair('id', Id);

    Arr := TJSONArray.Create;
    Root.AddPair('payments', Arr);
    for P in Payments do
    begin
      Obj := TJSONObject.Create;
      Arr.AddElement(Obj);
      Obj.AddPair('deposit', ECCMoneyText(P.Deposit));
      Obj.AddPair('type', TJSONNumber.Create(P.PayType));
      if P.Authorization <> '' then
        Obj.AddPair('authorization', P.Authorization);
      if P.Card <> '' then
        Obj.AddPair('card', P.Card);
      if P.PayDateTime <> '' then
        Obj.AddPair('datetime', P.PayDateTime);
      if P.Pan <> '' then
        Obj.AddPair('pan', P.Pan);
      if P.RRN <> '' then
        Obj.AddPair('rrn', P.RRN);
    end;

    Root.AddPair('posId', PosId);
    if PosName <> '' then
      Root.AddPair('posName', PosName);

    Sum := TJSONObject.Create;
    Root.AddPair('sum', Sum);
    Sum.AddPair('addition', TJSONNumber.Create(0));
    Sum.AddPair('deposit', MoneyNumber(Deposit));
    Sum.AddPair('discount', TJSONNumber.Create(0));
    Sum.AddPair('subtotal', MoneyNumber(Total));
    Sum.AddPair('total', MoneyNumber(Total));

    Result := Root.ToJSON;
  finally
    Root.Free;
  end;
end;

function TECCReceiptRequest.ToOrderExtJSON: string;
var
  Root, Obj, Sum: TJSONObject;
  Arr: TJSONArray;
  A: TECCArticle;
  P: TECCPayment;
begin
  Root := TJSONObject.Create;
  try
    Root.AddPair('id', Id);
    Root.AddPair('posId', PosId);
    if PosName <> '' then
      Root.AddPair('posName', PosName);
    Root.AddPair('client', TJSONNull.Create);

    Arr := TJSONArray.Create;
    Root.AddPair('payments', Arr);
    for P in Payments do
    begin
      Obj := TJSONObject.Create;
      Arr.AddElement(Obj);
      Obj.AddPair('type', TJSONNumber.Create(P.PayType));
      Obj.AddPair('deposit', MoneyNumber(P.Deposit));
    end;

    Sum := TJSONObject.Create;
    Root.AddPair('sum', Sum);
    Sum.AddPair('total', MoneyNumber(Total));
    Sum.AddPair('deposit', MoneyNumber(Deposit));
    Sum.AddPair('change', MoneyNumber(Change));
    Sum.AddPair('discount', TJSONNumber.Create(0));
    Sum.AddPair('addition', TJSONNumber.Create(0));
    Sum.AddPair('discount_percent', TJSONBool.Create(False));
    Sum.AddPair('addition_percent', TJSONBool.Create(False));

    Arr := TJSONArray.Create;
    Root.AddPair('articles', Arr);
    for A in Articles do
    begin
      Obj := TJSONObject.Create;
      Arr.AddElement(Obj);
      Obj.AddPair('name', A.Name);
      if A.ProductId <> '' then
        Obj.AddPair('product_id', A.ProductId);
      Obj.AddPair('quantity', TJSONNumber.Create(A.Quantity));
      Obj.AddPair('price', MoneyNumber(A.Price));
      Obj.AddPair('cost', MoneyNumber(A.Cost));
      Obj.AddPair('tax_code', A.TaxCode);
      Obj.AddPair('others', TJSONArray.Create);
    end;

    Result := Root.ToJSON;
  finally
    Root.Free;
  end;
end;

function TECCReceiptRequest.ToDeliveryJSON(const D: TECCDeliveryInfo): string;
var
  Root, Obj: TJSONObject;
  Arr: TJSONArray;
  A: TECCArticle;
begin
  Root := TJSONObject.Create;
  try
    Root.AddPair('id', Id);
    Root.AddPair('posId', PosId);
    Root.AddPair('cashierId', D.CashierId);
    Root.AddPair('clientName', D.ClientName);
    Root.AddPair('clientPhone', D.ClientPhone);
    Root.AddPair('deliveryAddress', D.Address);
    Root.AddPair('notes', D.Notes);
    Root.AddPair('total', MoneyNumber(Total));
    Root.AddPair('discount', TJSONNumber.Create(0));
    Root.AddPair('discountPercent', TJSONNumber.Create(0));
    Root.AddPair('paymentType', TJSONNumber.Create(D.PaymentType));
    Arr := TJSONArray.Create;
    Root.AddPair('items', Arr);
    for A in Articles do
    begin
      Obj := TJSONObject.Create;
      Arr.AddElement(Obj);
      Obj.AddPair('name', A.Name);
      Obj.AddPair('price', MoneyNumber(A.Price));
      Obj.AddPair('id', NewECCId);
      if A.ProductId <> '' then
        Obj.AddPair('product_id', A.ProductId);
      Obj.AddPair('quantity', TJSONNumber.Create(A.Quantity));
      Obj.AddPair('taxCode', A.TaxCode);
    end;
    Result := Root.ToJSON;
  finally
    Root.Free;
  end;
end;

{ TECCReceipt }

procedure TECCReceipt.LoadFromJSON(AObj: TJSONObject);
var
  Arr: TJSONValue;
begin
  Self := Default(TECCReceipt);
  if not Assigned(AObj) then
    Exit;
  Id := JStr(AObj, 'id');
  PosId := JStr(AObj, 'pos_id');
  if (PosId = '') and Assigned(JObj(AObj, 'pos')) then
    PosId := JStr(JObj(AObj, 'pos'), 'id');
  ReportId := JStr(AObj, 'report_id');
  MevLink := JStr(AObj, 'mev_link');
  DocFileName := JStr(AObj, 'doc_file_name');
  DateTimeText := JStr(AObj, 'datetime');
  DateTime := ParseECCDateTime(DateTimeText);
  Number := JInt(AObj, 'number');
  ZReportNumber := JInt(AObj, 'z_report_number');
  NumberFromFirst := JInt(AObj, 'number_from_first');
  SiaMevKey := JInt(AObj, 'sia_mev_key');
  Total := ECCRoundMoney(JFloat(AObj, 'total'));
  Subtotal := ECCRoundMoney(JFloat(AObj, 'subtotal'));
  Change := ECCRoundMoney(JFloat(AObj, 'change'));
  PaymentType := JInt(AObj, 'payment_type');
  if Assigned(JObj(AObj, 'cashier')) then
  begin
    CashierId := JStr(JObj(AObj, 'cashier'), 'id');
    CashierName := JStr(JObj(AObj, 'cashier'), 'full_name');
  end;
  if Assigned(JObj(AObj, 'pos')) then
    PosName := JStr(JObj(AObj, 'pos'), 'point');
  // tipul de plata si restul sint uneori doar in payments[]
  Arr := AObj.GetValue('payments');
  if (Arr is TJSONArray) and (TJSONArray(Arr).Count > 0) and (TJSONArray(Arr).Items[0] is TJSONObject) then
  begin
    if PaymentType = 0 then
      PaymentType := JInt(TJSONObject(TJSONArray(Arr).Items[0]), 'type');
    if Change = 0 then
      Change := ECCRoundMoney(JFloat(TJSONObject(TJSONArray(Arr).Items[0]), 'change'));
  end;
end;

{ TECCReport }

procedure TECCReport.LoadFromJSON(AObj: TJSONObject);
begin
  Self := Default(TECCReport);
  if not Assigned(AObj) then
    Exit;
  Id := JStr(AObj, 'id');
  PosId := JStr(AObj, 'pos_id');
  if (PosId = '') and Assigned(JObj(AObj, 'pos')) then
    PosId := JStr(JObj(AObj, 'pos'), 'id');
  ReportType := JStr(AObj, 'type');
  DocFileName := JStr(AObj, 'doc_file_name');
  Number := JInt(AObj, 'number');
  ZReportNumber := JInt(AObj, 'z_report_number');
  StartDateTime := ParseECCDateTime(JStr(AObj, 'start_datetime'));
  if StartDateTime = 0 then
    StartDateTime := ParseECCDateTime(JStr(AObj, 'datetime'));
  CloseDateTime := ParseECCDateTime(JStr(AObj, 'close_datetime'));
  Receipts := JInt(AObj, 'receipts');
  if Receipts = 0 then
    Receipts := JInt(AObj, 'total_number_tax_receipts');
  Total := ECCRoundMoney(JFloat(AObj, 'total'));
  MoneyDeposited := ECCRoundMoney(JFloat(AObj, 'money_deposited'));
  MoneyWithdrawn := ECCRoundMoney(JFloat(AObj, 'money_withdrawn'));
  MoneyInDrawer := ECCRoundMoney(JFloat(AObj, 'money_in_drawer'));
end;

{ TECCApiClient }

constructor TECCApiClient.Create(const ABaseURL, AApiKey: string);
begin
  inherited Create;
  FBaseURL := Trim(ABaseURL);
  while (FBaseURL <> '') and (FBaseURL[Length(FBaseURL)] = '/') do
    SetLength(FBaseURL, Length(FBaseURL) - 1);
  if not FBaseURL.ToLower.EndsWith(eccApiPath) then
    FBaseURL := FBaseURL + eccApiPath;
  if not (FBaseURL.ToLower.StartsWith('http://') or FBaseURL.ToLower.StartsWith('https://')) then
    FBaseURL := 'https://' + FBaseURL;
  FApiKey := Trim(AApiKey);
  FConnectionTimeout := 15000;
  FResponseTimeout := 30000;
end;

// Mediile de test Fiscal Partner (demo-13, sep 2026) raspund la fiecare a doua cerere cu
// 400 "Wrong Public IP address, unauthorized request" (un server din spatele balansorului nu
// are IP-ul in lista cheii). Cererea e respinsa inainte de orice procesare, deci repetarea ei
// (cu acelasi id) e sigura; orice alt raspuns se intoarce neschimbat.
function TECCApiClient.DoRequest(const AMethod, APath, ABody: string; AContent: TStream): Integer;
const
  cIpRetries = 4;
var
  Attempt: Integer;
  StartPos: Int64;
begin
  StartPos := 0;
  if Assigned(AContent) then
    StartPos := AContent.Position;
  for Attempt := 1 to cIpRetries do
  begin
    Result := DoRequestOnce(AMethod, APath, ABody, AContent);
    if not ((Result = 400) and (Pos('Wrong Public IP', FLastResponse) > 0)) then
      Exit;
    if Assigned(AContent) then
    begin
      AContent.Size := StartPos;
      AContent.Position := StartPos;
    end;
    Sleep(300);
  end;
end;

function TECCApiClient.DoRequestOnce(const AMethod, APath, ABody: string; AContent: TStream): Integer;
var
  Http: THTTPClient;
  Src: TStringStream;
  Resp: IHTTPResponse;
  Headers: TNetHeaders;
  Url: string;
begin
  Url := FBaseURL + APath;
  FLastRequest := AMethod + ' ' + Url;
  if ABody <> '' then
    FLastRequest := FLastRequest + sLineBreak + ABody;
  FLastResponse := '';
  FLastHttpCode := 0;

  Headers := [TNetHeader.Create('X-Api-Key', FApiKey)];
  if AContent = nil then
    Headers := Headers + [TNetHeader.Create('Accept', 'application/json')];

  Http := THTTPClient.Create;
  Src := nil;
  try
    Http.ConnectionTimeout := FConnectionTimeout;
    Http.ResponseTimeout := FResponseTimeout;
    if ABody <> '' then
    begin
      Src := TStringStream.Create(ABody, TEncoding.UTF8);
      Headers := Headers + [TNetHeader.Create('Content-Type', 'application/json')];
    end;

    try
      if AMethod = 'POST' then
        Resp := Http.Post(Url, Src, AContent, Headers)
      else if AMethod = 'PUT' then
        Resp := Http.Put(Url, Src, AContent, Headers)
      else if AMethod = 'DELETE' then
        Resp := Http.Delete(Url, AContent, Headers)
      else
        Resp := Http.Get(Url, AContent, Headers);
    except
      on E: ENetException do
        raise EECCApiError.CreateHttp(0, 'Serverul ECC nu raspunde: ' + E.Message);
    end;

    Result := Resp.StatusCode;
    FLastHttpCode := Result;
    if AContent = nil then
      FLastResponse := Resp.ContentAsString(TEncoding.UTF8)
    else if (Result < 200) or (Result > 299) then
    begin
      // la descarcare, raspunsul de eroare a ajuns in fluxul apelantului
      AContent.Position := 0;
      with TStringStream.Create('', TEncoding.UTF8) do
      try
        CopyFrom(AContent, 0);
        FLastResponse := DataString;
      finally
        Free;
      end;
    end;
  finally
    Src.Free;
    Http.Free;
  end;
end;

function TECCApiClient.RequestJSON(const AMethod, APath, ABody: string;
  const AOkCodes: array of Integer): TJSONObject;
var
  Code, I: Integer;
  Ok: Boolean;
  V: TJSONValue;
  Msg: string;
begin
  Code := DoRequest(AMethod, APath, ABody);
  V := TJSONObject.ParseJSONValue(FLastResponse);
  if not (V is TJSONObject) then
  begin
    V.Free;
    raise EECCApiError.CreateHttp(Code, Format('Raspuns ECC neasteptat (HTTP %d): %s',
      [Code, Copy(FLastResponse, 1, 300)]));
  end;
  Result := TJSONObject(V);

  Ok := False;
  for I := Low(AOkCodes) to High(AOkCodes) do
    if Code = AOkCodes[I] then
      Ok := True;
  // "status": false inseamna eroare chiar si cu HTTP 200
  if Ok and (Result.GetValue('status') is TJSONBool) and not TJSONBool(Result.GetValue('status')).AsBoolean then
    Ok := False;

  if not Ok then
  begin
    Msg := JStr(Result, 'message');
    Result.Free;
    if Msg = '' then
      Msg := Copy(FLastResponse, 1, 300);
    raise EECCApiError.CreateHttp(Code, Format('ECC: %s (HTTP %d)', [Msg, Code]));
  end;
end;

function TECCApiClient.PostForId(const APath, ABody: string): string;
var
  J: TJSONObject;
begin
  J := RequestJSON('POST', APath, ABody, [200, 201, 202]);
  try
    Result := JStr(J, 'id');
  finally
    J.Free;
  end;
end;

function TECCApiClient.PosBody(const APosId, APosName, ACashierName: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('cashierName', ACashierName);
  Result.AddPair('posId', APosId);
  if APosName <> '' then
    Result.AddPair('posName', APosName);
end;

function TECCApiClient.Status: Boolean;
var
  J: TJSONObject;
begin
  J := RequestJSON('GET', '/status', '', [200]);
  try
    Result := (J.GetValue('status') is TJSONBool) and TJSONBool(J.GetValue('status')).AsBoolean;
  finally
    J.Free;
  end;
end;

procedure TECCApiClient.PostReceipt(const R: TECCReceiptRequest);
var
  Err: string;
begin
  Err := R.Validate;
  if Err <> '' then
    raise EECCApiError.CreateHttp(0, Err);
  PostForId('/receipt', R.ToJSON);
end;

function TECCApiClient.TryGetReceipt(const AId: string; out AReceipt: TECCReceipt): Boolean;
var
  Code: Integer;
  V: TJSONValue;
begin
  AReceipt := Default(TECCReceipt);
  Code := DoRequest('GET', '/receipt/' + AId, '');
  if Code = 404 then
    Exit(False);
  V := TJSONObject.ParseJSONValue(FLastResponse);
  try
    if (Code <> 200) or not (V is TJSONObject) then
      raise EECCApiError.CreateHttp(Code, Format('ECC: %s (HTTP %d)',
        [Copy(FLastResponse, 1, 300), Code]));
    AReceipt.LoadFromJSON(JObj(TJSONObject(V), 'data'));
    Result := AReceipt.Id <> '';
  finally
    V.Free;
  end;
end;

function TECCApiClient.WaitReceipt(const AId: string; out AReceipt: TECCReceipt; const ATimeoutMs,
  AIntervalMs: Integer; const ACancel: TECCCancelCheck): Boolean;
var
  Deadline: TDateTime;
begin
  Deadline := IncMilliSecond(Now, ATimeoutMs);
  repeat
    if TryGetReceipt(AId, AReceipt) then
      Exit(True);
    if Assigned(ACancel) and ACancel() then
      Exit(False);
    Sleep(AIntervalMs);
  until Now >= Deadline;
  Result := TryGetReceipt(AId, AReceipt);
end;

function TECCApiClient.ListReceipts(const ADateFrom, ADateTo: TDateTime): TArray<TECCReceipt>;
const
  cPageSize = 100;
var
  J: TJSONObject;
  Items: TJSONValue;
  I, Page, LastPage: Integer;
  R: TECCReceipt;
begin
  // lista e paginata (items + lastPage + totalCount)
  Result := nil;
  Page := 1;
  repeat
    J := RequestJSON('GET', Format('/receipt?dateFrom=%s&dateTo=%s&page=%d&nrOfitems=%d',
      [QueryDateTime(ADateFrom), QueryDateTime(ADateTo), Page, cPageSize]), '', [200]);
    try
      Items := J.GetValue('items');
      if Items is TJSONArray then
        for I := 0 to TJSONArray(Items).Count - 1 do
          if TJSONArray(Items).Items[I] is TJSONObject then
          begin
            R.LoadFromJSON(TJSONObject(TJSONArray(Items).Items[I]));
            Result := Result + [R];
          end;
      LastPage := JInt(J, 'lastPage');
      if not (Items is TJSONArray) or (TJSONArray(Items).Count = 0) then
        LastPage := 0;
    finally
      J.Free;
    end;
    Inc(Page);
  until Page > LastPage;
end;

function TECCApiClient.ServiceReceipt(const APosId, APosName, ACashierName: string; const ASum: Currency;
  const ACurrency: string): string;
var
  Body: TJSONObject;
begin
  if ASum = 0 then
    raise EECCApiError.CreateHttp(0, 'Suma bonului de serviciu nu poate fi 0.');
  Body := PosBody(APosId, APosName, ACashierName);
  try
    Body.AddPair('currency', ACurrency);
    Body.AddPair('sum', ECCMoneyText(ASum));
    Result := PostForId('/service-receipt', Body.ToJSON);
  finally
    Body.Free;
  end;
end;

function TECCApiClient.Report(const APosId, APosName, ACashierName: string; const AReportType: Integer): string;
var
  Body: TJSONObject;
begin
  Body := PosBody(APosId, APosName, ACashierName);
  try
    Body.AddPair('reportType', TJSONNumber.Create(AReportType));
    Result := PostForId('/report', Body.ToJSON);
  finally
    Body.Free;
  end;
end;

function TECCApiClient.TryGetReport(const AId: string; out AReport: TECCReport): Boolean;
var
  Code: Integer;
  V: TJSONValue;
begin
  AReport := Default(TECCReport);
  Code := DoRequest('GET', '/report/' + AId, '');
  if Code = 404 then
    Exit(False);
  V := TJSONObject.ParseJSONValue(FLastResponse);
  try
    if (Code <> 200) or not (V is TJSONObject) then
      raise EECCApiError.CreateHttp(Code, Format('ECC: %s (HTTP %d)',
        [Copy(FLastResponse, 1, 300), Code]));
    AReport.LoadFromJSON(JObj(TJSONObject(V), 'data'));
    Result := AReport.Id <> '';
  finally
    V.Free;
  end;
end;

function TECCApiClient.ListZReports(const ADateFrom, ADateTo: TDateTime; const AClosed: Boolean;
  const APage, APageSize: Integer): TArray<TECCReport>;
const
  cBool: array[Boolean] of string = ('false', 'true');
var
  J: TJSONObject;
  Items: TJSONValue;
  I: Integer;
  R: TECCReport;
begin
  Result := nil;
  J := RequestJSON('GET', Format('/report?dateFrom=%s&dateTo=%s&closed=%s&page=%d&nrOfitems=%d',
    [QueryDateTime(ADateFrom), QueryDateTime(ADateTo), cBool[AClosed], APage, APageSize]), '', [200]);
  try
    Items := J.GetValue('items');
    if Items is TJSONArray then
      for I := 0 to TJSONArray(Items).Count - 1 do
        if TJSONArray(Items).Items[I] is TJSONObject then
        begin
          R.LoadFromJSON(TJSONObject(TJSONArray(Items).Items[I]));
          Result := Result + [R];
        end;
  finally
    J.Free;
  end;
end;

procedure TECCApiClient.Download(const ADocFileName: string; AContent: TStream);
var
  Code: Integer;
  StartPos: Int64;
begin
  if Trim(ADocFileName) = '' then
    raise EECCApiError.CreateHttp(0, 'Documentul ECC nu are fisier (doc_file_name gol).');
  StartPos := AContent.Position;
  Code := DoRequest('GET', '/download/' + ADocFileName, '', AContent);
  if Code <> 200 then
  begin
    AContent.Size := StartPos;
    raise EECCApiError.CreateHttp(Code, Format('ECC: descarcarea %s a esuat (HTTP %d): %s',
      [ADocFileName, Code, Copy(FLastResponse, 1, 300)]));
  end;
end;

procedure TECCApiClient.NewOrderExt(const R: TECCReceiptRequest);
var
  Err: string;
begin
  Err := R.Validate;
  if Err <> '' then
    raise EECCApiError.CreateHttp(0, Err);
  PostForId('/new-order-ext', R.ToOrderExtJSON);
end;

function TECCApiClient.GetOrderExtStatus(const AId: string; out AResultText: string): TECCOrderStatus;
var
  J: TJSONObject;
begin
  J := RequestJSON('GET', '/new-order-ext/' + AId, '', [200]);
  try
    Result := ParseOrderStatus(JStr(J, 'order_status'));
    AResultText := JStr(J, 'result');
  finally
    J.Free;
  end;
end;

procedure TECCApiClient.CancelOrderExt(const AId: string);
begin
  RequestJSON('DELETE', '/new-order-ext/' + AId, '', [200, 202, 204]).Free;
end;

procedure TECCApiClient.NewDelivery(const R: TECCReceiptRequest; const D: TECCDeliveryInfo);
begin
  if not IsValidECCId(R.Id) then
    raise EECCApiError.CreateHttp(0, 'Id-ul livrarii nu e un UUID valid.');
  if Trim(D.CashierId) = '' then
    raise EECCApiError.CreateHttp(0, 'Livrarea nu are casierul (curierul) ECC.');
  if Length(R.Articles) = 0 then
    raise EECCApiError.CreateHttp(0, 'Livrarea nu are articole.');
  PostForId('/delivery', R.ToDeliveryJSON(D));
end;

function TECCApiClient.GetDeliveryStatus(const AId: string): TECCOrderStatus;
var
  J: TJSONObject;
begin
  J := RequestJSON('GET', '/delivery/' + AId, '', [200]);
  try
    Result := ParseOrderStatus(JStr(J, 'order_status'));
  finally
    J.Free;
  end;
end;

procedure TECCApiClient.SetDeliveryStatus(const APosId, AId, AStatus: string);
var
  Body: TJSONObject;
begin
  Body := TJSONObject.Create;
  try
    Body.AddPair('posId', APosId);
    Body.AddPair('orderId', AId);
    Body.AddPair('status', AStatus);
    RequestJSON('POST', '/delivery-status', Body.ToJSON, [200, 202]).Free;
  finally
    Body.Free;
  end;
end;

end.

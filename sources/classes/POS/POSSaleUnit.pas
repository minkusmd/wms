unit POSSaleUnit;

{
  POS - logica fara interfata: casa (TPOS_TERMINAL), tura (TPOS_SHIFT), cautarea
  produsului (POS_FIND_GOODS_EX) si cosul bonului curent.

  Cosul traieste in memorie pina la incasare / punere in asteptare; nu atinge stocul.
  Schema: DB Model/pos.sql. Plan: Documents/pos-plan-2026-09-20.md
}

interface

uses
  SysUtils, Classes, Generics.Collections;

const
  // codurile stabile ale analiticilor de plata (TS_SYSS grupa 26, VALUE_STR)
  cPOS_Pay_Cash = 'PAY_CASH';
  cPOS_Pay_Card = 'PAY_POS';
  cPOS_Pay_QR = 'PAY_QR_MIA';

  // TS_GOODS.SERIAL_TYPE_ID pentru evidenta pe serii - la vinzare se cere serialul
  cPOS_SerialType_Serii = 4403;

  // POS_FIND_GOODS.MATCH_KIND
  cPOS_Match_OwnBarcode = 1;
  cPOS_Match_SupplierBarcode = 2;
  cPOS_Match_GoodsID = 3;
  cPOS_Match_Code = 4;
  cPOS_Match_Title = 5;

type
  TPOSTerminal = record
    PosID: Integer;
    Title: string;
    FirmaID: Integer;
    StockID: Integer;
    FPID: Integer;
    DefaultCustomerID: Integer;
    PriceColumn: Integer;
    MaxDiscountP: Integer;
    procedure Clear;
    function IsValid: Boolean;
  end;

  TPOSShift = record
    ShiftID: Integer;
    UserID: Integer;
    OpenedAt: TDateTime;
    OpenCash: Currency;
    procedure Clear;
    function IsOpen: Boolean;
  end;

  TPOSShiftSummary = record
    OpenCash: Currency;
    CashSales: Currency;
    CardSales: Currency;
    OtherSales: Currency;
    CashIn: Currency;
    CashOut: Currency;
    ExpectedCash: Currency;
    SalesCount: Integer;
    OpenCount: Integer;
    ParkedCount: Integer;
  end;

  TPOSFoundGoods = record
    GoodsID: Integer;
    Title: string;
    Code: string;
    Price: Currency;
    StockQty: Double;
    SerialTypeID: Integer;
    MatchKind: Integer;
    function NeedsSerial: Boolean;
  end;

  TPOSFoundGoodsArray = TArray<TPOSFoundGoods>;

  // O plata a bonului. Suma = cit acopera din bon; Tendered = cit a dat clientul (numerar).
  TPOSPayment = record
    PayCode: string;
    Suma: Currency;
    Tendered: Currency;
    ExtRef: string;
    function Change: Currency;
  end;

  TPOSPaymentArray = TArray<TPOSPayment>;

  TPOSCartLine = class
  private
    FGoodsID: Integer;
    FTitle: string;
    FCode: string;
    FQty: Double;
    FPrice: Currency;
    FDiscountP: Integer;
    FSerial: string;
    FScannedCode: string;
    FStockQty: Double;
    FNeedsSerial: Boolean;
  public
    function FullSuma: Currency;      // fara reducere
    function NetPrice: Currency;      // pretul unei bucati dupa reducere - asa ajunge in TDB_JURNAL
    function DiscountSuma: Currency;
    function Suma: Currency;          // de plata = NetPrice * Qty
    property GoodsID: Integer read FGoodsID;
    property Title: string read FTitle;
    property Code: string read FCode;
    property Qty: Double read FQty;
    property Price: Currency read FPrice;
    property DiscountP: Integer read FDiscountP;
    property Serial: string read FSerial;
    property ScannedCode: string read FScannedCode;
    property StockQty: Double read FStockQty;
    property NeedsSerial: Boolean read FNeedsSerial;
  end;

  EPOSCartError = class(Exception);
  EPOSError = class(Exception);

  TPOSCart = class
  private
    FLines: TObjectList<TPOSCartLine>;
    FMaxDiscountP: Integer;
    FOnChange: TNotifyEvent;
    function GetCount: Integer;
    function GetLine(Index: Integer): TPOSCartLine;
    procedure Changed;
    procedure CheckIndex(const Index: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    // Adauga produsul; acelasi produs fara serial se cumuleaza pe aceeasi linie.
    // Intoarce indexul liniei.
    function AddGoods(const Goods: TPOSFoundGoods; const AQty: Double; const ASerial, AScannedCode: string): Integer;
    procedure SetQty(const Index: Integer; const AQty: Double);
    procedure ChangeQty(const Index: Integer; const Delta: Double);
    procedure SetDiscountP(const Index: Integer; const ADiscountP: Integer);
    procedure SetDiscountPAll(const ADiscountP: Integer);
    procedure Delete(const Index: Integer);
    procedure Clear;

    function IsEmpty: Boolean;
    function Total: Currency;
    function TotalDiscount: Currency;
    function TotalQty: Double;
    function SerialUsed(const ASerial: string): Boolean;

    property Count: Integer read GetCount;
    property Lines[Index: Integer]: TPOSCartLine read GetLine; default;
    // limita de reducere fara aprobare; 100 = fara limita
    property MaxDiscountP: Integer read FMaxDiscountP write FMaxDiscountP;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

// Casa acestui calculator: TPOS_TERMINAL legata de statia de lucru curenta si de firma curenta.
// False = pe acest calculator nu este configurata nicio casa (sau schema POS lipseste din baza).
function POSDetectTerminal(out Terminal: TPOSTerminal; out ErrorText: string): Boolean;

// Tura deschisa a casei (daca exista).
function POSGetOpenShift(const PosID: Integer; out Shift: TPOSShift): Boolean;

function POSFindGoods(const AText: string; const PosID: Integer): TPOSFoundGoodsArray;

// Ture (SP_POS_SHIFT_*). Erorile de validare vin ca EPOSError cu textul din baza.
function POSOpenShift(const PosID: Integer; const OpenCash: Currency): Integer;
function POSGetShiftSummary(const ShiftID: Integer): TPOSShiftSummary;
// Kind: 1 = intrare, -1 = iesire
procedure POSCashMove(const ShiftID, Kind: Integer; const Suma: Currency; const Reason: string);
// Intoarce diferenta numarat - asteptat
function POSCloseShift(const ShiftID: Integer; const CountedCash: Currency; const ZNumber: Integer;
  const Comments: string): Currency;

// Textul util dintr-o exceptie a bazei: pentru ERR_POS doar mesajul procedurii.
function POSErrorText(const E: Exception): string;

// "Invata" un cod de bare necunoscut: il leaga de produs in TS_GOODS_BARCODE.
procedure POSLearnBarcode(const GoodsID: Integer; const Barcode: string);

function POSRoundMoney(const Value: Double): Currency;

implementation

uses
  Math, DB, IBC, DBAccess, DataModuleDB, FiscalPrinterUtilsUnit;

function POSRoundMoney(const Value: Double): Currency;
begin
  Result := SimpleRoundTo(Value, -2);
end;

{ TPOSTerminal }

procedure TPOSTerminal.Clear;
begin
  PosID := 0;
  Title := '';
  FirmaID := 0;
  StockID := 0;
  FPID := 0;
  DefaultCustomerID := 0;
  PriceColumn := 1;
  MaxDiscountP := 0;
end;

function TPOSTerminal.IsValid: Boolean;
begin
  Result := PosID > 0;
end;

{ TPOSShift }

procedure TPOSShift.Clear;
begin
  ShiftID := 0;
  UserID := 0;
  OpenedAt := 0;
  OpenCash := 0;
end;

function TPOSShift.IsOpen: Boolean;
begin
  Result := ShiftID > 0;
end;

{ TPOSFoundGoods }

function TPOSFoundGoods.NeedsSerial: Boolean;
begin
  Result := SerialTypeID = cPOS_SerialType_Serii;
end;

{ TPOSPayment }

function TPOSPayment.Change: Currency;
begin
  if Tendered > Suma then
    Result := Tendered - Suma
  else
    Result := 0;
end;

{ TPOSCartLine }

function TPOSCartLine.FullSuma: Currency;
begin
  Result := POSRoundMoney(FQty * FPrice);
end;

function TPOSCartLine.NetPrice: Currency;
begin
  Result := POSRoundMoney(FPrice * (100 - FDiscountP) / 100);
end;

function TPOSCartLine.Suma: Currency;
begin
  // reducerea se aplica pe pretul bucatii, ca suma liniei sa fie exact pret * cantitate
  // (SP_POS_CLOSE_SALE scrie in jurnal pretul net si verifica egalitatea)
  Result := POSRoundMoney(NetPrice * FQty);
end;

function TPOSCartLine.DiscountSuma: Currency;
begin
  Result := FullSuma - Suma;
end;

{ TPOSCart }

constructor TPOSCart.Create;
begin
  inherited Create;
  FLines := TObjectList<TPOSCartLine>.Create(True);
  FMaxDiscountP := 0;
end;

destructor TPOSCart.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TPOSCart.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TPOSCart.CheckIndex(const Index: Integer);
begin
  if (Index < 0) or (Index >= FLines.Count) then
    raise EPOSCartError.Create('Linia selectata nu exista in bon.');
end;

function TPOSCart.GetCount: Integer;
begin
  Result := FLines.Count;
end;

function TPOSCart.GetLine(Index: Integer): TPOSCartLine;
begin
  CheckIndex(Index);
  Result := FLines[Index];
end;

function TPOSCart.SerialUsed(const ASerial: string): Boolean;
var
  Line: TPOSCartLine;
begin
  Result := False;
  if Trim(ASerial) = '' then
    Exit;
  for Line in FLines do
    if SameText(Line.Serial, Trim(ASerial)) then
      Exit(True);
end;

function TPOSCart.AddGoods(const Goods: TPOSFoundGoods; const AQty: Double; const ASerial, AScannedCode: string): Integer;
var
  I: Integer;
  Line: TPOSCartLine;
  Serial: string;
begin
  if Goods.GoodsID <= 0 then
    raise EPOSCartError.Create('Produs necunoscut.');
  if AQty <= 0 then
    raise EPOSCartError.Create('Cantitatea trebuie sa fie mai mare ca zero.');
  if Goods.Price <= 0 then
    raise EPOSCartError.CreateFmt('Produsul "%s" nu are pret de vinzare.', [Goods.Title]);

  Serial := Trim(ASerial);
  if Goods.NeedsSerial then
  begin
    if Serial = '' then
      raise EPOSCartError.CreateFmt('Produsul "%s" se vinde cu numar de serie.', [Goods.Title]);
    if AQty <> 1 then
      raise EPOSCartError.Create('Un numar de serie = o bucata.');
    if SerialUsed(Serial) then
      raise EPOSCartError.CreateFmt('Serialul %s este deja in bon.', [Serial]);
  end;

  // acelasi produs, fara serial -> aceeasi linie
  if Serial = '' then
    for I := 0 to FLines.Count - 1 do
      if (FLines[I].GoodsID = Goods.GoodsID) and (FLines[I].Serial = '') then
      begin
        SetQty(I, FLines[I].Qty + AQty);
        Exit(I);
      end;

  if AQty > Goods.StockQty then
    raise EPOSCartError.CreateFmt('Stoc insuficient pentru "%s": disponibil %s.', [Goods.Title, FloatToStr(Goods.StockQty)]);

  Line := TPOSCartLine.Create;
  Line.FGoodsID := Goods.GoodsID;
  Line.FTitle := Goods.Title;
  Line.FCode := Goods.Code;
  Line.FQty := AQty;
  Line.FPrice := Goods.Price;
  Line.FDiscountP := 0;
  for I := 0 to FLines.Count - 1 do
    if FLines[I].GoodsID = Goods.GoodsID then
    begin
      Line.FDiscountP := FLines[I].DiscountP;
      Break;
    end;
  Line.FSerial := Serial;
  Line.FScannedCode := AScannedCode;
  Line.FStockQty := Goods.StockQty;
  Line.FNeedsSerial := Goods.NeedsSerial;
  Result := FLines.Add(Line);
  Changed;
end;

procedure TPOSCart.SetQty(const Index: Integer; const AQty: Double);
var
  Line: TPOSCartLine;
begin
  CheckIndex(Index);
  Line := FLines[Index];
  if AQty <= 0 then
    raise EPOSCartError.Create('Cantitatea trebuie sa fie mai mare ca zero.');
  if Line.NeedsSerial and (AQty <> 1) then
    raise EPOSCartError.Create('Un numar de serie = o bucata. Scanati produsul inca o data.');
  if AQty > Line.StockQty then
    raise EPOSCartError.CreateFmt('Stoc insuficient pentru "%s": disponibil %s.', [Line.Title, FloatToStr(Line.StockQty)]);
  Line.FQty := AQty;
  Changed;
end;

procedure TPOSCart.ChangeQty(const Index: Integer; const Delta: Double);
begin
  CheckIndex(Index);
  if FLines[Index].Qty + Delta <= 0 then
    Delete(Index)
  else
    SetQty(Index, FLines[Index].Qty + Delta);
end;

procedure TPOSCart.SetDiscountP(const Index: Integer; const ADiscountP: Integer);
var
  I, GoodsID: Integer;
begin
  CheckIndex(Index);
  if (ADiscountP < 0) or (ADiscountP > 100) then
    raise EPOSCartError.Create('Reducerea trebuie sa fie intre 0 si 100%.');
  if ADiscountP > FMaxDiscountP then
    raise EPOSCartError.CreateFmt('Reducerea maxima permisa la aceasta casa este %d%%.', [FMaxDiscountP]);
  // acelasi produs pe mai multe linii (seriale) ajunge intr-o singura linie de jurnal,
  // deci trebuie sa aiba acelasi pret net
  GoodsID := FLines[Index].GoodsID;
  for I := 0 to FLines.Count - 1 do
    if FLines[I].GoodsID = GoodsID then
      FLines[I].FDiscountP := ADiscountP;
  Changed;
end;

procedure TPOSCart.SetDiscountPAll(const ADiscountP: Integer);
var
  I: Integer;
  SavedOnChange: TNotifyEvent;
begin
  SavedOnChange := FOnChange;
  FOnChange := nil;
  try
    for I := 0 to FLines.Count - 1 do
      SetDiscountP(I, ADiscountP);
  finally
    FOnChange := SavedOnChange;
  end;
  Changed;
end;

procedure TPOSCart.Delete(const Index: Integer);
begin
  CheckIndex(Index);
  FLines.Delete(Index);
  Changed;
end;

procedure TPOSCart.Clear;
begin
  FLines.Clear;
  Changed;
end;

function TPOSCart.IsEmpty: Boolean;
begin
  Result := FLines.Count = 0;
end;

function TPOSCart.Total: Currency;
var
  Line: TPOSCartLine;
begin
  Result := 0;
  for Line in FLines do
    Result := Result + Line.Suma;
end;

function TPOSCart.TotalDiscount: Currency;
var
  Line: TPOSCartLine;
begin
  Result := 0;
  for Line in FLines do
    Result := Result + Line.DiscountSuma;
end;

function TPOSCart.TotalQty: Double;
var
  Line: TPOSCartLine;
begin
  Result := 0;
  for Line in FLines do
    Result := Result + Line.Qty;
end;

{ Baza de date }

type
  TPOSQueryProc = reference to procedure(Query: TIBCQuery);

// Ruleaza Proc intr-o tranzactie proprie; Commit la succes, Rollback la exceptie.
procedure POSRunInTransaction(const Proc: TPOSQueryProc);
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
begin
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      Proc(Query);
      Query.Close;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

function POSDetectTerminal(out Terminal: TPOSTerminal; out ErrorText: string): Boolean;
var
  T: TPOSTerminal;
  Found: Boolean;
  ComputerName: string;
begin
  T.Clear;
  Found := False;
  ErrorText := '';
  ComputerName := UpperCase(GetCurrentComputerName);
  try
    POSRunInTransaction(
      procedure(Query: TIBCQuery)
      begin
        Query.SQL.Text :=
          'SELECT P.POS_ID, P.TITLE, P.FIRMA_ID, P.STOCKID, P.FP_ID, P.DEFAULT_CUSTOMERID, ' +
          '       P.PRICE_COLUMN, P.MAX_DISCOUNT_P ' +
          'FROM TPOS_TERMINAL P ' +
          'INNER JOIN WS_WORK_STATIONS W ON W.WS_ID = P.WS_ID ' +
          'WHERE (P.FLG_ENABLED = 1) AND (P.FIRMA_ID = :FIRMA_ID) AND (UPPER(W.COMPUTER_NAME) = :COMPUTER_NAME)';
        Query.ParamByName('FIRMA_ID').AsInteger := dmDB.CurrentFirma;
        Query.ParamByName('COMPUTER_NAME').AsString := ComputerName;
        Query.Open;
        if not Query.Eof then
        begin
          T.PosID := Query.FieldByName('POS_ID').AsInteger;
          T.Title := Query.FieldByName('TITLE').AsString;
          T.FirmaID := Query.FieldByName('FIRMA_ID').AsInteger;
          T.StockID := Query.FieldByName('STOCKID').AsInteger;
          T.FPID := Query.FieldByName('FP_ID').AsInteger;
          T.DefaultCustomerID := Query.FieldByName('DEFAULT_CUSTOMERID').AsInteger;
          T.PriceColumn := Query.FieldByName('PRICE_COLUMN').AsInteger;
          T.MaxDiscountP := Query.FieldByName('MAX_DISCOUNT_P').AsInteger;
          Found := True;
        end;
      end);
    if not Found then
      ErrorText := Format('Pe calculatorul %s nu este configurata nicio casa pentru firma curenta. ' +
        'Configurati-o din meniu: Case POS (linga Statii de lucru), apoi Refresh.', [ComputerName]);
  except
    on E: Exception do
      // de regula: schema POS (DB Model/pos.sql) nu este inca rulata pe aceasta baza
      ErrorText := 'Casa nu poate fi determinata: ' + E.Message;
  end;
  Terminal := T;
  Result := Found;
end;

function POSGetOpenShift(const PosID: Integer; out Shift: TPOSShift): Boolean;
var
  S: TPOSShift;
begin
  S.Clear;
  POSRunInTransaction(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text :=
        'SELECT SHIFT_ID, USERID, OPENED_AT, OPEN_CASH FROM TPOS_SHIFT ' +
        'WHERE (POS_ID = :POS_ID) AND (CLOSED_AT IS NULL)';
      Query.ParamByName('POS_ID').AsInteger := PosID;
      Query.Open;
      if not Query.Eof then
      begin
        S.ShiftID := Query.FieldByName('SHIFT_ID').AsInteger;
        S.UserID := Query.FieldByName('USERID').AsInteger;
        S.OpenedAt := Query.FieldByName('OPENED_AT').AsDateTime;
        S.OpenCash := Query.FieldByName('OPEN_CASH').AsCurrency;
      end;
    end);
  Shift := S;
  Result := S.IsOpen;
end;

function POSFindGoods(const AText: string; const PosID: Integer): TPOSFoundGoodsArray;
var
  List: TList<TPOSFoundGoods>;
begin
  List := TList<TPOSFoundGoods>.Create;
  try
    POSRunInTransaction(
      procedure(Query: TIBCQuery)
      var
        G: TPOSFoundGoods;
      begin
        Query.SQL.Text :=
          'SELECT GOODSID, TITLE, CODE, PRICE_MDL, STOCK_QTY, SERIAL_TYPE_ID, MATCH_KIND ' +
          'FROM POS_FIND_GOODS_EX(:ATEXT, :APOS_ID)';
        Query.ParamByName('ATEXT').AsString := Copy(Trim(AText), 1, 128);
        Query.ParamByName('APOS_ID').AsInteger := PosID;
        Query.Open;
        while not Query.Eof do
        begin
          G.GoodsID := Query.FieldByName('GOODSID').AsInteger;
          G.Title := Query.FieldByName('TITLE').AsString;
          G.Code := Query.FieldByName('CODE').AsString;
          G.Price := Query.FieldByName('PRICE_MDL').AsCurrency;
          G.StockQty := Query.FieldByName('STOCK_QTY').AsFloat;
          G.SerialTypeID := Query.FieldByName('SERIAL_TYPE_ID').AsInteger;
          G.MatchKind := Query.FieldByName('MATCH_KIND').AsInteger;
          List.Add(G);
          Query.Next;
        end;
      end);
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function POSErrorText(const E: Exception): string;
const
  cMarker = 'ERR_POS';
var
  P: Integer;
  Lines: TStringList;
  I: Integer;
begin
  Result := E.Message;
  P := Pos(cMarker, Result);
  if P = 0 then
    Exit;
  Lines := TStringList.Create;
  try
    Lines.Text := Copy(Result, P + Length(cMarker), MaxInt);
    Result := '';
    for I := 0 to Lines.Count - 1 do
    begin
      // dupa mesaj urmeaza "At procedure ... line: ..." - nu intereseaza casierul
      if Pos('At procedure', Lines[I]) = 1 then
        Break;
      if Trim(Lines[I]) <> '' then
        Result := Trim(Result + ' ' + Trim(Lines[I]));
    end;
  finally
    Lines.Free;
  end;
  if (Result <> '') and (Result[1] = '-') then
    Result := Trim(Copy(Result, 2, MaxInt));
  if Result = '' then
    Result := E.Message;
end;

// Ruleaza Proc; o exceptie ERR_POS a bazei devine EPOSError cu mesajul curat.
procedure POSRunChecked(const Proc: TPOSQueryProc);
begin
  try
    POSRunInTransaction(Proc);
  except
    on E: Exception do
      if Pos('ERR_POS', E.Message) > 0 then
        raise EPOSError.Create(POSErrorText(E))
      else
        raise;
  end;
end;

function POSOpenShift(const PosID: Integer; const OpenCash: Currency): Integer;
var
  ShiftID: Integer;
begin
  ShiftID := 0;
  POSRunChecked(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text := 'SELECT SHIFT_ID FROM SP_POS_SHIFT_OPEN(:APOS_ID, :AOPEN_CASH)';
      Query.ParamByName('APOS_ID').AsInteger := PosID;
      Query.ParamByName('AOPEN_CASH').AsCurrency := OpenCash;
      Query.Open;
      ShiftID := Query.FieldByName('SHIFT_ID').AsInteger;
    end);
  Result := ShiftID;
end;

function POSGetShiftSummary(const ShiftID: Integer): TPOSShiftSummary;
var
  R: TPOSShiftSummary;
begin
  FillChar(R, SizeOf(R), 0);
  POSRunChecked(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text := 'SELECT * FROM SP_POS_SHIFT_SUMMARY(:ASHIFT_ID)';
      Query.ParamByName('ASHIFT_ID').AsInteger := ShiftID;
      Query.Open;
      if Query.Eof then
        Exit;
      R.OpenCash := Query.FieldByName('OPEN_CASH').AsCurrency;
      R.CashSales := Query.FieldByName('CASH_SALES').AsCurrency;
      R.CardSales := Query.FieldByName('CARD_SALES').AsCurrency;
      R.OtherSales := Query.FieldByName('OTHER_SALES').AsCurrency;
      R.CashIn := Query.FieldByName('CASH_IN').AsCurrency;
      R.CashOut := Query.FieldByName('CASH_OUT').AsCurrency;
      R.ExpectedCash := Query.FieldByName('EXPECTED_CASH').AsCurrency;
      R.SalesCount := Query.FieldByName('SALES_COUNT').AsInteger;
      R.OpenCount := Query.FieldByName('OPEN_COUNT').AsInteger;
      R.ParkedCount := Query.FieldByName('PARKED_COUNT').AsInteger;
    end);
  Result := R;
end;

procedure POSCashMove(const ShiftID, Kind: Integer; const Suma: Currency; const Reason: string);
begin
  POSRunChecked(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text := 'SELECT MOVE_ID FROM SP_POS_CASH_MOVE(:ASHIFT_ID, :AKIND, :ASUMA, :AREASON)';
      Query.ParamByName('ASHIFT_ID').AsInteger := ShiftID;
      Query.ParamByName('AKIND').AsInteger := Kind;
      Query.ParamByName('ASUMA').AsCurrency := Suma;
      Query.ParamByName('AREASON').AsString := Copy(Trim(Reason), 1, 256);
      Query.Open;
    end);
end;

function POSCloseShift(const ShiftID: Integer; const CountedCash: Currency; const ZNumber: Integer;
  const Comments: string): Currency;
var
  Diff: Currency;
begin
  Diff := 0;
  POSRunChecked(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text :=
        'SELECT EXPECTED_CASH, DIFF_CASH FROM SP_POS_SHIFT_CLOSE(:ASHIFT_ID, :ACOUNTED_CASH, :AZ_NUMBER, :ACOMMENTS)';
      Query.ParamByName('ASHIFT_ID').AsInteger := ShiftID;
      Query.ParamByName('ACOUNTED_CASH').AsCurrency := CountedCash;
      if ZNumber > 0 then
        Query.ParamByName('AZ_NUMBER').AsInteger := ZNumber
      else
      begin
        Query.ParamByName('AZ_NUMBER').DataType := ftInteger;
        Query.ParamByName('AZ_NUMBER').Clear;
      end;
      Query.ParamByName('ACOMMENTS').AsString := Copy(Trim(Comments), 1, 1024);
      Query.Open;
      Diff := Query.FieldByName('DIFF_CASH').AsCurrency;
    end);
  Result := Diff;
end;

procedure POSLearnBarcode(const GoodsID: Integer; const Barcode: string);
begin
  if (GoodsID <= 0) or (Trim(Barcode) = '') then
    Exit;
  POSRunInTransaction(
    procedure(Query: TIBCQuery)
    begin
      Query.SQL.Text :=
        'UPDATE OR INSERT INTO TS_GOODS_BARCODE (GOODSID, BARCODE) VALUES (:GOODSID, :BARCODE) ' +
        'MATCHING (GOODSID, BARCODE)';
      Query.ParamByName('GOODSID').AsInteger := GoodsID;
      Query.ParamByName('BARCODE').AsString := Trim(Barcode);
      Query.ExecSQL;
    end);
end;

end.

unit POSCheckoutUnit;

{
  POS - incasarea bonului. Aparatul fiscal NU participa la tranzactia bazei, de aceea ordinea e:

    1. conectare la aparat (fara aparat nu se vinde)
    2. tranzactie: TPOS_SALE + linii + plati -> SP_POS_CLOSE_SALE (107, 112, 116/120) - NECOMIS
    3. liniile bonului se citesc din GET_GOODS_FOR_RECEIPT(factura 112), ca in fluxul clasic
    4. jurnal local de recuperare (fisier) - inainte de a tipari
    5. tiparire; esec inainte de inchiderea bonului -> CancelReceipt + Rollback, nu ramine nimic
    6. SP_POS_REGISTER_RECEIPT (bonul se leaga de factura fiscala 112) + Commit
    7. esec la pasul 6 = bon tiparit dar neinregistrat: jurnalul ramine pe disc si casierul e avertizat

  Rezultatul spune exact in care din cele trei situatii sintem.
}

interface

uses
  SysUtils, Classes, POSSaleUnit;

type
  TPOSCheckoutOutcome = (
    pcoDone,              // bon tiparit si inregistrat
    pcoFailedClean,       // nimic tiparit, nimic in baza - se poate reincerca
    pcoPrintedNotSaved);  // bon tiparit, baza NU - cere interventie (jurnalul e pe disc)

  TPOSCheckoutResult = record
    Outcome: TPOSCheckoutOutcome;
    SaleID: Integer;
    RashodDocID: Integer;
    FacturaDocID: Integer;
    NumarBon: Integer;
    DataBon: TDateTime;
    ErrorText: string;
    JournalFile: string;
  end;

  // Aparatul a inchis bonul, dar numarul nu a putut fi citit: casierul il citeste de pe hirtie.
  // Intoarce 0 daca renunta.
  TPOSAskReceiptNumber = reference to function: Integer;

function POSCheckout(const Terminal: TPOSTerminal; const Shift: TPOSShift; const Cart: TPOSCart;
  const CustomerID: Integer; const Payments: TPOSPaymentArray;
  const AskReceiptNumber: TPOSAskReceiptNumber): TPOSCheckoutResult;

// Fisierul de recuperare al casei (exista = un bon tiparit a ramas neinregistrat)
function POSPendingJournalFile(const PosID: Integer): string;

implementation

uses
  DB, IBC, DBAccess, DataModuleDB, FiscalDeviceUnit;

// Codul stabil al platii POS (TS_SYSS.VALUE_STR) -> tipul de plata pe aparatul fiscal
function POSFiscalPayKind(const PayCode: string): TFiscalPayKind;
begin
  if PayCode = 'PAY_CASH' then
    Result := fpkCash
  else if PayCode = 'PAY_POS' then
    Result := fpkCard
  else if PayCode = 'PAY_QR_MIA' then
    Result := fpkOnline
  else
    raise EPOSError.Create('Tip de plata necunoscut pentru aparatul fiscal: ' + PayCode);
end;

function POSPendingJournalFile(const PosID: Integer): string;
var
  Dir: string;
begin
  Dir := IncludeTrailingPathDelimiter(GetEnvironmentVariable('LOCALAPPDATA')) + 'SWN';
  ForceDirectories(Dir);
  Result := IncludeTrailingPathDelimiter(Dir) + Format('pos_pending_%d.txt', [PosID]);
end;

procedure WriteJournal(const FileName: string; const Terminal: TPOSTerminal; const Shift: TPOSShift;
  const Cart: TPOSCart; const CustomerID: Integer; const Payments: TPOSPaymentArray; const R: TPOSCheckoutResult;
  const Stage: string);
var
  L: TStringList;
  I: Integer;
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Invariant;
  L := TStringList.Create;
  try
    L.Add('POS - bon in curs de incasare. Daca acest fisier exista dupa incasare, bonul fiscal');
    L.Add('a fost tiparit, dar documentele NU au ajuns in baza. Nu stergeti fisierul.');
    L.Add('stage=' + Stage);
    L.Add('time=' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));
    L.Add(Format('pos=%d firma=%d stock=%d shift=%d user=%d customer=%d',
      [Terminal.PosID, Terminal.FirmaID, Terminal.StockID, Shift.ShiftID, dmDB.CurrentUserID, CustomerID]));
    L.Add(Format('sale=%d rashod=%d factura=%d bon=%d', [R.SaleID, R.RashodDocID, R.FacturaDocID, R.NumarBon]));
    for I := 0 to Cart.Count - 1 do
      L.Add(Format('item goods=%d qty=%s netprice=%s suma=%s sn=%s',
        [Cart[I].GoodsID, FloatToStr(Cart[I].Qty, FS), CurrToStr(Cart[I].NetPrice, FS), CurrToStr(Cart[I].Suma, FS),
         Cart[I].Serial]));
    for I := 0 to High(Payments) do
      L.Add(Format('pay code=%s suma=%s tendered=%s ref=%s',
        [Payments[I].PayCode, CurrToStr(Payments[I].Suma, FS), CurrToStr(Payments[I].Tendered, FS), Payments[I].ExtRef]));
    L.SaveToFile(FileName);
  finally
    L.Free;
  end;
end;

function POSCheckout(const Terminal: TPOSTerminal; const Shift: TPOSShift; const Cart: TPOSCart;
  const CustomerID: Integer; const Payments: TPOSPaymentArray;
  const AskReceiptNumber: TPOSAskReceiptNumber): TPOSCheckoutResult;
var
  R: TPOSCheckoutResult;
  Fiscal: IFiscalDevice;
  Tr: TIBCTransaction;
  Query: TIBCQuery;
  Receipt: TFiscalReceipt;
  Printed: TFiscalReceiptResult;
  I, VatPercent: Integer;
  PaySum, LinesSum, Suma, SumaVat, Price: Currency;
  Qty: Double;
  ErrorText: string;

  procedure Fail(const Text: string);
  begin
    R.Outcome := pcoFailedClean;
    R.ErrorText := Text;
  end;

begin
  R := Default(TPOSCheckoutResult);
  R.Outcome := pcoFailedClean;
  R.JournalFile := POSPendingJournalFile(Terminal.PosID);
  Result := R;

  if Cart.IsEmpty then
  begin
    Fail('Bonul este gol.');
    Exit(R);
  end;
  PaySum := 0;
  for I := 0 to High(Payments) do
    PaySum := PaySum + Payments[I].Suma;
  if PaySum <> Cart.Total then
  begin
    Fail(Format('Platile (%s) nu acopera exact bonul (%s).', [CurrToStr(PaySum), CurrToStr(Cart.Total)]));
    Exit(R);
  end;
  if FileExists(R.JournalFile) then
  begin
    Fail('Exista un bon tiparit si neinregistrat: ' + R.JournalFile + sLineBreak +
      'Rezolvati-l inainte de a incasa alt bon.');
    Exit(R);
  end;

  Fiscal := nil;
  Tr := TIBCTransaction.Create(nil);
  Query := TIBCQuery.Create(nil);
  try
    // 1. fara aparat fiscal nu se vinde
    try
      Fiscal := CreateFiscalDevice(Terminal.FirmaID);
    except
      on E: Exception do
      begin
        Fail('Aparatul fiscal nu este disponibil: ' + E.Message);
        Exit(R);
      end;
    end;
    if not Fiscal.Connect(ErrorText) then
    begin
      Fail('Aparatul fiscal nu este disponibil: ' + ErrorText);
      Exit(R);
    end;

    Tr.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Tr;
    Tr.StartTransaction;
    try
      // 2. bonul POS + documentele, necomis
      Query.SQL.Text := 'SELECT NEXT VALUE FOR GEN_TPOS_SALE_ID FROM RDB$DATABASE';
      Query.Open;
      R.SaleID := Query.Fields[0].AsInteger;
      Query.Close;

      Query.SQL.Text :=
        'INSERT INTO TPOS_SALE (SALE_ID, POS_ID, SHIFT_ID, STATEID, CUSTOMERID, CREATED_BY) ' +
        'VALUES (:SALE_ID, :POS_ID, :SHIFT_ID, 0, :CUSTOMERID, :CREATED_BY)';
      Query.ParamByName('SALE_ID').AsInteger := R.SaleID;
      Query.ParamByName('POS_ID').AsInteger := Terminal.PosID;
      Query.ParamByName('SHIFT_ID').AsInteger := Shift.ShiftID;
      Query.ParamByName('CUSTOMERID').AsInteger := CustomerID;
      Query.ParamByName('CREATED_BY').AsInteger := dmDB.CurrentUserID;
      Query.Execute;

      Query.SQL.Text :=
        'INSERT INTO TPOS_SALE_ITEM (SALE_ID, ORDERNO, GOODSID, QTY, PRICE, DISCOUNT_P, DISCOUNT_SUMA, SUMA, SN, SCANNED_CODE) ' +
        'VALUES (:SALE_ID, :ORDERNO, :GOODSID, :QTY, :PRICE, :DISCOUNT_P, :DISCOUNT_SUMA, :SUMA, :SN, :SCANNED_CODE)';
      for I := 0 to Cart.Count - 1 do
      begin
        Query.ParamByName('SALE_ID').AsInteger := R.SaleID;
        Query.ParamByName('ORDERNO').AsInteger := I + 1;
        Query.ParamByName('GOODSID').AsInteger := Cart[I].GoodsID;
        Query.ParamByName('QTY').AsFloat := Cart[I].Qty;
        Query.ParamByName('PRICE').AsCurrency := Cart[I].Price;
        Query.ParamByName('DISCOUNT_P').AsInteger := Cart[I].DiscountP;
        Query.ParamByName('DISCOUNT_SUMA').AsCurrency := Cart[I].DiscountSuma;
        Query.ParamByName('SUMA').AsCurrency := Cart[I].Suma;
        Query.ParamByName('SN').AsString := Cart[I].Serial;
        Query.ParamByName('SCANNED_CODE').AsString := Cart[I].ScannedCode;
        Query.Execute;
      end;

      Query.SQL.Text :=
        'INSERT INTO TPOS_SALE_PAYMENT (SALE_ID, PAY_CODE, SUMA, TENDERED, CHANGE_SUMA, EXT_REF) ' +
        'VALUES (:SALE_ID, :PAY_CODE, :SUMA, :TENDERED, :CHANGE_SUMA, :EXT_REF)';
      for I := 0 to High(Payments) do
      begin
        Query.ParamByName('SALE_ID').AsInteger := R.SaleID;
        Query.ParamByName('PAY_CODE').AsString := Payments[I].PayCode;
        Query.ParamByName('SUMA').AsCurrency := Payments[I].Suma;
        Query.ParamByName('TENDERED').AsCurrency := Payments[I].Tendered;
        Query.ParamByName('CHANGE_SUMA').AsCurrency := Payments[I].Change;
        Query.ParamByName('EXT_REF').AsString := Payments[I].ExtRef;
        Query.Execute;
      end;

      Query.SQL.Text := 'SELECT RASHOD_DOCID, FACTURA_DOCID FROM SP_POS_CLOSE_SALE(:ASALE_ID)';
      Query.ParamByName('ASALE_ID').AsInteger := R.SaleID;
      Query.Open;
      R.RashodDocID := Query.FieldByName('RASHOD_DOCID').AsInteger;
      R.FacturaDocID := Query.FieldByName('FACTURA_DOCID').AsInteger;
      Query.Close;

      // 3. liniile bonului - aceeasi sursa ca dialogul clasic de bon fiscal
      Query.SQL.Text := 'SELECT NAMEACNT, QTY, PRICE, SUMAVAT FROM GET_GOODS_FOR_RECEIPT(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := R.FacturaDocID;
      Query.Open;
      LinesSum := 0;
      Receipt.Clear;
      Receipt.DocID := R.FacturaDocID;
      Receipt.SourceType := 2;   // bon POS (TFP_ECC_TRANSACTION.SOURCE_TYPE)
      Receipt.SourceRef := IntToStr(R.SaleID);
      while not Query.Eof do
      begin
        Qty := Query.FieldByName('QTY').AsFloat;
        Price := Query.FieldByName('PRICE').AsCurrency;
        Suma := POSRoundMoney(Price * Qty);
        SumaVat := Query.FieldByName('SUMAVAT').AsCurrency;
        if (SumaVat > 0) and (Suma - SumaVat > 0) then
          VatPercent := Round(100 * SumaVat / (Suma - SumaVat))
        else
          VatPercent := 0;
        Receipt.AddLine(Trim(Query.FieldByName('NAMEACNT').AsString), Qty, Price, VatPercent);
        LinesSum := LinesSum + Suma;
        Query.Next;
      end;
      Query.Close;

      if Length(Receipt.Lines) = 0 then
        raise EPOSError.Create('Factura nu are linii pentru bonul fiscal.');
      // aparatul ar refuza plata daca suma liniilor difera de plati - mai bine ne oprim inainte
      if LinesSum <> PaySum then
        raise EPOSError.CreateFmt('Suma liniilor pentru bon (%s) difera de plati (%s).',
          [CurrToStr(LinesSum), CurrToStr(PaySum)]);
      for I := 0 to High(Payments) do
        Receipt.AddPayment(POSFiscalPayKind(Payments[I].PayCode), Payments[I].Suma);
    except
      on E: Exception do
      begin
        if Tr.Active then
          Tr.Rollback;
        Fail(POSErrorText(E));
        Exit(R);
      end;
    end;

    // 4. jurnalul de recuperare, inainte de a tipari
    try
      WriteJournal(R.JournalFile, Terminal, Shift, Cart, CustomerID, Payments, R, 'before-print');
    except
      on E: Exception do
      begin
        Tr.Rollback;
        Fail('Jurnalul de recuperare nu poate fi scris: ' + E.Message);
        Exit(R);
      end;
    end;

    // 5. tiparirea. O exceptie = pe aparat nu a ramas nimic (bonul deschis e anulat de aparat)
    try
      Printed := Fiscal.PrintReceipt(Receipt);
    except
      on E: Exception do
      begin
        Tr.Rollback;
        DeleteFile(R.JournalFile);
        Fail(E.Message);
        Exit(R);
      end;
    end;
    R.NumarBon := Printed.Number;
    R.DataBon := Printed.DateTime;
    if Printed.State = frsPending then
    begin
      // ECC: cererea a plecat, rezultatul nu e cunoscut. Bonul NU se repeta si nu se cere numarul:
      // documentele nu se salveaza, jurnalul local ramine, iar bonul se verifica in jurnalul ECC
      Tr.Rollback;
      R.Outcome := pcoPrintedNotSaved;
      R.NumarBon := 0;
      R.ErrorText := Printed.Warning;
      try
        WriteJournal(R.JournalFile, Terminal, Shift, Cart, CustomerID, Payments, R, 'ecc-pending ' + Printed.ExternalId);
      except
      end;
      Exit(R);
    end;
    if Printed.State = frsNumberUnknown then
    begin
      // bonul e inchis pe aparat, doar numarul nu s-a citit
      R.ErrorText := Printed.Warning;
      R.NumarBon := 0;
    end;

    if R.NumarBon <= 0 then
    begin
      if Assigned(AskReceiptNumber) then
        R.NumarBon := AskReceiptNumber();
      if R.NumarBon <= 0 then
      begin
        Tr.Rollback;
        R.Outcome := pcoPrintedNotSaved;
        if R.ErrorText = '' then
          R.ErrorText := 'Numarul bonului fiscal nu este cunoscut.';
        try
          WriteJournal(R.JournalFile, Terminal, Shift, Cart, CustomerID, Payments, R, 'printed-no-number');
        except
        end;
        Exit(R);
      end;
      R.DataBon := Now;
    end;

    // 6. bonul se leaga de factura fiscala + commit
    try
      try
        WriteJournal(R.JournalFile, Terminal, Shift, Cart, CustomerID, Payments, R, 'printed');
      except
      end;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_POS_REGISTER_RECEIPT(:ASALE_ID, :ANUMAR_BON, :ADATA, 0)';
      Query.ParamByName('ASALE_ID').AsInteger := R.SaleID;
      Query.ParamByName('ANUMAR_BON').AsInteger := R.NumarBon;
      Query.ParamByName('ADATA').AsDateTime := R.DataBon;
      Query.Execute;
      Tr.Commit;
      // ECC: rindul din TDB_DOCS_RECEIPT se leaga de tranzactia din jurnal (nu e fatal daca nu reuseste)
      Printed.Number := R.NumarBon;
      Printed.DateTime := R.DataBon;
      Fiscal.ConfirmRegistered(Printed, R.FacturaDocID, PaySum);
    except
      on E: Exception do
      begin
        // 7. bon tiparit, baza nu: jurnalul ramine
        if Tr.Active then
          try
            Tr.Rollback;
          except
          end;
        R.Outcome := pcoPrintedNotSaved;
        R.ErrorText := POSErrorText(E);
        Exit(R);
      end;
    end;

    DeleteFile(R.JournalFile);
    R.Outcome := pcoDone;
    R.ErrorText := '';
  finally
    Query.Free;
    Tr.Free;
    Fiscal := nil;
    Result := R;
  end;
end;

end.

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
  DB, IBC, DBAccess, DataModuleDB, POSFiscalUnit;

type
  TFiscalLine = record
    Title: string;
    VatPercent: Integer;
    Price: Currency;
    Qty: Double;
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
  Fiscal: TPOSFiscal;
  Tr: TIBCTransaction;
  Query: TIBCQuery;
  Lines: array of TFiscalLine;
  I: Integer;
  PaySum, LinesSum, Suma, SumaVat: Currency;
  ReceiptClosed: Boolean;
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

  Fiscal := TPOSFiscal.Create;
  Tr := TIBCTransaction.Create(nil);
  Query := TIBCQuery.Create(nil);
  try
    // 1. fara aparat fiscal nu se vinde
    if not Fiscal.Connect(Terminal.FirmaID, ErrorText) then
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
      SetLength(Lines, 0);
      while not Query.Eof do
      begin
        SetLength(Lines, Length(Lines) + 1);
        with Lines[High(Lines)] do
        begin
          Title := Trim(Query.FieldByName('NAMEACNT').AsString);
          Qty := Query.FieldByName('QTY').AsFloat;
          Price := Query.FieldByName('PRICE').AsCurrency;
          Suma := POSRoundMoney(Price * Qty);
          SumaVat := Query.FieldByName('SUMAVAT').AsCurrency;
          if (SumaVat > 0) and (Suma - SumaVat > 0) then
            VatPercent := Round(100 * SumaVat / (Suma - SumaVat))
          else
            VatPercent := 0;
          LinesSum := LinesSum + Suma;
        end;
        Query.Next;
      end;
      Query.Close;

      if Length(Lines) = 0 then
        raise EPOSError.Create('Factura nu are linii pentru bonul fiscal.');
      // aparatul ar refuza plata daca suma liniilor difera de plati - mai bine ne oprim inainte
      if LinesSum <> PaySum then
        raise EPOSError.CreateFmt('Suma liniilor pentru bon (%s) difera de plati (%s).',
          [CurrToStr(LinesSum), CurrToStr(PaySum)]);
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

    // 5. tiparirea
    ReceiptClosed := False;
    try
      Fiscal.OpenReceipt;
      for I := 0 to High(Lines) do
        Fiscal.SellLine(Lines[I].Title, Lines[I].VatPercent, Lines[I].Price, Lines[I].Qty);
      for I := 0 to High(Payments) do
        Fiscal.Pay(Payments[I].PayCode, Payments[I].Suma);
      Fiscal.CloseReceipt(R.NumarBon, R.DataBon, ReceiptClosed);
    except
      on E: Exception do
      begin
        if not ReceiptClosed then
        begin
          Fiscal.CancelReceipt;
          Tr.Rollback;
          DeleteFile(R.JournalFile);
          Fail(E.Message);
          Exit(R);
        end;
        // bonul e inchis pe aparat, doar numarul nu s-a citit
        R.ErrorText := E.Message;
        R.NumarBon := 0;
      end;
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
    Fiscal.Free;
    Result := R;
  end;
end;

end.

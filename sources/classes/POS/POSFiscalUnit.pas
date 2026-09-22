unit POSFiscalUnit;

{
  POS - operatiile de tura pe aparatul fiscal (Tremol, prin serverul ZFPLab):
  raport X / Z, sertar, intrari si iesiri de numerar.

  Conectarea foloseste aceeasi configurare ca dialogul de service al MCC
  (FP_DEVICES / FP_DEVICE_ACCESS -> GetFiscalPrinterServer + ConnectTremolFiscalPrinter).
  Erorile nu se afiseaza aici: ies ca EPOSFiscalError, iar apelantul decide ce face.
}

interface

uses
  SysUtils, Tremol.FP, Tremol.FP_core, FiscalPrinterUtilsUnit;

type
  EPOSFiscalError = class(Exception);

  TPOSFiscal = class
  private
    FFP: FP;
    FConnected: Boolean;
    procedure RaiseFiscal(const Action: string; const E: Exception);
    procedure CheckConnected;
  public
    constructor Create;
    destructor Destroy; override;
    // False = aparatul nu a fost gasit; ErrorText spune de ce
    function Connect(const FirmaID: Integer; out ErrorText: string): Boolean;
    procedure PrintXReport;
    // Tipareste Z si intoarce numarul raportului (0 daca aparatul nu il raporteaza)
    function PrintZReport: Integer;
    procedure OpenDrawer;
    // Suma > 0 = intrare in sertar, Suma < 0 = iesire
    procedure CashInOut(const Suma: Currency; const Text: string);

    // Bonul fiscal, pas cu pas. Orice esec iese ca EPOSFiscalError; apelantul cheama CancelReceipt.
    procedure OpenReceipt;
    // VatPercent = 0 -> clasa E (fara TVA), altfel clasa A - ca in frmReceiptPrintDialogV2
    procedure SellLine(const Title: string; const VatPercent: Integer; const Price: Currency; const Qty: Double);
    // PayCode = PAY_CASH / PAY_POS / PAY_QR_MIA
    procedure Pay(const PayCode: string; const Suma: Currency);
    // Inchide bonul. ReceiptClosed din CloseReceipt devine True din clipa in care aparatul a
    // acceptat inchiderea - dupa acest punct bonul EXISTA fiscal, chiar daca citirea numarului esueaza.
    procedure CloseReceipt(out NumarBon: Integer; out DataBon: TDateTime; out ReceiptClosed: Boolean);
    // Anuleaza bonul deschis; nu arunca exceptii (se cheama pe calea de eroare)
    procedure CancelReceipt;
    property Connected: Boolean read FConnected;
  end;

implementation

uses
  ActiveX;

const
  // operatorul folosit si la tiparirea bonurilor (frmReceiptPrintDialogV2)
  cOperNum = 1;
  cOperPass = '0000';

{ TPOSFiscal }

constructor TPOSFiscal.Create;
begin
  inherited Create;
  CoInitialize(nil);
  FFP := FP.Create;
  FConnected := False;
end;

destructor TPOSFiscal.Destroy;
begin
  FFP.Free;
  CoUninitialize;
  inherited;
end;

procedure TPOSFiscal.RaiseFiscal(const Action: string; const E: Exception);
var
  Text: string;
begin
  if E is SException then
    Text := SException(E).GetMessage
  else
    Text := E.Message;
  if Trim(Text) = '' then
    Text := E.ClassName;
  raise EPOSFiscalError.CreateFmt('%s: %s', [Action, Text]);
end;

procedure TPOSFiscal.CheckConnected;
begin
  if not FConnected then
    raise EPOSFiscalError.Create('Aparatul fiscal nu este conectat.');
end;

function TPOSFiscal.Connect(const FirmaID: Integer; out ErrorText: string): Boolean;
var
  Server: TFiscalPrinterServer;
  Connection: TTremolConnection;
begin
  ErrorText := '';
  FConnected := False;
  try
    Server := GetFiscalPrinterServer(FirmaID);
    FFP.ServerAddress := Server.ServerAddress;
    // obligatoriu inainte de ConnectTremolFiscalPrinter
    FFP.ApplyClientLibraryDefinitions();
    Connection := ConnectTremolFiscalPrinter(FFP, Server);
    FConnected := Connection.Connected;
    if not FConnected then
      if Connection.ServerReachable then
        ErrorText := 'Aparatul fiscal nu a fost gasit pe niciun port COM.'
      else
        ErrorText := 'Serverul aparatului fiscal nu raspunde: ' + Server.ServerAddress;
  except
    on E: Exception do
      if E is SException then
        ErrorText := SException(E).GetMessage
      else
        ErrorText := E.Message;
  end;
  Result := FConnected;
end;

procedure TPOSFiscal.PrintXReport;
begin
  CheckConnected;
  try
    FFP.PrintDailyReport(z_Without_zeroing);
  except
    on E: Exception do
      RaiseFiscal('Raportul X nu a fost tiparit', E);
  end;
end;

function TPOSFiscal.PrintZReport: Integer;
var
  Info: LastDailyReportInfoRes;
begin
  CheckConnected;
  try
    FFP.PrintDailyReport(z_Zeroing);
  except
    on E: Exception do
      RaiseFiscal('Raportul Z nu a fost tiparit', E);
  end;

  // Z-ul e deja tiparit; daca numarul nu poate fi citit, tura se inchide fara el
  Result := 0;
  try
    Info := FFP.ReadLastDailyReportInfo();
    if Info <> nil then
      try
        Result := Round(Info.NoLastZDailyReport);
      finally
        Info.Free;
      end;
  except
    Result := 0;
  end;
end;

procedure TPOSFiscal.OpenDrawer;
begin
  CheckConnected;
  try
    FFP.SafeBoxOpen;
  except
    on E: Exception do
      RaiseFiscal('Sertarul nu a fost deschis', E);
  end;
end;

procedure TPOSFiscal.OpenReceipt;
begin
  CheckConnected;
  try
    FFP.OpenReceipt_V2(cOperNum, cOperPass, fpt_Step_by_step_printing);
  except
    on E: Exception do
      RaiseFiscal('Bonul fiscal nu a putut fi deschis', E);
  end;
end;

procedure TPOSFiscal.SellLine(const Title: string; const VatPercent: Integer; const Price: Currency; const Qty: Double);
var
  Name: string;
begin
  CheckConnected;
  // aparatul accepta 34 de caractere pentru denumire
  Name := Copy(StringReplace(Trim(Title), '  ', ' ', [rfReplaceAll]), 1, 34);
  try
    if VatPercent = 0 then
      FFP.SellPLUwithSpecifiedVAT(Name, vatc_VAT_Class_E, Price, Qty, 0, 0, '', '')
    else
      FFP.SellPLUwithSpecifiedVAT(Name, vatc_VAT_Class_A, Price, Qty, 0, 0, '', '');
  except
    on E: Exception do
      RaiseFiscal('Linia "' + Name + '" nu a fost acceptata de aparat', E);
  end;
end;

procedure TPOSFiscal.Pay(const PayCode: string; const Suma: Currency);
begin
  CheckConnected;
  try
    if PayCode = 'PAY_CASH' then
      FFP.Payment_V2_1(ptv21_NUMERAR, c_Without_Change, Suma, ct_Empty)
    else if PayCode = 'PAY_POS' then
      FFP.Payment_V2_1(ptv21_CARD_PLATA, c_Without_Change, Suma, ct_Empty)
    else if PayCode = 'PAY_QR_MIA' then
      // QR MIA = plata instant din cont; pe aparat: "alt instrument de plata"
      FFP.Payment_V2_1(ptv21_ALT_IP, c_Without_Change, Suma, ct_Empty)
    else
      raise EPOSFiscalError.Create('Tip de plata necunoscut pentru aparat: ' + PayCode);
  except
    on E: EPOSFiscalError do
      raise;
    on E: Exception do
      RaiseFiscal('Plata nu a fost acceptata de aparat', E);
  end;
end;

procedure TPOSFiscal.CloseReceipt(out NumarBon: Integer; out DataBon: TDateTime; out ReceiptClosed: Boolean);
var
  Info: LastReceiptNumRes;
begin
  NumarBon := 0;
  DataBon := Now;
  ReceiptClosed := False;
  CheckConnected;
  try
    FFP.CloseReceipt;
  except
    on E: Exception do
      RaiseFiscal('Bonul fiscal nu a putut fi inchis', E);
  end;
  ReceiptClosed := True;

  try
    Info := FFP.ReadLastReceiptNum();
    if Info <> nil then
      try
        NumarBon := Trunc(Info.DailyReceiptCounter);
      finally
        Info.Free;
      end;
    DataBon := FFP.ReadDateTime;
  except
    on E: Exception do
      RaiseFiscal('Bonul a fost tiparit, dar numarul lui nu a putut fi citit', E);
  end;
end;

procedure TPOSFiscal.CancelReceipt;
begin
  if not FConnected then
    Exit;
  try
    FFP.CancelReceipt;
  except
    // pe calea de eroare nu mai avem ce face; casierul vede starea pe aparat
  end;
end;

procedure TPOSFiscal.CashInOut(const Suma: Currency; const Text: string);
begin
  CheckConnected;
  if Suma = 0 then
    Exit;
  try
    FFP.ReceivedOnAccount_PaidOut(cOperNum, cOperPass, Suma, Copy(Text, 1, 30));
  except
    on E: Exception do
      RaiseFiscal('Miscarea de numerar nu a fost inregistrata pe aparat', E);
  end;
end;

end.

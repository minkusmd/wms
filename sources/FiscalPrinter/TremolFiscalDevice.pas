unit TremolFiscalDevice;

(* IFiscalDevice pentru MCC Tremol, NUMAI prin serverul ZFPLab (localhost:4444 sau
   adresa din FP_DEVICES) - regula din 23 sep 2026, fara zfpcom.dll.

   Codul vine din POSFiscalUnit (POS) si din frmReceiptPrintDialogV2 (bonul din
   factura), unificate:
     - conectarea: GetFiscalDeviceInfo -> ApplyClientLibraryDefinitions ->
       ConnectTremolFiscalPrinter;
     - clasa TVA: 0 % -> E, orice alta cota -> A (aparatul trebuie sa aiba A = 20 %);
     - operatorul 1 / parola '0000';
     - platile fara rest (c_Without_Change).
   Diferenta fata de codul vechi al dialogului de bon: o eroare inainte de
   inchiderea bonului il ANULEAZA pe aparat si iese ca EFiscalDeviceError; pina
   acum bonul ramanea deschis pe aparat sau era salvat in baza ca tiparit. *)

interface

uses
  System.SysUtils, Tremol.FP, Tremol.FP_core, FiscalPrinterUtilsUnit, FiscalDeviceUnit;

type
  TTremolFiscalDevice = class(TInterfacedObject, IFiscalDevice)
  private
    FFP: FP;
    FInfo: TFiscalDeviceInfo;
    FConnected: Boolean;
    FPort: string;
    FServerReachable: Boolean;
    procedure RaiseFiscal(const AAction: string; const E: Exception);
    procedure CheckConnected;
    procedure OpenReceipt;
    procedure SellLine(const ATitle: string; const AVatPercent: Integer; const APrice: Currency; const AQty: Double);
    procedure Pay(const AKind: TFiscalPayKind; const AAmount: Currency);
    procedure CancelOpenReceipt;
  public
    constructor Create(const AInfo: TFiscalDeviceInfo);
    destructor Destroy; override;
    { IFiscalDevice }
    function Kind: TFiscalDeviceKind;
    function Info: TFiscalDeviceInfo;
    function Connect(out AErrorText: string): Boolean;
    function Connected: Boolean;
    function ReadStatus: TFiscalDeviceStatus;
    function PrintReceipt(const R: TFiscalReceipt): TFiscalReceiptResult;
    procedure CashInOut(const Suma: Currency; const Text: string);
    procedure PrintXReport;
    function PrintZReport: Integer;
    procedure OpenDrawer;
    function ConfirmRegistered(const AResult: TFiscalReceiptResult; const ADocID: Integer;
      const ASuma: Currency): Boolean;
    property ServerReachable: Boolean read FServerReachable;
  end;

// Textul unei erori Tremol (SException) pe intelesul casierului.
function TremolErrorText(const E: Exception): string;

implementation

uses
  Winapi.ActiveX;

const
  cOperNum = 1;
  cOperPass = '0000';
  cMaxTitleLength = 34;   // aparatul accepta 34 de caractere pentru denumire

function TremolErrorText(const E: Exception): string;
var
  sx: SException;
begin
  Result := '';
  if E is SException then
  begin
    sx := SException(E);
    case sx.ErrType of
      ServerAddressNotSet:
        Result := 'Adresa serverului ZFPLab nu este indicata';
      ServerConnectionError:
        Result := 'Nu exista conexiune cu serverul ZFPLab';
      ServerDefsMismatch:
        Result := 'Versiunea bibliotecii nu corespunde definitiilor serverului ZFPLab';
      ServMismatchBetweenDefinitionAndFPResult:
        Result := 'Versiunea bibliotecii nu corespunde firmware-ului aparatului fiscal';
      ServSockConnectionFailed:
        Result := 'Serverul ZFPLab nu se poate conecta la aparatul fiscal';
      ServTCPAuth:
        Result := 'Parola TCP a aparatului este gresita';
      ServWaitOtherClientCmdProcessingTimeOut:
        Result := 'Aparatul executa prea mult timp comanda altui calculator';
      FPException:
        if sx.FPLibErrorCode > $100 then
          case sx.FPLibErrorCode of
            $109: Result := 'Aparatul fiscal lipseste';
            $10A: Result := 'Aparatul fiscal este ocupat';
            $102: Result := 'Timpul de asteptare a raspunsului de la aparat a expirat';
            $10F: Result := 'Conexiunea cu aparatul nu este disponibila';
            $110: Result := 'S-a terminat hirtia';
            $111: Result := 'Aparatul are deja o conexiune deschisa de la alt calculator';
            $112: Result := 'Parola de retea ZFP este gresita';
            $113: Result := 'Aparatul asteapta parola de retea';
          end
        else if (sx.ste1 = $30) and (sx.ste2 = $32) then
          Result := 'Comanda nu este permisa in starea curenta a aparatului'
        else if (sx.ste1 = $30) and (sx.ste2 = $33) then
          Result := 'Trebuie facut raportul Z'
        else if (sx.ste1 = $34) and (sx.ste2 = $32) then
          Result := 'Pe aparat este un bon fiscal deschis'
        else if sx.ste1 = $31 then
          Result := 'S-a terminat hirtia sau imprimanta aparatului are o defectiune'
        else if sx.ste1 = $3B then
          Result := 'Aparatul e blocat: lipseste raportul Z de peste 24 de ore'
        else if sx.ste2 = $38 then
          Result := 'Suma in numerar din aparat este insuficienta';
    end;
    if Result = '' then
      Result := sx.GetMessage;
  end;
  if Trim(Result) = '' then
    Result := E.Message;
  if Trim(Result) = '' then
    Result := E.ClassName;
end;

{ TTremolFiscalDevice }

constructor TTremolFiscalDevice.Create(const AInfo: TFiscalDeviceInfo);
begin
  inherited Create;
  CoInitialize(nil);
  FInfo := AInfo;
  FFP := FP.Create;
  FConnected := False;
  FServerReachable := False;
end;

destructor TTremolFiscalDevice.Destroy;
begin
  // eliberam MCC pentru celelalte calculatoare din retea
  if FConnected then
    try
      FFP.ServerCloseDeviceConnection;
    except
      // serverul poate fi deja inaccesibil
    end;
  FFP.Free;
  CoUninitialize;
  inherited;
end;

function TTremolFiscalDevice.Kind: TFiscalDeviceKind;
begin
  Result := fdkTremol;
end;

function TTremolFiscalDevice.Info: TFiscalDeviceInfo;
begin
  Result := FInfo;
end;

function TTremolFiscalDevice.Connected: Boolean;
begin
  Result := FConnected;
end;

procedure TTremolFiscalDevice.RaiseFiscal(const AAction: string; const E: Exception);
begin
  raise EFiscalDeviceError.CreateFmt('%s: %s', [AAction, TremolErrorText(E)]);
end;

procedure TTremolFiscalDevice.CheckConnected;
begin
  if not FConnected then
    raise EFiscalDeviceError.Create('Aparatul fiscal nu este conectat.');
end;

function TTremolFiscalDevice.Connect(out AErrorText: string): Boolean;
var
  Connection: TTremolConnection;
begin
  AErrorText := '';
  FConnected := False;
  FServerReachable := False;
  try
    FFP.ServerAddress := FInfo.Server.ServerAddress;
    // obligatoriu inainte de ConnectTremolFiscalPrinter
    FFP.ApplyClientLibraryDefinitions();
    Connection := ConnectTremolFiscalPrinter(FFP, FInfo.Server);
    FServerReachable := Connection.ServerReachable;
    FConnected := Connection.Connected;
    FPort := Connection.Port;
    if not FConnected then
      if Connection.ServerReachable then
        AErrorText := cFISCAL_PRINTER_NotFoundMessage + ' (niciun port COM nu raspunde)'
      else
        AErrorText := cFISCAL_PRINTER_ServerNotRespondingMessage + ': ' + FInfo.Server.ServerAddress;
  except
    on E: Exception do
      AErrorText := cFISCAL_PRINTER_ServerNotRespondingMessage + ': ' + FInfo.Server.ServerAddress +
        ' (' + TremolErrorText(E) + ')';
  end;
  Result := FConnected;
end;

function TTremolFiscalDevice.ReadStatus: TFiscalDeviceStatus;
var
  Nums: SerialAndFiscalNumsRes;
  Vat: VATratesRes;
begin
  Result := Default(TFiscalDeviceStatus);
  Result.VatRateA := -1;
  CheckConnected;
  try
    Nums := FFP.ReadSerialAndFiscalNums;
    try
      Result.SerialNumber := Trim(Nums.SerialNum);
      Result.FiscalNumber := Trim(Nums.FMNum);
    finally
      Nums.Free;
    end;
    Result.DeviceTime := FFP.ReadDateTime;
    Vat := FFP.ReadVATrates;
    try
      Result.VatRateA := Vat.VATrateA;
    finally
      Vat.Free;
    end;
  except
    on E: Exception do
      RaiseFiscal('Starea aparatului fiscal nu a putut fi citita', E);
  end;
  Result.Location := 'in ' + FPort;
  if FInfo.Server.IsRemote then
    Result.Location := Result.Location + ' pe ' + FInfo.Server.ServerAddress;
end;

procedure TTremolFiscalDevice.OpenReceipt;
begin
  try
    FFP.OpenReceipt_V2(cOperNum, cOperPass, fpt_Step_by_step_printing);
  except
    on E: Exception do
      RaiseFiscal('Bonul fiscal nu a putut fi deschis', E);
  end;
end;

procedure TTremolFiscalDevice.SellLine(const ATitle: string; const AVatPercent: Integer; const APrice: Currency;
  const AQty: Double);
var
  Name: string;
begin
  Name := Copy(StringReplace(Trim(ATitle), '  ', ' ', [rfReplaceAll]), 1, cMaxTitleLength);
  try
    if AVatPercent = 0 then
      FFP.SellPLUwithSpecifiedVAT(Name, vatc_VAT_Class_E, APrice, AQty, 0, 0, '', '')
    else
      FFP.SellPLUwithSpecifiedVAT(Name, vatc_VAT_Class_A, APrice, AQty, 0, 0, '', '');
  except
    on E: Exception do
      RaiseFiscal('Linia "' + Name + '" nu a fost acceptata de aparat', E);
  end;
end;

procedure TTremolFiscalDevice.Pay(const AKind: TFiscalPayKind; const AAmount: Currency);
begin
  try
    case AKind of
      fpkCash:
        FFP.Payment_V2_1(ptv21_NUMERAR, c_Without_Change, AAmount, ct_Empty);
      fpkCard:
        FFP.Payment_V2_1(ptv21_CARD_PLATA, c_Without_Change, AAmount, ct_Empty);
      fpkOnline:
        // QR MIA / plata online = "alt instrument de plata" pe aparat
        FFP.Payment_V2_1(ptv21_ALT_IP, c_Without_Change, AAmount, ct_Empty);
    end;
  except
    on E: Exception do
      RaiseFiscal('Plata (' + FiscalPayKindName(AKind) + ') nu a fost acceptata de aparat', E);
  end;
end;

procedure TTremolFiscalDevice.CancelOpenReceipt;
begin
  try
    FFP.CancelReceipt;
  except
    // pe calea de eroare nu mai avem ce face; casierul vede starea pe aparat
  end;
end;

function TTremolFiscalDevice.PrintReceipt(const R: TFiscalReceipt): TFiscalReceiptResult;
var
  I: Integer;
  Last: LastReceiptNumRes;
begin
  Result := Default(TFiscalReceiptResult);
  CheckConnected;
  if Length(R.Lines) = 0 then
    raise EFiscalDeviceError.Create('Bonul fiscal nu are linii.');
  if Length(R.Payments) = 0 then
    raise EFiscalDeviceError.Create('Bonul fiscal nu are plati.');

  // pina la CloseReceipt reusit, orice eroare anuleaza bonul deschis pe aparat
  OpenReceipt;
  try
    for I := 0 to High(R.Lines) do
      SellLine(R.Lines[I].Title, R.Lines[I].VatPercent, R.Lines[I].Price, R.Lines[I].Qty);
    for I := 0 to High(R.Payments) do
      Pay(R.Payments[I].Kind, R.Payments[I].Amount);
    try
      FFP.CloseReceipt;
    except
      on E: Exception do
        RaiseFiscal('Bonul fiscal nu a putut fi inchis', E);
    end;
  except
    CancelOpenReceipt;
    raise;
  end;

  // de aici bonul EXISTA fiscal; o eroare la citirea numarului nu il mai anuleaza
  Result.State := frsDone;
  Result.DateTime := Now;
  try
    Last := FFP.ReadLastReceiptNum();
    if Last <> nil then
      try
        Result.Number := Trunc(Last.DailyReceiptCounter);
      finally
        Last.Free;
      end;
    Result.DateTime := FFP.ReadDateTime;
  except
    on E: Exception do
      Result.Warning := 'Bonul a fost tiparit, dar numarul lui nu a putut fi citit: ' + TremolErrorText(E);
  end;
  if Result.Number <= 0 then
  begin
    Result.State := frsNumberUnknown;
    Result.Number := 0;
    if Result.Warning = '' then
      Result.Warning := 'Bonul a fost tiparit, dar aparatul nu a raportat numarul lui.';
  end;
end;

procedure TTremolFiscalDevice.CashInOut(const Suma: Currency; const Text: string);
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

procedure TTremolFiscalDevice.PrintXReport;
begin
  CheckConnected;
  try
    FFP.PrintDailyReport(z_Without_zeroing);
  except
    on E: Exception do
      RaiseFiscal('Raportul X nu a fost tiparit', E);
  end;
end;

function TTremolFiscalDevice.PrintZReport: Integer;
var
  ZInfo: LastDailyReportInfoRes;
begin
  CheckConnected;
  try
    FFP.PrintDailyReport(z_Zeroing);
  except
    on E: Exception do
      RaiseFiscal('Raportul Z nu a fost tiparit', E);
  end;

  // Z-ul e deja tiparit; daca numarul nu poate fi citit, se intoarce 0
  Result := 0;
  try
    ZInfo := FFP.ReadLastDailyReportInfo();
    if ZInfo <> nil then
      try
        Result := Round(ZInfo.NoLastZDailyReport);
      finally
        ZInfo.Free;
      end;
  except
    Result := 0;
  end;
end;

function TTremolFiscalDevice.ConfirmRegistered(const AResult: TFiscalReceiptResult; const ADocID: Integer;
  const ASuma: Currency): Boolean;
begin
  // MCC nu are jurnal propriu in baza: bonul e complet odata ce e in TDB_DOCS_RECEIPT
  Result := True;
end;

procedure TTremolFiscalDevice.OpenDrawer;
begin
  CheckConnected;
  try
    FFP.SafeBoxOpen;
  except
    on E: Exception do
      RaiseFiscal('Sertarul nu a fost deschis', E);
  end;
end;

end.

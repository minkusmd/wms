unit ECCFiscalDevice;

(* IFiscalDevice pentru casa virtuala ECC Fiscal Partner (faza 4 din
   Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md).

   Casa se configureaza in FP_DEVICES (DEVICE_TYPE = 1, ECC_API_CODE) +
   TS_API_CONFIG (BASE_URL, API_KEY, POS_ID, POS_NAME, CASHIER_NAME, TAX_<procent>).
   Casierul: TFP_ECC_CASHIER pentru utilizatorul curent, altfel CASHIER_NAME.

   Ordinea la bonul fiscal (regula jurnalului):
     1. rindul TFP_ECC_TRANSACTION se scrie si se COMITE (firul principal);
     2. POST /receipt + asteptarea rezultatului pe un fir de lucru, cu o
        fereastra de asteptare care nu blocheaza aplicatia (buton "Opreste");
     3. rezultatul se scrie in jurnal (firul principal), PNG-ul se salveaza si
        se tipareste pe imprimanta implicita a Windows.
   Terminalul bancar smart (faza 5): daca TS_API_CONFIG are TERMINAL_POS_ID si bonul
   are plata prin card, bonul intreg (cu toate platile) pleaca la terminal prin
   POST /new-order-ext. Clientul plateste pe terminal, iar terminalul emite si
   tipareste singur bonul fiscal (PC-ul nu il mai tipareste). "Opreste" anuleaza
   comanda cit e inca "pending"; anularea / refuzul = EFiscalDeviceError, nimic emis.
   ECC refuza cererea (HTTP 4xx) -> EFiscalDeviceError, bonul nu exista.
   Retea / timeout / asteptare oprita -> frsPending: bonul NU se reemite, se
   finalizeaza din jurnal (Casa ECC - diagnostic > In asteptare).

   Conexiunea la baza e dmDB.IBCConnection, folosita DOAR pe firul principal;
   pe firul de lucru se fac numai apeluri HTTP. *)

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, FiscalPrinterUtilsUnit, FiscalDeviceUnit, ECCApiClient, ECCConfigUnit,
  ECCTransactionStore;

type
  TECCFiscalDevice = class(TInterfacedObject, IFiscalDevice)
  private
    FInfo: TFiscalDeviceInfo;
    FFirmaID: Integer;
    FConfig: TECCConfig;
    FClient: TECCApiClient;
    FTerminalClient: TECCApiClient;   // nil daca nu e configurat terminalul smart
    FStore: TECCTransactionStore;
    FCashierName: string;
    FConnected: Boolean;
    procedure CheckConnected;
    function EccPayType(const AKind: TFiscalPayKind): Integer;
    function NewJournalRow(const AId: string; const AKind: Integer; const ASuma: Currency): TECCTransaction;
    procedure JournalSafe(const AProc: TProc);
    procedure SaveAndPrintPng(const ATransId: string; APng: TMemoryStream; var AWarning: string;
      const APrint: Boolean = True);
    function WaitReport(const AId: string; const ACancel: TECCCancelCheck; out AReport: TECCReport): Boolean;
    function MakeReport(const AReportType: Integer): TECCReport;
    function HasCardPayment(const R: TFiscalReceipt): Boolean;
    function PrintViaTerminal(const ARequest: TECCReceiptRequest): TFiscalReceiptResult;
  public
    constructor Create(const AInfo: TFiscalDeviceInfo; const AFirmaID: Integer);
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
  end;

// Ruleaza AWork pe un fir de lucru si arata o fereastra modala de asteptare pina
// se termina. Butonul "Opreste asteptarea" face ca ACancel sa intoarca True.
// Exceptia din AWork se ridica din nou pe firul principal.
procedure ECCRunWithWait(const AText: string; const AWork: TProc<TECCCancelCheck>);

// Tipareste PNG-ul (bon / raport ECC) pe imprimanta bonurilor (vezi mai jos) la latimea unui bon
// (72 mm tiparibili din rola de 80 mm), nu pe toata pagina: pe A4 bonul ramine
// in coltul de sus, pe imprimanta termica ocupa rola. Bonul lung trece pe pagina urmatoare.
procedure ECCPrintPng(AStream: TStream; const ATitle: string);
procedure ECCPrintGraphic(AGraphic: TGraphic; const ATitle: string);

// Imprimanta bonurilor ECC pe acest calculator (setarile locale WMS, AppConfigStorage);
// '' = imprimanta implicita din Windows. O folosesc tiparirea la emitere si copiile.
function ECCGetReceiptPrinter: string;
procedure ECCSetReceiptPrinter(const AName: string);
// Fereastra Windows de alegere a imprimantei, cu imprimanta memorata preselectata.
// La OK alegerea se memoreaza si devine imprimanta curenta (Printer).
function ECCChooseReceiptPrinter: Boolean;

implementation

uses
  Winapi.Windows, System.Types, System.UITypes, System.StrUtils, Vcl.Controls, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Printers, Vcl.Dialogs, Vcl.Imaging.pngimage, DataModuleDB, SWNValueStorageUnit;

const
  cReceiptWaitMs = 60000;
  cReportWaitSec = 30;
  cPngRetries = 5;

type
  TECCWaitForm = class(TForm)
  private
    FTextLabel: TLabel;
    FStopButton: TButton;
    FWork: TProc<TECCCancelCheck>;
    FCancel: Boolean;
    FDone: Boolean;
    FStarted: Boolean;
    FError: TObject;
    procedure StopClick(Sender: TObject);
    procedure WaitShow(Sender: TObject);
    procedure WaitCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    constructor CreateWait(const AText: string; const AWork: TProc<TECCCancelCheck>);
    destructor Destroy; override;
  end;

{ TECCWaitForm }

constructor TECCWaitForm.CreateWait(const AText: string; const AWork: TProc<TECCCancelCheck>);
begin
  inherited CreateNew(nil);
  FWork := AWork;
  BorderStyle := bsDialog;
  BorderIcons := [];
  Position := poScreenCenter;
  Caption := 'Casa ECC Fiscal Partner';
  ClientWidth := 460;
  ClientHeight := 130;

  FTextLabel := TLabel.Create(Self);
  FTextLabel.Parent := Self;
  FTextLabel.AutoSize := False;
  FTextLabel.WordWrap := True;
  FTextLabel.SetBounds(16, 16, 428, 64);
  FTextLabel.Caption := AText;

  FStopButton := TButton.Create(Self);
  FStopButton.Parent := Self;
  FStopButton.SetBounds(284, 88, 160, 30);
  FStopButton.Caption := 'Opreste asteptarea';
  FStopButton.OnClick := StopClick;

  OnShow := WaitShow;
  OnCloseQuery := WaitCloseQuery;
end;

destructor TECCWaitForm.Destroy;
begin
  FError.Free;
  inherited;
end;

procedure TECCWaitForm.StopClick(Sender: TObject);
begin
  FCancel := True;
  FStopButton.Enabled := False;
  FTextLabel.Caption := FTextLabel.Caption + sLineBreak + 'Se opreste asteptarea...';
end;

procedure TECCWaitForm.WaitCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // fereastra se inchide doar cind firul de lucru s-a terminat
  CanClose := FDone;
end;

procedure TECCWaitForm.WaitShow(Sender: TObject);
begin
  if FStarted then
    Exit;
  FStarted := True;
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        FWork(
          function: Boolean
          begin
            Result := FCancel;
          end);
      except
        FError := TObject(AcquireExceptionObject);
      end;
      TThread.Queue(nil,
        procedure
        begin
          FDone := True;
          ModalResult := mrOk;
        end);
    end).Start;
end;

procedure ECCRunWithWait(const AText: string; const AWork: TProc<TECCCancelCheck>);
var
  F: TECCWaitForm;
  E: TObject;
begin
  F := TECCWaitForm.CreateWait(AText, AWork);
  try
    F.ShowModal;
    E := F.FError;
    F.FError := nil;
  finally
    F.Free;
  end;
  if E <> nil then
    raise E;
end;

const
  cReceiptWidthMm = 72; // latimea tiparibila a rolei de 80 mm
  cReceiptPrinterKey = 'ECC_RECEIPT_PRINTER';

function ECCGetReceiptPrinter: string;
begin
  Result := AppConfigStorage.TextValues.GetValue(cReceiptPrinterKey, '');
end;

procedure ECCSetReceiptPrinter(const AName: string);
begin
  AppConfigStorage.TextValues.SetValue(cReceiptPrinterKey, AName);
end;

// Trece Printer pe imprimanta memorata, daca inca exista in Windows; altfel o lasa cum e.
// Indexul se schimba doar cind difera, ca sa nu se piarda setarile alese in dialog (copii etc.).
procedure UseReceiptPrinter;
var
  I: Integer;
begin
  I := Printer.Printers.IndexOf(ECCGetReceiptPrinter);
  if (I >= 0) and (I <> Printer.PrinterIndex) then
    Printer.PrinterIndex := I;
end;

function ECCChooseReceiptPrinter: Boolean;
var
  D: TPrintDialog;
begin
  UseReceiptPrinter;
  D := TPrintDialog.Create(nil);
  try
    D.Options := [];
    D.Copies := 1;
    Result := D.Execute;
    if Result and (Printer.PrinterIndex >= 0) then
      ECCSetReceiptPrinter(Printer.Printers[Printer.PrinterIndex]);
  finally
    D.Free;
  end;
end;

procedure ECCPrintGraphic(AGraphic: TGraphic; const ATitle: string);
var
  W, H, PageH, Top: Integer;
begin
  if (AGraphic = nil) or AGraphic.Empty or (AGraphic.Width = 0) then
    Exit;
  UseReceiptPrinter;
  Printer.Title := ATitle;
  Printer.BeginDoc;
  try
    W := MulDiv(GetDeviceCaps(Printer.Handle, LOGPIXELSX), cReceiptWidthMm * 10, 254);
    if (W <= 0) or (W > Printer.PageWidth) then
      W := Printer.PageWidth;
    H := MulDiv(AGraphic.Height, W, AGraphic.Width);
    PageH := Printer.PageHeight;
    Top := 0;
    repeat
      // fiecare pagina primeste urmatoarea felie; ce iese din pagina e taiat de imprimanta
      Printer.Canvas.StretchDraw(Rect(0, -Top, W, H - Top), AGraphic);
      Inc(Top, PageH);
      if Top < H then
        Printer.NewPage;
    until Top >= H;
  finally
    Printer.EndDoc;
  end;
end;

procedure ECCPrintPng(AStream: TStream; const ATitle: string);
var
  Png: TPngImage;
begin
  Png := TPngImage.Create;
  try
    AStream.Position := 0;
    Png.LoadFromStream(AStream);
    ECCPrintGraphic(Png, ATitle);
  finally
    Png.Free;
  end;
end;

// Pe firul de lucru: PNG-ul poate aparea cu intirziere dupa emitere. Esecul nu e fatal.
procedure DownloadPng(AClient: TECCApiClient; const ADocFileName: string; AStream: TMemoryStream;
  const ACancel: TECCCancelCheck);
var
  Attempt: Integer;
begin
  if ADocFileName = '' then
    Exit;
  for Attempt := 1 to cPngRetries do
    try
      AStream.Clear;
      AClient.Download(ADocFileName, AStream);
      Exit;
    except
      AStream.Clear;
      if Assigned(ACancel) and ACancel() then
        Exit;
      Sleep(1000);
    end;
end;

{ TECCFiscalDevice }

constructor TECCFiscalDevice.Create(const AInfo: TFiscalDeviceInfo; const AFirmaID: Integer);
begin
  inherited Create;
  FInfo := AInfo;
  FFirmaID := AFirmaID;
end;

destructor TECCFiscalDevice.Destroy;
begin
  FTerminalClient.Free;
  FClient.Free;
  FStore.Free;
  inherited;
end;

function TECCFiscalDevice.Kind: TFiscalDeviceKind;
begin
  Result := fdkECC;
end;

function TECCFiscalDevice.Info: TFiscalDeviceInfo;
begin
  Result := FInfo;
end;

function TECCFiscalDevice.Connected: Boolean;
begin
  Result := FConnected;
end;

procedure TECCFiscalDevice.CheckConnected;
begin
  if not FConnected then
    raise EFiscalDeviceError.Create('Casa ECC nu este conectata.');
end;

function TECCFiscalDevice.Connect(out AErrorText: string): Boolean;
begin
  AErrorText := '';
  FConnected := False;
  FreeAndNil(FClient);
  FreeAndNil(FTerminalClient);
  FreeAndNil(FStore);
  try
    FConfig := LoadECCConfig(dmDB.IBCConnection, FInfo.EccApiCode);
    AErrorText := FConfig.Validate;
    if AErrorText <> '' then
      Exit(False);

    // fara jurnal nu se emite nimic: el e protectia contra dublei fiscalizari
    if not TECCTransactionStore.Available(dmDB.IBCConnection) then
    begin
      AErrorText := 'Jurnalul ECC (TFP_ECC_TRANSACTION) lipseste din baza: rulati DB Model/ecc_fiscalpartner.sql.';
      Exit(False);
    end;
    FStore := TECCTransactionStore.Create(dmDB.IBCConnection);

    FCashierName := FStore.FindCashierName(FConfig.ApiCode, dmDB.CurrentUserID);
    if FCashierName = '' then
      FCashierName := FConfig.CashierName;

    FClient := FConfig.CreateClient;
    FClient.ConnectionTimeout := 5000;
    FClient.ResponseTimeout := 15000;
    if not FClient.Status then
    begin
      AErrorText := 'Casa ECC ' + FConfig.ApiCode + ': serverul raspunde, dar nu e functional (status = false).';
      Exit(False);
    end;
    FClient.ResponseTimeout := 30000;
    if FConfig.HasTerminal then
    begin
      FTerminalClient := FConfig.CreateTerminalClient;
      FTerminalClient.ConnectionTimeout := 5000;
      FTerminalClient.ResponseTimeout := 30000;
    end;
    FConnected := True;
  except
    on E: Exception do
      AErrorText := 'Casa ECC ' + FInfo.EccApiCode + ' nu este disponibila: ' + E.Message;
  end;
  Result := FConnected;
end;

function TECCFiscalDevice.ReadStatus: TFiscalDeviceStatus;
begin
  CheckConnected;
  Result := Default(TFiscalDeviceStatus);
  Result.SerialNumber := FConfig.PosId;
  Result.FiscalNumber := FConfig.ApiCode;
  Result.Location := FConfig.PosName + ' (' + FConfig.ApiCode + '), casier ' + FCashierName;
  if FConfig.HasTerminal then
    Result.Location := Result.Location + ', cardul prin terminalul ' +
      IfThen(FConfig.TerminalPosName <> '', FConfig.TerminalPosName, FConfig.TerminalPosId);
  Result.DeviceTime := 0;
  Result.VatRateA := -1;
end;

function TECCFiscalDevice.EccPayType(const AKind: TFiscalPayKind): Integer;
begin
  case AKind of
    fpkCash: Result := eccPayCash;
    fpkCard: Result := eccPayCard;
  else
    Result := eccPayOnline;
  end;
end;

function TECCFiscalDevice.NewJournalRow(const AId: string; const AKind: Integer; const ASuma: Currency): TECCTransaction;
begin
  Result := Default(TECCTransaction);
  Result.TransId := AId;
  Result.ApiCode := FConfig.ApiCode;
  Result.FPID := FInfo.FPID;
  Result.FirmaID := FFirmaID;
  Result.Kind := AKind;
  Result.Suma := ASuma;
  Result.CashierName := FCashierName;
  Result.UserID := dmDB.CurrentUserID;
end;

// Scrierile in jurnal de DUPA trimitere nu au voie sa ascunda rezultatul din ECC.
procedure TECCFiscalDevice.JournalSafe(const AProc: TProc);
begin
  try
    AProc();
  except
    // jurnalul se reface din ECC ("In asteptare"); bonul e deja emis
  end;
end;

procedure TECCFiscalDevice.SaveAndPrintPng(const ATransId: string; APng: TMemoryStream; var AWarning: string;
  const APrint: Boolean);
begin
  if APng.Size = 0 then
  begin
    AWarning := 'Imaginea bonului nu a putut fi descarcata; o puteti tipari din Casa ECC - diagnostic.';
    Exit;
  end;
  if ATransId <> '' then
    JournalSafe(
      procedure
      begin
        FStore.SavePng(ATransId, APng);
      end);
  if not APrint then
    Exit; // clientul primeste bonul pe e-mail / Viber / SMS (ECCReceiptSendUnit)
  try
    ECCPrintPng(APng, 'ECC ' + ATransId);
  except
    on E: Exception do
      AWarning := 'Bonul e emis, dar nu a putut fi tiparit: ' + E.Message;
  end;
end;

function TECCFiscalDevice.PrintReceipt(const R: TFiscalReceipt): TFiscalReceiptResult;
var
  Req: TECCReceiptRequest;
  L: TFiscalLine;
  P: TFiscalPayment;
  T: TECCTransaction;
  Err, RespJSON, Warning: string;
  Posted, Found, Final, UseTerminal: Boolean;
  Receipt: TECCReceipt;
  Png: TMemoryStream;
  Client: TECCApiClient;
begin
  Result := Default(TFiscalReceiptResult);
  CheckConnected;
  if Length(R.Lines) = 0 then
    raise EFiscalDeviceError.Create('Bonul fiscal nu are linii.');
  if Length(R.Payments) = 0 then
    raise EFiscalDeviceError.Create('Bonul fiscal nu are plati.');

  // plata prin card + terminal smart configurat = bonul il emite terminalul
  UseTerminal := Assigned(FTerminalClient) and HasCardPayment(R);

  // 1. cererea
  if UseTerminal then
    Req.Init(FConfig.TerminalPosId, FConfig.TerminalPosName, FCashierName)
  else
    Req.Init(FConfig.PosId, FConfig.PosName, FCashierName);
  try
    for L in R.Lines do
      Req.AddLineTotal(L.Title, L.Qty, FiscalRoundMoney(L.Price * L.Qty), FConfig.TaxCodeFor(L.VatPercent));
    for P in R.Payments do
      Req.AddPayment(EccPayType(P.Kind), P.Amount);
  except
    on E: Exception do
      raise EFiscalDeviceError.Create(E.Message);
  end;
  Err := Req.Validate;
  if Err <> '' then
    raise EFiscalDeviceError.Create('Bonul ECC nu e valid: ' + Err);

  // 2. jurnalul, comis INAINTE de trimitere
  if UseTerminal then
  begin
    T := NewJournalRow(Req.Id, eccKindOrderExt, Req.Total);
    T.RequestJSON := Req.ToOrderExtJSON;
  end
  else
  begin
    T := NewJournalRow(Req.Id, eccKindReceipt, Req.Total);
    T.RequestJSON := Req.ToJSON;
  end;
  T.SourceType := R.SourceType;
  T.SourceRef := R.SourceRef;
  T.DocID := R.DocID;
  T.PayType := Req.Payments[0].PayType;
  try
    FStore.AddNew(T);
  except
    on E: Exception do
      if Pos('UQ_TFP_ECC_TRANS_SOURCE', E.Message) > 0 then
        raise EFiscalDeviceError.Create('Pentru acest document exista deja un bon ECC activ in jurnal. ' +
          'Verificati-l in Casa ECC - diagnostic > Jurnal / In asteptare.')
      else
        raise EFiscalDeviceError.Create('Bonul nu a putut fi scris in jurnalul ECC: ' + E.Message);
  end;

  if UseTerminal then
    Exit(PrintViaTerminal(Req));

  // 3. trimiterea si asteptarea, pe firul de lucru
  Posted := False;
  Found := False;
  RespJSON := '';
  Client := FClient;
  Png := TMemoryStream.Create;
  try
    try
      ECCRunWithWait('Se emite bonul fiscal pe casa ECC ' + FConfig.PosName + ' (' + ECCMoneyText(Req.Total) +
        ' lei)...',
        procedure(Cancel: TECCCancelCheck)
        begin
          Client.PostReceipt(Req);
          Posted := True;
          Found := Client.WaitReceipt(Req.Id, Receipt, cReceiptWaitMs, 500, Cancel);
          if Found then
          begin
            RespJSON := Client.LastResponse;
            DownloadPng(Client, Receipt.DocFileName, Png, Cancel);
          end;
        end);
    except
      on E: Exception do
      begin
        // 4xx inainte de acceptare = ECC a refuzat bonul, el nu exista
        Final := (not Posted) and (E is EECCApiError) and (EECCApiError(E).HttpCode >= 400) and
          (EECCApiError(E).HttpCode < 500);
        Err := E.Message;
        JournalSafe(
          procedure
          begin
            FStore.MarkError(Req.Id, Err, Final);
          end);
        if Final then
          raise EFiscalDeviceError.Create('Casa ECC a refuzat bonul: ' + Err);
        // retea / server: nu stim daca ECC l-a primit - NU se reemite
        Result.State := frsPending;
        Result.ExternalId := Req.Id;
        Result.Warning := 'Legatura cu casa ECC s-a intrerupt (' + Err + '). Nu se stie daca bonul a fost emis; ' +
          'NU il repetati. Verificati-l in Casa ECC - diagnostic > In asteptare (id ' + Req.Id + ').';
        Exit;
      end;
    end;

    JournalSafe(
      procedure
      begin
        FStore.MarkSent(Req.Id);
      end);

    if not Found then
    begin
      Result.State := frsPending;
      Result.ExternalId := Req.Id;
      Result.Warning := 'Casa ECC a primit bonul, dar rezultatul nu a venit la timp. NU il repetati: ' +
        'se finalizeaza din Casa ECC - diagnostic > In asteptare (id ' + Req.Id + ').';
      Exit;
    end;

    // 4. bonul e emis
    JournalSafe(
      procedure
      begin
        FStore.MarkReceiptDone(Req.Id, Receipt, RespJSON);
      end);
    Warning := '';
    SaveAndPrintPng(Req.Id, Png, Warning, not R.NoPaperPrint);

    Result.State := frsDone;
    Result.Number := Receipt.Number;
    Result.DateTime := Receipt.DateTime;
    if Result.DateTime = 0 then
      Result.DateTime := Now;
    Result.ZNumber := Receipt.ZReportNumber;
    Result.ExternalId := Req.Id;
    Result.MevLink := Receipt.MevLink;
    Result.Warning := Warning;
  finally
    Png.Free;
  end;
end;

function TECCFiscalDevice.HasCardPayment(const R: TFiscalReceipt): Boolean;
var
  P: TFiscalPayment;
begin
  Result := False;
  for P in R.Payments do
    if P.Kind = fpkCard then
      Exit(True);
end;

// Rindul din jurnal e deja comis (KIND = 5). Starile comenzii: pending (asteapta cardul),
// processing (plata in curs), processed (bon emis), cancelled.
function TECCFiscalDevice.PrintViaTerminal(const ARequest: TECCReceiptRequest): TFiscalReceiptResult;
var
  Req: TECCReceiptRequest;   // copie locala: parametrii const nu se captureaza in metode anonime
  Client: TECCApiClient;
  Posted, Found, CancelledByUs, Final: Boolean;
  LastStatus: TECCOrderStatus;
  StatusText, RespJSON, Err, Warning: string;
  Receipt: TECCReceipt;
  Png: TMemoryStream;
  TimeoutSec: Integer;
begin
  Req := ARequest;
  Result := Default(TFiscalReceiptResult);
  Result.ExternalId := Req.Id;
  Client := FTerminalClient;
  TimeoutSec := FConfig.TerminalTimeoutSec;
  Posted := False;
  Found := False;
  CancelledByUs := False;
  LastStatus := eosUnknown;
  StatusText := '';
  RespJSON := '';
  Png := TMemoryStream.Create;
  try
    try
      ECCRunWithWait(Format('Plata cu cardul pe terminalul bancar %s: %s lei.' + sLineBreak +
        'Clientul plateste pe terminal; bonul fiscal il tipareste terminalul.' + sLineBreak +
        '"Opreste asteptarea" anuleaza comanda daca plata nu a inceput.',
        [IfThen(FConfig.TerminalPosName <> '', FConfig.TerminalPosName, FConfig.TerminalPosId),
         ECCMoneyText(Req.Total)]),
        procedure(Cancel: TECCCancelCheck)
        var
          Deadline: TDateTime;
        begin
          Client.NewOrderExt(Req);
          Posted := True;
          Deadline := Now + TimeoutSec / SecsPerDay;
          repeat
            LastStatus := Client.GetOrderExtStatus(Req.Id, StatusText);
            if LastStatus in [eosProcessed, eosCompleted, eosCancelled] then
              Break;
            // oprire ceruta sau timp expirat: cit plata nu a inceput, comanda se anuleaza
            if Cancel() or (Now >= Deadline) then
            begin
              if LastStatus = eosPending then
              begin
                Client.CancelOrderExt(Req.Id);
                CancelledByUs := True;
                LastStatus := eosCancelled;
              end;
              Break;
            end;
            Sleep(1000);
          until False;

          if LastStatus in [eosProcessed, eosCompleted] then
          begin
            Found := Client.WaitReceipt(Req.Id, Receipt, 30000, 1000, nil);
            if Found then
            begin
              RespJSON := Client.LastResponse;
              DownloadPng(Client, Receipt.DocFileName, Png, nil);
            end;
          end;
        end);
    except
      on E: Exception do
      begin
        Final := (not Posted) and (E is EECCApiError) and (EECCApiError(E).HttpCode >= 400) and
          (EECCApiError(E).HttpCode < 500);
        Err := E.Message;
        JournalSafe(
          procedure
          begin
            FStore.MarkError(Req.Id, Err, Final);
          end);
        if Final then
          raise EFiscalDeviceError.Create('Terminalul / casa ECC a refuzat comanda: ' + Err);
        Result.State := frsPending;
        Result.Warning := 'Legatura cu terminalul s-a intrerupt (' + Err + '). Nu se stie daca plata si bonul ' +
          'au fost facute; NU repetati plata. Verificati terminalul si Casa ECC - diagnostic > In asteptare ' +
          '(id ' + Req.Id + ').';
        Exit;
      end;
    end;

    JournalSafe(
      procedure
      begin
        FStore.MarkSent(Req.Id);
        FStore.SetOrderStatus(Req.Id, ECCOrderStatusName(LastStatus));
      end);

    case LastStatus of
      eosCancelled:
        begin
          JournalSafe(
            procedure
            begin
              if CancelledByUs then
                FStore.MarkCancelled(Req.Id, 'Anulat din WMS (oprit sau timp expirat) inainte de plata')
              else
                FStore.MarkCancelled(Req.Id, 'Anulat pe terminal ' + StatusText);
            end);
          if CancelledByUs then
            raise EFiscalDeviceError.Create('Comanda de pe terminal a fost anulata inainte de plata. ' +
              'Nu s-a incasat nimic si nu s-a emis niciun bon.')
          else
            raise EFiscalDeviceError.Create('Plata a fost anulata pe terminal' +
              IfThen(StatusText <> '', ' (' + StatusText + ')', '') + '. Nu s-a emis niciun bon.');
        end;
      eosProcessed, eosCompleted:
        if Found then
        begin
          JournalSafe(
            procedure
            begin
              FStore.MarkReceiptDone(Req.Id, Receipt, RespJSON);
              if Png.Size > 0 then
                FStore.SavePng(Req.Id, Png);
            end);
          // terminalul a tiparit deja bonul - PC-ul nu il mai tipareste
          Result.State := frsDone;
          Result.ExternalId := Req.Id; // fara el ConfirmRegistered nu leaga bonul de TDB_DOCS_RECEIPT
          Result.Number := Receipt.Number;
          Result.DateTime := Receipt.DateTime;
          if Result.DateTime = 0 then
            Result.DateTime := Now;
          Result.ZNumber := Receipt.ZReportNumber;
          Result.MevLink := Receipt.MevLink;
        end
        else
        begin
          // bonul e emis (terminalul l-a tiparit), dar datele lui nu se pot citi prin API
          JournalSafe(
            procedure
            begin
              FStore.MarkDone(Req.Id);
            end);
          Result.State := frsNumberUnknown;
          Result.ExternalId := Req.Id;
          Result.DateTime := Now;
          Result.Warning := 'Plata e facuta si terminalul a emis bonul, dar numarul lui nu a putut fi citit ' +
            'prin API. Introduceti numarul de pe bonul tiparit de terminal.';
        end;
    else
      // plata a inceput (processing) si nu s-a terminat in timp / asteptarea a fost oprita
      Warning := 'Plata pe terminal nu s-a terminat in ' + IntToStr(TimeoutSec) + ' s (stare: ' +
        ECCOrderStatusName(LastStatus) + '). NU repetati plata: verificati terminalul si Casa ECC - ' +
        'diagnostic > In asteptare (id ' + Req.Id + ').';
      JournalSafe(
        procedure
        begin
          FStore.MarkError(Req.Id, Warning, False);
        end);
      Result.State := frsPending;
      Result.Warning := Warning;
    end;
  finally
    Png.Free;
  end;
end;

function TECCFiscalDevice.ConfirmRegistered(const AResult: TFiscalReceiptResult; const ADocID: Integer;
  const ASuma: Currency): Boolean;
begin
  Result := AResult.ExternalId = '';
  if Result or not FConnected then
    Exit;
  try
    Result := FStore.LinkWmsReceipt(AResult.ExternalId, ADocID, AResult.Number, AResult.DateTime, ASuma,
      FInfo.FPID) > 0;
  except
    Result := False;
  end;
end;

procedure TECCFiscalDevice.CashInOut(const Suma: Currency; const Text: string);
var
  Id, Req, Resp, Warning: string;
  Png: TMemoryStream;
  Client: TECCApiClient;
  Config: TECCConfig;
  Cashier: string;
begin
  CheckConnected;
  if Suma = 0 then
    Exit;
  Client := FClient;
  Config := FConfig;
  Cashier := FCashierName;
  Id := '';
  Png := TMemoryStream.Create;
  try
    try
      ECCRunWithWait(Format('Se emite bonul de serviciu ECC (%s %s lei)...',
        [IfThen(Suma > 0, 'depunere', 'retragere'), ECCMoneyText(Abs(Suma))]),
        procedure(Cancel: TECCCancelCheck)
        begin
          Id := Client.ServiceReceipt(Config.PosId, Config.PosName, Cashier, Suma);
          Req := Client.LastRequest;
          Resp := Client.LastResponse;
          DownloadPng(Client, eccDocServiceReceipt + '/' + Id, Png, Cancel);
        end);
    except
      on E: Exception do
        raise EFiscalDeviceError.Create('Bonul de serviciu nu a fost emis pe casa ECC: ' + E.Message);
    end;

    // id-ul il da serverul, deci jurnalul se scrie dupa raspuns
    if IsValidECCId(Id) then
      JournalSafe(
        procedure
        var
          T: TECCTransaction;
        begin
          T := NewJournalRow(Id, eccKindService, Suma);
          T.PayType := eccPayCash;
          T.RequestJSON := Req;
          FStore.AddNew(T);
          FStore.MarkDone(Id, Resp);
        end);
    Warning := '';
    SaveAndPrintPng(Id, Png, Warning);
  finally
    Png.Free;
  end;
end;

// Pe firul de lucru.
function TECCFiscalDevice.WaitReport(const AId: string; const ACancel: TECCCancelCheck;
  out AReport: TECCReport): Boolean;
var
  Attempt: Integer;
begin
  Result := False;
  AReport := Default(TECCReport);
  for Attempt := 1 to cReportWaitSec do
  begin
    if FClient.TryGetReport(AId, AReport) then
      Exit(True);
    if Assigned(ACancel) and ACancel() then
      Exit;
    Sleep(1000);
  end;
end;

function TECCFiscalDevice.MakeReport(const AReportType: Integer): TECCReport;
var
  Id, Req, Resp, Title, Warning: string;
  Rep: TECCReport;
  Found: Boolean;
  Png: TMemoryStream;
  Client: TECCApiClient;
  Config: TECCConfig;
  Cashier: string;
  JournalKind: Integer;
begin
  CheckConnected;
  if AReportType = eccReportZ then
  begin
    Title := 'Raportul Z';
    JournalKind := eccKindZReport;
  end
  else
  begin
    Title := 'Raportul X';
    JournalKind := eccKindXReport;
  end;
  Client := FClient;
  Config := FConfig;
  Cashier := FCashierName;
  Id := '';
  Found := False;
  Png := TMemoryStream.Create;
  try
    try
      ECCRunWithWait('Se face ' + Title + ' pe casa ECC ' + Config.PosName + '...',
        procedure(Cancel: TECCCancelCheck)
        begin
          Id := Client.Report(Config.PosId, Config.PosName, Cashier, AReportType);
          Req := Client.LastRequest;
          Found := WaitReport(Id, Cancel, Rep);
          if Found then
          begin
            Resp := Client.LastResponse;
            DownloadPng(Client, Rep.DocFileName, Png, Cancel);
          end;
        end);
    except
      on E: Exception do
        raise EFiscalDeviceError.Create(Title + ' nu a fost facut pe casa ECC: ' + E.Message);
    end;

    if IsValidECCId(Id) then
      JournalSafe(
        procedure
        begin
          FStore.AddNew(NewJournalRow(Id, JournalKind, 0));
          if Found then
            FStore.MarkReportDone(Id, Rep, Resp)
          else
            FStore.MarkSent(Id);
        end);
    if Found then
    begin
      Warning := '';
      SaveAndPrintPng(Id, Png, Warning);
    end;
    Result := Rep;
  finally
    Png.Free;
  end;
end;

procedure TECCFiscalDevice.PrintXReport;
begin
  MakeReport(eccReportX);
end;

function TECCFiscalDevice.PrintZReport: Integer;
begin
  // la raportul Z, "number" e numarul Z-ului
  Result := MakeReport(eccReportZ).Number;
end;

procedure TECCFiscalDevice.OpenDrawer;
begin
  // casa virtuala nu are sertar
end;

end.

unit FiscalDeviceUnit;

(* Abstractia comuna peste aparatele fiscale (faza 3 din
   Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md).

   Doua implementari:
     TTremolFiscalDevice (TremolFiscalDevice.pas) - MCC Tremol prin serverul ZFPLab;
     TECCFiscalDevice (ECC/ECCFiscalDevice.pas)   - casa virtuala ECC Fiscal Partner.
   Aparatul se alege dupa FP_DEVICES (GetFiscalDeviceInfo): firma + calculator,
   iar DEVICE_TYPE spune ce implementare se foloseste.

   Interfata lucreaza cu BONUL INTREG, nu cu pasii Tremol (deschide / linie /
   plata / inchide): ECC primeste tot bonul intr-o singura cerere.

   Contractul PrintReceipt:
     - exceptie EFiscalDeviceError = pe aparat NU a ramas nimic (bonul deschis a
       fost anulat, ECC a refuzat cererea); apelantul poate reincerca;
     - rezultat frsDone           = bon emis, numar si data cunoscute;
     - rezultat frsNumberUnknown  = bonul EXISTA fiscal, dar numarul lui nu a
       putut fi citit (Tremol, dupa inchidere). Nu se reemite; apelantul cere
       numarul de pe hirtie;
     - rezultat frsPending        = cererea a ajuns (probabil) la casa, dar
       rezultatul nu a venit la timp (ECC). NU se reemite si NU se cere numar:
       bonul ramine in jurnalul TFP_ECC_TRANSACTION si se finalizeaza de acolo.
   Dupa ce bonul e salvat in WMS (TDB_DOCS_RECEIPT), apelantul cheama
   ConfirmRegistered: ECC leaga rindul de tranzactia din jurnal. *)

interface

uses
  System.SysUtils, FiscalPrinterUtilsUnit;

const
  // FP_DEVICES.DEVICE_TYPE
  cFiscalDeviceTypeTremol = 0;
  cFiscalDeviceTypeECC    = 1;

type
  EFiscalDeviceError = class(Exception);

  TFiscalDeviceKind = (fdkTremol, fdkECC);

  // Tremol: NUMERAR / CARD_PLATA / ALT_IP; ECC: 1 / 2 / 7
  TFiscalPayKind = (fpkCash, fpkCard, fpkOnline);

  TFiscalLine = record
    Title: string;
    Qty: Double;
    Price: Currency;       // pretul unitar final (cu TVA, dupa reducere)
    VatPercent: Integer;   // 0 = fara TVA
  end;

  TFiscalPayment = record
    Kind: TFiscalPayKind;
    Amount: Currency;
  end;

  TFiscalReceipt = record
    Lines: TArray<TFiscalLine>;
    Payments: TArray<TFiscalPayment>;
    // legatura cu WMS, pentru jurnalul ECC (Tremol le ignora)
    DocID: Integer;
    SourceType: Integer;
    SourceRef: string;
    // ECC: bonul nu se tipareste pe PC, clientul il primeste altfel (e-mail / Viber / SMS)
    NoPaperPrint: Boolean;
    procedure Clear;
    procedure AddLine(const ATitle: string; const AQty: Double; const APrice: Currency; const AVatPercent: Integer);
    procedure AddPayment(const AKind: TFiscalPayKind; const AAmount: Currency);
    function LinesTotal: Currency;
    function PaymentsTotal: Currency;
    function HasZeroVat: Boolean;
  end;

  TFiscalReceiptState = (frsDone, frsNumberUnknown, frsPending);

  TFiscalReceiptResult = record
    State: TFiscalReceiptState;
    Number: Integer;       // 0 daca frsNumberUnknown
    DateTime: TDateTime;
    ZNumber: Integer;      // 0 daca aparatul nu il da
    ExternalId: string;    // ECC: id-ul tranzactiei (TFP_ECC_TRANSACTION.TRANS_ID)
    MevLink: string;       // ECC: linkul de verificare SIA MEV
    Warning: string;       // de ce numarul nu e cunoscut
  end;

  TFiscalDeviceStatus = record
    SerialNumber: string;  // Tremol: nr. de fabrica; ECC: POS ID
    FiscalNumber: string;
    Location: string;      // unde e aparatul, pentru afisare
    DeviceTime: TDateTime; // 0 = necunoscut
    VatRateA: Double;      // cota clasei A pe aparat; -1 = necunoscut
  end;

  IFiscalDevice = interface
    ['{6E3E9B53-1C0D-4A4B-9C3E-5B1A7D2F8E41}']
    function Kind: TFiscalDeviceKind;
    function Info: TFiscalDeviceInfo;
    // False = aparatul nu e disponibil; AErrorText spune de ce
    function Connect(out AErrorText: string): Boolean;
    function Connected: Boolean;
    function ReadStatus: TFiscalDeviceStatus;
    function PrintReceipt(const R: TFiscalReceipt): TFiscalReceiptResult;
    // Suma > 0 = depunere, Suma < 0 = retragere
    procedure CashInOut(const Suma: Currency; const Text: string);
    procedure PrintXReport;
    // numarul raportului Z (0 daca aparatul nu il raporteaza)
    function PrintZReport: Integer;
    // casele fara sertar (ECC) nu fac nimic
    procedure OpenDrawer;
    // Bonul AResult a fost salvat in TDB_DOCS_RECEIPT (dupa commit). ECC leaga rindul de
    // tranzactia din jurnal; Tremol nu face nimic. False = legatura nu s-a facut (nu e fatal).
    function ConfirmRegistered(const AResult: TFiscalReceiptResult; const ADocID: Integer;
      const ASuma: Currency): Boolean;
  end;

// Aparatul firmei pentru calculatorul curent. Nu se conecteaza; apelantul cheama Connect.
function CreateFiscalDevice(const AFirmaID: Integer): IFiscalDevice;
function FiscalPayKindName(const AKind: TFiscalPayKind): string;
// Rotunjire comerciala la bani (0.005 -> 0.01)
function FiscalRoundMoney(const AValue: Double): Currency;

implementation

uses
  TremolFiscalDevice, ECCFiscalDevice;

function FiscalRoundMoney(const AValue: Double): Currency;
var
  Cents: Int64;
begin
  if AValue >= 0 then
    Cents := Trunc(AValue * 100 + 0.5 + 1E-7)
  else
    Cents := -Trunc(-AValue * 100 + 0.5 + 1E-7);
  Result := Cents / 100;
end;

function FiscalPayKindName(const AKind: TFiscalPayKind): string;
begin
  case AKind of
    fpkCash: Result := 'numerar';
    fpkCard: Result := 'card bancar';
    fpkOnline: Result := 'plata online / MIA';
  else
    Result := '?';
  end;
end;

function CreateFiscalDevice(const AFirmaID: Integer): IFiscalDevice;
var
  DeviceInfo: TFiscalDeviceInfo;
begin
  DeviceInfo := GetFiscalDeviceInfo(AFirmaID);
  case DeviceInfo.DeviceType of
    cFiscalDeviceTypeTremol:
      Result := TTremolFiscalDevice.Create(DeviceInfo);
    cFiscalDeviceTypeECC:
      Result := TECCFiscalDevice.Create(DeviceInfo, AFirmaID);
  else
    raise EFiscalDeviceError.CreateFmt('Tip de aparat fiscal necunoscut in FP_DEVICES (FP_ID %d): %d',
      [DeviceInfo.FPID, DeviceInfo.DeviceType]);
  end;
end;

{ TFiscalReceipt }

procedure TFiscalReceipt.Clear;
begin
  Lines := nil;
  Payments := nil;
  DocID := 0;
  SourceType := 0;
  SourceRef := '';
  NoPaperPrint := False;
end;

procedure TFiscalReceipt.AddLine(const ATitle: string; const AQty: Double; const APrice: Currency;
  const AVatPercent: Integer);
var
  L: TFiscalLine;
begin
  L.Title := ATitle;
  L.Qty := AQty;
  L.Price := APrice;
  L.VatPercent := AVatPercent;
  Lines := Lines + [L];
end;

procedure TFiscalReceipt.AddPayment(const AKind: TFiscalPayKind; const AAmount: Currency);
var
  P: TFiscalPayment;
begin
  P.Kind := AKind;
  P.Amount := AAmount;
  Payments := Payments + [P];
end;

function TFiscalReceipt.LinesTotal: Currency;
var
  L: TFiscalLine;
begin
  Result := 0;
  for L in Lines do
    Result := Result + FiscalRoundMoney(L.Price * L.Qty);
end;

function TFiscalReceipt.PaymentsTotal: Currency;
var
  P: TFiscalPayment;
begin
  Result := 0;
  for P in Payments do
    Result := Result + P.Amount;
end;

function TFiscalReceipt.HasZeroVat: Boolean;
var
  L: TFiscalLine;
begin
  Result := False;
  for L in Lines do
    if L.VatPercent = 0 then
      Exit(True);
end;

end.

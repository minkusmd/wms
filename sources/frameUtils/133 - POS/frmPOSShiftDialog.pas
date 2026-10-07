unit frmPOSShiftDialog;

{
  POS - dialogul de tura. Un singur dialog, patru moduri:
    psmOpen    - deschiderea turei (numerarul din sertar la deschidere)
    psmClose   - inchiderea turei: sumar, numerar numarat, raport Z, SP_POS_SHIFT_CLOSE
    psmCashIn  - intrare de numerar in sertar
    psmCashOut - iesire de numerar din sertar

  Ordinea la operatiile cu aparatul fiscal: validare locala -> aparat -> baza.
  Aparatul nu participa la tranzactia bazei, asa ca se valideaza tot ce se poate
  inainte de a tipari ceva.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit, POSSaleUnit;

type
  TPOSShiftDialogMode = (psmOpen, psmClose, psmCashIn, psmCashOut);

  TfrmPOSShiftDlg = class(TSWNCustomForm)
    lblTitle: TLabel;
    lblInfo: TLabel;
    lblSuma: TLabel;
    edSuma: TEdit;
    lblReason: TLabel;
    edReason: TEdit;
    lblFiscal: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnXReport: TButton;
    btnDrawer: TButton;
    procedure btnXReportClick(Sender: TObject);
    procedure btnDrawerClick(Sender: TObject);
    procedure edSumaChange(Sender: TObject);
  private
    { Private declarations }
    fMode: TPOSShiftDialogMode;
    fTerminal: TPOSTerminal;
    fShift: TPOSShift;
    fSummary: TPOSShiftSummary;
    fNewShiftID: Integer;
    function ReadSuma(out Suma: Currency): Boolean;
    procedure ShowSummary;
    procedure ShowDifference;
    function ConfirmWithoutFiscal(const ErrorText, Question: string): Boolean;
    function ExecOpen(const Suma: Currency): Boolean;
    function ExecClose(const Suma: Currency): Boolean;
    function ExecCashMove(const Suma: Currency): Boolean;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    // True = operatia s-a facut. Dupa psmOpen, Shift contine tura noua; dupa psmClose e golit.
    class function Execute(AOwner: TComponent; const Mode: TPOSShiftDialogMode; const Terminal: TPOSTerminal;
      var Shift: TPOSShift): Boolean;
  end;

implementation

uses
  System.UITypes, FiscalDeviceUnit;

{$R *.dfm}

const
  cMoneyFormat = '#,##0.00';

class function TfrmPOSShiftDlg.Execute(AOwner: TComponent; const Mode: TPOSShiftDialogMode;
  const Terminal: TPOSTerminal; var Shift: TPOSShift): Boolean;
var
  Dialog: TfrmPOSShiftDlg;
begin
  Dialog := TfrmPOSShiftDlg.Create(AOwner);
  try
    Dialog.fMode := Mode;
    Dialog.fTerminal := Terminal;
    Dialog.fShift := Shift;
    Result := Dialog.ShowModal = mrOk;
    if Result then
      case Mode of
        psmOpen:
          if not POSGetOpenShift(Terminal.PosID, Shift) then
            Shift.ShiftID := Dialog.fNewShiftID;
        psmClose:
          Shift.Clear;
      end;
  finally
    Dialog.Free;
  end;
end;

procedure TfrmPOSShiftDlg.Prepare;
begin
  lblFiscal.Caption := '';
  lblReason.Visible := fMode <> psmOpen;
  edReason.Visible := fMode <> psmOpen;
  btnXReport.Visible := fMode = psmClose;
  btnDrawer.Visible := fMode in [psmClose, psmCashIn, psmCashOut];

  case fMode of
    psmOpen:
      begin
        Caption := 'Deschidere tura';
        lblTitle.Caption := 'Deschidere tura - ' + fTerminal.Title;
        lblInfo.Caption := 'Numarati banii din sertar si introduceti suma.';
        lblSuma.Caption := 'Numerar la deschidere, lei';
        btnOK.Caption := 'Deschide tura';
        edSuma.Text := '0';
      end;
    psmClose:
      begin
        Caption := 'Inchidere tura';
        lblTitle.Caption := Format('Inchidere tura %d - %s', [fShift.ShiftID, fTerminal.Title]);
        lblSuma.Caption := 'Numerar numarat in sertar, lei';
        lblReason.Caption := 'Explicatie (obligatorie daca exista diferenta)';
        btnOK.Caption := 'Raport Z si inchide';
        fSummary := POSGetShiftSummary(fShift.ShiftID);
        ShowSummary;
        edSuma.Text := '';
      end;
    psmCashIn, psmCashOut:
      begin
        if fMode = psmCashIn then
        begin
          Caption := 'Intrare numerar';
          lblTitle.Caption := 'Intrare de numerar in sertar';
          btnOK.Caption := 'Inregistreaza intrarea';
        end
        else
        begin
          Caption := 'Iesire numerar';
          lblTitle.Caption := 'Iesire de numerar din sertar';
          btnOK.Caption := 'Inregistreaza iesirea';
        end;
        lblSuma.Caption := 'Suma, lei';
        lblReason.Caption := 'Motiv';
        fSummary := POSGetShiftSummary(fShift.ShiftID);
        lblInfo.Caption := 'In sertar (calculat): ' + FormatFloat(cMoneyFormat, fSummary.ExpectedCash) + ' lei';
        edSuma.Text := '';
      end;
  end;
  ActiveControl := edSuma;
end;

procedure TfrmPOSShiftDlg.ShowSummary;
begin
  lblInfo.Caption := Format(
    'Deschisa: %s' + sLineBreak +
    'Bonuri incasate: %d' + sLineBreak +
    'Numerar la deschidere: %s' + sLineBreak +
    'Incasat numerar: %s' + sLineBreak +
    'Incasat card: %s' + sLineBreak +
    'Alte plati: %s' + sLineBreak +
    'Intrari numerar: %s      Iesiri numerar: %s' + sLineBreak +
    'ASTEPTAT IN SERTAR: %s',
    [FormatDateTime('dd.mm.yyyy hh:nn', fShift.OpenedAt), fSummary.SalesCount,
     FormatFloat(cMoneyFormat, fSummary.OpenCash), FormatFloat(cMoneyFormat, fSummary.CashSales),
     FormatFloat(cMoneyFormat, fSummary.CardSales), FormatFloat(cMoneyFormat, fSummary.OtherSales),
     FormatFloat(cMoneyFormat, fSummary.CashIn), FormatFloat(cMoneyFormat, fSummary.CashOut),
     FormatFloat(cMoneyFormat, fSummary.ExpectedCash)]);
  if fSummary.ParkedCount > 0 then
    lblInfo.Caption := lblInfo.Caption + sLineBreak +
      Format('Atentie: %d bonuri in asteptare ramin pe aceasta tura.', [fSummary.ParkedCount]);
end;

procedure TfrmPOSShiftDlg.ShowDifference;
var
  Suma, Diff: Currency;
begin
  if fMode <> psmClose then
    Exit;
  if not ReadSuma(Suma) then
  begin
    lblFiscal.Caption := '';
    Exit;
  end;
  Diff := Suma - fSummary.ExpectedCash;
  if Diff = 0 then
  begin
    lblFiscal.Font.Color := clGreen;
    lblFiscal.Caption := 'Fara diferenta.';
  end
  else
  begin
    lblFiscal.Font.Color := clRed;
    if Diff > 0 then
      lblFiscal.Caption := 'Plus in casa: ' + FormatFloat(cMoneyFormat, Diff) + ' lei'
    else
      lblFiscal.Caption := 'Lipsa in casa: ' + FormatFloat(cMoneyFormat, -Diff) + ' lei';
  end;
end;

procedure TfrmPOSShiftDlg.edSumaChange(Sender: TObject);
begin
  ShowDifference;
end;

function TfrmPOSShiftDlg.ReadSuma(out Suma: Currency): Boolean;
var
  Text: string;
  Value: Double;
begin
  Suma := 0;
  Text := StringReplace(Trim(edSuma.Text), ' ', '', [rfReplaceAll]);
  Text := StringReplace(Text, ',', FormatSettings.DecimalSeparator, []);
  Text := StringReplace(Text, '.', FormatSettings.DecimalSeparator, []);
  Result := (Text <> '') and TryStrToFloat(Text, Value) and (Value >= 0);
  if Result then
    Suma := POSRoundMoney(Value);
end;

function TfrmPOSShiftDlg.ConfirmWithoutFiscal(const ErrorText, Question: string): Boolean;
begin
  Result := MessageDlg(ErrorText + sLineBreak + sLineBreak + Question, mtWarning, [mbYes, mbNo], 0) = mrYes;
end;

function TfrmPOSShiftDlg.IsFormDataPosted: Boolean;
var
  Suma: Currency;
begin
  Result := False;
  if not ReadSuma(Suma) then
  begin
    MessageDlg('Introduceti o suma corecta.', mtError, [mbOK], 0);
    if edSuma.CanFocus then
      edSuma.SetFocus;
    Exit;
  end;

  try
    case fMode of
      psmOpen: Result := ExecOpen(Suma);
      psmClose: Result := ExecClose(Suma);
      psmCashIn, psmCashOut: Result := ExecCashMove(Suma);
    end;
  except
    on E: EPOSError do
      MessageDlg(E.Message, mtError, [mbOK], 0);
    on E: Exception do
      MessageDlg(POSErrorText(E), mtError, [mbOK], 0);
  end;
end;

function TfrmPOSShiftDlg.ExecOpen(const Suma: Currency): Boolean;
begin
  fNewShiftID := POSOpenShift(fTerminal.PosID, Suma);
  Result := fNewShiftID > 0;
end;

// Aparatul fiscal al casei, conectat. nil + ErrorText daca nu e disponibil.
function ConnectPOSFiscal(const FirmaID: Integer; out ErrorText: string): IFiscalDevice;
begin
  Result := nil;
  try
    Result := CreateFiscalDevice(FirmaID);
    if not Result.Connect(ErrorText) then
      Result := nil;
  except
    on E: Exception do
    begin
      Result := nil;
      ErrorText := E.Message;
    end;
  end;
end;

function TfrmPOSShiftDlg.ExecCashMove(const Suma: Currency): Boolean;
var
  Fiscal: IFiscalDevice;
  ErrorText: string;
  Kind: Integer;
begin
  Result := False;
  if Suma <= 0 then
    raise EPOSError.Create('Suma trebuie sa fie mai mare ca zero.');
  if Trim(edReason.Text) = '' then
    raise EPOSError.Create('Indicati motivul miscarii de numerar.');
  if fMode = psmCashIn then
    Kind := 1
  else
    Kind := -1;
  // aceeasi regula ca in SP_POS_CASH_MOVE, verificata inainte de a atinge aparatul
  if (Kind = -1) and (Suma > fSummary.ExpectedCash) then
    raise EPOSError.CreateFmt('In sertar sint doar %s lei.', [FormatFloat(cMoneyFormat, fSummary.ExpectedCash)]);

  Fiscal := ConnectPOSFiscal(fTerminal.FirmaID, ErrorText);
  if Assigned(Fiscal) then
  begin
    Fiscal.CashInOut(Kind * Suma, edReason.Text);
    try
      Fiscal.OpenDrawer;
    except
      // sertarul e o comoditate; miscarea e deja pe aparat
    end;
    Fiscal := nil;
  end
  else if not ConfirmWithoutFiscal(ErrorText, 'Inregistrati miscarea doar in WMS, fara aparatul fiscal?') then
    Exit;

  POSCashMove(fShift.ShiftID, Kind, Suma, edReason.Text);
  Result := True;
end;

function TfrmPOSShiftDlg.ExecClose(const Suma: Currency): Boolean;
var
  Fiscal: IFiscalDevice;
  ErrorText: string;
  ZNumber: Integer;
  Diff: Currency;
begin
  Result := False;
  // sumarul se reciteste: intre deschiderea dialogului si OK se putea incasa ceva
  fSummary := POSGetShiftSummary(fShift.ShiftID);
  ShowSummary;
  if fSummary.OpenCount > 0 then
    raise EPOSError.CreateFmt('Tura are %d bonuri deschise. Incasati-le sau anulati-le.', [fSummary.OpenCount]);
  Diff := Suma - fSummary.ExpectedCash;
  if (Diff <> 0) and (Trim(edReason.Text) = '') then
    raise EPOSError.CreateFmt('Diferenta de casa %s lei: completati explicatia.', [FormatFloat(cMoneyFormat, Diff)]);

  if MessageDlg('Se tipareste raportul Z si se inchide tura. Continuati?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  ZNumber := 0;
  Fiscal := ConnectPOSFiscal(fTerminal.FirmaID, ErrorText);
  if Assigned(Fiscal) then
  begin
    ZNumber := Fiscal.PrintZReport;
    Fiscal := nil;
  end
  else if not ConfirmWithoutFiscal(ErrorText, 'Inchideti tura in WMS FARA raportul Z?') then
    Exit;

  POSCloseShift(fShift.ShiftID, Suma, ZNumber, edReason.Text);
  Result := True;
end;

procedure TfrmPOSShiftDlg.btnXReportClick(Sender: TObject);
var
  Fiscal: IFiscalDevice;
  ErrorText: string;
begin
  try
    Fiscal := ConnectPOSFiscal(fTerminal.FirmaID, ErrorText);
    if Assigned(Fiscal) then
      Fiscal.PrintXReport
    else
      MessageDlg(ErrorText, mtError, [mbOK], 0);
  except
    on E: EFiscalDeviceError do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmPOSShiftDlg.btnDrawerClick(Sender: TObject);
var
  Fiscal: IFiscalDevice;
  ErrorText: string;
begin
  try
    Fiscal := ConnectPOSFiscal(fTerminal.FirmaID, ErrorText);
    if Assigned(Fiscal) then
      Fiscal.OpenDrawer
    else
      MessageDlg(ErrorText, mtError, [mbOK], 0);
  except
    on E: EFiscalDeviceError do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

end.

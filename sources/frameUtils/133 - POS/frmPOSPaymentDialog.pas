unit frmPOSPaymentDialog;

{
  POS - dialogul de plata mixta. Casierul aduna platile pina acopera bonul:
    Numerar - poate depasi restul de plata (diferenta = rest pentru client)
    Card / QR MIA - cel mult restul de plata
  Cimpul de suma gol = "tot ce a ramas". Dialogul doar compune lista de plati;
  documentele si bonul fiscal le face POSCheckoutUnit.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, SWNBaseUnit, POSSaleUnit;

type
  TfrmPOSPaymentDlg = class(TSWNCustomForm)
    lblTotalCaption: TLabel;
    lblTotal: TLabel;
    lblRemainingCaption: TLabel;
    lblRemaining: TLabel;
    lblChangeCaption: TLabel;
    lblChange: TLabel;
    lblSuma: TLabel;
    edSuma: TEdit;
    lblRef: TLabel;
    edRef: TEdit;
    btnCash: TButton;
    btnCard: TButton;
    btnQR: TButton;
    lvPayments: TListView;
    btnRemove: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnCashClick(Sender: TObject);
    procedure btnCardClick(Sender: TObject);
    procedure btnQRClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure edSumaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fTotal: Currency;
    fPayments: TPOSPaymentArray;
    function Paid: Currency;
    function Remaining: Currency;
    function ReadSuma(out Suma: Currency): Boolean;
    procedure AddPayment(const PayCode: string);
    procedure RefreshView;
    function PayTitle(const PayCode: string): string;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    class function Execute(AOwner: TComponent; const Total: Currency; out Payments: TPOSPaymentArray): Boolean;
  end;

implementation

uses
  System.UITypes;

{$R *.dfm}

const
  cMoneyFormat = '#,##0.00';

class function TfrmPOSPaymentDlg.Execute(AOwner: TComponent; const Total: Currency;
  out Payments: TPOSPaymentArray): Boolean;
var
  Dialog: TfrmPOSPaymentDlg;
begin
  Payments := nil;
  Dialog := TfrmPOSPaymentDlg.Create(AOwner);
  try
    Dialog.fTotal := Total;
    Result := Dialog.ShowModal = mrOk;
    if Result then
      Payments := Dialog.fPayments;
  finally
    Dialog.Free;
  end;
end;

procedure TfrmPOSPaymentDlg.Prepare;
begin
  fPayments := nil;
  RefreshView;
  ActiveControl := edSuma;
end;

function TfrmPOSPaymentDlg.PayTitle(const PayCode: string): string;
begin
  if PayCode = cPOS_Pay_Cash then
    Result := 'Numerar'
  else if PayCode = cPOS_Pay_Card then
    Result := 'Card'
  else if PayCode = cPOS_Pay_QR then
    Result := 'QR MIA'
  else
    Result := PayCode;
end;

function TfrmPOSPaymentDlg.Paid: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(fPayments) do
    Result := Result + fPayments[I].Suma;
end;

function TfrmPOSPaymentDlg.Remaining: Currency;
begin
  Result := fTotal - Paid;
end;

function TfrmPOSPaymentDlg.ReadSuma(out Suma: Currency): Boolean;
var
  Text: string;
  Value: Double;
begin
  Text := StringReplace(Trim(edSuma.Text), ' ', '', [rfReplaceAll]);
  // gol = tot restul de plata
  if Text = '' then
  begin
    Suma := Remaining;
    Exit(Suma > 0);
  end;
  Text := StringReplace(Text, ',', FormatSettings.DecimalSeparator, []);
  Text := StringReplace(Text, '.', FormatSettings.DecimalSeparator, []);
  Result := TryStrToFloat(Text, Value) and (Value > 0);
  if Result then
    Suma := POSRoundMoney(Value)
  else
    Suma := 0;
end;

procedure TfrmPOSPaymentDlg.AddPayment(const PayCode: string);
var
  Suma: Currency;
  Payment: TPOSPayment;
  I: Integer;
begin
  if Remaining <= 0 then
  begin
    MessageDlg('Bonul este deja acoperit.', mtInformation, [mbOK], 0);
    Exit;
  end;
  if not ReadSuma(Suma) then
  begin
    MessageDlg('Introduceti o suma corecta.', mtError, [mbOK], 0);
    if edSuma.CanFocus then
      edSuma.SetFocus;
    Exit;
  end;

  Payment.PayCode := PayCode;
  Payment.ExtRef := Trim(edRef.Text);
  if PayCode = cPOS_Pay_Cash then
  begin
    // numerarul poate depasi restul de plata: diferenta e restul pentru client
    Payment.Tendered := Suma;
    if Suma > Remaining then
      Payment.Suma := Remaining
    else
      Payment.Suma := Suma;
    Payment.ExtRef := '';
  end
  else
  begin
    if Suma > Remaining then
    begin
      MessageDlg(Format('Pe card / QR se poate incasa cel mult restul de plata: %s lei.',
        [FormatFloat(cMoneyFormat, Remaining)]), mtError, [mbOK], 0);
      Exit;
    end;
    Payment.Suma := Suma;
    Payment.Tendered := Suma;
  end;

  // o singura linie de numerar: a doua se aduna la prima
  if PayCode = cPOS_Pay_Cash then
    for I := 0 to High(fPayments) do
      if fPayments[I].PayCode = cPOS_Pay_Cash then
      begin
        fPayments[I].Suma := fPayments[I].Suma + Payment.Suma;
        fPayments[I].Tendered := fPayments[I].Tendered + Payment.Tendered;
        Payment.Suma := 0;
        Break;
      end;
  if Payment.Suma > 0 then
  begin
    SetLength(fPayments, Length(fPayments) + 1);
    fPayments[High(fPayments)] := Payment;
  end;

  edSuma.Text := '';
  edRef.Text := '';
  RefreshView;
  if Remaining <= 0 then
  begin
    if btnOK.CanFocus then
      btnOK.SetFocus;
  end
  else if edSuma.CanFocus then
    edSuma.SetFocus;
end;

procedure TfrmPOSPaymentDlg.RefreshView;
var
  I: Integer;
  Item: TListItem;
  Change: Currency;
begin
  lvPayments.Items.BeginUpdate;
  try
    lvPayments.Items.Clear;
    Change := 0;
    for I := 0 to High(fPayments) do
    begin
      Item := lvPayments.Items.Add;
      Item.Caption := PayTitle(fPayments[I].PayCode);
      Item.SubItems.Add(FormatFloat(cMoneyFormat, fPayments[I].Suma));
      Item.SubItems.Add(FormatFloat(cMoneyFormat, fPayments[I].Tendered));
      Item.SubItems.Add(fPayments[I].ExtRef);
      Change := Change + fPayments[I].Change;
    end;
  finally
    lvPayments.Items.EndUpdate;
  end;
  lblTotal.Caption := FormatFloat(cMoneyFormat, fTotal);
  lblRemaining.Caption := FormatFloat(cMoneyFormat, Remaining);
  lblChange.Caption := FormatFloat(cMoneyFormat, Change);
  if Remaining > 0 then
    lblRemaining.Font.Color := clRed
  else
    lblRemaining.Font.Color := clGreen;
  btnOK.Enabled := (Remaining = 0) and (Length(fPayments) > 0);
  btnRemove.Enabled := Length(fPayments) > 0;
end;

function TfrmPOSPaymentDlg.IsFormDataPosted: Boolean;
begin
  Result := (Remaining = 0) and (Length(fPayments) > 0);
  if not Result then
    MessageDlg(Format('Au mai ramas de incasat %s lei.', [FormatFloat(cMoneyFormat, Remaining)]), mtError, [mbOK], 0);
end;

procedure TfrmPOSPaymentDlg.btnCashClick(Sender: TObject);
begin
  AddPayment(cPOS_Pay_Cash);
end;

procedure TfrmPOSPaymentDlg.btnCardClick(Sender: TObject);
begin
  AddPayment(cPOS_Pay_Card);
end;

procedure TfrmPOSPaymentDlg.btnQRClick(Sender: TObject);
begin
  AddPayment(cPOS_Pay_QR);
end;

procedure TfrmPOSPaymentDlg.btnRemoveClick(Sender: TObject);
var
  Index, I: Integer;
begin
  if lvPayments.Selected <> nil then
    Index := lvPayments.Selected.Index
  else
    Index := High(fPayments);
  if (Index < 0) or (Index > High(fPayments)) then
    Exit;
  for I := Index to High(fPayments) - 1 do
    fPayments[I] := fPayments[I + 1];
  SetLength(fPayments, Length(fPayments) - 1);
  RefreshView;
  if edSuma.CanFocus then
    edSuma.SetFocus;
end;

procedure TfrmPOSPaymentDlg.edSumaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // F1 numerar, F2 card, F3 QR - fara mouse
  case Key of
    VK_F1:
      begin
        Key := 0;
        AddPayment(cPOS_Pay_Cash);
      end;
    VK_F2:
      begin
        Key := 0;
        AddPayment(cPOS_Pay_Card);
      end;
    VK_F3:
      begin
        Key := 0;
        AddPayment(cPOS_Pay_QR);
      end;
  end;
end;

end.

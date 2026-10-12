unit frmECCReceiptSendDialog;

{ Fereastra de dinaintea emiterii bonului pe casa ECC: cum primeste clientul bonul
  (tiparit / e-mail / Viber / SMS) si adresa sau numarul lui, verificate pina sa existe bonul.
  O deschide ECCChooseReceiptSend din ECCReceiptSendUnit, care propune si contactul. }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.UITypes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit, ECCReceiptSendUnit;

type
  TfrmECCReceiptSendDlg = class(TSWNCustomForm)
    lblSummary: TLabel;
    rgKinds: TRadioGroup;
    lblContact: TLabel;
    edContact: TEdit;
    pnBottom: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure rgKindsClick(Sender: TObject);
  private
    FEmail, FPhone: string;
    FLastKind: Integer;
    procedure StoreContact;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    procedure SetData(const ASummary, AEmail, APhone: string; const AKind: TECCReceiptSendKind);
    function Choice: TECCReceiptSendChoice;
  end;

implementation

uses
  System.StrUtils, ReportMessengerSendUnit;

{$R *.dfm}

function IsValidEmail(const S: string): Boolean;
var
  At: Integer;
begin
  At := Pos('@', S);
  Result := (At > 1) and (Pos('@', S, At + 1) = 0) and (Pos('.', S, At + 2) > 0) and
    (S[Length(S)] <> '.') and (Pos(' ', S) = 0);
end;

// Mobil din Moldova in formatul cozii SMS (0XXXXXXXX, 06... / 07...); '' = nu e mobil valid.
function NormalizeSmsPhone(const APhone: string): string;
var
  Digits: string;
begin
  Result := '';
  Digits := NormalizePhoneForMessenger(APhone);  // 373XXXXXXXX
  if (Length(Digits) = 11) and StartsStr('373', Digits) and CharInSet(Digits[4], ['6', '7']) then
    Result := '0' + Copy(Digits, 4, MaxInt);
end;

procedure TfrmECCReceiptSendDlg.SetData(const ASummary, AEmail, APhone: string;
  const AKind: TECCReceiptSendKind);
begin
  lblSummary.Caption := ASummary;
  FEmail := AEmail;
  FPhone := APhone;
  FLastKind := Ord(AKind);
  rgKinds.OnClick := nil;
  rgKinds.ItemIndex := Ord(AKind);
  rgKinds.OnClick := rgKindsClick;
end;

procedure TfrmECCReceiptSendDlg.Prepare;
begin
  inherited;
  rgKindsClick(nil);
  // textul bonului are lungime variabila: inaltimea se potriveste dupa el
  ClientHeight := edContact.Top + edContact.Height + pnBottom.Height;
end;

// adresa si numarul se tin separat: trecerea intre variante nu pierde ce a scris operatorul
procedure TfrmECCReceiptSendDlg.StoreContact;
begin
  case TECCReceiptSendKind(FLastKind) of
    rskEmail: FEmail := Trim(edContact.Text);
    rskViber, rskSms: FPhone := Trim(edContact.Text);
  end;
end;

procedure TfrmECCReceiptSendDlg.rgKindsClick(Sender: TObject);
begin
  if Sender <> nil then
    StoreContact;
  FLastKind := rgKinds.ItemIndex;
  case TECCReceiptSendKind(rgKinds.ItemIndex) of
    rskEmail:
      begin
        lblContact.Caption := 'Adresa de e-mail a clientului:';
        edContact.Text := FEmail;
      end;
    rskViber:
      begin
        lblContact.Caption := 'Telefonul clientului in Viber:';
        edContact.Text := FPhone;
      end;
    rskSms:
      begin
        lblContact.Caption := 'Telefonul mobil al clientului (06... / 07...):';
        edContact.Text := FPhone;
      end;
    rskNone:
      begin
        lblContact.Caption := 'Bonul doar se emite in MEV: nu se tipareste si nu se trimite.';
        edContact.Text := '';
      end;
  else
    lblContact.Caption := 'Bonul se tipareste pe imprimanta bonurilor a acestui calculator.';
    edContact.Text := '';
  end;
  edContact.Enabled := TECCReceiptSendKind(rgKinds.ItemIndex) in [rskEmail, rskViber, rskSms];
  if edContact.Enabled and Visible then
    edContact.SetFocus;
end;

function TfrmECCReceiptSendDlg.IsFormDataPosted: Boolean;
var
  S, Err: string;
begin
  S := Trim(edContact.Text);
  Err := '';
  case TECCReceiptSendKind(rgKinds.ItemIndex) of
    rskEmail:
      if not IsValidEmail(S) then
        Err := 'Introduceti o adresa de e-mail corecta.';
    rskViber:
      if NormalizePhoneForMessenger(S) = '' then
        Err := 'Introduceti numarul de telefon al clientului (de ex. 069123456).';
    rskSms:
      if NormalizeSmsPhone(S) = '' then
        Err := 'SMS-ul se trimite doar pe un mobil din Moldova (06... / 07..., 9 cifre).';
  end;
  Result := Err = '';
  if not Result then
  begin
    MessageDlg(Err, mtWarning, [mbOK], 0);
    edContact.SetFocus;
  end;
end;

function TfrmECCReceiptSendDlg.Choice: TECCReceiptSendChoice;
begin
  Result.Kind := TECCReceiptSendKind(rgKinds.ItemIndex);
  case Result.Kind of
    rskEmail: Result.Contact := Trim(edContact.Text);
    rskViber: Result.Contact := NormalizePhoneForMessenger(edContact.Text);
    rskSms: Result.Contact := NormalizeSmsPhone(edContact.Text);
  else
    Result.Contact := '';
  end;
end;

end.

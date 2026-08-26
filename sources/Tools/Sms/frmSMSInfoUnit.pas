unit frmSMSInfoUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  Vcl.ExtCtrls,
  RzPanel,
  RzDlgBtn,
  cxMemo,
  cxTextEdit,
  cxLabel,
  SWNBaseUnit;

type
  TfrmSMSInfoDlg = class(TSWNCustomForm)
    cxLabel1: TcxLabel;
    tePhoneNumber: TcxTextEdit;
    cxLabel2: TcxLabel;
    meMessage: TcxMemo;
    RzDialogButtons1: TRzDialogButtons;
  private
    FPhoneNumber: string;
    procedure SendSMS;
    function ValidatePhoneNumber(FPhoneNumber: string): Boolean;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; APhoneNumber: string); overload;
  end;

var
  frmSMSInfoDlg: TfrmSMSInfoDlg;

implementation

uses
  DataModuleDB, IBC, SWNUtils, System.Character;

{$R *.dfm}



{ TfrmSMSInfoDlg }

constructor TfrmSMSInfoDlg.Create(AOwner: TComponent; APhoneNumber: string);
begin
  inherited Create(AOwner);
  FPhoneNumber := APhoneNumber;
end;

procedure TfrmSMSInfoDlg.SendSMS;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    if Trim(FPhoneNumber) = '' then
    begin
      raise Exception.Create('Eroare! Indicati numarul de telefon!');
    end;
    Query.Connection := dmdb.IBCConnection;
    Query.Transaction := dmdb.IBCTrDefaultUpdate;
    Query.SQL.Add('insert into sms_messages (phone, sms_text)');
    Query.SQL.Add('values (:phone, :sms_text)');
    Query.ParamByName('PHONE').AsString := FPhoneNumber;
    Query.ParamByName('SMS_TEXT').AsString := meMessage.Lines.Text;
    ;
    try
      Query.ExecSQL;
      if Query.transaction.Active then
        Query.Transaction.Commit;

      ShowInfoDialog('SWN', 'Mesajul a fost transmis la centru de procesare!');
    except
      on e: Exception do
      begin
        if Query.transaction.Active then
          Query.Transaction.Rollback;
        raise e.Create('Eroare la introducerea datelor!' + sLineBreak + e.message);
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TfrmSMSInfoDlg.IsFormDataPosted: Boolean;
begin

  if not (ValidatePhoneNumber(Trim(tePhoneNumber.Text))) then
  begin
    Result := false;
    raise Exception.Create('Eroare la validarea numarului de telefon');
  end;
  if trim(meMessage.Lines.Text) = '' then
  begin
    Result := false;
    raise Exception.Create('Messajul este gol');
  end;

  try
    SendSMS;
  except
    begin
      Result := false;
      raise;
    end;
  end;
end;

procedure TfrmSMSInfoDlg.Prepare;
begin
  inherited;

end;

function TfrmSMSInfoDlg.ValidatePhoneNumber(FPhoneNumber: string): Boolean;
var
  S: string;
  I: Integer;

  function IsAllDigits(const AValue: string): Boolean;
  var
    J: Integer;
  begin
    Result := (AValue <> '');
    for J := 1 to AValue.Length do
      if not AValue[J].IsDigit then
        Exit(False);
  end;

begin
  Result := false;
  S := Trim(FPhoneNumber);

  // 1) exact 9 caractere
  if S.Length <> 9 then
    raise EArgumentException.CreateFmt(
      'Numărul de telefon trebuie să conțină exact 9 cifre (ex: 099999999). Valoare primită: "%s".',
      [S]
    );

  // 2) doar cifre
  if not IsAllDigits(S) then
    raise EArgumentException.CreateFmt(
      'Numărul de telefon poate conține doar cifre (0-9). Valoare primită: "%s".',
      [S]
    );

  // 3) trebuie să înceapă cu 0
  if S[1] <> '0' then
    raise EArgumentException.CreateFmt(
      'Numărul de telefon din Moldova (format local) trebuie să înceapă cu "0" (ex: 099999999). Valoare primită: "%s".',
      [S]
    );

  // 4) prefix mobil (MD) uzual: 060-069, 076-079, 078, 079 etc.
  //    Dacă vrei strict doar "0" + 8 cifre, comentează blocul de mai jos.
  //    NOTĂ: Lista de prefixe poate fi extinsă după nevoile tale.
  if not ((S.StartsWith('06')) or (S.StartsWith('07'))) then
    raise EArgumentException.CreateFmt(
    'Prefix neacceptat. Pentru mobil în Moldova se folosesc uzual prefixe de tip 06x/07x. Valoare primită: "%s".',
    [S]
  );

  // 5) opțional: interzice 000000000
  if S = '000000000' then
    raise EArgumentException.Create('Numărul de telefon nu poate fi "000000000".');

  // Dacă ai nevoie să normalizezi înapoi în control (trim), fă asta unde apelezi metoda.
  Result := True;
end;

procedure TfrmSMSInfoDlg.WhenCancelForm;
begin
  inherited;

end;

end.


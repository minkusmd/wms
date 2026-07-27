unit frmPasswordDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, Menus, StdCtrls, cxButtons, ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

type

  TPasswordDialogOnVerifyPassword = procedure(const PasswordToVerify: String; var PasswordOk: Boolean) of object;
  TPasswordDialogMode = (pdmAskPassword, pdmNewPassword, pdmChangePassword);

  TfrmPasswordDialog = class(TForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    pnNewPass: TPanel;
    lbNewPass: TLabel;
    edNewPass: TEdit;
    pnPassConfirm: TPanel;
    edPassConfirm: TEdit;
    lbPassConfirm: TLabel;
    pnBottom: TPanel;
    pnPass: TPanel;
    lbPass: TLabel;
    edPass: TEdit;
    lbStrongPassword: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fPasswordMode: TPasswordDialogMode;
    FOnVerifyPassword: TPasswordDialogOnVerifyPassword;
    FMinPasswordLength: integer;
    FAllowNewPasswordLikeOld: Boolean;
    FRequireStrongPassword: Boolean;
    fPassword: String;
    fCurrentPassword: String;
    procedure SetOnVerifyPassword(const Value: TPasswordDialogOnVerifyPassword);
    function CheckValues: Boolean;
    procedure SetMinPasswordLength(const Value: integer);
    procedure PrepareView;
    procedure SetAllowNewPasswordLikeOld(const Value: Boolean);
    procedure SetRequireStrongPassword(const Value: Boolean);
    function IsPasswordStrong(const Password: String): Boolean;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const PasswordMode: TPasswordDialogMode); reintroduce;
    property OnVerifyPassword: TPasswordDialogOnVerifyPassword read FOnVerifyPassword write SetOnVerifyPassword;

    property CurrentPassword: String read fCurrentPassword;
    property Password: String read fPassword;

    property MinPasswordLength: integer read FMinPasswordLength write SetMinPasswordLength;
    property AllowNewPasswordLikeOld: Boolean read FAllowNewPasswordLikeOld write SetAllowNewPasswordLikeOld;
    property RequireStrongPassword: Boolean read FRequireStrongPassword write SetRequireStrongPassword;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmPasswordDialog }

procedure TfrmPasswordDialog.btnOkClick(Sender: TObject);
begin
  fCurrentPassword := '';
  if CheckValues then
  begin
    case fPasswordMode of
      pdmAskPassword:
        begin
          fPassword := Trim(edPass.Text);
        end;
      pdmNewPassword:
        begin
          fPassword := Trim(edNewPass.Text);
        end;
      pdmChangePassword:
        begin
          fPassword := Trim(edNewPass.Text);
          fCurrentPassword := Trim(edPass.Text);
        end;
    end;
    ModalResult := mrOk;
  end;
end;

function TfrmPasswordDialog.CheckValues: Boolean;
var
  ErrorStr: String;
  PasswordOk: Boolean;
begin
  Result := False;
  ErrorStr := '';

  case fPasswordMode of
    pdmAskPassword:
      begin
        if Trim(edPass.Text) = '' then
          AddErrorToStr(ErrorStr, 'Introduceti parola!');
      end;
    pdmNewPassword:
      begin
        if Trim(edNewPass.Text) = '' then
          AddErrorToStr(ErrorStr, 'Introduceti parola noua!');
        if Trim(edPassConfirm.Text) = '' then
          AddErrorToStr(ErrorStr, 'Confirmati parola noua!');

        if (ErrorStr = '') and (edNewPass.Text <> edPassConfirm.Text) then
          AddErrorToStr(ErrorStr, 'Difera parolele!');
        if (ErrorStr = '') and (Length(edNewPass.Text) < FMinPasswordLength) then
          AddErrorToStr(ErrorStr, Format('Lungimea parole trebuie sa fie mai mare decit %d simboluri!', [FMinPasswordLength]));

        if (ErrorStr = '') and (FRequireStrongPassword) and (Not IsPasswordStrong(edNewPass.Text)) then
          AddErrorToStr(ErrorStr, 'Parola este slaba!');
      end;
    pdmChangePassword:
      begin
        if Trim(edPass.Text) = '' then
          AddErrorToStr(ErrorStr, 'Introduceri parola veche!');
        if Trim(edNewPass.Text) = '' then
          AddErrorToStr(ErrorStr, 'Introduceri parola noua!');
        if Trim(edPassConfirm.Text) = '' then
          AddErrorToStr(ErrorStr, 'Confirmati parola noua!');

        if (ErrorStr = '') and (edNewPass.Text <> edPassConfirm.Text) then
          AddErrorToStr(ErrorStr, 'Parolele introduse sunt diferite!');
        if (ErrorStr = '') and (Length(edNewPass.Text) < FMinPasswordLength) then
          AddErrorToStr(ErrorStr, Format('Lungimea parole mai mare decit %d simboluri!', [FMinPasswordLength]));
        if (ErrorStr = '') and (edNewPass.Text = edPass.Text) and (Not FAllowNewPasswordLikeOld) then
          AddErrorToStr(ErrorStr, 'Parola noua trebuie sa fie diferita de cea veche!');

        if (ErrorStr = '') and (FRequireStrongPassword) and (Not IsPasswordStrong(edNewPass.Text)) then
          AddErrorToStr(ErrorStr, 'Parola noua este slaba!');

        if (ErrorStr = '') then
        begin
          // verify if old password is ok
          PasswordOk := False;
          if Assigned(FOnVerifyPassword) then
            FOnVerifyPassword(edPass.Text, PasswordOk);
          if Not PasswordOk then
            AddErrorToStr(ErrorStr, 'Старый пароль не правильный!');
        end;
      end;
  end;
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, ErrorStr);
end;

constructor TfrmPasswordDialog.Create(const AOwner: TComponent; const PasswordMode: TPasswordDialogMode);
begin
  inherited Create(AOwner);

  FMinPasswordLength := 3;
  FAllowNewPasswordLikeOld := True;
  RequireStrongPassword := False;
  fPassword := '';
  fCurrentPassword := '';

  fPasswordMode := PasswordMode;
end;

procedure TfrmPasswordDialog.FormShow(Sender: TObject);
begin
  PrepareView;
end;

function TfrmPasswordDialog.IsPasswordStrong(const Password: String): Boolean;
var
  i: integer;
  count_digits: integer;
  count_small: integer;
  count_big: integer;
  count_simbols: integer;
  count_others: integer;
  C: char;
begin
  count_digits := 0;
  count_small := 0;
  count_big := 0;
  count_simbols := 0;
  count_others := 0;

  if Length(Password) > 0 then
    for i := 1 to Length(Password) do
    begin
      C := Password[i];
      if CharInSet(C, ['0' .. '9']) then
        inc(count_digits)
      else if CharInSet(C, ['a' .. 'z']) then
        inc(count_small)
      else if CharInSet(C, ['A' .. 'Z']) then
        inc(count_big)
      else if CharInSet(C, ['!' .. '/', '@', '~']) then
        inc(count_simbols)
      else
        inc(count_others);
    end;
  // at least one digit and any simbols
  Result := (count_digits > 0) and ((count_small > 0) or (count_big > 0) or (count_others > 0) or (count_simbols > 0));
end;

procedure TfrmPasswordDialog.PrepareView;
begin
  case fPasswordMode of
    pdmAskPassword:
      begin
        // text
        Caption := 'Parola pentru client';
        dtDialogTitle.Title := Caption;
        dtDialogTitle.Text := 'Pentru a continua introduceri parola';
        // controls
        pnPass.Margins.Bottom := 12;
        lbPass.Caption := 'Parola';
        pnNewPass.Visible := False;
        pnPassConfirm.Visible := False;
        // default control
        ActiveControl := edPass;
        // default action
        btnOk.Default := True;
        lbStrongPassword.Visible := False;
      end;
    pdmNewPassword:
      begin
        Caption := 'Parola pentru client';
        dtDialogTitle.Title := Caption;
        dtDialogTitle.Text := 'Introduceri parola noua';
        // controls
        pnPass.Visible := False;
        // default control
        ActiveControl := edNewPass;
        lbStrongPassword.Visible := FRequireStrongPassword;
      end;
    pdmChangePassword:
      begin
        Caption := 'Modifica parola';
        dtDialogTitle.Title := Caption;
        dtDialogTitle.Text := 'Introduceti parola veche si noua';
        // default control
        ActiveControl := edPass;

        lbStrongPassword.Visible := FRequireStrongPassword;
      end;
  end;
  AutoSize := True;
end;

procedure TfrmPasswordDialog.SetAllowNewPasswordLikeOld(const Value: Boolean);
begin
  FAllowNewPasswordLikeOld := Value;
end;

procedure TfrmPasswordDialog.SetMinPasswordLength(const Value: integer);
begin
  if Value >= 1 then
    FMinPasswordLength := Value
  else
    FMinPasswordLength := 1;
end;

procedure TfrmPasswordDialog.SetOnVerifyPassword(const Value: TPasswordDialogOnVerifyPassword);
begin
  FOnVerifyPassword := Value;
end;

procedure TfrmPasswordDialog.SetRequireStrongPassword(const Value: Boolean);
begin
  FRequireStrongPassword := Value;
  if FRequireStrongPassword then
  begin
    FMinPasswordLength := 6;
    FAllowNewPasswordLikeOld := False;
  end;
end;

end.

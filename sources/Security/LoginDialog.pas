unit LoginDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNUpdateToolsDBUnit, Dialogs,
  StdCtrls, ExtCtrls, DB, DBAccess, IBC, Menus, dxGDIPlusClasses, cxButtons, cxImage, cxTextEdit, cxLabel,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, MemDS, cxMaskEdit, cxButtonEdit, dxShellDialogs,
  dxCoreGraphics;

type
  TfrmLoginDlg = class(TForm)
    pnButtons: TPanel;
    pnMain: TPanel;
    pnAddons: TPanel;
    Bevel1: TBevel;
    IBCConnection: TIBCConnection;
    IBCTrSelect: TIBCTransaction;
    IBCQuery: TIBCQuery;
    tmKLTimer: TTimer;
    btnLogin: TcxButton;
    btnClose: TcxButton;
    imgLogo: TcxImage;
    edUserName: TcxTextEdit;
    edPassword: TcxTextEdit;
    edServerAddress: TcxTextEdit;
    edPort: TcxTextEdit;
    edSpecial: TcxTextEdit;
    edDatabaseAlias: TcxTextEdit;
    Label5: TcxLabel;
    lbKL: TcxLabel;
    lbVersion: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel1: TcxLabel;
    Label3: TcxLabel;
    Label6: TcxLabel;
    Label1: TcxLabel;
    Label2: TcxLabel;
    cxLabel3: TcxLabel;
    dxOpenFileDialog1: TdxOpenFileDialog;
    beFBClientPath: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tmKLTimerTimer(Sender: TObject);
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fAppVersion: TFileVersionInfo;
    fDBVersion: TFileVersionInfo;
    fDBChanges: string;
    fDBCritical: Boolean;
    fAuthentificated: Boolean;
    fDatabaseName: string;
    FServerPort: integer;
    FServerAddress: string;
    FUserName: string;
    fUserPassword: string;
    fUserID: integer;
    fHasSecurityConfirmation: Boolean;
    FUpdaterAppName: string;
    function CheckParams: Boolean;
    function TryToAuthentificate: Boolean;
    procedure SetServerAddress(const Value: string);
    procedure SetServerPort(const Value: integer);
    procedure SetUserName(const Value: string);
    procedure DisplayKeyboardLayout;
    function ChangeUserPassword(const StrongPass: Boolean): Boolean;
    procedure WhenVerifyOldPassword(const PasswordToVerify: string; var PasswordOk: Boolean);
    function ChangeUserPasswordDB(const UserName, OldPass, NewPass: string): Boolean;
    function ActivationIsNotValid: Boolean;
    procedure LoadLogoImage;
    procedure SetDatabaseAlias(const Value: string);
    function CheckForNewVersion: Boolean;
    procedure ShowNewVersionDialog;
    procedure SetUpdaterAppName(const Value: string);
  public
    { Public declarations }
    property UserName: string read FUserName write SetUserName;
    property ServerAddress: string read FServerAddress write SetServerAddress;
    property ServerPort: integer read FServerPort write SetServerPort;
    property DatabaseAlias: string read fDatabaseName write SetDatabaseAlias;
    property UpdaterAppName: string read FUpdaterAppName write SetUpdaterAppName;
    property UserPassword: string read fUserPassword;
    property UserID: integer read fUserID;
    property Authentificated: Boolean read fAuthentificated;
    property HasSecurityConfirmation: Boolean read fHasSecurityConfirmation;
  end;

implementation

uses
  SWNUtils, SWNConst, SWNSecurityUtils, SWNValueStorageUnit, frmPasswordDlg, frmNewVersionDialog, ShellApi,
  SWNUpdateClientDBClass;

{$R *.dfm}

function TfrmLoginDlg.ActivationIsNotValid: Boolean;
var
  S, S2: string;
  i: integer;
begin
  Result := True;

  S := edPassword.Text;
  if S <> '' then
  begin
    S2 := '';
    for i := 1 to Length(S) do
      S2 := S[i] + S2;
    Result := edSpecial.Text <> S2;
  end;
end;

procedure TfrmLoginDlg.btnLoginClick(Sender: TObject);
begin
  if CheckParams then
  begin

    if TryToAuthentificate then
    begin
      fAuthentificated := True;
      fDatabaseName := edDatabaseAlias.Text;
      FUserName := edUserName.Text;
      fUserPassword := edPassword.Text;
      FServerPort := StrToInt(edPort.Text);
      FServerAddress := edServerAddress.Text;

      if AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppSaveLastLogin, True) then
        AppConfigStorage.TextValues.SetValue(cSETTINGS_AppLastLogin, FUserName);

      ModalResult := mrOk;
    end
    else
      edPassword.Text := '';
  end;
end;

function TfrmLoginDlg.ChangeUserPassword(const StrongPass: Boolean): Boolean;
var
  dialog: TfrmPasswordDialog;
  OldPass, NewPass: string;
  toChangePass: Boolean;
begin
  Result := False;
  toChangePass := False;
  ShowInfoDialog('Modificare parola', 'Va rugam sa schimbati parola de acces!');

  dialog := TfrmPasswordDialog.Create(Self, pdmChangePassword);
  try
    dialog.AllowNewPasswordLikeOld := False;
    dialog.RequireStrongPassword := StrongPass;

    dialog.OnVerifyPassword := WhenVerifyOldPassword;
    if dialog.ShowModal = mrOk then
    begin
      OldPass := dialog.edPass.Text;
      NewPass := dialog.Password;
      toChangePass := True;
    end;
  finally
    dialog.Free;
  end;

  if toChangePass then
  begin
    Result := ChangeUserPasswordDB(edUserName.Text, OldPass, NewPass);
    if Result then
      ShowInfoDialog('Modificare parola', 'Parola a fost modificata cu succes!' + sLineBreak +
        'Introduceti parola noua pentru a continua.')
    else
      ShowErrorDialog('Modificare parola', 'Eroare! Adresati-va la administrator.');
  end;
end;

function TfrmLoginDlg.ChangeUserPasswordDB(const UserName, OldPass, NewPass: string): Boolean;
begin
  Result := False;
  IBCQuery.Close;
  IBCQuery.SQL.Text := 'SELECT USERID FROM SP_CHANGE_USER_PASS(:LOGIN,:OLDPASS_HASH,:PASS_HASH)';
  IBCQuery.ParamByName('LOGIN').AsString := UserName;
  IBCQuery.ParamByName('OLDPASS_HASH').AsString := CreateHashPassword(OldPass);
  IBCQuery.ParamByName('PASS_HASH').AsString := CreateHashPassword(NewPass);
  try
    IBCQuery.ExecSQL;
    if not IBCQuery.Eof then
      Result := IBCQuery.FieldByName('USERID').asInteger > 0;
    IBCQuery.Transaction.Commit;
  finally
    IBCQuery.Close;
  end;
end;

function TfrmLoginDlg.CheckForNewVersion: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := IBCConnection;
    Query.SQL.Add('SELECT FIRST 1 "VERSION", VERSION_STR, (SELECT CHANGES FROM TAU_FILEVERSIONCHANGES WHERE TAU_FILEVERSIONCHANGES."VERSION"=TAU_FILEVERSIONS."VERSION"), FLG_CRITICAL');
    Query.SQL.Add('FROM TAU_FILEVERSIONS');
    Query.SQL.Add('ORDER BY TAU_FILEVERSIONS."VERSION" DESC');
    Query.ExecSQL;
    if not Query.Eof then
    begin
      if VersionStrToNum(Query.Fields[1].AsString, fDBVersion) then
      begin
        Result := FileVersionBigger(fDBVersion, fAppVersion);
        fDBChanges := Query.Fields[2].AsString;
        fDBCritical := Query.Fields[3].asInteger = 1;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function TfrmLoginDlg.CheckParams: Boolean;
var
  ErrorStr: string;
  N: integer;
begin
  Result := False;
  ErrorStr := '';
  if (Trim(edUserName.Text) = '') then
    AddErrorToStr(ErrorStr, 'Indicati numele utilizatorului!');
  if (Trim(edPassword.Text) = '') then
    AddErrorToStr(ErrorStr, 'Introduceti parola!');
  if (Trim(edServerAddress.Text) = '') then
    AddErrorToStr(ErrorStr, 'Introduceri adresa serverului!');
  N := StrToIntDef(edPort.Text, 0);
  if (N = 0) then
    AddErrorToStr(ErrorStr, 'Nu este indicat portul pentru conectare!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_LOGIN_InputError_Title, cMSG_LOGIN_InputError_Text, ErrorStr);
end;

procedure TfrmLoginDlg.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin

    if dxOpenFileDialog1.Execute then
    begin
        beFBClientPath.Text := dxOpenFileDialog1.FileName;
    end;
end;

procedure TfrmLoginDlg.DisplayKeyboardLayout;
var
  Buf: array[0..KL_NAMELENGTH] of WideChar;
  S: string;
begin
  if GetKeyboardLayoutName(Buf) then
  begin
    setstring(S, Buf, strlen(Buf));
    if S = '00000409' then
      lbKL.Caption := 'EN'
    else if S = '00000418' then
      lbKL.Caption := 'RO'
    else if S = '00000419' then
      lbKL.Caption := 'RU'
    else
      lbKL.Caption := '?';
  end
  else
    lbKL.Caption := '?';
end;

procedure TfrmLoginDlg.FormCreate(Sender: TObject);
begin
  fAuthentificated := False;
  fDatabaseName := cDATABASE_DBName;
  ServerPort := cDATABASE_ConnectionPortDefault;
  ServerAddress := cDATABASE_ConnectionServerDefault;
  FUserName := '';
  fUserPassword := '';
  fUserID := -1;
  fHasSecurityConfirmation := False;
  Caption := cAPP_Title;

  if GetMyFileVersion(Application.ExeName, fAppVersion) then
    lbVersion.Caption := Format(cAPP_Version, [FileVersionToStr(fAppVersion)])
  else
    lbVersion.Caption := 'No version!';

  edSpecial.Text := 'UTF-8';

  LoadLogoImage;
end;

procedure TfrmLoginDlg.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 122) and (ssShift in Shift) and (ssCtrl in Shift) then
    pnAddons.Visible := not pnAddons.Visible;
end;

procedure TfrmLoginDlg.FormShow(Sender: TObject);
begin
  // adjust view according to properties
  if FServerAddress <> '' then
    pnAddons.Hide;
  if FUserName = '' then
    ActiveControl := edUserName
  else
    ActiveControl := edPassword;

  DisplayKeyboardLayout;
end;

procedure TfrmLoginDlg.LoadLogoImage;
var
  png: TdxPNGImage;
  RS: TResourceStream;
begin
  png := TdxPNGImage.Create;
  RS := TResourceStream.Create(HInstance, 'PNG_SWNLOGOBIG', 'PNG');
  try
    png.LoadFromStream(RS);
    imgLogo.Picture.Assign(png);
  finally
    RS.Free;
    png.Free;
  end;
end;

procedure TfrmLoginDlg.SetDatabaseAlias(const Value: string);
begin
  fDatabaseName := Value;
  edDatabaseAlias.Text := fDatabaseName;
end;

procedure TfrmLoginDlg.SetServerAddress(const Value: string);
begin
  FServerAddress := Value;
  edServerAddress.Text := FServerAddress;
end;

procedure TfrmLoginDlg.SetServerPort(const Value: integer);
begin
  if (Value > 0) and (Value <= 65535) then
    FServerPort := Value
  else
    FServerPort := cDATABASE_ConnectionPortDefault;
  edPort.Text := IntToStr(FServerPort);
end;

procedure TfrmLoginDlg.SetUpdaterAppName(const Value: string);
begin
  FUpdaterAppName := Value;
end;

procedure TfrmLoginDlg.SetUserName(const Value: string);
begin
  FUserName := Value;
  edUserName.Text := FUserName;
end;

procedure TfrmLoginDlg.ShowNewVersionDialog;
var
  dialog: TfrmNewVersionDlg;
begin
  dialog := TfrmNewVersionDlg.Create(Self);
  try
    dialog.SetVersionInfo(FileVersionToStr(fAppVersion), FileVersionToStr(fDBVersion), fDBChanges, fDBCritical);
    if dialog.ShowModal = mrOk then
    begin
      if LaunchUpdater(FUpdaterAppName) then
      begin
        Application.Terminate;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmLoginDlg.tmKLTimerTimer(Sender: TObject);
begin
  DisplayKeyboardLayout;
end;

function TfrmLoginDlg.TryToAuthentificate: Boolean;
var
  MustChangePass, StrongPass, DBisLocked, RequireUpdate, PartialBlocked: Boolean;
  Actions: integer;
  hasNewVersion: Boolean;
  isFirstTimeRun: Boolean;
  ServerPort: integer;
begin
  Result := False;

  // validate inputs
  IBCConnection.Database := Format('%s/%s:%s', [edServerAddress.Text, edPort.Text, edDatabaseAlias.Text]);
  // cDATABASE_DBName
  IBCConnection.UserName := cDATABASE_TestLogin_UserName;
  IBCConnection.Password := cDATABASE_TestLogin_UserPassword;
  try
    try
      // try to connect
      IBCConnection.Connected := True;

      fDBCritical := False;
      hasNewVersion := CheckForNewVersion;

      ServerPort := StrToInt(edPort.Text);

      // daca intra prima data pe server, ii dam voie sa intri indiferent daca este versiune nou
      isFirstTimeRun := (AppConfigStorage.TextValues.GetValue('DATABASE_ALIAS', '') <> edDatabaseAlias.Text)
        or (AppConfigStorage.TextValues.GetValue('SERVER_ADDRESS', '') <> edServerAddress.Text) or (AppConfigStorage.IntValues.GetValue
        ('SERVER_PORT', 0) <> ServerPort);

      // 14.01.2014 - Daca s-a conectat la baza, salvam adresa serverului sesiunea urmatoare si pentru !!! updater
      AppConfigStorage.TextValues.SetValue('DATABASE_ALIAS', edDatabaseAlias.Text);
      AppConfigStorage.TextValues.SetValue('SERVER_ADDRESS', edServerAddress.Text);
      AppConfigStorage.IntValues.SetValue('SERVER_PORT', ServerPort);

      // check user credentials
      IBCQuery.Close;
      IBCQuery.SQL.Text := 'SELECT USERID, ACTIONS FROM CAN_USER_LOGIN2(:LOGIN,:PASS_HASH,:APP_VERSION)';
      IBCQuery.ParamByName('LOGIN').AsString := edUserName.Text;
      IBCQuery.ParamByName('PASS_HASH').AsString := CreateHashPassword(edPassword.Text);
      IBCQuery.ParamByName('APP_VERSION').AsLargeInt := GetVersionNumber(fAppVersion);
      IBCQuery.ExecSQL;
      if not IBCQuery.Eof then
      begin
        // user can login
        fUserID := IBCQuery.Fields[0].asInteger;
        Actions := IBCQuery.Fields[1].asInteger;
        DBisLocked := (Actions and $01) = $01;
        MustChangePass := (Actions and $02) = $02;
        StrongPass := (Actions and $04) = $04;
        RequireUpdate := (Actions and $08) = $08;
        PartialBlocked := (Actions and $10) = $10;
        Result := (fUserID > 0);
        IBCQuery.Close;

        // priority actions
        // 1. Require Update
        // 2. DB is Locked
        // 3. MustChangePass (StrongPass)

        fHasSecurityConfirmation := not ActivationIsNotValid;

        if hasNewVersion and not isFirstTimeRun then
        begin
          // update to new version
          Result := False;
          fDBCritical := fDBCritical or RequireUpdate;
          ShowNewVersionDialog;
        end
        else if DBisLocked and (not fHasSecurityConfirmation or not PartialBlocked) then
        begin
          Result := False;
          ShowErrorDialog(cMSG_LOGIN_LoginDenied_Title, cMSG_LOGIN_LoginDenied2_Text, cMSG_LOGIN_LoginDenied2_Expanded);
        end
        else if Result then
        begin
          // user must change its password
          if MustChangePass then
          begin
            Result := False;
            if ChangeUserPassword(StrongPass) then
            begin
              edPassword.Text := '';
            end;
          end;
        end;
      end
      else
        ShowErrorDialog(cMSG_LOGIN_LoginDenied_Title, cMSG_LOGIN_LoginDenied_Text,
          cMSG_LOGIN_LoginDenied_Expanded, cMSG_LOGIN_LoginDenied_Footer);
    except
      on E: Exception do
        ShowErrorDialog(cMSG_LOGIN_LoginError_Title, cMSG_LOGIN_LoginError_Text, E.Message,
          cMSG_LOGIN_LoginError_Footer);
    end;
  finally
    IBCConnection.Connected := False;
  end;

end;

procedure TfrmLoginDlg.WhenVerifyOldPassword(const PasswordToVerify: string; var PasswordOk: Boolean);
begin
  PasswordOk := (PasswordToVerify = edPassword.Text);
end;

end.


unit PWLoginDialog;

{ WMSPriceWatch - autentificarea ca in WMS: utilizator + parola verificate cu
  CAN_USER_LOGIN2(LOGIN, PASS_HASH, APP_VERSION) pe conexiunea tehnica de login
  (cDATABASE_TestLogin_*), apoi programul lucreaza cu contul din SWNConst, ca SWN.
  Ultimul utilizator si serverul se tin in %LOCALAPPDATA%\SWN\WMSPriceWatch.ini. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, PWBaseFormUnit, DialogTitle, IBC, DBAccess, MemDS, Data.DB,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxButtons,
  cxMaskEdit, cxSpinEdit, PWTypes;

type
  TfrmPWLoginDlg = class(TPWCustomForm)
    dtDialogTitle: TDialogTitle;
    lbUser: TLabel;
    edUser: TcxTextEdit;
    lbPassword: TLabel;
    edPassword: TcxTextEdit;
    lbServer: TLabel;
    edServer: TcxTextEdit;
    lbDatabase: TLabel;
    edDatabase: TcxTextEdit;
    lbPort: TLabel;
    edPort: TcxSpinEdit;
    lbError: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    FConn: TPWConnParams;
    function IniFileName: string;
    procedure LoadSettings;
    procedure SaveSettings;
    function Authenticate(out AError: string): Boolean;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    property Conn: TPWConnParams read FConn write FConn;
  end;

// dialogul de autentificare; True = autentificat, AConn completat (UserID, UserName, server)
function PWLogin(var AConn: TPWConnParams): Boolean;

implementation

uses
  System.IniFiles, System.IOUtils, System.UITypes, SWNConst, SWNSecurityUtils;

{$R *.dfm}

function PWLogin(var AConn: TPWConnParams): Boolean;
var
  Dlg: TfrmPWLoginDlg;
begin
  Dlg := TfrmPWLoginDlg.Create(Application);
  try
    Dlg.Conn := AConn;
    Result := Dlg.ShowModal = mrOk;
    if Result then
      AConn := Dlg.Conn;
  finally
    Dlg.Free;
  end;
end;

{ TfrmPWLoginDlg }

function TfrmPWLoginDlg.IniFileName: string;
var
  Dir: string;
begin
  Dir := TPath.Combine(TPath.GetHomePath, 'SWN');   // %LOCALAPPDATA%\SWN, ca SWN.exe
  try
    ForceDirectories(Dir);
  except
    Dir := ExtractFilePath(ParamStr(0));
  end;
  Result := TPath.Combine(Dir, 'WMSPriceWatch.ini');
end;

procedure TfrmPWLoginDlg.LoadSettings;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(IniFileName);
  try
    edUser.Text := Ini.ReadString('Login', 'User', '');
    edServer.Text := Ini.ReadString('Login', 'Server', FConn.Server);
    edDatabase.Text := Ini.ReadString('Login', 'Database', FConn.Database);
    edPort.Value := Ini.ReadInteger('Login', 'Port', FConn.Port);
  finally
    Ini.Free;
  end;
end;

procedure TfrmPWLoginDlg.SaveSettings;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(IniFileName);
  try
    Ini.WriteString('Login', 'User', Trim(edUser.Text));
    Ini.WriteString('Login', 'Server', Trim(edServer.Text));
    Ini.WriteString('Login', 'Database', Trim(edDatabase.Text));
    Ini.WriteInteger('Login', 'Port', edPort.Value);
  finally
    Ini.Free;
  end;
end;

procedure TfrmPWLoginDlg.Prepare;
begin
  dtDialogTitle.Title := 'Autentificare';
  dtDialogTitle.Text := 'Utilizatorul si parola din WMS. Programul va lucra non-stop in numele acestui utilizator.';
  lbError.Caption := '';
  LoadSettings;
  if Trim(edUser.Text) = '' then
    ActiveControl := edUser
  else
    ActiveControl := edPassword;
end;

function TfrmPWLoginDlg.Authenticate(out AError: string): Boolean;
var
  Conn: TIBCConnection;
  Q: TIBCQuery;
  Actions: Integer;
begin
  Result := False;
  AError := '';
  Conn := TIBCConnection.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Conn.Options.Charset := 'UTF8';
    Conn.Options.UseUnicode := True;
    Conn.ClientLibrary := 'fbclient.dll';
    Conn.LoginPrompt := False;
    Conn.Database := Format('%s/%d:%s', [Trim(edServer.Text), edPort.Value, Trim(edDatabase.Text)]);
    Conn.Username := cDATABASE_TestLogin_UserName;
    Conn.Password := cDATABASE_TestLogin_UserPassword;
    try
      Conn.Connected := True;
    except
      on E: Exception do
      begin
        AError := 'Nu ma pot conecta la server: ' + E.Message;
        Exit;
      end;
    end;
    Q.Connection := Conn;
    Q.SQL.Text := 'SELECT USERID, ACTIONS FROM CAN_USER_LOGIN2(:LOGIN, :PASS_HASH, :APP_VERSION)';
    Q.ParamByName('LOGIN').AsString := Trim(edUser.Text);
    Q.ParamByName('PASS_HASH').AsString := CreateHashPassword(edPassword.Text);
    Q.ParamByName('APP_VERSION').AsLargeInt := 0;
    try
      Q.Open;
      if Q.Eof or (Q.Fields[0].AsInteger <= 0) then
      begin
        AError := 'Utilizator sau parola gresita.';
        Exit;
      end;
      Actions := Q.Fields[1].AsInteger;
      if (Actions and $01) = $01 then
      begin
        AError := 'Accesul la baza de date este blocat.';
        Exit;
      end;
      FConn.UserID := Q.Fields[0].AsInteger;
      FConn.UserName := Trim(edUser.Text);
      Q.Close;
    except
      on E: Exception do
      begin
        AError := 'Verificarea utilizatorului: ' + E.Message;
        Exit;
      end;
    end;
    FConn.Server := Trim(edServer.Text);
    FConn.Port := edPort.Value;
    FConn.Database := Trim(edDatabase.Text);
    FConn.User := cDATABASE_UserLogin_UserName;
    FConn.Password := cDATABASE_UserLogin_UserPassword;
    Result := True;
  finally
    Q.Free;
    Conn.Free;
  end;
end;

function TfrmPWLoginDlg.IsFormDataPosted: Boolean;
var
  Err: string;
begin
  Result := False;
  if Trim(edUser.Text) = '' then
  begin
    lbError.Caption := 'Completati utilizatorul.';
    ActiveControl := edUser;
    Exit;
  end;
  if edPassword.Text = '' then
  begin
    lbError.Caption := 'Completati parola.';
    ActiveControl := edPassword;
    Exit;
  end;
  Screen.Cursor := crHourGlass;
  try
    Result := Authenticate(Err);
  finally
    Screen.Cursor := crDefault;
  end;
  if Result then
    SaveSettings
  else
  begin
    lbError.Caption := Err;
    edPassword.Text := '';
    ActiveControl := edPassword;
  end;
end;

end.

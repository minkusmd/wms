unit AppSettingsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Menus, SWNBaseUnit, StdCtrls, Buttons, ComCtrls,
  cxButtons, DialogTitle, Vcl.ExtCtrls,
  frameSipAudioSettingsUnit, cxLabel, cxPC, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu,
  cxControls, cxContainer, cxEdit;

type
  TfrmAppSettingsDialog = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    pcPageControl: TPageControl;
    tbsGeneral: TTabSheet;
    tbsView: TTabSheet;
    Label4: TLabel;
    sbResetFormPos: TSpeedButton;
    sbResetGridColumns: TSpeedButton;
    tbsUserInfo: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    sbChangeUserPass: TSpeedButton;
    cbStartWithWindows: TCheckBox;
    cbSaveLastLogin: TCheckBox;
    cbSaveFormPos: TCheckBox;
    cbSaveGridColumns: TCheckBox;
    cmbFontSize: TComboBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    tbsSounds: TTabSheet;
    Label9: TLabel;
    cmbSounds_Rashod: TComboBox;
    sbPlay_Rashod: TSpeedButton;
    edUserName: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edUserPhone: TEdit;
    edUserEmail: TEdit;
    Label13: TLabel;
    edUserBirthDate: TEdit;
    Label3: TLabel;
    edUserAddress: TEdit;
    Label10: TLabel;
    sbResetConfirmations: TSpeedButton;
    Label14: TLabel;
    sbPlay_Sborka: TSpeedButton;
    cmbSounds_NareadSborka: TComboBox;
    Label15: TLabel;
    cmbSounds_WebZakaz: TComboBox;
    sbPlay_WebZakaz: TSpeedButton;
    cbSaveMultiMonitorPos: TCheckBox;
    tbsSipClient: TTabSheet;
    tsCulori: TTabSheet;
    cxPageControl1: TcxPageControl;
    cxTabSheet2: TcxTabSheet;
    cbITSales_Background: TColorBox;
    cbITSales_Foreground: TColorBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cbFurnitureSales_Background: TColorBox;
    cbFurnitureSales_Foreground: TColorBox;
    cxLabel3: TcxLabel;
    cbService_Background: TColorBox;
    cbService_Foreground: TColorBox;
    cxLabel4: TcxLabel;
    cbAccounting_Background: TColorBox;
    cbAccounting_Foreground: TColorBox;
    cxLabel5: TcxLabel;
    cbPurchaise_Background: TColorBox;
    cbPurchaise_Foreground: TColorBox;
    cxButton1: TcxButton;
    Label16: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label17: TLabel;
    Image3: TImage;
    Label18: TLabel;
    waveInDevice: TComboBox;
    waveOutDevice: TComboBox;
    waveRingDevice: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure sbResetFormPosClick(Sender: TObject);
    procedure sbResetGridColumnsClick(Sender: TObject);
    procedure sbPlay_RashodClick(Sender: TObject);
    procedure sbChangeUserPassClick(Sender: TObject);
    procedure sbResetConfirmationsClick(Sender: TObject);
    procedure sbPlay_SborkaClick(Sender: TObject);
    procedure sbPlay_WebZakazClick(Sender: TObject);
    procedure tbsSipClientShow(Sender: TObject);
    procedure tbsSipClientExit(Sender: TObject);
    procedure frameSipAudioSettings1Label1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayValues;
    procedure PrepareFontList;
    procedure SaveValues;
    procedure DoResetFormPos;
    procedure DoResetGridColumns;
    procedure PlayCustomSound(const FileName: string);
    procedure Create_SoundsList;
    procedure ChangeUserPassword;
    procedure WhenVerifyCurrentPassword(const PasswordToVerify: string; var PasswordOk: Boolean);
    procedure GetSipAudioSettings;
    procedure LoadSipAudioSettings;
    procedure SaveSipAudioSettings;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SaveStates; override;
    procedure LoadStates; override;

  public
    { Public declarations }
  end;

implementation

uses
  SWNValueStorageUnit, SWNConst, SWNUtils, MMSystem,
  SWNSecurity, frmPasswordDlg, DataModuleDB;

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}
{ TfrmAppSettingsDialog }

procedure TfrmAppSettingsDialog.btnOkClick(Sender: TObject);
begin
  SaveValues;
  ModalResult := mrOk;
end;

procedure TfrmAppSettingsDialog.ChangeUserPassword;
var
  dialog: TfrmPasswordDialog;
begin
  dialog := TfrmPasswordDialog.Create(Self, pdmChangePassword);
  try
    // dialog.RequireStrongPassword:=True;
    dialog.OnVerifyPassword := WhenVerifyCurrentPassword;
    if dialog.ShowModal = mrOk then
    begin
      // change password
      if SWNSecurityManager.ChangeCurrentUserPassword(dialog.Password, dialog.CurrentPassword) then
        ShowInfoDialog('Modificare parola', 'Parola a fost modifica!')
      else
        ShowErrorDialog('Modificare parola', 'Eroare la modificarea parolei!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmAppSettingsDialog.Create_SoundsList;
var
  root: string;
  Sr: TSearchRec;
  N: integer;
  sList: TStringList;
begin
  sList := TStringList.Create;
  cmbSounds_Rashod.Items.BeginUpdate;
  cmbSounds_NareadSborka.Items.BeginUpdate;
  cmbSounds_WebZakaz.Items.BeginUpdate;
  try
    sList.Add(cSOUND_DefaultAudioTitle);

    root := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));

    N := FindFirst(root + '*.wav', faArchive, Sr);
    while N = 0 do
    begin
      if (Sr.Name <> '.') and (Sr.Name <> '..') and ((Sr.Attr and faDirectory) <> faDirectory) then
      begin
        sList.Add(ReplaceFileExt(Sr.Name, ''));
      end;
      N := FindNext(Sr);
    end;
    FindClose(Sr);

    cmbSounds_Rashod.Items.AddStrings(sList);
    cmbSounds_NareadSborka.Items.AddStrings(sList);
    cmbSounds_WebZakaz.Items.AddStrings(sList);

  finally
    cmbSounds_NareadSborka.Items.EndUpdate;
    cmbSounds_Rashod.Items.EndUpdate;
    cmbSounds_WebZakaz.Items.EndUpdate;
    sList.Free;
  end;
end;

procedure TfrmAppSettingsDialog.cxButton1Click(Sender: TObject);
begin

   AppConfigStorage.DeleteSettingsFile;
end;

procedure TfrmAppSettingsDialog.DisplayValues;
var
  S: string;
begin
  // Generale
  cbStartWithWindows.Checked := AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppAutoStart);
  cbSaveLastLogin.Checked := AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppSaveLastLogin, True);

  // Tip
  PrepareFontList;
  cmbFontSize.ItemIndex := AppUserConfigStorage.IntValues.GetValue(cSETTINGS_UserFontSize, cAppDefaultFontIndex); // Dimensiune fonturi;
  cbSaveFormPos.Checked := AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos);
  cbSaveGridColumns.Checked := AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns);
  cbSaveMultiMonitorPos.Checked := AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveMonitorPosition);
  cbSaveMultiMonitorPos.Enabled := Screen.MonitorCount > 1;

  // Utilizator
  edUserName.Text := SWNSecurityManager.LoggedUser.FullName;
  edUserPhone.Text := SWNSecurityManager.LoggedUser.Telefon;
  edUserEmail.Text := SWNSecurityManager.LoggedUser.EMail;
  edUserBirthDate.Text := FormatDateTime('dd mmmm yyyy', SWNSecurityManager.LoggedUser.BirthDay);
  edUserAddress.Text := SWNSecurityManager.LoggedUser.Address;

  // Notificari
  // 1. Nakladnaia de iesire
  S := AppUserConfigStorage.TextValues.GetValue(cSOUND_РасходнаяНакладная, cSOUND_DefaultAudioTitle);
  if S <> cSOUND_DefaultAudioTitle then
    S := ReplaceFileExt(S, '');
  cmbSounds_Rashod.ItemIndex := cmbSounds_Rashod.Items.IndexOf(S);
  // 2. Naryad de asamblare
  S := AppUserConfigStorage.TextValues.GetValue(cSOUND_НарядНаСборку, cSOUND_DefaultAudioTitle);
  if S <> cSOUND_DefaultAudioTitle then
    S := ReplaceFileExt(S, '');
  cmbSounds_NareadSborka.ItemIndex := cmbSounds_Rashod.Items.IndexOf(S);
  // 3. Comanda Web
  S := AppUserConfigStorage.TextValues.GetValue(cSOUND_WebZakaz, cSOUND_DefaultAudioTitle);
  if S <> cSOUND_DefaultAudioTitle then
    S := ReplaceFileExt(S, '');
  cmbSounds_WebZakaz.ItemIndex := cmbSounds_WebZakaz.Items.IndexOf(S);
end;

procedure TfrmAppSettingsDialog.DoResetFormPos;
begin
  AppUserConfigStorage.FormPositions.Clear;
end;

procedure TfrmAppSettingsDialog.DoResetGridColumns;
begin
  AppUserConfigStorage.GridColumns.Clear;
end;

procedure TfrmAppSettingsDialog.FormCreate(Sender: TObject);
begin
  pcPageControl.ActivePage := tbsGeneral;
end;

procedure TfrmAppSettingsDialog.frameSipAudioSettings1Label1Click(Sender: TObject);
begin
//  frameSipAudioSettings1.Label1Click(Sender);

end;

procedure TfrmAppSettingsDialog.Label18Click(Sender: TObject);
begin
 GetSipAudioSettings;
end;

procedure TfrmAppSettingsDialog.GetSipAudioSettings;
var
  DevOutCaps: TWaveOutCaps;
  DevInCaps: TWaveInCaps;
  n, i: Integer;
  s: String;
begin
  waveOutDevice.Items.Clear;
  waveOutDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveOutGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveOutGetDevCaps(i, @DevOutCaps, SizeOf(DevOutCaps));
    s := PChar(@DevOutCaps.szPname);
    waveOutDevice.Items.Add(s);
  end;
  waveInDevice.Items.Clear;
  waveInDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveInGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveInGetDevCaps(i, @DevInCaps, SizeOf(DevInCaps));
    s := PChar(@DevInCaps.szPname);
    waveInDevice.Items.Add(s);
  end;
  waveRingDevice.Items.Clear;
  waveRingDevice.Items.AddObject('Default', TObject(WAVE_MAPPER));
  n := waveOutGetNumDevs;
  for i := 0 to n-1 do
  begin
    waveOutGetDevCaps(i, @DevOutCaps, SizeOf(DevOutCaps));
    s := PChar(@DevOutCaps.szPname);
    waveRingDevice.Items.Add(s);
  end;

  waveOutDevice.ItemIndex := 0;
  waveInDevice.ItemIndex := 0;
  waveRingDevice.ItemIndex := 0;

end;

procedure TfrmAppSettingsDialog.LoadStates;
begin
        cbITSales_Background.Selected := AppUserConfigStorage.IntValues.GetValue('ITSales_Background', clPurple);
        cbITSales_Foreground.Selected := AppUserConfigStorage.IntValues.GetValue('ITSales_Foreground', clWhite);

        cbFurnitureSales_Background.Selected := AppUserConfigStorage.IntValues.GetValue('FurnitureSales_Background', clFuchsia);
        cbFurnitureSales_Foreground.Selected := AppUserConfigStorage.IntValues.GetValue('FurnitureSales_Foreground', clWhite);

        cbService_Background.Selected := AppUserConfigStorage.IntValues.GetValue('Service_Background', clYellow);
        cbService_Foreground.Selected := AppUserConfigStorage.IntValues.GetValue('Service_Foreground', clBlack);

        cbAccounting_Background.Selected := AppUserConfigStorage.IntValues.GetValue('Accounting_Background', clRed);
        cbAccounting_Foreground.Selected := AppUserConfigStorage.IntValues.GetValue('Accounting_Foreground', clWhite);

        cbPurchaise_Background.Selected := AppUserConfigStorage.IntValues.GetValue('Purchaise_Background', clTeal);
        cbPurchaise_Foreground.Selected := AppUserConfigStorage.IntValues.GetValue('Purchaise_Foreground', clBlack);
end;

procedure TfrmAppSettingsDialog.PlayCustomSound(const FileName: string);
var
  SoundFilePathName: string;
begin
  if FileName = cSOUND_DefaultAudioTitle then
    PlaySound(PWideChar(cSOUND_DefaultAudio), 0, SND_ASYNC)
  else
  begin
    SoundFilePathName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + FileName + '.wav';
    if FileExists(SoundFilePathName) then
      PlaySound(PWideChar(SoundFilePathName), 0, SND_FILENAME + SND_ASYNC)
    else
      PlaySound(PWideChar(cSOUND_DefaultAudio), 0, SND_ASYNC);
  end;
end;

procedure TfrmAppSettingsDialog.Prepare;
begin
  Create_SoundsList;
  DisplayValues;
end;

procedure TfrmAppSettingsDialog.PrepareFontList;
var
  i: integer;
begin
  cmbFontSize.Items.BeginUpdate;
  try
    cmbFontSize.Items.Clear;
    for i := 0 to High(cFontSizeItems) do
      cmbFontSize.Items.Add(cFontSizeItems[i].Title);
  finally
    cmbFontSize.Items.EndUpdate;
  end;
end;

procedure TfrmAppSettingsDialog.SaveStates;
begin
    AppUserConfigStorage.IntValues.SetValue('ITSales_Background', cbITSales_Background.Selected);
    AppUserConfigStorage.IntValues.SetValue('ITSales_Foreground', cbITSales_Foreground.Selected);

    AppUserConfigStorage.IntValues.SetValue('FurnitureSales_Background', cbFurnitureSales_Background.Selected);
    AppUserConfigStorage.IntValues.SetValue('FurnitureSales_Foreground', cbFurnitureSales_Foreground.Selected);

    AppUserConfigStorage.IntValues.SetValue('Service_Background', cbService_Background.Selected);
    AppUserConfigStorage.IntValues.SetValue('Service_Foreground', cbService_Foreground.Selected);

    AppUserConfigStorage.IntValues.SetValue('Accounting_Background', cbAccounting_Background.Selected);
    AppUserConfigStorage.IntValues.SetValue('Accounting_Foreground', cbAccounting_Foreground.Selected);

    AppUserConfigStorage.IntValues.SetValue('Purchaise_Background', cbPurchaise_Background.Selected);
    AppUserConfigStorage.IntValues.SetValue('Purchaise_Foreground', cbPurchaise_Foreground.Selected);

    // Refresh Colors in system.
    dmdb.LoadSipColors;
end;

procedure TfrmAppSettingsDialog.SaveValues;
var
  S: string;
begin
  // Generale
  AppConfigStorage.BooleanValues.SetValue(cSETTINGS_AppAutoStart, cbStartWithWindows.Checked);
  AppConfigStorage.BooleanValues.SetValue(cSETTINGS_AppSaveLastLogin, cbSaveLastLogin.Checked);

  // Tip
  AppUserConfigStorage.IntValues.SetValue(cSETTINGS_UserFontSize, cmbFontSize.ItemIndex); // Dimensiune fonturi;
  AppUserConfigStorage.BooleanValues.SetValue(cSETTINGS_UserSaveFormPos, cbSaveFormPos.Checked);
  AppUserConfigStorage.BooleanValues.SetValue(cSETTINGS_UserSaveGridColumns, cbSaveGridColumns.Checked);
  AppUserConfigStorage.BooleanValues.SetValue(cSETTINGS_UserSaveMonitorPosition, cbSaveMultiMonitorPos.Checked);

  // Notificari
  // 1. Nakladnaia de iesire
  S := cmbSounds_Rashod.Text;
  if S <> cSOUND_DefaultAudioTitle then
    S := S + '.wav';
  AppUserConfigStorage.TextValues.SetValue(cSOUND_РасходнаяНакладная, S);
  // 2. Naryad de asamblare
  S := cmbSounds_NareadSborka.Text;
  if S <> cSOUND_DefaultAudioTitle then
    S := S + '.wav';
  AppUserConfigStorage.TextValues.SetValue(cSOUND_НарядНаСборку, S);
  // 3. Comanda Web
  S := cmbSounds_WebZakaz.Text;
  if S <> cSOUND_DefaultAudioTitle then
    S := S + '.wav';
  AppUserConfigStorage.TextValues.SetValue(cSOUND_WebZakaz, S);
end;

procedure TfrmAppSettingsDialog.sbChangeUserPassClick(Sender: TObject);
begin
  ChangeUserPassword;
end;

procedure TfrmAppSettingsDialog.sbPlay_RashodClick(Sender: TObject);
begin
  PlayCustomSound(cmbSounds_Rashod.Text);
end;

procedure TfrmAppSettingsDialog.sbPlay_SborkaClick(Sender: TObject);
begin
  PlayCustomSound(cmbSounds_NareadSborka.Text);
end;

procedure TfrmAppSettingsDialog.sbPlay_WebZakazClick(Sender: TObject);
begin
  PlayCustomSound(cmbSounds_WebZakaz.Text);
end;

procedure TfrmAppSettingsDialog.sbResetConfirmationsClick(Sender: TObject);
begin
  AppUserConfigStorage.Confirmations.Clear;
  sbResetConfirmations.Enabled := False;
end;

procedure TfrmAppSettingsDialog.sbResetFormPosClick(Sender: TObject);
begin
  DoResetFormPos;
  sbResetFormPos.Enabled := False;
end;

procedure TfrmAppSettingsDialog.sbResetGridColumnsClick(Sender: TObject);
begin
  DoResetGridColumns;
  sbResetGridColumns.Enabled := False;
end;

procedure TfrmAppSettingsDialog.tbsSipClientExit(Sender: TObject);
begin
//  FrameSipAudioSettings1.SaveSipAudioSettings;
 SaveSipAudioSettings;
end;

procedure TfrmAppSettingsDialog.tbsSipClientShow(Sender: TObject);
begin
//  FrameSipAudioSettings1.LoadSipAudioSettings;
  LoadSipAudioSettings;
end;

procedure TfrmAppSettingsDialog.WhenVerifyCurrentPassword(const PasswordToVerify: string; var PasswordOk: Boolean);
begin
  PasswordOk := SWNSecurityManager.TestUserPassword(SWNSecurityManager.LoggedUser.UserID, PasswordToVerify);
end;

procedure TfrmAppSettingsDialog.LoadSipAudioSettings;
begin
  waveInDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveInDevice', '');
  waveOutDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveOutDevice', '');
  waveRingDevice.Text := AppUserConfigStorage.TextValues.GetValue('WaveRingDevice', '');
end;

procedure TfrmAppSettingsDialog.SaveSipAudioSettings;
begin
  AppUserConfigStorage.TextValues.SetValue('WaveInDevice', waveInDevice.Text);
  AppUserConfigStorage.TextValues.SetValue('WaveOutDevice', waveOutDevice.Text);
  AppUserConfigStorage.TextValues.SetValue('WaveRingDevice', waveRingDevice.Text);
end;


end.


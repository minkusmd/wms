unit frmSipPhoneWindowUnit;
{
  Telefonul SIP intr-o fereastra separata, nemodala si mereu deasupra (10.10.2026).

  Fereastra nu are componente proprii: la pornire MainForm muta aici bara SIP (bdcSIP) si
  frame-ul clientului SIP (frameSipClient1: apelare + istoria apelurilor). Ele raman
  componentele MainForm, deci codul care le foloseste (frameSipClient1.*, butoanele barii SIP,
  scurtaturile Alt+A / Alt+Q) merge neschimbat.

  Inchiderea doar ascunde fereastra; pozitia, marimea si vizibilitatea se pastreaza in
  AppUserConfigStorage. Ca si frame-ul SIP, fereastra ramane activa cand un dialog modal
  dezactiveaza celelalte ferestre: operatorul poate raspunde la un apel din orice dialog.

  Fiind activa si mereu deasupra, Windows ii dadea ei activarea la revenirea in aplicatie (taskbar,
  Alt+Tab, click pe MainForm dezactivata de un dialog modal). De aceea telefonul primeste focusul
  doar cand se face click pe el; altfel il preda ferestrei de lucru (dialogul activ sau MainForm).

  Proprietarul ferestrei e MainForm (CreateFor + CreateParams). Handle-ul se creeaza in
  TfrmMainForm.FormCreate, cand Application.MainForm e inca nil, si VCL (fsStayOnTop -> pmNone) ii
  dadea ca proprietar fereastra ascunsa Application.Handle; la revenirea in aplicatie cu un dialog
  modal deschis TApplication (CM_ACTIVATE) facea SetFocus(GetLastActivePopup(Application.Handle)),
  adica pe telefon, chiar si ascuns.
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.Types, Vcl.Controls, Vcl.Forms;

const
  WM_SIPWND_REENABLE = WM_USER + 4243;
  WM_SIPWND_PASSACTIVATION = WM_USER + 4244;

type
  TfrmSipPhoneWindow = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fOwnerForm: TCustomForm;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMSipReenable(var Message: TMessage); message WM_SIPWND_REENABLE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMSipPassActivation(var Message: TMessage); message WM_SIPWND_PASSACTIVATION;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    // AOwnerForm = fereastra proprietar (MainForm); componenta nu are Owner
    constructor CreateFor(AOwnerForm: TCustomForm);
    procedure LoadPosition;
    procedure SavePosition;
    // la pornire: fereastra apare daca era deschisa la ultima iesire (implicit da)
    procedure RestoreVisibility;
    procedure ShowPhone;
    procedure TogglePhone;
  end;

implementation

uses
  SWNValueStorageUnit;

{$R *.dfm}

const
  cKeyLeft = 'SipPhoneWindow.Left';
  cKeyTop = 'SipPhoneWindow.Top';
  cKeyWidth = 'SipPhoneWindow.Width';
  cKeyHeight = 'SipPhoneWindow.Height';
  cKeyVisible = 'SipPhoneWindow.Visible';
  cDefaultWidth = 360;
  cDefaultHeight = 720;

constructor TfrmSipPhoneWindow.CreateFor(AOwnerForm: TCustomForm);
begin
  fOwnerForm := AOwnerForm;
  inherited Create(nil);
end;

procedure TfrmSipPhoneWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Assigned(fOwnerForm) then
    Params.WndParent := fOwnerForm.Handle;
end;

procedure TfrmSipPhoneWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // telefonul nu se distruge: SIP-ul ramane inregistrat, apelurile vin in continuare
  Action := caHide;
  SavePosition;
end;

procedure TfrmSipPhoneWindow.LoadPosition;
var
  R, Work: TRect;
  W, H: Integer;
begin
  Work := Screen.WorkAreaRect;
  W := AppUserConfigStorage.IntValues.GetValue(cKeyWidth, cDefaultWidth);
  H := AppUserConfigStorage.IntValues.GetValue(cKeyHeight, cDefaultHeight);
  R := Rect(0, 0, W, H);
  R.Offset(AppUserConfigStorage.IntValues.GetValue(cKeyLeft, Work.Right - W - 16),
    AppUserConfigStorage.IntValues.GetValue(cKeyTop, Work.Top + 80));
  // pozitie salvata pe un monitor care nu mai exista -> coltul din dreapta al ecranului principal
  if (W < Constraints.MinWidth) or (H < Constraints.MinHeight) or (Screen.MonitorFromRect(R, mdNull) = nil) then
  begin
    W := cDefaultWidth;
    H := cDefaultHeight;
    R := Rect(Work.Right - W - 16, Work.Top + 80, Work.Right - 16, Work.Top + 80 + H);
  end;
  SetBounds(R.Left, R.Top, R.Width, R.Height);
end;

procedure TfrmSipPhoneWindow.SavePosition;
begin
  AppUserConfigStorage.IntValues.SetValue(cKeyLeft, Left);
  AppUserConfigStorage.IntValues.SetValue(cKeyTop, Top);
  AppUserConfigStorage.IntValues.SetValue(cKeyWidth, Width);
  AppUserConfigStorage.IntValues.SetValue(cKeyHeight, Height);
  AppUserConfigStorage.BooleanValues.SetValue(cKeyVisible, Visible);
end;

procedure TfrmSipPhoneWindow.RestoreVisibility;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cKeyVisible, True) then
    Show;
end;

procedure TfrmSipPhoneWindow.ShowPhone;
begin
  if not Visible then
    Show;
end;

procedure TfrmSipPhoneWindow.TogglePhone;
begin
  if Visible then
    Hide
  else
    Show;
  AppUserConfigStorage.BooleanValues.SetValue(cKeyVisible, Visible);
end;

procedure TfrmSipPhoneWindow.WMEnable(var Message: TWMEnable);
begin
  inherited;
  // un dialog modal (ShowModal) dezactiveaza toate ferestrele aplicatiei; telefonul trebuie sa
  // ramana utilizabil (acelasi truc ca TframeSipClient.WMEnable)
  if not Message.Enabled then
    PostMessage(Handle, WM_SIPWND_REENABLE, 0, 0);
end;

procedure TfrmSipPhoneWindow.WMSipReenable(var Message: TMessage);
begin
  EnableWindow(Handle, True);
end;

type
  PFindWorkWindowData = ^TFindWorkWindowData;
  TFindWorkWindowData = record
    Exclude: HWND;
    Found: HWND;
  end;

// prima fereastra a aplicatiei in Z-order care poate primi lucrul: vizibila, activa, nu "mereu deasupra"
// (telefonul, chatul) - in timpul unui dialog modal asta e dialogul, altfel MainForm sau o forma nemodala
function FindWorkWindowProc(Wnd: HWND; Param: LPARAM): BOOL; stdcall;
var
  Data: PFindWorkWindowData;
begin
  Result := True;
  Data := PFindWorkWindowData(Param);
  if (Wnd <> Data^.Exclude) and (Wnd <> Application.Handle) and IsWindowVisible(Wnd) and IsWindowEnabled(Wnd) and
    not IsIconic(Wnd) and (GetWindowLong(Wnd, GWL_EXSTYLE) and WS_EX_TOPMOST = 0) then
  begin
    Data^.Found := Wnd;
    Result := False;
  end;
end;

procedure TfrmSipPhoneWindow.WMActivate(var Message: TWMActivate);
var
  FromOutside, MouseDown: Boolean;
begin
  inherited;
  // WA_CLICKACTIVE = click pe telefon: ramane activ. WA_ACTIVE venit din alta aplicatie (taskbar, Alt+Tab)
  // sau in timpul unui click pe alta fereastra (MainForm dezactivata de un dialog modal) -> nu e cerut
  if Message.Active <> WA_ACTIVE then
    Exit;
  FromOutside := (Message.ActiveWindow = 0) or
    (GetWindowThreadProcessId(Message.ActiveWindow, nil) <> GetCurrentThreadId);
  MouseDown := (GetAsyncKeyState(VK_LBUTTON) < 0) or (GetAsyncKeyState(VK_RBUTTON) < 0);
  // ascuns nu are ce face cu focusul
  if FromOutside or MouseDown or not Visible then
    PostMessage(Handle, WM_SIPWND_PASSACTIVATION, 0, 0);
end;

procedure TfrmSipPhoneWindow.WMSipPassActivation(var Message: TMessage);
var
  Data: TFindWorkWindowData;
begin
  if GetActiveWindow <> Handle then
    Exit;
  Data.Exclude := Handle;
  Data.Found := 0;
  EnumThreadWindows(GetCurrentThreadId, @FindWorkWindowProc, LPARAM(@Data));
  if Data.Found <> 0 then
    SetForegroundWindow(Data.Found);
end;

end.

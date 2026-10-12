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
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.Types, Vcl.Controls, Vcl.Forms;

const
  WM_SIPWND_REENABLE = WM_USER + 4243;

type
  TfrmSipPhoneWindow = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMSipReenable(var Message: TMessage); message WM_SIPWND_REENABLE;
  public
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

end.

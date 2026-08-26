unit frmSipClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Menus,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, sipclient, ringtone,
  sipints, Data.DB, MemDS, DBAccess, IBC, RzCmboBx, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxBarBuiltInMenu, cxPC, Vcl.Mask, Vcl.DBCtrls,
  cxImageComboBox, cxImageList;

 const
  WM_REENABLE = WM_USER + $100;

type
  TSipInfo = record
    CallerID: string;
    ServerIP: string;
    Password: string;
    STUN: string;
    Proxy: string;
  end;

  THistoryCallInfo = record
    CallType: integer; { 0 = income, 1 = outgoing }
    PhoneNumber: string;
    UserID: integer;
  end;

  TSipAudioInfo = record
    waveInDevice: string;
    waveOutDevice:  string;
    waveRingDevice: string;
  end;

  TframeSipClient = class(TFrame)
    LineMemo: TMemo;
    ImageList1: TImageList;
    ActionList1: TActionList;
    CallAction: TAction;
    HangUpAction: TAction;
    HoldAction: TAction;
    TransferAction: TAction;
    RegisterAction: TAction;
    RemoveAction: TAction;
    EditAction: TAction;
    AddAction: TAction;
    ConferenceAction: TAction;
    RecordAction: TAction;
    Timer1: TTimer;
    StatusImages: TImageList;
    StatusPopupMenu: TPopupMenu;
    OnlineMenu: TMenuItem;
    OfflineMenu: TMenuItem;
    CallBtn: TSpeedButton;
    HangUpBtn: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SBtn1: TSpeedButton;
    SBtn2: TSpeedButton;
    SBtn3: TSpeedButton;
    SBtn6: TSpeedButton;
    SBtn5: TSpeedButton;
    SBtn4: TSpeedButton;
    TransferBtn: TBitBtn;
    TransferEdit: TEdit;
    HoldBtn: TBitBtn;
    ConferenceBtn: TBitBtn;
    RecordBtn: TBitBtn;
    StatusBar1: TStatusBar;
    PhoneEdit: TRzMRUComboBox;
    cxImageList1: TcxImageList;
    SipClient: TSipClient;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SipClientRegistrationOk(Sender: TObject; const AAccount: ISipAccount);
    procedure SipClientRegistrationBye(Sender: TObject; const AAccount: ISipAccount);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure StatusBar1Click(Sender: TObject);
    procedure OnlineMenuClick(Sender: TObject);
    procedure OfflineMenuClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CallActionUpdate(Sender: TObject);
    procedure CallActionExecute(Sender: TObject);
    procedure HangUpActionExecute(Sender: TObject);
    procedure HangUpActionUpdate(Sender: TObject);
    procedure HoldActionExecute(Sender: TObject);
    procedure HoldActionUpdate(Sender: TObject);
    procedure TransferActionExecute(Sender: TObject);
    procedure TransferActionUpdate(Sender: TObject);
    procedure RegisterActionExecute(Sender: TObject);
    procedure RegisterActionUpdate(Sender: TObject);
    procedure SBtn1Click(Sender: TObject);
    procedure SipClientBye(Sender: TObject; const ACall: ISipCall);
    procedure SipClientInvite(Sender: TObject; const ACall: ISipCall);
    procedure SipClientInviteOk(Sender: TObject; const ACall: ISipCall);
    procedure SipClientDtmf(Sender: TObject; const ACall: ISipCall; const Dtmf: string);
    procedure Timer1Timer(Sender: TObject);
    procedure ConferenceActionExecute(Sender: TObject);
    procedure ConferenceActionUpdate(Sender: TObject);
    procedure RecordActionExecute(Sender: TObject);
    procedure RecordActionUpdate(Sender: TObject);
  private
    { Private declarations }
    FConnected: Boolean;
    FRingThread: TRingThread;
    FLineIndex: Integer;
    FButtons: array[1..6] of TSpeedButton;
    FLines: array[1..6] of ISipCall;
    FDtmf: array[1..6] of String;
    FLineImages: array[1..6] of Boolean;
    FConference: ISipConference;
    FRecorder: ISipRecorder;
    procedure SetConnected(const Value: boolean);

  protected
    { Protected declarations }
    procedure LoadSipAccountInfo;
    procedure LoadSipAudioInfo;
    procedure RefreshLines;
    procedure ShowMemo;
    procedure AddToHistory(const HistoryCallInfo: THistoryCallInfo);


  public
    { Public declarations }
    Account: ISipAccount;
    SipInfo: TSipInfo;
    SipAudioInfo : TSipAudioInfo;
    HistoryCallInfo: THistoryCallInfo;
    constructor Create(AOwner: TComponent); override;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMReenable(var Message: TMessage); message WM_REENABLE;

    procedure CallTo(const PhoneNumber: string);
    property Connected: boolean read fConnected write SetConnected;
  end;


implementation

uses
  DataModuleDB, SWNValueStorageUnit;


{$R *.dfm}

procedure TframeSipClient.RecordActionExecute(Sender: TObject);
var
  Dlg: TSaveDialog;
begin
  if not Assigned(FRecorder) then
  begin
    FRecorder := SipClient.CreateRecorder;
    if Assigned(FLines[FLineIndex]) then
      FLines[FLineIndex].SetRecorder(FRecorder);
  end
  else
  begin
    Dlg := TSaveDialog.Create(nil);
    try
      if Dlg.Execute then
        FRecorder.SaveToFile(Dlg.FileName);
    finally
      Dlg.Free;
    end;
    FRecorder := nil;
  end;
end;

procedure TframeSipClient.RefreshLines;
var
  i: Integer;

  procedure SetGlyph(Index: Integer);
  var
    B: TBitmap;
  begin
    B := TBitmap.Create;
    try
      StatusImages.GetBitmap(2+Integer(FLineImages[Index]), B);
      B.PixelFormat := pf24bit;
      FButtons[Index].Glyph.Assign(B);
      FButtons[Index].Glyph.TransparentColor := clWhite;
      FButtons[Index].Glyph.Transparent := True;
    finally
      B.Free;
    end;
  end;

begin
  for i := 1 to 6 do
  begin

    if Assigned(FLines[i]) then
    begin
      if FLines[i].EnableAudioOut <> (FLineIndex = i) then
        FLines[i].EnableAudioOut := FLineIndex = i;
      if FLines[i].EnableAudioIn <> (FLineIndex = i) then
        FLines[i].EnableAudioIn := FLineIndex = i;
    end;

    if (FLineIndex = i) and Assigned(FLines[i]) and (FLines[i].State = csActive) then
    begin
      if not FLineImages[i] then
      begin
        FLineImages[i] := True;
        SetGlyph(i);
      end;
    end
    else
    begin
      if Assigned(FLines[i]) and (FLines[i].State <> csInactive) then
      begin
        FLineImages[i] := not FLineImages[i];
        SetGlyph(i);
      end
      else
      begin
        if FLineImages[i] then
        begin
          FLineImages[i] := False;
          SetGlyph(i);
        end;
      end;
    end;
  end;
  ShowMemo;
end;

 procedure TframeSipClient.ShowMemo;
 var
   text: String;
 begin
   text := 'Line '+IntToStr(FLineIndex);
   if Assigned(FLines[FLineIndex]) then
   begin
     if FLines[FLineIndex].CallType = ctIncoming then
       text := text + ' Incoming'+#13#10
     else
       text := text + ' Outgoing'+#13#10;
     text := text + FLines[FLineIndex].RemoteUser;
//     HistoryListBox.Items.Add(FLines[FLineIndex].RemoteUser);
     if FDtmf[FLineIndex] <> '' then
       text := text + #13#10 + 'DTMF detected: '+FDtmf[FLineIndex];
   end;
   LineMemo.Text := text;
 end;

procedure TframeSipClient.AddToHistory(const HistoryCallInfo: THistoryCallInfo);
begin
//  HistoryListBox.Items.Add(HistoryCallInfo.PhoneNumber);
end;

procedure TframeSipClient.CallActionExecute(Sender: TObject);
begin
  FreeAndNil(FRingThread);
  if Assigned(Account) then
  if not Assigned(FLines[FLineIndex]) then
  begin
    FLines[FLineIndex] := SipClient.AddCall(Account, PhoneEdit.Text,
      AudioInDeviceNameToDeviceID(SipAudioInfo.waveInDevice),
      AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice));

    HistoryCallInfo.CallType := 1;
    HistoryCAllInfo.PhoneNumber := PhoneEdit.Text;
    HistoryCAllInfo.UserID := dmdb.CurrentUserID;
    AddToHistory(HistoryCallInfo);

  end
  else
  if FLines[FLineIndex].State = csRinging then
  begin
    FLines[FLineIndex].AudioInDeviceID :=  AudioInDeviceNameToDeviceID(SipAudioInfo.waveInDevice);
    FLines[FLineIndex].AudioOutDeviceID := AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice);
    SipClient.AnswerCall(FLines[FLineIndex]);
  end;
end;

procedure TframeSipClient.CallActionUpdate(Sender: TObject);
begin
  CallAction.Enabled :=
    FConnected and (not Assigned(FLines[FLineIndex]) or (Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State = csRinging)
    and (FLines[FLineIndex].CallType = ctIncoming)));
  CallBtn.Enabled := CallAction.Enabled;
//  if callAction.Enabled then
//  begin
//    frmSipClient.Show;
//  end;
end;

procedure TframeSipClient.CallTo(const PhoneNumber: string);
begin
  PhoneEdit.Text := PhoneNumber;
  CallActionExecute(Self);
end;

procedure TframeSipClient.ConferenceActionExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FConference) then
    FConference := nil
  else
    FConference := SipClient.CreateConference;

  for i := 1 to 6 do
  begin
    if Assigned(FLines[i]) and (FLines[i].State = csActive) then
      FLines[i].SetConference(FConference);
  end;
end;

procedure TframeSipClient.ConferenceActionUpdate(Sender: TObject);
var
  cnt, i: Integer;
begin
  if not Assigned(FConference) then
  begin
    cnt := 0;
    for i := 1 to 6 do
    begin
      if Assigned(FLines[i]) and (FLines[i].State = csActive) then
      begin
        Inc(cnt);
        if cnt > 1 then break;
      end;
    end;
    ConferenceAction.Enabled := cnt > 1;
    ConferenceAction.Caption := 'Conference';
  end
  else
  begin
    ConferenceAction.Caption := 'Stop Conf.';
    ConferenceAction.Enabled := True;
  end;
end;

constructor TframeSipClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  LoadSipAccountInfo;
  LoadSipAudioInfo;
  FRingThread := nil;

  FLineIndex := 1;

    FButtons[1] := SBtn1;
    FButtons[2] := SBtn2;
    FButtons[3] := SBtn3;
    FButtons[4] := SBtn4;
    FButtons[5] := SBtn5;
    FButtons[6] := SBtn6;

    RefreshLines;

    FRingThread := nil;
end;

procedure TframeSipClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TframeSipClient.HangUpActionExecute(Sender: TObject);
begin
  FreeAndNil(FRingThread);
  if Assigned(FLines[FLineIndex]) then
  begin
    if ((FLines[FLineIndex].State <> csRinging) or (FLines[FLineIndex].CallType = ctOutgoing)) then
    begin
      HangUpBtn.Enabled := False;
      SipClient.EndCall(FLines[FLineIndex]);
    end
    else
    if (FLines[FLineIndex].State = csRinging) and (FLines[FLineIndex].CallType = ctIncoming) then
    begin
      HangUpBtn.Enabled := False;
      SipClient.SendBusy(FLines[FLineIndex]);
    end;
  end;
end;

procedure TframeSipClient.HangUpActionUpdate(Sender: TObject);
begin
  HangUpAction.Enabled := Assigned(FLines[FLineIndex]) and
    (FLines[FLineIndex].State in [csActive, csRinging, csHold, csConnecting, csAutConnecting]);
  HangUpBtn.Enabled := HangUpAction.Enabled;
end;

procedure TframeSipClient.HoldActionExecute(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) then
  begin
    if FLines[FLineIndex].State = csActive then
      SipClient.HoldCall(FLines[FLineIndex])
    else if FLines[FLineIndex].State = csHold then
      SipClient.UnHoldCall(FLines[FLineIndex]);
  end;
end;

procedure TframeSipClient.HoldActionUpdate(Sender: TObject);
begin
  HoldAction.Enabled := Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State in [csActive, csHold]);
  if Assigned(FLines[FLineIndex]) then
  begin
    if FLines[FLineIndex].State = csActive then
      HoldAction.Caption := 'Hold'
    else
    if FLines[FLineIndex].State = csHold then
      HoldAction.Caption := 'Unhold';
  end;
end;

procedure TframeSipClient.LoadSipAccountInfo;
var
  Query: TIBCQuery;
begin
  // select * from ts_users
  Query := TIBCQuery.Create(Self);
  try
  Query.SQL.Text := 'SELECT * FROM TS_USERS WHERE USERID=:USERID';
  Query.ParamByName('USERID').AsInteger := dmdb.CurrentUserID;
  Query.Open;
  with SipInfo do
  begin
    CallerID := Query.FieldByName('SIP_USERID').AsString;
    Password := Query.FieldByName('SIP_USER_PSWD').AsString;
    ServerIP := Query.FieldByName('SIP_SRV_ADRESS').AsString;
    STUN := Query.FieldByName('SIP_STUN').AsString;
    Proxy := Query.FieldByName('SIP_PROXY').AsString;
  end;
  finally
    Query.Free;
  end;

  if not SipClient.Active then
    SipClient.Active := True;

  Account := SipClient.AddAccount(sipInfo.ServerIP, sipInfo.CallerID, sipInfo.Password, sipInfo.STUN);
  Account.Expires := 3000;
  SipClient.RegisterAccount(Account);
end;

procedure TframeSipClient.LoadSipAudioInfo;
begin
  // load from ini file
  SipAudioInfo.waveInDevice := AppUserConfigStorage.TextValues.GetValue('WaveInDevice', '');
  SipAudioInfo.waveOutDevice := AppUserConfigStorage.TextValues.GetValue('WaveOutDevice', '');
  SipAudioInfo.waveRingDevice := AppUserConfigStorage.TextValues.GetValue('WaveRingDevice', '');
end;

procedure TframeSipClient.OfflineMenuClick(Sender: TObject);
begin
  if SipClient.Active then
  begin
    if Assigned(Account) then
    begin
      SipClient.UnRegisterAccount(Account);
      StatusBar1.Repaint;
      OfflineMenu.Checked := True;
    end;
  end;
end;

procedure TframeSipClient.OnlineMenuClick(Sender: TObject);
begin
  if not SipClient.Active then
    SipClient.Active := True;
  Account := SipClient.AddAccount(sipInfo.ServerIP, sipInfo.CallerID, sipInfo.Password, sipInfo.STUN);
  Account.Expires := 3000;
  SipClient.RegisterAccount(Account);
  StatusBar1.Repaint;
end;

procedure TframeSipClient.RegisterActionExecute(Sender: TObject);
begin
  if Assigned(Account) then
  begin
    FConnected := False;
    SipClient.UnRegisterAccount(Account);
  end;
  OnlineMenuClick(Self);
end;

procedure TframeSipClient.RegisterActionUpdate(Sender: TObject);
begin
  RegisterAction.Enabled := True
  and ((Assigned(Account)) or
  (not Assigned(Account)));
end;

procedure TframeSipClient.SBtn1Click(Sender: TObject);
begin
  FLineIndex := (Sender as TSpeedButton).Tag;
  RefreshLines;
end;

procedure TframeSipClient.SetConnected(const Value: boolean);
begin
  fConnected := Value;
end;

procedure TframeSipClient.SipClientBye(Sender: TObject; const ACall: ISipCall);
var
  i: Integer;
begin
  FreeAndNil(FRingThread);
  for i := 1 to 6 do
  if FLines[i] = ACall then
  begin
    FLines[i] := nil;
    FDtmf[i] := '';
  end;
  RefreshLines;
end;


procedure TframeSipClient.SipClientDtmf(Sender: TObject; const ACall: ISipCall; const Dtmf: string);
var
  i: Integer;
begin
  for i := 1 to 6 do
  begin
    if (FLines[i] = ACall) and (ACall.State = csActive) then
    begin
      FDtmf[i] := FDtmf[i] + Dtmf;
      ShowMemo;
    end;
  end;
end;


procedure TframeSipClient.SipClientInvite(Sender: TObject; const ACall: ISipCall);
var
  i, FreeLine: Integer;
begin
  FreeLine := 0;
  for i := 1 to 6 do
    if not Assigned(FLines[i]) then
    begin
      FreeLine := i;
      break;
    end;
  if FreeLine = 0 then
  begin
    SipClient.SendBusy(ACall);
  end
  else
  begin
    FLines[FreeLine] := ACall;
    FreeAndNil(FRingThread);
    FRingThread := TRingThread.Create(13, AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice));

    // complete call record for history
    HistoryCallInfo.CallType := 0;
    HistoryCallInfo.PhoneNumber := aCall.RemoteUser;
    HistoryCallInfo.UserID := dmdb.CurrentUserID;
    AddToHistory(HistoryCallInfo);
  end;
end;


procedure TframeSipClient.SipClientInviteOk(Sender: TObject; const ACall: ISipCall);
begin
  FreeAndNil(FRingThread);
end;

procedure TframeSipClient.SipClientRegistrationBye(Sender: TObject; const AAccount: ISipAccount);
begin
  FConnected := False;
end;

procedure TframeSipClient.SipClientRegistrationOk(Sender: TObject; const AAccount: ISipAccount);
begin
  fConnected := True;

end;

procedure TframeSipClient.SpeedButton1Click(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State = csActive) then
  begin
    case TSpeedButton(Sender).Tag of
     0: SipClient.SendDtmf(FLines[FLineIndex], '0');
     1: SipClient.SendDtmf(FLines[FLineIndex], '1');
     2: SipClient.SendDtmf(FLines[FLineIndex], '2');
     3: SipClient.SendDtmf(FLines[FLineIndex], '3');
     4: SipClient.SendDtmf(FLines[FLineIndex], '4');
     5: SipClient.SendDtmf(FLines[FLineIndex], '5');
     6: SipClient.SendDtmf(FLines[FLineIndex], '6');
     7: SipClient.SendDtmf(FLines[FLineIndex], '7');
     8: SipClient.SendDtmf(FLines[FLineIndex], '8');
     9: SipClient.SendDtmf(FLines[FLineIndex], '9');
    10: SipClient.SendDtmf(FLines[FLineIndex], '*');
    11: SipClient.SendDtmf(FLines[FLineIndex], '#');
    end;
  end
  else
    if TSpeedButton(Sender).Tag in [0,1,2,3,4,5,6,7,8,9] then
      PhoneEdit.Text := PhoneEdit.Text + IntToStr(TSpeedButton(Sender).Tag)
    else
    if TSpeedButton(Sender).Tag = 10 then
      PhoneEdit.Text := PhoneEdit.Text + '*'
    else
    if TSpeedButton(Sender).Tag = 11 then
      PhoneEdit.Text := PhoneEdit.Text + '#';
end;

procedure TframeSipClient.StatusBar1Click(Sender: TObject);
begin
  StatusPopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TframeSipClient.StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  case Panel.Index of
  0:
  begin
    StatusImages.Draw(StatusBar1.Canvas,Rect.Left,Rect.Top, 0, FConnected);
    StatusBar1.Canvas.Font.Color := clBlack;
    StatusBar1.Canvas.Brush.Style := bsClear;
    if not FConnected then
      StatusBar1.Canvas.TextOut(20, 3, 'Offline')
    else
    if Assigned(Account) then
      StatusBar1.Canvas.TextOut(20, 3, 'sip:'+Account.User+'@' + Account.Server);
  end
  end;
end;

procedure TframeSipClient.Timer1Timer(Sender: TObject);
begin
  RefreshLines;
end;

procedure TframeSipClient.TransferActionExecute(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) then
  begin
    if TransferEdit.Text <> '' then
    begin
      if Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State = csActive) then
        SipClient.TransferCall(FLines[FLineIndex], TransferEdit.Text);
    end
    else
    begin
      MessageBox(Handle, 'Please enter the phone number you want to transfer the call to.', 'Call Transfer',MB_OK + MB_ICONSTOP);
      TransferEdit.SetFocus;
    end;
  end;
end;

procedure TframeSipClient.TransferActionUpdate(Sender: TObject);
begin
  TransferAction.Enabled := Assigned(FLines[FLineIndex])
  and (FLines[FLineIndex].State in [csActive]);
end;

procedure TframeSipClient.WMEnable(var Message: TWMEnable);
begin
  if not Message.Enabled then
  begin
    PostMessage(Self.Handle, WM_REENABLE, 1, 0);
  end;
end;

procedure TframeSipClient.WMReenable(var Message: TMessage);
begin
  EnableWindow(Self.Handle, True);
end;

procedure TframeSipClient.RecordActionUpdate(Sender: TObject);
begin
  RecordAction.Enabled := (Assigned(FLines[FLineIndex]) and
    (FLines[FLineIndex].State in [csActive, csRinging, csHold, csConnecting]))
    or Assigned(FRecorder);

  RecordBtn.Enabled := RecordAction.Enabled;
  if not Assigned(FRecorder) then
  begin
    if RecordBtn.Caption <> 'Record' then
      RecordBtn.Caption := 'Record'
  end
  else
  begin
    if RecordBtn.Caption <> 'Save Audio File' then
      RecordBtn.Caption := 'Save Audio File';
  end;
end;

end.

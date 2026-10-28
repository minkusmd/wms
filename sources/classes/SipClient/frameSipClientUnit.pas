unit frameSipClientUnit;

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
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Menus,
  Vcl.ExtCtrls,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  sipclient,
  ringtone,
  sipints,
  Data.DB,
  MemDS,
  DBAccess,
  IBC,
  RzCmboBx,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxBarBuiltInMenu,
  cxPC,
  Vcl.Mask,
  Vcl.DBCtrls,
  cxImageComboBox,
  cxContainer,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLabel,
  cxImage,
  cxCheckBox,
  cxMemo,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxButtons,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxImageList,
  cxButtonEdit,
  Vcl.Clipbrd,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCalendar,
  Vcl.MPlayer,
  ACS_Classes,
  ACS_LAME,
  ACS_Wave,
  dxUIAClasses,
  uPhoneSearchThread,
  System.Character,
  System.RegularExpressions;

const
  WM_REENABLE = WM_USER + $101;

  { CALL_STATEID in TS_PHONE_CALLS_HISTORY (vezi DB Model\phone_calls_state.sql).
    Starea 3 (preluat de coleg) o pune procedura SP_PHONE_CALL_SET_STATE prin
    corelarea cu apelul preluat de alt operator din grup. }
  cCallState_InProgress = 0;
  cCallState_Answered = 1;
  cCallState_Missed = 2;
  cCallState_AnsweredElsewhere = 3;
  cCallState_Rejected = 4;

  { lista de apeluri pentru o baza fara coloanele de stare (DDL-ul
    phone_calls_state.sql inca nerulat) - altfel aplicatia n-ar porni }
  cCallHistorySqlLegacy = 'select ch.nickname, ch.customerid, ch.docid, ch.phonenumber, ch.calltypeid, ' +
    '       ch.data, ch.userid, ch.callid, ' +
    '       iif(exists (select callid from ts_phone_calls_register zz where zz.callid = ch.callid), 1, 0) FLG_HAS_WAV ' +
    'from TS_PHONE_CALLS_HISTORY ch ' + 'where ch.data >= (current_date - 1) ' + 'order by ch.data desc';

type
  TSipInfo = record
    CallerID: string;
    ServerIP: string;
    Password: string;
    STUN: string;
    Proxy: string;
  end;

  THistoryCallInfo = record
    CallType: Integer; { 0 = income, 1 = outgoing }
    PhoneNumber: string;
    UserID: Integer;
    DocID: Integer;
    CustomerID: Integer;
    NickName: string
  end;

  TSipAudioInfo = record
    waveInDevice: string;
    waveOutDevice: string;
    waveRingDevice: string;
  end;

//  TPhoneSearchThread = class(TThread)
//  private
//    PhoneNumber: string;
//    IBCConnection: TIBCConnection;
//    IBCTransaction: TIBCTransaction;
//    procedure FormatPhoneNumber(var PhoneNumber: string);
//    procedure AddNewCustomer(PhoneNumber: string);
//  public
//    CustomerName: string;
//    CustomerID: integer;
//    constructor Create(ACreateSuspended: boolean; APhoneNumber: string); overload;
//    procedure Execute; override;
//    procedure UpdateCallerInfo;
//
//  end;

  TframeSipClient = class(TFrame)
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
    IBCDataSourceCallHistory: TIBCDataSource;
    IBCCallHistory: TIBCQuery;
    Timer2: TTimer;
    GridImageList: TImageList;
    cxImageList1: TcxImageList;
    IBCQueryCallsWav: TIBCQuery;
    PopupMenu1: TPopupMenu;
    pmPlayWav: TMenuItem;
    Salveazaconvorbirea1: TMenuItem;
    IBCTrSipSelect: TIBCTransaction;
    sipclient: TSipClient;
    IBCQueryActiveUsers: TIBCQuery;
    IBCDataSourceActiveUsers: TIBCDataSource;
    N1: TMenuItem;
    IstoriaSMS1: TMenuItem;
    IBCDataSourceCallerHistory: TIBCDataSource;
    IBCQueryCallerHistory: TIBCQuery;
    IBCTrSms: TIBCTransaction;
    Panel1: TPanel;
    Panel2: TPanel;
    SBtn1: TSpeedButton;
    SBtn2: TSpeedButton;
    LineMemo: TMemo;
    PhoneEdit: TcxTextEdit;
    CallBtn: TcxButton;
    HangUpBtn: TcxButton;
    lbDuration: TcxLabel;
    HoldBtn: TcxButton;
    TransferBtn: TcxButton;
    TransferEdit: TcxLookupComboBox;
    cxButton1: TcxButton;
    IBCTrSipUpdate: TIBCTransaction;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    tsDial: TcxTabSheet;
    btnDtmf1: TcxButton;
    btnDtmf2: TcxButton;
    btnDtmf3: TcxButton;
    btnDtmf4: TcxButton;
    btnDtmf5: TcxButton;
    btnDtmf6: TcxButton;
    btnDtmf7: TcxButton;
    btnDtmf8: TcxButton;
    btnDtmf9: TcxButton;
    btnDtmfStar: TcxButton;
    btnDtmf0: TcxButton;
    btnDtmfHash: TcxButton;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1_CALLTYPEID: TcxGridDBColumn;
    cxGrid1DBTableView1_DATA: TcxGridDBColumn;
    cxGrid1DBTableView1_PHONENUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1_NICKNAME: TcxGridDBColumn;
    cxGrid1DBTableView1_CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1_USERNAME: TcxGridDBColumn;
    cxGrid1DBTableView1_DOCID: TcxGridDBColumn;
    cxGrid1DBTableView1_CALLID: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_HAS_WAV: TcxGridDBColumn;
    cxGrid1DBTableView1_CALL_STATE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_ANSWERED_BY: TcxGridDBColumn;
    cxGrid1DBTableView1_CALL_STATEID: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    procedure SipClientRegistrationOk(Sender: TObject; const AAccount: ISipAccount);
    procedure SipClientRegistrationBye(Sender: TObject; const AAccount: ISipAccount);
    procedure OnlineMenuClick(Sender: TObject);
    procedure OfflineMenuClick(Sender: TObject);
    procedure CallActionUpdate(Sender: TObject);
    procedure CallActionExecute(Sender: TObject);
    procedure HangUpActionExecute(Sender: TObject);
    procedure HangUpActionUpdate(Sender: TObject);
    procedure HoldActionExecute(Sender: TObject);
    procedure HoldActionUpdate(Sender: TObject);
    procedure TransferActionUpdate(Sender: TObject);
    procedure RegisterActionExecute(Sender: TObject);
    procedure RegisterActionUpdate(Sender: TObject);
    procedure SBtn1Click(Sender: TObject);
    procedure SipClientBye(Sender: TObject; const ACall: ISipCall);
    procedure SipClientInvite(Sender: TObject; const ACall: ISipCall);
    procedure SipClientInviteOk(Sender: TObject; const ACall: ISipCall);
    procedure SipClientDtmf(Sender: TObject; const ACall: ISipCall; const dtmf: string);
    procedure Timer1Timer(Sender: TObject);
    procedure ConferenceActionExecute(Sender: TObject);
    procedure ConferenceActionUpdate(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure RecordActionExecute(Sender: TObject);
    procedure RecordActionUpdate(Sender: TObject);
    procedure PhoneEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure IBCCallHistoryBeforePost(DataSet: TDataSet);
    procedure pmPlayWavClick(Sender: TObject);
    procedure Salveazaconvorbirea1Click(Sender: TObject);
    procedure TransferEditPropertiesInitPopup(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure IstoriaSMS1Click(Sender: TObject);
    procedure PhoneEditDblClick(Sender: TObject);
    procedure TransferBtnClick(Sender: TObject);
    procedure cxGrid1DBTableView1_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
  private    { Private declarations }
    FConnected: Boolean;
    FRingThread: TRingThread;
    FLineIndex: Integer;
    FButtons: array[1..6] of TSpeedButton;
    FLines: array[1..6] of ISipCall;
    FDtmf: array[1..6] of string;
    FLineImages: array[1..6] of Boolean;
    FConference: ISipConference;
    FRecorder: ISipRecorder;
    FStartCall: TDateTime;
    FSipMutex: THandle;
    FAlreadyRunning: Boolean;
    FLineCallID: array[1..6] of Integer;    { CALLID din TS_PHONE_CALLS_HISTORY, per linie }
    FLineAnswered: array[1..6] of Boolean;  { apelul a fost preluat (InviteOk / Raspunde) }
    FLineRejected: array[1..6] of Boolean;  { operatorul a apasat "Ocupat" }

    procedure CloseCallerHistoryData;
    procedure ColorMemo(BackgroundColor, FontColor: Integer);
    procedure SetConnected(const Value: Boolean);
    procedure SetStartCall(const Value: TDateTime);
    function FormatPhoneNumber(const PhoneNumber: string): string;
    procedure ShowCallerHistory(PhoneNumber: string);
    procedure AddNewCustomer(var PhoneNumber: string; var fIdentifiedCustomer: string; var fCustomerID: integer);
    procedure ClearCall;
    procedure RedrawMemo(var Txt: string);
    procedure SaveRecord(const ACall: ISipCall);
    procedure SaveRecordedCall(ms: TMemoryStream; const ACall: ISipCall);
    procedure SelectNextAction;
    function LineIndexOf(const ACall: ISipCall): Integer;
    procedure BeginLineCall(const ALine, ACallID: Integer);
    procedure SetCallState(const ACallID, AStateID: Integer);
  protected    { Protected declarations }
//        PhoneThread: TPhoneSearchThread;
    procedure LoadSipAccountInfo;
    procedure LoadSipAudioInfo;
    procedure RefreshLines;
    procedure ShowMemo;
    procedure AddToHistory(const HistoryCallInfo: THistoryCallInfo);
    procedure SearchCustomerByPhoneNumber(var PhoneNumber: string);
    procedure CopyGridCellTextToClipboard(const Grid: TcxGridTableView);
    procedure TrimPhoneNumber(var PhoneNumber: string);
    property StartCall: TDateTime read FStartCall write SetStartCall;
  public    { Public declarations }
    account: ISipAccount;
    SipInfo: TSipInfo;
    SipAudioInfo: TSipAudioInfo;
    HistoryCallInfo: THistoryCallInfo;
    fCallID: Integer;
    fIdentifiedCustomer: string;
    fCustomerID: Integer;
    // apel primit (MainForm arata fereastra telefonului)
    OnIncomingCall: TNotifyEvent;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WMEnable(var Message: TWMEnable); message WM_ENABLE;
    procedure WMReenable(var Message: TMessage); message WM_REENABLE;
    procedure CallTo(var PhoneNumber: string);
    procedure ShowCustomerCallInfo(PhoneNumber: string);
    property Connected: Boolean read FConnected write SetConnected;
  end;

var
  frameSipClient: TframeSipClient;

implementation

uses
  DataModuleAdditions,
  DataModuleDB,
  DateUtils,
  MMSystem,
  SWNUtils,
  SWNValueStorageUnit,
  acm,
  frmCustomerCallInfoUnit,
  frmGoods,
  frmSMSInfoUnit,
  uSMSHistoryDlg,
  System.IOUtils,
  System.UITypes;


{$R *.dfm}

{ Normalizeaza un numar MD la formatul national 0XXXXXXXX.
  Numerele scurte (<= 5 cifre: interioare, servicii) raman doar cifre;
  intrarea fara cifre da ''. Accepta +373 / 00373 / 373 / 0 / fara prefix. }

function NormalizePhoneMD(const AInput: string): string;
var
  Digits: string;
  I, Count, StartPos: Integer;
begin
  // Prealocăm memoria pentru a evita concatenările repetate.
  SetLength(Digits, Length(AInput));
  Count := 0;

  for I := 1 to Length(AInput) do
    if AInput[I].IsDigit then
    begin
      Inc(Count);
      Digits[Count] := AInput[I];
    end;

  // Numerele scurte rămân intacte.
  if (Count = 4) or (Count = 5) then
    Exit(Copy(Digits, 1, Count));

  StartPos := 1;

  // Ignorăm prefixul internațional fără să mutăm caracterele.
  if Count > 5 then
    if (Digits[1] = '3') and
       (Digits[2] = '7') and
       (Digits[3] = '3') then
    begin
      StartPos := 4;
      Dec(Count, 3);
    end;

  // Numere scurte precedate de prefixul internațional.
  if (Count = 4) or (Count = 5) then
    Exit(Copy(Digits, StartPos, Count));

  // Păstrăm ultimele 8 cifre, inclusiv pentru formatul 0xxxxxxxx.
  if Count > 8 then
  begin
    Inc(StartPos, Count - 8);
    Count := 8;
  end;

  Result := '0' + Copy(Digits, StartPos, Count);
end;

function IsMobileMD(const AInput: string): Boolean;
const
  C_MobileMD_Pattern = '^0(?:6[0-9]|71|7[6-9])\d{6}$';
var
  normalized: string;
begin
  normalized := NormalizePhoneMD(AInput);
  Result := TRegEx.IsMatch(normalized, C_MobileMD_Pattern);
end;

function TryNormalizeAndCheckMobileMD(const AInput: string; out ANational: string): Boolean;
const
  C_MobileMD_Pattern = '^0(?:6[0-9]|71|7[6-9])\d{6}$';
begin
  try
    ANational := NormalizePhoneMD(AInput);
    Result := TRegEx.IsMatch(ANational, C_MobileMD_Pattern);
  except
    on E: Exception do
    begin
      ANational := '';
      Result := False;
    end;
  end;
end;

{ Data apelului in istorie: azi - doar ora (hh:nn:ss), altfel dd.mm.yy hh:nn:ss. }
procedure TframeSipClient.cxGrid1DBTableView1_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
var
  V: Variant;
  D: TDateTime;
begin
  V := ARecord.Values[Sender.Index];
  if VarIsNull(V) or VarIsEmpty(V) then
    Exit;
  D := VarToDateTime(V);
  if IsToday(D) then
    AText := FormatDateTime('hh:nn:ss', D)
  else
    AText := FormatDateTime('dd.mm.yy hh:nn:ss', D);
end;

procedure TframeSipClient.RecordActionExecute(Sender: TObject);
var
  Dlg: TSaveDialog;
begin
  if not Assigned(FRecorder) then
  begin
    FRecorder := sipclient.CreateRecorder;
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
      StatusImages.GetBitmap(2 + Integer(FLineImages[Index]), B);
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

    if (FLineIndex = i) and Assigned(FLines[i]) and (FLines[i].State = sipints.csActive) then
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
  PhoneNumber: string;
  Txt: string;
begin
  Txt := 'Line ' + IntToStr(FLineIndex);
  ColorMemo(clbtnface, clWindowText);
  if Assigned(FLines[FLineIndex]) then
  begin
    RedrawMemo(Txt);
    PhoneNumber := FLines[FLineIndex].RemoteUser;
    FormatPhoneNumber(PhoneNumber);
    Txt := Txt + PhoneNumber;
    if fIdentifiedCustomer <> '' then
      Txt := Txt + '  [' + fIdentifiedCustomer + ']';
  end;
  LineMemo.Text := Txt;
end;

procedure TframeSipClient.AddToHistory(const HistoryCallInfo: THistoryCallInfo);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmdb.IBCConnection;
    q.Transaction := IBCTrSipUpdate;
    q.AutoCommit := False;
    q.Options.ReturnParams := True;

    q.SQL.Text := 'INSERT INTO TS_PHONE_CALLS_HISTORY ' + ' (CALLTYPEID, PHONENUMBER, DOCID, CUSTOMERID, NICKNAME) ' +
      'VALUES ' + ' (:CALLTYPEID, :PHONENUMBER, :DOCID, :CUSTOMERID, :NICKNAME) ' + 'RETURNING CALLID';

    q.ParamByName('CALLTYPEID').AsInteger := HistoryCallInfo.CallType;
    q.ParamByName('PHONENUMBER').AsString := HistoryCallInfo.PhoneNumber;
    q.ParamByName('CUSTOMERID').AsInteger := HistoryCallInfo.CustomerID;
    q.ParamByName('NICKNAME').AsString := Copy(HistoryCallInfo.NickName, 1, 49);

    if HistoryCallInfo.DocID > 0 then
      q.ParamByName('DOCID').AsInteger := HistoryCallInfo.DocID
    else
      q.ParamByName('DOCID').Clear;

    if not q.Transaction.Active then
      q.Transaction.StartTransaction;

    try
      // Folosim ExecSQL în loc de Open pentru DML-uri în IBCDac 10.1+
      q.ExecSQL;

      // Extragem valoarea returnată de Firebird.
      // ExecSQL populează intern Fields pentru clauzele RETURNING.
      fCallID := q.ParamByName('RET_CALLID').AsInteger;

      q.Transaction.Commit;
    except
      if q.Transaction.Active then
        q.Transaction.Rollback;
      raise; // Re-aruncăm excepția către apelant
    end;

    // Mutăm refresh-ul aici: e bine să actualizăm UI-ul doar
    // dacă tranzacția de mai sus s-a terminat cu succes (Commit)
    ibcCallHistory.Refresh;

  finally
    // try...finally garantează că obiectul se eliberează mereu,
    // chiar dacă "raise"-ul din except a fost declanșat
    q.Free;
  end;
end;

procedure TframeSipClient.CallActionExecute(Sender: TObject);
var
  sPhoneNumber: string;
begin
  FreeAndNil(FRingThread);
  sPhoneNumber := PhoneEdit.Text;
  TrimPhoneNumber(sPhoneNumber);
  if Assigned(account) then
  begin
    if not Assigned(FLines[FLineIndex]) then
    begin
      FLines[FLineIndex] := sipclient.AddCall(account, sPhoneNumber, AudioInDeviceNameToDeviceID(SipAudioInfo.waveInDevice),
        AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice));
      sPhoneNumber := Trim(sPhoneNumber);
      SearchCustomerByPhoneNumber(sPhoneNumber);
      HistoryCallInfo.CallType := 1; // outgoing
      PhoneEdit.Properties.LookupItems.Add(sPhoneNumber);
      HistoryCallInfo.PhoneNumber := sPhoneNumber;
      HistoryCallInfo.UserID := dmDB.CurrentUserID;
      HistoryCallInfo.NickName := fIdentifiedCustomer;
      HistoryCallInfo.CustomerID := fCustomerID;
      StartCall := Now;
      lbDuration.Visible := True;

      AddToHistory(HistoryCallInfo);
      BeginLineCall(FLineIndex, fCallID);

      if not Assigned(FRecorder) then
      begin
        FRecorder := sipclient.CreateRecorder;
        if Assigned(FLines[FLineIndex]) then
          FLines[FLineIndex].SetRecorder(FRecorder);
      end;

    end
    else if FLines[FLineIndex].State = csRinging then
    begin
      if not Assigned(FRecorder) then
      begin
        FRecorder := sipclient.CreateRecorder;
        if Assigned(FLines[FLineIndex]) then
          FLines[FLineIndex].SetRecorder(FRecorder);
      end;

      HistoryCallInfo.CallType := 0; // incoming
      FLines[FLineIndex].AudioInDeviceID := AudioInDeviceNameToDeviceID(SipAudioInfo.waveInDevice);
      FLines[FLineIndex].AudioOutDeviceID := AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice);
      sipclient.AnswerCall(FLines[FLineIndex]);
      FLineAnswered[FLineIndex] := True;

    end;
  end;
end;

procedure TframeSipClient.CallActionUpdate(Sender: TObject);
begin
  CallAction.Enabled := FConnected and (not Assigned(FLines[FLineIndex]) or (Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State
    = csRinging) and (FLines[FLineIndex].CallType = ctIncoming)));
  CallBtn.Enabled := CallAction.Enabled;
end;

procedure TframeSipClient.CallTo(var PhoneNumber: string);
begin
  PhoneEdit.Text := PhoneNumber;
  SearchCustomerByPhoneNumber(PhoneNumber);
  Application.ProcessMessages;
  CallActionExecute(Self);
end;

procedure TframeSipClient.ConferenceActionExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(FConference) then
    FConference := nil
  else
    FConference := sipclient.CreateConference;

  for i := 1 to 6 do
  begin
    if Assigned(FLines[i]) and (FLines[i].State = sipints.csActive) then
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
      if Assigned(FLines[i]) and (FLines[i].State = sipints.csActive) then
      begin
        Inc(cnt);
        if cnt > 1 then
          Break;
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
  if IBCCallHistory.Active then
    IBCCallHistory.Close;

//  IBCCallHistory.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
  try
    IBCCallHistory.Open;
  except
    IBCCallHistory.Close;
    IBCCallHistory.SQL.Text := cCallHistorySqlLegacy;
    IBCCallHistory.Open;
  end;

  RefreshLines;

//    pcDialPad.ActivePage := tsCallHistory;
  FRingThread := nil;
end;

procedure TframeSipClient.CloseCallerHistoryData;
begin
  IBCQueryCallerHistory.Close;
end;

procedure TframeSipClient.ColorMemo(BackgroundColor, FontColor: Integer);
begin
  LineMemo.Color := BackgroundColor;
  LineMemo.Font.Color := FontColor;
end;

procedure TframeSipClient.cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  v: Variant;
begin
  // pierdut = rosu; preluat de coleg = gri; respins = maro
  v := AViewInfo.GridRecord.Values[cxGrid1DBTableView1_CALL_STATEID.Index];
  if VarIsNull(v) or VarIsEmpty(v) then
    Exit;
  case Integer(v) of
    cCallState_Missed:
      begin
        ACanvas.Font.Color := clRed;
        ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
      end;
    cCallState_AnsweredElsewhere:
      ACanvas.Font.Color := clGrayText;
    cCallState_Rejected:
      ACanvas.Font.Color := clMaroon;
  end;
end;

procedure TframeSipClient.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
  PhoneEdit.Text := IBCCallHistory.FieldByName('PHONENUMBER').AsString;
//    pcDialPad.ActivePageIndex := 0;
  Application.ProcessMessages;
  CallActionExecute(Sender);
end;

procedure TframeSipClient.CopyGridCellTextToClipboard(const Grid: TcxGridTableView);
var
  RecordIndex: Integer;
  i, j: Integer;
  MS: TStringList;
  S: string;
begin
  if Grid.OptionsSelection.CellMultiSelect then
  begin
    MS := TStringList.Create;
    try
      // multiple cells
      for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
      begin
        S := '';
        for j := 0 to Grid.Controller.SelectedColumnCount - 1 do
        begin
          if S <> '' then
            S := S + #9;
          S := S + Trim(Grid.DataController.GetDisplayText(Grid.Controller.SelectedRecords[i].RecordIndex, Grid.Controller.SelectedColumns
            [j].Index));
        end;
        MS.Add(S);
      end;
      Clipboard.asText := MS.Text;
    finally
      MS.Free;
    end;
  end
  else if Grid.DataController.FocusedRowIndex >= 0 then
  begin
    // single cell
    RecordIndex := Grid.DataController.GetRowInfo(Grid.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := Trim(Grid.DataController.GetDisplayText(RecordIndex, Grid.Controller.FocusedColumn.Index));
  end;
end;

procedure TframeSipClient.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
  begin
      // copy cell content in clipboard
    CopyGridCellTextToClipboard(cxGrid1DBTableView1);
    Key := 0;
    Shift := [];
  end;
end;

destructor TframeSipClient.Destroy;
begin
//    if Assigned(PhoneThread) then
//    begin
//        PhoneThread.Terminate;   // Marchează thread-ul pentru oprire
//        PhoneThread.WaitFor;     // Așteaptă să se termine complet
//        FreeAndNil(PhoneThread); // Eliberează
//    end;
  inherited;
end;

procedure TframeSipClient.SearchCustomerByPhoneNumber(var PhoneNumber: string);
begin
//    PhoneThread.OnResult :=
//      procedure(AName: string; AID: Integer)
//      begin
//        fIdentifiedCustomer := AName;
//        fCustomerID := AID;
//      end;
//    PhoneThread.Start;
//    PhoneThread.WaitFor;       // <- așteaptă ca thread-ul să termine

  PhoneNumber := FormatPhoneNumber(PhoneNumber);
  var Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text := 'SELECT * FROM GET_CUSTOMERS_BY_PHONE(:PHONENUMBER)';
    Query.ParamByName('PHONENUMBER').AsString := PhoneNumber;
    Query.Open;
    if Query.RecordCount > 0 then
    begin
      fIdentifiedCustomer := Query.FieldByName('NAME').AsString;
      fCustomerID := Query.FieldByName('CUSTOMERID').AsInteger;
    end
    else
    begin

      AddNewCustomer(PhoneNumber, fIdentifiedCustomer, fCustomerID);
//      if IBCTrSipUpdate.Active then
//        IBCTrSipUpdate.Commit;
    end;
  finally
    Query.Free;
  end;
end;

procedure TframeSipClient.HangUpActionExecute(Sender: TObject);
begin
  FreeAndNil(FRingThread);
  if Assigned(FLines[FLineIndex]) then
  begin
    if ((FLines[FLineIndex].State <> csRinging) or (FLines[FLineIndex].CallType = ctOutgoing)) then
    begin
      HangUpBtn.Enabled := False;
      sipclient.EndCall(FLines[FLineIndex]);
    end
    else if (FLines[FLineIndex].State = csRinging) and (FLines[FLineIndex].CallType = ctIncoming) then
    begin
      HangUpBtn.Enabled := False;
      FLineRejected[FLineIndex] := True;
      sipclient.SendBusy(FLines[FLineIndex]);
    end;
  end;
  PhoneEdit.Text := '';
  lbDuration.Visible := False;
end;

procedure TframeSipClient.HangUpActionUpdate(Sender: TObject);
begin
  HangUpAction.Enabled := Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State in [sipints.csActive, sipints.csRinging,
    sipints.csHold, sipints.csConnecting, sipints.csAutConnecting]);
  HangUpBtn.Enabled := HangUpAction.Enabled;
end;

procedure TframeSipClient.HoldActionExecute(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) then
  begin
    if FLines[FLineIndex].State = sipints.csActive then
    begin
      sipclient.HoldCall(FLines[FLineIndex]);
      // Hold mark active
//      HoldBtn.Glyph.LoadFromResourceName(hinstance, '');
    end
    else if FLines[FLineIndex].State = sipints.csHold then
      sipclient.UnHoldCall(FLines[FLineIndex]);
  end;
end;

procedure TframeSipClient.HoldActionUpdate(Sender: TObject);
begin
  HoldAction.Enabled := Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].State in [sipints.csActive, sipints.csHold]);
  if Assigned(FLines[FLineIndex]) then
  begin
    if FLines[FLineIndex].State = sipints.csActive then
      HoldAction.Caption := 'Hold'
    else if FLines[FLineIndex].State = sipints.csHold then
      HoldAction.Caption := 'Unhold';
  end;
end;

procedure TframeSipClient.IstoriaSMS1Click(Sender: TObject);
var
  dialog: TfrmSMSHistoryDlg;
begin
    // aici aratam o fereastra cu istoria sms
  dialog := TfrmSMSHistoryDlg.Create(Self);
  try
    dialog.PhoneNumber := IBCCallHistory.FieldByName('PHONENUMBER').AsString;
    dialog.ShowModal;
  finally
    dialog.Free;
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
    Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
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

  OnlineMenuClick(Self);
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
  if sipclient.Active then
  begin
    if Assigned(account) then
    begin
      sipclient.UnRegisterAccount(account);
    end;
  end;
end;

procedure TframeSipClient.OnlineMenuClick(Sender: TObject);
begin
  // Încearcă să creezi mutex-ul GLOBAL (ca să fie vizibil între procese).
  FSipMutex := CreateMutex(nil, False, 'Global\SWNSipClient_Mutex');
  // Dacă deja exista, GetLastError = ERROR_ALREADY_EXISTS
  FAlreadyRunning := (GetLastError = ERROR_ALREADY_EXISTS);
  if not FAlreadyRunning then
  begin

  end;

  if not sipclient.Active then
    sipclient.Active := True;
  account := sipclient.AddAccount(SipInfo.ServerIP, SipInfo.CallerID, SipInfo.Password, SipInfo.STUN);
  account.Expires := 3000;
  sipclient.RegisterAccount(account);
end;

procedure TframeSipClient.PhoneEditDblClick(Sender: TObject);
begin
//    if Assigned(FLines[FLineIndex]) then
//    begin
//        if not IBCTrSipUpdate.Active then
//            IBCTrSipUpdate.StartTransaction;
//
//        dmDB.IBCQueryDocComments.UpdateTransaction := IBCTrSipUpdate;
//
//        dmDB.IBCQueryDocComments.Open;
//        dmDB.IBCQueryDocComments.Edit;
//        dmDB.IBCQueryDocComments.FieldByName('COMMENTS').AsString := dmDB.IBCQueryDocComments.FieldByName('COMMENTS').AsString +
//                        #13#10+ dmDB.CurrentUserFullName + ' - (' + LineMemo.Text;
//
//        try
//            dmDB.IBCQueryDocComments.Post;
//            dmDB.IBCQueryDocComments.Close;
//        except
//            begin
//                dmDB.IBCQueryDocComments.Cancel;
//                dmDB.IBCQueryDocComments.Close;
//                IBCTrSipUpdate.Rollback;
//                raise;
//            end;
//        end;
//    end;

end;

procedure TframeSipClient.PhoneEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    CallActionExecute(Sender);
end;

procedure TframeSipClient.pmPlayWavClick(Sender: TObject);
var
  tmpFilename: string;
begin
  with IBCQueryCallsWav do
  begin
    Close;
    ParamByName('CALLID').AsInteger := IBCCallHistory.FieldByName('CALLID').AsInteger;
    Open;

    tmpFilename := tpath.GetTempFileName;
    tmpFilename := ChangeFileExt(tmpFilename, '.wav');
    TBlobField(FieldByName('WAV')).SaveToFile(tmpFilename);
  end;
end;

procedure TframeSipClient.PopupMenu1Popup(Sender: TObject);
var
  RecordIndex: Integer;
begin
  RecordIndex := cxGrid1DBTableView1.DataController.GetRowInfo(cxGrid1DBTableView1.DataController.FocusedRowIndex).RecordIndex;
  pmPlayWav.Enabled := (cxGrid1DBTableView1.DataController.Values[RecordIndex, cxGrid1DBTableView1_FLG_HAS_WAV.Index] = 1);
end;

procedure TframeSipClient.RegisterActionExecute(Sender: TObject);
begin
  if Assigned(account) then
  begin
    FConnected := False;
    sipclient.UnRegisterAccount(account);
  end;
  OnlineMenuClick(Self);
end;

procedure TframeSipClient.RegisterActionUpdate(Sender: TObject);
begin
  RegisterAction.Enabled := True and ((Assigned(account)) or (not Assigned(account)));
end;

procedure TframeSipClient.Salveazaconvorbirea1Click(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  with IBCQueryCallsWav do
  begin
    Close;
    ParamByName('CALLID').AsInteger := IBCCallHistory.FieldByName('CALLID').AsInteger;
    Open;
    dialog := TSaveDialog.Create(Owner);
    dialog.DefaultExt := 'wav';
    dialog.Options := dialog.Options + [ofPathMustExist];
    dialog.Filter := 'Wav Files|*.wav';
    try
      if dialog.Execute then
        TBlobField(FieldByName('WAV')).SaveToFile(dialog.FileName);
    finally
      dialog.Free;
    end;
  end;
end;

procedure TframeSipClient.SBtn1Click(Sender: TObject);
begin
  FLineIndex := (Sender as TSpeedButton).Tag;
  RefreshLines;
end;

procedure TframeSipClient.SetConnected(const Value: Boolean);
begin
  FConnected := Value;
end;

procedure TframeSipClient.SipClientBye(Sender: TObject; const ACall: ISipCall);
var
  i, callID, state: Integer;
begin
  // starea finala a apelului de pe linia lui: preluat / respins / pierdut.
  // "Pierdut" poate deveni "preluat de coleg" in SP_PHONE_CALL_SET_STATE.
  i := LineIndexOf(ACall);
  callID := 0;
  state := cCallState_Missed;
  if i > 0 then
  begin
    callID := FLineCallID[i];
    if FLineRejected[i] then
      state := cCallState_Rejected
    else if FLineAnswered[i] then
      state := cCallState_Answered;
    fCallID := callID; // SaveRecordedCall scrie WAV-ul pe acest CALLID
  end;

  SaveRecord(ACall);
  CloseCallerHistoryData;
  FreeAndNil(FRingThread);
  SelectNextAction;
  ClearCall;

  // dupa WAV, ca procedura de corelare sa vada inregistrarea
  if callID > 0 then
    SetCallState(callID, state);
end;

procedure TframeSipClient.SipClientDtmf(Sender: TObject; const ACall: ISipCall; const Dtmf: string);
var
  i: Integer;
begin
  for i := 1 to 6 do
  begin
    if (FLines[i] = ACall) and (ACall.State = sipints.csActive) then
    begin
      FDtmf[i] := FDtmf[i] + Dtmf;
      ShowMemo;
    end;
  end;
end;

procedure TframeSipClient.SipClientInvite(Sender: TObject; const ACall: ISipCall);
var
  i, FreeLine: Integer;
  PhoneNumber: string;
begin
  FreeLine := 0;
  for i := 1 to 2 do
    if not Assigned(FLines[i]) then
    begin
      FreeLine := i;
      Break;
    end;
  if FreeLine = 0 then
  begin
    sipclient.SendBusy(ACall);
  end
  else
  begin
    FLines[FreeLine] := ACall;
    FreeAndNil(FRingThread);
    FRingThread := TRingThread.Create(13, AudioOutDeviceNameToDeviceID(SipAudioInfo.waveOutDevice));
    PhoneNumber := NormalizePhoneMD(ACall.RemoteUser);

    SearchCustomerByPhoneNumber(PhoneNumber);

    ShowCallerHistory(PhoneNumber);

    HistoryCallInfo.CallType := 0;
    HistoryCallInfo.PhoneNumber := PhoneNumber;
    HistoryCallInfo.UserID := dmDB.CurrentUserID;
    HistoryCallInfo.NickName := fIdentifiedCustomer;
    HistoryCallInfo.CustomerID := fCustomerID;
    AddToHistory(HistoryCallInfo);
    BeginLineCall(FreeLine, fCallID);
    if Assigned(OnIncomingCall) then
      OnIncomingCall(Self);
  end;
end;

procedure TframeSipClient.SipClientInviteOk(Sender: TObject; const ACall: ISipCall);
var
  i: Integer;
begin
  FreeAndNil(FRingThread);

  i := LineIndexOf(ACall);
  if i > 0 then
    FLineAnswered[i] := True;

  if not Assigned(FRecorder) then
    FRecorder := sipclient.CreateRecorder;

  if Assigned(FLines[FLineIndex]) then
    FLines[FLineIndex].SetRecorder(FRecorder);

  StartCall := Now;
  lbDuration.Visible := True;
end;

procedure TframeSipClient.SipClientRegistrationBye(Sender: TObject; const AAccount: ISipAccount);
begin
  FConnected := False;
end;

procedure TframeSipClient.SipClientRegistrationOk(Sender: TObject; const AAccount: ISipAccount);
begin
  FConnected := True;
end;

procedure TframeSipClient.Timer1Timer(Sender: TObject);
var
  current_time: Extended;
begin
  RefreshLines;

  current_time := (Now - StartCall);
  lbDuration.Caption := TimeToStr(current_time);
end;

procedure TframeSipClient.Timer2Timer(Sender: TObject);
begin
  sipclient.RegisterAccount(account);
end;

procedure TframeSipClient.TransferActionUpdate(Sender: TObject);
begin
  TransferAction.Enabled := Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].state in [sipints.csActive]);
end;

procedure TframeSipClient.TransferEditPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryActiveUsers.Open;
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
  RecordAction.Enabled := (Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].state in [sipints.csActive, sipints.csRinging,
    sipints.csHold, sipints.csConnecting])) or Assigned(FRecorder);
end;

procedure TframeSipClient.SetStartCall(const Value: TDateTime);
begin
  FStartCall := Value;
end;

procedure TframeSipClient.ShowCustomerCallInfo(PhoneNumber: string);
var
  dialog: TfrmCustomerCallInfoDlg;
begin
  if PhoneNumber <> '' then
  begin
    dialog := TfrmCustomerCallInfoDlg.Create(Self, dmDB.IBCConnection);
    try
      dialog.PhoneNumber := PhoneNumber;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TframeSipClient.SaveRecordedCall(ms: TMemoryStream; const ACall: ISipCall);
var
  PhoneNumber: string;
begin
  if Assigned(FRecorder) then
  begin
    FRecorder.SaveToStream(ms);
    with IBCQueryCallsWav do
    begin
      if not Active then
        Open;
      if not UpdateTransaction.Active then
        UpdateTransaction.StartTransaction;
      try
        Insert;
        FieldByName('CALLID').AsInteger := FCallID;
        PhoneNumber := ACall.RemoteUser;
        SearchCustomerByPhoneNumber(PhoneNumber);
        FieldByName('SourceID').AsString := PhoneNumber;
        FieldByName('DURATION').AsString := TimeToStr(Now - StartCall);
        lbDuration.Caption := TimeToStr(Now - StartCall);
        if Assigned(FRecorder) then
          TBlobField(FieldByName('WAV')).LoadFromStream(ms);
        Post;
        if UpdateTransaction.Active then
          UpdateTransaction.Commit;
        IBCCallHistory.Refresh;
      except
        on e: Exception do
        begin
          Cancel;
          UpdateTransaction.Rollback;
          raise;
        end;
      end;
    end;
  end;
end;

procedure TframeSipClient.RedrawMemo(var Txt: string);
var
  ToNumber: string;
begin
  if FLines[FLineIndex].CallType = ctIncoming then
  begin
    ToNumber := Copy(FLines[FLineIndex].FromAddr, 8, Pos('|', FLines[FLineIndex].FromAddr) - 8);
    ToNumber := FormatPhoneNumber(ToNumber);
    Txt := Txt + ' Incoming: ' + ToNumber + ''#13''#10'';
    // Sales IT
    if (ToNumber = '022903090') or (ToNumber = '079903090') then
      ColorMemo(dmdb.sipITSalesBGColor, dmdb.sipITSalesFontColor);
    // green
    // Sale Furniture
    if ToNumber = '022903095' then
      ColorMemo(dmDB.sipFurnitureSalesBGColor, dmDB.sipFurnitureSalesFontColor);
    // ServicePlus
    if (ToNumber = '022909911') and (ToNumber = '069909911') then
      ColorMemo(dmdb.sipServiceBGColor, dmDB.sipServiceFontColor);
    // Achizitii
    if ToNumber = '022903092' then
      ColorMemo(dmDB.sipPurchaiseBGColor, dmDB.sipPurchaiseFontColor);
    // Contabilitate
    if ToNumber = '022903091' then
      ColorMemo(dmdb.sipAccountingBGColor, dmDB.sipAccountingFontColor);
  end
  else
  begin
    Txt := Txt + ' Outgoing' + ''#13''#10'';
    ColorMemo($B0F9FD, clBlack);
  end;
end;

procedure TframeSipClient.AddNewCustomer(var PhoneNumber: string; var fIdentifiedCustomer: string; var fCustomerID: integer);
var
  Query: TIBCQuery;
  trUpdate: TIBCTransaction;
begin
  Query := TIBCQuery.Create(Self);
  trUpdate := TIBCTransaction.Create(nil);
  try

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    Query.SQL.Text := 'SELECT CUSTOMER_NAME, CUSTOMERID FROM REG_NEW_CUSTOMER_BY_PHONE(:PHONENUMBER)';
    Query.ParamByName('PHONENUMBER').AsString := PhoneNumber;
    Query.Transaction := trUpdate;

    if (not Query.Transaction.Active) then
      Query.Transaction.StartTransaction;

    Query.Execute;

    fIdentifiedCustomer := Query.FieldByName('CUSTOMER_NAME').AsString;
    fCustomerID := Query.FieldByName('CUSTOMERID').AsInteger;
    try
      if Query.Transaction.Active then
        Query.Transaction.Commit;
    except
      on e: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
      end;
    end;
  finally
    Query.Free;
    trUpdate.Free;
  end;
end;

procedure TframeSipClient.ClearCall;
begin
  PhoneEdit.Text := '';

  lbDuration.Caption := '0.00';
  lbDuration.Visible := False;

  FRecorder := nil;
//    FreeAndNil(FRingThread);
end;

procedure TframeSipClient.cxButton1Click(Sender: TObject);
begin
  var d := TfrmSMSInfoDlg.Create(self, PhoneEdit.Text);
  try
    d.showmodal;
  finally
    d.Free;
  end;
end;

function TframeSipClient.FormatPhoneNumber(const PhoneNumber: string): string;
begin
  Result := NormalizePhoneMD(PhoneNumber);
end;

procedure TframeSipClient.IBCCallHistoryBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('data').AsDateTime := Now();
end;

procedure TframeSipClient.SaveRecord(const ACall: ISipCall);
var
  i: Integer;
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.Position := 0;
    for i := 1 to 6 do
    begin
      // doar linia apelului incheiat; celelalte linii raman active
      if (FLines[i] = ACall) then
      begin
        SaveRecordedCall(ms, ACall);
        FLines[i] := nil;
        FDtmf[i] := '';
        FLineCallID[i] := 0;
        FLineAnswered[i] := False;
        FLineRejected[i] := False;
      end;
    end;
    RefreshLines;
  finally
    ms.Free;
  end;
end;

function TframeSipClient.LineIndexOf(const ACall: ISipCall): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to 6 do
    if Assigned(FLines[i]) and (FLines[i] = ACall) then
      Exit(i);
end;

procedure TframeSipClient.BeginLineCall(const ALine, ACallID: Integer);
begin
  FLineCallID[ALine] := ACallID;
  FLineAnswered[ALine] := False;
  FLineRejected[ALine] := False;
end;

// Scrie starea finala a apelului prin SP_PHONE_CALL_SET_STATE, care si
// coreleaza "pierdut" cu apelul preluat de un coleg din grup (+/- 90 s).
// O eroare aici nu trebuie sa blocheze inchiderea apelului: se arata in memo.
procedure TframeSipClient.SetCallState(const ACallID, AStateID: Integer);
var
  q: TIBCQuery;
  tr: TIBCTransaction;
begin
  if ACallID <= 0 then
    Exit;

  tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    try
      tr.DefaultConnection := dmDB.IBCConnection;
      q.Connection := dmDB.IBCConnection;
      q.Transaction := tr;
      q.SQL.Text := 'EXECUTE PROCEDURE SP_PHONE_CALL_SET_STATE(:CALLID, :STATEID)';
      q.ParamByName('CALLID').AsInteger := ACallID;
      q.ParamByName('STATEID').AsInteger := AStateID;
      tr.StartTransaction;
      q.Execute;
      tr.Commit;
      IBCCallHistory.Refresh;
    except
      on E: Exception do
      begin
        if tr.Active then
          tr.Rollback;
        LineMemo.Lines.Add('Stare apel: ' + E.Message);
      end;
    end;
  finally
    q.Free;
    tr.Free;
  end;
end;

procedure TframeSipClient.SelectNextAction;
begin
    // create reminder
//    if MessageDlg('Adaugati reamintire de sunat inapoi peste 5 min?', mtConfirmation, [mbYes, mbNo],0)=mrYes then
//    begin
//        dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, PhoneEdit.Text);
//    end;
end;

procedure TframeSipClient.SpeedButton13Click(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].state = sipints.csActive) then
  begin
    sipclient.DtmfMethod := dtmfSipInfo;
    case TComponent(Sender).Tag of
      0:
        sipclient.SendDtmf(FLines[FLineIndex], '0');
      1:
        sipclient.SendDtmf(FLines[FLineIndex], '1');
      2:
        sipclient.SendDtmf(FLines[FLineIndex], '2');
      3:
        sipclient.SendDtmf(FLines[FLineIndex], '3');
      4:
        sipclient.SendDtmf(FLines[FLineIndex], '4');
      5:
        sipclient.SendDtmf(FLines[FLineIndex], '5');
      6:
        sipclient.SendDtmf(FLines[FLineIndex], '6');
      7:
        sipclient.SendDtmf(FLines[FLineIndex], '7');
      8:
        sipclient.SendDtmf(FLines[FLineIndex], '8');
      9:
        sipclient.SendDtmf(FLines[FLineIndex], '9');
      10:
        sipclient.SendDtmf(FLines[FLineIndex], '*');
      11:
        sipclient.SendDtmf(FLines[FLineIndex], '#');
    end;
  end
  else if TComponent(Sender).Tag in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] then
    PhoneEdit.Text := PhoneEdit.Text + IntToStr(TComponent(Sender).Tag)
  else if TComponent(Sender).Tag = 10 then
    PhoneEdit.Text := PhoneEdit.Text + '*'
  else if TComponent(Sender).Tag = 11 then
    PhoneEdit.Text := PhoneEdit.Text + '#';

  sipclient.DtmfMethod := dtmfInBand;
end;

procedure TframeSipClient.TrimPhoneNumber(var PhoneNumber: string);
begin
  PhoneNumber := NormalizePhoneMD(PhoneNumber);
//    PhoneNumber := StringReplace(PhoneNumber, ' ', '', [rfReplaceAll, rfIgnoreCase]);
//    PhoneNumber := StringReplace(PhoneNumber, '(', '', [rfReplaceAll, rfIgnoreCase]);
//    PhoneNumber := StringReplace(PhoneNumber, ')', '', [rfReplaceAll, rfIgnoreCase]);
//    PhoneNumber := StringReplace(PhoneNumber, '-', '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TframeSipClient.ShowCallerHistory(PhoneNumber: string);
begin
  IBCQueryCallerHistory.Close;
  IBCQueryCallerHistory.ParamByName('PHONENUMBER').AsString := PhoneNumber;
  IBCQueryCallerHistory.Open;
end;

procedure TframeSipClient.TransferBtnClick(Sender: TObject);
begin
  if Assigned(FLines[FLineIndex]) then
  begin
    if VarToStr(TransferEdit.EditValue) <> '' then
    begin
      if Assigned(FLines[FLineIndex]) and (FLines[FLineIndex].state = sipints.csActive) then
      begin
        sipclient.TransferCall(FLines[FLineIndex], VarToStr(TransferEdit.EditValue));
      end
      else
      begin
        MessageBox(Handle, 'Apelul este inactiv sau intrerupt', 'Transfer de apel', MB_OK + MB_ICONSTOP);
      end;
    end
    else
    begin
      MessageBox(Handle, 'Introduceti numarul unde trebuie sa fie transferat apelul.', 'Transfer de apel', MB_OK + MB_ICONSTOP);
      TransferEdit.SetFocus;
    end;
  end;
end;

{ TPhoneSearchThread }

//constructor TPhoneSearchThread.Create(ACreateSuspended: boolean; APhoneNumber:
//    string);
//begin
//  inherited Create(ACreateSuspended);
//  IBCConnection := TIBCConnection.Create(nil);
//  ibcconnection.Create(nil, 'Data Source=192.168.106.254;Database=sw;User ID=SYSDBA;Password=uigres321;Client Library=fbclient.dll;Character Set=UTF8;Use Unicode=True;Login Prompt=False');
//  ibcconnection.Connected := true;
//  IBCTransaction := TIBCTransaction.Create(nil);
//  IBCTransaction.DefaultConnection := ibcConnection;
//
//  PhoneNumber := APhoneNumber;
//end;
//
//procedure TPhoneSearchThread.Execute;
//var
//  Query: TIBCQuery;
//  pn : string;
//begin
//  pn := FormatPhoneNumber(PhoneNumber);
//  Query := TIBCQuery.Create(nil);
//  Query.Connection := ibcconnection;
//  try
//    Query.SQL.TExt := 'SELECT * FROM GET_CUSTOMERS_BY_PHONE(:PHONENUMBER)';
//    Query.ParamByName('PHONENUMBER').AsString := pn;
//    Query.Open;
//    if Query.RecordCount > 0 then
//    begin
//      CustomerID := query.FieldByName('customerid').AsInteger;
//      CustomerName := query.FieldByName('NAME').AsString;
//    end
//    else
//    begin
//      AddNewCustomer(pn);
//    end;
//  finally
//    Query.Free;
//  end;
//end;
//
//procedure TPhoneSearchThread.FormatPhoneNumber(var PhoneNumber: string);
//begin
//  if (Copy(PhoneNumber, 1, 2) = '22') then
//    PhoneNumber := '0' + PhoneNumber;
////
////  if p > 0 then
////    PhoneNumber := copy(PhoneNumber, pos('022', PhoneNumber) + 1, length(PhoneNumber));
//  if Length(PhoneNumber) > 0 then
//    if (PhoneNumber[1] = '6') or (PhoneNumber[1] = '7') then
//      PhoneNumber := '0' + PhoneNumber;
//end;
//
//procedure TPhoneSearchThread.UpdateCallerInfo;
//begin
//    frameSipClient.fIdentifiedCustomer := CustomerName;
//    frameSipClient.fCustomerID := CustomerID;
//end;
//
//procedure TPhoneSearchThread.AddNewCustomer(PhoneNumber: string);
//var
//  Query: TIBCQuery;
//begin
//  Query := TIBCQuery.Create(nil);
//  try
//    Query.SQL.Text := 'SELECT CUSTOMER_NAME, CUSTOMERID FROM REG_NEW_CUSTOMER_BY_PHONE(:PHONENUMBER)';
//    Query.ParamByName('PHONENUMBER').AsString := PhoneNumber;
//    Query.Transaction := IBCTransaction;
//    if (not Query.Transaction.Active) then
//      Query.Transaction.StartTransaction;
//
//    Query.Execute;
//    Synchronize(UpdateCallerInfo);
//    try
//      if Query.Transaction.Active then
//        Query.Transaction.Commit;
//    except
//      on e: Exception do
//      begin
//        if Query.Transaction.Active then
//          Query.Transaction.Rollback;
//      end;
//    end;
//  finally
//    Query.Free;
//  end;
//end;

end.


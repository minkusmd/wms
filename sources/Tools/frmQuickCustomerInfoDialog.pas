unit frmQuickCustomerInfoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, cxPC, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxBar, cxBarEditItem,
  DBAccess, IBC, MemDS, Vcl.Buttons, cxMemo, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges,
  dxBarBuiltInMenu, cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList,
  dxScrollbarAnnotations, Vcl.Menus, cxButtons, frameDocsDeliveryUnit,
  frameCustomerEMailUnit, frameCustomerPhonesUnit, frameCustomerAddressUnit,
  Vcl.MPlayer, dxBarExtItems, cxLabel, cxDBLabel, Vcl.ComCtrls, ACS_Classes, ACS_WinMedia, ACS_smpeg, ACS_DXAudio,
  ACS_Wave, System.Classes;

type
  TCustomerList = array of Integer;

  TfrmQuickCustomerInfoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnButtons: TPanel;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    lcbCustomers: TcxBarEditItem;
    Panel: TPanel;
    Label1: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    Label2: TLabel;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    Label4: TLabel;
    cxDBTextEdit7: TcxDBTextEdit;
    Label5: TLabel;
    cxDBTextEdit8: TcxDBTextEdit;
    cxLabel10: TLabel;
    cxLabel11: TLabel;
    cxLabel19: TLabel;
    cxDBTextEdit9: TcxDBTextEdit;
    cxDBTextEdit10: TcxDBTextEdit;
    cxDBTextEdit11: TcxDBTextEdit;
    cxDBTextEdit12: TcxDBTextEdit;
    IBCQueryCustomers: TIBCQuery;
    IBCDataSourceCustomers: TIBCDataSource;
    IBCQueryInfo: TIBCQuery;
    IBCDataSourceInfo: TIBCDataSource;
    IBCQueryAcc: TIBCQuery;
    IBCDataSourceAcc: TIBCDataSource;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    sbOpenCustomer: TSpeedButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGridAccounts: TcxGrid;
    cxGridAccountsDB: TcxGridDBTableView;
    cxGridAccountsDBACCOUNTNUMBER: TcxGridDBColumn;
    cxGridAccountsDBACCOUNTNAME: TcxGridDBColumn;
    cxGridAccountsDBBANKNAME: TcxGridDBColumn;
    cxGridAccountsDBDEFAULT_ACCOUNT: TcxGridDBColumn;
    cxGridAccountsLevel: TcxGridLevel;
    cxTabSheet2: TcxTabSheet;
    mmCOMMENTS: TcxDBMemo;
    cxTabSheet3: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarDockControl2: TdxBarDockControl;
    bbPlay: TdxBarButton;
    bbSaveAs: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    IBCQueryDialHistory: TIBCQuery;
    IBCDataSourceDialHistory: TIBCDataSource;
    cxGrid1DBTableView1WAV: TcxGridDBColumn;
    cxGrid1DBTableView1SOURCEID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1USERNAME: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxImageList1: TcxImageList;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    btnClose: TcxButton;
    cxTabSheet4: TcxTabSheet;
    frameCustomerAddr1: TframeCustomerAddr;
    cxImageList2: TcxImageList;
    cxTabSheet5: TcxTabSheet;
    frameCustomerPhones1: TframeCustomerPhones;
    dxBarContainerItem1: TdxBarContainerItem;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    cxLabel1: TcxLabel;
    lbCashback: TcxLabel;
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    dxBarButton1: TdxBarButton;
    cxButton1: TcxButton;
    dxBarButton2: TdxBarButton;
    cxBarEditItem1: TcxBarEditItem;
    MP3In1: TMP3In;
    DXAudioOut1: TDXAudioOut;
    WaveIn1: TWaveIn;
    procedure lcbCustomersPropertiesChange(Sender: TObject);
    procedure sbOpenCustomerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxTabSheet3Show(Sender: TObject);
    procedure bbPlayClick(Sender: TObject);
    procedure bbSaveAsClick(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxTabSheet5Show(Sender: TObject);
    procedure DXAudioOut1Progress(Sender: TComponent);
    procedure FormShow(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure DXAudioOut1Done(Sender: TComponent);
  private
    { Private declarations }
    fCT: integer;
    fDT: integer;
    fCustomerIDToOpen: integer;
    fAudioInput: TAuFileIn;    // inputul activ: MP3In1 sau WaveIn1
    fTrackUpdating: Boolean;   // TrackBar1.Position este schimbat din cod, nu de utilizator
    fTrackScrubbing: Boolean;  // utilizatorul trage cursorul cu mouse-ul
    fPendingSeek: Integer;     // pozitia ceruta inainte ca redarea sa devina activa (-1 = nimic)
    fTrackWndProc: TWndMethod; // WindowProc original al TrackBar1
    procedure TrackBarWndProc(var Message: TMessage);
    procedure SetCT(const Value: integer);
    procedure SetDT(const Value: integer);
    procedure ShowCustomerInfo(const CustomerID: integer);
    procedure StopPlayback;
    procedure ResetTrackBar;
    procedure SetTrackPosition(const APos: Integer);
    procedure ApplySeek(const ATrackPos: Integer);
    procedure SeekToTrackPosition;
    procedure UpdatePlaybackInfo(const ATrackPos: Integer = -1);
  protected
    function GetCashbackAmount(const CT: integer): Double;
    { protected declarations }
    procedure Prepare; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property DT: integer read FDT write SetDT;
    property CT: integer read FCT write SetCT;
    property CustomerIDToOpen: integer read fCustomerIDToOpen;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, Winapi.MMSystem, System.IOUtils, SWNUtils,
  Winapi.CommCtrl;

{$R *.dfm}

const
  // TrackBar-ul lucreaza in miimi din durata totala, independent de numarul de sample-uri
  TrackScale = 1000;

function FormatSeconds(const ASeconds: Integer): string;
begin
  Result := Format('%.2d:%.2d', [ASeconds div 60, ASeconds mod 60]);
end;

{ TfrmQuickCustomerInfoDlg }

procedure TfrmQuickCustomerInfoDlg.bbPlayClick(Sender: TObject);
var
  tmpFilename: string;
begin
  StopPlayback;

  // eliberam fisierul temporar inainte de a-l suprascrie
  fAudioInput := nil;
  MP3In1.FileName := '';
  WaveIn1.FileName := '';

  tmpFilename := 'tmpvoice';//tpath.GetTempFileName;
  TBlobField(IBCQueryDialHistory.FieldByName('WAV')).SaveToFile(tmpFilename);

  MP3In1.FileName := tmpFilename;
  if MP3In1.Valid then
    fAudioInput := MP3In1
  else begin
    WaveIn1.FileName := tmpFileName;
    if WaveIn1.Valid then
      fAudioInput := WaveIn1;
  end;

  ResetTrackBar;

  if fAudioInput = nil then begin
    UpdatePlaybackInfo;
    Exit;
  end;

  DXAudioOut1.Input := fAudioInput;
  DXAudioOut1.Run;
  UpdatePlaybackInfo;
end;

procedure TfrmQuickCustomerInfoDlg.bbSaveAsClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  dialog := TSaveDialog.Create(Owner);
  try
    dialog.DefaultExt := 'wav';
    dialog.Options := dialog.Options + [ofPathMustExist];
    dialog.Filter := 'Wav Files|*.wav';

    if dialog.Execute then
      TBlobField(IBCQueryDialHistory.FieldByName('WAV')).SaveToFile(dialog.FileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.cxButton1Click(Sender: TObject);
var
  CurrentCashBack: Double;
begin
  CurrentCashBack := GetCashbackAmount(CT);
  lbCashback.Caption := Format('%n', [CurrentCashBack]);
  if (CurrentCashBack < 0) then begin
    if Assigned(lbCashback.Style) then begin
      lbCashback.Style.Color := clRed;
      lbCashback.Style.Font.Color := clWhite;
    end;
     lbCashback.Enabled := True;
  end
  else
   lbCashback.Enabled := False;

end;

procedure TfrmQuickCustomerInfoDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGrid1DBTableView1, Key, Shift);
end;

procedure TfrmQuickCustomerInfoDlg.cxTabSheet3Show(Sender: TObject);
begin
  IBCQueryDialHistory.Close;
  IBCQueryDialHistory.ParamByName('PHONENUMBER').AsString := IBCQueryInfo.FieldByName('MOBILE').AsString + ',' + IBCQueryInfo.FieldByName('TELEFON1').AsString;
  IBCQueryDialHistory.Open;
end;

procedure TfrmQuickCustomerInfoDlg.cxTabSheet5Show(Sender: TObject);
begin
  frameCustomerPhones1.IBCQueryCustomerPhones.Active := True;
end;

procedure TfrmQuickCustomerInfoDlg.DXAudioOut1Done(Sender: TComponent);
begin
  if fTrackScrubbing or (fPendingSeek >= 0) then
    Exit;
  SetTrackPosition(TrackBar1.Max);
  UpdatePlaybackInfo(TrackBar1.Max);
end;

procedure TfrmQuickCustomerInfoDlg.DXAudioOut1Progress(Sender: TComponent);
var
  Pending: Integer;
begin
  if fAudioInput = nil then
    Exit;

  // pozitia ceruta inainte de pornire se aplica dupa ce redarea a devenit activa
  if fPendingSeek >= 0 then begin
    Pending := fPendingSeek;
    fPendingSeek := -1;
    ApplySeek(Pending);
    Exit;
  end;

  // cat timp utilizatorul trage cursorul nu il mutam sub mouse
  if fTrackScrubbing then
    Exit;

  if fAudioInput.Size > 0 then
    SetTrackPosition(Round(fAudioInput.Position / fAudioInput.Size * TrackScale));
  UpdatePlaybackInfo;
end;

procedure TfrmQuickCustomerInfoDlg.dxBarButton1Click(Sender: TObject);
begin
  StopPlayback;
  ResetTrackBar;
  UpdatePlaybackInfo(0);
end;

procedure TfrmQuickCustomerInfoDlg.dxBarButton2Click(Sender: TObject);
begin
  case DXAudioOut1.Status of
    tosPlaying: DXAudioOut1.Pause;
    tosPaused:  DXAudioOut1.Resume;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.FormCreate(Sender: TObject);
begin
  fCustomerIDToOpen := -1;
  fAudioInput := nil;
  fPendingSeek := -1;

  fTrackWndProc := TrackBar1.WindowProc;
  TrackBar1.WindowProc := TrackBarWndProc;
end;

procedure TfrmQuickCustomerInfoDlg.FormShow(Sender: TObject);
begin
  cxPageControl1.ActivePageIndex := 0;
end;

function TfrmQuickCustomerInfoDlg.GetCashbackAmount(const CT: integer): Double;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.SQL.Text := 'SELECT CASHBACK from GET_AVAILABLE_CASHBACK(:ct)';
    Query.ParamByName('CT').AsInteger := CT;
    Query.Open;
    Result := Query.FieldByName('CASHBACK').AsFloat;
  finally
    Query.Free;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.lcbCustomersPropertiesChange(Sender: TObject);
begin
  ShowCustomerInfo(lcbCustomers.EditValue);
end;

procedure TfrmQuickCustomerInfoDlg.Prepare;
var
  CurrentCashBack: double;
  S: string;
begin
  S := '';
  if DT <> -1 then
    S := Format('CUSTOMERID=%d', [fDT]);
  if CT <> -1 then begin
    if S <> '' then
      S := S + ' OR ';
    S := S + Format('CUSTOMERID=%d', [fCT]);
  end;

  IBCQueryCustomers.AddWhere(S);
  IBCQueryCustomers.Active := True;

  if CT <> -1 then
    lcbCustomers.EditValue := fCT
  else if DT <> -1 then
    lcbCustomers.EditValue := fDT;

  if VarIsNumeric(lcbCustomers.EditValue) then
    ShowCustomerInfo(lcbCustomers.EditValue);

  frameCustomerPhones1.CustomerID := CT;
  frameCustomerPhones1.IBCQueryCustomerPhones.ParamByName('CUSTOMERID').AsInteger := CT;
  frameCustomerPhones1.IBCQueryCustomerPhones.Active := True;

  frameCustomerAddr1.CustomerID := CT;
  frameCustomerAddr1.IBCQueryCustomerAddr.ParamByName('CUSTOMERID').AsInteger := CT;
  frameCustomerAddr1.IBCQueryCustomerAddr.Active := True;

  IBCQueryCustomers.Active := True;

  lbCashback.Enabled := False;
  ResetTrackBar;
end;

procedure TfrmQuickCustomerInfoDlg.sbOpenCustomerClick(Sender: TObject);
begin
  fCustomerIDToOpen := lcbCustomers.EditValue;
  ModalResult := mrOk;
end;

procedure TfrmQuickCustomerInfoDlg.SetCT(const Value: integer);
begin
  FCT := Value;
end;

procedure TfrmQuickCustomerInfoDlg.SetDT(const Value: integer);
begin
  FDT := Value;
end;

procedure TfrmQuickCustomerInfoDlg.ShowCustomerInfo(const CustomerID: integer);
begin
  IBCQueryInfo.Close;
  IBCQueryInfo.ParamByName('id').AsInteger := CustomerID;
  IBCQueryInfo.Active := True;
  IBCQueryAcc.Active := True;
end;

procedure TfrmQuickCustomerInfoDlg.TrackBar1Change(Sender: TObject);
begin
  // pozitia a fost setata din cod (progresul redarii) - nu este o comanda a utilizatorului
  if fTrackUpdating then
    Exit;

  if fTrackScrubbing then
    // in timpul tragerii aratam doar timpul; seek-ul se face la eliberarea butonului
    UpdatePlaybackInfo(TrackBar1.Position)
  else
    SeekToTrackPosition;
end;

procedure TfrmQuickCustomerInfoDlg.TrackBarWndProc(var Message: TMessage);
var
  ScrollCode: Integer;
begin
  // TTrackBar nu publica OnMouseDown/OnMouseUp, asa ca urmarim direct notificarile de scroll:
  // TB_THUMBTRACK = utilizatorul trage cursorul, restul codurilor incheie deplasarea
  if (Message.Msg = CN_HSCROLL) or (Message.Msg = CN_VSCROLL) then begin
    ScrollCode := TWMScroll(Message).ScrollCode;
    fTrackScrubbing := True; // pe durata prelucrarii, OnChange doar actualizeaza timpul
    try
      fTrackWndProc(Message);
    finally
      fTrackScrubbing := ScrollCode = TB_THUMBTRACK;
    end;

    if not fTrackScrubbing then
      SeekToTrackPosition;
    Exit;
  end;

  fTrackWndProc(Message);
end;

procedure TfrmQuickCustomerInfoDlg.SeekToTrackPosition;
begin
  if fAudioInput = nil then
    Exit;

  case DXAudioOut1.Status of
    tosPlaying, tosPaused:
      ApplySeek(TrackBar1.Position);
    tosIdle:
      begin
        // redarea s-a terminat sau a fost oprita: pornim din nou si sarim la pozitia ceruta
        fPendingSeek := TrackBar1.Position;
        UpdatePlaybackInfo(TrackBar1.Position);
        DXAudioOut1.Input := fAudioInput;
        DXAudioOut1.Run;
      end;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.ApplySeek(const ATrackPos: Integer);
var
  TotalSamples, TargetSample: Int64;
begin
  if (fAudioInput = nil) or (not fAudioInput.Seekable) then
    Exit;

  TotalSamples := fAudioInput.TotalSamples;
  if TotalSamples <= 0 then
    Exit;

  TargetSample := Round(TotalSamples * (ATrackPos / TrackScale));
  if TargetSample >= TotalSamples then
    TargetSample := TotalSamples - 1;
  if TargetSample < 0 then
    TargetSample := 0;

  // Seek functioneaza si in timpul redarii - nu oprim si nu repornim iesirea audio
  // (Stop asincron urmat imediat de Run producea EAuException 'Component is Busy')
  fAudioInput.Seek(TargetSample);
  UpdatePlaybackInfo(ATrackPos);
end;

procedure TfrmQuickCustomerInfoDlg.StopPlayback;
begin
  fPendingSeek := -1;
  if Assigned(DXAudioOut1) and (DXAudioOut1.Status <> tosIdle) then
    DXAudioOut1.Stop(False); // sincron: asteptam oprirea efectiva a firului de redare
end;

procedure TfrmQuickCustomerInfoDlg.ResetTrackBar;
begin
  fTrackScrubbing := False;
  fTrackUpdating := True;
  try
    TrackBar1.Min := 0;
    TrackBar1.Max := TrackScale;
    TrackBar1.PageSize := TrackScale div 20;
    TrackBar1.Frequency := TrackScale div 10;
    TrackBar1.Position := 0;
  finally
    fTrackUpdating := False;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.SetTrackPosition(const APos: Integer);
var
  Pos: Integer;
begin
  Pos := APos;
  if Pos < TrackBar1.Min then
    Pos := TrackBar1.Min;
  if Pos > TrackBar1.Max then
    Pos := TrackBar1.Max;

  fTrackUpdating := True;
  try
    TrackBar1.Position := Pos;
  finally
    fTrackUpdating := False;
  end;
end;

procedure TfrmQuickCustomerInfoDlg.UpdatePlaybackInfo(const ATrackPos: Integer);
var
  Total, Elapsed: Integer;
begin
  if fAudioInput = nil then begin
    cxBarEditItem1.Caption := '';
    Exit;
  end;

  Total := fAudioInput.TotalTime;
  if ATrackPos >= 0 then
    Elapsed := Round(Total * (ATrackPos / TrackScale))
  else
    Elapsed := DXAudioOut1.TimeElapsed;

  if Elapsed > Total then
    Elapsed := Total;
  if Elapsed < 0 then
    Elapsed := 0;

  cxBarEditItem1.Caption := Format('%s / %s', [FormatSeconds(Elapsed), FormatSeconds(Total)]);
end;

procedure TfrmQuickCustomerInfoDlg.WhenCancelForm;
begin
  inherited;
  StopPlayback;
end;

end.


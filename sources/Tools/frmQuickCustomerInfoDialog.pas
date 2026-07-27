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
    procedure cxBarEditItem1Change(Sender: TObject);
  private
    { Private declarations }
    fCT: integer;
    fDT: integer;
    fCustomerIDToOpen: integer;
    procedure SetCT(const Value: integer);
    procedure SetDT(const Value: integer);
    procedure ShowCustomerInfo(const CustomerID: integer);
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

{ TfrmQuickCustomerInfoDlg }

procedure TfrmQuickCustomerInfoDlg.bbPlayClick(Sender: TObject);
var
  tmpFilename: string;
begin
  tmpFilename := 'tmpvoice';//tpath.GetTempFileName;
//  tmpFilename := ChangeFileExt(tmpFilename, '.mp3');
  TBlobField(IBCQueryDialHistory.FieldByName('WAV')).SaveToFile(tmpFilename);

  MP3In1.FileName := tmpFilename;
  if MP3In1.Valid then begin
    DXAudioOut1.Input := MP3In1;
    TrackBar1.Position := 0;
    TrackBar1.max := mp3in1.TotalSamples;
    DXAudioOut1.Run;
  end
  else begin
    WaveIn1.FileName := tmpFileName;
    if WaveIn1.Valid then begin
      DXAudioOut1.Input := WaveIn1;
      TrackBar1.Min := 0;
      TrackBar1.Max := WaveIn1.TotalSamples;
      DXAudioOut1.Run;
    end;
  end;

//  with MediaPlayer1 do begin
//    MediaPlayer1.Close;
//    MediaPlayer1.FileName := tmpFilename;
//    TimeFormat := tfMilliSeconds;
//    MediaPlayer1.Open;
//    TrackBar1.Min := 0;
//    TrackBar1.Max := Length;
//    MediaPlayer1.Position := TrackBar1.Position;
//    MediaPlayer1.Play;
//    AudioTimer.Enabled := True;
//  end;
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

procedure TfrmQuickCustomerInfoDlg.cxBarEditItem1Change(Sender: TObject);
begin
  DXAudioOut1.Jump(1000);
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

procedure TfrmQuickCustomerInfoDlg.DXAudioOut1Progress(Sender: TComponent);
begin
  TrackBar1.Position := dxAudioout1.Progress * 1000;
cxBarEditItem1.Caption :=  IntToStr(DXAudioOut1.Progress);
//  Application.ProcessMessages;
end;

procedure TfrmQuickCustomerInfoDlg.dxBarButton1Click(Sender: TObject);
begin
  dxAudioOut1.Stop(false);
end;

procedure TfrmQuickCustomerInfoDlg.dxBarButton2Click(Sender: TObject);
begin
 if DxAudioOut1.Status = tosPlaying then
    DxAudioOut1.Pause
  else
    DxAudioOut1.Resume;
end;

procedure TfrmQuickCustomerInfoDlg.FormCreate(Sender: TObject);
begin
  fCustomerIDToOpen := -1;
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
  TrackBar1.Position := 0;
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
  DXAudioOut1.Stop();
  WaveIn1.Seek(TrackBar1.Position);
  DXAudioOut1.Run;
end;

procedure TfrmQuickCustomerInfoDlg.WhenCancelForm;
begin
  inherited;
  if Assigned(DXAudioOut1) then
    DXAudioOut1.Stop;
end;

end.


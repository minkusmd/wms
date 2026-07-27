unit uSipLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Menus, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  DBAccess, IBC, MemDS, dxBar, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.StdCtrls, cxButtons, cxButtonEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxLabel, cxTextEdit, Vcl.ExtCtrls, DialogTitle,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageComboBox,
  dxDateRanges, dxScrollbarAnnotations, Vcl.MPlayer, dxBarExtItems, ACS_Wave,
  ACS_Classes, ACS_WinMedia, ACS_smpeg, ACS_DXAudio, cxProgressBar, dxStatusBar;

type
  TfrmSipLog = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    tePhoneNumber: TcxTextEdit;
    cxLabel2: TcxLabel;
    cxDateEdit1: TcxDateEdit;
    cxLabel1: TcxLabel;
    cxDateEdit2: TcxDateEdit;
    cxLabel3: TcxLabel;
    beUserName: TcxButtonEdit;
    cxButton1: TcxButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel2: TPanel;
    btnOK: TcxButton;
    dxBarButton1: TdxBarButton;
    IBCQueryPhoneCalls: TIBCQuery;
    IBCDataSourcePhoneCalls: TIBCDataSource;
    cxGrid1DBTableView1CALLID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1CALLTYPEID: TcxGridDBColumn;
    cxGrid1DBTableView1PHONENUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1NICKNAME: TcxGridDBColumn;
    cxGrid1DBTableView1FULL_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_HAS_WAV: TcxGridDBColumn;
    IBCQueryCallsWav: TIBCQuery;
    dxBarButton2: TdxBarButton;
    SaveDialog1: TSaveDialog;
    cxGrid1DBTableView1_DURATION: TcxGridDBColumn;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    dxBarButton3: TdxBarButton;
    DXAudioOut1: TDXAudioOut;
    MP3In1: TMP3In;
    WaveIn1: TWaveIn;
    dxStatusBar1: TdxStatusBar;
    dxBarButton4: TdxBarButton;
    procedure cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmSipLog: TfrmSipLog;

implementation

uses
  DataModuleAdditions, frmUsersBrowser, uSelectUserDialog, Winapi.MMSystem,
  SWNSecurityUtils, SWNSecurity, System.IOUtils;

{$R *.dfm}

procedure TfrmSipLog.cxButton1Click(Sender: TObject);
begin
  with IBCQueryPhoneCalls do begin
    Close;
    sql.Clear;
    sql.Add('select ch.*, u.FULL_NAME, cr.DURATION,' + 'iif(exists(select callid from ts_phone_calls_register cc where cc.callid=ch.callid),1,0) FLG_HAS_WAV from ts_phone_calls_history ch ' + 'inner join ts_users u on u.userid=ch.userid');
    sql.Add('inner join  ts_phone_calls_register cr on cr.callid=ch.callid');
//    if (SWNSecurity.SWNSecurityManager.UserID<>204) then
//      sql.Add(' and u.USERID not in (204, 360, 196) ');

    sql.Add('left outer join ts_customer c on c.customerid=ch.customerid ' + ' where cast(data as date)>=:data1 and cast(data as date)<=:data2');

    sql.Add('order by data desc');

    ParamByName('DATA1').AsDate := cxDateEdit1.Date;
    ParamByName('DATA2').AsDate := cxDateEdit2.Date;
    if tePhoneNumber.Text <> '' then
      AddWhere('ch.phonenumber containing ' + QuotedStr(tePhoneNumber.Text));

    if beUserName.Tag > 0 then
      AddWhere(Format('u.userid=%d', [beUsername.Tag]));
    Open;
  end;
end;

procedure TfrmSipLog.cxButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmSelectUserDialog;
begin
  if AButtonIndex = 0 then begin
    dialog := TfrmSelectUserDialog.Create(Owner);
    try
      if dialog.SelectUser then begin
        beUserName.Tag := dialog.UserID;
        beUserName.Text := dialog.UserName;
      end;
    finally
      dialog.Free;
    end;
  end;
  if AButtonIndex = 1 then begin
    beUserName.Text := '';
    beUserName.Tag := 0;
  end;

end;

procedure TfrmSipLog.cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
//  if not VarIsNull(AViewInfo.GridRecord.Values[cxGrid1DBTableView1_FLG_HAS_WAV.Index]) then
//  begin
//    if AViewInfo.GridRecord.Values[cxGrid1DBTableView1_FLG_HAS_WAV.Index] = 1 then
//    begin
//      ACanvas.Brush.Color := clWebLightSalmon;
//    end;
//  end;
end;

procedure TfrmSipLog.dxBarButton1Click(Sender: TObject);
var
  tmpFilename: string;
begin
  with IBCQueryCallsWav do begin
    Close;
    ParamByName('CALLID').AsInteger := IBCQueryPhoneCalls.FieldByName('CALLID').AsInteger;
    Open;

    tmpFilename := tpath.GetTempFileName;
    TBlobField(IBCQueryCallsWav.FieldByName('WAV')).SaveToFile(tmpFilename);

    MP3In1.FileName := tmpFilename;
    if MP3In1.Valid then begin
      DXAudioOut1.Input := MP3In1;
      DXAudioOut1.Run;
    end
    else begin
      WaveIn1.FileName := tmpFilename;
      if WaveIn1.Valid then begin
        DXAudioOut1.Input := WaveIn1;
        DXAudioOut1.Run;
      end;
    end;
  end;
end;

procedure TfrmSipLog.dxBarButton2Click(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  with IBCQueryCallsWav do begin
    Close;
    ParamByName('CALLID').AsInteger := IBCQueryPhoneCalls.FieldByName('CALLID').AsInteger;
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

procedure TfrmSipLog.dxBarButton3Click(Sender: TObject);
begin
 if DXAudioOut1.Status = tosPlaying then
    DXAudioOut1.Pause
  else
    DXAudioOut1.Resume;
end;

procedure TfrmSipLog.dxBarButton4Click(Sender: TObject);
begin
  DXAudioOut1.Stop(False);
end;

procedure TfrmSipLog.Prepare;
begin
  inherited;
  cxDateEdit1.Date := Date - 1;
  cxDateEdit2.Date := Date;
  tePhoneNumber.Text := '';
  beUserName.Tag := -1;
  beUserName.Text := '';
end;

end.


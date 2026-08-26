unit frmPhoneCallsOptionsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls, DialogTitle, SWNBaseUnit, cxContainer, ACS_Classes, ACS_Wave,
  ACS_LAME, cxProgressBar, Vcl.MPlayer, ACS_WinMedia, ACS_smpeg, ACS_DXAudio, ACS_Converters, Vcl.ComCtrls;

type
  TfrmPhoneCallsOptionsDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    Panel2: TPanel;
    cxButton1: TcxButton;
    IBCQueryCalls: TIBCQuery;
    IBCDataSourceCalls: TIBCDataSource;
    IBCTransaction1: TIBCTransaction;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryWAV: TIBCQuery;
    cxProgressBar1: TcxProgressBar;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    MP3Out1: TMP3Out;
    WaveIn1: TWaveIn;
    Panel3: TPanel;
    btnStart: TcxButton;
    pbConvertion: TcxProgressBar;
    Memo1: TMemo;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    btnStop: TcxButton;
    cxButton2: TcxButton;
    MP3In1: TMP3In;
    DXAudioOut1: TDXAudioOut;
    cxButton3: TcxButton;
    TrackBar1: TTrackBar;
    procedure btnStartClick(Sender: TObject);
    procedure MP3Out1Done(Sender: TComponent);
    procedure MP3Out1Progress(Sender: TComponent);
    procedure btnStopClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton3Click(Sender: TObject);
    procedure DXAudioOut1Done(Sender: TComponent);
    procedure DXAudioOut1Progress(Sender: TComponent);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    flgDone: Boolean;
    procedure ConvertToMP3;
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmPhoneCallsOptionsDlg: TfrmPhoneCallsOptionsDlg;

implementation

{$R *.dfm}

{ TfrmPhoneCallsOptionsDlg }

procedure TfrmPhoneCallsOptionsDlg.btnStartClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  btnStop.Enabled := True;
  btnStart.Enabled := False;
  ConvertToMP3;
end;

procedure TfrmPhoneCallsOptionsDlg.MP3Out1Done(Sender: TComponent);
begin
  if MP3Out1.ExceptionMessage = '' then begin
    Memo1.Lines.Add(format('%d - converted with success', [IBCQueryCalls.FieldByName('callid').AsInteger]));
    try
      // update print-o procedura din FB
      IBCQueryWAV.Edit;
      TBlobField(IBCQueryWAV.FieldByName('WAV')).LoadFromFile(MP3Out1.FileName);
      IBCQueryWAV.Post;
      flgDone := True;

    finally
      deleteFile(MP3Out1.FileName);
      deleteFile(WaveIn1.FileName);
    end;
  end
  else
    Memo1.Lines.add(format('%d - Error [%s]', [IBCQueryCalls.FieldByName('callid').AsInteger, MP3Out1.ExceptionMessage]));
    cxProgressBar1.Position := ibcquerycalls.recno;

  if (not ibcquerycalls.Eof) and (btnStop.Enabled) then begin
    Application.ProcessMessages;
    IBCQueryCalls.Next;
    ConvertToMP3;
  end;
end;

procedure TfrmPhoneCallsOptionsDlg.MP3Out1Progress(Sender: TComponent);
begin
  pbConvertion.Position := MP3Out1.Progress;
end;

procedure TfrmPhoneCallsOptionsDlg.Prepare;
begin
  inherited;
  IBCTransaction1.DefaultConnection := fIBCConnection;
  ibcquerycalls.Open;
  ibcquerywav.Open;

  cxProgressBar1.properties.min := ibcquerycalls.RecNo;
  cxProgressBar1.Properties.max := ibcquerycalls.RecordCount-1;
end;

procedure TfrmPhoneCallsOptionsDlg.btnStopClick(Sender: TObject);
begin
  inherited;
  btnStop.Enabled := false;
  btnStart.Enabled := True;
end;

procedure TfrmPhoneCallsOptionsDlg.ConvertToMP3;
begin
  WaveIn1.FileName := IBCQueryWav.FieldByName('callid').AsString + '.wav';
  MP3Out1.FileName := ChangeFileExt(WaveIn1.FileName, '.mp3');
  TBlobField(IBCQueryWav.FieldByName('WAV')).SaveToFile(WaveIn1.FileName);
  if WaveIn1.Valid then begin
    MP3Out1.Id3v2Tags.Clear;
    flgDone := False;
    MP3Out1.Run;
  end
  else
  begin
    DeleteFile(WaveIn1.FileName);
    Memo1.Lines.Add(IBCQueryWav.FieldByName('callid').AsString + ' - Eroare! Format incompatibil!');
    ibcquerycalls.Next;
    Application.ProcessMessages;
    if btnStop.Enabled then
      ConvertToMP3;
  end;
end;

procedure TfrmPhoneCallsOptionsDlg.cxButton2Click(Sender: TObject);
var
  fn: string;
begin
  inherited;
  fn := IBCQueryCalls.FieldByName('callid').AsString + '.mp3';
  TBlobField(IBCQueryWAV.FieldByName('WAV')).SaveToFile(fn);

  mp3in1.FileName :=  fn;
  Trackbar1.Min := 0;
  Trackbar1.Max := mp3in1.Size;

  if (mp3in1.Valid) then
  begin
    dxAudioOut1.Run;
  end;
end;

procedure TfrmPhoneCallsOptionsDlg.cxButton3Click(Sender: TObject);
begin
  inherited;
  DXAudioOut1.Stop;
end;

procedure TfrmPhoneCallsOptionsDlg.DXAudioOut1Done(Sender: TComponent);
begin
  trackbar1.Position := 0;
end;

procedure TfrmPhoneCallsOptionsDlg.DXAudioOut1Progress(Sender: TComponent);
begin

  Trackbar1.Position := MP3In1.Position;
end;

procedure TfrmPhoneCallsOptionsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DXAudioOut1.Stop(False);
end;

procedure TfrmPhoneCallsOptionsDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  DXAudioOut1.Stop(False);
  CanClose := True;
end;

end.


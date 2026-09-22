unit ParsersMainFormUnit;

{ WMSParsers - fereastra principala: alegi joburile, modul de scriere si le rulezi pe rind.
  Aceeasi rulare, fara fereastra, o face modul /auto (vezi WMSParsers.dpr). }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst, SupplierPriceSyncUnit,
  ParserJobUnit;

type
  TfrmParsersMain = class(TForm)
    pnlTop: TPanel;
    lblParsers: TLabel;
    clbParsers: TCheckListBox;
    rgMode: TRadioGroup;
    lblServer: TLabel;
    edServer: TEdit;
    lblUser: TLabel;
    edUser: TEdit;
    btnRun: TButton;
    btnStop: TButton;
    lblStatus: TLabel;
    mmLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRunClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    fRunning: Boolean;
    fStopRequested: Boolean;
    fCurrentJob: TParserJob;
    procedure AddLog(const AMessage: string);
    procedure SetRunning(const Value: Boolean);
  public
    { Public declarations }
  end;

var
  frmParsersMain: TfrmParsersMain;

implementation

uses
  System.UITypes, IBC, ParserRunnerUnit;

{$R *.dfm}

procedure TfrmParsersMain.FormCreate(Sender: TObject);
var
  C: TParserJobClass;
  Options: TParserRunOptions;
begin
  clbParsers.Items.Clear;
  for C in ParserJobs do
    clbParsers.Items.Add(C.DisplayName);

  Options := TParserRunOptions.Defaults;
  Options.ReadCommandLine;
  edServer.Text := Options.Server;
  edUser.Text := IntToStr(Options.UserID);
  if Options.Mode = hsmReevaluation then
    rgMode.ItemIndex := 1
  else
    rgMode.ItemIndex := 0;
  SetRunning(False);
  lblStatus.Caption := 'Alegeti joburile si apasati Ruleaza.';
end;

procedure TfrmParsersMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not fRunning;
  if fRunning then
    MessageDlg('Un parser ruleaza. Apasati Stop si asteptati sa se opreasca.', mtInformation, [mbOK], 0);
end;

procedure TfrmParsersMain.AddLog(const AMessage: string);
begin
  mmLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + AMessage);
end;

procedure TfrmParsersMain.SetRunning(const Value: Boolean);
begin
  fRunning := Value;
  btnRun.Enabled := not Value;
  btnStop.Enabled := Value;
  clbParsers.Enabled := not Value;
  rgMode.Enabled := not Value;
  edServer.Enabled := not Value;
  edUser.Enabled := not Value;
end;

procedure TfrmParsersMain.btnStopClick(Sender: TObject);
begin
  fStopRequested := True;
  if Assigned(fCurrentJob) then
    fCurrentJob.Cancel;
  lblStatus.Caption := 'Se opreste dupa cererea curenta...';
end;

procedure TfrmParsersMain.btnRunClick(Sender: TObject);
var
  Classes: TArray<TParserJobClass>;
  Options: TParserRunOptions;
  Connection: TIBCConnection;
  I, Selected: Integer;
begin
  Classes := ParserJobs;
  Selected := 0;
  for I := 0 to clbParsers.Items.Count - 1 do
    if clbParsers.Checked[I] then
      Inc(Selected);
  if Selected = 0 then
  begin
    MessageDlg('Bifati cel putin un job.', mtInformation, [mbOK], 0);
    Exit;
  end;

  Options := TParserRunOptions.Defaults;
  Options.ReadCommandLine;
  Options.Server := Trim(edServer.Text);
  Options.UserID := StrToIntDef(Trim(edUser.Text), Options.UserID);
  if rgMode.ItemIndex = 1 then
    Options.Mode := hsmReevaluation
  else
    Options.Mode := hsmDirectUpdate;

  if MessageDlg(Format('Se ruleaza %d job(uri) pe serverul %s si se scrie in baza. Continuati?',
    [Selected, Options.Server]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  mmLog.Lines.Clear;
  fStopRequested := False;
  SetRunning(True);
  try
    try
      Connection := CreateParserConnection(Options.Server);
    except
      on E: Exception do
      begin
        AddLog('Conectarea la baza a esuat: ' + E.Message);
        Exit;
      end;
    end;
    try
      for I := 0 to High(Classes) do
      begin
        if fStopRequested then
          Break;
        if not clbParsers.Checked[I] then
          Continue;
        lblStatus.Caption := 'Ruleaza: ' + Classes[I].DisplayName;
        try
          RunParserJob(Connection, Classes[I], Options,
            procedure(const AMessage: string)
            begin
              AddLog(AMessage);
            end,
            procedure(AJob: TParserJob)
            begin
              fCurrentJob := AJob;
            end);
        except
          // eroarea e deja in jurnal; trecem la jobul urmator
        end;
      end;
    finally
      Connection.Free;
    end;
    if fStopRequested then
      lblStatus.Caption := 'Oprit.'
    else
      lblStatus.Caption := 'Gata. Jurnalele sint in ' + Options.LogDir;
  finally
    fCurrentJob := nil;
    SetRunning(False);
  end;
end;

end.

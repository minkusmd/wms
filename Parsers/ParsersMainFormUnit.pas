unit ParsersMainFormUnit;

{ WMSParsers - fereastra principala: alegi joburile, modul de scriere si le rulezi in paralel
  (fiecare job in firul lui, cu conexiunea lui). Aceeasi rulare, fara fereastra, o face modul /auto
  (vezi WMSParsers.dpr). }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst, System.SyncObjs,
  System.Generics.Collections, SupplierPriceSyncUnit, ParserJobUnit;

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
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRunClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    fRunning: Boolean;
    fStopRequested: Boolean;
    // joburile care ruleaza (adaugate / scoase din firele lor)
    fJobs: TList<TParserJob>;
    fJobsLock: TCriticalSection;
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
  fJobs := TList<TParserJob>.Create;
  fJobsLock := TCriticalSection.Create;
  OnDestroy := FormDestroy;
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

procedure TfrmParsersMain.FormDestroy(Sender: TObject);
begin
  fJobs.Free;
  fJobsLock.Free;
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
var
  Job: TParserJob;
begin
  fStopRequested := True;
  fJobsLock.Enter;
  try
    for Job in fJobs do
      Job.Cancel;
  finally
    fJobsLock.Leave;
  end;
  lblStatus.Caption := 'Se opreste dupa cererile curente...';
end;

procedure TfrmParsersMain.btnRunClick(Sender: TObject);
var
  Classes, Selected: TArray<TParserJobClass>;
  Options: TParserRunOptions;
  Outcomes: TArray<TParserJobOutcome>;
  I, Failed: Integer;
begin
  Classes := ParserJobs;
  Selected := nil;
  for I := 0 to clbParsers.Items.Count - 1 do
    if clbParsers.Checked[I] then
      Selected := Selected + [Classes[I]];
  if Length(Selected) = 0 then
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

  if MessageDlg(Format('Se ruleaza %d job(uri) in paralel pe serverul %s si se scrie in baza. Continuati?',
    [Length(Selected), Options.Server]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  mmLog.Lines.Clear;
  fStopRequested := False;
  SetRunning(True);
  try
    lblStatus.Caption := Format('Ruleaza %d job(uri) in paralel...', [Length(Selected)]);
    Outcomes := RunParserJobsParallel(Selected, Options,
      // din firele joburilor: liniile ajung pe ecran prin firul principal
      procedure(const AMessage: string)
      var
        Line: string;
      begin
        Line := AMessage;
        TThread.Queue(nil,
          procedure
          begin
            AddLog(Line);
          end);
      end,
      procedure(AJob: TParserJob)
      begin
        fJobsLock.Enter;
        try
          fJobs.Add(AJob);
          if fStopRequested then
            AJob.Cancel;
        finally
          fJobsLock.Leave;
        end;
      end,
      procedure(AJob: TParserJob)
      begin
        fJobsLock.Enter;
        try
          fJobs.Remove(AJob);
        finally
          fJobsLock.Leave;
        end;
      end,
      procedure
      begin
        Application.ProcessMessages;
      end);
    // liniile ramase in coada
    CheckSynchronize;

    Failed := 0;
    for I := 0 to High(Outcomes) do
      if Outcomes[I].Error <> '' then
        Inc(Failed);
    if fStopRequested then
      lblStatus.Caption := 'Oprit.'
    else
      lblStatus.Caption := Format('Gata: %d job(uri), %d cu erori. Jurnalele sint in %s',
        [Length(Outcomes), Failed, Options.LogDir]);
  finally
    fJobsLock.Enter;
    try
      fJobs.Clear;
    finally
      fJobsLock.Leave;
    end;
    SetRunning(False);
  end;
end;

end.

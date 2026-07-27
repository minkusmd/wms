unit frmWebMailingSenderProcessWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  WebMailingSenderUnit, WebMailingTypesUnit;

type
  TfrmWebMailingSenderProcessWin = class(TForm)
    Bevel1: TBevel;
    pbProgressBar: TProgressBar;
    btnStop: TButton;
    mmLog: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    FMailingID: Integer;
    fSender: TWebMailingSender;
    fError: Boolean;
    fCanceled: Boolean;
    procedure SetMailingID(const Value: Integer);

    procedure WhenStartSending(const TotalRecipients: Integer);
    procedure WhenProgressChanged(const SentRecipients: Integer);
    procedure WhenFinish(Sender: TObject);
    procedure WhenCloseWindow(Sender: TObject);
    procedure WhenGetError(const ErrorText: String);

    function ChangeMailingState(const NewState: Integer): Boolean;
  public
    { Public declarations }
    property MailingID: Integer read FMailingID write SetMailingID;

  end;

implementation

{$R *.dfm}

uses DataModuleDB, SWNUtils, IBC;

const
  cState_Finished = 3;
  cState_ReadyToSend = 1;

procedure TfrmWebMailingSenderProcessWin.btnStopClick(Sender: TObject);
begin
  fSender.Suspended := True;
  if ShowAskDialog('Distributie', 'Doriti sa stopati distributia pe email?') <> mrYes then
    Exit;
  fSender.Suspended := False;

  btnStop.Enabled := False;
  mmLog.Lines.Add('Stopam distributia...');
  fCanceled := True;
  fSender.Terminate;
end;

procedure TfrmWebMailingSenderProcessWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmWebMailingSenderProcessWin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fSender.JobFinished;
end;

procedure TfrmWebMailingSenderProcessWin.FormCreate(Sender: TObject);
begin
  fCanceled := False;
  fError := False;

  fSender := TWebMailingSender.Create(dmDB.IBCConnection);
  fSender.OnStartSending := WhenStartSending;
  fSender.OnProgress := WhenProgressChanged;
  fSender.OnTerminate := WhenFinish;
  fSender.OnError := WhenGetError;
end;

procedure TfrmWebMailingSenderProcessWin.FormDestroy(Sender: TObject);
begin
  if Not fSender.JobFinished then
  begin
    fSender.Terminate;
    fSender.WaitFor;
  end;
  fSender.Free;
end;

procedure TfrmWebMailingSenderProcessWin.FormShow(Sender: TObject);
begin
  if fSender.LoadMailing(FMailingID, nil) then
  begin
    Caption := Format('Distribui "%s"...', [fSender.MailingTitle]);
    mmLog.Lines.Add(Format('Distributia email: "%s"', [fSender.MailingTitle]));
    fSender.Start;
  end
  else
  begin
    fError := True;
    mmLog.Lines.Add('Eroare! Nu este posibil de incarcat datele.');
    btnStop.Caption := 'Inchide';
    btnStop.OnClick := WhenCloseWindow;
  end;
end;

function TfrmWebMailingSenderProcessWin.ChangeMailingState(const NewState: Integer): Boolean;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  Transaction := TIBCTransaction.Create(nil);
  try
    Transaction.DefaultConnection := dmDB.IBCConnection;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := Transaction;
    Query.AutoCommit := False;
    Query.SQL.Text := 'UPDATE TWEB_MAILINGS SET STATE=:state WHERE MAILINGID=:id';
    Query.ParamByName('id').AsInteger := FMailingID;
    Query.ParamByName('state').AsInteger := NewState;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
      end;
    end;
  finally
    Query.Free;
    Transaction.Free;
  end;
end;

procedure TfrmWebMailingSenderProcessWin.SetMailingID(const Value: Integer);
begin
  FMailingID := Value;
end;

procedure TfrmWebMailingSenderProcessWin.WhenCloseWindow(Sender: TObject);
begin
  Close;
end;

procedure TfrmWebMailingSenderProcessWin.WhenFinish(Sender: TObject);
var
  N: Integer;
begin
  N := fSender.GetTotalSent;
  pbProgressBar.Position := N;
  mmLog.Lines.Add(Format('Total expediate: %d.', [N]));
  mmLog.Lines.Add(Format('Timpul: %dms', [fSender.GetTotalTime]));
  mmLog.Lines.Add('Finisat!');
  btnStop.Enabled := True;
  btnStop.Caption := 'Inchide';
  btnStop.OnClick := WhenCloseWindow;

  if Not(fCanceled or fError) then
  begin
    if ChangeMailingState(cState_Finished) then
      mmLog.Lines.Add('Distributie setata ca finisata!')
    else
      mmLog.Lines.Add('Eroare! Nu pot inchide distributie.');
  end
  else if fCanceled then
  begin
    if ChangeMailingState(cState_ReadyToSend) then
      mmLog.Lines.Add('Aceasta distributie poate fi efectuata mai tirziu.')
    else
      mmLog.Lines.Add('Eroare! Nu pot schimba statutul expeditiei.');
  end;
end;

procedure TfrmWebMailingSenderProcessWin.WhenGetError(const ErrorText: String);
begin
  fError := True;
  mmLog.Lines.Add(Format('Eroare: %s', [ErrorText]));
  mmLog.Lines.Add('Proces stopat!');
end;

procedure TfrmWebMailingSenderProcessWin.WhenProgressChanged(const SentRecipients: Integer);
begin
  pbProgressBar.Position := SentRecipients;
end;

procedure TfrmWebMailingSenderProcessWin.WhenStartSending(const TotalRecipients: Integer);
begin
  pbProgressBar.Max := TotalRecipients;
  mmLog.Lines.Add(Format('Total receptioneri: %d.', [TotalRecipients]));
  mmLog.Lines.Add('Distribui...');
end;

end.

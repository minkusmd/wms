unit frmServiceContinueIncidentDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, IBC, DB,
  DBAccess, MemDS, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, StdCtrls, ExtCtrls, ControlGroup, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmServiceContinueIncidentDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryIncidents: TIBCQuery;
    IBCDataSourceIncidents: TIBCDataSource;
    pnClient: TPanel;
    btnCancel: TButton;
    btnFinish: TButton;
    cgIncident: TControlGroup;
    cgDescription: TControlGroup;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edTYPE_TITLE: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    edSN: TcxDBTextEdit;
    edGOODS_MODEL: TcxDBTextEdit;
    edCUSTOMER_FULLNAME: TcxDBTextEdit;
    mmText: TMemo;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFinishClick(Sender: TObject);
  private
    { Private declarations }
    FIncidentID: integer;
    procedure SetIncidentID(const Value: integer);
    procedure LockIncident;
    procedure DoActionDB_ContinueIncident(const IID: integer; const Comments: string);
    procedure DoActionDB_ReadPreviuosIncidentComments(const IncidentID: integer);
    function CheckParams: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property IncidentID: integer read FIncidentID write SetIncidentID;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}

{ TfrmServiceContinueIncidentDlg }

procedure TfrmServiceContinueIncidentDlg.btnFinishClick(Sender: TObject);
begin
  if CheckParams then
  begin
    DoActionDB_ContinueIncident(FIncidentID, Trim(mmText.Text));
    dmDB.IBCTrDefaultUpdate.Commit;

    ModalResult := mrOk;
  end;
end;

function TfrmServiceContinueIncidentDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  if Trim(mmText.Lines.Text) = '' then
    AddErrorToStr(ErrorStr, 'Причина продолжения инцидента!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceContinueIncidentDlg.DoActionDB_ContinueIncident(const IID: integer; const Comments: string);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_RESTART_INCIDENT(:IID,:COMMENTS)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ParamByName('COMMENTS').AsString := Comments;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceContinueIncidentDlg.DoActionDB_ReadPreviuosIncidentComments(const IncidentID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'SELECT COMMENTS FROM TDB_SC_INCIDENT_COMMENT WHERE IID=:IID';
    Query.ParamByName('IID').AsInteger := IncidentID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      mmText.Lines.Text := Query.Fields[0].AsString;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceContinueIncidentDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    dmDB.IBCTrDefaultUpdate.Rollback;
  end;
end;

procedure TfrmServiceContinueIncidentDlg.FormCreate(Sender: TObject);
begin
  FIncidentID := -1;
end;

procedure TfrmServiceContinueIncidentDlg.LockIncident;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_LOCK_INCIDENT(:IID)';
    Query.ParamByName('IID').AsInteger := FIncidentID;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceContinueIncidentDlg.Prepare;
begin
  if FIncidentID = -1 then
    raise Exception.Create('Не установлен номер инцидента!');

  dmDB.IBCTrDefaultUpdate.StartTransaction;
  try
    LockIncident;
    IBCQueryIncidents.ParamByName('IID').AsInteger := FIncidentID;
    IBCQueryIncidents.Active := True;

    DoActionDB_ReadPreviuosIncidentComments(FIncidentID);

  except
    dmDB.IBCTrDefaultUpdate.Rollback;
    raise;
  end;
end;

procedure TfrmServiceContinueIncidentDlg.SetIncidentID(const Value: integer);
begin
  FIncidentID := Value;
end;

end.


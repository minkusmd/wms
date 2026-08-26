unit frame38ServiceFinishedIncidentsUnit;
{
 СЕРВИС - Решённые инциденты
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseFrameUnit, Dialogs, cxClasses, dxBar,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, DBAccess, IBC, MemDS,
  cxImageComboBox, cxCheckBox, cxCurrencyEdit, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator;

type
  Tframe38ServiceFinishedIncidents = class(TSWNBaseFrame)
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    pnClient: TPanel;
    pnBottom: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    cxGridIncidentsDBTableView: TcxGridDBTableView;
    cxGridIncidentsLevel: TcxGridLevel;
    cxGridIncidents: TcxGrid;
    cxGridCalls: TcxGrid;
    cxGridCallsDBTableView: TcxGridDBTableView;
    cxGridCallsLevel: TcxGridLevel;
    bbCloseIncident: TdxBarButton;
    bbNewCall: TdxBarButton;
    bbModifyCall: TdxBarButton;
    bbRemoveCall: TdxBarButton;
    cxGridCallsDB_CALL_TIME: TcxGridDBColumn;
    cxGridCallsDB_PHONE: TcxGridDBColumn;
    cxGridCallsDB_COMMENTS: TcxGridDBColumn;
    cxGridCallsDB_PICKUP_DATE: TcxGridDBColumn;
    cxGridIncidentsDB_IID: TcxGridDBColumn;
    cxGridIncidentsDB_CUSTOMER_FULLNAME: TcxGridDBColumn;
    cxGridIncidentsDB_TYPE_NAME: TcxGridDBColumn;
    cxGridIncidentsDB_DATA: TcxGridDBColumn;
    cxGridIncidentsDB_GOODS_NAME: TcxGridDBColumn;
    cxGridIncidentsDB_STATUS_TITLE: TcxGridDBColumn;
    cxGridIncidentsDB_SN: TcxGridDBColumn;
    bbRestartIncident: TdxBarButton;
    cxGridCallsDB_USER_FULLNAME: TcxGridDBColumn;
    IBCQueryIncidents: TIBCQuery;
    IBCDataSourceIncidents: TIBCDataSource;
    cxGridIncidentsDB_FLG_CLIENT_INFORMED: TcxGridDBColumn;
    IBCQueryCalls: TIBCQuery;
    IBCDataSourceCalls: TIBCDataSource;
    cxGridCallsDB_CALL_RESULT_TEXT: TcxGridDBColumn;
    procedure bbCloseIncidentClick(Sender: TObject);
    procedure bbRestartIncidentClick(Sender: TObject);
    procedure bbNewCallClick(Sender: TObject);
    procedure bbModifyCallClick(Sender: TObject);
    procedure bbRemoveCallClick(Sender: TObject);
    procedure cxGridCallsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridIncidentsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    procedure WhenGlobalDateTimeFilterChanged(Sender: TObject);
    procedure OpenData;
    procedure IncidentSelectionChanged;
    procedure ShowCloseIncidentDialog;
    procedure ShowContinueIncidentDialog;
    procedure CallSelectionChanged;
    procedure ShowNewCallDialog;
    procedure ShowModifyCallDialog;
    procedure ShowDeleteCall;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow; override;
    procedure DoFrameHide; override;
  public
    { Public declarations }
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, frmServiceCloseIncidentDialog, frmServiceContinueIncidentDialog,
  frmIncidentCallDialog, SWNUtils, SWNDBErrors, SWNConst;

{$R *.dfm}

{ Tframe38ServiceFinishedIncidents }

procedure Tframe38ServiceFinishedIncidents.bbCloseIncidentClick(Sender: TObject);
begin
  ShowCloseIncidentDialog;
end;

procedure Tframe38ServiceFinishedIncidents.bbModifyCallClick(Sender: TObject);
begin
  ShowModifyCallDialog;
end;

procedure Tframe38ServiceFinishedIncidents.bbNewCallClick(Sender: TObject);
begin
  ShowNewCallDialog;
end;

procedure Tframe38ServiceFinishedIncidents.bbRemoveCallClick(Sender: TObject);
begin
  ShowDeleteCall;
end;

procedure Tframe38ServiceFinishedIncidents.CallSelectionChanged;
var
  fNew, fModify, fDelete: Boolean;
begin
  fNew := False;
  fModify := False;
  fDelete := False;
  if cxGridIncidentsDBTableView.DataController.RecNo > 0 then
  begin
    fNew := True;

    if cxGridCallsDBTableView.DataController.RecNo > 0 then
    begin
      fModify := True;
      fDelete := True;
    end;
  end;
     // buttons
  bbNewCall.Enabled := fNew;
  bbModifyCall.Enabled := fModify;
  bbRemoveCall.Enabled := fDelete;
end;

procedure Tframe38ServiceFinishedIncidents.cxGridCallsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  CallSelectionChanged;
end;

procedure Tframe38ServiceFinishedIncidents.cxGridIncidentsDBTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  IncidentSelectionChanged;
end;

procedure Tframe38ServiceFinishedIncidents.DoFrameHide;
begin
  dmDB.OnDateFilterChanged := nil;

  IBCQueryCalls.Active := False;
  IBCQueryIncidents.Active := False;

  inherited;
end;

procedure Tframe38ServiceFinishedIncidents.DoFrameShow;
begin
  inherited;

  dmDB.OnDateFilterChanged := WhenGlobalDateTimeFilterChanged;

  OpenData;
  IncidentSelectionChanged;
end;

procedure Tframe38ServiceFinishedIncidents.bbRestartIncidentClick(Sender: TObject);
begin
  ShowContinueIncidentDialog;
end;

function Tframe38ServiceFinishedIncidents.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe38ServiceFinishedIncidents.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

procedure Tframe38ServiceFinishedIncidents.IncidentSelectionChanged;
var
  fClose, fRestart: boolean;
begin
  fClose := False;
  fRestart := False;

  if cxGridIncidentsDBTableView.DataController.RecNo > 0 then
  begin
    fClose := True;
    fRestart := True;
  end;
     // buttons
  bbCloseIncident.Enabled := fClose;
  bbRestartIncident.Enabled := fRestart;

  CallSelectionChanged;
end;

function Tframe38ServiceFinishedIncidents.InitFrameID: integer;
begin
  Result := 38; // СЕРВИС - Решённые инциденты
end;

procedure Tframe38ServiceFinishedIncidents.OpenData;
var
  S: string;
begin
  IBCQueryCalls.Active := False;
  IBCQueryIncidents.Active := False;

  S := '';
  if dfiDATE1 in dmDB.CurrentDocsFilters then
  begin
    if (dfiDATE1 in dmDB.CurrentDocsFilters) and (dfiDATE2 in dmDB.CurrentDocsFilters) then
      S := '(CAST(DATA_FINISHED AS DATE)>=:DateRange1) and (CAST(DATA_FINISHED AS DATE)<=:DateRange2)'
    else
      S := '(CAST(DATA_FINISHED AS DATE)>=:DateRange1)';
  end;
  IBCQueryIncidents.FilterSQL := S;

  if dfiDATE1 in dmDB.CurrentDocsFilters then
    IBCQueryIncidents.ParamByName('DateRange1').AsDate := dmDB.CurrentFilterDateRange1;
  if dfiDATE2 in dmDB.CurrentDocsFilters then
    IBCQueryIncidents.ParamByName('DateRange2').AsDate := dmDB.CurrentFilterDateRange2;

  IBCQueryIncidents.Active := True;
  IBCQueryCalls.Active := True;
end;

procedure Tframe38ServiceFinishedIncidents.ShowCloseIncidentDialog;
var
  dialog: TfrmServiceCloseIncidentDlg;
begin
  dialog := TfrmServiceCloseIncidentDlg.Create(Self);
  try
    dialog.IncidentID := IBCQueryIncidents.FieldByName('IID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryIncidents.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.ShowContinueIncidentDialog;
var
  dialog: TfrmServiceContinueIncidentDlg;
begin
  dialog := TfrmServiceContinueIncidentDlg.Create(Self);
  try
    dialog.IncidentID := IBCQueryIncidents.FieldByName('IID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryIncidents.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.ShowDeleteCall;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Вы хотите удалить запись о звонке от ' + IBCQueryCalls.FieldByName
    ('CALL_TIME').AsString + '?') = mrYes then
  begin
    try
      IBCQueryCalls.Delete;
      IBCQueryCalls.UpdateTransaction.Commit;
      IBCQueryIncidents.Refresh;
    except
      on E: Exception do
      begin
        IBCQueryCalls.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;

  end;
end;

procedure Tframe38ServiceFinishedIncidents.ShowModifyCallDialog;
var
  dialog: TfrmIncidentCallDlg;
begin
  dialog := TfrmIncidentCallDlg.Create(Self, IBCQueryIncidents, IBCQueryCalls, IBCDataSourceIncidents, IBCDataSourceCalls);
  try
    dialog.CreateNewCall := False;
    if dialog.ShowModal = mrOk then
      IBCQueryIncidents.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.ShowNewCallDialog;
var
  dialog: TfrmIncidentCallDlg;
begin
  dialog := TfrmIncidentCallDlg.Create(Self, IBCQueryIncidents, IBCQueryCalls, IBCDataSourceIncidents, IBCDataSourceCalls);
  try
    dialog.CreateNewCall := True;
    if dialog.ShowModal = mrOk then
      IBCQueryIncidents.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe38ServiceFinishedIncidents.WhenGlobalDateTimeFilterChanged(Sender: TObject);
begin
  OpenData;
end;

end.


unit frame37ServiceDispatcherUnit;
{
 СЕРВИС - Диспетчер сервиса
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, SWNBaseFrameUnit, ComCtrls,
  cxStyles, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxTextEdit, cxMemo, cxDBEdit, StdCtrls, ExtCtrls, DBAccess, IBC, MemDS, CheckLst, dxBar, Buttons,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxGridLevel;

type
  Tframe37ServiceDispatcher = class(TSWNBaseFrame)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    cxGridTasks: TcxGrid;
    cxGridTasksDBTable: TcxGridDBTableView;
    cxGridTasksDB_DATA_ASSIGN: TcxGridDBColumn;
    cxGridTasksDB_TYPE_TITLE: TcxGridDBColumn;
    cxGridTasksDB_STATUS_TITLE: TcxGridDBColumn;
    cxGridTasksDB_ASSIGNED_USER_NAME: TcxGridDBColumn;
    cxGridTasksLevel: TcxGridLevel;
    cxGridTasksDB_TYPE_TITLE_1: TcxGridDBColumn;
    cxGridTasksDB_PRIORITY: TcxGridDBColumn;
    cxGridTasksDB_DATA_ESTIMATED_FINISH: TcxGridDBColumn;
    IBCDataSourceTasks: TIBCDataSource;
    IBCQueryTasks: TIBCQuery;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbEndTask: TdxBarButton;
    dxBarButton6: TdxBarButton;
    cxGridTasksDB_IID: TcxGridDBColumn;
    bbRefresh: TdxBarButton;
    pnTaskFilters: TPanel;
    Label3: TLabel;
    sbPreset_AllTasks: TSpeedButton;
    Label7: TLabel;
    sbPreset_NewGoods: TSpeedButton;
    sbPreset_CurrentTasks: TSpeedButton;
    sbPreset_CriticalTasks: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cxGridTasksDB_STATUS_ID: TcxGridDBColumn;
    sbPreset_NewAssignment: TSpeedButton;
    Label1: TLabel;
    cxGridTasksDBTableColumn1: TcxGridDBColumn;
    dxBarPopupMenuTask: TdxBarPopupMenu;
    bbGotoClientServiceCard: TdxBarButton;
    procedure sbPreset_AllTasksClick(Sender: TObject);
    procedure sbPreset_NewGoodsClick(Sender: TObject);
    procedure sbPreset_CurrentTasksClick(Sender: TObject);
    procedure sbPreset_CriticalTasksClick(Sender: TObject);
    procedure cxGridTasksDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure sbPreset_NewAssignmentClick(Sender: TObject);
    procedure bbRefreshClick(Sender: TObject);
    procedure bbEndTaskClick(Sender: TObject);
    procedure cxGridTasksDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure dxBarPopupMenuTaskPopup(Sender: TObject);
    procedure bbGotoClientServiceCardClick(Sender: TObject);
  private
    { Private declarations }
    fLastTaskStatus, fLastTaskType: array of integer;
    procedure TaskSelectionChanged;
    procedure TaskPopupMenuOpen;
    procedure WhenGlobalDateTimeFilterChnaged(Sender: TObject);
    procedure SetCustomFilter(const TaskStatus: array of integer; const TaskType: array of integer);
    procedure RefreshAllData;
    procedure ShowEndTaskDialog;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow; override;
    procedure DoFrameHide; override;
  public
    { Public declarations }
    function HasDocID: Boolean; override;
  end;

implementation

uses
  DataModuleAdditions, frmServiceEndTaskDialog, DataModuleDB, frame36ServiceCardClientUnit;

{$R *.dfm}

{ Tframe37ServiceDispatcher }

procedure Tframe37ServiceDispatcher.bbEndTaskClick(Sender: TObject);
begin
  ShowEndTaskDialog;
end;

procedure Tframe37ServiceDispatcher.bbGotoClientServiceCardClick(Sender: TObject);
var
  SCCFrame: Tframe36ServiceCardClient;
  CustID: Integer;
begin
  CustID := IBCQueryTasks.FieldByName('I_CUSTOMERID').AsInteger;
  SCCFrame := Tframe36ServiceCardClient(SWNFrameManager.GoToFrame(36));
  if Assigned(SCCFrame) then
    SCCFrame.SelectCustomer(CustID);
end;

procedure Tframe37ServiceDispatcher.bbRefreshClick(Sender: TObject);
begin
  RefreshAllData;
end;

procedure Tframe37ServiceDispatcher.cxGridTasksDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  TaskSelectionChanged;
end;

procedure Tframe37ServiceDispatcher.cxGridTasksDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  TaskStatus: integer;
begin
     // Status sarcini in service
     // 6301 - In asteptare
     // 6302 - In executare

  TaskStatus := ARecord.Values[cxGridTasksDB_STATUS_ID.Index];
  case TaskStatus of
    6301:
      AStyle := dmAdditions.cxStyle_TextColorRed;
    6302:
      AStyle := dmAdditions.cxStyle_TextColorGreen;
    6303:
      AStyle := dmAdditions.cxStyle_TextGray;
  end
end;

procedure Tframe37ServiceDispatcher.DoFrameHide;
begin
  IBCQueryTasks.Active := False;
  dmDB.OnDateFilterChanged := nil;

  inherited;
end;

procedure Tframe37ServiceDispatcher.DoFrameShow;
begin
  inherited;

  dmDB.OnDateFilterChanged := WhenGlobalDateTimeFilterChnaged;

  if (Length(fLastTaskType) = 0) or (Length(fLastTaskStatus) = 0) then
    sbPreset_NewGoodsClick(sbPreset_NewGoods) //sbPreset_AllTasksClick(sbPreset_AllTasks)
  else
    IBCQueryTasks.Active := True;
  cxGridTasksDBTable.DataController.Groups.FullExpand;

  TaskSelectionChanged;
end;

procedure Tframe37ServiceDispatcher.dxBarPopupMenuTaskPopup(Sender: TObject);
begin
  TaskPopupMenuOpen;
end;

function Tframe37ServiceDispatcher.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe37ServiceDispatcher.GetFrameButtons: TFrameButtons;
begin
  Result := [];
end;

function Tframe37ServiceDispatcher.HasDocID: Boolean;
begin
  Result := False;
end;

function Tframe37ServiceDispatcher.InitFrameID: integer;
begin
  Result := 37; // SERVICE - Dispecer service
end;

procedure Tframe37ServiceDispatcher.RefreshAllData;
begin
  IBCQueryTasks.Refresh;
end;

procedure Tframe37ServiceDispatcher.sbPreset_AllTasksClick(Sender: TObject);
begin
  SetCustomFilter([], []);
end;

procedure Tframe37ServiceDispatcher.sbPreset_CriticalTasksClick(Sender: TObject);
begin
     // Status sarcini in service
     // 6301 - In asteptare
     // 6302 - In executare

     // Tipuri de sarcini in service
     // 6201 - Primire marfa
     // 6202 - Distribuire pentru deservire (reparatie)
     // 6203 - Deservire (reparatie) marfa

  SetCustomFilter([6301, 6302], [6201, 6202, 6203]);
end;

procedure Tframe37ServiceDispatcher.sbPreset_CurrentTasksClick(Sender: TObject);
begin
     // Status sarcini in service
     // 6301 - In asteptare
     // 6302 - In executare

     // Tipuri de sarcini in service
     // 6202 - Distribuire pentru deservire (reparatie)
     // 6203 - Deservire (reparatie) marfa
     // 6210 - Возврат товара поставщику
     // 6211 - Возврат товара от поставщика
     // 6220 - Приход запасных частей
     // 6230 - Транспортировка товара

  SetCustomFilter([6301, 6302], [6202, 6203, 6210, 6211, 6220, 6230]);
end;

procedure Tframe37ServiceDispatcher.sbPreset_NewAssignmentClick(Sender: TObject);
begin
     // Status sarcini in service
     // 6301 - In asteptare

     // Tipuri de sarcini in service
     // 6202 - Distribuire pentru deservire (reparatie)

  SetCustomFilter([6301], [6202]);
end;

procedure Tframe37ServiceDispatcher.sbPreset_NewGoodsClick(Sender: TObject);
begin
     // Status sarcini in service
     // 6301 - In asteptare

     // Tipuri de sarcini in service
     // 6201 - Primire marfa

  SetCustomFilter([6301], [6201]);
end;

procedure Tframe37ServiceDispatcher.SetCustomFilter(const TaskStatus, TaskType: array of integer);
var
  i: integer;
  S: string;
begin
  S := '';

  SetLength(fLastTaskStatus, Length(TaskStatus));
  if Length(TaskStatus) > 0 then
  begin
    S := S + 'VW_TDB_SC_TASKS.STATUS_ID in (';
    for i := Low(TaskStatus) to High(TaskStatus) do
    begin
      fLastTaskStatus[i] := TaskStatus[i];
      if i = High(TaskStatus) then
        S := S + IntToStr(TaskStatus[i])
      else
        S := S + IntToStr(TaskStatus[i]) + ',';
    end;
    S := S + ')';
  end;

  SetLength(fLastTaskType, Length(TaskType));
  if Length(TaskType) > 0 then
  begin
    if S <> '' then
      S := S + ' AND ';
    S := S + 'VW_TDB_SC_TASKS.TYPE_ID in (';
    for i := Low(TaskType) to High(TaskType) do
    begin
      fLastTaskType[i] := TaskType[i];
      if i = High(TaskType) then
        S := S + IntToStr(TaskType[i])
      else
        S := S + IntToStr(TaskType[i]) + ',';
    end;
    S := S + ')';
  end;

  IBCQueryTasks.Active := False;
     // date time filter
  if dfiDATE1 in dmDB.CurrentDocsFilters then
  begin
    if S <> '' then
      S := S + ' AND ';
    if (dfiDATE1 in dmDB.CurrentDocsFilters) and (dfiDATE2 in dmDB.CurrentDocsFilters) then
      S := S + '(CAST(DATA_ASSIGN AS DATE)>=:DateRange1) AND (CAST(DATA_ASSIGN AS DATE)<=:DateRange2)'
    else
      S := S + '(CAST(DATA_ASSIGN AS DATE)=:DateRange1)';
  end;

     // finally
  IBCQueryTasks.FilterSQL := S;

     // and params
  if dfiDATE1 in dmDB.CurrentDocsFilters then
    IBCQueryTasks.ParamByName('DateRange1').AsDate := dmDB.CurrentFilterDateRange1;
  if dfiDATE2 in dmDB.CurrentDocsFilters then
    IBCQueryTasks.ParamByName('DateRange2').AsDate := dmDB.CurrentFilterDateRange2;

  IBCQueryTasks.Active := True;
end;

procedure Tframe37ServiceDispatcher.ShowEndTaskDialog;
var
  dialog: TfrmServiceEndTaskDlg;
begin
  dialog := TfrmServiceEndTaskDlg.Create(Self, IBCQueryTasks, IBCDataSourceTasks);
  try
    if dialog.ShowModal = mrOk then
      IBCQueryTasks.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe37ServiceDispatcher.TaskPopupMenuOpen;
var
  fGotoCSC: Boolean;
begin
  fGotoCSC := False;
  if cxGridTasksDBTable.DataController.RecNo > 0 then
  begin
    fGotoCSC := True;
  end;
  bbGotoClientServiceCard.Enabled := fGotoCSC;
end;

procedure Tframe37ServiceDispatcher.TaskSelectionChanged;
var
  fEndTask: Boolean;
begin
  fEndTask := False;
  if cxGridTasksDBTable.DataController.RecNo > 0 then
  begin
    fEndTask := IBCQueryTasks.FieldByName('STATUS_ID').AsInteger <> 6303; // Задача завершенна
  end;

  bbEndTask.Enabled := fEndTask;
end;

procedure Tframe37ServiceDispatcher.WhenGlobalDateTimeFilterChnaged(Sender: TObject);
begin
  SetCustomFilter(fLastTaskStatus, fLastTaskType);
end;

end.


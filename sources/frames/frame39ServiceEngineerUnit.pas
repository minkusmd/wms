unit frame39ServiceEngineerUnit;
{
  СЕРВИС. Инжинер сервиса
  DocTypeID = 1408
  Frame Index = 39
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SWNDataFiltering, SWNBaseFrameUnit,
  ComCtrls, ExtCtrls, cxGraphics,
  cxSplitter, cxStyles, cxTL,
  dxBar, cxDBTL,
  DB, MemDS, DBAccess, IBC, cxDBData,
  cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid,
  cxDBVGrid,

  cxGridPopupMenu,
  dxBarExtDBItems, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCurrencyEdit, cxCheckBox, cxLabel,
  cxMaskEdit, cxTLdxBarBuiltInMenu, dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxVGrid, cxInplaceContainer,
  cxTLData, cxGridTableView, cxGridCustomView, dxUIAClasses;

type
  Tframe39ServiceEngineer = class(TSWNBaseFrame)
    pnRight: TPanel;
    cxDBTreeListTask: TcxDBTreeList;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    IBCDataSourceTask: TIBCDataSource;
    IBCQueryTask: TIBCQuery;
    pnClient: TPanel;
    cxSplitter1: TcxSplitter;
    cxGridIncidentTable: TcxGridDBTableView;
    cxGridIncidentLevel: TcxGridLevel;
    cxGridIncident: TcxGrid;
    cxGridIncident_INCIDENTID: TcxGridDBColumn;
    cxGridIncident_DOC_CUSTOMER: TcxGridDBColumn;
    cxGridIncident_GOODS_TITLE: TcxGridDBColumn;
    cxGridIncident_GOODS_MODEL: TcxGridDBColumn;
    cxGridIncident_VENDOR_TITLE: TcxGridDBColumn;
    cxGridIncident_GOODS_SN: TcxGridDBColumn;
    cxDBTreeListTaskcxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeListTaskcxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeListTaskcxDBTreeListColumn3: TcxDBTreeListColumn;
    cxDBTreeListTaskcxDBTreeListColumn4: TcxDBTreeListColumn;
    bbTaskNew: TdxBarButton;
    pnBottom: TPanel;
    pcPageControlDocs: TPageControl;
    tbsIncidentRashod: TTabSheet;
    cxSplitter2: TcxSplitter;
    pnTop: TPanel;
    cxDBTreeListTaskcxDBTreeListColumn5: TcxDBTreeListColumn;
    dxBarDockControlIncidents: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    dxBarDockControlRashod: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    dxBarManagerBar4: TdxBar;
    dxBarManagerBarAkt: TdxBar;
    cxGridDocGoodsTable: TcxGridDBTableView;
    cxGridDocGoodsLevel: TcxGridLevel;
    cxGridDocGoods: TcxGrid;
    cxGridRashod_DTDEP_NAME: TcxGridDBColumn;
    cxGridRashod_GOODSID: TcxGridDBColumn;
    cxGridRashod_GOODS_NAME: TcxGridDBColumn;
    cxGridRashod_QTY: TcxGridDBColumn;
    cxGridRashod_UM_NAME: TcxGridDBColumn;
    cxGridRashod_PRICE: TcxGridDBColumn;
    cxGridRashod_SUMA: TcxGridDBColumn;
    cxGridRashod_FLG_ACTIVE: TcxGridDBColumn;
    cxGridRashod_FLG_READY: TcxGridDBColumn;
    bbRashodGoodsAdd: TdxBarButton;
    bbRashodEdit: TdxBarButton;
    bbRashodDelete: TdxBarButton;
    bbRashodSN: TdxBarButton;
    cxDBVerticalGrid2: TcxDBVerticalGrid;
    cxDBVerticalGrid2DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow3: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow4: TcxDBEditorRow;
    cxDBVerticalGrid2DBEditorRow5: TcxDBEditorRow;
    dxBarButton2: TdxBarButton;
    cxDBVerticalGrid2DBEditorRow6: TcxDBEditorRow;
    bbTaskComments: TdxBarButton;
    bbTaskAssign: TdxBarButton;
    pnTaskRequest: TPanel;
    pnTasks: TPanel;
    cxSplitter3: TcxSplitter;
    dxBarDockControlTaskRequest: TdxBarDockControl;
    dxBarManagerBar5: TdxBar;
    bbRequestAccept: TdxBarButton;
    cxGridTRLevel: TcxGridLevel;
    cxGridTR: TcxGrid;
    IBCQueryRequest: TIBCQuery;
    IBCDataSourceRequest: TIBCDataSource;
    cxGridTRTable: TcxGridDBTableView;
    cxGridTR_TASKID: TcxGridDBColumn;
    cxGridTR_TITLE: TcxGridDBColumn;
    cxGridTR_COMMENTS: TcxGridDBColumn;
    cxGridTR_CREATED_FULL_NAME: TcxGridDBColumn;
    cxGridTR_IMG: TcxGridDBColumn;
    cxDBTreeListTaskcxDBTreeListColumn6: TcxDBTreeListColumn;
    cxGridPopupMenuTR: TcxGridPopupMenu;
    dxBarPopupMenuTR: TdxBarPopupMenu;
    cxDBTreeListTaskcxDBTreeListColumn7: TcxDBTreeListColumn;
    dxBarPopupMenuTask: TdxBarPopupMenu;
    cxDBTreeListTaskcxDBTreeListColumn8: TcxDBTreeListColumn;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    bbCloseIncident: TdxBarButton;
    cxDBTreeListTaskcxDBTreeList_DATA: TcxDBTreeListColumn;
    dxBarLookupCombo1: TdxBarLookupCombo;
    bbCreateDocument: TdxBarButton;
    cxGridIncidentTable_Data: TcxGridDBColumn;
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocs_DOCID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocs_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    dxBarManagerBar6: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    tsIncidentStatus: TTabSheet;
    IBC_Incident_Status: TIBCQuery;
    IBCDS_Incident_Status: TIBCDataSource;
    cxGridIncidentStatuses: TcxGrid;
    cxGridIncidentStatusesTable: TcxGridDBTableView;
    cxGridIncidentStatusesLevel: TcxGridLevel;
    cxGridIncidentStatuses_DATA: TcxGridDBColumn;
    cxGridIncidentStatusesTableColumn2: TcxGridDBColumn;
    cxGridIncidentStatusesTableColumn3: TcxGridDBColumn;
    cxGridIncidentStatusesTableColumn4: TcxGridDBColumn;
    cxGridIncident_PAYER_NAME: TcxGridDBColumn;
    TabSheet1: TTabSheet;
    cxGridDocsPayer: TcxGrid;
    cxGridDocsPayerTable: TcxGridDBTableView;
    cxGridDocsPayer_DOCID: TcxGridDBColumn;
    cxGridDocsPayer_DATA: TcxGridDBColumn;
    cxGridDocsPayer_CT_NAME: TcxGridDBColumn;
    cxGridDocsPayer_SUMA: TcxGridDBColumn;
    cxGridDocsPayer_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocsPayer_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocsPayerLevel: TcxGridLevel;
    cxGridDocPayerGoods: TcxGrid;
    cxGridDocPayerGoodsTable: TcxGridDBTableView;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBPayer_GoodsID: TcxGridDBColumn;
    cxGridDocPayerGoods_GOODS_NAME: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDocPayerGoodsLevel: TcxGridLevel;
    pmIncident: TdxBarPopupMenu;
    bbNewAct: TdxBarButton;
    IBCDocs_Pay: TIBCQuery;
    IBCDS_DocsPay: TIBCDataSource;
    dxBarDockControl3: TdxBarDockControl;
    btnRashodPayer: TdxBarButton;
    dxBarManagerBar7: TdxBar;
    dxBarManagerBar8: TdxBar;
    bbRashodPayerGoodsAdd: TdxBarButton;
    bbRashodPayerGoodsEdit: TdxBarButton;
    bbRashodPayerGoodsRemove: TdxBarButton;
    bbRashodPayerGoodsSN: TdxBarButton;
    dxBarDockControl4: TdxBarDockControl;
    IBCDS_JurnalPayer: TIBCDataSource;
    IBC_JurnalPayer: TIBCQuery;
    bbIncidentDesc: TdxBarButton;
    cxGridIncident_SOLVED_BY_NAME: TcxGridDBColumn;
    cxGridIncident_TYPE_TITLE: TcxGridDBColumn;
    cxGridIncident_DT_NAME: TcxGridDBColumn;
    cxGridIncident_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn;
    cxGridRashod_IMG: TcxGridDBColumn;
    cxGridDocPayerGoods_IMG: TcxGridDBColumn;
    cxGridIncident_CREATE_DATE: TcxGridDBColumn;
    procedure cxDBTreeListTaskStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
    procedure cxGridDocGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxDBTreeListTaskDataChanged(Sender: TObject);
    procedure bbTaskNewClick(Sender: TObject);
    procedure cxGridTRTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxDBTreeListTaskFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure bbTaskAssignClick(Sender: TObject);
    procedure bbRequestAcceptClick(Sender: TObject);
    procedure bbTaskCommentsClick(Sender: TObject);
    procedure cxGridIncidentTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbRashodGoodsAddClick(Sender: TObject);
    procedure bbRashodEditClick(Sender: TObject);
    procedure bbRashodDeleteClick(Sender: TObject);
    procedure bbRashodSNClick(Sender: TObject);
    procedure bbCloseIncidentClick(Sender: TObject);
    procedure bbCreateDocumentClick(Sender: TObject);
    procedure beCTSC_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridIncidentTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbNewActClick(Sender: TObject);
    procedure btnRashodPayerClick(Sender: TObject);
    procedure bbRashodPayerGoodsAddClick(Sender: TObject);
    procedure bbRashodPayerGoodsEditClick(Sender: TObject);
    procedure bbRashodPayerGoodsRemoveClick(Sender: TObject);
    procedure bbRashodPayerGoodsSNClick(Sender: TObject);
    procedure bbIncidentDescClick(Sender: TObject);
    procedure cxGridDocPayerGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridIncidentTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDocGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridIncidentTable_DataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocsPayer_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridIncidentStatuses_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocsPayerTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocPayerGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDocsPayerTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
  private
    { Private declarations }
    procedure IncidentSelectionChanged;
    procedure DocRashodSelectionChanged;
    procedure DocRashodGoodsSelectionChanged;
    procedure DocPayerRashodSelectionChanged;
    procedure DocPayerRashodGoodsSelectionChanged;
    procedure TaskSelectionChanged;
    procedure RequestSelectionChanged;
    function GetLatestRootTaskID: Integer;
    procedure ShowCreateNewTaskDialog(const RootTaskID: Integer);
    function CreateNewTaskDB(const RootTaskID, TaskTypeID: Integer; const Comments: string): Boolean;
    procedure ShowCreateNewAssignmentDialog(const RootTaskID: Integer);
    function CreateNewAssignmentDB(const RootTaskID, TasTypeID: Integer; const Comments, SN: string; const FinalDateTime: TDateTime): Boolean;
    procedure ShowAcceptRequestDialog(const TaskID: Integer);
    function VerifyUserSecurity(const UserID: Integer): Boolean;
    function AcceptAssignedDB(const TaskID: Integer): Boolean;
    function ShowTaskCommentsEditorDialog(const TaskID: Integer): Boolean;
    procedure ShowAddGoodsToJurnalDialog;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
    function WhenCheckIfGoodsExists_Payer(const GoodsID: Integer): Boolean;
    procedure ShowModifyGoodsToJurnalDialog;
    procedure ShowRemoveRashodGoodsDialog;
    procedure ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
    procedure ShowSelectGoodsSerialNumberDialog_Payer(const ViewOnly: Boolean);
    procedure ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
    procedure ShowSelectGoodsPartNumberDialog_Payer(const ViewOnly: Boolean);
    procedure ShowCloseIncidentDialog;
    function DoCloseIncidentDB(const IncidentID, StatusID: Integer; const CreateReturn: Boolean): Boolean;
    procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
    procedure OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
    procedure CloseData;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure RefreshData; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    procedure CreateAct1994(AIncidentID: Integer);
    procedure ShowIncidentDescriptionDialog;
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, frmServiceEnginerCreateNewTaskDialog,
  System.UITypes, frmServiceEnginerCreateNewAssignmentDialog, SWNDBErrors,
  frmServiceEnginerAcceptAssignmentDialog, frmPasswordDlg, SWNSecurity, SWNUtils,
  frmServiceEnginerTaskCommentsDialog, SWNTypes,
  frmServiceSelectGoodsToAddDialog, SWNConst, frmCustomersDlg,
  frmSelectPartNumbersDialog, frmSelectSNDialog,
  frmServiceNewIncidentEditorDialog, frmServiceEnginerCloseIncidentDialog,
  SWNValueStorageUnit;

{$R *.dfm}
{ Tframe39ServiceEngineer }

procedure Tframe39ServiceEngineer.cxDBTreeListTaskDataChanged(Sender: TObject);
begin
  cxDBTreeListTask.FullExpand;
end;

procedure Tframe39ServiceEngineer.cxDBTreeListTaskFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
  TaskSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxDBTreeListTaskStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
begin
  if not VarIsNull(ANode.Values[4]) then
  begin
    if ANode.Values[4] <> dmDB.CurrentUserID then
      AStyle := dmAdditions.cxStyle_TextGray;
  end;
end;

procedure Tframe39ServiceEngineer.cxGridDocsPayerTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridDocsPayer_FLG_CLOSED.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridDocsPayer_FLG_CLOSED.Index] then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;

  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe39ServiceEngineer.cxGridDocsPayerTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocPayerRashodSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxGridDocsPayer_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocsPayer_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsPayer_DATA.Index]);
end;

procedure Tframe39ServiceEngineer.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridDocs_FLG_CLOSED.Index] then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;

  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe39ServiceEngineer.cxGridDocsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocRashodSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxGridDocPayerGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe39ServiceEngineer.cxGridDocPayerGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocPayerRashodGoodsSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocs_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_DATA.Index]);
end;

procedure Tframe39ServiceEngineer.cxGridIncidentStatuses_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridIncidentStatuses_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridIncidentStatuses_DATA.Index]);
end;

procedure Tframe39ServiceEngineer.cxGridIncidentTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if VarIsStr(AViewInfo.GridRecord.Values[cxGridIncident_DOC_CUSTOMER.index]) and VarIsStr(AViewInfo.GridRecord.Values[cxGridIncident_PAYER_NAME.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridIncident_DOC_CUSTOMER.index] <> AViewInfo.GridRecord.Values[cxGridIncident_PAYER_NAME.index] then
    begin
      if not AViewInfo.Selected then
      begin
        // Document protejat
        ACanvas.Font.Color := clBlue;
      end;
    end
  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
    //ACanvas.Font.Color := clBlack;
  end;

end;

procedure Tframe39ServiceEngineer.cxGridIncidentTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  IncidentSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxGridIncidentTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridIncidentTable, Key, Shift);
end;

procedure Tframe39ServiceEngineer.cxGridIncidentTable_DataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridIncidentTable_Data.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridIncidentTable_Data.Index]);
end;

procedure Tframe39ServiceEngineer.cxGridDocGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe39ServiceEngineer.cxGridDocGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocRashodGoodsSelectionChanged;
end;

procedure Tframe39ServiceEngineer.cxGridDocGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridDocGoodsTable, Key, Shift);
end;

procedure Tframe39ServiceEngineer.cxGridTRTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  RequestSelectionChanged;
end;

procedure Tframe39ServiceEngineer.DoFrameHide;
begin
     // inchidem datele interne
  CloseData;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridIncidentTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  IBCQueryDocs.MasterSource := nil;
  IBCDocs_Pay.MasterSource := nil;
  IBCQueryTask.MasterSource := nil;
  IBC_Incident_Status.MasterSource := nil;
  cxGridIncidentTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe39ServiceEngineer.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customizedFilterData: TFrameDataFilteringInfo;
begin
  inherited;

  pcPageControlDocs.ActivePage := tbsIncidentRashod;

     // 1. Legam grid-urile de datasource-sele
  IBCQueryDocs.MasterSource := dmDB.IBCDataSourceIncidente;
  IBCDocs_Pay.MasterSource := dmDB.IBCDataSourceIncidente;
  IBCQueryTask.MasterSource := dmDB.IBCDataSourceIncidente;
  IBC_Incident_Status.MasterSource := dmDB.IBCDataSourceIncidente;
  cxGridIncidentTable.DataController.DataSource := dmDB.IBCDataSourceIncidente;

     // 2. Selection handlers
  cxGridIncidentTable.OnFocusedRecordChanged := cxGridIncidentTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
  customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
  try
    customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
    OpenExternalData(customizedFilterData);
  finally
    customizedFilterData.Free;
  end;
     // deschidem datele interne
  OpenData(customizedFilterData);

end;

procedure Tframe39ServiceEngineer.bbRashodPayerGoodsRemoveClick(Sender: TObject);
var
  S: string;
begin
  S := Format(cMSG_DELETERECORD_РасходнаяНакладная, [IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  // confirmation
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, S) <> mrYes then
    Exit;

  IBC_JurnalPayer.UpdateTransaction.StartTransaction;
  try
    IBC_JurnalPayer.Delete;
    IBC_JurnalPayer.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBC_JurnalPayer.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure Tframe39ServiceEngineer.bbRashodPayerGoodsSNClick(Sender: TObject);
var
  flg_serial: Integer;
begin
  flg_serial := IBC_JurnalPayer.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

  // Серийный учет
  if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowSelectGoodsSerialNumberDialog_Payer(IBCDocs_Pay.FieldByName('FLG_SHIP').AsInteger = 1)
  else
    // Партийный учет
 if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowSelectGoodsPartNumberDialog_Payer(IBCDocs_Pay.FieldByName('FLG_SHIP').AsInteger = 1);
end;

procedure Tframe39ServiceEngineer.bbIncidentDescClick(Sender: TObject);
begin
  ShowIncidentDescriptionDialog;
end;

procedure Tframe39ServiceEngineer.ShowIncidentDescriptionDialog;
var
  dialog: TfrmServiceNewIncidentEditorDlg;
begin
  dialog := TfrmServiceNewIncidentEditorDlg.Create(Self, dmDB.IBCQueryIncidente, dmDB.IBCDataSourceIncidente);
  try
    dialog.ShowModal;
    dmDB.IBCQueryIncidente.RefreshRecord;
  finally
    dialog.Free;
  end;
end;

function Tframe39ServiceEngineer.AcceptAssignedDB(const TaskID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_INGINER_ACCEPT_REQUEST(:id)';
    Query.ParamByName('id').AsInteger := TaskID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe39ServiceEngineer.bbCloseIncidentClick(Sender: TObject);
begin
  ShowCloseIncidentDialog;
end;

procedure Tframe39ServiceEngineer.bbCreateDocumentClick(Sender: TObject);
var
  q: TIBCQuery;
begin
  if ShowAskDialog('Создать Расходную Накладную', Format('Вы хотите создать Расходную Накладную на имя "%s"?', [dmDB.IBCQueryIncidente.FieldByName('DOC_CUSTOMER').AsString])) <> mrYes then
    Exit;

  q := TIBCQuery.Create(Self);
  try
    q.Transaction := dmDB.IBCTrDefaultUpdate;
    q.AutoCommit := False;
    q.SQL.Text := 'execute procedure SP_SC_INCIDENT_GOES_WORK(:iid)';
    q.ParamByName('IID').AsInteger := dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger;
    q.Transaction.StartTransaction;
    try
      q.ExecSQL;
      q.Transaction.Commit;
      dmDB.IBCQueryIncidente.Refresh;
      IBCQueryDocs.Refresh;
      IBCQueryJurnal.Refresh;
      IncidentSelectionChanged;
    except
      on E: Exception do
      begin
        q.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    FreeAndNil(q);
  end;
end;

procedure Tframe39ServiceEngineer.bbNewActClick(Sender: TObject);
begin
  inherited;
  CreateAct1994(dmDB.IBCQueryIncidente.FieldByName('Incidentid').AsInteger);
end;

procedure Tframe39ServiceEngineer.bbRashodGoodsAddClick(Sender: TObject);
begin
  ShowAddGoodsToJurnalDialog;
end;

procedure Tframe39ServiceEngineer.bbRashodDeleteClick(Sender: TObject);
begin
  ShowRemoveRashodGoodsDialog;
end;

procedure Tframe39ServiceEngineer.bbRashodEditClick(Sender: TObject);
begin
  ShowModifyGoodsToJurnalDialog;
end;

procedure Tframe39ServiceEngineer.bbRashodSNClick(Sender: TObject);
var
  flg_serial: Integer;
begin
  flg_serial := IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

  // Серийный учет
  if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowSelectGoodsSerialNumberDialog(IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1)
  else
    // Партийный учет
 if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowSelectGoodsPartNumberDialog(IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1);
end;

procedure Tframe39ServiceEngineer.bbRequestAcceptClick(Sender: TObject);
begin
  ShowAcceptRequestDialog(IBCQueryRequest.FieldByName('TASKID').AsInteger);
end;

procedure Tframe39ServiceEngineer.bbTaskAssignClick(Sender: TObject);
begin
  ShowCreateNewAssignmentDialog(GetLatestRootTaskID);
end;

procedure Tframe39ServiceEngineer.bbTaskCommentsClick(Sender: TObject);
begin
  if Assigned(cxDBTreeListTask.FocusedNode) then
  begin
    if ShowTaskCommentsEditorDialog(cxDBTreeListTask.FocusedNode.Values[5]) // TASKID
      then
      // IBCQueryTask.Refresh;

  end;
end;

procedure Tframe39ServiceEngineer.bbTaskNewClick(Sender: TObject);
begin
  ShowCreateNewTaskDialog(GetLatestRootTaskID);
end;

procedure Tframe39ServiceEngineer.beCTSC_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  if AButtonIndex = 0 then
  begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
      // dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
      dmDB.IBCQueryIncidente.Edit;
      if dialog.SelectCustomer(dmDB.IBCQueryIncidente.FieldByName('PAYERID').AsInteger, False, 0, 'Выбор плательщика для Заявки на гарантийный ремонт') then
      begin

        dmDB.IBCQueryIncidente.FieldByName('PAYERID').AsInteger := dialog.CustomerID;
        dmDB.IBCQueryIncidente.FieldByName('PAYER_NAME').AsString := dialog.CustomerTitle;
        dmDB.IBCQueryIncidente.Post;
        dmDB.IBCQueryIncidente.RefreshRecord;
      end;
    finally
      dialog.Free;
    end;
  end;
  if AButtonIndex = 1 then
  begin
    dmDB.IBCQueryIncidente.Edit;
    dmDB.IBCQueryIncidente.FieldByName('PAYERID').AsInteger := dmDB.IBCQueryIncidente.FieldByName('CT').AsInteger;
    dmDB.IBCQueryIncidente.FieldByName('PAYER_NAME').AsString := dmDB.IBCQueryIncidente.FieldByName('DOC_CUSTOMER').AsString;
    dmDB.IBCQueryIncidente.Post;
    dmDB.IBCQueryIncidente.RefreshRecord;
  end;
end;

procedure Tframe39ServiceEngineer.bbRashodPayerGoodsAddClick(Sender: TObject);
var
  dialog: TfrmServiceSelectGoodsToAddDlg;
begin
  dialog := TfrmServiceSelectGoodsToAddDlg.Create(Self, IBC_JurnalPayer, IBCDS_JurnalPayer, IBCDocs_Pay);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists_Payer;
    dialog.AllowedActions := dialog.AllowedActions { -[acChangePrice] };
    dialog.AddNewGoods := True;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.bbRashodPayerGoodsEditClick(Sender: TObject);
var
  dialog: TfrmServiceSelectGoodsToAddDlg;
begin
  dialog := TfrmServiceSelectGoodsToAddDlg.Create(Self, IBC_JurnalPayer, IBCDS_JurnalPayer, IBCDocs_Pay);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists_Payer;
    dialog.AllowedActions := dialog.AllowedActions;
    dialog.AddNewGoods := False;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.btnRashodPayerClick(Sender: TObject);
var
  q: TIBCQuery;
begin
  if ShowAskDialog('Создать Расходную Накладную на плательщика', Format('Вы хотите создать Расходную Накладную на плательщика "%s"?', [dmDB.IBCQueryIncidente.FieldByName('PAYER_NAME').AsString])) <> mrYes then
    Exit;

  q := TIBCQuery.Create(Self);
  try
    q.Transaction := dmDB.IBCTrDefaultUpdate;
    q.AutoCommit := False;
    q.SQL.Text := 'execute procedure SC_INCIDENT_CREATE_PAYER_RASHOD(:iid)';
    q.ParamByName('IID').AsInteger := dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger;
    q.Transaction.StartTransaction;
    try
      q.ExecSQL;
      q.Transaction.Commit;
      dmDB.IBCQueryIncidente.Refresh;
      IBCDocs_Pay.RefreshRecord;
      IBC_JurnalPayer.Refresh;
      IncidentSelectionChanged;
    except
      on E: Exception do
      begin
        q.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    FreeAndNil(q);
  end;
end;

procedure Tframe39ServiceEngineer.CloseData;
begin
  IBCQueryDocs.Close;
  IBCQueryJurnal.Close;
  IBC_Incident_Status.Close;
  IBCDocs_Pay.Close;
  IBC_JurnalPayer.Close;
  IBCQueryRequest.Close;
  IBCQueryTask.Close;
end;

procedure Tframe39ServiceEngineer.CreateAct1994(AIncidentID: Integer);
var
  Query: TIBCQuery;
begin

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_NEW_ACT_1994(:IID)';
    Query.ParamByName('IID').AsInteger := AIncidentID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe39ServiceEngineer.CreateNewAssignmentDB(const RootTaskID, TasTypeID: Integer; const Comments, SN: string; const FinalDateTime: TDateTime): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_INGINER_CREATE_REQUEST(:id1,:id2,:comm,:sn,:fd)';
    Query.ParamByName('id1').AsInteger := RootTaskID;
    Query.ParamByName('id2').AsInteger := TasTypeID;
    Query.ParamByName('comm').AsString := Comments;
    Query.ParamByName('sn').AsString := SN;
    Query.ParamByName('fd').AsDateTime := FinalDateTime;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe39ServiceEngineer.CreateNewTaskDB(const RootTaskID, TaskTypeID: Integer; const Comments: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_INGINER_CREATE_SUB_TASK(:root,:type,:comm)';
    Query.ParamByName('root').AsInteger := RootTaskID;
    Query.ParamByName('type').AsInteger := TaskTypeID;
    Query.ParamByName('comm').AsString := Comments;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe39ServiceEngineer.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsIncidente];
end;

function Tframe39ServiceEngineer.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffCustomer, ffGoods, ffGoodsSN];
end;

function Tframe39ServiceEngineer.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

function Tframe39ServiceEngineer.GetLatestRootTaskID: Integer;
var
  Node: TcxTreeListNode;
  i: Integer;
begin
  Result := -1;
  for i := cxDBTreeListTask.Count - 1 downto 0 do
  begin
    Node := cxDBTreeListTask.Items[i];
    if (Node.Level = 0) and (Node.Values[6] = 1) then // TASKTYPE_ID
    begin
      Result := Node.Values[5]; // TASKID
      break;
    end;
  end
end;

procedure Tframe39ServiceEngineer.GetParamsListForReport(const ParamsList: TStringList);
begin
  inherited;
  if dmDB.IBCQueryIncidente.Active then
  begin
    ParamsList.Add('INCIDENTID');
    ParamsList.Add('DT');
  end;
end;

function Tframe39ServiceEngineer.GetParamValueForReport(const ParamName: string): Variant;
begin
  if dmDB.IBCQueryIncidente.Active then
  begin
    if SameText(ParamName, 'INCIDENTID') then
      Result := dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').AsInteger;
    if SameText(ParamName, 'DT') then
      Result := dmDB.CurrentFirma;

  end;
end;

procedure Tframe39ServiceEngineer.IncidentSelectionChanged;
var
  fClose, fEdit, fHasRashod, fHasPayerRashod: Boolean;
begin
  fClose := False;
  fEdit := False;
  fHasRashod := False;
  fHasPayerRashod := False;

  if cxGridIncidentTable.DataController.RecNo > 0 then
  begin
    fClose := True;
    fEdit := True;
    fHasRashod := dmDB.IBCQueryIncidente.FieldByName('RASHOD_DOCID').AsInteger <= 0;
    fHasPayerRashod := dmDB.IBCQueryIncidente.FieldByName('PAYER_RASHOD_DOCID').AsInteger <= 0;
  end;

  bbCloseIncident.Enabled := fClose;
  bbIncidentDesc.Enabled := fEdit;
  bbCreateDocument.Enabled := fHasRashod;
  btnRashodPayer.Enabled := fHasPayerRashod;

  DocRashodSelectionChanged;
  DocPayerRashodSelectionChanged;
end;

function Tframe39ServiceEngineer.InitFrameID: Integer;
begin
  Result := 39; // СЕРВИС - Инжинер сервиса
  dmDB.CreateGridImageColumnItems(cxGridRashod_IMG);
  dmDB.CreateGridImageColumnItems(cxGridDocPayerGoods_IMG);
end;

procedure Tframe39ServiceEngineer.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  CloseData;

  IBCQueryDocs.Active := True;
  IBCQueryJurnal.Active := True;
  IBC_Incident_Status.Open;
  IBCDocs_Pay.Open;
  IBC_JurnalPayer.Open;

  IncidentSelectionChanged;
  TaskSelectionChanged;
  RequestSelectionChanged;
end;

procedure Tframe39ServiceEngineer.DocPayerRashodSelectionChanged;
var
  fAdd: Boolean;
  FLG_CLOSED: Boolean;
begin
  fAdd := False;
  if (cxGridDocsPayerTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := IBCDocs_Pay.FieldByName('FLG_CLOSED').AsInteger = 1;
    fAdd := not FLG_CLOSED;
  end;
  bbRashodPayerGoodsAdd.Enabled := fAdd;

  DocPayerRashodGoodsSelectionChanged;
end;

procedure Tframe39ServiceEngineer.DocRashodGoodsSelectionChanged;
var
  fEdit, fDelete, fSN: Boolean;
  SerialType: Integer;
  FLG_CLOSED: Boolean;
begin
  fEdit := False;
  fDelete := False;
  fSN := False;

  if (cxGridDocsTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    if not FLG_CLOSED and (cxGridDocGoodsTable.DataController.RecNo > 0) then
    begin
      SerialType := IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
      fEdit := True;
      fDelete := True;
      fSN := (SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
    end;
  end;

  bbRashodEdit.Enabled := fEdit;
  bbRashodDelete.Enabled := fDelete;
  bbRashodSN.Enabled := fSN;
end;

procedure Tframe39ServiceEngineer.DocRashodSelectionChanged;
var
  fAdd: Boolean;
  FLG_CLOSED: Boolean;
begin
  fAdd := False;
  if (cxGridDocsTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fAdd := not FLG_CLOSED;
  end;
  bbRashodGoodsAdd.Enabled := fAdd;

  DocRashodGoodsSelectionChanged;
end;

procedure Tframe39ServiceEngineer.DocPayerRashodGoodsSelectionChanged;
var
  fEdit, fDelete, fSN: Boolean;
  SerialType: Integer;
begin
  fEdit := False;
  fDelete := False;
  fSN := False;

  if (cxGridDocsPayerTable.DataController.RecNo > 0) then
  begin
    SerialType := IBC_JurnalPayer.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
    fEdit := True;
    fDelete := True;
    fSN := (SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
  end;

  bbRashodPayerGoodsEdit.Enabled := fEdit;
  bbRashodPayerGoodsRemove.Enabled := fDelete;
  bbRashodPayerGoodsSN.Enabled := fSN;
end;

procedure Tframe39ServiceEngineer.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter2.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridIncidentTable);
    ReadGridColumnsSettings(cxGridDocsTable);
    ReadGridColumnsSettings(cxGridDocGoodsTable);
    ReadGridColumnsSettings(cxGridDocsPayerTable);
    ReadGridColumnsSettings(cxGridDocPayerGoodsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe39ServiceEngineer.RefreshData;
begin
  inherited;
  IBCQueryDocs.Refresh;
  IBCQueryJurnal.Refresh;
  IBCDocs_Pay.Refresh;
  IBC_JurnalPayer.Refresh;
     // IBCQueryTask.Refresh;
end;

procedure Tframe39ServiceEngineer.RequestSelectionChanged;
var
  fAccept: Boolean;
begin
  fAccept := False;
  if (cxGridTRTable.DataController.RecNo > 0) then
  begin
    fAccept := True;
  end;
  bbRequestAccept.Enabled := fAccept;
end;

procedure Tframe39ServiceEngineer.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter2.State));
    SaveGridColumnsSettings(cxGridIncidentTable);
    SaveGridColumnsSettings(cxGridDocsTable);
    SaveGridColumnsSettings(cxGridDocGoodsTable);
    SaveGridColumnsSettings(cxGridDocsPayerTable);
    SaveGridColumnsSettings(cxGridDocPayerGoodsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe39ServiceEngineer.SetupDefaultFocus;
begin
     // grid
  cxGridIncident.SetFocus;
     // columns
  cxGridIncident_DOC_CUSTOMER.Focused := True;
  cxGridDocs_CT_NAME.Focused := True;
  cxGridRashod_GOODS_NAME.Focused := True;
  cxGridDocsPayer_CT_NAME.Focused := True;
  cxGridDocPayerGoods_GOODS_NAME.Focused := True;
end;

procedure Tframe39ServiceEngineer.ShowAcceptRequestDialog(const TaskID: Integer);
var
  dialog: TfrmServiceEnginerAcceptAssignmentDlg;
begin
  dialog := TfrmServiceEnginerAcceptAssignmentDlg.Create(Self, IBCQueryRequest, IBCDataSourceRequest);
  try
    if dialog.ShowModal = mrOk then
    begin
      if VerifyUserSecurity(dmDB.CurrentUserID) then
      begin
        if AcceptAssignedDB(TaskID) then
        begin
          // IBCQueryRequest.Refresh;
          dmDB.IBCQueryIncidente.Refresh;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowAddGoodsToJurnalDialog;
var
  dialog: TfrmServiceSelectGoodsToAddDlg;
begin
  dialog := TfrmServiceSelectGoodsToAddDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal, IBCQueryDocs);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AllowedActions := dialog.AllowedActions { -[acChangePrice] };
    dialog.AddNewGoods := True;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

function Tframe39ServiceEngineer.DoCloseIncidentDB(const IncidentID, StatusID: Integer; const CreateReturn: Boolean): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SC_INGINER_CLOSE_INCIDENT(:id, :STATUS_ID, :FLG_CREATE_RETURN)';
    Query.ParamByName('ID').AsInteger := IncidentID;
    Query.ParamByName('STATUS_ID').AsInteger := StatusID;
    Query.ParamByName('FLG_CREATE_RETURN').AsInteger := Ord(CreateReturn);
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowCloseIncidentDialog;
var
  dialog: TfrmServiceEnginerCloseIncidentDlg;
begin
  dialog := TfrmServiceEnginerCloseIncidentDlg.Create(self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if DoCloseIncidentDB(dmDB.IBCQueryIncidente.FieldByName('INCIDENTID').asInteger, dialog.StatusID, dialog.CreateReturn) then
        dmDB.IBCQueryIncidente.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowCreateNewAssignmentDialog(const RootTaskID: Integer);
var
  dialog: TfrmServiceEnginerCreateNewAssignmentDlg;
begin
  dialog := TfrmServiceEnginerCreateNewAssignmentDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if CreateNewAssignmentDB(RootTaskID, dialog.getTaskTypeID, dialog.getComents, dialog.getSN, dialog.getFinalDateTime) then
        // IBCQueryTask.Refresh;

    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowCreateNewTaskDialog(const RootTaskID: Integer);
var
  dialog: TfrmServiceEnginerCreateNewTaskDlg;
begin
  dialog := TfrmServiceEnginerCreateNewTaskDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if CreateNewTaskDB(GetLatestRootTaskID, dialog.getTaskType, dialog.getComments) then
        // IBCQueryTask.Refresh;

    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowModifyGoodsToJurnalDialog;
var
  dialog: TfrmServiceSelectGoodsToAddDlg;
begin
  dialog := TfrmServiceSelectGoodsToAddDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal, IBCQueryDocs);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AllowedActions := dialog.AllowedActions;
    dialog.AddNewGoods := False;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowRemoveRashodGoodsDialog;
var
  S: string;
begin
  S := Format(cMSG_DELETERECORD_РасходнаяНакладная, [IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  // confirmation
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, S) <> mrYes then
    Exit;

  IBCQueryJurnal.UpdateTransaction.StartTransaction;
  try
    IBCQueryJurnal.Delete;
    IBCQueryJurnal.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryJurnal.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure Tframe39ServiceEngineer.ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
var
  frmSelectPartsDlg: TfrmSelectPartsDlg;
begin
  frmSelectPartsDlg := TfrmSelectPartsDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal);
  try
    frmSelectPartsDlg.DocsDataSet := IBCQueryDocs;
    frmSelectPartsDlg.readonly := ViewOnly;
    if frmSelectPartsDlg.ShowModal = mrOk then
      IBCQueryJurnal.Refresh;
  finally
    frmSelectPartsDlg.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowSelectGoodsPartNumberDialog_Payer(const ViewOnly: Boolean);
var
  frmSelectPartsDlg: TfrmSelectPartsDlg;
begin
  frmSelectPartsDlg := TfrmSelectPartsDlg.Create(Self, IBC_JurnalPayer, IBCDS_JurnalPayer);
  try
    frmSelectPartsDlg.DocsDataSet := IBCDocs_Pay;
    frmSelectPartsDlg.readonly := ViewOnly;
    if frmSelectPartsDlg.ShowModal = mrOk then
      IBC_JurnalPayer.Refresh;
  finally
    frmSelectPartsDlg.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
var
  frmSelectSNDlg: TfrmSelectSNDlg;
begin
  frmSelectSNDlg := TfrmSelectSNDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal);
  try
    frmSelectSNDlg.DocsDataSet := IBCQueryDocs;
    frmSelectSNDlg.readonly := ViewOnly;
    if frmSelectSNDlg.ShowModal = mrOk then
      IBCQueryJurnal.Refresh;
  finally
    frmSelectSNDlg.Free;
  end;
end;

procedure Tframe39ServiceEngineer.ShowSelectGoodsSerialNumberDialog_Payer(const ViewOnly: Boolean);
var
  frmSelectSNDlg: TfrmSelectSNDlg;
begin
  frmSelectSNDlg := TfrmSelectSNDlg.Create(Self, IBC_JurnalPayer, IBCDS_JurnalPayer);
  try
    frmSelectSNDlg.DocsDataSet := IBCDocs_Pay;
    frmSelectSNDlg.readonly := ViewOnly;
    if frmSelectSNDlg.ShowModal = mrOk then
      IBC_JurnalPayer.Refresh;
  finally
    frmSelectSNDlg.Free;
  end;
end;

function Tframe39ServiceEngineer.ShowTaskCommentsEditorDialog(const TaskID: Integer): Boolean;
var
  dialog: TfrmServiceEnginerTaskCommentsDlg;
begin
  dialog := TfrmServiceEnginerTaskCommentsDlg.Create(Self, IBCQueryTask, IBCDataSourceTask);
  try
    Result := dialog.ShowModal = mrOk;
  finally
    dialog.Free;
  end;
end;

procedure Tframe39ServiceEngineer.TaskSelectionChanged;
var
  fNew, fAssign, fComments: Boolean;
  Node: TcxTreeListNode;
begin
  fNew := False;
  fAssign := False;
  fComments := False;

  if (cxDBTreeListTask.Count > 0) then
  begin
    fNew := True;
    if Assigned(cxDBTreeListTask.FocusedNode) then
    begin
      Node := cxDBTreeListTask.FocusedNode;
      fAssign := True;
      fComments := (Node.Values[6] <> 18) and (Node.Values[6] <> 1) and (Node.Values[7] = dmDB.CurrentUserID);
      // TASKTYPE_ID, CREATED_BY
    end;
  end;
  bbTaskNew.Enabled := fNew;
  bbTaskAssign.Enabled := fAssign;
  bbTaskComments.Enabled := fComments;
end;

function Tframe39ServiceEngineer.VerifyUserSecurity(const UserID: Integer): Boolean;
var
  dialog: TfrmPasswordDialog;
begin
  Result := False;
  dialog := TfrmPasswordDialog.Create(Self, pdmAskPassword);
  try
    if dialog.ShowModal = mrOk then
    begin
      Result := SWNSecurityManager.TestUserPassword(UserID, dialog.Password);
      if not Result then
        ShowErrorDialog('Ошибка', 'Неправильный пароль!');
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe39ServiceEngineer.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridDocGoodsTable.DataController.RecordCount - 1 do
  begin
    if cxGridDocGoodsTable.DataController.Values[i, cxGridRashod_GOODSID.index] = GoodsID then
    begin
      Result := True;
      break;
    end;
  end;
end;

function Tframe39ServiceEngineer.WhenCheckIfGoodsExists_Payer(const GoodsID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridDocPayerGoodsTable.DataController.RecordCount - 1 do
  begin
    if cxGridDocPayerGoodsTable.DataController.Values[i, cxGridDBPayer_GoodsID.index] = GoodsID then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure Tframe39ServiceEngineer.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
  FilterSQL := FilterSQL + ' AND (STATUS_ID=6104)';
end;

procedure Tframe39ServiceEngineer.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customizedFilterData: TFrameDataFilteringInfo;
begin
  customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
  try
    customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
    inherited WhenFilterDataChanged(customizedFilterData);
    OpenData(customizedFilterData);
  finally
    customizedFilterData.Free;
  end;
end;

end.


unit frame37ServiceDispatcherUnit;
{
 SERVICE - Dispecer service
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit,
  ExtCtrls, cxSplitter, cxStyles,
  DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGrid, StdCtrls, DBAccess, IBC, dxBar,
  cxTL, cxDBTL, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxMaskEdit, cxTLdxBarBuiltInMenu,
  cxClasses, MemDS, cxInplaceContainer, cxTLData, cxGridTableView, cxGridCustomView;

type
  Tframe37ServiceDispatcher = class(TSWNBaseFrame)
    pnTop: TPanel;
    pnClient: TPanel;
    pnTopClient: TPanel;
    pnTopRight: TPanel;
    pnClientRight: TPanel;
    pnClientClient: TPanel;
    cxSplitterTopRight: TcxSplitter;
    cxSplitterTop: TcxSplitter;
    cxSplitterClientRight: TcxSplitter;
    cxGridPerTable: TcxGridDBTableView;
    cxGridPerLevel: TcxGridLevel;
    cxGridPer: TcxGrid;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    IBCQueryPererabotka: TIBCQuery;
    IBCDataSourcePererabotka: TIBCDataSource;
    cxGridPer_INCIDENTID: TcxGridDBColumn;
    cxGridPer_GOODS_TITLE: TcxGridDBColumn;
    cxGridPer_GOODS_SN: TcxGridDBColumn;
    dxBarManager: TdxBarManager;
    dxBarDockControlTopRight: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbPererabotkaAccept: TdxBarButton;
    cxGridPer_DOC_CUSTOMER: TcxGridDBColumn;
    cxGridPer_GOODS_MODEL: TcxGridDBColumn;
    dxBarDockControlTopClient: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    cxGridWaitTable: TcxGridDBTableView;
    cxGridWaitLevel: TcxGridLevel;
    cxGridWait: TcxGrid;
    dxBarDockControlClientClient: TdxBarDockControl;
    dxBarDockControlClientRight: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    dxBarManagerBar4: TdxBar;
    cxGridWorkTable: TcxGridDBTableView;
    cxGridWorkLevel: TcxGridLevel;
    cxGridWork: TcxGrid;
    cxDBTreeList: TcxDBTreeList;
    bbWaitingIncidentProps: TdxBarButton;
    IBCQueryWait: TIBCQuery;
    IBCDataSourceWait: TIBCDataSource;
    cxGridWait_INCIDENTID: TcxGridDBColumn;
    cxGridWait_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn;
    cxGridWait_VENDOR_TITLE: TcxGridDBColumn;
    cxGridWait_GOODS_MODEL: TcxGridDBColumn;
    cxGridWait_GOODS_SN: TcxGridDBColumn;
    cxGridWait_DATA_EST_FINISH: TcxGridDBColumn;
    cxGridWait_PRIORITY_LEVEL_TITLE: TcxGridDBColumn;
    cxGridWait_DAYS_LEFT: TcxGridDBColumn;
    cxGridWait_PRIORITY_LEVEL_VALUE: TcxGridDBColumn;
    cxGridWait_FLG_TOP_PRIORITY: TcxGridDBColumn;
    bbWaitingIncidentRun: TdxBarButton;
    IBCQueryInWork: TIBCQuery;
    IBCDataSourceInWork: TIBCDataSource;
    cxGridWork_INCIDENTID: TcxGridDBColumn;
    cxGridWork_GOODS_TITLE: TcxGridDBColumn;
    cxGridWork_VENDOR_TITLE: TcxGridDBColumn;
    cxGridWork_GOODS_MODEL: TcxGridDBColumn;
    cxGridWork_GOODS_SN: TcxGridDBColumn;
    cxGridWork_EXEC_PERSONAL_GROUP_TITLE: TcxGridDBColumn;
    cxGridWor_LEFT_HOURS: TcxGridDBColumn;
    cxGridWork_ENGINER_FULL_NAME: TcxGridDBColumn;
    IBCQueryTask: TIBCQuery;
    IBCDataSourceTask: TIBCDataSource;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn3: TcxDBTreeListColumn;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    procedure cxGridPerTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbPererabotkaAcceptClick(Sender: TObject);
    procedure cxGridWaitTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridWait_DAYS_LEFTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbWaitingIncidentPropsClick(Sender: TObject);
    procedure cxGridWaitTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbWaitingIncidentRunClick(Sender: TObject);
  private
    { Private declarations }

    // Prelucrare
    procedure WhenPererabotkaSelectionChanged;
    procedure ShowAcceptPererabotkaDialog(const IncidentID:Integer);
    function AcceptGoodsFromPererabotkaDB(const IncidentID,InginersGroupID:Integer):Boolean;

    // Asteptare pentru reparatie
    procedure WaitingIncidentSelectionChanged;
    procedure ShowWaitingIncidentPropsDialog;
    procedure ShowWaitingIncidentRunDialog(const IncidentID:Integer);
    function RunWaitingIncident(const IncidentID,TargetUserID:integer; const FinishDate:TDateTime):Boolean;

    // Incidente in lucru

  protected
    { Protected declarations }
    function InitFrameID:integer;override;
    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;

    procedure DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);override;
    procedure DoFrameHide;override;

    procedure RefreshData;override;

    procedure ReadFrameStates;override;
    procedure SaveFrameStates;override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNValueStorageUnit, frmServiceAcceptGoodsFromPererabotkaDialog,
     SWNDBErrors, frmServiceWaitingIncidentPropsDialog, frmServiceWaitingIncidentRunDialog;

{$R *.dfm}

{ Tframe37ServiceDispatcher }

function Tframe37ServiceDispatcher.AcceptGoodsFromPererabotkaDB(const IncidentID,InginersGroupID: Integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_SC_INCIDENTFROMPERERABOTKA(:id,:id2)';
        Query.ParamByName('id').AsInteger:=IncidentID;
        Query.ParamByName('id2').AsInteger:=InginersGroupID;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe37ServiceDispatcher.bbPererabotkaAcceptClick(Sender: TObject);
begin
     ShowAcceptPererabotkaDialog(IBCQueryPererabotka.FieldByName('INCIDENTID').AsInteger);
end;

procedure Tframe37ServiceDispatcher.cxGridPerTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     WhenPererabotkaSelectionChanged;
end;

procedure Tframe37ServiceDispatcher.cxGridWaitTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     WaitingIncidentSelectionChanged;
end;

procedure Tframe37ServiceDispatcher.cxGridWaitTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridWait_DAYS_LEFT.Index]) then
     begin
          if ARecord.Values[cxGridWait_DAYS_LEFT.Index]<0 then AStyle:=dmAdditions.cxStyle_TextColorRed
          else
          if ARecord.Values[cxGridWait_DAYS_LEFT.Index]<=4 then AStyle:=dmAdditions.cxStyle_TextColorDarkYellow;
     end;
end;

procedure Tframe37ServiceDispatcher.cxGridWait_DAYS_LEFTGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridWait_DAYS_LEFT.Index]) then
     begin
          if ARecord.Values[cxGridWait_DAYS_LEFT.Index]<0 then AText:='Intarziat'
          else
          if ARecord.Values[cxGridWait_DAYS_LEFT.Index]=0 then AText:='Astazi'
     end;
end;

procedure Tframe37ServiceDispatcher.DoFrameHide;
begin
     IBCQueryPererabotka.Close;
     IBCQueryWait.Close;
     IBCQueryInWork.Close;
     IBCQueryTask.Close;

     inherited;
end;

procedure Tframe37ServiceDispatcher.DoFrameShow(const FrameDataFilterInfo:TFrameDataFilteringInfo);
begin
     inherited;

     // open data
     IBCQueryPererabotka.Active:=True;
     IBCQueryWait.Active:=True;
     IBCQueryInWork.Active:=True;
     IBCQueryTask.Active:=True;

     cxGridWaitTable.DataController.Groups.FullExpand;
     cxDBTreeList.DataController.TreeList.FullExpand;

     // selection
     WhenPererabotkaSelectionChanged;
     WaitingIncidentSelectionChanged;
end;

procedure Tframe37ServiceDispatcher.bbWaitingIncidentPropsClick(Sender: TObject);
begin
     ShowWaitingIncidentPropsDialog;
end;

procedure Tframe37ServiceDispatcher.bbWaitingIncidentRunClick(Sender: TObject);
begin
     ShowWaitingIncidentRunDialog(IBCQueryWait.FieldByName('INCIDENTID').AsInteger);
end;

function Tframe37ServiceDispatcher.GetFilterFields: TFrameFilterFields;
begin
     Result:=[ffDate];
end;

function Tframe37ServiceDispatcher.GetFrameButtons: TFrameButtons;
begin
     Result:=[fbtREFRESH];
end;

function Tframe37ServiceDispatcher.InitFrameID: integer;
begin
     Result:=37; // SERVICE - Dispecer service
end;

procedure Tframe37ServiceDispatcher.ReadFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        pnTop.Height:=AppUserConfigStorage.IntValues.GetValue('TopPanelHeight',Self.Height div 2);
        cxSplitterTop.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('TopPanelSplitterState'));

        pnTopRight.Width:=AppUserConfigStorage.IntValues.GetValue('TopRightPanelWidth',pnTop.Width div 2);
        cxSplitterTopRight.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('TopRightPanelSplitterState'));

        pnClientRight.Width:=AppUserConfigStorage.IntValues.GetValue('ClientRightPanelWidth',pnClient.Width div 2);
        cxSplitterClientRight.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('ClientRightPanelSplitterState'));

        //ReadGridColumnsSettings(cxGridNPNTable);
        //ReadGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe37ServiceDispatcher.RefreshData;
begin
     IBCQueryPererabotka.Refresh;
     IBCQueryWait.Refresh;
     IBCQueryInWork.Refresh;
     IBCQueryTask.Refresh;
end;

function Tframe37ServiceDispatcher.RunWaitingIncident(const IncidentID, TargetUserID: integer; const FinishDate: TDateTime): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_SC_INCIDENT_GOES_WORK(:id,:user,:fdate)';
        Query.ParamByName('id').AsInteger:=IncidentID;
        Query.ParamByName('user').AsInteger:=TargetUserID;
        Query.ParamByName('fdate').AsDate:=FinishDate;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure Tframe37ServiceDispatcher.SaveFrameStates;
begin
     AppUserConfigStorage.OpenSection(Self.Name);
     try
        // panels size
        AppUserConfigStorage.IntValues.SetValue('TopPanelHeight',pnTop.Height);
        AppUserConfigStorage.IntValues.SetValue('TopPanelSplitterState',Ord(cxSplitterTop.State));

        AppUserConfigStorage.IntValues.SetValue('TopRightPanelWidth',pnTopRight.Width);
        AppUserConfigStorage.IntValues.SetValue('TopRightPanelSplitterState',Ord(cxSplitterTopRight.State));

        AppUserConfigStorage.IntValues.SetValue('ClientRightPanelWidth',pnClientRight.Width);
        AppUserConfigStorage.IntValues.SetValue('ClientRightPanelSplitterState',Ord(cxSplitterClientRight.State));

        //SaveGridColumnsSettings(cxGridNPNTable);
        //SaveGridColumnsSettings(cxGridComponentsTable);
     finally
        AppUserConfigStorage.CloseSection;
     end;
end;

procedure Tframe37ServiceDispatcher.ShowAcceptPererabotkaDialog(const IncidentID: Integer);
var dialog:TfrmServiceAcceptGoodsFromPererabotkaDlg;
begin
     dialog:=TfrmServiceAcceptGoodsFromPererabotkaDlg.Create(Self,IBCQueryPererabotka,IBCDataSourcePererabotka);
     try
        if dialog.ShowModal=mrOk then
        begin
             AcceptGoodsFromPererabotkaDB(IncidentID,dialog.GetInginersGroup);
             // refresh anyway
             IBCQueryPererabotka.Refresh;
             IBCQueryWait.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe37ServiceDispatcher.ShowWaitingIncidentPropsDialog;
var dialog:TfrmServiceWaitingIncidentPropsDlg;
begin
     dialog:=TfrmServiceWaitingIncidentPropsDlg.Create(Self,IBCQueryWait,IBCDataSourceWait);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure Tframe37ServiceDispatcher.ShowWaitingIncidentRunDialog(const IncidentID:Integer);
var dialog:TfrmServiceWaitingIncidentRunDlg;
begin
     dialog:=TfrmServiceWaitingIncidentRunDlg.Create(Self,IBCQueryWait,IBCDataSourceWait);
     try
        if dialog.ShowModal=mrOk then
        begin
             RunWaitingIncident(IncidentID,dialog.AssignedUser,dialog.FinishDate);
             IBCQueryWait.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe37ServiceDispatcher.WaitingIncidentSelectionChanged;
var fProps,fRun:Boolean;
begin
     fProps:=False;
     fRun:=False;
     if (cxGridWaitTable.DataController.RecNo>0) then
     begin
          fProps:=True;
          fRun:=True;
     end;
     bbWaitingIncidentProps.Enabled:=fProps;
     bbWaitingIncidentRun.Enabled:=fRun;
end;

procedure Tframe37ServiceDispatcher.WhenPererabotkaSelectionChanged;
var fAccept:Boolean;
begin
     fAccept:=False;
     if (cxGridPerTable.DataController.RecNo>0) then
     begin
          fAccept:=True;
     end;
     bbPererabotkaAccept.Enabled:=fAccept;
end;

end.

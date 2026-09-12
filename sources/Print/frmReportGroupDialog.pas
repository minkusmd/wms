unit frmReportGroupDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxClasses, dxBar, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls,
  DialogTitle, MemDS, DBAccess, IBC, StdCtrls, cxLabel, cxNavigator, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  TfrmReportGroupDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManagerBar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCDataSourceReportGroup: TIBCDataSource;
    IBCQueryReportGroup: TIBCQuery;
    cxGrid_REPORTGROUPID: TcxGridDBColumn;
    cxGrid_TITLE: TcxGridDBColumn;
    btnOk: TButton;
    IBCTrDefaultUpdate: TIBCTransaction;
    bbSort: TdxBarButton;
    cxGrid_ORDERNO: TcxGridDBColumn;
    cxGrid_CODE: TcxGridDBColumn;
    procedure cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbSortClick(Sender: TObject);
  private
    { Private declarations }
    fChanged: Boolean;
    fReportGroupID: integer;
    procedure SelectionChanged;
    procedure SetReportGroupID(const Value: integer);
    procedure ShowAddNewReportGroupDialog;
    procedure ShowModifyReportGroupDialog;
    procedure DeleteReportGroup;
    procedure ShowSortDialog;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property ReportGroupID: integer read FReportGroupID write SetReportGroupID;
    property DataChanged: Boolean read fChanged;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
  frmReportGroupEditorDialog, frmChangeOrderNoDialog;

{$R *.dfm}

procedure TfrmReportGroupDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteReportGroup;
end;

procedure TfrmReportGroupDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyReportGroupDialog;
end;

procedure TfrmReportGroupDlg.bbNewClick(Sender: TObject);
begin
  ShowAddNewReportGroupDialog;
end;

procedure TfrmReportGroupDlg.bbSortClick(Sender: TObject);
begin
  ShowSortDialog;
end;

procedure TfrmReportGroupDlg.cxGridDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModify.Enabled then
  begin
    bbModifyClick(bbModify);
    AHandled := True;
  end;
end;

procedure TfrmReportGroupDlg.cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmReportGroupDlg.DeleteReportGroup;
begin
  if (IBCQueryReportGroup.FieldByName('REPORTGROUPID').asInteger = -1) then
  begin
    ShowErrorDialog('Nu se poate', 'Nu se poate sterge grupul implicit!');
    Exit;
  end;

  if ShowAskDialog('Stergere grup', Format('Doriti sa stergeti grupul "%s"?', [IBCQueryReportGroup.FieldByName('TITLE').AsString])) = mrYes then
  begin
    IBCTrDefaultUpdate.StartTransaction;
    try
      IBCQueryReportGroup.Delete;
      IBCTrDefaultUpdate.Commit;
    except
      on E: Exception do
      begin
        IBCTrDefaultUpdate.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmReportGroupDlg.Prepare;
begin
  IBCQueryReportGroup.Active := True;
  IBCQueryReportGroup.Locate('REPORTGROUPID', fReportGroupID, []);

  SelectionChanged;
end;

procedure TfrmReportGroupDlg.SelectionChanged;
var
  fAdd, fEdit, fDelete, fSort: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  fSort := cxGridDBTable.DataController.RecordCount > 1;
  if cxGridDBTable.DataController.RecNo > 0 then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbNew.Enabled := fAdd;
  bbModify.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbSort.Enabled := fSort;
end;

procedure TfrmReportGroupDlg.SetReportGroupID(const Value: integer);
begin
  fReportGroupID := Value;
end;

procedure TfrmReportGroupDlg.ShowAddNewReportGroupDialog;
var
  dialog: TfrmReportGroupEditorDlg;
begin
  dialog := TfrmReportGroupEditorDlg.Create(Self, IBCQueryReportGroup, IBCDataSourceReportGroup);
  try
    dialog.CreateNewGroup := True;
    if dialog.ShowModal = mrOk then
    begin
      fReportGroupID := IBCQueryReportGroup.FieldByName('REPORTGROUPID').AsInteger;
      fChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmReportGroupDlg.ShowModifyReportGroupDialog;
var
  dialog: TfrmReportGroupEditorDlg;
begin
  dialog := TfrmReportGroupEditorDlg.Create(Self, IBCQueryReportGroup, IBCDataSourceReportGroup);
  try
    dialog.CreateNewGroup := False;
    if dialog.ShowModal = mrOk then
    begin
      fReportGroupID := IBCQueryReportGroup.FieldByName('REPORTGROUPID').AsInteger;
      fChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmReportGroupDlg.ShowSortDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotReportGroups;
    if dialog.ShowModal = mrOK then
    begin
      IBCQueryReportGroup.Close;
      IBCQueryReportGroup.Active := True;
    end;
  finally
    dialog.Free;
  end;
end;

end.


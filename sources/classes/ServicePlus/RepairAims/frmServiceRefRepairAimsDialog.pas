unit frmServiceRefRepairAimsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, ExtCtrls, DBAccess, IBC, MemDS,
  cxImageComboBox, Menus, StdCtrls, cxButtons, cxLabel, cxCheckBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmServiceRefRepairAimsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryScop: TIBCQuery;
    IBCDataSourceScop: TIBCDataSource;
    cxGridTable_ANALITICAID: TcxGridDBColumn;
    cxGridTable_FLG_FOLDER: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_DESCRIPTION: TcxGridDBColumn;
    bbNew: TdxBarSubItem;
    bbNewAim: TdxBarButton;
    bbNewFolder: TdxBarButton;
    bbModifyItem: TdxBarButton;
    bbDeleteItem: TdxBarButton;
    btnOk: TcxButton;
    bbNavPrev: TdxBarButton;
    bbNavNext: TdxBarButton;
    bbNavHome: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    cxGridTable_ESTIMATED_HOURS: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    bbSortItems: TdxBarButton;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    cxGridTable_FLG_ENABLED: TcxGridDBColumn;
    cxGridTable_CREATED_BY_TITLE: TcxGridDBColumn;
    bbAimTaskTypes: TdxBarButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewAimClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure bbModifyItemClick(Sender: TObject);
    procedure bbDeleteItemClick(Sender: TObject);
    procedure bbNavNextClick(Sender: TObject);
    procedure bbNavPrevClick(Sender: TObject);
    procedure bbNavHomeClick(Sender: TObject);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTable_ESTIMATED_HOURSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbSortItemsClick(Sender: TObject);
    procedure bbAimTaskTypesClick(Sender: TObject);
  private
    { Private declarations }
    fCurrentParentID: integer;
    procedure NavigateToParent(const NewParentID: integer; const OldParentID: integer = -1);
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToHome;

    procedure SelectionChanged;

    procedure ShowCreateNewScopDialog;
    procedure ShowCreateNewScopFolderDialog;
    procedure ShowModifyScopDialog;
    procedure ShowModifyScopFolderDialog;
    procedure ShowDeleteScopFolder;
    procedure ShowDeleteScop;

    procedure ShowSortItemsDialog;

    procedure ShowTaskTypesEditorDialog;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, frmServiceRefRepairAimsEditorDialog,
  frmServiceRefRepairAimsFolderEditorDialog, frmChangeOrderNoDialog, frmServiceRefRepairAimsLinkTaskTypeDialog;

{$R *.dfm}
{ TfrmAnalyticsDlg }

procedure TfrmServiceRefRepairAimsDlg.bbDeleteItemClick(Sender: TObject);
begin
  if Assigned(cxGridTable.Controller.FocusedRow) then
  begin
    if cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex, cxGridTable_FLG_FOLDER.Index] = 1 then
      ShowDeleteScopFolder
    else
      ShowDeleteScop;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.bbModifyItemClick(Sender: TObject);
begin
  if Assigned(cxGridTable.Controller.FocusedRow) then
  begin
    if cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex, cxGridTable_FLG_FOLDER.Index] = 1 then
      ShowModifyScopFolderDialog
    else
      ShowModifyScopDialog;
  end;
end;

constructor TfrmServiceRefRepairAimsDlg.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TfrmServiceRefRepairAimsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (bbNavNext.Enabled) then
  begin
    bbNavNextClick(bbNavNext);
    AHandled := True;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmServiceRefRepairAimsDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and (Shift = []) and (bbNavNext.Enabled) then
    NavigateForward
  else if (Key = 8) and (Shift = []) and (bbNavPrev.Enabled) then
    NavigateBack;
end;

procedure TfrmServiceRefRepairAimsDlg.cxGridTable_ESTIMATED_HOURSGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridTable_FLG_FOLDER.Index]) and Not VarIsNull(ARecord.Values[cxGridTable_ESTIMATED_HOURS.Index]) then
  begin
    if ARecord.Values[cxGridTable_FLG_FOLDER.Index] = 1 then
      AText := ''
    else
      AText := IntToStr(ARecord.Values[cxGridTable_ESTIMATED_HOURS.Index]);
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.bbAimTaskTypesClick(Sender: TObject);
begin
  ShowTaskTypesEditorDialog;
end;

procedure TfrmServiceRefRepairAimsDlg.bbNavHomeClick(Sender: TObject);
begin
  NavigateToHome;
end;

procedure TfrmServiceRefRepairAimsDlg.bbNavNextClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmServiceRefRepairAimsDlg.bbNavPrevClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmServiceRefRepairAimsDlg.bbNewFolderClick(Sender: TObject);
begin
  ShowCreateNewScopFolderDialog;
end;

procedure TfrmServiceRefRepairAimsDlg.bbSortItemsClick(Sender: TObject);
begin
  ShowSortItemsDialog;
end;

procedure TfrmServiceRefRepairAimsDlg.bbNewAimClick(Sender: TObject);
begin
  ShowCreateNewScopDialog;
end;

procedure TfrmServiceRefRepairAimsDlg.NavigateBack;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT PARENTID FROM SC_REF_INCIDENT_SCOP WHERE SCOPID=:id';
    Query.ParamByName('id').AsInteger := fCurrentParentID;
    Query.ExecSQL;
    if Query.Eof then
      NavigateToHome
    else
    begin
      NavigateToParent(Query.Fields[0].AsInteger, fCurrentParentID);
    end;
  finally
    Query.Free;
  end;

end;

procedure TfrmServiceRefRepairAimsDlg.NavigateForward;
begin
  NavigateToParent(IBCQueryScop.FieldByName('SCOPID').AsInteger);
end;

procedure TfrmServiceRefRepairAimsDlg.NavigateToHome;
begin
  NavigateToParent(0);
end;

procedure TfrmServiceRefRepairAimsDlg.NavigateToParent(const NewParentID: integer; const OldParentID: integer);
begin
  IBCQueryScop.Close;
  IBCQueryScop.ParamByName('ParentID').AsInteger := NewParentID;
  IBCQueryScop.Active := True;
  if (OldParentID <> -1) then
    IBCQueryScop.Locate('SCOPID', OldParentID, []);
  fCurrentParentID := NewParentID;
  SelectionChanged;
end;

procedure TfrmServiceRefRepairAimsDlg.Prepare;
begin
  inherited;

  NavigateToHome;
  SelectionChanged;
end;

procedure TfrmServiceRefRepairAimsDlg.SelectionChanged;
var
  fHome, fPrev, fNext, fAddFolder, fAddItem, fModify, fDelete, fAimTaskTypes: Boolean;
  rowIndex: integer;
begin
  fHome := fCurrentParentID > 0;
  fPrev := fCurrentParentID > 0;
  fNext := false;
  fAddFolder := fCurrentParentID = 0;
  fAddItem := fCurrentParentID > 0;
  fModify := false;
  fDelete := false;
  fAimTaskTypes := false;
  rowIndex := cxGridTable.Controller.FocusedRowIndex;
  if (rowIndex >= 0) then
  begin
    fModify := True;
    fDelete := True;
    fNext := cxGridTable.DataController.Values[rowIndex, cxGridTable_FLG_FOLDER.Index] = 1;
    fAimTaskTypes := cxGridTable.DataController.Values[rowIndex, cxGridTable_FLG_FOLDER.Index] = 0;
  end;
  bbNavHome.Enabled := fHome;
  bbNavPrev.Enabled := fPrev;
  bbNavNext.Enabled := fNext;

  bbNewFolder.Enabled := fAddFolder;
  bbNewAim.Enabled := fAddItem;

  bbModifyItem.Enabled := fModify;
  bbDeleteItem.Enabled := fDelete;

  bbAimTaskTypes.Enabled := fAimTaskTypes;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowCreateNewScopDialog;
var
  dialog: TfrmServiceRefRepairAimsEditorDlg;
begin
  dialog := TfrmServiceRefRepairAimsEditorDlg.Create(Self, IBCQueryScop, IBCDataSourceScop);
  try
    dialog.CreateNewScop := True;
    dialog.ParentID := fCurrentParentID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowCreateNewScopFolderDialog;
var
  dialog: TfrmServiceRefRepairAimsFolderEditorDlg;
begin
  dialog := TfrmServiceRefRepairAimsFolderEditorDlg.Create(Self, IBCQueryScop, IBCDataSourceScop);
  try
    dialog.CreateNewFolderScop := True;
    dialog.ParentID := fCurrentParentID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowDeleteScop;
var
  s: string;
begin
  s := IBCQueryScop.FieldByName('TITLE').AsString;
  if ShowAskDialog('Удаление цели', Format('Вы хотите удалить цель "%s"?', [s])) = mrYes then
  begin
    IBCQueryScop.UpdateTransaction.StartTransaction;
    try
      IBCQueryScop.Delete;
      IBCQueryScop.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryScop.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowDeleteScopFolder;
var
  s: string;
begin
  s := IBCQueryScop.FieldByName('TITLE').AsString;
  if ShowAskDialog('Удаление папки', Format('Вы хотите удалить папку "%s"?', [s]), 'Папка должна быть пустой!') = mrYes then
  begin
    IBCQueryScop.UpdateTransaction.StartTransaction;
    try
      IBCQueryScop.Delete;
      IBCQueryScop.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryScop.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowModifyScopDialog;
var
  dialog: TfrmServiceRefRepairAimsEditorDlg;
begin
  dialog := TfrmServiceRefRepairAimsEditorDlg.Create(Self, IBCQueryScop, IBCDataSourceScop);
  try
    dialog.CreateNewScop := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowModifyScopFolderDialog;
var
  dialog: TfrmServiceRefRepairAimsFolderEditorDlg;
begin
  dialog := TfrmServiceRefRepairAimsFolderEditorDlg.Create(Self, IBCQueryScop, IBCDataSourceScop);
  try
    dialog.CreateNewFolderScop := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowSortItemsDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotSERVICE_Scop;
    dialog.ParentID := fCurrentParentID;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryScop.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsDlg.ShowTaskTypesEditorDialog;
var
  dialog: TfrmServiceRefRepairAimsLinkTaskTypeDlg;
begin
  dialog := TfrmServiceRefRepairAimsLinkTaskTypeDlg.Create(Self, IBCQueryScop, IBCDataSourceScop);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

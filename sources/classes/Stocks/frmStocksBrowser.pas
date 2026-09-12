unit frmStocksBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxStyles,
  DB, cxDBData, dxBar, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, ExtCtrls, Menus,
  StdCtrls, cxButtons, IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCheckBox,
  DBAccess, MemDS, cxClasses;

type
  TfrmStocksBrowserDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridStock: TcxGrid;
    cxGridStockTable: TcxGridDBTableView;
    cxGridStockTableID: TcxGridDBColumn;
    cxGridStockTableTITLE: TcxGridDBColumn;
    cxGridStockTableDSC: TcxGridDBColumn;
    cxGridStockLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbRemove: TdxBarButton;
    IBCQueryStock: TIBCQuery;
    IBCDataSourceStock: TIBCDataSource;
    IBCTrUpdateStocks: TIBCTransaction;
    cxGridStockTable_FLG_FOLDER: TcxGridDBColumn;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbHome: TdxBarButton;
    bbBack: TdxBarButton;
    bbForward: TdxBarButton;
    bbItem: TdxBarSubItem;
    bbNewFolder: TdxBarButton;
    bbAdditionalTools: TdxBarSubItem;
    bbChangeParent: TdxBarButton;
    bbSearch: TdxBarButton;
    cxGridStock_FLG_VISISIBLE_FOR_SALE: TcxGridDBColumn;
    cxGridStock_FLG_ADMINISTRATIA: TcxGridDBColumn;
    cxGridStock_FLG_RMA: TcxGridDBColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure bbRemoveClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridStockTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridStockTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbSearchClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure bbBackClick(Sender: TObject);
    procedure bbHomeClick(Sender: TObject);
    procedure bbForwardClick(Sender: TObject);
    procedure cxGridStockTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbChangeParentClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridStockTableTITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FSelectMode: Boolean;
    FListOfStocksChanged: Boolean;
    FStockID: integer;
    fCurrentParentID: integer;
    fRootParentID: integer;
    fInSearch: Boolean;
    fStockTitle: string;
    procedure SetSelectMode(const Value: Boolean);
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToStock(const StockID: integer);
    procedure NavigateSearch(const WhereConditions: string);
    procedure NavigateToHome(const RootID: integer);
    procedure EnableCondition(const ConditionIndex: integer; const CustomCondition: string = '');
    function ItemSelected: Boolean;
    procedure DeleteCurrentRecord;
    procedure SetListOfStocksChanged(const Value: Boolean);
    procedure SetStockID(const Value: integer);
    procedure ShowCreateNewStockDialog;
    procedure ShowModifyCurrentStockDialog;
    procedure SelectionChanged;
    procedure ShowSearchDialog;
    procedure ShowNewFolderDialog;
    procedure ShowChangeParentDialog;
  protected
    { Protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property StockID: integer read FStockID write SetStockID;
    property StockTitle: string read fStockTitle;
    property ListOfStocksChanged: Boolean read FListOfStocksChanged write SetListOfStocksChanged;
    function SelectStock(const DefaultStockID: integer = -1): Boolean;
    procedure BrowseStock(const DefaultStockID: integer = -1);
  end;

implementation

uses
  DataModuleAdditions, frmStockEditorDialog, SWNUtils, SWNSearchUnit, frmStockFolderEditorDialog,
  frmChangeParentFolderDialog, SWNSecurityFlags, SWNDBErrors, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmStocksDlg }

procedure TfrmStocksBrowserDlg.bbBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmStocksBrowserDlg.bbChangeParentClick(Sender: TObject);
begin
  ShowChangeParentDialog;
end;

procedure TfrmStocksBrowserDlg.bbForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmStocksBrowserDlg.bbHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
end;

procedure TfrmStocksBrowserDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyCurrentStockDialog;
end;

procedure TfrmStocksBrowserDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewStockDialog;
end;

procedure TfrmStocksBrowserDlg.bbNewFolderClick(Sender: TObject);
begin
  ShowNewFolderDialog;
end;

procedure TfrmStocksBrowserDlg.bbRemoveClick(Sender: TObject);
begin
  DeleteCurrentRecord;
end;

procedure TfrmStocksBrowserDlg.bbSearchClick(Sender: TObject);
begin
  ShowSearchDialog;
end;

procedure TfrmStocksBrowserDlg.btnOkClick(Sender: TObject);
begin
  if (IBCQueryStock.RecordCount > 0) and (not IBCQueryStock.FieldByName('StockID').IsNull) then
    ModalResult := mrOk;
end;

procedure TfrmStocksBrowserDlg.cxGridStockTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if cxGridStockTable.DataController.RecNo > 0 then
  begin
    if IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 1 then
      NavigateForward
    else
    begin
      if ItemSelected then
        ModalResult := mrOk;
    end;
  end;
end;

procedure TfrmStocksBrowserDlg.cxGridStockTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmStocksBrowserDlg.cxGridStockTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = 13) then
  begin
    // ENTER
    if (cxGridStockTable.DataController.RecNo > 0) then
    begin
      if IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 1 then
        NavigateForward
      else if ItemSelected then
        ModalResult := mrOk;
    end;
  end
  else
    // Back Space
if (Key = 8) and (Shift = []) then
    NavigateBack;
end;

procedure TfrmStocksBrowserDlg.cxGridStockTableTITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridStockTable_FLG_FOLDER.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmStocksBrowserDlg.DeleteCurrentRecord;
var
  S1, S2: string;
begin
  if IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    S1 := 'Stergere grup';
    S2 := 'Doriti sa stergeti grupul de depozite "%s"?';
  end
  else
  begin
    S1 := 'Stergere depozit';
    S2 := 'Doriti sa stergeti depozitul "%s"?';
  end;
  S2 := Format(S2, [IBCQueryStock.FieldByName('TITLE').asString]);
  if ShowAskDialog(S1, S2) = mrYes then
  begin
    try
      IBCQueryStock.Delete;
      IBCTrUpdateStocks.Commit;
      FListOfStocksChanged := True;
    except
      on E: Exception do
      begin
        IBCTrUpdateStocks.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmStocksBrowserDlg.EnableCondition(const ConditionIndex: integer; const CustomCondition: string);
begin
  fInSearch := False;
  IBCQueryStock.Close;
  case ConditionIndex of
    // forward
    0:
      IBCQueryStock.FilterSQL := 'PARENTID=:ParentID';
    // backward
    1:
      IBCQueryStock.FilterSQL := 'PARENTID=(SELECT PARENTID FROM VW_TS_STOCKS WHERE STOCKID=:ParentID)';
    // search
    2:
      IBCQueryStock.FilterSQL := CustomCondition;
  end;
end;

procedure TfrmStocksBrowserDlg.FormCreate(Sender: TObject);
begin
  FSelectMode := True;
  FListOfStocksChanged := False;
  FStockID := -1;
  fRootParentID := 0;
  fInSearch := False;
  fStockTitle := '';
end;

function TfrmStocksBrowserDlg.ItemSelected: Boolean;
begin
  Result := False;
  if (cxGridStockTable.DataController.RecNo > 0) and (IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 0) then
  begin
    if FSelectMode then
    begin
      FStockID := IBCQueryStock.FieldByName('STOCKID').AsInteger;
      fStockTitle := IBCQueryStock.FieldByName('TITLE').asString;
      Result := True;
    end;
  end;
end;

procedure TfrmStocksBrowserDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
    (Self) then
    Position := poDesigned;

  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
  begin
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridStockTable);
  end;
end;

procedure TfrmStocksBrowserDlg.BrowseStock(const DefaultStockID: integer);
begin
  SelectMode := False;
  StockID := DefaultStockID;
  ShowModal;
end;

procedure TfrmStocksBrowserDlg.NavigateBack;
var
  ParentID: integer;
begin
  if cxGridStockTable.DataController.RecNo > 0 then
  begin
    ParentID := IBCQueryStock.FieldByName('PARENTID').AsInteger;
  end
  else
  begin
    if fCurrentParentID = -1 then
      ParentID := fRootParentID
    else
      ParentID := fCurrentParentID;
  end;

  if (ParentID > 0) and (ParentID <> fRootParentID) then
  begin
    EnableCondition(1); // Browse Backward
    IBCQueryStock.ParamByName('ParentID').AsInteger := ParentID;
    IBCQueryStock.Open;
    fCurrentParentID := IBCQueryStock.FieldByName('PARENTID').AsInteger;
    IBCQueryStock.Locate('STOCKID', ParentID, []);
  end;
end;

procedure TfrmStocksBrowserDlg.NavigateForward;
var
  ParentID: integer;
begin
  if (IBCQueryStock.RecordCount = 0) then
    ParentID := 0
  else
    ParentID := IBCQueryStock.FieldByName('STOCKID').AsInteger;

  EnableCondition(0); // Browse Forward
  IBCQueryStock.ParamByName('ParentID').AsInteger := ParentID;
  fCurrentParentID := ParentID;
  IBCQueryStock.Open;
  SelectionChanged;
end;

procedure TfrmStocksBrowserDlg.NavigateSearch(const WhereConditions: string);
begin
  EnableCondition(2, WhereConditions); // Search
  fInSearch := True;
  IBCQueryStock.Open;
  fCurrentParentID := -1;
  SelectionChanged;
end;

procedure TfrmStocksBrowserDlg.NavigateToHome(const RootID: integer);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryStock.ParamByName('ParentID').AsInteger := RootID;
  fCurrentParentID := RootID;
  IBCQueryStock.Open;
  SelectionChanged;
end;

procedure TfrmStocksBrowserDlg.NavigateToStock(const StockID: integer);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryStock.ParamByName('ParentID').AsInteger := StockID;
  IBCQueryStock.Open;
  IBCQueryStock.Locate('STOCKID', StockID, []);
  fCurrentParentID := IBCQueryStock.FieldByName('ParentID').AsInteger;
  SelectionChanged;
end;

procedure TfrmStocksBrowserDlg.Prepare;
begin
  SetupSecurityItems;

  if not FSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

  if FStockID > 0 then
    NavigateToStock(FStockID)
  else
  begin
    if fRootParentID > 0 then
      NavigateToHome(fRootParentID)
    else
      NavigateForward;
  end;
  SelectionChanged;

  cxGridStockTableTITLE.Selected := True;
  cxGridStockTableTITLE.Focused := True;
end;

procedure TfrmStocksBrowserDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);

  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
  begin
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridStockTable);
  end;
end;

procedure TfrmStocksBrowserDlg.SelectionChanged;
var
  fHome, fBack, fForw, fNewFolder, fNewStock, fEdit, fDel, fChangeParent: Boolean;
begin
  fNewStock := (not fInSearch) and (fCurrentParentID > 0);

  fForw := False;
  fNewFolder := (not fInSearch) and (fCurrentParentID = 0);
  // New folder + Security
  fEdit := False;
  fDel := False;
  fChangeParent := False;
  if cxGridStockTable.DataController.RecNo > 0 then
  begin
    fHome := fCurrentParentID <> fRootParentID;
    fBack := fCurrentParentID <> fRootParentID;
    fForw := IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 1;

    fEdit := True; // Edit + Security
    fDel := True; // Delete + Security
    fChangeParent := True; // Change Parent + Security
  end
  else
  begin
    fBack := (fCurrentParentID > -1) and (fRootParentID <> fCurrentParentID);
    fHome := fBack or (fRootParentID = 0);
  end;

  bbHome.Enabled := fHome;
  bbBack.Enabled := fBack;
  bbForward.Enabled := fForw;

  bbNewFolder.Enabled := fNewFolder;
  bbNew.Enabled := fNewStock;
  bbModify.Enabled := fEdit;
  bbRemove.Enabled := fDel;

  bbChangeParent.Enabled := fChangeParent;
end;

function TfrmStocksBrowserDlg.SelectStock(const DefaultStockID: integer): Boolean;
begin
  SelectMode := True;
  StockID := DefaultStockID;
  Result := ShowModal = mrOk;
end;

procedure TfrmStocksBrowserDlg.SetListOfStocksChanged(const Value: Boolean);
begin
  FListOfStocksChanged := Value;
end;

procedure TfrmStocksBrowserDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmStocksBrowserDlg.SetStockID(const Value: integer);
begin
  FStockID := Value;
end;

procedure TfrmStocksBrowserDlg.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Склады_Создать) then
  begin
    bbNewFolder.Visible := ivNever;
    bbNew.Visible := ivNever;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Склады_Редактировать) then
  begin
    bbModify.Visible := ivNever;
    bbChangeParent.Visible := ivNever;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Склады_Удалить) then
  begin
    bbRemove.Visible := ivNever;
  end;

  if bbAdditionalTools.ItemLinks.VisibleItemCount = 0 then
    bbAdditionalTools.Visible := ivNever;
  if bbItem.ItemLinks.VisibleItemCount = 0 then
    bbItem.Visible := ivNever;
  if dxBarPopupMenu.ItemLinks.VisibleItemCount = 0 then
    cxGridStockTable.PopupMenu := nil;

end;

procedure TfrmStocksBrowserDlg.ShowChangeParentDialog;
var
  dialog: TfrmChangeParentFolderDlg;
  oldStockID: integer;
begin
  oldStockID := IBCQueryStock.FieldByName('STOCKID').AsInteger;
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtSTOCKS;
    dialog.FolderObjectID := IBCQueryStock.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(oldStockID, IBCQueryStock.FieldByName('TITLE').asString);
    if dialog.ShowModal = mrOk then
    begin
      NavigateToStock(oldStockID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmStocksBrowserDlg.ShowCreateNewStockDialog;
var
  editor: TfrmStockEditorDlg;
begin
  editor := TfrmStockEditorDlg.Create(Self, IBCQueryStock, IBCDataSourceStock);
  try
    editor.CreateNewRecord := True;
    editor.ParentID := fCurrentParentID;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure TfrmStocksBrowserDlg.ShowModifyCurrentStockDialog;
var
  editor_stock: TfrmStockEditorDlg;
  editor_folder: TfrmStockFolderEditorDlg;
begin
  if IBCQueryStock.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    editor_folder := TfrmStockFolderEditorDlg.Create(Self, IBCQueryStock, IBCDataSourceStock);
    try
      editor_folder.ShowModal;
    finally
      editor_folder.Free;
    end;
  end
  else
  begin
    editor_stock := TfrmStockEditorDlg.Create(Self, IBCQueryStock, IBCDataSourceStock);
    try
      editor_stock.CreateNewRecord := False;
      editor_stock.ShowModal;
    finally
      editor_stock.Free;
    end;
  end;
end;

procedure TfrmStocksBrowserDlg.ShowNewFolderDialog;
var
  dialog: TfrmStockFolderEditorDlg;
begin
  dialog := TfrmStockFolderEditorDlg.Create(Self, IBCQueryStock, IBCDataSourceStock);
  try
    dialog.CreateNewFolder := True;
    dialog.ParentID := fCurrentParentID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmStocksBrowserDlg.ShowSearchDialog;
var
  search: TSWNSearchDialog;
  i: integer;
  Criteria: TSearchCriteria;
  S: string;
begin
  S := '';
  search := TSWNSearchDialog.Create(Self);
  try
    if search.GetSearchCritera(stStocks) then
    begin
      for i := 0 to search.SearchCriteriasCount - 1 do
      begin
        Criteria := search.SearchCriterias[i];
        case Criteria.SearchField of
          sfID:
            AddConditionToWHERE(S, 'STOCKID=' + Criteria.SearchText);
          sfName:
            AddConditionToWHERE(S, 'LOWER(TITLE) LIKE ' + PrepareTextForLIKE(Criteria.SearchText));
        end;
      end;
    end;
  finally
    search.Free;
  end;
  if (S <> '') then
    NavigateSearch(S);
end;

end.


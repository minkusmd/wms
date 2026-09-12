unit frmSyssEditorWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  DB, cxDBData, Menus, dxBar, IBC,
  StdCtrls, cxButtons, cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, ExtCtrls, DialogTitle,
  dxPSCore,

  dxPScxGridLnk,
  Vcl.ActnList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxDBLookupComboBox,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers, System.Actions,
  dxPScxCommon, DBAccess, MemDS, cxClasses, dxUIAClasses;

type
  TfrmSelectSyssEditorWin = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    pnFolders: TPanel;
    pnData: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewGroup: TdxBarButton;
    bbModifyGroup: TdxBarButton;
    bbDeleteItem: TdxBarButton;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbNewItem: TdxBarButton;
    bbModifyItem: TdxBarButton;
    cxGridGroupsTable: TcxGridDBTableView;
    cxGridGroupsLevel: TcxGridLevel;
    cxGridGroups: TcxGrid;
    cxGridData: TcxGrid;
    cxGridDataTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGridGroupsCol_ID: TcxGridDBColumn;
    cxGridGroupsCol_TITLE: TcxGridDBColumn;
    IBCQuerySYSS: TIBCQuery;
    IBCTrUpdateSYSS: TIBCTransaction;
    IBCDataSourceSYSS: TIBCDataSource;
    IBCDataSourceSYSSData: TIBCDataSource;
    IBCQuerySYSSData: TIBCQuery;
    cxGridDataCol_ID: TcxGridDBColumn;
    cxGridDataCol_TITLE: TcxGridDBColumn;
    cxGridDataCol_VALUE_INT2: TcxGridDBColumn;
    cxGridDataCol_ValueSTR: TcxGridDBColumn;
    IBCQuerySYSSLookup: TIBCQuery;
    IBCDataSourceSYSSLookup: TIBCDataSource;
    dxBarPopupMenuData: TdxBarPopupMenu;
    dxBarPopupMenuGroups: TdxBarPopupMenu;
    Panel2: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cxSplitter: TcxSplitter;
    cxGridDataCol_VALUE_INT1: TcxGridDBColumn;
    cxGridDataCol_IMG: TcxGridDBColumn;
    bbPrint: TdxBarButton;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLink1: TdxGridReportLink;
    SysSActionList: TActionList;
    actBrandImage: TAction;
    bbBrandImages: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    procedure cxGridGroupsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewGroupClick(Sender: TObject);
    procedure cxGridDataTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbModifyGroupClick(Sender: TObject);
    procedure bbNewItemClick(Sender: TObject);
    procedure bbModifyItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbDeleteItemClick(Sender: TObject);
    procedure cxGridDataTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbPrintClick(Sender: TObject);
    procedure cxGridGroupsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actBrandImageUpdate(Sender: TObject);
    procedure actBrandImageExecute(Sender: TObject);
    procedure cxGridDataTableKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    FSelectMode: Boolean;
    fFixedView: Boolean;
    FSYSSID: integer;
    fSyssTitle: String;
    fHideTree: Boolean;
    fItemsChanged: Boolean;
    fParentID: integer;
    FCanSelectFolder: Boolean;
    FPartialCatalogAccess: Boolean;
    procedure ShowAddNewGroupDialog;
    procedure WhenSyssGroupChanged;
    procedure SetupDetailsColumns;
    procedure WhenSyssDetialsChanged;
    procedure ShowModifySyssGroupEditor;
    procedure ShowAddNewDetailsDialog;
    procedure ShowModifySelectedDetailsDialog;
    procedure SetSelectMode(const Value: Boolean);
    procedure DeleteCurrentDetail;

    procedure SelectDetailItem;
    procedure SelectMasterItem;
    procedure SetSYSSID(const Value: integer);
    procedure SetCanSelectFolder(const Value: Boolean);
    procedure SetPartialCatalogAccess(const Value: Boolean);

  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property SYSSID: integer read FSYSSID write SetSYSSID;
    property SyssTitle: string read fSyssTitle;
    property ItemsChanged: Boolean read fItemsChanged;
    property CanSelectFolder: Boolean read FCanSelectFolder write SetCanSelectFolder;
    property PartialCatalogAccess: Boolean read FPartialCatalogAccess write SetPartialCatalogAccess;

    procedure SetDefaultGroup(const GroupID: integer; const HideTree: Boolean = True);
  end;

implementation

uses frmSyssFolderEditor, frmSyssDataEditor, SWNUtils, SWNConst,
  SWNValueStorageUnit, SWNSecurityFlags, frmBrandsImagesDialog, frmMergeSyssUnit, DataModuleDB;

{$R *.dfm}

procedure TfrmSelectSyssEditorWin.actBrandImageExecute(Sender: TObject);
var
  dialog: TfrmBrandsImagesDlg;
begin
  dialog := TfrmBrandsImagesDlg.Create(Self, IBCQuerySYSSData, IBCDataSourceSYSSData);
  try
    dialog.ShowModal;
  finally
     dialog.Free;
  end;
end;

procedure TfrmSelectSyssEditorWin.actBrandImageUpdate(Sender: TObject);
begin
  if (IBCQuerySYSS.FieldbyName('SYSSID').AsInteger=1) then  // producatori
    bbBrandImages.Visible := ivAlways
  else
    bbBrandImages.Visible := ivNever;
end;

procedure TfrmSelectSyssEditorWin.bbDeleteItemClick(Sender: TObject);
begin
  DeleteCurrentDetail;
end;

procedure TfrmSelectSyssEditorWin.bbModifyGroupClick(Sender: TObject);
begin
  ShowModifySyssGroupEditor;
end;

procedure TfrmSelectSyssEditorWin.bbModifyItemClick(Sender: TObject);
begin
  ShowModifySelectedDetailsDialog;
end;

procedure TfrmSelectSyssEditorWin.bbNewGroupClick(Sender: TObject);
begin
  ShowAddNewGroupDialog;
end;

procedure TfrmSelectSyssEditorWin.bbNewItemClick(Sender: TObject);
begin
  ShowAddNewDetailsDialog;
end;

procedure TfrmSelectSyssEditorWin.bbPrintClick(Sender: TObject);
var
  B: Boolean;
begin
  B := cxGridDataCol_IMG.Visible;
  if B then
    cxGridDataCol_IMG.Visible := False;
  try
    if fHideTree then
      dxComponentPrinterLink1.ReportTitle.Text := dtDialogTitle.Title
    else
    begin
      dxComponentPrinterLink1.ReportTitle.Text := 'Nomenclator: ' + IBCQuerySYSS.FieldByName('TITLE').AsString;
    end;
    dxComponentPrinter.Preview;
  finally
    if B then
      cxGridDataCol_IMG.Visible := True;
  end;
end;

procedure TfrmSelectSyssEditorWin.btnOkClick(Sender: TObject);
begin
  SelectDetailItem;
end;

procedure TfrmSelectSyssEditorWin.cxGridDataTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if FSelectMode then
  begin
    SelectDetailItem;
    AHandled := True;
  end
  else if bbModifyItem.Enabled and (bbModifyItem.Visible = ivAlways) then
  begin
    bbModifyItemClick(bbModifyItem);
    AHandled := True;
  end;
end;

procedure TfrmSelectSyssEditorWin.cxGridDataTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WhenSyssDetialsChanged;
end;

procedure TfrmSelectSyssEditorWin.cxGridDataTableKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  if (Key=Ord('c') ) and (ssCtrl in Shift) then
  begin
    CopyCellToClipboard(cxGridData);
    Key := 0;
  end;
end;

procedure TfrmSelectSyssEditorWin.cxGridGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGroup.Enabled and (bbModifyGroup.Visible = ivAlways) then
  begin
    bbModifyGroupClick(bbModifyGroup);
    AHandled := True;
  end;
end;

procedure TfrmSelectSyssEditorWin.cxGridGroupsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WhenSyssGroupChanged;
  SetupDetailsColumns;
end;

procedure TfrmSelectSyssEditorWin.cxGridGroupsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 13) and (Shift = [ssCtrl]) and FCanSelectFolder then
  begin
    SelectMasterItem;
  end;
end;

procedure TfrmSelectSyssEditorWin.DeleteCurrentDetail;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Sterge inregistrarea' + #13#10 + IBCQuerySYSSData.FieldByName('TITLE').AsString + '?') = mrYes
  then
  begin
    IBCQuerySYSSData.Delete;
    IBCQuerySYSSData.UpdateTransaction.Commit;
    fItemsChanged := True;
  end;
end;

procedure TfrmSelectSyssEditorWin.dxBarButton1Click(Sender: TObject);
var
  d: TfrmMergeSysSDlg;
begin
  d := TfrmMergeSysSDlg.Create(self, dmdb.ibcconnection);
  try
    d.OldID := ibcquerySysSData.FieldByName('SYSSID').AsInteger;
    d.showModal;
  finally
    d.Free;
  end;

end;

procedure TfrmSelectSyssEditorWin.FormCreate(Sender: TObject);
begin
  FSelectMode := False;
  fFixedView := False;
  FSYSSID := -1;
  fHideTree := False;
  fItemsChanged := False;
  cxGridDataCol_TITLE.Selected := True;
  cxGridDataCol_TITLE.Focused := True;
  fParentID := 0;
  FCanSelectFolder := False;
end;

procedure TfrmSelectSyssEditorWin.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Format('%S_PARENTID=%d', [Self.Name, fParentID]));
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.ReadFormPos(Self);

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    begin
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGroupsTable);
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDataTable);
      if cxSplitter.Visible then
      begin
        pnFolders.Width := AppUserConfigStorage.IntValues.GetValue(pnFolders.Name, pnFolders.Width);
      end;
    end;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmSelectSyssEditorWin.Prepare;
begin
  SetupSecurityItems;

  WhenSyssGroupChanged;
  WhenSyssDetialsChanged;

  if Not FSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

  IBCQuerySYSS.Open;
  IBCQuerySYSSData.Open;
  if FSYSSID <> -1 then
    IBCQuerySYSSData.Locate('SYSSID', FSYSSID, []);

  if fFixedView and fHideTree then
  begin
    dtDialogTitle.Title := 'Nomenclator: ' + IBCQuerySYSS.FieldByName('TITLE').asWideString;
  end;
end;

procedure TfrmSelectSyssEditorWin.SaveStates;
var
  N: integer;
begin
  AppUserConfigStorage.OpenSection(Format('%S_PARENTID=%d', [Self.Name, fParentID]));
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    begin
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGroupsTable);
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDataTable);
      if cxSplitter.Visible then
      begin
        N := pnFolders.Width;
        if N < cxSplitter.MinSize then
          N := cxSplitter.MinSize;
        AppUserConfigStorage.IntValues.SetValue(pnFolders.Name, N);
      end;
    end;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmSelectSyssEditorWin.SelectDetailItem;
begin
  FSYSSID := IBCQuerySYSSData.FieldByName('SYSSID').AsInteger;
  fSyssTitle := IBCQuerySYSSData.FieldByName('TITLE').AsString;
  ModalResult := mrOk;
end;

procedure TfrmSelectSyssEditorWin.SelectMasterItem;
begin
  FSYSSID := IBCQuerySYSS.FieldByName('SYSSID').AsInteger;
  fSyssTitle := IBCQuerySYSS.FieldByName('TITLE').AsString;
  ModalResult := mrOk;
end;

procedure TfrmSelectSyssEditorWin.SetCanSelectFolder(const Value: Boolean);
begin
  FCanSelectFolder := Value;
end;

procedure TfrmSelectSyssEditorWin.SetDefaultGroup(const GroupID: integer; const HideTree: Boolean = True);
begin
  IBCQuerySYSS.FilterSQL := 'SYSSID=:GroupID';
  IBCQuerySYSS.ParamByName('GroupID').AsInteger := GroupID;
  fParentID := GroupID;
  fFixedView := True;
  fHideTree := HideTree;
  ActiveControl := cxGridData;
  if HideTree then
  begin
    pnFolders.Visible := False;
    cxSplitter.Visible := False;
    Width := Width - pnFolders.Width;
  end;
end;

procedure TfrmSelectSyssEditorWin.SetPartialCatalogAccess(const Value: Boolean);
begin
    FPartialCatalogAccess := Value;
end;

procedure TfrmSelectSyssEditorWin.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmSelectSyssEditorWin.SetSYSSID(const Value: integer);
begin
  FSYSSID := Value;
end;

procedure TfrmSelectSyssEditorWin.SetupDetailsColumns;
var
  valType: integer;
begin
  // setup Column for details
  valType := IBCQuerySYSS.FieldByName('VALUE_INT_TYPE').AsInteger;
  if valType > 0 then
  begin
    if valType = 1 then
    begin
      cxGridDataCol_VALUE_INT1.Visible := True;
      cxGridDataCol_VALUE_INT1.Caption := IBCQuerySYSS.FieldByName('TITLE_INT').AsString;
    end
    else if valType = 2 then
    begin
      cxGridDataCol_VALUE_INT2.Visible := True;
      cxGridDataCol_VALUE_INT2.Caption := IBCQuerySYSS.FieldByName('TITLE_INT').AsString;
      IBCQuerySYSSLookup.Close;
      IBCQuerySYSSLookup.Open;
    end;
  end
  else
  begin
    cxGridDataCol_VALUE_INT1.Visible := False;
    cxGridDataCol_VALUE_INT2.Visible := False;
  end;

  if IBCQuerySYSS.FieldByName('VALUE_STR').IsNull then
  begin
    cxGridDataCol_ValueSTR.Visible := False;
  end
  else
  begin
    cxGridDataCol_ValueSTR.Visible := True;
    cxGridDataCol_ValueSTR.Caption := IBCQuerySYSS.FieldByName('VALUE_STR').AsString;
  end;
end;

procedure TfrmSelectSyssEditorWin.SetupSecurityItems;
var
  visGroup, visItem: Boolean;
begin
  if fPartialCatalogAccess then
  begin
        bbNewGroup.Visible := ivNever;
        bbNewItem.Visible := ivAlways;
        bbModifyItem.Visible := ivAlways;
        bbDeleteItem.Visible := ivNever;
  end
  else
  begin
      if Not SecurityFlagEnabled(cSecurityFlag_Справочники_СС_Создать) then
      begin
        bbNewGroup.Visible := ivNever;
        bbNewItem.Visible := ivNever;
      end;
      if Not SecurityFlagEnabled(cSecurityFlag_Справочники_СС_Редактироватi) then
      begin
        bbModifyGroup.Visible := ivNever;
        bbModifyItem.Visible := ivNever;
      end;
      if Not SecurityFlagEnabled(cSecurityFlag_Справочники_СС_Удалитi) then
      begin
        bbDeleteItem.Visible := ivNever;
      end;

      visGroup := (bbNewGroup.Visible = ivAlways) or (bbModifyGroup.Visible = ivAlways);
      visItem := (bbNewItem.Visible = ivAlways) or (bbModifyItem.Visible = ivAlways) or (bbDeleteItem.Visible = ivAlways);

      if Not visGroup then
      begin
        dxBarManagerBar1.Visible := False;
        dxBarDockControl1.Visible := False;
      end;
      if Not visItem then
      begin
        dxBarManagerBar2.Visible := False;
        dxBarDockControl2.Visible := False;
      end;

      if dxBarPopupMenuGroups.ItemLinks.VisibleItemCount = 0 then
        cxGridGroupsTable.PopupMenu := nil;
      if dxBarPopupMenuData.ItemLinks.VisibleItemCount = 0 then
        cxGridDataTable.PopupMenu := nil;
  end;

end;

procedure TfrmSelectSyssEditorWin.ShowAddNewDetailsDialog;
var
  editor: TfrmSyssDataEditorDlg;
  s1, s2: String;
begin
  s1 := IBCQuerySYSS.FieldByName('TITLE_INT').AsString;
  s2 := IBCQuerySYSS.FieldByName('VALUE_STR').AsString;

  editor := TfrmSyssDataEditorDlg.Create(Self, IBCQuerySYSSData, IBCDataSourceSYSSData);
  try
    editor.SetGroupTitle(IBCQuerySYSS.FieldByName('TITLE').asWideString);
    editor.SetDetails(IBCQuerySYSS.FieldByName('VALUE_INT_TYPE').AsInteger, Not IBCQuerySYSS.FieldByName('VALUE_STR').IsNull, s1, s2);
    if (IBCQuerySYSS.FieldByName('VALUE_INT_TYPE').AsInteger = 2) then
      editor.SetValueINTDataSource(IBCDataSourceSYSSLookup);

    editor.CreateNewRecord := True;
    if editor.ShowModal = mrOk then
    begin
      fItemsChanged := True;
      IBCQuerySYSSData.Refresh;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmSelectSyssEditorWin.ShowAddNewGroupDialog;
var
  editor: TfrmSyssFolderEditorDlg;
begin
  editor := TfrmSyssFolderEditorDlg.Create(Self, IBCQuerySYSS, IBCDataSourceSYSS);
  try
    editor.CreateNewGroup := True;
    if editor.ShowModal = mrOk then
    begin
      IBCQuerySYSS.Refresh;
      WhenSyssGroupChanged;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmSelectSyssEditorWin.ShowModifySelectedDetailsDialog;
var
  editor: TfrmSyssDataEditorDlg;
  s1, s2: String;
begin
  s1 := IBCQuerySYSS.FieldByName('TITLE_INT').AsString;
  s2 := IBCQuerySYSS.FieldByName('VALUE_STR').AsString;

  editor := TfrmSyssDataEditorDlg.Create(Self, IBCQuerySYSSData, IBCDataSourceSYSSData);
  try
    editor.SetGroupTitle(IBCQuerySYSS.FieldByName('TITLE').asWideString);
    editor.SetDetails(IBCQuerySYSS.FieldByName('VALUE_INT_TYPE').AsInteger, Not IBCQuerySYSS.FieldByName('VALUE_STR').IsNull, s1, s2);
    if (IBCQuerySYSS.FieldByName('VALUE_INT_TYPE').AsInteger = 2) then
      editor.SetValueINTDataSource(IBCDataSourceSYSSLookup);

    editor.CreateNewRecord := False;
    if editor.ShowModal = mrOk then
    begin
      IBCQuerySYSS.Refresh;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmSelectSyssEditorWin.ShowModifySyssGroupEditor;
var
  editor: TfrmSyssFolderEditorDlg;
begin
  editor := TfrmSyssFolderEditorDlg.Create(Self, IBCQuerySYSS, IBCDataSourceSYSS);
  try
    editor.CreateNewGroup := False;
    if editor.ShowModal = mrOk then
    begin
      IBCQuerySYSS.Refresh;
      WhenSyssGroupChanged;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmSelectSyssEditorWin.WhenSyssDetialsChanged;
var
  f1, f2, f3: Boolean;
begin
  f1 := (cxGridGroupsTable.DataController.RecNo > 0); // + Security
  f2 := False;
  f3 := False;
  if cxGridDataTable.DataController.RecNo > 0 then
  begin
    f2 := True; // + Security
    f3 := True; // + Security
  end;

  bbNewItem.Enabled := f1;
  bbModifyItem.Enabled := f2;
  bbDeleteItem.Enabled := f3;
end;

procedure TfrmSelectSyssEditorWin.WhenSyssGroupChanged;
var
  f1, f2: Boolean;
begin
  f1 := True and (Not fFixedView); // + Security
  f2 := False;
  if cxGridGroupsTable.DataController.RecNo > 0 then
  begin
    f2 := True and (Not fFixedView); // + Security
  end;

  bbNewGroup.Enabled := f1;
  bbModifyGroup.Enabled := f2;
end;

end.

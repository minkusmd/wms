unit frmPrintWizardDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, frmPrintEngineWindow, Dialogs, DialogTitle, jpeg, Menus,
  cxStyles, cxCustomData,
  DB, cxDBData, DBAccess, IBC, dxBar,
  StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, ExtCtrls,
  cxButtons, cxCheckBox,
  cxGridPopupMenu, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxControls, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, cxContainer,
  cxGridCustomPopupMenu, cxClasses, MemDS, cxGridCustomView, dxUIAClasses;

type
  TOnPrintWizardSetupReportParams = procedure(const ReportParams: TReportParamsList) of object;

  TfrmPrintWizardDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnBack: TcxButton;
    btnNext: TcxButton;
    btnPrint: TcxButton;
    btnClose: TcxButton;
    IBCDataSourceReports: TIBCDataSource;
    IBCQueryReports: TIBCQuery;
    pnClient: TPanel;
    cxPageControl: TcxPageControl;
    tbsReports: TcxTabSheet;
    cxGridReports: TcxGrid;
    cxGridReportsTable: TcxGridDBTableView;
    cxGridReports_REPORTID: TcxGridDBColumn;
    cxGridReports_TITLE: TcxGridDBColumn;
    cxGridReportsLevel: TcxGridLevel;
    tbsParams: TcxTabSheet;
    cxPageControlParams: TcxPageControl;
    tbsSampleTab: TcxTabSheet;
    cxLabel2: TLabel;
    lbReportTitle: TLabel;
    cxLabel1: TLabel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbEditReport: TdxBarButton;
    Label1: TLabel;
    Label2: TLabel;
    bbTools: TdxBarSubItem;
    bbNewReport: TdxBarButton;
    bbDeleteReport: TdxBarButton;
    cxGridReports_TABSHEETINDEX: TcxGridDBColumn;
    bbCopyReport: TdxBarButton;
    bbChangeOrder: TdxBarButton;
    bbShowByDocType: TdxBarButton;
    cxGridReports_DOCTYPEID: TcxGridDBColumn;
    IBCTrReportUpdate: TIBCTransaction;
    cxGridReports_FLG_DISABLED: TcxGridDBColumn;
    cxGridReports_FLG_NO_DIRECT_PRINT: TcxGridDBColumn;
    tbsParam_PriceLabel: TcxTabSheet;
    dxBarDockControlPriceLabels: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbPriceLabel_Add: TdxBarButton;
    bbPriceLabel_Remove: TdxBarButton;
    bbPriceLabel_ImportFromDoc: TdxBarButton;
    cxGridPriceLabelsTable: TcxGridDBTableView;
    cxGridPriceLabelsLevel: TcxGridLevel;
    cxGridPriceLabels: TcxGrid;
    cxGridPriceLabelsTable_GOODSID: TcxGridDBColumn;
    cxGridPriceLabelsTable_IMG: TcxGridDBColumn;
    cxGridPriceLabelsTable_TITLE: TcxGridDBColumn;
    IBCQuery_TMP_GOODS: TIBCQuery;
    IBCDataSource_TMP_GOODS: TIBCDataSource;
    bbShowGroupedReports: TdxBarButton;
    bbPriceLabel_ImportFromStock: TdxBarButton;
    cxGridPriceLabelsTable_PARENT_TITLE: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    bbPriceLabel_Menu_GroupByFolder: TdxBarButton;
    tbsParam_UserGroups: TcxTabSheet;
    Label3: TLabel;
    cxGridPersonelTable: TcxGridDBTableView;
    cxGridPersonelLevel: TcxGridLevel;
    cxGridPersonel: TcxGrid;
    cxGridPersonel_CUSTOMERID: TcxGridDBColumn;
    cxGridPersonel_DISPLAYNAME: TcxGridDBColumn;
    Label4: TLabel;
    cxGridUserGroups: TcxGrid;
    cxGridUserGroupsTable: TcxGridDBTableView;
    cxGridUserGroupsTable_GROUPID: TcxGridDBColumn;
    cxGridUserGroupsTable_GROUP_NAME: TcxGridDBColumn;
    cxGridUserGroupsLevel: TcxGridLevel;
    IBCQuery_TMP_FIRMS: TIBCQuery;
    IBCDataSource_TMP_FIRMS: TIBCDataSource;
    IBCQuery_TMP_USERGROUPS: TIBCQuery;
    IBCDataSource_TMP_USERGROUPS: TIBCDataSource;
    cbParam_UserGroups_HideAdmins: TcxCheckBox;
    cxGridReports_FLG_QUICK_ACCESS: TcxGridDBColumn;
    cxGridReports_DT: TcxGridDBColumn;
    cxGridReports_REPORTGROUP_ORDERNO: TcxGridDBColumn;
    cxGridReports_REPORTGROUP_TITLE: TcxGridDBColumn;
    cxGridReports_IMG: TcxGridDBColumn;
    cxGridPopupMenuReports: TcxGridPopupMenu;
    dxBarPopupMenuReports: TdxBarPopupMenu;
    bbReportCollapseAllGroups: TdxBarButton;
    bbReportExpandAllGroups: TdxBarButton;
    cxGridPriceLabelsTable_DISCOUNT: TcxGridDBColumn;
    bbSetupDiscount: TdxBarButton;
    bbSearchReport: TdxBarButton;
    bbCancelSearch: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure cxGridReportsTableDataControllerDataChanged(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure cxGridReportsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxPageControlChange(Sender: TObject);
    procedure bbEditReportClick(Sender: TObject);
    procedure cxGridReportsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewReportClick(Sender: TObject);
    procedure bbDeleteReportClick(Sender: TObject);
    procedure cxGridReports_TABSHEETINDEXGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCopyReportClick(Sender: TObject);
    procedure bbChangeOrderClick(Sender: TObject);
    procedure bbShowByDocTypeClick(Sender: TObject);
    procedure cxPageControlParamsChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bbPriceLabel_AddClick(Sender: TObject);
    procedure bbPriceLabel_RemoveClick(Sender: TObject);
    procedure cxGridPriceLabelsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridPriceLabelsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbPriceLabel_ImportFromDocClick(Sender: TObject);
    procedure bbShowGroupedReportsClick(Sender: TObject);
    procedure bbPriceLabel_Menu_GroupByFolderClick(Sender: TObject);
    procedure bbPriceLabel_ImportFromStockClick(Sender: TObject);
    procedure cxGridReports_REPORTGROUP_ORDERNOGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure dxBarPopupMenuReportsPopup(Sender: TObject);
    procedure bbReportCollapseAllGroupsClick(Sender: TObject);
    procedure bbReportExpandAllGroupsClick(Sender: TObject);
    procedure bbSetupDiscountClick(Sender: TObject);
    procedure bbSearchReportClick(Sender: TObject);
    procedure bbCancelSearchClick(Sender: TObject);
    procedure cxGridReportsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridReportsTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
  private
    { Private declarations }
    fViewParamsTab: Boolean;
    fParamsViewed: Boolean;
    fDT: integer;
    fDocTypeID: integer;
    fReportParams: TReportParamsList;
    fReportGroup: Integer;
    fShowByDocType: Boolean;
    fShowGroupedReports: Boolean;
    fQuickAccessReportsChanged: Boolean;
    FOnPrintWizardSetupReportParams: TOnPrintWizardSetupReportParams;
    fPreserveUserSettings: Boolean;
    fInSearch: Boolean;
    procedure PrepareData(const CustomerSearch: string = '');
    procedure SelectionChanged;
    procedure PrintReport(const ReportID: integer; const Title: string);
    procedure ShowReportTitles;
    procedure HideReportTitles;
    procedure ShowCreateNewReportDialog;
    procedure ShowEditSelectedReportDialog;
    procedure DeleteSelectedReport;
    procedure SetupInternalParams(const ReportID: integer);
    procedure SelectFirstControlInParams;
    procedure ShowChangeReportOrderDialog;
    procedure ShowCopyReportDialog;

    // report params related procs
    // 1. Etichete de pret
    procedure PriceLabel_ShowAddGoodsDialog;
    procedure PriceLable_WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added: Boolean; var Count: integer);
    function PriceLable_WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    procedure PriceLabel_DeleteCurrentGoods;
    procedure PriceLabel_GridSelectionChanged;
    procedure PriceLabel_ClearTempGoodsTable;
    procedure PriceLabel_ImportGoodsFromDocument;
    procedure PriceLabel_ActionImportGoodsFromDocumentDB(const DocID: integer);
    procedure PriceLabel_ShowSelectStockToImportDialog;
    procedure PriceLabel_ImportGoodsFromStock(const StockID: integer);
    procedure SetOnPrintWizardSetupReportParams(const Value: TOnPrintWizardSetupReportParams);
    procedure ShowSetupPriceLabelsDiscountValueDialog;
    function SetupGoodsDiscountValue(const DiscountValue: integer; const ApplyToAllGoods: Boolean): Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const DT: integer; const DocType: integer); reintroduce;
    destructor Destroy; override;
    procedure ShowReportsFromGroupOnly(const ReportGroup: integer);
    property QuickAccessReportsChanged: Boolean read fQuickAccessReportsChanged;
    property OnPrintWizardSetupReportParams: TOnPrintWizardSetupReportParams read FOnPrintWizardSetupReportParams write SetOnPrintWizardSetupReportParams;
  end;

implementation

uses
  DataModuleDB, SWNUtils, frmReportEditorDialog, DataModuleAdditions,
  frmChangeOrderNoDialog, frmCopyReportDialog, SWNValueStorageUnit, SWNSecurity,
  frmGoods, SWNDBErrors, frmDocumentImportBrowserDialog,
  frmSelectStockDialog, SWNSecurityFlags, frmPriceLabelsDiscountDialog,
  SWNSearchUnit;

{$R *.dfm}

procedure TfrmPrintWizardDlg.bbNewReportClick(Sender: TObject);
begin
  ShowCreateNewReportDialog;
end;

procedure TfrmPrintWizardDlg.bbPriceLabel_AddClick(Sender: TObject);
begin
  PriceLabel_ShowAddGoodsDialog;
end;

procedure TfrmPrintWizardDlg.bbPriceLabel_ImportFromDocClick(Sender: TObject);
begin
  PriceLabel_ImportGoodsFromDocument;
end;

procedure TfrmPrintWizardDlg.bbPriceLabel_ImportFromStockClick(Sender: TObject);
begin
  PriceLabel_ShowSelectStockToImportDialog;
end;

procedure TfrmPrintWizardDlg.bbPriceLabel_Menu_GroupByFolderClick(Sender: TObject);
begin
  if cxGridPriceLabelsTable_PARENT_TITLE.GroupIndex = 0 then
    cxGridPriceLabelsTable_PARENT_TITLE.GroupIndex := -1
  else
    cxGridPriceLabelsTable_PARENT_TITLE.GroupIndex := 0;
end;

procedure TfrmPrintWizardDlg.bbPriceLabel_RemoveClick(Sender: TObject);
begin
  PriceLabel_DeleteCurrentGoods;
end;

procedure TfrmPrintWizardDlg.bbReportCollapseAllGroupsClick(Sender: TObject);
begin
  cxGridReportsTable.DataController.Groups.FullCollapse;
end;

procedure TfrmPrintWizardDlg.bbReportExpandAllGroupsClick(Sender: TObject);
begin
  cxGridReportsTable.DataController.Groups.FullExpand;
end;

procedure TfrmPrintWizardDlg.bbSearchReportClick(Sender: TObject);
var
  dialog: TSWNSearchDialog;
  i: integer;
  SC: TSearchCriteria;
  SearchInWhere: string;
begin
  SearchInWhere := '';
  dialog := TSWNSearchDialog.Create(Self);
  try
    dialog.AdvancedSearchOptions := False;
    if dialog.GetSearchCritera(stReports) then
    begin
      for i := 0 to dialog.SearchCriteriasCount - 1 do
      begin
        SC := dialog.SearchCriterias[i];
        case SC.SearchField of
          sfID:
            AddConditionToWHERE(SearchInWhere, 'REPORTID=' + SC.SearchText);
          sfName:
            AddConditionToWHERE(SearchInWhere, 'TITLE CONTAINING ''' + SC.SearchText + '''');
        end;
      end;
    end;
  finally
    dialog.Free;
  end;

  if SearchInWhere <> '' then
  begin
    bbCancelSearch.Visible := ivAlways;
    fInSearch := True;
    PrepareData(SearchInWhere);
  end;
end;

procedure TfrmPrintWizardDlg.bbSetupDiscountClick(Sender: TObject);
begin
  ShowSetupPriceLabelsDiscountValueDialog;
end;

procedure TfrmPrintWizardDlg.bbShowByDocTypeClick(Sender: TObject);
begin
  fShowByDocType := not fShowByDocType;
  bbShowByDocType.Down := fShowByDocType;
  PrepareData;
end;

procedure TfrmPrintWizardDlg.bbShowGroupedReportsClick(Sender: TObject);
begin
  fShowGroupedReports := not fShowGroupedReports;
  bbShowGroupedReports.Down := fShowGroupedReports;
  PrepareData;
end;

procedure TfrmPrintWizardDlg.btnBackClick(Sender: TObject);
begin
  if fViewParamsTab then
  begin
    cxPageControl.ActivePageIndex := 0;
    fViewParamsTab := False;
    SelectionChanged;
  end;
end;

procedure TfrmPrintWizardDlg.btnNextClick(Sender: TObject);
var
  N: integer;
begin
  N := IBCQueryReports.FieldByName('TabSheetIndex').asInteger;
  if (N > 0) and (N < cxPageControlParams.TabCount) then
  begin
    cxPageControl.ActivePageIndex := 1;
    cxPageControlParams.ActivePageIndex := N;
    fViewParamsTab := True;
    fParamsViewed := True;
    SelectionChanged;
    SelectFirstControlInParams;
  end
  else
    fParamsViewed := False;
end;

procedure TfrmPrintWizardDlg.btnPrintClick(Sender: TObject);
var
  N: integer;
begin
     // check before print
  N := IBCQueryReports.FieldByName('TabSheetIndex').asInteger;
  if (N > 0) and (N < cxPageControl.TabCount) and (not fParamsViewed) then
    btnNextClick(btnNext)
  else
  begin
    if (N = 0) or fParamsViewed then
    begin
               // commit transaction after param who working with transaction: PriceLabel,
      if IBCTrReportUpdate.Active then
        IBCTrReportUpdate.Commit;

      PrintReport(IBCQueryReports.FieldByName('ReportID').asInteger, IBCQueryReports.FieldByName('TITLE').asString);
      cxPageControl.ActivePage := tbsReports;
      fViewParamsTab := False;
      fParamsViewed := False;
      SelectionChanged;
    end
    else
      ShowErrorDialog('Parametri nu sunt setati!', 'Raportul dat necesita parametri suplimentari care nu sunt setati la moment!');
  end;
end;

constructor TfrmPrintWizardDlg.Create(const AOwner: TComponent; const DT: integer; const DocType: integer);
begin
  inherited Create(AOwner);

  fReportParams := TReportParamsList.Create;
  fPreserveUserSettings := False;

  fDT := DT;
  fDocTypeID := DocType;
  fReportGroup := -1;
  fShowByDocType := True;
  fShowGroupedReports := True;
  fQuickAccessReportsChanged := False;
end;

procedure TfrmPrintWizardDlg.cxGridPriceLabelsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if cxGridPriceLabelsTable.DataController.FocusedRecordIndex >= 0 then
    PriceLabel_DeleteCurrentGoods;
end;

procedure TfrmPrintWizardDlg.cxGridPriceLabelsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  PriceLabel_GridSelectionChanged;
end;

procedure TfrmPrintWizardDlg.cxGridReportsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if btnPrint.Enabled then
  begin
    btnPrintClick(btnPrint);
    AHandled := True;
  end;
end;

procedure TfrmPrintWizardDlg.cxGridReports_REPORTGROUP_ORDERNOGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
var
  s: string;
begin
  if VarIsNumeric(cxGridReportsTable.DataController.Values[ARecordIndex, cxGridReports_REPORTGROUP_ORDERNO.Index]) and VarIsStr(cxGridReportsTable.DataController.Values[ARecordIndex, cxGridReports_REPORTGROUP_TITLE.Index]) then
  begin
    s := cxGridReportsTable.DataController.Values[ARecordIndex, cxGridReports_REPORTGROUP_TITLE.Index];
    AText := Format('%s', [s]);
  end;
end;

procedure TfrmPrintWizardDlg.cxGridReports_TABSHEETINDEXGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if ARecord.Values[cxGridReports_TABSHEETINDEX.Index] > 0 then
    AText := 'Parametri'
  else
    AText := '';
end;

procedure TfrmPrintWizardDlg.cxGridReportsTableDataControllerDataChanged(Sender: TObject);
begin
  fParamsViewed := False;
end;

procedure TfrmPrintWizardDlg.cxGridReportsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmPrintWizardDlg.cxGridReportsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridReports_FLG_DISABLED.Index]) then
  begin
    if ARecord.Values[cxGridReports_FLG_DISABLED.Index] = 1 then
      AStyle := dmAdditions.cxStyle_TextGray
    else if ARecord.Values[cxGridReports_FLG_NO_DIRECT_PRINT.Index] = 1 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;

end;

procedure TfrmPrintWizardDlg.cxGridReportsTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord; ALevel: Integer; var AStyle: TcxStyle);
begin
  if ALevel = 0 then
    AStyle := dmAdditions.cxStyle_Bold
  else
    AStyle := dmAdditions.cxStyle_Italic;
end;

procedure TfrmPrintWizardDlg.cxPageControlChange(Sender: TObject);
begin
  if cxPageControl.ActivePageIndex = 0 then
  begin
    if IBCTrReportUpdate.Active then
      IBCTrReportUpdate.Rollback;
    HideReportTitles;
    cxPageControlParams.ActivePageIndex := 0;
  end
  else
    ShowReportTitles;

  SelectionChanged;
end;

procedure TfrmPrintWizardDlg.cxPageControlParamsChange(Sender: TObject);
begin
  if cxPageControlParams.ActivePage = tbsParam_PriceLabel then
  begin
    PriceLabel_ClearTempGoodsTable;
    dmDB.CreateGridImageColumnItems(cxGridPriceLabelsTable_IMG);
    IBCTrReportUpdate.StartTransaction;
    IBCQuery_TMP_GOODS.Active := True;
    PriceLabel_GridSelectionChanged;
  end
  else if cxPageControlParams.ActivePage = tbsParam_UserGroups then
  begin
    cbParam_UserGroups_HideAdmins.Checked := False;
    if SWNSecurityManager.LoggedUser.IsInAdminGroup then
    begin
//      cxGridUserGroups.Height := Round(299 * PixelsPerInch / 96);   //199
      cbParam_UserGroups_HideAdmins.Visible := True;
    end
    else
    begin
//      cxGridUserGroups.Height := Round(228 * PixelsPerInch / 96);
      cbParam_UserGroups_HideAdmins.Visible := False;
    end;

    IBCQuery_TMP_FIRMS.Active := True;
    IBCQuery_TMP_FIRMS.Locate('CUSTOMERID', dmDB.CurrentFirma, []);
    IBCQuery_TMP_USERGROUPS.ParamByName('userID').AsInteger := dmDB.CurrentUserID;
    IBCQuery_TMP_USERGROUPS.Active := True;
    cxGridUserGroupsTable.Controller.SelectAll;
    cxGridPersonel.SetFocus;
  end
end;

procedure TfrmPrintWizardDlg.DeleteSelectedReport;
var
  S: string;
begin
  S := #13#10 + IBCQueryReports.FieldByName('TITLE').AsString + ' ?';
  if ShowAskDialog('Rapoarte', 'Doriti sa fie sters raportul: ' + S) = mrYes then
  begin
    try
      IBCQueryReports.Delete;
      IBCQueryReports.UpdateTransaction.Commit;
    except
      IBCQueryReports.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

destructor TfrmPrintWizardDlg.Destroy;
begin
  fReportParams.Free;
  inherited;
end;

procedure TfrmPrintWizardDlg.dxBarPopupMenuReportsPopup(Sender: TObject);
var
  B: Boolean;
begin
  B := cxGridReportsTable.DataController.Groups.GroupingItemCount > 0;
  bbReportCollapseAllGroups.Enabled := B;
  bbReportExpandAllGroups.Enabled := B;
end;

procedure TfrmPrintWizardDlg.bbCancelSearchClick(Sender: TObject);
begin
  bbCancelSearch.Visible := ivNever;
  fInSearch := False;
  PrepareData;
end;

procedure TfrmPrintWizardDlg.bbChangeOrderClick(Sender: TObject);
begin
  ShowChangeReportOrderDialog;
end;

procedure TfrmPrintWizardDlg.bbCopyReportClick(Sender: TObject);
begin
  ShowCopyReportDialog;
end;

procedure TfrmPrintWizardDlg.bbDeleteReportClick(Sender: TObject);
begin
  DeleteSelectedReport;
end;

procedure TfrmPrintWizardDlg.bbEditReportClick(Sender: TObject);
begin
  ShowEditSelectedReportDialog;
end;

procedure TfrmPrintWizardDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if IBCTrReportUpdate.Active then
    IBCTrReportUpdate.Rollback;
end;

procedure TfrmPrintWizardDlg.FormCreate(Sender: TObject);
begin
  cxPageControl.HideTabs := True;
  cxPageControlParams.HideTabs := True;
  cxPageControl.ActivePageIndex := 0;
  fViewParamsTab := False;
  fParamsViewed := False;
//  ClientHeight := 460 * 1440 div 1080; //514;
  HideReportTitles;
  cxPageControlParams.ActivePageIndex := 0;
//  * screen.Height div cScreenHeight
  ActiveControl := cxGridReports;
end;

procedure TfrmPrintWizardDlg.HideReportTitles;
begin
  lbReportTitle.Visible := False;
  cxLabel1.Visible := False;
  cxLabel2.Visible := False;
end;

procedure TfrmPrintWizardDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if not fPreserveUserSettings then
    begin
      fShowByDocType := AppUserConfigStorage.BooleanValues.GetValue('ShowByDocType', True);
      fShowGroupedReports := AppUserConfigStorage.BooleanValues.GetValue('ShowGroupedReports', True);
    end;

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridReportsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmPrintWizardDlg.Prepare;
begin
  bbCancelSearch.Visible := ivNever;
  fInSearch := False;

  bbShowByDocType.Down := fShowByDocType;
  bbShowGroupedReports.Down := fShowGroupedReports;
  SetupSecurityItems;
  PrepareData;
  cxGridReports_TITLE.Focused := True;

  if fPreserveUserSettings then
  begin
    bbShowByDocType.Enabled := False;
    bbShowGroupedReports.Enabled := False;
  end;

end;

procedure TfrmPrintWizardDlg.PrepareData(const CustomerSearch: string);
var
  S: string;
  groupIndex: integer;
begin
  IBCQueryReports.Close;

  S := 'SELECT VW_TS_REPORTS2.* FROM VW_TS_REPORTS2';
  if not UserHasUserGroup(cUserGroup_Администратор) then
  begin
    S := S + ' INNER JOIN TS_REPORTS2_DT ON TS_REPORTS2_DT.REPORTID=VW_TS_REPORTS2.REPORTID AND TS_REPORTS2_DT.CUSTOMERID=' + IntToStr(dmDB.CurrentFirma);
  end;
  S := S + ' WHERE (BIN_AND(ACC$MASK,:GROUPMASK)>0)';

     // Afiseaza dupa tipul documentului
  if fShowByDocType then
    S := S + ' AND (DOCTYPEID=:DOCTYPEID)';

  if fReportGroup > 0 then
  begin
    S := S + ' AND (REPORTGROUP=:ReportGroup)';
  end;

     // UPDATE: in "PartialAccessMode" sa se vada "Etichete de pret"
  if SWNSecurityManager.IsPartialAccessMode and (fReportGroup <> 1) then
  begin
          // hide ungruped reports
    S := S + ' AND (DOCTYPEID<>-1)';
  end;

  if (CustomerSearch <> '') then
    S := S + ' AND (' + CustomerSearch + ')';

  S := S + ' ORDER BY';
  if fShowGroupedReports then
    S := S + ' REPORTGROUP_TITLE,';
  S := S + ' ORDERNO, TITLE';

  IBCQueryReports.SQL.Text := S;
  IBCQueryReports.ParamByName('GROUPMASK').AsInteger := SWNSecurityManager.UserGroupsAccMask;
  if fShowByDocType then
    IBCQueryReports.ParamByName('DOCTYPEID').AsInteger := fDocTypeID;
  if fReportGroup > 0 then
    IBCQueryReports.ParamByName('ReportGroup').AsInteger := fReportGroup;

  groupIndex := 0;

  cxGridReportsTable.DataController.Groups.ClearGrouping;

     // Afiseaza dupa tipul documentului
  if fShowByDocType then
  begin
          // make group by DOCTYPE
    cxGridReports_DOCTYPEID.GroupBy(groupIndex);
    Inc(groupIndex);
  end;

     // Grupare rapoarte
  if fShowGroupedReports then
  begin
          // make group by REPORTGROUP
    cxGridReports_REPORTGROUP_ORDERNO.GroupBy(groupIndex);
          //Inc(groupIndex);
  end;

  IBCQueryReports.Active := True;
  if (cxGridReportsTable.DataController.Groups.GroupingItemCount > 0) then
    cxGridReportsTable.DataController.Groups.FullExpand;

  if not fShowByDocType and (fDocTypeID <> -1) then
  begin
    IBCQueryReports.Locate('DOCTYPEID', fDocTypeID, [loPartialKey]);
  end;

  SelectionChanged;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ActionImportGoodsFromDocumentDB(const DocID: integer);
var
  Query: TIBCQuery;
  toDelete: Boolean;
begin
  toDelete := False;
  if (cxGridPriceLabelsTable.DataController.RecordCount > 0) and (ShowAskDialogVerification('Rapoarte', 'Doriti sa importati lista de produse din documentul ales ?', 'Produsele curente sa fie sterse?', '', toDelete) <> mrYes) then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrReportUpdate;
        // transaction is already opened!!!
    Query.SQL.Text := 'EXECUTE PROCEDURE PRINT_IMPORTGOODSFROMDOCUMENT(:DOCID,:TODELETE)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('TODELETE').AsInteger := Ord(toDelete);
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ClearTempGoodsTable;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrReportUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'DELETE FROM TMP_GOODS';
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

procedure TfrmPrintWizardDlg.PriceLabel_DeleteCurrentGoods;
begin
  cxGridPriceLabelsTable.DataController.DeleteSelection;
     //IBCQuery_TMP_GOODS.Delete;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ShowAddGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
  added: Boolean;
  count: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.BurstMode := True;
    dialog.OnBurstAddGoods := PriceLable_WhenBurstAddGoods;
    dialog.OnCheckIfGoodsExists := PriceLable_WhenCheckIfGoodsExists;
    dialog.SelectMode := True;
    if dialog.ShowModal = mrOk then
    begin
      PriceLable_WhenBurstAddGoods(dialog.GoodsID, dialog.GoodsTitle, added, count);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ShowSelectStockToImportDialog;
var
  dialog: TfrmSelectStockDlg;
begin
  dialog := TfrmSelectStockDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      PriceLabel_ImportGoodsFromStock(dialog.StockID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrintWizardDlg.PriceLabel_GridSelectionChanged;
var
  canAdd, canDelete, canImportFromDoc, canImportFromStock: Boolean;
begin
  canAdd := True;
  canDelete := False;
  canImportFromDoc := True;
  canImportFromStock := True;
  if cxGridPriceLabelsTable.DataController.FocusedRecordIndex >= 0 then
  begin
    canDelete := True;
  end;
  bbPriceLabel_Add.Enabled := canAdd;
  bbPriceLabel_Remove.Enabled := canDelete;
  bbPriceLabel_ImportFromDoc.Enabled := canImportFromDoc;
  bbPriceLabel_ImportFromStock.Enabled := canImportFromStock;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ImportGoodsFromDocument;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultFirmaID := dmDB.CurrentFirma;

    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_Приход_товара) then
      dialog.DocTypeList.Add(106); // Intrare marfa
    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_Расходная_накладная) then
      dialog.DocTypeList.Add(107); // Nakladnaia de iesire
    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_Приход_товара_по_накладным) then
      dialog.DocTypeList.Add(109); // Intrare marfa pe nakladnie
    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ПЕРЕМЕЩЕНИЕ_Перемещение) then
      dialog.DocTypeList.Add(114); // Transfer
    if dialog.ShowModal = mrOk then
    begin
      PriceLabel_ActionImportGoodsFromDocumentDB(dialog.DocID);
      IBCQuery_TMP_GOODS.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrintWizardDlg.PriceLabel_ImportGoodsFromStock(const StockID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := IBCTrReportUpdate;
    Query.SQL.Text := 'INSERT INTO TMP_GOODS (GOODSID) SELECT GOODSID FROM TS_GOODS_STOCK WHERE DT=:DT AND DTDEP=:StockID AND QTY>0';
    Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
    Query.ParamByName('StockID').AsInteger := StockID;
    Query.ExecSQL;
    IBCQuery_TMP_GOODS.Refresh;
  finally
    Query.Free;
  end;
end;

procedure TfrmPrintWizardDlg.PriceLable_WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added: Boolean; var Count: integer);
begin
  IBCQuery_TMP_GOODS.Append;
  try
    IBCQuery_TMP_GOODS.FieldByName('GOODSID').AsInteger := GoodsID;
    IBCQuery_TMP_GOODS.Post;
    Added := True;
    Count := 1;
  except
    IBCQuery_TMP_GOODS.Cancel;
  end;
end;

function TfrmPrintWizardDlg.PriceLable_WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridPriceLabelsTable.DataController.RecordCount - 1 do
    if cxGridPriceLabelsTable.DataController.Values[i, cxGridPriceLabelsTable_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      break;
    end;
end;

procedure TfrmPrintWizardDlg.PrintReport(const ReportID: integer; const Title: string);
var
  ReportWin: TfrmPrintEngine;
begin
     // 1. Setup internal params
  SetupInternalParams(ReportID);

     // 2. Run report
  ReportWin := TfrmPrintEngine.Create(Self);
  try
    ReportWin.Title := Title;
        // pass params
    ReportWin.ReportParams := fReportParams;
        // execute report
    ReportWin.AddReport(ReportID);
    ReportWin.ShowModal;
  finally
    ReportWin.Free;
  end;

     //ModalResult:=mrOk;
end;

procedure TfrmPrintWizardDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if not fPreserveUserSettings then
    begin
      AppUserConfigStorage.BooleanValues.SetValue('ShowByDocType', fShowByDocType);
      AppUserConfigStorage.BooleanValues.SetValue('ShowGroupedReports', fShowGroupedReports);
    end;

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridReportsTable);

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmPrintWizardDlg.SelectFirstControlInParams;
var
  i: integer;
  WC: TCustomControl;
begin
  for i := 0 to cxPageControlParams.ActivePage.ControlCount - 1 do
  begin
    if cxPageControlParams.ActivePage.Controls[i] is TCustomControl then
    begin
      WC := TCustomControl(cxPageControlParams.ActivePage.Controls[i]);
      if WC.CanFocus and WC.TabStop then
      begin
        WC.SetFocus;
        break;
      end;
    end;
  end;
end;

procedure TfrmPrintWizardDlg.SelectionChanged;
var
  fNew, fEdit, fDelete, fBack, fNext, fPrint: Boolean;
  fTools, fClone, fChangeOrder: Boolean;
  N: integer;
  FLG_DISABLED, FLG_NO_DIRECT_PRINT: Boolean;
begin
  fNew := (cxPageControl.ActivePage = tbsReports) and not fInSearch;     // New report + Security
  fTools := (cxPageControl.ActivePage = tbsReports);

  fEdit := False;
  fDelete := False;
  fBack := False;
  fNext := False;
  fPrint := False;

  fClone := False;
  fChangeOrder := False;

  if cxGridReportsTable.DataController.RecNo > 0 then
  begin
    FLG_DISABLED := IBCQueryReports.FieldByName('FLG_DISABLED').AsInteger = 1;
    FLG_NO_DIRECT_PRINT := IBCQueryReports.FieldByName('FLG_NO_DIRECT_PRINT').AsInteger = 1;

    fEdit := (cxPageControl.ActivePage = tbsReports); // Edit report + Security
    fDelete := (cxPageControl.ActivePage = tbsReports);  // Delete reports + Security
    fBack := fViewParamsTab;
    N := IBCQueryReports.FieldByName('TabSheetIndex').asInteger;
    fNext := (not fViewParamsTab) and (N > 0) and (N < cxPageControlParams.TabCount);
    fPrint := (not FLG_DISABLED) and (not FLG_NO_DIRECT_PRINT); // Printare
    fClone := True; // Clonare raport + Security
    fChangeOrder := (cxGridReportsTable.DataController.RecordCount > 1) and not fInSearch; // Ordonare rapoarte + Security
          // display labels
    lbReportTitle.Caption := IBCQueryReports.FieldByName('TITLE').AsString;
  end;
     // report
  bbNewReport.Enabled := fNew;
  bbEditReport.Enabled := fEdit;
  bbDeleteReport.Enabled := fDelete;
     // buttons
  btnBack.Enabled := fBack;
  btnNext.Enabled := fNext;
  if fNext then
  begin
    btnNext.Default := True;
    btnPrint.Default := False;
  end
  else
    btnPrint.Default := True;

  btnPrint.Enabled := fPrint;
     // tools
  bbTools.Enabled := fTools;
  bbCopyReport.Enabled := fClone;
  bbChangeOrder.Enabled := fChangeOrder;
end;

procedure TfrmPrintWizardDlg.SetOnPrintWizardSetupReportParams(const Value: TOnPrintWizardSetupReportParams);
begin
  FOnPrintWizardSetupReportParams := Value;
end;

function TfrmPrintWizardDlg.SetupGoodsDiscountValue(const DiscountValue: integer; const ApplyToAllGoods: Boolean): Boolean;
var
  Query: TIBCQuery;
  i, N: integer;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrReportUpdate;
    try
      if ApplyToAllGoods then
      begin
                // aplicam la toate produsele
        Query.SQL.Text := 'UPDATE TMP_GOODS SET DISCOUNT=:DISCOUNT';
        Query.ParamByName('DISCOUNT').AsInteger := DiscountValue;
        Query.Execute;
      end
      else
      begin
                // aplicam numai la produsele selectate
        Query.SQL.Text := 'UPDATE TMP_GOODS SET DISCOUNT=:DISCOUNT WHERE GOODSID=:GOODSID';
        Query.ParamByName('DISCOUNT').AsInteger := DiscountValue;
        for i := 0 to cxGridPriceLabelsTable.Controller.SelectedRecordCount - 1 do
        begin
          N := cxGridPriceLabelsTable.Controller.SelectedRecords[i].RecordIndex;
          Query.ParamByName('GOODSID').AsInteger := cxGridPriceLabelsTable.DataController.Values[N, cxGridPriceLabelsTable_GOODSID.Index];
          Query.Execute;
        end;
      end;
      Result := True;
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmPrintWizardDlg.SetupInternalParams(const ReportID: integer);
var
  i: integer;
  S: string;
begin
  if Assigned(FOnPrintWizardSetupReportParams) then
    FOnPrintWizardSetupReportParams(fReportParams);

     // setup report specific params
  case ReportID of     // raport "PERSONAL"
    109:
      begin
                // Firma selectata
        if cxGridPersonelTable.DataController.RecNo > 0 then
          fReportParams.SetParamValue('TARGET_DT', cxGridPersonelTable.DataController.Values[cxGridPersonelTable.DataController.RecNo - 1, cxGridPersonel_CUSTOMERID.Index])
        else
          fReportParams.SetParamValue('TARGET_DT', 0);

                // grupele selectate
        for i := 0 to cxGridUserGroupsTable.Controller.SelectedRowCount - 1 do
        begin
          if S <> '' then
            S := S + ',';
          S := S + IntToStr(cxGridUserGroupsTable.DataController.Values[cxGridUserGroupsTable.Controller.SelectedRows[i].RecordIndex, cxGridUserGroupsTable_GROUPID.Index]);
        end;
        fReportParams.SetParamValue('USER_GROUPS', S);
        fReportParams.SetParamValue('SHOW_ADMIN', Ord(not cbParam_UserGroups_HideAdmins.Checked));
      end;
  end;
end;

procedure TfrmPrintWizardDlg.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Редактировать_шаблоны_отчетов) then
    bbEditReport.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Клонировать_шаблон) then
    bbCopyReport.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Удалить_шаблон) then
    bbDeleteReport.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Создать_шаблон) then
    bbNewReport.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Упорядочить_шаблоны) then
    bbChangeOrder.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_TIPAR_MR_Поиск_шаблона) then
  begin
    bbSearchReport.Visible := ivNever;
    bbCancelSearch.Visible := ivNever;
  end;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    fPreserveUserSettings := True;
    bbShowByDocType.Visible := ivNever;
    bbShowGroupedReports.Visible := ivNever;
  end;
end;

procedure TfrmPrintWizardDlg.ShowChangeReportOrderDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotREPORTS;
    dialog.ParentID := fDocTypeID;
    if dialog.ShowModal = mrOk then
    begin
             // reload data
      IBCQueryReports.Close;
      IBCQueryReports.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrintWizardDlg.ShowCopyReportDialog;
var
  dialog: TfrmCopyReportDlg;
begin
  dialog := TfrmCopyReportDlg.Create(Self);
  try
    dialog.ReportID := IBCQueryReports.FieldByName('REPORTID').AsInteger;
    dialog.ReportTitle := IBCQueryReports.FieldByName('TITLE').AsString;
    if dialog.ShowModal = mrOk then
    begin
             // refresh data
      IBCQueryReports.DisableControls;
      try
        IBCQueryReports.Close;
        IBCQueryReports.Open;
                // locate new report in current context
        IBCQueryReports.Locate('REPORTID', dialog.NewReportID, []);
      finally
        IBCQueryReports.EnableControls;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrintWizardDlg.ShowCreateNewReportDialog;
var
  editor: TfrmReportEditorDlg;
begin
  SetupInternalParams(-1);
  editor := TfrmReportEditorDlg.Create(Self, IBCQueryReports, IBCDataSourceReports);
  try
    editor.CreateNewReport := True;
    editor.DocTypeID := fDocTypeID;
    editor.DT := fDT;
    editor.ReportParamsList := fReportParams;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure TfrmPrintWizardDlg.ShowEditSelectedReportDialog;
var
  editor: TfrmReportEditorDlg;
begin
  SetupInternalParams(IBCQueryReports.FieldByName('REPORTID').AsInteger);

  editor := TfrmReportEditorDlg.Create(Self, IBCQueryReports, IBCDataSourceReports);
  try
    editor.CreateNewReport := False;
    editor.DocTypeID := fDocTypeID;
    editor.DT := fDT;
    editor.ReportParamsList := fReportParams;
    if editor.ShowModal = mrOk then
    begin
      fQuickAccessReportsChanged := fQuickAccessReportsChanged or editor.QuickAccessReportsChanged;
      IBCQueryReports.Refresh;
    end;
  finally
    editor.Free;
  end;
end;

procedure TfrmPrintWizardDlg.ShowReportsFromGroupOnly(const ReportGroup: integer);
begin
  fReportGroup := ReportGroup;
  fShowByDocType := True;
  fShowGroupedReports := False;
  fPreserveUserSettings := ReportGroup <> -1;
end;

procedure TfrmPrintWizardDlg.ShowReportTitles;
begin
  lbReportTitle.Visible := True;
  cxLabel1.Visible := True;
  cxLabel2.Visible := True;
end;

procedure TfrmPrintWizardDlg.ShowSetupPriceLabelsDiscountValueDialog;
var
  dialog: TfrmPriceLabelsDiscountDlg;
begin
  dialog := TfrmPriceLabelsDiscountDlg.Create(Self);
  try
    if dialog.ShowModal = mrOK then
    begin
      if SetupGoodsDiscountValue(dialog.Discount, dialog.ApplyToAll) then
        IBCQuery_TMP_GOODS.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

end.


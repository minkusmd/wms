unit frmCustomersDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  SWNCustomersTypesUnit, Dialogs, cxStyles, cxCustomData, cxGraphics, DB, cxDBData, dxBar, DBAccess, IBC,
  StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls,
  frmPrintEngineWindow, cxButtons, SWNSearchUnit, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox,
  MemDS, cxClasses, cxGridCustomView, cxPropertiesStore, dxUIAClasses;

type
  TfrmCustomersDlg = class(TSWNCustomForm)
    dxBarManager: TdxBarManager;
    bbBack: TdxBarButton;
    bbForward: TdxBarButton;
    dxBarManager1Bar1: TdxBar;
    bbNewCustomer: TdxBarButton;
    bbEditCustomer: TdxBarButton;
    bbDeleteCustomer: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbAdditionalTools: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    bbFirst: TdxBarButton;
    bbNewFolder: TdxBarButton;
    bbAccounts: TdxBarButton;
    bbDiscounts: TdxBarButton;
    bbCredits: TdxBarButton;
    bbWEB: TdxBarButton;
    bbComments: TdxBarButton;
    IBCDataSourceCustomer: TIBCDataSource;
    IBCTrUpdateCustomer: TIBCTransaction;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbChangeParent: TdxBarButton;
    bbChangeFolderOrder: TdxBarButton;
    pnBottom: TPanel;
    bbCustomerCurrentDebts: TdxBarButton;
    bbStamp: TdxBarButton;
    bbGotoCustomer: TdxBarButton;
    bbTools: TdxBarSubItem;
    bbJoinCustomers: TdxBarButton;
    bbPrint: TdxBarButton;
    bbNotifyCustDebts: TdxBarButton;
    bbSetupFirmsFor1C: TdxBarButton;
    bbCustomerContracts: TdxBarButton;
    bbDial: TdxBarButton;
    bbSMSHistory: TdxBarButton;
    dxBarButton2: TdxBarButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    dxBarButton3: TdxBarButton;
    cxPropertiesStore1: TcxPropertiesStore;
    dxBarButton4: TdxBarButton;
    bbConditiiDeLucru: TdxBarButton;
    IBCQueryCustomer: TIBCQuery;
    cxGridCustomers: TcxGrid;
    cxGridCustomersTable: TcxGridDBTableView;
    cxGridCustomers_CUSTOMERID: TcxGridDBColumn;
    cxGridCustomers_IMG: TcxGridDBColumn;
    cxGridCustomers_DISPLAYNAME: TcxGridDBColumn;
    cxGridCustomers_TELEFON1: TcxGridDBColumn;
    cxGridCustomers_FAX: TcxGridDBColumn;
    cxGridCustomers_MOBILE: TcxGridDBColumn;
    cxGridCustomers_ACCOUNTNUMBER: TcxGridDBColumn;
    cxGridCustomers_IDEN_NUMBER: TcxGridDBColumn;
    cxGridCustomers_FLG_FOLDER: TcxGridDBColumn;
    cxGridCustomers_CUSTOMER_STATUS_ID: TcxGridDBColumn;
    cxGridCustomersLevel: TcxGridLevel;
    bbGoodsFromSupplierDlg: TdxBarButton;
    procedure btnOkClick(Sender: TObject);
    procedure cxGridCustomersTableDblClick(Sender: TObject);
    procedure cxGridCustomersDBTableView1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridCustomersTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbBackClick(Sender: TObject);
    procedure bbForwardClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbFirstClick(Sender: TObject);
    procedure bbEditCustomerClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure bbNewCustomerClick(Sender: TObject);
    procedure bbDeleteCustomerClick(Sender: TObject);
    procedure bbDiscountsClick(Sender: TObject);
    procedure bbCommentsClick(Sender: TObject);
    procedure bbCreditsClick(Sender: TObject);
    procedure bbWEBClick(Sender: TObject);
    procedure bbAccountsClick(Sender: TObject);
    procedure bbChangeParentClick(Sender: TObject);
    procedure bbChangeFolderOrderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbCustomerCurrentDebtsClick(Sender: TObject);
    procedure bbStampClick(Sender: TObject);
    procedure bbGotoCustomerClick(Sender: TObject);
    procedure bbJoinCustomersClick(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure bbNotifyCustDebtsClick(Sender: TObject);
    procedure bbSetupFirmsFor1CClick(Sender: TObject);
    procedure cxGridCustomers_DISPLAYNAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbCustomerContractsClick(Sender: TObject);
    procedure bbDialClick(Sender: TObject);
    procedure cxGridCustomersTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbConditiiDeLucruClick(Sender: TObject);
    procedure bbGoodsFromSupplierDlgClick(Sender: TObject);
  private
    { Private declarations }
    fAllowSelectFolder: Boolean;
    fCustomerID: integer;
    fRootParentID: integer;
    fCurrentParentID: integer;
    FSelectMode: Boolean;
    fCustomerTitle: string;
    fInSearch: Boolean;
    fItemsChanged: Boolean;
    // security flags
    cSecurityFlag_CanModify_Folder, cSecurityFlag_CanModify_Customer, cSecurityFlag_CanDelete_Folder,
      cSecurityFlag_CanDelete_Customer: Boolean;
    cSecurityFlag_IsAdmin: Boolean;
    FCustomerFolderID: Integer;
    fCustomFilter: TCustomerFiltersSet;
    fCustomFilterSQL: string;
    fExcludeFilterSQL: string;
    fCustomerSearchMask: string;
    fCustomerVAT: integer;
    fCustomerIsFolder: Boolean;
    fCustomerTypeID: integer;
    fExcludeFilter: TCustomerFiltersSet;
    FSearchText: string;
    procedure SelectedRecordChanged;
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToCustomer(const CustomerID: integer);
    procedure NavigateSearch(const WhereConditions: string; SearchField: TSearchField = sfID);
    procedure NavigateToHome(const RootID: integer);
    procedure EnableCondition(const ConditionIndex: integer);
    function ItemSelected: Boolean;
    procedure SetAllowSelectFolder(const Value: Boolean);
    procedure SetTitle(const Value: string);
    procedure ShowSearchDialog;
    procedure SetCustomerID(const Value: integer);
    procedure SetRootParentID(const Value: integer);
    procedure SetSelectMode(const Value: Boolean);
    procedure ModifySelectedCustomer;
    procedure ShowCreateNewFolderDialog;
    procedure CreateNewCustomer;
    procedure DeleteSelectedCustomer;
    procedure ShowCustomerCardsDialog;
    procedure ShowCustomerCreditsDialog;
    procedure ShowCustomerCommentsDialog;
    procedure ShowCustomerWebAccessDialog;
    procedure ShowCustomerAccountsDialog;
    procedure ShowChangeParentDialog;
    procedure ShowChangeFolderOrderDialog;
    procedure ShowCustomerCurrentDebts;
    procedure SetCustomFilter(const Value: TCustomerFiltersSet);
    procedure SetExcludeFilter(const Value: TCustomerFiltersSet);
    procedure ShowCustomerStampDialog;
    procedure CopyCellTextToClipboard;
    function GetCustomFilterSQL: string;
    procedure SetSearchText(const Value: string);
    procedure ShowJoinCustomersDialog;
    procedure ShowPrintDialog;
    procedure SetupReportParams(const ReportParams: TReportParamsList);
    procedure ShowCustomerDebtsNotifyDialog;
    procedure ShowCustomerContractsDialogs;
    procedure ShowSetupFirmaFor1CDialog;
    function SearchCustomer(const ASearchText: string; const AAllowSelectFolder: Boolean; const
  ARootID: integer; const ATitle: string): Boolean;
    procedure SetCustomerFolderID(const Value: Integer);
  protected
    { Protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CustomerID: integer read fCustomerID write SetCustomerID;
    property CustomerTitle: string read fCustomerTitle;
    property VAT: integer read fCustomerVAT;
    property RootID: integer read fRootParentID write SetRootParentID;
    property CustomerIsFolder: Boolean read fCustomerIsFolder;
    property CustomerTypeID: integer read fCustomerTypeID;
    property Title: string write SetTitle;
    property AllowSelectFolder: Boolean write SetAllowSelectFolder;
    property CustomerFolderID: Integer read FCustomerFolderID write SetCustomerFolderID;
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property ItemsChanged: Boolean read fItemsChanged;
    property CustomFilter: TCustomerFiltersSet read fCustomFilter write SetCustomFilter;
    property ExcludeFilter: TCustomerFiltersSet read fExcludeFilter write SetExcludeFilter;
    property SearchText: string read FSearchText write SetSearchText;
    function SelectCustomer(const ACustomerID: integer; const AAllowSelectFolder: Boolean = False; const
      ARootID: integer = 0; const ATitle: string = ''): Boolean;
    function SelectCustomerBySearch(const CustomerMask: string; const ATitle: string = ''): Boolean;
    procedure BrowseCustomers(const ACustomerID: integer; const ARootID: integer = 0; const ATitle: string = '');
    procedure ShowCustomersCatalog(const CustomerID: Integer);
  end;

implementation

uses
  frmCustomerEditorDlg, frmFolderEditorDlg, frmCustomerCardDlg, frmCustomerCreditDlg, ClipBrd,
  frmCustomerWebDlg, frmCustomerAccountsDlg, DataModuleAdditions, SWNUtils, frmChangeParentFolderDialog,
  frmChangeOrderNoDialog, frmCustomerCurrentDebtsDialog, frmCustomerStampDialog, SWNValueStorageUnit,
  SWNSecurityFlags, SWNDBErrors, DataModuleDB, SWNSecurity, frmCustomerJoinDialog, frmPrintWizardDialog,
  frmCustomerNotifyDebtsDialog, frmCustomerCommentsV2Dialog, frmCustomerContractsDialog,
  frmLinkFirmsTo1CDialog, frmSelectPhoneNumberUnit, frmCustomerAddrUnit, frmQuickCustomerInfoDialog, frmCustomerCategoryPricesDialog, frmCustomerWorkRulesUnit,
  frmGoodsFromSupplierUnit;

{$R *.dfm}
{ TfrmSelectCustomerDlg }

procedure TfrmCustomersDlg.bbAccountsClick(Sender: TObject);
begin
  ShowCustomerAccountsDialog;
end;

procedure TfrmCustomersDlg.bbBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmCustomersDlg.bbChangeFolderOrderClick(Sender: TObject);
begin
  ShowChangeFolderOrderDialog;
end;

procedure TfrmCustomersDlg.bbChangeParentClick(Sender: TObject);
begin
  ShowChangeParentDialog;
end;

procedure TfrmCustomersDlg.bbCommentsClick(Sender: TObject);
begin
  ShowCustomerCommentsDialog;
end;

procedure TfrmCustomersDlg.bbConditiiDeLucruClick(Sender: TObject);
var
  dialog: TfrmCustomerWorkRules;
begin
  dialog := TfrmCustomerWorkRules.Create(self, ibcqueryCustomer, ibcDataSourceCustomer);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.bbCustomerContractsClick(Sender: TObject);
begin
  ShowCustomerContractsDialogs;
end;

procedure TfrmCustomersDlg.bbCreditsClick(Sender: TObject);
begin
  ShowCustomerCreditsDialog;
end;

procedure TfrmCustomersDlg.bbCustomerCurrentDebtsClick(Sender: TObject);
begin
  ShowCustomerCurrentDebts;
end;

procedure TfrmCustomersDlg.bbDeleteCustomerClick(Sender: TObject);
begin
  DeleteSelectedCustomer;
end;

procedure TfrmCustomersDlg.bbDialClick(Sender: TObject);
begin
  frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
  try
    frmSelectPhoneNumber.CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    if frmSelectPhoneNumber.ShowModal = mrOk then
    begin
//      frmMainForm.frameSipClient1.PhoneEdit.Text := frmSelectPhoneNumber.SelectedPhoneNumber;
//      frmMainForm.frameSipClient1.pcDialPad.ActivePageIndex := 0;
//      frmMainForm.frameSipClient1.CallActionExecute(Sender);
    end;
  finally
    frmSelectPhoneNumber.Free;
  end;
end;

procedure TfrmCustomersDlg.bbDiscountsClick(Sender: TObject);
begin
  ShowCustomerCardsDialog;
end;

procedure TfrmCustomersDlg.bbEditCustomerClick(Sender: TObject);
begin
  ModifySelectedCustomer;
end;

procedure TfrmCustomersDlg.bbFirstClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
end;

procedure TfrmCustomersDlg.bbForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmCustomersDlg.bbGoodsFromSupplierDlgClick(Sender: TObject);
var
  d: TfrmGoodsFromSupplierDlg;
begin
  d:=TfrmGoodsFromSupplierDlg.Create(self);
  try
    d.SupplierID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmCustomersDlg.bbGotoCustomerClick(Sender: TObject);
begin
  if Assigned(cxGridCustomersTable.Controller.FocusedRecord) then
  begin
    NavigateToCustomer(cxGridCustomersTable.Controller.FocusedRecord.Values[cxGridCustomers_CUSTOMERID.Index]);
  end;
end;

procedure TfrmCustomersDlg.bbJoinCustomersClick(Sender: TObject);
begin
  ShowJoinCustomersDialog;
end;

procedure TfrmCustomersDlg.bbNewCustomerClick(Sender: TObject);
begin
  CreateNewCustomer;
end;

procedure TfrmCustomersDlg.bbNewFolderClick(Sender: TObject);
begin
  ShowCreateNewFolderDialog;
end;

procedure TfrmCustomersDlg.bbPrintClick(Sender: TObject);
begin
  ShowPrintDialog;
end;

procedure TfrmCustomersDlg.bbSetupFirmsFor1CClick(Sender: TObject);
begin
  ShowSetupFirmaFor1CDialog;
end;

procedure TfrmCustomersDlg.bbStampClick(Sender: TObject);
begin
  ShowCustomerStampDialog;
end;

procedure TfrmCustomersDlg.bbWEBClick(Sender: TObject);
begin
  ShowCustomerWebAccessDialog;
end;

procedure TfrmCustomersDlg.BrowseCustomers(const ACustomerID, ARootID: integer; const ATitle: string);
begin
//  cxGridCustomersTable.DataController.DataSource := nil;
  SelectMode := False;
  CustomerID := ACustomerID;
  RootID := ARootID;
  if ATitle <> '' then
    Title := ATitle;
  ShowModal;
end;

procedure TfrmCustomersDlg.btnOkClick(Sender: TObject);
begin
  if ItemSelected then
    ModalResult := mrOk
end;

procedure TfrmCustomersDlg.CopyCellTextToClipboard;
var
  RecordIndex: integer;
begin
  if cxGridCustomersTable.DataController.FocusedRowIndex >= 0 then
  begin
    RecordIndex := cxGridCustomersTable.DataController.GetRowInfo(cxGridCustomersTable.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := cxGridCustomersTable.DataController.GetDisplayText(RecordIndex, cxGridCustomersTable.Controller.FocusedColumn.Index);
  end;
end;

procedure TfrmCustomersDlg.CreateNewCustomer;
var
  dialog: TfrmCustomerEditorDialog;
begin
  dialog := TfrmCustomerEditorDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    dialog.CreateNewRecord := True;
    dialog.LocalUpdateTransaction := IBCQueryCustomer.UpdateTransaction;
    if fInSearch then
      dialog.ParentID := 7 // PERSOANE FIZICE
    else
      dialog.ParentID := fCurrentParentID;

    if dialog.ShowModal = mrOk then
    begin
      fItemsChanged := True;
      IBCQueryCustomer.RefreshRecord;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCreateNewFolderDialog;
var
  dialog_fold: TfrmCustomerFolderEditorDialog;
begin
  dialog_fold := TfrmCustomerFolderEditorDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    dialog_fold.ParentID := fCurrentParentID;
    dialog_fold.ParentCustomerTypeID := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger;
    dialog_fold.CreateNewRecord := True;
    if dialog_fold.ShowModal = mrOk then
    begin
      if fAllowSelectFolder then
        fItemsChanged := True;
    end;
  finally
    dialog_fold.Free;
  end;
end;

procedure TfrmCustomersDlg.cxGridCustomersTableDblClick(Sender: TObject);
begin
  if IBCQueryCustomer.RecordCount = 0 then
    Exit;

  if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
    NavigateForward
  else if ItemSelected then
    ModalResult := mrOk;
end;

procedure TfrmCustomersDlg.cxGridCustomersTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectedRecordChanged;
end;

procedure TfrmCustomersDlg.cxGridCustomers_DISPLAYNAMEStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridCustomers_FLG_FOLDER.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmCustomersDlg.cxGridCustomersDBTableView1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // ENTER
  if (Key = 13) and (Shift = []) then
  begin
    if IBCQueryCustomer.RecordCount = 0 then
      Exit;
    if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
      NavigateForward
    else if ItemSelected then
      ModalResult := mrOk;
  end
  else    // BackSpace
if (Key = 8) and (Shift = []) then
  begin
    NavigateBack;
  end
  else      // Ctrl + BackSpace
if (Key = 8) and (Shift = [ssCtrl]) then
  begin
    if fCurrentParentID <> fRootParentID then
      NavigateToHome(fRootParentID);
  end
  else        // Ctrl + Enter
if (Key = 13) and (Shift = [ssCtrl]) then
  begin
    if IBCQueryCustomer.RecordCount = 0 then
      Exit;
    if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
      if ItemSelected then
        ModalResult := mrOk;
  end
  else          // Ctrl+C
if (Key = 67) and (Shift = [ssCtrl]) then
  begin
            // copy cell content in clipboard
    CopyCellTextToClipboard;
    Key := 0;
    Shift := [];
  end  // else
  // // Search: F3
  // if (Key = 114) and (Shift = []) then
  // begin
  // ShowSearchDialog;
  // Key := 0;
  // Shift := [];
  // end
end;

procedure TfrmCustomersDlg.DeleteSelectedCustomer;
var
  S0, S: string;
begin
  if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Удаление_папки) then
      Exit;
    S0 := 'Sterge mapa';
    S := 'mapa';
  end
  else
  begin
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Удаление_клиента) then
      Exit;
    S0 := 'Sterge client';
    S := 'Client';
  end;

  S := 'Sterge ' + S + ' "' + IBCQueryCustomer.FieldByName('DISPLAYNAME').AsString + '"?';
  if ShowAskDialog(S0, S) = mrYes then
  begin
    IBCQueryCustomer.UpdateTransaction.StartTransaction;
    try
      IBCQueryCustomer.Delete;
      IBCQueryCustomer.UpdateTransaction.Commit;
      fItemsChanged := True;
    except
      on E: Exception do
      begin
        IBCQueryCustomer.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmCustomersDlg.dxBarButton1Click(Sender: TObject);
begin
  ShowSearchDialog;
end;

procedure TfrmCustomersDlg.dxBarButton2Click(Sender: TObject);
var
  dialog: TfrmCustomerAddrDlg;
begin
  dialog := TfrmCustomerAddrDlg.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomersCatalog(const CustomerID: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomerID := CustomerID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.dxBarButton3Click(Sender: TObject);
var
  dialog: TfrmQuickCustomerInfoDlg;
begin
  dialog := TfrmQuickCustomerInfoDlg.Create(Self);
  try
    dialog.CT := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    if dialog.ShowModal = mrOk then
      ShowCustomersCatalog(IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger);
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.dxBarButton4Click(Sender: TObject);
var
    d: TfrmCustomerCategoryPricesDlg;
begin
    d:= TfrmCustomerCategoryPricesDlg.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
    try
        d.CustomerID := IBCQueryCustomer.FieldByName('CustomerID').AsInteger;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmCustomersDlg.bbNotifyCustDebtsClick(Sender: TObject);
begin
  ShowCustomerDebtsNotifyDialog;
end;

procedure TfrmCustomersDlg.cxGridCustomersTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not AViewInfo.Selected then
    if (AViewInfo.GridRecord.Values[cxGridCustomers_CUSTOMER_STATUS_ID.Index] = 4105) then
      ACanvas.Brush.Color := clWebLightYellow;
end;

procedure TfrmCustomersDlg.EnableCondition(const ConditionIndex: integer);
begin
  fInSearch := False;
  IBCQueryCustomer.Close;
  case ConditionIndex of
    0:
      IBCQueryCustomer.SQL.Text := 'SELECT A.* FROM SELECT_CUSTOMERS(:ParentID) A';
    1:
      IBCQueryCustomer.SQL.Text := 'SELECT A.* FROM SELECT_CUSTOMERS(:ParentID,:SelectType) A order by FLG_FOLDER DESC, name';
    2:
      IBCQueryCustomer.SQL.Text := 'SELECT A.* FROM SELECT_CUSTOMERS(:ParentID,:SelectType,:WhereCondition) A order by FLG_FOLDER DESC, name';
  end;
end;

procedure TfrmCustomersDlg.FormCreate(Sender: TObject);
begin
  fAllowSelectFolder := False;

  fCustomerID := -1;
  fCustomerTitle := '';
  fCurrentParentID := -1;
  fRootParentID := 0;
  fCustomerVAT := 20;
  RootID := 0;
  FSelectMode := True;
  fInSearch := False;
  fItemsChanged := False;
  fCustomFilter := cCustomerAllFilters; // secured flags are disabled by default
  fExcludeFilter := [];
  fCustomFilterSQL := '';
  fCustomerSearchMask := '';
  fCustomerIsFolder := False;
  fCustomerTypeID := -1;
end;

function TfrmCustomersDlg.GetCustomFilterSQL: string;
begin
  Result := '';
  if fCustomFilterSQL <> '' then
    AddConditionToWHERE(Result, fCustomFilterSQL);
  if fExcludeFilterSQL <> '' then
    AddConditionToWHERE(Result, fExcludeFilterSQL);
end;

procedure TfrmCustomersDlg.NavigateSearch(const WhereConditions: string; SearchField: TSearchField);
var
  FilterSQL: string;
begin
  EnableCondition(2); // Search

  if SearchField = sfPhone then
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 5
  else
  if SearchField = sfIDNO then
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 6
  else
  if SearchField=sfAdvancedCustomerSearch then
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 8
  else
  if SearchField=sfEMail then
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 9
  else
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 3;


  IBCQueryCustomer.ParamByName('WhereCondition').AsString := WhereConditions;
  IBCQueryCustomer.ParamByName('ParentID').AsInteger := -1;
  FilterSQL := GetCustomFilterSQL;
  IBCQueryCustomer.FilterSQL := GetCustomFilterSQL;
  ibcquerycustomer.Prepare;
  IBCQueryCustomer.Open;

//  if FilterSQL <> '' then
//  begin
//    FilterSQL := FilterSQL + ' AND ';
//  end;
//  FilterSQL := FilterSQL + ' NOT EXISTS(SELECT CUSTOMERID FROM Get_not_avail_Firms_By_User GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';
//  IBCQueryCustomer.FilterSQL := FilterSQL;
  fCurrentParentID := -1;
  fInSearch := True;
  if (cxGridCustomersTable.DataController.RecNo = 0) then
    SelectedRecordChanged;
end;

procedure TfrmCustomersDlg.NavigateBack;
var
  ParentID: integer;
begin
  if not IBCQueryCustomer.Active then
    Exit;

  if IBCQueryCustomer.Eof then
  begin
    if fCurrentParentID = -1 then
      ParentID := fRootParentID
    else
      ParentID := fCurrentParentID;
  end
  else
  begin
    ParentID := IBCQueryCustomer.FieldByName('PARENTID').AsInteger;
  end;

  if fInSearch then
  begin
    NavigateToHome(ParentID);
  end
  else if (ParentID <> fRootParentID) then
  begin
    EnableCondition(1); // Browse Backward
    IBCQueryCustomer.ParamByName('ParentID').AsInteger := ParentID;
//    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 4;
    IBCQueryCustomer.ParamByName('SelectType').AsInteger := 2;
    if ParentID = 5209 then // Firme
      IBCQueryCustomer.FilterSQL :=
        ' EXISTS(SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';

    IBCQueryCustomer.FilterSQL := GetCustomFilterSQL;
    IBCQueryCustomer.Open;
    fCurrentParentID := IBCQueryCustomer.FieldByName('PARENTID').AsInteger;
    IBCQueryCustomer.Locate('CUSTOMERID', ParentID, []);
  end;
end;

procedure TfrmCustomersDlg.NavigateToHome(const RootID: integer);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryCustomer.ParamByName('ParentID').AsInteger := RootID;
  IBCQueryCustomer.FilterSQL := GetCustomFilterSQL;
  if RootID = 5209 then // Firme
    IBCQueryCustomer.FilterSQL :=
      ' EXISTS (SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';
  fCurrentParentID := RootID;
  IBCQueryCustomer.Open;
end;

procedure TfrmCustomersDlg.Prepare;
begin
  SetupSecurityItems;

  if fCustomerID > 0 then
    NavigateToCustomer(fCustomerID)
  else if fCustomerSearchMask <> '' then
    NavigateSearch(fCustomerSearchMask)
  else
  begin
    if fRootParentID > 0 then
      NavigateToHome(fRootParentID)
    else
      NavigateForward;
  end;
  SelectedRecordChanged;

  cxGridCustomers_DISPLAYNAME.Selected := True;
  cxGridCustomers_DISPLAYNAME.Focused := True;
end;

procedure TfrmCustomersDlg.NavigateForward;
var
  CustomerID: integer;
begin
  if (not IBCQueryCustomer.Active) or (IBCQueryCustomer.RecordCount = 0) then
    CustomerID := 0
  else
    CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;

  EnableCondition(0); // Browse Forward
  IBCQueryCustomer.ParamByName('ParentID').AsInteger := CustomerID;
  IBCQueryCustomer.FilterSQL := GetCustomFilterSQL;
  fCurrentParentID := CustomerID;
  // daca e parent firme atunci sa se filtreze firmele dupa nivelul de access. 15.06.2016 SErgiu
  if CustomerID = 5209 then
  begin
    if IBCQueryCustomer.FilterSQL <> '' then
      IBCQueryCustomer.FilterSQL := IBCQueryCustomer.FilterSQL + ' AND ';

    IBCQueryCustomer.FilterSQL := IBCQueryCustomer.FilterSQL +
      ' EXISTS(SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';
  end;

  IBCQueryCustomer.Open;
  // fix
  if IBCQueryCustomer.Eof then
    SelectedRecordChanged;
end;

procedure TfrmCustomersDlg.NavigateToCustomer(const CustomerID: integer);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryCustomer.ParamByName('ParentID').AsInteger := CustomerID;
  IBCQueryCustomer.ParamByName('SelectType').AsInteger := 4;
//  IBCQueryCustomer.ParamByName('SelectType').AsInteger := 2;
  IBCQueryCustomer.FilterSQL := GetCustomFilterSQL;
  IBCQueryCustomer.Open;

  IBCQueryCustomer.Locate('CUSTOMERID', CustomerID, []);
  fCurrentParentID := IBCQueryCustomer.FieldByName('ParentID').AsInteger;
end;

procedure TfrmCustomersDlg.ShowChangeFolderOrderDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotCUSTOMERS;
    dialog.ParentID := fCurrentParentID;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryCustomer.Close;
      IBCQueryCustomer.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowChangeParentDialog;
var
  dialog: TfrmChangeParentFolderDlg;
begin
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtCUSTOMERS;
    dialog.FolderObjectID := IBCQueryCustomer.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger, IBCQueryCustomer.FieldByName('DISPLAYNAME').AsString);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryCustomer.Close;
      IBCQueryCustomer.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerAccountsDialog;
var
  browser: TfrmCustomerAccountDialog;
begin
  browser := TfrmCustomerAccountDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    browser.ShowModal;
  finally
    browser.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerCardsDialog;
var
  browser: TfrmCustomerCardDialog;
begin
  browser := TfrmCustomerCardDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    browser.ShowModal;
  finally
    browser.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerCommentsDialog;
var
  dialog: TfrmCustomerCommentsV2Dlg;
begin
  dialog := TfrmCustomerCommentsV2Dlg.Create(Self);
  try
    dialog.CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerContractsDialogs;
var
  dialog: TfrmContractsDlg;
begin
  dialog := TfrmContractsDlg.Create(Self);
  try
    dialog.CT := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerCreditsDialog;
var
  browser: TfrmCustomerCreditDialog;
begin
  browser := TfrmCustomerCreditDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    browser.ShowModal;
  finally
    browser.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerCurrentDebts;
var
  dialog: TfrmCustomerCurrentDebtsDlg;
begin
  dialog := TfrmCustomerCurrentDebtsDlg.Create(Self);
  try
    dialog.CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerDebtsNotifyDialog;
var
  dialog: TfrmCustomerNotifyDebtsDlg;
begin
  dialog := TfrmCustomerNotifyDebtsDlg.Create(Self);
  try
    dialog.CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerStampDialog;
var
  dialog: TfCustomerStampDlg;
begin
  dialog := TfCustomerStampDlg.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowCustomerWebAccessDialog;
var
  dialog: TfrmCustomerWebDialog;
begin
  dialog := TfrmCustomerWebDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
  try
    dialog.EditWebAccess;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowJoinCustomersDialog;
var
  dialog: TfrmCustomerJoinDlg;
begin
  dialog := TfrmCustomerJoinDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if dialog.ShowTargetCustomer then
        NavigateToCustomer(dialog.TargetCustomerID)
      else
        IBCQueryCustomer.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowPrintDialog;
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(9); // 9 - Контрагенты
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;

procedure TfrmCustomersDlg.ShowSearchDialog;
var
  Search: TSWNSearchDialog;
  S: string;
  i: integer;
  SC: TSearchCriteria;
  toSearch: Boolean;
begin
  toSearch := False;
  S := '';
  SC := nil;
  Search := TSWNSearchDialog.Create(Self);
  try
    if fRootParentID <> 0 then
      AddConditionToWHERE(S, 'PARENTID=' + IntToStr(fRootParentID));
    // allow to search only in current folder

    if Search.GetSearchCritera(stCustomer) then
    begin
      for i := 0 to Search.SearchCriteriasCount - 1 do
      begin
        SC := Search.SearchCriterias[i];
        case SC.SearchField of
          sfID:
            AddConditionToWHERE(S, 'CUSTOMERID=' + SC.SearchText);
          sfName:
            AddConditionToWHERE(S, 'NAME LIKE ' + PrepareTextForLIKE(SC.SearchText));
          sfEMail:
            S := lowercase(SC.SearchText);
          sfPhone:
            S := SC.SearchText;
          sfIDNO:
            s := sc.SearchText;
          sfDiscount:
            AddConditionToWHERE(S,
              ' EXISTS(SELECT * FROM TS_CUST_DISCOUNT WHERE CUSTOMERID=VW_TS_CUSTOMER.CUSTOMERID AND SN=' +
              QuotedStr(SC.SearchText) + ')');
          sfAdvancedCustomerSearch:
                S := SC.SearchText;
        end;
      end;
      toSearch := S <> '';
    end;
  finally
    Search.Free;
  end;

  if (Assigned(SC) and toSearch) then
    NavigateSearch(S, SC.SearchField);
end;

procedure TfrmCustomersDlg.ShowSetupFirmaFor1CDialog;
var
  dialog: TfrmLinkFirmsTo1CDlg;
begin
  dialog := TfrmLinkFirmsTo1CDlg.Create(Self);
  try
    dialog.FirmaFolderID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomersDlg.SaveStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  cxPropertiesStore1.StorageName := Extractfilepath (Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
//  cxPropertiesStore1.StorageName := 'settings-u'+dmDB.CurrentUserID.ToSTring+'.ini';

  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then begin
     cxPropertiesStore1.StoreTo;
  end;
//    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
//  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
//    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridCustomersTable);
end;

function TfrmCustomersDlg.SelectCustomer(const ACustomerID: integer; const AAllowSelectFolder: Boolean; const
  ARootID: integer; const ATitle: string): Boolean;
begin
  CustomerID := ACustomerID;
  AllowSelectFolder := AAllowSelectFolder;
  RootID := ARootID;
  if ATitle <> '' then
    Title := ATitle;
  Result := (ShowModal = mrOk);
end;

function TfrmCustomersDlg.SearchCustomer(const ASearchText: string; const AAllowSelectFolder: Boolean; const
  ARootID: integer; const ATitle: string): Boolean;
begin
  SearchText := ASearchText;
  AllowSelectFolder := AAllowSelectFolder;
  RootID := ARootID;
  if ATitle <> '' then
    Title := ATitle;
  Result := ShowModal = mrOk;
end;


function TfrmCustomersDlg.SelectCustomerBySearch(const CustomerMask, ATitle: string): Boolean;
begin
  AddConditionToWHERE(fCustomerSearchMask, 'NAME LIKE ' + PrepareTextForLIKE(WideUpperCase(CustomerMask)));
  AllowSelectFolder := False;
  if ATitle <> '' then
    Title := ATitle;
  Result := ShowModal = mrOk;
end;

procedure TfrmCustomersDlg.SelectedRecordChanged;
var
  fNewFolder, fNewCustomer, fModify, fDelete: Boolean;
  fForward, fBack, fFirst: Boolean;
  fAddtional: Boolean;
  fChangeParent: Boolean;
  fChangeFolderOrder: Boolean;
  FLG_FOLDER: Boolean;
  fStamp, fAngajat: Boolean;
  fGotoCustomer: Boolean;
  fContracts: Boolean;
  fSetupFirmsFor1C: Boolean;
begin
  fForward := False;
  fNewCustomer := (not fInSearch) and (fCurrentParentID > 1);
  // Новый контрагент
  fNewFolder := not fInSearch; // Новая папка
  // NEURON Special - vedem daca utilizatorul poate face inregistrari noi in mapele speciale
  if fNewCustomer and not cSecurityFlag_IsAdmin then
  begin
    fNewCustomer := (fCurrentParentID <> 5215) and // Склады
      (fCurrentParentID <> 5209) and // Фирмы
      (fCurrentParentID <> 8) and // COLABORATORI
      (fCurrentParentID <> 3); // CLIENTI
  end;

  fModify := False;
  fDelete := False;

  fAddtional := False;
  fStamp := False;
  fChangeParent := False;
  fChangeFolderOrder := False;

  fGotoCustomer := False;
  fContracts := False;
  fSetupFirmsFor1C := False;

  // cSecurityFlag_IsAdmin

  if (cxGridCustomersTable.DataController.RecNo > 0) then
  begin
    FLG_FOLDER := IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1;
    fAngajat := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4006; // only for "angajat"

    if FLG_FOLDER then
    begin
      fForward := True;
      if fAngajat then
      begin
        fModify := cSecurityFlag_CanModify_Folder and cSecurityFlag_IsAdmin;
        // Изменить + Security
        fDelete := cSecurityFlag_CanDelete_Folder and cSecurityFlag_IsAdmin;
        // Удалить + Security
        fChangeParent := cSecurityFlag_IsAdmin;
        fChangeFolderOrder := cSecurityFlag_IsAdmin;
      end
      else
      begin
        fModify := cSecurityFlag_CanModify_Folder; // Изменить + Security
        fDelete := cSecurityFlag_CanDelete_Folder; // Удалить + Security
        fChangeParent := True;
        fChangeFolderOrder := True;
        fSetupFirmsFor1C := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4009;
        // Тип контрагента = "Структура фирмы"
      end;
    end
    else
    begin
      fModify := cSecurityFlag_CanModify_Customer; // Изменить + Security
      fDelete := cSecurityFlag_CanDelete_Customer; // Удалить + Security
      fChangeParent := True;
      fChangeFolderOrder := True;

      if fAngajat then
      begin
        fAddtional := cSecurityFlag_IsAdmin;
      end
      else
      begin
        fAddtional := True;
      end;
      fStamp := True; // IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4002; // only for "Фирмы"

      fGotoCustomer := fInSearch;
      fContracts := True;
    end;

    // back
    fBack := (IBCQueryCustomer.FieldByName('PARENTID').AsInteger > 0) and (fRootParentID <> IBCQueryCustomer.FieldByName
      ('PARENTID').AsInteger);
    // home
    fFirst := fBack or (fRootParentID = 0);
  end
  else
  begin
    fBack := (fCurrentParentID > -1) and (fRootParentID <> fCurrentParentID) or fInSearch;
    fFirst := fBack or (fRootParentID = 0) or fInSearch;
  end;

  bbFirst.Enabled := fFirst;
  bbForward.Enabled := fForward;
  bbBack.Enabled := fBack;
  if fGotoCustomer then
    bbGotoCustomer.Visible := ivAlways
  else
    bbGotoCustomer.Visible := ivNever;

  bbNewFolder.Enabled := fNewFolder;
  bbNewCustomer.Enabled := fNewCustomer;

  bbEditCustomer.Enabled := fModify;
  bbDeleteCustomer.Enabled := fDelete;

  bbAccounts.Enabled := fAddtional; // Банковские реквизиты
  bbDiscounts.Enabled := fAddtional; // Карточки

  bbCredits.Enabled := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Кредиты_просмотр); // Кредиты

  bbWEB.Enabled := fAddtional; // Интернет доступ
  bbComments.Enabled := fAddtional; // Коментарии
  bbStamp.Enabled := fStamp; // Печать
  bbCustomerCurrentDebts.Enabled := fAddtional; // Текущие долги контрагента
  bbCustomerContracts.Enabled := fContracts; // Контракты

  bbChangeParent.Enabled := fChangeParent; // Изменение предка
  bbChangeFolderOrder.Enabled := fChangeFolderOrder; // Упорядочить папки

  bbSetupFirmsFor1C.Enabled := fSetupFirmsFor1C; // Настройка фирм для 1С

end;

procedure TfrmCustomersDlg.SetAllowSelectFolder(const Value: Boolean);
begin
  fAllowSelectFolder := Value;
end;

procedure TfrmCustomersDlg.SetCustomerID(const Value: integer);
begin
  fCustomerID := Value;
end;

procedure TfrmCustomersDlg.SetCustomFilter(const Value: TCustomerFiltersSet);
var
  i: TCustomerFilters;
  S: string;
begin
  // CUSTOMER_TYPE_ID
  fCustomFilter := Value;
  fCustomFilterSQL := '';

  S := '';
  for i := Low(TCustomerFilters) to High(TCustomerFilters) do
    if i in fCustomFilter then
      case i of
        cfCustomers:
          S := S + '4001,4010,4011,';
        // Клиенты, Клиенты Физические, Клиенты Юридические
        cfFirms:
          S := S + '4002,4009,'; // Фирмы, Структура фирмы
        cfDiler:
          S := S + '4003,'; // Дилеры
        cfFranchises:
          S := S + '4004,'; // Франшизы
        cfVendors:
          S := S + '4005,'; // Поставщики
        cfColaboratori:
          S := S + '4006,'; // Сотрудники
      end;

  if (S <> '') then
  begin
    // remove last comma
    SetLength(S, Length(S) - 1);
    S := Format('A.CUSTOMER_TYPE_ID IN (%s)', [S]);
    if cfSecuredFirms in fCustomFilter then
      S := S + ' AND EXISTS(SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';
  end;
  fCustomFilterSQL := S;
end;

procedure TfrmCustomersDlg.SetExcludeFilter(const Value: TCustomerFiltersSet);
var
  i: TCustomerFilters;
  S: string;
begin
  // CUSTOMER_TYPE_ID
  fExcludeFilter := Value;
  fExcludeFilterSQL := '';

  S := '';
  // excluded customer types
  for i := Low(TCustomerFilters) to High(TCustomerFilters) do
    if i in fExcludeFilter then
      case i of
        cfCustomers:
          S := S + '4001,4010,4011,';
        // Клиенты, Клиенты Физические, Клиенты Юридические
        cfFirms:
          S := S + '4002,';
        cfDiler:
          S := S + '4003,';
        cfFranchises:
          S := S + '4004,';
        cfVendors:
          S := S + '4005,';
        cfColaboratori:
          S := S + '4006,';
      end;

  if (S <> '') then
  begin
    // remove last comma
    SetLength(S, Length(S) - 1);
    S := Format('A.CUSTOMER_TYPE_ID NOT IN (%s)', [S]);
    if cfSecuredFirms in fCustomFilter then
      S := S + ' AND EXISTS(SELECT CUSTOMERID FROM GET_FIRMS_BY_USER2 GFBU2 WHERE GFBU2.CUSTOMERID=A.CUSTOMERID)';
  end;
  fExcludeFilterSQL := S;
end;

procedure TfrmCustomersDlg.SetRootParentID(const Value: integer);
begin
  fRootParentID := Value;
end;

procedure TfrmCustomersDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
  if FSelectMode then
  begin
    btnCancel.Caption := 'Renunta';
    btnOk.Visible := True;
  end
  else
  begin
    btnCancel.Caption := 'Inchide';
    btnOk.Visible := False;
  end;
end;

procedure TfrmCustomersDlg.SetTitle(const Value: string);
begin
  Caption := Value;
end;

procedure TfrmCustomersDlg.SetupReportParams(const ReportParams: TReportParamsList);
var
  N: integer;
begin
  N := -1;
  if Assigned(cxGridCustomersTable.Controller.FocusedRow) then
    N := cxGridCustomersTable.Controller.FocusedRow.Values[cxGridCustomers_CUSTOMERID.Index];
  // setup here general params
  ReportParams.SetParamValue('CT', N);
end;

procedure TfrmCustomersDlg.SetupSecurityItems;
begin

  cSecurityFlag_IsAdmin := SWNSecurityManager.LoggedUser.IsInAdminGroup;
  // Контрагент
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Создание_папки) then
    bbNewFolder.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Создание_клиента) then
    bbNewCustomer.Visible := ivNever;

  cSecurityFlag_CanModify_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_папки);
  cSecurityFlag_CanModify_Customer := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_клиента)
    or SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_клиента_сотрудника);

  if not (cSecurityFlag_CanModify_Folder or cSecurityFlag_CanModify_Customer) then
    bbEditCustomer.Visible := ivNever;

  cSecurityFlag_CanDelete_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Удаление_папки);
  cSecurityFlag_CanDelete_Customer := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Удаление_клиента);
  if not (cSecurityFlag_CanDelete_Folder or cSecurityFlag_CanDelete_Customer) then
    bbDeleteCustomer.Visible := ivNever;

  // conditii de lucru cu furnizorii
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Conditiile_de_lucru_cu_furnizorii) then
     bbConditiiDeLucru.Visible := ivNever;

  // Дополнительно
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Банковские_реквизиты) then
    bbAccounts.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Дисконтные_карточки) then
    bbDiscounts.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Кредиты_просмотр) or SWNSecurityManager.IsPartialAccessMode
    then
    bbCredits.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Интернет_доступ) then
    bbWEB.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Комментарии) then
    bbComments.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_предка) then
    bbChangeParent.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Упорядочивание_папок) then
    bbChangeFolderOrder.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента) or SWNSecurityManager.IsPartialAccessMode then
    bbCustomerCurrentDebts.Visible := ivNever;

  if not ((SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) or
    SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Смотреть)) or SWNSecurityManager.IsPartialAccessMode)
    then
    bbCustomerContracts.Visible := ivNever;

  // Group: Дополнительно
  if bbAdditionalTools.ItemLinks.VisibleItemCount = 0 then
    bbAdditionalTools.Visible := ivNever;

  // Обьединение контрагентов
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Создание_клиента) then
    bbJoinCustomers.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerContracts.Visible := ivNever;
    bbCustomerCurrentDebts.Visible := ivNever;
    bbNotifyCustDebts.Visible := ivNever;
    bbConditiiDeLucru.Visible := ivNever;
  end;

  // Group: Инструменты
  if bbTools.ItemLinks.VisibleItemCount = 0 then
    bbTools.Visible := ivNever;

  if SWNSecurityManager.IsLimitedUser then
  begin
    bbConditiiDeLucru.Visible := ivNever;
    bbAdditionalTools.Visible := ivNever;
    cxGridCustomers_TELEFON1.Visible := False;
    cxGridCustomers_MOBILE.Visible := False;
    cxGridCustomers_ACCOUNTNUMBER.Visible := False;
    cxGridCustomers_IDEN_NUMBER.Visible := False;
    bbEditCustomer.Visible := ivNever;
  end;

end;

function TfrmCustomersDlg.ItemSelected: Boolean;
begin
  Result := False;

  if (IBCQueryCustomer.RecordCount = 0) or (not FSelectMode) then
    Exit;

  if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    if fAllowSelectFolder then
    begin
      fCustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
      fCustomerTitle := IBCQueryCustomer.FieldByName('DISPLAYNAME').AsString;
      fCustomerTypeID := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger;
      fCustomerIsFolder := True;
      Result := True;
    end;
  end
  else
  begin
    fCustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
    fCustomerTitle := IBCQueryCustomer.FieldByName('DISPLAYNAME').AsString;
    fCustomerVAT := IBCQueryCustomer.FieldByName('VAT').AsInteger;
    fCustomerTypeID := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger;
    fCurrentParentID := IBCQueryCustomer.FieldByName('PARENTID').AsInteger;
    fCustomerIsFolder := False;
    Result := True;
  end;
end;

procedure TfrmCustomersDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and
     AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;

  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then begin
    cxPropertiesStore1.StorageName := Extractfilepath (Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
    cxPropertiesStore1.RestoreFrom;
  end;

end;

procedure TfrmCustomersDlg.ModifySelectedCustomer;
var
  dialog_fold: TfrmCustomerFolderEditorDialog;
  dialog_cust: TfrmCustomerEditorDialog;
  fAngajat: Boolean;
  CanModify: Boolean;
begin
  fAngajat := IBCQueryCustomer.FieldByName('CUSTOMER_TYPE_ID').AsInteger = 4006;
  if IBCQueryCustomer.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_папки) then
    begin
      dialog_fold := TfrmCustomerFolderEditorDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
      try
        dialog_fold.CreateNewRecord := False;
        dialog_fold.ShowModal;
      finally
        dialog_fold.Free;
      end;
    end;
  end
  else
  begin
    CanModify := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_клиента);
    if CanModify and fAngajat then
      CanModify := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Изменение_клиента_сотрудника);

    dialog_cust := TfrmCustomerEditorDialog.Create(Self, IBCQueryCustomer, IBCDataSourceCustomer);
    try
      dialog_cust.LocalUpdateTransaction := IBCQueryCustomer.UpdateTransaction;
      dialog_cust.CustomerID := IBCQueryCustomer.FieldByName('CUSTOMERID').AsInteger;
      dialog_cust.CreateNewRecord := False;
      dialog_cust.readonly := not CanModify;
      dialog_cust.ShowModal;
    finally
      dialog_cust.Free;
    end;
  end;
end;

procedure TfrmCustomersDlg.SetCustomerFolderID(const Value: Integer);
begin
  FCustomerFolderID := Value;
end;

procedure TfrmCustomersDlg.SetSearchText(const Value: string);
begin
  FSearchText := Value;
end;

end.


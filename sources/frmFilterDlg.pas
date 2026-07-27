unit frmFilterDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, SWNUtils, SWNDataFiltering,
  Dialogs, ExtCtrls, Menus, DB, DBAccess, IBC,
  StdCtrls, cxButtons, cxDBLookupComboBox, cxButtonEdit, cxSpinEdit, cxCheckBox,
  cxRadioGroup, cxLabel, cxDropDownEdit, cxEdit, cxTextEdit, cxCalendar,
  cxCustomData, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGridLevel, cxGrid, dxBar, Vcl.ComCtrls,
  SWNDocumentFilters, cxPC, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxControls,
  cxContainer, dxCore, cxDateUtils, cxStyles, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, MemDS, cxClasses, cxLookupEdit, cxDBLookupEdit, cxMaskEdit, dxCoreGraphics,
  dxUIAClasses;

type
  TfrmFilterDialog = class(TSWNBaseFormClass)
    pnButtons: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    btnClearFilter: TcxButton;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbGoodsAdd: TdxBarButton;
    bbGoodsRemove: TdxBarButton;
    bbGoodsClear: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    bbAcntFolderAdd: TdxBarButton;
    bbAcntFolderDelete: TdxBarButton;
    bbAcntFoldersClear: TdxBarButton;
    cxPageControl: TcxPageControl;
    tbsDate: TcxTabSheet;
    tbsClient: TcxTabSheet;
    tbsGoods: TcxTabSheet;
    tbsStock: TcxTabSheet;
    deDateStart: TcxDateEdit;
    deDateEnd: TcxDateEdit;
    cmbQuickDate: TcxComboBox;
    cxLabel1: TcxLabel;
    rbQuarter: TcxRadioButton;
    rbMonth: TcxRadioButton;
    rbDay: TcxRadioButton;
    rbDateRange: TcxRadioButton;
    cbQuarterYearStart: TcxCheckBox;
    cbMonthQuarterStart: TcxCheckBox;
    cbDayMonthStart: TcxCheckBox;
    cmbQuarter: TcxComboBox;
    cmbMonth: TcxComboBox;
    seQuarterYear: TcxSpinEdit;
    seMonthYear: TcxSpinEdit;
    deDateByDay: TcxDateEdit;
    rbNoDateFilter: TcxRadioButton;
    cxLabel4: TcxLabel;
    lcbCustomer: TcxButtonEdit;
    cxLabel5: TcxLabel;
    lcbGoods: TcxButtonEdit;
    cxLabel2: TcxLabel;
    pcGoodsGroups: TPageControl;
    tbsGoodsFolders: TTabSheet;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridTableView;
    cxGrid_GOODSID: TcxGridColumn;
    cxGrid_TITLE: TcxGridColumn;
    cxGridGoodsLevel: TcxGridLevel;
    tbsGoodsByAcnt: TTabSheet;
    dxBarDockControl2: TdxBarDockControl;
    cxGridAcnt: TcxGrid;
    cxGridAcntTable: TcxGridTableView;
    cxGridAcntTable_ACNTID: TcxGridColumn;
    cxGridAcntTable_TITLE: TcxGridColumn;
    cxGridAcntLevel: TcxGridLevel;
    cxLabel3: TcxLabel;
    txtGoodsSN: TcxTextEdit;
    cxLabel6: TcxLabel;
    lcbStock: TcxLookupComboBox;
    cxLabel7: TcxLabel;
    lcbCustomerType: TcxLookupComboBox;
    IBCQueryCustTypes: TIBCQuery;
    IBCDataSourceCustTypes: TIBCDataSource;
    procedure cmbQuickDatePropertiesEditValueChanged(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lcbCustomerPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCustomerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure lcbGoodsPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure lcbGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure rbQuarterClick(Sender: TObject);
    procedure lcbCustomerKeyPress(Sender: TObject; var Key: Char);
    procedure lcbGoodsKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbGoodsAddClick(Sender: TObject);
    procedure bbGoodsRemoveClick(Sender: TObject);
    procedure bbGoodsClearClick(Sender: TObject);
    procedure cxGridAcntTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAcntFolderAddClick(Sender: TObject);
    procedure bbAcntFolderDeleteClick(Sender: TObject);
    procedure bbAcntFoldersClearClick(Sender: TObject);
    procedure cxGridAcntTableFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure cxGridGoodsTableFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxPageControlCanCloseEx(Sender: TObject; ATabIndex: Integer; var ACanClose: Boolean);
  private
    { Private declarations }
    fLocalDataFilteringInfo: TFrameDataFilteringInfo;
    fReferenceDataFilteringInfo: TFrameDataFilteringInfo;
    fFrameFilterFields: TFrameFilterFields;
    fLastGoodsFolderID: Integer;
    fLastAcntFolderID: Integer;
    procedure SetupQuickDateFilter(const filterItem: TFrameDocumentDateFilter);
    procedure SelectCustomer;
    procedure SelectGoods;
    procedure SelectDateFilterByDate(const StartDate, EndDate: TDateTime);
    procedure CreateDateFilter;
    procedure SetDateEnd(const Value: TDateTime);
    procedure SetDateStart(const Value: TDateTime);
    procedure SetCustomerID(const Value: Integer);
    procedure SetCustomerText(const Value: string);
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsText(const Value: string);
    procedure SetStockID(const Value: Integer);
    procedure SetGoodsSNText(const Value: string);
    procedure GoodsFoldersSelectionChanged;
    procedure DisplayGoodsFoldersIDList;
    procedure AddGoodsFolderItemToGrid(const GoodsFolderID: Integer; const Title: string);
    procedure ShowAddGoodsFoldersDialog;
    procedure SaveGoodsFoldersIDList;
    procedure AcntFoldersSelectionChanged;
    procedure DisplayAcntFoldersIDList;
    procedure AddAcntItemToGrid(const AcntID: Integer; const AcntTitle: string);
    procedure ShowAddAcntFolderDialog;
    procedure SaveAcntFoldersIDList;
    procedure ShowFirstVisibleTab;
    procedure ClearGridData(const Grid: TcxGridTableView);
    procedure SetTabsVisibility;
    procedure DisplayEditValues;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
  public
    { Public declarations }

    procedure SetupFilters(const FrameFilterFields: TFrameFilterFields; const CurrentDataFilteringInfo: TFrameDataFilteringInfo);
    property DateStart: TDateTime write SetDateStart;
    property DateEnd: TDateTime write SetDateEnd;
    property CustomerID: Integer write SetCustomerID;
    property CustomerText: string write SetCustomerText;
    property GoodsID: Integer write SetGoodsID;
    property GoodsText: string write SetGoodsText;
    property GoodsSNText: string write SetGoodsSNText;
    property StockID: Integer write SetStockID;
  end;

implementation

uses
  DateUtils, frmGoods, frmCustomersDlg, DataModuleDB, frmGoodsACNTBrowser;

{$R *.dfm}

procedure TfrmFilterDialog.AcntFoldersSelectionChanged;
var
  fAdd, fRemove, fClear: Boolean;
begin
  fAdd := True;
  fRemove := False;
  fClear := cxGridAcntTable.DataController.RecordCount > 0;
  if Assigned(cxGridAcntTable.Controller.FocusedRow) then
  begin
    fRemove := True;
    fClear := True;
  end;
  bbAcntFolderAdd.Enabled := fAdd;
  bbAcntFolderDelete.Enabled := fRemove;
  bbAcntFoldersClear.Enabled := fClear;
end;

procedure TfrmFilterDialog.AddAcntItemToGrid(const AcntID: Integer; const AcntTitle: string);
var
  N, i: Integer;
  found: Boolean;
begin
  found := False;
  // verificam daca nu este deja
  for i := 0 to cxGridAcntTable.DataController.RecordCount - 1 do
  begin
    if (cxGridAcntTable.DataController.Values[i, cxGridAcntTable_ACNTID.Index] = AcntID) then
    begin
      found := True;
      break;
    end;
  end;
  if not found then
  begin
    cxGridAcntTable.BeginUpdate;
    try
      N := cxGridAcntTable.DataController.AppendRecord;
      cxGridAcntTable.DataController.Values[N, cxGridAcntTable_ACNTID.Index] := AcntID;
      cxGridAcntTable.DataController.Values[N, cxGridAcntTable_TITLE.Index] := AcntTitle;
    finally
      cxGridAcntTable.EndUpdate;
    end;
    tbsGoodsByAcnt.ImageIndex := 43;
  end;
end;

procedure TfrmFilterDialog.AddGoodsFolderItemToGrid(const GoodsFolderID: Integer; const Title: string);
var
  N, i: Integer;
  found: Boolean;
begin
  found := False;
  // verificam daca nu este deja
  for i := 0 to cxGridGoodsTable.DataController.RecordCount - 1 do
  begin
    if (cxGridGoodsTable.DataController.Values[i, cxGrid_GOODSID.Index] = GoodsFolderID) then
    begin
      found := True;
      break;
    end;
  end;
  if not found then
  begin
    cxGridGoodsTable.BeginUpdate;
    try
      N := cxGridGoodsTable.DataController.AppendRecord;
      cxGridGoodsTable.DataController.Values[N, cxGrid_GOODSID.Index] := GoodsFolderID;
      cxGridGoodsTable.DataController.Values[N, cxGrid_TITLE.Index] := Title;
    finally
      cxGridGoodsTable.EndUpdate;
    end;
    tbsGoodsFolders.ImageIndex := 43;
  end;
end;

procedure TfrmFilterDialog.bbAcntFolderAddClick(Sender: TObject);
begin
  ShowAddAcntFolderDialog;
end;

procedure TfrmFilterDialog.bbAcntFolderDeleteClick(Sender: TObject);
begin
  cxGridAcntTable.BeginUpdate;
  try
    cxGridAcntTable.DataController.DeleteSelection;
  finally
    cxGridAcntTable.EndUpdate;
  end;
  if cxGridAcntTable.DataController.RecordCount = 0 then
    tbsGoodsByAcnt.ImageIndex := -1;
end;

procedure TfrmFilterDialog.bbAcntFoldersClearClick(Sender: TObject);
begin
  cxGridAcntTable.BeginUpdate;
  try
    cxGridAcntTable.DataController.SelectAll;
    cxGridAcntTable.DataController.DeleteSelection;
  finally
    cxGridAcntTable.EndUpdate;
  end;
  if cxGridAcntTable.DataController.RecordCount = 0 then
    tbsGoodsByAcnt.ImageIndex := -1;
end;

procedure TfrmFilterDialog.bbGoodsAddClick(Sender: TObject);
begin
  ShowAddGoodsFoldersDialog;
end;

procedure TfrmFilterDialog.bbGoodsClearClick(Sender: TObject);
begin
  cxGridGoodsTable.BeginUpdate;
  try
    cxGridGoodsTable.DataController.SelectAll;
    cxGridGoodsTable.DataController.DeleteSelection;
  finally
    cxGridGoodsTable.EndUpdate;
  end;
  if cxGridGoodsTable.DataController.RecordCount = 0 then
    tbsGoodsFolders.ImageIndex := -1;
end;

procedure TfrmFilterDialog.bbGoodsRemoveClick(Sender: TObject);
begin
  cxGridGoodsTable.BeginUpdate;
  try
    cxGridGoodsTable.DataController.DeleteSelection;
  finally
    cxGridGoodsTable.EndUpdate;
  end;
  if cxGridGoodsTable.DataController.RecordCount = 0 then
    tbsGoodsFolders.ImageIndex := -1;
end;

procedure TfrmFilterDialog.btnOkClick(Sender: TObject);
var
  y1, m1, m2: Word;
begin
  // check Dates
  if rbNoDateFilter.Checked then
  begin
    fLocalDataFilteringInfo.DateStart := 0;
    fLocalDataFilteringInfo.DateEnd := 0;
  end
  else if rbQuarter.Checked then
  begin
    // Квартал
    y1 := seQuarterYear.Value;
    m2 := (cmbQuarter.ItemIndex + 1) * 3;
    if cbQuarterYearStart.Checked then
    begin
      // С начала года
      fLocalDataFilteringInfo.DateStart := EncodeDate(y1, 1, 1);
      fLocalDataFilteringInfo.DateEnd := EncodeDate(y1, m2, DaysInAMonth(y1, m2));
    end
    else
    begin
      m1 := (cmbQuarter.ItemIndex * 3) + 1;
      fLocalDataFilteringInfo.DateStart := EncodeDate(y1, m1, 1);
      fLocalDataFilteringInfo.DateEnd := EncodeDate(y1, m2, DaysInAMonth(y1, m2));
    end;
  end
  else if rbMonth.Checked then
  begin
    // Месяц
    y1 := seMonthYear.Value;
    m1 := cmbMonth.ItemIndex + 1;
    if cbMonthQuarterStart.Checked then
    begin
      // С начало квартала
      fLocalDataFilteringInfo.DateEnd := EncodeDate(y1, m1, DaysInAMonth(y1, m1));
      m2 := m1 div 3;
      if (m1 mod 3) > 0 then
        Inc(m2);
      m2 := (m2 - 1) * 3 + 1;
      fLocalDataFilteringInfo.DateStart := EncodeDate(y1, m2, 1);
    end
    else
    begin
      fLocalDataFilteringInfo.DateStart := EncodeDate(y1, m1, 1);
      fLocalDataFilteringInfo.DateEnd := EncodeDate(y1, m1, DaysInAMonth(y1, m1));
    end;
  end
  else if rbDay.Checked then
  begin
    // День
    if cbDayMonthStart.Checked then
    begin
      // С начала месяца
      fLocalDataFilteringInfo.DateEnd := deDateByDay.Date;
      fLocalDataFilteringInfo.DateStart := IncDay(fLocalDataFilteringInfo.DateEnd, -DayOfTheMonth(fLocalDataFilteringInfo.DateEnd) + 1);
    end
    else
    begin
      fLocalDataFilteringInfo.DateStart := deDateByDay.Date;
      fLocalDataFilteringInfo.DateEnd := deDateByDay.Date;
    end;
  end
  else if rbDateRange.Checked then
  begin
    // Интервал
    fLocalDataFilteringInfo.DateStart := deDateStart.Date;
    fLocalDataFilteringInfo.DateEnd := deDateEnd.Date;
  end;

  // Customer
  fLocalDataFilteringInfo.CustomerText := '';
  if (Trim(lcbCustomer.Text) <> '') then
    fLocalDataFilteringInfo.CustomerText := Trim(lcbCustomer.Text);

  // Customer Type
  fLocalDataFilteringInfo.CustomerTypeID := -1;
  if VarIsNumeric(lcbCustomerType.EditValue) and (lcbCustomerType.EditValue > 0) then
    fLocalDataFilteringInfo.CustomerTypeID := lcbCustomerType.EditValue;

  // Goods
  fLocalDataFilteringInfo.GoodsText := '';
  if (Trim(lcbGoods.Text) <> '') then
    fLocalDataFilteringInfo.GoodsText := Trim(lcbGoods.Text);

  // Goods SN
  if (Trim(txtGoodsSN.Text) <> '') then
    fLocalDataFilteringInfo.GoodsSN := txtGoodsSN.Text;

  // Stock
  fLocalDataFilteringInfo.StockID := -1;
  if VarIsNumeric(lcbStock.EditValue) and (lcbStock.EditValue > 0) then
    fLocalDataFilteringInfo.StockID := lcbStock.EditValue;

  // goods folders
  fLocalDataFilteringInfo.GoodsFolders.Clear;
  if cxGridGoodsTable.DataController.RecordCount > 0 then
    SaveGoodsFoldersIDList;

  // acnt goods
  fLocalDataFilteringInfo.AcntGoods.Clear;
  if (cxGridAcntTable.DataController.RecordCount > 0) then
    SaveAcntFoldersIDList;

  // Inchidem numai daca sunt filtre active
  if fLocalDataFilteringInfo.FrameFilters <> [] then
  begin
    fLocalDataFilteringInfo.CopyFiltersTo(fReferenceDataFilteringInfo);
    ModalResult := mrOk;
  end
  else
    ShowErrorDialog('Eroare', 'Pentru filtrare alegeti valorile corecte!');
end;

procedure TfrmFilterDialog.ClearGridData(const Grid: TcxGridTableView);
var
  i: Integer;
begin
  Grid.BeginUpdate;
  try
    for i := Grid.DataController.RecordCount - 1 downto 0 do
      Grid.DataController.DeleteRecord(i);
  finally
    Grid.EndUpdate;
  end;
end;

procedure TfrmFilterDialog.cmbQuickDatePropertiesEditValueChanged(Sender: TObject);
var
  filterObj: TDocumentDateFilterItem;
begin
  if cmbQuickDate.ItemIndex <> -1 then
  begin
    filterObj := TDocumentDateFilterItem(cmbQuickDate.Properties.Items.Objects[cmbQuickDate.ItemIndex]);
    SetupQuickDateFilter(filterObj.Filter);
  end;
end;

procedure TfrmFilterDialog.CreateDateFilter;
var
  i: TFrameDocumentDateFilter;
  filterObj: TDocumentDateFilterItem;
begin
  cmbQuickDate.Properties.Items.BeginUpdate;
  try
    cmbQuickDate.Properties.Items.Clear;
    for i in cDocumentAllFiltersWithFilter do
    begin
      filterObj := SWNDocumentFrameDateFilters.GetFilterObject(i);
      cmbQuickDate.Properties.Items.AddObject(filterObj.Title, filterObj);
    end;
    // select first as default
    // if cmbQuickDate.Properties.Items.Count>0 then cmbQuickDate.ItemIndex:=0;
  finally
    cmbQuickDate.Properties.Items.EndUpdate;
  end;
end;

procedure TfrmFilterDialog.cxGridAcntTableFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  AcntFoldersSelectionChanged;
end;

procedure TfrmFilterDialog.cxGridAcntTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  AcntFoldersSelectionChanged;
end;

procedure TfrmFilterDialog.cxGridGoodsTableFocusedItemChanged(Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  GoodsFoldersSelectionChanged;
end;

procedure TfrmFilterDialog.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsFoldersSelectionChanged;
end;

procedure TfrmFilterDialog.cxPageControlCanCloseEx(Sender: TObject; ATabIndex: Integer; var ACanClose: Boolean);
begin
  ACanClose := False;

  case ATabIndex of
    0:
      begin
        tbsDate.AllowCloseButton := False;
        tbsDate.ImageIndex := -1;
        rbNoDateFilter.Checked := True;
      end;
    1:
      begin
        tbsClient.AllowCloseButton := False;
        tbsClient.ImageIndex := -1;
        lcbCustomer.Text := '';
        fLocalDataFilteringInfo.CustomerID := -1;
        fLocalDataFilteringInfo.CustomerText := '';
        lcbCustomerType.EditValue := -1;
      end;
    2:
      begin
        tbsGoods.AllowCloseButton := False;
        tbsGoods.ImageIndex := -1;
        lcbGoods.Text := '';
        fLocalDataFilteringInfo.GoodsID := -1;
        fLocalDataFilteringInfo.GoodsText := '';
        txtGoodsSN.EditValue := '';
        fLocalDataFilteringInfo.GoodsFolders.Clear;
        fLocalDataFilteringInfo.AcntGoods.Clear;
        ClearGridData(cxGridGoodsTable);
        ClearGridData(cxGridAcntTable);
      end;
    3:
      begin
        tbsStock.AllowCloseButton := False;
        tbsStock.ImageIndex := -1;
        lcbStock.EditValue := -1;
      end;
  end;
end;

procedure TfrmFilterDialog.DisplayAcntFoldersIDList;
var
  Query: TIBCQuery;
  N: Integer;
begin
  cxGridAcntTable.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Append('SELECT GOODS_ACNT_ID, NAMEACNT FROM TS_GOODS_ACNT WHERE GOODS_ACNT_ID IN (');
    Query.SQL.Append(fLocalDataFilteringInfo.AcntGoods.GetValueList);
    Query.SQL.Append(')');
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridAcntTable.DataController.AppendRecord;
      cxGridAcntTable.DataController.Values[N, cxGridAcntTable_ACNTID.Index] := Query.Fields[0].AsInteger;
      cxGridAcntTable.DataController.Values[N, cxGridAcntTable_TITLE.Index] := Query.Fields[1].AsString;
      Query.Next;
    end;
  finally
    Query.Free;
    cxGridAcntTable.EndUpdate;
  end;
end;

procedure TfrmFilterDialog.DisplayEditValues;
var
  fieldsWithValues: TFrameDataFilterSet;
begin
  fieldsWithValues := fLocalDataFilteringInfo.FrameFilters;

  // Период
  rbQuarterClick(nil);
  if (ffDate in fFrameFilterFields) then
  begin
    if (dfiDATE in fieldsWithValues) then
    begin
      SelectDateFilterByDate(fLocalDataFilteringInfo.DateStart, fLocalDataFilteringInfo.DateEnd);
      tbsDate.ImageIndex := 43;
      tbsDate.AllowCloseButton := True;
    end;
  end
  else
    tbsDate.Visible := False;

  // Контрагент
  if (([ffCustomer, ffCustomerType] * fFrameFilterFields) <> []) then
  begin
    // Контрагент
    cxLabel4.Visible := ffCustomer in fFrameFilterFields;
    lcbCustomer.Visible := ffCustomer in fFrameFilterFields;

    // Тип контрагента
    cxLabel7.Visible := ffCustomerType in fFrameFilterFields;
    lcbCustomerType.Visible := ffCustomerType in fFrameFilterFields;
    IBCQueryCustTypes.Active := ffCustomerType in fFrameFilterFields;

    if (([dfiCustomerID, dfiCustomerText, dfiCustomerTypeID] * fieldsWithValues) <> []) then
    begin
      lcbCustomer.Text := fLocalDataFilteringInfo.CustomerText;
      lcbCustomerType.EditValue := fLocalDataFilteringInfo.CustomerTypeID;

      tbsClient.ImageIndex := 43;
      tbsClient.AllowCloseButton := True;
    end;
  end
  else
    tbsClient.Visible := False;

  // Товар
  if (([ffGoods, ffGoodsFolders, ffAcntGoods, ffGoodsSN] * fFrameFilterFields) <> []) then
  begin
    // Товар
    cxLabel5.Visible := ffGoods in fFrameFilterFields;
    lcbGoods.Visible := ffGoods in fFrameFilterFields;
    // Серийный номер товара
    cxLabel3.Visible := ffGoodsSN in fFrameFilterFields;
    txtGoodsSN.Visible := ffGoodsSN in fFrameFilterFields;
    // Группа товаров
    cxLabel2.Visible := ([ffGoodsFolders, ffAcntGoods] * fFrameFilterFields) <> [];
    tbsGoodsFolders.Visible := ffGoodsFolders in fFrameFilterFields;
    tbsGoodsByAcnt.Visible := ffAcntGoods in fFrameFilterFields;
    if tbsGoodsFolders.Visible then
      pcGoodsGroups.ActivePage := tbsGoodsFolders;
    pcGoodsGroups.Visible := cxLabel2.Visible;

    if (([dfiGoodsID, dfiGoodsText, dfiGoodsSN, dfiGoodsFolders, dfiAcntGoods] * fieldsWithValues) <> []) then
    begin
      lcbGoods.Text := fLocalDataFilteringInfo.GoodsText;
      txtGoodsSN.Text := fLocalDataFilteringInfo.GoodsSN;
      if (fLocalDataFilteringInfo.GoodsFolders.Count > 0) then
      begin
        DisplayGoodsFoldersIDList;
        GoodsFoldersSelectionChanged;
      end;
      if (fLocalDataFilteringInfo.AcntGoods.Count > 0) then
      begin
        DisplayAcntFoldersIDList;
        AcntFoldersSelectionChanged;
      end;

      tbsGoods.ImageIndex := 43;
      tbsGoods.AllowCloseButton := True;
    end;
  end
  else
    tbsGoods.Visible := False;

  // Склад
  if (ffStock in fFrameFilterFields) then
  begin
    dmDB.IBCQueryStocks.Active := True;

    if (dfiStockID in fieldsWithValues) then
    begin
      lcbStock.EditValue := fLocalDataFilteringInfo.StockID;

      tbsStock.ImageIndex := 43;
      tbsStock.AllowCloseButton := True;
    end;
  end
  else
    tbsStock.Visible := False;
end;

procedure TfrmFilterDialog.DisplayGoodsFoldersIDList;
var
  Query: TIBCQuery;
  N: Integer;
begin
  cxGridGoodsTable.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Append('SELECT GOODSID, TITLE FROM TS_GOODS WHERE GOODSID IN (');
    Query.SQL.Append(fLocalDataFilteringInfo.GoodsFolders.GetValueList);
    Query.SQL.Append(')');
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridGoodsTable.DataController.AppendRecord;
      cxGridGoodsTable.DataController.Values[N, cxGrid_GOODSID.Index] := Query.Fields[0].AsInteger;
      cxGridGoodsTable.DataController.Values[N, cxGrid_TITLE.Index] := Query.Fields[1].AsString;
      Query.Next;
    end;
  finally
    Query.Free;
    cxGridGoodsTable.EndUpdate;
  end;
end;

procedure TfrmFilterDialog.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 113) then
    ModalResult := mrAbort;
end;

procedure TfrmFilterDialog.GoodsFoldersSelectionChanged;
var
  fAdd, fDelete, fClear: Boolean;
begin
  fAdd := True;
  fDelete := False;
  fClear := cxGridGoodsTable.DataController.RecordCount > 0;
  if Assigned(cxGridGoodsTable.Controller.FocusedRow) then
  begin
    fDelete := True;
  end;
  bbGoodsAdd.Enabled := fAdd;
  bbGoodsRemove.Enabled := fDelete;
  bbGoodsClear.Enabled := fClear;
end;

procedure TfrmFilterDialog.BindingDataSource;
begin
  inherited;
  fLocalDataFilteringInfo := TFrameDataFilteringInfo.Create;
  fReferenceDataFilteringInfo := nil;

  lcbCustomer.EditValue := NULL;
  lcbGoods.EditValue := NULL;
  lcbStock.EditValue := NULL;

  // setup default view
  CreateDateFilter;
  // cmbQuickDate.ItemIndex:=-1;

  cmbMonth.ItemIndex := MonthOfTheYear(NOW) - 1;

  seQuarterYear.Properties.MinValue := YearOf(NOW) - 1;
  seQuarterYear.Properties.MaxValue := seQuarterYear.Properties.MinValue + 2;
  seQuarterYear.Value := YearOf(NOW);

  seMonthYear.Properties.MinValue := seQuarterYear.Properties.MinValue;
  seMonthYear.Properties.MaxValue := seQuarterYear.Properties.MaxValue;
  seMonthYear.Value := YearOf(NOW);

  fLastGoodsFolderID := -1;
  fLastAcntFolderID := -1;

  tbsDate.AllowCloseButton := False;
  tbsClient.AllowCloseButton := False;
  tbsGoods.AllowCloseButton := False;
  tbsStock.AllowCloseButton := False;
end;

procedure TfrmFilterDialog.lcbCustomerKeyPress(Sender: TObject; var Key: Char);
begin
  fLocalDataFilteringInfo.CustomerID := -1
end;

procedure TfrmFilterDialog.lcbCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomer;
end;

procedure TfrmFilterDialog.lcbCustomerPropertiesEditValueChanged(Sender: TObject);
begin
  if VarIsNull(lcbCustomer.EditValue) then
  begin
    fLocalDataFilteringInfo.CustomerID := -1;
  end
  else
  begin
    if Trim(lcbCustomer.EditValue) = '' then
    begin
      fLocalDataFilteringInfo.CustomerID := -1;
      lcbCustomer.EditValue := NULL;
    end;
  end;
end;

procedure TfrmFilterDialog.lcbCustomerPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText:
  TCaption; var Error: Boolean);
begin
  fLocalDataFilteringInfo.CustomerID := -1;
end;

procedure TfrmFilterDialog.lcbGoodsKeyPress(Sender: TObject; var Key: Char);
begin
  fLocalDataFilteringInfo.GoodsID := -1;
end;

procedure TfrmFilterDialog.lcbGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectGoods;
end;

procedure TfrmFilterDialog.lcbGoodsPropertiesEditValueChanged(Sender: TObject);
begin
  if VarIsNull(lcbGoods.EditValue) then
    fLocalDataFilteringInfo.GoodsID := -1
  else
  begin
    if Trim(lcbGoods.EditValue) = '' then
    begin
      fLocalDataFilteringInfo.GoodsID := -1;
      lcbGoods.EditValue := NULL;
    end;
  end;
end;

procedure TfrmFilterDialog.Prepare;
begin
  SetTabsVisibility;
  DisplayEditValues;
  ShowFirstVisibleTab;
end;

procedure TfrmFilterDialog.rbQuarterClick(Sender: TObject);
var
  fq: Boolean;
  fm: Boolean;
  fd: Boolean;
  fi: Boolean;
begin
  // disable all
  fq := False;
  fm := False;
  fd := False;
  fi := False;
  // enable only needed
  if Sender = rbQuarter then // Квартал
  begin
    fq := True;
  end
  else if Sender = rbMonth then // Месяц
  begin
    fm := True;
  end
  else if Sender = rbDay then // День
  begin
    fd := True;
    if deDateByDay.Date <= 0 then
      deDateByDay.Date := NOW;
  end
  else if Sender = rbDateRange then // Интервал
  begin
    fi := True;
    if deDateStart.Date <= 0 then
      deDateStart.Date := NOW;
    if deDateEnd.Date <= 0 then
      deDateEnd.Date := NOW;
  end;

  // Квартал
  cmbQuarter.Enabled := fq;
  seQuarterYear.Enabled := fq;
  cbQuarterYearStart.Enabled := fq;
  // Месяц
  cmbMonth.Enabled := fm;
  seMonthYear.Enabled := fm;
  cbMonthQuarterStart.Enabled := fm;
  // День
  deDateByDay.Enabled := fd;
  cbDayMonthStart.Enabled := fd;
  cbDayMonthStart.Enabled := fd;
  // Интервал
  deDateStart.Enabled := fi;
  deDateEnd.Enabled := fi;
end;

procedure TfrmFilterDialog.SaveAcntFoldersIDList;
var
  i: Integer;
begin
  fLocalDataFilteringInfo.AcntGoods.Clear;
  for i := 0 to cxGridAcntTable.DataController.RecordCount - 1 do
    fLocalDataFilteringInfo.AcntGoods.Add(cxGridAcntTable.DataController.Values[i, cxGridAcntTable_ACNTID.Index]);
end;

procedure TfrmFilterDialog.SaveGoodsFoldersIDList;
var
  i: Integer;
begin
  fLocalDataFilteringInfo.GoodsFolders.Clear;
  for i := 0 to cxGridGoodsTable.DataController.RecordCount - 1 do
    fLocalDataFilteringInfo.GoodsFolders.Add(cxGridGoodsTable.DataController.Values[i, cxGrid_GOODSID.Index]);
end;

procedure TfrmFilterDialog.SelectCustomer;
var
  customers: TfrmCustomersDlg;
  ok: Boolean;
begin
  customers := TfrmCustomersDlg.Create(Self);
  try
    if (fLocalDataFilteringInfo.CustomerID = -1) and (lcbCustomer.Text <> '') then
      ok := customers.SelectCustomerBySearch(lcbCustomer.Text, 'Alegeti clientul pentru filtrare')
    else
      ok := customers.SelectCustomer(fLocalDataFilteringInfo.CustomerID, False, 0, 'Alegeti clientul pentru filtrare');
    if ok then
    begin
      fLocalDataFilteringInfo.CustomerID := customers.CustomerID;
      lcbCustomer.EditValue := customers.CustomerTitle;
    end;
  finally
    customers.Free;
  end;
end;

procedure TfrmFilterDialog.SelectDateFilterByDate(const StartDate, EndDate: TDateTime);
var
  Year, QuarterIndex, MonthIndex: Integer;
  Flag_StartingFrom: Boolean;
  selDay, selMonth, selQuarter: Boolean;
begin
  selDay := False;
  selMonth := False;
  selQuarter := False;

  if IsDateRangeDay(StartDate, EndDate, Flag_StartingFrom) then
  begin
    // День
    deDateByDay.Date := EndDate;
    cbDayMonthStart.Checked := Flag_StartingFrom;
    selDay := True;
  end;

  if IsDateRangeMonth(StartDate, EndDate, MonthIndex, Year, Flag_StartingFrom) then
  begin
    cmbMonth.ItemIndex := MonthIndex - 1;
    seMonthYear.Value := Year;
    cbMonthQuarterStart.Checked := Flag_StartingFrom;
    selMonth := True;
  end;

  if IsDateRangeQuarter(StartDate, EndDate, QuarterIndex, Year, Flag_StartingFrom) then
  begin
    cmbQuarter.ItemIndex := QuarterIndex - 1;
    seQuarterYear.Value := Year;
    cbQuarterYearStart.Checked := Flag_StartingFrom;
    selQuarter := True;
  end;

  // Интервал
  deDateStart.Date := StartDate;
  deDateEnd.Date := EndDate;

  // select by priority
  if selQuarter then
    rbQuarter.Checked := True // Квартал
  else if selMonth then
    rbMonth.Checked := True // Месяц
  else if selDay then
    rbDay.Checked := True // День
  else
    rbDateRange.Checked := True; // Интервал
end;

procedure TfrmFilterDialog.SelectGoods;
var
  goods: TfrmGoodsBrowser;
begin
  goods := TfrmGoodsBrowser.Create(Self);
  try
    if goods.SelectGoods(fLocalDataFilteringInfo.GoodsID, False, 0, 'Alegeti produsul pentru filtrare') then
    begin
      fLocalDataFilteringInfo.GoodsID := goods.GoodsID;
      fLocalDataFilteringInfo.GoodsText := goods.GoodsTitle;
      lcbGoods.EditValue := goods.GoodsTitle;
    end;
  finally
    goods.Free;
  end;
end;

procedure TfrmFilterDialog.SetCustomerID(const Value: Integer);
begin
  fLocalDataFilteringInfo.CustomerID := Value;
end;

procedure TfrmFilterDialog.SetCustomerText(const Value: string);
begin
  fLocalDataFilteringInfo.CustomerText := Value;
end;

procedure TfrmFilterDialog.SetDateEnd(const Value: TDateTime);
begin
  fLocalDataFilteringInfo.DateEnd := Value;
end;

procedure TfrmFilterDialog.SetDateStart(const Value: TDateTime);
begin
  fLocalDataFilteringInfo.DateStart := Value;
end;

procedure TfrmFilterDialog.SetGoodsID(const Value: Integer);
begin
  fLocalDataFilteringInfo.GoodsID := Value;
end;

procedure TfrmFilterDialog.SetGoodsSNText(const Value: string);
begin
  fLocalDataFilteringInfo.GoodsSN := Value;
end;

procedure TfrmFilterDialog.SetGoodsText(const Value: string);
begin
  fLocalDataFilteringInfo.GoodsText := Value;
end;

procedure TfrmFilterDialog.SetStockID(const Value: Integer);
begin
  fLocalDataFilteringInfo.StockID := Value;
end;

procedure TfrmFilterDialog.SetupFilters(const FrameFilterFields: TFrameFilterFields; const CurrentDataFilteringInfo:
  TFrameDataFilteringInfo);
begin
  // FrameFilterFields - arata care cautari sunt disponibile
  fFrameFilterFields := FrameFilterFields;

  // CurrentDataFilteringInfo - datele curente pentru filtrare
  // pastram referinta pentru setarea datelor la iesire
  fReferenceDataFilteringInfo := CurrentDataFilteringInfo;
  // facem o copie locala a datelor
  CurrentDataFilteringInfo.CopyFiltersTo(fLocalDataFilteringInfo);
end;

procedure TfrmFilterDialog.SetupQuickDateFilter(const filterItem: TFrameDocumentDateFilter);
var
  d1, d2: TDateTime;
begin
  if GetDocumentFrameFilterDateValues(filterItem, d1, d2) then
    SelectDateFilterByDate(d1, d2);
end;

procedure TfrmFilterDialog.SetTabsVisibility;
begin
  tbsDate.TabVisible := ffDate in fFrameFilterFields;
  tbsClient.TabVisible := ([ffCustomer, ffCustomerType] * fFrameFilterFields) <> [];
  tbsGoods.TabVisible := ([ffGoods, ffGoodsFolders, ffAcntGoods, ffGoodsSN] * fFrameFilterFields) <> [];
  tbsStock.TabVisible := ffStock in fFrameFilterFields;
end;

procedure TfrmFilterDialog.ShowAddAcntFolderDialog;
var
  browser: TfrmGoodsACNTDlg;
begin
  browser := TfrmGoodsACNTDlg.Create(Self);
  try
    browser.SelectMode := True;
    if (browser.SelectGoodsACNT(fLastAcntFolderID)) then
    begin
      AddAcntItemToGrid(browser.GoodsAcntID, browser.GoodsAcntTitle);
      fLastAcntFolderID := browser.GoodsAcntID;
    end;
  finally
    browser.Free;
  end;
end;

procedure TfrmFilterDialog.ShowAddGoodsFoldersDialog;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(fLastGoodsFolderID, True, 0, 'Alegeti mapa de produse pentru filtrare') then
    begin
      if dialog.GoodsIsFolder then
      begin
        AddGoodsFolderItemToGrid(dialog.GoodsID, dialog.GoodsTitle);
        fLastGoodsFolderID := dialog.GoodsID;
      end
      else
        ShowErrorDialog('Mape produse', 'Se poate adauga doar mape!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFilterDialog.ShowFirstVisibleTab;
var
  i: Integer;
begin
  // selectam primul tab visibil
  for i := 0 to cxPageControl.Properties.PageCount - 1 do
    if cxPageControl.Properties.Pages[i].TabVisible then
    begin
      cxPageControl.ActivePageIndex := i;
      break;
    end;
  // din acelea visibile selectam primul care are valoare in filtru (daca exista)
  for i := 0 to cxPageControl.Properties.PageCount - 1 do
    if cxPageControl.Properties.Pages[i].TabVisible and (cxPageControl.Pages[i].ImageIndex = 43) then
    begin
      cxPageControl.ActivePageIndex := i;
      break;
    end;
end;

end.



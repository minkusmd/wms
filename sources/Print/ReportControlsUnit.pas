unit ReportControlsUnit;

interface

uses
  Classes, frxClass, frxDsgnIntf, fs_iinterpreter, Controls, ExtCtrls, Buttons, cxGridCustomTableView,
  cxGridTableView, cxGridLevel, cxGrid, SWNValueStorageUnit, SWNCustomersTypesUnit, ReportSelectorPanelUnit,
  cxButtonEdit,
  cxEdit;

type
  TfrxContractSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TcxButtonEdit;
    fContractTitle: string;
    fContractNumber: string;
    fCustomerID: Integer;
    procedure SetContractNumber(const Value: string);
    procedure SetContractTitle(const Value: string);
    procedure SetCustomerID(const Value: integer);
  protected
    procedure WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TcxButtonEdit read fSelector;
  published
    property ContractTitle: string read fContractTitle write SetContractTitle;
    property ContractNumber: string read FContractNumber write SetContractNumber;
    property CustomerID: integer read FCustomerID write SetCustomerID;
  end;

  TfrxCustomerSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TcxButtonEdit;
    fCustomerTitle: string;
    fCustomerID: integer;
    fDefaultCustomer: integer;
    FCustomersFilter: TCustomerFiltersSet;
    FExcludeFilter: TCustomerFiltersSet;
    function GetLastSelectedCustomer: Integer;
    procedure SetDefaultCustomer(const Value: integer);
    procedure SetCustomersFilter(const Value: TCustomerFiltersSet);
    procedure SetExcludeFilter(const Value: TCustomerFiltersSet);
    procedure SetLastSelectedCustomer(const Value: Integer);
  protected
    { protected declarations }
    procedure WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TcxButtonEdit read fSelector;
    procedure LoadCustomer(const CustomerID: integer);
  published
    { published declarations }
    property CustomerID: integer read fCustomerID;
    property CustomerTitle: string read fCustomerTitle;
    property CustomersFilter: TCustomerFiltersSet read FCustomersFilter write SetCustomersFilter;
    property ExcludeFilter: TCustomerFiltersSet read FExcludeFilter write SetExcludeFilter;
    property DefaultCustomer: integer read fDefaultCustomer write SetDefaultCustomer;
    property LastSelectedCustomer: Integer read GetLastSelectedCustomer write SetLastSelectedCustomer;
  end;

  TfrxStockSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TcxButtonEdit;
    fStockTitle: string;
    fStockID: integer;
    fDefaultStockID: integer;
    procedure SetDefaultStockID(const Value: integer);
  protected
    { protected declarations }
    procedure WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TcxButtonEdit read fSelector;
    procedure LoadStock(const StockID: integer);
  published
    { published declarations }
    property StockID: integer read fStockID;
    property StockTitle: string read fStockTitle;
    property DefaultStockID: integer read fDefaultStockID write SetDefaultStockID;
  end;

  TfrxGoodsSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TcxButtonEdit;
    fGoodsTitle: string;
    fGoodsID: integer;
    FCanSelectFolder: Boolean;
    fGoodsIsFolder: Boolean;
    fDefaultGoodsID: integer;
    FIniKey: string;
    FIniSection: string;
    fSQLFilter: string;
    procedure SetCanSelectFolder(const Value: Boolean);
    procedure SetDefaultGoodsID(const Value: integer);
    procedure SetIniKey(const Value: string);
    procedure SetIniSection(const Value: string);
    procedure SetSQLFilter(const Value: string);
  protected
    { protected declarations }
    procedure WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TcxButtonEdit read fSelector;
    procedure LoadGoodsID(const GoodsID: integer);
  published
    { published declarations }
    property GoodsID: integer read fGoodsID write LoadGoodsID;
    property GoodsTitle: string read fGoodsTitle;
    property GoodsIsFolder: Boolean read fGoodsIsFolder;
    property CanSelectFolder: Boolean read FCanSelectFolder write SetCanSelectFolder;
    property DefaultGoodsID: integer read fDefaultGoodsID write SetDefaultGoodsID;
    property IniKey: string read FIniKey write SetIniKey;
    property IniSection: string read FIniSection write SetIniSection;
    property SQLFilter: string read fSQLFilter write SetSQLFilter;

  end;

  TfrxItemsSelectorType = (istListOfGoods, istListGoodsFolders, istListOfCustomers, istListOfCustomersFolders,
    istListOfVendors, istListOfStocks, istSYSS, istWebGoodsType, istGoodsFilterTypes);

  TfrxItemsSelector = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TfrxSelectorPanel;
    fBtnAdd: TSpeedButton;
    fBtnDelete: TSpeedButton;
    fBtnClear: TSpeedButton;
    cxGridSelection: TcxGrid;
    xGridSelectionLevel: TcxGridLevel;
    fSelectorType: TfrxItemsSelectorType;
    cxGridTableView: TcxGridTableView;
    cxGridCol_ID: TcxGridColumn;
    cxGridCol_TITLE: TcxGridColumn;
    fSecureFirms: Boolean;
    procedure SetSelectorType(const Value: TfrxItemsSelectorType);
    function GetListOfID: string;
    procedure SetSecureFirms(const Value: Boolean);
    function GetListOfItems: string;
  protected
    { protected declarations }
    fLastSelectedID: integer;
    fLastSelectedFilterID: Integer;
    procedure InitSelectorControl(AOwner: TComponent);
    procedure cxGridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableViewSelectionChanged(Sender: TcxCustomGridTableView);
    procedure SelectionChanged;
    procedure sbAddClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure sbDeleteClick(Sender: TObject);
    procedure AddListOfGoods;
    function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    procedure WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added: Boolean; var
      Count: integer);
    procedure AddListOfGoodsFolders;
    procedure AddListOfCustomers;
    procedure AddListOfCustomersFolders;
    procedure AddListOfVendors;
    procedure AddListOfStocks;
    procedure AddListOfSYSS;
    procedure AddListOfWebGoodsTypes;
    procedure AddListOfGoodsFilterTypes;
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TfrxSelectorPanel read fSelector;
    procedure WhenSaveToRepository(const Storage: TAppUserInternalDataStorage);
    procedure WhenReadFromRepository(const Storage: TAppUserInternalDataStorage);
    procedure SetListOfID(const Values: string);
  published
    { published declarations }
    property SelectorType: TfrxItemsSelectorType read fSelectorType write SetSelectorType;
    property ListOfID: string read GetListOfID;
    property SecureFirms: Boolean read fSecureFirms write SetSecureFirms;
    property ListOfIDTitles: string read GetListOfItems;
  end;

  TfrxDataStorage = class(TfrxDialogControl)
  private
    { private declarations }
    fSelector: TPanel;
  protected
    { protected declarations }
    procedure InitSelectorControl(AOwner: TComponent);
    procedure WhenLoadClick(Sender: TObject);
    procedure WhenSaveClick(Sender: TObject);
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: string; override;
    property Selector: TPanel read fSelector;
  published
    { published declarations }
  end;

  TfrxFunctions = class(TfsRTTIModule)
  public
    constructor Create(AScript: TfsScript); override;
  end;

implementation

uses
  Dialogs, Graphics, frmCustomersDlg, frmStocksBrowser, frmGoods, IBC, DataModuleDB, DataModuleAdditions,
  SysUtils, SWNUtils, frmSyssEditorWindow, frmGoodsTypeDialog, frmCustomerContractsDialog, frmWebFiltersDialog, System.IniFiles;

{$R ReportControls.res}
{ TfrxCustomerSelector }

constructor TfrxCustomerSelector.Create(AOwner: TComponent);
var
  bmp: TBitmap;
begin
  inherited;

  fSelector := TcxButtonEdit.Create(AOwner);
  fSelector.Properties.OnButtonClick := WhenButtonClick;

  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, 'TFRXGLYPH_FOLDER');
    fSelector.Properties.Buttons[0].Glyph.Assign(bmp);
    fSelector.Properties.Buttons[0].Kind := bkGlyph;
  finally
    bmp.Free;
  end;

  InitControl(fSelector);

  FCustomersFilter := [];
  FExcludeFilter := [];

  Width := 200;
  Height := 24;

  LoadCustomer(GetLastSelectedCustomer);
//  fCustomerID := -1;
//  fCustomerTitle := '';
end;

class function TfrxCustomerSelector.GetDescription: string;
begin
  Result := 'Alege client';
end;

function TfrxCustomerSelector.GetLastSelectedCustomer: Integer;
begin
  AppUserConfigStorage.OpenSection('Reports');
  try
    // read column visibility and width
    Result := AppUserConfigStorage.IntValues.GetValue('LastSelectedCustomerID');

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrxCustomerSelector.LoadCustomer(const CustomerID: integer);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(Self);
  try
    query.Connection := dmDB.IBCConnection;
    query.SQL.Text := 'SELECT CUSTOMERID, DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=:id';
    query.ParamByName('id').AsInteger := CustomerID;
    query.ExecSQL;
    if not query.Eof then
    begin
      fCustomerID := query.Fields[0].AsInteger;
      fCustomerTitle := query.Fields[1].AsString;
      fSelector.Text := fCustomerTitle;
    end;
  finally
    query.Free;
  end;
end;

procedure TfrxCustomerSelector.SetCustomersFilter(const Value: TCustomerFiltersSet);
begin
  FCustomersFilter := Value;
end;

procedure TfrxCustomerSelector.SetDefaultCustomer(const Value: integer);
begin
  fDefaultCustomer := Value;
  LoadCustomer(Value);
end;

procedure TfrxCustomerSelector.SetExcludeFilter(const Value: TCustomerFiltersSet);
begin
  FExcludeFilter := Value;
end;

procedure TfrxCustomerSelector.SetLastSelectedCustomer(const Value: Integer);
begin
  AppUserConfigStorage.OpenSection('Reports');
  try
     // read column visibility and width
    AppUserConfigStorage.IntValues.SetValue('LastSelectedCustomerID', Value);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrxCustomerSelector.WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := FCustomersFilter;
    dialog.ExcludeFilter := FExcludeFilter;
    if dialog.SelectCustomer(fCustomerID) then
    begin
      fCustomerID := dialog.CustomerID;
      fCustomerTitle := dialog.CustomerTitle;
      fSelector.Text := fCustomerTitle;
      SetLastSelectedCustomer(dialog.CustomerID);
    end;
  finally
    dialog.Free;
  end;
end;

{ TFunctions }

constructor TfrxFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddClass(TfrxCustomerSelector, 'TfrxDialogControl');
    AddClass(TfrxStockSelector, 'TfrxDialogControl');
    AddClass(TfrxGoodsSelector, 'TfrxDialogControl');
    AddClass(TfrxItemsSelector, 'TfrxDialogControl');
    AddClass(TfrxDataStorage, 'TfrxDialogControl');
  end;
end;

{ TfrxStockSelector }

constructor TfrxStockSelector.Create(AOwner: TComponent);
var
  bmp: TBitmap;
begin
  inherited;

  fSelector := TcxButtonEdit.Create(AOwner);
//  fSelector.Properties.ViewStyle := vsHideCursor;
  fSelector.Properties.OnButtonClick := WhenButtonClick;
  InitControl(fSelector);

  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, 'TFRXGLYPH_FOLDER');
    fSelector.Properties.Buttons[0].Glyph.Assign(bmp);
    fSelector.Properties.Buttons[0].Kind := bkGlyph;
  finally
    bmp.Free;
  end;

  Width := 200;
  Height := 24;

  fStockID := -1;
  fStockTitle := '';
end;

class function TfrxStockSelector.GetDescription: string;
begin
  Result := 'Alege depozit';
end;

procedure TfrxStockSelector.LoadStock(const StockID: integer);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(Self);
  try
    query.Connection := dmDB.IBCConnection;
    query.SQL.Text := 'SELECT STOCKID, TITLE FROM TS_STOCKS WHERE STOCKID=:id';
    query.ParamByName('id').AsInteger := StockID;
    query.ExecSQL;
    if not query.Eof then
    begin
      fStockID := query.Fields[0].AsInteger;
      fStockTitle := query.Fields[1].AsString;
      fSelector.Text := fStockTitle;
    end;
  finally
    query.Free;
  end;
end;

procedure TfrxStockSelector.SetDefaultStockID(const Value: integer);
begin
  fDefaultStockID := Value;
  LoadStock(Value);
end;

procedure TfrxStockSelector.WhenButtonClick(Sender: TObject;  AButtonIndex: Integer);
var
  dialog: TfrmStocksBrowserDlg;
begin
  dialog := TfrmStocksBrowserDlg.Create(Self);
  try
    if dialog.SelectStock(fStockID) then
    begin
      fStockID := dialog.StockID;
      fStockTitle := dialog.StockTitle;
      fSelector.Text := fStockTitle;
    end;
  finally
    dialog.Free;
  end;
end;

{ TfrxGoodsSelector }

constructor TfrxGoodsSelector.Create(AOwner: TComponent);
var
  bmp: TBitmap;
  Ini: TIniFile;
begin
  inherited;

  fSelector := TcxButtonEdit.Create(AOwner);
  fSelector.Properties.OnButtonClick := WhenButtonClick;
  InitControl(fSelector);

  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, 'TFRXGLYPH_FOLDER');
    fSelector.Properties.Buttons[0].Glyph.Assign(bmp);
    fSelector.Properties.Buttons[0].Kind := bkGlyph;
  finally
    bmp.Free;
  end;

  Width := 200;
  Height := 24;

//  if ((IniSection='') or (IniKey='')) then
//  begin
//  fGoodsID := -1;
//  fGoodsTitle := '';
//  end
//  else
  begin
    Ini := TIniFile.Create('c:\windows\temp\repdefval.ini');
    GoodsID := Ini.ReadInteger(IniSection, 'goodsid', -1);
    fGoodsTitle := Ini.ReadString(IniSection, 'goods_name', '');
  end;

  FCanSelectFolder := False;
  fGoodsIsFolder := False;
end;

class function TfrxGoodsSelector.GetDescription: string;
begin
  Result := 'Alege produs';
end;

procedure TfrxGoodsSelector.LoadGoodsID(const GoodsID: integer);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(Self);
  try
    query.Connection := dmDB.IBCConnection;
    query.SQL.Text := 'SELECT GOODSID, TITLE, FLG_FOLDER FROM TS_GOODS WHERE FLG_FOLDER=0 AND GOODSID=:id';
    query.ParamByName('id').AsInteger := GoodsID;
    query.ExecSQL;
    if not query.Eof then
    begin
      fGoodsID := query.Fields[0].AsInteger;
      fGoodsTitle := query.Fields[1].AsString;
      fGoodsIsFolder := (query.Fields[2].AsInteger=1);
      fSelector.Text := fGoodsTitle;
    end;
  finally
    query.Free;
  end;
end;

procedure TfrxGoodsSelector.SetCanSelectFolder(const Value: Boolean);
begin
  FCanSelectFolder := Value;
end;

procedure TfrxGoodsSelector.SetDefaultGoodsID(const Value: integer);
begin
  fDefaultGoodsID := Value;
  LoadGoodsID(Value);
end;

procedure TfrxGoodsSelector.SetIniKey(const Value: string);
begin
  FIniKey := Value;
end;

procedure TfrxGoodsSelector.SetIniSection(const Value: string);
begin
  FIniSection := Value;
end;

procedure TfrxGoodsSelector.SetSQLFilter(const Value: string);
begin
  fSQLFilter := Value;
end;

procedure TfrxGoodsSelector.WhenButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    fSQLFilter := '';
    if dialog.SelectGoods(fGoodsID, FCanSelectFolder) then
    begin
      fGoodsID := dialog.GoodsID;
      fGoodsTitle := dialog.GoodsTitle;
      fGoodsIsFolder := dialog.GoodsIsFolder;
      fSelector.Text := fGoodsTitle;
      fSQLFilter := '(GOODSID=' + IntToStr(dialog.GoodsID) + ')';
    end;
  finally
    dialog.Free;
  end;
end;

{ TfrxItemsSelector }

procedure TfrxItemsSelector.AddListOfCustomers;
var
  dialog: TfrmCustomersDlg;
  N: integer;
  root: integer;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    root := 0;
    if fSecureFirms then
    begin
      dialog.CustomFilter := [cfFirms, cfSecuredFirms];
      root := 2;
    end;

    if dialog.SelectCustomer(fLastSelectedID, False, root, 'Adauga client') then
    begin
      fLastSelectedID := dialog.CustomerID;
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := fLastSelectedID;
        cxGridTableView.DataController.Values[N, 1] := dialog.CustomerTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfCustomersFolders;
var
  dialog: TfrmCustomersDlg;
  N: integer;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fLastSelectedID, true, 0, 'Adauga mapa clienti') then
    begin
      if dialog.CustomerIsFolder then
      begin
        fLastSelectedID := dialog.CustomerID;
        cxGridTableView.BeginUpdate;
        try
          N := cxGridTableView.DataController.AppendRecord;
          cxGridTableView.DataController.Values[N, 0] := fLastSelectedID;
          cxGridTableView.DataController.Values[N, 1] := dialog.CustomerTitle;
        finally
          cxGridTableView.EndUpdate;
          SelectionChanged;
        end;
      end
      else
        ShowErrorDialog('Eroare', 'Alegeti doar mapa cu clienti!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfGoods;
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.BurstMode := true;
    // dialog.OnCheckIfGoodsExists:=WhenCheckIfGoodsExists;
    dialog.OnBurstAddGoods := WhenBurstAddGoods;
    if dialog.SelectGoods(fLastSelectedID, False, 0, 'Adauga produs') then
    begin
      fLastSelectedID := dialog.GoodsID;
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := fLastSelectedID;
        cxGridTableView.DataController.Values[N, 1] := dialog.GoodsTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfGoodsFilterTypes;
var
  dialog: TfrmWebFiltersDlg;
//  defaultFilterID: Integer;
  N: integer;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmdb.IBCConnection);
  try
//    defaultFilterID := -1;
//    if Not dialog.IBCQueryFilters.FieldByName('FILTERID').IsNull then
//      defaultFilterID := fMasterDataSet.FieldByName('FILTERID').AsInteger;
    if dialog.SelectFilterParam(fLastSelectedFilterID) then
    begin
      fLastSelectedFilterID := dialog.FilterID;
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := fLastSelectedFilterID;
        cxGridTableView.DataController.Values[N, 1] := Format('%s / %s', [dialog.FilterNameRom, dialog.FilterNameRus]);
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;

//      beFILTERNAME.Text := Format('%s / %s', [dialog.FilterNameRom, dialog.FilterNameRus]);

    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfGoodsFolders;
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.OnCheckIfGoodsExists := WhenCheckIfGoodsExists;
    if dialog.SelectGoods(fLastSelectedID, true, 0, 'Adauga mapa produs') then
    begin
      if (dialog.GoodsIsFolder) then
      begin
        fLastSelectedID := dialog.GoodsID;
        cxGridTableView.BeginUpdate;
        try
          N := cxGridTableView.DataController.AppendRecord;
          cxGridTableView.DataController.Values[N, 0] := fLastSelectedID;
          cxGridTableView.DataController.Values[N, 1] := dialog.GoodsTitle;
        finally
          cxGridTableView.EndUpdate;
          SelectionChanged;
        end;
      end
      else
        ShowErrorDialog('Eroare', 'Alege mapa cu produse!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfStocks;
var
  dialog: TfrmStocksBrowserDlg;
  N: integer;
begin
  dialog := TfrmStocksBrowserDlg.Create(Self);
  try
    if dialog.SelectStock then
    begin
      fLastSelectedID := dialog.StockID;
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := fLastSelectedID;
        cxGridTableView.DataController.Values[N, 1] := dialog.StockTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfSYSS;
var
  syssEditor: TfrmSelectSyssEditorWin;
  N: integer;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    syssEditor.SelectMode := true;
    syssEditor.CanSelectFolder := true;

    if syssEditor.ShowModal = mrOk then
    begin
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := syssEditor.SYSSID;
        cxGridTableView.DataController.Values[N, 1] := syssEditor.SyssTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    syssEditor.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfVendors;
var
  syssEditor: TfrmSelectSyssEditorWin;
  N: integer;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    syssEditor.SetDefaultGroup(1);
    syssEditor.SelectMode := true;
    if syssEditor.ShowModal = mrOk then
    begin
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := syssEditor.SYSSID;
        cxGridTableView.DataController.Values[N, 1] := syssEditor.SyssTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    syssEditor.Free;
  end;
end;

procedure TfrxItemsSelector.AddListOfWebGoodsTypes;
var
  dialog: TfrmGoodsTypeDlg;
  N: integer;
begin
  dialog := TfrmGoodsTypeDlg.Create(Self);
  try
    dialog.SelectMode := true;

    if dialog.ShowModal = mrOk then
    begin
      cxGridTableView.BeginUpdate;
      try
        N := cxGridTableView.DataController.AppendRecord;
        cxGridTableView.DataController.Values[N, 0] := dialog.GoodsTypeID;
        cxGridTableView.DataController.Values[N, 1] := dialog.GoodsTypeTitle;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

constructor TfrxItemsSelector.Create(AOwner: TComponent);
begin
  inherited;
  InitSelectorControl(AOwner);
  fLastSelectedID := -1;
  fLastSelectedFilterID := -1;
  fSecureFirms := False;

  InitControl(fSelector);

  Width := 400;
  Height := 200;
end;

procedure TfrxItemsSelector.cxGridTableViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrxItemsSelector.cxGridTableViewSelectionChanged(Sender: TcxCustomGridTableView);
begin
  SelectionChanged;
end;

class function TfrxItemsSelector.GetDescription: string;
begin
  Result := 'Alege lista de produse, clienti, producatori etc.';
end;

function TfrxItemsSelector.GetListOfID: string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
  begin
    if (s <> '') then
      s := s + ',';
    s := s + IntToStr(cxGridTableView.DataController.Values[i, 0]);
  end;
  Result := s;
end;

function TfrxItemsSelector.GetListOfItems: string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
  begin
    if (s <> '') then
      s := s + #13#10;
    s := s + Format('#%d. %s', [integer(cxGridTableView.DataController.Values[i, 0]), string(cxGridTableView.DataController.Values
      [i, 1])]);
  end;
  Result := s;
end;

procedure TfrxItemsSelector.InitSelectorControl(AOwner: TComponent);
var
  panel: TPanel;
begin
  // holder
  fSelector := TfrxSelectorPanel.Create(AOwner, Self);
  fSelector.ShowCaption := False;
  fSelector.BevelOuter := bvNone;
  fSelector.Constraints.MinWidth := 340;
  fSelector.Constraints.MinHeight := 140;
  fSelector.NeedSaveData := true;
  fSelector.OnSaveToRepository := WhenSaveToRepository;
  fSelector.OnReadFromRepository := WhenReadFromRepository;

  // buttons panel
  panel := TPanel.Create(fSelector);
  panel.ShowCaption := False;
  panel.Align := alBottom;
  panel.Height := 31;
  panel.Padding.Top := 4;
  panel.BevelOuter := bvNone;
  panel.Parent := fSelector;

  // button: Add
  fBtnAdd := TSpeedButton.Create(panel);
  fBtnAdd.Align := alLeft;
  fBtnAdd.Caption := 'Adauga';
  fBtnAdd.Width := 90;
  fBtnAdd.OnClick := nil;
  fBtnAdd.Parent := panel;
  fBtnAdd.OnClick := sbAddClick;

  // button: Delete
  fBtnDelete := TSpeedButton.Create(panel);
  fBtnDelete.Align := alLeft;
  fBtnDelete.Caption := 'Sterge';
  fBtnDelete.AlignWithMargins := true;
  fBtnDelete.Margins.Left := 8;
  fBtnDelete.Margins.Top := 0;
  fBtnDelete.Margins.Bottom := 0;
  fBtnDelete.Margins.Right := 0;
  fBtnDelete.Left := 100;
  fBtnDelete.Width := 90;
  fBtnDelete.OnClick := nil;
  fBtnDelete.Parent := panel;
  fBtnDelete.Enabled := False;
  fBtnDelete.OnClick := sbDeleteClick;

  // button: Clear
  fBtnClear := TSpeedButton.Create(panel);
  fBtnClear.Align := alRight;
  fBtnClear.Caption := 'Sterge tot';
  fBtnClear.Width := 90;
  fBtnClear.OnClick := nil;
  fBtnClear.Parent := panel;
  fBtnClear.OnClick := sbClearClick;

  // Grid
  cxGridSelection := TcxGrid.Create(fSelector);
  cxGridSelection.Align := alClient;
  cxGridSelection.Parent := fSelector;

  xGridSelectionLevel := cxGridSelection.Levels.Add;

  cxGridTableView := TcxGridTableView.Create(xGridSelectionLevel);
  xGridSelectionLevel.GridView := cxGridTableView;

  // setup GridView props
  cxGridTableView.OptionsView.ColumnAutoWidth := true;
  cxGridTableView.OptionsView.GridLineColor := $00D1D1D1;
  cxGridTableView.OptionsView.GroupByBox := False;
  cxGridTableView.OptionsView.NoDataToDisplayInfoText := '<Nu sunt inregistrari>';

  cxGridTableView.OptionsSelection.CellSelect := False;
  cxGridTableView.OptionsSelection.MultiSelect := true;

  cxGridTableView.OptionsData.Deleting := False;
  cxGridTableView.OptionsData.Editing := False;
  cxGridTableView.OptionsData.Inserting := False;

  cxGridTableView.OptionsCustomize.ColumnFiltering := False;
  cxGridTableView.OptionsCustomize.ColumnGrouping := False;
  cxGridTableView.OptionsCustomize.ColumnSorting := False;

  cxGridTableView.Styles.Header := dmAdditions.cxStyle_GridHeader;

  cxGridTableView.OnFocusedRecordChanged := cxGridTableViewFocusedRecordChanged;
  cxGridTableView.OnSelectionChanged := cxGridTableViewSelectionChanged;

  // add columns

  cxGridCol_ID := cxGridTableView.CreateColumn;
  cxGridCol_ID.Caption := 'Cod';
  cxGridCol_ID.DataBinding.ValueType := 'Integer';
  cxGridCol_ID.Width := 50;
  cxGridCol_ID.Options.HorzSizing := False;
  cxGridCol_ID.HeaderAlignmentHorz := taCenter;

  cxGridCol_TITLE := cxGridTableView.CreateColumn;
  cxGridCol_TITLE.Caption := 'Denumire';
  cxGridCol_TITLE.Width := 100;

end;

procedure TfrxItemsSelector.sbAddClick(Sender: TObject);
begin
  case fSelectorType of
    istListOfGoods:
      AddListOfGoods;
    istListGoodsFolders:
      AddListOfGoodsFolders;
    istListOfCustomers:
      AddListOfCustomers;
    istListOfCustomersFolders:
      AddListOfCustomersFolders;
    istListOfVendors:
      AddListOfVendors;
    istListOfStocks:
      AddListOfStocks;
    istSYSS:
      AddListOfSYSS;
    istWebGoodsType:
      AddListOfWebGoodsTypes;
    istGoodsFilterTypes:
      AddListOfGoodsFilterTypes;

  end;
end;

procedure TfrxItemsSelector.sbClearClick(Sender: TObject);
begin
  if ShowAskDialog('Lista', 'Sterge toate inrestrarile din lista?') = mrYes then
  begin
    cxGridTableView.BeginUpdate;
    try
      cxGridTableView.Controller.SelectAll;
      cxGridTableView.DataController.DeleteSelection;
    finally
      cxGridTableView.EndUpdate;
      SelectionChanged;
    end;
  end;
end;

procedure TfrxItemsSelector.sbDeleteClick(Sender: TObject);
var
  s1, s2: string;
begin
  if (cxGridTableView.Controller.SelectedRecordCount > 0) then
  begin
    if (cxGridTableView.Controller.SelectedRecordCount > 1) then
    begin
      s1 := 'Sterge inregistrarile';
      s2 := 'Sterge inregistrarile selectate?';
    end
    else
    begin
      s1 := 'Sterge o inregistrare';
      s2 := Format('Sterge inregistrarea "%s"?', [cxGridTableView.Controller.SelectedRecords[0].Values[1]]);
    end;
    if ShowAskDialog(s1, s2) = mrYes then
    begin
      cxGridTableView.BeginUpdate;
      try
        cxGridTableView.DataController.DeleteSelection;
      finally
        cxGridTableView.EndUpdate;
        SelectionChanged;
      end;
    end;
  end;
end;

procedure TfrxItemsSelector.SelectionChanged;
var
  fAdd, fDelete, fClear: Boolean;
begin
  fAdd := true;
  fDelete := False;
  fClear := False;
  if (cxGridTableView.DataController.RecordCount > 0) then
  begin
    fClear := true;
    if (cxGridTableView.Controller.SelectedRecordCount > 0) then
    begin
      fDelete := true;
    end;
  end;

  fBtnAdd.Enabled := fAdd;
  fBtnDelete.Enabled := fDelete;
  fBtnClear.Enabled := fClear;
end;

procedure TfrxItemsSelector.SetListOfID(const Values: string);
begin

end;

procedure TfrxItemsSelector.SetSecureFirms(const Value: Boolean);
begin
  fSecureFirms := Value;
end;

procedure TfrxItemsSelector.SetSelectorType(const Value: TfrxItemsSelectorType);
begin
  fSelectorType := Value;
end;

procedure TfrxItemsSelector.WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added:
  Boolean; var Count: integer);
var
  N: integer;
begin
  if WhenCheckIfGoodsExists(GoodsID) then
    Added := False
  else
  begin
    cxGridTableView.BeginUpdate;
    try
      N := cxGridTableView.DataController.AppendRecord;
      cxGridTableView.DataController.Values[N, 0] := GoodsID;
      cxGridTableView.DataController.Values[N, 1] := GoodsTitle;
      Added := true;
      Count := 1;
    finally
      cxGridTableView.EndUpdate;
    end;
  end;
end;

function TfrxItemsSelector.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
  begin
    if cxGridTableView.DataController.Values[i, 0] = GoodsID then
    begin
      Result := true;
      break;
    end;
  end;
end;

procedure TfrxItemsSelector.WhenReadFromRepository(const Storage: TAppUserInternalDataStorage);
var
  i, N, Count, valInt: integer;
begin
  cxGridTableView.BeginUpdate;
  try
    cxGridTableView.Controller.SelectAll;
    cxGridTableView.DataController.DeleteSelection;

    Count := Storage.IntValues.GetValue('count');
    for i := 0 to Count - 1 do
    begin
      N := cxGridTableView.DataController.AppendRecord;
      valInt := Storage.IntValues.GetValue(Format('Row%d_ID', [i]));
      cxGridTableView.DataController.Values[N, 0] := valInt;
      cxGridTableView.DataController.Values[N, 1] := Storage.TextValues.GetValue(Format('Row%d_TITLE', [i]));
      fLastSelectedID := valInt;
    end;
  finally
    cxGridTableView.EndUpdate;
  end;
end;

procedure TfrxItemsSelector.WhenSaveToRepository(const Storage: TAppUserInternalDataStorage);
var
  i, valInt: integer;
  valStr: string;
begin
  // save control content to repository

  Storage.IntValues.SetValue('count', cxGridTableView.DataController.RecordCount);

  for i := 0 to cxGridTableView.DataController.RecordCount - 1 do
  begin
    valInt := cxGridTableView.DataController.Values[i, 0]; // ID
    valStr := cxGridTableView.DataController.Values[i, 1]; // Title

    Storage.IntValues.SetValue(Format('Row%d_ID', [i]), valInt);
    Storage.TextValues.SetValue(Format('Row%d_TITLE', [i]), valStr);
  end;
end;

{ TfrxDataStorage }

constructor TfrxDataStorage.Create(AOwner: TComponent);
begin
  inherited;
  InitSelectorControl(AOwner);

  InitControl(fSelector);

  Width := 170;
  Height := 58;
end;

class function TfrxDataStorage.GetDescription: string;
begin
  Result := 'Salvarea si incarcarea datelor';
end;

procedure TfrxDataStorage.InitSelectorControl(AOwner: TComponent);
var
  btn: TSpeedButton;
begin
  fSelector := TPanel.Create(AOwner);
  fSelector.AutoSize := true;
  fSelector.ShowCaption := False;
  fSelector.BevelOuter := bvNone;
  fSelector.Width := 170;
  fSelector.Height := 58;

  // button load
  btn := TSpeedButton.Create(fSelector);
  btn.Caption := 'Incarca datele...';
  btn.AlignWithMargins := true;
  btn.Margins.Left := 0;
  btn.Margins.Top := 0;
  btn.Margins.Right := 0;
  btn.Margins.Bottom := 2;
  btn.Width := 134;
  btn.Height := 27;
  btn.Align := alTop;
  btn.Parent := fSelector;
  btn.OnClick := WhenLoadClick;

  // button save
  btn := TSpeedButton.Create(fSelector);
  btn.Caption := 'Salveaza datele...';
  btn.AlignWithMargins := true;
  btn.Margins.Left := 0;
  btn.Margins.Top := 2;
  btn.Margins.Right := 0;
  btn.Margins.Bottom := 0;
  btn.Width := 134;
  btn.Height := 27;
  btn.Align := alTop;
  btn.Top := 30;
  btn.Parent := fSelector;
  btn.OnClick := WhenSaveClick;

end;

procedure TfrxDataStorage.WhenLoadClick(Sender: TObject);
var
  dialog: TOpenDialog;
  fileName: string;
  Storage: TAppUserInternalDataStorage;
  control: TfrxSelectorPanel;
  i, j, Count: integer;
  controlName: string;
begin
  fileName := '';
  dialog := TOpenDialog.Create(Self);
  try
    dialog.DefaultExt := '.report_params';
    dialog.Filter := 'Report params files|*.report_params';
    if dialog.Execute then
    begin
      fileName := dialog.fileName;
    end;
  finally
    dialog.Free;
  end;

  if fileName = '' then
    Exit;

  Storage := TAppUserInternalDataStorage.Create;
  try
    Storage.LoadFromFile(fileName);
    // controls saved
    Count := Storage.IntValues.GetValue('Count');

    for i := 0 to Count - 1 do
    begin
      controlName := Storage.TextValues.GetValue(Format('Control%d', [i]));
      if controlName <> '' then
      begin
        for j := 0 to Parent.ComponentCount - 1 do
          if Parent.Components[j] is TfrxSelectorPanel then
          begin
            control := TfrxSelectorPanel(Parent.Components[j]);
            if not control.NeedSaveData then
              Continue;

            if (control.ReportControl.Name = controlName) then
            begin
              Storage.OpenSection(controlName);
              try
                control.ReadFromRepository(Storage);
              finally
                Storage.CloseSection
              end;
            end;
          end;
      end;
    end;

  finally
    Storage.Free;
  end;
end;

procedure TfrxDataStorage.WhenSaveClick(Sender: TObject);
var
  i, Count, index: integer;
  Storage: TAppUserInternalDataStorage;
  control: TfrxSelectorPanel;
  dialog: TSaveDialog;
begin
  // count controls
  Count := 0;
  for i := 0 to Parent.ComponentCount - 1 do
    if Parent.Components[i] is TfrxSelectorPanel then
      Inc(Count);

  if Count = 0 then
  begin
    ShowErrorDialog('Eroare de scriere', 'Pe forma nu sunt elemente cu functia de salvare a datelor.');
    Exit;
  end;

  Storage := TAppUserInternalDataStorage.Create;
  try
    // save control list
    index := 0;
    for i := 0 to Parent.ComponentCount - 1 do
      if Parent.Components[i] is TfrxSelectorPanel then
      begin
        control := TfrxSelectorPanel(Parent.Components[i]);
        if not control.NeedSaveData then
          Continue;

        Storage.TextValues.SetValue(Format('Control%d', [index]), control.ReportControl.Name);
        Inc(index);
      end;
    // save count
    Storage.IntValues.SetValue('Count', index);

    // save content
    for i := 0 to Parent.ComponentCount - 1 do
      if Parent.Components[i] is TfrxSelectorPanel then
      begin
        control := TfrxSelectorPanel(Parent.Components[i]);
        if not control.NeedSaveData then
          Continue;

        Storage.OpenSection(control.ReportControl.Name);
        try
          control.SaveToRepository(Storage);
        finally
          Storage.CloseSection
        end;
      end;

    dialog := TSaveDialog.Create(Self);
    try
      dialog.DefaultExt := '.report_params';
      dialog.Filter := 'Report params files|*.report_params';
      dialog.Options := dialog.Options + [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoReadOnlyReturn];
      if dialog.Execute then
        Storage.SaveToFile(dialog.fileName);
    finally
      dialog.Free;
    end;

  finally
    Storage.Free;
  end;

end;

{ TfrxContractSelector }

constructor TfrxContractSelector.Create(AOwner: TComponent);
var
  bmp: TBitmap;
begin
  inherited;

  fSelector := TcxButtonEdit.Create(AOwner);
  fSelector.Properties.OnButtonClick := WhenButtonClick;

  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, 'TFRXGLYPH_FOLDER');
    fSelector.Properties.Buttons[0].Glyph.Assign(bmp);
    fSelector.Properties.Buttons[0].Kind := bkGlyph;
  finally
    bmp.Free;
  end;

  InitControl(fSelector);

  Width := 200;
  Height := 24;

  fCustomerID := -1;
  fContractTitle := '';
end;

class function TfrxContractSelector.GetDescription: string;
begin
  Result := 'Alege contractul';
end;

procedure TfrxContractSelector.SetContractNumber(const Value: string);
begin
  FContractNumber := Value;
end;

procedure TfrxContractSelector.SetContractTitle(const Value: string);
begin
  fContractTitle := Value;
end;

procedure TfrxContractSelector.SetCustomerID(const Value: integer);
begin
  FCustomerID := Value;
end;

procedure TfrxContractSelector.WhenButtonClick(Sender: TObject;  AButtonIndex: Integer);
var
  dialog: TfrmContractsDlg;
begin
  dialog := TfrmContractsDlg.Create(Self);
  try
    dialog.ct := CustomerID;
    if (dialog.ShowModal = mrOk) then
    begin
      fContractNumber := dialog.ContractCode;
      fContractTitle := dialog.ContractTypeTitle;

      fSelector.Text := fContractTitle + ' ' + dialog.ContractCode;
    end;
  finally
    dialog.Free;
  end;
end;

var
  bmp1, bmp2, bmp3, bmp4, bmp5, bmp6: TBitmap;

initialization

// image for component
  bmp1 := TBitmap.Create;
  bmp1.LoadFromResourceName(HInstance, 'TFRXCUSTOMERSELECTOR');
  frxObjects.RegisterObject(TfrxCustomerSelector, bmp1);

  bmp2 := TBitmap.Create;
  bmp2.LoadFromResourceName(HInstance, 'TFRXSTOCKSELECTOR');
  frxObjects.RegisterObject(TfrxStockSelector, bmp2);

  bmp3 := TBitmap.Create;
  bmp3.LoadFromResourceName(HInstance, 'TFRXGOODSSELECTOR');
  frxObjects.RegisterObject(TfrxGoodsSelector, bmp3);

  bmp4 := TBitmap.Create;
  bmp4.LoadFromResourceName(HInstance, 'TFRXITEMSSELECTOR');
  frxObjects.RegisterObject(TfrxItemsSelector, bmp4);

  bmp5 := TBitmap.Create;
  bmp5.LoadFromResourceName(HInstance, 'TFRXDATASTORAGE');
  frxObjects.RegisterObject(TfrxDataStorage, bmp5);

  bmp6 := TBitmap.Create;
  bmp6.LoadFromResourceName(HInstance, 'TFRXITEMSSELECTOR');
  frxObjects.RegisterObject(TfrxContractSelector, bmp6);

  fsRTTIModules.Add(TfrxFunctions);

finalization
  frxObjects.Unregister(TfrxDataStorage);
  frxObjects.Unregister(TfrxItemsSelector);
  frxObjects.Unregister(TfrxGoodsSelector);
  frxObjects.Unregister(TfrxStockSelector);
  frxObjects.Unregister(TfrxCustomerSelector);
  bmp5.Free;
  bmp4.Free;
  bmp3.Free;
  bmp2.Free;
  bmp1.Free;

end.


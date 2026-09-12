unit frmWebFiltersDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  DialogTitle, dxBar, ExtCtrls, cxStyles, DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, StdCtrls, DBAccess, IBC, frmGoodsFilterParamMergeDialog, cxButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox,
  Vcl.Menus, MemDS, cxClasses, cxGridTableView, cxGridCustomView, dxBarBuiltInMenu, cxPC, cxCheckBox,
  cxContainer, cxLabel, cxDBLabel, Vcl.Grids, Vcl.DBGrids, System.Generics.Collections,
  frmChangeFilterParentUnit, DataModuleDB, SWNSecurityFlags, frmContentGoodsEditorDialog, cxSplitter, dxUIAClasses;

type
  TfrmWebFiltersDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    pnParams: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    pnFilters: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    cxGridFilter: TcxGrid;
    cxGridFilterTable: TcxGridDBTableView;
    cxGridFilterLevel: TcxGridLevel;
    pnClient: TPanel;
    bbFilterNew: TdxBarButton;
    bbFilterModify: TdxBarButton;
    cxGridFilte_FILTERID: TcxGridDBColumn;
    cxGridFilter_FILTERNAME: TcxGridDBColumn;
    IBCQueryFilters: TIBCQuery;
    IBCDataSourceFilters: TIBCDataSource;
    IBCQueryParams: TIBCQuery;
    IBCDataSourceParams: TIBCDataSource;
    bbParamNew: TdxBarButton;
    bbParamModify: TdxBarButton;
    bbParamDelete: TdxBarButton;
    bbFilterDelete: TdxBarButton;
    bbValueOrder: TdxBarButton;
    cxGridFilter_FLG_FOLDER: TcxGridDBColumn;
    cxGridFilter_FILTERNAME_RUS: TcxGridDBColumn;
    bbNavHome: TdxBarButton;
    bbNavBack: TdxBarButton;
    bbNavForward: TdxBarButton;
    bbFolderNew: TdxBarButton;
    bbSortFilters: TdxBarButton;
    bbChangeParent: TdxBarButton;
    cxGridFilter_ORDERNO: TcxGridDBColumn;
    bbCloneValues: TdxBarButton;
    IBCTrUpdate: TIBCTransaction;
    bbTools: TdxBarSubItem;
    bbReadySet_YesNo: TdxBarButton;
    dxBarButton1: TdxBarButton;
    bbMergeFilterValues: TdxBarButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    bbGoodsList: TdxBarButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGridParams: TcxGrid;
    cxGridParamsTable: TcxGridDBTableView;
    cxGridParams_IMAGE: TcxGridDBColumn;
    cxGridParams_FILTERPARAMID: TcxGridDBColumn;
    cxGridParams_PARAM_VALUE: TcxGridDBColumn;
    cxGridParams_PARAM_VALUE_RUS: TcxGridDBColumn;
    cxGridParams_ORDERNO: TcxGridDBColumn;
    cxGridParams_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridParamsLevel: TcxGridLevel;
    IBCQueryGoodsByFilter: TIBCQuery;
    IBCDataSourceGoodsByFilter: TIBCDataSource;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbGoodsListByFiltersParam: TdxBarButton;
    bbChangeFilterParent: TdxBarButton;
    cxGridFilter_FLG_ORDINARY_FILTER: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1_GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1_WEBGoodsName: TcxGridDBColumn;
    cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    bbMergeFilters: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    procedure cxGridFilterTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridParamsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure bbFilterDeleteClick(Sender: TObject);
    procedure bbParamNewClick(Sender: TObject);
    procedure bbParamModifyClick(Sender: TObject);
    procedure bbParamDeleteClick(Sender: TObject);
    procedure bbFilterModifyClick(Sender: TObject);
    procedure bbFilterNewClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridParamsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbValueOrderClick(Sender: TObject);
    procedure cxGridFilterTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbNavForwardClick(Sender: TObject);
    procedure bbNavBackClick(Sender: TObject);
    procedure bbNavHomeClick(Sender: TObject);
    procedure bbChangeParentClick(Sender: TObject);
    procedure bbSortFiltersClick(Sender: TObject);
    procedure bbFolderNewClick(Sender: TObject);
    procedure bbCloneValuesClick(Sender: TObject);
    procedure bbReadySet_YesNoClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxGridFilterTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbMergeFilterValuesClick(Sender: TObject);
    procedure bbGoodsListClick(Sender: TObject);
    procedure bbGoodsListByFiltersParamClick(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbChangeFilterParentClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bbMergeFiltersClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
  private        { Private declarations }
    FSelectMode: Boolean;
    fFilterID: Integer;
    fFilterParamID: Integer;
    fDefaultFilterID: Integer;
    fDefaultParamID: Integer;
    fFixedFilter: Boolean;
    fFilterParamValueRom: string;
    fFilterParamValueRus: string;
    fFilterNameRom: string;
    fFilterNameRus: string;
    fCurrentParentID: Integer;
    fRootParentID: Integer;
    fInSearch: Boolean;
    fMergeDialog: TfrmGoodsFilterParamMergeDlg;
    procedure WhenFilterSelectionChanged;
    procedure WhenParamSelectionChanged;
    procedure SetSelectMode(const Value: Boolean);
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToHome(const RootID: Integer);
    procedure NavigateToFilterID(const FilterID: Integer);
    procedure NavigateBySearch(const SearchCondition: string);
    procedure EnableCondition(const ConditionIndex: Integer; const CustomCondition: string = '');

        // filters
    procedure ShowCreateNewFolderDialog;
    procedure ShowCreateNewFilterDialog;
    procedure ShowModifyGoodsPropertiesDialog;
    procedure DeleteCurrentFilter;

        // params
    procedure ShowCreateNewParamDialog(const DefaultRom: string = ''; const DefaultRus: string = '';
      const DefaultOrderNo: Integer = -1);
    procedure ShowModifyParamDialog;
    procedure DeleteCurrentParam;
    procedure ShowValuesSortDialog;
    procedure ShowChangeParentDialog;
    procedure ShowSortFiltersDialog;
    procedure DoCloneValues;
    procedure CreateReadySet_YesNo;
    procedure MergeFilterParams;
    procedure GetFilterPath;

  protected
    dialog: TfrmChangeFilterParentDialog;
    procedure FilterParamProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);
    procedure ChangeFilterParentProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);

        { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public        { Public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;
    property FilterID: Integer read fFilterID;
    property FilterParamID: Integer read fFilterParamID;
    property FilterNameRom: string read fFilterNameRom;
    property FilterNameRus: string read fFilterNameRus;
    property FilterParamValueRom: string read fFilterParamValueRom;
    property FilterParamValueRus: string read fFilterParamValueRus;
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    function SelectFilterParam(const DefaultFilterID: Integer = -1; const DefaultParamID: Integer =
      -1; const FixedFilter: Boolean = False): Boolean;
  end;

implementation

uses
  DataModuleAdditions, frmGoodsFilterEditorDialog, SWNUtils, SWNDBErrors,
  frmGoodsFilterParamEditorDialog, frmChangeOrderNoDialog, frmChangeParentFolderDialog,
  SWNSearchUnit, frmWebGoodsInFilterUnit, SWNSecurity, frmGoods, frmMergeFiltersUnit, System.Math;

{$R *.dfm}
{ TfrmWebFiltersDlg }

procedure TfrmWebFiltersDlg.bbCloneValuesClick(Sender: TObject);
begin
  DoCloneValues;
end;

procedure TfrmWebFiltersDlg.bbFilterDeleteClick(Sender: TObject);
begin
  DeleteCurrentFilter;
end;

procedure TfrmWebFiltersDlg.bbFilterModifyClick(Sender: TObject);
begin
  ShowModifyGoodsPropertiesDialog;
end;

procedure TfrmWebFiltersDlg.bbFilterNewClick(Sender: TObject);
begin
  ShowCreateNewFilterDialog;
end;

procedure TfrmWebFiltersDlg.bbParamDeleteClick(Sender: TObject);
begin
  DeleteCurrentParam;
end;

procedure TfrmWebFiltersDlg.bbParamModifyClick(Sender: TObject);
begin
  ShowModifyParamDialog;
end;

procedure TfrmWebFiltersDlg.bbParamNewClick(Sender: TObject);
begin
  ShowCreateNewParamDialog;
end;

procedure TfrmWebFiltersDlg.bbReadySet_YesNoClick(Sender: TObject);
begin
  if ShowAskDialog('Set predefinit', 'Creati setul predefinit de valori "Este"/"Nu este"?') <> mrYes then
    Exit;
  CreateReadySet_YesNo;
end;

procedure TfrmWebFiltersDlg.bbValueOrderClick(Sender: TObject);
begin
  ShowValuesSortDialog;
end;

procedure TfrmWebFiltersDlg.btnOkClick(Sender: TObject);
begin
  if cxGridParamsTable.DataController.RecNo > 0 then
  begin
    fFilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
    fFilterNameRom := IBCQueryFilters.FieldByName('FILTERNAME').AsString;
    fFilterNameRus := IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString;
    fFilterParamID := IBCQueryParams.FieldByName('FILTERPARAMID').AsInteger;
    fFilterParamValueRom := IBCQueryParams.FieldByName('PARAM_VALUE').AsString;
    fFilterParamValueRus := IBCQueryParams.FieldByName('PARAM_VALUE_RUS').AsString;
    ModalResult := mrOk;

  end;
end;

constructor TfrmWebFiltersDlg.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
  inherited;
  fRootParentID := 0;
  fCurrentParentID := 0;
end;

procedure TfrmWebFiltersDlg.CreateReadySet_YesNo;
begin
  IBCQueryParams.DisableControls;
  try
    IBCQueryParams.UpdateTransaction.StartTransaction;
    try
            // Exista
      IBCQueryParams.Append;
      IBCQueryParams.FieldByName('FILTERID').AsInteger := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
      IBCQueryParams.FieldByName('PARAM_VALUE').AsString := 'este';
      IBCQueryParams.FieldByName('PARAM_VALUE_RUS').AsString := 'da';
      IBCQueryParams.Post;
            // Nu
      IBCQueryParams.Append;
      IBCQueryParams.FieldByName('FILTERID').AsInteger := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
      IBCQueryParams.FieldByName('PARAM_VALUE').AsString := 'nu este';
      IBCQueryParams.FieldByName('PARAM_VALUE_RUS').AsString := 'nu';
      IBCQueryParams.Post;

      IBCQueryParams.UpdateTransaction.Commit;

    except
      on E: Exception do
      begin
        if IBCQueryParams.State in dsEditModes then
          IBCQueryParams.Cancel;
        IBCQueryParams.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    IBCQueryParams.EnableControls;
  end;
end;

procedure TfrmWebFiltersDlg.cxGridFilterTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
  AHandled: Boolean);
begin
  if ACellViewInfo.RecordViewInfo.GridRecord.Values[cxGridFilter_FLG_FOLDER.Index] = 1 then
  begin
    NavigateForward;
  end
  else if bbFilterModify.Enabled then
  begin
    bbFilterModifyClick(bbFilterModify);
    AHandled := True;
  end;
end;

procedure TfrmWebFiltersDlg.cxGridFilterTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WhenFilterSelectionChanged;
end;

procedure TfrmWebFiltersDlg.cxGridFilterTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  FilterID: Integer;
begin
  if not VarIsNull(ARecord.Values[cxGridFilter_FLG_FOLDER.Index]) then
  begin
    FilterID := ARecord.Values[cxGridFilte_FILTERID.Index];
        // Auto generated folder
    if FilterID = 1 then
      AStyle := dmAdditions.cxStyle_FilterGroupAutoG
    else if FilterID = 20 then
      AStyle := dmAdditions.cxStyle_FilterGroupDelimiters
    else if ARecord.Values[cxGridFilter_FLG_FOLDER.Index] = 1 then
      AStyle := dmAdditions.cxStyle_Bold;
  end;
end;

procedure TfrmWebFiltersDlg.cxGridParamsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
  AHandled: Boolean);
begin
  if FSelectMode then
  begin
    btnOkClick(btnOk);
    AHandled := True;
  end
  else if bbParamModify.Enabled then
  begin
    ShowModifyParamDialog;
    AHandled := True;
  end;
end;

procedure TfrmWebFiltersDlg.cxGridParamsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WhenParamSelectionChanged;
end;

procedure TfrmWebFiltersDlg.DeleteCurrentFilter;
var
  S: string;
begin
  S := Format('Stergeti filtrul "%s"?', [IBCQueryFilters.FieldByName('FILTERNAME').AsString]);
  if ShowAskDialog('Stergere', S,
    'Atentie! Acest element de filtru va fi sters din toate produsele unde a fost setat.') = mrYes then
  begin
    IBCQueryFilters.UpdateTransaction.StartTransaction;
    try
      IBCQueryFilters.Delete;
      IBCQueryFilters.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryFilters.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebFiltersDlg.DeleteCurrentParam;
var
  S: string;
begin
  S := Format('Stergeti valoarea "%s"?', [IBCQueryParams.FieldByName('PARAM_VALUE').AsString]);
  if ShowAskDialog('Sterge', S, 'Atentie! Valoarea filtrului va fi sters din toate produsele.') =
    mrYes then
  begin
    IBCQueryParams.UpdateTransaction.StartTransaction;
    try
      IBCQueryParams.Delete;
      IBCQueryParams.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryParams.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebFiltersDlg.DoCloneValues;
begin
  ShowCreateNewParamDialog(IBCQueryParams.FieldByName('PARAM_VALUE').AsString, IBCQueryParams.FieldByName
    ('PARAM_VALUE_RUS').AsString, IBCQueryParams.FieldByName('ORDERNO').AsInteger);
end;

procedure TfrmWebFiltersDlg.dxBarButton1Click(Sender: TObject);
var
  dialog: TSWNSearchDialog;
  i: Integer;
  SC: TSearchCriteria;
  SearchInWhere: string;
begin
  SearchInWhere := '';
  dialog := TSWNSearchDialog.Create(Self);
  try
    dialog.AdvancedSearchOptions := False;
    if dialog.GetSearchCritera(stWebCatalog) then
    begin
      for i := 0 to dialog.SearchCriteriasCount - 1 do
      begin
        SC := dialog.SearchCriterias[i];
        case SC.SearchField of
          sfID:
            AddConditionToWhere(SearchInWhere, 'FF.FILTERID=' + SC.SearchText);
          sfName:
            AddConditionToWhere(SearchInWhere, '(FF.FILTERNAME_RUS CONTAINING ''' + SC.SearchText +
              '''' + ' OR FF.FILTERNAME CONTAINING ''' + SC.SearchText + ''')');
          sfIDCustom:
            AddConditionToWhere(SearchInWhere,
              'EXISTS(SELECT 1 FROM TS_FILTER_PARAMS WHERE TS_FILTER_PARAMS.FILTERID=FF.FILTERID AND (PARAM_VALUE CONTAINING ''' +
              SC.SearchText + ''' OR PARAM_VALUE_RUS CONTAINING ''' + SC.SearchText + '''))');
        end;
      end;
    end;
  finally
    dialog.Free;
  end;

  if SearchInWhere <> '' then
    NavigateBySearch(SearchInWhere);
end;

procedure TfrmWebFiltersDlg.dxBarButton2Click(Sender: TObject);
var
  s: string;
begin
  inherited;
  if InputQuery('Proprietati produse', 'Valoarea', S) then
  begin
    IBCQueryParams.DisableControls;
    try
      IBCQueryParams.First;
      while not IBCQueryParams.Eof do
      begin
        IBCQueryParams.Edit;
        IBCQueryParams.FieldByName('PARAM_VALUE').AsString := trim(StringReplace(IBCQueryParams.FieldByName('PARAM_VALUE').AsString, s, '',[]));
        IBCQueryParams.Post;

        IBCQueryParams.Next;
      end;
    finally
      ibcqueryparams.EnableControls;
    end;
    if ibcqueryparams.UpdateTransaction.Active then
    ibcqueryparams.UpdateTransaction.Commit;
  end;
end;

procedure TfrmWebFiltersDlg.dxBarButton3Click(Sender: TObject);
var paramValue: double;
begin
    IBCQueryParams.DisableControls;
    try
      IBCQueryParams.First;
      while not IBCQueryParams.Eof do
      begin
        paramValue := StrToFloatDef(IBCQueryParams.FieldByName('PARAM_VALUE').AsString, -1);
        if (paramValue > -1) then
        begin
          IBCQueryParams.Edit;
          IBCQueryParams.FieldByName('PARAM_VALUE').AsString := FloatToStr(Ceil(paramValue));
          IBCQueryParams.Post;
        end;

        IBCQueryParams.Next;
      end;
    finally
      ibcqueryparams.EnableControls;
    end;
    if ibcqueryparams.UpdateTransaction.Active then
    ibcqueryparams.UpdateTransaction.Commit;

end;

procedure TfrmWebFiltersDlg.bbMergeFiltersClick(Sender: TObject);
var
  dialog: TfrmMergeFiltersDlg;
begin
  dialog := TfrmMergeFiltersDlg.Create(self, dmdb.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.bbMergeFilterValuesClick(Sender: TObject);
begin
  MergeFilterParams;
  IBCQueryParams.Refresh;
end;

procedure TfrmWebFiltersDlg.bbChangeFilterParentClick(Sender: TObject);
// var
// ARecordIndex: Integer;
// I: Integer;
begin
  inherited;
  frmChangeFilterParentDialog := TfrmChangeFilterParentDialog.Create(Self);
    // frmChangeFilterParentDialog.FilterParamList := TObjectList<TFilterParamsList>.Create();
  try
    cxGridParamsTable.DataController.ForEachRow(True, ChangeFilterParentProcessing);
    frmChangeFilterParentDialog.FFilterIDValue := IBCQueryParams.FieldByName('FILTERID').AsInteger;

    if frmChangeFilterParentDialog.ShowModal = mrOk then
      IBCQueryParams.Refresh;

  finally
    begin
            // frmChangeFilterParentDialog.FilterParamList.Free;
      frmChangeFilterParentDialog.Free;
    end;
  end;
end;

procedure TfrmWebFiltersDlg.bbFolderNewClick(Sender: TObject);
begin
  ShowCreateNewFolderDialog;
end;

procedure TfrmWebFiltersDlg.bbGoodsListByFiltersParamClick(Sender: TObject);
begin
  if bbGoodsListByFiltersParam.Down then
  begin
    IBCQueryGoodsByFilter.Close;
    IBCQueryGoodsByFilter.ParamByName('Filterparamid').AsInteger := IBCQueryParams.FieldByName('FILTERPARAMID').AsInteger;
    IBCQueryGoodsByFilter.Open;
  end
  else
    IBCQueryGoodsByFilter.Close;

//    cxPageControl1.ActivePage := tsGoodsList;
end;

procedure TfrmWebFiltersDlg.bbGoodsListClick(Sender: TObject);
var
  dialog: TfrmGoodsInFilterDialog;
begin
  dialog := TfrmGoodsInFilterDialog.Create(Self);
  try
    dialog.FilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.bbSortFiltersClick(Sender: TObject);
begin
  ShowSortFiltersDialog;
end;

procedure TfrmWebFiltersDlg.bbChangeParentClick(Sender: TObject);
begin
  ShowChangeParentDialog;
end;

procedure TfrmWebFiltersDlg.bbNavHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
end;

procedure TfrmWebFiltersDlg.bbNavBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmWebFiltersDlg.bbNavForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
var
  i: Integer;
  col: TcxGridDBColumn;
begin
  GoodsID := -1;
  Result := False;

  for i := 0 to Grid.ColumnCount - 1 do
  begin
    col := Grid.Columns[i];
    if (col.DataBinding.FieldName = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex,
      col.Index]) then
    begin
      GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
      Result := True;
      Break;
    end;
  end;
end;

procedure ShowGoodsBrowser(const GoodsID: Integer);
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(nil);
  try
    dialog.GoodsID := GoodsID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
var
  GoodsID: Integer;
  dialog: TfrmContentGoodsEditorDlg;
begin
  if Key = VK_F2 then
  begin
    dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryGoodsByFilter, IBCDataSourceGoodsByFilter);
    try
      dialog.ActiveTabsheetIndex := 2;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;

  if (Key = 84) and (Shift = [ssCtrl, ssShift]) then
  begin
    if CheckGridForGoodsIDValue(cxGrid1DBTableView1, GoodsID) then
      ShowGoodsBrowser(GoodsID);
  end

end;

procedure TfrmWebFiltersDlg.EnableCondition(const ConditionIndex: Integer; const CustomCondition:
  string);
begin
  IBCQueryFilters.Close;
  case ConditionIndex of // forward
    0:
      IBCQueryFilters.FilterSQL := 'PARENTID=:ParentID';
        // backward
    1:
      IBCQueryFilters.FilterSQL :=
        'PARENTID=(SELECT PARENTID FROM TS_FILTERS WHERE FILTERID=:ParentID)';
        // search
    2:
      IBCQueryFilters.FilterSQL := CustomCondition;
  end;
end;

procedure TfrmWebFiltersDlg.FormCreate(Sender: TObject);
begin
  FSelectMode := False;
  fDefaultFilterID := -1;
  fDefaultParamID := -1;
  fFixedFilter := False;

end;

procedure TfrmWebFiltersDlg.MergeFilterParams;
// var
// ARecordIndex: Integer;
// I: Integer;
// SelectedFilterParamID: string;
// SelectedFilterParamName: string;
begin
  fMergeDialog := TfrmGoodsFilterParamMergeDlg.Create(Self);
  fMergeDialog.FilterParamList := TObjectList<TFilterParamsList>.Create();

  try
    cxGridParamsTable.DataController.ForEachRow(True, FilterParamProcessing);
    fMergeDialog.ShowModal;
  finally
    begin
      fMergeDialog.FilterParamList.Free;
      fMergeDialog.Free;
    end;
  end;
end;

procedure TfrmWebFiltersDlg.FilterParamProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);
var
  RecIdx, ColIDIdx: Integer;
    // outputVal: Variant;
begin
  fMergeDialog.FilterParamList.Add(TFilterParamsList.Create);
  RecIdx := ARowInfo.RecordIndex;
  ColIDIdx := cxGridParamsTable.DataController.GetItemByFieldName('FILTERPARAMID').Index;
  fMergeDialog.FilterParamList.Last.FilterParamID := cxGridParamsTable.DataController.Values[RecIdx,
    ColIDIdx];
  ColIDIdx := cxGridParamsTable.DataController.GetItemByFieldName('PARAM_VALUE').Index;
  fMergeDialog.FilterParamList.Last.FilterParamName := cxGridParamsTable.DataController.Values[RecIdx,
    ColIDIdx];
end;

procedure TfrmWebFiltersDlg.ChangeFilterParentProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);
var
  RecIdx, ColIDIdx: Integer;
    // outputVal: Variant;
begin
  frmChangeFilterParentDialog.FilterParamList.Add(TFilterParamsList.Create);
  RecIdx := ARowInfo.RecordIndex;

  ColIDIdx := cxGridParamsTable.DataController.GetItemByFieldName('FILTERPARAMID').Index;
  frmChangeFilterParentDialog.FilterParamList.Last.FilterParamID := cxGridParamsTable.DataController.Values
    [RecIdx, ColIDIdx];

  ColIDIdx := cxGridParamsTable.DataController.GetItemByFieldName('PARAM_VALUE').Index;
  frmChangeFilterParentDialog.FilterParamList.Last.FilterParamName := cxGridParamsTable.DataController.Values
    [RecIdx, ColIDIdx];

    //
    // ARecordIndex := cxGridParamsTable.Controller.SelectedRecords[I].RecordIndex;
    // dialog.ListOfItems.Add(TFilterParamsList.Create);
    // dialog.ListOfItems.Last.FilterParamID := cxGridParamsTable.DataController.GetValue(ARecordIndex,
    // cxGridParams_FILTERPARAMID.Index);
    // dialog.ListOfItems.Last.FilterParamName := cxGridParamsTable.DataController.GetValue(ARecordIndex,
    // cxGridParams_PARAM_VALUE.Index);

end;

procedure TfrmWebFiltersDlg.FormActivate(Sender: TObject);
begin
  cxGridParams.SetFocus;
end;

procedure TfrmWebFiltersDlg.NavigateBack;
var
  ParentID: Integer;
begin
  if fInSearch then
  begin
    if IBCQueryFilters.Eof then
      ParentID := fRootParentID
    else
      ParentID := IBCQueryFilters.FieldByName('PARENTID').AsInteger
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
    IBCQueryFilters.ParamByName('ParentID').AsInteger := ParentID;
    fInSearch := False;
    IBCQueryFilters.Open;
    fCurrentParentID := IBCQueryFilters.FieldByName('PARENTID').AsInteger;
    IBCQueryFilters.Locate('FILTERID', ParentID, []);

  end;

  WhenFilterSelectionChanged;
end;

procedure TfrmWebFiltersDlg.NavigateBySearch(const SearchCondition: string);
begin
  EnableCondition(2, SearchCondition);
  fInSearch := True;
  IBCQueryFilters.Open;
  WhenFilterSelectionChanged;
end;

procedure TfrmWebFiltersDlg.NavigateForward;
var
  ParentID: Integer;
begin
  if (IBCQueryFilters.RecordCount = 0) then
    ParentID := 0
  else
    ParentID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;

  EnableCondition(0); // Browse Forward
  IBCQueryFilters.ParamByName('ParentID').AsInteger := ParentID;
  fCurrentParentID := ParentID;
  fInSearch := False;
  IBCQueryFilters.Open;
  GetFilterPath;
  WhenFilterSelectionChanged;
end;

procedure TfrmWebFiltersDlg.NavigateToFilterID(const FilterID: Integer);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryFilters.ParamByName('ParentID').AsInteger := FilterID;
  fInSearch := False;
  IBCQueryFilters.Open;
  IBCQueryFilters.Locate('FILTERID', FilterID, []);
  fCurrentParentID := IBCQueryFilters.FieldByName('ParentID').AsInteger;
end;

procedure TfrmWebFiltersDlg.NavigateToHome(const RootID: Integer);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryFilters.ParamByName('ParentID').AsInteger := RootID;
  fCurrentParentID := RootID;
  fInSearch := False;
  IBCQueryFilters.Open;

  WhenFilterSelectionChanged;
end;

procedure TfrmWebFiltersDlg.Prepare;
begin
    // prepare view
  if not FSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

    // open data
  if (fDefaultFilterID <> -1) then
    NavigateToFilterID(fDefaultFilterID)
  else
    NavigateToHome(fRootParentID);


//    WhenFilterSelectionChanged;

  cxGridFilter_FILTERNAME.Focused := True;
  cxPageControl1.ActivePageIndex := 0;
  GetFilterPath;
  IBCQueryParams.Open;
  IBCQueryParams.LocateEx('filterparamid', fDefaultParamID, []);
end;

function TfrmWebFiltersDlg.SelectFilterParam(const DefaultFilterID, DefaultParamID: Integer; const
  FixedFilter: Boolean): Boolean;
var
  Query: TIBCQuery;
begin
  FSelectMode := True;
  fDefaultFilterID := DefaultFilterID;
  fDefaultParamID := DefaultParamID;
  if (fDefaultFilterID = -1) and (fDefaultParamID > 0) then
  begin
    Query := TIBCQuery.Create(Self);
    try
      Query.SQL.Text :=
        'SELECT FILTERID FROM TS_FILTER_PARAMS WHERE FILTERPARAMID=:DEFAULT_FILTER_PARAMID';
      Query.ParamByName('DEFAULT_FILTER_PARAMID').AsInteger := fDefaultParamID;
      try
        Query.Open;
        fDefaultFilterID := Query.FieldByName('FILTERID').AsInteger;
      except
        on E: Exception do
          fDefaultFilterID := -1;
      end;
    finally
      Query.Free;
    end;
  end;
  fFixedFilter := FixedFilter;
  cxGridFilter.Enabled := not FixedFilter;

  Result := (ShowModal = mrOk);
end;

procedure TfrmWebFiltersDlg.GetFilterPath;
begin
  DialogTitle1.Text := '#' + IBCQueryFilters.FieldByName('PARENTID').AsString + ' - ' +
    IBCQueryFilters.FieldByName('PARENT_FILTERNAME').AsString + ' | ' + '#' + IBCQueryFilters.FieldByName
    ('FILTERID').AsString + ' - ' + IBCQueryFilters.FieldByName('FILTERNAME').AsString;
end;

procedure TfrmWebFiltersDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmWebFiltersDlg.SetupSecurityItems;
begin
    // IsLimitedUser := (SWNSecurityManager.LoggedUser.UserGroupCount = 1) and ((SWNSecurityManager.LoggedUser.UserGroups
    // [0].ID = 22) or (SWNSecurityManager.LoggedUser.UserGroups[0].ID = 11)); // Content operatori
    if swnsecurityManager.IsAdmin  then
      cxGridParams_CREATED_BY_NAME.Visible := True;

  if not SecurityFlagEnabled(cSecurityFlag_Website_Фильтры_Crearea_filtrelor) then
    bbParamNew.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Website_Фильтры_Editarea_filtrelor) then
    bbParamModify.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Website_Фильтры_Stergerea_filtrelor) then
    bbParamDelete.Visible := ivNever;

  if SWNSecurityManager.IsLimitedUser then
  begin
        // filter menu items
    bbFolderNew.Visible := ivNever;
    bbFilterNew.Visible := ivNever;
    bbFilterModify.Visible := ivNever;
    bbFilterDelete.Visible := ivNever;
    bbSortFilters.Visible := ivNever;
    bbChangeParent.Visible := ivNever;
    bbGoodsList.Visible := ivNever;
        // filter params value
        // bbParamNew.Visible := ivNever;
        // bbParamModify.Visible := ivNever;
        // bbParamDelete.Visible := ivNever;
        // bbTools.Visible := ivNever;
        // pnFilters.Visible := False;
        // Width := Width - pnFilters.Width;
//        tsGoodsList.Visible := False;
    bbValueOrder.Visible := ivNever;
    bbGoodsListByFiltersParam.Visible := ivNever;
    bbGoodsListByFiltersParam.Visible := ivNever;
    bbCloneValues.Visible := ivNever;
    bbMergeFilterValues.Visible := ivNever;
    bbChangeFilterParent.Visible := ivNever;
    bbReadySet_YesNo.Visible := ivNever;
    bbMergeFilters.Visible := ivNever;

    cxGridParamsTable.OptionsSelection.ShowCheckBoxesDynamically := False;
    cxGridParamsTable.OptionsSelection.MultiSelect := False;
  end;
end;

procedure TfrmWebFiltersDlg.ShowChangeParentDialog;
var
  dialog: TfrmChangeParentFolderDlg;
begin
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtFilters;
    dialog.FolderObjectID := IBCQueryFilters.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(IBCQueryFilters.FieldByName('FILTERID').AsInteger, IBCQueryFilters.FieldByName
      ('FILTERNAME').AsString + ' - ' + IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFilters.Close;
      IBCQueryFilters.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowCreateNewFilterDialog;
var
  dialog: TfrmGoodsFilterEditor;
begin
  dialog := TfrmGoodsFilterEditor.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewFilter := True;
    dialog.ParentID := fCurrentParentID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowCreateNewFolderDialog;
var
  dialog: TfrmGoodsFilterEditor;
begin
  dialog := TfrmGoodsFilterEditor.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewFilter := True;
    dialog.IsFolder := True;
    dialog.ParentID := fCurrentParentID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowCreateNewParamDialog(const DefaultRom, DefaultRus: string; const
  DefaultOrderNo: Integer);
var
  dialog: TfrmGoodsFilterParamEditor;
begin
  dialog := TfrmGoodsFilterParamEditor.Create(Self, IBCQueryParams, IBCDataSourceParams);
  try
    dialog.CreateNewValue := True;
    dialog.DefaultTitleRom := DefaultRom;
    dialog.DefaultTitleRus := DefaultRus;
    dialog.DefaultOrderNo := DefaultOrderNo;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowModifyGoodsPropertiesDialog;
var
  dialog: TfrmGoodsFilterEditor;
begin
  dialog := TfrmGoodsFilterEditor.Create(Self, IBCQueryFilters, IBCDataSourceFilters);
  try
    dialog.CreateNewFilter := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowModifyParamDialog;
var
  dialog: TfrmGoodsFilterParamEditor;
begin
  dialog := TfrmGoodsFilterParamEditor.Create(Self, IBCQueryParams, IBCDataSourceParams);
  try
    dialog.CreateNewValue := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowSortFiltersDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    if fCurrentParentID = 0 then
      dialog.DBTable := cotFiltersFolders
    else
      dialog.DBTable := cotFilters;

    dialog.ParentID := fCurrentParentID;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFilters.Close;
      IBCQueryFilters.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.ShowValuesSortDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cosWebFiltersParams;
    dialog.ParentID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryParams.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebFiltersDlg.WhenFilterSelectionChanged;
var
  fCanAdd, fCanModify, fCanDelete, fCanAddParam: Boolean;
  fForward, fBack, fHome, FLG_FOLDER, fCanSort: Boolean;
begin
  fCanAdd := not fFixedFilter and not fInSearch;
  fCanModify := False;
  fCanAddParam := False;
  fCanDelete := False;
  fHome := False;
  fForward := False;
  fBack := False;
  fCanSort := False;

  if fFixedFilter then
  begin
    if (cxGridFilterTable.DataController.RecNo > 0) then
    begin
      fCanAddParam := True;
      fCanSort := True;
    end;
  end
  else if (cxGridFilterTable.DataController.RecNo > 0) then
  begin
    FLG_FOLDER := IBCQueryFilters.FieldByName('FLG_FOLDER').AsInteger = 1;
    pnParams.Visible := not (FLG_FOLDER) and (IBCQueryFilters.FieldByName('FLG_ORDINARY_FILTER').AsInteger
      = 0);

    fForward := FLG_FOLDER;
    fBack := (fCurrentParentID > 0) and (fCurrentParentID <> fRootParentID) or fInSearch;
    fHome := (fCurrentParentID <> fRootParentID) or fInSearch;

    fCanModify := True;
    fCanDelete := True;

    fCanAddParam := not FLG_FOLDER;
    fCanSort := True;
  end
  else
  begin
        // no recors
    fBack := (fCurrentParentID > 0) and (fCurrentParentID <> fRootParentID) and not fInSearch;
    fHome := fBack or (fRootParentID >= 0);
    pnParams.Visible := False;

  end;

    // filter
  bbFilterNew.Enabled := fCanAdd;
  bbFolderNew.Enabled := fCanAdd;
  bbFilterModify.Enabled := fCanModify;
  bbFilterDelete.Enabled := fCanDelete;
  bbChangeParent.Enabled := fCanModify;
    // param
  bbParamNew.Enabled := fCanAddParam;
  bbSortFilters.Enabled := fCanSort;

    // navigation
  bbNavHome.Enabled := fHome;
  bbNavBack.Enabled := fBack;
  bbNavForward.Enabled := fForward;

  GetFilterPath;

  WhenParamSelectionChanged;
end;

procedure TfrmWebFiltersDlg.WhenParamSelectionChanged;
var
  fCanModify, fCanDelete, fCanSort, fCanClone: Boolean;
begin
  fCanModify := False;
  fCanDelete := False;
  fCanSort := cxGridParamsTable.DataController.RecordCount > 1;
  fCanClone := False;

  if cxGridParamsTable.DataController.RecNo > 0 then
  begin
    fCanModify := True;
    fCanDelete := True;
    fCanClone := True;
  end;
  bbParamModify.Enabled := fCanModify;
  bbParamDelete.Enabled := fCanDelete;
  bbValueOrder.Enabled := fCanSort;
  bbCloneValues.Enabled := fCanClone;
end;

end.


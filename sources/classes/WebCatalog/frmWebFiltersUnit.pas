unit frmWebFiltersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, cxImageComboBox, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  cxClasses, DBAccess, IBC, MemDS, dxUIAClasses;

type
  TfrmFiltersDialog = class(TSWNCustomForm)
    IBCDataSourceFilters: TIBCDataSource;
    IBCQueryFilters: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    dxBarManager: TdxBarManager;
    dxBarManagerBar2: TdxBar;
    bbFilterNew: TdxBarButton;
    bbFilterModify: TdxBarButton;
    bbParamNew: TdxBarButton;
    bbParamModify: TdxBarButton;
    bbParamDelete: TdxBarButton;
    bbFilterDelete: TdxBarButton;
    bbValueOrder: TdxBarButton;
    bbNavHome: TdxBarButton;
    bbNavBack: TdxBarButton;
    bbNavForward: TdxBarButton;
    bbFolderNew: TdxBarButton;
    bbSortFilters: TdxBarButton;
    bbChangeParent: TdxBarButton;
    bbCloneValues: TdxBarButton;
    bbTools: TdxBarSubItem;
    bbReadySet_YesNo: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    cxGridFilter: TcxGrid;
    cxGridFilterTable: TcxGridDBTableView;
    cxGridFilter_FLG_FOLDER: TcxGridDBColumn;
    cxGridFilte_FILTERID: TcxGridDBColumn;
    cxGridFilter_FILTERNAME: TcxGridDBColumn;
    cxGridFilter_FILTERNAME_RUS: TcxGridDBColumn;
    cxGridFilter_ORDERNO: TcxGridDBColumn;
    cxGridFilterLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    cxButton1: TcxButton;
    dxBarButton3: TdxBarButton;
    procedure bbNavHomeClick(Sender: TObject);
    procedure bbNavBackClick(Sender: TObject);
    procedure bbNavForwardClick(Sender: TObject);
    procedure bbFolderNewClick(Sender: TObject);
    procedure bbFilterNewClick(Sender: TObject);
    procedure bbFilterModifyClick(Sender: TObject);
    procedure bbFilterDeleteClick(Sender: TObject);
    procedure bbSortFiltersClick(Sender: TObject);
    procedure bbChangeParentClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
  private
    { Private declarations }
//    FSelectMode: Boolean;
//    fFilterID: Integer;
//    fFilterParamID: Integer;
    fDefaultFilterID: Integer;
//    fDefaultParamID: Integer;
    fFixedFilter: Boolean;
//    fFilterParamValueRom: string;
//    fFilterParamValueRus: string;
//    fFilterNameRom: string;
//    fFilterNameRus: string;
    fCurrentParentID: Integer;
    fRootParentID: Integer;
    fInSearch: Boolean;
  protected
    procedure Prepare; override;
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToHome(const RootID: Integer);
    procedure EnableCondition(const ConditionIndex: Integer; const CustomCondition: string = '');
    procedure WhenFilterSelectionChanged;
    procedure WhenParamSelectionChanged;
    procedure NavigateBySearch(const SearchCondition: string);
    procedure NavigateToFilterID(const FilterID: Integer);
  public
    { Public declarations }
  end;

var
  frmFiltersDialog: TfrmFiltersDialog;

implementation

uses
  frmGoodsFilterParamMergeDialog, frmChangeOrderNoDialog, SearchDialog, SWNSearchUnit,
  frmChangeParentFolderDialog, SWNUtils, SWNDBErrors, frmGoodsFilterEditorDialog, frmWebGoodsInFilterUnit;

{$R *.dfm}

procedure TfrmFiltersDialog.WhenFilterSelectionChanged;
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

  WhenParamSelectionChanged;
end;

procedure TfrmFiltersDialog.EnableCondition(const ConditionIndex: Integer; const CustomCondition: string);
begin
  IBCQueryFilters.Close;
  case ConditionIndex of     // forward
    0:
      IBCQueryFilters.FilterSQL := 'PARENTID=:ParentID';
     // backward
    1:
      IBCQueryFilters.FilterSQL := 'PARENTID=(SELECT PARENTID FROM TS_FILTERS WHERE FILTERID=:ParentID)';
     // search
    2:
      IBCQueryFilters.FilterSQL := CustomCondition;
  end;
end;

procedure TfrmFiltersDialog.NavigateForward;
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

  WhenFilterSelectionChanged;
end;

procedure TfrmFiltersDialog.bbSortFiltersClick(Sender: TObject);
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

procedure TfrmFiltersDialog.dxBarButton1Click(Sender: TObject);
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
            AddConditionToWhere(SearchInWhere, 'TS_FILTERS.FILTERID=' + SC.SearchText);
          sfName:
            AddConditionToWhere(SearchInWhere, '(TS_FILTERS.FILTERNAME_RUS CONTAINING ''' + SC.SearchText +
              '''' + ' OR TS_FILTERS.FILTERNAME CONTAINING ''' + SC.SearchText + ''')');
          sfIDCustom:
            AddConditionToWhere(SearchInWhere,
              'EXISTS(SELECT 1 FROM TS_FILTER_PARAMS WHERE TS_FILTER_PARAMS.FILTERID=TS_FILTERS.FILTERID AND (PARAM_VALUE CONTAINING ''' +
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

procedure TfrmFiltersDialog.dxBarButton3Click(Sender: TObject);
var
  dialog: TfrmGoodsInFilterDialog;
begin
  dialog:=TfrmGoodsInFilterDialog.Create(self);
  try
    dialog.FilterID := IBCQueryFilters.FieldByName('FILTERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFiltersDialog.NavigateBack;
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

procedure TfrmFiltersDialog.NavigateToHome(const RootID: Integer);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryFilters.ParamByName('ParentID').AsInteger := RootID;
  fCurrentParentID := RootID;
  fInSearch := False;
  IBCQueryFilters.Open;

  WhenFilterSelectionChanged;
end;

procedure TfrmFiltersDialog.NavigateToFilterID(const FilterID: Integer);
begin
   EnableCondition(1); // Browse Backward
   IBCQueryFilters.ParamByName('ParentID').AsInteger := FilterID;
   fInSearch := False;
   IBCQueryFilters.Open;
   IBCQueryFilters.Locate('FILTERID', FilterID, []);
   fCurrentParentID := IBCQueryFilters.FieldByName('ParentID').AsInteger;
end;

procedure TfrmFiltersDialog.Prepare;
begin
  inherited;
     // open data
   if (fDefaultFilterID <> -1) then
      NavigateToFilterID(fDefaultFilterID)
   else
      NavigateToHome(fRootParentID);

//   IBCQueryParams.Active := True;
end;

procedure TfrmFiltersDialog.bbChangeParentClick(Sender: TObject);
var
  dialog: TfrmChangeParentFolderDlg;
begin
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtFilters;
    dialog.FolderObjectID := IBCQueryFilters.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(IBCQueryFilters.FieldByName('FILTERID').AsInteger, IBCQueryFilters.FieldByName('FILTERNAME').asString
      + ' - ' + IBCQueryFilters.FieldByName('FILTERNAME_RUS').asString);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryFilters.Close;
      IBCQueryFilters.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmFiltersDialog.bbFilterDeleteClick(Sender: TObject);
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

procedure TfrmFiltersDialog.bbFilterModifyClick(Sender: TObject);
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

procedure TfrmFiltersDialog.bbFilterNewClick(Sender: TObject);
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

procedure TfrmFiltersDialog.bbFolderNewClick(Sender: TObject);
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

procedure TfrmFiltersDialog.bbNavBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmFiltersDialog.bbNavForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmFiltersDialog.bbNavHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
end;

procedure TfrmFiltersDialog.WhenParamSelectionChanged;
begin
  bbParamModify.Enabled := False;
  bbParamDelete.Enabled := False;
  bbValueOrder.Enabled := False;
  bbCloneValues.Enabled := False;
end;

procedure TfrmFiltersDialog.NavigateBySearch(const SearchCondition: string);
begin
  EnableCondition(2, SearchCondition);
  fInSearch := True;
  IBCQueryFilters.Open;
  WhenFilterSelectionChanged;
end;

end.


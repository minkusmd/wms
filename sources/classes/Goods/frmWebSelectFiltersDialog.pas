unit frmWebSelectFiltersDialog;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    SWNBaseUnit, Data.DB, DBAccess, IBC, MemDS, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
    cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxImageComboBox, cxCheckBox,
    cxClasses, dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, Vcl.ExtCtrls,
    Vcl.Menus, Vcl.StdCtrls, cxButtons, DialogTitle, dxUIAClasses;

type
    TfrmWebSelectFiltersDlg = class(TSWNBaseFormClass)
        IBCQueryFilters: TIBCQuery;
        IBCDataSourceFilters: TIBCDataSource;
        Panel1: TPanel;
        cxGridFilter: TcxGrid;
        cxGridFilterTable: TcxGridDBTableView;
        cxGridFilter_FLG_FOLDER: TcxGridDBColumn;
        cxGridFilte_FILTERID: TcxGridDBColumn;
        cxGridFilter_FILTERNAME: TcxGridDBColumn;
        cxGridFilter_FILTERNAME_RUS: TcxGridDBColumn;
        cxGridFilter_ORDERNO: TcxGridDBColumn;
        cxGridFilter_FLG_ORDINARY_FILTER: TcxGridDBColumn;
        cxGridFilterLevel: TcxGridLevel;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
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
        bbGoodsList: TdxBarButton;
        bbChangeFilterParent: TdxBarButton;
        bbMergeFilterValues: TdxBarButton;
        bbGoodsListByFiltersParam: TdxBarButton;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        DialogTitle1: TDialogTitle;
        IBCTrUpdate: TIBCTransaction;
        procedure bbChangeParentClick(Sender: TObject);
        procedure bbFolderNewClick(Sender: TObject);
        procedure bbNavBackClick(Sender: TObject);
        procedure bbNavForwardClick(Sender: TObject);
        procedure bbNavHomeClick(Sender: TObject);
        procedure bbParamDeleteClick(Sender: TObject);
        procedure bbParamModifyClick(Sender: TObject);
        procedure bbParamNewClick(Sender: TObject);
        procedure bbValueOrderClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
    private
        fCurrentParentID: Integer;
        fDefaultFilterID: Integer;
        FFilterID: Integer;
        FFilterNameRo: string;
        FFilterNameRu: string;
        fFixedFilter: Boolean;
        fInSearch: Boolean;
        fRootParentID: Integer;
        FSelectMode: Boolean;
        procedure SetFilterNameRo(const Value: string);
        procedure SetFilterNameRu(const Value: string);
        procedure SetSelectMode(const Value: Boolean);
    { Private declarations }
    protected
        procedure EnableCondition(const ConditionIndex: Integer; const CustomCondition: string = '');
        procedure GetFilterPath;
        procedure NavigateBack;
        procedure NavigateBySearch(const SearchCondition: string);
        procedure NavigateToHome(const RootID: Integer);
        procedure NavigateForward;
        procedure NavigateToFilterID(const FilterID: Integer);
        procedure WhenFilterSelectionChanged;
        procedure Prepare; override;
        procedure SetupSecurityItems; override;

    public    { Public declarations }
        function SelectFilter(const DefaultFilterID: Integer; const FixedFilter: Boolean = False): Boolean;
        property FilterID: Integer read FFilterID;
        property FilterNameRo: string read FFilterNameRo write SetFilterNameRo;
        property FilterNameRu: string read FFilterNameRu write SetFilterNameRu;
        property SelectMode: Boolean read FSelectMode write SetSelectMode;
    end;

var
    frmWebSelectFiltersDlg: TfrmWebSelectFiltersDlg;


implementation

uses
    frmGoodsFilterEditorDialog, SWNDBErrors, SWNUtils, frmChangeParentFolderDialog, frmChangeOrderNoDialog, SWNSearchUnit, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

procedure TfrmWebSelectFiltersDlg.bbChangeParentClick(Sender: TObject);
var
    dialog: TfrmChangeParentFolderDlg;
begin
    dialog := TfrmChangeParentFolderDlg.Create(Self);
    try
        dialog.DBTable := dbtFilters;
        dialog.FolderObjectID := IBCQueryFilters.FieldByName('PARENTID').AsInteger;
        dialog.AddObjectInfo(IBCQueryFilters.FieldByName('FILTERID').AsInteger, IBCQueryFilters.FieldByName('FILTERNAME').AsString + ' - ' +
            IBCQueryFilters.FieldByName('FILTERNAME_RUS').AsString);
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryFilters.Close;
            IBCQueryFilters.Open;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebSelectFiltersDlg.bbFolderNewClick(Sender: TObject);
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

procedure TfrmWebSelectFiltersDlg.bbNavBackClick(Sender: TObject);
begin
    NavigateBack;
end;

procedure TfrmWebSelectFiltersDlg.bbNavForwardClick(Sender: TObject);
begin
    NavigateForward;
end;

procedure TfrmWebSelectFiltersDlg.bbNavHomeClick(Sender: TObject);
begin
    NavigateToHome(fRootParentID);
end;

procedure TfrmWebSelectFiltersDlg.bbParamDeleteClick(Sender: TObject);
var
    S: string;
begin
    S := Format('Stergeti filtrul "%s"?', [IBCQueryFilters.FieldByName('FILTERNAME').AsString]);
    if ShowAskDialog('Stergere', S, 'Atentie! Acest element de filtru va fi sters din toate produsele unde a fost setat.') = mrYes then
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

procedure TfrmWebSelectFiltersDlg.bbParamModifyClick(Sender: TObject);
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

procedure TfrmWebSelectFiltersDlg.bbParamNewClick(Sender: TObject);
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

procedure TfrmWebSelectFiltersDlg.bbValueOrderClick(Sender: TObject);
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

procedure TfrmWebSelectFiltersDlg.dxBarButton1Click(Sender: TObject);
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
                        AddConditionToWhere(SearchInWhere, '(FF.FILTERNAME_RUS CONTAINING ''' + SC.SearchText + '''' +
                            ' OR FF.FILTERNAME CONTAINING ''' + SC.SearchText + ''')');
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

procedure TfrmWebSelectFiltersDlg.NavigateBack;
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

procedure TfrmWebSelectFiltersDlg.EnableCondition(const ConditionIndex: Integer; const CustomCondition: string);
begin
    IBCQueryFilters.Close;
    case ConditionIndex of // forward
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

procedure TfrmWebSelectFiltersDlg.GetFilterPath;
begin
    DialogTitle1.Text := '#' + IBCQueryFilters.FieldByName('PARENTID').AsString + ' - ' + IBCQueryFilters.FieldByName('PARENT_FILTERNAME').AsString
        + ' | ' + '#' + IBCQueryFilters.FieldByName('FILTERID').AsString + ' - ' + IBCQueryFilters.FieldByName('FILTERNAME').AsString;
end;

procedure TfrmWebSelectFiltersDlg.NavigateBySearch(const SearchCondition: string);
begin
    EnableCondition(2, SearchCondition);
    fInSearch := True;
    IBCQueryFilters.Open;
    WhenFilterSelectionChanged;
end;

procedure TfrmWebSelectFiltersDlg.NavigateToHome(const RootID: Integer);
begin
    EnableCondition(0); // Browse Forward
    IBCQueryFilters.ParamByName('ParentID').AsInteger := RootID;
    fCurrentParentID := RootID;
    fInSearch := False;
    IBCQueryFilters.Open;

    WhenFilterSelectionChanged;
end;

procedure TfrmWebSelectFiltersDlg.Prepare;
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
//    cxPageControl1.ActivePageIndex := 0;
    GetFilterPath;
//    IBCQueryParams.Open;
//    IBCQueryGoodsByFilter.Open;
end;

procedure TfrmWebSelectFiltersDlg.NavigateForward;
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

procedure TfrmWebSelectFiltersDlg.NavigateToFilterID(const FilterID: Integer);
begin
    EnableCondition(1); // Browse Backward
    IBCQueryFilters.ParamByName('ParentID').AsInteger := FilterID;
    fInSearch := False;
    IBCQueryFilters.Open;
    IBCQueryFilters.Locate('FILTERID', FilterID, []);
    fCurrentParentID := IBCQueryFilters.FieldByName('ParentID').AsInteger;
end;

procedure TfrmWebSelectFiltersDlg.WhenFilterSelectionChanged;
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

    GetFilterPath;

//    WhenParamSelectionChanged;
end;

function TfrmWebSelectFiltersDlg.SelectFilter(const DefaultFilterID: Integer; const FixedFilter: Boolean): Boolean;
var
    Query: TIBCQuery;
begin
    FSelectMode := True;
    fDefaultFilterID := DefaultFilterID;
    if (fDefaultFilterID = -1) then
    begin
        Query := TIBCQuery.Create(Self);
        try
            Query.SQL.Text := 'SELECT FILTERID, FILTERNAME, FILTERNAME_RUS FROM TS_FILTERS WHERE FILTERID=:DEFAULT_FILTER_ID';
            Query.ParamByName('DEFAULT_FILTER_ID').AsInteger := fDefaultFilterID;
            try
                Query.Open;
                fDefaultFilterID := Query.FieldByName('FILTERID').AsInteger;
                FFilterNameRo := Query.FieldByName('FILTERNAME').AsString;
                FFilterNameRu := Query.FieldByName('FILTERNAME_RUS').AsString;
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

procedure TfrmWebSelectFiltersDlg.SetFilterNameRo(const Value: string);
begin
    FFilterNameRo := Value;
end;

procedure TfrmWebSelectFiltersDlg.SetFilterNameRu(const Value: string);
begin
    FFilterNameRu := Value;
end;

procedure TfrmWebSelectFiltersDlg.SetSelectMode(const Value: Boolean);
begin
    FSelectMode := Value;
end;

procedure TfrmWebSelectFiltersDlg.SetupSecurityItems;
begin
    // IsLimitedUser := (SWNSecurityManager.LoggedUser.UserGroupCount = 1) and ((SWNSecurityManager.LoggedUser.UserGroups
    // [0].ID = 22) or (SWNSecurityManager.LoggedUser.UserGroups[0].ID = 11)); // Content operatori

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

        bbValueOrder.Visible := ivNever;
        bbGoodsListByFiltersParam.Visible := ivNever;
        bbGoodsListByFiltersParam.Visible := ivNever;
        bbCloneValues.Visible := ivNever;
        bbMergeFilterValues.Visible := ivNever;
        bbChangeFilterParent.Visible := ivNever;
        bbReadySet_YesNo.Visible := ivNever;
    end;
end;

end.


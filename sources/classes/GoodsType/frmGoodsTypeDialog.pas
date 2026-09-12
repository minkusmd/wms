unit frmGoodsTypeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, dxBar, DialogTitle,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, StdCtrls, DBAccess, IBC, cxButtons,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, MemDS, cxClasses, cxGridTableView,
  cxGridCustomView, cxCheckBox, SWNSecurity, dxUIAClasses;

type
  TcxGridTableControllerAccess = class(TcxGridTableController);

  TcxGridFindPanelAccess = class(TcxGridFindPanel);

  TfrmGoodsTypeDlg = class(TSWNCustomForm)
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    cxGridGoodsTypeTable: TcxGridDBTableView;
    cxGridGoodsTypeLevel: TcxGridLevel;
    cxGridGoodsType: TcxGrid;
    bbNewType: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryGoodsType: TIBCQuery;
    cxGridGoodsType_GOODSTYPEID: TcxGridDBColumn;
    cxGridGoodsType_TITLE: TcxGridDBColumn;
    cxGridGoodsType_DESCRIPTION: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    cxGridGoodsType_TITLE_RUS: TcxGridDBColumn;
    bbSearch: TdxBarButton;
    cxGridGoodsType_SEARCH_KEYS: TcxGridDBColumn;
    cxGridGoodsType_USER_NAME: TcxGridDBColumn;
    bbNPSC: TdxBarButton;
    dxBarSubItemNPSC: TdxBarSubItem;
    bbCloseNPSC: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    bbMergeGoodsType: TdxBarButton;
    btnClose: TcxButton;
    cxGridGoodsType_Model: TcxGridDBColumn;
    cxGridGoodsTypeTableColumn2: TcxGridDBColumn;
    cxGridGoodsTypeTableColumn3: TcxGridDBColumn;
    cxGridGoodsTypeTableColumn4: TcxGridDBColumn;
    btnOK: TcxButton;
    IBCDataSourceGoodsType: TIBCDataSource;
    cxGridGoodsTypeTableColumn1: TcxGridDBColumn;
    cxGridGoodsTypeTableColumn5: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    cxGridGoodsTypeTable_COUNT_GOODS: TcxGridDBColumn;
    bbCategorySuppliers: TdxBarButton;
    cxGridGoodsTypeTableColumn6: TcxGridDBColumn;
    bbGoodsAttributesTemplate: TdxBarButton;
    procedure cxGridGoodsTypeTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewTypeClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridGoodsTypeTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbSearchClick(Sender: TObject);
    procedure bbNPSCClick(Sender: TObject);
    procedure bbCloseNPSCClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbMergeGoodsTypeClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bbCategorySuppliersClick(Sender: TObject);
  private    { Private declarations }
    fInSearch: Boolean;
    fDefaultGoodsTypeID: integer;
    FSelectMode: Boolean;
    fGoodsTypeTitle: string;
    FGoodsTypeID: integer;
    procedure SelectionChanged;
    procedure ShowCreateNewTypeDialog;
    procedure ShowModifyTypeDialog;
    procedure DeleteType;
    procedure ShowSearchDialog;
    procedure NavigateSearch(const WhereCondition: string);
    procedure SetDefaultGoodsTypeID(const Value: integer);
    procedure SetSelectMode(const Value: Boolean);
    procedure SelectItem;
    procedure ShowNPSCDialog;
    procedure ShowCloneNPSCDialog;
    function DoCloneNPSCProps(const SourceGoodsTypeID, TargetGoodsTypeID: integer): Boolean;
    procedure SetGoodsTypeID(const Value: integer);
  protected    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property DefaultGoodsTypeID: integer read fDefaultGoodsTypeID write SetDefaultGoodsTypeID;
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property GoodsTypeID: integer read FGoodsTypeID write SetGoodsTypeID;
    property GoodsTypeTitle: string read fGoodsTypeTitle;
    function SelectGoodsType(AGoodsTypeID: Integer): Boolean;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNDBErrors, frmGoodsTypeEditorDialog, SWNSearchUnit, SWNValueStorageUnit,
  frmGoodsTypeNPSCDialog, frmGoodsTypeNPSC_Clone_Dialog, frmGoodsByTypeUnit, frmMergeGoodsTypesUnit,
  frmCategorySuppliersUnit, frmWebDescriptionTemplateDialog;

{$R *.dfm}

procedure TfrmGoodsTypeDlg.bbCategorySuppliersClick(Sender: TObject);
var
  d: TfrmCategorySuppliersDlg;
begin
  d:=TfrmCategorySuppliersDlg.Create(self, dmdb.IBCConnection);
  try
    D.WebGoodsTypeID := ibcQueryGoodsType.FieldByName('GOODSTYPEID').AsInteger;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.bbCloseNPSCClick(Sender: TObject);
begin
  ShowCloneNPSCDialog;
end;

procedure TfrmGoodsTypeDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteType;
end;

procedure TfrmGoodsTypeDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyTypeDialog;
end;

procedure TfrmGoodsTypeDlg.bbNewTypeClick(Sender: TObject);
begin
  ShowCreateNewTypeDialog;
end;

procedure TfrmGoodsTypeDlg.bbNPSCClick(Sender: TObject);
begin
  ShowNPSCDialog;
end;

procedure TfrmGoodsTypeDlg.cxGridGoodsTypeTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if FSelectMode then begin
    SelectItem;
  end
  else if bbModify.Enabled then begin
    bbModifyClick(bbModify);
    AHandled := True;
  end;
end;

procedure TfrmGoodsTypeDlg.cxGridGoodsTypeTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmGoodsTypeDlg.DeleteType;
begin
  if ShowAskDialog('Tipuri de produse', 'Stergerea tipului de produs' + #13#10 + '"' + IBCQueryGoodsType.FieldByName('TITLE').AsString
    + '"?') = mrYes then begin
    IBCQueryGoodsType.UpdateTransaction.StartTransaction;
    try
      IBCQueryGoodsType.Delete;
      IBCQueryGoodsType.UpdateTransaction.Commit;
    except
      on E: Exception do begin
        IBCQueryGoodsType.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

function TfrmGoodsTypeDlg.DoCloneNPSCProps(const SourceGoodsTypeID, TargetGoodsTypeID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_NGS_CLONE_NAMING_PARAMS(:sid,:tid)';
    Query.ParamByName('sid').AsInteger := SourceGoodsTypeID;
    Query.ParamByName('tid').AsInteger := TargetGoodsTypeID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.dxBarButton1Click(Sender: TObject);
var
  dialog: TfrmGoodsByType;
begin
  dialog := TfrmGoodsByType.Create(Self, dmDB.IBCConnection);
  try
    dialog.GoodsTypeID := IBCQueryGoodsType.FieldByName('GOODSTYPEID').AsInteger;
    if dialog.ShowModal = mrOk then
      IBCQueryGoodsType.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.bbMergeGoodsTypeClick(Sender: TObject);
var
  dialog: TfrmMergeGoodsTypesDlg;
begin
  dialog := TfrmMergeGoodsTypesDlg.Create(self, IBCQueryGoodsType.Connection);
  try
    dialog.GoodsTypeID := IBCQueryGoodsType.FieldByName('GOODSTYPEID').AsInteger;
    if dialog.ShowModal = mrOk then
      IBCQueryGoodsType.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
      (Self) then
      Self.Position := poDesigned;

    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGoodsTypeTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsTypeDlg.bbSearchClick(Sender: TObject);
begin
  if fInSearch then begin
    bbSearch.Caption := 'Cautare';
    fInSearch := False;
    IBCQueryGoodsType.Active := False;
    IBCQueryGoodsType.FilterSQL := '';
    IBCQueryGoodsType.Active := True;
  end
  else
    ShowSearchDialog;
end;

constructor TfrmGoodsTypeDlg.Create(AOwner: TComponent);
begin
  inherited;
  fDefaultGoodsTypeID := -1;
  FSelectMode := False;
end;

procedure TfrmGoodsTypeDlg.dxBarButton2Click(Sender: TObject);
begin
  IBCQueryGoodsType.UpdateTransaction.StartTransaction;
  IBCQueryGoodsType.Edit;
  IBCQueryGoodsType.FieldByName('FLG_FEED').AsInteger := (1 - IBCQueryGoodsType.FieldByName('FLG_FEED').AsInteger);
  IBCQueryGoodsType.Post;
  IBCQueryGoodsType.UpdateTransaction.Commit;
end;

procedure TfrmGoodsTypeDlg.FormActivate(Sender: TObject);
begin
//  TcxGridFindPanelAccess(TcxGridTableControllerAccess(cxGridGoodsTypeTable.Controller).FindPanel).Edit.SetFocus;
end;

procedure TfrmGoodsTypeDlg.NavigateSearch(const WhereCondition: string);
begin
  IBCQueryGoodsType.Active := False;
  IBCQueryGoodsType.FilterSQL := WhereCondition;
  IBCQueryGoodsType.Active := True;
  fInSearch := True;
  bbSearch.Caption := 'Vizualizeaza toate elementele';
end;

procedure TfrmGoodsTypeDlg.Prepare;
begin
  if not FSelectMode then begin
    btnOk.Visible := False;
  end;

  IBCQueryGoodsType.Active := False;
//  IBCQueryGoodsType.SQL.Clear();
//  IBCQueryGoodsType.SQL.Add('SELECT');
//  IBCQueryGoodsType.SQL.Add('gt.GOODSTYPEID,');
//  IBCQueryGoodsType.SQL.Add('gt.SHORT_TITLE,');
//  IBCQueryGoodsType.SQL.Add('gt.TITLE,');
//  IBCQueryGoodsType.SQL.Add('gt.TITLE_RUS,');
//  IBCQueryGoodsType.SQL.Add('gt.DESCRIPTION,');
//  IBCQueryGoodsType.SQL.Add('gt.SEARCH_KEYS,');
//  IBCQueryGoodsType.SQL.Add('gt.WEB_NAME_MODEL_RO,');
//  IBCQueryGoodsType.SQL.Add('gt.WEB_NAME_MODEL_RU,');
//  IBCQueryGoodsType.SQL.Add('gt.FLG_LANG_UNIQUE,');
//  IBCQueryGoodsType.SQL.Add('gt.USERID,');
//  IBCQueryGoodsType.SQL.Add('(SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=Gt.USERID) USER_NAME,');
//  IBCQueryGoodsType.SQL.Add('gt.MODEL_EX,');
//  IBCQueryGoodsType.SQL.Add('gt.PARAM_EX,');
//  IBCQueryGoodsType.SQL.Add('gt.AUX_EX,');
//  IBCQueryGoodsType.SQL.Add('gt.FLG_FEED,');
//  IBCQueryGoodsType.SQL.Add('IIF(EXISTS(SELECT 1 FROM TS_GOODS_TYPE_IMAGE A WHERE OCTET_LENGTH(A.IMAGE) > 0 AND A.GOODSTYPEID = Gt.GOODSTYPEID),1,0) FLG_DEF_IMAGE,');
//  IBCQueryGoodsType.SQL.Add('IIF(EXISTS(SELECT 1 FROM TS_GOODS_TYPE_IMAGE A WHERE OCTET_LENGTH(A.MENU_IMAGE)>0 AND A.GOODSTYPEID = Gt.GOODSTYPEID),1,0) FLG_MENU_IMAGE, ');
//  IBCQueryGoodsType.SQL.Add('goods_folderid, goods_folder_title');
//
//  if cxGridGoodsTypeTable_COUNT_GOODS.Visible then
//    IBCQueryGoodsType.SQL.Add(', (select count(goodsid) from ts_goods g where g.webgoodstype_id=gt.goodstypeid and get_flg_in_price(g.goodsid)=1) count_goods');
//
//  IBCQueryGoodsType.SQL.Add('FROM');
//  IBCQueryGoodsType.SQL.Add('vw_TS_GOODS_TYPE Gt');
//  IBCQueryGoodsType.SQL.Add('WHERE');
//  IBCQueryGoodsType.SQL.Add('(GOODSTYPEID<>-1)');
//  IBCQueryGoodsType.SQL.Add('ORDER BY TITLE');


  IBCQueryGoodsType.Active := True;
  if (fDefaultGoodsTypeID <> -1) then
    IBCQueryGoodsType.Locate('GOODSTYPEID', fDefaultGoodsTypeID, []);

  SelectionChanged;
  cxGridGoodsType_TITLE.Focused := True;
end;

procedure TfrmGoodsTypeDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    // store column visibility and width
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGoodsTypeTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;

end;

function TfrmGoodsTypeDlg.SelectGoodsType(AGoodsTypeID: Integer): Boolean;
begin
  FSelectMode := True;
  fDefaultGoodsTypeID := AGoodsTypeID;
  if (ShowModal = mrOK) then begin
    Result := True;
    fGoodsTypeID := IBCQueryGoodsType.FieldByName('GOODSTYPEID').AsInteger;
    fGoodsTypeTitle := IBCQueryGoodsType.FieldByName('TITLE').AsString;
  end
  else begin
    Result := False;
    fGoodsTypeID := -1;
    fGoodsTypeTitle := '';
  end;

end;

procedure TfrmGoodsTypeDlg.SelectionChanged;
var
  fNew, fModify, fDelete: Boolean;
begin
  fNew := True;
  fModify := False;
  fDelete := False;
  if cxGridGoodsTypeTable.DataController.RecNo > 0 then begin
    fModify := True;
    fDelete := True;
  end;
  bbNewType.Enabled := fNew;
  bbModify.Enabled := fModify;
  bbDelete.Enabled := fDelete;
  bbNPSC.Enabled := fModify;
end;

procedure TfrmGoodsTypeDlg.SelectItem;
begin
  fGoodsTypeID := IBCQueryGoodsType.FieldByName('GOODSTYPEID').AsInteger;
  fGoodsTypeTitle := IBCQueryGoodsType.FieldByName('TITLE_RUS').AsString;
  ModalResult := mrOk;
end;

procedure TfrmGoodsTypeDlg.SetDefaultGoodsTypeID(const Value: integer);
begin
  fDefaultGoodsTypeID := Value;
end;

procedure TfrmGoodsTypeDlg.SetGoodsTypeID(const Value: integer);
begin
  FGoodsTypeID := Value;
end;

procedure TfrmGoodsTypeDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmGoodsTypeDlg.SetupSecurityItems;
begin
  if SWNSecurityManager.IsLimitedUser then begin
    bbDelete.Visible := ivNever;
    dxBarSubItemNPSC.Visible := ivNever;
    bbMergeGoodsType.Visible := ivNever;
    bbModify.Visible := ivNever;
    bbNewType.Visible := ivNever;
  end
end;

procedure TfrmGoodsTypeDlg.ShowCloneNPSCDialog;
var
  dialog: TfrmGoodsTypeNPSC_Clone_Dlg;
begin
  dialog := TfrmGoodsTypeNPSC_Clone_Dlg.Create(Self, IBCQueryGoodsType, IBCDataSourceGoodsType);
  try
    if dialog.ShowModal = mrOk then begin
      if DoCloneNPSCProps(dialog.SourceGoodsTypeID, dialog.TargetGoodsTypeID) then
        ShowInfoDialog('Copierea tipizarii', 'Terminat!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.ShowCreateNewTypeDialog;
var
  dialog: TfrmGoodsTypeEditorDlg;
begin
  dialog := TfrmGoodsTypeEditorDlg.Create(Self, IBCQueryGoodsType, IBCDataSourceGoodsType);
  try
    dialog.CreateNewType := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.ShowModifyTypeDialog;
var
  dialog: TfrmGoodsTypeEditorDlg;
begin
  dialog := TfrmGoodsTypeEditorDlg.Create(Self, IBCQueryGoodsType, IBCDataSourceGoodsType);
  try
    dialog.CreateNewType := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.ShowNPSCDialog;
var
  dialog: TfrmGoodsTypeNPSCDlg;
begin
  dialog := TfrmGoodsTypeNPSCDlg.Create(Self, IBCQueryGoodsType, IBCDataSourceGoodsType);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsTypeDlg.ShowSearchDialog;
var
  Search: TSWNSearchDialog;
  SearchInWhere: string;
  SC: TSearchCriteria;
  toSearch: Boolean;
  S: string;
begin
  toSearch := False;
  SearchInWhere := '';

  Search := TSWNSearchDialog.Create(Self);
  try
    if Search.GetSearchCritera(stGoodsType) then begin
      SC := Search.SearchCriterias[0];
      S := Trim(SC.SearchText);
      AddConditionToWHERE(SearchInWhere, Format('(TITLE CONTAINING ''%s'') OR (TITLE_RUS CONTAINING ''%s'') OR (SEARCH_KEYS CONTAINING ''%s'')',
        [S, S, S]));
      toSearch := True;
    end;
  finally
    Search.Free;
  end;

  if toSearch then
    NavigateSearch(SearchInWhere);
end;

end.


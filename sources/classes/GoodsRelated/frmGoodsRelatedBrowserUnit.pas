unit frmGoodsRelatedBrowserUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, cxStyles, cxCustomData, cxGraphics, DB, cxDBData, Menus, dxBar,
  IBC, StdCtrls, cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, ExtCtrls, DialogTitle, cxCalc,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxImageComboBox, cxCurrencyEdit, DBAccess, MemDS, cxClasses, Vcl.Buttons,
  cxCheckBox;

type
  TOnMultiAddRelatedGoods = procedure(const GoodsID: integer; RelatedKey: string) of object;

  TfrmGoodsRelatedDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbRemove: TdxBarButton;
    IBCDataSourceRelatedKeys: TIBCDataSource;
    IBCTrLocalUpdate: TIBCTransaction;
    bbHome: TdxBarButton;
    bbBack: TdxBarButton;
    bbForward: TdxBarButton;
    bbNewFolder: TdxBarButton;
    bbSearch: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    pnBottom: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    Panel2: TPanel;
    IBCQueryGoodsRelatedGoods: TIBCQuery;
    IBCDataSourceRelatedGoods: TIBCDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1RELATED_KEY: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Panel3: TPanel;
    Panel4: TPanel;
    cxGridGoodsAcnt: TcxGrid;
    cxGridGoodsRelatedKeys: TcxGridDBTableView;
    cxGridGoodsRelatedKeysFolder: TcxGridDBColumn;
    cxGridGoodsRelated_Key: TcxGridDBColumn;
    cxGridGoodsRelatedKeysTitle: TcxGridDBColumn;
    cxGridGoodsAcntLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarDockControl3: TdxBarDockControl;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1_GOODSID: TcxGridDBColumn;
    cxGridDBTableView1_TITLE: TcxGridDBColumn;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    bbAddSelectedKeys: TdxBarButton;
    bbDeleteKey: TdxBarButton;
    bbRefreshGoods: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    bbRefreshRelatedKeys: TdxBarButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleExistKey: TcxStyle;
    IBCQueryRelatedKeys: TIBCQuery;
    cxGridDBTableView1_PRICE: TcxGridDBColumn;
    cxGridDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    IBCDataSourceResultGoods: TIBCDataSource;
    IBCQueryResultGoods: TIBCQuery;
    cxGrid3: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGrid1DBTableView1_GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1_WEBGOODSTYPE: TcxGridDBColumn;
    cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1_PRICE_MDL: TcxGridDBColumn;
    cxGrid1DBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    procedure bbForwardClick(Sender: TObject);
    procedure bbBackClick(Sender: TObject);
    procedure bbHomeClick(Sender: TObject);
    procedure cxGridGoodsRelatedKeysCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridGoodsRelatedKeysFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridGoodsAcnt_PRICE_ACNTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridGoodsRelatedKeysTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbRefreshRelatedKeysClick(Sender: TObject);
    procedure cxGridGoodsRelatedKeysStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbAddSelectedKeysClick(Sender: TObject);
    procedure bbDeleteKeyClick(Sender: TObject);
    procedure cxGridDBTableView2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbRefreshGoodsClick(Sender: TObject);
    procedure cxGridGoodsRelatedKeysKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    { Private declarations }
    fCurrentParent_Key: string;
    FRelatedKey: string;
    fRootParentKey: string;
    fInSearch: Boolean;
    fSelectMode: Boolean;
    fItemsChanged: Boolean;
    FRelatedKeyTitle: string;
    // security flags
    cSecurityFlag_CanModify_Folder, cSecurityFlag_CanModify_Item, cSecurityFlag_CanDelete_Folder, cSecurityFlag_CanDelete_Item: Boolean;
    FGoodsID: Integer;
    FGoodsModel: string;
    FGoodsTypeID: Integer;
    FOnMultiAddRelatedGoods: TOnMultiAddRelatedGoods;
    FVendorName: string;
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateTo(const RelatedKey: string);
    procedure NavigateSearch(const WhereConditions: string);
    procedure NavigateToHome(const RootID: string);
    procedure EnableCondition(const ConditionIndex: Integer; const CustomCondition: string = '');
    procedure SelectedRecordChanged;
    procedure SetSelectMode(const Value: Boolean);
    function ItemSelected: Boolean;
    procedure ShowCreateNewItemDialog;
    procedure ShowModifyCurrentItemDialog;
    procedure DeleteCurrentItem;
    procedure ShowCreateNewFolderDialog(IsNewRecord: Boolean);
    procedure ShowSortFoldersDialog;
    procedure CopyCellTextToClipboard;
    procedure RefreshGoodsRelatedKeys;
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsModel(const Value: string);
    procedure SetGoodsTypeID(const Value: Integer);
    procedure SetOnMultiAddRelatedGoods(const Value: TOnMultiAddRelatedGoods);
    procedure SetRelatedKey(const Value: string);
    procedure SetupQtyFields;
    procedure SetVendorName(const Value: string);
  protected
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure PasteFromClipboard;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    function SelectGoodsRelatedKey(const DefaultRelatedKey: string = ''): Boolean;
    procedure BrowseGoodsRelatedKeys(AGoodsID: Integer; AGoodsModel, AVendorName: string; const AParentRelatedKey: string = '');
    function FoundRelatedKey(RelatedKey: string): Boolean;
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    property GoodsModel: string read FGoodsModel write SetGoodsModel;
    property RelatedKey: string read FRelatedKey write SetRelatedKey;
    property RelatedKeyTitle: string read FRelatedKeyTitle;
    property GoodsTypeID: Integer read FGoodsTypeID write SetGoodsTypeID;
    property SelectMode: Boolean read fSelectMode write SetSelectMode;
    property ItemsChanged: Boolean read fItemsChanged;
    property VendorName: string read FVendorName write SetVendorName;
  published
    property OnMultiAddRelatedGoods: TOnMultiAddRelatedGoods read
        FOnMultiAddRelatedGoods write SetOnMultiAddRelatedGoods;
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, frmGoodsAcntFolderDialog,
  frmGoodsAcntEditorDialog, DataModuleDB, ClipBrd, SWNSearchUnit,
  frmChangeParentFolderDialog, frmChangeOrderNoDialog, SWNValueStorageUnit,
  SWNSecurityFlags, SWNDBErrors, frmGoodsFromAcnt, frmGoodsInfoCardDialog,
  SWNConst, frmGoodsRelatedKeysFolderUnit, frmGoodsRelatedKeyEditorUnit,
  Vcl.Dialogs;

{$R *.dfm}

procedure TfrmGoodsRelatedDlg.bbAddSelectedKeysClick(Sender: TObject);
var
  i: Integer;
  Query: TIBCQuery;
  S: string;
begin
  Query := TIBCQuery.Create(nil);
  try
    for i := 0 to cxGridGoodsRelatedKeys.Controller.SelectedRowCount - 1 do begin
      if i = 0 then
        S := cxGridGoodsRelatedKeys.Controller.SelectedRows[i].Values[cxGridGoodsRelated_Key.Index]
      else
        S := S + ', ' + cxGridGoodsRelatedKeys.Controller.SelectedRows[i].Values[cxGridGoodsRelated_Key.Index];
    end;
    Query.Transaction := IBCTrLocalUpdate;
    if not IBCTrLocalUpdate.Active then
      IBCTrLocalUpdate.StartTransaction;

    Query.SQL.Text := 'execute procedure update_related_keys(:goodsid, :list)';
    Query.parambyname('goodsid').Asinteger := FGoodsID;
    Query.parambyname('list').AsString := S;
    Query.Execute;

    IBCTrLocalUpdate.Commit;
    RefreshGoodsRelatedKeys;
    IBCQueryRelatedKeys.Refresh;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.bbBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmGoodsRelatedDlg.bbDeleteKeyClick(Sender: TObject);
begin
  if MessageDlg('Stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    IBCQueryGoodsRelatedGoods.Delete;
  end;
end;

procedure TfrmGoodsRelatedDlg.bbForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmGoodsRelatedDlg.bbHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentKey);
end;

procedure TfrmGoodsRelatedDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyCurrentItemDialog;
end;

procedure TfrmGoodsRelatedDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewItemDialog;
end;

procedure TfrmGoodsRelatedDlg.bbNewFolderClick(Sender: TObject);
begin
  ShowCreateNewFolderDialog(True);
end;

procedure TfrmGoodsRelatedDlg.bbRefreshGoodsClick(Sender: TObject);
begin
  IBCQueryResultGoods.Close;
  IBCQueryResultGoods.Open;
end;

procedure TfrmGoodsRelatedDlg.bbRefreshRelatedKeysClick(Sender: TObject);
begin
  RefreshGoodsRelatedKeys;
end;

procedure TfrmGoodsRelatedDlg.bbRemoveClick(Sender: TObject);
begin
  DeleteCurrentItem;
end;

procedure TfrmGoodsRelatedDlg.bbSearchClick(Sender: TObject);
var
  search: TSWNSearchDialog;
  i: Integer;
  Criteria: TSearchCriteria;
  S: string;
begin
  S := '';
  search := TSWNSearchDialog.Create(Self);
  try
    if search.GetSearchCritera(stGoodsACNT) then begin
      for i := 0 to search.SearchCriteriasCount - 1 do begin
        Criteria := search.SearchCriterias[i];
        case Criteria.SearchField of
          sfID:
            AddConditionToWhere(S, 'A.RELATED_KEY=' + Criteria.SearchText);
          sfName:
            AddConditionToWhere(S, 'UPPER(A.RELATED_KEY) LIKE ' + PrepareTextForLIKE(Criteria.SearchText));
        end;
      end;
    end;
  finally
    search.Free;
  end;

  if (S <> '') then
    NavigateSearch(S);
end;

procedure TfrmGoodsRelatedDlg.BrowseGoodsRelatedKeys(AGoodsID: Integer; AGoodsModel, AVendorName: string; const AParentRelatedKey: string);
begin
  fRootParentKey := AParentRelatedKey;

//  SelectMode := False;
  if SelectMode then begin
    btnCancel.Caption := 'Renunta';
    btnOk.ModalResult := mrOk;
  end
  else
    btnCancel.Caption := 'Inchide';

  GoodsModel := AGoodsModel;
  VendorName := AVendorName;
  GoodsID := AGoodsID;
  ShowModal;
end;

procedure TfrmGoodsRelatedDlg.btnOkClick(Sender: TObject);
begin
  if ItemSelected and fSelectMode then
    ModalResult := mrOk;
end;

procedure TfrmGoodsRelatedDlg.CopyCellTextToClipboard;
var
  RecordIndex: Integer;
begin
  if cxGridGoodsRelatedKeys.DataController.FocusedRowIndex >= 0 then begin
    RecordIndex := cxGridGoodsRelatedKeys.DataController.GetRowInfo(cxGridGoodsRelatedKeys.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := cxGridGoodsRelatedKeys.DataController.GetDisplayText(RecordIndex, cxGridGoodsRelatedKeys.Controller.FocusedColumn.Index);
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridDBTableView2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGridDBTableView2, Key, Shift);
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsRelatedKeysCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (ssLeft in AShift) and (ssDouble in AShift) then begin
    if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
      NavigateForward
    else if ItemSelected and fSelectMode then
      ModalResult := mrOk;
    AHandled := True;
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcnt_PRICE_ACNTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridGoodsRelatedKeysFolder.Index]) then begin
    if ARecord.Values[cxGridGoodsRelatedKeysFolder.Index] = 1 then
      AText := '';
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsRelatedKeysFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectedRecordChanged;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsRelatedKeysKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
  // VK_enter
  if (Key = 13) and (Shift = []) then begin
    if (cxGridGoodsRelatedKeys.DataController.RecNo > 0) then begin
      if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
        NavigateForward
      else if ItemSelected then begin
        Key := 0;
        Shift := [];
        ModalResult := mrOk;
      end;

    end;
  end;

  // Ctrl+C
  // copy cell content in clipboard
  if (Key = 67) and (Shift = [ssCtrl]) then begin
    CopyCellTextToClipboard;
    Key := 0;
    Shift := [];
  end;
end;

procedure TfrmGoodsRelatedDlg.DeleteCurrentItem;
var
  Title: string;
  Text: string;
begin
  if (IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1) then begin
    Title := 'Sterge mapa';
    Text := 'Doriti sa stergeti mapa "' + IBCQueryRelatedKeys.FieldByName('TITLE').AsWideString + '" ?';
  end
  else begin
    Title := 'Stergerea cheia pentru produs';
    Text := 'Doriti sa stergeti ' + #13#10 + IBCQueryRelatedKeys.FieldByName('TITLE').AsWideString + ' ?';
  end;

  if ShowAskDialog(Title, Text) = mrYes then begin
    try
      IBCQueryRelatedKeys.Delete;
      IBCQueryRelatedKeys.UpdateTransaction.Commit;
      fItemsChanged := True;
    except
      on E: Exception do begin
        IBCQueryRelatedKeys.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsRelatedKeysStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridGoodsRelated_Key.Index] <> Null then
    if FoundRelatedKey(ARecord.Values[cxGridGoodsRelated_Key.Index]) then begin
      AStyle := cxStyleExistKey;
    end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsRelatedKeysTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridGoodsRelatedKeysFolder.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmGoodsRelatedDlg.EnableCondition(const ConditionIndex: Integer; const CustomCondition: string);
begin
  fInSearch := False;
  IBCQueryRelatedKeys.Close;
  case ConditionIndex of
     // forward
    0:
      IBCQueryRelatedKeys.FilterSQL := 'A.PARENT_KEY=:Parent_KEY';
     // backward
    1:
      IBCQueryRelatedKeys.FilterSQL := 'A.PARENT_KEY=(SELECT PARENT_KEY FROM TS_RELATED_KEYS WHERE RELATED_KEY=:PARENT_KEY)';
     // search
    2:
      IBCQueryRelatedKeys.FilterSQL := CustomCondition;
  end;
//  IBCQueryRelatedKeys.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
end;

procedure TfrmGoodsRelatedDlg.FormCreate(Sender: TObject);
begin
  FRelatedKey := '';
  fRootParentKey := '';
  fInSearch := False;
  fCurrentParent_Key := '';
  fSelectMode := True;
  fItemsChanged := False;
end;

function TfrmGoodsRelatedDlg.FoundRelatedKey(RelatedKey: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to cxGrid1DBTableView1.DataController.RecordCount - 1 do begin
    if cxGrid1DBTableView1.DataController.Values[I, cxGrid1DBTableView1RELATED_KEY.Index] = RelatedKey then begin
      result := True;
      Break;
    end;
  end;

end;

function TfrmGoodsRelatedDlg.IsFormDataPosted: Boolean;
begin
  if Assigned(FOnMultiAddRelatedGoods) then
    FOnMultiAddRelatedGoods(GoodsID, IBCQueryRelatedKeys.FieldByName('RELATED_KEY').AsString);

  Result := True;
end;

function TfrmGoodsRelatedDlg.ItemSelected: Boolean;
begin
  Result := False;
  if (cxGridGoodsRelatedKeys.DataController.RecNo > 0) and (IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 0) then begin
    if fSelectMode then begin
      FRelatedKey := IBCQueryRelatedKeys.FieldByName('RELATED_KEY').AsString;
      FRelatedKeyTitle := IBCQueryRelatedKeys.FieldByName('TITLE').AsString;
      Result := True;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGoodsRelatedKeys);
end;

procedure TfrmGoodsRelatedDlg.NavigateBack;
var
  ParentID: string;
  RelatedKey: string;
begin
  RelatedKey := '';
  if IBCQueryRelatedKeys.Eof then begin
          // no records
    if fCurrentParent_Key = '' then
      ParentID := fRootParentKey
    else
      ParentID := fCurrentParent_Key;
  end
  else begin
    ParentID := IBCQueryRelatedKeys.FieldByName('PARENT_KEY').AsString;
    if ParentID = '' then
      RelatedKey := IBCQueryRelatedKeys.FieldByName('RELATEDKEY').AsString;
  end;

  EnableCondition(1); // Browse Backward
  if (RelatedKey <> '') then
    IBCQueryRelatedKeys.ParamByName('PARENT_KEY').AsString := RelatedKey
  else
    IBCQueryRelatedKeys.ParamByName('PARENT_KEY').AsString := ParentID;
  IBCQueryRelatedKeys.Open;
  fCurrentParent_Key := IBCQueryRelatedKeys.FieldByName('PARENT_KEY').AsString;
  if (RelatedKey <> '') then
    IBCQueryRelatedKeys.Locate('RELATED_KEY', RelatedKey, [])
  else
    IBCQueryRelatedKeys.Locate('RELATED_KEY', ParentID, []);
end;

procedure TfrmGoodsRelatedDlg.NavigateForward;
var
  ParentID: string;
begin
  if (IBCQueryRelatedKeys.RecordCount = 0) then
    ParentID := ''
  else
    ParentID := IBCQueryRelatedKeys.FieldByName('Related_Key').AsString;

  EnableCondition(0); // Browse Forward
  IBCQueryRelatedKeys.ParamByName('PARENT_KEY').AsString := ParentID;
  fCurrentParent_Key := ParentID;
//  IBCQueryRelatedKeys.ParamByName('GOODSID').AsInteger := GOODSID;
  IBCQueryRelatedKeys.Open;
end;

procedure TfrmGoodsRelatedDlg.NavigateSearch(const WhereConditions: string);
begin
  EnableCondition(2, WhereConditions); // Search
  fInSearch := True;
  IBCQueryRelatedKeys.Open;
  fCurrentParent_Key := '';
end;

procedure TfrmGoodsRelatedDlg.NavigateTo(const RelatedKey: string);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryRelatedKeys.ParamByName('Parent_KEY').AsString := RelatedKey;
//  IBCQueryRelatedKeys.ParamByName('GOODSID').AsInteger := GOODSID;
  IBCQueryRelatedKeys.Open;
  IBCQueryRelatedKeys.Locate('RELATED_KEY', RelatedKey, []);
  fCurrentParent_Key := IBCQueryRelatedKeys.FieldByName('Parent_KEY').AsString;
end;

procedure TfrmGoodsRelatedDlg.NavigateToHome(const RootID: string);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryRelatedKeys.ParamByName('Parent_KEY').AsString := RootID;
//  IBCQueryRelatedKeys.ParamByName('GOODSID').AsInteger := GOODSID;
  fCurrentParent_Key := RootID;
  IBCQueryRelatedKeys.Open;
end;

procedure TfrmGoodsRelatedDlg.PasteFromClipboard;
var
  i: Integer;
  list: TStringList;
begin
  list := TStringList.Create;
  try
    list.Text := ClipBrd.Clipboard.AsText;
    IBCTrLocalUpdate.StartTransaction;
    for i := 0 to list.Count - 1 do begin
      IBCQueryRelatedKeys.Append;
      IBCQueryRelatedKeys.FieldByName('TITLE').AsString := list[i];
      IBCQueryRelatedKeys.FieldByName('PARENT_KEY').AsString := fCurrentParent_Key;
      IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger := 0;
      IBCQueryRelatedKeys.Post;
    end;
    IBCTrLocalUpdate.Commit;
  finally
    list.free;
  end;
end;

procedure TfrmGoodsRelatedDlg.Prepare;
begin
  SetupSecurityItems;
  SetupQtyFields;
  IBCQueryGoods.Open;

//  IBCQueryRelatedKeys.ParamByName('GOODSID').AsInteger := GOODSID;
  if not fSelectMode then begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end
  else
    btnOk.ModalResult := mrOk;

  if FRelatedKey <> '' then
    NavigateTo(FRelatedKey)
  else begin
    if fRootParentKey <> '' then
      NavigateToHome(fRootParentKey)
    else
      NavigateForward;
  end;

  RefreshGoodsRelatedKeys;

  SelectedRecordChanged;
     // default focused column
  cxGridGoodsRelatedKeysTitle.Selected := True;
  cxGridGoodsRelated_Key.Focused := True;

  cxGridGoodsRelatedKeys.DataController.DataModeController.GridMode := True;
  cxGridGoodsRelatedKeys.DataController.DataModeController.GridModeBufferCount := 50;
  cxGridGoodsRelatedKeys.DataController.DataModeController.SyncMode := True;
end;

procedure TfrmGoodsRelatedDlg.RefreshGoodsRelatedKeys;
begin
  IBCQueryGoodsRelatedGoods.Close;
  IBCQueryGoodsRelatedGoods.ParamByName('GOODSID').AsInteger := FGoodsID;
  IBCQueryGoodsRelatedGoods.Open;
  IBCQueryResultGoods.Close;
  IBCQueryResultGoods.ParamByName('GOODSID').AsInteger := FGoodsID;
  IBCQueryResultGoods.Open;
end;

procedure TfrmGoodsRelatedDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGoodsRelatedKeys);
end;

procedure TfrmGoodsRelatedDlg.SelectedRecordChanged;
var
  fForward, fBack, fHome: Boolean;
  fNewFolder, fNewItem, fModify, fDelete: Boolean;
  fSortFolders, fChangeParent, fRelatedGoods, fInfoCard: Boolean;
  FLG_FOLDER: Boolean;
begin
  fForward := False;

  fNewFolder := not fInSearch; // new Folder
  fNewItem := not fInSearch; // New GoddsACNT
  fModify := False;
  fDelete := False;

  fSortFolders := False;
  fChangeParent := False;
  fRelatedGoods := False;
  fInfoCard := False;

  if Assigned(cxGridGoodsRelatedKeys) and (cxGridGoodsRelatedKeys.DataController.RecNo > 0) then begin
    FLG_FOLDER := IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1;

    if FLG_FOLDER then begin
      fForward := True;
      fModify := cSecurityFlag_CanModify_Folder; // Modify
      fDelete := cSecurityFlag_CanDelete_Folder; // Remove
    end
    else begin
      fModify := cSecurityFlag_CanModify_Item; // Modify
      fDelete := cSecurityFlag_CanDelete_Item; // Remove
      fRelatedGoods := True;
      fInfoCard := True;
    end;
    fBack := (fCurrentParent_Key <> '') and (fCurrentParent_Key <> fRootParentKey) or fInSearch;
    fHome := fBack or (fRootParentKey <> '');

    fSortFolders := not fInSearch;  // Sort Folders
    fChangeParent := not fInSearch; // Change Parent
  end
  else begin
    fBack := (fCurrentParent_Key <> '') and (fRootParentKey <> fCurrentParent_Key);
    fHome := fBack or (fRootParentKey = '');
  end;

  // navigation
  bbHome.Enabled := fHome;
  bbForward.Enabled := fForward;
  bbBack.Enabled := fBack;

  bbNewFolder.Enabled := fNewFolder;
  bbNew.Enabled := fNewItem;
  bbModify.Enabled := fModify;
  bbRemove.Enabled := fDelete;

//  bbRelatedGoods.Enabled := fRelatedGoods;
end;

function TfrmGoodsRelatedDlg.SelectGoodsRelatedKey(const DefaultRelatedKey: string): Boolean;
begin
  RelatedKey := DefaultRelatedKey;
//  SelectMode := True;
  Result := (ShowModal = mrOk);
end;

procedure TfrmGoodsRelatedDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

procedure TfrmGoodsRelatedDlg.SetGoodsModel(const Value: string);
begin
  FGoodsModel := Value;
end;

procedure TfrmGoodsRelatedDlg.SetGoodsTypeID(const Value: Integer);
begin
  FGoodsTypeID := Value;
end;

procedure TfrmGoodsRelatedDlg.SetOnMultiAddRelatedGoods(const Value:
    TOnMultiAddRelatedGoods);
begin
  FOnMultiAddRelatedGoods := Value;
end;

procedure TfrmGoodsRelatedDlg.SetRelatedKey(const Value: string);
begin
  FRelatedKey := Value;
end;

procedure TfrmGoodsRelatedDlg.SetSelectMode(const Value: Boolean);
begin
  fSelectMode := Value;
end;

procedure TfrmGoodsRelatedDlg.SetupQtyFields;
//var
//  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
//  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
//  TcxCalcEditProperties(cxGridGoodsAcnt_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
//  TcxCalcEditProperties(cxGridGoodsAcnt_QTY_STOCK.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmGoodsRelatedDlg.SetupSecurityItems;
begin
     // cSecurityFlag_Справочники_Наименование_для_накладных
  cSecurityFlag_CanModify_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Изменение_папки);
  cSecurityFlag_CanModify_Item := SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной);

  if not (cSecurityFlag_CanModify_Folder or cSecurityFlag_CanModify_Item) then
    bbModify.Visible := ivNever;

  cSecurityFlag_CanDelete_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Удаление_папки);
  cSecurityFlag_CanDelete_Item := SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Удаление_наименования_для_накладной);

  if not (cSecurityFlag_CanDelete_Folder or cSecurityFlag_CanDelete_Item) then
    bbRemove.Visible := ivNever;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Создание_папки) then
    bbNewFolder.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Создание_наименования_для_накладной) then
    bbNew.Visible := ivNever;

end;

procedure TfrmGoodsRelatedDlg.SetVendorName(const Value: string);
begin
  FVendorName := Value;
end;

procedure TfrmGoodsRelatedDlg.ShowCreateNewItemDialog;
var
  dialog: TfrmGoodsRelatedKeyEditorDlg;
begin
  dialog := TfrmGoodsRelatedKeyEditorDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceRelatedKeys);
  try
    dialog.ParentID := fCurrentParent_Key;
    dialog.CreateNewItem := True;
    dialog.GoodsModel := GoodsModel;
    dialog.VendorName := VendorName;
    if dialog.ShowModal = mrOk then begin
//      fItemsChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowCreateNewFolderDialog(IsNewRecord: Boolean);
var
  dialog: TfrmGoodsRelatedKeysFolderDlg;
begin
  dialog := TfrmGoodsRelatedKeysFolderDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceRelatedKeys);
  try
    dialog.ParentKey := fCurrentParent_Key;
    dialog.CreateNewFolder := IsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowModifyCurrentItemDialog;
var
//  dialogFolder: TfrmGoodsRelatedKeysFolderDlg;
  dialogItem: TfrmGoodsRelatedKeyEditorDlg;
begin
  if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then begin
    ShowCreateNewFolderDialog(False);
  end
  else begin
    dialogItem := TfrmGoodsRelatedKeyEditorDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceRelatedKeys);
    try
      dialogItem.ShowModal;
      IBCQueryRelatedKeys.Refresh;
    finally
      dialogItem.Free;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowSortFoldersDialog;
//var
//  dialog: TfrmChangeOrderNoDlg;
begin
//  dialog := TfrmChangeOrderNoDlg.Create(Self);
//  try
//    dialog.DBTable := cotGOODSACNT;
//    dialog.ParentID := fCurrentParent_Key;
//    if dialog.ShowModal = mrOk then
//    begin
//      IBCQueryRelatedKeys.Close;
//      IBCQueryRelatedKeys.Open;
//    end;
//  finally
//    dialog.Free;
//  end;
end;

end.


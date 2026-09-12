unit frmGoodsACNTBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, cxStyles, cxCustomData, cxGraphics,
  DB, cxDBData, Menus,
  dxBar, IBC, StdCtrls,
  cxButtons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, ExtCtrls, DialogTitle,
  cxCalc, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCurrencyEdit, DBAccess, MemDS, cxClasses;

type
  TfrmGoodsRelatedDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGoodsAcnt: TcxGrid;
    cxGridGoodsAcntTable: TcxGridDBTableView;
    cxGridGoodsAcntLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbRemove: TdxBarButton;
    IBCDataSourceRelatedKeys: TIBCDataSource;
    IBCQueryRelatedKeys: TIBCQuery;
    IBCTrLocalUpdate: TIBCTransaction;
    cxGridGoodsAcnt_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridGoodsAcntTableTitle: TcxGridDBColumn;
    cxGridGoodsAcntTableFolder: TcxGridDBColumn;
    bbHome: TdxBarButton;
    bbBack: TdxBarButton;
    bbForward: TdxBarButton;
    bbNewFolder: TdxBarButton;
    bbSearch: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbItem: TdxBarSubItem;
    bbAdditionalTools: TdxBarSubItem;
    bbChangeParent: TdxBarButton;
    bbSortFolders: TdxBarButton;
    pnBottom: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    cxGridGoodsAcnt_QTY: TcxGridDBColumn;
    bbRelatedGoods: TdxBarButton;
    bbGoodsInfoCard: TdxBarButton;
    cxGridGoodsAcnt_LOW_BOUND: TcxGridDBColumn;
    cxGridGoodsAcnt_HIGH_BOUND: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    procedure bbForwardClick(Sender: TObject);
    procedure bbBackClick(Sender: TObject);
    procedure bbHomeClick(Sender: TObject);
    procedure cxGridGoodsAcntTableKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsAcntTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbNewFolderClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridGoodsAcntTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbSearchClick(Sender: TObject);
    procedure bbChangeParentClick(Sender: TObject);
    procedure bbSortFoldersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridGoodsAcnt_PRICE_ACNTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbRelatedGoodsClick(Sender: TObject);
    procedure cxGridGoodsAcntTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridGoodsAcntTableTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fCurrentParent_Key: String;
    FRelatedKey: string;
    fRootParentID: String;
    fInSearch: Boolean;
    fSelectMode: Boolean;
    fItemsChanged: Boolean;
    FRelatedKeyTitle: string;
    // security flags
    cSecurityFlag_CanModify_Folder, cSecurityFlag_CanModify_Item, cSecurityFlag_CanDelete_Folder, cSecurityFlag_CanDelete_Item: Boolean;
    FGoodsTypeID: Integer;
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToGoodsAcnt(const RelatedKey: string);
    procedure NavigateSearch(const WhereConditions: string);
    procedure NavigateToHome(const RootID: string);
    procedure EnableCondition(const ConditionIndex: integer; const CustomCondition: string = '');
    procedure SelectedRecordChanged;
    procedure SetGoodsAcntID(const Value: integer);
    procedure SetSelectMode(const Value: Boolean);
    function ItemSelected: Boolean;
    procedure ShowCreateNewItemDialog;
    procedure ShowModifyCurrentItemDialog;
    procedure DeleteCurrentItem;
    procedure ShowCreateNewFolderDialog;
    procedure ShowChangeParentDialog;
    procedure ShowSortFoldersDialog;
    procedure CopyCellTextToClipboard;
    procedure SetGoodsTypeID(const Value: Integer);
    procedure SetRelatedKey(const Value: string);
    procedure ShowGoodsFromAcntCode(const acntCode: Integer);
    procedure ShowGoodsInfoCardDialog(const acntCode: integer; const acntName: string);
    procedure SetupQtyFields;
  protected
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure PasteFromClipboard;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    function SelectGoodsACNT(const DefaultGoodsAcntID: integer = -1): Boolean;
    procedure BrowseGoodsACNT(const DefaultGoodsAcntID: integer = -1; const
        DefaultGoodsTypeID: integer = -1);
    property RelatedKey: string read FRelatedKey write SetRelatedKey;
    property RelatedKeyTitle: string read FRelatedKeyTitle;
    property GoodsTypeID: Integer read FGoodsTypeID write SetGoodsTypeID;
    property SelectMode: Boolean read FSelectMode write SetSelectMode;
    property ItemsChanged: Boolean read fItemsChanged;
  end;

implementation

uses
  DataModuleAdditions, SWNUtils, frmGoodsAcntFolderDialog,
  frmGoodsAcntEditorDialog, DataModuleDB, ClipBrd, SWNSearchUnit,
  frmChangeParentFolderDialog, frmChangeOrderNoDialog, SWNValueStorageUnit,
  SWNSecurityFlags, SWNDBErrors, frmGoodsFromAcnt, frmGoodsInfoCardDialog,
  SWNConst;

{$R *.dfm}

procedure TfrmGoodsRelatedDlg.bbBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmGoodsRelatedDlg.bbChangeParentClick(Sender: TObject);
begin
  ShowChangeParentDialog;
end;

procedure TfrmGoodsRelatedDlg.bbForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmGoodsRelatedDlg.bbHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
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
  ShowCreateNewFolderDialog;
end;

procedure TfrmGoodsRelatedDlg.bbRemoveClick(Sender: TObject);
begin
  DeleteCurrentItem;
end;

procedure TfrmGoodsRelatedDlg.bbSearchClick(Sender: TObject);
var
  search: TSWNSearchDialog;
  i: integer;
  Criteria: TSearchCriteria;
  S: string;
begin
  S := '';
  search := TSWNSearchDialog.Create(Self);
  try
    if search.GetSearchCritera(stGoodsACNT) then
    begin
      for i := 0 to search.SearchCriteriasCount - 1 do
      begin
        Criteria := search.SearchCriterias[i];
        case Criteria.SearchField of
          sfID:
            AddConditionToWHERE(S, 'A.RELATED_KEY=' + Criteria.SearchText);
          sfName:
            AddConditionToWHERE(S, 'UPPER(A.RELATED_KEY) LIKE ' + PrepareTextForLIKE(Criteria.SearchText));
        end;
      end;
    end;
  finally
    search.Free;
  end;

  if (S <> '') then
    NavigateSearch(S);
end;

procedure TfrmGoodsRelatedDlg.bbSortFoldersClick(Sender: TObject);
begin
  ShowSortFoldersDialog;
end;

procedure TfrmGoodsRelatedDlg.BrowseGoodsACNT(const DefaultGoodsAcntID: integer =
    -1; const DefaultGoodsTypeID: integer = -1);
begin
  RelatedKey := DefaultGoodsAcntID;
  GoodsTypeID := DefaultGoodsTypeID;
  SelectMode := False;
  ShowModal;
end;

procedure TfrmGoodsRelatedDlg.btnOkClick(Sender: TObject);
begin
  if ItemSelected and fSelectMode then
    ModalResult := mrOk;
end;

procedure TfrmGoodsRelatedDlg.CopyCellTextToClipboard;
var
  RecordIndex: integer;
begin
  if cxGridGoodsAcntTable.DataController.FocusedRowIndex >= 0 then
  begin
    RecordIndex := cxGridGoodsAcntTable.DataController.GetRowInfo(cxGridGoodsAcntTable.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := cxGridGoodsAcntTable.DataController.GetDisplayText(RecordIndex, cxGridGoodsAcntTable.Controller.FocusedColumn.Index);
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcntTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (ssLeft in AShift) and (ssDouble in AShift) then
  begin
    if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
      NavigateForward
    else if ItemSelected and fSelectMode then
      ModalResult := mrOk;
    AHandled := True;
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcntTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcnt_PRICE_ACNTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridGoodsAcntTableFolder.Index]) then
  begin
    if ARecord.Values[cxGridGoodsAcntTableFolder.Index] = 1 then
      AText := '';
  end;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcntTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectedRecordChanged;
end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcntTableKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Enter
  if (Key = 13) and (Shift = []) then
  begin
    if (cxGridGoodsAcntTable.DataController.RecNo > 0) then
    begin
      if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
        NavigateForward
      else if ItemSelected then
        ModalResult := mrOk;
    end;
  end
  else
     // CTRL+Enter
 if (Key = 13) and (Shift = [ssCtrl]) and ItemSelected and fSelectMode then
    ModalResult := mrOk
  else
     // Ctrl+C
 if (Key = 67) and (Shift = [ssCtrl]) then
  begin
          // copy cell content in clipboard
    CopyCellTextToClipboard;
    Key := 0;
    Shift := [];
  end;

end;

procedure TfrmGoodsRelatedDlg.cxGridGoodsAcntTableTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridGoodsAcntTableFolder.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmGoodsRelatedDlg.DeleteCurrentItem;
var
  Title: string;
  Text: string;
begin
  if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    Title := 'Sterge mapa';
    Text := 'Doriti sa stergeti mapa "' + IBCQueryRelatedKeys.FieldByName('TITLE').AsWideString + '" ?';
  end
  else
  begin
    Title := 'Stergerea denumirii pentru facturi';
    Text := 'Doriti sa stergeti ' + #13#10 + IBCQueryRelatedKeys.FieldByName('TITLE').AsWideString + ' ?';
  end;

  if ShowAskDialog(Title, Text) = mrYes then
  begin
    try
      IBCQueryRelatedKeys.Delete;
      IBCQueryRelatedKeys.UpdateTransaction.Commit;
      fItemsChanged := True;
    except
      on E: Exception do
      begin
        IBCQueryRelatedKeys.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.dxBarButton1Click(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TfrmGoodsRelatedDlg.bbRelatedGoodsClick(Sender: TObject);
begin
  ShowGoodsFromAcntCode(IBCQueryRelatedKeys.FieldByName('RelatedKey').AsInteger);
end;

procedure TfrmGoodsRelatedDlg.EnableCondition(const ConditionIndex: integer; const CustomCondition: string);
begin
  fInSearch := False;
  IBCQueryRelatedKeys.Close;
  case ConditionIndex of
     // forward
    0:
      IBCQueryRelatedKeys.FilterSQL := 'A.PARENTID=:ParentID';
     // backward
        1:
      IBCQueryRelatedKeys.FilterSQL := 'A.PARENTID=(SELECT PARENTID FROM TS_GOODS_ACNT WHERE RelatedKey=:ParentID)';
     // search
        2:
      IBCQueryRelatedKeys.FilterSQL := CustomCondition;
  end;
  IBCQueryRelatedKeys.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
end;

procedure TfrmGoodsRelatedDlg.FormCreate(Sender: TObject);
begin
  fGoodsAcntID := -1;
  fRootParentID := 0;
  fInSearch := False;
  fCurrentParent_Key := 0;
  fSelectMode := True;
  fItemsChanged := False;
end;

function TfrmGoodsRelatedDlg.ItemSelected: Boolean;
begin
  Result := False;
  if (cxGridGoodsAcntTable.DataController.RecNo > 0) and (IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 0) then
  begin
    if fSelectMode then
    begin
      fGoodsAcntID := IBCQueryRelatedKeys.FieldByName('RelatedKey').AsInteger;
      FRelatedKeyTitle := IBCQueryRelatedKeys.FieldByName('TITLE').AsWideString;
      Result := True;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGoodsAcntTable);
end;

procedure TfrmGoodsRelatedDlg.NavigateBack;
var
  ParentID: Integer;
  RelatedKey: integer;
begin
  RelatedKey := -1;
  if IBCQueryRelatedKeys.Eof then
  begin
          // no records
    if fCurrentParent_Key = -1 then
      ParentID := fRootParentID
    else
      ParentID := fCurrentParent_Key;
  end
  else
  begin
    ParentID := IBCQueryRelatedKeys.FieldByName('PARENTID').AsInteger;
    if ParentID = 0 then
      RelatedKey := IBCQueryRelatedKeys.FieldByName('RelatedKey').AsInteger;
  end;

  EnableCondition(1); // Browse Backward
  if (RelatedKey <> -1) then
    IBCQueryRelatedKeys.ParamByName('ParentID').AsInteger := RelatedKey
  else
    IBCQueryRelatedKeys.ParamByName('ParentID').AsInteger := ParentID;
  IBCQueryRelatedKeys.Open;
  fCurrentParent_Key := IBCQueryRelatedKeys.FieldByName('PARENTID').AsInteger;
  if (RelatedKey <> -1) then
    IBCQueryRelatedKeys.Locate('RelatedKey', RelatedKey, [])
  else
    IBCQueryRelatedKeys.Locate('RelatedKey', ParentID, []);
end;

procedure TfrmGoodsRelatedDlg.NavigateForward;
var
  ParentID: Integer;
begin
  if (IBCQueryRelatedKeys.RecordCount = 0) then
    ParentID := 0
  else
    ParentID := IBCQueryRelatedKeys.FieldByName('RelatedKey').AsInteger;

  EnableCondition(0); // Browse Forward
  IBCQueryRelatedKeys.ParamByName('ParentID').AsInteger := ParentID;
  fCurrentParent_Key := ParentID;
  IBCQueryRelatedKeys.Open;
end;

procedure TfrmGoodsRelatedDlg.NavigateSearch(const WhereConditions: string);
begin
  EnableCondition(2, WhereConditions); // Search
  fInSearch := True;
  IBCQueryRelatedKeys.Open;
  fCurrentParent_Key := -1;
end;

procedure TfrmGoodsRelatedDlg.NavigateToGoodsAcnt(const RelatedKey: string);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryRelatedKeys.ParamByName('Parent_KEY').AsString := RelatedKey;
  IBCQueryRelatedKeys.Open;
  IBCQueryRelatedKeys.Locate('RELATED_KEY', RelatedKey, []);
  fCurrentParent_Key := IBCQueryRelatedKeys.FieldByName('Parent_KEY').AsString;
end;

procedure TfrmGoodsRelatedDlg.NavigateToHome(const RootID: string);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryRelatedKeys.ParamByName('ParentID').AsString := RootID;
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
    IBCTrUpdateGoodsAcnt.StartTransaction;
    for i:=0 to list.Count-1 do
    begin
      IBCQueryRelatedKeys.Append;
      IBCQueryRelatedKeys.FieldByName('TITLE').AsString := list[i];
      IBCQueryRelatedKeys.FieldByName('PARENT_KEY').AsString := fCurrentParent_Key;
      IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger := 0;
      IBCQueryRelatedKeys.Post;
    end;
    IBCTrUpdateGoodsAcnt.Commit;
  finally
    list.free;
  end;
end;

procedure TfrmGoodsRelatedDlg.Prepare;
begin
  SetupSecurityItems;
  SetupQtyFields;

  if not fSelectMode then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

  if fGoodsAcntID > 0 then
    NavigateToGoodsAcnt(fGoodsAcntID)
  else
  begin
    if fRootParentID > 0 then
      NavigateToHome(fRootParentID)
    else
      NavigateForward;
  end;
  SelectedRecordChanged;
     // default focused column
  cxGridGoodsAcntTableTitle.Selected := True;
  cxGridGoodsAcntTableTitle.Focused := True;

  cxGridGoodsAcntTable.DataController.DataModeController.GridMode := True;
  cxGridGoodsAcntTable.DataController.DataModeController.GridModeBufferCount := 50;
  cxGridGoodsAcntTable.DataController.DataModeController.SyncMode := True;
end;

procedure TfrmGoodsRelatedDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGoodsAcntTable);
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

  if cxGridGoodsAcntTable.DataController.RecNo > 0 then
  begin
    FLG_FOLDER := IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1;

    if FLG_FOLDER then
    begin
      fForward := True;
      fModify := cSecurityFlag_CanModify_Folder; // Modify
      fDelete := cSecurityFlag_CanDelete_Folder; // Remove
    end
    else
    begin
      fModify := cSecurityFlag_CanModify_Item; // Modify
      fDelete := cSecurityFlag_CanDelete_Item; // Remove
      fRelatedGoods := True;
      fInfoCard := True;
    end;
    fBack := (fCurrentParent_Key > 0) and (fCurrentParent_Key <> fRootParentID) or fInSearch;
    fHome := fBack or (fRootParentID >= 0);

    fSortFolders := not fInSearch;  // Sort Folders
    fChangeParent := not fInSearch; // Change Parent
  end
  else
  begin
    fBack := (fCurrentParent_Key > 0) and (fRootParentID <> fCurrentParent_Key);
    fHome := fBack or (fRootParentID = 0);
  end;

  // navigation
  bbHome.Enabled := fHome;
  bbForward.Enabled := fForward;
  bbBack.Enabled := fBack;

  bbNewFolder.Enabled := fNewFolder;
  bbNew.Enabled := fNewItem;
  bbModify.Enabled := fModify;
  bbRemove.Enabled := fDelete;

  bbSortFolders.Enabled := fSortFolders;
  bbChangeParent.Enabled := fChangeParent;

  bbGoodsInfoCard.Enabled := fInfoCard;
  bbRelatedGoods.Enabled := fRelatedGoods;
end;

function TfrmGoodsRelatedDlg.SelectGoodsACNT(const DefaultGoodsAcntID: integer): Boolean;
begin
  RelatedKey := DefaultGoodsAcntID;
  SelectMode := True;
  Result := ShowModal = mrOk;
end;

procedure TfrmGoodsRelatedDlg.SetGoodsTypeID(const Value: Integer);
begin
    FGoodsTypeID := Value;
end;

procedure TfrmGoodsRelatedDlg.SetRelatedKey(const Value: string);
begin
    FRelatedKey := Value;
end;

procedure TfrmGoodsRelatedDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmGoodsRelatedDlg.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
  TcxCalcEditProperties(cxGridGoodsAcnt_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  TcxCalcEditProperties(cxGridGoodsAcnt_QTY_STOCK.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
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

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Изменение_предка) then
    bbChangeParent.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_НДН_Упорядочивание_папок) then
    bbSortFolders.Visible := ivNever;

  if bbItem.ItemLinks.VisibleItemCount = 0 then
    bbItem.Visible := ivNever;
  if bbAdditionalTools.ItemLinks.VisibleItemCount = 0 then
    bbAdditionalTools.Visible := ivNever;
  if dxBarPopupMenu.ItemLinks.VisibleItemCount = 0 then
    cxGridGoodsAcntTable.PopupMenu := nil;
end;

procedure TfrmGoodsRelatedDlg.ShowCreateNewItemDialog;
var
  dialog: TfrmGoodsAcntEditorDlg;
begin
  dialog := TfrmGoodsAcntEditorDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceGoodsAcnt);
  try
    dialog.ParentID := fCurrentParent_Key;
    dialog.CreateNewItem := True;
    if dialog.ShowModal = mrOk then
    begin
      fItemsChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowGoodsFromAcntCode(const acntCode: Integer);
var
  dialog: TfmGoodsFromAcnt;
begin
  dialog := TfmGoodsFromAcnt.Create(self, acntCode);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowGoodsInfoCardDialog(const acntCode: integer; const acntName: string);
var
  dialog: TfrmGoodsInfoCardDlg;
begin
  dialog := TfrmGoodsInfoCardDlg.Create(Self);
  try
    dialog.SetAcntGoodsInfo(acntCode, acntName);
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowChangeParentDialog;
var
  dialog: TfrmChangeParentFolderDlg;
begin
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtGOODSACNT;
    dialog.FolderObjectID := IBCQueryRelatedKeys.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(IBCQueryRelatedKeys.FieldByName('RelatedKey').AsInteger, IBCQueryRelatedKeys.FieldByName('TITLE').asString);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryRelatedKeys.Close;
      IBCQueryRelatedKeys.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowCreateNewFolderDialog;
var
  dialog: TfrmGoodsAcntFolderDlg;
begin
  dialog := TfrmGoodsAcntFolderDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceGoodsAcnt);
  try
    dialog.ParentID := fCurrentParent_Key;
    dialog.CreateNewFolder := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowModifyCurrentItemDialog;
var
  dialogFolder: TfrmGoodsAcntFolderDlg;
  dialogItem: TfrmGoodsAcntEditorDlg;
begin
  if IBCQueryRelatedKeys.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    dialogFolder := TfrmGoodsAcntFolderDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceGoodsAcnt);
    try
      dialogFolder.ShowModal;
    finally
      dialogFolder.Free;
    end;
  end
  else
  begin
    dialogItem := TfrmGoodsAcntEditorDlg.Create(Self, IBCQueryRelatedKeys, IBCDataSourceGoodsAcnt);
    try
      dialogItem.ShowModal;
    finally
      dialogItem.Free;
    end;
  end;
end;

procedure TfrmGoodsRelatedDlg.ShowSortFoldersDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotGOODSACNT;
    dialog.ParentID := fCurrentParent_Key;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryRelatedKeys.Close;
      IBCQueryRelatedKeys.Open;
    end;
  finally
    dialog.Free;
  end;
end;

end.


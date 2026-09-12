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
  TfrmGoodsACNTDlg = class(TSWNCustomForm)
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
    IBCDataSourceGoodsAcnt: TIBCDataSource;
    IBCQueryGoodsAcnt: TIBCQuery;
    IBCTrUpdateGoodsAcnt: TIBCTransaction;
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
    cxGridGoodsAcnt_PRICE_ACNT: TcxGridDBColumn;
    bbRelatedGoods: TdxBarButton;
    bbGoodsInfoCard: TdxBarButton;
    cxGridGoodsAcnt_QTY_STOCK: TcxGridDBColumn;
    cxGridGoodsAcnt_LOW_BOUND: TcxGridDBColumn;
    cxGridGoodsAcnt_HIGH_BOUND: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    cxGridGoodsAcnt_GOODS_TYPE_TITLE: TcxGridDBColumn;
    cxGridGoodsAcnt_GOODS_TYPEID: TcxGridDBColumn;
    bbSetGoodsType: TdxBarButton;
    bbMergeGoodsAcnt: TdxBarButton;
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
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure cxGridGoodsAcntTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridGoodsAcntTableTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbSetGoodsTypeClick(Sender: TObject);
    procedure bbMergeGoodsAcntClick(Sender: TObject);
    procedure cxGridGoodsAcntTableSelectionChanged(Sender: TcxCustomGridTableView);
  private
    { Private declarations }
    fCurrentParentID: integer;
    fGoodsAcntID: integer;
    fRootParentID: integer;
    fInSearch: Boolean;
    fSelectMode: Boolean;
    fItemsChanged: Boolean;
    fGoodsAcntTitle: string;
    // security flags
    cSecurityFlag_CanModify_Folder, cSecurityFlag_CanModify_Item, cSecurityFlag_CanDelete_Folder, cSecurityFlag_CanDelete_Item: Boolean;
    FGoodsTypeID: Integer;
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToGoodsAcnt(const GoodsAcntID: integer);
    procedure NavigateSearch(const WhereConditions: string);
    procedure NavigateToHome(const RootID: integer);
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
    procedure ShowGoodsFromAcntCode(const acntCode: Integer);
    procedure ShowGoodsInfoCardDialog(const acntCode: integer; const acntName: string);
    procedure SetupQtyFields;
    function GetSelectedGoodsAcntIDs(out ADefaultGoodsTypeID: integer): TArray<integer>;
    procedure SetGoodsTypeForSelectedItems;
    procedure ShowMergeGoodsAcntDialog;
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
    property GoodsAcntID: integer read fGoodsAcntID write SetGoodsAcntID;
    property GoodsAcntTitle: string read fGoodsAcntTitle;
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
  frmGoodsTypeDialog, frmMergeGoodsAcntUnit, SWNConst;

{$R *.dfm}

procedure TfrmGoodsACNTDlg.bbBackClick(Sender: TObject);
begin
  NavigateBack;
end;

procedure TfrmGoodsACNTDlg.bbChangeParentClick(Sender: TObject);
begin
  ShowChangeParentDialog;
end;

procedure TfrmGoodsACNTDlg.bbForwardClick(Sender: TObject);
begin
  NavigateForward;
end;

procedure TfrmGoodsACNTDlg.bbGoodsInfoCardClick(Sender: TObject);
begin
  ShowGoodsInfoCardDialog(IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger, IBCQueryGoodsAcnt.FieldByName('NAMEACNT').AsString);
end;

procedure TfrmGoodsACNTDlg.bbHomeClick(Sender: TObject);
begin
  NavigateToHome(fRootParentID);
end;

procedure TfrmGoodsACNTDlg.bbModifyClick(Sender: TObject);
begin
  ShowModifyCurrentItemDialog;
end;

procedure TfrmGoodsACNTDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewItemDialog;
end;

procedure TfrmGoodsACNTDlg.bbNewFolderClick(Sender: TObject);
begin
  ShowCreateNewFolderDialog;
end;

procedure TfrmGoodsACNTDlg.bbRemoveClick(Sender: TObject);
begin
  DeleteCurrentItem;
end;

procedure TfrmGoodsACNTDlg.bbSearchClick(Sender: TObject);
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
            AddConditionToWHERE(S, 'A.GOODS_ACNT_ID=' + Criteria.SearchText);
          sfName:
            AddConditionToWHERE(S, 'UPPER(A.NAMEACNT) LIKE ' + PrepareTextForLIKE(Criteria.SearchText));
        end;
      end;
    end;
  finally
    search.Free;
  end;

  if (S <> '') then
    NavigateSearch(S);
end;

procedure TfrmGoodsACNTDlg.bbMergeGoodsAcntClick(Sender: TObject);
begin
  ShowMergeGoodsAcntDialog;
end;

procedure TfrmGoodsACNTDlg.bbSetGoodsTypeClick(Sender: TObject);
begin
  SetGoodsTypeForSelectedItems;
end;

procedure TfrmGoodsACNTDlg.bbSortFoldersClick(Sender: TObject);
begin
  ShowSortFoldersDialog;
end;

procedure TfrmGoodsACNTDlg.BrowseGoodsACNT(const DefaultGoodsAcntID: integer =
    -1; const DefaultGoodsTypeID: integer = -1);
begin
  GoodsAcntID := DefaultGoodsAcntID;
  GoodsTypeID := DefaultGoodsTypeID;
  SelectMode := False;
  ShowModal;
end;

procedure TfrmGoodsACNTDlg.btnOkClick(Sender: TObject);
begin
  if ItemSelected and fSelectMode then
    ModalResult := mrOk;
end;

procedure TfrmGoodsACNTDlg.CopyCellTextToClipboard;
var
  RecordIndex: integer;
begin
  if cxGridGoodsAcntTable.DataController.FocusedRowIndex >= 0 then
  begin
    RecordIndex := cxGridGoodsAcntTable.DataController.GetRowInfo(cxGridGoodsAcntTable.DataController.FocusedRowIndex).RecordIndex;
    Clipboard.asText := cxGridGoodsAcntTable.DataController.GetDisplayText(RecordIndex, cxGridGoodsAcntTable.Controller.FocusedColumn.Index);
  end;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (ssLeft in AShift) and (ssDouble in AShift) then
  begin
    if IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 1 then
      NavigateForward
    else if ItemSelected and fSelectMode then
      ModalResult := mrOk;
    AHandled := True;
  end;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcnt_PRICE_ACNTGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridGoodsAcntTableFolder.Index]) then
  begin
    if ARecord.Values[cxGridGoodsAcntTableFolder.Index] = 1 then
      AText := '';
  end;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectedRecordChanged;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Enter
  if (Key = 13) and (Shift = []) then
  begin
    if (cxGridGoodsAcntTable.DataController.RecNo > 0) then
    begin
      if IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 1 then
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

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  SelectedRecordChanged;
end;

procedure TfrmGoodsACNTDlg.cxGridGoodsAcntTableTitleStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridGoodsAcntTableFolder.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmGoodsACNTDlg.DeleteCurrentItem;
var
  Title: string;
  Text: string;
begin
  if IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    Title := 'Sterge mapa';
    Text := 'Doriti sa stergeti mapa "' + IBCQueryGoodsAcnt.FieldByName('NAMEACNT').AsWideString + '" ?';
  end
  else
  begin
    Title := 'Stergerea denumirii pentru facturi';
    Text := 'Doriti sa stergeti ' + #13#10 + IBCQueryGoodsAcnt.FieldByName('NAMEACNT').AsWideString + ' ?';
  end;

  if ShowAskDialog(Title, Text) = mrYes then
  begin
    try
      IBCQueryGoodsAcnt.Delete;
      IBCQueryGoodsAcnt.UpdateTransaction.Commit;
      fItemsChanged := True;
    except
      on E: Exception do
      begin
        IBCQueryGoodsAcnt.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmGoodsACNTDlg.dxBarButton1Click(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TfrmGoodsACNTDlg.bbRelatedGoodsClick(Sender: TObject);
begin
  ShowGoodsFromAcntCode(IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger);
end;

procedure TfrmGoodsACNTDlg.EnableCondition(const ConditionIndex: integer; const CustomCondition: string);
begin
  fInSearch := False;
  IBCQueryGoodsAcnt.Close;
  case ConditionIndex of
     // forward
    0:
      IBCQueryGoodsAcnt.FilterSQL := 'A.PARENTID=:ParentID';
     // backward
        1:
      IBCQueryGoodsAcnt.FilterSQL := 'A.PARENTID=(SELECT PARENTID FROM TS_GOODS_ACNT WHERE GOODS_ACNT_ID=:ParentID)';
     // search
        2:
      IBCQueryGoodsAcnt.FilterSQL := CustomCondition;
  end;
  IBCQueryGoodsAcnt.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
end;

procedure TfrmGoodsACNTDlg.FormCreate(Sender: TObject);
begin
  fGoodsAcntID := -1;
  fRootParentID := 0;
  fInSearch := False;
  fCurrentParentID := 0;
  fSelectMode := True;
  fItemsChanged := False;
end;

function TfrmGoodsACNTDlg.ItemSelected: Boolean;
begin
  Result := False;
  if (cxGridGoodsAcntTable.DataController.RecNo > 0) and (IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 0) then
  begin
    if fSelectMode then
    begin
      fGoodsAcntID := IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger;
      fGoodsAcntTitle := IBCQueryGoodsAcnt.FieldByName('NAMEACNT').AsWideString;
      Result := True;
    end;
  end;
end;

procedure TfrmGoodsACNTDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
    Self.Position := poDesigned;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGoodsAcntTable);
end;

procedure TfrmGoodsACNTDlg.NavigateBack;
var
  ParentID: Integer;
  GoodsAcntID: integer;
begin
  GoodsAcntID := -1;
  if IBCQueryGoodsAcnt.Eof then
  begin
          // no records
    if fCurrentParentID = -1 then
      ParentID := fRootParentID
    else
      ParentID := fCurrentParentID;
  end
  else
  begin
    ParentID := IBCQueryGoodsAcnt.FieldByName('PARENTID').AsInteger;
    if ParentID = 0 then
      GoodsAcntID := IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger;
  end;

  EnableCondition(1); // Browse Backward
  if (GoodsAcntID <> -1) then
    IBCQueryGoodsAcnt.ParamByName('ParentID').AsInteger := GoodsAcntID
  else
    IBCQueryGoodsAcnt.ParamByName('ParentID').AsInteger := ParentID;
  IBCQueryGoodsAcnt.Open;
  fCurrentParentID := IBCQueryGoodsAcnt.FieldByName('PARENTID').AsInteger;
  if (GoodsAcntID <> -1) then
    IBCQueryGoodsAcnt.Locate('GOODS_ACNT_ID', GoodsAcntID, [])
  else
    IBCQueryGoodsAcnt.Locate('GOODS_ACNT_ID', ParentID, []);
end;

procedure TfrmGoodsACNTDlg.NavigateForward;
var
  ParentID: Integer;
begin
  if (IBCQueryGoodsAcnt.RecordCount = 0) then
    ParentID := 0
  else
    ParentID := IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger;

  EnableCondition(0); // Browse Forward
  IBCQueryGoodsAcnt.ParamByName('ParentID').AsInteger := ParentID;
  fCurrentParentID := ParentID;
  IBCQueryGoodsAcnt.Open;
end;

procedure TfrmGoodsACNTDlg.NavigateSearch(const WhereConditions: string);
begin
  EnableCondition(2, WhereConditions); // Search
  fInSearch := True;
  IBCQueryGoodsAcnt.Open;
  fCurrentParentID := -1;
end;

procedure TfrmGoodsACNTDlg.NavigateToGoodsAcnt(const GoodsAcntID: integer);
begin
  EnableCondition(1); // Browse Backward
  IBCQueryGoodsAcnt.ParamByName('ParentID').AsInteger := GoodsAcntID;
  IBCQueryGoodsAcnt.Open;
  IBCQueryGoodsAcnt.Locate('GOODS_ACNT_ID', GoodsAcntID, []);
  fCurrentParentID := IBCQueryGoodsAcnt.FieldByName('ParentID').AsInteger;
end;

procedure TfrmGoodsACNTDlg.NavigateToHome(const RootID: integer);
begin
  EnableCondition(0); // Browse Forward
  IBCQueryGoodsAcnt.ParamByName('ParentID').AsInteger := RootID;
  fCurrentParentID := RootID;
  IBCQueryGoodsAcnt.Open;
end;

procedure TfrmGoodsACNTDlg.PasteFromClipboard;
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
      IBCQueryGoodsAcnt.Append;
      IBCQueryGoodsAcnt.FieldByName('NAMEACNT').AsString := list[i];
      IBCQueryGoodsAcnt.FieldByName('PARENTID').AsInteger := fCurrentParentID;
      IBCQueryGoodsAcnt.FieldByName('PERCENT_BOUNDS').AsInteger := 0;
      IBCQueryGoodsAcnt.FieldByName('PRICE_ACNT').AsInteger := 0;
      IBCQueryGoodsAcnt.FieldByName('PRCODE').AsInteger := 0;
      IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger := 0;
      IBCQueryGoodsAcnt.Post;
    end;
    IBCTrUpdateGoodsAcnt.Commit;
  finally
    list.free;
  end;
end;

procedure TfrmGoodsACNTDlg.Prepare;
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

procedure TfrmGoodsACNTDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGoodsAcntTable);
end;

procedure TfrmGoodsACNTDlg.SelectedRecordChanged;
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
    FLG_FOLDER := IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 1;

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
    fBack := (fCurrentParentID > 0) and (fCurrentParentID <> fRootParentID) or fInSearch;
    fHome := fBack or (fRootParentID >= 0);

    fSortFolders := not fInSearch;  // Sort Folders
    fChangeParent := not fInSearch; // Change Parent
  end
  else
  begin
    fBack := (fCurrentParentID > 0) and (fRootParentID <> fCurrentParentID);
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
  // OnFocusedRecordChanged se declanseaza inainte de actualizarea selectiei,
  // deci butoanele ramin active cit timp exista inregistrari, iar numarul
  // inregistrarilor selectate se verifica in momentul apelului
  bbSetGoodsType.Enabled := cxGridGoodsAcntTable.DataController.RecordCount > 0;
  bbMergeGoodsAcnt.Enabled := cxGridGoodsAcntTable.DataController.RecordCount > 0;
end;

function TfrmGoodsACNTDlg.SelectGoodsACNT(const DefaultGoodsAcntID: integer): Boolean;
begin
  GoodsAcntID := DefaultGoodsAcntID;
  SelectMode := True;
  Result := ShowModal = mrOk;
end;

function TfrmGoodsACNTDlg.GetSelectedGoodsAcntIDs(out ADefaultGoodsTypeID:
    integer): TArray<integer>;
var
  i, RecordIndex: integer;
  V: Variant;
begin
  SetLength(Result, 0);
  ADefaultGoodsTypeID := -1;

  for i := 0 to cxGridGoodsAcntTable.Controller.SelectedRecordCount - 1 do
  begin
    RecordIndex := cxGridGoodsAcntTable.Controller.SelectedRows[i].RecordIndex;

    // mapele nu au categorie de produs (in GridMode valoarea poate lipsi
    // din buffer - atunci inregistrarea nu se exclude)
    V := cxGridGoodsAcntTable.DataController.Values[RecordIndex, cxGridGoodsAcntTableFolder.Index];
    if (not VarIsNull(V)) and (V <> 0) then
      Continue;

    V := cxGridGoodsAcntTable.DataController.Values[RecordIndex, cxGridGoodsAcnt_GOODS_ACNT_ID.Index];
    if VarIsNull(V) then
      // in GridMode citim cheia inregistrarii (DataController.KeyFieldNames)
      V := cxGridGoodsAcntTable.DataController.GetRecordId(RecordIndex);
    if VarIsNull(V) or VarIsEmpty(V) then
      Continue;

    SetLength(Result, Length(Result) + 1);
    Result[High(Result)] := V;

    if ADefaultGoodsTypeID <= 0 then
    begin
      V := cxGridGoodsAcntTable.DataController.Values[RecordIndex, cxGridGoodsAcnt_GOODS_TYPEID.Index];
      if not VarIsNull(V) then
        ADefaultGoodsTypeID := V;
    end;
  end;
end;

procedure TfrmGoodsACNTDlg.SetGoodsTypeForSelectedItems;
var
  dialog: TfrmGoodsTypeDlg;
  q: TIBCQuery;
  i: integer;
  IDs: TArray<integer>;
  DefaultGoodsTypeID, NewGoodsTypeID, FocusedGoodsAcntID: integer;
  NewGoodsTypeTitle: string;
begin
  IDs := GetSelectedGoodsAcntIDs(DefaultGoodsTypeID);
  if Length(IDs) = 0 then
  begin
    ShowInfoDialog('Categorie produs', 'Selectati cel putin o denumire de contabilitate (mapele nu se accepta).');
    Exit;
  end;

  NewGoodsTypeID := -1;
  NewGoodsTypeTitle := '';
  dialog := TfrmGoodsTypeDlg.Create(Self);
  try
    if dialog.SelectGoodsType(DefaultGoodsTypeID) then
    begin
      NewGoodsTypeID := dialog.GoodsTypeID;
      NewGoodsTypeTitle := dialog.GoodsTypeTitle;
    end;
  finally
    dialog.Free;
  end;

  if NewGoodsTypeID <= 0 then
    Exit;

  if Length(IDs) > 1 then
    if ShowAskDialog('Categorie produs',
                     Format('Atribuiti categoria "%s" la %d denumiri selectate?', [NewGoodsTypeTitle, Length(IDs)])) <> mrYes then
      Exit;

  FocusedGoodsAcntID := IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger;

  q := TIBCQuery.Create(nil);
  try
    q.Connection := dmDB.IBCConnection;
    q.Transaction := IBCTrUpdateGoodsAcnt;
    q.AutoCommit := False;
    q.SQL.Text := 'UPDATE TS_GOODS_ACNT SET GOODS_TYPEID = :GOODS_TYPEID WHERE GOODS_ACNT_ID = :GOODS_ACNT_ID';
    q.Prepare;

    if not IBCTrUpdateGoodsAcnt.Active then
      IBCTrUpdateGoodsAcnt.StartTransaction;
    try
      for i := 0 to High(IDs) do
      begin
        q.ParamByName('GOODS_TYPEID').AsInteger := NewGoodsTypeID;
        q.ParamByName('GOODS_ACNT_ID').AsInteger := IDs[i];
        q.Execute;
      end;
      IBCTrUpdateGoodsAcnt.Commit;
      fItemsChanged := True;
    except
      on E: Exception do
      begin
        if IBCTrUpdateGoodsAcnt.Active then
          IBCTrUpdateGoodsAcnt.Rollback;
        if not ProcessSWNError(E) then
          raise;
        Exit;
      end;
    end;
  finally
    q.Free;
  end;

  IBCQueryGoodsAcnt.Close;
  IBCQueryGoodsAcnt.Open;
  if FocusedGoodsAcntID > 0 then
    IBCQueryGoodsAcnt.Locate('GOODS_ACNT_ID', FocusedGoodsAcntID, []);
  SelectedRecordChanged;
end;

procedure TfrmGoodsACNTDlg.SetGoodsAcntID(const Value: integer);
begin
  fGoodsAcntID := Value;
end;

procedure TfrmGoodsACNTDlg.SetGoodsTypeID(const Value: Integer);
begin
    FGoodsTypeID := Value;
end;

procedure TfrmGoodsACNTDlg.SetSelectMode(const Value: Boolean);
begin
  FSelectMode := Value;
end;

procedure TfrmGoodsACNTDlg.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Pozitii marfa: Cantitate
  TcxCalcEditProperties(cxGridGoodsAcnt_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  TcxCalcEditProperties(cxGridGoodsAcnt_QTY_STOCK.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmGoodsACNTDlg.SetupSecurityItems;
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

procedure TfrmGoodsACNTDlg.ShowCreateNewItemDialog;
var
  dialog: TfrmGoodsAcntEditorDlg;
begin
  dialog := TfrmGoodsAcntEditorDlg.Create(Self, IBCQueryGoodsAcnt, IBCDataSourceGoodsAcnt);
  try
    dialog.ParentID := fCurrentParentID;
    dialog.CreateNewItem := True;
    if dialog.ShowModal = mrOk then
    begin
      fItemsChanged := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsACNTDlg.ShowGoodsFromAcntCode(const acntCode: Integer);
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

procedure TfrmGoodsACNTDlg.ShowGoodsInfoCardDialog(const acntCode: integer; const acntName: string);
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

procedure TfrmGoodsACNTDlg.ShowChangeParentDialog;
var
  dialog: TfrmChangeParentFolderDlg;
begin
  dialog := TfrmChangeParentFolderDlg.Create(Self);
  try
    dialog.DBTable := dbtGOODSACNT;
    dialog.FolderObjectID := IBCQueryGoodsAcnt.FieldByName('PARENTID').AsInteger;
    dialog.AddObjectInfo(IBCQueryGoodsAcnt.FieldByName('GOODS_ACNT_ID').AsInteger, IBCQueryGoodsAcnt.FieldByName('NAMEACNT').asString);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryGoodsAcnt.Close;
      IBCQueryGoodsAcnt.Open;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsACNTDlg.ShowCreateNewFolderDialog;
var
  dialog: TfrmGoodsAcntFolderDlg;
begin
  dialog := TfrmGoodsAcntFolderDlg.Create(Self, IBCQueryGoodsAcnt, IBCDataSourceGoodsAcnt);
  try
    dialog.ParentID := fCurrentParentID;
    dialog.CreateNewFolder := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsACNTDlg.ShowModifyCurrentItemDialog;
var
  dialogFolder: TfrmGoodsAcntFolderDlg;
  dialogItem: TfrmGoodsAcntEditorDlg;
begin
  if IBCQueryGoodsAcnt.FieldByName('FLG_FOLDER').AsInteger = 1 then
  begin
    dialogFolder := TfrmGoodsAcntFolderDlg.Create(Self, IBCQueryGoodsAcnt, IBCDataSourceGoodsAcnt);
    try
      dialogFolder.ShowModal;
    finally
      dialogFolder.Free;
    end;
  end
  else
  begin
    dialogItem := TfrmGoodsAcntEditorDlg.Create(Self, IBCQueryGoodsAcnt, IBCDataSourceGoodsAcnt);
    try
      dialogItem.ShowModal;
    finally
      dialogItem.Free;
    end;
  end;
end;

procedure TfrmGoodsACNTDlg.ShowMergeGoodsAcntDialog;
var
  dialog: TfrmMergeGoodsAcntDlg;
  IDs: TArray<integer>;
  DefaultGoodsTypeID, TargetGoodsAcntID: integer;
begin
  IDs := GetSelectedGoodsAcntIDs(DefaultGoodsTypeID);
  if Length(IDs) < 2 then
  begin
    ShowInfoDialog('Unirea denumirilor',
                   'Selectati cel putin doua denumiri de contabilitate (mapele nu se accepta).');
    Exit;
  end;

  dialog := TfrmMergeGoodsAcntDlg.Create(Self);
  try
    dialog.SetGoodsAcntIDs(IDs);
    if dialog.ShowModal = mrOk then
    begin
      fItemsChanged := True;
      TargetGoodsAcntID := dialog.TargetGoodsAcntID;

      IBCQueryGoodsAcnt.Close;
      IBCQueryGoodsAcnt.Open;
      if TargetGoodsAcntID > 0 then
        IBCQueryGoodsAcnt.Locate('GOODS_ACNT_ID', TargetGoodsAcntID, []);
      SelectedRecordChanged;

      ShowInfoDialog('Unirea denumirilor',
                     Format('Au fost unite %d inregistrari in "%s".',
                            [dialog.MergedCount, dialog.TargetGoodsAcntTitle]));
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsACNTDlg.ShowSortFoldersDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotGOODSACNT;
    dialog.ParentID := fCurrentParentID;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryGoodsAcnt.Close;
      IBCQueryGoodsAcnt.Open;
    end;
  finally
    dialog.Free;
  end;
end;

end.


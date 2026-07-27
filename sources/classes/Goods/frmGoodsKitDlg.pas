unit frmGoodsKitDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, DB,
  cxCustomData, cxDBData,
  Menus, DBAccess, IBC, MemDS, dxBar, StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxTextEdit, cxDBEdit, ExtCtrls,
  cxCalc, Vcl.ActnList,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, cxCheckBox,
  System.Actions, cxClasses, cxGridCustomView, dxUIAClasses;

type
  TfrmGoodsKitEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewItem: TdxBarButton;
    bbRemove: TdxBarButton;
    cxGridComplecte: TcxGrid;
    cxGridComplecteTable: TcxGridDBTableView;
    cxGridComplecteLevel: TcxGridLevel;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxGridComplecte_TITLE: TcxGridDBColumn;
    cxGridComplecte_QTY: TcxGridDBColumn;
    cxGridComplecte_FLG_ACTIVE: TcxGridDBColumn;
    bbModify: TdxBarButton;
    cxGridComplecte_ORDERNO: TcxGridDBColumn;
    IBCDataSourceGoodsComplecte: TIBCDataSource;
    IBCQueryGoodsComplecte: TIBCQuery;
    IBCTrUpdateGoodsComplecte: TIBCTransaction;
    edGoodsID: TcxDBTextEdit;
    edGoodsTitle: TcxDBTextEdit;
    cxGridComplecte_GOODSID: TcxGridDBColumn;
    bbImportFromDoc: TdxBarButton;
    Bevel1: TBevel;
    cxGridComplecte_IMG: TcxGridDBColumn;
    bbSortItems: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbChangeActiveState: TdxBarButton;
    cxGridComplecte_UM_TITLE: TcxGridDBColumn;
    Label1: TLabel;
    dxBarSubItem1: TdxBarSubItem;
    bbEditGoodsPrice: TdxBarButton;
    bbForeignGoods: TdxBarButton;
    dxBarButton1: TdxBarButton;
    cxGridComplecte_FLG_FORCED_ADDON: TcxGridDBColumn;
    cxGridComplecte_FLG_FORCED: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    ActionList1: TActionList;
    actImportFromAnotherGoods: TAction;
    bbCopyNames: TdxBarButton;
    cxGridComplecte_FLG_MODIFY_QTY: TcxGridDBColumn;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    bbPasteFromClipboard: TdxBarButton;
    cxGridComplecte_PRICE: TcxGridDBColumn;
    cxGridComplecte_SUMA: TcxGridDBColumn;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    procedure bbNewItemClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridComplecteTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComplecteTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbImportFromDocClick(Sender: TObject);
    procedure bbSortItemsClick(Sender: TObject);
    procedure cxGridComplecteTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbChangeActiveStateClick(Sender: TObject);
    procedure bbEditGoodsPriceClick(Sender: TObject);
    procedure bbForeignGoodsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure actImportFromAnotherGoodsExecute(Sender: TObject);
    procedure bbCopyNamesClick(Sender: TObject);
    procedure bbPasteFromClipboardClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowImportFromDocumentDialog;
    function DocActionDB_ImportGoodsIntoComplect(const SourceDocID: integer): Boolean;
    procedure ShowAddNewGoodsDialog;
    procedure ShowReplaceGoodsDialog;
    procedure ChangeItemCount(const IncCount: Boolean);
    procedure ChangeItemActiveFlag;
    procedure ShowSortItemsDialog;
    procedure SetupQtyFields;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure SaveStates; override;
    procedure LoadStates; override;
    procedure DoImportFromGoodsComplect;
  public
    { Public declarations }
  end;

implementation

uses
  SWNUtils, SWNConst, SWNSecurityFlags, DataModuleDB, frmDocumentImportBrowserDialog, SWNTypes, SWNDBErrors,
  frmChangeOrderNoDialog, SWNValueStorageUnit, frmGoodsKitGoodsEditorDialog, frmGoodsForeignCodeDialog,
  frmGoodsPricesDialog, SWNSecurity, Vcl.Clipbrd;

{$R *.dfm}
{ TfrmGoodsKitEditorDialog }

procedure TfrmGoodsKitEditorDialog.ShowAddNewGoodsDialog;
var
  dialog: TfrmGoodsKitGoodsEditorDlg;
begin
  dialog := TfrmGoodsKitGoodsEditorDlg.Create(Self, IBCQueryGoodsComplecte, IBCDataSourceGoodsComplecte);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.ShowImportFromDocumentDialog;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultDocTypeID := cDBID_DocType_КОНФИГУРАЦИИ_К;
    dialog.DefaultUserID := UserID;

    dialog.DocTypeList.Add(cDBID_DocType_КОНФИГУРАЦИИ_К);
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_РН);
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПН);

    if dialog.SelectDoc then
    begin
      if DocActionDB_ImportGoodsIntoComplect(dialog.DocID) then
      begin
        IBCQueryGoodsComplecte.Refresh;
        ShowInfoDialog('Импорт из документа', 'Готово!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.ShowReplaceGoodsDialog;
var
  dialog: TfrmGoodsKitGoodsEditorDlg;
begin
  dialog := TfrmGoodsKitGoodsEditorDlg.Create(Self, IBCQueryGoodsComplecte, IBCDataSourceGoodsComplecte);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.ShowSortItemsDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self, IBCTrUpdateGoodsComplecte);
  try
    dialog.DBTable := cosCOMPLECTE;
    dialog.ParentID := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryGoodsComplecte.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.WhenCancelForm;
begin
  IBCTrUpdateGoodsComplecte.Rollback;
end;

procedure TfrmGoodsKitEditorDialog.actImportFromAnotherGoodsExecute(Sender: TObject);
var
  GoodsID: string;
  NewComplect: Integer;
begin
    // import din alt complect la toata complectatia
    DoImportFromGoodsComplect;
    if InputQuery('Introduceti codul complectlui din care trebuie importate produsele',
              'Codul complectului', GoodsID
              ) then
    begin
      NewComplect := fMasterDataSet.FieldByName('GOODSID').AsInteger;
      dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_IMPORT_GOODS_FROM_COMPLECT(:from_complectid, :to_complectid)', [StrToInt(GoodsID), NewComplect]);
      IBCQueryGoodsComplecte.Refresh;
    end;
end;

procedure TfrmGoodsKitEditorDialog.bbChangeActiveStateClick(Sender: TObject);
begin
  ChangeItemActiveFlag;
end;

procedure TfrmGoodsKitEditorDialog.bbCopyNamesClick(Sender: TObject);
var
  I: Integer;
  s: string;
  sList: TStringList;
begin
  sList := TStringList.Create;
  try
    for I := 0 to cxGridComplecteTable.DataController.RowCount-1 do
    begin
      s := cxGridComplecteTable.DataController.GetDisplayText(i, cxGridComplecte_TITLE.Index)+ #9 +
        cxGridComplecteTable.DataController.GetDisplayText(i, cxGridComplecte_QTY.Index);
      sList.Add(s)
    end;
    Clipboard.AsText := sList.Text;
  finally
    sList.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.bbEditGoodsPriceClick(Sender: TObject);
var
  dialog: TfrmGoodsPricesDlg;
begin
  dialog := TfrmGoodsPricesDlg.Create(Self);
  try
    dialog.SetGoodsInfo(IBCQueryGoodsComplecte.FieldByName('GOODSID').AsInteger, IBCQueryGoodsComplecte.FieldByName('GOODS_TITLE').AsString);
    if dialog.ShowModal = mrOk then
      IBCQueryGoodsComplecte.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.bbForeignGoodsClick(Sender: TObject);
var
  dialog: TfrmGoodsForeignCodeDlg;
begin
  dialog := TfrmGoodsForeignCodeDlg.Create(Self);
  try
    dialog.GoodsID := IBCQueryGoodsComplecte.FieldByName('GOODSID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.bbImportFromDocClick(Sender: TObject);
begin
  ShowImportFromDocumentDialog;
end;

procedure TfrmGoodsKitEditorDialog.bbNewItemClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure TfrmGoodsKitEditorDialog.bbPasteFromClipboardClick(Sender: TObject);
var
  sList: TStringList;
  GoodsID: string;
  i: Integer;
  qty: string;
begin
  sList := TStringList.Create;
    sList.Text := Clipboard.AsText;
  for i:=0 to sList.Count-1 do
  begin
    GoodsID := Copy(sList.Strings[i], 1, Pos(#9, sList.Strings[i])-1);
    Qty := Copy(sList.Strings[i], Pos(#9, sList.Strings[i])+1, length(sList.Strings[i]));
    IBCQueryGoodsComplecte.Append;
    IBCQueryGoodsComplecte.FieldByName('GoodsID').AsString := GoodsID;
    IBCQueryGoodsComplecte.FieldByName('QTY').AsString := qty;
    IBCQueryGoodsComplecte.FieldByName('FLG_ACTIVE').AsInteger := 1;
    IBCQueryGoodsComplecte.FieldByName('FLG_MODIFY_QTY').AsInteger := 1;
    IBCQueryGoodsComplecte.Post;
  end;
end;

procedure TfrmGoodsKitEditorDialog.bbRemoveClick(Sender: TObject);
begin
  if ShowAskDialog('Удаление товара из комплекта', 'Удалить "' + IBCQueryGoodsComplecte.FieldByName('GOODS_TITLE').AsString
    + '" ?') = mrYes then
  begin
    try
      IBCQueryGoodsComplecte.Delete;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmGoodsKitEditorDialog.bbModifyClick(Sender: TObject);
begin
  ShowReplaceGoodsDialog;
end;

procedure TfrmGoodsKitEditorDialog.bbSortItemsClick(Sender: TObject);
begin
  ShowSortItemsDialog;
end;

procedure TfrmGoodsKitEditorDialog.ChangeItemActiveFlag;
var
  RecNo, N: integer;
begin
  if cxGridComplecteTable.DataController.RecNo > 0 then
  begin
    RecNo := cxGridComplecteTable.DataController.GetFocusedRecordIndex;
    N := cxGridComplecteTable.DataController.Values[RecNo, cxGridComplecte_FLG_ACTIVE.Index];
    if N = 1 then
      N := 0
    else
      N := 1;

    IBCQueryGoodsComplecte.Edit;
    try
      IBCQueryGoodsComplecte.FieldByName('FLG_ACTIVE').AsInteger := N;
      IBCQueryGoodsComplecte.Post;
    except
      on E: Exception do
      begin
        IBCQueryGoodsComplecte.Cancel;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmGoodsKitEditorDialog.ChangeItemCount(const IncCount: Boolean);
var
  RecNo: integer;
  oldValue, newValue: Double;
begin
  if cxGridComplecteTable.DataController.RecNo > 0 then
  begin
    RecNo := cxGridComplecteTable.DataController.GetFocusedRecordIndex;
    oldValue := cxGridComplecteTable.DataController.Values[RecNo, cxGridComplecte_QTY.Index];
    newValue := oldValue;
    if IncCount then
      newValue := oldValue + 1
    else if (oldValue > 1) then
      newValue := oldValue - 1;

    if (newValue <> oldValue) then
    begin
      IBCQueryGoodsComplecte.Edit;
      try
        IBCQueryGoodsComplecte.FieldByName('QTY').AsFloat := newValue;
        IBCQueryGoodsComplecte.Post;
      except
        on E: Exception do
        begin
          IBCQueryGoodsComplecte.Cancel;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    end;
  end;
end;

procedure TfrmGoodsKitEditorDialog.cxGridComplecteTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModify.Enabled then
  begin
    ShowReplaceGoodsDialog;
    AHandled := True;
  end;
end;

procedure TfrmGoodsKitEditorDialog.cxGridComplecteTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmGoodsKitEditorDialog.cxGridComplecteTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // +,-
  if (Key = VK_ADD) or (Key = VK_SUBTRACT) or (Key = VK_OEM_PLUS) or (Key = VK_OEM_MINUS) then
    ChangeItemCount((Key = VK_ADD) or (Key = VK_OEM_PLUS));

  dmdb.ProcessClipboardKeys(cxGridComplecteTable, Key, Shift);
end;

function TfrmGoodsKitEditorDialog.DocActionDB_ImportGoodsIntoComplect(const SourceDocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrUpdateGoodsComplecte;
    Query.AutoCommit := False;
    if not ibctrUpdateGoodsComplecte.Active then
      ibctrUpdateGoodsComplecte.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_COMPLECT_IMPORT_GOODS(:PARENTGOODS_ID,:SOURCE_DOCID)';
      Query.ParamByName('PARENTGOODS_ID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
      Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
      Query.ExecSQL;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.DoImportFromGoodsComplect;
begin

end;

procedure TfrmGoodsKitEditorDialog.dxBarButton1Click(Sender: TObject);
var
  Query: TIBCQuery;
begin
  // recalcul pret complect din complectatia curenta
  Query := TIBCQuery.Create(self);
  try
    Query.SQL.Text := 'EXECUTE PROCEDURE Update_Complectprices (:complectgoodsid)';
    Query.ParamByName('complectgoodsid').AsInteger := IBCQueryGoodsComplecte.FieldByName('PARENTGOODS_ID').AsInteger;
    Query.Transaction := dmdb.IBCTrDefaultUpdate;
    try
      if not Query.Transaction.Active then
        Query.Transaction.StartTransaction;
      Query.Execute;
      Query.Transaction.Commit;
      fMasterDataSet.Refresh;
    except
      on e: Exception do
      begin
        Query.Transaction.Rollback;
        raise
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsKitEditorDialog.dxBarButton3Click(Sender: TObject);
begin
  IBCQueryGoodsComplecte.DisableControls;
  try
  IBCQueryGoodsComplecte.First;
  while not IBCQueryGoodsComplecte.Eof do
  begin
    IBCQueryGoodsComplecte.Edit;
    IBCQueryGoodsComplecte.FieldByName('Qty').AsFloat := 0;
    IBCQueryGoodsComplecte.Post;
    IBCQueryGoodsComplecte.Next;
  end;
  finally
    IBCQueryGoodsComplecte.EnableControls;
  end;
end;

procedure TfrmGoodsKitEditorDialog.dxBarButton4Click(Sender: TObject);
var
  sList: TStringList;
  GoodsID: string;
  i: Integer;
  qty: string;
  q: TIBCQuery;
  GoodsCode: string;
begin
  sList := TStringList.Create;
  q := TIBCQuery.Create(nil);

  try
    sList.Text := Clipboard.AsText;
    q.SQL.Add('select goodsid from ts_goods_foreign where goods_code=:goods_code');
//    q.Prepare;
    for i:=0 to sList.Count-1 do
    begin
      q.Close;
      GoodsID := Copy(sList.Strings[i], 1, Pos(#9, sList.Strings[i])-1);
      Qty := Copy(sList.Strings[i], Pos(#9, sList.Strings[i])+1, length(sList.Strings[i]));
      GoodsCODE := goodsid;
      q.ParamByName('GOODS_CODE').AsString := GoodsID;
      q.Open;
      if q.RecordCount=1 then
      begin
        GoodsID := q.FieldByName('GOODSID').AsString;
      end
      else
        raise Exception.Create('Au fost gasite mai multe produse dupa acest cod, indicati codul intern manual!');

      IBCQueryGoodsComplecte.Append;
      IBCQueryGoodsComplecte.FieldByName('GoodsID').AsString := GoodsID;
      IBCQueryGoodsComplecte.FieldByName('QTY').AsString := qty;
      IBCQueryGoodsComplecte.FieldByName('FLG_ACTIVE').AsInteger := 1;
      IBCQueryGoodsComplecte.FieldByName('FLG_MODIFY_QTY').AsInteger := 1;
      IBCQueryGoodsComplecte.Post;
    end;
  finally
    slist.Free;
    q.Free;
  end;
  ModalResult := mrOK;
end;

procedure TfrmGoodsKitEditorDialog.BindingDataSource;
begin
  inherited;
  IBCQueryGoodsComplecte.MasterSource := fMasterDataSource;
  edGoodsID.DataBinding.DataSource := fMasterDataSource;
  edGoodsTitle.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmGoodsKitEditorDialog.IsFormDataPosted: Boolean;
begin
  dxBarButton1Click(self);
  IBCTrUpdateGoodsComplecte.Commit;
  Result := True;
end;

procedure TfrmGoodsKitEditorDialog.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
      Self.Position := poDesigned;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsKitEditorDialog.Prepare;
begin
  SetupQtyFields;

  IBCTrUpdateGoodsComplecte.StartTransaction;
  try
    dmDB.CreateGridImageColumnItems(cxGridComplecte_IMG);
    IBCQueryGoodsComplecte.MasterSource := MasterDataSource;
    IBCQueryGoodsComplecte.Active := True;
    SelectionChanged;
  except
    IBCQueryGoodsComplecte.Close;
    IBCTrUpdateGoodsComplecte.Rollback;
    raise;
  end;
end;

procedure TfrmGoodsKitEditorDialog.SaveStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    // form pos
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    // store column visibility and width
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmGoodsKitEditorDialog.SelectionChanged;
var
  fNew, fImport, fModify, fDelete, fSort, fChangeActive: Boolean;
begin
  fNew := True;
  fImport := True;
  fModify := False;
  fDelete := False;
  fSort := False;
  fChangeActive := False;

  if cxGridComplecteTable.DataController.RecNo > 0 then
  begin
    fModify := (True and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
    fDelete := (True and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
    fSort := cxGridComplecteTable.DataController.RecordCount > 1;
    fChangeActive := (True and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  end;

  bbNewItem.Enabled := (fNew and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  bbImportFromDoc.Enabled := (fImport and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  bbModify.Enabled := (fModify and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  bbRemove.Enabled := (fDelete and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  bbSortItems.Enabled := (fSort and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
  bbChangeActiveState.Enabled := (fChangeActive and SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte));
end;

procedure TfrmGoodsKitEditorDialog.SetupQtyFields;
var
  qtyDigitsMode: integer;
begin
  // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
  // Товарные позиции: Кол-во
  TcxCalcEditProperties(cxGridComplecte_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  cxGridComplecte_QTY.Summary.FooterFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmGoodsKitEditorDialog.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Modificare_complecte)		// Modificare complecte)
  then
  begin
    bbImportFromDoc.Enabled := False;

    bbNewItem.Enabled := False;
    bbModify.Enabled := False;
    bbRemove.Enabled := False;
    bbSortItems.Visible := ivNever;
    dxBarSubItem1.Visible := ivNever;
    dtDialogTitle.Color :=  $00C4C4FF;
  end;
//  else
//  begin
//     dtDialogTitle.Color :=  clWindow;
//  end;
end;



end.


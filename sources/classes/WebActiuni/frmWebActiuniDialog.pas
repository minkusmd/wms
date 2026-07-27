unit frmWebActiuniDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar,
    cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
    cxGrid, StdCtrls, DBAccess, IBC,
  MemDS, cxImageComboBox, cxContainer, cxLabel, cxDBLabel, cxImage, cxDBEdit,
    cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebActiuniDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnLeft: TPanel;
    pnRight: TPanel;
    cxGridATable: TcxGridDBTableView;
    cxGridALevel: TcxGridLevel;
    cxGridActiuni: TcxGrid;
    cxGridGTable: TcxGridDBTableView;
    cxGridGLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    bbActiuneNew: TdxBarButton;
    bbActiuneModify: TdxBarButton;
    bbActiuneDelete: TdxBarButton;
    bbGoodsAdd: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    cxGridA_ACTIUNEID: TcxGridDBColumn;
    cxGridA_TITLE_RUS: TcxGridDBColumn;
    cxGridA_START_DATE: TcxGridDBColumn;
    cxGridA_END_DATE: TcxGridDBColumn;
    cxGridG_GOODSID: TcxGridDBColumn;
    cxGridG_TITLE: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    IBCQueryActiuni: TIBCQuery;
    IBCDataSourceActiuni: TIBCDataSource;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    bbSortActiuni: TdxBarButton;
    bbGoodsDeleteAll: TdxBarButton;
    cxGridA_FLG_ENDED: TcxGridDBColumn;
    pnButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridG_IMG: TcxGridDBColumn;
    pnClientBottom: TPanel;
    cxDBImage1: TcxDBImage;
    cxDBLabel1: TcxDBLabel;
    cxDBLabel2: TcxDBLabel;
    cxDBLabel3: TcxDBLabel;
    IBCQueryGoodsInfo: TIBCQuery;
    IBCDataSourceGoodsInfo: TIBCDataSource;
    cxDBLabel4: TcxDBLabel;
    cxDBLabel5: TcxDBLabel;
    cxDBLabel6: TcxDBLabel;
    cxDBLabel7: TcxDBLabel;
    cxDBLabel8: TcxDBLabel;
    procedure cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridGTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbActiuneNewClick(Sender: TObject);
    procedure bbActiuneModifyClick(Sender: TObject);
    procedure cxGridATableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bbActiuneDeleteClick(Sender: TObject);
    procedure bbGoodsAddClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbSortActiuniClick(Sender: TObject);
    procedure bbGoodsDeleteAllClick(Sender: TObject);
    procedure cxGridATableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
  private
    { Private declarations }
    fChanged: Boolean;
    fLastGoodsID: integer;
    procedure SelectionActiuniChanged;
    procedure SelectionGoodsChanged;

    procedure ShowAddNewActiuneDialog;
    procedure ShowEditActiuneDialog;
    procedure DeleteActiune;

    procedure ShowAddNewGoodsDialog;

    procedure AddGoodsFromFolder(const ParentID: integer);
    procedure AddGoods(const GoodsID: integer);
    procedure DeleteAllGoods(const ActiuneID: integer);

    function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    procedure WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle:
      string; var Added: Boolean; var Count: integer);

  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure LoadStates; override;
    procedure SaveStates; override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNDBErrors, frmWebActiuniEditorDialog,
SWNUtils, frmGoods,
  frmChangeOrderNoDialog, SWNValueStorageUnit;

{$R *.dfm}
{ TfrmWebActiuniDlg }

procedure TfrmWebActiuniDlg.AddGoods(const GoodsID: integer);
begin
  IBCQueryGoods.Insert;
  try
    IBCQueryGoods.FieldByName('ACTIUNEID').AsInteger :=
      IBCQueryActiuni.FieldByName('ACTIUNEID').AsInteger;
    IBCQueryGoods.FieldByName('GOODSID').AsInteger := GoodsID;
    IBCQueryGoods.Post;
    fLastGoodsID := GoodsID;
  except
    on E: Exception do
    begin
      IBCQueryGoods.Cancel;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmWebActiuniDlg.AddGoodsFromFolder(const ParentID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrUpdate;
    Query.SQL.Text := 'SELECT GOODSID FROM TS_GOODS WHERE PARENTID=:id';
    Query.ParamByName('id').AsInteger := ParentID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      AddGoods(Query.Fields[0].AsInteger);
      Query.Next;
    end;
    fLastGoodsID := ParentID;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebActiuniDlg.bbActiuneDeleteClick(Sender: TObject);
begin
  DeleteActiune;
end;

procedure TfrmWebActiuniDlg.bbActiuneModifyClick(Sender: TObject);
begin
  ShowEditActiuneDialog;
end;

procedure TfrmWebActiuniDlg.bbActiuneNewClick(Sender: TObject);
begin
  ShowAddNewActiuneDialog;
end;

procedure TfrmWebActiuniDlg.bbGoodsAddClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure TfrmWebActiuniDlg.bbGoodsDeleteAllClick(Sender: TObject);
begin
  if ShowAskDialog('Удаление товаров', 'Удалить все товары из списка?') = mrYes
    then
  begin
    DeleteAllGoods(IBCQueryActiuni.FieldByName('ACTIUNEID').AsInteger);
    IBCQueryGoods.Refresh;
  end;
end;

procedure TfrmWebActiuniDlg.bbGoodsDeleteClick(Sender: TObject);
begin
  IBCQueryGoods.Delete;
end;

procedure TfrmWebActiuniDlg.bbSortActiuniClick(Sender: TObject);
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self, IBCTrUpdate);
  try
    dialog.DBTable := cotWebActiuni;
    dialog.WhereParam := IntToStr(dmDB.CurrentFirma);
    if dialog.ShowModal = mrOk then
    begin
      IBCQueryActiuni.Close;
      IBCQueryActiuni.Active := True;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebActiuniDlg.cxGridATableCellDblClick(Sender:
  TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and bbActiuneModify.Enabled then
  begin
    bbActiuneModifyClick(bbActiuneModify);
    AHandled := True;
  end;
end;

procedure TfrmWebActiuniDlg.cxGridATableFocusedRecordChanged(Sender:
  TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
    ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionActiuniChanged;
end;

procedure TfrmWebActiuniDlg.cxGridATableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridA_FLG_ENDED.Index]) then
  begin
    if ARecord.Values[cxGridA_FLG_ENDED.Index] = 1 then
      AStyle := dmAdditions.cxStyle_TextGray;
  end;
end;

procedure TfrmWebActiuniDlg.cxGridGTableFocusedRecordChanged(Sender:
  TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
    ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionGoodsChanged;
end;

procedure TfrmWebActiuniDlg.DeleteActiune;
begin
  if ShowAskDialog('Удаление акции', Format('Вы хотите удалить акцию "%s"?',
    [IBCQueryActiuni.FieldByName('TITLE_RUS').AsString]),
    'Будут удаленны все товары из списка!') = mrYes then
  begin
    IBCQueryActiuni.Delete;
    fChanged := True;
  end;
end;

procedure TfrmWebActiuniDlg.DeleteAllGoods(const ActiuneID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := IBCTrUpdate;
    Query.SQL.Text := 'DELETE FROM TWEB_ACTIUNI_GOODS WHERE ACTIUNEID = :id';
    Query.ParamByName('id').AsInteger := ActiuneID;
    try
      Query.ExecSQL;
    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebActiuniDlg.FormCloseQuery(Sender: TObject; var CanClose:
  Boolean);
begin
  if fChanged and (ModalResult <> mrOk) then
  begin
    if (ShowAskDialog('Данные изменены',
      'Данные были изменены. Вы хотите выйти без сохранение?') <> mrYes) then
      CanClose := False;
  end;
end;

function TfrmWebActiuniDlg.IsFormDataPosted: Boolean;
begin
  IBCTrUpdate.Commit;
  Result := True;
end;

procedure TfrmWebActiuniDlg.LoadStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
      then
      AppUserConfigStorage.FormPositions.ReadFormPos(Self);
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns)
      then
    begin
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridATable);
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGTable);
    end;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebActiuniDlg.Prepare;
begin
  fLastGoodsID := 0;

  dtDialogTitle.Title := Format('Веб-акции для фирмы "%s"',
    [dmDB.CurrentFirmaName]);

  IBCTrUpdate.StartTransaction;
  try
    IBCQueryActiuni.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
    IBCQueryActiuni.Active := True;
    IBCQueryGoods.Active := True;
    IBCQueryGoodsInfo.Active := True;

    SelectionActiuniChanged;
    fChanged := False;
  except
    IBCTrUpdate.Rollback;
    raise;
  end;
end;

procedure TfrmWebActiuniDlg.SaveStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos)
      then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns)
      then
    begin
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridATable);
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGTable);
    end;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure TfrmWebActiuniDlg.SelectionActiuniChanged;
var
  fAdd, fEdit, fDelete, fAddGoods: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  fAddGoods := False;
  if (cxGridATable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
    fAddGoods := True;
  end;

  bbActiuneNew.Enabled := fAdd;
  bbActiuneModify.Enabled := fEdit;
  bbActiuneDelete.Enabled := fDelete;

  bbGoodsAdd.Enabled := fAddGoods;

  SelectionGoodsChanged;
end;

procedure TfrmWebActiuniDlg.SelectionGoodsChanged;
var
  fDelete, fDeleteAll: Boolean;
begin
  fDelete := False;
  fDeleteAll := cxGridGTable.DataController.RecordCount > 1;

  if (cxGridGTable.DataController.RecNo > 0) then
  begin
    fDelete := True;
  end;

  bbGoodsDelete.Enabled := fDelete;
  bbGoodsDeleteAll.Enabled := fDeleteAll;
end;

procedure TfrmWebActiuniDlg.ShowAddNewActiuneDialog;
var
  dialog: TfrmWebActiuniEditorDlg;
begin
  dialog := TfrmWebActiuniEditorDlg.Create(Self, IBCQueryActiuni,
    IBCDataSourceActiuni);
  try
    dialog.CreateNewActiune := True;
    dialog.DT := dmDB.CurrentFirma;
    fChanged := dialog.ShowModal = mrOk;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebActiuniDlg.ShowAddNewGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.OnCheckIfGoodsExists := WhenCheckIfGoodsExists;
    dialog.OnBurstAddGoods := WhenBurstAddGoods;
    dialog.BurstMode := True;
    if dialog.SelectGoods(fLastGoodsID, True, 0,
      'Выбор товара или папки для акции') then
    begin
      if (dialog.GoodsIsFolder) then
      begin
        if ShowAskDialog('Папка', 'Вы хотите добавить все товары из папки?') =
          mrYes then
          AddGoodsFromFolder(dialog.GoodsID);
      end
      else
        AddGoods(dialog.GoodsID);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebActiuniDlg.ShowEditActiuneDialog;
var
  dialog: TfrmWebActiuniEditorDlg;
begin
  dialog := TfrmWebActiuniEditorDlg.Create(Self, IBCQueryActiuni,
    IBCDataSourceActiuni);
  try
    dialog.CreateNewActiune := False;
    if dialog.ShowModal = mrOk then
      fChanged := True;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebActiuniDlg.WhenBurstAddGoods(const GoodsID: integer; const
  GoodsTitle: string; var Added: Boolean; var Count: integer);
begin
  if WhenCheckIfGoodsExists(GoodsID) then
  begin
    Added := False;
    Count := 0;
  end
  else
  begin
    AddGoods(GoodsID);
    Added := True;
    Count := 1;
  end;
end;

procedure TfrmWebActiuniDlg.WhenCancelForm;
begin
  IBCTrUpdate.Rollback;
end;

function TfrmWebActiuniDlg.WhenCheckIfGoodsExists(const GoodsID: integer):
  Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridGTable.DataController.RecordCount - 1 do
    if (cxGridGTable.DataController.Values[i, cxGridG_GOODSID.Index] = GoodsID)
      then
    begin
      Result := True;
      break;
    end;
end;

end.


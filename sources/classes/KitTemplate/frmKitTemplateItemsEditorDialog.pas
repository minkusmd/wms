unit frmKitTemplateItemsEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxCustomData,
  DB, cxDBData, MemDS, DBAccess, IBC, dxBar, cxTextEdit,
  cxDBEdit, StdCtrls, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DialogTitle, cxCalc,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCheckBox, cxContainer, Vcl.Menus,
  cxClasses, cxGridCustomView;

type
  TfrmKitTemplateItemsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewGoods: TdxBarButton;
    bbModifyItem: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTemplateDetails: TcxGrid;
    cxGridTemplateDetailsTable: TcxGridDBTableView;
    cxGridTemplateItemCol_ID: TcxGridDBColumn;
    cxGridTemplateItemCol_GOODS_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_UM_NAME: TcxGridDBColumn;
    cxGridTemplateItemCol_QTY: TcxGridDBColumn;
    cxGridTemplateItemCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridTemplateLevel: TcxGridLevel;
    pnKit: TPanel;
    edTITLE: TcxDBTextEdit;
    cxLabel1: TLabel;
    IBCDataSourceItems: TIBCDataSource;
    IBCQueryItems: TIBCQuery;
    cxGridTemplateItem_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridTemplateItem_ORDERNO: TcxGridDBColumn;
    bbSortItem: TdxBarButton;
    Label1: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridTemplateDetailsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyItemClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridTemplateDetailsTableKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbSortItemClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure ChangeItemCount(const IncCount:Boolean);
    procedure ChangeItemActiveFlag;
    procedure ShowSortItemsDialog;

    procedure LockTemplateItems;
    procedure SetupQtyItems;
  protected
    { Protected eclarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

uses SWNUtils, SWNDBErrors,
  frmChangeOrderNoDialog, DataModuleDB, SWNConst, SWNValueStorageUnit, frmKitTemplateGoodsEditorDialog;

{$R *.dfm}

{ TfrmKitTemplateItemsEditorDlg }

procedure TfrmKitTemplateItemsEditorDlg.bbModifyItemClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure TfrmKitTemplateItemsEditorDlg.bbNewGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure TfrmKitTemplateItemsEditorDlg.bbRemoveItemClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure TfrmKitTemplateItemsEditorDlg.btnOkClick(Sender: TObject);
begin
     fMasterDataSet.UpdateTransaction.Commit;

     ModalResult:=mrOk;
end;

procedure TfrmKitTemplateItemsEditorDlg.ChangeItemActiveFlag;
var RecNo,N:integer;
begin
     if cxGridTemplateDetailsTable.DataController.RecNo>0 then
     begin
          RecNo:=cxGridTemplateDetailsTable.DataController.GetFocusedRecordIndex;
          N:=cxGridTemplateDetailsTable.DataController.Values[RecNo,cxGridTemplateItemCol_FLG_ACTIVE.Index];
          if N=1 then N:=0 else N:=1;

          IBCQueryItems.Edit;
          try
             IBCQueryItems.FieldByName('FLG_ACTIVE').AsInteger:=N;
             IBCQueryItems.Post;
          except on E:Exception do
             begin
                  IBCQueryItems.Cancel;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.ChangeItemCount(const IncCount: Boolean);
var RecNo:integer;
    oldValue,newValue:Double;
begin
     if cxGridTemplateDetailsTable.DataController.RecNo>0 then
     begin
          RecNo:=cxGridTemplateDetailsTable.DataController.GetFocusedRecordIndex;
          oldValue:=cxGridTemplateDetailsTable.DataController.Values[RecNo,cxGridTemplateItemCol_QTY.Index];
          newValue:=oldValue;
          if IncCount then newValue:=oldValue+1
            else if (oldValue>1) then newValue:=oldValue-1;

          if (newValue<>oldValue) then
          begin
               IBCQueryItems.Edit;
               try
                  IBCQueryItems.FieldByName('QTY').AsFloat:=newValue;
                  IBCQueryItems.Post;
               except on E:Exception do
                  begin
                       IBCQueryItems.Cancel;
                       if Not ProcessSWNError(E) then raise;
                  end;
               end;
          end;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.cxGridTemplateDetailsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModifyItem.Enabled then
     begin
          if cxGridTemplateItemCol_QTY.Focused then
          begin

          end
          else
          if cxGridTemplateItemCol_FLG_ACTIVE.Focused then
          begin
               ChangeItemActiveFlag;
          end
          else
          begin
               ShowModifyGoodsDialog;
               AHandled:=True;
          end;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.cxGridTemplateDetailsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmKitTemplateItemsEditorDlg.cxGridTemplateDetailsTableKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=VK_ADD) or (Key=VK_SUBTRACT) or (Key=VK_OEM_PLUS) or (Key=VK_OEM_MINUS) then ChangeItemCount((Key=VK_ADD) or (Key=VK_OEM_PLUS))
     else
     // Ctrl+A
     if (Key=65) and (Shift=[ssCtrl]) then ChangeItemActiveFlag;
end;

procedure TfrmKitTemplateItemsEditorDlg.DeleteSelectedGoods;
var S:String;
begin
     S:=#13#10+IBCQueryItems.FieldByName('GOODS_NAME').AsString+' ?';
     if ShowAskDialog('Удаление товара','Удалить из состава конфигурации товар'+S)=mrYes then
     begin
          IBCQueryItems.Delete;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.bbSortItemClick(Sender: TObject);
begin
     ShowSortItemsDialog;
end;

procedure TfrmKitTemplateItemsEditorDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if ModalResult<>mrOk then
     begin
          fMasterDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.BindingDataSource;
begin
     edTITLE.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryItems.MasterSource:=fMasterDataSource;
     IBCQueryItems.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryItems.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryItems.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
end;

procedure TfrmKitTemplateItemsEditorDlg.LockTemplateItems;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='SELECT NULL FROM TS_KIT_TEMPLATE_ITEMS WHERE KITTEMPLATEID=:KITTEMPLATEID FOR UPDATE WITH LOCK';
        Query.ParamByName('KITTEMPLATEID').AsInteger:=fMasterDataSet.FieldByName('KITTEMPLATEID').AsInteger;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.Prepare;
begin
     SetupQtyItems;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        LockTemplateItems;
        dmDB.CreateGridImageColumnItems(cxGridTemplateItem_GOODS_TYPE_ID);
        IBCQueryItems.Active:=True;
        SelectionChanged;
        cxGridTemplateItemCol_GOODS_NAME.Focused:=True;
     except
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.SelectionChanged;
var fAdd,fEdit,fDelete,fCanSort:Boolean;
begin
     fAdd:=True;     // New Goods + Security
     fEdit:=False;
     fDelete:=False;
     fCanSort:=cxGridTemplateDetailsTable.DataController.RecordCount>1;

     if cxGridTemplateDetailsTable.DataController.RecNo>0 then
     begin
          fEdit:=True;   // Edit Goods + Security
          fDelete:=True; // Delete Goods + Security
     end;

     bbNewGoods.Enabled:=fAdd;
     bbModifyItem.Enabled:=fEdit;
     bbRemoveItem.Enabled:=fDelete;
     bbSortItem.Enabled:=fCanSort;
end;

procedure TfrmKitTemplateItemsEditorDlg.SetupQtyItems;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Товарные позиции: Кол-во
     TcxCalcEditProperties(cxGridTemplateItemCol_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
     cxGridTemplateItemCol_QTY.Summary.FooterFormat:=cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmKitTemplateItemsEditorDlg.ShowAddGoodsDialog;
var dialog:TfrmKitTemplateGoodsEditorDlg;
begin
     dialog:=TfrmKitTemplateGoodsEditorDlg.Create(Self,IBCQueryItems,IBCDataSourceItems);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.ShowModifyGoodsDialog;
var dialog:TfrmKitTemplateGoodsEditorDlg;
begin
     dialog:=TfrmKitTemplateGoodsEditorDlg.Create(Self,IBCQueryItems,IBCDataSourceItems);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmKitTemplateItemsEditorDlg.ShowSortItemsDialog;
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self,fMasterDataSet.UpdateTransaction);
     try
        dialog.DBTable:=cosKIT;
        dialog.ParentID:=fMasterDataSet.FieldByName('KITTEMPLATEID').AsInteger;
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryItems.Refresh;
        end;
     finally
        dialog.Free;
     end;

end;

end.

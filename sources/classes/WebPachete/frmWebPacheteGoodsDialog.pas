unit frmWebPacheteGoodsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImageComboBox, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGrid, Vcl.StdCtrls, DBAccess, IBC, MemDS, cxContainer,
  cxTextEdit, cxMaskEdit, cxButtonEdit, dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxScrollbarAnnotations;

type
  TfrmWebPacheteGoodsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_GOODS_NAME: TcxGridDBColumn;
    cxGridGoods_IMG: TcxGridDBColumn;
    cxGridGoods_ORDERNO: TcxGridDBColumn;
    btnOk: TButton;
    btnCancel: TButton;
    bbAdd: TdxBarButton;
    bbRemove: TdxBarButton;
    bbSort: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridGoods_PRICE: TcxGridDBColumn;
    cxGridGoods_DISCOUNT: TcxGridDBColumn;
    bbEdit: TdxBarButton;
    cxGridGoods_PRICE_CATALOG: TcxGridDBColumn;
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbRemoveClick(Sender: TObject);
    procedure bbAddClick(Sender: TObject);
    procedure bbSortClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
  private
    { Private declarations }
    fLastGoodsID:Integer;
    procedure SelectionChanged;
    function WhenCheckIfGoodsExists(const GoodsID: integer):Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;
  public
    { Public declarations }
  end;


implementation


uses DataModuleAdditions, DataModuleDB, frmGoods, SWNDBErrors, frmChangeOrderNoDialog,
  frmWebPacheteGoodsEditorUnit;

{$R *.dfm}



procedure TfrmWebPacheteGoodsDlg.bbAddClick(Sender: TObject);
begin
  var dialog := TfrmWebPacheteGoodsEditorDlg.Create(self, ibcquerygoods, ibcdatasourcegoods);
  try
    dialog.IsNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;


procedure TfrmWebPacheteGoodsDlg.bbEditClick(Sender: TObject);
begin
  var dialog := TfrmWebPacheteGoodsEditorDlg.Create(self, ibcquerygoods, ibcdatasourcegoods);
  try
    dialog.IsNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebPacheteGoodsDlg.bbRemoveClick(Sender: TObject);
begin
     cxGridGoodsTable.DataController.DeleteFocused;
end;

procedure TfrmWebPacheteGoodsDlg.bbSortClick(Sender: TObject);
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self);
     try
        dialog.DBTable:=cotPacheteProduseContinut;
        dialog.ParentID:=fMasterDataSet.FieldByName('PACHET_ID').AsInteger;
        if dialog.ShowModal=mrOk then IBCQueryGoods.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebPacheteGoodsDlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmWebPacheteGoodsDlg.BindingDataSource;
begin
     inherited;
     IBCQueryGoods.Transaction:=fMasterDataSet.Transaction;
     IBCQueryGoods.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryGoods.MasterSource:=fMasterDataSource;
end;

function TfrmWebPacheteGoodsDlg.IsFormDataPosted: Boolean;
begin
     IBCQueryGoods.Close;
     fMasterDataSet.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmWebPacheteGoodsDlg.Prepare;
begin
     cxGridGoods_GOODS_NAME.Focused:=True;

     fMasterDataSet.UpdateTransaction.StartTransaction;
     IBCQueryGoods.Active:=True;
     SelectionChanged;
end;

procedure TfrmWebPacheteGoodsDlg.SelectionChanged;
var fAdd,fRemove,fSort:Boolean;
begin
     fAdd:=True;
     fRemove:=False;
     fSort:=cxGridGoodsTable.DataController.RecordCount>1;

     if cxGridGoodsTable.DataController.RecNo>0 then
     begin
          fRemove:=True;
     end;

     bbAdd.Enabled:=fAdd;
     bbRemove.Enabled:=fRemove;
     bbSort.Enabled:=fSort;
end;

procedure TfrmWebPacheteGoodsDlg.WhenCancelForm;
begin
     IBCQueryGoods.Close;
     fMasterDataSet.UpdateTransaction.Rollback;
end;

function TfrmWebPacheteGoodsDlg.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     if cxGridGoodsTable.DataController.Values[i,cxGridGoods_GOODSID.Index]=GoodsID then
     begin
          Result:=True;
          Break;
     end;
end;

end.

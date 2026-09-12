unit frmGoodsCompatibleGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  SWNBaseUnit,
  Dialogs, DialogTitle, DB, cxDBData, DBAccess,
  IBC, MemDS, dxBar, StdCtrls, cxDBEdit, ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid,

  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxMaskEdit,
  Vcl.Menus, cxClasses, cxGridTableView, cxGridCustomView, cxTextEdit;

type
  TfrmGoodsCompatibleGoodsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable_GOODSID: TcxGridDBColumn;
    cxGridGoodsTable_GOODS_NAME: TcxGridDBColumn;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edGOODS_NAME: TcxDBTextEdit;
    IBCQueryCompatible: TIBCQuery;
    IBCDataSourceCompatible: TIBCDataSource;
    bbReorder: TdxBarButton;
    edGOODSID: TcxDBTextEdit;
    Bevel1: TBevel;
    bbModifyGoods: TdxBarButton;
    cxGridGoodsTable_ORDERNO: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    bbCustomDiffPrice: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    cxGridGoodsTable_IMG: TcxGridDBColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure bbReorderClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fDefaultPercent:integer;
    procedure SelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowReorderDialog;
    procedure ShowModifyPricePercentDialog;

    function WhenCheckIfGoodsExists(const GoodsID:integer):Boolean;
    procedure WhenAddGoodsBurst(const GoodsID:integer; const GoodsTitle:String; var Added:Boolean; var Count:integer);
    function GetNextOrderNo:integer;
    procedure SetCustomPriceDiffPercent(const CustomPercent:integer);

  protected
    { Protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;

    function IsFormDataPosted:Boolean;override;
    procedure WhenCancelForm;override;

  public
    { Public declarations }
  end;

implementation

uses SWNUtils, frmChangeOrderNoDialog, SWNDBErrors, frmGoods, frmGoodsCompatiblePriceDiffPercentDialog, DataModuleDB;

{$R *.dfm}

{ TfrmGoodsCompatibleGoodsDlg }

procedure TfrmGoodsCompatibleGoodsDlg.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure TfrmGoodsCompatibleGoodsDlg.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure TfrmGoodsCompatibleGoodsDlg.bbRemoveGoodsClick(Sender: TObject);
begin
     try
        IBCQueryCompatible.Delete;
     except on E:Exception do
        begin
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.bbReorderClick(Sender: TObject);
begin
     ShowReorderDialog;
end;

procedure TfrmGoodsCompatibleGoodsDlg.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  ShowModifyGoodsDialog;
  AHandled:=True;
end;

procedure TfrmGoodsCompatibleGoodsDlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmGoodsCompatibleGoodsDlg.dxBarButton1Click(Sender: TObject);
var diff:integer;
begin
     diff:=TdxBarButton(Sender).Tag;
     if ShowAskDialog('Diferenta de pret',Format('Setati diferenta de pret pentru toate marfurile la %d%%?',[diff]))=mrYes then
     begin
          SetCustomPriceDiffPercent(diff);
          IBCQueryCompatible.Refresh;
     end;
end;

function TfrmGoodsCompatibleGoodsDlg.GetNextOrderNo: integer;
var i,N:integer;
begin
     Result:=0;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     begin
          N:=cxGridGoodsTable.DataController.Values[i,cxGridGoodsTable_ORDERNO.Index];
          if N>Result then Result:=N;
     end;
     Inc(Result);
end;

procedure TfrmGoodsCompatibleGoodsDlg.BindingDataSource;
begin
     inherited;

     fDefaultPercent:=2; // %
     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     edGOODS_NAME.DataBinding.DataSource:=fMasterDataSource;
     IBCQueryCompatible.Connection:=fIBCConnection;
     IBCQueryCompatible.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryCompatible.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryCompatible.MasterSource:=fMasterDataSource;
end;

function TfrmGoodsCompatibleGoodsDlg.IsFormDataPosted: Boolean;
begin
     fMasterDataSet.UpdateTransaction.Commit;
     Result:=True;
end;

procedure TfrmGoodsCompatibleGoodsDlg.Prepare;
begin
     fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        dmDB.CreateGridImageColumnItems(cxGridGoodsTable_IMG);
        IBCQueryCompatible.Active:=True;
        SelectionChanged;
     except
        IBCQueryCompatible.Active:=False;
        fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.SelectionChanged;
var fAdd,fModify,fRemove,fReorder:Boolean;
begin
     fAdd:=True; // Add + Security
     fModify:=False;
     fRemove:=False;
     fReorder:=cxGridGoodsTable.DataController.RecordCount>0;
     if cxGridGoodsTable.DataController.RecNo>0 then
     begin
          fModify:=True;  // Modify
          fRemove:=True; // Delete + Security
     end;
     bbAddGoods.Enabled:=fAdd;
     bbModifyGoods.Enabled:=fModify;
     bbRemoveGoods.Enabled:=fRemove;
     bbReorder.Enabled:=fReorder;
     bbCustomDiffPrice.Enabled:=fReorder;
end;

procedure TfrmGoodsCompatibleGoodsDlg.SetCustomPriceDiffPercent(const CustomPercent: integer);
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=fMasterDataSet.Connection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        Query.SQL.Text:='UPDATE TS_GOODS_COMPATIBLE SET DIFFSUMPERCENT=:DIFF WHERE GOODSID=:GoodsID';
        Query.ParamByName('DIFF').AsInteger:=CustomPercent;
        Query.ParamByName('GoodsID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.ShowAddGoodsDialog;
var dialog:TfrmGoodsBrowser;
    tmpAdded:Boolean;
    tmpCount:integer;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.BurstMode:=True;
        dialog.OnCheckIfGoodsExists:=WhenCheckIfGoodsExists;
        dialog.OnBurstAddGoods:=WhenAddGoodsBurst;
        if dialog.ShowModal=mrOk then WhenAddGoodsBurst(dialog.GoodsID,dialog.GoodsTitle,tmpAdded,tmpCount);
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.ShowModifyGoodsDialog;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.GoodsID:=IBCQueryCompatible.FieldByName('COMPATIBLE_GOODSID').AsInteger;
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryCompatible.Edit;
             try
                IBCQueryCompatible.FieldByName('COMPATIBLE_GOODSID').AsInteger:=dialog.GoodsID;
                IBCQueryCompatible.Post;
             except on E:Exception do
                begin
                     IBCQueryCompatible.Cancel;
                     if Not ProcessSWNError(E) then raise;
                end;
             end;
      end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.ShowModifyPricePercentDialog;
var dialog:TfrmGoodsCompatiblePriceDiffPercentDlg;
begin
     dialog:=TfrmGoodsCompatiblePriceDiffPercentDlg.Create(Self,IBCQueryCompatible,IBCDataSourceCompatible);
     try
        if dialog.ShowModal=mrOk then
        begin
             if dialog.MakeDefault then fDefaultPercent:=IBCQueryCompatible.FieldByName('DIFFSUMPERCENT').AsInteger;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.ShowReorderDialog;
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self,fMasterDataSet.UpdateTransaction);
     try
        dialog.DBTable:=cotGOODS_COMPATIBLE;
        dialog.ParentID:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        if dialog.ShowModal=mrOk then
        begin
             // refresh data
             IBCQueryCompatible.Close;
             IBCQueryCompatible.Active:=True;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.WhenAddGoodsBurst(const GoodsID: integer; const GoodsTitle: String; var Added: Boolean; var Count: integer);
var OrderNo:integer;
begin
     OrderNo:=GetNextOrderNo;
     IBCQueryCompatible.Append;
     try
        IBCQueryCompatible.FieldByName('COMPATIBLE_GOODSID').AsInteger:=GoodsID;
        IBCQueryCompatible.FieldByName('COMPATIBLE_GOODS_NAME').AsString:=GoodsTitle;
        IBCQueryCompatible.FieldByName('DIFFSUMPERCENT').AsInteger:=fDefaultPercent;
        IBCQueryCompatible.FieldByName('ORDERNO').AsInteger:=OrderNo;
        IBCQueryCompatible.Post;
        Added:=True;
        Count:=1;
     except on E:Exception do
        begin
             IBCQueryCompatible.Cancel;
             Added:=False;
             Count:=0;
             //if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmGoodsCompatibleGoodsDlg.WhenCancelForm;
begin
     fMasterDataSet.UpdateTransaction.Rollback;
end;

function TfrmGoodsCompatibleGoodsDlg.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     if cxGridGoodsTable.DataController.Values[i,cxGridGoodsTable_GOODSID.Index]=GoodsID then
     begin
          Result:=True;
          Break;
     end;
end;

end.

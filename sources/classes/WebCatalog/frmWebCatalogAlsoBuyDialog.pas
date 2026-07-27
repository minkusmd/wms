unit frmWebCatalogAlsoBuyDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, dxBar,
  cxClasses, cxGridLevel, cxGridCustomView, cxGrid, Vcl.ExtCtrls, DialogTitle, Vcl.StdCtrls, DBAccess, IBC, MemDS, cxImageComboBox,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebCatalogAlsoBuyDlg = class(TSWNMasteredFormClass)
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbAddGroup: TdxBarButton;
    bbRemoveGroup: TdxBarButton;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryData: TIBCQuery;
    IBCDataSourceData: TIBCDataSource;
    cxGridTable_IMG: TcxGridDBColumn;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddGroupClick(Sender: TObject);
    procedure bbRemoveGroupClick(Sender: TObject);
  private
    { Private declarations }
    fLastGoodsID: Integer;
    procedure SelectionChanged;
    procedure ShowAddNewGroupDialog;
    procedure WhenAddGoodsFolder(const GoodsID: Integer; const GoodsTitle: String);
    function GoodsFolderExists(const GoodsID: Integer): Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, frmGoods;

procedure TfrmWebCatalogAlsoBuyDlg.bbAddGroupClick(Sender: TObject);
begin
  ShowAddNewGroupDialog;
end;

procedure TfrmWebCatalogAlsoBuyDlg.bbRemoveGroupClick(Sender: TObject);
begin
  IBCQueryData.Delete;
end;

procedure TfrmWebCatalogAlsoBuyDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

function TfrmWebCatalogAlsoBuyDlg.GoodsFolderExists(const GoodsID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridTable.DataController.RecordCount - 1 do
    if cxGridTable.DataController.Values[i, cxGridTable_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      Break;
    end;
end;

procedure TfrmWebCatalogAlsoBuyDlg.BindingDataSource;
begin
  fLastGoodsID := 0;
  IBCQueryData.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryData.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryData.MasterSource := fMasterDataSource;
end;

function TfrmWebCatalogAlsoBuyDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryData.state in dsEditModes then
    IBCQueryData.Post;
  fMasterDataSet.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmWebCatalogAlsoBuyDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  IBCQueryData.Active := True;
  SelectionChanged;
end;

procedure TfrmWebCatalogAlsoBuyDlg.SelectionChanged;
var
  fAdd, fRemove: Boolean;
begin
  fAdd := True;
  fRemove := False;
  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fRemove := True;
  end;
  bbAddGroup.Enabled := fAdd;
  bbRemoveGroup.Enabled := fRemove;
end;

procedure TfrmWebCatalogAlsoBuyDlg.ShowAddNewGroupDialog;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(fLastGoodsID, True, 0, 'Indicati ce grupe de produse se mai cumpara cu acest produs') and dialog.GoodsIsFolder then
    begin
      WhenAddGoodsFolder(dialog.GoodsID, dialog.GoodsTitle);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogAlsoBuyDlg.WhenAddGoodsFolder(const GoodsID: Integer; const GoodsTitle: String);
begin
  if Not GoodsFolderExists(GoodsID) then
  begin
    IBCQueryData.Insert;
    IBCQueryData.FieldByName('CATALOGID').AsInteger := fMasterDataSet.FieldByName('CATALOGID').AsInteger;
    IBCQueryData.FieldByName('GOODSID').AsInteger := GoodsID;
    IBCQueryData.Post;
    fLastGoodsID := GoodsID;
  end;
end;

procedure TfrmWebCatalogAlsoBuyDlg.WhenCancelForm;
begin
  if IBCQueryData.state in dsEditModes then
    IBCQueryData.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

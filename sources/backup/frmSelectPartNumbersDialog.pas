unit frmSelectPartNumbersDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SWNBaseUnit, DialogTitle, Menus, cxLookAndFeelPainters, ExtCtrls,
  StdCtrls, cxButtons, cxStyles, dxBar, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBAccess, IBC, MemDS, cxTextEdit, cxContainer, cxLabel, cxGraphics,
  cxLookAndFeels, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData;

type
  TfrmSelectPartsDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    btnOk: TcxButton;
    pnClient: TPanel;
    cxGridAPartsTable: TcxGridDBTableView;
    cxGridAPartsLevel: TcxGridLevel;
    cxGridAParts: TcxGrid;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    IBCGetParts: TIBCQuery;
    dsGetParts: TIBCDataSource;
    cxGridAPartsTablePartNO: TcxGridDBColumn;
    cxGridSParts: TcxGrid;
    cxGridSPartsTable: TcxGridDBTableView;
    cxGridDBPartNO: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    IBCSetParts: TIBCQuery;
    dsSetParts: TIBCDataSource;
    dxBarButton2: TdxBarButton;
    cxGridAPartsTableQTY: TcxGridDBColumn;
    cxGridSPartsTableQTY: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    cxButton1: TcxButton;
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FJurnalQTY: extended;
    fGoodsWarranty: integer;
    procedure ReadGoodsWarranty(GoodsID: integer);
    procedure CreateAvailablePartNumbers;
  protected
    procedure InitValues; override;
  public
    { Public declarations }
  end;

implementation

uses
  swnUtils, DataModuleDB, frmInputDialog, DataModuleAdditions;

{$R *.dfm}

{ TfrmSelectSNDlg }

procedure TfrmSelectPartsDlg.CreateAvailablePartNumbers;
begin
  fIBCConnection.ExecProc('GET_PARTS_DEP_GOODS', [fMasterDataSet.FieldByName('GOODSID').AsInteger, fMasterDataSet.FieldByName('DTDEP').AsInteger, fFirmaID]);
end;

procedure TfrmSelectPartsDlg.dxBarButton1Click(Sender: TObject);
var
  PARTNO: string;
  frmInputDlg: TfrmInputDlg;
  FQty: Extended;
begin
  PARTNO := IBCGetParts.FieldByName('PARTNO').AsString;

  frmInputDlg := TfrmInputDlg.Create(self);
  FQty := frmInputDlg.InputQtyDlg(FMasterDataSet.FieldByName('QTY').AsFloat);

  if IBCSetParts.Locate('PARTNO', PARTNO, []) then
  begin
    IBCSetParts.Edit;
    IBCSetParts.FieldByName('QTY').AsFloat := IBCSetParts.FieldByName('QTY').AsFloat + FQty;
    try
      IBCSetParts.Post;
      IBCGetParts.Edit;
      IBCGetParts.FieldByName('QTY').AsFloat := IBCGetParts.FieldByName('QTY').AsFloat - FQty;
      IBCGetParts.Post;
    except
      IBCSetParts.Cancel;
      raise;
    end;
  end
  else
  begin
    IBCSetParts.Append;
    IBCSetParts.FieldByName('QTY').AsFloat := FQty;
    IBCSetParts.FieldByName('PARTNO').AsString := PARTNO;
    IBCSetParts.FieldByName('VENDORWARRANTY').AsInteger := fMasterDataSet.FieldByName('WARRANTY').AsInteger;
    IBCSetParts.FieldByName('OWNWARRANTY').AsInteger := fGoodsWarranty;
    try
      IBCSetParts.Post;
      IBCGetParts.Edit;
      IBCGetParts.FieldByName('QTY').AsFloat := IBCGetParts.FieldByName('QTY').AsFloat - FQty;
      IBCGetParts.Post;
    except
      IBCSetParts.Cancel;
      raise;
    end;
  end;
  frmInputDlg.Free;
end;

procedure TfrmSelectPartsDlg.dxBarButton2Click(Sender: TObject);
begin
  if ShowAskDialog('Stergere partizi', 'Sunteti sigur ca doriti sa stergeti toate partizile?') = mrYES then
  begin
    IBCSetParts.DisableControls;
    try
      IBCSetParts.First;
      while not IBCSetParts.Eof do
      begin
        IBCSetParts.Delete;
      end;
    finally
      IBCSetParts.EnableControls;
    end;
  end;
end;

procedure TfrmSelectPartsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmSelectPartsDlg.FormShow(Sender: TObject);
begin
  ReadGoodsWarranty(fMasterDataSet.FieldByName('GOODSID').AsInteger);

  fMasterDataSet.UpdateTransaction.StartTransaction;

  CreateAvailablePartNumbers;

  IBCGetParts.Open;
  IBCSetParts.Open;

end;

procedure TfrmSelectPartsDlg.InitValues;
begin
  inherited;
  fGoodsWarranty := 0;

  IBCGetParts.Connection := fIBCConnection;

  IBCSetParts.Connection := fIBCConnection;
  IBCSetParts.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCSetParts.MasterSource := fMasterDataSource;

  FJurnalQTY := fMasterDataSet.FieldByName('DTDEP').AsFloat;
end;

procedure TfrmSelectPartsDlg.ReadGoodsWarranty(GoodsID: integer);
var
  query: TIBCQuery;
begin
  query := TIBCQuery.Create(self);
  try
    query.Connection := fIBCConnection;
    query.SQL.Text := 'select warranty from ts_goods where goodsid=:goodsid';
    query.ParamByName('goodsid').AsInteger := GoodsID;
    query.ExecSQL;
    if not query.Eof then
      fGoodsWarranty := query.Fields[0].AsInteger;
    query.Close;
  finally
    query.Free;
  end;
end;

end.


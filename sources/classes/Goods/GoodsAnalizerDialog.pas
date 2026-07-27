unit GoodsAnalizerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, StdCtrls, ExtCtrls, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit, dxBarBuiltInMenu, Data.DB, MemDS, DBAccess, IBC, cxLabel, cxPC;

type
  TGoodsAnalizerDlg = class(TSWNMasteredFormClass)
    btnOk: TButton;
    btnCancel: TButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    cxLabel1: TcxLabel;
    lbQtyIN: TcxLabel;
    cxLabel3: TcxLabel;
    lbSumaIN: TcxLabel;
    GroupBox2: TGroupBox;
    cxLabel5: TcxLabel;
    lbQTY_OUT: TcxLabel;
    cxLabel7: TcxLabel;
    lbSumPriceIN: TcxLabel;
    cxLabel9: TcxLabel;
    lbSumPriceOUT: TcxLabel;
    cxLabel11: TcxLabel;
    lbRevenue: TcxLabel;
    cxTabSheet2: TcxTabSheet;
    procedure cxTabSheet1Show(Sender: TObject);
  private
    procedure PrepareMicroSpravka;
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

uses
  DataModuleDB, DataModuleAdditions, SWNDBErrors, SWNUtils, SWNConst;

{$R *.dfm}

procedure TGoodsAnalizerDlg.cxTabSheet1Show(Sender: TObject);
begin
  PrepareMicroSpravka;
end;

procedure TGoodsAnalizerDlg.BindingDataSource;
begin
  inherited;
end;

function TGoodsAnalizerDlg.IsFormDataPosted: Boolean;
begin
//     Result:=False;
//     if CheckParams then
//     begin
//          fMasterDataSet.Post;
//          fMasterDataSet.UpdateTransaction.Commit;
//
//          Result:=True;
//     end;
  Result := True;
end;

procedure TGoodsAnalizerDlg.Prepare;
begin
//     fMasterDataSet.UpdateTransaction.StartTransaction;
end;

procedure TGoodsAnalizerDlg.PrepareMicroSpravka;
var
  q: TIBCQuery;
  SQL: string;
begin
  q := TIBCQuery.Create(Owner);
  try
    q.Connection := fIBCConnection;
    q.Transaction := fIBCConnection.DefaultTransaction;
    SQL := 'SELECT * FROM SP_GET_MICRO_SPRAVKA(:GOODSID)';
    q.SQL.Add(SQL);
    q.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    q.ExecSQL;
    lbQtyIN.Caption := FormatFloat('0.00', q.FieldByName('QTY_IN').AsFloat);
    lbSumaIN.Caption := FormatFloat('0.00', q.FieldByName('SUM_IN').AsFloat);
//    avg_cost :=
    lbQTY_OUT.Caption := FormatFloat('0.00', q.FieldByName('QTY_OUT').AsFloat);
    lbSumPriceIN.Caption := FormatFloat('0.00', q.FieldByName('SUM_PRICE_IN').AsFloat);
    lbSumPriceOut.Caption := FormatFloat('0.00', q.FieldByName('SUM_PRICE_OUT').AsFloat);
    lbRevenue.Caption := FormatFloat('0.00', q.FieldByName('REVENUE').AsFloat);
  finally
    q.Free;
  end;
end;

procedure TGoodsAnalizerDlg.WhenCancelForm;
begin
//     fMasterDataSet.Cancel;
//     fMasterDataSet.UpdateTransaction.Rollback;
end;

end.


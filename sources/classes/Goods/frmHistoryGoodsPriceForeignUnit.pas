unit frmHistoryGoodsPriceForeignUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC,
  MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, DialogTitle, cxCheckBox;

type
  TfrmHistoryGoodsPriceForeignDlg = class(TSWNMasteredFormClass)
    Panel1: TPanel;
    cxButton1: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryGoodsPriceHistory: TIBCQuery;
    IBCDataSourceGoodsPriceHistory: TIBCDataSource;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1LAST_PRICE_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE0: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY0ID: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE4: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE5: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY4ID: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE7: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY7ID: TcxGridDBColumn;
    cxGrid1DBTableView1FLAGS: TcxGridDBColumn;
    cxGrid1DBTableView1BASE_PRICE4: TcxGridDBColumn;
    cxGrid1DBTableView1MODIFIED_BY: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE1: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE2: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE3: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE6: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY6ID: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY3ID: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmHistoryGoodsPriceForeignDlg: TfrmHistoryGoodsPriceForeignDlg;

implementation

{$R *.dfm}

{ TfrmHistoryGoodsPriceForeignDlg }

procedure TfrmHistoryGoodsPriceForeignDlg.Prepare;
begin
    IBCQueryGoodsPriceHistory.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    IBCQueryGoodsPriceHistory.ParamByName('CUSTOMERID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    IBCQueryGoodsPriceHistory.Open;

end;

end.

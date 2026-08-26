unit frmGoodsFromSupplierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, RzPanel, RzDlgBtn, cxCheckBox, SWNBaseUnit;

type
  TfrmGoodsFromSupplierDlg = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    qSupplierGoods: TIBCQuery;
    dsSupplierGoods: TIBCDataSource;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE1_LEI: TcxGridDBColumn;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    FSupplierID: Integer;
    { Private declarations }
  public
    property SupplierID: Integer read FSupplierID write FSupplierID;
    { Public declarations }
  end;

var
  frmGoodsFromSupplierDlg: TfrmGoodsFromSupplierDlg;

implementation

uses
  DataModuleDB, SWNUtils;

{$R *.dfm}

procedure TfrmGoodsFromSupplierDlg.cxGrid1DBTableView1KeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGrid1DBTableView1, Key, Shift);
end;

procedure TfrmGoodsFromSupplierDlg.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
  qSupplierGoods.Close;
  Action := caFree;
end;

procedure TfrmGoodsFromSupplierDlg.FormShow(Sender: TObject);
begin
  qSupplierGoods.Close;
  qSupplierGoods.ParamByName('supplierid').AsInteger := SupplierID;
  qSupplierGoods.Open;
end;

end.

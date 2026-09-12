unit frmSelectGoodsSupplierUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, DBAccess, IBC, MemDS,
  SWNBaseUnit;

type
  TfrmSelectGoodsSupplierDlg = class(TSWNBaseFormClass)
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE0: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE7: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE1: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectGoodsSupplierDlg: TfrmSelectGoodsSupplierDlg;

implementation

{$R *.dfm}

end.

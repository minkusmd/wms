unit frmCategorySuppliersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, DBAccess, IBC, MemDS,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  cxCheckBox, dxBar;

type
  TfrmCategorySuppliersDlg = class(TSWNBaseFormClass)
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn;
    IBCQuerySupplierCategory: TIBCQuery;
    IBCDataSourceSupplierCategory: TIBCDataSource;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQuerySupplierGoods: TIBCQuery;
    IBCDataSourceSupplierGoods: TIBCDataSource;
    cxGrid2DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid2DBTableView1TITLE: TcxGridDBColumn;
    cxGrid2DBTableView1PRICE: TcxGridDBColumn;
    cxGrid2DBTableView1FLG_IN_PRICE: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbRefresh: TdxBarButton;
    procedure bbRefreshClick(Sender: TObject);
    procedure cxGrid2DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    FWebGoodsTypeID: Integer;
    { Private declarations }
  protected
    procedure Prepare; override;

  public
    property WebGoodsTypeID: Integer read FWebGoodsTypeID write FWebGoodsTypeID;
    { Public declarations }
  end;

var
  frmCategorySuppliersDlg: TfrmCategorySuppliersDlg;

implementation

uses
  DataModuleAdditions, SWNUtils;

{$R *.dfm}

{ TfrmCategorySuppliersDlg }

procedure TfrmCategorySuppliersDlg.bbRefreshClick(Sender: TObject);
begin
  IBCQuerySupplierGoods.Close;
  IBCQuerySupplierGoods.ParamByName('CUSTOMERID').AsInteger := IBCQuerySupplierCategory.FieldByName('CUSTOMERID').AsInteger;
  IBCQuerySupplierGoods.ParamByName('WEBGOODSTYPEID').AsInteger := WebGoodsTypeID;
  IBCQuerySupplierGoods.Open;
end;

procedure TfrmCategorySuppliersDlg.cxGrid2DBTableView1KeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGrid2DBTableView1, Key, Shift);
end;

procedure TfrmCategorySuppliersDlg.Prepare;
begin
  inherited;
  IBCQuerySupplierCategory.ParamByName('webgoodstypeid').AsInteger := WebGoodsTypeID;
  IBCQuerySupplierCategory.Open;
end;

end.

unit frmAddGoodsToSupplierOrderDlgUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  RzPanel,
  RzDlgBtn,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  Data.DB,
  DBAccess,
  IBC,
  MemDS,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  SWNBaseUnit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxCheckBox,
  cxCalc,
  cxGridBandedTableView,
  cxGridDBBandedTableView;

type
  TfrmAddGoodsToSupplierOrderDlg = class(TSWNCustomForm)
    RzDialogButtons1: TRzDialogButtons;
    Panel1: TPanel;
    cxLookupComboBox1: TcxLookupComboBox;
    cxLabel1: TcxLabel;
    IBCQuerySuppliers: TIBCQuery;
    IBCDataSourceSuppliers: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    cxGrid1DBTableView1DOCID: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1CT: TcxGridDBColumn;
    cxGrid1DBTableView1CT_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1SUMA: TcxGridDBColumn;
    cxGrid1DBTableView1CURRENCY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1RATE: TcxGridDBColumn;
    cxGrid1DBTableView1RATEUSD: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_CLOSED: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1DOCTYPEID: TcxGridDBColumn;
    cxGrid1DBTableView1DOCTYPE_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACTID: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACT_CODE: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACT_SIGN_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACT_CURRENCYID: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACT_TYPE_TITLE: TcxGridDBColumn;
    cxGrid1DBTableView1CONTRACT_PRICECOLUMN: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_WITH_DELIVERY: TcxGridDBColumn;
    btnRefresh: TcxButton;
    IBCQueryForeign: TIBCQuery;
    IBCDataSourceForeign: TIBCDataSource;
    cxGridForeign: TcxGrid;
    cxGridForeignDBBandedTableView1: TcxGridDBBandedTableView;
    TV1_GOODS_CODE: TcxGridDBBandedColumn;
    TV1_GOODSID: TcxGridDBBandedColumn;
    TV1_CUSTOMER_NAME: TcxGridDBBandedColumn;
    TV1_BARCODE: TcxGridDBBandedColumn;
    TV1_FLG_PREORDER: TcxGridDBBandedColumn;
    TV1_FLG_IN_PRICE: TcxGridDBBandedColumn;
    TV1_FLG_SUPPLIER_PROMO: TcxGridDBBandedColumn;
    TV1_FLG_SUPPLIER_PRIORITY: TcxGridDBBandedColumn;
    TV1_PRICE1: TcxGridDBBandedColumn;
    TV1_CURRENCY1ID: TcxGridDBBandedColumn;
    TV1_PRICE2: TcxGridDBBandedColumn;
    TV1_CURRENCY2ID: TcxGridDBBandedColumn;
    TV1_PRICE3: TcxGridDBBandedColumn;
    TV1_CURRENCY3ID: TcxGridDBBandedColumn;
    TV1_PRICE4: TcxGridDBBandedColumn;
    TV1_PRICE5: TcxGridDBBandedColumn;
    TV1_MARGIN5: TcxGridDBBandedColumn;
    TV1_CURRENCY5ID: TcxGridDBBandedColumn;
    TV1_PRICE6: TcxGridDBBandedColumn;
    TV_MARGIN6: TcxGridDBBandedColumn;
    TV1_CURRENCY6ID: TcxGridDBBandedColumn;
    TV1_PRICE7: TcxGridDBBandedColumn;
    TV1_CURRENCY7ID: TcxGridDBBandedColumn;
    TV1_flg_min_purchaise_price: TcxGridDBBandedColumn;
    TV1_PRICE4MDL: TcxGridDBBandedColumn;
    TV1_DIFF47: TcxGridDBBandedColumn;
    TV1_PERCENT47: TcxGridDBBandedColumn;
    TV1_PRICE7_LEI: TcxGridDBBandedColumn;
    TV1_FLG_RRP: TcxGridDBBandedColumn;
    tv1_PriceIndicativ: TcxGridDBBandedColumn;
    TV1_CUSTOMERID: TcxGridDBBandedColumn;
    TV1_MODIFY: TcxGridDBBandedColumn;
    TV1_GOODS_TITLE: TcxGridDBBandedColumn;
    tb1_ModifyPrice7: TcxGridDBBandedColumn;
    TV1_PRICE0_LEI: TcxGridDBBandedColumn;
    TV1_FLG_DRP: TcxGridDBBandedColumn;
    TV1_MARGIN01: TcxGridDBBandedColumn;
    cxGridForeignDBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGridForeignDBBandedTableView1Column2: TcxGridDBBandedColumn;
    TV1_DIF01: TcxGridDBBandedColumn;
    cxGridForeignLevel1: TcxGridLevel;
    procedure btnRefreshClick(Sender: TObject);
  private
    FDocID: Integer;
    FGoodsID: Integer;
    procedure RefreshData;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    SupplierID: Integer;
    SupplierName: string;
    property DocID: Integer read FDocID write FDocID;
    property GoodsID: Integer read FGoodsID write FGoodsID;
    { Public declarations }
  end;

var
  frmAddGoodsToSupplierOrderDlg: TfrmAddGoodsToSupplierOrderDlg;

implementation

uses
  DataModuleDB;

{$R *.dfm}

{ TfrmAddGoodsToSupplierOrderDlg }

procedure TfrmAddGoodsToSupplierOrderDlg.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

function TfrmAddGoodsToSupplierOrderDlg.IsFormDataPosted: Boolean;
begin
  DocID := ibcquerydocs.fieldbyname('docid').AsInteger;
  Result := True;
end;

procedure TfrmAddGoodsToSupplierOrderDlg.Prepare;
begin
  IBCQuerySuppliers.Open;
  IBCQueryForeign.close;
  IBCQueryForeign.parambyname('goodsid').asInteger := GoodsID;
  IBCQueryForeign.Open;
  RefreshData;
end;

procedure TfrmAddGoodsToSupplierOrderDlg.RefreshData;
begin
{  IBCQueryDocs.Close;
  IBCQueryDocs.ParamByName('dt').AsInteger := dmdb.CurrentFirma;
    IBCQueryDocs.parambyName('supplierid').AsInteger := IBCQuerySuppliers.fieldbyName('customerid').AsInteger;
      IBCQueryDocs.Open;}
end;

end.


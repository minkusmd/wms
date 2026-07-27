unit frmAnalizePriceListUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, dxBar,
  cxClasses, MemDS, DBAccess, IBC, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, Vcl.ExtCtrls, dxScrollbarAnnotations;

type
  TfrmAnalizePriceListDlg = class(TSWNBaseFormClass)
    cxPageControl1: TcxPageControl;
    tbsAllPriceList: TcxTabSheet;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxTabSheet4: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuery1: TIBCQuery;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbImport2Directory: TdxBarButton;
    bbReevaluare: TdxBarButton;
    bbPrepare: TdxBarButton;
    btnClose: TcxButton;
    Panel1: TPanel;
    cxLookupComboBox1: TcxLookupComboBox;
    cxLookupComboBox2: TcxLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    IBCQueryCurrentPriceList: TIBCQuery;
    IBCQueryOldPriceList: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1PLID: TcxGridDBColumn;
    cxGrid1DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1AVAILABILITY: TcxGridDBColumn;
    cxGrid1DBTableView1FLAGS: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE0: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE7: TcxGridDBColumn;
    cxGrid1DBTableView1WARANTY: TcxGridDBColumn;
    cxButton1: TcxButton;
  private
    FPLID: Integer;
    procedure SetPLID(const Value: Integer);
    { Private declarations }
  public
    property PLID: Integer read FPLID write SetPLID;
    { Public declarations }
  end;

var
  frmAnalizePriceListDlg: TfrmAnalizePriceListDlg;

implementation

{$R *.dfm}

procedure TfrmAnalizePriceListDlg.SetPLID(const Value: Integer);
begin
   FPLID := Value;
end;

end.

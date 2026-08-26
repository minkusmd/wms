unit frameSipCustomerCallsHistoryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseFrameUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxImageComboBox, cxDBLookupComboBox, dxBar, cxBarEditItem, cxClasses,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, MemDS, DBAccess, IBC;

type
  TframeSipCustomerCallsHistory = class(TSWNBaseFrame)
    IBCDataSourceDialHistory: TIBCDataSource;
    IBCQueryDialHistory: TIBCQuery;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1SOURCEID: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1WAV: TcxGridDBColumn;
    cxGrid1DBTableView1USERNAME: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManagerBar2: TdxBar;
    lcbCustomers: TcxBarEditItem;
    bbStop: TdxBarButton;
    bbPlay: TdxBarButton;
    bbSaveAs: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

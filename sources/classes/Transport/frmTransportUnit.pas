unit frmTransportUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData, Vcl.Menus,
  DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxBar, cxClasses, SWNBaseUnit, dxScrollbarAnnotations;

type
    TfrmTransportDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCQueryTransport: TIBCQuery;
    IBCDataSourceTransport: TIBCDataSource;
    cxGrid1DBTableView1TRANSPORTID: TcxGridDBColumn;
    cxGrid1DBTableView1NAME: TcxGridDBColumn;
    cxGrid1DBTableView1MODEL: TcxGridDBColumn;
    cxGrid1DBTableView1REGISTRATION_NUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1CONSUMPTION: TcxGridDBColumn;
    cxGrid1DBTableView1DRIVER_NAME: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTransportDlg: TfrmTransportDlg;

implementation

{$R *.dfm}

end.

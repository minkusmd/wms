unit frmJobVacanciesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomView, cxGrid, Vcl.ExtCtrls, dxBar, cxClasses;

type
  TfrmJobVacanciesDlg = class(TSWNBaseFormClass)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    Panel1: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryJobs: TIBCQuery;
    IBCDataSourceJobs: TIBCDataSource;
    cxGrid1DBTableView1JOBID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE_RO: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE_RU: TcxGridDBColumn;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJobVacanciesDlg: TfrmJobVacanciesDlg;

implementation

{$R *.dfm}

end.

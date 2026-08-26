unit frmSarcinaOperatorilorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  Vcl.ExtCtrls, RzPanel, RzDlgBtn, SWNBaseUnit;

type
  TfrmSarcinaOperatorilorDlg = class(TSWNBaseFormClass)
    RzDialogButtons1: TRzDialogButtons;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuerySarcinaOperatori: TIBCQuery;
    IBCDataSourceSarcinaOperatori: TIBCDataSource;
    cxGrid1DBTableView1USERID: TcxGridDBColumn;
    cxGrid1DBTableView1FULL_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1CNT: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmSarcinaOperatorilorDlg: TfrmSarcinaOperatorilorDlg;

implementation

{$R *.dfm}

{ TfrmSarcinaOperatorilorDlg }

procedure TfrmSarcinaOperatorilorDlg.Prepare;
begin
  ibcquerySarcinaOperatori.Connection := fibcConnection;
  ibcquerySarcinaOperatori.Open;
end;

end.

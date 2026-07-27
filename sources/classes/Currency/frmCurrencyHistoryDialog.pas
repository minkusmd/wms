unit frmCurrencyHistoryDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle,
  DB, cxGridLevel,
  cxGridDBTableView, cxGrid, StdCtrls,
  IBC, cxGridDBChartView, Vcl.ExtCtrls,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxLabel, Vcl.Menus, DBAccess,
  MemDS, cxGridChartView, cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView;

type
  TfrmCurrencyHistoryDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryHistory: TIBCQuery;
    IBCDataSourceHistory: TIBCDataSource;
    Panel1: TPanel;
    cxGridHistory: TcxGrid;
    cxGridHistoryTable: TcxGridDBTableView;
    cxGridHistory_DATA: TcxGridDBColumn;
    cxGridHistory_EXCHANGE_RATE: TcxGridDBColumn;
    cxGridHistory_TRANSFER_RATE: TcxGridDBColumn;
    cxGridHistory_DEGHEST_RATE: TcxGridDBColumn;
    cxGridHistory_BNM_RATE: TcxGridDBColumn;
    cxGridHistory_FULL_NAME: TcxGridDBColumn;
    cxGridHistoryLevel: TcxGridLevel;
    Panel2: TPanel;
    cxGrid1: TcxGrid;
    cxGridLevel1: TcxGridLevel;
    cxGrid1DBChartView1: TcxGridDBChartView;
    cxGrid1DBChartView1Series1: TcxGridDBChartSeries;
    IBCQueryHistoryChart: TIBCQuery;
    IBCDataSourceHistoryChart: TIBCDataSource;
    btnClose: TcxButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FCurrencyID: integer;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    procedure SetCurrencyInfo(const CurrencyID:integer; const Title:String);
  end;

implementation



{$R *.dfm}

{ TfrmCurrencyHistoryDlg }

procedure TfrmCurrencyHistoryDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  IBCQueryHistory.Close;
  IBCQueryHistoryChart.Close;
  CanClose := True;
end;

procedure TfrmCurrencyHistoryDlg.Prepare;
begin
     inherited;
     IBCQueryHistory.ParamByName('curr').AsInteger:=FCurrencyID;
     IBCQueryHistory.Active:=True;

     IBCQueryHistoryChart.ParamByName('curr').AsInteger:=FCurrencyID;
     IBCQueryHistoryChart.Active := True;
end;


procedure TfrmCurrencyHistoryDlg.SetCurrencyInfo(const CurrencyID: integer; const Title: String);
begin
     FCurrencyID:=CurrencyID;
     dtDialogTitle.Title:=Format('%s: %s',[dtDialogTitle.Title,Title]);
end;

end.

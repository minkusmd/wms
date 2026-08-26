unit frmSearchWebUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, dxBar, dxBarExtItems, cxClasses,
  MemDS, Vcl.StdCtrls, cxGridLevel, cxGridCustomView, cxGrid;

type
  TfrmSearchWebDialog = class(TSWNBaseFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnClose: TButton;
    IBCQuery1: TIBCQuery;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbDate1: TdxBarDateCombo;
    bbDate2: TdxBarDateCombo;
    bbRefresh: TdxBarButton;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1SEARCH_TEXT: TcxGridDBColumn;
    cxGrid1DBTableView1IP_ADDRESS: TcxGridDBColumn;
    cxGrid1DBTableView1SEARCH_TIME: TcxGridDBColumn;
    procedure bbRefreshClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmSearchWebDialog: TfrmSearchWebDialog;

implementation

{$R *.dfm}

procedure TfrmSearchWebDialog.bbRefreshClick(Sender: TObject);
begin
  ibcquery1.Close;
  ibcquery1.ParamByName('Data1').AsDate := bbDate1.Date;
  ibcquery1.ParamByName('Data2').AsDate := bbDate2.Date;
  IBCQuery1.Open;
end;

procedure TfrmSearchWebDialog.Prepare;
begin
  inherited;
  bbDate1.Date := Date;
  bbDate2.Date := Date;
  bbRefreshClick(Self);
end;

end.

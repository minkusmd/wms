unit uGoodsPricePolicyDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.StdCtrls, DBAccess, IBC, MemDS,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmGoodsPricePolicyDlg = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuery: TIBCQuery;
    IBCDataSource: TIBCDataSource;
    Button1: TButton;
    cxGrid1DBTableView1PRICECOLUMN: TcxGridDBColumn;
    cxGrid1DBTableView1MIN_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1MAX_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1FORMULA: TcxGridDBColumn;
    Label1: TLabel;
    IBCQueryPGT: TIBCQuery;
    procedure Button1Click(Sender: TObject);
  private
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    { Public declarations }
  end;

var
  frmGoodsPricePolicyDlg: TfrmGoodsPricePolicyDlg;

implementation

{$R *.dfm}

procedure TfrmGoodsPricePolicyDlg.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmGoodsPricePolicyDlg.Prepare;
begin

  ibcquery.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQuery.Open;

  IBCQueryPGT.ParamByName('PGT_ID').AsInteger := ibcquery.FieldByName('PGT_ID').AsInteger;
  IBCQueryPGT.Open;

  Label1.Caption := '#'+IBCQueryPGT.FieldByName('PGT_ID').AsString+' - '+IBCQueryPGT.FieldByName('TITLE').AsString;
end;

procedure TfrmGoodsPricePolicyDlg.SetGoodsID(const Value: Integer);
begin
  FGoodsID := Value;
end;

end.

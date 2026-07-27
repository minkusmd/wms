unit frmPriceTypesHistoryUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess,
  IBC, MemDS, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmPriceTypesHistoryDlg = class(TSWNMasteredFormClass)
    IBCQuery: TIBCQuery;
    IBCDataSource: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnClose: TcxButton;
    cxGrid1DBTableView1DATA: TcxGridDBColumn;
    cxGrid1DBTableView1USERNAME: TcxGridDBColumn;
    cxGrid1DBTableView1PRICECOLUMN: TcxGridDBColumn;
    cxGrid1DBTableView1MIN_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1MAX_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1FORMULA: TcxGridDBColumn;
    cxGrid1DBTableView1FORMULA_NEW: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    procedure Prepare; override;

  public
    { Public declarations }
  end;

var
  frmPriceTypesHistoryDlg: TfrmPriceTypesHistoryDlg;

implementation

{$R *.dfm}

procedure TfrmPriceTypesHistoryDlg.Prepare;
begin
  IBCQuery.Connection := fMasterDataSet.Connection;
  IBCQuery.Transaction :=  fMasterDataSet.Transaction;
  IBCQuery.Close;
  IBCQuery.ParamByName('PGT_ID').AsInteger := fMasterDataSet.FieldByName('PGT_ID').AsInteger;
  IBCQuery.Open;
end;

end.

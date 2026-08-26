unit frmHistoryGoodsFiltersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, Vcl.Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxButtons, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SWNBaseUnit;

type
  TfrmHistoryGoodsFiltersDlg = class(TSWNMasteredFormClass)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    btnClose: TcxButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1UID: TcxGridDBColumn;
    cxGrid1DBTableView1OPERATION: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1DESCRIPTIONID: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_GROUP: TcxGridDBColumn;
    cxGrid1DBTableView1FILTERID: TcxGridDBColumn;
    cxGrid1DBTableView1FILTERPARAMID: TcxGridDBColumn;
    cxGrid1DBTableView1FLAGS: TcxGridDBColumn;
    cxGrid1DBTableView1ORDERNO: TcxGridDBColumn;
    cxGrid1DBTableView1FILTER_VALUE: TcxGridDBColumn;
    cxGrid1DBTableView1MODIFIED_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1MODIFIED_BY: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmHistoryGoodsFiltersDlg: TfrmHistoryGoodsFiltersDlg;

implementation

{$R *.dfm}

{ TfrmHistoryGoodsFiltersDlg }

procedure TfrmHistoryGoodsFiltersDlg.Prepare;
begin
  IBCQuery1.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  IBCQuery1.Open;
end;

end.

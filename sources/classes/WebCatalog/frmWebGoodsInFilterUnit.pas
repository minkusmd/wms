unit frmWebGoodsInFilterUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Menus, DialogTitle, Vcl.StdCtrls, cxButtons,
  dxUIAClasses;

type
  TfrmGoodsInFilterDialog = class(TSWNCustomForm)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuery: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxGrid1DBTableView1FILTERID: TcxGridDBColumn;
    cxGrid1DBTableView1FILTERNAME: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    cxButton1: TcxButton;
    DialogTitle1: TDialogTitle;
  private
    FFilterID: Integer;
    procedure SetFilterID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  published
    property FilterID: Integer read FFilterID write SetFilterID;
  end;

var
  frmGoodsInFilterDialog: TfrmGoodsInFilterDialog;

implementation

uses
  DataModuleAdditions;

{$R *.dfm}

{ TfrmGoodsInFilterDialog }

procedure TfrmGoodsInFilterDialog.Prepare;
begin
  inherited;
  IBCQuery.Close;
  IBCQuery.ParamByName('FILTERID').AsInteger := FFilterID;
  IBCQuery.Open;
end;

procedure TfrmGoodsInFilterDialog.SetFilterID(const Value: Integer);
begin
  FFilterID := Value;
end;

end.

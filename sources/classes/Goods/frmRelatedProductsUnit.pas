unit frmRelatedProductsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxClasses, dxBar, DialogTitle, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomView, cxGrid, SWNBaseUnit,
  cxCheckBox;

type
  TfrmRelatedProductsDlg = class(TSWNMasteredFormClass)
    dxBarManager1: TdxBarManager;
    Panel1: TPanel;
    Panel2: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    bbNew: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid1DBTableView1RELATED_GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1RELATED_GOODS_NAME: TcxGridDBColumn;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxGrid1DBTableView1FLG_IN_PRICE: TcxGridDBColumn;
    cxGrid1DBTableView1PRICE_MDL: TcxGridDBColumn;
    IBCQueryRelatedGoods: TIBCQuery;
    IBCDataSourceRelatedGoods: TIBCDataSource;
    DialogTitle1: TDialogTitle;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1_GOODSID: TcxGridDBColumn;
    cxGridDBTableView1_TITLE: TcxGridDBColumn;
    cxGridDBTableView1_PRICE: TcxGridDBColumn;
    cxGridDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
  private
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added:
        Boolean; var Count: integer);
    procedure SetupSecurityItems; override;
  public
    procedure AddRelatedGoods(GoodsID: Integer; RelatedGOODSID: integer);
    property GoodsID: Integer read FGoodsID write SetGoodsID;
    { Public declarations }
  end;

var
  frmRelatedProductsDlg: TfrmRelatedProductsDlg;

implementation

uses
    DataModuleAdditions, frmRelatedProductsEditorUnit, frmGoods, SWNSecurityFlags;

{$R *.dfm}

procedure TfrmRelatedProductsDlg.AddRelatedGoods(GoodsID: Integer; RelatedGOODSID: integer);
begin
    with IBCQueryRelatedGoods do
    begin
        Append;
        FieldByName('GOODSID').AsInteger := GoodsID;
        FieldByName('RELATED_GOODSID').AsInteger := RelatedGOODSID;
        Post;
    end;
end;

{ TfrmRelatedProductsDlg }

function TfrmRelatedProductsDlg.IsFormDataPosted: Boolean;
begin
    result := true;
end;

procedure TfrmRelatedProductsDlg.SetupSecurityItems;
begin
  inherited;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
    bbDelete.Enabled := False;
end;

procedure TfrmRelatedProductsDlg.Prepare;
begin
  inherited;
//  IBCTrLocal.DefaultConnection := MasterDataSet.Connection;
  IBCQueryRelatedGoods.Connection := MasterDataSet.Connection;
  IBCQueryRelatedGoods.Transaction := MasterDataSet.Transaction;
  IBCQueryRelatedGoods.ParamByName('GOODSID').AsInteger := MasterDataSet.FieldByName('GOODSID').AsInteger;
  IBCQueryRelatedGoods.Open;
end;

procedure TfrmRelatedProductsDlg.SetGoodsID(const Value: Integer);
begin
    FGoodsID := Value;
end;

procedure TfrmRelatedProductsDlg.WhenBurstAddGoods(const GoodsID: integer; const GoodsTitle: string; var Added: Boolean;
  var Count: integer);
begin
  //
  AddRelatedGoods(MasterDataSet.FieldByName('GOODSID').AsInteger, GoodsID);
  Added := True;
end;

end.

unit frmGoodsStockByWarehouseDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, DB,
  StdCtrls, frameGoodsStockUnit,
  cxDBEdit, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.Menus, cxMemo, cxTextEdit;

type
  TfrmGoodsStockByWarehouseDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edGOODSID: TcxDBTextEdit;
    mmTITLE: TcxDBMemo;
    frameGoodsStock: TframeGoodsStock;
    Bevel1: TBevel;
    cbShowExistingOnly: TCheckBox;
    btnClose: TcxButton;
  private
    { Private declarations }
    FGoodsID: integer;
    fShowExistingOnly:Boolean;
    procedure SetGoodsID(const Value: integer);
    procedure WhenShowExistingOnlyClick(Sender: TObject);

  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:integer read FGoodsID write SetGoodsID;
  end;

implementation

uses SWNValueStorageUnit;

{$R *.dfm}

{ TForm1 }

procedure TfrmGoodsStockByWarehouseDlg.WhenShowExistingOnlyClick(Sender: TObject);
begin
     fShowExistingOnly:=Not fShowExistingOnly;
     cbShowExistingOnly.Checked:=fShowExistingOnly;
     frameGoodsStock.ShowStockForGoods(FGoodsID,FirmaID,fShowExistingOnly);
     AppUserConfigStorage.BooleanValues.SetValue('GoodsStockByWarehouse_ShowExistingOnly',fShowExistingOnly);
end;

procedure TfrmGoodsStockByWarehouseDlg.BindingDataSource;
begin
     inherited;

     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     mmTITLE.DataBinding.DataSource:=fMasterDataSource;
     fShowExistingOnly:=AppUserConfigStorage.BooleanValues.GetValue('GoodsStockByWarehouse_ShowExistingOnly');
end;

procedure TfrmGoodsStockByWarehouseDlg.Prepare;
begin
     cbShowExistingOnly.Checked:=fShowExistingOnly;
     cbShowExistingOnly.OnClick:=WhenShowExistingOnlyClick;
     frameGoodsStock.ShowStockForGoods(FGoodsID,FirmaID,fShowExistingOnly);
end;

procedure TfrmGoodsStockByWarehouseDlg.SetGoodsID(const Value: integer);
begin
     FGoodsID := Value;
end;

end.

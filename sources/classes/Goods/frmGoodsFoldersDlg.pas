unit frmGoodsFoldersDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxFilter, cxCustomData, cxStyles,
  dxScrollbarAnnotations, cxTL, cxTLdxBarBuiltInMenu, Data.DB, DBAccess, IBC,
  MemDS, Vcl.ExtCtrls, RzPanel, RzDlgBtn, cxInplaceContainer, cxTLData, cxDBTL,
  DataModuleDB, cxMaskEdit, swnbaseunit, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  dxUIAClasses;

type
  TfrmNewGoodsCatalogDlg = class(TSWNCustomForm)
    cxDBTreeList1: TcxDBTreeList;
    RzDialogButtons1: TRzDialogButtons;
    Panel1: TPanel;
    IBCQueryGoodsFolders: TIBCQuery;
    IBCDataSourceGoodsFolders: TIBCDataSource;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmNewGoodsCatalogDlg: TfrmNewGoodsCatalogDlg;

implementation



{$R *.dfm}

{ TForm1 }

procedure TfrmNewGoodsCatalogDlg.Prepare;
begin
  inherited;
  IBCQueryGoodsFolders.open;
  ibcqueryGoods.Open;
end;

end.

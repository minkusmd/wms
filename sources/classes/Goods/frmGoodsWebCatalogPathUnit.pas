unit frmGoodsWebCatalogPathUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB,
  cxDBData, Vcl.Menus, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, DBAccess, IBC, MemDS, Vcl.StdCtrls,
  cxButtons, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, SWNBaseUnit, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxTLData, cxDBTL,
  cxMaskEdit;

type
  TfrmGoodsWebCatalogPathDialog = class(TSWNBaseFormClass)
    cxButton1: TcxButton;
    IBCQuery1: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    cxDBTreeList1: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
  private
    FFolderID: Integer;
    procedure SetFolderID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  published
    property FolderID: Integer read FFolderID write SetFolderID;
  end;

var
  frmGoodsWebCatalogPathDialog: TfrmGoodsWebCatalogPathDialog;

implementation

{$R *.dfm}

procedure TfrmGoodsWebCatalogPathDialog.Prepare;
begin
  IBCQuery1.Close;
  ibcquery1.Connection := fIBCConnection;
  IBCQuery1.ParamByName('FOLDERID').AsInteger := FolderID;
  IBCQuery1.Open;
  cxDBTreeList1.FullExpand;
end;

procedure TfrmGoodsWebCatalogPathDialog.SetFolderID(const Value: Integer);
begin
  FFolderID := Value;
end;

end.

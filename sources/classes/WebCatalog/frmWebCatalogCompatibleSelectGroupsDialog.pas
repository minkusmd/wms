unit frmWebCatalogCompatibleSelectGroupsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL,
  cxTLdxBarBuiltInMenu, StdCtrls, cxInplaceContainer, cxTLData, cxDBTL, DialogTitle, DB, MemDS, DBAccess, IBC,
  cxMaskEdit, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations;

type
  TfrmWebCatalogCompatibleSelectGroupsDlg = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    cxDBTreeList: TcxDBTreeList;
    btnOk: TButton;
    btnCancel: TButton;
    IBCDataSourceTree: TIBCDataSource;
    IBCQueryTree: TIBCQuery;
    cxDBTreeListcxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeListcxDBTreeListColumn2: TcxDBTreeListColumn;
    cxDBTreeList_CATALOGID: TcxDBTreeListColumn;
  private
    { Private declarations }
    fCatalogID: integer;
    fCompatibleCatalogID: integer;
    procedure SetCatalogID(const Value: integer);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
    property CatalogID: integer read fCatalogID write SetCatalogID;
    property CompatibleCatalogID: integer read fCompatibleCatalogID;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{$R *.dfm}
{ TForm2 }

procedure TfrmWebCatalogCompatibleSelectGroupsDlg.BindingDataSource;
begin
  IBCQueryTree.Transaction := fMasterDataSet.Transaction;
end;

function TfrmWebCatalogCompatibleSelectGroupsDlg.IsFormDataPosted: Boolean;
var
  Node: TcxTreeListNode;
begin
  Node := cxDBTreeList.DataController.TreeList.FocusedNode;
  if Assigned(Node) and (Node.Level = 1) then
  begin
    fCompatibleCatalogID := Node.Values[2]; // CATALOGID
    Result := True;
  end
  else
  begin
    ShowErrorDialog(cMSG_GeneralError_Title, 'Selectati grupul de marfa de la nivelul doi!');
    Result := False;
  end;
end;

procedure TfrmWebCatalogCompatibleSelectGroupsDlg.Prepare;
begin
  IBCQueryTree.ParamByName('id').AsInteger := fCatalogID;
  IBCQueryTree.Active := True;
  cxDBTreeList.DataController.TreeList.FullCollapse;
end;

procedure TfrmWebCatalogCompatibleSelectGroupsDlg.SetCatalogID(const Value: integer);
begin
  fCatalogID := Value;
end;

end.

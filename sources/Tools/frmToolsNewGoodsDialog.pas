unit frmToolsNewGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, dxBar, DBAccess, IBC, MemDS,
  cxCheckBox, StdCtrls, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmToolsNewGoodsDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar: TdxBar;
    cxGrid_GOODSID: TcxGridDBColumn;
    cxGrid_TITLE: TcxGridDBColumn;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGrid_PARENT_TITLE: TcxGridDBColumn;
    cxGrid_DAYDATE: TcxGridDBColumn;
    bbShowWebCatalog: TdxBarButton;
    cmbCount: TdxBarCombo;
    cxGrid_FLG_EXISTS_WEB_CATALOG: TcxGridDBColumn;
    pnButtons: TPanel;
    btnCancel: TButton;
    procedure bbShowWebCatalogClick(Sender: TObject);
    procedure cmbCountChange(Sender: TObject);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure ShowWebCatalog;
    procedure LoadData;
    procedure ShowQuickInfoDialog(const GoodsID:integer);
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleAdditions, DataModuleDB, frmWebCatalogDialog, SWNSecurity, frmGoodsQuickInfoDialog;

{$R *.dfm}

{ TfrmToolsNewGoodsDlg }

procedure TfrmToolsNewGoodsDlg.bbShowWebCatalogClick(Sender: TObject);
begin
     ShowWebCatalog;
end;

procedure TfrmToolsNewGoodsDlg.cmbCountChange(Sender: TObject);
begin
     LoadData;
end;

procedure TfrmToolsNewGoodsDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var GoodsID:integer;
begin
     // F1
     if (key=112) and (Shift=[]) then
     begin
          if Assigned(cxGridTable.Controller.FocusedRow) then
          begin
               GoodsID:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRow.RecordIndex,cxGrid_GOODSID.Index];
               ShowQuickInfoDialog(GoodsID);
          end;
     end;
end;

procedure TfrmToolsNewGoodsDlg.LoadData;
var N:integer;
begin
     N:=StrToIntDef(cmbCount.Text,50);
     IBCQueryGoods.Close;
     IBCQueryGoods.ParamByName('count').AsInteger:=N;
     IBCQueryGoods.Active:=True;
     //cxGridTable.DataController.Groups.ChangeExpanding(0,true,false);
     cxGridTable.DataController.Groups.FullExpand;
end;

procedure TfrmToolsNewGoodsDlg.Prepare;
begin
     LoadData;
end;

procedure TfrmToolsNewGoodsDlg.SetupSecurityItems;
begin
     if Not SWNSecurityManager.LoggedUser.IsInAdminGroup then
     begin
          bbShowWebCatalog.Visible:=ivNever;
     end;

     if dxBarManagerBar.ItemLinks.VisibleItemCount=0 then
     begin
          dxBarManagerBar.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure TfrmToolsNewGoodsDlg.ShowQuickInfoDialog(const GoodsID: integer);
var dialog:TfrmGoodsQuickInfoDlg;
begin
     dialog:=TfrmGoodsQuickInfoDlg.Create(Self);
     try
        dialog.GoodsID:=GoodsID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmToolsNewGoodsDlg.ShowWebCatalog;
var dialog:TfrmWebCatalogDlg;
begin
     dialog:=TfrmWebCatalogDlg.Create(self);
     try
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.

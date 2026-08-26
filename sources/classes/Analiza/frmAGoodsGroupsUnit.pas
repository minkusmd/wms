unit frmAGoodsGroupsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls, cxButtons, dxBar;

type
  TfrmAGoodsGroupsDlg = class(TSWNBaseFormClass)
    Panel2: TPanel;
    IBCQueryGroups: TIBCQuery;
    IBCDataSourceGroups: TIBCDataSource;
    Panel1: TPanel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    cxButton1: TcxButton;
    Panel3: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    dxBarManager1Bar2: TdxBar;
    bbGoodsFolderNew: TdxBarButton;
    bbGoodsFolderModify: TdxBarButton;
    bbGoodsFolderDelete: TdxBarButton;
    cxGrid1DBTableView1GROUPID: TcxGridDBColumn;
    cxGrid1DBTableView1TITLE: TcxGridDBColumn;
    IBCTrLocal: TIBCTransaction;
    IBCQueryGoodsFolders: TIBCQuery;
    IBCDataSourceGoodsFolders: TIBCDataSource;
    cxGrid2DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid2DBTableView1GOODS_NAME: TcxGridDBColumn;
    procedure bbGoodsFolderNewClick(Sender: TObject);
    procedure bbGoodsFolderModifyClick(Sender: TObject);
    procedure bbGoodsFolderDeleteClick(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;

  public
    { Public declarations }
  end;

var
  frmAGoodsGroupsDlg: TfrmAGoodsGroupsDlg;

implementation

uses
  frmGoods, System.UITypes, DataModuleAdditions, frmAGoodsGroupsEditorUnit;

{$R *.dfm}

{ TfrmAGoodsGroupsDlg }

procedure TfrmAGoodsGroupsDlg.bbDeleteClick(Sender: TObject);
begin
  if (MessageDlg(Format('Stergeti inregistrarea?', []), mtConfirmation, [mbYes, mbNo], 0)= mrYes) then
    IBCQueryGroups.Delete;
end;

procedure TfrmAGoodsGroupsDlg.bbGoodsFolderDeleteClick(Sender: TObject);
begin
  if MessageDlg(Format(' Doriti sa stergeti grupa "%S"?', [IBCQueryGoodsFolders.FieldByName('Goods_name').AsString]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryGoodsFolders.Delete();
end;

procedure TfrmAGoodsGroupsDlg.bbGoodsFolderModifyClick(Sender: TObject);
var
     dialog: TfrmGoodsBrowser;
begin
   dialog:=TfrmGoodsBrowser.Create(Parent);
   try
     if dialog.SelectGoods(-1, True) then
     begin
       if dialog.GoodsIsFolder then
       begin
         IBCQueryGoodsFolders.Edit;
         IBCQueryGoodsFolders.FieldByName('goodsid').AsInteger := dialog.GoodsID;
         IBCQueryGoodsFolders.FieldByName('goods_name').AsString := dialog.GoodsTitle;
         IBCQueryGoodsFolders.Post;
       end
       else
        raise Exception.Create('Selectati o mapa!');
     end;
   finally
     dialog.Free;
   end;
end;

procedure TfrmAGoodsGroupsDlg.bbGoodsFolderNewClick(Sender: TObject);
var
     dialog: TfrmGoodsBrowser;
begin
   dialog:=TfrmGoodsBrowser.Create(Parent);
   try
     if dialog.SelectGoods(-1, True) then
     begin
       if dialog.GoodsIsFolder then
       begin
         IBCQueryGoodsFolders.Append;
         IBCQueryGoodsFolders.FieldByName('goodsid').AsInteger := dialog.GoodsID;
         IBCQueryGoodsFolders.FieldByName('goods_name').AsString := dialog.GoodsTitle;
         IBCQueryGoodsFolders.Post;
       end
       else
        raise Exception.Create('Selectati o mapa!');
     end;
   finally
     dialog.Free;
   end;
end;

procedure TfrmAGoodsGroupsDlg.bbModifyClick(Sender: TObject);
var
  dialog: TfrmAGoodsGroupsEditorDlg;
begin
  dialog := TfrmAGoodsGroupsEditorDlg.Create(Self, IBCQueryGroups, IBCDataSourceGroups);
  try
    dialog.IsNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmAGoodsGroupsDlg.bbNewClick(Sender: TObject);
var
  dialog: TfrmAGoodsGroupsEditorDlg;
begin
  dialog := TfrmAGoodsGroupsEditorDlg.Create(Self, IBCQueryGroups, IBCDataSourceGroups);
  try
    dialog.IsNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmAGoodsGroupsDlg.BindingDataSource;
begin
  IBCTrLocal.DefaultConnection := fIBCConnection;

  IBCQueryGroups.Active := True;
  IBCQueryGoodsFolders.Active := True;
end;

procedure TfrmAGoodsGroupsDlg.Prepare;
begin
  inherited;

end;

end.

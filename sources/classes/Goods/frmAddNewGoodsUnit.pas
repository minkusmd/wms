unit frmAddNewGoodsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, Vcl.Menus, DBAccess, IBC, MemDS,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, SWNBaseUnit, cxTL, cxMaskEdit, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxDBTL, cxTLData, cxContainer, cxTextEdit, cxButtonEdit,
  SWNButtonEditClass, cxCheckBox, dxUIAClasses, dxCoreGraphics;

type
  TfrmAddNewGoodsDlg = class(TSWNMasteredFormClass)
    cxGrid_Folders: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel1: TPanel;
    cxButton1: TcxButton;
    IBCQueryGoodsFolders: TIBCQuery;
    IBCDataSourceGoodsFolders: TIBCDataSource;
    cxGrid_FoldersColumn1: TcxGridDBColumn;
    cxGrid_FoldersColumn2: TcxGridDBColumn;
    cxButton2: TcxButton;
    cxWebCatalogTree: TcxDBTreeList;
    cxGridGoods: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    IBCQueryWebCatalog: TIBCQuery;
    IBCDataSourceWebCatalog: TIBCDataSource;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxWebCatalogTreecxDBTreeListColumn1: TcxDBTreeListColumn;
    cxWebCatalogTreecxDBTreeListColumn2: TcxDBTreeListColumn;
    cxGridGoodsColumn1: TcxGridDBColumn;
    cxGridGoodsColumn2: TcxGridDBColumn;
    cxGridGoodsColumn3: TcxGridDBColumn;
    beGoodsFolder: TcxButtonEdit;
    cxGridGoodsColumn4: TcxGridDBColumn;
    Label1: TLabel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Label2: TLabel;
    Label3: TLabel;
    IBCQueryWebCatalogGoods: TIBCQuery;
    IBCDataSourceWebCatalogGoods: TIBCDataSource;
    Label4: TLabel;
    cxGridGoodsWEBTOODSTITLE: TcxGridDBColumn;
    cxGridGoodsWEBGOODSTITLERU: TcxGridDBColumn;
    cxGrid_FoldersColumn3: TcxGridDBColumn;
    Label5: TLabel;
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure cxGridGoodsKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure cxGrid_FoldersKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure cxWebCatalogTreeFocusedNodeChanged(Sender: TcxCustomTreeList;
        APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure IBCDataSourceGoodsFoldersDataChange(Sender: TObject; Field: TField);
    procedure IBCDataSourceWebCatalogDataChange(Sender: TObject; Field: TField);
    procedure SWNButtonEdit1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FGoodsFolderID: Integer;
    FGoodsFolderName: string;
    procedure SetGoodsFolderID(const Value: Integer);
    procedure SetGoodsFolderName(const Value: string);
    procedure OpenWebCatalogPath;
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    WebGoodsTypeID: Integer;
    procedure LocateWebCatalog(WebCatalogID: Integer);
    procedure ShowGoodsList;
    property GoodsFolderID: Integer read FGoodsFolderID write SetGoodsFolderID;
    property GoodsFolderName: string read FGoodsFolderName write SetGoodsFolderName;
    { Public declarations }
  end;

var
  frmAddNewGoodsDlg: TfrmAddNewGoodsDlg;

implementation

uses
  frmGoods, SWNUtils;

{$R *.dfm}

procedure TfrmAddNewGoodsDlg.cxGridDBTableView1KeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGridDBTableView1, key, shift);
end;

procedure TfrmAddNewGoodsDlg.cxGridGoodsKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGridGoods, Key, Shift);
end;

procedure TfrmAddNewGoodsDlg.cxGrid_FoldersKeyDown(Sender: TObject; var Key:
    Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGrid_Folders, Key, Shift);
end;

procedure TfrmAddNewGoodsDlg.cxWebCatalogTreeFocusedNodeChanged(Sender:
    TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
begin
//  if IBCQueryWebCatalog.Active then
//  begin
//    IBCQueryWebCatalogGoods.Close;
//    IBCQueryWebCatalogGoods.ParamByName('CATALOGID').AsInteger := IBCQueryWebCatalog.FieldByName('CATALOGID').AsInteger;
//    IBCQueryWebCatalogGoods.Open;
//  end;
end;

procedure TfrmAddNewGoodsDlg.IBCDataSourceGoodsFoldersDataChange(Sender: TObject; Field: TField);
begin
  OpenWebCatalogPath;
  ShowGoodsList;
end;

procedure TfrmAddNewGoodsDlg.IBCDataSourceWebCatalogDataChange(Sender: TObject;
    Field: TField);
begin
end;

{ TfrmAddNewGoodsDlg }

function TfrmAddNewGoodsDlg.IsFormDataPosted: Boolean;
var
  d: TfrmGoodsBrowser;
begin
  Result := false;
  GoodsFolderID := -1;
  GoodsFolderName := '';
  if beGoodsFolder.Tag > 0 then
  begin
    Result := True;
    GoodsFolderID := beGoodsFolder.Tag;
    GoodsFolderName := beGoodsFolder.Text;
  end
  else
  if (IBCQueryGoodsFolders.FieldByName('parentid').AsInteger > 0) then
  begin
    GoodsFolderID := IBCQueryGoodsFolders.FieldByName('parentid').AsInteger;
    GoodsFolderName := IBCQueryGoodsFolders.FieldByName('title').AsString;
    Result := True;
  end
  else
  begin
    d := TfrmGoodsBrowser.Create(self);
    try
      if d.SelectGoods(-1, True, -1) then
      begin
        GoodsFolderID := d.GoodsID;
        GoodsFolderName := d.GoodsTitle;
        Result := True
      end
    finally
      d.Free;
    end;
  end;
end;

procedure TfrmAddNewGoodsDlg.LocateWebCatalog(WebCatalogID: Integer);
begin
  IBCQueryWebCatalog.Locate('CATALOGID', WebCatalogID, []);
end;

procedure TfrmAddNewGoodsDlg.OpenWebCatalogPath;
begin
  ibcquerywebcatalog.Close;
  ibcquerywebcatalog.ParamByName('FOLDERID').AsInteger := IBCQueryGoodsFolders.FieldByName('PARENTID').AsInteger;
  IBCQueryWebCatalog.Open;
  LocateWebCatalog(IBCQueryGoodsFolders.FieldByName('PARENTID').AsInteger);
  IBCQueryWebCatalog.Last;
end;

procedure TfrmAddNewGoodsDlg.Prepare;
begin
  inherited;
//  if IBCQueryGoodsFolders.MacroByName('m_webgoodstypeid').Value = '' then
    IBCQueryGoodsFolders.MacroByName('m_webgoodstypeid').Value := 'and g.webgoodstype_id = :webgoodstypeid';

//  if VarIsNull(IBCQueryGoodsFolders.FindParam('WEBGOODSTYPEID').Value) then
    IBCQueryGoodsFolders.ParamByName('WEBGOODSTYPEID').AsInteger := WebGoodsTypeID;

  beGoodsFolder.Tag := -1;
  beGoodsFolder.Text := '';
  // Open dataset
  IBCQueryGoodsFolders.Open;
  IBCQueryGoods.Open;
end;

procedure TfrmAddNewGoodsDlg.SetGoodsFolderID(const Value: Integer);
begin
  FGoodsFolderID := Value;
end;

procedure TfrmAddNewGoodsDlg.SetGoodsFolderName(const Value: string);
begin
  FGoodsFolderName := Value;
end;

procedure TfrmAddNewGoodsDlg.ShowGoodsList;
begin
  IBCQueryGoods.Close;
  IBCQueryGoods.ParamByName('parentid').AsInteger := IBCQueryGoodsFolders.FieldByName('PARENTID').AsInteger;
  IBCQueryGoods.Open;
end;

procedure TfrmAddNewGoodsDlg.SWNButtonEdit1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  d: TfrmGoodsBrowser;
begin
  d := TfrmGoodsBrowser.Create(self);
    try
      if d.SelectGoods(-1, True, -1) then
      begin
        GoodsFolderID := d.GoodsID;
        GoodsFolderName := d.GoodsTitle;
        beGoodsFolder.Tag := d.GoodsID;
        beGoodsFolder.Text := d.GoodsTitle;
      end
    finally
      d.Free;
    end;
end;

procedure TfrmAddNewGoodsDlg.WhenCancelForm;
begin
  inherited;
  GoodsFolderID := -1;
  GoodsFolderName := '';
  beGoodsFolder.Tag := -1;
  beGoodsFolder.Text := '';

end;

end.


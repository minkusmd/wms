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
    pmGoods: TPopupMenu;
    miChangeGoodsType: TMenuItem;
    miChangeParent: TMenuItem;
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
    procedure pmGoodsPopup(Sender: TObject);
    procedure miChangeGoodsTypeClick(Sender: TObject);
    procedure miChangeParentClick(Sender: TObject);
  private
    FGoodsFolderID: Integer;
    FGoodsFolderName: string;
    procedure SetGoodsFolderID(const Value: Integer);
    procedure SetGoodsFolderName(const Value: string);
    procedure OpenWebCatalogPath;
    function GetSelectedGoodsIDs(Titles: TStrings = nil): TArray<Integer>;
    procedure ChangeSelectedGoodsType;
    procedure MoveSelectedGoodsToFolder;
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
  frmGoods, SWNUtils, DataModuleDB, frmGoodsTypeDialog, frmChangeParentFolderDialog;

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

// Produsele selectate in cxGridGoods: ID-urile in Result, denumirile (optional) in Titles
function TfrmAddNewGoodsDlg.GetSelectedGoodsIDs(Titles: TStrings): TArray<Integer>;
var
  i, RecIdx: Integer;
  GoodsID: Variant;
begin
  Result := nil;
  if not IBCQueryGoods.Active then
    Exit;
  for i := 0 to cxGridGoods.Controller.SelectedRecordCount - 1 do
  begin
    RecIdx := cxGridGoods.Controller.SelectedRecords[i].RecordIndex;
    GoodsID := cxGridGoods.DataController.Values[RecIdx, cxGridGoodsColumn1.Index];
    if VarIsNull(GoodsID) then
      Continue;
    Result := Result + [Integer(GoodsID)];
    if Assigned(Titles) then
      Titles.Add(VarToStr(cxGridGoods.DataController.Values[RecIdx, cxGridGoodsColumn2.Index]));
  end;
end;

procedure TfrmAddNewGoodsDlg.pmGoodsPopup(Sender: TObject);
var
  HasSelection: Boolean;
begin
  HasSelection := IBCQueryGoods.Active and (cxGridGoods.Controller.SelectedRecordCount > 0);
  miChangeGoodsType.Enabled := HasSelection;
  miChangeParent.Enabled := HasSelection;
end;

procedure TfrmAddNewGoodsDlg.miChangeGoodsTypeClick(Sender: TObject);
begin
  ChangeSelectedGoodsType;
end;

procedure TfrmAddNewGoodsDlg.miChangeParentClick(Sender: TObject);
begin
  MoveSelectedGoodsToFolder;
end;

// Tipul de produs (TS_GOODS.WEBGOODSTYPE_ID) la toate produsele selectate, ales din
// nomenclatorul de tipuri (TfrmGoodsTypeDlg), la fel ca in nomenclatorul de produse
procedure TfrmAddNewGoodsDlg.ChangeSelectedGoodsType;
var
  d: TfrmGoodsTypeDlg;
  q: TIBCQuery;
  IDs: TArray<Integer>;
  GoodsID: Integer;
begin
  IDs := GetSelectedGoodsIDs;
  if Length(IDs) = 0 then
  begin
    MessageDlg('Selectati produsele carora le schimbati tipul!', mtError, [mbOK], 0);
    Exit;
  end;
  d := TfrmGoodsTypeDlg.Create(Self);
  try
    // implicit: tipul produsului curent din grid
    if not d.SelectGoodsType(IBCQueryGoods.FieldByName('WEBGOODSTYPE_ID').AsInteger) then
      Exit;
    q := TIBCQuery.Create(Self);
    try
      q.Connection := dmDB.IBCConnection;
      q.Transaction := dmDB.IBCTrDefaultUpdate;
      q.AutoCommit := False;
      q.SQL.Text := 'UPDATE TS_GOODS SET WEBGOODSTYPE_ID = :WEBGOODSTYPE_ID WHERE GOODSID = :GOODSID';
      q.ParamByName('WEBGOODSTYPE_ID').AsInteger := d.GoodsTypeID;
      if not q.Transaction.Active then
        q.Transaction.StartTransaction;
      try
        for GoodsID in IDs do
        begin
          q.ParamByName('GOODSID').AsInteger := GoodsID;
          q.ExecSQL;
        end;
        q.Transaction.Commit;
      except
        if q.Transaction.Active then
          q.Transaction.Rollback;
        raise;
      end;
    finally
      q.Free;
    end;
    IBCQueryGoods.Refresh;
  finally
    d.Free;
  end;
end;

// Muta produsele selectate in alta mapa: dialogul TfrmChangeParentFolderDlg (acelasi ca in
// nomenclator) alege mapa si scrie singur PARENTID; aici doar reincarcam mapele si lista
procedure TfrmAddNewGoodsDlg.MoveSelectedGoodsToFolder;
var
  d: TfrmChangeParentFolderDlg;
  IDs: TArray<Integer>;
  Titles: TStringList;
  i: Integer;
begin
  Titles := TStringList.Create;
  try
    IDs := GetSelectedGoodsIDs(Titles);
    if Length(IDs) = 0 then
    begin
      MessageDlg('Selectati produsele pe care le mutati in alta mapa!', mtError, [mbOK], 0);
      Exit;
    end;
    d := TfrmChangeParentFolderDlg.Create(Self);
    try
      d.DBTable := dbtGOODS;
      d.FolderObjectID := IBCQueryGoodsFolders.FieldByName('PARENTID').AsInteger;
      for i := 0 to High(IDs) do
        d.AddObjectInfo(IDs[i], Titles[i]);
      if d.ShowModal = mrOk then
      begin
        IBCQueryGoodsFolders.Refresh; // GOODS_CNT al mapelor s-a schimbat
        ShowGoodsList;
      end;
    finally
      d.Free;
    end;
  finally
    Titles.Free;
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


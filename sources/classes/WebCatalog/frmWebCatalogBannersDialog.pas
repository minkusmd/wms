unit frmWebCatalogBannersDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.ExtCtrls, Vcl.StdCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxContainer, cxTextEdit, DBAccess, IBC, MemDS, cxLabel, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmWebCatalogBannersDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnClose: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    pnTop: TPanel;
    Label1: TLabel;
    edCatalogName: TcxTextEdit;
    IBCQueryBanners: TIBCQuery;
    IBCDataSourceBanners: TIBCDataSource;
    cxGridTable_BANNERID: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_START_DATE: TcxGridDBColumn;
    cxGridTable_END_DATE: TcxGridDBColumn;
    bbSort: TdxBarButton;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    bbImport: TdxBarButton;
    IBCTrLocal: TIBCTransaction;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure bbSortClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    fCatalogID: integer;
    procedure SetCatalogID(const Value: integer);
    procedure SelectionChanged;

    procedure ReadCatalogInfo;

    procedure ShowCreateNewBannerDialog;
    procedure ShowModifyBannerDialog;
    procedure DeleteBanner;
    procedure ShowSortBanners;

  protected
    { protected declarations }
    procedure Prepare; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; const UpdateTransaction: TIBCTransaction); reintroduce;
    property CatalogID: integer read fCatalogID write SetCatalogID;
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNDBErrors, frmWebCatalogBannerEditorDialog;

{ TfrmWebCatalogBannersDlg }

procedure TfrmWebCatalogBannersDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteBanner;
end;

procedure TfrmWebCatalogBannersDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyBannerDialog;
end;

procedure TfrmWebCatalogBannersDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewBannerDialog;
end;

procedure TfrmWebCatalogBannersDlg.bbSortClick(Sender: TObject);
begin
  ShowSortBanners;
end;

constructor TfrmWebCatalogBannersDlg.Create(AOwner: TComponent; const UpdateTransaction: TIBCTransaction);
begin
  inherited Create(AOwner);
  IBCQueryBanners.UpdateTransaction := UpdateTransaction;
end;

procedure TfrmWebCatalogBannersDlg.bbImportClick(Sender: TObject);
var
    q: TIBCQuery;
    S: string;
begin
    if InputQuery('Import banere pentru catalog', 'Introduceti id banner sursa', S) then
    begin
        q := TIBCQuery.Create(nil);
        try
            q.Transaction := IBCTrLocal;
            q.sql.Text := 'execute procedure web_clone_catalog_baner(:banerid, :catalogid)';
            q.ParamByName('banerid').AsString := S;
            q.ParamByName('catalogid').AsInteger := fCatalogID;
            try
                q.ExecSQL;
                if IBCTrLocal.Active then
                    IBCTrLocal.Commit;
                IBCQueryBanners.Refresh;
            except
                on E: Exception do
                begin
                    IBCTrLocal.Rollback;
                    raise;
                end;
            end;
        finally
            q.Free;
        end;
    end;
end;

procedure TfrmWebCatalogBannersDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and bbEdit.Enabled then
  begin
    bbEditClick(bbEdit);
    AHandled := True;
  end;
end;

procedure TfrmWebCatalogBannersDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmWebCatalogBannersDlg.DeleteBanner;
begin
  if ShowAskDialog('Sterge baner', Format('Stergeti banerul "%s"?', [IBCQueryBanners.FieldByName('TITLE').AsString])) = mrYes
  then
  begin
    IBCQueryBanners.UpdateTransaction.StartTransaction;
    try
      IBCQueryBanners.Delete;
      IBCQueryBanners.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryBanners.UpdateTransaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmWebCatalogBannersDlg.Prepare;
begin
  ReadCatalogInfo;

  IBCQueryBanners.ParamByName('ID').AsInteger := fCatalogID;
  IBCQueryBanners.Active := True;

  SelectionChanged;
end;

procedure TfrmWebCatalogBannersDlg.ReadCatalogInfo;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT CATALOGID,PARENTID, TITLE_RUS FROM TWEB_CATALOG WHERE CATALOGID=:ID';
    Query.ParamByName('ID').AsInteger := fCatalogID;
    Query.ExecSQL;
    if Not Query.Eof then
    begin
      if Query.Fields[1].AsInteger = 0 then
        edCatalogName.Text := 'Pentru tot catalogul web!'
      else
        edCatalogName.Text := Query.Fields[2].AsString;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmWebCatalogBannersDlg.SelectionChanged;
var
  fAdd, fEdit, fDelete: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  if cxGridTable.DataController.RecNo > 0 then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbNew.Enabled := fAdd;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbSort.Enabled := cxGridTable.DataController.RecordCount > 1;
end;

procedure TfrmWebCatalogBannersDlg.SetCatalogID(const Value: integer);
begin
  fCatalogID := Value;
end;

procedure TfrmWebCatalogBannersDlg.ShowCreateNewBannerDialog;
var
  dialog: TfrmWebCatalogBannerEditorDlg;
begin
  dialog := TfrmWebCatalogBannerEditorDlg.Create(Self, IBCQueryBanners, IBCDataSourceBanners);
  try
    dialog.CreateNewRecord := True;
    dialog.CatalogID := fCatalogID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogBannersDlg.ShowModifyBannerDialog;
var
  dialog: TfrmWebCatalogBannerEditorDlg;
begin
  dialog := TfrmWebCatalogBannerEditorDlg.Create(Self, IBCQueryBanners, IBCDataSourceBanners);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmWebCatalogBannersDlg.ShowSortBanners;
begin

end;

end.

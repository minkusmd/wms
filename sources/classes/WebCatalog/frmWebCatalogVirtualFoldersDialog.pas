unit frmWebCatalogVirtualFoldersDialog;

{
  Lista mapelor virtuale ale unui nod de catalog (TWEB_CATALOG_VIRTUAL, prin
  view-ul updatable VW_TWEB_CATALOG_VIRTUAL).

  O mapa virtuala nu are mape proprii de produse: ea afiseaza produsele
  categoriei-parinte filtrate dupa un atribut (FILTERID + FILTERPARAMIDS).
  Pe site apare ca tile in capul categoriei si ca pagina proprie, la
  /category/<parinte>/<categorie>/<id>/<slug>.
}

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
    SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
    cxEdit, DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxContainer,
    cxTextEdit, DBAccess, IBC, MemDS, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations;

type
    TfrmWebCatalogVirtualFoldersDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        pnTop: TPanel;
        Label1: TLabel;
        edCatalogName: TcxTextEdit;
        btnClose: TButton;
        dxBarManager1: TdxBarManager;
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager1Bar1: TdxBar;
        bbNew: TdxBarButton;
        bbEdit: TdxBarButton;
        bbDelete: TdxBarButton;
        cxGrid: TcxGrid;
        cxGridLevel: TcxGridLevel;
        cxGridTable: TcxGridDBTableView;
        cxGridTable_ID: TcxGridDBColumn;
        cxGridTable_TITLE_ROM: TcxGridDBColumn;
        cxGridTable_TITLE_RUS: TcxGridDBColumn;
        cxGridTable_REWRITE_URL: TcxGridDBColumn;
        cxGridTable_FILTER_NAME: TcxGridDBColumn;
        cxGridTable_FLG_ENABLED: TcxGridDBColumn;
        cxGridTable_FLG_TILE: TcxGridDBColumn;
        cxGridTable_HAS_IMAGE: TcxGridDBColumn;
        cxGridTable_ORDERNO: TcxGridDBColumn;
        IBCQueryFolders: TIBCQuery;
        IBCDataSourceFolders: TIBCDataSource;
        procedure bbNewClick(Sender: TObject);
        procedure bbEditClick(Sender: TObject);
        procedure bbDeleteClick(Sender: TObject);
        procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
            ANewItemRecordFocusingChanged: Boolean);
        procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
            ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
            AShift: TShiftState; var AHandled: Boolean);
    private
        { Private declarations }
        fCatalogID: Integer;
        procedure SetCatalogID(const Value: Integer);
        procedure SelectionChanged;
        procedure ReadCatalogInfo;
        procedure ShowEditorDialog(const CreateNew: Boolean);
        procedure DeleteFolder;
    protected
        { protected declarations }
        procedure Prepare; override;
    public
        { Public declarations }
        constructor Create(AOwner: TComponent; const UpdateTransaction: TIBCTransaction); reintroduce;
        property CatalogID: Integer read fCatalogID write SetCatalogID;
    end;

implementation

{$R *.dfm}

uses
    DataModuleDB, DataModuleAdditions, SWNUtils, SWNDBErrors,
    frmWebCatalogVirtualFolderEditorDialog;

{ TfrmWebCatalogVirtualFoldersDlg }

constructor TfrmWebCatalogVirtualFoldersDlg.Create(AOwner: TComponent;
    const UpdateTransaction: TIBCTransaction);
begin
    inherited Create(AOwner);
    IBCQueryFolders.UpdateTransaction := UpdateTransaction;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.bbDeleteClick(Sender: TObject);
begin
    DeleteFolder;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.bbEditClick(Sender: TObject);
begin
    ShowEditorDialog(False);
end;

procedure TfrmWebCatalogVirtualFoldersDlg.bbNewClick(Sender: TObject);
begin
    ShowEditorDialog(True);
end;

procedure TfrmWebCatalogVirtualFoldersDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
    var AHandled: Boolean);
begin
    if (AButton = mbLeft) and bbEdit.Enabled then
    begin
        bbEditClick(bbEdit);
        AHandled := True;
    end;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.cxGridTableFocusedRecordChanged(
    Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
    ANewItemRecordFocusingChanged: Boolean);
begin
    SelectionChanged;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.DeleteFolder;
begin
    if ShowAskDialog('Sterge mapa virtuala',
        Format('Stergeti mapa virtuala "%s"?',
        [IBCQueryFolders.FieldByName('TITLE_ROM').AsString])) <> mrYes then
        Exit;

    IBCQueryFolders.UpdateTransaction.StartTransaction;
    try
        IBCQueryFolders.Delete;
        IBCQueryFolders.UpdateTransaction.Commit;
    except
        on E: Exception do
        begin
            IBCQueryFolders.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.Prepare;
begin
    ReadCatalogInfo;

    IBCQueryFolders.ParamByName('ID').AsInteger := fCatalogID;
    IBCQueryFolders.Active := True;

    SelectionChanged;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.ReadCatalogInfo;
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultSelect;
        Query.SQL.Text := 'SELECT TITLE, TITLE_RUS FROM TWEB_CATALOG WHERE CATALOGID = :ID';
        Query.ParamByName('ID').AsInteger := fCatalogID;
        Query.Open;
        if not Query.Eof then
            edCatalogName.Text := Query.Fields[0].AsString;
    finally
        Query.Free;
    end;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.SelectionChanged;
var
    fHasRecord: Boolean;
begin
    fHasRecord := cxGridTable.DataController.RecNo > 0;
    bbNew.Enabled := True;
    bbEdit.Enabled := fHasRecord;
    bbDelete.Enabled := fHasRecord;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.SetCatalogID(const Value: Integer);
begin
    fCatalogID := Value;
end;

procedure TfrmWebCatalogVirtualFoldersDlg.ShowEditorDialog(const CreateNew: Boolean);
var
    dialog: TfrmWebCatalogVirtualFolderEditorDlg;
begin
    dialog := TfrmWebCatalogVirtualFolderEditorDlg.Create(Self, IBCQueryFolders,
        IBCDataSourceFolders);
    try
        dialog.CreateNewRecord := CreateNew;
        dialog.CatalogID := fCatalogID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
    SelectionChanged;
end;

end.

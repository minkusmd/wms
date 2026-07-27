unit frameScanFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxImageComboBox, dxBar, cxClasses, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, MemDS, DBAccess, IBC,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TframeScanFile = class(TFrame)
    IBCDataSourceFiles: TIBCDataSource;
    IBCQueryFiles: TIBCQuery;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_DATA: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbAddFile: TdxBarButton;
    bbDeleteFile: TdxBarButton;
    bbSaveAs: TdxBarButton;
    dxBarButton1: TdxBarButton;
    procedure bbAddFileClick(Sender: TObject);
    procedure bbDeleteFileClick(Sender: TObject);
    procedure bbSaveAsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fDataOpened: Boolean;
    procedure SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure OpenDataSet;
    procedure CloseDataSet;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, frm53RPPFileEditorDialog, SWNUtils, SWNDBErrors,
  frmPreviewPDFUnit;

{$R *.dfm}


{ TframeScanFile }

procedure TframeScanFile.bbAddFileClick(Sender: TObject);
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TframeScanFile.bbDeleteFileClick(Sender: TObject);
begin
  if ShowAskDialog('Scan', Format('Stergeti fisierul "%s"?', [IBCQueryFiles.FieldByName('FILENAME').AsString]))
    = mrYes then
  begin
    IBCQueryFiles.UpdateTransaction.StartTransaction;
    try
      IBCQueryFiles.Delete;
      IBCQueryFiles.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryFiles.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure TframeScanFile.bbSaveAsClick(Sender: TObject);
begin
  with TSaveDialog.Create(Self) do
  try
    FileName := IBCQueryFiles.FieldByName('FILENAME').AsString;
    Filter := '*.*';
    if Execute then
      SaveFileAsDB(FileName, IBCQueryFiles.FieldByName('ATTID').AsInteger);
  finally
    Free;
  end;
end;

procedure TframeScanFile.SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
    Query.ParamByName('ID').AsInteger := AttachmentID;
    Query.ExecSQL;
    if not Query.Eof then
      TBlobField(Query.Fields[0]).SaveToFile(FileName);
  finally
    Query.Free;
  end;
end;

procedure TframeScanFile.CloseDataSet;
begin
  IBCQueryFiles.Close;
end;

constructor TframeScanFile.Create(AOwner: TComponent);
begin
  inherited;
  fDataOpened := false;
end;

procedure TframeScanFile.dxBarButton1Click(Sender: TObject);
var
  d:  TfrmPreviewPDFDlg;
  q: TIBCQuery;
  ms: TMemoryStream;
begin
  d:=TfrmPreviewPDFDlg.Create(Self, dmdb.IBCConnection);
  ms := TMemoryStream.Create;
  q := TIBCQuery.Create(nil);
  try
    q := TIBCQuery.Create(nil);
    q.SQL.Add('SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID');
    q.ParamByName('ID').AsInteger := IBCQueryFiles.FieldByName('ATTID').AsInteger;
    q.Open;
    TBlobField(q.FieldByName('filedata')).SaveToStream(ms);
    ms.Position := 0;
    d.PdfStream := ms;
    d.ShowModal;
  finally
    d.Free;
    ms.Free;
    q.Free;
  end;
end;

procedure TframeScanFile.OpenDataSet;
begin
  try
    IBCQueryFiles.Open;
  finally
    fDataOpened := True;
  end;
end;

end.


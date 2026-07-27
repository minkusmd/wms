unit frmSqlRepositoryWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxContainer, dxBar, cxTextEdit,
  cxMemo, cxDBEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, cxSplitter, DBAccess, IBC, MemDS, cxImageComboBox, cxPCdxBarPopupMenu, cxPC, dxBarBuiltInMenu,
  dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations;

type
  TfrmSqlRepositoryWin = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnList: TPanel;
    pnContent: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    dxBarManager1Bar2: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbCopySql: TdxBarButton;
    cxSplitter1: TcxSplitter;
    IBCQueryRep: TIBCQuery;
    IBCDataSourceRep: TIBCDataSource;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    bbSort: TdxBarButton;
    bbExecute: TdxBarButton;
    IBCExecuteTransaction: TIBCTransaction;
    IBCQueryExec: TIBCQuery;
    IBCDataSourceExec: TIBCDataSource;
    pcPageControl: TcxPageControl;
    tbsSQLText: TcxTabSheet;
    tbsResults: TcxTabSheet;
    mmSQL_TEXT: TcxDBMemo;
    cxGridExecTable: TcxGridDBTableView;
    cxGridExecLevel: TcxGridLevel;
    cxGridExec: TcxGrid;
    cxGridExecTableColumn1: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbSortClick(Sender: TObject);
    procedure bbCopySqlClick(Sender: TObject);
    procedure bbExecuteClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowCreateNewDialog;
    procedure ShowModifyDialog;
    procedure DeleteSelection;
    procedure ShowSortDialog;
    procedure CopySQL;
    procedure ExecuteSQL;
    procedure DisplaySQLResults;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, Vcl.Clipbrd, frmSqlRepositoryEditorDialog, SWNUtils, SWNDBErrors,
  frmChangeOrderNoDialog, SWNValueStorageUnit;

{ TForm2 }

procedure TfrmSqlRepositoryWin.bbCopySqlClick(Sender: TObject);
begin
  CopySQL;
end;

procedure TfrmSqlRepositoryWin.bbDeleteClick(Sender: TObject);
begin
  DeleteSelection;
end;

procedure TfrmSqlRepositoryWin.bbEditClick(Sender: TObject);
begin
  ShowModifyDialog;
end;

procedure TfrmSqlRepositoryWin.bbExecuteClick(Sender: TObject);
begin
  ExecuteSQL;
end;

procedure TfrmSqlRepositoryWin.bbNewClick(Sender: TObject);
begin
  ShowCreateNewDialog;
end;

procedure TfrmSqlRepositoryWin.bbSortClick(Sender: TObject);
begin
  ShowSortDialog;
end;

procedure TfrmSqlRepositoryWin.CopySQL;
begin
  Clipboard.AsText := IBCQueryRep.FieldByName('SQL_TEXT').AsString;
end;

procedure TfrmSqlRepositoryWin.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSqlRepositoryWin.DeleteSelection;
begin
  if ShowAskDialog('SQL query', Format('Doriti sa stergeti "%s"?', [IBCQueryRep.FieldByName('TITLE').AsString])) = mrYes then
  begin
    IBCQueryRep.UpdateTransaction.StartTransaction;
    try
      IBCQueryRep.Delete;
      IBCQueryRep.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryRep.UpdateTransaction.Rollback;
        if not ProcessSWNError(e) then
          raise;
      end;
    end;
  end;
end;

procedure TfrmSqlRepositoryWin.DisplaySQLResults;
var
  i: integer;
  col: TcxGridDBColumn;
begin
  cxGridExecTable.BeginUpdate;
  try
    cxGridExecTable.ClearItems;
        // create columns
    for i := 0 to IBCQueryExec.FieldCount - 1 do
    begin
      col := cxGridExecTable.CreateColumn;
      col.DataBinding.FieldName := IBCQueryExec.Fields[i].FieldName;
    end;
  finally
    cxGridExecTable.EndUpdate;
  end;
end;

procedure TfrmSqlRepositoryWin.ExecuteSQL;
begin
  IBCQueryExec.Close;
  IBCQueryExec.SQL.Text := IBCQueryRep.FieldByName('SQL_TEXT').AsString;
  try
    IBCQueryExec.ExecSQL;
    DisplaySQLResults;
    pcPageControl.ActivePage := tbsResults;
  except
    on E: Exception do
      ShowErrorDialog('Eroare!', E.Message);
  end;
end;

procedure TfrmSqlRepositoryWin.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
  begin
    if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
      Self.Position := poDesigned;
    pnList.Width := AppUserConfigStorage.IntValues.GetValue('Splitter', 400);
  end;
end;

procedure TfrmSqlRepositoryWin.Prepare;
begin
  pcPageControl.ActivePage := tbsSQLText;

  IBCQueryRep.Active := True;
  SelectionChanged;
end;

procedure TfrmSqlRepositoryWin.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
  begin
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    AppUserConfigStorage.IntValues.SetValue('Splitter', pnList.Width);
  end;
end;

procedure TfrmSqlRepositoryWin.SelectionChanged;
var
  fAdd, fEdit, fDelete, fSort, fCopy: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  fSort := cxGridTable.DataController.RecordCount > 1;
  fCopy := False;

  if cxGridTable.DataController.RecNo > 0 then
  begin
    fEdit := True;
    fDelete := True;
    fCopy := True;
  end;

  bbNew.Enabled := fAdd;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbSort.Enabled := fSort;
  bbCopySql.Enabled := fCopy;
  bbExecute.Enabled := fCopy;
end;

procedure TfrmSqlRepositoryWin.ShowCreateNewDialog;
var
  dialog: TfrmSqlRepositoryEditorDlg;
begin
  dialog := TfrmSqlRepositoryEditorDlg.Create(Self, IBCQueryRep, IBCDataSourceRep);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSqlRepositoryWin.ShowModifyDialog;
var
  dialog: TfrmSqlRepositoryEditorDlg;
begin
  dialog := TfrmSqlRepositoryEditorDlg.Create(Self, IBCQueryRep, IBCDataSourceRep);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSqlRepositoryWin.ShowSortDialog;
var
  dialog: TfrmChangeOrderNoDlg;
begin
  dialog := TfrmChangeOrderNoDlg.Create(Self);
  try
    dialog.DBTable := cotSqlRepository;
    if dialog.ShowModal = mrOk then
      IBCQueryRep.Refresh;
  finally
    dialog.Free;
  end;
end;

end.


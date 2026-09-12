unit frmServiceRefTaskTypesDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxClasses, dxBar, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS, cxCheckBox,
  cxImageComboBox, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmServiceRefTaskTypesDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnButtons: TPanel;
    btnClose: TButton;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryTT: TIBCQuery;
    IBCDataSourceTT: TIBCDataSource;
    cxGridTable_TASKTYPEID: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_DESCRIPTION: TcxGridDBColumn;
    cxGridTable_FLG_START_STATE: TcxGridDBColumn;
    cxGridTable_FLG_END_STATE: TcxGridDBColumn;
    cxGridTable_FLG_CODE_STATE: TcxGridDBColumn;
    cxGridTable_VALUE_INT: TcxGridDBColumn;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridTable_DefImage: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowCreateNewTaskTypeDialog;
    procedure ShowModifyTaskTypeDialog;
    procedure ShowDeleteTaskTypeDialog;

  protected
    { protected declarations }
    procedure Prepare; override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmServiceRefTaskTypeEditorDialog, SWNUtils, SWNDBErrors;

{$R *.dfm}
{ TfrmServiceRefTaskTypesDlg }

procedure TfrmServiceRefTaskTypesDlg.bbDeleteClick(Sender: TObject);
begin
  ShowDeleteTaskTypeDialog;
end;

procedure TfrmServiceRefTaskTypesDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyTaskTypeDialog;
end;

procedure TfrmServiceRefTaskTypesDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewTaskTypeDialog;
end;

procedure TfrmServiceRefTaskTypesDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmServiceRefTaskTypesDlg.Prepare;
begin
  IBCQueryTT.Active := True;
  SelectionChanged;
  cxGridTable_TITLE.Focused := True;
end;

procedure TfrmServiceRefTaskTypesDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;

  if (cxGridTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
  end;

  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
end;

procedure TfrmServiceRefTaskTypesDlg.ShowCreateNewTaskTypeDialog;
var
  dialog: TfrmServiceRefTaskTypeEditorDlg;
begin
  dialog := TfrmServiceRefTaskTypeEditorDlg.Create(Self, IBCQueryTT, IBCDataSourceTT);
  try
    dialog.CreateNewTaskType := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRefTaskTypesDlg.ShowDeleteTaskTypeDialog;
begin
  if ShowAskDialog('Stergere', Format('Doriti sa stergeti tipul de sarcina "%s"?', [IBCQueryTT.FieldByName('TITLE').AsString])) <> mrYes then
    Exit;

  IBCQueryTT.UpdateTransaction.StartTransaction;
  try
    IBCQueryTT.Delete;
    IBCQueryTT.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryTT.UpdateTransaction.Rollback;
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmServiceRefTaskTypesDlg.ShowModifyTaskTypeDialog;
var
  dialog: TfrmServiceRefTaskTypeEditorDlg;
begin
  dialog := TfrmServiceRefTaskTypeEditorDlg.Create(Self, IBCQueryTT, IBCDataSourceTT);
  try
    dialog.CreateNewTaskType := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

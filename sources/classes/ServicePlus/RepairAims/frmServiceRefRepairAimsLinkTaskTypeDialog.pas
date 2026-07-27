unit frmServiceRefRepairAimsLinkTaskTypeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxContainer, cxTextEdit, cxDBEdit, Buttons, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridLevel, cxGrid, StdCtrls, ExtCtrls, DialogTitle, cxCheckBox, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmServiceRefRepairAimsLinkTaskTypeDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxGridSLevel: TcxGridLevel;
    cxGridS: TcxGrid;
    cxGridSTable: TcxGridTableView;
    cxGridA: TcxGrid;
    cxGridATable: TcxGridTableView;
    cxGridALevel: TcxGridLevel;
    sbAppend: TSpeedButton;
    sbRemove: TSpeedButton;
    Label3: TLabel;
    edTITLE: TcxDBTextEdit;
    btnOk: TButton;
    btnCancel: TButton;
    cxGridS_ID: TcxGridColumn;
    cxGridS_TITLE: TcxGridColumn;
    cxGridS_MUST: TcxGridColumn;
    cxGridA_ID: TcxGridColumn;
    cxGridA_TITLE: TcxGridColumn;
    procedure cxGridSTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridSTableDataControllerNewRecord(ADataController: TcxCustomDataController; ARecordIndex: Integer);
    procedure cxGridSTableDataControllerDataChanged(Sender: TObject);
    procedure sbAppendClick(Sender: TObject);
    procedure cxGridATableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure sbRemoveClick(Sender: TObject);
  private
    { Private declarations }
    fItemsChanged: Boolean;

    procedure SelectedTaskTypesSelectionChanged;
    procedure AviableTaskTypesSelectionChanged;

    procedure ReadData;
    function SaveItems: Boolean;

    procedure AddSelectedItems;
    procedure RemoveSelectedItems;

  protected
    { protected declarations }

    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, IBC, DataModuleDB, SWNDBErrors;

{$R *.dfm}
{ TForm2 }

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.AddSelectedItems;
var
  i, N: Integer;
  Rec: TcxCustomGridRecord;
begin
  cxGridATable.BeginUpdate;
  cxGridSTable.BeginUpdate;
  try
    for i := 0 to cxGridATable.Controller.SelectedRecordCount - 1 do
    begin
      Rec := cxGridATable.Controller.SelectedRecords[i];
      N := cxGridSTable.DataController.AppendRecord;
      cxGridSTable.DataController.Values[N, cxGridS_ID.Index] := Rec.Values[cxGridA_ID.Index];
      cxGridSTable.DataController.Values[N, cxGridS_TITLE.Index] := Rec.Values[cxGridA_TITLE.Index];
      cxGridSTable.DataController.Values[N, cxGridS_MUST.Index] := 0;
    end;
    cxGridATable.Controller.DeleteSelection;
  finally
    cxGridATable.EndUpdate;
    cxGridSTable.EndUpdate;
  end;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.AviableTaskTypesSelectionChanged;
var
  fAdd: Boolean;
begin
  fAdd := False;
  if Assigned(cxGridATable.Controller.FocusedRow) then
  begin
    fAdd := True;
  end;
  sbAppend.Enabled := fAdd;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.cxGridATableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddSelectedItems;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  AviableTaskTypesSelectionChanged;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.cxGridSTableDataControllerDataChanged(Sender: TObject);
begin
  fItemsChanged := True;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.cxGridSTableDataControllerNewRecord(ADataController: TcxCustomDataController;
  ARecordIndex: Integer);
begin
  fItemsChanged := True;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.cxGridSTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectedTaskTypesSelectionChanged;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.BindingDataSource;
begin
  inherited;

  edTITLE.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmServiceRefRepairAimsLinkTaskTypeDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if fItemsChanged then
    Result := SaveItems;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.Prepare;
begin
  inherited;

  ReadData;

  SelectedTaskTypesSelectionChanged;
  AviableTaskTypesSelectionChanged;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.ReadData;
var
  Query: TIBCQuery;
  N: Integer;
  TaskType: Integer;
  Title: String;
begin
  cxGridSTable.BeginUpdate;
  cxGridATable.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT SC_REF_TASK_TYPE.TASKTYPEID, SC_REF_TASK_TYPE.TITLE,');
    Query.SQL.Add('SC_REF_SCOP_TASK_TYPE.SCOPID, GET_FLG_VALUE(SC_REF_SCOP_TASK_TYPE.FLAGS,0), SC_REF_SCOP_TASK_TYPE.ORDERNO');
    Query.SQL.Add('FROM SC_REF_TASK_TYPE');
    Query.SQL.Add
      ('LEFT OUTER JOIN SC_REF_SCOP_TASK_TYPE ON (SC_REF_SCOP_TASK_TYPE.TASKTYPEID=SC_REF_TASK_TYPE.TASKTYPEID AND SC_REF_SCOP_TASK_TYPE.SCOPID=:ID)');
    Query.SQL.Add('WHERE (SC_REF_TASK_TYPE.FLAGS=1)');
    Query.SQL.Add('ORDER BY SC_REF_SCOP_TASK_TYPE.ORDERNO, SC_REF_TASK_TYPE.TITLE');
    Query.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('SCOPID').AsInteger;
    Query.ExecSQL;
    while Not Query.Eof do
    begin
      TaskType := Query.Fields[0].AsInteger;
      Title := Query.Fields[1].AsString;
      if Query.Fields[2].IsNull then
      begin
        // item not in use
        N := cxGridATable.DataController.AppendRecord;
        cxGridATable.DataController.Values[N, cxGridA_ID.Index] := TaskType;
        cxGridATable.DataController.Values[N, cxGridA_TITLE.Index] := Title;
      end
      else
      begin
        N := cxGridSTable.DataController.AppendRecord;
        cxGridSTable.DataController.Values[N, cxGridS_ID.Index] := TaskType;
        cxGridSTable.DataController.Values[N, cxGridS_TITLE.Index] := Title;
        cxGridSTable.DataController.Values[N, cxGridS_MUST.Index] := Query.Fields[3].AsInteger;
      end;

      Query.Next;
    end;
    Query.Close;
    fItemsChanged := False;
  finally
    Query.Free;
    cxGridSTable.EndUpdate;
    cxGridATable.EndUpdate;
  end;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.RemoveSelectedItems;
var
  i, N: Integer;
  Rec: TcxCustomGridRecord;
begin
  cxGridATable.BeginUpdate;
  cxGridSTable.BeginUpdate;
  try
    for i := 0 to cxGridSTable.Controller.SelectedRecordCount - 1 do
    begin
      Rec := cxGridSTable.Controller.SelectedRecords[i];
      N := cxGridATable.DataController.AppendRecord;
      cxGridATable.DataController.Values[N, cxGridA_ID.Index] := Rec.Values[cxGridS_ID.Index];
      cxGridATable.DataController.Values[N, cxGridA_TITLE.Index] := Rec.Values[cxGridS_TITLE.Index];
    end;
    cxGridSTable.Controller.DeleteSelection;
  finally
    cxGridATable.EndUpdate;
    cxGridSTable.EndUpdate;
  end;
end;

function TfrmServiceRefRepairAimsLinkTaskTypeDlg.SaveItems: Boolean;
var
  Query: TIBCQuery;
  i: Integer;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.Transaction.StartTransaction;
    try
      // 1. remove old
      Query.SQL.Text := 'DELETE FROM SC_REF_SCOP_TASK_TYPE WHERE SCOPID=:ID';
      Query.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('SCOPID').AsInteger;
      Query.ExecSQL;

      // 2. create new
      Query.SQL.Text := 'INSERT INTO SC_REF_SCOP_TASK_TYPE (SCOPID,TASKTYPEID,FLAGS) VALUES (:id1,:id2,:flags)';
      Query.ParamByName('id1').AsInteger := fMasterDataSet.FieldByName('SCOPID').AsInteger;
      for i := 0 to cxGridSTable.DataController.RecordCount - 1 do
      begin
        Query.ParamByName('id2').AsInteger := cxGridSTable.DataController.Values[i, cxGridS_ID.Index];
        Query.ParamByName('flags').AsInteger := cxGridSTable.DataController.Values[i, cxGridS_MUST.Index];
        Query.ExecSQL;
      end;

      Query.Transaction.Commit;
      Result := True;

    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.sbAppendClick(Sender: TObject);
begin
  AddSelectedItems;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.sbRemoveClick(Sender: TObject);
begin
  RemoveSelectedItems;
end;

procedure TfrmServiceRefRepairAimsLinkTaskTypeDlg.SelectedTaskTypesSelectionChanged;
var
  fRemove: Boolean;
begin
  fRemove := False;
  if Assigned(cxGridSTable.Controller.FocusedRow) then
  begin
    fRemove := True;
  end;
  sbRemove.Enabled := fRemove;
end;

end.

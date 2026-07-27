unit frmDescriptionTemplateGTEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit, IBC,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DialogTitle, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxClasses,
  cxGridLevel, cxGrid, Vcl.Buttons, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  TfrmDescriptionTemplateGTEditorDlg = class(TSWNMasteredFormClass)
    pnClient: TPanel;
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    cxGridSLevel: TcxGridLevel;
    cxGridS: TcxGrid;
    cxGridALevel: TcxGridLevel;
    cxGridA: TcxGrid;
    cxGridSTable: TcxGridTableView;
    cxGridATable: TcxGridTableView;
    sbAddToSelected: TSpeedButton;
    sbAddToAvailable: TSpeedButton;
    cxGridATable_GOODSTYPEID: TcxGridColumn;
    cxGridATable_TITLE_ROM: TcxGridColumn;
    cxGridATable_TITLE_RUS: TcxGridColumn;
    cxGridSTable_GOODSTYPEID: TcxGridColumn;
    cxGridSTable_TITLE_RUS: TcxGridColumn;
    cxGridSTable_TITLE_ROM: TcxGridColumn;
    procedure cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure sbAddToSelectedClick(Sender: TObject);
    procedure sbAddToAvailableClick(Sender: TObject);
    procedure cxGridATableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridSTableSelectionChanged(Sender: TcxCustomGridTableView);
  private
    { Private declarations }
    procedure ReadData;
    procedure SelectionChanged;
    procedure AddItemsToSelected;
    procedure AddItemsToAvailable;
    function SaveData: Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNDBErrors;

{ TfrmDescriptionTemplateGTEditorDlg }

procedure TfrmDescriptionTemplateGTEditorDlg.AddItemsToAvailable;
var
  i, N: integer;
  rec: TcxCustomGridRecord;
begin
  cxGridATable.DataController.BeginUpdate;
  cxGridSTable.DataController.BeginUpdate;
  try
    for i := 0 to cxGridSTable.Controller.SelectedRecordCount - 1 do
    begin
      rec := cxGridSTable.Controller.SelectedRecords[i];
      N := cxGridATable.DataController.AppendRecord;
      cxGridATable.DataController.Values[N, cxGridATable_GOODSTYPEID.Index] := rec.Values[cxGridSTable_GOODSTYPEID.Index];
      cxGridATable.DataController.Values[N, cxGridATable_TITLE_ROM.Index] := rec.Values[cxGridSTable_TITLE_ROM.Index];
      cxGridATable.DataController.Values[N, cxGridATable_TITLE_RUS.Index] := rec.Values[cxGridSTable_TITLE_RUS.Index];
    end;
    cxGridSTable.Controller.DeleteSelection;
  finally
    cxGridATable.DataController.EndUpdate;
    cxGridSTable.DataController.EndUpdate;
    SelectionChanged;
  end;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.AddItemsToSelected;
var
  i, N: integer;
  rec: TcxCustomGridRecord;
begin
  cxGridATable.DataController.BeginUpdate;
  cxGridSTable.DataController.BeginUpdate;
  try
    for i := 0 to cxGridATable.Controller.SelectedRecordCount - 1 do
    begin
      rec := cxGridATable.Controller.SelectedRecords[i];
      N := cxGridSTable.DataController.AppendRecord;
      cxGridSTable.DataController.Values[N, cxGridSTable_GOODSTYPEID.Index] := rec.Values[cxGridATable_GOODSTYPEID.Index];
      cxGridSTable.DataController.Values[N, cxGridSTable_TITLE_ROM.Index] := rec.Values[cxGridATable_TITLE_ROM.Index];
      cxGridSTable.DataController.Values[N, cxGridSTable_TITLE_RUS.Index] := rec.Values[cxGridATable_TITLE_RUS.Index];
    end;
    cxGridATable.Controller.DeleteSelection;
  finally
    cxGridATable.DataController.EndUpdate;
    cxGridSTable.DataController.EndUpdate;
    SelectionChanged;
  end;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.cxGridATableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.cxGridATableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  SelectionChanged;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.cxGridSTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  SelectionChanged;
end;

function TfrmDescriptionTemplateGTEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := SaveData;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.Prepare;
begin
  ReadData;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.ReadData;
var
  Query: TIBCQuery;
  N: integer;
begin
  cxGridSTable.DataController.BeginUpdate;
  cxGridATable.DataController.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Add('SELECT GT.GOODSTYPEID, GT.TITLE, GT.TITLE_RUS,');
    Query.SQL.Add(' IIF(EXISTS(SELECT 1 FROM TS_DESC_TEMPL_GT WHERE TEMPLATEID=:tid AND GOODSTYPEID=GT.GOODSTYPEID),1,0) FLG_IN_USE');
    Query.SQL.Add(' FROM TS_GOODS_TYPE GT ORDER BY 3');
    Query.ParamByName('tid').asInteger := fMasterDataSet.FieldByName('TEMPLATEID').asInteger;
    Query.ExecSQL;
    while Not Query.Eof do
    begin
      if Query.FieldByName('FLG_IN_USE').asInteger = 1 then
      begin
        // add in Selected
        N := cxGridSTable.DataController.AppendRecord;
        cxGridSTable.DataController.Values[N, cxGridSTable_GOODSTYPEID.Index] := Query.FieldByName('GOODSTYPEID').asInteger;
        cxGridSTable.DataController.Values[N, cxGridSTable_TITLE_RUS.Index] := Query.FieldByName('TITLE_RUS').AsString;
        cxGridSTable.DataController.Values[N, cxGridSTable_TITLE_ROM.Index] := Query.FieldByName('TITLE').AsString;
      end
      else
      begin
        // add in Available
        N := cxGridATable.DataController.AppendRecord;
        cxGridATable.DataController.Values[N, cxGridATable_GOODSTYPEID.Index] := Query.FieldByName('GOODSTYPEID').asInteger;
        cxGridATable.DataController.Values[N, cxGridATable_TITLE_RUS.Index] := Query.FieldByName('TITLE_RUS').AsString;
        cxGridATable.DataController.Values[N, cxGridATable_TITLE_ROM.Index] := Query.FieldByName('TITLE').AsString;
      end;
      Query.Next;
    end;
  finally
    Query.Free;
    cxGridATable.DataController.EndUpdate;
    cxGridSTable.DataController.EndUpdate;
  end;
  SelectionChanged;
end;

function TfrmDescriptionTemplateGTEditorDlg.SaveData: Boolean;
var
  Query: TIBCQuery;
  i: integer;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'DELETE FROM TS_DESC_TEMPL_GT WHERE TEMPLATEID=:id';
    Query.ParamByName('id').asInteger := fMasterDataSet.FieldByName('TEMPLATEID').asInteger;
    try
      Query.ExecSQL;
      if (cxGridSTable.DataController.RecordCount > 0) then
      begin
        Query.SQL.Text := 'INSERT INTO TS_DESC_TEMPL_GT (TEMPLATEID, GOODSTYPEID) VALUES (:tid,:gid)';
        Query.ParamByName('tid').asInteger := fMasterDataSet.FieldByName('TEMPLATEID').asInteger;
        for i := 0 to cxGridSTable.DataController.RecordCount - 1 do
        begin
          Query.ParamByName('gid').asInteger := cxGridSTable.DataController.Values[i, cxGridSTable_GOODSTYPEID.Index];
          Query.ExecSQL;
        end;
      end;
      Result := True;
    except
      on E: Exception do
        if Not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.sbAddToAvailableClick(Sender: TObject);
begin
  AddItemsToAvailable;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.sbAddToSelectedClick(Sender: TObject);
begin
  AddItemsToSelected;
end;

procedure TfrmDescriptionTemplateGTEditorDlg.SelectionChanged;
begin
  sbAddToSelected.Enabled := cxGridATable.Controller.SelectedRecordCount > 0;
  sbAddToAvailable.Enabled := cxGridSTable.Controller.SelectedRecordCount > 0;
end;

end.

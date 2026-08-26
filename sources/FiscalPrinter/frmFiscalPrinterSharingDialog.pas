unit frmFiscalPrinterSharingDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxImageComboBox, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Vcl.StdCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.Buttons, Vcl.ExtCtrls,
  DialogTitle, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFiscalPrinterSharingDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxGridSelLevel: TcxGridLevel;
    cxGridSel: TcxGrid;
    cxGridSelTable: TcxGridTableView;
    cxGridAv: TcxGrid;
    cxGridAvTable: TcxGridTableView;
    cxGridAvLevel: TcxGridLevel;
    sbAddToSelected: TSpeedButton;
    sbRemoveFromSelected: TSpeedButton;
    cxGridSelTable_WSID: TcxGridColumn;
    cxGridSelTable_IMG: TcxGridColumn;
    cxGridSelTable_TITLE: TcxGridColumn;
    cxGridSelTable_FIRMA: TcxGridColumn;
    cxGridAvTable_WSID: TcxGridColumn;
    cxGridAvTable_IMG: TcxGridColumn;
    cxGridAvTable_TITLE: TcxGridColumn;
    cxGridAvTable_FIRMA: TcxGridColumn;
    btnOk: TButton;
    btnCancel: TButton;
    procedure cxGridAvTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAvTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure sbAddToSelectedClick(Sender: TObject);
    procedure sbRemoveFromSelectedClick(Sender: TObject);
  private
    { Private declarations }
    fChanged: Boolean;
    procedure SelectionChanged;
    procedure ReadData;
    function SaveData: Boolean;
    procedure AddToSelected;
    procedure RemoveFromSelected;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, IBC, SWNDBErrors;

{ TfrmFiscalPrinterSharingDlg }

procedure TfrmFiscalPrinterSharingDlg.AddToSelected;
var
  i, N1, N2: Integer;
begin
  fChanged := True;
  cxGridSelTable.DataController.BeginUpdate;
  cxGridAvTable.DataController.BeginUpdate;
  try
    for i := 0 to cxGridAvTable.Controller.SelectedRowCount - 1 do
    begin
      N1 := cxGridAvTable.Controller.SelectedRows[i].RecordIndex;
      N2 := cxGridSelTable.DataController.AppendRecord;
      cxGridSelTable.DataController.Values[N2, cxGridSelTable_WSID.Index] := cxGridAvTable.DataController.Values
        [N1, cxGridAvTable_WSID.Index];
      cxGridSelTable.DataController.Values[N2, cxGridSelTable_TITLE.Index] := cxGridAvTable.DataController.Values
        [N1, cxGridAvTable_TITLE.Index];
      cxGridSelTable.DataController.Values[N2, cxGridSelTable_FIRMA.Index] := cxGridAvTable.DataController.Values
        [N1, cxGridAvTable_FIRMA.Index];
    end;
    cxGridAvTable.Controller.DeleteSelection;

  finally
    cxGridSelTable.DataController.EndUpdate;
    cxGridAvTable.DataController.EndUpdate;
  end;
  SelectionChanged;
end;

procedure TfrmFiscalPrinterSharingDlg.cxGridAvTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmFiscalPrinterSharingDlg.cxGridAvTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  SelectionChanged;
end;

function TfrmFiscalPrinterSharingDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  if fChanged then
    Result := SaveData;
end;

procedure TfrmFiscalPrinterSharingDlg.Prepare;
begin
  fChanged := False;
  ReadData;
  SelectionChanged;
end;

procedure TfrmFiscalPrinterSharingDlg.ReadData;
var
  Query: TIBCQuery;
  N: Integer;
begin
  cxGridSelTable.DataController.BeginUpdate;
  cxGridAvTable.DataController.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
        // lista computerilor selectate
    Query.SQL.Add('SELECT DA.WS_ID, WS.COMPUTER_NAME, WS.FIRMA_NAME');
    Query.SQL.Add('FROM FP_DEVICE_ACCESS DA');
    Query.SQL.Add('INNER JOIN VW_WS_WORK_STATIONS WS ON DA.WS_ID = WS.WS_ID');
    Query.SQL.Add('WHERE DA.FP_ID=:ID');
    Query.SQL.Add('ORDER BY WS.COMPUTER_NAME');
    Query.ParamByName('ID').AsInteger := fMasterDataSet.FieldByName('FP_ID').asInteger;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridSelTable.DataController.AppendRecord;
      cxGridSelTable.DataController.Values[N, cxGridSelTable_WSID.Index] := Query.Fields[0].AsInteger;
      cxGridSelTable.DataController.Values[N, cxGridSelTable_TITLE.Index] := Query.Fields[1].AsString;
      cxGridSelTable.DataController.Values[N, cxGridSelTable_FIRMA.Index] := Query.Fields[2].AsString;
      Query.Next;
    end;

    Query.Close;
    Query.SQL.Clear;
        // Lista computerilor disponibile. Nu filtram dupa subdiviziunea MCC: MCC din retea
        // este folosita tocmai de calculatoare din alta parte. Dreptul de tipar ramine
        // controlat de SP_CANPRINTFPDEVICE (firma curenta + numarul de serie al MCC).
    Query.SQL.Add('SELECT WS.WS_ID, WS.COMPUTER_NAME, WS.FIRMA_NAME');
    Query.SQL.Add('FROM VW_WS_WORK_STATIONS WS');
    Query.SQL.Add('WHERE (WS.FLG_ENABLED=1)');
    Query.SQL.Add('  AND NOT EXISTS(SELECT 1 FROM FP_DEVICE_ACCESS WHERE FP_ID=:FP_ID AND WS_ID=WS.WS_ID)');
    Query.SQL.Add('ORDER BY WS.COMPUTER_NAME');
    Query.ParamByName('FP_ID').AsInteger := fMasterDataSet.FieldByName('FP_ID').asInteger;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := cxGridAvTable.DataController.AppendRecord;
      cxGridAvTable.DataController.Values[N, cxGridAvTable_WSID.Index] := Query.Fields[0].AsInteger;
      cxGridAvTable.DataController.Values[N, cxGridAvTable_TITLE.Index] := Query.Fields[1].AsString;
      cxGridAvTable.DataController.Values[N, cxGridAvTable_FIRMA.Index] := Query.Fields[2].AsString;
      Query.Next;
    end;
  finally
    Query.Free;
    cxGridSelTable.DataController.EndUpdate;
    cxGridAvTable.DataController.EndUpdate;
  end;
end;

procedure TfrmFiscalPrinterSharingDlg.RemoveFromSelected;
var
  i, N1, N2: Integer;
begin
  fChanged := True;
  cxGridSelTable.DataController.BeginUpdate;
  cxGridAvTable.DataController.BeginUpdate;
  try
    for i := 0 to cxGridSelTable.Controller.SelectedRowCount - 1 do
    begin
      N1 := cxGridSelTable.Controller.SelectedRows[i].RecordIndex;
      N2 := cxGridAvTable.DataController.AppendRecord;
      cxGridAvTable.DataController.Values[N2, cxGridAvTable_WSID.Index] := cxGridSelTable.DataController.Values
        [N1, cxGridSelTable_WSID.Index];
      cxGridAvTable.DataController.Values[N2, cxGridAvTable_TITLE.Index] := cxGridSelTable.DataController.Values
        [N1, cxGridSelTable_TITLE.Index];
      cxGridAvTable.DataController.Values[N2, cxGridAvTable_FIRMA.Index] := cxGridSelTable.DataController.Values
        [N1, cxGridSelTable_FIRMA.Index];
    end;
    cxGridSelTable.Controller.DeleteSelection;
  finally
    cxGridSelTable.DataController.EndUpdate;
    cxGridAvTable.DataController.EndUpdate;
  end;
  SelectionChanged;
end;

function TfrmFiscalPrinterSharingDlg.SaveData: Boolean;
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
           // stergem datele curent
      Query.SQL.Text := 'DELETE FROM FP_DEVICE_ACCESS WHERE FP_ID=:FP_ID';
      Query.ParamByName('FP_ID').AsInteger := fMasterDataSet.FieldByName('FP_ID').asInteger;
      Query.Execute;

           // adaugam cele selectate
      Query.SQL.Clear;
      Query.SQL.Add('INSERT INTO FP_DEVICE_ACCESS(FP_ID, WS_ID)');
      Query.SQL.Add('VALUES (:FP_ID, :WS_ID)');
      Query.ParamByName('FP_ID').AsInteger := fMasterDataSet.FieldByName('FP_ID').asInteger;
      for i := 0 to cxGridSelTable.DataController.RecordCount - 1 do
      begin
        Query.ParamByName('WS_ID').AsInteger := cxGridSelTable.DataController.Values[i, cxGridSelTable_WSID.Index];
        Query.Execute;
      end;
      Query.Transaction.Commit;
      Result := True;

    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmFiscalPrinterSharingDlg.sbAddToSelectedClick(Sender: TObject);
begin
  AddToSelected;
end;

procedure TfrmFiscalPrinterSharingDlg.sbRemoveFromSelectedClick(Sender: TObject);
begin
  RemoveFromSelected;
end;

procedure TfrmFiscalPrinterSharingDlg.SelectionChanged;
begin
  sbAddToSelected.Enabled := cxGridAvTable.Controller.SelectedRowCount >= 1;
  sbRemoveFromSelected.Enabled := cxGridSelTable.Controller.SelectedRowCount >= 1;
end;

end.


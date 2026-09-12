unit frmSelectPartNumbersDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, SWNPNClasses, IBC, Dialogs, DialogTitle, cxStyles, cxCustomData,

  cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxTextEdit, cxDBEdit, Buttons, StdCtrls,
  ExtCtrls,
  cxCalc,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxFilter, cxData,
  cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, Vcl.Menus, cxMaskEdit,
  cxDropDownEdit, cxClasses, cxGridCustomView, dxUIAClasses, System.Actions, Vcl.ActnList;

type
  TfrmSelectPartsDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edGOODS_NAME: TcxDBTextEdit;
    cxGridAParts: TcxGrid;
    cxGridAPartsTable: TcxGridTableView;
    cxGridAParts_PARTNO: TcxGridColumn;
    cxGridAParts_QTY: TcxGridColumn;
    cxGridAPartsLevel: TcxGridLevel;
    cxGridSParts: TcxGrid;
    cxGridSPartsLevel: TcxGridLevel;
    Label3: TLabel;
    Label4: TLabel;
    edGOODSID: TcxDBTextEdit;
    cxGridSPartsTable: TcxGridTableView;
    cxGridSPartsTable_PARTNO: TcxGridColumn;
    cxGridSPartsTable_QTY: TcxGridColumn;
    sbAddPNs: TSpeedButton;
    sbAddAllPNs: TSpeedButton;
    sbRemovePNs: TSpeedButton;
    sbRemoveAllPNs: TSpeedButton;
    cxGridAPartsTable_IMG: TcxGridColumn;
    cxGridSPartsTable_IMG: TcxGridColumn;
    sbAddCustomPNs: TSpeedButton;
    lbInfo: TLabel;
    cxGridSPartsTable_CREATED_BY: TcxGridColumn;
    sbShowPNs: TSpeedButton;
    edQTY: TcxDBCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure actAddPartnoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridAPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridSPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbAddAllPNsClick(Sender: TObject);
    procedure sbRemovePNsClick(Sender: TObject);
    procedure sbRemoveAllPNsClick(Sender: TObject);
    procedure cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure sbAddCustomPNsClick(Sender: TObject);
    procedure cxGridAPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbShowPNsClick(Sender: TObject);
    procedure cxGridAPartsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure sbAddPNsClick(Sender: TObject);
  private
    { Private declarations }
    FJurnalQTY: double;
    fGoodsWarranty: integer;
    fAvailablePartNoList: TSWNPartNoList;
    fSelectedPartNoList: TSWNPartNoList;
    FReadOnly: Boolean;
    FDocsDataSet: TIBCQuery;
    procedure ReadGoodsWarranty(GoodsID: integer);
    procedure ReadAvailablePartNumbersFromDB;
    procedure ReadSelectedPartNumbersFromDB;
    procedure DisplayAvailablePartNumbers;
    procedure DisplaySelectedPartNumbers;
    procedure SelectionChanged;
    procedure AddAvailablePartNo(const MaxQTY: double);
    procedure AddAllRequestedPartNumbers;
    function GetSelectedRecordIndexByPartNo(const PartNo: string): integer;
    procedure ShowSelectCustomNumberToAddDialog;
    procedure RemoveSelectedPartNo(const MaxQTY: double);
    function GetAvailableRecordIndexByPartNo(const PartNo: string): integer;
    procedure RemoveFullSelectedPartNo;
    procedure FocusTheSameSelectedItem(const SourceGrid, TargetGrid: TcxGridTableView; const SourceColumn, TargetColumn: TcxGridColumn);
    function SavePartNoDB: Boolean;
    procedure WhenGridDataChanged(Sender: TObject);
    procedure ShowInfoForUser;
    procedure CopyFocusedPartNoToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetDocsDataSet(const Value: TIBCQuery);
    procedure SetupQtyFields;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property readonly: Boolean read FReadOnly write SetReadOnly;
    property DocsDataSet: TIBCQuery read FDocsDataSet write SetDocsDataSet;
  end;

implementation

uses
  Math, System.Types, DataModuleAdditions,
  SWNValueStorageUnit, frmInputPartNoCountDialog, SWNConst, ClipBrd, SWNDBErrors;

{$R *.dfm}

procedure TfrmSelectPartsDlg.actAddPartnoExecute(Sender: TObject);
begin

end;

{ TfrmSelectSNDlg }

procedure TfrmSelectPartsDlg.ReadAvailablePartNumbersFromDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.AutoCommit := False;
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Text := 'EXECUTE PROCEDURE GET_PARTS_DEP_GOODS(:GOODSID,:DTDEP,:DT,:DATA)';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := fMasterDataSet.FieldByName('DTDEP').AsInteger;
    Query.ParamByName('DT').AsInteger := FDocsDataSet.FieldByName('DT').AsInteger; // FirmaID;
    Query.ParamByName('DATA').AsDate := FDocsDataSet.FieldByName('DATA').AsDateTime;
    Query.ExecSQL;
    Query.Close;

    Query.SQL.Text := 'SELECT PARTNO, QTY, COUNTRYID, VENDORID FROM TMP_PARTS';
    Query.ExecSQL;
    while not Query.Eof do
    begin
      fAvailablePartNoList.Add(Query.Fields[0].AsString, Query.Fields[1].AsFloat, Query.Fields[2].AsInteger, Query.Fields[3].AsInteger, '');
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartsDlg.cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if sbAddPNs.Enabled then
  begin
    sbAddPNsClick(sbAddPNs);
    AHandled := True;
  end;
end;

procedure TfrmSelectPartsDlg.cxGridAPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSelectPartsDlg.cxGridAPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = []) and sbAddPNs.Enabled then
    sbAddPNsClick(sbAddPNs)
  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and sbAddAllPNs.Enabled then
    sbAddAllPNsClick(sbAddAllPNs)
  else if (Key = VK_F2) then
    ShowSelectCustomNumberToAddDialog
  else if (Key = VK_SPACE) then
    FocusTheSameSelectedItem(cxGridAPartsTable, cxGridSPartsTable, cxGridAParts_PARTNO, cxGridSPartsTable_PARTNO)
  else if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
  begin
    CopyFocusedPartNoToClipboard(cxGridAPartsTable, cxGridAParts_PARTNO.Index);
    Key := 0;
  end;
end;

procedure TfrmSelectPartsDlg.cxGridAPartsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridAParts_QTY.Index] = 0 then
    AStyle := dmAdditions.cxStyle_TextGray;

end;

procedure TfrmSelectPartsDlg.cxGridSPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if sbRemovePNs.Enabled then
  begin
    sbRemovePNsClick(sbRemovePNs);
    AHandled := True;
  end;
end;

procedure TfrmSelectPartsDlg.cxGridSPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSelectPartsDlg.cxGridSPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not FReadOnly then
  begin
    if (Key = VK_DELETE) and (Shift = []) and sbRemovePNs.Enabled then
      sbRemovePNsClick(sbRemovePNs)
    else if (Key = VK_DELETE) and (Shift = [ssCtrl]) and sbRemoveAllPNs.Enabled then
      sbRemoveAllPNsClick(sbRemoveAllPNs)
    else if (Key = VK_SPACE) then
      FocusTheSameSelectedItem(cxGridSPartsTable, cxGridAPartsTable, cxGridSPartsTable_PARTNO, cxGridAParts_PARTNO)
  end;

  if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
  begin
    CopyFocusedPartNoToClipboard(cxGridSPartsTable, cxGridSPartsTable_PARTNO.Index);
    Key := 0;
  end;
end;

procedure TfrmSelectPartsDlg.DisplayAvailablePartNumbers;
var
  i, N: integer;
  PartNoItem: TSWNPartNoItem;
begin
  cxGridAPartsTable.DataController.BeginUpdate;
  try
    for i := 0 to fAvailablePartNoList.Count - 1 do
    begin
      PartNoItem := fAvailablePartNoList[i];
      N := cxGridAPartsTable.DataController.AppendRecord;
      cxGridAPartsTable.DataController.Values[N, cxGridAParts_PARTNO.Index] := PartNoItem.PartNo;
      cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := PartNoItem.QTY;
    end;
  finally
    cxGridAPartsTable.DataController.EndUpdate;
  end;
  if cxGridAPartsTable.DataController.RecordCount > 0 then
    cxGridAPartsTable.ViewData.Records[0].Focused := True;
end;

procedure TfrmSelectPartsDlg.DisplaySelectedPartNumbers;
var
  i, N: integer;
  PartNoItem: TSWNPartNoItem;
begin
  cxGridSPartsTable.DataController.BeginUpdate;
  try
    for i := 0 to fSelectedPartNoList.Count - 1 do
    begin
      PartNoItem := fSelectedPartNoList[i];
      N := cxGridSPartsTable.DataController.AppendRecord;
      cxGridSPartsTable.DataController.Values[N, cxGridAParts_PARTNO.Index] := PartNoItem.PartNo;
      cxGridSPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := PartNoItem.QTY;
      cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_CREATED_BY.Index] := PartNoItem.UserName;
    end;
  finally
    cxGridSPartsTable.DataController.EndUpdate;
  end;
  if cxGridSPartsTable.DataController.RecordCount > 0 then
    cxGridSPartsTable.ViewData.Records[0].Focused := True;
end;

procedure TfrmSelectPartsDlg.AddAllRequestedPartNumbers;
var
  N: integer;
  QTY, SelQTY: double;
begin
  N := cxGridAPartsTable.DataController.FocusedRecordIndex;
  if N >= 0 then
  begin
    QTY := cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index];

    if VarIsNumeric(cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0]) then
      SelQTY := cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0] // QTY
    else
      SelQTY := 0;

    QTY := Min(FJurnalQTY - SelQTY, QTY);
    if QTY > 0 then
      AddAvailablePartNo(QTY);
  end;
end;

procedure TfrmSelectPartsDlg.AddAvailablePartNo(const MaxQTY: double);
var
  N: integer;
  PartNo: string;
  QTY: double;
  SourcePartNoItem, TargetPartNoItem: TSWNPartNoItem;
begin
  cxGridAPartsTable.DataController.BeginUpdate;
  cxGridSPartsTable.DataController.BeginUpdate;
  try
    N := cxGridAPartsTable.DataController.FocusedRecordIndex;
    if N >= 0 then
    begin
      PartNo := cxGridAPartsTable.DataController.Values[N, cxGridAParts_PARTNO.Index];
      QTY := cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index];
      SourcePartNoItem := fAvailablePartNoList.Find(PartNo, null);
      if (MaxQTY <= QTY) and Assigned(SourcePartNoItem) then
      begin
        // decrease QTY
        QTY := QTY - MaxQTY;
        SourcePartNoItem.QTY := QTY;
        // update source QTY
        cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := QTY;

        TargetPartNoItem := fSelectedPartNoList.Find(PartNo, null);
        if Assigned(TargetPartNoItem) then
        begin
          TargetPartNoItem.QTY := TargetPartNoItem.QTY + MaxQTY;
          if (SourcePartNoItem.Status = pnstInUseDeleted) then
          begin
            if TargetPartNoItem.QTY_initial = TargetPartNoItem.QTY then
              TargetPartNoItem.Status := pnstInUse
            else
              TargetPartNoItem.Status := pnstInUseUpdate;
          end
          else if (TargetPartNoItem.Status in [pnstInUse, pnstInUseDeleted]) then
            TargetPartNoItem.Status := pnstInUseUpdate;

          N := GetSelectedRecordIndexByPartNo(PartNo);
          if N = -1 then
          begin
            // create new record
            N := cxGridSPartsTable.DataController.AppendRecord;
            cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_PARTNO.Index] := PartNo;
          end;
          cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_QTY.Index] := TargetPartNoItem.QTY;
          cxGridSPartsTable.DataController.FocusedRecordIndex := N;
        end
        else
        begin
          // create new PartNo
          TargetPartNoItem := fSelectedPartNoList.Add(PartNo, MaxQTY, SourcePartNoItem.CountryID, SourcePartNoItem.VendorID, SourcePartNoItem.UserName);
          TargetPartNoItem.Status := pnstNew;
          // create new record
          N := cxGridSPartsTable.DataController.AppendRecord;
          cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_PARTNO.Index] := PartNo;
          cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_QTY.Index] := MaxQTY;
          cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_CREATED_BY.Index] := TargetPartNoItem.UserName;
        end;
      end;
    end;
  finally
    cxGridAPartsTable.DataController.EndUpdate;
    cxGridSPartsTable.DataController.EndUpdate;
  end;
  SelectionChanged;
end;

procedure TfrmSelectPartsDlg.btnOkClick(Sender: TObject);
begin
  if SavePartNoDB then
  begin
    try
      if fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.Commit;

      ModalResult := mrOk;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmSelectPartsDlg.CopyFocusedPartNoToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
begin
  if Grid.Controller.FocusedRecordIndex >= 0 then
    Clipboard.AsText := Grid.DataController.Values[Grid.Controller.FocusedRecordIndex, ColumnIndex];
end;

procedure TfrmSelectPartsDlg.FocusTheSameSelectedItem(const SourceGrid, TargetGrid: TcxGridTableView; const SourceColumn, TargetColumn: TcxGridColumn);
var
  i, N: integer;
  PartNo: string;
begin
  N := SourceGrid.DataController.GetFocusedRecordIndex;
  if (N >= 0) and (N < SourceGrid.DataController.RecordCount) then
  begin
    PartNo := SourceGrid.DataController.Values[N, SourceColumn.Index];
    for i := 0 to TargetGrid.DataController.RecordCount - 1 do
    begin
      if TargetGrid.DataController.Values[i, TargetColumn.Index] = PartNo then
      begin
        TargetGrid.DataController.BeginUpdate;
        try
          TargetGrid.DataController.MakeRecordVisible(i);
          TargetGrid.DataController.FocusedRecordIndex := i;
        finally
          TargetGrid.DataController.EndUpdate;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TfrmSelectPartsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmSelectPartsDlg.FormCreate(Sender: TObject);
begin
  fAvailablePartNoList := TSWNPartNoList.Create;
  fSelectedPartNoList := TSWNPartNoList.Create;
end;

procedure TfrmSelectPartsDlg.FormDestroy(Sender: TObject);
begin
  fAvailablePartNoList.Free;
  fSelectedPartNoList.Free;
end;

function TfrmSelectPartsDlg.GetAvailableRecordIndexByPartNo(const PartNo: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to cxGridAPartsTable.DataController.RecordCount - 1 do
    if cxGridAPartsTable.DataController.Values[i, cxGridAParts_PARTNO.Index] = PartNo then
    begin
      Result := i;
      Break;
    end;
end;

function TfrmSelectPartsDlg.GetSelectedRecordIndexByPartNo(const PartNo: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to cxGridSPartsTable.DataController.RecordCount - 1 do
    if cxGridSPartsTable.DataController.Values[i, cxGridSPartsTable_PARTNO.Index] = PartNo then
    begin
      Result := i;
      Break;
    end;
end;

procedure TfrmSelectPartsDlg.BindingDataSource;
begin
  inherited;
  fGoodsWarranty := 0;
  FReadOnly := False;
  FDocsDataSet := nil;

  edGOODSID.DataBinding.DataSource := fMasterDataSource;
  edGOODS_NAME.DataBinding.DataSource := fMasterDataSource;
  edQTY.DataBinding.DataSource := fMasterDataSource;

  FJurnalQTY := fMasterDataSet.FieldByName('QTY').AsFloat;
end;

procedure TfrmSelectPartsDlg.LoadStates;
begin
  if AppUserConfigStorage.FormPositions.ReadFormPos(self) then
    self.Position := poDesigned;
end;

procedure TfrmSelectPartsDlg.Prepare;
begin
  SetupQtyFields;

  sbShowPNs.Visible := FReadOnly;

  if FReadOnly then
  begin
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    Caption := 'Numere de partide';
    dtDialogTitle.Title := Caption;
    dtDialogTitle.Text := 'Vizualizarea numerilor de partida';

    cxGridAParts.Enabled := False;

    btnOk.Visible := False;
    btnCancel.Default := True;
    btnCancel.Caption := cMSG_ButtonClose;
  end;

  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if not FReadOnly then
      ReadGoodsWarranty(fMasterDataSet.FieldByName('GOODSID').AsInteger);
    if not FReadOnly then
    begin
      ReadAvailablePartNumbersFromDB;
      DisplayAvailablePartNumbers;
    end;
    ReadSelectedPartNumbersFromDB;
    DisplaySelectedPartNumbers;

    if not FReadOnly then
      cxGridSPartsTable.DataController.OnDataChanged := WhenGridDataChanged;
    SelectionChanged;
    ShowInfoForUser;

  except
    if not FReadOnly then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmSelectPartsDlg.ReadGoodsWarranty(GoodsID: integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.Connection := fIBCConnection;
    Query.SQL.Text := 'SELECT WARRANTY FROM TS_GOODS WHERE GOODSID=:GOODSID';
    Query.ParamByName('GOODSID').AsInteger := GoodsID;
    Query.ExecSQL;
    if not Query.Eof then
      fGoodsWarranty := Query.Fields[0].AsInteger;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartsDlg.ReadSelectedPartNumbersFromDB;
var
  Query: TIBCQuery;
  PartNoItem: TSWNPartNoItem;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.AutoCommit := False;
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Add('SELECT PARTNO,QTY,COUNTRYID,VENDORID,(SELECT FULL_NAME FROM TS_USERS WHERE USERID=CREATED_BY) FROM TDB_PARTS');
    Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
    Query.ParamByName('DOCID').Value := fMasterDataSet.FieldByName('DOCID').Value;
    Query.ParamByName('DTDEP').Value := fMasterDataSet.FieldByName('DTDEP').Value;
    Query.ParamByName('CTDEP').Value := fMasterDataSet.FieldByName('CTDEP').Value;
    Query.ParamByName('GOODSCOMPLECT_ID').Value := fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
    Query.ParamByName('GOODSID').Value := fMasterDataSet.FieldByName('GOODSID').Value;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      PartNoItem := fSelectedPartNoList.Add(Query.Fields[0].AsString, Query.Fields[1].AsFloat, Query.Fields[2].AsInteger, Query.Fields[3].AsInteger, Query.Fields[4].AsString);
      PartNoItem.Status := pnstInUse;
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartsDlg.RemoveFullSelectedPartNo;
var
  N: integer;
  QTY: double;
begin
  N := cxGridSPartsTable.DataController.FocusedRecordIndex;
  if N >= 0 then
  begin
    QTY := cxGridSPartsTable.DataController.Values[N, cxGridAParts_QTY.Index];
    RemoveSelectedPartNo(QTY);
  end;
end;

procedure TfrmSelectPartsDlg.RemoveSelectedPartNo(const MaxQTY: double);
var
  N: integer;
  QTY: double;
  PartNo: string;
  SourcePartNoItem, TargetPartNoItem: TSWNPartNoItem;
begin
  cxGridAPartsTable.DataController.BeginUpdate;
  cxGridSPartsTable.DataController.BeginUpdate;
  try
    N := cxGridSPartsTable.DataController.FocusedRecordIndex;
    if N >= 0 then
    begin
      PartNo := cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_PARTNO.Index];
      QTY := cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_QTY.Index];
      SourcePartNoItem := fSelectedPartNoList.Find(PartNo, null);
      if (MaxQTY <= QTY) and Assigned(SourcePartNoItem) then
      begin
        // decrease QTY
        QTY := QTY - MaxQTY;
        SourcePartNoItem.QTY := QTY;
        if QTY = 0 then
        begin
          // remove grid record
          cxGridSPartsTable.DataController.DeleteRecord(N);
          if SourcePartNoItem.Status = pnstNew then
            SourcePartNoItem.Status := pnstDeleted
          else if SourcePartNoItem.Status in [pnstInUse, pnstInUseUpdate] then
            SourcePartNoItem.Status := pnstInUseDeleted;
        end
        else
        begin
          if SourcePartNoItem.Status = pnstInUse then
            SourcePartNoItem.Status := pnstInUseUpdate;
          // update source QTY
          cxGridSPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := QTY;
        end;

        TargetPartNoItem := fAvailablePartNoList.Find(PartNo, null);
        if Assigned(TargetPartNoItem) then
        begin
          TargetPartNoItem.QTY := TargetPartNoItem.QTY + MaxQTY;

          N := GetAvailableRecordIndexByPartNo(PartNo);
          cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := TargetPartNoItem.QTY;
        end
        else
        begin
          // create new PartNo item
          TargetPartNoItem := fAvailablePartNoList.Add(PartNo, MaxQTY, SourcePartNoItem.CountryID, SourcePartNoItem.VendorID, SourcePartNoItem.UserName);
          TargetPartNoItem.Status := pnstInUseDeleted;

          // create new grid record
          N := cxGridAPartsTable.DataController.AppendRecord;
          cxGridAPartsTable.DataController.Values[N, cxGridAParts_PARTNO.Index] := PartNo;
          cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := MaxQTY;
        end;
        cxGridAPartsTable.DataController.FocusedRecordIndex := N;
      end;
    end;
  finally
    cxGridAPartsTable.DataController.EndUpdate;
    cxGridSPartsTable.DataController.EndUpdate;
  end;
  SelectionChanged;
end;

function TfrmSelectPartsDlg.SavePartNoDB: Boolean;
var
  Query: TIBCQuery;
  PartNoItem: TSWNPartNoItem;
  i: integer;
begin
  Result := False;

  Query := TIBCQuery.Create(self);
  try
    Query.AutoCommit := False;
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    try
      // 1. Delete
      if fSelectedPartNoList.HasItemsOfStatus(pnstInUseDeleted) then
      begin
        Query.SQL.Clear;
        Query.SQL.Add('DELETE FROM TDB_PARTS');
        Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
        Query.SQL.Add('and PARTNO=:PARTNO');
        Query.ParamByName('DOCID').Value := fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value := fMasterDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value := fMasterDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').Value := fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
        Query.ParamByName('GOODSID').Value := fMasterDataSet.FieldByName('GOODSID').Value;

        for i := 0 to fSelectedPartNoList.Count - 1 do
        begin
          PartNoItem := fSelectedPartNoList[i];
          if PartNoItem.Status = pnstInUseDeleted then
          begin
            Query.ParamByName('PARTNO').AsString := PartNoItem.PartNo;
            Query.ExecSQL;
          end;
        end;
      end;

      // 2. Update
      if fSelectedPartNoList.HasItemsOfStatus(pnstInUseUpdate) then
      begin
        Query.SQL.Clear;
        Query.SQL.Add('UPDATE TDB_PARTS SET QTY=:QTY');
        Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
        Query.SQL.Add('and PARTNO=:PARTNO');
        Query.ParamByName('DOCID').Value := fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value := fMasterDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value := fMasterDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').Value := fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
        Query.ParamByName('GOODSID').Value := fMasterDataSet.FieldByName('GOODSID').Value;

        for i := 0 to fSelectedPartNoList.Count - 1 do
        begin
          PartNoItem := fSelectedPartNoList[i];
          if (PartNoItem.Status = pnstInUseUpdate) and (PartNoItem.QTY <> PartNoItem.QTY_initial) then
          begin
            Query.ParamByName('PARTNO').AsString := PartNoItem.PartNo;
            Query.ParamByName('QTY').AsFloat := PartNoItem.QTY;
            Query.ExecSQL;
          end;
        end;
      end;

      // 2. Insert
      if fSelectedPartNoList.HasItemsOfStatus(pnstNew) then
      begin
        Query.SQL.Clear;
        Query.SQL.Add('INSERT INTO TDB_PARTS (DOCID,DTDEP,CTDEP,GOODSCOMPLECT_ID,GOODSID,PARTNO,COMPLECT_SN,VENDORWARRANTY,OWNWARRANTY,QTY,CREATED_BY,SUMA_ACCIZE,COUNTRYID,VENDORID)');
        Query.SQL.Add('VALUES (:DOCID,:DTDEP,:CTDEP,:GOODSCOMPLECT_ID,:GOODSID,:PARTNO,:COMPLECT_SN,:VENDORWARRANTY,:OWNWARRANTY,:QTY,:CREATED_BY,0,:COUNTRYID,:VENDORID)');
        Query.ParamByName('DOCID').Value := fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value := fMasterDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value := fMasterDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').Value := fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
        Query.ParamByName('GOODSID').Value := fMasterDataSet.FieldByName('GOODSID').Value;

        Query.ParamByName('VENDORWARRANTY').AsInteger := fMasterDataSet.FieldByName('WARRANTY').AsInteger;
        Query.ParamByName('OWNWARRANTY').Value := fGoodsWarranty;
        Query.ParamByName('COMPLECT_SN').AsString := 'none';

        Query.ParamByName('CREATED_BY').AsInteger := UserID;

        for i := 0 to fSelectedPartNoList.Count - 1 do
        begin
          PartNoItem := fSelectedPartNoList[i];
          if PartNoItem.Status = pnstNew then
          begin
            Query.ParamByName('PARTNO').AsString := PartNoItem.PartNo;
            Query.ParamByName('QTY').AsFloat := PartNoItem.QTY;
            Query.ParamByName('COUNTRYID').AsInteger := PartNoItem.CountryID;
            Query.ParamByName('VENDORID').AsInteger := PartNoItem.VendorID;
            Query.ExecSQL;
          end;
        end;
      end;

      Result := True;

    except
      on E: Exception do
      begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartsDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(self);
end;

procedure TfrmSelectPartsDlg.sbAddAllPNsClick(Sender: TObject);
begin
  AddAllRequestedPartNumbers;
end;

procedure TfrmSelectPartsDlg.sbAddCustomPNsClick(Sender: TObject);
begin
  ShowSelectCustomNumberToAddDialog;
end;

procedure TfrmSelectPartsDlg.sbAddPNsClick(Sender: TObject);
begin
  AddAvailablePartNo(1);
end;

procedure TfrmSelectPartsDlg.sbRemoveAllPNsClick(Sender: TObject);
begin
  RemoveFullSelectedPartNo;
end;

procedure TfrmSelectPartsDlg.sbRemovePNsClick(Sender: TObject);
begin
  RemoveSelectedPartNo(1);
end;

procedure TfrmSelectPartsDlg.sbShowPNsClick(Sender: TObject);
begin
  ReadAvailablePartNumbersFromDB;
  DisplayAvailablePartNumbers;
  sbShowPNs.Visible := False;
end;

procedure TfrmSelectPartsDlg.SelectionChanged;
var
  N: integer;
  fCanAdd: Boolean;
  fCanRemove: Boolean;
begin
  fCanAdd := False;
  fCanRemove := False;

  if not FReadOnly then
  begin
    N := cxGridAPartsTable.DataController.GetFocusedRecordIndex;
    if (N >= 0) and (N < cxGridAPartsTable.DataController.RecordCount) then
    begin
      fCanAdd := cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] > 0;
    end;

    N := cxGridSPartsTable.DataController.GetFocusedRecordIndex;
    if (N >= 0) and (N < cxGridSPartsTable.DataController.RecordCount) then
    begin
      fCanRemove := cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_QTY.Index] > 0;
    end;
  end;

  sbAddPNs.Enabled := fCanAdd;
  sbAddAllPNs.Enabled := fCanAdd;
  sbAddCustomPNs.Enabled := fCanAdd;

  sbRemovePNs.Enabled := fCanRemove;
  sbRemoveAllPNs.Enabled := fCanRemove;
end;

procedure TfrmSelectPartsDlg.SetDocsDataSet(const Value: TIBCQuery);
begin
  FDocsDataSet := Value;
end;

procedure TfrmSelectPartsDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmSelectPartsDlg.SetupQtyFields;
var
  qtyDigitsMode: integer;
begin
  // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
  // Cantitate
  TcxCalcEditProperties(edQTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Numere de partida disponibile: Cantitate
  TcxCalcEditProperties(cxGridAParts_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Numere de partida disponibile (Footer): Cantitate
  cxGridAParts_QTY.Summary.FooterFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Numere de partida selectate: Cantitate
  TcxCalcEditProperties(cxGridSPartsTable_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Numere de partida selectate (Footer): Cantitate
  cxGridSPartsTable_QTY.Summary.FooterFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmSelectPartsDlg.ShowInfoForUser;
var
  SelQTY: double;
  qtyDigitsMode: integer;
begin
  // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);

  if VarIsNumeric(cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0]) then
    SelQTY := cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0] // QTY
  else
    SelQTY := 0;

  case CompareValue(Round(SelQTY * cQTY_DigitsRoundMask[qtyDigitsMode]) / cQTY_DigitsRoundMask[qtyDigitsMode], Round(FJurnalQTY * cQTY_DigitsRoundMask[qtyDigitsMode]) / cQTY_DigitsRoundMask[qtyDigitsMode], 0) of
    LessThanValue:
      begin
        lbInfo.Caption := cMSG_PARTNO_CountIsLess;
        lbInfo.Color := cCOLOR_PARTNO_CountIsLess;
      end;
    EqualsValue:
      begin
        lbInfo.Caption := cMSG_PARTNO_CountIsOk;
        lbInfo.Color := cCOLOR_PARTNO_CountIsOk;
      end;
    GreaterThanValue:
      begin
        lbInfo.Caption := cMSG_PARTNO_CountIsBigger;
        lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
      end;
  end;
end;

procedure TfrmSelectPartsDlg.ShowSelectCustomNumberToAddDialog;
var
  N: integer;
  QTY, SelQTY: double;
  dialog: TfrmInputPartNoCountDlg;
begin
  N := cxGridAPartsTable.DataController.FocusedRecordIndex;
  if N >= 0 then
  begin
    QTY := cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index];

    if VarIsNumeric(cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0]) then
      SelQTY := cxGridSPartsTable.DataController.Summary.FooterSummaryValues[0] // QTY
    else
      SelQTY := 0;

    QTY := Min(FJurnalQTY - SelQTY, QTY);
    if QTY > 0 then
    begin
      dialog := TfrmInputPartNoCountDlg.Create(self);
      try
        dialog.MaxValue := QTY;
        if dialog.ShowModal = mrOk then
          AddAvailablePartNo(dialog.QTY);
      finally
        dialog.Free;
      end;
    end;
  end;
end;

procedure TfrmSelectPartsDlg.WhenGridDataChanged(Sender: TObject);
begin
  ShowInfoForUser;
end;

end.


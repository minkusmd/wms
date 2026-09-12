unit frmSelectPartNumbersParentedDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, SWNPNClasses, Dialogs, DialogTitle, Menus, cxStyles, cxCustomData,
  DB, DBAccess,
  IBC, cxTextEdit, cxDBEdit, StdCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, ExtCtrls, Buttons,
  cxDropDownEdit,
  cxCalc,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxFilter, cxData,
  cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxLabel, cxMaskEdit, cxClasses,
  cxGridCustomView;

type
  TfrmSelectPartNoParentedDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edGOODS_NAME: TcxDBTextEdit;
    edQTY: TcxDBTextEdit;
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
    Label1: TLabel;
    Label2: TLabel;
    edMasterGOODS_NAME: TcxDBTextEdit;
    edMasterGOODSID: TcxDBTextEdit;
    cmbKitSN: TcxComboBox;
    cxGridSPartsTable_CREATED_BY: TcxGridColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridAPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridSPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbAddPNsClick(Sender: TObject);
    procedure sbAddAllPNsClick(Sender: TObject);
    procedure sbRemovePNsClick(Sender: TObject);
    procedure sbRemoveAllPNsClick(Sender: TObject);
    procedure cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure sbAddCustomPNsClick(Sender: TObject);
    procedure cxGridAPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbKitSNPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridAPartsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FJurnalQTY: double;
    fGoodsWarranty: integer;
    fAvailablePartNoList: TSWNPartNoList;
    fSelectedPartNoList: TSWNPartNoList;
    fChildDataSet: TCustomIBCDataSet;
    fChildDataSource: TIBCDataSource;
    fCurrentKitSN: string;
    FReadOnly: Boolean;
    procedure ReadKitSerials;
    procedure ReadGoodsWarranty(GoodsID: integer);
    procedure ReadAvailablePartNumbersFromDB;
    procedure ReadSelectedPartNumbersFromDB;
    procedure DisplayAvailablePartNumbers;
    procedure DisplaySelectedPartNumbers(const KitSN: string);
    procedure SelectionChanged;
    procedure AddAvailablePartNo(const MaxQTY: double);
    procedure AddAllRequestedPartNumbers;
    function GetSelectedRecordIndexByPartNo(const PartNo: string): integer;
    procedure ShowSelectCustomNumberToAddDialog;
    procedure RemoveSelectedPartNo(const MaxQTY: double);
    function GetAvailableRecordIndexByPartNo(const PartNo: string): integer;
    procedure RemoveFullSelectedPartNo;
    procedure FocusTheSameSelectedItem(const SourceGrid, TargetGrid: TcxGridTableView; const SourceColumn, TargetColumn: TcxGridColumn);
    procedure SavePartNoDB;
    procedure WhenGridDataChanged(Sender: TObject);
    function GetTotalSelectedPartNumbersCount(const KitSN: string): double;
    procedure ShowInfoForUser;
    procedure CopyFocusedPartNoToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetupQtyFields;
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const MasterDataSet, ChildDataSet: TCustomIBCDataSet; const MasterDataSource, ChildDataSource: TIBCDataSource); reintroduce;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  Math, System.Types, swnUtils, DataModuleAdditions,
  SWNValueStorageUnit, frmInputPartNoCountDialog, SWNConst, ClipBrd, SWNDBErrors;

{$R *.dfm}
{ TfrmSelectSNDlg }

procedure TfrmSelectPartNoParentedDlg.ReadAvailablePartNumbersFromDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Text := 'EXECUTE PROCEDURE GET_PARTS_DEP_GOODS(:GOODSID,:DTDEP,:DT,(SELECT DATA FROM TDB_DOCS WHERE DOCID=:DOCID))';
    Query.ParamByName('GOODSID').AsInteger := fChildDataSet.FieldByName('GOODSID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := fChildDataSet.FieldByName('DTDEP').AsInteger;
    Query.ParamByName('DT').AsInteger := FirmaID;
    Query.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
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

procedure TfrmSelectPartNoParentedDlg.cxGridAPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if sbAddPNs.Enabled then
  begin
    sbAddPNsClick(sbAddPNs);
    AHandled := True;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.cxGridAPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSelectPartNoParentedDlg.cxGridAPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmSelectPartNoParentedDlg.cxGridAPartsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridAParts_QTY.Index] = 0 then
    AStyle := dmAdditions.cxStyle_TextGray;

end;

procedure TfrmSelectPartNoParentedDlg.cxGridSPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if sbRemovePNs.Enabled then
  begin
    sbRemovePNsClick(sbRemovePNs);
    AHandled := True;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.cxGridSPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSelectPartNoParentedDlg.cxGridSPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Shift = []) and sbRemovePNs.Enabled then
    sbRemovePNsClick(sbRemovePNs)
  else if (Key = VK_DELETE) and (Shift = [ssCtrl]) and sbRemoveAllPNs.Enabled then
    sbRemoveAllPNsClick(sbRemoveAllPNs)
  else if (Key = VK_SPACE) and (not FReadOnly) then
    FocusTheSameSelectedItem(cxGridSPartsTable, cxGridAPartsTable, cxGridSPartsTable_PARTNO, cxGridAParts_PARTNO)
  else if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
  begin
    CopyFocusedPartNoToClipboard(cxGridSPartsTable, cxGridSPartsTable_PARTNO.Index);
    Key := 0;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.DisplayAvailablePartNumbers;
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

procedure TfrmSelectPartNoParentedDlg.DisplaySelectedPartNumbers(const KitSN: string);
var
  i, N: integer;
  PartNoItem: TSWNPartNoItem;
begin
  fCurrentKitSN := KitSN;
  cxGridSPartsTable.DataController.BeginUpdate;
  try
    for i := cxGridSPartsTable.DataController.RecordCount - 1 downto 0 do
      cxGridSPartsTable.DataController.DeleteRecord(i);

    for i := 0 to fSelectedPartNoList.Count - 1 do
    begin
      PartNoItem := fSelectedPartNoList[i];
      if (PartNoItem.Complect_SN = KitSN) and (PartNoItem.QTY > 0) then
      begin
        N := cxGridSPartsTable.DataController.AppendRecord;
        cxGridSPartsTable.DataController.Values[N, cxGridAParts_PARTNO.Index] := PartNoItem.PartNo;
        cxGridSPartsTable.DataController.Values[N, cxGridAParts_QTY.Index] := PartNoItem.QTY;
        cxGridSPartsTable.DataController.Values[N, cxGridSPartsTable_CREATED_BY.Index] := PartNoItem.UserName;
      end;
    end;
  finally
    cxGridSPartsTable.DataController.EndUpdate;
  end;
  if cxGridSPartsTable.DataController.RecordCount > 0 then
    cxGridSPartsTable.ViewData.Records[0].Focused := True;
end;

procedure TfrmSelectPartNoParentedDlg.AddAllRequestedPartNumbers;
var
  N: integer;
  QTY, SelQTY: double;
begin
  N := cxGridAPartsTable.DataController.FocusedRecordIndex;
  if N >= 0 then
  begin
    QTY := cxGridAPartsTable.DataController.Values[N, cxGridAParts_QTY.Index];
    SelQTY := GetTotalSelectedPartNumbersCount(cmbKitSN.Text);

    QTY := Min(FJurnalQTY - SelQTY, QTY);
    if QTY > 0 then
      AddAvailablePartNo(QTY);
  end;
end;

procedure TfrmSelectPartNoParentedDlg.AddAvailablePartNo(const MaxQTY: double);
var
  N: integer;
  QTY: double;
  PartNo: string;
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

        TargetPartNoItem := fSelectedPartNoList.Find(PartNo, fCurrentKitSN);
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

          TargetPartNoItem.Complect_SN := fCurrentKitSN;

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
          TargetPartNoItem := fSelectedPartNoList.Add(PartNo, fCurrentKitSN, MaxQTY, SourcePartNoItem.CountryID, SourcePartNoItem.VendorID, SourcePartNoItem.UserName);
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

procedure TfrmSelectPartNoParentedDlg.btnOkClick(Sender: TObject);
begin
  if GetTotalSelectedPartNumbersCount(cmbKitSN.Text) > FJurnalQTY then
  begin
    if ShowAskDialog('Eroare', 'Cantitatea numerilor de partide selectate este mai mare decit necesarul! Doriti sa salvati ?', 'Verificati inca o data!') <> mrYes then
      Exit;
  end;

  try
    SavePartNoDB;
    fMasterDataSet.UpdateTransaction.Commit;
    ModalResult := mrOk;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.cmbKitSNPropertiesEditValueChanged(Sender: TObject);
begin
  DisplaySelectedPartNumbers(cmbKitSN.Text);
end;

procedure TfrmSelectPartNoParentedDlg.CopyFocusedPartNoToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
begin
  if Grid.Controller.FocusedRecordIndex >= 0 then
    Clipboard.AsText := Grid.DataController.Values[Grid.Controller.FocusedRecordIndex, ColumnIndex];
end;

constructor TfrmSelectPartNoParentedDlg.Create(const AOwner: TComponent; const MasterDataSet, ChildDataSet: TCustomIBCDataSet; const MasterDataSource, ChildDataSource: TIBCDataSource);
begin
  fChildDataSet := ChildDataSet;
  fChildDataSource := ChildDataSource;
  inherited Create(AOwner, MasterDataSet, MasterDataSource);
end;

procedure TfrmSelectPartNoParentedDlg.FocusTheSameSelectedItem(const SourceGrid, TargetGrid: TcxGridTableView; const SourceColumn, TargetColumn: TcxGridColumn);
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

procedure TfrmSelectPartNoParentedDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.FormCreate(Sender: TObject);
begin
  fAvailablePartNoList := TSWNPartNoList.Create;
  fSelectedPartNoList := TSWNPartNoList.Create;
end;

procedure TfrmSelectPartNoParentedDlg.FormDestroy(Sender: TObject);
begin
  fAvailablePartNoList.Free;
  fSelectedPartNoList.Free;
end;

function TfrmSelectPartNoParentedDlg.GetAvailableRecordIndexByPartNo(const PartNo: string): integer;
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

function TfrmSelectPartNoParentedDlg.GetSelectedRecordIndexByPartNo(const PartNo: string): integer;
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

function TfrmSelectPartNoParentedDlg.GetTotalSelectedPartNumbersCount(const KitSN: string): double;
var
  i: integer;
  PartNoItem: TSWNPartNoItem;
begin
  Result := 0;
  for i := 0 to fSelectedPartNoList.Count - 1 do
  begin
    PartNoItem := fSelectedPartNoList[i];
    if (PartNoItem.Complect_SN = KitSN) and (PartNoItem.QTY > 0) then
      Result := Result + PartNoItem.QTY;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.BindingDataSource;
begin
  inherited;

  FReadOnly := False;
  fGoodsWarranty := 0;
  fCurrentKitSN := '';

  edMasterGOODSID.DataBinding.DataSource := fMasterDataSource;
  edMasterGOODS_NAME.DataBinding.DataSource := fMasterDataSource;

  edGOODSID.DataBinding.DataSource := fChildDataSource;
  edGOODS_NAME.DataBinding.DataSource := fChildDataSource;
  edQTY.DataBinding.DataSource := fChildDataSource;

  FJurnalQTY := fChildDataSet.FieldByName('QTY').AsFloat;
end;

procedure TfrmSelectPartNoParentedDlg.LoadStates;
begin
  if AppUserConfigStorage.FormPositions.ReadFormPos(self) then
    self.Position := poDesigned;
end;

procedure TfrmSelectPartNoParentedDlg.Prepare;
begin
  SetupQtyFields;

  if not FReadOnly then
    fChildDataSet.UpdateTransaction.StartTransaction;
  try
    ReadGoodsWarranty(fChildDataSet.FieldByName('GOODSID').AsInteger);
    if not FReadOnly then
      ReadAvailablePartNumbersFromDB;
    ReadSelectedPartNumbersFromDB;
    ReadKitSerials;

    if FReadOnly then
      cmbKitSN.Enabled := False;
    if cmbKitSN.Properties.Items.Count = 0 then
    begin
      cxGridAParts.Enabled := False;
      cxGridSParts.Enabled := False;
      cmbKitSN.Enabled := False;
      cmbKitSN.Properties.DropDownListStyle := lsEditList;
      cmbKitSN.Text := 'Nu este numar de serie!';
      btnOk.Visible := False;
      btnCancel.Caption := 'Inchide';
      btnCancel.Default := True;
    end;

    if FReadOnly then
    begin
      cxGridAParts.Enabled := False;
      btnOk.Visible := False;
      btnCancel.Caption := 'Inchide';
      btnCancel.Default := True;
      dtDialogTitle.Color := cCOLOR_DocReadOnly;
      dtDialogTitle.Text := cMSG_DIALOG_VIEWONLY_Parts;
    end
    else
    begin
      DisplayAvailablePartNumbers;
    end;

    cxGridSPartsTable.DataController.OnDataChanged := WhenGridDataChanged;
    SelectionChanged;
    ShowInfoForUser;
  except
    if not FReadOnly then
      fChildDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.ReadGoodsWarranty(GoodsID: integer);
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

procedure TfrmSelectPartNoParentedDlg.ReadKitSerials;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  cmbKitSN.Properties.Items.BeginUpdate;
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fChildDataSet.UpdateTransaction;
    Query.SQL.Add('SELECT SN FROM TDB_SN');
    Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
    Query.ParamByName('DOCID').Value := fMasterDataSet.FieldByName('DOCID').Value;
    Query.ParamByName('DTDEP').Value := fMasterDataSet.FieldByName('DTDEP').Value;
    Query.ParamByName('CTDEP').Value := fMasterDataSet.FieldByName('CTDEP').Value;
    Query.ParamByName('GOODSCOMPLECT_ID').AsInteger := -1;
    Query.ParamByName('GOODSID').Value := fMasterDataSet.FieldByName('GOODSID').Value;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      cmbKitSN.Properties.Items.Add(Query.Fields[0].AsString);
      Query.Next;
    end;
    Query.Close;
  finally
    cmbKitSN.Properties.Items.EndUpdate;
    Query.Free;
  end;
  if cmbKitSN.Properties.Items.Count > 0 then
    cmbKitSN.ItemIndex := 0;
end;

procedure TfrmSelectPartNoParentedDlg.ReadSelectedPartNumbersFromDB;
var
  Query: TIBCQuery;
  PartNoItem: TSWNPartNoItem;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Add('SELECT PARTNO,COMPLECT_SN,QTY,COUNTRYID,VENDORID,(SELECT FULL_NAME FROM TS_USERS WHERE USERID=CREATED_BY) FROM TDB_PARTS');
    Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
    Query.ParamByName('DOCID').Value := fChildDataSet.FieldByName('DOCID').Value;
    Query.ParamByName('DTDEP').Value := fChildDataSet.FieldByName('DTDEP').Value;
    Query.ParamByName('CTDEP').Value := fChildDataSet.FieldByName('CTDEP').Value;
    Query.ParamByName('GOODSCOMPLECT_ID').Value := fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
    Query.ParamByName('GOODSID').Value := fChildDataSet.FieldByName('GOODSID').Value;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      PartNoItem := fSelectedPartNoList.Add(Query.Fields[0].AsString, Query.Fields[1].AsString, Query.Fields[2].AsFloat, Query.Fields[3].AsInteger, Query.Fields[4].AsInteger, Query.Fields[5].AsString);
      PartNoItem.Status := pnstInUse;
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.RemoveFullSelectedPartNo;
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

procedure TfrmSelectPartNoParentedDlg.RemoveSelectedPartNo(const MaxQTY: double);
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
      SourcePartNoItem := fSelectedPartNoList.Find(PartNo, fCurrentKitSN);
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

procedure TfrmSelectPartNoParentedDlg.SavePartNoDB;
var
  Query: TIBCQuery;
  PartNoItem: TSWNPartNoItem;
  i: integer;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    // 1. Delete
    if fSelectedPartNoList.HasItemsOfStatus(pnstInUseDeleted) then
    begin
      Query.SQL.Clear;
      Query.SQL.Add('DELETE FROM TDB_PARTS');
      Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
      Query.SQL.Add('and PARTNO=:PARTNO');
      Query.ParamByName('DOCID').Value := fChildDataSet.FieldByName('DOCID').Value;
      Query.ParamByName('DTDEP').Value := fChildDataSet.FieldByName('DTDEP').Value;
      Query.ParamByName('CTDEP').Value := fChildDataSet.FieldByName('CTDEP').Value;
      Query.ParamByName('GOODSCOMPLECT_ID').Value := fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
      Query.ParamByName('GOODSID').Value := fChildDataSet.FieldByName('GOODSID').Value;

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
      Query.ParamByName('DOCID').Value := fChildDataSet.FieldByName('DOCID').Value;
      Query.ParamByName('DTDEP').Value := fChildDataSet.FieldByName('DTDEP').Value;
      Query.ParamByName('CTDEP').Value := fChildDataSet.FieldByName('CTDEP').Value;
      Query.ParamByName('GOODSCOMPLECT_ID').Value := fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
      Query.ParamByName('GOODSID').Value := fChildDataSet.FieldByName('GOODSID').Value;

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
      Query.ParamByName('DOCID').Value := fChildDataSet.FieldByName('DOCID').Value;
      Query.ParamByName('DTDEP').Value := fChildDataSet.FieldByName('DTDEP').Value;
      Query.ParamByName('CTDEP').Value := fChildDataSet.FieldByName('CTDEP').Value;
      Query.ParamByName('GOODSCOMPLECT_ID').Value := fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
      Query.ParamByName('GOODSID').Value := fChildDataSet.FieldByName('GOODSID').Value;

      Query.ParamByName('VENDORWARRANTY').AsInteger := fChildDataSet.FieldByName('WARRANTY').AsInteger;
      Query.ParamByName('OWNWARRANTY').Value := fGoodsWarranty;
      Query.ParamByName('CREATED_BY').AsInteger := UserID;

      for i := 0 to fSelectedPartNoList.Count - 1 do
      begin
        PartNoItem := fSelectedPartNoList[i];
        if PartNoItem.Status = pnstNew then
        begin
          Query.ParamByName('PARTNO').AsString := PartNoItem.PartNo;
          Query.ParamByName('COMPLECT_SN').AsString := PartNoItem.Complect_SN;
          Query.ParamByName('QTY').AsFloat := PartNoItem.QTY;
          Query.ParamByName('COUNTRYID').AsInteger := PartNoItem.CountryID;
          Query.ParamByName('VENDORID').AsInteger := PartNoItem.VendorID;
          Query.ExecSQL;
        end;
      end;
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmSelectPartNoParentedDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(self);
end;

procedure TfrmSelectPartNoParentedDlg.sbAddAllPNsClick(Sender: TObject);
begin
  AddAllRequestedPartNumbers;
end;

procedure TfrmSelectPartNoParentedDlg.sbAddCustomPNsClick(Sender: TObject);
begin
  ShowSelectCustomNumberToAddDialog;
end;

procedure TfrmSelectPartNoParentedDlg.sbAddPNsClick(Sender: TObject);
begin
  AddAvailablePartNo(1);
end;

procedure TfrmSelectPartNoParentedDlg.sbRemoveAllPNsClick(Sender: TObject);
begin
  RemoveFullSelectedPartNo;
end;

procedure TfrmSelectPartNoParentedDlg.sbRemovePNsClick(Sender: TObject);
begin
  RemoveSelectedPartNo(1);
end;

procedure TfrmSelectPartNoParentedDlg.SelectionChanged;
var
  N: integer;
  fCanAdd: Boolean;
  fCanRemove: Boolean;
begin
  fCanAdd := False;
  fCanRemove := False;

  if (not FReadOnly) and cmbKitSN.Enabled then
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

procedure TfrmSelectPartNoParentedDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmSelectPartNoParentedDlg.SetupQtyFields;
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

procedure TfrmSelectPartNoParentedDlg.ShowInfoForUser;
begin
  case CompareValue(GetTotalSelectedPartNumbersCount(cmbKitSN.Text), FJurnalQTY, 0) of
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

procedure TfrmSelectPartNoParentedDlg.ShowSelectCustomNumberToAddDialog;
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

procedure TfrmSelectPartNoParentedDlg.WhenGridDataChanged(Sender: TObject);
begin
  ShowInfoForUser;
end;

end.


unit frmPartNumbersDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxCustomData,
  DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, ExtCtrls, dxBar, Menus, StdCtrls, cxButtons, DBAccess, IBC, MemDS,
  cxTextEdit, cxDBEdit,
  cxCalc, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxContainer, cxClasses, cxMaskEdit,
  cxDropDownEdit, cxGridCustomView, cxCalendar;

type
  TfrmPartNumbersDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewPartNo: TdxBarButton;
    bbModifyPartNo: TdxBarButton;
    bbRemovePartNo: TdxBarButton;
    IBCQueryParts: TIBCQuery;
    IBCDataSourceParts: TIBCDataSource;
    pnClient: TPanel;
    cxGridParts: TcxGrid;
    cxGridPartsTable: TcxGridDBTableView;
    cxGridParts_PARTNO: TcxGridDBColumn;
    cxGridParts_QTY: TcxGridDBColumn;
    cxGridParts_VENDORWARRANTY: TcxGridDBColumn;
    cxGridParts_OWNWARRANTY: TcxGridDBColumn;
    cxGridPartsTable_SUMA_ACCIZE: TcxGridDBColumn;
    cxGridPartsLevel: TcxGridLevel;
    lbInfo: TLabel;
    cxGridParts_IMG: TcxGridDBColumn;
    pnTop: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edGOODSID: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    cxGridParts_COUNTRY_TITLE: TcxGridDBColumn;
    cxGridParts_VENDOR_TITLE: TcxGridDBColumn;
    cxGridParts_CREATED_BY_NAME: TcxGridDBColumn;
    edGOODS_QTY: TcxDBCalcEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    dxBarButton1: TdxBarButton;
    cxGridParts_EXPIRATION_DATE: TcxGridDBColumn;
    procedure bbNewPartNoClick(Sender: TObject);
    procedure cxGridPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbRemovePartNoClick(Sender: TObject);
    procedure bbModifyPartNoClick(Sender: TObject);
    procedure cxGridPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fDefaultVendorWarranty: integer;
    fDefaultOwnWarranty: Integer;
    fGoodsQuantity: Double;
    fNewPartNoTemplate: string;
    FReadOnly: Boolean;
    procedure ShowAddNewPartNoDialog;
    procedure SelectionChanged;
    procedure ReadGoodsAdditionalInfo;
    function GetDefaultQTY: Double;
    procedure DeleteSelectedPartNo;
    procedure ShowModifyDialog;
    procedure WhenGridDataChanged(Sender: TObject);
    procedure ShowInfoForUser;
    procedure SetNewPartNoTemplate(const Value: string);
    function WhenCheckPartNoExists(const PartNo: string): Boolean;

    procedure WhenBeginToAddSerials(Sender: TObject);
    procedure WhenEndToAddSerials(Sender: TObject);
    procedure WhenAddSerialFromScanner(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
              var Added: Boolean);

    procedure SetReadOnly(const Value: Boolean);
    procedure SetupQtyFields;
    procedure ShowInputFromScannerDialog;
    function AddNewRecord(const SerialNumber: String; const VendorWarranty,
      OwnVaranty, CountryID, VendorID: integer; var ErrorStr: String): Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property NewPartNoTemplate: string read fNewPartNoTemplate write SetNewPartNoTemplate;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  frmPartNumberEditorDialog, SWNUtils, SWNValueStorageUnit,
  SWNConst, SWNDBErrors, ClipBrd, frmSerialScannerDialog;

{$R *.dfm}
{ TfrmPartNumbersDlg }

procedure TfrmPartNumbersDlg.bbModifyPartNoClick(Sender: TObject);
begin
  ShowModifyDialog;
end;

procedure TfrmPartNumbersDlg.bbNewPartNoClick(Sender: TObject);
begin
  ShowAddNewPartNoDialog;
end;

procedure TfrmPartNumbersDlg.bbRemovePartNoClick(Sender: TObject);
begin
  DeleteSelectedPartNo;
end;

procedure TfrmPartNumbersDlg.cxGridPartsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyPartNo.Enabled then
    ShowModifyDialog;
end;

procedure TfrmPartNumbersDlg.cxGridPartsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmPartNumbersDlg.cxGridPartsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
  begin
    Clipboard.AsText := cxGridPartsTable.DataController.Values[cxGridPartsTable.Controller.FocusedRecordIndex, cxGridParts_PARTNO.Index];

    Key := 0;
  end;
end;

procedure TfrmPartNumbersDlg.DeleteSelectedPartNo;
begin
  if ShowAskDialog('Gestionarea partidelor', 'Sterge numar partida' + #13#10 + IBCQueryParts.FieldByName('PARTNO').AsString + '?') = mrYes then
  try
    IBCQueryParts.Delete;
  except
    on E: Exception do
    begin
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmPartNumbersDlg.dxBarButton1Click(Sender: TObject);
begin
 ShowInputFromScannerDialog;
end;

procedure TfrmPartNumbersDlg.ShowInputFromScannerDialog;
var
  dialog: TfrmSerialScannerDlg;
  N: Double;
begin
  N := 0;
  if VarIsNumeric(cxGridPartsTable.DataController.Summary.FooterSummaryValues[0]) then
    N := cxGridPartsTable.DataController.Summary.FooterSummaryValues[0];
  N := fGoodsQuantity - N;
  if N < 0 then
    N := 0;

  dialog := TfrmSerialScannerDlg.Create(Self);
  try
    dialog.DefaultVendorWarranty := fDefaultVendorWarranty;
    dialog.DefaultOwnWarranty := fDefaultOwnWarranty;
    dialog.RequiredCount := round(N);
    dialog.OnBeginToAddSearials := WhenBeginToAddSerials;
    dialog.OnAddSerialNumber := WhenAddSerialFromScanner;
    dialog.OnEndToAddSearials := WhenEndToAddSerials;
    dialog.GoodsID := fMasterDataSet.FieldByName('GOODSID').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      ShowInfoForUser;
    end;
  finally
    dialog.Free;
  end;
end;


procedure TfrmPartNumbersDlg.ShowInfoForUser;
var
  Count: Double;
begin
  Count := 0;
  if VarIsNumeric(cxGridPartsTable.DataController.Summary.FooterSummaryValues[0]) then
    Count := cxGridPartsTable.DataController.Summary.FooterSummaryValues[0];

  if Count = fGoodsQuantity then
  begin
    lbInfo.Caption := cMSG_PARTNO_CountIsOk;
    lbInfo.Color := cCOLOR_PARTNO_CountIsOk;
  end
  else if Count < fGoodsQuantity then
  begin
    lbInfo.Caption := cMSG_PARTNO_CountIsLess;
    lbInfo.Color := cCOLOR_PARTNO_CountIsLess;
  end
  else
  begin
    lbInfo.Caption := cMSG_PARTNO_CountIsBigger;
    lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
  end;
end;

function TfrmPartNumbersDlg.GetDefaultQTY: Double;
var
  N, N2: Double;
begin
  N := fGoodsQuantity;
  N2 := 0;
  if not VarIsNull(cxGridPartsTable.DataController.Summary.FooterSummaryValues[0]) then
    N2 := cxGridPartsTable.DataController.Summary.FooterSummaryValues[0];

  N := N - N2;

  if N < 0 then
    N := 0;
  Result := N;
end;

procedure TfrmPartNumbersDlg.BindingDataSource;
begin
  inherited;

  fNewPartNoTemplate := '';
  fDefaultOwnWarranty := 0;
  fGoodsQuantity := fMasterDataSet.FieldByName('QTY').AsFloat;

  IBCQueryParts.Connection := fMasterDataSet.Connection;
  IBCQueryParts.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryParts.MasterSource := fMasterDataSource;

  edGOODSID.DataBinding.DataSource := fMasterDataSource;
  edGOODS_NAME.DataBinding.DataSource := fMasterDataSource;
  edGOODS_QTY.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmPartNumbersDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if not FReadOnly then
    begin
      if IBCQueryParts.State in dsEditModes then
        IBCQueryParts.Post;
      IBCQueryParts.UpdateTransaction.Commit;
    end;
    IBCQueryParts.Close;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmPartNumbersDlg.LoadStates;
begin
  AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmPartNumbersDlg.Prepare;
begin
  SetupQtyFields;
  cxGridParts_PARTNO.Focused := True;

  if FReadOnly then
  begin
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    dtDialogTitle.Text := 'Vizualizarea partidelor';
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
    btnCancel.Default := True;

    IBCQueryParts.UpdateTransaction := nil;
  end;

  try
    if not FReadOnly then
      IBCQueryParts.UpdateTransaction.StartTransaction;

    if not FReadOnly then
      ReadGoodsAdditionalInfo;
    SelectionChanged;
    if FReadOnly then
      IBCQueryParts.readonly := True;
    IBCQueryParts.Active := True;

    if not FReadOnly then
      cxGridPartsTable.DataController.OnDataChanged := WhenGridDataChanged;
    ShowInfoForUser;
  except
    IBCQueryParts.Close;
    if not FReadOnly then
    begin
      if IBCQueryParts.UpdateTransaction.Active then
        IBCQueryParts.UpdateTransaction.Rollback;
    end;
    raise;
  end;
end;

procedure TfrmPartNumbersDlg.ReadGoodsAdditionalInfo;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    // read from TS_Goods: Warranty
    Query.Connection := fMasterDataSet.Connection;
    Query.SQL.Text := 'SELECT WARRANTY FROM TS_GOODS WHERE GOODSID=:GoodsID';
    Query.Params.ParamByName('GoodsID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
      fDefaultOwnWarranty := Query.Fields[0].AsInteger;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmPartNumbersDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmPartNumbersDlg.SelectionChanged;
var
  f1, f2, f3: Boolean;
begin
  f1 := not FReadOnly; // New + Security
  f2 := False; // Edit
  f3 := False; // Delete
  if (not FReadOnly) and (cxGridPartsTable.DataController.RecNo > 0) then
  begin
    f2 := True; // Edit + Security
    f3 := True; // Delete + Security
  end;
  bbNewPartNo.Enabled := f1;
  bbModifyPartNo.Enabled := f2;
  bbRemovePartNo.Enabled := f3;
end;

procedure TfrmPartNumbersDlg.SetNewPartNoTemplate(const Value: string);
begin
  fNewPartNoTemplate := Value;
end;

procedure TfrmPartNumbersDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmPartNumbersDlg.SetupQtyFields;
var
  qtyDigitsMode: Integer;
begin
  // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
  // Товарные позиции: Кол-во
  TcxCalcEditProperties(cxGridParts_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Товарные позиции (Footer): Кол-во
  cxGridParts_QTY.Summary.FooterFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Кол-во
  TcxCalcEditProperties(edGOODS_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmPartNumbersDlg.ShowAddNewPartNoDialog;
var
  dialog: TfrmPartNumberEditorDlg;
begin
  dialog := TfrmPartNumberEditorDlg.Create(Self, IBCQueryParts, IBCDataSourceParts);
  try
    dialog.CreateNewPartNo := True;
    dialog.DefaultPartNo := fNewPartNoTemplate;
    dialog.DefaultVendorWarranty := fMasterDataSet.FieldByName('WARRANTY').AsInteger;
    dialog.DefaultOwnWarranty := fDefaultOwnWarranty;
    dialog.DefaultQTY := GetDefaultQTY;
    dialog.OnCheckPartNoExists := WhenCheckPartNoExists;
    dialog.GoodsID := fMasterDataSet.FieldByName('GOODSID').AsInteger;

    if dialog.ShowModal = mrOk then
    begin

    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPartNumbersDlg.ShowModifyDialog;
var
  dialog: TfrmPartNumberEditorDlg;
begin
  dialog := TfrmPartNumberEditorDlg.Create(Self, IBCQueryParts, IBCDataSourceParts);
  try
    dialog.CreateNewPartNo := False;

    if dialog.ShowModal = mrOk then
    begin

    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPartNumbersDlg.WhenBeginToAddSerials(Sender: TObject);
begin
  cxGridPartsTable.DataController.BeginFullUpdate;
end;

procedure TfrmPartNumbersDlg.WhenCancelForm;
begin
  if not FReadOnly then
  begin
    if IBCQueryParts.State in dsEditModes then
      IBCQueryParts.Cancel;
    IBCQueryParts.UpdateTransaction.Rollback;
  end;
  IBCQueryParts.Close;
end;

function TfrmPartNumbersDlg.WhenCheckPartNoExists(const PartNo: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridPartsTable.DataController.RecordCount - 1 do
  begin
    if (i <> cxGridPartsTable.DataController.FocusedRecordIndex) and (cxGridPartsTable.DataController.Values[i, cxGridParts_PARTNO.Index] = PartNo) then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TfrmPartNumbersDlg.WhenEndToAddSerials(Sender: TObject);
begin
  cxGridPartsTable.DataController.EndFullUpdate;
end;

procedure TfrmPartNumbersDlg.WhenGridDataChanged(Sender: TObject);
begin
  ShowInfoForUser;
end;

procedure TfrmPartNumbersDlg.WhenAddSerialFromScanner(const SerialNumber: String;
  const VendorWarranty, OwnVaranty, CountryID, VendorID: integer; var Added: Boolean);
var
  ErrorStr: String;
begin
  Added := AddNewRecord(SerialNumber, VendorWarranty, OwnVaranty, CountryID, VendorID, ErrorStr);
end;

function TfrmPartNumbersDlg.AddNewRecord(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
  var ErrorStr: String): Boolean;
begin
  Result := False;
  IBCQueryParts.Append;
  try
    IBCQueryParts.FieldByName('PARTNO').AsString := SerialNumber;
    IBCQueryParts.FieldByName('QTY').AsFloat := 1;
    IBCQueryParts.FieldByName('VENDORWARRANTY').AsInteger := VendorWarranty;
    IBCQueryParts.FieldByName('OWNWARRANTY').AsInteger := OwnVaranty;
    IBCQueryParts.FieldByName('COMPLECT_SN').AsString := '';
    IBCQueryParts.FieldByName('CREATED_BY').AsInteger := UserID;
    IBCQueryParts.FieldByName('COUNTRYID').AsInteger := CountryID;
    IBCQueryParts.FieldByName('VENDORID').AsInteger := VendorID;
    IBCQueryParts.Post;
    Result := True;
  except
    on E: Exception do
    begin
      IBCQueryParts.Cancel;
      ErrorStr := E.Message;
    end;
  end;
end;



end.


unit frmSerialNumbersDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, ExtCtrls, cxCustomData, DB, cxDBData,
  dxBar, DBAccess, IBC, MemDS, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, StdCtrls, cxDBEdit,

  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, Vcl.Menus, cxClasses,
  cxGridCustomView, cxTextEdit;

type
  TfrmSerialNumbersDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bsubTools: TdxBarSubItem;
    bbNewSerial: TdxBarButton;
    bbModifySerial: TdxBarButton;
    bbRemoveSerial: TdxBarButton;
    dxBarButton3: TdxBarButton;
    bbScanner: TdxBarButton;
    bbPaste: TdxBarButton;
    bbCopy: TdxBarButton;
    IBCDataSourceSN: TIBCDataSource;
    pnGoods: TPanel;
    cxLabel1: TLabel;
    pmPopupMenu: TdxBarPopupMenu;
    edQTY: TcxDBTextEdit;
    cxGridSerials: TcxGrid;
    cxGridSerialsTable: TcxGridDBTableView;
    cxGridSerialsTable_IMG: TcxGridDBColumn;
    cxGridSerialsTable_SN: TcxGridDBColumn;
    cxGridSerialsTable_VENDORWARRANTY: TcxGridDBColumn;
    cxGridSerialsTable_OWNWARRANTY: TcxGridDBColumn;
    cxGridSerialsTable_SUMA_ACCIZE: TcxGridDBColumn;
    cxGridSerialsLevel: TcxGridLevel;
    cxLabel2: TLabel;
    lbInfo: TLabel;
    edGOODSID: TcxDBTextEdit;
    edGOODS_NAME: TcxDBTextEdit;
    cxGridSerials_COUNTRY_TITLE: TcxGridDBColumn;
    cxGridSerials_VENDOR_TITLE: TcxGridDBColumn;
    cxGridSerials_CREATED_BY_NAME: TcxGridDBColumn;
    bbGenerateKitSerials: TdxBarButton;
    cxGridSerials_CREATED_DATE: TcxGridDBColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQuerySN: TIBCQuery;
    procedure bbNewSerialClick(Sender: TObject);
    procedure bbModifySerialClick(Sender: TObject);
    procedure bbRemoveSerialClick(Sender: TObject);
    procedure cxGridSerialsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbScannerClick(Sender: TObject);
    procedure bbPasteClick(Sender: TObject);
    procedure bbCopyClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure cxGridSerialsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbGenerateKitSerialsClick(Sender: TObject);
    procedure cxGridSerials_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridSerialsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fDefaultVendorWarranty: integer;
    fDefaultOwnWarranty: integer;
    fGoodsQuantity: integer;
    FReadOnly: Boolean;
    FNeuronSborkaMode: Boolean;
    procedure ShowAddNewSerialDialog;
    procedure ShowModifySerialDialog;
    procedure ShowRemoveSerialDialog;
    procedure ShowInputFromScannerDialog;
    procedure PasteSerialFromClipboard;

    procedure WhenClipboardChanged(var Msg: TWMDrawClipboard); message WM_DRAWCLIPBOARD;
    procedure ClipboardContentChanged;

    procedure SelectionChanged;

    procedure ReadGoodsAdditionalInfo;
    procedure ShowInfoForUser;

    function AddNewRecord(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
      var ErrorStr: String): Boolean;
    procedure WhenAddSerialFromScanner(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
      var Added: Boolean);
    procedure WhenBeginToAddSerials(Sender: TObject);
    procedure WhenEndToAddSerials(Sender: TObject);

    procedure ExportSearials;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetNeuronSborkaMode(const Value: Boolean);

    function DoGenerateSborkaSerials: Boolean;

  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property NeuronSborkaMode: Boolean read FNeuronSborkaMode write SetNeuronSborkaMode;
  end;

implementation

uses ClipBrd, frmSerialNumberEditorDialog, frmSerialScannerDialog,
  SWNUtils, cxGridExportLink, SWNValueStorageUnit, SWNConst, SWNDBErrors, DataModuleDB;

{$R *.dfm}
{ TfrmSerialNumbersDlg }

function TfrmSerialNumbersDlg.AddNewRecord(const SerialNumber: String; const VendorWarranty, OwnVaranty, CountryID, VendorID: integer;
  var ErrorStr: String): Boolean;
begin
  Result := False;
  IBCQuerySN.Append;
  try
    IBCQuerySN.FieldByName('SN').AsString := SerialNumber;
    IBCQuerySN.FieldByName('VENDORWARRANTY').AsInteger := VendorWarranty;
    IBCQuerySN.FieldByName('OWNWARRANTY').AsInteger := OwnVaranty;
    IBCQuerySN.FieldByName('COMPLECT_SN').Value := null;
    IBCQuerySN.FieldByName('CREATED_BY').AsInteger := UserID;
    IBCQuerySN.FieldByName('COUNTRYID').AsInteger := CountryID;
    IBCQuerySN.FieldByName('VENDORID').AsInteger := VendorID;
    IBCQuerySN.Post;
    Result := True;
  except
    on E: Exception do
    begin
      IBCQuerySN.Cancel;
      ErrorStr := E.Message;
    end;
  end;
end;

procedure TfrmSerialNumbersDlg.bbCopyClick(Sender: TObject);
begin
  ClipBoard.AsText := IBCQuerySN.FieldByName('SN').AsString;
end;

procedure TfrmSerialNumbersDlg.bbGenerateKitSerialsClick(Sender: TObject);
var
  S: String;
begin
  S := Format('Doriti sa generati %d de serii noi pentru asamblare?', [fGoodsQuantity]);
  if ShowAskDialog('Serii noi pentru asamblare', S, 'Seriile curente vor fi sterse!') = mrYes then
  begin
    if DoGenerateSborkaSerials then
      IBCQuerySN.Refresh;
  end;
end;

procedure TfrmSerialNumbersDlg.bbModifySerialClick(Sender: TObject);
begin
  ShowModifySerialDialog;
end;

procedure TfrmSerialNumbersDlg.bbNewSerialClick(Sender: TObject);
begin
  ShowAddNewSerialDialog;
end;

procedure TfrmSerialNumbersDlg.bbPasteClick(Sender: TObject);
begin
  PasteSerialFromClipboard;
end;

procedure TfrmSerialNumbersDlg.bbRemoveSerialClick(Sender: TObject);
begin
  ShowRemoveSerialDialog;
end;

procedure TfrmSerialNumbersDlg.bbScannerClick(Sender: TObject);
begin
  ShowInputFromScannerDialog;
end;

procedure TfrmSerialNumbersDlg.ClipboardContentChanged;
begin
  bbPaste.Enabled := ClipBoard.HasFormat(CF_TEXT);
end;

procedure TfrmSerialNumbersDlg.cxGridSerialsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifySerial.Enabled then
    ShowModifySerialDialog;
end;

procedure TfrmSerialNumbersDlg.cxGridSerialsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmSerialNumbersDlg.cxGridSerialsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 65) and (Shift = [ssCtrl]) then
    cxGridSerialsTable.DataController.SelectAll // Ctrl+A
  else if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
  begin
    ClipBoard.AsText := cxGridSerialsTable.DataController.Values[cxGridSerialsTable.Controller.FocusedRecordIndex,
      cxGridSerialsTable.Controller.FocusedItem.Index];
    Key := 0;
  end
end;

procedure TfrmSerialNumbersDlg.cxGridSerials_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if Not VarIsNull(ARecord.Values[cxGridSerials_CREATED_DATE.Index]) then
  begin
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridSerials_CREATED_DATE.Index]);
  end;
end;

function TfrmSerialNumbersDlg.DoGenerateSborkaSerials: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := IBCQuerySN.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_GET_COMPLECTS_COUNT(:DOCID,:DTDEP,:CTDEP,:GOODSID,:GOODSCOMPLECT_ID,:VENDORWARRANTY,:COUNT_SN)';
    Query.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := fMasterDataSet.FieldByName('DTDEP').AsInteger;
    Query.ParamByName('CTDEP').AsInteger := fMasterDataSet.FieldByName('CTDEP').AsInteger;
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
    Query.ParamByName('GOODSCOMPLECT_ID').AsInteger := fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').AsInteger;
    Query.ParamByName('VENDORWARRANTY').AsInteger := fMasterDataSet.FieldByName('WARRANTY').AsInteger;;
    Query.ParamByName('COUNT_SN').AsInteger := fMasterDataSet.FieldByName('QTY').AsInteger;;
    try
      Query.ExecSQL;
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

procedure TfrmSerialNumbersDlg.ShowInfoForUser;
var
  N: integer;
begin
  N := 0;
  if VarIsNumeric(cxGridSerialsTable.DataController.Summary.FooterSummaryValues[0]) then
    N := cxGridSerialsTable.DataController.Summary.FooterSummaryValues[0];

  if N = fGoodsQuantity then
  begin
    lbInfo.Caption := cMSG_SN_CountIsOk;
    lbInfo.Color := cCOLOR_PARTNO_CountIsOk;
  end
  else if N < fGoodsQuantity then
  begin
    lbInfo.Caption := cMSG_SN_CountIsLess;
    lbInfo.Color := cCOLOR_PARTNO_CountIsLess;
  end
  else
  begin
    lbInfo.Caption := cMSG_SN_CountIsBigger;
    lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
  end;
end;

procedure TfrmSerialNumbersDlg.dxBarButton3Click(Sender: TObject);
begin
  ExportSearials;
end;

procedure TfrmSerialNumbersDlg.ExportSearials;
begin
  with TSaveDialog.Create(Self) do
  begin
    Filter := 'Excel file|*.xls|Text file|*.txt';
    if Execute then
    begin
      case FilterIndex of
        1:
          ExportGridToExcel(FileName, cxGridSerials);
        2:
          ExportGridToText(FileName, cxGridSerials);
      end;
    end;
    Free;
  end;
end;

procedure TfrmSerialNumbersDlg.BindingDataSource;
begin
  inherited;

  fDefaultOwnWarranty := 0;
  bbGenerateKitSerials.Visible := ivNever;

  fGoodsQuantity := fMasterDataSet.FieldByName('QTY').AsInteger;
  fDefaultVendorWarranty := fMasterDataSet.FieldByName('WARRANTY').AsInteger;

  IBCQuerySN.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySN.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQuerySN.MasterSource := fMasterDataSource;

  edGOODSID.DataBinding.DataSource := fMasterDataSource;
  edGOODS_NAME.DataBinding.DataSource := fMasterDataSource;
  edQTY.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmSerialNumbersDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if Not FReadOnly then
      fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  except
    on E: Exception do
      if Not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmSerialNumbersDlg.LoadStates;
begin
  AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmSerialNumbersDlg.PasteSerialFromClipboard;
var
  i: integer;
  S, ErrorStr: string;
  List, ErrorList: TStringList;
  toBuffer, toSort: Boolean;
  defCountry, defVendor: integer;
begin
  defCountry := AppUserConfigStorage.IntValues.GetValue('SerialNumber_DefaultCountryID', -1);
  defVendor := AppUserConfigStorage.IntValues.GetValue('SerialNumber_DefaultVendorID', -1);

  List := TStringList.Create;
  ErrorList := TStringList.Create;
  try
    List.Text := Trim(ClipBoard.AsText);
    // check content
    for i := List.Count - 1 downto 0 do
    begin
      S := List[i];
      if Not ValidateTextForSerial(S) then
      begin
        ErrorList.Insert(0, S);
        List.Delete(i);
      end;
    end;

    if List.Count > 0 then
    begin
      toSort := False;
      if ShowAskDialogVerification('Paste', 'Introduce ' + IntToStr(List.Count) + ' numere de serii din clipboard?',
        'Sortarea numerilor de serii?', 'Serii eronate: ' + IntToStr(ErrorList.Count), toSort) = mrYes then
      begin
        if toSort then
          List.Sort;

        cxGridSerialsTable.DataController.BeginFullUpdate;
        try
          // insert serials
          for i := 0 to List.Count - 1 do
          begin
            S := List[i];
            ErrorStr := '';
            if Not AddNewRecord(S, fDefaultVendorWarranty, fDefaultOwnWarranty, defCountry, defVendor, ErrorStr) then
              ErrorList.Add(S);
          end;
        finally
          cxGridSerialsTable.DataController.EndFullUpdate;
        end;
        // show verdict
        if ErrorList.Count > 0 then
        begin
          S := Format('Adaugate serii: %d' + #13#10 + 'Serii neprocesate: %d', [List.Count - ErrorList.Count, ErrorList.Count]);
          toBuffer := False;
          ShowInfoDialogVerification('Introducerea numerilor de serii sa finisat.', S, 'Doriti seriile neprocesate sa fie adaugate in clipboard', toBuffer);
          if toBuffer then
          begin
            // left unposted serials back to clipboard
            ClipBoard.AsText := ErrorList.Text;
          end;
        end
        else
          ShowInfoDialog('Introducerea numerilor de serii sa finisat', 'Toate seriile au fost introduse!')
      end;
    end
    else
      ShowErrorDialog('Date gresite', 'Datele din clipboard par a nu fi numere de serie!');
  finally
    List.Free;
    ErrorList.Free;
  end;

  ShowInfoForUser;
end;

procedure TfrmSerialNumbersDlg.Prepare;
begin
  cxGridSerialsTable_SN.Focused := True;

  if FReadOnly then
  begin
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    dtDialogTitle.Text := 'Vizualizarea numerilor de serii';
    btnOk.Visible := False;
    btnCancel.Caption := cMSG_ButtonClose;
    btnCancel.Default := True;

    IBCQuerySN.Transaction := fMasterDataSet.Transaction;
    IBCQuerySN.UpdateTransaction := nil;
  end;

  pnClient.AutoSize := True;
  SelectionChanged;
  ClipboardContentChanged;

  try
    if Not FReadOnly then
      fMasterDataSet.UpdateTransaction.StartTransaction;

    if Not FReadOnly then
      ReadGoodsAdditionalInfo;
    if FReadOnly then
      IBCQuerySN.ReadOnly := True;
    IBCQuerySN.Active := True;
    ShowInfoForUser;
  except
    IBCQuerySN.Close;
    if Not FReadOnly then
    begin
      if fMasterDataSet.UpdateTransaction.Active then
        fMasterDataSet.UpdateTransaction.Rollback;
    end;
    raise;
  end;
end;

procedure TfrmSerialNumbersDlg.ReadGoodsAdditionalInfo;
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
    if Not Query.Eof then
      fDefaultOwnWarranty := Query.Fields[0].AsInteger;
    Query.Close;

    // read from TDB_SN field COMPLECT_SN if curent Goods has Complect
    {
      if fParentGoodsID<>-1 then
      begin
      Query.Connection:=fMasterDataSet.Connection;
      Query.SQL.Text:='SELECT SN FROM VW_TDB_SN WHERE (DOCID = :DOCID) AND (DTDEP = :DTDEP) AND (CTDEP = :CTDEP) AND (GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID) AND (GOODSID=:GOODSID)';
      Query.Params.ParamByName('DOCID').AsInteger:=fMasterDataSet.FieldByName('DOCID').asInteger;
      Query.Params.ParamByName('DTDEP').AsInteger:=fMasterDataSet.FieldByName('DTDEP').asInteger;
      Query.Params.ParamByName('CTDEP').AsInteger:=fMasterDataSet.FieldByName('CTDEP').asInteger;
      Query.Params.ParamByName('GOODSCOMPLECT_ID').AsInteger:=fMasterDataSet.FieldByName('GOODSCOMPLECT_ID').asInteger;
      Query.Params.ParamByName('GOODSID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').asInteger;
      Query.ExecSQL;
      if Not Query.Eof then fComplectSN:=Query.Fields[0].AsString;
      Query.Close;
      end;
    }
  finally
    Query.Free;
  end;
end;

procedure TfrmSerialNumbersDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmSerialNumbersDlg.SelectionChanged;
var
  f1, f2, f3, f4, f5, f6: Boolean;
begin
  f1 := Not FReadOnly; // New + Security
  f2 := Not FReadOnly; // New from Scanner + Security
  f3 := False;
  f4 := False;
  f5 := False;
  f6 := Not FReadOnly;
  if (Not FReadOnly) and (cxGridSerialsTable.DataController.RecNo > 0) then
  begin
    f3 := True; // Modify + Security
    f4 := True; // Delete + Security
    f5 := True; // Copy
  end;
  bbNewSerial.Enabled := f1;
  bbGenerateKitSerials.Enabled := f1;
  bbScanner.Enabled := f2;
  bbModifySerial.Enabled := f3;
  bbRemoveSerial.Enabled := f4;
  bbCopy.Enabled := f5;
  bbPaste.Enabled := f6;
end;

procedure TfrmSerialNumbersDlg.SetNeuronSborkaMode(const Value: Boolean);
begin
  FNeuronSborkaMode := Value;
  if Value then
    bbGenerateKitSerials.Visible := ivAlways
  else
    bbGenerateKitSerials.Visible := ivNever;
end;

procedure TfrmSerialNumbersDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmSerialNumbersDlg.ShowAddNewSerialDialog;
var
  dialog: TfrmSerialNumberEditorDlg;
begin
  dialog := TfrmSerialNumberEditorDlg.Create(Self, IBCQuerySN, IBCDataSourceSN);
  try
    dialog.CreateNewSerial := True;
    dialog.DefaultVendorWarranty := fDefaultVendorWarranty;
    dialog.DefaultOwnWarranty := fDefaultOwnWarranty;
    dialog.GoodsID := fMasterDataSet.FieldByName('GOODSID').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      ShowInfoForUser;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialNumbersDlg.ShowInputFromScannerDialog;
var
  dialog: TfrmSerialScannerDlg;
  N: integer;
begin
  N := 0;
  if VarIsNumeric(cxGridSerialsTable.DataController.Summary.FooterSummaryValues[0]) then
    N := cxGridSerialsTable.DataController.Summary.FooterSummaryValues[0];
  N := fGoodsQuantity - N;
  if N < 0 then
    N := 0;

  dialog := TfrmSerialScannerDlg.Create(Self);
  try
    dialog.DefaultVendorWarranty := fDefaultVendorWarranty;
    dialog.DefaultOwnWarranty := fDefaultOwnWarranty;
    dialog.RequiredCount := N;
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

procedure TfrmSerialNumbersDlg.ShowModifySerialDialog;
var
  dialog: TfrmSerialNumberEditorDlg;
begin
  dialog := TfrmSerialNumberEditorDlg.Create(Self, IBCQuerySN, IBCDataSourceSN);
  try
    dialog.CreateNewSerial := False;
    if dialog.ShowModal = mrOk then
    begin
      ShowInfoForUser;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmSerialNumbersDlg.ShowRemoveSerialDialog;
begin
  if ShowAskDialog('Numere de serii', 'Sterge numarul de serie' + #13#10 + IBCQuerySN.FieldByName('SN').AsString + '?') = mrYes
  then
  begin
    try
      IBCQuerySN.Delete;
      ShowInfoForUser;
    except
      on E: Exception do
        if Not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmSerialNumbersDlg.WhenAddSerialFromScanner(const SerialNumber: String;
  const VendorWarranty, OwnVaranty, CountryID, VendorID: integer; var Added: Boolean);
var
  ErrorStr: String;
begin
  Added := AddNewRecord(SerialNumber, VendorWarranty, OwnVaranty, CountryID, VendorID, ErrorStr);
end;

procedure TfrmSerialNumbersDlg.WhenBeginToAddSerials(Sender: TObject);
begin
  cxGridSerialsTable.DataController.BeginFullUpdate;
end;

procedure TfrmSerialNumbersDlg.WhenCancelForm;
begin
  if Not FReadOnly then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmSerialNumbersDlg.WhenClipboardChanged(var Msg: TWMDrawClipboard);
begin
  inherited;
  ClipboardContentChanged;
end;

procedure TfrmSerialNumbersDlg.WhenEndToAddSerials(Sender: TObject);
begin
  cxGridSerialsTable.DataController.EndFullUpdate;
end;

end.

unit frmCustomerContractsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB,
  cxDBData, DBAccess, IBC, MemDS, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar,
  Vcl.ExtCtrls, DialogTitle, Vcl.StdCtrls, cxNavigator, cxCheckBox, cxLabel,
  cxImageComboBox, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxDateRanges, dxScrollbarAnnotations, frameScanFiles, frmPrintEngineWindow, dxUIAClasses;

type
  TfrmContractsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridCTable: TcxGridDBTableView;
    cxGridCLevel: TcxGridLevel;
    cxGridC: TcxGrid;
    IBCQueryC: TIBCQuery;
    IBCDataSourceC: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGridC_CONTRACTID: TcxGridDBColumn;
    cxGridC_DT_NAME: TcxGridDBColumn;
    cxGridC_CT_NAME: TcxGridDBColumn;
    cxGridC_SIGN_DATE: TcxGridDBColumn;
    cxGridC_EXPIRE_DATE: TcxGridDBColumn;
    cxGridC_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridC_CODE: TcxGridDBColumn;
    cxGridC_CONTRACT_TYPE_TITLE: TcxGridDBColumn;
    cxGridC_CREATED_BY_NAME: TcxGridDBColumn;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridC_PRICE_COLUMN: TcxGridDBColumn;
    cxGridC_FLG_CLOSED: TcxGridDBColumn;
    cxGridC_FLG_ACNT: TcxGridDBColumn;
    pnBottom: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    pnFiles: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFilesLevel: TcxGridLevel;
    cxGridFiles: TcxGrid;
    dxBarManager1Bar2: TdxBar;
    bbFileNew: TdxBarButton;
    bbFileDelete: TdxBarButton;
    bbFileSave: TdxBarButton;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_TITLE: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    cxGridC_VAT: TcxGridDBColumn;
    cxGridC_FLG_DEFAULT: TcxGridDBColumn;
    cxGridC_RAGAZ_PLATA: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    procedure cxGridCTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridCTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridC_CURRENCY_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbFileNewClick(Sender: TObject);
    procedure bbFileDeleteClick(Sender: TObject);
    procedure bbFileSaveClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    { Private declarations }
    fCT: integer;
    fSelectMode: Boolean;
    fContractID: integer;
    fContractCode: string;
    fContractSignDate: TDate;
    fSECURITY_Allow: Boolean;
    fContractCurrencyID: integer;
    fContractTypeTitle: string;
    fContractFLG_ACNT: integer;
    fLastFilePath: string;

    procedure SelectionChanged;
    procedure FileSelectionChanged;
    procedure SetCT(const Value: integer);

    procedure ShowCreateNewContractDialog;
    procedure ShowModifyContractDialog;
    procedure DeleteContract;
    procedure SetSelectMode(const Value: Boolean);
    procedure SetContractID(const Value: integer);

    function CheckSelection: Boolean;

    procedure ShowAddNewFileDialog;
    procedure DeleteSelectedFile;
    procedure SaveSelectedFile;
    procedure SaveFileFromDB(const ContractFileID: Integer; const TargetDir: string);
    procedure SetupReportParams(const ReportParams: TReportParamsList);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;

    procedure SetupSecurityItems; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ContractID: integer read fContractID write SetContractID;
    property ContractCode: string read fContractCode;
    property ContractSignDate: TDate read fContractSignDate;
    property ContractCurrencyID: integer read fContractCurrencyID;
    property ContractTypeTitle: string read fContractTypeTitle;
    property ContractFLG_ACNT: integer read fContractFLG_ACNT;
    property SelectMode: Boolean read fSelectMode write SetSelectMode;
    property CT: integer read fCT write SetCT;
  end;

  TCustomerDefultContractInfo = class
  public
    ContractID: Integer;
    ContractTypeTitle: string;
    Code: string;
    SignDate: TDateTime;
    CurrencyID: Integer;
    FLG_ACNT: Boolean;

    constructor Create(AOwner: TComponent; ACustomerID: Integer; ADocDate: Double); overload;
    destructor Destroy; override;
  end;

function LoadCustomerDefaultContractInfo(const ADT, ACT: Integer; const DocDate: TDateTime):
    TCustomerDefultContractInfo;

function SelectCustomerContract(const CustomerID, ExistingContractID: integer): TCustomerDefultContractInfo;



implementation

{$R *.dfm}
{$WARN UNIT_PLATFORM OFF}

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNDBErrors,
  frmCustomerContractEditorDialog, SWNSecurityFlags, SWNConst,
  frmCustomerContractFileEditorDialog, Vcl.FileCtrl, System.UITypes, frmPreviewPDFUnit, frmPrintWizardDialog;

function LoadCustomerDefaultContractInfo(const ADT, ACT: Integer; const DocDate: TDateTime): TCustomerDefultContractInfo;
var
  Query: TIBCQuery;
begin
  Result := nil;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Clear;
//    Query.SQL.Add('select C.* from VW_TDB_CONTRACTS C');
//    Query.SQL.Add('inner join TS_CUST_1C CC on CC.CUSTOMERID = C.DT');
//    Query.SQL.Add('inner join SP_GET_ORG(12057) Z on Z.ORGID = CC.DT');
//    Query.SQL.Add('where C.FLG_DEFAULT = 1 and C.CT = :CT and c.expire_date >= :DATA and c.sign_date <=:data');

    Query.SQL.Add('select C.* from VW_TDB_CONTRACTS C');
    Query.SQL.Add('inner join TS_CUST_1C CC on CC.CUSTOMERID = C.DT and c.dt = :dt');
    Query.SQL.Add('where C.FLG_DEFAULT = 1 and C.CT = :ct and c.expire_date >= :DATA and c.sign_date <=:data');
    Query.SQL.Add('and c.dt = :dt');

    Query.ParamByName('DT').AsInteger := ADT;
    Query.ParamByName('CT').AsInteger := ACT;
    Query.ParamByName('DATA').AsDate := DocDate;

    Query.ExecSQL;
    if not Query.Eof then
    begin
             // got single record
      Result := TCustomerDefultContractInfo.Create;
      Result.ContractTypeTitle := Query.FieldByName('CONTRACT_TYPE_TITLE').AsString;
      Result.Code := Query.FieldByName('CODE').AsString;
      Result.SignDate := Query.FieldByName('SIGN_DATE').AsDateTime;
      Result.ContractID := Query.FieldByName('CONTRACTID').AsInteger;
      Result.FLG_ACNT := Query.FieldByName('FLG_ACNT').AsInteger = 1;
      Result.CurrencyID := Query.FieldByName('CURRENCYID').AsInteger;
    end
  finally
    Query.Free;
  end;
end;

function SelectCustomerContract(const CustomerID, ExistingContractID: integer): TCustomerDefultContractInfo;
var
  dialog: TfrmContractsDlg;
begin
  Result := nil;
  if (CustomerID <= 0) then
  begin
    ShowErrorDialog('Eroare', 'In primul rind alegeti clientul si dupa contractele!');
    Exit;
  end;

  dialog := TfrmContractsDlg.Create(nil);
  try
    dialog.ContractID := ExistingContractID;
    dialog.CT := CustomerID;
    dialog.SelectMode := True;
    if dialog.ShowModal = mrOk then
    begin
      Result := TCustomerDefultContractInfo.Create;
      Result.ContractID := dialog.ContractID;
      Result.ContractTypeTitle := dialog.ContractTypeTitle;
      Result.Code := dialog.ContractCode;
      Result.SignDate := dialog.ContractSignDate;
      Result.CurrencyID := dialog.ContractCurrencyID;
      Result.FLG_ACNT := dialog.ContractFLG_ACNT = 1;
    end;
  finally
    dialog.Free;
  end;
end;

{ TfrmContractsDlg }
procedure TfrmContractsDlg.SetupReportParams(const ReportParams: TReportParamsList);
begin
  // setup here general params
  ReportParams.SetParamValue('CONTRACT_TYPEID', IBCQueryC.FieldByName('CONTRACT_TYPE').AsInteger);
  ReportParams.SetParamValue('CONTRACTID', IBCQueryC.FieldByName('CONTRACTID').AsInteger);
end;


procedure TfrmContractsDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteContract;
end;

procedure TfrmContractsDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyContractDialog;
  ibcqueryc.RefreshRecord;
end;

procedure TfrmContractsDlg.bbFileDeleteClick(Sender: TObject);
begin
  DeleteSelectedFile;
end;

procedure TfrmContractsDlg.bbFileNewClick(Sender: TObject);
begin
  ShowAddNewFileDialog;
end;

procedure TfrmContractsDlg.bbFileSaveClick(Sender: TObject);
begin
  SaveSelectedFile;
end;

procedure TfrmContractsDlg.bbNewClick(Sender: TObject);
begin
  ShowCreateNewContractDialog;
//     IBCQueryC.RefreshRecord;
end;

function TfrmContractsDlg.CheckSelection: Boolean;
var
  Errors: string;
begin
  Result := False;
  Errors := '';

  if IBCQueryC.FieldByName('FLG_CLOSED').AsInteger = 1 then
    AddErrorToStr(Errors, 'Nu pot fi utilizate contractele inchise!');

  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

constructor TfrmContractsDlg.Create(AOwner: TComponent);
begin
  inherited;
  fContractID := -1;
  fSelectMode := False;
end;

procedure TfrmContractsDlg.cxGridCTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) then
  begin
    if fSelectMode then
      ModalResult := mrOk
    else if bbEdit.Enabled then
      bbEditClick(bbEdit);
  end;
end;

procedure TfrmContractsDlg.cxGridCTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  DATA: TDate;
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridC_FLG_CLOSED.Index]) then
  begin
    if (AViewInfo.GridRecord.Values[cxGridC_FLG_CLOSED.Index] = 1) then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clGrayText;
    end;
  end;

  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridC_EXPIRE_DATE.Index]) then
  begin
    if dmDB.ibcquerydocs.Active then
      DATA := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime
    else
      DATA := Date;
    if (AViewInfo.GridRecord.Values[cxGridC_EXPIRE_DATE.Index] < DATA) then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      ACanvas.Font.Color := clGrayText;
    end;
  end;
end;

procedure TfrmContractsDlg.cxGridCTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmContractsDlg.cxGridC_CURRENCY_TITLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridC_CURRENCY_TITLE.Index]) and not VarIsNull(ARecord.Values[cxGridC_PRICE_COLUMN.Index]) then
    AText := Format('%s [%d]', [string(ARecord.Values[cxGridC_CURRENCY_TITLE.Index]), Integer(ARecord.Values[cxGridC_PRICE_COLUMN.Index])]);
end;

procedure TfrmContractsDlg.cxGridFilesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  FileSelectionChanged;
end;

procedure TfrmContractsDlg.DeleteContract;
begin
  if ShowAskDialog('Contracte', Format('Stergeti contractul №%s ?', [IBCQueryC.FieldByName('CODE').AsString])) <> mrYes then
    Exit;

  if not IBCQueryC.UpdateTransaction.Active then
    IBCQueryC.UpdateTransaction.StartTransaction;
  try
    IBCQueryC.Delete;
    IBCQueryC.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryC.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmContractsDlg.DeleteSelectedFile;
begin
  if ShowAskDialog('Contracte', Format('Stergeti file-ul "%s"?', [IBCQueryFiles.FieldByName('TITLE').AsString])) <> mrYes then
    Exit;

  IBCQueryFiles.UpdateTransaction.StartTransaction;
  try
    if not IBCQueryC.UpdateTransaction.Active then
      IBCQueryC.UpdateTransaction.StartTransaction;
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

procedure TfrmContractsDlg.dxBarButton1Click(Sender: TObject);
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
    q.SQL.Add('SELECT FILECONTENT FROM TDB_CONTRACT_FILES WHERE CONTRACTFILEID=:ID');
    q.ParamByName('ID').AsInteger := IBCQueryFiles.FieldByName('CONTRACTFILEID').AsInteger;
    q.Open;
    TBlobField(q.FieldByName('FILECONTENT')).SaveToStream(ms);
    ms.Position := 0;
    d.PdfStream := ms;
    d.ShowModal;
  finally
    d.Free;
    ms.Free;
    q.Free;
  end;
end;
procedure TfrmContractsDlg.dxBarButton2Click(Sender: TObject);
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(29);
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;



procedure TfrmContractsDlg.FileSelectionChanged;
var
  fNew, fDelete, fSave: Boolean;
  FLG_CLOSED: Boolean;
begin
  fNew := False;
  fDelete := False;
  fSave := False;
  if (cxGridCTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := IBCQueryC.FieldByName('FLG_CLOSED').AsInteger = 1;

    fNew := not FLG_CLOSED;
    if (cxGridFilesTable.DataController.RecNo > 0) then
    begin
      fDelete := not FLG_CLOSED;
      fSave := True;
    end;
  end;
  bbFileNew.Enabled := fNew;
  bbFileDelete.Enabled := fDelete;
  bbFileSave.Enabled := fSave;
end;

function TfrmContractsDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if Assigned(cxGridCTable.Controller.FocusedRecord) and CheckSelection then
  begin
    try
      if IBCTrUpdate.Active then
        IBCTrUpdate.Commit;
    except
      on E: Exception do
      begin
        IBCTrUpdate.Rollback;
        raise;
      end;
    end;

    if (Date <= IBCQueryC.FieldByName('EXPIRE_DATE').AsDateTime) then
    begin
      fContractID := IBCQueryC.FieldByName('CONTRACTID').AsInteger;
      fContractCode := IBCQueryC.FieldByName('CODE').AsString;
      fContractSignDate := IBCQueryC.FieldByName('SIGN_DATE').AsDateTime;
      fContractCurrencyID := IBCQueryC.FieldByName('CURRENCYID').AsInteger;
      fContractTypeTitle := IBCQueryC.FieldByName('CONTRACT_TYPE_TITLE').asString;
      fContractFLG_ACNT := IBCQueryC.FieldByName('FLG_ACNT').AsInteger;
      Result := True;
    end;
  end;
end;

procedure TfrmContractsDlg.Prepare;
begin
  fLastFilePath := '';

  if not fSelectMode then
  begin
    btnCancel.Caption := 'Inchide';
    btnOk.Visible := False;
  end;

  IBCQueryC.ParamByName('CT').AsInteger := fCT;
  IBCQueryC.Active := True;

  if fContractID > 0 then
    IBCQueryC.Locate('CONTRACTID', fContractID, []);

  IBCQueryFiles.Active := True;
  // start transaction
//  if not IBCTrUpdate.Active then
//    IBCTrUpdate.StartTransaction;

  SelectionChanged;
end;

procedure TfrmContractsDlg.SaveFileFromDB(const ContractFileID: Integer; const TargetDir: string);
var
  Query: TIBCQuery;
  filename: string;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT FILENAME,FILECONTENT FROM TDB_CONTRACT_FILES WHERE CONTRACTFILEID=:ID';
    Query.ParamByName('ID').AsInteger := ContractFileID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      filename := IncludeTrailingPathDelimiter(TargetDir) + Query.Fields[0].AsString;
      TBlobField(Query.Fields[1]).SaveToFile(filename);
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmContractsDlg.SaveSelectedFile;
var
  dir: string;
begin
  dir := fLastFilePath;
  if SelectDirectory('Alegeti calea pentru salvare', '', dir) then
  begin
    SaveFileFromDB(IBCQueryFiles.FieldByName('CONTRACTFILEID').AsInteger, dir);
    fLastFilePath := dir;
  end;
end;

procedure TfrmContractsDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fNew := fSECURITY_Allow;
  fEdit := False;
  fDelete := False;
  if (cxGridCTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := IBCQueryC.FieldByName('FLG_CLOSED').AsInteger = 1;
    fEdit := fSECURITY_Allow and not FLG_CLOSED;
    fDelete := fSECURITY_Allow and not FLG_CLOSED;
  end;
  bbNew.Enabled := fNew;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;

  FileSelectionChanged;
end;

procedure TfrmContractsDlg.SetContractID(const Value: integer);
begin
  fContractID := Value;
end;

procedure TfrmContractsDlg.SetCT(const Value: integer);
begin
  fCT := Value;
end;

procedure TfrmContractsDlg.SetSelectMode(const Value: Boolean);
begin
  fSelectMode := Value;
end;

procedure TfrmContractsDlg.SetupSecurityItems;
begin
  fSECURITY_Allow := SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование);
  if not fSECURITY_Allow then
  begin
    bbNew.Visible := ivNever;
    bbEdit.Visible := ivNever;
    bbDelete.Visible := ivNever;
    dxBarManager1Bar1.Visible := False;
    dxBarDockControl1.Visible := False;
  end;
end;

procedure TfrmContractsDlg.ShowAddNewFileDialog;
var
  dialog: TfrmCustomerContractFileEditorDlg;
begin
  dialog := TfrmCustomerContractFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.ContractID := IBCQueryC.FieldByName('CONTRACTID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContractsDlg.ShowCreateNewContractDialog;
var
  dialog: TfrmCustomerContractEditorDlg;
begin
  dialog := TfrmCustomerContractEditorDlg.Create(Self, IBCQueryC, IBCDataSourceC);
  try
    dialog.CreateNewRecord := True;
    dialog.CT := fCT;
    dialog.DisableCT;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmContractsDlg.ShowModifyContractDialog;
var
  dialog: TfrmCustomerContractEditorDlg;
begin
  dialog := TfrmCustomerContractEditorDlg.Create(Self, IBCQueryC, IBCDataSourceC);
  try
    dialog.CreateNewRecord := False;
    dialog.CT := fCT;
    dialog.DisableCT;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

{ TCustomerDefultContractInfo }

constructor TCustomerDefultContractInfo.Create(AOwner: TComponent; ACustomerID: Integer; ADocDate: Double);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Clear;
    Query.SQL.Add('select C.* from VW_TDB_CONTRACTS C');
    Query.SQL.Add('inner join TS_CUST_1C CC on CC.CUSTOMERID = C.DT');
    Query.SQL.Add('inner join SP_GET_ORG(12057) Z on Z.ORGID = CC.DT');
    Query.SQL.Add('where C.FLG_DEFAULT = 1 and C.CT = :CT and c.expire_date >= :DATA and c.sign_date <=:data');
    Query.ParamByName('CT').AsInteger := ACustomerID;
    Query.ParamByName('DATA').AsDate := ADocDate;

    Query.ExecSQL;
    if not Query.Eof then
    begin
             // got single record
      ContractTypeTitle := Query.FieldByName('CONTRACT_TYPE_TITLE').AsString;
      Code := Query.FieldByName('CODE').AsString;
      SignDate := Query.FieldByName('SIGN_DATE').AsDateTime;
      ContractID := Query.FieldByName('CONTRACTID').AsInteger;
      FLG_ACNT := Query.FieldByName('FLG_ACNT').AsInteger = 1;
      CurrencyID := Query.FieldByName('CURRENCYID').AsInteger;
    end
  finally
    Query.Free;
  end;
end;

destructor TCustomerDefultContractInfo.Destroy;
begin
  inherited;
end;

end.


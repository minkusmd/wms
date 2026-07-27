unit frmDocumentBrowserDialog;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  SWNBaseUnit,
  IBC,
  cxGraphics,
  DB,
  cxDBData,
  Menus,
  StdCtrls,
  cxButtons,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridDBTableView,
  cxGrid,
  cxDropDownEdit,
  cxTextEdit,
  cxDBLookupComboBox,
  ExtCtrls,
  DialogTitle,
  cxCalc,
  cxButtonEdit,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCheckBox,
  cxLabel,
  cxCurrencyEdit,
  cxImageComboBox,
  MemDS,
  DBAccess,
  cxGridTableView,
  cxClasses,
  cxGridCustomView,
  cxMaskEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  dxUIAClasses,
  dxCoreGraphics;

type
  TfrmDocumentBrowserDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    Panel1: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    lcbDocType: TcxLookupComboBox;
    cmbDate: TcxComboBox;
    lcbFirma: TcxLookupComboBox;
    lcbUser: TcxLookupComboBox;
    cxGridDocsDB: TcxGridDBTableView;
    cxGridDocsLevel: TcxGridLevel;
    cxGridDocs: TcxGrid;
    cxGridDocsDB_DOCID: TcxGridDBColumn;
    cxGridDocsDB_DT_NAME: TcxGridDBColumn;
    cxGridDocsDB_DTDEP_NAME: TcxGridDBColumn;
    cxGridDocsDB_SUMA: TcxGridDBColumn;
    cxGridDocsDB_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocsDB_RATE: TcxGridDBColumn;
    cxGridDocsDB_FLG_ACNT: TcxGridDBColumn;
    cxGridDocsDB_DATA: TcxGridDBColumn;
    cxGridDocsDB_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocsDB_DOCTYPE_NAME: TcxGridDBColumn;
    IBCDataSourceFirms: TIBCDataSource;
    IBCQueryFirms: TIBCQuery;
    IBCDataSourceDocTypes: TIBCDataSource;
    IBCQueryDocTypes: TIBCQuery;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    Bevel1: TBevel;
    cxGridDocsDB_CT_NAME: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoodsTable: TcxGridDBTableView;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_GOODS_NAME: TcxGridDBColumn;
    cxGridGoods_UM_NAME: TcxGridDBColumn;
    cxGridGoods_QTY: TcxGridDBColumn;
    cxGridGoods_IMG: TcxGridDBColumn;
    cxGridDocs_FLG_CLOSED: TcxGridDBColumn;
    Label1: TLabel;
    beCT: TcxButtonEdit;
    cxGridGoods_DEP_NAME: TcxGridDBColumn;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure cxGridDocsDBFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDocsDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsDB_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fDefaultDocTypeID: Integer;
    fDefaultFirmaID: Integer;
    fDefaultUserID: Integer;
    fDefaultCT: integer;
    fDocID: integer;
    fDocDocTypeName: string;
    fDocSuma: Currency;
    fDocRate: single;
    fDocCurrency_Name: string;
    fDocDT: string;
    fDocCT: string;
    fCT, fSupplierID: integer;
    FHasNoChildDocTypeID: Integer;

    procedure CreateDateFilter;
    procedure SetDefaultValues;
    procedure OpenDocDataByFilter;

    procedure WhenFilterChanged(Sender: TObject);
    procedure SetDefaultDocTypeID(const Value: integer);
    procedure SetDefaultFirmaID(const Value: integer);
    procedure SetDefaultCT(const Value: integer);
    procedure SetFixedDocTypeID(const Value: Boolean);
    procedure SetFixedFirmaID(const Value: Boolean);
    procedure SetDefaultUserID(const Value: integer);
    procedure SetFixedUserID(const Value: Boolean);
    procedure SetDocID(const Value: integer);

    procedure SelectionChanged;
    procedure SetFixedDate(const Value: Boolean);
    procedure SetHasNoChildDocTypeID(const Value: Integer);
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;

    procedure LoadStates; override;
    procedure SaveStates; override;

  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); override;

    property DefaultDocTypeID: integer write SetDefaultDocTypeID;
    property FixedDocTypeID: Boolean write SetFixedDocTypeID;

    property DefaultFirmaID: integer write SetDefaultFirmaID;
    property FixedFirmaID: Boolean write SetFixedFirmaID;

    property DefaultUserID: integer write SetDefaultUserID;
    property FixedUserID: Boolean write SetFixedUserID;

    property FixedDate: Boolean write SetFixedDate;

    property DefaultCT: integer write SetDefaultCT;

    property DocID: integer read fDocID write SetDocID;
    property DocDocTypeName: string read fDocDocTypeName;
    property DocSuma: Currency read fDocSuma;
    property DocCurrency_Name: string read fDocCurrency_Name;
    property DocRate: single read fDocRate;
    property DocDT: string read fDocDT;
    property DocCT: string read fDocCT;
    property HasNoChildDocTypeID: Integer read FHasNoChildDocTypeID write SetHasNoChildDocTypeID;
  end;

implementation

uses
  DataModuleAdditions,
  SWNConst,
  DataModuleDB,
  SWNSearchUnit,
  SWNUtils,
  SWNValueStorageUnit,
  SWNDocumentFilters,
  frmCustomersDlg;

{$R *.dfm}

{ TfrmDocumentBrowserDlg }

procedure TfrmDocumentBrowserDlg.beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  fCT := -1;
  try
    if dialog.SelectCustomer(fCT, false, 0, 'Alegeti subdiviziunea') then
    begin
      beCT.Text := dialog.CustomerTitle;
      fCT := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

constructor TfrmDocumentBrowserDlg.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
  inherited;
  HasNoChildDocTypeID := -1;
end;

procedure TfrmDocumentBrowserDlg.CreateDateFilter;
var
  i: TFrameDocumentDateFilter;
  filterObject: TDocumentDateFilterItem;
  N: Integer;
begin
  cmbDate.Properties.Items.BeginUpdate;
  try
    cmbDate.Properties.Items.Clear;
    for i in cDocumentAllFilters do
    begin
      filterObject := SWNDocumentFrameDateFilters.GetFilterObject(i);
      N := cmbDate.Properties.Items.AddObject(filterObject.Title, filterObject);
      if (i = cDocumentDefaultFilter) then
        cmbDate.ItemIndex := N;
    end;
  finally
    cmbDate.Properties.Items.EndUpdate;
  end;
end;

procedure TfrmDocumentBrowserDlg.cxGridDocsDBCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridDocsDB_FLG_ACNT.Index]) then
  begin
          // contabilitate
    if not AViewInfo.Selected then
    begin
      if AViewInfo.GridRecord.Values[cxGridDocsDB_FLG_ACNT.Index] = 1 then
        ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
    end;
  end;

  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure TfrmDocumentBrowserDlg.cxGridDocsDBFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmDocumentBrowserDlg.cxGridDocsDB_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocsDB_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsDB_DATA.Index]);
end;

procedure TfrmDocumentBrowserDlg.BindingDataSource;
begin
  inherited;

  fDefaultDocTypeID := dmDB.CurrentDocTypeID;
  fDefaultFirmaID := dmDB.CurrentFirma;
  fDefaultUserID := dmDB.CurrentUserID;

  fDefaultCT := -1;

  fDocID := -1;
  fDocDocTypeName := '';
  fDocSuma := 0;

  IBCQueryDocTypes.Connection := fIBCConnection;
  IBCQueryFirms.Connection := fIBCConnection;
  IBCQueryUsers.Connection := fIBCConnection;
  IBCQueryDocs.Connection := fIBCConnection;

  CreateDateFilter;
end;

function TfrmDocumentBrowserDlg.IsFormDataPosted: Boolean;
begin
  fDocID := IBCQueryDocs.FieldByName('DOCID').AsInteger;
  fDocDocTypeName := IBCQueryDocs.FieldByName('DOCTYPE_NAME').AsString;
  fDocSuma := IBCQueryDocs.FieldByName('SUMA').AsCurrency;
  fDocRate := IBCQueryDocs.FieldByName('RATE').AsFloat;
  fDocCurrency_Name := IBCQueryDocs.FieldByName('CURRENCY_NAME').AsString;
  fDocDT := IBCQueryDocs.FieldByName('DT_NAME').AsString;
  fDocCT := IBCQueryDocs.FieldByName('CT_NAME').AsString;

  Result := True;
end;

procedure TfrmDocumentBrowserDlg.LoadStates;
var
  qtyDigitsMode: Integer;
begin
  inherited;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
    (Self) then
    Position := poDesigned;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDocsDB);

     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Количество
  TcxCalcEditProperties(cxGridGoods_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TfrmDocumentBrowserDlg.OpenDocDataByFilter;
var
  f1, f2, f3, f4, f5: Boolean;
  S: string;
  d1, d2: TDateTime;
  filterObject: TDocumentDateFilterItem;
begin
     // close active
  IBCQueryJurnal.Close;
  IBCQueryDocs.Close;

     // create filter
  f1 := False;
  f2 := False;
  f3 := False;
  f4 := False;
  f5 := false;
  S := '';

     // filter dupa ct (la adaugarea in documente sa fie acelas ct) prihodnaya naklanaya po buhgalterii
  if (fDefaultCT <> -1) then
  begin
    AddConditionToWHERE(S, 'CT=:CT');
    f5 := True;
  end;

  if (lcbDocType.EditValue <> NULL) and (lcbDocType.EditValue > 0) then
  begin
    AddConditionToWHERE(S, 'DOCTYPEID=:DOCTYPE');
    f1 := True;
  end;

  if (lcbFirma.EditValue <> NULL) and (lcbFirma.EditValue > 0) then
  begin
    AddConditionToWHERE(S, 'DT=:FIRMA');
    f2 := True;
  end;

  if HasNoChildDocTypeID > 0 then
    if (lcbUser.EditValue <> NULL) and (lcbUser.EditValue > 0) then
    begin
      AddConditionToWHERE(S, 'CREATED_BY=:USER');
      f3 := True;
    end;

  if cmbDate.ItemIndex <> -1 then
  begin
    filterObject := TDocumentDateFilterItem(cmbDate.Properties.Items.Objects[cmbDate.ItemIndex]);
    f4 := GetDocumentFrameFilterDateValues(filterObject.Filter, d1, d2);
    if f4 then
    begin
      AddConditionToWHERE(S, 'CAST(DATA AS DATE)>=:Date1');
      AddConditionToWHERE(S, 'CAST(DATA AS DATE)<=:Date2');
    end;
  end;

     // apply filter
  IBCQueryDocs.FilterSQL := S;

     // set params
  if f1 then
    IBCQueryDocs.ParamByName('DOCTYPE').asInteger := lcbDocType.EditValue;
  if f2 then
    IBCQueryDocs.ParamByName('FIRMA').asInteger := lcbFirma.EditValue;
  if f3 then
    IBCQueryDocs.ParamByName('USER').asInteger := lcbUser.EditValue;
  if f4 then
  begin
    IBCQueryDocs.ParamByName('Date1').AsDate := d1;
    IBCQueryDocs.ParamByName('Date2').AsDate := d2;
  end;
  if f5 then
    IBCQueryDocs.ParamByName('CT').Asinteger := FDefaultCT;


     // open data
  IBCQueryDocs.Active := True;
  if fDocID <> -1 then
  begin
    IBCQueryDocs.Locate('DOCID', fDocID, []);
    fDocID := -1;
  end;
  IBCQueryJurnal.Active := True;
end;

procedure TfrmDocumentBrowserDlg.Prepare;
begin
  try
        // open data
    IBCQueryDocTypes.Active := True;
    IBCQueryFirms.Active := True;
    IBCQueryUsers.Active := True;

        // set default values
    SetDefaultValues;

    SelectionChanged;
    OpenDocDataByFilter;

    cxGridDocsDB_CT_NAME.Focused := true;

  except
    IBCQueryUsers.Active := False;
    IBCQueryFirms.Active := False;
    IBCQueryDocTypes.Active := False;

    raise;
  end;
end;

procedure TfrmDocumentBrowserDlg.SaveStates;
begin
  inherited;
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDocsDB);
end;

procedure TfrmDocumentBrowserDlg.SelectionChanged;
begin
  btnOk.Enabled := cxGridDocsDB.DataController.RecNo > 0;
end;

procedure TfrmDocumentBrowserDlg.SetDefaultCT(const Value: integer);
begin
  FDefaultCT := Value;
end;

procedure TfrmDocumentBrowserDlg.SetDefaultDocTypeID(const Value: integer);
begin
  fDefaultDocTypeID := Value;
end;

procedure TfrmDocumentBrowserDlg.SetDefaultFirmaID(const Value: integer);
begin
  fDefaultFirmaID := Value;
end;

procedure TfrmDocumentBrowserDlg.SetDefaultUserID(const Value: integer);
begin
  fDefaultUserID := Value;
end;

procedure TfrmDocumentBrowserDlg.SetDefaultValues;
begin
//     IBCQueryDocTypes.Locate('DOCTYPEID',fDefaultDocTypeID,[]);
  lcbDocType.EditValue := fDefaultDocTypeID; //IBCQueryDocTypes.FieldByName('DOCTYPEID').asInteger;

//     IBCQueryFirms.Locate('CUSTOMERID',fDefaultFirmaID,[]);
  lcbFirma.EditValue := fDefaultFirmaID; //IBCQueryFirms.FieldByName('CUSTOMERID').asInteger;

//     IBCQueryUsers.Locate('USERID',fDefaultUserID,[]);
  lcbUser.EditValue := fDefaultUserID; //IBCQueryUsers.FieldByName('USERID').asInteger;

     // set event handlers
  cmbDate.Properties.OnChange := WhenFilterChanged;
  lcbDocType.Properties.OnChange := WhenFilterChanged;
  lcbFirma.Properties.OnChange := WhenFilterChanged;
  lcbUser.Properties.OnChange := WhenFilterChanged;
end;

procedure TfrmDocumentBrowserDlg.SetDocID(const Value: integer);
begin
  fDocID := Value;
end;

procedure TfrmDocumentBrowserDlg.SetFixedDate(const Value: Boolean);
begin
  cmbDate.Enabled := not Value;
end;

procedure TfrmDocumentBrowserDlg.SetFixedDocTypeID(const Value: Boolean);
begin
  lcbDocType.Enabled := not Value;
end;

procedure TfrmDocumentBrowserDlg.SetFixedFirmaID(const Value: Boolean);
begin
  lcbFirma.Enabled := not Value;
end;

procedure TfrmDocumentBrowserDlg.SetFixedUserID(const Value: Boolean);
begin
  lcbUser.Enabled := not Value;
end;

procedure TfrmDocumentBrowserDlg.SetHasNoChildDocTypeID(const Value: Integer);
begin
  FHasNoChildDocTypeID := Value;
end;

procedure TfrmDocumentBrowserDlg.WhenFilterChanged(Sender: TObject);
begin
  OpenDocDataByFilter;
end;

end.


unit frame09NakladniePNUnit;
{
  НАКЛАДНЫЕ. Приход товара управленческий
  DocTypeID = 106
  Frame Index = 9
}

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
  System.UITypes,
  Dialogs,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxStyles,
  cxGraphics,
  DB,
  cxDBData,
  dxBar,
  DBAccess,
  IBC,
  cxPC,
  ExtCtrls,
  cxSplitter,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  cxGridPopupMenu,
  cxCalc,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCheckBox,
  cxCurrencyEdit,
  cxLabel,
  cxImageComboBox,
  dxBarBuiltInMenu,
  cxGridCustomPopupMenu,
  MemDS,
  cxClasses,
  dxUIAClasses;

type
  Tframe09NakladniePN = class(TSWNBaseFrame)
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPN_DATA: TcxGridDBColumn;
    cxGridNPN_DTDEP_NAME: TcxGridDBColumn;
    cxGridNPN_CT_NAME: TcxGridDBColumn;
    cxGridNPN_SUMA: TcxGridDBColumn;
    cxGridNPN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPN_RATE: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPNTableFlgACNT: TcxGridDBColumn;
    cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    cxPageControlGeneral: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsExpenses: TcxTabSheet;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsModify: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    bbGoodsSerialPartNumbers: TdxBarButton;
    cxGridExpenses: TcxGrid;
    cxGridExpensesTable: TcxGridDBTableView;
    cxGridExpenses_NAME: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_SUMA: TcxGridDBColumn;
    cxGridExpensesLevel: TcxGridLevel;
    cxGridExpenses_EXPENSE_DOC_CURRENCY_NAME: TcxGridDBColumn;
    cxGridExpenses_RATE: TcxGridDBColumn;
    IBCQueryExpenses: TIBCQuery;
    IBCDataSourceExpenses: TIBCDataSource;
    cxGridComponents: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
    cxGridDBCol_WARRANTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    pmPopupMenuGoods: TdxBarPopupMenu;
    cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn;
    cxGridGoods_PRICE: TcxGridDBColumn;
    cxGridGoods_SUMA: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbExpenseNew: TdxBarButton;
    bbExpenseModify: TdxBarButton;
    bbExpenseDelete: TdxBarButton;
    dxBarPopupMenuDoc: TdxBarPopupMenu;
    bbActionRashodniiKasoviiOrder: TdxBarButton;
    bbActionPlatejnoePorucenie: TdxBarButton;
    cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridNPN_SC2_NAME: TcxGridDBColumn;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxGridGoods_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridGoods_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    bbGoodsForeignCode: TdxBarButton;
    bbGoodsInfoCard: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    cxGridPopupMenuGOODS: TcxGridPopupMenu;
    cxGridGoodsCOST: TcxGridDBColumn;
    cxGridNPN_DTSC_NAME: TcxGridDBColumn;
    cxGridExpenses_CT_NAME: TcxGridDBColumn;
    cxGridExpensesSuma_USD: TcxGridDBColumn;
    cxGridExpenses_CURSDOC_USD: TcxGridDBColumn;
    bbNewFile: TdxBarButton;
    bbFileDelete: TdxBarButton;
    bbFileSaveAs: TdxBarButton;
    tbsFiles: TcxTabSheet;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_DATA: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManagerBar3: TdxBar;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    bbImportAmb: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    bbActCasare: TdxBarButton;
    dxBarButton3: TdxBarButton;
    cxGridNPN_SUMA_MDL: TcxGridDBColumn;
    bbImportDocument: TdxBarButton;
    cxGridGoodsTableColumn1: TcxGridDBColumn;
    bbRequestPayment: TdxBarButton;
    cxGridNPN_FLG_FACTURA_FISCALA: TcxGridDBColumn;
    dxBarButton4: TdxBarButton;
    bbCreateVanzarePrime: TdxBarButton;
    cxGridNPNTableCT: TcxGridDBColumn;
    dxBarButton5: TdxBarButton;
    bbAcntName: TdxBarButton;
    procedure bbAcntNameClick(Sender: TObject);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsModifyClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbGoodsSerialPartNumbersClick(Sender: TObject);
    procedure bbExpenseNewClick(Sender: TObject);
    procedure bbExpenseModifyClick(Sender: TObject);
    procedure bbExpenseDeleteClick(Sender: TObject);
    procedure bbActionRashodniiKasoviiOrderClick(Sender: TObject);
    procedure bbActionPlatejnoePorucenieClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbChangeEnterPriceClick(Sender: TObject);
    procedure dxBarPopupMenuDocPopup(Sender: TObject);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbNewFileClick(Sender: TObject);
    procedure bbFileSaveAsClick(Sender: TObject);
    procedure bbFileDeleteClick(Sender: TObject);
    procedure cxGridGoods_GOODS_ACNT_IDStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbImportAmbClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbActCasareClick(Sender: TObject);
    procedure bbCreateVanzarePrimeClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure bbImportDocumentClick(Sender: TObject);
    procedure bbRequestPaymentClick(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: Integer;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure ExpenseSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteGoodsDialog;
    procedure ShowNewExpenseDialog;
    procedure ShowModifyExpenseDialog;
    procedure ShowDeleteExpenseDialog;
    procedure ShowInputSerialNumbersDialog(const ViewOnly: Boolean);
    procedure ShowInputPartNumbersDialog(const ViewOnly: Boolean);
    procedure DoActionRashodniiKasoviiOrder;
    procedure DoActionPlatejnoePorucenie;
    function DoActionZakritiNakladnuiu(const DocID: Integer): Boolean;
    function DoActionOtkritiNakladnuiu(const DocID: Integer): Boolean;
    function DoDBAction(const ActionID: Integer; const DOCID, CurrencyID, FLG_ACNT: Integer; const Rate: Single; const
      SUMA: Currency): Boolean;
    function DoActionDB_IzmenitiPrihodnuiuTenu(const DOCID: Integer): Boolean;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
    procedure SetuQtyFields;
    procedure SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
    function DoActionImportGoodsFromDoc(const SourceDocID: Integer): Integer;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure CreateNewRecord; override;
    function DBImportGoodsFromDocument(TargetDocID, SourceDocID: Integer): Boolean;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure DoCreateRashodnaiaNakladnaya;
    procedure DoImportFromDocument;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure UpdateGoodsAcntID(GoodsID, GoodsAcntID: Integer; GoodsAcntTitle:
        string);
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNCommonDialogs, SWNConst, SWNDBErrors, SWNSecurity, SWNSecurityFlags, SWNTypes,
  SWNUtils, SWNValueStorageUnit, frm53RPPFileEditorDialog, frmCerereDePlataDialog, frmCustomersDlg,
  frmDocumentAMBImportBrowserDialog, frmDocumentImportBrowserDialog, frmGoodsACNTBrowser, frmGoodsImageViewerUnit,
  frmListofJurnalGoodsUnit, frmMoneyIncomeDialog, frmNakladnaiaPNDocDialog, frmNakladnaiaPNExpenseDialog,
  frmPartNumbersDialog, frmSelectGoodsToAddDialog, frmSellInvoiceProductsToCompanyUnit, frmSerialNumbersDialog,
  Generics.Collections;

var
  frmGoodsImageViewer: TfrmGoodsImageViewer;

{$R *.dfm}

procedure Tframe09NakladniePN.bbAcntNameClick(Sender: TObject);
var
  goodsACNT: TfrmGoodsACNTDlg;
begin
  goodsACNT := TfrmGoodsACNTDlg.Create(Self);
  try
    if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной) then
    begin
      AppUserConfigStorage.OpenSection(Self.Name + 'GOODS_ACNT_ID');
      try
        AppUserConfigStorage.IntValues.GetValue(Self.Name + 'GOODS_ACNT_ID', goodsACNT.GoodsAcntID)//          store column visibility and width
      finally
        AppUserConfigStorage.CloseSection;
      end;

      if goodsACNT.SelectGoodsAcnt(dmdb.ibcqueryjurnal.FieldByName('GOODS_ACNT_ID').AsInteger) then
      begin
        UpdateGoodsAcntID(dmdb.ibcqueryjurnal.FieldByName('GOODSID').AsInteger, goodsACNT.GoodsAcntID, goodsACNT.GoodsAcntTitle);

        AppUserConfigStorage.OpenSection(Self.Name + 'GOODS_ACNT_ID');
        try
          AppUserConfigStorage.IntValues.SetValue(Self.Name + 'GOODS_ACNT_ID', goodsACNT.GoodsAcntID)//          store column visibility and width
        finally
          AppUserConfigStorage.CloseSection;
        end;

      end;
    end
    else
    begin
      // deschidem doar cu codul de contabilitate, fara a face update in tdb_jurnal si in ts_goods
      goodsACNT.BrowseGoodsACNT(dmdb.IBCQueryJurnal.FieldByName('GOODS_ACNT_ID').AsInteger);
    end;
  finally
    goodsACNT.Free;
  end;
end;

{ Tframe09NakladniePN }

procedure Tframe09NakladniePN.bbGoodsSerialPartNumbersClick(Sender: TObject);
var
  FLG_CLOSED: Boolean;
  snType: Integer;
begin
  snType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

  if snType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowInputSerialNumbersDialog(FLG_CLOSED)
  else if snType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowInputPartNumbersDialog(FLG_CLOSED);
end;

procedure Tframe09NakladniePN.bbImportAmbClick(Sender: TObject);
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
//    dialog.DefaultDocTypeID := dmDB.CurrentDocTypeID;
//    dialog.DefaultFirmaID := dmDB.CurrentFirma;
//    dialog.DefaultUserID := dmDB.CurrentUserID;
    dialog.DocTypeList.Add(107); // Vinzare
//    dialog.DocTypeList.Add(3089); // Vinzare
    if dialog.SelectDoc then
    begin
      if DoActionImportGoodsFromDoc(dialog.DocID) > 0 then
      begin
        RefreshData;
        ShowInfoDialog('Import', 'Import din document finisat!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.bbImportDocumentClick(Sender: TObject);
begin
  inherited;
  DoImportFromDocument;
end;

function Tframe09NakladniePN.DoActionImportGoodsFromDoc(const SourceDocID: Integer): Integer;
var
  Query: TIBCQuery;
begin
  Result := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'SELECT NEW_DOCID FROM SP_CREATE_PRIHOD_TOVARA(:DOCID, 1, :current_docid)';
      Query.Params.ParamByName('DOCID').AsInteger := SourceDocID;
      Query.Params.ParamByName('Current_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ExecSQL;
      if not Query.Eof then
        Result := Query.FieldByName('NEW_DOCID').AsInteger;
      Query.Transaction.Commit;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(e) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe09NakladniePN.bbGoodsModifyClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe09NakladniePN.bbGoodsNewClick(Sender: TObject);
begin
  ShowNewGoodsDialog;
end;

procedure Tframe09NakladniePN.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe09NakladniePN.bbActCasareClick(Sender: TObject);
var
  dialog: TfrmListOfJurnalGoodsDialog;
begin
  dialog := TfrmListOfJurnalGoodsDialog.Create(Owner, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.bbActionPlatejnoePorucenieClick(Sender: TObject);
begin
  DoActionPlatejnoePorucenie;
end;

procedure Tframe09NakladniePN.bbActionRashodniiKasoviiOrderClick(Sender: TObject);
begin
  DoActionRashodniiKasoviiOrder;
end;

procedure Tframe09NakladniePN.bbChangeEnterPriceClick(Sender: TObject);
begin
  if ShowAskDialog('Primire marfa', 'Doriti sa modificati pretul in nomenclator?') = mrYes then
  begin
    if DoActionDB_IzmenitiPrihodnuiuTenu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.RefreshJurnal;
  end;
end;

procedure Tframe09NakladniePN.bbCreateVanzarePrimeClick(Sender: TObject);
begin
  DoCreateRashodnaiaNakladnaya;
end;

procedure Tframe09NakladniePN.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe09NakladniePN.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe09NakladniePN.bbExpenseDeleteClick(Sender: TObject);
begin
  ShowDeleteExpenseDialog;
end;

procedure Tframe09NakladniePN.bbExpenseModifyClick(Sender: TObject);
begin
  ShowModifyExpenseDialog;
end;

procedure Tframe09NakladniePN.bbExpenseNewClick(Sender: TObject);
begin
  ShowNewExpenseDialog;
end;

procedure Tframe09NakladniePN.bbGoodsDeleteClick(Sender: TObject);
begin
  ShowDeleteGoodsDialog
end;

procedure Tframe09NakladniePN.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe09NakladniePN.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe09NakladniePN.CreateNewRecord;
var
  dialog: TfrmNakladnaiaPNDocDlg;
begin
  dialog := TfrmNakladnaiaPNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    if dialog.ShowModal = mrOk then
    begin
      DocumentSelectionChanged;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe09NakladniePN.cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbExpenseModify.Enabled then
  begin
    ShowModifyExpenseDialog;
    AHandled := True;
  end;
end;

procedure Tframe09NakladniePN.cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridExpensesTable, Key, Shift);
end;

procedure Tframe09NakladniePN.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (not SWNSecurityManager.IsLimitedUser and bbGoodsModify.Enabled) then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe09NakladniePN.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe09NakladniePN.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  swnutils.ProcessCommonKeys(self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe09NakladniePN.cxGridGoods_GOODS_ACNT_IDStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if (ARecord.Values[cxGridGoods_GOODS_ACNT_ID.Index] = -1) then
  begin
    AStyle := dmAdditions.cxStyle_TextBoldRed;
  end;

end;

procedure Tframe09NakladniePN.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe09NakladniePN.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridNPNTableFlgACNT.Index] = 1 then
          ACanvas.Font.Color := clRed
        else
          ACanvas.Font.Color := clBlack;
      end;
    end
    else
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridNPNTableFlgACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := clHighlight;
//    ACanvas.Font.Color := clWhite;
  end;
end;

procedure Tframe09NakladniePN.cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_DATA.Index]);
end;

procedure Tframe09NakladniePN.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(self, cxGridNPNTable, Key, Shift);
end;

procedure Tframe09NakladniePN.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Dosriti sa stergeti inregistrarea cu numarul %d?', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').asInteger])) = mrYes then
  begin
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryDocs.Delete;
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

function Tframe09NakladniePN.DoActionDB_IzmenitiPrihodnuiuTenu(const DOCID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
           // Изменить приходную цену в справочнике
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_GOODS_PRICE_FROM_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DOCID;
           // exec
      Query.ExecSQL;
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

function Tframe09NakladniePN.DoActionOtkritiNakladnuiu(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_INCOME_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ExecSQL;
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

procedure Tframe09NakladniePN.DoActionPlatejnoePorucenie;
var
  dialog: TfrmMoneyIncomeDlg;
  docID: Integer;
begin
  docID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de plata', 'dispozitiei de plata');

    if dialog.ShowModal = mrOk then
    begin
             // Платежное поручение
      DoDBAction(2, docID, dialog.CurrencyID, dialog.FLG_ACNT, dialog.Rate, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.DoActionRashodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Ordin de plata in numerar', 'ordinului de plata in numerar');

    if dialog.ShowModal = mrOk then
    begin
      DoDBAction(1, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger,
        dialog.Rate, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe09NakladniePN.DoActionZakritiNakladnuiu(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_INCOME_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ExecSQL;
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

procedure Tframe09NakladniePN.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  DocChanged: Boolean;
  FLG_CLOSED: Boolean;
  fRashod, fPlatej, fCloseDoc, fOpenDoc: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;

  fRashod := False;
  fPlatej := False;
  fCloseDoc := False;
  fOpenDoc := False;

  DocChanged := True;

  if cxGridNPNTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := (fSECURITY_CanEdit and not FLG_CLOSED) or fSECURITY_CanNew;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;

    DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fRashod := True;  // Расходный кассовый ордер
    fPlatej := True;  // Платежное поручение
    fCloseDoc := not FLG_CLOSED;  // Закрыть накладную
    fOpenDoc := FLG_CLOSED;  // Открыть накладную
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbActionRashodniiKasoviiOrder.Enabled := fRashod;  // Расходный кассовый ордер + Security
  bbActionPlatejnoePorucenie.Enabled := fPlatej;     // Платежное поручение + Security

  ButtonStateChanged(fbtCloseDocument, fCloseDoc);      // Закрыть накладную + Security
  ButtonStateChanged(fbtOpenDocument, fOpenDoc);        // Открыть накладную + Security
  if DocChanged then
    cxPageControlGeneral.ActivePage := tbsGoods;

  GoodsSelectionChanged;
  ExpenseSelectionChanged;
end;

function Tframe09NakladniePN.DoDBAction(const ActionID, DOCID, CurrencyID, FLG_ACNT: Integer; const Rate: Single; const
  SUMA: Currency): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      case ActionID of           // Расходный кассовый ордер
        1:
          begin
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_RKO(:DOCID,:CurrencyID,:FLG_ACNT,:Rate,:SUMA)';
            Query.ParamByName('FLG_ACNT').AsInteger := FLG_ACNT;
          end;
           // Платежное поручение
        2:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_BANK_TRANSFER(:DOCID,:SUMA,:CurrencyID,:Rate)';
      end;
           // set params
      Query.ParamByName('DOCID').AsInteger := DOCID;
      Query.ParamByName('SUMA').AsCurrency := SUMA;
      Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
      Query.ParamByName('Rate').AsFloat := Rate;
           // exec
      Query.ExecSQL;
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

procedure Tframe09NakladniePN.DoFrameHide;
begin
  IBCQueryFiles.Close;
     // inchidem sursele de date interne
  IBCQueryExpenses.Active := False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridExpensesTable.OnFocusedRecordChanged := nil;
  cxGridGoodsTable.OnFocusedRecordChanged := nil;
  cxGridNPNTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridExpensesTable.DataController.DataSource := nil;
  cxGridGoodsTable.DataController.DataSource := nil;
  cxGridNPNTable.DataController.DataSource := nil;

  frmGoodsImageViewer.Free;
  inherited;
end;

procedure Tframe09NakladniePN.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridNPNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridGoodsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;
  cxGridExpensesTable.DataController.DataSource := IBCDataSourceExpenses;

     // 2. Selection handlers
  cxGridNPNTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
  cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
  cxGridExpensesTable.OnFocusedRecordChanged := WhenExpenseGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // si interne
  IBCQueryExpenses.Active := True;
  IBCQueryFiles.Active := True;

     // 4. Selection update
  DocumentSelectionChanged;

end;

procedure Tframe09NakladniePN.bbNewFileClick(Sender: TObject);
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.bbRequestPaymentClick(Sender: TObject);
var
  frmCerereDePlataDlg: TfrmCerereDePlataDlg;
begin
  inherited;
  frmCerereDePlataDlg := TfrmCerereDePlataDlg.Create(Owner, dmdb.IBCConnection);
  try
    frmCerereDePlataDlg.Amount := dmdb.IBCQueryDocs.FieldByName('SUMA').AsFloat;
    frmCerereDePlataDlg.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    frmCerereDePlataDlg.CustomerName := dmdb.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    frmCerereDePlataDlg.PaymentDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    if frmCerereDePlataDlg.ShowModal = mrOK then
      frmCerereDePlataDlg.AddRequestPaymentDocument;
  finally
    frmCerereDePlataDlg.Free;
  end;
end;

procedure Tframe09NakladniePN.bbFileDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('Primire marfa', Format('Doriti sa sterge fisierul "%s"?', [IBCQueryFiles.FieldByName('FILENAME').AsString]))
    = mrYes then
  begin
    IBCQueryFiles.UpdateTransaction.StartTransaction;
    try
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
end;

procedure Tframe09NakladniePN.bbFileSaveAsClick(Sender: TObject);
begin
  with TSaveDialog.Create(Self) do
  try
    FileName := IBCQueryFiles.FieldByName('FILENAME').AsString;
    Filter := '*.*';
    if Execute then
      SaveFileAsDB(FileName, IBCQueryFiles.FieldByName('ATTID').AsInteger);
  finally
    Free;
  end;
end;

function Tframe09NakladniePN.DBImportGoodsFromDocument(TargetDocID, SourceDocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := false;
    Result := False;
    try
      dmDB.IBCTrDefaultUpdate.StartTransaction;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_GOODS_FROM_DOCUMENT(:TARGET_DOCID, :SOURCE_DOCID)';
      Query.ParamByName('TARGET_DOCID').AsInteger := TargetDocID;
      Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
      Query.ExecSQL;
      dmDB.IBCTrDefaultUpdate.Commit;

      Result := True;
    except
      on E: Exception do
      begin
        dmDB.IBCTrDefaultUpdate.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe09NakladniePN.DoCloseDocument(const DocID: Integer);
begin

  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0 then
  begin
    if ShowAskDialog('Primire marfa', 'Doriti sa inchideti documentul?') = mrYes then
    begin
      if DoActionZakritiNakladnuiu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        DocumentSelectionChanged;
        GoodsSelectionChanged;
        ExpenseSelectionChanged;
      end;
    end;
  end
  else
  begin
    if ShowAskDialog('Primire marfa', 'Doriti sa deschideti documentul?') = mrYes then
    begin
      if DoActionOtkritiNakladnuiu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        DocumentSelectionChanged;
        GoodsSelectionChanged;
        ExpenseSelectionChanged;
      end;
    end;
  end;
end;

procedure Tframe09NakladniePN.DoCreateRashodnaiaNakladnaya;
var
  ListDocIDs: TStringList;
  CustomerDialog: TfrmCustomersDlg;
begin
  ListDocIDs := TStringList.Create;
  var q := TIBCQuery.Create(nil);
  CustomerDialog := TfrmCustomersDlg.Create(Self);
  try
    if CustomerDialog.SelectCustomer(-1, false, 5209) then
    begin
      for var i := 0 to cxGridNPNTable.Controller.SelectedRecordCount - 1 do
      begin
        ListDocIDs.Add(cxGridNPNTable.Controller.SelectedRows[i].Values[cxGridNPNTableDocID.Index]);
      end;

      q.AutoCommit := True;
      q.Transaction := dmdb.IBCTrDefaultUpdate;
      if not q.Transaction.Active then
        q.Transaction.StartTransaction;

      q.SQL.Add('execute procedure create_rashod_from_prihod(:ListofDocs, :default_dt, :default_ct)');
      q.ParamByName('listOfDocs').AsString := ListDocIDs.CommaText;
      q.ParamByName('default_dt').AsInteger := dmdb.CurrentFirma;
      q.ParamByName('default_ct').AsInteger := CustomerDialog.CustomerID;

      q.ExecSQL;
      if q.Transaction.Active then
        q.Transaction.Commit;
    end;
  finally
    ListDocIDs.Free;
    q.Free;
    CustomerDialog.Free;
  end;
end;

procedure Tframe09NakladniePN.DoImportFromDocument;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultDocTypeID := cDBID_DocType_НАКЛАДНЫЕ_РН;
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_РН);
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПН);
    if dialog.SelectDoc then
    begin
      if DBImportGoodsFromDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.DocID) then
      begin
        dmdb.IBCQueryJurnal.Refresh;
        ShowInfoDialog('Import din document', 'Finisat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.DoOpenDocument(const DocID: Integer);
begin
  if ShowAskDialog('Primire marfa', 'Doriti sa deschideti documentul?') = mrYes then
  begin
    if DoActionOtkritiNakladnuiu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      DocumentSelectionChanged;
      GoodsSelectionChanged;
      ExpenseSelectionChanged;
    end;
  end;
end;

procedure Tframe09NakladniePN.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  dmDB.IBCQueryJurnal.First;
  dmDB.IBCQueryJurnal.DisableControls;

  while not dmDB.IBCQueryJurnal.Eof do
  begin
    dmDB.IBCQueryJurnal.Edit;
    dmDB.IBCQueryJurnal.FieldByName('FLG_ACTIVE').AsInteger := 1;
    dmDB.IBCQueryJurnal.FieldByName('FLG_ACNT').AsInteger := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger;
    dmDB.IBCQueryJurnal.Post;
    dmDB.IBCQueryJurnal.Next;
  end;
  dmDB.IBCQueryJurnal.EnableControls;

  try
    if dmDB.IBCQueryJurnal.UpdateTransaction.Active then
      dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
  except
    begin
      dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
      raise;
    end;
  end;
//  dmDB.IBCQueryJurnal.Refresh;

end;

procedure Tframe09NakladniePN.dxBarButton2Click(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe09NakladniePN.dxBarButton3Click(Sender: TObject);
begin
  if not Assigned(frmGoodsImageViewer) then
    frmGoodsImageViewer := TfrmGoodsImageViewer.Create(self);

  if frmGoodsImageViewer.Active then
    frmGoodsImageViewer.Close;

  frmGoodsImageViewer.MasterFields := 'GOODSID';
  frmGoodsImageViewer.MasterDataSource := dmDB.IBCDataSourceJurnal;
  frmGoodsImageViewer.FormStyle := fsStayOnTop;
  frmGoodsImageViewer.Connection := dmDB.IBCConnection;
  frmGoodsImageViewer.Show;
end;

procedure Tframe09NakladniePN.dxBarButton4Click(Sender: TObject);
var
  FacturaNo: string;
  st: TIBCQuery;
begin
  // Creaza factura fiscala de intrare
  if InputQuery('Factura fiscala', 'Seria, Numar', FacturaNo) then
  begin
    try
      st := TIBCQuery.Create(Self);
      try
        st.Transaction := dmdb.IBCTrDefaultUpdate;
        st.AutoCommit := true;

        try
          st.SQL.Text := 'execute procedure SP_CREATE_INCOME_FISCAL_INVOICE(:docid, :facturano)';
          st.ParamByName('DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
          st.ParamByName('FacturaNo').AsString := FacturaNo;
          st.ExecSQL;

          MessageDlg('Document creat cu succes!', mtInformation, [mbOK], 0);
        except
          raise;
        end;

        try
          st.SQL.Text := 'EXECUTE PROCEDURE sp_close_income_invoice(:docid)';
          st.ParamByName('DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
          st.ExecSQL;
        except
          MessageDlg('Eroare la inchiderea documentului de intrare', mtInformation, [mbOK], 0);
        end;

      finally
        dmdb.IBCQueryDocs.RefreshRecord;
        st.Free;
      end;
    except
      on e: Exception do
      begin
        MessageDlg('Eroare la crearea documentului!' + sLineBreak + e.Message, mtError, [mbOK], 0);
      end;
    end;
  end;
end;

procedure Tframe09NakladniePN.dxBarButton5Click(Sender: TObject);
begin
  var d := TfrmSellInvoiceProductsToCompanyDlg.Create(self);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure Tframe09NakladniePN.dxBarPopupMenuDocPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe09NakladniePN.ExpenseSelectionChanged;
var
  fExpenseNew, fExpenseEdit, fExpenseDelete: Boolean;
begin
  fExpenseNew := False;
  fExpenseEdit := False;
  fExpenseDelete := False;

  if fSECURITY_CanEdit and (cxGridNPNTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger
    = 0) then
  begin
    fExpenseNew := True; // New Expense + Security
    if (cxGridExpensesTable.DataController.RecNo > 0) then
    begin
               // Дополнительные затраты
      fExpenseEdit := True; // Edit Expense+ Security
      fExpenseDelete := True; // Delete Expense + Security
    end;
  end;
     // expenses
  bbExpenseNew.Enabled := fExpenseNew;
  bbExpenseModify.Enabled := fExpenseEdit;
  bbExpenseDelete.Enabled := fExpenseDelete;
end;

function Tframe09NakladniePN.InitFrameID: Integer;
begin
  Result := 9; // НАКЛАДНЫЕ. Приход товара (Оперативный учет)
  SetuQtyFields;
end;

procedure Tframe09NakladniePN.ModifyRecord;
var
  dialog: TfrmNakladnaiaPNDocDlg;
  canEdit: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  canEdit := (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0) and fSECURITY_CanEdit or SWNSecurityManager.LoggedUser.IsInAdminGroup;

  dialog := TfrmNakladnaiaPNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := not canEdit;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.RefreshJurnal; // refresh all jurnal records
      dmdb.IBCQueryDocComments.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridNPNTable);
    ReadGridColumnsSettings(cxGridGoodsTable);
    ReadGridColumnsSettings(cxGridExpensesTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe09NakladniePN.RefreshData;
begin
  inherited;
  IBCQueryExpenses.Refresh;
  IBCQueryFiles.Refresh;
end;

procedure Tframe09NakladniePN.SaveFileAsDB(const FileName: string; const AttachmentID: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
    Query.ParamByName('ID').AsInteger := AttachmentID;
    Query.ExecSQL;
    if not Query.Eof then
      TBlobField(Query.Fields[0]).SaveToFile(FileName);
  finally
    Query.Free;
  end;
end;

procedure Tframe09NakladniePN.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridNPNTable);
    SaveGridColumnsSettings(cxGridGoodsTable);
    SaveGridColumnsSettings(cxGridExpensesTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe09NakladniePN.SetupDefaultFocus;
begin
     // grid
  cxGridNPN.SetFocus;
     // page
  cxPageControlGeneral.ActivePage := tbsGoods;
     // columns
  cxGridNPN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
  cxGridExpenses_NAME.Focused := True;
end;

procedure Tframe09NakladniePN.SetupSecurityItems;
begin
  if SWNSecurityManager.IsLimitedUser then
  begin
    cxGridPopupMenuDOCS.Grid := nil;
    cxGridPopupMenuGOODS.Grid := nil;
    dxBarManagerBar1.Visible := False;
  end;

  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Удалить);
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_PDB_Creare_document_Vanzare_catre_Prime_Store_SRL) then
    bbCreateVanzarePrime.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Просмотр_цен) then
  begin
// doc
    cxGridNPN_SUMA.Visible := False;
    cxGridNPN_SUMA.VisibleForCustomization := False;
    cxGridNPN_CURRENCY_NAME.Visible := False;
    cxGridNPN_CURRENCY_NAME.VisibleForCustomization := False;
    cxGridNPN_RATE.Visible := False;
    cxGridNPN_RATE.VisibleForCustomization := False;
// goods
    cxGridGoods_PRICE.Visible := False;
    cxGridGoods_PRICE.VisibleForCustomization := False;
    cxGridGoods_SUMA.Visible := False;
    cxGridGoods_SUMA.VisibleForCustomization := False;
// expenses
    cxGridExpenses_EXPENSE_DOC_SUMA.Visible := False;
    cxGridExpenses_EXPENSE_DOC_SUMA.VisibleForCustomization := False;
    cxGridExpenses_EXPENSE_DOC_CURRENCY_NAME.Visible := False;
    cxGridExpenses_EXPENSE_DOC_CURRENCY_NAME.VisibleForCustomization := False;
  end;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_PDB_Stergerea_produselor) then
  begin
    bbGoodsDelete.Visible := ivNever;
    bbExpenseDelete.Visible := ivNever;
    bbFileDelete.Visible := ivNever;
  end;


     // Карточка товара
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode
    then
    bbGoodsInfoCard.Visible := ivNever;

     // Изменить цены товара
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or
    SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPrice.Visible := ivNever;

     // Соответствие товара в других фирмах
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    cxGridNPNTableFlgACNT.VisibleForCustomization := False;
    cxGridNPNTableFlgACNT.Visible := False;
  end;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_PDB_Deschide_documentul) then
  begin
    SetOpenDocumentEnabled(false);
//    bbActionOpenNakladnaia.Enabled := False;
  end;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_PDB_Inchide_documentul) then
  begin
    SetCloseDocumentEnabled(False);
//    bbActionZakritiNakladnuiu.Enabled := False;
  end;

  // Denumire facturi
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной) then
    bbAcntName.Visible := ivNever;

end;

procedure Tframe09NakladniePN.SetuQtyFields;
begin
     // Список товара: Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

function Tframe09NakladniePN.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridGoodsTable.Site.Focused then
  begin
          // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridNPNTable.Site.Focused then
  begin
              // context from Docs
    if cxGridNPN_CT_NAME.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridNPN_DATA.Focused then
    begin
                       // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridNPN_DTDEP_NAME.Focused then
    begin
                           // Склад
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe09NakladniePN.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe09NakladniePN.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe09NakladniePN.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe09NakladniePN.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete: Boolean;
  fGoodsSN, fGoodsSelected: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;
  fGoodsSN := False;
  fGoodsSelected := False;

  if (cxGridNPNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fGoodsNew := not FLG_CLOSED;

    if (cxGridGoodsTable.DataController.RecNo > 0) then
    begin
               // Список товара
      fGoodsEdit := not FLG_CLOSED;
      fGoodsDelete := not FLG_CLOSED;

               // Серийный учет, Партийный учет
      fGoodsSN := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
        cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
        cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
      fGoodsSelected := True;
    end;
  end;

     // goods
  bbGoodsNew.Enabled := fGoodsNew;
  bbGoodsModify.Enabled := fGoodsEdit;
  bbGoodsDelete.Enabled := fGoodsDelete;

  // Scan Files Tabsheet
  bbNewFile.Enabled := False;
  bbFileDelete.Enabled := False;
  bbFileSaveAs.Enabled := False;

  if ((dmDB.IBCQueryDocs.RecNo > 0)) then
  begin
    bbNewFile.Enabled := True;
    bbFileDelete.Enabled := (cxGridFilesTable.DataController.RecNo > 0);
    bbFileSaveAs.Enabled := (cxGridFilesTable.DataController.RecNo > 0);
  end;

  bbGoodsSerialPartNumbers.Enabled := fGoodsSN;
  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;

  ExpenseSelectionChanged;
end;

procedure Tframe09NakladniePN.ShowNewExpenseDialog;
var
  dialog: TfrmNakladnaiaPNExpenseDlg;
begin
  dialog := TfrmNakladnaiaPNExpenseDlg.Create(Self, IBCQueryExpenses, IBCDataSourceExpenses);
  try
    dialog.CreateNewExpense := True;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCTrDefaultUpdate.StartTransaction;
      try
        dmDB.DoActionDB_SP_Expenses2Jurnal(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger); // Приходная накладная
        dmDB.IBCTrDefaultUpdate.Commit;
      except
        on E: Exception do
        begin
          dmDB.IBCTrDefaultUpdate.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ShowNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
     // show dialog
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Просмотр_цен) then
    begin
      dialog.VisibleActions := dialog.VisibleActions - [acChangePrice];
    end;
    if (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактирование_цен)) then
    begin
      dialog.AllowedActions := dialog.AllowedActions - [acChangePrice];
    end;
    if (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактировать_колво)) then
    begin
      dialog.AllowedActions := dialog.AllowedActions - [acChangeQTY];
    end;

    dialog.AddNewGoods := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ShowDeleteExpenseDialog;
var
  S: WideString;
begin
  S := Format('Stergeti cheltuielile aditionale' + #13#10 + '%s ?', [IBCQueryExpenses.FieldByName('EXPENSE_TITLE').AsString]);
  if ShowAskDialog('Primire marfa', S) = mrYes then
  begin
    IBCQueryExpenses.UpdateTransaction.StartTransaction;
    try
      IBCQueryExpenses.Delete;
      dmDB.DoActionDB_SP_Expenses2Jurnal(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger); // Приходная накладная
      IBCQueryExpenses.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryExpenses.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe09NakladniePN.ShowDeleteGoodsDialog;
var
  S, S2, S3: WideString;
begin
  if (dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').asInteger)) then
  begin
    S := 'Stergere complect';
    S3 := 'Va fi sterse complecte!'
  end
  else
  begin
    S := 'Eliminare produse';
    S3 := '';
  end;
  S2 := Format('Eliminarea produselor' + #13#10 + '%s?', [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);

  if ShowAskDialog(S, S2, S3) = mrYes then
  begin
    dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryJurnal.Delete;
      dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
      dmDB.IBCQueryDocs.Refresh;
    except
      on E: Exception do
      begin
        dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe09NakladniePN.ShowInputPartNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmPartNumbersDlg;
begin
  dialog := TfrmPartNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NewPartNoTemplate := CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryJurnal.FieldByName
      ('GOODSID').AsInteger);
    if dialog.ShowModal = mrOk then
    begin
      dmDB.RefreshJurnal;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ShowInputSerialNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NeuronSborkaMode := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.RefreshJurnal;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ShowModifyExpenseDialog;
var
  dialog: TfrmNakladnaiaPNExpenseDlg;
begin
  dialog := TfrmNakladnaiaPNExpenseDlg.Create(Self, IBCQueryExpenses, IBCDataSourceExpenses);
  try
    dialog.CreateNewExpense := False;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCTrDefaultUpdate.StartTransaction;
      try
        dmDB.DoActionDB_SP_Expenses2Jurnal(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger); // Приходная накладная
        dmDB.IBCTrDefaultUpdate.Commit;
      except
        on E: Exception do
        begin
          dmDB.IBCTrDefaultUpdate.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
     // show dialog
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AddNewGoods := False;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Просмотр_цен) then
    begin
      dialog.VisibleActions := dialog.VisibleActions - [acChangePrice];
    end;
    if (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактирование_цен)) then
    begin
      dialog.AllowedActions := dialog.AllowedActions - [acChangePrice];
    end;
    if (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТОУ_Товары_Редактировать_колво)) then
    begin
      dialog.AllowedActions := dialog.AllowedActions - [acChangeQTY];
    end;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe09NakladniePN.UpdateGoodsAcntID(GoodsID, GoodsAcntID: Integer;
    GoodsAcntTitle: string);
begin
  var q:=TIBCQuery.Create(nil);
    try
      q.sql.text := 'update ts_goods set goods_acnt_id = :goods_acnt_id where goodsid = :goodsid';
      q.transaction := dmdb.IBCTrDefaultUpdate;
      q.parambyname('goods_acnt_id').AsInteger := GoodsAcntID;
      q.parambyname('goodsid').AsInteger := GoodsID;
      q.ExecSQL;

      dmdb.IBCQueryJurnal.Refresh;
    finally
      q.Free;
    end;

end;

function Tframe09NakladniePN.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridGoodsTable.DataController.RecordCount - 1 do
  begin
    if cxGridGoodsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure Tframe09NakladniePN.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe09NakladniePN.WhenDocumentPopupMenuOpen;
begin
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe09NakladniePN.WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ExpenseSelectionChanged;
end;

procedure Tframe09NakladniePN.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


unit frame25ScetFakturaUnit;
{
  СЧЕТ ФАКТУРЫ. Счет фактуры
  DocTypeID = 112
  Frame Index = 25
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IBC, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxGraphics, DB, cxDBData, dxBar, ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxPC, DBAccess, cxGridPopupMenu, cxCalc, cxTextEdit, cxVGrid,
  cxDBVGrid, frameScanFiles, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, cxImageComboBox,
  dxBarBuiltInMenu, cxButtonEdit, cxCalendar, cxDBLookupComboBox, cxMemo, cxGridCustomPopupMenu, MemDS, cxClasses,
  cxInplaceContainer, Xml.XMLDoc, Xml.XMLIntf, System.DateUtils, Vcl.Menus, cxContainer, Vcl.StdCtrls, cxButtons,
  dxUIAClasses;

type
  Tframe25ScetFaktura = class(TSWNBaseFrame)
    cxGridSF: TcxGrid;
    cxGridSFTable: TcxGridDBTableView;
    cxGridSFT_DOCID: TcxGridDBColumn;
    cxGridSFT_DATA: TcxGridDBColumn;
    cxGridSFT_DTDEP_NAME: TcxGridDBColumn;
    cxGridSFT_CT_NAME: TcxGridDBColumn;
    cxGridSFT_SUMA: TcxGridDBColumn;
    cxGridSFT_CURRENCY_NAME: TcxGridDBColumn;
    cxGridSFT_VAT: TcxGridDBColumn;
    cxGridSFT_RATE: TcxGridDBColumn;
    cxGridSFT_PARENTDOCID: TcxGridDBColumn;
    cxGridSFT_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridSFLevel: TcxGridLevel;
    cxGridSF_FLG_CLOSED: TcxGridDBColumn;
    cxSplitter: TcxSplitter;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManagerBarGoods: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    dxBarDockControlGoods: TdxBarDockControl;
    cxGridDB_FLG_ACTIVE: TcxGridDBColumn;
    bbModifyInvoice: TdxBarButton;
    bbPrintInvoice: TdxBarButton;
    cxGridSF_FLG_ACNT: TcxGridDBColumn;
    bbActionPrintReceipt: TdxBarButton;
    cxPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsInvoices: TcxTabSheet;
    tbsReceipts: TcxTabSheet;
    dxBarDockControlInvoices: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarDockControlReceipt: TdxBarDockControl;
    dxBarManagerBarReceipt: TdxBar;
    cxGridInvoice: TcxGrid;
    cxGridInvoiceTable: TcxGridDBTableView;
    cxGridInvoiceLevel: TcxGridLevel;
    IBCQueryINVOICES: TIBCQuery;
    IBCDataSourceINVOICES: TIBCDataSource;
    cxGridInvoiceTable_FACTURANO: TcxGridDBColumn;
    cxGridInvoiceTable_TRANSPORTATOR_NAME: TcxGridDBColumn;
    cxGridInvoiceTable_NRMATRICULARE: TcxGridDBColumn;
    cxGridInvoiceTable_NRFOAIEDEPARCURS: TcxGridDBColumn;
    cxGridInvoiceTable_DATA_ELIBERARII: TcxGridDBColumn;
    cxGridInvoiceTable_DELEGAT: TcxGridDBColumn;
    cxGridInvoiceTable_PROCURA_NO: TcxGridDBColumn;
    IBCQueryReceipt: TIBCQuery;
    IBCDataSourceReceipt: TIBCDataSource;
    cxGridReceipts: TcxGrid;
    cxGridReceiptsTable: TcxGridDBTableView;
    cxGridReceipts_IMG: TcxGridDBColumn;
    cxGridReceipts_DATA_ELIBERARII: TcxGridDBColumn;
    cxGridReceipts_NUMAR_BON: TcxGridDBColumn;
    cxGridReceipts_SUMA: TcxGridDBColumn;
    cxGridReceipts_USER_NAME: TcxGridDBColumn;
    cxGridReceipts_FLG_NUMERAR: TcxGridDBColumn;
    cxGridReceipts_FLG_BON_PARTIAL: TcxGridDBColumn;
    cxGridReceipts_FLG_PERSOANA_JURIDICA: TcxGridDBColumn;
    cxGridReceipts_FLAGS: TcxGridDBColumn;
    cxGridReceiptLevel: TcxGridLevel;
    bbCancelReceipt: TdxBarButton;
    cxGridInvoiceTable_IMG: TcxGridDBColumn;
    cxGridInvoiceTable_FLG_CANCELED: TcxGridDBColumn;
    bbNewInvoice: TdxBarButton;
    cxGridSF_RATEUSD: TcxGridDBColumn;
    cxGridInvoiceTable_INVOICEID: TcxGridDBColumn;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    bbDeleteInvoice: TdxBarButton;
    bbDeleteReceipt: TdxBarButton;
    bbGotoParentDoc: TdxBarButton;
    bbCustomerDebts: TdxBarButton;
    bbDebtsNotify: TdxBarButton;
    cxGridReceipts_PRIHOD_DOCID: TcxGridDBColumn;
    cxGridSF_DT: TcxGridDBColumn;
    cxGridSF_CT: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    cxGridDBCol_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridSF_SC2_NAME: TcxGridDBColumn;
    bbBringGoodsFromRashod: TdxBarButton;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridSF_FLG_EXPORTED: TcxGridDBColumn;
    cxGridDBCol_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponentsTableColumn1: TcxGridDBColumn;
    cxGridSF_CREATED_DATE: TcxGridDBColumn;
    bbChangeCasa: TdxBarButton;
    cxGridSF_FLG_NEW_CEC: TcxGridDBColumn;
    bbBringGoodsFromDocs: TdxBarSubItem;
    bbBringGoodsFromCustomDoc: TdxBarButton;
    tbsSborkaComplect: TcxTabSheet;
    dxBarDockSborkaComplect: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbSborkaComplectBringGoods: TdxBarButton;
    bbSborkaComplectAddGoods: TdxBarButton;
    bbSborkaComplectModifyGoods: TdxBarButton;
    bbSborkaComplectRemoveGoods: TdxBarButton;
    cxGridComplect: TcxGrid;
    cxGridComplectTable: TcxGridDBTableView;
    cxGridComplect_DTDEP_NAME: TcxGridDBColumn;
    cxGridComplect_GOODSID: TcxGridDBColumn;
    cxGridComplect_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridComplect_GOODS_NAME: TcxGridDBColumn;
    cxGridComplect_QTY: TcxGridDBColumn;
    cxGridComplect_UM_NAME: TcxGridDBColumn;
    cxGridComplect_PRICE: TcxGridDBColumn;
    cxGridComplect_SUMA: TcxGridDBColumn;
    cxGridComplect_SUMAVAT: TcxGridDBColumn;
    cxGridComplect_FLG_ACTIVE: TcxGridDBColumn;
    cxGridComplect_FLG_READY: TcxGridDBColumn;
    cxGridComplect_FLG_ACNT: TcxGridDBColumn;
    cxGridComplect_WARRANTY: TcxGridDBColumn;
    cxGridComplect_COST: TcxGridDBColumn;
    cxGridComplect_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComplectLevel: TcxGridLevel;
    IBCQueryJurnalKit: TIBCQuery;
    IBCDataSourceJurnalKit: TIBCDataSource;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComplect_UMID: TcxGridDBColumn;
    bbPriceCol0: TdxBarButton;
    bbPriceCol1: TdxBarButton;
    bbPriceCol2: TdxBarButton;
    bbPriceCol3: TdxBarButton;
    bbPriceCol4: TdxBarButton;
    bbPriceCol5: TdxBarButton;
    bbPriceCol6: TdxBarButton;
    bbPriceCol7: TdxBarButton;
    bbSubItemsPriceColumns: TdxBarSubItem;
    bbSubItemsPriceColumnsComplect: TdxBarSubItem;
    bbPriceCol0Complect: TdxBarButton;
    cxGridInvoiceTable_FPDATAELIBERARII: TcxGridDBColumn;
    cxGridComponents_ACNT_QTY: TcxGridDBColumn;
    cxGridComplect_ACNT_QTY: TcxGridDBColumn;
    bbBringGoodsFromMultiSborka: TdxBarButton;
    dxBarPopupMenuGoods: TdxBarPopupMenu;
    cxGridPopupMenuGoods: TcxGridPopupMenu;
    bbGoodsForeignCode: TdxBarLargeButton;
    bbGoodsInfoCard: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    bbEditCec: TdxBarButton;
    tbsDelivery: TcxTabSheet;
    IBCDSDelivery: TIBCDataSource;
    IBCQueryDelivery: TIBCQuery;
    bbPKO: TdxBarButton;
    cxGridSFTableColumn1: TcxGridDBColumn;
    cxGridDBCol_CREATED_DATE: TcxGridDBColumn;
    tbsScanFiles: TcxTabSheet;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar4: TdxBar;
    bbDeliveryAdd: TdxBarButton;
    bbDeliveryDel: TdxBarButton;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxDBVerticalGrid1DOCID: TcxDBEditorRow;
    cxDBVerticalGrid1COURIERID: TcxDBEditorRow;
    cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow;
    cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow;
    cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow;
    cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow;
    cxDBVerticalGrid1AWB: TcxDBEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow;
    cxDBVerticalGrid1CategoryRow1: TcxCategoryRow;
    cxDBVerticalGrid1CategoryRow2: TcxCategoryRow;
    bbDeliverySave: TdxBarButton;
    dxBarButton5: TdxBarButton;
    cxGridInvoiceTable_TipFacturaNAME: TcxGridDBColumn;
    cxGridInvoiceTable_FFType: TcxGridDBColumn;
    cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow;
    IBCQuerySysS: TIBCQuery;
    IBCDataSourceSysS: TIBCDataSource;
    IBCQueryCities: TIBCQuery;
    IBCDataSourceCities: TIBCDataSource;
    bbPdncRamburs: TdxBarButton;
    bbBankOut: TdxBarButton;
    bbFLG_Export_Cancel: TdxBarButton;
    cxGridSF_STATE_NAME: TcxGridDBColumn;
    cxGridSF_STATUSID: TcxGridDBColumn;
    frameScanFile1: TframeScanFile;
    cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow;
    bbExport2eFactura: TdxBarButton;
    IBCQueryeFactura: TIBCQuery;
    IBCQueryDetail: TIBCQuery;
    cxGridInvoiceTableColumn1: TcxGridDBColumn;
    cxGridInvoiceTableColumn2: TcxGridDBColumn;
    bbDublicateDocument: TdxBarButton;
    bbAccountName: TdxBarButton;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbModifyInvoiceClick(Sender: TObject);
    procedure bbPrintInvoiceClick(Sender: TObject);
    procedure cxGridSFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
      TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure bbActionPrintReceiptClick(Sender: TObject);
    procedure bbCancelInvoiceClick(Sender: TObject);
    procedure cxGridInvoiceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridReceiptsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCancelReceiptClick(Sender: TObject);
    procedure cxGridReceipts_FLAGSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbNewInvoiceClick(Sender: TObject);
    procedure cxGridInvoiceTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSFTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridInvoiceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridReceiptsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDeleteInvoiceClick(Sender: TObject);
    procedure bbDeleteReceiptClick(Sender: TObject);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbDebtsNotifyClick(Sender: TObject);
    procedure cxGridSFTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridSFT_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbBringGoodsFromRashodClick(Sender: TObject);
    procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridSF_FLG_EXPORTEDStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridSF_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText:
      string);
    procedure bbChangeCasaClick(Sender: TObject);
    procedure bbBringGoodsFromCustomDocClick(Sender: TObject);
    procedure bbSborkaComplectBringGoodsClick(Sender: TObject);
    procedure bbSborkaComplectAddGoodsClick(Sender: TObject);
    procedure bbSborkaComplectModifyGoodsClick(Sender: TObject);
    procedure bbSborkaComplectRemoveGoodsClick(Sender: TObject);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbPriceCol0Click(Sender: TObject);
    procedure bbPriceCol0ComplectClick(Sender: TObject);
    procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbBringGoodsFromMultiSborkaClick(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbEditCecClick(Sender: TObject);
    procedure IBCDataSourceJurnalKitStateChange(Sender: TObject);
    procedure tbsDeliveryShow(Sender: TObject);
    procedure IBCDSDeliveryStateChange(Sender: TObject);
    procedure bbPKOClick(Sender: TObject);
    procedure bbDeliveryAddClick(Sender: TObject);
    procedure cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbDeliverySaveClick(Sender: TObject);
    procedure bbDeliveryDelClick(Sender: TObject);
    procedure cxPageControlChange(Sender: TObject);
    procedure tbsScanFilesHide(Sender: TObject);
    procedure tbsScanFilesShow(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
    procedure IBCQueryINVOICESAfterInsert(DataSet: TDataSet);
    procedure cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesInitPopup(Sender: TObject);
    procedure cxDBVerticalGrid1DBMultiEditorRow2Editors1EditPropertiesInitPopup(Sender: TObject);
    procedure bbPdncRambursClick(Sender: TObject);
    procedure bbBankOutClick(Sender: TObject);
    procedure bbFLG_Export_CancelClick(Sender: TObject);
    procedure bbExport2eFacturaClick(Sender: TObject);
    procedure bbDublicateDocumentClick(Sender: TObject);
    procedure bbAccountNameClick(Sender: TObject);
  private
//    fLastFilePath: string;
    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete, fSYS_VIEW_COMPLECT: Boolean;
    procedure WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenInvoiceFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure InvoiceSelectionChanged;
    procedure WhenReceiptFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure ReceiptSelectionChanged;
    procedure DelivertySelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure WhenGridComplectTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure WhenSborkaComplectSelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteSelectedGoods;
    procedure ShowCreateNewInvoiceDialog;
    procedure ShowModifyInvoiceDialog;
    procedure ShowPrintReceiptDialog;
    procedure GetInvoiceStats(const DocID: integer; var StatsPrintedNotCanceled, StatsNotPrintedNotCanceled: Integer);
    function VidatScetFactura(const DocID, InvoiceID: integer; const FacturaNo: string): Boolean;
    procedure DoCloseInvoice;
    procedure DoOpenInvoice;
    function DoCloseInvoiceDB(const DOCID: Integer; const forcedClose: Boolean = false): Boolean;
    function DoOpenInvoiceDB(const DOCID: Integer): Boolean;
    procedure DoDeleteInvoice;
    procedure DoDeleteReceipt;
// TODO: DoCancelInvoiceDB
//  function DoCancelInvoiceDB(const DocID, InvoiceID: integer): Boolean;
    procedure DoBringGoodsFromRashod;
    function DoBringGoodsFromRashodDB(const DocID: integer): Boolean;
    function VerifyCanPrintInvoice(const DocID: integer): Boolean;
    procedure ShowBringGoodsFromCustomDocument;
    function DoActionImportGoodsFromDoc(const SourceDocID: integer): Boolean;
    procedure ShowMultiSborkaBringGoodsDocument;
    function DoActionImportGoodsFromDocMultiSborka(const SourceDocID: integer): Boolean;
    procedure SetupQtyFields;

    // Sborka Complect
    procedure ShowBringGoodsFromSborkaComplectDialog;
    function BringGoodsFromSborkaComplect(const DocID, GoodsID: Integer): Boolean;
    procedure ShowSborkaComplectAddGoodsDialog;
    procedure ShowSborkaComplectModifyGoodsDialog;
    procedure ShowSborkaComplectDeleteGoods;
    procedure EditCecDlg;
    procedure SelectGoodsAcnt;
// TODO: SaveFileFromDB
//  procedure SaveFileFromDB(const AttID: integer; const FilePath: string);
  protected
    procedure CloseDataSets;
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure GenerateInvoiceXml(FileName: string);
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;

  public
    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, frmScetFakturaDocDialog,
  frmSelectGoodsToAddDialog, frmScetFakturaDoverenostiDialog, SWNConst,
  SWNUtils, SWNValueStorageUnit, SWNDBErrors, frmPrintEngineWindow,
  frmScetFacturaNomerDialog, SWNSecurity, SWNSecurityFlags,
  frmDocumentDeleteDialog, frmDocumentImportBrowserDialog, SWNTypes,
  SWNCommonDialogs, uEditCecDlg, frmCustomersDlg, frmMoneyIncomeDialog,
  frmReceiptPrintDialogV2, frmReceiptPrintDialogV1, frmGoodsACNTBrowser;

{$R *.dfm}

{ Tframe25ScetFaktura }

procedure Tframe25ScetFaktura.SelectGoodsAcnt;
var
  goodsACNT: TfrmGoodsACNTDlg;
begin
  goodsACNT := TfrmGoodsACNTDlg.Create(Self);
  try
      if goodsACNT.SelectGoodsAcnt(dmdb.IBCQueryJurnal.FieldByName('GOODS_ACNT_ID').AsInteger) then
      begin
        dmdb.IBCQueryJurnal.Edit;
        dmdb.IBCQueryJurnal.FieldByName('GOODS_ACNT_ID').AsInteger := goodsACNT.GoodsAcntID;
        dmdb.IBCQueryJurnal.Post;
      end;
  finally
      goodsACNT.Free;
  end;
end;

procedure Tframe25ScetFaktura.bbAccountNameClick(Sender: TObject);
begin
    SelectGoodsAcnt;
end;

procedure Tframe25ScetFaktura.bbActionPrintReceiptClick(Sender: TObject);
begin
  if (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency > 0) then
  begin
    if dmDB.CheckIfGoodsAreValidForReceipt(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ShowPrintReceiptDialog
    else
      ShowErrorDialog('Eroare', 'Sunt produse fara denumire pentru factura!');
  end
  else
    ShowErrorDialog('Eroare', 'A fost depistat cec cu suma = 0!');
end;

procedure Tframe25ScetFaktura.bbPriceCol0Click(Sender: TObject);
var
  PriceColumn: integer;
begin
  PriceColumn := TdxBarButton(Sender).Tag;
  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName('DTDEP').asInteger,
    dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, -1, PriceColumn) then
    RefreshData;
end;

procedure Tframe25ScetFaktura.bbPriceCol0ComplectClick(Sender: TObject);
var
  PriceColumn: integer;
begin
  PriceColumn := TdxBarButton(Sender).Tag;
  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger,
    dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, PriceColumn, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString, cxGridComplectTable.DataController.RecordCount) then
    RefreshData;
end;

procedure Tframe25ScetFaktura.bbPrintInvoiceClick(Sender: TObject);
var
  PrintEngine: TfrmPrintEngine;
  ReportParams: TReportParamsList;
  ReportOk: Boolean;
    //FacturaNO:String;
  dialog: TfrmScetFacturaNomerDlg;
  FLG_CLOSED: Boolean;
begin
     // verificam daca putem imprima factura
  if not VerifyCanPrintInvoice(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    Exit;

  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

//  ReportOk := False;
     // 1. imprimam "счет фактуры"
  ReportParams := TReportParamsList.Create;
  PrintEngine := TfrmPrintEngine.Create(Self);
  try
    ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    if not IBCQueryINVOICES.Active then
      IBCQueryINVOICES.Open;

    ReportParams.SetParamValue('INVOICEID', IBCQueryINVOICES.FieldByName('INVOICEID').asInteger);

        // get system params
    if Assigned(OnCustomPrintSetupReportParams) then
      OnCustomPrintSetupReportParams(ReportParams);

        // give param to printer
    PrintEngine.ReportParams := ReportParams;

//    PrintEngine.AddReport(133); // Счет фактура
    if IBCQueryINVOICES.FieldByName('TIP_FACTURA').AsInteger = 8556 then
    begin
      PrintEngine.AddReport(477);
    end
    else
    begin
      PrintEngine.AddReport(AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_FacturaFiscalaReportID, 519));
    end;
      // Factura Fiscala
    PrintEngine.ShowModal;

    if PrintEngine.Printed then
      ReportOk := True
    else
      raise Exception.Create('SYSERROR_SCETFACTURA');
  finally
    PrintEngine.Free;
    ReportParams.Free;
  end;

  if FLG_CLOSED or not ReportOk then
    Exit;

  // verificam daca factura are numar
  if IBCQueryINVOICES.FieldByName('FACTURANO').IsNull or (IBCQueryINVOICES.FieldByName('FACTURANO').AsString = '') then
  begin
    if ShowAskDialog('Numar factura', 'Introduceti numarul facturii') = mrYes then
    begin
      dialog := TfrmScetFacturaNomerDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
      try
        if dialog.ShowModal = mrOk then
        begin
          IBCQueryINVOICES.Open;
          if VidatScetFactura(dmDb.IBCQueryDocs.FieldByName('DOCID').AsInteger, IBCQueryINVOICES.FieldByName('INVOICEID').asInteger,
            dialog.InvoiceNO) then
          begin
            IBCQueryINVOICES.Refresh;
          end;
        end;
      finally
        dialog.Free;
      end;
    end;
  end;

  // try Close Document
  DoCloseInvoice;
end;

procedure Tframe25ScetFaktura.bbSborkaComplectAddGoodsClick(Sender: TObject);
begin
  ShowSborkaComplectAddGoodsDialog;
end;

procedure Tframe25ScetFaktura.bbSborkaComplectBringGoodsClick(Sender: TObject);
begin
  ShowBringGoodsFromSborkaComplectDialog;
end;

procedure Tframe25ScetFaktura.bbSborkaComplectModifyGoodsClick(Sender: TObject);
begin
  ShowSborkaComplectModifyGoodsDialog;
end;

procedure Tframe25ScetFaktura.bbSborkaComplectRemoveGoodsClick(Sender: TObject);
begin
  ShowSborkaComplectDeleteGoods;
end;

function Tframe25ScetFaktura.BringGoodsFromSborkaComplect(const DocID, GoodsID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SF_BRINGGOODS_SBORKA(:DOCID,:GOODSID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('GOODSID').AsInteger := GoodsID;
    Query.Transaction.StartTransaction;
    try
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

procedure Tframe25ScetFaktura.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe25ScetFaktura.bbBankOutClick(Sender: TObject);
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Приход денег на счет
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de plata bancara', 'Dispozitie de plata bancara');

    if dialog.ShowModal = mrOk then
    begin
             // Приход денег на счет
      if dmDB.CreateBPP(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.SUMA) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        ShowInfoDialog('Dispozitie de plata bancara', 'Document creat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.bbBringGoodsFromCustomDocClick(Sender: TObject);
begin
  ShowBringGoodsFromCustomDocument;
end;

procedure Tframe25ScetFaktura.bbBringGoodsFromRashodClick(Sender: TObject);
begin
  DoBringGoodsFromRashod;
end;

procedure Tframe25ScetFaktura.bbCancelInvoiceClick(Sender: TObject);
//var
//  S: string;
begin
//  S := IBCQueryINVOICES.FieldByName('FACTURANO').AsString;
//  if ShowAskDialog('Anulare factura', Format('Factura cu nr. %s va fi anulata?', [S]),
//    'Vor fi sterse toate produsele din factura.') = mrYes then
//  begin
//    if DoCancelInvoiceDB(IBCQueryINVOICES.FieldByName('DOCID').AsInteger, IBCQueryINVOICES.FieldByName('INVOICEID').AsInteger)
//      then
//      RefreshData;
//  end;
end;

procedure Tframe25ScetFaktura.bbCancelReceiptClick(Sender: TObject);
begin
  if ShowAskDialog('Anulare cec', Format('Cecul cu nr %4.4d in suma de %f lei va fi anulat?', [IBCQueryReceipt.FieldByName('NUMAR_BON').asInteger,
    IBCQueryReceipt.FieldByName('SUMA').asCurrency])) = mrYes then
  begin
    if not IBCQueryReceipt.UpdateTransaction.Active then
      IBCQueryReceipt.UpdateTransaction.StartTransaction;

    try
      dmDB.ExecuteQuery('execute procedure sp_cancel_pos_fiscal_receipt(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);

      IBCQueryReceipt.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryReceipt.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
    IBCQueryReceipt.Refresh;
  end;
end;

procedure Tframe25ScetFaktura.bbChangeCasaClick(Sender: TObject);
var
  S: string;
  Query: TIBCQuery;
begin
  S := #13#10 + dmDB.IBCQueryDocs.FieldByName('Suma').asString + ' ' + dmDB.IBCQueryDocs.FieldByName('Currency_name').asString
    + ' ?';
  if ShowAskDialog('Corectare casa', 'Creare document cu suma:' + S) = mrYes then
  begin
    Query := TIBCQuery.Create(Self);
    try
      Query.AutoCommit := False;
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultUpdate;
      Query.Transaction.StartTransaction;
      try
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_2003(:DOCID)';
        Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DocID').Asinteger;
        Query.ExecSQL;
        Query.Transaction.Commit;
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
    dmDB.IBCQueryDocs.RefreshRecord;
  end;
end;

procedure Tframe25ScetFaktura.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe25ScetFaktura.bbDeleteGoodsClick(Sender: TObject);
begin
  ShowDeleteSelectedGoods;
end;

procedure Tframe25ScetFaktura.bbDeleteInvoiceClick(Sender: TObject);
begin
  DoDeleteInvoice;
end;

procedure Tframe25ScetFaktura.bbDeleteReceiptClick(Sender: TObject);
begin
  DoDeleteReceipt;
end;

procedure Tframe25ScetFaktura.bbDeliveryAddClick(Sender: TObject);
begin
  inherited;
  IBCQueryDelivery.Open;
  IBCQueryDelivery.Edit;
end;

procedure Tframe25ScetFaktura.bbDeliveryDelClick(Sender: TObject);
begin
  if ShowAskDialog('Livrari', 'Sterge inregistrarea?') = mrYes then
  begin
    if IBCQueryDelivery.RecNo > 0 then
    begin
//      if not IBCQueryDelivery.UpdateTransaction.Active then
//        IBCQueryDelivery.UpdateTransaction.StartTransaction;
//      try
      IBCQueryDelivery.Delete;
//        IBCQueryDelivery.UpdateTransaction.Commit;
//      except on e:Exception do
//        begin
//          IBCQueryDelivery.UpdateTransaction.Rollback;
//          raise;
//        end;
//      end;
    end;
  end;
end;

procedure Tframe25ScetFaktura.bbDeliverySaveClick(Sender: TObject);
begin
  if IBCQueryDelivery.Active then
  begin
    if IBCQueryDelivery.State in [dsEdit, dsInsert] then
    begin
      IBCQueryDelivery.Post;
      bbDeliverySave.Enabled := false;
    end;
  end;
end;

procedure Tframe25ScetFaktura.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe25ScetFaktura.bbDublicateDocumentClick(Sender: TObject);
begin
  inherited;
  try
    dmdb.ExecuteQuery('execute procedure sp_clone_document(:docid, :new_doctypeid)', [dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger,
      112]);
    MessageDlg('Document nou creat cu succes!', mtInformation, [mbOK], 0);
  finally
    dmdb.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe25ScetFaktura.bbEditCecClick(Sender: TObject);
begin
  EditCecDlg;
end;

procedure Tframe25ScetFaktura.bbExport2eFacturaClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  dialog := TSaveDialog.Create(self);
  try
    dialog.DefaultExt := 'xml';
    dialog.FileName := 'efactura-' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + ' ' + AnsiDequotedStr(dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, '"');
    if dialog.Execute then
    begin
      GenerateInvoiceXml(dialog.FileName);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe25ScetFaktura.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe25ScetFaktura.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe25ScetFaktura.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe25ScetFaktura.bbPdncRambursClick(Sender: TObject);
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Приход денег на счет
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de incasare bancara', 'Dispozitie de incasare bancara');

    if dialog.ShowModal = mrOk then
    begin
             // Приход денег на счет
      if dmDB.CreateProhodDenegNaSciot(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger, dialog.Rate, dialog.SUMA, 135) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        ShowInfoDialog('Dispozitie de incasare bancara', 'Document creat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.bbModifyInvoiceClick(Sender: TObject);
begin
  ShowModifyInvoiceDialog;
end;

procedure Tframe25ScetFaktura.bbNewInvoiceClick(Sender: TObject);
begin
  ShowCreateNewInvoiceDialog;
end;

procedure Tframe25ScetFaktura.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe25ScetFaktura.GetInvoiceStats(const DocID: integer; var StatsPrintedNotCanceled, StatsNotPrintedNotCanceled:
  Integer);
var
  Query: TIBCQuery;
begin
  StatsPrintedNotCanceled := 0;
  StatsNotPrintedNotCanceled := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text :=
      'SELECT COUNT(DOCID),(SELECT COUNT(DOCID) FROM TDB_INVOICES WHERE (DOCID=:DOCID) AND (DATA_ELIBERARII IS NULL) AND (FLG_CANCELED=0)) FROM TDB_INVOICES WHERE (DOCID=:DOCID) AND (DATA_ELIBERARII IS NOT NULL) AND (FLG_CANCELED=0)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ExecSQL;
    StatsPrintedNotCanceled := Query.Fields[0].AsInteger;
    StatsNotPrintedNotCanceled := Query.Fields[1].AsInteger;
  finally
    Query.Free;
  end;
end;

procedure Tframe25ScetFaktura.CreateNewRecord;
var
  dialog: TfrmScetFakturaDocDlg;
begin
  dialog := TfrmScetFakturaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(IBCQueryDelivery.FieldByName('COURIERID').AsInteger, False, 0, 'Alege transportator') then
    begin
      IBCQueryDelivery.Edit;
      IBCQueryDelivery.FieldByName('COURIERID').AsInteger := dialog.CustomerID;
      IBCQueryDelivery.FieldByName('COURIER_NAME').Asstring := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesInitPopup(Sender: TObject);
begin
  IBCQuerySysS.Close;
  IBCQuerySysS.ParamByName('PARENTID').AsInteger := 3;
  IBCQuerySysS.Open;
end;

procedure Tframe25ScetFaktura.cxDBVerticalGrid1DBMultiEditorRow2Editors1EditPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCities.Close;
  IBCQueryCities.ParamByName('CITYID').AsInteger := IBCQuerySysS.FieldByName('SYSSID').AsInteger;
  IBCQueryCities.Open;
end;

procedure Tframe25ScetFaktura.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // daca nu este suficienta cantitate pe contabilitate, aratam cu rosu
  if VarIsFloat(AViewInfo.GridRecord.Values[cxGridComponents_ACNT_QTY.Index]) then
  begin
    if (AViewInfo.GridRecord.Values[cxGridComponents_ACNT_QTY.Index] <= 0) then
      ACanvas.Font.Color := clRed;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe25ScetFaktura.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComplect_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe25ScetFaktura.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe25ScetFaktura.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // daca nu este suficienta cantitate pe contabilitate, aratam cu rosu
  if VarIsFloat(AViewInfo.GridRecord.Values[cxGridComponents_ACNT_QTY.Index]) then
  begin
    if (AViewInfo.GridRecord.Values[cxGridComponents_ACNT_QTY.Index] <= 0) then
      ACanvas.Font.Color := clRed;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe25ScetFaktura.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe25ScetFaktura.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridDBCol_GOODS_ACNT_ID.Index]) and not VarIsNull(ARecord.Values[cxGridDB_FLG_ACTIVE.Index])
    then
  begin
    if (ARecord.Values[cxGridDBCol_GOODS_ACNT_ID.Index] = -1) and (ARecord.Values[cxGridDB_FLG_ACTIVE.Index] = 1) then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe25ScetFaktura.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  N: Integer;
begin
  if not VarIsNull(ARecord.Values[cxGridComponents_PRICE_COLUMN.Index]) then
  begin
    N := ARecord.Values[cxGridComponents_PRICE_COLUMN.Index];
    if (N <= 0) or (N >= 4) then
      AStyle := dmAdditions.cxStyle_GridPriceColumnRed;
  end;
end;

procedure Tframe25ScetFaktura.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe25ScetFaktura.cxGridInvoiceTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    ShowModifyInvoiceDialog;
    AHandled := True;
  end;
end;

procedure Tframe25ScetFaktura.cxGridInvoiceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridInvoiceTable_IMG.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;
end;

procedure Tframe25ScetFaktura.cxGridInvoiceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridInvoiceTable, Key, Shift);
end;

procedure Tframe25ScetFaktura.cxGridReceiptsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridReceipts_IMG.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;
end;

procedure Tframe25ScetFaktura.cxGridReceiptsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridReceiptsTable, Key, Shift);
end;

procedure Tframe25ScetFaktura.cxGridReceipts_FLAGSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  BonPartial, PersJuridica, Numerar: Boolean;
  S: string;
begin
  BonPartial := ARecord.Values[cxGridReceipts_FLG_BON_PARTIAL.Index] = 1;
  PersJuridica := ARecord.Values[cxGridReceipts_FLG_PERSOANA_JURIDICA.Index] = 1;
  Numerar := ARecord.Values[cxGridReceipts_FLG_NUMERAR.Index] = 1;

  if BonPartial then
    S := 'cec avans pentru '
  else
    S := 'cec pentru';
  if PersJuridica then
    S := S + ' persoana juridica'
  else
    S := S + ' persoana fizica';
  if Numerar then
    S := S + ' in numerar'
  else
    S := S + ' prin POS terminal';

  AText := S;
end;

procedure Tframe25ScetFaktura.cxGridSFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    if bbModifyInvoice.Enabled then
    begin
      DoDocumentDoubleClick;
      AHandled := True;
    end;
  end;
end;

procedure Tframe25ScetFaktura.cxGridSFTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridSF_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridSF_FLG_CLOSED.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridSF_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end
    else
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridSF_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe25ScetFaktura.cxGridSFTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridSFTable, Key, Shift);
end;

procedure Tframe25ScetFaktura.cxGridSFT_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridSFT_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridSFT_DATA.Index]);
end;

procedure Tframe25ScetFaktura.cxGridSF_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridSF_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridSF_CREATED_DATE.Index]);
end;

procedure Tframe25ScetFaktura.cxGridSF_FLG_EXPORTEDStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridSF_FLG_EXPORTED.Index]) then
  begin
    if ARecord.Values[cxGridSF_FLG_EXPORTED.Index] = 1 then
      AStyle := dmAdditions.cxStyle_BackgroundRED;
  end;
end;

procedure Tframe25ScetFaktura.DeleteRecord;
var
  canDelete, FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  canDelete := fSYS_Delete and not FLG_CLOSED;

  if not canDelete then
    Exit;

  DeleteCurrentSWNDocument(Self);


     {
     S:='';
     if FLG_CLOSED then S:='Внимание! Счет фактура уже выдана.';


     if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument,Format('Удалить запись номер %d?',[dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]),S)=mrYes then
     begin
          dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
          try
             dmDB.IBCQueryDocs.Delete;
             dmDB.IBCQueryDocs.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
     }
end;

procedure Tframe25ScetFaktura.DoFrameHide;
begin
  if IBCQueryDelivery.Active then
    if IBCQueryDelivery.State in [dsEdit, dsInsert] then
    begin
      IBCQueryDelivery.Post;
    end;

  IBCQueryDelivery.Close;

     // inchidem datele interne
  IBCQueryJurnalKit.Active := False;
  IBCQueryINVOICES.Active := False;
  IBCQueryReceipt.Active := False;
  frameScanFile1.IBCQueryFiles.Active := False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridComplectTable.OnFocusedRecordChanged := nil;
  cxGridSFTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;
  cxGridInvoiceTable.OnFocusedRecordChanged := nil;
  cxGridReceiptsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridSFTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe25ScetFaktura.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  tbsSborkaComplect.TabVisible := False;
  cxPageControl.ActivePage := tbsGoods;

     // 1. Legam grid-urile de datasource-sele
  cxGridSFTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridSFTable.OnFocusedRecordChanged := WhenDocumentFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsFocusedRecordChanged;
  cxGridInvoiceTable.OnFocusedRecordChanged := WhenInvoiceFocusedRecordChanged;
  cxGridReceiptsTable.OnFocusedRecordChanged := WhenReceiptFocusedRecordChanged;
  cxGridComplectTable.OnFocusedRecordChanged := WhenGridComplectTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryINVOICES.Active := True;
  IBCQueryReceipt.Active := True;
  IBCQueryJurnalKit.Active := True;
  frameScanFile1.IBCQueryFiles.Active := True;

     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe25ScetFaktura.DoOpenDocument(const DocID: Integer);
begin
  inherited;
  DoOpenInvoice;
end;

procedure Tframe25ScetFaktura.DoOpenInvoice;
begin
  if ShowAskDialog('Document Factura fiscala', 'deschide document ?') = mrYes then
  begin
    if DoOpenInvoiceDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe25ScetFaktura.DoOpenInvoiceDB(const DOCID: Integer): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE OPEN_FISCAL_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DOCID;
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

procedure Tframe25ScetFaktura.bbDebtsNotifyClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerNotifyDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe25ScetFaktura.bbBringGoodsFromMultiSborkaClick(Sender: TObject);
begin
  ShowMultiSborkaBringGoodsDocument;
end;

procedure Tframe25ScetFaktura.CloseDataSets;
begin
  IBCQueryINVOICES.Active := False;
  frameScanFile1.IBCQueryFiles.Active := False;
  IBCQueryJurnalKit.Active := False;
  IBCQueryDelivery.Active := False;
  IBCQueryReceipt.Active := False;
  dmdb.IBCQueryJurnal.Active := False;
end;

procedure Tframe25ScetFaktura.cxPageControlChange(Sender: TObject);
begin
  inherited;
  DocumentSelectionChanged;
end;

procedure Tframe25ScetFaktura.tbsScanFilesHide(Sender: TObject);
begin
  inherited;
  if frameScanFile1.IBCQueryFiles.State in (dsEditModes) then
    frameScanFile1.IBCQueryFiles.Post;

end;

procedure Tframe25ScetFaktura.tbsScanFilesShow(Sender: TObject);
begin
  inherited;
  frameScanFile1.IBCQueryFiles.Open;
end;

procedure Tframe25ScetFaktura.bbPKOClick(Sender: TObject);
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Приход денег на счет
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de incasare bancara', 'Dispozitie de incasare bancara');

    if dialog.ShowModal = mrOk then
    begin
             // Приход денег на счет
      if dmDB.CreateProhodDenegNaSciot(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger, dialog.Rate, dialog.SUMA) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        ShowInfoDialog('Dispozitie de incasare bancara', 'Document creat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.bbFLG_Export_CancelClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCE_FLG_EXP(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ExecSQL;
      Query.Transaction.Commit;
      dmDB.IBCQueryDocs.RefreshRecord;
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

procedure Tframe25ScetFaktura.dxBarButton5Click(Sender: TObject);
var
  PrintEngine: TfrmPrintEngine;
  ReportParams: TReportParamsList;
//  ReportOk: Boolean;
    //FacturaNO:String;
//  dialog: TfrmScetFacturaNomerDlg;
begin
//  ReportOk := False;
     // 1. imprimam "счет фактуры"
  ReportParams := TReportParamsList.Create;
  PrintEngine := TfrmPrintEngine.Create(Self);
  try
    ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    // get system params
    if Assigned(OnCustomPrintSetupReportParams) then
      OnCustomPrintSetupReportParams(ReportParams);

        // give param to printer
    PrintEngine.ReportParams := ReportParams;

    PrintEngine.AddReport(477); // Act transportator
    PrintEngine.ShowModal;

    if not PrintEngine.Printed then
      raise Exception.Create('SYSERROR_SCETFACTURA');
  finally
    PrintEngine.Free;
    ReportParams.Free;
  end;

end;

// TODO: SaveFileFromDB
//procedure Tframe25ScetFaktura.SaveFileFromDB(const AttID: integer; const FilePath: string);
//var
//Query: TIBCQuery;
//filename: string;
//begin
//Query := TIBCQuery.Create(Self);
//try
//  Query.Connection := dmDB.IBCConnection;
//  Query.SQL.Text := 'SELECT FILENAME,FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
//  Query.ParamByName('ID').AsInteger := AttID;
//  Query.ExecSQL;
//  if not Query.Eof then
//  begin
//    filename := IncludeTrailingPathDelimiter(FilePath) + Query.Fields[0].AsString;
//    TBlobField(Query.Fields[1]).SaveToFile(filename);
//  end;
//finally
//  Query.Free;
//end;
//end;

procedure Tframe25ScetFaktura.dxBarPopupMenuPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe25ScetFaktura.EditCecDlg;
var
  dialog: TfrmEditCecDlg;
begin
  dialog := TfrmEditCecDlg.Create(self, IBCQueryReceipt, IBCDataSourceReceipt);
  try
    dialog.ShowModal;
  finally
    dialog.Free
  end;
end;

function Tframe25ScetFaktura.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridSFTable.Site.Focused then
  begin
          // context from Docs
    if cxGridSFT_CT_NAME.Focused then
    begin
               // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridSFT_DATA.Focused then
    begin
               // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridSFT_DTDEP_NAME.Focused then
    begin
               // Склад
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe25ScetFaktura.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe25ScetFaktura.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods, ffCustomerType];
end;

function Tframe25ScetFaktura.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];
  if fSYS_Add then
    Result := Result + [fbtADD];
  if fSYS_Edit or fSYS_View then
    Result := Result + [fbtMODIFY];
  if fSYS_Delete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe25ScetFaktura.GetParamsListForReport(const ParamsList: TStringList);
begin
  ParamsList.Add('INVOICEID');
end;

function Tframe25ScetFaktura.GetParamValueForReport(const ParamName: string): Variant;
begin
  if ParamName = 'INVOICEID' then
  begin
    if not IBCQueryINVOICES.Eof then
      Result := IBCQueryINVOICES.FieldByName('INVOICEID').AsInteger
    else
      Result := -1;
  end
end;

procedure Tframe25ScetFaktura.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete, fBringGoods: Boolean;
  FLG_CLOSED: Boolean;
  fSborkaTab: Boolean;
  GoodsTypeID: Integer;
  fGoodsSelected: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;
  fBringGoods := False;
  fSborkaTab := False;
  fGoodsSelected := False;

  if (cxGridSFTable.DataController.DataSource <> nil) and (cxGridSFTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fGoodsNew := fSYS_Edit and not FLG_CLOSED; // Добавить товар
    fBringGoods := fSYS_Edit and not FLG_CLOSED; // Привести товары
    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      GoodsTypeID := dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger;

      fGoodsEdit := fSYS_Edit and not FLG_CLOSED;   // Изменить товар
      fGoodsDelete := fSYS_Edit and not FLG_CLOSED; // Удалить товар
               // 11.12.2013
      fSborkaTab := dmDB.IsKit(GoodsTypeID);
      fGoodsSelected := True;
    end;
  end;
     // goods
  bbAddGoods.Enabled := fGoodsNew;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbDeleteGoods.Enabled := fGoodsDelete;
  bbBringGoodsFromRashod.Enabled := fBringGoods;
  bbBringGoodsFromCustomDoc.Enabled := fBringGoods;
  bbBringGoodsFromMultiSborka.Enabled := fBringGoods;

  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;

  tbsSborkaComplect.TabVisible := fSYS_VIEW_COMPLECT and fSborkaTab;
  if not fSborkaTab and (cxPageControl.ActivePage = tbsSborkaComplect) then
    cxPageControl.ActivePage := tbsGoods;

  WhenSborkaComplectSelectionChanged;
end;

procedure Tframe25ScetFaktura.IBCDataSourceJurnalKitStateChange(Sender: TObject);
begin
  inherited;
  if IBCDSDelivery.DataSet.State in [dsEdit, dsInsert] then
    bbDeliverySave.Enabled := True;
end;

procedure Tframe25ScetFaktura.IBCDSDeliveryStateChange(Sender: TObject);
begin
  inherited;
  if IBCDSDelivery.DataSet.State in [dsEdit, dsInsert] then
    bbDeliverySave.Enabled := True
  else
    bbDeliverySave.Enabled := False;

end;

function Tframe25ScetFaktura.InitFrameID: integer;
begin
     // СЧЕТ ФАКТУРЫ. Счет фактуры
  Result := 25;

  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
end;

procedure Tframe25ScetFaktura.InvoiceSelectionChanged;
var
  fCreateNewInvoice, fModifyInvoice, fDelete: Boolean;
  fPrintInvoice, FLG_CLOSED: Boolean;
begin
  fCreateNewInvoice := False;
  fModifyInvoice := False;
  fPrintInvoice := False;
//  fCancelInvoice := False;
  fDelete := False;
  FLG_CLOSED := True;
  SWNSecurityManager.LoggedUser.IsInAdminGroup;
  if (cxGridSFTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fCreateNewInvoice := (not FLG_CLOSED);
    if (cxGridInvoiceTable.DataController.RecNo > 0) then
    begin
      fModifyInvoice := not FLG_CLOSED; {and IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull)} {or (SWNSecurityManager.LoggedUser.IsInAdminGroup)}
      ;
      fPrintInvoice := (IBCQueryINVOICES.FieldByName('FLG_CANCELED').AsInteger = 0);
//      fCancelInvoice := (not IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull) and (IBCQueryINVOICES.FieldByName
//        ('FLG_CANCELED').AsInteger = 0);
      fDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Удалить);
    end;
  end;

  bbNewInvoice.Enabled := fCreateNewInvoice;
  bbModifyInvoice.Enabled := (fModifyInvoice) and (not FLG_CLOSED);
  bbPrintInvoice.Enabled := fPrintInvoice;
  bbDeleteInvoice.Enabled := fDelete and (not FLG_CLOSED);
end;

procedure Tframe25ScetFaktura.ModifyRecord;
var
  dialog: TfrmScetFakturaDocDlg;
  can_edit, FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  can_edit := fSYS_Edit and not FLG_CLOSED;

  if not (can_edit or fSYS_View) then
    Exit;

  dialog := TfrmScetFakturaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := not can_edit;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    cxPageControl.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridSFTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
    ReadGridColumnsSettings(cxGridInvoiceTable);
    ReadGridColumnsSettings(cxGridReceiptsTable);
    ReadGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe25ScetFaktura.ReceiptSelectionChanged;
var
  fCancelReceipt, fDelete: Boolean;
begin
  fCancelReceipt := False;
  fDelete := False;
  if (cxGridSFTable.DataController.RecNo > 0) and (cxGridReceiptsTable.DataController.RecNo > 0) then
  begin
    fCancelReceipt := IBCQueryReceipt.FieldByName('FLG_CANCELED').AsInteger = 0;
    fDelete := True;
  end;
  bbCancelReceipt.Enabled := fCancelReceipt;
  bbDeleteReceipt.Enabled := fDelete;

end;

procedure Tframe25ScetFaktura.DelivertySelectionChanged;
begin
  if (IBCQueryDelivery.RecNo > 0) then
  begin
    bbDeliveryDel.Enabled := true;
  end;
end;

procedure Tframe25ScetFaktura.RefreshData;
begin
  inherited;
  if IBCQueryINVOICES.Active then
    IBCQueryINVOICES.Refresh;
  if IBCQueryReceipt.Active then
    IBCQueryReceipt.Refresh;
  if IBCQueryJurnalKit.Active then
    IBCQueryJurnalKit.Refresh;
  if IBCQueryReceipt.Active then
    IBCQueryReceipt.Refresh;

end;

procedure Tframe25ScetFaktura.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', cxPageControl.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridSFTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
    SaveGridColumnsSettings(cxGridInvoiceTable);
    SaveGridColumnsSettings(cxGridReceiptsTable);
    SaveGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe25ScetFaktura.SetupDefaultFocus;
begin
     // grid
  cxGridSF.SetFocus;
     // columns
  cxGridSFT_CT_NAME.Focused := True;
  cxGridInvoiceTable_FACTURANO.Focused := True;
  cxGridDBCol_GOODS_NAMEACNT.Focused := True;
  cxGridReceipts_SUMA.Focused := True;
  cxGridComplect_GOODS_NAME.Focused := True;
end;

procedure Tframe25ScetFaktura.SetupQtyFields;
begin
     // Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
  TcxCalcEditProperties(cxGridComponents_ACNT_QTY.Properties).DisplayFormat := QtyDisplayFormat;
     // Комплектация из сборки: Кол-во
  TcxCalcEditProperties(cxGridComplect_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridComplect_QTY.Summary.FooterFormat := QtyDisplayFormat;
  TcxCalcEditProperties(cxGridComplect_ACNT_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe25ScetFaktura.SetupSecurityItems;
begin
  fSYS_Add := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Создать);
  fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Изменить);
  fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Просмотр);
  fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Удалить);
     // Комплектация из сборки
  fSYS_VIEW_COMPLECT := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Комплектация_из_сборки);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Корректровка_кассы) then
  begin
    bbChangeCasa.Visible := ivNever;

  end;

     // Колонка цен
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
  begin
    bbPriceCol0.Visible := ivNever;
    bbPriceCol0Complect.Visible := ivNever;
  end;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
    bbPriceCol1.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_2) then
    bbPriceCol2.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
    bbPriceCol3.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_4) then
    bbPriceCol4.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_5) then
    bbPriceCol5.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
    bbPriceCol6.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_7) then
    bbPriceCol7.Visible := ivNever;
  if (bbSubItemsPriceColumns.ItemLinks.VisibleItemCount = 0) then
    bbSubItemsPriceColumns.Visible := ivNever;
  if (bbSubItemsPriceColumnsComplect.ItemLinks.VisibleItemCount = 0) then
    bbSubItemsPriceColumnsComplect.Visible := ivNever;

     // Принести товары из других документов
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Принести_товары_из_других_документов) then
  begin
    bbBringGoodsFromRashod.Visible := ivNever;
    bbBringGoodsFromCustomDoc.Visible := ivNever;
    bbBringGoodsFromDocs.Visible := ivNever;
  end;

     // Привести товары из мульти-Сборки
//     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Принести_товары_из_расхода_мультиСборка)
//       then bbBringGoodsFromMultiSborka.Visible:=ivNever;
     // Doc popup menu
  if not fSYS_Edit then
  begin
    bbActionPrintReceipt.Visible := ivNever;
    bbPrintInvoice.Visible := ivNever;
    ButtonStateChanged(fbtCloseDocument, False);
    ButtonStateChanged(fbtOpenDocument, False);

//    bbCloseInvoice.Visible := ivNever;
//    bbOpenInvoice.Visible := ivNever;
  end;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Закрыть) then
    ButtonStateChanged(fbtCloseDocument, False);
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Открыть) then
    ButtonStateChanged(fbtOpenDocument, False);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Видеть_колонку_цен) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    cxGridComponents_PRICE_COLUMN.Visible := False;
    cxGridComponents_PRICE_COLUMN.VisibleForCustomization := False;
  end;

     // Счет фактура
  if not fSYS_Edit then
  begin
    bbNewInvoice.Visible := ivNever;
    bbModifyInvoice.Visible := ivNever;
    bbPrintInvoice.Visible := ivNever;
  end;
//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Аннулировать_счет_фактуры) then
//    bbCancelInvoice.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Удалить_счет_фактуры) then
    bbDeleteInvoice.Visible := ivNever;

  if dxBarManagerBar1.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManagerBar1.Visible := False;
    dxBarDockControlInvoices.Visible := False;
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

     // Кассовые чеки
  if (not fSYS_Edit) and (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_FF_E_Создание_чеков)) then
    bbActionPrintReceipt.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Аннулировать_чек) then
    bbCancelReceipt.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Удалить_чек) then
    bbDeleteReceipt.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Удалить_чек) then
    bbEditCec.Visible := ivNever;

  if dxBarManagerBarReceipt.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManagerBarReceipt.Visible := False;
    dxBarDockControlReceipt.Visible := False;
  end;

  bbPKO.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_FF_E_Dispozitie_de_incasare_bancara),
    ivAlways, ivNever);		// Dispozitie de incasare bancara
  bbPdncRamburs.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_FF_E_Dispozitie_de_incasare_bancara_cu_ramburs),
    ivAlways, ivNever);		// Dispozitie de incasare bancara cu ramburs
  bbBankOut.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_FF_E_Dispozitie_de_plata_bancara),
    ivAlways, ivNever);		// Dispozitie de plata bancara
  bbFLG_Export_Cancel.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_FACTURI_FF_E_Anulare_FLG_Export),
    ivAlways, ivNever);		// Anulare FLG_Export

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbEditCec.Visible := ivNever;
    bbCustomerDebts.Visible := ivNever;
    bbDebtsNotify.Visible := ivNever;
    bbFLG_Export_Cancel.Visible := ivNever;
    cxGridSF_FLG_ACNT.VisibleForCustomization := False;
    cxGridSF_FLG_ACNT.Visible := False;
  end;

  if (dxBarPopupMenu.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuDocs.PopupMenus.Clear;
  if (dxBarPopupMenuGoods.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuGoods.PopupMenus.Clear;
end;

function Tframe25ScetFaktura.DoActionImportGoodsFromDoc(const SourceDocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SCET_FACTURA_IMPORT_GOODS2(:DOCID,:SOURCE_DOCID)';
    Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
    Query.Transaction.StartTransaction;
    try
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

function Tframe25ScetFaktura.DoActionImportGoodsFromDocMultiSborka(const SourceDocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    if (UpperCase(dmdb.IBCConnection.Database) = '192.168.25.254/3050:GD') then
    begin
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SCET_FACTURA_IMPORT_GOODS3(:DOCID,:SOURCE_DOCID)';
    end;

    if (UpperCase(dmdb.IBCConnection.Database) = '192.168.25.254/3050:DL') then
    begin
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SCET_FACTURA_IMPORT_GOODS3(:DOCID,:SOURCE_DOCID)';
    end;

    if (UpperCase(dmdb.IBCConnection.Database) = '192.168.25.254/3050:PROFIL') then
    begin
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SCET_FACTURA_IMPORT_GOODS3(:DOCID,:SOURCE_DOCID)';
    end;

    if UpperCase(dmdb.IBCConnection.Database) = '192.168.106.254/3050:SW' then
    begin
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SCET_FACTURA_IMPORT_GOODS2(:DOCID,:SOURCE_DOCID)';
    end;

    Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
    Query.Transaction.StartTransaction;
    try
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

procedure Tframe25ScetFaktura.DoBringGoodsFromRashod;
begin
  if ShowAskDialog('Lista de produse', 'Copiere produse din document parinte?') = mrYes then
  begin
    if DoBringGoodsFromRashodDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
      RefreshData;
  end;
end;

function Tframe25ScetFaktura.DoBringGoodsFromRashodDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_INVOICE_BRING_GOODS(:DOCID)';
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

procedure Tframe25ScetFaktura.DoCloseDocument(const DocID: Integer);
begin
  inherited;
  DoCloseInvoice;
end;

// TODO: DoCancelInvoiceDB
//function Tframe25ScetFaktura.DoCancelInvoiceDB(const DocID, InvoiceID: integer): Boolean;
//var
//Query: TIBCQuery;
//begin
//Result := False;
//Query := TIBCQuery.Create(Self);
//try
//  Query.AutoCommit := False;
//  Query.Connection := dmDB.IBCConnection;
//  Query.Transaction := dmDB.IBCTrDefaultUpdate;
//  Query.Transaction.StartTransaction;
//  try
//    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCEL_INVOICE(:DOCID,:INVOICEID)';
//    Query.ParamByName('DOCID').AsInteger := DocID;
//    Query.ParamByName('INVOICEID').AsInteger := InvoiceID;
//    Query.ExecSQL;
//    Query.Transaction.Commit;
//    Result := True;
//  except
//    on E: Exception do
//    begin
//      Query.Transaction.Rollback;
//      if not ProcessSWNError(E) then
//        raise;
//    end;
//  end;
//finally
//  Query.Free;
//end;
//end;

procedure Tframe25ScetFaktura.DoCloseInvoice;
var
  S: string;
  forcedClose: Boolean;
begin
  S := #13#10 + dmDB.IBCQueryDocs.FieldByName('CT_NAME').asString + ' ?';

  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_СФ_Принудительное_закрытие_фактуры) then
  begin
          // utilizatorul face parte din Administrator
          // propunem varianta de inchidere fortata a facturii
    forcedClose := false;
    if ShowAskDialogVerification('Document Factura Fiscala', 'Inchide document Factura Fiscala pentru ' + S,
      'Inchidere fortata,fara verificari', '', forcedClose) = mrYes then
    begin
      if DoCloseInvoiceDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, forcedClose) then
        dmDB.IBCQueryDocs.Refresh;
    end;
  end
  else
  begin
    if ShowAskDialog('Document Factura Fiscala', 'Inchide document Factura Fiscala pentru ' + S) = mrYes then
    begin
      if DoCloseInvoiceDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
        dmDB.IBCQueryDocs.Refresh;
    end;
  end;
end;

function Tframe25ScetFaktura.DoCloseInvoiceDB(const DOCID: Integer; const forcedClose: Boolean): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      if (forcedClose) then
        Query.SQL.Text := 'EXECUTE PROCEDURE CLOSE_FISCAL_INVOICE_FORCED(:DOCID)'
      else
        Query.SQL.Text := 'EXECUTE PROCEDURE CLOSE_FISCAL_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DOCID;
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

procedure Tframe25ScetFaktura.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCanCloseInvoice, fCanOpenInvoice, fChangeColumnPrice: Boolean;
begin
  fDocNew := fSYS_Add; // New Document + Security
  fDocEdit := False;
  fDocDelete := False;

  fCanCloseInvoice := False;
  fCanOpenInvoice := False;
  fChangeColumnPrice := False;

  if (cxGridSFTable.DataController.DataSource <> nil) and (cxGridSFTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := (fSYS_Edit and not FLG_CLOSED) or fSYS_View; // Edit Document
    fDocDelete := fSYS_Delete and not FLG_CLOSED; // Delete Document
    fCanCloseInvoice := not FLG_CLOSED;
    fCanOpenInvoice := FLG_CLOSED;

    fChangeColumnPrice := not FLG_CLOSED;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);
  bbPriceCol0.Enabled := fChangeColumnPrice;
  bbPriceCol1.Enabled := fChangeColumnPrice;
  bbPriceCol2.Enabled := fChangeColumnPrice;
  bbPriceCol3.Enabled := fChangeColumnPrice;
  bbPriceCol4.Enabled := fChangeColumnPrice;
  bbPriceCol5.Enabled := fChangeColumnPrice;
  bbPriceCol6.Enabled := fChangeColumnPrice;
  bbPriceCol7.Enabled := fChangeColumnPrice;
  // inchidem toate sursele de date

  CloseDataSets;
  if cxPageControl.ActivePage = tbsSborkaComplect then
  begin
    IBCQueryJurnalKit.Active := True;
  end;
  if cxPageControl.ActivePage = tbsGoods then
  begin
    dmDB.IBCQueryJurnal.Active := True;
    GoodsSelectionChanged;
  end;
  if cxPageControl.ActivePage = tbsInvoices then
  begin
    IBCQueryINVOICES.Active := True;
    InvoiceSelectionChanged;
  end;
  if cxPageControl.ActivePage = tbsReceipts then
  begin
    IBCQueryReceipt.Active := True;
    ReceiptSelectionChanged;
  end;
  if cxPageControl.ActivePage = tbsDelivery then
  begin
    IBCQueryDelivery.Active := True;
    DelivertySelectionChanged;
  end;

  if cxPageControl.ActivePage = tbsScanFiles then
  begin
    frameScanFile1.IBCQueryFiles.Active := True;
  end;
     // popup

  ButtonStateChanged(fbtCloseDocument, True{fActionOtgruziti});
  ButtonStateChanged(fbtOpenDocument, True);

  WhenDocumentPopupMenuOpen;

end;

procedure Tframe25ScetFaktura.DoDeleteInvoice;
var
  S: string;
begin
  S := IBCQueryINVOICES.FieldByName('FACTURANO').AsString;
  if ShowAskDialog('Document Factura Fiscala', 'Sterge document Factura Fiscala nr.' + S, 'Atentie!') = mrYes then
  begin
    if not IBCQueryINVOICES.UpdateTransaction.Active then
      IBCQueryINVOICES.UpdateTransaction.StartTransaction;

    try
      dmdb.SendSWNMail('contabilitate@fantastic.md', 'Factura fiscala stearsa! ' + dmdb.CurrentFirmaName,
        'La ' + DateTimeToStr(Now) + ' - DOCID #' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + #13#10 +
        ' a fost stearsa de utilizatorul: ' + dmDB.CurrentUserFullName + #13#10 + 'Factura fiscala nr. ' + IBCQueryINVOICES.FieldByName
        ('FACTURANO').AsString);

      IBCQueryINVOICES.Delete;
      IBCQueryINVOICES.UpdateTransaction.Commit;
      InvoiceSelectionChanged;
    except
      on E: Exception do
      begin
        IBCQueryINVOICES.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe25ScetFaktura.DoDeleteReceipt;
var
  S: string;
begin
  S := IBCQueryReceipt.FieldByName('NUMAR_BON').AsString;
  if ShowAskDialog('Cec MCC', 'Sterge cec-mcc nr.' + S, 'Atentie!') = mrYes then
  begin
    IBCQueryReceipt.UpdateTransaction.StartTransaction;
    try
      IBCQueryReceipt.Delete;
      IBCQueryReceipt.UpdateTransaction.Commit;
      ReceiptSelectionChanged;
    except
      on E: Exception do
      begin
        IBCQueryReceipt.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe25ScetFaktura.GenerateInvoiceXml(FileName: string);
var
  XML: TXMLDocument;
//  Node: IXMLNode;
//  NodeSupplierInfo: IXMLNode;
  ErrorStr: string;
begin
  XML := TXMLDocument.Create(self);
  try
    XML.Active := True;
    XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
    XML.Version := '1.0';
    XML.Encoding := 'UTF-8';

    with IBCQueryeFactura do
    begin
      Close;
      ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Open;
    end;

    ErrorStr := '';
    with XML, IBCQueryeFactura do
    begin
      with AddChild('Documents') do
      begin
        with AddChild('Document') do
        begin
          // child elements
          with AddChild('SupplierInfo') do
          begin
            with AddChild('DeliveryDate') do
              NodeValue := DateToISO8601(FieldByName('DATA').AsDateTime);
            {$REGION 'SUPPLIER'}
            with AddChild('Supplier') do
            begin
              Attributes['IDNO'] := FieldByName('DT_IDEN_NUMBER').AsString;
              Attributes['CodTVA'] := FieldByName('DT_VAT_NUMBER').AsString;
              Attributes['Title'] := FieldbyName('DT_NAME').AsString;
              Attributes['Address'] := FieldByName('DT_ADDRESS2').AsString;

              with AddChild('BankAccount') do
              begin
                Attributes['BranchTitle'] := FieldByName('DT_BANKNAME').AsString;
                Attributes['BranchCode'] := FieldByName('DT_BANKACCOUNT').AsString;
                Attributes['Account'] := FieldByName('DT_ACCOUNT').AsString;
              end;
            end;
            {$ENDREGION}
        // Buyer
            {$REGION 'CUMPARATOR'}
            with AddChild('Buyer') do
            begin
              Attributes['TaxpayerType'] := 1;
              Attributes['IDNO'] := FieldByName('CT_IDEN_NUMBER').AsString;
              Attributes['CodTVA'] := FieldByName('CT_VAT_NUMBER').AsString;
              Attributes['Title'] := FieldbyName('CT_NAME').AsString;
              if FieldByName('CT_ADDRESS2').AsString = '' then
                raise Exception.Create('Adresa juridica nu este setata!');

              Attributes['Address'] := FieldByName('CT_ADDRESS2').AsString;
              with AddChild('BankAccount') do
              begin
                Attributes['BranchTitle'] := FieldByName('CT_BANKNAME').AsString;
                Attributes['BranchCode'] := FieldByName('CT_BANKACCOUNT').AsString;
                Attributes['Account'] := FieldByName('CT_ACCOUNT').AsString;
                if FieldByName('CT_ACCOUNT').AsString = '' then
                  ErrorStr := ErrorStr + 'Eroare! Nu sunt indicate conturile bancare a cumparatorului!'#13#10;
              end;
            end;
            {$ENDREGION}
        // Transporter
          {$REGION 'Transportator'}
            with AddChild('Transporter') do
            begin
              Attributes['IDNO'] := FieldByName('Transportator_IDNO').Asstring;
              Attributes['CodTVA'] := FieldByName('Transportator_VAT_NUMBER').Asstring;
              Attributes['Title'] := FieldByName('TRANSPORTATOR_NUME').AsString;
              Attributes['Address'] := FieldByName('TRANS_ADDRESS').AsString;
              Attributes['TaxpayerType'] := 1;
              with AddChild('BankAccount') do
              begin
                Attributes['BranchTitle'] := FieldByName('TRANS_BANKNAME').AsString;
                Attributes['BranchCode'] := FieldByName('TRANS_BANKACCOUNT').AsString;
                Attributes['Account'] := FieldByName('TRANS_ACCOUNT').AsString;
              end;
            end;
           {$ENDREGION}

            with AddChild('AttachedDocuments') do
              NodeValue := 'Documente anexate';
            with AddChild('Notes') do
              NodeValue := 'Comentarii';
//            with AddChild('DelegateSeria') do
//              NodeValue := '';
//            with AddChild('DelegateNumber') do
//              NodeValue := '';
//            with AddChild('DelegateName') do
//              NodeValue := '';
//            with AddChild('DelegateDate') do
//              NodeValue := '';
//            with AddChild('VehicleLogBook') do
//            begin
////              with AddChild('IssuedDate') do
////              begin
////                // In cazul in care data lipseste, nodul dat nu trebuie sa fie prezent in XML
////                Attributes['IssuedDate'] := '';
////                Attributes['Seria'] := '';
////                Attributes['Number'] := '';
////              end;
//            end;
            with AddChild('LoadingPoint') do
              NodeValue := FieldByName('DT_ADDRESS').AsString;
            if FieldByName('CT_ADDRESS').AsString = '' then
              raise Exception.Create('Nu este indicat punctul de descarcare.');
            with AddChild('UnloadingPoint') do
              NodeValue := FieldByName('CT_ADDRESS').AsString;
            with AddChild('Redirections') do
              NodeValue := FieldByName('Redirijari_NAME').AsString;
            with AddChild('Merchandises') do
            begin
              // for each jurnalRecord do
               {$REGION 'PRODUSE'}
              IBCQueryDetail.Close;
              IBCQueryDetail.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
              IBCQueryDetail.Open;
              while not IBCQueryDetail.Eof do
              begin
                with AddChild('Row') do
                begin
                // In cazul in care data lipse?te, nodul dat nu trebuie sa fie prezent in XML
                  if IBCQueryDetail.FieldByName('goods_acnt_id').AsInteger <= 0 then
                    raise exception.Create('Sunt produse fara nume in factura');

                  Attributes['Code'] := IBCQueryDetail.FieldByName('goods_acnt_id').AsString;
                  Attributes['Name'] := IBCQueryDetail.FieldByName('NAMEACNT').AsString;
                  Attributes['UnitOfMeasure'] := IBCQueryDetail.FieldByName('um_name').AsString;
                  Attributes['Quantity'] := IBCQueryDetail.FieldByName('qty').AsString;
                  Attributes['UnitPriceWithoutTVA'] := IBCQueryDetail.FieldByName('PRICE_WVAT').AsString;
                  Attributes['TotalPriceWithoutTVA'] := IBCQueryDetail.FieldByName('SUMA').AsFloat - IBCQueryDetail.FieldByName
                    ('SUMAVAT').AsFloat;
                  if IBCQueryDetail.FieldByName('VAT_RATE').AsInteger = 0 then
                    Attributes['TVA'] := '-'
                  else
                    Attributes['TVA'] := Round(100 * IBCQueryDetail.FieldByName('SUMAVAT').AsFloat / (IBCQueryDetail.FieldByName
                      ('SUMA').AsFloat - IBCQueryDetail.FieldByName('SUMAVAT').AsFloat));
                  Attributes['TotalTVA'] := IBCQueryDetail.FieldByName('SUMAVAT').AsFloat;
                  Attributes['TotalPrice'] := IBCQueryDetail.FieldByName('SUMA').AsFloat;
                  Attributes['OtherInfo'] := '';
                  Attributes['PackageType'] := '';
                  Attributes['NumberOfPlaces'] := '';
                  Attributes['GrossWeight'] := '';
                end;
                IBCQueryDetail.Next;
              end;
            {$ENDREGION}
            end;
            with AddChild('CreationMotiv') do
            begin
              if (FieldByName('Redirijari_NAME').AsString = '<Non livrare>') then
                NodeValue := '5'
              else
                NodeValue := '4';
            end;
          end;
          // supplierinfo
          with AddChild('AdditionalInformation') do
            with AddChild('field') do
              NodeValue := 'FEAWDADA22';
        end;
      end;
    end;
    if ErrorStr = '' then
      XML.SaveToFile(FileName)
    else
    begin
      ShowMessage(ErrorStr + 'Documentul XML nu a fost generat!');
    end;
  finally
    XML.Free;
  end;
end;

procedure Tframe25ScetFaktura.IBCQueryINVOICESAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('fftypeid').AsInteger := 7692; // Factura vanzare
  DataSet.FieldByName('fftype_name').AsString := 'Vanzare';
end;

procedure Tframe25ScetFaktura.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ShowBringGoodsFromCustomDocument;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultDocTypeID := dmDB.CurrentDocTypeID;
    dialog.DefaultFirmaID := dmDB.CurrentFirma;
    dialog.DefaultUserID := dmDB.CurrentUserID;

    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПТПН); // Приход товара по накладным
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_РН); // Расходная накладная (Оперативный учет)
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ВТОК); // Возврат товара от клиента

    if dialog.SelectDoc then
    begin
      if DoActionImportGoodsFromDoc(dialog.DocID) then
      begin
        RefreshData;
        ShowInfoDialog('Import', 'Import din document finisat!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ShowBringGoodsFromSborkaComplectDialog;
var
  S, S2: string;
begin
  S := Format(#13#10'"%d - %s"?', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  S2 := '';
  if (cxGridComplectTable.DataController.RecordCount > 0) then
    S2 := 'Toate positiile for fi sterse!';

  if ShowAskDialog('Factura Fiscala', 'Copie produsele din asamblarea nr. ' + S, S2) <> mrYes then
    Exit;

  if BringGoodsFromSborkaComplect(dmDB.IBCQueryJurnal.FieldByName('DOCID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger)
    then
    IBCQueryJurnalKit.Refresh;
end;

procedure Tframe25ScetFaktura.ShowCreateNewInvoiceDialog;
var
  dialog: TfrmScetFakturaDoverenostiDlg;
  StatsPrintedNotCanceled, StatsNotPrintedNotCanceled: Integer;
  CanCreateNewInvoice: Boolean;
begin
  CanCreateNewInvoice := False;

  GetInvoiceStats(dmDb.IBCQueryDocs.FieldByName('DOCID').AsInteger, StatsPrintedNotCanceled, StatsNotPrintedNotCanceled);
  begin
    if StatsNotPrintedNotCanceled > 0 then
      ShowErrorDialog(cMSG_GeneralInputError_Title, 'Exista factura neinchisa.')
    else if StatsPrintedNotCanceled > 0 then
      ShowErrorDialog(cMSG_GeneralInputError_Title, 'Doar o factura poate fi eliberata din document!')
    else
      CanCreateNewInvoice := True;
  end;

  if CanCreateNewInvoice then
  begin
    dialog := TfrmScetFakturaDoverenostiDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
    try
      dialog.CreateNewInvoice := True;
      dialog.DT := dmDB.IBCQueryDocs.FieldByName('DT').AsInteger;
      dialog.CT := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      dialog.DT_Name := dmDB.IBCQueryDocs.FieldByName('DT_Name').AsString;
      dialog.CT_Name := dmDB.IBCQueryDocs.FieldByName('CT_Name').AsString;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tframe25ScetFaktura.ShowDeleteSelectedGoods;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Sterge produs ' + #13#10 + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString
    + '?') = mrYes then
  begin
    if not dmDB.IBCQueryJurnal.UpdateTransaction.Active then
      dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryJurnal.Delete;
      dmdb.ibcqueryjurnal.UpdateTransaction.Commit;
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

procedure Tframe25ScetFaktura.ShowModifyInvoiceDialog;
var
  dialog: TfrmScetFakturaDoverenostiDlg;
  Flg_Closed, canEdit: Boolean;
begin
  Flg_Closed := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  canEdit := fSYS_Edit and not Flg_Closed; // and IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull;
  if not canEdit then
    Exit;

  dialog := TfrmScetFakturaDoverenostiDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
  try
    dialog.CreateNewInvoice := False;
    dialog.DT := dmDB.IBCQueryDocs.FieldByName('DT').AsInteger;
    dialog.CT := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.DT_Name := dmDB.IBCQueryDocs.FieldByName('DT_Name').AsString;
    dialog.CT_Name := dmDB.IBCQueryDocs.FieldByName('CT_Name').AsString;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ShowMultiSborkaBringGoodsDocument;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultDocTypeID := dmDB.CurrentDocTypeID;
    dialog.DefaultFirmaID := dmDB.CurrentFirma;
    dialog.DefaultUserID := dmDB.CurrentUserID;
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_РН); // Расходная накладная (Оперативный учет)
    if dialog.SelectDoc then
    begin
      if DoActionImportGoodsFromDocMultiSborka(dialog.DocID) then
      begin
        RefreshData;
        ShowInfoDialog('Import', 'Importul produselor din mai multe asamblari e finisat!');
      end;
    end;
  finally
    dialog.Free;
  end;

end;

procedure Tframe25ScetFaktura.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
  FLG_CLOSED, canEdit: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  canEdit := fSYS_Edit and not FLG_CLOSED;

  if not canEdit then
    Exit;

  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
    if dialog.ShowModal = mrOk then
    begin
      if dmdb.IBCQueryDocs.Active then
        dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ShowPrintReceiptDialog;
//var
//  dialog: TSWNCustomForm;
begin
  if (dmDB.CurrentFirma = 307225) then  // PRIME STORE
  begin
    var dialog := TfrmReceiptPrintV2Dlg.Create(Self);
    try
      if (dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger = 0) or (dmDB.IBCQueryDocs.FieldByName('FLG_NEW_CEC').AsInteger
        = 1) then
        dialog.RASHOD_DOCID := -1
      else
        dialog.RASHOD_DOCID := dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger;

      dialog.FACTURA_DOCID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        // temp
      dialog.PrintWithoutPrinter := True;
      dialog.ShowModal;

      if dialog.ReceiptPrinted and IBCQueryReceipt.Active then
        IBCQueryReceipt.Refresh;
    finally
      dialog.Free;
    end;
  end
  else
  begin
    var dialog := TfrmReceiptPrintV1Dlg.Create(self);
    try
      if (dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger = 0) or (dmDB.IBCQueryDocs.FieldByName('FLG_NEW_CEC').AsInteger
        = 1) then
        dialog.RASHOD_DOCID := -1
      else
        dialog.RASHOD_DOCID := dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger;

      dialog.FACTURA_DOCID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        // temp
      dialog.PrintWithoutPrinter := True;
      dialog.ShowModal;

      if dialog.ReceiptPrinted and IBCQueryReceipt.Active then
        IBCQueryReceipt.Refresh;
    finally
      dialog.Free;
    end;
  end;

end;

procedure Tframe25ScetFaktura.ShowSborkaComplectAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
  try
    dialog.AddNewGoods := True;
    dialog.AllowedActions := dialog.AllowedActions - [acChangeWarranty, acChangeStock] + [acChangePrice];
    dialog.VisibleActions := dialog.VisibleActions + [acChangeStock];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.ShowSborkaComplectDeleteGoods;
var
  S, S2: string;
begin
  S := #13#10 + Format('[%d] - %s', [IBCQueryJurnalKit.FieldByName('GOODSID').asInteger, IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString])
    + #13#10;
  S2 := Format('Complect: [%d] - %s', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  if ShowAskDialog('Complectatie', 'Sterge produsul ' + S + 'din complect?', S2) = mrYes then
  begin
    IBCQueryJurnalKit.UpdateTransaction.StartTransaction;
    try
      IBCQueryJurnalKit.Delete;
      IBCQueryJurnalKit.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryJurnalKit.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe25ScetFaktura.ShowSborkaComplectModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
  try
    dialog.AddNewGoods := False;
    dialog.AllowedActions := dialog.AllowedActions - [acChangeWarranty, acChangeStock] + [acChangePrice];
    dialog.VisibleActions := dialog.VisibleActions + [acChangeStock];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe25ScetFaktura.tbsDeliveryShow(Sender: TObject);
begin
  inherited;
  if cxPageControl.ActivePage = tbsDelivery then
  begin
    IBCQueryDelivery.Open;
    IBCQueryDelivery.Edit;
  end;
end;

procedure Tframe25ScetFaktura.WhenDocumentPopupMenuOpen;
begin
  if cxPageControl.ActivePage = tbsReceipts then
  begin
    if cxGridSFTable.DataController.DataSource <> nil then
    begin
      bbActionPrintReceipt.Enabled := (cxGridSFTable.DataController.RecNo > 0) and fSYS_Edit; // Печать фискального чека
      bbGotoParentDoc.Enabled := (cxGridSFTable.DataController.RecNo > 0) and not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
    end;
  end;
  bbDocComments.Enabled := fSYS_Edit; // Комментарии
end;

procedure Tframe25ScetFaktura.WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe25ScetFaktura.WhenGridComplectTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WhenSborkaComplectSelectionChanged;
end;

procedure Tframe25ScetFaktura.WhenInvoiceFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  InvoiceSelectionChanged;
end;

procedure Tframe25ScetFaktura.WhenReceiptFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ReceiptSelectionChanged;
end;

procedure Tframe25ScetFaktura.WhenSborkaComplectSelectionChanged;
var
  fBring, fAdd, fEdit, fDelete: Boolean;
  docFLG_CLOSED: Boolean;
  fCanChangePrice: Boolean;
begin
  fBring := False;
  fAdd := False;
  fEdit := False;
  fDelete := False;
  fCanChangePrice := False;

     // document
  if (cxGridSFTable.DataController.DataSource <> nil) and (cxGridSFTable.DataController.RecNo > 0) then
  begin
    docFLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    if not docFLG_CLOSED then
    begin
      fBring := True;
      fAdd := True;
      fCanChangePrice := cxGridComplectTable.DataController.RecordCount > 0;

      if Assigned(cxGridComplectTable.DataController.DataSource) and (cxGridComplectTable.DataController.RecNo > 0) then
      begin
        fEdit := True;
        fDelete := True;
      end;
    end;
  end;
  bbSborkaComplectBringGoods.Enabled := fBring;
  bbSborkaComplectAddGoods.Enabled := fAdd;
  bbSborkaComplectModifyGoods.Enabled := fEdit;
  bbSborkaComplectRemoveGoods.Enabled := fDelete;
  bbPriceCol0Complect.Enabled := fCanChangePrice;
end;

procedure Tframe25ScetFaktura.WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

function Tframe25ScetFaktura.VerifyCanPrintInvoice(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CAN_PRINT_INVOICE(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    try
      Query.ExecSQL;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe25ScetFaktura.VidatScetFactura(const DocID, InvoiceID: integer; const FacturaNo: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.SQL.Text := 'EXECUTE PROCEDURE SP_ISSUE_INVOICEPAPER(:DOCID,:INVOICEID,:FACTURANO)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('INVOICEID').AsInteger := InvoiceID;
    Query.ParamByName('FACTURANO').AsString := FacturaNo;

    Query.Transaction.StartTransaction;
    try
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

end.


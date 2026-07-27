unit frame59TTNUnit;
{
  СЧЕТ ФАКТУРЫ. Товаро транспортные накладные
  DocTypeID = 2016
  Frame Index = 59
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IBC, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit,
  cxLabel, cxCheckBox, cxImageComboBox, dxBar, cxClasses, ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, cxPC, DBAccess, MemDS, cxLookAndFeels,
  cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxPCdxBarPopupMenu, cxNavigator, cxCalc, dxBarBuiltInMenu,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe59TTN = class(TSWNBaseFrame)
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
    cxGridSF_FLG_ACNT: TcxGridDBColumn;
    cxPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsInvoices: TcxTabSheet;
    dxBarDockControlInvoices: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
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
    bbCancelInvoice: TdxBarButton;
    cxGridInvoiceTable_IMG: TcxGridDBColumn;
    cxGridInvoiceTable_FLG_CANCELED: TcxGridDBColumn;
    bbNewInvoice: TdxBarButton;
    bbCloseInvoice: TdxBarButton;
    cxGridSF_RATEUSD: TcxGridDBColumn;
    cxGridInvoiceTable_INVOICEID: TcxGridDBColumn;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    bbDeleteInvoice: TdxBarButton;
    bbGotoParentDoc: TdxBarButton;
    bbOpenInvoice: TdxBarButton;
    cxGridSF_DT: TcxGridDBColumn;
    cxGridSF_CT: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    cxGridDBCol_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridSF_SC2_NAME: TcxGridDBColumn;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridDBCol_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponentsTableColumn1: TcxGridDBColumn;
    cxGridSF_CREATED_DATE: TcxGridDBColumn;
    bbSubBringGoods: TdxBarSubItem;
    bbBringGoodsFromParent: TdxBarButton;
    cxGridInvoice_DOCUMENTE_ANEXATE: TcxGridDBColumn;
    bbPrintSF_horiz: TdxBarButton;
    bbPrintSF_vert: TdxBarButton;
    bbPrintFE: TdxBarSubItem;
    tbsSborkaComplect: TcxTabSheet;
    dxBarDockSborkaComplect: TdxBarDockControl;
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
    cxGridComplect_UMID: TcxGridDBColumn;
    cxGridComplect_ACNT_QTY: TcxGridDBColumn;
    cxGridComplectLevel: TcxGridLevel;
    dxBarButton1: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    IBCQueryJurnalKit: TIBCQuery;
    IBCDataSourceJurnalKit: TIBCDataSource;
    dxBarButton5: TdxBarButton;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbModifyInvoiceClick(Sender: TObject);
    procedure cxGridSFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
      TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure bbCancelInvoiceClick(Sender: TObject);
    procedure cxGridInvoiceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbNewInvoiceClick(Sender: TObject);
    procedure cxGridInvoiceTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbCloseInvoiceClick(Sender: TObject);
    procedure cxGridSFTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridInvoiceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDeleteInvoiceClick(Sender: TObject);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbOpenInvoiceClick(Sender: TObject);
    procedure cxGridSFTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridSFT_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridSF_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText:
      string);
    procedure bbBringGoodsFromParentClick(Sender: TObject);
    procedure bbPrintSF_horizClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
  private
    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
    procedure WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenInvoiceFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure InvoiceSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteSelectedGoods;
    procedure ShowCreateNewInvoiceDialog;
    procedure ShowModifyInvoiceDialog;
    procedure GetInvoiceStats(const DocID: integer; var StatsPrintedNotCanceled, StatsNotPrintedNotCanceled: Integer);
    function VidatScetFactura(const DocID, InvoiceID: integer; const FacturaNo: string): Boolean;
    procedure DoCloseInvoice;
    procedure DoOpenInvoice;
    function DoCloseInvoiceDB(const DOCID: Integer): Boolean;
    function DoOpenInvoiceDB(const DOCID: Integer): Boolean;
    procedure DoDeleteInvoice;
    function DoCancelInvoiceDB(const DocID, InvoiceID: integer): Boolean;
    function VerifyCanPrintInvoice(const DocID: integer): Boolean;
    procedure DoBringGoodsFromParentDoc;
    function DoBringGoodsFromParentDocDB(const DocID: Integer; const ClearAll: Boolean): Boolean;
    procedure PrintSF(const ReportID: integer);
    procedure SetupQtyFields;
  protected
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
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure ShowBringGoodsFromSborkaComplectDialog;
    function BringGoodsFromSborkaComplect(const DocID, GoodsID: Integer): Boolean;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, IBCError, frmSelectGoodsToAddDialog, frmScetFakturaDoverenostiDialog, SWNConst, SWNUtils,
  SWNValueStorageUnit, SWNDBErrors, frmPrintEngineWindow, frmScetFacturaNomerDialog, SWNSecurity, SWNSecurityFlags,
  frmCalcProfitabilityDialog, frmCustomerNotifyDebtsDialog, frmCustomerCurrentDebtsDialog, frmScetFakturaCekPKODialog,
  frmDocumentDeleteDialog, frmDocumentImportBrowserDialog, SWNTypes, frmTTNDocDialog;

{$R *.dfm}

{ Tframe25ScetFaktura }

procedure Tframe59TTN.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe59TTN.bbBringGoodsFromParentClick(Sender: TObject);
begin
  DoBringGoodsFromParentDoc;
end;

procedure Tframe59TTN.bbCancelInvoiceClick(Sender: TObject);
var
  S: string;
begin
  S := IBCQueryINVOICES.FieldByName('FACTURANO').AsString;
  if ShowAskDialog('Анулирование фактуры', Format('Вы хотите анулировать фактуру номер %s?', [S]),
    'Будут удаленны все товары из счет-фактуры.') = mrYes then
  begin
    if DoCancelInvoiceDB(IBCQueryINVOICES.FieldByName('DOCID').AsInteger, IBCQueryINVOICES.FieldByName('INVOICEID').AsInteger)
      then
      dmDB.FullRefresh;
  end;
end;

procedure Tframe59TTN.bbCloseInvoiceClick(Sender: TObject);
begin
  DoCloseInvoice;
end;

procedure Tframe59TTN.bbDeleteGoodsClick(Sender: TObject);
begin
  ShowDeleteSelectedGoods;
end;

procedure Tframe59TTN.bbDeleteInvoiceClick(Sender: TObject);
begin
  DoDeleteInvoice;
end;

procedure Tframe59TTN.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe59TTN.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe59TTN.bbModifyInvoiceClick(Sender: TObject);
begin
  ShowModifyInvoiceDialog;
end;

procedure Tframe59TTN.bbNewInvoiceClick(Sender: TObject);
begin
  ShowCreateNewInvoiceDialog;
end;

procedure Tframe59TTN.bbOpenInvoiceClick(Sender: TObject);
begin
  DoOpenInvoice;
end;

procedure Tframe59TTN.bbPrintSF_horizClick(Sender: TObject);
var
  reportID: integer;
begin
  reportID := -1;
  if (Sender = bbPrintSF_horiz) then
    reportID := 337
  else if (Sender = bbPrintSF_vert) then
    reportID := 353;

  if (reportID <> -1) then
    PrintSF(reportID);
end;

procedure Tframe59TTN.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe59TTN.GetInvoiceStats(const DocID: integer; var StatsPrintedNotCanceled, StatsNotPrintedNotCanceled: Integer);
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

procedure Tframe59TTN.CreateNewRecord;
var
  dialog: TfrmTTNDocDlg;
begin
  dialog := TfrmTTNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe59TTN.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe59TTN.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe59TTN.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe59TTN.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridDBCol_GOODS_ACNT_ID.Index]) and not VarIsNull(ARecord.Values[cxGridDB_FLG_ACTIVE.Index])
    then
  begin
    if (ARecord.Values[cxGridDBCol_GOODS_ACNT_ID.Index] = -1) and (ARecord.Values[cxGridDB_FLG_ACTIVE.Index] = 1) then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe59TTN.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
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

procedure Tframe59TTN.cxGridInvoiceTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    ShowModifyInvoiceDialog;
    AHandled := True;
  end;
end;

procedure Tframe59TTN.cxGridInvoiceTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridInvoiceTable_IMG.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;
end;

procedure Tframe59TTN.cxGridInvoiceTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridInvoiceTable, Key, Shift);
end;

procedure Tframe59TTN.cxGridSFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe59TTN.cxGridSFTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
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

procedure Tframe59TTN.cxGridSFTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridSFTable, Key, Shift);
end;

procedure Tframe59TTN.cxGridSFT_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText:
  string);
begin
  if not VarIsNull(ARecord.Values[cxGridSFT_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridSFT_DATA.Index]);
end;

procedure Tframe59TTN.cxGridSF_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridSF_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:NN', ARecord.Values[cxGridSF_CREATED_DATE.Index]);
end;

procedure Tframe59TTN.DeleteRecord;
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

procedure Tframe59TTN.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryJurnalKit.Active := False;

  IBCQueryINVOICES.Active := False;
  IBCQueryReceipt.Active := False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridSFTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;
  cxGridInvoiceTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridSFTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe59TTN.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  cxPageControl.ActivePage := tbsGoods;

     // 1. Legam grid-urile de datasource-sele
  cxGridSFTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridSFTable.OnFocusedRecordChanged := WhenDocumentFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsFocusedRecordChanged;
  cxGridInvoiceTable.OnFocusedRecordChanged := WhenInvoiceFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryINVOICES.Active := True;
  IBCQueryReceipt.Active := True;
  IBCQueryJurnalKit.Active := True;


     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe59TTN.DoOpenInvoice;
begin
  if ShowAskDialog('Открыть товаро транспортную накладную', 'Вы хотите открыть товаро транспортную накладную?') = mrYes then
  begin
    if DoOpenInvoiceDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe59TTN.DoOpenInvoiceDB(const DOCID: Integer): Boolean;
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

procedure Tframe59TTN.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  ShowBringGoodsFromSborkaComplectDialog;
end;

procedure Tframe59TTN.dxBarButton2Click(Sender: TObject);
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

procedure Tframe59TTN.dxBarButton3Click(Sender: TObject);
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

procedure Tframe59TTN.dxBarButton4Click(Sender: TObject);
var
  S, S2: string;
begin
  S := #13#10 + Format('[%d] - %s', [IBCQueryJurnalKit.FieldByName('GOODSID').asInteger, IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString])
    + #13#10;
  S2 := Format('Комплект: [%d] - %s', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  if ShowAskDialog('Удаление товара из комплектации', 'Вы хотите удалить товар' + S + 'из комплекта?', S2) = mrYes then
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

procedure Tframe59TTN.dxBarButton5Click(Sender: TObject);
var
  Query: TIBCQuery;
begin
//     PriceColumn:=TdxBarButton(Sender).Tag;
  Query := TIBCQuery.Create(nil);
  Query.SQL.Text := 'select ' +
    '(select RESULT_SUMA from TRANSFORM_SUMA_TO_MDL(gp.price0, gp.currencyid, (select transfer_rate from ts_currency c where c.currencyid=gp.currencyid)) p)  suma ' +
    ' from ts_goods_price gp where gp.goodsid=:goodsid';
  try
    IBCQueryJurnalKit.First;
    while not IBCQueryJurnalKit.Eof do
    begin
      Query.Close;
      Query.ParamByName('GOODSID').AsInteger := IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger;
      Query.ExecSQL;

      IBCQueryJurnalKit.Edit;
      IBCQueryJurnalKit.FieldByName('PRICE').AsFloat := Query.FieldByName('SUMA').AsFloat;
      IBCQueryJurnalKit.Post;

      IBCQueryJurnalKit.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe59TTN.ShowBringGoodsFromSborkaComplectDialog;
var
  S, S2: string;
begin
  S := Format(#13#10'"%d - %s"?', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  S2 := '';
  if (cxGridComplectTable.DataController.RecordCount > 0) then
    S2 := 'Все текущие позиции будут удаленны!';

  if ShowAskDialog('Принести товары из сборки', 'Вы хотите принести товары из комплекта сборки для' + S, S2) <> mrYes then
    Exit;

  if BringGoodsFromSborkaComplect(dmDB.IBCQueryJurnal.FieldByName('DOCID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger)
    then
    IBCQueryJurnalKit.Refresh;
end;

function Tframe59TTN.BringGoodsFromSborkaComplect(const DocID, GoodsID: Integer): Boolean;
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

procedure Tframe59TTN.dxBarPopupMenuPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe59TTN.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal
          // Код + Наименование
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

function Tframe59TTN.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe59TTN.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods, ffStock];
end;

function Tframe59TTN.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSYS_Add then
    Result := Result + [fbtADD];
  if fSYS_Edit or fSYS_View then
    Result := Result + [fbtMODIFY];
  if fSYS_Delete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe59TTN.GetParamsListForReport(const ParamsList: TStringList);
begin
  ParamsList.Add('INVOICEID');
end;

function Tframe59TTN.GetParamValueForReport(const ParamName: string): Variant;
begin
  if ParamName = 'INVOICEID' then
  begin
    if not IBCQueryINVOICES.Eof then
      Result := IBCQueryINVOICES.FieldByName('INVOICEID').AsInteger
    else
      Result := -1;
  end
end;

procedure Tframe59TTN.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;

  if fSYS_Edit and (cxGridSFTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    if (not FLG_CLOSED) then
    begin
      fGoodsNew := True; // Добавить товар

      if (cxGridComponentsTable.DataController.RecNo > 0) then
      begin
        fGoodsEdit := True;   // Изменить товар
        fGoodsDelete := True; // Удалить товар
      end;
    end;
  end;
     // goods
  bbAddGoods.Enabled := fGoodsNew;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbDeleteGoods.Enabled := fGoodsDelete;
end;

function Tframe59TTN.InitFrameID: integer;
begin
     // СЧЕТ ФАКТУРЫ. Товаро транспортные накладные
  Result := 59;
  SetupQtyFields;
end;

procedure Tframe59TTN.InvoiceSelectionChanged;
var
  fCreateNewInvoice, fModifyInvoice, fCancelInvoice, fDelete: Boolean;
  fPrintInvoice, FLG_CLOSED: Boolean;
begin
  fCreateNewInvoice := False;
  fModifyInvoice := False;
  fPrintInvoice := False;
  fCancelInvoice := False;
  fDelete := False;

  if (cxGridSFTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fCreateNewInvoice := (not FLG_CLOSED);
    if (cxGridInvoiceTable.DataController.RecNo > 0) then
    begin
      fModifyInvoice := (not FLG_CLOSED); // and IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull;

      fPrintInvoice := (IBCQueryINVOICES.FieldByName('FLG_CANCELED').AsInteger = 0);
      fCancelInvoice := (not IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull) and (IBCQueryINVOICES.FieldByName('FLG_CANCELED').AsInteger
        = 0);
      fDelete := True;
    end;
  end;

  bbNewInvoice.Enabled := fCreateNewInvoice;
  bbModifyInvoice.Enabled := fModifyInvoice;
  bbPrintSF_horiz.Enabled := fPrintInvoice;
  bbPrintSF_vert.Enabled := fPrintInvoice;
  bbCancelInvoice.Enabled := fCancelInvoice;
  bbDeleteInvoice.Enabled := fDelete;
end;

procedure Tframe59TTN.ModifyRecord;
var
  dialog: TfrmTTNDocDlg;
  can_edit, FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  can_edit := fSYS_Edit and not FLG_CLOSED;

  if not (can_edit or fSYS_View) then
    Exit;

  dialog := TfrmTTNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ReadOnly := not can_edit;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe59TTN.PrintSF(const ReportID: integer);
var
  PrintEngine: TfrmPrintEngine;
  ReportParams: TReportParamsList;
//    ReportOk:Boolean;
  dialog: TfrmScetFacturaNomerDlg;
  FLG_CLOSED: Boolean;
begin
     // verificam daca putem imprima factura
  if not VerifyCanPrintInvoice(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    Exit;

  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

//     ReportOk:=False;
     // 1. imprimam "Factura de Expeditie" (orizontal sau vertical)
  ReportParams := TReportParamsList.Create;
  PrintEngine := TfrmPrintEngine.Create(Self);
  try
    ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    ReportParams.SetParamValue('INVOICEID', IBCQueryINVOICES.FieldByName('INVOICEID').asInteger);

        // get system params
    if Assigned(OnCustomPrintSetupReportParams) then
      OnCustomPrintSetupReportParams(ReportParams);

        // give param to printer
    PrintEngine.ReportParams := ReportParams;

    PrintEngine.AddReport(ReportID);
    PrintEngine.ShowModal;

    if not PrintEngine.Printed then
//          ReportOk:=True
//        else
    begin
//            ReportOk := False;
      raise Exception.Create('SYSERROR_SCETFACTURA');
    end;
  finally
    PrintEngine.Free;
    ReportParams.Free;
  end;

  if FLG_CLOSED then
    Exit;

     // verificam daca factura are numar
  if IBCQueryINVOICES.FieldByName('FACTURANO').IsNull or (IBCQueryINVOICES.FieldByName('FACTURANO').AsString = '') then
  begin
    if ShowAskDialog('Номер фактуры', 'Вы хотите ввести номер фактуры?') = mrYes then
    begin
      dialog := TfrmScetFacturaNomerDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
      try
        if dialog.ShowModal = mrOk then
        begin
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

end;

procedure Tframe59TTN.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    cxPageControl.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridSFTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
    ReadGridColumnsSettings(cxGridInvoiceTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe59TTN.RefreshData;
begin
  inherited;
  IBCQueryINVOICES.Refresh;
  IBCQueryReceipt.Refresh;
end;

procedure Tframe59TTN.SaveFrameStates;
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
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe59TTN.SetupDefaultFocus;
begin
     // grid
  cxGridSF.SetFocus;
     // columns
  cxGridSFT_CT_NAME.Focused := True;
  cxGridInvoiceTable_FACTURANO.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe59TTN.SetupQtyFields;
begin
     // Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

procedure Tframe59TTN.SetupSecurityItems;
begin
  fSYS_Add := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Создать_документ);
  fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Изменить_документ);
  fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Просмотр_документа);
  fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Удалить_документ);

     // Doc popup menu
  if not fSYS_Edit then
  begin
    bbPrintSF_horiz.Visible := ivNever;
    bbPrintSF_vert.Visible := ivNever;
    bbPrintFE.Visible := ivNever;
    bbCloseInvoice.Visible := ivNever;
    bbOpenInvoice.Visible := ivNever;
  end;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Закрыть_документ) then
    bbCloseInvoice.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Открыть_документ) then
    bbOpenInvoice.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    cxGridComponents_PRICE_COLUMN.Visible := False;
    cxGridComponents_PRICE_COLUMN.VisibleForCustomization := False;
    cxGridSF_FLG_ACNT.VisibleForCustomization := False;
    cxGridSF_FLG_ACNT.Visible := False;
  end;

  if dxBarPopupMenu.ItemLinks.VisibleItemCount = 0 then
    cxGridPopupMenuDocs.PopupMenus[0].PopupMenu := nil;

     // Счет фактура
  if not fSYS_Edit then
  begin
    bbNewInvoice.Visible := ivNever;
    bbModifyInvoice.Visible := ivNever;
    bbPrintSF_horiz.Visible := ivNever;
    bbPrintSF_vert.Visible := ivNever;
    bbPrintFE.Visible := ivNever;
  end;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Анулировать_ТТН) then
    bbCancelInvoice.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Удалить_регистрацию_ТТН) then
    bbDeleteInvoice.Visible := ivNever;

  if dxBarManagerBar1.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManagerBar1.Visible := False;
    dxBarDockControlInvoices.Visible := False;
  end;

  if dxBarManagerBarReceipt.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManagerBarReceipt.Visible := False;
  end;
end;

procedure Tframe59TTN.DoBringGoodsFromParentDoc;
var
  clearAll: Boolean;
begin
  clearAll := True;
  if ShowAskDialogVerification('Привести товары', 'Вы хотите привести товары из документа родителя?',
    'Удалить существующие товары?', '', clearAll) = mrYes then
  begin
    if DoBringGoodsFromParentDocDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, clearAll) then
    begin
      dmDB.FullRefresh;
      ShowInfoDialog('Привести товары', 'Готово!');
    end;
  end;
end;

function Tframe59TTN.DoBringGoodsFromParentDocDB(const DocID: Integer; const ClearAll: Boolean): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_TTN_BRING_PARENT_GOODS(:DOCID,:CA)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('CA').AsInteger := Ord(ClearAll);
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

function Tframe59TTN.DoCancelInvoiceDB(const DocID, InvoiceID: integer): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCEL_INVOICE(:DOCID,:INVOICEID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('INVOICEID').AsInteger := InvoiceID;
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

procedure Tframe59TTN.DoCloseInvoice;
var
  S: string;
begin
  S := #13#10 + dmDB.IBCQueryDocs.FieldByName('CT_NAME').asString + ' ?';

  if ShowAskDialog('Закрыть товаро транспортную накладную', 'Вы хотите закрыть товаро транспортную накладную на контрагента'
    + S) = mrYes then
  begin
    if DoCloseInvoiceDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe59TTN.DoCloseInvoiceDB(const DOCID: Integer): Boolean;
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

procedure Tframe59TTN.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCanCloseInvoice, fCanOpenInvoice, fBringGoods, fHasParent: Boolean;
begin
  fDocNew := fSYS_Add; // New Document + Security
  fDocEdit := False;
  fDocDelete := False;

  fCanCloseInvoice := False;
  fCanOpenInvoice := False;
  fHasParent := False;
  fBringGoods := False;

  if cxGridSFTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := (fSYS_Edit and not FLG_CLOSED) or fSYS_View;   // Edit Document
    fDocDelete := fSYS_Delete and not FLG_CLOSED; // Delete Document

    fCanCloseInvoice := not FLG_CLOSED;
    fCanOpenInvoice := FLG_CLOSED;

    fBringGoods := fSYS_Edit and not FLG_CLOSED;
    fHasParent := dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger > 0;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbCloseInvoice.Enabled := fCanCloseInvoice;
  bbOpenInvoice.Enabled := fCanOpenInvoice;

     // goods
  bbSubBringGoods.Enabled := fBringGoods;
  bbBringGoodsFromParent.Enabled := fBringGoods and fHasParent;

  GoodsSelectionChanged;
  InvoiceSelectionChanged;
end;

procedure Tframe59TTN.DoDeleteInvoice;
var
  S: string;
begin
  S := IBCQueryINVOICES.FieldByName('FACTURANO').AsString;
  if ShowAskDialog('Удаление фактуры', 'Вы хотите удалить фактуру №' + S, 'Внимание!') = mrYes then
  begin
    IBCQueryINVOICES.UpdateTransaction.StartTransaction;
    try
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

procedure Tframe59TTN.ShowAddGoodsDialog;
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

procedure Tframe59TTN.ShowCreateNewInvoiceDialog;
var
  dialog: TfrmScetFakturaDoverenostiDlg;
  StatsPrintedNotCanceled, StatsNotPrintedNotCanceled: Integer;
  CanCreateNewInvoice: Boolean;
begin
  CanCreateNewInvoice := False;

  GetInvoiceStats(dmDb.IBCQueryDocs.FieldByName('DOCID').AsInteger, StatsPrintedNotCanceled, StatsNotPrintedNotCanceled);
  begin
    if StatsNotPrintedNotCanceled > 0 then
      ShowErrorDialog(cMSG_GeneralInputError_Title, 'Существует не выданная счет фактура! Измените её для ваших нужд.')
    else if StatsPrintedNotCanceled > 0 then
      ShowErrorDialog(cMSG_GeneralInputError_Title, 'Можно выдать только одну фактуру!')
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

procedure Tframe59TTN.ShowDeleteSelectedGoods;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Вы хотите удалить товар' + #13#10 + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString
    + '?') = mrYes then
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

procedure Tframe59TTN.ShowModifyInvoiceDialog;
var
  dialog: TfrmScetFakturaDoverenostiDlg;
  FLG_CLOSED, canEdit: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  canEdit := fSYS_Edit and not FLG_CLOSED; // and IBCQueryINVOICES.FieldByName('DATA_ELIBERARII').IsNull;

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

procedure Tframe59TTN.ShowModifyGoodsDialog;
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
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe59TTN.WhenDocumentPopupMenuOpen;
begin
  bbGotoParentDoc.Enabled := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  bbDocComments.Enabled := fSYS_Edit; // Комментарии
end;

procedure Tframe59TTN.WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe59TTN.WhenInvoiceFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  InvoiceSelectionChanged;
end;

procedure Tframe59TTN.WhenDocumentFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

function Tframe59TTN.VerifyCanPrintInvoice(const DocID: integer): Boolean;
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

function Tframe59TTN.VidatScetFactura(const DocID, InvoiceID: integer; const FacturaNo: string): Boolean;
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


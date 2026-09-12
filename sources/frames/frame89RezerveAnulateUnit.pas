unit frame89RezerveAnulateUnit;
{
  NAKLADNIE. Nakladnaia de iesire
  DocTypeID = 3297
  Frame Index = 89
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, System.UITypes,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxGraphics, cxFilter, DB, cxDBData, cxCalc, cxGridPopupMenu,
  dxBar, Vcl.ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, DBAccess, IBC, cxPC, cxTextEdit, frameScanFiles, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxImageComboBox, cxLabel, cxCurrencyEdit, dxBarBuiltInMenu,
  cxGridCustomPopupMenu, cxClasses, MemDS, dxUIAClasses;

type
  Tframe89RezerveAnulate = class(TSWNBaseFrame)
    cxGridNPN: TcxGrid;
    cxGridNPNTable: TcxGridDBTableView;
    cxGridNPNTableDocID: TcxGridDBColumn;
    cxGridNPN_DATA: TcxGridDBColumn;
    cxGridNPN_DTDEP_NAME: TcxGridDBColumn;
    cxGridNPN_CT_NAME: TcxGridDBColumn;
    cxGridNPNTableSuma: TcxGridDBColumn;
    cxGridNPN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridNPNTableVAT: TcxGridDBColumn;
    cxGridNPNTableRate: TcxGridDBColumn;
    cxGridNPNTableParentDocID: TcxGridDBColumn;
    cxGridNPNTable_FLG_ACNT: TcxGridDBColumn;
    cxGridNPN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPNLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    dxBarManager: TdxBarManager;
    bbNewGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    cxGridNPNTable_FLG_SHIP: TcxGridDBColumn;
    pmPopupMenuDocs: TdxBarPopupMenu;
    bbActionOtgruziti: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn;
    bbRollbackOtgruzka: TdxBarButton;
    bbPrintWarranty: TdxBarButton;
    cxGridNPN_CREATED_DATE: TcxGridDBColumn;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    cxGridPopupMenuNPN: TcxGridPopupMenu;
    cxGridNPN_CT: TcxGridDBColumn;
    cxGridNPN_DT: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    cxGridNPN_SC2_NAME: TcxGridDBColumn;
    ppJurnal: TdxBarPopupMenu;
    bbCheckStock: TdxBarButton;
    cxGridPopupmMenuComponents: TcxGridPopupMenu;
    cxGridNPN_DTSC_NAME: TcxGridDBColumn;
    cxGridNPNTable_FLG_CLOSE: TcxGridDBColumn;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridNPNTableFLG_SALARY: TcxGridDBColumn;
    cxGridNPNTableColumn2: TcxGridDBColumn;
    cxGridNPNTable_FLG_WITH_DELIVERY: TcxGridDBColumn;
    cxGridNPN_CTSC_NAME: TcxGridDBColumn;
    cxGridNPN_PHONELIST: TcxGridDBColumn;
    cxGridNPN_DELIVERY_DATE: TcxGridDBColumn;
    IBCQueryCashback: TIBCQuery;
    IBCDataSourceCashback: TIBCDataSource;
    cxGridComponentsTableColumn1: TcxGridDBColumn;
    bbGoodsTurnover: TdxBarButton;
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure bbActionOtgruzitiClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pmPopupMenuDocsPopup(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbApplyCashbackClick(Sender: TObject);
    procedure bbDebtsNotifyClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure bbCheckStockClick(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsTurnoverClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbRollbackOtgruzkaClick(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: Integer;
    fSYS_OtmenitiOtgruzku: Boolean;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fSecurityCalcRentability: boolean;
    procedure WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowModifyGoodsDialog;
    procedure ShowRemoveGoodsDialog;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
    function GetDiscountText(const DiscountType, DiscountValue: Integer): string;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    function GetPhoneNumber: string; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleAdditions, frmRNDocDialog, DataModuleDB, SWNUtils, SWNConst, frmSelectSNDialog, SWNTypes,
  frmSelectPartNumbersDialog, frmMoneyIncomeDialog, DateUtils, frmSelectGoodsToAddDialog, SWNValueStorageUnit,
  SWNDBErrors, frmPrintEngineWindow, frmBringGoodsDialog, SWNSecurity, frmCalcProfitabilityDialog,
  SWNSecurityFlags, frmOtgruzkaDialog, frmActiuneTVAInapoiDialog, frmProduseCuReducereDialog,
  frmDocumentDeleteDialog, frmApplyPromoCodeDialog, frmApplyActiuneCodeDialog,
  frmCalcProfitabilityContractDialog, uChangeUser, SWNCommonDialogs, frmSelectPhoneNumberUnit,
  frm82SelectLivrareUnit;

{$R *.dfm}
procedure Tframe89RezerveAnulate.bbActionOtgruzitiClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('execute procedure sp_set_flg_close_3297(:docid, 1)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe89RezerveAnulate.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe89RezerveAnulate.bbDebtsNotifyClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerNotifyDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe89RezerveAnulate.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe89RezerveAnulate.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe89RezerveAnulate.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog
end;

procedure Tframe89RezerveAnulate.bbRollbackOtgruzkaClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('execute procedure sp_set_flg_close_3297(:docid, 0)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe89RezerveAnulate.CreateNewRecord;
var
  dialog: TfrmRNDocDlg;
begin
  dialog := TfrmRNDocDlg.Create(Self);
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

procedure Tframe89RezerveAnulate.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    ShowModifyGoodsDialog;
    AHandled := True;
end;

procedure Tframe89RezerveAnulate.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure Tframe89RezerveAnulate.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe89RezerveAnulate.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (fSECURITY_CanEdit or fSECURITY_CanView) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe89RezerveAnulate.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_SHIP.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_CLOSE.Index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
        if (AViewInfo.GridRecord.Values[cxGridNPN_CREATED_DATE.Index] < Date - 3) then
          ACanvas.Brush.Color := clWebLightYellow;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
    end;
  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe89RezerveAnulate.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridNPNTable, Key, Shift);
end;

procedure Tframe89RezerveAnulate.cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_CREATED_DATE.Index]);
end;

procedure Tframe89RezerveAnulate.cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_DATA.Index]);
end;

procedure Tframe89RezerveAnulate.cxPageControlComplectChange(Sender: TObject);
begin
  SelectionChanged;
end;

procedure Tframe89RezerveAnulate.DeleteRecord;
begin
  DeleteCurrentSWNDocument(Self);
end;

function Tframe89RezerveAnulate.GetPhoneNumber;
begin
  inherited;
  Result := '';
  frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
  try
    frmSelectPhoneNumber.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    if frmSelectPhoneNumber.ShowModal = mrOk then
    begin
      Result := frmSelectPhoneNumber.SelectedPhoneNumber;
    end;
  finally
    frmSelectPhoneNumber.Free;
  end;
end;

//function Tframe10NakladnieRN.DoCreateShipmentDB(const DocID: integer; const ActiuneList: string): Boolean;
//var
//  Query: TIBCQuery;
//begin
//  Result := False;
//
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.Transaction := dmDB.IBCTrDefaultUpdate;
//    Query.Transaction.StartTransaction;
//    try
//      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_SHIPMENT2(:DOCID,:ACLIST)';
//      Query.ParamByName('DOCID').AsInteger := DocID;
//      Query.ParamByName('ACLIST').AsString := ActiuneList;
//      // exec
//      Query.ExecSQL;
//      Query.Transaction.Commit;
//      Result := True;
//    except
//      on E: Exception do
//      begin
//        Query.Transaction.Rollback;
//        if not ProcessSWNError(E) then
//          raise;
//      end;
//    end;
//  finally
//    Query.Free;
//  end;
//end;

procedure Tframe89RezerveAnulate.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  fTVA: Boolean;
  FLG_SHIP, FLG_PROTECTED, FLG_ACNT, FLG_CLOSED: Boolean;
  fActionPKO, fActionRKO, fActionStartEnterSerials, fActionSNS: Boolean;
  fActionOtgruziti, fActionRollbackOtgruzka, fActionBringGoods: Boolean;
  fActionVSF, fActionCalcProfitability, fGotoParent, fActionPrintWarranty: Boolean;
  fActiuneCode, fPrintCek: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;
  fTVA := False;

     // popup
  fActionPKO := False;
  fActionRKO := False;
  fActionStartEnterSerials := False;
  fActionSNS := False;
  fActionOtgruziti := False;
  fActionRollbackOtgruzka := False;
  fActionBringGoods := False;
  fActionVSF := False;
  fActionCalcProfitability := False;
  fGotoParent := False;
  fActionPrintWarranty := False;
  fActiuneCode := False;
  fPrintCek := False;

  if (cxGridNPNTable.DataController.RecNo > 0) then
  begin
    FLG_PROTECTED := dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1; // Introducere numere seriale
    FLG_SHIP := dmDB.IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1; // Expediat
    FLG_ACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1; // Contabilitate
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_SHIP or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete and not FLG_SHIP;


    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fGotoParent := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  SelectionChanged;
end;

procedure Tframe89RezerveAnulate.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridNPNTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridComponentsTable.DataController.DataSource := nil;
  cxGridNPNTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe89RezerveAnulate.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;
     // 1. Legam grid-urile de datasource-sele
  cxGridNPNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridNPNTable.OnFocusedRecordChanged := WhenDocumentGrid_FocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

//  IBCQueryDelivery.Open;
  cxPageControl1.ActivePageIndex := 0;


     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe89RezerveAnulate.dxBarButton1Click(Sender: TObject);
begin
  dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString,
    '');
end;

procedure Tframe89RezerveAnulate.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe89RezerveAnulate.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe89RezerveAnulate.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe89RezerveAnulate.bbCheckStockClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_DOC_STOCKQTY(:DOCID)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryJurnal.Refresh;
end;

function Tframe89RezerveAnulate.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridNPNTable.Site.Focused then
  begin
              // context from Docs
    if cxGridNPN_CT_NAME.Focused then
    begin
                   // Contraagent
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridNPN_DATA.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridNPN_DTDEP_NAME.Focused then
    begin
                           // Depozit
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe89RezerveAnulate.GetDiscountText(const DiscountType, DiscountValue: Integer): string;
begin
  case DiscountType of
    1:
      Result := Format('%d%%', [DiscountValue]);
    2:
      Result := Format('%d LEI', [DiscountValue]);
  end;
end;

function Tframe89RezerveAnulate.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe89RezerveAnulate.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffCustomerType, ffGoods, ffGoodsSN, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe89RezerveAnulate.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe89RezerveAnulate.InitFrameID: Integer;
begin
     // Rezerve anulate
  Result := 89;
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
  cxPageControl1.ActivePageIndex := 0;
end;

procedure Tframe89RezerveAnulate.ModifyRecord;
var
  dialog: TfrmRNDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmRNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe89RezerveAnulate.pmPopupMenuDocsPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe89RezerveAnulate.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridNPNTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe89RezerveAnulate.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AddNewGoods := False;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CONTRACT_PRICECOLUMN').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe89RezerveAnulate.ShowRemoveGoodsDialog;
var
  S: string;
begin
  S := Format(cMSG_DELETERECORD_РасходнаяНакладная, [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  // confirmation
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, S) <> mrYes then
    Exit;

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

procedure Tframe89RezerveAnulate.bbApplyCashbackClick(Sender: TObject);
begin
  try
    dmdb.ExecuteQuery('EXECUTE PROCEDURE SP_APPLY_CASHBACK (:DOCID, 1)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    MessageDlg('Recalculat cu succes', mtInformation, [mbOK], 0);
  finally
    IBCQueryCashback.Open;
    IBCQueryCashback.Refresh;
  end;

end;

procedure Tframe89RezerveAnulate.bbGoodsTurnoverClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

function Tframe89RezerveAnulate.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
  begin
    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure Tframe89RezerveAnulate.WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe89RezerveAnulate.WhenDocumentPopupMenuOpen;
begin
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe89RezerveAnulate.WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe89RezerveAnulate.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridNPNTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe89RezerveAnulate.SelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete: Boolean;
  fSerials, fInActiune: Boolean;
  SerialType, GoodsTypeID: Integer;
  FLG_SHIP: Boolean;
  fChangeUser, fChangeColumnPrice, fCheckStock: Boolean;
  fGoodsSelected: Boolean;
begin
     // goods
  fGoodsAdd := False;
  fGoodsEdit := False;
  fGoodsDelete := False;

  fSerials := False;
  fChangeUser := False;
  fChangeColumnPrice := False;
  fCheckStock := False;
  fGoodsSelected := False;

  if fSECURITY_CanEdit and (cxGridNPNTable.DataController.RecNo > 0) then
  begin
    FLG_SHIP := dmDB.IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1;

    fGoodsAdd := not FLG_SHIP; // New item for "Componenta"+ Security
    fChangeColumnPrice := not FLG_SHIP;

    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      SerialType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
      GoodsTypeID := dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger;

      fGoodsEdit := False;; // Modify "Componenta" + Security
      fGoodsDelete := False; // Delete "Componenta" + Security
      fSerials := False;

      fChangeUser := False;
      fGoodsSelected := True;
    end;
    fCheckStock := True;
  end;

     // goods
  bbNewGoods.Enabled := fGoodsAdd;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbRemoveGoods.Enabled := fGoodsDelete;
end;

procedure Tframe89RezerveAnulate.SetupDefaultFocus;
begin
     // focused grid
  cxGridNPN.SetFocus;
     // set focused column
  cxGridNPN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe89RezerveAnulate.SetupQtyFields;
begin
     // Pozitii marfa: Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

procedure Tframe89RezerveAnulate.SetupSecurityItems;
begin
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_RA_Modificare);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_RA_Sterge_documentul);
end;

end.


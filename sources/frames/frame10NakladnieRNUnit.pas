unit frame10NakladnieRNUnit;
{
  НАКЛАДНЫЕ. Расходная накладная
  DocTypeID = 107
  Frame Index = 10
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
  Dialogs,
  System.UITypes,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxStyles,
  cxGraphics,
  cxFilter,
  DB,
  cxDBData,
  cxCalc,
  cxGridPopupMenu,
  dxBar,
  Vcl.ExtCtrls,
  cxSplitter,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  DBAccess,
  IBC,
  cxPC,
  cxTextEdit,
  frameScanFiles,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCheckBox,
  cxImageComboBox,
  cxLabel,
  cxCurrencyEdit,
  dxBarBuiltInMenu,
  cxGridCustomPopupMenu,
  cxClasses,
  MemDS,
  frameDeliveryUnit,
  uValidateVoucherGiftDlg,
  dxUIAClasses;

type
  Tframe10NakladnieRN = class(TSWNBaseFrame)
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
    bbShowSerialDialog: TdxBarButton;
    cxGridNPNTable_FLG_CLOSED: TcxGridDBColumn;
    pmPopupMenuDocs: TdxBarPopupMenu;
    bbActionPKO: TdxBarButton;
    bbActionRKO: TdxBarButton;
    bbActionSNS: TdxBarButton;
    bbActionVSF: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    bbActionStartEnterSerials: TdxBarButton;
    cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn;
    bbPrintWarranty: TdxBarButton;
    bbBringGoods: TdxBarButton;
    bbCustomerDebts: TdxBarButton;
    cxGridNPN_CREATED_DATE: TcxGridDBColumn;
    cxGridNPN_RATEUSD: TcxGridDBColumn;
    cxGridPopupMenuNPN: TcxGridPopupMenu;
    bbCalcProfitability: TdxBarButton;
    cxGridNPN_CT: TcxGridDBColumn;
    cxGridNPN_DT: TcxGridDBColumn;
    bbGotoParentDoc: TdxBarButton;
    bbActiuneTVA: TdxBarButton;
    bbDebtsNotify: TdxBarButton;
    bbApplyPromoCode: TdxBarButton;
    bbActiuni: TdxBarSubItem;
    bbWinterPromoCode: TdxBarButton;
    bbDocComments: TdxBarButton;
    bbCodeActiune: TdxBarButton;
    cxGridNPN_SC2_NAME: TcxGridDBColumn;
    bbChangeColumnPrice: TdxBarButton;
    bbCreateProformaInvoice: TdxBarButton;
    ppJurnal: TdxBarPopupMenu;
    bbGoodsChangeUser: TdxBarButton;
    bbCreateCec: TdxBarButton;
    bbCheckStock: TdxBarButton;
    bbTTN: TdxBarButton;
    cxGridPopupmMenuComponents: TcxGridPopupMenu;
    bbSubItemsPriceColumns: TdxBarSubItem;
    bbPriceCol1: TdxBarButton;
    bbPriceCol2: TdxBarButton;
    bbPriceCol3: TdxBarButton;
    bbPriceCol4: TdxBarButton;
    bbPriceCol5: TdxBarButton;
    bbPriceCol6: TdxBarButton;
    bbPriceCol7: TdxBarButton;
    bbPriceCol0: TdxBarButton;
    bbGoodsForeignCode: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    bbGoodsInfoCard: TdxBarButton;
    cxGridNPN_DTSC_NAME: TcxGridDBColumn;
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
    cxGridComponents_PRICE_USD: TcxGridDBColumn;
    cxGridComponents_DISCOUNT_P: TcxGridDBColumn;
    cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridComponents_SUMA_USD: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    bbFLG_DOC_SALARY: TdxBarButton;
    cxGridNPN_FLG_SALARY: TcxGridDBColumn;
    cxGridComponentsTable_FLG_FA: TcxGridDBColumn;
    cxGridNPNTable_FLG_WITH_DELIVERY: TcxGridDBColumn;
    bbChangeDocUser: TdxBarButton;
    dxBarButton1: TdxBarButton;
    cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
    cxGridNPN_PHONELIST: TcxGridDBColumn;
    cxGridNPN_DELIVERY_DATE: TcxGridDBColumn;
    cxGridComponents_FLG_FORCED: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    cxGridComponents_FLG_PROMO: TcxGridDBColumn;
    bbApplyCashback: TdxBarButton;
    tbCashback: TcxTabSheet;
    bbCashbackNew: TdxBarButton;
    bbCashbackEdit: TdxBarButton;
    bbCashbackDelete: TdxBarButton;
    bbSendSMS: TdxBarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQueryCashback: TIBCQuery;
    IBCDataSourceCashback: TIBCDataSource;
    cxGrid1DBTableView1DOCID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1CASHBACK: TcxGridDBColumn;
    cxGrid1DBTableView1REGISTER_DATE: TcxGridDBColumn;
    cxGrid1DBTableView1VALID_UNTIL: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1WEB_LOGIN: TcxGridDBColumn;
    tbsDelivery: TcxTabSheet;
    bbBankIn: TdxBarButton;
    frameDelivery1: TframeDelivery;
    bbVoucherGift: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxBarButton5: TdxBarButton;
    bbAddToSupplier: TdxBarButton;
    bbVindutPrinPartener: TdxBarButton;
    bbDocumentTree: TdxBarButton;
    cxGridNPN_RESPONSIBLE_USERNAME: TcxGridDBColumn;
    bbSelectSupplier: TdxBarButton;
    dxBarSubItem5: TdxBarSubItem;
    dxBarButton6: TdxBarButton;
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure bbShowSerialDialogClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure bbActionRKOClick(Sender: TObject);
    procedure bbActionPKOClick(Sender: TObject);
    procedure bbActionSNSClick(Sender: TObject);
    procedure bbActionVSFClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbActionStartEnterSerialsClick(Sender: TObject);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pmPopupMenuDocsPopup(Sender: TObject);
    procedure bbPrintWarrantyClick(Sender: TObject);
    procedure bbBringGoodsClick(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbCalcProfitabilityClick(Sender: TObject);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbActiuneTVAClick(Sender: TObject);
    procedure bbApplyCashbackClick(Sender: TObject);
    procedure bbDebtsNotifyClick(Sender: TObject);
    procedure bbApplyPromoCodeClick(Sender: TObject);
    procedure bbWinterPromoCodeClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure bbCodeActiuneClick(Sender: TObject);
    procedure cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure bbChangeColumnPriceClick(Sender: TObject);
    procedure bbCreateProformaInvoiceClick(Sender: TObject);
    procedure bbGoodsChangeUserClick(Sender: TObject);
    procedure bbCreateCecClick(Sender: TObject);
    procedure bbCheckStockClick(Sender: TObject);
    procedure bbTTNClick(Sender: TObject);
    procedure cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure cxGridComponents_DISCOUNT_PGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridComponents_DISCOUNT_SUMAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxTabSheet2Show(Sender: TObject);
    procedure cxTabSheet2Hide(Sender: TObject);
    procedure bbFLG_DOC_SALARYClick(Sender: TObject);
    procedure bbChangeDocUserClick(Sender: TObject);
    procedure cxPageControl1PageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesChange(Sender: TObject);
    procedure frameDelivery1bbPrintClick(Sender: TObject);
    procedure bbBankInClick(Sender: TObject);
    procedure bbVoucherGiftClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
    procedure bbAddToSupplierClick(Sender: TObject);
    procedure bbVindutPrinPartenerClick(Sender: TObject);
    procedure bbDocumentTreeClick(Sender: TObject);
    procedure bbSelectSupplierClick(Sender: TObject);
    procedure dxBarButton6Click(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: Integer;
    fSYS_OtmenitiOtgruzku: Boolean;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fSecurityCalcRentability: boolean;
    procedure WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowRemoveGoodsDialog;
    procedure ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
    procedure ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
    function DoDBAction(const ActionID: Integer; const ValueInt: Integer = 0): Boolean;
//    function DoCreateShipmentDB(const DocID: integer; const ActiuneList: string): Boolean;
    procedure CreateNariadNaSborku;
    procedure DoActionPrihodniiKasoviiOrder;
    procedure DoActionRashodniiKasoviiOrder;
    function CheckIfDocumentisLocked: Boolean;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
    function VerifyBeforePrintWarranty: Boolean;
    procedure ShowPrintWarranty;
    procedure ShowBringGoodsDialog;
    procedure DoAction_BringGoodsDB(const DocID: Integer; const CustomMsg: string);
    procedure ShowCalcProfitabilityDialog(const DocID: Integer);
    procedure ShowCalcProfitabilityByContractDialog(const ContractID: Integer);
    function ActiuneTVAInapoiHasError(const ErrorList: TStringList): Boolean;
    function VerifyActiuneTVAInapoi_SumaProduselor: Double;
    function VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(const DocID: Integer): Boolean;
    function VerifyActiuneTVAInapoi_CustomerIsPF(const CustomerID: Integer): Boolean;
    function VerifyActiuneTVAInapoi_HasInvoice(const DocID: Integer): Boolean;
    function VerifyActiuneTVAInapoi_IsCustomerMobileOk(const CustomerID: Integer): Boolean;
    function VerifyActiuneTVAInapoi_DejaInActiune: Boolean;
    procedure ShowActiuneTVADialog;
    function ApplyActiuneTVAOverDocumentDB(const Code: string; const SourceDocID, TargetDocID: Integer): Boolean;
    procedure ShowApplyDiscountCodeDialog(const DocID: Integer);
    function ApplyPromoCodeOverDocumentDB(const PromoCode: string; const DocID: Integer): Boolean;
    function ActiuneDiscountSecondBuyHasErrors(const DocID: Integer; const ErrorList: TStringList): Boolean;
    procedure AddGoodsToContAchizitii(DocID, GoodsID, Qty: Integer);
    function GetDiscountText(const DiscountType, DiscountValue: Integer): string;
    procedure ShowNewYear2011PromoCodeDialog;
    function ApplyPromoCodeDB(const DocID: Integer; const PromoCode: string): Boolean;
    procedure ShowActivateActiuneCodeDialog;
    function ChangeGoodsUser(const DocID, DTDEP, CTDEP, GoodsComplectID, GoodsID, NewUserID: Integer): Boolean;
    procedure CreateCerereDeLivrare(DocID: Integer);
    procedure ShowCreateTTN;
    function TestGoodsIdForActiune(const GoodsID: Integer): Boolean;
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
    procedure CloneRecord; override;
    function GetPhoneNumber: string; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure SetupSecurityItems; override;
    procedure TransferMoneytoOtherUser(const dt, FromUser, ToUser: Integer; Amount: Double; CurrencyID: Integer;
      rashod_docid: integer; comment: string);

    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;

  public
    procedure DoSelectGoodsSupplier;
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, DateUtils, SWNCommonDialogs, SWNConst, SWNDBErrors, SWNSecurity, SWNSecurityFlags,
  SWNTypes, SWNUtils, SWNValueStorageUnit, frm82SelectLivrareUnit, frmActiuneTVAInapoiDialog,
  frmAddGoodsToSupplierOrderDlgUnit, frmApplyActiuneCodeDialog, frmApplyPromoCodeDialog, frmBringGoodsDialog,
  frmCalcProfitabilityContractDialog, frmCalcProfitabilityDialog, frmDocumentDeleteDialog, frmDocumentTreeUnit,
  frmGoodsForeignCodeDialog, frmMoneyIncomeDialog, frmOtgruzkaDialog, frmPrintEngineWindow, frmProduseCuReducereDialog,
  frmRNDocDialog, frmSelectGoodsSupplierUnit, frmSelectGoodsToAddDialog, frmSelectPartNumbersDialog,
  frmSelectPhoneNumberUnit, frmSelectSNDialog, uChangeUser,
  Vcl.Clipbrd;

{$R *.dfm}
{ Tframe10NakladnieRN }

function Tframe10NakladnieRN.ApplyActiuneTVAOverDocumentDB(const Code: string; const SourceDocID, TargetDocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_APPLY_CASHBACK_CODE(:id1,:id2)';
    // Query.ParamByName('code').AsString:=Code;
    Query.ParamByName('id1').AsInteger := SourceDocID;
    Query.ParamByName('id2').AsInteger := TargetDocID;
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

function Tframe10NakladnieRN.ApplyPromoCodeDB(const DocID: Integer; const PromoCode: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_APPLY_GOODS_PROMO_CODE(:id,:code)';
    Query.ParamByName('id').AsInteger := DocID;
    Query.ParamByName('code').AsString := PromoCode;
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

function Tframe10NakladnieRN.ApplyPromoCodeOverDocumentDB(const PromoCode: string; const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_APPLY_GOODS_DISCOUNT(:CODE,:DOCID)';
    Query.ParamByName('CODE').AsString := PromoCode;
    Query.ParamByName('DOCID').AsInteger := DocID;
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

procedure Tframe10NakladnieRN.bbActionPKOClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;
  DoActionPrihodniiKasoviiOrder;
end;

procedure Tframe10NakladnieRN.bbActionRKOClick(Sender: TObject);
begin

  if CheckIfDocumentisLocked then
    Exit;
  DoActionRashodniiKasoviiOrder;
end;

procedure Tframe10NakladnieRN.bbActionSNSClick(Sender: TObject);
begin
  CreateNariadNaSborku;
end;

procedure Tframe10NakladnieRN.bbActionStartEnterSerialsClick(Sender: TObject);
begin
  // Начать вводить серийники
  if ShowAskDialog('Numere de serie', 'blocare document pentru a introduce seriile?',
    'Doar d-voastra va putea modifica documentul si componenta lui!') = mrYes then
  begin
    if DoDBAction(4) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe10NakladnieRN.bbActionVSFClick(Sender: TObject);
begin
     // Выписать "Счет фактуру"
  if ShowAskDialog(' "Factura Fiscala"', 'Generez Factura Fiscala ?') = mrYes then
  begin
    if DoDBAction(3) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe10NakladnieRN.bbActiuneTVAClick(Sender: TObject);
begin
  ShowActiuneTVADialog;
end;

procedure Tframe10NakladnieRN.bbAddToSupplierClick(Sender: TObject);
var
  SupplierID: Integer;
begin
  var d: TfrmAddGoodsToSupplierOrderDlg;
  try
    d := TfrmAddGoodsToSupplierOrderDlg.Create(self);
    d.GoodsID := dmdb.ibcqueryjurnal.fieldbyname('goodsid').AsInteger;
    if (d.Showmodal = mrOK) then
    begin
      SupplierID := d.IBCQueryForeign.FieldByName('CustomerID').AsInteger;
      AddGoodsToContAchizitii(dmdb.ibcquerydocs.FieldByName('DOCID').AsInteger,
                              dmdb.ibcqueryJurnal.FieldByName('goodsid').AsInteger,
                              dmdb.ibcqueryjurnal.fieldbyname('qty').Asinteger);

//      ShowMessage('docid=' + d.Docid.ToString);
    end;
  finally
    d.Free;
  end;
end;

procedure Tframe10NakladnieRN.bbApplyPromoCodeClick(Sender: TObject);
begin
  ShowApplyDiscountCodeDialog(cxGridNPNTable.Controller.FocusedRecord.Values[cxGridNPNTableDocID.Index]);
end;

procedure Tframe10NakladnieRN.bbBankInClick(Sender: TObject);
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Приход денег на счет
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de incasare bancara', 'Dispozitie de incasare bancara');
    dialog.ShowBanknotesCounter := False;
    dialog.ShowModIncasare := False;
    if dialog.ShowModal = mrOk then
    begin
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

procedure Tframe10NakladnieRN.bbBringGoodsClick(Sender: TObject);
begin
  ShowBringGoodsDialog;
end;

procedure Tframe10NakladnieRN.bbCalcProfitabilityClick(Sender: TObject);
begin
  ShowCalcProfitabilityDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe10NakladnieRN.bbCodeActiuneClick(Sender: TObject);
begin
  ShowActivateActiuneCodeDialog;
end;

procedure Tframe10NakladnieRN.bbCreateCecClick(Sender: TObject);
begin
     // Выписать чек
  if ShowAskDialog('CEC MCC', 'Generarea cecului?') = mrYes then
  begin
    if DoDBAction(10) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      ShowInfoDialog('CEC MCC', 'Generat!');
    end;
  end;
end;

procedure Tframe10NakladnieRN.bbCreateProformaInvoiceClick(Sender: TObject);
begin
     // Выписать "Счет на оплату"
  if ShowAskDialog('Proforma', 'Generare document "PROFORMA"?') = mrYes then
  begin
    if DoDBAction(8) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      ShowInfoDialog('Proforma', 'Generat!');
    end;
  end;
end;

procedure Tframe10NakladnieRN.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe10NakladnieRN.bbDebtsNotifyClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerNotifyDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe10NakladnieRN.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe10NakladnieRN.bbDocumentTreeClick(Sender: TObject);
begin
  inherited;
  var d := TfrmDocumentTreeDlg.Create(self);
  try
    d.DocID := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure Tframe10NakladnieRN.bbFLG_DOC_SALARYClick(Sender: TObject);
begin
  try
    dmDB.ExecuteQuery('execute procedure sp_modify_docs_salary_flags(:docid, :FLG_SALARY)', [dmDB.IBCQueryDocs.FieldByName
      ('DOCID').AsInteger, (1 - dmDB.IBCQueryDocs.FieldByName('FLG_SALARY').AsInteger)]);

    dmDB.IBCQueryDocs.Refresh;
  except
    on e: Exception do
    begin
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
      if not ProcessSWNError(e) then
        raise;
    end;
  end;
end;

procedure Tframe10NakladnieRN.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe10NakladnieRN.bbModifyGoodsClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;
  ShowModifyGoodsDialog
end;

procedure Tframe10NakladnieRN.bbNewGoodsClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe10NakladnieRN.bbPrintWarrantyClick(Sender: TObject);
begin
  if VerifyBeforePrintWarranty then
    ShowPrintWarranty
  else
    ShowErrorDialog('Eroare', 'Pentru a tipari certificatul de garatie trebui introduse toate seriile si partidele!');
end;

procedure Tframe10NakladnieRN.bbRemoveGoodsClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;

  ShowRemoveGoodsDialog;
end;

procedure Tframe10NakladnieRN.bbSelectSupplierClick(Sender: TObject);

begin
  var d:=TfrmGoodsForeignCodeDlg.Create(self);
  try
    d.GoodsID := dmdb.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    if d.ShowModal=mrOK then
    begin
       dmdb.AddToAchizitii(d.GoodsID, dmdb.IBCQueryJurnal.fieldByname('QTY').AsInteger, d.SupplierID);
    end;
  finally
    d.Free;
  end;
end;

procedure Tframe10NakladnieRN.bbShowSerialDialogClick(Sender: TObject);
var
  flg_serial: Integer;
begin
  if CheckIfDocumentisLocked then
    Exit;

  flg_serial := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

  // Серийный учет
  if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowSelectGoodsSerialNumberDialog(dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1)
  else    // Партийный учет
    if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowSelectGoodsPartNumberDialog(dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1);
end;

procedure Tframe10NakladnieRN.bbTTNClick(Sender: TObject);
begin
  ShowCreateTTN;
end;

procedure Tframe10NakladnieRN.bbVindutPrinPartenerClick(Sender: TObject);
begin
  inherited;
  dmdb.ExecuteQuery('update tdb_docs set doctypeid = 3425 where docid = :docid', [dmdb.ibcqueryDocs.fieldbyname('docid').AsInteger]);
  dmdb.ibcquerydocs.refresh;
end;

procedure Tframe10NakladnieRN.bbVoucherGiftClick(Sender: TObject);
var
  d: TfrmValidateVoucherGiftDlg;
begin
  d := TfrmValidateVoucherGiftDlg.Create(self);
  try
    d.DocID := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    d.DT := dmdb.IBCQueryDocs.FieldByName('DT').AsInteger;
    d.ShowModal;
  finally
    d.Free;
  end;
end;

function Tframe10NakladnieRN.ChangeGoodsUser(const DocID, DTDEP, CTDEP, GoodsComplectID, GoodsID, NewUserID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text :=
      'EXECUTE PROCEDURE SP_CHANGE_JURNAL_OWNER(:Created_BY, :docid, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID)';
    Query.ParamByName('CREATED_BY').AsInteger := NewUserID;
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('DTDEP').AsInteger := DTDEP;
    Query.ParamByName('CTDEP').AsInteger := CTDEP;
    Query.ParamByName('GOODSCOMPLECT_ID').AsInteger := GoodsComplectID;
    Query.ParamByName('GOODSID').AsInteger := GoodsID;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
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

function Tframe10NakladnieRN.CheckIfDocumentisLocked: Boolean;
var
  UserName: string;
begin
  Result := False;
  if (dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1) and (dmDB.GetDocumentProtectedUser(dmDB.IBCQueryDocs.FieldByName
    ('DOCID').AsInteger, UserName) <> dmDB.CurrentUserID) then
  begin
    Result := True;
    ShowErrorDialog('Blocare documente',
      'Acest document este blocat pentru introducerea numerilor de serii / partide de catre ', '', Format('Пользователь: %s',
      [UserName]));
  end;
end;

procedure Tframe10NakladnieRN.CloneRecord;
var
  S: string;
  newDocID: Integer;
begin
  S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
  if ShowAskDialog('Clonare', 'Va fi creata o copie a documentului nr.' + S + '?') <> mrYes then
    Exit;

  if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
  begin
    dmDB.RefreshDocs;
    dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
    ShowInfoDialog('Clonare', 'Cope creata cu succes.'#13#10' Nr.' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString);
  end;
end;

procedure Tframe10NakladnieRN.CreateNariadNaSborku;
var
  Query: TIBCQuery;
  SumaDoc: Currency;
  SumaDocConfig: Currency;
  DocTypeConfig: Integer;
  found: Boolean;
begin
  // Создать наряд на сборку
  if ShowAskDialog('Producere', 'Creare document producere?') = mrYes then
  begin
    // verificam
    // 1. daca suma documentului nu s-a schimbat fata de suma documentului din Configurator
    SumaDoc := -1;
    SumaDocConfig := -1;
    DocTypeConfig := -1;
    found := False;

    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.SQL.Text :=
        'SELECT A.SUMA, B.SUMA, B.DOCTYPEID FROM TDB_DOCS A INNER JOIN TDB_DOCS B ON (B.DOCID=A.PARENTDOCID) WHERE A.DOCID=:DOCID';
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ExecSQL;
      if not Query.Eof then
      begin
        SumaDoc := Query.Fields[0].AsCurrency;
        SumaDocConfig := Query.Fields[1].AsCurrency;
        DocTypeConfig := Query.Fields[2].AsInteger;
        found := True;
      end;
    finally
      Query.Free;
    end;

    if found and ((DocTypeConfig = 115) or (DocTypeConfig = 101)) then
    // 115 = Конфигуратор, 101 = Счета на оплату
    begin
      // TEMP. Functie inchisa
      if (DocTypeConfig = 101) then
      begin
        // cream Sborka in orice caz din Sciot Na Oplatu. Verificare orpita de Sergiu. Vezi "sumele sunt diferite! Operatia este interzisa..."
        if dmDB.CreateNariadNaSborku_Other_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
          dmDB.IBCQueryDocs.Refresh;
          ShowInfoDialog('Producere', 'Document producere creat!');
        end
      end
      else        // sumele documentului
        if SumaDoc = SumaDocConfig then
      begin
          // sumele coincid, cream Sborka
        if dmDB.CreateNariadNaSborku_Other_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
          dmDB.IBCQueryDocs.Refresh;
          ShowInfoDialog('Producere', 'Document producere creat!');
        end
      end
      else if DocTypeConfig = 115 then
      begin
        if ShowAskDialog('Producere', 'Datele din documentul vinzari difera de cele din oferta!' + #13#10 + #13#10 +
          'Datele din oferta sa fie identice cu cele din documentul vinzari?' + 'creaza document producere?',
          'sau modificati manual in oferta datele.') = mrYes then
        begin
          if dmDB.CreateNariadNaSborku_Other_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
          begin
            dmDB.IBCQueryDocs.Refresh;
            ShowInfoDialog('Producere', 'Document producere creat!');
          end;
        end;
      end
      else          // sumele sunt diferite! Operatia este interzisa daca documentul initial este "Счет на оплату"
        if DocTypeConfig = 101 then
        ShowErrorDialog(cMSG_GeneralError_Title,
          'Данные из Расходной накладной отличаются от данных из Счета на оплату!' + #13#10#13#10 +
          'Наряд на сборку не может быть сделан!');
    end
    else
      ShowErrorDialog(cMSG_GeneralError_Title,
        'Данная Расходная накладная должна исходить из Конфигуратора или Счета на оплату!');
  end;
end;

procedure Tframe10NakladnieRN.CreateNewRecord;
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

procedure Tframe10NakladnieRN.cxDBVerticalGrid1DBMultiEditorRow2Editors0EditPropertiesChange(Sender: TObject);
begin
  inherited;
  frameDelivery1.IBCQueryDelivery.Edit;
  frameDelivery1.IBCQueryDelivery.FieldByName('cityid').AsInteger := -1;

end;

procedure Tframe10NakladnieRN.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (not CheckIfDocumentisLocked) and bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe10NakladnieRN.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
    ACanvas.Font.Color := clBlack;
  end;

  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index]) then
  begin
    if (AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index] = 0) and (AViewInfo.GridRecord.Values[cxGridDBCol_STOCK_QTY.Index]
      < 0) then
    begin
      if not AViewInfo.Selected then
      begin
        ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end;
  end;
end;

procedure Tframe10NakladnieRN.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe10NakladnieRN.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if (not VarIsNull(ARecord.Values[cxGridDBCol_STOCK_QTY.Index])) and VarIsNumeric(ARecord.Values[cxGridDBCol_STOCK_QTY.Index])
    then
  begin
    if ARecord.Values[cxGridDBCol_STOCK_QTY.Index] < 0 then
      AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
  end;
end;

procedure Tframe10NakladnieRN.cxGridComponents_DISCOUNT_PGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridComponents_DISCOUNT_P.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_DISCOUNT_P.Index] = 0) then
      AText := ''
  end;
end;

procedure Tframe10NakladnieRN.cxGridComponents_DISCOUNT_SUMAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridComponents_DISCOUNT_SUMA.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_DISCOUNT_SUMA.Index] = 0) then
      AText := ''
  end;
end;

procedure Tframe10NakladnieRN.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
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

procedure Tframe10NakladnieRN.cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe10NakladnieRN.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (fSECURITY_CanEdit or fSECURITY_CanView) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe10NakladnieRN.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_CLOSED.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_CLOSED.Index] = 0 then
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

      if not AViewInfo.Selected then
      begin
        ACanvas.Font.Color := clGrayText;
//        if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_ACNT.Index] = 1 then
//          ACanvas.Font.Color := $008B8BC5
//        else
//          ACanvas.Font.Color := clGrayText;
      end;
    end;
    if (AViewInfo.GridRecord.Values[cxGridNPN_FLG_SALARY.Index] = 0) then
    begin
      if not AViewInfo.Selected then
      begin
        ACanvas.Font.Style := ACanvas.Font.Style + [fsItalic];
//                ACanvas.Brush.Color := clWebHotPink;

      end;
    end;

  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe10NakladnieRN.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridNPNTable, Key, Shift);
end;

procedure Tframe10NakladnieRN.cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_CREATED_DATE.Index]);
end;

procedure Tframe10NakladnieRN.cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_DATA.Index]);
end;

procedure Tframe10NakladnieRN.cxPageControlComplectChange(Sender: TObject);
begin
  SelectionChanged;
end;

procedure Tframe10NakladnieRN.cxTabSheet2Hide(Sender: TObject);
begin
  inherited;
//  frameScanFile1.CloseDataSet;
end;

procedure Tframe10NakladnieRN.cxTabSheet2Show(Sender: TObject);
begin
  inherited;
//  frameScanFile1.OpenDataSet;
end;

procedure Tframe10NakladnieRN.DeleteRecord;
begin
  DeleteCurrentSWNDocument(Self);
end;

function Tframe10NakladnieRN.GetPhoneNumber;
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

procedure Tframe10NakladnieRN.DoActionPrihodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de incasare', 'Dispozitie de incasare in numerar');
    dialog.TargetDocTypeID := cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО; // Приходный кассовый ордер
    if dialog.ShowModal = mrOk then
    begin
      dmDB.CreatePrihodniiKasoviiOrder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dialog.FLG_ACNT,
        dialog.Rate, dialog.SUMA, dialog.rgModIncasare.ItemIndex);

      if (dialog.rgModIncasare.ItemIndex = 1) then
      begin
        TransferMoneytoOtherUser(dmDB.ibcquerydocs.FieldByName('DT').AsInteger, dmdb.CurrentUserID, dialog.IBCQueryUsers.FieldByName
          ('USERID').AsInteger, dialog.SUMA, dialog.CurrencyID, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 'Livrare');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.DoActionRashodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Dispozitie de plata', 'Dispozitie de plata');
    dialog.TargetDocTypeID := cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО; // Расходный кассовый ордер
    if dialog.ShowModal = mrOk then
    begin
      dmDB.CreateRashodniiKasoviiOrder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dialog.FLG_ACNT,
        dialog.Rate, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.DoAction_BringGoodsDB(const DocID: Integer; const CustomMsg: string);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE PROC_CREATE_DT_EVENT(:DT,1,:MSG,:DOCID,:USERID)';
      Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
      Query.ParamByName('MSG').AsString := CustomMsg;
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
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
end;

procedure Tframe10NakladnieRN.DoCloseDocument(const DocID: Integer);
var
  dialog: TfrmOtgruzkaDlg;
  CanCreateShipment: Boolean;
  // errorDialog:TfrmOtgruzkaChecksDlg;
  ActiuniList: string;
  FLG_CLOSED, fActionOtgruziti: Boolean;
begin
  if (not (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) and
      not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить)) then
    Exit;


  CanCreateShipment := False;

  // Отгрузить
  dialog := TfrmOtgruzkaDlg.Create(Self);
  try
    dialog.DocID := DocID;
    if dialog.ShowModal = mrYes then
    begin
      CanCreateShipment := True;
      ActiuniList := dialog.GetActiuneList;
    end;
  finally
    dialog.Free;
  end;

  if CanCreateShipment and dmDB.DoCreateShipmentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, ActiuniList) then
  begin
    dmDB.IBCQueryDocs.Refresh;
    ShowInfoDialog('Expediere produse', 'Expediere cu succes!');
    DocumentSelectionChanged;
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

procedure Tframe10NakladnieRN.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  fTVA: Boolean;
  FLG_PROTECTED, FLG_ACNT, FLG_CLOSED: Boolean;
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
    FLG_PROTECTED := dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1; // Ввод серийников
//    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1; // Отгружен
    FLG_ACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1; // Бухгалтерия
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;
    fTVA := not FLG_CLOSED;

    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

          // popup
    fActionPKO := True; // Приходный кассовый ордер
    fActionRKO := True; // Расходный кассовый ордер
    fActionStartEnterSerials := (not FLG_CLOSED) and (not FLG_PROTECTED); // Начать вводить серийники
    fActionSNS := (not FLG_CLOSED); // Создать наряд на сборку

    fActionBringGoods := (not FLG_CLOSED);
    fActionVSF :=  FLG_ACNT; // Выписать "Счет фактуру"
    fGotoParent := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
    fActionPrintWarranty := True; //FLG_CLOSED or FLG_CLOSED;
    fActiuneCode := (not FLG_CLOSED) and (dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger = 498) and (dmDB.IBCQueryDocs.FieldByName
      ('HAS_JURNAL_GOODS').AsInteger = 1);
    fPrintCek := FLG_CLOSED and not FLG_ACNT;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  bbActiuneTVA.Enabled := fTVA;
  bbApplyPromoCode.Enabled := fTVA;
  bbWinterPromoCode.Enabled := fTVA;

     // popup docs
  bbActionPKO.Enabled := fActionPKO;
  bbActionRKO.Enabled := fActionRKO;
  bbActionStartEnterSerials.Enabled := fActionStartEnterSerials;
  bbActionSNS.Enabled := fActionSNS;
  ButtonStateChanged(fbtCloseDocument, True{fActionOtgruziti});
  ButtonStateChanged(fbtOpenDocument, fActionRollbackOtgruzka);
//  bbActionOtgruziti.Enabled := fActionOtgruziti;
//  bbRollbackOtgruzka.Enabled := ;
  SetCloseDocumentEnabled(True{fActionOtgruziti});
  bbBringGoods.Enabled := fActionBringGoods;
  bbActionVSF.Enabled := fActionVSF;
  bbTTN.Enabled := fActionVSF;
  bbGotoParentDoc.Enabled := fGotoParent;
  bbPrintWarranty.Enabled := fActionPrintWarranty;
  bbCreateCec.Enabled := fPrintCek;
     // goods
  bbCodeActiune.Enabled := fActiuneCode;

  SelectionChanged;
end;

function Tframe10NakladnieRN.DoDBAction(const ActionID, ValueInt: Integer): Boolean;
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
      case ActionID of        // Выписать "Счет фактуру"
        3:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE(:DOCID)';
        // Начать вводить серийники
        4:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_BEGIN_SN_ENTER(:DOCID)';
        // Отмена отгрузки
        7:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_ROLLBACK_SHIPMENT(:DOCID)';
        // Счет на оплату
        8:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_D101_FROM_RASHOD(:DOCID)';
        // Выписать "ТТН"
        9:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_TTN_INVOICE(:DOCID)';
        // Выписать чек
        10:
          Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE_CEC(:DOCID)';
      end;
      // set params
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe10NakladnieRN.DoFrameHide;
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

procedure Tframe10NakladnieRN.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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
  cxGridNPN_CT_NAME.Options.FilterRowOperator := foContains;
  cxGridNPN_PHONELIST.Options.FilterRowOperator := foContains;
end;

procedure Tframe10NakladnieRN.DoOpenDocument(const DocID: Integer);
var
  fActionRollbackOtgruzka, Flg_Closed: Boolean;
begin
   if (not (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) and
      not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить) and
      SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Отменить_отгрузку) ) then
    Exit;


  // Отгрузить
  if ShowAskDialog('Expetidie', 'Anularea expeditiei?') = mrYes then
  begin
    if DoDBAction(7) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      DocumentSelectionChanged;
      ShowInfoDialog('Expeditie', 'Document anulat!');
    end;
  end;
end;

procedure Tframe10NakladnieRN.dxBarButton1Click(Sender: TObject);
begin
  dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, '');
end;

procedure Tframe10NakladnieRN.dxBarButton2Click(Sender: TObject);
begin
  CreateCerereDeLivrare(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe10NakladnieRN.dxBarButton3Click(Sender: TObject);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_GOODS_STOCK_IN_RASHOD', []);
  dmDB.IBCQueryJurnal.Refresh;
end;

procedure Tframe10NakladnieRN.dxBarButton4Click(Sender: TObject);
//var
//  query: TIBCQuery;
begin
  (*TODO: extracted code
  if not dmdb.IBCTrDefaultUpdate.Active then
    dmdb.IBCTrDefaultUpdate.StartTransaction;
  try
    dmdb.ExecuteQuery('execute procedure add_goods2jurnal(:docid, :goodscomplectid, :goodsid)', [dmdb.IBCQueryDocs.FieldByName
      ('DOCID').AsInteger, -1, 173080]);
    dmdb.IBCQueryJurnal.Edit;
    dmdb.IBCQueryJurnal.Post;
    dmdb.IBCTrDefaultUpdate.Commit;
    dmdb.IBCQueryDocs.RefreshRecord;
    dmdb.IBCQueryJurnal.Refresh;
  except
    begin
      dmdb.IBCTrDefaultUpdate.Rollback;
      raise;
    end;
  end;
  *)
  AddDelivery2Jurnal(173080);
  dmdb.IBCQueryJurnal.Refresh;
  dmdb.IBCQueryDocs.RefreshRecord;
end;

procedure Tframe10NakladnieRN.dxBarButton5Click(Sender: TObject);
begin
  inherited;
    (*TODO: extracted code
    var q := TIBCQuery.Create(nil);
    try
        q.SQL.Add('SELECT str FROM GET_SUPPLIER_GOODS_BY_DOCID(:DOCID, FALSE)');
        q.ParamByName('docid').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        q.Open;
        Clipboard.AsText := q.FieldByName('str').AsString;
    finally
        q.Free;
    end;
    *)
  dmdb.GetSupplierGoodsByDocID;
end;

procedure Tframe10NakladnieRN.dxBarButton6Click(Sender: TObject);
begin
  // Livrare Moldova
  AddDelivery2Jurnal(122294);
end;

procedure Tframe10NakladnieRN.bbGoodsChangeUserClick(Sender: TObject);
var
  dialog: Tfrm57ChangeUser;
  userName: string;
begin
  userName := dmDB.IBCQueryJurnal.FieldByName('CREATED_BY_NAME').AsString;
  dialog := Tfrm57ChangeUser.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    if dialog.ShowModal = mrOk then
    begin
      if (ShowAskDialog('Modifica utilizator', Format('Modificarea utilizatorului pentru produsul %s pe urmatorul utilizator %s?',
        [userName, dialog.NewUserName])) = mrYes) and ChangeGoodsUser(dmDB.IBCQueryJurnal.FieldByName('DOCID').AsInteger,
        dmDB.IBCQueryJurnal.FieldByName('DTDEP').AsInteger, dmDB.IBCQueryJurnal.FieldByName('CTDEP').AsInteger, dmDB.IBCQueryJurnal.FieldByName
        ('GOODSCOMPLECT_ID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dialog.NewUserID) then
        dmDB.FullRefresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.bbGoodsForeignCodeClick(Sender: TObject);
begin

  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('STOCK_QTY').AsFloat);
end;

procedure Tframe10NakladnieRN.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe10NakladnieRN.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe10NakladnieRN.bbCheckStockClick(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_DOC_STOCKQTY(:DOCID)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryJurnal.Refresh;
end;

procedure Tframe10NakladnieRN.bbChangeColumnPriceClick(Sender: TObject);
var
  PriceColumn: Integer;
begin
  if CheckIfDocumentisLocked then
    Exit;

  PriceColumn := TdxBarButton(Sender).Tag;
  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName
    ('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, -1, PriceColumn) then
    RefreshData;
end;

procedure Tframe10NakladnieRN.bbChangeDocUserClick(Sender: TObject);
var
  UserName: string;
  dialog: Tfrm57ChangeUser;
begin
  UserName := dmDB.IBCQueryDocs.FieldByName('CREATED_BY_NAME').AsString;
  dialog := Tfrm57ChangeUser.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  dialog.OldUserID := dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger;
  dialog.OldUserName := dmDB.IBCQueryDocs.FieldByName('CREATED_BY_NAME').AsString;
  try
    if dialog.ShowModal = mrOk then
    begin
      if not dmDB.IBCQueryDocs.UpdateTransaction.Active then
        dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
      dmDB.IBCQueryDocs.Edit;
      dmDB.IBCQueryDocs.FieldByName('Created_by').AsInteger := dialog.NewUserID;
      dmDB.IBCQueryDocs.FieldByName('CREATED_BY_NAME').AsString := dialog.NewUserName;
      dmDB.IBCQueryDocs.Post;
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.bbWinterPromoCodeClick(Sender: TObject);
begin
  ShowNewYear2011PromoCodeDialog;
end;

function Tframe10NakladnieRN.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
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

function Tframe10NakladnieRN.GetDiscountText(const DiscountType, DiscountValue: Integer): string;
begin
  case DiscountType of
    1:
      Result := Format('%d%%', [DiscountValue]);
    2:
      Result := Format('%d LEI', [DiscountValue]);
  end;
end;

function Tframe10NakladnieRN.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe10NakladnieRN.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffCustomerType, ffGoods, ffGoodsSN, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe10NakladnieRN.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe10NakladnieRN.InitFrameID: Integer;
begin
     // НАКЛАДНЫЕ. Расходная накладная
  Result := 10;
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
  cxPageControl1.ActivePageIndex := 0;
end;

procedure Tframe10NakladnieRN.ModifyRecord;
var
  dialog: TfrmRNDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) or CheckIfDocumentisLocked then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmRNDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    if dialog.ShowModal = mrOK then
      dmdb.IBCQueryDocComments.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.pmPopupMenuDocsPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe10NakladnieRN.ReadFrameStates;
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

procedure Tframe10NakladnieRN.ShowActiuneTVADialog;
var
  dialog: TfrmActiuneTVAInapoiDlg;
begin
  dialog := TfrmActiuneTVAInapoiDlg.Create(Self);
  try
    dialog.SourceCustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.SourceCustomerName := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    if dialog.ShowModal = mrYes then
    begin
      if ApplyActiuneTVAOverDocumentDB(dialog.TargetCode, dialog.TargetDocID, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger)
        then
      begin
        ShowInfoDialog('Cashback', 'Finisat cu succes!');
        dmDB.FullRefresh;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowActivateActiuneCodeDialog;
var
  dialog: TfrmApplyActiuneCodeDlg;
begin
  dialog := TfrmApplyActiuneCodeDlg.Create(Self);
  try
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  if CheckIfDocumentisLocked then
    Exit;

  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    dialog.AddNewGoods := True;
        // dialog.DefaultPriceColumn:=dmDB.IBCQueryDocs.FieldByName('CONTRACT_PRICECOLUMN').AsInteger;
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowApplyDiscountCodeDialog(const DocID: Integer);
var
  dialog: TfrmProduseCuReducereDlg;
begin
  if ShowAskDialog('Carduri de reducere',
    'Toate produsele si seriile trebuie sa fie introduse inainte de a aplica cardul de reducere! Sunteti gata pentru a aplica Reducerea?')
    <> mrYes then
    Exit;

  dialog := TfrmProduseCuReducereDlg.Create(Self);
  try
    dialog.CurrentDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.CurrentCustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.CurrentCustomerName := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    if dialog.ShowModal = mrYes then
    begin
      if ApplyPromoCodeOverDocumentDB(dialog.PromoCode, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      begin
        ShowInfoDialog('Carduri de reducere', Format('Reducerea (%s) a fost aplicata!', [GetDiscountText(dialog.DiscountType,
          dialog.DiscountValue)]));
        dmDB.FullRefresh;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowBringGoodsDialog;
var
  dialog: TfrmBringGoodsDlg;
begin
  dialog := TfrmBringGoodsDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      DoAction_BringGoodsDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, Trim(dialog.mmComments.Text));
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowCalcProfitabilityByContractDialog(const ContractID: Integer);
var
  dialog: TfrmCalcProfitabilityContractDlg;
begin
  dialog := TfrmCalcProfitabilityContractDlg.Create(Self);
  try
    dialog.ContractID := ContractID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowCalcProfitabilityDialog(const DocID: Integer);
var
  dialog: TfrmCalcProfitabilityDlg;
begin
  dialog := TfrmCalcProfitabilityDlg.Create(Self);
  try
    dialog.DocID := DocID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowCreateTTN;
begin
//     // Выписать "товаро транспортную накладную"
//  if ShowAskDialog('Товаро-транспортная накладная', Format('Вы хотите выписать "Товаро-транспортную накладную" на'#13#10'"%s"?',
//    [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
//  begin
//    if DoDBAction(9) then
//      ShowInfoDialog('Товаро-транспортная накладная', 'Готово!');
//  end;
end;

procedure Tframe10NakladnieRN.ShowModifyGoodsDialog;
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

procedure Tframe10NakladnieRN.ShowNewYear2011PromoCodeDialog;
var
  dialog: TfrmApplyPromoCodeDlg;
begin
  if ShowAskDialog('Новогодний Промо-код',
    'Все товары и их серийные номера должны быть введенны перед применением промо-кода. Вы ввели все товары, все серийники и готовы применить промо-код?')
    <> mrYes then
    Exit;

  dialog := TfrmApplyPromoCodeDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Промо-код', 'Вы точно хотите применить промо-код для этого расхода?') = mrYes then
      begin
        if ApplyPromoCodeDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.PromoCode) then
          dmDB.FullRefresh;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowPrintWarranty;
var
  printEngine: TfrmPrintEngine;
  tmpParams: TReportParamsList;
  reportID: Integer;
begin
     // luam codul raportului din grupa "Гарантийный талон" pentru firma curenta
  reportID := dmDB.GetDefaultReportForReportGroup('WARRANTY');

  if (reportID = -1) then
  begin
    ShowErrorDialog('Eroare', 'Raportul nu a fost gasit!');
    Exit;
  end;

  tmpParams := TReportParamsList.Create;
  printEngine := TfrmPrintEngine.Create(Self);
  try
        // prepare params
    tmpParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').Value);
    tmpParams.SetParamValue('USERID', dmDB.CurrentUserID);
    tmpParams.SetParamValue('USER_NAME', dmDB.CurrentUserFullName);
    printEngine.ReportParams := tmpParams;
    printEngine.AddReport(reportID);
    printEngine.ShowModal;
  finally
    printEngine.Free;
    tmpParams.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowRemoveGoodsDialog;
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

procedure Tframe10NakladnieRN.ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
var
  frmSelectPartsDlg: TfrmSelectPartsDlg;
begin
  frmSelectPartsDlg := TfrmSelectPartsDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    frmSelectPartsDlg.DocsDataSet := dmDB.IBCQueryDocs;
    frmSelectPartsDlg.readonly := ViewOnly;
    if frmSelectPartsDlg.ShowModal = mrOk then
      dmDB.RefreshJurnal;
  finally
    frmSelectPartsDlg.Free;
  end;
end;

procedure Tframe10NakladnieRN.ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
var
  frmSelectSNDlg: TfrmSelectSNDlg;
begin
  frmSelectSNDlg := TfrmSelectSNDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    frmSelectSNDlg.DocsDataSet := dmDB.IBCQueryDocs;
    frmSelectSNDlg.readonly := ViewOnly;
    if frmSelectSNDlg.ShowModal = mrOk then
      dmDB.RefreshJurnal;
  finally
    frmSelectSNDlg.Free;
  end;
end;

function Tframe10NakladnieRN.TestGoodsIdForActiune(const GoodsID: Integer): Boolean;
begin
  Result := (GoodsID = 50128) // TVA Inapoi
    or (GoodsID = 52988) // Reducere pentru actiunea "Новогодний промо-код"
    or (GoodsID = 54252) // Reducere pentru actiunea "Vîrsta Ta = % reducere"
    or (GoodsID = 55108) // Reducere pentru actiunea "Dăm Bani!"
    or (GoodsID = 51346) // Reducere pentru actiunea "Скидка на 2-ю покупку"
    or (GoodsID = 70529); // Reducere pentru actiunea "Happy Hour 2013"
end;

function Tframe10NakladnieRN.ActiuneDiscountSecondBuyHasErrors(const DocID: Integer; const ErrorList: TStringList): Boolean;
var
  Query: TIBCQuery;
  N: Integer;
begin
  Result := False;
  // add separator
  if ErrorList.Count > 0 then
    ErrorList.Add('');

  N := ErrorList.Count;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT ERROR_STR FROM SP_CHECK_ACGOODS_BEFORE_SHIP(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      ErrorList.Add(Query.Fields[0].AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  if (ErrorList.Count > N) then
  begin
    ErrorList.Insert(N, 'Promotie "Reducere la a 2 cumparatura"');
    Result := True;
  end;
end;

function Tframe10NakladnieRN.ActiuneTVAInapoiHasError(const ErrorList: TStringList): Boolean;
var
  SUMA: Double;
  N: Integer;
begin
  Result := False;
  N := ErrorList.Count;
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger <> 498 then
    ErrorList.Add('> Achitarile trebuie sa fie in MDL!')
  else
  begin
    SUMA := VerifyActiuneTVAInapoi_SumaProduselor;

    if SUMA < 100 then
      ErrorList.Add('> Suma produselor trebuie sa fie mai mare de 100 lei!');

    if not VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ErrorList.Add('> Preturile trebuie stabilite la 1 grila!');

    if not VerifyActiuneTVAInapoi_CustomerIsPF(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger) then
      ErrorList.Add('> Clientul nu poate fi persoana juridica sau angajat al companiei!');

    if not VerifyActiuneTVAInapoi_IsCustomerMobileOk(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger) then
      ErrorList.Add('> Numaruld e mobil trebuie indicat!');

    if VerifyActiuneTVAInapoi_HasInvoice(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ErrorList.Add('> Nu a fost eliberata factura!');

    if VerifyActiuneTVAInapoi_DejaInActiune then
      ErrorList.Add('> Nu poti participa de mai multe ori in promotie!');
  end;

  if ErrorList.Count > N then
  begin
    ErrorList.Insert(N, 'Акция "TVA înapoi"');
    Result := True;
  end;
end;


procedure Tframe10NakladnieRN.AddGoodsToContAchizitii(DocID, GoodsID, Qty: Integer);
begin
  dmdb.ExecuteQuery('execute procedure Add_Produse_Cont_Achizitii(:docid, :goodsid, :qty)', [DocID, GoodsID, Qty])
end;

procedure Tframe10NakladnieRN.bbApplyCashbackClick(Sender: TObject);
begin
  try
    dmdb.ExecuteQuery('EXECUTE PROCEDURE SP_APPLY_CASHBACK (:DOCID, 1)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    MessageDlg('Recalculat cu succes', mtInformation, [mbOK], 0);
  finally
    IBCQueryCashback.Open;
    IBCQueryCashback.Refresh;
  end;

end;

procedure Tframe10NakladnieRN.CreateCerereDeLivrare(DocID: Integer);
var
  error_str: string;
  Query: TIBCQuery;
  dialog: Tfrm82SelectLivrareDlg;
begin
  dialog := Tfrm82SelectLivrareDlg.Create(Self, dmDB.IBCConnection);
  try
//       error_str := '';
//       Query := TIBCQuery.Create(Self);
//       try
//          Query.Connection := dmDB.IBCConnection;
//          Query.SQL.Add('SELECT ERROR_STR FROM SP_CREATE_LIVRARE(:DOCID)');
//          Query.ParamByName('DOCID').AsInteger := DocID;
//          Query.ExecSQL;
//          error_str := Query.FieldByName('ERROR_STR').AsString;
//
//          if error_str<>'' then
//             Exception.Create(error_str);
//
//       finally
//          Query.Free;
//       end;
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
          // de adaugat documentul "Rezerva" in "Livrarea" aleasa
    end;

  finally
    dialog.Free;
  end;
end;

procedure Tframe10NakladnieRN.cxPageControl1PageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  if (NewPage = tbCashback) then
  begin
    IBCQueryCashback.Close;
    IBCQueryCashback.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    IBCQueryCashback.Open;
  end;

  if (NewPage = tbsDelivery) then
  begin
    frameDelivery1.IBCQueryDelivery.Open;
    frameDelivery1.IBCQueryStatutLivrari.Open;
    frameDelivery1.IBCQueryDistricts.Open;
    frameDelivery1.IBCQueryCities.Open;
  end;
end;

procedure Tframe10NakladnieRN.DoSelectGoodsSupplier;
begin
  // TODO -cMM: Tframe10NakladnieRN.DoSelectGoodsSupplier default body inserted
end;

procedure Tframe10NakladnieRN.frameDelivery1bbPrintClick(Sender: TObject);
begin
  inherited;
  frameDelivery1.bbPrintClick(Sender);
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_CustomerIsPF(const CustomerID: Integer): Boolean;
var
  Query: TIBCQuery;
  ParentID: Integer;
begin
  Result := True;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT PARENTID FROM TS_CUSTOMER WHERE CUSTOMERID=:CT');
    Query.ParamByName('CT').AsInteger := CustomerID;
    Query.ExecSQL;

    if not Query.Eof then
    begin
      ParentID := Query.Fields[0].AsInteger;
      Result := (ParentID = 7) or (ParentID = 99);
    end;
  finally
    Query.Free;
  end;
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_DejaInActiune: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = 50128 then
    begin
      Result := True;
      Break;
    end;
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_HasInvoice(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT IIF(EXISTS(');
    Query.SQL.Add('SELECT FACTURANO');
    Query.SQL.Add('FROM TDB_DOCS LEFT OUTER JOIN TDB_INVOICES ON (TDB_INVOICES.DOCID=TDB_DOCS.DOCID)');
    Query.SQL.Add('WHERE (PARENTDOCID=:docID) AND (DOCTYPEID=112) AND (TDB_INVOICES.FACTURANO IS NOT NULL)');
    Query.SQL.Add('),1,0) FROM RDB$DATABASE');
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger = 1;
  finally
    Query.Free;
  end;
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_IsCustomerMobileOk(const CustomerID: Integer): Boolean;
var
  Query: TIBCQuery;
  phone: string;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT MOBILE FROM TS_CUST_INFO WHERE CUSTOMERID=:custID');
    Query.ParamByName('custID').AsInteger := CustomerID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      phone := Query.Fields[0].AsString;
      Result := Length(phone) >= 8;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := True;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT IIF(EXISTS(');
    Query.SQL.Add('SELECT GOODSID FROM (');
    Query.SQL.Add('SELECT TDB_JURNAL.GOODSID,');
    Query.SQL.Add('(SELECT PRICE1_LEI-TDB_JURNAL.PRICE FROM VW_TS_GOODS WHERE VW_TS_GOODS.GOODSID=TDB_JURNAL.GOODSID) DIFF');
    Query.SQL.Add('FROM TDB_JURNAL INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_JURNAL.GOODSID)');
    Query.SQL.Add('WHERE (DOCID=:docID) and (TS_GOODS.GOODS_TYPE_ID=4201)');
    Query.SQL.Add(') WHERE DIFF>1),1,0) FROM RDB$DATABASE');
    Query.ParamByName('docID').AsInteger := DocID;
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger = 0;
  finally
    Query.Free;
  end;
end;

function Tframe10NakladnieRN.VerifyActiuneTVAInapoi_SumaProduselor: Double;
var
  i, GoodsType: Integer;
begin
  Result := 0;
  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
  begin
    GoodsType := cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODS_TYPE_ID.Index];
    if (dmDB.IsKit(GoodsType)) then
      Result := Result + cxGridComponentsTable.DataController.Values[i, cxGridDBCol_SUMA.Index];
  end;
end;

function Tframe10NakladnieRN.VerifyBeforePrintWarranty: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
     // pentru a imprima "Garantia", verificam daca sunt toate numerile de serie si partida setate pentru produsele din document
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT HAS_ERROR FROM SP_VERIDYDOCFORWARRANTYPRINT(:ID)';
    Query.ParamByName('ID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger = 0;
  finally
    Query.Free;
  end;
end;

function Tframe10NakladnieRN.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
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

procedure Tframe10NakladnieRN.WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe10NakladnieRN.WhenDocumentPopupMenuOpen;
begin
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe10NakladnieRN.WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe10NakladnieRN.SaveFrameStates;
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

procedure Tframe10NakladnieRN.SelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete: Boolean;
  fSerials, fInActiune: Boolean;
  SerialType, GoodsTypeID: Integer;
  FLG_CLOSED: Boolean;
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
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fGoodsAdd := not FLG_CLOSED; // New item for "Состав"+ Security
    fChangeColumnPrice := not FLG_CLOSED;

    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      SerialType := dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
      GoodsTypeID := dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger;

      fInActiune := TestGoodsIdForActiune(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
      fGoodsEdit := not fInActiune and not FLG_CLOSED; // Modify "Состав" + Security
      fGoodsDelete := not fInActiune and not FLG_CLOSED; // Delete "Состав" + Security
      fSerials := not fInActiune and (GoodsTypeID <> 4214) // Otkat
        and ((SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет));

      fChangeUser := not FLG_CLOSED;
      fGoodsSelected := True;
    end;
    fCheckStock := True;
  end;

  if cxPageControl1.ActivePage = tbsDelivery then
  begin
    if not frameDelivery1.IBCQueryDelivery.Active then
      frameDelivery1.IBCQueryDelivery.Open
    else
      frameDelivery1.IBCQueryDelivery.Refresh;

    if (frameDelivery1.IBCQueryDistricts.Active = True) then
      frameDelivery1.IBCQueryDistricts.Refresh
    else
      frameDelivery1.IBCQueryDistricts.Open;

    frameDelivery1.IBCQueryCities.Open;

    frameDelivery1.IBCQueryStatutLivrari.Open;
  end;


     // goods
  bbNewGoods.Enabled := fGoodsAdd;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbRemoveGoods.Enabled := fGoodsDelete;
  bbShowSerialDialog.Enabled := fSerials;
  bbChangeColumnPrice.Enabled := fChangeColumnPrice;
  bbPriceCol0.Enabled := fChangeColumnPrice;
  bbPriceCol1.Enabled := fChangeColumnPrice;
  bbPriceCol2.Enabled := fChangeColumnPrice;
  bbPriceCol3.Enabled := fChangeColumnPrice;
  bbPriceCol4.Enabled := fChangeColumnPrice;
  bbPriceCol5.Enabled := fChangeColumnPrice;
  bbPriceCol6.Enabled := fChangeColumnPrice;
  bbPriceCol7.Enabled := fChangeColumnPrice;

  bbCheckStock.Enabled := fCheckStock;
  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;
     // popup menu
  bbGoodsChangeUser.Enabled := fChangeUser;
end;

procedure Tframe10NakladnieRN.SetupDefaultFocus;
begin
     // focused grid
  cxGridNPN.SetFocus;
     // set focused column
  cxGridNPN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe10NakladnieRN.SetupQtyFields;
begin
     // Товарные позиции: Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Товарные позиции: Остаток
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe10NakladnieRN.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Удалить);

     // Menu: Отменить проводку
  fSYS_OtmenitiOtgruzku := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Отменить_отгрузку);
  bbActionRKO.Enabled := fSYS_OtmenitiOtgruzku;

  if (not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_R_V_Modifica_utilizatorul_in_document)) then
    bbChangeDocUser.Visible := ivNever;

     // Цена клиента
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить_цены_по_колонке_клиента) or not
    SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Цена_клиента) then
    bbChangeColumnPrice.Visible := ivNever;

     // Колонка цен
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Колонка_цен_0) then
    bbPriceCol0.Visible := ivNever;
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


     // Menu: Изменить пользователя
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить_создателя_в_Журнале_Товаров) then
    bbGoodsChangeUser.Visible := ivNever;
     // Menu: Расчет рентабильности

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Расчет_рентабильности) then
  begin
    bbCalcProfitability.Visible := ivNever;
    fSecurityCalcRentability := False;
  end
  else
    fSecurityCalcRentability := True;

     // Колонка цен
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Видеть_колонку_цен) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    cxGridComponents_PRICE_COLUMN.Visible := False;
    cxGridComponents_PRICE_COLUMN.VisibleForCustomization := False;
  end;
     // Menu: Выписать чек
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать_чек) then
    bbCreateCec.Visible := ivNever;
     // Menu: Выписать товаро-транспортную накладную
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Создать_документ) then
    bbTTN.Visible := ivNever;

     // Обновить остатки
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Обновить_остатки) then
    bbCheckStock.Visible := ivNever;
     // Акции
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Акции) then
    bbActiuni.Visible := ivNever;

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

   	 // Documentul nu participa la calculul salariului
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_Rezervare_Documentul_nu_participa_la_calculul_salariului)
    then
    bbFLG_DOC_SALARY.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_R_V_Ordin_de_incasare_bancar) then
    bbBankIn.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    bbDebtsNotify.Visible := ivNever;
    bbCalcProfitability.Visible := ivNever;
    fSecurityCalcRentability := False;
    cxGridNPNTable_FLG_ACNT.VisibleForCustomization := False;
    cxGridNPNTable_FLG_ACNT.Visible := False;
    bbGoodsPrice.Visible := ivNever;
    bbGoodsInfoCard.Visible := ivNever;
    bbFLG_DOC_SALARY.Visible := ivNever;
  end;

  if (ppJurnal.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupmMenuComponents.PopupMenus.Clear;
end;

procedure Tframe10NakladnieRN.TransferMoneytoOtherUser(const dt, FromUser, ToUser: Integer; Amount: Double; CurrencyID:
  Integer; rashod_docid: integer; comment: string);
begin
  dmDB.ExecuteQuery('execute procedure TransferMoneyToOtherUser( :DT, :FromUser, :ToUser, :Amount, :CurrencyID, :flg_acnt, :rashod_docid, :comment)',
    [dt, FromUser, ToUser, Amount, CurrencyID, 1, rashod_docid, comment]);
end;

end.


unit frame64;

{
  НАКЛАДНЫЕ. Расходная накладная
  DocTypeID = 107
  Frame Index = 64
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, System.UITypes, SWNDataFiltering, SWNBaseFrameUnit,
  SWNDocumentFilters, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox,
  cxImageComboBox, dxBar, MemDS, DBAccess, IBC, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, cxCalc, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxClasses, Vcl.ExtCtrls, cxSplitter, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe64 = class(TSWNBaseFrame)
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
    cxGridNPNTable_FLG_SHIP: TcxGridDBColumn;
    pmPopupMenuDocs: TdxBarPopupMenu;
    bbActionPKO: TdxBarButton;
    bbActionRKO: TdxBarButton;
    bbActionSNS: TdxBarButton;
    bbActionOtgruziti: TdxBarButton;
    bbActionVSF: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    bbActionStartEnterSerials: TdxBarButton;
    cxGridNPNTable_FLG_PROTECTED: TcxGridDBColumn;
    cxGridNPNTable_CUSTOMER_TYPE_ID: TcxGridDBColumn;
    bbRollbackOtgruzka: TdxBarButton;
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
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    bbCreateProformaInvoice: TdxBarButton;
    cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn;
    ppJurnal: TdxBarPopupMenu;
    bbGoodsChangeUser: TdxBarButton;
    bbCreateCec: TdxBarButton;
    bbCheckStock: TdxBarButton;
    bbTTN: TdxBarButton;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridPopupmMenuComponents: TcxGridPopupMenu;
    cxGridComponents_UMID: TcxGridDBColumn;
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
    cxGridComponents_DISCOUNT_P: TcxGridDBColumn;
    cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn;
    bbGoodsPrice: TdxBarButton;
    bbGoodsInfoCard: TdxBarButton;
    cxGridComponents_PRICE_USD: TcxGridDBColumn;
    cxGridComponents_SUMA_USD: TcxGridDBColumn;
    cxGridNPN_DTSC_NAME: TcxGridDBColumn;
    cxGridNPNTableColumn1: TcxGridDBColumn;
    IBCDataSourceDocs: TIBCDataSource;
    IBCQueryDocs: TIBCQuery;
    IBCQueryJurnal: TIBCQuery;
    IBCDataSourceJurnal: TIBCDataSource;
    cxGridNPNTable_DT_NAME: TcxGridDBColumn;
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure bbShowSerialDialogClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure bbActionRKOClick(Sender: TObject);
    procedure bbActionPKOClick(Sender: TObject);
    procedure bbActionSNSClick(Sender: TObject);
    procedure bbActionOtgruzitiClick(Sender: TObject);
    procedure bbActionVSFClick(Sender: TObject);
    procedure cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbActionStartEnterSerialsClick(Sender: TObject);
    procedure cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure pmPopupMenuDocsPopup(Sender: TObject);
    procedure bbRollbackOtgruzkaClick(Sender: TObject);
    procedure bbPrintWarrantyClick(Sender: TObject);
    procedure bbBringGoodsClick(Sender: TObject);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbCalcProfitabilityClick(Sender: TObject);
    procedure cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbActiuneTVAClick(Sender: TObject);
    procedure bbDebtsNotifyClick(Sender: TObject);
    procedure bbApplyPromoCodeClick(Sender: TObject);
    procedure bbWinterPromoCodeClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure bbCodeActiuneClick(Sender: TObject);
    procedure cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbChangeColumnPriceClick(Sender: TObject);
    procedure bbCreateProformaInvoiceClick(Sender: TObject);
    procedure bbGoodsChangeUserClick(Sender: TObject);
    procedure bbCreateCecClick(Sender: TObject);
    procedure bbCheckStockClick(Sender: TObject);
    procedure bbTTNClick(Sender: TObject);
    procedure cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure cxGridComponents_DISCOUNT_PGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponents_DISCOUNT_SUMAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fLastDocID: integer;
    fSYS_OtmenitiOtgruzku: Boolean;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowRemoveGoodsDialog;
    procedure ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
    procedure ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
    function DoDBAction(const ActionID: integer; const ValueInt: integer = 0): Boolean;
    function DoCreateShipmentDB(const DocID: integer; const ActiuneList: string): Boolean;
    procedure CreateNariadNaSborku;
    procedure DoActionPrihodniiKasoviiOrder;
    procedure DoActionRashodniiKasoviiOrder;
    function CheckIfDocumentisLocked: Boolean;
    function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    function VerifyBeforePrintWarranty: Boolean;
    procedure ShowPrintWarranty;
    procedure ShowBringGoodsDialog;
    procedure DoAction_BringGoodsDB(const DocID: integer; const CustomMsg: string);
    procedure ShowCalcProfitabilityDialog(const DocID: integer);
    procedure ShowCalcProfitabilityByContractDialog(const ContractID: integer);
//    function ActiuneTVAInapoiHasError(const ErrorList: TStringList): Boolean;
//    function VerifyActiuneTVAInapoi_SumaProduselor: Double;
//    function VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(const DocID: integer): Boolean;
//    function VerifyActiuneTVAInapoi_CustomerIsPF(const CustomerID: integer): Boolean;
//    function VerifyActiuneTVAInapoi_HasInvoice(const DocID: integer): Boolean;
//    function VerifyActiuneTVAInapoi_IsCustomerMobileOk(const CustomerID: integer): Boolean;
//    function VerifyActiuneTVAInapoi_DejaInActiune: Boolean;

    // procedure ShowActiuneTVADialog;
//    function ApplyActiuneTVAOverDocumentDB(const Code: string; const SourceDocID, TargetDocID: integer): Boolean;
    procedure ShowApplyDiscountCodeDialog(const DocID: integer);
    function ApplyPromoCodeOverDocumentDB(const PromoCode: string; const DocID: integer): Boolean;
//    function ActiuneDiscountSecondBuyHasErrors(const DocID: integer; const ErrorList: TStringList): Boolean;
    function GetDiscountText(const DiscountType, DiscountValue: integer): string;
    procedure ShowNewYear2011PromoCodeDialog;
    function ApplyPromoCodeDB(const DocID: integer; const PromoCode: string): Boolean;

    // procedure ShowActivateActiuneCodeDialog;

    function ChangeGoodsUser(const DocID, DTDEP, CTDEP, GoodsComplectID, GoodsID, NewUserID: integer): Boolean;
    procedure ShowCreateTTN;
    function TestGoodsIdForActiune(const GoodsID: integer): Boolean;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure CloneRecord; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure SetupSecurityItems; override;
    procedure RefreshData; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleAdditions, IBCError, frmRNDocDialog, DataModuleDB, SWNUtils,
  SWNConst, frmSelectSNDialog, SWNTypes, frmSelectPartNumbersDialog,
  frmMoneyIncomeDialog, DateUtils, frmSelectGoodsToAddDialog,
  SWNValueStorageUnit, SWNDBErrors, frmPrintEngineWindow, frmBringGoodsDialog,
  frmCustomerCurrentDebtsDialog, SWNSecurity, frmCalcProfitabilityDialog,
  SWNSecurityFlags, frmOtgruzkaDialog, frmActiuneTVAInapoiDialog,
  frmCustomerNotifyDebtsDialog, frmProduseCuReducereDialog,
  frmOtgruzkaChecksDialog, frmDocumentDeleteDialog, frmApplyPromoCodeDialog,
  frmDocumentCommentsV2Dialog, frmApplyActiuneCodeDialog,
  frmSelectSNParentedDialog, frmSelectPartNumbersParentedDialog,
  frmCalcProfitabilityContractDialog, uChangeUser, SWNCommonDialogs,
  frmCustomersDlg, MainForm;

{$R *.dfm}
{ Tframe10NakladnieRN }

//function Tframe64.ApplyActiuneTVAOverDocumentDB(const Code: string; const SourceDocID, TargetDocID: integer): Boolean;
//var
//  Query: TIBCQuery;
//begin
//  Result := False;
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.AutoCommit := False;
//    Query.Connection := dmDB.IBCConnection;
//    Query.Transaction := dmDB.IBCTrDefaultUpdate;
//    Query.SQL.Text := 'EXECUTE PROCEDURE SP_APPLY_TVA_CODE(:id1,:id2)';
//    // Query.ParamByName('code').AsString:=Code;
//    Query.ParamByName('id1').AsInteger := SourceDocID;
//    Query.ParamByName('id2').AsInteger := TargetDocID;
//    Query.Transaction.StartTransaction;
//    try
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

function Tframe64.ApplyPromoCodeDB(const DocID: integer; const PromoCode: string): Boolean;
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

function Tframe64.ApplyPromoCodeOverDocumentDB(const PromoCode: string; const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_APPLY_GOODS_DISCOUNT(:code,:docid)';
    Query.ParamByName('code').AsString := PromoCode;
    Query.ParamByName('docid').AsInteger := DocID;
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

procedure Tframe64.bbActionOtgruzitiClick(Sender: TObject);
var
  dialog: TfrmOtgruzkaDlg;
  CanCreateShipment: Boolean;
  // errorDialog:TfrmOtgruzkaChecksDlg;
  ActiuniList: string;
begin
  CanCreateShipment := False;

  // Отгрузить
  dialog := TfrmOtgruzkaDlg.Create(Self);
  try
    dialog.DocID := IBCQueryDocs.FieldByName('DOCID').AsInteger;
    if dialog.ShowModal = mrYes then
    begin
      CanCreateShipment := True;
      ActiuniList := dialog.GetActiuneList;
    end;
  finally
    dialog.Free;
  end;

  if CanCreateShipment and DoCreateShipmentDB(IBCQueryDocs.FieldByName('DOCID').AsInteger, ActiuniList) then
  begin
    IBCQueryDocs.Refresh;
    ShowInfoDialog('Отгрузка товара', 'Отгрузили успешно!');
    DocumentSelectionChanged;
  end;
end;

procedure Tframe64.bbActionPKOClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;
  DoActionPrihodniiKasoviiOrder;
end;

procedure Tframe64.bbActionRKOClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;
  DoActionRashodniiKasoviiOrder;
end;

procedure Tframe64.bbActionSNSClick(Sender: TObject);
begin
  CreateNariadNaSborku;
end;

procedure Tframe64.bbActionStartEnterSerialsClick(Sender: TObject);
begin
  // Начать вводить серийники
  // if ShowAskDialog('Начать вводить серийники', 'Вы хотите заблокировать документ для ввода серийных номеров?',
  // 'Только Вы сможеты изменить документ и его состав!') = mrYes then
  // begin
  // if DoDBAction(4) then
  // IBCQueryDocs.Refresh;
  // end;
end;

procedure Tframe64.bbActionVSFClick(Sender: TObject);
begin
  // Выписать "Счет фактуру"
  if ShowAskDialog('Выписать "Счет фактуру"', 'Вы хотите выписать "Счет фактуру"?') = mrYes then
  begin
    if DoDBAction(3) then
      IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe64.bbActiuneTVAClick(Sender: TObject);
begin
  // ShowActiuneTVADialog;
end;

procedure Tframe64.bbApplyPromoCodeClick(Sender: TObject);
begin
  ShowApplyDiscountCodeDialog(cxGridNPNTable.Controller.FocusedRecord.Values[cxGridNPNTableDocID.Index]);
end;

procedure Tframe64.bbBringGoodsClick(Sender: TObject);
begin
  ShowBringGoodsDialog;
end;

procedure Tframe64.bbCalcProfitabilityClick(Sender: TObject);
begin
  if not IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
    ShowCalcProfitabilityByContractDialog(IBCQueryDocs.FieldByName('CONTRACTID').AsInteger)
  else
    ShowCalcProfitabilityDialog(IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe64.bbCodeActiuneClick(Sender: TObject);
begin
  // ShowActivateActiuneCodeDialog;
end;

procedure Tframe64.bbCreateCecClick(Sender: TObject);
begin
  // Выписать чек
  if ShowAskDialog('Выписать чек', 'Вы хотите выписать чек?') = mrYes then
  begin
    if DoDBAction(10) then
    begin
      IBCQueryDocs.Refresh;
      ShowInfoDialog('Выписать чек', 'Готово!');
    end;
  end;
end;

procedure Tframe64.bbCreateProformaInvoiceClick(Sender: TObject);
begin
  // Выписать "Счет на оплату"
  if ShowAskDialog('Счет на оплату', 'Вы хотите Создать "Счет на оплату"?') = mrYes then
  begin
    if DoDBAction(8) then
    begin
      IBCQueryDocs.Refresh;
      ShowInfoDialog('Выписать "Счет на оплату"', 'Готово!');
    end;
  end;
end;

procedure Tframe64.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe64.bbDebtsNotifyClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerNotifyDebts(IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe64.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe64.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe64.bbModifyGoodsClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;
  ShowModifyGoodsDialog
end;

procedure Tframe64.bbNewGoodsClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe64.bbPrintWarrantyClick(Sender: TObject);
begin
  if VerifyBeforePrintWarranty then
    ShowPrintWarranty
  else
    ShowErrorDialog('Ошибка', 'Для печати гарантийного талона нужно проставить все серийные/партийные номера!');
end;

procedure Tframe64.bbRemoveGoodsClick(Sender: TObject);
begin
  if CheckIfDocumentisLocked then
    Exit;

  ShowRemoveGoodsDialog;
end;

procedure Tframe64.bbRollbackOtgruzkaClick(Sender: TObject);
begin
  // Отгрузить
  if ShowAskDialog('Отмена отгрузки', 'Вы хотите вернуть отгруженный товар?') = mrYes then
  begin
    if DoDBAction(7) then
    begin
      IBCQueryDocs.Refresh;
      DocumentSelectionChanged;
      ShowInfoDialog('Отмена отгрузки', 'Отгруженный товар возвращен!');
    end;
  end;
end;

procedure Tframe64.bbShowSerialDialogClick(Sender: TObject);
var
  flg_serial: integer;
begin
  if CheckIfDocumentisLocked then
    Exit;

  flg_serial := IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;

  // Серийный учет
  if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowSelectGoodsSerialNumberDialog(IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1)
  else
    // Партийный учет
 if flg_serial = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowSelectGoodsPartNumberDialog(IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1);
end;

procedure Tframe64.bbTTNClick(Sender: TObject);
begin
  ShowCreateTTN;
end;

function Tframe64.ChangeGoodsUser(const DocID, DTDEP, CTDEP, GoodsComplectID, GoodsID, NewUserID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CHANGE_JURNAL_OWNER(:Created_BY, :docid, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID)';
    Query.ParamByName('Created_BY').AsInteger := NewUserID;
    Query.ParamByName('docid').AsInteger := DocID;
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
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe64.CheckIfDocumentisLocked: Boolean;
var
  UserName: string;
begin
  Result := False;
  if (IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1) and (dmDB.GetDocumentProtectedUser(IBCQueryDocs.FieldByName('DOCID').AsInteger, UserName) <> dmDB.CurrentUserID) then
  begin
    Result := True;
    ShowErrorDialog('Документ заблокирован', 'Данный документ заблокирован для ввода серийных номеров.', '', Format('Пользователь: %s', [UserName]));
  end;
end;

procedure Tframe64.CloneRecord;
var
  S: string;
  newDocID: integer;
begin
  S := IBCQueryDocs.FieldByName('DOCID').AsString;
  if ShowAskDialog('Клонирование документа', 'Создать копию Расходной накладной №' + S + '?') <> mrYes then
    Exit;

  if dmDB.CloneDocumentDB(IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
  begin
    dmDB.RefreshDocs;
    IBCQueryDocs.Locate('DOCID', newDocID, []);
    ShowInfoDialog('Клонирование документа', 'Созданна новая копия.'#13#10'Расходная накладная №' + IBCQueryDocs.FieldByName('DOCID').AsString);
  end;
end;

procedure Tframe64.CreateNariadNaSborku;
var
  Query: TIBCQuery;
  SumaDoc: Currency;
  SumaDocConfig: Currency;
  DocTypeConfig: integer;
  found: Boolean;
begin
  // Создать наряд на сборку
  if ShowAskDialog('Создать наряд на сборку', 'Вы хотите создать наряд на сборку?') = mrYes then
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
      Query.SQL.Text := 'SELECT A.SUMA, B.SUMA, B.DOCTYPEID FROM TDB_DOCS A INNER JOIN TDB_DOCS B ON (B.DOCID=A.PARENTDOCID) WHERE A.DOCID=:DOCID';
      Query.ParamByName('DOCID').AsInteger := IBCQueryDocs.FieldByName('DOCID').AsInteger;
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
        if dmDB.CreateNariadNaSborku_Other_DB(IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
          IBCQueryDocs.Refresh;
          ShowInfoDialog('Наряд на сборку', 'Наряд на сборку сделан!');
        end
      end
      else
        // sumele documentului
 if SumaDoc = SumaDocConfig then
      begin
          // sumele coincid, cream Sborka
        if dmDB.CreateNariadNaSborku_Other_DB(IBCQueryDocs.FieldByName('DOCID').AsInteger) then
        begin
          IBCQueryDocs.Refresh;
          ShowInfoDialog('Наряд на сборку', 'Наряд на сборку сделан!');
        end
      end
      else if DocTypeConfig = 115 then
      begin
        if ShowAskDialog('Наряд на сборку', 'Данные из Расходной накладной отличаются от данных из Конфигуратора!' + #13#10 + #13#10 + 'Вы хотите чтобы данные из Конфигуратора сделать идентичными данным из Расходной накладной и потом ' + 'создать наряд на сборку?', 'Вы можете в ручном режиме сделать исправления в Конфигураторе.') = mrYes then
        begin
          if dmDB.CreateNariadNaSborku_Other_DB(IBCQueryDocs.FieldByName('DOCID').AsInteger) then
          begin
            IBCQueryDocs.Refresh;
            ShowInfoDialog('Наряд на сборку', 'Наряд на сборку сделан!');
          end;
        end;
      end
      else
          // sumele sunt diferite! Operatia este interzisa daca documentul initial este "Счет на оплату"
 if DocTypeConfig = 101 then
        ShowErrorDialog(cMSG_GeneralError_Title, 'Данные из Расходной накладной отличаются от данных из Счета на оплату!' + #13#10#13#10 + 'Наряд на сборку не может быть сделан!');
    end
    else
      ShowErrorDialog(cMSG_GeneralError_Title, 'Данная Расходная накладная должна исходить из Конфигуратора или Счета на оплату!');
  end;
end;

procedure Tframe64.CreateNewRecord;
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

procedure Tframe64.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (not CheckIfDocumentisLocked) and bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe64.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.RecordViewInfo.Selected and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe64.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe64.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if (not VarIsNull(ARecord.Values[cxGridDBCol_STOCK_QTY.Index])) and VarIsNumeric(ARecord.Values[cxGridDBCol_STOCK_QTY.Index]) then
  begin
    if ARecord.Values[cxGridDBCol_STOCK_QTY.Index] < 0 then
      AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
  end;
end;

procedure Tframe64.cxGridComponents_DISCOUNT_PGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridComponents_DISCOUNT_P.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_DISCOUNT_P.Index] = 0) then
      AText := ''
  end;
end;

procedure Tframe64.cxGridComponents_DISCOUNT_SUMAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if VarIsNumeric(ARecord.Values[cxGridComponents_DISCOUNT_SUMA.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_DISCOUNT_SUMA.Index] = 0) then
      AText := ''
  end;
end;

procedure Tframe64.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  N: integer;
begin
  if not VarIsNull(ARecord.Values[cxGridComponents_PRICE_COLUMN.Index]) then
  begin
    N := ARecord.Values[cxGridComponents_PRICE_COLUMN.Index];
    if (N <= 0) or (N >= 4) then
      AStyle := dmAdditions.cxStyle_GridPriceColumnRed;
  end;
end;

procedure Tframe64.cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe64.cxGridNPNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (fSECURITY_CanEdit or fSECURITY_CanView) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe64.cxGridNPNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_SHIP.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_SHIP.Index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
        // Document protejat
        if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_PROTECTED.Index] = 1 then
          ACanvas.Brush.Color := dmAdditions.cxStyle_BackgroundRED.Color;
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridNPNTable_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008B8BC5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end;

    if VarIsFloat(AViewInfo.GridRecord.Values[cxGridNPN_CREATED_DATE.Index]) and VarIsFloat(AViewInfo.GridRecord.Values[cxGridNPN_DATA.Index]) then
    begin
      if AViewInfo.GridRecord.Values[cxGridNPN_DATA.Index] - AViewInfo.GridRecord.Values[cxGridNPN_CREATED_DATE.Index] > 3 then
        ACanvas.Font.Color := dmAdditions.cxStyle1_ExpiredRecord.Font.Color;
      ACanvas.Brush.Color := dmAdditions.cxStyle1_ExpiredRecord.Color;
    end;

  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe64.cxGridNPNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGridNPNTable, Key, Shift);
end;

procedure Tframe64.cxGridNPN_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_CREATED_DATE.Index]);
end;

procedure Tframe64.cxGridNPN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridNPN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridNPN_DATA.Index]);
end;

procedure Tframe64.cxPageControlComplectChange(Sender: TObject);
begin
  SelectionChanged;
end;

procedure Tframe64.DeleteRecord;
begin
  DeleteCurrentSWNDocument(Self);
end;

procedure Tframe64.DoActionPrihodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Приходный кассовый ордер', 'приходного кассового ордера');
    dialog.TargetDocTypeID := cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО;
    // Приходный кассовый ордер
    if dialog.ShowModal = mrOk then
    begin
      dmDB.CreatePrihodniiKasoviiOrder(IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dialog.FLG_ACNT, dialog.Rate, dialog.SUMA, 0);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.DoActionRashodniiKasoviiOrder;
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.SetCustomTitle('Расходный кассовый ордер', 'расходного кассового ордера');
    dialog.TargetDocTypeID := cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО;
    // Расходный кассовый ордер
    if dialog.ShowModal = mrOk then
    begin
      dmDB.CreateRashodniiKasoviiOrder(IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dialog.FLG_ACNT, dialog.Rate, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.DoAction_BringGoodsDB(const DocID: integer; const CustomMsg: string);
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

function Tframe64.DoCreateShipmentDB(const DocID: integer; const ActiuneList: string): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_SHIPMENT2(:DOCID,:ACLIST)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('ACLIST').AsString := ActiuneList;
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

procedure Tframe64.DocumentSelectionChanged;
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
    FLG_PROTECTED := IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger = 1;
    // Ввод серийников
    FLG_SHIP := IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1; // Отгружен
    FLG_ACNT := IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    // Бухгалтерия
    FLG_CLOSED := IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_SHIP or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete and not FLG_SHIP;
    fTVA := not FLG_SHIP;

    fLastDocID := IBCQueryDocs.FieldByName('DOCID').AsInteger;

    // popup
    fActionPKO := True; // Приходный кассовый ордер
    fActionRKO := True; // Расходный кассовый ордер
    fActionStartEnterSerials := (not FLG_SHIP) and (not FLG_PROTECTED);
    // Начать вводить серийники
    fActionSNS := (not FLG_SHIP); // Создать наряд на сборку
    fActionOtgruziti := fSECURITY_CanEdit and (not FLG_SHIP); // Отгрузить
    fActionRollbackOtgruzka := FLG_SHIP and fSYS_OtmenitiOtgruzku;
    fActionBringGoods := (not FLG_SHIP);
    fActionVSF := (not FLG_PROTECTED) and FLG_ACNT; // Выписать "Счет фактуру"
    fActionCalcProfitability := True;
    fGotoParent := not IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
    fActionPrintWarranty := True; // FLG_SHIP;
    fActiuneCode := (not FLG_SHIP) and (IBCQueryDocs.FieldByName('CURRENCYID').AsInteger = 498) and (IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger = 1);
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
  bbActionOtgruziti.Enabled := fActionOtgruziti;
  bbRollbackOtgruzka.Enabled := fActionRollbackOtgruzka;
  bbBringGoods.Enabled := fActionBringGoods;
  bbActionVSF.Enabled := fActionVSF;
  bbTTN.Enabled := fActionVSF;
  bbCalcProfitability.Enabled := fActionCalcProfitability;
  bbGotoParentDoc.Enabled := fGotoParent;
  bbPrintWarranty.Enabled := fActionPrintWarranty;
  bbCreateCec.Enabled := fPrintCek;
  // goods
  bbCodeActiune.Enabled := fActiuneCode;

  SelectionChanged;
end;

function Tframe64.DoDBAction(const ActionID, ValueInt: integer): Boolean;
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
      case ActionID of
        // Выписать "Счет фактуру"
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
      Query.ParamByName('DOCID').AsInteger := IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe64.DoFrameHide;
begin
  // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

  // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridNPNTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

  // 2. De deconectat sursele de date de la griduri
  cxGridComponentsTable.DataController.DataSource := nil;
  cxGridNPNTable.DataController.DataSource := nil;
  dmdb.IBCQueryDocComments.Close;
  dmdb.IBCQueryDocComments.MasterSource := dmdb.IBCDataSourceDocs;

  inherited;
end;

procedure Tframe64.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

  // 1. Legam grid-urile de datasource-sele
  cxGridNPNTable.DataController.DataSource := IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := IBCDataSourceJurnal;

  // 2. Selection handlers
  cxGridNPNTable.OnFocusedRecordChanged := WhenDocumentGrid_FocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGrid_FocusedRecordChanged;

  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  // OpenExternalData(FrameDataFilterInfo);
  IBCQueryDocs.Open;
  IBCQueryJurnal.Open;


  // 4. Selection update
  DocumentSelectionChanged;
  dmdb.IBCQueryDocComments.MasterSource := IBCDataSourceDocs;
  dmdb.IBCQueryDocComments.Open;


end;

procedure Tframe64.bbGoodsChangeUserClick(Sender: TObject);
var
  dialog: Tfrm57ChangeUser;
  UserName: string;
begin
  UserName := IBCQueryJurnal.FieldByName('CREATED_BY_NAME').AsString;
  dialog := Tfrm57ChangeUser.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal);
  try
    if dialog.ShowModal = mrOk then
    begin
      if (ShowAskDialog('Замена пользователя', Format('Вы хотите поменять пользователя товара %s на нового пользователя %s?', [UserName, dialog.NewUserName])) = mrYes) and ChangeGoodsUser(IBCQueryJurnal.FieldByName('DOCID').AsInteger, IBCQueryJurnal.FieldByName('DTDEP').AsInteger, IBCQueryJurnal.FieldByName('CTDEP').AsInteger, IBCQueryJurnal.FieldByName('GOODSCOMPLECT_ID').AsInteger, IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dialog.NewUserID) then
        dmDB.FullRefresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe64.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryJurnal.FieldByName('GOODSID').AsInteger, IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe64.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryJurnal.FieldByName('GOODSID').AsInteger, IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe64.bbCheckStockClick(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('EXECUTE PROCEDURE UPDATE_DOC_STOCKQTY(:DOCID)', [IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  IBCQueryJurnal.Refresh;
end;

procedure Tframe64.bbChangeColumnPriceClick(Sender: TObject);
var
  PriceColumn: integer;
begin
  if CheckIfDocumentisLocked then
    Exit;

  PriceColumn := TdxBarButton(Sender).Tag;
  if dmDB.UpdateJurnalGoodsPricesByColumn(IBCQueryDocs.FieldByName('DOCID').AsInteger, IBCQueryDocs.FieldByName('DTDEP').AsInteger, IBCQueryDocs.FieldByName('CTDEP').AsInteger, -1, PriceColumn) then
    RefreshData;
end;

procedure Tframe64.bbWinterPromoCodeClick(Sender: TObject);
begin
  ShowNewYear2011PromoCodeDialog;
end;

function Tframe64.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
    // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridNPNTable.Site.Focused then
  begin
    // context from Docs
    if cxGridNPN_CT_NAME.Focused then
    begin
      // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridNPN_DATA.Focused then
    begin
      // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridNPN_DTDEP_NAME.Focused then
    begin
      // Склад
      Result.Context := ffStock;
      Result.ValueInt := IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe64.GetDiscountText(const DiscountType, DiscountValue: integer): string;
begin
  case DiscountType of
    1:
      Result := Format('%d%%', [DiscountValue]);
    2:
      Result := Format('%d LEI', [DiscountValue]);
  end;
end;

function Tframe64.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := []; // [fedsDocs,fedsJurnal];
end;

function Tframe64.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffCustomerType, ffGoods, ffGoodsSN, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe64.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe64.InitFrameID: integer;
begin
  // НАКЛАДНЫЕ. Расходная накладная незакрытые по всем филиалам
  Result := 64;
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
end;

procedure Tframe64.ModifyRecord;
var
  dialog: TfrmRNDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) or CheckIfDocumentisLocked then
    Exit;

  if fSECURITY_CanEdit then
    readonly := IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1
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

procedure Tframe64.pmPopupMenuDocsPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

procedure Tframe64.ReadFrameStates;
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

procedure Tframe64.RefreshData;
begin
  inherited;
  IBCQueryDocs.Refresh;
  IBCQueryJurnal.Refresh;
end;

procedure Tframe64.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  if CheckIfDocumentisLocked then
    Exit;

  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal, -1);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    dialog.AddNewGoods := True;
    // dialog.DefaultPriceColumn:=IBCQueryDocs.FieldByName('CONTRACT_PRICECOLUMN').AsInteger;
    dialog.DefaultPriceColumn := IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.ShowApplyDiscountCodeDialog(const DocID: integer);
var
  dialog: TfrmProduseCuReducereDlg;
begin
  if ShowAskDialog('Дискоунт-код', 'Все товары и их серийные номера должны быть введенны перед применением дискоунт-кода. Вы ввели все товары, все серийники и готовы применить дискоунт-код?') <> mrYes then
    Exit;

  dialog := TfrmProduseCuReducereDlg.Create(Self);
  try
    dialog.CurrentDocID := IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.CurrentCustomerID := IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.CurrentCustomerName := IBCQueryDocs.FieldByName('CT_NAME').AsString;
    if dialog.ShowModal = mrYes then
    begin
      if ApplyPromoCodeOverDocumentDB(dialog.PromoCode, IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      begin
        ShowInfoDialog('Дискоунт-код', Format('Скидка из дискоунт-кода (%s) применена!', [GetDiscountText(dialog.DiscountType, dialog.DiscountValue)]));
        dmDB.FullRefresh;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.ShowBringGoodsDialog;
var
  dialog: TfrmBringGoodsDlg;
begin
  dialog := TfrmBringGoodsDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      DoAction_BringGoodsDB(IBCQueryDocs.FieldByName('DOCID').AsInteger, Trim(dialog.mmComments.Text));
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.ShowCalcProfitabilityByContractDialog(const ContractID: integer);
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

procedure Tframe64.ShowCalcProfitabilityDialog(const DocID: integer);
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

procedure Tframe64.ShowCreateTTN;
begin
  // Выписать "товаро транспортную накладную"
  if ShowAskDialog('Товаро-транспортная накладная', Format('Вы хотите выписать "Товаро-транспортную накладную" на'#13#10'"%s"?', [IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
  begin
    if DoDBAction(9) then
      ShowInfoDialog('Товаро-транспортная накладная', 'Готово!');
  end;
end;

procedure Tframe64.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal, -1);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.AddNewGoods := False;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    dialog.DefaultPriceColumn := IBCQueryDocs.FieldByName('CONTRACT_PRICECOLUMN').AsInteger;

    if dialog.ShowModal = mrOk then
    begin
      IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.ShowNewYear2011PromoCodeDialog;
var
  dialog: TfrmApplyPromoCodeDlg;
begin
  if ShowAskDialog('Новогодний Промо-код', 'Все товары и их серийные номера должны быть введенны перед применением промо-кода. Вы ввели все товары, все серийники и готовы применить промо-код?') <> mrYes then
    Exit;

  dialog := TfrmApplyPromoCodeDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Промо-код', 'Вы точно хотите применить промо-код для этого расхода?') = mrYes then
      begin
        if ApplyPromoCodeDB(IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.PromoCode) then
          dmDB.FullRefresh;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe64.ShowPrintWarranty;
var
  printEngine: TfrmPrintEngine;
  tmpParams: TReportParamsList;
  reportID: integer;
begin
  // luam codul raportului din grupa "Гарантийный талон" pentru firma curenta
  reportID := dmDB.GetDefaultReportForReportGroup('WARRANTY');

  if (reportID = -1) then
  begin
    ShowErrorDialog('Ошибка', 'Отчет не найден!');
    Exit;
  end;

  tmpParams := TReportParamsList.Create;
  printEngine := TfrmPrintEngine.Create(Self);
  try
    // prepare params
    tmpParams.SetParamValue('DOCID', IBCQueryDocs.FieldByName('DOCID').Value);
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

procedure Tframe64.ShowRemoveGoodsDialog;
var
  S: string;
begin
  S := Format(cMSG_DELETERECORD_РасходнаяНакладная, [IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  // confirmation
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, S) <> mrYes then
    Exit;

  IBCQueryJurnal.UpdateTransaction.StartTransaction;
  try
    IBCQueryJurnal.Delete;
    IBCQueryJurnal.UpdateTransaction.Commit;
    IBCQueryDocs.Refresh;
  except
    on E: Exception do
    begin
      IBCQueryJurnal.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure Tframe64.ShowSelectGoodsPartNumberDialog(const ViewOnly: Boolean);
var
  frmSelectPartsDlg: TfrmSelectPartsDlg;
begin
  frmSelectPartsDlg := TfrmSelectPartsDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal);
  try
    frmSelectPartsDlg.DocsDataSet := IBCQueryDocs;
    frmSelectPartsDlg.readonly := ViewOnly;
    if frmSelectPartsDlg.ShowModal = mrOk then
      dmDB.RefreshJurnal;
  finally
    frmSelectPartsDlg.Free;
  end;
end;

procedure Tframe64.ShowSelectGoodsSerialNumberDialog(const ViewOnly: Boolean);
var
  frmSelectSNDlg: TfrmSelectSNDlg;
begin
  frmSelectSNDlg := TfrmSelectSNDlg.Create(Self, IBCQueryJurnal, IBCDataSourceJurnal);
  try
    frmSelectSNDlg.DocsDataSet := IBCQueryDocs;
    frmSelectSNDlg.readonly := ViewOnly;
    if frmSelectSNDlg.ShowModal = mrOk then
      dmDB.RefreshJurnal;
  finally
    frmSelectSNDlg.Free;
  end;
end;

function Tframe64.TestGoodsIdForActiune(const GoodsID: integer): Boolean;
begin
  Result := (GoodsID = 50128) // TVA Inapoi
    or (GoodsID = 52988) // Reducere pentru actiunea "Новогодний промо-код"
    or (GoodsID = 54252) // Reducere pentru actiunea "Vîrsta Ta = % reducere"
    or (GoodsID = 55108) // Reducere pentru actiunea "Dăm Bani!"
    or (GoodsID = 51346) // Reducere pentru actiunea "Скидка на 2-ю покупку"
    or (GoodsID = 70529); // Reducere pentru actiunea "Happy Hour 2013"
end;

//function Tframe64.ActiuneDiscountSecondBuyHasErrors(const DocID: integer; const ErrorList: TStringList): Boolean;
//var
//  Query: TIBCQuery;
//  N: integer;
//begin
//  Result := False;
//  // add separator
//  if ErrorList.Count > 0 then
//    ErrorList.Add('');
//
//  N := ErrorList.Count;
//
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Text := 'SELECT ERROR_STR FROM SP_CHECK_ACGOODS_BEFORE_SHIP(:DOCID)';
//    Query.ParamByName('DOCID').AsInteger := DocID;
//    Query.ExecSQL;
//    while not Query.Eof do
//    begin
//      ErrorList.Add(Query.Fields[0].AsString);
//      Query.Next;
//    end;
//  finally
//    Query.Free;
//  end;
//
//  if (ErrorList.Count > N) then
//  begin
//    ErrorList.Insert(N, 'Акция "Скидка на вторую покупку"');
//    Result := True;
//  end;
//end;

//function Tframe64.ActiuneTVAInapoiHasError(const ErrorList: TStringList): Boolean;
//var
//  SUMA: Double;
//  N: integer;
//begin
//  Result := False;
//  N := ErrorList.Count;
//  if IBCQueryDocs.FieldByName('CURRENCYID').AsInteger <> 498 then
//    ErrorList.Add('> Расчет должен быть в леях!')
//  else
//  begin
//    SUMA := VerifyActiuneTVAInapoi_SumaProduselor;
//
//    if SUMA < 100 then
//      ErrorList.Add('> Сумма товаров должна быть больше 100 леев!');
//
//    if not VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(IBCQueryDocs.FieldByName('DOCID').AsInteger) then
//      ErrorList.Add('> Цены должны быть установленны по 1 колонке!');
//
//    if not VerifyActiuneTVAInapoi_CustomerIsPF(IBCQueryDocs.FieldByName('CT').AsInteger) then
//      ErrorList.Add('> Контрагент не должен быть юридическим лицом или сотрудником фирмы!');
//
//    if not VerifyActiuneTVAInapoi_IsCustomerMobileOk(IBCQueryDocs.FieldByName('CT').AsInteger) then
//      ErrorList.Add('> У контрагента должен быть указан номер мобильного телефона!');
//
//    if VerifyActiuneTVAInapoi_HasInvoice(IBCQueryDocs.FieldByName('DOCID').AsInteger) then
//      ErrorList.Add('> Не должны быть выданны Счет-фактуры!');
//
//    if VerifyActiuneTVAInapoi_DejaInActiune then
//      ErrorList.Add('> Нельзя повторно участвовать а акции!');
//  end;
//
//  if ErrorList.Count > N then
//  begin
//    ErrorList.Insert(N, 'Акция "TVA înapoi"');
//    Result := True;
//  end;
//end;

//function Tframe64.VerifyActiuneTVAInapoi_CustomerIsPF(const CustomerID: integer): Boolean;
//var
//  Query: TIBCQuery;
//  ParentID: integer;
//begin
//  Result := True;
//
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Add('SELECT PARENTID FROM TS_CUSTOMER WHERE CUSTOMERID=:ct');
//    Query.ParamByName('ct').AsInteger := CustomerID;
//    Query.ExecSQL;
//    if not Query.Eof then
//    begin
//      ParentID := Query.Fields[0].AsInteger;
//      Result := (ParentID = 7) or (ParentID = 99);
//    end;
//  finally
//    Query.Free;
//  end;
//end;
//
//function Tframe64.VerifyActiuneTVAInapoi_DejaInActiune: Boolean;
//var
//  i: integer;
//begin
//  Result := False;
//  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
//    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = 50128 then
//    begin
//      Result := True;
//      break;
//    end;
//end;
//
//function Tframe64.VerifyActiuneTVAInapoi_HasInvoice(const DocID: integer): Boolean;
//var
//  Query: TIBCQuery;
//begin
//  Result := False;
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Add('SELECT IIF(EXISTS(');
//    Query.SQL.Add('SELECT FACTURANO');
//    Query.SQL.Add('FROM TDB_DOCS LEFT OUTER JOIN TDB_INVOICES ON (TDB_INVOICES.DOCID=TDB_DOCS.DOCID)');
//    Query.SQL.Add('WHERE (PARENTDOCID=:docID) AND (DOCTYPEID=112) AND (TDB_INVOICES.FACTURANO IS NOT NULL)');
//    Query.SQL.Add('),1,0) FROM RDB$DATABASE');
//    Query.ParamByName('docID').AsInteger := DocID;
//    Query.ExecSQL;
//    if not Query.Eof then
//      Result := Query.Fields[0].AsInteger = 1;
//  finally
//    Query.Free;
//  end;
//end;
//
//function Tframe64.VerifyActiuneTVAInapoi_IsCustomerMobileOk(const CustomerID: integer): Boolean;
//var
//  Query: TIBCQuery;
//  phone: string;
//begin
//  Result := False;
//
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Add('SELECT MOBILE FROM TS_CUST_INFO WHERE CUSTOMERID=:custID');
//    Query.ParamByName('custID').AsInteger := CustomerID;
//    Query.ExecSQL;
//    if not Query.Eof then
//    begin
//      phone := Query.Fields[0].AsString;
//      Result := Length(phone) >= 8;
//    end;
//  finally
//    Query.Free;
//  end;
//end;
//
//function Tframe64.VerifyActiuneTVAInapoi_ProduseVinduteDupaCol1(const DocID: integer): Boolean;
//var
//  Query: TIBCQuery;
//begin
//  Result := True;
//
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Add('SELECT IIF(EXISTS(');
//    Query.SQL.Add('SELECT GOODSID FROM (');
//    Query.SQL.Add('SELECT TDB_JURNAL.GOODSID,');
//    Query.SQL.Add('(SELECT PRICE1_LEI-TDB_JURNAL.PRICE FROM VW_TS_GOODS WHERE VW_TS_GOODS.GOODSID=TDB_JURNAL.GOODSID) DIFF');
//    Query.SQL.Add('FROM TDB_JURNAL INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TDB_JURNAL.GOODSID)');
//    Query.SQL.Add('WHERE (DOCID=:docID) and (TS_GOODS.GOODS_TYPE_ID=4201)');
//    Query.SQL.Add(') WHERE DIFF>1),1,0) FROM RDB$DATABASE');
//    Query.ParamByName('docID').AsInteger := DocID;
//    Query.ExecSQL;
//    if not Query.Eof then
//      Result := Query.Fields[0].AsInteger = 0;
//  finally
//    Query.Free;
//  end;
//end;
//
//function Tframe64.VerifyActiuneTVAInapoi_SumaProduselor: Double;
//var
//  i, GoodsType: integer;
//begin
//  Result := 0;
//  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
//  begin
//    GoodsType := cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODS_TYPE_ID.Index];
//    if (GoodsType = cSYSS_GOODS_TYPE_Товар) or (GoodsType = cSYSS_GOODS_TYPE_Товары_для_сервиса) or (GoodsType = cSYSS_GOODS_TYPE_Комплект) // Товар, Комплект
//      then
//      Result := Result + cxGridComponentsTable.DataController.Values[i, cxGridDBCol_SUMA.Index];
//  end;
//end;

function Tframe64.VerifyBeforePrintWarranty: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  // pentru a imprima "Garantia", verificam daca sunt toate numerile de serie si partida setate pentru produsele din document
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT HAS_ERROR FROM SP_VERIDYDOCFORWARRANTYPRINT(:ID)';
    Query.ParamByName('ID').AsInteger := IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ExecSQL;
    if not Query.Eof then
      Result := Query.Fields[0].AsInteger = 0;
  finally
    Query.Free;
  end;
end;

function Tframe64.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
  begin
    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure Tframe64.WhenDocumentGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe64.WhenDocumentPopupMenuOpen;
begin
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe64.WhenGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe64.SaveFrameStates;
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

procedure Tframe64.SelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete: Boolean;
  fSerials, fInActiune: Boolean;
  SerialType, GoodsTypeID: integer;
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
    FLG_SHIP := IBCQueryDocs.FieldByName('FLG_SHIP').AsInteger = 1;

    fGoodsAdd := not FLG_SHIP; // New item for "Состав"+ Security
    fChangeColumnPrice := not FLG_SHIP;

    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      SerialType := IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
      GoodsTypeID := IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger;

      fInActiune := TestGoodsIdForActiune(IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
      fGoodsEdit := not fInActiune and not FLG_SHIP;
      // Modify "Состав" + Security
      fGoodsDelete := not fInActiune and not FLG_SHIP;
      // Delete "Состав" + Security
      fSerials := not fInActiune and (GoodsTypeID <> 4214) // Otkat
        and ((SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет));

      fChangeUser := not FLG_SHIP;
      fGoodsSelected := True;
    end;
    fCheckStock := True;
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

procedure Tframe64.SetupDefaultFocus;
begin
  // focused grid
  cxGridNPN.SetFocus;
  // set focused column
  cxGridNPN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe64.SetupQtyFields;
begin
  // Товарные позиции: Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
  // Товарные позиции: Остаток
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe64.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Удалить);

  // Menu: Отменить проводку
  fSYS_OtmenitiOtgruzku := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Отменить_отгрузку);

  // Цена клиента
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Изменить_цены_по_колонке_клиента) or not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Цена_клиента) then
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
    bbCalcProfitability.Visible := ivNever;
  // Колонка цен
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Видеть_колонку_цен) or SWNSecurityManager.IsPartialAccessMode then
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
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsInfoCard.Visible := ivNever;

  // Изменить цены товара
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPrice.Visible := ivNever;

  // Соответствие товара в других фирмах
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    bbDebtsNotify.Visible := ivNever;
    bbCalcProfitability.Visible := ivNever;
    cxGridNPNTable_FLG_ACNT.VisibleForCustomization := False;
    cxGridNPNTable_FLG_ACNT.Visible := False;
    bbGoodsPrice.Visible := ivNever;
    bbGoodsInfoCard.Visible := ivNever;
  end;

  if (ppJurnal.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupmMenuComponents.PopupMenus.Clear;
end;

end.


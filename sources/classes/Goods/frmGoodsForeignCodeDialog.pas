unit frmGoodsForeignCodeDialog;

interface

uses
  Classes,
  Controls,
  DB,
  DBAccess,
  DataModuleDB,
  DialogTitle,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  IBC,
  MemDS,
  Messages,
  SWNBaseUnit,
  StdCtrls,
  SysUtils,
  System.JSON,
  Variants,
  Windows,
  cxButtons,
  cxCalc,
  cxCalendar,
  cxCheckBox,
  cxClasses,
  cxContainer,
  cxControls,
  cxCustomData,
  cxDBData,
  cxDBLookupComboBox,
  cxDBVGrid,
  cxData,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDataStorage,
  cxEdit,
  cxFilter,
  cxGraphics,
  cxGrid,
  cxGridBandedTableView,
  cxGridCustomTableView,
  cxGridCustomView,
  cxGridDBBandedTableView,
  cxGridDBTableView,
  cxGridLevel,
  cxGridTableView,
  cxImageComboBox,
  cxInplaceContainer,
  cxLabel,
  cxLookAndFeelPainters,
  cxLookAndFeels,
  cxMemo,
  cxNavigator,
  cxPC,
  cxStyles,
  cxTextEdit,
  cxVGrid,
  dxBar,
  dxBarBuiltInMenu,
  dxDateRanges,
  dxScrollbarAnnotations,
  dxSpreadSheetConditionalFormatting,
  Vcl.Menus,
  cxButtonEdit,
  frmWebPromoActiuniDialog,
  cxDBLabel,
  dxTokenEdit,
  dxUIAClasses,
  B2B.DMlink,
  B2B.DMLink.Thread,
  B2B.DMLinkClient,
  SCOPAPIClientUnit,
  B2BClientUltra;

const
  // Credentialele API-urilor de furnizor NU stau in cod: se citesc din
  // TS_API_CONFIG (vezi "DB Model\ts_api_config.sql"), randurile cu PARAM_NAME
  // in (BASE_URL, USERNAME, PASSWORD). Se administreaza din meniul
  // Setari > Configurari API. Aici raman doar codurile si valorile implicite.
  C_UltraApiCode = 'ULTRA_ESHOP';
  C_UltraApiDefaultURL = 'https://eshop.ultra.md/api';
  C_ScopApiCode = 'SCOP';
  C_ScopApiDefaultURL = 'https://api.scop.md';
  // DMLink nu se apeleaza prin HTTP din WMS, ci prin DLL-ul construit din
  // proiectul separat sources\b2b.api\dmlink\B2BDMLInkDLL.dproj (adresa
  // serviciului este in DLL). Calea se poate suprascrie cu parametrul DLL_PATH.
  C_DMLinkApiCode = 'DMLINK';
  C_DMLinkDefaultDLL = 'B2BDMLInk.dll';

type
  TdxSpreadSheetCustomConditionalFormattingRuleAccess = class(TdxSpreadSheetCustomConditionalFormattingRule);

  // Rezultatul interogarii Ultra.md eShop API pentru un cod de produs (ultra_code).
  // Moneda goala inseamna ca tipul de pret respectiv nu vine pentru produsul cerut.
  TUltraStockInfo = record
    Code: string;
    Name: string;
    Quantity: Double;
    UpdatedAt: string;
    PriceUser: Double;
    PriceUserCurrency: string;
    PriceD: Double;
    PriceDCurrency: string;
    PriceFixed: Double;
    PriceFixedCurrency: string;
    PricePromo: Double;
    PricePromoCurrency: string;
    StatusCode: Integer;
  end;

TfrmGoodsForeignCodeDlg = class(TSWNCustomForm)
    dxBarPopupMenu1: TdxBarPopupMenu;
    pnClient: TPanel;
    dxBarManagerGoods: TdxBarManager;
    dxBarManagerGoodsBar2: TdxBar;
    bbForeignNew: TdxBarButton;
    bbForeignModify: TdxBarButton;
    bbForeignDelete: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    cxGridForeign: TcxGrid;
    pnGoods: TPanel;
    IBCQueryForeign: TIBCQuery;
    IBCDataSourceForeign: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    bbCall: TdxBarButton;
    bbRemoveForcedFlag: TdxBarButton;
    bbSetForcesFlag: TdxBarButton;
    bbAVAILABLE_QTY: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbInstrumente: TdxBarSubItem;
    bbGoodsMoves: TdxBarButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    mmGoods: TcxMemo;
    bbGoodsPriceHistory: TdxBarButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxLabel1: TcxLabel;
    IBCQueryPromos: TIBCQuery;
    IBCDataSourcePromos: TIBCDataSource;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow;
    cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBMultiEditorRow2: TcxDBMultiEditorRow;
    cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow;
    lbQty: TcxLabel;
    cxGridForeignLevel1: TcxGridLevel;
    cxGridForeignDBBandedTableView1: TcxGridDBBandedTableView;
    TV1_GOODS_CODE: TcxGridDBBandedColumn;
    TV1_GOODSID: TcxGridDBBandedColumn;
    TV1_CUSTOMER_NAME: TcxGridDBBandedColumn;
    TV1_BARCODE: TcxGridDBBandedColumn;
    TV1_FLG_IN_PRICE: TcxGridDBBandedColumn;
    TV1_FLG_PREORDER: TcxGridDBBandedColumn;
    TV1_FLG_SUPPLIER_PROMO: TcxGridDBBandedColumn;
    TV1_FLG_SUPPLIER_PRIORITY: TcxGridDBBandedColumn;
    TV1_PRICE1: TcxGridDBBandedColumn;
    TV1_CURRENCY1ID: TcxGridDBBandedColumn;
    TV1_PRICE2: TcxGridDBBandedColumn;
    TV1_CURRENCY2ID: TcxGridDBBandedColumn;
    TV1_PRICE3: TcxGridDBBandedColumn;
    TV1_CURRENCY3ID: TcxGridDBBandedColumn;
    TV1_PRICE5: TcxGridDBBandedColumn;
    TV1_CURRENCY5ID: TcxGridDBBandedColumn;
    TV1_PRICE6: TcxGridDBBandedColumn;
    TV1_CURRENCY6ID: TcxGridDBBandedColumn;
    TV1_PRICE7: TcxGridDBBandedColumn;
    TV1_CURRENCY7ID: TcxGridDBBandedColumn;
    TV1_flg_min_purchaise_price: TcxGridDBBandedColumn;
    TV1_PRICE4MDL: TcxGridDBBandedColumn;
    TV1_DIFF47: TcxGridDBBandedColumn;
    TV1_PERCENT47: TcxGridDBBandedColumn;
    TV1_PRICE7_LEI: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleBKGreen: TcxStyle;
    cxStyleGray: TcxStyle;
    TV1_FLG_RRP: TcxGridDBBandedColumn;
    tv1_PriceIndicativ: TcxGridDBBandedColumn;
    TV1_CUSTOMERID: TcxGridDBBandedColumn;
    TV1_MODIFY: TcxGridDBBandedColumn;
    cxStyleHidden: TcxStyle;
    TV1_GOODS_TITLE: TcxGridDBBandedColumn;
    cxStyleNormal: TcxStyle;
    ShapeQty: TShape;
    TV1_MARGIN5: TcxGridDBBandedColumn;
    TV_MARGIN6: TcxGridDBBandedColumn;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    lblSupplier: TcxLabel;
    tb1_ModifyPrice7: TcxGridDBBandedColumn;
    cxStylePreOrder: TcxStyle;
    IBCQueryCatalog: TIBCQuery;
    IBCDataSourceCatalog: TIBCDataSource;
    cxLabel4: TcxLabel;
    lbPath: TcxLabel;
    cxStyleBold: TcxStyle;
    TV1_PRICE4: TcxGridDBBandedColumn;
    cxStyleNoCurrency: TcxStyle;
    IBCQueryCustomerInfo: TIBCQuery;
    cxLabel5: TcxLabel;
    lbURL: TcxDBLabel;
    IBCDataSourceCustomerInfo: TIBCDataSource;
    bbSupllierApi: TdxBarButton;
    bbSelectCreditOption: TdxBarButton;
    bbDebts: TdxBarButton;
    TV1_PRICE0_LEI: TcxGridDBBandedColumn;
    dxBarButton1: TdxBarButton;
    btnRefresh: TdxBarButton;
    bbPricePolicy: TdxBarButton;
    TV1_FLG_DRP: TcxGridDBBandedColumn;
    TV1_MARGIN01: TcxGridDBBandedColumn;
    cxGridForeignDBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGridForeignDBBandedTableView1Column2: TcxGridDBBandedColumn;
    bbCopyToPartner: TdxBarButton;
    TV1_DIF01: TcxGridDBBandedColumn;
    TV1_PRICE_CREDIT0: TcxGridDBBandedColumn;
    procedure cxGridForeignTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbForeignNewClick(Sender: TObject);
    procedure bbForeignModifyClick(Sender: TObject);
    procedure bbForeignDeleteClick(Sender: TObject);
    procedure cxGridForeignTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbCallClick(Sender: TObject);
    procedure bbRemoveForcedFlagClick(Sender: TObject);
    procedure bbSetForcesFlagClick(Sender: TObject);
    function BarItemVisible(const Visible: Boolean): TdxBarItemVisible;
    procedure bbAVAILABLE_QTYClick(Sender: TObject);
    procedure bbGoodsMovesClick(Sender: TObject);
    procedure bbGoodsPriceHistoryClick(Sender: TObject);
    procedure cxGridForeignDBBandedTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridForeignDBBandedTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxDBVerticalGrid1DBEditorRow2EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure TV1_CURRENCY7IDCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbSupllierApiClick(Sender: TObject);
    procedure bbSelectCreditOptionClick(Sender: TObject);
    procedure bbDebtsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure bbPricePolicyClick(Sender: TObject);
    procedure bbCopyToPartnerClick(Sender: TObject);
  private { Private declarations }
    fGoodsInfo: TGoodsInfo;
    fGoodsID: Integer;
    FQty: Double;
    FSupplierID: Integer;
    FUltraToken: string;
    FUltraTokenExpires: TDateTime;
    FUltraApiURL: string;
    FUltraApiUser: string;
    FUltraApiPassword: string;
    FUltraConfigLoaded: Boolean;
    procedure ReadGoodsInfo;
    procedure SelectionChanged;
    procedure ShowAddNewCodeDialog;
    procedure ShowModifyCodeDialog;
    procedure DeleteSelectedCode;
    procedure PrepareDataSet;
    procedure SetGoodsID(const Value: Integer);
    procedure SetQty(const Value: Double);
    procedure AddGoodsToCreditRetail(ACid: Integer);
    procedure GetDMLinkProductStock(GoodsCode: string);
    procedure GetGoodsBalance_198;
    procedure GetGoodsBalance_261523;
    procedure GetMuncitorulProductStock(GoodsCode: string);
    procedure GetScopProductStock(GoodsCode: string);
    procedure GetUltraProductStock(GoodsCode: string);
    procedure ReadApiConfig(const AApiCode: string; AValues: TStrings);
    procedure LoadApiConfig(const AApiCode, ADefaultURL: string;
      out ABaseURL, AUser, APassword: string);
    procedure LoadUltraApiConfig;
    function UltraApiLogin: Boolean;
    function UltraApiGetJson(const APath: string; out AJson: TJSONValue; out AStatusCode: Integer): Boolean;
    procedure ParseBallanceQty(url: string);

  protected { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure SaveStates; override;
    procedure LoadStates; override;
  public
    function GetLowestPrice7RowIndex(Sender: TcxGridDBBandedTableView): Integer; overload;
    function GetUltraStock(const AGoodsCode: string; out AInfo: TUltraStockInfo): Boolean;
    function GetDMLinkStock(const AGoodsCode: string; out AInfo: TB2BProductInfo;
      out AError: string): Boolean;
    { Public declarations }
    property GoodsID: Integer read fGoodsID write SetGoodsID;
    property Qty: Double read FQty write SetQty;
    property SupplierID: Integer read FSupplierID write FSupplierID;
  end;

implementation

uses
  DataModuleAdditions,
  MainForm,
  SWNSecurityFlags,
  SWNUtils,
  SWNValueStorageUnit,
  clipbrd,
  dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetCore,
  frmGoodsForeignCodeEditorDialog,
  frmGoodsInfoCardDialog,
  frmHistoryGoodsPriceForeignUnit,
  frmSelectPhoneNumberUnit,
  System.UITypes,
  IdHTTP,
  System.Math,
  System.Generics.Collections,
  frmCrediteRetailUnit,
  frmCustomerCurrentDebtsDialog,
  System.Net.HttpClient,
  frmPriceTypesUnit,
  MSHTML,
  Winapi.ActiveX,
  System.Net.URLClient,
  System.NetConsts,
  System.NetEncoding,
  System.DateUtils,
  AccentGuidRepo,
  AccentAuthService;

{$R *.dfm}

function TfrmGoodsForeignCodeDlg.BarItemVisible(const Visible: Boolean): TdxBarItemVisible;
begin
  if Visible then
    Result := ivAlways
  else
    Result := ivNever;
end;

procedure TfrmGoodsForeignCodeDlg.bbCallClick(Sender: TObject);
var
  frmSelectPhoneNumber: TfrmSelectPhoneNumber;
begin
  frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
  try
    frmSelectPhoneNumber.CustomerID := IBCQueryForeign.FieldByName('CUSTOMERID').AsInteger;
    frmSelectPhoneNumber.Caption := 'Alegeti numarul de apel pentru: ' + IBCQueryForeign.FieldByName('CUSTOMER_NAME').AsString;

    if frmSelectPhoneNumber.ShowModal = mrOk then
    begin
      frmMainForm.frameSipClient1.PhoneEdit.Text := frmSelectPhoneNumber.SelectedPhoneNumber;
      frmMainForm.frameSipClient1.CallActionExecute(Sender);
      Application.ProcessMessages;
    end;
  finally
    frmSelectPhoneNumber.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.bbCopyToPartnerClick(Sender: TObject);
begin
  var s: string;
  s := IBCQueryForeign.FieldByName('CUSTOMER_NAME').AsString;
  s := s + ' **' + IBCQueryForeign.FieldByName('GOODS_code').AsString + '**';
  s := s + ' ' + IBCQueryForeign.FieldByName('GOODS_TITLE').AsString;
  clipbrd.Clipboard.AsText := s;
end;

procedure TfrmGoodsForeignCodeDlg.bbDebtsClick(Sender: TObject);
var
  dialog: TfrmCustomerCurrentDebtsDlg;
begin
  dialog := TfrmCustomerCurrentDebtsDlg.Create(Self);
  try
    dialog.CustomerID := IBCQueryForeign.FieldByName('CUSTOMERID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.bbForeignDeleteClick(Sender: TObject);
begin
  DeleteSelectedCode;
end;

procedure TfrmGoodsForeignCodeDlg.bbForeignModifyClick(Sender: TObject);
begin
  ShowModifyCodeDialog;
end;

procedure TfrmGoodsForeignCodeDlg.bbForeignNewClick(Sender: TObject);
begin
  ShowAddNewCodeDialog;
end;

procedure TfrmGoodsForeignCodeDlg.cxGridForeignTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbForeignModify.Enabled then
  begin
    bbForeignModifyClick(bbForeignModify);
    AHandled := True;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.cxGridForeignTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmGoodsForeignCodeDlg.DeleteSelectedCode;
begin
  if ShowAskDialog('Coduri produse furnizori', Format('Stergeti codul "%s"?', [IBCQueryForeign.FieldByName('GOODS_CODE').AsString]))
    = mrYes then
  begin
    IBCQueryForeign.Delete;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.dxBarButton1Click(Sender: TObject);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Transaction := IBCTrUpdate;
    if not IBCTrUpdate.Active then
      IBCTrUpdate.StartTransaction;
    q.SQL.Text := 'EXECUTE PROCEDURE RESET_GOODS_FOREIGN_PRICES(:GOODSID, :CUSTOMERID)';
    q.ParamByName('GOODSID').AsInteger := IBCQueryForeign.FieldByName('GOODSID').AsInteger;
    q.ParamByName('CUSTOMERID').AsInteger := IBCQueryForeign.FieldByName('CUSTOMERID').AsInteger;
    q.Execute;
    IBCTrUpdate.Commit;
  finally
    q.Free;
  end;

  IBCQueryForeign.Refresh;
end;

procedure TfrmGoodsForeignCodeDlg.bbAVAILABLE_QTYClick(Sender: TObject);
begin
  IBCQueryForeign.Edit;
  IBCQueryForeign.FieldByName('FLG_AVAILABLE_QTY').AsInteger := 1;
  IBCQueryForeign.Post;
end;

procedure TfrmGoodsForeignCodeDlg.bbGoodsMovesClick(Sender: TObject);
var
  dialog: TfrmGoodsInfoCardDlg;
begin
  dialog := TfrmGoodsInfoCardDlg.Create(Self);
  try
    dialog.SetGoodsInfo(IBCQueryForeign.FieldByName('GOODSID').AsInteger, IBCQueryForeign.FieldByName('GOODS_TITLE').AsString);
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.bbGoodsPriceHistoryClick(Sender: TObject);
var
  dialog: TfrmHistoryGoodsPriceForeignDlg;
begin
  dialog := TfrmHistoryGoodsPriceForeignDlg.Create(Self, IBCQueryForeign, IBCDataSourceForeign);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.bbPricePolicyClick(Sender: TObject);
var
  dialog: TfrmPriceTypesDlg;
  Query: TIBCQuery;
begin
  dialog := TfrmPriceTypesDlg.Create(Self, dmDB.IBCConnection);
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Add('select distinct TP.PGT_ID, TP.PRICECOLUMN, TP.MIN_VALUE, TP.MAX_VALUE, TP.FORMULA');
    Query.SQL.Add('from TPRICE_GOODSTYPE TP');
    Query.SQL.Add('inner join TWEB_CATALOG C on C.PGT_ID = TP.PGT_ID and');
    Query.SQL.Add('C.DT = 5213 and get_flg_value(c.flags, 0) = 1');
    Query.SQL.Add('inner join TWEB_CATALOG_ITEMS I on I.CATALOGID = C.CATALOGID and');
    Query.SQL.Add('C.PGT_ID = TP.PGT_ID');
    Query.SQL.Add('inner join TS_GOODS G on G.PARENTID = I.GOODSPARENTID and');
    Query.SQL.Add('G.GOODSID = :goodsid');
    Query.SQL.Add('order by tp.pgt_id desc, TP.PRICECOLUMN, TP.MIN_VALUE');
    Query.ParamByName('GOODSID').AsInteger := IBCQueryForeign.FieldByName('GOODSID').AsInteger;
    Query.Open;

    dialog.PGT_ID := Query.FieldByName('PGT_ID').AsInteger;
    dialog.GoodsID := IBCQueryForeign.FieldByName('GOODSID').AsInteger;
    dialog.ShowModal;
  finally
    Query.Free;
    dialog.Free;
  end;

end;

procedure TfrmGoodsForeignCodeDlg.bbRemoveForcedFlagClick(Sender: TObject);
begin
  IBCQueryForeign.Edit;
  IBCQueryForeign.FieldByName('FLG_IN_PRICE').AsInteger := 0;
  IBCQueryForeign.FieldByName('FLG_SUPPLIER_PRIORITY').AsInteger := 0;
  IBCQueryForeign.Post;
end;

procedure TfrmGoodsForeignCodeDlg.bbSelectCreditOptionClick(Sender: TObject);
var
  d: TfrmCrediteRetailDlg;
begin
  d := TfrmCrediteRetailDlg.Create(Self, dmDB.IBCConnection);
  try
    if (d.ShowModal = mrOk) then
    begin
      AddGoodsToCreditRetail(d.cid);
    end;

  finally
    d.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.AddGoodsToCreditRetail(ACid: Integer);
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Transaction := IBCTrUpdate;
    if not q.Transaction.Active then
      q.Transaction.StartTransaction;
    q.SQL.Text := 'insert into tcredite_goods(cid, goods_code, customerid) values (:cid, :goods_code, :customerid)';
    q.Prepare;

    try
      q.ParamByName('goods_code').AsString := IBCQueryForeign.FieldByName('goods_code').AsString;
      q.ParamByName('cid').AsInteger := ACid;
      q.ParamByName('customerid').AsInteger := IBCQueryForeign.FieldByName('customerid').AsInteger;
      q.Execute;
      if q.Transaction.Active then
        q.Transaction.Commit;
    except
      on E: Exception do
      begin
        q.Transaction.Rollback;
        raise;
      end;
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.bbSetForcesFlagClick(Sender: TObject);
begin
  IBCQueryForeign.Edit;
  IBCQueryForeign.FieldByName('FLG_IN_PRICE').AsInteger := 1;
  IBCQueryForeign.Post;
end;

procedure TfrmGoodsForeignCodeDlg.bbSupllierApiClick(Sender: TObject);
begin
    // accent
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 198) then // accent
    GetGoodsBalance_198;
    // dehome
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 261523) then  // dehome
    GetGoodsBalance_261523;
    // 229466 DMLink
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 229466) then
    GetDMLinkProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString);
    // triomac
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 209280) then
    GetScopProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString);
    // ultra
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 202294) then
    GetUltraProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString);
    // muncitorul.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 251465) then
    GetMuncitorulProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString);

end;

procedure TfrmGoodsForeignCodeDlg.btnRefreshClick(Sender: TObject);
begin
  IBCQueryForeign.Refresh;
end;

procedure TfrmGoodsForeignCodeDlg.cxDBVerticalGrid1DBEditorRow2EditPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmWebPromoActiuniDlg;
begin
  dialog := TfrmWebPromoActiuniDlg.Create(Self);
  try
    dialog.FirmaID := 5213;
    dialog.KeyFieldValue := IBCQueryPromos.FieldByName('PROMOACTIONID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.cxGridForeignDBBandedTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = 122) or (Key = 90)) and (Shift = [ssCtrl]) then
    Key := 0;

  ProcessCommonKeysBandedTableView(Self, cxGridForeignDBBandedTableView1, Key, Shift)
end;

procedure TfrmGoodsForeignCodeDlg.cxGridForeignDBBandedTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  AStyle := cxStyleNormal;
  if not VarIsNull(ARecord.Values[TV1_FLG_IN_PRICE.Index]) then
    if (ARecord.Values[TV1_FLG_IN_PRICE.Index] = 0) then
    begin
      AStyle := cxStyleGray;
    end
    else
    begin
      GetLowestPrice7RowIndex(cxGridForeignDBBandedTableView1);
      AStyle := cxStyleBold;
    end;

  if not VarIsNull(ARecord.Values[TV1_FLG_PREORDER.Index]) then
    if (ARecord.Values[TV1_FLG_PREORDER.Index] = 1) then
      AStyle := cxStylePreOrder;

end;

procedure TfrmGoodsForeignCodeDlg.FormCreate(Sender: TObject);
begin
  fGoodsInfo := nil;
  Qty := 1;
end;

procedure TfrmGoodsForeignCodeDlg.FormDestroy(Sender: TObject);
begin
  if Assigned(fGoodsInfo) then
    FreeAndNil(fGoodsInfo);
end;

function TfrmGoodsForeignCodeDlg.GetDMLinkStock(const AGoodsCode: string;
  out AInfo: TB2BProductInfo; out AError: string): Boolean;
// Furnizorul 229466. Cererea se face prin B2BDMLInk.dll (proiect Delphi separat):
// DLL-ul se autentifica singur si intoarce produsul dupa SKU. Credentialele vin
// din TS_API_CONFIG (API_CODE = 'DMLINK'), calea DLL-ului din parametrul optional
// DLL_PATH - implicit se cauta langa SWN.exe.
var
  Values: TStringList;
  Client: TB2BDMLinkClient;
  DllPath: string;
  User: string;
  Password: string;
begin
  Result := False;
  AError := '';
  FillChar(AInfo, SizeOf(AInfo), 0);

  if Trim(AGoodsCode) = '' then
    Exit;

  Values := TStringList.Create;
  try
    ReadApiConfig(C_DMLinkApiCode, Values);
    User := Values.Values['USERNAME'];
    Password := Values.Values['PASSWORD'];
    DllPath := Values.Values['DLL_PATH'];
  finally
    Values.Free;
  end;

  if (User = '') or (Password = '') then
    raise Exception.Create('Lipsesc credentialele pentru API-ul ' + C_DMLinkApiCode +
      '. Completati randurile USERNAME si PASSWORD in TS_API_CONFIG ' +
      '(meniul Setari > Configurari API).');

  if DllPath = '' then
    DllPath := C_DMLinkDefaultDLL;
  if ExtractFilePath(DllPath) = '' then
    DllPath := ExtractFilePath(Application.ExeName) + DllPath;
  if not FileExists(DllPath) then
    raise Exception.Create('Nu s-a gasit biblioteca DMLink: ' + DllPath);

  Client := TB2BDMLinkClient.Create(DllPath);
  try
    if not Client.Initialize then
      raise Exception.Create('Initializarea bibliotecii DMLink a esuat: ' + Client.LastError);

    if not Client.Login(User, Password) then
      raise Exception.Create('Autentificare DMLink esuata: ' + Client.LastError);

    Result := Client.GetProduct(Trim(AGoodsCode), AInfo);
    if not Result then
      AError := Client.LastError;
  finally
    Client.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetDMLinkProductStock(GoodsCode: string);
var
  Info: TB2BProductInfo;
  Error: string;
  Found: Boolean;
  Msg: string;
begin
  Screen.Cursor := crHourGlass;
  try
    try
      Found := GetDMLinkStock(GoodsCode, Info, Error);
    except
      on E: Exception do
      begin
        MessageDlg('DMLink API: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if not Found then
  begin
    if Error = '' then
      MessageDlg(Format('Codul "%s" nu a fost gasit in API-ul DMLink.', [GoodsCode]),
        mtWarning, [mbOK], 0)
    else
      MessageDlg('DMLink API: ' + Error, mtError, [mbOK], 0);
    Exit;
  end;

  Msg := Format('Cod DMLink: %s', [string(Info.SKU)]);
  if string(Info.Name) <> '' then
    Msg := Msg + #13#10 + string(Info.Name);

  Msg := Msg + Format(#13#10#13#10'Stoc disponibil: %d', [Info.Stock]);
  if Info.Transit > 0 then
    Msg := Msg + Format(#13#10'In tranzit: %d', [Info.Transit]);

  if Info.NPrice > 0 then
    Msg := Msg + Format(#13#10#13#10'Pret net: %.2f', [Info.NPrice]);
  if Info.SPrice > 0 then
    Msg := Msg + Format(#13#10'Pret special: %.2f', [Info.SPrice]);
  if Info.RPrice > 0 then
    Msg := Msg + Format(#13#10'Pret recomandat: %.2f', [Info.RPrice]);

  if string(Info.BrandName) <> '' then
    Msg := Msg + Format(#13#10#13#10'Brand: %s', [string(Info.BrandName)]);
  if Info.WarrantyPeriod > 0 then
    Msg := Msg + Format(#13#10'Garantie: %d luni', [Info.WarrantyPeriod]);

  MessageDlg(Msg, mtInformation, [mbOK], 0);
end;

function TfrmGoodsForeignCodeDlg.IsFormDataPosted: Boolean;
begin
  if IBCQueryForeign.FieldByName('FLG_IN_PRICE').AsInteger=1 then
  begin
    GoodsID := IBCQueryForeign.FieldByName('goodsid').AsInteger;
    SupplierID:= IBCQueryForeign.FieldByName('customerid').AsInteger;
    Result := True;
  end
  else
  begin
    SupplierID := -1;
    Result := False;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.LoadStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.ReadFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
  begin
    AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridForeignDBBandedTableView1);
  end;
end;

function TfrmGoodsForeignCodeDlg.GetLowestPrice7RowIndex(Sender: TcxGridDBBandedTableView): Integer;
var
  i: Integer;
  minPurchaiseValue: Double;
begin
  Result := -1;
  minPurchaiseValue := 100000;
  for i := 0 to Sender.DataController.RecordCount - 1 do
  begin
    if not VarIsNull(Sender.DataController.Values[i, TV1_FLG_SUPPLIER_PROMO.Index]) and (Sender.DataController.Values[i,
      TV1_FLG_SUPPLIER_PROMO.Index] = 1) and (Sender.DataController.Values[i, TV1_FLG_IN_PRICE.Index] = 1) then
    begin
      lblSupplier.Caption := Sender.DataController.Values[i, TV1_CUSTOMER_NAME.Index];
      Result := i;
      exit;
    end
    else if (Sender.DataController.Values[i, TV1_FLG_IN_PRICE.Index] = 1) then
    begin
      if not VarIsNull(Sender.DataController.Values[i, TV1_PRICE0_LEI.Index]) and (Sender.DataController.Values[i,
        TV1_PRICE0_LEI.Index] > 0) then
      begin
        if (Sender.DataController.Values[i, TV1_PRICE0_LEI.Index] < minPurchaiseValue) then
        begin
          minPurchaiseValue := Sender.DataController.Values[i, TV1_PRICE0_LEI.Index];
          Result := i;

          if (IBCQueryPromos.RecordCount > 0) then
//            if (Sender.DataController.Values[i, TV1_PRICE7_LEI.Index]) > (Sender.DataController.Values[i,
//              TV1_PRICE1.Index]) then
          begin
//              if (Sender.DataController.Values[i, TV1_CUSTOMER_NAME.Index] = IBCQueryPromos.FieldByName
//                ('SUPPLIER_NAME').AsString) then
            begin
              lblSupplier.Caption := IBCQueryPromos.FieldByName('SUPPLIER_NAME').AsString;
              result := i;
              exit;
            end;
          end
          else if (Sender.DataController.Values[i, TV1_PRICE0_LEI.Index] = minPurchaiseValue) and (Sender.DataController.Values
            [i, TV1_CUSTOMER_NAME.Index] = IBCQueryPromos.FieldByName('SUPPLIER_NAME').AsString) then
          begin
            lblSupplier.Caption := IBCQueryPromos.FieldByName('SUPPLIER_NAME').AsString
          end
          else
            lblSupplier.Caption := Sender.DataController.Values[i, TV1_CUSTOMER_NAME.Index];
        end;
      end
      else if (Sender.DataController.Values[i, TV1_PRICE7_LEI.Index] < minPurchaiseValue) or (VarIsNull(Sender.DataController.Values
        [i, TV1_FLG_SUPPLIER_PROMO.Index]) and (Sender.DataController.Values[i, TV1_FLG_SUPPLIER_PROMO.Index] = 1)) then
      begin
        if not VarIsNull(Sender.DataController.Values[i, TV1_PRICE7_LEI.Index]) then
        begin
          minPurchaiseValue := Sender.DataController.Values[i, TV1_PRICE7_LEI.Index];
          Result := i;
          if (IBCQueryPromos.RecordCount > 0) //and
//          (Sender.DataController.Values[i, tv1_PriceIndicativ.Index] = minPurchaiseValue) and
//          (Sender.DataController.Values[i, TV1_CUSTOMER_NAME.Index] = IBCQueryPromos.FieldByName('SUPPLIER_NAME').AsString)
            then
            lblSupplier.Caption := IBCQueryPromos.FieldByName('SUPPLIER_NAME').AsString
          else
            lblSupplier.Caption := Sender.DataController.Values[i, TV1_CUSTOMER_NAME.Index];
        end
      end;
    end;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetGoodsBalance_198;
var
//    guid: string;
  JSONBody: string;
  Params: string;
  Req_Json: TStringStream;
  HttpClient: THTTPClient;
  url: string;
  Response: TMemoryStream;
  JSONArray: TJSONArray;
  LJsonValue: TJSONValue;
  AProduct: TJSONObject;
  j: Integer;
  aPair: TJSONPair;
  s: string;
  Qty: string;
  oqty: string;
var
  Api: TAccentAuthService;
begin
  if IBCQueryForeign.FieldByName('CUSTOMERID').AsInteger = 198 then
  begin
    try
      screen.Cursor := crHourGlass;
      Api := TAccentAuthService.Create('http://b2brestful.accent.md:8090', 'Fantastic.APIUser',
        'D1519F75556D1D689C3C24C721CCFF9C');
      var Repo := TAccentGuidRepo.Create(dmdb.IBCConnection, dmdb.IBCTrDefaultSelect);
      try
        dmdb.AccentGuid := Repo.EnsureTodayGuid(Api);
      finally
        Repo.Free;
      end;
    finally
      screen.Cursor := crDefault;
    end;

    JSONBody := '';
    Params := '{"articul": "' + IBCQueryForeign.FieldByName('GOODS_CODE').AsString + '"}';
    Req_Json := TStringStream.Create(Params, TEncoding.UTF8);
    Req_Json.Position := 0;
    HttpClient := Thttpclient.Create;

    try
      HttpClient.UserAgent :=
        'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
      HttpClient.Accept := 'application/json, text/javascript, */*';
      HttpClient.ContentType := 'application/json; charset=UTF-8';
      HttpClient.AcceptCharSet := 'utf-8';
      url := 'http://b2brestful.accent.md:8090/stockstate/' + dmdb.AccentGuid + '/productcode';
      Response := TMemoryStream.Create;
      var st := TStringList.Create;
      try
        HttpClient.Post(url, Req_Json, Response);
        st.LoadFromStream(Response);
        JSONBody := st.Text;
        begin
          try
            screen.Cursor := crHourGlass;
            var Repo := TAccentGuidRepo.Create(dmdb.IBCConnection, dmdb.IBCTrDefaultSelect);
            Repo.TryClearTodayGuidFromTable;
            try
              dmdb.AccentGuid := Repo.EnsureTodayGuid(Api);
            finally
              Repo.Free;
            end;
          finally
            screen.Cursor := crDefault;
          end;
        end;
      finally
        Response.Free;
        st.Free;
      end;

      if (JSONBody = '') then
      begin
        raise Exception.Create('Eroare de conexiune la API, mai incercati odata.');
      end;

      JSONArray := TJSONArray.Create;

      try
        JSONArray := TJSONArray(TJSONObject.ParseJSONValue(JSONBody));
        for LJsonValue in JSONArray do
        begin
          AProduct := TJSONObject(LJsonValue);
          for j := 0 to AProduct.Count - 1 do
          begin
            aPair := AProduct.Pairs[j];
            s := aPair.JsonString.Value;
            if s = 'qty' then
            begin
              Qty := aPair.JsonValue.Value;
            end;
            if s = 'oqty' then
            begin
              oqty := aPair.JsonValue.Value;
            end;
          end;
        end;
        MessageDlg('Cantitate disponibila: ' + ''#13''#10'' + 'In depozit: ' + Qty + ''#13''#10'' + 'In magazine ' +
          oqty, mtInformation, [mbOK], 0);
      finally
        JSONArray.Free;
      end;
    finally
      HttpClient.Free;
      Req_Json.Free;
    end;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetGoodsBalance_261523;
var
  allDivs: OleVariant;
  atags: OleVariant;
  Body: OleVariant;
  Doc: IHTMLDocument2;
  href: string;
  HttpClient: THTTPClient;
  url: string;
  HTMLBody: TSTringlist;
  Response: TMemoryStream;
  v: OleVariant;
  I: Integer;
begin
  HttpClient := Thttpclient.Create;
  HTMLBody := TSTringlist.Create;
  try
    HttpClient.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
    HttpClient.Accept := 'application/json, text/javascript, */*';
    HttpClient.ContentType := 'application/json; charset=UTF-8';
    HttpClient.AcceptCharSet := 'utf-8';
    url := format('https://www.technodom.md/index.php?route=product/search&search=%s', [IBCQueryForeign.FieldByName('goods_code').AsString]);
    Response := TMemoryStream.Create;
    try
      HttpClient.AcceptCharSet := 'utf-8';
      HttpClient.Get(url, Response);
      HTMLBody.LoadFromStream(Response);

      Doc := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
      Doc.designMode := 'on';
      v := VarArrayCreate([0, 0], varVariant);
      v[0] := HTMLBody.Text;
      Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
      Body := Doc.body;
    finally
      Response.Free;
    end;

    allDivs := Body.All.Tags('div');
    for I := 0 to allDivs.Length - 1 do
    begin
      if (allDivs.item(I).ClassName = 'caption text-center') then
      begin
        atags := allDivs.item(I).getelementsByTagName('a');
        if atags.Length > 0 then
          href := atags.item(0).href;

        ParseBallanceQty(href);
        Continue;
      end;

    end;
  finally
    HttpClient.Free;
    HTMLBody.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetMuncitorulProductStock(GoodsCode: string);
//var
//  Client: TMuncitorulProductClient;
//  P: TMuncitorulProductInfo;
begin
//  Client := TMuncitorulProductClient.Create;
//  try
//    P := Client.FetchProduct('VOR58046'); // aici treci SKU primit ca parametru
//    Writeln('SKU: ' + P.SKU);
//    Writeln('Denumire: ' + P.Name);
//    Writeln(Format('Pret vanzare: %.2f', [P.PriceSale]));
//    Writeln(Format('Pret online: %.2f', [P.PriceOnline]));
//    Writeln(Format('Stoc: %.2f', [P.Stock]));
//    if Length(P.Images) > 0 then
//    begin
//      Writeln('Imagini:');
//      for var S in P.Images do
//        Writeln(' - ' + S);
//    end
//    else
//      Writeln('Fara imagini');
//  finally
//    Client.Free;
//  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetScopProductStock(GoodsCode: string);
var
  APIClient: TSCOPAPIClient;
  ProductInfo: TScopProductInfo;
  BaseURL: string;
  User: string;
  Password: string;
begin
  // Credentialele stau in TS_API_CONFIG (API_CODE = 'SCOP'), nu in cod.
  try
    LoadApiConfig(C_ScopApiCode, C_ScopApiDefaultURL, BaseURL, User, Password);
  except
    on E: Exception do
    begin
      MessageDlg('SCOP API: ' + E.Message, mtError, [mbOK], 0);
      Exit;
    end;
  end;

  Screen.Cursor := crHourGlass;
  try
    APIClient := TSCOPAPIClient.Create(User, Password);
    try
      APIClient.BaseURL := BaseURL;
      // Login automat la prima cerere
      if APIClient.GetProductInfoBySKU(GoodsCode, ProductInfo) then
        MessageDlg(Format('Produs: %s'#13#10'Pret: %.2f'#13#10'Stoc: %d',
          [ProductInfo.Name, ProductInfo.Price, ProductInfo.StockQuantity]),
          mtInformation, [mbOK], 0)
      else
        MessageDlg(Format('Codul "%s" nu a fost gasit in API-ul SCOP.', [GoodsCode]),
          mtWarning, [mbOK], 0);
    finally
      APIClient.Free;
    end;
  except
    on E: Exception do
      MessageDlg('SCOP API: ' + E.Message, mtError, [mbOK], 0);
  end;
  Screen.Cursor := crDefault;
end;

// -- Ultra.md eShop REST API (https://eshop.ultra.md/api) --------------------
// Doc: "ESHOP API DOCUMENTATION v1.1"; acelasi flux ca pipeline-ul python
// ultra2_* care umple TS_ULTRA2_*: POST /auth/token (Bearer), apoi
// GET /quantity/<ultra_code> pentru stoc si GET /product/<ultra_code> pentru
// preturi. GOODS_CODE din TS_GOODS_FOREIGN (furnizor 202294) = ultra_code.

function UltraAsObject(AJson: TJSONValue): TJSONObject;
begin
  Result := nil;
  if AJson is TJSONObject then
    Result := TJSONObject(AJson)
  else if (AJson is TJSONArray) and (TJSONArray(AJson).Count > 0) and (TJSONArray(AJson).Items[0] is TJSONObject) then
    Result := TJSONObject(TJSONArray(AJson).Items[0]);
end;

function UltraJsonNumber(AObj: TJSONObject; const AName: string; const ADefault: Double = 0): Double;
var
  Value: TJSONValue;
begin
  Result := ADefault;
  if not Assigned(AObj) then
    Exit;
  Value := AObj.GetValue(AName);
  if Value is TJSONNumber then
    Result := TJSONNumber(Value).AsDouble
  else if Value is TJSONString then
    Result := StrToFloatDef(Value.Value, ADefault, TFormatSettings.Invariant);
end;

function UltraPlainText(const AValue: string): string;
// product_name vine ca STRING care contine JSON multilingv
// {"ro":..,"ru":..,"en":..} - luam varianta romana, altfel prima disponibila.
var
  Json: TJSONValue;
  Obj: TJSONObject;
  Lang: string;
begin
  Result := Trim(AValue);
  if (Result = '') or (Result[1] <> '{') then
    Exit;

  Json := TJSONObject.ParseJSONValue(Result);
  if not Assigned(Json) then
    Exit;
  try
    Obj := UltraAsObject(Json);
    if not Assigned(Obj) then
      Exit;
    for Lang in TArray<string>.Create('ro', 'ru', 'en') do
      if Obj.GetValue<string>(Lang, '') <> '' then
      begin
        Result := Obj.GetValue<string>(Lang, '');
        Break;
      end;
  finally
    Json.Free;
  end;
end;

procedure UltraReadPrice(AProduct: TJSONObject; const AField: string; out AAmount: Double; out ACurrency: string);
// user_price / price_d / fixed_price / promo_b2b = {amount, currency:{code,name,rate}}
var
  PriceObj: TJSONObject;
  CurrencyObj: TJSONObject;
begin
  AAmount := 0;
  ACurrency := '';
  if not Assigned(AProduct) then
    Exit;

  PriceObj := UltraAsObject(AProduct.GetValue(AField));
  if not Assigned(PriceObj) then
    Exit;

  AAmount := UltraJsonNumber(PriceObj, 'amount', -1);
  if AAmount < 0 then
  begin
    AAmount := 0;
    Exit;
  end;

  CurrencyObj := UltraAsObject(PriceObj.GetValue('currency'));
  if Assigned(CurrencyObj) then
  begin
    ACurrency := CurrencyObj.GetValue<string>('name', '');
    if ACurrency = '' then
      // currency.code este NUMERIC (ISO 4217), nu literal
      case Trunc(UltraJsonNumber(CurrencyObj, 'code')) of
        840: ACurrency := 'USD';
        978: ACurrency := 'EUR';
        498: ACurrency := 'MDL';
      end;
  end;

  if ACurrency = '' then
    ACurrency := 'MDL';
end;

procedure TfrmGoodsForeignCodeDlg.ReadApiConfig(const AApiCode: string; AValues: TStrings);
// Parametrii API-urilor externe stau in TS_API_CONFIG, ca sa poata fi schimbati
// fara recompilare (dialogul Setari > Configurari API). Intoarce toti parametrii
// activi ai unui API ca perechi NUME=valoare.
var
  Query: TIBCQuery;
begin
  AValues.Clear;

  Query := TIBCQuery.Create(Self);
  try
    dmDB.OpenQuery(Query, 'select PARAM_NAME, PARAM_VALUE from TS_API_CONFIG' +
      ' where API_CODE = ' + QuotedStr(AApiCode) + ' and FLG_ACTIVE = 1', []);
    while not Query.Eof do
    begin
      AValues.Values[UpperCase(Trim(Query.FieldByName('PARAM_NAME').AsString))] :=
        Trim(Query.FieldByName('PARAM_VALUE').AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.LoadApiConfig(const AApiCode, ADefaultURL: string;
  out ABaseURL, AUser, APassword: string);
// Lipsa credentialelor este eroare - preferam un mesaj clar unui 401 de la furnizor.
var
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    ReadApiConfig(AApiCode, Values);

    ABaseURL := Values.Values['BASE_URL'];
    if ABaseURL = '' then
      ABaseURL := ADefaultURL;
    while (ABaseURL <> '') and (ABaseURL[Length(ABaseURL)] = '/') do
      SetLength(ABaseURL, Length(ABaseURL) - 1);

    AUser := Values.Values['USERNAME'];
    APassword := Values.Values['PASSWORD'];
  finally
    Values.Free;
  end;

  if (AUser = '') or (APassword = '') then
    raise Exception.Create('Lipsesc credentialele pentru API-ul ' + AApiCode +
      '. Completati randurile USERNAME si PASSWORD in TS_API_CONFIG ' +
      '(meniul Setari > Configurari API).');
end;

procedure TfrmGoodsForeignCodeDlg.LoadUltraApiConfig;
begin
  if FUltraConfigLoaded then
    Exit;

  LoadApiConfig(C_UltraApiCode, C_UltraApiDefaultURL,
    FUltraApiURL, FUltraApiUser, FUltraApiPassword);
  FUltraConfigLoaded := True;
end;

function TfrmGoodsForeignCodeDlg.UltraApiLogin: Boolean;
var
  Http: THTTPClient;
  Request: TJSONObject;
  Body: TStringStream;
  Response: IHTTPResponse;
  Json: TJSONValue;
  Obj: TJSONObject;
  ExpiresIn: Integer;
begin
  Result := False;
  FUltraToken := '';
  FUltraTokenExpires := 0;
  LoadUltraApiConfig;

  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 60000;

    Request := TJSONObject.Create;
    try
      Request.AddPair('username', FUltraApiUser);
      Request.AddPair('password', FUltraApiPassword);

      Body := TStringStream.Create(Request.ToJSON, TEncoding.UTF8);
      try
        Response := Http.Post(FUltraApiURL + '/auth/token', Body, nil,
          [TNetHeader.Create('Content-Type', 'application/json'),
           TNetHeader.Create('Accept', 'application/json')]);
      finally
        Body.Free;
      end;
    finally
      Request.Free;
    end;

    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('Autentificare Ultra esuata (HTTP %d): %s',
        [Response.StatusCode, Copy(Response.ContentAsString(TEncoding.UTF8), 1, 200)]);

    Json := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
    if not Assigned(Json) then
      Exit;
    try
      Obj := UltraAsObject(Json);
      if not Assigned(Obj) then
        Exit;
      FUltraToken := Obj.GetValue<string>('access_token', '');
      ExpiresIn := Trunc(UltraJsonNumber(Obj, 'expires_in', 3600));
    finally
      Json.Free;
    end;

    if FUltraToken = '' then
      Exit;

    // /auth/refresh nu este implementat pe server - ne reautentificam cu 2 minute
    // inainte de expirare
    FUltraTokenExpires := IncSecond(Now, Max(60, ExpiresIn - 120));
    Result := True;
  finally
    Http.Free;
  end;
end;

function TfrmGoodsForeignCodeDlg.UltraApiGetJson(const APath: string; out AJson: TJSONValue;
  out AStatusCode: Integer): Boolean;
var
  Http: THTTPClient;
  Response: IHTTPResponse;
  Attempt: Integer;
begin
  Result := False;
  AJson := nil;
  AStatusCode := 0;

  LoadUltraApiConfig;

  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 60000;

    for Attempt := 1 to 2 do
    begin
      if (FUltraToken = '') or (Now >= FUltraTokenExpires) then
        if not UltraApiLogin then
          Exit;

      Response := Http.Get(FUltraApiURL + APath, nil,
        [TNetHeader.Create('Authorization', 'Bearer ' + FUltraToken),
         TNetHeader.Create('Accept', 'application/json')]);
      AStatusCode := Response.StatusCode;

      // token invalidat pe server - fortam o reautentificare, o singura data
      if AStatusCode <> 401 then
        Break;
      FUltraToken := '';
    end;

    if AStatusCode <> 200 then
      Exit;

    AJson := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
    Result := Assigned(AJson);
  finally
    Http.Free;
  end;
end;

function TfrmGoodsForeignCodeDlg.GetUltraStock(const AGoodsCode: string; out AInfo: TUltraStockInfo): Boolean;
var
  Json: TJSONValue;
  Obj: TJSONObject;
  Path: string;
  Status: Integer;
begin
  Result := False;
  AInfo := Default(TUltraStockInfo);

  if Trim(AGoodsCode) = '' then
    Exit;
  Path := TNetEncoding.URL.Encode(Trim(AGoodsCode));

  // 1. stocul - GET /quantity/<ultra_code>
  if not UltraApiGetJson('/quantity/' + Path, Json, Status) then
  begin
    AInfo.StatusCode := Status;
    Exit;
  end;

  try
    AInfo.StatusCode := Status;
    Obj := UltraAsObject(Json);
    if not Assigned(Obj) then
      Exit;

    AInfo.Code := Obj.GetValue<string>('ultra_code', Trim(AGoodsCode));
    AInfo.Name := UltraPlainText(Obj.GetValue<string>('product_name', ''));
    AInfo.Quantity := UltraJsonNumber(Obj, 'quantity');
    AInfo.UpdatedAt := StringReplace(Obj.GetValue<string>('updated_at', ''), 'T', ' ', []);
    Result := True;
  finally
    Json.Free;
  end;

  // 2. preturile - GET /product/<ultra_code>; daca esueaza, stocul ramane valid
  if UltraApiGetJson('/product/' + Path, Json, Status) then
  try
    Obj := UltraAsObject(Json);
    if Assigned(Obj) then
    begin
      if AInfo.Name = '' then
        AInfo.Name := UltraPlainText(Obj.GetValue<string>('product_name', ''));
      UltraReadPrice(Obj, 'user_price', AInfo.PriceUser, AInfo.PriceUserCurrency);
      UltraReadPrice(Obj, 'price_d', AInfo.PriceD, AInfo.PriceDCurrency);
      UltraReadPrice(Obj, 'fixed_price', AInfo.PriceFixed, AInfo.PriceFixedCurrency);
      UltraReadPrice(Obj, 'promo_b2b', AInfo.PricePromo, AInfo.PricePromoCurrency);
    end;
  finally
    Json.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetUltraProductStock(GoodsCode: string);
var
  Info: TUltraStockInfo;
  Msg: string;
  Found: Boolean;

  procedure AddPriceLine(const ACaption: string; const AAmount: Double; const ACurrency: string);
  begin
    if ACurrency <> '' then
      Msg := Msg + Format(#13#10'%s: %.2f %s', [ACaption, AAmount, ACurrency]);
  end;

begin
  Screen.Cursor := crHourGlass;
  try
    try
      Found := GetUltraStock(GoodsCode, Info);
    except
      on E: Exception do
      begin
        MessageDlg('Ultra API: ' + E.Message, mtError, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;

  if not Found then
  begin
    // API-ul eShop expune un sortiment mai mic decat serviciul B2B SOAP:
    // pozitiile pur-B2B intorc 404 Product not found
    if Info.StatusCode = 404 then
      MessageDlg(Format('Codul "%s" nu exista in API-ul Ultra eShop.', [GoodsCode]), mtWarning, [mbOK], 0)
    else
      MessageDlg(Format('Nu s-a putut citi stocul Ultra pentru "%s" (HTTP %d).',
        [GoodsCode, Info.StatusCode]), mtError, [mbOK], 0);
    Exit;
  end;

  Msg := Format('Cod Ultra: %s', [Info.Code]);
  if Info.Name <> '' then
    Msg := Msg + #13#10 + Info.Name;
  Msg := Msg + Format(#13#10#13#10'Stoc disponibil: %.0f', [Info.Quantity]);

  AddPriceLine('Pret contract', Info.PriceUser, Info.PriceUserCurrency);
  AddPriceLine('Pret D', Info.PriceD, Info.PriceDCurrency);
  AddPriceLine('Pret fix', Info.PriceFixed, Info.PriceFixedCurrency);
  AddPriceLine('Promo B2B', Info.PricePromo, Info.PricePromoCurrency);

  if Info.UpdatedAt <> '' then
    Msg := Msg + Format(#13#10#13#10'Actualizat: %s', [Info.UpdatedAt]);

  MessageDlg(Msg, mtInformation, [mbOK], 0);
end;

procedure TfrmGoodsForeignCodeDlg.ParseBallanceQty(url: string);
var
  allSpan: OleVariant;
  Body: OleVariant;
  Doc: IHTMLDocument2;
  HTMLBody: TSTringlist;
  HttpClient: Thttpclient;
  Response: TMemoryStream;
  v: OleVariant;
  i: integer;
begin

  HttpClient := Thttpclient.Create;
  HTMLBody := TSTringlist.Create;
  try
    HttpClient.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
    HttpClient.Accept := 'application/json, text/javascript, */*';
    HttpClient.ContentType := 'application/json; charset=UTF-8';
    HttpClient.AcceptCharSet := 'utf-8';

    Response := TMemoryStream.Create;
    try
      HttpClient.AcceptCharSet := 'utf-8';
      HttpClient.Get(url, Response);
      HTMLBody.LoadFromStream(Response);

      Doc := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
      Doc.designMode := 'on';
      v := VarArrayCreate([0, 0], varVariant);
      v[0] := HTMLBody.Text;
      Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
      Body := Doc.body;
    finally
      Response.Free;
    end;

    allSpan := Body.All.Tags('div');
    for i := 0 to allSpan.Length - 1 do
    begin
      if (allSpan.item(i).ClassName = 'availability in-stock') then
      begin
        MessageDlg(Format('%s', [allSpan.item(i).innertext]), mtInformation, [mbOK], 0);
      end;
    end;
  finally
    HttpClient.Free;
    HTMLBody.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.Prepare;
var
  Query: TIBCQuery;
begin
  inherited;

  ReadGoodsInfo;
  PrepareDataSet;
  mmGoods.Text := '#' + fGoodsInfo.GoodsID.ToString + '-' + fGoodsInfo.Title;
  Caption := fGoodsInfo.Title;

  try
    IBCTrUpdate.StartTransaction;

    IBCQueryForeign.ParamByName('goodsID').AsInteger := fGoodsID;
    IBCQueryForeign.Active := True;

    tv1_PriceIndicativ.DataBinding.Expression := 'if(AND([Stoc]=1; [Cod Furnizor]=202294 ); [Indicativ, MDL];' +  // ultra
      'if(AND([Stoc]=1; [Cod Furnizor]=1455   ); [Indicativ, MDL] / 1.05;' + // doxy
      'if(AND([Stoc]=1; [Cod Furnizor]=225846 ); [Indicativ, MDL] / 1.02;' + // elcore
      'if([Stoc]=1;[Indicativ, MDL];   10000000)))))';

    Query := TIBCQuery.Create(Self);
    try
      dmDB.OpenQuery(Query, 'select goodsid, parentid from get_ts_goods_path(:goodsid)', [fGoodsID]);
      if Query.Locate('GOODSID', 223771, []) then // IT -3$
        tv1_PriceIndicativ.DataBinding.Expression := 'if(AND([Stoc]=1; [Cod Furnizor]=202294 ); [Indicativ, MDL] / 1.0;'
          + // ULTRA
          'if(AND([Stoc]=1; [Cod Furnizor]=198    ); [Indicativ, MDL] / 1.0;' + // ACCENT
          'if(AND([Stoc]=1; [Cod Furnizor]=1455   ); [Indicativ, MDL] / 1.04;' + // DOXY
          'if(AND([Stoc]=1; [Cod Furnizor]=225846 ); [Indicativ, MDL] / 1.02;' + // elcore
          'if([Stoc]=1;[Indicativ, MDL]; 10000000)))))';

      if Query.Locate('GOODSID', 55573, []) then // GSM -2%
        tv1_PriceIndicativ.DataBinding.Expression := 'if(AND([Stoc]=1; [Cod Furnizor]=202294 ); [Indicativ, MDL] / 1.0;'
          + // ultra
          'if(AND([Stoc]=1; [Cod Furnizor]=198    ); [Indicativ, MDL] / 1.0;' + // accent
          'if(AND([Stoc]=1; [Cod Furnizor]=1455   ); [Indicativ, MDL] / 1.0;' + // doxy
          'if(AND([Stoc]=1; [Cod Furnizor]=225846 ); [Indicativ, MDL] / 1.02;' + // elcore
          'if([Stoc]=1;[Indicativ, MDL]; 10000000)))))';
    finally
      Query.Free;
    end;

    if (IBCQueryPromos.FieldByName('PROMOACTIONID').AsInteger > 0) then
      cxDBVerticalGrid1.Brush.Color := clYellow;

    if (Qty <> 0) then
    begin
      lbQty.Caption := Qty.ToString;
      lbQty.Visible := True;
      ShapeQty.Visible := True;
    end
    else
    begin
      lbQty.Caption := '';
      lbQty.Visible := False;
      ShapeQty.Visible := False;
    end;

    IBCQueryCustomerInfo.Open;

    SelectionChanged;
  except
    IBCTrUpdate.Rollback;
    raise;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.PrepareDataSet;
begin
  IBCQueryPromos.Close;
  IBCQueryPromos.ParamByName('GOODSID').AsInteger := fGoodsID;
  IBCQueryPromos.Open;

  IBCQueryCatalog.ParamByName('GoodsID').AsInteger := fGoodsID;
  IBCQueryCatalog.Open;
  lbPath.Caption := IBCQueryCatalog.FieldByName('breadcrumb').AsString;
end;

procedure TfrmGoodsForeignCodeDlg.ReadGoodsInfo;
begin
  fGoodsInfo := dmDB.GetGoodsInfo(fGoodsID);
  if not Assigned(fGoodsInfo) then
    raise Exception.Create('Nu pot citi informatia despre produs!');
end;

procedure TfrmGoodsForeignCodeDlg.SetupSecurityItems;
begin
  cxGridForeignDBBandedTableView1.Bands[0].Width := 582;
  cxGridForeignDBBandedTableView1.Bands[1].Width := 609;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Текущие_долги_контрагента) then
  begin
    bbDebts.Visible := ivNever;
  end;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_ТУП_Администрирование) then
  begin
    bbSetForcesFlag.Visible := ivNever;
    bbRemoveForcedFlag.Visible := ivNever;
    bbForeignNew.Visible := ivNever;
    bbForeignModify.Visible := ivNever;
    bbForeignDelete.Visible := ivNever;
    bbAVAILABLE_QTY.Visible := ivNever;
    TV1_PRICE0_LEI.Visible := False;

    TV1_PRICE7.Visible := False;
    TV1_CURRENCY7ID.Visible := False;

    TV1_PRICE7_LEI.Visible := false;
    TV1_PERCENT47.Visible := false;
    TV1_DIFF47.Visible := false;
    TV1_MARGIN01.Visible := false;
    cxGridForeignDBBandedTableView1.Bands[0].Width := 900;
    cxGridForeignDBBandedTableView1.Bands[1].Width := 500;
  end;

  if not SecurityFlagEnabled(cSecurityFlag_Справочники_НТУП_Modificare) then
  begin
    bbInstrumente.Visible := ivNever;
    bbGoodsMoves.Visible := ivNever;
    bbGoodsPriceHistory.Visible := ivNever;
    bbForeignNew.Visible := ivNever;
    bbForeignModify.Visible := ivNever;
    bbForeignDelete.Visible := ivNever;
    bbSetForcesFlag.Visible := ivNever;
    bbRemoveForcedFlag.Visible := ivNever;
    bbAVAILABLE_QTY.Visible := ivNever;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.SaveStates;
begin
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
    AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
  begin
    AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridForeignDBBandedTableView1);
  end;

end;

procedure TfrmGoodsForeignCodeDlg.SelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
begin
  fNew := True;
  fEdit := False;
  fDelete := False;

  if cxGridForeignDBBandedTableView1.DataController.RecNo > 0 then
  begin
    fEdit := True;
    fDelete := True;
  end;

  bbForeignNew.Enabled := fNew;
  bbForeignModify.Enabled := fEdit;
  bbForeignDelete.Enabled := fDelete;
end;

procedure TfrmGoodsForeignCodeDlg.SetGoodsID(const Value: Integer);
begin
  fGoodsID := Value;
end;

procedure TfrmGoodsForeignCodeDlg.SetQty(const Value: Double);
begin
  FQty := Value;
end;

procedure TfrmGoodsForeignCodeDlg.ShowAddNewCodeDialog;
var
  dialog: TfrmGoodsForeignCodeEditorDlg;
begin
  dialog := TfrmGoodsForeignCodeEditorDlg.Create(Self, IBCQueryForeign, IBCDataSourceForeign);
  try
    dialog.CreateNewCode := True;
    dialog.GoodsID := fGoodsID;
    dialog.GoodsCode := fGoodsInfo.Code;
    dialog.GoodsDesc := fGoodsInfo.Details;
    dialog.GoodsTitle := fGoodsInfo.Title;

    if dialog.ShowModal = mrOk then
      if IBCQueryForeign.State in dsEditModes then
        IBCQueryForeign.Post
      else if IBCQueryForeign.State in dsEditModes then
        IBCQueryForeign.Cancel;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.ShowModifyCodeDialog;
var
  dialog: TfrmGoodsForeignCodeEditorDlg;
begin
  dialog := TfrmGoodsForeignCodeEditorDlg.Create(Self, IBCQueryForeign, IBCDataSourceForeign);
  try
    dialog.CreateNewCode := False;
    dialog.GoodsTitle := fGoodsInfo.Title;
    if dialog.ShowModal = mrOk then
      IBCQueryForeign.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.TV1_CURRENCY7IDCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  if not VarIsNull(AViewInfo.Gridrecord.Values[TV1_CURRENCY7ID.Index]) then
  begin
    if (AViewInfo.Gridrecord.Values[TV1_CURRENCY7ID.Index] = '') then
      ACanvas.Brush.Color := clRed;
  end;

  if not VarIsNull(AViewInfo.Gridrecord.Values[TV1_CURRENCY6ID.Index]) then
  begin
    if (AViewInfo.Gridrecord.Values[TV1_CURRENCY6ID.Index] = '') then
      ACanvas.Brush.Color := clRed;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.WhenCancelForm;
begin
  if IBCTrUpdate.Active then
    IBCTrUpdate.Rollback;

  SupplierID := -1;
end;

end.


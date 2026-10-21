unit  frmGoodsForeignCodeDialog;

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
  B2BClientUltra, cxCurrencyEdit;

const
  // Credentialele API-urilor de furnizor NU stau in cod: se citesc din
  // TS_API_CONFIG (vezi "DB Model\ts_api_config.sql"), randurile cu PARAM_NAME
  // in (BASE_URL, USERNAME, PASSWORD). Se administreaza din meniul
  // Setari > Configurari API. Aici raman doar codurile si valorile implicite.
  C_UltraApiCode = 'ULTRA_ESHOP';
  C_UltraApiDefaultURL = 'https://eshop.ultra.md/api';
  // SCOP (Triomac): API_KEY / API_SECRET, citite de SCOPAPIClientUnit.CreateFromConfig
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
    bbAskAvailability: TdxBarButton;
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
    TV1_P1_MDL: TcxGridDBBandedColumn;
    TV1_P1_USD: TcxGridDBBandedColumn;
    TV1_P2_MDL: TcxGridDBBandedColumn;
    TV1_P2_USD: TcxGridDBBandedColumn;
    TV1_P3_MDL: TcxGridDBBandedColumn;
    TV1_P3_USD: TcxGridDBBandedColumn;
    TV1_P4_MDL: TcxGridDBBandedColumn;
    TV1_P4_USD: TcxGridDBBandedColumn;
    TV1_P5_MDL: TcxGridDBBandedColumn;
    TV1_P5_USD: TcxGridDBBandedColumn;
    TV1_P6_MDL: TcxGridDBBandedColumn;
    TV1_P6_USD: TcxGridDBBandedColumn;
    TV1_P7_MDL: TcxGridDBBandedColumn;
    TV1_P7_USD: TcxGridDBBandedColumn;
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
    procedure bbAskAvailabilityClick(Sender: TObject);
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
    procedure HideLegacyPriceColumns;
    procedure SelectionChanged;
    procedure ShowAddNewCodeDialog;
    procedure ShowModifyCodeDialog;
    procedure DeleteSelectedCode;
    procedure PrepareDataSet;
    procedure SetGoodsID(const Value: Integer);
    procedure SetQty(const Value: Double);
    procedure AddGoodsToCreditRetail(ACid: Integer);
    procedure GetATehnoProductStock(AGoodsCode: string);
    procedure GetDMLinkProductStock(GoodsCode: string);
    procedure GetDoxyterraProductStock(AGoodsCode: string);
    procedure GetEuroTermProductStock(AGoodsCode: string);
    procedure GetGoodsBalance_198;
    procedure GetHiTechProductStock(AGoodsCode: string);
    procedure GetImperiaProductStock(AGoodsCode: string);
    procedure GetTechnodomProductStock(AGoodsCode: string);
    procedure GetTrisautoProductStock(AGoodsCode: string);
    procedure GetMuncitorulProductStock(GoodsCode: string);
    procedure GetScopProductStock(GoodsCode: string);
    procedure GetSnaigeProductStock(AGoodsCode: string);
    procedure GetAloProductStock(AGoodsCode: string);
    procedure GetPernaMeaProductStock(AGoodsCode: string);
    procedure GetUltraProductStock(GoodsCode: string);
    procedure ReadApiConfig(const AApiCode: string; AValues: TStrings);
    procedure LoadApiConfig(const AApiCode, ADefaultURL: string;
      out ABaseURL, AUser, APassword: string);
    procedure LoadUltraApiConfig;
    function UltraApiLogin: Boolean;
    function UltraApiGetJson(const APath: string; out AJson: TJSONValue; out AStatusCode: Integer): Boolean;

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
  frmATehnoStockResultDialog,
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
  System.RegularExpressions,
  System.DateUtils,
  AccentGuidRepo,
  AccentAuthService,
  ImperiaContentUnit,
  PernaMeaContentUnit,
  TelegramApiUnit;

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

// "Verifica disponibilitatea": intrebarea despre produsul furnizorului se trimite
// direct in grupul Telegram de achizitii, in forma
//   Furnizor <b>"COD" cantitate</b> Denumire la furnizor?
// Tokenul botului vine din TS_API_CONFIG (API_CODE = 'TELEGRAM'). Chat-ul e cel
// din canalul SUPPLIER_STOCK din TELEGRAM_CHANNELS, daca a fost creat (Setari >
// Notificari Telegram), altfel grupul fix cAskAvailabilityChatID.
procedure TfrmGoodsForeignCodeDlg.bbAskAvailabilityClick(Sender: TObject);
const
  cAskAvailabilityChatID = '-4974887695';
var
  Values: TStringList;
  Query: TIBCQuery;
  Token: string;
  ChatID: string;
  ThreadID: Integer;
  QtyValue: Double;
  MsgText: string;
  Res: TTelegramSendResult;
begin
  if IBCQueryForeign.IsEmpty then
    Exit;

  Values := TStringList.Create;
  try
    ReadApiConfig('TELEGRAM', Values);
    Token := Values.Values['BOT_TOKEN'];
  finally
    Values.Free;
  end;
  if Token = '' then
  begin
    MessageDlg('Completati BOT_TOKEN in Setari > Configurari API (Cod API = TELEGRAM).',
      mtWarning, [mbOK], 0);
    Exit;
  end;

  ChatID := cAskAvailabilityChatID;
  ThreadID := 0;
  Query := TIBCQuery.Create(Self);
  try
    dmDB.OpenQuery(Query, 'select CHAT_ID, THREAD_ID from TELEGRAM_CHANNELS' +
      ' where CHANNEL_CODE = ''SUPPLIER_STOCK'' and FLG_ACTIVE = 1', []);
    if (not Query.Eof) and (Trim(Query.FieldByName('CHAT_ID').AsString) <> '') then
    begin
      ChatID := Trim(Query.FieldByName('CHAT_ID').AsString);
      ThreadID := Query.FieldByName('THREAD_ID').AsInteger;
    end;
  finally
    Query.Free;
  end;

  // Din nomenclator Qty vine ca deficit (negativ); fara cantitate intrebam de 1 buc.
  QtyValue := Abs(FQty);
  if QtyValue = 0 then
    QtyValue := 1;

  MsgText := Format('%s <b>"%s"</b> %s <b>%s</b>?', [
    TelegramEscapeHtml(Trim(IBCQueryForeign.FieldByName('CUSTOMER_NAME').AsString)),
    TelegramEscapeHtml(Trim(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)),
    TelegramEscapeHtml(Trim(IBCQueryForeign.FieldByName('GOODS_TITLE').AsString)),
    FormatFloat('0.###', dmDB.ibcqueryJurnal.FieldByName('QTY').AsFloat)]);

  Screen.Cursor := crHourGlass;
  try
    Res := TelegramSendMessage(Token, ChatID, ThreadID, MsgText, 'HTML', False);
  finally
    Screen.Cursor := crDefault;
  end;

  if Res.Ok then
    MessageDlg('Intrebarea a fost trimisa in Telegram:' + sLineBreak + sLineBreak +
      TelegramStripHtml(MsgText), mtInformation, [mbOK], 0)
  else
    MessageDlg(Format('Telegram a refuzat mesajul (HTTP %d): %s' + sLineBreak + sLineBreak +
      'Verificati ca botul este membru in grupul %s.',
      [Res.HttpCode, Res.Description, ChatID]), mtError, [mbOK], 0);
end;

procedure TfrmGoodsForeignCodeDlg.bbSupllierApiClick(Sender: TObject);
begin
    // accent
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 198) then // accent
    GetGoodsBalance_198
    else
    // technodom.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 261523) then
    GetTechnodomProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // 229466 DMLink
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 229466) then
    GetDMLinkProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // triomac
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 209280) then
    GetScopProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
    else
    // ultra
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 202294) then
    GetUltraProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // muncitorul.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 251465) then
    GetMuncitorulProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // atehno.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 292109) then
    GetATehnoProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // euroterm.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 162399) then
    GetEuroTermProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // Comitek SRL - doxyterra.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 1455) then
    GetDoxyterraProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // TEOCOM LuX SRL - imperia.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = cImperiaSupplierID) then
    GetImperiaProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // AIEA SRL - snaige.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 74995) then
    GetSnaigeProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // MOBILE STOCK SRL - alo.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 246795) then
    GetAloProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // PERNAMEA S.R.L. - pernamea.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = cPernaMeaSupplierID) then
    GetPernaMeaProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // HI-Tech SRL - h-t.md
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 262735) then
    GetHiTechProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    // Tris SRL - trisauto.md (www.tris.md)
  if (ibcqueryforeign.fieldbyname('customerid').AsInteger = 8606) then
    GetTrisautoProductStock(IBCQueryForeign.FieldByName('GOODS_CODE').AsString)
  else
    MessageDlg('nu este implimentata procedura!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],0);
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

// -- atehno.md (scraping, fara API) ------------------------------------------
// Nu exista cont B2B/API pentru atehno.md: incarcam direct pagina de cautare
// (search/catalog?keywords=<cod>&mode=simple) - randata server-side, contine
// deja rezultatele in HTML, fara JSON/AJAX - si cautam link-ul de produs care
// contine efectiv GOODS_CODE (fiecare URL de produs se termina cu codul/EAN-ul,
// ex. https://atehno.md/products/<slug>-<GOODS_CODE>). Apoi citim pagina
// produsului si extragem lista de magazine cu stoc din blocul
// "Самовывоз из магазина" (ul.product-taking-block--list > li.available).
procedure TfrmGoodsForeignCodeDlg.GetATehnoProductStock(AGoodsCode: string);
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  ResponseContent: string;
  LinkMatch: TMatch;
  Doc: IHTMLDocument2;
  DocBody: OleVariant;
  VarArr: OleVariant;
  AllSpans: OleVariant;
  AllULs: OleVariant;
  ListItems: OleVariant;
  I, J: Integer;
  ProductURL: string;
  ProductTitle: string;
  StatusText: string;
  ElemClass: string;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;
begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      HttpClient := THTTPClient.Create;
      try
        HttpClient.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';

        // Pagina de cautare (HTML complet, randat server-side)
        Response := HttpClient.Get(Format('https://atehno.md/search/catalog?keywords=%s&mode=simple',
          [TNetEncoding.URL.Encode(AGoodsCode)]));
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('atehno.md: cautarea a esuat (HTTP %d).', [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);

        // Cautam link-ul de produs care contine efectiv codul cautat, nu doar
        // primul rezultat - cautarea poate intoarce si alte produse apropiate.
        ProductURL := '';
        LinkMatch := TRegEx.Match(ResponseContent,
          'href="(https://atehno\.md/products/[^"]*' + TRegEx.Escape(AGoodsCode) + ')"', [roIgnoreCase]);
        if LinkMatch.Success then
          ProductURL := LinkMatch.Groups[1].Value;

        if ProductURL = '' then
        begin
          MessageDlg(Format('Codul "%s" nu a fost gasit pe atehno.md.', [AGoodsCode]), mtWarning, [mbOK], 0);
          Exit;
        end;

        // Pagina produsului
        Response := HttpClient.Get(ProductURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('atehno.md: nu s-a putut deschide pagina produsului (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);
      finally
        HttpClient.Free;
      end;

      Doc := CoHTMLDocument.Create as IHTMLDocument2;
      VarArr := VarArrayCreate([0, 0], varVariant);
      VarArr[0] := ResponseContent;
      Doc.Write(PSafeArray(TVarData(VarArr).VArray));
      DocBody := Doc.Body;

      // Denumirea produsului: <span class="product-name">
      ProductTitle := '';
      AllSpans := DocBody.All.Tags('span');
      for I := 0 to Integer(AllSpans.Length) - 1 do
        if string(AllSpans.item(I).ClassName) = 'product-name' then
        begin
          ProductTitle := Trim(string(AllSpans.item(I).innerText));
          Break;
        end;

      // Statutul general: <span class="product-available|product-only-order|product-not-available">
      StatusText := '';
      for I := 0 to Integer(AllSpans.Length) - 1 do
      begin
        ElemClass := string(AllSpans.item(I).ClassName);
        if (ElemClass = 'product-available') or (ElemClass = 'product-only-order') or
          (ElemClass = 'product-not-available') then
        begin
          StatusText := Trim(string(AllSpans.item(I).innerText));
          Break;
        end;
      end;
      if StatusText = '' then
        ElemClass := ''; // fara potrivire in bucla de mai sus - clasa retinuta e a ultimului span, nu una relevanta

      // Magazinele/depozitele cu stoc: <ul class="product-taking-block--list"><li class="available">
      AllULs := DocBody.All.Tags('ul');
      for I := 0 to Integer(AllULs.Length) - 1 do
        if string(AllULs.item(I).ClassName) = 'product-taking-block--list' then
        begin
          ListItems := AllULs.item(I).All.Tags('li');
          for J := 0 to Integer(ListItems.Length) - 1 do
            if string(ListItems.item(J).ClassName) = 'available' then
              Locations.Add(Trim(string(ListItems.item(J).innerText)));
          Break;
        end;

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, ElemClass, ProductURL, Locations);
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('atehno.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
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
  HideLegacyPriceColumns;
end;

// Preturile se afiseaza pe benzi (Web, Promo, RRP, Calc, Discount, Diler,
// Indicativ): sus pret MDL + valuta, jos pret USD + valuta (campurile Pn_MDL /
// Pn_USD din IBCQueryForeign). Coloanele vechi raman pentru expresii si calcule
// (ex. [Indicativ, MDL] in tv1_PriceIndicativ, GetLowestPrice7RowIndex), dar
// ascunse - si dupa ce se restaureaza structura grilei salvata de utilizator.
procedure TfrmGoodsForeignCodeDlg.HideLegacyPriceColumns;
begin
  TV1_PRICE1.Visible := False;
  TV1_CURRENCY1ID.Visible := False;
  TV1_PRICE2.Visible := False;
  TV1_CURRENCY2ID.Visible := False;
  TV1_PRICE3.Visible := False;
  TV1_CURRENCY3ID.Visible := False;
  TV1_PRICE4.Visible := False;
  TV1_PRICE5.Visible := False;
  TV1_CURRENCY5ID.Visible := False;
  TV1_PRICE6.Visible := False;
  TV1_CURRENCY6ID.Visible := False;
  TV1_PRICE7.Visible := False;
  TV1_CURRENCY7ID.Visible := False;
  TV1_PRICE7_LEI.Visible := False;
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

// -- technodom.md (catalog JSON, fara autentificare) --------------------------
// Pagina noua Technodom incarca produsele prin GET /products?query=<cod>.
// Raspunsul JSON contine denumirea, slug-ul, cantitatea si statutul de stoc.
procedure TfrmGoodsForeignCodeDlg.GetTechnodomProductStock(AGoodsCode: string);
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  ResponseContent: string;
  SearchURL: string;
  ProductURL: string;
  ProductTitle: string;
  StatusText: string;
  StatusClass: string;
  StockAvailability: string;
  Json: TJSONValue;
  ProductsValue: TJSONValue;
  DataValue: TJSONValue;
  RootObject: TJSONObject;
  ProductsObject: TJSONObject;
  ProductObject: TJSONObject;
  ProductsArray: TJSONArray;
  Quantity: Double;
  ManagesStock: Boolean;
  InStock: Boolean;
  OutOfStock: Boolean;
  AvailableForPurchase: Boolean;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  function ReadJsonBoolean(AObject: TJSONObject; const AName: string;
    const ADefault: Boolean): Boolean;
  var
    Value: TJSONValue;
  begin
    Result := ADefault;
    if not Assigned(AObject) then
      Exit;

    Value := AObject.GetValue(AName);
    if not Assigned(Value) then
      Exit;

    if SameText(Value.Value, 'true') or (Value.Value = '1') then
      Result := True
    else if SameText(Value.Value, 'false') or (Value.Value = '0') then
      Result := False;
  end;

  function ReadJsonNumber(AObject: TJSONObject; const AName: string;
    const ADefault: Double): Double;
  var
    Value: TJSONValue;
  begin
    Result := ADefault;
    if not Assigned(AObject) then
      Exit;

    Value := AObject.GetValue(AName);
    if Assigned(Value) then
      Result := StrToFloatDef(Value.Value, ADefault, TFormatSettings.Invariant);
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Json := nil;
  Locations := TStringList.Create;
  try
    try
      SearchURL := Format('https://www.technodom.md/products?query=%s',
        [TNetEncoding.URL.Encode(AGoodsCode)]);

      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'application/json, text/plain, */*';
        HttpClient.CustomHeaders['X-Requested-With'] := 'XMLHttpRequest';
        HttpClient.CustomHeaders['Referer'] := Format(
          'https://www.technodom.md/ro/products?query=%s',
          [TNetEncoding.URL.Encode(AGoodsCode)]);

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('technodom.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);
      finally
        HttpClient.Free;
      end;

      Json := TJSONObject.ParseJSONValue(ResponseContent);
      if not (Json is TJSONObject) then
        raise Exception.Create('Raspuns JSON invalid.');

      RootObject := TJSONObject(Json);
      ProductsValue := RootObject.GetValue('products');
      if not (ProductsValue is TJSONObject) then
        raise Exception.Create('Lista de produse lipseste din raspuns.');

      ProductsObject := TJSONObject(ProductsValue);
      DataValue := ProductsObject.GetValue('data');
      if not (DataValue is TJSONArray) then
        raise Exception.Create('Datele produselor lipsesc din raspuns.');

      ProductsArray := TJSONArray(DataValue);
      if ProductsArray.Count = 0 then
      begin
        MessageDlg(Format('Codul "%s" nu a fost gasit pe technodom.md.',
          [AGoodsCode]), mtWarning, [mbOK], 0);
        Exit;
      end;

      if not (ProductsArray.Items[0] is TJSONObject) then
        raise Exception.Create('Formatul produsului este invalid.');
      ProductObject := TJSONObject(ProductsArray.Items[0]);

      ProductTitle := ProductObject.GetValue<string>('name', '');
      StockAvailability := ProductObject.GetValue<string>('stock_availability', '');
      Quantity := ReadJsonNumber(ProductObject, 'qty', 0);
      ManagesStock := ReadJsonBoolean(ProductObject, 'does_manage_stock',
        ReadJsonBoolean(ProductObject, 'manage_stock', False));
      InStock := ReadJsonBoolean(ProductObject, 'is_in_stock',
        SameText(StockAvailability, 'in_stock'));
      OutOfStock := ReadJsonBoolean(ProductObject, 'is_out_of_stock',
        SameText(StockAvailability, 'out_of_stock'));
      AvailableForPurchase := ReadJsonBoolean(ProductObject,
        'is_available_for_purchase', InStock);

      if SameText(StockAvailability, 'backorder') then
      begin
        StatusText := 'Disponibil la comanda';
        StatusClass := 'product-only-order';
      end
      else if SameText(StockAvailability, 'special_order') then
      begin
        StatusText := 'Comanda speciala';
        StatusClass := 'product-only-order';
      end
      else if InStock and not OutOfStock then
      begin
        StatusText := 'In stoc';
        StatusClass := 'product-available';
      end
      else if OutOfStock or not AvailableForPurchase then
      begin
        StatusText := 'Epuizat';
        StatusClass := 'product-not-available';
      end
      else
      begin
        StatusText := StockAvailability;
        StatusClass := '';
      end;

      if ManagesStock and InStock then
        Locations.Add(Format('Cantitate disponibila: %s buc.',
          [FormatFloat('0.##', Quantity)]))
      else if AvailableForPurchase then
        Locations.Add('Cantitatea exacta nu este publicata.')
      else
        Locations.Add('Produs indisponibil.');

      ProductURL := ProductObject.GetValue<string>('url', '');
      if ProductURL = '' then
      begin
        ProductURL := ProductObject.GetValue<string>('slug', '');
        if ProductURL <> '' then
          ProductURL := 'https://www.technodom.md/ro/products/' + ProductURL;
      end;
      if ProductURL = '' then
        ProductURL := Format('https://www.technodom.md/ro/products?query=%s',
          [TNetEncoding.URL.Encode(AGoodsCode)]);

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc technodom.md';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('technodom.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Json.Free;
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- euroterm.md (pagina de cautare, fara autentificare) ----------------------
// Site-ul nu are API public: cautarea /ro/search-products?search=<cod> este
// randata pe server. Fiecare produs e un bloc "main-catalog__item" care
// contine "Cod: <cod>" (acelasi cod ca GOODS_CODE din TS_GOODS_FOREIGN pentru
// furnizorul 162399). Cantitatea nu se publica: produsul din stoc are pret si
// butonul "add_to_cart", cel adus la comanda are eticheta "for_order".
procedure TfrmGoodsForeignCodeDlg.GetEuroTermProductStock(AGoodsCode: string);
const
  C_EuroTermHost = 'https://www.euroterm.md';
  C_CardMarker = '<div class="main-catalog__item';
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  ResponseContent: string;
  SearchURL: string;
  Cards: TArray<string>;
  Card: string;
  ProductCard: string;
  ProductCode: string;
  ProductTitle: string;
  ProductURL: string;
  PriceText: string;
  OldPriceText: string;
  OrderText: string;
  StatusText: string;
  StatusClass: string;
  CardCount: Integer;
  FooterPos: Integer;
  i: Integer;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Primul grup din APattern, fara taguri HTML si cu entitatile decodate.
  function CardValue(const ACard, APattern: string): string;
  var
    Match: TMatch;
  begin
    Result := '';
    Match := TRegEx.Match(ACard, APattern, [roIgnoreCase, roSingleLine]);
    if Match.Success then
    begin
      Result := TRegEx.Replace(Match.Groups[1].Value, '<[^>]*>', ' ');
      Result := TRegEx.Replace(Result, '\s+', ' ');
      Result := Trim(TNetEncoding.HTML.Decode(Result));
    end;
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      SearchURL := Format(C_EuroTermHost + '/ro/search-products?search=%s',
        [TNetEncoding.URL.Encode(AGoodsCode)]);

      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('euroterm.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);
      finally
        HttpClient.Free;
      end;

      // Cards[0] este antetul paginii; fiecare element urmator e un produs.
      Cards := ResponseContent.Split([C_CardMarker], TStringSplitOptions.None);
      CardCount := Length(Cards) - 1;
      if CardCount <= 0 then
      begin
        MessageDlg(Format('Codul "%s" nu a fost gasit pe euroterm.md.',
          [AGoodsCode]), mtWarning, [mbOK], 0);
        Exit;
      end;

      // Ultimul card continua cu subsolul paginii - il taiem.
      FooterPos := Pos('main-catalog__footer', Cards[CardCount]);
      if FooterPos > 0 then
        Cards[CardCount] := Copy(Cards[CardCount], 1, FooterPos - 1);

      ProductCard := '';
      for i := 1 to CardCount do
      begin
        Card := Cards[i];
        if SameText(CardValue(Card, 'product-card__code[^>]*>\s*Cod:\s*([^<]*)</'), AGoodsCode) then
        begin
          ProductCard := Card;
          Break;
        end;
      end;

      // Cautarea e dupa text: daca nu exista potrivire exacta dar a venit un
      // singur produs, il aratam cu avertisment (codul de pe site difera).
      if (ProductCard = '') and (CardCount = 1) then
        ProductCard := Cards[1];

      if ProductCard = '' then
      begin
        MessageDlg(Format('Codul "%s" nu a fost gasit pe euroterm.md ' +
          '(cautarea a intors %d produse, niciunul cu acest cod).',
          [AGoodsCode, CardCount]), mtWarning, [mbOK], 0);
        Exit;
      end;

      ProductCode := CardValue(ProductCard, 'product-card__code[^>]*>\s*Cod:\s*([^<]*)</');
      ProductTitle := CardValue(ProductCard, 'class="product__name"[^>]*>(.*?)</a>');
      ProductURL := CardValue(ProductCard, '<a\s+href="([^"]+)"\s+class="product__name"');
      // Pret redus: price-product__now (+ price-product__old); altfel span.price
      PriceText := CardValue(ProductCard, 'class="price-product__now[^"]*"[^>]*>(.*?)</span>');
      if PriceText = '' then
        PriceText := CardValue(ProductCard, 'class="price\s*"[^>]*>(.*?)</span>');
      OldPriceText := CardValue(ProductCard, 'class="price-product__old[^"]*"[^>]*>(.*?)</span>');
      OrderText := CardValue(ProductCard, 'class="for_order[^"]*"[^>]*>(.*?)</span>');

      if OrderText <> '' then
      begin
        StatusText := OrderText;
        StatusClass := 'product-only-order';
      end
      else if ProductCard.Contains('add_to_cart') then
      begin
        StatusText := 'In stoc';
        StatusClass := 'product-available';
      end
      else
      begin
        StatusText := 'Indisponibil';
        StatusClass := 'product-not-available';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      if OldPriceText <> '' then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      if StatusClass = 'product-available' then
        Locations.Add('Produsul poate fi comandat online.')
      else if StatusClass = 'product-only-order' then
        Locations.Add('Produsul se aduce doar la comanda.');
      Locations.Add('Cantitatea exacta nu este publicata pe euroterm.md.');
      if (ProductCode <> '') and not SameText(ProductCode, AGoodsCode) then
        Locations.Add(Format('Atentie: pe site produsul are codul %s.', [ProductCode]));

      if ProductURL = '' then
        ProductURL := SearchURL
      else if ProductURL.StartsWith('/') then
        ProductURL := C_EuroTermHost + ProductURL;

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc euroterm.md';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('euroterm.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- doxyterra.md (Comitek SRL 1455, scraping, fara API) ----------------------
// Cautarea /ro/catalog/search/?q=<cod> e randata pe server; fiecare produs e un
// bloc "catalogCard j-catalog-card" cu "Articol: <cod>" (= GOODS_CODE). Cautarea
// e dupa text, deci alegem cardul cu articolul exact (33592 gaseste si 233592).
// Produsele scoase din vanzare nu apar deloc in cautare. Statutul vine din
// pagina produsului: div.product-header__availability ("In stoc", sau cu
// modificatorul --out-of-stock "In asteptare") + meta product:availability.
// Cantitatea nu se publica. Paginile de produs sint protejate de o provocare JS
// care seteaza cookie-ul challenge_passed=<defaultHash> si reincarca pagina -
// il setam noi si repetam cererea.
procedure TfrmGoodsForeignCodeDlg.GetDoxyterraProductStock(AGoodsCode: string);
const
  C_DoxyHost = 'https://doxyterra.md';
  C_CardMarker = '<div class="catalogCard j-catalog-card';
var
  HttpClient: THTTPClient;
  SearchURL: string;
  ResponseContent: string;
  Cards: TArray<string>;
  Card: string;
  ProductCard: string;
  ProductTitle: string;
  ProductURL: string;
  PriceText: string;
  OldPriceText: string;
  Availability: string;
  AvailabilityClass: string;
  MetaAvailability: string;
  StatusText: string;
  StatusClass: string;
  CardCount: Integer;
  i: Integer;
  Match: TMatch;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Primul grup din APattern, fara taguri HTML si cu entitatile decodate.
  function HtmlValue(const AText, APattern: string): string;
  var
    M: TMatch;
  begin
    Result := '';
    M := TRegEx.Match(AText, APattern, [roIgnoreCase, roSingleLine]);
    if M.Success then
    begin
      Result := TRegEx.Replace(M.Groups[1].Value, '<[^>]*>', ' ');
      Result := TRegEx.Replace(Result, '\s+', ' ');
      Result := Trim(TNetEncoding.HTML.Decode(Result));
    end;
  end;

  // GET cu trecerea provocarii JS: raspunsul scurt cu "challenge_passed" ne da
  // hash-ul cookie-ului; il punem in CookieManager si repetam cererea o data.
  function FetchPage(const AURL: string; out AContent: string): Boolean;
  var
    Response: IHTTPResponse;
    Attempt: Integer;
    HashMatch: TMatch;
  begin
    Result := False;
    AContent := '';
    for Attempt := 1 to 2 do
    begin
      Response := HttpClient.Get(AURL);
      if Response.StatusCode <> 200 then
      begin
        MessageDlg(Format('doxyterra.md: cererea a esuat (HTTP %d).'#13#10'%s',
          [Response.StatusCode, AURL]), mtError, [mbOK], 0);
        Exit;
      end;
      AContent := Response.ContentAsString(TEncoding.UTF8);

      HashMatch := TRegEx.Match(AContent, 'defaultHash\s*=\s*"([0-9a-fA-F]+)"');
      if not (HashMatch.Success and AContent.Contains('challenge_passed')) then
        Exit(True);

      HttpClient.CookieManager.AddServerCookie('challenge_passed=' +
        HashMatch.Groups[1].Value + '; path=/', C_DoxyHost);
    end;
    MessageDlg('doxyterra.md: protectia anti-bot a site-ului nu a putut fi trecuta.',
      mtError, [mbOK], 0);
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      SearchURL := Format(C_DoxyHost + '/ro/catalog/search/?q=%s',
        [TNetEncoding.URL.Encode(AGoodsCode)]);

      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        if not FetchPage(SearchURL, ResponseContent) then
          Exit;

        // Cards[0] este antetul paginii; fiecare element urmator e un produs.
        Cards := ResponseContent.Split([C_CardMarker], TStringSplitOptions.None);
        CardCount := Length(Cards) - 1;

        ProductCard := '';
        for i := 1 to CardCount do
        begin
          Card := Cards[i];
          if SameText(HtmlValue(Card, 'catalogCard-code"[^>]*>\s*Articol:\s*([^<]*)<'), AGoodsCode) then
          begin
            ProductCard := Card;
            Break;
          end;
        end;

        if ProductCard = '' then
        begin
          if CardCount = 0 then
            MessageDlg(Format('Codul "%s" nu a fost gasit pe doxyterra.md ' +
              '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
          else
            MessageDlg(Format('Codul "%s" nu a fost gasit pe doxyterra.md ' +
              '(cautarea a intors %d produse, niciunul cu acest articol).',
              [AGoodsCode, CardCount]), mtWarning, [mbOK], 0);
          Exit;
        end;

        ProductURL := HtmlValue(ProductCard, 'catalogCard-title"[^>]*>\s*<a\s+href=[''"]([^''"]+)[''"]');
        ProductTitle := HtmlValue(ProductCard, 'catalogCard-title"[^>]*>\s*<a[^>]*>(.*?)</a>');
        PriceText := HtmlValue(ProductCard, 'class="catalogCard-price"[^>]*>(.*?)</div>');
        OldPriceText := HtmlValue(ProductCard, 'class="catalogCard-oldPrice"[^>]*>(.*?)</div>');

        if ProductURL = '' then
          ProductURL := SearchURL
        else if ProductURL.StartsWith('/') then
          ProductURL := C_DoxyHost + ProductURL;

        // Pagina produsului - de aici statutul de disponibilitate
        Availability := '';
        AvailabilityClass := '';
        MetaAvailability := '';
        if (ProductURL <> SearchURL) and FetchPage(ProductURL, ResponseContent) then
        begin
          Match := TRegEx.Match(ResponseContent,
            'class="product-header__availability([^"]*)"[^>]*>(.*?)</div>',
            [roIgnoreCase, roSingleLine]);
          if Match.Success then
          begin
            AvailabilityClass := Match.Groups[1].Value;
            Availability := Trim(TNetEncoding.HTML.Decode(
              TRegEx.Replace(Match.Groups[2].Value, '<[^>]*>', ' ')));
          end;
          MetaAvailability := HtmlValue(ResponseContent,
            'property="product:availability"\s+content="([^"]*)"');
        end;
      finally
        HttpClient.Free;
      end;

      if AvailabilityClass.Contains('out-of-stock') or SameText(MetaAvailability, 'oos') or
        SameText(MetaAvailability, 'out of stock') then
      begin
        StatusText := Availability;
        if StatusText = '' then
          StatusText := 'Indisponibil';
        StatusClass := 'product-not-available';
      end
      else if SameText(MetaAvailability, 'instock') or SameText(MetaAvailability, 'in stock') or
        ((Availability <> '') and (MetaAvailability = '')) then
      begin
        StatusText := Availability;
        if StatusText = '' then
          StatusText := 'In stoc';
        StatusClass := 'product-available';
      end
      else if (Availability <> '') or (MetaAvailability <> '') then
      begin
        // preorder / alte statute - le aratam ca "la comanda"
        StatusText := Availability;
        if StatusText = '' then
          StatusText := MetaAvailability;
        StatusClass := 'product-only-order';
      end
      else
      begin
        StatusText := 'Statut necunoscut (pagina produsului nu a putut fi citita)';
        StatusClass := '';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      if OldPriceText <> '' then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      if StatusClass = 'product-available' then
        Locations.Add('Produsul poate fi comandat online.')
      else if StatusClass = 'product-not-available' then
        Locations.Add('Produsul nu este disponibil acum.');
      Locations.Add('Cantitatea exacta nu este publicata pe doxyterra.md.');

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc doxyterra.md (Comitek)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('doxyterra.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- imperia.md (TEOCOM LuX SRL 74852, scraping, fara API) --------------------
// Magazin OpenCart. Cautarea index.php?route=product/search&search=<cod> da
// blocuri "product-thumb"; candidatii se deschid pe rind si se accepta primul al
// carui <meta itemprop="sku"> (sau titlu) contine codul - aceleasi functii ca la
// incarcarea continutului (ImperiaContentUnit). Site-ul NU publica stocul:
// pagina are doar nota "Verificati disponibilitatea la operatori" si butonul
// "In cos" la toate produsele (verificat 14 oct 2026, si in cos - fara
// avertisment de stoc). Aratam deci daca produsul e activ pe site, pretul si
// link-ul; produsele scoase din catalog nu apar la cautare.
procedure TfrmGoodsForeignCodeDlg.GetImperiaProductStock(AGoodsCode: string);
const
  C_ImperiaHost = 'https://imperia.md/';
  C_MaxCandidates = 5;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  SearchURL: string;
  ResponseContent: string;
  Links: TArray<string>;
  ProductURL: string;
  ProductTitle: string;
  ProductCode: string;
  PriceText: string;
  OldPriceText: string;
  NoteText: string;
  StatusText: string;
  StatusClass: string;
  i: Integer;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Primul grup din APattern, fara taguri HTML si cu entitatile decodate.
  function HtmlValue(const AText, APattern: string): string;
  var
    M: TMatch;
  begin
    Result := '';
    M := TRegEx.Match(AText, APattern, [roIgnoreCase, roSingleLine]);
    if M.Success then
    begin
      Result := TRegEx.Replace(M.Groups[1].Value, '<[^>]*>', ' ');
      Result := TRegEx.Replace(Result, '\s+', ' ');
      Result := Trim(TNetEncoding.HTML.Decode(Result));
    end;
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      SearchURL := C_ImperiaHost + 'index.php?route=product/search&search=' +
        TNetEncoding.URL.Encode(AGoodsCode);

      ProductURL := '';
      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('imperia.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        Links := ImperiaSearchResults(Response.ContentAsString(TEncoding.UTF8));

        // Cautarea e dupa text si poate intoarce si alte produse - verificam
        // fiecare candidat dupa SKU/titlu.
        for i := 0 to High(Links) do
        begin
          if i >= C_MaxCandidates then
            Break;
          Response := HttpClient.Get(Links[i]);
          if Response.StatusCode <> 200 then
            Continue;
          ResponseContent := Response.ContentAsString(TEncoding.UTF8);
          if ImperiaPageMatchesCode(ResponseContent, AGoodsCode) then
          begin
            ProductURL := Links[i];
            Break;
          end;
        end;
      finally
        HttpClient.Free;
      end;

      if ProductURL = '' then
      begin
        if Length(Links) = 0 then
          MessageDlg(Format('Codul "%s" nu a fost gasit pe imperia.md ' +
            '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
        else
          MessageDlg(Format('Codul "%s" nu a fost gasit pe imperia.md ' +
            '(cautarea a intors %d produse, niciunul cu acest cod).',
            [AGoodsCode, Length(Links)]), mtWarning, [mbOK], 0);
        Exit;
      end;

      ProductTitle := HtmlValue(ResponseContent, '<h1[^>]*itemprop="name"[^>]*>(.*?)</h1>');
      ProductCode := HtmlValue(ResponseContent, '<meta\s+itemprop="sku"\s+content="([^"]*)"');
      // Pret redus: autocalc-product-special + autocalc-product-price (vechi);
      // altfel doar autocalc-product-price.
      PriceText := HtmlValue(ResponseContent, 'class=[''"]autocalc-product-special[''"][^>]*>(.*?)</span>');
      if PriceText <> '' then
        OldPriceText := HtmlValue(ResponseContent, 'class=[''"]autocalc-product-price[''"][^>]*>(.*?)</span>')
      else
      begin
        OldPriceText := '';
        PriceText := HtmlValue(ResponseContent, 'class=[''"]autocalc-product-price[''"][^>]*>(.*?)</span>');
      end;
      NoteText := HtmlValue(ResponseContent, 'class="check-item-availability[^"]*"[^>]*>(.*?)</div>');

      if ResponseContent.Contains('id="button-cart"') then
        StatusText := 'Activ pe site (stocul nu este publicat)'
      else
        StatusText := 'Pe site, fara buton de cumparare';
      StatusClass := '';

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      if (OldPriceText <> '') and (OldPriceText <> PriceText) then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      Locations.Add('imperia.md nu publica stocul: toate produsele din catalog au butonul "In cos".');
      if NoteText <> '' then
        Locations.Add(NoteText);
      if (ProductCode <> '') and not SameText(ProductCode, AGoodsCode) then
        Locations.Add(Format('Atentie: pe site produsul are articolul %s.', [ProductCode]));

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc imperia.md (TEOCOM LuX)';
        Dialog.lbLocationsCaption.Caption := 'Detalii:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('imperia.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- snaige.md (AIEA SRL 74995, scraping, fara API) ---------------------------
// Magazin OpenCart (ca imperia.md), in rusa implicit. Cautarea
// index.php?route=product/search&search=<cod> da blocuri "product-thumb" cu
// h4.protitle; candidatii se deschid pe rind si se accepta primul al carui
// "Артикул:" (sau "Код Товара:") este codul (= GOODS_CODE). Cantitatea nu se
// publica. Statutul: textul "Наличие:" ("В наличии" / "Нет в наличии") si
// butonul de cumparare - "button-cart" = se poate cumpara; "button-outstock"
// (dezactivat, "Запас ограничен") = epuizat, chiar daca textul spune "В наличии".
// JSON-LD-ul are mereu schema.org/InStock, deci nu e folosit (verificat 14 oct 2026).
procedure TfrmGoodsForeignCodeDlg.GetSnaigeProductStock(AGoodsCode: string);
const
  C_SnaigeHost = 'https://snaige.md/';
  C_MaxCandidates = 5;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  SearchURL: string;
  ResponseContent: string;
  Matches: TMatchCollection;
  Links: TStringList;
  ProductURL: string;
  ProductTitle: string;
  ProductArticle: string;
  ProductModel: string;
  SiteStatus: string;
  PriceText: string;
  OldPriceText: string;
  StatusText: string;
  StatusClass: string;
  i: Integer;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Primul grup din APattern, fara taguri HTML si cu entitatile decodate.
  function HtmlValue(const AText, APattern: string): string;
  var
    M: TMatch;
  begin
    Result := '';
    M := TRegEx.Match(AText, APattern, [roIgnoreCase, roSingleLine]);
    if M.Success then
    begin
      Result := TRegEx.Replace(M.Groups[1].Value, '<[^>]*>', ' ');
      Result := TRegEx.Replace(Result, '\s+', ' ');
      Result := Trim(TNetEncoding.HTML.Decode(Result));
    end;
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  Links := TStringList.Create;
  try
    try
      SearchURL := C_SnaigeHost + 'index.php?route=product/search&search=' +
        TNetEncoding.URL.Encode(AGoodsCode);

      ProductURL := '';
      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('snaige.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;

        // link-urile produselor din rezultate, fara "?search=..."
        Matches := TRegEx.Matches(Response.ContentAsString(TEncoding.UTF8),
          'class="protitle"[^>]*>\s*<a\s+href="([^"?]+)', [roIgnoreCase]);
        for i := 0 to Matches.Count - 1 do
          if Links.IndexOf(Matches[i].Groups[1].Value) < 0 then
            Links.Add(Matches[i].Groups[1].Value);

        // Cautarea e dupa text si poate intoarce si alte produse - verificam
        // fiecare candidat dupa articol / codul de model.
        for i := 0 to Links.Count - 1 do
        begin
          if i >= C_MaxCandidates then
            Break;
          Response := HttpClient.Get(Links[i]);
          if Response.StatusCode <> 200 then
            Continue;
          ResponseContent := Response.ContentAsString(TEncoding.UTF8);
          ProductArticle := HtmlValue(ResponseContent, 'Артикул:\s*</span>([^<]*)<');
          ProductModel := HtmlValue(ResponseContent, 'Код Товара:\s*</span>([^<]*)<');
          if SameText(ProductArticle, AGoodsCode) or SameText(ProductModel, AGoodsCode) then
          begin
            ProductURL := Links[i];
            Break;
          end;
        end;
      finally
        HttpClient.Free;
      end;

      if ProductURL = '' then
      begin
        if Links.Count = 0 then
          MessageDlg(Format('Codul "%s" nu a fost gasit pe snaige.md ' +
            '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
        else
          MessageDlg(Format('Codul "%s" nu a fost gasit pe snaige.md ' +
            '(cautarea a intors %d produse, niciunul cu acest articol).',
            [AGoodsCode, Links.Count]), mtWarning, [mbOK], 0);
        Exit;
      end;

      ProductTitle := HtmlValue(ResponseContent, '<h1[^>]*>(.*?)</h1>');
      SiteStatus := HtmlValue(ResponseContent, 'Наличие:\s*</span>([^<]*)<');
      // Pret redus: h2.price-special + span.price-old; altfel h2.pro-price
      PriceText := HtmlValue(ResponseContent, 'class="price-special"[^>]*>(.*?)</h2>');
      if PriceText <> '' then
        OldPriceText := HtmlValue(ResponseContent, 'class="price-old"[^>]*>(.*?)</span>')
      else
      begin
        OldPriceText := '';
        PriceText := HtmlValue(ResponseContent, 'class="pro-price"[^>]*>(.*?)</h2>');
      end;

      if ResponseContent.Contains('id="button-cart"') then
      begin
        StatusText := 'In stoc';
        StatusClass := 'product-available';
      end
      else if ResponseContent.Contains('id="button-outstock"') or
        SiteStatus.StartsWith('Нет', True) then
      begin
        StatusText := 'Indisponibil';
        StatusClass := 'product-not-available';
      end
      else
      begin
        // alt statut OpenCart ("Ожидается", "Предзаказ"...) - il aratam ca "la comanda"
        StatusText := SiteStatus;
        if StatusText = '' then
          StatusText := 'Statut necunoscut';
        StatusClass := 'product-only-order';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      if SiteStatus <> '' then
        Locations.Add('Pe site: ' + SiteStatus);
      if (OldPriceText <> '') and (OldPriceText <> PriceText) then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      if StatusClass = 'product-available' then
        Locations.Add('Produsul poate fi comandat online.')
      else if ResponseContent.Contains('id="button-outstock"') then
        Locations.Add('Butonul de cumparare e dezactivat pe site (stoc epuizat).');
      Locations.Add('Cantitatea exacta nu este publicata pe snaige.md.');
      if ProductModel <> '' then
        Locations.Add('Model: ' + ProductModel);
      if (ProductArticle <> '') and not SameText(ProductArticle, AGoodsCode) then
        Locations.Add(Format('Atentie: pe site produsul are articolul %s.', [ProductArticle]));

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc snaige.md (AIEA)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('snaige.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Links.Free;
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- pernamea.md (PERNAMEA S.R.L. 307501) -----------------------------------
// Cautarea dupa cod si parsarea paginii sint in PernaMeaContentUnit (aceleasi si pentru
// incarcarea continutului din frame78): search?s=<cod> sare direct pe produs (302) doar la
// codul exact; codul se verifica in <div class="cod-item">. Statutul vine din JSON-LD
// (offers.availability + price), disponibilitatea pe magazine (Centru, Ciocana, Botanica)
// din lista "Disponibilitate". Cantitatile nu se publica.
procedure TfrmGoodsForeignCodeDlg.GetPernaMeaProductStock(AGoodsCode: string);
var
  Stock: TPernaMeaStock;
  Candidates, I, InStores: Integer;
  StatusText, StatusClass: string;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;
begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      if not TPernaMeaContentLoader.GetStock(AGoodsCode, Stock, Candidates) then
      begin
        Screen.Cursor := crDefault;
        if Candidates = 0 then
          MessageDlg(Format('Codul "%s" nu a fost gasit pe pernamea.md ' +
            '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
        else
          MessageDlg(Format('Codul "%s" nu a fost gasit pe pernamea.md ' +
            '(cautarea a intors %d produse, niciunul cu acest articol).',
            [AGoodsCode, Candidates]), mtWarning, [mbOK], 0);
        Exit;
      end;

      InStores := 0;
      for I := 0 to High(Stock.Stores) do
        if Stock.Stores[I].Available then
          Inc(InStores);

      if SameText(Stock.Availability, 'InStock') or SameText(Stock.Availability, 'LimitedAvailability') then
      begin
        StatusText := 'In stoc';
        StatusClass := 'product-available';
      end
      else if SameText(Stock.Availability, 'OutOfStock') or SameText(Stock.Availability, 'SoldOut') or
        SameText(Stock.Availability, 'Discontinued') then
      begin
        StatusText := 'Indisponibil';
        StatusClass := 'product-not-available';
      end
      else if Stock.Availability <> '' then
      begin
        // PreOrder / BackOrder / OnlineOnly...
        StatusText := 'La comanda (' + Stock.Availability + ')';
        StatusClass := 'product-only-order';
      end
      else
      begin
        // fara JSON-LD - dupa magazine
        if InStores > 0 then
        begin
          StatusText := 'In stoc';
          StatusClass := 'product-available';
        end
        else
        begin
          StatusText := 'Statut necunoscut';
          StatusClass := 'product-only-order';
        end;
      end;
      if Stock.Price <> '' then
        StatusText := StatusText + ' - ' + Stock.Price + ' lei';

      for I := 0 to High(Stock.Stores) do
        Locations.Add(Stock.Stores[I].Name + ': ' + Stock.Stores[I].Status);
      if Stock.SiteStatus <> '' then
        Locations.Add('Pe site: ' + Stock.SiteStatus);
      if (Length(Stock.Stores) > 0) and (InStores = 0) and (StatusClass = 'product-available') then
        Locations.Add('Atentie: site-ul spune "in stoc", dar niciun magazin nu are produsul (doar depozit / online).');
      Locations.Add('Cantitatea exacta nu este publicata pe pernamea.md.');

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, Stock.Title, StatusText, StatusClass, Stock.Url, Locations);
        Dialog.Caption := 'Stoc pernamea.md (PERNAMEA)';
        Dialog.lbLocationsCaption.Caption := 'Disponibilitate in magazine:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('pernamea.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;
// -- alo.md (MOBILE STOCK SRL 246795, API JSON al platformei ecom.md) --------
// Acelasi flux ca la snaige.md: cautarea dupa cod -> candidatii verificati dupa
// cod -> fisa produsului -> statut + pret. Site-ul (Nuxt) isi ia datele din
// API-ul public al platformei ecom.md (https://admin.ecom.md), nu din HTML:
//   GET general/v2/search/search/?query=<cod> -> products[] {code, url, stock,
//       available, price, old_price, title}. Cautarea e aproximativa
//       ("MI0000311" intoarce 8 produse), deci se accepta doar code = GOODS_CODE;
//   GET general/v2/product/<url>/             -> product {stock, available,
//       to_order, to_order_days, preorder, old_price, brand, availability}.
// Antetul "token" alege magazinul: fara el (sau cu altul) raspund produsele
// altui magazin ecom.md. Tokenul e public, in configurarea Nuxt a paginii
// (TOKEN:"..."); il recitim o data pe sesiune de pe alo.md, cu valoarea din
// 17 oct 2026 ca rezerva. Spre deosebire de snaige.md, alo.md publica si
// cantitatea (stock). Pagina publica: https://alo.md/ro/product/<url>.
var
  GAloShopToken: string = '';

procedure TfrmGoodsForeignCodeDlg.GetAloProductStock(AGoodsCode: string);
const
  C_AloApi = 'https://admin.ecom.md/';
  C_AloSite = 'https://alo.md/';
  C_AloDefaultToken = 'xqp!pgw5bfc6KNF@chu';
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  Json: TJSONValue;
  Item: TJSONValue;
  Product: TJSONObject;
  Availability: TJSONObject;
  ProductSlug: string;
  ProductURL: string;
  ProductTitle: string;
  Brand: string;
  ToOrderDays: string;
  Candidates: Integer;
  Stock: Double;
  Price: Double;
  OldPrice: Double;
  Available: Boolean;
  ToOrder: Boolean;
  StatusText: string;
  StatusClass: string;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;
  M: TMatch;

  function JValue(AObj: TJSONObject; const AName: string): TJSONValue;
  begin
    Result := nil;
    if Assigned(AObj) then
    begin
      Result := AObj.GetValue(AName);
      if Result is TJSONNull then
        Result := nil;
    end;
  end;

  function JStr(AObj: TJSONObject; const AName: string): string;
  var
    V: TJSONValue;
  begin
    V := JValue(AObj, AName);
    if (V = nil) or (V is TJSONObject) or (V is TJSONArray) then
      Result := ''
    else
      Result := Trim(V.Value);
  end;

  // pretul vine uneori ca text ("5999.00")
  function JNum(AObj: TJSONObject; const AName: string): Double;
  var
    V: TJSONValue;
  begin
    Result := 0;
    V := JValue(AObj, AName);
    if V is TJSONNumber then
      Result := TJSONNumber(V).AsDouble
    else if Assigned(V) and not (V is TJSONObject) and not (V is TJSONArray) then
      Result := StrToFloatDef(StringReplace(Trim(V.Value), ',', '.', [rfReplaceAll]), 0,
        TFormatSettings.Invariant);
  end;

  function JBool(AObj: TJSONObject; const AName: string): Boolean;
  var
    V: TJSONValue;
  begin
    V := JValue(AObj, AName);
    Result := (V is TJSONBool) and TJSONBool(V).AsBoolean;
  end;

  function JObj(AObj: TJSONObject; const AName: string): TJSONObject;
  var
    V: TJSONValue;
  begin
    V := JValue(AObj, AName);
    if V is TJSONObject then
      Result := TJSONObject(V)
    else
      Result := nil;
  end;

  function GetJson(const AURL: string): TJSONObject;
  var
    V: TJSONValue;
  begin
    Response := HttpClient.Get(AURL, nil, [TNetHeader.Create('token', GAloShopToken),
      TNetHeader.Create('Accept-Language', 'ro'), TNetHeader.Create('Accept', 'application/json')]);
    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('cererea a esuat (HTTP %d).'#13#10'%s', [Response.StatusCode, AURL]);
    V := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
    if not (V is TJSONObject) then
    begin
      V.Free;
      raise Exception.Create('raspuns invalid de la API-ul ecom.md.'#13#10 + AURL);
    end;
    Result := TJSONObject(V);
  end;

  function Lei(AValue: Double): string;
  begin
    Result := FormatFloat('0.##', AValue) + ' lei';
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      ProductSlug := '';
      Candidates := 0;
      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';

        // tokenul magazinului din configurarea Nuxt a site-ului (o data pe sesiune)
        if GAloShopToken = '' then
        begin
          try
            Response := HttpClient.Get(C_AloSite);
            if Response.StatusCode = 200 then
            begin
              M := TRegEx.Match(Response.ContentAsString(TEncoding.UTF8), 'TOKEN:"([^"\\]+)"');
              if M.Success then
                GAloShopToken := M.Groups[1].Value;
            end;
          except
            // pagina nu s-a deschis - ramine valoarea de rezerva
          end;
          if GAloShopToken = '' then
            GAloShopToken := C_AloDefaultToken;
        end;

        // cautarea e aproximativa - se accepta doar produsul cu exact acest cod
        Json := GetJson(C_AloApi + 'general/v2/search/search/?query=' + TNetEncoding.URL.Encode(AGoodsCode));
        try
          Item := JValue(TJSONObject(Json), 'products');
          if Item is TJSONArray then
          begin
            Candidates := TJSONArray(Item).Count;
            for Item in TJSONArray(Item) do
              if (Item is TJSONObject) and SameText(JStr(TJSONObject(Item), 'code'), AGoodsCode) then
              begin
                ProductSlug := JStr(TJSONObject(Item), 'url');
                Break;
              end;
          end;
        finally
          Json.Free;
        end;

        if ProductSlug = '' then
        begin
          Screen.Cursor := crDefault;
          if Candidates = 0 then
            MessageDlg(Format('Codul "%s" nu a fost gasit pe alo.md ' +
              '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
          else
            MessageDlg(Format('Codul "%s" nu a fost gasit pe alo.md ' +
              '(cautarea a intors %d produse, niciunul cu acest cod).',
              [AGoodsCode, Candidates]), mtWarning, [mbOK], 0);
          Exit;
        end;

        // fisa produsului: stocul, statutul "la comanda", pretul vechi
        Json := GetJson(C_AloApi + 'general/v2/product/' + TNetEncoding.URL.Encode(ProductSlug) + '/');
        try
          Product := JObj(TJSONObject(Json), 'product');
          if Product = nil then
            raise Exception.Create('fisa produsului nu a venit de la API-ul ecom.md.');
          ProductTitle := JStr(Product, 'title');
          Stock := JNum(Product, 'stock');
          Price := JNum(Product, 'price');
          OldPrice := JNum(Product, 'old_price');
          Available := JBool(Product, 'available');
          ToOrder := JBool(Product, 'to_order') or JBool(Product, 'preorder');
          ToOrderDays := JStr(Product, 'to_order_days');
          Brand := JStr(JObj(Product, 'brand'), 'name');
          Availability := JObj(Product, 'availability');

          if Available and (Stock > 0) then
          begin
            StatusText := Format('In stoc: %s buc.', [FormatFloat('0.##', Stock)]);
            StatusClass := 'product-available';
          end
          else if ToOrder or JBool(Availability, 'to_order') then
          begin
            StatusText := 'La comanda';
            if ToOrderDays <> '' then
              StatusText := StatusText + Format(' (%s zile)', [ToOrderDays]);
            StatusClass := 'product-only-order';
          end
          else
          begin
            StatusText := 'Indisponibil';
            StatusClass := 'product-not-available';
          end;

          // Pretul se afiseaza langa statutul de stoc
          if Price > 0 then
            StatusText := StatusText + ' - ' + Lei(Price);

          Locations.Add(Format('Cantitate pe site: %s buc.', [FormatFloat('0.##', Stock)]));
          if OldPrice > Price then
            Locations.Add(Format('Pret redus de la %s la %s', [Lei(OldPrice), Lei(Price)]));
          if JBool(Availability, 'in_showroom') then
            Locations.Add('Disponibil in showroom.');
          if JBool(Availability, 'in_outlet') and (JNum(Availability, 'outlet_qty') > 0) then
            Locations.Add(Format('Outlet: %s buc.', [FormatFloat('0.##', JNum(Availability, 'outlet_qty'))]));
          if StatusClass = 'product-available' then
            Locations.Add('Produsul poate fi comandat online.');
          if Brand <> '' then
            Locations.Add('Brand: ' + Brand);
          if not SameText(JStr(Product, 'code'), AGoodsCode) then
            Locations.Add(Format('Atentie: fisa produsului are codul %s.', [JStr(Product, 'code')]));
        finally
          Json.Free;
        end;
      finally
        HttpClient.Free;
      end;

      ProductURL := C_AloSite + 'ro/product/' + ProductSlug;
      Screen.Cursor := crDefault;
      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc alo.md (Mobile Stock)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
      begin
        Screen.Cursor := crDefault;
        MessageDlg('alo.md: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- h-t.md (HI-Tech SRL 262735, scraping, fara API) -------------------------
// Magazin CS-Cart. GOODS_CODE = "COD" de pe site (ex. "T-000077698", cu T
// chirilic). Cautarea dupa codul intreg nu gaseste nimic, dar dupa partea
// numerica (q=000077698&pcode_from_q=Y) da; la un singur rezultat site-ul
// redirectioneaza direct pe pagina produsului. Produsul il identificam dupa
// COD (id="sku_<product_id>"), apoi citim tabelul "Disponibilitate" pe magazine
// (ty-warehouses-store__group / __name / __availability). Ne intereseaza
// randul "Chisinau" - "Depozit": "In stoc", "La comanda (1-3 zile)" sau
// "Nu este disponibil". Cantitatea nu se publica (verificat 15 oct 2026).
procedure TfrmGoodsForeignCodeDlg.GetHiTechProductStock(AGoodsCode: string);
const
  C_HiTechHost = 'https://h-t.md/md/';
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  SearchURL: string;
  ResponseContent: string;
  CodeNumber: string;
  Matches: TMatchCollection;
  ProductID: string;
  ProductURL: string;
  ProductTitle: string;
  SiteStatus: string;
  PriceText: string;
  OldPriceText: string;
  StoresHtml: string;
  Groups: TArray<string>;
  GroupName: string;
  StoreName: string;
  StoreAvailability: string;
  DepotAvailability: string;
  StatusText: string;
  StatusClass: string;
  i, j, p: Integer;
  OtherStores: TStringList;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Text fara taguri, cu entitatile decodate (si &nbsp; ca spatiu).
  function CleanHtml(const AText: string): string;
  begin
    Result := TRegEx.Replace(AText, '<[^>]*>', ' ');
    Result := TNetEncoding.HTML.Decode(Result).Replace(#160, ' ');
    Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
  end;

  // Primul grup din APattern, curatat.
  function HtmlValue(const AText, APattern: string): string;
  var
    M: TMatch;
  begin
    Result := '';
    M := TRegEx.Match(AText, APattern, [roIgnoreCase, roSingleLine]);
    if M.Success then
      Result := CleanHtml(M.Groups[1].Value);
  end;

  // Partea numerica a codului: "T-000077698" -> "000077698".
  function CodeDigits(const ACode: string): string;
  begin
    Result := TRegEx.Replace(Trim(ACode), '^\D+-', '');
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  OtherStores := TStringList.Create;
  Locations := TStringList.Create;
  try
    try
      CodeNumber := CodeDigits(AGoodsCode);
      SearchURL := C_HiTechHost + '?dispatch=products.search&q=' +
        TNetEncoding.URL.Encode(CodeNumber) + '&pcode_from_q=Y&search_performed=Y';

      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('h-t.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);

        // Produsul cu acest COD - pe pagina de produs sau in lista de rezultate
        // (pagina mai contine si produse recomandate, deci comparam codul).
        ProductID := '';
        Matches := TRegEx.Matches(ResponseContent,
          'id="sku_(\d+)">\s*COD:\s*</label>\s*<span[^>]*>\s*([^<]*?)\s*<', [roIgnoreCase]);
        for i := 0 to Matches.Count - 1 do
          if SameText(CodeDigits(Matches[i].Groups[2].Value), CodeNumber) then
          begin
            ProductID := Matches[i].Groups[1].Value;
            Break;
          end;

        if ProductID = '' then
        begin
          MessageDlg(Format('Codul "%s" nu a fost gasit pe h-t.md ' +
            '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0);
          Exit;
        end;

        // Cautarea a intors o lista - deschidem pagina produsului.
        if not ResponseContent.Contains('id="warehouses_stock_availability_' + ProductID + '"') then
        begin
          Response := HttpClient.Get(C_HiTechHost + '?dispatch=products.view&product_id=' + ProductID);
          if Response.StatusCode <> 200 then
          begin
            MessageDlg(Format('h-t.md: nu s-a putut deschide pagina produsului (HTTP %d).',
              [Response.StatusCode]), mtError, [mbOK], 0);
            Exit;
          end;
          ResponseContent := Response.ContentAsString(TEncoding.UTF8);
        end;
      finally
        HttpClient.Free;
      end;

      ProductURL := HtmlValue(ResponseContent, '<link\s+rel="canonical"\s+href="([^"]+)"');
      if ProductURL = '' then
        ProductURL := C_HiTechHost + '?dispatch=products.view&product_id=' + ProductID;
      ProductTitle := HtmlValue(ResponseContent, '<h1[^>]*>(.*?)</h1>');
      // Statutul general de langa pret: "in magazine" / "pre-comanda"
      SiteStatus := HtmlValue(ResponseContent, 'id="in_stock_info_' + ProductID +
        '"[^>]*>.*?</span>\s*<span class="stock-type">(.*?)</span>');
      PriceText := HtmlValue(ResponseContent, 'id="sec_discounted_price_' + ProductID + '"[^>]*>(.*?)</span>');
      OldPriceText := HtmlValue(ResponseContent, 'id="sec_list_price_' + ProductID + '"[^>]*>(.*?)</span>');
      if PriceText <> '' then
        PriceText := PriceText + ' MDL';
      if OldPriceText <> '' then
        OldPriceText := OldPriceText + ' MDL';

      // Tabelul de magazine: grupe (localitate) cu magazinele lor.
      DepotAvailability := '';
      StoresHtml := '';
      i := Pos('id="warehouses_list_items_', ResponseContent);
      if i > 0 then
      begin
        p := Pos('_not_found"', ResponseContent, i);
        if p = 0 then
          p := Length(ResponseContent) + 1;
        StoresHtml := Copy(ResponseContent, i, p - i);
      end;
      Groups := StoresHtml.Split(['class="ty-warehouses-store__group"'], TStringSplitOptions.None);
      for i := 1 to High(Groups) do
      begin
        GroupName := HtmlValue(Groups[i], 'ty-warehouses-store__group-name"[^>]*>(.*?)</div>');
        Matches := TRegEx.Matches(Groups[i],
          'ty-warehouses-store__name"[^>]*>(.*?)</a>.*?ty-warehouses-store__availability"[^>]*>(.*?)</div>',
          [roIgnoreCase, roSingleLine]);
        for j := 0 to Matches.Count - 1 do
        begin
          StoreName := CleanHtml(Matches[j].Groups[1].Value);
          StoreAvailability := CleanHtml(Matches[j].Groups[2].Value);
          if SameText(StoreName, 'Depozit') and GroupName.ToLower.Contains('chisinau') then
            DepotAvailability := StoreAvailability
          else
            OtherStores.Add(Format('%s - %s: %s', [GroupName, StoreName, StoreAvailability]));
        end;
      end;

      if DepotAvailability = '' then
      begin
        StatusText := 'Depozit Chisinau: fara informatie';
        if SiteStatus <> '' then
          StatusText := StatusText + ' (pe site: ' + SiteStatus + ')';
        StatusClass := '';
      end
      else
      begin
        StatusText := 'Depozit Chisinau: ' + DepotAvailability;
        if DepotAvailability.ToLower.Contains('comand') then
          StatusClass := 'product-only-order'
        else if DepotAvailability.ToLower.Contains('stoc') then
          StatusClass := 'product-available'
        else
          StatusClass := 'product-not-available';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      if (OldPriceText <> '') and (OldPriceText <> PriceText) then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      if SiteStatus <> '' then
        Locations.Add('Statut general pe site: ' + SiteStatus);
      if OtherStores.Count > 0 then
      begin
        Locations.Add('Alte magazine:');
        for i := 0 to OtherStores.Count - 1 do
          Locations.Add('  ' + OtherStores[i]);
      end;
      Locations.Add('Cantitatea exacta nu este publicata pe h-t.md.');

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc h-t.md (HI-Tech)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('h-t.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    OtherStores.Free;
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- trisauto.md (Tris SRL 8606, scraping, fara API) --------------------------
// www.tris.md redirectioneaza pe trisauto.md (anvelope/jante). GOODS_CODE =
// articolul de pe site (ex. 36830). Cautarea ro/podbor?search_type=searchbar&
// searchword=<cod> da carduri li.item-wrapper; deschidem candidatii si
// acceptam pagina al carei <ngcart-addtocart article="..."> este codul.
// Acelasi tag are: exist (2 = "Disponibil", 1 = "Suna la depozit" - cantitate
// insuficienta, 0 = "Nu este disponibil"), price / old-price (lei) si DOUA
// atribute quantity: primul e cantitatea din formular (1), al doilea - stocul
// (verificat 15 oct 2026).
procedure TfrmGoodsForeignCodeDlg.GetTrisautoProductStock(AGoodsCode: string);
const
  C_TrisHost = 'https://trisauto.md/';
  C_MaxCandidates = 5;
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  SearchURL: string;
  ResponseContent: string;
  ResultsHtml: string;
  Matches: TMatchCollection;
  Links: TStringList;
  ProductURL: string;
  ProductTag: string;
  TagMatch: TMatch;
  ProductTitle: string;
  ExistValue: string;
  Quantity: Integer;
  PriceText: string;
  OldPriceText: string;
  StatusText: string;
  StatusClass: string;
  i, p: Integer;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  // Primul grup din APattern, fara taguri HTML si cu entitatile decodate.
  function HtmlValue(const AText, APattern: string): string;
  var
    M: TMatch;
  begin
    Result := '';
    M := TRegEx.Match(AText, APattern, [roIgnoreCase, roSingleLine]);
    if M.Success then
    begin
      Result := TRegEx.Replace(M.Groups[1].Value, '<[^>]*>', ' ');
      Result := TRegEx.Replace(Result, '\s+', ' ');
      Result := Trim(TNetEncoding.HTML.Decode(Result));
    end;
  end;

  // Valoarea atributului AName din tag; ALast = ultima aparitie (quantity e dublat).
  function TagAttr(const ATag, AName: string; ALast: Boolean = False): string;
  var
    M: TMatchCollection;
  begin
    Result := '';
    M := TRegEx.Matches(ATag, '\s' + AName + '="([^"]*)"', [roIgnoreCase]);
    if M.Count > 0 then
      if ALast then
        Result := M[M.Count - 1].Groups[1].Value
      else
        Result := M[0].Groups[1].Value;
  end;

begin
  AGoodsCode := Trim(AGoodsCode);
  if AGoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Links := TStringList.Create;
  Locations := TStringList.Create;
  try
    try
      SearchURL := C_TrisHost + 'ro/podbor?search_type=searchbar&searchword=' +
        TNetEncoding.URL.Encode(AGoodsCode);

      ProductURL := '';
      ProductTag := '';
      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'text/html,application/xhtml+xml,*/*';

        Response := HttpClient.Get(SearchURL);
        if Response.StatusCode <> 200 then
        begin
          MessageDlg(Format('trisauto.md: cautarea a esuat (HTTP %d).',
            [Response.StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);

        // Doar blocul cu rezultatele cautarii (restul paginii are alte link-uri).
        ResultsHtml := '';
        i := Pos('id="search-results"', ResponseContent);
        if i > 0 then
        begin
          p := Pos('pagination-block', ResponseContent, i);
          if p = 0 then
            p := Length(ResponseContent) + 1;
          ResultsHtml := Copy(ResponseContent, i, p - i);
        end;
        Matches := TRegEx.Matches(ResultsHtml,
          '<li\s+class="item-wrapper"[^>]*>\s*<a\s+href="([^"]+)"', [roIgnoreCase]);
        for i := 0 to Matches.Count - 1 do
          if Links.IndexOf(Matches[i].Groups[1].Value) < 0 then
            Links.Add(Matches[i].Groups[1].Value);

        // Cautarea e dupa text - verificam articolul fiecarui candidat.
        for i := 0 to Links.Count - 1 do
        begin
          if i >= C_MaxCandidates then
            Break;
          Response := HttpClient.Get(Links[i]);
          if Response.StatusCode <> 200 then
            Continue;
          ResponseContent := Response.ContentAsString(TEncoding.UTF8);
          TagMatch := TRegEx.Match(ResponseContent, '<ngcart-addtocart\s[^>]*>', [roIgnoreCase]);
          if TagMatch.Success then
            ProductTag := TagMatch.Value
          else
            ProductTag := '';
          if SameText(TagAttr(ProductTag, 'article'), AGoodsCode) then
          begin
            ProductURL := Links[i];
            Break;
          end;
        end;
      finally
        HttpClient.Free;
      end;

      if ProductURL = '' then
      begin
        if Links.Count = 0 then
          MessageDlg(Format('Codul "%s" nu a fost gasit pe trisauto.md ' +
            '(produsul lipseste din catalogul site-ului).', [AGoodsCode]), mtWarning, [mbOK], 0)
        else
          MessageDlg(Format('Codul "%s" nu a fost gasit pe trisauto.md ' +
            '(cautarea a intors %d produse, niciunul cu acest articol).',
            [AGoodsCode, Links.Count]), mtWarning, [mbOK], 0);
        Exit;
      end;

      ProductTitle := HtmlValue(ResponseContent, '<h1[^>]*>(.*?)</h1>');
      ExistValue := TagAttr(ProductTag, 'exist');
      Quantity := StrToIntDef(TagAttr(ProductTag, 'quantity', True), 0);
      PriceText := TagAttr(ProductTag, 'price');
      OldPriceText := TagAttr(ProductTag, 'old-price');
      if PriceText <> '' then
        PriceText := PriceText + ' lei';
      if (OldPriceText = '') or (OldPriceText = '0') then
        OldPriceText := ''
      else
        OldPriceText := OldPriceText + ' lei';

      if ExistValue = '2' then
      begin
        StatusText := Format('Disponibil (%d buc.)', [Quantity]);
        StatusClass := 'product-available';
      end
      else if ExistValue = '1' then
      begin
        StatusText := Format('Cantitate limitata - suna la depozit (%d buc.)', [Quantity]);
        StatusClass := 'product-only-order';
      end
      else if ExistValue = '0' then
      begin
        StatusText := 'Nu este disponibil';
        StatusClass := 'product-not-available';
      end
      else
      begin
        StatusText := 'Statut necunoscut';
        StatusClass := '';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceText <> '' then
        StatusText := StatusText + ' - ' + PriceText;
      Locations.Add(Format('Stoc pe site: %d buc.', [Quantity]));
      if (OldPriceText <> '') and (OldPriceText <> PriceText) then
        Locations.Add(Format('Pret redus de la %s la %s', [OldPriceText, PriceText]));
      if TagAttr(ProductTag, 'data') <> '' then
        Locations.Add('Dimensiune: ' + TagAttr(ProductTag, 'data'));
      if ExistValue = '1' then
        Locations.Add('Site-ul cere confirmarea cantitatii la depozit: ' +
          HtmlValue(ResponseContent, 'class="product-availability-phone"[^>]*>(.*?)</h2>'));

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(AGoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc trisauto.md (Tris)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('trisauto.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Links.Free;
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

// -- muncitorul.md (Olis Grup SRL 251465, API JSON) --------------------------
// GET https://price.muncitorul.md/api/product.php/?sku=<cod> intoarce produsul
// din dump-ul 1C: code, titluRO/RU, pret_vinz, pret_online, stoc (cantitate),
// tva, brand, categorieRO, link_produs, imagini, features. Codul inexistent da
// HTTP 404 cu {"error":"SKU not found in 1C dump","sku":...}.
procedure TfrmGoodsForeignCodeDlg.GetMuncitorulProductStock(GoodsCode: string);
const
  C_MuncitorulApi = 'https://price.muncitorul.md/api/product.php/?sku=%s';
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  RequestURL: string;
  StatusCode: Integer;
  ResponseContent: string;
  Json: TJSONValue;
  Obj: TJSONObject;
  ErrorText: string;
  ProductCode: string;
  ProductTitle: string;
  ProductURL: string;
  Category: string;
  Brand: string;
  VatText: string;
  PriceSale: Double;
  PriceOnline: Double;
  Stock: Double;
  StatusText: string;
  StatusClass: string;
  Locations: TStringList;
  Dialog: TfrmATehnoStockResultDlg;

  function JsonStr(const AName: string): string;
  var
    V: TJSONValue;
  begin
    Result := '';
    V := Obj.GetValue(AName);
    if Assigned(V) and not (V is TJSONNull) then
      Result := Trim(V.Value);
  end;

  // Numerele pot veni si ca text ("1480.00") - le citim pe ambele.
  function JsonNum(const AName: string): Double;
  var
    V: TJSONValue;
    FS: TFormatSettings;
  begin
    Result := 0;
    V := Obj.GetValue(AName);
    if V is TJSONNumber then
      Result := TJSONNumber(V).AsDouble
    else if Assigned(V) and not (V is TJSONNull) then
    begin
      FS := TFormatSettings.Invariant;
      Result := StrToFloatDef(StringReplace(Trim(V.Value), ',', '.', [rfReplaceAll]), 0, FS);
    end;
  end;

begin
  GoodsCode := Trim(GoodsCode);
  if GoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      RequestURL := Format(C_MuncitorulApi, [TNetEncoding.URL.Encode(GoodsCode)]);

      HttpClient := THTTPClient.Create;
      try
        HttpClient.ConnectionTimeout := 15000;
        HttpClient.ResponseTimeout := 30000;
        HttpClient.CustomHeaders['User-Agent'] :=
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
        HttpClient.CustomHeaders['Accept'] := 'application/json';

        Response := HttpClient.Get(RequestURL);
        StatusCode := Response.StatusCode;
        ResponseContent := Response.ContentAsString(TEncoding.UTF8);
      finally
        HttpClient.Free;
      end;

      Json := TJSONObject.ParseJSONValue(ResponseContent);
      try
        if not (Json is TJSONObject) then
        begin
          MessageDlg(Format('muncitorul.md: raspuns invalid (HTTP %d).'#13#10'%s',
            [StatusCode, RequestURL]), mtError, [mbOK], 0);
          Exit;
        end;
        Obj := TJSONObject(Json);

        ErrorText := JsonStr('error');
        if (StatusCode = 404) or (ErrorText <> '') then
        begin
          if (StatusCode = 404) or ErrorText.Contains('not found') then
            MessageDlg(Format('Codul "%s" nu a fost gasit la muncitorul.md (Olis Grup).',
              [GoodsCode]), mtWarning, [mbOK], 0)
          else
            MessageDlg(Format('muncitorul.md: %s (HTTP %d).',
              [ErrorText, StatusCode]), mtError, [mbOK], 0);
          Exit;
        end;
        if StatusCode <> 200 then
        begin
          MessageDlg(Format('muncitorul.md: cererea a esuat (HTTP %d).'#13#10'%s',
            [StatusCode, RequestURL]), mtError, [mbOK], 0);
          Exit;
        end;

        ProductCode := JsonStr('code');
        ProductTitle := JsonStr('titluRO');
        if ProductTitle = '' then
          ProductTitle := JsonStr('titluRU');
        ProductURL := JsonStr('link_produs');
        Category := JsonStr('categorieRO');
        Brand := JsonStr('brand');
        VatText := JsonStr('tva');
        PriceSale := JsonNum('pret_vinz');
        PriceOnline := JsonNum('pret_online');
        Stock := JsonNum('stoc');
      finally
        Json.Free;
      end;

      if Stock > 0 then
      begin
        StatusText := Format('In stoc: %s buc.', [FormatFloat('0.##', Stock)]);
        StatusClass := 'product-available';
      end
      else
      begin
        StatusText := 'Lipsa in stoc';
        StatusClass := 'product-not-available';
      end;

      // Pretul se afiseaza langa statutul de stoc
      if PriceOnline > 0 then
        StatusText := StatusText + Format(' - %s lei', [FormatFloat('0.##', PriceOnline)])
      else if PriceSale > 0 then
        StatusText := StatusText + Format(' - %s lei', [FormatFloat('0.##', PriceSale)]);

      Locations.Add(Format('Cantitate in stoc: %s', [FormatFloat('0.##', Stock)]));
      if PriceSale > 0 then
        Locations.Add(Format('Pret vinzare: %s lei', [FormatFloat('0.00', PriceSale)]));
      if PriceOnline > 0 then
        Locations.Add(Format('Pret online: %s lei', [FormatFloat('0.00', PriceOnline)]));
      if VatText <> '' then
        Locations.Add('TVA: ' + VatText);
      if Brand <> '' then
        Locations.Add('Brand: ' + Brand);
      if Category <> '' then
        Locations.Add('Categorie: ' + Category);
      if (ProductCode <> '') and not SameText(ProductCode, GoodsCode) then
        Locations.Add(Format('Atentie: API-ul a intors articolul %s.', [ProductCode]));

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(GoodsCode, ProductTitle, StatusText, StatusClass,
          ProductURL, Locations);
        Dialog.Caption := 'Stoc muncitorul.md (Olis Grup)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
        MessageDlg('muncitorul.md: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetScopProductStock(GoodsCode: string);
// API-ul de parteneri SCOP v2 (Triomac 209280). GOODS_CODE = sku-ul SCOP; API-ul nu cauta
// dupa sku, asa ca FindBySku parcurge catalogul compact (11 pagini, cateva secunde).
// Peste prag (azi 10) stocul vine ca "10 si mai mult" (stock_exact = false) - afisam "10+".
var
  APIClient: TSCOPAPIClient;
  Products: TArray<TScopProduct>;
  P: TScopProduct;
  V: TScopVariation;
  Locations: TStringList;
  StatusText, StatusClass, PriceText: string;
  Dialog: TfrmATehnoStockResultDlg;
  I: Integer;

  function Opt(ACondition: Boolean; const AText: string): string;
  begin
    if ACondition then
      Result := AText
    else
      Result := '';
  end;

begin
  GoodsCode := Trim(GoodsCode);
  if GoodsCode = '' then
    Exit;

  Screen.Cursor := crHourGlass;
  Locations := TStringList.Create;
  try
    try
      // credentialele stau in TS_API_CONFIG (API_CODE = 'SCOP'), nu in cod
      APIClient := TSCOPAPIClient.CreateFromConfig(dmDB.IBCConnection);
      try
        Products := APIClient.FindBySku(GoodsCode);
      finally
        APIClient.Free;
      end;
      Screen.Cursor := crDefault;

      if Length(Products) = 0 then
      begin
        MessageDlg(Format('Codul "%s" nu a fost gasit in catalogul SCOP (Triomac).', [GoodsCode]),
          mtWarning, [mbOK], 0);
        Exit;
      end;

      P := Products[0];
      if P.TotalStock > 0 then
      begin
        StatusText := Format('In stoc: %s buc.', [P.StockText]);
        StatusClass := 'product-available';
      end
      else
      begin
        StatusText := 'Lipsa in stoc';
        StatusClass := 'product-not-available';
      end;
      if P.Price > 0 then
      begin
        PriceText := Format('%s %s', [FormatFloat('0.00', P.Price), P.Currency]);
        if P.PriceMDL > 0 then
          PriceText := PriceText + Format(' (~%s lei)', [FormatFloat('0.00', P.PriceMDL)]);
        StatusText := StatusText + ' - ' + PriceText;
      end;
      if P.CallForPricing or not P.PriceAvailable then
        StatusText := StatusText + ' - pret la cerere';

      for I := 0 to High(Products) do
      begin
        P := Products[I];
        if Length(Products) > 1 then
          Locations.Add(Format('[%d] %s', [I + 1, P.NameRo]));
        Locations.Add(Format('Stoc: %s', [P.StockText]) +
          Opt((P.TotalStock > 0) and not P.TotalStockExact, ' (pragul SCOP - poate fi mai mult)'));
        if P.Price > 0 then
          Locations.Add(Format('Pret contract: %s %s', [FormatFloat('0.00', P.Price), P.Currency]) +
            Opt(P.PriceMDL > 0, Format(' = %s lei', [FormatFloat('0.00', P.PriceMDL)])));
        if P.Rrp > 0 then
          Locations.Add(Format('Pret recomandat (RRP): %s lei', [FormatFloat('0.00', P.Rrp)]));
        for V in P.Variations do
          Locations.Add(Format('  culoare %s (cod %s): %d%s', [V.Colour, V.Code, V.Stock,
            Opt((V.Stock > 0) and not V.StockExact, '+')]));
        Locations.Add(Format('Cod SCOP: %s; articul: %s', [P.Code, P.Articul]) +
          Opt(P.Brand <> '', '; brand: ' + P.Brand));
        if not SameText(P.Sku, GoodsCode) then
          Locations.Add(Format('Atentie: gasit dupa articul / cod SCOP, sku = %s.', [P.Sku]));
        if P.UpdatedAt <> '' then
          Locations.Add('Actualizat la SCOP: ' + P.UpdatedAt);
      end;
      if Length(Products) > 1 then
        Locations.Insert(0, Format('Atentie: %d produse SCOP au acest sku.', [Length(Products)]));

      Dialog := TfrmATehnoStockResultDlg.Create(Self);
      try
        Dialog.ShowStockInfo(GoodsCode, Products[0].NameRo, StatusText, StatusClass, '', Locations);
        Dialog.Caption := 'Stoc SCOP (Triomac)';
        Dialog.lbLocationsCaption.Caption := 'Detalii stoc:';
        Dialog.ShowModal;
      finally
        Dialog.Free;
      end;
    except
      on E: Exception do
      begin
        Screen.Cursor := crDefault;
        MessageDlg('SCOP API: ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Locations.Free;
    Screen.Cursor := crDefault;
  end;
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
    // banda "Indicativ" (pretul de achizitie) si marjele fata de el
    cxGridForeignDBBandedTableView1.Bands[7].Visible := False;
    TV1_P7_MDL.Visible := False;
    TV1_P7_USD.Visible := False;
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


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
  C_eMail = 'duca.al@gmail.com';
  C_Password = 'Uno2025!@';

type
  TdxSpreadSheetCustomConditionalFormattingRuleAccess = class(TdxSpreadSheetCustomConditionalFormattingRule);

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
    FMDLinkToken: string;
    FSupplierID: Integer;
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
    procedure ParseBallanceQty(url: string);

    procedure OnDMLinkLoginDone(const AResult: TB2BThreadResult);
    procedure OnDMLinkProductDone(const AResult: TB2BThreadResult);

  protected { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure SaveStates; override;
    procedure LoadStates; override;
  public
    function GetLowestPrice7RowIndex(Sender: TcxGridDBBandedTableView): Integer; overload;
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
  System.JSON,
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

procedure TfrmGoodsForeignCodeDlg.GetDMLinkProductStock(GoodsCode: string);
var
  FClient: TB2BDMLinkClient;
  FToken: string;
  T: TB2BThread;
begin
  // 229466
  T := TB2BThread.Create('B2BDMlink.dll');
  T.SetupLogin(C_eMail, C_Password, OnDMLinkLoginDone);
  T.Start;
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

procedure TfrmGoodsForeignCodeDlg.OnDMLinkLoginDone(const AResult: TB2BThreadResult);
var
  T: TB2BThread;
begin
  if AResult.Success then
  begin
        // Login succeeded
    FMDLinkToken := AResult.Token;
        // Step 2: Start GetProduct thread immediately
        // ← FIXED: Pass credentials so thread can re-authenticate
    T := TB2BThread.Create('B2BDMlink.dll');
    var s := IBCQueryForeign.FieldByName('GOODS_CODE').AsString;

    T.SetupGetProduct(s, C_eMail, C_Password, OnDMLinkProductDone);
    T.Start;
  end
  else
  begin
        // Login failed - stop here
    ShowMessage('Login failed: ' + AResult.ErrorMsg);
  end;
end;

procedure TfrmGoodsForeignCodeDlg.OnDMLinkProductDone(const AResult: TB2BThreadResult);
var
  P: TB2BProductInfo;
begin
  if AResult.Success then
  begin
        // Product found
    P := AResult.ProductInfo;
    ShowMessage(Format('Product: %s'#13#10'Price: %.2f$'#13#10'Stock: %d', [string(P.Name), P.NPrice, P.Stock]));
  end
  else
  begin
        // Product not found or error
    ShowMessage('Error: ' + AResult.ErrorMsg);
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
begin

  // Creare client cu credențiale
  APIClient := TSCOPAPIClient.Create('marketing@fantastic.md', 'Gama654!!');
  try
    // Login automat la prima cerere
    if APIClient.GetProductInfoBySKU(GoodsCode, ProductInfo) then
    begin
      ShowMessage(Format('Produs: %s' + #13#10 + 'Preț: %.2f' + #13#10 + 'Stoc: %d' + #13#10,
//        'Disponibil: %s',
        [ProductInfo.Name, ProductInfo.Price, ProductInfo.StockQuantity]));
    end;

    // Sau după slug
    if APIClient.GetProductInfoBySlug('slug-produs', ProductInfo) then
    begin
      // Procesare date
    end;
  finally
    APIClient.Free;
  end;
end;

procedure TfrmGoodsForeignCodeDlg.GetUltraProductStock(GoodsCode: string);
var
  C: TB2BClientUltra;
  Items: TArray<TUltraProductInfo>;
  I: TUltraProductInfo;
  OK: Boolean;
begin
  // Endpoint = adresa fără ?wsdl (WSDL e pentru generator; aici facem POST direct)
  C := TB2BClientUltra.Create('SimionI', 'yYw3nv', 'https://web1c.it-ultra.com/b2b/ru/ws/b2b.1cws');
  try
    // IMPORTANT: metoda primește UUID-ul produsului (nomenclature UUID)
    OK := C.GetProductStockByUUID('{UUID-PRODUS-AICI}', Items);

    if OK then
      for I in Items do
        Writeln(Format('%s | %s | qty=%.2f showroom=%.2f | price=%.2f %s | char=%s', [I.Code, I.Name, I.Quantity, I.QuantityShowroom,
          I.Price, I.Currency, I.CharacteristicUUID]))
    else
      Writeln('Nu s-au găsit date.');
  finally
    C.Free;
  end;
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


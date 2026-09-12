unit frame40InventarizatiaPereotencaTovaraUnit;
{
  INVENTARIERE - Reevaluare marfuri
  DocTypeID = 1414
  Frame Index = 40
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxStyles,
  cxGraphics, cxDBData, cxSplitter, ExtCtrls, dxBar, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, DBAccess, IBC, cxCalc, cxButtonEdit, cxGridPopupMenu, Data.DB,
  Vcl.Clipbrd, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxImageComboBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, System.ImageList, Vcl.ImgList, cxImageList,
  cxGridCustomPopupMenu, MemDS, cxClasses, frmContentGoodsEditorDialog,
  cxPropertiesStore, cxDBLookupComboBox, dxUIAClasses;

type
  TcxGridTableControllerAccess = class(TcxGridTableController);

  Tframe40InventarizatiaPereotencaTovara = class(TSWNBaseFrame)
    dxBarManager: TdxBarManager;
    dxBarManagerBar2: TdxBar;
    bbAddGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    cxGridDoc: TcxGrid;
    cxGridDocTable: TcxGridDBTableView;
    cxGridDoc_DOCID: TcxGridDBColumn;
    cxGridDoc_DATA: TcxGridDBColumn;
    cxGridDoc_DTNAME: TcxGridDBColumn;
    cxGridDoc_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    cxGridPrices: TcxGrid;
    cxGridPricesTable: TcxGridDBTableView;
    cxGridPrices_GOODSID: TcxGridDBColumn;
    cxGridPrices_IMG: TcxGridDBColumn;
    cxGridPrices_GOODS_NAME: TcxGridDBColumn;
    cxGridPrices_PRICE5: TcxGridDBColumn;
    cxGridPrices_PRICE4: TcxGridDBColumn;
    cxGridPrices_CURRENCY3_TITLE: TcxGridDBColumn;
    cxGridPricesLevel: TcxGridLevel;
    dxBarDockControl: TdxBarDockControl;
    bbImportGoods: TdxBarButton;
    IBCTrGPUpdate: TIBCTransaction;
    cxGridPrices_PRICE0: TcxGridDBColumn;
    cxGridPrices_MODIFIED_BY_NAME: TcxGridDBColumn;
    bbImportGoodsGroup: TdxBarButton;
    bbSubTools: TdxBarSubItem;
    bbSetupCustomPriceColumn: TdxBarButton;
    bbImportFromFile: TdxBarButton;
    cxGridPrices_FLG_PRICE_FORCED: TcxGridDBColumn;
    bbSubGoodsFlags: TdxBarSubItem;
    bbSetAllFlagForced: TdxBarButton;
    bbClearAllFlgForced: TdxBarButton;
    cxGridDoc_DT: TcxGridDBColumn;
    cxGridDoc_FLG_CLOSED: TcxGridDBColumn;
    cxGridPrices_PRICE6: TcxGridDBColumn;
    cxGridPrices_PRICE7: TcxGridDBColumn;
    cxGridPrices_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridPrices_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridPrices_GOODS_PRICE_ACNT: TcxGridDBColumn;
    cxGridPrices_STOCK_QTY: TcxGridDBColumn;
    cxGridPrices_PRICE_ACNT_LOW_BOUND: TcxGridDBColumn;
    cxGridPrices_PRICE_ACNT_HIGH_BOUND: TcxGridDBColumn;
    cxGridPrices_FLG_NEW: TcxGridDBColumn;
    cxGridPrices_FLG_PROMO: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    bbFlagNewProduct: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    cxGridPopupMenuGoods: TcxGridPopupMenu;
    dxBarPopupMenuGood: TdxBarPopupMenu;
    bbGoodsForeignCode: TdxBarButton;
    bbSendToNGS: TdxBarButton;
    bbDeleteSelectedGoods: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    cxGridPrices_FLG_FORCED_ADDON: TcxGridDBColumn;
    cxImageList1: TcxImageList;
    dxBarButton11: TdxBarButton;
    IBCQueryCurrency: TIBCQuery;
    dsCurrency: TIBCDataSource;
    dxBarButton12: TdxBarButton;
    dxBarButton13: TdxBarButton;
    bbRefreshPrices: TdxBarButton;
    cxGridDoc_CTNAME: TcxGridDBColumn;
    bbSupplierPromo: TdxBarSubItem;
    bbSetSupplierPromo: TdxBarButton;
    bbDelSupplierPromo: TdxBarButton;
    cxGridPrices_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
    dxBarSubItem5: TdxBarSubItem;
    dxBarButton10: TdxBarButton;
    dxBarButton14: TdxBarButton;
    cxGridPrices_SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    dxBarButton9: TdxBarButton;
    cxGridPrices_CURRENCY7_TITLE: TcxGridDBColumn;
    dxBarSubItem6: TdxBarSubItem;
    dxBarButton15: TdxBarButton;
    dxBarButton16: TdxBarButton;
    cxGridPrices_PRICE4_LEI: TcxGridDBColumn;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    dxBarButton17: TdxBarButton;
    cxGridPrices_WEBGOODSNAME_RO: TcxGridDBColumn;
    cxGridPrices_WEBGOODSNAME_RU: TcxGridDBColumn;
    bbEditGoodsDescription: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridPrices_PRICE7_LEI: TcxGridDBColumn;
    cxGridPrices_Margin71: TcxGridDBColumn;
    cxGridPrices_DIFF47: TcxGridDBColumn;
    dxBarSubItem7: TdxBarSubItem;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    cxGridPricesTable_EPP: TcxGridDBColumn;
    IBCQueryGoodsPrice: TIBCQuery;
    IBCDataSourceGoodsPrice: TIBCDataSource;
    IBCQuery1: TIBCQuery;
    dxBarButton20: TdxBarButton;
    cxGridPrices_PRICE5_LEI: TcxGridDBColumn;
    cxGridPrices_PRICE6_LEI: TcxGridDBColumn;
    cxGridPrices_PRICE3: TcxGridDBColumn;
    cxGridPrices_PRICE2: TcxGridDBColumn;
    cxGridPrices_PRICE1: TcxGridDBColumn;
    dxBarSubItem8: TdxBarSubItem;
    bbsetPreorder: TdxBarButton;
    bbCancelPreOrder: TdxBarButton;
    cxGridPricesTable_FLG_PRE_ORDER: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    bbAdjustRRP: TdxBarButton;
    bbSendToContent: TdxBarButton;
    cxGridPrices_Margin61: TcxGridDBColumn;
    dxBarButton21: TdxBarButton;
    cxGridPrices_Margin01: TcxGridDBColumn;
    cxGridPricesTableColumn1: TcxGridDBColumn;
    cxGridPricesTable_HAS_IMAGES: TcxGridDBColumn;
    cxGridDoc_CT: TcxGridDBColumn;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbComitClick(Sender: TObject);
    procedure bbImportGoodsClick(Sender: TObject);
    procedure cxGridDocTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbImportGoodsGroupClick(Sender: TObject);
    procedure cxGridPricesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbSetupCustomPriceColumnClick(Sender: TObject);
    procedure bbImportFromFileClick(Sender: TObject);
    procedure cxGridDocTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbSetAllFlagForcedClick(Sender: TObject);
    procedure bbClearAllFlgForcedClick(Sender: TObject);
    procedure cxGridDoc_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPricesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure IBCQueryGoodsPrice123AfterCancel(DataSet: TDataSet);
    procedure IBCQueryGoodsPrice123AfterDelete(DataSet: TDataSet);
    procedure IBCQueryGoodsPrice123AfterPost(DataSet: TDataSet);
    procedure cxGridPrices_GOODS_NAMEACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridPrices_PRICE1_LEIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridPrices_GOODS_NAMEACNTStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbFlagNewProductClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbSendToNGSClick(Sender: TObject);
    procedure bbDeleteSelectedGoodsClick(Sender: TObject);
    procedure dxBarButton6Click(Sender: TObject);
    procedure dxBarButton11Click(Sender: TObject);
    procedure dxBarButton12Click(Sender: TObject);
    procedure dxBarButton13Click(Sender: TObject);
    procedure bbRefreshPricesClick(Sender: TObject);
    procedure IBCQueryGoodsPrice123BeforePost(DataSet: TDataSet);
    procedure dxBarButton7Click(Sender: TObject);
    procedure bbSetSupplierPromoClick(Sender: TObject);
    procedure bbDelSupplierPromoClick(Sender: TObject);
    procedure dxBarButton10Click(Sender: TObject);
    procedure dxBarButton14Click(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridDocTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton17Click(Sender: TObject);
    procedure bbEditGoodsDescriptionClick(Sender: TObject);
    procedure cxGridPrices_Margin71CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton18Click(Sender: TObject);
    procedure dxBarButton19Click(Sender: TObject);
    procedure dxBarButton20Click(Sender: TObject);
    procedure bbsetPreorderClick(Sender: TObject);
    procedure bbCancelPreOrderClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbAdjustRRPClick(Sender: TObject);
    procedure bbSendToContentClick(Sender: TObject);
    procedure dxBarButton21Click(Sender: TObject);
    procedure cxGridPrices_CURRENCY3_TITLEStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    fCanDelete: Boolean;
    { Private declarations }
    fLastSelectGoodsID: Integer;
    procedure WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenPriceGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure PriceSelectionChanged;
    procedure ShowNewGoodsDialog;
    procedure ShowDeleteGoodsDialog;
    procedure AddNewGoodsDB(const GoodsID, CurrencyID: Integer; const Price0, Price1, Price2, Price3, Price4, Price5, Price6, Price7: Currency);
    function DoActionImportGoodsFromDoc(const SourceDocID: Integer): Boolean;
// TODO: ShowImportFromDocumentDialog
    procedure ShowImportFromDocumentDialog;
//  function DoActionImportGoodsFromDoc(const SourceDocID: Integer): Boolean;
    procedure DoImportGoodsGroup;
    function DoImportGoodsGroupDB(const DocID, GoodsParentID: Integer): Boolean;
// TODO: DoAdjustPriceColumnDB
//// TODO: ShowCustomSetupPriceColumnDialog
////  procedure ShowCustomSetupPriceColumnDialog;
//  function DoAdjustPriceColumnDB(const DocID, SourceColumn, TargetColumn: Integer; const Percent: Double;
//    const MarginValue: Double = 0): Boolean;
    procedure ShowImportGoodsFromFileDialog;
    function SetAllGoodsFlag(const DocID, StateFlag: Integer; const EndDate: TDateTime; const ClearFlag: Boolean = False): Boolean;
    function ClearAllFlgForced(const DocID, StateFlag: Integer): Boolean;
    procedure PrepareGoodsPriceSQL(const NewFirmaID: Integer);
    procedure SetupQtyFields;
    procedure ShowModifyGoodsAcntDialog;
    function GetSelectionIDList: string;
    function SendSelectedGoodsToNPSC(const OperatorID: Integer; const GoodsList: string): Boolean;
    procedure UpdateForcedFlag(Value: Integer);
    procedure ShowGoodsDescriptionsDialog;
    function SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
    procedure ShowCreditRetailDlg;
    procedure SetGoodsFlagEpp(ADocID, AGoodsID, AFlagValue: Integer);
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetGoodsSupplierFlag(DocID, FlagIndex: Integer; FlagValue: Integer);
    procedure SetupSecurityItems; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure WhenBurstGoodsAdd(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer);
  public
    procedure AddGoodsToCreditRetail(ACid: Integer; ACustomerid: Integer);
    procedure ChangeRRPByPercent(Value: Double);
    procedure ChangeRRPByValue(Value: Double);
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure SetFlgAvailableQty(FLG_AVAILABLE_QTY: Integer);
    procedure ImportAllGoodsFromSupplier;
    procedure SetExcludePPFlag(DocID, FlagValue: Integer);
    procedure Set_FLG_COD_D(DocID, FlagValue: Integer);
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst,
  frmInventarizatiaPereotencaTovaraDocDialog, SWNUtils, SWNDBErrors, frmGoods,
  frmDocumentImportBrowserDialog, SWNTypes, SWNValueStorageUnit,
  frmSetupCustomPriceColumnDialog, frmImportGoodsPricesDialog,
  frmForcedPerioudSetupDialog, SWNSecurity,
  frmПриходТовараПоНакладнымChangeGoodsAcntDialog, SWNSecurityFlags,
  frmGoodsSendGoodsToNPSCDialog, SWNCommonDialogs, frmCurrencyDlg, cxStorage,
  frmSelectPercentValueUnit, frmSendGoodsToPackage, frmCrediteRetailUnit, frame78PriceListUnit;

{$R *.dfm}

procedure Tframe40InventarizatiaPereotencaTovara.AddGoodsToCreditRetail(ACid: Integer; ACustomerid: Integer);
var
  Goods_Code: string;
  i: Integer;
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.Transaction := IBCTrGPUpdate;
    if not q.Transaction.Active then
      q.Transaction.StartTransaction;
    q.sql.text := 'insert into tcredite_goods(cid, goods_code, customerid) values (:cid, :goods_code, :customerid)';
    q.Prepare;

    IBCQueryGoodsPrice.DisableControls;
    for i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
      Goods_Code := cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPrices_SUPPLIER_GOODS_CODE.index];
      with IBCQueryGoodsPrice do begin
        if Locate('GOODS_CODE;CUSTOMERID', VarArrayOf([Goods_Code, ACustomerid]), []) then begin
          try
            q.ParamByName('goods_code').AsString := Goods_Code;
            q.ParamByName('cid').AsInteger := ACid;
            q.ParamByName('customerid').AsInteger := ACustomerid;
            q.Execute;
            if q.Transaction.Active then
              q.Transaction.Commit;
          except
            on E: Exception do begin
              q.Transaction.Rollback;
              raise;
            end;
          end;
        end;
      end;
    end;
    IBCQueryGoodsPrice.EnableControls;
  finally
    q.Free;
  end;
end;

{ Tframe40InventarizatiaPereotencaTovara }

procedure Tframe40InventarizatiaPereotencaTovara.AddNewGoodsDB(const GoodsID, CurrencyID: Integer; const Price0, Price1, Price2, Price3, Price4, Price5, Price6, Price7: Currency);
begin
  // verificam daca transactia este deschisa
  if IBCQueryGoodsPrice.UpdateTransaction.Active then begin
    if IBCQueryGoodsPrice.State in dsEditModes then
      IBCQueryGoodsPrice.Post;
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
  end;

  IBCQueryGoodsPrice.UpdateTransaction.StartTransaction;
  try
    IBCQueryGoodsPrice.Append;
    IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger := GoodsID;
    IBCQueryGoodsPrice.FieldByName('CURRENCYID').AsInteger := CurrencyID;
    IBCQueryGoodsPrice.FieldByName('PRICE0').AsCurrency := Price0;
    IBCQueryGoodsPrice.FieldByName('PRICE1').AsCurrency := Price1;
    IBCQueryGoodsPrice.FieldByName('PRICE2').AsCurrency := Price2;
    IBCQueryGoodsPrice.FieldByName('PRICE3').AsCurrency := Price3;
    IBCQueryGoodsPrice.FieldByName('PRICE4').AsCurrency := Price4;
    IBCQueryGoodsPrice.FieldByName('PRICE5').AsCurrency := Price5;
    IBCQueryGoodsPrice.FieldByName('PRICE6').AsCurrency := Price6;
    IBCQueryGoodsPrice.FieldByName('PRICE7').AsCurrency := Price7;
    IBCQueryGoodsPrice.FieldByName('MODIFIED_BY').AsInteger := dmDB.CurrentUserID;

    IBCQueryGoodsPrice.Post;
    // DataSet-ul singur face comit dupa Post
    if IBCQueryGoodsPrice.UpdateTransaction.Active then
      IBCQueryGoodsPrice.UpdateTransaction.Commit;
  except
    on E: Exception do begin
      if IBCQueryGoodsPrice.State in dsEditModes then
        IBCQueryGoodsPrice.Cancel;
      if IBCQueryGoodsPrice.UpdateTransaction.Active then
        IBCQueryGoodsPrice.UpdateTransaction.Rollback;
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbAddGoodsClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;
  ShowNewGoodsDialog;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbAdjustRRPClick(Sender: TObject);
var
  d: TfrmSelectPercentValueDlg;
begin
  inherited;
  d := TfrmSelectPercentValueDlg.Create(Self, dmDB.IBCConnection);
  if d.ShowModal = mrOk then begin
    if d.ValueType = 0 then begin
      // Amount
      ChangeRRPByValue(d.Value);
      dmdb.ExecuteQuery('insert into tlog_docs_reevaluare (docid, amount, percent) values (:docid, :amount, :percent)', [d.Value, 0]);
    end;
    if d.ValueType = 1 then begin
      // Percent
      ChangeRRPByPercent(d.Value);
      dmdb.ExecuteQuery('insert into tlog_docs_reevaluare (docid, amount, percent) values (:docid, :amount, :percent)', [0, d.Value]);
    end;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbCancelPreOrderClick(Sender: TObject);
begin
  inherited;
  SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 6, 0);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbClearAllFlgForcedClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  UpdateForcedFlag(0);
//
//    IBCQueryGoodsPrice.DisableControls;
//    IBCQueryGoodsPrice.First;
//    while not IBCQueryGoodsPrice.Eof do
//    begin
//        IBCQueryGoodsPrice.Edit;
//        IBCQueryGoodsPrice.FieldByName('FLG_PRICE_FORCED').AsInteger := 0;
//        IBCQueryGoodsPrice.Post;
//        IBCQueryGoodsPrice.Next;
//    end;
//    IBCQueryGoodsPrice.EnableControls;
//    if ShowAskDialog('Forced Flag', 'Sterge "Forced" Flag pentru toate produsele?') = mrYes then
//    begin
//        if ClearAllFlgForced(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 3) then
//            IBCQueryGoodsPrice.Refresh;
//    end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbCloseDocClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('execute procedure close_reevaluare(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryDocs.Refresh;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbComitClick(Sender: TObject);
begin
  // post changes
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;
  // commit
  if IBCQueryGoodsPrice.UpdateTransaction.Active then
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbDeleteGoodsClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;
  ShowDeleteGoodsDialog;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbDelSupplierPromoClick(Sender: TObject);
begin
  SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 2, 0);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbImportFromFileClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  ShowImportGoodsFromFileDialog;

  bbRefreshPricesClick(Sender);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbImportGoodsClick(Sender: TObject);
begin
  SWNUtils.ShowErrorDialog('Import produse din document!', 'Optiunea data este deconectata!', 'Contactati administratorul!');
//
//  if IBCQueryGoodsPrice.State in dsEditModes then
//    IBCQueryGoodsPrice.Post;
//  ShowImportFromDocumentDialog;
//
//  bbRefreshPricesClick(Sender);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbImportGoodsGroupClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;
  DoImportGoodsGroup;

  bbRefreshPricesClick(Sender);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbOpenDocClick(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('update tdb_docs set flags = set_flg_value(flags, 10, 0) where docid = :DOCID', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryDocs.Refresh;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbRefreshPricesClick(Sender: TObject);
begin
  inherited;
//  dmDB.ExecuteQuery('EXECUTE PROCEDURE REFRESH_PEREOTENKA(:DOCID)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbSendToNGSClick(Sender: TObject);
var
  dialog: TfrmGoodsSendGoodsToNPSCDlg;
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  dialog := TfrmGoodsSendGoodsToNPSCDlg.Create(Self);
  try
    dialog.SetGoodsQty(cxGridPricesTable.Controller.SelectedRecordCount);
    if dialog.ShowModal = mrOk then begin
      if SendSelectedGoodsToNPSC(dialog.GetOperatorID, GetSelectionIDList) then
        ShowInfoDialog('Transmitere spre inregistrare', 'Gata!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbSetAllFlagForcedClick(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  UpdateForcedFlag(1);

end;

procedure Tframe40InventarizatiaPereotencaTovara.bbSetSupplierPromoClick(Sender: TObject);
begin
  SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 2, 1);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbSetupCustomPriceColumnClick(Sender: TObject);
begin
  SWNUtils.ShowErrorDialog('SWN', 'Depricated!');
//  if IBCQueryGoodsPrice.State in dsEditModes then
//    IBCQueryGoodsPrice.Post;
//  ShowCustomSetupPriceColumnDialog;
end;

function Tframe40InventarizatiaPereotencaTovara.ClearAllFlgForced(const DocID, StateFlag: Integer): Boolean;
begin
  if SetAllGoodsFlag(DocID, StateFlag, 0, True) = True then begin
    Result := True;
    ShowMessage('Finisat cu succes!')
  end
  else begin
    Result := False;
    MessageDlg('In timpul executarii au aparut probleme.', mtError, [mbOK], 0);
  end;

end;

procedure Tframe40InventarizatiaPereotencaTovara.CreateNewRecord;
var
  dialog: TfrmInventarizatiaPereotencaTovaraDocDlg;
begin
  dialog := TfrmInventarizatiaPereotencaTovaraDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    if dialog.ShowModal = mrOk then begin
      DocumentSelectionChanged;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridDocTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridDocTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridDoc_FLG_CLOSED.index]) then begin
    if (AViewInfo.GridRecord.Values[cxGridDoc_FLG_CLOSED.index] = 1) then begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
    end;
  end;

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridDocTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(self, cxGridDocTable, Key, Shift);
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridDocTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridDoc_FLG_CLOSED.Index] = 1 then
    AStyle := dmAdditions.cxStyle_TextGrayStrike;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPricesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPricesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGridPricesTable, Key, Shift);
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowGoodsDescriptionsDialog;
var
  dialog: TfrmContentGoodsEditorDlg;
begin
  dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
  try
    if dialog.ShowModal = mrOk then
      IBCQueryGoodsPrice.RefreshRecord;
//         IBCQueryMissGoods.RefreshRecord; // can not refresh because record can be missing due all info is present
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPrices_CURRENCY3_TITLEStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
//  if not VarIsNull(ARecord.Values[cxGridPrices_CURRENCY3_TITLE.Index]) then
//    if (ARecord.Values[cxGridPrices_CURRENCY3_TITLE.Index] = 'MDL') then
//      AStyle := dmAdditions.cxStyle_TextBoldRed
//    else
//      AStyle := dmAdditions.cxStyle_TextBoldGreen;

end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPrices_GOODS_NAMEACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowModifyGoodsAcntDialog;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPrices_GOODS_NAMEACNTStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridPrices_GOODS_ACNT_ID.index]) then begin
    if (ARecord.Values[cxGridPrices_GOODS_ACNT_ID.index] = -1) then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPrices_PRICE1_LEIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
//var
//    n: Currency;
begin
//    if not VarIsNull(ARecord.Values[cxGridPrices_PRICE_ACNT_LOW_BOUND.index]) and not VarIsNull(ARecord.Values
//        [cxGridPrices_PRICE_ACNT_HIGH_BOUND.index]) and not VarIsNull(ARecord.Values[cxGridPrices_PRICE4_LEI.index])
//        then
//    begin
//        n := ARecord.Values[cxGridPrices_PRICE4_LEI.index];
//        if (n < ARecord.Values[cxGridPrices_PRICE_ACNT_LOW_BOUND.index]) or (n > ARecord.Values[cxGridPrices_PRICE_ACNT_HIGH_BOUND.index])
//            then
//            AStyle := dmAdditions.cxStyle_TextColorRed;
//    end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridDoc_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDoc_DATA.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDoc_DATA.index]);
end;

procedure Tframe40InventarizatiaPereotencaTovara.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea: %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then begin
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryDocs.Delete;
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    except
      on E: Exception do begin
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

function Tframe40InventarizatiaPereotencaTovara.DoActionImportGoodsFromDoc(const SourceDocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

// verificam daca transactia este deschisa
  if IBCQueryGoodsPrice.UpdateTransaction.Active then begin
    if IBCQueryGoodsPrice.State in dsEditModes then
      IBCQueryGoodsPrice.Post;
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
  end;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;

    IBCQueryGoodsPrice.UpdateTransaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_PEREOTENCA_IMPORT_GOODS(:DOCID,:SOURCE_DOCID)';
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
      Query.ExecSQL;
      IBCQueryGoodsPrice.UpdateTransaction.Commit;
      Result := True;
    except
      on E: Exception do begin
        IBCQueryGoodsPrice.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;


//
//function Tframe40InventarizatiaPereotencaTovara.DoAdjustPriceColumnDB(const DocID, SourceColumn, TargetColumn:
//Integer; const Percent: Double; const MarginValue: Double = 0): Boolean;
//var
//Query: TIBCQuery;
//begin
//Result := False;
//Query := TIBCQuery.Create(Self);
//try
//  Query.AutoCommit := False;
//  Query.Connection := dmDB.IBCConnection;
//  Query.Transaction := dmDB.IBCTrDefaultUpdate;
//  Query.SQL.Text :=
//    'EXECUTE PROCEDURE SP_PEREOTENCA_CALC_COLUMN(:DocID, :Column1, :Column2, :Percent, :margin_value)';
//  Query.ParamByName('DocID').AsInteger := DocID;
//  Query.ParamByName('Column1').AsInteger := SourceColumn;
//  Query.ParamByName('Column2').AsInteger := TargetColumn;
//  Query.ParamByName('Percent').AsFloat := Percent;
//  Query.ParamByName('Margin_value').AsFloat := MarginValue;
//
//  try
//    Query.Transaction.StartTransaction;
//    Query.ExecSQL;
//    Query.Transaction.Commit;
//    Result := True;
//  except
//    on E: Exception do
//    begin
//      if Query.Transaction.Active then
//        Query.Transaction.Rollback;
//      if not ProcessSWNError(E) then
//        raise;
//    end;
//  end;
//
//finally
//  Query.Free;
//end;
//end;

procedure Tframe40InventarizatiaPereotencaTovara.DocumentSelectionChanged;
var
  fNew, fModify, fEditPrices: Boolean;
begin
  fNew := True;
  fModify := False;
  fEditPrices := False;

  if cxGridDocTable.DataController.RecNo > 0 then begin
    SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari);
    fModify := (dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID) or SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari);
    fEditPrices := (dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID) or SWNSecurityManager.UserIsPartOfGroup(cUserGroup_ADM_Aprovizionari);
  end;
  // doc buttons
  ButtonStateChanged(fbtADD, fNew);
  ButtonStateChanged(fbtMODIFY, fModify);
  ButtonStateChanged(fbtDELETE, fModify);
  cxGridPrices_PRICE0.Options.Editing := fEditPrices;
  cxGridPrices_PRICE4.Options.Editing := fEditPrices;
  cxGridPrices_PRICE5.Options.Editing := fEditPrices;
  cxGridPrices_PRICE6.Options.Editing := fEditPrices;
  cxGridPrices_PRICE7.Options.Editing := fEditPrices;
  cxGridPrices_SUPPLIER_GOODS_CODE.Options.Editing := fEditPrices;
  cxGridPrices_FLG_PRICE_FORCED.Options.Editing := fEditPrices;

  bbOpenDoc.Enabled := fModify;

  bbSubGoodsFlags.Enabled := fEditPrices;

  if fEditPrices then
    cxGridPrices_GOODS_NAMEACNT.Options.ShowEditButtons := isebDefault
  else
    cxGridPrices_GOODS_NAMEACNT.Options.ShowEditButtons := isebNever;

  PriceSelectionChanged;
end;

procedure Tframe40InventarizatiaPereotencaTovara.DoFrameHide;
begin
  // inchidem datele interne
  IBCQueryGoods.Active := False;
  IBCQueryGoodsPrice.Active := False;

  // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

  // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridDocTable.OnFocusedRecordChanged := nil;
  cxGridPricesTable.OnFocusedRecordChanged := nil;

  // 2. De deconectat sursele de date de la griduri
  cxGridDocTable.DataController.DataSource := nil;
  IBCQueryCurrency.Close;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetupSecurityItems;
begin
  fCanDelete := True;
  // sterge pozitia
//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_ПТ_Удалить) then
  bbDeleteGoods.Enabled := fCanDelete;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной) then begin
    cxGridPrices_GOODS_NAMEACNT.Options.Editing := False;
    TcxButtonEditProperties(cxGridPrices_GOODS_NAMEACNT.Properties).Buttons.Clear;
  end;

  // Corespondenta produsului in alte firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

    // Actualizare preturi
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INVENTARIERE_RB_Actualizare_preturi) then
    bbRefreshPrices.Visible := ivNever;

//    // Sterge document
//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_ПТ_Удалить) then
//    fCanDelete := False;

end;

procedure Tframe40InventarizatiaPereotencaTovara.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  // schimba VIEW de extragere a datelor conform firmei curente
  PrepareGoodsPriceSQL(FrameDataFilterInfo.FirmaID);

  // 1. Legam grid-urile de datasource-sele
  cxGridDocTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

  // 2. Selection handlers
  cxGridDocTable.OnFocusedRecordChanged := WhenDocumentGridFocusedRecordChanged;
  cxGridPricesTable.OnFocusedRecordChanged := WhenPriceGridFocusedRecordChanged;

  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  // deschidem datele interne
  IBCQueryGoodsPrice.MasterSource := dmDB.IBCDataSourceDocs;
  IBCQueryGoodsPrice.Active := True;
  IBCQueryGoods.Active := True;

  // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe40InventarizatiaPereotencaTovara.DoImportGoodsGroup;
var
  dialog: TfrmGoodsBrowser;
begin
  if ShowAskDialog('Import produse din mapa', 'Doriti sa importati produsele din mapa?', 'Vor fi importate produsele din toate dub-mapele ') <> mrYes then
    Exit;

  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(0, True, 0, 'Selectati mapa pentru import') then begin
      if dialog.GoodsIsFolder then begin
        // close edit
        if IBCQueryGoodsPrice.State in dsEditModes then begin
          IBCQueryGoodsPrice.Post;
          IBCQueryGoodsPrice.UpdateTransaction.Commit;
        end;

        if DoImportGoodsGroupDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.GoodsID) then begin
          IBCQueryGoodsPrice.Refresh;
        end;
      end
      else
        ShowErrorDialog('Eroare!', 'Alegeti o mapa !!!');
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe40InventarizatiaPereotencaTovara.DoImportGoodsGroupDB(const DocID, GoodsParentID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_PEREOTENCA_IMPORT_GOODS2(:FirmaID, :DocID, :pID)';
    Query.ParamByName('FirmaID').AsInteger := dmDB.CurrentFirma;
    Query.ParamByName('DocID').AsInteger := DocID;
    Query.ParamByName('pID').AsInteger := GoodsParentID;

    try
      Query.Transaction.StartTransaction;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton10Click(Sender: TObject);
begin
//  if IBCQueryGoodsPrice.State in dsEditModes then
//    IBCQueryGoodsPrice.Post;
//
//  SetExcludePPFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 1);
//  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton11Click(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger, IBCQueryGoodsPrice.FieldByName('GOODS_TITLE').AsString);
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton12Click(Sender: TObject);
var
  currEditor: TfrmCurrencyDialog;
  i: Integer;
  GoodsID: Integer;
begin
  currEditor := TfrmCurrencyDialog.Create(dmDB.IBCConnection);
  try
    currEditor.readonly := not SWNSecurityManager.LoggedUser.IsInAdminGroup;
    if currEditor.ShowModal = mrOk then begin
      IBCQueryGoodsPrice.DisableControls;
      for i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
        GoodsID := cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPrices_GOODSID.index];

        with IBCQueryGoodsPrice do begin
          if Locate('GOODSID', GoodsID, []) then begin
            Edit;
            FieldByName('Currency4ID').AsInteger := currEditor.IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
            FieldByName('Currency5ID').AsInteger := currEditor.IBCQueryCurrency.FieldByName('CURRENCYID').AsInteger;
            Post;
          end;
        end;
      end;
      IBCQueryGoodsPrice.EnableControls;
    end;
  finally
    currEditor.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton13Click(Sender: TObject);
begin
  ImportAllGoodsFromSupplier;
  bbRefreshPricesClick(Sender);
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton14Click(Sender: TObject);
begin
//  if IBCQueryGoodsPrice.State in dsEditModes then
//    IBCQueryGoodsPrice.Post;
//
//  SetExcludePPFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 0);
//  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton17Click(Sender: TObject);
var
  CurrentyID: string;
begin
  if (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0) and (InputQuery('Introduceti codul valutei', 'Cod valuta', CurrentyID)) then begin
    dmDB.ExecuteQuery('UPDATE TDB_GOODS_PRICE SET CURRENCY4ID=:CURRENCYID, CURRENCY7ID=:CURRENCYID WHERE DOCID = :DOCID', [TCurrencyField, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    IBCQueryGoodsPrice.Refresh;
  end
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton18Click(Sender: TObject);
begin
  inherited;
  if (cxGridPricesTable.Controller.SelectedRowCount) > 1 then begin
    for var i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
        cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPricesTable_EPP.index] := 1;
        SetGoodsFlagEpp(
          dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,
          cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].Index, cxGridPrices_GOODSID.index],
          1);
    end
  end
  else
    SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 4, 1);
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton19Click(Sender: TObject);
begin
  inherited;
  if (cxGridPricesTable.Controller.SelectedRowCount) > 1 then begin
    for var i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
        cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPricesTable_EPP.index] := 0;
        SetGoodsFlagEpp(
          dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,
          cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].Index, cxGridPrices_GOODSID.index],
          0);

    end
  end
  else
    SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 4, 0);
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  // setam flg_in_price pentru toate produsele din reevaluare
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;
  UpdateForcedFlag(1);

  // activam trigerul pentru recalcul - inchidem documentul
  dmDB.ExecuteQuery('execute procedure close_reevaluare(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  // deschidem documentul pentru a scoate FLG_IN_Price
  dmDB.ExecuteQuery('update tdb_docs set flags = set_flg_value(flags, 10, 0) where docid = :DOCID', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  // setam flg_in_price = 0
  UpdateForcedFlag(0);
  // Inchidem documentul
  dmDB.ExecuteQuery('execute procedure close_reevaluare(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmDB.IBCQueryDocs.RefreshRecord;
  cxGridPricesTable.DataController.Refresh;
//  IBCQueryGoodsPrice.Refresh;
//
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbsetPreorderClick(Sender: TObject);
begin
  inherited;
  SetGoodsSupplierFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 6, 1);
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbEditGoodsDescriptionClick(Sender: TObject);
begin
  ShowGoodsDescriptionsDialog;
end;

procedure Tframe40InventarizatiaPereotencaTovara.cxGridPrices_Margin71CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPrices_Margin71.index]) then begin
    if AViewInfo.GridRecord.Values[cxGridPrices_Margin71.index] <= 1 then
      ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbFlagNewProductClick(Sender: TObject);
var
  dialog: TfrmForcedPerioudSetupDlg;
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  dialog := TfrmForcedPerioudSetupDlg.Create(Self);
  try
    dialog.SetTitles('Produs nou', 'Perioada de actiune a "FlagForced"');
    if dialog.ShowModal = mrOk then begin
      if SetAllGoodsFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 2, dialog.EndDate) then
        IBCQueryGoodsPrice.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbSendToContentClick(Sender: TObject);
var
  dialog: TfrmSendGoodsToPackageDlg;
begin
  dialog := TfrmSendGoodsToPackageDlg.Create(Self);
  try
    dialog.SetGoodsQty(cxGridPricesTable.Controller.SelectedRecordCount);
    if dialog.ShowModal = mrOk then begin
      if SendSelectedGoodsToPackage(dialog.GetOperatorID, GetSelectionIDList) then
        ShowInfoDialog('Transmis cu succes', 'Done!');
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe40InventarizatiaPereotencaTovara.SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SEND_GOODS_TO_PACKAGE(:opID, :gList)';
    Query.ParamByName('opID').AsInteger := OperatorID;
    Query.ParamByName('gList').AsString := GoodsList;
    Query.Transaction.StartTransaction;
    try
      if not dmDB.IBCTrDefaultUpdate.Active then
        dmDB.IBCTrDefaultUpdate.StartTransaction;

      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
    except
      on e: Exception do begin
        Query.Transaction.Rollback;
        raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ChangeRRPByPercent(Value: Double);
var
  Query: TIBCSQL;
begin
  { TODO : De rescris print-ro procedura in Firebird }
  Query := TIBCSQL.Create(nil);
  try
    Query.Transaction := dmdb.IBCTrDefaultUpdate;
    Query.AutoCommit := True;

    if not Query.Transaction.Active then
      Query.Transaction.StartTransaction;

    query.SQL.Text := 'EXECUTE PROCEDURE ADJUST_RRP_REEVALUATION(:DOCID, :PERCENT)';
    Query.ParamByName('DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ParamByName('PERCENT').AsFloat := Value;
    query.Prepare;
    query.Execute;

    if Query.Transaction.Active then
      Query.Transaction.Commit;
  finally
    Query.Free;
  end;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ChangeRRPByValue(Value: Double);
begin
  IBCQueryGoodsPrice.DisableControls;
  IBCQueryGoodsPrice.First;

  while not IBCQueryGoodsPrice.Eof do begin
    if IBCQueryGoodsPrice.FieldByName('FLG_EPP').AsInteger = 1 then
    begin
      IBCQueryGoodsPrice.Edit;
      IBCQueryGoodsPrice.FieldByName('PRICE3').AsFloat := IBCQueryGoodsPrice.FieldByName('PRICE3').AsFloat + Value;
      IBCQueryGoodsPrice.Post;
    end;
    IBCQueryGoodsPrice.Next;
  end;

  IBCQueryGoodsPrice.EnableControls;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton20Click(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('EXECUTE PROCEDURE ACTUALIZARE_REEVALUARE(:DOCID)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton21Click(Sender: TObject);
begin
//  ShowCreditRetailDlg;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowCreditRetailDlg;
var
  cid: Integer;
  d: TfrmCrediteRetailDlg;
begin
  d := TfrmCrediteRetailDlg.Create(Self, dmDB.IBCConnection);
  try
    if (d.ShowModal = mrOk) then begin
      cid := d.cid;
      AddGoodsToCreditRetail(cid, IBCQueryGoodsPrice.FieldByName('CUSTOMERID').AsInteger);
    end;

  finally
    d.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton2Click(Sender: TObject);
var
  dialog: TfrmForcedPerioudSetupDlg;
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  dialog := TfrmForcedPerioudSetupDlg.Create(Self);
  try
    dialog.SetTitles('Produse promotionale', 'Perioada de actiune a produselor "Promo"');
    if dialog.ShowModal = mrOk then begin
      if SetAllGoodsFlag(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 1, dialog.EndDate) then
        IBCQueryGoodsPrice.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton3Click(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  if ShowAskDialog('Produs nou', 'Sterge mentiunea "Nou" pentru toate produse?') = mrYes then begin
    if ClearAllFlgForced(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 2) then
      IBCQueryGoodsPrice.Refresh;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton4Click(Sender: TObject);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Post;

  if ShowAskDialog('Produse promotionale', 'Sterge "Promo" pentru toate produsele?') = mrYes then begin
    if ClearAllFlgForced(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 1) then
      IBCQueryGoodsPrice.Refresh;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.bbDeleteSelectedGoodsClick(Sender: TObject);
begin
  inherited;
  if ShowAskDialog('Inventariere', 'Sterge toate inregistrarile ?') = mrYes then begin
    dmDB.ExecuteQuery('delete from tdb_goods_price where docid=:docid', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    IBCQueryGoodsPrice.Refresh;
  end;

end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton6Click(Sender: TObject);
begin
  inherited;
  TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger, IBCQueryGoodsPrice.FieldByName('GOODS_TITLE').AsString);
end;

procedure Tframe40InventarizatiaPereotencaTovara.dxBarButton7Click(Sender: TObject);
begin
  SetFlgAvailableQty(TdxBarButton(Sender).Tag);
end;

function Tframe40InventarizatiaPereotencaTovara.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridPricesTable.Site.Focused then begin
    // context from goods: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := IBCQueryGoodsPrice.FieldByName('GOODS_TITLE').AsString;
  end
  else if cxGridDocTable.Site.Focused then begin
    // context from Docs
    if cxGridDoc_DATA.Focused then begin
      // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe40InventarizatiaPereotencaTovara.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe40InventarizatiaPereotencaTovara.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe40InventarizatiaPereotencaTovara.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtADD, fbtMODIFY, fbtDELETE, fbtREFRESH];
//  if fCanDelete then
//    Result := Result + [fbtDELETE];
end;

function Tframe40InventarizatiaPereotencaTovara.GetSelectionIDList: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to cxGridPricesTable.Controller.SelectedRecordCount - 1 do begin
    if Result <> '' then
      Result := Result + ',';
    Result := Result + IntToStr(cxGridPricesTable.Controller.SelectedRecords[i].Values[cxGridPrices_GOODSID.index]);
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.IBCQueryGoodsPrice123AfterCancel(DataSet: TDataSet);
begin
  if IBCQueryGoodsPrice.State in dsEditModes then
    IBCQueryGoodsPrice.Cancel;
  if IBCQueryGoodsPrice.UpdateTransaction.Active then
    IBCQueryGoodsPrice.UpdateTransaction.Rollback;
end;

procedure Tframe40InventarizatiaPereotencaTovara.IBCQueryGoodsPrice123AfterDelete(DataSet: TDataSet);
begin
  if IBCQueryGoodsPrice.UpdateTransaction.Active then
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
end;

procedure Tframe40InventarizatiaPereotencaTovara.IBCQueryGoodsPrice123AfterPost(DataSet: TDataSet);
begin
  if IBCQueryGoodsPrice.UpdateTransaction.Active then
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
end;

procedure Tframe40InventarizatiaPereotencaTovara.IBCQueryGoodsPrice123BeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('CURRENCYID').OldValue <> DataSet.FieldByName('CURRENCYID').NewValue then begin
    DataSet.FieldByName('PRICE0').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE0').NewValue);

    DataSet.FieldByName('PRICE1').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE1').NewValue);

    DataSet.FieldByName('PRICE2').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE2').NewValue);

    DataSet.FieldByName('PRICE3').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE3').NewValue);

    DataSet.FieldByName('PRICE4').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE4').NewValue);

    DataSet.FieldByName('PRICE5').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE5').NewValue);

    DataSet.FieldByName('PRICE6').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE6').NewValue);

    DataSet.FieldByName('PRICE7').AsFloat := dmDB.ConvertAmountByCurrency(DataSet.FieldByName('CURRENCYID').OldValue, DataSet.FieldByName('CURRENCYID').NewValue, DataSet.FieldByName('PRICE7').NewValue);
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ImportAllGoodsFromSupplier;
var
  CustomerID: Integer;
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    if not IBCTrGPUpdate.Active then
      IBCTrGPUpdate.StartTransaction;

    CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    if CustomerID > 0 then begin
      Query.Transaction := IBCTrGPUpdate;
      Query.SQL.Clear;
      Query.SQL.Text := 'execute procedure ImportAllGoodsFromSupplier (:SupplierID, :DOCID)';
      Query.ParamByName('supplierid').AsInteger := CustomerID;
      Query.ParamByName('docid').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      try
        Query.ExecSQL;
        if IBCTrGPUpdate.Active then
          IBCTrGPUpdate.Commit;
      except
        on E: Exception do begin
          ShowMessage(e.Message);
          raise;
        end
      end;
    end;
  finally
    Query.Free;
    IBCQueryGoodsPrice.Refresh;
  end;

end;

function Tframe40InventarizatiaPereotencaTovara.InitFrameID: Integer;
begin
  Result := 40; // INVENTARIERE - Reevaluare marfa
  fLastSelectGoodsID := -1;
  SetupQtyFields;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ModifyRecord;
var
  dialog: TfrmInventarizatiaPereotencaTovaraDocDlg;
begin
  dialog := TfrmInventarizatiaPereotencaTovaraDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    if dialog.ShowModal = mrOk then
      ;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.PrepareGoodsPriceSQL(const NewFirmaID: Integer);
var
  Firma: Integer;
  S: string;
begin
  IBCQueryGoodsPrice.Close;
  IBCQueryCurrency.Open;

  if (UpperCase(dmDB.IBCConnection.Database) = '192.168.106.254/3050:SW') then begin
    // pentru baza de date
    Firma := 5213;
    if (NewFirmaID = 123025) then
      Firma := 123025;
    S := Format('VW_TDB_GOODS_PRICE%d', [Firma]);

    if (Firma = 5213) then begin
      // change default
      IBCQueryGoodsPrice.SQL.Text := StringReplace(IBCQueryGoodsPrice.SQL.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
      IBCQueryGoodsPrice.SQLInsert.Text := StringReplace(IBCQueryGoodsPrice.SQLInsert.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
      IBCQueryGoodsPrice.SQLUpdate.Text := StringReplace(IBCQueryGoodsPrice.SQLUpdate.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
      IBCQueryGoodsPrice.SQLDelete.Text := StringReplace(IBCQueryGoodsPrice.SQLUpdate.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
      IBCQueryGoodsPrice.SQLRefresh.Text := StringReplace(IBCQueryGoodsPrice.SQLRefresh.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
    end
  end
  else begin
    S := 'VW_TDB_GOODS_PRICE';
    IBCQueryGoodsPrice.SQL.Text := StringReplace(IBCQueryGoodsPrice.SQL.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
    IBCQueryGoodsPrice.SQLInsert.Text := StringReplace(IBCQueryGoodsPrice.SQLInsert.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
    IBCQueryGoodsPrice.SQLUpdate.Text := StringReplace(IBCQueryGoodsPrice.SQLUpdate.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
    IBCQueryGoodsPrice.SQLRefresh.Text := StringReplace(IBCQueryGoodsPrice.SQLRefresh.Text, 'VW_TDB_GOODS_PRICE_XX', S, [rfReplaceAll, rfIgnoreCase]);
  end;

end;

procedure Tframe40InventarizatiaPereotencaTovara.PriceSelectionChanged;
var
  fNew, fImport, fDelete, fGoodsSelected: Boolean;
begin
  fNew := False;
  fImport := False;
  fDelete := False;
  fGoodsSelected := False;

  if cxGridDocTable.DataController.RecNo > 0 then begin
    fNew := dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID;
    fImport := fNew;

    if (cxGridPricesTable.DataController.RecNo > 0) then begin
      fDelete := fNew;
      fGoodsSelected := True;
    end;
  end;
  // price
  bbAddGoods.Enabled := fNew;
  bbDeleteGoods.Enabled := fDelete;
  // tools
  bbSubTools.Enabled := fImport or SWNSecurityManager.IsAdmin;
  bbSetAllFlagForced.Enabled := cxGridPricesTable.DataController.RecordCount > 0;
  bbClearAllFlgForced.Enabled := cxGridPricesTable.DataController.RecordCount > 0;
  bbSendToNGS.Enabled := cxGridPricesTable.Controller.SelectedRecordCount > 0;

  bbGoodsForeignCode.Enabled := fGoodsSelected;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    cxPropertiesStore1.StorageName := Extractfilepath (Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
//    cxPropertiesStore1.RestoreFrom;
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.RefreshData;
begin
  inherited;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    cxPropertiesStore1.StorageName := Extractfilepath (Application.ExeName) + 'swn_' + dmDB.CurrentUserID.ToSTring + '.ini';
//    cxPropertiesStore1.StoreTo(True);

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

function Tframe40InventarizatiaPereotencaTovara.SendSelectedGoodsToNPSC(const OperatorID: Integer; const GoodsList: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_NGS_REQUEST_FROM_APP(:opID,:gList)';
    Query.ParamByName('opID').AsInteger := OperatorID;
    Query.ParamByName('gList').AsString := GoodsList;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe40InventarizatiaPereotencaTovara.SetAllGoodsFlag(const DocID, StateFlag: Integer; const EndDate: TDateTime; const ClearFlag: Boolean): Boolean;
var
  Query: TIBCQuery;
  Firma: Integer;
begin
  Result := False;

  Firma := 5213;
  if dmDB.CurrentFirma = 123025 then
    Firma := 123025;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := IBCQueryGoodsPrice.Connection;
    Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE TDB_GOODS_PRICE_SET_ALL_FLAG(:DOCID,:SF,:FIRMA,:END_DATE,:CLR)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('SF').AsInteger := StateFlag;
    Query.ParamByName('FIRMA').AsInteger := Firma;
    Query.ParamByName('END_DATE').AsDate := EndDate;
    Query.ParamByName('CLR').AsInteger := Ord(ClearFlag);
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
    IBCQueryGoodsPrice.Refresh;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetExcludePPFlag(DocID, FlagValue: Integer);
begin
end;

procedure Tframe40InventarizatiaPereotencaTovara.Set_FLG_COD_D(DocID, FlagValue: Integer);
var
  GoodsID: Integer;
  i: Integer;
  Query: TIBCQuery;
begin
  for i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
    GoodsID := cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPrices_GOODSID.index];
    Query := TIBCQuery.Create(Self);
    try
      Query.AutoCommit := False;
      Query.Connection := IBCQueryGoodsPrice.Connection;
      Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SET_FLG_COL_D(:DOCID, :GoodsID, :GOODS_CODE, :FLAGVALUE)';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.ParamByName('GOODSID').AsInteger := GoodsID;
      Query.ParamByName('GOODS_CODE').AsString := IBCQueryGoodsPrice.FieldByName('GOODS_CODE').AsString;
      Query.ParamByName('FLAGVALUE').AsInteger := FlagValue;
      Query.Transaction.StartTransaction;
      try
        Query.ExecSQL;
        Query.Transaction.Commit;
      except
        on E: Exception do begin
          Query.Transaction.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  end;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetFlgAvailableQty(FLG_AVAILABLE_QTY: Integer);
var
  GoodsCODE: string;
  i: Integer;
  GoodsID: Integer;
  SupplierID: Integer;
  Query: TIBCQuery;
begin
  for i := 0 to cxGridPricesTable.Controller.SelectedRowCount - 1 do begin
    GoodsID := cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPrices_GOODSID.index];
    GoodsCODE := cxGridPricesTable.DataController.Values[cxGridPricesTable.Controller.SelectedRows[i].index, cxGridPrices_SUPPLIER_GOODS_CODE.index];
    SupplierID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;

    Query := TIBCQuery.Create(Self);
    try
      Query.AutoCommit := False;
      Query.Connection := IBCQueryGoodsPrice.Connection;
      Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_SET_FLG_FORCE_ADDON(:GOODSID, :CUSTOMERID, :GOODS_CODE, :FLAG_INDEX, :FLG_AVAILABLE_QTY)';

      Query.ParamByName('GOODSID').AsInteger := GoodsID;
      Query.ParamByName('CUSTOMERID').AsInteger := SupplierID;
      Query.ParamByName('GOODS_CODE').AsString := GoodsCODE;
      Query.ParamByName('FLAG_INDEX').AsInteger := 1; // FLG_MANY_AVAILABLE

      Query.ParamByName('FLG_AVAILABLE_QTY').AsInteger := FLG_AVAILABLE_QTY;
      try
        Query.ExecSQL;
        Query.Transaction.Commit;
      except
        on E: Exception do begin
          Query.Transaction.Rollback;
          if not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  end;
  IBCQueryGoodsPrice.Refresh;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetGoodsFlagEpp(ADocID, AGoodsID, AFlagValue: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := IBCQueryGoodsPrice.Connection;
    Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;
    Query.SQL.Text := 'execute procedure set_goods_flag(:docid, :goodsid, :flag_index, :flag_value)';
    Query.ParamByName('DOCID').AsInteger := ADocID;
    Query.ParamByName('GOODSID').AsInteger := AGOODSID;
    Query.ParamByName('FLAG_INDEX').AsInteger := 4;
    Query.ParamByName('FLAG_VALUE').AsInteger := AFlagValue;

    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      on E: Exception do begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetGoodsSupplierFlag(DocID, FlagIndex: Integer; FlagValue: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := IBCQueryGoodsPrice.Connection;
    Query.Transaction := IBCQueryGoodsPrice.UpdateTransaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_SET_SUPPLIER_FLAG(:DOCID, :FLAG_INDEX, :FLAG_VALUE)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('FLAG_INDEX').AsInteger := FlagIndex;
    Query.ParamByName('FLAG_VALUE').AsInteger := FlagValue;

    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      on E: Exception do begin
        Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.Free;
    IBCQueryGoodsPrice.Refresh;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetupDefaultFocus;
begin
  // grid
  cxGridDoc.SetFocus;
  // columns
  cxGridDoc_DTNAME.Focused := True;
  cxGridPrices_GOODS_NAME.Focused := True;
end;

procedure Tframe40InventarizatiaPereotencaTovara.SetupQtyFields;
begin
  TcxCalcEditProperties(cxGridPrices_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowDeleteGoodsDialog;
var
  toDelete: Boolean;
begin
  if cxGridPricesTable.Controller.SelectedRowCount > 1 then
    toDelete := ShowAskDialog('', Format('Sterge %d produse?', [cxGridPricesTable.Controller.SelectedRowCount])) = mrYes
  else
    toDelete := ShowAskDialog('Sterge produs', 'Sterge din lista de produse' + #13#10 + IBCQueryGoodsPrice.FieldByName('GOODS_TITLE').AsString) = mrYes;

  if toDelete then begin
    try
      if not IBCQueryGoodsPrice.UpdateTransaction.Active then
        IBCQueryGoodsPrice.UpdateTransaction.StartTransaction;

      if cxGridPricesTable.Controller.SelectedRowCount > 1 then
      begin
//        cxGridPricesTable.Controller.DeleteSelection;
        cxGridPricesTable.Datacontroller.DeleteSelection;
        cxGridPricesTable.Datacontroller.Post;
      end
      else
        IBCQueryGoodsPrice.Delete;

      if IBCQueryGoodsPrice.UpdateTransaction.Active then
        IBCQueryGoodsPrice.UpdateTransaction.Commit;

      dmDB.IBCQueryDocs.Refresh;
    except
      on E: Exception do begin
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowImportGoodsFromFileDialog;
var
  dialog: TfrmImportGoodsPricesDlg;
begin
  dialog := TfrmImportGoodsPricesDlg.Create(Self, dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString);
  try
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.SupplierID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    if dialog.ShowModal = mrOk then begin
      if IBCQueryGoodsPrice.State in dsEditModes then begin
        IBCQueryGoodsPrice.Post;
        IBCQueryGoodsPrice.UpdateTransaction.Commit;
      end;
      IBCQueryGoodsPrice.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowModifyGoodsAcntDialog;
var
  dialog: TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg;
begin

  if IBCQueryGoodsPrice.UpdateTransaction.Active then begin
    if IBCQueryGoodsPrice.State in dsEditModes then
      IBCQueryGoodsPrice.Post;
    IBCQueryGoodsPrice.UpdateTransaction.Commit;
  end;

  dialog := TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.Create(Self);
  try
    dialog.GoodsID := IBCQueryGoodsPrice.FieldByName('GOODSID').AsInteger;
    if dialog.ShowModal = mrOk then
      IBCQueryGoodsPrice.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowNewGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    dialog.BurstMode := True;
    dialog.OnBurstAddGoods := WhenBurstGoodsAdd;
    if dialog.SelectGoods(fLastSelectGoodsID, False, 0, 'Selecteaza produsul') then begin
      AddNewGoodsDB(dialog.GoodsID, dialog.GoodsPriceCurrencyID, dialog.GoodsPrice[0], dialog.GoodsPrice[1], dialog.GoodsPrice[2], dialog.GoodsPrice[3], dialog.GoodsPrice[4], dialog.GoodsPrice[5], dialog.GoodsPrice[6], dialog.GoodsPrice[7]);
      fLastSelectGoodsID := dialog.GoodsID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.UpdateForcedFlag(Value: Integer);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.SQL.Text := 'update tdb_goods_price set flags = set_flg_value(flags, 3, :flag_value) where docid = :docid';
    Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.ParamByName('flag_value').AsInteger := Value;
    Query.Execute;

    if dmDB.IBCTrDefaultUpdate.Active then
      dmDB.IBCTrDefaultUpdate.Commit;

    cxGridPricesTable.DataController.Refresh;

    IBCQueryGoodsPrice.Refresh;
  finally
    Query.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.WhenBurstGoodsAdd(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer);
var
  Query: TIBCQuery;
  q: TIBCQuery;
begin
  Query := TIBCQuery.Create(nil);
  q := TIBCQuery.Create(nil);
  try

    q.sql.Text := 'SELECT GOODS_CODE, CURRENCY4ID, CURRENCY7ID, PRICE4, PRICE7 FROM TS_GOODS_FOREIGN WHERE CUSTOMERID = :CUSTOMERID AND GOODSID = :GOODSID AND GET_FLG_VALUE(FLAGS, 3) = 1';
    q.ParamByName('CUSTOMERID').AsInteger := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    q.ParamByName('GOODSID').AsInteger := GoodsID;
    q.Open;

    Query.Transaction := IBCTrGPUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'insert into tdb_goods_price (docid, goodsid, supplier_goods_code, currencyid, price4, currency4id, price7, currency7id)' + ' values(:docid, :goodsid, :supplier_goods_code, :currency4id, :price4, :currency4id, :price7, :currency7id)';

      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ParamByName('GOODSID').AsInteger := GoodsID;
      Query.ParamByName('SUPPLIER_GOODS_CODE').AsString := q.FieldByName('goods_code').AsString;
      Query.ParamByName('PRICE4').AsFloat := q.FieldByName('PRICE4').AsFloat;
      Query.ParamByName('CURRENCY4ID').AsInteger := q.FieldByName('currency4id').AsInteger;
      Query.ParamByName('PRICE7').AsFloat := q.FieldByName('PRICE7').AsFloat;
      Query.ParamByName('CURRENCY7ID').AsInteger := q.FieldByName('currency7id').AsInteger;
      Query.ExecSQL;
      Added := True;

      IBCTrGPUpdate.Commit;
    except
      on E: Exception do begin
        IBCTrGPUpdate.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
    IBCQueryGoods.Refresh;
  finally
    FreeAndNil(Query);
    q.Free;
  end;
end;

procedure Tframe40InventarizatiaPereotencaTovara.WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe40InventarizatiaPereotencaTovara.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  PrepareGoodsPriceSQL(FrameDataFilterInfo.FirmaID);
  inherited;
  IBCQueryGoodsPrice.Active := True;
end;

procedure Tframe40InventarizatiaPereotencaTovara.WhenPriceGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  PriceSelectionChanged;
end;

procedure Tframe40InventarizatiaPereotencaTovara.ShowImportFromDocumentDialog;
var
  dialog: TfrmDocumentImportBrowserDlg;
begin
  dialog := TfrmDocumentImportBrowserDlg.Create(Self);
  try
    dialog.DefaultDocTypeID := dmDB.CurrentDocTypeID;
    dialog.DefaultFirmaID := dmDB.CurrentFirma;
    dialog.DefaultUserID := dmDB.CurrentUserID;

    dialog.DocTypeList.Add(cDBID_DocType_СЧЕТА_ВС); // Facturi de intrare
    dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПН); // Nakladnaia de intrare
//  dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПТПН); // Intrare marfa pe nakladnie
//  dialog.DocTypeList.Add(cDBID_DocType_ПЕРЕМЕЩЕНИЕ_П); // Transfer
//  dialog.DocTypeList.Add(cDBID_DocType_ОСТАТКИ_ОТ); // Stocuri marfa
    if dialog.SelectDoc then begin
      if DoActionImportGoodsFromDoc(dialog.DocID) then begin
        IBCQueryGoodsPrice.Refresh;
        ShowInfoDialog('Import', 'Import din document finisat!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

end.


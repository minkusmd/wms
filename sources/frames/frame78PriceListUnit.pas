unit frame78PriceListUnit;
{
  Manager Price Listuri
  DocTypeID = 1280
  Frame Index = 78
}

interface

uses
  Classes, Controls, DBAccess, ExtCtrls, Forms, Graphics, IBC, ImgList, MemDS, Messages, SWNBaseFrameUnit,
  SWNDataFiltering, SWNDocumentFilters, Variants, Windows, cxBlobEdit, cxButtonEdit, cxButtons, cxCalc, cxCalendar,
  cxCheckBox, cxClasses, cxContainer, cxControls, cxCustomData, cxDBData, cxDBEdit, cxDBLabel, cxDBLookupComboBox,
  cxDBLookupEdit, cxDBTL, cxData, cxDataControllerConditionalFormattingRulesManagerDialog, cxDataStorage, cxDropDownEdit,
  cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomPopupMenu, cxGridCustomTableView, cxGridCustomView, cxGridDBTableView,
  cxGridLevel, cxGridPopupMenu, cxGridTableView, cxGroupBox, cxImage, cxInplaceContainer, cxLabel, cxLookAndFeelPainters,
  cxLookAndFeels, cxLookupEdit, cxMaskEdit, cxMemo, cxNavigator, cxPC, cxProgressBar, cxSplitter, cxStyles, cxTL,
  cxTLData, cxTLdxBarBuiltInMenu, cxTextEdit, dxBar, dxBarBuiltInMenu, dxDateRanges, dxRatingControl,
  dxScrollbarAnnotations, dxSpreadSheetCore, dxStatusBar, dxUIAClasses, frmSendGoodsToPackage,
  Data.DB,
  System.Actions,
  System.SysUtils,
  System.UITypes,
  Vcl.ActnList,
  Vcl.Buttons,
  Vcl.Menus,
  Vcl.StdCtrls;

type
  TPriceGoodsMinInfo = record
    GoodsID: integer;
    ParentID: integer;
    WebGoodsTypeID: integer;
    VendorID: integer;
    IsFolder: integer;
    Price3: double;
    Currency3ID: integer;
    Price7: double;
    Currency7ID: integer;
    VAT: integer;

    Model: string;
    URL: string;

    FLG_RRP: boolean;
    FLG_IN_PRICE: boolean;
    FLG_PRE_ORDER: boolean;
  end;

  Tframe78PriceList = class(TSWNBaseFrame)
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarButton3: TdxBarButton;
    IBCQueryPriceItems: TIBCQuery;
    IBCDataSourcePriceItems: TIBCDataSource;
    IBCQueryPriceData: TIBCQuery;
    IBCDataSourcePriceData: TIBCDataSource;
    bbSupplierNew: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    bbPricelistNew: TdxBarButton;
    bbPricelistDelete: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbGoodsNew: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton2: TdxBarButton;
    bbIndentifyBrand: TdxBarButton;
    cxPageControl1: TcxPageControl;
    tsPriceList: TcxTabSheet;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    pnMain: TPanel;
    Panel2: TPanel;
    bbIdentifyBrand: TdxBarButton;
    bbSetupGoodsType: TdxBarButton;
    bbSetupBrand: TdxBarButton;
    bbAddBrandToPricelist: TdxBarButton;
    bbAddSelectedGoodsToCatalog: TdxBarButton;
    dxBarButton4: TdxBarButton;
    IBCDataSourceNewGoods: TIBCDataSource;
    IBCQueryNewGoods: TIBCQuery;
    IBCQueryOldGoods: TIBCQuery;
    IBCDataSourceOldGoods: TIBCDataSource;
    IBCDataSourcePricesUp: TIBCDataSource;
    IBCQueryPricesUp: TIBCQuery;
    IBCQueryPricesDown: TIBCQuery;
    IBCDataSourcePricesDown: TIBCDataSource;
    IBCDataSource122: TIBCDataSource;
    IBCQuery122: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    IBCQueryGoods: TIBCQuery;
    IBCQueryOldPriceList: TIBCQuery;
    IBCDataSourceOldPriceList: TIBCDataSource;
    IBCQueryCurrentPriceList: TIBCQuery;
    IBCDataSourceCurrentPriceList: TIBCDataSource;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    lcbPriceCategory: TcxLookupComboBox;
    IBCQueryPriceCategories: TIBCQuery;
    IBCDataSourcePriceCategories: TIBCDataSource;
    IBCQueryPriceToCompare: TIBCQuery;
    IBCDataSourcePriceToCompare: TIBCDataSource;
    lcbCompareWithPrice: TcxLookupComboBox;
    cxLabel4: TcxLabel;
    dxBarButton6: TdxBarButton;
    bbShowSettings: TdxBarButton;
    dxBarButton7: TdxBarButton;
    cxSplitter1: TcxSplitter;
    bbPricePolicy: TdxBarButton;
    bbProcessSelectedRecords: TdxBarButton;
    bbInternetSearch: TdxBarButton;
    cxButton3: TcxButton;
    ActionList1: TActionList;
    ActReevaluare: TAction;
    dxBarPopupPrices: TdxBarPopupMenu;
    Panel3: TPanel;
    cxGridData: TcxGrid;
    cxGridDataDBTableView1: TcxGridDBTableView;
    cxGridDataDBTableView1_PLID: TcxGridDBColumn;
    cxGridDataDBTableView1DATA: TcxGridDBColumn;
    cxGridDataDB_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDataLevel1: TcxGridLevel;
    dxBarDockControl2: TdxBarDockControl;
    cxButton1: TcxButton;
    btnUpdatePriceFromDB: TButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    bbSetParentID: TdxBarButton;
    cxGridSuppliers: TcxGrid;
    cxGridSuppliersDBTableView1: TcxGridDBTableView;
    cxGridSuppliersDBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGridSuppliersDBTableView1DISPLAYNAME: TcxGridDBColumn;
    cxGridSuppliersDBTableView1LAST_PRICELIST_DATE: TcxGridDBColumn;
    cxGridSuppliersLevel1: TcxGridLevel;
    tmrSupplierRefresh: TTimer;
    IBCQuerySuppliers: TIBCQuery;
    IBCDataSourceSuppliers: TIBCDataSource;
    SpeedButton1: TSpeedButton;
    Panel1: TPanel;
    pcPricesAnalize: TcxPageControl;
    tsAllPriceGoods: TcxTabSheet;
    cxGridItems: TcxGrid;
    cxGridItemsDBTableView1: TcxGridDBTableView;
    cxGridItemsDBTableView1FLG_IN_PRICE: TcxGridDBColumn;
    cxGridItemsDBTableView1_FLG_RRP: TcxGridDBColumn;
    cxGridItemsDBTableView1PLID: TcxGridDBColumn;
    cxGridItemsDBTableView1_PARENTID: TcxGridDBColumn;
    cxGridItemsDBTableView1PARENTTITLE: TcxGridDBColumn;
    cxGridItemsDBTableView1WEBGOODSTYPE_ID: TcxGridDBColumn;
    cxGridItemsDBTableView1WEBGOODSTYPE_NAME: TcxGridDBColumn;
    cxGridItemsDBTableView1GOODSID: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_VENDORID: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_GOODSTYPE: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_GOODS_BRAND: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_GOODS_MODEL: TcxGridDBColumn;
    cxGridItemsDBTableView1DESCRIERE: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_Price1: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_Price7: TcxGridDBColumn;
    cxGridItemsDBTableView1_GOODS_NAME: TcxGridDBColumn;
    cxGridItemsDBTableView1AVAILABILITY: TcxGridDBColumn;
    cxGridItemsDBTableView1FLAGS: TcxGridDBColumn;
    cxGridItemsDBTableView1PRICERRP: TcxGridDBColumn;
    cxGridItemsDBTableView1CURRENCY3ID: TcxGridDBColumn;
    cxGridItemsDBTableView1PRICE7: TcxGridDBColumn;
    cxGridItemsDBTableView1CURRENCY7ID: TcxGridDBColumn;
    cxGridItemsDBTableView1Price0: TcxGridDBColumn;
    cxGridItemsDBTableView1CURRENCY0ID: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_VENDOR_NAME: TcxGridDBColumn;
    cxGridItemsDBTableView1_SUPPLIER_BARCODE: TcxGridDBColumn;
    cxGridItemsDBTableView1Product_link: TcxGridDBColumn;
    cxGridItemsLevel1: TcxGridLevel;
    tsNewGoods: TcxTabSheet;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1GOODSID: TcxGridDBColumn;
    cxGridDBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGridDBTableView1SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridDBTableView1NEW_PRICE3: TcxGridDBColumn;
    cxGridDBTableView1_CURRENCY3ID: TcxGridDBColumn;
    cxGridDBTableView1NEW_PRICE7: TcxGridDBColumn;
    cxGridDBTableView1_CURRENCY7ID: TcxGridDBColumn;
    cxGridDBTableView1_PRICE0: TcxGridDBColumn;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    tsOldGoodsPrice: TcxTabSheet;
    cxGrid2: TcxGrid;
    cxGrid2DBTableViewOldGoods: TcxGridDBTableView;
    cxGrid2DBTableViewOldGoods_FLG_IN_PRICE: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoods_GOODSID: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoodsNEW_PRICE0: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoods_CURRENCY3ID: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoodsNEW_PRICE7: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoods_CURRENCY7ID: TcxGridDBColumn;
    cxGrid2DBTableViewOldGoods_PRICE0: TcxGridDBColumn;
    cxGrid2Level1: TcxGridLevel;
    tsGoodsPricesUp: TcxTabSheet;
    cxGrid4: TcxGrid;
    cxGridDBTVPricesUp: TcxGridDBTableView;
    cxGridDBTVPricesUp_FLG_IN_PRICE: TcxGridDBColumn;
    cxGridDBTVPricesUp_GOODSID: TcxGridDBColumn;
    cxGridDBTVPricesUp_SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGridDBTVPricesUp_SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridDBTVPricesUp_NEW_PRICE3: TcxGridDBColumn;
    cxGridDBTVPricesUp_OLD_PRICE3: TcxGridDBColumn;
    cxGridDBTVPricesUp_NEW_CURRENCY3ID: TcxGridDBColumn;
    cxGridDBTVPricesUp_DEVIATION3: TcxGridDBColumn;
    cxGridDBTVPricesUp_NEW_PRICE7: TcxGridDBColumn;
    cxGridDBTVPricesUp_OLD_PRICE7: TcxGridDBColumn;
    cxGridDBTVPricesUp_NEW_CURRENCY7ID: TcxGridDBColumn;
    cxGridDBTVPricesUp_DEVIATION7: TcxGridDBColumn;
    cxGridDBTVPricesUp_OLD_PRICE0: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    tsGoodsPricesDown: TcxTabSheet;
    cxGrid5: TcxGrid;
    cxGridDBTVPricesDown: TcxGridDBTableView;
    cxGridDBTVPricesDownColumn3: TcxGridDBColumn;
    cxGridDBTVPricesDown_GOODSID: TcxGridDBColumn;
    cxGridDBTVPricesDownSUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGridDBTVPricesDownSUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridDBTVPricesDownNEW_PRICE3: TcxGridDBColumn;
    cxGridDBTVPricesDownOLD_PRICE3: TcxGridDBColumn;
    cxGridDBTVPricesDownDEVIATION3: TcxGridDBColumn;
    cxGridDBTVPricesDownCURRENCY3ID: TcxGridDBColumn;
    cxGridDBTVPricesDownNEW_PRICE7: TcxGridDBColumn;
    cxGridDBTVPricesDownOLD_PRICE7: TcxGridDBColumn;
    cxGridDBTVPricesDownCURRENCY7ID: TcxGridDBColumn;
    cxGridDBTVPricesDownDEVIATION7: TcxGridDBColumn;
    cxGridDBTVPricesDown_NEW_PRICE0: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    dxBarButton10: TdxBarButton;
    dxStatusBar1: TdxStatusBar;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    cxGridDBTVPricesUp_FLG_EPP: TcxGridDBColumn;
    cxGridDBTVPricesDown_FLG_EPP: TcxGridDBColumn;
    cxGridItemsDBTableView1_FLG_HAS_IMAGE: TcxGridDBColumn;
    cxGridItemsDBTableView1_CODE_RU: TcxGridDBColumn;
    cxGridItemsDBTableView1_CODE: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_DETAIL: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_PARAMS: TcxGridDBColumn;
    cxGridItemsDBTableView1_SYSTEM_PARAMS_RU: TcxGridDBColumn;
    dxBarButton13: TdxBarButton;
    cbRRP: TcxCheckBox;
    bbAPISupplier: TdxBarButton;
    cxGridDBTVPricesUp_NEW_PRICE0: TcxGridDBColumn;
    cxGridDBTVPricesDown_OLD_PRICE0: TcxGridDBColumn;
    bbSetEPP: TdxBarButton;
    cxGridItemsDBTableView1FLG_PREORDER: TcxGridDBColumn;
    bbDeleteAllGoodsFromCatalog: TdxBarButton;
    actAnalizaPriceLIst: TAction;
    bbCurrency7: TdxBarButton;
    IBCQueryCustSuppliers: TIBCQuery;
    IBCDataSourceCustSuppliers: TIBCDataSource;
    dxBarSubItem2: TdxBarSubItem;
    bbChangeGoodsName: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton16: TdxBarButton;
    dxBarButton17: TdxBarButton;
    IBCDataSourceNewGoodsSupplier: TIBCDataSource;
    IBCQueryNewGoodsSupplier: TIBCQuery;
    tbsNewSupplierGoods: TcxTabSheet;
    bbChangeRRP: TdxBarButton;
    cxGrid2DBTableViewOldGoods_FLG_EPP: TcxGridDBColumn;
    cxGridItemsDBTableView1M71: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBTableView2GOODSID: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDB_SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridDBColumn21: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDBColumn28: TcxGridDBColumn;
    cxGridDBColumn29: TcxGridDBColumn;
    cxGridDBColumn30: TcxGridDBColumn;
    cxGridDBColumn31: TcxGridDBColumn;
    cxGridDBColumn32: TcxGridDBColumn;
    cxGridDBColumn33: TcxGridDBColumn;
    cxGridDBColumn34: TcxGridDBColumn;
    cxGridDBColumn35: TcxGridDBColumn;
    cxGridDBColumn36: TcxGridDBColumn;
    cxGridDBColumn37: TcxGridDBColumn;
    cxGridDBColumn38: TcxGridDBColumn;
    cxGridLevel4: TcxGridLevel;
    dxBarButton18: TdxBarButton;
    dxStatusBar2: TdxStatusBar;
    bbToateReevaluarile: TdxBarButton;
    dxBarButton19: TdxBarButton;
    cxButton2: TcxButton;
    cxButton4: TcxButton;
    btnAnalizaReevaluare: TcxButton;
    dxBarButton20: TdxBarButton;
    cxGridItemsDBTableView1Column2: TcxGridDBColumn;
    bbGoodsPropertiesDownload: TdxBarButton;
    bbGoodsContentToProduction: TdxBarButton;
    cxPageControl2: TcxPageControl;
    tsLog: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    meLog: TcxMemo;
    cxGrid6DBTableView1: TcxGridDBTableView;
    cxGrid6Level1: TcxGridLevel;
    cxGrid6: TcxGrid;
    cxDBImage1: TcxDBImage;
    IBCQueryPriceListImages: TIBCQuery;
    IBCDataSourcePricelistImages: TIBCDataSource;
    IBCQueryPriceListImageBlob: TIBCQuery;
    IBCDataSourcePricelistImageBlob: TIBCDataSource;
    cxGrid6DBTableView1SUPPLIERID: TcxGridDBColumn;
    cxGrid6DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGrid6DBTableView1IMAGE_URL: TcxGridDBColumn;
    cxGrid6DBTableView1PROCESS_DATE: TcxGridDBColumn;
    cxGridItemsDBTableView1Price1_LEI: TcxGridDBColumn;
    cxGridItemsDBTableView1EXCHANGE_RATE3: TcxGridDBColumn;
    dxBarButton21: TdxBarButton;
    cxGridDataDBTableView1_FLG_DONE: TcxGridDBColumn;
    procedure cxPageControl2Change(Sender: TObject);
    procedure actAnalizaPriceLIstExecute(Sender: TObject);
    procedure ActReevaluareExecute(Sender: TObject);
    procedure bbAnalizeClick(Sender: TObject);
    procedure bbPricelistNewClick(Sender: TObject);
    procedure bbPricelistDeleteClick(Sender: TObject);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure cxGridItemsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbIdentifyBrandClick(Sender: TObject);
    procedure bbSetupGoodsTypeClick(Sender: TObject);
    procedure bbSetupBrandClick(Sender: TObject);
    procedure bbAddBrandToPricelistClick(Sender: TObject);
    procedure bbAddSelectedGoodsToCatalogClick(Sender: TObject);
    procedure bbChangeGoodsNameClick(Sender: TObject);
    procedure bbPricePolicyClick(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure btnUpdatePriceFromDBClick(Sender: TObject);
    procedure cxGrid2DBTableViewOldGoodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTVPricesUpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTVPricesDownKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGrid2DBTableViewOldGoodsStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
      TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridDBTVIncreasePricesStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridDBTableView3StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton6Click(Sender: TObject);
    procedure lcbCompareWithPricePropertiesInitPopup(Sender: TObject);
    procedure bbShowSettingsClick(Sender: TObject);
    procedure dxBarButton7Click(Sender: TObject);
    procedure bbProcessSelectedRecordsClick(Sender: TObject);
    procedure bbInternetSearchClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure dxBarButton9Click(Sender: TObject);
    procedure bbSetParentIDClick(Sender: TObject);
    procedure cxGridSuppliersDBTableView1DblClick(Sender: TObject);
    procedure cxGridSuppliersDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSuppliersDBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure tmrSupplierRefreshTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dxBarButton10Click(Sender: TObject);
    procedure dxBarButton11Click(Sender: TObject);
    procedure dxBarButton12Click(Sender: TObject);
    procedure lcbPriceCategoryPropertiesChange(Sender: TObject);
    procedure dxBarButton13Click(Sender: TObject);
    procedure cxGridItemsDBTableView1_CODEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pcPricesAnalizePageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure bbAPISupplierClick(Sender: TObject);
    procedure bbSetEPPClick(Sender: TObject);
    procedure dxBarButton15Click(Sender: TObject);
    procedure bbDeleteAllGoodsFromCatalogClick(Sender: TObject);
    procedure bbCurrency7Click(Sender: TObject);
    procedure cxGridDBTableView2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton16Click(Sender: TObject);
    procedure dxBarButton17Click(Sender: TObject);
    procedure cxGridDBTableView2StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbToateReevaluarileClick(Sender: TObject);
    procedure btnAnalizaReevaluareClick(Sender: TObject);
    procedure dxBarButton19Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxGridItemsDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbGoodsPropertiesDownloadClick(Sender: TObject);
    procedure bbGoodsContentToProductionClick(Sender: TObject);
    procedure dxBarButton21Click(Sender: TObject);
    procedure dxBarButton18Click(Sender: TObject);
    procedure bbSupplierNewClick(Sender: TObject);
  private // procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
    FlgImportWithRRP: Boolean;
    LastPriceCategoryID: Integer;
    LastSupplierID: Integer;
    FMediaMagnatToken: string;
    FMediaMagnatTokenUser: string;
    FMediaMagnatTokenBaseUrl: string;
    FMediaMagnatTokenExpiresAt: UInt64;
    procedure ClosePriceAnalizeDataSet;
    procedure LoadSelectedSupplier;
    procedure ImportMediaMagnatPriceList;
    function GetSelectionIDList(ATable: TcxGridDBTableView): string;
    function SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
    procedure AddRecordToReevaluareVinzare(Transaction: TIBCTransaction; DOCID, goodsid, Supplierid: Integer;
      SupplierGoodsCode: string; price0: double; currency0id: Integer; price3: double; Currency3ID: Integer; GoodsName,
      Barcode: string; flg_in_price: Boolean; flg_rrp: boolean);
    function GetGoodsPrice0Index(ATableView: TcxGridDBTableView): Integer;
    function GetGoodsCurrency0Index(ATableView: TcxGridDBTableView): Integer;
    procedure GoodsDescription(AGoodsID: Integer);
    procedure InitArrayCont(AGridView: TcxGridDBTableView; AFieldIndex: Integer; ADuplist: TStringList);
  protected
    { Protected declarations }
    procedure AddGoodsToCatalog(TableView: TcxGridDBTableView);
    function AddNewGoodsInCatalogV1: TPriceGoodsMinInfo;
    procedure AnalyzePriceList;
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure DeleteAllGoodsFromCatalog(PLID, SupplierID: Integer);
    procedure DeleteRecord; override;
    procedure DoAnalizePrice(OldPlid: integer; NewPlid: Integer);
    procedure UpdatePriceListImagesQuery;
    procedure DoSearchBrandByName;
    function GetActiveTableView(ActivePageIndex: Integer): TcxGridDBTableView;
    function GetGoodsCurrency3Index(ATableView: TcxGridDBTableView): Integer;
    function GetGoodsCurrency7idIndex(ATableView: TcxGridDBTableView): Integer;
    function GetGoodsIDFieldIndex(ATableView: TcxGridDBTableView): Integer;
    function GetGoodsPrice3Index(ATableView: TcxGridDBTableView): Integer;
    function GetGoodsPrice7Index(ATableView: TcxGridDBTableView): Integer;
    procedure OpenPriceList;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    function ShowLinkGoodsDialog(GoodsName: string): Integer;
    procedure SelectSupplier;
    procedure SetupSecurityItems; override;
  public
    DupFieldIndex: Integer;
    DupList: TStringList;

    function AddDocumentReeveluare(Transaction: TIBCTransaction): Integer;
    procedure AddRecordToReevaluare(Transaction: TIBCTransaction; DOCID, goodsid, Supplierid: Integer; SupplierGoodsCode:
      string; price0: double; currency0id: Integer; price3: double; Currency3ID: Integer; Price7: double; currency7id:
      Integer; GoodsName, Barcode: string; flg_in_price: Boolean; flg_rrp: boolean);
    function CheckGoodsIsFolder(goodsid: Integer): Boolean;
    procedure CopyNameToModel(const FieldName: string);
    procedure DoCreateReevaluare(FLG_UseRRP: Boolean; ATableView: TcxGridDBTableView; flg_in_price: Boolean = False);
    function GetBestMatchParentGoodsID(const webgoodstypeid: Integer; out fBestMatchParentGoodsID: Integer): Boolean;
    function GetBrandID: Integer;
    function GetRRPFlag(GoodsID, SupplierID: Integer): Integer;
    procedure SetBrandByName(BrandName, GoodsCode: string; PLID: Integer);
    procedure SetParentID(AParentID: Integer);
    procedure SetPriceListGoodsTypeID;
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

uses
  ApiAccentUnit, B2B.DMLinkPriceListImport, DataModuleAdditions, DataModuleDB, SWNConst, SWNDBErrors, SWNSecurity, SWNTypes, SWNUtils,
  SWNValueStorageUnit, dxInputDialogs, frmAddGoodsfromPrices, frmAddNewGoodsUnit, frmAnalizePriceListUnit,
  frmContentGoodsEditorDialog, frmContentPackage, frmCustomersDlg, frmGoods, frmGoodsPriceListDlgUnit, frmGoodsTypeDialog,
  frmMuncitorulProgressUnit, OlisGrupContentUnit, frmPriceManageStringFieldsUnit, frmPriceTypesUnit, frmPricelistImportUnit,
  frmSelectGoodsTypeUnit, frmSyssDataEditor, frmSyssEditorWindow, uAnalizePriceList, {uLoadProductImages,} uPythonRunner, MamicoContentUnit, ImperiaContentUnit, ArvaliscomContentUnit, FiltreContentUnit, AloContentUnit, PernaMeaContentUnit, TinaContentUnit, PriceListContentTransferUnit, NexDistributionUnit, TriomacPriceListUnit, AgroPiesePriceListUnit, PriceGoodsCreateUnit,
  System.Math,
  IBCClasses, System.JSON, System.Generics.Collections, System.Net.HttpClient, System.Net.URLClient,
  System.Win.Registry,
  Vcl.Clipbrd,
  Vcl.Dialogs,
  Winapi.ShellAPI, uPythonRunnerGoogle;

{$R *.dfm}

procedure Tframe78PriceList.actAnalizaPriceLIstExecute(Sender: TObject);
begin
  DoAnalizePrice(IBCQueryPriceToCompare.FieldByName('PLID').AsInteger, IBCQueryPriceData.FieldByName('PLID').AsInteger);
end;

procedure Tframe78PriceList.ActReevaluareExecute(Sender: TObject);
begin
  FlgImportWithRRP := cbRRP.Checked;
  if pcPricesAnalize.ActivePage = tsAllPriceGoods then
  begin
    if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGridItemsDBTableView1.Controller.SelectedRowCount]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
//      IBCQueryPriceItems.Refresh;
      cxGridItemsDBTableView1.DataController.RefreshExternalData;
      DoCreateReevaluare(FlgImportWithRRP, cxGridItemsDBTableView1, true);
    end;
  end;

  if (pcPricesAnalize.ActivePage = tsNewGoods) then
  begin
    if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGridDBTableView1.Controller.SelectedRowCount]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DoCreateReevaluare(FlgImportWithRRP, cxGridDBTableView1, true);
    end;
  end;

  if (pcPricesAnalize.ActivePage = tsOldGoodsPrice) then
  begin
    if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGrid2DBTableViewOldGoods.Controller.SelectedRowCount]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DoCreateReevaluare(FlgImportWithRRP, cxGrid2DBTableViewOldGoods, False);
    end;
  end;

  if (pcPricesAnalize.ActivePage = tsGoodsPricesUp) then
  begin
    if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGridDBTVPricesUp.Controller.SelectedRowCount]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DoCreateReevaluare(FlgImportWithRRP, cxGridDBTVPricesUp, true);
    end;
  end;

  if (pcPricesAnalize.ActivePage = tsGoodsPricesDown) then
  begin
    if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGridDBTVPricesDown.Controller.SelectedRowCount]),
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      DoCreateReevaluare(FlgImportWithRRP, cxGridDBTVPricesDown, true);
    end;
  end;

end;

function Tframe78PriceList.AddDocumentReeveluare(Transaction: TIBCTransaction): Integer;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  Query.Transaction := Transaction;
  try
    Query.SQL.Text :=
      'select newdocid from sp_create_new_document (:dt, :ct, :DTDEP, :CTDEP, :DTSC, :ctsc, :SUMA, :VAT, :CURRENCYID, :DISCOUNT, ' +
      ':RATE, :RATEUSD, :DOCID, :ACC$MASK, :doctypeid, :flags, :SC2, :CONTRACTID)';

    Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
    Query.ParamByName('CT').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := -1; // FieldByName('dTDEP').AsInteger,
    Query.ParamByName('CTDEP').AsInteger := -1; // FieldByName('CTDEP').AsInteger,
    Query.ParamByName('DTSC').AsInteger := -1; // FieldByName('DTSC').AsInteger,
    Query.ParamByName('CTSC').AsInteger := -1; // FieldByName('CTSC').AsInteger,
    Query.ParamByName('SUMA').AsInteger := 0; // FieldByName('SUMA').AsInteger,
    Query.ParamByName('VAT').AsInteger := 0; // FieldByName('VAT').AsInteger,
    Query.ParamByName('CURRENCYID').AsInteger := 498; // FieldByName('CURRENCYID').AsInteger,
    Query.ParamByName('DISCOUNT').AsInteger := 0; // FieldByName('DISCOUNT').AsInteger,
    Query.ParamByName('RATE').AsInteger := 1; // FieldByName('RATE').AsInteger,
    Query.ParamByName('RATEUSD').AsInteger := 1; // FieldByName('RATEUSD').AsInteger,
    Query.ParamByName('DOCID').AsInteger := -1;
    Query.ParamByName('ACC$MASK').AsInteger := 0; // dmDB.IBCQueryDocs.FieldByName('ACC$MASK').AsInteger;
    Query.ParamByName('DOCTYPEID').AsInteger := 1414; // FieldByName('DOCTYPEID').AsInteger,
    Query.ParamByName('FLAGS').AsInteger := 0; // FieldByName('FLAGS').AsInteger,
    Query.ParamByName('SC2').AsInteger := -1; // FieldByName('SC2').AsInteger,
    Query.ParamByName('CONTRACTID').AsInteger := -1; // FieldByName('CONTRACTD').AsInteger,

    try
      Query.Open;
      Result := Query.FieldByName('NEWDOCID').AsInteger;
      Transaction.Commit;
      IBCQueryPriceItems.RefreshRecord;
    except
      Result := -1;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe78PriceList.AddGoodsToCatalog(TableView: TcxGridDBTableView);
begin

end;

function Tframe78PriceList.AddNewGoodsInCatalogV1: TPriceGoodsMinInfo;
var
  rec: TPriceGoodsMinInfo;
  q: TIBCQuery;
  aGoodsID: integer;
begin
  if strToIntDef(clipboard.AsText, -1) = -1 then
  begin
    // in clipboard este un integer
    // trebuie de adus din catalog;
    var d := TfrmGoodsBrowser.Create(self);
    try
      if d.SelectGoods(-1, false) then
        aGoodsID := d.GoodsID;
    finally
      d.Free;
    end;
  end
  else
  begin
    aGoodsID := strToInt(clipboard.AsText);
  end;

  q := TIBCQuery.Create(nil);
  try
    q.SQL.Text := 'select * from ts_goods where goodsid = :goodsid';
    q.parambyname('goodsid').AsString := clipboard.astext;
    q.Open;
    rec.GoodsID := q.FieldByName('goodsid').AsInteger;
    rec.ParentID := iif(q.FieldByName('parentid').AsInteger > 0, q.FieldByName('parentid').AsInteger, -1);
    rec.VendorID := iif(q.FieldByName('vendor_id').AsInteger > 0, q.FieldByName('goodsid').AsInteger, -1);
    rec.WebGoodsTypeID := iif(q.FieldByName('webgoodstype_id').AsInteger > 0, q.FieldByName('webgoodstype_id').AsInteger, -1);
  finally
    q.Free;
  end;

  if (rec.ParentID < 0) or (rec.VendorID < 0) or (rec.WebGoodsTypeID < 0) then
  begin
    // fill the form for
    var dialog := TfrmGoodsPriceListDlg.Create(self);
    try
      dialog.ParentID := rec.ParentID;
      dialog.VendorID := rec.VendorID;
      dialog.WebGoodsTypeID := rec.WebGoodsTypeID;
      dialog.VAT := rec.Vat;
      if dialog.ShowModal = mrOK then
      begin
        rec.GoodsID := dialog.GoodsID;
        rec.ParentID := dialog.ParentID;
        rec.WebGoodsTypeID := dialog.WebGoodsTypeID;
        rec.VendorID := dialog.VendorID;
        rec.VAT := dialog.VAT;
      end;
    finally
      dialog.Free;
    end;

  end;

  Result := rec;
end;

procedure Tframe78PriceList.AddRecordToReevaluare(Transaction: TIBCTransaction; DOCID, goodsid, Supplierid: Integer;
  SupplierGoodsCode: string; price0: double; currency0id: Integer; price3: double; Currency3ID: Integer; Price7: double;
  currency7id: Integer; GoodsName, Barcode: string; flg_in_price: Boolean; flg_rrp: boolean);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  Query.AutoCommit := False;
  Query.Transaction := Transaction;

  if not Transaction.Active then
    Transaction.StartTransaction;

  try
    Query.SQL.Add('insert into TDB_GOODS_PRICE (DOCID, GOODSID, SUPPLIER_GOODS_CODE, PRICE0, PRICE3, CURRENCYID, CURRENCY3ID, PRICE7, CURRENCY7ID, BARCODE, flags)');
    Query.SQL.Add('values (:DOCID, :GOODSID, :SUPPLIER_GOODS_CODE, :PRICE0, :PRICE3, :CURRENCYID, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, :BARCODE, '
      + 'set_flg_value(set_flg_value(0, 3, :flg_in_price), 4, :flg_epp))');

    // Q.SQL.Text := 'insert into tdb_goods_price (docid, goodsid, supplier_goods_code,price3, currencyid, currency3id, price7,currency7id, barcode) values( :DOCID, :GOODSID, :SUPPLIER_GOODS_CODE, :PRICE3, :currencyid, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, :BARCODE )';

    Query.ParamByName('DOCID').Value := DOCID;
    Query.ParamByName('GOODSID').Value := goodsid;
    Query.ParamByName('SUPPLIER_GOODS_CODE').Value := SupplierGoodsCode;
    Query.ParamByName('PRICE0').Value := price0;
    Query.ParamByName('CURRENCYID').Value := currency0id;

    Query.ParamByName('PRICE3').Value := price3;
    Query.ParamByName('CURRENCY3ID').Value := Currency3ID;
    Query.ParamByName('PRICE7').Value := Price7;
    Query.ParamByName('CURRENCY7ID').Value := currency7id;
    Query.ParamByName('BARCODE').Value := Barcode;
    Query.ParamByName('flg_in_price').Value := iif(flg_in_price, 1, 0);
    Query.ParamByName('flg_epp').Value := iif((flg_rrp), 1, 0);

    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure Tframe78PriceList.AddRecordToReevaluareVinzare(Transaction: TIBCTransaction; DOCID, goodsid, Supplierid:
  Integer; SupplierGoodsCode: string; price0: double; currency0id: Integer; price3: double; Currency3ID: Integer;
  GoodsName, Barcode: string; flg_in_price: Boolean; flg_rrp: boolean);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  Query.AutoCommit := False;
  Query.Transaction := Transaction;

  if not Transaction.Active then
    Transaction.StartTransaction;

  try
    Query.SQL.Text :=
      'insert into tdb_goods_price (docid, goodsid, supplier_goods_code, price0, price3, currencyid, currency3id, barcode, flags) ' +
      ' values( :DOCID, :GOODSID, :SUPPLIER_GOODS_CODE, :PRICE0, :PRICE3, :currencyid, :CURRENCY3ID, :BARCODE, set_flg_value(set_flg_value(0, 3, :flg_in_price), 4, :flg_epp ))';

    Query.ParamByName('DOCID').Value := DOCID;
    Query.ParamByName('GOODSID').Value := goodsid;
    Query.ParamByName('SUPPLIER_GOODS_CODE').Value := SupplierGoodsCode;
    Query.ParamByName('PRICE0').Value := price0;
    Query.ParamByName('PRICE3').Value := price3; //iif(flg_rrp, price3, 0.00);
    Query.ParamByName('CURRENCYID').Value := currency0id;
    Query.ParamByName('CURRENCY3ID').Value := Currency3ID;
    Query.ParamByName('BARCODE').Value := Barcode;
    Query.ParamByName('FLG_IN_PRICE').Value := iif(flg_in_price, 1, 0);
    Query.ParamByName('flg_epp').Value := iif(flg_rrp, 1, 0);
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure Tframe78PriceList.AnalyzePriceList;
begin
  raise Exception.Create('Nu este definita procedura');
end;

procedure Tframe78PriceList.CreateNewRecord;
begin
  raise Exception.Create('Nu sunt definite regulile pentru crearea unei inregistrari noi.');
end;

procedure Tframe78PriceList.cxGridItemsDBTableView1_CODEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
    cxGridItemsDBTableView1_CODE_RU.Index] := cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
    cxGridItemsDBTableView1_CODE.Index];
end;

procedure Tframe78PriceList.LoadSelectedSupplier;
// Se cheama pentru furnizorul curent focusat in cxGridSuppliers: fie imediat
// (dublu-click / Enter), fie automat, cu 1 secunda intarziere dupa ultima
// deplasare in grid (scroll/sageti) - vezi tmrSupplierRefresh.
begin
  if IBCQuerySuppliers.IsEmpty then
    Exit;

  IBCQueryPriceCategories.Close;
  IBCQueryPriceCategories.ParamByName('customerid').AsInteger := IBCQuerySuppliers.FieldByName('customerid').AsInteger;
  IBCQueryPriceCategories.Open;

  if IBCQueryPriceCategories.RecordCount > 0 then
  begin
    lcbPriceCategory.EditValue := IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger;
  end;
  ClosePriceAnalizeDataSet;
  OpenPriceList;
  pcPricesAnalize.ActivePage := tsAllPriceGoods;

  ibcqueryCustSuppliers.Close;
  ibcqueryCustSuppliers.ParamByName('Customerid').AsInteger := IBCQuerySuppliers.FieldByName('customerid').AsInteger;
  ibcqueryCustSuppliers.Open;
end;

procedure Tframe78PriceList.cxGridSuppliersDBTableView1DblClick(Sender: TObject);
begin
  tmrSupplierRefresh.Enabled := False;
  LoadSelectedSupplier;
end;

procedure Tframe78PriceList.cxGridSuppliersDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    tmrSupplierRefresh.Enabled := False;
    LoadSelectedSupplier;
    Key := 0;
  end;
end;

procedure Tframe78PriceList.cxGridSuppliersDBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  // Repornim temporizatorul la fiecare deplasare (scroll / sageti): reincarcarea
  // efectiva (categorii de pret + lista de produse) se face abia dupa 1 secunda
  // de la ultima miscare, ca sa nu interogam baza de date la fiecare rand parcurs.
  tmrSupplierRefresh.Enabled := False;
  if AFocusedRecord <> nil then
    tmrSupplierRefresh.Enabled := True;
end;

procedure Tframe78PriceList.tmrSupplierRefreshTimer(Sender: TObject);
begin
  tmrSupplierRefresh.Enabled := False;
  LoadSelectedSupplier;
end;

procedure Tframe78PriceList.DeleteRecord;
begin
  inherited;

end;

procedure Tframe78PriceList.DoFrameHide;
begin
  // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  // 1. De scos la griduri event handles for OnFocusedRecordChanged

  IBCQueryPriceData.Active := False;
  IBCQueryPriceCategories.Active := False;
  IBCQueryPriceItems.Active := False;
  IBCQuerySuppliers.Active := False;
  IBCQueryPriceListImageBlob.Active := False;
  IBCQueryPriceListImages.Active := False;
  // 2. De deconectat sursele de date de la griduri

  cxGridDataDBTableView1.DataController.DataSource := nil;
  cxGridItemsDBTableView1.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe78PriceList.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  cxGridDataDBTableView1.DataController.DataSource := IBCDataSourcePriceData;
  cxGridItemsDBTableView1.DataController.DataSource := IBCDataSourcePriceItems;

  pcPricesAnalize.ActivePageIndex := 0;
  IBCQuerySuppliers.Open;

  SetupSecurityItems;

  cxGridSuppliersDBTableView1DISPLAYNAME.Focused := True;
end;

procedure Tframe78PriceList.bbSetParentIDClick(Sender: TObject);
var
  aRecIndex: Integer;
  d: TfrmAddNewGoodsDlg;
  q: TIBCSQL;
  ATableView: TcxGridDBTableView;
begin
  d := TfrmAddNewGoodsDlg.Create(Self, IBCQueryPriceItems, IBCDataSourcePriceItems);
  try
//    ATableView := cxGridItemsDBTableView1;
    ATableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
    aRecIndex := ATableView.ViewData.Records[ATableView.Controller.FocusedRecordIndex].RecordIndex;
    d.webgoodstypeid := ATableView.DataController.Values[aRecIndex, ATableView.GetColumnByFieldName('GOODSTYPEID').Index];

    if (d.ShowModal = mrOK) then
    begin
      q := TIBCSQL.Create(Self);
      try
        q.Transaction := dmDB.IBCTrDefaultUpdate;

        if not q.Transaction.Active then
          q.Transaction.StartTransaction;

        for var I := 0 to ATableView.Controller.SelectedRecordCount - 1 do
        begin
          aRecIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;

          ATableView.DataController.Values[aRecIndex, ATableView.GetColumnByFieldName('PARENTGOODSID').Index] := d.GoodsFolderID;
          ATableView.DataController.Values[aRecIndex, ATableView.GetColumnByFieldName('PARENTGOODS_NAME').Index] := d.GoodsFolderName;
          ATableView.DataController.Post(true);

          q.SQL.Text :=
            'UPDATE VW_TS_PRICELIST_ITEMS SET PARENTGOODSID = :PARENTGOODSID WHERE SUPPLIERID = :CUSTOMERID AND SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE';
          q.ParamByName('PARENTGOODSID').AsInteger := d.GoodsFolderID;
          q.ParamByName('CUSTOMERID').AsInteger := IBCQuerySuppliers.FieldByName('customerid').AsInteger;
          q.ParamByName('SUPPLIER_GOODS_CODE').AsString := ATableView.DataController.Values[aRecIndex, ATableView.GetColumnByFieldName
            ('SUPPLIER_GOODS_CODE').Index];
          q.Execute;

          if q.Transaction.Active then
            q.Transaction.Commit;

        end;
        IBCQueryPriceItems.Refresh;
      finally
        q.Free;
      end;
    end;
  finally
    d.Free;
  end;
end;

procedure Tframe78PriceList.dxBarButton10Click(Sender: TObject);
begin
  CopyNameToModel('SUPPLIER_GOODS_NAME');
end;

procedure Tframe78PriceList.dxBarButton11Click(Sender: TObject);
var
  aRowIndex: Integer;
  d: TfrmPriceManageStringFieldsDlg;
  GoodsCode: string;
  GoodsModel: string;
  I: Integer;
  PLID: Integer;
  SQL: TIBCSQL;
begin
  d := TfrmPriceManageStringFieldsDlg.Create(Self);
  PLID := IBCQueryPriceData.FieldByName('PLID').AsInteger;

  SQL := TIBCSQL.Create(nil);
  SQL.Transaction := dmDB.IBCTrDefaultUpdate;
  SQL.AutoCommit := False;

  SQL.Transaction.StartTransaction;
  SQL.Text :=
    'update TS_PRICELIST_ITEMS set supplier_goods_model = :goodsmodel where supplier_goods_code = :goods_code and plid = :plid';
  SQL.Prepare;
  try
    if (d.ShowModal = mrOK) then
    begin
      for I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
      begin
        aRowIndex := cxGridItemsDBTableView1.ViewData.Records[cxGridItemsDBTableView1.Controller.SelectedRecords[I].Index].RecordIndex;
        GoodsCode := cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE.Index];
        GoodsModel := cxGridItemsDBTableView1.DataController.Values[aRowIndex,
          cxGridItemsDBTableView1_SUPPLIER_GOODS_MODEL.Index];

        // update
        GoodsModel := StringReplace(GoodsModel, d.StringToReplace, '', [rfReplaceALL]);
        SQL.ParamByName('goodsmodel').AsString := trim(GoodsModel);
        SQL.ParamByName('goods_code').AsString := GoodsCode;
        SQL.ParamByName('plid').AsInteger := PLID;
        SQL.Execute;
      end;
      SQL.Transaction.Commit;
    end;
  finally
    SQL.Free;
    d.Free;
  end;
end;

procedure Tframe78PriceList.dxBarButton12Click(Sender: TObject);
begin
  inherited;
  CopyNameToModel('SUPPLIER_GOODS_CODE');
end;

procedure Tframe78PriceList.dxBarButton13Click(Sender: TObject);
var
  aRowIndex: Integer;
  GoodsCode: string;
  Model: string;
  ModelRu: string;
begin
  IBCQueryPriceItems.DisableControls;
  for var I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
  begin
    aRowIndex := cxGridItemsDBTableView1.ViewData.Records[cxGridItemsDBTableView1.Controller.SelectedRecords[I].Index].RecordIndex;
    GoodsCode := cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE.Index];
    Model := trim(cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_CODE.Index]);
    ModelRu := trim(cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_CODE_RU.Index]);

    // update

    cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_CODE_RU.Index] := trim(cxGridItemsDBTableView1.DataController.Values
      [aRowIndex, cxGridItemsDBTableView1_CODE.Index]);
    // IBCQueryPriceItems.Edit;
    // IBCQueryPriceItems.FieldByName('code_ru').AsString := IBCQueryPriceItems.FieldByName('code').AsString;
    // IBCQueryPriceItems.Post;
  end;
  IBCQueryPriceItems.EnableControls;
end;

procedure Tframe78PriceList.ImportMediaMagnatPriceList;
const
  cSupplierID = 121249;
  cApiCode = 'MEDIAMAGNAT';
  cCurrencyMDL = 498;
  cPageSize = 100;
  cMaxPages = 10000;
  cBatchSize = 500;
type
  TMagnatProduct = record
    Sku, Name, Brand, Category, Stock: string;
    PurchasePrice, SalePrice: Currency;
  end;
var
  Http: THTTPClient;
  Products: TList<TMagnatProduct>;
  Seen: TDictionary<string, Boolean>;
  User, Password, BaseUrl: string;
  CategoryID, PLID, ReadCount, NoStock, NoPrice, NoCode, Duplicates: Integer;
  MainForm: TForm;
  WasEnabled: Boolean;
  OldCursor: TCursor;

  function JsonText(AObj: TJSONObject; const AName: string): string;
  var
    V: TJSONValue;
  begin
    V := AObj.GetValue(AName);
    if (V = nil) or (V is TJSONNull) then
      Exit('');
    if not ((V is TJSONString) or (V is TJSONNumber)) then
      raise Exception.CreateFmt('API MEDIAMAGNAT: camp invalid "%s".', [AName]);
    Result := Trim(V.Value);
  end;

  function JsonInt(AObj: TJSONObject; const AName: string): Integer;
  begin
    if not TryStrToInt(JsonText(AObj, AName), Result) then
      raise Exception.CreateFmt('API MEDIAMAGNAT: camp numeric invalid "%s".', [AName]);
  end;

  function CategoryPath(AObj: TJSONObject; const AName: string): string;
  var
    V, Item: TJSONValue;
    Name: string;
  begin
    Result := '';
    V := AObj.GetValue(AName);
    if not (V is TJSONArray) then
      Exit;
    for Item in TJSONArray(V) do
    begin
      if not (Item is TJSONString) then
        raise Exception.Create('API MEDIAMAGNAT: categorie invalida.');
      Name := Trim(Item.Value);
      if Name <> '' then
      begin
        if Result <> '' then
          Result := Result + ' / ';
        Result := Result + Name;
      end;
    end;
  end;

  procedure WaitForApi(AMilliseconds: Cardinal);
  var
    UntilTick, CurrentTick: UInt64;
  begin
    UntilTick := GetTickCount64 + AMilliseconds;
    repeat
      Application.ProcessMessages;
      CurrentTick := GetTickCount64;
      if CurrentTick >= UntilTick then
        Break;
      Sleep(Cardinal(Min(UInt64(50), UntilTick - CurrentTick)));
    until False;
  end;

  procedure ReadConfig;
  var
    Tr: TIBCTransaction;
    Q: TIBCQuery;
    ParamName: string;
  begin
    Tr := TIBCTransaction.Create(nil);
    Q := TIBCQuery.Create(nil);
    try
      Tr.DefaultConnection := dmDB.IBCConnection;
      Tr.IsolationLevel := iblReadOnlyReadCommitted;
      Tr.StartTransaction;
      Q.Connection := dmDB.IBCConnection;
      Q.Transaction := Tr;
      Q.SQL.Text := 'select PARAM_NAME, PARAM_VALUE from TS_API_CONFIG ' +
        'where API_CODE = :API_CODE and FLG_ACTIVE = 1';
      Q.ParamByName('API_CODE').AsString := cApiCode;
      Q.Open;
      while not Q.Eof do
      begin
        ParamName := Trim(Q.FieldByName('PARAM_NAME').AsString);
        if SameText(ParamName, 'USERNAME') then
          User := Trim(Q.FieldByName('PARAM_VALUE').AsString)
        else if SameText(ParamName, 'PASSWORD') then
          Password := Q.FieldByName('PARAM_VALUE').AsString
        else if SameText(ParamName, 'BASE_URL') then
          BaseUrl := Trim(Q.FieldByName('PARAM_VALUE').AsString);
        Q.Next;
      end;
      Q.Close;
      Tr.Commit;
    finally
      Q.Free;
      Tr.Free;
    end;
    if BaseUrl = '' then
      BaseUrl := 'https://api.magnat.md';
    while BaseUrl.EndsWith('/') do
      Delete(BaseUrl, Length(BaseUrl), 1);
    if (User = '') or (Password = '') then
      raise Exception.Create('Lipsesc datele de acces MEDIAMAGNAT.' + sLineBreak +
        'In Setari > Configurari API adaugati USERNAME si PASSWORD, API_CODE = ' + cApiCode +
        ', furnizor 121249; optional BASE_URL = https://api.magnat.md.');
  end;

  procedure EnsureToken(AForce: Boolean); forward;

  // Textul de eroare al serverului (FastAPI: {"detail": "..."})
  function ErrorDetail(const AResponse: IHTTPResponse): string;
  var
    V, D: TJSONValue;
  begin
    Result := Trim(AResponse.ContentAsString(TEncoding.UTF8));
    V := TJSONObject.ParseJSONValue(Result);
    try
      if V is TJSONObject then
      begin
        D := TJSONObject(V).GetValue('detail');
        if D is TJSONString then
          Result := D.Value
        else if Assigned(D) then
          Result := D.ToJSON;
      end;
    finally
      V.Free;
    end;
    if Length(Result) > 300 then
      Result := Copy(Result, 1, 300) + '...';
  end;

  // Retries never turn a temporary 503 into an empty catalog. No DB writes here.
  function RequestJson(const APath: string; ABody: TJSONObject): TJSONObject;
  var
    Source: TStringStream;
    Headers: TNetHeaders;
    Response: IHTTPResponse;
    V: TJSONValue;
    Attempt, WaitSeconds: Integer;
    Renewed: Boolean;
  begin
    Renewed := False;
    for Attempt := 0 to 5 do
    begin
      Headers := [TNetHeader.Create('Accept', 'application/json')];
      if Assigned(ABody) then
      begin
        Headers := Headers + [TNetHeader.Create('Content-Type', 'application/json; charset=UTF-8')];
        Source := TStringStream.Create(ABody.ToJSON, TEncoding.UTF8);
        try
          Response := Http.Post(BaseUrl + APath, Source, nil, Headers);
        finally
          Source.Free;
        end;
      end
      else
      begin
        Headers := Headers + [TNetHeader.Create('Authorization', 'Bearer ' + FMediaMagnatToken)];
        Response := Http.Get(BaseUrl + APath, nil, Headers);
      end;
      if (Response.StatusCode = 401) and not Assigned(ABody) and not Renewed then
      begin
        EnsureToken(True);
        Renewed := True;
        Continue;
      end;
      if (Response.StatusCode = 429) or (Response.StatusCode = 503) then
      begin
        WaitSeconds := StrToIntDef(Response.HeaderValue['Retry-After'], 5);
        if WaitSeconds < 1 then
          WaitSeconds := 1;
        if (Attempt = 5) or (WaitSeconds > 300) then
          raise Exception.CreateFmt('API MEDIAMAGNAT: HTTP %d, catalog temporar indisponibil. ' +
            'Repetati importul peste %d secunde. Nu s-a creat niciun pricelist.',
            [Response.StatusCode, WaitSeconds]);
        dxStatusBar1.SimplePanelStyle.Text := Format('MEDIAMAGNAT: HTTP %d, reincercare peste %d secunde...',
          [Response.StatusCode, WaitSeconds]);
        WaitForApi(Cardinal(WaitSeconds) * 1000);
        Continue;
      end;
      // 401 e identic pentru parola gresita, cont blocat si IP nepermis (documentatia API 1.0.0);
      // 403 = IP-ul nu e in lista permisa a contului
      if (Response.StatusCode = 401) or (Response.StatusCode = 403) then
        raise Exception.CreateFmt('API MEDIAMAGNAT: acces refuzat (HTTP %d: %s).' + sLineBreak + sLineBreak +
          'Serverul nu precizeaza cauza: parola gresita, cont blocat sau adresa IP nepermisa.' + sLineBreak +
          'Verificati USERNAME si PASSWORD in Setari > Configurari API (API_CODE = %s) ' +
          'si cereti furnizorului sa confirme contul si sa permita adresa IP externa a acestui calculator.',
          [Response.StatusCode, ErrorDetail(Response), cApiCode]);
      if Response.StatusCode <> 200 then
        raise Exception.CreateFmt('API MEDIAMAGNAT: HTTP %d %s: %s',
          [Response.StatusCode, Response.StatusText, ErrorDetail(Response)]);
      V := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
      if not (V is TJSONObject) then
      begin
        V.Free;
        raise Exception.Create('API MEDIAMAGNAT: raspuns JSON invalid.');
      end;
      Exit(TJSONObject(V));
    end;
    raise Exception.Create('API MEDIAMAGNAT: numarul de reincercari a fost depasit.');
  end;

  procedure EnsureToken(AForce: Boolean);
  var
    Body, Root: TJSONObject;
    Token: string;
    ExpiresIn: Integer;
  begin
    if not AForce and (FMediaMagnatToken <> '') and (FMediaMagnatTokenUser = User) and
      (FMediaMagnatTokenBaseUrl = BaseUrl) and (GetTickCount64 < FMediaMagnatTokenExpiresAt) then
      Exit;
    FMediaMagnatToken := '';
    FMediaMagnatTokenExpiresAt := 0;
    Body := TJSONObject.Create;
    try
      Body.AddPair('username', User);
      Body.AddPair('password', Password);
      Root := RequestJson('/auth/token', Body);
      try
        Token := JsonText(Root, 'access_token');
        ExpiresIn := JsonInt(Root, 'expires_in');
        if (Token = '') or (ExpiresIn <= 0) then
          raise Exception.Create('API MEDIAMAGNAT: token sau durata de valabilitate invalida.');
        FMediaMagnatToken := Token;
        FMediaMagnatTokenUser := User;
        FMediaMagnatTokenBaseUrl := BaseUrl;
        FMediaMagnatTokenExpiresAt := GetTickCount64 + UInt64(Max(1, ExpiresIn - 60)) * 1000;
      finally
        Root.Free;
      end;
    finally
      Body.Free;
    end;
  end;

  procedure ParseProduct(AObj: TJSONObject);
  var
    P: TMagnatProduct;
    StockStatus: Integer;
    PriceText: string;
  begin
    Inc(ReadCount);
    P := Default(TMagnatProduct);
    P.Sku := JsonText(AObj, 'sku');
    if P.Sku = '' then
    begin
      Inc(NoCode);
      Exit;
    end;
    // Never truncate a supplier key: two distinct SKUs could become identical.
    if Length(P.Sku) > 128 then
      raise Exception.Create('API MEDIAMAGNAT: sku depaseste 128 caractere.');
    StockStatus := JsonInt(AObj, 'stock_status');
    case StockStatus of
      0:
        begin
          Inc(NoStock);
          Exit;
        end;
      1: P.Stock := '<5';
      2: P.Stock := '>=5';
    else
      raise Exception.CreateFmt('API MEDIAMAGNAT: stock_status invalid pentru %s.', [P.Sku]);
    end;
    PriceText := JsonText(AObj, 'merchant_price');
    if PriceText = '' then
    begin
      Inc(NoPrice);
      Exit;
    end;
    if not TryStrToCurr(PriceText, P.PurchasePrice, TFormatSettings.Invariant) then
      raise Exception.CreateFmt('API MEDIAMAGNAT: merchant_price invalid pentru %s.', [P.Sku]);
    if P.PurchasePrice <= 0 then
    begin
      Inc(NoPrice);
      Exit;
    end;
    if not TryStrToCurr(JsonText(AObj, 'sale_price'), P.SalePrice, TFormatSettings.Invariant) or
      (P.SalePrice <= 0) then
      raise Exception.CreateFmt('API MEDIAMAGNAT: sale_price invalid pentru %s.', [P.Sku]);
    if Seen.ContainsKey(P.Sku) then
    begin
      Inc(Duplicates);
      Exit;
    end;
    P.Name := JsonText(AObj, 'name_ro');
    if P.Name = '' then
      P.Name := JsonText(AObj, 'name_ru');
    if P.Name = '' then
      raise Exception.CreateFmt('API MEDIAMAGNAT: denumire lipsa pentru %s.', [P.Sku]);
    P.Brand := JsonText(AObj, 'brand');
    P.Category := CategoryPath(AObj, 'categories_ro');
    if P.Category = '' then
      P.Category := CategoryPath(AObj, 'categories_ru');
    Seen.Add(P.Sku, True);
    Products.Add(P);
  end;

  procedure DownloadCatalog;
  var
    Root: TJSONObject;
    Items, Item: TJSONValue;
    Page, Pages, Total, PerPage, ExpectedPages, ExpectedTotal, ExpectedPerPage: Integer;
  begin
    EnsureToken(False);
    Page := 1;
    ExpectedPages := -1;
    ExpectedTotal := -1;
    ExpectedPerPage := -1;
    repeat
      dxStatusBar1.SimplePanelStyle.Text := Format('MEDIAMAGNAT: descarcare pagina %d...', [Page]);
      Application.ProcessMessages;
      Root := RequestJson(Format('/products?page=%d&per_page=%d', [Page, cPageSize]), nil);
      try
        Pages := JsonInt(Root, 'pages');
        Total := JsonInt(Root, 'total');
        PerPage := JsonInt(Root, 'per_page');
        if (JsonInt(Root, 'page') <> Page) or (Pages < 0) or (Pages > cMaxPages) or
          (Total < 0) or (PerPage < 1) or (PerPage > cPageSize) then
          raise Exception.Create('API MEDIAMAGNAT: paginare invalida; import anulat.');
        if (Total > 0) and ((Pages <> (Int64(Total) + PerPage - 1) div PerPage) or (Page > Pages)) then
          raise Exception.Create('API MEDIAMAGNAT: numar de pagini inconsistent; import anulat.');
        if ExpectedPages < 0 then
        begin
          ExpectedPages := Pages;
          ExpectedTotal := Total;
          ExpectedPerPage := PerPage;
        end
        else if (Pages <> ExpectedPages) or (Total <> ExpectedTotal) or (PerPage <> ExpectedPerPage) then
          raise Exception.Create('API MEDIAMAGNAT: catalog schimbat in timpul descarcarii; repetati importul.');
        Items := Root.GetValue('items');
        if not (Items is TJSONArray) then
          raise Exception.Create('API MEDIAMAGNAT: lipseste lista items.');
        if TJSONArray(Items).Count <> Min(PerPage, Max(0, Total - (Page - 1) * PerPage)) then
          raise Exception.Create('API MEDIAMAGNAT: pagina incompleta; import anulat.');
        for Item in TJSONArray(Items) do
        begin
          if not (Item is TJSONObject) then
            raise Exception.Create('API MEDIAMAGNAT: produs invalid in catalog.');
          ParseProduct(TJSONObject(Item));
        end;
      finally
        Root.Free;
      end;
      Inc(Page);
      if Page <= Pages then
        WaitForApi(550); // below the documented 120 requests/minute
    until Page > Pages;
    if ReadCount <> ExpectedTotal then
      raise Exception.Create('API MEDIAMAGNAT: catalog incomplet; nu s-a creat pricelistul.');
    if Products.Count = 0 then
      raise Exception.CreateFmt('API MEDIAMAGNAT: niciun produs cu stoc si merchant_price. ' +
        'Citite %d, fara stoc %d, fara pret %d, fara cod %d. Nu s-a creat pricelistul.',
        [ReadCount, NoStock, NoPrice, NoCode]);
  end;

  procedure SavePriceList;
  var
    Tr: TIBCTransaction;
    QMaster: TIBCQuery;
    QItem: TIBCSQL;
    P: TMagnatProduct;
    From, N, K: Integer;
  begin
    Tr := TIBCTransaction.Create(nil);
    QMaster := TIBCQuery.Create(nil);
    QItem := TIBCSQL.Create(nil);
    try
      Tr.DefaultConnection := dmDB.IBCConnection;
      Tr.StartTransaction;
      try
        QMaster.Connection := dmDB.IBCConnection;
        QMaster.Transaction := Tr;
        QMaster.AutoCommit := False;
        QMaster.SQL.Text := 'insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, FLAGS, MENTIUNI) ' +
          'values (:SUPPLIERID, :PRICE_CATEGORYID, :FLAGS, :MENTIUNI) returning PLID';
        QMaster.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
        QMaster.ParamByName('PRICE_CATEGORYID').AsInteger := CategoryID;
        QMaster.ParamByName('FLAGS').AsInteger := 2; // FLG_API
        QMaster.ParamByName('MENTIUNI').AsString := 'Import MEDIAMAGNAT API; preturi MDL; stoc estimativ';
        QMaster.Options.ReturnParams := True;
        QMaster.Execute;
        PLID := QMaster.ParamByName('RET_PLID').AsInteger;
        if PLID <= 0 then
          raise Exception.Create('MEDIAMAGNAT: nu s-a obtinut codul pricelistului nou.');

        QItem.Connection := dmDB.IBCConnection;
        QItem.Transaction := Tr;
        QItem.AutoCommit := False;
        QItem.SQL.Text := 'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, ' +
          'SUPPLIER_GOODS_NAME, SUPPLIER_GOODS_BRAND, SUPPLIER_CATEGORY, STOCK_QTY, ' +
          'PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID) ' +
          'values (:PLID, :CODE, :NAME, :BRAND, :CATEGORY, :STOCK, ' +
          ':PRICE0, :CURRENCY0ID, :PRICE3, :CURRENCY3ID, :PRICE7, :CURRENCY7ID)';
        QItem.ParamByName('PLID').DataType := ftInteger;
        QItem.ParamByName('CODE').DataType := ftWideString;
        QItem.ParamByName('NAME').DataType := ftWideString;
        QItem.ParamByName('BRAND').DataType := ftWideString;
        QItem.ParamByName('CATEGORY').DataType := ftWideString;
        QItem.ParamByName('STOCK').DataType := ftWideString;
        QItem.ParamByName('PRICE0').DataType := ftCurrency;
        QItem.ParamByName('PRICE3').DataType := ftCurrency;
        QItem.ParamByName('PRICE7').DataType := ftCurrency;
        QItem.ParamByName('CURRENCY0ID').DataType := ftInteger;
        QItem.ParamByName('CURRENCY3ID').DataType := ftInteger;
        QItem.ParamByName('CURRENCY7ID').DataType := ftInteger;
        From := 0;
        while From < Products.Count do
        begin
          N := Min(cBatchSize, Products.Count - From);
          QItem.Params.ValueCount := N;
          for K := 0 to N - 1 do
          begin
            P := Products[From + K];
            QItem.ParamByName('PLID')[K].AsInteger := PLID;
            QItem.ParamByName('CODE')[K].AsString := P.Sku;
            QItem.ParamByName('NAME')[K].AsString := Copy(P.Name, 1, 2048);
            QItem.ParamByName('BRAND')[K].AsString := Copy(P.Brand, 1, 128);
            // Keep compatibility with databases where DM_VARCHAR512 still allows only 128 characters.
            QItem.ParamByName('CATEGORY')[K].AsString := Copy(P.Category, 1, 128);
            QItem.ParamByName('STOCK')[K].AsString := P.Stock;
            QItem.ParamByName('PRICE0')[K].AsCurrency := P.PurchasePrice;
            QItem.ParamByName('PRICE7')[K].AsCurrency := P.PurchasePrice;
            QItem.ParamByName('PRICE3')[K].AsCurrency := P.SalePrice;
            QItem.ParamByName('CURRENCY0ID')[K].AsInteger := cCurrencyMDL;
            QItem.ParamByName('CURRENCY3ID')[K].AsInteger := cCurrencyMDL;
            QItem.ParamByName('CURRENCY7ID')[K].AsInteger := cCurrencyMDL;
          end;
          QItem.Execute(N);
          Inc(From, N);
        end;
        Tr.Commit;
      except
        if Tr.Active then
          Tr.Rollback;
        raise;
      end;
    finally
      QItem.Free;
      QMaster.Free;
      Tr.Free;
    end;
  end;

begin
  if not IBCQueryPriceCategories.Active or IBCQueryPriceCategories.IsEmpty then
    raise Exception.Create('Selectati categoria de pret inainte de importul MEDIAMAGNAT.');
  CategoryID := IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger;
  if CategoryID <= 0 then
    raise Exception.Create('Selectati o categorie de pret valida pentru MEDIAMAGNAT.');
  ReadCount := 0;
  NoStock := 0;
  NoPrice := 0;
  NoCode := 0;
  Duplicates := 0;
  ReadConfig;
  Http := THTTPClient.Create;
  Products := TList<TMagnatProduct>.Create;
  Seen := TDictionary<string, Boolean>.Create;
  MainForm := Application.MainForm;
  WasEnabled := Assigned(MainForm) and MainForm.Enabled;
  OldCursor := Screen.Cursor;
  try
    Http.ConnectionTimeout := 30000;
    Http.ResponseTimeout := 120000;
    if Assigned(MainForm) then
      MainForm.Enabled := False;
    Screen.Cursor := crHourGlass;
    try
      DownloadCatalog;
      dxStatusBar1.SimplePanelStyle.Text := 'MEDIAMAGNAT: salvare pricelist...';
      SavePriceList;
    finally
      Screen.Cursor := OldCursor;
      if Assigned(MainForm) then
        MainForm.Enabled := WasEnabled;
      dxStatusBar1.SimplePanelStyle.Text := '';
    end;
    IBCQueryPriceData.Refresh;
    IBCQueryPriceData.Locate('PLID', PLID, []);
    MessageDlg(Format('Pricelist MEDIAMAGNAT #%d creat: %d produse (din %d citite).' + sLineBreak +
      'Sarite: fara stoc %d, fara merchant_price %d, fara cod %d, coduri repetate %d.' + sLineBreak +
      'Preturi MDL: PRICE0 = PRICE7 = merchant_price; PRICE3 = sale_price.' + sLineBreak +
      'Stoc estimativ: <5 sau >=5; API-ul nu transmite cantitatea exacta.',
      [PLID, Products.Count, ReadCount, NoStock, NoPrice, NoCode, Duplicates]), mtInformation, [mbOK], 0);
  finally
    Seen.Free;
    Products.Free;
    Http.Free;
  end;
end;

procedure Tframe78PriceList.bbAPISupplierClick(Sender: TObject);
begin
  // MEDIAMAGNAT GRUP S.R.L. - catalog API magnat.md, pricelist nou
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 121249 then
  begin
    try
      ImportMediaMagnatPriceList;
    except
      on E: Exception do
        ShowErrorDialog('Import MEDIAMAGNAT', E.Message);
    end;
    Exit;
  end;

  // Accent
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 198 then
  begin
    var myApiAccent: TApiAccent;
    myApiAccent := TApiAccent.Create(dmdb.IBCConnection, dmdb.GetCurrencyExchangeValue(840, True), false);
    try
      myApiAccent.Connect;
      myApiAccent.GetJSONProducts;
      myApiAccent.ParseJSON;
      myApiAccent.GeneratePriceList(IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger);
      IBCQueryPriceData.Refresh;
    finally
      myApiAccent.Free;
    end;
  end;

  // DMLink: API direct (fara DLL), parsare si scriere in baza pe mai multe fire
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cDMLinkSupplierID then
  begin
    var ImportResult: TDMLinkImportResult;
    var Importer := TDMLinkPriceListImport.Create(dmDB.IBCConnection, cDMLinkSupplierID, 10);
    Importer.OnWait :=
      procedure
      begin
        Application.ProcessMessages;
      end;
    Importer.OnProgress :=
      procedure(AText: string)
      begin
        dxStatusBar1.SimplePanelStyle.Text := AText;
      end;
    // firele de lucru ruleaza cu ProcessMessages - fereastra principala nu primeste clicuri intre timp
    Screen.Cursor := crHourGlass;
    if Assigned(Application.MainForm) then
      Application.MainForm.Enabled := False;
    try
      ImportResult := Importer.Execute;
    finally
      if Assigned(Application.MainForm) then
        Application.MainForm.Enabled := True;
      Screen.Cursor := crDefault;
      dxStatusBar1.SimplePanelStyle.Text := '';
      Importer.Free;
    end;
    IBCQueryPriceData.Refresh;

    var Msg := Format('Pricelist DMLink #%d creat in %.1f s:' + sLineBreak +
      '  produse: %d, descrieri: %d' + sLineBreak +
      '  produse cu imagini: %d (liste de imagini noi/schimbate: %d, %d URL-uri)' + sLineBreak +
      '  descarcare %.1f s, parsare %.1f s (%d fire), salvare %.1f s (%d fire)',
      [ImportResult.PLID, (ImportResult.DownloadMs + ImportResult.ParseMs + ImportResult.SaveMs) / 1000,
       ImportResult.ProductsImported, ImportResult.Descriptions,
       ImportResult.ProductsWithImages, ImportResult.ImagesChanged, ImportResult.ImageRows,
       ImportResult.DownloadMs / 1000, ImportResult.ParseMs / 1000, ImportResult.ParseThreads,
       ImportResult.SaveMs / 1000, ImportResult.DbThreads]);
    if ImportResult.OutOfStockProducts > 0 then
      Msg := Msg + sLineBreak + Format('  sarite fara stoc la DMLink: %d', [ImportResult.OutOfStockProducts]);
    if ImportResult.InvalidProducts > 0 then
      Msg := Msg + sLineBreak + Format('  elemente fara sku / invalide: %d', [ImportResult.InvalidProducts]);
    // DMLink pune uneori acelasi sku (ex. culoarea "Black") la mai multe produse - se sar
    if ImportResult.DuplicateProducts > 0 then
      Msg := Msg + sLineBreak + sLineBreak +
        Format('Sarite %d produse cu cod (sku) repetat in API-ul DMLink:', [ImportResult.DuplicateProducts]) +
        sLineBreak + ImportResult.DuplicateCodes;
    MessageDlg(Msg + sLineBreak + sLineBreak + 'Urmeaza descarcarea imaginilor nedescarcate si ' +
      'copierea lor la produsele legate.', mtInformation, [mbOK], 0);

    // imaginile (PNG in TS_PRICELIST_ITEMS_IMAGES.IMAGE) - doar randurile fara IMAGE, in fire
    TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, ImportResult.PLID);
    // si mai departe in TS_GOODS_IMAGE / TS_GOODS_DSC, la produsele legate fara imagini
    // (estimare + confirmare); pina la 5 oct 2026 pasul era doar butonul separat
    TPriceListContentTransfer.Run(dmDB.IBCConnection, cDMLinkSupplierID, ImportResult.PLID);
  end;

  // Convel
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 229005 then
  begin

  end;

  // OlisGrup
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 251465 then
  begin
    var d := TfrmMuncitorulProgressDlg.Create(self);
    try
      d.PLID := IBCQueryPriceData.FieldByName('PLID').AsInteger;
      d.PriceCategoryID := IBCQueryPriceCategories.FieldByName('price_categoryid').AsInteger;
      d.ShowModal;
      IBCQueryPriceData.Refresh;

      // descrierile RO/RU + URL-urile imaginilor din feed -> TS_PRICELIST_ITEMS_DESCRIPTION / _IMAGES,
      // apoi descarcarea imaginilor si copierea la produsele legate - ca la DMLink
      if d.Imported and (Length(d.Content) > 0) then
      begin
        var ContentStats: TOlisContentStats;
        Screen.Cursor := crHourGlass;
        try
          ContentStats := TOlisGrupContent.Save(dmDB.IBCConnection, d.Content);
        finally
          Screen.Cursor := crDefault;
        end;
        MessageDlg(Format('Pricelist Olis Grup #%d creat.' + sLineBreak +
          '  descrieri RO/RU: %d' + sLineBreak +
          '  produse cu imagini: %d (liste de imagini noi/schimbate: %d, %d URL-uri)',
          [d.PLID, ContentStats.Descriptions, ContentStats.ProductsWithImages,
           ContentStats.ImagesChanged, ContentStats.ImageRows]) + sLineBreak + sLineBreak +
          'Urmeaza descarcarea imaginilor nedescarcate si copierea lor la produsele legate.',
          mtInformation, [mbOK], 0);

        TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, d.PLID, cOlisContentSupplierID,
          'muncitorul.md');
        TPriceListContentTransfer.Run(dmDB.IBCConnection, cOlisContentSupplierID, d.PLID);
      end;
    finally
      d.Free;
    end;

  end;
  // NEXPRIM SERVICE - API NexDistribution: pricelist nou + descrieri RO/RU + imagini
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cNexSupplierID then
  begin
    var NexPLID := 0;
    try
      NexPLID := TNexPriceListImport.Run(dmDB.IBCConnection,
        IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger);
    except
      on E: Exception do
        ShowErrorDialog('Import NexDistribution', E.Message);
    end;
    if NexPLID > 0 then
    begin
      IBCQueryPriceData.Refresh;
      IBCQueryPriceData.Locate('PLID', NexPLID, []);
    end;
  end;

  // TRIOMAC - API SCOP v2 (scop.md/api/partner/v2): pricelist nou din produsele cu stoc, descrieri,
  // imagini (descarcate si copiate la produsele legate in TTriomacPriceListImport.Run)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cTriomacSupplierID then
  begin
    var TriomacPLID := 0;
    try
      TriomacPLID := TTriomacPriceListImport.Run(dmDB.IBCConnection,
        IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger);
    except
      on E: Exception do
        ShowErrorDialog('Import Triomac (SCOP)', E.Message);
    end;
    if TriomacPLID > 0 then
    begin
      IBCQueryPriceData.Refresh;
      IBCQueryPriceData.Locate('PLID', TriomacPLID, []);
    end;
  end;

  // AgroPiese TGR Grup - API angro.agropiese.md: pricelist nou din produsele cu pret engros,
  // caracteristicile RO/RU ca descriere, imaginile (descarcate si copiate la produsele legate
  // in TAgroPiesePriceListImport.Run)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cAgroPieseSupplierID then
  begin
    var AgroPLID := 0;
    try
      AgroPLID := TAgroPiesePriceListImport.Run(dmDB.IBCConnection,
        IBCQueryPriceCategories.FieldByName('PRICE_CATEGORYID').AsInteger);
    except
      on E: Exception do
        ShowErrorDialog('Import AgroPiese (angro.agropiese.md)', E.Message);
    end;
    if AgroPLID > 0 then
    begin
      IBCQueryPriceData.Refresh;
      IBCQueryPriceData.Locate('PLID', AgroPLID, []);
    end;
  end;

  //smartex
  {
    run python
  }


end;


procedure ImportSmartex(Sender: TObject);
var
  ScriptPath, JsonPath: string;
begin
  ScriptPath := 'd:\Projects\MyProjects\WMS\Python\scrape_dulapuri.py';
  JsonPath   := ExtractFilePath(ScriptPath) + 'dulapuri_cu_usa.json';
//  btnImportProducts.Enabled := False;
//  lblStatus.Caption := 'Extracting products from smartex.md...';
  // Run in a background thread so the VCL UI stays responsive
  TThread.CreateAnonymousThread(
    procedure
    var
      Success: Boolean;
    begin
      // Run Python script
      Success := RunPythonScriptAndWait('python.exe', ScriptPath);
      // Synchronize with main UI thread after execution
      TThread.Queue(nil,
        procedure
        begin
//          btnImportProducts.Enabled := True;
          if Success then
          begin
            ReadScrapedJson(JsonPath);
//            lblStatus.Caption := 'Scraping and JSON import completed!';
            ShowMessage('Successfully imported products from JSON.');
          end
          else
          begin
//            lblStatus.Caption := 'Error executing Python script.';
            ShowMessage('Failed to execute python.exe script.');
          end;
        end);
    end
  ).Start;
end;

procedure Tframe78PriceList.dxBarButton15Click(Sender: TObject);
var
  q: TibcSQL;
begin
  var CurrencyID: string;
  if InputQuery('Schimba valuta', 'Codul valutei pentru RRP', CurrencyID) then
  begin
    q := TibcSQL.Create(nil);
    try
      q.Transaction := dmdb.IBCTrDefaultUpdate;
      q.AutoCommit := false;
      q.SQL.Text :=
        'update ts_pricelist_items set currency3id = :currency3id where plid = :plid and SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE';
      q.Prepare;
      IBCQueryPriceItems.First;
      try
        if not q.Transaction.Active then
          q.Transaction.StartTransaction;

        while not IBCQueryPriceItems.Eof do
        begin
          q.ParamByName('currency3id').AsString := CurrencyID;
          q.ParamByName('PLID').Asstring := IBCQueryPriceItems.FieldByName('plid').AsString;
          q.ParamByName('supplier_goods_code').AsString := IBCQueryPriceItems.FieldByName('supplier_goods_code').AsString;
          q.Execute;
          ibcquerypriceitems.next;
        end;

        q.Transaction.Commit;
      except
        begin
          q.Transaction.Rollback;
          raise;
        end;
      end;
    finally
      q.Free;
    end;
  end;
end;

procedure Tframe78PriceList.dxBarButton16Click(Sender: TObject);
var
  ARecordIndex: Integer;
  GoodsID: Integer;
  q: TIBCQuery;
  VendorID: integer;
begin
{ modifica denumirea la produsele selectate}
  q := TIBCQuery.Create(nil);
  try
    q.AutoCommit := false;
    q.Transaction := dmdb.IBCTrDefaultUpdate;
    q.SQL.Text := 'execute procedure update_goods_vendor(:goodsid, :vendorid)';
    if not q.Transaction.Active then
      q.Transaction.StartTransaction;
    q.Prepare;
    for var I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
    begin
      ARecordIndex := cxGridItemsDBTableView1.Controller.SelectedRecords[I].RecordIndex;

      VendorID := cxGridItemsDBTableView1.DataController.Values[ARecordIndex, cxGridItemsDBTableView1_SYSTEM_VENDORID.Index];

      GoodsID := cxGridItemsDBTableView1.DataController.Values[ARecordIndex, cxGridItemsDBTableView1GOODSID.Index];

      q.ParamByName('VENDORID').AsInteger := VendorID;
      q.ParamByName('GOODSID').AsInteger := GoodsID;
      q.Execute;
    end;
    if q.Transaction.Active then
      q.Transaction.Commit;

  finally
    q.Free;
    cxGridItemsDBTableView1.DataController.RefreshExternalData;
  end;
end;

procedure Tframe78PriceList.dxBarButton17Click(Sender: TObject);
var
  q: TIBCSQL;
begin
  if not SWNSecurityManager.IsAdmin then
    exit;

  if MessageDlg('Toate produsele vor fi sterse din nomenclator! Sunteti sigur ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if MessageDlg('Sunteti sigur ca vor fi sterse toate produsele din nomenclator ?', mtConfirmation, [mbYes, mbNo], 0)
      = mrYes then
    begin
      q := TIBCSQL.Create(nil);
      q.Transaction := dmDB.IBCTrDefaultUpdate;
      q.AutoCommit := False;
      q.SQL.Text := 'delete from ts_goods where goodsid = :goodsid';
      q.Prepare;

      if not q.Transaction.Active then
        q.Transaction.StartTransaction;

      cxGridItemsDBTableView1.BeginUpdate;

      for var I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
      begin
        var ARecordIndex := cxGridItemsDBTableView1.Controller.SelectedRecords[I].RecordIndex;

        var GoodsID := cxGridItemsDBTableView1.DataController.Values[ARecordIndex, cxGridItemsDBTableView1GOODSID.Index];
        q.ParamByName('goodsid').AsInteger := GoodsID;
        q.Execute;

//        dmdb.ExecuteQuery('execute procedure DeleteAllGoodsFromCatalog(:plid, :supplierid)', [PLID, SupplierID]);
      end;
      cxGridItemsDBTableView1.EndUpdate;
    end;
end;

procedure Tframe78PriceList.dxBarButton18Click(Sender: TObject);
begin
  inherited;
  var SupplierBrand := IBCQueryPriceItems.FieldByName('SUPPLIER_GOODS_BRAND').AsString;
  if (SupplierBrand <> '') then
  begin
    SetBrandByName(SupplierBrand, IBCQueryPriceItems.fieldbyname('SUPPLIER_GOODS_CODE').AsString, IBCQueryPriceItems.fieldbyname('PLID').AsInteger);
  end;
end;

procedure Tframe78PriceList.dxBarButton1Click(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    if not Query.Transaction.Active then
      Query.Transaction.StartTransaction;

    Query.SQL.Text := 'execute procedure generate_goods_dictionary';
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      on e: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe78PriceList.dxBarButton21Click(Sender: TObject);
//var
//FRunner: TPythonRunner;
//begin
//  inherited;
//  FRunner := TPythonRunner.Create;
//  FRunner.SetPythonDLL('C:\Python\Python313-32\python313.dll');
//
//
//  FRunner.OnOutput  := procedure(const S: string) begin
//    if meLog.Lines.Count = 0 then
//    begin
//      meLog.Lines.Add('Script pornit ✓');
////      ProgressBar.Style := pbstMarquee;
//    end;
//    meLog.Lines.Add(S)
//  end;
//
//  FRunner.OnFinished := procedure(Code: Integer)
//  begin
//    if ExitCode = 0 then
//        Caption := 'Gata ✓'
//      else
//        Caption := 'Eroare (exit code ' + ExitCode.ToString + ')';
//  end;
//  FRunner.Run('d:\scrapers\scraping_uno_by_code.py');

var
  ScriptPath: string;
  WorkDir: string;
  Ret: HINST;
begin
  ScriptPath := 'C:\scrapers\scraping_uno_by_code.py';
  WorkDir := ExtractFilePath(ScriptPath);

  Ret := ShellExecute(Handle, 'open', PChar('C:\Python\Python313-32\python.exe'), PChar('"' + ScriptPath + '"'), PChar(WorkDir),
    SW_SHOW    // schimbă în SW_HIDE dacă nu vrei fereastra consolă
  );

  if Ret <= 32 then
    ShowMessage('Eroare la lansare: ' + SysErrorMessage(Ret))
  else
    meLog.Lines.Add('Script lansat.');
end;

procedure Tframe78PriceList.dxBarButton2Click(Sender: TObject);
var
  dialog: TfrmSendGoodsToPackageDlg;
begin
  dialog := TfrmSendGoodsToPackageDlg.Create(Self);
  try
    dialog.SetGoodsQty(cxGridItemsDBTableView1.Controller.SelectedRecordCount);
    if dialog.ShowModal = mrOK then
    begin
      if SendSelectedGoodsToPackage(dialog.GetOperatorID, GetSelectionIDList(cxGridItemsDBTableView1)) then
        ShowInfoDialog('Transmis cu succes', 'Done!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe78PriceList.dxBarButton4Click(Sender: TObject);
begin
  if not dmDB.IBCTrDefaultUpdate.Active then
    dmDB.IBCTrDefaultUpdate.StartTransaction;
  try
    DoSearchBrandByName;
    dmDB.IBCTrDefaultUpdate.Commit;
  except
    begin
      dmDB.IBCTrDefaultUpdate.Rollback;
      raise;
    end;
  end;
end;

// "Download images": TLoadBombaProductImages (uLoadProductImages) descarca un URL fix de pe bomba.md -
// nu mai e folosit; butonul e ascuns (ivNever), metoda ramine goala - e legata din .dfm.
// Imaginile furnizorilor se aduc prin "Caracteristici si imagini" (bbGoodsPropertiesDownloadClick).
procedure Tframe78PriceList.dxBarButton6Click(Sender: TObject);
//var
//  bmbImages: TLoadBombaProductImages;
begin
//  bmbImages := TLoadBombaProductImages.Create(dmDB.IBCConnection);
//  try
//    bmbImages.LoadImages(IBCQueryPriceItems.FieldByName('GOODSID').AsInteger, IBCQueryPriceItems.FieldByName('SUPPLIER_GOODS_CODE').AsString);
//  finally
//    bmbImages.Free;
//  end;
end;

procedure Tframe78PriceList.dxBarButton7Click(Sender: TObject);
begin
  inherited;
  if MessageDlg(Format('Doriti sa creati un document Reevaluare cu %d produse?', [cxGridItemsDBTableView1.Controller.SelectedRowCount]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    DoCreateReevaluare(FlgImportWithRRP, cxGridItemsDBTableView1, true);
  end;
end;

procedure Tframe78PriceList.dxBarButton9Click(Sender: TObject);
var
  GoodsID: Variant;
  url: string;
  TableView: TcxGridDBTableView;
begin
  TableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
  TableView.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex, TableView.GetColumnByFieldName
    ('GOODSID').index];
  if (not varisnull(TableView.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex, TableView.GetColumnByFieldName
    ('GOODSID').index]) and TableView.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
    TableView.GetColumnByFieldName('GOODSID').index] > 0) then
  begin
    GoodsDescription(TableView.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
      TableView.GetColumnByFieldName('GOODSID').index]);
  end;

end;

procedure Tframe78PriceList.GoodsDescription(AGoodsID: Integer);
var
  dialog: TfrmContentGoodsEditorDlg;
begin
  dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryPriceItems, IBCDataSourcePriceItems);
  try
    dialog.GoodsID := AGoodsID;
    if dialog.ShowModal = mrOK then
    begin

    end;
  finally
    dialog.Free;
  end;

end;

procedure Tframe78PriceList.bbProcessSelectedRecordsClick(Sender: TObject);
begin
  //
end;

procedure Tframe78PriceList.bbSetupGoodsTypeClick(Sender: TObject);
begin
  SetPriceListGoodsTypeID;
end;

procedure Tframe78PriceList.bbShowSettingsClick(Sender: TObject);
begin
  pnMain.Visible := bbShowSettings.Down;
end;

procedure Tframe78PriceList.bbSupplierNewClick(Sender: TObject);
begin
  IBCQueryPriceData.Append;
  try
    IBCQueryPriceData.FieldByName('SUPPLIERID').AsInteger :=  IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
    IBCQueryPriceData.FieldByName('PRICE_CATEGORYID').AsInteger := lcbPriceCategory.EditValue;
    IBCQueryPriceData.Post;
    IBCQueryPriceData.Refresh;
    IBCQueryPriceData.First;
  except
  begin
    IBCQueryPriceData.Cancel;
    raise;
  end;
  end;
end;

procedure Tframe78PriceList.bbToateReevaluarileClick(Sender: TObject);
begin
  dxStatusBar2.Panels[0].Text := 'Reevaluare: Produse noi!';
  cxGridDBTableView1.DataController.RefreshExternalData;
  cxGridDBTableView1.Controller.SelectAllRecords;
  DoCreateReevaluare(FlgImportWithRRP, cxGridDBTableView1, true);

  dxStatusBar2.Panels[0].Text := 'Reevaluare: Produse vechi!';
  cxGrid2DBTableViewOldGoods.DataController.RefreshExternalData;
  cxGrid2DBTableViewOldGoods.Controller.SelectAllRecords;
  DoCreateReevaluare(FlgImportWithRRP, cxGrid2DBTableViewOldGoods, false);

  dxStatusBar2.Panels[0].Text := 'Reevaluare: Produse cu preturi marite!';
  cxGridDBTVPricesUp.DataController.RefreshExternalData;
  cxGridDBTVPricesUp.Controller.SelectAllRecords;
  DoCreateReevaluare(FlgImportWithRRP, cxGridDBTVPricesUp, true);

  dxStatusBar2.Panels[0].Text := 'Reevaluare: Produse cu preturi scazute!';
  cxGridDBTVPricesDown.DataController.RefreshExternalData;
  cxGridDBTVPricesDown.Controller.SelectAllRecords;
  DoCreateReevaluare(FlgImportWithRRP, cxGridDBTVPricesDown, true);

  dxStatusBar2.Panels[0].Text := 'Reevaluare finisata cu succes!';
end;

// "Adauga brand in pricelist": completeaza SYSTEM_VENDORID pentru toate produsele
// din pricelistul curent dupa coloana SUPPLIER_GOODS_BRAND - se cauta (fara litere
// mari/mici, fara spatii la capete) in TS_SYSS, grupa PARENTID = 1 (branduri), dupa TITLE.
// La titluri duplicate se ia SYSSID-ul cel mai mic; rindurile fara potrivire ramin neatinse.
procedure Tframe78PriceList.bbAddBrandToPricelistClick(Sender: TObject);
const
  cBrandMatch = 'select first 1 s.syssid from ts_syss s where s.parentid = 1 ' +
    'and upper(trim(s.title)) = upper(trim(pli.supplier_goods_brand)) order by s.syssid';
var
  q: TIBCSQL;
  PLID, Updated: Integer;
begin
  if (not IBCQueryPriceData.Active) or IBCQueryPriceData.IsEmpty then
    Exit;
  PLID := IBCQueryPriceData.FieldByName('PLID').AsInteger;

  if MessageDlg(Format('Se completeaza "Brandul" (SYSTEM_VENDORID) pentru produsele din pricelistul #%d ' +
    'dupa coloana "Brand furnizor" (cautare in nomenclatorul de branduri dupa denumire).' + sLineBreak +
    'Continuati?', [PLID]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  if IBCQueryPriceItems.Active and (IBCQueryPriceItems.State in dsEditModes) then
    IBCQueryPriceItems.Post;

  q := TIBCSQL.Create(nil);
  try
    q.Transaction := dmDB.IBCTrDefaultUpdate;
    q.AutoCommit := False;
    q.SQL.Text :=
      'update ts_pricelist_items pli set pli.system_vendorid = (' + cBrandMatch + ') ' +
      'where pli.plid = :plid ' +
      'and pli.supplier_goods_brand is not null and trim(pli.supplier_goods_brand) <> '''' ' +
      'and exists (select 1 from ts_syss s where s.parentid = 1 ' +
      '  and upper(trim(s.title)) = upper(trim(pli.supplier_goods_brand))) ' +
      'and coalesce(pli.system_vendorid, 0) <> (' + cBrandMatch + ')';
    q.ParamByName('PLID').AsInteger := PLID;

    if not q.Transaction.Active then
      q.Transaction.StartTransaction;
    try
      Screen.Cursor := crHourGlass;
      try
        q.Execute;
        Updated := q.RowsAffected;
      finally
        Screen.Cursor := crDefault;
      end;
      q.Transaction.Commit;
    except
      if q.Transaction.Active then
        q.Transaction.Rollback;
      raise;
    end;
  finally
    q.Free;
  end;

  if IBCQueryPriceItems.Active then
  begin
    IBCQueryPriceItems.DisableControls;
    try
      IBCQueryPriceItems.Refresh;
    finally
      IBCQueryPriceItems.EnableControls;
    end;
  end;

  MessageDlg(Format('Brandul a fost completat pentru %d produse.', [Updated]), mtInformation, [mbOK], 0);
end;

procedure Tframe78PriceList.bbSetupBrandClick(Sender: TObject);
var
  ARecordIndex: Integer;
  I: Integer;
  syssEditor: TfrmSelectSyssEditorWin;
  q: TIBCSQL;
  SupplierGoodsCode: string;
  TableView: TcxGridDBTableView;
begin
  TableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);

  TableView.DataController.BeginUpdate;
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    syssEditor.SetDefaultGroup(1);
    syssEditor.SelectMode := true;

    if syssEditor.ShowModal = mrOK then
    begin
      q := TIBCSQL.Create(nil);
      q.Transaction := dmDB.IBCTrDefaultUpdate;
      q.AutoCommit := False;
      q.SQL.Text :=
        'update ts_pricelist_items set system_vendorid=:system_vendorID where plid=:plid and supplier_goods_code = :supplier_goods_code';
      q.Prepare;
      try
        if not q.Transaction.Active then
          q.Transaction.StartTransaction;
        try

          for I := 0 to TableView.Controller.SelectedRowCount - 1 do
          begin
            ARecordIndex := TableView.Controller.SelectedRecords[I].RecordIndex;
            SupplierGoodsCode := TableView.DataController.Values[ARecordIndex, TableView.GetColumnByFieldName('SUPPLIER_GOODS_CODE').Index];
            q.ParamByName('SYSTEM_VENDORID').AsInteger := syssEditor.SYSSID;
            q.ParamByName('PLID').AsInteger := IBCQueryPriceData.FieldByName('PLID').AsInteger;
            q.ParamByName('SUPPLIER_GOODS_CODE').AsString := SupplierGoodsCode;
            q.Execute;

            dxStatusBar1.SimplePanelStyle.Text := '[' + I.ToString + '] / [' + TableView.Controller.SelectedRowCount.ToString
              + ']';

            TableView.DataController.Values[ARecordIndex, TableView.GetColumnByFieldName('SYSTEM_VENDOR_NAME').Index] :=
              syssEditor.SyssTitle;
            TableView.DataController.Values[ARecordIndex, TableView.GetColumnByFieldName('SYSTEM_VENDORID').Index] :=
              syssEditor.SYSSID;

            Application.ProcessMessages;
//            cxGridItemsDBTableView1.DataController.Refresh;
          end;
          dxStatusBar1.SimplePanelStyle.Text := 'Commiting...';
                    // if active transaction then commit
          if q.Transaction.Active then
            q.Transaction.Commit;
//          cxGridItemsDBTableView1.DataController.Refresh;
        except
          on e: Exception do
          begin
            e.Create('Produs problematic: ' + SupplierGoodsCode + #13#10 + e.Message);
          end;
        end;
      finally
        q.Free;
        dxStatusBar1.SimplePanelStyle.Text := '';

      end;
    end;
  finally
    syssEditor.Free;
    TableView.DataController.EndUpdate;
  end;
end;

procedure Tframe78PriceList.bbDeleteAllGoodsFromCatalogClick(Sender: TObject);
begin
  if SWNSecurityManager.IsAdmin then
    DeleteAllGoodsFromCatalog(IBCQueryPriceData.FieldByName('PLID').AsInteger, IBCQueryPriceData.FieldByName('SUPPLIERID').AsInteger);
end;

procedure Tframe78PriceList.bbAddSelectedGoodsToCatalogClick(Sender: TObject);
var
  ATableView: TcxGridDBTableView;
  aRowIndex: Integer;
  I: Integer;
  Item: TPriceItemGoodsData;
  Template: TTemplateGoods;
  NewGoodsID: Integer;
  ParentID: Integer;

  // valoarea coloanei din rindul curent; Null daca view-ul nu are coloana
  function Cell(const AFieldName: string): Variant;
  var
    Column: TcxGridDBColumn;
  begin
    Column := ATableView.GetColumnByFieldName(AFieldName);
    if Assigned(Column) then
      Result := ATableView.DataController.Values[aRowIndex, Column.Index]
    else
      Result := Null;
  end;

begin
  // crearea produsului e in PriceGoodsCreateUnit (folosita si de frmAddGoodsfromPrices);
  // produsul-model (mapa, tip web, producator, flag RRP) e GOODSID-ul din clipboard
  ATableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
  Template := Default(TTemplateGoods);
  try
    for I := 0 to ATableView.Controller.SelectedRowCount - 1 do
    begin
      aRowIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;

      // daca este cod produs atunci nu mai generam un produs nou
      if not VarIsNull(Cell('GOODSID')) then
        Continue;

      Item := Default(TPriceItemGoodsData);
      Item.SupplierID := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
      Item.SupplierGoodsCode := VarToStr(Cell('SUPPLIER_GOODS_CODE'));
      Item.SupplierGoodsName := VarToStr(Cell('SUPPLIER_GOODS_NAME'));
      Item.Model := VarToStr(Cell('SUPPLIER_GOODS_MODEL'));
      Item.VendorID := StrToIntDef(VarToStr(Cell('SYSTEM_VENDORID')), -1);
      Item.WebGoodsTypeID := StrToIntDef(VarToStr(Cell('GOODSTYPEID')), -1);
      Item.ParentGoodsID := StrToIntDef(VarToStr(Cell('PARENTGOODSID')), -1);
      if VarIsNumeric(Cell('PRICE3')) then
        Item.Price3 := Cell('PRICE3');
      Item.Currency3ID := StrToIntDef(VarToStr(Cell('CURRENCY3ID')), 0);
      if VarIsNumeric(Cell('PRICE7')) then
        Item.Price7 := Cell('PRICE7');
      Item.Currency7ID := StrToIntDef(VarToStr(Cell('CURRENCY7ID')), 0);

      // modelul se citeste o singura data, la primul rind caruia ii lipseste mapa sau producatorul
      if not Template.Loaded and ((Item.ParentGoodsID <= 0) or (Item.VendorID <= 0)) then
        LoadTemplateGoods(StrToIntDef(Trim(Clipboard.AsText), -1), Item.SupplierID, Template);

      NewGoodsID := CreateGoodsFromPriceItem(Item, Template, ParentID);
      ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('GOODSID').Index] := NewGoodsID;
      AppUserTempConfigStorage.IntValues.SetValue(Self.Name + '_LastGoodsID', ParentID);
    end;
  finally
    if not ATableView.DataController.Filter.Active then
      ATableView.DataController.RefreshExternalData;
  end;
end;

function Tframe78PriceList.SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
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
      Result := true;
    except
      on e: Exception do
      begin
        Query.Transaction.Rollback;
      end;
    end;
  finally
    Query.Free;
  end;
end;

function Tframe78PriceList.GetSelectionIDList(ATable: TcxGridDBTableView): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to ATable.Controller.SelectedRecordCount - 1 do
  begin
    if Result <> '' then
      Result := Result + ',';

    Result := Result + IntToStr(ATable.Controller.SelectedRecords[I].Values[ATable.GetColumnByFieldName('GOODSID').Index]);
  end;
end;

procedure Tframe78PriceList.bbAnalizeClick(Sender: TObject);
begin
  AnalyzePriceList;
end;

procedure Tframe78PriceList.bbChangeGoodsNameClick(Sender: TObject);
var
  ARecordIndex: Integer;
  GoodsID: Integer;
  q: TIBCQuery;
  SupplierGoodsName: string;
begin
{ modifica denumirea la produsele selectate}
  q := TIBCQuery.Create(nil);
  try
    q.AutoCommit := false;
    q.Transaction := dmdb.IBCTrDefaultUpdate;
    q.SQL.Text := 'execute procedure update_goodsname(:goodsid, :goodsname, :supplierid)';
    if not q.Transaction.Active then
      q.Transaction.StartTransaction;
    q.Prepare;
    for var I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
    begin
      ARecordIndex := cxGridItemsDBTableView1.Controller.SelectedRecords[I].RecordIndex;

      SupplierGoodsName := cxGridItemsDBTableView1.DataController.Values[ARecordIndex,
        cxGridItemsDBTableView1_SUPPLIER_GOODS_NAME.Index];

      GoodsID := cxGridItemsDBTableView1.DataController.Values[ARecordIndex, cxGridItemsDBTableView1GOODSID.Index];

      q.ParamByName('goodsname').AsString := SupplierGoodsName;
      q.ParamByName('goodsid').AsInteger := GoodsID;
      q.parambyname('supplierid').AsInteger := IBCQuerySuppliers.FieldByName('customerid').AsInteger;
      q.Execute;
    end;
    if q.Transaction.Active then
      q.Transaction.Commit;

  finally
    q.Free;
  end;
end;

procedure Tframe78PriceList.bbCurrency7Click(Sender: TObject);
var
  q: TibcSQL;
begin
  var CurrencyID: string;
  if InputQuery('Schimba valuta', 'Codul valutei pentru Indicativ', CurrencyID) then
  begin
    q := TibcSQL.Create(nil);
    try
      q.Transaction := dmdb.IBCTrDefaultUpdate;
      q.AutoCommit := false;
      q.SQL.Text :=
        'update ts_pricelist_items set currency7id = :currency7id where plid = :plid and SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE';
      q.Prepare;
      IBCQueryPriceItems.First;
      try
        if not q.Transaction.Active then
          q.Transaction.StartTransaction;

        while not IBCQueryPriceItems.Eof do
        begin
          q.ParamByName('currency7id').AsString := CurrencyID;
          q.ParamByName('PLID').Asstring := IBCQueryPriceItems.FieldByName('plid').AsString;
          q.ParamByName('supplier_goods_code').AsString := IBCQueryPriceItems.FieldByName('supplier_goods_code').AsString;
          q.Execute;
          ibcquerypriceitems.next;
        end;
        if q.Transaction.Active then
          q.Transaction.Commit;
      except
        begin
          q.Transaction.Rollback;
          raise;
        end;
      end;
    finally
      q.Free;
    end;
    IBCQueryPriceItems.Refresh;
  end;
end;

procedure Tframe78PriceList.bbGoodsNewClick(Sender: TObject);
begin
  case pcPricesAnalize.ActivePageIndex of
    0:
      begin
        ShowLinkGoodsDialog(cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
          cxGridItemsDBTableView1_SUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGridItemsDBTableView1.DataController.DataSource.DataSet).RefreshRecord;
      end;
    1:
      begin
        ShowLinkGoodsDialog(cxGridDBTableView1.DataController.Values[cxGridDBTableView1.DataController.FocusedRecordIndex,
          cxGridDBTableView1SUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGridDBTableView1.DataController.DataSource.DataSet).RefreshRecord;
      end;
    2:
      begin
        ShowLinkGoodsDialog(cxGrid2DBTableViewOldGoods.DataController.Values[cxGrid2DBTableViewOldGoods.DataController.FocusedRecordIndex,
          cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGrid2DBTableViewOldGoods.DataController.DataSource.DataSet).RefreshRecord;
      end;
    3:
      begin
        ShowLinkGoodsDialog(cxGridDBTVPricesUp.DataController.Values[cxGridDBTVPricesUp.DataController.FocusedRecordIndex,
          cxGridDBTVPricesUp_SUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGridDBTVPricesUp.DataController.DataSource.DataSet).RefreshRecord;
      end;
    4:
      begin
        ShowLinkGoodsDialog(cxGridDBTVPricesDown.DataController.Values[cxGridDBTVPricesDown.DataController.FocusedRecordIndex,
          cxGridDBTVPricesDownSUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGridDBTVPricesDown.DataController.DataSource.DataSet).RefreshRecord;
      end;
    5:
      begin
        ShowLinkGoodsDialog(cxGridDBTableView2.DataController.Values[cxGridDBTableView2.DataController.FocusedRecordIndex,
          cxGridDB_SUPPLIER_GOODS_NAME.Index]);
        TIBCQuery(cxGridDBTableView2.DataController.DataSource.DataSet).RefreshRecord;
      end;
  end;

//    IBCQueryPriceItems.RefreshRecord;
end;

procedure Tframe78PriceList.bbGoodsPropertiesDownloadClick(Sender: TObject);
begin
  // maximum electronic
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 229873 then
  begin

  end;
  // mamico.md Ad web invest srl
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 315715 then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE pe mamico.md (fallback PRODUCT_LINK):
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, caracteristicile RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TMamicoContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, 315715);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;
  // imperia.md (Imperiul sculelor electrice)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cImperiaSupplierID then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE pe imperia.md (verificat dupa SKU / titlu):
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TImperiaContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cImperiaSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  // DMLink (API): imaginile ramase nedescarcate ale pricelistului curent (si cele de la care a
  // venit doar o parte), apoi copierea la produsele legate - fara import nou
  if (IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cDMLinkSupplierID) and
    IBCQueryPriceData.Active and not IBCQueryPriceData.IsEmpty then
  begin
    TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, IBCQueryPriceData.FieldByName('PLID').AsInteger);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
    TPriceListContentTransfer.Run(dmDB.IBCConnection, cDMLinkSupplierID,
      IBCQueryPriceData.FieldByName('PLID').AsInteger);
  end;

  // Olis Grup (feed muncitorul.md): descrierile si URL-urile imaginilor recitite din feed (ca la
  // import), apoi imaginile nedescarcate si copierea la produsele legate - fara pricelist nou
  if (IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cOlisContentSupplierID) and
    IBCQueryPriceData.Active and not IBCQueryPriceData.IsEmpty then
  begin
    Screen.Cursor := crHourGlass;
    try
      TOlisGrupContent.Save(dmDB.IBCConnection, TOlisGrupContent.LoadFromFeed);
    finally
      Screen.Cursor := crDefault;
    end;
    TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, IBCQueryPriceData.FieldByName('PLID').AsInteger,
      cOlisContentSupplierID, 'muncitorul.md');
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
    TPriceListContentTransfer.Run(dmDB.IBCConnection, cOlisContentSupplierID,
      IBCQueryPriceData.FieldByName('PLID').AsInteger);
  end;

  // AgroPiese TGR Grup (API angro.agropiese.md): caracteristicile RO/RU si URL-urile imaginilor
  // recitite din API pentru tot catalogul (ca la import), apoi imaginile nedescarcate si copierea
  // la produsele legate - fara pricelist nou
  if (IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cAgroPieseSupplierID) and
    IBCQueryPriceData.Active and not IBCQueryPriceData.IsEmpty then
  begin
    Screen.Cursor := crHourGlass;
    try
      try
        TOlisGrupContent.SaveForSupplier(dmDB.IBCConnection, cAgroPieseSupplierID,
          TAgroPiesePriceListImport.LoadContent(dmDB.IBCConnection,
            procedure
            begin
              Application.ProcessMessages;
            end));
      except
        on E: Exception do
        begin
          Screen.Cursor := crDefault;
          ShowErrorDialog('Continut AgroPiese (angro.agropiese.md)', E.Message);
          Exit;
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
    TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, IBCQueryPriceData.FieldByName('PLID').AsInteger,
      cAgroPieseSupplierID, cAgroPieseImageSite);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
    TPriceListContentTransfer.Run(dmDB.IBCConnection, cAgroPieseSupplierID,
      IBCQueryPriceData.FieldByName('PLID').AsInteger);
  end;

  // arvaliscom.md (ARVALISCOM)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cArvaliscomSupplierID then
  begin
    TArvaliscomContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cArvaliscomSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  // filtre.md (LUMEA FILTRELOR)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cFiltreSupplierID then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE pe filtre.md (verificat dupa "Cod produs"):
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TFiltreContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cFiltreSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  // alo.md (MOBILE STOCK SRL) - API-ul JSON ecom.md al site-ului
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cAloSupplierID then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE (cod exact) pe alo.md:
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea + caracteristicile RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TAloContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cAloSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  // pernamea.md (PERNAMEA S.R.L.)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cPernaMeaSupplierID then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE pe pernamea.md (cod exact):
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea + caracteristicile RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TPernaMeaContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cPernaMeaSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  // tina.md (TINA SRL, produse FIRST)
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = cTinaSupplierID then
  begin
    // cauta fiecare articol dupa SUPPLIER_GOODS_CODE pe tina.md (verificat dupa codul produsului):
    // imaginile -> TS_PRICELIST_ITEMS_IMAGES, descrierea RO/RU -> TS_PRICELIST_ITEMS_DESCRIPTION
    TTinaContentLoader.RunForPriceItems(IBCQueryPriceItems, dmDB.IBCConnection, cTinaSupplierID);
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;

  //Teocom lux
  if IBCQuerySuppliers.FieldByName('CustomerID').AsInteger = 74852 then
  begin


    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Refresh;
  end;


end;

// imaginile si descrierile furnizorului (TS_PRICELIST_ITEMS_IMAGES / _DESCRIPTION) ->
// TS_GOODS_IMAGE / TS_GOODS_DSC pentru produsele legate de pricelistul curent; universal,
// pentru orice furnizor - nu suprascrie imaginile si descrierile existente.
// Copierea ia doar rindurile cu blob-ul IMAGE completat. Unele loadere (scripturile Python, ex.
// ronix_tools.py pentru CILITRANS 317185 / PLID 6074) scriu doar IMAGE_URL - fara pasul de mai jos
// butonul raporta "nu este nimic de copiat". Rindurile cu URL si fara IMAGE se descarca intii
// (DownloadImages e universal: URL-urile din tabela, conversie in PNG, inclusiv WebP), apoi se copiaza.
procedure Tframe78PriceList.bbGoodsContentToProductionClick(Sender: TObject);
var
  SupplierID, PLID, Pending: Integer;
  SiteName: string;
  Query: TIBCQuery;
begin
  if not IBCQueryPriceData.Active or IBCQueryPriceData.IsEmpty then
    Exit;
  SupplierID := IBCQueryPriceData.FieldByName('SUPPLIERID').AsInteger;
  PLID := IBCQueryPriceData.FieldByName('PLID').AsInteger;

  // imaginile articolelor din pricelist care au doar adresa, fara continut descarcat
  Pending := 0;
  SiteName := '';
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text :=
      'select count(*), min(x.IMAGE_URL) from TS_PRICELIST_ITEMS_IMAGES x ' +
      'where x.SUPPLIERID = :SUPPLIERID and x.IMAGE is null and coalesce(x.IMAGE_URL, '''') <> '''' ' +
      '  and exists(select 1 from TS_PRICELIST_ITEMS i ' +
      '    where i.PLID = :PLID and i.SUPPLIER_GOODS_CODE = x.SUPPLIER_GOODS_CODE)';
    Query.ParamByName('SUPPLIERID').AsInteger := SupplierID;
    Query.ParamByName('PLID').AsInteger := PLID;
    Query.Open;
    Pending := Query.Fields[0].AsInteger;
    if Pending > 0 then
      try
        SiteName := TURI.Create(Trim(Query.Fields[1].AsString)).Host;
      except
        SiteName := '';
      end;
    Query.Close;
  finally
    Query.Free;
  end;
  if SiteName = '' then
    SiteName := 'site-ul furnizorului';

  if Pending > 0 then
    case MessageDlg(Format('%d imagini ale articolelor din acest pricelist au doar adresa (URL), ' +
      'fara continut descarcat - acestea nu se pot copia la produse.'#13#10#13#10 +
      'Da - descarca imaginile de pe %s (se convertesc in PNG), apoi copiaza la produse'#13#10 +
      'Nu - copiaza doar ce este deja descarcat'#13#10 +
      'Renunta - nu face nimic', [Pending, SiteName]), mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          TDMLinkPriceListImport.DownloadImages(dmDB.IBCConnection, PLID, SupplierID, SiteName);
          if IBCQueryPriceListImages.Active then
            IBCQueryPriceListImages.Refresh;
        end;
      mrCancel:
        Exit;
    end;

  // MOBILE STOCK (alo.md, 17 oct 2026) si TINA SRL (tina.md, 20 oct 2026): imaginile site-ului
  // inlocuiesc imaginile existente ale produselor; la ceilalti furnizori imaginile existente nu se ating
  TPriceListContentTransfer.Run(dmDB.IBCConnection, SupplierID, PLID,
    (SupplierID = cAloSupplierID) or (SupplierID = cTinaSupplierID));
end;

procedure Tframe78PriceList.bbIdentifyBrandClick(Sender: TObject);
begin
  inherited;
  GetBrandID;
end;

procedure Tframe78PriceList.bbInternetSearchClick(Sender: TObject);
var
  url: string;
  TableView: TcxGridDBTableView;
begin
  TableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
  url := 'https://www.google.com/search?q=' + TableView.DataController.Values[TableView.Controller.FocusedRow.RecordIndex,
    TableView.GetColumnByFieldName('SUPPLIER_GOODS_NAME').Index];
  ShellExecute(0, 'open', PChar(UrlDecode(url)), nil, nil, SW_SHOWNORMAL);
end;

function Tframe78PriceList.GetBrandID: Integer;
var
  q: TIBCQuery;
  // I: Integer;
  BrandName: string;
begin
  Result := -1;
  IBCQueryPriceItems.First;
  IBCQueryPriceItems.DisableControls;
  q := TIBCQuery.Create(Self);
  try
    while not IBCQueryPriceItems.Eof do
    begin
      BrandName := IBCQueryPriceItems.FieldByName('BRAND').AsString;
      if BrandName <> '' then
      begin
        dmDB.OpenQuery(q, 'select syssid from ts_syss where upper(title) like ' + QuotedStr('%' + UpperCase(BrandName) +
          '%'), []);
        if q.RecordCount = 1 then
        begin
          IBCQueryPriceItems.Edit;
          IBCQueryPriceItems.FieldByName('brandid').AsInteger := q.FieldByName('SYSSID').AsInteger;
          IBCQueryPriceItems.Post;
        end;
      end;
      IBCQueryPriceItems.Next;
    end;
  finally
    IBCQueryPriceItems.EnableControls;
    q.Free;
  end;
end;

procedure Tframe78PriceList.bbPricelistDeleteClick(Sender: TObject);
begin
  if MessageDlg('Stergeti inregistrarea ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    IBCQueryPriceData.Delete;
end;

procedure Tframe78PriceList.bbPricelistNewClick(Sender: TObject);
var
  dialog: TfrmPriceListImportDlg;
begin
  dialog := TfrmPriceListImportDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.Supplierid := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
    dialog.SupplierName := IBCQuerySuppliers.FieldByName('SUPPLIER_NAME').AsString;
    dialog.PriceCategoryID := lcbPriceCategory.EditValue;
    if (dialog.ShowModal = mrOK) then
    begin
      IBCQueryPriceData.Refresh;
      IBCQueryPriceData.First;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe78PriceList.bbPricePolicyClick(Sender: TObject);
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
    Query.SQL.Add('order by TP.PRICECOLUMN, TP.MIN_VALUE');
    Query.ParamByName('GOODSID').AsInteger := IBCQueryPriceItems.FieldByName('GOODSID').AsInteger;
    Query.Open;

    dialog.PGT_ID := Query.FieldByName('PGT_ID').AsInteger;
    dialog.goodsid := IBCQueryPriceItems.FieldByName('GOODSID').AsInteger;
    dialog.ShowModal;
  finally
    Query.Free;
    dialog.Free;
  end;
end;

procedure Tframe78PriceList.btnUpdatePriceFromDBClick(Sender: TObject);
begin

  IBCQueryPriceItems.DisableControls;
  try
    dmDB.ExecuteQuery('execute procedure sync_pricelist(:plid)', [IBCQueryPriceItems.FieldByName('PLID').AsInteger]);
  finally
    IBCQueryPriceItems.Refresh;
    IBCQueryPriceItems.EnableControls;
  end;
end;

function Tframe78PriceList.CheckGoodsIsFolder(goodsid: Integer): Boolean;
var
  q: TIBCQuery;
begin
  q := TIBCQuery.Create(nil);
  try
    q.SQL.Text := 'select flg_folder from ts_goods where goodsid = :goodsid';
    q.ParamByName('goodsid').AsInteger := goodsid;
    q.Open;
    Result := q.FieldByName('flg_folder').AsInteger = 1;
  finally
    q.Free;
  end;
end;

procedure Tframe78PriceList.ClosePriceAnalizeDataSet;
begin
  IBCQueryNewGoods.Active := False;
  IBCQueryOldGoods.Active := False;
  IBCQueryPricesUp.Active := False;
  IBCQueryPricesDown.Active := False;
end;

procedure Tframe78PriceList.CopyNameToModel(const FieldName: string);
var
  aRowIndex: Integer;
  GoodsCode: string;
  GoodsName: string;
  I: Integer;
  PLID: Integer;
  SQL: TIBCSQL;
begin
  PLID := IBCQueryPriceData.FieldByName('PLID').AsInteger;
  SQL := TIBCSQL.Create(nil);
  SQL.Transaction := dmDB.IBCTrDefaultUpdate;
  SQL.Transaction.StartTransaction;
  SQL.SQL.Text :=
    'UPDATE TS_PRICELIST_ITEMS SET supplier_goods_MODEL = :MODEL WHERE PLID = :PLID AND SUPPLIER_GOODS_CODE = :GOODSCODE';
  SQL.Prepare;
  SQL.AutoCommit := False;
  try
    for I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
    begin
      aRowIndex := cxGridItemsDBTableView1.ViewData.Records[cxGridItemsDBTableView1.Controller.SelectedRecords[I].Index].Index;
      // aRecIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;

      GoodsCode := cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE.Index];
      GoodsName := cxGridItemsDBTableView1.DataController.Values[aRowIndex, cxGridItemsDBTableView1.GetColumnByFieldName
        (FieldName).Index];

      if Pos(#$A, GoodsName, 1) > 1 then
        SQL.ParamByName('model').AsString := copy(GoodsName, 1, MinIntValue([250, Pos(#$A, GoodsName, 1) - 1]))
      else
        SQL.ParamByName('model').AsString := copy(GoodsName, 1, 250);

      SQL.ParamByName('plid').AsInteger := PLID;
      SQL.ParamByName('GoodsCode').AsString := GoodsCode;
      dxStatusBar1.SimplePanelStyle.Text := '[' + I.ToString + '] / [' + cxGridItemsDBTableView1.Controller.SelectedRowCount.ToString
        + ']';
      Application.ProcessMessages;
      SQL.Execute;
    end;

    SQL.Transaction.Commit;
  finally
    dxStatusBar1.SimplePanelStyle.Text := '';
    SQL.Free;
  end;
  cxGridItemsDBTableView1.DataController.RefreshExternalData;
  cxGridItemsDBTableView1.DataController.Refresh;
end;

procedure Tframe78PriceList.cxButton1Click(Sender: TObject);
begin
  FlgImportWithRRP := cbRRP.Checked;
  ActReevaluareExecute(Sender);
end;

procedure Tframe78PriceList.cxButton2Click(Sender: TObject);
begin
  inherited;
  bbToateReevaluarileClick(Sender);
end;

procedure Tframe78PriceList.cxButton4Click(Sender: TObject);
begin
  inherited;
  bbSetEPPClick(Sender);
end;

procedure Tframe78PriceList.cxGrid2DBTableViewOldGoodsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, cxGrid2DBTableViewOldGoods, Key, Shift);
end;

procedure Tframe78PriceList.cxGrid2DBTableViewOldGoodsStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNull(ARecord.Values[cxGrid2DBTableViewOldGoods_GOODSID.Index]) then
    AStyle := dmAdditions.cxStyle_CalcProfit_Red;
end;

procedure Tframe78PriceList.cxGridDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  SWNUtils.ProcessCommonKeys(Self, cxGridDBTableView1, Key, Shift);
end;

procedure Tframe78PriceList.cxGridDBTableView1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNull(ARecord.Values[cxGridDBTableView1GOODSID.Index]) then
    AStyle := dmAdditions.cxStyle_CalcProfit_Red;
end;

procedure Tframe78PriceList.cxGridDBTVPricesUpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  SWNUtils.ProcessCommonKeys(Self, cxGridDBTVPricesUp, Key, Shift);
end;

procedure Tframe78PriceList.cxGridDBTVIncreasePricesStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if VarIsNull(ARecord.Values[cxGridDBTVPricesUp_GOODSID.Index]) then
    AStyle := dmAdditions.cxStyle_CalcProfit_Red;
end;

procedure Tframe78PriceList.cxGridDBTVPricesDownKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  SWNUtils.ProcessCommonKeys(Self, cxGridDBTVPricesDown, Key, Shift);
end;

procedure Tframe78PriceList.cxGridDBTableView3StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if VarIsNull(ARecord.Values[cxGridDBTVPricesDown_GOODSID.Index]) then
    AStyle := dmAdditions.cxStyle_CalcProfit_Red;
end;

procedure Tframe78PriceList.cxGridItemsDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    if (cxGridItemsDBTableView1.Controller.FocusedColumn = cxGridItemsDBTableView1_CODE) then
      IBCQueryPriceItems.Edit;
    IBCQueryPriceItems.FieldByName('CODE_RU').AsString := cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
      cxGridItemsDBTableView1_CODE.Index]
  end;

  SWNUtils.ProcessCommonKeys(Self, cxGridItemsDBTableView1, Key, Shift);

  // IBCQueryPriceItems.RefreshRecord;
end;

procedure Tframe78PriceList.DoAnalizePrice(OldPlid: integer; NewPlid: Integer);
begin
  // Produse noi
  IBCQueryNewGoods.Close;
  IBCQueryNewGoods.ParamByName('SUPPLIERID').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  IBCQueryNewGoods.ParamByName('NEW_PLID').AsInteger := NewPlid;
//  IBCQueryNewGoods.ParamByName('OLD_PLID').AsInteger := OldPlid;
  IBCQueryNewGoods.Open;

  // produse scoase din price
  IBCQueryOldGoods.Close;
//  IBCQueryOldGoods.ParamByName('SUPPLIERID').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  IBCQueryOldGoods.ParamByName('NEW_PLID').AsInteger := NewPlid;
//  IBCQueryOldGoods.ParamByName('OLD_PLID').AsInteger := OldPlid;
  IBCQueryOldGoods.Open;

  // if cxPageControl1.ActivePageIndex = 3 then    // produse cu preturi majorate
  IBCQueryPricesUp.Close;
//    IBCQueryPricesUp.ParamByName('SUPPLIERID').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  IBCQueryPricesUp.ParamByName('NEW_PLID').AsInteger := NewPlid;
//    IBCQueryPricesUp.ParamByName('OLD_PLID').AsInteger := OldPlid;
  IBCQueryPricesUp.Open;

  // if cxPageControl1.ActivePageIndex = 4 then    // produse cu preturi micsorate
  IBCQueryPricesDown.Close;
//    IBCQueryPricesDown.ParamByName('SUPPLIERID').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
//    IBCQueryPricesDown.ParamByName('NEW_PLID').AsInteger := NewPlid;
  IBCQueryPricesDown.ParamByName('new_plid').AsInteger := NewPlid;
  IBCQueryPricesDown.Open;

  IBCQueryNewGoodsSupplier.Close;
  IBCQueryNewGoodsSupplier.ParamByName('NEW_PLID').AsInteger := NewPlid;
  IBCQueryNewGoodsSupplier.ParamByName('OLD_PLID').AsInteger := OldPlid;
  IBCQueryNewGoodsSupplier.Open;
end;

procedure Tframe78PriceList.DoCreateReevaluare(FLG_UseRRP: Boolean; ATableView: TcxGridDBTableView; flg_in_price:
  Boolean = False);
var
  aRecIndex: Integer;
  Barcode: string;
  Brand: string;
  Currency0Index: Integer;
  Currency3Index: Integer;
  currency0id: string;
  Currency3ID: string;
  Currency7Index: Integer;
  currency7id: string;
  CustomerRrpDiscount: Double;
  goodsid: Integer;
  GOODSTYPENAME: string;
  I: Integer;
  Model: string;
  price0: double;
  price3: double;
  Price7: double;
  DOCID: Integer;
  FlgEppIndex: Integer;
  FLG_EPP: Integer;
  FLG_EPPIndex: Integer;
  GoodsIDIndex: Integer;
  GoodsName: string;
  Price0Index: Integer;
  Price3Index: Integer;
  Price7Index: Integer;
  q: TIBCQuery;
  supplier_goods_code: string;
begin
  meLog.Lines.Clear;
  if not dmDB.IBCTrDefaultUpdate.Active then
    dmDB.IBCTrDefaultUpdate.StartTransaction;
  try
    GoodsIDIndex := GetGoodsIDFieldIndex(ATableView);
    price0 := 0;

    // Price0Index := -1;
    Price0Index := GetGoodsPrice0Index(ATableView);
    Currency0Index := GetGoodsCurrency0Index(ATableView);

    price3 := 0;
    Price3Index := GetGoodsPrice3Index(ATableView);
    Currency3Index := GetGoodsCurrency3Index(ATableView);

    Price7 := 0;
    Price7Index := GetGoodsPrice7Index(ATableView);
    Currency7Index := GetGoodsCurrency7idIndex(ATableView);

    DOCID := AddDocumentReeveluare(dmDB.IBCTrDefaultUpdate);

    goodsid := -1;
    for I := 0 to ATableView.Controller.SelectedRowCount - 1 do
    begin
      aRecIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;
      if assigned(ATableView.GetColumnByFieldName('FLG_EPP')) then
        FLG_EPPIndex := ATableView.GetColumnByFieldName('FLG_EPP').Index
      else
        FLG_EPPIndex := -1;

      if FLG_EPPIndex >= 0 then
        FLG_UseRRP := ATableView.DataController.Values[aRecIndex, FLG_EPPIndex]
      else
        FLG_UseRRP := False;

      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, GoodsIDIndex]) then
        goodsid := ATableView.DataController.Values[aRecIndex, GoodsIDIndex];

      price3 := 0;
      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price3Index]) then
        price3 := ATableView.DataController.Values[aRecIndex, Price3Index];

      Price7 := 0;
      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price7Index]) and (ATableView.Controller.SelectedRecords
        [I].Values[Price7Index] <> 0) then
        Price7 := ATableView.DataController.Values[aRecIndex, Price7Index];

      // Furnizorul nu da pret indicativ pentru pozitia asta (ex. Ultra: produse
      // cu pret retail, fara pretul 'd'). Singurul reper ramane RRP-ul din
      // pricelist, deci fortam modul EPP ca pretul de vinzare sa se calculeze din el.
      if (Price7 = 0) and (price3 > 0) then
        FLG_UseRRP := True;

      if (FLG_UseRRP or not VarIsNull(ATableView.DataController.Values[aRecIndex, Currency3Index])) then
        Currency3ID := ATableView.DataController.Values[aRecIndex, Currency3Index];

      if (FLG_UseRRP) and (price3 = 0) then
      begin
        FLG_UseRRP := False;
        meLog.Lines.Add(Format('[%s] - Produsul %d este cu RRP, dar pricelistul nu are RRP - se scoate RRP-ul (FLG_EPP = 0, PRICE3 = 0)',
          [FormatDateTime('yyyy/mm/dd hh:nn:ss', now), goodsid]));
      end;

      // fara pret indicativ si fara RRP nu ramine nicio baza pentru pretul de vinzare
      if (Price7 = 0) and (price3 = 0) then
      begin
        meLog.Lines.Add(Format('[%s] - Produsul %d nu are in pricelist nici pret indicativ, nici RRP - nu intra in reevaluare',
          [FormatDateTime('yyyy/mm/dd hh:nn:ss', now), goodsid]));
        Continue;
      end;

      if not Variants.VarIsNull(ATableView.DataController.Values[aRecIndex, Currency7Index]) then
        currency7id := ATableView.DataController.Values[aRecIndex, Currency7Index];

      price0 := 0;
      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price0Index]) and (ATableView.DataController.Values[aRecIndex,
        Price0Index] <> 0) then
      begin
        price0 := ATableView.DataController.Values[aRecIndex, Price0Index];
      end;

      if (Price7 = 0) and FLG_UseRRP then
        // pozitie fara pret indicativ: valuta 7 nu vine din pricelist, luam valuta RRP
        currency7id := iif(Currency3ID = '', '840', Currency3ID)
      else if (currency7id = '') then
        raise Exception.create('Valuta 7 nu este setata');

      currency0id := iif(currency7id = '', Currency3ID, currency7id);

            // trunc name until $10 (ultra price)
      if not (VarIsNull(ATableView.DataController.Values[aRecIndex, cxGridDBTableView1SUPPLIER_GOODS_NAME.Index])) then
      begin
        GoodsName := ATableView.DataController.Values[aRecIndex, cxGridDBTableView1SUPPLIER_GOODS_NAME.Index];
        if (Pos(#10, GoodsName, 1) > 0) then
          GoodsName := copy(GoodsName, 1, Pos(#10, GoodsName, 1) - 1);
      end;

      supplier_goods_code := ATableView.DataController.Values[aRecIndex, ATableView.GetColumnByFieldName('SUPPLIER_GOODS_CODE').Index];

      if (Currency3ID = '') then
        Currency3ID := '498';

      if (Price7 > 0) then
      begin
        // produsul pe RRP fara RRP in pricelist intra fara RRP (vezi mesajul de mai sus)
        AddRecordToReevaluare(dmDB.IBCTrDefaultUpdate, DOCID, goodsid, IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger,
          supplier_goods_code, price0, currency0id.ToInteger, price3, Currency3ID.ToInteger, Price7, StrToIntDef(currency7id,
          498), GoodsName, Barcode, flg_in_price, FLG_UseRRP);
      end
      else
        AddRecordToReevaluareVinzare(dmDB.IBCTrDefaultUpdate, DOCID, goodsid, IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger,
          supplier_goods_code, price0, StrToIntDef(currency0id, 840), price3, Currency3ID.ToInteger, GoodsName, Barcode,
          flg_in_price, FLG_UseRRP);
    end;

    try
      if dmDB.IBCTrDefaultUpdate.Active then
        dmDB.IBCTrDefaultUpdate.Commit;

//            MessageDlg('Reevaluarea creata cu succes!', mtInformation, [mbOK], 0);
    except
      on e: Exception do
      begin
        MessageDlg(e.Message, mtError, [mbOK], 0);

        if dmDB.IBCTrDefaultUpdate.Active then
          dmDB.IBCTrDefaultUpdate.Rollback;
      end;
    end;


     // micsorarea preturilui recomandat cu 1 % automat, exceptie accent
    var qq := TIBCQuery.Create(nil);
    CustomerRrpDiscount := 0;
    try
      qq.SQL.Text := 'select rrp_discount from ts_customer where customerid = :customerid';
      qq.ParamByName('customerid').AsInteger := IBCDataSourceSuppliers.DataSet.FieldByName('CUSTOMERID').AsInteger;
      qq.Open;
      CustomerRrpDiscount := qq.FieldByName('rrp_discount').AsFloat;
    finally
      qq.Free;
    end;

    dmDB.ExecuteQuery('EXECUTE PROCEDURE ADJUST_RRP_REEVALUATION(:DOCID, :PERCENT)', [DOCID, CustomerRrpDiscount]);
    dmDB.ExecuteQuery('execute procedure close_reevaluare(:docid)', [DOCID]);
  except
    if dmDB.IBCTrDefaultUpdate.Active then
      dmDB.IBCTrDefaultUpdate.Rollback;
    raise;
  end;
end;

procedure Tframe78PriceList.DoSearchBrandByName;
var
  I: Integer;
  q: TIBCQuery;
  SupplierGoodsName: string;
  qq: TIBCQuery;
begin
  q := TIBCQuery.Create(Self);
  qq := TIBCQuery.Create(Self);
  qq.Transaction := dmDB.IBCTrDefaultUpdate;

  try
    for I := 0 to cxGridItemsDBTableView1.Controller.SelectedRowCount - 1 do
    begin
      SupplierGoodsName := cxGridItemsDBTableView1.Controller.SelectedRecords[I].Values[cxGridItemsDBTableView1_SUPPLIER_GOODS_NAME.Index];
      q.SQL.Text := 'select brandid, brandname from FindBrandFromGoodsName(:brandname)';
      q.ParamByName('brandname').AsString := SupplierGoodsName;
      q.Open;
      if q.RecordCount = 1 then
      begin

        qq.SQL.Text :=
          'update TS_PRICELIST_ITEMS set brand = :brandname, vendorid = :vendorid where supplier_goods_code = :supplier_goods_code and plid = :plid';
        qq.ParamByName('plid').AsInteger := IBCQueryPriceItems.FieldByName('plid').AsInteger;
        qq.ParamByName('brandname').AsString := q.FieldByName('brandname').AsString;
        qq.ParamByName('vendorid').AsInteger := q.FieldByName('brandid').AsInteger;
        qq.ParamByName('supplier_goods_code').AsString := cxGridItemsDBTableView1.Controller.SelectedRecords[I].Values[cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE.Index];
        qq.Execute;

        cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.Controller.SelectedRows[I].Index,
          cxGridItemsDBTableView1_SYSTEM_VENDORID.Index] := q.FieldByName('brandid').AsInteger;
      end;

    end;
  finally
    q.Free;
    qq.Free;
  end;
end;

procedure Tframe78PriceList.bbSetEPPClick(Sender: TObject);
var
  ARecordIndex: Integer;
  flg_epp: string;
  I: Integer;
  q: TIBCSQL;
  SupplierGoodsCode: string;
begin
  if MessageDlg('Doriti sa modificati RRP pentru produsele selectte?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    q := TIBCSQL.Create(nil);
    q.Transaction := dmDB.IBCTrDefaultUpdate;
    q.AutoCommit := False;

    flg_epp := '0';
    InputQuery('Schimba FLG_EPP', 'Introduceri valoare flg_epp (0/1)', flg_epp);
    q.SQL.Text :=
      'update vw_ts_pricelist_items set flg_epp = :flg_epp where plid=:plid and supplier_goods_code = :supplier_goods_code';
    q.ParamByName('plid').AsInteger := IBCQueryPriceData.FieldByName('PLID').AsInteger;
    q.ParamByName('flg_epp').AsString := flg_epp;
    q.Prepare;
    var TableView: TcxGridDBTableView;
    TableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
    try
      if not q.Transaction.Active then
        q.Transaction.StartTransaction;
      try
        for I := 0 to TableView.Controller.SelectedRowCount - 1 do
        begin
          ARecordIndex := TableView.Controller.SelectedRecords[I].RecordIndex;

          SupplierGoodsCode := TableView.DataController.Values[ARecordIndex, TableView.GetColumnByFieldName('SUPPLIER_GOODS_CODE').Index];

          q.ParamByName('supplier_goods_code').AsString := SupplierGoodsCode;
          q.Execute;

          dxStatusBar1.SimplePanelStyle.Text := '[' + I.ToString + '] / [' + TableView.Controller.SelectedRowCount.ToString + ']';
          Application.ProcessMessages;

        end;
        q.Transaction.Commit;
      except
        on e: Exception do
        begin
          e.Create('Produs problematic: ' + SupplierGoodsCode + #13#10 + e.Message);
        end;
      end;
    finally
      q.Free;
      dxStatusBar1.SimplePanelStyle.Text := '';
      TableView.DataController.RefreshExternalData;
    end;
  end;
end;

procedure Tframe78PriceList.btnAnalizaReevaluareClick(Sender: TObject);
begin
  DoAnalizePrice(IBCQueryPriceToCompare.FieldByName('PLID').AsInteger, IBCQueryPriceData.FieldByName('PLID').AsInteger);
  bbToateReevaluarileClick(Sender);
  ibcquerypricedata.Edit;
  IBCQUERYPRICEDATA.FieldByName('flg_done').AsInteger := 1;
  IBCQueryPriceData.post;
end;

procedure Tframe78PriceList.cxGridDBTableView2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//    if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
//    begin
//        if (cxGridItemsDBTableView1.Controller.FocusedColumn = cxGridItemsDBTableView1_CODE) then
//            IBCQueryPriceItems.Edit;
//        IBCQueryPriceItems.FieldByName('CODE_RU').AsString := cxGridItemsDBTableView1.DataController.Values[cxGridItemsDBTableView1.DataController.FocusedRecordIndex,
//            cxGridItemsDBTableView1_CODE.Index]
//    end;

  SWNUtils.ProcessCommonKeys(Self, cxGridDBTableView2, Key, Shift);
end;

procedure Tframe78PriceList.cxGridDBTableView2StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if VarIsNull(ARecord.Values[cxGridDBTableView2GOODSID.Index]) then
    AStyle := dmAdditions.cxStyle_CalcProfit_Red;

end;

procedure Tframe78PriceList.cxGridItemsDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  ValoareID: Variant;
  IndexColoana: Integer;
  V: Variant;
begin
    // Obținem indexul coloanei GOODSID
  IndexColoana := cxGridItemsDBTableView1GOODSID.Index;

    // Obținem valoarea din rândul curent
  ValoareID := AViewInfo.GridRecord.Values[IndexColoana];

  if VarIsNull(ValoareID) then
  begin
        // Aici modifici direct canvas-ul de desenare
    ACanvas.Font.Color := clRed;

        // Opțional: Poți face și Bold
        // ACanvas.Font.Style := [fsBold];
  end;

// 1. Verificăm dacă suntem pe coloana corectă
  // În CustomDrawCell folosim AViewInfo.Item
  if (AViewInfo.Item <> nil) and (AViewInfo.Item.Index = DupFieldIndex) and (DupList <> nil) then
  begin
    // 2. Obținem valoarea din rândul curent
    // Folosim AViewInfo.GridRecord în loc de ARecord
    V := AViewInfo.GridRecord.Values[DupFieldIndex];

    // 3. Verificarea logicii (identică cu cea veche)
    if not VarIsNull(V) and (DupList.IndexOf(VarToStr(V)) <> -1) then
    begin
      // 4. APLICAREA STILULUI MANUAL
      // Aici nu putem scrie "AStyle := cxStyle1", trebuie să setăm Canvas-ul.

      // Dacă cxStyle1 schimbă culoarea de FUNDAL:
      ACanvas.Brush.Color := clRed;

      // Dacă cxStyle1 schimbă culoarea TEXTULUI sau Fontul:
      ACanvas.Font.Color := clBlack;
    end;
  end;
end;

procedure Tframe78PriceList.DeleteAllGoodsFromCatalog(PLID, SupplierID: Integer);
begin
   // delete all goods from ts_goods_foreign is no more link then delete from ts_goods;
  if MessageDlg('Toate produsele vor fi sterse din nomenclator! Sunteti sigur ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if MessageDlg('Sunteti sigur ca vor fi sterse toate produsele din nomenclator ?', mtConfirmation, [mbYes, mbNo], 0)
      = mrYes then
      dmdb.ExecuteQuery('execute procedure DeleteAllGoodsFromCatalog(:plid, :supplierid)', [PLID, SupplierID]);
end;

procedure Tframe78PriceList.dxBarButton19Click(Sender: TObject);
begin
  cxButton1Click(Sender);
end;

function Tframe78PriceList.GetActiveTableView(ActivePageIndex: Integer): TcxGridDBTableView;
begin
  Result := nil;
  case ActivePageIndex of
    0:
      Result := cxGridItemsDBTableView1;
    1:
      Result := cxGridDBTableView1;
    2:
      Result := cxGrid2DBTableViewOldGoods;
    3:
      Result := cxGridDBTVPricesUp;
    4:
      Result := cxGridDBTVPricesDown;
    5:
      Result := cxGridDBTableView2;
  end;

end;

function Tframe78PriceList.GetBestMatchParentGoodsID(const webgoodstypeid: Integer; out fBestMatchParentGoodsID: Integer):
  Boolean;
var
  q: TIBCQuery;
begin
  Result := False;
  q := TIBCQuery.Create(nil);
  try
    q.SQL.Add('select distinct gt.goodstypeid, g.parentid, gg.parentid pparentid, gg.title from ts_goods g');
    q.SQL.Add('join ts_goods gg on (gg.goodsid = g.parentid) and (g.flg_folder = 0)');
    q.SQL.Add('join TS_GOODS_TYPE gt on gt.goodstypeid = g.webgoodstype_id  and gt.goodstypeid = :webgoodstypeid');
    q.ParamByName('webgoodstypeid').AsInteger := webgoodstypeid;
    q.Open;
    if q.RecordCount > 0 then
    begin
      fBestMatchParentGoodsID := q.FieldByName('GOODSID').AsInteger;
      Result := true;
    end;
  finally
    q.Free;
  end;

end;

function Tframe78PriceList.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsPriceList];
end;

function Tframe78PriceList.GetFilterFields: TFrameFilterFields;
begin
  Result := [];
end;

function Tframe78PriceList.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

function Tframe78PriceList.GetGoodsCurrency0Index(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;
  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;
  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;
  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY7ID').Index;
  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY7ID').Index;
end;

function Tframe78PriceList.GetGoodsCurrency3Index(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY3ID').Index;
  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY3ID').Index;
  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('CURRENCY3ID').Index;
  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY3ID').Index;
  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY3ID').Index;
end;

function Tframe78PriceList.GetGoodsCurrency7idIndex(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;

  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;

  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('CURRENCY7ID').Index;

  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY7ID').Index;

  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_CURRENCY7ID').Index;
end;

function Tframe78PriceList.GetGoodsIDFieldIndex(ATableView: TcxGridDBTableView): Integer;
var
  column: TcxGridDBColumn;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
  begin
    column := ATableView.GetColumnByFieldName('GOODSID');
    if Assigned(column) then
      Result := ATableView.GetColumnByFieldName('GOODSID').Index;
  end
  else if ATableView.Name = 'cxGridDBTableView1' then
  begin
    column := ATableView.GetColumnByFieldName('goodsid');
    if Assigned(column) then
      Result := ATableView.GetColumnByFieldName('goodsid').Index;
  end
  else if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
  begin
    column := ATableView.GetColumnByFieldName('goodsid');
    if Assigned(column) then
      Result := ATableView.GetColumnByFieldName('goodsid').Index;
  end
  else if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
  begin
    column := ATableView.GetColumnByFieldName('GOODSID');
    if Assigned(column) then
      Result := ATableView.GetColumnByFieldName('goodsid').Index;
  end
  else if ATableView.Name = 'cxGridDBTVPricesDown' then
  begin
    column := ATableView.GetColumnByFieldName('goodsid');
    if Assigned(column) then
      Result := ATableView.GetColumnByFieldName('goodsid').Index;
  end;
end;

function Tframe78PriceList.GetGoodsPrice0Index(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE0').Index;
  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE0').Index;
  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE0').Index;
  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE0').Index;
  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE0').Index;
end;

function Tframe78PriceList.GetGoodsPrice3Index(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE3').Index;
  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE3').Index;
  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE3').Index;
  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE3').Index;
  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE3').Index;
end;

function Tframe78PriceList.GetGoodsPrice7Index(ATableView: TcxGridDBTableView): Integer;
begin
  Result := -1;
  if ATableView.Name = 'cxGridItemsDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE7').Index;

  if ATableView.Name = 'cxGridDBTableView1' then
    Result := ATableView.GetColumnByFieldName('PRICE7').Index;

  if ATableView.Name = 'cxGrid2DBTableViewOldGoods' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE7').Index;

  if CompareText(ATableView.Name, 'cxGridDBTVPricesUp') = 0 then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE7').Index;

  if ATableView.Name = 'cxGridDBTVPricesDown' then
    Result := ATableView.GetColumnByFieldName('NEW_PRICE7').Index;
end;

function Tframe78PriceList.GetRRPFlag(GoodsID, SupplierID: Integer): Integer;
begin
  Result := -1;
  var q := TIBCQuery.Create(nil);

  try
    q.sql.text :=
      'select get_flg_value(flags, 4) rrp_flag from ts_goods_foreign where customerid = :supplierid and goodsid = :goodsid';
    q.ParamByName('supplierid').AsInteger := SupplierID;
    q.ParamByName('goodsid').Asinteger := GoodsID;
    q.open;

    Result := q.fieldbyname('rrp_flag').AsInteger;
  finally
    q.Free;
  end;
    // TODO -cMM: Tframe78PriceList.GetRRPFlag default body inserted
end;

function Tframe78PriceList.InitFrameID: Integer;
begin
  Result := 78; // PriceList
  LastSupplierID := -1;
  LastPriceCategoryID := -1;

end;

procedure Tframe78PriceList.lcbCompareWithPricePropertiesInitPopup(Sender: TObject);
begin
  inherited;

  IBCQueryPriceToCompare.Active := False;
  IBCQueryPriceToCompare.ParamByName('supplierid').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  IBCQueryPriceToCompare.ParamByName('price_categoryid').AsInteger := lcbPriceCategory.EditValue;
  IBCQueryPriceToCompare.ParamByName('plid').AsInteger := IBCQueryPriceData.FieldByName('PLID').AsInteger;
  IBCQueryPriceToCompare.Active := true;

end;

procedure Tframe78PriceList.lcbPriceCategoryPropertiesChange(Sender: TObject);
begin
  inherited;
  OpenPriceList;
  pcPricesAnalize.ActivePage := tsAllPriceGoods;
  if Assigned(DupList) then
    DupList.Free;
  DupList := TStringList.Create;

  DupFieldIndex := cxGridItemsDBTableView1_SUPPLIER_GOODS_CODE.Index;
  InitArrayCont(cxGridItemsDBTableView1, DupFieldIndex, DupList);
end;

procedure Tframe78PriceList.OpenPriceList;
begin
  IBCQueryPriceData.Close;
  IBCQueryPriceData.ParamByName('supplierid').AsInteger := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
  IBCQueryPriceData.ParamByName('price_categoryid').AsInteger := lcbPriceCategory.EditValue;

  if not varisnull(lcbPriceCategory.EditValue) then
    IBCQueryPriceData.Open;

  IBCQueryPriceItems.Open;
  UpdatePriceListImagesQuery;
end;

// Imaginile pozitiei (TS_PRICELIST_ITEMS_IMAGES) se citesc doar cind fila lor e deschisa: interogarea
// e legata de fiecare pozitie selectata, iar la NexDistribution o pozitie are zeci de MB de imagini
// (PNG-uri de 3213x5712) - deschiderea pricelistului dura peste 10 s.
// Lista imaginilor (IBCQueryPriceListImages) nu citeste blob-ul; imaginea afisata vine din
// IBCQueryPriceListImageBlob (detaliu pe IMAGE_URL), deci se aduce doar cea selectata.
// Nu DeferredBlobRead: conexiunea e in DisconnectedMode si inchide tranzactia dupa Open, iar
// citirea amanata a blob-ului dadea "invalid transaction handle" (17 oct 2026, MOBILE STOCK).
procedure Tframe78PriceList.UpdatePriceListImagesQuery;
begin
  if cxPageControl2.ActivePage = cxTabSheet2 then
  begin
    if IBCQueryPriceItems.Active and not IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Open;
    if IBCQueryPriceListImages.Active and not IBCQueryPriceListImageBlob.Active then
      IBCQueryPriceListImageBlob.Open;
  end
  else
  begin
    if IBCQueryPriceListImageBlob.Active then
      IBCQueryPriceListImageBlob.Close;
    if IBCQueryPriceListImages.Active then
      IBCQueryPriceListImages.Close;
  end;
end;

procedure Tframe78PriceList.cxPageControl2Change(Sender: TObject);
begin
  if csLoading in ComponentState then
    Exit;
  UpdatePriceListImagesQuery;
end;

procedure Tframe78PriceList.pcPricesAnalizePageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
//    bbSetupBrand.Enabled := (NewPage.TabIndex = 0);
//    bbSetupGoodsType.Enabled := (NewPage.TabIndex = 0);
//    bbAddSelectedGoodsToCatalog.Enabled := (NewPage.TabIndex = 0);
//    bbSetParentID.Enabled := (NewPage.TabIndex = 0);
  bbSetEPP.Enabled := (NewPage.TabIndex < 5);
end;

procedure Tframe78PriceList.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridItemsDBTableView1);
    ReadGridColumnsSettings(cxGridDBTableView1);
    ReadGridColumnsSettings(cxGrid2DBTableViewOldGoods);
    ReadGridColumnsSettings(cxGridDBTVPricesUp);
    ReadGridColumnsSettings(cxGridDBTVPricesDown);
    ReadGridColumnsSettings(cxGridDBTableView2);

    LastSupplierID := AppUserConfigStorage.IntValues.GetValue('LastSupplierID');
    LastPriceCategoryID := AppUserConfigStorage.IntValues.GetValue('LastPriceCategoryID');

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe78PriceList.RefreshData;
begin
  if IBCQueryPriceItems.Active then
    IBCQueryPriceItems.Refresh;
  if IBCQueryNewGoods.Active then
    IBCQueryNewGoods.Refresh;
  if IBCQueryOldGoods.Active then
    IBCQueryOldGoods.Refresh;
  if IBCQueryPricesUp.Active then
    IBCQueryPricesUp.Refresh;
  if IBCQueryPricesDown.Active then
    IBCQueryPricesDown.Refresh;
  if IBCQueryNewGoodsSupplier.Active then
    IBCQueryNewGoodsSupplier.Refresh;

end;

procedure Tframe78PriceList.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridItemsDBTableView1);
    SaveGridColumnsSettings(cxGridDBTableView1);
    SaveGridColumnsSettings(cxGrid2DBTableViewOldGoods);
    SaveGridColumnsSettings(cxGridDBTVPricesUp);
    SaveGridColumnsSettings(cxGridDBTVPricesDown);
    SaveGridColumnsSettings(cxGridDBTableView2);

    AppUserConfigStorage.IntValues.SetValue('LastSupplierID', LastSupplierID);
    AppUserConfigStorage.IntValues.SetValue('LastPriceCategoryID', LastPriceCategoryID);

  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

function Tframe78PriceList.ShowLinkGoodsDialog(GoodsName: string): Integer;
var
  dialog: TfrmAddGoodsFromPriceDlg;
  ATableView: TcxGridDBTableView;
begin
  Result := -1;
  dialog := TfrmAddGoodsFromPriceDlg.Create(Self, dmDB.IBCConnection);
  try
    case pcPricesAnalize.ActivePageIndex of
      0:
        ATableView := cxGridItemsDBTableView1;
      1:
        ATableView := cxGridDBTableView1;
      2:
        ATableView := cxGrid2DBTableViewOldGoods;
      3:
        ATableView := cxGridDBTVPricesUp;
      4:
        ATableView := cxGridDBTVPricesDown;
      5:
        ATableView := cxGridDBTableView2;
    end;

    if ATableView.DataController.RecordCount > 1 then
    begin
      with ATableView.DataController do
      begin
        dialog.Supplierid := IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger;
        dialog.SupplierGoodsName := GoodsName;
        dialog.SupplierGoodsCode := Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('SUPPLIER_GOODS_CODE').Index];
        dialog.priceRRP := StrToFloatDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('PRICE3').Index]),
          0);
        dialog.CurrencyRRP := StrToIntDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('CURRENCY3ID').Index]),
          840);
        dialog.Price7 := StrToFloatDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('PRICE7').Index]), 0);
        dialog.currency7id := StrToIntDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('CURRENCY7ID').Index]),
          840);

        dialog.VendorID := StrToIntDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('SYSTEM_VENDORID').Index]),
          -1);

        dialog.Model := VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('SUPPLIER_GOODS_MODEL').Index]);
        if Assigned(ATableView.GetColumnByFieldName('PARENTGOODSID')) then
          dialog.ParentGoodsID := StrToIntDef(VarToStr(Values[FocusedRecordIndex,
            ATableView.GetColumnByFieldName('PARENTGOODSID').Index]), -1);

        if pcPricesAnalize.ActivePageIndex = 0 then
        begin
          dialog.GOODSTYPENAME := VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('GOODSTYPE_NAME').Index]);
          dialog.GoodsTypeID := StrToIntDef(VarToStr(Values[FocusedRecordIndex, ATableView.GetColumnByFieldName('GOODSTYPEID').Index]),
            -1);
        end;
      end;

      if dialog.ShowModal = mrOK then
        Result := dialog.goodsid;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe78PriceList.SelectSupplier;
var
  d: TfrmCustomersDlg;
begin
  d := TfrmCustomersDlg.Create(Self);
  try
    if d.SelectCustomer(IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger, False) then
    begin
      // Se pozitioneaza intai pe furnizorul ales, abia apoi se incarca datele lui
      // (inainte reincarcarea se facea pe furnizorul VECHI, inainte de Locate).
      IBCQuerySuppliers.locate('customerid', d.CustomerID, []);
      tmrSupplierRefresh.Enabled := False; // Locate a declansat FocusedRecordChanged - evitam un refresh dublu peste 1 sec.
      LoadSelectedSupplier;
    end;
  finally
    d.Free;
  end;
end;

procedure Tframe78PriceList.SetParentID(AParentID: Integer);
var
  ATableView: TcxGridDBTableView;
  dialog: TfrmGoodsBrowser;
  FolderID: Integer;
begin
  ATableView := cxGridItemsDBTableView1;
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    if dialog.SelectGoods(-1, true) then
    begin
      if not dialog.GoodsIsFolder then
        FolderID := dialog.CurrentParentID
      else
        FolderID := dialog.goodsid;

      var I: Integer;
      for I := 0 to ATableView.Controller.SelectedRowCount - 1 do
      begin
        ATableView.Controller.SelectedRecords[I].Values[cxGridItemsDBTableView1_PARENTID.Index] := FolderID;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe78PriceList.SetPriceListGoodsTypeID;
var
  ACurrentWebGoodsTypeID: Integer;
  aRowIndex: Integer;
  // dialog: TfrmSelectGoodsTypeDlg;
  editor: TfrmGoodsTypeDlg;
  I: Integer;
  SupplierGoodsCode: string;
  Query: TIBCSQL;
  ATableView: TcxGridDBTableView;
begin
  ATableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);
  Query := TIBCSQL.Create(Self);
  Query.Transaction := dmDB.IBCTrDefaultUpdate;
  Query.AutoCommit := False;
  Query.SQL.Text :=
    'update ts_pricelist_items set goodstypeid=:goodstypeid where plid=:plid and supplier_goods_code = :supplier_goods_code';
  Query.Prepare;

  editor := TfrmGoodsTypeDlg.Create(Self);
  try
    ACurrentWebGoodsTypeID := iif(VarIsNull(ATableView.DataController.Values[ATableView.Controller.FocusedRecord.Index,
      ATableView.GetColumnByFieldName('GOODSTYPEID').Index]), -1, ATableView.DataController.Values[ATableView.Controller.FocusedRecord.Index,
      ATableView.GetColumnByFieldName('GOODSTYPEID').Index]);

    if (ACurrentWebGoodsTypeID = 0) then
      ACurrentWebGoodsTypeID := -1;

    if editor.SelectGoodsType(ACurrentWebGoodsTypeID) then
    begin
      if not Query.Transaction.Active then
        Query.Transaction.StartTransaction;
      for I := 0 to ATableView.Controller.SelectedRowCount - 1 do
      begin
        aRowIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;
        SupplierGoodsCode := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('SUPPLIER_GOODS_CODE').Index];
        Query.ParamByName('goodstypeid').AsInteger := editor.GoodsTypeID;
        Query.ParamByName('plid').AsInteger := IBCQueryPriceData.FieldByName('PLID').AsInteger;
        Query.ParamByName('supplier_goods_code').AsString := SupplierGoodsCode;
        Query.Execute;
      end;
      Query.Transaction.Commit;
      ATableView.DataController.DataSet.Refresh;
//            ATableView.DataController.RefreshExternalData;
    end;
  finally
    Query.Free;
    editor.Free;
  end;
end;

procedure Tframe78PriceList.SetupDefaultFocus;
begin
  cxGridSuppliers.SetFocus;
end;

procedure Tframe78PriceList.SpeedButton1Click(Sender: TObject);
begin
  SelectSupplier;
end;

procedure Tframe78PriceList.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin

end;

procedure Tframe78PriceList.SetupSecurityItems;
begin
  if not SWNSecurityManager.LoggedUser.IsInAdminGroup then
  begin
    bbDeleteAllGoodsFromCatalog.Visible := ivNever;
  end;
end;

procedure Tframe78PriceList.InitArrayCont(AGridView: TcxGridDBTableView; AFieldIndex: Integer; ADuplist: TStringList);
var
  AValue: string;
  I: Integer;
  List: TStringList;
begin
  List := TStringList.Create;
  try
    with AGridView.DataController do
    begin
      for I := 0 to RecordCount - 1 do
      begin
        AValue := VarToStr(Values[I, AFieldIndex]);
        if (List.IndexOf(AValue) <> -1) then
          ADuplist.Add(AValue)
        else
          List.Add(AValue);
      end;
    end;
  finally
    List.Free;
  end;
end;

procedure Tframe78PriceList.SetBrandByName(BrandName, GoodsCode: string; PLID:
    Integer);
var
  BrandID: integer;
begin
  var q := TIBCQuery.Create(nil);
  BrandID := 0;
  try
    q.sql.Text := 'execute procedure SET_PRICELIST_BRANDID ( ' + ':PLID, ' + ':GOODS_CODE, ' + ':BRANDNAME)';
    q.parambyname('PLID').AsInteger := PLID;
    q.parambyname('GOODS_CODE').Asstring := GoodsCode;
    q.parambyname('brandname').Asstring := BrandName;
    q.Open;
    if q.RecordCount > 0 then
      BrandID := q.fieldbyname('syssid').Asinteger;
  finally
    q.Free;
  end;

end;

end.


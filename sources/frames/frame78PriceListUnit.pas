unit frame78PriceListUnit;
{
  Менеджер Прайс Листов
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
    cxGridDataDBTableView1MENTIUNI: TcxGridDBColumn;
    cxGridDataDB_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDataLevel1: TcxGridLevel;
    dxBarDockControl2: TdxBarDockControl;
    cxButton1: TcxButton;
    btnUpdatePriceFromDB: TButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    bbSetParentID: TdxBarButton;
    lcbSupplier: TcxLookupComboBox;
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
    dxBarButton14: TdxBarButton;
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
    cxGrid6DBTableView1SUPPLIERID: TcxGridDBColumn;
    cxGrid6DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGrid6DBTableView1IMAGE_URL: TcxGridDBColumn;
    cxGrid6DBTableView1PROCESS_DATE: TcxGridDBColumn;
    cxGridItemsDBTableView1Price1_LEI: TcxGridDBColumn;
    cxGridItemsDBTableView1EXCHANGE_RATE3: TcxGridDBColumn;
    dxBarButton21: TdxBarButton;
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
    procedure cxLookupComboBox1PropertiesCloseUp(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dxBarButton10Click(Sender: TObject);
    procedure dxBarButton11Click(Sender: TObject);
    procedure dxBarButton12Click(Sender: TObject);
    procedure lcbPriceCategoryPropertiesChange(Sender: TObject);
    procedure dxBarButton13Click(Sender: TObject);
    procedure cxGridItemsDBTableView1_CODEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pcPricesAnalizePageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
    procedure dxBarButton14Click(Sender: TObject);
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
    procedure dxBarButton21Click(Sender: TObject);
    procedure dxBarButton18Click(Sender: TObject);
    procedure bbSupplierNewClick(Sender: TObject);
  private // procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
    FlgImportWithRRP: Boolean;
    LastPriceCategoryID: Integer;
    LastSupplierID: Integer;
    procedure ClosePriceAnalizeDataSet;
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
  ApiAccentUnit, DataModuleAdditions, DataModuleDB, SWNConst, SWNDBErrors, SWNSecurity, SWNTypes, SWNUtils,
  SWNValueStorageUnit, dxInputDialogs, frmAddGoodsfromPrices, frmAddNewGoodsUnit, frmAnalizePriceListUnit,
  frmContentGoodsEditorDialog, frmContentPackage, frmCustomersDlg, frmGoods, frmGoodsPriceListDlgUnit, frmGoodsTypeDialog,
  frmMuncitorulProgressUnit, frmPriceManageStringFieldsUnit, frmPriceTypesUnit, frmPricelistImportUnit,
  frmSelectGoodsTypeUnit, frmSyssDataEditor, frmSyssEditorWindow, uAnalizePriceList, uLoadProductImages, uPythonRunner,
  System.Math,
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
      'insert into tdb_goods_price (docid, goodsid, supplier_goods_code, price3, currencyid, currency3id, barcode, flags) ' +
      ' values( :DOCID, :GOODSID, :SUPPLIER_GOODS_CODE, :PRICE3, :currencyid, :CURRENCY3ID, :BARCODE, set_flg_value(set_flg_value(0, 3, :flg_in_price), 4, :flg_epp ))';

    Query.ParamByName('DOCID').Value := DOCID;
    Query.ParamByName('GOODSID').Value := goodsid;
    Query.ParamByName('SUPPLIER_GOODS_CODE').Value := SupplierGoodsCode;
    Query.ParamByName('PRICE3').Value := iif(flg_rrp, price3, 0.00);
    Query.ParamByName('CURRENCYID').Value := Currency3ID;
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

procedure Tframe78PriceList.cxLookupComboBox1PropertiesCloseUp(Sender: TObject);
begin

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

procedure Tframe78PriceList.dxBarButton14Click(Sender: TObject);
begin
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
    finally
      d.Free;
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

procedure Tframe78PriceList.dxBarButton6Click(Sender: TObject);
var
  bmbImages: TLoadBombaProductImages;
begin
  bmbImages := TLoadBombaProductImages.Create(dmDB.IBCConnection);
  try
    bmbImages.LoadImages(IBCQueryPriceItems.FieldByName('GOODSID').AsInteger, IBCQueryPriceItems.FieldByName('SUPPLIER_GOODS_CODE').AsString);
  finally
    bmbImages.Free;
  end;
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
  AccountingCostFormationTypeID: Integer;
  aRowIndex: Integer;
  ATableView: TcxGridDBTableView;
  Barcode: string;
  Currency3ID: Integer;
  currency7id: Integer;
  dialog: TfrmGoodsBrowser;
  LastParentID: Integer;
  fBestMatсhParentGoodsID: Integer;
  GoodsTypeID: Integer;
  I: Integer;
  Model: string;
  ParentGoodsID: string;
  price3: double;
  Price7: double;
  R: TGoodsWebInfoClass;
  SupplierGoodsCode: string;
  SupplierGoodsName: string;
  VendorID: Integer;
  WebGoodsTypeID: Integer;
  FlgRRP: integer;
begin
// ATLANT
  ATableView := GetActiveTableView(pcPricesAnalize.ActivePageIndex);

  Price7 := 0;
  price3 := 0;
  try
    R := TGoodsWebInfoClass.Create;
    LastParentID := AppUserTempConfigStorage.IntValues.GetValue(Self.Name + '_LastParentID', -1);
    WebGoodsTypeID := -1;
    try
      for I := 0 to ATableView.Controller.SelectedRowCount - 1 do
      begin
        aRowIndex := ATableView.ViewData.Records[ATableView.Controller.SelectedRecords[I].Index].RecordIndex;

                // daca este cod produs atunci nu mai generam un produs nou
        if not varisnull(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnbyFieldName('GOODSID').Index]) then
          Continue;

                // daca nu este setat parentgoodsid atunci il luam din nomenclator
        R.ParentID := -1;
        if not VarIsNull(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnbyFieldName('PARENTGOODSID').Index]) then
        begin
          ParentGoodsID := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnbyFieldName('PARENTGOODSID').Index];
        end
        else
        begin
                // daca nu este valoare pentru ParentGoodsID atunci ->
                // 1. unde sunt amplasate majoritatea produselor cu webgoodstypeid (daca setat)
                // if not GetBestMatchParentGoodsID(webgoodstypeid, fBestMatсhParentGoodsID) then begin
                // 2. daca nu avem inregistrari propunem sa selecteze din nomenclator
          dialog := TfrmGoodsBrowser.Create(Self);
          try
            if (not CheckGoodsIsFolder(LastParentID)) then
            begin
//                            LastParentID := -1;
              LastParentID := StrToIntDef(Clipboard.AsText, -1);
              var q := TIBCQuery.Create(nil);
              q.sql.Add('select * from vw_ts_goods where goodsid = :goodsid');
              q.ParamByName('goodsid').AsInteger := LastParentID;
              q.Open;

              if (q.fieldbyname('flg_folder').AsInteger = 0) then
              begin
                                    // daca e produs
                ParentGoodsID := q.fieldbyname('parentid').AsString;
                FlgRRP := GetRRPFlag(q.FieldByName('goodsid').AsInteger, IBCQuerySuppliers.fieldbyname('customerid').AsInteger);
                WebGoodsTypeID := q.FieldByName('webgoodstype_id').AsInteger;
                VendorID := q.FieldByName('vendor_id').AsInteger;
              end
              else
              begin
                                // daca e mapa
                ParentGoodsID := q.fieldbyname('goodsid').AsString;
              end;
            end
            else
              ParentGoodsID := LastParentID.ToString;

            if ParentGoodsID <> '' then
              LastParentID := ParentGoodsID.ToInteger;

            // SaveLastUsedParentFolder
            if (LastParentID > -1) then
              AppUserTempConfigStorage.IntValues.SetValue(Self.Name + '_LastParentID', LastParentID);
          finally
            if Assigned(dialog) then
              FreeAndNil(dialog);
          end;
        end;

        if ParentGoodsID <> '' then
        begin
          Currency3ID := 0;
          currency7id := 0;
          price3 := 0;
          if VarIsNumeric(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PRICE3').Index]) then
            price3 := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PRICE3').Index];

          SupplierGoodsName := StringReplace(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName
            ('SUPPLIER_GOODS_NAME').Index], #$D#$A, ' ', [rfReplaceALL]);
          SupplierGoodsCode := StringReplace(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName
            ('SUPPLIER_GOODS_CODE').Index], #$D#$A, ' ', [rfReplaceALL]);

          if VarIsNumeric(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PRICE7').Index]) then
            Price7 := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PRICE7').Index];

          if not Variants.VarIsNull(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('CURRENCY3ID').Index])
            then
          begin
            Currency3ID := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('CURRENCY3ID').Index];
          end;

          if not Variants.VarIsNull(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('CURRENCY7ID').Index])
            then
            currency7id := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('CURRENCY7ID').Index];

          if StrToIntDef(VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('SYSTEM_VENDORID').Index]),
            -1) = -1 then
          begin
            if VendorID > 0 then
            begin
              var res := MessageDlg('Nu este setat producatorul!, folosim din produsul sursa?', mtInformation, [mbYes,
                mbNo, mbCancel], 0);
              if res = mrCancel then
              begin
                VendorID := -1;
                raise exception.Create('Oprit');
              end;

              if res = mrNo then
              begin
                VendorID := -1;
                raise exception.Create('Nu este indicat producatorul!');
              end;
            end;
          end
          else
            VendorID := StrToIntDef(VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName
              ('SYSTEM_VENDORID').Index]), -1);

          if StrToIntDef(VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('GOODSTYPEID').Index]),
            -1) > 0 then
            WebGoodsTypeID := StrToIntDef(VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName
              ('GOODSTYPEID').Index]), -1);

          Barcode := VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('BARCODE').Index]);

          Model := VarToStr(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('SUPPLIER_GOODS_MODEL').Index]);

          if (ParentGoodsID <> '') then
          begin
            R := GetGoodsWebInfo(ParentGoodsID.ToInteger);

            R.ParentID := strtoint(ParentGoodsID);

            if not VarIsNull(ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PARENTGOODSID').Index])
              then
              R.ParentID := ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('PARENTGOODSID').Index]
            else
              R.ParentID := strtoint(ParentGoodsID)
          end
          else
            raise Exception.Create('Nu este setata mapa unde doriti sa adaugati produsele selectate!');

          if Model <> '' then
            R.CodeRO := Model;

          AccountingCostFormationTypeID := iif(R.AccountingCostFormationTypeID = -1, 4201, R.AccountingCostFormationTypeID);
          if VendorID <= 0 then
            raise Exception.Create('Eroare! Nu este indicat producatorul');

          var NewGoodsID := dmDB.CreateNewGoods(R.ParentID, SupplierGoodsName, AccountingCostFormationTypeID,
            WebGoodsTypeID, SupplierGoodsCode, VendorID, IBCQuerySuppliers.FieldByName('CUSTOMERID').AsInteger, R.CodeRO,
            R.BaseParamsRO, price3, Currency3ID, Price7, currency7id, FlgRRP);

          ATableView.DataController.Values[aRowIndex, ATableView.GetColumnByFieldName('GOODSID').Index] := NewGoodsID;
          AppUserTempConfigStorage.IntValues.SetValue(Self.Name + '_LastGoodsID', ParentGoodsID.ToInteger);
        end;
      end;
    finally
      AppUserTempConfigStorage.IntValues.SetValue(Self.Name + '_LastParentID', -1);
      R.Free;
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
    IBCQueryPriceItems.First;
    while IBCQueryPriceItems.Eof do
    begin
       {
       GetMamicoGoodsInfo (IBCQueryPriceItems.FieldByName('product_link').AsString );
       }
      IBCQueryPriceItems.Next;
    end;
  end;

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
    dialog.SupplierName := IBCQuerySuppliers.FieldByName('DISPLAYNAME').AsString;
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
      if (FLG_UseRRP and VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price3Index])) then
        price3 := ATableView.DataController.Values[aRecIndex, Price3Index];

      if (FLG_UseRRP or not VarIsNull(ATableView.DataController.Values[aRecIndex, Currency3Index])) then
        Currency3ID := ATableView.DataController.Values[aRecIndex, Currency3Index];

      if (FLG_UseRRP) and (price3 = 0) then
      begin
        meLog.Lines.Add(Format('[%s] - Produsul %d este cu RRP si nu are pret!', [FormatDateTime('yyyy/mm/dd hh:nn:ss',
          now), goodsid]));
      end;

      Price7 := 0;
      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price7Index]) and (ATableView.Controller.SelectedRecords
        [I].Values[Price7Index] <> 0) then
        Price7 := ATableView.DataController.Values[aRecIndex, Price7Index];

      if not Variants.VarIsNull(ATableView.DataController.Values[aRecIndex, Currency7Index]) then
        currency7id := ATableView.DataController.Values[aRecIndex, Currency7Index];

      if VarIsNumeric(ATableView.DataController.Values[aRecIndex, Price0Index]) and (ATableView.DataController.Values[aRecIndex,
        Price0Index] <> 0) then
      begin
        price0 := ATableView.DataController.Values[aRecIndex, Price0Index];
      end;

      if (currency7id = '') then
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
        Currency3ID := '840';

      if (Price7 > 0) then
      begin
        if FLG_UseRRP and flg_in_price and (price3 = 0) then
          MessageDlg('Eroare! Pret RRP = 0 si FLG_RRP este setat!', mtError, [mbOK], 0)
        else
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

    dmDB.ExecuteQuery('execute procedure close_reevaluare(:docid)', [DOCID]);
        // micsorarea preturilui recomandat cu 1 % automat, exceptie accent

    var qq := TIBCQuery.Create(nil);
    CustomerRrpDiscount := 0;
    try
      qq.SQL.Text := 'select rrp_discount from ts_customer where customerid = :customerid';
      qq.ParamByName('customerid').AsInteger := IBCDataSourceSuppliers.DataSet.FieldByName('CUSTOMERID').AsInteger;
      qq.Open;
      CustomerRrpDiscount := qq.FieldByName('rrp_discount').AsFloat *  - 1;
    finally
      qq.Free;
    end;

    dmDB.ExecuteQuery('EXECUTE PROCEDURE ADJUST_RRP_REEVALUATION(:DOCID, :PERCENT)', [DOCID, CustomerRrpDiscount]);
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
  IBCQueryPriceListImages.Open;

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
      cxLookupComboBox1PropertiesCloseUp(Self);
      lcbSupplier.Text := d.CustomerTitle;
      IBCQuerySuppliers.locate('customerid', d.CustomerID, []);
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
  lcbSupplier.SetFocus;
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


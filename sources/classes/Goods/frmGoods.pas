unit frmGoods;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNBaseUnit, Dialogs, Menus, cxStyles, cxGraphics, cxLabel, IBC, dxBar,
    cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
    cxGrid, cxDBLabel, StdCtrls, cxButtons, ExtCtrls, CheckLst,
    GoodsFiltersClasses, ComCtrls, Buttons, cxGridPopupMenu, cxPC,
    frmPrintEngineWindow, cxCalc, GoodsAnalizerDialog, frmGoodsImageViewerUnit,
    cxLookAndFeels, System.ImageList, cxLookAndFeelPainters, cxControls,
    cxContainer, cxEdit, cxCustomData, cxFilter, cxData, cxDataStorage,
    cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxDBData, cxImageComboBox,
    cxCurrencyEdit, cxCheckBox, dxBarBuiltInMenu, Vcl.ImgList, cxImageList,
    cxGridCustomPopupMenu, DBAccess, MemDS, cxClasses, cxGridCustomView,
    frmContentGoodsEditorDialog, SWNUtils, Vcl.WebpImage, System.Notification,
    dxOfficeSearchBox, cxCalendar, cxBarEditItem, dxStatusBar, Data.DB,
    dxUIAClasses;

type
    TDelayedOpenPathCatalog = class(TThread)
    private
        FDataSet: TDataSet;
        FDelay: Integer;
        FlbPath: TLabel;
    protected
        procedure Execute; override;
    public
        constructor Create(ADataSet: TDataSet; ADelay: Integer; lbPath: TLabel);
    end;

    TGoodsWebInfoClass = class
        GoodsID: Integer;
        ParentID: Integer;
        Title: string;
        CatID: Integer;
        SecID: Integer;
        GoodsTypeID: Integer; // тип товара для веб
        GoodsTypeNameRO: string;
        GoodsTypeNameRU: string;
        VendorID: Integer;
        VendorName: string;
        CodeRO: string;
        BaseParamsRO: string;
        Details: string;
        AccountingCostFormationTypeID: Integer; // тип учета формирование себистоимости
    end;

    TOnBurstAddGoods = procedure(const GoodsID: Integer; const GoodsTitle: string; var Added: Boolean; var Count: Integer) of object;

    TOnCheckIfGoodsExists = function(const GoodsID: Integer): Boolean of object;

    TfrmGoodsBrowser = class(TSWNCustomForm)
        dxBarDockControl1: TdxBarDockControl;
        dxBarManager: TdxBarManager;
        cxGridGoods: TcxGrid;
        cxGridGoods_Table: TcxGridDBTableView;
        cxGridGoodsLevel: TcxGridLevel;
        dxBarManagerBar1: TdxBar;
        cxGridGoods_GOODSID: TcxGridDBColumn;
        cxGridGoods_CODE: TcxGridDBColumn;
        cxGridGoods_VENDOR: TcxGridDBColumn;
        cxGridGoods_TITLE: TcxGridDBColumn;
        cxGridGoods_UM_TITLE: TcxGridDBColumn;
        cxGridGoods_QTY_AVAILABLE: TcxGridDBColumn;
        cxGridGoods_QTY_FILIALE: TcxGridDBColumn;
        cxGridGoods_QTY_FRANCIZE: TcxGridDBColumn;
        cxGridGoods_PRICEC1_LEI: TcxGridDBColumn;
        bbHome: TdxBarButton;
        bbBack: TdxBarButton;
        bbForward: TdxBarButton;
        bbNewGoods: TdxBarButton;
        bbModify: TdxBarButton;
        bbRemove: TdxBarButton;
        bbNewFolder: TdxBarButton;
        dxBarGoodsSubItems: TdxBarSubItem;
        bbSearch: TdxBarButton;
        cxGridGoods_QTY_INTERNAL: TcxGridDBColumn;
        cxGridGoods_QTY_RMA: TcxGridDBColumn;
        cxGridGoods_QTY_ACCOUNT: TcxGridDBColumn;
        cxGridGoods_WARRANTY: TcxGridDBColumn;
        cxGridGoods_FLG_OLD: TcxGridDBColumn;
        dxAddonsSubItems: TdxBarSubItem;
        bbGoodsDescriptions: TdxBarButton;
        bbGoodsKit: TdxBarButton;
        IBCDataSourceGoods: TIBCDataSource;
        IBCQueryGoods: TIBCQuery;
        cxGridGoods_IMG: TcxGridDBColumn;
        bbArrangeFolders: TdxBarButton;
        dxBarPopupMenu: TdxBarPopupMenu;
        bbChangeParent: TdxBarButton;
        IBCTrUpdateGoods: TIBCTransaction;
        bbCompatibleGoods: TdxBarButton;
        bbQtyByStocks: TdxBarButton;
        bbQtyByFirms: TdxBarButton;
        dxBarSubItemVIEW: TdxBarSubItem;
        bbShowAvailableGoods: TdxBarButton;
        bbQuickGoodsInfo: TdxBarButton;
        bbCloneGoods: TdxBarButton;
        cxGridGoods_WEBGOODSTYPE_TITLE: TcxGridDBColumn;
        miMultiSelect: TdxBarButton;
        bbRecalcPrice: TdxBarButton;
        bbGoodsPrice: TdxBarButton;
        bbForeignCodes: TdxBarButton;
        cxGridGoods_FLG_PRICE_FORCED: TcxGridDBColumn;
        cxGridGoods_FLG_REQUIRE_CERTIFICAT: TcxGridDBColumn;
        bbSet_FLG_OLD: TdxBarButton;
        bbMergeGoods: TdxBarButton;
        bbTools: TdxBarSubItem;
        bbFollowGoods: TdxBarButton;
        cxGridGoods_BASE_PARAM: TcxGridDBColumn;
        bbSetupPropsToSelection: TdxBarButton;
        cxGridPopupMenuGoods: TcxGridPopupMenu;
        cxGridGoods_QTY_TRANSIT: TcxGridDBColumn;
        bbReCalcGoodsStock: TdxBarButton;
        cxPageControlAddons: TcxPageControl;
        tbsGeneralInfo: TcxTabSheet;
        tbsStocks: TcxTabSheet;
        cxGridStockFirma: TcxGrid;
        cxGridStockFirmaTable: TcxGridDBTableView;
        cxGridStockFirmaTable_IMG: TcxGridDBColumn;
        cxGridStockFirmaTable_FIRMA: TcxGridDBColumn;
        cxGridStockFirmaTable_QTY: TcxGridDBColumn;
        cxGridStockFirmaTable_TRANSIT_QTY: TcxGridDBColumn;
        cxGridStockFirmaLevel: TcxGridLevel;
        IBCQueryStockFirms: TIBCQuery;
        IBCDataSourceStockFirms: TIBCDataSource;
        bbGoodsInfoCard: TdxBarButton;
        cxGridStocksTable: TcxGridDBTableView;
        cxGridStocksLevel: TcxGridLevel;
        cxGridStocks: TcxGrid;
        cxGridStocksTableColumn1: TcxGridDBColumn;
        cxGridStocksTableColumn2: TcxGridDBColumn;
        cxGridStocksTableColumn3: TcxGridDBColumn;
        cxGridStocks_IMAGE: TcxGridDBColumn;
        cxGridStockFirma_CUSTOMERID: TcxGridDBColumn;
        IBCQueryStockWarehouse: TIBCQuery;
        IBCDataSourceStockWarehouse: TIBCDataSource;
        bsubFlgNewGoods: TdxBarSubItem;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        dxBarButton3: TdxBarButton;
        bsubFlgPromoGoods: TdxBarSubItem;
        dxBarButton4: TdxBarButton;
        dxBarButton5: TdxBarButton;
        dxBarButton6: TdxBarButton;
        bbSubWebFLG_DISCOUNT: TdxBarSubItem;
        bbWEB_FLG_DISCOUNT_Edit: TdxBarButton;
        bbWEB_FLG_DISCOUNT_Delete: TdxBarButton;
        bbPriceMargins: TdxBarButton;
        cxGridGoods_FLG_NEW: TcxGridDBColumn;
        cxGridGoods_FLG_PROMO: TcxGridDBColumn;
        cxGridGoods_FLG_DISCOUNT: TcxGridDBColumn;
        bbPrint: TdxBarButton;
        cxGridGoods_PRICE5: TcxGridDBColumn;
        cxGridGoods_PRICE4_LEI: TcxGridDBColumn;
        IBC_GOODS_Recomendation: TIBCQuery;
        IBCDS_GOODS_Recomendation: TIBCDataSource;
        cxGridGoods_FLG_FOLDER: TcxGridDBColumn;
        IBCQueryBalansParts: TIBCQuery;
        IBCDataSourceBalansParts: TIBCDataSource;
        bbBalansPoPartiam: TdxBarButton;
        cxGridGoods_UMID: TcxGridDBColumn;
        bbAviableSnPartsNumbers: TdxBarButton;
        dxBarButton7: TdxBarButton;
        dxBarButton8: TdxBarButton;
        bbSendToNPSC: TdxBarButton;
        bbConvertGIF2PNG: TdxBarButton;
        cxGridGoods_FLG_FORCED_ADDON: TcxGridDBColumn;
        cxImageList1: TcxImageList;
        bbPriceAnalize: TdxBarButton;
        bbAnalizer: TdxBarButton;
        cxGridGoods_GOODS_TYPE_NAME: TcxGridDBColumn;
        bbRecalcComplectPrice: TdxBarButton;
        cxGridGoods_MINQTY: TcxGridDBColumn;
        dxBarButton10: TdxBarButton;
        bbLoanOffer: TdxBarButton;
        bbConvertJPEG2PNG: TdxBarButton;
        cxGridGoods_DELIVERY_TYPEID: TcxGridDBColumn;
        cxGridGoods_DELIVERY_TYPENAME: TcxGridDBColumn;
        bbGoodsPricePolicy: TdxBarButton;
        cxGridGoods_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
        bbForcedAnalize: TdxBarButton;
        cxGridGoods_PRICE7: TcxGridDBColumn;
        cxGridGoods_PRICE4: TcxGridDBColumn;
        bbMoveToArchive: TdxBarButton;
        bbSendToArchive: TdxBarButton;
        bbGoodsImages: TdxBarButton;
        cxGridGoods_FLG_SOCIAL: TcxGridDBColumn;
        cxGridGoods_VAT: TcxGridDBColumn;
        cxGridGoods_FLG_HAS_META: TcxGridDBColumn;
        bbWebCatalogPath: TdxBarButton;
        bbGoodsTitle: TdxBarButton;
        Panel5: TPanel;
        IBCQueryCatalog: TIBCQuery;
        IBCDataSourceCatalog: TIBCDataSource;
        lbPath: TLabel;
        cxGridGoods_FLG_PREODRDER: TcxGridDBColumn;
        Shape1: TShape;
        lbRecCount: TcxLabel;
        bbGoodsAttributes: TdxBarButton;
        bbAddToPromo: TdxBarButton;
        dxBarButton9: TdxBarButton;
        bbUpdateTitle: TdxBarButton;
        bbRelatedProducts: TdxBarButton;
        bbOK: TdxBarButton;
        bbCancel: TdxBarButton;
        bbChangeSupplierToAnother: TdxBarButton;
        cxGridGoods_MARGIN17: TcxGridDBColumn;
        bbModifyFiltersParams: TdxBarButton;
        cxGridGoods_FLG_HAS_KEYS: TcxGridDBColumn;
        dxBarButton11: TdxBarButton;
        bbBurstMode: TdxBarButton;
        SwnNotificationCenter: TNotificationCenter;
        cxBarEditItem1: TcxBarEditItem;
        dxStatusBar1: TdxStatusBar;
        bbAddToWebCatalog: TdxBarButton;
        bbFastMode: TdxBarButton;
        bbRefresh: TdxBarButton;
        bbChangeFiltersValue: TdxBarButton;
        bsiWeb: TdxBarSubItem;
        bbShowGoodsTypeFolders: TdxBarButton;
        cxGridGoods_TableColumn1: TcxGridDBColumn;
        dxBarButton12: TdxBarButton;
        dxBarButton13: TdxBarButton;
    bbAcntGoods: TdxBarButton;
        procedure bbAcntGoodsClick(Sender: TObject);
        procedure cxGridGoods_TableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure bbHomeClick(Sender: TObject);
        procedure bbBackClick(Sender: TObject);
        procedure bbForwardClick(Sender: TObject);
        procedure bbNewFolderClick(Sender: TObject);
        procedure bbRemoveClick(Sender: TObject);
        procedure cxGridGoods_TableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure bbModifyClick(Sender: TObject);
        procedure bbGoodsDescriptionsClick(Sender: TObject);
        procedure bbGoodsKitClick(Sender: TObject);
        procedure bbNewGoodsClick(Sender: TObject);
        procedure bbSearchClick(Sender: TObject);
        procedure bbChangeParentClick(Sender: TObject);
        procedure bbArrangeFoldersClick(Sender: TObject);
        procedure bbCompatibleGoodsClick(Sender: TObject);
        procedure bbQtyByStocksClick(Sender: TObject);
        procedure bbQtyByFirmsClick(Sender: TObject);
        procedure bbShowAvailableGoodsClick(Sender: TObject);
        procedure bbQuickGoodsInfoClick(Sender: TObject);
        procedure bbCloneGoodsClick(Sender: TObject);
        procedure dxBarSubItemVIEWPopup(Sender: TObject);
        procedure miMultiSelectClick(Sender: TObject);
        procedure bbRecalcPriceClick(Sender: TObject);
        procedure bbGoodsPriceClick(Sender: TObject);
        procedure bbForeignCodesClick(Sender: TObject);
        procedure bbSet_FLG_OLDClick(Sender: TObject);
        procedure bbMergeGoodsClick(Sender: TObject);
        procedure bbFollowGoodsClick(Sender: TObject);
        procedure bbSetupPropsToSelectionClick(Sender: TObject);
        procedure bbReCalcGoodsStockClick(Sender: TObject);
        procedure cxPageControlAddonsChange(Sender: TObject);
        procedure bbGoodsInfoCardClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton4Click(Sender: TObject);
        procedure bbWEB_FLG_DISCOUNT_EditClick(Sender: TObject);
        procedure bbWEB_FLG_DISCOUNT_DeleteClick(Sender: TObject);
        procedure bbSetupFLG_PRICE_FORCED_14Click(Sender: TObject);
        procedure bbRemoveFLG_PRICE_FORCEDClick(Sender: TObject);
        procedure bbPrintClick(Sender: TObject);
        procedure cxTabSheet1Show(Sender: TObject);
        procedure cxTabSheet1Exit(Sender: TObject);
        procedure IBC_GOODS_RecomendationAfterInsert(DataSet: TDataSet);
        procedure bbBalansPoPartiamClick(Sender: TObject);
        procedure cxGridGoods_QTY_AVAILABLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure bbAviableSnPartsNumbersClick(Sender: TObject);
        procedure dxBarButton7Click(Sender: TObject);
        procedure dxBarButton8Click(Sender: TObject);
        procedure cxGridGoods_TableSelectionChanged(Sender: TcxCustomGridTableView);
        procedure bbSendToNPSCClick(Sender: TObject);
        procedure bbConvertGIF2PNGClick(Sender: TObject);
        procedure cxGridGoods_PRICEC1_LEIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridGoods_MARGIN1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridGoods_TableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridGoods_TITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridStockFirmaTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure cxGridStockFirmaTable_TRANSIT_QTYStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure bbQty1Click(Sender: TObject);
        procedure bbPriceAnalizeClick(Sender: TObject);
        procedure bbAnalizerClick(Sender: TObject);
        procedure bbRecalcComplectPriceClick(Sender: TObject);
        procedure dxBarButton10Click(Sender: TObject);
        procedure bbLoanOfferClick(Sender: TObject);
        procedure bbConvertJPEG2PNGClick(Sender: TObject);
        procedure cxGridStockFirmaTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure bbGoodsPricePolicyClick(Sender: TObject);
        procedure bbForcedAnalizeClick(Sender: TObject);
        procedure cxGridGoods_QTY_AVAILABLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
        procedure bbMoveToArchiveClick(Sender: TObject);
        procedure bbSendToArchiveClick(Sender: TObject);
        procedure bbGoodsImagesClick(Sender: TObject);
        procedure bbWebCatalogPathClick(Sender: TObject);
        procedure bbGoodsTitleClick(Sender: TObject);
        procedure bbGoodsAttributesClick(Sender: TObject);
        procedure bbAddToPromoClick(Sender: TObject);
        procedure cxGridGoods_TableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure dxBarButton9Click(Sender: TObject);
        procedure bbRelatedProductsClick(Sender: TObject);
        procedure bbOKClick(Sender: TObject);
        procedure bbCancelClick(Sender: TObject);
        procedure bbChangeSupplierToAnotherClick(Sender: TObject);
        procedure bbUpdateTitleClick(Sender: TObject);
        procedure bbModifyFiltersParamsClick(Sender: TObject);
        procedure dxBarButton11Click(Sender: TObject);
        procedure IBCQueryGoodsAfterOpen(DataSet: TDataSet);
        procedure bbAddToWebCatalogClick(Sender: TObject);
        procedure bbChangeFiltersValueClick(Sender: TObject);
        procedure bbRefreshClick(Sender: TObject);
        procedure bbShowGoodsTypeFoldersClick(Sender: TObject);
        procedure dxBarButton12Click(Sender: TObject);
        procedure dxBarButton13Click(Sender: TObject);
    private
  { Private declarations }
        FCurrentParentID: Integer;
        fCurrentParentGoodsTypeID: Integer;
        fCurrentParentWEBGoodsTypeID: Integer;
        fCurrentParentSerialTypeID: Integer;
        FExtFilter: Boolean;
        fGoodsID: Integer;
    // fGoodsPrice: Currency;
        fGoodsWarranty: Integer;
        fGoodsUMID: Integer;
        fRootParentID: Integer;
        fAllowSelectFolder: Boolean;
        fSelectMode: Boolean;
        fInSearch: Boolean;
        fGoodsTitle: string;
        fGoodsPriceCurrencyID: Integer;
        fGoodsQuantityAvailable: Double;
        FBurstMode: Boolean;
        FOnBurstAddGoods: TOnBurstAddGoods;
        FCustomeSQLFilter: string;
        fCompactMode: Boolean;
    // security additional flags
        fSecurityFlag_CanModify_Folder, fSecurityFlag_CanModify_Goods, fSecurityFlag_CanDelete_Folder, fSecurityFlag_CanDelete_Goods: Boolean;
        fOnCheckIfGoodsExists: TOnCheckIfGoodsExists;

    // filters collection
        fFilterGroups: TGoodsFilterCollection;
        fGoodsIsFolder: Boolean;
        fGoodsSerialType: Integer;
        FGoodsVendorID: Integer;
        FWebGoodsTypeID: Integer;
    /// <summary>TfrmGoodsBrowser.SelectedRecordChanged
    /// </summary>
        procedure SelectedRecordChanged;
        procedure NavigateForward;
        procedure NavigateBack;
        procedure NavigateToGoods(const GoodsID: Integer);
        procedure NavigateSearch(const WhereConditionsInProc: string; const WhereConditionsInSQL: string = '');
        procedure NavigateToHome(const RootID: Integer);
        procedure NavigateAvailableGoods;
        procedure SetGoodsID(const Value: Integer);
        procedure SetRootParentID(const Value: Integer);
        procedure SetTitle(const Value: string);
        function ItemSelected: Boolean;
        procedure ShowNewGoodsDialog;
        procedure ShowCreateNewFolderDialog;
        procedure DeleteCurrentSelectedGoods;
        procedure ShowModifySelectedGoodsDialog;
        procedure ShowGoodsKitDialog;
        procedure SetSelectMode(const Value: Boolean);
        function BarItemVisible(const Visible: Boolean): TdxBarItemVisible;
        procedure ShowSearchDialog;
        procedure SetBurstMode(const Value: Boolean);
        procedure SetExtFilter(const Value: Boolean);
        procedure SetOnBurstAddGoods(const Value: TOnBurstAddGoods);
        procedure DisplayBurstCounter(const Count: Integer);
        procedure DisplayBurstAddFailed;
        procedure ShowChangeParentDialog;
        procedure ShowSortFoldersDialog;
        procedure ShowGoodsDescriptionsDialog;
        procedure ShowGoodsCompatibleGoodsDialog;
        procedure SetCustomeSQLFilter(const Value: string);
        function GetGoodsPrice(Index: Integer): Currency;
        function GetGoodsPriceMDL(Index: Integer): Currency;
        function GetGoodsCurrency(Index: Integer): Integer;
        procedure ShowQtyByStockDialog;
        procedure ShowQtyByFirmsDialog;
        procedure SetOnCheckIfGoodsExists(const Value: TOnCheckIfGoodsExists);
        procedure ShowQuickInfoDialog(const GoodsID: Integer);
        procedure CopyCellTextToClipboard;
        procedure DoCloneGoods;
        function DoCloneGoodsDB(const GoodsID: Integer; var NewGoodsID: Integer): Boolean;
        procedure ShowRecalcPriceDialog;
        procedure DoRecalcGoodsPriceDB;
        procedure ShowModifyGoodsPriceDlg;
        procedure ShowForeignGoodsCodesDialog;
        procedure SetFLG_OLD;
        procedure ShowSetupPropsToGoodsSelection;
        function DBSetupPropertiesForGoodsSelection(const Data: TGoodsPropertySelectionData): Boolean;
        function DoReCalcGoodsStockDB(const FirmaID, GoodsID: Integer): Boolean;
        procedure ShowAdditionalMasterDetailsData;
        procedure ShowGoodsInfoCardDialog;
        procedure SetGoodsWebFlags(const FlagTypeID, Discount: Integer; const StartDate, EndDate: TDate; const GoodsIDList: string);
        procedure SetFolderWebFlags(const FlagTypeID, Discount: Integer; const StartDate, EndDate: TDate; const FolderID: string);
        procedure DeleteGoodsWebFlags(const FlagTypeID: Integer; const GoodsIDList: string);
        function GetSelectionIDList: string;
        procedure ShowPrintDialog;
        procedure SetupReportParams(const ReportParams: TReportParamsList);
        procedure ShowBalansPoPartiamDialog;
        procedure ShowAviableSNnPartsNumbersDialog;
        procedure ConvertGif2PNG;
        procedure ConvertJpeg2PNG;
        function SendSelectedGoodsToAnalize(const GoodsList: string): Boolean;
        procedure SetupPriceMarginColumns;
        procedure ModifyGoods;
        procedure ModifyFolder;
        function SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
        procedure SetGoodsVendorID(const Value: Integer);
        procedure SetWebGoodsTypeID(const Value: Integer);
        procedure UpdatePath;
        procedure NavigateSearchForeignCode(const WhereConditionsInProc, WhereConditionsInSQL: string);
        procedure NavigateSearchGoodsComposite(const WhereConditionsInProc, WhereConditionsInSQL: string);
        procedure PrepareGrid;
        procedure SetCurrentParentID(const Value: Integer);
    protected { protected declarations }
        procedure AddGoodsToPromotion(PromoActionID: Integer);
        procedure Prepare; override;
        procedure LoadStates; override;
        procedure SaveStates; override;
        procedure SetupSecurityItems; override;
        procedure ShowPriceRules;

        procedure MultiAddRelatedGoods(const AGoodsid: Integer; ARelatedKey: string);
    public { Public declarations }
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure SetCompactMode;
        procedure EnableCondition(const ConditionIndex: Integer; const CustomConditionInProc: string = ''; const CustomConditionInWhere: string = '');
        property Title: string write SetTitle;
        property AllowSelectFolder: Boolean read fAllowSelectFolder write fAllowSelectFolder;
        property GoodsID: Integer read fGoodsID write SetGoodsID;
        property GoodsTitle: string read fGoodsTitle;
        property GoodsPrice[Index: Integer]: Currency read GetGoodsPrice;
        property GoodsPriceMDL[Index: Integer]: Currency read GetGoodsPriceMDL;
        property GoodsWarranty: Integer read fGoodsWarranty;
        property GoodsCurrency[Index: Integer]: Integer read GetGoodsCurrency;
        property GoodsPriceCurrencyID: Integer read fGoodsPriceCurrencyID;
        property GoodsQuantityAvailable: Double read fGoodsQuantityAvailable;
        property GoodsUMID: Integer read fGoodsUMID;
        property GoodsIsFolder: Boolean read fGoodsIsFolder;
        property GoodsSerialType: Integer read fGoodsSerialType;
        property RootID: Integer read fRootParentID write SetRootParentID;
        property SelectMode: Boolean read fSelectMode write SetSelectMode;
        property BurstMode: Boolean read FBurstMode write SetBurstMode;
        property ExtFilter: Boolean read FExtFilter write SetExtFilter;
        property OnBurstAddGoods: TOnBurstAddGoods read FOnBurstAddGoods write SetOnBurstAddGoods;
        property OnCheckIfGoodsExists: TOnCheckIfGoodsExists read fOnCheckIfGoodsExists write SetOnCheckIfGoodsExists;
        property CurrentParentID: Integer read FCurrentParentID write SetCurrentParentID;
        property CustomeSQLFilter: string read FCustomeSQLFilter write SetCustomeSQLFilter;
        procedure AddFolderToWebCatalog;
        procedure AdjustGoodsName(Values: Integer);
        function SelectGoods(const DefaultGoodsID: Integer; const CanSelectFolder: Boolean; const RootParentID: Integer = 0; const CustomTitle: string = ''): Boolean;
        procedure BrowseGoods(const DefaultGoodsID: Integer; const RootParentID: Integer = 0; const CustomTitle: string = '');
        function IsSerialTypeSerialNumber(const SerialType: Integer): Boolean;
        function IsSerialTypePartNumber(const SerialType: Integer): Boolean;
        function SelectWebCatalog: Integer;
        procedure ShowAcntGoodsDlg(GoodsID: Integer);
    published
        property GoodsVendorID: Integer read FGoodsVendorID write SetGoodsVendorID;
        property WebGoodsTypeID: Integer read FWebGoodsTypeID write SetWebGoodsTypeID;
    end;

function GetGoodsWebInfo(const GoodsID: Integer): TGoodsWebInfoClass;

var
    frmGoodsImage: TfrmGoodsImageViewer;

implementation

{$R *.dfm}

uses
    frmGoodsFolderEditor, frmGoodsEditorDlg, DataModuleAdditions, ClipBrd,
    frmGoodsKitDlg, SWNSecurityFlags, SWNSearchUnit, frmChangeParentFolderDialog,
    frmChangeOrderNoDialog, frmGoodsCompatibleGoodsDialog, SWNValueStorageUnit,
    DataModuleDB, SWNDBErrors, frmGoodsStockByWarehouseDialog,
    frmGoodsStockByFirmsDialog, frmGoodsQuickInfoDialog, SWNSecurity,
    frmGoodsPricesDialog, frmGoodsForeignCodeDialog, frmMergeGoodsDialog,
    frmSetupGoodsPropsSelectionDialog, frmGoodsInfoCardDialog,
    frmGoodsWebDiscountDialog, frmDatePeriodDialog, frmPrintWizardDialog,
    SWNTypes, SWNConst, frmGoodsBalansPoPartiamDialog,
    frmGoodsAviableSerialsNumbersDialog, frmGoodsAviablePartNumbersDialog,
    frmGoodsSendGoodsToNPSCDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
    gifImg, frmShowWebGoodsPropertiesUnit, uCreditFinalInfoDialog,
    frmPriceTypesUnit, frmGoodsWebCatalogPathUnit, frmChangeGoodsTitleUnit,
    frmSendGoodsToPackage, uGoodsAttributes, frameGoodsEditDescriptionUnit,
    uSelectPromotionDialog, WebpHelpers, Winapi.GDIPOBJ, frmRelatedProductsUnit,
    frmChangeGoodsSuppliersUnit, SWNGoodsUtils, frmModifyFilterParamsUnit,
    frmGoodsRelatedBrowserUnit, frmSelectGoodsUnit, frmWebCatalogDialog,
    frmGoodsForeignCodeEditorDialog, frmGoodsChangeFiltersUnit,
    frmShowGoodsTypeFoldersUnit, frmGoodsByCategoryFolderDlgUnit;

type
    TcxGridTableControllerAccess = class(TcxGridTableController);

function GetGoodsWebInfo(const GoodsID: Integer): TGoodsWebInfoClass;
var
    Query: TIBCQuery;
begin
    Result := nil;
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT CATEGORYID, SECTION, BASE_PARAM, WEBGOODSTYPE_ID, WEBGOODSTYPE_TITLE_ROM, ' + 'WEBGOODSTYPE_TITLE_RUS, VENDOR_ID, VENDOR, CODE, DETAILS, GOODS_TYPE_ID FROM WEB_GET_SHOPCART_GOODS_INFO2(5213,:ID)';
        Query.ParamByName('ID').AsInteger := GoodsID;
        Query.ExecSQL;
        if not Query.Eof then
        begin
            Result := TGoodsWebInfoClass.Create;
            Result.GoodsID := GoodsID;
            Result.Title := '';
            Result.CatID := Query.FieldByName('CATEGORYID').AsInteger; // CATEGORYID
            Result.SecID := Query.FieldByName('SECTION').AsInteger; // SECTION
            Result.GoodsTypeID := Query.FieldByName('WEBGOODSTYPE_ID').AsInteger; // WEBGOODSTYPE_ID
            Result.GoodsTypeNameRO := Query.FieldByName('WEBGOODSTYPE_TITLE_ROM').AsString; // WEBGOODSTYPE_TITLE_ROM
            Result.GoodsTypeNameRO := Query.FieldByName('WEBGOODSTYPE_TITLE_RUS').AsString; // WEBGOODSTYPE_TITLE_RUS
            Result.VendorID := Query.FieldByName('VENDOR_ID').AsInteger; // VENDOR
            Result.VendorName := Query.FieldByName('VENDOR').AsString; // VENDOR
            Result.CodeRO := Query.FieldByName('CODE').AsString; // CODE
            Result.BaseParamsRO := Query.FieldByName('BASE_PARAM').AsString; // CODE
            Result.Details := Query.FieldByName('DETAILS').AsString; // DETAILS
            Result.AccountingCostFormationTypeID := Query.FieldByName('GOODS_TYPE_ID').AsInteger;

        end;
    finally
        Query.Free;
    end;
end;

function TfrmGoodsBrowser.BarItemVisible(const Visible: Boolean): TdxBarItemVisible;
begin
    if Visible then
        Result := ivAlways
    else
        Result := ivNever;
end;

procedure TfrmGoodsBrowser.bbAnalizerClick(Sender: TObject);
var
    dialog: TGoodsAnalizerDlg;
begin
    dialog := TGoodsAnalizerDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbArrangeFoldersClick(Sender: TObject);
begin
    ShowSortFoldersDialog;
end;

procedure TfrmGoodsBrowser.bbAviableSnPartsNumbersClick(Sender: TObject);
begin
    ShowAviableSNnPartsNumbersDialog;
end;

procedure TfrmGoodsBrowser.bbBackClick(Sender: TObject);
begin
    NavigateBack;
end;

procedure TfrmGoodsBrowser.bbBalansPoPartiamClick(Sender: TObject);
begin
    ShowBalansPoPartiamDialog;
end;

procedure TfrmGoodsBrowser.bbCancelClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

procedure TfrmGoodsBrowser.bbChangeParentClick(Sender: TObject);
begin
    ShowChangeParentDialog;
end;

procedure TfrmGoodsBrowser.bbChangeSupplierToAnotherClick(Sender: TObject);
var
    d: TfrmChangeGoodsSupplier;
begin
    d := TfrmChangeGoodsSupplier.Create(Self);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbCloneGoodsClick(Sender: TObject);
begin
    DoCloneGoods;
end;

procedure TfrmGoodsBrowser.bbCompatibleGoodsClick(Sender: TObject);
begin
    ShowGoodsCompatibleGoodsDialog;
end;

procedure TfrmGoodsBrowser.bbFollowGoodsClick(Sender: TObject);
begin
    if Assigned(cxGridGoods_Table.Controller.FocusedRecord) then
    begin
        NavigateToGoods(cxGridGoods_Table.Controller.FocusedRecord.Values[cxGridGoods_GOODSID.Index]);
    end;
end;

procedure TfrmGoodsBrowser.bbForcedAnalizeClick(Sender: TObject);
begin
    if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
        dmDB.ExecuteQuery('EXECUTE PROCEDURE RECALC_FORCED_FLAG_FROM_FOLDER(:FOLDERID)', [IBCQueryGoods.FieldByName('GOODSID').AsInteger]);

end;

procedure TfrmGoodsBrowser.bbForeignCodesClick(Sender: TObject);
begin
    ShowForeignGoodsCodesDialog;
end;

procedure TfrmGoodsBrowser.bbForwardClick(Sender: TObject);
begin
    NavigateForward;
end;

procedure TfrmGoodsBrowser.bbGoodsAttributesClick(Sender: TObject);
var
    d: TfrmGoodsAttributesDlg;
begin
    d := TfrmGoodsAttributesDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbGoodsDescriptionsClick(Sender: TObject);
begin
    ShowGoodsDescriptionsDialog;
end;

procedure TfrmGoodsBrowser.bbGoodsInfoCardClick(Sender: TObject);
begin
    ShowGoodsInfoCardDialog;
end;

procedure TfrmGoodsBrowser.bbGoodsKitClick(Sender: TObject);
begin
    ShowGoodsKitDialog;
end;

procedure TfrmGoodsBrowser.bbGoodsPriceClick(Sender: TObject);
begin
    ShowModifyGoodsPriceDlg;
end;

procedure TfrmGoodsBrowser.bbGoodsPricePolicyClick(Sender: TObject);
begin
    ShowPriceRules;
end;

procedure TfrmGoodsBrowser.bbHomeClick(Sender: TObject);
begin
    NavigateToHome(fRootParentID);

end;

procedure TfrmGoodsBrowser.bbMergeGoodsClick(Sender: TObject);
begin
    ShowMergeGoodsDialog(ibcqueryGoods.FieldByName('GOODSID').AsInteger);
end;

procedure TfrmGoodsBrowser.bbModifyClick(Sender: TObject);
begin
    ShowModifySelectedGoodsDialog;
end;

procedure TfrmGoodsBrowser.bbModifyFiltersParamsClick(Sender: TObject);
var
    d: TfrmModifyFilterParamsDlg;
begin
    d := TfrmModifyFilterParamsDlg.Create(Self);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbMoveToArchiveClick(Sender: TObject);
var
    ArchiveFolderID: string;
begin
    ArchiveFolderID := '0';
    if InputQuery('Introduceti codul mapei cu arhiva', 'Cod mapa', ArchiveFolderID) then
        dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_MOVE_GOODS2ARCHIVEFOLDER(:CURRENTFOLDER, :PARENTFOLDER)', [IBCQueryGoods.FieldByName('PARENTID').Asinteger, ArchiveFolderID]);

    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.bbNewFolderClick(Sender: TObject);
begin
    ShowCreateNewFolderDialog;
end;

procedure TfrmGoodsBrowser.bbNewGoodsClick(Sender: TObject);
begin
    ShowNewGoodsDialog;
end;

procedure TfrmGoodsBrowser.bbOKClick(Sender: TObject);
begin
    if fSelectMode and ItemSelected then
        ModalResult := mrOk;
end;

procedure TfrmGoodsBrowser.bbPriceAnalizeClick(Sender: TObject);
begin
    if SendSelectedGoodsToAnalize(GetSelectionIDList) then
        ShowInfoDialog('Spre analiza', 'Finisat!');
end;

procedure TfrmGoodsBrowser.bbPrintClick(Sender: TObject);
begin
    ShowPrintDialog;
end;

procedure TfrmGoodsBrowser.bbQtyByFirmsClick(Sender: TObject);
begin
    ShowQtyByFirmsDialog;
end;

procedure TfrmGoodsBrowser.bbQtyByStocksClick(Sender: TObject);
begin
    ShowQtyByStockDialog;
end;

procedure TfrmGoodsBrowser.bbQuickGoodsInfoClick(Sender: TObject);
begin
    ShowQuickInfoDialog(IBCQueryGoods.FieldByName('GOODSID').AsInteger);
end;

procedure TfrmGoodsBrowser.bbReCalcGoodsStockClick(Sender: TObject);
begin
    if ShowAskDialog('Recalcul sold', Format('Doriti sa recalculati soldurile marfii'#13#10'"%s"?', [IBCQueryGoods.FieldByName('TITLE').AsString])) = mrYes then
    begin
        DoReCalcGoodsStockDB(dmDB.CurrentFirma, IBCQueryGoods.FieldByName('GOODSID').AsInteger);
        IBCQueryGoods.Refresh;
    end;
end;

procedure TfrmGoodsBrowser.bbRecalcPriceClick(Sender: TObject);
begin
    ShowRecalcPriceDialog;
end;

procedure TfrmGoodsBrowser.bbRefreshClick(Sender: TObject);
begin
    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.bbRemoveClick(Sender: TObject);
begin
    DeleteCurrentSelectedGoods;
end;

procedure TfrmGoodsBrowser.bbRemoveFLG_PRICE_FORCEDClick(Sender: TObject);
begin
  // DeleteGoodsWebFlags(3, GetSelectionIDList);
  // IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.bbSearchClick(Sender: TObject);
begin
    ShowSearchDialog;
end;

procedure TfrmGoodsBrowser.bbSendToNPSCClick(Sender: TObject);
var
    dialog: TfrmSendGoodsToPackageDlg;
begin
    dialog := TfrmSendGoodsToPackageDlg.Create(Self);
    try
        dialog.SetGoodsQty(cxGridGoods_Table.Controller.SelectedRecordCount);
        if dialog.ShowModal = mrOk then
        begin
            if SendSelectedGoodsToPackage(dialog.GetOperatorID, GetSelectionIDList) then
                ShowInfoDialog('Produsele au fost trimise la descriere', 'Finisat!');
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbSetupFLG_PRICE_FORCED_14Click(Sender: TObject);
var
    btn: TdxBarButton;
begin
    btn := TdxBarButton(Sender);
    if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
    begin
        SetFolderWebFlags(3, 0, Now, Now + btn.Tag, GetSelectionIDList);
    end
    else
    begin
        SetGoodsWebFlags(3, 0, Now, Now + btn.Tag, GetSelectionIDList);
    end;
    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.bbSetupPropsToSelectionClick(Sender: TObject);
begin
    ShowSetupPropsToGoodsSelection;
end;

procedure TfrmGoodsBrowser.bbSet_FLG_OLDClick(Sender: TObject);
begin
    SetFLG_OLD;
end;

procedure TfrmGoodsBrowser.bbShowAvailableGoodsClick(Sender: TObject);
begin
    NavigateAvailableGoods;
end;

procedure TfrmGoodsBrowser.bbShowGoodsTypeFoldersClick(Sender: TObject);
var
    d: TfrmShowGoodsTypeFoldersDlg;
begin
    d := TfrmShowGoodsTypeFoldersDlg.create(self, ibcquerygoods.FieldByName('WEBGOODSTYPE_ID').AsInteger);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbWebCatalogPathClick(Sender: TObject);
var
    dialog: TfrmGoodsWebCatalogPathDialog;
begin
    dialog := TfrmGoodsWebCatalogPathDialog.Create(Self, dmDB.IBCConnection);
    try
        dialog.FolderID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbWEB_FLG_DISCOUNT_DeleteClick(Sender: TObject);
begin
    if cxGridGoods_Table.Controller.SelectedRecordCount > 1 then
    begin
        if ShowAskDialog('Reduceri', Format('Sterge reducerea pentru %d produse selectate?', [cxGridGoods_Table.Controller.SelectedRecordCount])) = mrYes then
        begin
            DeleteGoodsWebFlags(4, GetSelectionIDList);
            IBCQueryGoods.Refresh;
        end;
    end
    else
    begin
        if ShowAskDialog('Reduceri', Format('Sterge reducerea pentru produsul "%s" ?', [IBCQueryGoods.FieldByName('TITLE').AsString])) = mrYes then
        begin
            DeleteGoodsWebFlags(4, IBCQueryGoods.FieldByName('GOODSID').AsString);
            IBCQueryGoods.Refresh;
        end;
    end;
end;

procedure TfrmGoodsBrowser.bbWEB_FLG_DISCOUNT_EditClick(Sender: TObject);
var
    dialog: TfrmGoodsWebDiscountDlg;
    Discount: Integer;
    StartDate, EndDate: TDate;
begin
    Discount := 0;
    StartDate := Date;
    EndDate := Date + 30;

    dialog := TfrmGoodsWebDiscountDlg.Create(Self);
    try
        dialog.MultiSelect := cxGridGoods_Table.Controller.SelectedRecordCount > 1;
        dialog.Discount := Discount;
        dialog.StartDate := StartDate;
        dialog.EndDate := EndDate;
        if dialog.ShowModal = mrOk then
        begin
            SetGoodsWebFlags(4, dialog.Discount, dialog.StartDate, dialog.EndDate, GetSelectionIDList);
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.BrowseGoods(const DefaultGoodsID, RootParentID: Integer; const CustomTitle: string);
begin
    if CustomTitle <> '' then
        Title := CustomTitle;
    GoodsID := DefaultGoodsID;
    RootID := RootParentID;
    SelectMode := False;
    ShowModal;
end;

procedure TfrmGoodsBrowser.bbUpdateTitleClick(Sender: TObject);
var
    i: Integer;
    q: TIBCQuery;
    tmpGoodsID: Integer;
begin
  // if (dmDB.CurrentUserID = 204) or (dmDB.CurrentUserID = 360) then begin
    q := TIBCQuery.Create(nil);
    q.Transaction := IBCTrUpdateGoods;
    q.AutoCommit := False;
    q.SQL.Add('UPDATE TS_GOODS SET TITLE = (SELECT Z.GOODSNAME_RO FROM GET_GOODS_NAMES(:GOODSID) Z)');
    q.SQL.Add('WHERE GOODSID = :GOODSID');
    q.Prepare;
    if not IBCTrUpdateGoods.Active then
        IBCTrUpdateGoods.StartTransaction;
    try
        for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
        begin
            if (cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_FLG_FOLDER.Index] = 0) then
            begin
                tmpGoodsID := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_GOODSID.Index];
                q.ParamByName('GOODSID').AsInteger := tmpGoodsID;
                q.Execute;
                GenerateSeoData(tmpGoodsID, IBCTrUpdateGoods);
            end;
        end;
        IBCTrUpdateGoods.Commit;
        IBCQueryGoods.Refresh;
    finally
        q.Free;
    end;
  // end
end;

procedure TfrmGoodsBrowser.CopyCellTextToClipboard;
var
    i, j: Integer;
    S: string;
    Lines: TStringList;
begin
    Lines := TStringList.Create;
    try
        if cxGridGoods_Table.OptionsSelection.CellMultiSelect then
            for i := 0 to cxGridGoods_Table.Controller.SelectedRowCount - 1 do
            begin
                S := '';
                for j := 0 to cxGridGoods_Table.Controller.SelectedColumnCount - 1 do
                begin
                    if S <> '' then
                        S := S + #9;
                    S := S + Trim(cxGridGoods_Table.DataController.GetDisplayText(cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_Table.Controller.SelectedColumns[j].Index));
                end;
                Lines.Add(S);
            end
        else
            Lines.Add(Trim(cxGridGoods_Table.DataController.GetDisplayText(cxGridGoods_Table.Controller.FocusedRecord.RecordIndex, cxGridGoods_Table.Controller.FocusedColumn.Index)));

        Clipboard.AsText := Lines.Text;
    finally
        Lines.Free;
    end;
end;

constructor TfrmGoodsBrowser.Create(AOwner: TComponent);
begin
    inherited;

    fCompactMode := False;
    fAllowSelectFolder := False;
    fGoodsID := -1;
    fGoodsTitle := '';
    fGoodsIsFolder := False;
    fRootParentID := 0;
    fSelectMode := True;
  // fGoodsPrice:=0;
    fGoodsWarranty := 0;
    fGoodsUMID := 1;
    fGoodsPriceCurrencyID := -1;
    fGoodsQuantityAvailable := 0;
    BurstMode := False;
    FOnBurstAddGoods := nil;
    FCustomeSQLFilter := '';
    fOnCheckIfGoodsExists := nil;

  // lbInfo.Caption := '';
    fFilterGroups := TGoodsFilterCollection.Create;

    cxPageControlAddons.ActivePageIndex := 0;
end;

procedure TfrmGoodsBrowser.cxGridGoods_MARGIN1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if ARecord.Values[AItem.Index] <= 0 then
        AStyle := dmAdditions.cxStyle_TextColorRed;
end;

procedure TfrmGoodsBrowser.cxGridGoods_PRICEC1_LEIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if (ARecord.Values[cxGridGoods_QTY_AVAILABLE.Index] > 0) then
        AStyle := dmAdditions.cxStyle_TextColorGreen
    else if (ARecord.Values[cxGridGoods_QTY_FILIALE.Index] > 0) then
        AStyle := dmAdditions.cxStyle_TextColorDarkYellow;

end;

procedure TfrmGoodsBrowser.cxGridGoods_QTY_AVAILABLEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(cxGridGoods_Table.DataController.Values[ARecord.RecordIndex, cxGridGoods_FLG_FOLDER.Index]) then
    begin
        if (cxGridGoods_Table.DataController.Values[ARecord.RecordIndex, cxGridGoods_FLG_FOLDER.Index] = 1) then
            AText := ''
        else if (cxGridGoods_Table.DataController.Values[ARecord.RecordIndex, Sender.Index] = 0) then
            AText := '0'
        else if (cxGridGoods_Table.DataController.Values[ARecord.RecordIndex, cxGridGoods_UMID.Index] = 1) then
            AText := StringReplace(AText, ',000', '', []);
    end;
end;

procedure TfrmGoodsBrowser.cxGridGoods_QTY_AVAILABLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if not VarIsNull(ARecord.Values[cxGridGoods_QTY_AVAILABLE.Index]) then
        if ARecord.Values[cxGridGoods_QTY_AVAILABLE.Index] > 0 then
            AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmGoodsBrowser.cxGridGoods_TableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if (AButton = mbLeft) and (ssLeft in AShift) and (ssDouble in AShift) then
    begin
        if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
        begin
            if (ssCtrl in AShift) and fAllowSelectFolder and ItemSelected then
                ModalResult := mrOk
            else
                NavigateForward;
        end
        else if ItemSelected then
            ModalResult := mrOk;

        AHandled := True;
    end;
end;

procedure TfrmGoodsBrowser.cxGridGoods_TableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
    Added: Boolean;
    AddedCount: Integer;
begin
    if ((Key = Ord('f')) or (Key = Ord('F')) and (Shift = [ssAlt])) then
    begin
        TcxGridTableControllerAccess(cxGridGoods_Table.Controller).FindPanel.Show;
    end;
  // Ctrl+Alt+C
    if (Key = 67) and (Shift = [ssAlt, ssCtrl]) then
    begin
        ShowCopyGridContent(Self, cxGridGoods_Table);
        Key := 0;
        Shift := [];
    end;

  // lbInfo.Caption := '';
  // Enter
    if (Key = 13) and (Shift = []) then
    begin
        if (IBCQueryGoods.RecNo > 0) then
        begin
            if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
                NavigateForward
            else if ItemSelected then
                ModalResult := mrOk;
        end;
    end
    else
    // Back Space
        if (Key = 8) and (Shift = []) then
        NavigateBack
    else
      // Ctrl + BackSpace
        if (Key = 8) and (Shift = [ssCtrl]) then
    begin
        if FCurrentParentID <> fRootParentID then
            NavigateToHome(fRootParentID);
    end
    else
        // CTRL+Enter
        if (Key = 13) and (Shift = [ssCtrl]) then
    begin
        if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
        begin
            // folder
            if fAllowSelectFolder and ItemSelected then
                ModalResult := mrOk;
        end
        else
        begin
            if FBurstMode and Assigned(FOnBurstAddGoods) and ItemSelected then
            begin
                Added := False;
                AddedCount := 0;
                FOnBurstAddGoods(fGoodsID, fGoodsTitle, Added, AddedCount);
                if Added then
                begin
                    DisplayBurstCounter(AddedCount);
                end
                else
                    DisplayBurstAddFailed;
            end;
        end;
    end
    else
          // Ctrl+C
        if (Key = 67) and (Shift = [ssCtrl]) then
    begin
        CopyCellTextToClipboard;
        Key := 0;
        Shift := [];
    end
end;

procedure TfrmGoodsBrowser.cxGridGoods_TableSelectionChanged(Sender: TcxCustomGridTableView);
begin
    SelectedRecordChanged;
end;

procedure TfrmGoodsBrowser.cxGridGoods_TableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridGoods_QTY_AVAILABLE.Index]) then
    begin
        if ARecord.Values[cxGridGoods_QTY_AVAILABLE.Index] < 0 then
            AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure TfrmGoodsBrowser.cxGridGoods_TITLEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridGoods_IMG.Index]) then
    begin
        if ARecord.Values[cxGridGoods_IMG.Index] = 1 then
            AStyle := dmAdditions.cxStyle_Bold
    end;
end;

procedure TfrmGoodsBrowser.cxGridStockFirmaTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
    QTY, trQTY: Double;
begin
    if not VarIsNull(ARecord.Values[cxGridStockFirmaTable_QTY.Index]) then
    begin
        trQTY := ARecord.Values[cxGridStockFirmaTable_TRANSIT_QTY.Index];
        QTY := ARecord.Values[cxGridStockFirmaTable_QTY.Index];

        if (QTY <= 0) and (trQTY > 0) then
            AStyle := dmAdditions.cxStyle_Italic;
    // if QTY>0 then AStyle:=dmAdditions.cxStyle_Bold;
        if (trQTY <= 0) and (QTY <= 0) then
            AStyle := dmAdditions.cxStyle_TextGray;
    end;
end;

procedure TfrmGoodsBrowser.cxGridStockFirmaTable_TRANSIT_QTYStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridStockFirmaTable_TRANSIT_QTY.Index]) then
    begin
        if ARecord.Values[cxGridStockFirmaTable_TRANSIT_QTY.Index] <= 0 then
            AStyle := dmAdditions.cxStyle_TextGray;
    end;

end;

procedure TfrmGoodsBrowser.cxPageControlAddonsChange(Sender: TObject);
begin
    if cxPageControlAddons.ActivePage = tbsStocks then
        ShowAdditionalMasterDetailsData;
end;

procedure TfrmGoodsBrowser.cxTabSheet1Exit(Sender: TObject);
begin
  // IBC_GOODS_Recomendation.UpdateTransaction.StartTransaction;
    if IBC_GOODS_Recomendation.State in [dsEdit, dsInsert] then
    begin
        try

            IBC_GOODS_Recomendation.Post;
      // IBC_GOODS_Recomendation.UpdateTransaction.Commit;
        except
            IBC_GOODS_Recomendation.Cancel;
      // IBC_GOODS_Recomendation.UpdateTransaction.Rollback;
        end;
    end;

    IBC_GOODS_Recomendation.Close
end;

procedure TfrmGoodsBrowser.cxTabSheet1Show(Sender: TObject);
begin
    IBC_GOODS_Recomendation.Open;
end;

function TfrmGoodsBrowser.DBSetupPropertiesForGoodsSelection(const Data: TGoodsPropertySelectionData): Boolean;
var
    Query: TIBCQuery;
    i: Integer;
    S: string;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.AutoCommit := False;
        Query.SQL.Add('UPDATE TS_GOODS SET');

        S := '';

        if Data.Change_WebGoodsTypeID then
            S := 'WEBGOODSTYPE_ID=:webtypeID';

        if Data.Change_VendorID then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'VENDOR_ID=:vendorID';
        end;

        if Data.Change_BaseParam then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'BASE_PARAM=:base_param';
        end;

        if Data.Change_GoodsACNT then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'GOODS_ACNT_ID=:acntID';
        end;
        if Data.Change_GoodsTypeID then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'GOODS_TYPE_ID = :GOODS_TYPE_ID';
        end;
        if Data.Change_TipEvidenta then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'SERIAL_TYPE_ID = :SERIAL_TYPE_ID';
        end;

        if Data.Change_Waranty then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'WARRANTY=:WARRANTY';
        end;

        if Data.Change_PrefixName then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'TITLE = :PREFIX' + ' || TITLE';
        end;
        if Data.Change_UM then
        begin
            if S <> '' then
                S := S + ', ';
            S := S + 'UMID = :UMID';
        end;

        Query.SQL.Add(S);
        Query.SQL.Add(' WHERE GOODSID=:GOODSID');

        if Data.Change_WebGoodsTypeID then
            Query.ParamByName('WEBTYPEID').AsInteger := Data.Value_WebGoodsTypeID;
        if Data.Change_VendorID then
            Query.ParamByName('VENDORID').AsInteger := Data.Value_VendorID;
        if Data.Change_BaseParam then
            Query.ParamByName('BASE_PARAM').AsString := Data.Value_BaseParam;
        if Data.Change_GoodsACNT then
            Query.ParamByName('ACNTID').AsInteger := Data.Value_GoodsACNT;
        if Data.Change_GoodsTypeID then
            Query.ParamByName('GOODS_TYPE_ID').AsInteger := Data.Value_GoodsTypeID;
        if Data.Change_TipEvidenta then
            Query.ParamByName('SERIAL_TYPE_ID').AsInteger := Data.Value_TipEvidenta;
        if Data.Change_UM then
            Query.ParamByName('UMID').AsInteger := Data.Value_UM;
        if Data.Change_PrefixName then
            Query.ParamByName('PREFIX').AsString := Data.Value_PrefixName;
        if Data.Change_Waranty then
            Query.ParamByName('WARRANTY').AsString := Data.Value_Waranty;


        try
            Query.Transaction.StartTransaction;
            for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
            begin
                Query.ParamByName('GOODSID').AsInteger := cxGridGoods_Table.Controller.SelectedRecords[i].Values[cxGridGoods_GOODSID.Index];
                Query.ExecSQL;
            end;
            Query.Transaction.Commit;
            Result := True;
        except
            on e: Exception do
            begin
                if Query.Transaction.Active then
                    Query.Transaction.Rollback;
                if not ProcessSWNError(e) then
                    raise;
            end;
        end;

    finally
        Query.Free;
    end;
end;

procedure TfrmGoodsBrowser.DeleteCurrentSelectedGoods;
var
    S0, S: string;
    isFolder: Boolean;
begin
    isFolder := IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1;
    if isFolder then
    begin
        S0 := 'Stergerea mapei';
        S := 'Sterge mapa';
    end
    else
    begin
        S0 := 'Stergerea produsului';
        S := 'Sterge produsul';
    end;
    S := S + #13#10 + '"' + IBCQueryGoods.FieldByName('TITLE').AsString + '"?';
    if ShowAskDialog(S0, S) = mrYes then
    begin
        IBCQueryGoods.UpdateTransaction.StartTransaction;
        try
            IBCQueryGoods.Delete;
            IBCQueryGoods.UpdateTransaction.Commit;
        except
            on e: Exception do
            begin
                IBCQueryGoods.UpdateTransaction.Rollback;
                if not ProcessSWNError(e) then
                    raise;
            end;
        end;
    end;
end;

procedure TfrmGoodsBrowser.DeleteGoodsWebFlags(const FlagTypeID: Integer; const GoodsIDList: string);
var
    Query: TIBCQuery;
begin
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCQueryGoods.UpdateTransaction;
        Query.SQL.Text := 'EXECUTE PROCEDURE WEB_SETUP_GOODS_FLAG2(:DT, :GOODSIDLIST, :FLAGTYPEID, NULL, NULL, NULL)';
        Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
        Query.ParamByName('GOODSIDLIST').AsString := GoodsIDList;
        Query.ParamByName('FLAGTYPEID').AsInteger := FlagTypeID;

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
        except
            on e: Exception do
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

destructor TfrmGoodsBrowser.Destroy;
begin
    fFilterGroups.Free;
    inherited;
end;

procedure TfrmGoodsBrowser.AddFolderToWebCatalog;
var
    CurrentFolderID: Integer;
    q: TIBCQuery;
    WebCatalogID: Integer;
begin
    if (IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1) then
    begin
        CurrentFolderID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;

        WebCatalogID := SelectWebCatalog;
        if (WebCatalogID > -1) then
        begin
            q := TIBCQuery.Create(nil);
            try
                q.Transaction := IBCTrUpdateGoods;
                if not q.Transaction.Active then
                    q.Transaction.StartTransaction;

                q.SQL.Text := 'execute procedure link_web_catalog(:webcatalogid, :goodsfolderid)';
                q.ParamByName('webcatalogid').AsInteger := WebCatalogID;
                q.ParamByName('goodsfolderid').AsInteger := CurrentFolderID;
                try
                    q.Execute;
                    if q.Transaction.Active then
                        q.Transaction.Commit;
                except
                    on e: Exception do
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
end;

procedure TfrmGoodsBrowser.AddGoodsToPromotion(PromoActionID: Integer);
var
    i: Integer;
    q: TIBCQuery;
    tmpGoodsID: Integer;
    tmpGoodsPrice: Integer;
begin
    q := TIBCQuery.Create(nil);
    q.Transaction := IBCTrUpdateGoods;
    q.AutoCommit := False;
    q.SQL.Add('UPDATE TS_GOODS SET TITLE = (SELECT Z.GOODSNAME_RO FROM GET_GOODS_NAMES(:GOODSID) Z)');
    q.SQL.Add('WHERE GOODSID = :GOODSID');
    q.Prepare;
    if not IBCTrUpdateGoods.Active then
        IBCTrUpdateGoods.StartTransaction;
    try
        for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
        begin
            if (cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_FLG_FOLDER.Index] = 0) then
            begin
                tmpGoodsID := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_GOODSID.Index];
                tmpGoodsPrice := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_PRICE4_LEI.Index];

                q.ParamByName('GOODSID').AsInteger := tmpGoodsID;

                q.Execute;
                GenerateSeoData(tmpGoodsID, IBCTrUpdateGoods);
            end;
        end;
        IBCTrUpdateGoods.Commit;
        IBCQueryGoods.Refresh;
    finally
        q.Free;
    end;
  // end
end;

procedure TfrmGoodsBrowser.AdjustGoodsName(Values: Integer);
begin

end;

procedure TfrmGoodsBrowser.bbAcntGoodsClick(Sender: TObject);
begin
  ShowAcntGoodsDlg(GoodsID);
end;

procedure TfrmGoodsBrowser.DisplayBurstAddFailed;
var
    mynotification: TNotification;
begin
    mynotification := SwnNotificationCenter.CreateNotification;
    try
        mynotification.Name := 'SWNNotification';
        mynotification.Title := 'SWN notification';
        mynotification.AlertBody := 'Produsul nu este adaugat';
        SwnNotificationCenter.PresentNotification(mynotification);
    finally
        mynotification.Free;
    end;
end;

procedure TfrmGoodsBrowser.DisplayBurstCounter(const Count: Integer);
begin

end;

procedure TfrmGoodsBrowser.DoCloneGoods;
var
    NewGoodsID: Integer;
begin
    if ShowAskDialog('Clonare produs', 'Doriti sa clonati'#13#10 + IBCQueryGoods.FieldByName('TITLE').AsString + '?') = mrYes then
    begin
        if DoCloneGoodsDB(IBCQueryGoods.FieldByName('GOODSID').AsInteger, NewGoodsID) then
        begin
            IBCQueryGoods.Refresh;
            IBCQueryGoods.Locate('GOODSID', NewGoodsID, []);
            ModifyGoods;
        end;
    end;
end;

function TfrmGoodsBrowser.DoCloneGoodsDB(const GoodsID: Integer; var NewGoodsID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCTrUpdateGoods;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'SELECT NEWGOODSID FROM SP_CREATE_GOODS_CLONE(:GOODSID)';
            Query.ParamByName('GOODSID').AsInteger := GoodsID;
            Query.ExecSQL;
            if not Query.Eof then
            begin
                NewGoodsID := Query.Fields[0].AsInteger;
                Result := True;
            end;
            Query.Transaction.Commit;
        except
            on e: Exception do
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

procedure TfrmGoodsBrowser.DoRecalcGoodsPriceDB;
var
    Query: TIBCQuery;
    S: string;
    i: Integer;
begin
  // create list of goods
    S := '';
    for i := 0 to cxGridGoods_Table.Controller.SelectedRowCount - 1 do
    begin
        if S <> '' then
            S := S + ',';
        S := S + IntToStr(cxGridGoods_Table.Controller.SelectedRows[i].Values[cxGridGoods_GOODSID.Index]);
    end;

  // exec
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCTrUpdateGoods;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_RECALC_GOODS_PRICE(:GOODSLIST)';
            Query.ParamByName('GoodsList').AsString := S;
            Query.ExecSQL;
            Query.Transaction.Commit;
        except
            on e: Exception do
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

function TfrmGoodsBrowser.DoReCalcGoodsStockDB(const FirmaID, GoodsID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;

    Query := TIBCQuery.Create(Self);
    try
        Query.AutoCommit := False;
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE (:DT,:GOODSID)';
        Query.ParamByName('DT').AsInteger := FirmaID;
        Query.ParamByName('GOODSID').AsInteger := GoodsID;

        try
            Query.Transaction.StartTransaction;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;

        except
            on e: Exception do
            begin
                if Query.Transaction.Active then
                    Query.Transaction.Rollback;
                if not ProcessSWNError(e) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbQty1Click(Sender: TObject);
// var
// i: integer;
// GoodsID: integer;
/// /  Query: TIBCQuery;
// Bookmark: TBookMark;
begin
  // Bookmark := IBCQueryGoods.GetBookmark;
  // for i := 0 to cxGridGoods_Table.Controller.SelectedRowCount - 1 do
  // begin
  // GoodsID := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].Index,
  // cxGridGoods_GOODSID.Index];
  // dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_SET_FLG_FORCE_ADDON(:GOODSID,:FLG_FORCED_ADDON)', [GoodsID,
  // TdxBarButton(Sender).Tag]);
  // end;
  //
  // IBCQueryGoods.Refresh;
  //
  // IBCQueryGoods.GotoBookmark(Bookmark);
  // IBCQueryGoods.FreeBookmark(Bookmark);

end;

procedure TfrmGoodsBrowser.dxBarButton10Click(Sender: TObject);
var
    frmShowWebGoodsProperties: TfrmShowWebGoodsProperties;
begin
    frmShowWebGoodsProperties := TfrmShowWebGoodsProperties.Create(Owner);
    try
        if IBCQueryGoods.FieldByName('TITLE_WEB').AsString = '' then
            frmShowWebGoodsProperties.GoodsName := IBCQueryGoods.FieldByName('TITLE').AsString
        else
            frmShowWebGoodsProperties.GoodsName := IBCQueryGoods.FieldByName('TITLE_WEB').AsString;

        frmShowWebGoodsProperties.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        frmShowWebGoodsProperties.ShowModal;
    finally
        frmShowWebGoodsProperties.Free;
    end;
end;

procedure TfrmGoodsBrowser.dxBarButton11Click(Sender: TObject);
var
    d: TfrmSelectGoodsDlg;
    q: TIBCQuery;
begin
    d := TfrmSelectGoodsDlg.Create(Self, dmDB.IBCConnection);
    q := TIBCQuery.Create(nil);
    try
        if d.SelectGoods(IBCQueryGoods.FieldByName('GOODSID').AsInteger, IBCQueryGoods.FieldByName('TITLE').AsString) then
        begin
            q.Transaction := IBCTrUpdateGoods;
            q.AutoCommit := False;
            if not IBCTrUpdateGoods.Active then
                IBCTrUpdateGoods.StartTransaction;

            q.SQL.Text := 'EXECUTE PROCEDURE IMPORT_RELATED_KEYS(:FROM_GOODSID, :TO_GOODSID)';
            q.ParamByName('FROM_GOODSID').AsInteger := d.GoodsID;
            q.ParamByName('TO_GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            try
                q.Execute;
                IBCTrUpdateGoods.Commit;
            except
                begin
                    IBCTrUpdateGoods.Rollback;
                    raise;
                end;
            end;
        end;
    finally
        d.Free;
        q.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbRelatedProductsClick(Sender: TObject);
var
    d: TfrmGoodsRelatedDlg;
    q: TIBCQuery;
begin
    d := TfrmGoodsRelatedDlg.Create(Self);
    q := TIBCQuery.Create(nil);
    d.dtDialogTitle.Title := 'Gestionarea chei produse inrudite';
    d.dtDialogTitle.Text := '#' + IBCQueryGoods.FieldByName('GOODSID').AsString + ' ' + IBCQueryGoods.FieldByName('TITLE').AsString;
    d.OnMultiAddRelatedGoods := MultiAddRelatedGoods;
    q.SQL.Text := 'SELECT RELATED_KEY FROM TS_GOODS WHERE GOODSID = :PARENTID';
    q.ParamByName('PARENTID').AsInteger := IBCQueryGoods.FieldByName('PARENTID').AsInteger;
    q.Open;

    try
        d.SelectMode := True;
        d.BrowseGoodsRelatedKeys(IBCQueryGoods.FieldByName('GOODSID').AsInteger, IBCQueryGoods.FieldByName('CODE').AsString, IBCQueryGoods.FieldByName('VENDOR').AsString, q.FieldByName('RELATED_KEY').AsString);
        IBCQueryGoods.RefreshRecord;
    finally
        d.Free;
        q.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbLoanOfferClick(Sender: TObject);
var
    dialog: TfrmCreditFinalInfoDialog;
begin
    dialog := TfrmCreditFinalInfoDialog.Create(Self, dmDB.IBCConnection);
    try
        dialog.ListOfGoodsID := IBCQueryGoods.FieldByName('GOODSID').AsString;
        dialog.SumaCredit := IBCQueryGoods.FieldByName('PRICE1_LEI').AsFloat;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbRecalcComplectPriceClick(Sender: TObject);
var
    Query: TIBCQuery;
begin
  // recalcul pret complect din complectatia curenta
    if (IBCQueryGoods.FieldByName('GOODS_TYPE_ID').AsInteger = 4202) or (IBCQueryGoods.FieldByName('GOODS_TYPE_ID').AsInteger = 4212) then
    begin

        Query := TIBCQuery.Create(Self);
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE UPDATE_COMPLECTPRICES (:complectgoodsid)';
            Query.ParamByName('COMPLECTGOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            Query.Transaction := dmDB.IBCTrDefaultUpdate;
            try
                if not Query.Transaction.Active then
                    Query.Transaction.StartTransaction;
                Query.Execute;
                Query.Transaction.Commit;
                IBCQueryGoods.Refresh;
            except
                on e: Exception do
                begin
                    Query.Transaction.Rollback;
                    raise
                end;
            end;
        finally
            Query.Free;
        end;

    end;
end;

procedure TfrmGoodsBrowser.bbGoodsImagesClick(Sender: TObject);
begin
    frmGoodsImage := TfrmGoodsImageViewer.Create(Self);
    frmGoodsImage.FormStyle := fsStayOnTop;
    frmGoodsImage.Connection := dmDB.IBCConnection;
    frmGoodsImage.MasterDataSource := IBCDataSourceGoods;
    frmGoodsImage.MasterFields := 'GOODSID';
    frmGoodsImage.Show;
end;

procedure TfrmGoodsBrowser.bbConvertJPEG2PNGClick(Sender: TObject);
var
    List: TStringList;
begin
    List := TStringList.Create;
    try
        IBCQueryGoods.First;
        while not IBCQueryGoods.Eof do
        begin
            try
                ConvertJpeg2PNG;
                Application.ProcessMessages;
            except
                List.Add(IBCQueryGoods.FieldByName('GOODSID').AsString);
            end;
            IBCQueryGoods.Next;
        end;

    finally
        if List.Count >= 1 then
            ShowMessage('Convert with errors for goodsid (' + List.CommaText + ')');

        List.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbGoodsTitleClick(Sender: TObject);
var
    dialog: TfrmChangeGoodsTitleDlg;
begin
    dialog := TfrmChangeGoodsTitleDlg.Create(Self);
    try
        dialog.ParentID := IBCQueryGoods.FieldByName('PARENTID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.dxBarButton1Click(Sender: TObject);
var
    btn: TdxBarButton;
begin
  // NEW = 2
    btn := TdxBarButton(Sender);
    if (btn.Tag > 0) then
        SetGoodsWebFlags(2, 0, Now, Now + btn.Tag, GetSelectionIDList)
    else
        DeleteGoodsWebFlags(2, GetSelectionIDList);
    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.dxBarButton4Click(Sender: TObject);
var
    btn: TdxBarButton;
begin
  // PROMO = 1
    btn := TdxBarButton(Sender);
    if (btn.Tag > 0) then
        SetGoodsWebFlags(1, 0, Now, Now + btn.Tag, GetSelectionIDList)
    else
        DeleteGoodsWebFlags(1, GetSelectionIDList);
    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.dxBarButton7Click(Sender: TObject);
var
    dialog: TfrmDatePeriodDlg;
begin
    dialog := TfrmDatePeriodDlg.Create(Self);
    try
        dialog.SetTitles('Web flag - Produs nou', 'Perioada de actiune');
        if dialog.ShowModal = mrOk then
        begin
            SetGoodsWebFlags(2, 0, dialog.DateStart, dialog.DateEnd, GetSelectionIDList);
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.dxBarButton8Click(Sender: TObject);
var
    dialog: TfrmDatePeriodDlg;
begin
    dialog := TfrmDatePeriodDlg.Create(Self);
    try
        dialog.SetTitles('Web flag - Produs Promo', 'Perioada de actiune');
        if dialog.ShowModal = mrOk then
        begin
            SetGoodsWebFlags(1, 0, dialog.DateStart, dialog.DateEnd, GetSelectionIDList);
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.dxBarButton9Click(Sender: TObject);

    procedure ConvertWebp;
    var
        q: TIBCQuery;
        png: TPngImage;
        GoodsImageID: Integer;
        ms: TMemoryStream;
        img: TGPBitmap;
        qUpd: TIBCQuery;
    begin
        q := TIBCQuery.Create(Self);
        png := TPngImage.Create;
        try
            q.SQL.Text := 'SELECT IMAGE, GOODS_IMAGE_ID FROM TS_GOODS_IMAGE WHERE GOODSID=:GOODSID';
            q.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            q.Open;
            while not q.Eof do
            begin
                GoodsImageID := q.FieldByName('GOODS_IMAGE_ID').AsInteger;
                TBlobField(q.FieldByName('IMAGE')).SaveToFile('tmp.png');

                try
                    png.LoadFromFile('tmp.png');
                except
                    begin
                        q.Free;
                        png.Free;
                        Exit;
                    end;
                end;
                img := TGPBitmap.Create('tmp.png');
                try
                    WebpEncode(ms, img, 100);
                    ms.SaveToFile('tmp.webp');

                except
                    begin
                        q.Free;
                        png.Free;
                        Exit;
                    end;
                end;

                qUpd := TIBCQuery.Create(Self);
                qUpd.Connection := dmDB.IBCConnection;
                qUpd.Transaction := dmDB.IBCTrDefaultUpdate;

                try
                    qUpd.SQL.Text := 'UPDATE TS_GOODS_IMAGE SET IMAGE = :IMAGE WHERE GOODSID=:GOODSID AND GOODS_IMAGE_ID=:GOODS_IMAGE_ID';
                    qUpd.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
                    qUpd.ParamByName('GOODS_IMAGE_ID').AsInteger := GoodsImageID;
                    qUpd.ParamByName('IMAGE').LoadFromFile('tmp.webp', ftBlob);
                    qUpd.ExecSQL;
                finally
                    qUpd.Free
                end;
                q.Next;
            end;
        finally
            q.Free;
            png.Free;
        end;

    end;

var
    List: TStringList;
begin
    List := TStringList.Create;
    try
        while not IBCQueryGoods.Eof do
        begin
            try
                ConvertWebp;
                Application.ProcessMessages;
            except
                List.Add(IBCQueryGoods.FieldByName('GOODSID').AsString);
            end;
            IBCQueryGoods.Next;
        end;

    finally
        if List.Count >= 1 then
            ShowMessage('Convert with errors for goodsid (' + List.CommaText + ')');

        List.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbAddToPromoClick(Sender: TObject);
var
    dialog: TfrmSelectPromotionDlg;
begin
    dialog := TfrmSelectPromotionDlg.Create(Self, dmDB.IBCConnection, dmDB.IBCTrDefaultSelect, dmdb.IBCTrDefaultUpdate);
    try
        if dialog.ShowModal = mrOK then
        begin
            AddGoodsToPromotion(dialog.PromoActionID);

        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbAddToWebCatalogClick(Sender: TObject);
begin
    AddFolderToWebCatalog;
end;

procedure TfrmGoodsBrowser.bbChangeFiltersValueClick(Sender: TObject);
var
    dialog: TfrmGoodsChangeFilters;
    FilterID: Integer;
    FilterParamID: Integer;
    qd: TIBCSQL;
    qi: TIBCSQL;
    tmpGoodsID: Integer;
    ErrorList: TStringList;
begin
    dialog := TfrmGoodsChangeFilters.Create(Self, dmDB.IBCConnection);
    try
        if (dialog.ShowModal = mrOk) then
        begin

            FilterID := dialog.beFilters.Tag;
            FilterParamID := dialog.beParamValue.Tag;

            ErrorList := TStringList.Create;
            qd := TIBCSQL.Create(nil);
            qi := TIBCSQL.Create(nil);

            qd.AutoCommit := False;
            qi.AutoCommit := False;

            if not dmDB.IBCTrDefaultUpdate.Active then
                dmDB.IBCTrDefaultUpdate.StartTransaction;

            try
        {$region 'init delete and insert sql and prepare' fold}
                qd.Transaction := dmDB.IBCTrDefaultUpdate;
                qd.SQL.Text := 'Delete from ts_goods_descriptions where goodsid = :goodsid and filterid = :filterid';
                qd.Prepare;

                qi.Transaction := dmDB.IBCTrDefaultUpdate;
                qi.SQL.Add('insert into ts_goods_descriptions (goodsid, filterid, filterparamid, flg_group, flags)');
                qi.SQL.Add('values(:goodsid, :filterid, :filterparamid, :flg_group, :flags)');
                qi.Prepare;
        {$endregion}

        {$REGION 'loop through grid and update data' fold }
                for var i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
                begin
                    try
                        if (cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_FLG_FOLDER.Index] = 0) then
                        begin
                            tmpGoodsID := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_GOODSID.Index];

                            qd.ParamByName('goodsid').AsInteger := tmpGoodsID;
                            qd.ParamByName('filterid').AsInteger := FilterID;
                            qd.Execute;

                            if dialog.AppendMode then
                            begin

                                qi.ParamByName('goodsid').AsInteger := tmpGoodsID;
                                qi.ParamByName('filterid').AsInteger := FilterID;
                                qi.ParamByName('filterparamid').AsInteger := FilterParamID;
                                qi.ParamByName('flg_group').AsInteger := 0;
                                qi.ParamByName('flags').AsInteger := 1;
                                qi.Execute;
                            end;
                        end;

                    except
                        on e: Exception do
                        begin
                            ErrorList.Add(Format('Eroare la adaugare! Produsul: %d FilterID: %d FilterParamID: %d, %s', [GoodsID, FilterID, FilterParamID, e.Message]));
                        end;
                    end;
                end;
        {$ENDREGION }

        // commit transaction after loop
                if dmDB.IBCTrDefaultUpdate.Active then
                    dmDB.IBCTrDefaultUpdate.Commit;

                if ErrorList.Count > 0 then
                    ShowMessage(ErrorList.Text);
            finally
                qd.Free;
                qi.Free;
                ErrorList.Free;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.bbConvertGIF2PNGClick(Sender: TObject);
var
    List: TStringList;
begin
  // IBCQueryGoods.First;
    List := TStringList.Create;
    try
        while not IBCQueryGoods.Eof do
        begin
            try
                ConvertGif2PNG;
                Application.ProcessMessages;
            except
                List.Add(IBCQueryGoods.FieldByName('GOODSID').AsString);
            end;
            IBCQueryGoods.Next;
        end;

    finally
        if List.Count >= 1 then
            ShowMessage('Convert with errors for goodsid (' + List.CommaText + ')');

        List.Free;
    end;
end;

procedure TfrmGoodsBrowser.ConvertGif2PNG;
var
    png: TPngImage;
    p: TPicture;
    q: TIBCQuery;
    qUpd: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);
    p := TPicture.Create;

    try
        q.SQL.Text := 'SELECT IMAGE FROM TS_GOODS_IMAGE WHERE GOODSID=:GOODSID';
        q.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        q.Open;
        TBlobField(q.FieldByName('IMAGE')).SaveToFile('tmp.jpeg');

        try
            p.LoadFromFile('tmp.jpeg');
        except
            Exit;
        end;

        png := TPngImage.CreateBlank(COLOR_RGB, 8, p.Width, p.Height);
        try
            png.Canvas.FillRect(rect(0, 0, p.Width, p.Height));
            png.Canvas.Draw(0, 0, p.Graphic);
            png.RemoveTransparency;
            png.CompressionLevel := 9;
            png.SaveToFile('tmp.png');

        finally
            png.Free;
        end;

        qUpd := TIBCQuery.Create(Self);
        qUpd.Connection := dmDB.IBCConnection;
    // qUpd.Transaction := dmdb.IBCTrDefaultSelect;
        qUpd.Transaction := dmDB.IBCTrDefaultUpdate;

        try
            qUpd.SQL.Text := 'UPDATE TS_GOODS_IMAGE SET IMAGE = :IMAGE WHERE GOODSID=:GOODSID AND GOODS_IMAGE_ID=1';
            qUpd.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            qUpd.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
            qUpd.ExecSQL;

        finally
            qUpd.Free
        end;
    finally
        q.Free;
        p.Free;
    end;

end;

procedure TfrmGoodsBrowser.ConvertJpeg2PNG;
var
    GoodsImageID: Integer;
    png: TPngImage;
    jpeg: TJPEGImage;
    q: TIBCQuery;
    qUpd: TIBCQuery;
begin
    q := TIBCQuery.Create(Self);
    jpeg := TJPEGImage.Create;
    try
        q.SQL.Text := 'SELECT IMAGE, GOODS_IMAGE_ID FROM TS_GOODS_IMAGE WHERE GOODSID=:GOODSID';
        q.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        q.Open;
        while not q.Eof do
        begin
            GoodsImageID := q.FieldByName('GOODS_IMAGE_ID').AsInteger;
            TBlobField(q.FieldByName('IMAGE')).SaveToFile('tmp.jpeg');

            try
                jpeg.LoadFromFile('tmp.jpeg');
            except
                begin
                    q.Free;
                    jpeg.Free;
                    Exit;
                end;
            end;
            png := TPngImage.CreateBlank(COLOR_RGB, 8, jpeg.Width, jpeg.Height);

            try
                png.Canvas.FillRect(rect(0, 0, jpeg.Width, jpeg.Height));
                png.Canvas.Draw(0, 0, jpeg);
                png.RemoveTransparency;
                png.CompressionLevel := 5;
                png.SaveToFile('tmp.png');

            except
                begin
                    q.Free;
                    jpeg.Free;
                    png.Free;
                    Exit;
                end;
            end;

            qUpd := TIBCQuery.Create(Self);
            qUpd.Connection := dmDB.IBCConnection;
            qUpd.Transaction := dmDB.IBCTrDefaultUpdate;

            try
                qUpd.SQL.Text := 'UPDATE TS_GOODS_IMAGE SET IMAGE = :IMAGE WHERE GOODSID=:GOODSID AND GOODS_IMAGE_ID=:GOODS_IMAGE_ID';
                qUpd.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
                qUpd.ParamByName('GOODS_IMAGE_ID').AsInteger := GoodsImageID;
                qUpd.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
                qUpd.ExecSQL;
            finally
                qUpd.Free
            end;
            q.Next;
        end;
    finally
        q.Free;
        jpeg.Free;
    end;
end;

procedure TfrmGoodsBrowser.cxGridStockFirmaTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    IBCQueryStockWarehouse.Active := False;
    IBCQueryStockWarehouse.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
    IBCQueryStockWarehouse.ParamByName('DT').AsInteger := IBCQueryStockFirms.FieldByName('DT').AsInteger;
    IBCQueryStockWarehouse.Active := True;
end;

procedure TfrmGoodsBrowser.bbSendToArchiveClick(Sender: TObject);
begin
    dmDB.ExecuteQuery('EXECUTE PROCEDURE SP_MOVE_GOODS2ARCHIVE(:GOODSID)', [IBCQueryGoods.FieldByName('GOODSID').AsInteger, 206557]);
    IBCQueryGoods.Refresh;
end;

procedure TfrmGoodsBrowser.cxGridGoods_TableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    SelectedRecordChanged;
end;

procedure TfrmGoodsBrowser.dxBarButton12Click(Sender: TObject);
begin
    cxGridGoods_Table.Preview.Visible := not cxGridGoods_Table.Preview.Visible;
end;

procedure TfrmGoodsBrowser.dxBarButton13Click(Sender: TObject);
var
    d: TfrmGoodsByCategoryFolderDlg;
begin
    d := TfrmGoodsByCategoryFolderDlg.Create(Self, dmdb.IBCConnection);
    try
        d.ParentID := ibcquerygoods.FieldByName('parentid').AsInteger;
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure TfrmGoodsBrowser.dxBarSubItemVIEWPopup(Sender: TObject);
begin
    miMultiSelect.Down := cxGridGoods_Table.OptionsSelection.MultiSelect;
end;

procedure TfrmGoodsBrowser.EnableCondition(const ConditionIndex: Integer; const CustomConditionInProc: string; const CustomConditionInWhere: string);
begin
    fInSearch := False;
    IBCQueryGoods.Close;
    case ConditionIndex of
        0:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 1; // by parent
                IBCQueryGoods.ParamByName('SEARCH').Value := Null;
                IBCQueryGoods.FilterSQL := '';
            end;
        1:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 2;
                IBCQueryGoods.ParamByName('SEARCH').Value := Null;
                IBCQueryGoods.FilterSQL := '';
            end;
        2:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 3; // search
                IBCQueryGoods.ParamByName('PARENTID').Value := Null;
                IBCQueryGoods.ParamByName('SEARCH').AsString := CustomConditionInProc;
                IBCQueryGoods.FilterSQL := CustomConditionInWhere;
            end;
        3:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 4; // доступные
                IBCQueryGoods.ParamByName('SEARCH').Value := Null;
                IBCQueryGoods.FilterSQL := '';
            end;
        4:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 5; // Cod produs furnizor
                IBCQueryGoods.ParamByName('PARENTID').Value := Null;
                IBCQueryGoods.ParamByName('SEARCH').Value := CustomConditionInProc;
                IBCQueryGoods.FilterSQL := '';
            end;
        5:
            begin
                IBCQueryGoods.ParamByName('MODE').AsInteger := 6; // cautare complexa algoritmul de pe web
                IBCQueryGoods.ParamByName('PARENTID').Value := Null;
                IBCQueryGoods.ParamByName('SEARCH').Value := CustomConditionInProc;
                IBCQueryGoods.FilterSQL := '';
            end;

    end;
end;

function TfrmGoodsBrowser.GetGoodsCurrency(Index: Integer): Integer;
begin
    case Index of
        1:
            Result := IBCQueryGoods.FieldByName('CURRENCY1ID').AsInteger;
        2:
            Result := IBCQueryGoods.FieldByName('CURRENCY2ID').AsInteger;
        3:
            Result := IBCQueryGoods.FieldByName('CURRENCY3ID').AsInteger;
        4:
            Result := IBCQueryGoods.FieldByName('CURRENCY4ID').AsInteger;
        5:
            Result := IBCQueryGoods.FieldByName('CURRENCY5ID').AsInteger;
        6:
            Result := IBCQueryGoods.FieldByName('CURRENCY6ID').AsInteger;
        7:
            Result := IBCQueryGoods.FieldByName('CURRENCY7ID').AsInteger;
    else
        Result := IBCQueryGoods.FieldByName('CURRENCY1ID').AsInteger;
    end;
end;

function TfrmGoodsBrowser.GetGoodsPrice(Index: Integer): Currency;
begin
    case Index of
        0:
        begin
           if IBCQueryGoods.FieldByName('PRICE0').AsCurrency > 0 then
              Result := IBCQueryGoods.FieldByName('PRICE0').AsCurrency
           else
              Result := IBCQueryGoods.FieldByName('PRICE7').AsCurrency
        end;
        1:
            Result := IBCQueryGoods.FieldByName('PRICE1').AsCurrency;
        2:
            Result := IBCQueryGoods.FieldByName('PRICE2').AsCurrency;
        3:
            Result := IBCQueryGoods.FieldByName('PRICE3').AsCurrency;
        4:
            Result := IBCQueryGoods.FieldByName('PRICE4').AsCurrency;
        5:
            Result := IBCQueryGoods.FieldByName('PRICE5').AsCurrency;
        6:
            Result := IBCQueryGoods.FieldByName('PRICE6').AsCurrency;
        7:
            Result := IBCQueryGoods.FieldByName('PRICE7').AsCurrency;
    else
        Result := IBCQueryGoods.FieldByName('PRICE1').AsCurrency;
    end;
end;

function TfrmGoodsBrowser.GetGoodsPriceMDL(Index: Integer): Currency;
begin
    case Index of
//        0:
//            Result := IBCQueryGoods.FieldByName('PRICE7_LEI').AsCurrency;
        1:
            Result := IBCQueryGoods.FieldByName('PRICE1_LEI').AsCurrency;
        2:
            Result := IBCQueryGoods.FieldByName('PRICE2_LEI').AsCurrency;
        3:
            Result := IBCQueryGoods.FieldByName('PRICE3_LEI').AsCurrency;
        4:
            Result := IBCQueryGoods.FieldByName('PRICE4_LEI').AsCurrency;
        5:
            Result := IBCQueryGoods.FieldByName('PRICE5_LEI').AsCurrency;
        6:
            Result := IBCQueryGoods.FieldByName('PRICE6_LEI').AsCurrency;
        7:
            Result := IBCQueryGoods.FieldByName('PRICE7_LEI').AsCurrency;
    else
        Result := IBCQueryGoods.FieldByName('PRICE1_LEI').AsCurrency;
    end;
end;

function TfrmGoodsBrowser.GetSelectionIDList: string;
var
    i: Integer;
begin
  // comment here
    Result := '';
    for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
    begin
        if Result <> '' then
            Result := Result + ',';
        Result := Result + IntToStr(cxGridGoods_Table.Controller.SelectedRecords[i].Values[cxGridGoods_GOODSID.Index]);
    end;
end;

procedure TfrmGoodsBrowser.IBCQueryGoodsAfterOpen(DataSet: TDataSet);
begin
    dxStatusBar1.Panels[0].Text := Format('Total rec: %d', [DataSet.RecordCount]);
end;

procedure TfrmGoodsBrowser.IBC_GOODS_RecomendationAfterInsert(DataSet: TDataSet);
begin
    IBC_GOODS_Recomendation.FieldByName('CUSTOMERID').AsInteger := -1;
end;

function TfrmGoodsBrowser.IsSerialTypePartNumber(const SerialType: Integer): Boolean;
begin
    Result := SerialType = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет;
end;

procedure TfrmGoodsBrowser.SetupPriceMarginColumns;
begin
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_1) then
    begin
    // LEI
        cxGridGoods_PRICEC1_LEI.Visible := False;
        cxGridGoods_PRICEC1_LEI.VisibleForCustomization := False;
    end;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_3) then
    begin
    end;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4) or SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridGoods_PRICE4.Visible := False;
        cxGridGoods_PRICE4.VisibleForCustomization := False;

    end;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_5) or SWNSecurityManager.IsPartialAccessMode then
    begin
    end;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_6) then
    begin
    end;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7) or SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridGoods_PRICE7.Visible := False;
        cxGridGoods_PRICE7.VisibleForCustomization := False;
    end;

  // Margin Columns
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Просмотр_рентабельности) or SWNSecurityManager.IsPartialAccessMode then
    begin
        bbPriceMargins.Visible := ivNever;
//    bbSubColorFlags.Visible := ivNever;
    end;
end;

function TfrmGoodsBrowser.IsSerialTypeSerialNumber(const SerialType: Integer): Boolean;
begin
    Result := (SerialType = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет);
end;

function TfrmGoodsBrowser.ItemSelected: Boolean;
var
    mynotification: TNotification;
begin
    Result := False;

    if (IBCQueryGoods.RecordCount = 0) or (not fSelectMode) then
        Exit;

    if (IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1) then
    begin
        if fAllowSelectFolder then
        begin
            fGoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            fGoodsTitle := IBCQueryGoods.FieldByName('TITLE').AsString;
            fGoodsIsFolder := True;
            WebGoodsTypeID := IBCQueryGoods.FieldByName('webgoodstype_id').AsInteger;
            Result := True;

            if (Assigned(fOnCheckIfGoodsExists) and fOnCheckIfGoodsExists(fGoodsID)) then
            begin
                mynotification := SwnNotificationCenter.CreateNotification;
                try
                    mynotification.Name := 'SWNNotification';
                    mynotification.Title := 'SWN notification';
                    mynotification.AlertBody := 'Produsul exista in lista!';
                    SwnNotificationCenter.PresentNotification(mynotification);
                finally
                    mynotification.Free;
                end;
                Result := False;
            end

        end;
    end
    else
    begin
        fGoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        fGoodsTitle := IBCQueryGoods.FieldByName('TITLE').AsString;
        fGoodsWarranty := IBCQueryGoods.FieldByName('WARRANTY').AsInteger;
        fGoodsPriceCurrencyID := IBCQueryGoods.FieldByName('CURRENCYID').AsInteger;
        fGoodsQuantityAvailable := IBCQueryGoods.FieldByName('QTY_AVAILABLE').AsFloat;
        fGoodsUMID := IBCQueryGoods.FieldByName('UMID').AsInteger;
        fGoodsIsFolder := False;
        fGoodsSerialType := IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger;
        FCurrentParentID := IBCQueryGoods.FieldByName('PARENTID').AsInteger;
        fWebGoodsTypeID := IBCQueryGoods.FieldByName('webgoodstype_id').AsInteger;
        SetGoodsVendorID(IBCQueryGoods.FieldByName('vendor_id').AsInteger);
        Result := True;
        if Assigned(fOnCheckIfGoodsExists) and (not FBurstMode) and fOnCheckIfGoodsExists(fGoodsID) then
        begin
            mynotification := SwnNotificationCenter.CreateNotification;
            try
                mynotification.Name := 'SWNNotification';
                mynotification.Title := 'SWN notification';
                mynotification.AlertBody := 'Produsul exista in lista!';
                SwnNotificationCenter.PresentNotification(mynotification);
            finally
                mynotification.Free;
            end;
            Result := False;
        end
    end;
end;

procedure TfrmGoodsBrowser.LoadStates;
var
    qtyDigitsMode: Integer;
begin
    AppUserConfigStorage.OpenSection(Self.Name + IntToStr(Ord(fCompactMode)));
    try
    // form position
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then
            Self.Position := poDesigned;
    // read column visibility and width
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
            AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridGoods_Table);

        bbFastMode.Down := false; //AppUserConfigStorage.BooleanValues.GetValue('GoodsFastMode', False);

    finally
        AppUserConfigStorage.CloseSection;
    end;

  // current session setting
    AppUserTempConfigStorage.OpenSection(Self.Name + IntToStr(Ord(fCompactMode)));
    try
    // grid MultiSelect
        cxGridGoods_Table.OptionsSelection.MultiSelect := AppUserTempConfigStorage.BooleanValues.GetValue('MultiSelect');
    finally
        AppUserTempConfigStorage.CloseSection;
    end;

  // Numarul de zecimale in QTY :
    qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
  // Остаток
    TcxCalcEditProperties(cxGridGoods_QTY_AVAILABLE.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Остаток по филиалам
    TcxCalcEditProperties(cxGridGoods_QTY_FILIALE.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Остаток по франчизам
    TcxCalcEditProperties(cxGridGoods_QTY_FRANCIZE.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Остаток по Администрации
    TcxCalcEditProperties(cxGridGoods_QTY_INTERNAL.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Остаток Брак
    TcxCalcEditProperties(cxGridGoods_QTY_RMA.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Товаров в перемещениях
    TcxCalcEditProperties(cxGridGoods_QTY_TRANSIT.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];

  // Остаток по фирмам
    TcxCalcEditProperties(cxGridStockFirmaTable_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
    TcxCalcEditProperties(cxGridStockFirmaTable_TRANSIT_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
  // Остаток по складам
    TcxCalcEditProperties(cxGridStocksTableColumn3.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];

end;

procedure TfrmGoodsBrowser.miMultiSelectClick(Sender: TObject);
begin
    miMultiSelect.Down := True;
//    if miMultiSelect.Down then
//    begin
//        cxGridGoods_Table.OptionsSelection.MultiSelect := True;
//        cxGridGoods_Table.OptionsSelection.CellSelect := False;
//    end
//    else
//    begin
//        cxGridGoods_Table.OptionsSelection.MultiSelect := False;
//        cxGridGoods_Table.OptionsSelection.CellSelect := True;
//        cxGridGoods_TITLE.Focused := True;
//    end;
end;

procedure TfrmGoodsBrowser.NavigateAvailableGoods;
var
    ParentID: Integer;
begin
    ParentID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
    EnableCondition(3);
    IBCQueryGoods.ParamByName('PARENTID').AsInteger := ParentID;
    fInSearch := True;
    FCurrentParentID := ParentID;
    IBCQueryGoods.Open;
end;

procedure TfrmGoodsBrowser.NavigateBack;
var
    ParentID: Integer;
begin
    PrepareGrid;
    if IBCQueryGoods.Eof then
    begin
    // no records
        if FCurrentParentID = -1 then
            ParentID := fRootParentID
        else
            ParentID := FCurrentParentID;
    end
    else
    begin
        ParentID := IBCQueryGoods.FieldByName('PARENTID').AsInteger;
    end;

    if fInSearch then
    begin
        NavigateToHome(ParentID);
    end
    else if (ParentID <> fRootParentID) then
    begin
        EnableCondition(1); // Browse Backward
        IBCQueryGoods.ParamByName('PARENTID').AsInteger := ParentID;
        IBCQueryGoods.Open;

        FCurrentParentID := ParentID;
        IBCQueryGoods.FilterSQL := '';
        IBCQueryGoods.Locate('GOODSID', ParentID, []);
        fCurrentParentGoodsTypeID := -1;
        fCurrentParentWEBGoodsTypeID := -1;
    end;
end;

procedure TfrmGoodsBrowser.NavigateForward;
var
    ParentID: Integer;
begin
    PrepareGrid;
    if (not IBCQueryGoods.Active) or (IBCQueryGoods.RecordCount = 0) then
    begin
        ParentID := 0;
        fCurrentParentGoodsTypeID := -1;
        fCurrentParentWEBGoodsTypeID := -1;
        fCurrentParentSerialTypeID := 4403;
    end
    else
    begin
        ParentID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        fCurrentParentGoodsTypeID := IBCQueryGoods.FieldByName('GOODS_TYPE_ID').AsInteger;
        fCurrentParentWEBGoodsTypeID := IBCQueryGoods.FieldByName('WEBGOODSTYPE_ID').AsInteger;
        fCurrentParentSerialTypeID := IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger;
    end;
    if not ExtFilter then
        EnableCondition(0) // Browse Forward
    else
        ExtFilter := False;

    IBCQueryGoods.ParamByName('PARENTID').AsInteger := ParentID;
    IBCQueryGoods.ParamByName('FLG_ONLY_IN_PRICE').AsInteger := 1;
  // ibcquerygoods.FilterSQL := '(flg_price_forced = 1 or qty_available<>0 or qty_internal <> 0 or flg_folder = 1)';

    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
  // 'ORDER BY FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE';
    FCurrentParentID := ParentID;
    IBCQueryGoods.Open;
end;

procedure TfrmGoodsBrowser.NavigateSearch(const WhereConditionsInProc, WhereConditionsInSQL: string);
begin
    PrepareGrid;
    EnableCondition(2, WhereConditionsInProc, WhereConditionsInSQL); // Search
    fInSearch := True;
    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
  // 'ORDER BY FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE';
    IBCQueryGoods.Open;
    FCurrentParentID := -1;
end;

procedure TfrmGoodsBrowser.NavigateSearchForeignCode(const WhereConditionsInProc, WhereConditionsInSQL: string);
begin
    PrepareGrid;
    EnableCondition(4, WhereConditionsInProc, WhereConditionsInSQL); // Search
    fInSearch := True;
    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
  // 'ORDER BY FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE';
    IBCQueryGoods.Open;
    FCurrentParentID := -1;
end;

procedure TfrmGoodsBrowser.NavigateSearchGoodsComposite(const WhereConditionsInProc, WhereConditionsInSQL: string);
begin
    PrepareGrid;
    EnableCondition(5, WhereConditionsInProc, WhereConditionsInSQL); // Search
    fInSearch := True;
    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
    IBCQueryGoods.Open;
    FCurrentParentID := -1;
end;

procedure TfrmGoodsBrowser.NavigateToGoods(const GoodsID: Integer);
begin
    PrepareGrid;
    EnableCondition(1); // Browse Backward
    IBCQueryGoods.ParamByName('PARENTID').AsInteger := GoodsID;
    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
  // 'ORDER BY FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE';
    IBCQueryGoods.Open;
    IBCQueryGoods.Locate('GOODSID', GoodsID, []);
    FCurrentParentID := IBCQueryGoods.FieldByName('ParentID').AsInteger;
    fCurrentParentGoodsTypeID := -1;
    fCurrentParentWEBGoodsTypeID := -1;
end;

procedure TfrmGoodsBrowser.NavigateToHome(const RootID: Integer);
begin
    PrepareGrid;
    EnableCondition(0); // Browse Forward
    IBCQueryGoods.ParamByName('ParentID').AsInteger := RootID;
    FCurrentParentID := RootID;
    IBCQueryGoods.MacroByName('ORDERBY').Value := '';
  // 'ORDER BY FLG_FOlDER DESC, QTY_AVAILABLE DESC, FLG_PRICE_FORCED DESC, ORDERNO, TITLE';
    IBCQueryGoods.Open;
end;

procedure TfrmGoodsBrowser.Prepare;
begin
    dmDB.CreateGridImageColumnItems(cxGridGoods_IMG, True);

    IBCQueryGoods.ParamByName('DT').AsInteger := dmDB.CurrentFirma;

    if fGoodsID > 0 then
        NavigateToGoods(fGoodsID)
    else
    begin
        if fRootParentID > 0 then
            NavigateToHome(fRootParentID)
        else
            NavigateForward
    end;

  // select default column
    cxGridGoods_TITLE.Selected := True;
    cxGridGoods_TITLE.Focused := True;
end;

procedure TfrmGoodsBrowser.SaveStates;
begin
    if SWNSecurityManager.IsPartialAccessMode then
        Exit;

    AppUserConfigStorage.OpenSection(Self.Name + IntToStr(Ord(fCompactMode)));
    try
    // form pos
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
            AppUserConfigStorage.FormPositions.SaveFormPos(Self);
    // store column visibility and width
        if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
            AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridGoods_Table);

        AppUserConfigStorage.BooleanValues.SetValue('GoodsFastMode', bbFastMode.Down);
    finally
        AppUserConfigStorage.CloseSection;
    end;

  // current session setting
    AppUserTempConfigStorage.OpenSection(Self.Name + IntToStr(Ord(fCompactMode)));
    try
    // grid MultiSelect
        AppUserTempConfigStorage.BooleanValues.SetValue('MultiSelect', cxGridGoods_Table.OptionsSelection.MultiSelect);
    finally
        AppUserTempConfigStorage.CloseSection;
    end;
end;

procedure TfrmGoodsBrowser.SelectedRecordChanged;
var
    fForward, fBack, fHome: Boolean;
    fModify, fDelete: Boolean;
    fGoodsDSC, fCompatibleGoods, fGoodsKit: Boolean;
    fQtyByStock, fQtyByFirms: Boolean;
    FLG_FOLDER: Boolean;
    curParentID: Integer;
    fShowAvailableGoods: Boolean;
    fQuickInfo: Boolean;
    fRecalcPrice, fRecalcStock: Boolean;
    fGotoGoods: Boolean;
    fGoodsInfoCard: Boolean;
    fFLG_NewGoods, fFLG_PromoGoods: Boolean;
    fSet_FLG_OLD, fSet_FLG_DISCOUNT, fBalansPoPartiam: Boolean;
    fHasSNParts, MultiSelect, fSendToNPSC: Boolean;
begin
    fForward := False;

    fQuickInfo := False;
    fModify := False;
    fDelete := False;

    fGoodsDSC := False;
    fCompatibleGoods := False;
    fGoodsKit := False;

    fQtyByStock := False;
    fQtyByFirms := False;

    fShowAvailableGoods := False;
    fRecalcPrice := False;
    fRecalcStock := False;

    FLG_FOLDER := False;
    fGotoGoods := False;
    fGoodsInfoCard := False;

    fFLG_NewGoods := False;
    fFLG_PromoGoods := False;

    fSet_FLG_OLD := False;
  // fSet_FLG_PRICE_FORCED := False;
    fSet_FLG_DISCOUNT := False;
    fBalansPoPartiam := False;
    fHasSNParts := False;
    fSendToNPSC := False;

    if cxGridGoods_Table.DataController.RecNo > 0 then
    begin
        FLG_FOLDER := IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1;
        curParentID := IBCQueryGoods.FieldByName('PARENTID').AsInteger;
        fGotoGoods := fInSearch;
        MultiSelect := cxGridGoods_Table.Controller.SelectedRecordCount > 1;

        fBack := (curParentID > 0) and (curParentID <> fRootParentID);
        fHome := fBack or (fRootParentID >= 0);

        if FLG_FOLDER then
        begin
            fForward := FLG_FOLDER and not MultiSelect;

            fModify := fSecurityFlag_CanModify_Folder and not MultiSelect;
      // Modify + security
            fDelete := fSecurityFlag_CanDelete_Folder and not MultiSelect;
      // Remove + security
            fShowAvailableGoods := (not fInSearch) and not MultiSelect;

            fGoodsDSC := not MultiSelect;
      // to allow edit folder image and description
            fSet_FLG_OLD := True;
        end
        else
        begin
            fQuickInfo := not MultiSelect;
            fModify := fSecurityFlag_CanModify_Goods and not MultiSelect;
      // Modify + security
            fDelete := fSecurityFlag_CanDelete_Goods and not MultiSelect;
      // Remove + security
            fGoodsDSC := not MultiSelect; // Описание товара + security
            fSendToNPSC := True;
            fGoodsKit := dmDB.IsKit(IBCQueryGoods.FieldByName('GOODS_TYPE_ID').AsInteger) and not MultiSelect;
            fCompatibleGoods := not MultiSelect;
      // Взаимозаменяемость товара + security
            fQtyByStock := not MultiSelect; // Остатки по складам
            fQtyByFirms := not MultiSelect; // Остатки по фирмам
            fRecalcPrice := not MultiSelect;
            fRecalcStock := not MultiSelect;

            fGoodsInfoCard := not MultiSelect; // Карточка товара
            fFLG_NewGoods := True;
            fFLG_PromoGoods := True;

      // fSet_FLG_PRICE_FORCED := True;
            fSet_FLG_DISCOUNT := True;

            fBalansPoPartiam := (IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет) // Партийный учет
                and not MultiSelect;
            fHasSNParts := ((IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет)
        // Партийный учет
                or (IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет))
      // Серийный учет
                and not MultiSelect;
        end;
    end
    else
    begin
        fBack := (FCurrentParentID > -1) and (fRootParentID <> FCurrentParentID) or fInSearch;
        fHome := fBack or (fRootParentID = 0);
    end;

  // navigation
    bbHome.Enabled := fHome;
    bbForward.Enabled := fForward;
    bbBack.Enabled := fBack;
    if fGotoGoods then
        bbFollowGoods.Visible := ivAlways
    else
        bbFollowGoods.Visible := ivNever;

  // folder+goods
    bbQuickGoodsInfo.Enabled := fQuickInfo;
    bbNewFolder.Enabled := (not fInSearch); // New Folder
    bbNewGoods.Enabled := (not fInSearch); // New Goods
    bbModify.Enabled := fModify;
    bbRemove.Enabled := fDelete;
    bbCloneGoods.Enabled := (not FLG_FOLDER) and fModify and (not fInSearch);
  // tools
    bbGoodsDescriptions.Enabled := fGoodsDSC;
    bbSendToNPSC.Enabled := fSendToNPSC;

    bbGoodsKit.Enabled := fGoodsKit;
    bbCompatibleGoods.Enabled := fCompatibleGoods;
    bbQtyByStocks.Enabled := fQtyByStock;
    bbQtyByFirms.Enabled := fQtyByFirms;
    bbArrangeFolders.Enabled := (cxGridGoods_Table.DataController.RecordCount > 0) and (not fInSearch);
    bbRecalcPrice.Enabled := fRecalcPrice;
    bbReCalcGoodsStock.Enabled := fRecalcStock;
    bbGoodsInfoCard.Enabled := fGoodsInfoCard;
    bsubFlgNewGoods.Enabled := fFLG_NewGoods;
    bsubFlgPromoGoods.Enabled := fFLG_PromoGoods;

    bbSetupPropsToSelection.Enabled := (cxGridGoods_Table.Controller.SelectedRowCount > 0) and not FLG_FOLDER;
    bbChangeParent.Enabled := cxGridGoods_Table.DataController.RecNo > 0;
    bbBalansPoPartiam.Enabled := fBalansPoPartiam;

    bbSet_FLG_OLD.Enabled := fSet_FLG_OLD;
    bbSubWebFLG_DISCOUNT.Enabled := fSet_FLG_DISCOUNT;

  // price
    bbGoodsPrice.Enabled := (bbGoodsPrice.Visible = ivAlways) and (not FLG_FOLDER) and fModify
  { and (Not fInSearch) };
    bbForeignCodes.Enabled := (not FLG_FOLDER); // and fModify { and (Not fInSearch) };
  // view
    bbShowAvailableGoods.Enabled := fShowAvailableGoods;
    bbAviableSnPartsNumbers.Enabled := fHasSNParts;

  // master-detials data
    ShowAdditionalMasterDetailsData;

  // lbNameLength.Caption := Format('(%d)', [IBCQueryGoods.FieldByName('TITLE').AsString.Length]);
    UpdatePath;

end;

function TfrmGoodsBrowser.SelectGoods(const DefaultGoodsID: Integer; const CanSelectFolder: Boolean; const RootParentID: Integer; const CustomTitle: string): Boolean;
begin
    if CustomTitle <> '' then
        Title := CustomTitle;
    AllowSelectFolder := CanSelectFolder;
    GoodsID := DefaultGoodsID;
    RootID := RootParentID;
    Result := ShowModal = mrOk;
end;

function TfrmGoodsBrowser.SendSelectedGoodsToAnalize(const GoodsList: string): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCTrUpdateGoods;
        Query.AutoCommit := False;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_SEND_ANALIZE_PRICE(:gList)';
        Query.ParamByName('gList').AsString := GoodsList;
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
            Query.Transaction.Commit;
            Result := True;
        except
            on e: Exception do
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

function TfrmGoodsBrowser.SendSelectedGoodsToPackage(const OperatorID: Integer; const GoodsList: string): Boolean;
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
            on e: Exception do
            begin
                Query.Transaction.Rollback;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmGoodsBrowser.SetBurstMode(const Value: Boolean);
begin
    FBurstMode := Value;
  // lbBurstMode.Visible := Value;
    bbBurstMode.Down := Value;
  // pnAddInfo.Visible := not Value;
end;

procedure TfrmGoodsBrowser.SetCompactMode;
begin
    fCompactMode := True;
    cxGridGoods_FLG_OLD.Visible := False;
    cxGridGoods_WARRANTY.Visible := False;
    cxGridGoods_QTY_ACCOUNT.Visible := False;
    cxGridGoods_QTY_RMA.Visible := False;
    cxGridGoods_QTY_INTERNAL.Visible := False;
    cxGridGoods_QTY_FRANCIZE.Visible := False;
  // cxGridGoods_QTY_FILIALE.Visible:=False;
    cxGridGoods_QTY_AVAILABLE.VisibleForCustomization := False;
    cxGridGoods_UM_TITLE.Visible := False;
    cxGridGoods_CODE.Visible := False;
  // ClientWidth:=732;
  // pnAddInfo.Visible := False;
end;

procedure TfrmGoodsBrowser.SetCustomeSQLFilter(const Value: string);
begin
    FCustomeSQLFilter := Value;
    if FCustomeSQLFilter <> '' then
        FCustomeSQLFilter := ' and (' + FCustomeSQLFilter + ')';
end;

procedure TfrmGoodsBrowser.SetExtFilter(const Value: Boolean);
begin
    FExtFilter := Value;
end;

procedure TfrmGoodsBrowser.SetFLG_OLD;
begin
    Cursor := crHourGlass;
    try
        dmDB.ExecuteQuery('execute procedure UPDATE_GOODS_OLD_FLAG(:foldergoodsid)', [IBCQueryGoods.FieldByName('GoodsID').AsInteger]);
        IBCQueryGoods.Refresh;
    finally
        Cursor := crDefault;
    end;
end;

procedure TfrmGoodsBrowser.SetFolderWebFlags(const FlagTypeID, Discount: Integer; const StartDate, EndDate: TDate; const FolderID: string);
// var
// Query: TIBCQuery;
begin
  // Query := TIBCQuery.Create(Self);
  // try
  // Query.Connection := dmDB.IBCConnection;
  // Query.Transaction := IBCQueryGoods.UpdateTransaction;
  // Query.SQL.Text := 'EXECUTE PROCEDURE WEB_SETUP_GOODS_FLAG3(:DT, :GOODSIDLIST, :FLAGTYPEID, :START_DATE, :END_DATE, :DISCOUNT)';
  // Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
  // Query.ParamByName('GOODSIDLIST').AsString := GoodsIDList;
  // Query.ParamByName('FLAGTYPEID').AsInteger := FlagTypeID;
  // Query.ParamByName('START_DATE').AsDate := StartDate;
  // Query.ParamByName('END_DATE').AsDate := EndDate;
  // Query.ParamByName('DISCOUNT').AsInteger := Discount;
  //
  // Query.Transaction.StartTransaction;
  // try
  // Query.ExecSQL;
  // Query.Transaction.Commit;
  // except
  // on E: Exception do
  // begin
  // Query.Transaction.Rollback;
  // if Not ProcessSWNError(E) then
  // raise;
  // end;
  // end;
  // finally
  // Query.Free;
  // end;
  // end;
end;

procedure TfrmGoodsBrowser.SetGoodsID(const Value: Integer);
begin
    fGoodsID := Value;
end;

procedure TfrmGoodsBrowser.SetGoodsWebFlags(const FlagTypeID, Discount: Integer; const StartDate, EndDate: TDate; const GoodsIDList: string);
var
    Query: TIBCQuery;
begin
  // 1 - FLG_PROMO - produs promotional;
  // 2 - FLG_NEW - produs nou;
  // 3 - FLG_PRICE_FORCED - produsul trebuie aratat fortat;
  // 4 - FLG_DISCOUNT - arata daca produsulu are discount in perioada. Vezi VALUE_INT pentru valoare.
  // 5 - FLG_PRICE - (autocalc) arata daca produsul se arata in price-list-uri (pe Web). START_DATE si END_DATE n-au efect.
  // 6 - FLG_CREDIT0 - (in VALUE_INT RATA LUNARA)
  // 7 - FLG_LOW_PRICE (ЦЕНА СНИЖЕНА) - 14 ДНЕЙ
  // 8 - FLG_

    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := IBCQueryGoods.UpdateTransaction;
        Query.SQL.Text := 'EXECUTE PROCEDURE WEB_SETUP_GOODS_FLAG2(:DT, :GOODSIDLIST, :FLAGTYPEID, :START_DATE, :END_DATE, :DISCOUNT)';
        Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
        Query.ParamByName('GOODSIDLIST').AsString := GoodsIDList;
        Query.ParamByName('FLAGTYPEID').AsInteger := FlagTypeID;
        Query.ParamByName('START_DATE').AsDate := StartDate;
        Query.ParamByName('END_DATE').AsDate := EndDate;
        Query.ParamByName('DISCOUNT').AsInteger := Discount;

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            Query.Transaction.Commit;
        except
            on e: Exception do
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

procedure TfrmGoodsBrowser.SetOnBurstAddGoods(const Value: TOnBurstAddGoods);
begin
    FOnBurstAddGoods := Value;
end;

procedure TfrmGoodsBrowser.SetOnCheckIfGoodsExists(const Value: TOnCheckIfGoodsExists);
begin
    fOnCheckIfGoodsExists := Value;
end;

procedure TfrmGoodsBrowser.SetRootParentID(const Value: Integer);
begin
    fRootParentID := Value;
end;

procedure TfrmGoodsBrowser.SetSelectMode(const Value: Boolean);
begin
    fSelectMode := Value;
    bbOK.Visible := iif(fSelectMode, ivAlways, ivNever);
    if not fSelectMode then
    begin
        bbCancel.Caption := 'Inchide';
        bbCancel.Hint := 'Inchide';
    end;
end;

procedure TfrmGoodsBrowser.SetTitle(const Value: string);
begin
    Caption := Value;
end;

procedure TfrmGoodsBrowser.SetupReportParams(const ReportParams: TReportParamsList);
var
    N: Integer;
begin
    N := -1;
    if Assigned(cxGridGoods_Table.Controller.FocusedRow) then
        N := cxGridGoods_Table.Controller.FocusedRow.Values[cxGridGoods_GOODSID.Index];
  // setup here general params
    ReportParams.SetParamValue('GOODSID', N);
    ReportParams.SetParamValue('GOODSPARENTID', FCurrentParentID);
end;

procedure TfrmGoodsBrowser.SetupSecurityItems;
var
    b: Boolean;
begin
    bbNewFolder.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Создание_папки));
    bbNewGoods.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Создание_товара));
    bbChangeFiltersValue.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Gestiune_filtre_produse_din_nomenclatorul_Produselor));
    fSecurityFlag_CanModify_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_папки);
    fSecurityFlag_CanModify_Goods := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_товара);
    bbModify.Visible := BarItemVisible(fSecurityFlag_CanModify_Folder or fSecurityFlag_CanModify_Goods);
    bbRecalcPrice.Visible := BarItemVisible(fSecurityFlag_CanModify_Goods);

    b := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Наличие_товара_фирмасклад) and not SWNSecurityManager.IsPartialAccessMode;
    bbQtyByStocks.Visible := BarItemVisible(b);
    bbQtyByFirms.Visible := BarItemVisible(b);
    tbsStocks.TabVisible := b;

    SetupPriceMarginColumns;

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_у_поставщиков) then
        bbForeignCodes.Visible := ivNever;

    fSecurityFlag_CanDelete_Folder := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Удаление_папки);
    fSecurityFlag_CanDelete_Goods := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Удаление_товара);
    bbRemove.Visible := BarItemVisible((fSecurityFlag_CanDelete_Folder or fSecurityFlag_CanDelete_Goods) and (not FBurstMode));

    bbGoodsDescriptions.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Описание_товара));
    bbGoodsKit.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Комплектация_товара) and (not FBurstMode));
    bbCompatibleGoods.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Взаимозаменяемость_товара));
    bbChangeParent.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_предка) and (not FBurstMode));
    bbArrangeFolders.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Упорядочивание_папок) and (not FBurstMode));

    bsubFlgNewGoods.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Флаг_Новый_товар));
    bsubFlgPromoGoods.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Флаг_Промо_товар));

    bbGoodsInfoCard.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Карточка_товара) and not SWNSecurityManager.IsPartialAccessMode);

    dxBarGoodsSubItems.Visible := BarItemVisible(dxBarGoodsSubItems.ItemLinks.VisibleItemCount > 0);

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Просмотр_рентабельности) then
    begin
        bbMergeGoods.Visible := ivNever;
        cxGridGoods_MARGIN17.Visible := False;
    end;

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Флаг_Всегда_показывать_в_прайсах) then
        bbForcedAnalize.Visible := ivNever;

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Флаг_Скидка_на_товар) then
        bbSubWebFLG_DISCOUNT.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Флаг_Устаревший_товар) then
        bbSet_FLG_OLD.Visible := ivNever;

    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Web_menu) then
        bsiWeb.Visible := ivNever;
    if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Arata_mapele_pentru_tipul_de_produse) then
        bbShowGoodsTypeFolders.Visible := ivNever;

  // колонки цен
    cxGridGoods_PRICEC1_LEI.Visible := False;
    cxGridGoods_PRICEC1_LEI.VisibleForCustomization := False;

    cxGridGoods_PRICE4.Visible := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4);
    cxGridGoods_PRICE4.VisibleForCustomization := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_4);

    cxGridGoods_PRICE7.Visible := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7);
    cxGridGoods_PRICE7.VisibleForCustomization := SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Колонка_цен_7);

    bbGoodsPrice.Visible := BarItemVisible(SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) and not SWNSecurityManager.IsPartialAccessMode);

//  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Удалить_все_цветные_флаги) then
//  begin
//    bbDeleteAllGreenFlag.Visible := ivNever;
//    bbDeleteSelectedGreenFlags.Visible := ivNever;
//    bbSubColorFlags.Visible := ivNever;
//  end;
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Politica_de_preturi) then
    begin
        bbGoodsPricePolicy.Visible := ivNever;
        cxGridGoods_MARGIN17.Visible := False;
    end;

    if SWNSecurityManager.LoggedUser.IsLimitedUser then
    begin
        cxGridGoods_MARGIN17.Visible := False;
        bbSendToArchive.Visible := ivNever;
        dxAddonsSubItems.Visible := ivNever;
        bbTools.Visible := ivNever;
        dxBarSubItemVIEW.Visible := ivNever;
        cxGridGoods_Table.PopupMenu := nil;
        cxGridGoods_VAT.Visible := False;
        cxGridGoods_FLG_HAS_META.Visible := False;
        cxGridGoods_QTY_AVAILABLE.Visible := False;
        cxGridGoods_QTY_FILIALE.Visible := False;
        cxGridGoods_FLG_PROMO.Visible := False;
        cxGridGoods_FLG_SOCIAL.Visible := False;
        cxGridGoods_DELIVERY_TYPENAME.Visible := False;
        cxGridGoods_Table.OptionsCustomize.ColumnsQuickCustomization := False;
        cxGridGoods_Table.OptionsCustomize.ColumnsQuickCustomizationShowCommands := False;
        cxPageControlAddons.Visible := False;
    //
        bbNewFolder.Visible := ivNever;
        bbNewGoods.Visible := ivNever;
        bbModify.Visible := ivNever;
        bbCloneGoods.Visible := ivNever;

    //
        bbSendToArchive.Visible := ivNever;
        bbPrint.Visible := ivNever;
        bbSendToNPSC.Visible := ivNever;
        bbGoodsKit.Visible := ivNever;
        bbCompatibleGoods.Visible := ivNever;
        bbGoodsInfoCard.Visible := ivNever;
        bbLoanOffer.Visible := ivNever;
        bbBalansPoPartiam.Visible := ivNever;
        bbAviableSnPartsNumbers.Visible := ivNever;
        bbChangeParent.Visible := ivNever;
        bbArrangeFolders.Visible := ivNever;
        bbGoodsPrice.Visible := ivNever;
        bbQtyByStocks.Visible := ivNever;
        bbQtyByFirms.Visible := ivNever;
        bbForeignCodes.Visible := ivNever;
        bbMergeGoods.Visible := ivNever;
        bbSetupPropsToSelection.Visible := ivNever;
//    bsiDeliveryType.Visible := ivNever;
        bbSet_FLG_OLD.Visible := ivNever;
        bsubFlgNewGoods.Visible := ivNever;
        bsubFlgPromoGoods.Visible := ivNever;
        bbSubWebFLG_DISCOUNT.Visible := ivNever;
//    bbSubColorFlags.Visible := ivNever;
        bbForcedAnalize.Visible := ivNever;
        bbReCalcGoodsStock.Visible := ivNever;
        bbRecalcComplectPrice.Visible := ivNever;
        bbConvertGIF2PNG.Visible := ivNever;
        bbConvertJPEG2PNG.Visible := ivNever;
        bbGoodsTitle.Visible := ivNever;
        bbAnalizer.Visible := ivNever;
        bbMoveToArchive.Visible := ivNever;

    // View
        bbShowAvailableGoods.Visible := ivNever;
        bbPriceMargins.Visible := ivNever;
        bbGoodsPricePolicy.Visible := ivNever;
        bbGoodsAttributes.Visible := ivNever;
        bbWebCatalogPath.Visible := ivNever;

        miMultiSelect.Visible := ivNever;

        cxGridGoods_PRICE4_LEI.Visible := False;
        cxGridGoods_PRICE4.Visible := False;
        cxGridGoods_PRICE7.Visible := False;
        cxGridGoods_VAT.Visible := False;
        cxGridGoods_QTY_AVAILABLE.Visible := False;
        cxGridGoods_QTY_FILIALE.Visible := False;

    // pnMoreInfo.Visible := False;

        tbsStocks.Visible := False;
    end;

    if SWNSecurityManager.IsPartialAccessMode then
    begin
    // Price USD
    // pnPriceUSD.Visible := False;
        tbsStocks.TabVisible := False;
        bbReCalcGoodsStock.Visible := ivNever;
        bbPriceMargins.Visible := ivNever;
        bbGoodsInfoCard.Visible := ivNever;
        bbQtyByStocks.Visible := ivNever;
        bbQtyByFirms.Visible := ivNever;
    // cxLabelAcntTitle.Visible := False;
    // lbNAMEACNT.Visible := False;

        cxGridGoods_QTY_AVAILABLE.Visible := False;
        cxGridGoods_QTY_AVAILABLE.VisibleForCustomization := False;
        cxGridGoods_QTY_FILIALE.Visible := False;
        cxGridGoods_QTY_FILIALE.VisibleForCustomization := False;
        cxGridGoods_QTY_FRANCIZE.Visible := False;
        cxGridGoods_QTY_FRANCIZE.VisibleForCustomization := False;
        cxGridGoods_QTY_INTERNAL.Visible := False;
        cxGridGoods_QTY_INTERNAL.VisibleForCustomization := False;
        cxGridGoods_QTY_RMA.Visible := False;
        cxGridGoods_QTY_RMA.VisibleForCustomization := False;
        cxGridGoods_QTY_ACCOUNT.Visible := False;
        cxGridGoods_QTY_ACCOUNT.VisibleForCustomization := False;
    // cxGridGoods_PRICE7.Visible := False;
    // cxGridGoods_PRICE7.VisibleForCustomization := False;

        bbGoodsPrice.Visible := ivNever;
        bbForeignCodes.Visible := ivNever;

        bbMergeGoods.Visible := ivNever;
    end;
end;

procedure TfrmGoodsBrowser.ShowAdditionalMasterDetailsData;
begin
    IBCQueryStockFirms.Close;
    IBCQueryStockWarehouse.Close;
    IBCQueryCatalog.Open;
  // stokurile
    if cxPageControlAddons.ActivePage = tbsStocks then
    begin
        if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 0 then
        begin
            IBCQueryStockFirms.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            IBCQueryStockFirms.Active := True;

            IBCQueryStockWarehouse.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            IBCQueryStockWarehouse.ParamByName('DT').AsInteger := IBCQueryStockFirms.FieldByName('DT').AsInteger;

            IBCQueryStockWarehouse.Active := True;
        end;
    end;
end;

procedure TfrmGoodsBrowser.ShowAviableSNnPartsNumbersDialog;
var
    dialogSerial: TfrmGoodsAviableSerialsNumbersDlg;
    dialogParts: TfrmGoodsAviablePartNumbersDlg;
begin
    if (IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет) then
    begin
    // PARTS
        dialogParts := TfrmGoodsAviablePartNumbersDlg.Create(Self);
        try
            dialogParts.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            dialogParts.GoodsTitle := IBCQueryGoods.FieldByName('TITLE').AsString;
            dialogParts.ShowModal;
        finally
            dialogParts.Free;
        end;
    end
    else
    begin
    // SN
        dialogSerial := TfrmGoodsAviableSerialsNumbersDlg.Create(Self);
        try
            dialogSerial.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
            dialogSerial.GoodsTitle := IBCQueryGoods.FieldByName('TITLE').AsString;
            dialogSerial.ShowModal;
        finally
            dialogSerial.Free;
        end;
    end;
end;

procedure TfrmGoodsBrowser.ShowBalansPoPartiamDialog;
var
    dialog: TfrmGoodsBalansPoPartiamDlg;
begin
    dialog := TfrmGoodsBalansPoPartiamDlg.Create(Self);
    try
        dialog.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowChangeParentDialog;
var
    dialog: TfrmChangeParentFolderDlg;
    i: Integer;
    S: string;
    rec: TcxCustomGridRecord;
begin
    dialog := TfrmChangeParentFolderDlg.Create(Self);
    try
        dialog.DBTable := dbtGOODS;
        dialog.FolderObjectID := IBCQueryGoods.FieldByName('PARENTID').AsInteger;

        for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
        begin
            rec := cxGridGoods_Table.Controller.SelectedRecords[i];

            if VarIsNull(rec.Values[cxGridGoods_CODE.Index]) then
                S := rec.Values[cxGridGoods_TITLE.Index]
            else
                S := rec.Values[cxGridGoods_CODE.Index];

            dialog.AddObjectInfo(rec.Values[cxGridGoods_GOODSID.Index], S);
        end;
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowCreateNewFolderDialog;
var
    dialog: TfrmGoodsFolderEditorDialog;
begin
    dialog := TfrmGoodsFolderEditorDialog.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.CreateNewRecord := True;
        dialog.ParentGoodsTypeID := IBCQueryGoods.FieldByName('GOODS_TYPE_ID').AsInteger; //fCurrentParentGoodsTypeID;
        dialog.ParentWEBGoodsTypeID := IBCQueryGoods.FieldByName('WEBGOODSTYPE_ID').AsInteger; //fCurrentParentWEBGoodsTypeID;
        dialog.CashbackValue := IBCQueryGoods.FieldByName('CASHBACK_PERCENT').AsInteger;
        dialog.ParentSerialTypeID := IBCQueryGoods.FieldByName('SERIAL_TYPE_ID').AsInteger; // fCurrentParentSerialTypeID;
        dialog.ParentID := FCurrentParentID;
        dialog.DeliveryTypeID := IBCQueryGoods.FieldByName('DELIVERY_TYPEID').AsInteger;

        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowForeignGoodsCodesDialog;
var
    dialog: TfrmGoodsForeignCodeDlg;
begin
    dialog := TfrmGoodsForeignCodeDlg.Create(Self);
    try
        dialog.QTY := iif(IBCQueryGoods.FieldByName('QTY_AVAILABLE').AsFloat < 0, IBCQueryGoods.FieldByName('QTY_AVAILABLE').AsFloat, 0);
        dialog.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        if dialog.ShowModal = mrOk then
            IBCQueryGoods.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowGoodsCompatibleGoodsDialog;
var
    dialog: TfrmGoodsCompatibleGoodsDlg;
begin
    dialog := TfrmGoodsCompatibleGoodsDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowGoodsDescriptionsDialog;
var
    dialog: TfrmContentGoodsEditorDlg;
begin
    if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 0 then
    begin

        dialog := TfrmContentGoodsEditorDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
        try

            dialog.ShowModal;
        finally
            dialog.Free;
        end;
    end;
end;

procedure TfrmGoodsBrowser.ShowGoodsInfoCardDialog;
var
    dialog: TfrmGoodsInfoCardDlg;
begin
    dialog := TfrmGoodsInfoCardDlg.Create(Self);
    try
        dialog.SetGoodsInfo(IBCQueryGoods.FieldByName('GOODSID').AsInteger, IBCQueryGoods.FieldByName('TITLE').AsString);
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowGoodsKitDialog;
var
    dialog: TfrmGoodsKitEditorDialog;
begin
    dialog := TfrmGoodsKitEditorDialog.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowModifyGoodsPriceDlg;
var
    dialog: TfrmGoodsPricesDlg;
begin
    dialog := TfrmGoodsPricesDlg.Create(Self);
    try
        dialog.SetGoodsInfo(IBCQueryGoods.FieldByName('GOODSID').AsInteger, IBCQueryGoods.FieldByName('TITLE').AsString);
        if dialog.ShowModal = mrOk then
            IBCQueryGoods.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowModifySelectedGoodsDialog;
begin
    if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger = 1 then
    begin
        ModifyFolder;
    end
    else
        ModifyGoods;
end;

procedure TfrmGoodsBrowser.ShowNewGoodsDialog;
var
    goods_editor: TfrmGoodsEditorDialog;
begin
    goods_editor := TfrmGoodsEditorDialog.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        goods_editor.CreateNewRecord := True;

        goods_editor.ParentID := FCurrentParentID;
        goods_editor.ParentWEBGoodsTypeID := fCurrentParentWEBGoodsTypeID;
        goods_editor.ShowModal;
    finally
        goods_editor.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowPrintDialog;
var
    printWizard: TfrmPrintWizardDlg;
begin
    printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
    try
        printWizard.ShowReportsFromGroupOnly(10); // 10 - Справочник товаров
        printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
        printWizard.ShowModal;
    finally
        printWizard.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowQtyByFirmsDialog;
var
    dialog: TfrmGoodsStockByFirmsDlg;
begin
    dialog := TfrmGoodsStockByFirmsDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowQtyByStockDialog;
var
    dialog: TfrmGoodsStockByWarehouseDlg;
begin
    dialog := TfrmGoodsStockByWarehouseDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
    try
        dialog.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowQuickInfoDialog(const GoodsID: Integer);
var
    dialog: TfrmGoodsQuickInfoDlg;
begin
    dialog := TfrmGoodsQuickInfoDlg.Create(Self);
    try
        dialog.GoodsID := GoodsID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.ShowRecalcPriceDialog;
var
    S, SS: string;
begin
    if cxGridGoods_Table.Controller.SelectedRowCount < 1 then
        Exit;

    if cxGridGoods_Table.Controller.SelectedRowCount = 1 then
    begin
        SS := Format('"%s"?', [IBCQueryGoods.FieldByName('TITLE').AsString]);
        S := 'Puteti selecta mai multe produse!';
    end
    else
    begin
        SS := Format('grupe de produse? Total selectate: %d.', [cxGridGoods_Table.Controller.SelectedRowCount]);
        S := '';
    end;

    if ShowAskDialog('Preturi', 'Doriti sa recalculati preturile pentru: ' + SS, S) = mrYes then
    begin
        DoRecalcGoodsPriceDB;
        IBCQueryGoods.Refresh;
        ShowInfoDialog('Preturi', 'Recalcul preturi finisat!');
    end;
end;

procedure TfrmGoodsBrowser.ShowSearchDialog;
var
    Search: TSWNSearchDialog;
    SearchInProc: string;
    SearchInWhere: string;
    i: Integer;
    SC: TSearchCriteria;
    toSearch: Boolean;
    S: string;
begin
    SC := nil;
    toSearch := False;
    SearchInProc := '';
    SearchInWhere := '';

    Search := TSWNSearchDialog.Create(Self);
    try
        if Search.GetSearchCritera(stGoods) then
        begin
            for i := 0 to Search.SearchCriteriasCount - 1 do
            begin
                SC := Search.SearchCriterias[i];
                case SC.SearchField of
          // cautarea se face in procedura
                    sfComposite:
                        begin
                            S := '';

                            if not dmDB.IsDecimalInteger(SC.SearchText) then
                            begin
                                AddConditionToWhere(S, Format('CAST(TS_GOODS.GOODSID AS VARCHAR(10))=''%s''', [SC.SearchText]), 'OR');
                                AddConditionToWhere(S, Format('UPPER(TS_GOODS.title) LIKE %s', [PrepareTextForLIKE(SC.SearchText)]), 'OR');
                                AddConditionToWhere(S, Format('UPPER(TS_GOODS.code) LIKE %s', [PrepareTextForLIKE(SC.SearchText)]), 'OR');
                            end
                            else
                            begin
                                AddConditionToWhere(SearchInProc, Format('TS_GOODS.GOODSID=%s', [SC.SearchText]));
                            end;

                            AddConditionToWhere(SearchInProc, S);
                        end;
                    sfWebMode:
                        begin
                            S := '';
                            SearchInProc := Format('%s', [SC.SearchText]);
                        end;
                    sfFoldersMode:
                        begin
                            AddConditionToWhere(SearchInProc, Format('TS_GOODS.FLG_FOLDER = 1 and TS_GOODS.TITLE like %s', [PrepareTextForLIKE(SC.SearchText)]));
                        end;
                    sfID:
                        AddConditionToWhere(SearchInProc, Format('TS_GOODS.GOODSID=%s', [SC.SearchText]));
                    sfAcntID:
                        AddConditionToWhere(SearchInProc, Format('TS_GOODS.GOODS_ACNT_ID=%s', [SC.SearchText]));
                    sfName:
                        AddConditionToWhere(SearchInProc, Format('UPPER(TS_GOODS.TITLE) LIKE %s', [PrepareTextForLIKE(SC.SearchText)]));
                    sfArticul:
                        AddConditionToWhere(SearchInProc, Format('UPPER(TS_GOODS.CODE) LIKE %s', [PrepareTextForLIKE(SC.SearchText)]));
                    sfGoodsCurrentGroup:
                        AddConditionToWhere(SearchInProc, Format('TS_GOODS.PARENTID=%d', [FCurrentParentID]));
                    sfGoodsAvailable:
                        AddConditionToWhere(SearchInWhere, 'QTY_AVAILABLE>0 OR QTY_FILIALE>0');
                    sfGoodsAdmin:
                        AddConditionToWhere(SearchInWhere, 'QTY_RESERVE>0');
                    sfGoodsDefect:
                        AddConditionToWhere(SearchInWhere, 'QTY_RMA>0');
                    sfGoodsSumRangeStart:
                        AddConditionToWhere(SearchInWhere, Format('PRICE1_LEI>=%s', [SC.SearchText]));
                    sfGoodsSumRangeEnd:
                        AddConditionToWhere(SearchInWhere, Format('PRICE1_LEI<=%s', [SC.SearchText]));
                    sfBarcode:
                        AddConditionToWhere(SearchInProc, Format('EXISTS(SELECT GOODSID FROM TS_GOODS_FOREIGN WHERE UPPER(TS_GOODS_FOREIGN.BARCODE)=''%s'' AND ' + 'TS_GOODS_FOREIGN.GOODSID=TS_GOODS.GOODSID)', [SC.SearchText]));
                    sfIDCustom:
                        AddConditionToWhere(SearchInProc, Format('UPPER(''%s'')', [SC.SearchText]));
                end;
            end;
            toSearch := (SearchInProc <> '') or (SearchInWhere <> '')
        end;
    finally
        Search.Free;
    end;

    if toSearch then
        if (SC <> nil) then
            if (SC.SearchField = sfIDCustom) then
                NavigateSearchForeignCode(SearchInProc, SearchInWhere)
            else if (SC.SearchField = sfWebMode) then
                NavigateSearchGoodsComposite(SearchInProc, SearchInWhere)
            else
                NavigateSearch(SearchInProc, SearchInWhere);
end;

procedure TfrmGoodsBrowser.ShowSetupPropsToGoodsSelection;
var
    dialog: TfrmSetupGoodsPropsSelectionDlg;
    Data: TGoodsPropertySelectionData;
    needUpdate: Boolean;
begin
    needUpdate := False;
    dialog := TfrmSetupGoodsPropsSelectionDlg.Create(Self);
    try
        dialog.SetGoodsCount(cxGridGoods_Table.Controller.SelectedRecordCount);
        if dialog.ShowModal = mrOk then
        begin
            Data := dialog.SelectionData;
            needUpdate := True;
        end;
    finally
        dialog.Free;
    end;

    if needUpdate then
    begin
        if DBSetupPropertiesForGoodsSelection(Data) then
        begin
            ShowInfoDialog('Modificare proprietati', 'Modificare proprietati finisata cu succes!');
      // IBCQueryGoods.Refresh;
        end;
    end;
end;

procedure TfrmGoodsBrowser.ShowSortFoldersDialog;
var
    dialog: TfrmChangeOrderNoDlg;
begin
    dialog := TfrmChangeOrderNoDlg.Create(Self);
    try
        dialog.DBTable := cotGOODS;
        dialog.ParentID := FCurrentParentID;
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryGoods.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmGoodsBrowser.UpdatePath;
begin
    if IBCQueryGoods.Active then
    begin
        IBCQueryCatalog.Close;
        IBCQueryCatalog.ParamByName('GoodsID').AsInteger := IBCQueryGoods.FieldByName('goodsid').AsInteger;
        TDelayedOpenPathCatalog.Create(IBCQueryCatalog, 500, lbPath);
    end;
end;

procedure TfrmGoodsBrowser.ModifyFolder;
var
    folder_editor: TfrmGoodsFolderEditorDialog;
begin
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_папки) then
    begin
        folder_editor := TfrmGoodsFolderEditorDialog.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
        try
            folder_editor.CreateNewRecord := False;
            folder_editor.ShowModal;
        finally
            folder_editor.Free;
        end;
    end;
end;

procedure TfrmGoodsBrowser.ModifyGoods;
var
    goods_editor: TfrmGoodsEditorDialog;
begin
    if SecurityFlagEnabled(cSecurityFlag_Справочники_Товары_Изменение_товара) then
    begin
        goods_editor := TfrmGoodsEditorDialog.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
        try
            goods_editor.CreateNewRecord := False;
            goods_editor.ShowModal;
        finally
            goods_editor.Free;
        end;
    end;
end;

procedure TfrmGoodsBrowser.MultiAddRelatedGoods(const AGoodsid: Integer; ARelatedKey: string);
var
    i: Integer;
    q: TIBCQuery;
    tmpGoodsID: Integer;
begin
    q := TIBCQuery.Create(nil);
    q.Transaction := IBCTrUpdateGoods;
    q.AutoCommit := False;
    q.SQL.Add('update or insert into ts_related_goods (goodsid, related_key) values (:goodsid, :related_key) matching (goodsid, related_key)');
    q.Prepare;

    if not IBCTrUpdateGoods.Active then
        IBCTrUpdateGoods.StartTransaction;

    try
        for i := 0 to cxGridGoods_Table.Controller.SelectedRecordCount - 1 do
        begin
            if (cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_FLG_FOLDER.Index] = 0) then
            begin
                tmpGoodsID := cxGridGoods_Table.DataController.Values[cxGridGoods_Table.Controller.SelectedRows[i].RecordIndex, cxGridGoods_GOODSID.Index];
                q.ParamByName('GOODSID').AsInteger := tmpGoodsID;
                q.ParamByName('RELATED_KEY').AsString := ARelatedKey;
                q.Execute;
            end;
        end;

        IBCTrUpdateGoods.Commit;
        IBCQueryGoods.Refresh;
    finally
        q.Free;
    end;
end;

procedure TfrmGoodsBrowser.PrepareGrid;
begin
    if bbFastMode.Down then
    begin
        cxGridGoods_Table.DataController.DataModeController.GridMode := True;
        cxGridGoods_Table.DataController.DataModeController.GridModeBufferCount := 100;
    end
    else
    begin
        cxGridGoods_Table.DataController.DataModeController.GridMode := False;
    end;
end;

function TfrmGoodsBrowser.SelectWebCatalog: Integer;
var
    d: TfrmWebCatalogDlg;
begin
    d := TfrmWebCatalogDlg.Create(Self);
  // заглушка 19.08.2022
    d.FirmaID := 5213;

    d.btnOK.Visible := True;
    if (d.ShowModal = mrOk) then
    begin
        Result := d.WebCatalogID;
    end
    else
        Result := -1;
end;

procedure TfrmGoodsBrowser.SetCurrentParentID(const Value: Integer);
begin
    FCurrentParentID := Value;
end;

procedure TfrmGoodsBrowser.SetGoodsVendorID(const Value: Integer);
begin
    FGoodsVendorID := Value;
end;

procedure TfrmGoodsBrowser.SetWebGoodsTypeID(const Value: Integer);
begin
    FWebGoodsTypeID := Value;
end;

procedure TfrmGoodsBrowser.ShowAcntGoodsDlg(GoodsID: Integer);
begin

end;

procedure TfrmGoodsBrowser.ShowPriceRules;
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
        Query.ParamByName('GOODSID').AsInteger := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        Query.Open;

        dialog.PGT_ID := Query.FieldByName('PGT_ID').AsInteger;
        dialog.GoodsID := IBCQueryGoods.FieldByName('GOODSID').AsInteger;
        dialog.ShowModal;
    finally
        Query.Free;
        dialog.Free;
    end;
end;



// TDelayedOpenThread = class(TThread)
constructor TDelayedOpenPathCatalog.Create(ADataSet: TDataSet; ADelay: Integer; lbPath: TLabel);
begin
    inherited Create(True); // Create suspended
    FDataSet := ADataSet;
    FDelay := ADelay;
    FlbPath := lbPath;
    FreeOnTerminate := True; // Free the thread automatically when it finishes
    Resume; // Start the thread
end;

procedure TDelayedOpenPathCatalog.Execute;
begin
//    Sleep(FDelay); // Delay for the specified time
    Synchronize(
        procedure
        begin
            if not FDataSet.Active then
            try
                FDataSet.Open; // Open the TDataSet in the main thread
                if FDataSet.FieldByName('BreadCrumb').AsString = '' then
                    flbPath.Caption := 'ROOT'
                else
                    flbPath.Caption := FDataSet.FieldByName('BreadCrumb').AsString;
            finally
                FDataSet.Close;
            end;
        end);
end;

end.


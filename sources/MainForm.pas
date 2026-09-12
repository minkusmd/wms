unit MainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Controls,
  Forms,
  Vcl.StdCtrls,
  SWNDataFiltering,
  SWNSearchDocumentTypes,
  IBC,
  Data.DB,
  DBAccess,
  cxGraphics,
  cxCustomData,
  cxStyles,
  cxTL,
  cxImageComboBox,
  Vcl.ExtCtrls,
  cxLookAndFeels,
  dxBar,
  cxBarEditItem,
  cxSplitter,
  cxInplaceContainer,
  cxClasses,
  dxNavBar,
  dxStatusBar,
  SWNBaseFrameUnit,
  SWNUpdateClientDBClass,
  SWNDBEvents,
  SWNDocumentFilters,
  IBCAlerter,
  cxEdit,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridCustomView,
  cxGrid,
  Vcl.Buttons,
  DAAlerter,
  frmPrintEngineWindow,
  cxDBEdit,
  cxPC,
  System.UITypes,
  frameSipClientUnit,
  SWNConst,
  System.Messaging,
  cxControls,
  cxLookAndFeelPainters,
  dxScrollbarAnnotations,
  cxTextEdit,
  cxTLdxBarBuiltInMenu,
  cxContainer,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  cxMemo,
  cxButtonEdit,
  cxMaskEdit,
  cxCheckBox,
  cxLabel,
  cxCheckComboBox,
  frmAnalyticTypesUnit,
  System.Threading,
  cxCalendar,
  cxCalc,
  dxBarExtItems,
  dxOfficeSearchBox,
  Vcl.Menus,
  dxUIAClasses,
  frmSchedulerDaemonUnit;

type
  WKSTA_INFO_100 = record
    wki100_platform_id: DWORD;
    wki100_computername: LPWSTR;
    wki100_langroup: LPWSTR;
    wki100_ver_major: DWORD;
    wki100_ver_minor: DWORD;
  end;

type
  PTokenUser = ^TTokenUser;

  _TOKEN_USER = record
    User: TSIDAndAttributes;
  end;

//    TPriceThread = class(TThread)
//        FOnFinished: TNotifyEvent;
//        procedure Execute; override;
//    public
//        property OnFinished: TNotifyEvent read FOnFinished write FOnFinished;
//    end;

  TTokenUser = _TOKEN_USER;

  LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

function NetWkstaGetInfo(ServerName: LPWSTR; Level: DWORD; BufPtr: Pointer): Longint; stdcall; external 'netapi32.dll'
  name 'NetWkstaGetInfo';

type
  TfrmMainForm = class(TForm)
    dxStatusBar: TdxStatusBar;
    dxBarManagerMain: TdxBarManager;
    dxBarManagerMainBar1: TdxBar;
    cxLookAndFeelController: TcxLookAndFeelController;
    bbMainMenuSys_Exit: TdxBarButton;
    bbMainMenuFile: TdxBarSubItem;
    bbMainMenuDictionaries: TdxBarSubItem;
    bbMainMenuRef_Goods: TdxBarButton;
    bbMainMenuRef_Customers: TdxBarButton;
    bbMainMenuRef_Currency: TdxBarButton;
    bbMainMenuRef_Banks: TdxBarButton;
    bbMainMenuRef_Stocks: TdxBarButton;
    bbMainMenuRef_Enterprises: TdxBarButton;
    bbMainMenuSys_Settings: TdxBarButton;
    bbCreateNewVersion: TdxBarSubItem;
    bbMainMenuHelp_About: TdxBarButton;
    bbAdminAccess: TdxBarSubItem;
    bbMainMenuAcs_Users: TdxBarButton;
    bbMainMenuAcs_UserGroups: TdxBarButton;
    bbMainMenuAcs_DocTypes: TdxBarButton;
    bbMainMenuRef_GoodsType: TdxBarButton;
    bbMainFilter: TdxBarButton;
    bbQuickLinks: TdxBarSubItem;
    pnLeft: TPanel;
    cxSplitter: TcxSplitter;
    cmbMainFirms: TcxBarEditItem;
    dxBarManagerMainBar3: TdxBar;
    dxStructureNavigation: TdxNavBar;
    cxTreeDocTypes: TcxTreeList;
    cxTreeDocTypescxTreeListColumn1: TcxTreeListColumn;
    bbShortcut_QuickSetupKit: TdxBarButton;
    bbShortcut_RashodNaklad: TdxBarButton;
    bbShortcut_ScetFactura: TdxBarButton;
    bbShortcut_PrihodCasaOrder: TdxBarButton;
    bbShortcut_RashCasaOrder: TdxBarButton;
    bbMainMenuRef_GoodsACNT: TdxBarButton;
    bbNewDocument: TdxBarButton;
    bbModifyDocument: TdxBarButton;
    bbRemoveDocument: TdxBarButton;
    bbCloneDocument: TdxBarButton;
    bbPrintDocuments: TdxBarButton;
    bbMainMenuPrint: TdxBarSubItem;
    bbMainMenuDocument: TdxBarSubItem;
    bbPrint_PriceList: TdxBarButton;
    bbToolsMainMenu: TdxBarSubItem;
    bbSYSS: TdxBarButton;
    bbRefCertifications: TdxBarButton;
    bbRefreshDocuments: TdxBarButton;
    bbProcuri: TdxBarButton;
    bbKitTemplates: TdxBarButton;
    bbService_FiscalPrinter: TdxBarButton;
    bbCheckForUpdates: TdxBarButton;
    TimerForTr: TTimer;
    miTransferMoneyToUser: TdxBarButton;
    bbMoneyTransfer: TdxBarButton;
    bbExchangeCurrency: TdxBarButton;
    IBCAlerter_DBEvents: TIBCAlerter;
    bbLockSystem: TdxBarButton;
    bbLockFirms: TdxBarButton;
    bbLocksLog: TdxBarButton;
    tmTimerEvent: TTimer;
    pmPopupMenuEvents: TdxBarPopupMenu;
    bbEventClearLog: TdxBarButton;
    bbEventGoToDocument: TdxBarButton;
    bbPrint_PriceLabels: TdxBarButton;
    bbSearchSciotFactura: TdxBarButton;
    bbWebFilters: TdxBarButton;
    bbWebCatalog: TdxBarButton;
    bbWebBlockedIp: TdxBarButton;
    bbApiConfig: TdxBarButton;
    bbStockRecalc: TdxBarButton;
    bbGoodsPriceSynchronize: TdxBarButton;
    bbMainMenuAcs_Analytics: TdxBarButton;
    bbQuickAccessReports: TdxBarSubItem;
    bbMainWebSiteMenu: TdxBarSubItem;
    bbWebDescriptionTemplates: TdxBarButton;
    bbWebDelivery: TdxBarButton;
    bbWebShops: TdxBarButton;
    bbCreateAppNewVersion: TdxBarButton;
    bbStopDatabase1Min: TdxBarButton;
    bbSearchScetOplata: TdxBarButton;
    bbSearchTools: TdxBarSubItem;
    bbImportGoodsByTitles: TdxBarButton;
    bbBonusGoods: TdxBarButton;
    bbSalaryInfo: TdxBarButton;
    bbSalePlans: TdxBarButton;
    bbNewGoods: TdxBarButton;
    bbFilterButtons: TdxBarButton;
    bbShortcut_WebZakaz: TdxBarButton;
    bbNacislenieZarplatiTools: TdxBarButton;
    bbWebActiuni: TdxBarButton;
    bbWebMailingLists: TdxBarButton;
    bbRealizatia: TdxBarButton;
    bbDiscountGoods: TdxBarButton;
    bbSearchDocsLog: TdxBarButton;
    bbToolsRecalcQtyInTransfer: TdxBarButton;
    bbServicePlusRefs: TdxBarSubItem;
    bbServicePlusRef_Aims: TdxBarButton;
    bbServicePlusRef_TaskType: TdxBarButton;
    bbMainFilterContext: TdxBarButton;
    bbResetMainFilter: TdxBarButton;
    bbUserMissedHours: TdxBarButton;
    bbCalcSalesBonus: TdxBarButton;
    bbExportTo1C: TdxBarButton;
    bbMainMenu1C: TdxBarSubItem;
    bbActiveUsers: TdxBarButton;
    bbUserWorkBonus: TdxBarButton;
    bbBonusGoods2: TdxBarButton;
    bbActivityMonitor: TdxBarButton;
    bbDocContractTypes: TdxBarButton;
    bbWebPromoActiuni: TdxBarButton;
    bbAddExpenses: TdxBarButton;
    bbWebStaticPages: TdxBarButton;
    bbBringDocsByToday: TdxBarButton;
    bbBonusTools: TdxBarSubItem;
    bbCostAnalyze: TdxBarButton;
    bbSalaryTools: TdxBarSubItem;
    bntSerialSearch: TdxBarButton;
    btnPartsSearch: TdxBarButton;
    bbPriceListAnalyze: TdxBarButton;
    bbComboFilterDates: TdxBarCombo;
    bbCloseBusinessDay: TdxBarButton;
    bbSQLRepository: TdxBarButton;
    bbWebGoodsFlags: TdxBarButton;
    bbWebSiteRefreshGoods: TdxBarButton;
    bbFindDocByID: TdxBarButton;
    pnClient: TPanel;
    pnShutdownWarning: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    cgEmergencyShutdown2: TLabel;
    pnClientFooter: TPanel;
    pnDocsComments: TPanel;
    mmCOMMENTS: TcxDBMemo;
    bbShowHideChat: TdxBarButton;
    pnEvents: TPanel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridTableView;
    cxGridTable_EVENTID: TcxGridColumn;
    cxGridTable_IMG: TcxGridColumn;
    cxGridTable_DateTime: TcxGridColumn;
    cxGridTable_DOCID: TcxGridColumn;
    cxGridTable_EVENT: TcxGridColumn;
    cxGridTable_USERFULLNAME: TcxGridColumn;
    cxGridTable_MSG: TcxGridColumn;
    cxGridTable_ISNEW: TcxGridColumn;
    cxGridTable_EVENTTYPE: TcxGridColumn;
    cxGridLevel: TcxGridLevel;
    Panel3: TPanel;
    Label2: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    cxSplitterEvents: TcxSplitter;
    bbWebPacheteProduse: TdxBarButton;
    bbSMS: TdxBarButton;
    bbUM: TdxBarButton;
    bbBugete: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    bbManageWorkPeriods: TdxBarButton;
    dxBarButton4: TdxBarButton;
    bbToolsRecalcQtyAcnt: TdxBarButton;
    bbDial: TdxBarButton;
    bbSipLog: TdxBarButton;
    bbTipCredite: TdxBarButton;
    bbCredite: TdxBarSubItem;
    bbPromoPerDay: TdxBarButton;
    SpeedButton1: TSpeedButton;
    bbPriceRules: TdxBarButton;
    dxBarSubItem3: TdxBarSubItem;
    bbMCC: TdxBarButton;
    bbWorkStations: TdxBarButton;
    bbWebUrlManager: TdxBarButton;
    bbWebGoodsGroups: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    bbECB: TdxBarButton;
    bdcSIP: TdxBarDockControl;
    dxBarManagerMainBar2: TdxBar;
    bbOffer: TdxBarButton;
    dxBarButton5: TdxBarButton;
    bbGrupeProduseAnaliza: TdxBarButton;
    bbAutoTransport: TdxBarButton;
    bbPlanVinzari: TdxBarButton;
    bbRegistrulBancar: TdxBarButton;
    bbChangeCustomerName: TdxBarButton;
    bbSeoActualizareWeb: TdxBarButton;
    bbWebAccessLog: TdxBarButton;
    dxBarButton7: TdxBarButton;
    bbAnaliza: TdxBarSubItem;
    dxBarButton8: TdxBarButton;
    bbAnaliticaSubItem: TdxBarSubItem;
    bbAnalyticTypes: TdxBarButton;
    dxBarButton9: TdxBarButton;
    bbPricePolicy: TdxBarButton;
    bbPreturiSubItem: TdxBarSubItem;
    dxBarButton11: TdxBarButton;
    bbWebConfig: TdxBarButton;
    frameSipClient1: TframeSipClient;
    bbRecalcPreturi: TdxBarButton;
    bbReevaluare: TdxBarButton;
    bbBrands: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbFantasticOnline: TdxBarButton;
    bbGamaComp: TdxBarButton;
    bbBlog: TdxBarButton;
    bbJobs: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarDateCombo1: TdxBarDateCombo;
    cxBarEditItem1: TcxBarEditItem;
    cxBarEditItem2: TcxBarEditItem;
    bbWebSearch: TdxBarButton;
    bbCrediteRetail: TdxBarButton;
    bbManagerGoodsImages: TdxBarButton;
    bbPhoneCalls: TdxBarButton;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    bbPrimeStore: TdxBarButton;
    bbCustomerInfoByPhone: TdxBarButton;
    bbProforme: TdxBarButton;
    dxBarButton10: TdxBarButton;
    bbVinzariPrinPartener: TdxBarButton;
    bbAsamblare: TdxBarButton;
    bbCloseDocument: TdxBarButton;
    bbOpenDocument: TdxBarButton;
    bbIntrareMarfa: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure bbMainMenuAcs_DocTypesClick(Sender: TObject);
    procedure bbMainMenuSys_ExitClick(Sender: TObject);
    procedure bbMainMenuAcs_UserGroupsClick(Sender: TObject);
    procedure bbMainMenuAcs_UsersClick(Sender: TObject);
    procedure dxStructureNavigationActiveGroupChanged(Sender: TObject);
    procedure bbMainFilterClick(Sender: TObject);
    procedure bbMainMenuSys_SettingsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbShortcutQuickSetupClick(Sender: TObject);
    procedure bbMainMenuRef_GoodsClick(Sender: TObject);
    procedure bbMainMenuRef_CustomersClick(Sender: TObject);
    procedure bbMainMenuRef_CurrencyClick(Sender: TObject);
    procedure bbMainMenuRef_BanksClick(Sender: TObject);
    procedure bbMainMenuRef_GoodsTypeClick(Sender: TObject);
    procedure bbMainMenuRef_EnterprisesClick(Sender: TObject);
    procedure bbMainMenuRef_GoodsACNTClick(Sender: TObject);
    procedure cmbMainFirmsCurChange(Sender: TObject);
    procedure bbNewDocumentClick(Sender: TObject);
    procedure bbModifyDocumentClick(Sender: TObject);
    procedure bbRemoveDocumentClick(Sender: TObject);
    procedure bbPrintDocumentsClick(Sender: TObject);
    procedure bbMainMenuRef_StocksClick(Sender: TObject);
    procedure bbSYSSClick(Sender: TObject);
    procedure bbRefCertificationsClick(Sender: TObject);
    procedure bbQuickLinksPopup(Sender: TObject);
    procedure bbRefreshDocumentsClick(Sender: TObject);
    procedure cxTreeDocTypesDblClick(Sender: TObject);
    procedure bbProcuriClick(Sender: TObject);
    procedure bbKitTemplatesClick(Sender: TObject);
    procedure bbService_FiscalPrinterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbCheckForUpdatesClick(Sender: TObject);
    procedure TimerForTrTimer(Sender: TObject);
    procedure miTransferMoneyToUserClick(Sender: TObject);
    procedure dxStatusBarPanels6DblClick(Sender: TObject);
    procedure bbMoneyTransferClick(Sender: TObject);
    procedure bbExchangeCurrencyClick(Sender: TObject);
    procedure IBCAlerter_CLOSEAPPIMMEDIATEEvent(Sender: TObject; EventName: string; EventCount: Integer);
    procedure bbLockFirmsClick(Sender: TObject);
    procedure bbLockSystemClick(Sender: TObject);
    procedure bbLocksLogClick(Sender: TObject);
    procedure cxTreeDocTypesDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
    procedure cxTreeDocTypesCollapsing(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
    procedure cxTreeDocTypesStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode:
      TcxTreeListNode; var AStyle: TcxStyle);
    procedure bbMainMenuHelp_AboutClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bbCloneDocumentClick(Sender: TObject);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure tmTimerEventTimer(Sender: TObject);
    procedure pmPopupMenuEventsPopup(Sender: TObject);
    procedure bbEventGoToDocumentClick(Sender: TObject);
    procedure bbEventClearLogClick(Sender: TObject);
    procedure bbPrint_PriceLabelsClick(Sender: TObject);
    procedure bbPrint_PriceListClick(Sender: TObject);
    procedure bbSearchSciotFacturaClick(Sender: TObject);
    procedure bbWebFiltersClick(Sender: TObject);
    procedure bbWebCatalogClick(Sender: TObject);
    procedure bbWebBlockedIpClick(Sender: TObject);
    procedure bbApiConfigClick(Sender: TObject);
    procedure bbStockRecalcClick(Sender: TObject);
    procedure bbGoodsPriceSynchronizeClick(Sender: TObject);
    procedure bbMainMenuAcs_AnalyticsClick(Sender: TObject);
    procedure bbWebDescriptionTemplatesClick(Sender: TObject);
    procedure bbWebDeliveryClick(Sender: TObject);
    procedure bbWebShopsClick(Sender: TObject);
    procedure bbCreateAppNewVersionClick(Sender: TObject);
    procedure bbStopDatabase1MinClick(Sender: TObject);
    procedure bbSearchScetOplataClick(Sender: TObject);
    procedure bbImportGoodsByTitlesClick(Sender: TObject);
    procedure bbBonusGoodsClick(Sender: TObject);
    procedure bbSalaryInfoClick(Sender: TObject);
    procedure bbSalePlansClick(Sender: TObject);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure bbFilterButtonsClick(Sender: TObject);
    procedure bbNacislenieZarplatiToolsClick(Sender: TObject);
    procedure bbWebActiuniClick(Sender: TObject);
    procedure bbWebMailingListsClick(Sender: TObject);
    procedure bbRealizatiaClick(Sender: TObject);
    procedure bbDiscountGoodsClick(Sender: TObject);
    procedure bbSearchDocsLogClick(Sender: TObject);
    procedure bbToolsRecalcQtyInTransferClick(Sender: TObject);
    procedure bbServicePlusRef_AimsClick(Sender: TObject);
    procedure bbServicePlusRef_TaskTypeClick(Sender: TObject);
    procedure cxTreeDocTypesCanSelectNode(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
    procedure cxTreeDocTypesCanFocusNode(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
    procedure bbMainFilterContextClick(Sender: TObject);
    procedure bbResetMainFilterClick(Sender: TObject);
    procedure dxStatusBarPanels4DblClick(Sender: TObject);
    procedure bbUserMissedHoursClick(Sender: TObject);
    procedure bbExportTo1CClick(Sender: TObject);
    procedure bbActiveUsersClick(Sender: TObject);
    procedure bbUserWorkBonusClick(Sender: TObject);
    procedure bbBonusGoods2Click(Sender: TObject);
    procedure bbCalcSalesBonusClick(Sender: TObject);
    procedure cxGridTable_DateTimeGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbActivityMonitorClick(Sender: TObject);
    procedure bbDocContractTypesClick(Sender: TObject);
    procedure bbAddExpensesClick(Sender: TObject);
    procedure bbWebPromoActiuniClick(Sender: TObject);
    procedure bbWebStaticPagesClick(Sender: TObject);
    procedure bbBringDocsByTodayClick(Sender: TObject);
    procedure bbCostAnalyzeClick(Sender: TObject);
    procedure bntSerialSearchClick(Sender: TObject);
    procedure bbPriceListAnalyzeClick(Sender: TObject);
    procedure bbCloseBusinessDayClick(Sender: TObject);
    procedure bbSQLRepositoryClick(Sender: TObject);
    procedure bbWebGoodsFlagsClick(Sender: TObject);
    procedure bbWebSiteRefreshGoodsClick(Sender: TObject);
    procedure bbComparePricesClick(Sender: TObject);
    procedure bbFindDocByIDClick(Sender: TObject);
    procedure cxDBTreeListChatCollapsing(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
    procedure bbShowHideChatClick(Sender: TObject);
    procedure bbWebPacheteProduseClick(Sender: TObject);
    procedure bbSMSClick(Sender: TObject);
    procedure bbUMClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbManageWorkPeriodsClick(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbToolsRecalcQtyAcntClick(Sender: TObject);
    procedure bbDialClick(Sender: TObject);
    procedure frameSipClient1CallBtnClick(Sender: TObject);
    procedure bbSipLogClick(Sender: TObject);
    procedure bbTipCrediteClick(Sender: TObject);
    procedure bbPromoPerDayClick(Sender: TObject);
    procedure bbPriceRulesClick(Sender: TObject);
    procedure bbMCCClick(Sender: TObject);
    procedure bbWorkStationsClick(Sender: TObject);
    procedure bbWebUrlManagerClick(Sender: TObject);
    procedure bbWebGoodsGroupsClick(Sender: TObject);
    procedure bbECBClick(Sender: TObject);
    procedure bbOfferClick(Sender: TObject);
    procedure dxBarButton5Click(Sender: TObject);
    procedure frameSipClient1HangUpBtnClick(Sender: TObject);
    procedure bbGrupeProduseAnalizaClick(Sender: TObject);
    procedure dxStatusBarPanels2DblClick(Sender: TObject);
    procedure bbAutoTransportClick(Sender: TObject);
    procedure bbPlanVinzariClick(Sender: TObject);
    procedure bbRegistrulBancarClick(Sender: TObject);
    procedure bbPricePolicyClick(Sender: TObject);
    procedure bbChangeCustomerNameClick(Sender: TObject);
    procedure bbSeoActualizareWebClick(Sender: TObject);
    procedure bbWebAccessLogClick(Sender: TObject);
    procedure dxBarButton7Click(Sender: TObject);
    procedure bbAnalyticTypesClick(Sender: TObject);
    procedure dxBarButton9Click(Sender: TObject);
    procedure dxBarButton11Click(Sender: TObject);
    procedure bbWebConfigClick(Sender: TObject);
    procedure bbRecalcPreturiClick(Sender: TObject);
    procedure bbBrandsClick(Sender: TObject);
    procedure bbFantasticOnlineClick(Sender: TObject);
    procedure bbBlogClick(Sender: TObject);
    procedure bbJobsClick(Sender: TObject);
    procedure dxBarButton12Click(Sender: TObject);
    procedure bbWebSearchClick(Sender: TObject);
    procedure bbCrediteRetailClick(Sender: TObject);
    procedure bbManagerGoodsImagesClick(Sender: TObject);
    procedure bbPhoneCallsClick(Sender: TObject);
    procedure dxBarButton14Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton6Click(Sender: TObject);
    procedure bbCustomerInfoByPhoneClick(Sender: TObject);
    procedure dxBarButton10Click(Sender: TObject);
    procedure bbCloseDocumentClick(Sender: TObject);
    procedure bbOpenDocumentClick(Sender: TObject);
  private    { Private declarations }
    fInShutdown: Boolean;
    fCurrentFrameFilterFields: TFrameFilterFields;
    fCurrentFrameDataFilter: TFrameDataFilteringInfo;
    fUpdater: TSWNUpdateDBClient;
    fEventManager: TSWNDBEventManager;

    frmSchedulerDaemon: TfrmSchedulerDaemon;
    procedure OnRingMessage(var Msg: TMessage); message WM_SWN_RING;
    procedure WhenAppHint(Sender: TObject);
    procedure DisplayAppCaption;
    procedure BuildFirmList;
    procedure BuildStructureList;
    procedure StructureListChanged(const NewStructureGroupIndex: Integer);
    procedure ShowDocumentsTree(const StructureID: Integer);
    procedure ShowMainFilterDialog;
    procedure ShowAppSettingsDialog;
    procedure ShowContextMainFilterDialog;
    procedure ResetMainFilter;
    procedure WhenRequiredFrameNotFound(const RequiredFrameID: Integer; var NewCustomFrame: TSWNBaseFrame);
    procedure WhenFrameShow(const ShownFrame: TSWNBaseFrame);
    procedure WhenFrameButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
    procedure RunFirstViewThread;
    procedure WhenFirstView(Sender: TObject);
    procedure SelectFirstItemInDocTypeList;
    procedure SwitchToDocType(const DocTypeID: Integer);
    function DocTypeExistsInTree(const DocTypeID: Integer): Boolean;
    function FrameIndexExistsInTree(const FrameIndex: Integer): TcxTreeListNode;
    procedure SetupSecurityItems;
    procedure ShowStocksEditor;
    procedure ShowGoodsEditor;
    procedure ShowWebFiltersDialog;
    procedure ShowGoodsCategoryEditor;
    procedure ShowCustomersEditor;
    procedure ShowBanksEditor;
    procedure ShowCurrencyEditor;
    procedure ShowFirmsEditor;
    procedure ShowGoodsAcntEditor;
    procedure ShowSYSSEditor(const ParentID: Integer = -1);
    procedure CreateDateFilter(const Filters: TFrameDocumentDateFilterSet);
    procedure WhenDatesFilterChange(Sender: TObject);
    procedure WhenTreeDocTypesFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure WhenGotoFrame(const FrameID: Integer; const Value: Integer; var FrameFound: Boolean);
    procedure WhenGotoFrameEx(const FrameID: Integer; const Value: Integer; const DocDate: TDateTime; var FrameFound: Boolean);
    procedure WhenNeedShowPrintDialog(const FrameID: Integer);
    procedure ShowFilterIndicator;
    procedure HideFilterIndicator;
    procedure ShowPrintDocumentsDialog(const PrintDocType: Integer = -1; const ReportGroup: Integer = -1);
    procedure ShowCertificationsDialog;
    procedure ShowDocTypesDialog;
    procedure ShowProcuriDialog;
    procedure ShowKitTemplatesDialog;
    procedure ShowServiceFiscalPrinter;
    procedure WhenNewVersionFound(const NewVersion, WhatsNew: string; const Crtitical: Boolean);
    procedure WhenNoVersionFound(Sender: TObject);
    procedure ShowMoneyTransferToUserDialog;
    procedure ShowMoneyTransferDialog;
    procedure ShowCurrencyExchangeDialog;
    procedure WhenOpenFormsListChanged(Sender: TObject);
    procedure ImmediateAppShutdown;
    procedure StartAppShutdown(const DelaySec: Integer);
    procedure WhenShutdownTimerTick(const RemainingTime: cardinal);
    procedure WhenShutdownTimerEnds;
    procedure ShowLockFirmsDialog;
    procedure LockSystem;
    function LockSystemDB: Boolean;
    procedure ShowSystemLocksLogDialog;
    procedure ShowAboutDialog;
    procedure SetWindowsAutoStart(const AutoStart, oldAutoStart: Boolean);
    function IsWindowsAutoStartEnabled: Boolean;
    procedure SetupFont;
    procedure PlayCustomSound(const FileName: string);
    procedure PlayAudio_РасходнаяНакладная;
    procedure PlayAudio_НарядНаСборку;
    procedure PlayAudio_WebZakaz;
    procedure PlayAudio_CerereDeFinantare;
    procedure WhenNewEventArrive(const ListOfEvents: TList);
    procedure DisplayEvents;
    procedure GotoDocumentFromEvent;
    procedure ShowSearchSciotFacturaDialog;
    procedure ShowWebCatalogDialog;
    procedure DoStockRecalcDB;
    procedure ShowGoodsPriceSynchronizeDialog;
    procedure ShowDocumentTypeAnalyticsDialog;
    procedure DisplayQuickAccessReports;
    procedure WhenQuickAccessReportClicked(Sender: TObject);
    procedure SetupReportParams(const ReportParams: TReportParamsList);
    procedure PrintReport(const ReportID: Integer; const Title: string = '');
    procedure ShowWebDescriptionTemplatesDialog;
    procedure ShowWebShopsDialog;
    procedure ShowWebDeliveryDialog;
    procedure ShowWebFilterButtonsDialog;
    procedure ShowCreateNewAppVersionDialog;
    procedure DoStopDb;
    procedure DoShowSearchScetNaOplatuDialog;
    procedure ShowImportGoodsFromTitlesDialog;
    procedure LoadEventsPanelPosition;
    procedure SaveEventsPanelPosition;
    // procedure LoadSipPanelPosition;
    // procedure SaveSipPanelPosition;
    // procedure LoadChatPanelPosition;
    procedure SaveChatPanelPosition;
    procedure ShowBonusGoodsDialog;
    procedure ShowBonusGoods2Dialog;
    procedure ShowSalaryInfoDialog;
    procedure ShowSalePlansDialog;
    procedure ShowNewGoodsDialog;
    procedure ShowNacislenieZarplatiToolsDialog;
    procedure ShowWebPromoActiuniDialog;
    procedure ShowWebMailingLists;
    procedure ShowImportForeighGoodsIntoTableDialog;
    procedure ShowDiscountGoodsDialog;
    procedure ShowSearchDocumentByID2Dialog;
    procedure ShowSearchInDocsLogDialog;
    procedure RecalcQtyInTransfer;
    function DoRecalcQtyInTransferDB: Boolean;
    procedure SaveCurrentMonitorProperties;
    function GetMonitorFromUserOptions: TMonitor;
    procedure ShowUserMissedHoursDialog;
    procedure ShowUserWorkBonusDialog;
    procedure ShowExportTo1CDialog;
    procedure ShowActiveUsersDialog;
    procedure ShowWebStaticPages;
    procedure ShowCalcSalesBonusDialog;
    procedure ShowActivityMonitorDialog;
    procedure ShowContractsTypeDialog;
    procedure ShowAddExpensesDialog;
    procedure BringDocsByToday;
    function BringDocsByTodayDB: Boolean;
    procedure CurrencyRateChangeBeforeStart(Sender: TObject);
    procedure WhenNeedToScanForEvent(Sender: TObject);
    procedure ShowCloseBusinessDayDialog;
    procedure ShowSqlRepositoryDialog;
    procedure ShowWebGoodsFlagsSetupDialog;
    function WebSiteRefreshGoodsDB: Boolean;
    procedure ShowComparePricesDialog;
    procedure ShowBugetDialog;

    // Service Plus
    procedure ShowServicePlusRepairAimsDialog;
    procedure ShowService_TaskTypesDialog;
    procedure InsertWKInfo;
    procedure SecurityInstrumente;
// TODO: ShowHistoryDialWindow
//      procedure ShowHistoryDialWindow;
    procedure ShowWebPromoGoodsByDay;
    procedure WebSecuritySetup;

  protected
    procedure SetupNomenclatoareRights;
    procedure ShowClientBankECB;
    procedure ShowWebFirstPageGoodsGroups;
  public    { Public declarations }
    procedure GotoDocument(const SearchDocumentID: Integer; const Target: TSearchDocumentSearchTarget);
    procedure ShowCreditRetailDlg;
  end;

var
  frmMainForm: TfrmMainForm;

implementation

uses
  AppSettingsDlg,
  Clipbrd,
  DMLinkAPIClientUnit,
  DataModuleAdditions,
  DataModuleDB,
  DateUtils,
  Dialogs,
  IdURI,
  LockFirmsDialog,
  MMSystem,
  Registry,
  SWNBaseUnit,
  SWNCustomersTypesUnit,
  SWNDBErrors,
  SWNSecurity,
  SWNSecurityFlags,
  SWNTypes,
  SWNUtils,
  SWNValueStorageUnit,
  SwnThreadsUnit,
  dxNavBarCollns,
  frame01CasaPKOUnit,
  frame02CasaRKOUnit,
  frame03CasaNSUnit,
  frame04BankPDNSUnit,
  frame05BankPDNSICUnit,
  frame06BankBPPLUnit,
  frame07BankBPPVUnit,
  frame08ConfigurationKonfiguratorUnit,
  frame09NakladniePNUnit,
  frame100CerereDePlataUnit,
  frame101WebscrapMuncitorulUnit,
  frame102WebscrapImperiaUnit,
  frame105VoltaUnit,
  frame106ConvelUnit,
  frame107CatolUnit,
  frame108LumeaInstrumentelorUnit,
  frame109SnaigeUnit,
  frame10NakladnieRNUnit,
  frame110BombaUnit,
  frame111UltraUnit,
  frame112HikokiUnit,
  frame113EuroTermUnit,
  frame114AcvilinUnit,
  frame115MegacomUnit,
  frame116ComputerUniverseUnit,
  frame117ParserBeanBagUnit,
  frame118InstrumentAllUnit,
  frame119PernaMeaUnit,
  frame11PeremesheniePUnit,
  frame120ATehnoUnit,
  frame121APIScopUnit,
  frame122SamsoniteUnit,
  frame123DehomeUnit,
  frame124HiTechUnit,
  frame125NexDistributionUnit,
  frame126RefurbUnit,
  frame127DoxyUnit,
  frame129VinzarePrinPartenerUnit,
  frame12CassaPersonalUnit,
  frame132DMLinkUnit,
  frame14NareadSborkaUnit,
  frame15TovarBezHaracteristicUnit,
  frame16NedostaiushiiTovarUnit,
  frame17NareadRazborkaUnit,
  frame18SciotNaOplatuUnit,
  frame20PrihodTovaraPoNakladnim,
  frame21ZarplataUnit,
  frame22OstatkiTovaraUnit,
  frame23SalidoKontragentovUnit,
  frame24WebZakazUnit,
  frame25ScetFakturaUnit,
  frame26AktSpisaniaUnit,
  frame27AktOprihodovaniaUnit,
  frame28NakladnieRNSUnit,
  frame29RezervUnit,
  frame30CassaFirmaUnit,
  frame31ServiceRequestsUnit,
  frame32ServiceRequestsWarrantyUnit,
  frame33ServiceReturnToVendorUnit,
  frame34ServiceReturnFromVendorUnit,
  frame35ServiceReturnToClientUnit,
  frame36ServiceNewIncidentsUnit,
  frame37ServiceDispatcherUnit,
  frame38ServiceFinishedIncidentsUnit,
  frame39ServiceEngineerUnit,
  frame40InventarizatiaPereotencaTovaraUnit,
  frame41AktOprihodPoNakladnim,
  frame42CassaGlobalFirmeUnit,
  frame43CashTransferUnit,
  frame44ZamenaPoBrakuUnit,
  frame45ZakritiTovarKomisiaUnit,
  frame46RascetZarplatiUnit,
  frame47ActiuniMarketingUnit,
  frame48KBPUnit,
  frame49ZacetBalansGarantiaUnit,
  frame50RealizatiaUnit,
  frame51ZaiavkaCreditUnit,
  frame52ZamenaTovaraUnit,
  frame53ARPPUnit,
  frame54InventarizatiaUnit,
  frame55VozvratPriemServiceUnit,
  frame57ActDeficienteUnit,
  frame58Unit,
  frame59TTNUnit,
  frame60PredvaritelnieZakaziUnit,
  frame61OstatkiDenegNaScetuUnit,
  frame62ContracteUnit,
  frame63AktSpisaniaPoNakladnim,
  frame64,
  frame70CorrInUnit,
  frame71CorrOutUnit,
  frame72ProiecteUnit,
  frame73DSEUnit,
  frame75ReminderForced,
  frame76ActiuniProduseWeb,
  frame77OportunitatiUnit,
  frame78PriceListUnit,
  frame80InventariereUnit,
  frame82Livrari,
  frame83PromoCoduriUnit,
  frame84RegistruCashbackUnit,
  frame85ApeluriUnit,
  frame86SoldClientiContabilUnit,
  frame87SupplierPromoUnit,
  frame88ImportGoods,
  frame89RezerveAnulateUnit,
  frame91APIAccentUnit,
  frame92APIUltraUnit,
  frame93TenderUnit,
  frame94WebCheckUnit,
  frame95VouchereCadouUnit,
  frame96DistribuireRambursUnit,
  frame97ClientBankUnit,
  frame98APIAmbiantaUnit,
  frameSchedulerUnit,
  frmAGoodsGroupsUnit,
  frmAboutDialog,
  frmActiveUsersDialog,
  frmAnalyticsDialog,
  frmBanksBrowse,
  frmBonusGoods2Dialog,
  frmBonusGoodsDialog,
  frmBugetDialog,
  frmCalcSalesBonusDialog,
  frmCertificationsDialog,
  frmChatWindow,
  frmCloseBusinessDayDialog,
  frmContractTypeDialog,
  frmCreateAppNewversionDialog,
  frmCrediteRetailUnit,
  frmCurrencyDlg,
  frmCurrencyExchangeDialog,
  frmCustomersDlg,
  frmDiscountGoodsDialog,
  frmDocTypesEditorBrowser,
  frmDocumentPreviewUnit,
  frmExpensesDialog,
  frmExportTo1CDialog,
  frmFilterDlg,
  frmFirmsLocksLogDialog,
  frmFiscalPrinterServiceDialogV1,
  frmFiscalPrinterServiceDialogV2,
  frmFiscalPrintersSetupDialog,
  frmGlobalCallHistoryUnit,
  frmGoods,
  frmGoodsACNTBrowser,
  frmGoodsFoldersDlg,
  frmGoodsRelatedBrowserUnit,
  frmGoodsTypeDialog,
  frmGroupGoodsAnalizeUnit,
  frmImportForeignGoodsIntoTableDialog,
  frmImportGoodsByTitlesDialog,
  frmIndeplinirePlanVinzariUnit,
  frmJobVacanciesDialog,
  frmKitTemplatesDialog,
  frmManageGoodsImagesUnit,
  frmMoneyTransferDialog,
  frmMoneyTransferToUserDialog,
  frmNacislenieZarplatiToolsDialog,
  frmNewVersionDialog,
  frmPhoneCallsOptionsUnit,
  frmPriceSynchronizeDialog,
  frmPriceTypesUnit,
  frmPrintWizardDialog,
  frmProcuriBrowserDialog,
  frmSMSPromo,
  frmSalaryInfoDialog,
  frmSalePlansDialog,
  frmSearchDocumentById2Dialog,
  frmSearchInDocsLog2Dialog,
  frmSearchSciotFacturaDialog,
  frmSearchSciotNaOplatuDialog,
  frmSearchWebUnit,
  frmServiceRefRepairAimsDialog,
  frmServiceRefTaskTypesDialog,
  frmSqlRepositoryWindow,
  frmStocksBrowser,
  frmSupplierGroupsUnit,
  frmSyssEditorWindow,
  frmToolsNewGoodsDialog,
  frmTransportUnit,
  frmUMDlg,
  frmUserActivityMonitorDialog,
  frmUserGroupsDlg,
  frmUserMissedHoursDialog,
  frmUserMissedHoursSetIntervalDialog,
  frmUserWorkBonusDialog,
  frmUsersBrowser,
  frmWebActiuniDialog,
  frmWebBlogDialog,
  frmBlockedIpDialog,
  frmApiConfigDialog,
  frmWebCatalogDialog,
  frmWebDeliveryDialog,
  frmWebDescriptionTemplateDialog,
  frmWebFilterButtonsDialog,
  frmWebFiltersDialog,
  frmWebGoodsGroupsUnit,
  frmWebMailingsDialog,
  frmWebPacheteProduseDialog,
  frmWebPromoActiuniDialog,
  frmWebShopsDialog,
  frmWebStaticPagesDialog,
  frmWebUrlsUnit,
  frmWorkStationsSetupDialog,
  uAnalizePriceList,
  uAnalizeSupplierPrice,
  uCrediteDlg,
  uFacturiFiscaleElectroniceVerificare,
  uPricesTypesDlg,
  uPromoGoodsByDayDlg,
  uSipLog,
  uSystemPeriodDlg,
  uWebConfigDlg,
  ufrmBankInOutDlg,
  unitUserAccessLogSearchDialog,
  frame19СчетаВходныеСчетаUnit;

type
  PDocTypeItem = ^TDocTypeItem;

  TDocTypeItem = record
    isFolder: Boolean;
    DocTypeID: Integer;
    TabSheetIndex: Integer;
  end;

{$R *.dfm}

function GetCurrentUserAndDomain(var User, Domain: string): Boolean;
var
  hToken: THandle;
  ptiUser: PTokenUser;
  cbti: DWORD;
  snu: SID_NAME_USE;
  pcchUser, pcchDomain: DWORD;
begin
  result := false;
  hToken := 0;
  ptiUser := nil;
  cbti := 0;
  pcchUser := 0;
  pcchDomain := 0;

  try
    { Get the calling thread's access token. }
    if not OpenThreadToken(GetCurrentThread, TOKEN_QUERY, true, hToken) then
    begin
      if GetLastError <> ERROR_NO_TOKEN then
        exit;

      { Retry against process token if no thread token exists. }
      if not OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hToken) then
        exit;
    end;

    { Obtain the size of the user information in the token. }
    if GetTokenInformation(hToken, TokenUser, nil, 0, cbti) then
      { Call should have failed due to zero-length buffer. }
      exit
    else
    begin
      { Call should have failed due to zero-length buffer. }
      if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
        exit;
    end;

    { Allocate buffer for user information in the token. }
    ptiUser := PTokenUser(HeapAlloc(GetProcessHeap, 0, cbti));
    if not Assigned(ptiUser) then
      exit;

    { Retrieve the user information from the token. }
    if not GetTokenInformation(hToken, TokenUser, ptiUser, cbti, cbti) then
      exit;

    { Retrieve user name and domain name based on user's SID. }
    { Delphi adaptation :
      The first call is used to get the length of the two strings }

    LookupAccountSid(nil, ptiUser.User.Sid, nil, pcchUser, nil, pcchDomain, snu);
    Setlength(User, pcchUser);
    Setlength(Domain, pcchDomain);
    if not LookupAccountSid(nil, ptiUser.User.Sid, PChar(User), pcchUser, PChar(Domain), pcchDomain, snu) then
      exit;

    result := true;
  finally
    { Free resources. }
    if hToken <> 0 then
      CloseHandle(hToken);

    if Assigned(ptiUser) then
      HeapFree(GetProcessHeap, 0, ptiUser);
  end;
end;

function TfrmMainForm.WebSiteRefreshGoodsDB: Boolean;
var
  Query: TIBCQuery;
begin
  result := false;
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_WEB_CREATE_CACHE_GOODS';
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      result := true;
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

procedure TfrmMainForm.WhenAppHint(Sender: TObject);
begin
  dxStatusBar.Panels[5].Text := Application.Hint;
end;

procedure TfrmMainForm.WhenDatesFilterChange(Sender: TObject);
var
  index: Integer;
  Silent: Boolean;
  filterObj: TDocumentDateFilterItem;
begin
  index := bbComboFilterDates.ItemIndex;
  if (index <> -1) then
  begin
    Silent := (bbComboFilterDates.Tag <> 0);
    filterObj := TDocumentDateFilterItem(bbComboFilterDates.Items.Objects[index]);
    fCurrentFrameDataFilter.Clear(filterObj.Filter);
    if not Silent then
      SWNFrameManager.FrameDataFilterChanged(fCurrentFrameDataFilter);
    HideFilterIndicator;
  end;
end;

procedure TfrmMainForm.bbActiveUsersClick(Sender: TObject);
begin
  ShowActiveUsersDialog;
end;

procedure TfrmMainForm.bbActivityMonitorClick(Sender: TObject);
begin
  ShowActivityMonitorDialog;
end;

procedure TfrmMainForm.bbAddExpensesClick(Sender: TObject);
begin
  ShowAddExpensesDialog;
end;

procedure TfrmMainForm.bbAnalyticTypesClick(Sender: TObject);
//var
//  dialog: TfrmAnalyticTypesDlg;
begin
  // dialog := TfrmAnalyticTypesDlg.Create(Self, );
  // try
  // dialog.ShowModal;
  // finally
  // dialog.Free;
  // end;
end;

procedure TfrmMainForm.bbAutoTransportClick(Sender: TObject);
var
  dialog: TfrmTransportDlg;
begin
  dialog := TfrmTransportDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbBlogClick(Sender: TObject);
var
  dialog: TfrmWebBlogDlg;
begin
  dialog := TfrmWebBlogDlg.Create(Self, dmdb.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbBonusGoods2Click(Sender: TObject);
begin
  ShowBonusGoods2Dialog;
end;

procedure TfrmMainForm.bbBonusGoodsClick(Sender: TObject);
begin
  ShowBonusGoodsDialog;
end;

procedure TfrmMainForm.bbBrandsClick(Sender: TObject);
var
  syssEditor: TfrmSelectSyssEditorWin;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    syssEditor.SetDefaultGroup(1);
    syssEditor.PartialCatalogAccess := True;
    syssEditor.ShowModal;
  finally
    syssEditor.Free;
  end;
end;

procedure TfrmMainForm.bbBringDocsByTodayClick(Sender: TObject);
begin
  BringDocsByToday;
end;

procedure TfrmMainForm.bbCalcSalesBonusClick(Sender: TObject);
begin
  ShowCalcSalesBonusDialog;
end;

procedure TfrmMainForm.bbCheckForUpdatesClick(Sender: TObject);
begin
  fUpdater.CheckForUpdateNow;
end;

procedure TfrmMainForm.bbCloneDocumentClick(Sender: TObject);
begin
  SWNFrameManager.DoButtonClick(fbtCLONE);
end;

procedure TfrmMainForm.bbCloseDocumentClick(Sender: TObject);
//var
//  frame: TSWNBaseFrame;
begin
  SWNFrameManager.DoCloseDocument(dmdb.ibcquerydocs.fieldbyname('docid').Asinteger);
//  frame := SWNFrameManager.CurrentFrame;
//  if Assigned(frame) then
//  begin
//    frame.OnCloseDocument(dmdb.ibcquerydocs.fieldbyname('docid').Asinteger);
//  end;
end;

procedure TfrmMainForm.bbOpenDocumentClick(Sender: TObject);
begin
    SWNFrameManager.DoOpenDocument(dmdb.ibcquerydocs.fieldbyname('docid').Asinteger);
end;

procedure TfrmMainForm.bbCloseBusinessDayClick(Sender: TObject);
begin
  ShowCloseBusinessDayDialog;
end;

procedure TfrmMainForm.bbECBClick(Sender: TObject);
begin
  ShowClientBankECB;
end;

procedure TfrmMainForm.bbEventClearLogClick(Sender: TObject);
begin
  fEventManager.Clear;
  DisplayEvents;
end;

procedure TfrmMainForm.bbEventGoToDocumentClick(Sender: TObject);
begin
  GotoDocumentFromEvent;
end;

procedure TfrmMainForm.bbExchangeCurrencyClick(Sender: TObject);
begin
  ShowCurrencyExchangeDialog;
end;

procedure TfrmMainForm.bbExportTo1CClick(Sender: TObject);
begin
  ShowExportTo1CDialog;
end;

procedure TfrmMainForm.bbFantasticOnlineClick(Sender: TObject);
begin
  cmbMainFirms.EditValue := TdxBarButton(Sender).Tag;
  dmDB.ChangeCurrentFirma(TdxBarButton(Sender).Tag, TdxBarButton(Sender).Caption);
  fCurrentFrameDataFilter.firmaID := TdxBarButton(Sender).Tag;
  dxStatusBar.Panels[3].Text := 'TVA=' + dmDB.FirmaInfo.VAT.ToString + '%, ' + TdxBarButton(Sender).Caption;
end;

procedure TfrmMainForm.bbFilterButtonsClick(Sender: TObject);
begin
  ShowWebFilterButtonsDialog;
end;

procedure TfrmMainForm.bbFindDocByIDClick(Sender: TObject);
begin
  ShowSearchDocumentByID2Dialog;
end;

procedure TfrmMainForm.bbGoodsPriceSynchronizeClick(Sender: TObject);
begin
  ShowGoodsPriceSynchronizeDialog;
end;

procedure TfrmMainForm.bbRealizatiaClick(Sender: TObject);
begin
  ShowImportForeighGoodsIntoTableDialog;
end;

procedure TfrmMainForm.bbImportGoodsByTitlesClick(Sender: TObject);
begin
  ShowImportGoodsFromTitlesDialog;
end;

procedure TfrmMainForm.bbJobsClick(Sender: TObject);
var
  dialog: TfrmJobVacanciesDlg;
begin
  dialog := TfrmJobVacanciesDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbKitTemplatesClick(Sender: TObject);
begin
  ShowKitTemplatesDialog;
end;

procedure TfrmMainForm.bbLockFirmsClick(Sender: TObject);
begin
  ShowLockFirmsDialog;
end;

procedure TfrmMainForm.bbLocksLogClick(Sender: TObject);
begin
  ShowSystemLocksLogDialog;
end;

procedure TfrmMainForm.bbLockSystemClick(Sender: TObject);
begin
  LockSystem;
end;

procedure TfrmMainForm.bbMainFilterClick(Sender: TObject);
begin
  ShowMainFilterDialog;
end;

procedure TfrmMainForm.bbMainFilterContextClick(Sender: TObject);
begin
  ShowContextMainFilterDialog;
end;

procedure TfrmMainForm.bbMainMenuAcs_AnalyticsClick(Sender: TObject);
begin
  ShowDocumentTypeAnalyticsDialog;
end;

procedure TfrmMainForm.bbMainMenuAcs_DocTypesClick(Sender: TObject);
begin
  ShowDocTypesDialog;
end;

procedure TfrmMainForm.bbMainMenuAcs_UserGroupsClick(Sender: TObject);
var
  dialog: TfrmUserGroupsEditor;
begin
  dialog := TfrmUserGroupsEditor.Create(Self);
  try
    dialog.ShowModal;
    SWNSecurityManager.ReadAccRights;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbMainMenuAcs_UsersClick(Sender: TObject);
var
  dialog: TfrmUsersDlg;
begin
  dialog := TfrmUsersDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbMainMenuHelp_AboutClick(Sender: TObject);
begin
  ShowAboutDialog;
  dmDB.ShowNotification;
end;

procedure TfrmMainForm.bbMainMenuRef_BanksClick(Sender: TObject);
begin
  ShowBanksEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_CurrencyClick(Sender: TObject);
begin
  ShowCurrencyEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_CustomersClick(Sender: TObject);
begin
  ShowCustomersEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_EnterprisesClick(Sender: TObject);
begin
  ShowFirmsEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_GoodsACNTClick(Sender: TObject);
begin
  ShowGoodsAcntEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_GoodsClick(Sender: TObject);
begin
  ShowGoodsEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_GoodsTypeClick(Sender: TObject);
begin
  ShowGoodsCategoryEditor;
end;

procedure TfrmMainForm.bbMainMenuRef_StocksClick(Sender: TObject);
begin
  ShowStocksEditor;
end;

procedure TfrmMainForm.bbMainMenuSys_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMainForm.bbMainMenuSys_SettingsClick(Sender: TObject);
begin
  ShowAppSettingsDialog;
end;

procedure TfrmMainForm.bbModifyDocumentClick(Sender: TObject);
begin
  SWNFrameManager.DoButtonClick(fbtMODIFY);
end;

procedure TfrmMainForm.bbMoneyTransferClick(Sender: TObject);
begin
  ShowMoneyTransferDialog;
end;

procedure TfrmMainForm.bbNacislenieZarplatiToolsClick(Sender: TObject);
begin
  ShowNacislenieZarplatiToolsDialog;
end;

procedure TfrmMainForm.bbNewDocumentClick(Sender: TObject);
begin
  SWNFrameManager.DoButtonClick(fbtADD);
end;

procedure TfrmMainForm.bbNewGoodsClick(Sender: TObject);
begin
  ShowNewGoodsDialog;
end;

procedure TfrmMainForm.bbOfferClick(Sender: TObject);
begin
  // schimbam Frame pe Oferte
  // SWNFrameManager.SwitchToFrame sau SWNFrameManager.GoToFrameEx
  SWNFrameManager.GoToFrameEx(8, -1, Date);
  Tframe08ConfigurationBRK(SWNFrameManager.CurrentFrame).CreateNewRecordFromSip(frameSipClient1.HistoryCallInfo.PhoneNumber,
    frameSipClient1.HistoryCallInfo.NickName, frameSipClient1.HistoryCallInfo.CustomerID);
end;

procedure TfrmMainForm.bbPrintDocumentsClick(Sender: TObject);
begin
  ShowPrintDocumentsDialog(dmDB.CurrentDocTypeID);
end;

procedure TfrmMainForm.bbPrint_PriceLabelsClick(Sender: TObject);
begin
  ShowPrintDocumentsDialog(-1, 1); // 1 - Etichete de pret
end;

procedure TfrmMainForm.bbPrint_PriceListClick(Sender: TObject);
begin
  ShowPrintDocumentsDialog(-1, 2); // 2 - Pricelist
end;

procedure TfrmMainForm.bbProcuriClick(Sender: TObject);
begin
  ShowProcuriDialog;
end;

procedure TfrmMainForm.bbQuickLinksPopup(Sender: TObject);
begin
  // check if items from popum menu are in current doc structure
  // 1. Calcul rapid configuratie
  bbShortcut_QuickSetupKit.Enabled := DocTypeExistsInTree(cDBID_DocType_КОНФИГУРАЦИИ_К);
  // 2. Nakladnaia de iesire
  bbShortcut_RashodNaklad.Enabled := DocTypeExistsInTree(cDBID_DocType_НАКЛАДНЫЕ_РН);
  // 4. Facturi fiscale
  bbShortcut_ScetFactura.Enabled := DocTypeExistsInTree(cDBID_DocType_СЧЕТ_ФАКТУРЫ_СФ);
  // 5. Dispozitie de incasare
  bbShortcut_PrihodCasaOrder.Enabled := DocTypeExistsInTree(cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО);
  // 6. Dispozitie de plata
  bbShortcut_RashCasaOrder.Enabled := DocTypeExistsInTree(cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО);
  // 7. Web Zakaz
  bbShortcut_WebZakaz.Enabled := DocTypeExistsInTree(cDBID_DocType_WEB_WЗ);
end;

procedure TfrmMainForm.bbRefCertificationsClick(Sender: TObject);
begin
  ShowCertificationsDialog;
end;

procedure TfrmMainForm.bbRefreshDocumentsClick(Sender: TObject);
begin
  SWNFrameManager.DoButtonClick(fbtREFRESH);
end;

procedure TfrmMainForm.bbRemoveDocumentClick(Sender: TObject);
begin
  SWNFrameManager.DoButtonClick(fbtDELETE);
end;

procedure TfrmMainForm.bbResetMainFilterClick(Sender: TObject);
begin
  ResetMainFilter;
end;

procedure TfrmMainForm.bbSalaryInfoClick(Sender: TObject);
begin
  ShowSalaryInfoDialog;
end;

procedure TfrmMainForm.bbSalePlansClick(Sender: TObject);
begin
  ShowSalePlansDialog;
end;

procedure TfrmMainForm.bbSearchDocsLogClick(Sender: TObject);
begin
  ShowSearchInDocsLogDialog;
end;

procedure TfrmMainForm.bbSearchScetOplataClick(Sender: TObject);
begin
  DoShowSearchScetNaOplatuDialog;
end;

procedure TfrmMainForm.bbSearchSciotFacturaClick(Sender: TObject);
begin
  ShowSearchSciotFacturaDialog;
end;

procedure TfrmMainForm.bbServicePlusRef_AimsClick(Sender: TObject);
begin
  ShowServicePlusRepairAimsDialog;
end;

procedure TfrmMainForm.bbServicePlusRef_TaskTypeClick(Sender: TObject);
begin
  ShowService_TaskTypesDialog;
end;

procedure TfrmMainForm.bbService_FiscalPrinterClick(Sender: TObject);
begin
  ShowServiceFiscalPrinter;
end;

procedure TfrmMainForm.bbShortcutQuickSetupClick(Sender: TObject);
begin
  case TdxBarButton(Sender).Tag of
    1:
      SwitchToDocType(cDBID_DocType_КОНФИГУРАЦИИ_К); // Configurator
    2:
      SwitchToDocType(cDBID_DocType_НАКЛАДНЫЕ_РН); // Nakladnaia de iesire
    4:
      SwitchToDocType(cDBID_DocType_СЧЕТ_ФАКТУРЫ_СФ); // Facturi fiscale
    5:      // Dispozitie de incasare
      SwitchToDocType(cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО);
    6:      // Dispozitie de plata
      SwitchToDocType(cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО);
    7:
      SwitchToDocType(cDBID_DocType_WEB_WЗ); // Web Zakaz
    8:
      SwitchToDocType(cDBID_DocType_PriceList); // Lista de preturi
    9:
      SwitchToDocType(cDBID_DocType_ИНВЕНТАРИЗАЦИЯ_ПТ); // Reevaluare
    10:
      SwitchToDocType(101); // Proforme
    11:
      SwitchToDocType(3425); // Vinzari prin partener
    12:
      SwitchToDocType(113); // Asamblare
    13:
      SwitchToDocType(106); // Intrari de marfa

  end;
end;

procedure TfrmMainForm.bbShowHideChatClick(Sender: TObject);
begin
  winChatWindow.Visible := not winChatWindow.Visible;
end;

procedure TfrmMainForm.bbSipLogClick(Sender: TObject);
var
  dialog: TfrmSipLog;
begin
  dialog := TfrmSipLog.Create(Owner);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbSMSClick(Sender: TObject);
var
  dialog: TfrmSMSPromoDialog;
begin
  dialog := TfrmSMSPromoDialog.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbSQLRepositoryClick(Sender: TObject);
begin
  ShowSqlRepositoryDialog;
end;

procedure TfrmMainForm.bbStockRecalcClick(Sender: TObject);
begin
  DoStockRecalcDB;
end;

procedure TfrmMainForm.bbStopDatabase1MinClick(Sender: TObject);
begin
  if ShowAskDialog('Incetarea lucrului sistemei', 'Sistema va fi oprita in 20 sec, Confirmati?') = mrYes then
    DoStopDb();
end;

procedure TfrmMainForm.bbSYSSClick(Sender: TObject);
begin
  ShowSYSSEditor;
end;

procedure TfrmMainForm.bbTipCrediteClick(Sender: TObject);
var
  dialog: TfrmCrediteDlg;
begin
  dialog := TfrmCrediteDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbToolsRecalcQtyAcntClick(Sender: TObject);
begin
  dmDB.ExecuteQuery('EXECUTE PROCEDURE RECALC_ALL_STOCK_ACNT', []);
  ShowMessage('Stoc contabil recalculat!');
end;

procedure TfrmMainForm.bbToolsRecalcQtyInTransferClick(Sender: TObject);
begin
  RecalcQtyInTransfer;
end;

procedure TfrmMainForm.bbUMClick(Sender: TObject);
var
  dialog: TfrmUMDialog;
begin
  dialog := TfrmUMDialog.Create(Application);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbUserMissedHoursClick(Sender: TObject);
begin
  ShowUserMissedHoursDialog;
end;

procedure TfrmMainForm.bbUserWorkBonusClick(Sender: TObject);
begin
  ShowUserWorkBonusDialog;
end;

procedure TfrmMainForm.bbWebAccessLogClick(Sender: TObject);
var
  dialog: TfrmUserAccessLogSearchDialog;
begin
  dialog := TfrmUserAccessLogSearchDialog.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbWebActiuniClick(Sender: TObject);
begin
  ShowWebPromoActiuniDialog;
end;

procedure TfrmMainForm.bbWebCatalogClick(Sender: TObject);
begin
  ShowWebCatalogDialog;
end;

procedure TfrmMainForm.bbWebBlockedIpClick(Sender: TObject);
var
  dialog: TfrmBlockedIpDlg;
begin
  dialog := TfrmBlockedIpDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbApiConfigClick(Sender: TObject);
var
  dialog: TfrmApiConfigDlg;
begin
  dialog := TfrmApiConfigDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbWebConfigClick(Sender: TObject);
var
  d: TfrmWebConfigDlg;
begin
  d := TfrmWebConfigDlg.Create(Self, dmDB.IBCConnection);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.bbWebDeliveryClick(Sender: TObject);
begin
  ShowWebDeliveryDialog;
end;

procedure TfrmMainForm.bbWebDescriptionTemplatesClick(Sender: TObject);
begin
  ShowWebDescriptionTemplatesDialog;
end;

procedure TfrmMainForm.bbWebFiltersClick(Sender: TObject);
begin
  ShowWebFiltersDialog;
end;

procedure TfrmMainForm.bbWebGoodsFlagsClick(Sender: TObject);
begin
  ShowWebGoodsFlagsSetupDialog;
end;

procedure TfrmMainForm.bbWebMailingListsClick(Sender: TObject);
begin
  ShowWebMailingLists;
end;

procedure TfrmMainForm.bbWebPacheteProduseClick(Sender: TObject);
var
  dialog: TfrmWebPacheteProduseDlg;
begin
  dialog := TfrmWebPacheteProduseDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbWebPromoActiuniClick(Sender: TObject);
var
  dialog: TfrmWebPromoActiuniDlg;
begin
  dialog := TfrmWebPromoActiuniDlg.Create(Self);
  try
    dialog.FirmaID := 5213; //dmdb.FirmaInfo.FirmaID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbWebSearchClick(Sender: TObject);
var
  d: TfrmSearchWebDialog;
begin
  d := TfrmSearchWebDialog.Create(self, dmDB.IBCConnection);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.bbWebShopsClick(Sender: TObject);
begin
  ShowWebShopsDialog;
end;

procedure TfrmMainForm.bbWebSiteRefreshGoodsClick(Sender: TObject);
begin
  if ShowAskDialog('Reinoire date pentru site', 'Doriti sa reinoiti datele privind produsele de pe site?') = mrYes then
  begin
    if WebSiteRefreshGoodsDB then
      ShowInfoDialog('Reinoire date pentru site', 'Finisat. Pe parcursul unui minut datele for fi modificate pe site!');
  end;
end;

procedure TfrmMainForm.bbWebStaticPagesClick(Sender: TObject);
begin
  ShowWebStaticPages;
end;

procedure TfrmMainForm.bbWebUrlManagerClick(Sender: TObject);
var
  dialog: TfrmWebUrlsDialog;
begin
  dialog := TfrmWebUrlsDialog.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bntSerialSearchClick(Sender: TObject);
begin
  ShowPrintDocumentsDialog(-1, 16); // 16 - cautare dupa numar serial/de partida
end;

procedure TfrmMainForm.BuildStructureList;
var
  Group: TdxNavBarGroup;
begin
  dxStructureNavigation.BeginUpdate;
  try
    dxStructureNavigation.Groups.Clear;

    with dmDB do
    begin
      IBCQueryTemp.Close;
      IBCQueryTemp.SQL.Text := 'SELECT STRUCTUREID, TITLE, IMAGE_INDEX FROM GET_STRUCTURE_BY_USER(:UserID)';
      IBCQueryTemp.ParamByName('UserID').AsInteger := dmDB.CurrentUserID;
      IBCQueryTemp.ExecSQL;
      while not IBCQueryTemp.Eof do
      begin
        Group := dxStructureNavigation.Groups.Add;
        Group.Expanded := false;
        Group.Tag := IBCQueryTemp.Fields[0].AsInteger;
        Group.Caption := IBCQueryTemp.Fields[1].AsString;
        Group.UseControl := true;
//                Group.LargeImageIndex := IBCQueryTemp.FieldByName('IMAGE_INDEX').AsInteger;
        Group.SmallImageIndex := IBCQueryTemp.FieldByName('IMAGE_INDEX').AsInteger;
        IBCQueryTemp.Next;
      end;
      IBCQueryTemp.Close;
    end;
  finally
    if dxStructureNavigation.Groups.Count <= 1 then
      dxStructureNavigation.OptionsView.Common.ShowGroupCaptions := false;
    dxStructureNavigation.EndUpdate;
  end;
end;

procedure TfrmMainForm.cmbMainFirmsCurChange(Sender: TObject);
var
  filterItem: TDocumentDateFilterItem;
  firmaName: string;
  firmaID: Integer;
begin
  // Se schimba firma curenta
  // anulam filtrele silent si punem filtrul pe data implicit
  filterItem := SWNDocumentFrameDateFilters.GetFilterObject(cDocumentDefaultFilter);
  if Assigned(filterItem) then
  begin

    bbComboFilterDates.Tag := 1;
    bbComboFilterDates.ItemIndex := bbComboFilterDates.Items.IndexOfObject(filterItem);
    bbComboFilterDates.Tag := 0;
    fCurrentFrameDataFilter.Clear(filterItem.Filter);
  end;

  // schimbam firma si reload la date
  firmaID := cmbMainFirms.EditValue;
  firmaName := TcxImageComboBoxProperties(cmbMainFirms.Properties).GetDisplayText(firmaID);
  dmDB.ChangeCurrentFirma(firmaID, firmaName);

  // display current firma name in status bar
  dxStatusBar.Panels[3].Text := 'TVA=' + dmDB.FirmaInfo.VAT.ToString + '%, ' + dmDB.FirmaInfo.firmaName;
  // set event manager firma
  fEventManager.Firma := firmaID;
  // display last event from changed firma
  DisplayEvents;
  // rebuild quick access reports list
  DisplayQuickAccessReports;

  // notificam Frame-u curent despre schimbarea filtrului de date
  fCurrentFrameDataFilter.firmaID := firmaID;
  SWNFrameManager.FrameDataFilterChanged(fCurrentFrameDataFilter);
end;

procedure TfrmMainForm.BringDocsByToday;
begin
  if ShowAskDialog('Modificare data documente', 'Modificare datei documentelor pe ziua curenta?') = mrYes then
  begin
    if BringDocsByTodayDB then
    begin
      // Refresh Rashod
      if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID in [6, 10, 11, 14]) then
        dmDB.FullRefresh;
      ShowInfoDialog('Modificare data documente', 'Finisat!');
    end;
  end;
end;

function TfrmMainForm.BringDocsByTodayDB: Boolean;
var
  Query: TIBCQuery;
begin
  result := false;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := false;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_UPDATE_DATE_IN_DOCS';
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      result := true;
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
  Application.Terminate;
end;

procedure TfrmMainForm.BuildFirmList;
var
  Props: TcxImageComboBoxProperties;
  Item: TcxImageComboBoxItem;
  S: string;
  fLastFirmaID: Integer;
begin
  fLastFirmaID := SWNSecurityManager.LoggedUser.DefaultFirma;
  Props := TcxImageComboBoxProperties(cmbMainFirms.Properties);
  Props.BeginUpdate;
  try
    Props.Items.Clear;
    S := '';
    with dmDB do
    begin
      IBCQueryTemp.Close;
      IBCQueryTemp.SQL.Text := 'SELECT * FROM GET_FIRMS_BY_USER(:UserID)';
      IBCQueryTemp.ParamByName('UserID').AsInteger := dmDB.CurrentUserID;
      IBCQueryTemp.Open;
      while not IBCQueryTemp.Eof do
      begin
        Item := Props.Items.Add;
        Item.Value := IBCQueryTemp.FieldByName('CUSTOMERID').AsInteger;
        if (SWNSecurityManager.LoggedUser.IsSuperAdminUser) then
          Item.Description := Format('%s (%d)', [IBCQueryTemp.FieldByName('DISPLAYNAME').AsString, Integer(Item.Value)])
        else
          Item.Description := Format('%s', [IBCQueryTemp.FieldByName('DISPLAYNAME').AsString]);
        Item.ImageIndex := 11;
        if (fLastFirmaID = -1) or (fLastFirmaID = Item.Value) then
        begin
          fLastFirmaID := Item.Value;
          S := Item.Description;
        end;

        IBCQueryTemp.Next;
      end;
      IBCQueryTemp.Close;
    end;
  finally
    cmbMainFirms.EditValue := fLastFirmaID;
    dmDB.ChangeCurrentFirma(fLastFirmaID, S);
    fCurrentFrameDataFilter.FirmaID := fLastFirmaID;
    dxStatusBar.Panels[3].Text := 'TVA=' + dmDB.FirmaInfo.VAT.ToString + '%, ' + S;
    Props.EndUpdate;
  end;
end;

procedure TfrmMainForm.CreateDateFilter(const Filters: TFrameDocumentDateFilterSet);
var
  i: TFrameDocumentDateFilter;
  filterObj: TDocumentDateFilterItem;
  N: Integer;
begin
  // set event catcher
  bbComboFilterDates.OnChange := nil;
  bbComboFilterDates.Items.BeginUpdate;
  try
    bbComboFilterDates.Items.Clear;
    for i in cDocumentAllFilters do
      if (i in Filters) then
      begin
        filterObj := SWNDocumentFrameDateFilters.GetFilterObject(i);
        N := bbComboFilterDates.Items.AddObject(filterObj.Title, filterObj);
        if (i = cDocumentDefaultFilter) then
        begin
          bbComboFilterDates.ItemIndex := N;
          fCurrentFrameDataFilter.Clear(i);
        end;
      end;
  finally
    bbComboFilterDates.Items.EndUpdate;
    // set event catcher
    bbComboFilterDates.OnChange := WhenDatesFilterChange;
  end;
end;

procedure TfrmMainForm.cxDBTreeListChatCollapsing(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
begin
  Allow := false;
end;

procedure TfrmMainForm.cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    GotoDocumentFromEvent;
    AHandled := true;
  end;
  {
    if ACellViewInfo.GridRecord.Values[cxGridTable_PROCESSED.Index]=False then
    begin
    ACellViewInfo.GridRecord.Values[cxGridTable_PROCESSED.Index]:=True;
    DocID:=ACellViewInfo.GridRecord.Values[cxGridTable_DOCID.Index];

    if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID=10)
    then dmDB.IBCQueryDocs.Locate('DOCID',DocID,[])
    else SWNFrameManager.GoToFrame(10,DocID);

    AHandled:=True;
    end;
  }
end;

procedure TfrmMainForm.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridTable_ISNEW.index] = false then
  begin
    ACanvas.Font.Color := clGrayText;
  end;
end;

procedure TfrmMainForm.cxGridTable_DateTimeGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridTable_DateTime.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridTable_DateTime.index]);
end;

procedure TfrmMainForm.cxTreeDocTypesCanFocusNode(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
var
  Data: PDocTypeItem;
begin
  if Assigned(ANode) then
  begin
    Data := PDocTypeItem(ANode.Data);
    Allow := Data^.TabSheetIndex <> -1;
  end
end;

procedure TfrmMainForm.cxTreeDocTypesCanSelectNode(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
var
  Data: PDocTypeItem;
begin
  Data := PDocTypeItem(ANode.Data);
  Allow := (Data^.TabSheetIndex <> -1);
end;

procedure TfrmMainForm.cxTreeDocTypesCollapsing(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
begin
  Allow := false;
end;

procedure TfrmMainForm.cxTreeDocTypesDblClick(Sender: TObject);
begin
  if Assigned(cxTreeDocTypes.FocusedNode) then
  begin
    Clipboard.asText := cxTreeDocTypes.FocusedNode.Texts[0];
  end;
end;

procedure TfrmMainForm.cxTreeDocTypesDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
var
  Data: PDocTypeItem;
begin
  Data := PDocTypeItem(ANode.Data);
  Dispose(Data);
end;

procedure TfrmMainForm.cxTreeDocTypesStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode:
  TcxTreeListNode; var AStyle: TcxStyle);
var
  Data: PDocTypeItem;
begin
  Data := PDocTypeItem(ANode.Data);
  if Data^.isFolder then
    AStyle := dmAdditions.cxStyle_Bold
  else if (Data^.TabSheetIndex = -1) then
    AStyle := dmAdditions.cxStyle_TextGray;
end;

procedure TfrmMainForm.WhenTreeDocTypesFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode:
  TcxTreeListNode);
var
  Data: PDocTypeItem;
  Frame: TSWNBaseFrame;
  DocID: Integer;
begin
    // Kind se schimba documentul activ in copacul documentelor
  if Assigned(AFocusedNode) then
  begin
    Data := PDocTypeItem(AFocusedNode.Data);
    if (Data^.TabSheetIndex <> -1) then
    begin
            // change DocType
      fCurrentFrameDataFilter.DocTypeID := Data^.DocTypeID;
      dmDB.SetCurrentDocTypeID(Data^.DocTypeID);
            /// !!! Kind se schimba tipul documentului, nu se schimba filtrele curente
      DocID := cxTreeDocTypes.Tag;
            // show frame by TabSheetIndex
      Frame := SWNFrameManager.SwitchToFrame(Data^.TabSheetIndex, fCurrentFrameDataFilter, cxTreeDocTypes.Tag);
      cxTreeDocTypes.Tag := -1;
      if Assigned(Frame) then
      begin
                // locate search document
        if DocID = -1 then
          Frame.SetupDefaultView
        else
          Frame.LocateDocument(DocID);
                // put focus
        Frame.SetupDefaultFocus;
      end
    end
    else
    begin
      SWNFrameManager.HideCurrentFrame;
      dmDB.SetCurrentDocTypeID(-1 { , fdsNone } );
      WhenFrameShow(nil);
    end;
  end
  else
  begin
    SWNFrameManager.HideCurrentFrame;
    WhenFrameShow(nil);
  end;
end;

procedure TfrmMainForm.DisplayAppCaption;
var
  S: string;
begin
  Caption := cAPP_Title;
  S := '';
  if GetSystemMetrics(sm_RemoteSession) <> 0 then
    S := ' (T)';
  dxStatusBar.Panels[0].Text := Format(cAPP_Version, [fUpdater.AppVersionStr]);
  if SWNSecurityManager.LoggedUser.IsSuperAdminUser then
    dxStatusBar.Panels[1].Text := Format(cAPP_Server, [dmDB.DBAlias, dmDB.DBServer, S])
  else
    // dxStatusBar.Panels[1].Text := 'cloud:DDEG954AE4832';
    dxStatusBar.Panels[1].Text := Format(cAPP_Server, [dmDB.DBAlias, dmDB.DBServer, S]);
  dxStatusBar.Panels[2].Text := dmDB.CurrentUserFullName;
end;

procedure TfrmMainForm.DisplayEvents;
var
  i, N: Integer;
  Event: TSWNDBEvent;
begin
  cxGridTable.DataController.BeginUpdate;
  try
    // clear existing
    for i := cxGridTable.DataController.RecordCount - 1 downto 0 do
      cxGridTable.DataController.DeleteRecord(i);
    // populate with event from current Firma only
    for i := 0 to fEventManager.Count - 1 do
    begin
      Event := fEventManager.Events[i];
      if Event.DT = dmDB.CurrentFirma then
      begin
        N := cxGridTable.DataController.InsertRecord(0);
        cxGridTable.DataController.Values[N, cxGridTable_EVENTID.index] := Event.EventID;
        cxGridTable.DataController.Values[N, cxGridTable_DateTime.index] := Event.DateTime;
        cxGridTable.DataController.Values[N, cxGridTable_EVENT.index] := Event.Title;
        cxGridTable.DataController.Values[N, cxGridTable_DOCID.index] := Event.ValueInt;
        cxGridTable.DataController.Values[N, cxGridTable_MSG.index] := Event.Msg;
        cxGridTable.DataController.Values[N, cxGridTable_EVENTTYPE.index] := Ord(Event.EventType);
        cxGridTable.DataController.Values[N, cxGridTable_ISNEW.index] := Event.IsNew;
        cxGridTable.DataController.Values[N, cxGridTable_USERFULLNAME.index] := Event.UserFullName;
      end;
    end;
  finally
    cxGridTable.DataController.EndUpdate;
  end;
end;

procedure TfrmMainForm.DisplayQuickAccessReports;
var
  Query1: TIBCQuery;
  link: TdxBarItemLink;
  btn: TdxBarButton;
  isFirst: Boolean;
  i: Integer;
begin
  // delete existing items
  for i := bbQuickAccessReports.ItemLinks.Count - 1 downto 0 do
  begin
    link := bbQuickAccessReports.ItemLinks[i];
    link.Free;
  end;

  // In "PartialAccessMode" meniul "Rapoarte rapide" nu se vede!
  if SWNSecurityManager.IsPartialAccessMode then
    exit;

  Query1 := TIBCQuery.Create(Self);
  try
    Query1.Connection := dmDB.IBCConnection;
    Query1.SQL.Text := 'SELECT REPORTID,TITLE FROM GET_QUICK_ACCESS_REPORTS(:firma)';
    Query1.ParamByName('firma').AsInteger := dmDB.CurrentFirma;
    Query1.ExecSQL;
    isFirst := true;
    if Query1.Eof then
    begin
      bbQuickAccessReports.Visible := ivNever;
    end
    else
    begin
      bbQuickAccessReports.Visible := ivAlways;

      while not Query1.Eof do
      begin
        link := bbQuickAccessReports.ItemLinks.AddButton;
        if isFirst then
          link.BeginGroup := true;

        btn := TdxBarButton(link.Item);
        btn.Caption := Query1.Fields[1].AsString;
        btn.Tag := Query1.Fields[0].AsInteger;
        btn.OnClick := WhenQuickAccessReportClicked;
        btn.ImageIndex := 28;

        Query1.Next;
        isFirst := false;
      end;
    end;
  finally
    Query1.Free;
  end;
end;

function TfrmMainForm.DocTypeExistsInTree(const DocTypeID: Integer): Boolean;
var
  NodeParent, Node: TcxTreeListNode;
  Data: PDocTypeItem;
begin
  result := false;
  if cxTreeDocTypes.Count > 0 then
  begin
    NodeParent := cxTreeDocTypes.Items[0];
    while NodeParent <> nil do
    begin
      Node := NodeParent.getFirstChild;
      while Node <> nil do
      begin
        Data := PDocTypeItem(Node.Data);
        if Data^.DocTypeID = DocTypeID then
        begin
          result := true;
          break;
        end;
        Node := Node.getNextSibling;
      end;
      if result then
        break;
      NodeParent := NodeParent.getNextSibling;
    end;
  end;
end;

function TfrmMainForm.DoRecalcQtyInTransferDB: Boolean;
var
  Query: TIBCQuery;
begin
  result := false;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := false;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE RECALC_TRANSIT_QTY';
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      result := true;
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

procedure TfrmMainForm.DoShowSearchScetNaOplatuDialog;
var
  dialog: TfrmSearchSciotNaOplatuDlg;
begin
  dialog := TfrmSearchSciotNaOplatuDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
      SWNFrameManager.GoToFrameEx(18, dialog.DocID, dialog.DocData);
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.DoStockRecalcDB;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE RECALC_ALL_STOCK_NEW';
      Query.Execute;

      Query.Transaction.Commit;
      ShowInfoDialog('Recalcul', 'Recalcul stoc finisat cu succes!');
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

procedure TfrmMainForm.DoStopDb;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := false;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SYS_SHUTDOWN_DB(:UserID)';
      Query.ParamByName('UserID').AsInteger := dmDB.CurrentUserID;
      Query.Execute;
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

procedure TfrmMainForm.bbCreateAppNewVersionClick(Sender: TObject);
begin
  ShowCreateNewAppVersionDialog;
end;

procedure TfrmMainForm.bbCrediteRetailClick(Sender: TObject);
begin
  ShowCreditRetailDlg;
end;

procedure TfrmMainForm.bbCustomerInfoByPhoneClick(Sender: TObject);
begin
  frameSipClient1.ShowCustomerCallInfo(frameSipClient1.IBCCallHistory.FieldByName('PHONENUMBER').AsString);
end;

procedure TfrmMainForm.bbDiscountGoodsClick(Sender: TObject);
begin
  ShowDiscountGoodsDialog;
end;

procedure TfrmMainForm.bbDocContractTypesClick(Sender: TObject);
begin
  ShowContractsTypeDialog;
end;

procedure TfrmMainForm.bbComparePricesClick(Sender: TObject);
begin
  ShowComparePricesDialog;
end;

procedure TfrmMainForm.bbCostAnalyzeClick(Sender: TObject);
var
  dialog: TfmAnalizePriceList;
begin
  dialog := TfmAnalizePriceList.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbPhoneCallsClick(Sender: TObject);
var
  d: TfrmPhoneCallsOptionsDlg;
begin
  d := TfrmPhoneCallsOptionsDlg.Create(self, dmdb.ibcconnection);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.bbPlanVinzariClick(Sender: TObject);
var
  dialog: TfrmIndeplinirePlanVinzariDialog;
begin
  dialog := TfrmIndeplinirePlanVinzariDialog.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbPriceListAnalyzeClick(Sender: TObject);
var
  dialog: TfmAnalizeSupplierPrice;
begin
  dialog := TfmAnalizeSupplierPrice.Create(Application);
  dialog.ShowModal;
  dialog.Free;
end;

procedure TfrmMainForm.bbPriceRulesClick(Sender: TObject);
var
  dialog: TfrmPriceTypesDlg;
begin
  dialog := TfrmPriceTypesDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbPricePolicyClick(Sender: TObject);
var
  dialog: TfrmPriceTypesDlg;
begin
  dialog := TfrmPriceTypesDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton10Click(Sender: TObject);
var
  d: TfrmGlobalCallHistory;
begin
  d := TfrmGlobalCallHistory.Create(self);
  try
    if frameSipClient1.HistoryCallInfo.PhoneNumber = '' then
      d.phonenumber := frameSipClient1.IBCCallHistory.FieldByName('PHONENUMBER').AsString
    else
      d.phonenumber := frameSipClient1.HistoryCallInfo.PhoneNumber;

    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton11Click(Sender: TObject);
var
  d: TfrmSupplierGroupsDlg;
begin
  d := TfrmSupplierGroupsDlg.Create(Self, dmDB.IBCConnection);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton12Click(Sender: TObject);
var
  d: TfrmGoodsRelatedDlg;
begin
  d := TfrmGoodsRelatedDlg.Create(Self);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton14Click(Sender: TObject);
begin
  var d := TfrmNewGoodsCatalogDlg.Create(self);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.bbRecalcPreturiClick(Sender: TObject);
var
  myThread: TCurrencyRateChangeThread;
begin
  if MessageDlg('Incepeti procedure de recalcul pentru toate produsele ?', TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    myThread := TCurrencyRateChangeThread.Create(true);
    myThread.OnBeforeStart := (
      procedure
      begin
        dxStatusBar.Panels[5].Text := 'Modificare curs, recalcul preturi...';
        dxStatusBar.Panels[5].PanelStyle.Color := clBtnFace;
        dxStatusBar.Panels[5].PanelStyle.Font.Color := clBlue;

      end);

    myThread.OnSuccesFinished := (
      procedure
      begin
        dxStatusBar.Panels[5].Text := 'Finisat cu succes...';
        dxStatusBar.Panels[5].PanelStyle.Color := clBtnFace;
        dxStatusBar.Panels[5].PanelStyle.Font.Color := clBlue;

      end);

    myThread.Priority := tpNormal;
    myThread.FreeOnTerminate := true;
    myThread.Start;
  end;
end;

procedure TfrmMainForm.dxBarButton1Click(Sender: TObject);
begin
  ShowBugetDialog;
end;

procedure TfrmMainForm.dxBarButton4Click(Sender: TObject);
var
  dialog: TfrmPricesTypesDlg;
begin
  dialog := TfrmPricesTypesDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton5Click(Sender: TObject);
begin
  frameSipClient1.ShowCustomerCallInfo(frameSipClient1.HistoryCallInfo.PhoneNumber);
end;

procedure TfrmMainForm.dxBarButton6Click(Sender: TObject);
begin
// var
////  API: TDMLinkAPIClient;
//  Products: TJSONArray;
//  OrderResponse: string;
//begin
//  API := TDMLinkAPIClient.Create;
//  try
//    if API.Login('duca.al@gmail.com', 'Uno2025!@') then
//    begin
//      ShowMessage(API.GetAllProducts(100));
//
//      Products := TJSONArray.Create;
//      Products.AddElement(
//        TJSONObject.Create
//          .AddPair('sku', 'VT75')
//          .AddPair('qty', '1')
//      );
//
//      OrderResponse := API.CreateOrder('dealer-id-obtinut', Products, 'comanda test');
//      ShowMessage(OrderResponse);
//    end;
//  finally
//    API.Free;
//  end;
//end;
end;

procedure TfrmMainForm.bbSeoActualizareWebClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_UPDATE_SEO_DATA';
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      dmDB.IBCTrDefaultUpdate.Commit;
    except
      on E: Exception do
      begin
        dmDB.IBCTrDefaultUpdate.Rollback;
        raise;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton7Click(Sender: TObject);
var
  dialog: TfrmAGoodsGroupsDlg;
begin
  dialog := TfrmAGoodsGroupsDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.dxBarButton9Click(Sender: TObject);
var
  dialog: TfrmFacturiFiscaleElectroniceVerificareDlg;
begin
  dialog := TfrmFacturiFiscaleElectroniceVerificareDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbChangeCustomerNameClick(Sender: TObject);
var
  CustomerName: string;
  Query: TIBCQuery;
begin
  CustomerName := frameSipClient1.HistoryCallInfo.NickName;
  if InputQuery('SWN', 'Introduceti numele corect al clientului:', CustomerName) then
  begin
    Query := TIBCQuery.Create(Self);
    try
      Query.SQL.Text := 'update ts_customer set name = :name where customerid = :customerid';
      Query.ParamByName('name').AsString := UpperCase(CustomerName);
      Query.ParamByName('customerid').AsInteger := frameSipClient1.HistoryCallInfo.CustomerID;
      Query.Transaction := frameSipClient1.IBCTrSipUpdate;
      Query.Transaction.StartTransaction;
      try
        Query.ExecSQL;
        Query.Transaction.Commit;
      except
        on e: Exception do
        begin
          Query.Transaction.Rollback;
          raise;
        end;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TfrmMainForm.bbWebGoodsGroupsClick(Sender: TObject);
begin
  ShowWebFirstPageGoodsGroups;
end;

procedure TfrmMainForm.bbDialClick(Sender: TObject);
begin
  frameSipClient1.PhoneEdit.Text := SWNFrameManager.GetFrameNumberToDial;
  frameSipClient1.CallActionExecute(Sender);
end;

procedure TfrmMainForm.bbPromoPerDayClick(Sender: TObject);
begin
  ShowWebPromoGoodsByDay;
end;

procedure TfrmMainForm.bbGrupeProduseAnalizaClick(Sender: TObject);
var
  dialog: TfrmGroupGoodsAnalizeDlg;
begin
  dialog := TfrmGroupGoodsAnalizeDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbRegistrulBancarClick(Sender: TObject);
var
  dialog: TfrmBankInOut;
begin
  dialog := TfrmBankInOut.Create(Self, dmDB.IBCConnection);
  try
    dialog.DT := dmDB.CurrentFirma;
    if (dialog.ShowModal = mrOk) then
    begin
    end;

  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbManagerGoodsImagesClick(Sender: TObject);
var
  dialog: TfrmManageGoodsImages;
begin
   // Gestionare imagini produse
  dialog := TfrmManageGoodsImages.Create(Self, dmdb.IBCConnection);
  try
    dialog.ShowModal
  finally
    dialog.free;
  end;

end;

procedure TfrmMainForm.bbManageWorkPeriodsClick(Sender: TObject);
var
  dialog: TfrmSystemPeriodDlg;
begin
  dialog := TfrmSystemPeriodDlg.Create(Self);
  try
    dialog.ShowModal
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbMCCClick(Sender: TObject);
var
  dialog: TfrmFiscalPrintersSetupDlg;
begin
  dialog := TfrmFiscalPrintersSetupDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.bbWorkStationsClick(Sender: TObject);
var
  dialog: TfrmWorkStationsSetupDlg;
begin
  dialog := TfrmWorkStationsSetupDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.dxStatusBarPanels4DblClick(Sender: TObject);
begin
  if dxStatusBar.Panels[4].Text <> '' then
    ResetMainFilter;
end;

procedure TfrmMainForm.dxStatusBarPanels6DblClick(Sender: TObject);
begin
  if dmDB.IBCTrDefaultUpdate.Active and (ShowAskDialog('Transactia activa!', 'Update transactia este activa. ' +
    sLineBreak + 'Inchidem transactia?') = mrYes) then
    dmDB.IBCTrDefaultUpdate.Commit;
end;

procedure TfrmMainForm.dxStructureNavigationActiveGroupChanged(Sender: TObject);
begin
  StructureListChanged(dxStructureNavigation.ActiveGroupIndex);
end;

procedure TfrmMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

procedure TfrmMainForm.FormCreate(Sender: TObject);
var
  tmpMonitor: TMonitor;
begin
  // kill collab and launch new process
  try
    swnUtils.KillTask('collabman.exe');
  except

  end;

  Application.OnHint := WhenAppHint;

  fCurrentFrameFilterFields := [];
  fCurrentFrameDataFilter := TFrameDataFilteringInfo.Create;

  SWNFrameManager.FrameParentControl := pnClient;
  SWNFrameManager.OnRequiredFrameNotFound := WhenRequiredFrameNotFound;
  SWNFrameManager.OnFrameShow := WhenFrameShow;
  SWNFrameManager.OnButtonStateChanged := WhenFrameButtonStateChanged;
  SWNFrameManager.OnGotoFrame := WhenGotoFrame;
  SWNFrameManager.OnGotoFrameEx := WhenGotoFrameEx;
  SWNFrameManager.OnShowPrintDialog := WhenNeedShowPrintDialog;

  cxTreeDocTypes.Tag := -1;

  CreateDateFilter(cDocumentAllFilters);

  SetupSecurityItems;

  BuildFirmList;
  BuildStructureList;

  fUpdater := TSWNUpdateDBClient.Create(dmDB.IBCConnection, cUPDATE_IntervalCheckMin);
  fUpdater.OnNewVersionExists := WhenNewVersionFound;
  fUpdater.OnNoVersionFound := WhenNoVersionFound;
  fUpdater.BeginCheckForNewVersions;

  DisplayAppCaption;

  fEventManager := TSWNDBEventManager.Create(dmDB.IBCConnection);
  fEventManager.OnNewEvent := WhenNewEventArrive;
  fEventManager.Firma := dmDB.CurrentFirma;

  // Event "Nakladnaia de iesire"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Расходная_накладная) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetRashod];
  // Event "Naryad de asamblare"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Наряд_на_сборку) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetSborka];
  // Event "Modificare comentarii"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Изменение_комментариев) then
    fEventManager.EventTypes := fEventManager.EventTypes + cEventsComments;
  // Event "Comanda Web"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Web_Заказ) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetWebZakaz];
  // Event "Cerere de finantare"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Заявка_на_финансирование) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetWebCerereFinantare];
  // Event "Grafic de livrare"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_График_доставки) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetSchedulerDelivery];
  // Event "Comenzi preliminare"
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_SE_Event_Предварительные_заказы) then
    fEventManager.EventTypes := fEventManager.EventTypes + [dbetGoodsPreOrder];

  IBCAlerter_DBEvents.Start;

  SWNFormsMonitor.OnListChanged := WhenOpenFormsListChanged;
  fInShutdown := false;

  if AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppAutoStart, false) = true then
    AppConfigStorage.BooleanValues.SetValue(cSETTINGS_AppAutoStart, IsWindowsAutoStartEnabled);

  SetupFont;
  dmAdditions.SetupStyleFont;

  LoadEventsPanelPosition;

  // display quick access reports
  if not SWNSecurityManager.IsPartialAccessMode then
    DisplayQuickAccessReports;

  bbResetMainFilter.Enabled := false;

  // support for multiple monitors
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveMonitorPosition) and (Screen.MonitorCount > 1) then
  begin
    tmpMonitor := GetMonitorFromUserOptions;
    if (tmpMonitor <> nil) then
    begin
      Left := tmpMonitor.Left;
      Top := tmpMonitor.Top;
    end;
  end;
  InsertWKInfo;

  winChatWindow := nil;

  dmDB.LoadSipColors;

 // Cream o singura data la pornirea aplicatiei
  frmSchedulerDaemon := TfrmSchedulerDaemon.Create(nil);
  frmSchedulerDaemon.BindStorage;
  frmSchedulerDaemon.Hide;
end;

procedure TfrmMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(winChatWindow) then
  begin
    SaveChatPanelPosition;
    winChatWindow.Free;
  end;

  // if Assigned(frmSipClient) then
  // begin
  // SaveSipPanelPosition;
  // frmSipClient.Free;
  // end;
  // support for multiple monitors
  if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveMonitorPosition) and (Screen.MonitorCount > 1) then
    SaveCurrentMonitorProperties;

  SaveEventsPanelPosition;

  fCurrentFrameDataFilter.Free;

  try
    IBCAlerter_DBEvents.Stop;
  finally
    fEventManager.Free;
    fUpdater.Free;
  end;
  frmSchedulerDaemon.Free;
end;

procedure TfrmMainForm.FormShow(Sender: TObject);
begin
  RunFirstViewThread;
end;

function TfrmMainForm.FrameIndexExistsInTree(const FrameIndex: Integer): TcxTreeListNode;
var
  NodeParent, Node: TcxTreeListNode;
  Data: PDocTypeItem;
begin
  result := nil;
  if cxTreeDocTypes.Count > 0 then
  begin
    NodeParent := cxTreeDocTypes.Items[0];
    while NodeParent <> nil do
    begin
      Node := NodeParent.getFirstChild;
      while Node <> nil do
      begin
        Data := PDocTypeItem(Node.Data);
        if Data^.TabSheetIndex = FrameIndex then
        begin
          result := Node;
          break;
        end;
        Node := Node.getNextSibling;
      end;
      if result <> nil then
        break;
      NodeParent := NodeParent.getNextSibling;
    end;
  end;
end;

procedure TfrmMainForm.frameSipClient1CallBtnClick(Sender: TObject);
begin
  frameSipClient1.CallActionExecute(Sender);
end;

function TfrmMainForm.GetMonitorFromUserOptions: TMonitor;
var
  L, T, W, H: Integer;
  i: Integer;
  mon: TMonitor;
begin
  result := nil;
  L := AppUserConfigStorage.IntValues.GetValue(cSETTINGS_MonitorLeftPos);
  T := AppUserConfigStorage.IntValues.GetValue(cSETTINGS_MonitorTopPos);
  W := AppUserConfigStorage.IntValues.GetValue(cSETTINGS_MonitorWidth);
  H := AppUserConfigStorage.IntValues.GetValue(cSETTINGS_MonitorHeight);
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    mon := Screen.Monitors[i];
    if not mon.Primary and (mon.Left = L) and (mon.Top = T) and (mon.Width = W) and (mon.Height = H) then
    begin
      result := mon;
      break;
    end;
  end;
end;

procedure TfrmMainForm.GotoDocument(const SearchDocumentID: Integer; const Target: TSearchDocumentSearchTarget);
var
  DT, TabIndex, i: Integer;
  docDateTime: TDateTime;
  Props: TcxImageComboBoxProperties;
  Item: TcxImageComboBoxItem;
  firmaFound: Boolean;
  documentFound: Boolean;
  DocID: Integer;
begin
  documentFound := false;
  DocID := SearchDocumentID;
  case Target of
    sdstDoc:
      documentFound := dmDB.GetDocumentGotoInfo(SearchDocumentID, DT, TabIndex, docDateTime);
    sdstInvoice:
      documentFound := dmDB.GetInvoiceGotoInfo(SearchDocumentID, DocID, DT, TabIndex, docDateTime);
    // se cauta dupa InvoiceID, se localizeaza documentul dupa DocID
    sdstContract:
      documentFound := dmDB.GetContractInfo(SearchDocumentID, DT, TabIndex, docDateTime);
    sdstIncident:
      documentFound := dmDB.GetIncidentInfo(SearchDocumentID, DT, TabIndex, docDateTime);
    sdstAWB:
      documentFound := dmDB.GetDocumentGotoInfo(SearchDocumentID, DT, TabIndex, docDateTime);

  end;

  // get document info
  if documentFound then
  begin
    firmaFound := true;
    // Switch to DT, if needed
    if (DT <> fCurrentFrameDataFilter.firmaID) then
    begin
      firmaFound := false;
      Props := TcxImageComboBoxProperties(cmbMainFirms.Properties);
      // check if DT is available
      for i := 0 to Props.Items.Count - 1 do
      begin
        Item := Props.Items[i];
        if Item.Value = DT then
        begin
          firmaFound := true;
          break;
        end;
      end;

      if firmaFound then
      begin
        // schimbam firma
        cmbMainFirms.EditValue := DT;
        // apply changes
        cmbMainFirmsCurChange(cmbMainFirms);
        // aplicam data documentului gasit
        fCurrentFrameDataFilter.DateStart := docDateTime;
        fCurrentFrameDataFilter.DateEnd := docDateTime;
      end
      else
        ShowErrorDialog('Cautare document', 'Documentul cautat este in subdiviziunea in care nu aveti acces!');
    end;

    if firmaFound then
    begin
      if not Assigned(SWNFrameManager.GoToFrameEx(TabIndex, DocID, docDateTime)) then
        ShowErrorDialog('Cautare document', 'Nu este gasit documentul cautat sau nu aveti suficiente drepturi');
    end;
  end
  else
    ShowErrorDialog('Cautare document', 'Eroare! Documentul nu a fost gasit!');
end;

procedure TfrmMainForm.WebSecuritySetup;
begin
  // Web site
  // 1. Catalog Web marfa

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Web_Каталог_товаров) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    bbWebCatalog.Visible := ivNever;
    bbWebSiteRefreshGoods.Visible := ivNever;
    bbWebSearch.Visible := ivNever;
  end;
  // 2. Filtre
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Фильтры) or SWNSecurityManager.IsPartialAccessMode then
    bbWebFilters.Visible := ivNever;
  // 3. Sabloane descriere marfa
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Шаблоны_описания_товаров) or SWNSecurityManager.IsPartialAccessMode
    then
    bbWebDescriptionTemplates.Visible := ivNever;
  // 4. Butoane pentru filtre
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Кнопки_для_фильтров) or SWNSecurityManager.IsPartialAccessMode
    then
    bbFilterButtons.Visible := ivNever;
  // 5. Magazine
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Магазины) or SWNSecurityManager.IsPartialAccessMode then
    bbWebShops.Visible := ivNever;
  // 6. Livrare
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Доставка) or SWNSecurityManager.IsPartialAccessMode then
    bbWebDelivery.Visible := ivNever;
  // 7. Actiuni promo
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Промо_акции) or SWNSecurityManager.IsPartialAccessMode then
  begin
    bbWebActiuni.Visible := ivNever;
    bbWebPromoActiuni.Visible := ivNever;
    bbWebGoodsGroups.Visible := ivNever;
    bbWebUrlManager.Visible := ivNever;
  end;
  // 8. Trimiteri E-mail
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Email_рассылки) or SWNSecurityManager.IsPartialAccessMode
    then
    bbWebMailingLists.Visible := ivNever;
  // Pagini statice pe site
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Статические_страницы_на_сайте) or
    SWNSecurityManager.IsPartialAccessMode then
    bbWebStaticPages.Visible := ivNever;
  // Pachete de produse
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Pachete_de_produse) then
    bbWebPacheteProduse.Visible := ivNever;
  // >> Web-site : daca nu se mai vede nici un element, ascunde meniul principal
  if (bbMainWebSiteMenu.ItemLinks.VisibleItemCount = 0) then
    bbMainWebSiteMenu.Visible := ivNever;
  // Blocare firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Администрирование_Блокировка_фирм) or (SWNSecurityManager.IsPartialAccessMode
    and not SWNSecurityManager.HasPartialAccessModeSecurityConfirmed) then
  begin
    bbLockFirms.Visible := ivNever;
    bbLocksLog.Visible := ivNever;
  end;
    //  Web Access log
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Web_access_log) then
    bbWebAccessLog.Visible := ivNever;

    //  cSecurityFlag_Website_Actualizarea_lista_de_marfa_pe_web
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Actualizarea_lista_de_marfa_pe_web) then
    bbWebSiteRefreshGoods.Visible := ivNever;

    //
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Actualizare_SEO_info_produse) then
    bbSeoActualizareWeb.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Configurare_website) then
    bbWebConfig.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Starea_New_si_Promo_pentru_produse) then
    bbWebGoodsFlags.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Sabloate_de_descriere_a_produselor) then
    bbWebDescriptionTemplates.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Gestionarea_URL_pe_site) then
    bbWebUrlManager.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Catalog_articole_site) then
    bbBlog.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Produse_promotionale_zilnice_pe_web) then
    bbPromoPerDay.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Distributie_content_prin_e_mail) then
    bbWebMailingLists.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Distribuire_content_prin_SMS) then
    bbSMS.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Posturi_vacante) then
    bbJobs.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Website_Search_pe_Web) then
    bbWebSearch.Visible := ivNever;
end;

procedure TfrmMainForm.GotoDocumentFromEvent;
var
  DocID, N: Integer;
  Event: TSWNDBEvent;
  schedulerFrame: TframeScheduler;
begin
  N := cxGridTable.DataController.FocusedRecordIndex;
  Event := fEventManager.GetEventByID(cxGridTable.DataController.Values[N, cxGridTable_EVENTID.index]);

  if Assigned(Event) then
  begin
    if (Event.EventType = dbetSchedulerDelivery) then
    begin
      if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID = 0) then
      begin
        // Scheduler Delivery is currently in view, show it and refresh it
        schedulerFrame := TframeScheduler(SWNFrameManager.CurrentFrame);
        schedulerFrame.ShowDeliveryTab;
        schedulerFrame.RefreshDelivery;
      end
      else
      begin
        schedulerFrame := TframeScheduler(SWNFrameManager.SwitchToFrame(0, nil, 0));
        if Assigned(schedulerFrame) then
        begin
          schedulerFrame.ShowDeliveryTab;
          schedulerFrame.RefreshDelivery;

          // change selection in document tree
          cxTreeDocTypes.BeginUpdate;
          try
            cxTreeDocTypes.Select(cxTreeDocTypes.Items[0]);
            cxTreeDocTypes.FocusedNode := cxTreeDocTypes.Items[0];
          finally
            cxTreeDocTypes.EndUpdate;
          end;
        end;
      end;
    end
    else
    begin
      DocID := cxGridTable.DataController.Values[N, cxGridTable_DOCID.index];
      GotoDocument(DocID, sdstDoc);
    end;
    // mark event as viewed
    cxGridTable.BeginUpdate;
    try
      Event.MarkAsRead;
      cxGridTable.DataController.Values[N, cxGridTable_ISNEW.index] := Event.IsNew;
    finally
      cxGridTable.EndUpdate;
    end;
  end;
end;

procedure TfrmMainForm.HideFilterIndicator;
begin
  bbMainFilter.Style := nil;
  dxStatusBar.Panels[4].PanelStyle.Color := clBtnFace;
  dxStatusBar.Panels[4].Text := '';
  bbResetMainFilter.Enabled := true;
end;

procedure TfrmMainForm.IBCAlerter_CLOSEAPPIMMEDIATEEvent(Sender: TObject; EventName: string; EventCount: Integer);
begin
  if EventName = 'EVENT_DBEVENT' then
    with TDelayThread.Create(500, WhenNeedToScanForEvent) do
      Start
  else if EventName = 'EVENT_CLOSEAPPIMMEDIATE' then
    StartAppShutdown(0)
  else if EventName = 'EVENT_CLOSEAPP20SEC' then
    StartAppShutdown(20)
  else if EventName = 'EVENT_CLOSEAPP60SEC' then
    StartAppShutdown(60)
  else if EventName = 'EVENT_CHAT' then
  begin
    if Assigned(winChatWindow) then
      winChatWindow.UpdateChat;
  end
end;

procedure TfrmMainForm.ImmediateAppShutdown;
begin
  SWNFormsMonitor.CloseAllForms;
  Close;
end;

procedure GetBuildInfo(var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
      begin
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
end;

function GetBuildInfoAsString: string;
var
  V1, V2, V3, V4: word;
begin
  GetBuildInfo(V1, V2, V3, V4);
  result := IntToStr(V1) + '.' + IntToStr(V2) + '.' + IntToStr(V3) + '.' + IntToStr(V4);
end;

procedure TfrmMainForm.CurrencyRateChangeBeforeStart(Sender: TObject);
begin
  dxStatusBar.Panels[5].Text := 'Modificare curs, recalcul preturi...';
  dxStatusBar.Panels[5].PanelStyle.Color := clBtnFace;
  dxStatusBar.Panels[5].PanelStyle.Font.Color := clBlue;
end;

procedure TfrmMainForm.dxStatusBarPanels2DblClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.SQL.Text := 'select RDB$GET_CONTEXT(' + QuotedStr('USER_SESSION') + ', ' + QuotedStr('UserID') +
      ') userid from rdb$database ';
    Query.Open;
    ShowMessage(Query.FieldByName('USERID').AsString);
  finally
    Query.Free;
  end;
end;

procedure TfrmMainForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//   if (ssCtrl in Shift) and (Key = Ord('o')) then
//  begin
//    if GetKeyState(Ord('o')) < 0 then
//    begin
//      ShowMessage('Ctrl + O + O apasate!');
//      Key := 0;
//    end;
//  end;
end;

procedure TfrmMainForm.frameSipClient1HangUpBtnClick(Sender: TObject);
begin
  frameSipClient1.HangUpActionExecute(Sender);
end;

procedure TfrmMainForm.ShowWebPromoGoodsByDay;
var
  dialog: TfrmPromoGoodsByDayDlg;
begin
  dialog := TfrmPromoGoodsByDayDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.InsertWKInfo;
var
  PBuf: LPWKSTA_INFO_100;
  q: TIBCQuery;
  S: string;
  UserName: string;
  DomainName: string;
begin
  q := TIBCQuery.Create(Self);
  q.Transaction := dmDB.IBCTrDefaultUpdate;
  try
    NetWkstaGetInfo(nil, 100, @PBuf);
    GetCurrentUserAndDomain(UserName, DomainName);
    UserName := Trim(UserName);
    DomainName := Trim(DomainName);
    S := 'UserName: ' + dmDB.CurrentUserFullName + ', DomainName: ' + PBuf^.wki100_langroup + ', ComputerName: ' + PBuf^.wki100_computername
      + ' dUserName:[' + UserName + '] new DomainName: [' + DomainName + ']' + ' App Version:[' + GetBuildInfoAsString + ']';

//    if ('FANTASTIC' <> DomainName) and ((dmDB.IBCConnection.Database = '192.168.106.254/3050:SW')
//     {or (dmDB.IBCConnection.Database = '192.168.106.254/3050:SW_OLD')}) then
//    begin
//      if ((dmDB.CurrentUserID <> 204) and (dmDB.CurrentUserID <> 444) // Delia
//        and (dmDB.CurrentUserID <> 612)) and (dmDB.CurrentUserID <> 1) then
//      begin
//        ShowErrorDialog('', 'Error! Computer not authorized');
//        dmdb.sendsms('069127845', 'Logare neuatorizata: ' + S);
//        Application.Terminate;
//      end
//    end
  finally
    q.Free;
  end;
end;

function TfrmMainForm.IsWindowsAutoStartEnabled: Boolean;
var
  Reg: TRegistry;
begin
  result := false;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey(cREGISTRY_KEY_Run, false) then
      result := Reg.ValueExists(cREGISTRY_VALUE_Run) and (Reg.ReadString(cREGISTRY_VALUE_Run) = Application.ExeName);
  finally
    Reg.Free;
  end;
end;

// procedure TfrmMainForm.LoadSipPanelPosition;
// begin
// dxDockPanelSipClient.Visible:=AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_CHAT_Visible, True);
//
// docState:=TdxDockingState(AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_State, Ord(TdxDockingState.dsDocked)));
//
// if (docState=dsFloating) then dxDockPanelChat.MakeFloating
// else
// begin
// docType:=TdxDockingTypeEx(AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Align, Ord(TdxDockingTypeEx.dtRight)));
// docIndex:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_DockIndex, 0);
// dxDockPanelChat.DockTo(dxDockSiteMainContent,docType,docIndex);
// end;
// dxDockPanelChat.Width:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Width, 400);
// pnChatRight.Width:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Splitter, 140);
// end;

// procedure TfrmMainForm.LoadChatPanelPosition;
// begin
// dxDockPanelChat.Visible:=AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_CHAT_Visible, True);
//
// docState:=TdxDockingState(AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_State, Ord(TdxDockingState.dsDocked)));
//
// if (docState=dsFloating) then dxDockPanelChat.MakeFloating
// else
// begin
// docType:=TdxDockingTypeEx(AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Align, Ord(TdxDockingTypeEx.dtRight)));
// docIndex:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_DockIndex, 0);
// dxDockPanelChat.DockTo(dxDockSiteMainContent,docType,docIndex);
// end;
// dxDockPanelChat.Width:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Width, 400);
// pnChatRight.Width:=AppUserConfigStorage.IntValues.GetValue(cSETTINGS_CHAT_Splitter, 140);
// end;

procedure TfrmMainForm.LoadEventsPanelPosition;
begin
//    pnEvents.Width := AppUserConfigStorage.IntValues.GetValue('pnEvents.Width', 630);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('cxSplitterEvents.State'));
end;

procedure TfrmMainForm.LockSystem;
begin
  if ShowAskDialog('Horoscop', 'Astazi va fi o zi frumoasa.' + sLineBreak + 'Doriti sa aflati detalii ?',
    'Nu esti sigur - nu da click!') = mrYes then
  begin
    LockSystemDB;
  end;
end;

function TfrmMainForm.LockSystemDB: Boolean;
var
  Query: TIBCQuery;
begin
  result := false;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE LOCK_SYSTEM(:USERID,:DT,1)';
      // Allow partial access
      Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
      Query.ParamByName('DT').AsInteger := SWNSecurityManager.LoggedUser.DefaultFirma;
      Query.ExecSQL;
      Query.Transaction.Commit;
      result := true;
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

procedure TfrmMainForm.miTransferMoneyToUserClick(Sender: TObject);
begin
  ShowMoneyTransferToUserDialog;
end;

procedure TfrmMainForm.OnRingMessage(var Msg: TMessage);
begin
  frameSipClient1.CallActionExecute(nil);
  frameSipClient1.CallActionUpdate(nil);
end;

procedure TfrmMainForm.PlayAudio_WebZakaz;
begin
  PlayCustomSound(AppUserConfigStorage.TextValues.GetValue(cSOUND_WebZakaz, cSOUND_DefaultAudioTitle));
  dmdb.DoNotification('SWN', 'Web order', 'A fost creat un web order nou.');
end;

procedure TfrmMainForm.PlayAudio_CerereDeFinantare;
begin
  PlayCustomSound(AppUserConfigStorage.TextValues.GetValue(cSOUND_WebZakaz, cSOUND_DefaultAudioTitle));
  dmdb.DoNotification('SWN', 'Web order', 'A fost creata o cerere de finantare!');

end;

procedure TfrmMainForm.PlayAudio_НарядНаСборку;
begin
  PlayCustomSound(AppUserConfigStorage.TextValues.GetValue(cSOUND_НарядНаСборку, cSOUND_DefaultAudioTitle));
end;

procedure TfrmMainForm.PlayAudio_РасходнаяНакладная;
begin
  PlayCustomSound(AppUserConfigStorage.TextValues.GetValue(cSOUND_РасходнаяНакладная, cSOUND_DefaultAudioTitle));
end;

procedure TfrmMainForm.PlayCustomSound(const FileName: string);
var
  SoundFilePathName: string;
begin
  if FileName = cSOUND_DefaultAudioTitle then
    PlaySound(PWideChar(cSOUND_DefaultAudio), 0, SND_ASYNC)
  else
  begin
    SoundFilePathName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + FileName;
    if FileExists(SoundFilePathName) then
      PlaySound(PWideChar(SoundFilePathName), 0, SND_FILENAME + SND_ASYNC)
    else
      PlaySound(PWideChar(cSOUND_DefaultAudio), 0, SND_ASYNC);
  end;
end;

procedure TfrmMainForm.pmPopupMenuEventsPopup(Sender: TObject);
begin
  bbEventGoToDocument.Enabled := cxGridTable.DataController.FocusedRecordIndex >= 0;
  bbEventClearLog.Enabled := cxGridTable.DataController.RecordCount > 0;
end;

procedure TfrmMainForm.PrintReport(const ReportID: Integer; const Title: string);
var
  ReportWin: TfrmPrintEngine;
  fReportParams: TReportParamsList;
begin

  // 2. Run report
  ReportWin := TfrmPrintEngine.Create(Self);
  fReportParams := TReportParamsList.Create;
  try
    // 1. Setup internal params
    SetupReportParams(fReportParams);

    ReportWin.Title := Title;
    // pass params
    ReportWin.ReportParams := fReportParams;
    // execute report
    ReportWin.AddReport(ReportID);
    ReportWin.ShowModal;
  finally
    ReportWin.Free;
    fReportParams.Free;
  end;
end;

procedure TfrmMainForm.RecalcQtyInTransfer;
begin
  if ShowAskDialog('Recalcul bunuri in transfer', 'Doriti sa recalculati cantitatea bunurilor in transfer?',
    'Poate dura citeva minute!') = mrYes then
  begin
    if DoRecalcQtyInTransferDB then
      ShowInfoDialog('Recalcul bunuri in transfer', 'Finisat cu succes.');
  end;
end;

procedure TfrmMainForm.ResetMainFilter;
var
  filterObj: TDocumentDateFilterItem;
  N: Integer;
begin
  filterObj := SWNDocumentFrameDateFilters.GetFilterObject(SWNFrameManager.CurrentFrame.DocumentDefaultFilter);
  try
    // setup default from current frame
    N := bbComboFilterDates.Items.IndexOfObject(filterObj);
    bbComboFilterDates.ItemIndex := N;
  finally
    HideFilterIndicator;
  end;
end;

procedure TfrmMainForm.RunFirstViewThread;
begin
  with TDelayThread.Create(100, WhenFirstView) do
    Start;
end;

procedure TfrmMainForm.SaveChatPanelPosition;
begin

end;

procedure TfrmMainForm.SaveCurrentMonitorProperties;
begin
  AppUserConfigStorage.IntValues.SetValue(cSETTINGS_MonitorLeftPos, Monitor.Left);
  AppUserConfigStorage.IntValues.SetValue(cSETTINGS_MonitorTopPos, Monitor.Top);
  AppUserConfigStorage.IntValues.SetValue(cSETTINGS_MonitorWidth, Monitor.Width);
  AppUserConfigStorage.IntValues.SetValue(cSETTINGS_MonitorHeight, Monitor.Height);
end;

procedure TfrmMainForm.SaveEventsPanelPosition;
begin
  AppUserConfigStorage.IntValues.SetValue('pnEvents.Width', pnEvents.Width);
  AppUserConfigStorage.IntValues.SetValue('cxSplitterEvents.State', Ord(cxSplitterEvents.State));
end;

procedure TfrmMainForm.SecurityInstrumente;
begin
    // Imprimanta fiscala
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Фискальный_принтер) then
    bbService_FiscalPrinter.Visible := ivNever;
    // Import produse din denumiri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Импорт_товаров_из_названий) or
    SWNSecurityManager.IsPartialAccessMode then
    bbImportGoodsByTitles.Visible := ivNever;
    // Transfer bani catre alt utilizator
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Передача_денег_другому_пользователю) or
    SWNSecurityManager.IsPartialAccessMode then
    miTransferMoneyToUser.Visible := ivNever;
    // Transfer bani catre sine
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Трансфер_денег_себе) or SWNSecurityManager.IsPartialAccessMode
    then
    bbMoneyTransfer.Visible := ivNever;
    // Schimb valutar
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Обмен_валюты) or SWNSecurityManager.IsPartialAccessMode
    then
    bbExchangeCurrency.Visible := ivNever;
    // Recalcul stocuri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Перерасчет_остатков) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    bbStockRecalc.Visible := ivNever;
    bbToolsRecalcQtyAcnt.Visible := ivNever;
  end;
    // Sincronizare preturi din alte firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Синхронизация_цен_из_других_фирм) or
    SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPriceSynchronize.Visible := ivNever;
    // Marfuri bonus
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Бонусные_товары) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    bbBonusGoods.Visible := ivNever;
    bbBonusGoods2.Visible := ivNever;
    bbCalcSalesBonus.Visible := ivNever;
  end;

    // Salariu
    // Calcul salariu - instrumente
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ИОЗ_Начисление_зарплаты_инструменты) or
    SWNSecurityManager.IsPartialAccessMode then
    bbNacislenieZarplatiTools.Visible := ivNever;

    // Informatii despre salariu
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ИОЗ_Информация_о_зарплате) or not
    SWNSecurityManager.isAdmin then
    bbSalaryInfo.Visible := ivNever;

    // Planuri de vanzari
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ИОЗ_Планы_продаж) or SWNSecurityManager.IsPartialAccessMode
    then
    bbSalePlans.Visible := ivNever;

    // Realizare...
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Импорт_товаров_из_других_фирм_в_таблицу) or
    SWNSecurityManager.IsPartialAccessMode then
    bbRealizatia.Visible := ivNever;
    // Produse pentru actiunea "Discount la a 2-a achizitie"
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Товары_для_акции_Скидка_на_2ю_покупку) or
    SWNSecurityManager.IsPartialAccessMode then
    bbDiscountGoods.Visible := ivNever;
    // Cautare in registrul documentelor
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Поиск_в_журнале_документов) or
    SWNSecurityManager.IsPartialAccessMode then
    bbSearchDocsLog.Visible := ivNever;
    // Recalcul cantitate in transferuri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Пересчет_колва_в_перемещениях) or
    SWNSecurityManager.IsPartialAccessMode then
    bbToolsRecalcQtyInTransfer.Visible := ivNever;
    // Registru intarzieri angajati
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Журнал_опозданий_работников) or
    SWNSecurityManager.IsPartialAccessMode then
    bbUserMissedHours.Visible := ivNever;
    // Registru amenzi si bonusuri angajati
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Журнал_штрафов_и_бонусов_работников) or
    SWNSecurityManager.IsPartialAccessMode then
    bbUserWorkBonus.Visible := ivNever;
    // Aflare bonus propriu din vanzari
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Узнать_свой_бонус_с_продаж) or
    SWNSecurityManager.IsPartialAccessMode then
    bbCalcSalesBonus.Visible := ivNever;
    // Monitor activitate
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Монитор_активности) or SWNSecurityManager.IsPartialAccessMode
    then
    bbActivityMonitor.Visible := ivNever;
    // Cheltuieli suplimentare
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Дополнительные_расходы) or SWNSecurityManager.IsPartialAccessMode
    then
    bbAddExpenses.Visible := ivNever;
    // Muta iesirile pe azi
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Перенести_документы_на_сегодня) or
    SWNSecurityManager.IsPartialAccessMode then
    bbBringDocsByToday.Visible := ivNever;
    // Analiza preturilor
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Анализ_цен) or SWNSecurityManager.IsPartialAccessMode
    then
    bbCostAnalyze.Visible := ivNever;
    // Analiza preturilor
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Анализ_прайсов) or SWNSecurityManager.IsPartialAccessMode
    then
    bbPriceListAnalyze.Visible := ivNever;
    // Inchidere zi business
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Закрытие_business_дня) or SWNSecurityManager.IsPartialAccessMode
    then
    bbCloseBusinessDay.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_УРП_Управлять) or SWNSecurityManager.IsPartialAccessMode
    then
    bbManageWorkPeriods.Visible := ivNever;

  if bbToolsMainMenu.ItemLinks.VisibleItemCount = 0 then
    bbToolsMainMenu.Visible := ivNever;

  // intretinere , Informatii despre salariu;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INSTRUMENTE_IPDV_Vinzarile_personale) then
    bbPlanVinzari.Visible := ivNever
  else
  begin
    bbPlanVinzari.Visible := ivAlways;
    bbSalaryTools.Visible := ivAlways;
  end;

  if bbSalaryTools.ItemLinks.VisibleItemCount = 0 then
    bbSalaryTools.Visible := ivNever;

end;

procedure TfrmMainForm.SelectFirstItemInDocTypeList;
var
  Node: TcxTreeListNode;
begin
  Node := cxTreeDocTypes.Root.getFirstChild;
  if Assigned(Node) then
  begin
    if Node <> cxTreeDocTypes.FocusedNode then
    begin
      cxTreeDocTypes.SetFocusedNode(Node, []);
      cxTreeDocTypes.Select(Node, []);
    end
    else
      WhenTreeDocTypesFocusedNodeChanged(cxTreeDocTypes, nil, cxTreeDocTypes.FocusedNode);
  end;
end;

procedure TfrmMainForm.SetupFont;
var
  fn: string;
  fs: Integer;
begin
  with cFontSizeItems[AppUserConfigStorage.IntValues.GetValue(cSETTINGS_UserFontSize, cAppDefaultFontIndex)] do
  begin
    fn := FontName;
    fs := FontSize;
  end;

  Font.Name := fn;
  Font.Size := fs;
end;

procedure TfrmMainForm.SetupNomenclatoareRights;
begin
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Analiza_Vinzarilor_Pivot) then
    bbGrupeProduseAnaliza.Visible := ivNever;
end;

procedure TfrmMainForm.SetupReportParams(const ReportParams: TReportParamsList);
var
  Params: TStringList;
  S: string;
  i: Integer;
  CurrFrame: TSWNBaseFrame;
begin
  // setup here general params
  ReportParams.SetParamValue('FIRMAID', dmDB.CurrentFirma);
  ReportParams.SetParamValue('FIRMA_NAME', dmDB.CurrentFirmaName);
  ReportParams.SetParamValue('USERID', dmDB.CurrentUserID);
  ReportParams.SetParamValue('USER_NAME', dmDB.CurrentUserFullName);
  ReportParams.SetParamValue('USER_POSITION', SWNSecurityManager.LoggedUser.OcupiedPosition);

  // params from current document
  if dmDB.IBCQueryDocs.Active then
  begin
    // DT
    ReportParams.SetParamValue('DT', dmDB.IBCQueryDocs.FieldByName('DT').AsInteger);
    ReportParams.SetParamValue('DT_NAME', dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString);
    // CT
    ReportParams.SetParamValue('CT', dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
    ReportParams.SetParamValue('CT_NAME', dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString);

    ReportParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    ReportParams.SetParamValue('DOCTYPEID', dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger);
    ReportParams.SetParamValue('DOCTYPE_NAME', dmDB.IBCQueryDocs.FieldByName('DOCTYPE_NAME').AsString);
  end;

  // params from current open frame
  Params := TStringList.Create;
  try
    CurrFrame := SWNFrameManager.CurrentFrame;
    if Assigned(CurrFrame) then
    begin
      CurrFrame.GetParamsListForReport(Params);
      for i := 0 to Params.Count - 1 do
      begin
        S := Params[i];
        ReportParams.SetParamValue(S, CurrFrame.GetParamValueForReport(S));
      end;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmMainForm.SetupSecurityItems;
var
  Allow: Boolean;
begin

  if SWNSecurityManager.IsLimitedUser then
  begin
    frameSipClient1.Visible := false;
    bdcSIP.Visible := false;
    bbQuickLinks.Visible := ivNever;
    bbSearchTools.Visible := ivNever;
    bbUM.Visible := ivNever;
    bdcSIP.Visible := false;
    bbMainWebSiteMenu.Visible := ivNever;
    dxBarManagerMainBar2.Visible := false;
    bbMainMenuSys_Settings.Visible := ivNever;
    pnClientFooter.Visible := false;
    bbMainFilter.Visible := ivNever;
    bbPriceRules.Visible := ivNever;

    bbGrupeProduseAnaliza.Visible := ivNever;
    bbPreturiSubItem.Visible := ivNever;
    bbAnaliticaSubItem.Visible := ivNever;
    bbMainMenuRef_GoodsType.Visible := ivNever;
    bbBrands.Visible := ivNever;
    bbCrediteRetail.Visible := ivNever;
    bbTipCredite.Visible := ivNever;
  end;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Analiza) then
    bbAnaliza.Visible := ivNever;

  // Produse
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары) then
    bbMainMenuRef_Goods.Visible := ivNever;

  // Contraagenti
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Клиенты) then
  begin
    bbMainMenuRef_Customers.Visible := ivNever;
    bbMainMenuRef_Enterprises.Visible := ivNever;
  end;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbMainMenuRef_Enterprises.Visible := ivNever;
  end;

  // Denumiri pentru nakladnie
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Наименование_для_накладных) or
    SWNSecurityManager.IsPartialAccessMode then
    bbMainMenuRef_GoodsACNT.Visible := ivNever;

  // SYSS
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Системный_справочник) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    bbSYSS.Visible := ivNever;
    bbMainMenuRef_GoodsType.Visible := ivNever;
  end;

  // Tipuri de contracte
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Типы_контрактов) or SWNSecurityManager.IsPartialAccessMode
    then
    bbDocContractTypes.Visible := ivNever;

  // Depozite
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Склады) or SWNSecurityManager.IsPartialAccessMode then
    bbMainMenuRef_Stocks.Visible := ivNever;

  // Valuta
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Валюта) or SWNSecurityManager.IsPartialAccessMode then
    bbMainMenuRef_Currency.Visible := ivNever;

  // BANCI
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Банки) or SWNSecurityManager.IsPartialAccessMode then
    bbMainMenuRef_Banks.Visible := ivNever;

  // Analitica
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Аналитика) or SWNSecurityManager.IsPartialAccessMode
    then
    bbMainMenuAcs_Analytics.Visible := ivNever;

  // Procuri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Доверенности) then
    bbProcuri.Visible := ivNever;

  // Certificate
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Сертификаты) then
    bbRefCertifications.Visible := ivNever;

  // Sabloane configuratii
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Шаблоны_конфигураций) or SWNSecurityManager.IsPartialAccessMode
    then
    bbKitTemplates.Visible := ivNever;

  //Branduri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Branduri) then
    bbBrands.Visible := ivNever;

  // daca nu mai sint elemente visibile, ascunde meniul principal
  if bbMainMenuDictionaries.ItemLinks.VisibleItemCount = 0 then
    bbMainMenuDictionaries.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Информация_о_зарплате) then
    bbSalaryTools.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Печать) then
    bbMainMenuPrint.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_1C_Бухгалтерия) then
    bbMainMenu1C.Visible := ivNever;

  // Utilizatori
  if not SWNSecurityManager.IsSuperUser then
  begin
    bbActiveUsers.Visible := ivNever;
    // >> credentialele API-urilor externe
    bbApiConfig.Visible := ivNever;
    // >> SQL Repository
    bbSQLRepository.Visible := ivNever;
    // >> Nomenclatoare - Service+
    bbServicePlusRefs.Visible := ivNever;
    // >> Instrumente - Marfa noua
//        bbNewGoods.Visible := ivNever;
  end;

  // >> Instrumente - Recalcul stocuri
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_Перерасчет_остатков) then
  begin
    bbStockRecalc.Visible := ivNever;
    bbToolsRecalcQtyInTransfer.Visible := ivNever;
    bbToolsRecalcQtyAcnt.Visible := ivNever;
  end;

  // >> Setari, daca nu mai sint elemente visibile, ascunde meniul principal
  if bbAdminAccess.ItemLinks.VisibleItemCount = 0 then
    bbAdminAccess.Visible := ivNever;

  WebSecuritySetup;

  if not SWNSecurityManager.isAdmin then
  begin
    // Creare versiune noua a programului...
    bbCreateAppNewVersion.Visible := ivNever;
    // >> lista utilizatorilor activi
    bbMainMenuAcs_Users.Visible := ivNever;
    // Grupuri de utilizatori
    bbMainMenuAcs_UserGroups.Visible := ivNever;
    // Tipuri de documente
    bbMainMenuAcs_DocTypes.Visible := ivNever;
    // >> Setari - Oprirea bazei in 20 secunde
    bbStopDatabase1Min.Visible := ivNever;
  end;

  SetupNomenclatoareRights;
  // >> Setari : daca nu se mai vede nici un element, ascundem meniul principal
  if bbAdminAccess.ItemLinks.VisibleItemCount = 0 then
    bbAdminAccess.Visible := ivNever;

  // >> Instrumente : daca nu se mai vede nici un element, ascundem meniul principal
  if bbToolsMainMenu.ItemLinks.VisibleItemCount = 0 then
    bbToolsMainMenu.Visible := ivNever;

  SecurityInstrumente;
  // Jurnale
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_RB_Registru_comun_bancar) then
  begin
    bbRegistrulBancar.Visible := ivNever;
  end;
  // Cautare
  Allow := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_Счет_фактуры) or SWNSecurityManager.UserHasSecurityFlag
    (cSecurityFlag_СЧЕТА_Счета_на_оплату);
  // Cautare Factura de plata
  if not Allow then
    bbSearchScetOplata.Visible := ivNever;
  // Cautare Nakladnaia Fiscala
  if not Allow then
    bbSearchSciotFactura.Visible := ivNever;

  if bbSearchTools.ItemLinks.VisibleItemCount = 0 then
    bbSearchTools.Visible := ivNever;

  if bbBonusTools.ItemLinks.VisibleItemCount = 0 then
    bbBonusTools.Visible := ivNever;

  // 1C Contabilitate
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_1C_Экспорт_документов) or SWNSecurityManager.IsPartialAccessMode
    then
    bbExportTo1C.Visible := ivNever;

  if bbMainMenu1C.ItemLinks.VisibleItemCount <= 0 then
    bbMainMenu1C.Visible := ivNever;

  // 1C Contabilitate
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INSTRUMENTE_Sip_Log) or SWNSecurityManager.IsPartialAccessMode then
    bbSipLog.Visible := ivNever;

  // Politica de formare a preturilor
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Politica_de_preturi) then
  begin
    bbPriceRules.Visible := ivNever;
    bbRecalcPreturi.Visible := ivNever;
  end;

  // Clientbank ECB export/Import;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_1Б_CB_ECB) then
    bbECB.Visible := ivNever;
    // Reevaluarea (Alt + E)
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PL_Reevaluarea_bunurilor) then
    bbReevaluare.Visible := ivNever;



  // este content user si poate lucra remote
  if SWNSecurityManager.IsLimitedUser then
  begin
    bbCredite.Visible := ivNever;
    bbBugete.Visible := ivNever;
    bbMainMenuRef_Customers.Visible := ivNever;
    bbMainMenuRef_Enterprises.Visible := ivNever;
    bbMCC.Visible := ivNever;
    bbWorkStations.Visible := ivNever;
    bbAutoTransport.Visible := ivNever;
    bbSYSS.Visible := ivNever;
    bbRegistrulBancar.Visible := ivNever;
    bbCreateNewVersion.Visible := ivNever;
    bbFindDocByID.Visible := ivNever;
    bbToolsMainMenu.Visible := ivNever;
    bbQuickLinks.Visible := ivNever;
    bbSearchTools.Visible := ivNever;
    bbMainMenuDocument.Visible := ivNever;
    bbWebGoodsFlags.Visible := ivNever;
    bbWebUrlManager.Visible := ivNever;
    bbWebGoodsGroups.Visible := ivNever;
    bbWebShops.Visible := ivNever;
    bbWebDelivery.Visible := ivNever;
    bbWebPromoActiuni.Visible := ivNever;
    bbWebStaticPages.Visible := ivNever;
    bbWebPacheteProduse.Visible := ivNever;
    bbPromoPerDay.Visible := ivNever;
    bbWebMailingLists.Visible := ivNever;
    bbSMS.Visible := ivNever;
    frameSipClient1.Visible := false;
    bbWebAccessLog.Visible := ivNever;
    bbRecalcPreturi.Visible := ivNever;
    bbReevaluare.Visible := ivNever;
    bbCrediteRetail.Visible := ivNever;
    bbTipCredite.Visible := ivNever;
  end;

  // DB is partial locked
  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbECB.Visible := ivNever;
    bbQuickAccessReports.Visible := ivNever;
    bbLockSystem.Visible := ivNever;
    bbCheckForUpdates.Visible := ivNever;
    bbCreateAppNewVersion.Visible := ivNever;
    bbNewGoods.Visible := ivNever;
    bbShortcut_WebZakaz.Visible := ivNever;
    // bbFindDocByID.Visible := ivNever;
    bbPrint_PriceList.Visible := ivNever;
    bbPriceRules.Visible := ivNever;
    bbPlanVinzari.Visible := ivNever;
    bbWebAccessLog.Visible := ivNever;
    bbReevaluare.Visible := ivNever;
    bbCrediteRetail.Visible := ivNever;
    bbTipCredite.Visible := ivNever;
  end;

end;

procedure TfrmMainForm.SetWindowsAutoStart(const AutoStart, oldAutoStart: Boolean);
var
  Reg: TRegistry;
begin
  if (not AutoStart) and (oldAutoStart) then
  begin
    // remove Autostart key
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey(cREGISTRY_KEY_Run, false) then
      begin
        if Reg.ValueExists(cREGISTRY_VALUE_Run) then
          Reg.DeleteValue(cREGISTRY_VALUE_Run);
      end;
    finally
      Reg.Free;
    end;
  end
  else if AutoStart then
  begin
    // add Autostart key
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey(cREGISTRY_KEY_Run, false) then
      begin
        Reg.WriteString(cREGISTRY_VALUE_Run, Application.ExeName);
      end;
    finally
      Reg.Free;
    end;
  end;
end;

procedure TfrmMainForm.ShowAboutDialog;
var
  dialog: TfrmAboutDlg;
begin
  dialog := TfrmAboutDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowActiveUsersDialog;
var
  dialog: TfrmActiveUsersDlg;
begin
  dialog := TfrmActiveUsersDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowActivityMonitorDialog;
var
  dialog: TfrmUserActivityMonitorDlg;
begin
  if (dmDB.CurrentUserID = 1) then
  begin
    dialog := TfrmUserActivityMonitorDlg.Create(Self);
    try
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmMainForm.ShowAddExpensesDialog;
var
  dialog: TfrmExpensesDlg;
begin
  dialog := TfrmExpensesDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowAppSettingsDialog;
var
  dialog: TfrmAppSettingsDialog;
  old_AutoStart, new_AutoStart: Boolean;
begin
  dialog := TfrmAppSettingsDialog.Create(Self);
  try
    old_AutoStart := AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppAutoStart, false);

    if dialog.ShowModal = mrOk then
    begin
      new_AutoStart := AppConfigStorage.BooleanValues.GetValue(cSETTINGS_AppAutoStart, false);
      SetWindowsAutoStart(new_AutoStart, old_AutoStart);
    end;

  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowCustomersEditor;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.BrowseCustomers(-1);
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowBanksEditor;
var
  bankEditor: TfrmBanksBrowserDlg;
begin
  bankEditor := TfrmBanksBrowserDlg.Create(Self);
  try
    bankEditor.BrowseBanks;
  finally
    bankEditor.Free;
  end;
end;

procedure TfrmMainForm.ShowBonusGoods2Dialog;
var
  dialog: TfrmBonusGoods2Dlg;
begin
  dialog := TfrmBonusGoods2Dlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowBonusGoodsDialog;
var
  dialog: TfrmBonusGoodsDlg;
begin
  dialog := TfrmBonusGoodsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowBugetDialog;
var
  dialog: TfrmBugetDlg;
begin
  dialog := TfrmBugetDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free
  end;
end;

procedure TfrmMainForm.ShowCalcSalesBonusDialog;
var
  dialog: TfrmCalcSalesBonusDlg;
begin
  dialog := TfrmCalcSalesBonusDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowCertificationsDialog;
var
  dialog: TfrmCertificationsDlg;
begin
  dialog := TfrmCertificationsDlg.Create(Self);
  try
    dialog.ManageCertificates;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowClientBankECB;
begin
end;

procedure TfrmMainForm.ShowCloseBusinessDayDialog;
var
  dialog: TfrmCloseBusinessDayDlg;
begin
  dialog := TfrmCloseBusinessDayDlg.Create(Self);
  try
    dialog.OnOpenDocument := GotoDocument;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowComparePricesDialog;
begin

end;

procedure TfrmMainForm.ShowContextMainFilterDialog;
var
  ContextValues: TSearchContextValue;
  filterDlg: TfrmFilterDialog;
  tmpDataFilters: TFrameDataFilteringInfo;
begin
  // get context type and value from current frame
  ContextValues := SWNFrameManager.CurrentFrame.GetCurrentSearchContext;
  if ContextValues.Context = ffNone then
    exit;

  // cream un data filtru temporar
  tmpDataFilters := TFrameDataFilteringInfo.Create;
  try
    // si luam Firma si Tipul documentului curent
    tmpDataFilters.firmaID := fCurrentFrameDataFilter.firmaID;
    tmpDataFilters.DocTypeID := fCurrentFrameDataFilter.DocTypeID;
    // setam valorile de cautare din context
    if (ContextValues.Context = ffDate) then
    begin
      tmpDataFilters.DateStart := ContextValues.ValueDateTime;
      tmpDataFilters.DateEnd := ContextValues.ValueDateTime;
    end;
    if (ContextValues.Context = ffCustomer) then
    begin
      tmpDataFilters.CustomerID := ContextValues.ValueInt;
      tmpDataFilters.CustomerText := ContextValues.ValueStr;
    end;
    if (ContextValues.Context = ffGoods) then
    begin
      tmpDataFilters.GoodsID := ContextValues.ValueInt;
      tmpDataFilters.GoodsText := ContextValues.ValueStr;
    end;
    if (ContextValues.Context = ffGoodsSN) then
      tmpDataFilters.GoodsSN := ContextValues.ValueStr;
    if (ContextValues.Context = ffStock) then
      tmpDataFilters.StockID := ContextValues.ValueInt;

    // show search dialog with new context values
    filterDlg := TfrmFilterDialog.Create(Self, dmDB.IBCConnection);
    try
      // setam dupa care indicatori se poate de cautat
      // setam indicatorii curenti de filtrare
      filterDlg.SetupFilters(fCurrentFrameFilterFields, tmpDataFilters);
      filterDlg.btnClearFilter.Visible := bbComboFilterDates.ItemIndex = -1;
      // show dialog
      case filterDlg.ShowModal of
        mrOk:
          begin
            // copy filter values
            tmpDataFilters.CopyFiltersTo(fCurrentFrameDataFilter);

            // no current filter by date
            bbComboFilterDates.Tag := 1;
            bbComboFilterDates.ItemIndex := -1;
            bbComboFilterDates.Tag := 0;

            // show Filter indicator
            ShowFilterIndicator;

            SWNFrameManager.FrameDataFilterChanged(fCurrentFrameDataFilter);
          end;
        mrAbort:
          begin
            // button: "Fara filtru"
            ResetMainFilter;
          end;
      end;
    finally
      filterDlg.Free;
    end;
  finally
    tmpDataFilters.Free;
  end;
end;

procedure TfrmMainForm.ShowContractsTypeDialog;
var
  dialog: TfrmContractTypeDlg;
begin
  dialog := TfrmContractTypeDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowCreateNewAppVersionDialog;
var
  dialog: TfrmCreateAppNewversionDlg;
begin
  dialog := TfrmCreateAppNewversionDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowCreditRetailDlg;
var
  d: TfrmCrediteRetailDlg;
begin
  d := TfrmCrediteRetailDlg.Create(self, dmdb.IBCConnection);
  try
    d.ShowModal;
  finally
    d.Free;
  end;
end;

procedure TfrmMainForm.ShowDiscountGoodsDialog;
var
  dialog: TfrmDiscountGoodsDlg;
begin
  dialog := TfrmDiscountGoodsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowDocTypesDialog;
var
  docTypes: TfrmDocTypesEditorDlg;
begin
  docTypes := TfrmDocTypesEditorDlg.Create(dmDB.IBCConnection);
  try
    docTypes.EditDocTypes;
  finally
    docTypes.Free;
  end;
end;

procedure TfrmMainForm.ShowCurrencyEditor;
var
  currEditor: TfrmCurrencyDialog;
//  aTask: ITask;
  myThread: TCurrencyRateChangeThread;
begin
  currEditor := TfrmCurrencyDialog.Create(dmDB.IBCConnection);
  try
    currEditor.readonly := not SWNSecurityManager.LoggedUser.IsInAdminGroup;
    if currEditor.ShowModal = mrOk then
    begin
      if currEditor.IsCurrencyRateChanged then
      begin
        // TThread
        myThread := TCurrencyRateChangeThread.Create(true);
        myThread.Priority := tpNormal;
        myThread.FreeOnTerminate := true;
        myThread.OnBeforeStart := (
          procedure
          begin
            dxStatusBar.Panels[5].Text := 'Modificare curs, recalcul preturi...';
            dxStatusBar.Panels[5].PanelStyle.Color := clBtnFace;
            dxStatusBar.Panels[5].PanelStyle.Font.Color := clBlue;
          end);

        myThread.OnSuccesFinished := (
          procedure
          begin
            dxStatusBar.Panels[5].Text := 'Schimb curs valutar. Finisat cu succes...';
            dxStatusBar.Panels[5].PanelStyle.Color := clBtnFace;
            dxStatusBar.Panels[5].PanelStyle.Font.Color := clBlue;
//            sleep(3000);
//            dxStatusBar.Panels[5].Text := '';
          end);

        myThread.Start;
      end;
    end;
  finally
    currEditor.Free;
  end;
end;

procedure TfrmMainForm.ShowCurrencyExchangeDialog;
var
  dialog: TfrmCurrencyExchangeDlg;
begin
  dialog := TfrmCurrencyExchangeDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowDocumentsTree(const StructureID: Integer);

  function GetDocumentTreeItemByDocTypeID(const DocTypeID: Integer): TcxTreeListNode;
  var
    Node: TcxTreeListNode;
    Data: PDocTypeItem;
  begin
    result := nil;
    if cxTreeDocTypes.Count > 0 then
    begin
      Node := cxTreeDocTypes.Root.getFirstChild;
      while Node <> nil do
      begin
        Data := Node.Data;
        if Data^.DocTypeID = DocTypeID then
        begin
          result := Node;
          break;
        end;
        Node := Node.getNextSibling;
      end;
    end;
  end;

var
  NodeScheduler, Node0, Node1: TcxTreeListNode;
  Data0, Data1: PDocTypeItem;
  LastFolderID: Integer;
  ParentDocTypeID: Integer;
  DocTypeID: Integer;
  Query: TIBCQuery;
  ShowDocType: Boolean;
begin
  ShowDocType := SWNSecurityManager.LoggedUser.IsSuperAdminUser;

  cxTreeDocTypes.BeginUpdate;
  try
    cxTreeDocTypes.SetFocusedNode(nil, []);
    cxTreeDocTypes.Select(nil, []);
    cxTreeDocTypes.Clear;

    // create default folder for Scheduler
    NodeScheduler := cxTreeDocTypes.AddChild(nil);
    NodeScheduler.Texts[0] := 'EVENIMENTE';
    New(Data0);
    Data0^.DocTypeID := -1;
    Data0^.TabSheetIndex := 0;
    NodeScheduler.Data := Data0;
    NodeScheduler.ImageIndex := 2;
    NodeScheduler.SelectedIndex := 2;
    Data0^.isFolder := true;

    cxTreeDocTypes.SetFocusedNode(NodeScheduler, []);

    Node0 := nil;
    LastFolderID := -1;

    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text := 'SELECT * FROM GET_DOCTYPES_BY_USER_NEW(:StructureID,:UserID)';
      Query.ParamByName('StructureID').AsInteger := StructureID;
      Query.ParamByName('UserID').AsInteger := dmDB.CurrentUserID;
      Query.ExecSQL;
      while not Query.Eof do
      begin
        ParentDocTypeID := Query.FieldByName('PARENT_DOCTYPEID').AsInteger;
        DocTypeID := Query.FieldByName('DOCTYPEID').AsInteger;

        if ParentDocTypeID <> LastFolderID then
        begin
          // add group
          Node0 := cxTreeDocTypes.Add;
          Node0.Texts[0] := Query.FieldByName('PARENT_TITLE').AsString;
          New(Data0);
          Data0^.DocTypeID := ParentDocTypeID;
          Data0^.TabSheetIndex := -1;
          // IBCQueryTemp.FieldByName('TABSHEETINDEX').AsInteger;
          Data0^.isFolder := true;
          Node0.Data := Data0;
          Node0.ImageIndex := Query.FieldByName('PARENT_IMAGEINDEX').AsInteger;
          Node0.SelectedIndex := Node0.ImageIndex;
          LastFolderID := ParentDocTypeID;
        end;

        Node1 := cxTreeDocTypes.AddChild(Node0);
        New(Data1);
        Data1^.DocTypeID := DocTypeID;
        Data1^.TabSheetIndex := Query.FieldByName('TABSHEETINDEX').AsInteger;
        Data1^.isFolder := false;
//                if ShowDocType then
        Node1.Texts[0] := Format('%d [%d] %s', [DocTypeID, Data1^.TabSheetIndex, Query.FieldByName('TITLE').AsString]);
//                else
//                    Node1.Texts[0] := Format('%d[%d] %s', [DocTypeID, Data1^.TabSheetIndex, Query.FieldByName('TITLE').AsString]);
        Node1.Data := Data1;
        Node1.ImageIndex := Query.FieldByName('IMAGEINDEX').AsInteger;
        Node1.SelectedIndex := Node1.ImageIndex;
        Node0.Expanded := true;

        Query.Next;
      end;
    finally
      Query.Free;
    end;

    // delete empty folders
    Node0 := NodeScheduler.getNextSibling;
    while (Node0 <> nil) do
    begin
      Data0 := Node0.Data;
      if Data0^.isFolder and not Node0.HasChildren then
      begin
        // delete folder
        Node1 := Node0.getPrevSibling;
        Node0.Delete;
        Node0 := Node1;
      end;
      Node0 := Node0.getNextSibling;
    end;

  finally
    cxTreeDocTypes.EndUpdate;
  end;
end;

procedure TfrmMainForm.ShowDocumentTypeAnalyticsDialog;
var
  dialog: TfrmAnalyticsDlg;
begin
  dialog := TfrmAnalyticsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowExportTo1CDialog;
var
  dialog: TfrmExportTo1CDlg;
begin
  dialog := TfrmExportTo1CDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowFilterIndicator;
begin
  bbMainFilter.Style := dmAdditions.cxStyle_FilterButton;
  dxStatusBar.Panels[4].PanelStyle.Color := clRed;
  dxStatusBar.Panels[4].Text := 'Filtru Activ';
  bbResetMainFilter.Enabled := true;
end;

procedure TfrmMainForm.ShowFirmsEditor;
var
  custEditor: TfrmCustomersDlg;
begin
  custEditor := TfrmCustomersDlg.Create(Self);
  try
    custEditor.CustomFilter := [cfFirms];
    custEditor.BrowseCustomers(-1, 0, 'Organizatii');
  finally
    custEditor.Free;
  end;
end;

procedure TfrmMainForm.ShowGoodsAcntEditor;
var
  goodsACNT: TfrmGoodsACNTDlg;
begin
  goodsACNT := TfrmGoodsACNTDlg.Create(Self);
  try
    goodsACNT.BrowseGoodsACNT;
  finally
    goodsACNT.Free;
  end;
end;

procedure TfrmMainForm.ShowGoodsEditor;
var
  goodsEditor: TfrmGoodsBrowser;
begin
  goodsEditor := TfrmGoodsBrowser.Create(Self);
  try
    goodsEditor.BrowseGoods(-1);
  finally
    goodsEditor.Free;
  end;
end;

procedure TfrmMainForm.ShowGoodsPriceSynchronizeDialog;
var
  dialog: TfrmPriceSynchronizeDlg;
begin
  dialog := TfrmPriceSynchronizeDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowGoodsCategoryEditor;
var
  editor: TfrmGoodsTypeDlg;
begin
  editor := TfrmGoodsTypeDlg.Create(Self);
  try
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure TfrmMainForm.ShowImportForeighGoodsIntoTableDialog;
var
  dialog: TfrmImportForeignGoodsIntoTableDlg;
begin
  dialog := TfrmImportForeignGoodsIntoTableDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowImportGoodsFromTitlesDialog;
var
  dialog: TfrmImportGoodsByTitlesDlg;
begin
  dialog := TfrmImportGoodsByTitlesDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;

end;

procedure TfrmMainForm.ShowKitTemplatesDialog;
var
  KitTemplate: TfrmKitTemplatesDlg;
begin
  KitTemplate := TfrmKitTemplatesDlg.Create(Self, dmDB.IBCConnection);
  try
    KitTemplate.SelectMode := false;
    KitTemplate.ShowModal;
  finally
    KitTemplate.Free;
  end;
end;

procedure TfrmMainForm.ShowLockFirmsDialog;
var
  dialog: TfrmLockFirmsDlg;
begin
  dialog := TfrmLockFirmsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowMainFilterDialog;
var
  filterDlg: TfrmFilterDialog;
begin
  filterDlg := TfrmFilterDialog.Create(Self, dmDB.IBCConnection);
  try
    // setam dupa care indicatori se poate de cautat
    // setam indicatorii curenti de filtrare
    filterDlg.SetupFilters(fCurrentFrameFilterFields, fCurrentFrameDataFilter);
    filterDlg.btnClearFilter.Visible := bbComboFilterDates.ItemIndex = -1;
    // show dialog
    case filterDlg.ShowModal of
      mrOk:
        begin
          // set filter
          // dmDB.SetCustomFilter(FilterOptions, SWNFrameManager.CurrentFrame.DocumentSource=fdsNone);
          // no current filter by date
          bbComboFilterDates.Tag := 1;
          bbComboFilterDates.ItemIndex := -1;
          bbComboFilterDates.Tag := 0;

          // show Filter indicator
          ShowFilterIndicator;

          SWNFrameManager.FrameDataFilterChanged(fCurrentFrameDataFilter);
        end;
      mrAbort:
        begin
          // button: "Fara filtru"
          ResetMainFilter;
        end;
    end;
  finally
    filterDlg.Free;
  end;
end;

procedure TfrmMainForm.ShowMoneyTransferDialog;
var
  dialog: TfrmMoneyTransferDlg;
begin
  dialog := TfrmMoneyTransferDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowMoneyTransferToUserDialog;
var
  dialog: TfrmMoneyTransferToUserDlg;
begin
  dialog := TfrmMoneyTransferToUserDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      // update frame "CASA - Casa personala (12)", if visible
      if SWNFrameManager.CurrentFrame is Tframe12CassaPersonal then
      begin
        Tframe12CassaPersonal(SWNFrameManager.CurrentFrame).RefreshInfo;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowNacislenieZarplatiToolsDialog;
var
  dialog: TfrmNacislenieZarplatiToolsDlg;
begin
  dialog := TfrmNacislenieZarplatiToolsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowNewGoodsDialog;
var
  dialog: TfrmToolsNewGoodsDlg;
begin
  dialog := TfrmToolsNewGoodsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowPrintDocumentsDialog(const PrintDocType: Integer; const ReportGroup: Integer);
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, PrintDocType);
  try
    printWizard.ShowReportsFromGroupOnly(ReportGroup);
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
    if printWizard.QuickAccessReportsChanged then
      DisplayQuickAccessReports;
  finally
    printWizard.Free;
  end;
end;

procedure TfrmMainForm.ShowProcuriDialog;
var
  dialog: TfrmProcuriBrowserDlg;
begin
  dialog := TfrmProcuriBrowserDlg.Create(Self);
  try
    dialog.AllowSelect := false;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSalaryInfoDialog;
var
  dialog: TfrmSalaryInfoDlg;
begin
  dialog := TfrmSalaryInfoDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSalePlansDialog;
var
  dialog: TfrmSalePlansDlg;
begin
  dialog := TfrmSalePlansDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSearchDocumentByID2Dialog;
var
  dialog: TfrmSearchDocumentById2Dlg;
  resultInfo: TSearchDocumentResultInfo;
begin
  dialog := TfrmSearchDocumentById2Dlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      resultInfo := dialog.GetSearchResult;
      if (resultInfo.Doctype <> sdstNONE) then
        GotoDocument(resultInfo.ID, resultInfo.Doctype);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSearchInDocsLogDialog;
var
  dialog: TfrmSearchInDocsLog2Dlg;
begin
  dialog := TfrmSearchInDocsLog2Dlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSearchSciotFacturaDialog;
var
  dialog: TfrmSearchSciotFacturaDlg;
begin
  dialog := TfrmSearchSciotFacturaDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
      SWNFrameManager.GoToFrameEx(25, dialog.GotoDocID, dialog.GotoDocDate);
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowServicePlusRepairAimsDialog;
var
  dialog: TfrmServiceRefRepairAimsDlg;
begin
  dialog := TfrmServiceRefRepairAimsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowServiceFiscalPrinter;
begin
  if (dmDB.CurrentFirma = 307225) then  // PRIME STORE
  begin
    var dialog := TfrmFiscalPrinterServiceV2Dlg.Create(Self);
    try
    // setup printer info
      dialog.PrinterPort := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterComPort,
        cFISCAL_PRINTER_DefaultCOMport);
      dialog.PrinterBoundRate := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterBoundRate,
        cFISCAL_PRINTER_DefaultBoundRate);
      dialog.ShowModal;
      if dialog.PrinterExists then
      begin
        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterComPort, dialog.PrinterPort);
        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterBoundRate, dialog.PrinterBoundRate);
      end;
    finally
      dialog.Free;
    end;
  end
  else
  begin
    var dialog := TfrmFiscalPrinterServiceV1Dlg.Create(Self);
    try
    // setup printer info
      dialog.PrinterPort := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterComPort,
        cFISCAL_PRINTER_DefaultCOMport);
      dialog.PrinterBoundRate := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterBoundRate,
        cFISCAL_PRINTER_DefaultBoundRate);
      dialog.ShowModal;
      if dialog.PrinterExists then
      begin
        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterComPort, dialog.PrinterPort);
        AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterBoundRate, dialog.PrinterBoundRate);
      end;
    finally
      dialog.Free;
    end;

  end;
end;

procedure TfrmMainForm.ShowService_TaskTypesDialog;
var
  dialog: TfrmServiceRefTaskTypesDlg;
begin
  dialog := TfrmServiceRefTaskTypesDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowSqlRepositoryDialog;
var
  dialog: TfrmSqlRepositoryWin;
begin
  dialog := TfrmSqlRepositoryWin.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowStocksEditor;
var
  stocks: TfrmStocksBrowserDlg;
begin
  stocks := TfrmStocksBrowserDlg.Create(Self);
  try
    stocks.BrowseStock;
  finally
    stocks.Free;
  end;
end;

procedure TfrmMainForm.ShowSYSSEditor(const ParentID: Integer);
var
  syssEditor: TfrmSelectSyssEditorWin;
begin
  syssEditor := TfrmSelectSyssEditorWin.Create(Self);
  try
    if ParentID <> -1 then
      syssEditor.SetDefaultGroup(ParentID);
    syssEditor.ShowModal;
  finally
    syssEditor.Free;
  end;
end;

procedure TfrmMainForm.ShowSystemLocksLogDialog;
var
  dialog: TfrmFirmsLocksLogDlg;
begin
  dialog := TfrmFirmsLocksLogDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowUserMissedHoursDialog;
var
  dialog: TfrmUserMissedHoursDlg;
begin
  dialog := TfrmUserMissedHoursDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowUserWorkBonusDialog;
var
  dialog: TfrmUserWorkBonusDlg;
begin
  dialog := TfrmUserWorkBonusDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebCatalogDialog;
var
  dialog: TfrmWebCatalogDlg;
begin
  dialog := TfrmWebCatalogDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebDeliveryDialog;
var
  dialog: TfrmWebDeliveryDlg;
begin
  dialog := TfrmWebDeliveryDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebDescriptionTemplatesDialog;
var
  dialog: TfrmWebDescriptionTemplateDlg;
begin
  dialog := TfrmWebDescriptionTemplateDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebFilterButtonsDialog;
var
  dialog: TfrmWebFilterButtonsDlg;
begin
  dialog := TfrmWebFilterButtonsDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebFiltersDialog;
var
  dialog: TfrmWebFiltersDlg;
begin
  dialog := TfrmWebFiltersDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebGoodsFlagsSetupDialog;
begin

end;

procedure TfrmMainForm.ShowWebFirstPageGoodsGroups;
var
  dialog: TfrmWebGoodsGroupsDlg;
begin
  dialog := TfrmWebGoodsGroupsDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebMailingLists;
var
  dialog: TfrmWebMailingsDlg;
begin
  dialog := TfrmWebMailingsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebPromoActiuniDialog;
var
  dialog: TfrmWebActiuniDlg;
begin
  dialog := TfrmWebActiuniDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebShopsDialog;
var
  dialog: TfrmWebShopsDlg;
begin
  dialog := TfrmWebShopsDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.ShowWebStaticPages;
var
  dialog: TfrmWebStaticPagesDlg;
begin
  dialog := TfrmWebStaticPagesDlg.Create(Self);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.StartAppShutdown(const DelaySec: Integer);
var
  Timer: TTimerThread;
begin
  if not fInShutdown then
  begin
    if (DelaySec > 0) or (dmDB.CheckIfShutdownIsForDefaultDT) then
    begin
      PlaySound(PWideChar(cSOUND_SYSTEMHAND), 0, SND_ASYNC);
      fInShutdown := true;

      if DelaySec = 0 then
        ImmediateAppShutdown
      else
      begin
        pnShutdownWarning.Visible := True;

        Timer := TTimerThread.Create;
        Timer.Interval := DelaySec * 1000;
        Timer.TickInterval := 1000; // 1sec
        Timer.OnTick := WhenShutdownTimerTick;
        Timer.OnEndTime := WhenShutdownTimerEnds;
        Timer.Start;
      end;
    end;
  end;
end;

procedure TfrmMainForm.StructureListChanged(const NewStructureGroupIndex: Integer);
var
  Group: TdxNavBarGroup;
begin
  Group := dxStructureNavigation.Groups[NewStructureGroupIndex];
  cxTreeDocTypes.Parent := Group.Control;
  cxTreeDocTypes.align := alClient;

  ShowDocumentsTree(Group.Tag);
end;

procedure TfrmMainForm.SwitchToDocType(const DocTypeID: Integer);
var
  NodeParent, Node: TcxTreeListNode;
  Data: PDocTypeItem;
  found: Boolean;
begin
  if cxTreeDocTypes.Count > 0 then
  begin
    found := false;
    Node := nil;

    NodeParent := cxTreeDocTypes.Items[0];
    while NodeParent <> nil do
    begin
      Node := NodeParent.getFirstChild;
      while Node <> nil do
      begin
        Data := PDocTypeItem(Node.Data);
        if Data^.DocTypeID = DocTypeID then
        begin
          found := true;
          break;
        end;
        Node := Node.getNextSibling;
      end;
      if found then
        break;
      NodeParent := NodeParent.getNextSibling;
    end;

    if found and Assigned(Node) then
    begin
      Node.MakeVisible;
      cxTreeDocTypes.SetFocusedNode(Node, []);
    end;
  end;
end;

procedure TfrmMainForm.TimerForTrTimer(Sender: TObject);
begin
  if dmDB.IBCTrDefaultUpdate.Active then
    dxStatusBar.Panels[6].Text := 'Transaction ACTIVE!'
  else
    dxStatusBar.Panels[6].Text := '';
end;

procedure TfrmMainForm.tmTimerEventTimer(Sender: TObject);
begin
  // if pnEventHeader.Color = clGray
  // then pnEventHeader.Color := $000085DD
  // else pnEventHeader.Color := clGray;
  tmTimerEvent.Tag := tmTimerEvent.Tag - 1;
  if tmTimerEvent.Tag < 0 then
    tmTimerEvent.Enabled := false;
end;

procedure TfrmMainForm.WhenFirstView(Sender: TObject);
begin
  if dxStructureNavigation.Groups.Count > 0 then
    StructureListChanged(0);

  cxTreeDocTypes.OnFocusedNodeChanged := WhenTreeDocTypesFocusedNodeChanged;
  SelectFirstItemInDocTypeList;

  TimerForTr.Enabled := true;
  fUpdater.CheckForUpdateNow(true);
  // show chat window
  if Assigned(winChatWindow) then
    winChatWindow.ShowChatWindow;
  // focus back to main window
  Self.SetFocus;
end;

procedure TfrmMainForm.WhenFrameButtonStateChanged(const Button: TFrameButtonType; const ButtonEnabled: Boolean);
begin
  case Button of
    fbtADD:
      bbNewDocument.Enabled := ButtonEnabled;
    fbtMODIFY:
      bbModifyDocument.Enabled := ButtonEnabled;
    fbtDELETE:
      bbRemoveDocument.Enabled := ButtonEnabled;
    fbtCLONE:
      bbCloneDocument.Enabled := ButtonEnabled;
    fbtREFRESH:
      bbRefreshDocuments.Enabled := ButtonEnabled;
    fbtCloseDocument:
      bbCloseDocument.Enabled := ButtonEnabled;
    fbtOpenDocument:
      bbOpenDocument.Enabled := ButtonEnabled;
  end;
end;

procedure TfrmMainForm.WhenFrameShow(const ShownFrame: TSWNBaseFrame);
begin
  dxBarManagerMain.BeginUpdate;
  dxBarManagerMainBar3.LockUpdate := true;
  try
    if Assigned(ShownFrame) then
    begin
      // setup buttons:
      // 1. Add
      if fbtADD in ShownFrame.FrameButtons then
        bbNewDocument.Visible := ivAlways
      else
        bbNewDocument.Visible := ivNever;

      // 2. Modify
      if fbtMODIFY in ShownFrame.FrameButtons then
        bbModifyDocument.Visible := ivAlways
      else
        bbModifyDocument.Visible := ivNever;

      // 3. Delete
      if fbtDELETE in ShownFrame.FrameButtons then
        bbRemoveDocument.Visible := ivAlways
      else
        bbRemoveDocument.Visible := ivNever;

      // 4. Clone
      if fbtCLONE in ShownFrame.FrameButtons then
        bbCloneDocument.Visible := ivAlways
      else
        bbCloneDocument.Visible := ivNever;

      // 5. Refresh
      if fbtREFRESH in ShownFrame.FrameButtons then
        bbRefreshDocuments.Visible := ivAlways
      else
        bbRefreshDocuments.Visible := ivNever;

      // 6. Dial
      if fbtDial in ShownFrame.FrameButtons then
        bbDial.Visible := ivAlways
      else
        bbDial.Visible := ivNever;

      // setup filter settings
      fCurrentFrameFilterFields := ShownFrame.FilterFields;
      if fCurrentFrameFilterFields <> [] then
      begin
        bbMainFilter.Enabled := true;
        bbMainFilterContext.Enabled := true;
      end
      else
      begin
        bbMainFilter.Enabled := false;
        bbMainFilterContext.Enabled := false;
      end;
      if not (ffDate in fCurrentFrameFilterFields) then
      begin
        // Frame-u n-are filtrare dupa data, facem disable si resetam filtru la Today
        bbComboFilterDates.Tag := 1; // silent change
        bbComboFilterDates.Enabled := false;
        bbComboFilterDates.ItemIndex := bbComboFilterDates.Items.IndexOfObject(SWNDocumentFrameDateFilters.GetFilterObject
          (fdfToday));
        bbComboFilterDates.Tag := 0;
      end
      else
        bbComboFilterDates.Enabled := true;
    end
    else
    begin
      bbNewDocument.Visible := ivNever;
      bbModifyDocument.Visible := ivNever;
      bbRemoveDocument.Visible := ivNever;
      bbCloneDocument.Visible := ivNever;
      bbDial.Visible := ivNever;
      bbMainFilter.Enabled := false;
      bbComboFilterDates.Enabled := false;
    end;
  finally
    dxBarManagerMainBar3.LockUpdate := false;
    dxBarManagerMain.EndUpdate;
  end;
end;

procedure TfrmMainForm.WhenGotoFrame(const FrameID: Integer; const Value: Integer; var FrameFound: Boolean);
var
  Node: TcxTreeListNode;
begin
  Node := FrameIndexExistsInTree(FrameID);
  if Assigned(Node) then
  begin
    cxTreeDocTypes.BeginUpdate;
    try
      cxTreeDocTypes.Tag := Value;
      cxTreeDocTypes.FocusedNode := Node;
      Node.MakeVisible;
    finally
      cxTreeDocTypes.EndUpdate;
      FrameFound := true;
    end;

  end;
end;

procedure TfrmMainForm.WhenGotoFrameEx(const FrameID, Value: Integer; const DocDate: TDateTime; var FrameFound: Boolean);
var
  Node: TcxTreeListNode;
  selectedFilterObject: TDocumentDateFilterItem;
  computedFilterItem: TFrameDocumentDateFilter;
  DateStart, DateEnd: TDateTime;
  filterItem: TDocumentDateFilterItem;
begin
  FrameFound := false;
  Node := FrameIndexExistsInTree(FrameID);
  if Assigned(Node) then
  begin
    // check if doc date is in current filter
    if (bbComboFilterDates.ItemIndex <> -1) then
      selectedFilterObject := TDocumentDateFilterItem(bbComboFilterDates.Items.Objects[bbComboFilterDates.ItemIndex])
    else
      selectedFilterObject := nil;
    computedFilterItem := GetDocumentFrameFilterByDate(DocDate);

    if (selectedFilterObject = nil) or (computedFilterItem <> selectedFilterObject.Filter) or (computedFilterItem = fdfAll) then
    begin
      // documentul cautat nu este in diapazonul calendaristic identic cu cel din filtru selectat
      // verificam daca diapazonul calendaristic este "pe aproape"
      if (computedFilterItem in [fdfToday, fdfLast7days, fdfCurrentWeek, fdfLast2weeks, fdfCurrentMonth]) and
        GetDocumentFrameFilterDateValues(computedFilterItem, DateStart, DateEnd) then
      begin
        // anulam filtrele silent si punem filtrul pe data implicit
        filterItem := SWNDocumentFrameDateFilters.GetFilterObject(computedFilterItem);
        bbComboFilterDates.ItemIndex := bbComboFilterDates.Items.IndexOfObject(filterItem);
      end
      else
      begin
        // impunem filtrarea dupa data la ziua documentului
        fCurrentFrameDataFilter.DateStart := DocDate;
        fCurrentFrameDataFilter.DateEnd := DocDate;

        // scoatem selectia de filtru
        bbComboFilterDates.Tag := 1;
        bbComboFilterDates.ItemIndex := -1;
        bbComboFilterDates.Tag := 0;

        // aratam "Filter indicator"
        ShowFilterIndicator;
      end;
    end;

    // goto frame
    if Node.Selected then
    begin
      // rezultatul se afla tot in acelas tip de document
      // refresh la date cu filtrele de date noi
      SWNFrameManager.FrameDataFilterChanged(fCurrentFrameDataFilter);
    end
    else
    begin
      // rezultatul se afla in alt tip de document
      // schimbam nodul (va fi automat recitite datele)
      cxTreeDocTypes.BeginUpdate;
      try
        cxTreeDocTypes.Tag := Value;
        cxTreeDocTypes.SetFocusedNode(Node, []); // FocusedNode:=Node;
        Node.MakeVisible;
      finally
        cxTreeDocTypes.EndUpdate;
      end;
    end;

    FrameFound := SWNFrameManager.CurrentFrame.LocateDocument(Value);
    if FrameFound and (Value = -1) then
      SWNFrameManager.CurrentFrame.SetupDefaultFocus;
  end;
end;

procedure TfrmMainForm.WhenNeedShowPrintDialog(const FrameID: Integer);
begin
  ShowPrintDocumentsDialog(dmDB.CurrentDocTypeID);
end;

procedure TfrmMainForm.WhenNeedToScanForEvent(Sender: TObject);
begin
  if (fEventManager.EventTypes <> []) then
  begin
    if fEventManager.ScanForEvents then
    begin
      // start flash panel
      tmTimerEvent.Enabled := true;
      tmTimerEvent.Tag := 5;
    end;
  end;
end;

procedure TfrmMainForm.WhenNewEventArrive(const ListOfEvents: TList);
var
  N, i: Integer;
  Event: TSWNDBEvent;
begin
  cxGridTable.BeginUpdate;
  try
    for i := 0 to ListOfEvents.Count - 1 do
    begin
      Event := TSWNDBEvent(ListOfEvents[i]);

      N := cxGridTable.DataController.InsertRecord(0);
      cxGridTable.DataController.Values[N, cxGridTable_EVENTID.index] := Event.EventID;
      cxGridTable.DataController.Values[N, cxGridTable_DateTime.index] := Event.DateTime;
      cxGridTable.DataController.Values[N, cxGridTable_EVENT.index] := Event.Title;
      if (Event.EventType <> dbetSchedulerDelivery) then
        cxGridTable.DataController.Values[N, cxGridTable_DOCID.index] := Event.ValueInt;
      cxGridTable.DataController.Values[N, cxGridTable_MSG.index] := Event.Msg;
      cxGridTable.DataController.Values[N, cxGridTable_EVENTTYPE.index] := Ord(Event.EventType);
      cxGridTable.DataController.Values[N, cxGridTable_ISNEW.index] := Event.IsNew;
      cxGridTable.DataController.Values[N, cxGridTable_USERFULLNAME.index] := Event.UserFullName;
    end;
  finally
    cxGridTable.EndUpdate;
  end;

  // pentru ultimul eveniment, facem sunetul corespunzator si refresh la date daca e posibil
  if (ListOfEvents.Count > 0) then
  begin
    // luam ultimul event
    Event := TSWNDBEvent(ListOfEvents[ListOfEvents.Count - 1]);
    case Event.EventType of
      dbetRashod:
        begin
          PlayAudio_РасходнаяНакладная;
          // refresh Rashod, only if frame is visible and no other dialogs opened
          if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID = 10) and (SWNFormsMonitor.Count
            = 0) then
            dmDB.FullRefresh;
        end;
      dbetSborka:
        begin
          PlayAudio_НарядНаСборку;
          // refresh Sborka, only if frame is visible and no other dialogs opened
          if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID = 14) and (SWNFormsMonitor.Count
            = 0) then
            dmDB.FullRefresh;
        end;
      dbetRashodCommentsChanged:
        ;
      dbetSborksCommentsChanged:
        ;
      dbetPeremeshenieCommentsChanged:
        ;
      dbetWebZakaz:
        begin
          PlayAudio_WebZakaz;
          // refresh WebZakaz, only if frame is visible and no other dialogs opened
          if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID = 24) and (SWNFormsMonitor.Count
            = 0) then
            dmDB.FullRefresh;
        end;
      dbetWebCerereFinantare:
        begin
          PlayAudio_CerereDeFinantare;
          // refresh Cerere de finantare, only if frame is visible and no other dialogs opened
          if Assigned(SWNFrameManager.CurrentFrame) and (SWNFrameManager.CurrentFrame.FrameID = 51) and (SWNFormsMonitor.Count
            = 0) then
            dmDB.FullRefresh;
        end;

//      -- Depricated
//      dbetSchedulerDelivery:
//        begin
//          PlayAudio_WebZakaz;
//        end;
    end;
  end;
end;

procedure TfrmMainForm.WhenNewVersionFound(const NewVersion, WhatsNew: string; const Crtitical: Boolean);
var
  dialog: TfrmNewVersionDlg;
begin
  dialog := TfrmNewVersionDlg.Create(Self);
  try
    dialog.SetVersionInfo(fUpdater.AppVersionStr, NewVersion, WhatsNew, Crtitical);
    if dialog.ShowModal = mrOk then
      fUpdater.DoUpdateApplication(cUPDATE_UpdaterFileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmMainForm.WhenNoVersionFound(Sender: TObject);
begin
  ShowInfoDialog('Versiunea programei ' + fUpdater.AppVersionStr, 'La moment este instalata ultima versiune a programei!');
end;

procedure TfrmMainForm.WhenOpenFormsListChanged(Sender: TObject);
begin
  // mmEvents.Lines.Add('Opened forms count = '+IntToStr(SWNFormsMonitor.Count));
end;

procedure TfrmMainForm.WhenQuickAccessReportClicked(Sender: TObject);
begin
  PrintReport(TdxBarButton(Sender).Tag, TdxBarButton(Sender).Caption);
end;

procedure TfrmMainForm.WhenRequiredFrameNotFound(const RequiredFrameID: Integer; var NewCustomFrame: TSWNBaseFrame);
begin
  case RequiredFrameID of
    0:
      NewCustomFrame := TframeScheduler.Create(Self); // Scheduler
    1:
      NewCustomFrame := Tframe01CasaPKO.Create(Self);
    // CASA. Dispozitie de incasare
    2:
      NewCustomFrame := Tframe02CasaRKO.Create(Self);
    // CASA. Dispozitie de plata
    3:
      NewCustomFrame := Tframe03CasaNS.Create(Self); // CASA. Sold initial
    4:
      NewCustomFrame := Tframe04BankPDNS.Create(Self);
    // BANCA. Incasare bani in cont
    5:
      NewCustomFrame := Tframe05BankPDNSIC.Create(Self);
    // BANCA. Incasare bani in cont (din casa)
    6:
      NewCustomFrame := Tframe06BankBPPL.Create(Self);
    // BANCA. Ordine de plata bancare, Lei
    7:
      NewCustomFrame := Tframe07BankBPPV.Create(Self);
    // BANCA. Ordine de plata bancare, Valuta
    8:
      NewCustomFrame := Tframe08ConfigurationBRK.Create(Self);
    // CONFIGURATII. Configurator (Calcul rapid configuratie)
    9:
      NewCustomFrame := Tframe09NakladniePN.Create(Self);
    // NAKLADNIE. Intrare marfa (Evidenta operativa)
    10:
      NewCustomFrame := Tframe10NakladnieRN.Create(Self);
    // NAKLADNIE. Nakladnaia de iesire
    11:
      NewCustomFrame := Tframe11PeremeshenieP.Create(Self);
    // TRANSFER. Transfer
    12:
      NewCustomFrame := Tframe12CassaPersonal.Create(Self);
    // CASA. Casa personala
    14:
      NewCustomFrame := Tframe14NareadSborka.Create(Self);
    // ASAMBLARE - Naryad de asamblare
    15:
      NewCustomFrame := Tframe15TovarBezHaracteristic.Create(Self);
    // Produs fara caracteristici
    16:
      NewCustomFrame := Tframe16NedostaiushiiTovar.Create(Self);
    // Produs lipsa
    17:
      NewCustomFrame := Tframe17NareadRazborka.Create(Self);
    // ASAMBLARE - Naryad de dezasamblare
    18:
      NewCustomFrame := Tframe18SciotNaOplatu.Create(Self);
    // FACTURI - Facturi de plata
    19:
      NewCustomFrame := Tframe19ScetaVhodnieSceta.Create(Self);
    // FACTURI - Facturi de intrare
    20:
      NewCustomFrame := Tframe20PrihotTovaraPoNakladnim.Create(Self);
    // NAKLADNIE. Intrare Marfa pe Nakladnie
    21:
      begin
        if dmdb.CurrentUserID <> 204 then
          sleep(5000);
        NewCustomFrame := Tframe21Zarplata.Create(Self);
      end;
    // OPERATIUNI DE CASA. Salariu
    22:
      NewCustomFrame := Tframe22OstatkiTovara.Create(Self);
    // STOCURI. Stocuri marfa
    23:
      NewCustomFrame := Tframe23SalidoKontragentov.Create(Self);
    // STOCURI. Sold contraagenti
    24:
      NewCustomFrame := Tframe24WebZakaz.Create(Self); // WEB. Comanda Web
    25:
      NewCustomFrame := Tframe25ScetFaktura.Create(Self);
    // FACTURI FISCALE. Facturi fiscale
    26:
      NewCustomFrame := Tframe26AktSpisania.Create(Self);
    // INVENTARIERE. Act de casare
    27:
      NewCustomFrame := Tframe27AktOprihodovania.Create(Self);
    // INVENTARIERE. Act de intrare
    28:
      NewCustomFrame := Tframe28NakladnieRNS.Create(Self);
    // NAKLADNIE. Nakladnaia de iesire (Service)
    29:
      NewCustomFrame := Tframe29Rezerv.Create(Self); // NAKLADNIE. Rezerva
    30:
      NewCustomFrame := Tframe30CassaFirma.Create(Self);
    // CASA - Casa organizatiei
    31:
      NewCustomFrame := Tframe31ServiceRequests.Create(Self);
    // SERVICE - Cereri de reparatie
    32:
      NewCustomFrame := Tframe32ServiceRequestsWarranty.Create(Self);
    // SERVICE - Cereri de reparatie in garantie
    33:
      NewCustomFrame := Tframe33ServiceReturnToVendor.Create(Self);
    // SERVICE - Retur marfa furnizor
    34:
      NewCustomFrame := Tframe34ServiceReturnFromVendor.Create(Self);
    // SERVICE - Retur de la furnizor
    35:
      NewCustomFrame := Tframe35ServiceReturnToClient.Create(Self);
    // SERVICE - Retur marfa client
    36:
      NewCustomFrame := Tframe36ServiceNewIncidents.Create(Self);
    // SERVICE - Incidente noi
    37:
      NewCustomFrame := Tframe37ServiceDispatcher.Create(Self);
    // SERVICE - Dispecer service
    38:
      NewCustomFrame := Tframe38ServiceFinishedIncidents.Create(Self);
    // SERVICE - Incidente rezolvate
    39:
      NewCustomFrame := Tframe39ServiceEngineer.Create(Self);
    // SERVICE - Inginer service
    40:
      NewCustomFrame := Tframe40InventarizatiaPereotencaTovara.Create(Self);
    // INVENTARIERE - Reevaluare marfa
    41:
      NewCustomFrame := Tframe41AktOprihodPoNakladnim.Create(Self);
    // NAKLADNIE. Act de intrare pe nakladnie
    42:
      NewCustomFrame := Tframe42CassaGlobalFirme.Create(Self);
    // CASA - Casa pe toate organizatiile
    43:
      NewCustomFrame := Tframe43CashTransfer.Create(Self);
    // CASA - Transfer bani
    44:
      NewCustomFrame := Tframe44ZamenaPoBraku.Create(Self);
    // SERVICE - Inlocuire pe rebut
    45:
      NewCustomFrame := Tframe45ZakritiTovarKomisia.Create(Self);
    // COMISION - Inchidere marfa in comision
    46:
      NewCustomFrame := Tframe46RascetZarplati.Create(Self);
    // SALARIU - Calcul Salariu
    47:
      NewCustomFrame := Tframe47ActiuniMarketing.Create(Self);
    // PUBLICITATE - Actiuni de marketing
    48:
      NewCustomFrame := Tframe48KBP.Create(Self);
    // OPERATIUNI BANCARE - Comision plata bancara
    49:
      NewCustomFrame := Tframe49ZacetBalansGarantia.Create(Self);
    // SERVICE. Trecere in bilant pe garantie
    50:
      NewCustomFrame := Tframe50Realizatia.Create(Self);
    // Primire in bilant din comision
    51:
      NewCustomFrame := Tframe51ZaiavkaCredit.Create(Self);
    // WEB. Cerere de finantare
    52:
      NewCustomFrame := Tframe52ZamenaTovara.Create(Self);
    // SERVICE. Inlocuire marfa
    53:
      NewCustomFrame := Tframe53ARPP.Create(Self);
    // Acte: Registru transmitere documente
    54:
      NewCustomFrame := Tframe54Inventarizatia.Create(Self);
    // INVENTARIERE. Inventariere
    55:
      NewCustomFrame := Tframe55VozvratPriemService.Create(Self);
    // SERVICE. Retur in / Primire din Centrul Service
    // 56: NewCustomFrame:=Tframe56PVfromCustomerService.Create(Self);       // SERVICE. Retur in / Primire de la client
    57:
      NewCustomFrame := Tframe57ActDeficiente.Create(Self);
    // Act de constatare a deficientelor
    58:
      NewCustomFrame := Tframe58.Create(Self); // Corectare casa!
    59:
      NewCustomFrame := Tframe59TTN.Create(Self);
    // FACTURI FISCALE - Nakladnie marfa transport
    60:
      NewCustomFrame := Tframe60PredvaritelnieZakazi.Create(Self);
    // FACTURI - Comenzi preliminare
    61:
      NewCustomFrame := Tframe61OstatkiDenegNaScetu.Create(Self);
    // OPERATIUNI BANCARE - Sold bani in cont
    62:
      NewCustomFrame := Tframe62Contracte.Create(Self); // CONTRACTE - Contracte
    63:
      NewCustomFrame := Tframe63AktSpisaniaPoNakladnim.Create(Self);
    64:
      NewCustomFrame := Tframe64.Create(Self);
//    67:
//      NewCustomFrame := Tframe67AnalizTsen.Create(Self);
    70:
      NewCustomFrame := Tframe70CorrIn.Create(Self);
    71:
      NewCustomFrame := Tframe71CorrOut.Create(Self);
    72:
      NewCustomFrame := Tframe72Proiecte.Create(Self);
    73:
      NewCustomFrame := Tframe73DSE.Create(Self);
    // 74:
    // NewCustomFrame := Tframe74PriceList.Create(Self);
    75:
      NewCustomFrame := Tframe75ReminderForced.Create(Self);
    76:
      NewCustomFrame := Tframe76ActiuniProduseWeb.Create(Self);
    77:
      NewCustomFrame := Tframe77Oportunitati.Create(Self);
    78:
      NewCustomFrame := Tframe78PriceList.Create(Self);
//    79:
//      NewCustomFrame := Tframe79AnalizePriceList.Create(Self);
    80:
      NewCustomFrame := Tframe80Inventariere.Create(Self);
//    81:
//      NewCustomFrame := Tframe81Salary.Create(Self);
    82: // Registrul livrarilor
      NewCustomFrame := Tframe82Livrari.Create(Self);
    83: // Promo Coduri
      NewCustomFrame := Tframe83PromoCoduri.Create(Self);
    84: // Cashback
      NewCustomFrame := Tframe84RegistruCashback.Create(Self);
    85: // Registrul apelurilor telefonice
      NewCustomFrame := Tframe85Apeluri.Create(Self);
    86: // Sold Contabil
      NewCustomFrame := Tframe86SoldClientiContabil.Create(Self);
    87: // Supplier Promotions
      NewCustomFrame := Tframe87SupplierPromo.Create(Self);
    88: // ImportGoods
      NewCustomFrame := Tframe88ImportGoods.Create(Self);
    89: // ImportGoods
      NewCustomFrame := Tframe89RezerveAnulate.Create(Self);
    91: // API Furnizor Accent
      NewCustomFrame := Tframe91APIAccent.Create(Self);
    92: // API Furnizor Ultra
      NewCustomFrame := Tframe92APIUltra.Create(Self);
    93: // Oferte pentru tender
      NewCustomFrame := Tframe93Tender.Create(Self);
    94: // Web Check
      NewCustomFrame := Tframe94WebCheck.Create(Self);
    95: // Vouchere cadou
      NewCustomFrame := Tframe95VouchereCadou.Create(Self);
    96: // Distributie rambrus
      NewCustomFrame := Tframe96DistribuireRamburs.Create(Self);
    97: // Client bank
      NewCustomFrame := Tframe97ClientBank.Create(Self);
    98: // Ambianta api
      NewCustomFrame := Tframe98ApiAmbianta.Create(Self);
    100: // Cerere de plati
      NewCustomFrame := Tframe100CerereDePlata.Create(Self);
    101: // Grab muncitorul images
      NewCustomFrame := Tframe101WebscrapMuncitorul.Create(Self);
    102: // Grab imperia.md images
      NewCustomFrame := Tframe102WebscrapImperia.Create(Self);
//    103:  // Grab pit.md images
//            NewCustomFrame := Tframe103PIT.Create(Self);
    105:  // Grab volta.md images
      NewCustomFrame := Tframe105Volta.Create(Self);
    106:  // Grab volta.md images
      NewCustomFrame := Tframe106Convel.Create(Self);
    107:  // Grab catol.md images
      NewCustomFrame := Tframe107Catol.Create(Self);
    108:  // Grab lumeainstrumentelor.md
      NewCustomFrame := Tframe108LumeaInstrumentelor.Create(Self);
    109: // snaige.md
      NewCustomFrame := Tframe109SnaigeAPI.Create(Self);
    110: // bomba.md
      NewCustomFrame := Tframe110BombaAPI.Create(Self);
    111: // ultra.md
      NewCustomFrame := Tframe111UltraMD.Create(Self);
    112: // hikoki
      NewCustomFrame := Tframe112Hikoki.Create(Self);
    113: // euroterm
      NewCustomFrame := Tframe113EuroTerm.Create(Self);
    114: // Acvilin Grup
      NewCustomFrame := Tframe114AcvilinParse.Create(Self);
    115: // Megacom service
      NewCustomFrame := Tframe115Megacom.Create(Self);
    116: // ComputerUniverse.NET
      NewCustomFrame := Tframe116ComputerUniverse.Create(Self);
    117: // BeanBag
      NewCustomFrame := Tframe117ParserBeanBag.Create(Self);
    118: // instrumentall.md
      NewCustomFrame := Tframe118InstrumentAll.Create(Self);
    119: // pernamea.md
      NewCustomFrame := Tframe119PernaMea.Create(Self);
    120:
      NewCustomFrame := TFrame120ATehno.Create(self);
    121:
      NewCustomFrame := TFrame121ApiScop.Create(self);
    122:
      NewCustomFrame := Tframe122Samsonite.Create(self);
    123:
      NewCustomFrame := Tframe123Dehome.Create(self);
    124:
      NewCustomFrame := Tframe124HiTech.Create(self);
    125:
      NewCustomFrame := Tframe125NexDistribution.Create(self);
    126:
      NewCustomFrame := Tframe126Refurb.Create(self);
    127:
      NewCustomFrame := Tframe127Doxy.Create(self);
    129:
      NewCustomFrame := Tframe129VInzarePrinPartener.Create(self);
//        130:
//            NewCustomFrame := Tframe130PhoneCalls.Create(self);
//        131:
//            NewCustomFrame := Tframe131OlisGrup.Create(self);
    132:
      NewCustomFrame := Tframe132DMLink.Create(self);

  end;
  // custom actions
  if Assigned(NewCustomFrame) then
  begin
    NewCustomFrame.OnCustomPrintSetupReportParams := SetupReportParams;
  end;
end;

procedure TfrmMainForm.WhenShutdownTimerEnds;
begin
  // SWNFormsMonitor.CloseAllForms;
  Close;
end;

procedure TfrmMainForm.WhenShutdownTimerTick(const RemainingTime: cardinal);
var
  sec: Integer;
begin
  sec := RemainingTime div 1000;
  cgEmergencyShutdown2.Caption := Format('Programa va inchisa fortat in  %d secunde', [sec]);
  if (sec = 30) or (sec = 10) or (sec = 5) then
    PlaySound(PWideChar(cSOUND_SYSTEMHAND), 0, SND_ASYNC);

end;

end.


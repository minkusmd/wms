unit frame08ConfigurationKonfiguratorUnit;

{
  КОНФИГУРАЦИИ. Быстрый расчет конфигурации
  DocTypeID = 115
  Frame Index = 8
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, DB,
    cxDBData, dxBar, DBAccess, IBC, cxSplitter, cxPC, ExtCtrls, cxGridLevel,
    cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
    cxGrid, cxGridPopupMenu, cxCalc, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
    dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCurrencyEdit,
    cxLabel, cxCheckBox, dxBarBuiltInMenu, cxGridCustomPopupMenu, MemDS,
    cxClasses, dxUIAClasses;

type
    TStringArray = array of string;

    Tframe08ConfigurationBRK = class(TSWNBaseFrame)
        cxGridBRK: TcxGrid;
        cxGridBRKDBTable: TcxGridDBTableView;
        cxGridBRKDBTableDocID: TcxGridDBColumn;
        cxGridBRKDBTableData: TcxGridDBColumn;
        cxGridBRKDB_CT_NAME: TcxGridDBColumn;
        cxGridBRKDBTableSuma: TcxGridDBColumn;
        cxGridBRKDB_CURRENCY_NAME: TcxGridDBColumn;
        cxGridBRKDBTableVAT: TcxGridDBColumn;
        cxGridBRKDBTableRate: TcxGridDBColumn;
        cxGridBRKDBTableParentDocID: TcxGridDBColumn;
        cxGridBRK_FLG_ACNT: TcxGridDBColumn;
        cxGridBRKDB_CREATED_BY_NAME: TcxGridDBColumn;
        cxGridBRKLevel: TcxGridLevel;
        cxGridBRKDB_DTDEP_NAME: TcxGridDBColumn;
        pnBottom: TPanel;
        cxSplitter: TcxSplitter;
        dxBarManager: TdxBarManager;
        cxPageControlComplect: TcxPageControl;
        bbPriceColSelector: TdxBarSubItem;
        dxBarSubItem2: TdxBarSubItem;
        bbGoodsNew: TdxBarButton;
        bbGoodsModify: TdxBarButton;
        bbGoodsDelete: TdxBarButton;
        bbPriceCol1: TdxBarButton;
        bbPriceCol2: TdxBarButton;
        bbPriceCol3: TdxBarButton;
        bbPriceCol4: TdxBarButton;
        bbPriceCol5: TdxBarButton;
        bbAddFromKit: TdxBarButton;
        bbInsertFromTemplate: TdxBarButton;
        bbCalcKit: TdxBarButton;
        tbsGoods: TcxTabSheet;
        tbsKitContent: TcxTabSheet;
        cxGridComplect: TcxGrid;
        cxGridComplectTable: TcxGridDBTableView;
        cxGridComplect_GOODSID: TcxGridDBColumn;
        cxGridComplect_GOODS_NAME: TcxGridDBColumn;
        cxGridComplect_UM_NAME: TcxGridDBColumn;
        cxGridComplect_QTY: TcxGridDBColumn;
        cxGridComplect_PRICE: TcxGridDBColumn;
        cxGridComplect_SUMA: TcxGridDBColumn;
        cxGridComplect_SUMAVAT: TcxGridDBColumn;
        cxGridComplect_FLG_ACNT: TcxGridDBColumn;
        cxGridComplect_WARRANTY: TcxGridDBColumn;
        cxGridComplect_STOCK_QTY: TcxGridDBColumn;
        cxGridComplect_FLG_ACTIVE: TcxGridDBColumn;
        cxGridComplectLevel1: TcxGridLevel;
        cxGridComponents: TcxGrid;
        cxGridComponentsTable: TcxGridDBTableView;
        cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
        cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
        cxGridDBCol_UM_NAME: TcxGridDBColumn;
        cxGridDBCol_QTY: TcxGridDBColumn;
        cxGridDBCol_PRICE: TcxGridDBColumn;
        cxGridDBCol_SUMA: TcxGridDBColumn;
        cxGridDBCol_SUMAVAT: TcxGridDBColumn;
        cxGridDBCol_GOODSID: TcxGridDBColumn;
        cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
        cxGridLevel: TcxGridLevel;
        bbAddToQTY: TdxBarButton;
        bbIncreaseSum: TdxBarButton;
        IBCQueryJurnalKit: TIBCQuery;
        IBCDataSourceJurnalKit: TIBCDataSource;
        cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
        dxPopupMenuRBK: TdxBarPopupMenu;
        bbPopup_CreateRashod: TdxBarButton;
        bbPopup_Menu2: TdxBarButton;
        bbPopup_CreateScet: TdxBarButton;
        cxGridDBCol_IMG: TcxGridDBColumn;
        cxGridComplect_IMG: TcxGridDBColumn;
        cxGridDBCol_FLG_READY: TcxGridDBColumn;
        cxGridComplect_FLG_READY: TcxGridDBColumn;
        DockControlGoods: TdxBarDockControl;
        DockControlComplect: TdxBarDockControl;
        dxBarManagerBar2: TdxBar;
        dxBarManagerBar3: TdxBar;
        bbGoodsComplectAdd: TdxBarButton;
        bbGoodsComplectEdit: TdxBarButton;
        bbGoodsComplectDelete: TdxBarButton;
        dxBarSubItem3: TdxBarSubItem;
        bbAddToQTYComplect: TdxBarButton;
        cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
        bbAddSumaToComplect: TdxBarButton;
        cxGridDBCol_GOODSCOMPLECTID: TcxGridDBColumn;
        cxGridBRKDB_RATEUSD: TcxGridDBColumn;
        cxGridPopupMenuBRK: TcxGridPopupMenu;
        bbDocDiscount: TdxBarButton;
        cxGridBRKDB_DT: TcxGridDBColumn;
        cxGridBRKDB_CT: TcxGridDBColumn;
        cxGridDBCol_FLG_HAS_COMPLECT_GOODS: TcxGridDBColumn;
        cxGridBRK_FLG_CLOSED: TcxGridDBColumn;
        cxGridComponents_PRICE_COLUMN: TcxGridDBColumn;
        cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
        cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
        cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn;
        cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn;
        bbCustomerDebts: TdxBarButton;
        cxGridComponents_UMID: TcxGridDBColumn;
        cxGridComplect_UMID: TcxGridDBColumn;
        bbPriceCol6: TdxBarButton;
        bbPriceCol7: TdxBarButton;
        bbPriceCol0: TdxBarButton;
        bbMoveGoodsInComplect: TdxBarButton;
        cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
        dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu;
        dxBarPopupMenuCOMPLECT: TdxBarPopupMenu;
        cxGridPopupMenuCOMPLECT: TcxGridPopupMenu;
        bbGoodsInfoCard: TdxBarButton;
        bbGoodsPrice: TdxBarButton;
        bbGoodsForeignCode: TdxBarButton;
        bbKitGoodsInfoCard: TdxBarButton;
        bbKitGoodsPrice: TdxBarButton;
        bbKitGoodsForeignCode: TdxBarButton;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        cxGridComponentsTable_FLG_FORCED_ADDON: TcxGridDBColumn;
        dxBarButton3: TdxBarButton;
        dxBarButton4: TdxBarButton;
        cxGridBRKDB_CREATED_DATE: TcxGridDBColumn;
        cxGrid_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
        cxGridComplect_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
        cxGridBRKDB_CTSC_NAME: TcxGridDBColumn;
        cxGridBRKDB_dtsc_name: TcxGridDBColumn;
        cxGridBRKDBTableColumn1: TcxGridDBColumn;
        dxBarButton5: TdxBarButton;
        bbKitchenTemplate: TdxBarButton;
        cxGridComponents_FLG_FORCED: TcxGridDBColumn;
        dxBarButton6: TdxBarButton;
        dxBarButton7: TdxBarButton;
        dxBarSubItem1: TdxBarSubItem;
        cxGridComponents_FLG_PROMO: TcxGridDBColumn;
        cxGridComplect_FLG_ADDON: TcxGridDBColumn;
        dxBarButton8: TdxBarButton;
        dxBarButton9: TdxBarButton;
        cxGridBRKDB_STATE_NAME: TcxGridDBColumn;
        cxGridBRKDBTableColumn2: TcxGridDBColumn;
        bbTVA0: TdxBarButton;
        cxGridBRKDB_FLG_REZERVA: TcxGridDBColumn;
        cxGridBRKDB_FLG_PROFORMA: TcxGridDBColumn;
        dxBarButton10: TdxBarButton;
        bbFromAnotherDocument: TdxBarButton;
        bbAddFreeDelivery: TdxBarButton;
        bbTender: TdxBarButton;
        dxBarButton11: TdxBarButton;
        dxBarButton12: TdxBarButton;
        bbCredit: TdxBarButton;
        btnVinzarePartener: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxBarButton13: TdxBarButton;
    cxGridBRKDBTableColumn3: TcxGridDBColumn;
    dxBarButton14: TdxBarButton;
    cxGridComponentsLevel1: TcxGridLevel;
    cxGridComponentsDBTableView1: TcxGridDBTableView;
    cxGridComponentsDBTableView1DOCID: TcxGridDBColumn;
    cxGridComponentsDBTableView1DTDEP: TcxGridDBColumn;
    cxGridComponentsDBTableView1SUPPLIERID: TcxGridDBColumn;
    cxGridComponentsDBTableView1SUPPLIER_NAME: TcxGridDBColumn;
    cxGridComponentsDBTableView1GOODS_CODE: TcxGridDBColumn;
    cxGridComponentsDBTableView1GOODSID: TcxGridDBColumn;
    cxGridComponentsDBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGridComponentsDBTableView1SUPPLIER_QTY: TcxGridDBColumn;
    cxGridComponentsDBTableView1PRICE: TcxGridDBColumn;
    cxGridComponentsDBTableView1MENTIUNI: TcxGridDBColumn;
    cxGridComponentsDBTableView1SUMA: TcxGridDBColumn;
    bbLibrareSubMenu: TdxBarSubItem;
    bbLivrareRepublica: TdxBarButton;
        procedure bbGoodsNewClick(Sender: TObject);
        procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure bbGoodsModifyClick(Sender: TObject);
        procedure bbGoodsDeleteClick(Sender: TObject);
        procedure bbAddFromKitClick(Sender: TObject);
        procedure bbIncreaseSumClick(Sender: TObject);
        procedure bbAddToQTYClick(Sender: TObject);
        procedure bbInsertFromTemplateClick(Sender: TObject);
        procedure bbPriceCol1Click(Sender: TObject);
        procedure cxGridComplectTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure cxGridDBCol_GOODS_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure bbPopup_CreateRashodClick(Sender: TObject);
        procedure bbPopup_Menu2Click(Sender: TObject);
        procedure bbPopup_CreateScetClick(Sender: TObject);
        procedure bbGoodsComplectAddClick(Sender: TObject);
        procedure bbGoodsComplectEditClick(Sender: TObject);
        procedure bbAddToQTYComplectClick(Sender: TObject);
        procedure bbAddSumaToComplectClick(Sender: TObject);
        procedure bbCalcKitClick(Sender: TObject);
        procedure bbGoodsComplectDeleteClick(Sender: TObject);
        procedure cxGridBRKDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure dxPopupMenuRBKPopup(Sender: TObject);
        procedure bbDocDiscountClick(Sender: TObject);
        procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridBRKDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridBRKDBTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure cxGridBRKDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure bbCustomerDebtsClick(Sender: TObject);
        procedure cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
        procedure bbMoveGoodsInComplectClick(Sender: TObject);
        procedure bbGoodsInfoCardClick(Sender: TObject);
        procedure bbGoodsPriceClick(Sender: TObject);
        procedure bbGoodsForeignCodeClick(Sender: TObject);
        procedure bbKitGoodsInfoCardClick(Sender: TObject);
        procedure bbKitGoodsPriceClick(Sender: TObject);
        procedure bbKitGoodsForeignCodeClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton3Click(Sender: TObject);
        procedure dxBarButton4Click(Sender: TObject);
        procedure dxBarButton5Click(Sender: TObject);
        procedure bbKitchenTemplateClick(Sender: TObject);
        procedure dxBarButton6Click(Sender: TObject);
        procedure dxBarButton8Click(Sender: TObject);
        procedure dxBarButton9Click(Sender: TObject);
        procedure bbTVA0Click(Sender: TObject);
        procedure dxBarButton10Click(Sender: TObject);
        procedure bbFromAnotherDocumentClick(Sender: TObject);
        procedure bbAddFreeDeliveryClick(Sender: TObject);
        procedure bbTenderClick(Sender: TObject);
        procedure dxBarButton11Click(Sender: TObject);
        procedure dxBarButton12Click(Sender: TObject);
        procedure bbCreditClick(Sender: TObject);
        procedure btnVinzarePartenerClick(Sender: TObject);
    procedure dxBarButton13Click(Sender: TObject);
    procedure dxBarButton14Click(Sender: TObject);
    procedure bbLivrareRepublicaClick(Sender: TObject);
    private
    { Private declarations }
        fLastDocID: Integer;
        fLastGoodsID: Integer;
        fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
        procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure DocumentSelectionChanged;
        procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsSelectionChanged;
        procedure WhenGoodsComplectGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsComplectSelectionChanged;
        procedure WhenDocumentPopupMenu;
        procedure ShowAddNewGoodsDialog;
        procedure ShowAddNewGoodsToComplectDialog;
        procedure ShowModifyGoodsDialog;
        procedure ShowModifyGoodsInComplectDialog;
        procedure DeleteSelectedGoods;
        procedure DeleteSelectedGoodsInComplect;
        procedure KitAddGoodsFromComplect;
        function KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const RemoveExisting: Boolean): Integer;
        procedure ShowAddCustomSumaToGoodsDialog;
        function DB_AddCustomSumaToGoodsDialog(const Suma: Currency; var NotUsedSuma: Currency): Boolean;
        function GetSumaForTVA: Integer;
        procedure ShowAddCustomSumaToGoodsInComplectDialog;
        function DB_AddCustomSumaToGoodsInComplectDialog(const DocID: Integer; const Suma: Currency; const ParentGoodsID: Integer; var NotUsedSuma: Currency): Boolean;
        procedure ShowSetCustomQTYToGoodsDialog;
        function DB_SetCustomQTYToGoods(const DocID: Integer; const Count: Double; const SetAsCount: Boolean): Boolean;
        procedure ShowSetCustomQTYToGoodsInComplectDialog;
        function DB_SetCustomQTYToGoodsInComplect(const DocID: Integer; const Count: Double; const SetAsCount: Boolean; const ParentGoodsID: Integer): Boolean;
        procedure ShowSelectKitTemplateDialog;
        procedure KitAddGoodsFromTemplate(const TemplateID: Integer; const TemplateName: string);
        function KitAddGoodsFromTemplateDB(const DocID, TemplateID: Integer; const RemoveExisting: Boolean): Boolean;
        procedure CreateRashodnaiaNakladnaia;
        procedure CreateRashodnaiaNakladnaiaServis;
        procedure CreateSciotNaOplatu;
        procedure ShowRascetKonfiguratiiDialog;
        function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
        function WhenCheckIfGoodsExistsInComplect(const GoodsID: Integer): Boolean;
        procedure ShowDocumentDiscountDialog;
        procedure RefreshFromComplect;
        procedure RefreshFromComplectDelete;
        function DoMoveGoodsIntoComplect(const DocID, GoodsID: Integer): Boolean;
        procedure SetupQtyFields;
        function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
        function CreateVinzarePartener(DocID: Integer): Integer;
        function DoImportDocFromPrihod(const DocID: integer): Integer;
    protected
    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        procedure CreateNewRecord; override;
        procedure ModifyRecord; override;
        procedure DeleteRecord; override;
        function GetPhoneNumber: string; override;
        procedure RefreshData; override;
        procedure CloneRecord; override;
        procedure ReadFrameStates; override;
        procedure SaveFrameStates; override;
        procedure SetupSecurityItems; override;
        function GetFrameButtons: TFrameButtons; override;
        function GetFilterFields: TFrameFilterFields; override;
        procedure ShowKitchenTemplate;
        procedure AddGoods2Jurnal(AGoodsID: Integer);
    public
//        procedure AddToAchizitii(GoodsID, Qty, SupplierID: Integer);
    { Public declarations }
        procedure CreateNewRecordFromSip(CustomerPhone, CustomerName: string; CustomerID: Integer);
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
        procedure ShowImportFromDocumentDialog;
        function DocActionDB_ImportFromDocument(TargetDocID: Integer; const SourceDocID: Integer): Boolean;
    end;

implementation

uses
    DataModuleDB, frmConfigurationDocDialog, DataModuleAdditions, System.UITypes,
    SWNUtils, SWNConst, frmConfigurationCustomSumaDialog,
    frmConfigurationCustomCountDialog, SWNTypes, frmSelectGoodsToAddDialog,
    frmRascetKonfiguratiiDialog, SWNValueStorageUnit, frmKitTemplatesDialog,
    SWNDBErrors, frmDocumentDiscountDialog, frmCreateCustomNareadSborkaDialog,
    SWNSecurity, SWNSecurityFlags, SWNCommonDialogs, frmSelectPhoneNumberUnit,
    Vcl.Clipbrd, Vcl.Dialogs, uCreditFinalInfoDialog, frmKitchenTemplateUnit,
    frmDocumentImportBrowserDialog, System.Types, frmCustomerContractsDialog,
    frmGoodsQuickInfoDialog, frmDocumentBrowserDialog, frmCredit01Unit, frmGoodsForeignCodeDialog;

{$R *.dfm}

{ Tframe08ConfigurationBRK }

procedure Tframe08ConfigurationBRK.SaveFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
        SaveGridColumnsSettings(cxGridBRKDBTable);
        SaveGridColumnsSettings(cxGridComponentsTable);
        SaveGridColumnsSettings(cxGridComplectTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe08ConfigurationBRK.GoodsSelectionChanged;
var
    fGoodsAdd, fGoodsEdit, fGoodsDelete, fGoodsSelected: Boolean;
    fCalcConfig: Boolean;
    fAddFromKit, fInsertFromTemplate: Boolean;
    fAddToQTY: Boolean;
    fAddToSUMA, fKit, fMoveGoods: Boolean;
    //fpc1,fpc2,fpc3,fpc4,fpc5,fpcCust:Boolean;
    GoodsChanged: Boolean;
    FLG_CLOSED: Boolean;
begin
    fGoodsAdd := False;
    fGoodsEdit := False;
    fGoodsDelete := False;
    fGoodsSelected := False;
    fKit := False;

     // common
    fAddFromKit := False; // Добавить из комплекта
    fInsertFromTemplate := False; // Вставка из шаблона
     // specific: Goods
    fCalcConfig := False; // Расчет конфигурации
    fAddToQTY := False; // Изменение количество
    fAddToSUMA := False; // Изменение суммы комплектов
    fMoveGoods := False; // Переместить товары в комплект
    GoodsChanged := True;

    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fGoodsAdd := fSECURITY_CanEdit and not FLG_CLOSED; // New Goods + Security
        fInsertFromTemplate := fGoodsAdd;
        fAddFromKit := fGoodsAdd;

        if (cxGridComponentsTable.DataController.RecNo > 0) then
        begin
               // Состав
            fGoodsEdit := fGoodsAdd;   // Edit Goods + Security
            fGoodsDelete := fGoodsAdd; // Delete Goods + Security
            fKit := dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger);

            fCalcConfig := True; // Расчет конфигурации
            fAddToQTY := fGoodsAdd; // Изменение количество
            fAddToSUMA := fGoodsAdd; // Изменение суммы
            fMoveGoods := fKit; // Переместить товары в комплект
            fGoodsSelected := True;

            GoodsChanged := fLastGoodsID <> dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
            fLastGoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        end;
    end;
     // tab
    tbsKitContent.TabVisible := fKit;
     // goods
    bbGoodsNew.Enabled := fGoodsAdd;
    bbGoodsModify.Enabled := fGoodsEdit;
    bbGoodsDelete.Enabled := fGoodsDelete;
     // Инструменты, common
    bbAddFromKit.Enabled := fAddFromKit;                  // Добавить из комплекта
    bbInsertFromTemplate.Enabled := fInsertFromTemplate;  // Вставка из шаблона
     // Инструменты, Goods
    bbCalcKit.Enabled := fCalcConfig;                     // Расчет конфигурации
    bbAddToQTY.Enabled := fAddToQTY;                      // Изменение количество
    bbIncreaseSum.Enabled := fAddToSUMA;                  // Изменение суммы
    bbMoveGoodsInComplect.Enabled := fMoveGoods;
     // Колонки цен
    bbPriceColSelector.Enabled := fGoodsAdd;

    bbGoodsInfoCard.Enabled := fGoodsSelected;
    bbGoodsPrice.Enabled := fGoodsSelected;
    bbGoodsForeignCode.Enabled := fGoodsSelected;

    if GoodsChanged then
        cxPageControlComplect.ActivePage := tbsGoods;

    GoodsComplectSelectionChanged;
end;

procedure Tframe08ConfigurationBRK.ShowSetCustomQTYToGoodsDialog;
var
    dialog: TfrmConfigurationCustomCountDlg;
begin
    dialog := TfrmConfigurationCustomCountDlg.Create(Self);
    try
        dialog.InComplect := False;
        dialog.OptionType := ocSetCount;
        if dialog.ShowModal = mrOk then
        begin
            if DB_SetCustomQTYToGoods(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger, dialog.Value, dialog.OptionType = ocSetCount) then
            begin
                  // refresh data
                dmDB.FullRefresh;
                IBCQueryJurnalKit.Refresh;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowSetCustomQTYToGoodsInComplectDialog;
var
    dialog: TfrmConfigurationCustomCountDlg;
begin
    dialog := TfrmConfigurationCustomCountDlg.Create(Self);
    try
        dialog.InComplect := True;
        dialog.OptionType := ocSetCount;
        if dialog.ShowModal = mrOk then
        begin
            if DB_SetCustomQTYToGoodsInComplect(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger, dialog.Value, dialog.OptionType = ocSetCount, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger) then
            begin
                  // refresh data
                dmDB.FullRefresh;
                IBCQueryJurnalKit.Refresh;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowAddCustomSumaToGoodsDialog;
var
    AddAmount: Currency;
    dialog: TfrmConfigurationCustomSumaDlg;
    DocumentAmount: currency;
    NotUsedSuma: Currency;
    S: string;
begin
    dialog := TfrmConfigurationCustomSumaDlg.Create(Self);
    try
        dialog.InComplect := False;
        dialog.CurrencyTitle := dmDB.IBCQueryDocs.FieldByName('CURRENCY_NAME').AsString;
        dialog.Suma := cxGridComponentsTable.DataController.Summary.FooterSummaryValues[cxGridComponentsTable.DataController.Summary.FooterSummaryItems.IndexOfItemLink(cxGridDBCol_SUMA)];
        // update: pentru operatia "TVA inapoi", trebuie de luat numai suma componentelor finite
        dialog.SumaForTVA := GetSumaForTVA;
        dialog.AddedPercent := 12;

        if dialog.ShowModal = mrOk then
        begin
            DocumentAmount := dmdb.IBCQueryDocs.FieldByName('SUMA').AsCurrency;
            if dialog.rbPercent.Checked then
                AddAmount := (DocumentAmount * (dialog.AddedPercent / 100))
            else
                AddAmount := dialog.AddedSuma;

            if DB_AddCustomSumaToGoodsDialog(AddAmount, NotUsedSuma) then
            begin
                if NotUsedSuma <> 0 then
                begin
                    if (NotUsedSuma = dialog.AddedSuma) then
                        ShowErrorDialog('Oferte', 'Nu e posibil de distribuit suma!' + #13#10 + 'Suma trebuie sa fie mai mare.')
                    else
                    begin
                        S := 'Nu toata suma a fost distribuita uniform intre produse!' + #13#10 + #13#10 + Format('Suma initiala: %d', [dialog.AddedSuma]) + sLineBreak + Format('Suma distribuita: %f', [dialog.AddedSuma - NotUsedSuma]) + #13#10 + #13#10 + Format('Sold: %f', [NotUsedSuma]);
                        ShowWarningDialog('Modificare suma', S);
                    end;
                end;
                dmDB.FullRefresh;
            end;

        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowAddCustomSumaToGoodsInComplectDialog;
var
    dialog: TfrmConfigurationCustomSumaDlg;
    NotUsedSuma: Currency;
    S: string;
begin
    dialog := TfrmConfigurationCustomSumaDlg.Create(Self);
    try
        dialog.InComplect := True;
        dialog.CurrencyTitle := dmDB.IBCQueryDocs.FieldByName('CURRENCY_NAME').AsString;
        dialog.Suma := cxGridComplectTable.DataController.Summary.FooterSummaryValues[cxGridComplectTable.DataController.Summary.FooterSummaryItems.IndexOfItemLink(cxGridComplect_SUMA)];
        dialog.SumaForTVA := dialog.Suma;

        if dialog.ShowModal = mrOk then
        begin
            if DB_AddCustomSumaToGoodsInComplectDialog(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger, dialog.AddedSuma, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger, NotUsedSuma) then
            begin
                if NotUsedSuma <> 0 then
                begin
                    if (NotUsedSuma = dialog.AddedSuma) then
                        ShowErrorDialog('Oferte', 'Nu e posibil de distribuit suma!' + #13#10 + 'Suma trebuie sa fie mai mare.')
                    else
                    begin
                        S := 'Nu toata suma a fost distribuita!' + #13#10 + #13#10 + Format('Suma initiala: %d', [dialog.AddedSuma]) + #13#10 + Format('Suma distribuita: %f', [dialog.AddedSuma - NotUsedSuma]) + #13#10 + #13#10 + Format('Sold: %f', [NotUsedSuma]);
                        ShowWarningDialog('Suma modificata', S);
                    end;
                end;

                  // refresh
                dmDB.FullRefresh;
                IBCQueryJurnalKit.Refresh;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

function Tframe08ConfigurationBRK.DB_SetCustomQTYToGoods(const DocID: Integer; const Count: Double; const SetAsCount: Boolean): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE CUSTOMIZE_GOODSCOMPLECT_BYCNT2(:DOCID,:Count,:AddAsCount)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('Count').AsFloat := Count;
            Query.ParamByName('AddAsCount').AsInteger := Ord(SetAsCount);

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

function Tframe08ConfigurationBRK.DB_SetCustomQTYToGoodsInComplect(const DocID: Integer; const Count: Double; const SetAsCount: Boolean; const ParentGoodsID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE CUSTOMIZE_GOODSCOMPLECT_BYCNT2(:DOCID,:Count,:AddAsCount,:GoodsComplectID)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('Count').AsFloat := Count;
            Query.ParamByName('AddAsCount').AsInteger := Ord(SetAsCount);
            Query.ParamByName('GoodsComplectID').AsInteger := ParentGoodsID;

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

function Tframe08ConfigurationBRK.DB_AddCustomSumaToGoodsDialog(const Suma: Currency; var NotUsedSuma: Currency): Boolean;
var
    DocumentAmount: currency;
    Query: TIBCQuery;
begin
  // aflam care e suma documentului
    DocumentAmount := dmdb.IBCQueryDocs.FieldByName('Suma').AsFloat;
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'SELECT SUMARAMASA FROM CUSTOM_GOODSCOMPLECT_BY_SUMA2(:DOCID,:SUMA,NULL)';
            Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger;
            Query.ParamByName('SUMA').AsCurrency := Suma;
            Query.ExecSQL;
            if not Query.Eof then
            begin
                NotUsedSuma := Query.Fields[0].AsCurrency;
                Result := True;
            end;
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

function Tframe08ConfigurationBRK.DB_AddCustomSumaToGoodsInComplectDialog(const DocID: Integer; const Suma: Currency; const ParentGoodsID: Integer; var NotUsedSuma: Currency): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'SELECT SUMARAMASA FROM CUSTOM_GOODSCOMPLECT_BY_SUMA2(:DOCID,:SUMA,:ParentGoodsID)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('SUMA').AsCurrency := Suma;
            Query.ParamByName('PARENTGOODSID').AsInteger := ParentGoodsID;

            Query.ExecSQL;
            if not Query.Eof then
            begin
                NotUsedSuma := Query.Fields[0].AsCurrency;
                Result := True;
            end;
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

procedure Tframe08ConfigurationBRK.bbAddSumaToComplectClick(Sender: TObject);
begin
    ShowAddCustomSumaToGoodsInComplectDialog;
end;

procedure Tframe08ConfigurationBRK.bbAddToQTYClick(Sender: TObject);
begin
    ShowSetCustomQTYToGoodsDialog;
end;

procedure Tframe08ConfigurationBRK.bbAddToQTYComplectClick(Sender: TObject);
begin
    ShowSetCustomQTYToGoodsInComplectDialog;
end;

procedure Tframe08ConfigurationBRK.bbCalcKitClick(Sender: TObject);
begin
    ShowRascetKonfiguratiiDialog;
end;

procedure Tframe08ConfigurationBRK.bbCreditClick(Sender: TObject);
var
    d: TfrmCredit01Dlg;
begin
    d := TfrmCredit01Dlg.Create(self);
    try
        d.ShowModal;
    finally
        d.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.bbCustomerDebtsClick(Sender: TObject);
begin
    TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe08ConfigurationBRK.bbDocDiscountClick(Sender: TObject);
begin
    ShowDocumentDiscountDialog;
end;

procedure Tframe08ConfigurationBRK.bbFromAnotherDocumentClick(Sender: TObject);
var
    dialog: TfrmDocumentBrowserDlg;
    docid: integer;
begin
    dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
    try
        if dialog.ShowModal = mrOk then
        begin
            if ShowAskDialog('Import din document', Format('Doriti sa importati documentul №%d?', [dialog.DocID])) = mrYes then
            begin
                DoImportDocFromPrihod(dialog.DocID);
                ShowInfoDialog('Import', 'Documentul importat!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

function Tframe08ConfigurationBRK.DoImportDocFromPrihod(const DocID: integer): Integer;
var
    Query: TIBCQuery;
begin
    Result := 0;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_Jurnal (:DOCID, :current_docid)';
            Query.Params.ParamByName('DOCID').AsInteger := DocID;
            Query.Params.ParamByName('CURRENT_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            Query.ExecSQL;

            Query.Transaction.Commit;
            dmdb.IBCQueryJurnal.Refresh;
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

procedure Tframe08ConfigurationBRK.bbIncreaseSumClick(Sender: TObject);
begin
    ShowAddCustomSumaToGoodsDialog;
end;

procedure Tframe08ConfigurationBRK.bbInsertFromTemplateClick(Sender: TObject);
begin
    ShowSelectKitTemplateDialog;
end;

procedure Tframe08ConfigurationBRK.bbKitchenTemplateClick(Sender: TObject);
begin
    ShowKitchenTemplate;
end;

procedure Tframe08ConfigurationBRK.bbKitGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName('QTY').AsFloat);
end;

procedure Tframe08ConfigurationBRK.bbKitGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe08ConfigurationBRK.bbKitGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe08ConfigurationBRK.bbLivrareRepublicaClick(
  Sender: TObject);
begin
  // Livrare Moldova
  AddDelivery2Jurnal(122294);
end;

procedure Tframe08ConfigurationBRK.bbMoveGoodsInComplectClick(Sender: TObject);
begin
    if ShowAskDialog('Produsele din complect', Format('Doriti transferul produselor in complect"%s" ?', [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString])) <> mrYes then
        Exit;

    if DoMoveGoodsIntoComplect(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger) then
        RefreshData;
end;

procedure Tframe08ConfigurationBRK.bbAddFreeDeliveryClick(Sender: TObject);
begin
  AddDelivery2Jurnal(173080);
  dmdb.ibcqueryjurnal.Refresh;
  dmdb.IBCQueryDocs.RefreshRecord;

end;

procedure Tframe08ConfigurationBRK.bbAddFromKitClick(Sender: TObject);
begin
    KitAddGoodsFromComplect;
end;

procedure Tframe08ConfigurationBRK.bbGoodsModifyClick(Sender: TObject);
begin
    ShowModifyGoodsDialog;
end;

procedure Tframe08ConfigurationBRK.bbGoodsNewClick(Sender: TObject);
begin
    ShowAddNewGoodsDialog;
end;

procedure Tframe08ConfigurationBRK.bbGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe08ConfigurationBRK.bbPopup_CreateRashodClick(Sender: TObject);
begin
    CreateRashodnaiaNakladnaia;
end;

procedure Tframe08ConfigurationBRK.bbPopup_Menu2Click(Sender: TObject);
begin
    CreateRashodnaiaNakladnaiaServis;
end;

procedure Tframe08ConfigurationBRK.bbPopup_CreateScetClick(Sender: TObject);
begin
    CreateSciotNaOplatu;
end;

procedure Tframe08ConfigurationBRK.bbPriceCol1Click(Sender: TObject);
var
    PriceColumn: Integer;
    GoodsParentID: Integer;
    GoodsParentTitle: string;
    GoodsParentGoodsCount: Integer;
begin
    PriceColumn := TdxBarButton(Sender).Tag;
    GoodsParentID := -1;
    GoodsParentTitle := '';
    GoodsParentGoodsCount := 0;

    if cxPageControlComplect.ActivePage = tbsKitContent then
    begin
        GoodsParentID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger;
        GoodsParentTitle := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString;
        GoodsParentGoodsCount := IBCQueryJurnalKit.RecordCount;
    end;

    if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, GoodsParentID, PriceColumn, GoodsParentTitle, GoodsParentGoodsCount) then
        RefreshData;
end;

procedure Tframe08ConfigurationBRK.bbGoodsComplectAddClick(Sender: TObject);
begin
    ShowAddNewGoodsToComplectDialog;
end;

procedure Tframe08ConfigurationBRK.bbGoodsComplectDeleteClick(Sender: TObject);
begin
    DeleteSelectedGoodsInComplect;
end;

procedure Tframe08ConfigurationBRK.bbGoodsComplectEditClick(Sender: TObject);
begin
    ShowModifyGoodsInComplectDialog;
end;

procedure Tframe08ConfigurationBRK.bbGoodsDeleteClick(Sender: TObject);
begin
    DeleteSelectedGoods;
end;

procedure Tframe08ConfigurationBRK.bbGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('QTY').AsFloat);
end;

procedure Tframe08ConfigurationBRK.bbGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe08ConfigurationBRK.CloneRecord;
var
    S: string;
    newDocID: Integer;
begin
    S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
    if ShowAskDialog('Clonarea documentului', 'Clonarea configuratiei №' + S + '?') <> mrYes then
        Exit;

    if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
    begin
        dmDB.RefreshDocs;
        dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
        ShowInfoDialog('Clonarea documentului', 'O nou copie a fost creata.'#13#10'Configuratia №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString);
    end;
end;

procedure Tframe08ConfigurationBRK.CreateNewRecord;
var
    dialog: TfrmConfigurationDocDlg;
begin
    dialog := TfrmConfigurationDocDlg.Create(Self);
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

procedure Tframe08ConfigurationBRK.CreateNewRecordFromSip(CustomerPhone, CustomerName: string; CustomerID: Integer);
var
    dialog: TfrmConfigurationDocDlg;
    Query: TIBCQuery;
begin
    dialog := TfrmConfigurationDocDlg.Create(Self);
    Query := TIBCQuery.Create(Self);
    try
        dialog.CreateNewDocument := True;
        dialog.beCT_NAME.Tag := CustomerID;
        dialog.beCT_NAME.Text := CustomerName;
        dialog.NewComment := Format('%s (%s) - %s', [dmDB.CurrentUserFullName, DateToStr(Now), (CustomerName + ' ' + CustomerPhone)]);
        if dialog.ShowModal = mrOk then
        begin
            if not dmDB.IBCQueryDocs.UpdateTransaction.Active then
                dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;

            Query.Transaction := dmDB.IBCQueryDocs.UpdateTransaction;
            Query.AutoCommit := False;
            Query.SQL.Text := 'insert into tdb_docs_phones(docid, phonenumber) values (:docid, :phonenumber)';
            Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            Query.ParamByName('PHONENUMBER').AsString := CustomerPhone;
            try
                Query.Execute;

                dmDB.IBCQueryDocs.UpdateTransaction.Commit;
            except
                on e: Exception do
                begin
                    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                    raise;
                end;
            end;
            DocumentSelectionChanged;
        end;
    finally
        Query.Free;
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.CreateRashodnaiaNakladnaia;
var
    DocID: Integer;
    rashodDocID: Integer;
    createSborka: Boolean;
    S: string;
    dialog: TfrmCreateCustomNareadSborkaDlg;
    result: Integer;
    firma: Integer;
begin
    DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    result := 0; // nothing done
     // 1 - Расходная на  кладная была успешна создана
     // 2 - Расходная накладная была успешна создана! Внимание! Наряд на сборку не сделан.
     // 3 - Расходная накладная и Наряд на сборку были успешно созданны!
    if dmDB.DocumentHasComplecte(DocID) then
    begin
        createSborka := True;
        S := #13#10 + 'Atentie!' + #13#10 + 'In configuratie a fost gasite complecte pentru asamblare.';
        if ShowAskDialogVerification('Creaza document "Rezerva"', 'Doriti sa creati uun document "Rezerva"?' + #13#10 + S, 'Crearea documentului "Asamblarea"?', '', createSborka) = mrYes then
        begin
            rashodDocID := dmDB.CreateRashodnaiaNakladnaia_DB(DocID);
            if rashodDocID <> -1 then
            begin
                if createSborka then
                begin
                    dialog := TfrmCreateCustomNareadSborkaDlg.Create(Self);
                    try
                        if dialog.ShowModal = mrOk then
                        begin
                            firma := dmDB.CurrentFirma;
                            if dialog.IsCustomFirma then
                                firma := dialog.CustomFirma;

                            if dmDB.CreateNariadNaSborkuIzConfiguratora_DB(DocID, rashodDocID, firma) then
                                result := 3
                            else
                                result := 2;
                        end
                        else
                            result := 2;
                    finally
                        dialog.Free;
                    end;
                end
                else
                    result := 2;
            end;
        end
    end
    else
    begin
        rashodDocID := dmDB.CreateRashodnaiaNakladnaia_DB(DocID);
        if rashodDocID <> -1 then
            result := 1;
    end;

    case result of
//    1:
//      ShowInfoDialog('Rezerva', 'Document "Rezerva" a fost creat cu succes!');
        2:
            ShowInfoDialog('Rezerva', 'Document "Rezerva" a fost creat cu succes!'#13#10#13#10'Atentie! Asamblarea nu a fost creata.');
        3:
            ShowInfoDialog('Rezerva si Asamblarea', 'Documentele au fost create cu success!');
    end;

    dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe08ConfigurationBRK.CreateRashodnaiaNakladnaiaServis;
begin
     // Создать "Расходную накладную в сервис"
//  if ShowAskDialog('Создать "Расходную накладную в сервис"', 'Вы хотите создать расходную накладную в сервис ?') = mrYes then
    begin

        dmDB.CreateRashodnaiaNakladnaiaServis_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
//      ShowInfoDialog('Расходная накладная в сервис', 'Расходная накладная в сервис создана!');
    end;
end;

procedure Tframe08ConfigurationBRK.CreateSciotNaOplatu;
begin
     // Создать "Счет на оплату"
//  if ShowAskDialog('Creare document', 'Doriti sa creati documentul "Proforma" ?') = mrYes then
//  begin
    dmDB.CreateSciotNaOplatu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
//      ShowInfoDialog('Proforma', 'Document Proforma creat cu succes!');
//  end;
end;

procedure Tframe08ConfigurationBRK.cxGridBRKDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if AButton = mbLeft then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridBRKDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBRK_FLG_CLOSED.index]) then
    begin
        if AViewInfo.GridRecord.Values[cxGridBRK_FLG_CLOSED.index] = 0 then
        begin
            if not AViewInfo.Selected then
            begin
                    // Document prin contabilitate
                if AViewInfo.GridRecord.Values[cxGridBRK_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
            end;
        end
        else
        begin
            ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
            if not AViewInfo.Selected then
            begin
                if AViewInfo.GridRecord.Values[cxGridBRK_FLG_ACNT.Index] = 1 then
                    ACanvas.Font.Color := $008b8bc5
                else
                    ACanvas.Font.Color := clGrayText;
            end;
        end;
    end;

    if AViewInfo.GridRecord.Values[cxGridBRKDB_FLG_REZERVA.index] = 1 then
    begin
        ACanvas.Brush.Color := clWebLightCyan;
    end;

    if AViewInfo.GridRecord.Values[cxGridBRKDB_FLG_PROFORMA.index] = 1 then
    begin
        ACanvas.Brush.Color := clWebLightGreen;
    end;

     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $00C66300;
        ACanvas.Font.Color := clWhite;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridBRKDBTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridBRKDBTableData.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBRKDBTableData.Index]);
end;

procedure Tframe08ConfigurationBRK.cxGridBRKDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnutils.ProcessCommonKeys(self, cxGridBRKDBTable, Key, Shift);
end;

procedure Tframe08ConfigurationBRK.cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if bbGoodsComplectEdit.Enabled then
    begin
        ShowModifyGoodsInComplectDialog;
        AHandled := True;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    swnutils.ProcessCommonKeys(self, cxGridComplectTable, Key, Shift);
end;

procedure Tframe08ConfigurationBRK.cxGridComplectTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridComplect_STOCK_QTY.Index]) then
    begin
        if (ARecord.Values[cxGridComplect_STOCK_QTY.Index] <= 0) then
            AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if VarIsNumeric(ARecord.Values[Sender.Index]) and VarIsNumeric(ARecord.Values[cxGridComplect_UMID.Index]) then
    begin
        if (ARecord.Values[cxGridComplect_UMID.Index] = 1) then
            AText := StringReplace(AText, QtyReplaceMask, '', []);
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if bbGoodsModify.Enabled then
    begin
        ShowModifyGoodsDialog;
        AHandled := True;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;

    if AViewInfo.GridRecord.Values[cxGridDBCol_STOCK_QTY.Index] > 0 then
    begin
        ACanvas.Font.Style := ACanvas.Font.style + [fsBold];
    end;

    if not VarIsNull(AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index]) then
    begin
        if AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index] = 0 then
        begin
            if not AViewInfo.Selected then
            begin
                ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
            end;
        end
    end;
end;

function Tframe08ConfigurationBRK.CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
var
    i: Integer;
    col: TcxGridDBColumn;
begin
    GoodsID := -1;
    result := False;

    for i := 0 to Grid.ColumnCount - 1 do
    begin
        col := Grid.Columns[i];
        if (col.DataBinding.FieldName = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index]) then
        begin
            GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
            result := True;
            Break;
        end;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
    dialog: TfrmGoodsQuickInfoDlg;
    goodsid: Integer;
begin
   // F1
    if (Key = 112) and (Shift = []) then
    begin
        if CheckGridForGoodsIDValue(cxGridComponentsTable, goodsid) then
        begin
            dialog := TfrmGoodsQuickInfoDlg.Create(Self);
            try
                dialog.GoodsID := goodsid;
                dialog.OnAddGoods2Jurnal := AddGoods2Jurnal;
                dialog.ShowModal;
                dmDB.IBCQueryJurnal.Refresh;
            finally
                dialog.Free;
            end;
        end;
        Key := 0;
    end;

    swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe08ConfigurationBRK.AddGoods2Jurnal(AGoodsID: Integer);
var
    q: TIBCSQL;
begin
    q := TIBCSQL.Create(Self);
    try
        q.Transaction := dmDB.IBCTrDefaultUpdate;
        q.AutoCommit := False;
        if not q.Transaction.Active then
            q.Transaction.StartTransaction;

        q.SQL.Add('EXECUTE PROCEDURE ADD_GOODS2JURNAL(:DOCID, -1, :GOODSID)');
        q.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        q.ParamByName('GOODSID').AsInteger := AGoodsID;
        q.Execute;
        q.Transaction.Commit;
    finally
        q.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridDBCol_STOCK_QTY.Index]) then
    begin
        if (ARecord.Values[cxGridDBCol_STOCK_QTY.Index] <= 0) then
            AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
    N: Integer;
begin
    if VarIsNumeric(ARecord.Values[cxGridComponents_PRICE_COLUMN.Index]) then
    begin
        N := ARecord.Values[cxGridComponents_PRICE_COLUMN.Index];
        if (N <= 0) or (N >= 4) then
            AStyle := dmAdditions.cxStyle_GridPriceColumnRed;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridDBCol_GOODS_NAMEStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridDBCol_GOODS_TYPE_ID.Index]) then
    begin
        if (dmDB.IsKit(ARecord.Values[cxGridDBCol_GOODS_TYPE_ID.Index])) then
            AStyle := dmAdditions.cxStyle_Bold;
    end;
end;

procedure Tframe08ConfigurationBRK.cxGridDBCol_STOCK_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
    if VarIsNumeric(ARecord.Values[Sender.Index]) and VarIsNumeric(ARecord.Values[cxGridComponents_UMID.Index]) then
    begin
        if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
            AText := StringReplace(AText, QtyReplaceMask, '', []);
    end;
end;

procedure Tframe08ConfigurationBRK.DeleteRecord;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_Конфигуратор, [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
    begin
        dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
        try
            dmDB.IBCQueryDocs.Delete;
            dmDB.IBCQueryDocs.UpdateTransaction.Commit;
        except
            on E: Exception do
            begin
                dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    end;
end;

procedure Tframe08ConfigurationBRK.DocumentSelectionChanged;
var
    fDocNew, fDocEdit, fDocDelete, fDebts: Boolean;
    FLG_CLOSED, DocChanged: Boolean;
begin
    fDocNew := fSECURITY_CanNew;
    fDocEdit := False;
    fDocDelete := False;

    fDebts := False;

    DocChanged := True;

    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;
        fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;

        DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

        fDebts := True;
    end;
     // doc
    ButtonStateChanged(fbtADD, fDocNew);
    ButtonStateChanged(fbtMODIFY, fDocEdit);
    ButtonStateChanged(fbtDELETE, fDocDelete);
     // tab
    if DocChanged then
        cxPageControlComplect.ActivePage := tbsGoods;

     // popup menu
    bbCustomerDebts.Enabled := fDebts;

    GoodsSelectionChanged;
end;

procedure Tframe08ConfigurationBRK.DoFrameHide;
begin
     // inchidem datele interne
    IBCQueryJurnalKit.Close;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGridBRKDBTable.OnFocusedRecordChanged := nil;
    cxGridComponentsTable.OnFocusedRecordChanged := nil;
    cxGridComplectTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGridComplectTable.DataController.DataSource := nil;
    cxGridComponentsTable.DataController.DataSource := nil;
    cxGridBRKDBTable.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe08ConfigurationBRK.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

    fLastDocID := -1;
    fLastGoodsID := -1;
    cxPageControlComplect.ActivePageIndex := 0;


     // 1. Legam grid-urile de datasource-sele
    cxGridBRKDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;
    cxGridComplectTable.DataController.DataSource := IBCDataSourceJurnalKit;

     // 2. Selection handlers
    cxGridBRKDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
    cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
    cxGridComplectTable.OnFocusedRecordChanged := WhenGoodsComplectGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
    IBCQueryJurnalKit.Active := True;
    dmDB.IBCQueryAchizitii.Active := True;

     // 4. Selection update
    DocumentSelectionChanged;
end;

function Tframe08ConfigurationBRK.DoMoveGoodsIntoComplect(const DocID, GoodsID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.SQL.Text := 'EXECUTE PROCEDURE SP_CONF_MOVEGOODS(:DOC,:GOODS)';
        Query.ParamByName('DOC').AsInteger := DocID;
        Query.ParamByName('GOODS').AsInteger := GoodsID;
        Query.Transaction.StartTransaction;
        try
            Query.Execute;
            Query.Transaction.Commit;
            result := True;
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

procedure Tframe08ConfigurationBRK.bbTenderClick(Sender: TObject);
begin
     // Создать Документ Тендер
    if ShowAskDialog('Creare document', 'Doriti sa creati documentul "Tender" ?') = mrYes then
    begin
        if dmDB.CreateTender(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
            ShowInfoDialog('Oferta pentru Tender', 'Documentul a fost creat cu succes!');
    end;
end;

procedure Tframe08ConfigurationBRK.bbTVA0Click(Sender: TObject);
begin
    dmDB.ExecuteQuery('execute procedure setvat0(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    dmDB.IBCQueryDocs.Refresh;
    dmDB.IBCQueryJurnal.Refresh;
end;

procedure Tframe08ConfigurationBRK.btnVinzarePartenerClick(Sender: TObject);
var
    DocID: Integer;
    rashodDocID: Integer;
    createSborka: Boolean;
    S: string;
    dialog: TfrmCreateCustomNareadSborkaDlg;
    result: Integer;
    firma: Integer;
begin
    DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    result := 0; // nothing done
    rashodDocID := CreateVinzarePartener(DocID);

    dmDB.IBCQueryDocs.Refresh;
end;

function Tframe08ConfigurationBRK.CreateVinzarePartener(DocID: Integer):
    Integer;
begin
var
  Query: TIBCQuery;
  Result := -1;

  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmdb.IBCTrDefaultUpdate;
    Query.SQL.Text := 'SELECT RASHDOCID FROM SP_CREATE_VINZARE_PARTENER(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      if not Query.Eof then
        Result := Query.Fields[0].AsInteger;
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

procedure Tframe08ConfigurationBRK.dxBarButton10Click(Sender: TObject);
begin
    inherited;
    dmDB.ExecuteQuery('execute procedure setvat0_v1(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    dmDB.IBCQueryDocs.Refresh;
    dmDB.IBCQueryJurnal.Refresh;
end;

procedure Tframe08ConfigurationBRK.dxBarButton11Click(Sender: TObject);
begin
    dmdb.IBCQueryJurnal.First;
    while not dmdb.IBCQueryJurnal.Eof do
    begin
        dmdb.IBCQueryJurnal.Edit;
        dmdb.IBCQueryJurnal.FieldByName('price').AsFloat := Round(dmdb.IBCQueryJurnal.FieldByName('price').AsFloat);
        dmdb.IBCQueryJurnal.Next;
    end;
end;

procedure Tframe08ConfigurationBRK.dxBarButton12Click(Sender: TObject);
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select vat from tdb_contracts where contractid = :contractid';
        q.ParamByName('contractid').AsInteger := dmdb.ibcQueryDocs.FieldByName('CONTRACTID').AsInteger;
        q.Open;
        if q.FieldByName('VAT').AsInteger > 0 then
            raise Exception.Create('Contractul trebuie sa fie cu TVA 0!');
    finally
        q.Free;
    end;

    dmdb.ibcqueryjurnal.DisableControls;
    try
        dmdb.ibcqueryjurnal.First;
        try
            q := TIBCQuery.Create(nil);
            try
                q.SQL.Text := 'select cast(price1_lei/price7_lei as dm_amount) margin from web_get_goods_min_info(:goodsid)';
                q.Prepare;

                while not dmdb.ibcqueryjurnal.Eof do
                begin

                    q.ParamByName('goodsid').AsInteger := dmdb.ibcqueryjurnal.FieldByName('goodsid').AsInteger;
                    q.Open;
                    dmdb.ibcqueryjurnal.Edit;
                    if q.FieldByName('margin').AsFloat < 1.2 then
                        dmdb.ibcqueryjurnal.FieldByName('Price').AsFloat := Round((dmdb.ibcqueryjurnal.FieldByName('Price').AsFloat * 1.12) / 1.2)
                    else
                        dmdb.ibcqueryjurnal.FieldByName('Price').AsFloat := Round((dmdb.ibcqueryjurnal.FieldByName('Price').AsFloat) / 1.2);
                    dmdb.ibcqueryjurnal.FieldByName('SUMAVAT').AsFloat := 0;
                    dmdb.ibcqueryjurnal.Post;
                    q.Close;
                    dmdb.ibcqueryjurnal.Next;
                end;
            finally
                q.Free;
            end;

            if dmdb.ibcqueryjurnal.UpdateTransaction.Active then
                dmdb.ibcqueryjurnal.UpdateTransaction.Commit;

        except
            begin
                dmdb.ibcqueryjurnal.UpdateTransaction.Rollback;
                raise;
            end;
        end;
    finally
        dmdb.ibcqueryjurnal.EnableControls;

    end;
end;

procedure Tframe08ConfigurationBRK.dxBarButton13Click(Sender: TObject);
begin
  dmdb.GetSupplierGoodsByDocID;
end;

procedure Tframe08ConfigurationBRK.dxBarButton14Click(Sender: TObject);
begin
  var d:=TfrmGoodsForeignCodeDlg.Create(self);
  try
    d.GoodsID := dmdb.IBCQueryJurnal.FieldByName('goodsid').AsInteger;
    if d.ShowModal=mrOK then
    begin
       dmdb.AddToAchizitii(d.GoodsID, dmdb.IBCQueryJurnal.fieldByname('qty').AsInteger, d.SupplierID);
    end;
  finally
    d.Free;
  end;
end;

procedure Tframe08ConfigurationBRK.dxBarButton1Click(Sender: TObject);
var
    list: TStringList;
    i: Integer;
    goodsid: string;
    qty: string;
    clipboard_array: TArray<string>;
begin
    list := TStringList.Create;
    dmDB.IBCQueryJurnal.DisableControls;
    try
        list.Text := Clipboard.AsText;
        if not dmDB.IBCQueryJurnal.UpdateTransaction.Active then
        begin
            for i := 0 to list.Count - 1 do
            begin
                clipboard_array := list[i].Split([#9]);
                goodsid := clipboard_array[0];

                try
                    qty := clipboard_array[1];
                except
                    qty := '1';
                end;

                with dmDB.IBCQueryJurnal do
                begin
                    Append;
                    try
                        FieldByName('GoodsID').AsString := goodsid;
                        FieldByName('QTY').AsString := qty;
                        FieldByName('DTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
                        FieldByName('CTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger;
                        FieldByName('UMID').AsInteger := 1;
                        FieldByName('WARRANTY').AsInteger := 12;
                        FieldByName('FLG_ACTIVE').AsInteger := 1;
                        FieldByName('PRICE').AsFloat := 0;
                        FieldByName('GOODSCOMPLECT_ID').AsInteger := -1;
                        Post;
                    except
                        on e: Exception do
                        begin
                            cancel;
                            dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
                            raise;
                        end;
                    end;
                end;
            end;
            dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
        end;
        dmDB.IBCQueryJurnal.Refresh;
    finally
        list.Free;
        dmDB.IBCQueryJurnal.EnableControls;
    end;
end;

procedure Tframe08ConfigurationBRK.dxBarButton3Click(Sender: TObject);
var
    dialog: TfrmCreditFinalInfoDialog;
    i: Integer;
    ListOfGoodsID: TStringList;
begin
    dialog := TfrmCreditFinalInfoDialog.Create(Self, dmDB.IBCConnection);
    ListOfGoodsID := TStringList.Create;
    try
        for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
        begin
            ListOfGoodsID.Add(IntToStr(cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index]));
        end;
        dialog.ListOfGoodsID := ListOfGoodsID.CommaText;
        dialog.SumaCredit := dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat;
        dialog.ShowModal;
    finally
        dialog.Free;
        ListOfGoodsID.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.dxBarButton4Click(Sender: TObject);
begin
    dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, '');
end;

procedure Tframe08ConfigurationBRK.dxBarButton5Click(Sender: TObject);
begin
    inherited;
    dmDB.IBCTrDefaultUpdate.StartTransaction;
    dmDB.IBCQueryDocs.Edit;
    dmDB.IBCQueryDocs.FieldByName('FLG_UPDATE_DATE').AsInteger := (1 - dmDB.IBCQueryDocs.FieldByName('FLG_UPDATE_DATE').AsInteger);
    dmDB.IBCQueryDocs.Post;
    dmDB.IBCTrDefaultUpdate.Commit;
end;

procedure Tframe08ConfigurationBRK.dxBarButton6Click(Sender: TObject);
begin
    ShowImportFromDocumentDialog;
end;

procedure Tframe08ConfigurationBRK.dxBarButton8Click(Sender: TObject);
var
    CustomerName: string;
begin
    inherited;
    CustomerName := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    if InputQuery('SWN', 'Numele nou al clientului: ', CustomerName) then
    begin

        dmDB.ExecuteQuery('update ts_customer set name = :customername where customerid = :customerid', [CustomerName, dmDB.IBCQueryDocs.FieldByName('CT').AsInteger]);
        dmDB.IBCQueryDocs.Refresh;
    end;

end;

procedure Tframe08ConfigurationBRK.dxBarButton9Click(Sender: TObject);
var
    sList: TStringList;
    GoodsID: string;
    i: Integer;
    qty: string;
    Price: string;
    Cells: TStringDynArray;
begin
    sList := TStringList.Create;
    try
        sList.Text := Clipboard.AsText;

        if not dmDB.IBCTrDefaultUpdate.Active then
            dmDB.IBCTrDefaultUpdate.StartTransaction;
        for i := 0 to sList.Count - 1 do
        begin
            Cells := Split(sList.Strings[i], #9);
            GoodsID := Cells[0];
            qty := Cells[1];
            Price := Cells[2];
//      sList.Strings[i] := Copy(sList.Strings[i], Pos(#9, sList.Strings[i]), Length(sList.Strings[i]));
//    Qty := Copy(sList.Strings[i], 1, Pos(#9, sList.Strings[i])-1);
//      sList.Strings[i] := Copy(sList.Strings[i], Pos(#9, sList.Strings[i]), Length(sList.Strings[i]));
//    Price := Copy(sList.Strings[i], 1, Length(sList.Strings[i]));
            IBCQueryJurnalKit.Append;
            IBCQueryJurnalKit.FieldByName('GoodsID').AsString := GoodsID;
            IBCQueryJurnalKit.FieldByName('QTY').AsString := qty;
            IBCQueryJurnalKit.FieldByName('PRICE').AsString := Price;
            IBCQueryJurnalKit.FieldByName('UMID').AsInteger := 1;
            IBCQueryJurnalKit.FieldByName('WARRANTY').AsInteger := 24;
            IBCQueryJurnalKit.Post;
        end;
        dmDB.IBCTrDefaultUpdate.Commit;
        ShowMessage('Finisat cu success!');
    finally
        sList.free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowImportFromDocumentDialog;
var
    dialog: TfrmDocumentImportBrowserDlg;
begin
    dialog := TfrmDocumentImportBrowserDlg.Create(Self);
    try
        dialog.DefaultDocTypeID := cDBID_DocType_КОНФИГУРАЦИИ_К;
        dialog.DefaultUserID := dmDB.CurrentUserID;

        dialog.DocTypeList.Add(cDBID_DocType_КОНФИГУРАЦИИ_К);
        dialog.DocTypeList.Add(cDBID_DocType_НАКЛАДНЫЕ_ПН);

        if dialog.SelectDoc then
        begin
            if DocActionDB_ImportFromDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.DocID) then
            begin
                dmDB.IBCQueryDocs.Refresh;
                IBCQueryJurnalKit.Refresh;
                ShowInfoDialog('Import', 'Finsat cu succes!');
            end;
        end;
    finally
        dialog.Free;
    end;
end;

function Tframe08ConfigurationBRK.DocActionDB_ImportFromDocument(TargetDocID: Integer; const SourceDocID: Integer): Boolean;
var
    Query: TIBCQuery;
begin
    result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.AutoCommit := False;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_FROM_DOC(:TARGET_DOCID, :SOURCE_DOCID, :COMPLECTID)';
            Query.ParamByName('TARGET_DOCID').AsInteger := TargetDocID;
            Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
            Query.ParamByName('COMPLECTID').AsInteger := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
            Query.ExecSQL;
            result := True;
            dmDB.IBCTrDefaultUpdate.Commit;
        except
            on E: Exception do
                if not ProcessSWNError(E) then
                    raise;
        end;
    finally
        Query.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.dxPopupMenuRBKPopup(Sender: TObject);
begin
    WhenDocumentPopupMenu;
end;

function Tframe08ConfigurationBRK.GetCurrentSearchContext: TSearchContextValue;
begin
    result := inherited;

    if cxGridComponentsTable.Site.Focused then
    begin
          // context from Jurnal: Код + Наименование
        result.Context := ffGoods;
        result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
        result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
    end
    else if cxGridBRKDBTable.Site.Focused then
    begin
              // context from Docs
        if cxGridBRKDB_CT_NAME.Focused then
        begin
                   // Контрагент
            result.Context := ffCustomer;
            result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridBRKDBTableData.Focused then
        begin
                       // Дата
            result.Context := ffDate;
            result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end
        else if cxGridBRKDB_DTDEP_NAME.Focused then
        begin
                           // Склад
            result.Context := ffStock;
            result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
            result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
        end;
    end
end;

function Tframe08ConfigurationBRK.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    result := [fedsDocs, fedsJurnal];
end;

function Tframe08ConfigurationBRK.GetFilterFields: TFrameFilterFields;
begin
    result := [ffDate, ffCustomer, ffGoods, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe08ConfigurationBRK.GetFrameButtons: TFrameButtons;
begin
    result := [fbtREFRESH, fbtDial];
    if fSECURITY_CanNew then
        result := result + [fbtADD, fbtCLONE];
    if fSECURITY_CanEdit then
        result := result + [fbtMODIFY];
    if fSECURITY_CanDelete then
        result := result + [fbtDELETE];
end;

function Tframe08ConfigurationBRK.GetSumaForTVA: Integer;
var
    i: Integer;
begin
    result := 0;
    for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
    begin
        if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_FLG_HAS_COMPLECT_GOODS.Index] = 0 then
            result := result + cxGridComponentsTable.DataController.Values[i, cxGridDBCol_SUMA.Index];
    end;
end;

procedure Tframe08ConfigurationBRK.GoodsComplectSelectionChanged;
var
    fGoodsComplectAdd, fGoodsComplectEdit, fGoodsComplectDelete: Boolean;
    fAddFromKit, fGoodsSelected: Boolean;
    fAddToQTYComplect: Boolean;
    fAddToSUMAInComplect: Boolean;
begin
    fGoodsComplectAdd := False;
    fGoodsComplectEdit := False;
    fGoodsComplectDelete := False;

     // common
    fAddFromKit := False; // Добавить из комплекта
     // specific: Complect
    fAddToQTYComplect := False; // Изменение количество
    fAddToSUMAInComplect := False;
    fGoodsSelected := False;

    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
        if (cxGridComponentsTable.DataController.RecNo > 0) then
        begin
            if (dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger)) then // Комплект
            begin
                    // --Комплектация--
                fAddFromKit := fSECURITY_CanEdit;
                fGoodsComplectAdd := fSECURITY_CanEdit;

                if (cxGridComplectTable.DataController.RecNo > 0) then
                begin
                    fGoodsComplectEdit := fSECURITY_CanEdit;
                    fGoodsComplectDelete := fSECURITY_CanEdit;
                    fAddToQTYComplect := fSECURITY_CanEdit;
                    fAddToSUMAInComplect := fSECURITY_CanEdit;
                    fGoodsSelected := True;
                end;

            end;
        end;
    end;

  // goods in complect
    bbGoodsComplectAdd.Enabled := fGoodsComplectAdd;
    bbGoodsComplectEdit.Enabled := fGoodsComplectEdit;
    bbGoodsComplectDelete.Enabled := fGoodsComplectDelete;

  // Инструменты
    bbAddFromKit.Enabled := fAddFromKit;                  // Добавить из комплекта
    bbAddToQTYComplect.Enabled := fAddToQTYComplect;      // Изменение количество
    bbAddSumaToComplect.Enabled := fAddToSUMAInComplect;  // Изменение суммы в комплекте
    bbKitGoodsInfoCard.Enabled := fGoodsSelected;
    bbKitGoodsPrice.Enabled := fGoodsSelected;
    bbKitGoodsForeignCode.Enabled := fGoodsSelected;
end;

function Tframe08ConfigurationBRK.InitFrameID: Integer;
begin
  // КОНФИГУРАЦИИ. Быстрый расчет конфигурации
    result := 8;

    dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
    dmDB.CreateGridImageColumnItems(cxGridComplect_IMG);

    SetupQtyFields;
end;

procedure Tframe08ConfigurationBRK.KitAddGoodsFromComplect;
var
    Allow: Boolean;
    ClearAll: Boolean;
    RecordsAdded: Integer;
begin
    ClearAll := True;
     // ask for options
    if IBCQueryJurnalKit.RecordCount > 0 then
        Allow := ShowAskDialogVerification('Complect', 'Adauga produsele din complect in oferta?', 'Sterge produsele curente?', Format('Complecte: %s', [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]), ClearAll) = mrYes
    else
        Allow := True;

    if Allow then
    begin
        RecordsAdded := KitAddGoodsFromComplectDB(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger, ClearAll);
        if (RecordsAdded <= 0) then
            ShowErrorDialog('Oferte', 'In complect lipsesc produsele!', 'Verificati completarea din nomenclatorul de produse.')
        else
        begin
            dmDB.FullRefresh;
            IBCQueryJurnalKit.Refresh;
            ShowInfoDialog('Oferte', Format('Adaugat cu succes %d de produse', [RecordsAdded]));
        end;
    end;
end;

function Tframe08ConfigurationBRK.KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const RemoveExisting: Boolean): Integer;
var
    Query: TIBCQuery;
begin
    result := -1;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;

        Query.SQL.Text := 'SELECT RECORDSADDED FROM CREATE_GOODSCOMPLECT(:DOCID,:GOODSID,:REMOVEEXISTING)';
        Query.ParamByName('DOCID').AsInteger := DocID;
        Query.ParamByName('GOODSID').AsInteger := GoodsID;
        Query.ParamByName('REMOVEEXISTING').AsInteger := Ord(RemoveExisting);

        Query.Transaction.StartTransaction;
        try
            Query.ExecSQL;
            if not Query.Eof then
                result := Query.Fields[0].AsInteger;
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

procedure Tframe08ConfigurationBRK.KitAddGoodsFromTemplate(const TemplateID: Integer; const TemplateName: string);
var
    Allow: Boolean;
    ClearAll: Boolean;
begin
    ClearAll := True;
     // ask for options
    if dmDB.IBCQueryJurnal.RecordCount > 0 then
        Allow := ShowAskDialogVerification('Oferte', 'Adauga produse din template"' + TemplateName + '" in oferta curenta?', 'sterge produsele existente', '', ClearAll) = mrYes
    else
        Allow := True;

    if Allow then
    begin
        if KitAddGoodsFromTemplateDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, TemplateID, ClearAll) then
        begin
            dmDB.FullRefresh;
            ShowInfoDialog('Oferte', 'Adaugat cu succes!');
        end;
    end;
end;

function Tframe08ConfigurationBRK.KitAddGoodsFromTemplateDB(const DocID, TemplateID: Integer; const RemoveExisting: Boolean): Boolean;
var
    Query: TIBCQuery;
begin
    result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'EXECUTE PROCEDURE CREATE_GOODSCOMPLECT_TEMPLATED(:DOCID, :KITTEMPLATEID, :REMOVEEXISTING)';
            Query.ParamByName('DOCID').AsInteger := DocID;
            Query.ParamByName('KITTEMPLATEID').AsInteger := TemplateID;
            Query.ParamByName('REMOVEEXISTING').asInteger := Ord(RemoveExisting);

            Query.ExecSQL;
            Query.Transaction.Commit;
            result := True;

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

procedure Tframe08ConfigurationBRK.ModifyRecord;
var
    dialog: TfrmConfigurationDocDlg;
begin
    if not fSECURITY_CanEdit then
        Exit;

    dialog := TfrmConfigurationDocDlg.Create(Self);
    try
        dialog.CreateNewDocument := False;
        if dialog.ShowModal = mrOK then
        begin
            dmdb.IBCQueryDocComments.Refresh;
            dmdb.IBCQueryJurnal.Refresh;
        end
    finally
        dialog.Free;

    end;
end;

procedure Tframe08ConfigurationBRK.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
        ReadGridColumnsSettings(cxGridBRKDBTable);
        ReadGridColumnsSettings(cxGridComponentsTable);
        ReadGridColumnsSettings(cxGridComplectTable);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe08ConfigurationBRK.RefreshData;
begin
    inherited;
    IBCQueryJurnalKit.Refresh;
end;

procedure Tframe08ConfigurationBRK.RefreshFromComplect;
var
    GoodsID, GoodsID2, tabIndex: Integer;
begin
    GoodsID2 := IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger;
    GoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    tabIndex := cxPageControlComplect.ActivePageIndex;

    IBCQueryJurnalKit.DisableControls;
    dmDB.IBCQueryJurnal.DisableControls;
    try
        // refresh
        dmDB.IBCQueryDocs.Refresh;
        dmDB.IBCQueryJurnal.Refresh;
        // reposition
        dmDB.IBCQueryJurnal.Locate('GOODSID', GoodsID, []);
        cxPageControlComplect.ActivePageIndex := tabIndex;
        IBCQueryJurnalKit.Locate('GOODSID', GoodsID2, []);
    finally
        IBCQueryJurnalKit.EnableControls;
        dmDB.IBCQueryJurnal.EnableControls;
    end;
end;

procedure Tframe08ConfigurationBRK.RefreshFromComplectDelete;
var
    GoodsID, tabIndex: Integer;
begin
    GoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    tabIndex := cxPageControlComplect.ActivePageIndex;

    IBCQueryJurnalKit.DisableControls;
    dmDB.IBCQueryJurnal.DisableControls;
    try
        // refresh
        dmDB.IBCQueryDocs.Refresh;
        dmDB.IBCQueryJurnal.Refresh;
        // reposition
        dmDB.IBCQueryJurnal.Locate('GOODSID', GoodsID, []);
        cxPageControlComplect.ActivePageIndex := tabIndex;
    finally
        IBCQueryJurnalKit.EnableControls;
        dmDB.IBCQueryJurnal.EnableControls;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowAddNewGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := True;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowAddNewGoodsToComplectDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExistsInComplect;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := True;
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryJurnalKit.Refresh;
            RefreshFromComplect;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowDocumentDiscountDialog;
var
    dialog: TfrmDocumentDiscountDlg;
begin
    dialog := TfrmDocumentDiscountDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowModifyGoodsDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := False;
        if dialog.ShowModal = mrOk then
            dmDB.IBCQueryDocs.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowModifyGoodsInComplectDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExistsInComplect;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := False;
        if dialog.ShowModal = mrOk then
        begin
            IBCQueryJurnalKit.Refresh;
            RefreshFromComplect;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowRascetKonfiguratiiDialog;
var
    dialog: TfrmRascetKonfiguratiiDlg;
begin
     // Расчет конфигурации
    dialog := TfrmRascetKonfiguratiiDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.DeleteSelectedGoods;
var
    S, S2: string;
    flag: Boolean;
begin
     // confirmation flag
    flag := AppUserConfigStorage.Confirmations.GetValue('ASK_GoodsDelete');
    if not flag then
    begin
        if dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').asInteger) then
            S2 := 'Produsele din complect vor fi sterse!'
        else
            S2 := '';

        S := Format(cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации, [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString]);
          // confirmation
        if ShowAskDialogVerification(cMSG_DELETERECORD_DeleteGoods, S, cMSG_CONFIRMATION_DoNotAskAgain, S2, flag) <> mrYes then
            Exit;
        AppUserConfigStorage.Confirmations.SetValue('ASK_GoodsDelete', flag);
    end;

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

procedure Tframe08ConfigurationBRK.DeleteSelectedGoodsInComplect;
var
    S, S2: string;
    flag: Boolean;
begin
     // confirmation flag
    flag := AppUserConfigStorage.Confirmations.GetValue('ASK_GoodsDelete');
    if not flag then
    begin
        S2 := 'Complect: ' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString;
        S := Format(cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации2, [IBCQueryJurnalKit.FieldByName('GOODS_NAME').asString]);

        if ShowAskDialogVerification(cMSG_DELETERECORD_DeleteGoods, S, cMSG_CONFIRMATION_DoNotAskAgain, S2, flag) <> mrYes then
            Exit;
        AppUserConfigStorage.Confirmations.SetValue('ASK_GoodsDelete', flag);
    end;

    IBCQueryJurnalKit.UpdateTransaction.StartTransaction;
    try
        IBCQueryJurnalKit.Delete;
        IBCQueryJurnalKit.UpdateTransaction.Commit;
        IBCQueryJurnalKit.Refresh;
        RefreshFromComplectDelete;
    except
        on E: Exception do
        begin
            IBCQueryJurnalKit.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

function Tframe08ConfigurationBRK.GetPhoneNumber;
begin
    inherited;
    result := '';
    frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
    try
        frmSelectPhoneNumber.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
        if frmSelectPhoneNumber.ShowModal = mrOk then
        begin
            result := frmSelectPhoneNumber.SelectedPhoneNumber;
        end;
    finally
        frmSelectPhoneNumber.Free;
    end;
end;

procedure Tframe08ConfigurationBRK.ShowSelectKitTemplateDialog;
var
    kitTemplates: TfrmKitTemplatesDlg;
begin
    kitTemplates := TfrmKitTemplatesDlg.Create(Self, dmDB.IBCConnection);
    try
        if kitTemplates.ShowModal = mrOk then
        begin
            KitAddGoodsFromTemplate(kitTemplates.KitTemplateID, kitTemplates.KitTemplateName);
        end;
    finally
        kitTemplates.Free;
    end;
end;

function Tframe08ConfigurationBRK.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
var
    i: Integer;
begin
    result := False;
    for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
    begin
        if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
        begin
            result := True;
            Break;
        end;
    end;
end;

function Tframe08ConfigurationBRK.WhenCheckIfGoodsExistsInComplect(const GoodsID: Integer): Boolean;
var
    i: Integer;
begin
    result := False;
    for i := 0 to cxGridComplectTable.DataController.RecordCount - 1 do
    begin
        if cxGridComplectTable.DataController.Values[i, cxGridComplect_GOODSID.Index] = GoodsID then
        begin
            result := True;
            Break;
        end;
    end;
end;

procedure Tframe08ConfigurationBRK.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe08ConfigurationBRK.WhenDocumentPopupMenu;
var
    fPopup1, fPopup2, fPopup3, fDiscount: Boolean;
begin
    fPopup1 := False;     // Создать "Расходную накладную"
    fPopup2 := False;     // Создать "Расходную накладную в сервис"
    fPopup3 := False;     // Создать "Счет на оплату" + Security
    fDiscount := False; // Скидка
    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
          // Создать "Расходную накладную"
        fPopup1 := True;
          // Создать "Расходную накладную в сервис"
        fPopup2 := True;
          // Создать "Счет на оплату" + Security
        fPopup3 := ((dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger = 498)); // Valuta = MDL
          // Скидка
        fDiscount := dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat > 0;
    end;
     // popup
    bbPopup_CreateRashod.Enabled := fPopup1;  // Создать "Расходную накладную"
    bbPopup_Menu2.Enabled := fPopup2;  // Создать "Расходную накладную в сервис"
    bbPopup_CreateScet.Enabled := fPopup3;  // Создать "Счет на оплату"
    bbDocDiscount.Enabled := fDiscount;
end;

procedure Tframe08ConfigurationBRK.WhenGoodsComplectGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsComplectSelectionChanged;
end;

procedure Tframe08ConfigurationBRK.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsSelectionChanged;
end;

procedure Tframe08ConfigurationBRK.SetupDefaultFocus;
begin
     // grid
    cxGridBRK.SetFocus;
     // columns
    cxGridBRKDB_CT_NAME.Focused := True;
    cxGridDBCol_GOODS_NAME.Focused := True;
    cxGridComplect_GOODS_NAME.Focused := True;
end;

procedure Tframe08ConfigurationBRK.SetupQtyFields;
begin
     // Состав: Кол-во
    TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
    cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Состав: Остаток
    TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
     // Комплектация: Кол-во
    TcxCalcEditProperties(cxGridComplect_QTY.Properties).DisplayFormat := QtyDisplayFormat;
    cxGridComplect_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Комплектация: Остаток
    TcxCalcEditProperties(cxGridComplect_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe08ConfigurationBRK.SetupSecurityItems;
begin
    fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Просмотр);
    fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Создать);
    fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Изменить);
    fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Удалить);

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

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Видеть_колонку_цен) or SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridComponents_PRICE_COLUMN.Visible := False;
        cxGridComponents_PRICE_COLUMN.VisibleForCustomization := False;
    end;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_Oferte_Calcul_TVA_0) then
        bbTVA0.Visible := ivNever;

     // Создать "Счет на оплату"
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_СНО_Создать) then
        bbPopup_CreateScet.Visible := ivNever;
     // Создать "Расходную накладную"
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать) then
        bbPopup_CreateRashod.Visible := ivNever;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Дополнительные_операции) then
        cxGridPopupMenuBRK.PopupMenus.Clear;

     // Карточка товара
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode then
    begin
        bbGoodsInfoCard.Visible := ivNever;
        bbKitGoodsInfoCard.Visible := ivNever;
    end;
     // Изменить цены товара
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or SWNSecurityManager.IsPartialAccessMode then
    begin
        bbGoodsPrice.Visible := ivNever;
        bbKitGoodsPrice.Visible := ivNever;
    end;
     // Соответствие товара в других фирмах
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    begin
        bbGoodsForeignCode.Visible := ivNever;
        bbKitGoodsForeignCode.Visible := ivNever;
    end;

    if SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridBRK_FLG_ACNT.Visible := False;
        cxGridBRK_FLG_ACNT.VisibleForCustomization := False;
        bbCustomerDebts.Visible := ivNever;
        bbTVA0.Visible := ivNever;
    end;

    if (dxBarPopupMenuCOMPONENTS.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuCOMPONENTS.PopupMenus.Clear;
    if (dxBarPopupMenuCOMPLECT.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuCOMPLECT.PopupMenus.Clear;
end;

procedure Tframe08ConfigurationBRK.ShowKitchenTemplate;
var
    dialog: TfrmKitchenTemplateDlg;
begin
    dialog := TfrmKitchenTemplateDlg.Create(Self, dmDB.IBCConnection);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

end.


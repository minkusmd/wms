unit frame93TenderUnit;

{
  CONFIGURATII. Calcul rapid al configuratiei
  DocTypeID = 115
  Frame Index = 8
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNDataFiltering,
    SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, DB, cxDBData, dxBar, DBAccess, IBC,
    cxSplitter, cxPC, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxGridCustomView, cxGrid, cxGridPopupMenu, cxCalc, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, cxImageComboBox, cxCurrencyEdit, cxLabel, cxCheckBox, dxBarBuiltInMenu,
    cxGridCustomPopupMenu, MemDS, cxClasses, DataModuleDB, dxSpreadSheet, dxSpreadSheetCore, dxCore,
    dxCoreClasses, dxHashUtils, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
    dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
    dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers,
    dxSpreadSheetFormulas, dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles,
    dxSpreadSheetGraphics, dxSpreadSheetPrinting, dxSpreadSheetTypes, dxSpreadSheetUtils,
    dxSpreadSheetFormattedTextUtils, dxUIAClasses;

type
    TStringArray = array of string;

    Tframe93Tender = class(TSWNBaseFrame)
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
        cxGridLevel: TcxGridLevel;
        bbAddToQTY: TdxBarButton;
        bbIncreaseSum: TdxBarButton;
        IBCQueryJurnalKit: TIBCQuery;
        IBCDataSourceJurnalKit: TIBCDataSource;
        dxPopupMenuRBK: TdxBarPopupMenu;
        bbPopup_Menu2: TdxBarButton;
        cxGridComplect_IMG: TcxGridDBColumn;
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
        bbAddSumaToComplect: TdxBarButton;
        cxGridBRKDB_RATEUSD: TcxGridDBColumn;
        cxGridPopupMenuBRK: TcxGridPopupMenu;
        cxGridBRKDB_DT: TcxGridDBColumn;
        cxGridBRKDB_CT: TcxGridDBColumn;
        cxGridBRK_FLG_CLOSED: TcxGridDBColumn;
        cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn;
        cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn;
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
        dxBarButton3: TdxBarButton;
        dxBarButton4: TdxBarButton;
        cxGridBRKDB_CREATED_DATE: TcxGridDBColumn;
        cxGridComplect_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
        cxGridBRKDB_CTSC_NAME: TcxGridDBColumn;
        cxGridBRKDB_dtsc_name: TcxGridDBColumn;
        cxGridBRKDBTableColumn1: TcxGridDBColumn;
        bbKitchenTemplate: TdxBarButton;
        dxBarButton6: TdxBarButton;
        dxBarButton7: TdxBarButton;
        dxBarSubItem1: TdxBarSubItem;
        cxGridComplect_FLG_ADDON: TcxGridDBColumn;
        dxBarButton9: TdxBarButton;
        cxGridBRKDBTableColumn2: TcxGridDBColumn;
        bbTVA0: TdxBarButton;
        IBCQueryTenderItems: TIBCQuery;
        IBCDataSourceTenderItems: TIBCDataSource;
        cxGridComponentsTableUID: TcxGridDBColumn;
        cxGridComponentsTableDOCID: TcxGridDBColumn;
        cxGridComponentsTableCPV: TcxGridDBColumn;
        cxGridComponentsTableDENUMIREA_BUNULUI: TcxGridDBColumn;
        cxGridComponentsTableFDA_SPECIFICATION: TcxGridDBColumn;
        cxGridComponentsTableGOODSID: TcxGridDBColumn;
        cxGridComponentsTableGOODS_NAME: TcxGridDBColumn;
        cxGridComponentsTableCOUNTRY_NAME: TcxGridDBColumn;
        cxGridComponentsTableMANUFACTURER: TcxGridDBColumn;
        cxGridComponentsTableWARANTY: TcxGridDBColumn;
        cxGridComponentsTableSTANDARD: TcxGridDBColumn;
        cxGridComponentsTableQTY: TcxGridDBColumn;
        cxGridComponentsTablePRICE: TcxGridDBColumn;
        cxGridComponentsTableSUMA: TcxGridDBColumn;
        cxGridComponentsTableVAT: TcxGridDBColumn;
        dxBarButton10: TdxBarButton;
        bbCreateOffer: TdxBarButton;
        procedure bbGoodsNewClick(Sender: TObject);
        procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
            TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure bbGoodsModifyClick(Sender: TObject);
        procedure bbGoodsDeleteClick(Sender: TObject);
        procedure bbAddFromKitClick(Sender: TObject);
        procedure bbIncreaseSumClick(Sender: TObject);
        procedure bbAddToQTYClick(Sender: TObject);
        procedure bbInsertFromTemplateClick(Sender: TObject);
        procedure bbPriceCol1Click(Sender: TObject);
        procedure cxGridComplectTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
            TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure bbPopup_Menu2Click(Sender: TObject);
        procedure bbGoodsComplectAddClick(Sender: TObject);
        procedure bbGoodsComplectEditClick(Sender: TObject);
        procedure bbAddToQTYComplectClick(Sender: TObject);
        procedure bbAddSumaToComplectClick(Sender: TObject);
        procedure bbCalcKitClick(Sender: TObject);
        procedure bbGoodsComplectDeleteClick(Sender: TObject);
        procedure cxGridBRKDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
            TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
        procedure dxPopupMenuRBKPopup(Sender: TObject);
        procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridBRKDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
        procedure cxGridBRKDBTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
        procedure cxGridBRKDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
            AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
            TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
            TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
        procedure cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender: TcxCustomGridTableView;
            ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
        procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
            TcxCustomGridRecord; var AText: string);
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
        procedure bbKitchenTemplateClick(Sender: TObject);
        procedure dxBarButton9Click(Sender: TObject);
        procedure bbTVA0Click(Sender: TObject);
        procedure dxBarButton10Click(Sender: TObject);
        procedure bbCreateOfferClick(Sender: TObject);
    private    { Private declarations }
        fLastDocID: integer;
        fLastGoodsID: integer;
        fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
        procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure DocumentSelectionChanged;
        procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsSelectionChanged;
        procedure WhenGoodsComplectGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
            APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure GoodsComplectSelectionChanged;
        procedure WhenDocumentPopupMenu;
        procedure ShowAddNewGoodsDialog;
        procedure ShowAddNewGoodsToComplectDialog;
        procedure ShowModifyGoodsDialog;
        procedure ShowModifyGoodsInComplectDialog;
        procedure DeleteSelectedGoods;
        procedure DeleteSelectedGoodsInComplect;
        procedure KitAddGoodsFromComplect;
        function KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const RemoveExisting:
            Boolean): Integer;
        procedure ShowAddCustomSumaToGoodsDialog;
        function DB_AddCustomSumaToGoodsDialog(const Suma: Currency; var NotUsedSuma: Currency): Boolean;
        function GetSumaForTVA: Integer;
        procedure ShowAddCustomSumaToGoodsInComplectDialog;
        function DB_AddCustomSumaToGoodsInComplectDialog(const DocID: Integer; const Suma: Currency;
            const ParentGoodsID: integer; var NotUsedSuma: Currency): Boolean;
        procedure ShowSetCustomQTYToGoodsDialog;
        function DB_SetCustomQTYToGoods(const DocID: Integer; const Count: double; const SetAsCount:
            Boolean): Boolean;
        procedure ShowSetCustomQTYToGoodsInComplectDialog;
        function DB_SetCustomQTYToGoodsInComplect(const DocID: Integer; const Count: Double; const
            SetAsCount: Boolean; const ParentGoodsID: integer): Boolean;
        procedure ShowSelectKitTemplateDialog;
        procedure KitAddGoodsFromTemplate(const TemplateID: integer; const TemplateName: string);
        function KitAddGoodsFromTemplateDB(const DocID, TemplateID: integer; const RemoveExisting:
            Boolean): Boolean;
        procedure CreateRashodnaiaNakladnaiaServis;
        procedure CreateProforma;
        procedure ShowRascetKonfiguratiiDialog;
        function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
        function WhenCheckIfGoodsExistsInComplect(const GoodsID: integer): Boolean;
        procedure RefreshFromComplect;
        procedure RefreshFromComplectDelete;
        function DoMoveGoodsIntoComplect(const DocID, GoodsID: Integer): Boolean;
        procedure SetupQtyFields;
    protected    { Protected declarations }
        function InitFrameID: integer; override;
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
        function DoImportData(ASpreadSheet: TdxSpreadSheet): boolean;
        procedure PrepareSpreadSheet(ASpreadSheet: TdxSpreadSheet);
    public    { Public declarations }
        procedure CreateNewRecordFromSip(CustomerPhone, CustomerName: string; CustomerID: Integer);
        procedure SetupDefaultFocus; override;
        function GetCurrentSearchContext: TSearchContextValue; override;
        function DocActionDB_ImportFromDocument(TargetDocID: Integer; const SourceDocID: integer): Boolean;
    end;

implementation

uses
    frmConfigurationDocDialog, DataModuleAdditions, System.UITypes, SWNUtils, SWNConst,
    frmConfigurationCustomSumaDialog, frmConfigurationCustomCountDialog, SWNTypes,
    frmSelectGoodsToAddDialog, frmRascetKonfiguratiiDialog, SWNValueStorageUnit,
    frmKitTemplatesDialog, SWNDBErrors, frmDocumentDiscountDialog, frmCreateCustomNareadSborkaDialog,
    SWNSecurity, SWNSecurityFlags, SWNCommonDialogs, frmSelectPhoneNumberUnit, Vcl.Clipbrd,
    vcl.dialogs, uCreditFinalInfoDialog, frmKitchenTemplateUnit, frmDocumentImportBrowserDialog,
    System.Types, frmAddItemsToTenderUnit, frmCustomImportXlsUnit;

{$R *.dfm}

{ Tframe08ConfigurationBRK }

procedure Tframe93Tender.SaveFrameStates;
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

procedure Tframe93Tender.GoodsSelectionChanged;
var
    fGoodsAdd, fGoodsEdit, fGoodsDelete, fGoodsSelected: Boolean;
    fCalcConfig: Boolean;
    fAddFromKit, fInsertFromTemplate: Boolean;
    fAddToQTY: Boolean;
    fAddToSUMA, fKit, fMoveGoods: boolean;
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
    fAddFromKit := False; // Adauga din set
    fInsertFromTemplate := False; // Inserare din sablon
     // specific: Goods
    fCalcConfig := False; // Calcul configuratie
    fAddToQTY := False; // Modificare cantitate
    fAddToSUMA := False; // Modificare suma seturi
    fMoveGoods := False; // Muta produsele in set
    GoodsChanged := True;

    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
        FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

        fGoodsAdd := fSECURITY_CanEdit and not FLG_CLOSED; // New Goods + Security
        fInsertFromTemplate := fGoodsAdd;
        fAddFromKit := fGoodsAdd;

        if (cxGridComponentsTable.DataController.RecNo > 0) then
        begin
               // Componenta
            fGoodsEdit := fGoodsAdd;   // Edit Goods + Security
            fGoodsDelete := fGoodsAdd; // Delete Goods + Security
//      fKit := dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger);

            fCalcConfig := True; // Calcul configuratie
            fAddToQTY := fGoodsAdd; // Modificare cantitate
            fAddToSUMA := fGoodsAdd; // Modificare suma
            fMoveGoods := fKit; // Muta produsele in set
            fGoodsSelected := True;

            GoodsChanged := fLastGoodsID <> IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
            fLastGoodsID := IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
        end;
    end;
     // tab
    tbsKitContent.TabVisible := fKit;
     // goods
    bbGoodsNew.Enabled := fGoodsAdd;
    bbGoodsModify.Enabled := fGoodsEdit;
    bbGoodsDelete.Enabled := fGoodsDelete;
     // Instrumente, common
    bbAddFromKit.Enabled := fAddFromKit;                  // Adauga din set
    bbInsertFromTemplate.Enabled := fInsertFromTemplate;  // Inserare din sablon
     // Instrumente, Goods
    bbCalcKit.Enabled := fCalcConfig;                     // Calcul configuratie
    bbAddToQTY.Enabled := fAddToQTY;                      // Modificare cantitate
    bbIncreaseSum.Enabled := fAddToSUMA;                  // Modificare suma
    bbMoveGoodsInComplect.Enabled := fMoveGoods;
     // Coloane preturi
    bbPriceColSelector.Enabled := fGoodsAdd;

    bbGoodsInfoCard.Enabled := fGoodsSelected;
    bbGoodsPrice.Enabled := fGoodsSelected;
    bbGoodsForeignCode.Enabled := fGoodsSelected;

    if GoodsChanged then
        cxPageControlComplect.ActivePage := tbsGoods;

    GoodsComplectSelectionChanged;
end;

procedure Tframe93Tender.ShowSetCustomQTYToGoodsDialog;
var
    dialog: TfrmConfigurationCustomCountDlg;
begin
    dialog := TfrmConfigurationCustomCountDlg.Create(Self);
    try
        dialog.InComplect := False;
        dialog.OptionType := ocSetCount;
        if dialog.ShowModal = mrOk then
        begin
            if DB_SetCustomQTYToGoods(IBCQueryTenderItems.FieldByName('DOCID').asInteger, dialog.Value,
                dialog.OptionType = ocSetCount) then
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

procedure Tframe93Tender.ShowSetCustomQTYToGoodsInComplectDialog;
var
    dialog: TfrmConfigurationCustomCountDlg;
begin
    dialog := TfrmConfigurationCustomCountDlg.Create(Self);
    try
        dialog.InComplect := True;
        dialog.OptionType := ocSetCount;
        if dialog.ShowModal = mrOk then
        begin
            if DB_SetCustomQTYToGoodsInComplect(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger,
                dialog.Value, dialog.OptionType = ocSetCount, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger)
                then
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

procedure Tframe93Tender.ShowAddCustomSumaToGoodsDialog;
var
    dialog: TfrmConfigurationCustomSumaDlg;
    NotUsedSuma: Currency;
    S: string;
begin
    dialog := TfrmConfigurationCustomSumaDlg.Create(Self);
    try
        dialog.InComplect := False;
        dialog.CurrencyTitle := dmDB.IBCQueryDocs.FieldByName('CURRENCY_NAME').AsString;
        dialog.Suma := cxGridComponentsTable.DataController.Summary.FooterSummaryValues[cxGridComponentsTable.DataController.Summary.FooterSummaryItems.IndexOfItemLink
            (cxGridComponentsTableSUMA)];
        // update: pentru operatia "TVA inapoi", trebuie de luat numai suma componentelor finite
        dialog.SumaForTVA := GetSumaForTVA;

        if dialog.ShowModal = mrOk then
        begin
            if DB_AddCustomSumaToGoodsDialog(dialog.AddedSuma, NotUsedSuma) then
            begin
                if NotUsedSuma <> 0 then
                begin
                    if (NotUsedSuma = dialog.AddedSuma) then
                        ShowErrorDialog('Oferte', 'Nu e posibil de distribuit suma!' + #13#10 +
                            'Suma trebuie sa fie mai mare.')
                    else
                    begin
                        S := 'Nu toata suma a fost distribuita uniform peste produse!' + #13#10 +
                            #13#10 + Format('Suma initiala: %d', [dialog.AddedSuma]) + #13#10 +
                            Format('Suma distribuita: %f', [dialog.AddedSuma - NotUsedSuma]) +
                            #13#10 + #13#10 + Format('Sold: %f', [NotUsedSuma]);
                        ShowWarningDialog('Modificare suma', S);
                    end;
                end;

                  // reload data
                dmDB.FullRefresh;
            end;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.ShowAddCustomSumaToGoodsInComplectDialog;
var
    dialog: TfrmConfigurationCustomSumaDlg;
    NotUsedSuma: Currency;
    S: string;
begin
    dialog := TfrmConfigurationCustomSumaDlg.Create(Self);
    try
        dialog.InComplect := True;
        dialog.CurrencyTitle := dmDB.IBCQueryDocs.FieldByName('CURRENCY_NAME').AsString;
        dialog.Suma := cxGridComplectTable.DataController.Summary.FooterSummaryValues[cxGridComplectTable.DataController.Summary.FooterSummaryItems.IndexOfItemLink
            (cxGridComplect_SUMA)];
        dialog.SumaForTVA := dialog.Suma;

        if dialog.ShowModal = mrOk then
        begin
            if DB_AddCustomSumaToGoodsInComplectDialog(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger,
                dialog.AddedSuma, dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger, NotUsedSuma) then
            begin
                if NotUsedSuma <> 0 then
                begin
                    if (NotUsedSuma = dialog.AddedSuma) then
                        ShowErrorDialog('Oferte', 'Nu e posibil de distribuit suma!' + #13#10 +
                            'Suma trebuie sa fie mai mare.')
                    else
                    begin
                        S := 'Nu toata suma a fost distribuita!' + #13#10 + #13#10 + Format('Suma initiala: %d',
                            [dialog.AddedSuma]) + #13#10 + Format('Suma distribuita: %f', [dialog.AddedSuma
                            - NotUsedSuma]) + #13#10 + #13#10 + Format('Sold: %f', [NotUsedSuma]);
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

function Tframe93Tender.DB_SetCustomQTYToGoods(const DocID: Integer; const Count: double; const
    SetAsCount: Boolean): Boolean;
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

function Tframe93Tender.DB_SetCustomQTYToGoodsInComplect(const DocID: Integer; const Count: Double;
    const SetAsCount: Boolean; const ParentGoodsID: integer): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text :=
                'EXECUTE PROCEDURE CUSTOMIZE_GOODSCOMPLECT_BYCNT2(:DOCID,:Count,:AddAsCount,:GoodsComplectID)';
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

function Tframe93Tender.DB_AddCustomSumaToGoodsDialog(const Suma: Currency; var NotUsedSuma:
    Currency): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text := 'SELECT SUMARAMASA FROM CUSTOM_GOODSCOMPLECT_BY_SUMA2(:DOCID,:SUMA,NULL)';
            Query.ParamByName('DOCID').AsInteger := IBCQueryTenderItems.FieldByName('DOCID').asInteger;
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

function Tframe93Tender.DB_AddCustomSumaToGoodsInComplectDialog(const DocID: Integer; const Suma:
    Currency; const ParentGoodsID: integer; var NotUsedSuma: Currency): Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text :=
                'SELECT SUMARAMASA FROM CUSTOM_GOODSCOMPLECT_BY_SUMA2(:DOCID,:SUMA,:ParentGoodsID)';
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

procedure Tframe93Tender.bbAddSumaToComplectClick(Sender: TObject);
begin
    ShowAddCustomSumaToGoodsInComplectDialog;
end;

procedure Tframe93Tender.bbAddToQTYClick(Sender: TObject);
begin
    ShowSetCustomQTYToGoodsDialog;
end;

procedure Tframe93Tender.bbAddToQTYComplectClick(Sender: TObject);
begin
    ShowSetCustomQTYToGoodsInComplectDialog;
end;

procedure Tframe93Tender.bbCalcKitClick(Sender: TObject);
begin
    ShowRascetKonfiguratiiDialog;
end;

procedure Tframe93Tender.bbCreateOfferClick(Sender: TObject);
begin
    inherited;
    dmDB.ExecuteQuery('execute procedure sp_create_oferta(:docid)', [dmDB.IBCQueryDocs.FieldByName('docid').AsInteger]);
    ShowInfoDialog('Tender', 'Oferta a fost creata cu succes!');
end;

procedure Tframe93Tender.bbIncreaseSumClick(Sender: TObject);
begin
    ShowAddCustomSumaToGoodsDialog;
end;

procedure Tframe93Tender.bbInsertFromTemplateClick(Sender: TObject);
begin
    ShowSelectKitTemplateDialog;
end;

procedure Tframe93Tender.bbKitchenTemplateClick(Sender: TObject);
begin
    ShowKitchenTemplate;
end;

procedure Tframe93Tender.bbKitGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe93Tender.bbKitGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger,
        IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe93Tender.bbKitGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger,
        IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe93Tender.bbMoveGoodsInComplectClick(Sender: TObject);
begin
    if ShowAskDialog('Produsele din complect', Format('Doriti transferul produselor in complect"%s" ?',
        [IBCQueryTenderItems.FieldByName('GOODS_NAME').asString])) <> mrYes then
        Exit;

    if DoMoveGoodsIntoComplect(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, IBCQueryTenderItems.FieldByName
        ('GOODSID').AsInteger) then
        RefreshData;
end;

procedure Tframe93Tender.bbAddFromKitClick(Sender: TObject);
begin
    KitAddGoodsFromComplect;
end;

procedure Tframe93Tender.bbGoodsModifyClick(Sender: TObject);
begin
    ShowModifyGoodsDialog;
end;

procedure Tframe93Tender.bbGoodsNewClick(Sender: TObject);
begin
    ShowAddNewGoodsDialog;
end;

procedure Tframe93Tender.bbGoodsPriceClick(Sender: TObject);
begin
    TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryTenderItems.FieldByName('GOODSID').AsInteger,
        IBCQueryTenderItems.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe93Tender.bbPopup_Menu2Click(Sender: TObject);
begin
    CreateRashodnaiaNakladnaiaServis;
end;

procedure Tframe93Tender.bbPriceCol1Click(Sender: TObject);
var
    GoodsParentID: integer;
    GoodsParentTitle: string;
    PriceColumn: integer;
    GoodsParentGoodsCount: Integer;
begin
    PriceColumn := TdxBarButton(Sender).Tag;

    GoodsParentID := -1;
    GoodsParentTitle := '';
    GoodsParentGoodsCount := 0;
    if cxPageControlComplect.ActivePage = tbsKitContent then
    begin
        GoodsParentID := IBCQueryTenderItems.FieldByName('GOODSID').asInteger;
        GoodsParentTitle := IBCQueryTenderItems.FieldByName('GOODS_NAME').asString;
        GoodsParentGoodsCount := IBCQueryJurnalKit.RecordCount;
    end;

    if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName
        ('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, GoodsParentID,
        PriceColumn, GoodsParentTitle, GoodsParentGoodsCount) then
        RefreshData;
end;

procedure Tframe93Tender.bbGoodsComplectAddClick(Sender: TObject);
begin
    ShowAddNewGoodsToComplectDialog;
end;

procedure Tframe93Tender.bbGoodsComplectDeleteClick(Sender: TObject);
begin
    DeleteSelectedGoodsInComplect;
end;

procedure Tframe93Tender.bbGoodsComplectEditClick(Sender: TObject);
begin
    ShowModifyGoodsInComplectDialog;
end;

procedure Tframe93Tender.bbGoodsDeleteClick(Sender: TObject);
begin
    DeleteSelectedGoods;
end;

procedure Tframe93Tender.bbGoodsForeignCodeClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsForeignCode(IBCQueryTenderItems.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe93Tender.bbGoodsInfoCardClick(Sender: TObject);
begin
    TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryTenderItems.FieldByName('GOODSID').AsInteger,
        IBCQueryTenderItems.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe93Tender.CloneRecord;
var
    S: string;
    newDocID: integer;
begin
    S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
    if ShowAskDialog('Clonarea documentului', 'Clonarea configuratiei №' + S + '?') <> mrYes then
        Exit;

    if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
    begin
        dmDB.RefreshDocs;
        dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
        ShowInfoDialog('Clonarea documentului', 'O nou copie a fost creata.'#13#10'Configuratia №' +
            dmDB.IBCQueryDocs.FieldByName('DOCID').AsString);
    end;
end;

procedure Tframe93Tender.CreateNewRecord;
var
    dialog: TfrmConfigurationDocDlg;
begin
    dialog := TfrmConfigurationDocDlg.Create(self);
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

procedure Tframe93Tender.CreateNewRecordFromSip(CustomerPhone, CustomerName: string; CustomerID: Integer);
var
    dialog: TfrmConfigurationDocDlg;
    Query: TIBCQuery;
begin
    dialog := TfrmConfigurationDocDlg.Create(self);
    Query := TIBCQuery.Create(self);
    try
        dialog.CreateNewDocument := True;
        dialog.beCT_NAME.Tag := CustomerID;
        dialog.beCT_NAME.Text := CustomerName;
        dialog.NewComment := Format('%s (%s) - %s', [dmdb.CurrentUserFullName, DateToStr(now), (CustomerName
            + ' ' + CustomerPhone)]);
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

procedure Tframe93Tender.CreateRashodnaiaNakladnaiaServis;
begin
     // Creare "Nakladnaia de iesire in service"
    if ShowAskDialog('Creeaza "Nakladnaia de iesire in service"',
        'Doriti sa creati nakladnaia de iesire in service?') = mrYes then
    begin
        if dmDB.CreateRashodnaiaNakladnaiaServis_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
            ShowInfoDialog('Nakladnaia de iesire in service', 'Nakladnaia de iesire in service a fost creata!');
    end;
end;

procedure Tframe93Tender.CreateProforma;
begin
     // Creare "Factura de plata"
    if ShowAskDialog('Creare document', 'Doriti sa creati documentul "Proforma" ?') = mrYes then
    begin
        if dmDB.CreateProforma(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
            ShowInfoDialog('Proforma', 'Document Proforma creat cu succes!');
    end;
end;

procedure Tframe93Tender.cxGridBRKDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
    TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
    if AButton = mbLeft then
    begin
        DoDocumentDoubleClick;
        AHandled := True;
    end;
end;

procedure Tframe93Tender.cxGridBRKDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
    TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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

     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe93Tender.cxGridBRKDBTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
    TcxCustomGridRecord; var AText: string);
begin
    if not VarIsNull(ARecord.Values[cxGridBRKDBTableData.Index]) then
        AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBRKDBTableData.Index]);
end;

procedure Tframe93Tender.cxGridBRKDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGridBRKDBTable, Key, Shift);
end;

procedure Tframe93Tender.cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
    AHandled: Boolean);
begin
    if bbGoodsComplectEdit.Enabled then
    begin
        ShowModifyGoodsInComplectDialog;
        AHandled := True;
    end;
end;

procedure Tframe93Tender.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
    TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;
end;

procedure Tframe93Tender.cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGridComplectTable, Key, Shift);
end;

procedure Tframe93Tender.cxGridComplectTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
    if VarIsNumeric(ARecord.Values[cxGridComplect_STOCK_QTY.Index]) then
    begin
        if (ARecord.Values[cxGridComplect_STOCK_QTY.Index] <= 0) then
            AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
    end;
end;

procedure Tframe93Tender.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
    TcxCustomGridRecord; var AText: string);
begin
    if VarIsNumeric(ARecord.Values[Sender.Index]) and VarIsNumeric(ARecord.Values[cxGridComplect_UMID.Index])
        then
    begin
        if (ARecord.Values[cxGridComplect_UMID.Index] = 1) then
            AText := StringReplace(AText, QtyReplaceMask, '', []);
    end;
end;

procedure Tframe93Tender.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
    AHandled: Boolean);
begin
    if bbGoodsModify.Enabled then
    begin
        ShowModifyGoodsDialog;
        AHandled := True;
    end;
end;

procedure Tframe93Tender.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
    TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
    if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    begin
        ACanvas.Brush.Color := $E8E8E8;
    end;

//  if AViewInfo.GridRecord.Values[cxGridDBCol_STOCK_QTY.Index] > 0 then
//  begin
//    ACanvas.Font.Style := ACanvas.Font.style + [fsBold];
//  end;
//  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index]) then
//  begin
//    if AViewInfo.GridRecord.Values[cxGridComponents_FLG_FORCED.Index] = 0 then
//    begin
//      if not AViewInfo.Selected then
//      begin
//        ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
//      end;
//    end
//  end;
end;

procedure Tframe93Tender.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // daca cimpul e GoodsName atunci in clipboard trebuie sa ajunga codul + denumirea
  // -------------------------------------------------------------------------------
  // in caz contrar procedura standarta
    SWNUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe93Tender.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
    ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
//  if VarIsNumeric(ARecord.Values[cxGridDBCol_STOCK_QTY.Index]) then
//  begin
//    if (ARecord.Values[cxGridDBCol_STOCK_QTY.Index] <= 0) then
//      AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
//  end;
end;

procedure Tframe93Tender.cxGridComponents_PRICE_COLUMNStylesGetContentStyle(Sender:
    TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle:
    TcxStyle);
//var
//  N: Integer;
begin
//  if VarIsNumeric(ARecord.Values[cxGridComponents_PRICE_COLUMN.Index]) then
//  begin
//    N := ARecord.Values[cxGridComponents_PRICE_COLUMN.Index];
//    if (N <= 0) or (N >= 4) then
//      AStyle := dmAdditions.cxStyle_GridPriceColumnRed;
//  end;
end;

procedure Tframe93Tender.DeleteRecord;
begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_Конфигуратор, [dmDB.IBCQueryDocs.FieldByName
        ('DOCID').asInteger])) = mrYes then
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

procedure Tframe93Tender.DocumentSelectionChanged;
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

    GoodsSelectionChanged;
end;

procedure Tframe93Tender.DoFrameHide;
begin
     // inchidem datele interne
    IBCQueryJurnalKit.Close;
    IBCQueryTenderItems.Close;
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

procedure Tframe93Tender.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

    fLastDocID := -1;
    fLastGoodsID := -1;
    cxPageControlComplect.ActivePageIndex := 0;


     // 1. Legam grid-urile de datasource-sele
    cxGridBRKDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGridComponentsTable.DataController.DataSource := IBCDataSourceTenderItems;
    cxGridComplectTable.DataController.DataSource := IBCDataSourceJurnalKit;

     // 2. Selection handlers
    cxGridBRKDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
    cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
    cxGridComplectTable.OnFocusedRecordChanged := WhenGoodsComplectGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
    IBCQueryTenderItems.Open;
    IBCQueryJurnalKit.Open;

     // 4. Selection update
    DocumentSelectionChanged;
end;

function Tframe93Tender.DoImportData(ASpreadSheet: TdxSpreadSheet): boolean;
var
    i, N: integer;
    cell: TdxSpreadSheetCell;
    CPV: string;
    FDA: string;
    NAME: string;
    QTY: Double;
    Sheet: TdxSpreadSheetTableView;
    STANDARD: string;
    query: TIBCQuery;
begin
//    Result := False;
    try
        Sheet := ASpreadSheet.ActiveSheetAsTable;
        Sheet.BeginUpdate;

        if not dmdb.IBCTrDefaultUpdate.Active then
            dmdb.IBCTrDefaultUpdate.StartTransaction;

        query := TIBCQuery.Create(self);
        query.Transaction := dmDB.IBCTrDefaultUpdate;
        query.SQL.Text :=
            'insert into tdb_tender (docid, CPV, DENUMIREA_BUNULUI, FDA_SPECIFICATION, STANDARD, QTY) ' +
            ' VALUES(:DOCID, :CPV, :NAME, :FDA, :STANDARD, :QTY)';
        query.Prepare;
        for i := 1 to Sheet.Rows.LastIndex do
        begin
            CPV := Sheet.Cells[i, 0].DisplayText;
            NAME := Sheet.Cells[i, 1].DisplayText;
            FDA := Sheet.Cells[i, 2].DisplayText;
            STANDARD := Sheet.Cells[i, 3].DisplayText;
            QTY := Sheet.Cells[i, 4].AsFloat;
            query.ParamByName('DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
            query.ParamByName('CPV').AsString := CPV;
            query.ParamByName('NAME').AsString := NAME;
            query.ParamByName('FDA').AsString := FDA;
            query.ParamByName('STANDARD').AsString := STANDARD;
            query.ParamByName('QTY').AsFloat := QTY;
            query.ExecSQL;
        end;
        Sheet.EndUpdate;

        if dmdb.IBCTrDefaultUpdate.Active then
            dmdb.IBCTrDefaultUpdate.Commit;

        Result := True;

    except
        on E: Exception do
        begin
            Result := False;
            if dmdb.IBCTrDefaultUpdate.Active then
                dmdb.IBCTrDefaultUpdate.Rollback;
            raise;
        end;

    end;
end;

function Tframe93Tender.DoMoveGoodsIntoComplect(const DocID, GoodsID: Integer): Boolean;
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

procedure Tframe93Tender.bbTVA0Click(Sender: TObject);
begin
    dmDB.ExecuteQuery('execute procedure setvat0(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    dmDB.IBCQueryDocs.Refresh;
    IBCQueryTenderItems.Refresh;
end;

procedure Tframe93Tender.dxBarButton10Click(Sender: TObject);
var
    dialog: TfrmCustomImportXLS;
begin
    dialog := TfrmCustomImportXLS.Create(self, dmDB.IBCConnection);
    try
        dialog.OnPrepareSpreadSheet := PrepareSpreadSheet;
        dialog.OnDoImport := DoImportData;
        dialog.ShowModal;
        IBCQueryTenderItems.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.dxBarButton1Click(Sender: TObject);
var
    list: TStringList;
    i: Integer;
    goodsid: string;
//  s: string;
    qty: string;
    clipboard_array: TArray<string>;
begin

    list := TStringList.Create;
    IBCQueryTenderItems.DisableControls;
    try
        list.Text := Clipboard.AsText;
//    i := 0;
        if not IBCQueryTenderItems.UpdateTransaction.Active then
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
                        FieldByName('GOODSID').AsString := goodsid;
                        FieldByName('QTY').AsString := qty;
//            FieldByName('DTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
//            FieldByName('CTDEP').AsInteger := dmDB.IBCQueryDocs.FieldByName('CTDEP').AsInteger;
//            FieldByName('UMID').AsInteger := 1;
                        FieldByName('WARANTY').AsInteger := 12;
//            FieldByName('FLG_ACTIVE').AsInteger := 1;
                        FieldByName('PRICE').AsFloat := 0;
//            FieldByName('GOODSCOMPLECT_ID').AsInteger := -1;
                        Post;
                    except
                        on e: exception do
                        begin
                            cancel;
                            IBCQueryTenderItems.UpdateTransaction.Rollback;
                            raise;
                        end;
                    end;
                end;
            end;
            IBCQueryTenderItems.UpdateTransaction.Commit;
        end;
        IBCQueryTenderItems.Refresh;
    finally
        list.Free;
        IBCQueryTenderItems.EnableControls;
    end;
end;

procedure Tframe93Tender.dxBarButton3Click(Sender: TObject);
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
            ListOfGoodsID.Add(IntToStr(cxGridComponentsTable.DataController.Values[i,
                cxGridComponentsTableGOODSID.Index]));
        end;
        dialog.ListOfGoodsID := ListOfGoodsID.CommaText;
        dialog.SumaCredit := dmdb.IBCQueryDocs.FieldByName('SUMA').AsFloat;
        dialog.ShowModal;
    finally
        dialog.Free;
        ListOfGoodsID.Free;
    end;
end;

procedure Tframe93Tender.dxBarButton4Click(Sender: TObject);
begin
    dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('CT_NAME').AsString, '');
end;

procedure Tframe93Tender.dxBarButton9Click(Sender: TObject);
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

function Tframe93Tender.DocActionDB_ImportFromDocument(TargetDocID: Integer; const SourceDocID:
    integer): Boolean;
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
            Query.SQL.Text :=
                'EXECUTE PROCEDURE SP_IMPORT_FROM_DOC(:TARGET_DOCID, :SOURCE_DOCID, :COMPLECTID)';
            Query.ParamByName('TARGET_DOCID').AsInteger := TargetDocID;
            Query.ParamByName('SOURCE_DOCID').AsInteger := SourceDocID;
            Query.ParamByName('COMPLECTID').AsInteger := IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
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

procedure Tframe93Tender.dxPopupMenuRBKPopup(Sender: TObject);
begin
    WhenDocumentPopupMenu;
end;

function Tframe93Tender.GetCurrentSearchContext: TSearchContextValue;
begin
    result := inherited;

    if cxGridComponentsTable.Site.Focused then
    begin
          // context from Jurnal: Cod + Denumire
        result.Context := ffGoods;
        result.ValueInt := IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
        result.ValueStr := IBCQueryTenderItems.FieldByName('GOODS_NAME').AsString;
    end
    else if cxGridBRKDBTable.Site.Focused then
    begin
              // context from Docs
        if cxGridBRKDB_CT_NAME.Focused then
        begin
                   // Contraagent
            result.Context := ffCustomer;
            result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
            result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
        end
        else if cxGridBRKDBTableData.Focused then
        begin
                       // Data
            result.Context := ffDate;
            result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        end
        else if cxGridBRKDB_DTDEP_NAME.Focused then
        begin
                           // Depozit
            result.Context := ffStock;
            result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
            result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
        end;
    end
end;

function Tframe93Tender.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    result := [fedsDocs];
end;

function Tframe93Tender.GetFilterFields: TFrameFilterFields;
begin
    result := [ffDate, ffCustomer, ffGoods, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe93Tender.GetFrameButtons: TFrameButtons;
begin
    result := [fbtREFRESH, fbtDial];
    if fSECURITY_CanNew then
        result := result + [fbtADD, fbtCLONE];
    if fSECURITY_CanEdit then
        result := result + [fbtMODIFY];
    if fSECURITY_CanDelete then
        result := result + [fbtDELETE];
end;

function Tframe93Tender.GetSumaForTVA: Integer;
//var
//  i: integer;
begin
    result := 0;
//  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
//  begin
//    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_FLG_HAS_COMPLECT_GOODS.Index] = 0 then
//      result := result + cxGridComponentsTable.DataController.Values[i, cxGridDBCol_SUMA.Index];
//  end;
end;

procedure Tframe93Tender.GoodsComplectSelectionChanged;
var
    fGoodsComplectAdd, fGoodsComplectEdit, fGoodsComplectDelete: Boolean;
    fAddFromKit, fGoodsSelected: Boolean;
    fAddToQTYComplect: Boolean;
    fAddToSUMAInComplect: boolean;
begin
    fGoodsComplectAdd := False;
    fGoodsComplectEdit := False;
    fGoodsComplectDelete := False;

     // common
    fAddFromKit := False; // Adauga din set
     // specific: Complect
    fAddToQTYComplect := False; // Modificare cantitate
    fAddToSUMAInComplect := False;
    fGoodsSelected := False;

    if cxGridBRKDBTable.DataController.RecNo > 0 then
    begin
        if (cxGridComponentsTable.DataController.RecNo > 0) then
        begin
//      if (dmdb.IsKit(IBCQueryTenderItems.FieldByName('GOODS_TYPE_ID').AsInteger)) then // Set
//      begin
//                    // --Configurare set--
//        fAddFromKit := fSECURITY_CanEdit;
//        fGoodsComplectAdd := fSECURITY_CanEdit;
//
//        if (cxGridComplectTable.DataController.RecNo > 0) then
//        begin
//          fGoodsComplectEdit := fSECURITY_CanEdit;
//          fGoodsComplectDelete := fSECURITY_CanEdit;
//          fAddToQTYComplect := fSECURITY_CanEdit;
//          fAddToSUMAInComplect := fSECURITY_CanEdit;
//          fGoodsSelected := True;
//        end;
//
//      end;
        end;
    end;

  // goods in complect
    bbGoodsComplectAdd.Enabled := fGoodsComplectAdd;
    bbGoodsComplectEdit.Enabled := fGoodsComplectEdit;
    bbGoodsComplectDelete.Enabled := fGoodsComplectDelete;

  // Instrumente
    bbAddFromKit.Enabled := fAddFromKit;                  // Adauga din set
    bbAddToQTYComplect.Enabled := fAddToQTYComplect;      // Modificare cantitate
    bbAddSumaToComplect.Enabled := fAddToSUMAInComplect;  // Modificare suma in set
    bbKitGoodsInfoCard.Enabled := fGoodsSelected;
    bbKitGoodsPrice.Enabled := fGoodsSelected;
    bbKitGoodsForeignCode.Enabled := fGoodsSelected;
end;

function Tframe93Tender.InitFrameID: integer;
begin
  // Oferta tender
    result := 93;

//  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
    dmDB.CreateGridImageColumnItems(cxGridComplect_IMG);

    SetupQtyFields;
end;

procedure Tframe93Tender.KitAddGoodsFromComplect;
var
    Allow: Boolean;
    ClearAll: Boolean;
    RecordsAdded: Integer;
begin
    ClearAll := True;
     // ask for options
    if IBCQueryJurnalKit.RecordCount > 0 then
        Allow := ShowAskDialogVerification('Complect', 'Adauga produsele din complect in oferta?',
            'Sterge produsele curente?', Format('Complecte: %s', [IBCQueryTenderItems.FieldByName('GOODS_NAME').AsString]),
            ClearAll) = mrYes
    else
        Allow := True;

    if Allow then
    begin
        RecordsAdded := KitAddGoodsFromComplectDB(IBCQueryTenderItems.FieldByName('DOCID').asInteger,
            IBCQueryTenderItems.FieldByName('GOODSID').asInteger, ClearAll);
        if (RecordsAdded <= 0) then
            ShowErrorDialog('Oferte', 'In complect lipsesc produsele!',
                'Verificati completarea din nomenclatorul de produse.')
        else
        begin
            dmDB.FullRefresh;
            IBCQueryJurnalKit.Refresh;
            ShowInfoDialog('Oferte', Format('Adaugat cu succes %d de produse', [RecordsAdded]));
        end;
    end;
end;

function Tframe93Tender.KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const
    RemoveExisting: Boolean): Integer;
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

procedure Tframe93Tender.KitAddGoodsFromTemplate(const TemplateID: integer; const TemplateName: string);
var
    Allow: Boolean;
    ClearAll: Boolean;
begin
    ClearAll := True;
     // ask for options
    if IBCQueryTenderItems.RecordCount > 0 then
        Allow := ShowAskDialogVerification('Oferte', 'Adauga produse din template"' + TemplateName +
            '" in oferta curenta?', 'sterge produsele existente', '', ClearAll) = mrYes
    else
        Allow := True;

    if Allow then
    begin
        if KitAddGoodsFromTemplateDB(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, TemplateID,
            ClearAll) then
        begin
            dmDB.FullRefresh;
            ShowInfoDialog('Oferte', 'Adaugat cu succes!');
        end;
    end;
end;

function Tframe93Tender.KitAddGoodsFromTemplateDB(const DocID, TemplateID: integer; const
    RemoveExisting: Boolean): Boolean;
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
            Query.SQL.Text :=
                'EXECUTE PROCEDURE CREATE_GOODSCOMPLECT_TEMPLATED(:DOCID, :KITTEMPLATEID, :REMOVEEXISTING)';
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

procedure Tframe93Tender.ModifyRecord;
var
    dialog: TfrmConfigurationDocDlg;
begin
    if not fSECURITY_CanEdit then
        Exit;

    dialog := TfrmConfigurationDocDlg.Create(self);
    try
        dialog.CreateNewDocument := False;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.PrepareSpreadSheet(ASpreadSheet: TdxSpreadSheet);
const
    FontSize = 9;
    FontName = 'Tahoma';
var
    cell: TdxSpreadSheetCell;
    Sheet: TdxSpreadSheetTableView;
begin
    with ASpreadSheet do
    begin

        Sheet := ASpreadSheet.ActiveSheetAsTable;
        ASpreadSheet.Font.Name := FontName;
        ASpreadSheet.Font.Size := FontSize;
        Sheet.Caption := 'Lista de produse';
//         CreateCell(FontSize, cell);

        cell := ASpreadSheet.ActiveSheetAsTable.CreateCell(0, 0);
        cell.column.Size := 100;
        cell.Style.Font.Style := [fsBold];
        cell.SetText('Cod CPV');

        cell := ASpreadSheet.ActiveSheetAsTable.CreateCell(0, 1);
        cell.column.Size := 450;
        cell.Style.Font.Style := [fsBold];
        cell.SetText('Denumirea bunului');

        cell := ASpreadSheet.ActiveSheetAsTable.CreateCell(0, 2);
        cell.column.Size := 250;
        cell.Style.Font.Style := [fsBold];
        cell.SetText('Specificatia din FDA');

        cell := ASpreadSheet.ActiveSheetAsTable.CreateCell(0, 3);
        cell.column.Size := 100;
        cell.Style.Font.Style := [fsBold];
        cell.SetText('Standarde');

        cell := ASpreadSheet.ActiveSheetAsTable.CreateCell(0, 4);
        cell.column.Size := 70;
        cell.Style.Font.Style := [fsBold];
        cell.SetText('Cant');
    end;
end;

procedure Tframe93Tender.ReadFrameStates;
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

procedure Tframe93Tender.RefreshData;
begin
    inherited;
    IBCQueryJurnalKit.Refresh;
    IBCQueryTenderItems.Refresh;
end;

procedure Tframe93Tender.RefreshFromComplect;
var
    GoodsID, GoodsID2, tabIndex: integer;
begin
    GoodsID2 := IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger;
    GoodsID := IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
    tabIndex := cxPageControlComplect.ActivePageIndex;

    IBCQueryJurnalKit.DisableControls;
    IBCQueryTenderItems.DisableControls;
    try
        // refresh
        dmDB.IBCQueryDocs.Refresh;
        IBCQueryTenderItems.Refresh;
        // reposition
        IBCQueryTenderItems.Locate('GOODSID', GoodsID, []);
        cxPageControlComplect.ActivePageIndex := tabIndex;
        IBCQueryJurnalKit.Locate('GOODSID', GoodsID2, []);
    finally
        IBCQueryJurnalKit.EnableControls;
        IBCQueryTenderItems.EnableControls;
    end;
end;

procedure Tframe93Tender.RefreshFromComplectDelete;
var
    GoodsID, tabIndex: integer;
begin
    GoodsID := IBCQueryTenderItems.FieldByName('GOODSID').AsInteger;
    tabIndex := cxPageControlComplect.ActivePageIndex;

    IBCQueryJurnalKit.DisableControls;
    IBCQueryTenderItems.DisableControls;
    try
        // refresh
        dmDB.IBCQueryDocs.Refresh;
        IBCQueryTenderItems.Refresh;
        // reposition
        IBCQueryTenderItems.Locate('GOODSID', GoodsID, []);
        cxPageControlComplect.ActivePageIndex := tabIndex;
    finally
        IBCQueryJurnalKit.EnableControls;
        IBCQueryTenderItems.EnableControls;
    end;
end;

procedure Tframe93Tender.ShowAddNewGoodsDialog;
var
    dialog: TfrmAddItemsToTender;
begin
    dialog := TfrmAddItemsToTender.Create(self, IBCQueryTenderItems, IBCDataSourceTenderItems);
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

procedure Tframe93Tender.ShowAddNewGoodsToComplectDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
     // show dialog
    dialog := TfrmSelectGoodsToAddDlg.Create(self, IBCQueryJurnalKit, IBCDataSourceJurnalKit,
        IBCQueryTenderItems.FieldByName('GOODSID').asInteger);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExistsInComplect;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := True;
        if dialog.ShowModal = mrOk then
        begin
             //dmDB.FullRefresh;
            RefreshFromComplect;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.ShowModifyGoodsDialog;
var
    dialog: TfrmAddItemsToTender;
begin
    dialog := TfrmAddItemsToTender.Create(self, IBCQueryTenderItems, IBCDataSourceTenderItems);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := False;
        if dialog.ShowModal = mrOk then
        begin
            dmDB.IBCQueryDocs.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.ShowModifyGoodsInComplectDialog;
var
    dialog: TfrmSelectGoodsToAddDlg;
begin
    dialog := TfrmSelectGoodsToAddDlg.Create(self, IBCQueryJurnalKit, IBCDataSourceJurnalKit,
        IBCQueryTenderItems.FieldByName('GOODSID').asInteger);
    try
        dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExistsInComplect;
        dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
        dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

        dialog.AddNewGoods := False;
        if dialog.ShowModal = mrOk then
        begin
            RefreshFromComplect;
             //dmDB.IBCQueryDocs.Refresh;
             //dmDB.IBCQueryJurnal.Refresh;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.ShowRascetKonfiguratiiDialog;
var
    dialog: TfrmRascetKonfiguratiiDlg;
begin
     // Calcul configuratie
    dialog := TfrmRascetKonfiguratiiDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
    try
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure Tframe93Tender.DeleteSelectedGoods;
var
    S, S2: string;
    flag: Boolean;
begin
     // confirmation flag
    flag := AppUserConfigStorage.Confirmations.GetValue('ASK_GoodsDelete');
    if not flag then
    begin
        S := Format(cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации, [ibcQueryTenderItems.FieldByName
            ('GOODS_NAME').asString]);
          // confirmation
        if ShowAskDialogVerification(cMSG_DELETERECORD_DeleteGoods, S,
            cMSG_CONFIRMATION_DoNotAskAgain, S2, flag) <> mrYes then
            Exit;
        AppUserConfigStorage.Confirmations.SetValue('ASK_GoodsDelete', flag);
    end;

    dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
    try
        IBCQueryTenderItems.Delete;
        IBCQueryTenderItems.UpdateTransaction.Commit;
        dmDB.IBCQueryDocs.Refresh;
    except
        on E: Exception do
        begin
            IBCQueryTenderItems.UpdateTransaction.Rollback;
            if not ProcessSWNError(E) then
                raise;
        end;
    end;
end;

procedure Tframe93Tender.DeleteSelectedGoodsInComplect;
var
    S, S2: string;
    flag: Boolean;
begin
     // confirmation flag
    flag := AppUserConfigStorage.Confirmations.GetValue('ASK_GoodsDelete');
    if not flag then
    begin
        S2 := 'Complect: ' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString;
        S := Format(cMSG_DELETERECORD_КОНФИГУРАЦИИ_Быстрый_расчет_конфигурации2, [IBCQueryJurnalKit.FieldByName
            ('GOODS_NAME').asString]);

        if ShowAskDialogVerification(cMSG_DELETERECORD_DeleteGoods, S,
            cMSG_CONFIRMATION_DoNotAskAgain, S2, flag) <> mrYes then
            Exit;
        AppUserConfigStorage.Confirmations.SetValue('ASK_GoodsDelete', flag);
    end;

    IBCQueryJurnalKit.UpdateTransaction.StartTransaction;
    try
        IBCQueryJurnalKit.Delete;
        IBCQueryJurnalKit.UpdateTransaction.Commit;
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

function Tframe93Tender.GetPhoneNumber;
begin
    inherited;
    result := '';
    frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
    try
        frmSelectPhoneNumber.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
        if frmSelectPhoneNumber.ShowModal = mrOK then
        begin
            result := frmSelectPhoneNumber.SelectedPhoneNumber;
        end;
    finally
        frmSelectPhoneNumber.Free;
    end;
end;

procedure Tframe93Tender.ShowSelectKitTemplateDialog;
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

function Tframe93Tender.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var
    i: integer;
begin
    result := False;
    for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
    begin
        if cxGridComponentsTable.DataController.Values[i, cxGridComponentsTableGOODSID.Index] = GoodsID then
        begin
            result := True;
            Break;
        end;
    end;
end;

function Tframe93Tender.WhenCheckIfGoodsExistsInComplect(const GoodsID: integer): Boolean;
var
    i: integer;
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

procedure Tframe93Tender.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    DocumentSelectionChanged;
end;

procedure Tframe93Tender.WhenDocumentPopupMenu;
//var
//  fPopup1, fPopup2, fPopup3, fDiscount: Boolean;
begin
//  fPopup1 := False;     // Creare "Nakladnaia de iesire"
//  fPopup2 := False;     // Creare "Nakladnaia de iesire in service"
//  fPopup3 := False;     // Creare "Factura de plata" + Security
//  fDiscount := False; // Discount
//  if cxGridBRKDBTable.DataController.RecNo > 0 then
//  begin
//          // Creare "Nakladnaia de iesire"
//    fPopup1 := True;
//          // Creare "Nakladnaia de iesire in service"
//    fPopup2 := True;
//          // Creare "Factura de plata" + Security
//    fPopup3 := ((dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger = 498)); // Valuta = MDL
//          // Discount
//    fDiscount := dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat > 0;
//  end;
//     // popup
//  bbPopup_CreateRashod.Enabled := fPopup1;  // Creare "Nakladnaia de iesire"
//  bbPopup_Menu2.Enabled := fPopup2;  // Creare "Nakladnaia de iesire in service"
//  bbPopup_CreateScet.Enabled := fPopup3;  // Creare "Factura de plata"
//  bbDocDiscount.Enabled := fDiscount;
end;

procedure Tframe93Tender.WhenGoodsComplectGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsComplectSelectionChanged;
end;

procedure Tframe93Tender.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView;
    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
    GoodsSelectionChanged;
end;

procedure Tframe93Tender.SetupDefaultFocus;
begin
     // grid
    cxGridBRK.SetFocus;
     // columns
    cxGridBRKDB_CT_NAME.Focused := True;
    cxGridComponentsTableGOODS_NAME.Focused := True;
    cxGridComplect_GOODS_NAME.Focused := True;
end;

procedure Tframe93Tender.SetupQtyFields;
begin
     // Componenta: Cantitate
    TcxCalcEditProperties(cxGridComponentsTableQTY.Properties).DisplayFormat := QtyDisplayFormat;
    cxGridComponentsTableQTY.Summary.FooterFormat := QtyDisplayFormat;
     // Componenta: Stoc
//  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
     // Configurare set: Cantitate
    TcxCalcEditProperties(cxGridComplect_QTY.Properties).DisplayFormat := QtyDisplayFormat;
    cxGridComplect_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Configurare set: Stoc
    TcxCalcEditProperties(cxGridComplect_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe93Tender.SetupSecurityItems;
begin
    fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Просмотр);
    fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Создать);
    fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Изменить);
    fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Удалить);

     // Coloana preturi
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

//  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Видеть_колонку_цен) or
//    SWNSecurityManager.IsPartialAccessMode then
//  begin
//    cxGridComponents_PRICE_COLUMN.Visible := False;
//    cxGridComponents_PRICE_COLUMN.VisibleForCustomization := False;
//  end;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_Oferte_Calcul_TVA_0) then
        bbTVA0.Visible := ivNever;

    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КОНФИГУРАЦИИ_Конфигуратор_Дополнительные_операции)
        then
        cxGridPopupMenuBRK.PopupMenus.Clear;

     // Fisa produsului
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара)
        or SWNSecurityManager.IsPartialAccessMode then
    begin
        bbGoodsInfoCard.Visible := ivNever;
        bbKitGoodsInfoCard.Visible := ivNever;
    end;
     // Modifica preturile marfii
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара)
        or SWNSecurityManager.IsPartialAccessMode then
    begin
        bbGoodsPrice.Visible := ivNever;
        bbKitGoodsPrice.Visible := ivNever;
    end;
     // Corespondenta produsului in alte firme
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    begin
        bbGoodsForeignCode.Visible := ivNever;
        bbKitGoodsForeignCode.Visible := ivNever;
    end;

    if SWNSecurityManager.IsPartialAccessMode then
    begin
        cxGridBRK_FLG_ACNT.Visible := False;
        cxGridBRK_FLG_ACNT.VisibleForCustomization := False;
        bbTVA0.Visible := ivNever;
    end;

    if (dxBarPopupMenuCOMPONENTS.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuCOMPONENTS.PopupMenus.Clear;
    if (dxBarPopupMenuCOMPLECT.ItemLinks.VisibleItemCount = 0) then
        cxGridPopupMenuCOMPLECT.PopupMenus.Clear;
end;

procedure Tframe93Tender.ShowKitchenTemplate;
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


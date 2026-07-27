unit frame79AnalizePriceListUnit;
{
  Frame Index = 79
  Analiza PriceList
}

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ImgList, SWNDataFiltering,
   SWNBaseFrameUnit, SWNDocumentFilters, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
   cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
   cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxBar, ExtCtrls,
   DBAccess, IBC, MemDS, cxLabel, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, Vcl.Menus, Vcl.StdCtrls,
   cxButtons, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
   cxCalendar, cxTextEdit, cxCalc, cxProgressBar, dxRatingControl, cxContainer, cxDropDownEdit, cxLookupEdit,
   cxDBLookupEdit, cxDBLookupComboBox, cxMaskEdit, cxButtonEdit, cxPC, frmPrepareGoodsForImportUnit,
  dxScrollbarAnnotations, cxMemo, cxTL, cxTLdxBarBuiltInMenu, cxInplaceContainer, cxDBTL, cxTLData,
  dxCoreGraphics;

type
   Tframe79AnalizePriceList = class(TSWNBaseFrame)
      IBCQueryPriceItems: TIBCQuery;
      IBCDataSourcePriceItems: TIBCDataSource;
      Panel1: TPanel;
      Label1: TLabel;
      Label2: TLabel;
      lcbCurrentPrice: TcxLookupComboBox;
      lcbOldPricelist: TcxLookupComboBox;
      cxButton1: TcxButton;
      IBCQueryOldPriceList: TIBCQuery;
      IBCQueryCurrentPriceList: TIBCQuery;
      IBCQueryOldGoods: TIBCQuery;
      IBCDataSourceOldGoods: TIBCDataSource;
      IBCQueryPricesUp: TIBCQuery;
      IBCDataSourcePricesUp: TIBCDataSource;
      IBCQueryPricesDown: TIBCQuery;
      IBCDataSourcePricesSown: TIBCDataSource;
      IBCQueryNewGoods: TIBCQuery;
      IBCDataSourceNewGoods: TIBCDataSource;
      IBCDataSourceCurrentPriceList: TIBCDataSource;
      IBCDataSourceOldPriceList: TIBCDataSource;
      Label3: TLabel;
      beCustomer: TcxButtonEdit;
      Panel2: TPanel;
      cxPageControl1: TcxPageControl;
      tbsAllPriceList: TcxTabSheet;
      cxGrid1: TcxGrid;
      cxGrid1DBTableView1: TcxGridDBTableView;
      cxGrid1DBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
      cxGrid1DBTableView1OLD_PRICE0: TcxGridDBColumn;
      cxGrid1DBTableView1OLD_PRICE7: TcxGridDBColumn;
      cxGrid1DBTableView1SUPPLIER_GOODS_CODE_1: TcxGridDBColumn;
      cxGrid1DBTableView1NEW_PRICE0: TcxGridDBColumn;
      cxGrid1DBTableView1NEW_PRICE7: TcxGridDBColumn;
      cxGrid1DBTableView1FLAGS: TcxGridDBColumn;
      cxGrid1Level1: TcxGridLevel;
      cxTabSheet1: TcxTabSheet;
      cxTabSheet2: TcxTabSheet;
      cxGrid2: TcxGrid;
      cxGrid2DBTableViewOldGoods: TcxGridDBTableView;
      cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_CODE: TcxGridDBColumn;
      cxGrid2DBTableViewOldGoodsSUPPLIER_GOODS_NAME: TcxGridDBColumn;
      cxGrid2DBTableViewOldGoodsNEW_PRICE0: TcxGridDBColumn;
      cxGrid2DBTableViewOldGoodsNEW_PRICE7: TcxGridDBColumn;
      cxGrid2Level1: TcxGridLevel;
      cxTabSheet3: TcxTabSheet;
      cxGrid4: TcxGrid;
      cxGridDBTableView2: TcxGridDBTableView;
      cxGridDBTableView2SUPPLIER_GOODS_CODE: TcxGridDBColumn;
      cxGridDBTableView2SUPPLIER_GOODS_NAME: TcxGridDBColumn;
      cxGridDBTableView2NEW_PRICE7: TcxGridDBColumn;
      cxGridDBTableView2DEVIATION: TcxGridDBColumn;
      cxGridLevel2: TcxGridLevel;
      cxTabSheet4: TcxTabSheet;
      cxGrid5: TcxGrid;
      cxGridDBTableView3: TcxGridDBTableView;
      cxGridDBTableView3SUPPLIER_GOODS_CODE: TcxGridDBColumn;
      cxGridDBTableView3SUPPLIER_GOODS_NAME: TcxGridDBColumn;
      cxGridDBTableView3NEW_PRICE0: TcxGridDBColumn;
      cxGridDBTableView3NEW_PRICE7: TcxGridDBColumn;
      cxGridDBTableView3DEVIATION: TcxGridDBColumn;
      cxGridLevel3: TcxGridLevel;
      dxBarDockControl1: TdxBarDockControl;
      dxBarManager1: TdxBarManager;
      dxBarManager1Bar1: TdxBar;
      bbLinkGoods: TdxBarButton;
    cxGridDBTableView2OLD_PRICE7: TcxGridDBColumn;
    Panel3: TPanel;
    cxGrid3: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1SUPPLIER_GOODS_CODE: TcxGridDBColumn;
    cxGridDBTableView1SUPPLIER_GOODS_NAME: TcxGridDBColumn;
    cxGridDBTableView1NEW_PRICE0: TcxGridDBColumn;
    cxGridDBTableView1NEW_PRICE7: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxDBTreeList1: TcxDBTreeList;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
      procedure beCustomerClick(Sender: TObject);
      procedure cxTabSheet2Hide(Sender: TObject);
      procedure cxTabSheet2Show(Sender: TObject);
      procedure cxButton1Click(Sender: TObject);
      procedure cxTabSheet1Hide(Sender: TObject);
      procedure cxTabSheet1Show(Sender: TObject);
      procedure cxTabSheet3Hide(Sender: TObject);
      procedure cxTabSheet3Show(Sender: TObject);
      procedure cxTabSheet4Hide(Sender: TObject);
      procedure cxTabSheet4Show(Sender: TObject);
      procedure bbLinkGoodsClick(Sender: TObject);
   private
      procedure WhenCustomDataFilterGetSQL(var FilterSQL: string);
      procedure WhenCustomDataFilterSetParams(const Query: TIBCQuery);
   protected
    { Protected declarations }
      dialog: TfrmPrepareGoodsForImportDlg;
      function InitFrameID: Integer; override;
      function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
      procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
      procedure DoFrameHide; override;
      procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
      function GetFilterFields: TFrameFilterFields; override;
      function GetFrameButtons: TFrameButtons; override;
      procedure CreateNewRecord; override;
      procedure DeleteRecord; override;
      procedure PrepareGoods(ActivePageIndex: Integer);
      procedure PrepareGoodsDecreasePrices;
      procedure PrepareGoodsIncreasePrices;
      procedure PrepareNewGoods;
      procedure PrepareOldGoods;
      procedure TabsheetsEnabled(AState: Boolean);
      procedure ReadFrameStates; override;
      procedure SaveFrameStates; override;
      procedure SelectCustomer;
   public
    { Public declarations }
      procedure SetupDefaultFocus; override;
   end;

implementation

uses
   DataModuleAdditions, frmCustomersDlg, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, SWNTypes, Vcl.Dialogs,
   SWNValueStorageUnit, frmPricelistImportUnit, uAnalizePriceList, frmAnalizePriceListUnit;

{$R *.dfm}

procedure Tframe79AnalizePriceList.CreateNewRecord;
//var
//   dialog: TfrmOportunitatiDlg;
begin
//   dialog := TfrmOportunitatiDlg.Create(Self);
//   try
//      dialog.CreateNewDocument := True;
//      dialog.ShowModal;
//   finally
//      dialog.Free;
//   end;
end;

procedure Tframe79AnalizePriceList.DeleteRecord;
begin
   inherited;

end;

procedure Tframe79AnalizePriceList.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
   CloseExternalData;
     // 1. De scos la griduri event handles for OnFocusedRecordChanged

   // 2. De deconectat sursele de date de la griduri

   IBCQueryCurrentPriceList.Active := False;
   IBCQueryOldPriceList.Active := False;

   IBCQueryPriceItems.Active := False;
   IBCQueryOldGoods.Active := False;
   IBCQueryNewGoods.Active := False;
   IBCQueryPricesUp.Active := False;
   IBCQueryPricesDown.Active := False;

   if Assigned(dialog) then
      dialog.Free;
   inherited;
end;

procedure Tframe79AnalizePriceList.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
   customizedFilterData: TFrameDataFilteringInfo;
begin
   inherited;

     // 1. Legam grid-urile de datasource-sele

     // 2. Selection handlers
//     cxGridOportunitatiTable.OnFocusedRecordChanged:=cxGridOportunitatiTableFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
     // aici mai avem nevoie de un filtru special. indicam procedurile pentru call-back
//   customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
//   try
//      customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
//      customizedFilterData.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
//      OpenExternalData(customizedFilterData);
//   finally
//      customizedFilterData.Free;
//   end;

   cxPageControl1.ActivePageIndex := 0;
   TabsheetsEnabled(False);

end;

procedure Tframe79AnalizePriceList.bbLinkGoodsClick(Sender: TObject);
begin
   inherited;
   PrepareGoods(cxPageControl1.ActivePageIndex);
end;

procedure Tframe79AnalizePriceList.beCustomerClick(Sender: TObject);
begin
   SelectCustomer;
end;

procedure Tframe79AnalizePriceList.cxButton1Click(Sender: TObject);
begin
   TabsheetsEnabled(True);
   if IBCQueryCurrentPriceList.Active then
   begin
//   if cxPageControl1.ActivePageIndex = 0 then // toate produsele
   begin
      IBCQueryPriceItems.Close;
      IBCQueryPriceItems.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPriceItems.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPriceItems.Open;
   end;

//   if cxPageControl1.ActivePageIndex = 1 then    // produse noi
   begin
      IBCQueryNewGoods.Close;
      IBCQueryNewGoods.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
      IBCQueryNewGoods.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
      IBCQueryNewGoods.Open;
   end;

//   if cxPageControl1.ActivePageIndex = 2 then    // produse eliminate
   begin
      IBCQueryOldGoods.Close;
      IBCQueryOldGoods.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
      IBCQueryOldGoods.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
      IBCQueryOldGoods.Open;
   end;

//   if cxPageControl1.ActivePageIndex = 3 then    // produse cu preturi majorate
   begin
      IBCQueryPricesUp.Close;
      IBCQueryPricesUp.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPricesUp.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPricesUp.Open;
   end;

//   if cxPageControl1.ActivePageIndex = 4 then    // produse cu preturi majorate
   begin
      IBCQueryPricesDown.Close;
      IBCQueryPricesDown.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPricesDown.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
      IBCQueryPricesDown.Open;
   end;
   end;
end;

procedure Tframe79AnalizePriceList.cxTabSheet1Hide(Sender: TObject);
begin
   inherited;
//   IBCQueryNewGoods.Close;
end;

procedure Tframe79AnalizePriceList.cxTabSheet1Show(Sender: TObject);
begin
//   if IBCQueryCurrentPriceList.Active then
//   begin
//   IBCQueryNewGoods.Close;
//   IBCQueryNewGoods.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryNewGoods.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryNewGoods.Open;
//   end;
end;

procedure Tframe79AnalizePriceList.cxTabSheet2Hide(Sender: TObject);
begin
//   IBCQueryOldGoods.Close;
end;

procedure Tframe79AnalizePriceList.cxTabSheet2Show(Sender: TObject);
begin
//   if IBCQueryCurrentPriceList.Active then
//   begin
//   IBCQueryOldGoods.Close;
//   IBCQueryOldGoods.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryOldGoods.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryOldGoods.Open;
//   end;
end;

procedure Tframe79AnalizePriceList.cxTabSheet3Hide(Sender: TObject);
begin
//   IBCQueryPricesUp.Close;
end;

procedure Tframe79AnalizePriceList.cxTabSheet3Show(Sender: TObject);
begin
//   if IBCQueryCurrentPriceList.Active then
//   begin
//   IBCQueryPricesUp.Close;
//   IBCQueryPricesUp.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryPricesUp.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryPricesUp.Open;
//   end;
end;

procedure Tframe79AnalizePriceList.cxTabSheet4Hide(Sender: TObject);
begin
//   IBCQueryPricesDown.Close;
end;

procedure Tframe79AnalizePriceList.cxTabSheet4Show(Sender: TObject);
begin
//   if IBCQueryCurrentPriceList.Active then
//   begin
//   IBCQueryPricesDown.Close;
//   IBCQueryPricesDown.ParamByName('NEW_PLID').AsInteger := IBCQueryCurrentPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryPricesDown.ParamByName('OLD_PLID').AsInteger := IBCQueryOldPriceList.FieldByName('PLID').AsInteger;
//   IBCQueryPricesDown.Open;
//   end;
end;

procedure Tframe79AnalizePriceList.TabsheetsEnabled(AState: Boolean);
begin
   cxTabSheet1.Enabled := AState;
   cxTabSheet2.Enabled := AState;
   cxTabSheet3.Enabled := AState;
   cxTabSheet4.Enabled := AState;
end;

function Tframe79AnalizePriceList.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
   Result := [fedsPriceList];
end;

function Tframe79AnalizePriceList.GetFilterFields: TFrameFilterFields;
begin
   Result := [];
end;

function Tframe79AnalizePriceList.GetFrameButtons: TFrameButtons;
begin
   Result := [];
end;

function Tframe79AnalizePriceList.InitFrameID: Integer;
begin
   Result := 79;  // Analize Pricelist
end;

procedure Tframe79AnalizePriceList.PrepareGoods(ActivePageIndex: Integer);
begin
   case ActivePageIndex of
      1:
         PrepareNewGoods;
      2:
         PrepareOldGoods;
      3:
         PrepareGoodsIncreasePrices;
      4:
         PrepareGoodsDecreasePrices;
   end;
end;

procedure Tframe79AnalizePriceList.PrepareGoodsDecreasePrices;
begin

end;

procedure Tframe79AnalizePriceList.PrepareGoodsIncreasePrices;
begin
end;

procedure Tframe79AnalizePriceList.PrepareNewGoods;
begin
   if not Assigned(dialog) then
      dialog := TfrmPrepareGoodsForImportDlg.Create(Self, dmDB.IBCConnection, IBCQueryNewGoods);
   dialog.SupplierID := beCustomer.Tag;
   dialog.SupplierName := beCustomer.Text;
   dialog.Show;
end;

procedure Tframe79AnalizePriceList.PrepareOldGoods;
begin

end;

procedure Tframe79AnalizePriceList.ReadFrameStates;
begin
//   AppUserConfigStorage.OpenSection(Self.Name);
//   try
//      ReadGridColumnsSettings(cxGridOportunitatiTable);
//   finally
//      AppUserConfigStorage.CloseSection;
//   end;
end;

procedure Tframe79AnalizePriceList.SaveFrameStates;
begin
// De memorizat ultimul furnizor !!!

//   AppUserConfigStorage.OpenSection(Self.Name);
//   try
//      SaveGridColumnsSettings(cxGridOportunitatiTable);
//   finally
//      AppUserConfigStorage.CloseSection;
//   end;
end;

procedure Tframe79AnalizePriceList.SelectCustomer;
var
   dialog: TfrmCustomersDlg;
begin
   dialog := TfrmCustomersDlg.Create(Self);
   try
        //dialog.CustomFilter:=dialog.CustomFilter;   // Gheorghian, 28.03.2011
      if dialog.SelectCustomer(beCustomer.Tag, False, 0, 'Alege furnizor de pricelist') then
      begin
         beCustomer.Tag := dialog.CustomerID;
         beCustomer.Text := dialog.CustomerTitle;

         lcbCurrentPrice.Enabled := True;
         IBCQueryCurrentPriceList.Close;
         IBCQueryCurrentPriceList.ParamByName('SUPPLIERID').AsInteger := beCustomer.Tag;
         IBCQueryCurrentPriceList.Open;

         lcbOldPricelist.Enabled := True;
         IBCQueryOldPriceList.Close;
         IBCQueryOldPriceList.ParamByName('SUPPLIERID').AsInteger := beCustomer.Tag;
         IBCQueryOldPriceList.Open;
      end
      else
      begin
         lcbCurrentPrice.Enabled := False;
         lcbOldPricelist.Enabled := False;
         TabsheetsEnabled(False);
      end;
   finally
      dialog.Free;
   end;
end;

procedure Tframe79AnalizePriceList.SetupDefaultFocus;
begin
     // focused grid
//   cxGridOportunitati.SetFocus;
     // set default focused column
end;

procedure Tframe79AnalizePriceList.WhenCustomDataFilterGetSQL(var FilterSQL: string);
begin
//   FilterSQL := FilterSQL + ' AND DT = :DT';
end;

procedure Tframe79AnalizePriceList.WhenCustomDataFilterSetParams(const Query: TIBCQuery);
begin
//   Query.ParamByName('DT').AsInteger := dmDB.FirmaInfo.FirmaID; // Subdiviziunea
end;

procedure Tframe79AnalizePriceList.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
//var
//   customizedFilterData: TFrameDataFilteringInfo;
begin
//   customizedFilterData := TFrameDataFilteringInfo.Create(FrameDataFilterInfo);
//   try
//      customizedFilterData.OnCustomDataFilterGetSQL := WhenCustomDataFilterGetSQL;
//      customizedFilterData.OnCustomDataFilterSetParams := WhenCustomDataFilterSetParams;
//      inherited WhenFilterDataChanged(customizedFilterData);
//   finally
//      customizedFilterData.Free;
//   end;
end;

end.


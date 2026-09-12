unit frame19СчетаВходныеСчетаUnit;

// FACTURI. Facturi de intrare
// DocTypeID = 1455
// Frame Index = 19

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, DB,
  cxDBData, dxBar, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, IBC,
  cxGridPopupMenu, cxCalc, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  cxImageComboBox, dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses,
  SWNValueStorageUnit, dxUIAClasses;

type
  Tframe19ScetaVhodnieSceta = class(TSWNBaseFrame)
    cxGridPTN: TcxGrid;
    cxGridPTNTable: TcxGridDBTableView;
    cxGridPTN_DOCID: TcxGridDBColumn;
    cxGridPTN_DATA: TcxGridDBColumn;
    cxGridPTN_DTDEP_NAME: TcxGridDBColumn;
    cxGridPTN_CT_NAME: TcxGridDBColumn;
    cxGridPTN_SUMA: TcxGridDBColumn;
    cxGridPTN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridPTN_VAT: TcxGridDBColumn;
    cxGridPTN_FLG_ACNT: TcxGridDBColumn;
    cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    pnBottom: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    bbCreatePrihodRashod: TdxBarButton;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    dxBarPopupMenuDOCS: TdxBarPopupMenu;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    bbGoodsTools: TdxBarSubItem;
    bbImportGoods: TdxBarButton;
    bbAnalyzeGoods: TdxBarButton;
    dxBarPopupMenuCOMPONENTS: TdxBarPopupMenu;
    cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
    bbGoodsInfoCard: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    bbGoodsForeignCode: TdxBarButton;
    dxBarButton2: TdxBarButton;
    bbXMLExport: TdxBarButton;
    SaveDialog1: TSaveDialog;
    cxGridComponents_PRICE_USD: TcxGridDBColumn;
    cxGridComponents_SUMA_USD: TcxGridDBColumn;
    cxGridComponentsTableColumn1: TcxGridDBColumn;
    bbPaymentRequest: TdxBarButton;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbCreatePrihodRashodClick(Sender: TObject);
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridPTNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbImportGoodsClick(Sender: TObject);
    procedure bbAnalyzeGoodsClick(Sender: TObject);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure bbXMLExportClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbPaymentRequestClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;

    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;

    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure WhenDocumentPopupMenuOpen;

    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;

    procedure CreatePrihodnaiaNakladnaia;
    function DoAction_PrihodnaiaNakladnaiaDB: Boolean;
    procedure Export2XML;

    procedure ShowImportVendorGoodsDialog;
    procedure ShowAnalyzeGoodsPricesDialog;

    procedure SetupQtyFields;

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
    procedure CloneRecord; override;

    procedure SetupSecurityItems; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, frmВходныеСчетаDocDialog,
  SWNUtils, SWNDBErrors, frmSelectGoodsToAddDialog, SWNSecurity,
  SWNSecurityFlags, frmImportGoodsPricesDialog,
  frmVhodnieScetaGoodsAnalyzeDialog, SWNCommonDialogs, Xml.XMLDoc, Xml.XMLIntf,
  frmCerereDePlataDialog;

{$R *.dfm}

{ Tframe44ScetaVhodnieSceta }

procedure Tframe19ScetaVhodnieSceta.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe19ScetaVhodnieSceta.bbAnalyzeGoodsClick(Sender: TObject);
begin
  ShowAnalyzeGoodsPricesDialog;
end;

procedure Tframe19ScetaVhodnieSceta.bbCreatePrihodRashodClick(Sender: TObject);
begin
  CreatePrihodnaiaNakladnaia;
end;

procedure Tframe19ScetaVhodnieSceta.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe19ScetaVhodnieSceta.bbDeleteGoodsClick(Sender: TObject);
begin
  DeleteSelectedGoods;
end;

procedure Tframe19ScetaVhodnieSceta.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe19ScetaVhodnieSceta.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe19ScetaVhodnieSceta.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe19ScetaVhodnieSceta.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe19ScetaVhodnieSceta.bbImportGoodsClick(Sender: TObject);
begin
  ShowImportVendorGoodsDialog;
end;

procedure Tframe19ScetaVhodnieSceta.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe19ScetaVhodnieSceta.bbPaymentRequestClick(Sender: TObject);
var
  frmCerereDePlataDlg: TfrmCerereDePlataDlg;
begin
  inherited;
  frmCerereDePlataDlg := TfrmCerereDePlataDlg.Create(Owner, dmDB.IBCConnection);
  try
    frmCerereDePlataDlg.Amount := dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat;
    frmCerereDePlataDlg.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    frmCerereDePlataDlg.CustomerName := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    frmCerereDePlataDlg.PaymentDate := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    frmCerereDePlataDlg.ShowModal;
  finally
    frmCerereDePlataDlg.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.bbXMLExportClick(Sender: TObject);
begin
  Export2XML;
end;

procedure Tframe19ScetaVhodnieSceta.CloneRecord;
var
  S: string;
  newDocID: Integer;
begin
  S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
  if ShowAskDialog('Clonarea documentului', 'Clonarea configuratiei №' + S + '?') <> mrYes then
    Exit;

  if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID, 0) then
  begin
    dmDB.RefreshDocs;
    dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
    ShowInfoDialog('Clonarea documentului', 'O nou copie a fost creata.'#13#10'Configuratia №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString);
  end;
end;

procedure Tframe19ScetaVhodnieSceta.CreateNewRecord;
var
  dialog: TfrmVhodnieScetaDocDlg;
begin
  dialog := TfrmVhodnieScetaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Stergeti inregistrarea nr.%d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe19ScetaVhodnieSceta.DeleteSelectedGoods;
var
  S: string;
begin
  S := #13#10 + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '?';
  if ShowAskDialog('Stergere produs', 'Doriti sa stergeti produsul' + S) = mrYes then
  begin
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
end;

function Tframe19ScetaVhodnieSceta.DoAction_PrihodnaiaNakladnaiaDB: Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
           // Creare "Factura de intrare"
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_INCOME_INVOICE(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe19ScetaVhodnieSceta.DocSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDebts, fImportGoods: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;
  fDebts := False;
  fImportGoods := False;

  if cxGridPTNTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;
    fDebts := True;
    fImportGoods := not FLG_CLOSED;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  bbCustomerDebts.Enabled := fDebts;
  bbImportGoods.Enabled := fImportGoods;

  GoodsSelectionChanged;
end;

procedure Tframe19ScetaVhodnieSceta.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridPTNTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridPTNTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe19ScetaVhodnieSceta.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridPTNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridPTNTable.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocSelectionChanged;
end;

procedure Tframe19ScetaVhodnieSceta.dxBarButton2Click(Sender: TObject);
begin
  CloneRecord;
end;

procedure Tframe19ScetaVhodnieSceta.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe19ScetaVhodnieSceta.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridPTNTable.Site.Focused then
  begin
              // context from Docs
    if cxGridPTN_CT_NAME.Focused then
    begin
                   // Furnizor
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridPTN_DATA.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridPTN_DTDEP_NAME.Focused then
    begin
                           // Depozit
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe19ScetaVhodnieSceta.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe19ScetaVhodnieSceta.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe19ScetaVhodnieSceta.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe19ScetaVhodnieSceta.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete, fGoodsSelected: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;
  fGoodsSelected := False;

  if (cxGridPTNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fGoodsNew := fSECURITY_CanEdit and not FLG_CLOSED; // New Goods + Security
    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      fGoodsEdit := fSECURITY_CanEdit and not FLG_CLOSED;   // Edit Goods + Security
      fGoodsDelete := fSECURITY_CanEdit and not FLG_CLOSED; // Delete Goods + Security
      fGoodsSelected := True;
    end;
  end;
     // goods
  bbAddGoods.Enabled := fGoodsNew;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbDeleteGoods.Enabled := fGoodsDelete;
     // popup menu
  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;

  bbAnalyzeGoods.Visible := ivNever;
  bbAnalyzeGoods.Enabled := False;
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or not SWNSecurityManager.IsPartialAccessMode then
  begin
    bbAnalyzeGoods.Enabled := cxGridComponentsTable.DataController.RecordCount > 0;
    bbAnalyzeGoods.Visible := ivAlways;
  end;
end;

function Tframe19ScetaVhodnieSceta.InitFrameID: Integer;
begin
     // FACTURI - Facturi de intrare
  Result := 19;
  SetupQtyFields;
end;

procedure Tframe19ScetaVhodnieSceta.ModifyRecord;
var
  dialog: TfrmVhodnieScetaDocDlg;
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if fSECURITY_CanEdit and not FLG_CLOSED then
  begin
    dialog := TfrmVhodnieScetaDocDlg.Create(Self);
    try
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridPTNTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;

end;

procedure Tframe19ScetaVhodnieSceta.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridPTNTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.SetupDefaultFocus;
begin
     // grid
  cxGridPTN.SetFocus;
     // columns
  cxGridPTN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe19ScetaVhodnieSceta.SetupQtyFields;
begin
     // Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Stoc
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe19ScetaVhodnieSceta.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_ВС_Удалить);

  if not fSECURITY_CanEdit then
  begin
    bbAddGoods.Visible := ivNever;
    bbModifyGoods.Visible := ivNever;
    bbDeleteGoods.Visible := ivNever;
  end;
  if (dxBarManagerBar1.ItemLinks.VisibleItemCount = 0) then
  begin
    dxBarManagerBar1.Visible := False;
    dxBarDockControl1.Visible := False;
  end;

     // Fisa produsului
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsInfoCard.Visible := ivNever;
     // Modifica preturile marfii
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPrice.Visible := ivNever;
     // Corespondenta produsului in alte firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
  end;

  bbXMLExport.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROFORME_CDA_Export_XML), ivAlways, ivNever);

  if (dxBarPopupMenuCOMPONENTS.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuCOMPONENTS.PopupMenus.Clear;
end;

procedure Tframe19ScetaVhodnieSceta.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    dialog.DefaultPriceColumn := 7;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    if (dialog.ShowModal = mrOk) then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.ShowAnalyzeGoodsPricesDialog;
var
  dialog: TfrmVhodnieScetaGoodsAnalyzeDlg;
begin
  dialog := TfrmVhodnieScetaGoodsAnalyzeDlg.Create(Self);
  try
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.ShowImportVendorGoodsDialog;
var
  dialog: TfrmImportGoodsPricesDlg;
begin
  dialog := TfrmImportGoodsPricesDlg.Create(Self, dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString);
  try
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.ImportGoodsTarget := igtVhodnieSceta;
    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
    dialog.DefaultPriceColumn := 0;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryDocs.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe19ScetaVhodnieSceta.WhenDocumentPopupMenuOpen;
var
  fCreatePrihodRashod: Boolean;
  FLG_CLOSED: Boolean;
begin
  fCreatePrihodRashod := False;

  if (cxGridPTNTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger = 1) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fCreatePrihodRashod := (not FLG_CLOSED);     // Creare Nakladnaia de intrare
  end;
     // popup menu
  bbCreatePrihodRashod.Enabled := fCreatePrihodRashod;  // Creare Nakladnaia de intrare
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe19ScetaVhodnieSceta.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe19ScetaVhodnieSceta.CreatePrihodnaiaNakladnaia;
begin
  if ShowAskDialog('Creare "Factura de intrare"', 'Doriti sa creati "Factura de intrare"?') = mrYes then
  begin
    if DoAction_PrihodnaiaNakladnaiaDB then
    begin
      dmDB.FullRefresh;
      ShowInfoDialog('Factura de intrare', 'Factura de intrare a fost creata!');
    end;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift, True);
end;

procedure Tframe19ScetaVhodnieSceta.cxGridComponentsTableKeyPress(Sender: TObject; var Key: Char);
begin
     // special pentru Kiril
  if (Key = '+') and (bbAddGoods.Enabled) then
    bbAddGoodsClick(bbAddGoods);
end;

procedure Tframe19ScetaVhodnieSceta.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe19ScetaVhodnieSceta.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
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

procedure Tframe19ScetaVhodnieSceta.cxGridPTNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridPTNTable, Key, Shift);
end;

procedure Tframe19ScetaVhodnieSceta.cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridPTN_DATA.Index]);
end;

procedure Tframe19ScetaVhodnieSceta.Export2XML;
var
  XML: TXMLDocument;
  node: IXMLNode;
  node1: IXMLNode;
  q: TIBCQuery;
begin
  XML := TXMLDocument.Create(Self);
  q := TIBCQuery.Create(Self);
  dmDB.IBCQueryJurnal.DisableControls;
  try
    XML.Active := True;
    XML.Options := [doNodeAutoCreate, doNodeAutoIndent];
    XML.Version := '1.0';
    XML.Encoding := 'UTF-8';

    node := XML.AddChild('Comanda');
    node.AddChild('CodeFiscal_Client').Text := '1004600055542'; //GetCustomerIDNO(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
    node.AddChild('Denumire_Client').Text := 'GAMA COMPUTER SRL';
    node.AddChild('Adresa_Contract').Text := 'or.Chisinau, str. M.Manole 12/2';
    node.AddChild('NumarComanda').Text := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
    node.AddChild('DataComanda').Text := DateToStr(Date);
    node.AddChild('DataRidicare').Text := DateToStr(Date);

    q.sql.Text := 'select goods_code from ts_goods_foreign where customerid = :customerid and goodsid = :goodsid';
    q.Prepare;

    while not dmDB.IBCQueryJurnal.EOF do
    begin
      with node.AddChild('lista_nomenclatura') do
      begin
        q.Active := False;
        q.ParamByName('customerid').AsInteger := dmDB.IBCQueryDocs.FieldByName('ct').AsInteger;
        q.ParamByName('goodsid').AsInteger := dmDB.IBCQueryJurnal.FieldByName('goodsid').AsInteger;
        q.Active := True;

        Attributes['barcode'] := q.FieldByName('GOODS_CODE').AsString;
        Attributes['denumire'] := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
        Attributes['cantitate'] := dmDB.IBCQueryJurnal.FieldByName('QTY').AsString;
      end;
      dmDB.IBCQueryJurnal.Next;
    end;
    SaveDialog1.FileName := 'Achizitie Nr. ' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + '.xml';
    if SaveDialog1.Execute then
      XML.SaveToFile(SaveDialog1.FileName);
  finally
    XML.Free;
    q.Free;
    dmDB.IBCQueryJurnal.EnableControls;
  end;
end;

end.


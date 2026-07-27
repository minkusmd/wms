unit frame14NareadSborkaUnit;

// СБОРКА. Наряд на сборку
// DocTypeID = 113
// Frame Index = 14

interface

uses
  Classes, Controls, DB, DBAccess, Dialogs, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages, SWNBaseFrameUnit,
  SWNDataFiltering, SysUtils, Variants, Windows, cxCalc, cxCheckBox, cxClasses, cxControls, cxCurrencyEdit, cxCustomData,
  cxDBData, cxData, cxDataStorage, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomPopupMenu, cxGridCustomTableView,
  cxGridCustomView, cxGridDBTableView, cxGridLevel, cxGridPopupMenu, cxGridTableView, cxImageComboBox, cxLabel,
  cxLookAndFeelPainters, cxLookAndFeels, cxNavigator, cxPC, cxSplitter, cxStyles, dxBar, dxBarBuiltInMenu, dxDateRanges,
  dxScrollbarAnnotations,

  System.UITypes, dxUIAClasses;

type
  Tframe14NareadSborka = class(TSWNBaseFrame)
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    cxPageControlComplect: TcxPageControl;
    tbsGoods: TcxTabSheet;
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
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    tbsKitContent: TcxTabSheet;
    cxGridComplect: TcxGrid;
    cxGridComplectTable: TcxGridDBTableView;
    cxGridComplect_GOODSID: TcxGridDBColumn;
    cxGridComplect_GOODS_TYPE_ID: TcxGridDBColumn;
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
    cxGridComplectLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbSerialPartNumbers: TdxBarButton;
    cxGridSborka: TcxGrid;
    cxGridSborkaTable: TcxGridDBTableView;
    cxGridSborkaTableDocID: TcxGridDBColumn;
    cxGridSborka_DATA: TcxGridDBColumn;
    cxGridSborkaTableWarehouse: TcxGridDBColumn;
    cxGridSborkaTableCtName: TcxGridDBColumn;
    cxGridSborkaTableSuma: TcxGridDBColumn;
    cxGridSborkaTableCurrencyName: TcxGridDBColumn;
    cxGridSborkaTableVAT: TcxGridDBColumn;
    cxGridSborkaTableRate: TcxGridDBColumn;
    cxGridSborkaTableParentDocID: TcxGridDBColumn;
    cxGridSborka_FLG_ACNT: TcxGridDBColumn;
    cxGridSborkaTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridSborkaTable_FLG_CLOSED: TcxGridDBColumn;
    cxGridSborkaLevel: TcxGridLevel;
    IBCQueryJurnalKit: TIBCQuery;
    IBCDataSourceJurnalKit: TIBCDataSource;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    cxGridComplect_FLG_READY: TcxGridDBColumn;
    bbMarkAsReady: TdxBarButton;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbAddGoodsComplect: TdxBarButton;
    bbModifyGoodsComplect: TdxBarButton;
    bbDeleteGoodsComplect: TdxBarButton;
    bbSerialGoods: TdxBarButton;
    cxGridComplect_DTDEP_NAME: TcxGridDBColumn;
    bbDocOpen: TdxBarButton;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    bbCreateRazborca: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridComponentsCOST: TcxGridDBColumn;
    cxGridComplectCOST: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComplect_UMID: TcxGridDBColumn;
    bbSubItemsPriceColumns: TdxBarSubItem;
    bbPriceCol0: TdxBarButton;
    bbPriceCol1: TdxBarButton;
    bbPriceCol2: TdxBarButton;
    bbPriceCol3: TdxBarButton;
    bbPriceCol4: TdxBarButton;
    bbPriceCol5: TdxBarButton;
    bbPriceCol6: TdxBarButton;
    bbPriceCol7: TdxBarButton;
    cxGridComponents_PRICE_USD: TcxGridDBColumn;
    cxGridComponents_SUMA_USD: TcxGridDBColumn;
    cxGridComplect_PRICE_USD: TcxGridDBColumn;
    cxGridComplect_SUMA_USD: TcxGridDBColumn;
    dxBarPopupMenuGoods: TdxBarPopupMenu;
    cxGridPopupMenuGoods: TcxGridPopupMenu;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    cxGridComplectTableColumn1: TcxGridDBColumn;
    dxBarButton4: TdxBarButton;
    cxGridSborka_FLG_FURNITURE: TcxGridDBColumn;
    bbCost2Price: TdxBarButton;
    bbImport: TdxBarButton;
    bbGoodsBySupplier: TdxBarButton;
    procedure bbMarkAsReadyClick(Sender: TObject);
    procedure bbAddGoodsComplectClick(Sender: TObject);
    procedure bbModifyGoodsComplectClick(Sender: TObject);
    procedure bbDeleteGoodsComplectClick(Sender: TObject);
    procedure bbSerialGoodsClick(Sender: TObject);
    procedure bbSerialPartNumbersClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure cxGridSborkaTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSborkaTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSborkaTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbDocOpenClick(Sender: TObject);
    procedure bbCreateRazborcaClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridSborka_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbPriceCol0Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbCost2PriceClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    function DoImportFromPrihodnayaNakl_inDoc_db(const Docid: integer): integer;
    procedure bbGoodsBySupplierClick(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: integer;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenGoodsComplectGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsComplectSelectionChanged;
    function MarkDocAsShipped(const DocID: integer): Boolean;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure RemoveSelectedGoods;
    procedure ShowAddGoodsComplectDialog;
    procedure ShowModifyGoodsComplectDialog;
    procedure RemoveSelectedGoodsComplect;
    procedure ShowSerialPartNumbersGoodsDialogs;
    procedure ShowSerialPartNumbersGoodsComplectDialogs;
    procedure ShowGoodsSerialNumbersDialog(const ViewOnly: Boolean);
    procedure ShowGoodsComplectSerialNumberDialog(const ViewOnly: Boolean);
    procedure ShowGoodsComplectPartNumberDialog(const ViewOnly: Boolean);
    procedure ResfreshGoods;
    procedure ResfreshGoodsComplect;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
    function CreateRazborcaDB(const DocID: integer): Boolean;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure CloneRecord; override;
    procedure SetupSecurityItems; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    function KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const RemoveExisting: Boolean): Integer;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNCommonDialogs, SWNDBErrors, SWNSecurity, SWNSecurityFlags, SWNTypes, SWNUtils,
  SWNValueStorageUnit, frmDocumentDeleteDialog, frmNSbDocDialog, frmSelectGoodsToAddDialog,
  frmSelectPartNumbersParentedDialog, frmSelectSNParentedDialog, frmSerialNumbersDialog, frmDocumentBrowserDialog,
  SWNConst;

{$R *.dfm}

{ Tframe14NareadSborka }

procedure Tframe14NareadSborka.bbMarkAsReadyClick(Sender: TObject);
begin
     // Комплект готов
  if ShowAskDialog('Комплекты готовы', 'Все комплекты были собранны?') = mrYes then
  begin
    if MarkDocAsShipped(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      DocumentSelectionChanged;
      GoodsSelectionChanged;
      GoodsComplectSelectionChanged;
    end;
  end;
end;

procedure Tframe14NareadSborka.bbSerialPartNumbersClick(Sender: TObject);
begin
  ShowSerialPartNumbersGoodsComplectDialogs;
end;

procedure Tframe14NareadSborka.CloneRecord;
var
  S: string;
  newDocID: integer;
begin
  S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
  if ShowAskDialog('Клонирование документа', 'Создать копию наряда на сборку №' + S + '?') <> mrYes then
    Exit;

  if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
  begin
    dmDB.RefreshDocs;
    dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
    ShowInfoDialog('Клонирование документа', 'Созданна новая копия.'#13#10'Конфигурация №' + dmDB.IBCQueryDocs.FieldByName
      ('DOCID').AsString);
  end;
end;

procedure Tframe14NareadSborka.CreateNewRecord;
var
  dialog: TfrmNSbDocDlg;
begin
  dialog := TfrmNSbDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

function Tframe14NareadSborka.CreateRazborcaDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_DISASSEMBLY_FROM_ASSEMBLY(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    try
      Query.Transaction.StartTransaction;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
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

procedure Tframe14NareadSborka.cxGridComplectTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGoodsComplect.Enabled then
  begin
    ShowModifyGoodsComplectDialog;
    AHandled := True;
  end;
end;

procedure Tframe14NareadSborka.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe14NareadSborka.cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComplectTable, Key, Shift);
end;

procedure Tframe14NareadSborka.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComplect_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe14NareadSborka.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe14NareadSborka.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe14NareadSborka.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe14NareadSborka.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe14NareadSborka.cxGridSborkaTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe14NareadSborka.cxGridSborkaTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridSborkaTable_FLG_CLOSED.Index]) then
  begin
    if (AViewInfo.GridRecord.Values[cxGridSborkaTable_FLG_CLOSED.Index] = 1) then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridSborka_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end
    else
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridSborka_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;

    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe14NareadSborka.cxGridSborkaTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridSborkaTable, Key, Shift);
end;

procedure Tframe14NareadSborka.cxGridSborka_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridSborka_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridSborka_DATA.Index]);
end;

procedure Tframe14NareadSborka.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe14NareadSborka.bbDeleteGoodsClick(Sender: TObject);
begin
  RemoveSelectedGoods;
end;

procedure Tframe14NareadSborka.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe14NareadSborka.bbSerialGoodsClick(Sender: TObject);
begin
  ShowSerialPartNumbersGoodsDialogs;
end;

procedure Tframe14NareadSborka.bbAddGoodsComplectClick(Sender: TObject);
begin
  ShowAddGoodsComplectDialog;
end;

procedure Tframe14NareadSborka.bbCost2PriceClick(Sender: TObject);
begin
  if not IBCQueryJurnalKit.UpdateTransaction.Active then
    IBCQueryJurnalKit.UpdateTransaction.StartTransaction;

  try
  IBCQueryJurnalKit.First;
  while not IBCQueryJurnalKit.Eof do
  begin
    IBCQueryJurnalKit.Edit;
    IBCQueryJurnalKit.FieldByName('Price').AsVariant := IBCQueryJurnalKit.FieldByName('COST').AsVariant;
    IBCQueryJurnalKit.Post;
    IBCQueryJurnalKit.Next;
  end;
    IBCQueryJurnalKit.UpdateTransaction.Commit;
  except on e: Exception do
    begin
      IBCQueryJurnalKit.UpdateTransaction.Rollback;
      raise;
    end;
  end;

end;

procedure Tframe14NareadSborka.bbCreateRazborcaClick(Sender: TObject);
begin
  if ShowAskDialog('Создать Разборку', 'Вы хотите разобрать данную сборку?') = mrYes then
  begin
    if CreateRazborcaDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ShowInfoDialog('Разборка', 'Созданна новая разборка.');
  end;
end;

procedure Tframe14NareadSborka.bbDeleteGoodsComplectClick(Sender: TObject);
begin
  RemoveSelectedGoodsComplect;
end;

procedure Tframe14NareadSborka.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe14NareadSborka.bbDocOpenClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe14NareadSborka.bbGoodsBySupplierClick(Sender: TObject);
begin
  dmdb.GetSupplierGoodsByDocID;
end;

procedure Tframe14NareadSborka.bbImportClick(Sender: TObject);
var
  dialog: TfrmDocumentBrowserDlg;
  docid: integer;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.FixedDocTypeID := True;
    dialog.DefaultDocTypeID := 106;
    dialog.DefaultUserID := dmDB.CurrentUserID;
//    dialog.DefaultCT := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Facturi', Format('Doriti sa importati din documentul: №%d?',
        [dialog.DocID])) = mrYes then
      begin
        docid := DoImportFromPrihodnayaNakl_inDoc_db(dialog.DocID);
        dmDb.IBCQueryDocs.Refresh;
        dmDb.IBCQueryDocs.Locate('DOCID', docid, []);
        dmdb.IBCQueryJurnal.Refresh;
        ShowInfoDialog('Facturi', 'Document importat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe14NareadSborka.DoImportFromPrihodnayaNakl_inDoc_db(const
  Docid: integer): integer;
var
  Query: TIBCQuery;
begin
  Result := 0;
  Query := TIBCQuery.Create(Self);
  try
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text :=
        'SELECT NEW_DOCID FROM SP_IMPORT_IN_SBORKA(:DOCID, :current_docid, :COMPLECTID)';
      Query.Params.ParamByName('DOCID').AsInteger := Docid;
      Query.Params.ParamByName('COMPLECTID').AsInteger := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
      Query.Params.ParamByName('Current_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
      Query.ExecSQL;
      if not Query.Eof then
        Result := Query.Fields[0].AsInteger;
      Query.Transaction.Commit;
      IBCQueryJurnalKit.Refresh;
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

procedure Tframe14NareadSborka.bbModifyGoodsComplectClick(Sender: TObject);
begin
  ShowModifyGoodsComplectDialog;
end;

procedure Tframe14NareadSborka.bbPriceCol0Click(Sender: TObject);
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
    GoodsParentID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').asInteger;
    GoodsParentTitle := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString;
    GoodsParentGoodsCount := IBCQueryJurnalKit.RecordCount;
  end;

  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName
    ('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, GoodsParentID, PriceColumn, GoodsParentTitle,
    GoodsParentGoodsCount) then
    RefreshData;
end;

procedure Tframe14NareadSborka.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryJurnalKit.Active := False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridSborkaTable.OnFocusedRecordChanged := nil;
  cxGridComplectTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridSborkaTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe14NareadSborka.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridSborkaTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridSborkaTable.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGridFocusedRecordChanged;
  cxGridComplectTable.OnFocusedRecordChanged := WhenGoodsComplectGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryJurnalKit.Active := True;

     // 4. Selection update
  cxPageControlComplect.ActivePage := tbsGoods;
  DocumentSelectionChanged;

end;

procedure Tframe14NareadSborka.DoOpenDocument;
begin
  if ShowAskDialog('Открыть документ', 'Вы хотите открыть документ?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe14NareadSborka.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_ASSEMBLY_REOPEN(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    try
      Query.Transaction.StartTransaction;
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
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

procedure Tframe14NareadSborka.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName
    ('GOODS_NAME').AsString);

end;

procedure Tframe14NareadSborka.dxBarButton2Click(Sender: TObject);
begin
  inherited;
  TSWNCommonDialogs.GoodsForeignCode(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe14NareadSborka.dxBarButton3Click(Sender: TObject);
var
  Allow: Boolean;
  ClearAll: Boolean;
  RecordsAdded: Integer;
begin
  ClearAll := True;
     // ask for options
  if IBCQueryJurnalKit.RecordCount > 0 then
    Allow := ShowAskDialogVerification('Добавление из комплекта', 'Добавить товары из комплекта в данную конфигурацию?',
      'Удалить существующие товары?', Format('Комплект: %s', [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]), ClearAll) = mrYes
  else
    Allow := True;

  if Allow then
  begin
    RecordsAdded := KitAddGoodsFromComplectDB(dmDB.IBCQueryJurnal.FieldByName('DOCID').asInteger, dmDB.IBCQueryJurnal.FieldByName
      ('GOODSID').asInteger, ClearAll);
    if (RecordsAdded <= 0) then
      ShowErrorDialog('Добавление из комплекта', 'В данном комплекте отсутствуют товары!', 'Смотрите "Комплектация" в справочнике товаров.')
    else
    begin
      dmDB.FullRefresh;
      IBCQueryJurnalKit.Refresh;
      ShowInfoDialog('Добавление из комплекта', Format('Готово! Добавленно товаров: %d ', [RecordsAdded]));
    end;
  end;
end;

function Tframe14NareadSborka.KitAddGoodsFromComplectDB(const DocID, GoodsID: Integer; const RemoveExisting: Boolean): Integer;
var
  Query: TIBCQuery;
begin
  Result := -1;
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
        Result := Query.Fields[0].AsInteger;
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

function Tframe14NareadSborka.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridSborkaTable.Site.Focused then
  begin
              // context from Docs
    if cxGridSborkaTableCtName.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridSborka_DATA.Focused then
    begin
                       // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridSborkaTableWarehouse.Focused then
    begin
                           // Склад
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe14NareadSborka.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe14NareadSborka.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe14NareadSborka.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe14NareadSborka.GoodsComplectSelectionChanged;
var
  fKitSerialPartNo, FLG_CLOSED: Boolean;
  fKitAdd, fKitModify, fKitDelete: Boolean;
begin
     // additional buttons
  fKitSerialPartNo := False;

  fKitAdd := False;
  fKitModify := False;
  fKitDelete := False;

  if cxGridSborkaTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1; // Document closed
    if (cxGridComponentsTable.DataController.RecNo > 0) and (dmdb.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger)) then
    begin
               // Комплектация
      fKitAdd := fSECURITY_CanEdit and not FLG_CLOSED; // Добавить товар
      if cxGridComplectTable.DataController.RecNo > 0 then
      begin
        fKitModify := fSECURITY_CanEdit and not FLG_CLOSED;  // Изменить товар
        fKitDelete := fSECURITY_CanEdit and not FLG_CLOSED;  // Удалить товар
                    // Серийный учет & Партийный учет
        fKitSerialPartNo := (IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
          cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
          cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
      end;
    end;
  end;
     // Комплектация
  bbAddGoodsComplect.Enabled := fKitAdd;
  bbModifyGoodsComplect.Enabled := fKitModify;
  bbDeleteGoodsComplect.Enabled := fKitDelete;

  bbSerialPartNumbers.Enabled := fKitSerialPartNo;
end;

procedure Tframe14NareadSborka.GoodsSelectionChanged;
var
  fKit: Boolean;
  fComplectAdd, fComplectEdit, fComplectDelete, fComplectSerial, fChangePrice: Boolean;
  FLG_CLOSED: Boolean;
begin
     // additional buttons
  fKit := False;

  fComplectAdd := False;
  fComplectEdit := False;
  fComplectDelete := False;
  fComplectSerial := False;
  fChangePrice := False;

  if cxGridSborkaTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1; // Document closed
    fComplectAdd := (fSECURITY_CanEdit and not FLG_CLOSED); // Добавить комплект
    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
               // Состав
      fComplectEdit := fSECURITY_CanEdit and not FLG_CLOSED; // Изменить комплект
      fComplectDelete := fSECURITY_CanEdit and not FLG_CLOSED;
      fKit := dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger);
               // Серийный учет
      fComplectSerial := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет);
      fChangePrice := not FLG_CLOSED;
    end;
  end;
     // tabs
  tbsKitContent.TabVisible := fKit;

     // Состав
  bbAddGoods.Enabled := fComplectAdd;
  bbModifyGoods.Enabled := fComplectEdit;
  bbDeleteGoods.Enabled := fComplectDelete;
  bbSerialGoods.Enabled := fComplectSerial;
  bbPriceCol0.Enabled := fChangePrice;
  bbPriceCol1.Enabled := fChangePrice;
  bbPriceCol2.Enabled := fChangePrice;
  bbPriceCol3.Enabled := fChangePrice;
  bbPriceCol4.Enabled := fChangePrice;
  bbPriceCol5.Enabled := fChangePrice;
  bbPriceCol6.Enabled := fChangePrice;
  bbPriceCol7.Enabled := fChangePrice;

  GoodsComplectSelectionChanged;
end;

function Tframe14NareadSborka.InitFrameID: integer;
begin
  Result := 14; // СБОРКА - Наряд на сборку
  SetupQtyFields;
end;

function Tframe14NareadSborka.MarkDocAsShipped(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := false;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_ASSEMBLY(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := DocID;
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

procedure Tframe14NareadSborka.ModifyRecord;
var
  dialog: TfrmNSbDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmNSbDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridSborkaTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
    ReadGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe14NareadSborka.RefreshData;
begin
  inherited;
  IBCQueryJurnalKit.Refresh;
end;

procedure Tframe14NareadSborka.RemoveSelectedGoods;
var
  S: string;
begin
  S := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '?';
  if ShowAskDialog('Удаление товара', 'Вы хотите удалить товар' + #13#10 + S) = mrYes then
  begin
    dmDB.IBCQueryJurnal.UpdateTransaction.StartTransaction;
    try
      dmDB.IBCQueryJurnal.Delete;
      dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
      dmDB.IBCQueryDocs.Refresh;
    except
      dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure Tframe14NareadSborka.RemoveSelectedGoodsComplect;
var
  S, S2: string;
begin
  S := #13#10 + Format('[%d] - %s', [IBCQueryJurnalKit.FieldByName('GOODSID').asInteger, IBCQueryJurnalKit.FieldByName('GOODS_NAME').AsString])
    + #13#10;
  S2 := Format('Комплект: [%d] - %s', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString]);
  if ShowAskDialog('Удаление товара из комплектации', 'Вы хотите удалить товар' + S + 'из комплекта?', S2) = mrYes then
  begin
    IBCQueryJurnalKit.UpdateTransaction.StartTransaction;
    try
      IBCQueryJurnalKit.Delete;
      IBCQueryJurnalKit.UpdateTransaction.Commit;
      dmDB.FullRefresh;
    except
      on E: Exception do
      begin
        IBCQueryJurnalKit.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe14NareadSborka.ResfreshGoods;
var
  N1: integer;
begin
  N1 := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
  dmDB.IBCQueryDocs.Refresh;
  dmDB.IBCQueryJurnal.Refresh;
  dmDB.IBCQueryJurnal.Locate('GOODSID', N1, []);
end;

procedure Tframe14NareadSborka.ResfreshGoodsComplect;
var
  N1, N2: integer;
begin
  dmDB.IBCQueryDocs.DisableControls;
  dmDB.IBCQueryJurnal.DisableControls;
  IBCQueryJurnalKit.DisableControls;
  try
    N1 := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    N2 := IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger;

    dmDB.IBCQueryDocs.Refresh;

    dmDB.IBCQueryJurnal.Refresh;
    dmDB.IBCQueryJurnal.Locate('GOODSID', N1, []);

    IBCQueryJurnalKit.Refresh;
    IBCQueryJurnalKit.Locate('GOODSID', N2, []);
  finally
    dmDB.IBCQueryDocs.EnableControls;
    dmDB.IBCQueryJurnal.EnableControls;
    IBCQueryJurnalKit.EnableControls;
  end;
end;

procedure Tframe14NareadSborka.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridSborkaTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
    SaveGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe14NareadSborka.SetupDefaultFocus;
begin
     // grid
  cxGridSborka.SetFocus;
     // columns
  cxGridSborkaTableCtName.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
  cxGridComplect_GOODS_NAME.Focused := True;
end;

procedure Tframe14NareadSborka.SetupQtyFields;
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

procedure Tframe14NareadSborka.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Редактировать);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Комплекты_собраны) then
  begin
    bbMarkAsReady.Visible := ivNever;
    bbCreateRazborca.Visible := ivNever;
  end;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СБОРКА_ННС_Открыть_закрытую_сборку) then
    bbDocOpen.Visible := ivNever;

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

  if (bbSubItemsPriceColumns.ItemLinks.VisibleItemCount = 0) then
    bbSubItemsPriceColumns.Visible := ivNever;

end;

procedure Tframe14NareadSborka.DeleteRecord;
begin
  DeleteCurrentSWNDocument(Self);
end;

procedure Tframe14NareadSborka.DocumentSelectionChanged;
var
  DocChanged: Boolean;
  fAdd, fEdit, fDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCloseComplect, fOpenComplect, fRazborca, fDocComments: Boolean;
begin
  fAdd := fSECURITY_CanNew;
  fEdit := False;
  fDelete := False;
  DocChanged := False;

  fCloseComplect := False;
  fOpenComplect := False;
  fRazborca := False;
  fDocComments := False;

  if cxGridSborkaTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;
    fDelete := fSECURITY_CanEdit and not FLG_CLOSED;

    DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fCloseComplect := not FLG_CLOSED;  // Комплект готов + Security
    fOpenComplect := FLG_CLOSED;  // Открыть закрытую сборку
    fRazborca := FLG_CLOSED;

    fDocComments := fSECURITY_CanEdit;
  end;

     // doc
  ButtonStateChanged(fbtADD, fAdd);
  ButtonStateChanged(fbtMODIFY, fEdit);
  ButtonStateChanged(fbtDELETE, fDelete);

     // popup
  bbMarkAsReady.Enabled := fCloseComplect;
  bbDocOpen.Enabled := fOpenComplect;
  bbCreateRazborca.Enabled := fRazborca;
  bbDocComments.Enabled := fDocComments;

     // tab
  if DocChanged then
  begin
    cxPageControlComplect.ActivePage := tbsGoods;
  end;

  if not (dmDB.IBCQueryDocs.FieldByName('DT').AsInteger = 238300) then
  begin
    bbCost2Price.Visible := ivNever;
    bbImport.Visible := ivNever;
  end
  else
  begin
    bbCost2Price.Visible := ivAlways;
    bbImport.Visible := ivAlways;
  end;


  GoodsSelectionChanged;
end;

procedure Tframe14NareadSborka.dxBarButton4Click(Sender: TObject);
begin
      FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe14NareadSborka.ShowAddGoodsComplectDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName
    ('GOODSID').AsInteger);
  try
    dialog.AddNewGoods := True;
    dialog.AllowedActions := dialog.AllowedActions - [acChangeWarranty, acChangeStock] + [acChangePrice];
    dialog.VisibleActions := dialog.VisibleActions + [acChangeStock];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
      dmDB.IBCQueryJurnal.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.AddNewGoods := True;
    dialog.GoodsTypeFilter := [gtfComplect];
    dialog.AllowedActions := dialog.AllowedActions - [acChangeStock];
    dialog.DefaultPriceColumn := 0;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowModifyGoodsComplectDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, IBCQueryJurnalKit, IBCDataSourceJurnalKit, dmDB.IBCQueryJurnal.FieldByName
    ('GOODSID').AsInteger);
  try
    dialog.AddNewGoods := False;
    dialog.AllowedActions := dialog.AllowedActions - [acChangeWarranty, acChangeStock] + [acChangePrice];
    dialog.VisibleActions := dialog.VisibleActions + [acChangeStock];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
      dmDB.IBCQueryJurnal.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal, -1);
  try
    dialog.AddNewGoods := False;
    dialog.GoodsTypeFilter := [gtfComplect];
    dialog.AllowedActions := dialog.AllowedActions - [acChangeStock];
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowSerialPartNumbersGoodsComplectDialogs;
var
  N: integer;
  readonly: Boolean;
begin
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  N := IBCQueryJurnalKit.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger;
  if (N = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
    ShowGoodsComplectSerialNumberDialog(readonly)  // Серийный учет
  else if (N = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет) then
    ShowGoodsComplectPartNumberDialog(readonly); // Партийный учет
end;

procedure Tframe14NareadSborka.ShowSerialPartNumbersGoodsDialogs;
var
  readonly: Boolean;
begin
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

     // ONLY Серийный учет
  if (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) then
    ShowGoodsSerialNumbersDialog(readonly);
end;

procedure Tframe14NareadSborka.ShowGoodsComplectPartNumberDialog(const ViewOnly: Boolean);
var
  frmSelectPartsDlg: TfrmSelectPartNoParentedDlg;
begin
  frmSelectPartsDlg := TfrmSelectPartNoParentedDlg.Create(self, dmDB.IBCQueryJurnal, IBCQueryJurnalKit, dmDB.IBCDataSourceJurnal,
    IBCDataSourceJurnalKit);
  try
    frmSelectPartsDlg.readonly := ViewOnly;
    if frmSelectPartsDlg.ShowModal = mrOk then
      ResfreshGoodsComplect;
  finally
    frmSelectPartsDlg.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowGoodsComplectSerialNumberDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSelectSNParentedDlg;
begin
  dialog := TfrmSelectSNParentedDlg.Create(self, dmDB.IBCQueryJurnal, IBCQueryJurnalKit, dmDB.IBCDataSourceJurnal, IBCDataSourceJurnalKit);
  try
    dialog.readonly := ViewOnly;
    if dialog.ShowModal = mrOk then
      ResfreshGoodsComplect;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.ShowGoodsSerialNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NeuronSborkaMode := True;
    if dialog.ShowModal = mrOk then
      ResfreshGoods;
  finally
    dialog.Free;
  end;
end;

procedure Tframe14NareadSborka.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe14NareadSborka.WhenGoodsComplectGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsComplectSelectionChanged;
end;

procedure Tframe14NareadSborka.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


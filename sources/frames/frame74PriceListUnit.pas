unit frame74PriceListUnit;

// СЧЕТА. Входные Счета
// DocTypeID = 3126
// Frame Index = 74

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, dxBar, cxClasses, cxSplitter, ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, IBC, cxLookAndFeels,
  cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, frameScanFiles,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, cxPC, DBAccess, MemDS, dxDateRanges,
  dxScrollbarAnnotations, cxTextEdit;

type
  Tframe74PriceList = class(TSWNBaseFrame)
    cxGrid1DB_DOCS: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxSplitter1: TcxSplitter;
    cxGrid2DB_ConcurentsURL: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    bbImportFromExcel: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGrid1DB_DOCS_DOCID: TcxGridDBColumn;
    cxGrid1DB_DOCS_DATE: TcxGridDBColumn;
    cxGrid1DB_DOCS_CT_NAME: TcxGridDBColumn;
    cxGrid1DB_DOCS_CREATEDBY_NAME: TcxGridDBColumn;
    cxGrid2DB_Concurents_GOODSID: TcxGridDBColumn;
    cxGrid2DB_Concurents_GOODS_NAME: TcxGridDBColumn;
    cxGrid2DB_Concurents_URL: TcxGridDBColumn;
    cxGrid2DB_Concurents_PRICE4: TcxGridDBColumn;
    cxGrid2DB_Concurents_PRICE7: TcxGridDBColumn;
    cxGrid2DB_Concurents_PRICE_CONCURENT: TcxGridDBColumn;
    bbImportFromCatalog: TdxBarButton;
    bbDeleteAll: TdxBarButton;
    cxGrid2DB_Concurents_MODEL: TcxGridDBColumn;
    dxBarButton2: TdxBarButton;
    cxGrid2DB_Concurents_Diff: TcxGridDBColumn;
    cxGrid2DB_ConcurentsURLColumn2: TcxGridDBColumn;
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridDocsPriceCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure bbImportFromCatalogClick(Sender: TObject);
    procedure bbImportFromExcelClick(Sender: TObject);
    procedure bbDeleteAllClick(Sender: TObject);
    procedure cxGrid1DB_DOCSKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure dxBarButton2Click(Sender: TObject);
    procedure cxGrid2DB_ConcurentsURLColumn1StylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGrid2DB_ConcurentsURLKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;
    procedure DoImportFromCatalog(GoodsID: Integer);
    procedure WhenDocumentPopupMenuOpen;
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
    procedure SetupSecurityItems; override;
    procedure RefreshData; override;
  public
    procedure DoImportFromClipboard;
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, SWNUtils, SWNDBErrors, frmSelectGoodsToAddDialog,
  SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit, SWNCommonDialogs, frmPriceListDocUnit, Vcl.Clipbrd, frmGoods, frmImportGoodsConcurentsUnit;

{$R *.dfm}

{ Tframe44ScetaVhodnieSceta }

procedure Tframe74PriceList.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe74PriceList.bbDeleteAllClick(Sender: TObject);
begin
  inherited;
  cxGrid2DB_ConcurentsURL.BeginUpdate();
  while cxGrid2DB_ConcurentsURL.DataController.RecordCount>0 do
  begin
    cxGrid2DB_ConcurentsURL.DataController.DeleteRecord(0);
  end;
  cxGrid2DB_ConcurentsURL.EndUpdate;

end;

procedure Tframe74PriceList.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe74PriceList.bbImportClick(Sender: TObject);
begin
  inherited;
  DoImportFromClipboard;
end;

procedure Tframe74PriceList.bbImportFromCatalogClick(Sender: TObject);
var
    dialog: TfrmGoodsBrowser;
begin
    dialog := TfrmGoodsBrowser.Create(self);
    try
        if (dialog.SelectGoods(-1, True)) then
        begin
            DoImportFromCatalog(dialog.GoodsID);
        end;
    finally
        dialog.Free;
    end;

end;

procedure Tframe74PriceList.bbImportFromExcelClick(Sender: TObject);
var
    dialog: TfrmImportGoodsConcurentsDlg;
begin
    dialog := TfrmImportGoodsConcurentsDlg.Create(self);
    try
        dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
        if dialog.ShowModal = mrOk then
          RefreshData;
    finally
        dialog.Free;
    end;
end;

procedure Tframe74PriceList.CreateNewRecord;
var
  dialog: TfrmPriceListDocDialog;
begin
  dialog := TfrmPriceListDocDialog.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe74PriceList.cxGrid1DB_DOCSKeyDown(Sender: TObject; var Key:
    Word; Shift: TShiftState);
begin
    ProcessCommonKeys(cxGrid1DB_DOCS, Key, Shift);
end;

procedure Tframe74PriceList.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge documentul Nr. №%d?', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').AsInteger])) = mrYes then
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

procedure Tframe74PriceList.DocSelectionChanged;
begin

end;

procedure Tframe74PriceList.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;
    dmDB.IBCQueryDocs.Close;
    IBCQueryGoods.Close;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
    cxGrid1DB_DOCS.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
    cxGrid1DB_DOCS.DataController.DataSource := nil;
    cxGrid2DB_ConcurentsURL.DataController.DataSource := nil;
//
  inherited;
end;

procedure Tframe74PriceList.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
    cxGrid1DB_DOCS.DataController.DataSource := dmDB.IBCDataSourceDocs;
    cxGrid2DB_ConcurentsURL.DataController.DataSource := IBCDataSourceGoods;

     // 2. Selection handlers
    cxGrid1DB_DOCS.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
    IBCQueryGoods.Active := True;

     // 4. Selection update
    DocSelectionChanged;
end;

procedure Tframe74PriceList.dxBarButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryGoods.Delete;
end;

procedure Tframe74PriceList.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe74PriceList.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe74PriceList.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoodsConcurents];
end;

function Tframe74PriceList.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe74PriceList.InitFrameID: integer;
begin
     // Concurents goods URL
  Result := 74;
  SetupQtyFields;
end;

procedure Tframe74PriceList.ModifyRecord;
var
    dialog: TfrmPriceListDocDialog;
    FLG_CLOSED: Boolean;
begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if not FLG_CLOSED then
    begin
        dialog := TfrmPriceListDocDialog.Create(Self);
        try
            dialog.CreateNewDocument := False;
            dialog.ShowModal;
        finally
            dialog.Free;
        end;
    end;
end;

procedure Tframe74PriceList.RefreshData;
begin
  dmDB.IBCQueryDocs.Refresh;
  IBCQueryGoods.Refresh;
end;

procedure Tframe74PriceList.SetupDefaultFocus;
begin
     // grid
  cxGrid1.SetFocus;
//     // columns
//  cxGrid2DB_ConcurentsURL.Focused := True;
end;

procedure Tframe74PriceList.SetupQtyFields;
begin
    inherited;
end;

procedure Tframe74PriceList.SetupSecurityItems;
begin
  { TODO : De modificat securiltatile pentru frame }
    fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROFORME_LDP_Document_nou);

    fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROFORME_LDP_Document_nou);
    fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROFORME_LDP_Modifica_document);
    fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_PROFORME_LDP_Sterge_document);

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    cxGrid2.Visible := False;
  end;
end;

procedure Tframe74PriceList.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe74PriceList.WhenDocumentPopupMenuOpen;
begin
end;

procedure Tframe74PriceList.cxGrid2DB_ConcurentsURLColumn1StylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if ARecord.Values[cxGrid2DB_Concurents_Diff.Index]>0 then
    AStyle := dmAdditions.cxStyle_TextColorRed;

end;

procedure Tframe74PriceList.cxGrid2DB_ConcurentsURLKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
    ProcessCommonKeys(cxGrid2DB_ConcurentsURL, Key, Shift);
end;

procedure Tframe74PriceList.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe74PriceList.cxGridDocsPriceCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var
  AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe74PriceList.DoImportFromCatalog(GoodsID: Integer);
begin
    dmdb.ExecuteQuery('EXECUTE PROCEDURE SP_IMPORT_GOODS_CONCURENTS(:DOCID, :FOLDERID, :CT)',
                        [
                            dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,
                            GoodsID,
                            dmDB.IBCQueryDocs.FieldByName('CT').AsInteger
                        ]);
    IBCQueryGoods.Refresh;
end;

procedure Tframe74PriceList.DoImportFromClipboard;
var
  stringlist:   TStringList;
  I: Integer;
begin
  stringlist := TStringList.Create;
  try
    stringlist.CommaText := Clipboard.AsText;
    for I := 0 to stringlist.count-1 do
    begin

    end;
  finally
    stringlist.Free;
  end;
end;

end.


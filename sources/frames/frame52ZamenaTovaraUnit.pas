unit frame52ZamenaTovaraUnit;
{
  СЕРВИС. Замена товара у поставщика
  DocTypeID = 1945
  Frame Index = 52
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, System.UITypes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxCheckBox, cxCurrencyEdit, cxLabel, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxSplitter, cxGridCustomPopupMenu,
  cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS, cxGridBandedTableView,
  cxGridDBBandedTableView, cxNavigator, DataModuleDB, cxDataControllerConditionalFormattingRulesManagerDialog,
  dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe52ZamenaTovara = class(TSWNBaseFrame)
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGrid_FLG_CLOSED: TcxGridDBColumn;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_DTDEP_NAME: TcxGridDBColumn;
    cxGrid_CT_NAME: TcxGridDBColumn;
    cxGrid_SUMA: TcxGridDBColumn;
    cxGrid_CURRENCY_NAME: TcxGridDBColumn;
    cxGrid_VAT: TcxGridDBColumn;
    cxGrid_RATE: TcxGridDBColumn;
    cxGrid_PARENTDOCID: TcxGridDBColumn;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    cxGrid_FLG_ACNT: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridGoodsTable: TcxGridDBBandedTableView;
    cxGridGoods_DT_DEP_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_DT_GOODSID: TcxGridDBBandedColumn;
    cxGridGoods_DT_GOODS_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_DT_IDENT: TcxGridDBBandedColumn;
    cxGridGoods_CT_DEP_TITLE: TcxGridDBBandedColumn;
    cxGridGoods_CT_GOODSID: TcxGridDBBandedColumn;
    cxGridGoods_CT_IDENT: TcxGridDBBandedColumn;
    cxGridGoods_CT_GOODS_TITLE: TcxGridDBBandedColumn;
    cxGrid_DT_NAME: TcxGridDBColumn;
    cxGridGoods_CT_DATE: TcxGridDBBandedColumn;
    cxGridGoods_CT_CREATED_BY_NAME: TcxGridDBBandedColumn;
    cxGridGoods_DT_CREATED_BY_NAME: TcxGridDBBandedColumn;
    cxGridGoods_DT_PRICE: TcxGridDBBandedColumn;
    cxGridGoods_CT_PRICE: TcxGridDBBandedColumn;
    bbTargetGoods: TdxBarButton;
    pmDocs: TdxBarPopupMenu;
    bbNoClosedGoods: TdxBarButton;
    IBCQueryGoods: TIBCQuery;
    cxGridGoods_CT_FLG_BALANCE: TcxGridDBBandedColumn;
    cxGridGoods_DT_FLG_BALANCE: TcxGridDBBandedColumn;
    cxGridGoods_CT_CREATED_DATE: TcxGridDBBandedColumn;
    cxGridGoods_FLG_CLOSED: TcxGridDBBandedColumn;
    cxGridDocs_CREATED_DATE: TcxGridDBColumn;
    cxGridGoods_NR_ACT_PRIMIRE: TcxGridDBBandedColumn;
    cxGridGoods_NR_ACT_ZACEOT: TcxGridDBBandedColumn;
    cxGridPopupMenuGoods: TcxGridPopupMenu;
    dxBarPopupMenuGoods: TdxBarPopupMenu;
    bbGoodsCreateZaceotVBalansPoGarantii: TdxBarButton;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    dxBarButton1: TdxBarButton;
    cxGridGoods_DT_CREATED_DATE: TcxGridDBBandedColumn;
    cxGridGoodsTableColumn1: TcxGridDBBandedColumn;
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridGoods_CT_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbTargetGoodsClick(Sender: TObject);
    procedure bbNoClosedGoodsClick(Sender: TObject);
    procedure bbGoodsCreateZaceotVBalansPoGarantiiClick(Sender: TObject);
    procedure cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteGoods;
    procedure DoCloseDocument;
    function CloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function OpenDocumentDB(const DocID: integer): Boolean;
    procedure ShowTargetGoodsDialog(const CustomerID: integer; const CustomerTitle: string);
    procedure CreateGoodsDocZBPG;
    function DoCreateGoodsDocZBPG_DB(const DT, DocID32, DocID52, CustomerID, GoodsID, CurrencyID: integer; const CurrencyRate, Suma: Double; const GoodsIDENT: string): Boolean;
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
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

{$R *.dfm}

uses
  SWNSecurity, SWNSecurityFlags, frm52ZamenaTovaraDocDialog, SWNConst, SWNUtils,
  SWNDBErrors, DataModuleAdditions, frm52ZamenaTovaraEditorDialog,
  frm52TargetGoodsDialog, frmServiceRequestWarrantyCreateZBPGDocDialog,
  SWNDBEvents, SWNValueStorageUnit;

{ Tframe52ZamenaTovara }

procedure Tframe52ZamenaTovara.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe52ZamenaTovara.bbGoodsCreateZaceotVBalansPoGarantiiClick(Sender: TObject);
begin
  CreateGoodsDocZBPG;
end;

procedure Tframe52ZamenaTovara.bbGoodsDeleteClick(Sender: TObject);
begin
  DeleteGoods;
end;

procedure Tframe52ZamenaTovara.bbGoodsEditClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe52ZamenaTovara.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe52ZamenaTovara.bbNoClosedGoodsClick(Sender: TObject);
begin
  ShowTargetGoodsDialog(-1, '');
end;

procedure Tframe52ZamenaTovara.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe52ZamenaTovara.bbTargetGoodsClick(Sender: TObject);
begin
  ShowTargetGoodsDialog(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString);
end;

function Tframe52ZamenaTovara.CloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ZM(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    try
      Query.Transaction.StartTransaction;
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

procedure Tframe52ZamenaTovara.CreateGoodsDocZBPG;
var
  Dialog: TfrmServiceRequestWarrantyCreateZBPGDocDlg;
begin
  // verificam
  if IBCQueryGoods.FieldByName('NR_ACT_PRIMIRE').IsNull or (Trim(IBCQueryGoods.FieldByName('NR_ACT_PRIMIRE').AsString) = '') or IBCQueryGoods.FieldByName('NR_ACT_ZACEOT').IsNull or (Trim(IBCQueryGoods.FieldByName('NR_ACT_ZACEOT').AsString) = '') then
  begin
    ShowErrorDialog('Зачет в баланс по гарантии', 'Для выбранного товара не указанны:'#13#10'1. Номер акта или инцидента приема товара'#13#10'или'#13#10'2. Номер акта или инцидента зачета в баланс');
    Exit;
  end;

  Dialog := TfrmServiceRequestWarrantyCreateZBPGDocDlg.Create(Self);
  try

    Dialog.GoodsID := IBCQueryGoods.FieldByName('DT_GOODSID').AsInteger;
    Dialog.GoodsSerialType := IBCQueryGoods.FieldByName('DT_GOODS_SERIAL_TYPE').AsInteger;
    Dialog.GoodsIDENT := IBCQueryGoods.FieldByName('DT_IDENT').AsString;

    if Dialog.ShowModal = mrOk then
    begin
      if DoCreateGoodsDocZBPG_DB(Dialog.FirmaID, Dialog.CustomerDocID, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, Dialog.CustomerID, IBCQueryGoods.FieldByName('DT_GOODSID').AsInteger, Dialog.CurrencyID, Dialog.CurrencyRate, Dialog.Suma, IBCQueryGoods.FieldByName('DT_IDENT').AsString) then
        ShowInfoDialog('Зачет в баланс по гарантии', 'Документ создан!');
    end;
  finally
    Dialog.Free;
  end;
end;

procedure Tframe52ZamenaTovara.CreateNewRecord;
var
  Dialog: Tfrm52ZamenaTovaraDocDlg;
begin
  Dialog := Tfrm52ZamenaTovaraDocDlg.Create(Self);
  try
    Dialog.CreateNewDocument := True;
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

procedure Tframe52ZamenaTovara.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGrid_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGrid_FLG_ACNT.index] = 1 then
          ACanvas.Font.Color := $008B8BC5
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

procedure Tframe52ZamenaTovara.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe52ZamenaTovara.cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocs_CREATED_DATE.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_CREATED_DATE.index]);
end;

procedure Tframe52ZamenaTovara.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if (AViewInfo.GridView.DataController.RecordCount > 0) and (AViewInfo.GridRecord.Values[cxGridGoods_FLG_CLOSED.index] = 1) then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];

  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe52ZamenaTovara.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, TcxGridDBTableView(cxGridGoodsTable), Key, Shift);
end;

procedure Tframe52ZamenaTovara.cxGridGoods_CT_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridGoods_CT_DATE.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridGoods_CT_DATE.index]);
end;

procedure Tframe52ZamenaTovara.cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGrid_DATA.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGrid_DATA.index]);
end;

procedure Tframe52ZamenaTovara.DeleteGoods;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, Format('Удалить %s?', [IBCQueryGoods.FieldByName('DT_GOODS_TITLE').AsString])) = mrYes then
  begin
    IBCQueryGoods.UpdateTransaction.StartTransaction;
    try
      IBCQueryGoods.Delete;
      IBCQueryGoods.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryGoods.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe52ZamenaTovara.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Удалить запись номер %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
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

procedure Tframe52ZamenaTovara.DoCloseDocument;
begin
  if ShowAskDialog('Закрытие документа', 'Вы хотите закрыть документ?') = mrYes then
  begin
    if CloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe52ZamenaTovara.DoCreateGoodsDocZBPG_DB(const DT, DocID32, DocID52, CustomerID, GoodsID, CurrencyID: integer; const CurrencyRate, Suma: Double; const GoodsIDENT: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_52_CREATE_ZBPG(:DT, :DOCID52,:DOCID32,:CUSTOMER_ID,:GOODSID,:CURRENCYID,:RATE,:SUMA)';
    Query.ParamByName('DT').AsInteger := DT;
    Query.ParamByName('DOCID52').AsInteger := DocID52;
    Query.ParamByName('DOCID32').AsInteger := DocID32;
    Query.ParamByName('CUSTOMER_ID').AsInteger := CustomerID;
    Query.ParamByName('GOODSID').AsInteger := GoodsID;
    Query.ParamByName('CURRENCYID').AsInteger := CurrencyID;
    Query.ParamByName('RATE').AsFloat := CurrencyRate;
    Query.ParamByName('SUMA').AsFloat := Suma;
    Query.Transaction.StartTransaction;
    try
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

procedure Tframe52ZamenaTovara.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  fCloseDoc, fOpenDoc, fTargetGoods: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := True; // New document + Security
  fDocEdit := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fTargetGoods := False;

  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;
    // Edit document
    fDocDelete := fSECURITY_CanEdit and not FLG_CLOSED; // Delete document
    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
    fTargetGoods := True;
  end;
  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);
  // popup
  bbCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;
  bbTargetGoods.Enabled := fTargetGoods;

  GoodsSelectionChanged;
end;

procedure Tframe52ZamenaTovara.DoFrameHide;
begin
  // inchidem datele interne
  IBCQueryGoods.Close;
  // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

  // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridDocsTable.OnFocusedRecordChanged := nil;
  cxGridGoodsTable.OnFocusedRecordChanged := nil;

  // 2. De deconectat sursele de date de la griduri
  cxGridDocsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe52ZamenaTovara.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  // 1. Legam grid-urile de datasource-sele
  cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

  // 2. Selection handlers
  cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
  cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;

  // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
  // deschidem datele interne
  IBCQueryGoods.Active := True;

  // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe52ZamenaTovara.DoOpenDocument;
begin
  if ShowAskDialog('Открыть документ', 'Вы хотите открыть документ?') = mrYes then
  begin
    if OpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe52ZamenaTovara.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  dmDB.ExecuteQuery('execute procedure sp_SetReadyFlag52(:ROWID', [IBCQueryGoods.FieldByName('ROWID').AsInteger]);
end;

function Tframe52ZamenaTovara.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridDocsTable.Site.Focused then
  begin
    // context from Docs
    if cxGrid_CT_NAME.Focused then
    begin
      // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end;
  end
end;

function Tframe52ZamenaTovara.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe52ZamenaTovara.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe52ZamenaTovara.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe52ZamenaTovara.GoodsSelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
  FLG_CLOSED, goodsFLG_CLOSED, fGoodsCreateZBPG: Boolean;
begin
  fNew := False;
  fEdit := False;
  fDelete := False;
  fGoodsCreateZBPG := False;

  if (cxGridDocsTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fNew := not FLG_CLOSED and fSECURITY_CanEdit;

    if (cxGridGoodsTable.DataController.RecNo > 0) then
    begin
      goodsFLG_CLOSED := IBCQueryGoods.FieldByName('FLG_CLOSED').AsInteger = 1;

      fEdit := not FLG_CLOSED or fSECURITY_CanView;
      fDelete := not FLG_CLOSED;

      fGoodsCreateZBPG := goodsFLG_CLOSED;
    end;
  end;

  bbGoodsNew.Enabled := fNew;
  bbGoodsEdit.Enabled := fEdit;
  bbGoodsDelete.Enabled := fDelete;
  bbGoodsCreateZaceotVBalansPoGarantii.Enabled := fGoodsCreateZBPG;
end;

function Tframe52ZamenaTovara.InitFrameID: integer;
begin
  // СЕРВИС. Замена товара у поставщика
  Result := 52;
end;

procedure Tframe52ZamenaTovara.ModifyRecord;
var
  Dialog: Tfrm52ZamenaTovaraDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  Dialog := Tfrm52ZamenaTovaraDocDlg.Create(Self);
  try
    Dialog.readonly := readonly;
    Dialog.CreateNewDocument := False;
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

function Tframe52ZamenaTovara.OpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ZM(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    try
      Query.Transaction.StartTransaction;
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

procedure Tframe52ZamenaTovara.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridDocsTable);
    ReadGridColumnsSettings(cxGridGoodsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe52ZamenaTovara.RefreshData;
begin
  inherited;
  IBCQueryGoods.Refresh;
end;

procedure Tframe52ZamenaTovara.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridDocsTable);
    SaveGridColumnsSettings(cxGridGoodsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe52ZamenaTovara.SetupDefaultFocus;
begin
  // grid
  cxGridDocs.SetFocus;
  // columns
  cxGrid_DT_NAME.Focused := True;
  cxGridGoods_DT_GOODS_TITLE.Focused := True;
end;

procedure Tframe52ZamenaTovara.SetupSecurityItems;
begin
  // Замена товара в гарантии
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Создать) or SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Изменить) or SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Удалить) or SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Закрыть) and not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗТВГ_Открыть) and not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ПВСВ_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;

  if pmDocs.ItemLinks.VisibleItemCount = 0 then
    cxGridPopupMenuDocs.PopupMenus.Clear;

  if not fSECURITY_CanEdit then
    bbGoodsNew.Visible := ivNever;
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    bbGoodsNew.Visible := ivNever;
  if not fSECURITY_CanEdit then
    bbGoodsDelete.Visible := ivNever;

  if not fSECURITY_CanEdit and fSECURITY_CanView then
    bbGoodsEdit.Caption := 'Смотреть';

  if dxBarManager1Bar1.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManager1Bar1.Visible := False;
    dxBarDockControl1.Visible := False;
  end;
end;

procedure Tframe52ZamenaTovara.ShowAddGoodsDialog;
var
  Dialog: Tfrm52ZamenaTovaraEditorDlg;
begin
  Dialog := Tfrm52ZamenaTovaraEditorDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
  try
    Dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Dialog.DT_DEP := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
    Dialog.DocData := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    Dialog.DocCurrencyID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
    Dialog.DocFlgACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    Dialog.CreateNewRecord := True;
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

procedure Tframe52ZamenaTovara.ShowModifyGoodsDialog;
var
  Dialog: Tfrm52ZamenaTovaraEditorDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := True;

  Dialog := Tfrm52ZamenaTovaraEditorDlg.Create(Self, IBCQueryGoods, IBCDataSourceGoods);
  try
    Dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Dialog.DT_DEP := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
    Dialog.DocData := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    Dialog.DocCurrencyID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
    Dialog.DocFlgACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    Dialog.CreateNewRecord := False;
    Dialog.readonly := readonly;
    if Dialog.ShowModal = mrOk then
    begin
      dmDB.ExecuteQuery('execute procedure SP_SETREADYFLAG52(:ROWID)', [IBCQueryGoods.FieldByName('ROWID').AsInteger]);
      IBCQueryGoods.Refresh;
    end;
  finally
    Dialog.Free;
  end;
end;

procedure Tframe52ZamenaTovara.ShowTargetGoodsDialog(const CustomerID: integer; const CustomerTitle: string);
var
  Dialog: Tfrm52TargetGoodsDlg;
begin
  Dialog := Tfrm52TargetGoodsDlg.Create(Self);
  try
    Dialog.CustomerID := CustomerID;
    Dialog.CustomerName := CustomerTitle;
    Dialog.ShowModal;
  finally
    Dialog.Free;
  end;
end;

procedure Tframe52ZamenaTovara.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe52ZamenaTovara.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


unit frame31ServiceRequestsUnit;
{
  СЕРВИС. Заявки на ремонт
  DocTypeID = 124
  Frame Index = 31
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB,
  cxDBData, dxBar, ExtCtrls,
  cxSplitter, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid,
  cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxLabel, cxCurrencyEdit, cxCalc,
  cxImageComboBox, dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe31ServiceRequests = class(TSWNBaseFrame)
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocsTableDocID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocsTableWarehouse: TcxGridDBColumn;
    cxGridTable_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_VAT: TcxGridDBColumn;
    cxGridDocs_RATE: TcxGridDBColumn;
    cxGridDocsTableParentDocID: TcxGridDBColumn;
    cxGridDocsTableFlgACNT: TcxGridDBColumn;
    cxGridDocsTableCreatedBy: TcxGridDBColumn;
    cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsModify: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    dxBarPopupMenuDoc: TdxBarPopupMenu;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_Price: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_WARRANTY: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    bbGoodsSerials: TdxBarButton;
    cxGridPopupMenuDoc: TcxGridPopupMenu;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridDocs_RateUSD: TcxGridDBColumn;
    cxGridGoods_PRICE: TcxGridDBColumn;
    cxGridDocs_DT: TcxGridDBColumn;
    cxGridDocs_CT: TcxGridDBColumn;
    bbChangeRepairType: TdxBarButton;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridPopupMenuGOODS: TcxGridPopupMenu;
    dxBarPopupMenuGOODS: TdxBarPopupMenu;
    bbGoodsInfoCard: TdxBarButton;
    bbGoodsPrice: TdxBarButton;
    bbGoodsForeignCode: TdxBarButton;
    dxBarButton1: TdxBarButton;
    procedure dxBarPopupMenuDocPopup(Sender: TObject);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsModifyClick(Sender: TObject);
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbGoodsSerialsClick(Sender: TObject);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbChangeRepairTypeClick(Sender: TObject);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsInfoCardClick(Sender: TObject);
    procedure bbGoodsPriceClick(Sender: TObject);
    procedure bbGoodsForeignCodeClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteGoodsDialog;
    procedure ShowGoodsSerialsDialog(const readonly: Boolean = False);
    procedure ShowGoodsPartNumbersDialog(const readonly: Boolean = False);
    function DoCloseDocument(const DocID: integer): Boolean;
    function DoOpenDocument(const DocID: integer): Boolean;
    function DoChangeServiceType(const DocID: Integer): Boolean;
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
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure ListOfIncidents;
  end;

implementation

uses
  DataModuleDB, IBC, frmServiceRequestDocDialog,
  frmSelectGoodsToAddDialog, SWNUtils, SWNConst, SWNTypes,
  frmSerialNumbersDialog, SWNDBErrors, SWNSecurity, frmSelectPartNumbersDialog,
  SWNSecurityFlags, SWNValueStorageUnit, SWNCommonDialogs,
  frmListofIncidentDialog;

{$R *.dfm}

{ Tframe31ServiceRequests }

procedure Tframe31ServiceRequests.bbCloseDocClick(Sender: TObject);
begin
  if ShowAskDialog('Закрыть документ', 'Вы хотите закрыть документ и создать инциденты для всех товаров?') = mrYes then
  begin
    if DoCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe31ServiceRequests.bbGoodsDeleteClick(Sender: TObject);
begin
  ShowDeleteGoodsDialog;
end;

procedure Tframe31ServiceRequests.bbGoodsForeignCodeClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe31ServiceRequests.bbGoodsInfoCardClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe31ServiceRequests.bbGoodsModifyClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe31ServiceRequests.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe31ServiceRequests.bbGoodsPriceClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString);
end;

procedure Tframe31ServiceRequests.bbGoodsSerialsClick(Sender: TObject);
var
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
  begin
    ShowGoodsSerialsDialog(FLG_CLOSED);
  end
  else if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
  begin
    ShowGoodsPartNumbersDialog(FLG_CLOSED);
  end;
end;

procedure Tframe31ServiceRequests.bbOpenDocClick(Sender: TObject);
begin
  if DoOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe31ServiceRequests.CreateNewRecord;
var
  dialog: TfrmServiceRequestDocDlg;
begin
  dialog := TfrmServiceRequestDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
    GoodsSelectionChanged;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and (fSECURITY_CanEdit or fSECURITY_CanView) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe31ServiceRequests.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;

    // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe31ServiceRequests.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocs_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_DATA.Index]);
end;

procedure Tframe31ServiceRequests.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe31ServiceRequests.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbGoodsModify.Enabled then
  begin
    bbGoodsModifyClick(bbGoodsModify);
    AHandled := True;
  end;
end;

procedure Tframe31ServiceRequests.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe31ServiceRequests.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe31ServiceRequests.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Вы хотите удалить заявку на ремонт №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + '?') = mrYes then
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

function Tframe31ServiceRequests.DoChangeServiceType(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'update tdb_docs set doctypeid=125 where docid=:docid';
    ;
    Query.ParamByName('docID').AsInteger := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
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

function Tframe31ServiceRequests.DoCloseDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ZR(:docID)';
    Query.ParamByName('docID').AsInteger := DocID;

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

procedure Tframe31ServiceRequests.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := True;     // New document + Security
  fDocEdit := False;
  fDocDelete := False;
  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := True;   // Edit + Security
    fDocDelete := not FLG_CLOSED; // Delete
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  WhenDocumentPopupMenuOpen;
  GoodsSelectionChanged;
end;

procedure Tframe31ServiceRequests.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridGoodsTable.OnFocusedRecordChanged := nil;
  cxGridDocsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridGoodsTable.DataController.DataSource := nil;
  cxGridDocsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe31ServiceRequests.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridGoodsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
  cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocumentSelectionChanged;
end;

function Tframe31ServiceRequests.DoOpenDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  if ShowAskDialog('Открыть документ', 'Вы хотите открыть документ?') <> mrYes then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ZR(:docID)';
    Query.ParamByName('docID').AsInteger := DocID;

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

procedure Tframe31ServiceRequests.bbChangeRepairTypeClick(Sender: TObject);
var
  DocID: Integer;
begin
  if ShowAskDialog('Изменение типа ремонта', 'Вы хотите изменить тип ремонта на "Гарантийный Ремонт"?') = mrYes then
  begin
    DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    if DoChangeServiceType(DocID) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      if ShowAskDialog('Изменение типа ремонта', 'Готово!', 'Для перехода на документ в "Заявки на гарантийный ремонт", нажмите "Да".') = mrYes then
        SWNFrameManager.GoToFrame(32, DocID); // 32 = Заявки на гарантийный ремонт
    end;
  end;
end;

procedure Tframe31ServiceRequests.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  ListofIncidents;
end;

procedure Tframe31ServiceRequests.ListOfIncidents;
var
  dialog: TfrmDialogListOfIncidents;
begin
  dialog := TfrmDialogListOfIncidents.Create(self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    dialog.ShowModal;
  finally
    dialog.Free
  end;

end;

procedure Tframe31ServiceRequests.dxBarPopupMenuDocPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe31ServiceRequests.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridGoodsTable.Site.Focused then
  begin
          // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridDocsTable.Site.Focused then
  begin
              // context from Docs
    if cxGridTable_CT_NAME.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridDocs_DATA.Focused then
    begin
                       // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end;
  end
end;

function Tframe31ServiceRequests.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe31ServiceRequests.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe31ServiceRequests.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD, fbtCLONE];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe31ServiceRequests.GoodsSelectionChanged;
var
  fNew, fEdit, fDelete, fSerials, FLG_CLOSED, fGoodsSelected: Boolean;
begin
  fNew := False;
  fEdit := False;
  fDelete := False;
  fSerials := False;
  fGoodsSelected := False;

  if (cxGridDocsTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fNew := not FLG_CLOSED; // Новый товар + Security
    if (cxGridGoodsTable.DataController.RecNo > 0) then
    begin
      fEdit := not FLG_CLOSED;   // Изменить + Security
      fDelete := not FLG_CLOSED; // Удалить + Security
               // Серийные, Партий номера + Security
      fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);

      fGoodsSelected := True;
    end;
  end;
     // goods
  bbGoodsNew.Enabled := fNew;
  bbGoodsModify.Enabled := fEdit;
  bbGoodsDelete.Enabled := fDelete;
  bbGoodsSerials.Enabled := fSerials;
  bbGoodsInfoCard.Enabled := fGoodsSelected;
  bbGoodsPrice.Enabled := fGoodsSelected;
  bbGoodsForeignCode.Enabled := fGoodsSelected;
end;

function Tframe31ServiceRequests.InitFrameID: integer;
begin
  Result := 31; // СЕРВИС - Заявки на ремонт
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe31ServiceRequests.ModifyRecord;
var
  dialog: TfrmServiceRequestDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmServiceRequestDocDlg.Create(Self);
  try
    dialog.readonly := readonly;
    dialog.CreateNewDocument := False;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
      GoodsSelectionChanged;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', cxSplitter.MinSize);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridDocsTable);
    ReadGridColumnsSettings(cxGridGoodsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe31ServiceRequests.SaveFrameStates;
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

procedure Tframe31ServiceRequests.SetupDefaultFocus;
begin
     // focused grid
  cxGridDocs.SetFocus;
     // set focused column
  cxGridTable_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe31ServiceRequests.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ЗНР_Заменить_на_Гарантийный_Ремонт) then
    bbChangeRepairType.Visible := ivNever;

     // Карточка товара
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsInfoCard.Visible := ivNever;
     // Изменить цены товара
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or SWNSecurityManager.IsPartialAccessMode then
    bbGoodsPrice.Visible := ivNever;
     // Соответствие товара в других фирмах
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
    bbGoodsForeignCode.Visible := ivNever;

  if (dxBarPopupMenuDoc.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuDoc.PopupMenus.Clear;
  if (dxBarPopupMenuGOODS.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuGOODS.PopupMenus.Clear;
end;

procedure Tframe31ServiceRequests.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
        //dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
    dialog.GoodsTypeFilter := [gtfService];

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.ShowDeleteGoodsDialog;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Удалить товар для ремонта "' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '"?') = mrYes then
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

procedure Tframe31ServiceRequests.ShowGoodsPartNumbersDialog(const readonly: Boolean);
var
  dialog: TfrmSelectPartsDlg;
begin
  dialog := TfrmSelectPartsDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.DocsDataSet := dmDB.IBCQueryDocs;
    dialog.readonly := readonly;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.FullRefresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.ShowGoodsSerialsDialog(const readonly: Boolean = False);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := readonly;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryJurnal.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
        //dialog.AllowedActions:=dialog.AllowedActions-[acChangeACNT,acChangePrice,acChangeActive,acChangeEU,acChangeEUK,acChangeWarranty];
    dialog.GoodsTypeFilter := [gtfService];

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe31ServiceRequests.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe31ServiceRequests.WhenDocumentPopupMenuOpen;
var
  FLG_CLOSED, fOpen, fClose, fChangeRepairType: Boolean;
begin
  fOpen := False;
  fClose := False;
  fChangeRepairType := False;
  if (cxGridDocsTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fClose := not FLG_CLOSED;
    fOpen := FLG_CLOSED and SWNSecurityManager.LoggedUser.IsInAdminGroup;
    fChangeRepairType := not FLG_CLOSED;
  end;
     // popup
  bbCloseDoc.Enabled := fClose;
  bbOpenDoc.Enabled := fOpen;
  bbChangeRepairType.Enabled := fChangeRepairType;
end;

procedure Tframe31ServiceRequests.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.

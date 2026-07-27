unit frame35ServiceReturnToClientUnit;
{
  СЕРВИС. Возврат товара клиенту
  DocTypeID = 128
  Frame Index = 35
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics,
  Data.DB, cxDBData,
  dxBar,
  cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls, cxSplitter,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  cxImageComboBox, dxBarBuiltInMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe35ServiceReturnToClient = class(TSWNBaseFrame)
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocsTableDocID: TcxGridDBColumn;
    cxGridDocsTableData: TcxGridDBColumn;
    cxGridDocsTableWarehouse: TcxGridDBColumn;
    cxGridNPNCol_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_VAT: TcxGridDBColumn;
    cxGridDocs_RATE: TcxGridDBColumn;
    cxGridDocsTableParentDocID: TcxGridDBColumn;
    cxGridDocs_FLG_ACNT: TcxGridDBColumn;
    cxGridDocs_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
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
    dxBarManager: TdxBarManager;
    cxGridDocs_RATEUSD: TcxGridDBColumn;
    cxGridDocs_DT: TcxGridDBColumn;
    cxGridDocs_CT: TcxGridDBColumn;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    bbSerials: TdxBarButton;
    bbActionVSF: TdxBarButton;
    cxGridDocs_CREATED_DATE: TcxGridDBColumn;
    bbTTN: TdxBarButton;
    bbComments: TdxBarButton;
    cxGridDBCol_IMG: TcxGridDBColumn;
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarPopupMenuDocsPopup(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure bbSerialsClick(Sender: TObject);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbActionVSFClick(Sender: TObject);
    procedure bbTTNClick(Sender: TObject);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCommentsClick(Sender: TObject);
    procedure cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure ShowAddGoodsDialog;
    procedure ShowAddGoodsDialog2;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteGoodsDialog;
    procedure ShowGoodsSerialsDialog(const readonly: Boolean = False);
    procedure ShowGoodsPartNumbersDialog(const readonly: Boolean = False);
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
    function CreateScetFactura(const DocID: integer): Boolean;
    procedure ShowCreateTTN;
    function DoCreateTTN(const DocID: Integer): Boolean;
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
    function GetPhoneNumber: string; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  IBC, DataModuleDB, SWNConst,
  SWNUtils, SWNDBErrors, SWNTypes, frmServiceReturnToCustomerDocDialog,
  frmSelectPartNumbersDialog, frmSelectSNDialog, frmSelectGoodsToAddDialog,
  SWNSecurity, SWNSecurityFlags, frmServiceReturnToCustomerGoodsDialog,
  SWNValueStorageUnit, frmSelectPhoneNumberUnit;

{$R *.dfm}

{ Tframe35ServiceReturnToClient }

procedure Tframe35ServiceReturnToClient.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe35ServiceReturnToClient.bbCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe35ServiceReturnToClient.bbGoodsDeleteClick(Sender: TObject);
begin
  ShowDeleteGoodsDialog;
end;

procedure Tframe35ServiceReturnToClient.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddGoodsDialog2;
end;

procedure Tframe35ServiceReturnToClient.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe35ServiceReturnToClient.bbSerialsClick(Sender: TObject);
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

procedure Tframe35ServiceReturnToClient.bbTTNClick(Sender: TObject);
begin
  ShowCreateTTN;
end;

procedure Tframe35ServiceReturnToClient.CreateNewRecord;
var
  dialog: TfrmServiceReturnToCustomerDocDlg;
begin
  dialog := TfrmServiceReturnToCustomerDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

function Tframe35ServiceReturnToClient.CreateScetFactura(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe35ServiceReturnToClient.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0 then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe35ServiceReturnToClient.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.Index] = 1 then
  begin
    ACanvas.Font.Color := clGrayText;
    ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe35ServiceReturnToClient.cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocsTableData.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsTableData.Index]);
end;

procedure Tframe35ServiceReturnToClient.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe35ServiceReturnToClient.cxGridDocs_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocs_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_CREATED_DATE.Index]);
end;

procedure Tframe35ServiceReturnToClient.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe35ServiceReturnToClient.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe35ServiceReturnToClient.DeleteRecord;
begin
  if ShowAskDialog('Удаление записи', 'Вы хотите удалить возврат от поставщика №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + '?') = mrYes then
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

procedure Tframe35ServiceReturnToClient.DoCloseDocument;
begin
  if ShowAskDialog('Закрыть документ', 'Вы хотите закрыть документ?') = mrYes then
  begin
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.FullRefresh;
    end;
  end;
end;

function Tframe35ServiceReturnToClient.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_VTK(:docID)';
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

function Tframe35ServiceReturnToClient.DoCreateTTN(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_TTN_INVOICE(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
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

procedure Tframe35ServiceReturnToClient.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDocClose, fDocOpen, fScetFact, fTTN: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := True;     // New document + Security
  fDocEdit := False;
  fDocDelete := False;
  fDocClose := False;
  fDocOpen := False;
  fScetFact := False;
  fTTN := False;

  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := not FLG_CLOSED;   // Edit + Security
    fDocDelete := not FLG_CLOSED; // Delete + Security
    fDocClose := not FLG_CLOSED;
    fDocOpen := FLG_CLOSED;

    fScetFact := True;
    fTTN := True;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // POPUP
  bbCloseDoc.Enabled := fDocClose;
  bbOpenDoc.Enabled := fDocOpen;
  bbActionVSF.Enabled := fScetFact;
  bbTTN.Enabled := fTTN;

  GoodsSelectionChanged;
end;

procedure Tframe35ServiceReturnToClient.DoFrameHide;
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

procedure Tframe35ServiceReturnToClient.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridDocsTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridGoodsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridGoodsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
  cxGridDocsTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe35ServiceReturnToClient.DoOpenDocument;
begin
  if ShowAskDialog('Открыть документ', 'Вы хотите открыть документ?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.RefreshRecord;  // dmdb.FullRefresh;
    end;
  end;
end;

function Tframe35ServiceReturnToClient.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_VTK(:docID)';
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

procedure Tframe35ServiceReturnToClient.bbActionVSFClick(Sender: TObject);
begin
     // Выписать "Счет фактуру"
  if ShowAskDialog('Выписать "Счет фактуру"', 'Вы хотите выписать "Счет фактуру"?') = mrYes then
  begin
    if CreateScetFactura(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ShowInfoDialog('Счет фактуру', 'Готово.');
  end;
end;

procedure Tframe35ServiceReturnToClient.dxBarPopupMenuDocsPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe35ServiceReturnToClient.GetCurrentSearchContext: TSearchContextValue;
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
    if cxGridNPNCol_CT_NAME.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridDocsTableData.Focused then
    begin
                       // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe35ServiceReturnToClient.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe35ServiceReturnToClient.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe35ServiceReturnToClient.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtADD, fbtMODIFY, fbtDELETE];
end;

function Tframe35ServiceReturnToClient.GetPhoneNumber: string;
 begin
   inherited;
   Result := '';
   frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
   try
     frmSelectPhoneNumber.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
     if frmSelectPhoneNumber.ShowModal=mrOK then
     begin
         Result := frmSelectPhoneNumber.SelectedPhoneNumber;
     end;
   finally
     frmSelectPhoneNumber.Free;
   end;
 end;

procedure Tframe35ServiceReturnToClient.GoodsSelectionChanged;
var
  fNew, fDelete, FLG_CLOSED: Boolean;
  fSerials: Boolean;
begin
  fNew := False;
  fDelete := False;
  fSerials := False;

  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fNew := not FLG_CLOSED;  // Новый товар + Security
    if cxGridGoodsTable.DataController.RecNo > 0 then
    begin
      fDelete := not FLG_CLOSED;  // Удалить + Security
               // Серийные, Партий номера + Security
      fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
    end;
  end;

  bbGoodsNew.Enabled := fNew;
  bbGoodsDelete.Enabled := fDelete;
  bbSerials.Enabled := fSerials;
end;

function Tframe35ServiceReturnToClient.InitFrameID: integer;
begin
  Result := 35; // СЕРВИС - Возврат товара клиенту
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe35ServiceReturnToClient.ModifyRecord;
var
  dialog: TfrmServiceReturnToCustomerDocDlg;
begin
  dialog := TfrmServiceReturnToCustomerDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.ReadFrameStates;
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

procedure Tframe35ServiceReturnToClient.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.ShowAddGoodsDialog2;
var
  dialog: TfrmServiceReturnToCustomerGoodsDlg;
begin
  dialog := TfrmServiceReturnToCustomerGoodsDlg.Create(Self);
  try
    dialog.DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger;
    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.ShowCreateTTN;
begin
  if ShowAskDialog('Товаро-транспортная накладная', Format('Вы хотите выписать "Товаро-транспортную накладную" на'#13#10'"%s"?', [dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString])) = mrYes then
  begin
    if DoCreateTTN(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      ShowInfoDialog('Товаро-транспортная накладная', 'Готово!');
  end;
end;

procedure Tframe35ServiceReturnToClient.ShowDeleteGoodsDialog;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Удалить товар "' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '"?') = mrYes then
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

procedure Tframe35ServiceReturnToClient.ShowGoodsPartNumbersDialog(const readonly: Boolean);
var
  dialog: TfrmSelectPartsDlg;
begin
  dialog := TfrmSelectPartsDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.DocsDataSet := dmDB.IBCQueryDocs;
    dialog.readonly := readonly;
    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.ShowGoodsSerialsDialog(const readonly: Boolean);
var
  dialog: TfrmSelectSNDlg;
begin
  dialog := TfrmSelectSNDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := readonly;
    dialog.DocsDataSet := dmDB.IBCQueryDocs;

    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe35ServiceReturnToClient.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe35ServiceReturnToClient.WhenDocumentPopupMenuOpen;
begin
end;

procedure Tframe35ServiceReturnToClient.SaveFrameStates;
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

procedure Tframe35ServiceReturnToClient.SetupDefaultFocus;
begin
     // focused grid
  cxGridDocs.SetFocus;
     // set focused column
  cxGridNPNCol_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe35ServiceReturnToClient.SetupSecurityItems;
begin
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ВКТ_ИР_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЕРВИС_ВКТ_ИР_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СФ_ТТН_Создать_документ) then
    bbTTN.Visible := ivNever;

  if dxBarPopupMenuDocs.ItemLinks.VisibleItemCount = 0 then
    cxGridPopupMenuDocs.PopupMenus[0].PopupMenu := nil;
end;

procedure Tframe35ServiceReturnToClient.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


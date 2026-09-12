unit frame34ServiceReturnFromVendorUnit;
{
  SERVICE. Retur de la furnizor
  DocTypeID = 127
  Frame Index = 34
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics,
  Data.DB, cxDBData,
  dxBar, cxGridPopupMenu,
  Vcl.ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, cxImageComboBox,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe34ServiceReturnFromVendor = class(TSWNBaseFrame)
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridDocsTableDocID: TcxGridDBColumn;
    cxGridDocsTableData: TcxGridDBColumn;
    cxGridDocsTableWarehouse: TcxGridDBColumn;
    cxGridNPNCol_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocsTableVAT: TcxGridDBColumn;
    cxGridDocsTableRate: TcxGridDBColumn;
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
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_Price: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_K_UM: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridDBCol_WARRANTY: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    bbSerials: TdxBarButton;
    cxGridDocs_RATEUSD: TcxGridDBColumn;
    cxGridDocs_DT: TcxGridDBColumn;
    cxGridDocs_CT: TcxGridDBColumn;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridDBCol_IMG: TcxGridDBColumn;
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsModifyClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbSerialsClick(Sender: TObject);
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarPopupMenuDocsPopup(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
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
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  IBC, DataModuleDB, frmServiceReturnFromVendorDocDialog,
  SWNUtils, SWNDBErrors, SWNConst, SWNTypes, frmSelectGoodsToAddDialog,
  frmSerialNumbersDialog, frmPartNumbersDialog, SWNValueStorageUnit;

{$R *.dfm}

{ Tframe31ServiceRequests }

procedure Tframe34ServiceReturnFromVendor.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe34ServiceReturnFromVendor.bbGoodsDeleteClick(Sender: TObject);
begin
  ShowDeleteGoodsDialog;
end;

procedure Tframe34ServiceReturnFromVendor.bbGoodsModifyClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe34ServiceReturnFromVendor.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe34ServiceReturnFromVendor.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe34ServiceReturnFromVendor.bbSerialsClick(Sender: TObject);
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

procedure Tframe34ServiceReturnFromVendor.CreateNewRecord;
var
  dialog: TfrmServiceReturnFromVendorDocDlg;
begin
  dialog := TfrmServiceReturnFromVendorDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe34ServiceReturnFromVendor.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0 then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe34ServiceReturnFromVendor.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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

procedure Tframe34ServiceReturnFromVendor.cxGridDocsTableDataGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocsTableData.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocsTableData.Index]);
end;

procedure Tframe34ServiceReturnFromVendor.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe34ServiceReturnFromVendor.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe34ServiceReturnFromVendor.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe34ServiceReturnFromVendor.DeleteRecord;
begin
  if ShowAskDialog('Stergere inregistrare', 'Doriti sa stergeti returul de la furnizor nr.' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString + '?') = mrYes then
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

procedure Tframe34ServiceReturnFromVendor.DoCloseDocument;
begin
  if ShowAskDialog('Inchide documentul', 'Doriti sa inchideti documentul?') = mrYes then
  begin
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.FullRefresh;
    end;
  end;
end;

function Tframe34ServiceReturnFromVendor.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_VTOP(:docID)';
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

procedure Tframe34ServiceReturnFromVendor.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, FLG_CLOSED: Boolean;
begin
  fDocNew := True;     // New document + Security
  fDocEdit := False;
  fDocDelete := False;
  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fDocEdit := not FLG_CLOSED;   // Edit + Security
    fDocDelete := not FLG_CLOSED; // Delete + Security
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  WhenDocumentPopupMenuOpen;
  GoodsSelectionChanged;
end;

procedure Tframe34ServiceReturnFromVendor.DoFrameHide;
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

procedure Tframe34ServiceReturnFromVendor.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

procedure Tframe34ServiceReturnFromVendor.DoOpenDocument;
begin
  if ShowAskDialog('Deschide documentul', 'Doriti sa deschideti documentul?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.FullRefresh;
    end;
  end;
end;

function Tframe34ServiceReturnFromVendor.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_VTOP(:docID)';
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

procedure Tframe34ServiceReturnFromVendor.dxBarPopupMenuDocsPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe34ServiceReturnFromVendor.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridGoodsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridDocsTable.Site.Focused then
  begin
              // context from Docs
    if cxGridNPNCol_CT_NAME.Focused then
    begin
                   // Contraagent
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridDocsTableData.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe34ServiceReturnFromVendor.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe34ServiceReturnFromVendor.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

procedure Tframe34ServiceReturnFromVendor.GoodsSelectionChanged;
var
  fNew, fModify, fDelete, FLG_CLOSED: Boolean;
  fSerials: Boolean;
begin
  fNew := False;
  fModify := False;
  fDelete := False;
  fSerials := False;

  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fNew := not FLG_CLOSED;  // Produs nou + Security
    if cxGridGoodsTable.DataController.RecNo > 0 then
    begin
      fModify := not FLG_CLOSED;  // Modifica + Security
      fDelete := not FLG_CLOSED;  // Sterge + Security
               // Numere seriale, Partizi + Security
      fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
    end;
  end;

  bbGoodsNew.Enabled := fNew;
  bbGoodsModify.Enabled := fModify;
  bbGoodsDelete.Enabled := fDelete;
  bbSerials.Enabled := fSerials;
end;

function Tframe34ServiceReturnFromVendor.InitFrameID: integer;
begin
  Result := 34; // SERVICE - Retur de la furnizor
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe34ServiceReturnFromVendor.ModifyRecord;
var
  dialog: TfrmServiceReturnFromVendorDocDlg;
begin
  dialog := TfrmServiceReturnFromVendorDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    if dialog.ShowModal = mrOk then
    begin
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe34ServiceReturnFromVendor.ReadFrameStates;
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

procedure Tframe34ServiceReturnFromVendor.SaveFrameStates;
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

procedure Tframe34ServiceReturnFromVendor.SetupDefaultFocus;
begin
     // focused grid
  cxGridDocs.SetFocus;
     // set focused column
  cxGridNPNCol_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe34ServiceReturnFromVendor.ShowAddGoodsDialog;
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

procedure Tframe34ServiceReturnFromVendor.ShowDeleteGoodsDialog;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, 'Stergeti marfa "' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '"?') = mrYes then
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

procedure Tframe34ServiceReturnFromVendor.ShowGoodsPartNumbersDialog(const readonly: Boolean);
var
  dialog: TfrmPartNumbersDlg;
begin
  dialog := TfrmPartNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := readonly;
    dialog.NewPartNoTemplate := CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);

    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe34ServiceReturnFromVendor.ShowGoodsSerialsDialog(const readonly: Boolean = False);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := readonly;

    if dialog.ShowModal = mrOk then
      dmDB.FullRefresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe34ServiceReturnFromVendor.ShowModifyGoodsDialog;
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

procedure Tframe34ServiceReturnFromVendor.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe34ServiceReturnFromVendor.WhenDocumentPopupMenuOpen;
var
  fClose, fOpen, FLG_CLOSED: Boolean;
begin
  fClose := False;
  fOpen := False;
  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fClose := not FLG_CLOSED;
    fOpen := FLG_CLOSED;
  end;

  bbCloseDoc.Enabled := fClose;
  bbOpenDoc.Enabled := fOpen;
end;

procedure Tframe34ServiceReturnFromVendor.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


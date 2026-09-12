unit frame26AktSpisaniaUnit;
{
  INVENTARIERE. Act de casare marfa
  DocTypeID = 129
  Frame Index = 26
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, System.UITypes,

  DB, cxDBData,
  dxBar, DBAccess, IBC,
  cxSplitter, cxPC, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  cxGridPopupMenu, cxCalc,
  Vcl.Dialogs, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  cxImageComboBox, dxBarBuiltInMenu, MemDS, cxGridCustomPopupMenu, cxClasses, dxUIAClasses;

type
  Tframe26AktSpisania = class(TSWNBaseFrame)
    cxGridAS: TcxGrid;
    cxGridASTable: TcxGridDBTableView;
    cxGridASLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter1: TcxSplitter;
    cxGridAS_DTDEP_NAME: TcxGridDBColumn;
    cxPageControlGeneral: TcxPageControl;
    tbsGoods: TcxTabSheet;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_COST: TcxGridDBColumn;
    cxGridDBCol_Price: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbActionCloseDoc: TdxBarButton;
    bbGoodsSPNumber: TdxBarButton;
    cxGridAS_FLG_CLOSED: TcxGridDBColumn;
    cxGridAS_DT_NAME: TcxGridDBColumn;
    bbOpenDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cxGridAS_DATA: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComponents_FLG_READY: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    cxtsAttachment: TcxTabSheet;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_IMG: TcxGridDBColumn;
    cxGridFiles_DATA: TcxGridDBColumn;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFiles_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    bbAddFile: TdxBarButton;
    bbDeleteFile: TdxBarButton;
    bbSaveFile: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    IBCDataSourceFiles: TIBCDataSource;
    IBCQueryFiles: TIBCQuery;
    dxBarDockControl2: TdxBarDockControl;
    dxBarSubItem1: TdxBarSubItem;
    bbPrice4: TdxBarButton;
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbGoodsSPNumberClick(Sender: TObject);
    procedure bbActionCloseDocClick(Sender: TObject);
    procedure cxGridASTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridASTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridASTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridAS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbAddFileClick(Sender: TObject);
    procedure bbSaveFileClick(Sender: TObject);
    procedure bbDeleteFileClick(Sender: TObject);
    procedure bbPrice4Click(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: Integer;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure ShowSerialNumbersDialog(const ViewOnly: Boolean);
    procedure ShowPartNumbersDialog(const ViewOnly: Boolean);
    function DoCloseDocDB(const DocID: Integer): Boolean;
    procedure SetupQtyFields;
    procedure ShowCalcProfitabilityByContractDialog(const ContractID: Integer);
    procedure ShowCalcProfitabilityDialog(const DocID: Integer);
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure SetupSecurityItems; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    function CheckIfDocumentisLocked: Boolean;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, SWNTypes, SWNDBErrors,
  frmAktSpisaniaDocDialog, frmSelectGoodsToAddDialog,
  frmSelectSNDialog, frmSelectPartNumbersDialog,
  SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit,
  frmCalcProfitabilityContractDialog, frmCalcProfitabilityDialog,
  frm53RPPFileEditorDialog;

{$R *.dfm}

{ Tframe26AktSpisania }

procedure Tframe26AktSpisania.bbActionCloseDocClick(Sender: TObject);
begin
  if ShowAskDialog('Document de casare', 'Inchide document?') = mrYes then
  begin
    if DoCloseDocDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe26AktSpisania.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe26AktSpisania.bbGoodsDeleteClick(Sender: TObject);
begin
  DeleteSelectedGoods;
end;

procedure Tframe26AktSpisania.bbGoodsEditClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe26AktSpisania.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe26AktSpisania.bbGoodsSPNumberClick(Sender: TObject);
var
  viewOnly: Boolean;
begin
  if fSECURITY_CanEdit then
    viewOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    viewOnly := fSECURITY_CanView;

  if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет then
    ShowSerialNumbersDialog(viewOnly)
  else if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет then
    ShowPartNumbersDialog(viewOnly);
end;

procedure Tframe26AktSpisania.bbOpenDocClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_AKTSPISANIA(:DOCID)';
    Query.ParamByName('DOCID').asInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      dmDB.IBCQueryDocs.RefreshRecord;
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

function Tframe26AktSpisania.CheckIfDocumentisLocked: Boolean;
var
  UserName: string;
begin
  Result := False;
  if (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) then
  begin
    Result := True;
    ShowErrorDialog('Act de casare',
      'Acest document nu poate fi modificat!', '', '');
  end;
end;

procedure Tframe26AktSpisania.bbPrice4Click(Sender: TObject);
var
  PriceColumn: integer;
begin
  if CheckIfDocumentisLocked then
    Exit;

  PriceColumn := 1;
  if dmDB.UpdateJurnalGoodsPricesByColumn(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger, dmDB.IBCQueryDocs.FieldByName
    ('DTDEP').asInteger, dmDB.IBCQueryDocs.FieldByName('CTDEP').asInteger, -1, PriceColumn) then
    RefreshData;
end;

procedure Tframe26AktSpisania.CreateNewRecord;
var
  dialog: TfrmAktSpisaniaDocDlg;
begin
  dialog := TfrmAktSpisaniaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe26AktSpisania.cxGridASTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe26AktSpisania.cxGridASTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridAS_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridAS_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
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

procedure Tframe26AktSpisania.cxGridASTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridASTable, Key, Shift);
end;

procedure Tframe26AktSpisania.cxGridAS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridAS_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridAS_DATA.Index]);
end;

procedure Tframe26AktSpisania.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbGoodsEdit.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe26AktSpisania.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe26AktSpisania.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe26AktSpisania.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe26AktSpisania.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea nr %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe26AktSpisania.DeleteSelectedGoods;
var
  S: string;
begin
  S := #13#10 + Format('[%d] %s?', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  if ShowAskDialog('Document de casare', 'Sterge produs' + S) = mrYes then
  begin
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

function Tframe26AktSpisania.DoCloseDocDB(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_AKTSPISANIA(:DOCID)';
    Query.ParamByName('DOCID').asInteger := DocID;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

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

procedure Tframe26AktSpisania.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fCloseDoc, fOpenDoc, fEditComments: Boolean;
  FLG_CLOSED: Boolean;
  DocChanged: Boolean;
begin
  fDocNew := True;      // New document + Security
  fDocEdit := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fEditComments := False;
  DocChanged := True;

  if cxGridASTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;   // Edit document
    fDocDelete := fSECURITY_CanEdit and not FLG_CLOSED; // Delete document

    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
    fEditComments := fSECURITY_CanEdit;

    DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
  end;

  bbAddFile.Enabled := not FLG_CLOSED and (cxGridASTable.DataController.RecNo > 0);
  bbDeleteFile.Enabled := fDocDelete and (cxGridFilesTable.DataController.RecNo > 0);
  bbSaveFile.Enabled := (cxGridFilesTable.DataController.RecNo > 0);
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);
     // popup
  bbActionCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;
  bbDocComments.Enabled := fEditComments;

  if DocChanged then
  begin
    cxPageControlGeneral.ActivePage := tbsGoods;
    GoodsSelectionChanged;
  end;
end;

procedure Tframe26AktSpisania.DoFrameHide;
begin
     // inchidem datele interne
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  IBCQueryFiles.Close;
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridASTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridComponentsTable.DataController.DataSource := nil;
  cxGridASTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe26AktSpisania.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridASTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridASTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryFiles.Open;
     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe26AktSpisania.dxBarButton1Click(Sender: TObject);
begin
  if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
    ShowCalcProfitabilityByContractDialog(dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger)
  else
    ShowCalcProfitabilityDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe26AktSpisania.bbAddFileClick(Sender: TObject);
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;

end;

procedure Tframe26AktSpisania.bbDeleteFileClick(Sender: TObject);
begin
  if ShowAskDialog('Document de casare', Format('Sterge file scanat "%s"?', [IBCQueryFiles.FieldByName('FILENAME').AsString])) = mrYes then
  begin
    IBCQueryFiles.UpdateTransaction.StartTransaction;
    try
      IBCQueryFiles.Delete;
      IBCQueryFiles.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryFiles.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe26AktSpisania.bbSaveFileClick(Sender: TObject);
var
  Query: TIBCQuery;
begin
  with TSaveDialog.Create(Self) do
  try
    FileName := IBCQueryFiles.FieldByName('FILENAME').AsString;
    Filter := '*.*';
    if Execute then
    begin
      Query := TIBCQuery.Create(Self);
      try
        Query.Connection := dmDB.IBCConnection;
        Query.SQL.Text := 'SELECT FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
        Query.ParamByName('ID').AsInteger := IBCQueryFiles.FieldByName('ATTID').AsInteger;
        Query.ExecSQL;
        if not Query.Eof then
          TBlobField(Query.Fields[0]).SaveToFile(FileName);
      finally
        Query.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure Tframe26AktSpisania.ShowCalcProfitabilityByContractDialog(const ContractID: Integer);
var
  dialog: TfrmCalcProfitabilityContractDlg;
begin
  dialog := TfrmCalcProfitabilityContractDlg.Create(Self);
  try
    dialog.ContractID := ContractID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe26AktSpisania.ShowCalcProfitabilityDialog(const DocID: Integer);
var
  dialog: TfrmCalcProfitabilityDlg;
begin
  dialog := TfrmCalcProfitabilityDlg.Create(Self);
  try
    dialog.DocID := DocID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

function Tframe26AktSpisania.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.CONTEXT := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridASTable.Site.Focused then
  begin
              // context from Docs
    if cxGridAS_DATA.Focused then
    begin
                   // Data
      Result.CONTEXT := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridAS_DTDEP_NAME.Focused then
    begin
                       // Depozit
      Result.CONTEXT := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe26AktSpisania.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe26AktSpisania.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffGoods, ffGoodsFolders, ffAcntGoods, ffStock];
end;

function Tframe26AktSpisania.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe26AktSpisania.InitFrameID: Integer;
begin
  Result := 26; // INVENTARIERE. Act de casare
  SetupQtyFields;
end;

procedure Tframe26AktSpisania.ModifyRecord;
var
  dialog: TfrmAktSpisaniaDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;
  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmAktSpisaniaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe26AktSpisania.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter1.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridASTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe26AktSpisania.RefreshData;
begin
  inherited;
  dmDB.IBCQueryJurnal.Refresh;
end;

procedure Tframe26AktSpisania.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete, fGoodsSPNumber: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;
  fGoodsSPNumber := False;

  if (cxGridASTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fGoodsNew := fSECURITY_CanEdit and not FLG_CLOSED; // New Goods + Security

    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      fGoodsEdit := fSECURITY_CanEdit and not FLG_CLOSED;   // Edit Goods + Security
      fGoodsDelete := fSECURITY_CanEdit and not FLG_CLOSED; // Delete Goods + Security
               // Numere seriale/de partida
      fGoodsSPNumber := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Серийный_учет) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Партийный_учет);
    end;
  end;
     // goods
  bbGoodsNew.Enabled := fGoodsNew;
  bbGoodsEdit.Enabled := fGoodsEdit;
  bbGoodsDelete.Enabled := fGoodsDelete;
  bbGoodsSPNumber.Enabled := fGoodsSPNumber;
end;

procedure Tframe26AktSpisania.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter1.State));
    SaveGridColumnsSettings(cxGridASTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe26AktSpisania.SetupDefaultFocus;
begin
     // grid
  cxGridAS.SetFocus;
     // columns
  cxGridAS_DT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe26AktSpisania.SetupQtyFields;
begin
     // Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

procedure Tframe26AktSpisania.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Закрыть_документ) then
    bbActionCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АСТ_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;
end;

procedure Tframe26AktSpisania.ShowAddNewGoodsDialog;
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

procedure Tframe26AktSpisania.ShowModifyGoodsDialog;
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

procedure Tframe26AktSpisania.ShowPartNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSelectPartsDlg;
begin
  dialog := TfrmSelectPartsDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.DocsDataSet := dmDB.IBCQueryDocs;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe26AktSpisania.ShowSerialNumbersDialog(const ViewOnly: Boolean);
var
  dialogSN: TfrmSelectSNDlg;
begin
  dialogSN := TfrmSelectSNDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialogSN.readonly := ViewOnly;
    dialogSN.DocsDataSet := dmDB.IBCQueryDocs;
    dialogSN.ShowModal;
  finally
    dialogSN.Free;
  end;
end;

procedure Tframe26AktSpisania.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe26AktSpisania.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


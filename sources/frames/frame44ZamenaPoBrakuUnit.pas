unit frame44ZamenaPoBrakuUnit;
{
  SERVICE - Inlocuire pe defect
  DocTypeID = 1487
  Frame Index = 44
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxCurrencyEdit, cxLabel, cxCheckBox, dxBar, cxClasses, ExtCtrls, cxSplitter, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, cxLookAndFeels, cxLookAndFeelPainters,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxPCdxBarPopupMenu, cxNavigator, DBAccess, IBC, MemDS, cxPC, cxImageComboBox,
  frmPrintEngineWindow, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges,
  dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe44ZamenaPoBraku = class(TSWNBaseFrame)
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsModify: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    bbSerials: TdxBarButton;
    cxGridPopupMenuDocs: TcxGridPopupMenu;
    dxBarPopupMenuDocs: TdxBarPopupMenu;
    bbCloseDocument: TdxBarButton;
    bbOpenDocument: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridGoods: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_Price: TcxGridDBColumn;
    cxGridDBCol_K_UM: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridGoods_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridDBCol_FLG_ACNT: TcxGridDBColumn;
    cxGridDBCol_WARRANTY: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridGoodsLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    cxGridDocs: TcxGrid;
    cxGridDocsTable: TcxGridDBTableView;
    cxGridNPN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDocsTableDocID: TcxGridDBColumn;
    cxGridDocs_DATA: TcxGridDBColumn;
    cxGridDocsTableWarehouse: TcxGridDBColumn;
    cxGridNPNCol_CT_NAME: TcxGridDBColumn;
    cxGridDocs_SUMA: TcxGridDBColumn;
    cxGridDocs_CURRENCY_NAME: TcxGridDBColumn;
    cxGridDocs_VAT: TcxGridDBColumn;
    cxGridDocs_RATE: TcxGridDBColumn;
    cxGridDocs_RATEUSD: TcxGridDBColumn;
    cxGridDocsTableParentDocID: TcxGridDBColumn;
    cxGridDocs_FLG_ACNT: TcxGridDBColumn;
    cxGridDocsTableCreatedBy: TcxGridDBColumn;
    cxGridDocs_DT: TcxGridDBColumn;
    cxGridDocs_CT: TcxGridDBColumn;
    cxGridDocsLevel: TcxGridLevel;
    cxGridDBCol_IMG: TcxGridDBColumn;
    pnBottom: TPanel;
    bbCreateSF: TdxBarButton;
    bbCreateTTN: TdxBarButton;
    cxGridDocsTable_SC2_NAME: TcxGridDBColumn;
    bbPrintWaranty: TdxBarButton;
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsModifyClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbSerialsClick(Sender: TObject);
    procedure cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocumentClick(Sender: TObject);
    procedure bbOpenDocumentClick(Sender: TObject);
    procedure cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure bbCreateSFClick(Sender: TObject);
    procedure bbCreateTTNClick(Sender: TObject);
    procedure bbPrintWarantyClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure ShowDeleteGoodsDialog;
    procedure ShowGoodsSerialsDialog(const readonly: Boolean = False);
    procedure ShowGoodsPartNumbersDialog(const readonly: Boolean = False);
    function DoCloseDocument(const DocID: integer): Boolean;
    function DoOpenDocument(const DocID: integer): Boolean;
    function DoCreateSFDB(const DocID: Integer): Boolean;
    function DoCreateTTNDB(const DocID: Integer): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure SaveFrameStates; override;
    procedure ReadFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNDBErrors, frmSelectGoodsToAddDialog, SWNConst, SWNTypes,
  frmSelectSNDialog, frmSelectPartNumbersDialog, SWNSecurity, SWNSecurityFlags, frmServiceZamenaPoBrakuDocDialog,
  frm53RPPFileEditorDialog, Vcl.FileCtrl, SWNValueStorageUnit, ReportFunctions;

{$R *.dfm}

{ Tframe31ServiceRequests }

procedure Tframe44ZamenaPoBraku.bbCloseDocumentClick(Sender: TObject);
begin
  if DoCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe44ZamenaPoBraku.bbCreateSFClick(Sender: TObject);
begin
     // Creare "Facturi fiscale"
  if ShowAskDialog('Inlocuirea produsului', 'Creati document "FACTURA FISCALA" ?') <> mrYes then
    Exit;

  if DoCreateSFDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
  begin
    ShowInfoDialog('SWN', 'Finisat!');
    RefreshData;
  end;
end;

procedure Tframe44ZamenaPoBraku.bbCreateTTNClick(Sender: TObject);
begin
     // Creare "Nakladnaia marfa-transport"
  if ShowAskDialog('Inlocuirea produsului', 'Creati document "Factura de expeditie"?')
    <> mrYes then
    Exit;

  if DoCreateTTNDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
  begin
    RefreshData;
    ShowInfoDialog('SWN', 'Finisat!');
  end;
end;

procedure Tframe44ZamenaPoBraku.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe44ZamenaPoBraku.bbGoodsDeleteClick(Sender: TObject);
begin
  ShowDeleteGoodsDialog;
end;

procedure Tframe44ZamenaPoBraku.bbGoodsModifyClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe44ZamenaPoBraku.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe44ZamenaPoBraku.bbOpenDocumentClick(Sender: TObject);
begin
  if DoOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe44ZamenaPoBraku.bbPrintWarantyClick(Sender: TObject);
var
  printEngine: TfrmPrintEngine;
  tmpParams: TReportParamsList;
  reportID: integer;
begin
     // luam codul raportului din grupa "Talon de garantie" pentru firma curenta
//  reportID := dmDB.GetDefaultReportForReportGroup('WARRANTY');
//
//  if (reportID = -1) then
//  begin
//    ShowErrorDialog('Eroare', 'Raportul nu a fost gasit!');
//    Exit;
//  end;

  reportID := 85; // Certificat de garantie
  tmpParams := TReportParamsList.Create;
  printEngine := TfrmPrintEngine.Create(Self);
  try
        // prepare params
    tmpParams.SetParamValue('DOCID', dmDB.IBCQueryDocs.FieldByName('DOCID').Value);
    tmpParams.SetParamValue('USERID', dmDB.CurrentUserID);
    tmpParams.SetParamValue('USER_NAME', dmDB.CurrentUserFullName);
    printEngine.ReportParams := tmpParams;
    printEngine.AddReport(reportID);
    printEngine.ShowModal;
  finally
    printEngine.Free;
    tmpParams.Free;
  end;
end;

procedure Tframe44ZamenaPoBraku.bbSerialsClick(Sender: TObject);
var
  readonly, FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  readonly := not fSECURITY_CanEdit or FLG_CLOSED;

  if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Ñåðèéíûé_ó÷åò then
  begin
    ShowGoodsSerialsDialog(readonly);
  end
  else if dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger = cSYSS_GOODS_SERIAL_TYPE_Ïàðòèéíûé_ó÷åò then
  begin
    ShowGoodsPartNumbersDialog(readonly);
  end;
end;

procedure Tframe44ZamenaPoBraku.CreateNewRecord;
var
  dialog: TfrmServiceZamenaPoBrakuDocDlg;
begin
  dialog := TfrmServiceZamenaPoBrakuDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe44ZamenaPoBraku.cxGridDocsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0 then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe44ZamenaPoBraku.cxGridDocsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridNPN_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridDocs_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridDocs_FLG_ACNT.Index] = 1 then
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

procedure Tframe44ZamenaPoBraku.cxGridDocs_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridDocs_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridDocs_DATA.Index]);
end;

procedure Tframe44ZamenaPoBraku.cxGridDocsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridDocsTable, Key, Shift);
end;

procedure Tframe44ZamenaPoBraku.cxGridGoodsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe44ZamenaPoBraku.cxGridGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridGoodsTable, Key, Shift);
end;

procedure Tframe44ZamenaPoBraku.DeleteRecord;
begin
  if ShowAskDialog('SWN', 'Stergeti returul catre furnizor ¹' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString
    + '?') = mrYes then
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

function Tframe44ZamenaPoBraku.DoCloseDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  if ShowAskDialog('SWN', 'Inchideti document?') <> mrYes then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ZPB(:docID)';
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

function Tframe44ZamenaPoBraku.DoCreateSFDB(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_FISCAL_INVOICE(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
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

function Tframe44ZamenaPoBraku.DoCreateTTNDB(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CREATE_TTN_INVOICE(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
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

procedure Tframe44ZamenaPoBraku.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, FLG_CLOSED, FLG_ACNT, fClose, fOpen, fDocComments: Boolean;
  fCreateSF, fCreateTTN: Boolean;
begin
  fDocNew := fSECURITY_CanNew;     // New document
  fDocEdit := False;
  fDocDelete := False;
  fClose := False;
  fOpen := False;
  fDocComments := False;
  fCreateSF := False;
  fCreateTTN := False;

  if cxGridDocsTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    FLG_ACNT := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;

    fDocEdit := (fSECURITY_CanEdit and not FLG_CLOSED) or fSECURITY_CanView;   // Edit
    fDocDelete := fSECURITY_CanEdit and not FLG_CLOSED; // Delete
    fClose := not FLG_CLOSED;
    fOpen := FLG_CLOSED;

    fDocComments := fSECURITY_CanEdit;

    fCreateSF := FLG_ACNT;
    fCreateTTN := FLG_ACNT;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  bbCloseDocument.Enabled := fClose;
  bbOpenDocument.Enabled := fOpen;
  bbDocComments.Enabled := fDocComments;

  bbCreateSF.Enabled := fCreateSF;
  bbCreateTTN.Enabled := fCreateTTN;

  GoodsSelectionChanged;
end;

procedure Tframe44ZamenaPoBraku.DoFrameHide;
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

procedure Tframe44ZamenaPoBraku.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

function Tframe44ZamenaPoBraku.DoOpenDocument(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  if ShowAskDialog('SWN', 'Deschideti document?') <> mrYes then
    Exit;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ZPB(:docID)';
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

function Tframe44ZamenaPoBraku.GetCurrentSearchContext: TSearchContextValue;
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
    else if cxGridDocs_DATA.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridDocsTableWarehouse.Focused then
    begin
                           // Depozit
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe44ZamenaPoBraku.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe44ZamenaPoBraku.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffStock];
end;

function Tframe44ZamenaPoBraku.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe44ZamenaPoBraku.GoodsSelectionChanged;
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

    fNew := fSECURITY_CanEdit and not FLG_CLOSED;  // Produs nou + Security
    if cxGridGoodsTable.DataController.RecNo > 0 then
    begin
      fModify := fSECURITY_CanEdit and not FLG_CLOSED;  // Modifica + Security
      fDelete := fSECURITY_CanEdit and not FLG_CLOSED;  // Sterge + Security

               // Numere seriale, Partizi + Security
      fSerials := (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
        cSYSS_GOODS_SERIAL_TYPE_Ñåðèéíûé_ó÷åò) or (dmDB.IBCQueryJurnal.FieldByName('GOODS_SERIAL_TYPE_ID').AsInteger =
        cSYSS_GOODS_SERIAL_TYPE_Ïàðòèéíûé_ó÷åò);
    end;
  end;

  bbGoodsNew.Enabled := fNew;
  bbGoodsModify.Enabled := fModify;
  bbGoodsDelete.Enabled := fDelete;
  bbSerials.Enabled := fSerials;
end;

function Tframe44ZamenaPoBraku.InitFrameID: integer;
begin
  Result := 44; // SERVICE - Inlocuire pe rebut
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe44ZamenaPoBraku.ModifyRecord;
var
  dialog: TfrmServiceZamenaPoBrakuDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmServiceZamenaPoBrakuDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe44ZamenaPoBraku.ReadFrameStates;
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

procedure Tframe44ZamenaPoBraku.SaveFrameStates;
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

procedure Tframe44ZamenaPoBraku.SetupDefaultFocus;
begin
     // grid
  cxGridDocs.SetFocus;
     // columns
  cxGridNPNCol_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe44ZamenaPoBraku.SetupSecurityItems;
begin
     // Inlocuire produs in garantie
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Ïðîñìîòð);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Ñîçäàòü);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Èçìåíèòü);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Óäàëèòü);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Çàêðûòü) then
    bbCloseDocument.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÅÐÂÈÑ_ÇÒÂÃ_Îòêðûòü) then
    bbOpenDocument.Visible := ivNever;
     // Creare "Facturi fiscale"
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÔ_ÑÔ_Ñîçäàòü) then
    bbCreateSF.Visible := ivNever;
     // Creare "Nakladnaia marfa-transport"
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÑÔ_ÒÒÍ_Ñîçäàòü_äîêóìåíò) then
    bbCreateTTN.Visible := ivNever;
end;

procedure Tframe44ZamenaPoBraku.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
        //dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice];
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe44ZamenaPoBraku.ShowDeleteGoodsDialog;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteGoods, 'Sterge produsul "' + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString
    + '"?') = mrYes then
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

procedure Tframe44ZamenaPoBraku.ShowGoodsPartNumbersDialog(const readonly: Boolean = False);
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

procedure Tframe44ZamenaPoBraku.ShowGoodsSerialsDialog(const readonly: Boolean = False);
var
  dialog: TfrmSelectSNDlg;
begin
  dialog := TfrmSelectSNDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
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

procedure Tframe44ZamenaPoBraku.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
        //dialog.AllowedActions:=dialog.AllowedActions+[acChangePrice];
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe44ZamenaPoBraku.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe44ZamenaPoBraku.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


unit frame73DSEUnit;

// DSE Documente de stricata evidenta
// DocTypeID = 3135
// Frame Index = 73

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, dxBar,
  cxClasses, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, IBC, cxLookAndFeels,
  cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, MemDS, DBAccess,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  DAScript, IBCScript, dxUIAClasses;

type
  Tframe73DSE = class(TSWNBaseFrame)
    cxGridPTN: TcxGrid;
    cxGridPTNTable: TcxGridDBTableView;
    cxGridPTN_DOCID: TcxGridDBColumn;
    cxGridPTN_DATA: TcxGridDBColumn;
    cxGridPTN_CT_NAME: TcxGridDBColumn;
    cxGridPTN_SUMA: TcxGridDBColumn;
    cxGridPTN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridPTN_VAT: TcxGridDBColumn;
    cxGridPTN_FLG_ACNT: TcxGridDBColumn;
    cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    dxBarPopupMenuDOCS: TdxBarPopupMenu;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    cxGridPopupMenuCOMPONENTS: TcxGridPopupMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    cxSplitter1: TcxSplitter;
    cxGridDSE: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarManagerBar1: TdxBar;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbNewDSE: TdxBarButton;
    bbDeleteDSE: TdxBarButton;
    bbManagerSerials: TdxBarButton;
    IBCDS_DSE: TIBCDataSource;
    IBCQ_DSE: TIBCQuery;
    cxGrid2: TcxGrid;
    cxGridDSEDetail: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDSEUID: TcxGridDBColumn;
    cxGridDSEQTY: TcxGridDBColumn;
    cxGridDSEAMOUNT: TcxGridDBColumn;
    cxGridDSEDSE_TYPENAME: TcxGridDBColumn;
    IBCQ_DSE_Detail: TIBCQuery;
    IBCDS_DSE_Detail: TIBCDataSource;
    cxGridDSEDetailDSE_NO: TcxGridDBColumn;
    cxGridDSEDetailSTATUS: TcxGridDBColumn;
    cxGridDSEDetailINVOICE_DOCID: TcxGridDBColumn;
    bbModify: TdxBarButton;
    cxGridDSECNT: TcxGridDBColumn;
    IBCScript1: TIBCScript;
    dxBarButton1: TdxBarButton;
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
      TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbNewDSEClick(Sender: TObject);
    procedure bbDeleteDSEClick(Sender: TObject);
    procedure bbManagerSerialsClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridDSEFocusedRecordChanged(Sender: TcxCustomGridTableView;
        APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
        ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridDSESelectionChanged(Sender: TcxCustomGridTableView);
    procedure dxBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fDSEQuantity: integer;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure SetupQtyFields;
    function AddNewRecord(const SerialNumber: String; var ErrorStr: String): Boolean;
    procedure WhenBeginToAddSerials(Sender: TObject);
    procedure WhenEndToAddSerials(Sender: TObject);
    procedure WhenAddSerialFromScanner(const SerialNumber: String; var Added: Boolean);
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
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    procedure GenerateDSENumbers;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, frmВходныеСчетаDocDialog, SWNUtils, SWNDBErrors,
  frmSelectGoodsToAddDialog, SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit,
  frmImportGoodsPricesDialog, frmVhodnieScetaGoodsAnalyzeDialog, SWNCommonDialogs, frm73DocDialog, AddDSEUnit, uDSENumberGenerator,
  System.Diagnostics;

{$R *.dfm}

{ Tframe73DSE }

procedure Tframe73DSE.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe73DSE.bbDeleteDSEClick(Sender: TObject);
begin
  inherited;
  if ShowAskDialog('Documente de stricta evidenta', 'Sterge documentul?')=mrYes then
     IBCQ_DSE.Delete;
end;

procedure Tframe73DSE.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe73DSE.bbManagerSerialsClick(Sender: TObject);
begin
  GenerateDSENumbers;
end;

procedure Tframe73DSE.bbModifyClick(Sender: TObject);
var dialog:TfrmDSE;
begin
     dialog:=TfrmDSE.Create(Self,IBCQ_DSE,IBCDS_DSE);
     try
        dialog.AddDSE := False;
        if dialog.ShowModal=mrOk then
        begin
             IBCQ_DSE.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

function Tframe73DSE.AddNewRecord(const SerialNumber: String; var ErrorStr: String): Boolean;
begin
  Result := False;
  IBCQ_DSE_Detail.DisableControls;
//  IBCQ_DSE_Detail.Append;
  try
//    IBCQ_DSE_Detail.FieldByName('DSE_NO').AsString := SerialNumber;
//    IBCQ_DSE_Detail.FieldByName('STATUS').AsInteger := 0;
//    IBCQ_DSE_Detail.Post;

    IBCScript1.SQL.Add('INSERT INTO TDB_DSE_DETAIL');
    IBCScript1.SQL.Add('(UID, DSE_NO, STATUS)');
    IBCScript1.SQL.Add('VALUES');
    IBCScript1.SQL.Add('('+IBCQ_DSE.FieldByName('UID').AsString+', '+QuotedStr(SerialNumber)+', 0);');
    Result := True;
  except
    on E: Exception do
    begin
      IBCQ_DSE_Detail.Cancel;
      ErrorStr := E.Message;
    end;
  end;
  IBCQ_DSE_Detail.EnableControls;
end;

procedure Tframe73DSE.WhenAddSerialFromScanner(const SerialNumber: String; var Added: Boolean);
var
  ErrorStr: String;
begin
  Added := AddNewRecord(SerialNumber, ErrorStr);
end;

procedure TFrame73DSE.WhenBeginToAddSerials(Sender: TObject);
begin
  cxGridDSEDetail.DataController.BeginFullUpdate;
end;

procedure TFrame73DSE.WhenEndToAddSerials(Sender: TObject);
begin
  var stopwatch := TStopWatch.StartNew;
  try
    if not IBCScript1.Transaction.Active then
      IBCScript1.Transaction.StartTransaction;

    IBCScript1.ExecuteScript;
    IBCScript1.Transaction.Commit;

    Stopwatch.Stop;
    ShowMessage('Elapsed time: '+stopwatch.ElapsedMilliseconds.ToString + ' milliseconds');
  except
     raise;
  end;

  IBCQ_DSE_Detail.Refresh;
  cxGridDSEDetail.DataController.EndFullUpdate;
end;

procedure TFrame73DSE.GenerateDSENumbers;
var
  dialog: TfrmDSENumberGenerator;
  N: integer;
begin
  IBCScript1.SQL.Clear;
  N := 0;
  if VarIsNumeric(cxGridDSEDetail.DataController.Summary.FooterSummaryValues[0]) then
    N := cxGridDSEDetail.DataController.Summary.FooterSummaryValues[0];
  N := fDSEQuantity - N;
  if N < 0 then
    N := 0;

  dialog := TfrmDSENumberGenerator.Create(Self);
  try
    dialog.RequiredCount := N;
    dialog.OnBeginToAddSearials := WhenBeginToAddSerials;
    dialog.OnAddSerialNumber := WhenAddSerialFromScanner;
    dialog.OnEndToAddSearials := WhenEndToAddSerials;

    if dialog.ShowModal = mrOk then
    begin
//      ShowInfoForUser;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe73DSE.bbNewDSEClick(Sender: TObject);
var dialog:TfrmDSE;
begin
     dialog:=TfrmDSE.Create(Self,IBCQ_DSE,IBCDS_DSE);
     try
        dialog.AddDSE:=True;
        if dialog.ShowModal=mrOk then
        begin
             IBCQ_DSE.Refresh;
        end;
     finally
        dialog.Free;
     end;

end;

procedure Tframe73DSE.CreateNewRecord;
var
  dialog: Tfrm73DocDlg;
begin
  dialog := Tfrm73DocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe73DSE.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea №%d?', [dmDB.IBCQueryDocs.FieldByName
    ('DOCID').asInteger])) = mrYes then
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

procedure Tframe73DSE.DocSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDebts, fImportGoods: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := false;
  fDebts := False;
  fImportGoods := False;

  if cxGridDSE.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;

    bbDeleteDSE.Enabled := True;
    bbManagerSerials.Enabled := True;

  end
  else
  begin
    bbDeleteDSE.Enabled := False;
    bbManagerSerials.Enabled := False;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

end;

procedure Tframe73DSE.DoFrameHide;
begin
     // Inchidem sursele din frame cu scan
  IBCQ_DSE_Detail.Close;
  IBCQ_DSE.Close;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridPTNTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridPTNTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe73DSE.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridPTNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridPTNTable.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocSelectionChanged;

     // 5. Open custom Dataset
  IBCQ_DSE.Open;
  IBCQ_DSE_detail.Open;
end;

procedure Tframe73DSE.dxBarButton1Click(Sender: TObject);
begin
  dmdb.ExecuteQuery('execute procedure sp_close73(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
  dmdb.IBCQueryDocs.Refresh;
end;

procedure Tframe73DSE.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe73DSE.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe73DSE.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe73DSE.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe73DSE.InitFrameID: integer;
begin
     // Documentatia de proiect
  Result := 73;
  SetupQtyFields;
end;

procedure Tframe73DSE.ModifyRecord;
var
  dialog: Tfrm73DocDlg;
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if fSECURITY_CanEdit and not FLG_CLOSED then
  begin
    dialog := Tfrm73DocDlg.Create(Self);
    try
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tframe73DSE.SetupDefaultFocus;
begin
     // grid
  cxGridPTN.SetFocus;
     // columns
  cxGridPTN_CT_NAME.Focused := True;
end;

procedure Tframe73DSE.SetupQtyFields;
begin
     // Cantitate
end;

procedure Tframe73DSE.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_DSE_DDSE_Vizionare);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_DSE_DDSE_Creare);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_DSE_DDSE_Modificare);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_DSE_DDSE_Stergere);
end;

procedure Tframe73DSE.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe73DSE.WhenDocumentPopupMenuOpen;
var
  fCreatePrihodRashod: Boolean;
  FLG_CLOSED: Boolean;
begin
  fCreatePrihodRashod := False;

  if (cxGridPTNTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger
    = 1) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fCreatePrihodRashod := (not FLG_CLOSED);     // Creare Nakladnaia de intrare
  end;
     // popup menu
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

procedure Tframe73DSE.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe73DSE.cxGridDSEFocusedRecordChanged(Sender:
    TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
    TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
   DocSelectionChanged
end;

procedure Tframe73DSE.cxGridDSESelectionChanged(Sender: TcxCustomGridTableView);
var
  fDocDelete: Boolean;
  fDocEdit: Boolean;
  FLG_CLOSED: Boolean;
begin
  if cxGridDSE.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;

    bbDeleteDSE.Enabled := True;
    bbManagerSerials.Enabled := True;

  end
  else
  begin
    bbDeleteDSE.Enabled := False;
    bbManagerSerials.Enabled := False;
  end;
end;

procedure Tframe73DSE.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe73DSE.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]) then
    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index] = 1 then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];

  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe73DSE.cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridPTN_DATA.Index]);
end;

end.


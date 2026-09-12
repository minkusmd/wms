unit frame27AktOprihodovaniaUnit;
{
  INVENTARIERE. Act de intrare
  DocTypeID = 130
  Frame Index = 27
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit,
  cxGraphics, DB,
  cxDBData, dxBar, DBAccess, IBC,
  cxSplitter, cxPC, ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  cxGridPopupMenu,
  cxCalc, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel, cxImageComboBox,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, MemDS, cxClasses, dxUIAClasses;

type
  Tframe27AktOprihodovania = class(TSWNBaseFrame)
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
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    tbsExpenses: TcxTabSheet;
    cxGridExpenses: TcxGrid;
    cxGridExpensesTable: TcxGridDBTableView;
    cxGridExpenses_NAME: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_ID: TcxGridDBColumn;
    cxGridExpenses_EXPENSE_DOC_DOCTYPE_TITLE: TcxGridDBColumn;
    cxGridExpenses_SUMA: TcxGridDBColumn;
    cxGridExpenses_CURRENCY: TcxGridDBColumn;
    cxGridExpenses_RATE: TcxGridDBColumn;
    cxGridExpensesLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    bbExpenseNew: TdxBarButton;
    bbExpenseEdit: TdxBarButton;
    bbExpenseDelete: TdxBarButton;
    IBCQueryExpenses: TIBCQuery;
    IBCDataSourceExpenses: TIBCDataSource;
    dxBarPopupMenuAS: TdxBarPopupMenu;
    bbActionCloseDoc: TdxBarButton;
    bbGoodsSPNumber: TdxBarButton;
    cxGridAS_FLG_CLOSED: TcxGridDBColumn;
    cxGridPopupMenuAS: TcxGridPopupMenu;
    cxGridAS_FLG_ACNT: TcxGridDBColumn;
    bbActionOpenDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridAS_DATA: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbExpenseNewClick(Sender: TObject);
    procedure bbExpenseEditClick(Sender: TObject);
    procedure bbExpenseDeleteClick(Sender: TObject);
    procedure bbGoodsSPNumberClick(Sender: TObject);
    procedure bbActionCloseDocClick(Sender: TObject);
    procedure cxGridASTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridASTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridASTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridAS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridExpensesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbActionOpenDocClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    fLastDocID: integer;
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure ExpenseSelectionChanged;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure ShowAddExpenseDialog;
    procedure ShowModifyExpenseDialog;
    procedure DeleteSelectedExpense;
    procedure ShowSerialNumbersDialog(const ViewOnly: Boolean);
    procedure ShowPartNumbersDialog(const ViewOnly: Boolean);
    function DoAction_SetupDocFLG_CLOSE(const DocID, FLG_CLOSE: integer): Boolean;
    function WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
    procedure DoOpenDocument;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
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
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst,
  frmSelectGoodsToAddDialog, frmNakladnaiaPNExpenseDialog, SWNTypes,
  frmSerialNumbersDialog, frmPartNumbersDialog, frmAktOprihodovaniaDocDialog,
  SWNDBErrors, SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit;

{$R *.dfm}

{ Tframe27AktOprihodovaniaUnit }

procedure Tframe27AktOprihodovania.bbActionCloseDocClick(Sender: TObject);
begin
  if ShowAskDialog('Act de primire', 'Inchide documentul ?') = mrYes then
  begin
    if DoAction_SetupDocFLG_CLOSE(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 1) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe27AktOprihodovania.bbActionOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe27AktOprihodovania.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe27AktOprihodovania.bbExpenseDeleteClick(Sender: TObject);
begin
  DeleteSelectedExpense;
end;

procedure Tframe27AktOprihodovania.bbExpenseEditClick(Sender: TObject);
begin
  ShowModifyExpenseDialog;
end;

procedure Tframe27AktOprihodovania.bbExpenseNewClick(Sender: TObject);
begin
  ShowAddExpenseDialog;
end;

procedure Tframe27AktOprihodovania.bbGoodsDeleteClick(Sender: TObject);
begin
  DeleteSelectedGoods;
end;

procedure Tframe27AktOprihodovania.bbGoodsEditClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe27AktOprihodovania.bbGoodsNewClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe27AktOprihodovania.bbGoodsSPNumberClick(Sender: TObject);
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

procedure Tframe27AktOprihodovania.CreateNewRecord;
var
  dialog: TfrmAktOprihodovaniaDocDlg;
begin
  dialog := TfrmAktOprihodovaniaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridASTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridASTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridAS_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridAS_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridAS_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridAS_FLG_ACNT.Index] = 1 then
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

procedure Tframe27AktOprihodovania.cxGridASTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridASTable, Key, Shift);
end;

procedure Tframe27AktOprihodovania.cxGridAS_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridAS_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridAS_DATA.Index]);
end;

procedure Tframe27AktOprihodovania.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbGoodsEdit.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe27AktOprihodovania.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe27AktOprihodovania.cxGridExpensesTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbExpenseEdit.Enabled then
  begin
    ShowModifyExpenseDialog;
    AHandled := True;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridExpensesTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe27AktOprihodovania.cxGridExpensesTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridExpensesTable, Key, Shift);
end;

procedure Tframe27AktOprihodovania.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea nr. %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe27AktOprihodovania.DeleteSelectedExpense;
var
  S: string;
begin
  S := #13#10 + IBCQueryExpenses.FieldByName('EXPENSE_TITLE').AsString + #13#10 + Format('in suma %f %s ?', [IBCQueryExpenses.FieldByName('EXPENSE_DOC_SUMA').AsCurrency, IBCQueryExpenses.FieldByName('EXPENSE_DOC_CURRENCY_NAME').AsString]);
  if ShowAskDialog('Act de primire', 'Sterge articolul de chelcuieri' + S) = mrYes then
  begin
    IBCQueryExpenses.UpdateTransaction.StartTransaction;
    try
      IBCQueryExpenses.Delete;
      IBCQueryExpenses.UpdateTransaction.Commit;
    except
      IBCQueryExpenses.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure Tframe27AktOprihodovania.DeleteSelectedGoods;
var
  S: string;
begin
  S := #13#10 + Format('[%d] %s?', [dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString]);
  if ShowAskDialog('Act de primire', 'Sterge produsul' + S) = mrYes then
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

function Tframe27AktOprihodovania.DoAction_SetupDocFLG_CLOSE(const DocID, FLG_CLOSE: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_CLOSE_AKT_OPRIHOD(:DOCID, :FLG_CLOSE)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('FLG_CLOSE').AsInteger := FLG_CLOSE;

    Query.Transaction.StartTransaction;
    try
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

procedure Tframe27AktOprihodovania.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED, DocChanged: Boolean;
  fCloseDoc, fOpenDoc, fDocComments: Boolean;
begin
  fDocNew := fSECURITY_CanNew;      // New document
  fDocEdit := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fDocComments := False;

  DocChanged := True;

  if cxGridASTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;   // Edit document
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED; // Delete document
    DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
    fDocComments := fSECURITY_CanEdit;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbActionCloseDoc.Enabled := fCloseDoc;
  bbActionOpenDoc.Enabled := fOpenDoc;
  bbDocComments.Enabled := fDocComments;

  if DocChanged then
  begin
    cxPageControlGeneral.ActivePage := tbsGoods;
    GoodsSelectionChanged;
    ExpenseSelectionChanged;
  end;
end;

procedure Tframe27AktOprihodovania.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryExpenses.Active := False;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridASTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;
  cxGridExpensesTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridComponentsTable.DataController.DataSource := nil;
  cxGridASTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe27AktOprihodovania.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridASTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridASTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGrid_FocusedRecordChanged;
  cxGridExpensesTable.OnFocusedRecordChanged := WhenExpenseGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryExpenses.Active := True;

     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe27AktOprihodovania.DoOpenDocument;
begin
  if ShowAskDialog('Act de primire', 'Deschide document?') = mrYes then
  begin
    if DoAction_SetupDocFLG_CLOSE(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, 0) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

procedure Tframe27AktOprihodovania.ExpenseSelectionChanged;
var
  fExpenseNew, fExpenseEdit, fExpenseDelete: Boolean;
begin
  fExpenseNew := False;
  fExpenseEdit := False;
  fExpenseDelete := False;

  if fSECURITY_CanEdit and (cxGridASTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 0) then
  begin
    fExpenseNew := True; // New Expenses + Security
    if (cxGridExpensesTable.DataController.RecNo > 0) then
    begin
      fExpenseEdit := True;   // Edit Expense + Security
      fExpenseDelete := True; // Delete Expense + Security
    end;
  end;
     // expenses
  bbExpenseNew.Enabled := fExpenseNew;
  bbExpenseEdit.Enabled := fExpenseEdit;
  bbExpenseDelete.Enabled := fExpenseDelete;
end;

function Tframe27AktOprihodovania.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridASTable.Site.Focused then
  begin
              // context from Docs
    if cxGridAS_DATA.Focused then
    begin
                   // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridAS_DTDEP_NAME.Focused then
    begin
                       // Depozit
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe27AktOprihodovania.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe27AktOprihodovania.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffGoods, ffStock, ffGoodsFolders, ffAcntGoods];
end;

function Tframe27AktOprihodovania.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe27AktOprihodovania.InitFrameID: integer;
begin
     // INVENTARIERE. Act de intrare
  Result := 27;
  SetupQtyFields;
end;

procedure Tframe27AktOprihodovania.ModifyRecord;
var
  dialog: TfrmAktOprihodovaniaDocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmAktOprihodovaniaDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ReadFrameStates;
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

procedure Tframe27AktOprihodovania.RefreshData;
begin
  inherited;
  IBCQueryExpenses.Refresh;
end;

procedure Tframe27AktOprihodovania.GoodsSelectionChanged;
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
    fGoodsNew := fSECURITY_CanEdit and not FLG_CLOSED; // New Goods
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

procedure Tframe27AktOprihodovania.SaveFrameStates;
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

procedure Tframe27AktOprihodovania.SetupDefaultFocus;
begin
     // grid
  cxGridAS.SetFocus;
     // columns
  cxGridAS_DTDEP_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
  cxGridExpenses_NAME.Focused := True;
end;

procedure Tframe27AktOprihodovania.SetupQtyFields;
begin
     // Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

procedure Tframe27AktOprihodovania.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Закрыть_документ) then
    bbActionCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ИНВЕНТАРИЗАЦИЯ_АОТ_Открыть_документ) then
    bbActionOpenDoc.Visible := ivNever;
end;

procedure Tframe27AktOprihodovania.ShowAddExpenseDialog;
var
  dialog: TfrmNakladnaiaPNExpenseDlg;
begin
  dialog := TfrmNakladnaiaPNExpenseDlg.Create(Self, IBCQueryExpenses, IBCDataSourceExpenses);
  try
    dialog.CreateNewExpense := True;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ShowModifyExpenseDialog;
var
  dialog: TfrmNakladnaiaPNExpenseDlg;
begin
  dialog := TfrmNakladnaiaPNExpenseDlg.Create(Self, IBCQueryExpenses, IBCDataSourceExpenses);
  try
    dialog.CreateNewExpense := False;

    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;

    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ShowPartNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmPartNumbersDlg;
begin
  dialog := TfrmPartNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    dialog.NewPartNoTemplate := CreatePartNoTemplate(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryJurnal.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe27AktOprihodovania.ShowSerialNumbersDialog(const ViewOnly: Boolean);
var
  dialog: TfrmSerialNumbersDlg;
begin
  dialog := TfrmSerialNumbersDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.readonly := ViewOnly;
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryJurnal.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe27AktOprihodovania.WhenCheckIfGoodsExists(const GoodsID: integer): Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
  begin
    if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure Tframe27AktOprihodovania.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe27AktOprihodovania.WhenExpenseGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ExpenseSelectionChanged;
end;

procedure Tframe27AktOprihodovania.WhenGoodsGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

end.


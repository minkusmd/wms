unit frame20PrihodTovaraPoNakladnim;
{
  НАКЛАДНЫЕ. Приход Товара По Накладным.
  DocTypeID = 109
  Frame Index = 20
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxStyles,
  cxGraphics, DB,
  cxDBData, cxCurrencyEdit, dxBar,
  cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridPopupMenu,
  cxPC, DBAccess, IBC,
  cxCalc, cxButtonEdit, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxLabel, cxImageComboBox,
  cxCalendar, dxBarBuiltInMenu, MemDS, cxGridCustomPopupMenu, cxClasses, cxGridCustomView, dxUIAClasses;

type
  Tframe20PrihotTovaraPoNakladnim = class(TSWNBaseFrame)
    cxGridPTN: TcxGrid;
    cxGridPTNTable: TcxGridDBTableView;
    cxGridPTN_DOCID: TcxGridDBColumn;
    cxGridPTN_DATA: TcxGridDBColumn;
    cxGridPTN_DTDEP_NAME: TcxGridDBColumn;
    cxGridPTN_CT_NAME: TcxGridDBColumn;
    cxGridPTN_SUMA: TcxGridDBColumn;
    cxGridPTN_CURRENCY_NAME: TcxGridDBColumn;
    cxGridPTN_VAT: TcxGridDBColumn;
    cxGridPTN_FLG_ACNT: TcxGridDBColumn;
    cxGridPTN_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridPTNLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    dxPopupMenuPTN: TdxBarPopupMenu;
    dxBarDockControl1: TdxBarDockControl;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    bbActionPlatejnoePorucenie: TdxBarButton;
    bbActionCloseDoc: TdxBarButton;
    bbActionOpenDoc: TdxBarButton;
    cxGridPTN_FLG_CLOSED: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    bbImportRashod: TdxBarButton;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbDocComments: TdxBarButton;
    cxPageControlDetails: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsInvoice: TcxTabSheet;
    cxGridInvoice: TcxGrid;
    cxGridInvoiceTable: TcxGridDBTableView;
    cxGridInvoiceTable_INVOICEID: TcxGridDBColumn;
    cxGridInvoiceTable_IMG: TcxGridDBColumn;
    cxGridInvoiceTable_FACTURANO: TcxGridDBColumn;
    cxGridInvoiceTable_DATA_ELIBERARII: TcxGridDBColumn;
    cxGridInvoiceLevel: TcxGridLevel;
    dxBarDockControlInvoices: TdxBarDockControl;
    dxBarManagerBarInvoice: TdxBar;
    IBCQueryINVOICES: TIBCQuery;
    IBCDataSourceINVOICES: TIBCDataSource;
    cxGridInvoiceTable_USERID_NAME: TcxGridDBColumn;
    bbInvoiceNew: TdxBarButton;
    bbInvoiceEdit: TdxBarButton;
    bbInvoiceDelete: TdxBarButton;
    dxBarPopupMenuPTNUnselected: TdxBarPopupMenu;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_FLG_EXPORTED: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    tsScans: TcxTabSheet;
    cxGridFiles: TcxGrid;
    cxGridFilesTable: TcxGridDBTableView;
    cxGridFiles_FILENAME: TcxGridDBColumn;
    cxGridFiles_FILESIZE: TcxGridDBColumn;
    cxGridFilesLevel: TcxGridLevel;
    bbAttachFileNew: TdxBarButton;
    bbAttachFileRemove: TdxBarButton;
    bbAttachFileSaveAs: TdxBarButton;
    dxBarManagerBar2: TdxBar;
    dxBarDockControl2: TdxBarDockControl;
    IBCQueryFiles: TIBCQuery;
    IBCDataSourceFiles: TIBCDataSource;
    bbAttachFileModify: TdxBarButton;
    cxGridPTN_HasFilesScanned: TcxGridDBColumn;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComponents_ACNT_PRICE: TcxGridDBColumn;
    cxGridComponents_PRICE_ACNT_LOW_BOUND: TcxGridDBColumn;
    cxGridComponents_PRICE_ACNT_HIGH_BOUND: TcxGridDBColumn;
    dxBarButton5: TdxBarButton;
    cxGridInvoiceTable_REDIRIJARI: TcxGridDBColumn;
    cxGridPTN_CREATED_DATE: TcxGridDBColumn;
    cxGridPTNTable_PARENTDOCID: TcxGridDBColumn;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure bbActionCloseDocClick(Sender: TObject);
    procedure bbActionOpenDocClick(Sender: TObject);
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbActionPlatejnoePorucenieClick(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift:
      TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift:
      TShiftState; var AHandled: Boolean);
    procedure bbImportRashodClick(Sender: TObject);
    procedure cxGridPTNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridInvoiceTableFocusedRecordChanged(Sender:
      TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridInvoiceTableKeyDown(Sender: TObject; var Key: Word; Shift:
      TShiftState);
    procedure bbInvoiceNewClick(Sender: TObject);
    procedure bbInvoiceEditClick(Sender: TObject);
    procedure bbInvoiceDeleteClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridPTNTableColumn1StylesGetContentStyle(Sender:
      TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure dxBarButton4Click(Sender: TObject);
    procedure bbAttachFileNewClick(Sender: TObject);
    procedure bbAttachFileModifyClick(Sender: TObject);
    procedure bbAttachFileRemoveClick(Sender: TObject);
    procedure bbAttachFileSaveAsClick(Sender: TObject);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBCol_PRICEStylesGetContentStyle(Sender:
      TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridFilesTableFocusedRecordChanged(Sender:
      TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure dxBarButton5Click(Sender: TObject);
    procedure cxGridComponents_GOODS_NAMEACNTPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fLastFilePath: string;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure DocSelectionChanged;
    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure InvoiceSelectionChanged;
    procedure AttachFileSelectionChanged;
    procedure ShowAddNewGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    function DoActionCloseDocument(const DocID: integer): Boolean;
    function DoActionOpenDocument(const DocID: integer): Boolean;
    procedure DoActionPlatejnoePorucenie(const DOCID, CurrencyID: integer; const
      Rate: Single; const Suma: Currency);
    procedure DoImportDocFromRashod;
    function DoImportDocFromRashodDB(const DocID: integer): Integer;
    procedure DoImportFromPrihodnayaNakl_InDoc;
    function DoImportFromPrihodnayaNakl_inDoc_db(const Docid: integer): integer;
    procedure DoImport_1506;  //закрытие товара в комисию

    procedure DoImport_1757;  //принятие в баланс с комисии

    procedure ShowCreateNewInvoiceDialog;
    procedure ShowEditInvoiceDialog;
    procedure DeleteInvoice;
    procedure SaveFileFromDB(const AttID: integer; const FilePath: string);
    procedure ShowModifyGoodsAcntDialog;
    procedure SetupQtyFields;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions,
  frmПриходТовараПоНакладнымDocDialog, frmSelectGoodsToAddDialog,
  frmMoneyIncomeDialog, SWNConst, SWNUtils, SWNDBErrors,
  frmDocumentBrowserDialog, SWNSecurity, SWNSecurityFlags, frmPTNInvoiceDialog,
  Vcl.FileCtrl, frm53RPPFileEditorDialog,
  frmПриходТовараПоНакладнымChangeGoodsAcntDialog, SWNCommonDialogs;


{$R *.dfm}

{ Tframe20ПриходТовараПоНакладным }

procedure Tframe20PrihotTovaraPoNakladnim.AttachFileSelectionChanged;
var
  FLG_CLOSED: Boolean;
  fNew, fEdit, fDelete, fSaveAs: Boolean;
begin
  fNew := False;
  fEdit := False;
  fDelete := False;
  fSaveAs := False;

  if fSECURITY_CanEdit and (cxGridPTNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fNew := True;

    if cxGridFilesTable.DataController.RecNo > 0 then
    begin
      fEdit := not FLG_CLOSED;
      fDelete := not FLG_CLOSED;
      fSaveAs := True;
    end;
  end;
  bbAttachFileNew.Enabled := fNew;
  bbAttachFileModify.Enabled := fEdit;
  bbAttachFileRemove.Enabled := fDelete;
  bbAttachFileSaveAs.Enabled := fSaveAs;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbActionCloseDocClick(Sender: TObject);
begin
  if ShowAskDialog('Facturi', 'Doriti sa inchideti acest document?') = mrYes then
  begin
    if DoActionCloseDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbActionOpenDocClick(Sender: TObject);
begin
  if ShowAskDialog('Facturi', 'Doriti sa deschideti acest document?') = mrYes then
  begin
    if DoActionOpenDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbActionPlatejnoePorucenieClick(Sender:
  TObject);
var
  dialog: TfrmMoneyIncomeDlg;
begin
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.AllowChangeCurrency := False;
    dialog.AllowChangeCurrencyRate := False;
    dialog.SetCustomTitle('Dispozitie de plata', 'dispozitie de plata');
    if dialog.ShowModal = mrOk then
    begin
      DoActionPlatejnoePorucenie(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('RATE').AsFloat, dialog.SUMA);
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddNewGoodsDialog;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbDeleteGoodsClick(Sender: TObject);
begin
  DeleteSelectedGoods;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbImportRashodClick(Sender: TObject);
begin
  DoImportDocFromRashod;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbInvoiceDeleteClick(Sender: TObject);
begin
  DeleteInvoice;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbInvoiceEditClick(Sender: TObject);
begin
  ShowEditInvoiceDialog;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbInvoiceNewClick(Sender: TObject);
begin
  ShowCreateNewInvoiceDialog;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe20PrihotTovaraPoNakladnim.CreateNewRecord;
var
  dialog: TfrmPrihodTovaraPoNakladnimDocDlg;
begin
  dialog := TfrmPrihodTovaraPoNakladnimDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridComponentsTableCellDblClick(Sender:
  TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
  TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridComponentsTableCustomDrawCell(Sender:
  TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridComponentsTableKeyDown(Sender:
  TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridComponents_GOODS_NAMEACNTPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  ShowModifyGoodsAcntDialog;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridDBCol_PRICEStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
  TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  n: double;
begin
  if not VarIsNull(ARecord.Values[cxGridComponents_PRICE_ACNT_LOW_BOUND.Index])
    and not VarIsNull(ARecord.Values[cxGridComponents_PRICE_ACNT_HIGH_BOUND.Index])
    and not VarIsNull(ARecord.Values[cxGridDBCol_PRICE.Index]) then
  begin
    n := ARecord.Values[cxGridDBCol_PRICE.Index];
    if (n < ARecord.Values[cxGridComponents_PRICE_ACNT_LOW_BOUND.Index]) or (n >
      ARecord.Values[cxGridComponents_PRICE_ACNT_HIGH_BOUND.Index]) then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridDBCol_QTYGetDisplayText(Sender:
  TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridFilesTableFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  AttachFileSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridInvoiceTableFocusedRecordChanged
  (Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  InvoiceSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridInvoiceTableKeyDown(Sender:
  TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridInvoiceTable, Key, Shift);
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridPTNTableCellDblClick(Sender:
  TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
  TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridPTNTableColumn1StylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
  TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_FLG_EXPORTED.Index]) then
  begin
    if ARecord.Values[cxGridPTN_FLG_EXPORTED.Index] = 1 then
      AStyle := dmAdditions.cxStyle_BackgroundRED;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridPTNTableCustomDrawCell(Sender:
  TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.Index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
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
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.Index] = 1 then
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

procedure Tframe20PrihotTovaraPoNakladnim.cxGridPTNTableKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridPTNTable, Key, Shift);
end;

procedure Tframe20PrihotTovaraPoNakladnim.cxGridPTN_DATAGetDisplayText(Sender:
  TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridPTN_DATA.Index]);
end;

procedure Tframe20PrihotTovaraPoNakladnim.DeleteInvoice;
begin
  if ShowAskDialog('Facturi', Format('Doriti sa stergeti documentul %s?', [IBCQueryINVOICES.FieldByName
    ('FACTURANO').AsString])) = mrYes then
  begin
    IBCQueryINVOICES.UpdateTransaction.StartTransaction;
    try
      IBCQueryINVOICES.Delete;
      IBCQueryINVOICES.UpdateTransaction.Commit;
    except
      on E: Exception do
      begin
        IBCQueryINVOICES.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Doriti sa stergeti inregistrarea %d?',
    [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe20PrihotTovaraPoNakladnim.DeleteSelectedGoods;
var
  S: string;
begin
  S := #13#10 + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + '?';
  if ShowAskDialog('Facturi', 'Doriti sa stergeti produsul' + S) = mrYes then
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

function Tframe20PrihotTovaraPoNakladnim.DoActionCloseDocument(const DocID:
  integer): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_INCOME_INVOICE_ACNT(:DOCID)';
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

function Tframe20PrihotTovaraPoNakladnim.DoActionOpenDocument(const DocID:
  integer): Boolean;
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
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_INCOME_INVOICE(:DOCID)';
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

procedure Tframe20PrihotTovaraPoNakladnim.DoActionPlatejnoePorucenie(const DOCID,
  CurrencyID: integer; const Rate: Single; const Suma: Currency);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
           // Банковское платежное поручение
      Query.SQL.Text :=
        'EXECUTE PROCEDURE SP_CREATE_BANK_TRANSFER(:DOCID,:SUMA,:CurrencyID,:Rate)';
           // params
      Query.ParamByName('DOCID').AsInteger := DOCID;
      Query.ParamByName('SUMA').AsCurrency := Suma;
      Query.ParamByName('CurrencyID').AsInteger := CurrencyID;
      Query.ParamByName('Rate').AsFloat := Rate;
           // exec
      Query.ExecSQL;
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

procedure Tframe20PrihotTovaraPoNakladnim.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryFiles.Active := False;
  IBCQueryINVOICES.Active := False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridPTNTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridPTNTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe20PrihotTovaraPoNakladnim.DoFrameShow(const FrameDataFilterInfo:
  TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridPTNTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridPTNTable.OnFocusedRecordChanged := WhenDocGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryFiles.Active := True;
  IBCQueryINVOICES.Active := True;

     // 4. Selection update
  cxPageControlDetails.ActivePage := tbsGoods;
  DocSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.DoImportDocFromRashod;
var
  dialog: TfrmDocumentBrowserDlg;
  docid: integer;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.FixedDocTypeID := True;
    dialog.DefaultDocTypeID := 106;
    dialog.HasNoChildDocTypeID := 106;

    dialog.DefaultUserID := -1;
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Facturi', Format('Doriti sa importati datele din documentul: № %d?',
        [dialog.DocID])) = mrYes then
      begin
        docid := DoImportDocFromRashodDB(dialog.DocID);
        dmDb.IBCQueryDocs.Refresh;
        dmDb.IBCQueryDocs.Locate('DOCID', docid, []);
        ShowInfoDialog('Facturi', 'Importat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

function Tframe20PrihotTovaraPoNakladnim.DoImportDocFromRashodDB(const DocID:
  integer): Integer;
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
        'SELECT NEW_DOCID FROM SP_CREATE_PRIHOD_TOVARA(:DOCID, 1, :current_docid)';
      Query.Params.ParamByName('DOCID').AsInteger := DocID;
      Query.Params.ParamByName('Current_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName
        ('DOCID').AsInteger;
      Query.ExecSQL;
      if not Query.Eof then
        Result := Query.Fields[0].AsInteger;
      Query.Transaction.Commit;
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

procedure Tframe20PrihotTovaraPoNakladnim.DoImportFromPrihodnayaNakl_InDoc;
var
  dialog: TfrmDocumentBrowserDlg;
  docid: integer;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.FixedDocTypeID := True;
    dialog.DefaultDocTypeID := 106;
    dialog.DefaultUserID := dmDB.CurrentUserID;
    dialog.DefaultCT := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
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

function Tframe20PrihotTovaraPoNakladnim.DoImportFromPrihodnayaNakl_inDoc_db(const
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
        'SELECT NEW_DOCID FROM SP_CREATE_PRIHOD_TOVARA(:DOCID, 0, :current_docid)';
      Query.Params.ParamByName('DOCID').AsInteger := Docid;
      Query.Params.ParamByName('Current_DOCID').AsInteger := dmdb.IBCQueryDocs.FieldByName
        ('DOCID').AsInteger;
      Query.ExecSQL;
      if not Query.Eof then
        Result := Query.Fields[0].AsInteger;
      Query.Transaction.Commit;
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

procedure Tframe20PrihotTovaraPoNakladnim.DoImport_1506;
var
  dialog: TfrmDocumentBrowserDlg;
  docid: integer;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.FixedDocTypeID := True;
    dialog.DefaultDocTypeID := 1506;
    dialog.DefaultUserID := dmDB.CurrentUserID;
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Facturi', Format('Doriti sa importati din documentul: №%d?',
        [dialog.DocID])) = mrYes then
      begin
        docid := DoImportDocFromRashodDB(dialog.DocID);
        dmDb.IBCQueryDocs.Refresh;
        dmDb.IBCQueryDocs.Locate('DOCID', docid, []);
        ShowInfoDialog('Facturi ', 'Document imporat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.DoImport_1757;
var
  dialog: TfrmDocumentBrowserDlg;
  docid: integer;
begin
  dialog := TfrmDocumentBrowserDlg.Create(Self, dmDB.IBCConnection);
  try
    dialog.FixedDocTypeID := True;
    dialog.DefaultDocTypeID := 1757;
    dialog.DefaultUserID := dmDB.CurrentUserID;
    if dialog.ShowModal = mrOk then
    begin
      if ShowAskDialog('Facturi', Format('Doriti sa importati documentul: №%d?',
        [dialog.DocID])) = mrYes then
      begin
        docid := DoImportDocFromRashodDB(dialog.DocID);
        dmDb.IBCQueryDocs.Refresh;
        dmDb.IBCQueryDocs.Locate('DOCID', docid, []);
        ShowInfoDialog('Facturi', 'Document importat!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.dxBarButton1Click(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe20PrihotTovaraPoNakladnim.dxBarButton2Click(Sender: TObject);
begin
  inherited;
  DoImportFromPrihodnayaNakl_inDoc;
end;

procedure Tframe20PrihotTovaraPoNakladnim.dxBarButton3Click(Sender: TObject);
begin
  inherited;
  DoImport_1506;
end;

procedure Tframe20PrihotTovaraPoNakladnim.dxBarButton4Click(Sender: TObject);
begin
  inherited;
  DoImport_1757;
end;

procedure Tframe20PrihotTovaraPoNakladnim.dxBarButton5Click(Sender: TObject);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CANCE_FLG_EXP(:DOCID)';
      Query.ParamByName('DOCID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
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

procedure Tframe20PrihotTovaraPoNakladnim.bbAttachFileNewClick(Sender: TObject);
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

function Tframe20PrihotTovaraPoNakladnim.GetExternalDataSourceTypes:
  TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe20PrihotTovaraPoNakladnim.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe20PrihotTovaraPoNakladnim.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe20PrihotTovaraPoNakladnim.GoodsSelectionChanged;
var
  fGoodsNew, fGoodsEdit, fGoodsDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsNew := False;
  fGoodsEdit := False;
  fGoodsDelete := False;

  if fSECURITY_CanEdit and (cxGridPTNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    if not FLG_CLOSED then
    begin
      fGoodsNew := True; // New Goods + Security
      if (cxGridComponentsTable.DataController.RecNo > 0) then
      begin
        fGoodsEdit := True;   // Edit Goods + Security
        fGoodsDelete := True; // Delete Goods + Security
      end;
    end;
  end;
     // goods
  bbAddGoods.Enabled := fGoodsNew;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbDeleteGoods.Enabled := fGoodsDelete;
end;

function Tframe20PrihotTovaraPoNakladnim.InitFrameID: integer;
begin
  Result := 20; // НАКЛАДНЫЕ. Приход Товара По Накладным
  SetupQtyFields;
end;

procedure Tframe20PrihotTovaraPoNakladnim.InvoiceSelectionChanged;
var
  fNew, fEdit, fDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fNew := False;
  fEdit := False;
  fDelete := False;

  if fSECURITY_CanEdit and (cxGridPTNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if not FLG_CLOSED then
    begin
      fNew := True;
      if cxGridInvoiceTable.DataController.RecNo > 0 then
      begin
        fEdit := True;
        fDelete := True;
      end;
    end;
  end;

  bbInvoiceNew.Enabled := fNew;
  bbInvoiceEdit.Enabled := fEdit;
  bbInvoiceDelete.Enabled := fDelete;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ModifyRecord;
var
  dialog: TfrmPrihodTovaraPoNakladnimDocDlg;
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if (not fSECURITY_CanEdit or FLG_CLOSED) then
    Exit;

  dialog := TfrmPrihodTovaraPoNakladnimDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    if dialog.ShowModal = mrOK then
      dmdb.IBCQueryJurnal.Refresh;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ReadFrameStates;
begin
//  AppUserConfigStorage.OpenSection(Self.Name);
//  try
//    cxPageControlDetails.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight',
//      300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue
//      ('SplitterState'));
//  finally
//    AppUserConfigStorage.CloseSection;
//  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.RefreshData;
begin
  inherited;
  IBCQueryINVOICES.Refresh;
  IBCQueryFiles.Refresh;
end;

procedure Tframe20PrihotTovaraPoNakladnim.SaveFrameStates;
begin
//  AppUserConfigStorage.OpenSection(Self.Name);
//  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', cxPageControlDetails.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
//  finally
//    AppUserConfigStorage.CloseSection;
//  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.SetupDefaultFocus;
begin
     // grid
  cxGridPTN.SetFocus;
     // columns
  cxGridPTN_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe20PrihotTovaraPoNakladnim.SetupQtyFields;
begin
     // Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Остаток
  TcxCurrencyEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat :=
    QtyDisplayFormat;
end;

procedure Tframe20PrihotTovaraPoNakladnim.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Создать_счет_фактуры)
    then
    bbInvoiceNew.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Изменить_счет_фактуры)
    then
    bbInvoiceEdit.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ПТПН_Удалить_счет_фактуры)
    then
    bbInvoiceDelete.Visible := ivNever;

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_НДН_Изменение_наименования_для_накладной)
    then
  begin
    cxGridComponents_GOODS_NAMEACNT.Options.Editing := False;
    TcxButtonEditProperties(cxGridComponents_GOODS_NAMEACNT.Properties).Buttons.Clear;
  end;

  if dxBarManagerBarInvoice.ItemLinks.VisibleItemCount <= 0 then
  begin
    dxBarManagerBarInvoice.Visible := False;
    dxBarDockControlInvoices.Visible := False;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.DocSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCanClose, fCanOpen: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := false;

  fCanClose := False;
  fCanOpen := False;

  if (cxGridPTNTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;

    fCanClose := not FLG_CLOSED; // Закрыть накладную
    fCanOpen := FLG_CLOSED;     // Открыть накладную
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbActionCloseDoc.Enabled := fCanClose;  // Закрыть накладную
  bbActionOpenDoc.Enabled := fCanOpen;  // Открыть накладную

  if fDocEdit then
    cxGridComponents_GOODS_NAMEACNT.Options.ShowEditButtons := isebDefault
  else
    cxGridComponents_GOODS_NAMEACNT.Options.ShowEditButtons := isebNever;

  GoodsSelectionChanged;
  InvoiceSelectionChanged;
  AttachFileSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ShowAddNewGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    dialog.DefaultPriceColumn := 0;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ShowCreateNewInvoiceDialog;
var
  dialog: TfrmPTNInvoiceDlg;
begin
  dialog := TfrmPTNInvoiceDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
  try
    dialog.CreateNew := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ShowEditInvoiceDialog;
var
  dialog: TfrmPTNInvoiceDlg;
begin
  dialog := TfrmPTNInvoiceDlg.Create(Self, IBCQueryINVOICES, IBCDataSourceINVOICES);
  try
    dialog.CreateNew := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ShowModifyGoodsAcntDialog;
var
  dialog: TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg;
begin
  dialog := TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg.Create(Self);
  try
    dialog.GoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryJurnal.Refresh;
  finally
    dialog.free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := False;
    dialog.DefaultPriceColumn := 0;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.WhenGoodsGridFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.WhenDocGridFocusedRecordChanged(Sender:
  TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbAttachFileModifyClick(Sender: TObject);
var
  dialog: Tfrm53RPPFileEditorDlg;
begin
  dialog := Tfrm53RPPFileEditorDlg.Create(Self, IBCQueryFiles, IBCDataSourceFiles);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.bbAttachFileRemoveClick(Sender: TObject);
begin
  if ShowAskDialog('Facturi', Format('Doriti sa stergeti fisierul: "%s"?', [IBCQueryFiles.FieldByName
    ('FILENAME').AsString])) = mrYes then
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

procedure Tframe20PrihotTovaraPoNakladnim.bbAttachFileSaveAsClick(Sender: TObject);
var
  dir: string;
begin
  dir := fLastFilePath;
  if SelectDirectory('Alegeti calea unde va fi salvat documentul', '', dir) then
  begin
    SaveFileFromDB(IBCQueryFiles.FieldByName('ATTID').AsInteger, dir);
    fLastFilePath := dir;
  end;
end;

procedure Tframe20PrihotTovaraPoNakladnim.SaveFileFromDB(const AttID: integer;
  const FilePath: string);
var
  Query: TIBCQuery;
  filename: string;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text :=
      'SELECT FILENAME,FILEDATA FROM TDB_DOCS_ATTACHMENTS WHERE ATTID=:ID';
    Query.ParamByName('ID').AsInteger := AttID;
    Query.ExecSQL;
    if not Query.Eof then
    begin
      filename := IncludeTrailingPathDelimiter(FilePath) + Query.Fields[0].AsString;
      TBlobField(Query.Fields[1]).SaveToFile(filename);
    end;
  finally
    Query.Free;
  end;
end;

end.


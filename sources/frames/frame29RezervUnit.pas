unit frame29RezervUnit;
{
  НАКЛАДНЫЕ. Резерв
  DocTypeID = 108
  Frame Index = 29
}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxStyles,
  cxGraphics,
  DB,
  cxDBData,
  dxBar,
  ExtCtrls,
  cxSplitter,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  cxCalc,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxCurrencyEdit,
  cxLabel,
  cxImageComboBox,
  cxClasses,
  dxUIAClasses;

type
  Tframe29Rezerv = class(TSWNBaseFrame)
    cxGridRezerv: TcxGrid;
    cxGridRezervTable: TcxGridDBTableView;
    cxGridRezervTable_DOCID: TcxGridDBColumn;
    cxGridRezervTable_DATA: TcxGridDBColumn;
    cxGridRezervTable_DTDEP_NAME: TcxGridDBColumn;
    cxGridRezervTable_CT_NAME: TcxGridDBColumn;
    cxGridRezervTable_SUMA: TcxGridDBColumn;
    cxGridRezervTable_CURRENCY_NAME: TcxGridDBColumn;
    cxGridRezervTable_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridRezervLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewItem: TdxBarButton;
    bbModifyItem: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    cxGridComponents: TcxGrid;
    cxGridComponentsTable: TcxGridDBTableView;
    cxGridDBCol_DTDEP_NAME: TcxGridDBColumn;
    cxGridDBCol_GOODSID: TcxGridDBColumn;
    cxGridDBCol_IMG: TcxGridDBColumn;
    cxGridDBCol_GOODS_NAME: TcxGridDBColumn;
    cxGridDBCol_QTY: TcxGridDBColumn;
    cxGridDBCol_UM_NAME: TcxGridDBColumn;
    cxGridDBCol_PRICE: TcxGridDBColumn;
    cxGridDBCol_SUMA: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridComponents_UMID: TcxGridDBColumn;
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbNewItemClick(Sender: TObject);
    procedure bbModifyItemClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure cxPageControlComplectChange(Sender: TObject);
    procedure cxGridRezervTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridRezervTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridRezervTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    procedure WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;

    procedure WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;

    procedure ShowNewSelectedGoodsDialog;
    procedure ShowModifySelectedGoodsDialog;
    procedure ShowRemoveSelectedGoodsDialog;

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

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleAdditions,
  DataModuleDB,
  SWNUtils,
  SWNConst,
  frmRezervDocDialog,
  frmSelectGoodsToAddDialog,
  SWNValueStorageUnit,
  SWNDBErrors;

{$R *.dfm}

{ Tframe10NakladnieRN }

procedure Tframe29Rezerv.bbModifyItemClick(Sender: TObject);
begin
  ShowModifySelectedGoodsDialog
end;

procedure Tframe29Rezerv.bbNewItemClick(Sender: TObject);
begin
  ShowNewSelectedGoodsDialog;
end;

procedure Tframe29Rezerv.bbRemoveItemClick(Sender: TObject);
begin
  ShowRemoveSelectedGoodsDialog;
end;

procedure Tframe29Rezerv.CreateNewRecord;
var
  dialog: TfrmRezervDocDlg;
begin
  dialog := TfrmRezervDocDlg.Create(self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe29Rezerv.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyItem.Enabled then
  begin
    ShowModifySelectedGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe29Rezerv.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe29Rezerv.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe29Rezerv.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  inherited;
  if ARecord.Values[cxGridDBCol_STOCK_QTY.Index] <= 0 then
    AStyle := dmAdditions.cxStyle_GoodsOutOfStock;
end;

procedure Tframe29Rezerv.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe29Rezerv.cxGridRezervTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe29Rezerv.cxGridRezervTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe29Rezerv.cxGridRezervTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(Self, cxGridRezervTable, Key, Shift);
end;

procedure Tframe29Rezerv.cxPageControlComplectChange(Sender: TObject);
begin
  DocumentSelectionChanged;
end;

procedure Tframe29Rezerv.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Удалить запись номер %d?', [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))
    = mrYes then
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

procedure Tframe29Rezerv.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridRezervTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridRezervTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe29Rezerv.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridRezervTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridRezervTable.OnFocusedRecordChanged := WhenDocumentGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  DocumentSelectionChanged;
end;

function Tframe29Rezerv.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridRezervTable.Site.Focused then
  begin
              // context from Docs
    if cxGridRezervTable_CT_NAME.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridRezervTable_DATA.Focused then
    begin
                       // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridRezervTable_DTDEP_NAME.Focused then
    begin
                           // Склад
      Result.Context := ffStock;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe29Rezerv.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe29Rezerv.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffStock];
end;

function Tframe29Rezerv.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

procedure Tframe29Rezerv.GoodsSelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete: boolean;
begin
  fGoodsAdd := False;
  fGoodsEdit := false;
  fGoodsDelete := false;

  if (cxGridRezervTable.DataController.RecNo > 0) then
  begin

    fGoodsAdd := True; // New item for "Состав"+ Security

    if (cxGridComponentsTable.DataController.RecNo > 0) then
    begin
      fGoodsEdit := True; // Modify "Состав" + Security
      fGoodsDelete := True; // Delete "Состав" + Security
    end;
  end;
     // goods
  bbNewItem.Enabled := fGoodsAdd;
  bbModifyItem.Enabled := fGoodsEdit;
  bbRemoveItem.Enabled := fGoodsDelete;
end;

function Tframe29Rezerv.InitFrameID: integer;
begin
  Result := 29; // НАКЛАДНЫЕ. Резерв
  SetupQtyFields;
end;

procedure Tframe29Rezerv.ModifyRecord;
var
  dialog: TfrmRezervDocDlg;
begin
  dialog := TfrmRezervDocDlg.Create(self);
  try
    dialog.CreateNewDocument := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe29Rezerv.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//        pnBottom.Height:=AppUserConfigStorage.IntValues.GetValue('BottomHeight',300);
//        cxSplitter.State:=TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe29Rezerv.ShowNewSelectedGoodsDialog;
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

procedure Tframe29Rezerv.ShowModifySelectedGoodsDialog;
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

procedure Tframe29Rezerv.ShowRemoveSelectedGoodsDialog;
var
  S: WideString;
begin
  S := Format('Удалить товар' + #13#10 + '"%s"?', [dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').asString]);
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, S) = mrYes then
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

procedure Tframe29Rezerv.WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe29Rezerv.WhenGoodsGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe29Rezerv.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//        AppUserConfigStorage.IntValues.SetValue('BottomHeight',pnBottom.Height);
//        AppUserConfigStorage.IntValues.SetValue('SplitterState',Ord(cxSplitter.State));
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe29Rezerv.SetupDefaultFocus;
begin
     // grid
  cxGridRezerv.SetFocus;
     // columns
  cxGridRezervTable_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe29Rezerv.SetupQtyFields;
begin
     // Кол-во
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Остаток
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe29Rezerv.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
begin
  fDocNew := True;      // New Doc + Security
  fDocEdit := False;
  fDocDelete := False;

  if cxGridRezervTable.DataController.RecNo > 0 then
  begin
    fDocEdit := True;   // Edit Doc + Security
    fDocDelete := True; // Delete Doc + Security
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  GoodsSelectionChanged;
end;

end.


unit frame76ActiuniProduseWeb;

// MARKETING / Lichidare de stoc produse web
// DocTypeID = 3187
// Frame Index = 76

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCurrencyEdit, cxLabel, cxCheckBox, cxImageComboBox, dxBar,
  cxClasses, cxSplitter, ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxGrid, IBC, cxLookAndFeels,
  cxLookAndFeelPainters, cxGridCustomPopupMenu, cxGridPopupMenu, cxNavigator, cxCalc, MemDS, DBAccess,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu, dxDateRanges, dxScrollbarAnnotations,
  dxUIAClasses;

type
  Tframe76ActiuniProduseWeb = class(TSWNBaseFrame)
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
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    cxGridPTN_RATEUSD: TcxGridDBColumn;
    dxBarPopupMenuDOCS: TdxBarPopupMenu;
    cxGridPTN_CT: TcxGridDBColumn;
    cxGridPTN_SC2_NAME: TcxGridDBColumn;
    Panel1: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryALERT_GOODS_AVL: TIBCQuery;
    IBCDS_ALERT_GOODS_AVL: TIBCDataSource;
    cxGrid1DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid1DBTableView1CUSTOMER_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ALERT_MAIL: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ALERT_SMS: TcxGridDBColumn;
    cxGrid1DBTableView1EMAIL: TcxGridDBColumn;
    cxGrid1DBTableView1GSM_NUMBER: TcxGridDBColumn;
    cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
    cxGrid1DBTableView1GOODS_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1CREATED_BY: TcxGridDBColumn;
    cxGrid1DBTableView1CREATE_BY_NAME: TcxGridDBColumn;
    cxGrid1DBTableView1FLG_ACTIVE: TcxGridDBColumn;
    procedure cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure dxBarPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGrid1DBTableView1SelectionChanged(Sender: TcxCustomGridTableView);
    procedure bbNewClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete: Boolean;
    fDSEQuantity: integer;
    procedure WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
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
    procedure ShowForcedReminder(IsNewRecord: boolean);
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, frmВходныеСчетаDocDialog, SWNUtils, SWNDBErrors,
  frmSelectGoodsToAddDialog, SWNSecurity, SWNSecurityFlags, SWNValueStorageUnit,
  frmImportGoodsPricesDialog, frmVhodnieScetaGoodsAnalyzeDialog, SWNCommonDialogs, frm73DocDialog, AddDSEUnit,
  uDSENumberGenerator, frm75DocDialog, frm75GoodsDlgUnit;

{$R *.dfm}
{ Tframe73DSE }

procedure Tframe76ActiuniProduseWeb.bbCustomerDebtsClick(Sender: TObject);
begin
  TSWNCommonDialogs.CustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe76ActiuniProduseWeb.bbDeleteClick(Sender: TObject);
begin
  if ShowAskDialog('', 'Sterge inregistrarea?')=mrYes then
  begin
    IBCQueryALERT_GOODS_AVL.Delete;
  end;
end;

procedure Tframe76ActiuniProduseWeb.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe76ActiuniProduseWeb.bbModifyClick(Sender: TObject);
begin
  ShowForcedReminder(False);
end;

procedure Tframe76ActiuniProduseWeb.bbNewClick(Sender: TObject);
begin
  ShowForcedReminder(True);
end;

function Tframe76ActiuniProduseWeb.AddNewRecord(const SerialNumber: String; var ErrorStr: String): Boolean;
begin
end;

procedure Tframe76ActiuniProduseWeb.WhenAddSerialFromScanner(const SerialNumber: String; var Added: Boolean);
begin
end;

procedure Tframe76ActiuniProduseWeb.WhenBeginToAddSerials(Sender: TObject);
begin

end;

procedure Tframe76ActiuniProduseWeb.WhenEndToAddSerials(Sender: TObject);
begin

end;

procedure Tframe76ActiuniProduseWeb.CreateNewRecord;
var
  dialog: Tfrm75DocDlg;
begin
  dialog := Tfrm75DocDlg.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;
procedure Tframe76ActiuniProduseWeb.cxGrid1DBTableView1SelectionChanged(Sender: TcxCustomGridTableView);
var
  fGoodsNew,fGoodsEdit,fGoodsDelete,fGoodsSelected:Boolean;
  DATA: TDateTime;
  FLG_Enabled: Boolean;
begin
     fGoodsNew:=False;
     fGoodsEdit:=False;
     fGoodsDelete:=False;
     fGoodsSelected:=False;

     if (cxGridPTNTable.DataController.RecNo > 0) then
     begin
       FLG_Enabled := (dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime = Date);

       fGoodsNew := FLG_Enabled;
       if (cxGrid1DBTableView1.DataController.RecNo>0) then
       begin
         fGoodsNew := FLG_Enabled;
         fGoodsEdit := FLG_Enabled;
         fGoodsDelete := FLG_Enabled;
         fGoodsSelected := FLG_Enabled;
       end;
     end;

     // goods
     bbNew.Enabled:=fGoodsNew;
     bbModify.Enabled:=fGoodsEdit;
     bbDelete.Enabled:=fGoodsDelete;
end;


procedure Tframe76ActiuniProduseWeb.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea №%d?',
    [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger])) = mrYes then
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

procedure Tframe76ActiuniProduseWeb.DocSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fDebts, fImportGoods: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;
  fDebts := False;
  fImportGoods := False;

  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

  fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED;
  fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;
  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

end;

procedure Tframe76ActiuniProduseWeb.DoFrameHide;
begin
  // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

  // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridPTNTable.OnFocusedRecordChanged := nil;

  // 2. De deconectat sursele de date de la griduri
  cxGridPTNTable.DataController.DataSource := nil;

  IBCQueryALERT_GOODS_AVL.Active := False;
  cxGrid1DBTableView1.DataController.DataSource := nil;
end;

procedure Tframe76ActiuniProduseWeb.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

  IBCQueryALERT_GOODS_AVL.Active := True;
  cxGrid1DBTableView1.DataController.DataSource := IBCDS_ALERT_GOODS_AVL;
end;

procedure Tframe76ActiuniProduseWeb.dxBarPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe76ActiuniProduseWeb.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe76ActiuniProduseWeb.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe76ActiuniProduseWeb.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe76ActiuniProduseWeb.InitFrameID: integer;
begin
  // Documentatia de proiect
  Result := 76;
  SetupQtyFields;
end;

procedure Tframe76ActiuniProduseWeb.ModifyRecord;
var
  dialog: Tfrm75DocDlg;
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  if fSECURITY_CanEdit and not FLG_CLOSED then
  begin
    dialog := Tfrm75DocDlg.Create(Self);
    try
      dialog.CreateNewDocument := False;
      dialog.ShowModal;
    finally
      dialog.Free;
    end;
  end;
end;

procedure Tframe76ActiuniProduseWeb.SetupDefaultFocus;
begin
  // grid
  cxGridPTN.SetFocus;
  // columns
  cxGridPTN_CT_NAME.Focused := True;
end;

procedure Tframe76ActiuniProduseWeb.SetupQtyFields;
begin
  // Cantitate
end;

procedure Tframe76ActiuniProduseWeb.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_APD_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_APD_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_APD_Редактировать);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_OFERTE_APD_Удалить);
end;

procedure Tframe76ActiuniProduseWeb.WhenDocGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocSelectionChanged;
end;

procedure Tframe76ActiuniProduseWeb.WhenDocumentPopupMenuOpen;
var
  fCreatePrihodRashod: Boolean;
  FLG_CLOSED: Boolean;
begin
  fCreatePrihodRashod := False;

  if (cxGridPTNTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger = 1)
  then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fCreatePrihodRashod := (not FLG_CLOSED); // Creare Nakladnaia de intrare
  end;
end;

procedure Tframe76ActiuniProduseWeb.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe76ActiuniProduseWeb.cxGridPTNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (AButton = mbLeft) and fSECURITY_CanEdit then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe76ActiuniProduseWeb.cxGridPTNTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridPTN_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridPTN_FLG_ACNT.index] = 1 then
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

procedure Tframe76ActiuniProduseWeb.cxGridPTN_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridPTN_DATA.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridPTN_DATA.index]);
end;

procedure Tframe76ActiuniProduseWeb.ShowForcedReminder(IsNewRecord: boolean);
var
  dialog: Tfrm75GoodsDialog;
begin
  dialog := Tfrm75GoodsDialog.Create(self, IBCQueryALERT_GOODS_AVL, IBCDS_ALERT_GOODS_AVL);
  try
    dialog.IsNewRecord := IsNewRecord;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

end.

unit frame18SciotNaOplatuUnit;

// FACTURI. Facturi de plata
// DocTypeID = 101
// Frame Index = 18

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
  System.UITypes,
  Dialogs,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxGraphics,
  DB,
  cxDBData,
  dxBar,
  IBC,
  cxSplitter,
  cxPC,
  ExtCtrls,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  cxGridPopupMenu,
  cxCalc,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
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
  cxCheckBox,
  cxImageComboBox,
  dxBarBuiltInMenu,
  cxGridCustomPopupMenu,
  DBAccess,
  MemDS,
  cxClasses,
  dxUIAClasses;

type
  Tframe18SciotNaOplatu = class(TSWNBaseFrame)
    cxGridScetOplata: TcxGrid;
    cxGridScetOplataTable: TcxGridDBTableView;
    cxGridScetOplata_DOCID: TcxGridDBColumn;
    cxGridScetOplata_DATA: TcxGridDBColumn;
    cxGridScetOplata_DTDEP_NAME: TcxGridDBColumn;
    cxGridScetOplata_CT_NAME: TcxGridDBColumn;
    cxGridScetOplata_SUMA: TcxGridDBColumn;
    cxGridScetOplata_CURRENCY_NAME: TcxGridDBColumn;
    cxGridScetOplata_VAT: TcxGridDBColumn;
    cxGridScetOplata_RATE: TcxGridDBColumn;
    cxGridScetOplata_PARENTDOCID: TcxGridDBColumn;
    cxGridScetOplata_FLG_ACNT: TcxGridDBColumn;
    cxGridScetOplata_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridScetOplataLevel: TcxGridLevel;
    pnBottom: TPanel;
    cxPageControlComplect: TcxPageControl;
    tbsGoods: TcxTabSheet;
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
    cxGridDBCol_SUMAVAT: TcxGridDBColumn;
    cxGridDBCol_STOCK_QTY: TcxGridDBColumn;
    cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn;
    cxGridDBCol_FLG_READY: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    tbsKitContent: TcxTabSheet;
    cxGridComplect: TcxGrid;
    cxGridComplectTable: TcxGridDBTableView;
    cxGridComplect_GOODSID: TcxGridDBColumn;
    cxGridComplectTableCol_IMG: TcxGridDBColumn;
    cxGridComplect_GOODS_NAME: TcxGridDBColumn;
    cxGridComplect_UM_NAME: TcxGridDBColumn;
    cxGridComplect_QTY: TcxGridDBColumn;
    cxGridComplect_PRICE: TcxGridDBColumn;
    cxGridComplect_SUMA: TcxGridDBColumn;
    cxGridComplect_SUMAVAT: TcxGridDBColumn;
    cxGridComplect_FLG_ACNT: TcxGridDBColumn;
    cxGridComplect_WARRANTY: TcxGridDBColumn;
    cxGridComplect_STOCK_QTY: TcxGridDBColumn;
    cxGridComplect_FLG_ACTIVE: TcxGridDBColumn;
    cxGridComplect_FLG_READY: TcxGridDBColumn;
    cxGridComplectLevel: TcxGridLevel;
    cxSplitter: TcxSplitter;
    dxBarManager: TdxBarManager;
    IBCQueryJurnalKit: TIBCQuery;
    IBCDataSourceJurnalKit: TIBCDataSource;
    dxPopupMenuDOCS: TdxBarPopupMenu;
    cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn;
    cxGridScetOplata_FLG_PAID: TcxGridDBColumn;
    cxGridScetOplata_FLG_INVOICE: TcxGridDBColumn;
    bbAction_PrihodDenegNaScet: TdxBarButton;
    bbAction_CreateRashod: TdxBarButton;
    bbAction_RashodService: TdxBarButton;
    cxGridScetOplata_RATEUSD: TcxGridDBColumn;
    cxGridScetOplata_DT: TcxGridDBColumn;
    cxGridScetOplata_CT: TcxGridDBColumn;
    cxGridPopupMenuDOCS: TcxGridPopupMenu;
    bbGotoParentDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn;
    cxGridComplect_GOODS_ACNT_ID: TcxGridDBColumn;
    cxGridComplect_GOODS_NAMEACNT: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridComplect_UMID: TcxGridDBColumn;
    cxGridPopupMenuComponents: TcxGridPopupMenu;
    cxGridPopupMenuComplect: TcxGridPopupMenu;
    dxBarPopupMenuComponents: TdxBarPopupMenu;
    dxBarPopupMenuComplect: TdxBarPopupMenu;
    bbGoodsInfoCard_Components: TdxBarButton;
    bbGoodsPrice_Components: TdxBarButton;
    bbGoodsForeignCode_Components: TdxBarButton;
    bbGoodsInfoCard_Complect: TdxBarButton;
    bbGoodsPrice_Complect: TdxBarButton;
    bbGoodsForeignCode_Complect: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbChangeGoods: TdxBarButton;
    procedure bbAction_PrihodDenegNaScetClick(Sender: TObject);
    procedure bbAction_CreateRashodClick(Sender: TObject);
    procedure bbAction_RashodServiceClick(Sender: TObject);
    procedure cxGridScetOplataTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dxPopupMenuDOCSPopup(Sender: TObject);
    procedure cxGridScetOplataTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridScetOplataTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridScetOplata_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
      AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsInfoCard_ComponentsClick(Sender: TObject);
    procedure bbGoodsPrice_ComponentsClick(Sender: TObject);
    procedure bbGoodsForeignCode_ComponentsClick(Sender: TObject);
    procedure bbGoodsInfoCard_ComplectClick(Sender: TObject);
    procedure bbGoodsPrice_ComplectClick(Sender: TObject);
    procedure bbGoodsForeignCode_ComplectClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbChangeGoodsClick(Sender: TObject);
  private
    { Private declarations }
    fLastDocID: integer;
    fSec_Edit, fSec_View: Boolean;
    procedure WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenGridComplectFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure ComplectSelectionChanged;
    procedure WhenDocumentPopupMenuOpen;
    procedure DoPrihodDenegNaSceot;
    procedure DoSozdatRashod;
    procedure DoSozdatRashodServis;
    procedure SetupQtyFields;
    procedure ShowModifyGoodsDialog;
    function WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure ModifyRecord; override;
    function GetPhoneNumber: string; override;
    procedure RefreshData; override;
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
  DataModuleDB, SWNCommonDialogs, SWNConst, SWNSecurity, SWNSecurityFlags, SWNUtils, SWNValueStorageUnit,
  frmCreateCustomNareadSborkaDialog, frmMoneyIncomeDialog, frmScetNaOplatuDocDialog, frmSelectGoodsToAddDialog,
  frmSelectPhoneNumberUnit;

{$R *.dfm}

{ Tframe18SciotNaOplatu }

procedure Tframe18SciotNaOplatu.bbAction_PrihodDenegNaScetClick(Sender: TObject);
begin
  DoPrihodDenegNaSceot;
end;

procedure Tframe18SciotNaOplatu.bbAction_CreateRashodClick(Sender: TObject);
begin
  DoSozdatRashod;
end;

procedure Tframe18SciotNaOplatu.bbAction_RashodServiceClick(Sender: TObject);
begin
  DoSozdatRashodServis;
end;

procedure Tframe18SciotNaOplatu.bbChangeGoodsClick(Sender: TObject);
begin
  inherited;
  ShowModifyGoodsDialog;
end;

procedure Tframe18SciotNaOplatu.bbCustomerDebtsClick(Sender: TObject);
begin
  dmDB.ShowCustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe18SciotNaOplatu.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe18SciotNaOplatu.bbGoodsForeignCode_ComplectClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe18SciotNaOplatu.bbGoodsForeignCode_ComponentsClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe18SciotNaOplatu.bbGoodsInfoCard_ComplectClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe18SciotNaOplatu.bbGoodsInfoCard_ComponentsClick(Sender: TObject);
begin
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe18SciotNaOplatu.bbGoodsPrice_ComplectClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(IBCQueryJurnalKit.FieldByName('GOODSID').AsInteger, IBCQueryJurnalKit.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe18SciotNaOplatu.bbGoodsPrice_ComponentsClick(Sender: TObject);
begin
  TSWNCommonDialogs.ModifyGoodsPriceDlg(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe18SciotNaOplatu.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe18SciotNaOplatu.ComplectSelectionChanged;
var
  fSelected: Boolean;
begin
  fSelected := False;

  fSelected := cxGridComplectTable.DataController.RecNo > 0;

  bbGoodsInfoCard_Complect.Enabled := fSelected;
  bbGoodsPrice_Complect.Enabled := fSelected;
  bbGoodsForeignCode_Complect.Enabled := fSelected;
end;

procedure Tframe18SciotNaOplatu.cxGridComplectTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe18SciotNaOplatu.cxGridComplectTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComplectTable, Key, Shift);
end;

procedure Tframe18SciotNaOplatu.cxGridComplect_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComplect_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe18SciotNaOplatu.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe18SciotNaOplatu.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe18SciotNaOplatu.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe18SciotNaOplatu.cxGridScetOplataTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe18SciotNaOplatu.cxGridScetOplataTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if not VarIsNull(AViewInfo.GridRecord.Values[cxGridScetOplata_FLG_INVOICE.Index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridScetOplata_FLG_INVOICE.Index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clGrayText;
    end;
    if AViewInfo.GridRecord.Values[cxGridScetOplata_FLG_PAID.Index] = 1 then
    begin
      if not AViewInfo.Selected then
        ACanvas.Font.Color := clTeal;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe18SciotNaOplatu.cxGridScetOplataTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridScetOplataTable, Key, Shift);
end;

procedure Tframe18SciotNaOplatu.cxGridScetOplata_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridScetOplata_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridScetOplata_DATA.Index]);
end;

function Tframe18SciotNaOplatu.GetPhoneNumber;
begin
  inherited;
  Result := '';
  frmSelectPhoneNumber := TfrmSelectPhoneNumber.Create(Self);
  try
    frmSelectPhoneNumber.CustomerID := dmdb.IBCQueryDocs.FieldByName('CT').AsInteger;
    if frmSelectPhoneNumber.ShowModal = mrOK then
    begin
      Result := frmSelectPhoneNumber.SelectedPhoneNumber;
    end;
  finally
    frmSelectPhoneNumber.Free;
  end;
end;

procedure Tframe18SciotNaOplatu.DocumentSelectionChanged;
var
  fDocEdit, DocChanged, fDebts: Boolean;
begin
  fDocEdit := False;
  DocChanged := True;
  fDebts := False;

  if cxGridScetOplataTable.DataController.RecNo > 0 then
  begin
    fDocEdit := fSec_View or fSec_Edit; // Modify Doc
    DocChanged := fLastDocID <> dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    fLastDocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

    fDebts := True;
  end;
     // doc
  ButtonStateChanged(fbtMODIFY, fDocEdit);
     // tabs
  cxPageControlComplect.ActivePage := tbsGoods;

  if DocChanged then
  begin
    cxPageControlComplect.ActivePage := tbsGoods;
  end;

     // popup menu
  bbCustomerDebts.Enabled := fDebts;

  WhenDocumentPopupMenuOpen;
end;

procedure Tframe18SciotNaOplatu.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryJurnalKit.Active := False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridScetOplataTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridScetOplataTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe18SciotNaOplatu.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  fLastDocID := -1;

     // 1. Legam grid-urile de datasource-sele
  cxGridScetOplataTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridScetOplataTable.OnFocusedRecordChanged := WhenDocumentGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;
  cxGridComplectTable.OnFocusedRecordChanged := WhenGridComplectFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryJurnalKit.Active := True;

     // 4. Selection update
  DocumentSelectionChanged;
  SelectionChanged;
end;

procedure Tframe18SciotNaOplatu.DoPrihodDenegNaSceot;
var
  dialog: TfrmMoneyIncomeDlg;
begin
     // Incasare bani in cont
  dialog := TfrmMoneyIncomeDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    dialog.ShowBanknotesCounter := false;
    dialog.ShowModIncasare := false;
    dialog.SetCustomTitle('Ordin de incasare', 'incasare in cont bancar');

    if dialog.ShowModal = mrOk then
    begin
             // Incasare bani in cont
      if dmDB.CreateProhodDenegNaSciot(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.CurrencyID, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger, dialog.Rate, dialog.SUMA) then
      begin
        dmDB.IBCQueryDocs.Refresh;
        ShowInfoDialog('Ordin de incasare', 'Creat cu succes!');
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe18SciotNaOplatu.DoSozdatRashod;
var
  DocID: integer;
  rashodDocID: integer;
  createSborka: Boolean;
  S: string;
  dialog: TfrmCreateCustomNareadSborkaDlg;
  result: integer;
  firma: integer;
begin
  DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;

  result := 0; // nothing done
     // 1 - Factura de iesire a fost creata cu succes
     // 2 - Nakladnaia de iesire a fost creata cu succes! Atentie! Naryad de asamblare nu a fost creat.
     // 3 - Nakladnaia de iesire si Naryad de asamblare au fost create cu succes!
  if dmDB.DocumentHasComplecte(DocID) then
  begin
    S := #13#10 + 'Atentie!' + #13#10 + 'In aceasta configuratie au fost gasite produse pentru asamblare!';
    if ShowAskDialogVerification('Rezerva', 'Creez document "Rezerva"?' + #13#10 + S, 'Creaza document "Asamblare"?', '',
      createSborka) = mrYes then
    begin
      rashodDocID := dmDB.CreateRashodnaiaNakladnaia_DB(DocID);
      if rashodDocID <> -1 then
      begin
        if createSborka then
        begin
          dialog := TfrmCreateCustomNareadSborkaDlg.Create(Self);
          try
            if dialog.ShowModal = mrOk then
            begin
              firma := dmDB.CurrentFirma;
              if dialog.IsCustomFirma then
                firma := dialog.CustomFirma;

              if dmDB.CreateNariadNaSborkuIzConfiguratora_DB(DocID, rashodDocID, firma) then
                result := 3
              else
                result := 2;
            end
            else
              result := 2;
          finally
            dialog.Free;
          end;
        end
        else
          result := 2;
      end;
    end
  end
  else if ShowAskDialog('Rezerva', 'Creati document "Rezerva"') = mrYes then
  begin
    rashodDocID := dmDB.CreateRashodnaiaNakladnaia_DB(DocID);
    if rashodDocID <> -1 then
      result := 1;
  end;

  case result of
    1:
      ShowInfoDialog('Proforma', 'Documentul "Rezerva" a fost creata cu succes!');
    2:
      ShowInfoDialog('Proforma',
        'Documentul "Rezerva" a fost creata cu succes!'#13#10#13#10'Atentie! Document asamblare nu a fost creat!');
    3:
      ShowInfoDialog('Proforma', 'Document "Rezerva" si "Asamblare" au fost create cu succes!');
  end;

  dmDB.IBCQueryDocs.Refresh;
end;

procedure Tframe18SciotNaOplatu.DoSozdatRashodServis;
begin
     // Creare "Nakladnaia de iesire pe service"
  if ShowAskDialog('Rezerva in service', 'Creez document "Rezerva: si "Asamblare"?') = mrYes then
  begin
    if dmDB.CreateRashodnaiaNakladnaiaServis_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      dmDB.IBCQueryDocs.Refresh;
      ShowInfoDialog('', 'Document "Rezerva" creat cu succes!');
    end;
  end;
end;

procedure Tframe18SciotNaOplatu.dxBarButton1Click(Sender: TObject);
begin
  dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, '');
end;

procedure Tframe18SciotNaOplatu.dxPopupMenuDOCSPopup(Sender: TObject);
begin
  WhenDocumentPopupMenuOpen;
end;

function Tframe18SciotNaOplatu.GetCurrentSearchContext: TSearchContextValue;
begin
  result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal
    result.Context := ffGoods;
    result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridScetOplataTable.Site.Focused then
  begin
          // context from Docs
    if cxGridScetOplata_CT_NAME.Focused then
    begin
      result.Context := ffCustomer;
      result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridScetOplata_DATA.Focused then
    begin
      result.Context := ffDate;
      result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
    else if cxGridScetOplata_DTDEP_NAME.Focused then
    begin
      result.Context := ffStock;
      result.ValueInt := dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger;
      result.ValueStr := dmDB.IBCQueryDocs.FieldByName('DTDEP_NAME').AsString;
    end;
  end
end;

function Tframe18SciotNaOplatu.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  result := [fedsDocs, fedsJurnal];
end;

function Tframe18SciotNaOplatu.GetFilterFields: TFrameFilterFields;
begin
  result := [ffDate, ffCustomer, ffGoods, ffGoodsFolders, ffAcntGoods];
end;

function Tframe18SciotNaOplatu.GetFrameButtons: TFrameButtons;
begin
  result := [fbtREFRESH, fbtDial];
  if fSec_Edit or fSec_View then
    result := result + [fbtMODIFY];
end;

function Tframe18SciotNaOplatu.InitFrameID: integer;
begin
     // FACTURI - Facturi de plata
  result := 18;
  SetupQtyFields;
end;

procedure Tframe18SciotNaOplatu.ModifyRecord;
var
  dialog: TfrmScetNaOplatuDocDlg;
begin
  dialog := TfrmScetNaOplatuDocDlg.Create(Self);
  try
    dialog.readonly := fSec_View and (not fSec_Edit);
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe18SciotNaOplatu.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridScetOplataTable);
    ReadGridColumnsSettings(cxGridComponentsTable);
    ReadGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe18SciotNaOplatu.RefreshData;
begin
  inherited;
  IBCQueryJurnalKit.Refresh;
end;

procedure Tframe18SciotNaOplatu.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridScetOplataTable);
    SaveGridColumnsSettings(cxGridComponentsTable);
    SaveGridColumnsSettings(cxGridComplectTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe18SciotNaOplatu.SelectionChanged;
var
  fKit: Boolean;
  fSelected: Boolean;
begin
  fKit := False;
  fSelected := False;
  if cxGridScetOplataTable.DataController.RecNo > 0 then
  begin
    if cxGridComponentsTable.DataController.RecNo > 0 then
    begin
      fSelected := True;
      fKit := dmDB.IsKit(dmDB.IBCQueryJurnal.FieldByName('GOODS_TYPE_ID').AsInteger);
    end;
  end;
  bbGoodsInfoCard_Components.Enabled := fSelected;
  bbGoodsPrice_Components.Enabled := fSelected;
  bbGoodsForeignCode_Components.Enabled := fSelected;

     // tabs
  tbsKitContent.TabVisible := fKit;

  ComplectSelectionChanged;
end;

procedure Tframe18SciotNaOplatu.SetupDefaultFocus;
begin
     // grid
  cxGridScetOplata.SetFocus;
     // columns
  cxGridScetOplata_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe18SciotNaOplatu.SetupQtyFields;
begin
     // Componenta: Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Componenta: Stoc
  TcxCalcEditProperties(cxGridDBCol_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
     // Configurare set: Cantitate
  TcxCalcEditProperties(cxGridComplect_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridComplect_QTY.Summary.FooterFormat := QtyDisplayFormat;
     // Configurare set: Stoc
  TcxCalcEditProperties(cxGridComplect_STOCK_QTY.Properties).DisplayFormat := QtyDisplayFormat;
end;

procedure Tframe18SciotNaOplatu.SetupSecurityItems;
begin
  fSec_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_СНО_Просмотр);
  fSec_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_СЧЕТА_СНО_Изменить);

     // Creare "Nakladnaia de iesire"
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Создать) then
    bbAction_CreateRashod.Visible := ivNever;
     // Creare "Nakladnaia de iesire pe service"
//     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_НАКЛАДНЫЕ_ВТ_Новый) then bbAction_RashodService.Visible:=ivNever;
     // Incasare bani in cont
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_ПДНС_Создать) then
    bbAction_PrihodDenegNaScet.Visible := ivNever;

     // Fisa produsului
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Карточка_товара) or SWNSecurityManager.IsPartialAccessMode
    then
  begin
    bbGoodsInfoCard_Components.Visible := ivNever;
    bbGoodsInfoCard_Complect.Visible := ivNever;
  end;

     // Modifica preturile marfii
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Изменение_валюты_и_цены_товара) or
    SWNSecurityManager.IsPartialAccessMode then
  begin
    bbGoodsPrice_Components.Visible := ivNever;
    bbGoodsPrice_Complect.Visible := ivNever;
  end;

     // Corespondenta produsului in alte firme
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Товары_Товары_из_других_фирм) then
  begin
    bbGoodsForeignCode_Components.Visible := ivNever;
    bbGoodsForeignCode_Complect.Visible := ivNever;
  end;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
  end;

  if (dxBarPopupMenuComponents.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuComponents.PopupMenus.Clear;
  if (dxBarPopupMenuComplect.ItemLinks.VisibleItemCount = 0) then
    cxGridPopupMenuComplect.PopupMenus.Clear;
end;

procedure Tframe18SciotNaOplatu.WhenDocumentGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

procedure Tframe18SciotNaOplatu.WhenDocumentPopupMenuOpen;
var
  fAction1, fAction2, fAction3: Boolean;
  FLG_INVOICE: Boolean;
  fGotoParent: Boolean;
begin
  fAction1 := False;
  fAction2 := False;
  fAction3 := False;
  fGotoParent := False;

  if (cxGridScetOplataTable.DataController.RecNo > 0) and (dmDB.IBCQueryDocs.FieldByName('HAS_JURNAL_GOODS').AsInteger = 1) then
  begin
    FLG_INVOICE := dmDB.IBCQueryDocs.FieldByName('FLG_INVOICE').AsInteger = 1;
          // popup actions
    fAction1 := True;                // Incasare bani in cont + Security
    fAction2 := (not FLG_INVOICE);   // Creare "Nakladnaia de iesire" + Security
    fAction3 := (not FLG_INVOICE);   // Creare "Nakladnaia de iesire pe service" + Security
    fGotoParent := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  end;
     // popup menu
  bbAction_PrihodDenegNaScet.Enabled := fAction1;
  bbAction_CreateRashod.Enabled := fAction2;
  bbAction_RashodService.Enabled := fAction3;
  bbDocComments.Enabled := fSec_Edit;

  bbGotoParentDoc.Enabled := fGotoParent;
end;

procedure Tframe18SciotNaOplatu.WhenGridComplectFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  ComplectSelectionChanged;
end;

procedure Tframe18SciotNaOplatu.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe18SciotNaOplatu.ShowModifyGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.OnVerifyGoodsExists := WhenCheckIfGoodsExists;
    dialog.DefaultPriceColumn := dmDB.IBCQueryDocs.FieldByName('CUSTOMER_PRICE_COLUMN').AsInteger;
    dialog.AllowedActions := dialog.AllowedActions + [acChangePrice];

    dialog.AddNewGoods := False;
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryDocs.Refresh;
  finally
    dialog.Free;
  end;
end;

function Tframe18SciotNaOplatu.WhenCheckIfGoodsExists(const GoodsID: Integer): Boolean;
var
    i: Integer;
begin
    result := False;
    for i := 0 to cxGridComponentsTable.DataController.RecordCount - 1 do
    begin
        if cxGridComponentsTable.DataController.Values[i, cxGridDBCol_GOODSID.Index] = GoodsID then
        begin
            result := True;
            Break;
        end;
    end;
end;

end.


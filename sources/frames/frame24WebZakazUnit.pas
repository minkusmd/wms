unit frame24WebZakazUnit;
{
  WEB. Comanda Web
  DocTypeID = 134
  Frame Index = 24
}

interface

uses SWNDealsUnit,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  SWNDataFiltering,
  SWNBaseFrameUnit,
  cxGraphics,
  DB,
  cxDBData,
  dxBar,
  cxSplitter,
  ExtCtrls,
  cxGridLevel,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  System.UITypes,
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
  cxCheckBox,
  cxCurrencyEdit,
  cxLabel,
  cxImageComboBox,
  System.ImageList,
  Vcl.ImgList,
  cxImageList,
  cxClasses,
  dxUIAClasses,
  Vcl.StdCtrls,
  cxContainer,
  cxPC,
  dxBarBuiltInMenu,
  cxVGrid,
  cxDBVGrid,
  cxInplaceContainer,
  cxImage,
  cxTextEdit,
  cxDBEdit,
  DBAccess,
  IBC,
  MemDS;

type
  Tframe24WebZakaz = class(TSWNBaseFrame)
    cxGridWZ: TcxGrid;
    cxGridWZTable: TcxGridDBTableView;
    cxGridWZ_DOCID: TcxGridDBColumn;
    cxGridWZ_DATA: TcxGridDBColumn;
    cxGridWZ_DTDEP_NAME: TcxGridDBColumn;
    cxGridWZ_CT_NAME: TcxGridDBColumn;
    cxGridWZ_SUMA: TcxGridDBColumn;
    cxGridWZ_VALUTA: TcxGridDBColumn;
    cxGridWZ_VAT: TcxGridDBColumn;
    cxGridWZ_RATE: TcxGridDBColumn;
    cxGridWZ_PARENTDOCID: TcxGridDBColumn;
    cxGridWZ_FLG_ACNT: TcxGridDBColumn;
    cxGridWZ_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridWZLevel: TcxGridLevel;
    pnBottom: TPanel;
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
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarPopupMenu: TdxBarPopupMenu;
    dxBarManagerBar1: TdxBar;
    cxSplitter1: TcxSplitter;
    bbAddGoods: TdxBarButton;
    bbModifyGoods: TdxBarButton;
    bbDeleteGoods: TdxBarButton;
    bbAction_Rashod: TdxBarButton;
    bbAction_Sceot: TdxBarButton;
    bbDocClose: TdxBarButton;
    cxGridWZ_CT: TcxGridDBColumn;
    cxGridWZ_FLG_CLOSED: TcxGridDBColumn;
    bbAction_Configurator: TdxBarButton;
    cxGridComponents_UMID: TcxGridDBColumn;
    cxGridWZ_DTSC_NAME: TcxGridDBColumn;
    cxGridWZ_CreatedDate: TcxGridDBColumn;
    dxBarPopupMenuJurnal: TdxBarPopupMenu;
    bbGoodsBalance: TdxBarButton;
    bbForeignGoodsKey: TdxBarButton;
    cxGridComponentsTable_FLD_FORCED_ADDON: TcxGridDBColumn;
    cxImageList1: TcxImageList;
    bbDocState: TdxBarButton;
    dxBarButton1: TdxBarButton;
    cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn;
    cxGridComponents_FLG_PROMO: TcxGridDBColumn;
    cxGridComponentsFLG_FORCED: TcxGridDBColumn;
    cxGridComponentsTableColumn1: TcxGridDBColumn;
    bbEcommInfo: TdxBarButton;
    bbCancelCashback: TdxBarButton;
    cxGridWZ_RESPONSIBLE_USERNAME: TcxGridDBColumn;
    cxGridWZ_PAYMENT_METHOD: TcxGridDBColumn;
    bbAssignToMe: TdxBarButton;
    cxPageControlBottom: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsCredit: TcxTabSheet;
    pnCreditState: TPanel;
    lbCreditState: TLabel;
    sbCredit: TScrollBox;
    pnCreditInfo: TPanel;
    lbCreditInfo: TLabel;
    cxDBVerticalGridCredit: TcxDBVerticalGrid;
    vgrCreditOrg: TcxDBEditorRow;
    vgrCreditType: TcxDBEditorRow;
    vgrCreditSuma: TcxDBEditorRow;
    vgrCreditPerioada: TcxDBEditorRow;
    vgrCreditRata: TcxDBEditorRow;
    vgrCreditAvans: TcxDBEditorRow;
    pnCreditPerson: TPanel;
    lbCreditPerson: TLabel;
    cxDBVerticalGridPerson: TcxDBVerticalGrid;
    vgrPersonNPP: TcxDBEditorRow;
    vgrPersonIDNP: TcxDBEditorRow;
    vgrPersonBirth: TcxDBEditorRow;
    vgrPersonPhone: TcxDBEditorRow;
    vgrPersonFax: TcxDBEditorRow;
    imgCreditScan1: TcxDBImage;
    imgCreditScan2: TcxDBImage;
    edCreditScan1Name: TcxDBTextEdit;
    edCreditScan2Name: TcxDBTextEdit;
    IBCQueryCredit: TIBCQuery;
    IBCDataSourceCredit: TIBCDataSource;
    bbCreditOnly: TdxBarButton;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbModifyGoodsClick(Sender: TObject);
    procedure bbDeleteGoodsClick(Sender: TObject);
    procedure cxGridWZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridWZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCloseClick(Sender: TObject);
    procedure bbAction_RashodClick(Sender: TObject);
    procedure bbAction_SceotClick(Sender: TObject);
    procedure bbAction_ConfiguratorClick(Sender: TObject);
    procedure bbCancelCashbackClick(Sender: TObject);
    procedure cxGridWZ_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridWZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbGoodsBalanceClick(Sender: TObject);
    procedure bbForeignGoodsKeyClick(Sender: TObject);
    procedure bbDocStateClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure bbEcommInfoClick(Sender: TObject);
    procedure cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbAssignToMeClick(Sender: TObject);
    procedure cxGridWZ_PAYMENT_METHODGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxPageControlBottomChange(Sender: TObject);
    procedure IBCDataSourceCreditDataChange(Sender: TObject; Field: TField);
    procedure bbCreditOnlyClick(Sender: TObject);
  private
    { Private declarations }
    fSEC_ViewOnly, fSEC_CanModify, fSEC_CanDelete: Boolean;
    // dreptul 1792: dosarul de credit (IDNP, buletin) e date personale
    fSEC_ViewCredit: Boolean;
    procedure UpdateCreditTab;
    procedure ShowCreditState;
    procedure ApplyCreditFilter;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure SaveMiaDeleteNote(const ADocID: Integer; const ANote: string);
    procedure CreateRashodnaiaNakladnaia;
    procedure CreateSciotNaOplatu;
    procedure CloseCurrentDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
    procedure CreateConfigurator;
    procedure SetupQtyFields;
    procedure AssignResponsibleOnOpen;
    procedure MiaPaymentClick(Sender: TObject);
    function IsCreditOrder(ARecord: TcxCustomGridRecord): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure CloneRecord; override;
    function GetPhoneNumber: string; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure SetupSecurityItems; override;
    // F9 / Shift+F9 din meniul principal (TSWNFrameManager)
    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure ShowEcommInformation(DocID: Integer);
  end;

implementation

uses
  SWNGoodsServicesUnit,
  DataModuleDB,
  DataModuleAdditions,
  SWNConst,
  SWNUtils,
  frmSelectGoodsToAddDialog,
  frmWebZakazDocDialog,
  SWNSecurity,
  SWNSecurityFlags,
  SWNDBErrors,
  SWNCommonDialogs,
  frmSelectPhoneNumberUnit,
  uDocumentStates,
  frmWebEcommInfoUnit,
  SWNMiaPaymentsDialogUnit;

{$R *.dfm}

{ Tframe24WebZakaz }

procedure Tframe24WebZakaz.bbAction_ConfiguratorClick(Sender: TObject);
begin
  CreateConfigurator;
end;

procedure Tframe24WebZakaz.bbAction_RashodClick(Sender: TObject);
begin
  CreateRashodnaiaNakladnaia;
end;

procedure Tframe24WebZakaz.bbAction_SceotClick(Sender: TObject);
begin
  CreateSciotNaOplatu;
end;

procedure Tframe24WebZakaz.bbAddGoodsClick(Sender: TObject);
begin
  ShowAddGoodsDialog;
end;

procedure Tframe24WebZakaz.bbAssignToMeClick(Sender: TObject);
begin
  dmdb.ibcquerydocs.edit;
  dmdb.ibcquerydocs.fieldbyname('responsible_userid').AsInteger := dmdb.CurrentUserID;
  dmdb.ibcquerydocs.fieldbyname('responsible_username').AsString := dmdb.CurrentUserFullName;
  dmdb.ibcquerydocs.post;
end;

procedure Tframe24WebZakaz.bbCancelCashbackClick(Sender: TObject);
begin
  dmdb.ExecuteQuery('execute procedure sp_cancel_cashback(:docid)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
end;

procedure Tframe24WebZakaz.bbDeleteGoodsClick(Sender: TObject);
begin
  DeleteSelectedGoods;
end;

procedure Tframe24WebZakaz.bbDocCloseClick(Sender: TObject);
begin
  CloseCurrentDocument;
end;

procedure Tframe24WebZakaz.bbDocStateClick(Sender: TObject);
var
  dialog: TfrmDocumentStatesDlg;
begin
  dialog := TfrmDocumentStatesDlg.Create(self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    // aici trebuie transmis statutul curent al documentului
    //
    // CurrentStatus:= ???
    dialog.ShowModal;
  finally
    dialog.Free;
  end;

end;

procedure Tframe24WebZakaz.bbForeignGoodsKeyClick(Sender: TObject);
begin
  inherited;
  TSWNCommonDialogs.GoodsForeignCode(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger);
end;

procedure Tframe24WebZakaz.bbGoodsBalanceClick(Sender: TObject);
begin
  inherited;
  TSWNCommonDialogs.GoodsInfoCardDialog(dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger, dmDB.IBCQueryJurnal.FieldByName
    ('GOODS_NAME').AsString);
end;

procedure Tframe24WebZakaz.bbModifyGoodsClick(Sender: TObject);
begin
  ShowModifyGoodsDialog;
end;

procedure Tframe24WebZakaz.CloneRecord;
var
  S: string;
  newDocID: integer;
begin
  S := dmDB.IBCQueryDocs.FieldByName('DOCID').AsString;
  if ShowAskDialog('Web Order', 'Creaza o copie a documentului Web-Order №' + S + '?') <> mrYes then
    Exit;

  if dmDB.CloneDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID) then
  begin

    dmdb.ExecuteQuery('EXECUTE PROCEDURE SP_CLOSE_WEBZAKAZ (:DOCID, :DTSC)', [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger,
      dmDB.CurrentUserID]);
    dmDB.RefreshDocs;
    dmDB.IBCQueryDocs.Locate('DOCID', newDocID, []);
    ShowInfoDialog('Web Order', 'Copie creata cu succes.'#13#10'Web Order №' + dmDB.IBCQueryDocs.FieldByName('DOCID').AsString);
  end;
end;

procedure Tframe24WebZakaz.CreateConfigurator;
var
  docID: integer;
begin
  if ShowAskDialog('Web Order', 'Crearea oferte din Web-Order?') = mrYes then
  begin
    // Daca Web-Order-ul nu are responsabil (NULL, 0 sau -1), cine creeaza oferta devine responsabil;
    // un responsabil existent ramine. SP_CREATE_CONFIGURATOR copiaza RESPONSIBLE_USERID de pe
    // Web-Order pe oferta, deci ajunge si acolo.
    try
      dmDB.ExecuteQuery('UPDATE TDB_DOCS SET RESPONSIBLE_USERID = :USERID' +
        ' WHERE DOCID = :DOCID AND DOCTYPEID = 134 AND COALESCE(RESPONSIBLE_USERID, -1) <= 0',
        [dmDB.CurrentUserID, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    except
      on E: Exception do
      begin
        ShowErrorDialog('Web-Order', 'Responsabilul nu a putut fi setat: ' + E.Message);
        Exit;
      end;
    end;
    // CreateConfiguratorDoc_DB inchide deja Web-Order-ul (SP_CLOSE_WEBZAKAZ in aceeasi tranzactie);
    // aici doar se reincarca lista, fara a doua inchidere.
    docID := dmDB.CreateConfiguratorDoc_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    if docID <> -1 then
      dmDB.FullRefresh;
  end;
end;

procedure Tframe24WebZakaz.CreateRashodnaiaNakladnaia;
var
  rashodDocID: integer;
begin
  if ShowAskDialog('Web-Order', 'Crearea documentului "Vinzare"?') = mrYes then
  begin
    rashodDocID := dmDB.CreateRashodnaiaNakladnaia_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    if rashodDocID <> -1 then
    begin
      CloseCurrentDocument;
      ShowInfoDialog('Web-Order', 'Document "Vinzare" creat cu succes!');
    end;
  end;
end;

procedure Tframe24WebZakaz.CreateSciotNaOplatu;
begin
     // Creare "Factura de plata"
  if ShowAskDialog('Web-Order"', 'Crearea documentului "PROFORMA"?') = mrYes then
  begin
    if dmDB.CreateProforma(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      CloseCurrentDocument;
      ShowInfoDialog('Web-Order', 'Documentul "PROFORMA" creata cu succes!');
    end;
  end;
end;

procedure Tframe24WebZakaz.cxGridComponentsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyGoods.Enabled then
  begin
    ShowModifyGoodsDialog;
    AHandled := True;
  end;
end;

procedure Tframe24WebZakaz.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe24WebZakaz.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridComponentsTable, Key, Shift);
  if ((Key = vkF9) and (ssShift in Shift)) then
  begin

  end;
end;

procedure Tframe24WebZakaz.cxGridComponentsTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  inherited;
  if VarIsNumeric(ARecord.Values[cxGridDBCol_STOCK_QTY.Index]) then
  begin
    if ARecord.Values[cxGridDBCol_STOCK_QTY.Index] > 0 then
      AStyle := dmAdditions.cxStyle_Bold;
  end;
end;

procedure Tframe24WebZakaz.cxGridDBCol_QTYGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[Sender.Index]) then
  begin
    if (ARecord.Values[cxGridComponents_UMID.Index] = 1) then
      AText := StringReplace(AText, QtyReplaceMask, '', []);
  end;
end;

procedure Tframe24WebZakaz.cxGridWZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe24WebZakaz.cxGridWZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
const
  cCreditRowColor        = $E6F7E6; // RGB(230, 247, 230)
  cCreditFocusedRowColor = $CDEBCD; // RGB(205, 235, 205)
var
  Credit: Boolean;
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridWZ_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridWZ_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
        // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridWZ_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridWZ_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end;
  end;

  // clientul a ales creditul: fundal verde foarte deschis, tipul platii ingrosat
  Credit := IsCreditOrder(AViewInfo.GridRecord);
  if Credit then
  begin
    if not AViewInfo.Selected then
      ACanvas.Brush.Color := cCreditRowColor;
    if AViewInfo.Item = cxGridWZ_PAYMENT_METHOD then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    if Credit then
      ACanvas.Brush.Color := cCreditFocusedRowColor
    else
      ACanvas.Brush.Color := $E8E8E8;
  end;
end;

// Credit = metoda de plata din deal (site: cos / "1 click") sau analitica de credit (Credit 0% / cu dobanda).
function Tframe24WebZakaz.IsCreditOrder(ARecord: TcxCustomGridRecord): Boolean;
begin
  Result := False;
  if ARecord = nil then
    Exit;
  Result := (Pos('CREDIT', UpperCase(VarToStr(ARecord.Values[cxGridWZ_PAYMENT_METHOD.Index]))) = 1) or
    (Pos('CREDIT', UpperCase(VarToStr(ARecord.Values[cxGridWZ_DTSC_NAME.Index]))) = 1);
end;

procedure Tframe24WebZakaz.cxGridWZ_PAYMENT_METHODGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
var
  Analytic: string;
begin
  if ARecord = nil then
    Exit;
  if IsCreditOrder(ARecord) then
  begin
    // analitica precizeaza tipul creditului (Credit 0% / Credit cu dobanda)
    Analytic := VarToStr(ARecord.Values[cxGridWZ_DTSC_NAME.Index]);
    if Pos('CREDIT', UpperCase(Analytic)) = 1 then
      AText := Analytic
    else
      AText := 'Credit';
  end
  else if SameText(AText, 'La primire') then
    // "1 click": plata integrala la primirea marfii
    AText := 'Integral, la primire';
end;

procedure Tframe24WebZakaz.cxGridWZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridWZTable, Key, Shift);
end;

procedure Tframe24WebZakaz.cxGridWZ_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridWZ_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridWZ_DATA.Index]);
end;

procedure Tframe24WebZakaz.SaveMiaDeleteNote(const ADocID: Integer; const ANote: string);
var
  dealID: Int64;
begin
  // nota ramine in deal (deal-ul supravietuieste stergerii documentului);
  // fara deal, in comentariile documentului
  dealID := FindDealByDoc(ADocID);
  if dealID > 0 then
    ExecDealSQL('UPDATE TDB_DEALS SET NOTE = SUBSTRING(COALESCE(NOTE || '' | '', '''') || :note FROM 1 FOR 1000) ' +
      'WHERE DEAL_ID = :dealid', ['note', ANote, 'dealid', dealID])
  else
    ExecDealSQL('EXECUTE PROCEDURE SP_ADD_DOC_COMMENTS(:docid, :prefix, :note)',
      ['docid', ADocID, 'prefix', 'MIA: ', 'note', ANote]);
end;

procedure Tframe24WebZakaz.DeleteRecord;
var
  docID: Integer;
  miaNote: string;
begin
  docID := dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger;
  // Comanda cu plata MIA neachitata: dialogul cere nota cu rezultatul apelului
  // catre client si tine loc de confirmare
  if not ConfirmDeleteUnpaidMiaOrder(Self, docID, miaNote) then
    Exit;
  if (miaNote <> '') or
    (ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_WebZakaz, [docID])) = mrYes) then
  begin
    if miaNote <> '' then
      SaveMiaDeleteNote(docID, miaNote);
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

procedure Tframe24WebZakaz.DeleteSelectedGoods;
var
  S: string;
begin
  S := #13#10 + dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString + ' ?';
  if ShowAskDialog('Web-Order', 'Sterge produsul:' + S) = mrYes then
  begin
    var delDocID := dmDB.IBCQueryJurnal.FieldByName('DOCID').AsInteger;
    var delGoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    try
      dmDB.IBCQueryJurnal.Delete;
      dmDB.IBCQueryJurnal.UpdateTransaction.Commit;
      // servicii adiacente legate de produsul sters
      DeleteLinkedServices(delDocID, delGoodsID);
      dmDB.IBCQueryDocs.Refresh;
    except
      dmDB.IBCQueryJurnal.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

function Tframe24WebZakaz.GetPhoneNumber;
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

procedure Tframe24WebZakaz.CloseCurrentDocument;
begin
  if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    dmDB.FullRefresh;
end;

procedure Tframe24WebZakaz.DoCloseDocument(const DocID: Integer);
begin
  // F9 din meniul principal: aceleasi conditii ca butonul "Inchide document"
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Inchide_document) then
    Exit;
  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1 then
    Exit;

  if DoCloseDocumentDB(DocID) then
    dmDB.FullRefresh;
end;

procedure Tframe24WebZakaz.DoOpenDocument(const DocID: Integer);
begin
  // Shift+F9 din meniul principal: redeschide un Web-Order inchis (SP_OPEN_WEBZAKAZ scoate bitul 10 din FLAGS).
  // Se foloseste acelasi drept ca la inchidere - nu exista un drept separat pentru deschidere.
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Inchide_document) then
    Exit;
  if dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger <> 1 then
    Exit;

  if ShowAskDialog('Web-Order', 'Doriti sa deschideti documentul?') <> mrYes then
    Exit;

  if DoOpenDocumentDB(DocID) then
    dmDB.FullRefresh;
end;

function Tframe24WebZakaz.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_WEBZAKAZ(:DOCID)';
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

function Tframe24WebZakaz.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_WEBZAKAZ(:DOCID, :DTSC)';

    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('DTSC').AsInteger := dmDB.CurrentUserID;

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

procedure Tframe24WebZakaz.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;
  IBCQueryCredit.Close;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridWZTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridWZTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe24WebZakaz.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridWZTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  AddDealColumns(cxGridWZTable);
  // plata MIA (Victoriabank): coloana cu starea si fereastra cu linkul de plata / rambursarea
  AddMiaColumn(cxGridWZTable);
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Ecomm_transactii) then
    AddMiaButton(dxBarManager, dxBarPopupMenu, MiaPaymentClick);
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridWZTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

  // dosarul de credit se citeste doar cand fila "Credit" e deschisa (are scanarile buletinului)
  cxPageControlBottom.ActivePage := tbsGoods;
  UpdateCreditTab;

     // 4. Selection update
  SelectionChanged;
end;

procedure Tframe24WebZakaz.cxPageControlBottomChange(Sender: TObject);
begin
  if csLoading in ComponentState then
    Exit;
  UpdateCreditTab;
end;

procedure Tframe24WebZakaz.UpdateCreditTab;
begin
  if fSEC_ViewCredit and (cxPageControlBottom.ActivePage = tbsCredit) then
  begin
    if not IBCQueryCredit.Active then
      IBCQueryCredit.Open;
  end
  else if IBCQueryCredit.Active then
    IBCQueryCredit.Close;
  ShowCreditState;
end;

procedure Tframe24WebZakaz.IBCDataSourceCreditDataChange(Sender: TObject; Field: TField);
begin
  // Field = nil: dosarul s-a reincarcat (alta comanda selectata)
  if Field = nil then
    ShowCreditState;
end;

// Comanda are dosar (rand in TWEB_CERERE_FINANTARE) -> datele lui; comanda pe credit fara dosar
// ("1 click" cu credit) -> operatorul trebuie sa ceara actele clientului.
procedure Tframe24WebZakaz.ShowCreditState;
var
  HasFile: Boolean;
begin
  if not IBCQueryCredit.Active then
    Exit;
  HasFile := not IBCQueryCredit.IsEmpty;
  sbCredit.Visible := HasFile;
  pnCreditState.Visible := not HasFile;
  if HasFile then
    Exit;
  if IsCreditOrder(cxGridWZTable.Controller.FocusedRecord) then
  begin
    lbCreditState.Font.Color := clRed;
    lbCreditState.Caption := 'Dosar de credit lipsa - cereti actele clientului (buletinul).';
  end
  else
  begin
    lbCreditState.Font.Color := clGrayText;
    lbCreditState.Caption := 'Comanda nu este pe credit - nu are dosar de credit.';
  end;
end;

procedure Tframe24WebZakaz.bbCreditOnlyClick(Sender: TObject);
begin
  ApplyCreditFilter;
end;

// Filtrul rapid "Doar comenzi pe credit": aceeasi regula ca IsCreditOrder - metoda de plata din
// deal sau analitica de plata incep cu "Credit" (Credit / Credit 0% / Credit cu dobanda).
procedure Tframe24WebZakaz.ApplyCreditFilter;
var
  Filter: TcxDataFilterCriteria;
begin
  Filter := cxGridWZTable.DataController.Filter;
  Filter.BeginUpdate;
  try
    Filter.Root.Clear;
    if bbCreditOnly.Down then
    begin
      Filter.Options := Filter.Options + [fcoCaseInsensitive];
      Filter.Root.BoolOperatorKind := fboOr;
      Filter.Root.AddItem(cxGridWZ_PAYMENT_METHOD, foLike, 'Credit%', 'Credit%');
      Filter.Root.AddItem(cxGridWZ_DTSC_NAME, foLike, 'Credit%', 'Credit%');
    end;
    Filter.Active := bbCreditOnly.Down;
  finally
    Filter.EndUpdate;
  end;
end;

procedure Tframe24WebZakaz.dxBarButton1Click(Sender: TObject);
begin
  dmDB.AddCallReminder(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString, '');
end;

procedure Tframe24WebZakaz.bbEcommInfoClick(Sender: TObject);
begin
  inherited;
  ShowEcommInformation(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

function Tframe24WebZakaz.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridComponentsTable.Site.Focused then
  begin
          // context from Jurnal: Cod + Denumire
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridWZTable.Site.Focused then
  begin
              // context from Docs
    if cxGridWZ_CT_NAME.Focused then
    begin
                   // Contraagent
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridWZ_DATA.Focused then
    begin
                       // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe24WebZakaz.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe24WebZakaz.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe24WebZakaz.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];
  if fSEC_CanModify then
    Result := Result + [fbtMODIFY];
  if fSEC_CanDelete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe24WebZakaz.GoodsSelectionChanged;
var
  fGoodsAdd, fGoodsEdit, fGoodsDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fGoodsAdd := False;
  fGoodsEdit := False;
  fGoodsDelete := False;

  if fSEC_CanModify and (cxGridWZTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    if not FLG_CLOSED then
    begin
      fGoodsAdd := True;
      if cxGridComponentsTable.DataController.RecNo > 0 then
      begin
        fGoodsEdit := True;
        fGoodsDelete := True;
      end;
    end;
  end;
     // goods
  bbAddGoods.Enabled := fGoodsAdd;
  bbModifyGoods.Enabled := fGoodsEdit;
  bbDeleteGoods.Enabled := fGoodsDelete;
end;

function Tframe24WebZakaz.InitFrameID: integer;
begin
  Result := 24; // WEB. Comanda Web

  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
end;

procedure Tframe24WebZakaz.AssignResponsibleOnOpen;
// Comanda web deschisa, neinchisa si fara responsabil (NULL, 0 sau -1) primeste utilizatorul
// curent - aceeasi regula ca la Cererea de finantare si la crearea ofertei.
// UPDATE-ul e conditionat pe RESPONSIBLE_USERID gol, deci daca doi operatori o
// deschid in acelasi timp ramane primul. Reincarcarea completa pastreaza in
// grila atat RESPONSIBLE_USERID, cat si RESPONSIBLE_USERNAME.
var
  DocID, Winner: Integer;
  Query: TIBCQuery;
begin
  if not dmDB.IBCQueryDocs.Active or dmDB.IBCQueryDocs.IsEmpty then
    Exit;
  if (dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1) or
    (dmDB.IBCQueryDocs.FieldByName('RESPONSIBLE_USERID').AsInteger > 0) then
    Exit;

  DocID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
  try
    dmDB.ExecuteQuery('UPDATE TDB_DOCS SET RESPONSIBLE_USERID = :USERID' +
      ' WHERE DOCID = :DOCID AND DOCTYPEID = 134 AND COALESCE(RESPONSIBLE_USERID, -1) <= 0',
      [dmDB.CurrentUserID, DocID]);

    // Cine a castigat: noi sau un coleg care a deschis-o cu o clipa inainte
    Winner := 0;
    Query := TIBCQuery.Create(nil);
    try
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := dmDB.IBCTrDefaultSelect;
      Query.SQL.Text := 'SELECT COALESCE(RESPONSIBLE_USERID, 0) FROM TDB_DOCS WHERE DOCID = :DOCID';
      Query.ParamByName('DOCID').AsInteger := DocID;
      Query.Open;
      if not Query.Eof then
        Winner := Query.Fields[0].AsInteger;
      Query.Close;
    finally
      Query.Free;
    end;

    if Winner > 0 then
    begin
      dmDB.IBCQueryDocs.DisableControls;
      try
        dmDB.IBCQueryDocs.Refresh;
        dmDB.IBCQueryDocs.Locate('DOCID', DocID, []);
      finally
        dmDB.IBCQueryDocs.EnableControls;
      end;
    end;
  except
    // preluarea automata nu are voie sa blocheze deschiderea comenzii
    if dmDB.IBCQueryDocs.State in [dsEdit, dsInsert] then
      dmDB.IBCQueryDocs.Cancel;
  end;
end;

procedure Tframe24WebZakaz.MiaPaymentClick(Sender: TObject);
begin
  if not dmDB.IBCQueryDocs.Active or dmDB.IBCQueryDocs.IsEmpty then
    Exit;
  ShowMiaPaymentDialog(Self, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, fSEC_CanModify);
  // fereastra a putut schimba starea (link nou, rambursare ceruta): coloana se reincarca
  AddMiaColumn(cxGridWZTable);
  cxGridWZTable.LayoutChanged;
  dmDB.IBCQueryDocComments.Refresh;
end;

procedure Tframe24WebZakaz.ModifyRecord;
var
  dialog: TfrmWebZakazDocDlg;
  ReadOnly: Boolean;
begin
  if not (fSEC_CanModify or fSEC_ViewOnly) then
    exit;

  if fSEC_CanModify then
    ReadOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    ReadOnly := fSEC_ViewOnly;

  // Primul operator care deschide comanda web o preia: devine responsabil.
  if fSEC_CanModify then
    AssignResponsibleOnOpen;

  dialog := TfrmWebZakazDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ReadOnly := ReadOnly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
  dmdb.IBCQueryDocComments.Refresh;
end;

procedure Tframe24WebZakaz.SelectionChanged;
var
  fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fDocClose, fRashod, fSceot: Boolean;
begin
  fDocEdit := False;
  fDocDelete := False;

  fDocClose := False;
  fRashod := False;
  fSceot := False;

  if cxGridWZTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fDocEdit := fSEC_CanModify and not FLG_CLOSED or fSEC_ViewOnly;
    fDocDelete := fSEC_CanDelete and not FLG_CLOSED;

    fDocClose := not FLG_CLOSED;
    fRashod := not FLG_CLOSED;
    fSceot := not FLG_CLOSED;
  end;
     // doc
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbDocClose.Enabled := fDocClose;
  bbAction_Rashod.Enabled := fRashod;
  bbAction_Sceot.Enabled := fSceot;

  GoodsSelectionChanged;
  // mesajul "dosar lipsa" depinde si de plata comenzii selectate, nu doar de dosar
  ShowCreditState;
end;

procedure Tframe24WebZakaz.SetupDefaultFocus;
begin
     // grid
  cxGridWZ.SetFocus;
     // columns
  cxGridWZ_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe24WebZakaz.SetupQtyFields;
begin
     // Cantitate
  TcxCalcEditProperties(cxGridDBCol_QTY.Properties).DisplayFormat := QtyDisplayFormat;
  cxGridDBCol_QTY.Summary.FooterFormat := QtyDisplayFormat;
end;

procedure Tframe24WebZakaz.SetupSecurityItems;
begin
  fSEC_ViewOnly := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_WЗ_Просмотр);
  fSEC_CanModify := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_WЗ_Редактировать);
  fSEC_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_WЗ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_WЗ_Создать_Расход) then
    bbAction_Rashod.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_WЗ_Создать_Счет_на_Оплату) then
    bbAction_Sceot.Visible := ivNever;

  // fila "Credit" (dosarul: IDNP, buletin) - doar cu dreptul "Cerere de finantare - vizualizare"
  fSEC_ViewCredit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Просмотр);
  tbsCredit.TabVisible := fSEC_ViewCredit;

  if dxBarPopupMenu.ItemLinks.VisibleItemCount <= 0 then
    cxGridWZTable.PopupMenu := nil
  else
    cxGridWZTable.PopupMenu := dxBarPopupMenu;

  bbAddGoods.Enabled := fSEC_CanModify;
  bbModifyGoods.Enabled := fSEC_CanModify;
  bbDeleteGoods.Enabled := fSEC_CanDelete;

  bbEcommInfo.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Ecomm_transactii),
    ivAlways, ivNever);
  bbCancelCashback.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Anulare_cashback),
    ivAlways, ivNever);

  bbDocClose.Visible := iif(SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_Web_Order_Inchide_document),
    ivAlways, ivNever);
end;

procedure Tframe24WebZakaz.ShowAddGoodsDialog;
var
  dialog: TfrmSelectGoodsToAddDlg;
begin
  dialog := TfrmSelectGoodsToAddDlg.Create(Self, dmDB.IBCQueryJurnal, dmDB.IBCDataSourceJurnal);
  try
    dialog.AddNewGoods := True;
    if dialog.ShowModal = mrOk then
    begin
      var addedDocID := dmDB.IBCQueryJurnal.FieldByName('DOCID').AsInteger;
      var addedGoodsID := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
      dmDB.IBCQueryDocs.Refresh;
      // servicii adiacente ale produsului adaugat (TS_GOODS_SERVICE)
      if OfferGoodsServices(addedDocID, addedGoodsID) then
        dmDB.IBCQueryDocs.Refresh;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe24WebZakaz.ShowEcommInformation(DocID: Integer);
var
  dialog: TfrmWebEcommInfoDialog;
begin
  dialog := TfrmWebEcommInfoDialog.Create(self, dmdb.IBCConnection);
  try
    dialog.DocID := dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe24WebZakaz.ShowModifyGoodsDialog;
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

procedure Tframe24WebZakaz.WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  GoodsSelectionChanged;
end;

procedure Tframe24WebZakaz.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


unit frame24WebZakazUnit;
{
  WEB. Web Заказ
  DocTypeID = 134
  Frame Index = 24
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
  dxUIAClasses;

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
    cxGridWZ_STATUT: TcxGridDBColumn;
    cxGridWZ_RESPONSIBLE_USERNAME: TcxGridDBColumn;
    bbAssignToMe: TdxBarButton;
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
  private
    { Private declarations }
    fSEC_ViewOnly, fSEC_CanModify, fSEC_CanDelete: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenGoodsFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure GoodsSelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
    procedure CreateRashodnaiaNakladnaia;
    procedure CreateSciotNaOplatu;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure CreateConfigurator;
    procedure SetupQtyFields;
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
  IBC,
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
  frmWebEcommInfoUnit;

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
  DoCloseDocument;
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
    docID := dmDB.CreateConfiguratorDoc_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
    if docID <> -1 then
    begin
      DoCloseDocument;
//      ShowInfoDialog('Web-Order', 'Oferta creata cu succes!');
    end;
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
      DoCloseDocument;
      ShowInfoDialog('Web-Order', 'Document "Vinzare" creat cu succes!');
    end;
  end;
end;

procedure Tframe24WebZakaz.CreateSciotNaOplatu;
begin
     // Создать "Счет на оплату"
  if ShowAskDialog('Web-Order"', 'Crearea documentului "PROFORMA"?') = mrYes then
  begin
    if dmDB.CreateSciotNaOplatu(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      DoCloseDocument;
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

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
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

procedure Tframe24WebZakaz.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_WebZakaz, [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))
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

procedure Tframe24WebZakaz.DoCloseDocument;
begin
//  if ShowAskDialog('Web-Order', 'Doriti sa inchideti documentul?') = mrYes then
//  begin
  if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    dmDB.FullRefresh;
//  end;
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
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridWZTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGoodsFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);

     // 4. Selection update
  SelectionChanged;
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
          // context from Jurnal: Код + Наименование
    Result.Context := ffGoods;
    Result.ValueInt := dmDB.IBCQueryJurnal.FieldByName('GOODSID').AsInteger;
    Result.ValueStr := dmDB.IBCQueryJurnal.FieldByName('GOODS_NAME').AsString;
  end
  else if cxGridWZTable.Site.Focused then
  begin
              // context from Docs
    if cxGridWZ_CT_NAME.Focused then
    begin
                   // Контрагент
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridWZ_DATA.Focused then
    begin
                       // Дата
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
  Result := 24; // WEB. Web Заказ

  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
  SetupQtyFields;
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

  dialog := TfrmWebZakazDocDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ReadOnly := False;
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
     // Кол-во
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


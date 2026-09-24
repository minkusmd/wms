unit frame51ZaiavkaCreditUnit;
{
  WEB. 1791 - Cerere de finantare
  DocTypeID = 1791
  Frame Index = 51
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseFrameUnit, SWNDataFiltering, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxLabel, cxCheckBox,
  cxImageComboBox, dxBar, cxClasses, cxSplitter, ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxControls,
  cxGridCustomView, cxGrid, System.UITypes, cxLookAndFeels,
  cxLookAndFeelPainters, cxCurrencyEdit, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxPCdxBarPopupMenu, cxPC, cxVGrid, cxDBVGrid, cxInplaceContainer, Vcl.StdCtrls,
  DBAccess, IBC, MemDS, cxNavigator, dxBarBuiltInMenu, System.ImageList, Vcl.ImgList,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList, dxDateRanges, dxScrollbarAnnotations,
  cxContainer, Vcl.Menus, cxButtons, cxImage, cxDBEdit, dxUIAClasses;

type
  Tframe51ZaiavkaCredit = class(TSWNBaseFrame)
    cxGridWZ: TcxGrid;
    cxGridWZTable: TcxGridDBTableView;
    cxGridWZ_DOCID: TcxGridDBColumn;
    cxGridWZ_DATA: TcxGridDBColumn;
    cxGridWZ_DTDEP_NAME: TcxGridDBColumn;
    cxGridWZ_CT_NAME: TcxGridDBColumn;
    cxGridWZ_SUMA: TcxGridDBColumn;
    cxGridWZ_CURRENCY_NAME: TcxGridDBColumn;
    cxGridWZ_VAT: TcxGridDBColumn;
    cxGridWZ_RATE: TcxGridDBColumn;
    cxGridWZ_PARENTDOCID: TcxGridDBColumn;
    cxGridWZ_FLG_ACNT: TcxGridDBColumn;
    cxGridWZ_RESPONSIBLE_USERNAME: TcxGridDBColumn;
    cxGridWZ_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridWZLevel: TcxGridLevel;
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
    dxBarManager: TdxBarManager;
    dxBarPopupMenu: TdxBarPopupMenu;
    cxSplitter1: TcxSplitter;
    cxGridPopupMenu1: TcxGridPopupMenu;
    bbDocClose: TdxBarButton;
    cxGridWZ_CT: TcxGridDBColumn;
    cxGridWZ_FLG_CLOSED: TcxGridDBColumn;
    cxPageControl: TcxPageControl;
    tbsGoods: TcxTabSheet;
    tbsClientInfo: TcxTabSheet;
    ScrollBox1: TScrollBox;
    pnInfoPerson: TPanel;
    Label2: TLabel;
    cxDBVerticalGrid1: TcxDBVerticalGrid;
    cxDBEditorRow1: TcxDBEditorRow;
    cxDBEditorRow2: TcxDBEditorRow;
    cxDBEditorRow3: TcxDBEditorRow;
    cxDBEditorRow4: TcxDBEditorRow;
    pnInfoScan: TPanel;
    Label5: TLabel;
    cxDBVerticalGrid5: TcxDBVerticalGrid;
    cxDBEditorRow21: TcxDBEditorRow;
    cxDBVerticalGrid5DBEditorRow1: TcxDBEditorRow;
    cxDBVerticalGrid5DBEditorRow2: TcxDBEditorRow;
    IBCQueryInfo: TIBCQuery;
    IBCDataSourceInfo: TIBCDataSource;
    bbCreateConfigurator: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridWZ_CREATED_DATE: TcxGridDBColumn;
    cxImageList1: TcxImageList;
    cxGridComponentsTable_FLG_FORCED_ADDON: TcxGridDBColumn;
    cxGridWZ_DTSC: TcxGridDBColumn;
    cxDBImage1: TcxDBImage;
    cxDBImage2: TcxDBImage;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    procedure cxGridWZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridWZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridWZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure bbCreateConfiguratorClick(Sender: TObject);
    procedure bbDocCloseClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridWZ_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    { Private declarations }
    fSEC_ViewOnly, fSEC_CanModify, fSEC_CanDelete: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure CreateConfigurator;
    procedure AssignResponsibleOnOpen;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNConst, SWNUtils,
  frmSelectGoodsToAddDialog, SWNSecurity, SWNSecurityFlags, SWNDBErrors,
  frmWebZaiavkaCreditDialog;

{$R *.dfm}

{ Tframe51ZaiavkaCredit }

procedure Tframe51ZaiavkaCredit.bbCreateConfiguratorClick(Sender: TObject);
begin
  CreateConfigurator;
end;

procedure Tframe51ZaiavkaCredit.bbDocCloseClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe51ZaiavkaCredit.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe51ZaiavkaCredit.CreateConfigurator;
var
  docID: integer;
begin
  if ShowAskDialog('Cerere de finantare', 'Doriti sa creati o oferta din cererea de finantare?') = mrYes then
  begin
    // Daca cererea nu are responsabil (NULL, 0 sau -1), cine creeaza oferta devine responsabil;
    // un responsabil existent ramine. SP_CREATE_CONFIGURATOR copiaza RESPONSIBLE_USERID de pe
    // cerere pe oferta, deci ajunge si acolo (aceeasi regula ca la Web-Order).
    try
      dmDB.ExecuteQuery('UPDATE TDB_DOCS SET RESPONSIBLE_USERID = :USERID' +
        ' WHERE DOCID = :DOCID AND DOCTYPEID = 1791 AND COALESCE(RESPONSIBLE_USERID, -1) <= 0',
        [dmDB.CurrentUserID, dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    except
      on E: Exception do
      begin
        ShowErrorDialog('Cerere de finantare', 'Responsabilul nu a putut fi setat: ' + E.Message);
        Exit;
      end;
    end;
    docID := dmDB.CreateConfiguratorDoc_DB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dmDB.CurrentUserID, dmDB.IBCQueryDocComments.FieldByName('COMMENTS').AsString);
    if docID <> -1 then
    begin
      dmDB.IBCQueryDocs.Refresh;
      ShowInfoDialog('Cerere de finantare', 'Oferta a fost creata cu succes!');
    end;
  end;
end;

procedure Tframe51ZaiavkaCredit.cxButton1Click(Sender: TObject);
begin
  inherited;
  if IBCQueryInfo.State in [dsEdit, dsInsert] then
  begin
    IBCQueryInfo.Post;
  end;

end;

procedure Tframe51ZaiavkaCredit.cxButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryInfo.Edit;
end;

procedure Tframe51ZaiavkaCredit.cxGridComponentsTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe51ZaiavkaCredit.cxGridComponentsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridComponentsTable, Key, Shift);
end;

procedure Tframe51ZaiavkaCredit.cxGridWZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe51ZaiavkaCredit.cxGridWZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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

procedure Tframe51ZaiavkaCredit.cxGridWZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridWZTable, Key, Shift);
end;

procedure Tframe51ZaiavkaCredit.cxGridWZ_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridWZ_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridWZ_DATA.Index]);
end;

procedure Tframe51ZaiavkaCredit.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_WebZaiavkaCredit, [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe51ZaiavkaCredit.DoCloseDocument;
begin
  if ShowAskDialog('Cerere de finantare', 'Doriti sa inchideti documentul?') = mrYes then
  begin
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.FullRefresh;
  end;
end;

function Tframe51ZaiavkaCredit.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_WEBZAIAVKACREDIT(:DOCID)';
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

procedure Tframe51ZaiavkaCredit.DoFrameHide;
begin
  cxGridWZTable.OnFocusedRecordChanged := nil;
  cxGridComponentsTable.OnFocusedRecordChanged := nil;

  cxGridWZTable.DataController.DataSource := nil;
  cxGridComponentsTable.DataController.DataSource := nil;

  dmDB.IBCQueryJurnal.Options.DetailDelay := 0;

  dmDB.IBCQueryJurnal.Active := False;
  IBCQueryInfo.Active := False;

  inherited;
end;

procedure Tframe51ZaiavkaCredit.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  cxPageControl.ActivePage := tbsGoods;

     // 1. Legam grid-urile de datasource-sele
  cxGridWZTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  cxGridComponentsTable.DataController.DataSource := dmDB.IBCDataSourceJurnal;

     // 2. Selection handlers
  cxGridWZTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;
  cxGridComponentsTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  IBCQueryInfo.Active := True;

     // 4. Selection update
  SelectionChanged;
end;

procedure Tframe51ZaiavkaCredit.dxBarPopupMenuPopup(Sender: TObject);
begin
  WhenPopupMenuPopup;
end;

function Tframe51ZaiavkaCredit.GetCurrentSearchContext: TSearchContextValue;
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

function Tframe51ZaiavkaCredit.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs, fedsJurnal];
end;

function Tframe51ZaiavkaCredit.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer, ffGoods];
end;

function Tframe51ZaiavkaCredit.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH, fbtDial];

  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Просмотр) then
    Result := Result + [fbtMODIFY];
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Редактировать) then
    Result := Result + [fbtMODIFY];
  if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Удалить) then
    Result := Result + [fbtDELETE];
end;

function Tframe51ZaiavkaCredit.InitFrameID: integer;
begin
  Result := 51; // WEB. Cerere de finantare
  dmDB.CreateGridImageColumnItems(cxGridDBCol_IMG);
end;

procedure Tframe51ZaiavkaCredit.AssignResponsibleOnOpen;
// Cererea de finantare deschisa, neinchisa si fara responsabil (NULL, 0 sau -1) primeste
// utilizatorul curent - la fel ca la Web-Order (Tframe24WebZakaz.AssignResponsibleOnOpen).
// UPDATE-ul e conditionat pe responsabil gol, deci daca doi operatori o deschid in acelasi
// timp ramine primul. Reincarcarea completa pastreaza in grila atit RESPONSIBLE_USERID,
// cit si RESPONSIBLE_USERNAME.
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
      ' WHERE DOCID = :DOCID AND DOCTYPEID = 1791 AND COALESCE(RESPONSIBLE_USERID, -1) <= 0',
      [dmDB.CurrentUserID, DocID]);

    // Cine a cistigat: noi sau un coleg care a deschis-o cu o clipa inainte
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
    // preluarea automata nu are voie sa blocheze deschiderea cererii
    if dmDB.IBCQueryDocs.State in [dsEdit, dsInsert] then
      dmDB.IBCQueryDocs.Cancel;
  end;
end;

procedure Tframe51ZaiavkaCredit.ModifyRecord;
var
  dialog: TfrmWebZaiavkaCreditDlg;
  canEdit, FLG_CLOSED: Boolean;
begin
  if not (fSEC_CanModify or fSEC_ViewOnly) then
    exit;

  // Primul operator care deschide cererea o preia: devine responsabil.
  if fSEC_CanModify then
    AssignResponsibleOnOpen;

  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  canEdit := fSEC_CanModify and (not FLG_CLOSED);

  dialog := TfrmWebZaiavkaCreditDlg.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := (not canEdit) and fSEC_ViewOnly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe51ZaiavkaCredit.RefreshData;
begin
  inherited;
  IBCQueryInfo.Refresh;
end;

procedure Tframe51ZaiavkaCredit.SelectionChanged;
var
  fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
begin
  fDocEdit := False;
  fDocDelete := False;

  if cxGridWZTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fDocEdit := fSEC_CanModify or fSEC_ViewOnly;
    fDocDelete := fSEC_CanDelete and ((not FLG_CLOSED) or SWNSecurityManager.UserIsPartOfGroup(1));
  end;
     // doc
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);
end;

procedure Tframe51ZaiavkaCredit.SetupDefaultFocus;
begin
     // grid
  cxGridWZ.SetFocus;
     // columns
  cxGridWZ_CT_NAME.Focused := True;
  cxGridDBCol_GOODS_NAME.Focused := True;
end;

procedure Tframe51ZaiavkaCredit.SetupSecurityItems;
begin
  fSEC_ViewOnly := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Просмотр);
  fSEC_CanModify := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Редактировать);
  fSEC_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_WEB_ЗНФ_Удалить);

  if not fSEC_CanModify then
    bbDocClose.Visible := ivNever;

  if dxBarPopupMenu.ItemLinks.VisibleItemCount <= 0 then
    cxGridPopupMenu1.PopupMenus[0].PopupMenu := nil;
end;

procedure Tframe51ZaiavkaCredit.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe51ZaiavkaCredit.WhenPopupMenuPopup;
var
  FLG_CLOSED: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
  bbDocClose.Enabled := not FLG_CLOSED;
  bbDocComments.Enabled := fSEC_CanModify;
//     bbAction_Rashod.Enabled:=Not FLG_CLOSED;
//     bbAction_Sceot.Enabled:=Not FLG_CLOSED;
end;

end.


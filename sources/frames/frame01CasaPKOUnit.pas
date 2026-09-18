unit frame01CasaPKOUnit;

// CASA. Dispozitie de incasare
// DocTypeID = 116
// Frame Index = 1

interface

uses SWNDealsUnit,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGridCustomView, cxGrid,
  StdCtrls, ExtCtrls, dxBar, cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit,
  cxLabel, dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe01CasaPKO = class(TSWNBaseFrame)
    dxBarManagerPKO: TdxBarManager;
    bbCustomerDebts: TdxBarButton;
    dxBarPopupMenuPKO: TdxBarPopupMenu;
    cxGridPopupMenuDoc: TcxGridPopupMenu;
    bbGotoParentDoc: TdxBarButton;
    bbDebtsNotify: TdxBarButton;
    bbPrintReceipe: TdxBarButton;
    bbDocComments: TdxBarButton;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    bbTransferMoneyToUser: TdxBarButton;
    cxGridCasaPKO: TcxGrid;
    cxGridCasaPKODBTable: TcxGridDBTableView;
    cxGridCasaPKO_FLG_CLOSED: TcxGridDBColumn;
    cxGridCasaPKODBTableDocID: TcxGridDBColumn;
    cxGridCasaPKO_DATA: TcxGridDBColumn;
    cxGridCasaPKO_CT_NAME: TcxGridDBColumn;
    cxGridCasaPKODBTableSuma: TcxGridDBColumn;
    cxGridCasaPKODBTableCurrencyName: TcxGridDBColumn;
    cxGridCasaPKODBTableVAT: TcxGridDBColumn;
    cxGridCasaPKODBTableRate: TcxGridDBColumn;
    cxGridCasaPKO_RATEUSD: TcxGridDBColumn;
    cxGridCasaPKODBTableParentDocID: TcxGridDBColumn;
    cxGridCasaPKO_FLG_ACNT: TcxGridDBColumn;
    cxGridCasaPKODBTableCreatedBy: TcxGridDBColumn;
    cxGridCasaPKO_CT: TcxGridDBColumn;
    cxGridCasaPKODB_SC2_NAME: TcxGridDBColumn;
    cxGridCasaPKOLevel: TcxGridLevel;
    procedure cxGridCasaPKODBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridCasaPKODBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarPopupMenuPKOPopup(Sender: TObject);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure bbDebtsNotifyClick(Sender: TObject);
    procedure bbPrintReceipeClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridCasaPKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCasaPKODBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure bbTransferMoneyToUserClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_OnlyOwnDocuments: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;
    procedure ShowCustomerDebts;
    procedure ShowCustomerDebtsNotifyDialog;
// TODO: ShowPrintReceiptDialog
//  procedure ShowPrintReceiptDialog;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
    procedure ShowMoneyTransferToUserDialog(const SourceDT, FirmaID, UserID, CurrencyID: Integer);
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, DateUtils, SWNValueStorageUnit, IBC,
  frmCustomerCurrentDebtsDialog, SWNSecurity, frmPKODocDialog, SWNSecurityFlags, frmCustomerNotifyDebtsDialog,
  frmMoneyTransferToUserDialog;

{$R *.dfm}

{ TSWNBaseFrame1 }

procedure Tframe01CasaPKO.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe01CasaPKO.bbCustomerDebtsClick(Sender: TObject);
begin
  ShowCustomerDebts;
end;

procedure Tframe01CasaPKO.bbDebtsNotifyClick(Sender: TObject);
begin
  ShowCustomerDebtsNotifyDialog;
end;

procedure Tframe01CasaPKO.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe01CasaPKO.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe01CasaPKO.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe01CasaPKO.bbPrintReceipeClick(Sender: TObject);
begin
//  if dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').isNull or (dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger = -1) then
//  begin
//    ShowErrorDialog('Eroare', 'Bonul din intrarea care e creata din rezerva!');
//    Exit;
//  end;
//
//  if (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency > 0) then
////   and (dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency > 0)
//  begin
//    if dmDB.CheckIfGoodsAreValidForReceipt(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
//      ShowPrintReceiptDialog
//    else
//      ShowErrorDialog('Eroare', 'Pentru unele produse nu este indicata denumirea din factura!');
//  end
//  else
//    ShowErrorDialog('Eroare', 'Nu poate fi tiparit bonul fiscal cu suma Zero!');
end;

procedure Tframe01CasaPKO.bbTransferMoneyToUserClick(Sender: TObject);
var
  targetFirma, targetUser, targetCurrency, SourceFirma: Integer;
begin
  targetFirma := -1;
  targetUser := -1;
  targetCurrency := -1;

//  if not IBCQueryUsers.FieldByName('DT').IsNull then
  targetFirma := dmDB.IBCQueryDocs.FieldByName('DT').AsInteger;

//  if not IBCQueryUsers.FieldByName('CURRENCYID').IsNull then
  targetCurrency := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;

//  if not IBCQueryUsers.FieldByName('UserID').IsNull then
  targetUser := 409; // Papana Vasile


  SourceFirma := dmDB.IBCQueryDocs.FieldByName('DT').AsInteger;

  ShowMoneyTransferToUserDialog(SourceFirma, targetFirma, targetUser, targetCurrency);
end;

procedure Tframe01CasaPKO.ShowMoneyTransferToUserDialog(const SourceDT, FirmaID, UserID, CurrencyID: Integer);
var
  dialog: TfrmMoneyTransferToUserDlg;
begin
  dialog := TfrmMoneyTransferToUserDlg.Create(Self);
  try
    dialog.SourceDT := SourceDT;
    dialog.TargetFirmaID := FirmaID;
    dialog.TargetUserID := UserID;
    dialog.TargetCurrencyID := CurrencyID;
    dialog.SUMA := dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat;
    dialog.FLG_ACNT := True;
    dialog.FLG_LIVRARE := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe01CasaPKO.CreateNewRecord;
var
  dialog: TfrmPKODocDlg;
begin
  dialog := TfrmPKODocDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe01CasaPKO.cxGridCasaPKODBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe01CasaPKO.cxGridCasaPKODBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridCasaPKO_FLG_ACNT.Index] = 1 then
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

procedure Tframe01CasaPKO.cxGridCasaPKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var
  AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridCasaPKO_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridCasaPKO_DATA.Index]);
end;

procedure Tframe01CasaPKO.cxGridCasaPKODBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnUtils.ProcessCommonKeys(self, cxGridCasaPKODBTable, Key, Shift);
end;

procedure Tframe01CasaPKO.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_КАССА_Приходный_кассовый_ордер, [dmDB.IBCQueryDocs.FieldByName
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

procedure Tframe01CasaPKO.DoCloseDocument;
var
  b: Boolean;
begin
  b := AppUserTempConfigStorage.BooleanValues.GetValue('PKO_CloseDocVerify');
  if b or (ShowAskDialogVerification('Oridin de incasare', 'Inchideti documentul?', 'Nu mai intreba', '', b) = mrYes) then
  begin
    if b then
      AppUserTempConfigStorage.BooleanValues.SetValue('PKO_CloseDocVerify', b);
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe01CasaPKO.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_PKO(:DOCID)';
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

procedure Tframe01CasaPKO.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridCasaPKODBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridCasaPKODBTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe01CasaPKO.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridCasaPKODBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;
  AddDealColumns(cxGridCasaPKODBTable);

     // 2. Selection handlers
  cxGridCasaPKODBTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

  customDataFilter := FrameDataFilterInfo.Clone;
  try
        // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    OpenExternalData(customDataFilter);
  finally
    customDataFilter.Free;
  end;

     // 4. Selection update
  SelectionChanged;
end;

procedure Tframe01CasaPKO.DoOpenDocument;
begin
  if ShowAskDialog('Ordin de incasare', 'Deschideti documentul?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe01CasaPKO.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_PKO(:DOCID)';
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

procedure Tframe01CasaPKO.dxBarPopupMenuPKOPopup(Sender: TObject);
begin
  WhenPopupMenuPopup;
end;

function Tframe01CasaPKO.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridCasaPKODBTable.Site.Focused then
  begin
          // context from Docs
    if cxGridCasaPKO_CT_NAME.Focused then
    begin
               // Platitor
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridCasaPKO_DATA.Focused then
    begin
               // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end;
  end
end;

function Tframe01CasaPKO.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe01CasaPKO.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe01CasaPKO.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe01CasaPKO.InitFrameID: integer;
begin
     // CASA. Dispozitie de incasare
  Result := 1;
end;

procedure Tframe01CasaPKO.ModifyRecord;
var
  dialog: TfrmPKODocDlg;
  readonly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    readonly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    readonly := fSECURITY_CanView;

  dialog := TfrmPKODocDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    dialog.CreateNewDocument := False;
    dialog.readonly := readonly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe01CasaPKO.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridCasaPKODBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe01CasaPKO.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridCasaPKODBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe01CasaPKO.SelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED, fCloseDoc, fOpenDoc: Boolean;
begin
  fDocNew := fSECURITY_CanNew; // New document
  fDocEdit := False;
  fDocDelete := False;
  fCloseDoc := False;
  fOpenDoc := False;
  if cxGridCasaPKODBTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete;
    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;
end;

procedure Tframe01CasaPKO.SetupDefaultFocus;
begin
     // grid
  cxGridCasaPKO.SetFocus;
     // columns
  cxGridCasaPKO_CT_NAME.Focused := True;
end;

procedure Tframe01CasaPKO.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Удалить);
  fSECURITY_OnlyOwnDocuments := not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Видеть_и_чужие_документы);
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_ПКО_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    bbDebtsNotify.Visible := ivNever;
    cxGridCasaPKO_FLG_ACNT.VisibleForCustomization := False;
    cxGridCasaPKO_FLG_ACNT.Visible := False;
  end;
end;

procedure Tframe01CasaPKO.ShowCustomerDebts;
var
  dialog: TfrmCustomerCurrentDebtsDlg;
begin
  dialog := TfrmCustomerCurrentDebtsDlg.Create(Self);
  try
    dialog.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe01CasaPKO.ShowCustomerDebtsNotifyDialog;
var
  dialog: TfrmCustomerNotifyDebtsDlg;
begin
  dialog := TfrmCustomerNotifyDebtsDlg.Create(Self);
  try
    dialog.CustomerID := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

// TODO: ShowPrintReceiptDialog
//procedure Tframe01CasaPKO.ShowPrintReceiptDialog;
//var
//dialog: TfrmReceiptPrintDlg;
//begin
//dialog := TfrmReceiptPrintDlg.Create(Self);
//try
//  dialog.RASHOD_DOCID := dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger;
//  dialog.PKO_DOCID := dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger;
//
//  dialog.PrintWithoutPrinter := True;
//  dialog.ShowModal;
//  if dialog.ReceiptPrinted then
//    dmDB.IBCQueryDocs.Refresh;
//finally
//  dialog.Free;
//end;
//end;

procedure Tframe01CasaPKO.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  customDataFilter := FrameDataFilterInfo.Clone;
  try
    customDataFilter.FilterByCurrentUser := fSECURITY_OnlyOwnDocuments;
    inherited WhenFilterDataChanged(customDataFilter);
  finally
    customDataFilter.Free;
  end;
end;

procedure Tframe01CasaPKO.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
  TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure Tframe01CasaPKO.WhenPopupMenuPopup;
begin
  bbCustomerDebts.Enabled := cxGridCasaPKODBTable.DataController.RecNo > 0;
  bbDebtsNotify.Enabled := bbCustomerDebts.Enabled;
  bbGotoParentDoc.Enabled := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

end.


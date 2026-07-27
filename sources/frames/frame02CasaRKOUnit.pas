unit frame02CasaRKOUnit;

// КАССА. Расходный кассовый ордер
// DocTypeID = 117
// Frame Index = 2

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
  SWNBaseFrameUnit, cxGraphics, DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, dxBar,
  cxGridPopupMenu, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe02CasaRKO = class(TSWNBaseFrame)
    cxGridCasaRKO: TcxGrid;
    cxGridCasaRKODBTable: TcxGridDBTableView;
    cxGridCasaRKODBTableDocID: TcxGridDBColumn;
    cxGridCasaRKO_DATA: TcxGridDBColumn;
    cxGridCasaRKO_CT_NAME: TcxGridDBColumn;
    cxGridCasaRKODBTableSuma: TcxGridDBColumn;
    cxGridCasaRKODBTableVAT: TcxGridDBColumn;
    cxGridCasaRKODBTableCurrencyName: TcxGridDBColumn;
    cxGridCasaRKODBTableRate: TcxGridDBColumn;
    cxGridCasaRKODBTableParentDocID: TcxGridDBColumn;
    cxGridCasaRKO_FLG_ACNT: TcxGridDBColumn;
    cxGridCasaRKODBTableCreatedBy: TcxGridDBColumn;
    cxGridCasaRKOLevel: TcxGridLevel;
    dxBarManagerRKO: TdxBarManager;
    dxBarPopupMenuRKO: TdxBarPopupMenu;
    bbCustomerDebts: TdxBarButton;
    cxGridCasaRKO_RATEUSD: TcxGridDBColumn;
    bbGotoParentDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridCasaRKO_CT: TcxGridDBColumn;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    cxGridCasaRKO_FLG_CLOSED: TcxGridDBColumn;
    cxGridCasaRKODB_SC2_NAME: TcxGridDBColumn;
    cxGridPopupMenu1: TcxGridPopupMenu;
    procedure cxGridCasaRKODBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridCasaRKODBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbGotoParentDocClick(Sender: TObject);
    procedure dxBarPopupMenuRKOPopup(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridCasaRKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText:
      string);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure cxGridCasaRKODBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    fSECURITY_CanView, fSECURITY_CanNew, fSECURITY_CanEdit, fSECURITY_CanDelete, fSECURITY_OnlyOwnDocuments: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure ShowCustomerDebts;
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
    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;
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
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, IBC, dateUtils, SWNValueStorageUnit,
  frmCustomerCurrentDebtsDialog, SWNSecurity, SWNSecurityFlags, frmRKODocDialog;

{$R *.dfm}

{ TTframeCasa02RKO }

procedure Tframe02CasaRKO.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe02CasaRKO.bbCustomerDebtsClick(Sender: TObject);
begin
  ShowCustomerDebts;
end;

procedure Tframe02CasaRKO.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe02CasaRKO.bbGotoParentDocClick(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe02CasaRKO.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe02CasaRKO.CreateNewRecord;
var
  casa: TfrmRKODocDlg;
begin
  casa := TfrmRKODocDlg.Create(Self);
  try
    casa.CreateNewDocument := True;
    casa.ShowModal;
  finally
    casa.Free;
  end;
end;

procedure Tframe02CasaRKO.cxGridCasaRKODBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  DoDocumentDoubleClick;
  AHandled := True;
end;

procedure Tframe02CasaRKO.cxGridCasaRKODBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridCasaRKO_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridCasaRKO_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridCasaRKO_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridCasaRKO_FLG_ACNT.Index] = 1 then
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

procedure Tframe02CasaRKO.cxGridCasaRKO_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridCasaRKO_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy HH:MM', ARecord.Values[cxGridCasaRKO_DATA.Index]);
end;

procedure Tframe02CasaRKO.cxGridCasaRKODBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridCasaRKODBTable, Key, Shift);
end;

procedure Tframe02CasaRKO.DeleteRecord;
var
  allowDelete: Boolean;
begin
      // verificam daca:
     // 1. cel care stege este si owneru
     // 2. se poate de sters documentul numai in ziua curenta
  if SWNSecurityManager.UserIsPartOfGroup(1) then
    allowDelete := True
  else
    allowDelete := SameDate(dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime, dmDB.GetServerCurrentTime) and (dmDB.IBCQueryDocs.FieldByName
      ('CREATED_BY').AsInteger = dmDB.CurrentUserID);
  if allowDelete then
  begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_КАССА_Расходный_кассовый_ордер, [dmDB.IBCQueryDocs.FieldByName
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
  end
  else
    ShowErrorDialog(cMSG_ACCESS_DENIED, cMSG_ACCESS_DENIED_MSG_CASSA);
end;

procedure Tframe02CasaRKO.DoCloseDocument;
var
  b: Boolean;
begin
  b := AppUserTempConfigStorage.BooleanValues.GetValue('RKO_CloseDocVerify');
  if b or (ShowAskDialogVerification('Закрыть документ', 'Вы хотите закрыть документ?', 'Больше не спрашивать', '', b) =
    mrYes) then
  begin
    if b then
      AppUserTempConfigStorage.BooleanValues.SetValue('RKO_CloseDocVerify', b);
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe02CasaRKO.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_RKO(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe02CasaRKO.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridCasaRKODBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridCasaRKODBTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe02CasaRKO.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridCasaRKODBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridCasaRKODBTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

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

procedure Tframe02CasaRKO.DoOpenDocument;
begin
  if ShowAskDialog('Открыть документ', 'Вы хотите открыть документ?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe02CasaRKO.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_RKO(:DOCID)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure Tframe02CasaRKO.dxBarPopupMenuRKOPopup(Sender: TObject);
begin
  bbGotoParentDoc.Enabled := not dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').IsNull;
  bbDocComments.Enabled := fSECURITY_CanEdit;
end;

function Tframe02CasaRKO.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridCasaRKODBTable.Site.Focused then
  begin
          // context from Docs
    if cxGridCasaRKO_CT_NAME.Focused then
    begin
               // Получатель
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridCasaRKO_DATA.Focused then
    begin
               // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe02CasaRKO.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe02CasaRKO.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe02CasaRKO.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSECURITY_CanNew then
    Result := Result + [fbtADD];
  if fSECURITY_CanEdit or fSECURITY_CanView then
    Result := Result + [fbtMODIFY];
  if fSECURITY_CanDelete then
    Result := Result + [fbtDELETE];
end;

function Tframe02CasaRKO.InitFrameID: integer;
begin
     // КАССА. Расходный кассовый ордер
  Result := 2;
end;

procedure Tframe02CasaRKO.ModifyRecord;
var
  casa: TfrmRKODocDlg;
  ReaOnly: Boolean;
begin
  if not (fSECURITY_CanEdit or fSECURITY_CanView) then
    Exit;

  if fSECURITY_CanEdit then
    ReaOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    ReaOnly := fSECURITY_CanView;

  casa := TfrmRKODocDlg.Create(Self);
  try
    casa.CreateNewDocument := False;
    casa.readonly := ReaOnly;
    casa.ShowModal;
  finally
    casa.Free;
  end;
end;

procedure Tframe02CasaRKO.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridCasaRKODBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe02CasaRKO.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridCasaRKODBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe02CasaRKO.SelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete, fHasItem: Boolean;
  FLG_CLOSED, fCloseDoc, fOpenDoc: Boolean;
begin
  fDocNew := fSECURITY_CanNew;
  fDocEdit := False;
  fDocDelete := False;
  fHasItem := False;
  fCloseDoc := False;
  fOpenDoc := False;

  if cxGridCasaRKODBTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := fSECURITY_CanEdit and not FLG_CLOSED or fSECURITY_CanView;
    fDocDelete := fSECURITY_CanDelete and not FLG_CLOSED;
    fCloseDoc := not FLG_CLOSED;
    fOpenDoc := FLG_CLOSED;
    fHasItem := True;
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbCloseDoc.Enabled := fCloseDoc;
  bbOpenDoc.Enabled := fOpenDoc;

     // local
  bbCustomerDebts.Enabled := fHasItem;
end;

procedure Tframe02CasaRKO.SetupDefaultFocus;
begin
     // grid
  cxGridCasaRKO.SetFocus;
     // columns
  cxGridCasaRKO_CT_NAME.Focused := True;
end;

procedure Tframe02CasaRKO.SetupSecurityItems;
begin
  fSECURITY_CanView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Просмотр);
  fSECURITY_CanNew := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Создать);
  fSECURITY_CanEdit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Изменить);
  fSECURITY_CanDelete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Удалить);
  fSECURITY_OnlyOwnDocuments := not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Видеть_и_чужие_документы);
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Закрыть_документ) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_КО_РКО_Открыть_документ) then
    bbOpenDoc.Visible := ivNever;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    cxGridCasaRKO_FLG_ACNT.VisibleForCustomization := False;
    cxGridCasaRKO_FLG_ACNT.Visible := False;
  end;
end;

procedure Tframe02CasaRKO.ShowCustomerDebts;
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

procedure Tframe02CasaRKO.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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

procedure Tframe02CasaRKO.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


unit frame21ZarplataUnit;
{
  ЗАРПЛАТА. Выдача зарплата
  DocTypeID = 118
  Frame Index = 21
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs,
  SWNDataFiltering, SWNBaseFrameUnit, cxGraphics,
  DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxGridPopupMenu, dxBar, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit, cxLabel,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxClasses, cxGridTableView, dxUIAClasses;

type
  Tframe21Zarplata = class(TSWNBaseFrame)
    cxGridZ: TcxGrid;
    cxGridZTable: TcxGridDBTableView;
    cxGridZ_DOCID: TcxGridDBColumn;
    cxGridZ_DATA: TcxGridDBColumn;
    cxGridZ_CT_NAME: TcxGridDBColumn;
    cxGridZ_SUMA: TcxGridDBColumn;
    cxGridZ_CURRENCY_NAME: TcxGridDBColumn;
    cxGridZ_VAT: TcxGridDBColumn;
    cxGridZ_FLG_ACNT: TcxGridDBColumn;
    cxGridZ_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridZLevel: TcxGridLevel;
    cxGridZ_RATE: TcxGridDBColumn;
    cxGridZ_RATEUSD: TcxGridDBColumn;
    cxGridZ_SC2_NAME: TcxGridDBColumn;
    cxGridZ_FLG_CLOSED: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    bbCloseDoc: TdxBarButton;
    bbOpenDoc: TdxBarButton;
    bbDocComments: TdxBarButton;
    dxBarButton1: TdxBarButton;
    cxGridZTable_CREATED_DATE: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    cxGridPopupMenu1: TcxGridPopupMenu;
    procedure cxGridZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridZ_DATAGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure cxGridZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarPopupMenu1Popup(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure bbCloseDocClick(Sender: TObject);
    procedure bbOpenDocClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure cxGridPopupMenu1Popup(ASenderMenu: TComponent; AHitTest: TcxCustomGridHitTest; X, Y:
      Integer; var AllowPopup: Boolean);
  private
    { Private declarations }
    fSEC_View, fSEC_New, fSEC_Edit, fSEC_Delete: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: Integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: Integer): Boolean;
  protected
    { Protected declarations }
    function InitFrameID: Integer; override;
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
  end;

implementation

uses
  DataModuleDB, frmZarplataDocDlg, IBC, SWNUtils, SWNDBErrors, SWNConst,
  dateUtils, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}
{ Tframe21Зарплата }

procedure Tframe21Zarplata.bbCloseDocClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe21Zarplata.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe21Zarplata.bbOpenDocClick(Sender: TObject);
begin
  DoOpenDocument;
end;

procedure Tframe21Zarplata.CreateNewRecord;
var
  dialog: TfrmZarplataDocDialog;
begin
  dialog := TfrmZarplataDocDialog.Create(Self);
  try
    dialog.CreateNewDocument := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe21Zarplata.cxGridPopupMenu1Popup(ASenderMenu: TComponent; AHitTest:
  TcxCustomGridHitTest; X, Y: Integer; var AllowPopup: Boolean);
begin
  inherited;
  AllowPopup := (cxGridZTable.DataController.RecNo > 0);
end;

procedure Tframe21Zarplata.cxGridZTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe21Zarplata.cxGridZTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
  TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridZ_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridZ_FLG_CLOSED.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridZ_FLG_ACNT.index] = 1 then
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

procedure Tframe21Zarplata.cxGridZTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridZTable, Key, Shift);
end;

procedure Tframe21Zarplata.cxGridZ_DATAGetDataText(Sender: TcxCustomGridTableItem; ARecordIndex:
  Integer; var AText: string);
begin
  if not VarIsNull(cxGridZTable.DataController.Values[ARecordIndex, cxGridZ_DATA.index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', cxGridZTable.DataController.Values[ARecordIndex, cxGridZ_DATA.index]);
end;

procedure Tframe21Zarplata.DeleteRecord;
begin
  // verificam daca:
  // 1. cel care modifica este si owneru
  // 2. se poate de modificat documentul numai in ziua curenta

  if //(SameDate(dmDB.IBCQueryDocs.FieldByName('CREATED_DATE').AsDateTime, dmDB.GetServerCurrentTime))and
  (dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID) then
  begin
    if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format('Sterge inregistrarea %d?', [dmDB.IBCQueryDocs.FieldByName
      ('DOCID').AsInteger])) = mrYes then
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

procedure Tframe21Zarplata.DoCloseDocument;
var
  b: Boolean;
begin
  b := AppUserTempConfigStorage.BooleanValues.GetValue('Zarplata21_CloseDocVerify');
  if b or (ShowAskDialogVerification('Inchide documentul', 'Doriti sa inchideti documentul?',
    'Nu mai intreba', '', b) = mrYes) then
  begin
    if b then
      AppUserTempConfigStorage.BooleanValues.SetValue('Zarplata21_CloseDocVerify', b);
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe21Zarplata.DoCloseDocumentDB(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_ZARPLATA21(:DOCID)';
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

procedure Tframe21Zarplata.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridZTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridZTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe21Zarplata.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
     // 1. Legam grid-urile de datasource-sele
  cxGridZTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridZTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  if SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) or SWNSecurityManager.UserIsPartOfGroup
    (cUserGroup_Director) then
    OpenExternalData(FrameDataFilterInfo)
  else
  begin
    customDataFilter := FrameDataFilterInfo.Clone;
    try
      customDataFilter.FilterByCurrentUser := True;
      OpenExternalData(customDataFilter);
    finally
      customDataFilter.Free;
    end;
  end;

  // send notofication to administrator of accessing Salary Frame
  dmDB.SendSWNMail(
    'sergiu@fantastic.md',
    'Registrul Casa | Salarii',
    'Utilizatorul: '+dmdb.CurrentUserFullName+' a accesat Registrul de casa | Salarii'#13#10 +
    'ip: '+dmdb.GetLocalIP);

  // 4. Selection update
  SelectionChanged;
end;

procedure Tframe21Zarplata.DoOpenDocument;
begin
  if ShowAskDialog('Deschide documentul', 'Doriti sa deschideti acest document?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe21Zarplata.DoOpenDocumentDB(const DocID: Integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_ZARPLATA21(:DOCID)';
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

procedure Tframe21Zarplata.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  dmDB.ShowCustomerDebts(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger);
end;

procedure Tframe21Zarplata.dxBarPopupMenu1Popup(Sender: TObject);
begin

  bbDocComments.Enabled := fSEC_Edit;

end;

function Tframe21Zarplata.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridZTable.Site.Focused then
  begin
          // context from Docs
    if cxGridZ_CT_NAME.Focused then
    begin
               // Получатель
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridZ_DATA.Focused then
    begin
                   // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end;
  end;
end;

function Tframe21Zarplata.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe21Zarplata.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe21Zarplata.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSEC_New then
    Result := Result + [fbtADD];
  if fSEC_Edit or fSEC_View then
    Result := Result + [fbtMODIFY];
  if fSEC_Delete then
    Result := Result + [fbtDELETE];
end;

function Tframe21Zarplata.InitFrameID: Integer;
begin
  Result := 21; // ЗАРПЛАТА. Выдача зарплата
end;

procedure Tframe21Zarplata.ModifyRecord;
var
  dialog: TfrmZarplataDocDialog;
  ReadOnly: Boolean;
begin
  if not (fSEC_View or fSEC_Edit) then
    Exit;

  if fSEC_Edit then
    ReadOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    ReadOnly := fSEC_View;

  dialog := TfrmZarplataDocDialog.Create(Self);
  try
    dialog.CreateNewDocument := False;
    dialog.ReadOnly := ReadOnly;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe21Zarplata.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridZTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe21Zarplata.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridZTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe21Zarplata.SelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fClose, fOpen: Boolean;
begin
  fDocNew := True; // New doc + Security
  fDocEdit := False;
  fDocDelete := False;
  fClose := False;
  fOpen := False;
  if cxGridZTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := (fSEC_Edit and not FLG_CLOSED) or fSEC_View; // Edit
    fDocDelete := fSEC_Delete and not FLG_CLOSED; // Delete

    fClose := not FLG_CLOSED;
    fOpen := FLG_CLOSED;
  end;
  // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  // popup
  bbCloseDoc.Enabled := fClose;
  bbOpenDoc.Enabled := fOpen;
end;

procedure Tframe21Zarplata.SetupDefaultFocus;
begin
     // focused grid
  cxGridZ.SetFocus;
     // set focused column
  cxGridZ_CT_NAME.Focused := True;
end;

procedure Tframe21Zarplata.SetupSecurityItems;
begin
  fSEC_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Просмотр);
  fSEC_New := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Создавать);
  fSEC_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Изменить);
  fSEC_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Закрыть) then
    bbCloseDoc.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ЗАРПЛАТА_ВЗ_Открыть) then
    bbOpenDoc.Visible := ivNever;
end;

procedure Tframe21Zarplata.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
var
  customDataFilter: TFrameDataFilteringInfo;
begin
//  24.07.2024 remove adminisrator from salary all records
  if SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Администратор) { or SWNSecurityManager.UserIsPartOfGroup
      (cUserGroup_Director)} then
    inherited WhenFilterDataChanged(FrameDataFilterInfo)
  else
  begin
    customDataFilter := FrameDataFilterInfo.Clone;
    try
      customDataFilter.FilterByCurrentUser := True;
      inherited WhenFilterDataChanged(customDataFilter);
    finally
      customDataFilter.Free;
    end;
  end;

  dmdb.SendSWNMail('sergiu@fantastic.md', 'user '+dmdb.CurrentUserFullName+' filtreaza tipoper salariu', DateTimeToStr(now));
end;

procedure Tframe21Zarplata.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


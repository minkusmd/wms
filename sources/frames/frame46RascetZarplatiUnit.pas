unit frame46RascetZarplatiUnit;
{
  SALARIU. Calcul Salariu
  DocTypeID = 1514
  Frame Index = 46
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  System.UITypes, Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxLabel, cxCheckBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxLookAndFeels, cxLookAndFeelPainters, dxBar, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxCurrencyEdit, cxSplitter, ExtCtrls, DBAccess, IBC, MemDS,
  cxImageComboBox, cxCalendar, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  dxDateRanges, dxScrollbarAnnotations, dxUIAClasses;

type
  Tframe46RascetZarplati = class(TSWNBaseFrame)
    cxGridZap: TcxGrid;
    cxGridZapTable: TcxGridDBTableView;
    cxGridZap_DOCID: TcxGridDBColumn;
    cxGridZap_DATA: TcxGridDBColumn;
    cxGridZap_DT_NAME: TcxGridDBColumn;
    cxGridZap_SUMA: TcxGridDBColumn;
    cxGridZap_VAT: TcxGridDBColumn;
    cxGridZap_CURRENCY_NAME: TcxGridDBColumn;
    cxGridZap_RATE: TcxGridDBColumn;
    cxGridZap_PARENTDOCID: TcxGridDBColumn;
    cxGridZap_FLG_ACNT: TcxGridDBColumn;
    cxGridZap_CREATED_BY_NAME: TcxGridDBColumn;
    cxGridZapLevel: TcxGridLevel;
    cxGridZap_FLG_CLOSED: TcxGridDBColumn;
    dxDocPopupMenu: TcxGridPopupMenu;
    dxBarManager: TdxBarManager;
    cxGridZap_RATEUSD: TcxGridDBColumn;
    cxGridZap_CT: TcxGridDBColumn;
    cxGridZap_DT: TcxGridDBColumn;
    bbDocClose: TdxBarButton;
    bbDocOpen: TdxBarButton;
    cxSplitter: TcxSplitter;
    pnBottom: TPanel;
    cxGridCustomers: TcxGrid;
    cxGridCustomereTable: TcxGridDBTableView;
    cxGridCustomere_CT: TcxGridDBColumn;
    cxGridCustomere_CT_NAME: TcxGridDBColumn;
    cxGridCustomere_SUMA_TOT: TcxGridDBColumn;
    cxGridCustomere_SUMA_AVANS: TcxGridDBColumn;
    cxGridCustomere_SUMA_SAL_BAZA: TcxGridDBColumn;
    cxGridCustomere_SUMA_FACTURI_ELIBERATE: TcxGridDBColumn;
    cxGridCustomere_SUMA_FACTURI_NEINCHISE: TcxGridDBColumn;
    cxGridCustomere_SUMA_BONUS: TcxGridDBColumn;
    cxGridCustomere_AMENZI: TcxGridDBColumn;
    cxGridCustomere_SUMA_CARD: TcxGridDBColumn;
    cxGridCustomere_ORE_LUCRATE: TcxGridDBColumn;
    cxGridCustomersLevel: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    IBCQueryEMP: TIBCQuery;
    IBCDataSourceEMP: TIBCDataSource;
    bbFillCustomers: TdxBarButton;
    bbAddCustomer: TdxBarButton;
    bbDeleetCustomer: TdxBarButton;
    cxGridCustomere_IMG: TcxGridDBColumn;
    bbModifyCustomer: TdxBarButton;
    bbCalcSalary: TdxBarButton;
    cxGridCustomere_SUMA_DATORII: TcxGridDBColumn;
    cxGridCustomere_COMMENTS: TcxGridDBColumn;
    bbCustomerTools: TdxBarSubItem;
    bbRecalcMissedHours: TdxBarButton;
    bbDocComments: TdxBarButton;
    cxGridZap_DTSC_NAME: TcxGridDBColumn;
    cxGridCustomereSUMA_PENALITATI: TcxGridDBColumn;
    cxGridCustomere_INVENT: TcxGridDBColumn;
    btnCopyGrid: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    cxGridCustomere_SUMA_CALCULATA: TcxGridDBColumn;
    cxGridCustomere_BONUS_WEB_DESCRIPTION: TcxGridDBColumn;
    cxGridCustomere_SUMA_IMPOZIT: TcxGridDBColumn;
    procedure cxGridZapTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridZapTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridZapTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbDocCloseClick(Sender: TObject);
    procedure bbDocOpenClick(Sender: TObject);
    procedure bbFillCustomersClick(Sender: TObject);
    procedure cxGridCustomereTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridCustomereTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbModifyCustomerClick(Sender: TObject);
    procedure bbDeleetCustomerClick(Sender: TObject);
    procedure bbAddCustomerClick(Sender: TObject);
    procedure bbCalcSalaryClick(Sender: TObject);
    procedure cxGridCustomereTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbRecalcMissedHoursClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridCustomereTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnCopyGridClick(Sender: TObject);
    procedure cxGridCustomere_SUMA_DATORIICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridZap_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridCustomere_AMENZIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridCustomere_SUMA_BONUSStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fSYS_Create, fSYS_Edit, fSYS_Delete, fSYS_View: Boolean;
    fSYS_RestrictedView: Boolean;
    procedure WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure DocumentSelectionChanged;
    procedure CustomersSelectionChanged;
    procedure DoCloseDocument;
    function DoCloseDocumentDB(const DocID: integer): Boolean;
    procedure DoOpenDocument;
    function DoOpenDocumentDB(const DocID: integer): Boolean;
    procedure DoFillCustomers;
    function DoFillCustomersDB(const DocID: integer): Boolean;
    procedure ShowNewCustomerDialog;
    procedure ShowModifyCustomerDialog;
    procedure DoDeleteCustomerRecord;
    procedure DoCalcSalary;
    function DoCalcSalaryDB(const DocID: integer): Boolean;
    function DoRecalcMissedHoursDB(const DocID: integer): Boolean;
    procedure OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
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
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SetupSecurityItems; override;
    procedure WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
  public
    { Public declarations }
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors,
  SWNValueStorageUnit, frmRascetZarplatiDocDialog, SWNSecurity, SWNSecurityFlags,
  frmRascetZarplatiCustomerDialog;

{$R *.dfm}

{ Tframe04BankPDNS }

procedure Tframe46RascetZarplati.bbAddCustomerClick(Sender: TObject);
begin
  ShowNewCustomerDialog;
end;

procedure Tframe46RascetZarplati.bbCalcSalaryClick(Sender: TObject);
begin
  DoCalcSalary;
end;

procedure Tframe46RascetZarplati.bbDeleetCustomerClick(Sender: TObject);
begin
  DoDeleteCustomerRecord;
end;

procedure Tframe46RascetZarplati.bbDocCloseClick(Sender: TObject);
begin
  DoCloseDocument;
end;

procedure Tframe46RascetZarplati.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe46RascetZarplati.bbDocOpenClick(Sender: TObject);
begin
  if SWNSecurityManager.LoggedUser.IsInAdminGroup then
    DoOpenDocument
  else
    ShowInfoDialog('SWN mesaj!', 'Eroare baza de date!');
end;

procedure Tframe46RascetZarplati.bbFillCustomersClick(Sender: TObject);
begin
  DoFillCustomers;
end;

procedure Tframe46RascetZarplati.bbModifyCustomerClick(Sender: TObject);
begin
  ShowModifyCustomerDialog;
end;

procedure Tframe46RascetZarplati.bbRecalcMissedHoursClick(Sender: TObject);
begin
  if ShowAskDialog('Recalcul ore omise', 'Doriti sa recalculati orele omise pentru toti utilizatorii?', 'Valorile curente vor fi pierdute.') = mrYes then
  begin
    if DoRecalcMissedHoursDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
      IBCQueryEMP.Refresh;
      ShowInfoDialog('Recalcul ore omise', 'Gata.');
    end;
  end;
end;

procedure Tframe46RascetZarplati.btnCopyGridClick(Sender: TObject);
begin
  inherited;
  cxGridCustomereTable.CopyToClipboard(true);
end;

procedure Tframe46RascetZarplati.CreateNewRecord;
var
  editor: TfrmRascetZarplatiDocDlg;
begin
  editor := TfrmRascetZarplatiDocDlg.Create(Self);
  try
    editor.CreateNewDocument := True;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe46RascetZarplati.CustomersSelectionChanged;
var
  fEdit, fDelete, fCalc, fReCalcMissHours: Boolean;
  FLG_CLOSED: Boolean;
begin
  fEdit := False;
  fDelete := False;
  fCalc := False;
  fReCalcMissHours := False;

  if dmDB.IBCQueryDocs.Active then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    fReCalcMissHours := not FLG_CLOSED and (cxGridCustomereTable.DataController.RecordCount > 0);
  end;

  if cxGridZapTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;
    if (not FLG_CLOSED) and (cxGridCustomereTable.DataController.RecNo > 0) then
    begin
      fEdit := True;
      fDelete := True;
      fCalc := True;
    end;
  end;

  bbModifyCustomer.Enabled := fEdit;
  bbDeleetCustomer.Enabled := fDelete;
  bbCalcSalary.Enabled := fCalc;
  bbRecalcMissedHours.Enabled := fReCalcMissHours;
end;

procedure Tframe46RascetZarplati.cxGridCustomereTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModifyCustomer.Enabled then
  begin
    bbModifyCustomerClick(bbModifyCustomer);
    AHandled := True;
  end;
end;

procedure Tframe46RascetZarplati.cxGridCustomereTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe46RascetZarplati.cxGridCustomereTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  CustomersSelectionChanged;
end;

procedure Tframe46RascetZarplati.cxGridCustomereTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridCustomereTable, Key, Shift);
end;

procedure Tframe46RascetZarplati.cxGridCustomere_AMENZIStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if not VarIsNull(ARecord.Values[cxGridCustomere_AMENZI.Index]) then
  begin
    if ARecord.Values[cxGridCustomere_AMENZI.Index] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;

end;

procedure Tframe46RascetZarplati.cxGridCustomere_SUMA_BONUSStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  if not VarIsNull(ARecord.Values[cxGridCustomere_SUMA_BONUS.Index]) then
  begin
    if ARecord.Values[cxGridCustomere_SUMA_BONUS.Index] > 0 then
      AStyle := dmAdditions.cxStyle_TextColorGreen;
  end;

end;

procedure Tframe46RascetZarplati.cxGridCustomere_SUMA_DATORIICustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not VarIsNull(AViewInfo.Value) then
  begin
    if AViewInfo.Value < 0 then
      ACanvas.Font.Color := clRed;
  end;
//  aDone := True;
end;

procedure Tframe46RascetZarplati.cxGridZapTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe46RascetZarplati.cxGridZapTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridZap_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridZap_FLG_CLOSED.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridZap_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe46RascetZarplati.cxGridZapTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(Self, cxGridZapTable, Key, Shift);
end;

procedure Tframe46RascetZarplati.cxGridZap_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridZap_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridZap_DATA.Index]);
end;

procedure Tframe46RascetZarplati.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_46, [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger])) = mrYes then
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

procedure Tframe46RascetZarplati.DoFillCustomers;
var
  s: string;
begin
  s := '';
  if cxGridCustomereTable.DataController.RecordCount > 0 then
    s := 'Inregistrarile curente vor fi sterse!';

  if ShowAskDialog('Adauga contraagenti', 'Doriti sa completati lista cu toti angajatii din firma documentului?', s) = mrYes then
  begin
    if DoFillCustomersDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
    begin
               //dmDB.IBCQueryDocs.Refresh;
      IBCQueryEMP.Refresh;
    end;
  end;
end;

function Tframe46RascetZarplati.DoFillCustomersDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_RASCETZARPLATI_FILL(:DOCID)';
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

procedure Tframe46RascetZarplati.DoFrameHide;
begin
     // inchidem datele interne
  IBCQueryEMP.Active := false;
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridZapTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridZapTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe46RascetZarplati.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridZapTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridZapTable.OnFocusedRecordChanged := WhenGridFocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele interne
  OpenData(FrameDataFilterInfo);

     // 4. Selection update
  DocumentSelectionChanged;
end;

procedure Tframe46RascetZarplati.DoOpenDocument;
begin
  if ShowAskDialog('Deschide documentul', 'Doriti sa deschideti documentul?') = mrYes then
  begin
    if DoOpenDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe46RascetZarplati.DoOpenDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := True;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_OPEN_RASCETZARPLATA(:DOCID)';
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

function Tframe46RascetZarplati.DoRecalcMissedHoursDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SMP_RECALC_SALARY_MISSHOURS(:DocID)';
    Query.ParamByName('DocID').AsInteger := DocID;

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

function Tframe46RascetZarplati.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridZapTable.Site.Focused then
  begin
          // context from Docs
    if cxGridZap_DATA.Focused then
    begin
               // Data
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe46RascetZarplati.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe46RascetZarplati.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate];
end;

function Tframe46RascetZarplati.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSYS_Create then
    Result := Result + [fbtADD];
  if fSYS_Edit or fSYS_View then
    Result := Result + [fbtMODIFY];
  if fSYS_Delete then
    Result := Result + [fbtDELETE];
end;

function Tframe46RascetZarplati.InitFrameID: integer;
begin
  Result := 46;  // SALARIU - Calcul Salariu
end;

procedure Tframe46RascetZarplati.ModifyRecord;
var
  editor: TfrmRascetZarplatiDocDlg;
  FLG_CLOSED: Boolean;
  canEdit: Boolean;
begin
  FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

  canEdit := fSYS_Edit and (not FLG_CLOSED);
  if not (canEdit or fSYS_View) then
    Exit;

  editor := TfrmRascetZarplatiDocDlg.Create(Self);
  try
    editor.CreateNewDocument := False;
    editor.readonly := (not canEdit) and fSYS_View;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe46RascetZarplati.OpenData(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  IBCQueryEMP.Close;

     // la Redvaris se poate de uitat conform drepturilor de acces. Pentru alte firme, trebuie sa fie numai dekit si Admin
  if not SWNSecurityManager.LoggedUser.IsInAdminGroup and not SWNSecurityManager.UserIsPartOfGroup(cUserGroup_Director) then
  begin
          // ascundem butoanele
    bbFillCustomers.Visible := ivNever;
    bbAddCustomer.Visible := ivNever;
    bbModifyCustomer.Visible := ivNever;
    bbDeleetCustomer.Visible := ivNever;
    bbCalcSalary.Visible := ivNever;
    bbCustomerTools.Visible := ivNever;
  end
  else
  begin
    bbFillCustomers.Visible := ivAlways;
    bbAddCustomer.Visible := ivAlways;
    bbModifyCustomer.Visible := ivAlways;
    bbDeleetCustomer.Visible := ivAlways;
    bbCalcSalary.Visible := ivAlways;
    bbCustomerTools.Visible := ivAlways;

    if fSYS_RestrictedView then
    begin
               // aratam numai inregistrarea userului curent
      IBCQueryEMP.FilterSQL := Format('CT=%d', [SWNSecurityManager.LoggedUser.CustomerID]);
    end;

    IBCQueryEMP.Open;
  end;
end;

procedure Tframe46RascetZarplati.WhenFilterDataChanged(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  IBCQueryEMP.Close;
  inherited;
  OpenData(FrameDataFilterInfo);
end;

procedure Tframe46RascetZarplati.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    pnBottom.Height := AppUserConfigStorage.IntValues.GetValue('BottomHeight', 300);
//    cxSplitter.State := TcxSplitterState(AppUserConfigStorage.IntValues.GetValue('SplitterState'));
    ReadGridColumnsSettings(cxGridZapTable);
    ReadGridColumnsSettings(cxGridCustomereTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe46RascetZarplati.RefreshData;
begin
  inherited;
  IBCQueryEMP.Refresh;
end;

procedure Tframe46RascetZarplati.SaveFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
//    AppUserConfigStorage.IntValues.SetValue('BottomHeight', pnBottom.Height);
//    AppUserConfigStorage.IntValues.SetValue('SplitterState', Ord(cxSplitter.State));
    SaveGridColumnsSettings(cxGridZapTable);
    SaveGridColumnsSettings(cxGridCustomereTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe46RascetZarplati.DoCalcSalary;
begin
  if ShowAskDialog('Calcul salariu', 'Doriti sa calculati salariul pentru toti?') = mrYes then
  begin
    if DoCalcSalaryDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      IBCQueryEMP.Refresh;
  end;
end;

function Tframe46RascetZarplati.DoCalcSalaryDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    if (dmdb.CurrentFirma = 10103) or (dmdb.CurrentFirma = 211667) then // in redvaris alt algoritm de calcul
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_CALC_SALARY10103(:DocID)'
    else
      Query.SQL.Text := 'EXECUTE PROCEDURE SPM_CALC_SALARY(:DocID)';

    Query.ParamByName('DocID').AsInteger := DocID;

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

procedure Tframe46RascetZarplati.DoCloseDocument;
begin
  if ShowAskDialog('Inchide documentul', 'Doriti sa inchideti documentul?') = mrYes then
  begin
    if DoCloseDocumentDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger) then
      dmDB.IBCQueryDocs.Refresh;
  end;
end;

function Tframe46RascetZarplati.DoCloseDocumentDB(const DocID: integer): Boolean;
var
  Query: TIBCQuery;
begin
  Result := True;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CLOSE_RASCETZARPLATA(:DOCID)';
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

procedure Tframe46RascetZarplati.DocumentSelectionChanged;
var
  fDocNew, fDocEdit, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fFillCustomers, fAddCustomer, fCtTools: Boolean;
  fDocClose, fDocOpen: Boolean;
begin
  fDocNew := fSYS_Create;
  fDocEdit := False;
  fDocDelete := False;
  fFillCustomers := False;
  fAddCustomer := False;
  fCtTools := False;
  fDocClose := False;
  fDocOpen := False;

  if cxGridZapTable.DataController.RecNo > 0 then
  begin
    FLG_CLOSED := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocEdit := (fSYS_Edit and not FLG_CLOSED) or fSYS_View;
    fDocDelete := fSYS_Delete and (not FLG_CLOSED);

    fFillCustomers := not FLG_CLOSED;
    fAddCustomer := not FLG_CLOSED;

    fCtTools := not FLG_CLOSED;

    fDocClose := not FLG_CLOSED;
    fDocOpen := FLG_CLOSED;
  end;

     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocEdit);
  ButtonStateChanged(fbtDELETE, fDocDelete);

  bbFillCustomers.Enabled := fFillCustomers;
  bbAddCustomer.Enabled := fAddCustomer;
  bbCustomerTools.Enabled := fCtTools;

     // popup
  bbDocClose.Enabled := fDocClose;
  bbDocOpen.Enabled := fDocOpen;

  CustomersSelectionChanged;
end;

procedure Tframe46RascetZarplati.DoDeleteCustomerRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteCustomer, Format(cMSG_DELETERECORD_DeleteCustomer46, [IBCQueryEMP.FieldByName('CT_NAME').AsString])) = mrYes then
  begin
    IBCQueryEMP.UpdateTransaction.StartTransaction;
    try
      IBCQueryEMP.Delete;
      IBCQueryEMP.UpdateTransaction.Commit;
      dmDB.IBCQueryDocs.Refresh;
    except
      on E: Exception do
      begin
        IBCQueryEMP.UpdateTransaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;
  end;
end;

procedure Tframe46RascetZarplati.SetupDefaultFocus;
begin
     // focused grid
  cxGridZap.SetFocus;
     // set focused column
  cxGridZap_DT_NAME.Focused := True;
  cxGridCustomere_CT_NAME.Focused := True;
end;

procedure Tframe46RascetZarplati.SetupSecurityItems;
begin
  fSYS_Create := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Ñîçäàòü);
  fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Ðåäàêòèðîâàòü);
  fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Óäàëèòü);
  fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Ïðîñìîòð);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Çàêðûòü_äîêóìåíò) then
    bbDocClose.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Îòêðûòü_çàêðûòûé_äîêóìåíò) then
    bbDocOpen.Visible := ivNever;

     // customers
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Çàïîëíèòü_ñïèñîê_êîíòðàãåíòàìè) then
    bbFillCustomers.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Äîáàâèòü_êîíòðàãåíòà) then
    bbAddCustomer.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Óäàëèòü_êîíòðàãåíòà) then
    bbDeleetCustomer.Visible := ivNever;

  // nu e voie de redactat daca documentul e inchis si nu se poate de deschis documentul

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Èçìåíèòü_äàííûå_êîíòðàãåíòà) then
    bbModifyCustomer.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_ÇÀÐÏËÀÒÀ_ÐÇ_Ðàñ÷èòàòü_çàðïëàòó) then
    bbCalcSalary.Visible := ivNever;

  dxBarManagerBar1.Visible := dxBarManagerBar1.ItemLinks.VisibleItemCount > 0;

//     if dxDocPopupMenu.ItemLinks.VisibleItemCount=0 then cxGridPopupMenu.PopupMenus[0].PopupMenu:=nil;

  fSYS_RestrictedView := fSYS_View and not (fSYS_Create or fSYS_Edit or fSYS_Delete);
  if fSYS_RestrictedView then
  begin
          // si ascundem alte colonite de date
    cxGridCustomere_SUMA_SAL_BAZA.Visible := False;
    cxGridCustomere_SUMA_SAL_BAZA.VisibleForCustomization := False;
    cxGridCustomere_SUMA_AVANS.Visible := False;
    cxGridCustomere_SUMA_AVANS.VisibleForCustomization := False;
    cxGridCustomere_SUMA_DATORII.Visible := False;
    cxGridCustomere_SUMA_DATORII.VisibleForCustomization := False;
    cxGridCustomere_SUMA_FACTURI_ELIBERATE.Visible := False;
    cxGridCustomere_SUMA_FACTURI_ELIBERATE.VisibleForCustomization := False;
    cxGridCustomere_SUMA_FACTURI_NEINCHISE.Visible := False;
    cxGridCustomere_SUMA_FACTURI_NEINCHISE.VisibleForCustomization := False;
    cxGridCustomere_SUMA_BONUS.Visible := False;
    cxGridCustomere_SUMA_BONUS.VisibleForCustomization := False;
    cxGridCustomere_AMENZI.Visible := False;
    cxGridCustomere_AMENZI.VisibleForCustomization := False;
    cxGridCustomere_SUMA_CARD.Visible := False;
    cxGridCustomere_SUMA_CARD.VisibleForCustomization := False;
    cxGridCustomere_ORE_LUCRATE.Visible := False;
    cxGridCustomere_ORE_LUCRATE.VisibleForCustomization := False;
    cxGridCustomere_COMMENTS.Visible := False;
    cxGridCustomere_COMMENTS.VisibleForCustomization := False;
  end;

end;

procedure Tframe46RascetZarplati.ShowModifyCustomerDialog;
var
  dialog: TfrmRascetZarplatiCustomerDlg;
begin
  dialog := TfrmRascetZarplatiCustomerDlg.Create(Self, IBCQueryEMP, IBCDataSourceEMP);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe46RascetZarplati.ShowNewCustomerDialog;
var
  dialog: TfrmRascetZarplatiCustomerDlg;
begin
  dialog := TfrmRascetZarplatiCustomerDlg.Create(Self, IBCQueryEMP, IBCDataSourceEMP);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure Tframe46RascetZarplati.WhenGridFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  DocumentSelectionChanged;
end;

end.


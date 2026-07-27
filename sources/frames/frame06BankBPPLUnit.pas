unit frame06BankBPPLUnit;

// БАНКОВСКИЕ ОПЕРАЦИИ. Банковские платежные поручения, Леи
// DocTypeID = 119
// Frame Index = 6

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
  cxGridLevel,
  cxGridCustomTableView,
  cxGridDBTableView,
  cxGridCustomView,
  cxGrid,
  dxBar,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  Vcl.ExtCtrls,
  DBAccess,
  IBC,
  Vcl.StdCtrls,
  cxGridDBBandedTableView,
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
  dxBarBuiltInMenu,
  MemDS,
  cxClasses,
  cxGridBandedTableView,
  cxGridTableView,
  dxUIAClasses;

type
  Tframe06BankBPPL = class(TSWNBaseFrame)
    cxGridBankBPPL: TcxGrid;
    cxGridBankBPPLDBTable: TcxGridDBTableView;
    cxGridBankBPPLDBTableDocID: TcxGridDBColumn;
    cxGridBankBPPL_DATA: TcxGridDBColumn;
    cxGridBankBPPLDBTableCtName: TcxGridDBColumn;
    cxGridBankBPPLDBTableSuma: TcxGridDBColumn;
    cxGridBankBPPLDBTableCurrencyName: TcxGridDBColumn;
    cxGridBankBPPLDBTableVAT: TcxGridDBColumn;
    cxGridBankBPPLDBTableRate: TcxGridDBColumn;
    cxGridBankBPPLDBTableParentDocID: TcxGridDBColumn;
    cxGridBankBPPL_FLG_ACNT: TcxGridDBColumn;
    cxGridBankBPPLDBTableCreatedBy: TcxGridDBColumn;
    cxGridBankBPPLLevel1: TcxGridLevel;
    cxGridBankBPPL_RATEUSD: TcxGridDBColumn;
    cxGridBankBPPL_FLG_CLOSED: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    cxGridPopupMenu: TcxGridPopupMenu;
    pmPopupMenuDoc: TdxBarPopupMenu;
    bbProvesti: TdxBarButton;
    bbCancelProvodca: TdxBarButton;
    bbCalcComission: TdxBarButton;
    cxGridBankBPPL_CT: TcxGridDBColumn;
    cxGridBankBPPL_DT: TcxGridDBColumn;
    bbDocComments: TdxBarButton;
    pnBottom: TPanel;
    IBCQueryCD: TIBCQuery;
    IBCDataSourceCD: TIBCDataSource;
    Label1: TLabel;
    cxGridCT_CDLevel: TcxGridLevel;
    cxGridCT_CD: TcxGrid;
    cxGridCT_CDTable: TcxGridDBBandedTableView;
    cxGridCT_CDTableColumn1: TcxGridDBBandedColumn;
    cxGridCT_CDTableColumn2: TcxGridDBBandedColumn;
    cxGridCT_CDTableColumn3: TcxGridDBBandedColumn;
    cxGridCT_CDTableColumn4: TcxGridDBBandedColumn;
    cxGridCT_CDTableColumn5: TcxGridDBBandedColumn;
    cxGridCT_CDTableColumn6: TcxGridDBBandedColumn;
    cxGridBankBPPL_SC2_NAME: TcxGridDBColumn;
    bbCustomerDebts: TdxBarButton;
    cxGridBankBPPL_CREATED_DATE: TcxGridDBColumn;
    cxGridBankBPPL_FLG_CHILD: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    procedure cxGridBankBPPLDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure pmPopupMenuDocPopup(Sender: TObject);
    procedure bbProvestiClick(Sender: TObject);
    procedure bbCancelProvodcaClick(Sender: TObject);
    procedure cxGridBankBPPLDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbCalcComissionClick(Sender: TObject);
    procedure bbDocCommentsClick(Sender: TObject);
    procedure cxGridBankBPPLDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridBankBPPL_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbCustomerDebtsClick(Sender: TObject);
    procedure cxGridBankBPPL_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridCT_CDTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
      TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    { Private declarations }
    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;
    procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure SelectionChanged;
    procedure WhenPopupMenuPopup;

    procedure DoAction_Provesti;
    procedure DoAction_CancelProvodca;

    procedure CalcCommision;
    procedure DoCalcComissionDB(const DocID: integer; const Percent: double);

    procedure ShowCustomerDebts;
  protected
    { Protected declarations }
    function InitFrameID: integer; override;

    function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;

    function GetFrameButtons: TFrameButtons; override;
    function GetFilterFields: TFrameFilterFields; override;

    procedure CreateNewRecord; override;
    procedure ModifyRecord; override;
    procedure DeleteRecord; override;
    procedure RefreshData; override;

    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;

    procedure SetupSecurityItems; override;

    procedure DoCloseDocument(const DocID: Integer); override;
    procedure DoOpenDocument(const DocID: Integer); override;

  public
    { Public declarations }
    procedure GetParamsListForReport(const ParamsList: TStringList); override;
    function GetParamValueForReport(const ParamName: string): Variant; override;
    procedure SetupDefaultFocus; override;
    function GetCurrentSearchContext: TSearchContextValue; override;
  end;

implementation

uses
  DataModuleDB,
  SWNUtils,
  SWNConst,
  DataModuleAdditions,
  SWNDBErrors,
  SWNValueStorageUnit,
  SWNSecurity,
  SWNSecurityFlags,
  frmBPPLComissionDialog,
  frmBPPLDialog,
  frmCustomerCurrentDebtsDialog;

{$R *.dfm}

{ Tframe06BankBPPL }

procedure Tframe06BankBPPL.bbCalcComissionClick(Sender: TObject);
begin
  CalcCommision;
end;

procedure Tframe06BankBPPL.bbCancelProvodcaClick(Sender: TObject);
begin
  DoOpenDocument(dmdb.ibcquerydocs.fieldbyname('DOCID').AsInteger);
end;

procedure Tframe06BankBPPL.bbCustomerDebtsClick(Sender: TObject);
begin
  ShowCustomerDebts;
end;

procedure Tframe06BankBPPL.bbDocCommentsClick(Sender: TObject);
begin
  ShowDocumentCommentsDialog(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe06BankBPPL.bbProvestiClick(Sender: TObject);
begin
  DoCloseDocument(dmdb.ibcqueryDocs.fieldbyname('DOCID').Asinteger);
end;

procedure Tframe06BankBPPL.CalcCommision;
var
  s: string;
  dialog: TfrmBPPLComissionDlg;
begin
  dialog := TfrmBPPLComissionDlg.Create(Self, dmDB.IBCQueryDocs, dmDB.IBCDataSourceDocs);
  try
    if dialog.ShowModal = mrOk then
    begin
      s := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      if ShowAskDialog('Comision transfer bancar', Format('Comision transefr bancar pentru "%s" in suma de %f(%f%%)?', [s,
        dialog.Suma, dialog.Percent])) = mrYes then
      begin
        DoCalcComissionDB(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger, dialog.Percent);
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tframe06BankBPPL.CreateNewRecord;
var
  editor: TfrmBPPLDlg;
begin
  editor := TfrmBPPLDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    editor.CreateNewDocument := True;
    editor.DocTypeID := dmdb.CurrentDocTypeID;
    editor.DataDoc := Now;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe06BankBPPL.cxGridBankBPPLDBTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = mbLeft then
  begin
    DoDocumentDoubleClick;
    AHandled := True;
  end;
end;

procedure Tframe06BankBPPL.cxGridBankBPPLDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if VarIsNumeric(AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CLOSED.index]) then
  begin
    if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CLOSED.index] = 0 then
    begin
      if not AViewInfo.Selected then
      begin
                    // Document prin contabilitate
        if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := dmAdditions.cxStyle_TextColorRed.TextColor;
      end;
    end
    else
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_ACNT.Index] = 1 then
          ACanvas.Font.Color := $008b8bc5
        else
          ACanvas.Font.Color := clGrayText;
      end;
    end;
    if AViewInfo.GridRecord.Values[cxGridBankBPPL_FLG_CHILD.index] = 1 then
    begin
      ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
      if not AViewInfo.Selected then
      begin
        ACanvas.Font.Color := clTeal;

      end;
    end;
  end;

     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
  begin
    ACanvas.Brush.Color := $E8E8E8;
  end;
end;

procedure Tframe06BankBPPL.cxGridBankBPPL_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridBankBPPL_CREATED_DATE.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBankBPPL_CREATED_DATE.Index]);
end;

procedure Tframe06BankBPPL.cxGridBankBPPL_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
  TcxCustomGridRecord; var AText: string);
begin
  if not VarIsNull(ARecord.Values[cxGridBankBPPL_DATA.Index]) then
    AText := FormatDateTime('dd.mm.yyyy hh:nn', ARecord.Values[cxGridBankBPPL_DATA.Index]);
end;

procedure Tframe06BankBPPL.cxGridCT_CDTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
  TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
  if AViewInfo.RecordViewInfo.Focused and not AViewInfo.Focused then
    ACanvas.Brush.Color := $E8E8E8;
end;

procedure Tframe06BankBPPL.cxGridBankBPPLDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridBankBPPLDBTable, Key, Shift);
end;

procedure Tframe06BankBPPL.DeleteRecord;
begin
  if ShowAskDialog(cMSG_DELETERECORD_DeleteDocument, Format(cMSG_DELETERECORD_БАНК_БППЛ, [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]))
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

procedure Tframe06BankBPPL.DoAction_CancelProvodca;
begin
//     if ShowAskDialog('Transfer bancar','Deschiderea documentului?')=mrYes then
//     begin
  if dmDB.CancelDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
    dmDB.IBCQueryDocs.Refresh;
//     end;
end;

procedure Tframe06BankBPPL.DoAction_Provesti;
begin
//     if ShowAskDialog('Transfer bancar','Inchide documentul?')=mrYes then
//     begin
  if dmDB.CreateDocumentProvodka(dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger) then
    dmDB.IBCQueryDocs.Refresh;
//     end;
end;

procedure Tframe06BankBPPL.DoCalcComissionDB(const DocID: integer; const Percent: double);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_BPPL_CREATE_COMISSION (:DOCID,:PERCENT)';
    Query.ParamByName('DOCID').AsInteger := DocID;
    Query.ParamByName('PERCENT').AsFloat := Percent;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
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

procedure Tframe06BankBPPL.DoCloseDocument(const DocID: Integer);
begin
  DoAction_Provesti;
end;

procedure Tframe06BankBPPL.DoFrameHide;
begin
     // inchidem datele locale
  IBCQueryCD.Active := False;

     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
  CloseExternalData;

     // 1. De scos la griduri event handles for OnFocusedRecordChanged
  cxGridBankBPPLDBTable.OnFocusedRecordChanged := nil;

     // 2. De deconectat sursele de date de la griduri
  cxGridBankBPPLDBTable.DataController.DataSource := nil;

  inherited;
end;

procedure Tframe06BankBPPL.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

     // 1. Legam grid-urile de datasource-sele
  cxGridBankBPPLDBTable.DataController.DataSource := dmDB.IBCDataSourceDocs;

     // 2. Selection handlers
  cxGridBankBPPLDBTable.OnFocusedRecordChanged := WhenDocGrid_FocusedRecordChanged;

     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
  OpenExternalData(FrameDataFilterInfo);
     // deschidem datele locale
  IBCQueryCD.Active := True;

     // 4. Selection update
  SelectionChanged;
end;

procedure Tframe06BankBPPL.DoOpenDocument(const DocID: Integer);
begin
  inherited;

end;

procedure Tframe06BankBPPL.dxBarButton1Click(Sender: TObject);
begin
  FindParentDocument(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
end;

procedure Tframe06BankBPPL.dxBarButton2Click(Sender: TObject);
var
  NewDocID: integer;
begin
  if dmDB.CloneDocumentDB(dmdb.IBCQueryDocs.FieldByName('DOCID').AsInteger, NewDocID, 0, 1) then
  begin
    dmDB.RefreshDocs;
    dmdb.IBCQueryDocs.Locate('DOCID', NewDocID, []);
    ModifyRecord;
  end;

end;

procedure Tframe06BankBPPL.pmPopupMenuDocPopup(Sender: TObject);
begin
  WhenPopupMenuPopup;
end;

function Tframe06BankBPPL.GetCurrentSearchContext: TSearchContextValue;
begin
  Result := inherited;

  if cxGridBankBPPLDBTable.Site.Focused then
  begin
          // context from Docs
    if cxGridBankBPPLDBTableCtName.Focused then
    begin
               // Получатель
      Result.Context := ffCustomer;
      Result.ValueInt := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;
      Result.ValueStr := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end
    else if cxGridBankBPPL_DATA.Focused then
    begin
               // Дата
      Result.Context := ffDate;
      Result.ValueDateTime := dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime;
    end
  end
end;

function Tframe06BankBPPL.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
  Result := [fedsDocs];
end;

function Tframe06BankBPPL.GetFilterFields: TFrameFilterFields;
begin
  Result := [ffDate, ffCustomer];
end;

function Tframe06BankBPPL.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
  if fSYS_Add then
    Result := Result + [fbtADD];
  if fSYS_Edit or fSYS_View then
    Result := Result + [fbtMODIFY];
  if fSYS_Delete then
    Result := Result + [fbtDELETE];
end;

procedure Tframe06BankBPPL.GetParamsListForReport(const ParamsList: TStringList);
begin
  ParamsList.Add('FAST_MONEY_TRANSFER');
end;

function Tframe06BankBPPL.GetParamValueForReport(const ParamName: string): Variant;
begin
  if ParamName = 'FAST_MONEY_TRANSFER' then
  begin
    if (dmDb.IBCQueryDocs.FieldByName('SUMA').AsFloat >= 100000) then
      Result := '1'
    else
      Result := '0';
  end;
end;

function Tframe06BankBPPL.InitFrameID: integer;
begin
     // БАНКОВСКИЕ ОПЕРАЦИИ. Банковские платежные поручения, Леи
  Result := 6;
end;

procedure Tframe06BankBPPL.ModifyRecord;
var
  editor: TfrmBPPLDlg;
  ReadOnly: Boolean;
begin
  if not (fSYS_Edit or fSYS_View) then
    Exit;

  if fSYS_Edit then
    ReadOnly := dmDB.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1
  else
    ReadOnly := fSYS_View;

  editor := TfrmBPPLDlg.Create(Self, dmdb.IBCQueryDocs, dmdb.IBCDataSourceDocs);
  try
    editor.CreateNewDocument := False;
    editor.ReadOnly := ReadOnly;
    editor.DocTypeID := dmdb.CurrentDocTypeID;
    editor.ShowModal;
  finally
    editor.Free;
  end;
end;

procedure Tframe06BankBPPL.WhenPopupMenuPopup;
begin
  bbDocComments.Enabled := fSYS_Edit;
end;

procedure Tframe06BankBPPL.ReadFrameStates;
begin
  AppUserConfigStorage.OpenSection(Self.Name);
  try
    ReadGridColumnsSettings(cxGridBankBPPLDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe06BankBPPL.RefreshData;
begin
  inherited;
  IBCQueryCD.Refresh;
end;

procedure Tframe06BankBPPL.SaveFrameStates;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    Exit;

  AppUserConfigStorage.OpenSection(Self.Name);
  try
    SaveGridColumnsSettings(cxGridBankBPPLDBTable);
  finally
    AppUserConfigStorage.CloseSection;
  end;
end;

procedure Tframe06BankBPPL.SelectionChanged;
var
  fDocNew, fDocModify, fDocDelete: Boolean;
  FLG_CLOSED: Boolean;
  fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin
  fDocNew := fSYS_Add;     // New Document + Security
  fDocModify := False;
  fDocDelete := False;

  fCloseDoc := False;
  fOpenDoc := False;
  fCalcComs := False;

  if (cxGridBankBPPLDBTable.DataController.RecNo > 0) then
  begin
    FLG_CLOSED := dmDb.IBCQueryDocs.FieldByName('FLG_CLOSED').AsInteger = 1;

    fDocModify := fSYS_Edit and not FLG_CLOSED or fSYS_View; // Edit Document
    fDocDelete := fSYS_Delete and not FLG_CLOSED; // Delete Document

    fCloseDoc := not FLG_CLOSED; // Провести
    fOpenDoc := FLG_CLOSED;      // Отменить проводку
    fCalcComs := FLG_CLOSED;     // Расчитать комиссион банковского платежа
  end;
     // doc
  ButtonStateChanged(fbtADD, fDocNew);
  ButtonStateChanged(fbtMODIFY, fDocModify);
  ButtonStateChanged(fbtDELETE, fDocDelete);

     // popup
  bbProvesti.Enabled := fCloseDoc;
  bbCancelProvodca.Enabled := fOpenDoc;
  bbCalcComission.Enabled := fCalcComs;

end;

procedure Tframe06BankBPPL.SetupDefaultFocus;
begin
     // grid
  cxGridBankBPPL.SetFocus;
     // columns
  cxGridBankBPPLDBTableCtName.Focused := True;
end;

procedure Tframe06BankBPPL.SetupSecurityItems;
begin
  fSYS_View := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Просмотр);
  fSYS_Add := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Создать);
  fSYS_Edit := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Изменить);
  fSYS_Delete := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Удалить);

  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Закрыть_документ) then
    bbProvesti.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Открыть_документ) then
    bbCancelProvodca.Visible := ivNever;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_БО_БППЛ_Расчитать_комиссион) then
    bbCalcComission.Visible := ivNever;

  if pmPopupMenuDoc.ItemLinks.VisibleItemCount = 0 then
    cxGridPopupMenu.PopupMenus[0].PopupMenu := nil;

  if SWNSecurityManager.IsPartialAccessMode then
  begin
    bbCustomerDebts.Visible := ivNever;
    cxGridBankBPPL_FLG_ACNT.Visible := False;
    cxGridBankBPPL_FLG_ACNT.VisibleForCustomization := False;
  end;
end;

procedure Tframe06BankBPPL.ShowCustomerDebts;
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

procedure Tframe06BankBPPL.WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

end.


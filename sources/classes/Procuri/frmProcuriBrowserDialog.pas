unit frmProcuriBrowserDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxStyles, DB, cxDBData,
  Menus, IBC, dxBar, StdCtrls, cxButtons, cxLabel, Buttons,
  ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridDBTableView, cxGrid, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxCheckBox, cxContainer, DBAccess, MemDS, cxClasses, cxGridTableView, cxGridCustomView;

type
  TfrmProcuriBrowserDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridProcuraTable: TcxGridDBTableView;
    cxGridProcuraLevel: TcxGridLevel;
    cxGridProcura: TcxGrid;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbNewProcura: TdxBarButton;
    bbEditProcura: TdxBarButton;
    bbDeleteProcura: TdxBarButton;
    cxGridProcuraTable_CUSTOMER_NAME: TcxGridDBColumn;
    cxGridProcuraTable_DELEGAT: TcxGridDBColumn;
    cxGridProcuraTable_PROCURA_NO: TcxGridDBColumn;
    cxGridProcuraTable_DATA_START: TcxGridDBColumn;
    cxGridProcuraTable_DATA_END: TcxGridDBColumn;
    cxGridProcuraTable_FLG_EXPIRED: TcxGridDBColumn;
    IBCQueryPROCURA: TIBCQuery;
    IBCDataSourcePROCURA: TIBCDataSource;
    IBCTrPROCURAUpdate: TIBCTransaction;
    cxGridProcuraTable_PROCURAID: TcxGridDBColumn;
    pnMenus: TPanel;
    pnFilter: TPanel;
    cxLabel1: TcxLabel;
    lbCustomerTitle: TcxLabel;
    pnBottom: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    bbShowLast30Days: TdxBarButton;
    cxGridProcuraTable_CREATED_BY_NAME: TcxGridDBColumn;
    bbSearch: TdxBarButton;
    sbShowAll: TSpeedButton;
    procedure cxGridProcuraTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewProcuraClick(Sender: TObject);
    procedure bbEditProcuraClick(Sender: TObject);
    procedure bbDeleteProcuraClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxGridProcuraTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure bbShowLast30DaysClick(Sender: TObject);
    procedure bbSearchClick(Sender: TObject);
    procedure cxGridProcuraTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbShowAllClick(Sender: TObject);
    procedure cxGridProcuraTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    FProcuraID: integer;
    FAllowSelect: Boolean;
    fProcuraDelegat: String;
    fCustomerIDGroup: integer;
    fProcuraNo: String;
    fInSearch: Boolean;
    procedure SetAllowSelect(const Value: Boolean);
    procedure SetProcuraID(const Value: integer);

    procedure SelectionChanged;

    procedure OpenData;

    procedure ShowAddNewProcuraDialog;
    procedure ShowModifyProcuraDialog;
    procedure DeleteSelectedProcura;

    procedure ShowSearchDialog;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property AllowSelect: Boolean read FAllowSelect write SetAllowSelect;
    property ProcuraID: integer read FProcuraID write SetProcuraID;
    property ProcuraDelegat: String read fProcuraDelegat;
    property ProcuraNo: String read fProcuraNo;
    property CustomerIDGroup: integer read fCustomerIDGroup write fCustomerIDGroup;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmProcuriEditDialog, SWNUtils, SWNSecurityFlags, SWNSearchUnit;

{$R *.dfm}
{ TfrmProcuriBrowserDlg }

procedure TfrmProcuriBrowserDlg.bbDeleteProcuraClick(Sender: TObject);
begin
  DeleteSelectedProcura;
end;

procedure TfrmProcuriBrowserDlg.bbEditProcuraClick(Sender: TObject);
begin
  ShowModifyProcuraDialog;
end;

procedure TfrmProcuriBrowserDlg.bbNewProcuraClick(Sender: TObject);
begin
  ShowAddNewProcuraDialog;
end;

procedure TfrmProcuriBrowserDlg.bbShowLast30DaysClick(Sender: TObject);
begin
  OpenData;
end;

procedure TfrmProcuriBrowserDlg.btnOkClick(Sender: TObject);
begin
  if cxGridProcuraTable.DataController.RecNo > 0 then
  begin
    FProcuraID := IBCQueryPROCURA.FieldByName('PROCURAID').AsInteger;
    fProcuraDelegat := IBCQueryPROCURA.FieldByName('DELEGAT').AsString;
    fProcuraNo := IBCQueryPROCURA.FieldByName('PROCURA_NO').AsString;

    ModalResult := mrOk;
  end;
end;

procedure TfrmProcuriBrowserDlg.cxGridProcuraTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if FAllowSelect and btnOk.Visible and btnOk.Enabled then
  begin
    btnOkClick(btnOk);
    AHandled := True;
  end
  else if bbEditProcura.Enabled and (bbEditProcura.Visible = ivAlways) then
  begin
    bbEditProcuraClick(bbEditProcura);
    AHandled := True;
  end;
end;

procedure TfrmProcuriBrowserDlg.cxGridProcuraTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmProcuriBrowserDlg.cxGridProcuraTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 8) and fInSearch and (Shift = []) then
  begin
    fInSearch := False;
    OpenData;
  end;
end;

procedure TfrmProcuriBrowserDlg.cxGridProcuraTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridProcuraTable_FLG_EXPIRED.Index] = 1 then
    AStyle := dmAdditions.cxStyle_BackgroundRED;

end;

procedure TfrmProcuriBrowserDlg.DeleteSelectedProcura;
begin
  if ShowAskDialog('Stergere Procura', 'Doriti sa stergeti procura pe numele "' + IBCQueryPROCURA.FieldByName('DELEGAT').AsString +
    '"?') = mrYes then
  begin
    try
      IBCQueryPROCURA.Delete;
      IBCQueryPROCURA.UpdateTransaction.Commit;
    except
      IBCQueryPROCURA.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmProcuriBrowserDlg.bbSearchClick(Sender: TObject);
begin
  ShowSearchDialog;
end;

procedure TfrmProcuriBrowserDlg.FormCreate(Sender: TObject);
begin
  FAllowSelect := False;
  FProcuraID := -1;
  fProcuraDelegat := '';
  fCustomerIDGroup := -1;
  pnFilter.Visible := False;
end;

procedure TfrmProcuriBrowserDlg.LoadStates;
begin
  // AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmProcuriBrowserDlg.OpenData;
var
  S: String;
begin
  IBCQueryPROCURA.Close;

  if fInSearch then
    S := IBCQueryPROCURA.FilterSQL
  else
    S := '';

  if (bbShowLast30Days.Down) then
    AddConditionToWHERE(S, '(CURRENT_DATE-DATA_START)<30');
  if (fCustomerIDGroup <> -1) then
    AddConditionToWHERE(S, 'CUSTOMERID=' + IntToStr(fCustomerIDGroup));
  IBCQueryPROCURA.FilterSQL := S;
  // setup params

  // open data
  IBCQueryPROCURA.Open;
  fInSearch := False;

  if FProcuraID <> -1 then
  begin
    IBCQueryPROCURA.Locate('PROCURAID', FProcuraID, []);
    FProcuraID := -1;
  end;

  SelectionChanged;
end;

procedure TfrmProcuriBrowserDlg.Prepare;
begin
  SetupSecurityItems;

  if Not FAllowSelect then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := 'Inchide';
  end;

  if fCustomerIDGroup <> -1 then
  begin
    lbCustomerTitle.Caption := dmDB.GetCustomerDisplayName(fCustomerIDGroup);
    pnFilter.Visible := True;
    bbSearch.Visible := ivNever;
  end;

  OpenData;

  cxGridProcuraTable_PROCURA_NO.Focused := True;

  pnMenus.AutoSize := True;
end;

procedure TfrmProcuriBrowserDlg.SaveStates;
begin
  // AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmProcuriBrowserDlg.sbShowAllClick(Sender: TObject);
begin
  fCustomerIDGroup := -1;
  pnFilter.Visible := False;
  OpenData;
end;

procedure TfrmProcuriBrowserDlg.SelectionChanged;
var
  fNew, fEdit, fDelete, fSelect: Boolean;
begin
  fNew := True; // New Procura + Security
  fEdit := False;
  fDelete := False;

  fSelect := False;

  if cxGridProcuraTable.DataController.RecNo > 0 then
  begin
    fEdit := True; // Edit Procura + Security
    fDelete := True; // Delete Procura + Security
    fSelect := True;
  end;
  bbNewProcura.Enabled := fNew;
  bbEditProcura.Enabled := fEdit;
  bbDeleteProcura.Enabled := fDelete;

  btnOk.Enabled := fSelect;
end;

procedure TfrmProcuriBrowserDlg.SetAllowSelect(const Value: Boolean);
begin
  FAllowSelect := Value;
end;

procedure TfrmProcuriBrowserDlg.SetProcuraID(const Value: integer);
begin
  FProcuraID := Value;
end;

procedure TfrmProcuriBrowserDlg.SetupSecurityItems;
begin
  if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Доверенности_Создать) then
    bbNewProcura.Visible := ivNever;
  if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Доверенности_Редактировать) then
    bbEditProcura.Visible := ivNever;
  if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Доверенности_Удалить) then
    bbDeleteProcura.Visible := ivNever;
end;

procedure TfrmProcuriBrowserDlg.ShowAddNewProcuraDialog;
var
  dialog: TfrmProcuriEditDlg;
begin
  dialog := TfrmProcuriEditDlg.Create(Self, IBCQueryPROCURA, IBCDataSourcePROCURA);
  try
    if (fCustomerIDGroup <> -1) then
      dialog.RequiredCustomerID := fCustomerIDGroup;
    dialog.CreateNewProcura := True;
    if dialog.ShowModal = mrOk then
    begin
      if (fCustomerIDGroup <> -1) then
      begin
        if IBCQueryPROCURA.FieldByName('CUSTOMERID').AsInteger <> fCustomerIDGroup then
        begin
          fCustomerIDGroup := -1;
          pnFilter.Visible := False;
          FProcuraID := IBCQueryPROCURA.FieldByName('PROCURAID').AsInteger;
          OpenData;
        end;
      end;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmProcuriBrowserDlg.ShowModifyProcuraDialog;
var
  dialog: TfrmProcuriEditDlg;
begin
  dialog := TfrmProcuriEditDlg.Create(Self, IBCQueryPROCURA, IBCDataSourcePROCURA);
  try
    dialog.CreateNewProcura := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;

end;

procedure TfrmProcuriBrowserDlg.ShowSearchDialog;
var
  search: TSWNSearchDialog;
  i: integer;
  SC: TSearchCriteria;
  cond: String;
begin
  search := TSWNSearchDialog.Create(Self);
  try
    if search.GetSearchCritera(stProcuri) then
    begin
      cond := '';
      for i := 0 to search.SearchCriteriasCount - 1 do
      begin
        SC := search.SearchCriterias[i];
        case SC.SearchField of
          sfID:
            AddConditionToWHERE(cond, 'upper(PROCURA_NO) like' + PrepareTextForLIKE(SC.SearchText));
          sfPersoanaDelegata:
            AddConditionToWHERE(cond, 'upper(DELEGAT) like ' + PrepareTextForLIKE(SC.SearchText));

          sfName:
            AddConditionToWHERE(cond, 'upper(CUSTOMER_NAME) like ' + PrepareTextForLIKE(SC.SearchText));

        end;
      end;
      if cond <> '' then
      begin
        fInSearch := True;
        bbShowLast30Days.Down := False;
        IBCQueryPROCURA.Close;
        IBCQueryPROCURA.FilterSQL := cond;
        IBCQueryPROCURA.Active := True;
      end;
    end;
  finally
    search.Free;
  end;
end;

end.

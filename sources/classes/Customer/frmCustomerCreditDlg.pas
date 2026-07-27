unit frmCustomerCreditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle,
  Menus, DB, cxDBData, DBAccess, IBC, MemDS, dxBar, StdCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridDBTableView, cxGrid, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxLabel, cxCurrencyEdit, cxClasses, cxGridTableView, cxGridCustomView;

type
  TfrmCustomerCreditDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnMain: TPanel;
    cxGridCredits: TcxGrid;
    cxGridCreditsLevel: TcxGridLevel;
    dxBarManager: TdxBarManager;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbRemove: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    cxGridCreditsTable: TcxGridDBTableView;
    cxGridCreditsTableDATA: TcxGridDBColumn;
    cxGridCreditsTable_SUMA_CASH: TcxGridDBColumn;
    cxGridCreditsTableDATE_END: TcxGridDBColumn;
    cxGridCreditsTableDESCRIPTION: TcxGridDBColumn;
    cxGridCreditsTableCONCATENATION: TcxGridDBColumn;
    IBCQueryCredits: TIBCQuery;
    IBCDataSourceCredits: TIBCDataSource;
    cxGridCredits_SUMA_TRANSFER: TcxGridDBColumn;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbRemoveClick(Sender: TObject);
    procedure cxGridCreditsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridCreditsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    FReadOnly: Boolean;
    { Private declarations }
    procedure SelectionChanged;
    procedure CreateNewCredit;
    procedure ModifySelectedCredit;
    procedure RemoveSelectedCredit;
    procedure LockCustomerCredits;
    procedure SetReadOnly(const Value: Boolean);
    function WhenVerifyDateRange(const DateStart, DateEnd: TDate): Boolean;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  frmCustomerCreditEditorDlg, SWNUtils, SWNSecurityFlags, SWNDBErrors, SWNConst;

{$R *.dfm}
{ TfrmCustomerCreditDialog }

procedure TfrmCustomerCreditDialog.bbModifyClick(Sender: TObject);
begin
  ModifySelectedCredit;
end;

procedure TfrmCustomerCreditDialog.bbNewClick(Sender: TObject);
begin
  CreateNewCredit;
end;

procedure TfrmCustomerCreditDialog.bbRemoveClick(Sender: TObject);
begin
  RemoveSelectedCredit;
end;

procedure TfrmCustomerCreditDialog.CreateNewCredit;
var
  dialog: TfrmCustomerCreditEditorDialog;
begin
  dialog := TfrmCustomerCreditEditorDialog.Create(Self, IBCQueryCredits, IBCDataSourceCredits);
  try
    dialog.OnVerifyDateRange := WhenVerifyDateRange;
    dialog.CreateNewCredit := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCreditDialog.cxGridCreditsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbModify.Enabled and (bbModify.Visible = ivAlways) then
  begin
    bbModifyClick(bbModify);
    AHandled := True;
  end;
end;

procedure TfrmCustomerCreditDialog.cxGridCreditsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmCustomerCreditDialog.BindingDataSource;
begin
  inherited;

  IBCQueryCredits.Connection := fIBCConnection;
  IBCQueryCredits.MasterSource := fMasterDataSource;
  IBCQueryCredits.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

function TfrmCustomerCreditDialog.IsFormDataPosted: Boolean;
begin
  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.Commit;
  Result := True;
end;

procedure TfrmCustomerCreditDialog.LockCustomerCredits;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'SELECT NULL FROM TS_CUST_CREDIT WHERE CUSTOMERID = :CustomerID FOR UPDATE WITH LOCK';
    Query.ParamByName('CustomerID').AsInteger := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmCustomerCreditDialog.ModifySelectedCredit;
var
  dialog: TfrmCustomerCreditEditorDialog;
begin
  dialog := TfrmCustomerCreditEditorDialog.Create(Self, IBCQueryCredits, IBCDataSourceCredits);
  try
    dialog.CreateNewCredit := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerCreditDialog.Prepare;
begin
  if FReadOnly then
  begin
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    btnOk.Visible := False;
    btnCancel.Default := True;
    btnCancel.Caption := 'Закрыть';

    IBCQueryCredits.UpdateTransaction := nil;
  end;

  SetupSecurityItems;

  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if not FReadOnly then
      LockCustomerCredits;

    dtDialogTitle.Text := 'Контрагент: ' + fMasterDataSet.FieldByName('DISPLAYNAME').AsString;

    if FReadOnly then
      IBCQueryCredits.ReadOnly := True;
    IBCQueryCredits.Active := True;

    SelectionChanged;
  except
    if not FReadOnly then
      fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmCustomerCreditDialog.RemoveSelectedCredit;
var
  S: string;
begin
  S := #13#10 + 'Сумма наличного кредита: $' + IBCQueryCredits.FieldByName('SUMA_CASH').AsString + #13#10 +
    'Сумма безналичного кредита: ' + IBCQueryCredits.FieldByName('SUMA_TRANSFER').AsString + 'LEI' + #13#10 + #13#10;
  if ShowAskDialog('Удаление кредитной записи', 'Кредит' + S + 'Удалить кредитную запись?') = mrYes then
  begin
    try
      IBCQueryCredits.Delete;
    except
      on E: Exception do
        ProcessSWNError(E);
    end;
  end;
end;

procedure TfrmCustomerCreditDialog.SelectionChanged;
var
  f1, f2: Boolean;
begin
  f1 := not FReadOnly; // + Security
  f2 := False;
  if (not FReadOnly) and (cxGridCreditsTable.DataController.RecNo > 0) then
  begin
    f2 := True; // + Security
  end;
  bbNew.Enabled := f1;
  bbModify.Enabled := f2;
  bbRemove.Enabled := f2;
end;

procedure TfrmCustomerCreditDialog.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmCustomerCreditDialog.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Кредиты_создать) then
    bbNew.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Кредиты_изменить) then
    bbModify.Visible := ivNever;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Кредиты_удалить) then
    bbRemove.Visible := ivNever;

  if dxBarManager1Bar2.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManager1Bar2.Visible := False;
    dxBarDockControl1.Visible := False;
    btnOk.Visible := False;
    btnCancel.Caption := 'Закрыть';
  end;
end;

procedure TfrmCustomerCreditDialog.WhenCancelForm;
begin
  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

function TfrmCustomerCreditDialog.WhenVerifyDateRange(const DateStart, DateEnd: TDate): Boolean;
var
  i, N: integer;
  d1, d2: TDate;
begin
  Result := True; // ok
  N := cxGridCreditsTable.DataController.GetEditingRecordIndex;
  for i := 0 to cxGridCreditsTable.DataController.RecordCount - 1 do
    if (i <> N) then
    begin
      d1 := cxGridCreditsTable.DataController.Values[i, cxGridCreditsTableDATA.Index];
      d2 := cxGridCreditsTable.DataController.Values[i, cxGridCreditsTableDATE_END.Index];
      if (DateStart >= d1) and (DateStart <= d2) or (DateEnd >= d1) and (DateEnd <= d2) then
      begin
        Result := False;
        Break;
      end;
    end;
end;

end.


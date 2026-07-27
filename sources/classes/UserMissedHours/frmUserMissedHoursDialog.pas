unit frmUserMissedHoursDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, DialogTitle, StdCtrls, DBAccess, IBC, MemDS, cxLabel, cxCheckBox, cxNavigator,
  cxGridCustomPopupMenu, cxGridPopupMenu, dxDateRanges, dxBarBuiltInMenu, dxScrollbarAnnotations, dxUIAClasses;

type
  TfrmUserMissedHoursDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    btnClose: TButton;
    IBCQueryMiss: TIBCQuery;
    IBCDataSourceMiss: TIBCDataSource;
    cxGrid_MISSHOURID: TcxGridDBColumn;
    cxGrid_USER_NAME: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_HOURS: TcxGridDBColumn;
    cxGrid_DESCRIPTION: TcxGridDBColumn;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid_DATE_INDEX: TcxGridDBColumn;
    cxGrid_MOTIV_TITLE: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    cxGridPopupMenu1: TcxGridPopupMenu;
    bbSetInterval: TdxBarButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGrid_DATE_INDEXGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure bbSetIntervalClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddNewRecordDialog;
    procedure ShowEditRecordDialog;
    procedure DeleteRecord;

    function ExtendPeriod(const MisshourID: Integer; const FinalDate: TDateTime): Boolean;
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;

  public
    { Public declarations }
  end;

implementation

uses DataModuleAdditions, DataModuleDB, frmUserMissedHourEditorDialog, SWNSecurity, SWNSecurityFlags, SWNUtils,
  SWNDBErrors, frmUserMissedHoursSetIntervalDialog;

{$R *.dfm}
{ TfrmUserMissedHoursDlg }

procedure TfrmUserMissedHoursDlg.bbDeleteClick(Sender: TObject);
begin
  DeleteRecord;
end;

procedure TfrmUserMissedHoursDlg.bbEditClick(Sender: TObject);
begin
  ShowEditRecordDialog;
end;

procedure TfrmUserMissedHoursDlg.bbNewClick(Sender: TObject);
begin
  ShowAddNewRecordDialog;
end;

procedure TfrmUserMissedHoursDlg.bbSetIntervalClick(Sender: TObject);
var
  dialog: TfrmUserMissedHoursSetIntervalDlg;
begin
  dialog := TfrmUserMissedHoursSetIntervalDlg.Create(Self);
  try
    dialog.SetDates(IBCQueryMiss.FieldByName('DATA').AsDateTime);
    if dialog.ShowModal = mrOk then
    begin
      if ExtendPeriod(IBCQueryMiss.FieldByName('MISSHOURID').asInteger, dialog.GetEndDate) then
      begin
        IBCQueryMiss.Refresh;
        ShowInfoDialog('Готово', 'Evenimentul este prelungit pina la  ' + FormatDateTime('dd.mm.yyyy', dialog.GetEndDate));
      end;
    end;
  finally
    dialog.free;
  end;
end;

procedure TfrmUserMissedHoursDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  SelectionChanged;
end;

procedure TfrmUserMissedHoursDlg.cxGrid_DATE_INDEXGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  N: Integer;
begin
  if VarIsNumeric(ARecord.Values[cxGrid_DATE_INDEX.Index]) then
  begin
    N := ARecord.Values[cxGrid_DATE_INDEX.Index];
    AText := Format('%s, %d', [FormatSettings.LongMonthNames[N mod 100], N div 100]);
  end;
end;

procedure TfrmUserMissedHoursDlg.DeleteRecord;
begin
  if ShowAskDialog('Sterge registrarea', Format('Sterge orele pentru "%s"?', [IBCQueryMiss.FieldByName('CT_NAME').asString])) <> mrYes then
    Exit;

  IBCQueryMiss.UpdateTransaction.StartTransaction;
  try
    IBCQueryMiss.Delete;
    IBCQueryMiss.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryMiss.UpdateTransaction.Rollback;
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

function TfrmUserMissedHoursDlg.ExtendPeriod(const MisshourID: Integer; const FinalDate: TDateTime): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.AutoCommit := False;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_MISSHOURS_EXTEND(:ID,:DATA)';
    Query.ParamByName('ID').asInteger := MisshourID;
    Query.ParamByName('DATA').AsDate := FinalDate;
    Query.Transaction.StartTransaction;
    try
      Query.Execute;
      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;
  finally
    Query.free;
  end;
end;

procedure TfrmUserMissedHoursDlg.Prepare;
begin
  IBCQueryMiss.ParamByName('DT').asInteger := dmDB.CurrentFirma;
  IBCQueryMiss.Active := True;
  if cxGridTable.DataController.RecordCount > 0 then
    cxGridTable.DataController.Groups.ChangeExpanding(0, True, False);
  SelectionChanged;
end;

procedure TfrmUserMissedHoursDlg.SelectionChanged;
var
  fAdd, fEdit, fDelete: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  if cxGridTable.DataController.RecNo > 0 then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbNew.Enabled := fAdd;
  bbEdit.Enabled := fEdit;
  bbDelete.Enabled := fDelete;
  bbSetInterval.Enabled := fEdit;
end;

procedure TfrmUserMissedHoursDlg.SetupSecurityItems;
begin
  if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖОР_Создать) then
    bbNew.Visible := ivNever;
  if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖОР_Редактировать) then
    bbEdit.Visible := ivNever;
  if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖОР_Удалить) then
    bbDelete.Visible := ivNever;

  if dxBarManagerBar1.ItemLinks.VisibleItemCount = 0 then
  begin
    dxBarManagerBar1.Visible := False;
    dxBarDockControl1.Visible := False;
  end;
end;

procedure TfrmUserMissedHoursDlg.ShowAddNewRecordDialog;
var
  dialog: TfrmUserMissedHourEditorDlg;
begin
  dialog := TfrmUserMissedHourEditorDlg.Create(Self, IBCQueryMiss, IBCDataSourceMiss);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.free;
  end;
end;

procedure TfrmUserMissedHoursDlg.ShowEditRecordDialog;
var
  dialog: TfrmUserMissedHourEditorDlg;
begin
  dialog := TfrmUserMissedHourEditorDlg.Create(Self, IBCQueryMiss, IBCDataSourceMiss);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.free;
  end;
end;

end.

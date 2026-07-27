unit frmUsersBrowser;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
   DialogTitle, Menus, cxStyles, cxCustomData, cxFilter,
   DB, cxDBData, IBC, dxBar,
   cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
   cxGrid, ExtCtrls, StdCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCheckBox, DBAccess,
  MemDS, cxClasses, cxGridCustomView, dxUIAClasses, frmPrintEngineWindow;

type
   TfrmUsersDlg = class(TSWNCustomForm)
      dtDialogTitle: TDialogTitle;
      dxBarManager: TdxBarManager;
      dxBarDockControl2: TdxBarDockControl;
      dxBarUsers: TdxBar;
      bbUserNew: TdxBarButton;
      bbUserModify: TdxBarButton;
      bbUserRemove: TdxBarButton;
      cxGridUsers: TcxGrid;
      cxGridUsersTable: TcxGridDBTableView;
      cxGridLevel: TcxGridLevel;
      cxGridUsersTableUSERID: TcxGridDBColumn;
      cxGridUsersTableLOGIN_NAME: TcxGridDBColumn;
      cxGridUsersTable_FULL_NAME: TcxGridDBColumn;
      cxGridUsersTableTELEFON: TcxGridDBColumn;
      cxGridUsersTableEMAIL: TcxGridDBColumn;
      cxGridUsersTableBIRTHDAY: TcxGridDBColumn;
      cxGridUsersTable_FLG_ACTIVE: TcxGridDBColumn;
      bbUserTools: TdxBarSubItem;
      bbUserMakeInactive: TdxBarButton;
      bbUserResetPassword: TdxBarButton;
      IBCQueryUsers: TIBCQuery;
      IBCDataSourceUsers: TIBCDataSource;
      IBCTrUpdateUsers: TIBCTransaction;
      pnClient: TPanel;
      cxGridUsersTable_IMG: TcxGridDBColumn;
      cxGridUsers_DEFAULT_DT_NAME: TcxGridDBColumn;
      cxGridUsers_FLG_CHANGE_PSWD: TcxGridDBColumn;
      pnBottom: TPanel;
      btnClose: TcxButton;
      cxGridUsers_FLG_HAS_USERGROUP: TcxGridDBColumn;
      cxGridUsers_FUNCTIA_DETINUTA: TcxGridDBColumn;
      cxGridUsers_CUSTOMER_DISPLAYNAME: TcxGridDBColumn;
      cxGridUsers_REGISTER_DATE: TcxGridDBColumn;
      cxGridUsers_USERTYPE_TITLE: TcxGridDBColumn;
      cxGridUsers_CUSTOMERID: TcxGridDBColumn;
    cxGridUsersTable_SIP: TcxGridDBColumn;
    bbPrint: TdxBarButton;
      procedure bbUserNewClick(Sender: TObject);
      procedure bbUserModifyClick(Sender: TObject);
      procedure bbUserRemoveClick(Sender: TObject);
      procedure cxGridUsersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
         TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
      procedure cxGridUsersTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
         AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
      procedure cxGridUsersTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure cxGridUsers_CUSTOMER_DISPLAYNAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
         TcxCustomGridRecord; var AText: string);
      procedure cxGridUsersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
         TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure bbPrintClick(Sender: TObject);
   private
    { Private declarations }
      procedure UserSelectionChanged;
      procedure CreateNewUser;
      procedure ModifyCurrentUser;
      procedure CopyActiveCellIntoClipboard;
    procedure SetupReportParams(const ReportParams: TReportParamsList);
   protected
    { Protected declarations }
      procedure Prepare; override;
      procedure LoadStates; override;
      procedure SaveStates; override;
      procedure SetupSecurityItems; override;
   public
    { Public declarations }
   end;

implementation

uses
   frmUserSettingsDlg, DataModuleAdditions, SWNUtils, SWNSecurity,
   SWNDBErrors, Clipbrd, SWNValueStorageUnit, frmPrintWizardDialog, DataModuleDB;

{$R *.dfm}
{ TfrmAcessDlg }

procedure TfrmUsersDlg.bbPrintClick(Sender: TObject);
var
  printWizard: TfrmPrintWizardDlg;
begin
  printWizard := TfrmPrintWizardDlg.Create(Self, dmDB.CurrentFirma, -1);
  try
    printWizard.ShowReportsFromGroupOnly(30); // 30 - Пользователи
//    printWizard.Set
    printWizard.OnPrintWizardSetupReportParams := SetupReportParams;
    printWizard.ShowModal;
  finally
    printWizard.Free;
  end;
end;

procedure TfrmUsersDlg.SetupReportParams(const ReportParams: TReportParamsList);
begin
  ReportParams.SetParamValue('USERID', IBCQueryUsers.FieldByName('UserID').AsInteger);
end;

procedure TfrmUsersDlg.bbUserModifyClick(Sender: TObject);
begin
   ModifyCurrentUser;
end;

procedure TfrmUsersDlg.bbUserNewClick(Sender: TObject);
begin
   CreateNewUser;
end;

procedure TfrmUsersDlg.bbUserRemoveClick(Sender: TObject);
begin
   with IBCQueryUsers do
      if ShowAskDialog('Sterge utizator', 'Sterge utilizatorul "' + FieldByName('FIRST_NAME').AsString
         + ' ' + FieldByName('LAST_NAME').AsString + '"?') = mrYes then
      begin
         IBCQueryUsers.UpdateTransaction.StartTransaction;
         try
            IBCQueryUsers.Delete;
            IBCQueryUsers.UpdateTransaction.Commit;
         except
            on E: Exception do
            begin
               IBCQueryUsers.UpdateTransaction.Rollback;
               if not ProcessSWNError(E) then
                  raise;
            end;
         end;
      end;
end;

procedure TfrmUsersDlg.ModifyCurrentUser;
var
   dialog: TfrmUserSettingsDialog;
begin
   dialog := TfrmUserSettingsDialog.Create(Self, IBCQueryUsers, IBCDataSourceUsers);
   try
      dialog.CreateNewUser := False;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TfrmUsersDlg.Prepare;
begin
   SetupSecurityItems;

  // load data
   IBCQueryUsers.Active := True;
  // select default cell
   cxGridUsersTable_FULL_NAME.Focused := True;

   cxGridUsersTable.DataController.Filter.Root.Clear;
   cxGridUsersTable.DataController.Filter.Root.BoolOperatorKind := fboOr;
   cxGridUsersTable.DataController.Filter.Root.AddItem(cxGridUsersTable_FLG_ACTIVE, foEqual, '1', '1');
   cxGridUsersTable.DataController.Filter.Active := True;
end;

procedure TfrmUsersDlg.SaveStates;
begin
  // form pos
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
      AppUserConfigStorage.FormPositions.SaveFormPos(Self);
  // store column visibility and width
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridUsersTable);
end;

procedure TfrmUsersDlg.SetupSecurityItems;
begin
   if SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      IBCQueryUsers.FilterSQL := 'USERID >= 1' // dam voie sa se vada SuperAdmin
   else
      IBCQueryUsers.FilterSQL := 'USERID > 1'; // numai utilizatorii de rind
end;

procedure TfrmUsersDlg.UserSelectionChanged;
var
   fUserNew, fUserEdit, fUserDelete: Boolean;
begin
   fUserNew := True; // New User + Security
   fUserEdit := False;
   fUserDelete := False;

   if (cxGridUsersTable.DataController.RecNo > 0) then
   begin
      fUserEdit := True; // Edit User + Security
      fUserDelete := True; // Delete User + Security
   end;
   bbUserNew.Enabled := fUserNew;
   bbUserModify.Enabled := fUserEdit;
   bbUserRemove.Enabled := fUserDelete;

   bbUserMakeInactive.Enabled := fUserEdit;
   bbUserResetPassword.Enabled := fUserEdit;
end;

procedure TfrmUsersDlg.CopyActiveCellIntoClipboard;
var
   N, i: integer;
begin
   N := cxGridUsersTable.DataController.FocusedRecordIndex;
   if N <> -1 then
   begin
      for i := 0 to cxGridUsersTable.ColumnCount - 1 do
         if cxGridUsersTable.Columns[i].Focused then
         begin
            Clipboard.AsText := cxGridUsersTable.DataController.Values[N, cxGridUsersTable.Columns[i].Index];
            break;
         end;
   end;
end;

procedure TfrmUsersDlg.CreateNewUser;
var
   dialog: TfrmUserSettingsDialog;
begin
   dialog := TfrmUserSettingsDialog.Create(Self, IBCQueryUsers, IBCDataSourceUsers);
   try
      dialog.CreateNewUser := True;
      dialog.ShowModal;
   finally
      dialog.Free;
   end;
end;

procedure TfrmUsersDlg.cxGridUsersTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
   TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
   if bbUserModify.Enabled and (bbUserModify.Visible = ivAlways) then
   begin
      bbUserModifyClick(bbUserModify);
      AHandled := True;
   end;
end;

procedure TfrmUsersDlg.cxGridUsersTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
   AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
   UserSelectionChanged;
end;

procedure TfrmUsersDlg.cxGridUsersTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
   begin
      CopyActiveCellIntoClipboard;
      Key := 0;
      Shift := [];
   end;
end;

procedure TfrmUsersDlg.cxGridUsersTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
   TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
   if VarIsOrdinal(ARecord.Values[cxGridUsersTable_FLG_ACTIVE.Index]) then
   begin
      if ARecord.Values[cxGridUsersTable_FLG_ACTIVE.Index] = 0 then
         AStyle := dmAdditions.cxStyle_BackgroundRED;
   end;
   if VarIsNumeric(ARecord.Values[cxGridUsersTableUSERID.Index]) then
   begin
      if (ARecord.Values[cxGridUsersTableUSERID.Index] = 1) then
         AStyle := dmAdditions.cxStyle_Bold;

   end;
end;

procedure TfrmUsersDlg.cxGridUsers_CUSTOMER_DISPLAYNAMEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
   TcxCustomGridRecord; var AText: string);
begin
   if VarIsNumeric(ARecord.Values[cxGridUsers_CUSTOMERID.Index]) then
   begin
      if ARecord.Values[cxGridUsers_CUSTOMERID.Index] = -1 then
         AText := '(nu este ales)';
   end;
end;

procedure TfrmUsersDlg.LoadStates;
begin
  // form position
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos
      (Self) then
      Self.Position := poDesigned;
  // read column visibility and width
   if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then
      AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridUsersTable);
end;

end.


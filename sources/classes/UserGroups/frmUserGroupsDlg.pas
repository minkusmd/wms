unit frmUserGroupsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, IBC, Menus, cxStyles,
  DB,
  cxDBData, DBAccess, dxBar,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxControls, cxGridCustomView, cxGrid, ExtCtrls, StdCtrls,
  cxButtons, DialogTitle,
  System.Types, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxCheckBox, MemDS, cxClasses,
  dxGDIPlusClasses, dxUIAClasses;

type
  TfrmUserGroupsEditor = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarGroups: TdxBar;
    dxBarUsers: TdxBar;
    bbGroupNew: TdxBarButton;
    bbGroupModify: TdxBarButton;
    bbGroupRemove: TdxBarButton;
    bbUserNew: TdxBarButton;
    bbUserModify: TdxBarButton;
    bbUserRemove: TdxBarButton;
    cxGridGroupsTable: TcxGridDBTableView;
    cxGridGroupsLevel: TcxGridLevel;
    cxGridGroups: TcxGrid;
    cxGridGroups_GROUPID: TcxGridDBColumn;
    cxGridGroups_NAME: TcxGridDBColumn;
    cxGridGroups_FLG_SERVICE: TcxGridDBColumn;
    bbUserTools: TdxBarSubItem;
    btnClose: TcxButton;
    bbUserMakeInactive: TdxBarButton;
    bbUserResetPassword: TdxBarButton;
    IBCDataSourceGroups: TIBCDataSource;
    IBCQueryGroups: TIBCQuery;
    IBCTrUpdateGroups: TIBCTransaction;
    pnClient: TPanel;
    pnWarning: TPanel;
    Label1: TLabel;
    Image1: TImage;
    pnUsers: TPanel;
    cxGridUsersTable: TcxGridDBTableView;
    cxGridUsersLevel: TcxGridLevel;
    cxGridUsers: TcxGrid;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cxGridUsers_USERID: TcxGridDBColumn;
    cxGridUsers_FULL_NAME: TcxGridDBColumn;
    cxGridUsers_FLG_ACTIVE: TcxGridDBColumn;
    cxGridUsers_FIRMA: TcxGridDBColumn;
    pnGroups: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbRemoveFromGroup: TdxBarButton;
    cxGridUsers_IMG: TcxGridDBColumn;
    dxBarSubItem1: TdxBarSubItem;
    bbSetupFlagsToAllGroups: TdxBarButton;
    cxGridGroups_FLG_SERVICE_TITLE: TcxGridDBColumn;
    procedure bbGroupNewClick(Sender: TObject);
    procedure bbGroupRemoveClick(Sender: TObject);
    procedure DataSourceGroupsStateChange(Sender: TObject);
    procedure bbGroupModifyClick(Sender: TObject);
    procedure cxGridGroupsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridGroupsTableColumn2StylesGetContentStyle
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure IBCQueryUsersAfterRefresh(DataSet: TDataSet);
    procedure cxGridUsersTableFocusedRecordChanged
      (Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridUsersTableStylesGetContentStyle
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridGroupsTableDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure bbRemoveFromGroupClick(Sender: TObject);
    procedure cxGridGroupsTableDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure bbSetupFlagsToAllGroupsClick(Sender: TObject);
    procedure cxGridGroups_FLG_SERVICE_TITLEGetDataText
      (Sender: TcxCustomGridTableItem; ARecordIndex: Integer;
      var AText: string);
  private
    { Private declarations }
    procedure GroupSelectionChanged;
    procedure CreateNewUserGroup;
    procedure ModifySelectedGroup;

    procedure UsersSelectionChanged;

    function MoveUserToUserGroupDB(const UserID, OldGroupID,
      NewGroupID: Integer; const ToCopy: Integer = 0): Boolean;

    procedure ShowSetupSecurityFlagsForAllGroupsDialog;

  protected
    { Protected declarations }
    procedure Prepare; override;

    procedure SetupSecurityItems; override;

  public
    { Public declarations }
  end;

implementation

uses frmUserGroupEditorDlg, DataModuleAdditions, SWNUtils,
  DataModuleDB, SWNSecurity, SWNDBErrors,
  frmSecurityFlagsSelectorDialog;

{$R *.dfm}
{ TfrmAcessDlg }

procedure TfrmUserGroupsEditor.bbGroupModifyClick(Sender: TObject);
begin
  ModifySelectedGroup;
end;

procedure TfrmUserGroupsEditor.bbGroupNewClick(Sender: TObject);
begin
  CreateNewUserGroup;
end;

procedure TfrmUserGroupsEditor.bbGroupRemoveClick(Sender: TObject);
begin
  if IBCQueryGroups.FieldByName('GROUPID').AsInteger = 1 then
  begin
    ShowErrorDialog('Eroare', 'Nu puteți șterge acest grup!');
    Exit;
  end;

  if ShowAskDialog('Grupa de utilizatori', 'Ștergerea grupei "' + IBCQueryGroups.FieldByName('NAME').AsString + '"?')
     <> mrYes then
    Exit;



  IBCQueryGroups.UpdateTransaction.StartTransaction;
  try
    IBCQueryGroups.Delete;
    IBCQueryGroups.UpdateTransaction.Commit;
  except
    on E: Exception do
    begin
      IBCQueryGroups.UpdateTransaction.Rollback;
      if Not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmUserGroupsEditor.bbRemoveFromGroupClick(Sender: TObject);
var
  s1, s2: string;
  UserID, OldGroupID: Integer;
begin
  s1 := cxGridUsersTable.Controller.FocusedRecord.Values
    [cxGridUsers_FULL_NAME.Index];
  UserID := cxGridUsersTable.Controller.FocusedRecord.Values
    [cxGridUsers_USERID.Index];
  s2 := cxGridGroupsTable.Controller.FocusedRecord.Values
    [cxGridGroups_NAME.Index];
  OldGroupID := cxGridGroupsTable.Controller.FocusedRecord.Values
    [cxGridGroups_GROUPID.Index];
  if ShowAskDialog('Eliminarea unui utilizator dintr-un grup',
    Format('Doriți să eliminați utilizatorul %s din grup "%s" ?', [s1, s2])) = mrYes
  then
  begin
    if MoveUserToUserGroupDB(UserID, OldGroupID, -1) then
      IBCQueryUsers.Refresh;
  end;
end;

procedure TfrmUserGroupsEditor.bbSetupFlagsToAllGroupsClick(Sender: TObject);
begin
  ShowSetupSecurityFlagsForAllGroupsDialog;
end;

procedure TfrmUserGroupsEditor.GroupSelectionChanged;
var
  fGroupNew, fGroupEdit, fGroupDelete: Boolean;
begin
  fGroupNew := True; // New Group + Security
  fGroupEdit := False;
  fGroupDelete := False;

  if (cxGridGroupsTable.DataController.RecNo > 0) then
  begin
    fGroupEdit := True; // Edit Group + Security
    fGroupDelete := True; // Delete Group + Security
  end;
  bbGroupNew.Enabled := fGroupNew;
  bbGroupModify.Enabled := fGroupEdit;
  bbGroupRemove.Enabled := fGroupDelete;

  UsersSelectionChanged;
end;

procedure TfrmUserGroupsEditor.IBCQueryUsersAfterRefresh(DataSet: TDataSet);
begin
  cxGridUsersTable.BeginUpdate;
  try
    cxGridUsersTable.DataController.Groups.FullExpand;
  finally
    cxGridUsersTable.EndUpdate;
  end;
end;

procedure TfrmUserGroupsEditor.ModifySelectedGroup;
var
  dialog: TfrmUserGroupDlg;
begin
  dialog := TfrmUserGroupDlg.Create(self, IBCQueryGroups, IBCDataSourceGroups);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

function TfrmUserGroupsEditor.MoveUserToUserGroupDB(const UserID, OldGroupID,
  NewGroupID: Integer; const ToCopy: Integer = 0): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := IBCTrUpdateGroups;
    Query.SQL.Text :=
      'EXECUTE PROCEDURE SP_USER_MOVEOTHERUSERGORUP(:USERID,:OLD_GROUPID,:NEW_GROUPID,:TOCOPY)';
    Query.ParamByName('USERID').AsInteger := UserID;
    Query.ParamByName('OLD_GROUPID').AsInteger := OldGroupID;
    Query.ParamByName('NEW_GROUPID').AsInteger := NewGroupID;
    Query.ParamByName('TOCOPY').AsInteger := ToCopy;

    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
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
    Query.Free;
  end;
end;

procedure TfrmUserGroupsEditor.Prepare;
begin
  // check security permisions
  SetupSecurityItems;

  // load data
  IBCQueryGroups.Active := True;
  IBCQueryUsers.Active := True;
  cxGridUsers_FULL_NAME.Focused := True;

  cxGridGroupsTable.DataController.Groups.FullExpand;

  GroupSelectionChanged;
end;

procedure TfrmUserGroupsEditor.SetupSecurityItems;
begin
  if SWNSecurityManager.LoggedUser.IsSuperAdminUser then
    cxGridGroups_FLG_SERVICE_TITLE.GroupIndex := 0
  else
  begin
    bbRemoveFromGroup.Visible := ivNever;
    dxBarDockControl2.Visible := false;
  end;
end;

procedure TfrmUserGroupsEditor.ShowSetupSecurityFlagsForAllGroupsDialog;
var
  dialog: TfrmSecurityFlagsSelectorDlg;
begin
  dialog := TfrmSecurityFlagsSelectorDlg.Create(self, IBCQueryGroups,
    IBCDataSourceGroups);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserGroupsEditor.UsersSelectionChanged;
var
  fDelete: Boolean;
begin
  fDelete := False;
  if (cxGridUsersTable.DataController.RecNo > 0) then
  begin
    fDelete := True;
  end;
  bbRemoveFromGroup.Enabled := fDelete;
end;

procedure TfrmUserGroupsEditor.CreateNewUserGroup;
var
  usr_gr: TfrmUserGroupDlg;
begin
  usr_gr := TfrmUserGroupDlg.Create(self, IBCQueryGroups, IBCDataSourceGroups);
  try
    usr_gr.CreateNewGroup := True;
    if usr_gr.ShowModal = mrOk then
    begin
      IBCQueryGroups.Refresh;
    end;
  finally
    usr_gr.Free;
  end;
end;

procedure TfrmUserGroupsEditor.cxGridGroupsTableCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if bbGroupModify.Enabled and (bbGroupModify.Visible = ivAlways) then
  begin
    bbGroupModifyClick(bbGroupModify);
    AHandled := True;
  end;
end;

procedure TfrmUserGroupsEditor.cxGridGroupsTableColumn2StylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridGroups_GROUPID.Index] = 1 then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmUserGroupsEditor.cxGridGroupsTableDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  gridSite: TcxGridSite;
  AHitTest: TcxCustomGridHitTest;
  HitTest: TcxGridRecordHitTest;
  s0, s1, s2: string;
  UserID, OldGroupID, NewGroupID: Integer;
  // drag:TcxDragControlObject;
  asCopy: Integer;
begin
  // drag:=TcxDragControlObject(Source);

  asCopy := 0;
  if GetAsyncKeyState(VK_CONTROL) < 0 then
    asCopy := 1;

  gridSite := TcxGridSite(Sender);
  AHitTest := gridSite.GridView.GetHitTest(Point(X, Y));
  if (AHitTest is TcxGridRecordHitTest) then
  begin
    HitTest := TcxGridRecordHitTest(AHitTest);

    s0 := cxGridGroupsTable.Controller.FocusedRecord.Values
      [cxGridGroups_NAME.Index];
    OldGroupID := cxGridGroupsTable.Controller.FocusedRecord.Values
      [cxGridGroups_GROUPID.Index];
    s1 := cxGridUsersTable.Controller.FocusedRecord.Values
      [cxGridUsers_FULL_NAME.Index];
    UserID := cxGridUsersTable.Controller.FocusedRecord.Values
      [cxGridUsers_USERID.Index];
    s2 := HitTest.GridRecord.Values[cxGridGroups_NAME.Index];
    NewGroupID := HitTest.GridRecord.Values[cxGridGroups_GROUPID.Index];

    if asCopy = 0 then
    begin
      // move user
      if ShowAskDialog('Transfer utilizator',
        Format('Doriti sa mutati utilizatorul %s din grupul "%s" in grupul "%s" ?',
        [s1, s0, s2])) = mrYes then
      begin
        if MoveUserToUserGroupDB(UserID, OldGroupID, NewGroupID) then
          IBCQueryUsers.Refresh;
      end;
    end
    else
    begin
      // copy user
      if ShowAskDialog('Copiere utilizator',
        Format('Doriti sa adaugati utilizatorul %s in grupul "%s" ?', [s1, s2]))
        = mrYes then
      begin
        if MoveUserToUserGroupDB(UserID, OldGroupID, NewGroupID, 1) then
          IBCQueryUsers.Refresh;
      end;
    end;
  end;
end;

procedure TfrmUserGroupsEditor.cxGridGroupsTableDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  gridSite: TcxGridSite;
  AHitTest: TcxCustomGridHitTest;
  HitTest: TcxGridRecordHitTest;
begin
  gridSite := TcxGridSite(Sender);
  AHitTest := gridSite.GridView.GetHitTest(Point(X, Y));
  if (AHitTest is TcxGridRecordHitTest) then
  begin
    HitTest := TcxGridRecordHitTest(AHitTest);
    Accept := ((TcxDragControlObject(Source).Control as TcxGridSite)
      .GridView = cxGridUsersTable) and
      (HitTest.GridRecord <> cxGridGroupsTable.Controller.FocusedRecord);
  end;

  {
    gridSite:=TcxGridSite(Sender);
    AHitTest:=gridSite.GridView.GetHitTest(Point(X,Y));
    if (AHitTest is TcxGridRecordHitTest) then
    begin
    HitTest:=TcxGridRecordHitTest(AHitTest);
    if VarIsNull(HitTest.GridRecord.Values[cxGridGroupsTableColumn2.Index])
    then Label1.Caption:='NULL'
    else
    begin
    Label1.Caption:=HitTest.GridRecord.Values[cxGridGroupsTableColumn2.Index]+#13#10+cxGridUsersTable.Controller.FocusedRecord.Values[cxGridUsers_FULL_NAME.Index];
    Accept := ((TcxDragControlObject(Source).Control as TcxGridSite).GridView = cxGridUsersTable)
    and
    (HitTest.GridRecord<>cxGridGroupsTable.Controller.FocusedRecord);
    end;
    end;
  }
end;

procedure TfrmUserGroupsEditor.cxGridGroups_FLG_SERVICE_TITLEGetDataText
  (Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  if Not VarIsNull(cxGridGroupsTable.DataController.Values[ARecordIndex,
    cxGridGroups_FLG_SERVICE_TITLE.Index]) then
  begin
    if cxGridGroupsTable.DataController.Values[ARecordIndex,
      cxGridGroups_FLG_SERVICE_TITLE.Index] = 1 then
      AText := 'Grupuri B'
    else
      AText := 'Grupuri A';
  end;
end;

procedure TfrmUserGroupsEditor.cxGridUsersTableFocusedRecordChanged
  (Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord
  : TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  UsersSelectionChanged;
end;

procedure TfrmUserGroupsEditor.cxGridUsersTableStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if VarIsNumeric(ARecord.Values[cxGridUsers_FLG_ACTIVE.Index]) then
  begin
    if ARecord.Values[cxGridUsers_FLG_ACTIVE.Index] = 0 then
      AStyle := dmAdditions.cxStyle_TextGray;
  end;
end;

procedure TfrmUserGroupsEditor.DataSourceGroupsStateChange(Sender: TObject);
begin
  GroupSelectionChanged;
end;

end.

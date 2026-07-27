unit frmPeriodAccessGroupsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, Menus, StdCtrls, cxButtons, ExtCtrls, DialogTitle,
  cxMemo, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxCheckBox, cxNavigator,
  cxImageComboBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxClasses, cxGridCustomView, cxGrid, cxPC, Data.DB, MemDS, DBAccess, IBC,
  dxBarBuiltInMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxMaskEdit, cxDropDownEdit, cxCalendar,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmPeriodsSecurityDlg = class(TSWNMasteredFormClass)
    btnOk: TButton;
    btnCancel: TButton;
    cxPageControl1: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edDescription: TcxDBMemo;
    tbsAccess: TcxTabSheet;
    Label3: TLabel;
    cxLabel14: TLabel;
    btnAddUserGroup: TButton;
    btnRemoveUserGroup: TButton;
    cxGridUserGroups: TcxGrid;
    cxGridUserGroupsTable: TcxGridTableView;
    cxGridUserGroups_IMAGE: TcxGridColumn;
    cxGridUserGroups_TITLE: TcxGridColumn;
    cxGridUserGroups_GROUPID: TcxGridColumn;
    cxGridUserGroupsLevel: TcxGridLevel;
    cxGridAvailableUserGroups: TcxGrid;
    cxGridAUGTable: TcxGridTableView;
    cxGridAUG_IMAGE: TcxGridColumn;
    cxGridAUG_TITLE: TcxGridColumn;
    cxGridAUG_GROUPID: TcxGridColumn;
    cxGridAUGLevel: TcxGridLevel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxDBDateEdit2: TcxDBDateEdit;
    procedure btnAddUserGroupClick(Sender: TObject);
    procedure btnRemoveUserGroupClick(Sender: TObject);
    procedure cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAUGTableDblClick(Sender: TObject);
    procedure cxGridUserGroupsTableDblClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckParams: Boolean;
    procedure LoadStockUserGroups;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure UserGroupsSelectionChanged;
    procedure SetupSecurityItems; override;
    procedure AddSelectedAvailableGroups;
    procedure RemoveSelectedUserGroups;
    procedure SetStockAccessValue;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

uses
  SWNUtils, SWNSecurityFlags, SWNConst, frmSyssEditorWindow, DataModuleAdditions,
  DataModuleDB, SWNSecurityUtils, SWNSecurity;

{$R *.dfm}
{ TfrmStockEditorDlg }

procedure TfrmPeriodsSecurityDlg.btnAddUserGroupClick(Sender: TObject);
begin
  AddSelectedAvailableGroups;
end;

procedure TfrmPeriodsSecurityDlg.btnRemoveUserGroupClick(Sender: TObject);
begin
  RemoveSelectedUserGroups;
end;

procedure TfrmPeriodsSecurityDlg.RemoveSelectedUserGroups;
var
  i, N: integer;
  row: TcxCustomGridRow;
  groupID: integer;
  groupTitle: string;
begin
  cxGridAUGTable.DataController.BeginUpdate;
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
        // add selected groups
    for i := 0 to cxGridUserGroupsTable.Controller.SelectedRowCount - 1 do
    begin
      Row := cxGridUserGroupsTable.Controller.SelectedRows[i];

      groupID := Row.Values[cxGridUserGroups_GROUPID.Index];
      groupTitle := Row.Values[cxGridUserGroups_TITLE.Index];

      N := cxGridAUGTable.DataController.AppendRecord;
      cxGridAUGTable.DataController.Values[N, cxGridAUG_GROUPID.Index] := groupID;
      cxGridAUGTable.DataController.Values[N, cxGridAUG_TITLE.Index] := groupTitle;
    end;
        // remove selected groups
    for i := cxGridUserGroupsTable.Controller.SelectedRowCount - 1 downto 0 do
    begin
      Row := cxGridUserGroupsTable.Controller.SelectedRows[i];
      cxGridUserGroupsTable.DataController.DeleteRecord(Row.RecordIndex);
    end;
    cxGridUserGroupsTable.Controller.ClearSelection;
  finally
    cxGridAUGTable.DataController.EndUpdate;
    cxGridUserGroupsTable.DataController.EndUpdate;
  end;
end;

procedure TfrmPeriodsSecurityDlg.AddSelectedAvailableGroups;
var
  i, N: integer;
  row: TcxCustomGridRow;
  groupID: integer;
  groupTitle: string;
begin
  cxGridAUGTable.DataController.BeginUpdate;
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
        // add selected groups
    for i := 0 to cxGridAUGTable.Controller.SelectedRowCount - 1 do
    begin
      Row := cxGridAUGTable.Controller.SelectedRows[i];

      groupID := Row.Values[cxGridAUG_GROUPID.Index];
      groupTitle := Row.Values[cxGridAUG_TITLE.Index];

      N := cxGridUserGroupsTable.DataController.AppendRecord;
      cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := groupID;
      cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := groupTitle;
    end;
        // remove selected groups
    for i := cxGridAUGTable.Controller.SelectedRowCount - 1 downto 0 do
    begin
      Row := cxGridAUGTable.Controller.SelectedRows[i];
      cxGridAUGTable.DataController.DeleteRecord(Row.RecordIndex);
    end;
    cxGridAUGTable.Controller.ClearSelection;
  finally
    cxGridAUGTable.DataController.EndUpdate;
    cxGridUserGroupsTable.DataController.EndUpdate;
  end;
end;

function TfrmPeriodsSecurityDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPeriodsSecurityDlg.cxGridAUGTableDblClick(Sender: TObject);
begin
  btnAddUserGroupClick(Sender);
end;

procedure TfrmPeriodsSecurityDlg.cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserGroupsSelectionChanged;
end;

procedure TfrmPeriodsSecurityDlg.cxGridUserGroupsTableDblClick(Sender: TObject);
begin
  btnRemoveUserGroupClick(Sender);
end;

procedure TfrmPeriodsSecurityDlg.BindingDataSource;
begin
  inherited;

  FCreateNewRecord := False;

  cxDBDateEdit1.DataBinding.DataSource := fMasterDataSource;
  cxDBDateEdit2.DataBinding.DataSource := fMasterDataSource;

  edDescription.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmPeriodsSecurityDlg.Prepare;
begin
  SetupSecurityItems;
  fMasterDataSet.UpdateTransaction.StartTransaction;
  cxPageControl1.ActivePage := tbsGeneral;
  UserGroupsSelectionChanged;
  try
    if FCreateNewRecord then
    begin
      // new record
      fMasterDataSet.Append;
      with fMasterDataSet do
      begin
        FieldByName('DATA1').AsDateTime := Date-1;
        FieldByName('DATA2').AsDateTime := Date;
      end;
    end
    else
    begin
      fMasterDataSet.Edit;
    end;
    LoadStockUserGroups;
    UserGroupsSelectionChanged;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;

    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmPeriodsSecurityDlg.LoadStockUserGroups;
var
  Query: TIBCQuery;
  mask: int64;
  n: integer;
  groupID: integer;
  groupTitle: string;
begin
  mask := fMasterDataSet.FieldByName('ACC$MASK').AsLargeInt;
  Query := TIBCQuery.Create(Self);
  cxGridUserGroupsTable.DataController.BeginUpdate;
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT GROUPID, GROUP_NAME FROM GET_GROUPS_BY_USER(:USERID)';
    Query.ParamByName('USERID').AsInteger := dmDB.CurrentUserID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      groupID := Query.Fields[0].AsInteger;
      groupTitle := Query.Fields[1].asString;
      if (mask and (1 shl (groupID - 1)) > 0) then
      begin
                  // group is selected
        N := cxGridUserGroupsTable.DataController.AppendRecord;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := groupID;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := groupTitle;
      end
      else
      begin
                  // group is available
        N := cxGridAUGTable.DataController.AppendRecord;
        cxGridAUGTable.DataController.Values[N, cxGridAUG_GROUPID.Index] := groupID;
        cxGridAUGTable.DataController.Values[N, cxGridAUG_TITLE.Index] := groupTitle;
      end;

      Query.Next;
    end;
  finally
    cxGridUserGroupsTable.DataController.EndUpdate;
    Query.Free;
  end;
end;

procedure TfrmPeriodsSecurityDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmPeriodsSecurityDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmPeriodsSecurityDlg.UserGroupsSelectionChanged;
begin
  btnAddUserGroup.Enabled := cxGridAUGTable.Controller.SelectedRowCount > 0;
  btnRemoveUserGroup.Enabled := cxGridUserGroupsTable.Controller.SelectedRowCount > 0;
end;

procedure TfrmPeriodsSecurityDlg.SetupSecurityItems;
begin

end;

procedure TfrmPeriodsSecurityDlg.SetStockAccessValue;
var
  i, groupID: integer;
  N: int64;
begin
  N := 0;
  for i := 0 to cxGridUserGroupsTable.DataController.RecordCount - 1 do
  begin
    groupID := cxGridUserGroupsTable.DataController.Values[i, cxGridUserGroups_GROUPID.Index];
    N := N or (1 shl (groupID - 1));
  end;
  fMasterDataSet.FieldByName('ACC$MASK').Value := N;
end;

function TfrmPeriodsSecurityDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    SetStockAccessValue;
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end
  else
    Result := False;
end;

end.


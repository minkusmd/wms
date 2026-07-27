unit frmStockEditorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, Menus, StdCtrls, cxButtons, ExtCtrls, DialogTitle,
  cxDBEdit,

  cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxPC, Data.DB, DBAccess, IBC,
  cxCustomData, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxStyles, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox,
  cxClasses, cxGridCustomView, cxCheckBox, cxMemo, cxTextEdit;

type
  TfrmStockEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    cxPageControl1: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    cxGridSelFirms: TcxGrid;
    cxGridSelFirmsTable: TcxGridTableView;
    cxGridSelFirms_IMG: TcxGridColumn;
    cxGridSelFirms_TITLE: TcxGridColumn;
    cxGridSelFirms_ID: TcxGridColumn;
    cxGridSelFirmsLevel: TcxGridLevel;
    cxGridAvFirms: TcxGrid;
    cxGridAvFirmsTable: TcxGridTableView;
    cxGridAvFirms_IMG: TcxGridColumn;
    cxGridAvFirms_TITLE: TcxGridColumn;
    cxGridAvFirms_ID: TcxGridColumn;
    cxGridAvFirmsLevel: TcxGridLevel;
    cxLabel1: TLabel;
    edTitle: TcxDBTextEdit;
    cxLabel2: TLabel;
    edDescription: TcxDBMemo;
    cbFLG_VISISIBLE_FOR_SALE: TcxDBCheckBox;
    cbFLG_ADMINISTRATIA: TcxDBCheckBox;
    cbFLG_RMA: TcxDBCheckBox;
    tbsAccess: TcxTabSheet;
    Label3: TLabel;
    cxLabel14: TLabel;
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
    btnOk: TcxButton;
    btnCancel: TcxButton;
    btnAddFirms: TcxButton;
    btnRemoveFirms: TcxButton;
    btnAddUserGroup: TcxButton;
    btnRemoveUserGroup: TcxButton;
    procedure btnAddUserGroupClick(Sender: TObject);
    procedure btnRemoveUserGroupClick(Sender: TObject);
    procedure cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAUGTableDblClick(Sender: TObject);
    procedure cxGridUserGroupsTableDblClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    fParentID: integer;
    fFirmsChanged: Boolean;
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
//    procedure LoadReportUserGroups;
    procedure LoadFirmsInfo(const UserID, ReportID: integer);
    procedure FirmsSelectionChanged;
    procedure AddSelectedAvailableGroups;
    procedure RemoveSelectedUserGroups;
    procedure SetStockAccessValue;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    property ParentID: integer write fParentID;
  end;

implementation

uses
  SWNUtils, SWNSecurityFlags, SWNConst,
  DataModuleDB, SWNSecurity;

{$R *.dfm}
{ TfrmStockEditorDlg }

procedure TfrmStockEditorDlg.btnAddUserGroupClick(Sender: TObject);
begin
  AddSelectedAvailableGroups;
end;

procedure TfrmStockEditorDlg.btnRemoveUserGroupClick(Sender: TObject);
begin
  RemoveSelectedUserGroups;
end;

procedure TfrmStockEditorDlg.RemoveSelectedUserGroups;
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

procedure TfrmStockEditorDlg.AddSelectedAvailableGroups;
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

function TfrmStockEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  ErrorStr := '';
  Result := False;

  if (fMasterDataSet.FieldByName('TITLE').IsNull) or (fMasterDataSet.FieldByName('TITLE').AsString = '') then
    AddErrorToStr(ErrorStr, 'Название склада!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmStockEditorDlg.cxGridAUGTableDblClick(Sender: TObject);
begin
  btnAddUserGroupClick(Sender);
end;

procedure TfrmStockEditorDlg.cxGridAUGTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserGroupsSelectionChanged;
end;

procedure TfrmStockEditorDlg.cxGridUserGroupsTableDblClick(Sender: TObject);
begin
  btnRemoveUserGroupClick(Sender);
end;

procedure TfrmStockEditorDlg.BindingDataSource;
begin
  inherited;

  FCreateNewRecord := False;
  fParentID := 0;

  edTitle.DataBinding.DataSource := fMasterDataSource;
  edDescription.DataBinding.DataSource := fMasterDataSource;
  cbFLG_VISISIBLE_FOR_SALE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ADMINISTRATIA.DataBinding.DataSource := fMasterDataSource;
  cbFLG_RMA.DataBinding.DataSource := fMasterDataSource;
end;

procedure TfrmStockEditorDlg.Prepare;
begin
  SetupSecurityItems;
  fMasterDataSet.UpdateTransaction.StartTransaction;
  cxPageControl1.ActivePage := tbsGeneral;
  UserGroupsSelectionChanged;
  try
    if FCreateNewRecord then
    begin
      // new record
      dtDialogTitle.Text := 'Создание нового склада';

      fMasterDataSet.Append;
      fMasterDataSet.FieldByName('PARENTID').AsInteger := fParentID;
      fMasterDataSet.FieldByName('FLG_FOLDER').AsInteger := 0;
    end
    else
    begin
      // modify
      dtDialogTitle.Text := 'Изменение склада';

      fMasterDataSet.Edit;
    end;
    LoadStockUserGroups;
    UserGroupsSelectionChanged;

//    LoadFirmsInfo(dmDB.CurrentUserID, fMasterDataSet.FieldByName('EPORTID').AsInteger);
//    FirmsSelectionChanged;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;

    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmStockEditorDlg.LoadStockUserGroups;
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

procedure TfrmStockEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmStockEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmStockEditorDlg.UserGroupsSelectionChanged;
begin
  btnAddUserGroup.Enabled := cxGridAUGTable.Controller.SelectedRowCount > 0;
  btnRemoveUserGroup.Enabled := cxGridUserGroupsTable.Controller.SelectedRowCount > 0;
end;

procedure TfrmStockEditorDlg.SetupSecurityItems;
begin
  cxTabSheet2.TabVisible := False;
  if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Справочники_Склады_Права_пользователей) then
  begin
    tbsAccess.TabVisible := False;
  end;
end;

procedure TfrmStockEditorDlg.LoadFirmsInfo(const UserID, ReportID: integer);
var
  Query: TIBCQuery;
  custID, N: integer;
  firmaTitle: string;
begin
//  cxGridSelFirmsTable.DataController.BeginUpdate;
//  cxGridAvFirmsTable.DataController.BeginUpdate;
//
//  Query := TIBCQuery.Create(nil);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Add('SELECT CUSTOMERID, DISPLAYNAME,');
//    Query.SQL.Add('IIF(EXISTS(SELECT stockid FROM TS_REPORTS2_DT WHERE CUSTOMERID=F.CUSTOMERID AND REPORTID=:ReportID),1,0)');
//    Query.SQL.Add('FROM GET_FIRMS_BY_USER(:UserID) F');
//    Query.ParamByName('ReportID').AsInteger := ReportID;
//    Query.ParamByName('UserID').AsInteger := UserID;
//    Query.Open;
//    while not Query.Eof do
//    begin
//      custID := Query.Fields[0].AsInteger;
//      firmaTitle := Query.Fields[1].AsString;
//
//      if Query.Fields[2].AsInteger = 1 then
//      begin
//                  // firma este selectata
//        N := cxGridSelFirmsTable.DataController.AppendRecord;
//        cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_ID.Index] := custID;
//        cxGridSelFirmsTable.DataController.Values[N, cxGridSelFirms_TITLE.Index] := firmaTitle;
//      end
//      else
//      begin
//                  // firma este disponibila
//        N := cxGridAvFirmsTable.DataController.AppendRecord;
//        cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_ID.Index] := custID;
//        cxGridAvFirmsTable.DataController.Values[N, cxGridAvFirms_TITLE.Index] := firmaTitle;
//      end;
//
//      Query.Next;
//    end;
//    fFirmsChanged := False;
//  finally
//    Query.Free;
//
//    cxGridSelFirmsTable.DataController.EndUpdate;
//    cxGridAvFirmsTable.DataController.EndUpdate;
//  end;
end;

procedure TfrmStockEditorDlg.FirmsSelectionChanged;
begin
  btnAddFirms.Enabled := cxGridAvFirmsTable.Controller.SelectedRowCount > 0;
  btnRemoveFirms.Enabled := cxGridSelFirmsTable.Controller.SelectedRowCount > 0;
end;

procedure TfrmStockEditorDlg.SetStockAccessValue;
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

function TfrmStockEditorDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    SetStockAccessValue;

//          fQuickAccessReportsChanged:=fInitialQuickAccessFlagValue<>fMasterDataSet.FieldByName('FLG_QUICK_ACCESS').AsInteger;

    fMasterDataSet.Post;
//          if fReportTemplateLoaded and fReportTemplateChanged then SaveReportTemplate;
//          if fFirmsChanged then SaveReportFirms(dmDB.CurrentFirma, fMasterDataSet.FieldByName('REPORTID').AsInteger);
    fMasterDataSet.UpdateTransaction.Commit;
//          fReportTemplateChanged:=False;
    Result := True;
  end
  else
    Result := False;
end;

end.


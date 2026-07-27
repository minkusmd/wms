unit frmUserSettingsDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxStyles,
  cxCustomData, cxGridCustomTableView, cxGridTableView,
  cxControls, cxGridCustomView, cxGridLevel, cxGrid, DB, DBAccess, IBC, MemDS, cxButtonEdit, cxTextEdit,
  cxCheckBox, cxDBEdit, StdCtrls, cxDBLookupComboBox,
  cxPC, DialogTitle, cxTL, frmUserWorkHoursDlg,
  cxDBData, dxBar, cxGridDBTableView,
  cxLabel, frameCustomerEventsUnit, Vcl.Buttons,
  cxButtons, dxBarBuiltInMenu, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxFilter, cxData,
  cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, Vcl.Menus, cxClasses,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxImage, cxMemo, cxMaskEdit, cxCalendar, dxCoreGraphics, dxUIAClasses;

type
  TfrmUserSettingsDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pcPageControl: TcxPageControl;
    tbsGeneral: TcxTabSheet;
    tbsUserAccount: TcxTabSheet;
    tbsUserGroups: TcxTabSheet;
    tbsFirms: TcxTabSheet;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel5: TLabel;
    cxLabel6: TLabel;
    edUserFirstName: TcxDBTextEdit;
    edUserLastName: TcxDBTextEdit;
    edUserTelefon: TcxDBTextEdit;
    edUserEMail: TcxDBTextEdit;
    cxLabel9: TLabel;
    deUserBirthDay: TcxDBDateEdit;
    cxLabel8: TLabel;
    cxLabel7: TLabel;
    mmUserAddress: TcxDBMemo;
    cxLabel10: TLabel;
    edUserLoginName: TcxDBTextEdit;
    cxLabel12: TLabel;
    cxLabel11: TLabel;
    cxLabel14: TLabel;
    cbFlgActive: TcxDBCheckBox;
    cbFlgChangePass: TcxDBCheckBox;
    cbDefaultPassword: TcxCheckBox;
    lbUserWorkDaysInfo: TLabel;
    cxLabel15: TLabel;
    cxLabel16: TLabel;
    IBCQueryCities: TIBCQuery;
    IBCDataSourceCities: TIBCDataSource;
    tbsCustomer: TcxTabSheet;
    cxLabel17: TLabel;
    cxLabel19: TLabel;
    edDEFAULT_DT_NAME: TcxTextEdit;
    beCUSTOMER_DISPLAYNAME: TcxButtonEdit;
    cxGridUserGroupsLevel: TcxGridLevel;
    cxGridUserGroups: TcxGrid;
    cxGridUserGroupsTable: TcxGridTableView;
    cxGridUserGroups_IMAGE: TcxGridColumn;
    cxGridUserGroups_TITLE: TcxGridColumn;
    cxGridUserGroups_GROUPID: TcxGridColumn;
    cxGridAvailableUserGroups: TcxGrid;
    cxGridAUGTable: TcxGridTableView;
    cxGridAUG_IMAGE: TcxGridColumn;
    cxGridAUG_TITLE: TcxGridColumn;
    cxGridAUGLevel: TcxGridLevel;
    cxGridAUG_GROUPID: TcxGridColumn;
    cxGridUserFirms: TcxGrid;
    cxGridUserFirmsTable: TcxGridTableView;
    cxGridUserFirms_IMG: TcxGridColumn;
    cxGridUserFirms_TITLE: TcxGridColumn;
    cxGridUserFirms_FIRMAID: TcxGridColumn;
    cxGridUserFirmsLevel: TcxGridLevel;
    cxGridAUF: TcxGrid;
    cxGridAUFTable: TcxGridTableView;
    cxGridAUF_IMG: TcxGridColumn;
    cxGridAUF_TITLE: TcxGridColumn;
    cxGridAUF_FIRMAID: TcxGridColumn;
    cxGridAUFLevel: TcxGridLevel;
    cbFLG_ACTIVE_HOURS: TcxDBCheckBox;
    tbsSIP: TcxTabSheet;
    imgUserIMAGE: TcxDBImage;
    IBCQueryImage: TIBCQuery;
    IBCDataSourceImage: TIBCDataSource;
    Label2: TLabel;
    deREGISTER_DATE: TcxDBDateEdit;
    Label3: TLabel;
    lcbUSERTYPE_ID: TcxDBLookupComboBox;
    IBCQueryUserType: TIBCQuery;
    IBCDataSourceUserType: TIBCDataSource;
    Label4: TLabel;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbPeriodAdd: TdxBarButton;
    bbPeriodEdit: TdxBarButton;
    bbPeriodDelete: TdxBarButton;
    IBCQueryPeriods: TIBCQuery;
    IBCDataSourcePeriods: TIBCDataSource;
    cmbUserCity: TcxDBLookupComboBox;
    Label1: TLabel;
    cmbFUNCTIA_DETINUTA: TcxDBComboBox;
    cxLabel3: TLabel;
    mmUserDescription: TcxDBMemo;
    cxLabel13: TcxLabel;
    cxLabel18: TcxLabel;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxLabel22: TcxLabel;
    teServerIP: TcxDBTextEdit;
    teUser: TcxDBTextEdit;
    tePassword: TcxDBTextEdit;
    teSTUN: TcxDBTextEdit;
    teProxy: TcxDBTextEdit;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxGridComunications: TcxGridDBTableView;
    cxGridComLevel1: TcxGridLevel;
    cxGridCom: TcxGrid;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    bbComNew: TdxBarButton;
    bbComEdit: TdxBarButton;
    bbComDelete: TdxBarButton;
    cxGridComunicationsColumn1: TcxGridDBColumn;
    cxGridComunicationsColumn2: TcxGridDBColumn;
    cxGridComunicationsColumn3: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    Label5: TLabel;
    cxGridPlaces: TcxGrid;
    cxGridPlacesTable: TcxGridDBTableView;
    cxGridPlaces_START_DATE: TcxGridDBColumn;
    cxGridPlaces_END_DATE: TcxGridDBColumn;
    cxGridPlaces_DISPLAYNAME: TcxGridDBColumn;
    cxGridPlacesLevel: TcxGridLevel;
    tsPhones: TcxTabSheet;
    dxBarManager1Bar3: TdxBar;
    dxBarDockControl3: TdxBarDockControl;
    bbNewPhone: TdxBarButton;
    bbEditPhone: TdxBarButton;
    bbDeletePhone: TdxBarButton;
    tsPersonalData: TcxTabSheet;
    dxBarDockControl4: TdxBarDockControl;
    dxBarManager1Bar4: TdxBar;
    bbPDNew: TdxBarButton;
    bbPDEdit: TdxBarButton;
    bbPDDelete: TdxBarButton;
    cxGrid2: TcxGrid;
    cxGridDP: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    cxGridDP_TIPDOCUMENT: TcxGridDBColumn;
    cxGridDP_NUMAR_DOCUMENT: TcxGridDBColumn;
    cxGridDP_DATA_ELIBERARII: TcxGridDBColumn;
    cxGridDP_ELIBERAT_DE: TcxGridDBColumn;
    cxGridDP_SCAN: TcxGridDBColumn;
    cxTabSheet4: TcxTabSheet;
    dxBarManager1Bar5: TdxBar;
    frameCustomerEvents1: TframeCustomerEvents;
    SpeedButton1: TSpeedButton;
    imgUserSignature: TcxDBImage;
    Label6: TLabel;
    btnUserPassword: TcxButton;
    btnUserWorkHours: TcxButton;
    btnAddUserGroup: TcxButton;
    btnRemoveUserGroup: TcxButton;
    btnAddFirm: TcxButton;
    btnRemoveFirm: TcxButton;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    cbFLG_MONEY: TcxDBCheckBox;
    teIDNO: TcxDBTextEdit;
    Label7: TLabel;
    Label8: TLabel;
    teBuletinNo: TcxDBTextEdit;
    Label9: TLabel;
    deBuletinDate: TcxDBDateEdit;
    procedure btnUserWorkHoursClick(Sender: TObject);
    procedure btnUserPasswordClick(Sender: TObject);
    procedure cxUserGroupsFocusedNodeChanged(Sender: TObject; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure btnAddUserGroupClick(Sender: TObject);
    procedure btnRemoveUserGroupClick(Sender: TObject);
    procedure btnAddFirmClick(Sender: TObject);
    procedure btnRemoveFirmClick(Sender: TObject);
    procedure pcPageControlChange(Sender: TObject);
    procedure edDEFAULT_DT_NAMEDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure edDEFAULT_DT_NAMEDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure beCUSTOMER_DISPLAYNAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridUserGroupsTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridUserFirmsTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure cxGridAUFTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
      TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridUserFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAUFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAUGTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridUserGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
      TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cbFLG_ACTIVE_HOURSPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridPlacesTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord:
      TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbPeriodAddClick(Sender: TObject);
    procedure bbPeriodEditClick(Sender: TObject);
    procedure bbPeriodDeleteClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    fUserWorkWeek: TUserWorkWeek;
    fPasswordHASH: string;
    fUserGroups: TList;
    fUserGroupsChanged: Boolean;
    fUserFirms: TList;
    FCreateNewUser: Boolean;
    function CheckParams: Boolean;
    procedure UserGroupSelectionChanged;
    procedure CreateDefaultPassword;
    procedure ShowUserWorkHoursDialog;
    procedure LoadUserWorkWeek(const UserID: Integer);
    procedure SaveUserWorkingHours(const UserID: Integer);
    procedure WhenUserWorkWeekChanged(Sender: TObject);
    procedure ShowUserPasswordDialog;
    procedure LoadUserGroups(const UserID: Integer);
    procedure ClearUserGroups;
    function GetUserGroupByID(const GroupID: Integer): TObject;
    procedure AddSelectedUserGroup;
    procedure RemoveSelectedUserGroup;
    procedure SaveUserGroups(const UserID: Integer);
    procedure UserFirmSelectionChanged;
    procedure ReadFirms;
    procedure ClearUserFirms;
    procedure AddSelectedUserFirm;
    procedure RemoveSelectedUserFirm;
    procedure CalculateAccFirms;
    procedure SetCreateNewUser(const Value: Boolean);
    function GetUserFirmByID(const FirmaID: Integer): TObject;
    procedure ShowSelectCustomerDialog;
    procedure CreateUserDefaultWorkHours;
    procedure FirmePeriodSelectionChanged;
    procedure ShowAddNewFirmePeriodDialog;
    procedure ShowModifyFirmePeriodDialog;
    procedure DeleteFirmePeriod;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    destructor Destroy; override;
    property CreateNewUser: Boolean read FCreateNewUser write SetCreateNewUser;
  end;

implementation

uses
  SWNUtils, SWNSecurityUtils, frmPasswordDlg, DataModuleAdditions, SWNConst, frmCustomersDlg, DataModuleDB,
  frmUsersFirmePeriodEditorDialog;

{$R *.dfm}

type
  TUserGroupItem = class
  private
    fGroupID: Integer;
    fTitle: string;
    // new
    fUserInGroup: Boolean;
    constructor Create(const GroupID: Integer; const Title: string);
  end;

  TUserFirmItem = class
  private
    fIndex: Integer;
    fCustomerID: Integer;
    fDisplayName: string;
    // new
    fUserInFirm: Boolean;
    constructor Create(const Index, CustomerID: Integer; const DisplayName: string);
  end;

  { TfrmUserSettingsDialog }

procedure TfrmUserSettingsDialog.AddSelectedUserFirm;
var
  UserFirm: TUserFirmItem;
  i, N: Integer;
begin
  cxGridUserFirmsTable.DataController.ClearSelection;

  for i := cxGridAUFTable.DataController.RecordCount - 1 downto 0 do
    if cxGridAUFTable.DataController.IsRowSelected(cxGridAUFTable.DataController.GetRowIndexByRecordIndex(i, False)) then
    begin
      UserFirm := TUserFirmItem(GetUserFirmByID(cxGridAUFTable.DataController.Values[i, cxGridAUF_FIRMAID.Index]));
      if Assigned(UserFirm) then
      begin
        N := cxGridUserFirmsTable.DataController.AppendRecord;
        cxGridUserFirmsTable.DataController.Values[N, cxGridUserFirms_TITLE.Index] := UserFirm.fDisplayName;
        cxGridUserFirmsTable.DataController.Values[N, cxGridUserFirms_FIRMAID.Index] := UserFirm.fCustomerID;
      end;
    end;

  cxGridAUFTable.DataController.DeleteSelection;

  // Фирма по умолчанию
  if (cxGridUserFirmsTable.DataController.RecordCount = 1) and (fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger = -1) then
  begin
    UserFirm := TUserFirmItem(GetUserFirmByID(cxGridUserFirmsTable.DataController.Values[0, cxGridUserFirms_FIRMAID.Index]));
    if Assigned(UserFirm) then
    begin
      fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger := UserFirm.fCustomerID;
      edDEFAULT_DT_NAME.Text := dmDB.GetCustomerDisplayName(UserFirm.fCustomerID);
    end;
  end;
end;

procedure TfrmUserSettingsDialog.AddSelectedUserGroup;
var
  UserGroup: TUserGroupItem;
  i, N: Integer;
begin
  cxGridAUGTable.BeginUpdate;
  cxGridUserGroupsTable.BeginUpdate;
  try
    cxGridUserGroupsTable.DataController.ClearSelection;

    for i := cxGridAUGTable.DataController.RecordCount - 1 downto 0 do
      if cxGridAUGTable.DataController.IsRowSelected(cxGridAUGTable.DataController.GetRowIndexByRecordIndex(i, False)) then
      begin
        UserGroup := TUserGroupItem(GetUserGroupByID(cxGridAUGTable.DataController.Values[i, cxGridAUG_GROUPID.Index]));
        if Assigned(UserGroup) then
        begin
          N := cxGridUserGroupsTable.DataController.AppendRecord;
          cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := UserGroup.fTitle;
          cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := UserGroup.fGroupID;
          {
            cxGridUserGroupsTable.DataController.MakeRecordVisible(N);

            N:=cxGridUserGroupsTable.DataController.GetRowIndexByRecordIndex(N,True);
            cxGridUserGroupsTable.DataController.SelectRows(N,N);
          }
        end;
        fUserGroupsChanged := True;
      end;
    cxGridAUGTable.DataController.DeleteSelection;
  finally
    cxGridUserGroupsTable.EndUpdate;
    cxGridAUGTable.EndUpdate;
  end;
end;

procedure TfrmUserSettingsDialog.bbPeriodAddClick(Sender: TObject);
begin
  ShowAddNewFirmePeriodDialog;
end;

procedure TfrmUserSettingsDialog.bbPeriodDeleteClick(Sender: TObject);
begin
  DeleteFirmePeriod;
end;

procedure TfrmUserSettingsDialog.bbPeriodEditClick(Sender: TObject);
begin
  ShowModifyFirmePeriodDialog;
end;

procedure TfrmUserSettingsDialog.beCUSTOMER_DISPLAYNAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0:
      ShowSelectCustomerDialog;
    1:
      begin
        fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := -1;
        beCUSTOMER_DISPLAYNAME.Text := '';
      end;
  end;

end;

procedure TfrmUserSettingsDialog.btnAddFirmClick(Sender: TObject);
begin
  AddSelectedUserFirm;
end;

procedure TfrmUserSettingsDialog.btnAddUserGroupClick(Sender: TObject);
begin
  AddSelectedUserGroup;
end;

procedure TfrmUserSettingsDialog.btnRemoveFirmClick(Sender: TObject);
begin
  RemoveSelectedUserFirm;
end;

procedure TfrmUserSettingsDialog.btnRemoveUserGroupClick(Sender: TObject);
begin
  RemoveSelectedUserGroup;
end;

procedure TfrmUserSettingsDialog.btnUserPasswordClick(Sender: TObject);
begin
  ShowUserPasswordDialog;
end;

procedure TfrmUserSettingsDialog.btnUserWorkHoursClick(Sender: TObject);
begin
  ShowUserWorkHoursDialog;
end;

procedure TfrmUserSettingsDialog.CalculateAccFirms;
var
  accFirms: int64;
  i: Integer;
  UserFirm: TUserFirmItem;
begin
  accFirms := 0;
  for i := 0 to cxGridUserFirmsTable.DataController.RecordCount - 1 do
  begin
    UserFirm := TUserFirmItem(GetUserFirmByID(cxGridUserFirmsTable.DataController.Values[i, cxGridUserFirms_FIRMAID.Index]));
    if Assigned(UserFirm) then
      SetAccessBit(accFirms, UserFirm.fIndex, True);
  end;
  fMasterDataSet.FieldByName('ACC$FIRM').NewValue := accFirms;
end;

procedure TfrmUserSettingsDialog.cbFLG_ACTIVE_HOURSPropertiesEditValueChanged(Sender: TObject);
begin
  if fMasterDataSet.FieldByName('FLG_ACTIVE_HOURS').AsInteger = 1 then
  begin
    CreateUserDefaultWorkHours;
    btnUserWorkHours.Enabled := True;
  end
  else
  begin
    fUserWorkWeek.Clear;
    btnUserWorkHours.Enabled := False;
  end;
end;

function TfrmUserSettingsDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';
  if fMasterDataSet.FieldByName('FIRST_NAME').IsNull or (Trim(fMasterDataSet.FieldByName('FIRST_NAME').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Имя.');
  if fMasterDataSet.FieldByName('LAST_NAME').IsNull or (Trim(fMasterDataSet.FieldByName('LAST_NAME').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Фамилия.');
  if fMasterDataSet.FieldByName('BIRTHDAY').IsNull then
    AddErrorToStr(ErrorStr, 'Дата рождения.');
  if fMasterDataSet.FieldByName('CITY_ID').IsNull then
    AddErrorToStr(ErrorStr, 'Город проживания.');

  if fMasterDataSet.FieldByName('LOGIN_NAME').IsNull or (Trim(fMasterDataSet.FieldByName('LOGIN_NAME').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Имя учетной записи.');

  if fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger = -1 then
    AddErrorToStr(ErrorStr, 'Фирма по умолчанию.');

  if (fMasterDataSet.FieldByName('USERTYPE_ID').IsNull) or (fMasterDataSet.FieldByName('USERTYPE_ID').AsInteger = -1) then
    AddErrorToStr(ErrorStr, 'Тип пользователя!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmUserSettingsDialog.ClearUserFirms;
var
  i: Integer;
begin
  for i := 0 to fUserFirms.Count - 1 do
    TUserFirmItem(fUserFirms[i]).Free;
  fUserFirms.Clear;
end;

procedure TfrmUserSettingsDialog.ClearUserGroups;
var
  i: Integer;
begin
  for i := 0 to fUserGroups.Count - 1 do
    TUserGroupItem(fUserGroups[i]).Free;
  fUserGroups.Clear;
end;

procedure TfrmUserSettingsDialog.CreateDefaultPassword;
var
  lastName, firstName: string;
begin
  // default password: FIRST_NAME+'.'+LAST_NAME
  firstName := fMasterDataSet.FieldByName('FIRST_NAME').AsString;
  lastName := fMasterDataSet.FieldByName('LAST_NAME').AsString;

  fPasswordHASH := CreateHashPassword(Format('%s.%s', [firstName, lastName]));
end;

procedure TfrmUserSettingsDialog.CreateUserDefaultWorkHours;
begin
  fUserWorkWeek.Clear;
  fUserWorkWeek.AddDay(1, 8, 9, 19, 20);
  fUserWorkWeek.AddDay(2, 8, 9, 19, 20);
  fUserWorkWeek.AddDay(3, 8, 9, 19, 20);
  fUserWorkWeek.AddDay(4, 8, 9, 19, 20);
  fUserWorkWeek.AddDay(5, 8, 9, 19, 20);
  fUserWorkWeek.AddDay(6, 9, 10, 17, 18);
  fUserWorkWeek.AddDay(7, 9, 10, 17, 18);
end;

procedure TfrmUserSettingsDialog.cxGridAUFTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddSelectedUserFirm;
end;

procedure TfrmUserSettingsDialog.cxGridAUFTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord:
  TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if ARecord.Values[cxGridAUF_FIRMAID.Index] = dmDB.CurrentFirma then
    AStyle := dmAdditions.cxStyle_Bold;
end;

procedure TfrmUserSettingsDialog.cxGridAUGTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddSelectedUserGroup;
end;

procedure TfrmUserSettingsDialog.cxGridPlacesTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  FirmePeriodSelectionChanged;
end;

procedure TfrmUserSettingsDialog.cxGridUserFirmsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  RemoveSelectedUserFirm;
end;

procedure TfrmUserSettingsDialog.cxGridUserFirmsTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserFirmSelectionChanged;
end;

procedure TfrmUserSettingsDialog.cxGridUserGroupsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
  TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  RemoveSelectedUserGroup;
end;

procedure TfrmUserSettingsDialog.cxGridUserGroupsTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
  UserGroupSelectionChanged;
end;

procedure TfrmUserSettingsDialog.cxUserGroupsFocusedNodeChanged(Sender: TObject; APrevFocusedNode, AFocusedNode:
  TcxTreeListNode);
begin
  UserGroupSelectionChanged;
end;

procedure TfrmUserSettingsDialog.DeleteFirmePeriod;
begin
  if ShowAskDialog('Удаление периода работы', Format('Удалить период в фирме "%s"?', [IBCQueryPeriods.FieldByName('DISPLAYNAME').AsString]))
    = mrYes then
    IBCQueryPeriods.Delete;
end;

destructor TfrmUserSettingsDialog.Destroy;
begin
  ClearUserGroups;
  ClearUserFirms;

  fUserWorkWeek.Free;

  fUserGroups.Free;
  fUserFirms.Free;

  inherited;
end;

procedure TfrmUserSettingsDialog.edDEFAULT_DT_NAMEDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  UserFirm: TUserFirmItem;
begin
  if (Source is TcxDragControlObject) and (cxGridUserFirmsTable.DataController.GetSelectedCount = 1) then
  begin
    UserFirm := TUserFirmItem(GetUserFirmByID(cxGridUserFirmsTable.DataController.Values[cxGridUserFirmsTable.DataController.FocusedRecordIndex,
      cxGridUserFirms_FIRMAID.Index]));
    if Assigned(UserFirm) then
    begin
      fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger := UserFirm.fCustomerID;
      edDEFAULT_DT_NAME.Text := dmDB.GetCustomerDisplayName(UserFirm.fCustomerID);
      cxGridUserFirmsTable.DataController.Refresh;
    end;
  end;
end;

procedure TfrmUserSettingsDialog.edDEFAULT_DT_NAMEDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Source is TcxDragControlObject) and (cxGridUserFirmsTable.DataController.GetSelectedCount = 1);
end;

procedure TfrmUserSettingsDialog.FirmePeriodSelectionChanged;
var
  fAdd, fEdit, fDelete: Boolean;
begin
  fAdd := True;
  fEdit := False;
  fDelete := False;
  if (cxGridPlacesTable.DataController.RecNo > 0) then
  begin
    fEdit := True;
    fDelete := True;
  end;
  bbPeriodAdd.Enabled := fAdd;
  bbPeriodEdit.Enabled := fEdit;
  bbPeriodDelete.Enabled := fDelete;
end;

function TfrmUserSettingsDialog.GetUserFirmByID(const FirmaID: Integer): TObject;
var
  i: Integer;
  UserFirm: TUserFirmItem;
begin
  Result := nil;
  for i := 0 to fUserFirms.Count - 1 do
  begin
    UserFirm := TUserFirmItem(fUserFirms[i]);
    if UserFirm.fCustomerID = FirmaID then
    begin
      Result := UserFirm;
      Break;
    end;
  end;
end;

function TfrmUserSettingsDialog.GetUserGroupByID(const GroupID: Integer): TObject;
var
  i: Integer;
  UserGroup: TUserGroupItem;
begin
  Result := nil;
  for i := 0 to fUserGroups.Count - 1 do
  begin
    UserGroup := TUserGroupItem(fUserGroups[i]);
    if UserGroup.fGroupID = GroupID then
    begin
      Result := UserGroup;
      Break;
    end;
  end;
end;

procedure TfrmUserSettingsDialog.BindingDataSource;
begin
  inherited;

  FCreateNewUser := False;

  fUserGroups := TList.Create;
  fUserFirms := TList.Create;

  fUserWorkWeek := TUserWorkWeek.Create;
  fUserWorkWeek.OnChange := WhenUserWorkWeekChanged;

  IBCQueryImage.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryImage.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryImage.MasterSource := fMasterDataSource;

  IBCQueryPeriods.Transaction := fMasterDataSet.UpdateTransaction;
  IBCQueryPeriods.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryPeriods.MasterSource := fMasterDataSource;

  // setup fields link to db
  edUserFirstName.DataBinding.DataSource := fMasterDataSource;
  edUserLastName.DataBinding.DataSource := fMasterDataSource;
  edUserTelefon.DataBinding.DataSource := fMasterDataSource;
  edUserEMail.DataBinding.DataSource := fMasterDataSource;
  deUserBirthDay.DataBinding.DataSource := fMasterDataSource;
  cmbUserCity.DataBinding.DataSource := fMasterDataSource;
  mmUserDescription.DataBinding.DataSource := fMasterDataSource;
  mmUserAddress.DataBinding.DataSource := fMasterDataSource;
  edUserLoginName.DataBinding.DataSource := fMasterDataSource;
  cbFlgActive.DataBinding.DataSource := fMasterDataSource;
  cbFlgChangePass.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACTIVE_HOURS.DataBinding.DataSource := fMasterDataSource;
  cmbFUNCTIA_DETINUTA.DataBinding.DataSource := fMasterDataSource;
  deREGISTER_DATE.DataBinding.DataSource := fMasterDataSource;
  lcbUSERTYPE_ID.DataBinding.DataSource := fMasterDataSource;

  teServerIP.DataBinding.DataSource := fMasterDataSource;
  teUser.DataBinding.DataSource := fMasterDataSource;
  tePassword.DataBinding.DataSource := fMasterDataSource;
  teSTUN.DataBinding.DataSource := fMasterDataSource;
  teProxy.DataBinding.DataSource := fMasterDataSource;

  cbFLG_MONEY.DataBinding.DataSource := fMasterDataSource;

  teBuletinNo.DataBinding.DataSource := fMasterDataSource;
  teIDNO.DataBinding.DataSource := fMasterDataSource;
  deBuletinDate.DataBinding.DataSource := fMasterDataSource;

  pcPageControl.ActivePageIndex := 0;

end;

function TfrmUserSettingsDialog.IsFormDataPosted: Boolean;
var
  UserID: Integer;
  oldPassHash: string;
begin
  if CheckParams then
  begin
    oldPassHash := fMasterDataSet.FieldByName('PASSWORD_HASH').AsString;
    if cbDefaultPassword.Checked then
      CreateDefaultPassword;
    if fPasswordHASH <> oldPassHash then
    begin
      fMasterDataSet.FieldByName('PASSWORD_HASH').AsString := fPasswordHASH;
      fMasterDataSet.FieldByName('LAST_PASSWORD_CHANGE').AsDateTime := NOW;
    end;
    CalculateAccFirms;

    // POST
    fMasterDataSet.Post;

    UserID := fMasterDataSet.FieldByName('USERID').AsInteger;
    // get new/current USERID

    if (fMasterDataSet.FieldByName('FLG_ACTIVE_HOURS').AsInteger = 0) and (fUserWorkWeek.Count > 0) then
      fUserWorkWeek.Clear;
    if fUserWorkWeek.HasChanged then
      SaveUserWorkingHours(UserID);
    if fUserGroupsChanged then
      SaveUserGroups(UserID);

    if IBCQueryImage.State in dsEditModes then
      IBCQueryImage.Post;

    // comit chnages
    fMasterDataSet.UpdateTransaction.Commit;

    // done
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmUserSettingsDialog.LoadUserGroups(const UserID: Integer);
var
  Query: TIBCQuery;
  UserGroup: TUserGroupItem;
  i, N: Integer;
begin
  Query := TIBCQuery.Create(nil);

  cxGridUserGroupsTable.DataController.BeginUpdate;
  cxGridAUGTable.DataController.BeginUpdate;
  try
    Query.Connection := fMasterDataSet.Connection;
    // load Group list
    Query.SQL.Text := 'SELECT GROUPID, NAME FROM TS_USER_GROUPS ORDER BY GROUPID';
    Query.ExecSQL;
    while not Query.Eof do
    begin
      UserGroup := TUserGroupItem.Create(Query.Fields[0].AsInteger, Query.Fields[1].AsString);
      fUserGroups.Add(UserGroup);
      Query.Next;
    end;
    Query.Close;

    // load user's groups
    Query.SQL.Text := 'SELECT GROUPID FROM TS_USER_GROUP_LINKS WHERE (USERID=:UserID)';
    Query.ParamByName('UserID').AsInteger := UserID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      UserGroup := TUserGroupItem(GetUserGroupByID(Query.Fields[0].AsInteger));
      if Assigned(UserGroup) then
      begin
        UserGroup.fUserInGroup := True;
        N := cxGridUserGroupsTable.DataController.AppendRecord;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := UserGroup.fTitle;
        cxGridUserGroupsTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := UserGroup.fGroupID;
      end;
      Query.Next;
    end;
    Query.Close;

    // show available groups
    for i := 0 to fUserGroups.Count - 1 do
    begin
      UserGroup := fUserGroups[i];
      if not UserGroup.fUserInGroup then
      begin
        N := cxGridAUGTable.DataController.AppendRecord;
        cxGridAUGTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := UserGroup.fTitle;
        cxGridAUGTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := UserGroup.fGroupID;
      end;
    end;

  finally
    fUserGroupsChanged := False;
    Query.Free;

    cxGridUserGroupsTable.DataController.EndUpdate;
    cxGridAUGTable.DataController.EndUpdate;

    UserGroupSelectionChanged;
  end;

end;

procedure TfrmUserSettingsDialog.LoadUserWorkWeek(const UserID: Integer);
var
  Query: TIBCQuery;
begin
  fUserWorkWeek.Clear;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.SQL.Text :=
      'SELECT DayIndex, ACCESS_START_HOUR, Start_Hour, End_Hour, ACCESS_END_HOUR FROM TS_USER_WORKHOURS WHERE (USERID=:UserID)';
    Query.ParamByName('UserID').AsInteger := UserID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      fUserWorkWeek.AddDay(Query.Fields[0].AsInteger, Query.Fields[1].AsInteger, Query.Fields[2].AsInteger, Query.Fields
        [3].AsInteger, Query.Fields[4].AsInteger);
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
  fUserWorkWeek.MarkChangePoint;
end;

procedure TfrmUserSettingsDialog.pcPageControlChange(Sender: TObject);
var
  lastName, firstName: ShortString;
begin
  if (pcPageControl.ActivePage = tbsUserAccount) then
  begin
    lastName := WideStringToString(fMasterDataSet.FieldByName('LAST_NAME').AsString, CP_ACP);
    firstName := WideStringToString(fMasterDataSet.FieldByName('FIRST_NAME').AsString, CP_ACP);

    if (fMasterDataSet.FieldByName('LOGIN_NAME').IsNull or (fMasterDataSet.FieldByName('LOGIN_NAME').AsString = '')) then
    begin
      // create default user name
      fMasterDataSet.FieldByName('LOGIN_NAME').AsString := Format('%s %s', [firstName, lastName]);
    end;

    if (fMasterDataSet.FieldByName('EMAIL').IsNull or (fMasterDataSet.FieldByName('EMAIL').AsString = '')) then
    begin
      // create default EMail
      fMasterDataSet.FieldByName('EMAIL').AsString := LowerCase(Format('%s.%s@mail.md', [lastName, firstName]));
    end;
  end;
end;

procedure TfrmUserSettingsDialog.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    // read data
    IBCQueryCities.Active := True;
    IBCQueryImage.Active := True;
    IBCQueryUserType.Active := True;
    frameCustomerEvents1.CustomerID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
    frameCustomerEvents1.Connection := dmDB.IBCConnection;
    if FCreateNewUser then
    begin
      // new record
      fMasterDataSet.Insert;
      // set default values

      fMasterDataSet.FieldByName('ACC$FIRM').AsInteger := 0;
      fMasterDataSet.FieldByName('PASSWORD_HASH').AsString := '';
      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := -1;

      fMasterDataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_CHANGE_PSWD').AsInteger := 1;

      // fMasterDataSet.FieldByName('BIRTHDAY').AsDateTime:=NOW;
      fMasterDataSet.FieldByName('CITY_ID').AsInteger := 2000;

      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := 286;
      fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger := -1;

      fMasterDataSet.FieldByName('FLG_ACTIVE_HOURS').AsInteger := 1;

      fMasterDataSet.FieldByName('USERTYPE_ID').AsInteger := 7001;

      cbDefaultPassword.Checked := True;

      beCUSTOMER_DISPLAYNAME.Text := '';
      edDEFAULT_DT_NAME.Text := '';
    end
    else
    begin
          // edit record
          fMasterDataSet.Edit;

          fPasswordHASH := fMasterDataSet.FieldByName('PASSWORD_HASH').AsString;
          beCUSTOMER_DISPLAYNAME.Text := fMasterDataSet.FieldByName('CUSTOMER_DISPLAYNAME').AsString;
          edDEFAULT_DT_NAME.Text := fMasterDataSet.FieldByName('DEFAULT_DT_NAME').AsString;
          LoadUserWorkWeek(fMasterDataSet.FieldByName('USERID').AsInteger);
    end;

    ReadFirms;
    LoadUserGroups(fMasterDataSet.FieldByName('UserID').AsInteger);

    IBCQueryImage.Active := True;
    IBCQueryPeriods.Active := True;

    FirmePeriodSelectionChanged;

  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmUserSettingsDialog.ReadFirms;
var
  Query: TIBCQuery;
  UserFirm: TUserFirmItem;
  AccFirm: int64;
  i, Index, N: Integer;
begin
  if fMasterDataSet.FieldByName('ACC$FIRM').IsNull then
    AccFirm := 0
  else
    AccFirm := fMasterDataSet.FieldByName('ACC$FIRM').Value;

  Query := TIBCQuery.Create(nil);
  cxGridUserFirmsTable.DataController.BeginUpdate;
  cxGridAUFTable.DataController.BeginUpdate;
  try
    Query.SQL.Text := 'select CUSTOMERID, DISPLAYNAME from VW_TS_FIRMS ORDER BY CUSTOMERID';
    Query.Connection := fMasterDataSet.Connection;
    Query.ExecSQL;
    Index := 1;
    while not Query.Eof do
    begin
      UserFirm := TUserFirmItem.Create(Index, Query.FieldByName('CUSTOMERID').AsInteger, Query.FieldByName('DISPLAYNAME').AsString);
      fUserFirms.Add(UserFirm);
      UserFirm.fUserInFirm := ((AccFirm shr Index) and 1) = 1;
      Query.Next;
      Inc(Index);
    end;
    Query.Close;

    for i := 0 to fUserFirms.Count - 1 do
    begin
      UserFirm := TUserFirmItem(fUserFirms[i]);
      if UserFirm.fUserInFirm then
      begin
        N := cxGridUserFirmsTable.DataController.AppendRecord;
        cxGridUserFirmsTable.DataController.Values[N, cxGridUserFirms_TITLE.Index] := UserFirm.fDisplayName;
        cxGridUserFirmsTable.DataController.Values[N, cxGridUserFirms_FIRMAID.Index] := UserFirm.fCustomerID;
      end
      else
      begin
        N := cxGridAUFTable.DataController.AppendRecord;
        cxGridAUFTable.DataController.Values[N, cxGridAUF_TITLE.Index] := UserFirm.fDisplayName;
        cxGridAUFTable.DataController.Values[N, cxGridAUF_FIRMAID.Index] := UserFirm.fCustomerID;
      end;
    end;

  finally
    cxGridAUFTable.DataController.EndUpdate;
    cxGridUserFirmsTable.DataController.EndUpdate;
    Query.Free;
    UserFirmSelectionChanged;
  end;
end;

procedure TfrmUserSettingsDialog.RemoveSelectedUserFirm;
var
  UserFirm: TUserFirmItem;
  i, N: Integer;
begin
  cxGridAUFTable.DataController.ClearSelection;

  for i := cxGridUserFirmsTable.DataController.RecordCount - 1 downto 0 do
    if cxGridUserFirmsTable.DataController.IsRowSelected(cxGridUserFirmsTable.DataController.GetRowIndexByRecordIndex(i,
      False)) then
    begin
      UserFirm := TUserFirmItem(GetUserFirmByID(cxGridUserFirmsTable.DataController.Values[i, cxGridUserFirms_FIRMAID.Index]));
      if Assigned(UserFirm) then
      begin
        N := cxGridAUFTable.DataController.AppendRecord;
        cxGridAUFTable.DataController.Values[N, cxGridUserFirms_TITLE.Index] := UserFirm.fDisplayName;
        cxGridAUFTable.DataController.Values[N, cxGridUserFirms_FIRMAID.Index] := UserFirm.fCustomerID;

        if UserFirm.fCustomerID = fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger then
        begin
          fMasterDataSet.FieldByName('DEFAULT_DT').AsInteger := -1;
          edDEFAULT_DT_NAME.Text := '';
        end;
      end;
    end;

  cxGridUserFirmsTable.DataController.DeleteSelection;
end;

procedure TfrmUserSettingsDialog.RemoveSelectedUserGroup;
var
  i, N: Integer;
  UserGroup: TUserGroupItem;
begin
  cxGridUserGroupsTable.BeginUpdate;
  cxGridAUGTable.BeginUpdate;
  try
    cxGridAUGTable.DataController.ClearSelection;

    for i := cxGridUserGroupsTable.DataController.RecordCount - 1 downto 0 do
      if cxGridUserGroupsTable.DataController.IsRowSelected(cxGridUserGroupsTable.DataController.GetRowIndexByRecordIndex
        (i, False)) then
      begin
        UserGroup := TUserGroupItem(GetUserGroupByID(cxGridUserGroupsTable.DataController.Values[i,
          cxGridUserGroups_GROUPID.Index]));
        if Assigned(UserGroup) then
        begin
          N := cxGridAUGTable.DataController.AppendRecord;
          cxGridAUGTable.DataController.Values[N, cxGridUserGroups_TITLE.Index] := UserGroup.fTitle;
          cxGridAUGTable.DataController.Values[N, cxGridUserGroups_GROUPID.Index] := UserGroup.fGroupID;
        end;
        fUserGroupsChanged := True;
      end;
    cxGridUserGroupsTable.DataController.DeleteSelection;
  finally
    cxGridAUGTable.EndUpdate;
    cxGridUserGroupsTable.EndUpdate;
  end;
end;

procedure TfrmUserSettingsDialog.SaveUserGroups(const UserID: Integer);
var
  Query: TIBCQuery;
  UserGroup: TUserGroupItem;
  i: Integer;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fMasterDataSet.Connection;
    // use current update transaction
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Text := 'DELETE FROM TS_USER_GROUP_LINKS WHERE (USERID=:UserID)';
    Query.ParamByName('UserID').AsInteger := UserID;
    Query.ExecSQL;
    // 2. insert new
    if cxGridUserGroupsTable.DataController.RecordCount > 0 then
    begin
      Query.SQL.Text := 'INSERT INTO TS_USER_GROUP_LINKS (GROUPID,USERID) VALUES (:GroupID,:UserID)';
      Query.ParamByName('UserID').AsInteger := UserID;
      for i := 0 to cxGridUserGroupsTable.DataController.RecordCount - 1 do
      begin
        UserGroup := TUserGroupItem(GetUserGroupByID(cxGridUserGroupsTable.DataController.Values[i,
          cxGridUserGroups_GROUPID.Index]));
        if Assigned(UserGroup) then
        begin
          Query.ParamByName('GroupID').AsInteger := UserGroup.fGroupID;
          Query.ExecSQL;
        end;
      end;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserSettingsDialog.SaveUserWorkingHours(const UserID: Integer);
var
  Query: TIBCQuery;
  i: Integer;
  uwh: TUserWorkHourDay;
begin
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    // clear old values
    Query.SQL.Text := 'DELETE FROM TS_USER_WORKHOURS WHERE (USERID=:UserID)';
    Query.ParamByName('UserID').AsInteger := UserID;
    Query.ExecSQL;
    // insert new values
    Query.SQL.Text :=
      'INSERT INTO TS_USER_WORKHOURS (USERID, DAYINDEX, ACCESS_START_HOUR, START_HOUR, END_HOUR, ACCESS_END_HOUR) VALUES (:UserID,:DayIndex,:AccStart,:Start,:End,:AccEnd)';
    Query.ParamByName('UserID').AsInteger := UserID;
    for i := 0 to fUserWorkWeek.Count - 1 do
    begin
      uwh := fUserWorkWeek.Day[i];
      Query.ParamByName('DayIndex').AsInteger := uwh.DayIndex;
      Query.ParamByName('Start').AsInteger := uwh.WorkStartHour;
      Query.ParamByName('End').AsInteger := uwh.WorkEndHour;
      Query.ParamByName('AccStart').AsInteger := uwh.AccessStartHour;
      Query.ParamByName('AccEnd').AsInteger := uwh.AccessEndHour;
      Query.ExecSQL;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserSettingsDialog.SetCreateNewUser(const Value: Boolean);
begin
  FCreateNewUser := Value;
end;

procedure TfrmUserSettingsDialog.ShowAddNewFirmePeriodDialog;
var
  dialog: TfrmUsersFirmePeriodEditorDlg;
begin
  dialog := TfrmUsersFirmePeriodEditorDlg.Create(Self, IBCQueryPeriods, IBCDataSourcePeriods);
  try
    dialog.CreateNewRecord := True;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserSettingsDialog.ShowModifyFirmePeriodDialog;
var
  dialog: TfrmUsersFirmePeriodEditorDlg;
begin
  dialog := TfrmUsersFirmePeriodEditorDlg.Create(Self, IBCQueryPeriods, IBCDataSourcePeriods);
  try
    dialog.CreateNewRecord := False;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserSettingsDialog.ShowSelectCustomerDialog;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    // dialog.CustomFilter:=[cfColaboratori];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger, False, 0, '') then
    begin
      if (dialog.CustomerTypeID = 4006) or (dialog.CustomerTypeID = 4007) then
      begin
        fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := dialog.CustomerID;
        beCUSTOMER_DISPLAYNAME.Text := dialog.CustomerTitle;
      end
      else
        ShowErrorDialog('Ошибка', 'Только контрагент со статусом "Сотрудники"!');
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserSettingsDialog.ShowUserPasswordDialog;
var
  dialog: TfrmPasswordDialog;
begin
  dialog := TfrmPasswordDialog.Create(Self, pdmNewPassword);
  try
    if dialog.ShowModal = mrOk then
    begin
      fPasswordHASH := CreateHashPassword(dialog.Password);
      cbDefaultPassword.Checked := False;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserSettingsDialog.ShowUserWorkHoursDialog;
var
  dialog: TfrmUserWorkHoursDialog;
begin
  dialog := TfrmUserWorkHoursDialog.Create(Self, fUserWorkWeek);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmUserSettingsDialog.SpeedButton1Click(Sender: TObject);
begin
  fMasterDataSet.FieldByName('SIP_SRV_ADRESS').AsString := '192.168.104.254';
end;

procedure TfrmUserSettingsDialog.UserFirmSelectionChanged;
begin
  btnAddFirm.Enabled := cxGridAUFTable.DataController.GetSelectedCount > 0;
  btnRemoveFirm.Enabled := cxGridUserFirmsTable.DataController.GetSelectedCount > 0;
end;

procedure TfrmUserSettingsDialog.UserGroupSelectionChanged;
begin
  btnAddUserGroup.Enabled := cxGridAUGTable.DataController.GetSelectedCount > 0;
  btnRemoveUserGroup.Enabled := cxGridUserGroupsTable.DataController.GetSelectedCount > 0;
end;

procedure TfrmUserSettingsDialog.WhenCancelForm;
begin
  IBCQueryImage.Cancel;
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmUserSettingsDialog.WhenUserWorkWeekChanged(Sender: TObject);
begin
  if fUserWorkWeek.Count = 0 then
  begin
    lbUserWorkDaysInfo.Caption := 'Часы доступа и работы не заданны!';
    lbUserWorkDaysInfo.Font.Color := clGrayText;
  end
  else
  begin
    lbUserWorkDaysInfo.Caption := Format('Рабочих дней: %d, всего часов: %d.', [fUserWorkWeek.Count, fUserWorkWeek.GetTotalWorkHours]);
    lbUserWorkDaysInfo.Font.Color := clWindowText;
  end;
end;

{ TUserGroupItem }

constructor TUserGroupItem.Create(const GroupID: Integer; const Title: string);
begin
  fGroupID := GroupID;
  fTitle := Title;
  fUserInGroup := False;
end;

{ TUserFirmItem }

constructor TUserFirmItem.Create(const Index, CustomerID: Integer; const DisplayName: string);
begin
  fIndex := Index;
  fCustomerID := CustomerID;
  fDisplayName := DisplayName;
  fUserInFirm := False;
end;

end.


unit SWNSecurity;

interface

uses
  Classes, IBC;

type
  TSWNUserGroup = class
  private
    { private declarations }
    fGroupID: integer;
    FTitle: string;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    property Title: string read FTitle;
    property ID: integer read fGroupID;
  end;

  TSWNUserAccount = class
  private
    { private declarations }
    fEMail: string;
    fLastName: string;
    fServerEndMinutes: integer;
    fBirthDay: TDateTime;
    fServerLoggedTime: TDateTime;
    fStarHour: integer;
    fTelefon: string;
    fDescription: string;
    fServerDayIndex: integer;
    fEndHour: integer;
    fAddress: string;
    fFirstName: string;
    fLoginName: string;
    fServerStartMinutes: integer;
    fUserID: integer;
    fAccFirm: int64;
    fCityID: integer;
    fDefaultFirma: integer;
    fUserPosition: string;
    fCustomerID: integer;
    function GetUserGroupCount: integer;
    function GetUserGroups(index: integer): TSWNUserGroup;
    function getIsSuperAdminUser: Boolean;
    function GetIsLimitedUser: Boolean;
  protected
    { protected declarations }
    fUserGroups: TList;
    procedure ClearUserGroups;
    procedure InitDefaultValues;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function FullName: string;
    function IsInAdminGroup: Boolean;

    property UserID: integer read fUserID;
    property LoginName: string read fLoginName;
    property AccFirm: int64 read fAccFirm;
    property FirstName: string read fFirstName;
    property LastName: string read fLastName;
    property Description: string read fDescription;
    property Telefon: string read fTelefon;
    property EMail: string read fEMail;
    property Address: string read fAddress;
    property BirthDay: TDateTime read fBirthDay;
    property CityID: integer read fCityID;
    property StarHour: integer read fStarHour;
    property EndHour: integer read fEndHour;
    property DefaultFirma: integer read fDefaultFirma;
    property CustomerID: integer read fCustomerID;
    property ServerStartMinutes: integer read fServerStartMinutes;
    property ServerEndMinutes: integer read fServerEndMinutes;
    property ServerLoggedTime: TDateTime read fServerLoggedTime;
    property ServerDayIndex: integer read fServerDayIndex;
    property UserGroupCount: integer read GetUserGroupCount;
    property UserGroups[index: integer]: TSWNUserGroup read GetUserGroups;
    property IsLimitedUser: boolean read GetIsLimitedUser;
    property IsSuperAdminUser: Boolean read getIsSuperAdminUser;
    property OcupiedPosition: string read fUserPosition;
  end;

  TSWNSecurity = class
  private
    { private declarations }
    FFirmaID: integer;
    fUserGroupsAccMask: int64;
    fIsPartialAccessMode: Boolean;
    fHasPartialAccessModeSecurityConfirmed: Boolean;
    procedure SetFirmaID(const Value: integer);
    function GetUserFullName: string;
    function GetUserID: integer;
    function GetIsAdmin: Boolean;
    function GetIsSuperUser: Boolean;
    function GetIsLimitedUser: Boolean;
  protected
    { protected declarations }
    fIBCConnection: TIBCConnection;
    fTransaction: TIBCTransaction;
    fAccRights: TList;
    fLoaded: Boolean;
    fLoggedUser: TSWNUserAccount;
    procedure ClearLoggedUser;
    procedure ClearAccRights;
    procedure ReadAccRightsFromDB;
    function GetSecurityFlagByID(const FlagID: integer): Pointer;
    procedure WriteDBContextVar(const VarName: string; const VarValue: Variant);
  public
    { public declarations }
    constructor Create(const IBCConnection: TIBCConnection; const Transaction: TIBCTransaction);
    destructor Destroy; override;
    property LoggedUser: TSWNUserAccount read fLoggedUser;
    property FirmaID: integer read FFirmaID write SetFirmaID;
    property UserID: integer read GetUserID;
    property UserFullName: string read GetUserFullName;
    property UserGroupsAccMask: int64 read fUserGroupsAccMask;
    property IsPartialAccessMode: Boolean read fIsPartialAccessMode;
    property HasPartialAccessModeSecurityConfirmed: Boolean read fHasPartialAccessModeSecurityConfirmed;
    property IsAdmin: Boolean read GetIsAdmin;
    property IsLimitedUser: Boolean read GetIsLimitedUser;
    property IsSuperUser: Boolean read GetIsSuperUser;

    procedure ReadAccRights; // load user folder rights

    procedure LoginUser(const UserID: integer; const HasSecurityConfirmed: Boolean);
    function UserHasSecurityFlag(const SecurityFlag: integer): Boolean;
    function UserIsPartOfGroup(const GroupID: integer): Boolean;
    function UserHasFirmFlag(const FirmIndex: integer): Boolean;
    function TestUserPassword(const UserID: integer; const UserPass: string): Boolean;
    function ChangeCurrentUserPassword(const NewUserPass, OldUserPass: string): Boolean;
  end;

var
  SWNSecurityManager: TSWNSecurity;

implementation

uses
  SysUtils, SWNSecurityUtils;

type
  PDocTypeItem = ^TDocTypeItem;

  TDocTypeItem = record
    DocTypeID: integer;
    AccFolders: int64;
  end;

{ TSWNSecurity }

function TSWNSecurity.ChangeCurrentUserPassword(const NewUserPass, OldUserPass: string): Boolean;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  Transaction := TIBCTransaction.Create(nil);
  try
    Transaction.DefaultConnection := fIBCConnection;
    Query.Connection := fIBCConnection;
    Query.AutoCommit := False;
    Query.Transaction := Transaction;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_CHANGE_USER_PASS2(:USERID,:OLD_PASS_HASH,:PASS_HASH)';
    Query.ParamByName('USERID').AsInteger := UserID;
    Query.ParamByName('OLD_PASS_HASH').AsString := CreateHashPassword(OldUserPass);
    Query.ParamByName('PASS_HASH').AsString := CreateHashPassword(NewUserPass);
    Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Transaction.Commit;
      Result := True;
    except
      Transaction.Rollback;
    end;
  finally
    Query.Free;
    Transaction.Free;
  end;
end;

procedure TSWNSecurity.ClearAccRights;
var
  i: integer;
begin
  for i := 0 to fAccRights.Count - 1 do
    Dispose(PDocTypeItem(fAccRights[i]));
  fAccRights.Clear;
end;

procedure TSWNSecurity.ClearLoggedUser;
begin
  if Assigned(fLoggedUser) then
    FreeAndNil(fLoggedUser);
end;

constructor TSWNSecurity.Create(const IBCConnection: TIBCConnection; const Transaction: TIBCTransaction);
begin
  fIBCConnection := IBCConnection;
  fTransaction := Transaction;
  fAccRights := TList.Create;
  fLoaded := False;
  fLoggedUser := nil;
  fUserGroupsAccMask := 0;
  fIsPartialAccessMode := False;
  fHasPartialAccessModeSecurityConfirmed := False;
end;

destructor TSWNSecurity.Destroy;
begin
  try
    ClearLoggedUser;
    ClearAccRights;
    fAccRights.Free;
  finally
    inherited;
  end;
end;

function TSWNSecurity.GetIsAdmin: Boolean;
begin
  Result := LoggedUser.IsInAdminGroup;
end;

function TSWNSecurity.GetIsLimitedUser: Boolean;
begin
  Result := LoggedUser.IsLimitedUser;
end;

function TSWNSecurity.GetIsSuperUser: Boolean;
begin
  Result := LoggedUser.IsSuperAdminUser;
end;

function TSWNSecurity.GetSecurityFlagByID(const FlagID: integer): Pointer;
var
  i: integer;
  Item: PDocTypeItem;
begin
  Result := nil;
  for i := 0 to fAccRights.Count - 1 do
  begin
    Item := PDocTypeItem(fAccRights[i]);
    if Item^.DocTypeID = FlagID then
    begin
      Result := Item;
      Break;
    end;
  end;
end;

function TSWNSecurity.GetUserFullName: string;
begin
  if Assigned(fLoggedUser) then
    Result := fLoggedUser.FullName
  else
    Result := '';
end;

function TSWNSecurity.GetUserID: integer;
begin
  if Assigned(fLoggedUser) then
    Result := fLoggedUser.fUserID
  else
    Result := -1;
end;

procedure TSWNSecurity.LoginUser(const UserID: integer; const HasSecurityConfirmed: Boolean);
var
  Query: TIBCQuery;
  UserGroup: TSWNUserGroup;
begin
  ClearLoggedUser;

  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fIBCConnection;
    Query.Transaction := fTransaction;

    fTransaction.StartTransaction;
    try
      Query.AutoCommit := False;
      Query.SQL.Text := 'SELECT * FROM VW_TS_USERS WHERE (USERID=:UserID)';
      Query.ParamByName('UserID').AsInteger := UserID;
      Query.ExecSQL;
      if not Query.Eof then
      begin

        fLoggedUser := TSWNUserAccount.Create;
        fLoggedUser.fUserID := UserID;

                // read additional user info
        fLoggedUser.fLoginName := Query.FieldByName('LOGIN_NAME').asString;
        fLoggedUser.fAccFirm := Query.FieldByName('ACC$FIRM').Value;
        fLoggedUser.fFirstName := Query.FieldByName('FIRST_NAME').AsString;
        fLoggedUser.fLastName := Query.FieldByName('LAST_NAME').AsString;
        fLoggedUser.fDescription := Query.FieldByName('DESCRIPTION').AsString;
        fLoggedUser.fTelefon := Query.FieldByName('TELEFON').asString;
        fLoggedUser.fEMail := Query.FieldByName('EMAIL').asString;
        fLoggedUser.fAddress := Query.FieldByName('ADDRESS').asString;
        fLoggedUser.fBirthDay := Query.FieldByName('BIRTHDAY').AsDateTime;
        fLoggedUser.fCityID := Query.FieldByName('CITY_ID').asInteger;
        fLoggedUser.fDefaultFirma := Query.FieldByName('DEFAULT_DT').asInteger;
        fLoggedUser.fUserPosition := Query.FieldByName('FUNCTIA_DETINUTA').asString;
        fLoggedUser.fCustomerID := Query.FieldByName('CUSTOMERID').asInteger;


                // 3. read user groups
        fUserGroupsAccMask := 0;
        Query.Close;
        Query.SQL.Text := 'SELECT GROUPID, GROUP_NAME FROM GET_GROUPS_BY_USER(:USERID)';
        Query.ParamByName('UserID').AsInteger := fLoggedUser.fUserID;
        Query.ExecSQL;
        while (not Query.Eof) do
        begin
          UserGroup := TSWNUserGroup.Create;
          UserGroup.fGroupID := Query.Fields[0].AsInteger;
          UserGroup.fTitle := Query.Fields[1].asString;
          fLoggedUser.fUserGroups.Add(UserGroup);

          fUserGroupsAccMask := fUserGroupsAccMask or (1 shl (UserGroup.fGroupID - 1));

          Query.Next;
        end;

        if ((fUserGroupsAccMask and $01) = 1) or (fLoggedUser.fUserID = 1) then
        begin
                     // user is Administrator or SuperAdmin, let it see all available groups
          fUserGroupsAccMask := MaxLongint;
        end;

                // NEW. Check id DB is in Partial Access Mode
        if not HasSecurityConfirmed and (fLoggedUser.fUserID > 1) then
        begin
                     // 4. partial access mode?
          Query.Close;
          Query.SQL.Text := 'SELECT IS_PARTIAL_LOCKED FROM SP_IS_DB_PARTIAL_LOCKED(:UserID)';
          Query.ParamByName('UserID').AsInteger := fLoggedUser.fUserID;
          Query.ExecSQL;

          if not Query.Eof then
          begin
            fIsPartialAccessMode := Query.Fields[0].AsInteger = 1;
            fHasPartialAccessModeSecurityConfirmed := HasSecurityConfirmed;
          end;
        end;

                // Finally: Create context var "UserID"
        Query.Close;
        Query.SQL.Text := 'execute procedure PROC_USER_LOGIN(:UserID)';
        Query.ParamByName('UserID').AsInteger := fLoggedUser.fUserID;
        Query.ExecSQL;

      end;
      Query.Close;
      fTransaction.Commit;
    except
      fTransaction.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TSWNSecurity.ReadAccRights;
begin
  ClearAccRights;
  ReadAccRightsFromDB;
end;

procedure TSWNSecurity.ReadAccRightsFromDB;
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
  DocType: PDocTypeItem;
begin
  Query := TIBCQuery.Create(nil);
  Transaction := TIBCTransaction.Create(nil);
  try
    Query.Connection := fIBCConnection;
    Transaction.DefaultConnection := fIBCConnection;
    Query.Transaction := Transaction;
    Query.Transaction.StartTransaction;

    Query.SQL.Text := 'SELECT DOCTYPEID, ACC$FOLDERS FROM TS_DOCTYPES WHERE (DOCTYPEID>=0) ORDER BY DOCTYPEID';
    Query.ExecSQL;
    while (not Query.Eof) do
    begin
      New(DocType);
      DocType^.DocTypeID := Query.Fields[0].AsInteger;
      DocType^.AccFolders := Query.Fields[1].Value; // asInt64
      fAccRights.Add(DocType);
      Query.Next;
    end;
    Query.Close;
    Transaction.Commit;
  finally
    Query.Free;
    Transaction.Free;
  end;
  fLoaded := True;
end;

procedure TSWNSecurity.SetFirmaID(const Value: integer);
begin
  FFirmaID := Value;
end;

function TSWNSecurity.TestUserPassword(const UserID: integer; const UserPass: string): Boolean;
var
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := fIBCConnection;
    Query.SQL.Text := 'SELECT USERID FROM VW_TS_USERS WHERE (PASSWORD_HASH=:PASS_HASH) AND (FLG_ACTIVE=1) AND (USERID=:USERID)';
    Query.ParamByName('PASS_HASH').AsString := CreateHashPassword(UserPass);
    Query.ParamByName('USERID').AsInteger := UserID;
    Query.ExecSQL;
    if not Query.Eof then
      Result := UserID = Query.Fields[0].AsInteger;
    Query.Close;
  finally
    Query.Free;
  end;
end;

function TSWNSecurity.UserHasFirmFlag(const FirmIndex: integer): Boolean;
begin
     // SuperAdmin are toate drepturile
  if (fLoggedUser <> nil) and (fLoggedUser.fUserID = 1) then
  begin
    Result := True;
    Exit;
  end;

  if Assigned(fLoggedUser) then
    Result := (fLoggedUser.fAccFirm and FirmIndex) = FirmIndex
  else
    Result := False;
end;

    function TSWNSecurity.UserHasSecurityFlag(const SecurityFlag: integer): boolean;
var
  i: integer;
  GroupBits: int64;
  tmp: int64;
  SecurityRecord: PDocTypeItem;
begin
  Result := False;

     // SuperAdmin are toate drepturile
  if (fLoggedUser <> nil) and (fLoggedUser.fUserID = 1) then
  begin
    Result := True;
    Exit;
  end;

  if (fLoggedUser = nil) or (fLoggedUser.fUserGroups.Count = 0) or (fAccRights.Count = 0) then
    Exit;

     // create group test bits. Cream un numar la care biturile egale cu ID-urile grupelor din care
     // face parte utilizatorul sunt setate un 1. Se fa folosi la testarea flagurilor de securitate
  GroupBits := 0;
  for i := 0 to fLoggedUser.fUserGroups.Count - 1 do
  begin
    tmp := 1;
    tmp := tmp shl TSWNUserGroup(fLoggedUser.fUserGroups[i]).fGroupID;
    GroupBits := GroupBits or tmp;
  end;

     // gasim flag de securitate cu ID indicat
  SecurityRecord := PDocTypeItem(GetSecurityFlagByID(SecurityFlag));
  if Assigned(SecurityRecord) then
  begin
    Result := (SecurityRecord.AccFolders and GroupBits) > 0;
  end;
end;

function TSWNSecurity.UserIsPartOfGroup(const GroupID: integer): Boolean;
var
  i: integer;
  Group: TSWNUserGroup;
begin
     // SuperAdmin are toate drepturile
  if (fLoggedUser <> nil) and (fLoggedUser.fUserID = 1) then
  begin
    Result := True;
    Exit;
  end;

  Result := False;
  for i := 0 to fLoggedUser.fUserGroups.Count - 1 do
  begin
    Group := TSWNUserGroup(fLoggedUser.fUserGroups[i]);
    if Group.ID = GroupID then
    begin
      Result := True;
      break;
    end;
  end;
end;

procedure TSWNSecurity.WriteDBContextVar(const VarName: string; const VarValue: Variant);
var
  Query: TIBCQuery;
  Transaction: TIBCTransaction;
begin
  Query := TIBCQuery.Create(nil);
  Transaction := TIBCTransaction.Create(nil);
  try
    Query.Connection := fIBCConnection;
    Transaction.DefaultConnection := fIBCConnection;

    Query.Transaction := Transaction;
    Query.Transaction.StartTransaction;

    Query.SQL.Text := 'select rdb$set_context(''''USER_SESSION'''', :VarName, :VarValue) from rdb$database';
    Query.ParamByName('VarName').AsString := VarName;
    Query.ParamByName('VarValue').Value := VarValue;
    Query.ExecSQL;
    Transaction.Commit;
  finally
    Query.Free;
    Transaction.Free;
  end;
end;

{ TSWNUserAccount }

procedure TSWNUserAccount.ClearUserGroups;
var
  i: integer;
begin
  for i := 0 to fUserGroups.Count - 1 do
    TSWNUserGroup(fUserGroups[i]).Free;
  fUserGroups.Clear;
end;

constructor TSWNUserAccount.Create;
begin
  fUserGroups := TList.Create;
  InitDefaultValues;
end;

destructor TSWNUserAccount.Destroy;
begin
  ClearUserGroups;
  fUserGroups.Free;
  inherited;
end;

function TSWNUserAccount.FullName: string;
begin
  Result := WideFormat('%s %s', [fFirstName, fLastName]);
end;

function TSWNUserAccount.GetIsLimitedUser: Boolean;
var
  i: integer;
  UG: TSWNUserGroup;
begin
  Result := False;
  if UserID=1 then
  begin
//    Result := False;
    Exit(False);
  end;

  for i := 0 to fUserGroups.Count - 1 do
  begin
    UG := TSWNUserGroup(fUserGroups[i]);
    if (UG.fGroupID = 12) 
    then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function TSWNUserAccount.getIsSuperAdminUser: Boolean;
begin
  Result := (fUserID = 1);
end;

function TSWNUserAccount.GetUserGroupCount: integer;
begin
  Result := fUserGroups.Count;
end;

function TSWNUserAccount.GetUserGroups(index: integer): TSWNUserGroup;
begin
  Result := TSWNUserGroup(fUserGroups[index]);
end;

procedure TSWNUserAccount.InitDefaultValues;
begin
  fEMail := '';
  fLastName := '';
  fServerEndMinutes := 0;
  fBirthDay := 0;
  fServerLoggedTime := 0;
  fStarHour := 0;
  fTelefon := '';
  fDescription := '';
  fServerDayIndex := 0;
  fEndHour := 0;
  fAddress := '';
  fFirstName := '';
  fLoginName := '';
  fServerStartMinutes := 0;
  fUserID := -1;
  fAccFirm := 0;
  fCityID := -1;
  fDefaultFirma := -1;
  fUserPosition := '';
end;

function TSWNUserAccount.IsInAdminGroup: Boolean;
var
  i: integer;
  UG: TSWNUserGroup;
begin
  Result := False;
  for i := 0 to fUserGroups.Count - 1 do
  begin
    UG := TSWNUserGroup(fUserGroups[i]);
    if (UG.fGroupID = 1) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


{ TSWNUserGroup }

constructor TSWNUserGroup.Create;
begin
  fGroupID := -1;
  FTitle := '';
end;

initialization
  SWNSecurityManager := nil;

finalization
  if Assigned(SWNSecurityManager) then
    FreeAndNil(SWNSecurityManager);

end.


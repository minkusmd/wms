unit SWNBaseUnit;

interface

uses
  Windows, Messages, Classes, Forms, IBC, Controls, Menus, StdCtrls, cxGridTableView, cxGridDBTableView;

type
  TIntegerArray = array of Integer;

  TSWNCustomForm = class;

  TSWNFormsMonitor = class
  private
    { private declarations }
    FOnListChanged: TNotifyEvent;
    procedure SetOnListChanged(const Value: TNotifyEvent);
    function getCount: integer;
  protected
    { protected declarations }
    fInternalChange: Boolean;
    fOpenForms: TList;
    procedure ListChanged;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure RegisterOpenForm(const SWNForm: TSWNCustomForm);
    procedure UnRegisterOpenForm(const SWNForm: TSWNCustomForm);
    procedure CloseAllForms;
    property Count: integer read getCount;
    property OnListChanged: TNotifyEvent read FOnListChanged write SetOnListChanged;
  end;

  TSWNCustomForm = class(TForm)
  private
    { private declarations }
    function GetFirmaID: integer;
    function GetUserID: integer;
    procedure WhenFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WhenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    { protected declarations }
    fOldOnCloseQuery: TCloseQueryEvent;
    procedure OpenDataSets; virtual;
    procedure Prepare; virtual;
    function IsFormDataPosted: Boolean; virtual;
    function OnUserFormClosed: Boolean; virtual;
    procedure WhenCancelForm; virtual;
    procedure SaveStates; virtual;
    procedure LoadStates; virtual;
    function SecurityFlagEnabled(const SecurityFlag: integer): Boolean;
    function UserHasUserGroup(const UserGroupID: integer): Boolean;
    procedure SetupSecurityItems; virtual;
    procedure SetupFont;
  public
    { public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Integer; override;
    property UserID: integer read GetUserID;
    property FirmaID: integer read GetFirmaID;
  end;

  TSWNBaseFormClass = class(TSWNCustomForm)
  protected
    { protected declarations }
    fIBCConnection: TIBCConnection;
    fTrRead: TIBCTransaction;
    fTrWrite: TIBCTransaction;
//    procedure InitValues; virtual;
    procedure BindingDataSource; virtual;
  public
    { public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection); reintroduce; virtual;
    property IBCConnection: TIBCConnection read fIBCConnection;
  end;

  TSWNFormClass = class(TSWNBaseFormClass)
  private
    procedure SetReadTransaction(const Value: TIBCTransaction);
    procedure SetUpdateTransaction(const Value: TIBCTransaction);
  protected
    { protected declarations }
    fIBCConnection: TIBCConnection;
    FReadTransaction: TIBCTransaction;
    FUpdateTransaction: TIBCTransaction;
  public
    { public declarations }
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection; const AtrRead: TIBCTransaction; const
        AtrWrite: TIBCTransaction); reintroduce; virtual;
    property IBCConnection: TIBCConnection read fIBCConnection;
    property ReadTransaction: TIBCTransaction read FReadTransaction write SetReadTransaction;
    property UpdateTransaction: TIBCTransaction read FUpdateTransaction write SetUpdateTransaction;


  end;


  TSWNMasteredFormClass = class(TSWNBaseFormClass)
  protected
    { protected declarations }
    fMasterDataSet: TCustomIBCDataSet;
    fMasterDataSource: TIBCDataSource;
  public
    { public declarations }
    constructor Create(const AOwner: TComponent; const MasterDataSet: TCustomIBCDataSet; const MasterDataSource:
        TIBCDataSource); reintroduce; virtual;
    property MasterDataSet: TCustomIBCDataSet read fMasterDataSet;
    property MasterDataSource: TIBCDataSource read fMasterDataSource;
  end;

var
  SWNFormsMonitor: TSWNFormsMonitor;

implementation

uses
  SysUtils, SWNSecurity, SWNDBErrors, SWNConst, SWNValueStorageUnit, frmPriceTypesUnit,
  frmBSToolsCopyGridClipboardDialog, System.Types;


{ TSWNBaseFormClass }

//procedure TSWNBaseFormClass.BindingDataSource;
//begin
//  // in child
//  // use like OnCreate
//end;

procedure TSWNBaseFormClass.BindingDataSource;
begin
// only for child request
end;

constructor TSWNBaseFormClass.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection);
begin
  inherited Create(AOwner);
  fIBCConnection := IBCConnection;

  //  InitValues;
  BindingDataSource;
end;

//procedure TSWNBaseFormClass.InitValues;
//begin
//     // in child
//     // use like OnCreate
//end;

{ TSWNMasteredFormClass }

constructor TSWNMasteredFormClass.Create(const AOwner: TComponent; const MasterDataSet: TCustomIBCDataSet; const MasterDataSource: TIBCDataSource);
begin
  fMasterDataSet := MasterDataSet;
  fMasterDataSource := MasterDataSource;
  inherited Create(AOwner, fMasterDataSet.Connection);
end;

{ TSWNCustomFormClass }

constructor TSWNCustomForm.Create(AOwner: TComponent);
begin
  inherited;

     // register in Form Monitor
  if Assigned(SWNFormsMonitor) then
    SWNFormsMonitor.RegisterOpenForm(Self);

  fOldOnCloseQuery := OnCloseQuery;
  OnCloseQuery := WhenFormCloseQuery;
//  if KeyPreview then
  OnKeyDown := WhenKeyDown;

//  BorderStyle := bsDialog;
  Position := poMainFormCenter;
  DefaultMonitor := dmMainForm;

  SetupFont;
end;

destructor TSWNCustomForm.Destroy;
begin
  try
        // unregister from Form Monitor
    if Assigned(SWNFormsMonitor) then
      SWNFormsMonitor.UnRegisterOpenForm(Self);

    SaveStates;
  finally
    inherited;
  end;
end;

function TSWNCustomForm.GetFirmaID: integer;
begin
  Result := SWNSecurityManager.FirmaID;
end;

function TSWNCustomForm.GetUserID: integer;
begin
  Result := SWNSecurityManager.UserID;
end;

function TSWNCustomForm.IsFormDataPosted: Boolean;
begin
  Result := True;
end;

function TSWNCustomForm.SecurityFlagEnabled(const SecurityFlag: integer): Boolean;
begin
  if Assigned(SWNSecurityManager) then
    Result := SWNSecurityManager.UserHasSecurityFlag(SecurityFlag)
  else
    Result := False;
end;

procedure TSWNCustomForm.SetupFont;
begin
  with cFontSizeItems[AppUserConfigStorage.IntValues.GetValue(cSETTINGS_UserFontSize, cAppDefaultFontIndex)] do
  begin
    Font.Name := FontName;
    Font.Size := FontSize;
  end;
end;

procedure TSWNCustomForm.SetupSecurityItems;
begin
     // used in child to laod form state
end;

procedure TSWNCustomForm.LoadStates;
begin
     // used in child to laod form state
end;

function TSWNCustomForm.OnUserFormClosed: Boolean;
begin
  Result := IsFormDataPosted;
end;

procedure TSWNCustomForm.OpenDataSets;
begin

end;

procedure TSWNCustomForm.Prepare;
begin
      OpenDataSets;
     {

     Open transaction here (if exists)
     try
         write here all initialization code
     except
         roll back open transaction (if exists)
        raise; // must be, to notify upper caller for error and break further actions
     end;
     }
end;

procedure TSWNCustomForm.SaveStates;
begin
     // used in child to save form state
end;

function TSWNCustomForm.ShowModal: Integer;
var
  toSkip: Boolean;
begin
  Result := mrNone;
  toSkip := False;

  LoadStates;

  try
    SetupSecurityItems;
    Prepare;
    if ModalResult = mrCancel then
      toSkip := True;
  except
    on E: Exception do
    begin
      if ProcessSWNError(E) then
        toSkip := True
      else
        raise
    end;
  end;
  if not toSkip then
    Result := inherited ShowModal;
end;

function TSWNCustomForm.UserHasUserGroup(const UserGroupID: integer): Boolean;
begin
  if Assigned(SWNSecurityManager) then
    Result := SWNSecurityManager.UserIsPartOfGroup(UserGroupID)
  else
    Result := False;
end;

procedure TSWNCustomForm.WhenCancelForm;
begin

end;

procedure TSWNCustomForm.WhenFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(fOldOnCloseQuery) then
    fOldOnCloseQuery(Sender, CanClose);   // for any overriding of "OnCloseQuery" event in children

  if CanClose and (ModalResult <> mrCancel) and (ModalResult <> mrNone) then
  begin
          // FIX: Kind este button default sau cu shortcut, nu se face trecerea focusului din controlul current,
          //      simulam trecerea ca sa se efectuieze "post data" in controlul selectat
    SelectNext(ActiveControl as TWinControl, True, True);   // mutat focusu inainte
    SelectNext(ActiveControl as TWinControl, False, True);  // mutam focusus inapoi

    CanClose := False; // daca va fi vreo eroare mai departe, prevenim inchiderea formei
    CanClose := IsFormDataPosted;
  end
  else if CanClose then
    WhenCancelForm;
end;

procedure TSWNCustomForm.WhenKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  h: HWND;
begin
//  if (Key = 13) and ((Shift = [ssShift]) or (Shift = [])) then
//  begin
//    if Shift = [ssShift] then
//      SelectNext(ActiveControl, False, True)
//    else
//      SelectNext(ActiveControl, True, True);
//    Key := 0;
//  end;

  if ((Key = Ord('a')) or (Key = Ord('A'))) then
  begin
    if Shift = [ssAlt] then
    begin
    // Alt+A
      h := FindWindow(nil, 'iC Gestionarea Stocurilor');
      if h <> 0 then
      begin
        SendMessage(h, WM_SWN_RING, 0, DWord(PChar('rr')));
        Key := 0;
      end;
    end;
  end;
end;


{ TSWNFormsMonitor }

procedure TSWNFormsMonitor.CloseAllForms;
var
  i: integer;
  Form: TSWNCustomForm;
begin
     // close all forms in reverse order
  fInternalChange := True;
  try
    for i := fOpenForms.Count - 1 downto 0 do
    begin
      Form := TSWNCustomForm(fOpenForms[i]);
      Form.Close;
      Sleep(200);
    end;
  finally
    fOpenForms.Clear;
    fInternalChange := False;
  end;
end;

constructor TSWNFormsMonitor.Create;
begin
  fInternalChange := False;
  FOnListChanged := nil;
  fOpenForms := TList.Create;
end;

destructor TSWNFormsMonitor.Destroy;
begin
  fOpenForms.Free;
  inherited;
end;

function TSWNFormsMonitor.getCount: integer;
begin
  Result := fOpenForms.Count;
end;

procedure TSWNFormsMonitor.ListChanged;
begin
  if Assigned(FOnListChanged) then
    FOnListChanged(Self);
end;

procedure TSWNFormsMonitor.RegisterOpenForm(const SWNForm: TSWNCustomForm);
begin
  fOpenForms.Add(SWNForm);
  ListChanged;
end;

procedure TSWNFormsMonitor.SetOnListChanged(const Value: TNotifyEvent);
begin
  FOnListChanged := Value;
end;

procedure TSWNFormsMonitor.UnRegisterOpenForm(const SWNForm: TSWNCustomForm);
begin
  if not fInternalChange then
  begin
    fOpenForms.Remove(SWNForm);
    ListChanged;
  end;
end;

{ TSWNFormClass }

constructor TSWNFormClass.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection; const AtrRead: TIBCTransaction;
  const AtrWrite: TIBCTransaction);
begin
    inherited Create(AOwner, IBCConnection);
     fIBCConnection := IBCConnection;
     ReadTransaction := AtrRead;
     UpdateTransaction := AtrWrite;
end;

procedure TSWNFormClass.SetReadTransaction(const Value: TIBCTransaction);
begin
    FReadTransaction := Value;
end;

procedure TSWNFormClass.SetUpdateTransaction(const Value: TIBCTransaction);
begin
    FUpdateTransaction := Value;
end;

initialization
  SWNFormsMonitor := TSWNFormsMonitor.Create;

finalization
  if Assigned(SWNFormsMonitor) then
    FreeAndNil(SWNFormsMonitor);

end.


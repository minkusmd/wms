unit uChangeUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, Data.DB, DBAccess, IBC,
  MemDS, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.ExtCtrls;

type
  Tfrm57ChangeUser = class(TSWNMasteredFormClass)
    DialogTitle1: TDialogTitle;
    IBC_Users: TIBCQuery;
    IBCDS_Users: TIBCDataSource;
    btnOK: TcxButton;
    btnCancel: TcxButton;
    pnClient: TPanel;
    cxLabel2: TcxLabel;
    teOldUserName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cbNewUser: TcxLookupComboBox;
  private
    { Private declarations }
    fCurrentUserID: integer;
    fUserID: Integer;
    fUserName: String;
    fOldUserID: Integer;
    fOldUserName: string;
    function CheckInputValues:Boolean;
    procedure SetOldUserID(const Value: Integer);
    procedure SetOldUserName(const Value: string);
    procedure SetNewUserID(const Value: Integer);
    procedure SetNewUserName(const Value: String);
  protected
    { Protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;

  public
    { Public declarations }
    Property NewUserID: Integer read fUserID write SetNewUserID;
    property NewUserName:String read fUserName write SetNewUserName;
    property OldUserID: Integer read fOldUserID write SetOldUserID;
    property OldUserName: string read fOldUserName write SetOldUserName;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst;

{ TForm2 }

function Tfrm57ChangeUser.CheckInputValues: Boolean;
var Errors:String;
begin
     Result:=False;
     Errors:='';
     if VarIsNull(cbNewUser.EditValue) or (cbNewUser.EditValue<=0) then AddErrorToStr(Errors,'Выберите нового пользователя!');

     if Errors='' then Result:=True
     else ShowErrorDialog(cMSG_GeneralInputError_Title,cMSG_GeneralInputError_Text,Errors);
end;

function Tfrm57ChangeUser.IsFormDataPosted: Boolean;
begin
     Result:=False;
     if CheckInputValues then
     begin
          NewUserID := cbNewUser.EditValue;
          NewUserName :=cbNewUser.Text;
          Result := True;
     end;
end;

procedure Tfrm57ChangeUser.Prepare;
begin
     fCurrentUserID := OldUserID;
     teOldUserName.Text := OldUserName;

//     fCurrentUserID:=fMasterDataSource.DataSet.FieldByName('CREATED_BY').AsInteger;
//     teOldUserName.Text := fMasterDataSource.DataSet.FieldByName('CREATED_BY_NAME').AsString;
     IBC_Users.Open;
end;



procedure Tfrm57ChangeUser.SetNewUserID(const Value: Integer);
begin
  fUserID := Value;
end;

procedure Tfrm57ChangeUser.SetNewUserName(const Value: String);
begin
  fUserName := Value;
end;

procedure Tfrm57ChangeUser.SetOldUserID(const Value: Integer);
begin
  fOldUserID := Value;
end;

procedure Tfrm57ChangeUser.SetOldUserName(const Value: string);
begin
  fOldUserName := Value;
end;

end.

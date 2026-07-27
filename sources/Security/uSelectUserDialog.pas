unit uSelectUserDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBAccess, IBC, MemDS;

type
  TfrmSelectUserDialog = class(TSWNCustomForm)
    cxGridUsersView: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    cxGridUsersView_USERID: TcxGridDBColumn;
    cxGridUsersView_LOGIN_NAME: TcxGridDBColumn;
    cxGridUsersView_FULL_NAME: TcxGridDBColumn;
    procedure cxGridUsersViewDblClick(Sender: TObject);
  private
    fUserID: Integer;
    fUserName: string;
    procedure SetUserID(const Value: Integer);
    procedure SetUserName(const Value: string);
    { Private declarations }
    protected
    procedure Prepare; override;
  public
    { Public declarations }
    function SelectUser: Boolean;
    property UserID: Integer read fUserID write SetUserID;
    property UserName: string read fUserName write SetUserName;
  end;

var
  frmSelectUserDialog: TfrmSelectUserDialog;

implementation

uses
  DataModuleDB;

{$R *.dfm}

procedure TfrmSelectUserDialog.cxGridUsersViewDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmSelectUserDialog.Prepare;
begin
  inherited;

end;

procedure TfrmSelectUserDialog.SetUserID(const Value: Integer);
begin
  fUserID := Value;
end;

procedure TfrmSelectUserDialog.SetUserName(const Value: string);
begin
  fUserName := Value;
end;

function TfrmSelectUserDialog.SelectUser: Boolean;
begin
  IBCQueryUsers.Open;
  Result := (ShowModal = mrOk);

  UserID := IBCQueryUsers.FieldByName('USERID').AsInteger;
  UserName := IBCQueryUsers.FieldByName('FULL_NAME').AsString;
  IBCQueryUsers.Close;
end;

end.

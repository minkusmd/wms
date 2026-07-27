unit SelectDBUserDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, StdCtrls, ComCtrls;

type
  TfrmSelectDBUserDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    lvUsers: TListView;
    btnOk: TButton;
    btnCancel: TButton;
    procedure lvUsersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure btnOkClick(Sender: TObject);
  private
    fDBUserName: String;
    fDBUserID: integer;
    { Private declarations }
    procedure SelectionChanged;
  public
    { Public declarations }
    procedure SetConnectParams(const Server,DBName,User,Pass:String);

    property DBUserID:integer read fDBUserID;
    property DBUserName:String read fDBUserName;
  end;

implementation
Uses IBC;

{$R *.dfm}

{ TfrmSelectDBUserDlg }

procedure TfrmSelectDBUserDlg.btnOkClick(Sender: TObject);
var Item:TListItem;
begin
     Item:=lvUsers.Selected;
     fDBUserID:=StrToInt(Item.Caption);
     fDBUserName:=Item.SubItems[0];
     ModalResult:=mrOk;
end;

procedure TfrmSelectDBUserDlg.lvUsersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmSelectDBUserDlg.SelectionChanged;
begin
     btnOk.Enabled:=Assigned(lvUsers.Selected);
end;

procedure TfrmSelectDBUserDlg.SetConnectParams(const Server, DBName, User, Pass: String);
var Connection:TIBCConnection;
    Query:TIBCQuery;
    Item:TListItem;
begin
     SelectionChanged;

     Connection:=TIBCConnection.Create(Self);
     lvUsers.Items.BeginUpdate;
     try
        Connection.SQLDialect:=3;
        Connection.ClientLibrary:='fbclient.dll';
        Connection.Username:=User;
        Connection.Password:=Pass;
        Connection.Server:=Server;
        Connection.Database:=DBName;
        try
           Connection.Connect;

           Query:=TIBCQuery.Create(Self);
           try
              Query.Connection:=Connection;
              Query.SQL.Text:='SELECT USERID, FULL_NAME FROM TS_USERS WHERE GET_FLG_VALUE(FLAGS,0)=1 ORDER BY FIRST_NAME, LAST_NAME';
              Query.Execute;
              while Not Query.Eof do
              begin
                   Item:=lvUsers.Items.Add;
                   Item.Caption:=Query.Fields[0].AsString;
                   Item.SubItems.Add(Query.Fields[1].AsString);
                   Query.Next;
              end;
           finally
              Query.Free;
           end;
           Connection.Disconnect;
        except
        end;
     finally
        Connection.Free;
        lvUsers.Items.EndUpdate;
        SelectionChanged;
     end;
end;

end.

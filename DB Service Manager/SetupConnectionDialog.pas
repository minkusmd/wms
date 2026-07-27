unit SetupConnectionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DialogTitle, StdCtrls, Buttons, AppSettingsClass;

type
  TfrmSetupConnectionDlg = class(TForm)
    DialogTitle1: TDialogTitle;
    pnMain: TPanel;
    Label1: TLabel;
    edServer: TEdit;
    Label4: TLabel;
    edPort: TEdit;
    Label5: TLabel;
    edDBName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edUserName: TEdit;
    edUserPass: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    edAppPath: TEdit;
    Label6: TLabel;
    sbBrowse: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label7: TLabel;
    edDBUserName: TEdit;
    sbSelectDBUser: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure sbBrowseClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sbSelectDBUserClick(Sender: TObject);
  private
    { Private declarations }
    FAppSettings: TSWNServiceManagerSettings;
    FAppPath: String;
    fDBUserID: integer;
    procedure SetAppSettings(const Value: TSWNServiceManagerSettings);

    procedure DisplayValues;
    function CheckValues:Boolean;
    procedure SaveValues;
    procedure SetAppPath(const Value: String);

    procedure ShowSelectAppPath;
    function GetDBUserName(const UserID:integer):String;
    procedure ShowSelectDBUserDialog;
  public
    { Public declarations }
    property AppPath:String read FAppPath write SetAppPath;
    property AppSettings:TSWNServiceManagerSettings read FAppSettings write SetAppSettings;
  end;


implementation
Uses IBC, FileCtrl, SelectDBUserDialog;

{$R *.dfm}

{ TfrmSetupConnectionDlg }

procedure TfrmSetupConnectionDlg.btnOkClick(Sender: TObject);
begin
     if CheckValues then
     begin
          SaveValues;
          ModalResult:=mrOk;
     end;
end;

function TfrmSetupConnectionDlg.CheckValues: Boolean;
var S:String;
    N:integer;
begin
     Result:=False;

     if Trim(FAppPath)='' then S:=S+'Рабочая папка для сервиса? ';

     if Trim(edServer.Text)='' then S:=S+'Сервер? ';
     if Trim(edPort.Text)='' then S:=S+'Порт? '
     else
     begin
          N:=StrToIntDef(edPort.Text,-1);
          if N<=0 then S:=S+'Порт? ';
     end;
     if Trim(edDBName.Text)='' then S:=S+'База данных? ';
     if Trim(edUserName.Text)='' then S:=S+'Пользователь? ';
     if Trim(edUserPass.Text)='' then S:=S+'Пароль? ';

     if S='' then Result:=True
     else MessageDlg(S,mtError,[mbOk],0);
end;

procedure TfrmSetupConnectionDlg.DisplayValues;
begin
     edAppPath.Text:=FAppPath;
     edServer.Text:=FAppSettings.Server;
     edPort.Text:=IntToStr(FAppSettings.Port);
     edDBName.Text:=FAppSettings.DBName;
     edUserName.Text:=FAppSettings.UserName;
     edUserPass.Text:=FAppSettings.UserPass;
     fDBUserID:=FAppSettings.DBUserID;
     edDBUserName.Text:=Format('#%d - %s',[fDBUserID, GetDBUserName(fDBUserID)]);
end;

procedure TfrmSetupConnectionDlg.FormShow(Sender: TObject);
begin
     DisplayValues;
end;

function TfrmSetupConnectionDlg.GetDBUserName(const UserID: integer): String;
var Connection:TIBCConnection;
    Query:TIBCQuery;
begin
     Result:='';

     Connection:=TIBCConnection.Create(Self);
     try
        Connection.SQLDialect:=3;
        Connection.ClientLibrary:='fbclient.dll';
        Connection.Username:=FAppSettings.UserName;
        Connection.Password:=FAppSettings.UserPass;
        Connection.Server:=FAppSettings.Server;
        Connection.Database:=FAppSettings.DBName;
        try
           Connection.Connect;

           Query:=TIBCQuery.Create(Self);
           try
              Query.Connection:=Connection;
              Query.SQL.Text:='SELECT FULL_NAME FROM TS_USERS WHERE USERID='+IntToStr(UserID);
              Query.Execute;
              if Not Query.Eof then
              begin
                   Result:=Query.Fields[0].AsString;
              end;
           finally
              Query.Free;
           end;
           Connection.Disconnect;
        except
        end;
     finally
        Connection.Free;
     end;
end;

procedure TfrmSetupConnectionDlg.SaveValues;
begin
     FAppSettings.Server:=edServer.Text;
     FAppSettings.Port:=StrToInt(edPort.Text);
     FAppSettings.DBName:=edDBName.Text;
     FAppSettings.UserName:=edUserName.Text;
     FAppSettings.UserPass:=edUserPass.Text;
     FAppSettings.DBUserID:=fDBUserID;
end;

procedure TfrmSetupConnectionDlg.sbBrowseClick(Sender: TObject);
begin
     ShowSelectAppPath;
end;

procedure TfrmSetupConnectionDlg.sbSelectDBUserClick(Sender: TObject);
begin
     ShowSelectDBUserDialog;
end;

procedure TfrmSetupConnectionDlg.SetAppPath(const Value: String);
begin
     FAppPath := Value;
end;

procedure TfrmSetupConnectionDlg.SetAppSettings(const Value: TSWNServiceManagerSettings);
begin
     FAppSettings := Value;
end;

procedure TfrmSetupConnectionDlg.ShowSelectAppPath;
var dir:String;
begin
     if SelectDirectory('Выберите рабочую папку для сервиса',FAppPath,dir) then
     begin
          FAppPath:=IncludeTrailingPathDelimiter(dir);
          edAppPath.Text:=FAppPath;
     end;
end;

procedure TfrmSetupConnectionDlg.ShowSelectDBUserDialog;
var dialog:TfrmSelectDBUserDlg;
begin
     dialog:=TfrmSelectDBUserDlg.Create(Self);
     try
        dialog.SetConnectParams(edServer.Text,edDBName.Text,edUserName.Text,edUserPass.Text);
        if dialog.ShowModal=mrOk then
        begin
             fDBUserID:=dialog.DBUserID;
             edDBUserName.Text:=Format('#%d - %s',[fDBUserID, dialog.DBUserName]);
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSetupConnectionDlg.SpeedButton1Click(Sender: TObject);
var Connection:TIBCConnection;
begin
     Connection:=TIBCConnection.Create(Self);
     try
        Connection.SQLDialect:=3;
        Connection.ClientLibrary:='fbclient.dll';
        Connection.Username:=edUserName.Text;
        Connection.Password:=edUserPass.Text;
        Connection.Server:=edServer.Text;
        Connection.Database:=edDBName.Text;
        try
           Connection.Connect;
           Connection.Disconnect;
           MessageDlg('Connect Ok!',mtInformation,[mbOk],0);
        except on E:Exception do
           MessageDlg('Connection failed!'+#13#10+#13#10+E.Message,mtError,[mbOk],0);
        end;
     finally
        Connection.Free;
     end;
end;

end.

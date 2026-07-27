unit frameSipAccountSettingsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess, IBC,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxDBEdit;

type
  TframeSipAccountSettings = class(TFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnSave: TButton;
    StunBox: TCheckBox;
    btnCancel: TButton;
    IBCQueryUsers: TIBCQuery;
    ServerEdit: TcxDBTextEdit;
    UserEdit: TcxDBTextEdit;
    PasswordEdit: TcxDBTextEdit;
    STUNEdit: TcxDBTextEdit;
    ProxyEdit: TcxDBTextEdit;
    IBCDataSourceUsers: TIBCDataSource;
    procedure btnSaveClick(Sender: TObject);
    procedure FrameEnter(Sender: TObject);
    procedure btnSaveExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadSipAccountSettings;
    procedure SaveSipAccountSettings;
  end;

implementation

uses
  DataModuleDB;

{$R *.dfm}

{ TframeSipAccountSettings }

procedure TframeSipAccountSettings.btnSaveClick(Sender: TObject);
begin
  SaveSipAccountSettings;
end;

procedure TframeSipAccountSettings.btnSaveExit(Sender: TObject);
begin
  SaveSipAccountSettings;
end;

procedure TframeSipAccountSettings.FrameEnter(Sender: TObject);
begin
  LoadSipAccountSettings;
end;

procedure TframeSipAccountSettings.LoadSipAccountSettings;
begin
  with IBCQueryUsers do
  begin
    Close;
    ParamByName('USERID').AsInteger := dmdb.CurrentUserID;
    Open;
  end;

end;

procedure TframeSipAccountSettings.SaveSipAccountSettings;
begin
  try
  if IBCQueryUsers.State in [dsEdit, dsInsert] then
    IBCQueryUsers.Post;
  if IBCQueryUsers.UpdateTransaction.Active then
    IBCQueryUsers.UpdateTransaction.Commit;
  except on e: Exception do
  begin
    IBCQueryUsers.UpdateTransaction.Rollback;
    raise;
  end;
    end;
end;

end.

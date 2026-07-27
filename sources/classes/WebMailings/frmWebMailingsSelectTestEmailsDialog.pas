unit frmWebMailingsSelectTestEmailsDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmWebMailingsSelectTestEmailsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    mmEMails: TMemo;
    btnOk: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
{ TfrmWebMailingsSelectTestEmailsDlg }

function TfrmWebMailingsSelectTestEmailsDlg.IsFormDataPosted: Boolean;
begin
  Result := Trim(mmEMails.Text) <> '';
end;

procedure TfrmWebMailingsSelectTestEmailsDlg.Prepare;
begin

end;

end.

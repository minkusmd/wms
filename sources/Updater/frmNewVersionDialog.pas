unit frmNewVersionDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus;

type
  TfrmNewVersionDlg = class(TForm)
    pnInfo: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    lbNewVersionInfo: TLabel;
    lbCurrentVersionInfo: TLabel;
    dtDialogTitle: TDialogTitle;
    pnButtons: TPanel;
    lbProgress: TLabel;
    lbWhatsNew: TLabel;
    mmInfo: TMemo;
    lbCritical: TLabel;
    btnUpdate: TcxButton;
    btnPostpone: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetVersionInfo(const OldVersion,NewVersion,WhatsNew:String; const FLG_Critical: Boolean);
  end;

implementation

uses ShellApi;

{$R *.dfm}


procedure TfrmNewVersionDlg.SetVersionInfo(const OldVersion, NewVersion, WhatsNew:String; const FLG_Critical: Boolean);
begin
     lbCurrentVersionInfo.Caption:=OldVersion;
     lbNewVersionInfo.Caption:=NewVersion;
     if WhatsNew='' then
     begin
          mmInfo.Lines.Text:='Nu sunt informatii despre modificari!';
          mmInfo.Enabled:=False;
     end
     else mmInfo.Lines.Text:=WhatsNew;

     lbCritical.Visible:=FLG_Critical;
     btnPostpone.Visible:=Not FLG_Critical;
end;

end.

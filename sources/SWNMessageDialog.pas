unit SWNMessageDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxGDIPlusClasses;

type
  TSWNMessageDialog = class(TForm)
    pnClient: TPanel;
    pnButtons: TPanel;
    imgMainIcon: TImage;
    lbTitle: TLabel;
    lbInfo: TLabel;
    cbVerification: TCheckBox;
    lbFooterText: TLabel;
    imgFooterIcon: TImage;
    btnOk: TcxButton;
    btnYes: TcxButton;
    btnNo: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure lbInfoDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure LoadSystemIcon(const IconType:PWideChar);
    function getVerificationFlag: Boolean;
  public
    { Public declarations }
    constructor Create;reintroduce;

    procedure ShowErrorDlg(const Title, Text:String; const ErrorText:String=''; const FooterText:String='');
    function ShowAskDialog(const Title,Text:String; const InfoText:String=''):integer;
    function ShowAskDialogWithVerification(const Title,Text,VerificationTitle,FooterText:String; const DefaultChecked:Boolean=False):integer;
    procedure ShowWarningDialog(const Title,Text:String);
    procedure ShowInfoDialog(const Title,Text:String; const VerificationTitle:String='');

    property VerificationFlag:Boolean read getVerificationFlag;
  end;


implementation
Uses ClipBrd;

{$R *.dfm}


{ TSWNMessageDialog }

constructor TSWNMessageDialog.Create;
begin
     inherited Create(nil);
end;

procedure TSWNMessageDialog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=65) and (Shift=[ssCtrl]) then cbVerification.Checked:=Not cbVerification.Checked;
end;

procedure TSWNMessageDialog.FormShow(Sender: TObject);
begin
     imgFooterIcon.Top:=lbFooterText.Top;
end;

function TSWNMessageDialog.getVerificationFlag: Boolean;
begin
     if ModalResult<>mrCancel
      then Result:=cbVerification.Checked
      else Result:=False;
end;

procedure TSWNMessageDialog.lbInfoDblClick(Sender: TObject);
begin
     ClipBoard.asText:=lbInfo.Caption;
end;

procedure TSWNMessageDialog.LoadSystemIcon(const IconType: PWideChar);
var Icon:TIcon;
begin
     Icon:=TIcon.Create;
     try
        Icon.Handle:=LoadIcon(0,IconType);
        imgMainIcon.Picture.Assign(Icon);
     finally
        Icon.Free;
     end;
{
IDI_INFORMATION - Asterisk icon.
IDI_ERROR - Hand-shaped icon.
IDI_WARNING - Exclamation point icon.
IDI_QUESTION - Question mark icon.
}
end;

function TSWNMessageDialog.ShowAskDialog(const Title, Text, InfoText: String): integer;
begin
     LoadSystemIcon(IDI_QUESTION);

     cbVerification.Visible:=False;

     btnOk.Visible:=False;
     ActiveControl:=btnYes;

     lbTitle.Caption:=Title;
     lbInfo.Caption:=Trim(Text);
     lbInfo.AutoSize:=True;

     if InfoText<>'' then
     begin
          lbFooterText.Caption:=Trim(InfoText);
          lbFooterText.AutoSize:=True;
          imgFooterIcon.Top:=lbFooterText.Top-1;
     end
     else
     begin
          lbFooterText.Visible:=False;
          imgFooterIcon.Visible:=False;
     end;

     Result:=ShowModal;
end;

function TSWNMessageDialog.ShowAskDialogWithVerification(const Title, Text, VerificationTitle, FooterText: String; const DefaultChecked:Boolean=False): integer;
begin
     LoadSystemIcon(IDI_QUESTION);

     btnOk.Visible:=False;
     ActiveControl:=btnYes;

     lbTitle.Caption:=Title;
     lbInfo.Caption:=Trim(Text);
     lbInfo.AutoSize:=True;

     if VerificationTitle<>'' then
     begin
          cbVerification.Caption:=VerificationTitle;
          cbVerification.Checked:=DefaultChecked;
          if Trim(FooterText)<>'' then
          begin
               lbFooterText.Caption:=Trim(FooterText);
               lbFooterText.AutoSize:=True;
          end
          else
          begin
               lbFooterText.Visible:=False;
               imgFooterIcon.Visible:=False;
          end;
     end
     else
     begin
          cbVerification.Visible:=False;
     end;

     Result:=ShowModal;
end;

procedure TSWNMessageDialog.ShowErrorDlg(const Title, Text, ErrorText, FooterText: String);
begin
     LoadSystemIcon(IDI_ERROR);

     cbVerification.Visible:=False;

     btnYes.Visible:=False;
     btnNo.Visible:=False;

     lbTitle.Caption:=Title;

     if ErrorText<>''
      then lbInfo.Caption:=Trim(Text)+sLineBreak+sLineBreak+Trim(ErrorText)
      else lbInfo.Caption:=Trim(Text);
     lbInfo.AutoSize:=True;

     if FooterText<>'' then
     begin
          lbFooterText.Caption:=Trim(FooterText);
          lbFooterText.AutoSize:=True;
     end
     else
     begin
          lbFooterText.Visible:=False;
          imgFooterIcon.Visible:=False;
     end;

     ShowModal;
end;

procedure TSWNMessageDialog.ShowInfoDialog(const Title, Text, VerificationTitle: String);
begin
     LoadSystemIcon(IDI_INFORMATION);

     lbFooterText.Visible:=False;
     imgFooterIcon.Visible:=False;

     btnYes.Visible:=False;
     btnNo.Visible:=False;

     lbTitle.Caption:=Title;

     lbInfo.Caption:=Trim(Text);
     lbInfo.AutoSize:=True;

     if VerificationTitle<>'' then
     begin
          cbVerification.Caption:=VerificationTitle;
     end
     else
     begin
          cbVerification.Visible:=False;
     end;

     ShowModal;
end;

procedure TSWNMessageDialog.ShowWarningDialog(const Title, Text: String);
begin
     LoadSystemIcon(IDI_WARNING);

     cbVerification.Visible:=False;

     lbFooterText.Visible:=False;
     imgFooterIcon.Visible:=False;

     btnYes.Visible:=False;
     btnNo.Visible:=False;

     lbTitle.Caption:=Title;

     lbInfo.Caption:=Trim(Text);
     lbInfo.AutoSize:=True;

     ShowModal;
end;

end.


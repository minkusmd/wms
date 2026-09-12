unit frmOtgruzkaChecksDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, StdCtrls,
  cxTextEdit, cxMemo, DialogTitle, dxGDIPlusClasses;

type
  TfrmOtgruzkaChecksDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    mmInfo: TcxMemo;
    btnClose: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetText(const Text:String);
  end;


implementation

uses DataModuleAdditions;

{$R *.dfm}

{ TfrmOtgruzkaChecksDlg }

procedure TfrmOtgruzkaChecksDlg.SetText(const Text: String);
begin
     mmInfo.Lines.Text:=Text;
end;

end.

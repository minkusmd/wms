unit frmImportPricelistErrorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ExtCtrls,
  RzPanel, RzDlgBtn, cxTextEdit, cxMemo;

type
  TfrmImportPricelistErrorDlg = class(TForm)
    MemoLog: TcxMemo;
    RzDialogButtons1: TRzDialogButtons;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetErrors(Errors: string);
  end;

var
  frmImportPricelistErrorDlg: TfrmImportPricelistErrorDlg;

implementation

{$R *.dfm}


{ TfrmImportPricelistErrorDlg }

procedure TfrmImportPricelistErrorDlg.SetErrors(Errors: string);
begin
  MemoLog.lines.add(Errors);
end;

end.

unit frmPricePolicyFolderUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls;

type
  TfrmPricePolicyFolderDlg = class(TForm)
    DBLabeledEdit1: TDBLabeledEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPricePolicyFolderDlg: TfrmPricePolicyFolderDlg;

implementation

{$R *.dfm}

end.

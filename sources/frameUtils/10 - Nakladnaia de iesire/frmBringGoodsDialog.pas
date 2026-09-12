unit frmBringGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, ExtCtrls, StdCtrls, SWNBaseUnit,
  cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus;

type
  TfrmBringGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    mmComments: TMemo;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

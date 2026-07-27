unit frmTransportEditUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, cxMaskEdit, cxButtonEdit, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, cxDBEdit;

type
  TfrmTransportEditDlg = class(TSWNMasteredFormClass)
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButtonEdit1: TcxButtonEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTransportEditDlg: TfrmTransportEditDlg;

implementation

{$R *.dfm}

end.

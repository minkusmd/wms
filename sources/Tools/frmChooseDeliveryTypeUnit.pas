unit frmChooseDeliveryTypeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ExtCtrls, RzPanel, RzDlgBtn,
  Vcl.StdCtrls, cxRadioGroup, cxGroupBox, SWNBaseUnit;

type
  TfrmChooseDeliveryTypeDlg = class(TSWNCustomForm)
    cxGroupBox1: TcxGroupBox;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    RzDialogButtons1: TRzDialogButtons;
    cxRadioButton3: TcxRadioButton;
  private
    { Private declarations }
  protected
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
  end;

var
  frmChooseDeliveryTypeDlg: TfrmChooseDeliveryTypeDlg;

implementation

{$R *.dfm}

{ TfrmTipulLivrarii }

function TfrmChooseDeliveryTypeDlg.IsFormDataPosted: boolean;
begin

  result := True;
end;

end.

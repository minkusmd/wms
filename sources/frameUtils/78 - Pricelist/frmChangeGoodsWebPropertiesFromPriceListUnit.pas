unit frmChangeGoodsWebPropertiesFromPriceListUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCheckBox, Vcl.ExtCtrls, RzPanel,
  RzDlgBtn, SWNBaseUnit;

type
  TGoodsWebNameFlags = record
    FlgTitle: boolean;
    FlgCode: boolean;
    FlgCodeRu: boolean;
    FlgParams: boolean;
    FlgParamsRu: boolean;
  end;

  TfrmChangeGoodsWebPropertiesFromPriceListDlg = class(TSWNCustomForm)
    ckbTitle: TcxCheckBox;
    ckbCode: TcxCheckBox;
    ckbCodeRu: TcxCheckBox;
    ckbParamsRu: TcxCheckBox;
    ckbParams: TcxCheckBox;
    RzDialogButtons1: TRzDialogButtons;
  private
    { Private declarations }
  protected
    function IsFormDataPosted: boolean; override;
  public
    { Public declarations }
    GoodsWebNameFlags: TGoodsWebNameFlags;
  end;

var
  frmChangeGoodsWebPropertiesFromPriceListDlg: TfrmChangeGoodsWebPropertiesFromPriceListDlg;

implementation

{$R *.dfm}

{ TfrmChangeGoodsWebPropertiesFromPriceListDlg }


{ TfrmChangeGoodsWebPropertiesFromPriceListDlg }

function TfrmChangeGoodsWebPropertiesFromPriceListDlg.IsFormDataPosted: boolean;
begin
  Result := True;
  with GoodsWebNameFlags do
  begin
    FlgTitle := ckbTitle.Checked;
    FlgCode := ckbCode.Checked;
    FlgCodeRu := ckbCodeRu.Checked;
    FlgParams := ckbParams.Checked;
    FlgParamsRu := ckbParamsRu.Checked;
  end;
end;

end.

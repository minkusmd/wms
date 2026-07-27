unit frmGoodsSelectUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, SWNBaseUnit, SWNButtonEditClass, DialogTitle, SWNValueStorageUnit,
  cxLabel, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls;

type
  TGoodsTypeID = (gtAll, gtComplecte, gtServicii, gtProduse);

  // TSWNBaseFormClass
  TfrmGoodsSelectDlg = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    beGoods: TcxButtonEdit;
    procedure SWNButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    procedure DoSelectGoods;
  protected
    procedure Prepare; override;
  public
    { Public declarations }
    GoodsID: integer;
  end;

var
  frmGoodsSelectDlg: TfrmGoodsSelectDlg;

implementation

uses DataModuleDB, frmGoods, DataModuleAdditions;

{$R *.dfm}

procedure TfrmGoodsSelectDlg.SWNButtonEdit1PropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  DoSelectGoods;
end;

procedure TfrmGoodsSelectDlg.Prepare;
begin
   beGoods.Text := '';
end;

procedure TfrmGoodsSelectDlg.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
   DoSelectGoods;
end;

procedure TfrmGoodsSelectDlg.DoSelectGoods;
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try
    dialog.CustomeSQLFilter := '';

    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);

    if dialog.SelectGoods(N, False) then
    begin
      GoodsID := dialog.GoodsID;
      beGoods.Text := dialog.GoodsID.ToString + ' ' + dialog.GoodsTitle;

      // save last selected goodsid
      AppUserTempConfigStorage.IntValues.SetValue(Owner.Name + '_LastSelectedGoodsID', dialog.GoodsID);
    end;
  finally
    dialog.Free;
  end;
end;

end.

unit uGoodsImportFromSupplierDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.Menus, cxButtons, SWNBaseUnit;

type
  TfrmGoodsImportFromSupplierDialog = class(TSWNCustomForm)
    beCT_NAME: TcxButtonEdit;
    cxLabel2: TLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Label1: TLabel;
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectCustomer;
  end;

var
  frmGoodsImportFromSupplierDialog: TfrmGoodsImportFromSupplierDialog;

implementation

uses
  frmCustomersDlg;

{$R *.dfm}

procedure TfrmGoodsImportFromSupplierDialog.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomer;
end;

procedure TfrmGoodsImportFromSupplierDialog.SelectCustomer;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter;   // Gheorghian, 28.03.2011
    if dialog.SelectCustomer(beCT_NAME.Tag, False, 0, 'Alege clientul') then
    begin
      beCT_NAME.Tag := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;
end.

unit frm75GoodsDlgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DialogTitle, Vcl.StdCtrls, cxButtons,
  cxDBEdit, cxCheckBox, cxTextEdit, cxMaskEdit, cxButtonEdit, cxLabel, Data.DB, DBAccess, IBC;

type
  Tfrm75GoodsDialog = class(TSWNMasteredFormClass)
    cxLabel1: TcxLabel;
    beCustomer: TcxButtonEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    beGoods: TcxButtonEdit;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    DialogTitle1: TDialogTitle;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel5: TcxLabel;
    IBCDataSource1: TIBCDataSource;
    procedure beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FCustomerID: Integer;
    FCustomerName: string;
    FCustomeSQLFilter: string;
    FFreeName: string;
    FIsNewRecord: Boolean;
    procedure SetCustomerID(const Value: Integer);
    procedure SetCustomerName(const Value: string);
    procedure SetFreeName(const Value: string);
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    procedure ShowSelectGoodsDialog;
    property CustomerID: Integer read FCustomerID write SetCustomerID;
    property CustomerName: string read FCustomerName write SetCustomerName;
    property FreeName: string read FFreeName write SetFreeName;
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

implementation

uses
  frmGoods, SWNValueStorageUnit, frmCustomersDlg, SWNCustomersTypesUnit, DataModuleAdditions;

{$R *.dfm}

{ Tfrm75GoodsDialog }

procedure Tfrm75GoodsDialog.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfCustomers]; //cfFirms, cfSecuredFirms
    if dialog.SelectCustomer(CustomerID, False, 0, 'Alege clientul') then
    begin
      fMasterDataSet.FieldByName('CustomerID').asInteger := dialog.CustomerID;
      fMasterDataSet.FieldByName('Customer_Name').AsString := dialog.CustomerTitle;
      beCustomer.Text := dialog.CustomerTitle;
      beCustomer.Tag := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure Tfrm75GoodsDialog.beGoodsPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectGoodsDialog;
end;

function Tfrm75GoodsDialog.IsFormDataPosted: Boolean;
begin
  Result := True;
  try
    fMasterDataSet.Post;
  except
    begin
      Result := False;
      raise;
    end;
  end;
end;

procedure Tfrm75GoodsDialog.Prepare;
begin
  IBCDataSource1.DataSet := fMasterDataSet;
  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    beCustomer.Text := '';
    beCustomer.Tag := -1;

    beGoods.Text := '';
    beGoods.Tag := -1;
  end
  else
  begin
    fMasterDataSet.Edit;
    beCustomer.Text := fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString;
    beCustomer.Tag := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;

    beGoods.Text := fMasterDataSet.FieldByName('GOODS_NAME').AsString;
    beGoods.Tag := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  end;
end;

procedure Tfrm75GoodsDialog.SetCustomerID(const Value: Integer);
begin
  FCustomerID := Value;
end;

procedure Tfrm75GoodsDialog.SetCustomerName(const Value: string);
begin
  FCustomerName := Value;
end;

procedure Tfrm75GoodsDialog.SetFreeName(const Value: string);
begin
  FFreeName := Value;
end;

procedure Tfrm75GoodsDialog.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure Tfrm75GoodsDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

procedure Tfrm75GoodsDialog.ShowSelectGoodsDialog;
var
  dialog: TfrmGoodsBrowser;
  N: integer;
begin
  dialog := TfrmGoodsBrowser.Create(Parent);
  try
    dialog.CustomeSQLFilter := FCustomeSQLFilter;

    N := AppUserTempConfigStorage.IntValues.GetValue(Owner.Name + '_LastSelectedGoodsID', -1);
    if not fMasterDataSet.FieldByName('GOODSID').IsNull then
      N := fMasterDataSet.FieldByName('GOODSID').AsInteger;

    if dialog.SelectGoods(N, False) then
    begin
      fMasterDataSet.FieldByName('GOODSID').asInteger := dialog.GoodsID;
      beGoods.Text := dialog.GoodsTitle;
    end;
  finally
    dialog.Free;
  end;
end;

end.


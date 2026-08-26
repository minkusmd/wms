unit uWebPromoSuppliersDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Data.DB, cxDBData, Vcl.Menus, dxBar,
  cxClasses, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.StdCtrls, cxButtons, DBAccess, IBC, MemDS, cxGridLevel,
  cxGridCustomView, cxGrid;

type
  TfrmWebPromoSuppliersDlg = class(TSWNMasteredFormClass)
    cxGridPromoSuppliersDBTableView1: TcxGridDBTableView;
    cxGridPromoSuppliersLevel1: TcxGridLevel;
    cxGridPromoSuppliers: TcxGrid;
    IBCQueryPromoSuppliers: TIBCQuery;
    IBCDataSourcePromoSuppliers: TIBCDataSource;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxGridPromoSuppliersDBTableView1_SupplierID: TcxGridDBColumn;
    cxGridPromoSuppliersDBTableView1_SupplierName: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbAddSupplier: TdxBarButton;
    bbDeleteSupplier: TdxBarButton;
    procedure bbAddSupplierClick(Sender: TObject);
    procedure bbDeleteSupplierClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  end;

var
  frmWebPromoSuppliersDlg: TfrmWebPromoSuppliersDlg;

implementation

uses
  frmCustomersDlg, SWNCommonDialogs, SWNUtils;

{$R *.dfm}

procedure TfrmWebPromoSuppliersDlg.bbAddSupplierClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
  N: Integer;
begin
  dialog := TfrmCustomersDlg.Create(self);

  try
    if dialog.SelectCustomer(-1) then
    begin
      IBCQueryPromoSuppliers.Append;
      IBCQueryPromoSuppliers.FieldByName('SupplierID').AsInteger :=  dialog.CustomerID;
      IBCQueryPromoSuppliers.FieldByName('Supplier_Name').AsString :=  dialog.CustomerTitle;
      IBCQueryPromoSuppliers.FieldByName('PROMOACTIONID').AsInteger := fMasterDataSet.FieldByName('PROMOACTIONID').AsInteger;
      IBCQueryPromoSuppliers.Post;
    end;
  finally
    dialog.Free;
  end;

end;

procedure TfrmWebPromoSuppliersDlg.bbDeleteSupplierClick(Sender: TObject);
begin
  if ShowAskDialog(Application.Name, 'Sterge inregistrarea', format('Stergeti furnizorul %s din actiunea %s',
      [IBCQueryPromoSuppliers.FieldByName('SUPPLIER_NAME').AsString, IBCQueryPromoSuppliers.FieldByName('PROMOACTION_TITLE').AsString]))=mrYes then
    IBCQueryPromoSuppliers.Delete;

end;

procedure TfrmWebPromoSuppliersDlg.Prepare;
begin
  IBCQueryPromoSuppliers.Transaction := fMasterDataSet.Transaction;
  IBCQueryPromoSuppliers.UpdateTransaction := fMasterDataSet.UpdateTransaction;
  IBCQueryPromoSuppliers.MasterSource := fMasterDataSource;

  IBCQueryPromoSuppliers.Open;
end;

end.

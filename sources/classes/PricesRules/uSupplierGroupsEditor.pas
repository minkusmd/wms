unit uSupplierGroupsEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, Vcl.StdCtrls, Vcl.ExtCtrls, dxBar, cxClasses, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Data.DB, cxDBEdit, cxCheckBox;

type
  TfrmSupplierGroupsEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnButtons: TPanel;
    btnSelect: TButton;
    btnClose: TButton;
    pnClient: TPanel;
    Label2: TLabel;
    edCod: TcxDBTextEdit;
    Label3: TLabel;
    edTitle: TcxDBTextEdit;
    cbCostInPrice: TcxDBCheckBox;
    cbDefSupplier: TcxDBCheckBox;
    procedure beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FNewRecord: Boolean;
    procedure SetNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure SelectSupplier;
    procedure WhenCancelForm; override;
    function ValidateData: Boolean;
  public
    property NewRecord: Boolean read FNewRecord write SetNewRecord;
    { Public declarations }
  end;

var
  frmSupplierGroupsEditorDlg: TfrmSupplierGroupsEditorDlg;

implementation

uses
  frmCustomersDlg;

{$R *.dfm}

{ TfrmSupplierGroupsEditorDlg }

procedure TfrmSupplierGroupsEditorDlg.beSupplierPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectSupplier;
end;

procedure TfrmSupplierGroupsEditorDlg.BindingDataSource;
begin
  cbCostInPrice.DataBinding.DataSource := fMasterDataSource;
  cbDefSupplier.DataBinding.DataSource := fMasterDataSource;
  edTitle.DataBinding.DataSource := fMasterDataSource;
  edCod.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmSupplierGroupsEditorDlg.IsFormDataPosted: boolean;
begin
  result := false;
  if ValidateData then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;

    if fMasterDataSet.UpdateTransaction.Active then
    begin
      fMasterDataSet.UpdateTransaction.Commit;
    end;
  end;
end;

procedure TfrmSupplierGroupsEditorDlg.Prepare;
begin
  if fNewRecord then
  begin
    fMasterDataSet.Append;
    with fMasterDataSet do
    begin
      FieldByName('FLG_COST_IN_PRICE').AsInteger := 0;
      FieldByName('FLG_DEFAULT_SUPPLIER').AsInteger := 0;
    end;
  end
  else
  begin
    fMasterDataSet.Edit;
  end;
end;

procedure TfrmSupplierGroupsEditorDlg.SelectSupplier;
//var
//  d: TfrmCustomersDlg;
begin
//  d := TfrmCustomersDlg.Create(self);
//  try
//    if d.SelectCustomer(beSupplier.Tag) then
//    begin
//      beSupplier.Text := d.CustomerTitle;
//      beSupplier.Tag := d.CustomerID;
//      fMasterDataSet.FieldByName('supplierid').AsInteger := beSupplier.Tag;
//      fMasterDataSet.FieldByName('supplier_name').AsString := beSupplier.Text;
//    end;
//  finally
//    d.Free;
//  end;
end;

procedure TfrmSupplierGroupsEditorDlg.SetNewRecord(const Value: Boolean);
begin
  FNewRecord := Value;
end;

function TfrmSupplierGroupsEditorDlg.ValidateData: Boolean;
begin
  Result := True;
  if (fMasterDataSet.FieldByName('SGID').IsNull or (fMasterDataSet.FieldByName('SGID').AsInteger <= 0)) then
    Result := false;
end;

procedure TfrmSupplierGroupsEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
end;

end.

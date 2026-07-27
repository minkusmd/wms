unit uCrediteEditorDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalc, cxDBEdit, cxTextEdit, cxLabel, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons,
  cxCheckBox, cxButtonEdit;

type
  TfrmCrediteEditorDlg = class(TSWNMasteredFormClass)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    teTitle: TcxDBTextEdit;
    ceSumaMin: TcxDBCalcEdit;
    ceSumaMax: TcxDBCalcEdit;
    cxLabel3: TcxLabel;
    ceLuniMin: TcxDBCalcEdit;
    ceLuniMax: TcxDBCalcEdit;
    cxLabel4: TcxLabel;
    ceDobinda: TcxDBCalcEdit;
    cxLabel5: TcxLabel;
    ceComision: TcxDBCalcEdit;
    cxLabel6: TcxLabel;
    cePrimaRata: TcxDBCalcEdit;
    cbActive: TcxDBCheckBox;
    cxLabel7: TcxLabel;
    beCustomerName: TcxButtonEdit;
    procedure beCustomerNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    FIsNewRecord: Boolean;
    procedure SetIsNewRecord(const Value: Boolean);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure SelectCustomer;
    procedure WhenCancelForm; override;
  public
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

implementation

uses
  DB, frmCustomersDlg, SWNCustomersTypesUnit;

{$R *.dfm}

procedure TfrmCrediteEditorDlg.beCustomerNamePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomer;
end;

function TfrmCrediteEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := True;
  try
    if fMasterDataSet.State in [dsEdit, dsInsert] then
      fMasterDataSet.Post;
  except
    on e: Exception do
    begin
      Result := False;
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TfrmCrediteEditorDlg.Prepare;
begin
  teTitle.DataBinding.DataSource := fMasterDataSource;
  teTitle.DataBinding.DataField := 'TITLE';

  ceSumaMin.DataBinding.DataSource := fMasterDataSource;
  ceSumaMin.DataBinding.DataField := 'MIN_AMOUNT';

  ceSumaMax.DataBinding.DataSource := fMasterDataSource;
  ceSumaMax.DataBinding.DataField := 'MAX_AMOUNT';

  ceLuniMin.DataBinding.DataSource := fMasterDataSource;
  ceLuniMin.DataBinding.DataField := 'MIN_MONTH';

  ceLuniMax.DataBinding.DataSource := fMasterDataSource;
  ceLuniMax.DataBinding.DataField := 'MAX_MONTH';

  ceDobinda.DataBinding.DataSource := fMasterDataSource;
  ceDobinda.DataBinding.DataField := 'PERCENT';

  ceComision.DataBinding.DataSource := fMasterDataSource;
  ceComision.DataBinding.DataField := 'BUYER_COMISION';

  cePrimaRata.DataBinding.DataSource := fMasterDataSource;
  cePrimaRata.DataBinding.DataField := 'PREPAY_PERCENT';

  cbActive.DataBinding.DataSource := fMasterDataSource;
  cbActive.DataBinding.DataField := 'FLG_ACTIVE';
  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    beCustomerName.Text := '';
  end
  else
  begin
    fMasterDataSet.Edit;
    beCustomerName.Text := fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString;
  end;

end;

procedure TfrmCrediteEditorDlg.SelectCustomer;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
//    dialog.CustomFilter := [cfFirms];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CUSTOMERID').asInteger, False, 0, 'Alegerea companiei de finantare') then
    begin
      fMasterDataSet.FieldByName('CUSTOMERID').asInteger := dialog.CustomerID;
      beCustomerName.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCrediteEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmCrediteEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in [dsEdit, dsInsert] then
    fMasterDataSet.Cancel;
end;

end.


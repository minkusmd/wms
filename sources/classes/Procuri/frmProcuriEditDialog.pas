unit frmProcuriEditDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SWNBaseUnit, DialogTitle, Menus, cxButtonEdit, cxDBEdit,
  StdCtrls, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit;

type
  TfrmProcuriEditDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    edPROCURA_NO: TcxDBMaskEdit;
    edDELEGAT: TcxDBTextEdit;
    deDATA_START: TcxDBDateEdit;
    cxLabel4: TLabel;
    deDATA_END: TcxDBDateEdit;
    cxLabel5: TLabel;
    beCUSTOMER: TcxButtonEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewProcura: Boolean;
    fRequiredCustomerID: Integer;
    procedure SetCreateNewProcura(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SelectCustomer;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    property CreateNewProcura: Boolean read FCreateNewProcura write SetCreateNewProcura;
    property RequiredCustomerID: Integer read fRequiredCustomerID write fRequiredCustomerID;
  end;

implementation

uses DB, SWNUtils, SWNConst, frmCustomersDlg, DataModuleDB, SWNCustomersTypesUnit;

{$R *.dfm}
{ TfrmProcuriEditDlg }

procedure TfrmProcuriEditDlg.beCUSTOMERPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCustomer;
end;

function TfrmProcuriEditDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  if fMasterDataSet.FieldByName('PROCURA_NO').IsNull or (fMasterDataSet.FieldByName('PROCURA_NO').AsString = '') then
    AddErrorToStr(ErrorStr, 'Numarul procurii!');
  if fMasterDataSet.FieldByName('DELEGAT').IsNull or (fMasterDataSet.FieldByName('DELEGAT').AsString = '') then
    AddErrorToStr(ErrorStr, 'Persoana imputernicita!');
  if fMasterDataSet.FieldByName('CUSTOMERID').IsNull then
    AddErrorToStr(ErrorStr, 'Firma!');
  if fMasterDataSet.FieldByName('DATA_START').IsNull or fMasterDataSet.FieldByName('DATA_END').IsNull then
    AddErrorToStr(ErrorStr, 'Perioada de valabilitate!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmProcuriEditDlg.BindingDataSource;
begin
  inherited;

  FCreateNewProcura := False;
  fRequiredCustomerID := -1;

  edPROCURA_NO.DataBinding.DataSource := fMasterDataSource;
  edDELEGAT.DataBinding.DataSource := fMasterDataSource;
  deDATA_START.DataBinding.DataSource := fMasterDataSource;
  deDATA_END.DataBinding.DataSource := fMasterDataSource;

end;

function TfrmProcuriEditDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmProcuriEditDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewProcura then
    begin
      dtDialogTitle.Text := 'Creare procura noua';
      fMasterDataSet.Append;

      if fRequiredCustomerID <> -1 then
      begin
        fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := fRequiredCustomerID;
        beCUSTOMER.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger);
        beCUSTOMER.Enabled := False;
      end;

      fMasterDataSet.FieldByName('DATA_START').AsDateTime := NOW;
      fMasterDataSet.FieldByName('DATA_END').AsDateTime := NOW + 30;
      fMasterDataSet.FieldByName('CREATED_BY').AsInteger := dmDB.CurrentUserID;

    end
    else
    begin
      dtDialogTitle.Text := 'Modificare procura';

      fMasterDataSet.Edit;
      beCUSTOMER.Text := fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString;
    end;
  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmProcuriEditDlg.SelectCustomer;
var
  dialog: TfrmCustomersDlg;
  custID: Integer;
begin
  custID := -1;
  if fMasterDataSet.FieldByName('CUSTOMERID').IsNull then
  begin
    if (fRequiredCustomerID <> -1) then
      custID := fRequiredCustomerID;
  end
  else
    custID := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;

  dialog := TfrmCustomersDlg.Create(self);
  try
    dialog.CustomFilter := [cfCustomers];
    if dialog.SelectCustomer(custID, False, 0, 'Selectare firma pentru Procura') then
    begin
      fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := dialog.CustomerID;
      beCUSTOMER.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmProcuriEditDlg.SetCreateNewProcura(const Value: Boolean);
begin
  FCreateNewProcura := Value;
end;

procedure TfrmProcuriEditDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

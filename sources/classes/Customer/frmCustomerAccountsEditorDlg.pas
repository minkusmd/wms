unit frmCustomerAccountsEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit,
  Dialogs, DialogTitle,
  Menus, DB, IBC,
  cxDBEdit,

  StdCtrls, ExtCtrls,
  cxButtonEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxMaskEdit, cxCheckBox, cxTextEdit, dxCoreGraphics;

type
  TfrmCustomerAccountEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnAccount: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    edAccountName: TcxDBTextEdit;
    cxLabel3: TLabel;
    cbDefaultAccount: TcxDBCheckBox;
    beBank: TcxButtonEdit;
    edAccountNumber: TcxDBMaskEdit;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    cbContCurent: TcxDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure beBankPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edAccountNumberPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    fOldBankAccount: String;
    FCreateNewAccount: Boolean;
    function CheckParams: Boolean;
    procedure CreateNewBank;
    procedure SetCreateNewAccount(const Value: Boolean);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewAccount: Boolean read FCreateNewAccount
      write SetCreateNewAccount;

  end;

implementation

uses SWNUtils, SWNConst, frmBanksBrowse;

{$R *.dfm}

procedure TfrmCustomerAccountEditorDialog.FormCreate(Sender: TObject);
begin

end;

{ TfrmCustomerAccountEditorDialog }

procedure TfrmCustomerAccountEditorDialog.beBankPropertiesButtonClick
  (Sender: TObject; AButtonIndex: Integer);
begin
  CreateNewBank;
end;

function TfrmCustomerAccountEditorDialog.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if FieldByName('ACCOUNTNUMBER').IsNull or
      (Trim(FieldByName('ACCOUNTNUMBER').AsString) = '') then
      AddErrorToStr(ErrorStr, 'IBAN!');
    if FieldByName('ACCOUNTNAME').IsNull or
      (Trim(FieldByName('ACCOUNTNAME').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Denumire cont!');
    if FieldByName('BANKACCOUNT').IsNull then
      AddErrorToStr(ErrorStr, 'Banca!');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmCustomerAccountEditorDialog.CreateNewBank;
var
  Banks: TfrmBanksBrowserDlg;
begin
  Banks := TfrmBanksBrowserDlg.Create(Self);
  try
    if Banks.SelectBank(fMasterDataSet.FieldByName('BANKACCOUNT').AsString) then
    begin
      beBank.Text := Format('%s - %s', [Banks.BankAccount, Banks.BankName]);
      fMasterDataSet.FieldByName('BANKACCOUNT').AsString := Banks.BankAccount;
    end;
  finally
    Banks.Free;
  end;
end;

procedure TfrmCustomerAccountEditorDialog.edAccountNumberPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  Error := false;
  if Length(DisplayValue)<24 then
  begin
     ErrorText := 'EROARE! IBAN mai mic de 24 simboluri!';
     Error := True;
  end;
end;

procedure TfrmCustomerAccountEditorDialog.BindingDataSource;
begin
  inherited;

  FCreateNewAccount := False;

  edAccountNumber.DataBinding.DataSource := fMasterDataSource;
  edAccountName.DataBinding.DataSource := fMasterDataSource;
  cbDefaultAccount.DataBinding.DataSource := fMasterDataSource;
  cbContCurent.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerAccountEditorDialog.IsFormDataPosted: Boolean;
begin
    if CheckParams then
    begin
        fMasterDataSet.Post;
        Result := True;
    end
    else
        Result := False;
end;

procedure TfrmCustomerAccountEditorDialog.Prepare;
begin
  try
    if FCreateNewAccount then
    begin
        dtDialogTitle.Text := 'Crearea unui cont nou';
        fMasterDataSet.Append;
        fMasterDataSet.FieldByName('DEFAULT_ACCOUNT').AsInteger := Ord(fMasterDataSet.RecordCount = 0);
        fMasterDataSet.FieldByName('ACCOUNTNAME').AsString := 'Cont 1';
    end
    else
    begin
        dtDialogTitle.Text := 'Modifica cont';
        fMasterDataSet.Edit;
        fOldBankAccount := fMasterDataSet.FieldByName('BANKACCOUNT').AsString;
        beBank.Text := Format('%s - %s', [fMasterDataSet.FieldByName('BANKACCOUNT').AsString,
            fMasterDataSet.FieldByName('BANKNAME').AsString]);
    end;
  except
        fMasterDataSet.Cancel;
        raise;
  end;
end;

procedure TfrmCustomerAccountEditorDialog.SetCreateNewAccount
  (const Value: Boolean);
begin
  FCreateNewAccount := Value;
end;

procedure TfrmCustomerAccountEditorDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
end;

end.

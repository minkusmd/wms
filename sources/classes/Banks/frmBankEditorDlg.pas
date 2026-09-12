unit frmBankEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  IBC, SWNBaseUnit,
  Dialogs, Menus, cxDBEdit,
  ExtCtrls, StdCtrls,
  DialogTitle, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMemo;

type
  TfrmBankEditorDialog = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnCard: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    mmAddress: TcxDBMemo;
    edBancAccount: TcxDBTextEdit;
    edBankName: TcxDBTextEdit;
    edSWIFT: TcxDBTextEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
  private
    { Private declarations }
    FCreateNewBank: boolean;
    function CheckParams: boolean;
    procedure SetCreateNewBank(const Value: boolean);
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewBank: boolean read FCreateNewBank write SetCreateNewBank;
  end;

implementation

uses SWNUtils, SWNConst;

{$R *.dfm}
{ TfrmBankEditorDialog }

function TfrmBankEditorDialog.CheckParams: boolean;
var
  ErrorStr: String;
begin
  Result := false;
  ErrorStr := '';
  with fMasterDataSet do
  begin
    if FieldByName('BANKACCOUNT').IsNull or
      (Trim(FieldByName('BANKACCOUNT').AsString) = '') then
      AddErrorToStr(ErrorStr, 'MFO?');
    if FieldByName('BANKNAME').IsNull or
      (Trim(FieldByName('BANKNAME').AsString) = '') then
      AddErrorToStr(ErrorStr, 'Denumirea bancii?');
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text,
      ErrorStr);
end;

procedure TfrmBankEditorDialog.BindingDataSource;
begin
  inherited;

  FCreateNewBank := false;

  mmAddress.DataBinding.DataSource := fMasterDataSource;
  edBancAccount.DataBinding.DataSource := fMasterDataSource;
  edBankName.DataBinding.DataSource := fMasterDataSource;
  edSWIFT.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmBankEditorDialog.IsFormDataPosted: boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := false;
end;

procedure TfrmBankEditorDialog.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewBank then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Append;
    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrare';
      fMasterDataSet.Edit;
    end;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmBankEditorDialog.SetCreateNewBank(const Value: boolean);
begin
  FCreateNewBank := Value;
end;

procedure TfrmBankEditorDialog.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.

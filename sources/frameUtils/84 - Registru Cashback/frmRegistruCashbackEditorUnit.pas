unit frmRegistruCashbackEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxContainer, cxEdit, cxMemo,
  cxDBEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls,
  cxPC, cxCheckListBox, cxDBCheckListBox, cxCheckBox, cxButtonEdit, cxCalc,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, dxBarBuiltInMenu,
  cxCustomListBox, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxGridCustomView, cxGrid, cxClasses, dxBar, Vcl.ExtCtrls,
  dxDateRanges, DBAccess, IBC, MemDS, dxScrollbarAnnotations, cxLabel, cxImage;

type
  TfrmRegistruCashbackEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    deSTART_DATE: TcxDBDateEdit;
    deEND_DATE: TcxDBDateEdit;
    beCustomer: TcxButtonEdit;
    ceCashbackAmount: TcxDBCalcEdit;
    procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewRecord: Boolean;
    procedure SetCreateNewRecord(const Value: Boolean);
    function CheckInputValues: Boolean;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions, DataModuleDB, SWNConst, SWNUtils, System.Math,
  frmGoodsGroupsManagerDialog, frmCustomersDlg, SWNValueStorageUnit;

procedure TfrmRegistruCashbackEditorDlg.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
  OK: Boolean;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if AButtonIndex = 0 then
    begin
      if ((beCustomer.Text <> '') and (beCustomer.Tag < 1)) then
        OK := dialog.SelectCustomerBySearch(beCustomer.Text, 'Selecteaza clientul')
      else
        OK := dialog.SelectCustomer(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger, False, 0, 'Selecteaza clientul');

      if OK then
      begin
        beCustomer.Text := dialog.CustomerTitle;
        fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString := dialog.CustomerTitle;

        fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := dialog.CustomerID;
        beCustomer.Tag := dialog.CustomerID;
      end;
    end
    else
    begin
      beCustomer.Text := '';
      beCustomer.Tag := -1;
    end;

  finally
    dialog.Free;
  end;
end;

procedure TfrmRegistruCashbackEditorDlg.BindingDataSource;
begin
  deSTART_DATE.DataBinding.DataSource := fMasterDataSource;
  deEND_DATE.DataBinding.DataSource := fMasterDataSource;
  ceCashbackAmount.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmRegistruCashbackEditorDlg.CheckInputValues: Boolean;
var
  Errors: string;
begin
  Result := False;
  if Errors = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, Errors);
end;

function TfrmRegistruCashbackEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckInputValues then
  begin
    fMasterDataSet.Post;
    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;

    AppUserConfigStorage.DateTimeValues.SetValue('Cashback_data_start', fMasterDataSet.FieldByName('DATA_START').AsDateTime);
    AppUserConfigStorage.DateTimeValues.SetValue('Cashback_data_end', fMasterDataSet.FieldByName('DATA_END').AsDateTime);
    AppUserConfigStorage.TextValues.SetValue('Cashback_amount', fMasterDataSet.FieldByName('AMOUNT').AsString);

    Result := True;
  end;
end;

procedure TfrmRegistruCashbackEditorDlg.Prepare;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Inregistrare noua';
      fMasterDataSet.Insert;

      fMasterDataSet.FieldByName('DATA_START').AsDateTime :=  AppUserConfigStorage.DateTimeValues.GetValue('Cashback_data_start', Date);
      fMasterDataSet.FieldByName('DATA_END').AsDateTime := AppUserConfigStorage.DateTimeValues.GetValue('Cashback_data_end', Date);
      fMasterDataSet.FieldByName('DATA').AsDateTime := NOW;
      fMasterDataSet.FieldByName('AMOUNT').AsString :=  AppUserConfigStorage.TextValues.GetValue('Cashback_amount', '0');

    end
    else
    begin
      dtDialogTitle.Text := 'Modifica inregistrarea';
      beCustomer.Text := fMasterDataSet.FieldByName('CUSTOMER_NAME').AsString;
      beCustomer.Tag := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
      fMasterDataSet.Edit;
    end;

  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmRegistruCashbackEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  FCreateNewRecord := Value;
end;

procedure TfrmRegistruCashbackEditorDlg.WhenCancelForm;
begin
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;

  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

end.


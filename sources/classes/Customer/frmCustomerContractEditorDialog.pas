unit frmCustomerContractEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls,
  cxImage, cxDBEdit, cxDropDownEdit, cxCalendar, cxMaskEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, Vcl.ExtCtrls, DialogTitle,
  SWNBaseUnit, Data.DB, DBAccess, IBC, MemDS, Vcl.Buttons, cxButtonEdit,
  cxCheckBox, cxCalc, dxCoreGraphics, dxUIAClasses;

type
  TfrmCustomerContractEditorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lcbDT: TcxDBLookupComboBox;
    deSIGN_DATE: TcxDBDateEdit;
    deEXPIRE_DATE: TcxDBDateEdit;
    cmbPRICE_COLUMN: TcxDBComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDT: TIBCQuery;
    IBCDataSourceDT: TIBCDataSource;
    Label9: TLabel;
    lcbCURRENCYID: TcxDBLookupComboBox;
    beContractType: TcxButtonEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    beCT_NAME: TcxButtonEdit;
    Label8: TLabel;
    Label10: TLabel;
    beDT_RESP: TcxButtonEdit;
    beCT_RESP: TcxButtonEdit;
    cmbVAT: TcxDBComboBox;
    Label11: TLabel;
    beContractCode: TcxDBButtonEdit;
    cbFLG_DefaultContract: TcxDBCheckBox;
    Label12: TLabel;
    ceRagazPlata: TcxDBCalcEdit;
    ceDELIVERY_TERM_DAYS: TcxDBCalcEdit;
    Label13: TLabel;
    teDeliveryPlace: TcxDBTextEdit;
    Label14: TLabel;
    procedure beContractTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beDT_RESPPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_RESPPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beContractCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewRecord: Boolean;
    fCT: integer;
    procedure SetCreateNewRecord(const Value: Boolean);
    procedure SetCT(const Value: integer);
    function CheckValues: Boolean;
    procedure ShowSelectCustomerDialog;
    procedure SelectDtResponsablePerson;
    procedure SelectCtResponsablePerson;
  protected
    { protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewRecord: Boolean read FCreateNewRecord write SetCreateNewRecord;
    property CT: integer read FCT write SetCT;
    procedure DisableCT;
  end;

implementation

{$R *.dfm}

uses
  DataModuleDB, SWNUtils, SWNConst, frmContractTypeDialog, SWNSecurityFlags,
  DataModuleAdditions, System.UITypes, frmCustomersDlg, SWNCustomersTypesUnit, frmCustomerContractsDialog;

{ TfrmCustomerContractEditorDlg }

procedure TfrmCustomerContractEditorDlg.beContractCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  y,m,d: Word;
begin
   DecodeDate(Date, y,m,d);
   fMasterDataSet.FieldByName('CODE').AsString := FormatDateTime('yyyymmdd',Date) +' / 1';
   beContractCode.Text := FormatDateTime('yyyymmdd',Date) +' / 1';
end;

procedure TfrmCustomerContractEditorDlg.beContractTypePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmContractTypeDlg;
begin
  dialog := TfrmContractTypeDlg.Create(Self);
  try
    dialog.SelectMode := True;
    if not fMasterDataSet.FieldByName('CONTRACT_TYPE').IsNull then
      dialog.ContractTypeID := fMasterDataSet.FieldByName('CONTRACT_TYPE').AsInteger;
    if dialog.ShowModal = mrOK then
    begin
      fMasterDataSet.FieldByName('CONTRACT_TYPE').AsInteger := dialog.ContractTypeID;
      beContractType.Text := dialog.ContractTypeTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerContractEditorDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectCustomerDialog;
end;

procedure TfrmCustomerContractEditorDlg.beCT_RESPPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCtResponsablePerson;
end;

procedure TfrmCustomerContractEditorDlg.beDT_RESPPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDtResponsablePerson;
end;

function TfrmCustomerContractEditorDlg.CheckValues: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  if fMasterDataSet.FieldByName('CODE').IsNull or (fMasterDataSet.FieldByName('CODE').asString = '') then
    AddErrorToStr(ErrorStr, 'Numarul contractului!');
  if fMasterDataSet.FieldByName('DT').IsNull or (fMasterDataSet.FieldByName('DT').asInteger <= 0) then
    AddErrorToStr(ErrorStr, 'Intreprinderea!');
  if fMasterDataSet.FieldByName('CT').IsNull or (fMasterDataSet.FieldByName('CT').asInteger <= 0) then
    AddErrorToStr(ErrorStr, 'Client!');
  if fMasterDataSet.FieldByName('SIGN_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Data semnarii!');
  if fMasterDataSet.FieldByName('EXPIRE_DATE').IsNull then
    AddErrorToStr(ErrorStr, 'Data finisarii!');
  if fMasterDataSet.FieldByName('CONTRACT_TYPE').IsNull or (fMasterDataSet.FieldByName('CONTRACT_TYPE').asInteger <= 0) then
    AddErrorToStr(ErrorStr, 'Tipul contractului');
  if fMasterDataSet.FieldByName('PRICE_COLUMN').IsNull then
    AddErrorToStr(ErrorStr, 'Grila de preturi!');
  if fMasterDataSet.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Valuta!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCustomerContractEditorDlg.DisableCT;
begin
  beCT_NAME.Properties.Buttons.Clear;
end;

procedure TfrmCustomerContractEditorDlg.BindingDataSource;
begin
  fCreateNewRecord := False;
  fCT := -1;

  beContractCode.DataBinding.DataSource := fMasterDataSource;
  lcbDT.DataBinding.DataSource := fMasterDataSource;
  deSIGN_DATE.DataBinding.DataSource := fMasterDataSource;
  deEXPIRE_DATE.DataBinding.DataSource := fMasterDataSource;
  cmbPRICE_COLUMN.DataBinding.DataSource := fMasterDataSource;
  lcbCURRENCYID.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACNT.DataBinding.DataSource := fMasterDataSource;
  cbFLG_DefaultContract.DataBinding.DataSource := fMasterDataSource;
  cmbVAT.DataBinding.DataSource := fMasterDataSource;
  ceRagazPlata.DataBinding.DataSource := fMasterDataSource;
  ceDELIVERY_TERM_DAYS.DataBinding.DataSource := fMasterDataSource;
  teDeliveryPlace.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmCustomerContractEditorDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckValues then
  begin
    fMasterDataSet.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  end;
end;

procedure TfrmCustomerContractEditorDlg.Prepare;
var
  y,m,d: Word;
begin
  beCT_NAME.Text := '';
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if fCreateNewRecord then
    begin
      dtDialogTitle.Text := 'Crearea unui contract nou';
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
      fMasterDataSet.FieldByName('PRICE_COLUMN').AsInteger := 1;
      fMasterDataSet.FieldByName('SIGN_DATE').AsDateTime := NOW;
      fMasterDataSet.FieldByName('EXPIRE_DATE').AsString := '31.12.' + IntToStr(CurrentYear);
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
      fMasterDataSet.FieldByName('FLG_DEFAULT').AsInteger := 1;
      fMasterDataSet.FieldByName('VAT').AsInteger := 20;
      fMasterDataSet.FieldByName('CURRENCYID').AsInteger := 498;
      fMasterDataSet.FieldByName('CONTRACT_TYPE').AsInteger := 30;


     DecodeDate(Date, y,m,d);
     fMasterDataSet.FieldByName('CODE').AsString := FormatDateTime('yyyymmdd',Date) +' / 1';
     beContractCode.Text := FormatDateTime('yyyymmdd',Date) +' / 1';


      if (fCT > 0) then
      begin
        fMasterDataSet.FieldByName('CT').AsInteger := fCT;
        fMasterDataSet.FieldByName('CT_RESPONSABILE_PERSON').AsInteger := fCT;
        beCT_NAME.Text := dmDB.GetCustomerDisplayName(fCT);
        beCT_RESP.Text := beCT_NAME.Text;
      end;
    end
    else
    begin
      dtDialogTitle.Text := 'Modificarea contractului';
      fMasterDataSet.Edit;
      beCT_NAME.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;
      beDT_RESP.Text := fMasterDataSet.FieldByName('DT_RESPONSABILE_PERSON_NAME').AsString;
      beCT_RESP.Text := fMasterDataSet.FieldByName('CT_RESPONSABILE_PERSON_NAME').AsString;
      beContractType.Text := fMasterDataSet.FieldByName('CONTRACT_TYPE_TITLE').AsString;
    end;
    IBCQueryDT.Active := True;
    dmDB.IBCQueryCurrency.Active := True;
  except
    on E: Exception do
    begin
      fMasterDataSet.Cancel;
      fMasterDataSet.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmCustomerContractEditorDlg.SelectCtResponsablePerson;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT_RESPONSABILE_PERSON').AsInteger, False, 0, 'Selectati persoana responsabila a contraagentului') then
    begin
      fMasterDataSet.FieldByName('CT_RESPONSABILE_PERSON').AsInteger := dialog.CustomerID;
      beCT_RESP.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerContractEditorDlg.SelectDtResponsablePerson;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfColaboratori];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('DT_RESPONSABILE_PERSON').AsInteger, False, 0, 'Selectati persoana responsabila a firmei') then
    begin
      fMasterDataSet.FieldByName('DT_RESPONSABILE_PERSON').AsInteger := dialog.CustomerID;
      beDT_RESP.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerContractEditorDlg.SetCreateNewRecord(const Value: Boolean);
begin
  fCreateNewRecord := Value;
end;

procedure TfrmCustomerContractEditorDlg.SetCT(const Value: integer);
begin
  fCT := Value;
end;

procedure TfrmCustomerContractEditorDlg.SetupSecurityItems;
begin
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Типы_контрактов) then
  begin
    beContractType.Properties.Buttons[0].Visible := False;
  end;
end;

procedure TfrmCustomerContractEditorDlg.ShowSelectCustomerDialog;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').AsInteger, False, 0, 'Alege clientul') then
    begin
      beCT_NAME.Text := dialog.CustomerTitle;
      fMasterDataSet.FieldByName('CT').AsInteger := dialog.CustomerID;
      fMasterDataSet.FieldByName('CT_RESPONSABILE_PERSON').AsInteger := dialog.CustomerID;
      beCT_RESP.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCustomerContractEditorDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

end.


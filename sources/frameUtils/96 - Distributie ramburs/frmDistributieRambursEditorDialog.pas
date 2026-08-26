unit frmDistributieRambursEditorDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxDBEdit, cxDropDownEdit, cxCalc, cxLabel, cxTextEdit,
  cxMaskEdit, cxButtonEdit, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons, Data.DB, MemDS,
  DBAccess, IBC, dxUIAClasses, dxCoreGraphics;

type
  TfrmDistributieRambursEditorDlg = class(TSWNMasteredFormClass)
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Panel1: TPanel;
    cxLabel1: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel3: TcxLabel;
    ceComision: TcxDBCalcEdit;
    cePretLivrare: TcxDBCalcEdit;
    ceRamburs: TcxDBCalcEdit;
    beCustomer: TcxButtonEdit;
    beContract: TcxButtonEdit;
    lbContractInfo: TcxLabel;
    cxLabel2: TcxLabel;
    beAWB: TcxDBButtonEdit;
    Label1: TLabel;
    beRefererDoc: TcxDBButtonEdit;
    lbContractTitle: TLabel;
    procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beAWBPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beRefererDocPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FDocumentDate: TDateTime;
    FIsNewRecord: Boolean;
    fSECURITY_ALLOW_CONTRACT: boolean;
    procedure SetIsNewRecord(const Value: Boolean);
    function CheckParams: Boolean;
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
    procedure SetDocumentDate(const Value: TDateTime);
    { Private declarations }
  protected    { Protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: boolean; override;
    procedure WhenCancelForm; override;
    procedure BindingDataSource; override;
    procedure SetupSecurityItems; override;
    procedure SelectCustomer;

  public
    property DocumentDate: TDateTime read FDocumentDate write SetDocumentDate;
    property IsNewRecord: Boolean read FIsNewRecord write SetIsNewRecord;
    { Public declarations }
  end;

var
  frmDistributieRambursEditorDlg: TfrmDistributieRambursEditorDlg;

implementation

uses
  SWNUtils, SWNConst, frmCustomersDlg, SWNSecurityFlags, frmCustomerContractsDialog,
  frmDocumentBrowserDialog, DataModuleDB;

{$R *.dfm}

{ TfrmDistributieRambursDlg }

procedure TfrmDistributieRambursEditorDlg.beAWBPropertiesButtonClick(Sender: TObject; AButtonIndex:
  Integer);
var
  q: TIBCQuery;
begin
    // get info from awb
  q := TIBCQuery.Create(self);
  try
    q.SQL.Text := 'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME FROM GET_AWB_FULLINFO(:AWB)';
    q.ParamByName('awb').AsString := beAWB.Text;
    q.Open;

    beCustomer.Tag := q.FieldByName('CUSTOMERID').AsInteger;
    beCustomer.Text := q.FieldByName('CUSTOMER_NAME').AsString;
    fMasterDataSet.FieldByName('CUSTOMERID').AsInteger := beCustomer.Tag;

    if fSECURITY_ALLOW_CONTRACT then
      LoadDefaultContract(beCustomer.Tag, DocumentDate);
  finally
    q.Free;
  end;
end;

procedure TfrmDistributieRambursEditorDlg.beContractPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger,
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s от %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
      FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmDistributieRambursEditorDlg.beCustomerPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  SelectCustomer;
end;

procedure TfrmDistributieRambursEditorDlg.beRefererDocPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  d: TfrmDocumentBrowserDlg;
begin
  d := TfrmDocumentBrowserDlg.Create(self, fMasterDataSet.Connection);
  try
    d.DefaultDocTypeID := 107;
    if d.ShowModal=mrOK then
    begin
      fMasterDataSet.Edit;
      fMasterDataSet.FieldByName('REFERER_DOCID').AsInteger := d.DocID;
      fMasterDataSet.FieldByName('RAMBURS').AsFloat :=  d.DocSuma;
    end;
  finally
    d.Free;
  end;
end;

procedure TfrmDistributieRambursEditorDlg.BindingDataSource;
begin
  beAWB.DataBinding.DataSource := fMasterDataSource;
  ceRamburs.DataBinding.DataSource := fMasterDataSource;
  cePretLivrare.DataBinding.DataSource := fMasterDataSource;
  ceComision.DataBinding.DataSource := fMasterDataSource;
  beRefererDoc.DataBinding.DataSource := fMasterDataSource;
end;

function TfrmDistributieRambursEditorDlg.IsFormDataPosted: boolean;
begin
  if CheckParams then
  begin
    try
      try
        if fMasterDataSet.State in dsEditModes then
          fMasterDataSet.Post;
        if fMasterDataSet.UpdateTransaction.Active then
          fMasterDataSet.UpdateTransaction.Commit;
        fMasterDataSet.RefreshRecord;
        Result := True
      except
        on e: Exception do
        begin
          Result := false;
          raise;
        end;
      end;
    finally
      fMasterDataSet.RefreshRecord;
    end;
  end;
end;

procedure TfrmDistributieRambursEditorDlg.Prepare;
begin
  inherited;
  if not fMasterDataSet.UpdateTransaction.Active then
  begin
    fMasterDataSet.UpdateTransaction.StartTransaction;
  end;
  if IsNewRecord then
  begin
    fMasterDataSet.Append;
    beCustomer.Text := '';
    beCustomer.Tag := -1;
    fMasterDataSet.FieldByName('COMISION').AsFloat := 0;
    fMasterDataSet.FieldByName('PRET_LIVRARE').AsFloat := 0;
    fMasterDataSet.FieldByName('RAMBURS').AsFloat := 0;
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := -1;
  end
  else
  begin
    fMasterDataSet.Edit;
    beCustomer.Text := fMasterDataSet.FieldByName('Customer_Name').AsString;
    beCustomer.Tag := fMasterDataSet.FieldByName('CUSTOMERID').AsInteger;
  end;

end;

procedure TfrmDistributieRambursEditorDlg.SetIsNewRecord(const Value: Boolean);
begin
  FIsNewRecord := Value;
end;

procedure TfrmDistributieRambursEditorDlg.SetupSecurityItems;
begin
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_БО_ПДНС_Показывать_Контракт);
end;

procedure TfrmDistributieRambursEditorDlg.WhenCancelForm;
begin
  inherited;
  if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Cancel;
  if fMasterDataSet.UpdateTransaction.Active then
    fMasterDataSet.UpdateTransaction.Rollback;
end;

function TfrmDistributieRambursEditorDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';
  if True then
    if fMasterDataSet.FieldByName('REFERER_DOCID').AsString = '' then
      ErrorStr := 'Eroare! Indicati documentul de referinta pentru plata! (Factura Fiscala sau Rezerva)';
    if fMasterDataSet.FieldByName('AWB').AsString = '' then
       ErrorStr := 'Eroare! Complectati AWB';
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmDistributieRambursEditorDlg.SelectCustomer;
var
  dialog: TfrmCustomersDlg;
  IsCustomerSelected: Boolean;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if ((beCustomer.Text <> '')) then
      IsCustomerSelected := dialog.SelectCustomerBySearch(beCustomer.Text, 'Selecteaza clientul')
    else
      IsCustomerSelected := dialog.SelectCustomer(fMasterDataSet.FieldByName('CUSTOMERID').AsInteger, False, 0,
        'Selecteaza clientul');

    if IsCustomerSelected then
    begin
      fMasterDataSet.FieldByName('CUSTOMERID').asInteger := dialog.CustomerID;
      beCustomer.Text := dialog.CustomerTitle;
      beCustomer.Tag := dialog.CustomerID;

      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, DocumentDate);
    end;

  finally
    dialog.Free;
  end;
end;

procedure TfrmDistributieRambursEditorDlg.LoadDefaultContract(const CustomerID: Integer; const
  DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := frmCustomerContractsDialog.LoadCustomerDefaultContractInfo(dmdb.CurrentFirma, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
      FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
    if contractInfo.FLG_ACNT then
    begin
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
    end;
    lbContractInfo.Visible := True;

    contractInfo.Free;
  end
  else
  begin
    fMasterDataSet.FieldByName('CONTRACTID').Value := -1;
    beContract.Text := 'Fara contract';
  end;
end;

procedure TfrmDistributieRambursEditorDlg.SetDocumentDate(const Value: TDateTime);
begin
  FDocumentDate := Value;
end;

end.


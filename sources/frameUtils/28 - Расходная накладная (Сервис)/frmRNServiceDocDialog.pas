unit frmRNServiceDocDialog;

// Возврат товара

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle,
  Data.DB, IBC, Vcl.StdCtrls,
  cxButtonEdit, cxDBEdit,
  cxDBLookupComboBox, Vcl.ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxCheckBox, cxCalendar, cxMemo, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxTextEdit, cxMaskEdit, cxCalc, dxUIAClasses, dxCoreGraphics;

type
  TfrmRNServiceDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    edINBAZA: TcxDBTextEdit;
    cxLabel8: TLabel;
    cxLabel7: TLabel;
    cxLabel5: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    ceRateUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    lcbCURRENCY: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    FCustomCT: Integer;
    FCustomStock: Integer;
    FCustomCurrency: Integer;
    FReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure SetCustomCT(const Value: Integer);
    procedure SetCustomStock(const Value: Integer);
    procedure SetCustomCurrency(const Value: Integer);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure ShowSelectContractDialog;
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
    procedure SetReadOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
    property CustomCT: Integer read FCustomCT write SetCustomCT;
    property CustomStock: Integer read FCustomStock write SetCustomStock;
    property CustomCurrency: Integer read FCustomCurrency write SetCustomCurrency;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog,
  frmCustomerContractsDialog, SWNSecurityFlags;

{$R *.dfm}
{ TfrmConfigurationDocDlg }

procedure TfrmRNServiceDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmRNServiceDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmRNServiceDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmRNServiceDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!');
    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Organizatie!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Furnizor!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata documentului!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmRNServiceDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmRNServiceDocDlg.FormCreate(Sender: TObject);
begin
  FCustomCT := -1;
  FCustomStock := -1;
  FCustomCurrency := -1;
  FReadOnly := False;
  fCreateNewDocument := False;
end;

function TfrmRNServiceDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;

    dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmRNServiceDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0, 'Alege Clientul pentru documentul "Rezerva"') then
    begin
      if dialog.ItemsChanged then
      begin
        dmDB.IBCQueryCustomers.Close;
        dmDB.IBCQueryCustomers.Open;
      end;
      dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRNServiceDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: Integer;
  acnt: Boolean;
begin
  if (dmDB.IBCQueryDocs.State in dsEditModes) and (not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull) then
  begin
    currID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
    acnt := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := fRealRateValue;
  end;
end;

procedure TfrmRNServiceDocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
    begin
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
    end;
    lbContractInfo.Visible := True;

    contractInfo.Free;
  end
  else
  begin
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').Value := Null;
    beContract.Text := '';
    cbFLG_ACNT.Enabled := True;
  end;
end;

procedure TfrmRNServiceDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmRNServiceDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  if fCreateNewDocument then
    ActiveControl := beCT_NAME
  else
    ActiveControl := lcbDTDEP;

  ceRateUSD.DataBinding.DataSource := dmdb.IBCDataSourceDocs;
  beContract.Text := '';

  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;

    dmDB.IBCQueryStocks.FilterSQL := 'STOCKID<>-1';
    dmDB.IBCQueryStocks.Active := True;

    if fCreateNewDocument then
    begin
             // Create new document
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
      dmDB.IBCQueryDocs.Insert;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
                  // dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // user defaults
      if FCustomCT <> -1 then
        dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := FCustomCT;
      if FCustomStock <> -1 then
        dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger := FCustomStock;
      if FCustomCurrency <> -1 then
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := FCustomCurrency;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, true);

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
             //deDATA.Properties.MinDate := NOW;
      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
    end
    else
    begin
      if FReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnOk.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (№%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
        end;
      end;
    end;

    fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

    IBCQueryDocProps.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;
  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    CloseAdditionalDataSources;
    raise;
  end;
end;

procedure TfrmRNServiceDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        // dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0, 'Alege furnizorul') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRNServiceDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, False, 0, 'Alege organizatia') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRNServiceDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmRNServiceDocDlg.SetCustomCT(const Value: Integer);
begin
  FCustomCT := Value;
end;

procedure TfrmRNServiceDocDlg.SetCustomCurrency(const Value: Integer);
begin
  FCustomCurrency := Value;
end;

procedure TfrmRNServiceDocDlg.SetCustomStock(const Value: Integer);
begin
  FCustomStock := Value;
end;

procedure TfrmRNServiceDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmRNServiceDocDlg.SetupSecurityItems;
begin
     // Контракт
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_ВТОК1_Показывать_Контракт);
  if not fSECURITY_ALLOW_CONTRACT then
  begin
    lbContractTitle.Visible := False;
    beContract.Visible := False;
    lbContractInfo.Visible := False;
    beContract.Properties.Buttons.Clear;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) then
    beContract.Properties.Buttons.Clear;
end;

procedure TfrmRNServiceDocDlg.ShowDocumentCommentsEditorDialog;
var
  dialog: TfrmDocumentCommentsEditorDlg;
begin
  dialog := TfrmDocumentCommentsEditorDlg.Create(Self, IBCQueryDocProps, IBCDataSourceDocProps);
  try
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRNServiceDocDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmRNServiceDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmRNServiceDocDlg.WhenCancelForm;
begin
  if not FReadOnly then
  begin
    IBCQueryDocProps.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

end.


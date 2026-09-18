unit frmBankBPPVDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, cxGraphics, DB, DBAccess, IBC,
  MemDS, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, StdCtrls, cxButtonEdit, cxLookAndFeels,
  cxLookAndFeelPainters, dxUIAClasses, dxCoreGraphics;

type
  TfrmBankBPPVDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCDataSourceDocProps: TIBCDataSource;
    IBCQueryDocProps: TIBCQuery;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    ceRATE: TcxDBCalcEdit;
    cxLabel6: TLabel;
    lcbCT_CD: TcxDBLookupComboBox;
    ceSUMA: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    lcbDT_CD: TcxDBLookupComboBox;
    deDATA: TcxDBDateEdit;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure ceSUMAPropertiesEditValueChanged(Sender: TObject);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fRealRateValue: double;
    fLastCurrencyID: integer;
    fCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    FReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure OpenDT_Accounts;
    procedure OpenCT_Accounts;
    procedure SetReadOnly(const Value: Boolean);
    procedure SumaChanged;
    procedure ShowDocumentCommentsEditorDialog;
    procedure ShowSelectContractDialog;
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
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
  end;

implementation

uses
  SWNDealsUnit,
  DateUtils, DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNTypes,
  frmCustomersDlg, SWNSecurityFlags, SWNSecurity, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNDBErrors, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmBankPDNSDlg }

procedure TfrmBankBPPVDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmBankBPPVDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmBankBPPVDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmBankBPPVDlg.ceSUMAPropertiesEditValueChanged(Sender: TObject);
begin
  SumaChanged;
end;

function TfrmBankBPPVDlg.CheckParams: Boolean;
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
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Organizatia!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica organizatiei!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Expeditor!');

    if IBCQueryRechizite.FieldByName('DT_CD').IsNull or (IBCQueryRechizite.FieldByName('DT_CD').AsString = '') then
      AddErrorToStr(ErrorStr, 'Contul curent al organizatiei!');
    if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
      AddErrorToStr(ErrorStr, 'Contul curent al expeditorului!');

    if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
      AddErrorToStr(ErrorStr, 'Suma!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Cursul documentului!')
    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
      AddErrorToStr(ErrorStr, 'Cursul documentului este subevaluat!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmBankBPPVDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmBankBPPVDlg.FormCreate(Sender: TObject);
begin
  fCreateNewDocument := False;
  FReadOnly := false;
end;

function TfrmBankBPPVDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if (not FReadOnly) and CheckParams then
  try
    dmDB.IBCQueryDocs.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmBankBPPVDlg.lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmBankBPPVDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: integer;
  acnt: Boolean;
  suma: Currency;
  rate: double;
begin
  if (dmDB.IBCQueryDocs.State in dsEditModes) and (not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull) then
  begin
    currID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
    acnt := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    suma := dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency;

    rate := 0;
    if dmDB.TransformCurrency1(suma, fLastCurrencyID, currID, acnt, suma, rate, (suma = 0), False) then
    begin
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := suma;
    end;
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := rate;

    fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
    fLastCurrencyID := currID;
  end;
end;

procedure TfrmBankBPPVDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmBankBPPVDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
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
  end;
end;

procedure TfrmBankBPPVDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmBankBPPVDlg.OpenCT_Accounts;
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
  if IBCQueryRechizite.State <> dsEdit then
    IBCQueryRechizite.Edit;
  if not IBCQueryCT_Accounts.Eof then
    IBCQueryRechizite.FieldByName('CT_CD').Value := IBCQueryCT_Accounts.FieldByName('ACCOUNTNUMBER').asString
  else
    IBCQueryRechizite.FieldByName('CT_CD').Value := NULL;
end;

procedure TfrmBankBPPVDlg.OpenDT_Accounts;
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
  if IBCQueryRechizite.State <> dsEdit then
    IBCQueryRechizite.Edit;
  if not IBCQueryDT_Accounts.Eof then
    IBCQueryRechizite.FieldByName('DT_CD').Value := IBCQueryDT_Accounts.FieldByName('ACCOUNTNUMBER').asString
  else
    IBCQueryRechizite.FieldByName('DT_CD').Value := NULL;
end;

procedure TfrmBankBPPVDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  beContract.Text := '';

  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // Currency adjust
        // Ordine de plata bancare, Lei
    if dmDB.CurrentDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœÀ then
      dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID=498'
    else
        // Ordine de plata bancare, Valuta
 if dmDB.CurrentDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœ¬ then
      dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID<>498';

    dmDB.IBCQueryCurrency.Active := True;

    IBCQueryRechizite.Active := True;
    IBCQueryDocProps.Active := True;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      dmDB.IBCQueryDocs.Append;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

             // local defaults
             // Currency adjust
      fLastCurrencyID := 498;
             // Ordine de plata bancare, Valuta
      if dmDB.CurrentDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœ¬ then
        fLastCurrencyID := 840;

      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := fLastCurrencyID;

      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      OpenDT_Accounts;
      OpenCT_Accounts;
    end
    else
    begin
      if FReadOnly then
      begin
                  // View Only
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;

        btnOk.Visible := False;
        btnCancel.Default := True;
        btnCancel.Caption := 'Inchide';
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;

      fLastCurrencyID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (nr.%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
        end;
      end;
    end;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not FReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    IBCQueryRechizite.Close;
    IBCQueryDocProps.Close;

    CloseAdditionalDataSources;

    raise;
  end;
  AttachDealToDialog(Self, dmDB.IBCQueryDocs);
end;

procedure TfrmBankBPPVDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Selectare expeditor pentru ' + dtDialogTitle.Title) then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      OpenCT_Accounts;
      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankBPPVDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Selectare organizatie pentru ' + dtDialogTitle.Title) then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankBPPVDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmBankBPPVDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmBankBPPVDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_ÃÓÊÌÓ_‚˚ÒÚ‡‚ÎˇÚ_Ó·‡ÚÌÛ˛_‰‡ÚÛ);

     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_¡Œ_¡œœ¬_œÓÍ‡Á˚‚‡Ú¸_ ÓÌÚ‡ÍÚ);
  if not fSECURITY_ALLOW_CONTRACT then
  begin
    lbContractTitle.Visible := False;
    beContract.Visible := False;
    lbContractInfo.Visible := False;
    beContract.Properties.Buttons.Clear;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_—Ô‡‚Ó˜ÌËÍË_ ÎËÂÌÚ˚_ ÓÌÚ‡ÍÚ˚_¿‰ÏËÌËÒÚËÓ‚‡ÌËÂ) then
    beContract.Properties.Buttons.Clear;
end;

procedure TfrmBankBPPVDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmBankBPPVDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmBankBPPVDlg.SumaChanged;
var
  S: string;
begin
  if dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').asInteger = 119 { Ordine de plata bancare, Lei (6) } then
  begin
    S := Format('Plata conform contului/contractului nr.  din  pentru echipament tehnic. Inclusiv TVA, %f lei', [dmDB.IBCQueryDocs.FieldByName('SUMA').asFloat / 6]);
    if not (IBCQueryDocProps.State in dsEditModes) then
      IBCQueryDocProps.Edit;
    IBCQueryDocProps.FieldByName('COMMENTS').AsString := S;
  end;
end;

procedure TfrmBankBPPVDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  IBCQueryDocProps.Close;
  IBCQueryRechizite.Close;
end;

procedure TfrmBankBPPVDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryCurrency.FilterSQL := '';
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

end.


unit frmBankPDNSKDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls, cxGraphics, DB, DBAccess, IBC,
  MemDS, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, StdCtrls, cxButtonEdit, cxLookAndFeels,
  cxLookAndFeelPainters, frameMoneyCounterUnit, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd,
  dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, dxPScxCommon, cxClasses, dxUIAClasses, dxCoreGraphics;

type
  TfrmBankPDNSKDlg = class(TSWNMasteredFormClass)
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
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    frameMoneyCounter: TframeMoneyCounter;
    Button1: TButton;
    dxComponentPrinter1: TdxComponentPrinter;
    dxComponentPrinter1Link1: TdxGridReportLink;
    IBCDataSourceDocs: TIBCDataSource;
    Label1: TLabel;
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
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fRealRateValue: double;
    fLastCurrencyID: integer;
    fCreateNewDocument: Boolean;
    FDataDoc: TDateTime;
    FDocTypeID: Integer;
    FIBAN: string;
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
    procedure SetDataDoc(const Value: TDateTime);
    procedure SetDocTypeID(const Value: Integer);
    procedure SetIBAN(const Value: string);
    procedure WhenBanknotesCounterSumaChanged(Sender: TObject);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property DataDoc: TDateTime read FDataDoc write SetDataDoc;
    property DocTypeID: Integer read FDocTypeID write SetDocTypeID;
    property IBAN: string read FIBAN write SetIBAN;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNTypes,
  frmCustomersDlg, SWNSecurityFlags, SWNSecurity, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNDBErrors, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmBankPDNSDlg }

procedure TfrmBankPDNSKDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmBankPDNSKDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmBankPDNSKDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmBankPDNSKDlg.Button1Click(Sender: TObject);
begin
   dxComponentPrinter1Link1.Preview;
end;

procedure TfrmBankPDNSKDlg.ceSUMAPropertiesEditValueChanged(Sender: TObject);
begin
  SumaChanged;
end;

function TfrmBankPDNSKDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with fMasterDataSet do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Beneficiar!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Platitor!');

    if IBCQueryRechizite.FieldByName('DT_CD').IsNull or (IBCQueryRechizite.FieldByName('DT_CD').AsString = '') then
      AddErrorToStr(ErrorStr, 'Cont de decontare a beneficiarului!');
    if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
      AddErrorToStr(ErrorStr, 'Cont de decontare a platitorului!');

    if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
      AddErrorToStr(ErrorStr, 'Suma!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Rata de schimb a documentului!');
//    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
//      AddErrorToStr(ErrorStr, 'Cursul documentului este subevaluat!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata de schimb a USD!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;


//function TfrmBankPDNSKDlg.CheckParams: Boolean;
//var
//  ErrorStr: string;
//begin
//  Result := False;
//  ErrorStr := '';
//
//  with fMasterDataSet do
//  begin
//    if FieldByName('DATA').IsNull then
//      AddErrorToStr(ErrorStr, 'Data documentului!');
//
//    if FieldByName('SC2').IsNull then
//      AddErrorToStr(ErrorStr, 'Analitica documentului!');
//
//    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
//      AddErrorToStr(ErrorStr, 'Organizatia!');
//    if FieldByName('DTSC').IsNull then
//      AddErrorToStr(ErrorStr, 'Analitica organizatiei!');
//
//    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
//      AddErrorToStr(ErrorStr, 'Expeditor!');
//
//    if IBCQueryRechizite.FieldByName('DT_CD').IsNull or (IBCQueryRechizite.FieldByName('DT_CD').AsString = '') then
//      AddErrorToStr(ErrorStr, 'Contul curent al organizatiei!');
//    if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
//      AddErrorToStr(ErrorStr, 'Contul curent al expeditorului!');
//
//    if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
//      AddErrorToStr(ErrorStr, 'Suma!');
//    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
//      AddErrorToStr(ErrorStr, 'Cursul documentului!')
//    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
//      AddErrorToStr(ErrorStr, 'Cursul documentului este subevaluat!');
//
//    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
//      AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
//  end;
//
//  if ErrorStr = '' then
//    Result := True
//  else
//    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
//end;

procedure TfrmBankPDNSKDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmBankPDNSKDlg.FormCreate(Sender: TObject);
begin
  fCreateNewDocument := False;
  FReadOnly := false;
end;

function TfrmBankPDNSKDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if (not FReadOnly) and CheckParams then
  try
    fMasterDataSet.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    fMasterDataSet.UpdateTransaction.Commit;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmBankPDNSKDlg.lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmBankPDNSKDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: integer;
  acnt: Boolean;
  suma: Currency;
  rate: double;
begin
  if (fMasterDataSet.State in dsEditModes) and (not fMasterDataSet.FieldByName('CURRENCYID').IsNull) then
  begin
    currID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;
    acnt := fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1;
    suma := fMasterDataSet.FieldByName('SUMA').AsCurrency;

    rate := 0;
    if dmDB.TransformCurrency1(suma, fLastCurrencyID, currID, acnt, suma, rate, (suma = 0), False) then
    begin
      fMasterDataSet.FieldByName('SUMA').AsCurrency := suma;
    end;
    fMasterDataSet.FieldByName('RATE').AsFloat := rate;

    fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
    fLastCurrencyID := currID;
  end;
end;

procedure TfrmBankPDNSKDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmBankPDNSKDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(Masterdataset.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (π%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    fMasterDataSet.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
    begin
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
    end;
    lbContractInfo.Visible := True;

    contractInfo.Free;
  end
  else
  begin
    fMasterDataSet.FieldByName('CONTRACTID').Value := Null;
    beContract.Text := '';
  end;
end;

procedure TfrmBankPDNSKDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmBankPDNSKDlg.OpenCT_Accounts;
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

procedure TfrmBankPDNSKDlg.OpenDT_Accounts;
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

procedure TfrmBankPDNSKDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  IBCDataSourceDocs.DataSet := fMasterDataSet;
  beContract.Text := '';

  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
        // Currency adjust
        // Ordine de plata bancare, Lei
    if fDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœÀ then
      dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID=498'
    else
        // Ordine de plata bancare, Valuta
 if fDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœ¬ then
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
      fMasterDataSet.Append;

      if fIBAN <> 'Toate conturile' then
      begin
          IBCQueryRechizite.Edit;
          IBCQueryRechizite.FieldByName('DT_CD').AsString := fIBAN;
      end;


      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := fDocTypeID;
             // system defaults
      if not dmDB.LoadDocumentDefaults(fDocTypeID, dmDB.CurrentFirma, TIBCQuery(fMasterDataSet), DocumentAdditionalFlags) then
      begin
        fMasterDataSet.FieldByName('SC2').AsInteger := -1;
        fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //fMasterDataSet.FieldByName('DTSC').AsInteger:=-1;
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      fMasterDataSet.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1);

             // local defaults
             // Currency adjust
      fLastCurrencyID := 498;
             // Ordine de plata bancare, Valuta
      if fDocTypeID = cDBID_DocType_¡¿Õ Œ¬— »≈_Œœ≈–¿÷»»_¡œœ¬ then
        fLastCurrencyID := 840;

      fMasterDataSet.FieldByName('CURRENCYID').AsInteger := fLastCurrencyID;

      fMasterDataSet.FieldByName('DATA').AsDateTime := NOW;
      fMasterDataSet.FieldByName('FLG_SEND').AsInteger := 0;
      fMasterDataSet.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CT').Value);

      OpenDT_Accounts;
      OpenCT_Accounts;
    end
    else
    begin
      if FReadOnly then
      begin
                  // View Only
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;

        btnOk.Visible := False;
        btnCancel.Default := True;
        btnCancel.Caption := 'Inchide';
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
        fMasterDataSet.Edit;
      end;

      fLastCurrencyID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;
      beDT_NAME.Text := fMasterDataSet.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(fMasterDataSet.FieldByName('CURRENCYID').AsInteger, fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1);

      if not fMasterDataSet.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (π%s din %s)', [fMasterDataSet.FieldByName('CONTRACT_TYPE_TITLE').AsString, fMasterDataSet.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', fMasterDataSet.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
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

    frameMoneyCounter.OnTotalSumChanged := WhenBanknotesCounterSumaChanged;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    if not FReadOnly then
      fMasterDataSet.UpdateTransaction.Rollback;

    IBCQueryRechizite.Close;
    IBCQueryDocProps.Close;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmBankPDNSKDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').asInteger, False, 0, 'Selecteaza platitorul ' + dtDialogTitle.Title) then
    begin
      fMasterDataSet.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      OpenCT_Accounts;
      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, fMasterDataSet.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankPDNSKDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('DT').asInteger, False, 0, 'Selecteaza beneficiarul' + dtDialogTitle.Title) then
    begin
      fMasterDataSet.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankPDNSKDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmBankPDNSKDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmBankPDNSKDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_ÃÓÊÌÓ_‚˚ÒÚ‡‚ÎˇÚ_Ó·‡ÚÌÛ˛_‰‡ÚÛ);

     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_¡Œ_œƒÕ—» _œÓÍ‡Á˚‚‡Ú¸_ ÓÌÚ‡ÍÚ);
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

procedure TfrmBankPDNSKDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmBankPDNSKDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(fMasterDataSet.FieldByName('CT').AsInteger, fMasterDataSet.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (π%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    fMasterDataSet.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmBankPDNSKDlg.SumaChanged;
var
  S: string;
begin
  if fMasterDataSet.FieldByName('DOCTYPEID').asInteger = 119 { Ordine de plata bancare, Lei (6) } then
  begin
    S := Format('Plata conform contului/contractului nr. din  pentru echipament tehnic. Inclusiv TVA, %f lei', [fMasterDataSet.FieldByName('SUMA').asFloat / 6]);
    if not (IBCQueryDocProps.State in dsEditModes) then
      IBCQueryDocProps.Edit;
    IBCQueryDocProps.FieldByName('COMMENTS').AsString := S;
  end;
end;

procedure TfrmBankPDNSKDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;
  fMasterDataSet.Cancel;
  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.Rollback;
  IBCQueryDocProps.Close;
  IBCQueryRechizite.Close;
end;

procedure TfrmBankPDNSKDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryCurrency.FilterSQL := '';
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

procedure TfrmBankPDNSKDlg.SetDataDoc(const Value: TDateTime);
begin
    FDataDoc := Value;
end;

procedure TfrmBankPDNSKDlg.SetDocTypeID(const Value: Integer);
begin
    FDocTypeID := Value;
end;

procedure TfrmBankPDNSKDlg.SetIBAN(const Value: string);
begin
    FIBAN := Value;
end;

procedure TfrmBankPDNSKDlg.WhenBanknotesCounterSumaChanged(Sender: TObject);
begin
  fMasterDataSet.FieldByName('SUMA').AsFloat := frameMoneyCounter.TotalSum;
end;


end.


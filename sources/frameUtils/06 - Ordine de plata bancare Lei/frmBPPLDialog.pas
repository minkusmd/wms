unit frmBPPLDialog;

interface

uses
  Buttons, Classes, Controls, DB, DBAccess, DialogTitle, Dialogs, ExtCtrls, Forms, Graphics, IBC, MemDS, Messages,
  SWNBaseUnit, StdCtrls, SysUtils, Variants, Windows, cxButtonEdit, cxButtons, cxCalc, cxCalendar, cxCheckBox, cxClasses,
  cxContainer, cxControls, cxCustomData, cxDBData, cxDBEdit, cxDBExtLookupComboBox, cxDBLookupComboBox, cxDBLookupEdit,
  cxData, cxDataStorage, cxDropDownEdit, cxEdit, cxFilter, cxGraphics, cxGrid, cxGridCustomTableView, cxGridCustomView,
  cxGridDBTableView, cxGridTableView, cxLookAndFeelPainters, cxLookAndFeels, cxLookupEdit, cxMaskEdit, cxMemo,
  cxNavigator, cxStyles, cxTextEdit, dxDateRanges, dxScrollbarAnnotations,

  Vcl.DBCtrls,
  Vcl.Menus, dxUIAClasses, dxCoreGraphics;

type
  TfrmBPPLDlg = class(TSWNMasteredFormClass)
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
    cxLabel4: TLabel;
    ceRATE: TcxDBCalcEdit;
    cxLabel6: TLabel;
    lcbCT_CD: TcxDBLookupComboBox;
    ceSUMA: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    lcbDT_CD: TcxDBLookupComboBox;
    deDATA: TcxDBDateEdit;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    sbRateUsdFromDoc: TSpeedButton;
    cxDBCalcEdit1: TcxDBCalcEdit;
    lcbCURRENCY: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    cbFLG_ACNT: TcxDBCheckBox;
    cbTVA: TcxComboBox;
    cxButton1: TcxButton;
    Label2: TLabel;
    IBCDataSourceDocs: TIBCDataSource;
    Label1: TLabel;
    ceComision: TcxCalcEdit;
    beCT_NAME: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbRateUsdFromDocClick(Sender: TObject);
    procedure mmCOMMENTSEnter(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxButton1Click(Sender: TObject);
    procedure SWNCustomerComboBox1ButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure SWNCustomerComboBox1CloseUp(Sender: TObject);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fRealRateValue: Double;
    fLastCurrencyID: Integer;
    fCreateNewDocument: Boolean;
    FDataDoc: TDateTime;
    FDocTypeID: Integer;
    FIBAN: string;
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
    procedure ShowSelectedCustomUSDRateFromDocument;
    procedure ShowSelectContractDialog;
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
    procedure AddTVA;
    procedure SetDataDoc(const Value: TDateTime);
    procedure SetDocTypeID(const Value: Integer);
    procedure SetIBAN(const Value: string);
    procedure PopulateCustomersList;
  protected
    procedure GetDefaultCustomerContract;
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    procedure CreateComisionDocument(Suma: double);
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property DataDoc: TDateTime read FDataDoc write SetDataDoc;
    property DocTypeID: Integer read FDocTypeID write SetDocTypeID;
    property IBAN: string read FIBAN write SetIBAN;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  SWNDealsUnit,
  DataModuleAdditions, DataModuleDB, DateUtils, SWNConst, SWNCustomersTypesUnit, SWNDBErrors, SWNSecurity,
  SWNSecurityFlags, SWNTypes, SWNUtils, frmBPPLSelectCustomUSDRateDialog, frmCustomerContractsDialog, frmCustomersDlg,
  frmDocumentCommentsEditorDialog;

{$R *.dfm}
{ TfrmBankPDNSDlg }

procedure TfrmBPPLDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmBPPLDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmBPPLDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmBPPLDlg.CheckParams: Boolean;
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
//        if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
//            AddErrorToStr(ErrorStr, 'Cont de decontare a platitorului!');

    if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
      AddErrorToStr(ErrorStr, 'Suma!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Rata de schimb a documentului!');
//    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
//      AddErrorToStr(ErrorStr, 'Cursul documentului este subevaluat!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata de schimb a USD!');

  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

//function TfrmBPPLDlg.CheckParams: Boolean;
//var
//    ErrorStr: string;
//begin
//    Result := False;
//    ErrorStr := '';
//
//    with fMasterDataSet do
//    begin
//        if FieldByName('DATA').IsNull then
//            AddErrorToStr(ErrorStr, 'Data documentului!');
//
//        if FieldByName('SC2').IsNull then
//            AddErrorToStr(ErrorStr, 'Analitica documentului!');
//
//        if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
//            AddErrorToStr(ErrorStr, 'Organizatia!');
//        if FieldByName('DTSC').IsNull then
//            AddErrorToStr(ErrorStr, 'Analitica organizatiei!');
//
//        if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
//            AddErrorToStr(ErrorStr, 'Expeditor!');
//
//        if IBCQueryRechizite.FieldByName('DT_CD').IsNull or (IBCQueryRechizite.FieldByName('DT_CD').AsString = '') then
//            AddErrorToStr(ErrorStr, 'Contul curent al organizatiei!');
//        if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
//            AddErrorToStr(ErrorStr, 'Contul curent al expeditorului!');
//
//        if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
//            AddErrorToStr(ErrorStr, 'Suma!');
//        if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
//            AddErrorToStr(ErrorStr, 'Cursul documentului!')
//        else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
//            AddErrorToStr(ErrorStr, 'Cursul documentului este subevaluat!');
//
//        if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
//            AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
//    end;
//
//    if ErrorStr = '' then
//        Result := True
//    else
//        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
//end;

procedure TfrmBPPLDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmBPPLDlg.FormCreate(Sender: TObject);
begin
  fCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmBPPLDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
    fMasterDataSet.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;

//        CreateComisionDocument(ceComision.Value);
    fMasterDataSet.UpdateTransaction.Commit;
    fMasterDataSet.Refresh;

    CloseAdditionalDataSources;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmBPPLDlg.lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmBPPLDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  acnt: Boolean;
  currID: Integer;
  rate: Double;
  suma: Currency;
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

procedure TfrmBPPLDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmBPPLDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(fMasterDataSet.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
      FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//        fMasterDataSet.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
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

procedure TfrmBPPLDlg.mmCOMMENTSEnter(Sender: TObject);
begin
//    if fMasterDataSet.State in dsEditModes then
//        SumaChanged;
end;

procedure TfrmBPPLDlg.OpenCT_Accounts;
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
  if IBCQueryRechizite.State <> dsEdit then
    IBCQueryRechizite.Edit;
  if not IBCQueryCT_Accounts.Eof then
    IBCQueryRechizite.FieldByName('CT_CD').Value := IBCQueryCT_Accounts.FieldByName('ACCOUNTNUMBER').AsString
  else
    IBCQueryRechizite.FieldByName('CT_CD').Value := Null;
end;

procedure TfrmBPPLDlg.OpenDT_Accounts;
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
  if IBCQueryRechizite.State <> dsEdit then
    IBCQueryRechizite.Edit;
  if not IBCQueryDT_Accounts.Eof then
    IBCQueryRechizite.FieldByName('DT_CD').Value := IBCQueryDT_Accounts.FieldByName('ACCOUNTNUMBER').AsString
  else
    IBCQueryRechizite.FieldByName('DT_CD').Value := Null;
end;

procedure TfrmBPPLDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  IBCDataSourceDocs.DataSet := fMasterDataSet;
  beContract.Text := '';

  if not FReadOnly and not (fMasterDataSet.UpdateTransaction.Active) then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    // Currency adjust
    dmDB.IBCQueryCurrency.Active := False;
    dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID=498';
    dmDB.IBCQueryCurrency.Active := True;

    IBCQueryRechizite.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    IBCQueryDocProps.UpdateTransaction := fMasterDataSet.UpdateTransaction;

    IBCQueryRechizite.Active := True;
    IBCQueryDocProps.Active := True;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;

    if fCreateNewDocument then
    begin
      // Append
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := fDocTypeID;

      // system defaults
      if not dmDB.LoadDocumentDefaults(fDocTypeID, dmDB.CurrentFirma, fMasterDataSet as TIBCQuery,
        DocumentAdditionalFlags) then
      begin
        fMasterDataSet.FieldByName('SC2').AsInteger := -1;
        fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        // fMasterDataSet.FieldByName('DTSC').AsInteger:=-1;
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      fMasterDataSet.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, fMasterDataSet.FieldByName
        ('FLG_ACNT').AsInteger = 1);

      // local defaults
      // Currency adjust
      fLastCurrencyID := 498;

      fMasterDataSet.FieldByName('CURRENCYID').AsInteger := fLastCurrencyID;

      fMasterDataSet.FieldByName('DATA').AsDateTime := FDataDoc;
      fMasterDataSet.FieldByName('FLG_SEND').AsInteger := 0;
      fMasterDataSet.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('DT').Value);

      OpenDT_Accounts;
      OpenCT_Accounts;
      if IBAN <> 'Toate conturile' then
      begin
        IBCQueryRechizite.Edit;
        IBCQueryRechizite.FieldByName('DT_CD').AsString := IBAN;
      end;
      fMasterDataSet.FieldByName('DATA').AsDateTime := DataDoc;
    end
    else
    begin
    // Edit
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
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
        fMasterDataSet.Edit;
      end;

      fLastCurrencyID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;
      beDT_NAME.Text := fMasterDataSet.FieldByName('DT_NAME').AsString;

      beCT_NAME.Tag := fMasterDataSet.FieldByName('CT').AsInteger;
      beCT_NAME.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;


      fRealRateValue := dmDB.GetCurrencyExchangeValue(fMasterDataSet.FieldByName('CURRENCYID').AsInteger,
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger = 1);

      if not fMasterDataSet.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (№%s din %s)', [fMasterDataSet.FieldByName('CONTRACT_TYPE_TITLE').AsString,
          fMasterDataSet.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', fMasterDataSet.FieldByName
          ('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
        end;
      end;
    end;

    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource(fDocTypeID);

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

  AttachDealToDialog(Self, fMasterDataSet);
end;

procedure TfrmBPPLDlg.sbRateUsdFromDocClick(Sender: TObject);
begin
  ShowSelectedCustomUSDRateFromDocument;
end;

procedure TfrmBPPLDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
  ok: Boolean;
begin
  dialog := TfrmCustomersDlg.Create(Self);

  try
    if ((beCT_NAME.Text <> '') and (beCT_NAME.Tag < 1)) then
      ok := dialog.SelectCustomerBySearch(beCT_NAME.Text, 'Selecteaza platitorul')
    else
    ok := dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').AsInteger, False, 0, 'Selecteaza platitorul');

    if ok then

        // dialog.CustomFilter:=[cfFirms];
//        if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').AsInteger, False, 0, 'Selecteaza beneficiarul pentru "' +
//            dtDialogTitle.Title + '"') then
    begin
      fMasterDataSet.FieldByName('CT').AsInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      beCT_NAME.Tag:= dialog.CustomerID;

      OpenCT_Accounts;

      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, fMasterDataSet.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBPPLDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('DT').AsInteger, False, 0,
      'Selecteaza pltitorul pentru "' + dtDialogTitle.Title + '"') then
    begin
      fMasterDataSet.FieldByName('DT').AsInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBPPLDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmBPPLDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmBPPLDlg.SetupSecurityItems;
begin
     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_БО_БППЛ_Показывать_Контракт);
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

procedure TfrmBPPLDlg.AddTVA;
var
  S: string;
  suma: Double;
  sumaTVA: Double;
  tvaprocent: Integer;
begin
  suma := fMasterDataSet.FieldByName('SUMA').AsFloat;
  tvaprocent := StrToIntDef(cbTVA.Text, 20);
  sumaTVA := suma - (suma / (1 + (tvaprocent / 100)));
  S := Format('Inclusiv TVA %spr. - %2.2f %s', [cbTVA.Text, sumaTVA, fMasterDataSet.FieldByName('currency_name').AsString]);
  if IBCQueryDocProps.FieldByName('COMMENTS').AsString = '' then
    IBCQueryDocProps.FieldByName('COMMENTS').AsString := S
  else
    IBCQueryDocProps.FieldByName('COMMENTS').AsString := IBCQueryDocProps.FieldByName('COMMENTS').AsString +
      ''#13''#10'' + S;
end;

procedure TfrmBPPLDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(fMasterDataSet.FieldByName('CT').AsInteger, fMasterDataSet.FieldByName
    ('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
      FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
        //evidenta aiuera, valuta USD dar totul prin transfer
//        fMasterDataSet.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmBPPLDlg.ShowSelectedCustomUSDRateFromDocument;
var
  dialog: TfrmBPPLSelectCustomUSDRateDlg;
begin
  dialog := TfrmBPPLSelectCustomUSDRateDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      fMasterDataSet.FieldByName('RATEUSD').AsFloat := dialog.CustomUSDRate;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBPPLDlg.SumaChanged;
var
  k: Integer;
  S: string;
begin
  if ShowAskDialog('Destinatia platii', 'Modifica destinatia platii?') = mrYes then
  begin
//    fMasterDataSet.FieldByName('VAT').AsFloat := fMasterDataSet.FieldByName('SUMA').AsFloat / 6;
    S := Format('Plata conform contului/contractului nr.  din  pentru echipament tehnic. Inclusiv TVA, %f lei',
      [fMasterDataSet.FieldByName('SUMA').AsFloat / 6]);

  end
  else
  begin
    S := IBCQueryDocProps.FieldByName('COMMENTS').AsString;
    k := Pos('Inclusiv TVA', S);
    if k > 0 then
    begin
      S := Copy(S, 0, k - 1);
    end;
    S := S + Format(' Inclusiv TVA, %f lei', [fMasterDataSet.FieldByName('SUMA').AsFloat / 6]);
  end;
  if not (IBCQueryDocProps.State in dsEditModes) then
    IBCQueryDocProps.Edit;

  IBCQueryDocProps.FieldByName('COMMENTS').AsString := S;
end;

procedure TfrmBPPLDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;
  fMasterDataSet.Cancel;
  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.Rollback;
  CloseAdditionalDataSources;
end;

procedure TfrmBPPLDlg.CloseAdditionalDataSources;
begin
  // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryCurrency.FilterSQL := '';
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

procedure TfrmBPPLDlg.CreateComisionDocument(Suma: double);
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.Transaction := fMasterDataSet.UpdateTransaction;
    Query.SQL.Text := 'execute procedure sp_create_comision_doc(:parentdocid, :suma)';
    Query.ParamByName('parentdocid').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
    Query.ParamByName('SUMA').AsFloat := Suma;
    Query.Execute;
  finally
    Query.Free;
  end;
end;

procedure TfrmBPPLDlg.PopulateCustomersList;
begin
end;

procedure TfrmBPPLDlg.cxButton1Click(Sender: TObject);
begin
  AddTVA;
end;

procedure TfrmBPPLDlg.GetDefaultCustomerContract;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  Query.SQL.Text := 'select * from get_default_contract(:customerid)';
  Query.ParamByName('CUSTOMERID').AsInteger := beCT_NAME.Tag;
  Query.Open;

end;

procedure TfrmBPPLDlg.SetDataDoc(const Value: TDateTime);
begin
  FDataDoc := Value;
end;

procedure TfrmBPPLDlg.SetDocTypeID(const Value: Integer);
begin
  FDocTypeID := Value;
end;

procedure TfrmBPPLDlg.SetIBAN(const Value: string);
begin
  FIBAN := Value;
end;

procedure TfrmBPPLDlg.SWNCustomerComboBox1ButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
//  if (AButtonIndex = 1) then
//  begin
//    fMasterDataSet.FieldByName('CT').AsInteger := ExpencesID;
//    TSWNCustomerComboBox(Sender).CustomerID := ExpencesID;
//    TSWNCustomerComboBox(Sender).CustomerName := 'CHELTUIELI ALTE';
//
//    OpenCT_Accounts;
////    if fSECURITY_ALLOW_CONTRACT then
////      LoadDefaultContract(ExpencesID, fMasterDataSet.FieldByName('DATA').AsDateTime);
////    contractInfo := LoadCustomerDefaultContractInfo(ExpencesID, deDATA.EditingValue);
////    fMasterDataSet.FieldByName('CONTRACTID').Value := Null;
//    beContract.Text := '';
//    beContract.Tag := -1;
//  end;
//
//  if (AButtonIndex = 2) then
//  begin
//    SelectCT;
//
//    contractInfo := LoadCustomerDefaultContractInfo(beCT_NAME.Tag, deDATA.EditingValue);
//    if Assigned(contractInfo) then
//    begin
//      beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
//        FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
//      fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//      if contractInfo.FLG_ACNT then
//      begin
//        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
//      end;
//      lbContractInfo.Visible := True;
//      contractInfo.Free;
//    end
//  end;
end;

procedure TfrmBPPLDlg.SWNCustomerComboBox1CloseUp(Sender: TObject);
var
  contractinfo: TCustomerDefultContractInfo;
begin
  fMasterDataSet.FieldByName('CT_NAME').AsString := beCT_NAME.Text;
  fMasterDataSet.FieldByName('CT').AsInteger := beCT_NAME.Tag;

  OpenCT_Accounts;

  // load default Contract properties
  contractinfo := LoadCustomerDefaultContractInfo(MasterDataSet.fieldbyname('dt').Asinteger, beCT_NAME.Tag, deDATA.EditingValue);
  if Assigned(contractinfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractinfo.ContractTypeTitle, contractinfo.Code,
      FormatDateTime('dd MMMM yyyy', contractinfo.SignDate)]);
    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractinfo.ContractID;
    if contractinfo.FLG_ACNT then
    begin
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
    end;
    lbContractInfo.Visible := True;

    contractinfo.Free;
  end
  else
  begin
    fMasterDataSet.FieldByName('CONTRACTID').Value := Null;
    beContract.Text := '';
    beContract.Tag := -1;
  end;

end;

end.


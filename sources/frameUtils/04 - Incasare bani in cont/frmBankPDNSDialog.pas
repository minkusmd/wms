unit frmBankPDNSDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  ExtCtrls, cxGraphics, DB, DBAccess, IBC, MemDS, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  StdCtrls, cxButtonEdit, cxLookAndFeels, cxLookAndFeelPainters, DialogTitle,
  dxBarBuiltInMenu, cxPC, dxBar, cxClasses, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridCustomView, cxGrid, cxCheckBox, dxUIAClasses, dxCoreGraphics;

type
  TfrmBankPDNSDlg = class(TSWNMasteredFormClass)
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
    IBCDataSourceDocs: TIBCDataSource;
    dtDialogTitle: TDialogTitle;
    cxPageControl1: TcxPageControl;
    tsDocuments: TcxTabSheet;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    cxLabel6: TLabel;
    cxLabel8: TLabel;
    Label1: TLabel;
    lbContractTitle: TLabel;
    lbContractInfo: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbCT_CD: TcxDBLookupComboBox;
    ceSUMA: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    lcbDT_CD: TcxDBLookupComboBox;
    deDATA: TcxDBDateEdit;
    beDT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    tsDistribution: TcxTabSheet;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbImport: TdxBarButton;
    IBCTrLocal: TIBCTransaction;
    IBCDataSourceDistributieRamburs: TIBCDataSource;
    IBCQueryDistributieRamburs: TIBCQuery;
    cxGridRamburs: TcxGrid;
    cxGridRambursDBTableView: TcxGridDBTableView;
    cxGridRambursDBTableViewCUSTOMERID: TcxGridDBColumn;
    cxGridRambursDBTableViewCUSTOMER_NAME: TcxGridDBColumn;
    cxGridRambursDBTableViewAWB: TcxGridDBColumn;
    cxGridRambursDBTableViewRAMBURS: TcxGridDBColumn;
    cxGridRambursDBTableViewPRET_LIVRARE: TcxGridDBColumn;
    cxGridRambursDBTableViewCOMISION: TcxGridDBColumn;
    cxGridRambursDBTableViewCONTRACTID: TcxGridDBColumn;
    cxGridRambursLevel1: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    IBCQueryDistributieDocs: TIBCQuery;
    IBCDataSourceDistributieDocs: TIBCDataSource;
    ckbFLG_ACNT: TcxDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure ceSUMAPropertiesEditValueChanged(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure SWNCustomerComboBox1ButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure SWNCustomerComboBox1CloseUp(Sender: TObject);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxGridRambursDBTableViewKeyDown(Sender: TObject; var Key: Word;
        Shift: TShiftState);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fRealRateValue: double;
    fLastCurrencyID: integer;
    fCreateNewDocument: Boolean;
    FDateDoc: TDateTime;
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
    procedure SetDateDoc(const Value: TDateTime);
    procedure SetDocTypeID(const Value: Integer);
    procedure SetIBAN(const Value: string);
    procedure ShowEditorDlg(AIsNewRecord: Boolean);
  protected  { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
    procedure BindingDataSource; override;
    procedure ClearContract;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property DateDoc: TDateTime read FDateDoc write SetDateDoc;
    property DocTypeID: Integer read FDocTypeID write SetDocTypeID;
    property IBAN: string read FIBAN write SetIBAN;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  SWNDealsUnit,
  DateUtils, DataModuleDB, SWNUtils, SWNConst, SWNTypes, frmCustomersDlg,
  SWNSecurityFlags, SWNSecurity, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, SWNDBErrors,
  frmCustomerContractsDialog, Vcl.Clipbrd, frmDistributieRambursEditorDialog;

{$R *.dfm}

{ TfrmBankPDNSDlg }

procedure TfrmBankPDNSDlg.bbDeleteClick(Sender: TObject);
begin
    if (MessageDlg('Stergeti inregistrarea', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
        IBCQueryDistributieRamburs.Delete;
end;

procedure TfrmBankPDNSDlg.bbEditClick(Sender: TObject);
begin
  ShowEditorDlg(False);
end;

procedure TfrmBankPDNSDlg.bbImportClick(Sender: TObject);
var
    AWB: string;
    I: Integer;
    q: TIBCQuery;
    slist: TStringList;
    clipboard_array: TArray<string>;
    PretLivrare: string;
    SumaRamburs: string;
begin
    slist := TStringlist.Create;

    q := TIBCQuery.Create(self);
    q.SQL.Text := 'SELECT DOCID, CUSTOMERID, CUSTOMER_NAME FROM GET_AWB_FULLINFO(:AWB)';
    q.Prepare;
    slist.Text := Clipboard.AsText;

    try
    for I := 0 to slist.count-1 do
    begin
        clipboard_array := slist[i].Split([#9]);
        awb := clipboard_array[0];
        PretLivrare := clipboard_array[1];
        SumaRamburs := clipboard_array[2];

        q.CLose;
        q.ParamByName('awb').AsString := AWB;
        q.Open;

        IBCQueryDistributieRamburs.Append;
        IBCQueryDistributieRamburs.FieldByName('CUSTOMERID').AsInteger := q.FieldByName('CUSTOMERID').AsInteger;
        IBCQueryDistributieRamburs.FieldByName('PRET_LIVRARE').Asstring := PretLivrare;
        IBCQueryDistributieRamburs.FieldByName('RAMBURS').Asstring := SumaRamburs;
        IBCQueryDistributieRamburs.FieldByName('AWB').Asstring := AWB;
        IBCQueryDistributieRamburs.FieldByName('COMISION').AsFloat := 0;
        IBCQueryDistributieRamburs.FieldByName('CONTRACTID').AsFloat := -1;

        LoadDefaultContract(q.FieldByName('CUSTOMERID').AsInteger, dmdb.ibcquerydocs.FieldByName('DATA').AsDateTime);
        IBCQueryDistributieRamburs.Post;
    end
    finally
        q.Free;
        slist.Free;
    end;
end;

procedure TfrmBankPDNSDlg.bbNewClick(Sender: TObject);
begin
  ShowEditorDlg(True);
end;

procedure TfrmBankPDNSDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0:   ShowSelectContractDialog;
    1:  ClearContract;
  end;

end;

procedure TfrmBankPDNSDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmBankPDNSDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmBankPDNSDlg.ceSUMAPropertiesEditValueChanged(Sender: TObject);
begin
//  SumaChanged;
end;

function TfrmBankPDNSDlg.CheckParams: Boolean;
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
      AddErrorToStr(ErrorStr, 'Cont de decontare a organizatiei!');
//    if IBCQueryRechizite.FieldByName('CT_CD').IsNull or (IBCQueryRechizite.FieldByName('CT_CD').AsString = '') then
//      AddErrorToStr(ErrorStr, 'Cont de decontare a platitorului!');

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

procedure TfrmBankPDNSDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmBankPDNSDlg.FormCreate(Sender: TObject);
begin
  fCreateNewDocument := False;
  FReadOnly := false;
end;

procedure TfrmBankPDNSDlg.BindingDataSource;
begin
//  IBCDataSourceDocs := fMasterDataSource;
  ibcDataSourceDocs.DataSet := fMasterDataSet;
  ckbFLG_ACNT.Databinding.DataSource := MasterDataSource;
end;

procedure TfrmBankPDNSDlg.ClearContract;
begin
  MasterDataSet.FieldByName('ContractID').AsInteger := -1;
  beContract.Text := '';
end;

function TfrmBankPDNSDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if (not FReadOnly) and CheckParams then
  try
    if fMasterDataSet.State in dsEditModes then
    fMasterDataSet.Post;

    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;

    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;

    if fMasterDataSet.UpdateTransaction.Active then
      fMasterDataSet.UpdateTransaction.Commit;

    fMasterDataSet.Refresh;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmBankPDNSDlg.lcbCT_AccountsPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmBankPDNSDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmBankPDNSDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmBankPDNSDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := frmCustomerContractsDialog.LoadCustomerDefaultContractInfo(
                                    MasterDataSet.FieldByName('DT').AsInteger,
                                    CustomerID,
                                    DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
      FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
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

procedure TfrmBankPDNSDlg.OpenCT_Accounts;
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

procedure TfrmBankPDNSDlg.OpenDT_Accounts;
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

procedure TfrmBankPDNSDlg.Prepare;
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
    IBCQueryRechizite.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    IBCQueryDocProps.UpdateTransaction := fMasterDataSet.UpdateTransaction;
    dmDB.IBCQueryCurrency.UpdateTransaction := fMasterDataSet.UpdateTransaction;


    if fDocTypeID = cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_БППЛ then
      dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID = 498'
    else if fDocTypeID = cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_БППВ then
      dmDB.IBCQueryCurrency.FilterSQL := 'CurrencyID <> 498';

    dmDB.IBCQueryCurrency.Active := True;

    IBCQueryRechizite.Active := True;
    IBCQueryDocProps.Active := True;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;

    if fCreateNewDocument then
    begin
//      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      fMasterDataSet.Append;
      if fDateDoc < StrToDate('01.01.2020') then
        fDateDoc := Now;

      if fIBAN <> 'Toate conturile' then
      begin
        if FIBAN <> '' then
        begin
          IBCQueryRechizite.Edit;
          IBCQueryRechizite.FieldByName('DT_CD').AsString := fIBAN;
        end;
      end;

      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := fDocTypeID;
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
             // system defaults
      if not dmDB.LoadDocumentDefaults(fDocTypeID, dmDB.CurrentFirma, TIBCQuery(fMasterDataSet),
        DocumentAdditionalFlags) then
      begin
        fMasterDataSet.FieldByName('SC2').AsInteger := -1;
        fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //fMasterDataSet.FieldByName('DTSC').AsInteger:=-1;
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      fMasterDataSet.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, fMasterDataSet.FieldByName
        ('FLG_ACNT').AsInteger = 1);

             // local defaults
             // Currency adjust
      fLastCurrencyID := 498;
             // Ordine de plata bancare, Valuta
      if fDocTypeID = cDBID_DocType_БАНКОВСКИЕ_ОПЕРАЦИИ_БППВ then
        fLastCurrencyID := 840;

      fMasterDataSet.FieldByName('CURRENCYID').AsInteger := fLastCurrencyID;

      fMasterDataSet.FieldByName('DATA').AsDateTime := DateDoc;
      fMasterDataSet.FieldByName('FLG_SEND').AsInteger := 0;
      fMasterDataSet.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CT').Value);
      beCT_NAME.Tag := fMasterDataSet.FieldByName('CT').AsInteger;

      OpenDT_Accounts;
      OpenCT_Accounts;
    end
    else
    begin
      if FReadOnly then
      begin
        // View Only
//        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
//        dtDialogTitle.Color := cCOLOR_DocReadOnly;
//        pnClient.Enabled := False;

        btnOk.Visible := False;
        btnCancel.Default := True;
        btnCancel.Caption := 'Inchide';
      end
      else
      begin
                  // Edit
//        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
        fMasterDataSet.Edit;
      end;

      fLastCurrencyID := fMasterDataSet.FieldByName('CURRENCYID').AsInteger;
      beDT_NAME.Text := fMasterDataSet.FieldByName('DT_NAME').AsString;

      beCT_NAME.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;
      beCT_NAME.Tag := fMasterDataSet.FieldByName('CT').AsInteger;

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

    dmDB.OpenAnalyticsDataSource(DocTypeID);

    // distribuire plati
    IBCQueryDistributieDocs.ParamByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').Asinteger;
    IBCQueryDistributieDocs.Open;

    IBCTrLocal.DefaultConnection := fMasterDataSet.Transaction.DefaultConnection;
    IBCQueryDistributieRamburs.Transaction := fMasterDataSet.Transaction;
    IBCQueryDistributieRamburs.MasterSource := IBCDataSourceDistributieDocs;
    IBCQueryDistributieRamburs.MasterFields := 'DOCID';
    IBCQueryDistributieRamburs.DetailFields := 'DOCID';
    IBCQueryDistributieRamburs.Open;


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

procedure TfrmBankPDNSDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
  ok: Boolean;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms];
    if ((beCT_NAME.Text <> '')) then
      ok := dialog.SelectCustomerBySearch(beCT_NAME.Text, 'Selecteaza platitorul')
    else
      ok := dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').AsInteger, False, 0, 'Selecteaza platitorul');

    if ok then
    begin
      fMasterDataSet.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      beCT_NAME.Tag := dialog.CustomerID;
      OpenCT_Accounts;
      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, fMasterDataSet.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankPDNSDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('DT').asInteger, False, 0, 'Selecteaza beneficiarul' +
      dtDialogTitle.Title) then
    begin
      fMasterDataSet.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmBankPDNSDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmBankPDNSDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmBankPDNSDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_БО_ПДНС_Показывать_Контракт);
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

procedure TfrmBankPDNSDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmBankPDNSDlg.ShowSelectContractDialog;
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
//    fMasterDataSet.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmBankPDNSDlg.SumaChanged;
var
  S: string;
begin
  if fMasterDataSet.FieldByName('DOCTYPEID').asInteger = 119 { Ordine de plata bancare, Lei (6) } then
  begin
    S := Format('Plata conform contului/contractului nr.  din  pentru echipament tehnic. Inclusiv TVA, %f lei',
      [fMasterDataSet.FieldByName('SUMA').asFloat / 6]);
    if not (IBCQueryDocProps.State in dsEditModes) then
      IBCQueryDocProps.Edit;
    IBCQueryDocProps.FieldByName('COMMENTS').AsString := S;
  end;
end;

procedure TfrmBankPDNSDlg.WhenCancelForm;
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

procedure TfrmBankPDNSDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryCurrency.FilterSQL := '';
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

procedure TfrmBankPDNSDlg.cxGridRambursDBTableViewKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(Self, cxGridRambursDBTableView, key, Shift);
end;

procedure TfrmBankPDNSDlg.FormShow(Sender: TObject);
begin
  cxPageControl1.ActivePageIndex := 0;
end;

procedure TfrmBankPDNSDlg.SetDateDoc(const Value: TDateTime);
begin
  FDateDoc := Value;
end;

procedure TfrmBankPDNSDlg.SetDocTypeID(const Value: Integer);
begin
  FDocTypeID := Value;
end;

procedure TfrmBankPDNSDlg.SetIBAN(const Value: string);
begin
  FIBAN := Value;
end;

procedure TfrmBankPDNSDlg.SWNCustomerComboBox1ButtonClick(Sender: TObject; AButtonIndex: Integer);
begin

  if AButtonIndex = 2 then
    SelectCT;
end;

procedure TfrmBankPDNSDlg.SWNCustomerComboBox1CloseUp(Sender: TObject);
//var
//  contractinfo: TCustomerDefultContractInfo;
begin
//  fMasterDataSet.FieldByName('CT_NAME').AsString := SWNCustomerComboBox1.CustomerName;
//  fMasterDataSet.FieldByName('CT').AsInteger := SWNCustomerComboBox1.CustomerID;
//
//  OpenCT_Accounts;
//
//  // load default Contract properties
//  contractinfo := LoadCustomerDefaultContractInfo(SWNCustomerComboBox1.CustomerID, deDATA.EditingValue);
//  if Assigned(contractinfo) then
//  begin
//    beContract.Text := Format('%s (№%s din %s)', [contractinfo.ContractTypeTitle, contractinfo.Code,
//      FormatDateTime('dd MMMM yyyy', contractinfo.SignDate)]);
//    fMasterDataSet.FieldByName('CONTRACTID').AsInteger := contractinfo.ContractID;
//    if contractinfo.FLG_ACNT then
//    begin
//      fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 1;
//    end;
//    lbContractInfo.Visible := True;
//
//    contractinfo.Free;
//  end
//  else
//  begin
//    fMasterDataSet.FieldByName('CONTRACTID').Value := Null;
//    beContract.Text := '';
//    beContract.Tag := -1;
//  end;

end;

procedure TfrmBankPDNSDlg.ShowEditorDlg(AIsNewRecord: Boolean);
var
    dialog: TfrmDistributieRambursEditorDlg;
begin
    dialog := TfrmDistributieRambursEditorDlg.Create(Self, IBCQueryDistributieRamburs, IBCDataSourceDistributieRamburs);
    try
        dialog.DocumentDate := dmdb.IBCQueryDocs.FieldByName('DATA').AsDateTime;
        dialog.IsNewRecord := AIsNewRecord;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;


end.


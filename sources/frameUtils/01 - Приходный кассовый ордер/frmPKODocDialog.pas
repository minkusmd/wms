unit frmPKODocDialog;

// Приходный кассовый ордер
// Dispozitie de incasare

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, DB,
  DBAccess, IBC, MemDS, cxCalendar, cxDBEdit, cxMemo, cxCheckBox, cxDropDownEdit, cxCalc, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ExtCtrls, StdCtrls, cxButtonEdit, Buttons,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxCoreGraphics, dxUIAClasses;

type
  TfrmPKODocDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    pnClient: TPanel;
    lbFirma: TLabel;
    lbClient: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbDocComments2: TLabel;
    edSuma: TcxDBCalcEdit;
    edRate: TcxDBCalcEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    mmDocCOMMENTS: TcxDBMemo;
    deDATA: TcxDBDateEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    sbShowCurrencyCalc: TSpeedButton;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    cmbCurrency: TcxDBLookupComboBox;
    lcbDT_CD: TcxDBLookupComboBox;
    lcbCT_CD: TcxDBLookupComboBox;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceRechizite: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    lcbDocumentState: TcxDBLookupComboBox;
    IBCQueryStates: TIBCQuery;
    IBCDataSourceStates: TIBCDataSource;
    Label2: TLabel;
    beCT_NAME: TcxButtonEdit;
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbShowCurrencyCalcClick(Sender: TObject);
    procedure mmDocCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure lcbDT_CDPropertiesInitPopup(Sender: TObject);
    procedure lcbCT_CDPropertiesInitPopup(Sender: TObject);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate, fSECURITY_ALLOW_CONTRACT: Boolean;
    FReadOnly: Boolean;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowCurrencyCalc;
    procedure SetReadOnly(const Value: Boolean);
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
    property CreateNewDocument: Boolean read FCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, SWNUtils, SWNTypes, SWNConst, DataModuleDB, DataModuleAdditions, frmCustomersDlg, frmBanknoteCounterDialog,
  SWNSecurityFlags, SWNSecurity, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, SWNDBErrors, frmCustomerContractsDialog,
  frmCustomerAccountsDlg;

{$R *.dfm}

procedure TfrmPKODocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if AButtonIndex = 0 then
    ShowSelectContractDialog;
  if AButtonIndex = 1 then
  begin
    dmDB.IBCQueryDocs.FieldByName('ContractID').AsInteger := -1;
    beContract.Text := '';
    beContract.Tag := -1;
  end;
end;

procedure TfrmPKODocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmPKODocDlg.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
var
  flg: Boolean;
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    flg := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
    if flg then
    begin
      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
      cmbCurrency.Enabled := False;
    end
    else
    begin
      cmbCurrency.Enabled := True;
      if not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
      begin
        dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, flg);
      end;
    end;
  end;
end;

function TfrmPKODocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
  S_DT, S_DTSC: string;
  S_CT: string;
begin
  Result := False;

     // specific fields
  case dmDB.CurrentDocTypeID of
    cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО: // Приходный кассовый ордер
      begin
        S_DT := 'Beneficiar!';
        S_DTSC := 'Analitica beneficiar!';
        S_CT := 'Platitor!';
        S_DTSC := 'Analitica platitor!';
      end;
    cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО,  // Расходный кассовый ордер
    cDBID_DocType_ЗАРПЛАТА_ВЗ:    // Зарплата
      begin
        S_DT := 'Platitor!';
        S_DTSC := 'Analitica platitor!';
        S_CT := 'Beneficiar!';
        S_DTSC := 'Analitica beneficiar!';
      end;
  end;

  if dmDB.IBCQueryDocs.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Data documentului!');

  if dmDB.IBCQueryDocs.FieldByName('SC2').IsNull then
    AddErrorToStr(ErrorStr, 'Analitica documentului!');

  if dmDB.IBCQueryDocs.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, S_DT);
  if dmDB.IBCQueryDocs.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, S_DTSC);

  if dmDB.IBCQueryDocs.FieldByName('CT').IsNull then
    AddErrorToStr(ErrorStr, S_CT);

     // common fields
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Valuta!');
  if dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat < 1 then
    AddErrorToStr(ErrorStr, 'Rata >= 1');

  if dmDB.IBCQueryDocs.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Rata!');

  if dmDB.IBCQueryDocs.FieldByName('SUMA').IsNull {or (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency<=0)} then
    AddErrorToStr(ErrorStr, 'Suma!');

  if dmDB.IBCQueryDocs.FieldByName('RATEUSD').IsNull or (dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat < 1) then
    AddErrorToStr(ErrorStr, 'Rata USD >= 1');

  if dmdb.ibcquerydocs.FieldByName('STATEID').IsNull then
    begin
      AddErrorToStr(ErrorStr, 'Statutul incasarii!');
    end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPKODocDlg.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger,
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
  end;
end;

procedure TfrmPKODocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if beCT_NAME.EditingText = '' then
    begin
      if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, false, 0, 'Selecteaza platitorul!') then
      begin
        dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
        beCT_NAME.Text := dialog.CustomerTitle;
        beCT_NAME.Tag := dialog.CustomerID;
        if fSECURITY_ALLOW_CONTRACT then
          LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
      end;
    end
    else
    if dialog.SelectCustomerBySearch(beCT_NAME.EditingText, 'Selecteaza platitorul!') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
      beCT_NAME.Tag := dialog.CustomerID;
      if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPKODocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Selecteaza beneficiarul') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Tag := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPKODocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmPKODocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmPKODocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

     // Контракт
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_КО_ПКО_Показывать_Контракт);
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

procedure TfrmPKODocDlg.ShowCurrencyCalc;
var
  dialog: TfrmBanknoteCounterDlg;
begin
  dialog := TfrmBanknoteCounterDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := dialog.TotalSum;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPKODocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmPKODocDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy',
      contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmPKODocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmPKODocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmPKODocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmPKODocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
  dtDialogTitle.FontTitle.Size := 10;
  dtDialogTitle.FontText.Size := 9;
  dtDialogTitle.ImageList.Height := 64;
end;

function TfrmPKODocDlg.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
begin
  if dmDB.IBCQueryCurrency.Active and dmDB.IBCQueryCurrency.Locate('CURRENCYID', CurrencyID, []) then
  begin
    if ThroughAccount then
      Result := dmDB.IBCQueryCurrency.FieldByName('TRANSFER_RATE').AsFloat
    else
      Result := dmDB.IBCQueryCurrency.FieldByName('EXCHANGE_RATE').AsFloat;
  end
  else
    Result := -1;
end;

function TfrmPKODocDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
    dmDB.IBCQueryDocs.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmPKODocDlg.lcbCT_CDPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmPKODocDlg.lcbDT_CDPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmPKODocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(dmdb.ibcquerydocs.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy',
      contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
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

procedure TfrmPKODocDlg.mmDocCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmPKODocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;
  beContract.Text := '';

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // open data
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;
    dmDB.OpenAnalyticsDataSource;
    IBCQueryDT_Accounts.Open;
    IBCQueryDT_Accounts.Open;
    IBCQueryRechizite.Open;
    IBCQueryStates.ParamByName('DOCTYPEID').AsInteger := dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger;
    IBCQueryStates.Open;
    IBCQueryDocProps.Active := True;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Append;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local default
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsInteger := 1;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
      beCT_NAME.Tag := dmDB.IBCQueryDocs.FieldByName('CT').AsInteger;

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
      if SWNSecurityManager.IsPartialAccessMode then
        cbFLG_ACNT.Visible := false;
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
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;

                  // Daca este prin contabilitatea, atunci numai MDL
        if dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1 then
        begin
          cmbCurrency.Enabled := False;
          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        end;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (№%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName
          ('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
        end;
      end;
    end;

        // updated: 22.02.2011 + 01.02.2012
    cbFLG_ACNT.Enabled := (dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger = dmDB.CurrentUserID) or SWNSecurityManager.UserHasSecurityFlag
      (cSecurityFlag_КО_ПКО_Изменить_Через_бухгалтерию);

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;

end;

procedure TfrmPKODocDlg.sbShowCurrencyCalcClick(Sender: TObject);
begin
  ShowCurrencyCalc;
end;

procedure TfrmPKODocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  SelectCT;
  contractInfo := LoadCustomerDefaultContractInfo(MasterDataSet.fieldbyname('dt').Asinteger, beCT_NAME.Tag, deDATA.EditingValue);
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
    beContract.Text := '';
    beContract.Tag := -1;
    lbContractInfo.Visible := False;
  end;
end;

end.


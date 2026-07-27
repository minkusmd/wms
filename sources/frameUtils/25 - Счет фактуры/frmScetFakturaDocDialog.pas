unit frmScetFakturaDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, DB, IBC, StdCtrls, cxButtonEdit,
  cxDBEdit,

  cxDBLookupComboBox, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess,
  MemDS, cxCalc, cxDropDownEdit, cxCalendar, cxMemo, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, dxUIAClasses,
  dxCoreGraphics;

type
  TfrmScetFakturaDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cxLabel6: TLabel;
    cxLabel11: TLabel;
    lcbDT_Account: TcxDBLookupComboBox;
    cxLabel10: TLabel;
    lcbCT_Account: TcxDBLookupComboBox;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    ceRATE: TcxDBCalcEdit;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    lbContractTitle: TLabel;
    lbContractInfo: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCT_AccountPropertiesInitPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fRealRateValue: double;
    FCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    FReadOnly: Boolean;
    fSECURITY_ALLOW_CONTRACT: Boolean;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSouces;
    procedure SelectDT;
    procedure SelectCT;
    procedure OpenDT_Accounts;
    procedure OpenCT_Accounts;
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
  DateUtils, DataModuleDB, SWNUtils, SWNConst,
  frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmScetFakturaDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  ShowSelectContractDialog;
end;

procedure TfrmScetFakturaDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmScetFakturaDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmScetFakturaDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Дата документа!');
//          else
//          begin
//               if (DateOf(FieldByName('DATA').AsDateTime)<DateOf(NOW)) and (Not fSECURITY_CanSetupPastDate) then AddErrorToStr(ErrorStr,'Дата документа слишком стара!');
//          end;
    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика документа!');

    if dmDb.IBCQueryDocs.FieldByName('DT').IsNull then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if dmDb.IBCQueryDocs.FieldByName('CT').IsNull then
      AddErrorToStr(ErrorStr, 'Получатель!');

    if IBCQueryRechizite.FieldByName('DT_CD').IsNull then
      AddErrorToStr(ErrorStr, 'Реквизиты организации!');
          //if IBCQueryRechizite.FieldByName('CT_CD').IsNull then AddErrorToStr(ErrorStr,'Реквизиты получателя!');
    if dmDb.IBCQueryDocs.FieldByName('DTDEP').IsNull then
      AddErrorToStr(ErrorStr, 'Склад!');

    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Курс документа!')
    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
      AddErrorToStr(ErrorStr, 'Курс документа занижен!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс USD документа!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmScetFakturaDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSouces;
end;

procedure TfrmScetFakturaDocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmScetFakturaDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    if not FReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmScetFakturaDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор Получателя для счета на оплату') then
    begin
      if dialog.ItemsChanged then
      begin
        dmDB.IBCQueryCustomers.Close;
        dmDB.IBCQueryCustomers.Open;
      end;
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmScetFakturaDocDlg.lcbCT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmScetFakturaDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: integer;
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

procedure TfrmScetFakturaDocDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmScetFakturaDocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.fieldbyname('dt').Asinteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s от %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
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

procedure TfrmScetFakturaDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmScetFakturaDocDlg.OpenCT_Accounts;
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

procedure TfrmScetFakturaDocDlg.OpenDT_Accounts;
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

procedure TfrmScetFakturaDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;
  beContract.Text := '';

  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    IBCQueryRechizite.Active := True;

    if FCreateNewDocument then
    begin
      dmDB.IBCQueryDocs.Append;
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

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
      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      OpenDT_Accounts;
      OpenCT_Accounts;
    end
    else
    begin
      if FReadOnly then
      begin
                  // view only
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnOk.Visible := False;
        btnCancel.Caption := 'Закрыть';
        btnCancel.Default := True;
      end
      else
      begin
                  // Edit
        dmDB.IBCQueryDocs.Edit;
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (№%s от %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
        if not fSECURITY_ALLOW_CONTRACT then
        begin
          lbContractTitle.Visible := True;
          beContract.Visible := True;
          lbContractInfo.Visible := True;
        end;
      end;
    end;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;

    IBCQueryDocProps.Active := True;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not FReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSouces;

    raise;
  end;

end;

procedure TfrmScetFakturaDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор получателя для Счет Фактуры') then
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

procedure TfrmScetFakturaDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации для Счет Фактуры') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmScetFakturaDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmScetFakturaDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmScetFakturaDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
     // Контракт
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_СФ_СФ_Показывать_Контракт);
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

procedure TfrmScetFakturaDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmScetFakturaDocDlg.ShowSelectContractDialog;
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s от %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    lbContractInfo.Visible := True;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmScetFakturaDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmScetFakturaDocDlg.CloseAdditionalDataSouces;
begin
     // close additional datasets
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

end.


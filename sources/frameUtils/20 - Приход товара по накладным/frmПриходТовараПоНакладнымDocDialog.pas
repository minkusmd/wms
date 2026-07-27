unit frmПриходТовараПоНакладнымDocDialog;
{
 Приход Товара По Накладным.
 > Forma de editare a documentului
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle,
  cxContainer, cxEdit, Data.DB, IBC, Vcl.StdCtrls,
  cxDBEdit, cxButtonEdit,
  cxDBLookupComboBox, Vcl.ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  DBAccess, MemDS, cxMemo, cxCheckBox, cxCalc, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, cxLookupEdit,
  cxDBLookupEdit, dxUIAClasses, dxCoreGraphics;

type
  TfrmPrihodTovaraPoNakladnimDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    cxLabel3: TLabel;
    ceRATE: TcxDBCalcEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel8: TLabel;
    mmCOMMENTS: TcxDBMemo;
    Label1: TLabel;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    Bevel2: TBevel;
    Label2: TLabel;
    IBCQueryPaymentPeriod: TIBCQuery;
    IBCDataSourcePaymentPeriod: TIBCDataSource;
    bePaymentPeriod: TcxButtonEdit;
    lcbCURRENCY: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    lbContractTitle: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure bePaymentPeriodPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    fSECURITY_CanSetupPastDate: Boolean;
    fSECURITY_ALLOW_CONTRACT: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure DisplayPaymentInfo;
    procedure SetupPayment;
    procedure DeletePayment;
    procedure PrepareContract;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst,
  frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, frm20PaymentPeriodDialog, SWNSecurity,
  frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmPrihodTovaraPoNakladnimDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s от %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.bePaymentPeriodPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
     // delete
    0:
      DeletePayment;
     // setup
    1:
      SetupPayment;
  end;
end;

function TfrmPrihodTovaraPoNakladnimDocDlg.CheckParams: Boolean;
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

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Поставщик!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад организации!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
//          if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat<1) then AddErrorToStr(ErrorStr,'Курс документа!')
//          else
//          if (FieldByName('RATE').AsFloat<fRealRateValue/1.15) then AddErrorToStr(ErrorStr,'Курс документа занижен!');
    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс USD документа!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmPrihodTovaraPoNakladnimDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmPrihodTovaraPoNakladnimDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор Поставщика для входных счетов') then
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

procedure TfrmPrihodTovaraPoNakladnimDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPrihodTovaraPoNakladnimDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if fCreateNewDocument then
    ActiveControl := beCT_NAME
  else
    ActiveControl := lcbDTDEP;

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      dmDB.IBCQueryDocs.Append;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
             // Edit
      dmDB.IBCQueryDocs.Edit;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
    end;

    PrepareContract;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;
    IBCQueryPaymentPeriod.Active := True;
    DisplayPaymentInfo;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.PrepareContract;
begin
  beContract.Text := '';
  if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
  begin
    beContract.Text := Format('%s (№%s от %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
    if not fSECURITY_ALLOW_CONTRACT then
    begin
      beContract.Visible := True;
    end;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор поставщика для Приход товара по накладным') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации для Приход товара по накладным') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.SetupPayment;
var
  dialog: Tfrm20PaymentPeriodDlg;
begin
  dialog := Tfrm20PaymentPeriodDlg.Create(Self, IBCQueryPaymentPeriod, IBCDataSourcePaymentPeriod);
  try
    if dialog.ShowModal = mrOk then
      DisplayPaymentInfo;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Показывать_Контракт);
  if not fSECURITY_ALLOW_CONTRACT then
  begin
    lbContractTitle.Visible := False;
    beContract.Visible := False;
    beContract.Properties.Buttons.Clear;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) then
    beContract.Properties.Buttons.Clear;

  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmPrihodTovaraPoNakladnimDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryFirms.Close;
  dmDB.IBCQueryCustomers.Close;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.DeletePayment;
begin
  if ShowAskDialog('Удаление', 'Вы хотите удалить срок оплаты документа?') = mrYes then
  begin
    IBCQueryPaymentPeriod.Delete;
    DisplayPaymentInfo;
  end;
end;

procedure TfrmPrihodTovaraPoNakladnimDocDlg.DisplayPaymentInfo;
begin
  if IBCQueryPaymentPeriod.Eof then
  begin
    bePaymentPeriod.Text := 'Нет';
    bePaymentPeriod.Properties.Buttons[0].Enabled := False;
    bePaymentPeriod.Style.TextColor := clGrayText;
  end
  else
  begin
    bePaymentPeriod.Text := IBCQueryPaymentPeriod.FieldByName('PAYMENT_ENDDATA').AsString;
    bePaymentPeriod.Properties.Buttons[0].Enabled := True;
    bePaymentPeriod.Style.TextColor := clWindowText;
  end;
end;

end.


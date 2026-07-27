unit frmВходныеСчетаDocDialog;
{
 СЧЕТА - Входные Счета
 > Forma de editare a documentului
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxDBEdit,

  cxDBLookupComboBox, ExtCtrls, Menus,
  StdCtrls, cxButtons, DB, IBC, cxButtonEdit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, DBAccess, MemDS, cxMemo, cxCheckBox, cxCalc, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit,
  cxLookupEdit, cxDBLookupEdit, dxUIAClasses, dxCoreGraphics;

type
  TfrmVhodnieScetaDocDlg = class(TSWNCustomForm)
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
    ceRATEUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
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
    procedure PrepareContract;
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
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst,
  frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, Math, SWNSecurity, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmVhodnieScetaDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmVhodnieScetaDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;

end;

procedure TfrmVhodnieScetaDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmVhodnieScetaDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Indicati data documentlui!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Indicati analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Indicati intreprinderea!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Indicati subconto!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Indicati furnizorul!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Indicati depozitul intreprinderii!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Indicati valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Eroare la cursul documentlui!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Nu este indicat cursul USD!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmVhodnieScetaDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmVhodnieScetaDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmVhodnieScetaDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alege furnizorul') then
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

procedure TfrmVhodnieScetaDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmVhodnieScetaDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmVhodnieScetaDocDlg.Prepare;
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
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 496;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);

      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

//      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
             // Edit
      dmDB.IBCQueryDocs.Edit;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);
    end;

    PrepareContract;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmVhodnieScetaDocDlg.PrepareContract;
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

procedure TfrmVhodnieScetaDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alege furnizorul') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;

        if fSECURITY_ALLOW_CONTRACT then
        LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmVhodnieScetaDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises, cfSecuredFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Alege intreprinderea') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmVhodnieScetaDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmVhodnieScetaDocDlg.SetupSecurityItems;
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

procedure TfrmVhodnieScetaDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmVhodnieScetaDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmVhodnieScetaDocDlg.CloseAdditionalDataSources;
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

procedure TfrmVhodnieScetaDocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := TCustomerDefultContractInfo.Create(Self, CustomerID, DocDate);
  try
      //LoadCustomerDefaultContractInfo(CustomerID, DocDate);
      if Assigned(contractInfo) and (contractInfo.ContractID > 0) then
      begin
        beContract.Text := Format('%s (№%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code,
          FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);

        dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := iif(contractInfo.FLG_ACNT, 1, 0);
      end
      else
      begin
        dmdb.IBCQueryDocs.FieldByName('CONTRACTID').Value := -1;
        beContract.Text := '';
        beContract.Tag := -1;
      end;
  finally
      contractInfo.Free;
  end;
end;

end.


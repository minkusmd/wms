unit frmNSDocDialog;

// Sold initial

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, DB, DBAccess, IBC, MemDS,
  cxCalendar, cxDBEdit, cxMemo, cxCheckBox, cxDropDownEdit, cxCalc, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, StdCtrls, cxButtonEdit, Buttons, cxLookAndFeels,
  cxLookAndFeelPainters;

type
  TfrmNSDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    pnClient: TPanel;
    lbFirma: TLabel;
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
    Label2: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbDTSC: TcxDBLookupComboBox;
    cmbCurrency: TcxDBLookupComboBox;
    beContract: TcxButtonEdit;
    lbContractTitle: TLabel;
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbShowCurrencyCalcClick(Sender: TObject);
    procedure mmDocCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    FCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    FReadOnly: Boolean;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure ShowCurrencyCalc;
    procedure SetReadOnly(const Value: Boolean);
    procedure ShowDocumentCommentsEditorDialog;
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
  DateUtils, SWNUtils, SWNTypes, SWNConst, DataModuleDB, DataModuleAdditions,
  frmCustomersDlg, frmBanknoteCounterDialog, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, frmCustomerContractsDialog;

{$R *.dfm}

procedure TfrmNSDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmNSDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmNSDocDlg.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
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

function TfrmNSDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  if dmDB.IBCQueryDocs.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Data documentului!');

  if dmDB.IBCQueryDocs.FieldByName('SC2').IsNull then
    AddErrorToStr(ErrorStr, 'Analitica documentului!');

  if dmDB.IBCQueryDocs.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, 'Organizatia!');
  if dmDB.IBCQueryDocs.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, 'Analitica organizatiei!');

     // common fields
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Valuta!');
  if dmDB.IBCQueryDocs.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Curs!');
  if dmDB.IBCQueryDocs.FieldByName('SUMA').IsNull {or (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency<=0)} then
    AddErrorToStr(ErrorStr, 'Suma!');

  if dmDB.IBCQueryDocs.FieldByName('RATEUSD').IsNull or (dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat < 1) then
    AddErrorToStr(ErrorStr, 'Cursul USD al documentului!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmNSDocDlg.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
  end;
end;

procedure TfrmNSDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Selectare organizatie pentru "Sold initial"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmNSDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmNSDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmNSDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := false; //SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;
end;

procedure TfrmNSDocDlg.ShowCurrencyCalc;
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

procedure TfrmNSDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmNSDocDlg.WhenCancelForm;
begin
  if not FReadOnly then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmNSDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmNSDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmNSDocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmNSDocDlg.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
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

function TfrmNSDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmNSDocDlg.mmDocCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmNSDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // open data
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;
    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

    if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
    begin
      beContract.Text := Format('%s (nr.%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
    end;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Append;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local default
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsInteger := 1;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := -1;
      dmDB.IBCQueryDocs.FieldByName('CTSC').AsInteger := -1;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      if FReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCNO').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnOk.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCNO').AsInteger]);
        dmDB.IBCQueryDocs.Edit;

                  // Daca este prin contabilitatea, atunci numai MDL
        if dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1 then
        begin
          cmbCurrency.Enabled := False;
          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        end;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
    end;

  except
    if not FReadOnly then
    begin
      if dmDB.IBCQueryDocs.State in dsEditModes then
        dmDB.IBCQueryDocs.Cancel;
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    end;
    CloseAdditionalDataSources;
    raise;
  end;

end;

procedure TfrmNSDocDlg.sbShowCurrencyCalcClick(Sender: TObject);
begin
  ShowCurrencyCalc;
end;

end.


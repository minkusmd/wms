unit frmRNDocDialog;

// Nakladnaia de iesire

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxCalendar, cxDBEdit, cxMemo,
  cxDropDownEdit, cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxControls, cxContainer, cxEdit, cxLabel, ExtCtrls, Menus,
  StdCtrls, cxButtons, DB, DBAccess, IBC, MemDS, cxCheckBox, cxButtonEdit,
  cxLookAndFeels, cxLookAndFeelPainters, System.Actions, Vcl.ActnList, dxUIAClasses, dxCoreGraphics,
  cxImageComboBox, frameDocsDeliveryUnit;

type
  TfrmRNDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    lcbCURRENCY: TcxDBLookupComboBox;
    Label4: TLabel;
    lcbDocumentState: TcxDBLookupComboBox;
    cmbImageState: TcxDBImageComboBox;
    frameDelivery: TframeDocsDelivery;
    lblSecDocument: TLabel;
    lblSecParti: TLabel;
    lblSecValuta: TLabel;
    bvParti: TBevel;
    bvValuta: TBevel;
    lbAnalytics: TLabel;
    lbRate: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    FCustomCT: Integer;
    FAllowChangeCT: Boolean;
    FAllowChangeDT: Boolean;
    FCustomStock: Integer;
    FAllowChangeStock: Boolean;
    FCustomCurrency: Integer;
    FAllowChangeCurrency: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    fSECURITY_CanChangeAcc, fSECURITY_ALLOW_CONTRACT: Boolean;
    FReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure SetCustomCT(const Value: Integer);
    procedure SetAllowChangeCT(const Value: Boolean);
    procedure SetAllowChangeDT(const Value: Boolean);
    procedure SetCustomStock(const Value: Integer);
    procedure SetAllowChangeStock(const Value: Boolean);
    procedure SetCustomCurrency(const Value: Integer);
    procedure SetAllowChangeCurrency(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
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
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    procedure PrepareStatesImages;
    procedure SetCustomTitle(const Title: string);
    property AllowChangeDT: Boolean read FAllowChangeDT write SetAllowChangeDT;
    property CustomCT: Integer read FCustomCT write SetCustomCT;
    property AllowChangeCT: Boolean read FAllowChangeCT write SetAllowChangeCT;
    property CustomStock: Integer read FCustomStock write SetCustomStock;
    property AllowChangeStock: Boolean read FAllowChangeStock write SetAllowChangeStock;
    property CustomCurrency: Integer read FCustomCurrency write SetCustomCurrency;
    property AllowChangeCurrency: Boolean read FAllowChangeCurrency write SetAllowChangeCurrency;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, System.Types,
  frmCustomersDlg, SWNValueStorageUnit, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, SWNDBErrors,
  frmCustomerContractsDialog;

{$R *.dfm}
{ TfrmConfigurationDocDlg }

procedure TfrmRNDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  case AButtonIndex of
    0:   ShowSelectContractDialog;
    1:  begin
          beContract.Text := '';
          beContract.Tag := -1;
          dmDB.IBCQueryDocs.FieldByName('ContractID').AsInteger := -1;
        end;
  end;
end;

procedure TfrmRNDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmRNDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmRNDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data document!');
    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');
    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Intreprinderea!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica 2!');
    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Cumparator!');
    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata de schimb!');
    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata de schimb al USD!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmRNDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmRNDocDlg.FormCreate(Sender: TObject);
begin
  FAllowChangeDT := True;
  FCustomCT := -1;
  FAllowChangeCT := True;
  FCustomStock := -1;
  FAllowChangeStock := True;
  FCustomCurrency := -1;
  FReadOnly := False;
end;

function TfrmRNDocDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  begin
    try
      dmDB.IBCQueryDocs.Post;
      frameDelivery.PostData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);
      if IBCQueryDocProps.State in dsEditModes then
        IBCQueryDocProps.Post;

      if dmDB.IBCQueryDocs.UpdateTransaction.Active then
        dmDB.IBCQueryDocs.UpdateTransaction.Commit;

      Result := True;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmRNDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmRNDocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, CustomerID, DocDate);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (Nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
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

procedure TfrmRNDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmRNDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  ActiveControl := beCT_NAME;

  lbContractInfo.Visible := False;
  beContract.Text := '';

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;
    IBCQueryDocProps.Active := True;

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
        // dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      // user defaults
      if FCustomCT <> -1 then
        dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := FCustomCT;
      if FCustomStock <> -1 then
        dmDB.IBCQueryDocs.FieldByName('DTDEP').AsInteger := FCustomStock;
      if FCustomCurrency <> -1 then
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := FCustomCurrency;

      // local defaults

      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

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
        btnCancel.Caption := 'Inchide';
        btnCancel.Default := True;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        cbFLG_ACNT.Enabled := fSECURITY_CanChangeAcc;
        // Edit
        dmDB.IBCQueryDocs.Edit;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
      begin
        beContract.Text := Format('%s (Nr.%s din %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
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

    dmdb.IBCQueryDocTypeStates.Open;

    frameDelivery.ReadOnly := FReadOnly;
    frameDelivery.PrepareData(dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger);

    PrepareStatesImages;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmRNDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    // dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0, 'Alege cumparator') then
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

procedure TfrmRNDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, False, 0, 'Alege intreprinderea') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRNDocDlg.SetAllowChangeCT(const Value: Boolean);
begin
  FAllowChangeCT := Value;
  beCT_NAME.Enabled := Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeCurrency(const Value: Boolean);
begin
  FAllowChangeCurrency := Value;
  lcbCURRENCY.Enabled := Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeDT(const Value: Boolean);
begin
  FAllowChangeDT := Value;
  beDT_NAME.Enabled := Value;
end;

procedure TfrmRNDocDlg.SetAllowChangeStock(const Value: Boolean);
begin
  FAllowChangeStock := Value;
  lcbDTDEP.Enabled := Value;
end;

procedure TfrmRNDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmRNDocDlg.SetCustomCT(const Value: Integer);
begin
  FCustomCT := Value;
end;

procedure TfrmRNDocDlg.SetCustomCurrency(const Value: Integer);
begin
  FCustomCurrency := Value;
end;

procedure TfrmRNDocDlg.SetCustomStock(const Value: Integer);
begin
  FCustomStock := Value;
end;

procedure TfrmRNDocDlg.SetCustomTitle(const Title: string);
begin
  dtDialogTitle.Title := Title;
  Caption := Title;
end;

procedure TfrmRNDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmRNDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  fSECURITY_CanChangeAcc := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_FLG_Провести_по_бухгалтерии);

     // Contract
  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Показывать_Контракт);
  if not fSECURITY_ALLOW_CONTRACT then
  begin
    lbContractTitle.Visible := False;
    beContract.Visible := False;
    lbContractInfo.Visible := False;
    beContract.Properties.Buttons.Clear;
  end;
  if not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) then
    beContract.Properties.Buttons.Clear;

  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := False;
end;

procedure TfrmRNDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmRNDocDlg.ShowSelectContractDialog;
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

procedure TfrmRNDocDlg.CloseAdditionalDataSources;
begin
  // close additional datasets
  frameDelivery.CloseData;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
end;

procedure TfrmRNDocDlg.PrepareStatesImages;
var
  item: TcxImageComboBoxItem;
  i: integer;
begin
  i := 0;
  dmDB.IBCQueryDocTypeStates.Open;
  dmDB.IBCQueryDocTypeStates.First;
  while not dmdb.IBCQueryDocTypeStates.Eof do
  begin
    Item := cmbImageState.Properties.Items.Add;
    item.Value := dmdb.IBCQueryDocTypeStates.FieldByName('stateid').AsInteger;
    item.Description := dmdb.IBCQueryDocTypeStates.FieldByName('title').AsString;
    item.ImageIndex := i;
    inc(i);
    dmdb.IBCQueryDocTypeStates.Next;
  end;
end;

procedure TfrmRNDocDlg.WhenCancelForm;
begin
  frameDelivery.CancelData;

  IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;

  if dmDB.IBCQueryDocs.UpdateTransaction.Active then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

end.


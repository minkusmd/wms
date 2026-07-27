unit frmRealizatiaDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxGraphics,
  cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxControls, cxContainer, cxEdit, cxLabel, ExtCtrls, Menus, StdCtrls, cxButtons, DB, DBAccess, IBC,
  MemDS, cxCheckBox, cxButtonEdit, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, dxCoreGraphics, dxUIAClasses;

type
  TfrmRealizatiaDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    edINBAZA: TcxDBTextEdit;
    cxLabel8: TLabel;
    cxLabel7: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    Bevel1: TBevel;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure PrepareContract;
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    fSECURITY_CanSetupPastDate: Boolean;
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
    procedure SetReadOnly(const Value: Boolean);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property ReadOnly: Boolean read fReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNSecurity, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmRealizatiaDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  contractInfo: TCustomerDefultContractInfo;
begin
  contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
  if Assigned(contractInfo) then
  begin
    beContract.Text := Format('%s (№%s от %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy',
      contractInfo.SignDate)]);
    dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//    dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
    if contractInfo.FLG_ACNT then
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
  end;
end;

procedure TfrmRealizatiaDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmRealizatiaDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmRealizatiaDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Дата документа!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика документа!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Контрагент!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
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

procedure TfrmRealizatiaDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmRealizatiaDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmRealizatiaDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmRealizatiaDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmRealizatiaDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if fCreateNewDocument then
    ActiveControl := beCT_NAME
  else
    ActiveControl := lcbDTDEP;

  if not fReadOnly then
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
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 840;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      if fReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;
        btnOk.Visible := False;
        btnCancel.Caption := cMSG_ButtonClose;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
                  // Edit
        dmDB.IBCQueryDocs.Edit;
      end;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);
    end;

    PrepareContract;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    if not fReadOnly then
    begin
      if dmDB.IBCQueryDocs.State in dsEditModes then
        dmDB.IBCQueryDocs.Cancel;
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    end;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmRealizatiaDocDlg.PrepareContract;
begin
  beContract.Text := '';
  if not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
  begin
    beContract.Text := Format('%s (№%s от %s)', [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString, dmDB.IBCQueryDocs.FieldByName
      ('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy', dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)]);
                  // ??? daca cumva acest document are contract, aratam info fortat
    if not fSECURITY_ALLOW_CONTRACT then
    begin
      beContract.Visible := True;
    end;
  end;
end;

procedure TfrmRealizatiaDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter;
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Выбор контрагента для Принятие в баланс с комисии') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRealizatiaDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0,
      'Выбор организации для Принятие в баланс с комисии') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmRealizatiaDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmRealizatiaDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmRealizatiaDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

     // Контракт
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

procedure TfrmRealizatiaDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmRealizatiaDocDlg.WhenCancelForm;
begin
  if not fReadOnly then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmRealizatiaDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

end.


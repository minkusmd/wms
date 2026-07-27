unit frmServiceZamenaPoBrakuDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxGraphics,
  cxButtonEdit, DB, DBAccess, IBC, MemDS, StdCtrls, cxCheckBox, cxDBEdit, cxCalc,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCoreGraphics, cxDropDownEdit, cxCalendar, cxMemo, cxTextEdit, cxMaskEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Vcl.ExtCtrls, dxUIAClasses;

type
  TfrmServiceZamenaPoBrakuDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cxLabel6: TLabel;
    cxLabel11: TLabel;
    lcbDT_CD: TcxDBLookupComboBox;
    cxLabel10: TLabel;
    lcbCT_CD: TcxDBLookupComboBox;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    ceRATE: TcxDBCalcEdit;
    cbFLG_ACNT: TcxDBCheckBox;
    Label1: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    beCT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    ceRATEUSD: TcxDBCalcEdit;
    Label2: TLabel;
    lcbCURRENCY: TcxDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCT_AccountPropertiesInitPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lcbDTPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTPropertiesEditValueChanged(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fRealRateValue: double;
    fCreateNewDocument: Boolean;
    fReadOnly: Boolean;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure OpenDT_Accounts;
    procedure OpenCT_Accounts;
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
    property CreateNewDocument: Boolean read FCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, frmCustomersDlg, SWNValueStorageUnit, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmServiceZamenaPoBrakuDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmServiceZamenaPoBrakuDocDlg.CheckParams: Boolean;
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

    if FieldByName('DT').IsNull or (FieldByName('DT').asInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if FieldByName('CT').IsNull or (FieldByName('CT').asInteger = -1) then
      AddErrorToStr(ErrorStr, 'Получатель!');

    if FieldByName('DTDEP').IsNull then
      AddErrorToStr(ErrorStr, 'Склад!');
  end;

  if IBCQueryRechizite.FieldByName('DT_CD').IsNull then
    AddErrorToStr(ErrorStr, 'Реквизиты организации!');
     //if IBCQueryRechizite.FieldByName('CT_CD').IsNull then AddErrorToStr(ErrorStr,'Реквизиты получателя!');
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
end;

function TfrmServiceZamenaPoBrakuDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Выбор Получателя для Возврата товара поставщику') then
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

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbCTPropertiesEditValueChanged(Sender: TObject);
begin
  if IBCQueryRechizite.Active and (dmDB.IBCQueryDocs.State in dsEditModes) then
  begin
    if IBCQueryRechizite.State <> dsEdit then
      IBCQueryRechizite.Edit;
    IBCQueryRechizite.FieldByName('CT_CD').Value := NULL;
  end;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbCT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbDTPropertiesEditValueChanged(Sender: TObject);
begin
  if IBCQueryRechizite.Active and (dmDB.IBCQueryDocs.State in dsEditModes) then
  begin
    if IBCQueryRechizite.State <> dsEdit then
      IBCQueryRechizite.Edit;
    IBCQueryRechizite.FieldByName('DT_CD').Value := NULL;
  end;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.OpenCT_Accounts;
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

procedure TfrmServiceZamenaPoBrakuDocDlg.OpenDT_Accounts;
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

procedure TfrmServiceZamenaPoBrakuDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  if not fReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;

  try
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    IBCQueryRechizite.Active := True;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Append;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger,
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

      deDATA.Properties.MinDate := NOW;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);

      OpenDT_Accounts;
      OpenCT_Accounts;
    end
    else
    begin
      if fReadOnly then
      begin
        pnClient.Enabled := False;
        btnOk.Visible := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        btnCancel.Caption := cMSG_ButtonClose;
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
        deDATA.Properties.MinDate := NOW;
      end;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);
    end;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;

    IBCQueryDocProps.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    IBCQueryDocProps.Cancel;
    IBCQueryDocProps.Close;
    IBCQueryRechizite.Cancel;
    IBCQueryRechizite.Close;
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not fReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    CloseAdditionalDataSources;

    raise;
  end;

end;

procedure TfrmServiceZamenaPoBrakuDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfVendors];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Выбор получателя для Возврат товара поставщику') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;

      OpenCT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0,
      'Выбор организации для Возврат товара поставщику') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.SetupSecurityItems;
begin
  inherited;
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmServiceZamenaPoBrakuDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmServiceZamenaPoBrakuDocDlg.WhenCancelForm;
begin
  IBCQueryDocProps.Cancel;
  IBCQueryDocProps.Close;
  IBCQueryRechizite.Cancel;
  IBCQueryRechizite.Close;

  if not fReadOnly then
  begin
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmServiceZamenaPoBrakuDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryCurrency.Close;
end;

end.


unit frmPeremesheniePDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, DB, IBC, StdCtrls, cxButtonEdit,
  cxDBEdit,

  cxDBLookupComboBox, ExtCtrls, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess,
  MemDS, cxCheckBox, cxCalendar, cxMemo, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxTextEdit, cxMaskEdit, cxCalc,
  dxUIAClasses, dxCoreGraphics;

type
  TfrmPeremesheniePDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    Label8: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    Label6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    Label11: TLabel;
    lcbDT_Account: TcxDBLookupComboBox;
    Label10: TLabel;
    lcbCT_Account: TcxDBLookupComboBox;
    Label12: TLabel;
    lcbCTDEP: TcxDBLookupComboBox;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    Label5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    Label4: TLabel;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCT_AccountPropertiesInitPopup(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    fSECURITY_CanSetupPastDate: Boolean;
    fReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
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
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst,
  frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNDBErrors, SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmPeremesheniePDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmPeremesheniePDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmPeremesheniePDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data nu este setata!')
    else
    begin
      if not fCreateNewDocument then
      begin
        if (DateOf(FieldByName('DATA').AsDateTime) < DateOf(NOW)-7) and (not fSECURITY_CanSetupPastDate) then
          AddErrorToStr(ErrorStr, 'Data documentului e prea veche!');
      end;
    end;

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Furnizor!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Beneficiar!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit furnizor!');
    if FieldByName('CTDEP').IsNull or (FieldByName('CTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit beneficiar!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata documentului!');

    if SWNSecurityManager.LoggedUser.IsInAdminGroup then
    begin
    if FieldByName('CT').AsInteger = FieldByName('DT').AsInteger then
    begin
      if FieldByName('DTDEP').asInteger = FieldByName('CTDEP').AsInteger then
        AddErrorToStr(ErrorStr, 'Depozitele sunt identice, corectati!');
    end;
    end;
  end;

  if IBCQueryRechizite.FieldByName('DT_CD').IsNull then
    AddErrorToStr(ErrorStr, 'Rechizitele furnizorului!');
  if IBCQueryRechizite.FieldByName('CT_CD').IsNull then
    AddErrorToStr(ErrorStr, 'Rechizitele beneficiarului!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmPeremesheniePDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmPeremesheniePDocDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
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

procedure TfrmPeremesheniePDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alegeti beneficiarul transferului') then
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

procedure TfrmPeremesheniePDocDlg.lcbCT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmPeremesheniePDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmPeremesheniePDocDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmPeremesheniePDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmPeremesheniePDocDlg.OpenCT_Accounts;
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

procedure TfrmPeremesheniePDocDlg.OpenDT_Accounts;
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

procedure TfrmPeremesheniePDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if fCreateNewDocument then
    Self.ActiveControl := beCT_NAME
  else
    Self.ActiveControl := lcbCT_Account;

  if not fReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    IBCQueryRechizite.Active := True;

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
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('FLG_PROTECTED').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('FLG_SEND').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('FLG_RECEIVE').AsInteger := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      OpenDT_Accounts;
      OpenCT_Accounts;
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
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
        fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
      end;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;

      IBCQueryDT_Accounts.Active := True;
      IBCQueryCT_Accounts.Active := True;
    end;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;
  except
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Cancel;

    IBCQueryDocProps.Close;
    IBCQueryRechizite.Close;

    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not fReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmPeremesheniePDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alege beneficiarul pentru factura') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;

      OpenCT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPeremesheniePDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfSecuredFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Alege furnizorul transferului') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmPeremesheniePDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmPeremesheniePDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmPeremesheniePDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmPeremesheniePDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmPeremesheniePDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;

  IBCQueryDocProps.Close;
  IBCQueryRechizite.Close;

  if dmDB.IBCQueryDocs.State in dsEditModes then
    dmDB.IBCQueryDocs.Cancel;
  if not fReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmPeremesheniePDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

end.


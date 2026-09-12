unit frmOstatokDenegNaScetuDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, ExtCtrls,
  cxGraphics, DB, DBAccess, IBC, MemDS, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, StdCtrls, cxButtonEdit, cxLookAndFeels,
  cxLookAndFeelPainters, Buttons, cxCheckBox, dxCoreGraphics, dxUIAClasses;

type
  TfrmOstatokDenegNaScetuDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCDataSourceDocProps: TIBCDataSource;
    IBCQueryDocProps: TIBCQuery;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel4: TLabel;
    ceRATE: TcxDBCalcEdit;
    cxLabel6: TLabel;
    ceSUMA: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    lcbDT_CD: TcxDBLookupComboBox;
    deDATA: TcxDBDateEdit;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    cbFLG_ACNT: TcxDBCheckBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLG_ACNTPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    fInPrepareMode: Boolean;
    fCreateNewDocument: Boolean;
    FReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure OpenDT_Accounts;
    procedure SetReadOnly(const Value: Boolean);
    procedure ShowDocumentCommentsEditorDialog;
    procedure ReCalcCurrencyRate;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNTypes, frmCustomersDlg, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, frmBPPLSelectCustomUSDRateDialog, SWNDBErrors;

{$R *.dfm}
{ TfrmBankPDNSDlg }

procedure TfrmOstatokDenegNaScetuDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.cbFLG_ACNTPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
    ReCalcCurrencyRate;
end;

function TfrmOstatokDenegNaScetuDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!');

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Organizatia!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica organizatiei!');

    if IBCQueryRechizite.FieldByName('DT_CD').IsNull or (IBCQueryRechizite.FieldByName('DT_CD').AsString = '') then
      AddErrorToStr(ErrorStr, 'Contul curent al organizatiei!');

    if FieldByName('SUMA').IsNull or (FieldByName('SUMA').AsCurrency = 0) then
      AddErrorToStr(ErrorStr, 'Suma!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat <= 0) then
      AddErrorToStr(ErrorStr, 'Cursul documentului!');
    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
  end;

  if (ErrorStr = '') then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmOstatokDenegNaScetuDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.FormCreate(Sender: TObject);
begin
  fCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmOstatokDenegNaScetuDocDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  if CheckParams then
  try
    dmDB.IBCQueryDocs.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;
    CloseAdditionalDataSources;
    Result := True;
  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
    ReCalcCurrencyRate;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.OpenDT_Accounts;
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
  if IBCQueryRechizite.State <> dsEdit then
    IBCQueryRechizite.Edit;
  if not IBCQueryDT_Accounts.Eof then
    IBCQueryRechizite.FieldByName('DT_CD').Value := IBCQueryDT_Accounts.FieldByName('ACCOUNTNUMBER').AsString
  else
    IBCQueryRechizite.FieldByName('DT_CD').Value := NULL;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  fInPrepareMode := True;
  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;

    IBCQueryRechizite.Active := True;
    IBCQueryDocProps.Active := True;

    IBCQueryDT_Accounts.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      dmDB.IBCQueryDocs.Insert;

      dmDB.IBCQueryDocs.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
             // system defaults
      if dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
      end
      else
      begin
                  // local defaults
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
      end;
             // always
      dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := -1;

      dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger,
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);

      OpenDT_Accounts;
    end
    else
    begin
      if FReadOnly then
      begin
                  // view Only
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
        pnClient.Enabled := False;
        btnOk.Visible := False;
        btnCancel.Default := True;
        btnCancel.Caption := cMSG_ButtonClose;
      end
      else
      begin
                  // Edit
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;
      end;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
    end;

    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    if not FReadOnly then
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    CloseAdditionalDataSources;
    raise;
  end;
  fInPrepareMode := False;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.ReCalcCurrencyRate;
begin
  if fInPrepareMode then
    Exit;
  dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
    = 1);
  dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger,
    dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
end;

procedure TfrmOstatokDenegNaScetuDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, False, 0, 'Selectare organizatie pentru ' +
      dtDialogTitle.Title) then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;

      OpenDT_Accounts;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmOstatokDenegNaScetuDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  if IBCQueryRechizite.State in dsEditModes then
    IBCQueryRechizite.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  if not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  CloseAdditionalDataSources;
end;

procedure TfrmOstatokDenegNaScetuDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryCurrency.FilterSQL := '';
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
end;

end.


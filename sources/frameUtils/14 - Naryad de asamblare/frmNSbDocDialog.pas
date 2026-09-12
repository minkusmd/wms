unit frmNSbDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxCalendar, cxDBEdit, cxMemo,
  cxDropDownEdit, cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxControls, cxContainer, cxEdit, cxLabel, ExtCtrls, Menus,
  StdCtrls, cxButtons, DB, DBAccess, IBC, MemDS, cxCheckBox, cxButtonEdit,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  TfrmNSbDocDlg = class(TSWNCustomForm)
    beCT_NAME: TcxButtonEdit;
    beDT_NAME: TcxButtonEdit;
    Bevel1: TBevel;
    cbFLG_ACNT: TcxDBCheckBox;
    ceRATE: TcxDBCalcEdit;
    ceRATEUSD: TcxDBCalcEdit;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    cxLabel5: TLabel;
    cxLabel6: TLabel;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    dtDialogTitle: TDialogTitle;
    IBCDataSourceDocProps: TIBCDataSource;
    IBCQueryDocProps: TIBCQuery;
    Label1: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbCURRENCY: TcxDBLookupComboBox;
    lcbDTDEP: TcxDBLookupComboBox;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    pnClient: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cbFLG_FURNITURE: TcxDBCheckBox;
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    FAllowChangeCT: Boolean;
    FAllowChangeCurrency: Boolean;
    FAllowChangeDT: Boolean;
    FAllowChangeStock: Boolean;
    { Private declarations }
    fCreateNewDocument: Boolean;
    FCustomCT: integer;
    FCustomCurrency: integer;
    FCustomStock: integer;
    FReadOnly: Boolean;
    fRealRateValue: double;
    fSECURITY_CanSetupPastDate: Boolean;
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectCT;
    procedure SelectDT;
    procedure SetAllowChangeCT(const Value: Boolean);
    procedure SetAllowChangeCurrency(const Value: Boolean);
    procedure SetAllowChangeDT(const Value: Boolean);
    procedure SetAllowChangeStock(const Value: Boolean);
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure SetCustomCT(const Value: integer);
    procedure SetCustomCurrency(const Value: integer);
    procedure SetCustomStock(const Value: integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure ShowDocumentCommentsEditorDialog;
  protected
    function IsFormDataPosted: Boolean; override;
    { protected declarations }
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
    procedure WhenCancelForm; override;
  public
    procedure SetCustomTitle(const Title: string);
    property AllowChangeCT: Boolean read FAllowChangeCT write SetAllowChangeCT;
    property AllowChangeCurrency: Boolean read FAllowChangeCurrency write SetAllowChangeCurrency;
    property AllowChangeDT: Boolean read FAllowChangeDT write SetAllowChangeDT;
    property AllowChangeStock: Boolean read FAllowChangeStock write SetAllowChangeStock;
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property CustomCT: integer read FCustomCT write SetCustomCT;
    property CustomCurrency: integer read FCustomCurrency write SetCustomCurrency;
    property CustomStock: integer read FCustomStock write SetCustomStock;
    property readonly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions,
  frmCustomersDlg, SWNValueStorageUnit, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmNSbDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmNSbDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmNSbDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmNSbDocDlg.FormCreate(Sender: TObject);
begin
  FAllowChangeDT := True;
  FCustomCT := -1;
  FAllowChangeCT := True;
  FCustomStock := -1;
  FAllowChangeStock := True;
  FCustomCurrency := -1;
  FReadOnly := False;
end;

procedure TfrmNSbDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmNSbDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

function TfrmNSbDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!')
    else
    begin
      if not fCreateNewDocument then
      begin
        if not ((FieldByName('CREATED_BY').asInteger <> dmDB.CurrentUserID) and SWNSecurityManager.LoggedUser.IsInAdminGroup) then
          if DateOf(FieldByName('DATA').asDateTime) < DateOf(NOW) then
            AddErrorToStr(ErrorStr, 'Data este prea veche!');
      end;
    end;

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Subdiviziunea!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica 2!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Client!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Depozit!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Valuta!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata valutei!');


    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Rata USD!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmNSbDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
end;

procedure TfrmNSbDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Alege clientul pentru producere') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmNSbDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Alege intreprinderea pentru producere') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmNSbDocDlg.SetAllowChangeCT(const Value: Boolean);
begin
  FAllowChangeCT := Value;
  beCT_NAME.Enabled := Value;
end;

procedure TfrmNSbDocDlg.SetAllowChangeCurrency(const Value: Boolean);
begin
  FAllowChangeCurrency := Value;
  lcbCURRENCY.Enabled := Value;
end;

procedure TfrmNSbDocDlg.SetAllowChangeDT(const Value: Boolean);
begin
  FAllowChangeDT := Value;
  beDT_NAME.Enabled := Value;
end;

procedure TfrmNSbDocDlg.SetAllowChangeStock(const Value: Boolean);
begin
  FAllowChangeStock := Value;
  lcbDTDEP.Enabled := Value;
end;

procedure TfrmNSbDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmNSbDocDlg.SetCustomCT(const Value: integer);
begin
  FCustomCT := Value;
end;

procedure TfrmNSbDocDlg.SetCustomCurrency(const Value: integer);
begin
  FCustomCurrency := Value;
end;

procedure TfrmNSbDocDlg.SetCustomStock(const Value: integer);
begin
  FCustomStock := Value;
end;

procedure TfrmNSbDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmNSbDocDlg.ShowDocumentCommentsEditorDialog;
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

function TfrmNSbDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmNSbDocDlg.Prepare;
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
             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
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
                  // Edit
        dmDB.IBCQueryDocs.Edit;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1)
    end;

    IBCQueryDocProps.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmNSbDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmNSbDocDlg.WhenCancelForm;
begin
  IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmNSbDocDlg.SetCustomTitle(const Title: string);
begin
  dtDialogTitle.Title := Title;
  Caption := Title;
end;

end.


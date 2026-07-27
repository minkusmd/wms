unit frmKBPDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, cxGraphics,
  DB, DBAccess, IBC, MemDS, cxCalendar, cxDBEdit, cxMemo, cxCheckBox, cxDropDownEdit, cxCalc, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ExtCtrls, StdCtrls, cxButtonEdit, Buttons,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, dxCoreGraphics, dxUIAClasses;

type
  TfrmKBPDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    pnClient: TPanel;
    lbFirma: TLabel;
    lbClient: TLabel;
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
    beCT_NAME: TcxButtonEdit;
    ceRATEUSD: TcxDBCalcEdit;
    Label2: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    lcbDT_CD: TcxDBLookupComboBox;
    lcbCT_CD: TcxDBLookupComboBox;
    Label3: TLabel;
    Label4: TLabel;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCQueryCT_Accounts: TIBCQuery;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    IBCDataSourceRechizite: TIBCDataSource;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    cmbCURRENCY: TcxDBLookupComboBox;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmDocCOMMENTSClick(Sender: TObject);
    procedure lcbCT_CDPropertiesInitPopup(Sender: TObject);
    procedure lcbDT_CDPropertiesInitPopup(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fReadOnly: Boolean;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
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
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    property readonly: Boolean read fReadOnly write SetReadOnly;
  end;

implementation

uses
  DateUtils, SWNUtils, SWNTypes, SWNConst, DataModuleDB, DataModuleAdditions, frmCustomersDlg, frmBanknoteCounterDialog,
  SWNSecurityFlags, SWNSecurity, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog;

{$R *.dfm}

procedure TfrmKBPDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmKBPDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmKBPDocDlg.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
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
        dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger,
          flg);
      end;
    end;
  end;
end;

function TfrmKBPDocDlg.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;

  if dmDB.IBCQueryDocs.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Дата документа!');

  if dmDB.IBCQueryDocs.FieldByName('SC2').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика документа!');

  if dmDB.IBCQueryDocs.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, 'Плательшик!');
  if dmDB.IBCQueryDocs.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика плательшика!');

  if dmDB.IBCQueryDocs.FieldByName('CT').IsNull then
    AddErrorToStr(ErrorStr, 'Получатель!');

     // common fields
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Валюта!');
  if dmDB.IBCQueryDocs.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Курс!');
  if dmDB.IBCQueryDocs.FieldByName('SUMA').IsNull or (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency <= 0) then
    AddErrorToStr(ErrorStr, 'Сумма!');

  if dmDB.IBCQueryDocs.FieldByName('RATEUSD').IsNull or (dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat < 1) then
    AddErrorToStr(ErrorStr, 'Курс USD документа!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmKBPDocDlg.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger,
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
  end;
end;

procedure TfrmKBPDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Выбор получателья для "Комиссион банковского платежа"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmKBPDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfFirms,cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0,
      'Выбор плательшика для "Комиссион банковского платежа"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmKBPDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmKBPDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmKBPDocDlg.SetupSecurityItems;
begin
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmKBPDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmKBPDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmKBPDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmKBPDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmKBPDocDlg.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmKBPDocDlg.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
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

function TfrmKBPDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmKBPDocDlg.lcbCT_CDPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmKBPDocDlg.lcbDT_CDPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmKBPDocDlg.mmDocCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmKBPDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // open data
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    IBCQueryRechizite.Active := True;
    IBCQueryDocProps.Active := True;

    dmDB.OpenAnalyticsDataSource;
    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Insert;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
      end;
             // always defaults
      dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
      dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsInteger := 1;

             // local default
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := False;
      cmbCurrency.Enabled := False;
    end
    else
    begin
      if FReadOnly then
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        pnClient.Enabled := False;
        dtDialogTitle.Color := cCOLOR_DocReadOnly;
      end
      else
      begin
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
        dmDB.IBCQueryDocs.Edit;

        cbFLG_ACNT.Enabled := False;
        cmbCurrency.Enabled := False;
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
    end;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;

end;

end.


unit frmAktSpisaniaDocDialog;
{
 ИНВЕНТАРИЗАЦИЯ - Акт списания
 > Forma de editare a documentului
}

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
  TfrmAktSpisaniaDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel3: TLabel;
    ceRATE: TcxDBCalcEdit;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    lcbDTDEP: TcxDBLookupComboBox;
    Bevel1: TBevel;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    Label1: TLabel;
    ceRATEUSD: TcxDBCalcEdit;
    lcbCURRENCY: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    FReadOnly: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
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
  frmCustomersDlg, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmAktSpisaniaDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации для Акта списания') then
    begin
      if dialog.ItemsChanged then
      begin
        dmDB.IBCQueryCustomers.Close;
        dmDB.IBCQueryCustomers.Open;
      end;
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

function TfrmAktSpisaniaDocDlg.CheckParams: Boolean;
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
      AddErrorToStr(ErrorStr, 'Отправитель!');
    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад отправителя!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс документа!')
    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
      AddErrorToStr(ErrorStr, Format('Курс документа занижен! Минимально %f', [fRealRateValue]));
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmAktSpisaniaDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmAktSpisaniaDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmAktSpisaniaDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmAktSpisaniaDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmAktSpisaniaDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  if fReadOnly then
  begin
    btnOk.Visible := False;
    btnCancel.Caption := cMSG_ButtonClose;
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    pnClient.Enabled := False;
  end
  else
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;

  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.IBCQueryStocks.FilterSQL := 'STOCKID<>-1';
    dmDB.IBCQueryStocks.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      dmDB.IBCQueryDocs.Append;

             // defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;
      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('VAT').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      if fReadOnly then
      begin
                  // View Only
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
      end
      else
      begin
                  // Edit
        dmDB.IBCQueryDocs.Edit;
        dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
      end;

      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
    end;

    IBCQueryDocProps.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    if not fReadOnly then
    begin
      if dmDB.IBCQueryDocs.State in dsEditModes then
        dmDB.IBCQueryDocs.Cancel;
      IBCQueryDocProps.Active := False;
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    end;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmAktSpisaniaDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmAktSpisaniaDocDlg.SetReadOnly(const Value: Boolean);
begin
  fReadOnly := Value;
end;

procedure TfrmAktSpisaniaDocDlg.SetupSecurityItems;
begin
  inherited;
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;
end;

procedure TfrmAktSpisaniaDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmAktSpisaniaDocDlg.WhenCancelForm;
begin
  if not fReadOnly then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmAktSpisaniaDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

end.


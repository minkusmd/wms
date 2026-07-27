unit frmServiceReturnFromVendorDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, DB, IBC,
  StdCtrls, cxDBEdit, cxCalendar, ExtCtrls, cxButtonEdit, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxCheckBox, cxMemo, cxDropDownEdit, cxCalc,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, dxCoreGraphics, cxDBLookupComboBox, dxUIAClasses;

type
  TfrmServiceReturnFromVendorDocDlg = class(TSWNCustomForm)
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
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    beCT_NAME: TcxButtonEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    ceRATEUSD: TcxDBCalcEdit;
    Label2: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    lcbCURERNCY: TcxDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    procedure SetCreateNewDocument(const Value: Boolean);
    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowDocumentCommentsEditorDialog;
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmServiceReturnFromVendorDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmServiceReturnFromVendorDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmServiceReturnFromVendorDocDlg.CheckParams: Boolean;
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
      AddErrorToStr(ErrorStr, 'Поставщик!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад отправителя!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс документа!')
    else if (FieldByName('RATE').AsFloat < fRealRateValue / 1.05) then
      AddErrorToStr(ErrorStr, 'Курс документа занижен!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceReturnFromVendorDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmServiceReturnFromVendorDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmServiceReturnFromVendorDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор Поставщика для входных счетов') then
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

procedure TfrmServiceReturnFromVendorDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmServiceReturnFromVendorDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmServiceReturnFromVendorDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;
    dmDB.IBCQueryStocks.Active := True;

    if fCreateNewDocument then
    begin
             // Append
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Insert;

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
    end
    else
    begin
             // Edit
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);

      dmDB.IBCQueryDocs.Edit;
      deDATA.Properties.MinDate := NOW;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);
    end;

    IBCQueryDocProps.Active := True;

  except
    IBCQueryDocProps.Close;
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmServiceReturnFromVendorDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=[cfVendors];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Выбор поставщика для Возврат от поставщику') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceReturnFromVendorDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0,
      'Выбор организации для Возврат от поставщику') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceReturnFromVendorDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmServiceReturnFromVendorDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmServiceReturnFromVendorDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmServiceReturnFromVendorDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
end;

end.


unit frmCorrespondentaDlg;
{
 СЧЕТА - Входные Счета
 > Forma de editare a documentului
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, cxCalendar, cxDBEdit, cxMemo,
  cxDropDownEdit, cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxControls, cxContainer, cxEdit, cxLabel, ExtCtrls, Menus,
  StdCtrls, cxButtons, DB, DBAccess, IBC, MemDS, cxCheckBox, cxButtonEdit,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, dxUIAClasses, dxCoreGraphics;

type
  TfrmCorespondentaDialog = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    deDATA: TcxDBDateEdit;
    btnOk: TButton;
    btnCancel: TButton;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cxLabel5: TLabel;
    Bevel1: TBevel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    cxLabel8: TLabel;
    mmCOMMENTS: TcxDBMemo;
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
    fSECURITY_CanSetupPastDate: Boolean;
    fSECURITY_ALLOW_CONTRACT: Boolean;
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
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
  end;

implementation

uses
  DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions,
  frmCustomersDlg, SWNValueStorageUnit, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, Math, SWNSecurity, frmCustomerContractsDialog;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmCorespondentaDialog.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmCorespondentaDialog.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmCorespondentaDialog.CheckParams: Boolean;
var
  ErrorStr: string;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Дата документа!')
    else
    begin
      if (DateOf(FieldByName('DATA').AsDateTime) < DateOf(NOW)) and (not fSECURITY_CanSetupPastDate) then
        AddErrorToStr(ErrorStr, 'Дата документа слишком стара!');
    end;

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика документа!');

    if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Организация!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Аналитика организации!');

    if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Поставщик!');

    if FieldByName('DTDEP').IsNull or (FieldByName('DTDEP').AsInteger = -1) then
      AddErrorToStr(ErrorStr, 'Склад организации!');
    if FieldByName('CURRENCYID').IsNull then
      AddErrorToStr(ErrorStr, 'Валюта!');
    if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс документа!')
    else if (FieldByName('RATE').AsFloat < RoundTo(fRealRateValue / 1.1, -2)) then
      AddErrorToStr(ErrorStr, 'Курс документа занижен!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Курс USD документа!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmCorespondentaDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmCorespondentaDialog.IsFormDataPosted: Boolean;
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

procedure TfrmCorespondentaDialog.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор контрагента') then
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

procedure TfrmCorespondentaDialog.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmCorespondentaDialog.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmCorespondentaDialog.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;
    ActiveControl := beCT_NAME;

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
             // defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 496;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
      end;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);

      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);
    end
    else
    begin
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
             // Edit
      dmDB.IBCQueryDocs.Edit;
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);
    end;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

  except
    if dmDB.IBCQueryDocs.State in dsEditModes then
      dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmCorespondentaDialog.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор контрагента') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCorespondentaDialog.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises, cfSecuredFirms];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор организации') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmCorespondentaDialog.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmCorespondentaDialog.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

  fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Показывать_Контракт);
end;

procedure TfrmCorespondentaDialog.ShowDocumentCommentsEditorDialog;
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

procedure TfrmCorespondentaDialog.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmCorespondentaDialog.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryFirms.Close;
  dmDB.IBCQueryCustomers.Close;
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
  dmDB.IBCQueryStocks.FilterSQL := '';
end;

end.


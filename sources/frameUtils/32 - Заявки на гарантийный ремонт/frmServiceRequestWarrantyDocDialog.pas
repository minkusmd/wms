unit frmServiceRequestWarrantyDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, DB, IBC,
  MemDS, StdCtrls, cxButtonEdit, cxDBEdit, cxDBLookupComboBox, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, cxCalc, cxCheckBox, cxDropDownEdit, cxCalendar, cxMemo,
  cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, dxCoreGraphics, dxUIAClasses;

type
  TfrmServiceRequestWarrantyDocDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
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
    beCT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    lcbAnalytics: TcxDBLookupComboBox;
    cxLabel3: TLabel;
    Label2: TLabel;
    ceRATE: TcxDBCalcEdit;
    ceRATEUSD: TcxDBCalcEdit;
    beCTSC_NAME: TcxButtonEdit;
    Label3: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    lcbCURRENCY: TcxDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure deDATAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure beCTSC_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
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
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    { Public declarations }
    property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
  end;

implementation

uses
  DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog, DateUtils;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmServiceRequestWarrantyDocDlg.beCTSC_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CTSC').asInteger, False, 0,
      'Выбор плательщика для Заявки на гарантийный ремонт') then
    begin
      fMasterDataSet.FieldByName('CTSC').asInteger := dialog.CustomerID;
      beCTSC_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmServiceRequestWarrantyDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmServiceRequestWarrantyDocDlg.CheckParams: Boolean;
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
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmServiceRequestWarrantyDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmServiceRequestWarrantyDocDlg.BindingDataSource;
begin
  deDATA.DataBinding.DataSource := fMasterDataSource;
  lcbAnalytics.DataBinding.DataSource := fMasterDataSource;
  lcbDTSC.DataBinding.DataSource := fMasterDataSource;
  lcbDTDEP.DataBinding.DataSource := fMasterDataSource;
  cbFLG_ACNT.DataBinding.DataSource := fMasterDataSource;
  IBCQueryDocProps.MasterSource := fMasterDataSource;
  IBCQueryDocProps.Transaction := fMasterDataSet.Transaction;
  IBCQueryDocProps.UpdateTransaction := fMasterDataSet.UpdateTransaction;
end;

function TfrmServiceRequestWarrantyDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmServiceRequestWarrantyDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').asInteger, False, 0,
      'Выбор контрагента для Заявки на гарантийный ремонт') then
    begin
      if dialog.ItemsChanged then
      begin
        dmDB.IBCQueryCustomers.Close;
        dmDB.IBCQueryCustomers.Open;
      end;
      fMasterDataSet.FieldByName('CT').asInteger := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmServiceRequestWarrantyDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmServiceRequestWarrantyDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryStocks.Active := True;

    IBCQueryDocProps.Active := True;

    if fCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;
             // Append
      fMasterDataSet.Append;

      fMasterDataSet.FieldByName('DOCTYPEID').AsInteger := dmDB.CurrentDocTypeID;
      fMasterDataSet.FieldByName('CTSC').AsInteger := 0;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        fMasterDataSet.FieldByName('SC2').AsInteger := -1;
        fMasterDataSet.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //fMasterDataSet.FieldByName('DTSC').AsInteger:=-1;
        fMasterDataSet.FieldByName('CURRENCYID').AsInteger := 498;
        fMasterDataSet.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local defaults
      fMasterDataSet.FieldByName('SUMA').AsCurrency := 0;
      fMasterDataSet.FieldByName('DATA').AsDateTime := NOW;
             //fMasterDataSet.FieldByName('RATE').AsFloat:=dmDB.GetCurrencyExchangeValue(fMasterDataSet.FieldByName('CURRENCYID').AsInteger,fMasterDataSet.FieldByName('FLG_ACNT').AsInteger=1);
      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger
        = 1);

//             deDATA.Properties.MinDate:=NOW-45;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CT').Value);
      beCTSC_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CTSC').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [fMasterDataSet.FieldByName('DOCID').AsInteger]);
             // Edit
      fMasterDataSet.Edit;
//             deDATA.Properties.MinDate:=NOW - 45;
      beDT_NAME.Text := fMasterDataSet.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := fMasterDataSet.FieldByName('CT_NAME').AsString;
      beCTSC_NAME.Text := dmDB.GetCustomerDisplayName(fMasterDataSet.FieldByName('CTSC').Value);

    end;

    dmDB.IBCQueryAnalitica.Active := True;

    dmDB.OpenAnalyticsDataSource;

  except
    if fMasterDataSet.State in dsEditModes then
      fMasterDataSet.Cancel;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    IBCQueryDocProps.Close;
    fMasterDataSet.UpdateTransaction.Rollback;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmServiceRequestWarrantyDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
//        dialog.CustomFilter:=dialog.CustomFilter-[cfFirms];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('CT').asInteger, False, 0,
      'Выбор контрагента для Заявки на гарантийный ремонт') then
    begin
      fMasterDataSet.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(fMasterDataSet.FieldByName('DT').asInteger, False, 0,
      'Выбор организации для Заявки на гарантийный ремонт') then
    begin
      fMasterDataSet.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmServiceRequestWarrantyDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmServiceRequestWarrantyDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmServiceRequestWarrantyDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmServiceRequestWarrantyDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
end;

procedure TfrmServiceRequestWarrantyDocDlg.deDATAPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText:
  TCaption; var Error: Boolean);
var
  InputDate: TDate;
begin
  InputDate := int(Variants.VarToDateTime(DisplayValue));
  if ((InputDate > int(Date)) or (InputDate < (int(date) - 45))) then
  begin
    ErrorText := 'Недопустимый диапазон даты (-45 дней)';
    Error := true;
  end
  else
    Error := false;
end;

end.


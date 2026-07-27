unit frmNareadRazborkaDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs, DialogTitle, DB, IBC,
  StdCtrls, cxButtonEdit, cxDBEdit, cxDBLookupComboBox, ExtCtrls, cxButtons, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess, MemDS, cxCheckBox, cxCalendar, cxMemo, cxDropDownEdit,
  cxCalc, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit, dxCoreGraphics, dxUIAClasses;

type
  TfrmNareaRazborkaDocDlg = class(TSWNCustomForm)
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
    Bevel1: TBevel;
    cxLabel5: TLabel;
    beDT_NAME: TcxButtonEdit;
    beCT_NAME: TcxButtonEdit;
    lcbDTDEP: TcxDBLookupComboBox;
    lcbAnalytics: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    lcbCURRENCY: TcxDBLookupComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
  private
    { Private declarations }
    fCreateNewDocument: Boolean;
    fRealRateValue: double;
    fSECURITY_CanSetupPastDate: Boolean;
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
  DateUtils, DataModuleDB, SWNUtils, SWNConst, frmCustomersDlg, SWNSecurityFlags, SWNCustomersTypesUnit,
  frmDocumentCommentsEditorDialog, SWNSecurity;

{$R *.dfm}

{ TfrmConfigurationDocDlg }

procedure TfrmNareaRazborkaDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmNareaRazborkaDocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

function TfrmNareaRazborkaDocDlg.CheckParams: Boolean;
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
      AddErrorToStr(ErrorStr, 'Склад!');
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

procedure TfrmNareaRazborkaDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmNareaRazborkaDocDlg.IsFormDataPosted: Boolean;
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

procedure TfrmNareaRazborkaDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
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

procedure TfrmNareaRazborkaDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmNareaRazborkaDocDlg.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

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
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local defaults
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
    end
    else
    begin
             // Edit
      dmDB.IBCQueryDocs.Edit;
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
      beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
      beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;
      fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('FLG_ACNT').AsInteger = 1);
    end;

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

procedure TfrmNareaRazborkaDocDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор поставщика для Наряда на зборку')
      then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmNareaRazborkaDocDlg.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0,
      'Выбор организации для Наряда на зборку') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmNareaRazborkaDocDlg.SetCreateNewDocument(const Value: Boolean);
begin
  fCreateNewDocument := Value;
end;

procedure TfrmNareaRazborkaDocDlg.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmNareaRazborkaDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmNareaRazborkaDocDlg.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmNareaRazborkaDocDlg.CloseAdditionalDataSources;
begin
     // close additional datasets
  dmDB.IBCQueryCurrency.Close;
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryStocks.Close;
end;

end.


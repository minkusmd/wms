unit frmZarplataDocDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, DialogTitle, cxGraphics, DB, DBAccess, IBC, MemDS,
  cxCalendar, cxDBEdit, cxMemo, cxCheckBox, cxDropDownEdit, cxCalc, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, ExtCtrls, StdCtrls, cxButtonEdit, Buttons, cxLookAndFeels,
  cxLookAndFeelPainters, dxUIAClasses, dxCoreGraphics;

type
  TfrmZarplataDocDialog = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    btnOk: TButton;
    btnCancel: TButton;
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
    sbShowCurrencyCalc: TSpeedButton;
    ceRATEUSD: TcxDBCalcEdit;
    Label2: TLabel;
    lcbAnalytics: TcxDBLookupComboBox;
    sbRateUsdFromDoc: TSpeedButton;
    cmbCurrency: TcxDBLookupComboBox;
    lcbDTSC: TcxDBLookupComboBox;
    procedure cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
    procedure cbFLGAccPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure sbShowCurrencyCalcClick(Sender: TObject);
    procedure mmDocCOMMENTSClick(Sender: TObject);
    procedure sbRateUsdFromDocClick(Sender: TObject);
  private
    { Private declarations }
    FCreateNewDocument: Boolean;
    fSECURITY_CanSetupPastDate: Boolean;
    FReadOnly: Boolean;
    function GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
    function CheckParams: Boolean;
    procedure SetCreateNewDocument(const Value: Boolean);
    procedure CloseAdditionalDataSources;
    procedure SelectDT;
    procedure SelectCT;
    procedure ShowCurrencyCalc;
    procedure SetReadOnly(const Value: Boolean);
    procedure ShowDocumentCommentsEditorDialog;
    procedure ShowSelectedCustomUSDRateFromDocument;
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
  DateUtils, SWNUtils, SWNTypes, SWNConst, DataModuleDB, DataModuleAdditions,
  frmCustomersDlg, frmBanknoteCounterDialog, SWNSecurityFlags, SWNSecurity,
  SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog,
  frmZarplataSelectCustomUSDRateDlg;

{$R *.dfm}

procedure TfrmZarplataDocDialog.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

procedure TfrmZarplataDocDialog.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectDT;
end;

procedure TfrmZarplataDocDialog.cbFLGAccPropertiesEditValueChanged(Sender: TObject);
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
        dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, flg);
      end;
    end;
  end;
end;

function TfrmZarplataDocDialog.CheckParams: Boolean;
var
  ErrorStr: string;
  S_DT, S_DTSC: string;
  S_CT: string;
begin
  Result := False;

     // specific fields
  case dmDB.CurrentDocTypeID of
    cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_ПКО: // Приходный кассовый ордер
      begin
        S_DT := 'Получатель!';
        S_DTSC := 'Аналитика получателя!';
        S_CT := 'Плательщик!';
        S_DTSC := 'Аналитика плательщика!';
      end;
    cDBID_DocType_КАССОВЫЕ_ОПЕРАЦИИ_РКО,  // Расходный кассовый ордер
      cDBID_DocType_ЗАРПЛАТА_ВЗ:    // Зарплата
      begin
        S_DT := 'Плательщик!';
        S_DTSC := 'Аналитика плательщика!';
        S_CT := 'Получатель!';
        S_DTSC := 'Аналитика получателя!';
      end;
  end;

  if dmDB.IBCQueryDocs.FieldByName('DATA').IsNull then
    AddErrorToStr(ErrorStr, 'Дата документа!');
     {
     else
     begin
          if Not FCreateNewDocument then
          begin
               if Not ((dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger<>dmDB.CurrentUserID) and SWNSecurityManager.LoggedUser.IsInAdminGroup) then
               begin
                    if (DateOf(dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime)<DateOf(NOW)) and (Not fSECURITY_CanSetupPastDate) then AddErrorToStr(ErrorStr,'Дата документа слишком стара!');
               end;
          end;
     end;
     }
  if dmDB.IBCQueryDocs.FieldByName('SC2').IsNull then
    AddErrorToStr(ErrorStr, 'Аналитика документа!');

  if dmDB.IBCQueryDocs.FieldByName('DT').IsNull then
    AddErrorToStr(ErrorStr, S_DT);
  if dmDB.IBCQueryDocs.FieldByName('DTSC').IsNull then
    AddErrorToStr(ErrorStr, S_DTSC);

  if dmDB.IBCQueryDocs.FieldByName('CT').IsNull then
    AddErrorToStr(ErrorStr, S_CT);

     // common fields
  if dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull then
    AddErrorToStr(ErrorStr, 'Валюта!');
  if dmDB.IBCQueryDocs.FieldByName('RATE').IsNull then
    AddErrorToStr(ErrorStr, 'Курс!');
  if dmDB.IBCQueryDocs.FieldByName('SUMA').IsNull {or (dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency<=0)} then
    AddErrorToStr(ErrorStr, 'Сумма!');

  if dmDB.IBCQueryDocs.FieldByName('RATEUSD').IsNull or (dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat < 1) then
    AddErrorToStr(ErrorStr, 'Курс USD документа!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmZarplataDocDialog.cmbCurrencyPropertiesEditValueChanged(Sender: TObject);
begin
  if dmDB.IBCQueryDocs.State in dsEditModes then
  begin
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := GetCurrencySubValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);
  end;
end;

procedure TfrmZarplataDocDialog.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
        //dialog.CustomFilter:=dialog.CustomFilter-[cfCustomers];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0, 'Выбор ' + lbClient.Caption + ' для "' + Caption + '"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
      beCT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmZarplataDocDialog.SelectDT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    dialog.CustomFilter := [cfFirms, cfFranchises];
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').asInteger, False, 0, 'Выбор ' + lbFirma.Caption + ' для "' + Caption + '"') then
    begin
      dmDB.IBCQueryDocs.FieldByName('DT').asInteger := dialog.CustomerID;
      beDT_NAME.Text := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmZarplataDocDialog.SetCreateNewDocument(const Value: Boolean);
begin
  FCreateNewDocument := Value;
end;

procedure TfrmZarplataDocDialog.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmZarplataDocDialog.SetupSecurityItems;
begin
  fSECURITY_CanSetupPastDate := false; //SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := false;

end;

procedure TfrmZarplataDocDialog.ShowCurrencyCalc;
var
  dialog: TfrmBanknoteCounterDlg;
begin
  dialog := TfrmBanknoteCounterDlg.Create(Self);
  try
    if dialog.ShowModal = mrOk then
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := dialog.TotalSum;
  finally
    dialog.Free;
  end;
end;

procedure TfrmZarplataDocDialog.ShowDocumentCommentsEditorDialog;
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

procedure TfrmZarplataDocDialog.ShowSelectedCustomUSDRateFromDocument;
var
  dialog: TfrmZarplataSelectCustomUsdRateDialog;
begin
  dialog := TfrmZarplataSelectCustomUsdRateDialog.Create(Self);
  try
    if dialog.ShowModal = mrOk then
    begin
      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dialog.CustomUSDRate;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmZarplataDocDialog.WhenCancelForm;
begin
  if IBCQueryDocProps.State in dsEditModes then
    IBCQueryDocProps.Cancel;
  dmDB.IBCQueryDocs.Cancel;
  dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure TfrmZarplataDocDialog.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmZarplataDocDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

procedure TfrmZarplataDocDialog.FormCreate(Sender: TObject);
begin
  FCreateNewDocument := False;
  FReadOnly := False;
end;

function TfrmZarplataDocDialog.GetCurrencySubValue(const CurrencyID: integer; const ThroughAccount: Boolean): Double;
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

function TfrmZarplataDocDialog.IsFormDataPosted: Boolean;
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

procedure TfrmZarplataDocDialog.mmDocCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmZarplataDocDialog.Prepare;
var
  DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
  SetupSecurityItems;

  dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
        // open data
    dmDB.IBCQueryCurrency.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;
    dmDB.OpenAnalyticsDataSource;
    dmDB.OpenAnalyticsDataSource;

    IBCQueryDocProps.Active := True;

    if FCreateNewDocument then
    begin
      dtDialogTitle.Text := cMSG_DIALOG_DOCUMENT_New;

      dmDB.IBCQueryDocs.Append;

             // system defaults
      if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs, DocumentAdditionalFlags) then
      begin
        dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;
        dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                  //dmDB.IBCQueryDocs.FieldByName('DTSC').AsInteger:=-1;
        dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 0;
      end;

             // local default
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsInteger := 0;
      dmDB.IBCQueryDocs.FieldByName('RATE').AsInteger := 1;
      dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;

      dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840, dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1);

      beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
      beCT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('CT').Value);

      cbFLG_ACNT.Enabled := not (dafFLG_ACNT_DISABLED in DocumentAdditionalFlags);
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

                  // Nu se poate de schimbat FLG_ACNT daca documentul este mostenit. Except Administrator
        if UserHasUserGroup(1) then
        begin
          if dmDB.IBCQueryDocs.FieldByName('CREATED_BY').AsInteger <> dmDB.CurrentUserID then
          begin
            edSuma.Enabled := False;
            sbShowCurrencyCalc.Enabled := False;
          end;
        end
        else
        begin
          if dmDB.IBCQueryDocs.FieldByName('PARENTDOCID').AsInteger <> -1 then
            cbFLG_ACNT.Enabled := False;
        end;

                  // Daca este prin contabilitatea, atunci numai MDL
        if dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1 then
        begin
          cmbCurrency.Enabled := False;
          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 498;
        end;
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

procedure TfrmZarplataDocDialog.sbRateUsdFromDocClick(Sender: TObject);
begin
  ShowSelectedCustomUSDRateFromDocument;
end;

procedure TfrmZarplataDocDialog.sbShowCurrencyCalcClick(Sender: TObject);
begin
  ShowCurrencyCalc;
end;

end.


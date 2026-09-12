unit frmScetNaOplatuDocDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, DB, IBC, StdCtrls, cxDBEdit,

  cxDBLookupComboBox, ExtCtrls, cxButtonEdit,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, DBAccess,
  MemDS, cxCalc, cxCurrencyEdit, cxCheckBox, cxDropDownEdit, cxCalendar, cxMemo, cxTextEdit, cxMaskEdit, cxLookupEdit,
  cxDBLookupEdit, dxUIAClasses, dxCoreGraphics;

type
  TfrmScetNaOplatuDocDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxLabel1: TLabel;
    cxLabel2: TLabel;
    cxLabel3: TLabel;
    lcbDTSC: TcxDBLookupComboBox;
    mmCOMMENTS: TcxDBMemo;
    cxLabel8: TLabel;
    cxLabel5: TLabel;
    deDATA: TcxDBDateEdit;
    IBCQueryDocProps: TIBCQuery;
    IBCDataSourceDocProps: TIBCDataSource;
    cbFLG_ACNT: TcxDBCheckBox;
    cxLabel6: TLabel;
    cxLabel11: TLabel;
    lcbDT_CD: TcxDBLookupComboBox;
    cxLabel10: TLabel;
    lcbCT_CD: TcxDBLookupComboBox;
    cxLabel13: TLabel;
    IBCDataSourceRechizite: TIBCDataSource;
    IBCQueryRechizite: TIBCQuery;
    edDT_NAME: TcxDBTextEdit;
    edDTDEP_NAME: TcxDBTextEdit;
    edRATE: TcxDBTextEdit;
    IBCDataSourceDT_Accounts: TIBCDataSource;
    IBCQueryDT_Accounts: TIBCQuery;
    IBCDataSourceCT_Accounts: TIBCDataSource;
    IBCQueryCT_Accounts: TIBCQuery;
    cxLabel12: TLabel;
    edSUMA: TcxDBCurrencyEdit;
    Bevel1: TBevel;
    beCT_NAME: TcxButtonEdit;
    Label1: TLabel;
    ceRATEUSD: TcxDBCalcEdit;
    lcbAnalytics: TcxDBLookupComboBox;
    lbContractTitle: TLabel;
    beContract: TcxButtonEdit;
    lbContractInfo: TLabel;
    lcbCURRENCY: TcxDBLookupComboBox;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
    procedure lcbCTButtonClick(Sender: TObject);
    procedure lcbDT_AccountPropertiesInitPopup(Sender: TObject);
    procedure lcbCT_AccountPropertiesInitPopup(Sender: TObject);
    procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure mmCOMMENTSClick(Sender: TObject);
    procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  private
    { Private declarations }
    fSECURITY_ALLOW_CONTRACT: Boolean;
    fRealRateValue: double;
    fLastCurrencyID: Integer;
    FReadOnly: Boolean;

    function CheckParams: Boolean;
    procedure CloseAdditionalDataSources;

    procedure SelectCT;

    procedure ShowDocumentCommentsEditorDialog;
    procedure SetReadOnly(const Value: Boolean);

    procedure ShowSelectContractDialog;
    procedure LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
  protected
    { protected declarations }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses DateUtils, DataModuleDB, SWNUtils, SWNConst,
  frmCustomersDlg, SWNSecurityFlags, frmDocumentCommentsEditorDialog, SWNSecurity,
  frmCustomerContractsDialog;

{$R *.dfm}
{ TfrmConfigurationDocDlg }

procedure TfrmScetNaOplatuDocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
     ShowSelectContractDialog;
end;

procedure TfrmScetNaOplatuDocDlg.ShowSelectContractDialog;
var contractInfo:TCustomerDefultContractInfo;
begin
     contractInfo:=SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger);
     if Assigned(contractInfo) then
     begin
          beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle, contractInfo.Code, FormatDateTime('dd MMMM yyyy', contractInfo.SignDate)]);
          dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
          lbContractInfo.Visible := True;
          if contractInfo.FLG_ACNT then dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
     end;
end;

procedure TfrmScetNaOplatuDocDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  SelectCT;
end;

function TfrmScetNaOplatuDocDlg.CheckParams: Boolean;
var
  ErrorStr: String;
begin
  Result := False;
  ErrorStr := '';

  with dmDB.IBCQueryDocs do
  begin
    if FieldByName('DATA').IsNull then
      AddErrorToStr(ErrorStr, 'Data documentului!');
    {
      else
      begin
      if (DateOf(FieldByName('DATA').AsDateTime)<DateOf(NOW)) and (Not fSECURITY_CanSetupPastDate) then AddErrorToStr(ErrorStr,'Data documentului este prea veche!');
      end;
    }

    if FieldByName('SC2').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica documentului!');

    if IBCQueryRechizite.FieldByName('DT_CD').IsNull then
      AddErrorToStr(ErrorStr, 'Datele organizatiei!');
    if FieldByName('DTSC').IsNull then
      AddErrorToStr(ErrorStr, 'Analitica organizatiei!');

    // if IBCQueryRechizite.FieldByName('CT_CD').IsNull then AddErrorToStr(ErrorStr,'Datele platitorului!');

    if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
      AddErrorToStr(ErrorStr, 'Cursul USD al documentului!')
  end;

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure TfrmScetNaOplatuDocDlg.CloseAdditionalDataSources;
begin
  dmDB.IBCQueryAnalitica.Close;
  dmDB.IBCQueryAnalytics.Close;
  dmDB.IBCQueryCurrency.Close;
end;

procedure TfrmScetNaOplatuDocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseAdditionalDataSources;
end;

function TfrmScetNaOplatuDocDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    dmDB.IBCQueryDocs.Post;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Post;
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Post;
    dmDB.IBCQueryDocs.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmScetNaOplatuDocDlg.lcbCTButtonClick(Sender: TObject);
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,
      'Selectare beneficiar pentru factura de plata') then
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

procedure TfrmScetNaOplatuDocDlg.lcbCT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryCT_Accounts.Close;
  IBCQueryCT_Accounts.Open;
end;

procedure TfrmScetNaOplatuDocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
  currID: Integer;
  acnt: Boolean;
  Suma: Currency;
begin
  if (dmDB.IBCQueryDocs.State in dsEditModes) and (Not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull)
  then
  begin
    currID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger;
    acnt := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').asInteger = 1;
    fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := fRealRateValue;
    // change doc suma
    if dmDB.TransformCurrency1(dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat, fLastCurrencyID, currID, acnt,
      Suma, fRealRateValue, False, False) then
    begin
      dmDB.IBCQueryDocs.FieldByName('SUMA').AsFloat := Suma;
    end;
    dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := fRealRateValue;
    fLastCurrencyID := currID;
  end;
end;

procedure TfrmScetNaOplatuDocDlg.lcbDT_AccountPropertiesInitPopup(Sender: TObject);
begin
  IBCQueryDT_Accounts.Close;
  IBCQueryDT_Accounts.Open;
end;

procedure TfrmScetNaOplatuDocDlg.LoadDefaultContract(const CustomerID: Integer; const DocDate: TDateTime);
var contractInfo:TCustomerDefultContractInfo;
begin
     contractInfo:=LoadCustomerDefaultContractInfo(dmDB.IBCQueryDocs.fieldbyname('dt').Asinteger, CustomerID,DocDate);
     if Assigned(contractInfo) then
     begin
          beContract.Text := Format('%s (nr.%s din %s)', [contractInfo.ContractTypeTitle,contractInfo.Code,FormatDateTime('dd MMMM yyyy',contractInfo.SignDate)]);
          dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
//          dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
          if contractInfo.FLG_ACNT then
          begin
               dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
          end;
          lbContractInfo.Visible := True;

          contractInfo.Free;
     end
     else
     begin
          dmDB.IBCQueryDocs.FieldByName('CONTRACTID').Value := Null;
          beContract.Text := '';
          cbFLG_ACNT.Enabled := True;
     end;
end;

procedure TfrmScetNaOplatuDocDlg.mmCOMMENTSClick(Sender: TObject);
begin
  ShowDocumentCommentsEditorDialog;
end;

procedure TfrmScetNaOplatuDocDlg.Prepare;
begin
  SetupSecurityItems;

  if Not FReadOnly then
    dmDB.IBCQueryDocs.UpdateTransaction.StartTransaction;
  try
    IBCQueryRechizite.Active := True;
    dmDB.IBCQueryCurrency.Active := True;

    if FReadOnly then
    begin
      // view only
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_ViewOnly,
        [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]);
      dtDialogTitle.Color := cCOLOR_DocReadOnly;

      btnOk.Visible := False;
      btnCancel.Caption := cMSG_ButtonClose;
      pnClient.Enabled := False;
    end
    else
    begin
      // Edit
      dmDB.IBCQueryDocs.Edit;
      dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit,
        [dmDB.IBCQueryDocs.FieldByName('DOCID').asInteger]);
    end;

    fLastCurrencyID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').asInteger;
    beCT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('CT_NAME').AsString;

    IBCQueryDT_Accounts.Active := True;
    IBCQueryCT_Accounts.Active := True;
    dmDB.IBCQueryAnalitica.Active := True;

    IBCQueryDocProps.Active := True;

    dmDB.OpenAnalyticsDataSource;

             if Not dmDB.IBCQueryDocs.FieldByName('CONTRACTID').IsNull then
             begin
                  beContract.Text := Format('%s (nr.%s din %s)',
                                       [dmDB.IBCQueryDocs.FieldByName('CONTRACT_TYPE_TITLE').AsString,
                                        dmDB.IBCQueryDocs.FieldByName('CONTRACT_CODE').AsString, FormatDateTime('dd MMMMM yyyy',
                                        dmDB.IBCQueryDocs.FieldByName('CONTRACT_SIGN_DATE').AsDateTime)
                                       ]);
                  // ??? daca cumva acest document are contract, aratam info fortat
                  if Not fSECURITY_ALLOW_CONTRACT then
                  begin
                       lbContractTitle.Visible:=True;
                       beContract.Visible:=True;
                  end;
             end;

  except
    if Not FReadOnly then
    begin
      if dmDB.IBCQueryDocs.State in dsEditModes then
        dmDB.IBCQueryDocs.Cancel;
      dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
    end;

    CloseAdditionalDataSources;

    raise;
  end;
end;

procedure TfrmScetNaOplatuDocDlg.SelectCT;
var dialog: TfrmCustomersDlg;
begin
     dialog := TfrmCustomersDlg.Create(Self);
     try
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').asInteger, False, 0,'Selectare furnizor pentru factura de plata') then
        begin
             dmDB.IBCQueryDocs.FieldByName('CT').asInteger := dialog.CustomerID;
             beCT_NAME.Text := dialog.CustomerTitle;
             if fSECURITY_ALLOW_CONTRACT then LoadDefaultContract(dialog.CustomerID, dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime);
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmScetNaOplatuDocDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmScetNaOplatuDocDlg.SetupSecurityItems;
// var b:Boolean;
begin
  {
    if Not fReadOnly then
    begin
    // Se pot edita cele vechi ?
    if (DateOf(dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime)<DateOf(NOW)) then
    begin
    b:=SecurityFlagEnabled(cSecurityFlag_СЧЕТА_СНО_Редактировать_старые);

    deDATA.Enabled:=b;
    lcbAnalytics.Enabled:=b;
    edDT_NAME.Enabled:=b;
    lcbDTSC.Enabled:=b;
    lcbDT_CD.Enabled:=b;
    edDTDEP_NAME.Enabled:=b;
    beCT_NAME.Enabled:=SecurityFlagEnabled(cSecurityFlag_СЧЕТА_СНО_Изменить_плательщика);
    lcbCT_CD.Enabled:=beCT_NAME.Enabled;
    lcbCURRENCY.Enabled:=b;
    ceRATEUSD.Enabled:=b;
    edINBAZA.Enabled:=b;
    end;

    end;
  }
  if SWNSecurityManager.IsPartialAccessMode then
    cbFLG_ACNT.Visible := False;

     // Contract
     fSECURITY_ALLOW_CONTRACT:=SecurityFlagEnabled(cSecurityFlag_СЧЕТА_СНО_Показывать_Контракт);
     if Not fSECURITY_ALLOW_CONTRACT then
     begin
          lbContractTitle.Visible:=False;
          beContract.Visible:=False;
          lbContractInfo.Visible:=False;
          beContract.Properties.Buttons.Clear;
     end;
     if Not SecurityFlagEnabled(cSecurityFlag_Справочники_Клиенты_Контракты_Администрирование) then beContract.Properties.Buttons.Clear;


end;

procedure TfrmScetNaOplatuDocDlg.ShowDocumentCommentsEditorDialog;
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

procedure TfrmScetNaOplatuDocDlg.WhenCancelForm;
begin
  if Not FReadOnly then
  begin
    if IBCQueryDocProps.State in dsEditModes then
      IBCQueryDocProps.Cancel;
    if IBCQueryRechizite.State in dsEditModes then
      IBCQueryRechizite.Cancel;
    dmDB.IBCQueryDocs.Cancel;
    dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
  end;
end;

end.

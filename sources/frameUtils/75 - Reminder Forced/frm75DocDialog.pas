unit frm75DocDialog;
{
  FACTURI - Facturi de intrare
  > Forma de editare a documentului
}

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
    DialogTitle, cxGraphics, cxCalendar, cxDBEdit, cxMemo, cxDropDownEdit, cxCalc, cxTextEdit,
    cxMaskEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxControls, cxContainer, cxEdit,
    cxLabel, ExtCtrls, Menus, StdCtrls, cxButtons, DB, DBAccess, IBC, MemDS, cxCheckBox,
    cxButtonEdit, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGrid, dxUIAClasses, dxCoreGraphics;

type
    Tfrm75DocDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        pnClient: TPanel;
        cxLabel1: TLabel;
        deDATA: TcxDBDateEdit;
        btnOk: TButton;
        btnCancel: TButton;
        cxLabel5: TLabel;
        Bevel1: TBevel;
        beDT_NAME: TcxButtonEdit;
        cxLabel8: TLabel;
        mmCOMMENTS: TcxDBMemo;
        lcbAnalytics: TcxDBLookupComboBox;
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
        procedure lcbCTButtonClick(Sender: TObject);
        procedure beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure mmCOMMENTSClick(Sender: TObject);
        procedure beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    private { Private declarations }
        fCreateNewDocument: Boolean;
        fRealRateValue: double;
        fSECURITY_CanSetupPastDate: Boolean;
        fSECURITY_ALLOW_CONTRACT: Boolean;
        procedure SetCreateNewDocument(const Value: Boolean);
        function CheckParams: Boolean;
        procedure CloseAdditionalDataSources;
        procedure SelectDT;
        procedure ShowDocumentCommentsEditorDialog;
    protected { protected declarations }
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
        procedure SetupSecurityItems; override;
    public { Public declarations }
        property CreateNewDocument: Boolean read fCreateNewDocument write SetCreateNewDocument;
    end;

implementation

uses
    DateUtils, DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, frmCustomersDlg,
    SWNValueStorageUnit, SWNSecurityFlags, SWNCustomersTypesUnit, frmDocumentCommentsEditorDialog,
    Math, SWNSecurity, frmCustomerContractsDialog;

{$R *.dfm}
{ TfrmConfigurationDocDlg }

procedure Tfrm75DocDlg.beContractPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    contractInfo: TCustomerDefultContractInfo;
begin
    contractInfo := SelectCustomerContract(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, dmDB.IBCQueryDocs.FieldByName
        ('CONTRACTID').AsInteger);
    if Assigned(contractInfo) then
    begin
        dmDB.IBCQueryDocs.FieldByName('CONTRACTID').AsInteger := contractInfo.ContractID;
        // dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := contractInfo.CurrencyID;
        if contractInfo.FLG_ACNT then
            dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
    end;
end;

procedure Tfrm75DocDlg.beDT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
    SelectDT;
end;

function Tfrm75DocDlg.CheckParams: Boolean;
var
    ErrorStr: string;
begin
    Result := False;
    ErrorStr := '';

    with dmDB.IBCQueryDocs do
    begin
        if FieldByName('DATA').IsNull then
            AddErrorToStr(ErrorStr, 'Data document!')
        else
        begin
            if (DateOf(FieldByName('DATA').AsDateTime) < DateOf(NOW)) and (not
                fSECURITY_CanSetupPastDate) then
                AddErrorToStr(ErrorStr, 'Data este prea veche!');
        end;

        if FieldByName('SC2').IsNull then
            AddErrorToStr(ErrorStr, 'Analitica!');

        if FieldByName('DT').IsNull or (FieldByName('DT').AsInteger = -1) then
            AddErrorToStr(ErrorStr, 'Organizatia!');

//        if FieldByName('CT').IsNull or (FieldByName('CT').AsInteger = -1) then
//            AddErrorToStr(ErrorStr, 'Furnizor!');

        if FieldByName('CURRENCYID').IsNull then
            AddErrorToStr(ErrorStr, 'Valuta!');
        if FieldByName('RATE').IsNull or (FieldByName('RATE').AsFloat < 1) then
            AddErrorToStr(ErrorStr, 'Rata documentului!');

        if FieldByName('RATEUSD').IsNull or (FieldByName('RATEUSD').AsFloat < 1) then
            AddErrorToStr(ErrorStr, 'Rata USD!')
    end;

    if ErrorStr = '' then
        Result := True
    else
        ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

procedure Tfrm75DocDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    CloseAdditionalDataSources;
end;

function Tfrm75DocDlg.IsFormDataPosted: Boolean;
begin
    if CheckParams then
    begin
        try
            dmDB.IBCQueryDocs.Post;
            dmDB.IBCQueryDocs.UpdateTransaction.Commit;

            Result := True;
        except on e: Exception do
            begin
                Result := False;
                raise;
            end;
        end;
    end
    else
        Result := False;
end;

procedure Tfrm75DocDlg.lcbCTButtonClick(Sender: TObject);
var
    dialog: TfrmCustomersDlg;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('CT').AsInteger, False, 0,
            'Alege Furnizor') then
        begin
            if dialog.ItemsChanged then
            begin
                dmDB.IBCQueryCustomers.Close;
                dmDB.IBCQueryCustomers.Open;
            end;
            dmDB.IBCQueryDocs.FieldByName('CT').AsInteger := dialog.CustomerID;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tfrm75DocDlg.lcbCURRENCYPropertiesEditValueChanged(Sender: TObject);
var
    currID: Integer;
    acnt: Boolean;
begin
    if (dmDB.IBCQueryDocs.State in dsEditModes) and (not dmDB.IBCQueryDocs.FieldByName('CURRENCYID').IsNull)
        then
    begin
        currID := dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger;
        acnt := dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1;
        fRealRateValue := dmDB.GetCurrencyExchangeValue(currID, acnt);
        dmDB.IBCQueryDocs.FieldByName('RATE').AsFloat := fRealRateValue;
    end;
end;

procedure Tfrm75DocDlg.mmCOMMENTSClick(Sender: TObject);
begin
    ShowDocumentCommentsEditorDialog;
end;

procedure Tfrm75DocDlg.Prepare;
var
    DocumentAdditionalFlags: TDocumentAdditionalFlags;
begin
    SetupSecurityItems;

    ActiveControl := beDT_NAME;

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
            dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger := 496;
            dmdb.IBCQueryDocs.FieldByName('Rate').AsFloat := 1;
            dmDB.IBCQueryDocs.FieldByName('ct').AsInteger := -1;
            // defaults
            if not dmDB.LoadDocumentDefaults(dmDB.CurrentDocTypeID, dmDB.CurrentFirma, dmDB.IBCQueryDocs,
                DocumentAdditionalFlags) then
            begin
                dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dmDB.CurrentFirma;
                dmDB.IBCQueryDocs.FieldByName('SC2').AsInteger := -1;

                dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger := 1;
            end;

            dmDB.IBCQueryDocs.FieldByName('RATEUSD').AsFloat := dmDB.GetCurrencyExchangeValue(840,
                dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);

            dmDB.IBCQueryDocs.FieldByName('DATA').AsDateTime := NOW;
            dmDB.IBCQueryDocs.FieldByName('SUMA').AsCurrency := 0;

            beDT_NAME.Text := dmDB.GetCustomerDisplayName(dmDB.IBCQueryDocs.FieldByName('DT').Value);
        end
        else
        begin
            dtDialogTitle.Text := Format(cMSG_DIALOG_DOCUMENT_Edit, [dmDB.IBCQueryDocs.FieldByName('DOCID').AsInteger]);
            // Edit
            dmDB.IBCQueryDocs.Edit;
            beDT_NAME.Text := dmDB.IBCQueryDocs.FieldByName('DT_NAME').AsString;
            fRealRateValue := dmDB.GetCurrencyExchangeValue(dmDB.IBCQueryDocs.FieldByName('CURRENCYID').AsInteger,
                dmDB.IBCQueryDocs.FieldByName('FLG_ACNT').AsInteger = 1, True);
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

procedure Tfrm75DocDlg.SelectDT;
var
    dialog: TfrmCustomersDlg;
begin
    dialog := TfrmCustomersDlg.Create(Self);
    try
        dialog.CustomFilter := [cfFirms, cfFranchises, cfSecuredFirms];
        if dialog.SelectCustomer(dmDB.IBCQueryDocs.FieldByName('DT').AsInteger, False, 0,
            'Alege organizatia') then
        begin
            dmDB.IBCQueryDocs.FieldByName('DT').AsInteger := dialog.CustomerID;
            beDT_NAME.Text := dialog.CustomerTitle;
        end;
    finally
        dialog.Free;
    end;
end;

procedure Tfrm75DocDlg.SetCreateNewDocument(const Value: Boolean);
begin
    fCreateNewDocument := Value;
end;

procedure Tfrm75DocDlg.SetupSecurityItems;
begin
    fSECURITY_CanSetupPastDate := SecurityFlagEnabled(cSecurityFlag_Можно_выставлят_обратную_дату);

    fSECURITY_ALLOW_CONTRACT := SecurityFlagEnabled(cSecurityFlag_НАКЛАДНЫЕ_РНОУ_Показывать_Контракт);
end;

procedure Tfrm75DocDlg.ShowDocumentCommentsEditorDialog;
begin
end;

procedure Tfrm75DocDlg.WhenCancelForm;
begin
    if dmdb.IBCQueryDocs.State in dsEditModes then
        dmDB.IBCQueryDocs.Cancel;
    if dmdb.IBCQueryDocs.UpdateTransaction.Active then
        dmDB.IBCQueryDocs.UpdateTransaction.Rollback;
end;

procedure Tfrm75DocDlg.CloseAdditionalDataSources;
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


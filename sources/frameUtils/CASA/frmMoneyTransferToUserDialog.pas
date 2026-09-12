unit frmMoneyTransferToUserDialog;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
    cxDBLookupComboBox, cxTextEdit, DB, DBAccess, IBC, StdCtrls, frameMoneyCounterUnit, ExtCtrls,
    Buttons, cxMemo, dxPSCore, cxButtons, dxPScxGridLnk, cxCheckBox, cxGroupBox, cxButtonEdit,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
    dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
    dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
    dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLayoutViewLnk,
    dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, cxClasses, MemDS, cxMaskEdit,
    cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, dxUIAClasses, dxCoreGraphics;

type
    TipIncasare = (tiFizic, tiLivrare);

    TfrmMoneyTransferToUserDlg = class(TSWNCustomForm)
        pnClient: TPanel;
        cxLabel1: TLabel;
        cxLabel2: TLabel;
        frameMoneyCounter: TframeMoneyCounter;
        cmbCURRENCY: TcxLookupComboBox;
        IBCQueryUsers: TIBCQuery;
        IBCDataSourceUsers: TIBCDataSource;
        edSuma: TEdit;
        cbFLG_ACNT: TCheckBox;
        Label4: TLabel;
        sbOpenCalc: TSpeedButton;
        IBCQueryFirme: TIBCQuery;
        IBCDataSourceFirme: TIBCDataSource;
        Label5: TLabel;
        mmComments: TcxMemo;
        cxButton1: TcxButton;
        dxComponentPrinter1: TdxComponentPrinter;
        dxComponentPrinter1Link1: TdxGridReportLink;
        cxGroupBox1: TcxGroupBox;
        Label1: TLabel;
        edUserName: TcxTextEdit;
        edFirmaName: TcxTextEdit;
        Label2: TLabel;
        cxGroupBox2: TcxGroupBox;
        Label6: TLabel;
        cmbUserName: TcxLookupComboBox;
        clbFirme: TcxLookupComboBox;
        Label3: TLabel;
        cbLivrare: TcxCheckBox;
        beTRANSFERAT_PRIN: TcxButtonEdit;
        Label7: TLabel;
        btnCancel: TcxButton;
        btnOk: TcxButton;
        teForDocument: TcxTextEdit;
        Label8: TLabel;
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure btnOkClick(Sender: TObject);
        procedure cmbUserNamePropertiesEditValueChanged(Sender: TObject);
        procedure sbOpenCalcClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure cxButton1Click(Sender: TObject);
        procedure beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure cbLivrarePropertiesEditValueChanged(Sender: TObject);
    private
        FFLG_ACNT: boolean;
        FFLG_LIVRARE: Boolean;
        FShowCurrentUser: Boolean;
    { Private declarations }
        FTargetCurrencyID: integer;
        FTargetFirmaID: integer;
        FTargetUserID: integer;
        FSourceDT: integer;
        fTipIncasare: TipIncasare;
//    FSourceUserID: integer;
        procedure WhenBanknotesCounterSumaChanged(Sender: TObject);
        function getCurrencyID: integer;
        function getSUMA: Currency;
        procedure SetAllowChangeCurrency(const Value: Boolean);
        procedure SetShowBanknotesCounter(const Value: Boolean);
        procedure SetSUMA(const Value: Currency);
        function CheckParams: Boolean;
        function CheckTargetCredentials(const UserID: integer): Boolean;
        function DoMoneyTransferDB: Boolean;
        procedure SetFLG_ACNT(const Value: boolean);
        procedure SetFLG_LIVRARE(const Value: Boolean);
        procedure SetShowCurrentUser(const Value: Boolean);
        procedure SetTargetCurrencyID(const Value: integer);
        procedure SetTargetFirmaID(const Value: integer);
        procedure SetTargetUserID(const Value: integer);
        procedure SetSourceDT(const Value: integer);
    protected    { protected declarations }
        procedure Prepare; override;
    public    { Public declarations }
        procedure SetCustomTitle(const ACaption, ADescription: string);
    // in
        property AllowChangeCurrency: Boolean write SetAllowChangeCurrency;
        property ShowBanknotesCounter: Boolean write SetShowBanknotesCounter;

    // in/out
        property SUMA: Currency read getSUMA write SetSUMA;
    // out
        property CurrencyID: integer read getCurrencyID;
        property ShowCurrentUser: Boolean read FShowCurrentUser write SetShowCurrentUser;

    // defaults
        property TargetUserID: integer read FTargetUserID write SetTargetUserID;
        property TargetFirmaID: integer read FTargetFirmaID write SetTargetFirmaID;
        property TargetCurrencyID: integer read FTargetCurrencyID write SetTargetCurrencyID;
        property SourceDT: integer read FSourceDT write SetSourceDT;

        constructor Create(AOwner: TComponent); override;
    published
        property FLG_ACNT: boolean read FFLG_ACNT write SetFLG_ACNT;
        property FLG_LIVRARE: Boolean read FFLG_LIVRARE write SetFLG_LIVRARE;
    end;

implementation

uses
    DataModuleDB, SWNUtils, frmPasswordDlg, SWNSecurity, SWNDBErrors, frmCustomersDlg;

{$R *.dfm}

{ TForm1 }

procedure TfrmMoneyTransferToUserDlg.beCT_NAMEPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
    dialog: TfrmCustomersDlg;
    q: TIBCQuery;
begin
    case AButtonIndex of
        0:
            begin
                dialog := TfrmCustomersDlg.Create(Self);
                try
                    if dialog.SelectCustomer(beTRANSFERAT_PRIN.Tag, False, 0,
                        'Alege prin cine a fost transmisa suma de bani') then
                    begin
                        beTRANSFERAT_PRIN.Tag := dialog.CustomerID;
                        beTRANSFERAT_PRIN.Text := dialog.CustomerTitle;
                    end;
                finally
                    dialog.Free;
                end;
            end;

        1:
            begin
                q := TIBCQuery.Create(Self);
                try
                    q.SQL.Text := 'SELECT CUSTOMERID FROM TS_USERS WHERE USERID = :USERID';
                    q.ParamByName('USERID').asInteger := dmDB.CurrentUserID;
                    q.Open;
                    if q.RecordCount>0 then begin
                      beTRANSFERAT_PRIN.Tag := q.FieldByName('CUSTOMERID').AsInteger;
                      beTRANSFERAT_PRIN.Text := dmDB.CurrentUserFullName;
                    end;
                    q.Close;
                finally
                    q.Free;
                end;
            end;

        2:
            begin
                beTRANSFERAT_PRIN.Tag := 278123;
                beTRANSFERAT_PRIN.Text := 'CIUNTU VSEVOLOD';
            end;

        3:
            begin
                dialog := TfrmCustomersDlg.Create(Self);
                try
                    if dialog.SelectCustomer(beTRANSFERAT_PRIN.Tag, False, 0,
                        'Alege prin cine a fost transmisa suma de bani') then
                    begin
                        beTRANSFERAT_PRIN.Tag := dialog.CustomerID;
                        beTRANSFERAT_PRIN.Text := dialog.CustomerTitle;
                    end;
                finally
                    dialog.Free;
                end;
            end;
    end;
end;

procedure TfrmMoneyTransferToUserDlg.btnOkClick(Sender: TObject);
var
    S: string;
    tmpSuma: Currency;
begin
    if CheckParams then
    begin
        tmpSuma := StrToCurr(edSuma.Text);
        S := Format('Doriti sa transferati %f %s pentru %s?', [tmpSuma, cmbCURRENCY.Text, cmbUserName.Text]);

        if ShowAskDialog('Transfer mijloace financiare', S + #13#10 + #13#10 +
            'Pentru a continua este nevoie de parola d-voatra.') = mrYes then
        begin
            if CheckTargetCredentials(dmDB.CurrentUserID) then
            begin
                if DoMoneyTransferDB then
                    ModalResult := mrOk;
            end
            else
                ShowErrorDialog('Parola gresita', 'Parola introdusa este gresita!');
        end;
    end;
end;

procedure TfrmMoneyTransferToUserDlg.cbLivrarePropertiesEditValueChanged(Sender: TObject);
begin
    Label8.Visible := cbLivrare.Checked;
    teForDocument.Visible := cbLivrare.Checked;
    if cbLivrare.Checked then
        teForDocument.SetFocus;
end;

function TfrmMoneyTransferToUserDlg.CheckParams: Boolean;
var
    ErrorStr: string;
    tmpSuma: Currency;
begin
    Result := False;
    ErrorStr := '';

    if VarIsNull(cmbUserName.EditValue) or (cmbUserName.EditValue <= 0) then
        AddErrorToStr(ErrorStr, 'Indicati beneficiarul!');

    if VarIsNull(clbFirme.EditValue) or (clbFirme.EditValue <= 0) then
        AddErrorToStr(ErrorStr, 'Indicati subdiviziunea beneficiarului!');

    if VarIsNull(cmbCURRENCY.EditValue) or (cmbCURRENCY.EditValue <= 0) then
        AddErrorToStr(ErrorStr, 'Indicati valuta!');

    if beTRANSFERAT_PRIN.Tag <= 0 then
        AddErrorToStr(ErrorStr, 'Indicati prin cine a fost transferat suma!');

    if Trim(edSuma.Text) = '' then
        AddErrorToStr(ErrorStr, 'Indicati suma!')
    else
    begin
        tmpSuma := StrToCurrDef(edSuma.Text, 0);
        if (tmpSuma < 1) then
            AddErrorToStr(ErrorStr, 'Indicati suma!');
    end;

    if (ErrorStr = '') then
        Result := True
    else
        ShowErrorDialog('Eroare generata', ErrorStr);
end;

function TfrmMoneyTransferToUserDlg.CheckTargetCredentials(const UserID: integer): Boolean;
var
    dialog: TfrmPasswordDialog;
begin
    Result := False;
    dialog := TfrmPasswordDialog.Create(Self, pdmAskPassword);
    try
        if dialog.ShowModal = mrOk then
            Result := SWNSecurityManager.TestUserPassword(UserID, dialog.Password);
    finally
        dialog.Free;
    end;
end;

procedure TfrmMoneyTransferToUserDlg.cmbUserNamePropertiesEditValueChanged(Sender: TObject);
var
    N: integer;
begin
    IBCQueryFirme.Close;
    if VarIsNull(cmbUserName.EditValue) then
    begin
        clbFirme.EditValue := null;
    end
    else
    begin
        IBCQueryFirme.ParamByName('USERID').AsInteger := cmbUserName.EditValue;
        IBCQueryFirme.Open;
        if TargetFirmaID <> -1 then
            N := TargetFirmaID
        else
            N := dmDB.CurrentFirma;
        if IBCQueryFirme.Locate('CUSTOMERID', N, []) then
            clbFirme.EditValue := N
        else
            clbFirme.EditValue := null;
    end;
end;

constructor TfrmMoneyTransferToUserDlg.Create(AOwner: TComponent);
begin
    inherited;
    FLG_ACNT := True;
    FLG_LIVRARE := False;
    FShowCurrentUser := False;
end;

procedure TfrmMoneyTransferToUserDlg.cxButton1Click(Sender: TObject);
begin
    dxComponentPrinter1Link1.Preview;
end;

function TfrmMoneyTransferToUserDlg.DoMoneyTransferDB: Boolean;
var
    Query: TIBCQuery;
begin
    Result := False;
    Query := TIBCQuery.Create(Self);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;
        Query.Transaction.StartTransaction;
        try
            Query.SQL.Text :=
                'INSERT INTO VW_TDB_CASH_JURNAL (FLG_DT_CONFIRMED, FLG_CT_CONFIRMED, FLG_LIVRARE, DT, CURRENCYID_DT, USER_DT, SUMA_DT, FLG_ACNT_DT, RATE_DT, CT, CURRENCYID_CT, USER_CT, SUMA_CT, FLG_ACNT_CT, RATE_CT, COMMENT, transferat_prin)' +
                'VALUES (:FLG_DT_CONFIRMED, :FLG_CT_CONFIRMED, :FLG_LIVRARE, :DT, :CURRENCYID_DT, :USER_DT, :SUMA_DT, :FLG_ACNT_DT, :RATE_DT, :CT, :CURRENCYID_DT, :USER_CT, :SUMA_CT, :FLG_ACNT_CT, :RATE_DT, :COMMENT, :transferat_prin)';

            Query.ParamByName('CURRENCYID_DT').AsInteger := cmbCURRENCY.EditValue;
            Query.ParamByName('FLG_DT_CONFIRMED').AsInteger := 1;
            Query.ParamByName('FLG_CT_CONFIRMED').AsInteger := 0;
            Query.ParamByName('FLG_LIVRARE').AsInteger := Ord(cbLivrare.Checked);
            Query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
            Query.ParamByName('USER_DT').AsInteger := dmDB.CurrentUserID;
            Query.ParamByName('SUMA_DT').AsCurrency := StrToCurr(edSuma.Text);
            Query.ParamByName('FLG_ACNT_DT').AsInteger := Ord(cbFLG_ACNT.Checked);
            Query.ParamByName('CT').AsInteger := clbFirme.EditValue;
            Query.ParamByName('USER_CT').AsInteger := cmbUserName.EditValue;
            Query.ParamByName('SUMA_CT').AsCurrency := StrToCurr(edSuma.Text);
            Query.ParamByName('FLG_ACNT_CT').AsInteger := Ord(cbFLG_ACNT.Checked);
            Query.ParamByName('RATE_DT').AsFloat := dmDB.GetCurrencyExchangeValue(cmbCURRENCY.EditValue,
                cbFLG_ACNT.Checked);
            Query.ParamByName('COMMENT').AsString := Trim(mmComments.Text);
            Query.ParamByName('Transferat_prin').AsInteger := beTRANSFERAT_PRIN.Tag;
            Query.ExecSQL;
            Query.Transaction.Commit;
            Result := True;
        except
            on E: Exception do
            begin
                Query.Transaction.Rollback;
                if not ProcessSWNError(E) then
                    raise;
            end;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmMoneyTransferToUserDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    dmDB.IBCQueryCurrency.Active := False;
end;

procedure TfrmMoneyTransferToUserDlg.FormCreate(Sender: TObject);
begin
    FTargetCurrencyID := -1;
    FTargetFirmaID := -1;
    FTargetUserID := -1;
end;

function TfrmMoneyTransferToUserDlg.getCurrencyID: integer;
begin
    Result := cmbCURRENCY.EditValue;
end;

function TfrmMoneyTransferToUserDlg.getSUMA: Currency;
begin
    Result := StrToCurrDef(edSuma.Text, 0);
end;

procedure TfrmMoneyTransferToUserDlg.Prepare;
begin
    ClientWidth := 505;

    try
        edUserName.Text := dmDB.CurrentUserFullName;

        edFirmaName.Text := dmdb.GetCustomerDisplayName(FSourceDT); //dmDB.CurrentFirmaName;
        dmDB.IBCQueryCurrency.Active := True;
        cmbCURRENCY.EditValue := 498; // MDL by default

        Label8.Visible := False;
        teForDocument.Visible := False;
        cbLivrare.Checked := FLG_LIVRARE;

        cbFLG_ACNT.Checked := FLG_ACNT;

        if FTargetCurrencyID <> -1 then
            cmbCURRENCY.EditValue := FTargetCurrencyID;



        IBCQueryUsers.ParamByName('SHOWCURRENTUSER').AsInteger := iif(ShowcurrentUser = True, 1, 0);
        IBCQueryUsers.Active := True;
        if FTargetUserID <> -1 then
        begin
            if IBCQueryUsers.Locate('USERID', FTargetUserID, []) then
            begin
                cmbUserName.EditValue := FTargetUserID;
                  {
                  if FTargetFirmaID<>-1 then
                  begin
                       IBCQueryFirme.Active:=True;
                       if IBCQueryFirme.Locate('CUSTOMERID',FTargetFirmaID,[]) then clbFirme.EditValue:=FTargetFirmaID;
                  end;
                  }
            end;
        end;

        frameMoneyCounter.OnTotalSumChanged := WhenBanknotesCounterSumaChanged;

        frameMoneyCounter.cxGridBanknotesTableCol2.Selected := True;
        frameMoneyCounter.cxGridBanknotesTableCol2.Focused := True;

//    beTRANSFERAT_PRIN.Tag := 242379;
//    beTRANSFERAT_PRIN.Text := 'BULAI ARTUR';
    except
        IBCQueryUsers.Active := False;
        dmDB.IBCQueryCurrency.Active := False;

        raise;
    end;
end;

procedure TfrmMoneyTransferToUserDlg.sbOpenCalcClick(Sender: TObject);
begin
    ClientWidth := 842;
    sbOpenCalc.Visible := False;
end;

procedure TfrmMoneyTransferToUserDlg.SetAllowChangeCurrency(const Value: Boolean);
begin
    cmbCURRENCY.Enabled := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetCustomTitle(const ACaption, ADescription: string);
begin
    Caption := ACaption;
end;

procedure TfrmMoneyTransferToUserDlg.SetFLG_ACNT(const Value: boolean);
begin
    FFLG_ACNT := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetFLG_LIVRARE(const Value: Boolean);
begin
    FFLG_LIVRARE := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetShowBanknotesCounter(const Value: Boolean);
begin
    if Value then
        ClientWidth := 576
    else
        ClientWidth := 238;
end;

procedure TfrmMoneyTransferToUserDlg.SetShowCurrentUser(const Value: Boolean);
begin
    FShowCurrentUser := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetSourceDT(const Value: integer);
begin
    FSourceDT := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetSUMA(const Value: Currency);
begin
    edSUMA.Text := FloatToStr(Value);
end;

procedure TfrmMoneyTransferToUserDlg.SetTargetCurrencyID(const Value: integer);
begin
    FTargetCurrencyID := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetTargetFirmaID(const Value: integer);
begin
    FTargetFirmaID := Value;
end;

procedure TfrmMoneyTransferToUserDlg.SetTargetUserID(const Value: integer);
begin
    FTargetUserID := Value;
end;

procedure TfrmMoneyTransferToUserDlg.WhenBanknotesCounterSumaChanged(Sender: TObject);
begin
    edSUMA.Text := FloatToStr(frameMoneyCounter.TotalSum);
end;

end.


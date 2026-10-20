unit frmFinantareEditorDialog;

(* ============================================================================
   Cererea de finantare a unei oferte (TWEB_CERERE_FINANTARE) + depunerea ei
   la eCredit prin API (ECreditApiUnit).

   Se deschide din "Oferte" (frame08): click dreapta pe document ->
   "Cerere de finantare / eCredit...". Inregistrarea se cauta:
     1. pe DOCID-ul ofertei;
     2. in sus pe lantul PARENTDOCID (comanda Web-Order 134 cu plata in credit,
        creata de site "cu 1 click" sau din cos, ori Cererea de finantare 1791);
     3. daca nu exista - una noua pe DOCID-ul ofertei, precompletata din fisa
        clientului (VW_TS_CUSTOMER) si din suma ofertei.
   Comanda "cu 1 click" cu plata in credit scrie singura un stub (nume,
   telefon, suma) - WEB_CREATE_TRANSACTION_PHONE2 din finantare_weborder_faza2.sql.

   Salvarea: UPDATE OR INSERT ... MATCHING (DOCID), tranzactie proprie
   (trWrite). Scanurile buletinului (SCAN1/SCAN2) se iau din fisier si se
   scriu doar daca au fost alese; "Vezi" le salveaza in %TEMP% si le deschide.

   eCredit (grupul din dreapta jos):
     "Verifica clientul"      Preapproved_v2_1 - numele din baza eCredit si
                              limitele de aprobare automata;
     "Calculeaza rata"        ECM_InstallmentCalc;
     "Transmite in eCredit"   Request_v4 -> URN; cererea se salveaza inainte;
     "Actualizeaza statutul"  URNStatus_v9;
     "Anuleaza cererea"       ECM_CancelRequest.
   URN-ul si statutele se tin in coloanele ECREDIT_* ale tabelei, fiecare apel
   in TDB_ECREDIT_LOG (DB Model/ecredit_api.sql). Fara coloanele ECREDIT_*
   (scriptul nerulat) cererea se editeaza, dar nu se poate transmite.
   Accesul se configureaza in Setari > Configurari API, codul ECREDIT.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, Data.DB, DBAccess, IBC, MemDS, SWNBaseUnit,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
    cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCurrencyEdit, cxSpinEdit,
    cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCheckBox, cxMemo, cxButtons,
    cxGroupBox, cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
    cxNavigator, dxDateRanges, dxScrollbarAnnotations, ECreditApiUnit;

type
    TfrmFinantareEditorDlg = class(TSWNCustomForm)
        lblHeader: TLabel;
        gbApplicant: TcxGroupBox;
        lblNPP: TLabel;
        edNPP: TcxTextEdit;
        lblIDEN: TLabel;
        edIDEN: TcxTextEdit;
        lblBirth: TLabel;
        deBirth: TcxDateEdit;
        lblPhone: TLabel;
        edPhone: TcxTextEdit;
        lblEmail: TLabel;
        edEmail: TcxTextEdit;
        lblAddress: TLabel;
        edAddress: TcxTextEdit;
        lblHomePhone: TLabel;
        edHomePhone: TcxTextEdit;
        gbWork: TcxGroupBox;
        lblWorkEmployer: TLabel;
        edWorkEmployer: TcxTextEdit;
        lblWorkJob: TLabel;
        edWorkJob: TcxTextEdit;
        lblWorkPhone: TLabel;
        edWorkPhone: TcxTextEdit;
        lblWorkSalary: TLabel;
        edWorkSalary: TcxTextEdit;
        lblWorkDuration: TLabel;
        edWorkDuration: TcxTextEdit;
        gbScans: TcxGroupBox;
        lblScan1: TLabel;
        edScan1Name: TcxTextEdit;
        btnScan1Load: TcxButton;
        btnScan1Open: TcxButton;
        lblScan2: TLabel;
        edScan2Name: TcxTextEdit;
        btnScan2Load: TcxButton;
        btnScan2Open: TcxButton;
        lblFilesStatus: TLabel;
        btnUploadScans: TcxButton;
        gbCredit: TcxGroupBox;
        lblOrg: TLabel;
        lcbOrg: TcxLookupComboBox;
        lblCreditType: TLabel;
        edCreditType: TcxTextEdit;
        lblGoodsPriceCap: TLabel;
        lblGoodsPrice: TLabel;
        lblAvans: TLabel;
        ceAvans: TcxCurrencyEdit;
        lblCreditSuma: TLabel;
        ceCreditSuma: TcxCurrencyEdit;
        lblMonths: TLabel;
        seMonths: TcxSpinEdit;
        lblPlataLunara: TLabel;
        cePlataLunara: TcxCurrencyEdit;
        chkFax: TcxCheckBox;
        gbECredit: TcxGroupBox;
        lblProduct: TLabel;
        cbProduct: TcxComboBox;
        btnProducts: TcxButton;
        lblFirstPay: TLabel;
        deFirstPay: TcxDateEdit;
        lblEnv: TLabel;
        lblNames: TLabel;
        edLastName: TcxTextEdit;
        edFirstName: TcxTextEdit;
        edFatherName: TcxTextEdit;
        btnCheckClient: TcxButton;
        btnCalc: TcxButton;
        lblCalc: TLabel;
        lblURNCap: TLabel;
        lblURN: TLabel;
        lblDocStatus: TLabel;
        lblMessage: TLabel;
        btnSend: TcxButton;
        btnStatus: TcxButton;
        btnCancelReq: TcxButton;
        btnContract: TcxButton;
        mmLog: TcxMemo;
        pnButtons: TPanel;
        lblRequired: TLabel;
        btnSave: TcxButton;
        btnCancel: TcxButton;
        trWrite: TIBCTransaction;
        qOrg: TIBCQuery;
        dsOrg: TIBCDataSource;
        dlgOpenScan: TOpenDialog;
        procedure btnScan1LoadClick(Sender: TObject);
        procedure btnScan2LoadClick(Sender: TObject);
        procedure btnScan1OpenClick(Sender: TObject);
        procedure btnScan2OpenClick(Sender: TObject);
        procedure btnProductsClick(Sender: TObject);
        procedure btnCheckClientClick(Sender: TObject);
        procedure btnCalcClick(Sender: TObject);
        procedure btnSendClick(Sender: TObject);
        procedure btnStatusClick(Sender: TObject);
        procedure btnCancelReqClick(Sender: TObject);
        procedure btnUploadScansClick(Sender: TObject);
        procedure btnContractClick(Sender: TObject);
        procedure cbProductPropertiesChange(Sender: TObject);
        procedure seMonthsPropertiesChange(Sender: TObject);
        procedure edNPPExit(Sender: TObject);
    private
        FOfferDocID: Integer;
        FFinDocID: Integer;
        FIsNew: Boolean;
        FCustomerID: Integer;
        FOfferSuma: Currency;
        FOfferCustomer: string;
        FGoodsName: string;
        FHasEcredit: Boolean;
        FHasScan1: Boolean;
        FHasScan2: Boolean;
        FScan1File: string;
        FScan2File: string;
        FURN: string;
        FReqStatus: string;
        FDocStatus: string;
        FMessage: string;
        FFilesUrl: string;
        FStoredProductID: Integer;
        FProducts: TArray<TECreditProduct>;
        FApplyingProduct: Boolean;
        FConfig: TECreditConfig;
        FConfigError: string;
        FLoading: Boolean;
        function NewReadQuery: TIBCQuery;
        function NewWriteQuery: TIBCQuery;
        procedure BeginWrite;
        procedure CommitWrite;
        procedure RollbackWrite;
        procedure LoadOffer;
        procedure ResolveFinDoc;
        procedure LoadFin;
        procedure PrefillFromCustomer;
        procedure FillProducts(const AProducts: TArray<TECreditProduct>);
        function SelectedProductID: Integer;
        function SelectedProductName: string;
        // False = produsul nu e in lista (ID tastat manual) - fara limite cunoscute
        function SelectedProduct(out P: TECreditProduct): Boolean;
        procedure SelectProduct(const AProductID: Integer);
        procedure SelectProductForMonths(const AMonths: Integer);
        // Aduce termenul si data primei rate in limitele produsului ales.
        procedure ApplyProductConstraints;
        // '' = suma / termenul / data primei rate se incadreaza in produs
        function CheckProduct: string;
        procedure SplitNameIfEmpty;
        function BirthDateText: string;
        function ValidateBase(out AMsg: string): Boolean;
        procedure SaveFin;
        function CreateClient: TECreditApiClient;
        function BuildRequest(out R: TECreditRequest; out AMsg: string): Boolean;
        procedure SaveEcreditState(const ASentNow: Boolean);
        procedure LogApi(AClient: TECreditApiClient; const AAction: string; const AError: string = '');
        procedure ApplyStatus(const S: TECreditStatus);
        procedure ShowEcreditState;
        procedure Log(const AText: string);
        procedure LoadScan(const AIndex: Integer);
        procedure OpenScan(const AIndex: Integer);
        // Scanul AIndex intr-un fisier (cel ales sau blob-ul din baza, salvat in %TEMP%); '' = nu exista.
        function ScanToFile(const AIndex: Integer; out AIsTemp: Boolean): string;
        procedure UploadScans(const AInteractive: Boolean);
        procedure SaveFilesUrl;
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public
        // True = cererea a fost salvata (OK).
        class function Execute(AOwner: TComponent; const AOfferDocID: Integer): Boolean;
    end;

implementation

uses
    System.IOUtils, System.DateUtils, System.StrUtils, System.Math, Winapi.ShellAPI,
    DataModuleDB, SWNUtils;

{$R *.dfm}

const
    cTitle = 'Cerere de finantare';
    cGenericCustomerID = 286;   // PERSOANA FIZICA - clientul generic al comenzilor web

function CurrOf(const V: Variant): Currency;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

function IntOf(const V: Variant): Integer;
begin
    if VarIsNull(V) or VarIsEmpty(V) then
        Result := 0
    else
        Result := V;
end;

// DATA_NASTERII e VARCHAR: 'dd.mm.yyyy' (site), acceptam si yyyy-mm-dd / dd/mm/yyyy.
function ParseRoDate(const S: string; out D: TDateTime): Boolean;
var
    FS: TFormatSettings;
    T: string;
begin
    Result := False;
    T := Trim(S);
    if T = '' then
        Exit;
    FS := TFormatSettings.Invariant;
    FS.DateSeparator := '.';
    FS.ShortDateFormat := 'dd.mm.yyyy';
    Result := TryStrToDate(T, D, FS);
    if not Result then
    begin
        FS.DateSeparator := '-';
        FS.ShortDateFormat := 'yyyy-mm-dd';
        Result := TryStrToDate(Copy(T, 1, 10), D, FS);
    end;
    if not Result then
    begin
        FS.DateSeparator := '/';
        FS.ShortDateFormat := 'dd/mm/yyyy';
        Result := TryStrToDate(T, D, FS);
    end;
end;

{ TfrmFinantareEditorDlg }

class function TfrmFinantareEditorDlg.Execute(AOwner: TComponent; const AOfferDocID: Integer): Boolean;
var
    D: TfrmFinantareEditorDlg;
begin
    D := TfrmFinantareEditorDlg.Create(AOwner);
    try
        D.FOfferDocID := AOfferDocID;
        Result := D.ShowModal = mrOk;
    finally
        D.Free;
    end;
end;

function TfrmFinantareEditorDlg.NewReadQuery: TIBCQuery;
begin
    Result := TIBCQuery.Create(nil);
    Result.Connection := dmDB.IBCConnection;
    Result.Transaction := dmDB.IBCTrDefaultSelect;
end;

function TfrmFinantareEditorDlg.NewWriteQuery: TIBCQuery;
begin
    Result := TIBCQuery.Create(nil);
    Result.Connection := dmDB.IBCConnection;
    Result.Transaction := trWrite;
    Result.UpdateTransaction := trWrite;
    Result.AutoCommit := False;
end;

procedure TfrmFinantareEditorDlg.BeginWrite;
begin
    if not trWrite.Active then
        trWrite.StartTransaction;
end;

procedure TfrmFinantareEditorDlg.CommitWrite;
begin
    if trWrite.Active then
        trWrite.Commit;
end;

procedure TfrmFinantareEditorDlg.RollbackWrite;
begin
    if trWrite.Active then
        trWrite.Rollback;
end;

procedure TfrmFinantareEditorDlg.Log(const AText: string);
begin
    mmLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + AText);
end;

procedure TfrmFinantareEditorDlg.Prepare;
var
    Q: TIBCQuery;
begin
    inherited;
    FLoading := True;
    try
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT COUNT(*) FROM RDB$RELATION_FIELDS ' +
                'WHERE RDB$RELATION_NAME = ''TWEB_CERERE_FINANTARE'' AND RDB$FIELD_NAME = ''ECREDIT_URN''';
            Q.Open;
            FHasEcredit := Q.Fields[0].AsInteger > 0;
        finally
            Q.Free;
        end;

        qOrg.Open;
        LoadOffer;
        ResolveFinDoc;
        if FIsNew then
            PrefillFromCustomer
        else
            LoadFin;
        SplitNameIfEmpty;
        if VarIsNull(deFirstPay.EditValue) then
            deFirstPay.Date := Date + 31;

        Caption := Format('%s - oferta #%d', [cTitle, FOfferDocID]);
        lblHeader.Caption := Format('Oferta #%d, %s, %.2f MDL.  Cererea: %s', [FOfferDocID, FOfferCustomer, FOfferSuma,
            IfThen(FIsNew, 'noua, pe oferta', IfThen(FFinDocID = FOfferDocID, 'pe oferta',
            Format('pe documentul #%d', [FFinDocID])))]);
        lblGoodsPrice.Caption := Format('%.2f MDL', [FOfferSuma]);

        FConfigError := '';
        try
            FConfig := LoadECreditConfig(dmDB.IBCConnection);
            FConfigError := FConfig.Validate;
        except
            on E: Exception do
                FConfigError := E.Message;
        end;
        FillProducts(ECreditDefaultProducts);
        if FStoredProductID > 0 then
            SelectProduct(FStoredProductID)
        else
            SelectProductForMonths(IntOf(seMonths.Value));
        ShowEcreditState;
    finally
        FLoading := False;
    end;
end;

procedure TfrmFinantareEditorDlg.LoadOffer;
var
    Q: TIBCQuery;
    S: string;
begin
    FCustomerID := 0;
    FOfferSuma := 0;
    FOfferCustomer := '';
    FGoodsName := '';
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT D.CT, D.SUMA FROM TDB_DOCS D WHERE D.DOCID = :D';
        Q.ParamByName('D').AsInteger := FOfferDocID;
        Q.Open;
        if Q.IsEmpty then
            raise Exception.CreateFmt('Oferta #%d nu exista.', [FOfferDocID]);
        FCustomerID := Q.FieldByName('CT').AsInteger;
        FOfferSuma := Q.FieldByName('SUMA').AsCurrency;
        Q.Close;

        Q.SQL.Text := 'SELECT NAME FROM VW_TS_CUSTOMER WHERE CUSTOMERID = :C';
        Q.ParamByName('C').AsInteger := FCustomerID;
        Q.Open;
        if not Q.IsEmpty then
            FOfferCustomer := Trim(Q.Fields[0].AsString);
        Q.Close;

        // denumirea marfii pentru eCredit (GoodsName): produsele ofertei, fara componentele complectelor
        Q.SQL.Text := 'SELECT G.TITLE, J.QTY FROM TDB_JURNAL J JOIN TS_GOODS G ON G.GOODSID = J.GOODSID ' +
            'WHERE J.DOCID = :D AND COALESCE(J.GOODSCOMPLECT_ID, -1) = -1';
        Q.ParamByName('D').AsInteger := FOfferDocID;
        Q.Open;
        while not Q.Eof do
        begin
            S := Trim(Q.FieldByName('TITLE').AsString);
            if Q.FieldByName('QTY').AsFloat > 1 then
                S := S + Format(' x%g', [Q.FieldByName('QTY').AsFloat]);
            if FGoodsName <> '' then
                FGoodsName := FGoodsName + '; ';
            FGoodsName := FGoodsName + S;
            Q.Next;
        end;
        if Length(FGoodsName) > 250 then
            FGoodsName := Copy(FGoodsName, 1, 247) + '...';
    finally
        Q.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.ResolveFinDoc;
var
    Q: TIBCQuery;
    Cur, I: Integer;
begin
    FFinDocID := 0;
    Cur := FOfferDocID;
    Q := NewReadQuery;
    try
        for I := 0 to 5 do
        begin
            Q.SQL.Text := 'SELECT COUNT(*) FROM TWEB_CERERE_FINANTARE WHERE DOCID = :D';
            Q.ParamByName('D').AsInteger := Cur;
            Q.Open;
            if Q.Fields[0].AsInteger > 0 then
            begin
                FFinDocID := Cur;
                Break;
            end;
            Q.Close;
            Q.SQL.Text := 'SELECT PARENTDOCID FROM TDB_DOCS WHERE DOCID = :D';
            Q.ParamByName('D').AsInteger := Cur;
            Q.Open;
            if Q.IsEmpty or Q.Fields[0].IsNull then
                Cur := 0
            else
                Cur := Q.Fields[0].AsInteger;
            Q.Close;
            if Cur <= 0 then
                Break;
        end;
    finally
        Q.Free;
    end;
    FIsNew := FFinDocID = 0;
    if FIsNew then
        FFinDocID := FOfferDocID;
end;

procedure TfrmFinantareEditorDlg.PrefillFromCustomer;
var
    Q: TIBCQuery;
    S: string;
begin
    ceCreditSuma.Value := FOfferSuma;
    ceAvans.Value := 0;
    if (FCustomerID <= 0) or (FCustomerID = cGenericCustomerID) then
        Exit;
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT NAME, IDEN_NUMBER, BIRTH_DATE, MOBILE, TELEFON1, EMAIL ' +
            'FROM VW_TS_CUSTOMER WHERE CUSTOMERID = :C';
        Q.ParamByName('C').AsInteger := FCustomerID;
        Q.Open;
        if Q.IsEmpty then
            Exit;
        edNPP.Text := Trim(Q.FieldByName('NAME').AsString);
        S := Trim(Q.FieldByName('IDEN_NUMBER').AsString);
        if ECreditIsValidUIN(S) then
            edIDEN.Text := S;
        if not Q.FieldByName('BIRTH_DATE').IsNull then
            deBirth.Date := Q.FieldByName('BIRTH_DATE').AsDateTime;
        S := Trim(Q.FieldByName('MOBILE').AsString);
        if S = '' then
            S := Trim(Q.FieldByName('TELEFON1').AsString);
        edPhone.Text := S;
        edEmail.Text := Trim(Q.FieldByName('EMAIL').AsString);
    finally
        Q.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.LoadFin;
var
    Q: TIBCQuery;
    D: TDateTime;
    S: string;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT CREDIT_SUMA, CREDIT_PERIOADA, NPP, IDEN, DATA_NASTERII, CONTACT_TELEFON, ' +
            'LOCUL_DE_TRAI, DOMICILIU_TELEFON, WORK_ANGAJATOR, WORK_TELEFON, WORK_JOB_TITLE, WORK_SALARY, ' +
            'WORK_DURATION, FLG_COPY_BY_FAX, AVANS, PLATA_LUNARA, ORG_ID, CREDIT_TYPE, SCAN1_NAME, SCAN2_NAME, ' +
            'IIF(SCAN1 IS NULL, 0, 1) AS HAS1, IIF(SCAN2 IS NULL, 0, 1) AS HAS2' +
            IfThen(FHasEcredit, ', EMAIL, ECREDIT_URN, ECREDIT_PRODUCT_ID, ECREDIT_FIRST_PAY_DATE, ' +
            'ECREDIT_LAST_NAME, ECREDIT_FIRST_NAME, ECREDIT_FATHER_NAME, ECREDIT_REQ_STATUS, ' +
            'ECREDIT_DOC_STATUS, ECREDIT_MESSAGE, ECREDIT_INSTALLMENT, ECREDIT_FILES_URL', '') +
            ' FROM TWEB_CERERE_FINANTARE WHERE DOCID = :D';
        Q.ParamByName('D').AsInteger := FFinDocID;
        Q.Open;
        if Q.IsEmpty then
            raise Exception.CreateFmt('Cererea de finantare #%d nu a fost gasita.', [FFinDocID]);

        ceCreditSuma.Value := Q.FieldByName('CREDIT_SUMA').AsCurrency;
        if Q.FieldByName('CREDIT_PERIOADA').IsNull then
            seMonths.Value := 0
        else
            seMonths.Value := Q.FieldByName('CREDIT_PERIOADA').AsInteger;
        edNPP.Text := Trim(Q.FieldByName('NPP').AsString);
        edIDEN.Text := Trim(Q.FieldByName('IDEN').AsString);
        S := Trim(Q.FieldByName('DATA_NASTERII').AsString);
        if ParseRoDate(S, D) then
            deBirth.Date := D
        else
        begin
            deBirth.EditValue := Null;
            if S <> '' then
                Log('Data nasterii din cerere nu a putut fi citita: "' + S + '"');
        end;
        edPhone.Text := Trim(Q.FieldByName('CONTACT_TELEFON').AsString);
        edAddress.Text := Trim(Q.FieldByName('LOCUL_DE_TRAI').AsString);
        edHomePhone.Text := Trim(Q.FieldByName('DOMICILIU_TELEFON').AsString);
        edWorkEmployer.Text := Trim(Q.FieldByName('WORK_ANGAJATOR').AsString);
        edWorkPhone.Text := Trim(Q.FieldByName('WORK_TELEFON').AsString);
        edWorkJob.Text := Trim(Q.FieldByName('WORK_JOB_TITLE').AsString);
        edWorkSalary.Text := Trim(Q.FieldByName('WORK_SALARY').AsString);
        edWorkDuration.Text := Trim(Q.FieldByName('WORK_DURATION').AsString);
        chkFax.Checked := Q.FieldByName('FLG_COPY_BY_FAX').AsInteger = 1;
        ceAvans.Value := Q.FieldByName('AVANS').AsCurrency;
        if Q.FieldByName('PLATA_LUNARA').IsNull then
            cePlataLunara.EditValue := Null
        else
            cePlataLunara.Value := Q.FieldByName('PLATA_LUNARA').AsCurrency;
        if Q.FieldByName('ORG_ID').IsNull then
            lcbOrg.EditValue := Null
        else
            lcbOrg.EditValue := Q.FieldByName('ORG_ID').AsInteger;
        edCreditType.Text := Trim(Q.FieldByName('CREDIT_TYPE').AsString);
        edScan1Name.Text := Trim(Q.FieldByName('SCAN1_NAME').AsString);
        edScan2Name.Text := Trim(Q.FieldByName('SCAN2_NAME').AsString);
        FHasScan1 := Q.FieldByName('HAS1').AsInteger = 1;
        FHasScan2 := Q.FieldByName('HAS2').AsInteger = 1;

        if FHasEcredit then
        begin
            edEmail.Text := Trim(Q.FieldByName('EMAIL').AsString);
            FURN := Trim(Q.FieldByName('ECREDIT_URN').AsString);
            FStoredProductID := Q.FieldByName('ECREDIT_PRODUCT_ID').AsInteger;
            if not Q.FieldByName('ECREDIT_FIRST_PAY_DATE').IsNull then
                deFirstPay.Date := Q.FieldByName('ECREDIT_FIRST_PAY_DATE').AsDateTime;
            edLastName.Text := Trim(Q.FieldByName('ECREDIT_LAST_NAME').AsString);
            edFirstName.Text := Trim(Q.FieldByName('ECREDIT_FIRST_NAME').AsString);
            edFatherName.Text := Trim(Q.FieldByName('ECREDIT_FATHER_NAME').AsString);
            FReqStatus := Trim(Q.FieldByName('ECREDIT_REQ_STATUS').AsString);
            FDocStatus := Trim(Q.FieldByName('ECREDIT_DOC_STATUS').AsString);
            FMessage := Trim(Q.FieldByName('ECREDIT_MESSAGE').AsString);
            FFilesUrl := Trim(Q.FieldByName('ECREDIT_FILES_URL').AsString);
        end;
    finally
        Q.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.FillProducts(const AProducts: TArray<TECreditProduct>);
var
    P: TECreditProduct;
    Sel: Integer;
begin
    Sel := SelectedProductID;
    FProducts := AProducts;
    FApplyingProduct := True;
    try
        cbProduct.Properties.Items.BeginUpdate;
        try
            cbProduct.Properties.Items.Clear;
            for P in AProducts do
                cbProduct.Properties.Items.AddObject(Format('%d - %s', [P.ID, P.Describe]), TObject(P.ID));
        finally
            cbProduct.Properties.Items.EndUpdate;
        end;
        if Sel > 0 then
            SelectProduct(Sel);
    finally
        FApplyingProduct := False;
    end;
end;

function TfrmFinantareEditorDlg.SelectedProduct(out P: TECreditProduct): Boolean;
var
    ID, I: Integer;
begin
    Result := False;
    P := Default(TECreditProduct);
    ID := SelectedProductID;
    for I := 0 to High(FProducts) do
        if FProducts[I].ID = ID then
        begin
            P := FProducts[I];
            Exit(True);
        end;
end;

procedure TfrmFinantareEditorDlg.ApplyProductConstraints;
var
    P: TECreditProduct;
    Months, Days: Integer;
begin
    if FLoading or FApplyingProduct or not SelectedProduct(P) then
        Exit;
    FApplyingProduct := True;
    try
        Months := IntOf(seMonths.Value);
        if (P.MinInstallments > 0) and (Months < P.MinInstallments) then
            seMonths.Value := P.MinInstallments
        else if (P.MaxInstallments > 0) and (Months > P.MaxInstallments) then
            seMonths.Value := P.MaxInstallments;
        // prima rata: la limita de sus a produsului (31 de zile la "Shop Standard", 180 la Shop-12 din UAT)
        Days := P.FirstPaymentAfter;
        if Days <= 0 then
            Days := 31;
        if VarIsNull(deFirstPay.EditValue) or
           (P.Check(Max(P.MinAmount, 1), Max(P.MinInstallments, 1), deFirstPay.Date) <> '') then
            deFirstPay.Date := Date + Days;
        if P.FromAPI then
            Log(Format('Produs %d: %s.', [P.ID, P.Describe]));
    finally
        FApplyingProduct := False;
    end;
end;

function TfrmFinantareEditorDlg.CheckProduct: string;
var
    P: TECreditProduct;
begin
    Result := '';
    if SelectedProductID <= 0 then
        Exit('Alegeti produsul de credit eCredit.');
    if VarIsNull(deFirstPay.EditValue) then
        Exit('Indicati data primei rate.');
    if SelectedProduct(P) then
        Result := P.Check(CurrOf(ceCreditSuma.Value), IntOf(seMonths.Value), deFirstPay.Date)
    else if (deFirstPay.Date < Date + 15) or (deFirstPay.Date > Date + 45) then
        Result := 'Data primei rate trebuie sa fie intre 15 si 45 de zile de azi (eCredit).';
end;

procedure TfrmFinantareEditorDlg.cbProductPropertiesChange(Sender: TObject);
begin
    ApplyProductConstraints;
end;

function TfrmFinantareEditorDlg.SelectedProductID: Integer;
var
    S: string;
    I: Integer;
begin
    if cbProduct.ItemIndex >= 0 then
        Exit(Integer(cbProduct.Properties.Items.Objects[cbProduct.ItemIndex]));
    // textul tastat: "4661" sau "4661 - ..."
    S := Trim(cbProduct.Text);
    I := 1;
    while (I <= Length(S)) and CharInSet(S[I], ['0'..'9']) do
        Inc(I);
    Result := StrToIntDef(Copy(S, 1, I - 1), 0);
end;

function TfrmFinantareEditorDlg.SelectedProductName: string;
var
    P: Integer;
    Prod: TECreditProduct;
begin
    if SelectedProduct(Prod) then
        Exit(Copy(Prod.Name, 1, 128));
    Result := Trim(cbProduct.Text);
    P := Pos(' - ', Result);
    if P > 0 then
        Result := Trim(Copy(Result, P + 3, MaxInt));
    Result := Copy(Result, 1, 128);
end;

procedure TfrmFinantareEditorDlg.SelectProduct(const AProductID: Integer);
var
    I: Integer;
begin
    for I := 0 to cbProduct.Properties.Items.Count - 1 do
        if Integer(cbProduct.Properties.Items.Objects[I]) = AProductID then
        begin
            cbProduct.ItemIndex := I;
            Exit;
        end;
    if AProductID > 0 then
        cbProduct.Text := IntToStr(AProductID);
end;

// Produsul in care se incadreaza termenul: dupa limitele din API (Shop-06-11 pentru 8 luni),
// altfel dupa nume ("Fantastic 0% pe 6 luni" pentru 6 luni).
procedure TfrmFinantareEditorDlg.SelectProductForMonths(const AMonths: Integer);
var
    I: Integer;
    Key: string;
    Cur: TECreditProduct;
begin
    if AMonths <= 0 then
        Exit;
    // produsul ales ramine daca termenul se incadreaza in el
    if SelectedProduct(Cur) and (Cur.MinInstallments > 0) and (AMonths >= Cur.MinInstallments) and
       (AMonths <= Cur.MaxInstallments) then
        Exit;
    for I := 0 to High(FProducts) do
        if (FProducts[I].MinInstallments > 0) and (AMonths >= FProducts[I].MinInstallments) and
           (AMonths <= FProducts[I].MaxInstallments) then
        begin
            SelectProduct(FProducts[I].ID);
            Exit;
        end;
    Key := Format('pe %d luni', [AMonths]);
    for I := 0 to cbProduct.Properties.Items.Count - 1 do
        if Pos(Key, LowerCase(cbProduct.Properties.Items[I])) > 0 then
        begin
            cbProduct.ItemIndex := I;
            Exit;
        end;
end;

// NPP "Nume Prenume [Patronimic]" -> cimpurile separate cerute de API, daca sint goale.
procedure TfrmFinantareEditorDlg.SplitNameIfEmpty;
var
    Parts: TArray<string>;
begin
    if (Trim(edLastName.Text) <> '') or (Trim(edFirstName.Text) <> '') then
        Exit;
    Parts := Trim(edNPP.Text).Split([' '], TStringSplitOptions.ExcludeEmpty);
    if Length(Parts) >= 1 then
        edLastName.Text := Parts[0];
    if Length(Parts) >= 2 then
        edFirstName.Text := Parts[1];
    if Length(Parts) >= 3 then
        edFatherName.Text := Parts[2];
end;

function TfrmFinantareEditorDlg.BirthDateText: string;
begin
    if VarIsNull(deBirth.EditValue) then
        Result := ''
    else
        Result := FormatDateTime('dd"."mm"."yyyy', deBirth.Date);
end;

function TfrmFinantareEditorDlg.ValidateBase(out AMsg: string): Boolean;
var
    S: string;
begin
    Result := False;
    if Trim(edNPP.Text) = '' then
        AMsg := 'Indicati numele si prenumele solicitantului.'
    else
    begin
        S := Trim(edIDEN.Text);
        if (S <> '') and not ECreditIsValidUIN(S) then
            AMsg := 'IDNP-ul trebuie sa aiba 13 cifre si sa inceapa cu 0 sau 2.'
        else if CurrOf(ceCreditSuma.Value) < 0 then
            AMsg := 'Suma creditului nu poate fi negativa.'
        else
            Result := True;
    end;
end;

procedure TfrmFinantareEditorDlg.SaveFin;
var
    Q: TIBCQuery;
    Extra, ExtraVals: string;
begin
    BeginWrite;
    try
        Q := NewWriteQuery;
        try
            Extra := '';
            ExtraVals := '';
            if FHasEcredit then
            begin
                Extra := ', EMAIL, ECREDIT_PRODUCT_ID, ECREDIT_PRODUCT_NAME, ECREDIT_FIRST_PAY_DATE, ' +
                    'ECREDIT_LAST_NAME, ECREDIT_FIRST_NAME, ECREDIT_FATHER_NAME';
                ExtraVals := ', :EMAIL, :EPID, :EPNAME, :EFPD, :ELN, :EFN, :EFAN';
            end;
            Q.SQL.Text := 'UPDATE OR INSERT INTO TWEB_CERERE_FINANTARE (DOCID, CREDIT_SUMA, CREDIT_PERIOADA, NPP, ' +
                'IDEN, DATA_NASTERII, CONTACT_TELEFON, LOCUL_DE_TRAI, DOMICILIU_TELEFON, WORK_ANGAJATOR, ' +
                'WORK_TELEFON, WORK_JOB_TITLE, WORK_SALARY, WORK_DURATION, FLG_COPY_BY_FAX, AVANS, PLATA_LUNARA, ' +
                'ORG_ID, CREDIT_TYPE' + Extra + ') VALUES (:DOCID, :CREDIT_SUMA, :CREDIT_PERIOADA, :NPP, :IDEN, ' +
                ':DATA_NASTERII, :CONTACT_TELEFON, :LOCUL_DE_TRAI, :DOMICILIU_TELEFON, :WORK_ANGAJATOR, ' +
                ':WORK_TELEFON, :WORK_JOB_TITLE, :WORK_SALARY, :WORK_DURATION, :FLG_COPY_BY_FAX, :AVANS, ' +
                ':PLATA_LUNARA, :ORG_ID, :CREDIT_TYPE' + ExtraVals + ') MATCHING (DOCID)';
            Q.ParamByName('DOCID').AsInteger := FFinDocID;
            Q.ParamByName('CREDIT_SUMA').AsCurrency := CurrOf(ceCreditSuma.Value);
            if IntOf(seMonths.Value) > 0 then
                Q.ParamByName('CREDIT_PERIOADA').AsInteger := IntOf(seMonths.Value)
            else
            begin
                Q.ParamByName('CREDIT_PERIOADA').DataType := ftInteger;
                Q.ParamByName('CREDIT_PERIOADA').Clear;
            end;
            Q.ParamByName('NPP').AsString := Copy(Trim(edNPP.Text), 1, 512);
            Q.ParamByName('IDEN').AsString := Copy(Trim(edIDEN.Text), 1, 64);
            Q.ParamByName('DATA_NASTERII').AsString := BirthDateText;
            Q.ParamByName('CONTACT_TELEFON').AsString := Copy(Trim(edPhone.Text), 1, 1020);
            Q.ParamByName('LOCUL_DE_TRAI').AsString := Copy(Trim(edAddress.Text), 1, 1020);
            Q.ParamByName('DOMICILIU_TELEFON').AsString := Copy(Trim(edHomePhone.Text), 1, 1020);
            Q.ParamByName('WORK_ANGAJATOR').AsString := Copy(Trim(edWorkEmployer.Text), 1, 1020);
            Q.ParamByName('WORK_TELEFON').AsString := Copy(Trim(edWorkPhone.Text), 1, 1020);
            Q.ParamByName('WORK_JOB_TITLE').AsString := Copy(Trim(edWorkJob.Text), 1, 1020);
            Q.ParamByName('WORK_SALARY').AsString := Copy(Trim(edWorkSalary.Text), 1, 1020);
            Q.ParamByName('WORK_DURATION').AsString := Copy(Trim(edWorkDuration.Text), 1, 1020);
            Q.ParamByName('FLG_COPY_BY_FAX').AsInteger := IfThen(chkFax.Checked, 1, 0);
            Q.ParamByName('AVANS').AsCurrency := CurrOf(ceAvans.Value);
            if CurrOf(cePlataLunara.Value) > 0 then
                Q.ParamByName('PLATA_LUNARA').AsCurrency := CurrOf(cePlataLunara.Value)
            else
            begin
                Q.ParamByName('PLATA_LUNARA').DataType := ftCurrency;
                Q.ParamByName('PLATA_LUNARA').Clear;
            end;
            if VarIsNull(lcbOrg.EditValue) or VarIsEmpty(lcbOrg.EditValue) then
            begin
                Q.ParamByName('ORG_ID').DataType := ftInteger;
                Q.ParamByName('ORG_ID').Clear;
            end
            else
                Q.ParamByName('ORG_ID').AsInteger := lcbOrg.EditValue;
            if Trim(edCreditType.Text) = '' then
            begin
                Q.ParamByName('CREDIT_TYPE').DataType := ftString;
                Q.ParamByName('CREDIT_TYPE').Clear;
            end
            else
                Q.ParamByName('CREDIT_TYPE').AsString := Copy(Trim(edCreditType.Text), 1, 128);
            if FHasEcredit then
            begin
                Q.ParamByName('EMAIL').AsString := Copy(Trim(edEmail.Text), 1, 255);
                if SelectedProductID > 0 then
                begin
                    Q.ParamByName('EPID').AsInteger := SelectedProductID;
                    Q.ParamByName('EPNAME').AsString := SelectedProductName;
                end
                else
                begin
                    Q.ParamByName('EPID').DataType := ftInteger;
                    Q.ParamByName('EPID').Clear;
                    Q.ParamByName('EPNAME').DataType := ftString;
                    Q.ParamByName('EPNAME').Clear;
                end;
                if VarIsNull(deFirstPay.EditValue) then
                begin
                    Q.ParamByName('EFPD').DataType := ftDate;
                    Q.ParamByName('EFPD').Clear;
                end
                else
                    Q.ParamByName('EFPD').AsDate := deFirstPay.Date;
                Q.ParamByName('ELN').AsString := Copy(Trim(edLastName.Text), 1, 64);
                Q.ParamByName('EFN').AsString := Copy(Trim(edFirstName.Text), 1, 64);
                Q.ParamByName('EFAN').AsString := Copy(Trim(edFatherName.Text), 1, 64);
            end;
            Q.Execute;

            if FScan1File <> '' then
            begin
                Q.SQL.Text := 'UPDATE TWEB_CERERE_FINANTARE SET SCAN1 = :S, SCAN1_NAME = :N WHERE DOCID = :D';
                Q.ParamByName('S').LoadFromFile(FScan1File, ftBlob);
                Q.ParamByName('N').AsString := Copy(ExtractFileName(FScan1File), 1, 1020);
                Q.ParamByName('D').AsInteger := FFinDocID;
                Q.Execute;
            end;
            if FScan2File <> '' then
            begin
                Q.SQL.Text := 'UPDATE TWEB_CERERE_FINANTARE SET SCAN2 = :S, SCAN2_NAME = :N WHERE DOCID = :D';
                Q.ParamByName('S').LoadFromFile(FScan2File, ftBlob);
                Q.ParamByName('N').AsString := Copy(ExtractFileName(FScan2File), 1, 1020);
                Q.ParamByName('D').AsInteger := FFinDocID;
                Q.Execute;
            end;
        finally
            Q.Free;
        end;
        CommitWrite;
    except
        RollbackWrite;
        raise;
    end;
    FIsNew := False;
    if FScan1File <> '' then
        FHasScan1 := True;
    if FScan2File <> '' then
        FHasScan2 := True;
    FScan1File := '';
    FScan2File := '';
end;

function TfrmFinantareEditorDlg.IsFormDataPosted: Boolean;
var
    Msg: string;
begin
    Result := False;
    if not ValidateBase(Msg) then
    begin
        ShowErrorDialog(cTitle, Msg);
        Exit;
    end;
    try
        SaveFin;
        Result := True;
    except
        on E: Exception do
            ShowErrorDialog(cTitle, 'Cererea nu a fost salvata.', E.Message);
    end;
end;

procedure TfrmFinantareEditorDlg.WhenCancelForm;
begin
    RollbackWrite;
    inherited;
end;

{ scanurile buletinului }

procedure TfrmFinantareEditorDlg.LoadScan(const AIndex: Integer);
begin
    if not dlgOpenScan.Execute then
        Exit;
    if AIndex = 1 then
    begin
        FScan1File := dlgOpenScan.FileName;
        edScan1Name.Text := ExtractFileName(FScan1File);
    end
    else
    begin
        FScan2File := dlgOpenScan.FileName;
        edScan2Name.Text := ExtractFileName(FScan2File);
    end;
end;

procedure TfrmFinantareEditorDlg.OpenScan(const AIndex: Integer);
var
    Q: TIBCQuery;
    Col, Path, Ext, Pending: string;
    HasScan: Boolean;
begin
    if AIndex = 1 then
    begin
        Pending := FScan1File;
        HasScan := FHasScan1;
        Col := 'SCAN1';
    end
    else
    begin
        Pending := FScan2File;
        HasScan := FHasScan2;
        Col := 'SCAN2';
    end;
    if Pending <> '' then
        Path := Pending
    else
    begin
        if not HasScan then
        begin
            ShowInfoDialog(cTitle, 'Cererea nu are aceasta copie a buletinului.');
            Exit;
        end;
        Q := NewReadQuery;
        try
            Q.SQL.Text := Format('SELECT %s AS S, %s_NAME AS N FROM TWEB_CERERE_FINANTARE WHERE DOCID = :D', [Col, Col]);
            Q.ParamByName('D').AsInteger := FFinDocID;
            Q.Open;
            if Q.IsEmpty or Q.FieldByName('S').IsNull then
            begin
                ShowInfoDialog(cTitle, 'Cererea nu are aceasta copie a buletinului.');
                Exit;
            end;
            Ext := LowerCase(ExtractFileExt(Trim(Q.FieldByName('N').AsString)));
            if (Ext = '') or (Length(Ext) > 5) then
                Ext := '.jpg';
            Path := TPath.Combine(TPath.GetTempPath, Format('finantare_%d_%s%s', [FFinDocID, LowerCase(Col), Ext]));
            TBlobField(Q.FieldByName('S')).SaveToFile(Path);
        finally
            Q.Free;
        end;
    end;
    ShellExecute(0, 'open', PChar(Path), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmFinantareEditorDlg.btnScan1LoadClick(Sender: TObject);
begin
    LoadScan(1);
end;

procedure TfrmFinantareEditorDlg.btnScan2LoadClick(Sender: TObject);
begin
    LoadScan(2);
end;

procedure TfrmFinantareEditorDlg.btnScan1OpenClick(Sender: TObject);
begin
    OpenScan(1);
end;

procedure TfrmFinantareEditorDlg.btnScan2OpenClick(Sender: TObject);
begin
    OpenScan(2);
end;

procedure TfrmFinantareEditorDlg.seMonthsPropertiesChange(Sender: TObject);
begin
    if not FLoading and not FApplyingProduct then
        SelectProductForMonths(IntOf(seMonths.Value));
end;

procedure TfrmFinantareEditorDlg.edNPPExit(Sender: TObject);
begin
    SplitNameIfEmpty;
end;

{ eCredit }

function TfrmFinantareEditorDlg.CreateClient: TECreditApiClient;
begin
    Result := TECreditApiClient.Create(FConfig);
end;

procedure TfrmFinantareEditorDlg.ShowEcreditState;
var
    CanApi: Boolean;
begin
    if FConfigError <> '' then
        lblEnv.Caption := 'Acces API: ' + FConfigError + ' (Setari > Configurari API, ECREDIT)'
    else
        lblEnv.Caption := 'Mediu: ' + FConfig.Environment + IfThen(FConfig.ShopID > 0,
            Format(', magazin %d', [FConfig.ShopID]), '');
    if not FHasEcredit then
        lblEnv.Caption := 'Rulati DB Model/ecredit_api.sql (lipsesc coloanele ECREDIT_*). ' + lblEnv.Caption;

    if FURN = '' then
        lblURN.Caption := '-'
    else
        lblURN.Caption := FURN + IfThen(FReqStatus <> '', '  (' + FReqStatus + ')', '');
    lblDocStatus.Caption := 'Contract: ' + IfThen(FDocStatus = '', '-', FDocStatus +
        IfThen(ECreditDocStatusRo(FDocStatus) <> '', ' = ' + ECreditDocStatusRo(FDocStatus), ''));
    lblMessage.Caption := IfThen(FMessage = '', '', 'Mesaj: ' + FMessage);

    CanApi := FConfigError = '';
    btnProducts.Enabled := CanApi;
    btnCheckClient.Enabled := CanApi;
    btnCalc.Enabled := CanApi;
    btnSend.Enabled := CanApi and FHasEcredit;
    btnStatus.Enabled := CanApi and FHasEcredit and (FURN <> '');
    btnCancelReq.Enabled := btnStatus.Enabled and not ECreditIsFinalStatus(FReqStatus);
    btnContract.Enabled := btnStatus.Enabled;
    btnUploadScans.Enabled := btnStatus.Enabled and
        (FHasScan1 or FHasScan2 or (FScan1File <> '') or (FScan2File <> ''));
    if FFilesUrl <> '' then
        lblFilesStatus.Caption := 'eCredit: trimise (' + FFilesUrl + ')'
    else if FURN = '' then
        lblFilesStatus.Caption := 'eCredit: se trimit dupa depunerea cererii'
    else
        lblFilesStatus.Caption := 'eCredit: netrimise';
    lblFilesStatus.Hint := FFilesUrl;
end;

procedure TfrmFinantareEditorDlg.ApplyStatus(const S: TECreditStatus);
begin
    FReqStatus := S.RequestStatus;
    FDocStatus := S.DocumentStatus;
    FMessage := S.Message;
    if S.InstallmentAmount > 0 then
        cePlataLunara.Value := S.InstallmentAmount;
    if (Trim(edLastName.Text) = '') and (S.LastName <> '') then
        edLastName.Text := S.LastName;
    if (Trim(edFirstName.Text) = '') and (S.FirstName <> '') then
        edFirstName.Text := S.FirstName;
    if (Trim(edFatherName.Text) = '') and (S.FatherName <> '') then
        edFatherName.Text := S.FatherName;
    Log(S.Summary);
    ShowEcreditState;
end;

procedure TfrmFinantareEditorDlg.LogApi(AClient: TECreditApiClient; const AAction: string; const AError: string);
var
    Q: TIBCQuery;
begin
    if not FHasEcredit then
        Exit;
    try
        BeginWrite;
        Q := NewWriteQuery;
        try
            Q.SQL.Text := 'INSERT INTO TDB_ECREDIT_LOG (DOCID, URN, ACTION, HTTP_CODE, REQUEST_JSON, RESPONSE_JSON, ' +
                'ERROR_TEXT, CREATED_BY) VALUES (:DOCID, :URN, :ACTION, :CODE, :REQ, :RESP, :ERR, :USR)';
            Q.ParamByName('DOCID').AsInteger := FFinDocID;
            if FURN = '' then
            begin
                Q.ParamByName('URN').DataType := ftString;
                Q.ParamByName('URN').Clear;
            end
            else
                Q.ParamByName('URN').AsString := FURN;
            Q.ParamByName('ACTION').AsString := Copy(AAction, 1, 32);
            Q.ParamByName('CODE').AsInteger := AClient.LastHttpCode;
            Q.ParamByName('REQ').AsMemo := AClient.LastRequest;
            Q.ParamByName('RESP').AsMemo := AClient.LastResponse;
            if AError = '' then
            begin
                Q.ParamByName('ERR').DataType := ftString;
                Q.ParamByName('ERR').Clear;
            end
            else
                Q.ParamByName('ERR').AsString := Copy(AError, 1, 2000);
            Q.ParamByName('USR').AsInteger := dmDB.CurrentUserID;
            Q.Execute;
        finally
            Q.Free;
        end;
        CommitWrite;
    except
        on E: Exception do
        begin
            RollbackWrite;
            Log('Jurnalul TDB_ECREDIT_LOG: ' + E.Message);
        end;
    end;
end;

procedure TfrmFinantareEditorDlg.SaveEcreditState(const ASentNow: Boolean);
var
    Q: TIBCQuery;
begin
    if not FHasEcredit then
        Exit;
    BeginWrite;
    try
        Q := NewWriteQuery;
        try
            Q.SQL.Text := 'UPDATE TWEB_CERERE_FINANTARE SET ECREDIT_URN = :URN, ECREDIT_REQ_STATUS = :RS, ' +
                'ECREDIT_DOC_STATUS = :DS, ECREDIT_MESSAGE = :MSG, ECREDIT_CHECKED_AT = CURRENT_TIMESTAMP, ' +
                'ECREDIT_PRODUCT_ID = :PID, ECREDIT_PRODUCT_NAME = :PN, ECREDIT_FIRST_PAY_DATE = :FPD, ' +
                'ECREDIT_LAST_NAME = :LN, ECREDIT_FIRST_NAME = :FN, ECREDIT_FATHER_NAME = :FAN, ' +
                'ECREDIT_INSTALLMENT = :INST' + IfThen(ASentNow, ', ECREDIT_SENT_AT = CURRENT_TIMESTAMP', '') +
                ' WHERE DOCID = :D';
            Q.ParamByName('URN').AsString := FURN;
            Q.ParamByName('RS').AsString := Copy(FReqStatus, 1, 64);
            Q.ParamByName('DS').AsString := Copy(FDocStatus, 1, 64);
            Q.ParamByName('MSG').AsString := Copy(FMessage, 1, 1024);
            if SelectedProductID > 0 then
            begin
                Q.ParamByName('PID').AsInteger := SelectedProductID;
                Q.ParamByName('PN').AsString := SelectedProductName;
            end
            else
            begin
                Q.ParamByName('PID').DataType := ftInteger;
                Q.ParamByName('PID').Clear;
                Q.ParamByName('PN').DataType := ftString;
                Q.ParamByName('PN').Clear;
            end;
            if VarIsNull(deFirstPay.EditValue) then
            begin
                Q.ParamByName('FPD').DataType := ftDate;
                Q.ParamByName('FPD').Clear;
            end
            else
                Q.ParamByName('FPD').AsDate := deFirstPay.Date;
            Q.ParamByName('LN').AsString := Copy(Trim(edLastName.Text), 1, 64);
            Q.ParamByName('FN').AsString := Copy(Trim(edFirstName.Text), 1, 64);
            Q.ParamByName('FAN').AsString := Copy(Trim(edFatherName.Text), 1, 64);
            Q.ParamByName('INST').AsCurrency := CurrOf(cePlataLunara.Value);
            Q.ParamByName('D').AsInteger := FFinDocID;
            Q.Execute;
        finally
            Q.Free;
        end;
        CommitWrite;
    except
        RollbackWrite;
        raise;
    end;
end;

function TfrmFinantareEditorDlg.BuildRequest(out R: TECreditRequest; out AMsg: string): Boolean;
var
    Months: Integer;
begin
    Result := False;
    R := Default(TECreditRequest);
    AMsg := '';
    if not FHasEcredit then
        AMsg := 'Rulati mai intii DB Model/ecredit_api.sql - lipsesc coloanele ECREDIT_* din TWEB_CERERE_FINANTARE.'
    else if FConfigError <> '' then
        AMsg := 'Accesul la API nu e configurat: ' + FConfigError + '.'
    else if not ECreditIsValidUIN(Trim(edIDEN.Text)) then
        AMsg := 'IDNP-ul solicitantului trebuie sa aiba 13 cifre si sa inceapa cu 0 sau 2.'
    else if VarIsNull(deBirth.EditValue) then
        AMsg := 'Indicati data nasterii.'
    else if (Trim(edLastName.Text) = '') or (Trim(edFirstName.Text) = '') then
        AMsg := 'Indicati numele si prenumele (cimpurile separate din grupul eCredit).'
    else if Length(ECreditNormalizePhone(edPhone.Text)) < 9 then
        AMsg := 'Telefonul mobil trebuie sa aiba 9 cifre (0XXXXXXXX).'
    else if CurrOf(ceCreditSuma.Value) <= 0 then
        AMsg := 'Indicati suma creditului.'
    else if IntOf(seMonths.Value) <= 0 then
        AMsg := 'Indicati termenul creditului (luni).'
    else
        AMsg := CheckProduct;
    if AMsg <> '' then
        Exit;

    Months := IntOf(seMonths.Value);
    R.ProductID := SelectedProductID;
    R.ShopID := FConfig.ShopID;
    R.UIN := Trim(edIDEN.Text);
    R.BirthDate := deBirth.Date;
    R.LastName := Trim(edLastName.Text);
    R.FirstName := Trim(edFirstName.Text);
    R.FatherName := Trim(edFatherName.Text);
    R.Mobile := ECreditNormalizePhone(edPhone.Text);
    R.Email := Trim(edEmail.Text);
    R.GoodsName := FGoodsName;
    if R.GoodsName = '' then
        R.GoodsName := Format('Marfa conform ofertei #%d', [FOfferDocID]);
    R.CreditAmount := CurrOf(ceCreditSuma.Value);
    if FOfferSuma > 0 then
        R.GoodsPrice := FOfferSuma
    else
        R.GoodsPrice := R.CreditAmount + CurrOf(ceAvans.Value);
    R.Installments := Months;
    R.FirstInstallmentDate := deFirstPay.Date;
    Result := True;
end;

procedure TfrmFinantareEditorDlg.btnProductsClick(Sender: TObject);
var
    C: TECreditApiClient;
    P: TArray<TECreditProduct>;
begin
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                P := C.ShopProducts;
                LogApi(C, 'PRODUCTS');
                if Length(P) > 0 then
                begin
                    FillProducts(P);
                    Log(Format('Produse eCredit: %d (ECM_ShopProducts).', [Length(P)]));
                end
                else
                    Log('ECM_ShopProducts nu a intors produse; ramine lista locala. Raspuns: ' +
                        Copy(C.LastResponse, 1, 500));
            except
                on E: Exception do
                begin
                    LogApi(C, 'PRODUCTS', E.Message);
                    Log('Produse: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Lista de produse nu a putut fi citita.', E.Message);
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnCheckClientClick(Sender: TObject);
var
    C: TECreditApiClient;
    Info: TECreditClientInfo;
    Phone, Txt: string;
begin
    if not ECreditIsValidUIN(Trim(edIDEN.Text)) then
    begin
        ShowErrorDialog('eCredit', 'IDNP-ul trebuie sa aiba 13 cifre si sa inceapa cu 0 sau 2.');
        Exit;
    end;
    if VarIsNull(deBirth.EditValue) then
    begin
        ShowErrorDialog('eCredit', 'Indicati data nasterii.');
        Exit;
    end;
    Phone := ECreditNormalizePhone(edPhone.Text);
    if Length(Phone) < 9 then
    begin
        ShowErrorDialog('eCredit', 'Telefonul mobil trebuie sa aiba 9 cifre (0XXXXXXXX).');
        Exit;
    end;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Info := C.Preapproved(Trim(edIDEN.Text), deBirth.Date, Phone);
                LogApi(C, 'PREAPPROVED');
                if Info.LastName <> '' then
                    edLastName.Text := Info.LastName;
                if Info.FirstName <> '' then
                    edFirstName.Text := Info.FirstName;
                if Info.FatherName <> '' then
                    edFatherName.Text := Info.FatherName;
                if (Trim(edNPP.Text) = '') and (Info.LastName <> '') then
                    edNPP.Text := Trim(Info.LastName + ' ' + Info.FirstName);
                Txt := Format('Statut: %s'#13#10'Nume: %s %s %s'#13#10'Limita aprobare automata eSimplu: %.2f MDL'#13#10 +
                    'Limita aprobare automata Reuseste: %.2f MDL',
                    [Info.Status, Info.LastName, Info.FirstName, Info.FatherName, Info.MaxESimplu, Info.MaxReuseste]);
                Log('Verificare client: ' + StringReplace(Txt, #13#10, '; ', [rfReplaceAll]));
                ShowInfoDialog('eCredit - verificarea clientului', Txt);
            except
                on E: Exception do
                begin
                    LogApi(C, 'PREAPPROVED', E.Message);
                    Log('Verificare client: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Verificarea clientului a esuat.', E.Message, Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnCalcClick(Sender: TObject);
var
    C: TECreditApiClient;
    Calc: TECreditCalc;
begin
    if (CurrOf(ceCreditSuma.Value) <= 0) or (IntOf(seMonths.Value) <= 0) then
    begin
        ShowErrorDialog('eCredit', 'Indicati suma creditului si termenul (luni).');
        Exit;
    end;
    if CheckProduct <> '' then
    begin
        ShowErrorDialog('eCredit', CheckProduct);
        Exit;
    end;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Calc := C.InstallmentCalc(SelectedProductID, CurrOf(ceCreditSuma.Value), deFirstPay.Date,
                    IntOf(seMonths.Value));
                LogApi(C, 'CALC');
                lblCalc.Caption := Calc.Summary;
                if Calc.InstallmentAmount > 0 then
                    cePlataLunara.Value := Calc.InstallmentAmount;
                Log('Calcul: ' + Calc.Summary);
            except
                on E: Exception do
                begin
                    LogApi(C, 'CALC', E.Message);
                    Log('Calcul: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Calculul ratei a esuat.', E.Message, Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnSendClick(Sender: TObject);
var
    C: TECreditApiClient;
    R: TECreditRequest;
    Res: TECreditRequestResult;
    S: TECreditStatus;
    Msg: string;
begin
    if not ValidateBase(Msg) or not BuildRequest(R, Msg) then
    begin
        ShowErrorDialog('eCredit', Msg);
        Exit;
    end;
    if (FURN <> '') and not ECreditIsFinalStatus(FReqStatus) then
        if ShowAskDialog('eCredit', Format('Cererea are deja URN %s (%s).'#13#10'Depuneti o cerere noua?',
            [FURN, FReqStatus])) <> mrYes then
            Exit;
    Msg := Format('%s %s, IDNP %s'#13#10'%s'#13#10'Credit %.2f MDL, %d luni, prima rata %s'#13#10'Mediu: %s',
        [R.LastName, R.FirstName, R.UIN, Trim(cbProduct.Text), R.CreditAmount, R.Installments,
        FormatDateTime('dd.mm.yyyy', R.FirstInstallmentDate), FConfig.Environment]);
    if ShowAskDialog('eCredit', 'Transmiteti cererea de credit la eCredit?', Msg) <> mrYes then
        Exit;

    try
        SaveFin;
    except
        on E: Exception do
        begin
            ShowErrorDialog(cTitle, 'Cererea nu a fost salvata, nu se transmite.', E.Message);
            Exit;
        end;
    end;

    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Res := C.SendRequest(R);
                FURN := Res.URN;
                FReqStatus := Res.Status;
                FDocStatus := '';
                FMessage := '';
                SaveEcreditState(True);
                LogApi(C, 'REQUEST');
                Log(Format('Cerere depusa: URN %s, statut %s.', [FURN, FReqStatus]));
                ShowEcreditState;
                try
                    S := C.GetStatus(FURN);
                    ApplyStatus(S);
                    SaveEcreditState(False);
                    LogApi(C, 'STATUS');
                except
                    on E: Exception do
                    begin
                        LogApi(C, 'STATUS', E.Message);
                        Log('Statut: ' + E.Message);
                    end;
                end;
                ShowInfoDialog('eCredit', Format('Cererea a fost depusa.'#13#10'URN: %s'#13#10'Statut: %s',
                    [FURN, FReqStatus]));
                // copia buletinului merge la partener.ecredit.md imediat dupa cerere
                if FHasScan1 or FHasScan2 then
                    UploadScans(False);
            except
                on E: Exception do
                begin
                    LogApi(C, 'REQUEST', E.Message);
                    Log('Transmitere: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Cererea nu a fost depusa.', E.Message, Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnStatusClick(Sender: TObject);
var
    C: TECreditApiClient;
    S: TECreditStatus;
begin
    if FURN = '' then
        Exit;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                S := C.GetStatus(FURN);
                ApplyStatus(S);
                SaveEcreditState(False);
                LogApi(C, 'STATUS');
            except
                on E: Exception do
                begin
                    LogApi(C, 'STATUS', E.Message);
                    Log('Statut: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Statutul nu a putut fi citit.', E.Message, Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

function TfrmFinantareEditorDlg.ScanToFile(const AIndex: Integer; out AIsTemp: Boolean): string;
var
    Q: TIBCQuery;
    Col, Ext: string;
    Pending: string;
    HasScan: Boolean;
begin
    Result := '';
    AIsTemp := False;
    if AIndex = 1 then
    begin
        Pending := FScan1File;
        HasScan := FHasScan1;
        Col := 'SCAN1';
    end
    else
    begin
        Pending := FScan2File;
        HasScan := FHasScan2;
        Col := 'SCAN2';
    end;
    if Pending <> '' then
        Exit(Pending);
    if not HasScan then
        Exit;
    Q := NewReadQuery;
    try
        Q.SQL.Text := Format('SELECT %s AS S, %s_NAME AS N FROM TWEB_CERERE_FINANTARE WHERE DOCID = :D', [Col, Col]);
        Q.ParamByName('D').AsInteger := FFinDocID;
        Q.Open;
        if Q.IsEmpty or Q.FieldByName('S').IsNull then
            Exit;
        Ext := LowerCase(ExtractFileExt(Trim(Q.FieldByName('N').AsString)));
        if ECreditMimeType('x' + Ext) = '' then
            Ext := '.jpg';   // scanurile vechi de pe site nu au nume; sint JPEG
        Result := TPath.Combine(TPath.GetTempPath, Format('finantare_%d_%s_%s%s',
            [FFinDocID, LowerCase(Col), FormatDateTime('hhnnss', Now), Ext]));
        TBlobField(Q.FieldByName('S')).SaveToFile(Result);
        AIsTemp := True;
    finally
        Q.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.SaveFilesUrl;
var
    Q: TIBCQuery;
begin
    if not FHasEcredit then
        Exit;
    BeginWrite;
    try
        Q := NewWriteQuery;
        try
            Q.SQL.Text := 'UPDATE TWEB_CERERE_FINANTARE SET ECREDIT_FILES_URL = :U, ECREDIT_FILES_AT = CURRENT_TIMESTAMP ' +
                'WHERE DOCID = :D';
            Q.ParamByName('U').AsString := Copy(FFilesUrl, 1, 512);
            Q.ParamByName('D').AsInteger := FFinDocID;
            Q.Execute;
        finally
            Q.Free;
        end;
        CommitWrite;
    except
        RollbackWrite;
        raise;
    end;
end;

procedure TfrmFinantareEditorDlg.UploadScans(const AInteractive: Boolean);
var
    C: TECreditApiClient;
    Files: TArray<string>;
    Temp: TArray<Boolean>;
    F: string;
    IsTemp: Boolean;
    I: Integer;
    Res: TECreditUploadResult;
begin
    if (FURN = '') or not FHasEcredit or (FConfigError <> '') then
        Exit;
    // scanurile nesalvate se scriu intii in baza
    if (FScan1File <> '') or (FScan2File <> '') then
        SaveFin;
    Files := nil;
    Temp := nil;
    for I := 1 to 2 do
    begin
        F := ScanToFile(I, IsTemp);
        if F <> '' then
        begin
            Files := Files + [F];
            Temp := Temp + [IsTemp];
        end;
    end;
    if Length(Files) = 0 then
    begin
        if AInteractive then
            ShowInfoDialog('eCredit', 'Cererea nu are copia buletinului de trimis.');
        Exit;
    end;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Res := C.UploadFiles(FURN, Files);
                LogApi(C, 'FILES');
                FFilesUrl := Res.Url;
                SaveFilesUrl;
                Log('Fisiere: ' + Res.Summary);
                ShowEcreditState;
                if AInteractive then
                    ShowInfoDialog('eCredit - copia buletinului', Res.Summary);
            except
                on E: Exception do
                begin
                    LogApi(C, 'FILES', E.Message);
                    Log('Fisiere: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Copia buletinului nu a fost trimisa.', E.Message,
                        Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
            for I := 0 to High(Files) do
                if Temp[I] then
                    DeleteFile(Files[I]);
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnContractClick(Sender: TObject);
var
    C: TECreditApiClient;
    Pdf: TBytes;
    Path: string;
    F: TFileStream;
begin
    if FURN = '' then
        Exit;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Pdf := C.GetContract(FURN, 'RO');
                LogApi(C, 'CONTRACT');
                Path := TPath.Combine(TPath.GetTempPath, Format('ecredit_contract_%s.pdf', [FURN]));
                F := TFileStream.Create(Path, fmCreate);
                try
                    F.WriteBuffer(Pdf[0], Length(Pdf));
                finally
                    F.Free;
                end;
                Log(Format('Contract descarcat: %s (%d KB).', [Path, Length(Pdf) div 1024]));
                ShellExecute(0, 'open', PChar(Path), nil, nil, SW_SHOWNORMAL);
            except
                on E: Exception do
                begin
                    LogApi(C, 'CONTRACT', E.Message);
                    Log('Contract: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Contractul nu a putut fi descarcat.', E.Message, Copy(C.LastResponse, 1, 300));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

procedure TfrmFinantareEditorDlg.btnUploadScansClick(Sender: TObject);
begin
    if FURN = '' then
    begin
        ShowInfoDialog('eCredit', 'Depuneti intii cererea - fisierele se leaga de URN.');
        Exit;
    end;
    UploadScans(True);
end;

procedure TfrmFinantareEditorDlg.btnCancelReqClick(Sender: TObject);
var
    C: TECreditApiClient;
    S: TECreditStatus;
begin
    if FURN = '' then
        Exit;
    if ShowAskDialog('eCredit', Format('Anulati cererea URN %s la eCredit?', [FURN])) <> mrYes then
        Exit;
    C := CreateClient;
    try
        Screen.Cursor := crHourGlass;
        try
            try
                C.CancelRequest(FURN, Format('Anulat din WMS, oferta #%d', [FOfferDocID]));
                FReqStatus := 'Canceled';
                SaveEcreditState(False);
                LogApi(C, 'CANCEL');
                Log('Cererea a fost anulata.');
                ShowEcreditState;
                try
                    S := C.GetStatus(FURN);
                    ApplyStatus(S);
                    SaveEcreditState(False);
                except
                    on E: Exception do
                        Log('Statut: ' + E.Message);
                end;
            except
                on E: Exception do
                begin
                    LogApi(C, 'CANCEL', E.Message);
                    Log('Anulare: ' + E.Message);
                    ShowErrorDialog('eCredit', 'Cererea nu a fost anulata.', E.Message, Copy(C.LastResponse, 1, 1000));
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        C.Free;
    end;
end;

end.

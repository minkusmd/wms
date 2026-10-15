unit frmCompanyCardDialog;

(* ============================================================================
   Fisa companiei proprii / subdiviziunii - ca "Organizatii" din 1C.

   Creeaza sau editeaza o firma proprie (TS_CUSTOMER tip 4002, folderul 5209
   "COMPANII PROPRII") cu toate datele ei, intr-o singura tranzactie:
     TS_CUSTOMER        denumirea in WMS, cota TVA implicita
     TS_CUST_INFO       IDNO, cod TVA, conducator, contabil, adresele ca text, site
     TS_CUST_COMPANY    datele ASP / SFS / BNS (DB Model/company_card.sql)
     TS_CUST_ADDR       adresa juridica (7663) si fizica (7662) - folosite la tiparire
     TS_CUST_PHONES     telefonul de serviciu (7470) si mobil (7468)
     TS_CUST_EMAILS     e-mailul
     TS_CUST_ACCOUNTS   conturile bancare (+ TS_BANKS pentru o banca noua)
     TS_CUST_STAMP      logo, stampila, semnaturile olografe, stampila de garantie
     TS_CUST_1C         legatura cu 1C; DT = persoana juridica
     TS_API_CONFIG +    casa de marcat virtuala ECC Fiscal Partner a firmei
     FP_DEVICES         (DEVICE_TYPE = 1, ECC_API_CODE)
   La creare, optional: setarile documentelor copiate de la o firma-model
   (TS_DOCTYPES_DEFVALUES - fara ele site-ul si documentele nu au firma/depozit)
   si accesul utilizatorului curent (bitul firmei in TS_USERS.ACC$FIRM, pozitia
   firmei in VW_TS_FIRMS ordonat dupa CUSTOMERID, ca in GET_FIRMS_BY_USER).

   Butoanele de pe IDNO aduc datele din registre:
     SFS - Registrul fiscal prin API-ul e-Factura (denumire, adresa, cod TVA, IBAN);
     ASP - copia registrului de stat CUSTOMERS_REGISTRU (forma, data inregistrarii,
           conducator, fondatori, CAEM, CUATM; datele sint din 2021).

   Fara DB Model/company_card.sql rulat pe baza, campurile din TS_CUST_COMPANY
   sint dezactivate; restul fisei se salveaza normal.
   ============================================================================ *)

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, Data.DB, DBAccess, IBC, MemDS, System.Generics.Collections,
    SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
    cxEdit, cxClasses, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
    cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGridLevel, cxGrid, cxButtons,
    cxTextEdit, cxMaskEdit, cxButtonEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
    cxDBLookupComboBox, cxCheckBox, cxGroupBox, cxRadioGroup, cxLabel, cxMemo, cxCalendar,
    cxCurrencyEdit, cxImage, dxGDIPlusClasses, dxLayoutControl, dxLayoutContainer,
    dxLayoutLookAndFeels, dxLayoutcxEditAdapters, dxLayoutControlAdapters,
    dxScrollbarAnnotations, dxDateRanges, Vcl.Menus, ECCConfigUnit;

type
    TfrmCompanyCardDlg = class(TSWNCustomForm)
        pnButtons: TPanel;
        lblRequired: TLabel;
        btnSave: TcxButton;
        btnCancel: TcxButton;
        lcMain: TdxLayoutControl;
        lcMainGroup_Root: TdxLayoutGroup;
        grpHeader: TdxLayoutGroup;
        imgHeaderLogo: TcxImage;
        liHeaderLogo: TdxLayoutItem;
        grpHeaderText: TdxLayoutGroup;
        lblTitle: TcxLabel;
        liTitle: TdxLayoutItem;
        lblSubtitle: TcxLabel;
        liSubtitle: TdxLayoutItem;
        grpTabs: TdxLayoutGroup;
        tabGeneral: TdxLayoutGroup;
        grpKind: TdxLayoutGroup;
        cbKind: TcxComboBox;
        liKind: TdxLayoutItem;
        lcbParent: TcxLookupComboBox;
        liParent: TdxLayoutItem;
        grpGenCols: TdxLayoutGroup;
        grpIdent: TdxLayoutGroup;
        beIDNO: TcxButtonEdit;
        liIDNO: TdxLayoutItem;
        edName: TcxTextEdit;
        liName: TdxLayoutItem;
        edFullName: TcxTextEdit;
        liFullName: TdxLayoutItem;
        cbOrgForm: TcxComboBox;
        liOrgForm: TdxLayoutItem;
        deRegDate: TcxDateEdit;
        liRegDate: TdxLayoutItem;
        edRegAuthority: TcxTextEdit;
        liRegAuthority: TdxLayoutItem;
        ceCapital: TcxCurrencyEdit;
        liCapital: TdxLayoutItem;
        grpRight: TdxLayoutGroup;
        grpVat: TdxLayoutGroup;
        chkVatPayer: TcxCheckBox;
        liVatPayer: TdxLayoutItem;
        edVatCode: TcxTextEdit;
        liVatCode: TdxLayoutItem;
        deVatRegDate: TcxDateEdit;
        liVatRegDate: TdxLayoutItem;
        cbVatRate: TcxComboBox;
        liVatRate: TdxLayoutItem;
        grpManagement: TdxLayoutGroup;
        cbChiefPosition: TcxComboBox;
        liChiefPosition: TdxLayoutItem;
        edChief: TcxTextEdit;
        liChief: TdxLayoutItem;
        edAccountant: TcxTextEdit;
        liAccountant: TdxLayoutItem;
        edCashier: TcxTextEdit;
        liCashier: TdxLayoutItem;
        mmFounders: TcxMemo;
        liFounders: TdxLayoutItem;
        tabAddress: TdxLayoutGroup;
        grpAddrJ: TdxLayoutGroup;
        lcbCityJ: TcxLookupComboBox;
        liCityJ: TdxLayoutItem;
        lcbDistrictJ: TcxLookupComboBox;
        liDistrictJ: TdxLayoutItem;
        edStreetJ: TcxTextEdit;
        liStreetJ: TdxLayoutItem;
        grpAddrF: TdxLayoutGroup;
        chkSameAddress: TcxCheckBox;
        liSameAddress: TdxLayoutItem;
        lcbCityF: TcxLookupComboBox;
        liCityF: TdxLayoutItem;
        lcbDistrictF: TcxLookupComboBox;
        liDistrictF: TdxLayoutItem;
        edStreetF: TcxTextEdit;
        liStreetF: TdxLayoutItem;
        grpContacts: TdxLayoutGroup;
        edPhone: TcxTextEdit;
        liPhone: TdxLayoutItem;
        edMobile: TcxTextEdit;
        liMobile: TdxLayoutItem;
        edEmail: TcxTextEdit;
        liEmail: TdxLayoutItem;
        edWeb: TcxTextEdit;
        liWeb: TdxLayoutItem;
        tabFiscal: TdxLayoutGroup;
        grpSfs: TdxLayoutGroup;
        edSfsOffice: TcxTextEdit;
        liSfsOffice: TdxLayoutItem;
        edSubdivCode: TcxTextEdit;
        liSubdivCode: TdxLayoutItem;
        grpBns: TdxLayoutGroup;
        edCUIIO: TcxTextEdit;
        liCUIIO: TdxLayoutItem;
        edCFOJ: TcxTextEdit;
        liCFOJ: TdxLayoutItem;
        edCFP: TcxTextEdit;
        liCFP: TdxLayoutItem;
        edCUATM: TcxTextEdit;
        liCUATM: TdxLayoutItem;
        edCAEMMain: TcxTextEdit;
        liCAEMMain: TdxLayoutItem;
        mmCAEMList: TcxMemo;
        liCAEMList: TdxLayoutItem;
        tabAccounts: TdxLayoutGroup;
        grpAccButtons: TdxLayoutGroup;
        btnAccAdd: TcxButton;
        liAccAdd: TdxLayoutItem;
        btnAccDelete: TcxButton;
        liAccDelete: TdxLayoutItem;
        btnAccSfs: TcxButton;
        liAccSfs: TdxLayoutItem;
        gridAccounts: TcxGrid;
        tvAccounts: TcxGridTableView;
        colAccDefault: TcxGridColumn;
        colAccCurrent: TcxGridColumn;
        colAccName: TcxGridColumn;
        colAccIBAN: TcxGridColumn;
        colAccBank: TcxGridColumn;
        colAccBankName: TcxGridColumn;
        colAccOrig: TcxGridColumn;
        lvAccounts: TcxGridLevel;
        liAccGrid: TdxLayoutItem;
        lblAccHint: TcxLabel;
        liAccHint: TdxLayoutItem;
        tabImages: TdxLayoutGroup;
        grpImgRow0: TdxLayoutGroup;
        grpImgLogo: TdxLayoutGroup;
        imgLogo: TcxImage;
        liImgLogo: TdxLayoutItem;
        grpImgBtnLogo: TdxLayoutGroup;
        btnImgLoadLogo: TcxButton;
        liImgLoadLogo: TdxLayoutItem;
        btnImgClearLogo: TcxButton;
        liImgClearLogo: TdxLayoutItem;
        grpImgStamp: TdxLayoutGroup;
        imgStamp: TcxImage;
        liImgStamp: TdxLayoutItem;
        grpImgBtnStamp: TdxLayoutGroup;
        btnImgLoadStamp: TcxButton;
        liImgLoadStamp: TdxLayoutItem;
        btnImgClearStamp: TcxButton;
        liImgClearStamp: TdxLayoutItem;
        grpImgSignature: TdxLayoutGroup;
        imgSignature: TcxImage;
        liImgSignature: TdxLayoutItem;
        grpImgBtnSignature: TdxLayoutGroup;
        btnImgLoadSignature: TcxButton;
        liImgLoadSignature: TdxLayoutItem;
        btnImgClearSignature: TcxButton;
        liImgClearSignature: TdxLayoutItem;
        grpImgRow1: TdxLayoutGroup;
        grpImgCeoSign: TdxLayoutGroup;
        imgCeoSign: TcxImage;
        liImgCeoSign: TdxLayoutItem;
        grpImgBtnCeoSign: TdxLayoutGroup;
        btnImgLoadCeoSign: TcxButton;
        liImgLoadCeoSign: TdxLayoutItem;
        btnImgClearCeoSign: TcxButton;
        liImgClearCeoSign: TdxLayoutItem;
        grpImgAccSign: TdxLayoutGroup;
        imgAccSign: TcxImage;
        liImgAccSign: TdxLayoutItem;
        grpImgBtnAccSign: TdxLayoutGroup;
        btnImgLoadAccSign: TcxButton;
        liImgLoadAccSign: TdxLayoutItem;
        btnImgClearAccSign: TcxButton;
        liImgClearAccSign: TdxLayoutItem;
        grpImgWarranty: TdxLayoutGroup;
        imgWarranty: TcxImage;
        liImgWarranty: TdxLayoutItem;
        grpImgBtnWarranty: TdxLayoutGroup;
        btnImgLoadWarranty: TcxButton;
        liImgLoadWarranty: TdxLayoutItem;
        btnImgClearWarranty: TcxButton;
        liImgClearWarranty: TdxLayoutItem;
        lblImgHint: TcxLabel;
        liImgHint: TdxLayoutItem;
        tabSetup: TdxLayoutGroup;
        grp1C: TdxLayoutGroup;
        chk1C: TcxCheckBox;
        li1C: TdxLayoutItem;
        grp1CCols: TdxLayoutGroup;
        grp1CLeft: TdxLayoutGroup;
        ed1CFirmaCod: TcxTextEdit;
        li1CFirmaCod: TdxLayoutItem;
        ed1CFirmaName: TcxTextEdit;
        li1CFirmaName: TdxLayoutItem;
        ed1CPfCode: TcxTextEdit;
        li1CPfCode: TdxLayoutItem;
        ed1CPfTitle: TcxTextEdit;
        li1CPfTitle: TdxLayoutItem;
        grp1CRight: TdxLayoutGroup;
        ed1CSkladCod: TcxTextEdit;
        li1CSkladCod: TdxLayoutItem;
        ed1CTitle: TcxTextEdit;
        li1CTitle: TdxLayoutItem;
        cb1CType: TcxComboBox;
        li1CType: TdxLayoutItem;
        chk1CActive: TcxCheckBox;
        li1CActive: TdxLayoutItem;
        grpSetup: TdxLayoutGroup;
        chkCopyDefaults: TcxCheckBox;
        liCopyDefaults: TdxLayoutItem;
        lcbModelFirm: TcxLookupComboBox;
        liModelFirm: TdxLayoutItem;
        lcbDepot: TcxLookupComboBox;
        liDepot: TdxLayoutItem;
        chkGrantAccess: TcxCheckBox;
        liGrantAccess: TdxLayoutItem;
        tabEcc: TdxLayoutGroup;
        chkEcc: TcxCheckBox;
        liEcc: TdxLayoutItem;
        grpEccCols: TdxLayoutGroup;
        grpEccCash: TdxLayoutGroup;
        cbEccCode: TcxComboBox;
        liEccCode: TdxLayoutItem;
        cbEccServer: TcxComboBox;
        liEccServer: TdxLayoutItem;
        edEccApiKey: TcxTextEdit;
        liEccApiKey: TdxLayoutItem;
        edEccPosId: TcxTextEdit;
        liEccPosId: TdxLayoutItem;
        edEccPosName: TcxTextEdit;
        liEccPosName: TdxLayoutItem;
        edEccCashier: TcxTextEdit;
        liEccCashier: TdxLayoutItem;
        grpEccTax: TdxLayoutGroup;
        edEccTax20: TcxTextEdit;
        liEccTax20: TdxLayoutItem;
        edEccTax8: TcxTextEdit;
        liEccTax8: TdxLayoutItem;
        edEccTax0: TcxTextEdit;
        liEccTax0: TdxLayoutItem;
        edEccTaxNone: TcxTextEdit;
        liEccTaxNone: TdxLayoutItem;
        grpEccRight: TdxLayoutGroup;
        grpEccDevice: TdxLayoutGroup;
        lcbEccWorkstation: TcxLookupComboBox;
        liEccWorkstation: TdxLayoutItem;
        edEccDescription: TcxTextEdit;
        liEccDescription: TdxLayoutItem;
        chkEccEnabled: TcxCheckBox;
        liEccEnabled: TdxLayoutItem;
        grpEccTerminal: TdxLayoutGroup;
        edEccTermPosId: TcxTextEdit;
        liEccTermPosId: TdxLayoutItem;
        edEccTermPosName: TcxTextEdit;
        liEccTermPosName: TdxLayoutItem;
        edEccTermApiKey: TcxTextEdit;
        liEccTermApiKey: TdxLayoutItem;
        edEccTermTimeout: TcxTextEdit;
        liEccTermTimeout: TdxLayoutItem;
        grpEccTest: TdxLayoutGroup;
        btnEccTest: TcxButton;
        liEccTest: TdxLayoutItem;
        lblEccInfo: TcxLabel;
        liEccInfo: TdxLayoutItem;
        tabNote: TdxLayoutGroup;
        mmNote: TcxMemo;
        liNote: TdxLayoutItem;
        lafList: TdxLayoutLookAndFeelList;
        lafCx: TdxLayoutCxLookAndFeel;
        qFirms: TIBCQuery;
        dsFirms: TIBCDataSource;
        qCities: TIBCQuery;
        dsCities: TIBCDataSource;
        qDistrictJ: TIBCQuery;
        dsDistrictJ: TIBCDataSource;
        qDistrictF: TIBCQuery;
        dsDistrictF: TIBCDataSource;
        qStocks: TIBCQuery;
        dsStocks: TIBCDataSource;
        qWorkstations: TIBCQuery;
        dsWorkstations: TIBCDataSource;
        trWrite: TIBCTransaction;
        dlgOpenImage: TOpenDialog;
        procedure cbKindPropertiesChange(Sender: TObject);
        procedure lcbParentPropertiesEditValueChanged(Sender: TObject);
        procedure beIDNOPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
        procedure chkVatPayerPropertiesChange(Sender: TObject);
        procedure lcbCityJPropertiesEditValueChanged(Sender: TObject);
        procedure lcbCityFPropertiesEditValueChanged(Sender: TObject);
        procedure chkSameAddressPropertiesChange(Sender: TObject);
        procedure btnAccAddClick(Sender: TObject);
        procedure btnAccDeleteClick(Sender: TObject);
        procedure btnAccSfsClick(Sender: TObject);
        procedure colAccDefaultPropertiesEditValueChanged(Sender: TObject);
        procedure colAccBankPropertiesEditValueChanged(Sender: TObject);
        procedure imgLogoPropertiesChange(Sender: TObject);
        procedure btnImgLoadClick(Sender: TObject);
        procedure btnImgClearClick(Sender: TObject);
        procedure chk1CPropertiesChange(Sender: TObject);
        procedure chkCopyDefaultsPropertiesChange(Sender: TObject);
        procedure chkEccPropertiesChange(Sender: TObject);
        procedure cbEccCodePropertiesEditValueChanged(Sender: TObject);
        procedure btnEccTestClick(Sender: TObject);
    private
        FCustomerID: Integer;
        FDefaultKind: Integer;
        FIsNew: Boolean;
        FLoading: Boolean;
        FHasCompanyTable: Boolean;
        FHad1C: Boolean;
        FBanks: TDictionary<string, string>;
        FDeletedAccounts: TStringList;
        FAddrIdJ, FAddrIdF: Integer;
        FPhoneId, FMobileId, FEmailId: Integer;
        FEccFpId: Integer;
        FSaveWarnings: string;
        function Kind: Integer;
        function ImageControl(AIndex: Integer): TcxImage;
        function NewReadQuery: TIBCQuery;
        function NewWriteQuery: TIBCQuery;
        procedure OpenLookups;
        procedure LoadBanks;
        procedure LoadCompany;
        procedure LoadAddresses;
        procedure LoadContacts;
        procedure LoadAccounts;
        procedure LoadImages;
        procedure Load1C;
        procedure LoadEcc;
        procedure LoadEccParams(const ACode: string);
        procedure ReopenDistricts(AQuery: TIBCQuery; const ACityID: Variant);
        procedure UpdateKindState;
        procedure UpdateHeader;
        procedure UpdateVatState;
        procedure UpdateAddressState;
        procedure Update1CState;
        procedure UpdateEccState;
        procedure UpdateEccSharedInfo;
        procedure DisableCompanyFields;
        function AccountRowByIBAN(const AIBAN: string): Integer;
        function AddAccountRow(const AName, AIBAN, ABank, ABankName: string; ADefault, ACurrent: Boolean;
            const AOrig: string = ''): Integer;
        function HasDefaultAccount: Boolean;
        procedure ApplySfs(AOnlyAccounts: Boolean);
        procedure ApplyAsp;
        function ValidateData: Boolean;
        procedure Fail(const AText: string; ATab: TdxLayoutGroup; AControl: TWinControl);
        function EccConfigFromForm: TECCConfig;
        function EccCode: string;
        function SaveAll: Boolean;
        procedure SaveCustomer(Q: TIBCQuery);
        procedure SaveInfo(Q: TIBCQuery);
        procedure SaveCompany(Q: TIBCQuery);
        procedure SaveAddress(Q: TIBCQuery; ATypeID: Integer; var AAddrID: Integer; ACity, ADistrict: TcxLookupComboBox;
            AStreet: TcxTextEdit);
        procedure SavePhone(Q: TIBCQuery; ATypeID: Integer; var APhoneID: Integer; const ANumber: string);
        procedure SaveEmail(Q: TIBCQuery);
        procedure SaveAccounts(Q: TIBCQuery);
        procedure SaveImages(Q: TIBCQuery);
        procedure Save1C(Q: TIBCQuery);
        procedure SaveEcc(Q: TIBCQuery);
        procedure SaveDefaults(Q: TIBCQuery);
        procedure SaveAccess(Q: TIBCQuery);
    protected
        procedure Prepare; override;
        function IsFormDataPosted: Boolean; override;
        procedure WhenCancelForm; override;
    public
        destructor Destroy; override;
        // 0 = companie noua; ADefaultKind: 1 persoana juridica, 2 subdiviziune, 3 intreprinzator.
        // Intoarce CUSTOMERID-ul salvat sau 0 la Renunta.
        class function Execute(AOwner: TComponent; ACustomerID: Integer = 0; ADefaultKind: Integer = 1): Integer;
        property CustomerID: Integer read FCustomerID;
    end;

implementation

uses
    System.UITypes, System.StrUtils, System.Math, DataModuleDB, SWNUtils, RegistryAddressUnit,
    EFacturaApiClient, EFacturaManager, ECCApiClient;

{$R *.dfm}

const
    cFirmsFolderID = 5209;          // TS_CUSTOMER "COMPANII PROPRII"
    cCustomerTypeFirm = 4002;       // Companii proprii
    cCustomerStatusRegular = 4101;
    cCountryMoldova = 6515;
    cPhoneTypeWork = 7470;          // Telefon de serviciu
    cPhoneTypeMobile = 7468;        // Telefon mobil
    cFlagsBuyer = 8;                // TS_CUSTOMER.FLAGS bit 3 = cumparator, ca la firmele noi

    // parametrii casei ECC in TS_API_CONFIG (vezi ECCConfigUnit)
    cEccParams: array[0..12] of string = ('BASE_URL', 'API_KEY', 'POS_ID', 'POS_NAME', 'CASHIER_NAME',
        'TAX_20', 'TAX_8', 'TAX_0', 'TAX_NONE',
        'TERMINAL_POS_ID', 'TERMINAL_POS_NAME', 'TERMINAL_API_KEY', 'TERMINAL_TIMEOUT_SEC');

{ --- utilitare ---------------------------------------------------------------- }

function VarIsBlank(const V: Variant): Boolean;
begin
    Result := VarIsNull(V) or VarIsEmpty(V) or (VarIsStr(V) and (Trim(VarToStr(V)) = ''));
end;

function EditText(AEdit: TcxCustomEdit): string;
begin
    Result := Trim(VarToStr(AEdit.EditValue));
end;

function VarBool(const V: Variant): Boolean;
begin
    Result := not VarIsBlank(V) and Boolean(V);
end;

function NullIfBlank(const V: Variant): Variant;
begin
    if VarIsBlank(V) then
        Result := Null
    else
        Result := V;
end;

procedure SetStr(Q: TIBCQuery; const AName, AValue: string);
var
    P: TIBCParam;
begin
    P := Q.ParamByName(AName);
    P.DataType := ftWideString;
    if Trim(AValue) = '' then
        P.Value := Null
    else
        P.AsWideString := Trim(AValue);
end;

procedure SetInt(Q: TIBCQuery; const AName: string; const AValue: Variant);
var
    P: TIBCParam;
begin
    P := Q.ParamByName(AName);
    P.DataType := ftInteger;
    if VarIsBlank(AValue) then
        P.Value := Null
    else
        P.AsInteger := AValue;
end;

procedure SetDate(Q: TIBCQuery; const AName: string; const AValue: Variant);
var
    P: TIBCParam;
begin
    P := Q.ParamByName(AName);
    P.DataType := ftDate;
    if VarIsBlank(AValue) then
        P.Value := Null
    else
        P.AsDate := VarToDateTime(AValue);
end;

procedure SetFloat(Q: TIBCQuery; const AName: string; const AValue: Variant);
var
    P: TIBCParam;
begin
    P := Q.ParamByName(AName);
    P.DataType := ftFloat;
    if VarIsBlank(AValue) then
        P.Value := Null
    else
        P.AsFloat := AValue;
end;

procedure RunSQL(Q: TIBCQuery; const ASQL: string);
begin
    Q.Close;
    Q.SQL.Text := ASQL;
end;

{ IBAN dupa ISO 13616: litere + cifre, primele 4 caractere mutate la sfirsit, literele
  inlocuite cu 10..35, restul impartirii la 97 trebuie sa fie 1. }
function IsValidIBAN(const AIBAN: string; out AError: string): Boolean;
var
    S, R: string;
    C: Char;
    M, I: Integer;
begin
    AError := '';
    S := UpperCase(StringReplace(AIBAN, ' ', '', [rfReplaceAll]));
    if (Length(S) < 15) or (Length(S) > 34) then
        AError := 'lungimea nu e de IBAN'
    else if (Copy(S, 1, 2) = 'MD') and (Length(S) <> 24) then
        AError := 'un IBAN din Moldova are 24 de caractere'
    else
    begin
        R := Copy(S, 5, MaxInt) + Copy(S, 1, 4);
        M := 0;
        for C in R do
        begin
            case C of
                '0'..'9': I := Ord(C) - Ord('0');
                'A'..'Z': I := Ord(C) - Ord('A') + 10;
            else
                AError := 'caracter nepermis: ' + C;
                Exit(False);
            end;
            if I >= 10 then
                M := (M * 100 + I) mod 97
            else
                M := (M * 10 + I) mod 97;
        end;
        if M <> 1 then
            AError := 'cifrele de control nu corespund';
    end;
    Result := AError = '';
end;

function LooksLikeIBAN(const S: string): Boolean;
begin
    Result := (Length(Trim(S)) >= 2) and CharInSet(UpCase(Trim(S)[1]), ['A'..'Z']) and
        CharInSet(UpCase(Trim(S)[2]), ['A'..'Z']);
end;

procedure BlobToImage(AField: TField; AImage: TcxImage);
var
    MS: TMemoryStream;
    Img: TdxSmartImage;
begin
    AImage.Picture.Assign(nil);
    if AField.IsNull then
        Exit;
    MS := TMemoryStream.Create;
    Img := TdxSmartImage.Create;
    try
        TBlobField(AField).SaveToStream(MS);
        MS.Position := 0;
        try
            Img.LoadFromStream(MS);
            AImage.Picture.Assign(Img);
        except
            // imagine intr-un format necunoscut: ramine goala, nu blocheaza fisa
        end;
    finally
        Img.Free;
        MS.Free;
    end;
end;

procedure ImageToParam(AImage: TcxImage; Q: TIBCQuery; const AName: string);
var
    MS: TMemoryStream;
    G: TGraphic;
begin
    G := AImage.Picture.Graphic;
    if (G = nil) or G.Empty then
    begin
        Q.ParamByName(AName).DataType := ftBlob;
        Q.ParamByName(AName).Value := Null;
        Exit;
    end;
    MS := TMemoryStream.Create;
    try
        G.SaveToStream(MS);
        MS.Position := 0;
        Q.ParamByName(AName).LoadFromStream(MS, ftBlob);
    finally
        MS.Free;
    end;
end;

{ TfrmCompanyCardDlg }

class function TfrmCompanyCardDlg.Execute(AOwner: TComponent; ACustomerID, ADefaultKind: Integer): Integer;
var
    Dlg: TfrmCompanyCardDlg;
begin
    Result := 0;
    Dlg := TfrmCompanyCardDlg.Create(AOwner);
    try
        Dlg.FCustomerID := ACustomerID;
        Dlg.FDefaultKind := EnsureRange(ADefaultKind, 1, 3);
        if Dlg.ShowModal = mrOk then
            Result := Dlg.FCustomerID;
    finally
        Dlg.Free;
    end;
end;

destructor TfrmCompanyCardDlg.Destroy;
begin
    FBanks.Free;
    FDeletedAccounts.Free;
    inherited;
end;

function TfrmCompanyCardDlg.NewReadQuery: TIBCQuery;
begin
    Result := TIBCQuery.Create(nil);
    Result.Connection := dmDB.IBCConnection;
    Result.Transaction := dmDB.IBCTrDefaultSelect;
end;

function TfrmCompanyCardDlg.NewWriteQuery: TIBCQuery;
begin
    Result := TIBCQuery.Create(nil);
    Result.Connection := dmDB.IBCConnection;
    Result.Transaction := trWrite;
    Result.UpdateTransaction := trWrite;
    Result.AutoCommit := False;
end;

function TfrmCompanyCardDlg.Kind: Integer;
begin
    Result := EnsureRange(cbKind.ItemIndex + 1, 1, 3);
end;

function TfrmCompanyCardDlg.ImageControl(AIndex: Integer): TcxImage;
begin
    case AIndex of
        0: Result := imgLogo;
        1: Result := imgStamp;
        2: Result := imgSignature;
        3: Result := imgCeoSign;
        4: Result := imgAccSign;
    else
        Result := imgWarranty;
    end;
end;

procedure TfrmCompanyCardDlg.Prepare;
var
    Q: TIBCQuery;
begin
    inherited;
    FBanks := TDictionary<string, string>.Create;
    FDeletedAccounts := TStringList.Create;
    FIsNew := FCustomerID <= 0;
    FLoading := True;
    try
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ''TS_CUST_COMPANY''';
            Q.Open;
            FHasCompanyTable := Q.Fields[0].AsInteger > 0;
        finally
            Q.Free;
        end;

        OpenLookups;
        LoadBanks;

        grpSetup.Visible := FIsNew;
        if FIsNew then
        begin
            Caption := 'Companie / subdiviziune noua';
            cbKind.ItemIndex := FDefaultKind - 1;
            cbVatRate.Text := '20';
            chkVatPayer.Checked := True;
            chkEccEnabled.Checked := True;
            edEccTax20.Text := 'A';
            edEccTax8.Text := 'B';
            edEccTax0.Text := 'D';
            edEccTaxNone.Text := '_';
            chk1CActive.Checked := True;
            chkCopyDefaults.Checked := True;
            chkGrantAccess.Checked := True;
            if dmDB.CurrentFirma > 0 then
                lcbModelFirm.EditValue := dmDB.CurrentFirma;
            lcbCityJ.EditValue := cCityChisinau;
            ReopenDistricts(qDistrictJ, cCityChisinau);
        end
        else
        begin
            LoadCompany;
            LoadAddresses;
            LoadContacts;
            LoadAccounts;
            LoadImages;
            Load1C;
            LoadEcc;
        end;
    finally
        FLoading := False;
    end;

    liEccCode.CaptionOptions.Text := 'Codul casei (gol = ECC_<cod firma>)';
    imgLogoPropertiesChange(nil);
    if not FHasCompanyTable then
        DisableCompanyFields;
    UpdateKindState;
    UpdateVatState;
    UpdateAddressState;
    Update1CState;
    UpdateEccState;
    UpdateHeader;
    grpTabs.ItemIndex := 0;
end;

procedure TfrmCompanyCardDlg.OpenLookups;
var
    Q: TIBCQuery;
begin
    for Q in TArray<TIBCQuery>.Create(qFirms, qCities, qStocks, qWorkstations) do
    begin
        Q.Connection := dmDB.IBCConnection;
        Q.Transaction := dmDB.IBCTrDefaultSelect;
        Q.Open;
    end;
    for Q in TArray<TIBCQuery>.Create(qDistrictJ, qDistrictF) do
    begin
        Q.Connection := dmDB.IBCConnection;
        Q.Transaction := dmDB.IBCTrDefaultSelect;
    end;

    // tipurile de depozit folosite deja in 1C (texte libere)
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT DISTINCT TRIM(TYPE) FROM TS_CUST_1C WHERE COALESCE(TRIM(TYPE), '''') <> ''''';
        Q.Open;
        while not Q.Eof do
        begin
            cb1CType.Properties.Items.Add(Q.Fields[0].AsString);
            Q.Next;
        end;
    finally
        Q.Free;
    end;

    for var Code in ListECCApiCodes(dmDB.IBCConnection) do
        if not SameText(Code, 'ECC_ONLINE') then
            cbEccCode.Properties.Items.Add(Code);
end;

procedure TfrmCompanyCardDlg.LoadBanks;
var
    Q: TIBCQuery;
    Items: TStrings;
begin
    Items := (colAccBank.Properties as TcxComboBoxProperties).Items;
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT TRIM(BANKACCOUNT), BANKNAME FROM TS_BANKS';
        Q.Open;
        while not Q.Eof do
        begin
            FBanks.AddOrSetValue(UpperCase(Q.Fields[0].AsString), Trim(Q.Fields[1].AsString));
            Items.Add(UpperCase(Q.Fields[0].AsString));
            Q.Next;
        end;
    finally
        Q.Free;
    end;
end;

procedure TfrmCompanyCardDlg.ReopenDistricts(AQuery: TIBCQuery; const ACityID: Variant);
begin
    AQuery.Close;
    if VarIsBlank(ACityID) then
        Exit;
    AQuery.ParamByName('CITYID').AsInteger := ACityID;
    AQuery.Open;
end;

procedure TfrmCompanyCardDlg.LoadCompany;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT C.NAME, C.VAT, C.CUSTOMER_TYPE_ID, C.FLG_FOLDER, I.CHIEF, I.ACCOUNTANT, ' +
            'I.IDEN_NUMBER, I.VAT_NUMBER, I.WEBPAGE FROM TS_CUSTOMER C ' +
            'LEFT JOIN TS_CUST_INFO I ON I.CUSTOMERID = C.CUSTOMERID WHERE C.CUSTOMERID = :ID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        if Q.IsEmpty then
            raise Exception.CreateFmt('Firma %d nu exista.', [FCustomerID]);
        if (Q.FieldByName('CUSTOMER_TYPE_ID').AsInteger <> cCustomerTypeFirm) or
            (Q.FieldByName('FLG_FOLDER').AsInteger <> 0) then
            raise Exception.CreateFmt('%d nu e o companie proprie (tip 4002).', [FCustomerID]);

        Caption := 'Fisa companiei - ' + Trim(Q.FieldByName('NAME').AsString);
        edName.Text := Trim(Q.FieldByName('NAME').AsString);
        cbVatRate.Text := IntToStr(Q.FieldByName('VAT').AsInteger);
        beIDNO.Text := Trim(Q.FieldByName('IDEN_NUMBER').AsString);
        edVatCode.Text := Trim(Q.FieldByName('VAT_NUMBER').AsString);
        chkVatPayer.Checked := edVatCode.Text <> '';
        edChief.Text := Trim(Q.FieldByName('CHIEF').AsString);
        edAccountant.Text := Trim(Q.FieldByName('ACCOUNTANT').AsString);
        edWeb.Text := Trim(Q.FieldByName('WEBPAGE').AsString);
        Q.Close;

        if FHasCompanyTable then
        begin
            Q.SQL.Text := 'SELECT * FROM TS_CUST_COMPANY WHERE CUSTOMERID = :ID';
            Q.ParamByName('ID').AsInteger := FCustomerID;
            Q.Open;
            if not Q.IsEmpty then
            begin
                cbKind.ItemIndex := EnsureRange(Q.FieldByName('COMPANY_KIND').AsInteger, 1, 3) - 1;
                lcbParent.EditValue := Q.FieldByName('PARENT_FIRMAID').Value;
                edFullName.Text := Q.FieldByName('FULL_NAME').AsString;
                cbOrgForm.Text := Q.FieldByName('ORG_FORM').AsString;
                edCFOJ.Text := Q.FieldByName('CFOJ').AsString;
                edCFP.Text := Q.FieldByName('CFP').AsString;
                edCAEMMain.Text := Q.FieldByName('CAEM_MAIN').AsString;
                mmCAEMList.Text := Q.FieldByName('CAEM_LIST').AsString;
                edCUATM.Text := Q.FieldByName('CUATM').AsString;
                edCUIIO.Text := Q.FieldByName('CUIIO').AsString;
                deRegDate.EditValue := Q.FieldByName('REG_DATE').Value;
                edRegAuthority.Text := Q.FieldByName('REG_AUTHORITY').AsString;
                chkVatPayer.Checked := Q.FieldByName('VAT_PAYER').AsInteger = 1;
                deVatRegDate.EditValue := Q.FieldByName('VAT_REG_DATE').Value;
                edSfsOffice.Text := Q.FieldByName('SFS_OFFICE').AsString;
                edSubdivCode.Text := Q.FieldByName('SUBDIV_CODE').AsString;
                ceCapital.EditValue := Q.FieldByName('CAPITAL_SOCIAL').Value;
                mmFounders.Text := Q.FieldByName('FOUNDERS').AsString;
                cbChiefPosition.Text := Q.FieldByName('CHIEF_POSITION').AsString;
                edCashier.Text := Q.FieldByName('CASHIER').AsString;
                mmNote.Text := Q.FieldByName('NOTE').AsString;
            end;
        end;
    finally
        Q.Free;
    end;
end;

procedure TfrmCompanyCardDlg.LoadAddresses;

    procedure LoadOne(ATypeID: Integer; var AAddrID: Integer; ACity, ADistrict: TcxLookupComboBox;
        AStreet: TcxTextEdit; ADistrictQuery: TIBCQuery);
    var
        Q: TIBCQuery;
    begin
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT FIRST 1 ADDRID, CITYID, DISTRICTID, STREET FROM TS_CUST_ADDR ' +
                'WHERE CUSTOMERID = :ID AND ADDRTYPEID = :T ORDER BY ADDRID';
            Q.ParamByName('ID').AsInteger := FCustomerID;
            Q.ParamByName('T').AsInteger := ATypeID;
            Q.Open;
            if Q.IsEmpty then
                Exit;
            AAddrID := Q.FieldByName('ADDRID').AsInteger;
            ACity.EditValue := NullIfBlank(Q.FieldByName('CITYID').Value);
            ReopenDistricts(ADistrictQuery, ACity.EditValue);
            if Q.FieldByName('DISTRICTID').AsInteger > 0 then
                ADistrict.EditValue := Q.FieldByName('DISTRICTID').AsInteger;
            AStreet.Text := Trim(Q.FieldByName('STREET').AsString);
        finally
            Q.Free;
        end;
    end;

var
    Q: TIBCQuery;
begin
    LoadOne(cAddrTypeJuridic, FAddrIdJ, lcbCityJ, lcbDistrictJ, edStreetJ, qDistrictJ);
    LoadOne(cAddrTypeFizic, FAddrIdF, lcbCityF, lcbDistrictF, edStreetF, qDistrictF);

    // firmele vechi au adresa doar ca text in TS_CUST_INFO (ADDRESS2 = juridica, ADDRESS = fizica)
    if (FAddrIdJ = 0) or (FAddrIdF = 0) then
    begin
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT ADDRESS, ADDRESS2 FROM TS_CUST_INFO WHERE CUSTOMERID = :ID';
            Q.ParamByName('ID').AsInteger := FCustomerID;
            Q.Open;
            if (FAddrIdJ = 0) and (Trim(Q.Fields[1].AsString) <> '') then
                edStreetJ.Text := Trim(Q.Fields[1].AsString);
            if (FAddrIdF = 0) and (Trim(Q.Fields[0].AsString) <> '') then
                edStreetF.Text := Trim(Q.Fields[0].AsString);
        finally
            Q.Free;
        end;
    end;

    chkSameAddress.Checked := (VarToStr(lcbCityJ.EditValue) = VarToStr(lcbCityF.EditValue)) and
        (VarToStr(lcbDistrictJ.EditValue) = VarToStr(lcbDistrictF.EditValue)) and
        SameText(edStreetJ.Text, edStreetF.Text) and (edStreetJ.Text <> '');
end;

procedure TfrmCompanyCardDlg.LoadContacts;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT PHONEID, PHONENUMBER, PHONETYPEID FROM TS_CUST_PHONES WHERE CUSTOMERID = :ID ' +
            'AND PHONETYPEID IN (:T1, :T2) ORDER BY PHONEID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.ParamByName('T1').AsInteger := cPhoneTypeWork;
        Q.ParamByName('T2').AsInteger := cPhoneTypeMobile;
        Q.Open;
        while not Q.Eof do
        begin
            if (Q.Fields[2].AsInteger = cPhoneTypeWork) and (FPhoneId = 0) then
            begin
                FPhoneId := Q.Fields[0].AsInteger;
                edPhone.Text := Trim(Q.Fields[1].AsString);
            end
            else if (Q.Fields[2].AsInteger = cPhoneTypeMobile) and (FMobileId = 0) then
            begin
                FMobileId := Q.Fields[0].AsInteger;
                edMobile.Text := Trim(Q.Fields[1].AsString);
            end;
            Q.Next;
        end;
        Q.Close;
        Q.SQL.Text := 'SELECT FIRST 1 ID, EMAIL FROM TS_CUST_EMAILS WHERE CUSTOMERID = :ID ORDER BY ID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        if not Q.IsEmpty then
        begin
            FEmailId := Q.Fields[0].AsInteger;
            edEmail.Text := Trim(Q.Fields[1].AsString);
        end;
    finally
        Q.Free;
    end;
end;

function TfrmCompanyCardDlg.AddAccountRow(const AName, AIBAN, ABank, ABankName: string;
    ADefault, ACurrent: Boolean; const AOrig: string): Integer;
var
    DC: TcxCustomDataController;
begin
    DC := tvAccounts.DataController;
    Result := DC.AppendRecord;
    DC.Values[Result, colAccDefault.Index] := ADefault;
    DC.Values[Result, colAccCurrent.Index] := ACurrent;
    DC.Values[Result, colAccName.Index] := AName;
    DC.Values[Result, colAccIBAN.Index] := AIBAN;
    DC.Values[Result, colAccBank.Index] := ABank;
    DC.Values[Result, colAccBankName.Index] := ABankName;
    DC.Values[Result, colAccOrig.Index] := AOrig;
end;

procedure TfrmCompanyCardDlg.LoadAccounts;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    tvAccounts.DataController.BeginUpdate;
    try
        Q.SQL.Text := 'SELECT A.ACCOUNTNUMBER, A.ACCOUNTNAME, A.BANKACCOUNT, A.DEFAULT_ACCOUNT, A.FLG_CONT_CURENT, ' +
            'B.BANKNAME FROM TS_CUST_ACCOUNTS A LEFT JOIN TS_BANKS B ON B.BANKACCOUNT = A.BANKACCOUNT ' +
            'WHERE A.CUSTOMERID = :ID ORDER BY A.DEFAULT_ACCOUNT DESC, A.FLG_CONT_CURENT DESC, A.ACCOUNTNUMBER';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        while not Q.Eof do
        begin
            // ACCOUNTNUMBER e cheia: valoarea initiala, cu spatiile de la sfirsit, ramine in colAccOrig
            AddAccountRow(Trim(Q.FieldByName('ACCOUNTNAME').AsString), Trim(Q.FieldByName('ACCOUNTNUMBER').AsString),
                UpperCase(Trim(Q.FieldByName('BANKACCOUNT').AsString)), Trim(Q.FieldByName('BANKNAME').AsString),
                Q.FieldByName('DEFAULT_ACCOUNT').AsInteger = 1, Q.FieldByName('FLG_CONT_CURENT').AsInteger = 1,
                Q.FieldByName('ACCOUNTNUMBER').AsString);
            Q.Next;
        end;
    finally
        tvAccounts.DataController.EndUpdate;
        Q.Free;
    end;
end;

procedure TfrmCompanyCardDlg.LoadImages;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT LOGO, STAMP_IMAGE, SIGNATURE, CEO_SIGN, ACCOUNTANT_SIGN, WARRANTY_STAMP ' +
            'FROM TS_CUST_STAMP WHERE CUSTOMERID = :ID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        if Q.IsEmpty then
            Exit;
        BlobToImage(Q.FieldByName('LOGO'), imgLogo);
        BlobToImage(Q.FieldByName('STAMP_IMAGE'), imgStamp);
        BlobToImage(Q.FieldByName('SIGNATURE'), imgSignature);
        BlobToImage(Q.FieldByName('CEO_SIGN'), imgCeoSign);
        BlobToImage(Q.FieldByName('ACCOUNTANT_SIGN'), imgAccSign);
        BlobToImage(Q.FieldByName('WARRANTY_STAMP'), imgWarranty);
    finally
        Q.Free;
    end;
    imgLogoPropertiesChange(nil);
end;

procedure TfrmCompanyCardDlg.Load1C;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT * FROM TS_CUST_1C WHERE CUSTOMERID = :ID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        FHad1C := not Q.IsEmpty;
        chk1C.Checked := FHad1C;
        if not FHad1C then
            Exit;
        ed1CFirmaCod.Text := Trim(Q.FieldByName('FIRMA_COD').AsString);
        ed1CSkladCod.Text := Trim(Q.FieldByName('SKLAD_COD').AsString);
        ed1CTitle.Text := Trim(Q.FieldByName('TITLE').AsString);
        cb1CType.Text := Trim(Q.FieldByName('TYPE').AsString);
        ed1CFirmaName.Text := Trim(Q.FieldByName('FIRMA_NAME').AsString);
        ed1CPfCode.Text := Trim(Q.FieldByName('PERS_FIZ_CODE').AsString);
        ed1CPfTitle.Text := Trim(Q.FieldByName('PERS_FIZ_TITLE').AsString);
        chk1CActive.Checked := Q.FieldByName('FLAGS').AsInteger = 1;
        // subdiviziune fara fisa TS_CUST_COMPANY: firma-mama din legatura 1C
        if (Q.FieldByName('DT').AsInteger > 0) and (Q.FieldByName('DT').AsInteger <> FCustomerID) and
            VarIsBlank(lcbParent.EditValue) then
        begin
            cbKind.ItemIndex := 1;
            lcbParent.EditValue := Q.FieldByName('DT').AsInteger;
        end;
    finally
        Q.Free;
    end;
end;

procedure TfrmCompanyCardDlg.LoadEcc;
var
    Q: TIBCQuery;
begin
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT FIRST 1 FP_ID, WS_ID, DESCRIPTION, FLG_ENABLED, ECC_API_CODE FROM FP_DEVICES ' +
            'WHERE FIRMA_ID = :ID AND DEVICE_TYPE = 1 ORDER BY FLG_ENABLED DESC, FP_ID';
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.Open;
        if Q.IsEmpty then
            Exit;
        FEccFpId := Q.FieldByName('FP_ID').AsInteger;
        chkEcc.Checked := Q.FieldByName('FLG_ENABLED').AsInteger = 1;
        chkEccEnabled.Checked := Q.FieldByName('FLG_ENABLED').AsInteger = 1;
        lcbEccWorkstation.EditValue := NullIfBlank(Q.FieldByName('WS_ID').Value);
        edEccDescription.Text := Trim(Q.FieldByName('DESCRIPTION').AsString);
        cbEccCode.Text := UpperCase(Trim(Q.FieldByName('ECC_API_CODE').AsString));
    finally
        Q.Free;
    end;
    LoadEccParams(cbEccCode.Text);
end;

procedure TfrmCompanyCardDlg.LoadEccParams(const ACode: string);
var
    Q: TIBCQuery;
    Name, Value: string;
begin
    if Trim(ACode) = '' then
        Exit;
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG WHERE API_CODE = :C AND FLG_ACTIVE = 1';
        Q.ParamByName('C').AsString := UpperCase(Trim(ACode));
        Q.Open;
        if Q.IsEmpty then
            Exit;   // cod nou: valorile introduse raman
        for var E in TArray<TcxCustomEdit>.Create(cbEccServer, edEccApiKey, edEccPosId, edEccPosName, edEccCashier,
            edEccTax20, edEccTax8, edEccTax0, edEccTaxNone, edEccTermPosId, edEccTermPosName, edEccTermApiKey,
            edEccTermTimeout) do
            E.EditValue := Null;
        while not Q.Eof do
        begin
            Name := UpperCase(Trim(Q.Fields[0].AsString));
            Value := Trim(Q.Fields[1].AsString);
            if Name = 'BASE_URL' then cbEccServer.Text := Value
            else if Name = 'API_KEY' then edEccApiKey.Text := Value
            else if Name = 'POS_ID' then edEccPosId.Text := Value
            else if Name = 'POS_NAME' then edEccPosName.Text := Value
            else if Name = 'CASHIER_NAME' then edEccCashier.Text := Value
            else if Name = 'TAX_20' then edEccTax20.Text := Value
            else if Name = 'TAX_8' then edEccTax8.Text := Value
            else if Name = 'TAX_0' then edEccTax0.Text := Value
            else if Name = 'TAX_NONE' then edEccTaxNone.Text := Value
            else if Name = 'TERMINAL_POS_ID' then edEccTermPosId.Text := Value
            else if Name = 'TERMINAL_POS_NAME' then edEccTermPosName.Text := Value
            else if Name = 'TERMINAL_API_KEY' then edEccTermApiKey.Text := Value
            else if Name = 'TERMINAL_TIMEOUT_SEC' then edEccTermTimeout.Text := Value;
            Q.Next;
        end;
    finally
        Q.Free;
    end;
end;

{ --- starea controalelor --------------------------------------------------- }

procedure TfrmCompanyCardDlg.DisableCompanyFields;
begin
    // fara TS_CUST_COMPANY (DB Model/company_card.sql nerulat) aceste date nu au unde sa se salveze
    for var C in TArray<TControl>.Create(cbKind, lcbParent, edFullName, cbOrgForm, deRegDate, edRegAuthority,
        ceCapital, deVatRegDate, cbChiefPosition, edCashier, mmFounders, edSfsOffice, edSubdivCode, edCUIIO, edCFOJ,
        edCFP, edCUATM, edCAEMMain, mmCAEMList, mmNote) do
        C.Enabled := False;
    lblSubtitle.Caption := 'Datele de la fisc si statistica se vor salva dupa rularea DB Model/company_card.sql';
    lblSubtitle.Style.TextColor := clRed;
end;

procedure TfrmCompanyCardDlg.UpdateKindState;
var
    IsSub: Boolean;
begin
    IsSub := Kind = 2;
    lcbParent.Enabled := IsSub and FHasCompanyTable;
    edSubdivCode.Enabled := IsSub and FHasCompanyTable;
    if (Kind = 3) and (cbOrgForm.Text = '') then
        cbOrgForm.Text := 'Intreprindere individuala';
    UpdateHeader;
end;

procedure TfrmCompanyCardDlg.UpdateHeader;
var
    S: string;
begin
    if Trim(edName.Text) <> '' then
        lblTitle.Caption := Trim(edName.Text)
    else if Kind = 2 then
        lblTitle.Caption := 'Subdiviziune noua'
    else
        lblTitle.Caption := 'Companie noua';
    if not FHasCompanyTable then
        Exit;   // subtitlul arata avertismentul
    S := '';
    if Trim(beIDNO.Text) <> '' then
        S := 'IDNO ' + Trim(beIDNO.Text);
    if chkVatPayer.Checked and (Trim(edVatCode.Text) <> '') then
        S := IfThen(S = '', '', S + '   |   ') + 'Cod TVA ' + Trim(edVatCode.Text)
    else if not chkVatPayer.Checked then
        S := IfThen(S = '', '', S + '   |   ') + 'neplatitor de TVA';
    if (Kind = 2) and not VarIsBlank(lcbParent.EditValue) then
        S := IfThen(S = '', '', S + '   |   ') + 'subdiviziune a ' + lcbParent.Text;
    if not FIsNew then
        S := IfThen(S = '', '', S + '   |   ') + 'cod WMS ' + IntToStr(FCustomerID);
    if S = '' then
        S := 'Introduceti IDNO si apasati SFS / ASP: datele se completeaza din registre';
    lblSubtitle.Caption := S;
end;

procedure TfrmCompanyCardDlg.UpdateVatState;
begin
    edVatCode.Enabled := chkVatPayer.Checked;
    deVatRegDate.Enabled := chkVatPayer.Checked and FHasCompanyTable;
end;

procedure TfrmCompanyCardDlg.UpdateAddressState;
var
    Own: Boolean;
begin
    Own := not chkSameAddress.Checked;
    lcbCityF.Enabled := Own;
    lcbDistrictF.Enabled := Own;
    edStreetF.Enabled := Own;
end;

procedure TfrmCompanyCardDlg.Update1CState;
begin
    // o legatura existenta nu se sterge din fisa (o folosesc rapoartele si exportul)
    chk1C.Enabled := not FHad1C;
    for var C in TArray<TControl>.Create(ed1CFirmaCod, ed1CFirmaName, ed1CPfCode, ed1CPfTitle, ed1CSkladCod,
        ed1CTitle, cb1CType, chk1CActive) do
        C.Enabled := chk1C.Checked;
end;

procedure TfrmCompanyCardDlg.UpdateEccState;
begin
    for var C in TArray<TControl>.Create(cbEccCode, cbEccServer, edEccApiKey, edEccPosId, edEccPosName, edEccCashier,
        edEccTax20, edEccTax8, edEccTax0, edEccTaxNone, lcbEccWorkstation, edEccDescription, chkEccEnabled,
        edEccTermPosId, edEccTermPosName, edEccTermApiKey, edEccTermTimeout) do
        C.Enabled := chkEcc.Checked;
    btnEccTest.Enabled := chkEcc.Checked;
    UpdateEccSharedInfo;
end;

procedure TfrmCompanyCardDlg.UpdateEccSharedInfo;
var
    Q: TIBCQuery;
    Others: string;
begin
    Others := '';
    if chkEcc.Checked and (EccCode <> '') then
    begin
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT DISTINCT C.DISPLAYNAME FROM FP_DEVICES D JOIN TS_CUSTOMER C ON C.CUSTOMERID = D.FIRMA_ID ' +
                'WHERE UPPER(TRIM(D.ECC_API_CODE)) = :C AND D.FIRMA_ID <> :ID';
            Q.ParamByName('C').AsString := EccCode;
            Q.ParamByName('ID').AsInteger := FCustomerID;
            Q.Open;
            while not Q.Eof do
            begin
                Others := IfThen(Others = '', '', Others + ', ') + Trim(Q.Fields[0].AsString);
                Q.Next;
            end;
        finally
            Q.Free;
        end;
    end;
    if Others <> '' then
    begin
        lblEccInfo.Caption := Format('Atentie: casa %s e folosita si de %s. Parametrii casei sint comuni - ' +
            'modificarea lor se aplica si acolo.', [EccCode, Others]);
        lblEccInfo.Style.TextColor := clRed;
    end
    else
    begin
        lblEccInfo.Caption := 'Bonurile din facturi, POS, platile online (@ECC_ONLINE) si livrarile (@ECC_DELIVERY) ' +
            'folosesc casa ECC a firmei din FP_DEVICES. Cheia API se ia din BackOffice ECC > API/Keys.';
        lblEccInfo.Style.TextColor := clGrayText;
    end;
end;

{ --- evenimente ------------------------------------------------------------ }

procedure TfrmCompanyCardDlg.cbKindPropertiesChange(Sender: TObject);
begin
    if not FLoading then
        UpdateKindState;
end;

procedure TfrmCompanyCardDlg.lcbParentPropertiesEditValueChanged(Sender: TObject);
var
    Q: TIBCQuery;
begin
    if FLoading or VarIsBlank(lcbParent.EditValue) then
        Exit;
    // subdiviziunea are IDNO-ul si codul TVA al persoanei juridice
    if (Trim(beIDNO.Text) = '') or (Trim(edVatCode.Text) = '') then
    begin
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT IDEN_NUMBER, VAT_NUMBER FROM TS_CUST_INFO WHERE CUSTOMERID = :ID';
            Q.ParamByName('ID').AsInteger := lcbParent.EditValue;
            Q.Open;
            if not Q.IsEmpty then
            begin
                if Trim(beIDNO.Text) = '' then
                    beIDNO.Text := Trim(Q.Fields[0].AsString);
                if Trim(edVatCode.Text) = '' then
                begin
                    edVatCode.Text := Trim(Q.Fields[1].AsString);
                    chkVatPayer.Checked := edVatCode.Text <> '';
                end;
            end;
        finally
            Q.Free;
        end;
    end;
    if FIsNew and VarIsBlank(lcbModelFirm.EditValue) then
        lcbModelFirm.EditValue := lcbParent.EditValue;
    UpdateHeader;
end;

procedure TfrmCompanyCardDlg.chkVatPayerPropertiesChange(Sender: TObject);
begin
    if FLoading then
        Exit;
    UpdateVatState;
    if chkVatPayer.Checked and (cbVatRate.Text = '0') then
        cbVatRate.Text := '20'
    else if not chkVatPayer.Checked then
        cbVatRate.Text := '0';
    UpdateHeader;
end;

procedure TfrmCompanyCardDlg.lcbCityJPropertiesEditValueChanged(Sender: TObject);
begin
    ReopenDistricts(qDistrictJ, lcbCityJ.EditValue);
    if not FLoading then
        lcbDistrictJ.EditValue := Null;
end;

procedure TfrmCompanyCardDlg.lcbCityFPropertiesEditValueChanged(Sender: TObject);
begin
    ReopenDistricts(qDistrictF, lcbCityF.EditValue);
    if not FLoading then
        lcbDistrictF.EditValue := Null;
end;

procedure TfrmCompanyCardDlg.chkSameAddressPropertiesChange(Sender: TObject);
begin
    UpdateAddressState;
end;

procedure TfrmCompanyCardDlg.chk1CPropertiesChange(Sender: TObject);
begin
    if FLoading then
        Exit;
    if chk1C.Checked then
    begin
        if Trim(ed1CFirmaName.Text) = '' then
            ed1CFirmaName.Text := Copy(Trim(edName.Text), 1, 50);
        if Trim(ed1CTitle.Text) = '' then
            ed1CTitle.Text := Copy(Trim(edName.Text), 1, 50);
    end;
    Update1CState;
end;

procedure TfrmCompanyCardDlg.chkCopyDefaultsPropertiesChange(Sender: TObject);
begin
    lcbModelFirm.Enabled := chkCopyDefaults.Checked;
    lcbDepot.Enabled := chkCopyDefaults.Checked;
end;

procedure TfrmCompanyCardDlg.chkEccPropertiesChange(Sender: TObject);
begin
    if FLoading then
        Exit;
    if chkEcc.Checked and (cbEccServer.Text = '') then
        cbEccServer.Text := 'https://sc.fiscalpartner.md';
    if chkEcc.Checked and not FIsNew and (FEccFpId = 0) then
        chkEccEnabled.Checked := True;
    UpdateEccState;
end;

procedure TfrmCompanyCardDlg.cbEccCodePropertiesEditValueChanged(Sender: TObject);
begin
    if FLoading then
        Exit;
    LoadEccParams(EccCode);
    UpdateEccSharedInfo;
end;

procedure TfrmCompanyCardDlg.imgLogoPropertiesChange(Sender: TObject);
begin
    imgHeaderLogo.Picture.Assign(imgLogo.Picture);
    liHeaderLogo.Visible := (imgLogo.Picture.Graphic <> nil) and not imgLogo.Picture.Graphic.Empty;
end;

procedure TfrmCompanyCardDlg.btnImgLoadClick(Sender: TObject);
var
    Img: TdxSmartImage;
begin
    if not dlgOpenImage.Execute(Handle) then
        Exit;
    Img := TdxSmartImage.Create;
    try
        try
            Img.LoadFromFile(dlgOpenImage.FileName);
        except
            on E: Exception do
            begin
                ShowErrorDialog('Imaginea nu poate fi citita', E.Message);
                Exit;
            end;
        end;
        ImageControl(TComponent(Sender).Tag).Picture.Assign(Img);
    finally
        Img.Free;
    end;
    if TComponent(Sender).Tag = 0 then
        imgLogoPropertiesChange(nil);
end;

procedure TfrmCompanyCardDlg.btnImgClearClick(Sender: TObject);
begin
    ImageControl(TComponent(Sender).Tag).Picture.Assign(nil);
    if TComponent(Sender).Tag = 0 then
        imgLogoPropertiesChange(nil);
end;

{ --- conturi bancare ------------------------------------------------------- }

function TfrmCompanyCardDlg.AccountRowByIBAN(const AIBAN: string): Integer;
var
    I: Integer;
    DC: TcxCustomDataController;
begin
    Result := -1;
    DC := tvAccounts.DataController;
    for I := 0 to DC.RecordCount - 1 do
        if SameText(Trim(VarToStr(DC.Values[I, colAccIBAN.Index])), Trim(AIBAN)) then
            Exit(I);
end;

function TfrmCompanyCardDlg.HasDefaultAccount: Boolean;
var
    I: Integer;
    DC: TcxCustomDataController;
begin
    Result := False;
    DC := tvAccounts.DataController;
    for I := 0 to DC.RecordCount - 1 do
        if VarBool(DC.Values[I, colAccDefault.Index]) then
            Exit(True);
end;

procedure TfrmCompanyCardDlg.btnAccAddClick(Sender: TObject);
var
    R: Integer;
begin
    tvAccounts.DataController.PostEditingData;
    R := AddAccountRow('Cont curent', '', '', '', not HasDefaultAccount, True);
    tvAccounts.DataController.FocusedRecordIndex := R;
    gridAccounts.SetFocus;
    colAccIBAN.Focused := True;
    tvAccounts.Controller.EditingController.ShowEdit;
end;

procedure TfrmCompanyCardDlg.btnAccDeleteClick(Sender: TObject);
var
    R: Integer;
    Orig: string;
    DC: TcxCustomDataController;
begin
    DC := tvAccounts.DataController;
    DC.PostEditingData;
    R := DC.FocusedRecordIndex;
    if R < 0 then
        Exit;
    if ShowAskDialog('Contul bancar', 'Stergeti contul ' + VarToStr(DC.Values[R, colAccIBAN.Index]) + '?',
        'Contul se sterge din fisa la salvare.') <> mrYes then
        Exit;
    Orig := VarToStr(DC.Values[R, colAccOrig.Index]);
    if Orig <> '' then
        FDeletedAccounts.Add(Orig);
    DC.DeleteRecord(R);
end;

procedure TfrmCompanyCardDlg.btnAccSfsClick(Sender: TObject);
begin
    ApplySfs(True);
end;

procedure TfrmCompanyCardDlg.colAccDefaultPropertiesEditValueChanged(Sender: TObject);
var
    I, R: Integer;
    DC: TcxCustomDataController;
begin
    // un singur cont implicit, ca in triggerul TRG_TS_CUST_ACCOUNTS_BIU0
    if not VarBool(TcxCustomEdit(Sender).EditValue) then
        Exit;
    DC := tvAccounts.DataController;
    R := DC.FocusedRecordIndex;
    for I := 0 to DC.RecordCount - 1 do
        if I <> R then
            DC.Values[I, colAccDefault.Index] := False;
end;

procedure TfrmCompanyCardDlg.colAccBankPropertiesEditValueChanged(Sender: TObject);
var
    Code, Name: string;
    R: Integer;
begin
    Code := UpperCase(Trim(VarToStr(TcxCustomEdit(Sender).EditValue)));
    R := tvAccounts.DataController.FocusedRecordIndex;
    if (R >= 0) and FBanks.TryGetValue(Code, Name) then
        tvAccounts.DataController.Values[R, colAccBankName.Index] := Name;
end;

{ --- registrele ------------------------------------------------------------ }

procedure TfrmCompanyCardDlg.beIDNOPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
    if AButtonIndex = 0 then
        ApplySfs(False)
    else
        ApplyAsp;
end;

{ Valorile aduse din registre: cimpurile goale se completeaza direct; cele completate
  deja si diferite se inlocuiesc doar dupa confirmare (o singura intrebare). }
type
    TPendingValue = record
        Edit: TcxCustomEdit;
        Value: Variant;
        Caption: string;
    end;

procedure ApplyPending(const AValues: TArray<TPendingValue>; const ATitle, ASource: string);
var
    P: TPendingValue;
    Diff: string;
    Replace: Boolean;
begin
    Diff := '';
    for P in AValues do
        if not VarIsBlank(P.Edit.EditValue) and not VarIsBlank(P.Value) and
            not SameText(Trim(VarToStr(P.Edit.EditValue)), Trim(VarToStr(P.Value))) then
            Diff := Diff + #13#10 + '- ' + P.Caption + ': ' + Trim(VarToStr(P.Value));
    Replace := (Diff <> '') and (ShowAskDialog(ATitle,
        'Inlocuiti valorile deja completate cu cele din ' + ASource + '?',
        'Cimpurile goale se completeaza oricum. Valori diferite:' + Diff) = mrYes);
    for P in AValues do
        if not VarIsBlank(P.Value) and (VarIsBlank(P.Edit.EditValue) or Replace) then
            P.Edit.EditValue := P.Value;
end;

function Pending(AEdit: TcxCustomEdit; const AValue: Variant; const ACaption: string): TPendingValue;
begin
    Result.Edit := AEdit;
    Result.Value := AValue;
    Result.Caption := ACaption;
end;

procedure TfrmCompanyCardDlg.ApplySfs(AOnlyAccounts: Boolean);
var
    Manager: TEFacturaManager;
    Taxpayer: TEFacturaTaxpayer;
    Accounts: TEFacturaBankAccounts;
    Acc: TEFacturaBankAccount;
    IDNO, BankName, Added: string;
    Addr: TRegistryAddress;
    Values: TArray<TPendingValue>;
    Found: Boolean;
begin
    IDNO := Trim(beIDNO.Text);
    if IDNO = '' then
    begin
        Fail('Introduceti IDNO-ul (codul fiscal), apoi cereti datele din SFS.', tabGeneral, beIDNO);
        Exit;
    end;

    Manager := TEFacturaManager.Create(dmDB.IBCConnection);
    try
        Screen.Cursor := crHourGlass;
        try
            try
                Found := Manager.GetCompanyInfo(IDNO, dmDB.CurrentFirma, Taxpayer, Accounts);
            except
                on E: Exception do
                begin
                    Screen.Cursor := crDefault;
                    ShowErrorDialog('Registrul fiscal (SFS)', E.Message);
                    Exit;
                end;
            end;
        finally
            Screen.Cursor := crDefault;
        end;
    finally
        Manager.Free;
    end;
    if not Found then
    begin
        ShowInfoDialog('Registrul fiscal (SFS)', 'Codul fiscal ' + IDNO + ' nu a fost gasit in Registrul fiscal.');
        Exit;
    end;

    if not AOnlyAccounts then
    begin
        FLoading := True;
        try
            Values := [Pending(edName, RegistryNameToWMS(Taxpayer.Name), 'denumirea in WMS'),
                Pending(edFullName, Trim(Taxpayer.Name), 'denumirea completa'),
                Pending(edVatCode, Trim(Taxpayer.CodTVA), 'codul TVA')];
            Addr := ParseRegistryAddress(Taxpayer.Address);
            if Addr.CityID > 0 then
                Values := Values + [Pending(lcbCityJ, Addr.CityID, 'localitatea juridica')];
            Values := Values + [Pending(edStreetJ, Addr.Street, 'adresa juridica')];
            ApplyPending(Values, 'Registrul fiscal (SFS)', 'Registrul fiscal');
            ReopenDistricts(qDistrictJ, lcbCityJ.EditValue);
            if (Addr.DistrictID > 0) and (VarToStr(lcbCityJ.EditValue) = IntToStr(Addr.CityID)) then
                lcbDistrictJ.EditValue := Addr.DistrictID;
            chkVatPayer.Checked := Trim(edVatCode.Text) <> '';
            if not chkVatPayer.Checked then
                cbVatRate.Text := '0';
        finally
            FLoading := False;
        end;
        UpdateVatState;
    end;

    // conturile IBAN inregistrate la SFS care lipsesc din lista
    Added := '';
    tvAccounts.DataController.PostEditingData;
    for Acc in Accounts do
    begin
        if (Trim(Acc.AccountNumber) = '') or (AccountRowByIBAN(Acc.AccountNumber) >= 0) then
            Continue;
        if not FBanks.TryGetValue(UpperCase(Trim(Acc.BranchCode)), BankName) then
            BankName := Trim(Acc.BranchTitle);
        AddAccountRow('Cont curent', UpperCase(Trim(Acc.AccountNumber)), UpperCase(Trim(Acc.BranchCode)), BankName,
            not HasDefaultAccount, True);
        Added := Added + #13#10 + Trim(Acc.AccountNumber) + ' (' + BankName + ')';
    end;

    UpdateHeader;
    if Added <> '' then
        ShowInfoDialog('Registrul fiscal (SFS)', 'Conturi adaugate in fisa (se salveaza cu Salveaza):' + Added)
    else if AOnlyAccounts then
        ShowInfoDialog('Registrul fiscal (SFS)', 'Toate conturile inregistrate la SFS sint deja in lista.');
end;

procedure TfrmCompanyCardDlg.ApplyAsp;
var
    Q: TIBCQuery;
    IDNO, Director, Position, Caem: string;
    P1, P2: Integer;
    Addr: TRegistryAddress;
    Values: TArray<TPendingValue>;
    Codes: TArray<string>;
    RegDate: Variant;
    D: TDateTime;
begin
    IDNO := Trim(beIDNO.Text);
    if IDNO = '' then
    begin
        Fail('Introduceti IDNO-ul, apoi cereti datele din registrul ASP.', tabGeneral, beIDNO);
        Exit;
    end;
    Q := NewReadQuery;
    try
        Q.SQL.Text := 'SELECT FIRST 1 * FROM CUSTOMERS_REGISTRU WHERE IDNO = :IDNO ORDER BY DATA DESC';
        Q.ParamByName('IDNO').AsString := IDNO;
        Q.Open;
        if Q.IsEmpty then
        begin
            ShowInfoDialog('Registrul de stat (ASP)', 'IDNO ' + IDNO + ' nu e in copia registrului din baza ' +
                '(CUSTOMERS_REGISTRU, actualizata ultima data in 2021). Folositi butonul SFS.');
            Exit;
        end;

        // 'MINCHEVICI SERGIU [Administrator]' -> nume + functie
        Director := Trim(Q.FieldByName('DIRECTOR').AsString);
        P1 := Pos(',', Director);
        if P1 > 0 then
            Director := Trim(Copy(Director, 1, P1 - 1));
        Position := '';
        P1 := Pos('[', Director);
        P2 := Pos(']', Director);
        if (P1 > 0) and (P2 > P1) then
        begin
            Position := Trim(Copy(Director, P1 + 1, P2 - P1 - 1));
            Director := Trim(Copy(Director, 1, P1 - 1));
        end;

        // I = activitatile (coduri CAEM, prima e cea principala); J = licentele
        Caem := Trim(Q.FieldByName('I').AsString);
        Codes := Caem.Split([','], TStringSplitOptions.ExcludeEmpty);

        RegDate := Null;
        if not Q.FieldByName('DATA').IsNull then
            RegDate := Q.FieldByName('DATA').AsDateTime
        else if TryStrToDate(Q.FieldByName('CREATED_DATE').AsString, D,
            TFormatSettings.Create('ro-RO')) then
            RegDate := D;

        Addr := ParseAspAddress(Q.FieldByName('ADRESS').AsString);

        FLoading := True;
        try
            Values := [Pending(edFullName, Trim(Q.FieldByName('FULL_NAME').AsString), 'denumirea completa'),
                Pending(cbOrgForm, Trim(Q.FieldByName('ORG_TYPE').AsString), 'forma organizatorico-juridica'),
                Pending(deRegDate, RegDate, 'data inregistrarii'),
                Pending(edChief, Copy(Director, 1, 32), 'conducatorul'),
                Pending(cbChiefPosition, Position, 'functia conducatorului'),
                Pending(mmFounders, Copy(Trim(Q.FieldByName('FONDATORI').AsString), 1, 4000), 'fondatorii'),
                Pending(edCUATM, Trim(Q.FieldByName('F').AsString), 'CUATM'),
                Pending(mmCAEMList, Copy(Caem, 1, 2000), 'activitatile CAEM'),
                Pending(edRegAuthority, 'Agentia Servicii Publice', 'organul de inregistrare')];
            if Length(Codes) > 0 then
                Values := Values + [Pending(edCAEMMain, Trim(Codes[0]), 'CAEM principal')];
            if Addr.CityID > 0 then
                Values := Values + [Pending(lcbCityJ, Addr.CityID, 'localitatea juridica')];
            Values := Values + [Pending(edStreetJ, Addr.Street, 'adresa juridica')];
            if Trim(edName.Text) = '' then
                Values := Values + [Pending(edName, RegistryNameToWMS(Q.FieldByName('FULL_NAME').AsString),
                    'denumirea in WMS')];
            ApplyPending(Values, 'Registrul de stat (ASP)', Format('registrul ASP (copia din %s)',
                [FormatDateTime('dd.mm.yyyy', Q.FieldByName('DATA').AsDateTime)]));
            ReopenDistricts(qDistrictJ, lcbCityJ.EditValue);
            if (Addr.DistrictID > 0) and (VarToStr(lcbCityJ.EditValue) = IntToStr(Addr.CityID)) then
                lcbDistrictJ.EditValue := Addr.DistrictID;
        finally
            FLoading := False;
        end;
    finally
        Q.Free;
    end;
    UpdateHeader;
end;

{ --- validare -------------------------------------------------------------- }

procedure TfrmCompanyCardDlg.Fail(const AText: string; ATab: TdxLayoutGroup; AControl: TWinControl);
begin
    if ATab <> nil then
        grpTabs.ItemIndex := ATab.Index;
    ShowErrorDialog('Fisa companiei', AText);
    if (AControl <> nil) and AControl.CanFocus then
        AControl.SetFocus;
end;

function TfrmCompanyCardDlg.EccCode: string;
begin
    Result := UpperCase(Trim(cbEccCode.Text));
end;

function TfrmCompanyCardDlg.EccConfigFromForm: TECCConfig;
begin
    Result := Default(TECCConfig);
    Result.ApiCode := IfThen(EccCode = '', 'ECC_NOU', EccCode);
    Result.BaseURL := Trim(cbEccServer.Text);
    Result.ApiKey := Trim(edEccApiKey.Text);
    Result.PosId := Trim(edEccPosId.Text);
    Result.PosName := Trim(edEccPosName.Text);
    Result.CashierName := Trim(edEccCashier.Text);
end;

function TfrmCompanyCardDlg.ValidateData: Boolean;
var
    I, Defaults: Integer;
    DC: TcxCustomDataController;
    IBAN, Bank, Err, Dup: string;
    Seen: TStringList;
    Q: TIBCQuery;
begin
    Result := False;
    tvAccounts.DataController.PostEditingData;

    if Trim(edName.Text) = '' then
    begin
        Fail('Indicati denumirea firmei in WMS.', tabGeneral, edName);
        Exit;
    end;
    if Trim(beIDNO.Text) = '' then
    begin
        Fail('Indicati IDNO-ul (codul fiscal). Subdiviziunea are IDNO-ul persoanei juridice.', tabGeneral, beIDNO);
        Exit;
    end;
    for I := 1 to Length(Trim(beIDNO.Text)) do
        if not CharInSet(Trim(beIDNO.Text)[I], ['0'..'9']) then
        begin
            Fail('IDNO-ul are doar cifre.', tabGeneral, beIDNO);
            Exit;
        end;
    if (Kind <> 2) and (Length(Trim(beIDNO.Text)) <> 13) and (FIsNew) then
    begin
        Fail('IDNO-ul unei persoane juridice sau al unui intreprinzator are 13 cifre.', tabGeneral, beIDNO);
        Exit;
    end;
    if (Kind = 2) and FHasCompanyTable and VarIsBlank(lcbParent.EditValue) then
    begin
        Fail('Alegeti persoana juridica careia ii apartine subdiviziunea.', tabGeneral, lcbParent);
        Exit;
    end;
    if (Kind = 2) and not VarIsBlank(lcbParent.EditValue) and (lcbParent.EditValue = FCustomerID) then
    begin
        Fail('Subdiviziunea nu poate fi propria firma-mama.', tabGeneral, lcbParent);
        Exit;
    end;
    if chkVatPayer.Checked and (Trim(edVatCode.Text) = '') then
    begin
        Fail('Indicati codul TVA sau debifati "Platitor de TVA".', tabGeneral, edVatCode);
        Exit;
    end;
    if chkSameAddress.Checked and (Trim(edStreetJ.Text) = '') then
    begin
        Fail('Adresa juridica e goala - completati-o sau debifati "Coincide cu adresa juridica".', tabAddress, edStreetJ);
        Exit;
    end;

    // conturile bancare
    DC := tvAccounts.DataController;
    Defaults := 0;
    Seen := TStringList.Create;
    try
        for I := 0 to DC.RecordCount - 1 do
        begin
            IBAN := UpperCase(StringReplace(Trim(VarToStr(DC.Values[I, colAccIBAN.Index])), ' ', '', [rfReplaceAll]));
            Bank := UpperCase(Trim(VarToStr(DC.Values[I, colAccBank.Index])));
            DC.FocusedRecordIndex := I;
            if IBAN = '' then
            begin
                Fail('Contul din rindul ' + IntToStr(I + 1) + ' nu are IBAN.', tabAccounts, gridAccounts);
                Exit;
            end;
            // conturile vechi (17532124610119) raman; un IBAN se verifica dupa cifrele de control
            if LooksLikeIBAN(IBAN) and not IsValidIBAN(IBAN, Err) then
            begin
                Fail(Format('IBAN gresit %s: %s.', [IBAN, Err]), tabAccounts, gridAccounts);
                Exit;
            end;
            if Seen.IndexOf(IBAN) >= 0 then
            begin
                Fail('Contul ' + IBAN + ' apare de doua ori.', tabAccounts, gridAccounts);
                Exit;
            end;
            Seen.Add(IBAN);
            if Bank = '' then
            begin
                Fail('Indicati codul bancii pentru contul ' + IBAN + '.', tabAccounts, gridAccounts);
                Exit;
            end;
            if not FBanks.ContainsKey(Bank) and (Trim(VarToStr(DC.Values[I, colAccBankName.Index])) = '') then
            begin
                Fail('Banca ' + Bank + ' e noua: scrieti denumirea ei in coloana "Banca".', tabAccounts, gridAccounts);
                Exit;
            end;
            if Trim(VarToStr(DC.Values[I, colAccName.Index])) = '' then
                DC.Values[I, colAccName.Index] := 'Cont curent';
            if VarBool(DC.Values[I, colAccDefault.Index]) then
                Inc(Defaults);
        end;
    finally
        Seen.Free;
    end;
    if (DC.RecordCount > 0) and (Defaults = 0) then
        DC.Values[0, colAccDefault.Index] := True;

    // legatura 1C: toate cimpurile tabelei sint NOT NULL
    if chk1C.Checked and ((Trim(ed1CFirmaCod.Text) = '') or (Trim(ed1CSkladCod.Text) = '') or
        (Trim(ed1CPfCode.Text) = '')) then
    begin
        Fail('Pentru legatura cu 1C completati codurile organizatiei, depozitului si persoanei fizice.',
            tabSetup, ed1CFirmaCod);
        Exit;
    end;

    // casa ECC
    if chkEcc.Checked then
    begin
        if not StartsText('https://', Trim(cbEccServer.Text)) then
        begin
            Fail('Serverul ECC incepe cu https:// (productie: https://sc.fiscalpartner.md).', tabEcc, cbEccServer);
            Exit;
        end;
        Err := EccConfigFromForm.Validate;
        if Err <> '' then
        begin
            Fail(StringReplace(Err, ' in Setari > Configurari API', '', []), tabEcc, edEccApiKey);
            Exit;
        end;
        if (Trim(edEccTermTimeout.Text) <> '') and (StrToIntDef(Trim(edEccTermTimeout.Text), 0) <= 0) then
        begin
            Fail('Asteptarea platii la terminal se da in secunde (implicit 180).', tabEcc, edEccTermTimeout);
            Exit;
        end;
    end;

    if FIsNew and chkCopyDefaults.Checked and VarIsBlank(lcbModelFirm.EditValue) then
    begin
        Fail('Alegeti firma-model de la care se copiaza setarile documentelor.', tabSetup, lcbModelFirm);
        Exit;
    end;

    // alta persoana juridica proprie cu acelasi IDNO (subdiviziunile il au in comun)
    if Kind <> 2 then
    begin
        Dup := '';
        Q := NewReadQuery;
        try
            Q.SQL.Text := 'SELECT C.DISPLAYNAME FROM TS_CUSTOMER C JOIN TS_CUST_INFO I ON I.CUSTOMERID = C.CUSTOMERID ' +
                'WHERE C.CUSTOMER_TYPE_ID = 4002 AND C.FLG_FOLDER = 0 AND C.CUSTOMERID <> :ID AND TRIM(I.IDEN_NUMBER) = :IDNO';
            if FHasCompanyTable then
                Q.SQL.Text := Q.SQL.Text + ' AND NOT EXISTS (SELECT 1 FROM TS_CUST_COMPANY F ' +
                    'WHERE F.CUSTOMERID = C.CUSTOMERID AND F.COMPANY_KIND = 2)';
            Q.ParamByName('ID').AsInteger := FCustomerID;
            Q.ParamByName('IDNO').AsString := Trim(beIDNO.Text);
            Q.Open;
            while not Q.Eof do
            begin
                Dup := Dup + #13#10 + '- ' + Trim(Q.Fields[0].AsString);
                Q.Next;
            end;
        finally
            Q.Free;
        end;
        if (Dup <> '') and (ShowAskDialog('Fisa companiei', 'IDNO ' + Trim(beIDNO.Text) +
            ' il au deja alte companii proprii. Salvati totusi?',
            'Daca e o subdiviziune, alegeti tipul "Subdiviziune".' + Dup) <> mrYes) then
            Exit;
    end;
    Result := True;
end;

{ --- salvare --------------------------------------------------------------- }

procedure TfrmCompanyCardDlg.SaveCustomer(Q: TIBCQuery);
begin
    if FIsNew then
    begin
        RunSQL(Q, 'SELECT NEXT VALUE FOR SQ_TS_CUSTOMER_CUSTOMERID FROM RDB$DATABASE');
        Q.Open;
        FCustomerID := Q.Fields[0].AsInteger;
        Q.Close;
        RunSQL(Q, 'INSERT INTO TS_CUSTOMER (CUSTOMERID, PARENTID, FLG_FOLDER, PREFIXNAME, NAME, CUSTOMER_TYPE_ID, ' +
            'CUSTOMER_STATUS_ID, VAT, ORDERNO, FLAGS) VALUES (:ID, :PARENTID, 0, '''', :NAME, :TYPEID, :STATUSID, ' +
            ':VAT, 0, :FLAGS)');
        Q.ParamByName('PARENTID').AsInteger := cFirmsFolderID;
        Q.ParamByName('TYPEID').AsInteger := cCustomerTypeFirm;
        Q.ParamByName('STATUSID').AsInteger := cCustomerStatusRegular;
        Q.ParamByName('FLAGS').AsInteger := cFlagsBuyer;
    end
    else
        RunSQL(Q, 'UPDATE TS_CUSTOMER SET NAME = :NAME, VAT = :VAT WHERE CUSTOMERID = :ID');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    SetStr(Q, 'NAME', edName.Text);
    Q.ParamByName('VAT').AsInteger := StrToIntDef(cbVatRate.Text, 20);
    Q.Execute;
end;

function AddressText(ACity, ADistrict: TcxLookupComboBox; AStreet: TcxTextEdit): string;
begin
    Result := '';
    if not VarIsBlank(ACity.EditValue) then
        Result := Trim(ACity.Text);
    if not VarIsBlank(ADistrict.EditValue) then
        Result := IfThen(Result = '', '', Result + ', ') + Trim(ADistrict.Text);
    if Trim(AStreet.Text) <> '' then
        Result := IfThen(Result = '', '', Result + ', ') + Trim(AStreet.Text);
    Result := Copy(Result, 1, 255);
end;

procedure TfrmCompanyCardDlg.SaveInfo(Q: TIBCQuery);
begin
    RunSQL(Q, 'UPDATE OR INSERT INTO TS_CUST_INFO (CUSTOMERID, CHIEF, ACCOUNTANT, IDEN_NUMBER, VAT_NUMBER, ' +
        'ADDRESS, ADDRESS2, WEBPAGE) VALUES (:ID, :CHIEF, :ACCOUNTANT, :IDNO, :VAT_NUMBER, :ADDRESS, :ADDRESS2, ' +
        ':WEBPAGE) MATCHING (CUSTOMERID)');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    SetStr(Q, 'CHIEF', edChief.Text);
    SetStr(Q, 'ACCOUNTANT', edAccountant.Text);
    SetStr(Q, 'IDNO', beIDNO.Text);
    if chkVatPayer.Checked then
        SetStr(Q, 'VAT_NUMBER', edVatCode.Text)
    else
        SetStr(Q, 'VAT_NUMBER', '');
    // ca in fisa clientului: ADDRESS = adresa fizica, ADDRESS2 = cea juridica (text)
    if chkSameAddress.Checked then
        SetStr(Q, 'ADDRESS', AddressText(lcbCityJ, lcbDistrictJ, edStreetJ))
    else
        SetStr(Q, 'ADDRESS', AddressText(lcbCityF, lcbDistrictF, edStreetF));
    SetStr(Q, 'ADDRESS2', AddressText(lcbCityJ, lcbDistrictJ, edStreetJ));
    SetStr(Q, 'WEBPAGE', edWeb.Text);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveCompany(Q: TIBCQuery);
begin
    if not FHasCompanyTable then
        Exit;
    RunSQL(Q, 'UPDATE OR INSERT INTO TS_CUST_COMPANY (CUSTOMERID, COMPANY_KIND, PARENT_FIRMAID, FULL_NAME, ORG_FORM, ' +
        'CFOJ, CFP, CAEM_MAIN, CAEM_LIST, CUATM, CUIIO, REG_DATE, REG_AUTHORITY, VAT_PAYER, VAT_REG_DATE, SFS_OFFICE, ' +
        'SUBDIV_CODE, CAPITAL_SOCIAL, FOUNDERS, CHIEF_POSITION, CASHIER, NOTE) VALUES (:ID, :KIND, :PARENT, :FULL_NAME, ' +
        ':ORG_FORM, :CFOJ, :CFP, :CAEM_MAIN, :CAEM_LIST, :CUATM, :CUIIO, :REG_DATE, :REG_AUTHORITY, :VAT_PAYER, ' +
        ':VAT_REG_DATE, :SFS_OFFICE, :SUBDIV_CODE, :CAPITAL, :FOUNDERS, :CHIEF_POSITION, :CASHIER, :NOTE) ' +
        'MATCHING (CUSTOMERID)');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    Q.ParamByName('KIND').AsInteger := Kind;
    if Kind = 2 then
        SetInt(Q, 'PARENT', lcbParent.EditValue)
    else
        SetInt(Q, 'PARENT', Null);
    SetStr(Q, 'FULL_NAME', edFullName.Text);
    SetStr(Q, 'ORG_FORM', cbOrgForm.Text);
    SetStr(Q, 'CFOJ', edCFOJ.Text);
    SetStr(Q, 'CFP', edCFP.Text);
    SetStr(Q, 'CAEM_MAIN', edCAEMMain.Text);
    SetStr(Q, 'CAEM_LIST', mmCAEMList.Text);
    SetStr(Q, 'CUATM', edCUATM.Text);
    SetStr(Q, 'CUIIO', edCUIIO.Text);
    SetDate(Q, 'REG_DATE', deRegDate.EditValue);
    SetStr(Q, 'REG_AUTHORITY', edRegAuthority.Text);
    Q.ParamByName('VAT_PAYER').AsInteger := IfThen(chkVatPayer.Checked, 1, 0);
    if chkVatPayer.Checked then
        SetDate(Q, 'VAT_REG_DATE', deVatRegDate.EditValue)
    else
        SetDate(Q, 'VAT_REG_DATE', Null);
    SetStr(Q, 'SFS_OFFICE', edSfsOffice.Text);
    SetStr(Q, 'SUBDIV_CODE', IfThen(Kind = 2, edSubdivCode.Text, ''));
    SetFloat(Q, 'CAPITAL', ceCapital.EditValue);
    SetStr(Q, 'FOUNDERS', mmFounders.Text);
    SetStr(Q, 'CHIEF_POSITION', cbChiefPosition.Text);
    SetStr(Q, 'CASHIER', edCashier.Text);
    SetStr(Q, 'NOTE', mmNote.Text);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveAddress(Q: TIBCQuery; ATypeID: Integer; var AAddrID: Integer;
    ACity, ADistrict: TcxLookupComboBox; AStreet: TcxTextEdit);
begin
    if VarIsBlank(ACity.EditValue) and (Trim(AStreet.Text) = '') then
    begin
        if AAddrID > 0 then
        begin
            RunSQL(Q, 'DELETE FROM TS_CUST_ADDR WHERE ADDRID = :ADDRID');
            Q.ParamByName('ADDRID').AsInteger := AAddrID;
            Q.Execute;
            AAddrID := 0;
        end;
        Exit;
    end;
    if AAddrID > 0 then
    begin
        RunSQL(Q, 'UPDATE TS_CUST_ADDR SET CITYID = :CITYID, DISTRICTID = :DISTRICTID, STREET = :STREET ' +
            'WHERE ADDRID = :ADDRID');
        Q.ParamByName('ADDRID').AsInteger := AAddrID;
    end
    else
    begin
        RunSQL(Q, 'INSERT INTO TS_CUST_ADDR (CUSTOMERID, ADDRTYPEID, COUNTRYID, CITYID, DISTRICTID, STREET) ' +
            'VALUES (:ID, :TYPEID, :COUNTRYID, :CITYID, :DISTRICTID, :STREET)');
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.ParamByName('TYPEID').AsInteger := ATypeID;
        Q.ParamByName('COUNTRYID').AsInteger := cCountryMoldova;
    end;
    SetInt(Q, 'CITYID', ACity.EditValue);
    // -1 = fara sector, ca in restul adreselor din TS_CUST_ADDR
    if VarIsBlank(ADistrict.EditValue) then
        SetInt(Q, 'DISTRICTID', -1)
    else
        SetInt(Q, 'DISTRICTID', ADistrict.EditValue);
    SetStr(Q, 'STREET', AStreet.Text);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SavePhone(Q: TIBCQuery; ATypeID: Integer; var APhoneID: Integer; const ANumber: string);
begin
    if Trim(ANumber) = '' then
    begin
        if APhoneID > 0 then
        begin
            RunSQL(Q, 'DELETE FROM TS_CUST_PHONES WHERE PHONEID = :PHONEID');
            Q.ParamByName('PHONEID').AsInteger := APhoneID;
            Q.Execute;
            APhoneID := 0;
        end;
        Exit;
    end;
    if APhoneID > 0 then
    begin
        RunSQL(Q, 'UPDATE TS_CUST_PHONES SET PHONENUMBER = :NUM WHERE PHONEID = :PHONEID');
        Q.ParamByName('PHONEID').AsInteger := APhoneID;
    end
    else
    begin
        RunSQL(Q, 'INSERT INTO TS_CUST_PHONES (CUSTOMERID, PHONENUMBER, PHONETYPEID) VALUES (:ID, :NUM, :TYPEID)');
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.ParamByName('TYPEID').AsInteger := ATypeID;
    end;
    SetStr(Q, 'NUM', ANumber);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveEmail(Q: TIBCQuery);
begin
    if Trim(edEmail.Text) = '' then
    begin
        if FEmailId > 0 then
        begin
            RunSQL(Q, 'DELETE FROM TS_CUST_EMAILS WHERE ID = :EID');
            Q.ParamByName('EID').AsInteger := FEmailId;
            Q.Execute;
            FEmailId := 0;
        end;
        Exit;
    end;
    if FEmailId > 0 then
    begin
        RunSQL(Q, 'UPDATE TS_CUST_EMAILS SET EMAIL = :EMAIL WHERE ID = :EID');
        Q.ParamByName('EID').AsInteger := FEmailId;
    end
    else
    begin
        RunSQL(Q, 'INSERT INTO TS_CUST_EMAILS (CUSTOMERID, EMAIL) VALUES (:ID, :EMAIL)');
        Q.ParamByName('ID').AsInteger := FCustomerID;
    end;
    SetStr(Q, 'EMAIL', edEmail.Text);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveAccounts(Q: TIBCQuery);
var
    I, Pass: Integer;
    DC: TcxCustomDataController;
    IBAN, Orig, Bank, BankName: string;
    IsDefault: Boolean;
begin
    DC := tvAccounts.DataController;

    for Orig in FDeletedAccounts do
    begin
        RunSQL(Q, 'DELETE FROM TS_CUST_ACCOUNTS WHERE CUSTOMERID = :ID AND ACCOUNTNUMBER = :ORIG');
        Q.ParamByName('ID').AsInteger := FCustomerID;
        Q.ParamByName('ORIG').AsString := Orig;
        Q.Execute;
    end;

    // bancile noi (cod necunoscut in TS_BANKS)
    for I := 0 to DC.RecordCount - 1 do
    begin
        Bank := UpperCase(Trim(VarToStr(DC.Values[I, colAccBank.Index])));
        BankName := Trim(VarToStr(DC.Values[I, colAccBankName.Index]));
        if FBanks.ContainsKey(Bank) then
            Continue;
        RunSQL(Q, 'INSERT INTO TS_BANKS (BANKACCOUNT, BANKNAME) VALUES (:BANK, :BANKNAME)');
        SetStr(Q, 'BANK', Bank);
        SetStr(Q, 'BANKNAME', BankName);
        Q.Execute;
        FBanks.AddOrSetValue(Bank, BankName);
    end;

    // intii conturile ne-implicite, contul implicit la urma: triggerul TRG_TS_CUST_ACCOUNTS_BIU0
    // pune DEFAULT_ACCOUNT = 0 la celelalte cind se scrie un cont implicit
    for Pass := 0 to 1 do
        for I := 0 to DC.RecordCount - 1 do
        begin
            IsDefault := VarBool(DC.Values[I, colAccDefault.Index]);
            if IsDefault <> (Pass = 1) then
                Continue;
            IBAN := UpperCase(StringReplace(Trim(VarToStr(DC.Values[I, colAccIBAN.Index])), ' ', '', [rfReplaceAll]));
            Orig := VarToStr(DC.Values[I, colAccOrig.Index]);
            if Orig <> '' then
            begin
                RunSQL(Q, 'UPDATE TS_CUST_ACCOUNTS SET ACCOUNTNUMBER = :IBAN, ACCOUNTNAME = :NAME, BANKACCOUNT = :BANK, ' +
                    'DEFAULT_ACCOUNT = :DEF, IBAN = :IBAN2, FLG_CONT_CURENT = :CUR WHERE CUSTOMERID = :ID AND ACCOUNTNUMBER = :ORIG');
                Q.ParamByName('ORIG').AsString := Orig;
            end
            else
                RunSQL(Q, 'INSERT INTO TS_CUST_ACCOUNTS (CUSTOMERID, ACCOUNTNUMBER, ACCOUNTNAME, BANKACCOUNT, DEFAULT_ACCOUNT, ' +
                    'IBAN, FLG_CONT_CURENT) VALUES (:ID, :IBAN, :NAME, :BANK, :DEF, :IBAN2, :CUR)');
            Q.ParamByName('ID').AsInteger := FCustomerID;
            SetStr(Q, 'IBAN', IBAN);
            SetStr(Q, 'NAME', Copy(Trim(VarToStr(DC.Values[I, colAccName.Index])), 1, 60));
            SetStr(Q, 'BANK', UpperCase(Trim(VarToStr(DC.Values[I, colAccBank.Index]))));
            Q.ParamByName('DEF').AsInteger := IfThen(IsDefault, 1, 0);
            SetStr(Q, 'IBAN2', IfThen(LooksLikeIBAN(IBAN), IBAN, ''));
            Q.ParamByName('CUR').AsInteger :=
                IfThen(VarBool(DC.Values[I, colAccCurrent.Index]), 1, 0);
            Q.Execute;
        end;
end;

procedure TfrmCompanyCardDlg.SaveImages(Q: TIBCQuery);
var
    I: Integer;
    Any: Boolean;
begin
    Any := False;
    for I := 0 to 5 do
        Any := Any or ((ImageControl(I).Picture.Graphic <> nil) and not ImageControl(I).Picture.Graphic.Empty);
    if FIsNew and not Any then
        Exit;
    RunSQL(Q, 'UPDATE OR INSERT INTO TS_CUST_STAMP (CUSTOMERID, LOGO, STAMP_IMAGE, SIGNATURE, CEO_SIGN, ' +
        'ACCOUNTANT_SIGN, WARRANTY_STAMP) VALUES (:ID, :LOGO, :STAMP_IMAGE, :SIGNATURE, :CEO_SIGN, :ACCOUNTANT_SIGN, ' +
        ':WARRANTY_STAMP) MATCHING (CUSTOMERID)');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    ImageToParam(imgLogo, Q, 'LOGO');
    ImageToParam(imgStamp, Q, 'STAMP_IMAGE');
    ImageToParam(imgSignature, Q, 'SIGNATURE');
    ImageToParam(imgCeoSign, Q, 'CEO_SIGN');
    ImageToParam(imgAccSign, Q, 'ACCOUNTANT_SIGN');
    ImageToParam(imgWarranty, Q, 'WARRANTY_STAMP');
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.Save1C(Q: TIBCQuery);
begin
    if not chk1C.Checked then
        Exit;
    RunSQL(Q, 'UPDATE OR INSERT INTO TS_CUST_1C (CUSTOMERID, FIRMA_COD, SKLAD_COD, TITLE, TYPE, FIRMA_NAME, ' +
        'PERS_FIZ_CODE, PERS_FIZ_TITLE, DT, FLAGS) VALUES (:ID, :FIRMA_COD, :SKLAD_COD, :TITLE, :TYPE, :FIRMA_NAME, ' +
        ':PF_CODE, :PF_TITLE, :DT, :FLAGS) MATCHING (CUSTOMERID)');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    // coloanele sint NOT NULL: textele goale raman '' (nu NULL)
    Q.ParamByName('FIRMA_COD').AsString := Trim(ed1CFirmaCod.Text);
    Q.ParamByName('SKLAD_COD').AsString := Trim(ed1CSkladCod.Text);
    Q.ParamByName('TITLE').AsString := Trim(ed1CTitle.Text);
    Q.ParamByName('TYPE').AsString := Trim(cb1CType.Text);
    Q.ParamByName('FIRMA_NAME').AsString := Trim(ed1CFirmaName.Text);
    Q.ParamByName('PF_CODE').AsString := Trim(ed1CPfCode.Text);
    Q.ParamByName('PF_TITLE').AsString := Trim(ed1CPfTitle.Text);
    if (Kind = 2) and not VarIsBlank(lcbParent.EditValue) then
        Q.ParamByName('DT').AsInteger := lcbParent.EditValue
    else
        Q.ParamByName('DT').AsInteger := FCustomerID;
    Q.ParamByName('FLAGS').AsInteger := IfThen(chk1CActive.Checked, 1, 0);
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveEcc(Q: TIBCQuery);
var
    Code, Value: string;
    I: Integer;
begin
    if not chkEcc.Checked then
    begin
        // casa existenta se dezactiveaza, nu se sterge (jurnalul TFP_ECC_TRANSACTION o refera)
        if FEccFpId > 0 then
        begin
            RunSQL(Q, 'UPDATE FP_DEVICES SET FLG_ENABLED = 0 WHERE FP_ID = :FP_ID');
            Q.ParamByName('FP_ID').AsInteger := FEccFpId;
            Q.Execute;
        end;
        Exit;
    end;

    Code := EccCode;
    if Code = '' then
        Code := 'ECC_' + IntToStr(FCustomerID);

    for I := Low(cEccParams) to High(cEccParams) do
    begin
        case I of
            0: Value := cbEccServer.Text;
            1: Value := edEccApiKey.Text;
            2: Value := edEccPosId.Text;
            3: Value := edEccPosName.Text;
            4: Value := edEccCashier.Text;
            5: Value := edEccTax20.Text;
            6: Value := edEccTax8.Text;
            7: Value := edEccTax0.Text;
            8: Value := edEccTaxNone.Text;
            9: Value := edEccTermPosId.Text;
            10: Value := edEccTermPosName.Text;
            11: Value := edEccTermApiKey.Text;
        else
            Value := edEccTermTimeout.Text;
        end;
        Value := Trim(Value);
        if I = 0 then
        begin
            // BASE_URL fara /api/sp/v1 si fara '/' la sfirsit (ECCConfigUnit le adauga singur)
            Value := StringReplace(Value, '/api/sp/v1', '', [rfIgnoreCase]);
            while EndsText('/', Value) do
                SetLength(Value, Length(Value) - 1);
        end;
        if Value = '' then
        begin
            RunSQL(Q, 'DELETE FROM TS_API_CONFIG WHERE API_CODE = :C AND PARAM_NAME = :N');
            Q.ParamByName('C').AsString := Code;
            Q.ParamByName('N').AsString := cEccParams[I];
        end
        else
        begin
            RunSQL(Q, 'UPDATE OR INSERT INTO TS_API_CONFIG (API_CODE, PARAM_NAME, PARAM_VALUE, FLG_ACTIVE, NOTE) ' +
                'VALUES (:C, :N, :V, 1, :NOTE) MATCHING (API_CODE, PARAM_NAME)');
            Q.ParamByName('C').AsString := Code;
            Q.ParamByName('N').AsString := cEccParams[I];
            Q.ParamByName('V').AsString := Value;
            Q.ParamByName('NOTE').AsString := Copy('Casa ECC - ' + Trim(edName.Text), 1, 256);
        end;
        Q.Execute;
    end;

    if FEccFpId > 0 then
    begin
        RunSQL(Q, 'UPDATE FP_DEVICES SET WS_ID = :WS_ID, DESCRIPTION = :DESCR, FLG_ENABLED = :EN, DEVICE_TYPE = 1, ' +
            'ECC_API_CODE = :C WHERE FP_ID = :FP_ID');
        Q.ParamByName('FP_ID').AsInteger := FEccFpId;
    end
    else
    begin
        RunSQL(Q, 'INSERT INTO FP_DEVICES (FIRMA_ID, WS_ID, DESCRIPTION, FLG_ENABLED, DEVICE_TYPE, ECC_API_CODE) ' +
            'VALUES (:ID, :WS_ID, :DESCR, :EN, 1, :C)');
        Q.ParamByName('ID').AsInteger := FCustomerID;
    end;
    SetInt(Q, 'WS_ID', lcbEccWorkstation.EditValue);
    SetStr(Q, 'DESCR', IfThen(Trim(edEccDescription.Text) <> '', edEccDescription.Text, 'Casa ECC online'));
    Q.ParamByName('EN').AsInteger := IfThen(chkEccEnabled.Checked, 1, 0);
    Q.ParamByName('C').AsString := Code;
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveDefaults(Q: TIBCQuery);
var
    S: string;
begin
    if not (FIsNew and chkCopyDefaults.Checked) or VarIsBlank(lcbModelFirm.EditValue) then
        Exit;
    // DT = firma-model devine firma noua; depozitul ales inlocuieste DTDEP (si CTDEP acolo unde era acelasi)
    if VarIsBlank(lcbDepot.EditValue) then
        S := 'D.DTDEP, D.CTDEP'
    else
        S := ':DEP1, IIF(D.CTDEP = D.DTDEP, :DEP2, D.CTDEP)';
    RunSQL(Q, 'INSERT INTO TS_DOCTYPES_DEFVALUES (DOCTYPEID, FIRMA, DT, DTDEP, CTDEP, DTSC, CT, SC, CURRENCYID, ' +
        'FIRMA_PREFIX, FLG_ACNT, FLG_ACNT_DISABLED) SELECT D.DOCTYPEID, :NEW1, IIF(D.DT = :SRC1, :NEW2, D.DT), ' + S +
        ', D.DTSC, D.CT, D.SC, D.CURRENCYID, D.FIRMA_PREFIX, D.FLG_ACNT, D.FLG_ACNT_DISABLED ' +
        'FROM TS_DOCTYPES_DEFVALUES D WHERE D.FIRMA = :SRC2 AND NOT EXISTS (SELECT 1 FROM TS_DOCTYPES_DEFVALUES X ' +
        'WHERE X.DOCTYPEID = D.DOCTYPEID AND X.FIRMA = :NEW3)');
    Q.ParamByName('NEW1').AsInteger := FCustomerID;
    Q.ParamByName('NEW2').AsInteger := FCustomerID;
    Q.ParamByName('NEW3').AsInteger := FCustomerID;
    Q.ParamByName('SRC1').AsInteger := lcbModelFirm.EditValue;
    Q.ParamByName('SRC2').AsInteger := lcbModelFirm.EditValue;
    if not VarIsBlank(lcbDepot.EditValue) then
    begin
        Q.ParamByName('DEP1').AsInteger := lcbDepot.EditValue;
        Q.ParamByName('DEP2').AsInteger := lcbDepot.EditValue;
    end;
    Q.Execute;
end;

procedure TfrmCompanyCardDlg.SaveAccess(Q: TIBCQuery);
var
    Position: Integer;
begin
    if not (FIsNew and chkGrantAccess.Checked) or (UserID = 1) then
        Exit;   // administratorul (1) vede oricum toate firmele
    // GET_FIRMS_BY_USER: bitul N din ACC$FIRM = a N-a firma din VW_TS_FIRMS dupa CUSTOMERID (de la 1)
    RunSQL(Q, 'SELECT COUNT(*) FROM VW_TS_FIRMS WHERE CUSTOMERID <= :ID');
    Q.ParamByName('ID').AsInteger := FCustomerID;
    Q.Open;
    Position := Q.Fields[0].AsInteger;
    Q.Close;
    if (Position < 1) or (Position > 62) then
    begin
        FSaveWarnings := FSaveWarnings + #13#10 + 'Accesul nu a fost acordat: pozitia firmei (' + IntToStr(Position) +
            ') nu incape in ACC$FIRM.';
        Exit;
    end;
    try
        RunSQL(Q, 'UPDATE TS_USERS SET ACC$FIRM = BIN_OR(COALESCE(ACC$FIRM, 0), BIN_SHL(CAST(1 AS BIGINT), :POS)) ' +
            'WHERE USERID = :U');
        Q.ParamByName('POS').AsInteger := Position;
        Q.ParamByName('U').AsInteger := UserID;
        Q.Execute;
    except
        on E: Exception do
            FSaveWarnings := FSaveWarnings + #13#10 + 'Accesul nu a fost acordat (' + E.Message +
                '). Il acorda administratorul in setarile utilizatorului.';
    end;
end;

function TfrmCompanyCardDlg.SaveAll: Boolean;
var
    Q: TIBCQuery;
    WasNew: Boolean;
begin
    Result := False;
    if not ValidateData then
        Exit;

    WasNew := FIsNew;
    FSaveWarnings := '';
    Q := NewWriteQuery;
    try
        try
            if not trWrite.Active then
                trWrite.StartTransaction;
            SaveCustomer(Q);
            SaveInfo(Q);
            SaveCompany(Q);
            SaveAddress(Q, cAddrTypeJuridic, FAddrIdJ, lcbCityJ, lcbDistrictJ, edStreetJ);
            if chkSameAddress.Checked then
                SaveAddress(Q, cAddrTypeFizic, FAddrIdF, lcbCityJ, lcbDistrictJ, edStreetJ)
            else
                SaveAddress(Q, cAddrTypeFizic, FAddrIdF, lcbCityF, lcbDistrictF, edStreetF);
            SavePhone(Q, cPhoneTypeWork, FPhoneId, edPhone.Text);
            SavePhone(Q, cPhoneTypeMobile, FMobileId, edMobile.Text);
            SaveEmail(Q);
            SaveAccounts(Q);
            SaveImages(Q);
            Save1C(Q);
            SaveEcc(Q);
            SaveDefaults(Q);
            SaveAccess(Q);
            trWrite.Commit;
        except
            on E: Exception do
            begin
                if trWrite.Active then
                    trWrite.Rollback;
                if WasNew then
                begin
                    FCustomerID := 0;   // la urmatoarea incercare se ia un cod nou
                    FAddrIdJ := 0;
                    FAddrIdF := 0;
                    FPhoneId := 0;
                    FMobileId := 0;
                    FEmailId := 0;
                    FEccFpId := 0;
                end;
                ShowErrorDialog('Fisa companiei nu a fost salvata', E.Message);
                Exit;
            end;
        end;
    finally
        Q.Free;
    end;
    FIsNew := False;
    if FSaveWarnings <> '' then
        ShowInfoDialog('Fisa companiei', 'Fisa a fost salvata.' + FSaveWarnings);
    Result := True;
end;

procedure TfrmCompanyCardDlg.btnEccTestClick(Sender: TObject);
var
    Cfg: TECCConfig;
    Client: TECCApiClient;
    Err: string;
    Ok: Boolean;
begin
    Cfg := EccConfigFromForm;
    Err := Cfg.Validate;
    if Err <> '' then
    begin
        Fail(StringReplace(Err, ' in Setari > Configurari API', '', []), tabEcc, edEccApiKey);
        Exit;
    end;
    Screen.Cursor := crHourGlass;
    try
        try
            Client := Cfg.CreateClient;
            try
                Ok := Client.Status;
            finally
                Client.Free;
            end;
        except
            on E: Exception do
            begin
                Screen.Cursor := crDefault;
                ShowErrorDialog('Casa ECC', 'Serverul ECC nu raspunde corect: ' + E.Message);
                Exit;
            end;
        end;
    finally
        Screen.Cursor := crDefault;
    end;
    if Ok then
        ShowInfoDialog('Casa ECC', 'Legatura cu ' + Cfg.BaseURL + ' merge: serverul si cheia API sint valabile.')
    else
        ShowErrorDialog('Casa ECC', 'Serverul ' + Cfg.BaseURL + ' a raspuns, dar starea casei nu e activa.');
end;

function TfrmCompanyCardDlg.IsFormDataPosted: Boolean;
begin
    Result := SaveAll;
end;

procedure TfrmCompanyCardDlg.WhenCancelForm;
begin
    if trWrite.Active then
        trWrite.Rollback;
end;

end.

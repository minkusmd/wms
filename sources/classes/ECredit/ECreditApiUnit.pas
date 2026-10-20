unit ECreditApiUnit;

(* ============================================================================
   Clientul API Easy Credit (eCredit, https://api.ecredit.md) - depunerea
   cererilor de credit din WMS pentru ofertele din "Oferte".

   Specificatia: https://api.ecredit.md/openapi.json (OpenAPI 3.1, versiunea
   2023.12.11, descarcata la 20.10.2026). Paginile /docs si /redoc cer HTTP
   Basic cu contul de productie "Easy Credit Core System".

   Toate metodele sint POST {BASE_URL}/{ENVIRONMENT}/{Metoda} cu corp JSON;
   ENVIRONMENT = TEST sau PRODUCTION. Fiecare cerere poarta Login/Password in
   corpul JSON si HTTP Basic in antet (acelasi cont daca BASIC_USER lipseste).

   Configuratia vine din TS_API_CONFIG, API_CODE = 'ECREDIT'
   (DB Model/ecredit_api.sql): BASE_URL, ENVIRONMENT, USERNAME / PASSWORD
   (contul magazinului, folosit in corpul JSON in PRODUCTION), TEST_USERNAME /
   TEST_PASSWORD (contul UAT dat de eCredit, folosit in corpul JSON in TEST),
   BASIC_USER / BASIC_PASSWORD (contul de productie Easy Credit Core System,
   pentru antetul HTTP Basic - acelasi care deschide /docs; gol = contul din
   corp), SHOP_ID, SHOP_GROUP_ID, FILES_URL, SHOP_CONTACT, SHOP_EMAIL, SHOP_PHONE.

   Mediile Easy Credit Core System (SOAP, nu se apeleaza direct de aici):
   UAT https://tst.ecmoldova.cloud:8081 (web) / :8082 (soap), productie
   https://w81.ecredit.md:8081 / :8082. REST-ul de la api.ecredit.md pune
   mediul in path, urmat de numele serviciului SOAP (ECM_ShopProducts.svc ->
   /TEST/ECM_ShopProducts).

   Metode folosite (lista recomandata de eCredit, R. Costin, 08.07.2026):
     ECM_ShopProducts      produsele de credit ale magazinului (ProductID + limite);
                           lista se reciteste doar cind eCredit anunta schimbari
     ECM_InstallmentCalc   rata lunara, dobinda, comision, DAE pentru suma/termen
     Preapproved_v2_1      verificarea clientului dupa IDNP + data nasterii + telefon
     Request_v3            depunerea cererii -> URN (9 cifre) + Status (cimpul
                           "Product"); Request_v4 ("ProductID", "ShopID") doar daca
                           eCredit il deschide contului - TS_API_CONFIG REQUEST_METHOD
     URNStatus_v9          statutul cererii (RequestStatus) si al contractului
                           (DocumentStatus), rata, mesaj; nu exista webhook-uri,
                           statutul se interogheaza
     ECM_CancelRequest     anularea cererii
     ECM_GetDocs_V2        contractul de semnat (PDF base64 in DocTypeA)

   Scenariul dupa RequestStatus = Approved (DocumentStatus = Currently At Shop):
     semnare fizica:   Received FCopy -> Check FCopy -> Received Original By Bank
                       -> Checked Original By Bank (contractul scanat se trimite
                       prin partener.ecredit.md, vezi UploadFiles)
     semnare online:   Identified La Distanta -> Sign and Receive La Distanta
                       -> Check La Distanta (Not Identified La Distanta = eroare)
     apoi RequestStatus Disbursed (banii transferati) si Settled (imprumut inchis).

   Statutele cererii (eShopGetRequests.Status): A Approved, B Battery,
   C Canceled, D Disbursed, I Incomplete, M More data, N New, R Rejected,
   S Settled, U Uncommitted. Statutele contractului (ECM_Change_DocStatus):
   2150 Currently At Shop, 2151 Received By EasyCredit, 2153 Checked By
   EasyCredit, 2656/2657 Identified / Not Identified La Distanta, ...

   Fara VCL si fara acces la baza (in afara de LoadECreditConfig) - se poate
   apela si dintr-un fir separat. Parola nu apare in LastRequest.
   ============================================================================ *)

interface

uses
    System.SysUtils, System.Classes, System.JSON, IBC;

const
    cECreditApiCode = 'ECREDIT';
    cECreditDefaultBaseURL = 'https://api.ecredit.md';
    cECreditEnvTest = 'TEST';
    cECreditEnvProduction = 'PRODUCTION';
    // API-ul de fisiere (copia buletinului, contracte): partener.ecredit.md, spec. v2024.12.04.
    // POST /api/{ENV}/files/upload (multipart: Login, Password, URN, files[]) - fisierele se
    // imbina intr-un PDF; acelasi fisier trimis a doua oara -> 409. Lista: GET
    // /{yyyy}/{mm}/{uin}/{urn}?environment=ENV (HTML), link-ul vine in detail.destination.url.
    cECreditDefaultFilesURL = 'https://partener.ecredit.md';

type
    EECreditApiError = class(Exception)
    private
        FHttpCode: Integer;
    public
        constructor CreateHttp(AHttpCode: Integer; const AMessage: string);
        property HttpCode: Integer read FHttpCode;
    end;

    TECreditConfig = record
        BaseURL: string;
        Login: string;
        Password: string;
        BasicUser: string;
        BasicPassword: string;
        Environment: string;
        ShopID: Integer;
        ShopGroupID: string;
        FilesURL: string;      // partener.ecredit.md
        ShopContact: string;   // optional, la incarcarea fisierelor (3..35 caractere)
        ShopEmail: string;     // optional
        ShopPhone: string;     // optional, 0XXXXXXXX
        RequestMethod: string; // Request_v3 (implicit) sau Request_v4
        // '' = configuratia e completa
        function Validate: string;
        function IsProduction: Boolean;
    end;

    // ECM_ShopProducts -> response.Info.ProductInfo.Product[]: ProductID, ProductName, MinAmount,
    // MaxAmount, MinInstallments, MaxInstallments, FirstPaymentAfter (zile), MinDaysAfter,
    // ProductGroup (eSimplu...), ProductClass (Shop Standard...). 0 = necunoscut (lista locala).
    TECreditProduct = record
        ID: Integer;
        Name: string;
        FromAPI: Boolean;
        MinAmount: Double;
        MaxAmount: Double;
        MinInstallments: Integer;
        MaxInstallments: Integer;
        FirstPaymentAfter: Integer;  // prima rata la cel mult atitea zile de azi
        MinDaysAfter: Integer;       // ... si la cel putin atitea
        Group: string;
        ProductClass: string;
        function Describe: string;   // "Shop-06-11 (6..11 rate, 100..80000 MDL)"
        // '' = parametrii se incadreaza; altfel motivul
        function Check(const AAmount: Currency; const AInstallments: Integer; const AFirstDate: TDateTime): string;
    end;

    TECreditCalc = record
        Status: string;
        InstallmentAmount: Double;
        InterestRate: Double;
        CommissionRate: Double;
        DAE: Double;
        FixedExpenses: Double;
        PayableByConsumer: Double;
        function Summary: string;
    end;

    TECreditClientInfo = record
        Status: string;
        FirstName: string;
        LastName: string;
        FatherName: string;
        BirthDate: string;
        UpId: string;
        MaxESimplu: Double;
        MaxReuseste: Double;
    end;

    TECreditRequest = record
        ProductID: Integer;
        ShopID: Integer;
        UIN: string;                     // IDNP, 13 cifre
        BirthDate: TDateTime;
        FirstName: string;
        LastName: string;
        FatherName: string;
        Mobile: string;                  // 0XXXXXXXX
        Email: string;
        GoodsName: string;
        GoodsPrice: Currency;
        CreditAmount: Currency;
        Installments: Integer;
        FirstInstallmentDate: TDateTime; // 15..45 de zile de azi
        IdCard: string;
        UtmSource: string;
        UtmCampaign: string;
    end;

    TECreditRequestResult = record
        URN: string;
        Status: string;
    end;

    TECreditStatus = record
        URN: string;
        UIN: string;
        RequestStatus: string;
        RequestStatusID: string;
        DocumentStatus: string;
        DocumentStatusID: string;
        LoanStatus: string;
        Message: string;
        ReadyForSign: string;
        PaymentDate: string;
        ClosedDate: string;
        FirstName: string;
        LastName: string;
        FatherName: string;
        Mobile: string;
        Email: string;
        GoodsName: string;
        LoanAmount: Double;
        GoodsPrice: Double;
        InstallmentAmount: Double;
        InterestRate: Double;
        CommissionRate: Double;
        PayableByConsumer: Double;
        Installments: Integer;
        function Summary: string;
    end;

    TECreditUploadResult = record
        Status: string;
        Message: string;
        Url: string;        // lista fisierelor cererii (HTML, cu Basic auth)
        Filename: string;   // PDF-ul rezultat
        DocType: string;    // buletin / contract
        Pages: Integer;
        Count: Integer;
        Errors: Integer;
        FilesText: string;  // "fisier: mesaj; ..."
        function Summary: string;
    end;

    TECreditApiClient = class
    private
        FConfig: TECreditConfig;
        FConnectionTimeout: Integer;
        FResponseTimeout: Integer;
        FLastMethod: string;
        FLastRequest: string;
        FLastResponse: string;
        FLastHttpCode: Integer;
        // Trimite cererea (preia si elibereaza ABody), intoarce obiectul JSON de raspuns.
        // Gateway-ul impacheteaza raspunsul Core System: {"request": {...}, "response": {...}} -
        // se intoarce doar "response". AAlsoOkCode = un cod HTTP de eroare acceptat ca raspuns
        // normal (de ex. 404 "Wrong Customer" la Preapproved).
        function Post(const AMethod: string; ABody: TJSONObject; const AAlsoOkCode: Integer = 0): TJSONObject;
        procedure CheckStatus(AObj: TJSONObject; const AMethod: string);
    public
        constructor Create(const AConfig: TECreditConfig);

        function ShopProducts: TArray<TECreditProduct>;
        function InstallmentCalc(const AProductID: Integer; const AAmount: Currency;
            const AFirstDate: TDateTime; const AInstallments: Integer): TECreditCalc;
        function Preapproved(const AUIN: string; const ABirthDate: TDateTime; const APhone: string): TECreditClientInfo;
        function SendRequest(const R: TECreditRequest): TECreditRequestResult;
        function GetStatus(const AURN: string): TECreditStatus;
        procedure CancelRequest(const AURN, AComments: string);
        // Contractul de credit de semnat (PDF), ECM_GetDocs_V2. ALang: RO / RU / EN.
        function GetContract(const AURN: string; const ALang: string = 'RO'): TBytes;
        // Trimite fisierele (jpg/png/pdf/...) la partener.ecredit.md pentru cererea AURN.
        function UploadFiles(const AURN: string; const AFiles: array of string): TECreditUploadResult;

        property ConnectionTimeout: Integer read FConnectionTimeout write FConnectionTimeout;
        property ResponseTimeout: Integer read FResponseTimeout write FResponseTimeout;
        // pentru jurnal / diagnostic (parola e mascata in LastRequest)
        property LastMethod: string read FLastMethod;
        property LastRequest: string read FLastRequest;
        property LastResponse: string read FLastResponse;
        property LastHttpCode: Integer read FLastHttpCode;
    end;

// Citeste configuratia din TS_API_CONFIG; tranzactie proprie, doar citire.
function LoadECreditConfig(AConn: TIBCConnection; const AApiCode: string = cECreditApiCode): TECreditConfig;
// Produsele vazute in cabinetul shop.ecredit.md al contului "fantastic solutii" (20.10.2026) -
// lista de rezerva cind ECM_ShopProducts nu raspunde.
function ECreditDefaultProducts: TArray<TECreditProduct>;
function ECreditDateText(const ADate: TDateTime): string;        // yyyy-mm-dd
function ECreditIsValidUIN(const AUIN: string): Boolean;          // 13 cifre, incepe cu 0 sau 2
function ECreditIsValidURN(const AURN: string): Boolean;          // 9 cifre
function ECreditNormalizePhone(const APhone: string): string;     // 0XXXXXXXX
function ECreditIsErrorStatus(const AStatus: string): Boolean;
function ECreditIsFinalStatus(const AStatus: string): Boolean;    // anulata / respinsa / achitata
function ECreditMimeType(const AFileName: string): string;        // dupa extensie; '' = neacceptat
// Statutul contractului (DocumentStatus) in romana, cum il arata shop.ecredit.md; '' = necunoscut.
function ECreditDocStatusRo(const AStatus: string): string;

implementation

uses
    System.Net.HttpClient, System.Net.URLClient, System.NetEncoding, System.Net.Mime, System.Character,
    System.Math, System.Generics.Collections, MemDS, DBAccess, IBCClasses;

{ helpers JSON }

function JStr(AObj: TJSONObject; const AName: string): string;
var
    V: TJSONValue;
begin
    Result := '';
    if not Assigned(AObj) then
        Exit;
    V := AObj.GetValue(AName);
    if (V = nil) or (V is TJSONNull) then
        Exit;
    if V is TJSONString then
        Result := TJSONString(V).Value
    else
        Result := V.ToString;
end;

// Valorile numerice vin uneori ca text ("63"), alteori ca numar.
function JFloat(AObj: TJSONObject; const AName: string): Double;
begin
    Result := StrToFloatDef(StringReplace(JStr(AObj, AName), ',', '.', []), 0, TFormatSettings.Invariant);
end;

function JInt(AObj: TJSONObject; const AName: string): Integer;
begin
    Result := Round(JFloat(AObj, AName));
end;

function JNum(const AValue: Double): TJSONNumber;
begin
    Result := TJSONNumber.Create(AValue);
end;

// Intregii (ProductID, NumberOfInstallments) merg ca 4660, nu 4660.0.
function JIntNum(const AValue: Integer): TJSONNumber;
begin
    Result := TJSONNumber.Create(AValue);
end;

function JObj(AObj: TJSONObject; const AName: string): TJSONObject;
var
    V: TJSONValue;
begin
    Result := nil;
    if not Assigned(AObj) then
        Exit;
    V := AObj.GetValue(AName);
    if V is TJSONObject then
        Result := TJSONObject(V);
end;

function FirstNonEmpty(const AValues: array of string): string;
var
    I: Integer;
begin
    Result := '';
    for I := Low(AValues) to High(AValues) do
        if Trim(AValues[I]) <> '' then
            Exit(Trim(AValues[I]));
end;

function BasicAuthHeader(const AUser, APass: string): string;
var
    Enc: TBase64Encoding;
begin
    Enc := TBase64Encoding.Create(0, '');  // fara CRLF la 76 de caractere
    try
        Result := 'Basic ' + Enc.Encode(AUser + ':' + APass);
    finally
        Enc.Free;
    end;
end;

function MaskSecret(const AText, ASecret: string): string;
begin
    Result := AText;
    if ASecret <> '' then
        Result := StringReplace(Result, ASecret, '***', [rfReplaceAll]);
end;

// Mesajul de validare FastAPI (HTTP 422): {"detail":[{"loc":["body","UIN"],"msg":"..."}]}
function ValidationMessage(AObj: TJSONObject): string;
var
    D: TJSONValue;
    Item: TJSONValue;
    O: TJSONObject;
    Loc: TJSONValue;
    Field: string;
    I: Integer;
begin
    Result := '';
    D := AObj.GetValue('detail');
    if D is TJSONArray then
    begin
        for Item in TJSONArray(D) do
            if Item is TJSONObject then
            begin
                O := TJSONObject(Item);
                Field := '';
                Loc := O.GetValue('loc');
                if Loc is TJSONArray then
                    for I := 0 to TJSONArray(Loc).Count - 1 do
                        Field := TJSONArray(Loc).Items[I].Value;  // ultimul element = cimpul
                if Result <> '' then
                    Result := Result + '; ';
                if Field <> '' then
                    Result := Result + Field + ': ';
                Result := Result + JStr(O, 'msg');
            end;
    end
    else if D is TJSONString then
        Result := TJSONString(D).Value;
    if Result = '' then
        Result := Copy(AObj.ToJSON, 1, 300);
end;

// Primul tablou JSON din valoare (direct sau in interiorul unui obiect, max 3 niveluri):
// eCredit impacheteaza listele ca {"Info": {"Lista": {"Element": [...]}}}.
function FindArray(AValue: TJSONValue; ADepth: Integer = 0): TJSONArray;
var
    P: TJSONPair;
begin
    Result := nil;
    if AValue is TJSONArray then
        Exit(TJSONArray(AValue));
    if (AValue is TJSONObject) and (ADepth < 3) then
        for P in TJSONObject(AValue) do
        begin
            Result := FindArray(P.JsonValue, ADepth + 1);
            if Assigned(Result) then
                Exit;
        end;
end;

{ functii publice }

function ECreditDateText(const ADate: TDateTime): string;
begin
    Result := FormatDateTime('yyyy"-"mm"-"dd', ADate);
end;

function ECreditIsValidUIN(const AUIN: string): Boolean;
var
    I: Integer;
begin
    Result := (Length(AUIN) = 13) and CharInSet(AUIN[1], ['0', '2']);
    if Result then
        for I := 1 to 13 do
            if not AUIN[I].IsDigit then
                Exit(False);
end;

function ECreditIsValidURN(const AURN: string): Boolean;
var
    I: Integer;
begin
    Result := Length(AURN) = 9;
    if Result then
        for I := 1 to 9 do
            if not AURN[I].IsDigit then
                Exit(False);
end;

function ECreditNormalizePhone(const APhone: string): string;
var
    C: Char;
begin
    Result := '';
    for C in APhone do
        if C.IsDigit then
            Result := Result + C;
    if (Length(Result) = 11) and (Copy(Result, 1, 3) = '373') then
        Result := '0' + Copy(Result, 4, 8)
    else if Length(Result) = 8 then
        Result := '0' + Result;
end;

// Core System pune codul erorii la sfirsitul textului: "Wrong Customer - 50000",
// "These parameters does not match any active product! - 50000".
function ECreditIsErrorStatus(const AStatus: string): Boolean;
var
    L: string;
    P: Integer;
begin
    L := LowerCase(Trim(AStatus));
    Result := (Pos('error', L) > 0) or (Pos('fail', L) > 0) or (Pos('invalid', L) > 0) or
        (Pos('not valid', L) > 0) or (Pos('not auth', L) > 0) or (Pos('wrong', L) > 0) or
        (Pos('denied', L) > 0) or (Pos('eroare', L) > 0) or (Pos('not found', L) > 0) or
        (Pos('does not match', L) > 0) or (Pos('not allowed', L) > 0);
    if not Result then
    begin
        P := Pos(' - 5', L);   // " - 50000"
        Result := (P > 0) and (Length(L) >= P + 7) and L[P + 4].IsDigit and L[P + 5].IsDigit and
            L[P + 6].IsDigit and L[P + 7].IsDigit;
    end;
end;

function ECreditIsFinalStatus(const AStatus: string): Boolean;
var
    L: string;
begin
    L := LowerCase(Trim(AStatus));
    Result := (Pos('cancel', L) > 0) or (Pos('reject', L) > 0) or (Pos('settled', L) > 0) or
        (Pos('anulat', L) > 0) or (Pos('refuz', L) > 0);
end;

function ECreditMimeType(const AFileName: string): string;
var
    E: string;
begin
    E := LowerCase(ExtractFileExt(AFileName));
    if (E = '.jpg') or (E = '.jpeg') or (E = '.jfif') then
        Result := 'image/jpeg'
    else if E = '.png' then
        Result := 'image/png'
    else if E = '.pdf' then
        Result := 'application/pdf'
    else if E = '.bmp' then
        Result := 'image/bmp'
    else if (E = '.tif') or (E = '.tiff') then
        Result := 'image/tiff'
    else if E = '.webp' then
        Result := 'image/webp'
    else if E = '.heic' then
        Result := 'image/heic'
    else
        Result := '';
end;

function ECreditDocStatusRo(const AStatus: string): string;
var
    L: string;
begin
    L := LowerCase(Trim(AStatus));
    if L = 'currently at shop' then
        Result := 'La magazin'
    else if L = 'identified la distanta' then
        Result := 'Identificat la distanta'
    else if L = 'not identified la distanta' then
        Result := 'Neidentificat la distanta (eroare)'
    else if L = 'sign and receive la distanta' then
        Result := 'Semnat la distanta'
    else if L = 'check la distanta' then
        Result := 'Verificat (semnat la distanta)'
    else if L = 'received fcopy' then
        Result := 'Copie contract primita'
    else if L = 'check fcopy' then
        Result := 'Copie contract verificata'
    else if L = 'received original fcopy' then
        Result := 'Original copie primit'
    else if L = 'check original fcopy' then
        Result := 'Original copie verificat'
    else if L = 'received original by bank' then
        Result := 'Contract original primit'
    else if L = 'checked original by bank' then
        Result := 'Contract original verificat'
    else if L = 'received by easycredit' then
        Result := 'Primit de Easy Credit'
    else if L = 'checked by easycredit' then
        Result := 'Verificat de Easy Credit'
    else
        Result := '';
end;

function ECreditDefaultProducts: TArray<TECreditProduct>;
    procedure Add(const AID: Integer; const AName: string; const AMinInst, AMaxInst: Integer);
    begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := Default(TECreditProduct);
        Result[High(Result)].ID := AID;
        Result[High(Result)].Name := AName;
        Result[High(Result)].MinInstallments := AMinInst;
        Result[High(Result)].MaxInstallments := AMaxInst;
        Result[High(Result)].FirstPaymentAfter := 31;
        Result[High(Result)].MinDaysAfter := 15;
    end;
begin
    Result := nil;
    Add(4660, 'Fantastic 0% pe 4 luni', 4, 4);
    Add(4661, 'Fantastic 0% pe 6 luni', 6, 6);
    Add(4662, 'Fantastic 0% pe 10 luni', 10, 10);
    Add(4663, 'Fantastic 0% pe 12 luni', 12, 12);
    Add(5541, 'Fantastic 36 cu perioada gratie pe 4 luni', 0, 0);
    Add(3670, 'w.Shop-06-24', 6, 24);
    Add(3671, 'w.Shop-25-36', 25, 36);
    Add(5247, 'w.Shop-37-46', 37, 46);
end;

{ TECreditProduct }

function TECreditProduct.Describe: string;
begin
    Result := Name;
    if (MinInstallments > 0) and (MaxInstallments > 0) then
    begin
        if MinInstallments = MaxInstallments then
            Result := Result + Format(' (%d rate', [MinInstallments])
        else
            Result := Result + Format(' (%d..%d rate', [MinInstallments, MaxInstallments]);
        if MaxAmount > 0 then
            Result := Result + Format(', %.0f..%.0f MDL', [MinAmount, MaxAmount]);
        if FirstPaymentAfter > 0 then
            Result := Result + Format(', prima rata la %d..%d zile', [Max(MinDaysAfter, 1), FirstPaymentAfter]);
        Result := Result + ')';
    end;
end;

function TECreditProduct.Check(const AAmount: Currency; const AInstallments: Integer;
    const AFirstDate: TDateTime): string;
var
    DMin, DMax: Integer;
begin
    Result := '';
    if (MinInstallments > 0) and (AInstallments < MinInstallments) or
       (MaxInstallments > 0) and (AInstallments > MaxInstallments) then
        Exit(Format('Produsul "%s" accepta %d..%d rate, nu %d.', [Name, MinInstallments, MaxInstallments, AInstallments]));
    if (MaxAmount > 0) and ((AAmount < MinAmount) or (AAmount > MaxAmount)) then
        Exit(Format('Produsul "%s" accepta sume intre %.2f si %.2f MDL, nu %.2f.', [Name, MinAmount, MaxAmount, AAmount]));
    DMin := MinDaysAfter;
    if DMin <= 0 then
        DMin := 15;
    DMax := FirstPaymentAfter;
    if DMax <= 0 then
        DMax := 45;
    if (Trunc(AFirstDate) < Trunc(Date) + DMin) or (Trunc(AFirstDate) > Trunc(Date) + DMax) then
        Exit(Format('Pentru produsul "%s" prima rata trebuie sa fie intre %d si %d zile de azi (%s .. %s).',
            [Name, DMin, DMax, FormatDateTime('dd.mm.yyyy', Date + DMin), FormatDateTime('dd.mm.yyyy', Date + DMax)]));
end;

function LoadECreditConfig(AConn: TIBCConnection; const AApiCode: string): TECreditConfig;
var
    Tr: TIBCTransaction;
    Q: TIBCQuery;
    Name, Value, TestLogin, TestPassword: string;
begin
    Result := Default(TECreditConfig);
    TestLogin := '';
    TestPassword := '';
    Result.BaseURL := cECreditDefaultBaseURL;
    Result.FilesURL := cECreditDefaultFilesURL;
    Result.Environment := cECreditEnvTest;
    Result.RequestMethod := 'Request_v3';

    Tr := TIBCTransaction.Create(nil);
    Q := TIBCQuery.Create(nil);
    try
        Tr.DefaultConnection := AConn;
        Tr.IsolationLevel := iblReadOnlyReadCommitted;
        Q.Connection := AConn;
        Q.Transaction := Tr;
        Q.SQL.Text := 'SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG ' +
            'WHERE API_CODE = :API_CODE AND FLG_ACTIVE = 1';
        Q.ParamByName('API_CODE').AsString := UpperCase(Trim(AApiCode));
        Q.Open;
        while not Q.Eof do
        begin
            Name := UpperCase(Trim(Q.FieldByName('PARAM_NAME').AsString));
            Value := Trim(Q.FieldByName('PARAM_VALUE').AsString);
            if (Name = 'BASE_URL') and (Value <> '') then
                Result.BaseURL := Value
            else if Name = 'USERNAME' then
                Result.Login := Value
            else if Name = 'PASSWORD' then
                Result.Password := Value
            else if (Name = 'ENVIRONMENT') and (Value <> '') then
                Result.Environment := UpperCase(Value)
            else if Name = 'SHOP_ID' then
                Result.ShopID := StrToIntDef(Value, 0)
            else if Name = 'SHOP_GROUP_ID' then
                Result.ShopGroupID := Value
            else if Name = 'BASIC_USER' then
                Result.BasicUser := Value
            else if Name = 'BASIC_PASSWORD' then
                Result.BasicPassword := Value
            else if (Name = 'FILES_URL') and (Value <> '') then
                Result.FilesURL := Value
            else if Name = 'SHOP_CONTACT' then
                Result.ShopContact := Value
            else if Name = 'SHOP_EMAIL' then
                Result.ShopEmail := Value
            else if Name = 'SHOP_PHONE' then
                Result.ShopPhone := Value
            else if Name = 'TEST_USERNAME' then
                TestLogin := Value
            else if Name = 'TEST_PASSWORD' then
                TestPassword := Value
            else if (Name = 'REQUEST_METHOD') and (Value <> '') then
                Result.RequestMethod := Value;
            Q.Next;
        end;
        Q.Close;
        if Tr.Active then
            Tr.Commit;
    finally
        Q.Free;
        Tr.Free;
    end;
    // in TEST corpul JSON poarta contul UAT dat de eCredit; antetul Basic ramine cel de productie
    if (Result.Environment = cECreditEnvTest) and (TestLogin <> '') then
    begin
        if (Result.BasicUser = '') and (Result.Login <> '') then
        begin
            Result.BasicUser := Result.Login;
            Result.BasicPassword := Result.Password;
        end;
        Result.Login := TestLogin;
        Result.Password := TestPassword;
    end;
end;

{ TECreditConfig }

function TECreditConfig.Validate: string;
begin
    Result := '';
    if Trim(BaseURL) = '' then
        Exit('lipseste BASE_URL');
    if Trim(Login) = '' then
        Exit('lipseste USERNAME (Login-ul API)');
    if Password = '' then
        Exit('lipseste PASSWORD');
    if (Environment <> cECreditEnvTest) and (Environment <> cECreditEnvProduction) then
        Exit('ENVIRONMENT trebuie sa fie TEST sau PRODUCTION');
    if (RequestMethod <> 'Request_v3') and (RequestMethod <> 'Request_v4') then
        Exit('REQUEST_METHOD trebuie sa fie Request_v3 sau Request_v4');
end;

function TECreditConfig.IsProduction: Boolean;
begin
    Result := Environment = cECreditEnvProduction;
end;

{ TECreditCalc }

function TECreditCalc.Summary: string;
begin
    Result := Format('Rata lunara %.2f MDL; dobinda %.2f%%; comision %.2f%%; cheltuieli fixe %.2f MDL; ' +
        'total de achitat %.2f MDL; DAE %.2f%%',
        [InstallmentAmount, InterestRate, CommissionRate, FixedExpenses, PayableByConsumer, DAE]);
end;

{ TECreditStatus }

function TECreditStatus.Summary: string;
begin
    Result := Format('URN %s: cerere "%s", contract "%s"', [URN, RequestStatus, DocumentStatus]);
    if InstallmentAmount > 0 then
        Result := Result + Format(', rata %.2f MDL x %d', [InstallmentAmount, Installments]);
    if Message <> '' then
        Result := Result + '. ' + Message;
end;

{ TECreditUploadResult }

function TECreditUploadResult.Summary: string;
begin
    Result := Format('%s (%d fisiere, %d pagini, %s)', [Message, Count, Pages, DocType]);
    if Filename <> '' then
        Result := Result + ': ' + Filename;
    if FilesText <> '' then
        Result := Result + ' [' + FilesText + ']';
end;

{ EECreditApiError }

constructor EECreditApiError.CreateHttp(AHttpCode: Integer; const AMessage: string);
begin
    inherited Create(AMessage);
    FHttpCode := AHttpCode;
end;

{ TECreditApiClient }

constructor TECreditApiClient.Create(const AConfig: TECreditConfig);
begin
    inherited Create;
    FConfig := AConfig;
    FConnectionTimeout := 15000;
    FResponseTimeout := 60000;
end;

function TECreditApiClient.Post(const AMethod: string; ABody: TJSONObject; const AAlsoOkCode: Integer): TJSONObject;
var
    Http: THTTPClient;
    Src: TStringStream;
    Resp: IHTTPResponse;
    Headers: TNetHeaders;
    Url, Body, BUser, BPass, Msg: string;
    V: TJSONValue;
    Inner: TJSONObject;
    Code: Integer;
begin
    Result := nil;
    try
        Url := Trim(FConfig.BaseURL);
        while (Url <> '') and (Url[Length(Url)] = '/') do
            Delete(Url, Length(Url), 1);
        Url := Url + '/' + FConfig.Environment + '/' + AMethod;
        ABody.AddPair('Login', FConfig.Login);
        ABody.AddPair('Password', FConfig.Password);
        Body := ABody.ToJSON;
    finally
        ABody.Free;
    end;

    FLastMethod := AMethod;
    FLastRequest := 'POST ' + Url + sLineBreak + MaskSecret(Body, FConfig.Password);
    FLastResponse := '';
    FLastHttpCode := 0;

    BUser := FConfig.BasicUser;
    BPass := FConfig.BasicPassword;
    if BUser = '' then
    begin
        BUser := FConfig.Login;
        BPass := FConfig.Password;
    end;

    Headers := [TNetHeader.Create('Content-Type', 'application/json'),
        TNetHeader.Create('Accept', 'application/json')];
    if BUser <> '' then
        Headers := Headers + [TNetHeader.Create('Authorization', BasicAuthHeader(BUser, BPass))];

    Http := THTTPClient.Create;
    Src := TStringStream.Create(Body, TEncoding.UTF8);
    try
        Http.ConnectionTimeout := FConnectionTimeout;
        Http.ResponseTimeout := FResponseTimeout;
        try
            Resp := Http.Post(Url, Src, nil, Headers);
        except
            on E: ENetException do
                raise EECreditApiError.CreateHttp(0, 'Serverul eCredit nu raspunde: ' + E.Message);
        end;
        Code := Resp.StatusCode;
        FLastHttpCode := Code;
        FLastResponse := Resp.ContentAsString(TEncoding.UTF8);
    finally
        Src.Free;
        Http.Free;
    end;

    V := TJSONObject.ParseJSONValue(FLastResponse);
    if Code = 401 then
    begin
        // Doua feluri de 401: (a) nginx/gateway-ul respinge antetul Basic (corp HTML sau gol);
        // (b) gateway-ul a trimis cererea la Core System, iar acela a respins Login/Password-ul din
        // corp - raspunsul e JSON {"request": {...}, "response": {"Status": "Invalid User Name / Password - 50000"}}.
        // (c) in PRODUCTION gateway-ul verifica singur contul din corp: {"detail": "Authentication failed"}.
        Msg := '';
        if V is TJSONObject then
        begin
            Msg := JStr(JObj(TJSONObject(V), 'response'), 'Status');
            if Msg = '' then
                Msg := JStr(TJSONObject(V), 'detail');
        end;
        V.Free;
        if Pos('authentication failed', LowerCase(Msg)) > 0 then
            raise EECreditApiError.CreateHttp(Code, Format('api.ecredit.md (%s): %s. Contul din corpul cererii ' +
                '(Login "%s") nu e acceptat in acest mediu. In PRODUCTION se folosesc USERNAME / PASSWORD = contul ' +
                'de productie Easy Credit Core System (cel care deschide api.ecredit.md/docs); in TEST ' +
                'TEST_USERNAME / TEST_PASSWORD. Setari > Configurari API, codul ECREDIT.',
                [FConfig.Environment, Msg, FConfig.Login]))
        else if Msg <> '' then
            raise EECreditApiError.CreateHttp(Code, Format('Easy Credit Core System (%s) a respins contul din corpul ' +
                'cererii: %s. Login folosit: "%s". In mediul TEST se folosesc TEST_USERNAME / TEST_PASSWORD ' +
                '(contul UAT dat de eCredit), in PRODUCTION contul magazinului (USERNAME / PASSWORD) - ' +
                'Setari > Configurari API, codul ECREDIT.', [FConfig.Environment, Msg, FConfig.Login]))
        else
            raise EECreditApiError.CreateHttp(Code, 'api.ecredit.md a respins autentificarea HTTP Basic (401). ' +
                'Verificati BASIC_USER / BASIC_PASSWORD (contul de productie Core System) sau USERNAME / PASSWORD ' +
                'in Setari > Configurari API, codul ECREDIT.');
    end;

    if not (V is TJSONObject) then
    begin
        V.Free;
        raise EECreditApiError.CreateHttp(Code, Format('Raspuns eCredit neasteptat (HTTP %d) la %s: %s',
            [Code, AMethod, Copy(FLastResponse, 1, 300)]));
    end;
    Result := TJSONObject(V);

    // despachetam {"request": {...}, "response": {...}}
    Inner := JObj(Result, 'response');
    if Assigned(Inner) and (Result.GetValue('request') <> nil) then
    begin
        Inner := TJSONObject(Inner.Clone);
        FreeAndNil(Result);
        Result := Inner;
    end;

    if ((Code < 200) or (Code > 299)) and (Code <> AAlsoOkCode) then
    begin
        Msg := JStr(Result, 'Status');
        if Msg = '' then
            Msg := ValidationMessage(Result);
        FreeAndNil(Result);
        raise EECreditApiError.CreateHttp(Code, Format('eCredit %s: HTTP %d. %s', [AMethod, Code, Msg]));
    end;
end;

procedure TECreditApiClient.CheckStatus(AObj: TJSONObject; const AMethod: string);
var
    S, M: string;
begin
    S := JStr(AObj, 'Status');
    if ECreditIsErrorStatus(S) then
    begin
        M := JStr(AObj, 'Message');
        if M = '' then
            M := JStr(AObj, 'Info');
        if M <> '' then
            S := S + ' - ' + Copy(M, 1, 300);
        raise EECreditApiError.CreateHttp(FLastHttpCode, Format('eCredit %s: %s', [AMethod, S]));
    end;
end;

function TECreditApiClient.ShopProducts: TArray<TECreditProduct>;
var
    B, O, Item: TJSONObject;
    Info, Parsed, V: TJSONValue;
    Arr: TJSONArray;
    P: TECreditProduct;
begin
    Result := nil;
    B := TJSONObject.Create;
    if FConfig.ShopGroupID <> '' then
        B.AddPair('ShopGroupID', FConfig.ShopGroupID);
    O := Post('ECM_ShopProducts', B);
    try
        CheckStatus(O, 'ECM_ShopProducts');
        Info := O.GetValue('Info');
        Parsed := nil;
        try
            // Info poate veni ca text JSON impachetat
            if Info is TJSONString then
            begin
                Parsed := TJSONObject.ParseJSONValue(TJSONString(Info).Value);
                Info := Parsed;
            end;
            Arr := FindArray(Info);
            if Assigned(Arr) then
                for V in Arr do
                    if V is TJSONObject then
                    begin
                        Item := TJSONObject(V);
                        P := Default(TECreditProduct);
                        P.ID := StrToIntDef(FirstNonEmpty([JStr(Item, 'ProductID'), JStr(Item, 'ProductId'),
                            JStr(Item, 'ID'), JStr(Item, 'Id'), JStr(Item, 'ProdID')]), 0);
                        P.Name := FirstNonEmpty([JStr(Item, 'ProductName'), JStr(Item, 'Name'),
                            JStr(Item, 'Product'), JStr(Item, 'Title'), JStr(Item, 'ProdName')]);
                        P.FromAPI := True;
                        P.MinAmount := JFloat(Item, 'MinAmount');
                        P.MaxAmount := JFloat(Item, 'MaxAmount');
                        P.MinInstallments := JInt(Item, 'MinInstallments');
                        P.MaxInstallments := JInt(Item, 'MaxInstallments');
                        P.FirstPaymentAfter := JInt(Item, 'FirstPaymentAfter');
                        P.MinDaysAfter := JInt(Item, 'MinDaysAfter');
                        P.Group := JStr(Item, 'ProductGroup');
                        P.ProductClass := JStr(Item, 'ProductClass');
                        if P.ID > 0 then
                        begin
                            if P.Name = '' then
                                P.Name := 'Produs ' + IntToStr(P.ID);
                            SetLength(Result, Length(Result) + 1);
                            Result[High(Result)] := P;
                        end;
                    end;
        finally
            Parsed.Free;
        end;
    finally
        O.Free;
    end;
end;

function TECreditApiClient.InstallmentCalc(const AProductID: Integer; const AAmount: Currency;
    const AFirstDate: TDateTime; const AInstallments: Integer): TECreditCalc;
var
    B, O: TJSONObject;
begin
    Result := Default(TECreditCalc);
    B := TJSONObject.Create;
    B.AddPair('ProductID', JIntNum(AProductID));
    B.AddPair('LoanAmount', JNum(AAmount));
    B.AddPair('FirstInstallmentDate', ECreditDateText(AFirstDate));
    B.AddPair('Installments', JIntNum(AInstallments));
    O := Post('ECM_InstallmentCalc', B);
    try
        CheckStatus(O, 'ECM_InstallmentCalc');
        Result.Status := JStr(O, 'Status');
        Result.InstallmentAmount := JFloat(O, 'InstallmentAmount');
        Result.InterestRate := JFloat(O, 'InterestRate');
        Result.CommissionRate := JFloat(O, 'CommissionRate');
        Result.DAE := JFloat(O, 'DAE');
        Result.FixedExpenses := JFloat(O, 'Fixedexpenses');
        Result.PayableByConsumer := JFloat(O, 'PayablebyConsumer');
    finally
        O.Free;
    end;
end;

function TECreditApiClient.Preapproved(const AUIN: string; const ABirthDate: TDateTime;
    const APhone: string): TECreditClientInfo;
var
    B, O: TJSONObject;
begin
    Result := Default(TECreditClientInfo);
    B := TJSONObject.Create;
    B.AddPair('UIN', AUIN);
    B.AddPair('BirthDate', ECreditDateText(ABirthDate));
    B.AddPair('Phone', APhone);
    O := Post('Preapproved_v2_1', B, 404);
    try
        // 404 "Wrong Customer - 50000" e un raspuns valid aici: clientul nu e in baza eCredit
        Result.Status := JStr(O, 'Status');
        if (FLastHttpCode = 404) and (Result.Status = '') then
            Result.Status := 'Wrong Customer';
        Result.FirstName := JStr(O, 'FirstName');
        Result.LastName := JStr(O, 'LastName');
        Result.FatherName := JStr(O, 'FatherName');
        Result.BirthDate := JStr(O, 'BirthDate');
        Result.UpId := JStr(O, 'UpId');
        Result.MaxESimplu := JFloat(O, 'MaxAutoApproveAmountForeSimplu');
        Result.MaxReuseste := JFloat(O, 'MaxAutoApproveAmountForReuseste');
    finally
        O.Free;
    end;
end;

function TECreditApiClient.SendRequest(const R: TECreditRequest): TECreditRequestResult;
var
    B, O: TJSONObject;
begin
    Result := Default(TECreditRequestResult);
    B := TJSONObject.Create;
    if FConfig.RequestMethod = 'Request_v4' then
    begin
        B.AddPair('ProductID', JIntNum(R.ProductID));
        if R.ShopID > 0 then
            B.AddPair('ShopID', JIntNum(R.ShopID));
    end
    else
        B.AddPair('Product', JIntNum(R.ProductID));
    B.AddPair('UIN', R.UIN);
    B.AddPair('ApDateOfBirth', ECreditDateText(R.BirthDate));
    B.AddPair('ApFirstName', R.FirstName);
    B.AddPair('ApLastName', R.LastName);
    if R.FatherName <> '' then
        B.AddPair('ApFatherName', R.FatherName);
    B.AddPair('CaMobile', R.Mobile);
    if R.Email <> '' then
        B.AddPair('CaMail', R.Email);
    B.AddPair('GoodsName', R.GoodsName);
    B.AddPair('GoodsPrice', JNum(R.GoodsPrice));
    B.AddPair('CreditAmount', JNum(R.CreditAmount));
    B.AddPair('NumberOfInstallments', JIntNum(R.Installments));
    B.AddPair('FirstInstallmentDate', ECreditDateText(R.FirstInstallmentDate));
    if R.IdCard <> '' then
        B.AddPair('IdCard', R.IdCard);
    if R.UtmSource <> '' then
        B.AddPair('UtmSource', R.UtmSource);
    if R.UtmCampaign <> '' then
        B.AddPair('UtmCampaign', R.UtmCampaign);
    O := Post(FConfig.RequestMethod, B);
    try
        Result.URN := Trim(JStr(O, 'URN'));
        Result.Status := JStr(O, 'Status');
        if not ECreditIsValidURN(Result.URN) then
            raise EECreditApiError.CreateHttp(FLastHttpCode, 'eCredit nu a acceptat cererea: ' +
                FirstNonEmpty([Result.Status, JStr(O, 'Message'), Copy(FLastResponse, 1, 300)]));
    finally
        O.Free;
    end;
end;

// URNStatus_v9 pica uneori in gateway ("Unexpected element ...CreationDate", 20.10.2026) -
// se incearca pe rind v9, v8, v4, v3, v2 (toate au RequestStatus / DocumentStatus; v6/v7 au doar ID-uri).
function TECreditApiClient.GetStatus(const AURN: string): TECreditStatus;
const
    cMethods: array[0..4] of string = ('URNStatus_v9', 'URNStatus_v8', 'URNStatus_v4', 'URNStatus_v3', 'URNStatus_v2');
var
    B, O: TJSONObject;
    I: Integer;
    S, M: string;
begin
    Result := Default(TECreditStatus);
    O := nil;
    for I := Low(cMethods) to High(cMethods) do
    begin
        B := TJSONObject.Create;
        B.AddPair('URN', AURN);
        O := Post(cMethods[I], B);
        S := JStr(O, 'Status');
        M := JStr(O, 'Message');
        // raspuns de la Core System, nu de la gateway: statutul cererii e completat
        if (JStr(O, 'RequestStatus') <> '') or not ECreditIsErrorStatus(S) then
            Break;
        if (I = High(cMethods)) or (Pos('unexpected element', LowerCase(M)) = 0) then
        begin
            // eroare reala (URN gresit etc.) sau am epuizat versiunile
            O.Free;
            raise EECreditApiError.CreateHttp(FLastHttpCode, Format('eCredit %s: %s', [cMethods[I],
                Trim(S + ' - ' + M)]));
        end;
        FreeAndNil(O);
    end;
    try
        CheckStatus(O, FLastMethod);
        Result.URN := FirstNonEmpty([JStr(O, 'URN'), AURN]);
        Result.UIN := JStr(O, 'UIN');
        Result.RequestStatus := JStr(O, 'RequestStatus');
        Result.RequestStatusID := JStr(O, 'RequestStatusID');
        Result.DocumentStatus := JStr(O, 'DocumentStatus');
        Result.DocumentStatusID := JStr(O, 'DocumentStatusID');
        Result.LoanStatus := JStr(O, 'LoanStatus');
        Result.Message := JStr(O, 'Message');
        Result.ReadyForSign := JStr(O, 'ReadyForSign');
        Result.PaymentDate := JStr(O, 'PaymentDate');
        Result.ClosedDate := JStr(O, 'ClosedDate');
        Result.FirstName := JStr(O, 'FirstName');
        Result.LastName := JStr(O, 'LastName');
        Result.FatherName := JStr(O, 'FatherName');
        Result.Mobile := JStr(O, 'Mobile');
        Result.Email := JStr(O, 'Email');
        Result.GoodsName := JStr(O, 'GoodsName');
        Result.LoanAmount := JFloat(O, 'LoanAmount');
        Result.GoodsPrice := JFloat(O, 'GoodsPrice');
        Result.InstallmentAmount := JFloat(O, 'InstallmentAmount');
        Result.InterestRate := JFloat(O, 'InterestRate');
        Result.CommissionRate := JFloat(O, 'CommissionRate');
        Result.PayableByConsumer := JFloat(O, 'PayablebyConsumer');
        Result.Installments := JInt(O, 'Installments');
    finally
        O.Free;
    end;
end;

function TECreditApiClient.GetContract(const AURN: string; const ALang: string): TBytes;
var
    B, O: TJSONObject;
    S: string;
begin
    Result := nil;
    B := TJSONObject.Create;
    B.AddPair('URN', AURN);
    B.AddPair('Lang', ALang);
    O := Post('ECM_GetDocs_V2', B);
    try
        CheckStatus(O, 'ECM_GetDocs_V2');
        S := JStr(O, 'DocTypeA');
        if Trim(S) = '' then
            raise EECreditApiError.CreateHttp(FLastHttpCode, 'eCredit nu a intors contractul (DocTypeA gol): ' +
                FirstNonEmpty([JStr(O, 'Status'), Copy(FLastResponse, 1, 200)]));
        Result := TNetEncoding.Base64.DecodeStringToBytes(S);
        if Length(Result) = 0 then
            raise EECreditApiError.CreateHttp(FLastHttpCode, 'Contractul primit de la eCredit nu a putut fi decodat.');
    finally
        O.Free;
    end;
end;

function TECreditApiClient.UploadFiles(const AURN: string; const AFiles: array of string): TECreditUploadResult;
var
    Http: THTTPClient;
    Form: TMultipartFormData;
    Resp: IHTTPResponse;
    Headers: TNetHeaders;
    Url, BUser, BPass, Names, Mime, Msg: string;
    V, D, FV: TJSONValue;
    Detail, Dest, FO: TJSONObject;
    Code, I: Integer;
begin
    Result := Default(TECreditUploadResult);
    if Length(AFiles) = 0 then
        raise EECreditApiError.CreateHttp(0, 'Nu sint fisiere de trimis.');

    Url := Trim(FConfig.FilesURL);
    while (Url <> '') and (Url[Length(Url)] = '/') do
        Delete(Url, Length(Url), 1);
    Url := Url + '/api/' + FConfig.Environment + '/files/upload';

    Names := '';
    Form := TMultipartFormData.Create;
    try
        Form.AddField('Login', FConfig.Login);
        Form.AddField('Password', FConfig.Password);
        Form.AddField('URN', AURN);
        Form.AddField('message_lang', 'RO');
        if Length(Trim(FConfig.ShopContact)) >= 3 then
            Form.AddField('ShopContact', Copy(Trim(FConfig.ShopContact), 1, 35));
        if Trim(FConfig.ShopEmail) <> '' then
            Form.AddField('ShopEmail', Trim(FConfig.ShopEmail));
        if Length(ECreditNormalizePhone(FConfig.ShopPhone)) = 9 then
            Form.AddField('ShopPhone', ECreditNormalizePhone(FConfig.ShopPhone));
        for I := Low(AFiles) to High(AFiles) do
        begin
            Mime := ECreditMimeType(AFiles[I]);
            if Mime = '' then
                raise EECreditApiError.CreateHttp(0, 'Tip de fisier neacceptat de eCredit: ' + ExtractFileName(AFiles[I]) +
                    ' (se accepta jpg, png, pdf, bmp, tiff, webp, heic).');
            if not FileExists(AFiles[I]) then
                raise EECreditApiError.CreateHttp(0, 'Fisierul nu exista: ' + AFiles[I]);
            Form.AddFile('files', AFiles[I], Mime);
            if Names <> '' then
                Names := Names + ', ';
            Names := Names + ExtractFileName(AFiles[I]);
        end;

        FLastMethod := 'files/upload';
        FLastRequest := 'POST ' + Url + sLineBreak + Format('multipart: URN=%s, Login=%s, files=[%s]',
            [AURN, FConfig.Login, Names]);
        FLastResponse := '';
        FLastHttpCode := 0;

        BUser := FConfig.BasicUser;
        BPass := FConfig.BasicPassword;
        if BUser = '' then
        begin
            BUser := FConfig.Login;
            BPass := FConfig.Password;
        end;
        Headers := [TNetHeader.Create('Accept', 'application/json')];
        if BUser <> '' then
            Headers := Headers + [TNetHeader.Create('Authorization', BasicAuthHeader(BUser, BPass))];

        Http := THTTPClient.Create;
        try
            Http.ConnectionTimeout := FConnectionTimeout;
            Http.ResponseTimeout := Max(FResponseTimeout, 120000);  // PDF-ul se face pe server
            try
                Resp := Http.Post(Url, Form, nil, Headers);
            except
                on E: ENetException do
                    raise EECreditApiError.CreateHttp(0, 'Serverul partener.ecredit.md nu raspunde: ' + E.Message);
            end;
            Code := Resp.StatusCode;
            FLastHttpCode := Code;
            FLastResponse := Resp.ContentAsString(TEncoding.UTF8);
        finally
            Http.Free;
        end;
    finally
        Form.Free;
    end;

    if Code = 401 then
        raise EECreditApiError.CreateHttp(Code, 'partener.ecredit.md a respins autentificarea HTTP Basic (401). ' +
            'Verificati USERNAME / PASSWORD (sau BASIC_USER / BASIC_PASSWORD) in Setari > Configurari API, codul ECREDIT.');

    V := TJSONObject.ParseJSONValue(FLastResponse);
    try
        if not (V is TJSONObject) then
            raise EECreditApiError.CreateHttp(Code, Format('Raspuns neasteptat de la partener.ecredit.md (HTTP %d): %s',
                [Code, Copy(FLastResponse, 1, 300)]));
        D := TJSONObject(V).GetValue('detail');
        if D is TJSONArray then
            raise EECreditApiError.CreateHttp(Code, Format('Fisiere eCredit: HTTP %d. %s',
                [Code, ValidationMessage(TJSONObject(V))]));
        Detail := nil;
        if D is TJSONObject then
            Detail := TJSONObject(D);
        if Assigned(Detail) then
        begin
            Result.Status := JStr(Detail, 'status');
            Result.Message := JStr(Detail, 'message');
            Result.Count := JInt(Detail, 'count');
            Result.Errors := JInt(Detail, 'errors');
            FV := Detail.GetValue('files');
            if FV is TJSONArray then
                for I := 0 to TJSONArray(FV).Count - 1 do
                    if TJSONArray(FV).Items[I] is TJSONObject then
                    begin
                        FO := TJSONObject(TJSONArray(FV).Items[I]);
                        if Result.FilesText <> '' then
                            Result.FilesText := Result.FilesText + '; ';
                        Result.FilesText := Result.FilesText + JStr(FO, 'filename') + ': ' + JStr(FO, 'message');
                    end;
            Dest := JObj(Detail, 'destination');
            if Assigned(Dest) then
            begin
                Result.Url := JStr(Dest, 'url');
                Result.Filename := JStr(Dest, 'filename');
                Result.DocType := JStr(Dest, 'doc_type');
                Result.Pages := JInt(Dest, 'pages');
                if Result.Message = '' then
                    Result.Message := JStr(Dest, 'message');
            end;
        end;
        if (Code < 200) or (Code > 299) or (UpperCase(Result.Status) <> 'OK') then
        begin
            Msg := Result.Message;
            if Result.FilesText <> '' then
                Msg := Trim(Msg + ' ' + Result.FilesText);
            if Msg = '' then
                Msg := Copy(FLastResponse, 1, 300);
            raise EECreditApiError.CreateHttp(Code, Format('Fisiere eCredit: HTTP %d. %s', [Code, Msg]));
        end;
    finally
        V.Free;
    end;
end;

procedure TECreditApiClient.CancelRequest(const AURN, AComments: string);
var
    B, O: TJSONObject;
begin
    B := TJSONObject.Create;
    B.AddPair('URN', AURN);
    if AComments <> '' then
        B.AddPair('Comments', AComments);
    O := Post('ECM_CancelRequest', B);
    try
        CheckStatus(O, 'ECM_CancelRequest');
    finally
        O.Free;
    end;
end;

end.

unit EFacturaManager;

{
  Fluxul e-Factura prin API pentru facturile WMS (DocTypeID 112, frame25),
  paralel cu exportul manual al XML-ului:

    1. SendInvoice - genereaza XML-ul (EFacturaXmlBuilder) cu un ApiId propriu in
                     AdditionalInformation si il trimite nesemnat (PostInvoices);
                     factura apare in e-Factura la "Facturi noi";
    2. semnarea se face manual in interfata web (semnatura mobila MoldSign);
    3. SyncInvoice - regaseste factura dupa ApiId, preia seria/numarul atribuite
                     si statusul; SP_EFACTURA_SET_NUMBER completeaza FACTURANO.
                     Inchiderea documentului ramane decizia operatorului.

  Credentialele sunt per firma emitenta (TDB_DOCS.DT): fiecare firma are propriul
  utilizator API in e-Factura, deci in TS_API_CONFIG API_CODE = 'EFACTURA_<DT>'
  (ex. EFACTURA_307225 - PRIME STORE, EFACTURA_316910 - Solutii Comerciale).
  Nu exista credentiale implicite: o factura trimisa cu utilizatorul altei firme
  ar fi respinsa sau, mai rau, inregistrata la alta firma.

  Starea se pastreaza in TDB_EFACTURA (DB Model\efactura_api.sql).
}

interface

uses
  System.SysUtils, System.Classes, IBC, EFacturaApiClient;

const
  cEFacturaApiCodePrefix = 'EFACTURA_';

type
  TEFacturaSendResult = record
    InvoiceID: Integer;
    ApiId: string;
    Post: TEFacturaPostResult;
  end;

  TEFacturaSyncResult = record
    Found: Boolean;          // False = inca in procesare la e-Factura
    Seria: string;
    Number: string;
    InvoiceStatus: Integer;
    NumberAssigned: Boolean; // FACTURANO a fost completat la aceasta sincronizare
  end;

  TEFacturaManager = class
  private
    FConnection: TIBCConnection;
    FClient: TEFacturaApiClient;
    FClientFirmaID: Integer; // firma (DT) pentru care e configurat FClient
    FFixedClient: Boolean;   // client dat din exterior - folosit pentru orice firma
    function ClientForFirma(AFirmaID: Integer): TEFacturaApiClient;
    function NewQuery: TIBCQuery;
    procedure ExecInTransaction(AQuery: TIBCQuery);
    function DocFirmaID(ADocID: Integer): Integer;
    procedure ReadSentInvoice(AInvoiceID: Integer; out AApiId, ASeria, ANumber, AFacturaNo: string;
      out AFirmaID: Integer);
    procedure SetNumber(AInvoiceID: Integer; const ASeria, ANumber: string; AInvoiceStatus: Integer);
    // pentru interogari in Registrul fiscal: firma preferata sau prima firma configurata
    function LookupClient(APreferFirmaID: Integer): TEFacturaApiClient;
  public
    // AClient (optional, trece in proprietatea managerului) - in locul credentialelor
    // din TS_API_CONFIG, pentru teste sau servicii fara acces la configurare
    constructor Create(AConnection: TIBCConnection; AClient: TEFacturaApiClient = nil);
    destructor Destroy; override;
    class function ApiCodeForFirma(AFirmaID: Integer): string;
    // unic per trimitere, ca o factura anulata sa poata fi retrimisa
    class function MakeApiId(ADocID: Integer): string;
    // AForceResend - retrimite o factura care n-a aparut niciodata in e-Factura
    function SendInvoice(ADocID, AUserID: Integer; AForceResend: Boolean = False): TEFacturaSendResult;
    function SyncInvoice(AInvoiceID: Integer): TEFacturaSyncResult;
    procedure CancelInvoice(AInvoiceID: Integer; const AComment: string);
    function GetInvoicePdf(AInvoiceID: Integer): TBytes;
    // Datele firmei din Registrul fiscal: denumire, adresa juridica, cod TVA, IBAN-uri.
    function GetCompanyInfo(const AIDNO: string; APreferFirmaID: Integer; out ATaxpayer: TEFacturaTaxpayer;
      out AAccounts: TEFacturaBankAccounts): Boolean;
    // Adauga in TS_CUST_ACCOUNTS IBAN-urile care lipsesc; intoarce cate s-au adaugat.
    function ImportBankAccounts(ACustomerID: Integer; const AAccounts: TEFacturaBankAccounts): Integer;
    // Avertismente inainte de trimitere (Registrul fiscal); '' daca nu e nimic de semnalat.
    function CheckBeforeSend(ADocID: Integer): string;
    // clientul folosit la ultima operatie (diagnostic: LastRequest / LastResponse)
    property Client: TEFacturaApiClient read FClient;
  end;

implementation

uses
  Data.DB, EFacturaXmlBuilder;

{ TEFacturaManager }

constructor TEFacturaManager.Create(AConnection: TIBCConnection; AClient: TEFacturaApiClient);
begin
  inherited Create;
  FConnection := AConnection;
  FClient := AClient;
  FFixedClient := AClient <> nil;
end;

destructor TEFacturaManager.Destroy;
begin
  FClient.Free;
  inherited;
end;

class function TEFacturaManager.ApiCodeForFirma(AFirmaID: Integer): string;
begin
  Result := cEFacturaApiCodePrefix + IntToStr(AFirmaID);
end;

class function TEFacturaManager.MakeApiId(ADocID: Integer): string;
begin
  Result := Format('WMS-%d-%s', [ADocID, FormatDateTime('yymmddhhnnss', Now)]);
end;

function TEFacturaManager.NewQuery: TIBCQuery;
begin
  Result := TIBCQuery.Create(nil);
  Result.Connection := FConnection;
end;

procedure TEFacturaManager.ExecInTransaction(AQuery: TIBCQuery);
var
  Tr: TIBCTransaction;
begin
  Tr := TIBCTransaction.Create(nil);
  try
    Tr.DefaultConnection := FConnection;
    AQuery.AutoCommit := False;
    AQuery.Transaction := Tr;
    Tr.StartTransaction;
    try
      AQuery.ExecSQL;
      Tr.Commit;
    except
      Tr.Rollback;
      raise;
    end;
  finally
    AQuery.Transaction := nil;
    Tr.Free;
  end;
end;

function TEFacturaManager.ClientForFirma(AFirmaID: Integer): TEFacturaApiClient;
var
  Q: TIBCQuery;
  ApiCode, URL, User, Pwd, Name, FirmaName: string;
begin
  if FFixedClient or ((FClient <> nil) and (FClientFirmaID = AFirmaID)) then
    Exit(FClient);

  ApiCode := ApiCodeForFirma(AFirmaID);
  URL := '';
  User := '';
  Pwd := '';
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT PARAM_NAME, PARAM_VALUE FROM TS_API_CONFIG WHERE API_CODE = :API_CODE AND FLG_ACTIVE = 1';
    Q.ParamByName('API_CODE').AsString := ApiCode;
    Q.Open;
    while not Q.Eof do
    begin
      Name := UpperCase(Trim(Q.FieldByName('PARAM_NAME').AsString));
      if Name = 'BASE_URL' then
        URL := Trim(Q.FieldByName('PARAM_VALUE').AsString)
      else if Name = 'USERNAME' then
        User := Trim(Q.FieldByName('PARAM_VALUE').AsString)
      else if Name = 'PASSWORD' then
        Pwd := Trim(Q.FieldByName('PARAM_VALUE').AsString);
      Q.Next;
    end;

    if (User = '') or (Pwd = '') then
    begin
      Q.Close;
      Q.SQL.Text := 'SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID = :CUSTOMERID';
      Q.ParamByName('CUSTOMERID').AsInteger := AFirmaID;
      Q.Open;
      FirmaName := Trim(Q.FieldByName('DISPLAYNAME').AsString);
      raise EEFacturaApiError.CreateFmt('Lipsesc credentialele e-Factura pentru firma %s (cod %d). ' +
        'Completati USERNAME si PASSWORD pentru API_CODE = %s in Setari > Configurari API.',
        [FirmaName, AFirmaID, ApiCode]);
    end;
  finally
    Q.Free;
  end;

  FreeAndNil(FClient);
  FClient := TEFacturaApiClient.Create(URL, User, Pwd);
  FClientFirmaID := AFirmaID;
  Result := FClient;
end;

function TEFacturaManager.DocFirmaID(ADocID: Integer): Integer;
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT DT FROM TDB_DOCS WHERE DOCID = :DOCID';
    Q.ParamByName('DOCID').AsInteger := ADocID;
    Q.Open;
    if Q.IsEmpty then
      raise EEFacturaApiError.CreateFmt('Documentul #%d nu exista.', [ADocID]);
    Result := Q.FieldByName('DT').AsInteger;
  finally
    Q.Free;
  end;
end;

procedure TEFacturaManager.ReadSentInvoice(AInvoiceID: Integer; out AApiId, ASeria, ANumber, AFacturaNo: string;
  out AFirmaID: Integer);
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT E.API_ID, E.SERIA, E.EF_NUMBER, I.FACTURANO, D.DT FROM TDB_EFACTURA E' +
      ' JOIN TDB_INVOICES I ON I.DOCID = E.DOCID AND I.INVOICEID = E.INVOICEID' +
      ' JOIN TDB_DOCS D ON D.DOCID = E.DOCID' +
      ' WHERE E.INVOICEID = :INVOICEID';
    Q.ParamByName('INVOICEID').AsInteger := AInvoiceID;
    Q.Open;
    if Q.IsEmpty then
      raise EEFacturaApiError.Create('Factura nu a fost trimisa in e-Factura prin API.');
    AApiId := Q.FieldByName('API_ID').AsString;
    ASeria := Trim(Q.FieldByName('SERIA').AsString);
    ANumber := Trim(Q.FieldByName('EF_NUMBER').AsString);
    AFacturaNo := Trim(Q.FieldByName('FACTURANO').AsString);
    AFirmaID := Q.FieldByName('DT').AsInteger;
  finally
    Q.Free;
  end;
end;

procedure TEFacturaManager.SetNumber(AInvoiceID: Integer; const ASeria, ANumber: string; AInvoiceStatus: Integer);
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'EXECUTE PROCEDURE SP_EFACTURA_SET_NUMBER(:INVOICEID, :SERIA, :EF_NUMBER, :EF_STATUS)';
    Q.ParamByName('INVOICEID').AsInteger := AInvoiceID;
    Q.ParamByName('SERIA').AsString := ASeria;
    Q.ParamByName('EF_NUMBER').AsString := ANumber;
    Q.ParamByName('EF_STATUS').AsInteger := AInvoiceStatus;
    ExecInTransaction(Q);
  finally
    Q.Free;
  end;
end;

function TEFacturaManager.SendInvoice(ADocID, AUserID: Integer; AForceResend: Boolean): TEFacturaSendResult;
var
  Api: TEFacturaApiClient;
  Builder: TEFacturaXmlBuilder;
  Xml, Err, Ident: string;
  Q: TIBCQuery;
  PrevStatus: Integer;
begin
  Result := Default(TEFacturaSendResult);
  // intai credentialele firmei emitente - fara ele nu are rost sa generam nimic
  Api := ClientForFirma(DocFirmaID(ADocID));

  Result.ApiId := MakeApiId(ADocID);
  Builder := TEFacturaXmlBuilder.Create(FConnection);
  try
    Xml := Builder.Build(ADocID, Result.ApiId);
    Result.InvoiceID := Builder.InvoiceID;
  finally
    Builder.Free;
  end;

  // o factura se trimite o singura data; retrimiterea e permisa dupa anulare
  // sau, explicit, cand trimiterea anterioara nu a aparut niciodata in e-Factura
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT EF_STATUS, API_ID, SERIA, EF_NUMBER FROM TDB_EFACTURA WHERE INVOICEID = :INVOICEID';
    Q.ParamByName('INVOICEID').AsInteger := Result.InvoiceID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      PrevStatus := Q.FieldByName('EF_STATUS').AsInteger;
      if not ((PrevStatus = cEFInvCanceledBySupplier) or ((PrevStatus = cEFInvPending) and AForceResend)) then
      begin
        Ident := Trim(Trim(Q.FieldByName('SERIA').AsString) + ' ' + Trim(Q.FieldByName('EF_NUMBER').AsString));
        if Ident = '' then
          Ident := Q.FieldByName('API_ID').AsString;
        raise EEFacturaApiError.CreateFmt('Factura a fost deja trimisa in e-Factura (%s, %s). ' +
          'Folositi actualizarea statusului.', [Ident, EFacturaStatusName(PrevStatus)]);
      end;
    end;
  finally
    Q.Free;
  end;

  Result.Post := Api.PostInvoices(Xml);
  Err := Result.Post.ErrorMessage;
  if (Err = '') and not (Result.Post.Status in [cEFacturaReqAccepted, cEFacturaReqOk]) then
    Err := 'status ' + IntToStr(Result.Post.Status);
  if (Err = '') and (Result.Post.Status = cEFacturaReqOk) and (Result.Post.TotalInvoicesPosted = 0) then
    Err := 'nicio factura acceptata';
  if Err <> '' then
    raise EEFacturaApiError.Create('e-Factura a respins factura: ' + Err);

  Q := NewQuery;
  try
    Q.SQL.Text := 'UPDATE OR INSERT INTO TDB_EFACTURA (INVOICEID, DOCID, API_ID, REQUEST_ID, SERIA, EF_NUMBER,' +
      ' EF_STATUS, EF_STATUS_DATE, SENT_AT, SENT_BY, XML_SENT, LAST_ERROR)' +
      ' VALUES (:INVOICEID, :DOCID, :API_ID, :REQUEST_ID, NULL, NULL, :EF_STATUS, NULL, CURRENT_TIMESTAMP,' +
      ' :SENT_BY, :XML_SENT, NULL) MATCHING (INVOICEID)';
    Q.ParamByName('INVOICEID').AsInteger := Result.InvoiceID;
    Q.ParamByName('DOCID').AsInteger := ADocID;
    Q.ParamByName('API_ID').AsString := Result.ApiId;
    Q.ParamByName('REQUEST_ID').AsString := Api.LastRequestId;
    Q.ParamByName('EF_STATUS').AsInteger := cEFInvPending;
    Q.ParamByName('SENT_BY').AsInteger := AUserID;
    Q.ParamByName('XML_SENT').AsMemo := Xml;
    try
      ExecInTransaction(Q);
    except
      on E: Exception do
        raise EEFacturaApiError.CreateFmt('Factura a fost trimisa in e-Factura (ID %s), dar starea nu s-a ' +
          'salvat in WMS: %s', [Result.ApiId, E.Message]);
    end;
  finally
    Q.Free;
  end;
end;

function TEFacturaManager.SyncInvoice(AInvoiceID: Integer): TEFacturaSyncResult;
var
  ApiId, Seria, Number, FacturaNo: string;
  FirmaID: Integer;
  Api: TEFacturaApiClient;
  Inv: TEFacturaInvoice;
begin
  Result := Default(TEFacturaSyncResult);
  Result.InvoiceStatus := cEFInvPending;
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID);
  Api := ClientForFirma(FirmaID);

  if (Seria = '') or (Number = '') then
  begin
    if not Api.FindByApiId(ApiId, Inv) then
      Exit;
  end
  else
    Inv := Api.CheckStatus(Seria, Number);

  Result.Found := True;
  Result.Seria := Inv.Seria;
  Result.Number := Inv.Number;
  Result.InvoiceStatus := Inv.InvoiceStatus;
  Result.NumberAssigned := (FacturaNo = '') and (Inv.Seria <> '') and (Inv.Number <> '');
  SetNumber(AInvoiceID, Inv.Seria, Inv.Number, Inv.InvoiceStatus);
end;

procedure TEFacturaManager.CancelInvoice(AInvoiceID: Integer; const AComment: string);
var
  ApiId, Seria, Number, FacturaNo: string;
  FirmaID: Integer;
begin
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID);
  if (Seria = '') or (Number = '') then
    raise EEFacturaApiError.Create('Factura nu are inca serie si numar in e-Factura - actualizati statusul intai.');
  ClientForFirma(FirmaID).CancelInvoice(Seria, Number, AComment);
  SetNumber(AInvoiceID, Seria, Number, cEFInvCanceledBySupplier);
end;

function TEFacturaManager.GetInvoicePdf(AInvoiceID: Integer): TBytes;
var
  ApiId, Seria, Number, FacturaNo: string;
  FirmaID: Integer;
begin
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID);
  if (Seria = '') or (Number = '') then
    raise EEFacturaApiError.Create('Factura nu are inca serie si numar in e-Factura - actualizati statusul intai.');
  Result := ClientForFirma(FirmaID).GetInvoicePdf(Seria, Number);
end;

function TEFacturaManager.LookupClient(APreferFirmaID: Integer): TEFacturaApiClient;
var
  Q: TIBCQuery;
  FirmaID: Integer;
begin
  if FFixedClient or (FClient <> nil) then
    Exit(FClient);

  // orice utilizator API poate citi Registrul fiscal; preferam firma curenta
  FirmaID := 0;
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT U.API_CODE FROM TS_API_CONFIG U' +
      ' WHERE U.API_CODE STARTING WITH :PREFIX AND U.PARAM_NAME = ''USERNAME'' AND U.FLG_ACTIVE = 1' +
      '   AND COALESCE(U.PARAM_VALUE, '''') <> ''''' +
      '   AND EXISTS (SELECT 1 FROM TS_API_CONFIG P WHERE P.API_CODE = U.API_CODE AND P.PARAM_NAME = ''PASSWORD''' +
      '               AND P.FLG_ACTIVE = 1 AND COALESCE(P.PARAM_VALUE, '''') <> '''')' +
      ' ORDER BY IIF(U.API_CODE = :PREFERRED, 0, 1), U.API_CODE';
    Q.ParamByName('PREFIX').AsString := cEFacturaApiCodePrefix;
    Q.ParamByName('PREFERRED').AsString := ApiCodeForFirma(APreferFirmaID);
    Q.Open;
    while (FirmaID = 0) and not Q.Eof do
    begin
      FirmaID := StrToIntDef(Copy(Trim(Q.FieldByName('API_CODE').AsString), Length(cEFacturaApiCodePrefix) + 1,
        MaxInt), 0);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
  if FirmaID = 0 then
    raise EEFacturaApiError.Create('Nu exista nicio firma cu credentiale e-Factura ' +
      '(API_CODE = EFACTURA_<cod firma> in Setari > Configurari API).');
  Result := ClientForFirma(FirmaID);
end;

function TEFacturaManager.GetCompanyInfo(const AIDNO: string; APreferFirmaID: Integer;
  out ATaxpayer: TEFacturaTaxpayer; out AAccounts: TEFacturaBankAccounts): Boolean;
var
  Api: TEFacturaApiClient;
begin
  AAccounts := nil;
  Api := LookupClient(APreferFirmaID);
  Result := Api.GetTaxpayer(Trim(AIDNO), ATaxpayer);
  if Result then
    AAccounts := Api.GetBankAccounts(Trim(AIDNO));
end;

function TEFacturaManager.ImportBankAccounts(ACustomerID: Integer; const AAccounts: TEFacturaBankAccounts): Integer;
// ACCOUNTNUMBER = IBAN, ca la conturile introduse manual. Banca = codul filialei din
// Registrul fiscal (TS_BANKS.BANKACCOUNT); lipsa se adauga, cele existente nu se modifica.
// Primul cont adaugat devine implicit doar daca clientul nu are inca unul implicit.
var
  Q: TIBCQuery;
  Tr: TIBCTransaction;
  Acc: TEFacturaBankAccount;
  HasDefault: Boolean;
begin
  Result := 0;
  Tr := TIBCTransaction.Create(nil);
  Q := NewQuery;
  try
    Tr.DefaultConnection := FConnection;
    Q.AutoCommit := False;
    Q.Transaction := Tr;
    Tr.StartTransaction;
    try
      Q.SQL.Text := 'SELECT COUNT(*) FROM TS_CUST_ACCOUNTS WHERE CUSTOMERID = :CUSTOMERID AND DEFAULT_ACCOUNT = 1';
      Q.ParamByName('CUSTOMERID').AsInteger := ACustomerID;
      Q.Open;
      HasDefault := Q.Fields[0].AsInteger > 0;
      Q.Close;

      for Acc in AAccounts do
      begin
        if (Trim(Acc.AccountNumber) = '') or (Trim(Acc.BranchCode) = '') then
          Continue;

        Q.SQL.Text := 'INSERT INTO TS_BANKS (BANKACCOUNT, BANKNAME)' +
          ' SELECT :BANK1, :BANKNAME FROM RDB$DATABASE' +
          ' WHERE NOT EXISTS (SELECT 1 FROM TS_BANKS B WHERE B.BANKACCOUNT = :BANK2)';
        Q.ParamByName('BANK1').AsString := Trim(Acc.BranchCode);
        Q.ParamByName('BANK2').AsString := Trim(Acc.BranchCode);
        Q.ParamByName('BANKNAME').AsString := Copy(Trim(Acc.BranchTitle), 1, 255);
        Q.ExecSQL;

        Q.SQL.Text := 'INSERT INTO TS_CUST_ACCOUNTS (CUSTOMERID, ACCOUNTNUMBER, ACCOUNTNAME, BANKACCOUNT,' +
          ' DEFAULT_ACCOUNT, IBAN)' +
          ' SELECT :CUST1, :IBAN1, :ACCOUNTNAME, :BANKACCOUNT, :DEFAULT_ACCOUNT, :IBAN2 FROM RDB$DATABASE' +
          ' WHERE NOT EXISTS (SELECT 1 FROM TS_CUST_ACCOUNTS A WHERE A.CUSTOMERID = :CUST2 AND A.ACCOUNTNUMBER = :IBAN3)';
        Q.ParamByName('CUST1').AsInteger := ACustomerID;
        Q.ParamByName('CUST2').AsInteger := ACustomerID;
        Q.ParamByName('IBAN1').AsString := Trim(Acc.AccountNumber);
        Q.ParamByName('IBAN2').AsString := Trim(Acc.AccountNumber);
        Q.ParamByName('IBAN3').AsString := Trim(Acc.AccountNumber);
        Q.ParamByName('ACCOUNTNAME').AsString := Copy(Trim(Acc.BranchTitle), 1, 60);
        Q.ParamByName('BANKACCOUNT').AsString := Trim(Acc.BranchCode);
        if HasDefault then
          Q.ParamByName('DEFAULT_ACCOUNT').AsInteger := 0
        else
          Q.ParamByName('DEFAULT_ACCOUNT').AsInteger := 1;
        Q.ExecSQL;
        if Q.RowsAffected > 0 then
        begin
          Inc(Result);
          HasDefault := True;
        end;
      end;
      Tr.Commit;
    except
      Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

function TEFacturaManager.CheckBeforeSend(ADocID: Integer): string;
// Informativ, nu blocheaza trimiterea: e-Factura accepta si IBAN-uri introduse manual
// sau cumparatori care nu folosesc sistemul (ciclul scurt, cu tipar).
var
  Q: TIBCQuery;
  Api: TEFacturaApiClient;
  W: TStringList;
  FirmaID: Integer;
  SupplierIDNO, BuyerIDNO, SupplierAccount: string;
  Vat: Double;
  Supplier, Buyer: TEFacturaTaxpayer;
  Accounts: TEFacturaBankAccounts;
  Acc: TEFacturaBankAccount;
  Registered: Boolean;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT D.DT,' +
      ' (SELECT CI.IDEN_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.DT) DT_IDNO,' +
      ' (SELECT CI.IDEN_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.CT) CT_IDNO,' +
      ' (SELECT FIRST 1 DR.DT_CD FROM TDB_DOCS_RECHIZITE DR WHERE DR.DOCID = D.DOCID) DT_ACCOUNT,' +
      ' (SELECT SUM(P.SUMAVAT) FROM GET_GOODS_FOR_RECEIPT(D.DOCID) P) SUMAVAT' +
      ' FROM TDB_DOCS D WHERE D.DOCID = :DOCID';
    Q.ParamByName('DOCID').AsInteger := ADocID;
    Q.Open;
    if Q.IsEmpty then
      raise EEFacturaApiError.CreateFmt('Documentul #%d nu exista.', [ADocID]);
    FirmaID := Q.FieldByName('DT').AsInteger;
    SupplierIDNO := Trim(Q.FieldByName('DT_IDNO').AsString);
    BuyerIDNO := Trim(Q.FieldByName('CT_IDNO').AsString);
    SupplierAccount := Trim(Q.FieldByName('DT_ACCOUNT').AsString);
    Vat := Q.FieldByName('SUMAVAT').AsFloat;
  finally
    Q.Free;
  end;

  Api := ClientForFirma(FirmaID);
  W := TStringList.Create;
  try
    if (SupplierIDNO <> '') and Api.GetTaxpayer(SupplierIDNO, Supplier) then
    begin
      if (Supplier.CodTVA = '') and (Abs(Vat) >= 0.01) then
        W.Add(Format('Furnizorul nu este platitor de TVA (fara cod TVA in Registrul fiscal), dar factura are ' +
          'TVA de %.2f lei.', [Vat]));
      Accounts := Api.GetBankAccounts(SupplierIDNO);
      Registered := False;
      for Acc in Accounts do
        if SameText(Trim(Acc.AccountNumber), SupplierAccount) then
          Registered := True;
      if Length(Accounts) = 0 then
        W.Add('Furnizorul nu are niciun cont bancar inregistrat in Registrul fiscal.')
      else if SupplierAccount = '' then
        W.Add('Documentul nu are indicat contul bancar al furnizorului.')
      else if not Registered then
        W.Add('Contul furnizorului ' + SupplierAccount + ' nu este inregistrat in Registrul fiscal.');
    end;

    if BuyerIDNO <> '' then
    begin
      if not Api.GetTaxpayer(BuyerIDNO, Buyer) or not Buyer.ExistInTaxRegistry then
        W.Add('Cumparatorul (IDNO ' + BuyerIDNO + ') nu a fost gasit in Registrul fiscal.')
      else if not Buyer.IsEFacturaActor then
        W.Add('Cumparatorul nu foloseste e-Factura: factura se va tipari si semna olograf (ciclul scurt).');
    end;
    Result := Trim(W.Text);
  finally
    W.Free;
  end;
end;
end.

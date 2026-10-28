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
    Found: Boolean;          // False = inca in procesare la e-Factura (sau respinsa - vezi Rejected)
    Seria: string;
    Number: string;
    InvoiceStatus: Integer;
    NumberAssigned: Boolean; // FACTURANO a fost completat la aceasta sincronizare
    Rejected: Boolean;       // e-Factura a respins factura la procesare (stare cEFInvRejected)
    Message: string;         // motivul respingerii, cum l-a intors e-Factura
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
      out AFirmaID: Integer); overload;
    procedure ReadSentInvoice(AInvoiceID: Integer; out AApiId, ASeria, ANumber, AFacturaNo: string;
      out AFirmaID, AStatus: Integer); overload;
    procedure SetNumber(AInvoiceID: Integer; const ASeria, ANumber: string; AInvoiceStatus: Integer);
    // doar starea WMS (fara serie/numar) + motivul, pentru starile -1 / -3
    procedure SetState(AInvoiceID, AStatus: Integer; const AError: string);
    // randul TDB_EFACTURA al unei trimiteri: in procesare (fara eroare) sau respinsa sincron de
    // PostInvoices (-3 + motivul), ca mesajul si XML-ul trimis sa nu se piarda
    procedure SaveSendResult(AInvoiceID, ADocID: Integer; const AApiId, ARequestId: string;
      AStatus, AUserID: Integer; const AXml, AError: string);
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
    // Factura trimisa, fara serie/numar, care nu apare in e-Factura (respinsa la procesare):
    // CheckNotSent cauta in e-Factura dupa ApiId (toate statusurile) - daca o gaseste cu numar,
    // actualizeaza statusul si ridica eroare; altfel intoarce facturile catre acelasi cumparator,
    // inregistrate dupa trimitere si necunoscute in WMS ('' = nimic), ca utilizatorul sa verifice.
    // MarkNotSent o trece in cEFInvRejected - WMS permite apoi stergerea sau retrimiterea.
    function CheckNotSent(AInvoiceID: Integer): string;
    procedure MarkNotSent(AInvoiceID: Integer; const AUserName: string);
    // Codul TVA al furnizorului trebuie sa se potriveasca cu TVA-ul randurilor - altfel e-Factura
    // respinge factura la procesare, fara mesaj in raspunsul la PostInvoices
    class procedure CheckVatConsistency(const AInvoicesXml: string);
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
  Data.DB, System.DateUtils, System.RegularExpressions, EFacturaXmlBuilder;

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
  Status: Integer;
begin
  ReadSentInvoice(AInvoiceID, AApiId, ASeria, ANumber, AFacturaNo, AFirmaID, Status);
end;

procedure TEFacturaManager.ReadSentInvoice(AInvoiceID: Integer; out AApiId, ASeria, ANumber, AFacturaNo: string;
  out AFirmaID, AStatus: Integer);
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT E.API_ID, E.SERIA, E.EF_NUMBER, E.EF_STATUS, I.FACTURANO, D.DT FROM TDB_EFACTURA E' +
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
    AStatus := Q.FieldByName('EF_STATUS').AsInteger;
  finally
    Q.Free;
  end;
end;

procedure TEFacturaManager.SetState(AInvoiceID, AStatus: Integer; const AError: string);
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'UPDATE TDB_EFACTURA SET EF_STATUS = :EF_STATUS, EF_STATUS_DATE = CURRENT_TIMESTAMP,' +
      ' LAST_ERROR = :LAST_ERROR WHERE INVOICEID = :INVOICEID';
    Q.ParamByName('EF_STATUS').AsInteger := AStatus;
    Q.ParamByName('LAST_ERROR').DataType := ftString;
    if AError = '' then
      Q.ParamByName('LAST_ERROR').Clear
    else
      Q.ParamByName('LAST_ERROR').AsString := Copy(AError, 1, 1024);
    Q.ParamByName('INVOICEID').AsInteger := AInvoiceID;
    ExecInTransaction(Q);
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

  // o factura se trimite o singura data; retrimiterea e permisa dupa anulare, dupa respingerea la
  // procesare sau, explicit, cand trimiterea anterioara nu a aparut niciodata in e-Factura
  Q := NewQuery;
  try
    Q.SQL.Text := 'SELECT EF_STATUS, API_ID, SERIA, EF_NUMBER FROM TDB_EFACTURA WHERE INVOICEID = :INVOICEID';
    Q.ParamByName('INVOICEID').AsInteger := Result.InvoiceID;
    Q.Open;
    if not Q.IsEmpty then
    begin
      PrevStatus := Q.FieldByName('EF_STATUS').AsInteger;
      if not ((PrevStatus = cEFInvCanceledBySupplier) or (PrevStatus = cEFInvRejected) or
        ((PrevStatus = cEFInvPending) and AForceResend)) then
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

  CheckVatConsistency(Xml);

  Result.Post := Api.PostInvoices(Xml);
  Err := Result.Post.ErrorMessage;
  if (Err = '') and not (Result.Post.Status in [cEFacturaReqAccepted, cEFacturaReqOk]) then
    Err := 'status ' + IntToStr(Result.Post.Status);
  if (Err = '') and (Result.Post.Status = cEFacturaReqOk) and (Result.Post.TotalInvoicesPosted = 0) then
    Err := 'nicio factura acceptata';
  if Err <> '' then
  begin
    // respingere sincrona: pastram motivul si XML-ul (coloana EF_LAST_ERROR in frame25) - starea -3
    // permite corectarea documentului si retrimiterea; daca nici salvarea nu merge, ramane mesajul API
    try
      SaveSendResult(Result.InvoiceID, ADocID, Result.ApiId, Api.LastRequestId, cEFInvRejected, AUserID,
        Xml, 'Respinsa la trimitere: ' + Err);
    except
    end;
    raise EEFacturaApiError.Create('e-Factura a respins factura: ' + Err);
  end;

  try
    SaveSendResult(Result.InvoiceID, ADocID, Result.ApiId, Api.LastRequestId, cEFInvPending, AUserID, Xml, '');
  except
    on E: Exception do
      raise EEFacturaApiError.CreateFmt('Factura a fost trimisa in e-Factura (ID %s), dar starea nu s-a ' +
        'salvat in WMS: %s', [Result.ApiId, E.Message]);
  end;
end;

procedure TEFacturaManager.SaveSendResult(AInvoiceID, ADocID: Integer; const AApiId, ARequestId: string;
  AStatus, AUserID: Integer; const AXml, AError: string);
var
  Q: TIBCQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'UPDATE OR INSERT INTO TDB_EFACTURA (INVOICEID, DOCID, API_ID, REQUEST_ID, SERIA, EF_NUMBER,' +
      ' EF_STATUS, EF_STATUS_DATE, SENT_AT, SENT_BY, XML_SENT, LAST_ERROR)' +
      ' VALUES (:INVOICEID, :DOCID, :API_ID, :REQUEST_ID, NULL, NULL, :EF_STATUS, NULL, CURRENT_TIMESTAMP,' +
      ' :SENT_BY, :XML_SENT, :LAST_ERROR) MATCHING (INVOICEID)';
    Q.ParamByName('INVOICEID').AsInteger := AInvoiceID;
    Q.ParamByName('DOCID').AsInteger := ADocID;
    Q.ParamByName('API_ID').AsString := AApiId;
    Q.ParamByName('REQUEST_ID').AsString := ARequestId;
    Q.ParamByName('EF_STATUS').AsInteger := AStatus;
    Q.ParamByName('SENT_BY').AsInteger := AUserID;
    Q.ParamByName('XML_SENT').AsMemo := AXml;
    Q.ParamByName('LAST_ERROR').DataType := ftString;
    if AError = '' then
      Q.ParamByName('LAST_ERROR').Clear
    else
      Q.ParamByName('LAST_ERROR').AsString := Copy(AError, 1, 1024);
    ExecInTransaction(Q);
  finally
    Q.Free;
  end;
end;

function TEFacturaManager.SyncInvoice(AInvoiceID: Integer): TEFacturaSyncResult;
var
  ApiId, Seria, Number, FacturaNo: string;
  FirmaID, PrevStatus: Integer;
  Api: TEFacturaApiClient;
  Inv: TEFacturaInvoice;
begin
  Result := Default(TEFacturaSyncResult);
  Result.InvoiceStatus := cEFInvPending;
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID, PrevStatus);
  Api := ClientForFirma(FirmaID);

  if (Seria = '') or (Number = '') then
  begin
    if not Api.FindByApiId(ApiId, Inv) then
    begin
      // vazuta anterior (fara numar) si disparuta intre timp: inapoi "in procesare", nu ramine blocata
      // intr-un status care nu permite nicio actiune; respinsa ramane respinsa
      if PrevStatus = cEFInvRejected then
        Result.InvoiceStatus := cEFInvRejected
      else if PrevStatus <> cEFInvPending then
        SetState(AInvoiceID, cEFInvPending, '');
      Exit;
    end;

    // rezultat de eroare = respingerea asincrona a facturii (motivul in Message)
    if Inv.Status = cEFacturaReqError then
    begin
      Result.Rejected := True;
      Result.InvoiceStatus := cEFInvRejected;
      Result.Message := Trim(Inv.Message);
      if Result.Message = '' then
        Result.Message := 'e-Factura a respins factura fara a indica motivul.';
      SetState(AInvoiceID, cEFInvRejected, Result.Message);
      Exit;
    end;

    // gasita, dar inca fara serie/numar: o tratam ca "in procesare" (nu ca Draft fara numar)
    if (Inv.Seria = '') or (Inv.Number = '') then
    begin
      if PrevStatus <> cEFInvPending then
        SetState(AInvoiceID, cEFInvPending, Trim(Inv.Message));
      Exit;
    end;
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

function TEFacturaManager.CheckNotSent(AInvoiceID: Integer): string;
const
  // toate statusurile in afara de anulata - o factura anulata nu e o copie activa
  cStatuses: array[0..7] of Integer = (cEFInvDraft, cEFInvSignedBySupplier, cEFInvSentToBuyer,
    cEFInvSignedByBuyer, cEFInvAcceptedByBuyer, cEFInvTransported, cEFInvRejectedByBuyer, cEFInvArchived);
var
  ApiId, Seria, Number, FacturaNo, BuyerIDNO, Ident: string;
  FirmaID, PrevStatus, St: Integer;
  SentAt: TDateTime;
  Api: TEFacturaApiClient;
  Inv: TEFacturaInvoice;
  Search: TEFacturaSearch;
  Found: TEFacturaInvoices;
  Q: TIBCQuery;
  Unknown: TStringList;
  M: TMatch;
begin
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID, PrevStatus);
  if (Seria <> '') and (Number <> '') then
    raise EEFacturaApiError.CreateFmt('Factura are serie si numar in e-Factura (%s %s) - folositi anularea.',
      [Seria, Number]);
  Api := ClientForFirma(FirmaID);

  // 1. dupa identificatorul nostru, in toate statusurile
  if Api.FindByApiId(ApiId, Inv) and (Inv.Status <> cEFacturaReqError) and (Inv.Seria <> '') and
    (Inv.Number <> '') then
  begin
    SetNumber(AInvoiceID, Inv.Seria, Inv.Number, Inv.InvoiceStatus);
    raise EEFacturaApiError.CreateFmt('Factura exista in e-Factura: %s %s (%s). Statusul a fost actualizat.',
      [Inv.Seria, Inv.Number, EFacturaStatusName(Inv.InvoiceStatus)]);
  end;

  // 2. facturile catre acelasi cumparator, inregistrate de la trimitere, pe care WMS nu le cunoaste
  // (o factura preluata de e-Factura, dar fara identificatorul nostru)
  Q := NewQuery;
  Unknown := TStringList.Create;
  try
    Q.SQL.Text := 'SELECT SENT_AT, XML_SENT FROM TDB_EFACTURA WHERE INVOICEID = :INVOICEID';
    Q.ParamByName('INVOICEID').AsInteger := AInvoiceID;
    Q.Open;
    SentAt := Q.FieldByName('SENT_AT').AsDateTime;
    M := TRegEx.Match(Q.FieldByName('XML_SENT').AsString, '<Buyer\b[^>]*\bIDNO="([^"]*)"');
    BuyerIDNO := '';
    if M.Success then
      BuyerIDNO := Trim(M.Groups[1].Value);
    Q.Close;

    if BuyerIDNO <> '' then
    begin
      Q.SQL.Text := 'SELECT 1 FROM TDB_EFACTURA WHERE SERIA = :SERIA AND EF_NUMBER = :EF_NUMBER';
      for St in cStatuses do
      begin
        Search := TEFacturaSearch.Create(St);
        Search.BuyerIDNO := BuyerIDNO;
        Search.RegisteredFrom := DateOf(SentAt);
        Search.RegisteredTo := IncDay(Date, 1);
        Found := Api.SearchInvoices(Search);
        for Inv in Found do
        begin
          if (Inv.Status = cEFacturaReqError) or (Inv.Seria = '') or (Inv.Number = '') then
            Continue;
          Q.Close;
          Q.ParamByName('SERIA').AsString := Inv.Seria;
          Q.ParamByName('EF_NUMBER').AsString := Inv.Number;
          Q.Open;
          if Q.IsEmpty then
          begin
            Ident := Format('%s %s (%s)', [Inv.Seria, Inv.Number, EFacturaStatusName(St)]);
            if Unknown.IndexOf(Ident) < 0 then
              Unknown.Add(Ident);
          end;
        end;
      end;
    end;
    Result := Trim(Unknown.Text);
  finally
    Unknown.Free;
    Q.Free;
  end;
end;

procedure TEFacturaManager.MarkNotSent(AInvoiceID: Integer; const AUserName: string);
var
  ApiId, Seria, Number, FacturaNo: string;
  FirmaID, PrevStatus: Integer;
begin
  ReadSentInvoice(AInvoiceID, ApiId, Seria, Number, FacturaNo, FirmaID, PrevStatus);
  if (Seria <> '') and (Number <> '') then
    raise EEFacturaApiError.CreateFmt('Factura are serie si numar in e-Factura (%s %s) - folositi anularea.',
      [Seria, Number]);
  SetState(AInvoiceID, cEFInvRejected, Format('Negasita in e-Factura; marcata ca netrimisa de %s la %s.',
    [AUserName, FormatDateTime('dd.mm.yyyy hh:nn', Now)]));
end;

class procedure TEFacturaManager.CheckVatConsistency(const AInvoicesXml: string);
var
  M: TMatch;
  CodTVA, Rate: string;
  WithVat, WithoutVat: Integer;
begin
  CodTVA := '';
  M := TRegEx.Match(AInvoicesXml, '<Supplier\b[^>]*\bCodTVA="([^"]*)"');
  if M.Success then
    CodTVA := Trim(M.Groups[1].Value);

  WithVat := 0;
  WithoutVat := 0;
  // atributul TVA al randului ("-" = fara TVA); \b exclude TotalTVA / UnitPriceWithoutTVA
  for M in TRegEx.Matches(AInvoicesXml, '<Row\b[^>]*\bTVA="([^"]*)"') do
  begin
    Rate := Trim(M.Groups[1].Value);
    if (Rate = '') or (Rate = '-') then
      Inc(WithoutVat)
    else
      Inc(WithVat);
  end;

  if (CodTVA <> '') and (WithVat = 0) and (WithoutVat > 0) then
    raise EEFacturaApiError.CreateFmt('Factura nu poate fi trimisa: furnizorul este platitor de TVA ' +
      '(cod TVA %s), dar niciun rand al facturii nu are TVA.' + sLineBreak + sLineBreak +
      'Documentul a fost probabil creat cand firma nu platea TVA. Recalculati TVA-ul documentului ' +
      '(sau verificati cu contabilul daca marfa e scutita de TVA).' + sLineBreak + sLineBreak +
      'Pentru livrari cu cota TVA 0%% (ex. proiecte de asistenta tehnica) setati TVA = 0 in ' +
      'contractul documentului - randurile vor fi trimise cu cota 0.', [CodTVA]);
  if (CodTVA = '') and (WithVat > 0) then
    raise EEFacturaApiError.CreateFmt('Factura nu poate fi trimisa: furnizorul nu are cod TVA in fisa ' +
      'firmei, dar %d randuri ale facturii au TVA.' + sLineBreak + sLineBreak +
      'Completati codul TVA al firmei (daca e platitoare de TVA) sau recalculati documentul fara TVA.',
      [WithVat]);
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
          'TVA de %.2f lei.', [Vat]))
      else if (Supplier.CodTVA <> '') and (Abs(Vat) < 0.01) then
        W.Add(Format('Furnizorul este platitor de TVA (cod TVA %s in Registrul fiscal), dar factura nu are TVA - ' +
          'trimiterea va fi blocata daca si fisa firmei are cod TVA.', [Supplier.CodTVA]));
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

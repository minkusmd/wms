unit EFacturaApiClient;

{
  Client SOAP pentru API-ul SIA "e-Factura" (Serviciul Fiscal de Stat).

  Serviciul (https://efactura-api.sfs.md/Service.svc) este WCF basicHttpBinding
  cu securitate TransportWithMessageCredential: SOAP 1.1 peste HTTPS, iar
  fiecare cerere poarta in header un wsse:Security cu UsernameToken (parola in
  clar) si Timestamp. Delphi nu genereaza acest header, iar importul WSDL se
  impiedica de tipurile DataContract, de aceea plicul se construieste manual.

  Atentie:
  - sursa de adevar e WSDL-ul (?singleWsdl), nu ghidurile PDF (difera);
  - elementele DataContract se trimit in ordine: campurile clasei de baza,
    apoi ale clasei derivate, fiecare grup in ordine alfabetica;
  - la SearchInvoices criteriul InvoiceStatus e obligatoriu in practica
    (lipsa lui inseamna 0 = Draft);
  - PostInvoices e asincron (Status 1) si nu intoarce seria/numarul - factura
    se regaseste dupa identificatorul pus in AdditionalInformation (ApiId);
  - Timestamp-ul se ia din ceasul local; o abatere mai mare de ~5 minute fata
    de server duce la eroare de securitate.
}

interface

uses
  System.SysUtils, System.Classes, Xml.XMLIntf;

const
  cEFacturaDefaultURL = 'https://efactura-api.sfs.md/Service.svc';

  cEFacturaActorSupplier = 1;

  // Status la nivel de raspuns (BaseResponse.Status) si de factura (InvoiceResult.Status)
  cEFacturaReqAccepted = 1; // acceptat pentru executare (procesare asincrona)
  cEFacturaReqOk = 2;
  cEFacturaReqError = 3;

  // InvoiceStatus - ciclul de viata al facturii in e-Factura
  cEFInvPending = -1; // stare WMS: trimisa prin API, inca negasita in e-Factura
  // stare WMS: respinsa de e-Factura la procesare (motivul in TDB_EFACTURA.LAST_ERROR) sau
  // negasita acolo si marcata ca netrimisa - factura WMS poate fi stearsa sau retrimisa
  cEFInvRejected = -3;
  cEFInvDraft = 0;
  cEFInvSignedBySupplier = 1;
  cEFInvRejectedByBuyer = 2;
  cEFInvAcceptedByBuyer = 3;
  cEFInvCanceledBySupplier = 5;
  cEFInvArchived = 6;
  cEFInvSentToBuyer = 7;
  cEFInvSignedByBuyer = 8;
  cEFInvTransported = 10;

type
  EEFacturaApiError = class(Exception);

  TEFacturaInvoice = record
    Seria: string;
    Number: string;
    Status: Integer;        // cEFacturaReqOk / cEFacturaReqError
    InvoiceStatus: Integer; // cEFInv*
    Message: string;
    Xml: string;            // doar la GetInvoicesBySeriaNumber
  end;

  TEFacturaInvoices = TArray<TEFacturaInvoice>;

  TEFacturaPostResult = record
    Status: Integer;
    TotalInvoices: Integer;
    TotalInvoicesPosted: Integer;
    ErrorMessage: string;
  end;

  TEFacturaTaxpayer = record
    IDNO: string;
    Name: string;
    Address: string;
    CodTVA: string;
    TaxpayerType: Integer; // 1 - juridic, 2 - persoana fizica, 3 - nerezident
    IsEFacturaActor: Boolean;
    ExistInTaxRegistry: Boolean;
  end;

  TEFacturaBankAccount = record
    AccountNumber: string; // IBAN
    BranchCode: string;    // codul bancii/filialei, ex. AGRNMD2X435 (= TS_BANKS.BANKACCOUNT)
    BranchTitle: string;
    IsRegistered: Boolean;
  end;

  TEFacturaBankAccounts = TArray<TEFacturaBankAccount>;

  // Criterii SearchInvoices; sirurile goale si datele 0 se omit din cerere.
  TEFacturaSearch = record
    ApiId: string;
    Seria: string;
    Number: string;
    BuyerIDNO: string;
    InvoiceStatus: Integer;
    IssuedFrom, IssuedTo: TDateTime;
    RegisteredFrom, RegisteredTo: TDateTime;
    class function Create(AInvoiceStatus: Integer): TEFacturaSearch; static;
  end;

  TEFacturaApiClient = class
  private
    FURL: string;
    FUserName: string;
    FPassword: string;
    FTimeout: Integer;
    FLastRequestId: string;
    FLastRequest: string;
    FLastResponse: string;
    FLastDoc: IXMLDocument; // tine in viata nodurile intoarse de Execute
    function RequestIdTag: string;
    function BuildEnvelope(const AOperation, ABody: string): string;
    function Execute(const AOperation, ABody: string): IXMLNode;
    function ParseInvoices(AResult: IXMLNode): TEFacturaInvoices;
    function FirstInvoice(const AInvoices: TEFacturaInvoices; const ASeria, ANumber: string): TEFacturaInvoice;
  public
    constructor Create(const AURL, AUserName, APassword: string);

    // Intoarce textul serviciului ("User name: ... from v2") - confirma credentialele.
    function Test(const AMessage: string = 'WMS'): string;
    // Trimite una sau mai multe facturi (<Documents>...). Nesemnate = raman "Facturi noi" in web.
    function PostInvoices(const AInvoicesXml: string; ASigned: Boolean = False): TEFacturaPostResult;
    function SearchInvoices(const ASearch: TEFacturaSearch): TEFacturaInvoices;
    // Cauta factura dupa ApiId prin toate statutele (InvoiceStatus e criteriu obligatoriu).
    function FindByApiId(const AApiId: string; out AInvoice: TEFacturaInvoice): Boolean;
    function CheckStatus(const ASeria, ANumber: string): TEFacturaInvoice;
    function GetInvoiceXml(const ASeria, ANumber: string): TEFacturaInvoice;
    function GetInvoicePdf(const ASeria, ANumber: string): TBytes;
    // Posibil doar pana semneaza cumparatorul.
    function CancelInvoice(const ASeria, ANumber, AComment: string): TEFacturaInvoice;
    function GetTaxpayer(const AIDNO: string; out ATaxpayer: TEFacturaTaxpayer): Boolean;
    // IBAN-urile firmei din Registrul fiscal; cu AAccountNumber gol le intoarce pe toate.
    function GetBankAccounts(const AIDNO: string; const AAccountNumber: string = ''): TEFacturaBankAccounts;

    property Timeout: Integer read FTimeout write FTimeout;
    property LastRequestId: string read FLastRequestId;
    // Ultimul plic trimis (cu parola mascata) si ultimul raspuns - pentru diagnostic.
    property LastRequest: string read FLastRequest;
    property LastResponse: string read FLastResponse;
  end;

function EFacturaXmlEscape(const S: string): string;
function EFacturaStatusName(AInvoiceStatus: Integer): string;

implementation

uses
  System.DateUtils, System.NetConsts, System.NetEncoding, System.Net.HttpClient, System.Net.URLClient, Xml.XMLDoc;

const
  cNsTempuri = 'http://tempuri.org/';
  cNsModel = 'http://schemas.datacontract.org/2004/07/AX.EFactura.Model.ApiModel';
  cNsArrays = 'http://schemas.microsoft.com/2003/10/Serialization/Arrays';
  cNsSoap = 'http://schemas.xmlsoap.org/soap/envelope/';
  cNsWsse = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd';
  cNsWsu = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd';
  cPasswordText = 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText';
  cPasswordMask = '********';

{ utilitare }

function EFacturaXmlEscape(const S: string): string;
var
  SB: TStringBuilder;
  C: Char;
begin
  SB := TStringBuilder.Create(Length(S) + 16);
  try
    for C in S do
      case C of
        '&': SB.Append('&amp;');
        '<': SB.Append('&lt;');
        '>': SB.Append('&gt;');
        '"': SB.Append('&quot;');
        '''': SB.Append('&apos;');
        #0..#8, #11, #12, #14..#31: ; // interzise in XML 1.0 - se omit
      else
        SB.Append(C);
      end;
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

function EFacturaStatusName(AInvoiceStatus: Integer): string;
begin
  case AInvoiceStatus of
    cEFInvPending: Result := 'Trimisa, in procesare';
    cEFInvRejected: Result := 'Respinsa / negasita in e-Factura';
    cEFInvDraft: Result := 'Nesemnata (Facturi noi)';
    cEFInvSignedBySupplier: Result := 'Semnata de furnizor';
    cEFInvRejectedByBuyer: Result := 'Refuzata de cumparator';
    cEFInvAcceptedByBuyer: Result := 'Acceptata de cumparator';
    cEFInvCanceledBySupplier: Result := 'Anulata de furnizor';
    cEFInvArchived: Result := 'Arhivata';
    cEFInvSentToBuyer: Result := 'Trimisa la cumparator';
    cEFInvSignedByBuyer: Result := 'Semnata de cumparator';
    cEFInvTransported: Result := 'Transportata';
  else
    Result := 'Status ' + IntToStr(AInvoiceStatus);
  end;
end;

function IsoUtc(AOffsetMinutes: Integer): string;
var
  Y, Mo, D, H, Mi, S, Ms: Word;
begin
  DecodeDateTime(IncMinute(TTimeZone.Local.ToUniversalTime(Now), AOffsetMinutes), Y, Mo, D, H, Mi, S, Ms);
  Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d.%.3dZ', [Y, Mo, D, H, Mi, S, Ms]);
end;

function IsoLocal(ADate: TDateTime): string;
var
  Y, Mo, D, H, Mi, S, Ms: Word;
begin
  DecodeDateTime(ADate, Y, Mo, D, H, Mi, S, Ms);
  Result := Format('%.4d-%.2d-%.2dT%.2d:%.2d:%.2d', [Y, Mo, D, H, Mi, S]);
end;

function Req(const AInner: string): string;
begin
  Result := '<request xmlns:a="' + cNsModel + '">' + AInner + '</request>';
end;

function Tag(const AName, AValue: string): string;
begin
  Result := '<a:' + AName + '>' + EFacturaXmlEscape(AValue) + '</a:' + AName + '>';
end;

function OptTag(const AName, AValue: string): string;
begin
  if AValue = '' then
    Result := ''
  else
    Result := Tag(AName, AValue);
end;

function DateSearchTag(const AName: string; AFrom, ATo: TDateTime): string;
begin
  Result := '';
  if (AFrom = 0) and (ATo = 0) then
    Exit;
  // DateSearch: EndDate, StartDate (ordine alfabetica)
  Result := '<a:' + AName + '>';
  if ATo <> 0 then
    Result := Result + '<a:EndDate>' + IsoLocal(ATo) + '</a:EndDate>';
  if AFrom <> 0 then
    Result := Result + '<a:StartDate>' + IsoLocal(AFrom) + '</a:StartDate>';
  Result := Result + '</a:' + AName + '>';
end;

function IdentificatorsTag(const ASeria, ANumber: string): string;
begin
  Result := '<a:SeriaAndNumbers><a:InvoiceIndentificator>' + Tag('Number', ANumber) + Tag('Seria', ASeria) +
    '</a:InvoiceIndentificator></a:SeriaAndNumbers>';
end;

// Navigare dupa LocalName - prefixele de namespace din raspunsuri nu sunt garantate.

function ChildNode(ANode: IXMLNode; const ALocalName: string): IXMLNode;
var
  I: Integer;
begin
  Result := nil;
  if ANode = nil then
    Exit;
  for I := 0 to ANode.ChildNodes.Count - 1 do
    if (ANode.ChildNodes[I].NodeType = ntElement) and SameText(ANode.ChildNodes[I].LocalName, ALocalName) then
      Exit(ANode.ChildNodes[I]);
end;

function FindNode(ANode: IXMLNode; const ALocalName: string): IXMLNode;
var
  I: Integer;
begin
  Result := nil;
  if ANode = nil then
    Exit;
  if (ANode.NodeType = ntElement) and SameText(ANode.LocalName, ALocalName) then
    Exit(ANode);
  for I := 0 to ANode.ChildNodes.Count - 1 do
  begin
    Result := FindNode(ANode.ChildNodes[I], ALocalName);
    if Result <> nil then
      Exit;
  end;
end;

function NodeText(ANode: IXMLNode): string;
begin
  if (ANode <> nil) and ANode.IsTextElement then
    Result := ANode.Text
  else
    Result := '';
end;

function ChildText(ANode: IXMLNode; const ALocalName: string): string;
begin
  Result := NodeText(ChildNode(ANode, ALocalName));
end;

function ChildInt(ANode: IXMLNode; const ALocalName: string; ADefault: Integer = 0): Integer;
begin
  Result := StrToIntDef(ChildText(ANode, ALocalName), ADefault);
end;

{ TEFacturaSearch }

class function TEFacturaSearch.Create(AInvoiceStatus: Integer): TEFacturaSearch;
begin
  Result := Default(TEFacturaSearch);
  Result.InvoiceStatus := AInvoiceStatus;
end;

{ TEFacturaApiClient }

constructor TEFacturaApiClient.Create(const AURL, AUserName, APassword: string);
begin
  inherited Create;
  FURL := Trim(AURL);
  if FURL = '' then
    FURL := cEFacturaDefaultURL;
  FUserName := AUserName;
  FPassword := APassword;
  FTimeout := 60000;
end;

function TEFacturaApiClient.RequestIdTag: string;
begin
  FLastRequestId := LowerCase(Copy(TGUID.NewGuid.ToString, 2, 36));
  Result := Tag('RequestId', FLastRequestId);
end;

function TEFacturaApiClient.BuildEnvelope(const AOperation, ABody: string): string;
begin
  Result :=
    '<s:Envelope xmlns:s="' + cNsSoap + '" xmlns:u="' + cNsWsu + '">' +
    '<s:Header><o:Security s:mustUnderstand="1" xmlns:o="' + cNsWsse + '">' +
    '<u:Timestamp u:Id="_0"><u:Created>' + IsoUtc(0) + '</u:Created>' +
    '<u:Expires>' + IsoUtc(5) + '</u:Expires></u:Timestamp>' +
    '<o:UsernameToken u:Id="uuid-' + LowerCase(Copy(TGUID.NewGuid.ToString, 2, 36)) + '-1">' +
    '<o:Username>' + EFacturaXmlEscape(FUserName) + '</o:Username>' +
    '<o:Password Type="' + cPasswordText + '">' + EFacturaXmlEscape(FPassword) + '</o:Password>' +
    '</o:UsernameToken></o:Security></s:Header>' +
    '<s:Body><' + AOperation + ' xmlns="' + cNsTempuri + '">' + ABody + '</' + AOperation + '></s:Body>' +
    '</s:Envelope>';
end;

// pagina HTML de eroare a serverului/gateway-ului, in locul plicului SOAP
function IsHtmlPage(const ABody: string): Boolean;
var
  S: string;
begin
  S := LowerCase(Copy(TrimLeft(ABody), 1, 64));
  Result := (Pos('<!doctype html', S) = 1) or (Pos('<html', S) = 1);
end;

function TEFacturaApiClient.Execute(const AOperation, ABody: string): IXMLNode;
var
  Http: THTTPClient;
  Source: TStringStream;
  Response: IHTTPResponse;
  Envelope, Body, FaultCode, FaultText: string;
  StatusCode: Integer;
  Doc: IXMLDocument;
  Fault: IXMLNode;
begin
  Envelope := BuildEnvelope(AOperation, ABody);
  FLastRequest := StringReplace(Envelope, '>' + EFacturaXmlEscape(FPassword) + '</o:Password>',
    '>' + cPasswordMask + '</o:Password>', []);
  FLastResponse := '';
  FLastDoc := nil;

  Http := THTTPClient.Create;
  Source := TStringStream.Create(Envelope, TEncoding.UTF8);
  try
    Http.ConnectionTimeout := FTimeout;
    Http.ResponseTimeout := FTimeout;
    Http.ContentType := 'text/xml; charset=utf-8';
    try
      Response := Http.Post(FURL, Source, nil,
        [TNetHeader.Create('SOAPAction', '"' + cNsTempuri + 'IService/' + AOperation + '"')]);
      StatusCode := Response.StatusCode;
      Body := Response.ContentAsString(TEncoding.UTF8);
    except
      on E: Exception do
        raise EEFacturaApiError.CreateFmt('e-Factura nu raspunde (%s): %s', [AOperation, E.Message]);
    end;
  finally
    Source.Free;
    Http.Free;
  end;
  FLastResponse := Body;

  if Trim(Body) = '' then
    raise EEFacturaApiError.CreateFmt('e-Factura: raspuns gol la %s (HTTP %d).', [AOperation, StatusCode]);
  // serverul SFS cazut / gateway-ul lui (HTTP 502, 503...) intoarce o pagina HTML, nu SOAP
  // (20.10.2026: 502 chiar si la ?singleWsdl) - mesaj scurt, nu dump-ul paginii
  if (StatusCode >= 500) or IsHtmlPage(Body) then
    raise EEFacturaApiError.CreateFmt('Serviciul e-Factura (API SFS) nu este disponibil acum: HTTP %d la %s.' +
      sLineBreak + 'Problema este la serverul SFS - incercati mai tarziu.', [StatusCode, AOperation]);
  try
    Doc := LoadXMLData(Body);
  except
    raise EEFacturaApiError.CreateFmt('e-Factura: raspuns invalid la %s (HTTP %d): %s',
      [AOperation, StatusCode, Copy(Body, 1, 300)]);
  end;
  FLastDoc := Doc;

  Fault := FindNode(Doc.DocumentElement, 'Fault');
  if Fault <> nil then
  begin
    FaultCode := NodeText(FindNode(Fault, 'faultcode'));
    FaultText := NodeText(FindNode(Fault, 'faultstring'));
    if (Pos('Security', FaultCode) > 0) or (Pos('Authentication', FaultCode) > 0) then
      FaultText := FaultText + sLineBreak +
        '(verificati utilizatorul/parola API din Setari > Configurari API si ora calculatorului)';
    raise EEFacturaApiError.CreateFmt('e-Factura a refuzat cererea %s: %s', [AOperation, FaultText]);
  end;
  if (StatusCode < 200) or (StatusCode >= 300) then
    raise EEFacturaApiError.CreateFmt('e-Factura: HTTP %d la %s.', [StatusCode, AOperation]);

  Result := FindNode(Doc.DocumentElement, AOperation + 'Result');
  if Result = nil then
    raise EEFacturaApiError.CreateFmt('e-Factura: lipseste %sResult din raspuns.', [AOperation]);
end;

function TEFacturaApiClient.ParseInvoices(AResult: IXMLNode): TEFacturaInvoices;
var
  Results, N: IXMLNode;
  Inv: TEFacturaInvoice;
  I: Integer;
begin
  Result := nil;
  Results := ChildNode(AResult, 'Results');
  if Results = nil then
    Exit;
  for I := 0 to Results.ChildNodes.Count - 1 do
  begin
    N := Results.ChildNodes[I];
    if N.NodeType <> ntElement then
      Continue;
    Inv := Default(TEFacturaInvoice);
    Inv.Seria := ChildText(N, 'Seria');
    Inv.Number := ChildText(N, 'Number');
    Inv.Status := ChildInt(N, 'Status');
    Inv.InvoiceStatus := ChildInt(N, 'InvoiceStatus', cEFInvPending);
    Inv.Message := ChildText(N, 'Message');
    Inv.Xml := ChildText(N, 'Xml');
    Result := Result + [Inv];
  end;
end;

function TEFacturaApiClient.FirstInvoice(const AInvoices: TEFacturaInvoices; const ASeria, ANumber: string):
  TEFacturaInvoice;
begin
  if Length(AInvoices) = 0 then
    raise EEFacturaApiError.CreateFmt('e-Factura nu a intors factura %s %s.', [ASeria, ANumber]);
  Result := AInvoices[0];
  if Result.Status = cEFacturaReqError then
    raise EEFacturaApiError.CreateFmt('e-Factura, factura %s %s: %s', [ASeria, ANumber, Result.Message]);
end;

function TEFacturaApiClient.Test(const AMessage: string): string;
var
  R: IXMLNode;
begin
  R := Execute('Test', '<message>' + EFacturaXmlEscape(AMessage) + '</message>');
  if ChildInt(R, 'Status') <> cEFacturaReqOk then
    raise EEFacturaApiError.Create('e-Factura: testul conexiunii a esuat.');
  Result := ChildText(R, 'RequestId');
end;

function TEFacturaApiClient.PostInvoices(const AInvoicesXml: string; ASigned: Boolean): TEFacturaPostResult;
var
  R: IXMLNode;
  XmlStatus: string;
begin
  if ASigned then
    XmlStatus := '1'
  else
    XmlStatus := '0';
  // BaseRequest(RequestId), ActorBaseRequest(ActorRole), PostInvocesRequest(Attachment, InvoicesXml, InvoicesXmlStatus)
  R := Execute('PostInvoices', Req(RequestIdTag + Tag('ActorRole', IntToStr(cEFacturaActorSupplier)) +
    Tag('InvoicesXml', AInvoicesXml) + Tag('InvoicesXmlStatus', XmlStatus)));
  Result.Status := ChildInt(R, 'Status');
  Result.TotalInvoices := ChildInt(R, 'TotalInvoices');
  Result.TotalInvoicesPosted := ChildInt(R, 'TotalInvoicesPosted');
  Result.ErrorMessage := ChildText(R, 'ErrorMessage');
end;

function TEFacturaApiClient.SearchInvoices(const ASearch: TEFacturaSearch): TEFacturaInvoices;
var
  R: IXMLNode;
  P: string;
begin
  // SearchParameters, ordine alfabetica: APIeInvoiceId, BuyerIDNO, DeliveredOn, InvoiceStatus,
  // InvoiceType, IssuedOn, Number, RegisteredOn, Seria, SupplierIDNO, TransporterIDNO
  P := OptTag('APIeInvoiceId', ASearch.ApiId) +
    OptTag('BuyerIDNO', ASearch.BuyerIDNO) +
    Tag('InvoiceStatus', IntToStr(ASearch.InvoiceStatus)) +
    DateSearchTag('IssuedOn', ASearch.IssuedFrom, ASearch.IssuedTo) +
    OptTag('Number', ASearch.Number) +
    DateSearchTag('RegisteredOn', ASearch.RegisteredFrom, ASearch.RegisteredTo) +
    OptTag('Seria', ASearch.Seria);
  R := Execute('SearchInvoices', Req(RequestIdTag + Tag('ActorRole', IntToStr(cEFacturaActorSupplier)) +
    '<a:Parameters>' + P + '</a:Parameters>'));
  if ChildInt(R, 'Status') = cEFacturaReqError then
    raise EEFacturaApiError.Create('e-Factura: cautarea facturilor a esuat (criterii invalide).');
  Result := ParseInvoices(R);
end;

function TEFacturaApiClient.FindByApiId(const AApiId: string; out AInvoice: TEFacturaInvoice): Boolean;
const
  // in ordinea probabilitatii pentru o factura trimisa recent
  cStatuses: array[0..8] of Integer = (cEFInvDraft, cEFInvSignedBySupplier, cEFInvSentToBuyer,
    cEFInvSignedByBuyer, cEFInvAcceptedByBuyer, cEFInvTransported, cEFInvRejectedByBuyer,
    cEFInvCanceledBySupplier, cEFInvArchived);
var
  St: Integer;
  Search: TEFacturaSearch;
  Found: TEFacturaInvoices;
begin
  Result := False;
  AInvoice := Default(TEFacturaInvoice);
  for St in cStatuses do
  begin
    Search := TEFacturaSearch.Create(St);
    Search.ApiId := AApiId;
    Found := SearchInvoices(Search);
    if Length(Found) > 0 then
    begin
      AInvoice := Found[0];
      if AInvoice.InvoiceStatus = cEFInvPending then
        AInvoice.InvoiceStatus := St;
      Exit(True);
    end;
  end;
end;

function TEFacturaApiClient.CheckStatus(const ASeria, ANumber: string): TEFacturaInvoice;
begin
  Result := FirstInvoice(ParseInvoices(Execute('CheckInvoicesStatus',
    Req(RequestIdTag + IdentificatorsTag(ASeria, ANumber)))), ASeria, ANumber);
end;

function TEFacturaApiClient.GetInvoiceXml(const ASeria, ANumber: string): TEFacturaInvoice;
begin
  Result := FirstInvoice(ParseInvoices(Execute('GetInvoicesBySeriaNumber',
    Req(RequestIdTag + IdentificatorsTag(ASeria, ANumber)))), ASeria, ANumber);
end;

function TEFacturaApiClient.GetInvoicePdf(const ASeria, ANumber: string): TBytes;
var
  R, Content: IXMLNode;
  S: string;
begin
  // InvoicesRequest(RequestId, SeriaAndNumbers) + ActorRole, Orientation (0 = portret)
  R := Execute('GetInvoicesContentForPrint', Req(RequestIdTag + IdentificatorsTag(ASeria, ANumber) +
    Tag('ActorRole', IntToStr(cEFacturaActorSupplier)) + Tag('Orientation', '0')));
  Content := ChildNode(R, 'Result');
  if (Content = nil) or (ChildInt(Content, 'Status') = cEFacturaReqError) then
    raise EEFacturaApiError.CreateFmt('e-Factura nu a intors PDF-ul facturii %s %s: %s',
      [ASeria, ANumber, ChildText(Content, 'Message')]);
  S := ChildText(Content, 'Content');
  if S = '' then
    raise EEFacturaApiError.CreateFmt('e-Factura a intors un PDF gol pentru factura %s %s.', [ASeria, ANumber]);
  Result := TNetEncoding.Base64.DecodeStringToBytes(S);
end;

function TEFacturaApiClient.CancelInvoice(const ASeria, ANumber, AComment: string): TEFacturaInvoice;
begin
  // InvoiceComment: InvoiceIndentificator(Number, Seria) + Comment
  Result := FirstInvoice(ParseInvoices(Execute('PostCanceledInvoices', Req(RequestIdTag +
    '<a:InvoicesComments><a:InvoiceComment>' + Tag('Number', ANumber) + Tag('Seria', ASeria) +
    Tag('Comment', AComment) + '</a:InvoiceComment></a:InvoicesComments>'))), ASeria, ANumber);
end;

function TEFacturaApiClient.GetTaxpayer(const AIDNO: string; out ATaxpayer: TEFacturaTaxpayer): Boolean;
var
  Results, N: IXMLNode;
  I: Integer;
begin
  Result := False;
  ATaxpayer := Default(TEFacturaTaxpayer);
  Results := ChildNode(Execute('GetTaxpayersInfo', Req(RequestIdTag +
    '<a:FiscalCodes xmlns:b="' + cNsArrays + '"><b:string>' + EFacturaXmlEscape(AIDNO) +
    '</b:string></a:FiscalCodes>')), 'Results');
  if Results = nil then
    Exit;
  for I := 0 to Results.ChildNodes.Count - 1 do
  begin
    N := Results.ChildNodes[I];
    if N.NodeType <> ntElement then
      Continue;
    ATaxpayer.IDNO := ChildText(N, 'IDNO');
    ATaxpayer.Name := ChildText(N, 'Name');
    ATaxpayer.Address := ChildText(N, 'Address');
    ATaxpayer.CodTVA := Trim(ChildText(N, 'CodTVA'));
    ATaxpayer.TaxpayerType := ChildInt(N, 'TaxpayerType');
    ATaxpayer.IsEFacturaActor := SameText(ChildText(N, 'IsEFacturaActor'), 'true');
    ATaxpayer.ExistInTaxRegistry := SameText(ChildText(N, 'ExistInTaxRegistry'), 'true');
    Exit(True);
  end;
end;

function TEFacturaApiClient.GetBankAccounts(const AIDNO, AAccountNumber: string): TEFacturaBankAccounts;
var
  Results, N: IXMLNode;
  Acc: TEFacturaBankAccount;
  I: Integer;
begin
  Result := nil;
  // BankAccountRequest: BaseRequest(RequestId) + AccountNumber, IDNO
  Results := ChildNode(Execute('GetBankAccountInfo', Req(RequestIdTag + OptTag('AccountNumber', AAccountNumber) +
    Tag('IDNO', AIDNO))), 'Results');
  if Results = nil then
    Exit;
  for I := 0 to Results.ChildNodes.Count - 1 do
  begin
    N := Results.ChildNodes[I];
    if N.NodeType <> ntElement then
      Continue;
    Acc.AccountNumber := ChildText(N, 'AccountNumber');
    Acc.BranchCode := ChildText(N, 'BranchCode');
    Acc.BranchTitle := ChildText(N, 'BranchTitle');
    Acc.IsRegistered := SameText(ChildText(N, 'IsRegistered'), 'true');
    Result := Result + [Acc];
  end;
end;
end.

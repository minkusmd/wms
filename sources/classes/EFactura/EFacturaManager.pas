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

end.

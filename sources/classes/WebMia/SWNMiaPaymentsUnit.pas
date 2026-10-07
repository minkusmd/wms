unit SWNMiaPaymentsUnit;

(* ============================================================================
  MIA Victoriabank in WMS - partea de date (fara interfata, fara dmDB).

  Platile instant prin cod QR ale comenzilor de pe site stau in
  TWEB_MIA_VB_PAYMENT / TWEB_MIA_VB_QR (DB Model\mia_vb_payments.sql). Le scrie
  site-ul; plan si stare: Documents\plan-integrare-mia-victoriabank-2026-10-06.md.

  WMS nu vorbeste cu banca. Doar citeste starea platii si CERE, prin proceduri:
    - MiaCreateLink     : linkul de plata al unei comenzi (WEB_MIA_VB_CREATE_LINK);
                          codul QR il emite pagina site-ului cind clientul o deschide;
    - MiaRequestRefund  : rambursarea integrala (WEB_MIA_VB_REQUEST_REFUND); o face
                          cronul site-ului in citeva minute;
    - MiaSendLinkSms    : SMS cu linkul (WEB_MIA_VB_LINK_SMS -> SMS_MESSAGES).

  Totul e inactiv pina cind scriptul e rulat pe baza (MiaPaymentsAvailable,
  verificat o singura data pe sesiune).

  Adresa paginii de plata si brandul se pot schimba din Setari > Configurari API,
  API_CODE = 'MIA_VB': PAY_URL (implicit https://www.fantastic.md/plata-mia/) si
  BRAND (implicit fantastic).
  ============================================================================ *)

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, IBC;

const
  cMiaNew             = 'New';
  cMiaPaid            = 'Paid';
  cMiaMismatch        = 'Mismatch';
  cMiaCancelled       = 'Cancelled';
  cMiaRefundRequested = 'RefundRequested';
  cMiaRefunded        = 'Refunded';
  cMiaRefundFailed    = 'RefundFailed';

type
  TMiaOrderPayment = record
    Found: Boolean;
    PaymentID: Int64;
    DocID: Integer;
    Status: string;
    Token: string;
    Amount: Currency;        // suma ceruta
    PaidAmount: Currency;    // suma confirmata de banca
    PaidAt: TDateTime;
    TxID: string;
    PayerName: string;
    Source: string;          // checkout / operator
    CreatedAt: TDateTime;
    function StatusText: string;
    // linkul de plata mai poate fi folosit
    function HasOpenLink: Boolean;
    // banii au ajuns: plata se poate rambursa
    function CanRefund: Boolean;
    // banii au ajuns (inclusiv cu rambursare in curs sau esuata)
    function IsPaid: Boolean;
  end;

{ Tabelele si procedurile exista in baza? Rezultatul se tine pe sesiune. }
function MiaPaymentsAvailable(AConn: TIBCConnection): Boolean;

{ Starea pe intelesul operatorului: 'Platit', 'In asteptare' ... }
function MiaStatusText(const AStatus: string): string;

{ Cererea de plata cea mai importanta a comenzii: cea platita, altfel cea
  deschisa, altfel ultima. Found = False daca nu are niciuna. }
function LoadMiaOrderPayment(AConn: TIBCConnection; const ADocID: Integer): TMiaOrderPayment;

{ DOCID -> starea platii, pentru coloana din lista comenzilor. Lista e a apelantului. }
function LoadMiaStates(AConn: TIBCConnection): TDictionary<Integer, string>;

{ Adresa paginii de plata pentru un token. }
function MiaPayUrl(AConn: TIBCConnection; const AToken: string): string;

{ Linkul de plata al comenzii: cel deschis sau unul nou. False + AError la refuz. }
function MiaCreateLink(AConn: TIBCConnection; const ADocID, AUserID: Integer; out APayment: TMiaOrderPayment;
  out AError: string): Boolean;

function MiaRequestRefund(AConn: TIBCConnection; const APaymentID: Int64; const AUserID: Integer;
  out AError: string): Boolean;

{ Textul SMS-ului cu linkul ("~" = rind nou, ca in celelalte SMS-uri). }
function MiaLinkSmsText(const ADocID: Integer; const AUrl: string): string;

{ APhone gol = telefonul din comanda web. ASentTo = numarul folosit. }
function MiaSendLinkSms(AConn: TIBCConnection; const ADocID: Integer; const AText, APhone: string;
  out ASentTo, AError: string): Boolean;

implementation

uses
  Data.DB, DBAccess, MemDS, IBCClasses;

const
  cDefaultPayUrl = 'https://www.fantastic.md/plata-mia/';
  cDefaultBrand  = 'fantastic';
  cConfigCode    = 'MIA_VB';

var
  { -1 = neverificat, 0 = schema lipseste, 1 = schema exista }
  GAvailability: Integer = -1;

{ TMiaOrderPayment }

function TMiaOrderPayment.StatusText: string;
begin
  Result := MiaStatusText(Status);
end;

function TMiaOrderPayment.HasOpenLink: Boolean;
begin
  Result := Found and (Status = cMiaNew) and (Token <> '');
end;

function TMiaOrderPayment.IsPaid: Boolean;
begin
  Result := Found and ((Status = cMiaPaid) or (Status = cMiaRefundRequested) or (Status = cMiaRefundFailed));
end;

function TMiaOrderPayment.CanRefund: Boolean;
begin
  Result := Found and (TxID <> '') and
    ((Status = cMiaPaid) or (Status = cMiaMismatch) or (Status = cMiaRefundFailed));
end;

function MiaStatusText(const AStatus: string): string;
begin
  if AStatus = cMiaPaid then
    Result := 'Platit'
  else if AStatus = cMiaNew then
    Result := 'In asteptare'
  else if AStatus = cMiaMismatch then
    Result := 'Suma diferita!'
  else if AStatus = cMiaRefundRequested then
    Result := 'Rambursare in curs'
  else if AStatus = cMiaRefunded then
    Result := 'Rambursat'
  else if AStatus = cMiaRefundFailed then
    Result := 'Rambursare esuata!'
  else if AStatus = cMiaCancelled then
    Result := 'Renuntat'
  else
    Result := AStatus;
end;

// Cu cit e mai mic, cu atit starea e mai importanta pentru operator.
function StatusRank(const AStatus: string): Integer;
begin
  if (AStatus = cMiaPaid) or (AStatus = cMiaRefundRequested) or (AStatus = cMiaRefundFailed) then
    Result := 0
  else if AStatus = cMiaMismatch then
    Result := 1
  else if AStatus = cMiaRefunded then
    Result := 2
  else if AStatus = cMiaNew then
    Result := 3
  else
    Result := 4;
end;

function ErrorText(const ACode: string): string;
begin
  if ACode = 'NO_DOC' then
    Result := 'Documentul nu exista sau este sters.'
  else if ACode = 'NOT_MDL' then
    Result := 'Documentul nu este in lei. Plata MIA se face doar in MDL.'
  else if ACode = 'NO_AMOUNT' then
    Result := 'Documentul are suma zero.'
  else if ACode = 'ALREADY_PAID' then
    Result := 'Comanda are deja o plata MIA confirmata.'
  else if ACode = 'NOT_FOUND' then
    Result := 'Plata nu a fost gasita.'
  else if ACode = 'BAD_STATUS' then
    Result := 'Plata nu este confirmata sau este deja rambursata / in curs de rambursare.'
  else if ACode = 'NO_PHONE' then
    Result := 'Comanda nu are numar de telefon.'
  else
    Result := 'Operatia a fost refuzata (' + ACode + ').';
end;

// Interogare in tranzactie proprie. AWrite = True: tranzactia se comite la sfirsit
// (procedurile selectabile care scriu). ARow se cheama pentru fiecare rind.
procedure RunQuery(AConn: TIBCConnection; const ASQL: string; const AWrite: Boolean;
  const ASetup, ARow: TProc<TIBCQuery>);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConn;
    if not AWrite then
      Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Q.Connection := AConn;
    Q.Transaction := Tr;
    Q.SQL.Text := ASQL;
    if Assigned(ASetup) then
      ASetup(Q);
    try
      if AWrite then
        Tr.StartTransaction;
      Q.Open;
      while not Q.Eof do
      begin
        if Assigned(ARow) then
          ARow(Q);
        Q.Next;
      end;
      Q.Close;
      if Tr.Active then
        Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    Q.Free;
    Tr.Free;
  end;
end;

function MiaPaymentsAvailable(AConn: TIBCConnection): Boolean;
var
  Found: Integer;
begin
  if GAvailability < 0 then
  begin
    GAvailability := 0;
    Found := 0;
    try
      RunQuery(AConn,
        'SELECT (SELECT COUNT(*) FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ''TWEB_MIA_VB_PAYMENT'') + ' +
        '       (SELECT COUNT(*) FROM RDB$PROCEDURES WHERE RDB$PROCEDURE_NAME = ''WEB_MIA_VB_CREATE_LINK'') ' +
        'FROM RDB$DATABASE', False, nil,
        procedure(Q: TIBCQuery)
        begin
          Found := Q.Fields[0].AsInteger;
        end);
      if Found = 2 then
        GAvailability := 1;
    except
      GAvailability := 0;
    end;
  end;
  Result := GAvailability = 1;
end;

procedure ReadPayment(Q: TIBCQuery; var P: TMiaOrderPayment);
begin
  P.Found := True;
  P.PaymentID := Q.FieldByName('PAYMENT_ID').AsLargeInt;
  P.DocID := Q.FieldByName('DOCID').AsInteger;
  P.Status := Trim(Q.FieldByName('STATUS').AsString);
  P.Token := Trim(Q.FieldByName('TOKEN').AsString);
  P.Amount := Q.FieldByName('AMOUNT').AsCurrency;
  P.PaidAmount := Q.FieldByName('PAID_AMOUNT').AsCurrency;
  P.PaidAt := Q.FieldByName('PAID_AT').AsDateTime;
  P.TxID := Trim(Q.FieldByName('TX_ID').AsString);
  P.PayerName := Trim(Q.FieldByName('PAYER_NAME').AsString);
  P.Source := Trim(Q.FieldByName('SOURCE').AsString);
  P.CreatedAt := Q.FieldByName('CREATED_AT').AsDateTime;
end;

function LoadMiaOrderPayment(AConn: TIBCConnection; const ADocID: Integer): TMiaOrderPayment;
var
  P: TMiaOrderPayment;
  DocID: Integer;
begin
  P := Default(TMiaOrderPayment);
  DocID := ADocID;
  if (DocID > 0) and MiaPaymentsAvailable(AConn) then
    RunQuery(AConn,
      'SELECT FIRST 1 PAYMENT_ID, DOCID, STATUS, TOKEN, AMOUNT, PAID_AMOUNT, PAID_AT, TX_ID, PAYER_NAME, ' +
      '       SOURCE, CREATED_AT ' +
      'FROM TWEB_MIA_VB_PAYMENT WHERE DOCID = :DOCID ' +
      'ORDER BY CASE STATUS WHEN ''Paid'' THEN 0 WHEN ''RefundRequested'' THEN 0 WHEN ''RefundFailed'' THEN 0 ' +
      '  WHEN ''Mismatch'' THEN 1 WHEN ''Refunded'' THEN 2 WHEN ''New'' THEN 3 ELSE 4 END, PAYMENT_ID DESC',
      False,
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('DOCID').AsInteger := DocID;
      end,
      procedure(Q: TIBCQuery)
      begin
        ReadPayment(Q, P);
      end);
  Result := P;
end;

function LoadMiaStates(AConn: TIBCConnection): TDictionary<Integer, string>;
var
  States: TDictionary<Integer, string>;
begin
  States := TDictionary<Integer, string>.Create;
  try
    if MiaPaymentsAvailable(AConn) then
      RunQuery(AConn, 'SELECT DOCID, STATUS FROM TWEB_MIA_VB_PAYMENT', False, nil,
        procedure(Q: TIBCQuery)
        var
          DocID: Integer;
          Status, Old: string;
        begin
          DocID := Q.Fields[0].AsInteger;
          Status := Trim(Q.Fields[1].AsString);
          // o comanda poate avea mai multe cereri: ramine cea mai importanta
          if not States.TryGetValue(DocID, Old) or (StatusRank(Status) < StatusRank(Old)) then
            States.AddOrSetValue(DocID, Status);
        end);
  except
    States.Free;
    raise;
  end;
  Result := States;
end;

function ConfigValue(AConn: TIBCConnection; const AName, ADefault: string): string;
var
  Value: string;
  Name: string;
begin
  Value := '';
  Name := AName;
  try
    RunQuery(AConn,
      'SELECT PARAM_VALUE FROM TS_API_CONFIG WHERE API_CODE = :C AND PARAM_NAME = :N AND FLG_ACTIVE = 1',
      False,
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('C').AsString := cConfigCode;
        Q.ParamByName('N').AsString := Name;
      end,
      procedure(Q: TIBCQuery)
      begin
        Value := Trim(Q.Fields[0].AsString);
      end);
  except
    Value := '';   // fara TS_API_CONFIG ramin valorile implicite
  end;
  if Value = '' then
    Result := ADefault
  else
    Result := Value;
end;

function MiaPayUrl(AConn: TIBCConnection; const AToken: string): string;
var
  Base: string;
begin
  if AToken = '' then
    Exit('');
  Base := ConfigValue(AConn, 'PAY_URL', cDefaultPayUrl);
  if not Base.EndsWith('/') then
    Base := Base + '/';
  Result := Base + AToken;
end;

function MiaCreateLink(AConn: TIBCConnection; const ADocID, AUserID: Integer; out APayment: TMiaOrderPayment;
  out AError: string): Boolean;
var
  DocID, UserID: Integer;
  Brand, Code: string;
  PaymentID: Int64;
begin
  APayment := Default(TMiaOrderPayment);
  AError := '';
  Result := False;
  if not MiaPaymentsAvailable(AConn) then
  begin
    AError := 'Platile MIA nu sint instalate in baza de date (DB Model\mia_vb_payments.sql).';
    Exit;
  end;

  DocID := ADocID;
  UserID := AUserID;
  Brand := ConfigValue(AConn, 'BRAND', cDefaultBrand);
  Code := '';
  PaymentID := 0;
  try
    RunQuery(AConn,
      'SELECT PAYMENT_ID, ERROR_CODE FROM WEB_MIA_VB_CREATE_LINK(:DOCID, :BRAND, :USERID)', True,
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('DOCID').AsInteger := DocID;
        Q.ParamByName('BRAND').AsString := Brand;
        Q.ParamByName('USERID').AsInteger := UserID;
      end,
      procedure(Q: TIBCQuery)
      begin
        Code := Trim(Q.FieldByName('ERROR_CODE').AsString);
        PaymentID := Q.FieldByName('PAYMENT_ID').AsLargeInt;
      end);
  except
    on E: Exception do
    begin
      AError := E.Message;
      Exit;
    end;
  end;

  if Code <> '' then
  begin
    AError := ErrorText(Code);
    Exit;
  end;
  if PaymentID <= 0 then
  begin
    AError := 'Linkul de plata nu a putut fi creat.';
    Exit;
  end;

  APayment := LoadMiaOrderPayment(AConn, ADocID);
  Result := APayment.HasOpenLink;
  if not Result then
    AError := 'Linkul de plata nu a putut fi creat.';
end;

function MiaRequestRefund(AConn: TIBCConnection; const APaymentID: Int64; const AUserID: Integer;
  out AError: string): Boolean;
var
  PaymentID: Int64;
  UserID: Integer;
  Code: string;
  Answered: Boolean;
begin
  AError := '';
  Result := False;
  PaymentID := APaymentID;
  UserID := AUserID;
  Code := '';
  Answered := False;
  try
    RunQuery(AConn, 'SELECT ERROR_CODE FROM WEB_MIA_VB_REQUEST_REFUND(:ID, :USERID)', True,
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('ID').AsLargeInt := PaymentID;
        Q.ParamByName('USERID').AsInteger := UserID;
      end,
      procedure(Q: TIBCQuery)
      begin
        Answered := True;
        Code := Trim(Q.FieldByName('ERROR_CODE').AsString);
      end);
  except
    on E: Exception do
    begin
      AError := E.Message;
      Exit;
    end;
  end;

  if not Answered then
    AError := 'Cererea de rambursare nu a primit raspuns.'
  else if Code <> '' then
    AError := ErrorText(Code)
  else
    Result := True;
end;

function MiaLinkSmsText(const ADocID: Integer; const AUrl: string): string;
begin
  Result := Format('Comanda nr.%d: achitati prin MIA~%s', [ADocID, AUrl]);
end;

function MiaSendLinkSms(AConn: TIBCConnection; const ADocID: Integer; const AText, APhone: string;
  out ASentTo, AError: string): Boolean;
var
  DocID: Integer;
  Text, Phone, Code, SentTo: string;
begin
  ASentTo := '';
  AError := '';
  Result := False;
  DocID := ADocID;
  Text := AText;
  Phone := Trim(APhone);
  Code := '';
  SentTo := '';
  try
    RunQuery(AConn, 'SELECT PHONE, ERROR_CODE FROM WEB_MIA_VB_LINK_SMS(:DOCID, :TEXT, :PHONE)', True,
      procedure(Q: TIBCQuery)
      begin
        Q.ParamByName('DOCID').AsInteger := DocID;
        Q.ParamByName('TEXT').AsString := Text;
        if Phone = '' then
        begin
          Q.ParamByName('PHONE').DataType := ftString;
          Q.ParamByName('PHONE').Clear;
        end
        else
          Q.ParamByName('PHONE').AsString := Phone;
      end,
      procedure(Q: TIBCQuery)
      begin
        SentTo := Trim(Q.FieldByName('PHONE').AsString);
        Code := Trim(Q.FieldByName('ERROR_CODE').AsString);
      end);
  except
    on E: Exception do
    begin
      AError := E.Message;
      Exit;
    end;
  end;

  ASentTo := SentTo;
  if Code <> '' then
    AError := ErrorText(Code)
  else if SentTo = '' then
    AError := 'SMS-ul nu a putut fi pus in coada.'
  else
    Result := True;
end;

end.

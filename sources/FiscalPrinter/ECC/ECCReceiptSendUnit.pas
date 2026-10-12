unit ECCReceiptSendUnit;

(* Cum primeste clientul bonul emis pe casa ECC: tiparit, pe e-mail, pe Viber sau prin SMS.

   Operatorul alege inainte de emitere (ECCChooseReceiptSend, fereastra frmECCReceiptSendDialog), ca
   adresa / numarul sa fie verificate pina sa existe bonul; dupa emitere ECCSendReceipt il preda clientului.
   API-ul ECC nu trimite bonul (SMS / e-mail are doar aplicatia ECC), de aceea WMS trimite singur:
     Tiparire - PNG-ul bonului pe imprimanta bonurilor (ECCFiscalDevice), ca pina acum;
     E-mail   - coada EMAIL_MESSAGES (SP_CREATE_MAIL_TO_SEND), corp HTML cu produsele si linkul MEV.
                Coada nu are atasamevnte; linkul MEV e verificarea oficiala a bonului la SFS;
     Viber    - PNG-ul in clipboard ca fisier + conversatia deschisa pe numar (ca "Trimite pe..."
                din rapoarte, ReportMessengerSendUnit); operatorul apasa Ctrl+V si Enter;
     SMS      - coada SMS_MESSAGES: numar, suma si linkul MEV;
     Fara actiune - bonul doar se emite si se inregistreaza in MEV (PNG-ul ramine in jurnal).
   Cozile le trimite serviciul de mesaje din afara WMS. Inserarea merge pe o tranzactie proprie:
   dmDB.SendSMS / SendSWNMail lucreaza pe IBCTrDefaultUpdate, care poate fi activa in dialogul bonului.
   Contactul propus: din deal-ul documentului (sau al parintilor lui), apoi din clientul CT. *)

interface

uses
  System.SysUtils, System.Classes, FiscalDeviceUnit;

type
  // ordinea = valoarea salvata in ECC_RECEIPT_SEND_KIND: variantele noi se adauga la sfirsit
  TECCReceiptSendKind = (rskPrint, rskEmail, rskViber, rskSms, rskNone);

  TECCReceiptSendChoice = record
    Kind: TECCReceiptSendKind;
    Contact: string;  // e-mail-ul sau telefonul, deja verificat ('' la tiparire)
  end;

const
  cECCReceiptSendNames: array[TECCReceiptSendKind] of string = ('Tiparire', 'E-mail', 'Viber', 'SMS', 'Fara actiune');

// Fereastra de dinaintea emiterii: ASummary = ce bon se emite; ADocID = documentul din care
// se propune contactul. False = operatorul a renuntat (bonul nu se emite).
function ECCChooseReceiptSend(const ASummary: string; const ADocID: Integer;
  out AChoice: TECCReceiptSendChoice): Boolean;

// Dupa emitere. Intoarce textul pentru operator ('' la tiparire); exceptie = nu s-a trimis.
function ECCSendReceipt(const AChoice: TECCReceiptSendChoice; const ADocID: Integer; const R: TFiscalReceipt;
  const AResult: TFiscalReceiptResult; const ASuma: Currency): string;

implementation

uses
  System.UITypes, System.IOUtils, IBC, DataModuleDB, SWNValueStorageUnit, ReportMessengerSendUnit,
  ECCTransactionStore, frmECCReceiptSendDialog;

const
  cSendKindKey = 'ECC_RECEIPT_SEND_KIND';
  cPhoneTypeMobile = 7468; // TS_SYSS: "Telefon mobil"
  cSmsMaxLength = 280;     // SMS_MESSAGES.SMS_TEXT

  // documentul si parintii lui (deal-ul e legat de obicei de comanda / rezerva)
  cDocChainCTE =
    'WITH RECURSIVE P AS (SELECT DOCID, PARENTDOCID FROM TDB_DOCS WHERE DOCID = :DOCID ' +
    'UNION ALL SELECT D.DOCID, D.PARENTDOCID FROM TDB_DOCS D JOIN P ON D.DOCID = P.PARENTDOCID) ';

function QueryFirst(const ASQL: string; const ADocID: Integer): string;
var
  Q: TIBCQuery;
begin
  Result := '';
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := dmDB.IBCConnection;
    Q.Transaction := dmDB.IBCTrDefaultSelect;
    Q.SQL.Text := ASQL;
    Q.ParamByName('DOCID').AsInteger := ADocID;
    Q.Open;
    if not Q.Eof then
      Result := Trim(Q.Fields[0].AsString);
  finally
    Q.Free;
  end;
end;

function FindDocPhone(const ADocID: Integer): string;
begin
  Result := QueryFirst(cDocChainCTE +
    'SELECT FIRST 1 D.PHONE FROM P JOIN TDB_DEAL_DOCS L ON L.DOCID = P.DOCID ' +
    'JOIN TDB_DEALS D ON D.DEAL_ID = L.DEAL_ID WHERE COALESCE(TRIM(D.PHONE), '''') <> ''''', ADocID);
  if Result = '' then
    Result := QueryFirst(
      'SELECT FIRST 1 P.PHONENUMBER FROM TS_CUST_PHONES P ' +
      'WHERE P.CUSTOMERID = (SELECT CT FROM TDB_DOCS WHERE DOCID = :DOCID) ' +
      'AND COALESCE(TRIM(P.PHONENUMBER), '''') <> '''' ' +
      'ORDER BY CASE WHEN P.PHONETYPEID = ' + IntToStr(cPhoneTypeMobile) + ' THEN 0 ELSE 1 END, P.PHONEID DESC',
      ADocID);
end;

function FindDocEmail(const ADocID: Integer): string;
begin
  Result := QueryFirst(cDocChainCTE +
    'SELECT FIRST 1 D.EMAIL FROM P JOIN TDB_DEAL_DOCS L ON L.DOCID = P.DOCID ' +
    'JOIN TDB_DEALS D ON D.DEAL_ID = L.DEAL_ID WHERE COALESCE(TRIM(D.EMAIL), '''') <> ''''', ADocID);
  if Result = '' then
    Result := QueryFirst(
      'SELECT FIRST 1 E.EMAIL FROM TS_CUST_EMAILS E ' +
      'WHERE E.CUSTOMERID = (SELECT CT FROM TDB_DOCS WHERE DOCID = :DOCID) AND E.UNSUBSCRIBED = 0 ' +
      'ORDER BY E.ID DESC', ADocID);
  if Result = '' then
    Result := QueryFirst(
      'SELECT FIRST 1 W.EMAIL FROM TS_CUST_WEB W ' +
      'WHERE W.CUSTOMERID = (SELECT CT FROM TDB_DOCS WHERE DOCID = :DOCID) AND COALESCE(TRIM(W.EMAIL), '''') <> ''''',
      ADocID);
end;

function ECCChooseReceiptSend(const ASummary: string; const ADocID: Integer;
  out AChoice: TECCReceiptSendChoice): Boolean;
var
  F: TfrmECCReceiptSendDlg;
  Kind: Integer;
begin
  AChoice := Default(TECCReceiptSendChoice);
  Kind := AppConfigStorage.IntValues.GetValue(cSendKindKey, Ord(rskPrint));
  if (Kind < Ord(Low(TECCReceiptSendKind))) or (Kind > Ord(High(TECCReceiptSendKind))) then
    Kind := Ord(rskPrint);
  F := TfrmECCReceiptSendDlg.Create(nil);
  try
    F.SetData(ASummary, FindDocEmail(ADocID), FindDocPhone(ADocID), TECCReceiptSendKind(Kind));
    Result := F.ShowModal = mrOk;
    if Result then
    begin
      AChoice := F.Choice;
      AppConfigStorage.IntValues.SetValue(cSendKindKey, Ord(AChoice.Kind));
    end;
  finally
    F.Free;
  end;
end;

{ trimiterea }

// O inserare in coada (SMS_MESSAGES / EMAIL_MESSAGES), comisa pe loc pe o tranzactie proprie.
procedure QueueMessage(const ASQL: string; const ANames, AValues: array of string);
var
  Tr: TIBCTransaction;
  Q: TIBCQuery;
  I: Integer;
begin
  Tr := TIBCTransaction.Create(nil);
  Q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := dmDB.IBCConnection;
    Q.Connection := dmDB.IBCConnection;
    Q.Transaction := Tr;
    Q.SQL.Text := ASQL;
    for I := 0 to High(ANames) do
      Q.ParamByName(ANames[I]).AsString := AValues[I];
    Tr.StartTransaction;
    try
      Q.ExecSQL;
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

function HtmlEsc(const S: string): string;
begin
  Result := StringReplace(S, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
end;

function Money(const V: Currency): string;
begin
  Result := FormatFloat('0.00', V);
end;

function FirmaName(const ADocID: Integer): string;
begin
  Result := QueryFirst('SELECT C.NAME FROM TDB_DOCS D JOIN TS_CUSTOMER C ON C.CUSTOMERID = D.DT ' +
    'WHERE D.DOCID = :DOCID', ADocID);
end;

function EmailBody(const AFirma: string; const R: TFiscalReceipt; const AResult: TFiscalReceiptResult;
  const ASuma: Currency): string;
var
  SB: TStringBuilder;
  L: TFiscalLine;
  P: TFiscalPayment;
begin
  SB := TStringBuilder.Create;
  try
    SB.Append('<div style="font-family:Arial,sans-serif;font-size:14px;color:#222">');
    SB.Append('<p>Buna ziua!</p>');
    SB.AppendFormat('<p>Va multumim pentru cumparatura. Mai jos este bonul fiscal nr. <b>%d</b> din %s',
      [AResult.Number, FormatDateTime('dd.mm.yyyy hh:nn', AResult.DateTime)]);
    if AFirma <> '' then
      SB.Append(', emis de ' + HtmlEsc(AFirma));
    SB.Append('.</p>');
    SB.Append('<table cellpadding="4" cellspacing="0" style="border-collapse:collapse;font-size:13px">');
    SB.Append('<tr style="background:#f0f0f0"><th align="left">Produs</th><th align="right">Cant.</th>' +
      '<th align="right">Pret</th><th align="right">Suma</th></tr>');
    for L in R.Lines do
      SB.AppendFormat('<tr style="border-top:1px solid #ddd"><td>%s</td><td align="right">%s</td>' +
        '<td align="right">%s</td><td align="right">%s</td></tr>',
        [HtmlEsc(L.Title), FormatFloat('0.###', L.Qty), Money(L.Price), Money(FiscalRoundMoney(L.Price * L.Qty))]);
    SB.AppendFormat('<tr style="border-top:2px solid #222"><td colspan="3"><b>Total</b></td>' +
      '<td align="right"><b>%s lei</b></td></tr>', [Money(ASuma)]);
    for P in R.Payments do
      SB.AppendFormat('<tr><td colspan="3">%s</td><td align="right">%s lei</td></tr>',
        [HtmlEsc(FiscalPayKindName(P.Kind)), Money(P.Amount)]);
    SB.Append('</table>');
    if AResult.MevLink <> '' then
      SB.AppendFormat('<p>Bonul poate fi verificat pe site-ul Serviciului Fiscal de Stat: ' +
        '<a href="%s">verificare bon fiscal</a>.</p>', [HtmlEsc(AResult.MevLink)]);
    SB.Append('</div>');
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

function SendByEmail(const AChoice: TECCReceiptSendChoice; const ADocID: Integer; const R: TFiscalReceipt;
  const AResult: TFiscalReceiptResult; const ASuma: Currency): string;
var
  Firma, Subject: string;
begin
  Firma := FirmaName(ADocID);
  Subject := Format('Bon fiscal nr. %d din %s', [AResult.Number, FormatDateTime('dd.mm.yyyy', AResult.DateTime)]);
  if Firma <> '' then
    Subject := Subject + ' - ' + Firma;
  QueueMessage('EXECUTE PROCEDURE SP_CREATE_MAIL_TO_SEND(:MAIL_TO, '''', :MAIL_SUBJECT, :MAIL_BODY)',
    ['MAIL_TO', 'MAIL_SUBJECT', 'MAIL_BODY'], [AChoice.Contact, Subject, EmailBody(Firma, R, AResult, ASuma)]);
  Result := 'Bonul a fost trimis pe e-mail la ' + AChoice.Contact + '.';
end;

function SendBySms(const AChoice: TECCReceiptSendChoice; const AResult: TFiscalReceiptResult;
  const ASuma: Currency): string;
var
  Text: string;
begin
  if AResult.MevLink = '' then
    raise Exception.Create('Casa ECC nu a intors linkul de verificare al bonului; SMS-ul nu are ce trimite.');
  Text := Format('Bon fiscal nr.%d din %s, suma %s lei. Verificare: %s',
    [AResult.Number, FormatDateTime('dd.mm.yyyy hh:nn', AResult.DateTime), Money(ASuma), AResult.MevLink]);
  if Length(Text) > cSmsMaxLength then
    Text := Format('Bon fiscal %s lei: %s', [Money(ASuma), AResult.MevLink]);
  QueueMessage('INSERT INTO SMS_MESSAGES (PHONE, SMS_TEXT) VALUES (:PHONE, :SMS_TEXT)',
    ['PHONE', 'SMS_TEXT'], [AChoice.Contact, Copy(Text, 1, cSmsMaxLength)]);
  Result := 'Bonul a fost trimis prin SMS la ' + AChoice.Contact + '.';
end;

function SendByViber(const AChoice: TECCReceiptSendChoice; const AResult: TFiscalReceiptResult): string;
var
  Store: TECCTransactionStore;
  Png: TMemoryStream;
  FileName: string;
begin
  Png := TMemoryStream.Create;
  Store := TECCTransactionStore.Create(dmDB.IBCConnection);
  try
    if (AResult.ExternalId = '') or not Store.LoadPng(AResult.ExternalId, Png) then
      raise Exception.Create('Imaginea bonului nu a putut fi descarcata de la casa ECC.');
    FileName := TPath.Combine(TPath.GetTempPath, Format('Bon_fiscal_%d.png', [AResult.Number]));
    Png.SaveToFile(FileName);
  finally
    Store.Free;
    Png.Free;
  end;
  CopyFileToClipboard(FileName);
  if not OpenMessengerChat(rmViber, AChoice.Contact) then
    raise Exception.Create('Viber nu s-a deschis (nu este instalat pe acest calculator?). ' +
      'Imaginea bonului este in clipboard: ' + FileName);
  Result := 'In Viber s-a deschis conversatia cu +' + AChoice.Contact + '. ' +
    'Apasati Ctrl+V in conversatie si apoi Enter: imaginea bonului este in clipboard.';
end;

function ECCSendReceipt(const AChoice: TECCReceiptSendChoice; const ADocID: Integer; const R: TFiscalReceipt;
  const AResult: TFiscalReceiptResult; const ASuma: Currency): string;
begin
  case AChoice.Kind of
    rskEmail: Result := SendByEmail(AChoice, ADocID, R, AResult, ASuma);
    rskViber: Result := SendByViber(AChoice, AResult);
    rskSms: Result := SendBySms(AChoice, AResult, ASuma);
  else
    Result := '';
  end;
end;

end.

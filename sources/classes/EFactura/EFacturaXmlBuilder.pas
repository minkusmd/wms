unit EFacturaXmlBuilder;

{
  Genereaza XML-ul unei facturi fiscale pentru SIA "e-Factura" (formatul de
  import <Documents><Document><SupplierInfo>...) din documentul WMS (TDB_DOCS,
  DocTypeID 112) si factura lui neanulata (TDB_INVOICES).

  Folosit si de exportul manual in fisier (frame25 -> "Export e-Factura") si de
  trimiterea prin API (EFacturaManager), ca sa nu existe doua formate.

  Nu exista XSD public; referinta este XML-ul intors de GetInvoicesBySeriaNumber
  pentru facturile reale. La import, e-Factura suprascrie denumirea/adresa din
  Registrul fiscal si calculeaza singura Total/TotalTVA.

  Fata de vechiul TXMLDocument din frame25:
  - sumele se scriu mereu cu punct zecimal, indiferent de setarile Windows;
  - nu mai ajung pe factura textele de test "Comentarii", "Documente anexate"
    si "FEAWDADA22" (apareau pe facturile reale);
  - transportatorul se scrie doar daca e indicat;
  - toate problemele de date se raporteaza intr-un singur mesaj.
}

interface

uses
  System.SysUtils, System.Classes, IBC;

type
  EEFacturaXmlError = class(Exception);

  TEFacturaXmlBuilder = class
  private
    FConnection: TIBCConnection;
    FInvoiceID: Integer;
  public
    constructor Create(AConnection: TIBCConnection);
    // AApiId - identificatorul nostru, scris in AdditionalInformation/id (cheia
    // de cautare APIeInvoiceId); gol = fara AdditionalInformation.
    function Build(ADocID: Integer; const AApiId: string = ''): string;
    procedure SaveToFile(ADocID: Integer; const AFileName: string; const AApiId: string = '');
    // factura (TDB_INVOICES.INVOICEID) folosita la ultimul Build
    property InvoiceID: Integer read FInvoiceID;
  end;

implementation

uses
  System.Math, System.DateUtils, System.IOUtils, Data.DB, EFacturaApiClient;

const
  cAddrTypeLegal = 7663; // adresa juridica

  cHeaderSQL =
    'SELECT D.DOCID, D.DATA, D.DT_NAME, D.CT_NAME,' +
    '  I.INVOICEID, I.TRANSPORTATOR, I.DOCUMENTE_ANEXATE,' +
    '  (SELECT A.FULL_ADDRESS FROM VW_TS_CUST_ADDR A WHERE A.ADDRID = I.PUNCT_INCARCARE) DT_ADDRESS,' +
    '  (SELECT A.FULL_ADDRESS FROM VW_TS_CUST_ADDR A WHERE A.CUSTOMERID = D.DT AND A.ADDRTYPEID = :ADDR_LEGAL) DT_ADDRESS2,' +
    '  (SELECT CI.IDEN_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.DT) DT_IDEN_NUMBER,' +
    '  (SELECT CI.VAT_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.DT) DT_VAT_NUMBER,' +
    '  (SELECT A.FULL_ADDRESS FROM VW_TS_CUST_ADDR A WHERE A.ADDRID = I.PUNCT_DESCARCARE) CT_ADDRESS,' +
    '  (SELECT A.FULL_ADDRESS FROM VW_TS_CUST_ADDR A WHERE A.CUSTOMERID = D.CT AND A.ADDRTYPEID = :ADDR_LEGAL) CT_ADDRESS2,' +
    '  (SELECT CI.IDEN_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.CT) CT_IDEN_NUMBER,' +
    '  (SELECT CI.VAT_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = D.CT) CT_VAT_NUMBER,' +
    '  DA.ACCOUNTNUMBER DT_ACCOUNT, DA.BANKACCOUNT DT_BANKACCOUNT,' +
    '  (SELECT B.BANKNAME FROM TS_BANKS B WHERE B.BANKACCOUNT = DA.BANKACCOUNT) DT_BANKNAME,' +
    '  CA.ACCOUNTNUMBER CT_ACCOUNT, CA.BANKACCOUNT CT_BANKACCOUNT,' +
    '  (SELECT B.BANKNAME FROM TS_BANKS B WHERE B.BANKACCOUNT = CA.BANKACCOUNT) CT_BANKNAME,' +
    '  (SELECT CI.IDEN_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = I.TRANSPORTATOR) TRANS_IDNO,' +
    '  (SELECT CI.VAT_NUMBER FROM TS_CUST_INFO CI WHERE CI.CUSTOMERID = I.TRANSPORTATOR) TRANS_VAT_NUMBER,' +
    '  IIF(EXISTS(SELECT C1.FIRMA_NAME FROM TS_CUST_1C C1 WHERE C1.CUSTOMERID = I.TRANSPORTATOR),' +
    '      (SELECT C1.FIRMA_NAME FROM TS_CUST_1C C1 WHERE C1.CUSTOMERID = I.TRANSPORTATOR),' +
    '      (SELECT C.DISPLAYNAME FROM TS_CUSTOMER C WHERE C.CUSTOMERID = I.TRANSPORTATOR AND I.TRANSPORTATOR > -1)) TRANS_NAME,' +
    '  (SELECT A.FULL_ADDRESS FROM VW_TS_CUST_ADDR A WHERE A.CUSTOMERID = I.TRANSPORTATOR AND A.ADDRTYPEID = :ADDR_LEGAL) TRANS_ADDRESS,' +
    '  TA.ACCOUNTNUMBER TRANS_ACCOUNT, TA.BANKACCOUNT TRANS_BANKACCOUNT,' +
    '  (SELECT B.BANKNAME FROM TS_BANKS B WHERE B.BANKACCOUNT = TA.BANKACCOUNT) TRANS_BANKNAME,' +
    '  (SELECT S.TITLE FROM TS_SYSS S WHERE S.SYSSID = I.REDIRIJARIID) REDIRIJARI_NAME,' +
    '  (SELECT C.VAT FROM TDB_DOCS D2 JOIN TDB_CONTRACTS C ON C.CONTRACTID = D2.CONTRACTID' +
    '   WHERE D2.DOCID = D.DOCID) CONTRACT_VAT' +
    ' FROM VW_TDB_DOCS D' +
    '  LEFT OUTER JOIN TDB_DOCS_RECHIZITE DR ON (DR.DOCID = D.DOCID)' +
    '  LEFT OUTER JOIN TS_CUST_ACCOUNTS DA ON (DA.CUSTOMERID = D.DT AND DA.ACCOUNTNUMBER = DR.DT_CD)' +
    '  LEFT OUTER JOIN TS_CUST_ACCOUNTS CA ON (CA.CUSTOMERID = D.CT AND CA.ACCOUNTNUMBER = DR.CT_CD)' +
    '  LEFT OUTER JOIN TDB_INVOICES I ON (I.DOCID = D.DOCID AND I.FLG_CANCELED = 0)' +
    '  LEFT OUTER JOIN TS_CUST_ACCOUNTS TA ON (TA.CUSTOMERID = I.TRANSPORTATOR AND' +
    '    TA.ACCOUNTNUMBER = (SELECT TA1.ACCOUNTNUMBER FROM TS_CUST_ACCOUNTS TA1' +
    '                        WHERE TA1.CUSTOMERID = TA.CUSTOMERID AND TA1.DEFAULT_ACCOUNT = 1))' +
    ' WHERE D.DOCID = :DOCID';

  cRowsSQL =
    'SELECT P.GOODS_ACNT_ID, P.NAMEACNT, P.GOODS_NAME, P.QTY, P.UM_NAME,' +
    '  (SELECT G.VAT FROM TS_GOODS G WHERE G.GOODSID = P.GOODSID) VAT_RATE,' +
    '  IIF(P.QTY = 0, 0, ROUND((ROUND(P.SUMA, 3) - ROUND(P.SUMAVAT, 3)) / P.QTY, 2)) PRICE_WVAT,' +
    '  ROUND(P.SUMA, 2) SUMA,' +
    '  ROUND(P.SUMAVAT, 2) SUMAVAT' +
    ' FROM GET_GOODS_FOR_RECEIPT(:DOCID) P';

var
  InvariantFS: TFormatSettings;

function FmtMoney(V: Double): string;
begin
  Result := FormatFloat('0.00', V, InvariantFS);
end;

function FmtQty(V: Double): string;
begin
  Result := FormatFloat('0.###', V, InvariantFS);
end;

// perechi nume/valoare -> ' nume="valoare"...'
function Attrs(const APairs: array of string): string;
var
  I: Integer;
begin
  Result := '';
  I := 0;
  while I < High(APairs) do
  begin
    Result := Result + ' ' + APairs[I] + '="' + EFacturaXmlEscape(Trim(APairs[I + 1])) + '"';
    Inc(I, 2);
  end;
end;

procedure AddText(SB: TStringBuilder; const AName, AValue: string);
begin
  if Trim(AValue) = '' then
    Exit;
  SB.Append('<' + AName + '>' + EFacturaXmlEscape(Trim(AValue)) + '</' + AName + '>' + sLineBreak);
end;

procedure AddBankAccount(SB: TStringBuilder; const ABranchTitle, ABranchCode, AAccount: string);
begin
  SB.Append('<BankAccount' + Attrs(['BranchTitle', ABranchTitle, 'BranchCode', ABranchCode,
    'Account', AAccount]) + '/>' + sLineBreak);
end;

// IDNP-ul persoanelor fizice are tot 13 cifre, dar incepe cu 2 (IDNO-ul firmelor - cu 1).
function TaxpayerTypeOf(const AIDNO: string): string;
begin
  if (Length(Trim(AIDNO)) = 13) and (Trim(AIDNO)[1] = '2') then
    Result := '2'
  else
    Result := '1';
end;

// Cota vine din TS_GOODS.VAT (0/8/20). Daca nu se potriveste cu suma TVA din
// document (cota schimbata intre timp), se recalculeaza din sume, ca in exportul
// vechi. "-" = fara TVA (neplatitor / scutit), "0" = cota zero.
// AZeroRated: furnizor platitor de TVA + contract cu TVA 0 (ex. proiecte de asistenta
// tehnica) - randul fara TVA iese cu cota "0", ca in exportul manual vechi, prin care
// facturile PRIME STORE cu contract TVA 0 au primit serie si numar (EBI 000096917 etc.).
// Cu "-" la un platitor e-Factura respinge factura.
function VatRateOf(ARate: Integer; ANet, AVat: Double; AZeroRated: Boolean): string;
begin
  if (ARate > 0) and (Abs(RoundTo(ANet * ARate / 100, -2) - AVat) > 0.05) then
    ARate := 0;
  if (ARate = 0) and (Abs(AVat) >= 0.005) and (Abs(ANet) >= 0.005) then
    ARate := Round(100 * AVat / ANet);
  if (ARate = 0) and AZeroRated then
    Result := '0'
  else if ARate = 0 then
    Result := '-'
  else
    Result := IntToStr(ARate);
end;

{ TEFacturaXmlBuilder }

constructor TEFacturaXmlBuilder.Create(AConnection: TIBCConnection);
begin
  inherited Create;
  FConnection := AConnection;
end;

function TEFacturaXmlBuilder.Build(ADocID: Integer; const AApiId: string): string;
var
  H, R: TIBCQuery;
  SB: TStringBuilder;
  Errors: TStringList;
  Suma, Vat: Double;
  RowCount: Integer;
  S: string;
  ZeroRated: Boolean;
begin
  FInvoiceID := 0;
  Errors := TStringList.Create;
  SB := TStringBuilder.Create;
  H := TIBCQuery.Create(nil);
  R := TIBCQuery.Create(nil);
  try
    H.Connection := FConnection;
    H.SQL.Text := cHeaderSQL;
    H.ParamByName('DOCID').AsInteger := ADocID;
    H.ParamByName('ADDR_LEGAL').AsInteger := cAddrTypeLegal;
    H.Open;
    if H.IsEmpty then
      raise EEFacturaXmlError.CreateFmt('Documentul #%d nu exista.', [ADocID]);
    if H.FieldByName('INVOICEID').IsNull then
      raise EEFacturaXmlError.CreateFmt('Documentul #%d nu are o factura fiscala neanulata.', [ADocID]);
    FInvoiceID := H.FieldByName('INVOICEID').AsInteger;
    H.Next;
    if not H.Eof then
      raise EEFacturaXmlError.CreateFmt('Documentul #%d are mai multe facturi neanulate.', [ADocID]);
    H.First;

    if Trim(H.FieldByName('DT_IDEN_NUMBER').AsString) = '' then
      Errors.Add('Furnizorul nu are cod fiscal (IDNO).');
    if Trim(H.FieldByName('CT_IDEN_NUMBER').AsString) = '' then
      Errors.Add('Cumparatorul nu are cod fiscal (IDNO).');
    if Trim(H.FieldByName('CT_ADDRESS2').AsString) = '' then
      Errors.Add('Adresa juridica a cumparatorului nu este setata.');
    if Trim(H.FieldByName('CT_ADDRESS').AsString) = '' then
      Errors.Add('Nu este indicat punctul de descarcare.');

    SB.Append('<Documents>' + sLineBreak + '<Document>' + sLineBreak + '<SupplierInfo>' + sLineBreak);
    // DATA e ora locala; exportul vechi o marca drept UTC ("Z") si e-Factura o pastreaza asa
    AddText(SB, 'DeliveryDate', DateToISO8601(H.FieldByName('DATA').AsDateTime));

    SB.Append('<Supplier' + Attrs(['IDNO', H.FieldByName('DT_IDEN_NUMBER').AsString,
      'CodTVA', H.FieldByName('DT_VAT_NUMBER').AsString,
      'Title', H.FieldByName('DT_NAME').AsString,
      'Address', H.FieldByName('DT_ADDRESS2').AsString]) + '>' + sLineBreak);
    AddBankAccount(SB, H.FieldByName('DT_BANKNAME').AsString, H.FieldByName('DT_BANKACCOUNT').AsString,
      H.FieldByName('DT_ACCOUNT').AsString);
    SB.Append('</Supplier>' + sLineBreak);

    SB.Append('<Buyer' + Attrs(['TaxpayerType', TaxpayerTypeOf(H.FieldByName('CT_IDEN_NUMBER').AsString),
      'IDNO', H.FieldByName('CT_IDEN_NUMBER').AsString,
      'CodTVA', H.FieldByName('CT_VAT_NUMBER').AsString,
      'Title', H.FieldByName('CT_NAME').AsString,
      'Address', H.FieldByName('CT_ADDRESS2').AsString]) + '>' + sLineBreak);
    AddBankAccount(SB, H.FieldByName('CT_BANKNAME').AsString, H.FieldByName('CT_BANKACCOUNT').AsString,
      H.FieldByName('CT_ACCOUNT').AsString);
    SB.Append('</Buyer>' + sLineBreak);

    if (H.FieldByName('TRANSPORTATOR').AsInteger > 0) and (Trim(H.FieldByName('TRANS_IDNO').AsString) <> '') then
    begin
      SB.Append('<Transporter' + Attrs(['IDNO', H.FieldByName('TRANS_IDNO').AsString,
        'CodTVA', H.FieldByName('TRANS_VAT_NUMBER').AsString,
        'Title', H.FieldByName('TRANS_NAME').AsString,
        'Address', H.FieldByName('TRANS_ADDRESS').AsString,
        'TaxpayerType', TaxpayerTypeOf(H.FieldByName('TRANS_IDNO').AsString)]) + '>' + sLineBreak);
      AddBankAccount(SB, H.FieldByName('TRANS_BANKNAME').AsString, H.FieldByName('TRANS_BANKACCOUNT').AsString,
        H.FieldByName('TRANS_ACCOUNT').AsString);
      SB.Append('</Transporter>' + sLineBreak);
    end;

    AddText(SB, 'AttachedDocuments', H.FieldByName('DOCUMENTE_ANEXATE').AsString);
    AddText(SB, 'LoadingPoint', H.FieldByName('DT_ADDRESS').AsString);
    AddText(SB, 'UnloadingPoint', H.FieldByName('CT_ADDRESS').AsString);
    AddText(SB, 'Redirections', H.FieldByName('REDIRIJARI_NAME').AsString);

    SB.Append('<Merchandises>' + sLineBreak);
    ZeroRated := (Trim(H.FieldByName('DT_VAT_NUMBER').AsString) <> '') and
      not H.FieldByName('CONTRACT_VAT').IsNull and (H.FieldByName('CONTRACT_VAT').AsFloat = 0);
    R.Connection := FConnection;
    R.SQL.Text := cRowsSQL;
    R.ParamByName('DOCID').AsInteger := ADocID;
    R.Open;
    RowCount := 0;
    while not R.Eof do
    begin
      if R.FieldByName('GOODS_ACNT_ID').AsInteger <= 0 then
        Errors.Add('Produs fara denumire contabila: ' + R.FieldByName('GOODS_NAME').AsString)
      else
      begin
        Suma := RoundTo(R.FieldByName('SUMA').AsFloat, -2);
        Vat := RoundTo(R.FieldByName('SUMAVAT').AsFloat, -2);
        SB.Append('<Row' + Attrs(['Code', R.FieldByName('GOODS_ACNT_ID').AsString,
          'Name', R.FieldByName('NAMEACNT').AsString,
          'UnitOfMeasure', R.FieldByName('UM_NAME').AsString,
          'Quantity', FmtQty(R.FieldByName('QTY').AsFloat),
          'UnitPriceWithoutTVA', FmtMoney(R.FieldByName('PRICE_WVAT').AsFloat),
          'TotalPriceWithoutTVA', FmtMoney(Suma - Vat),
          'TVA', VatRateOf(R.FieldByName('VAT_RATE').AsInteger, Suma - Vat, Vat, ZeroRated),
          'TotalTVA', FmtMoney(Vat),
          'TotalPrice', FmtMoney(Suma),
          'OtherInfo', '', 'PackageType', '', 'NumberOfPlaces', '', 'GrossWeight', '']) + '/>' + sLineBreak);
        Inc(RowCount);
      end;
      R.Next;
    end;
    if (RowCount = 0) and (Errors.Count = 0) then
      Errors.Add('Factura nu are produse.');
    SB.Append('</Merchandises>' + sLineBreak);

    // Motivul crearii depinde de furnizor:
    //   platitor de TVA (are cod TVA):  4 = livrare, 5 = non-livrare
    //   neplatitor de TVA (fara cod):   1 = livrare, 2 = non-livrare
    // Cu 4/5 la un neplatitor e-Factura respinge factura: "Motivul Crearii este indicat
    // incorect trebue sa fie 1 sau 2" (21.09.2026, SOLUTII COMERCIALE SRL, DOCID 2180796).
    // Sensul exact al lui 1 si 2 nu e documentat public - e dedus prin analogie cu 4/5.
    if Trim(H.FieldByName('DT_VAT_NUMBER').AsString) = '' then
    begin
      if H.FieldByName('REDIRIJARI_NAME').AsString = '<Non livrare>' then
        S := '2'
      else
        S := '1';
    end
    else if H.FieldByName('REDIRIJARI_NAME').AsString = '<Non livrare>' then
      S := '5'
    else
      S := '4';
    AddText(SB, 'CreationMotiv', S);
    SB.Append('</SupplierInfo>' + sLineBreak);

    if AApiId <> '' then
      SB.Append('<AdditionalInformation>' + sLineBreak + '<id>' + EFacturaXmlEscape(AApiId) + '</id>' + sLineBreak +
        '</AdditionalInformation>' + sLineBreak);
    SB.Append('</Document>' + sLineBreak + '</Documents>');

    if Errors.Count > 0 then
      raise EEFacturaXmlError.Create('XML-ul e-Factura nu poate fi generat:' + sLineBreak + Trim(Errors.Text));
    Result := SB.ToString;
  finally
    R.Free;
    H.Free;
    SB.Free;
    Errors.Free;
  end;
end;

procedure TEFacturaXmlBuilder.SaveToFile(ADocID: Integer; const AFileName, AApiId: string);
begin
  // UTF-8 fara BOM, ca TXMLDocument.SaveToFile folosit inainte
  TFile.WriteAllBytes(AFileName, TEncoding.UTF8.GetBytes('<?xml version="1.0" encoding="UTF-8"?>' + sLineBreak +
    Build(ADocID, AApiId)));
end;

initialization
  InvariantFS := TFormatSettings.Invariant;

end.

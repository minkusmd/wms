unit B2BClientUltra;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.URLClient,
  System.NetEncoding, Xml.XMLIntf, Xml.XMLDoc, System.Generics.Collections, System.Variants;

type
  TUltraProductInfo = record
    Code: string;
    Name: string;
    Price: Double;
    Quantity: Double;
    QuantityShowroom: Double;
    Currency: string;
    Available: Boolean;
    UUID: string;
    CharacteristicUUID: string;
  end;

  EUltraClientError = class(Exception);

  TB2BClientUltra = class
  private
    FUser: string;
    FPass: string;
    FEndpoint: string; // ex: https://portal.it-ultra.com/b2b/ru/ws/b2b.1cws
    FHttp: THTTPClient;
    function BasicAuthHeader: string;
    function PostSOAP(const ASoap: string): string;
    class function MakeEnvelope(const BodyXml: string): string; static;
    class function NewXML(const AXml: string): IXMLDocument; static;
    function RequestData(const AService: string; AAll, ACompress: Boolean;
      const AAdditional: string): string; // -> returns GUID ID
    function IsReady(const AID: string): Boolean;
    function GetDataByID(const AID: string; out AMessage, AInnerXml: string): Boolean;

    // helpers to parse inner XML payloads
    class procedure ParseBalanceXml(const InnerXml: string;
      out Items: TArray<TUltraProductInfo>); static;

    class procedure ParsePriceXml(const InnerXml: string;
      Prices: TDictionary<string, TPair<Double, string>>); static;
      // key = Characteristic UUID (can be empty '' for no char),
      // value = Pair<Price, CurrencyCode>

    class function IsGuidLike(const S: string): Boolean; static;

  public
    constructor Create(const AUser, APass: string; const AEndpointWithoutWsdl: string = 'https://portal.it-ultra.com/b2b/ru/ws/b2b.1cws');
    destructor Destroy; override;

    /// <summary>
    ///  Obține stocul (și, dacă e disponibil în PRICELIST, prețul + moneda)
    ///  pentru un produs identificat prin UUID de nomenclatură (nu cod).
    ///  Întoarce true dacă a reușit și umple AItems (în raze de caracteristici).
    /// </summary>
    function GetProductStockByUUID(const NomenclatureUUID: string;
      out AItems: TArray<TUltraProductInfo>;
      APollTimeoutMS: Integer = 30000; APollIntervalMS: Integer = 600): Boolean;

    /// <summary>
    ///  Shortcut: cere doar balanța (fără PRICELIST).
    /// </summary>
    function GetBalanceOnlyByUUID(const NomenclatureUUID: string;
      out AItems: TArray<TUltraProductInfo>;
      APollTimeoutMS: Integer = 30000; APollIntervalMS: Integer = 600): Boolean;

    property UserName: string read FUser;
    property Password: string read FPass;
    property Endpoint: string read FEndpoint;
  end;

implementation

{ TB2BClientUltra }

constructor TB2BClientUltra.Create(const AUser, APass: string; const AEndpointWithoutWsdl: string);
begin
  inherited Create;
  FUser := AUser;
  FPass := APass;
  // Documentația îți dă adresa WSDL; endpoint-ul efectiv de POST SOAP e fără ?wsdl
  // ex: https://portal.it-ultra.com/b2b/ru/ws/b2b.1cws
  FEndpoint := AEndpointWithoutWsdl;
  FHttp := THTTPClient.Create;
  FHttp.ConnectionTimeout := 15000;
  FHttp.ResponseTimeout := 30000;
end;

destructor TB2BClientUltra.Destroy;
begin
  FHttp.Free;
  inherited;
end;

class function TB2BClientUltra.IsGuidLike(const S: string): Boolean;
begin
  Result := (S.Contains('-')) and (Length(S) >= 32);
end;

function TB2BClientUltra.BasicAuthHeader: string;
var
  cred: string;
begin
  cred := FUser + ':' + FPass;
  Result := 'Basic ' + TNetEncoding.Base64.Encode(cred);
end;

class function TB2BClientUltra.MakeEnvelope(const BodyXml: string): string;
begin
  // SOAP 1.2 envelope (xmlns:soap = 2003/05)
  Result :=
    '<?xml version="1.0" encoding="UTF-8"?>' +
    '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ult="http://ultra.b2b.md">' +
    '<soap:Header/>' +
    '<soap:Body>' +
      BodyXml +
    '</soap:Body>' +
    '</soap:Envelope>';
end;

function TB2BClientUltra.PostSOAP(const ASoap: string): string;
var
  Resp: IHTTPResponse;
  SStream, RStream: TStringStream;
begin
  SStream := TStringStream.Create(ASoap, TEncoding.UTF8);
  RStream := TStringStream.Create('', TEncoding.UTF8);
  try
    // SOAP 1.2 content-type
    FHttp.CustomHeaders['Content-Type'] := 'application/soap+xml; charset=utf-8';
    FHttp.CustomHeaders['Authorization'] := BasicAuthHeader;

    Resp := FHttp.Post(FEndpoint, SStream, RStream);
    if (Resp = nil) or (Resp.StatusCode < 200) or (Resp.StatusCode >= 300) then
      raise EUltraClientError.CreateFmt('HTTP error %d: %s', [Resp.StatusCode, Resp.StatusText]);

    Result := RStream.DataString;
  finally
    SStream.Free;
    RStream.Free;
  end;
end;

class function TB2BClientUltra.NewXML(const AXml: string): IXMLDocument;
begin
  Result := TXMLDocument.Create(nil);
  Result.Options := [doNodeAutoIndent];
  Result.ParseOptions := [poResolveExternals];
  Result.Active := False;
  Result.LoadFromXML(AXml);
  Result.Active := True;
end;

function TB2BClientUltra.RequestData(const AService: string; AAll, ACompress: Boolean;
  const AAdditional: string): string;
var
  body, env, resp: string;
  xml: IXMLDocument;
  n: IXMLNode;
begin
  body :=
    '<ult:requestData>' +
      '<ult:Service>' + AService + '</ult:Service>' +
      '<ult:all>' + LowerCase(BoolToStr(AAll, True)) + '</ult:all>' +
      '<ult:additionalParameters>' + AAdditional + '</ult:additionalParameters>' +
      '<ult:compress>' + LowerCase(BoolToStr(ACompress, True)) + '</ult:compress>' +
    '</ult:requestData>';

  env := MakeEnvelope(body);
  resp := PostSOAP(env);

  xml := NewXML(resp);
  // răspunsul conține un <requestDataResponse> cu un <requestDataResult> (ID GUID)
  n := xml.DocumentElement; // Envelope
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: no Envelope');

  n := n.ChildNodes.FindNode('Body', 'http://www.w3.org/2003/05/soap-envelope');
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: no Body');

  n := n.ChildNodes[0]; // ult:requestDataResponse
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: requestDataResponse missing');

  n := n.ChildNodes.FindNode('requestDataResult', 'http://ultra.b2b.md');
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: requestDataResult missing');

  Result := n.Text;
end;

function TB2BClientUltra.IsReady(const AID: string): Boolean;
var
  body, env, resp: string;
  xml: IXMLDocument;
  n: IXMLNode;
begin
  body :=
    '<ult:isReady>' +
      '<ult:ID>' + AID + '</ult:ID>' +
    '</ult:isReady>';

  env := MakeEnvelope(body);
  resp := PostSOAP(env);

  xml := NewXML(resp);

  n := xml.DocumentElement.ChildNodes.FindNode('Body', 'http://www.w3.org/2003/05/soap-envelope');
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: no Body');

  n := n.ChildNodes[0]; // ult:isReadyResponse
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: isReadyResponse missing');

  n := n.ChildNodes.FindNode('isReadyResult', 'http://ultra.b2b.md');
  if not Assigned(n) then
    raise EUltraClientError.Create('Invalid SOAP response: isReadyResult missing');

  Result := SameText(n.Text, 'true') or SameText(n.Text, '1');
end;

function TB2BClientUltra.GetDataByID(const AID: string; out AMessage, AInnerXml: string): Boolean;
var
  body, env, resp: string;
  xml: IXMLDocument;
  n, resultNode, msgNode, dataNode: IXMLNode;
begin
  AMessage := '';
  AInnerXml := '';
  Result := False;

  body :=
    '<ult:getDataByID>' +
      '<ult:ID>' + AID + '</ult:ID>' +
    '</ult:getDataByID>';

  env := MakeEnvelope(body);
  resp := PostSOAP(env);

  xml := NewXML(resp);

  n := xml.DocumentElement.ChildNodes.FindNode('Body', 'http://www.w3.org/2003/05/soap-envelope');
  if not Assigned(n) then Exit;

  resultNode := n.ChildNodes[0]; // ult:getDataByIDResponse
  if not Assigned(resultNode) then Exit;

  resultNode := resultNode.ChildNodes.FindNode('getDataByIDResult', 'http://ultra.b2b.md');
  if not Assigned(resultNode) then Exit;

  msgNode := resultNode.ChildNodes.FindNode('message');
  dataNode := resultNode.ChildNodes.FindNode('data');

  if Assigned(msgNode) then
    AMessage := msgNode.Text;

  if Assigned(dataNode) then
  begin
    // <data> conține XML-ul domeniu (BALANCE, PRICELIST, etc.)
    AInnerXml := dataNode.Text;
  end;

  Result := True;
end;

class procedure TB2BClientUltra.ParseBalanceXml(const InnerXml: string; out Items: TArray<TUltraProductInfo>);
var
  x: IXMLDocument;
  root, node: IXMLNode;
  list: TList<TUltraProductInfo>;
  it: TUltraProductInfo;
  i: Integer;
begin
  list := TList<TUltraProductInfo>.Create;
  try
    x := NewXML(InnerXml);

    root := x.DocumentElement; // de obicei ceva de tip <ArrayOfBalance> / <balances> etc.
    if not Assigned(root) then
    begin
      Items := nil;
      Exit;
    end;

    // căutăm noduri <balance>
    for i := 0 to root.ChildNodes.Count - 1 do
    begin
      node := root.ChildNodes[i];
      if not SameText(node.NodeName, 'balance') then
        Continue;

      FillChar(it, SizeOf(it), 0);
      it.UUID := node.ChildValues['UUID'];
      it.Name := node.ChildValues['name'];
      it.Code := node.ChildValues['code'];
      it.CharacteristicUUID := node.ChildValues['Characteristic'];

      // quantity
      try it.Quantity := StrToFloat(StringReplace(VarToStr(node.ChildValues['quantity']), ',', FormatSettings.DecimalSeparator, [rfReplaceAll])); except it.Quantity := 0; end;
      try it.QuantityShowroom := StrToFloat(StringReplace(VarToStr(node.ChildValues['quantityShowroom']), ',', FormatSettings.DecimalSeparator, [rfReplaceAll])); except it.QuantityShowroom := 0; end;

      it.Available := (it.Quantity > 0) or (it.QuantityShowroom > 0);

      // Preț/Monedă NU sunt în BALANCE, vor fi umplute ulterior din PRICELIST
      it.Price := 0;
      it.Currency := '';

      list.Add(it);
    end;

    Items := list.ToArray;
  finally
    list.Free;
  end;
end;

class procedure TB2BClientUltra.ParsePriceXml(const InnerXml: string;
  Prices: TDictionary<string, TPair<Double, string>>);
var
  x: IXMLDocument;
  root, node, ptNode, valNode: IXMLNode;
  i: Integer;
  chUUID, cur: string;
  priceVal: Double;
  priceTxt: string;
begin
  x := NewXML(InnerXml);
  root := x.DocumentElement;
  if not Assigned(root) then Exit;

  for i := 0 to root.ChildNodes.Count - 1 do
  begin
    node := root.ChildNodes[i];
    if not SameText(node.NodeName, 'price') then
      Continue;

    chUUID := VarToStr(node.ChildValues['Characteristic']); // poate fi gol
    priceTxt := VarToStr(node.ChildValues['Price']);
    try
      priceVal := StrToFloat(StringReplace(priceTxt, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]));
    except
      priceVal := 0;
    end;

    cur := '';
    ptNode := node.ChildNodes.FindNode('PriceType');
    if Assigned(ptNode) then
    begin
      valNode := ptNode.ChildNodes.FindNode('valute');
      if Assigned(valNode) then
        cur := VarToStr(valNode.ChildValues['code']); // ex: MDL, USD
    end;

    // salvează pe cheie characteristicUUID ('' = fără caracteristică)
    Prices.AddOrSetValue(chUUID, TPair<Double, string>.Create(priceVal, cur));
  end;
end;

function TB2BClientUltra.GetBalanceOnlyByUUID(const NomenclatureUUID: string;
  out AItems: TArray<TUltraProductInfo>;
  APollTimeoutMS, APollIntervalMS: Integer): Boolean;
var
  id, msg, data: string;
  t0: Cardinal;
begin
  AItems := nil;
  if not IsGuidLike(NomenclatureUUID) then
    raise EUltraClientError.Create('Nomenclature UUID invalid');

  id := RequestData('BALANCE', False, False, NomenclatureUUID);

  // așteptăm până e gata
  t0 := TThread.GetTickCount;
  while not IsReady(id) do
  begin
    if (TThread.GetTickCount - t0) > Cardinal(APollTimeoutMS) then
      raise EUltraClientError.Create('Timeout așteptând BALANCE');
    Sleep(APollIntervalMS);
  end;

  if not GetDataByID(id, msg, data) then
    raise EUltraClientError.Create('getDataByID(BALANCE) a eșuat');

  if not SameText(msg, 'OK') then
    raise EUltraClientError.CreateFmt('BALANCE message: %s', [msg]);

  ParseBalanceXml(data, AItems);
  Result := Length(AItems) > 0;
end;

function TB2BClientUltra.GetProductStockByUUID(const NomenclatureUUID: string;
  out AItems: TArray<TUltraProductInfo>; APollTimeoutMS, APollIntervalMS: Integer): Boolean;
var
  balances: TArray<TUltraProductInfo>;
  pricesMap: TDictionary<string, TPair<Double, string>>;
  id, msg, data: string;
  t0: Cardinal;
  i: Integer;
  p: TPair<Double, string>;
  key: string;
begin
  Result := False;
  AItems := nil;

  // 1) BALANCE
  if not GetBalanceOnlyByUUID(NomenclatureUUID, balances, APollTimeoutMS, APollIntervalMS) then
  begin
    // poate nu are stoc pe nici o caracteristică – continuăm totuși pentru preț
    SetLength(balances, 0);
  end;

  // 2) PRICELIST (filtrat după NomenclatureUUID)
  pricesMap := TDictionary<string, TPair<Double, string>>.Create;
  try
    id := RequestData('PRICELIST', False, False, NomenclatureUUID);

    t0 := TThread.GetTickCount;
    while not IsReady(id) do
    begin
      if (TThread.GetTickCount - t0) > Cardinal(APollTimeoutMS) then
        raise EUltraClientError.Create('Timeout așteptând PRICELIST');
      Sleep(APollIntervalMS);
    end;

    if not GetDataByID(id, msg, data) then
      raise EUltraClientError.Create('getDataByID(PRICELIST) a eșuat');

    if not SameText(msg, 'OK') then
      raise EUltraClientError.CreateFmt('PRICELIST message: %s', [msg]);

    ParsePriceXml(data, pricesMap);

    // 3) Combină BALANCE + PRICELIST (match pe CharacteristicUUID; dacă nu găsești, încearcă cheia golă '')
    if Length(balances) = 0 then
    begin
      // uneori nu există BALANCE, dar există PRICELIST; creează cel puțin o înregistrare
      // din prețuri (fără stoc)
      for key in pricesMap.Keys do
      begin
        SetLength(balances, Length(balances) + 1);
        balances[High(balances)].UUID := NomenclatureUUID;
        balances[High(balances)].CharacteristicUUID := key;
      end;
    end;

    for i := 0 to High(balances) do
    begin
      key := balances[i].CharacteristicUUID;
      if (key <> '') and pricesMap.TryGetValue(key, p) then
      begin
        balances[i].Price := p.Key;
        balances[i].Currency := p.Value;
      end
      else if pricesMap.TryGetValue('', p) then
      begin
        balances[i].Price := p.Key;
        balances[i].Currency := p.Value;
      end;
    end;

    AItems := balances;
    Result := Length(AItems) > 0;
  finally
    pricesMap.Free;
  end;
end;

end.


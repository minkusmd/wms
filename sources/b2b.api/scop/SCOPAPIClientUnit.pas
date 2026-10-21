unit SCOPAPIClientUnit;

(*
  Client pentru API-ul de parteneri SCOP B2B (TRIOMAC SRL, furnizor 209280), versiunea 2:
    https://scop.md/api/partner/v2      documentatia: https://scop.md/ro/dashboard/integration

    POST /auth/token {key, secret}           -> access_token, expires_in (1800 s); ruta are
                                                limita ei, 10 cereri/min - tokenul se refoloseste
    GET  /catalog/products?limit=200         -> data[], meta.has_more / meta.next_cursor
         &cursor=  &in_stock=1  &fields=compact (fara descrieri si imagini)
    GET  /catalog/products/{code}            -> data; 404 {"message":"Product not found"}
    GET  /catalog/categories                 -> data[] {id, parent_id, name{ro,ru}} (tot arborele)

  Limita generala: 600 cereri/min pe cheie; la 429 se asteapta Retry-After si se repeta.
  Cloudflare refuza unele User-Agent (Python-urllib -> 403), de aceea trimitem unul propriu.

  Codurile: "code" e codul 1C al SCOP - singurul dupa care merg /products/{code} si lookup;
  "sku" e codul pe care WMS il tine in TS_GOODS_FOREIGN.GOODS_CODE pentru furnizorul 209280
  inca din API-ul vechi (api.scop.md, 2 oct 2026: 539 din 1223 produse cu stoc se leaga dupa
  sku, 0 dupa code). Dupa sku API-ul nu cauta, deci FindBySku parcurge catalogul compact
  (~2000 produse, 11 pagini, 2-4 s). sku nu e unic: '128026' = 4 produse, cite unul pe culoare.

  Stocul: peste un prag (azi 10) vine pragul si stock_exact = false - "10 si mai mult".
  La produsele cu culori (variations[] nevid) stocul produsului e al UNEI culori, nu suma;
  stocul real e suma variations[].stock (TScopProduct.TotalStock).

  Credentialele: TS_API_CONFIG, API_CODE = 'SCOP', parametrii API_KEY si API_SECRET (+ optional
  BASE_URL) - meniul Setari > Configurari API, scriptul "DB Model\scop_api_v2_config.sql".
*)

interface

uses
  System.SysUtils, System.Classes, System.JSON, System.Generics.Collections,
  System.Net.HttpClient, System.Net.URLClient, IBC;

const
  cScopSupplierID = 209280;
  cScopApiCode = 'SCOP';
  cScopDefaultBaseURL = 'https://scop.md/api/partner/v2';

type
  TScopVariation = record
    Code: string;
    Colour: string;
    Barcode: string;
    Stock: Integer;
    StockExact: Boolean;
    Price: Double;
    Currency: string;
  end;

  TScopProduct = record
    Code: string;
    Sku: string;
    Articul: string;
    Barcode: string;
    NameRo: string;
    NameRu: string;
    Brand: string;
    UnitName: string;
    CategoryID: Integer;
    Stock: Integer;
    StockExact: Boolean;
    CallForPricing: Boolean;
    // pretul contractului, in valuta listei de preturi (azi USD)
    Price: Double;
    Currency: string;
    PriceAvailable: Boolean;
    // price.converted_value - conversia informativa in lei (0 cind lipseste)
    PriceMDL: Double;
    // pretul recomandat de vinzare, mereu in lei; 0 = pozitia nu are rrp
    Rrp: Double;
    RrpCurrency: string;
    DescriptionRo: string;
    DescriptionRu: string;
    // HTML; la multe produse doar un link spre site-ul producatorului
    SpecificationRo: string;
    SpecificationRu: string;
    Images: TArray<string>;
    Variations: TArray<TScopVariation>;
    UpdatedAt: string;
    // stocul real: suma culorilor la produsele cu variatii
    function TotalStock: Integer;
    // False daca cel putin o cifra e pragul ("atit si mai mult")
    function TotalStockExact: Boolean;
    // "7" sau "10+"
    function StockText: string;
  end;

  TSCOPAPIClient = class
  private
    FHttp: THTTPClient;
    FBaseURL: string;
    FKey: string;
    FSecret: string;
    FToken: string;
    FTokenExpiry: TDateTime;
    function Token: string;
    // cererea bruta (cu reincercare la 401 / 429); intoarce JSON-ul raspunsului sau nil
    function Send(const APath: string; ABody: TJSONObject; AAuth: Boolean;
      out AStatus: Integer): TJSONValue;
    // GET cu raspuns 200 obligatoriu
    function GetObject(const APath, AWhat: string): TJSONObject;
  public
    constructor Create(const AKey, ASecret: string; const ABaseURL: string = '');
    destructor Destroy; override;

    // citeste API_KEY / API_SECRET / BASE_URL din TS_API_CONFIG (API_CODE = 'SCOP');
    // arunca Exception cu indicatii daca lipsesc
    class function CreateFromConfig(AConnection: TIBCConnection): TSCOPAPIClient;

    class function ParseProduct(AObj: TJSONObject): TScopProduct;

    // tot catalogul, pagina cu pagina (cursorul nu sare si nu repeta pozitii);
    // AOnPage se apeleaza dupa fiecare pagina (Application.ProcessMessages, progres)
    procedure GetProducts(AProducts: TList<TScopProduct>; AInStockOnly, ACompact: Boolean;
      const AOnPage: TProc = nil);
    // un produs dupa code (codul 1C SCOP); False daca nu exista
    function GetProduct(const ACode: string; out AProduct: TScopProduct): Boolean;
    // produsele cu acest sku (de regula unul); daca nu e niciunul - dupa articul,
    // apoi ca code SCOP. Lista goala = nu exista in catalog
    function FindBySku(const ASku: string): TArray<TScopProduct>;
    // calea categoriei ("Parinte / Copil / Frunza", nume RO) pe category_id
    function GetCategoryPaths: TDictionary<Integer, string>;

    property BaseURL: string read FBaseURL;
  end;

implementation

uses
  System.Math, System.DateUtils, System.NetEncoding, System.StrUtils, IBCClasses;

const
  cUserAgent = 'WMS-NeuronGrup/5.5 (Delphi)';
  cPageLimit = 200;
  // plasa de siguranta pentru cursor (azi 11 pagini)
  cMaxPages = 500;
  cMaxAttempts = 4;

{ ---------------------------------------------------------------------------- }
{ JSON                                                                           }
{ ---------------------------------------------------------------------------- }

function JValue(AObj: TJSONObject; const AName: string): TJSONValue;
begin
  Result := nil;
  if Assigned(AObj) then
  begin
    Result := AObj.GetValue(AName);
    if Result is TJSONNull then
      Result := nil;
  end;
end;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if (V = nil) or (V is TJSONObject) or (V is TJSONArray) then
    Result := ''
  else
    Result := Trim(V.Value);
end;

function JFloat(AObj: TJSONObject; const AName: string): Double;
var
  V: TJSONValue;
begin
  Result := 0;
  V := JValue(AObj, AName);
  if V is TJSONNumber then
    Result := TJSONNumber(V).AsDouble
  else if V is TJSONString then
    Result := StrToFloatDef(StringReplace(Trim(V.Value), ',', '.', [rfReplaceAll]), 0,
      TFormatSettings.Invariant);
end;

function JBool(AObj: TJSONObject; const AName: string; ADefault: Boolean): Boolean;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONBool then
    Result := TJSONBool(V).AsBoolean
  else
    Result := ADefault;
end;

function JObj(AObj: TJSONObject; const AName: string): TJSONObject;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONObject then
    Result := TJSONObject(V)
  else
    Result := nil;
end;

// campurile traduse vin ca {"en":..,"ro":..,"ru":..}; specification fara text vine ca []
function JLang(AObj: TJSONObject; const AName, ALang: string): string;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONObject then
    Result := JStr(TJSONObject(V), ALang)
  else if (V = nil) or (V is TJSONArray) then
    Result := ''
  else
    Result := Trim(V.Value);
end;

// textul erorii: {"message": "...", "code": "..."}
function ApiErrorText(const AWhat: string; AStatus: Integer; ARoot: TJSONValue): string;
var
  Msg, Code: string;
begin
  Msg := '';
  Code := '';
  if ARoot is TJSONObject then
  begin
    Msg := JStr(TJSONObject(ARoot), 'message');
    Code := JStr(TJSONObject(ARoot), 'code');
  end;
  Result := Format('API SCOP: %s - HTTP %d', [AWhat, AStatus]);
  if Msg <> '' then
    Result := Result + ': ' + Msg;
  if Code <> '' then
    Result := Result + ' (' + Code + ')';
end;

{ ---------------------------------------------------------------------------- }
{ TScopProduct                                                                   }
{ ---------------------------------------------------------------------------- }

function TScopProduct.TotalStock: Integer;
var
  V: TScopVariation;
begin
  if Length(Variations) = 0 then
    Exit(Stock);
  Result := 0;
  for V in Variations do
    if V.Stock > 0 then
      Inc(Result, V.Stock);
end;

function TScopProduct.TotalStockExact: Boolean;
var
  V: TScopVariation;
begin
  if Length(Variations) = 0 then
    Exit(StockExact);
  Result := True;
  for V in Variations do
    if (V.Stock > 0) and not V.StockExact then
      Exit(False);
end;

function TScopProduct.StockText: string;
begin
  Result := IntToStr(TotalStock);
  if (TotalStock > 0) and not TotalStockExact then
    Result := Result + '+';
end;

{ ---------------------------------------------------------------------------- }
{ TSCOPAPIClient                                                                 }
{ ---------------------------------------------------------------------------- }

constructor TSCOPAPIClient.Create(const AKey, ASecret: string; const ABaseURL: string);
begin
  inherited Create;
  FKey := Trim(AKey);
  FSecret := Trim(ASecret);
  FBaseURL := Trim(ABaseURL);
  // BASE_URL vechi (https://api.scop.md) ramas in configurare nu mai raspunde la v2
  if (FBaseURL = '') or not ContainsText(FBaseURL, '/partner/') then
    FBaseURL := cScopDefaultBaseURL;
  while FBaseURL.EndsWith('/') do
    SetLength(FBaseURL, Length(FBaseURL) - 1);

  FHttp := THTTPClient.Create;
  FHttp.ConnectionTimeout := 30000;
  FHttp.ResponseTimeout := 120000;
  FHttp.UserAgent := cUserAgent;
end;

destructor TSCOPAPIClient.Destroy;
begin
  FHttp.Free;
  inherited;
end;

class function TSCOPAPIClient.CreateFromConfig(AConnection: TIBCConnection): TSCOPAPIClient;
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
  Name, Key, Secret, BaseURL: string;
begin
  Key := '';
  Secret := '';
  BaseURL := '';

  Tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConnection;
    // nu prin Params: IBDAC pune deja isc_tpb_write in TPB, iar 'read' dupa el da eroare
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Tr.StartTransaction;

    q.Connection := AConnection;
    q.Transaction := Tr;
    q.SQL.Text := 'select PARAM_NAME, PARAM_VALUE from TS_API_CONFIG ' +
      'where API_CODE = :API_CODE and FLG_ACTIVE = 1';
    q.ParamByName('API_CODE').AsString := cScopApiCode;
    q.Open;
    while not q.Eof do
    begin
      Name := Trim(q.FieldByName('PARAM_NAME').AsString);
      if SameText(Name, 'API_KEY') then
        Key := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'API_SECRET') then
        Secret := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'BASE_URL') then
        BaseURL := Trim(q.FieldByName('PARAM_VALUE').AsString);
      q.Next;
    end;
    q.Close;
    Tr.Commit;
  finally
    q.Free;
    Tr.Free;
  end;

  if (Key = '') or (Secret = '') then
    raise Exception.Create('Lipsesc datele de acces la API-ul SCOP (Triomac).' + sLineBreak +
      'Adaugati in Setari > Configurari API, API_CODE = ' + cScopApiCode + ' (furnizor ' +
      IntToStr(cScopSupplierID) + '), parametrii API_KEY (cheia scop_...) si API_SECRET - ' +
      'din scop.md, Cabinet > Integrare.');

  Result := TSCOPAPIClient.Create(Key, Secret, BaseURL);
end;

function TSCOPAPIClient.Send(const APath: string; ABody: TJSONObject; AAuth: Boolean;
  out AStatus: Integer): TJSONValue;
var
  Attempt, Wait: Integer;
  Source: TStringStream;
  Headers: TNetHeaders;
  Response: IHTTPResponse;
  Text: string;
begin
  Text := '';
  AStatus := 0;
  for Attempt := 1 to cMaxAttempts do
  begin
    Headers := [TNetHeader.Create('Accept', 'application/json')];
    if AAuth then
      Headers := Headers + [TNetHeader.Create('Authorization', 'Bearer ' + Token)];

    if Assigned(ABody) then
    begin
      Source := TStringStream.Create(ABody.ToJSON, TEncoding.UTF8);
      try
        Response := FHttp.Post(FBaseURL + APath, Source, nil,
          Headers + [TNetHeader.Create('Content-Type', 'application/json; charset=UTF-8')]);
      finally
        Source.Free;
      end;
    end
    else
      Response := FHttp.Get(FBaseURL + APath, nil, Headers);

    AStatus := Response.StatusCode;
    Text := Response.ContentAsString(TEncoding.UTF8);

    // tokenul expirat sau revocat - cerem altul o singura data
    if (AStatus = 401) and AAuth and (Attempt = 1) then
    begin
      FToken := '';
      Continue;
    end;
    // limita de cereri: Retry-After spune cite secunde
    if (AStatus = 429) and (Attempt < cMaxAttempts) then
    begin
      Wait := StrToIntDef(Trim(Response.HeaderValue['Retry-After']), 5);
      Sleep(EnsureRange(Wait, 1, 65) * 1000);
      Continue;
    end;
    Break;
  end;

  Result := TJSONObject.ParseJSONValue(Text);
end;

function TSCOPAPIClient.Token: string;
var
  Body: TJSONObject;
  Root: TJSONValue;
  Status, ExpiresIn: Integer;
begin
  if (FToken <> '') and (Now < FTokenExpiry) then
    Exit(FToken);

  FToken := '';
  Body := TJSONObject.Create;
  try
    Body.AddPair('key', FKey);
    Body.AddPair('secret', FSecret);
    Root := Send('/auth/token', Body, False, Status);
  finally
    Body.Free;
  end;
  try
    if (Status <> 200) or not (Root is TJSONObject) then
      raise Exception.Create(ApiErrorText('autentificarea', Status, Root) + sLineBreak +
        'Verificati API_KEY / API_SECRET in Setari > Configurari API (API_CODE = ' + cScopApiCode + ').');
    FToken := JStr(TJSONObject(Root), 'access_token');
    ExpiresIn := Trunc(JFloat(TJSONObject(Root), 'expires_in'));
  finally
    Root.Free;
  end;
  if FToken = '' then
    raise Exception.Create('API SCOP: autentificarea nu a intors access_token.');
  if ExpiresIn <= 0 then
    ExpiresIn := 1800;
  // cu un minut inainte de expirare cerem altul
  FTokenExpiry := IncSecond(Now, Max(ExpiresIn - 60, 30));
  Result := FToken;
end;

function TSCOPAPIClient.GetObject(const APath, AWhat: string): TJSONObject;
var
  Root: TJSONValue;
  Status: Integer;
begin
  Root := Send(APath, nil, True, Status);
  if (Status <> 200) or not (Root is TJSONObject) then
  begin
    try
      raise Exception.Create(ApiErrorText(AWhat, Status, Root));
    finally
      Root.Free;
    end;
  end;
  Result := TJSONObject(Root);
end;

class function TSCOPAPIClient.ParseProduct(AObj: TJSONObject): TScopProduct;
var
  Price, Rrp, VObj: TJSONObject;
  Arr: TJSONValue;
  Item: TJSONValue;
  Url: string;
  Urls: TList<string>;
  Vars: TList<TScopVariation>;
  V: TScopVariation;
begin
  Result := Default(TScopProduct);
  Result.Code := JStr(AObj, 'code');
  Result.Sku := JStr(AObj, 'sku');
  Result.Articul := JStr(AObj, 'articul');
  Result.Barcode := JStr(AObj, 'barcode');
  Result.NameRo := JLang(AObj, 'name', 'ro');
  Result.NameRu := JLang(AObj, 'name', 'ru');
  Result.Brand := JStr(AObj, 'brand');
  Result.UnitName := JStr(AObj, 'unit');
  Result.CategoryID := Trunc(JFloat(AObj, 'category_id'));
  Result.Stock := Trunc(JFloat(AObj, 'stock'));
  Result.StockExact := JBool(AObj, 'stock_exact', True);
  Result.CallForPricing := JBool(AObj, 'is_call_for_pricing', False);
  Result.UpdatedAt := JStr(AObj, 'updated_at');

  Price := JObj(AObj, 'price');
  Result.Price := JFloat(Price, 'value');
  Result.Currency := UpperCase(JStr(Price, 'currency'));
  Result.PriceAvailable := JBool(Price, 'available', Assigned(Price));
  Result.PriceMDL := JFloat(Price, 'converted_value');

  Rrp := JObj(AObj, 'rrp');
  Result.Rrp := JFloat(Rrp, 'value');
  Result.RrpCurrency := UpperCase(JStr(Rrp, 'currency'));

  Result.DescriptionRo := JLang(AObj, 'description', 'ro');
  Result.DescriptionRu := JLang(AObj, 'description', 'ru');
  Result.SpecificationRo := JLang(AObj, 'specification', 'ro');
  Result.SpecificationRu := JLang(AObj, 'specification', 'ru');

  // images: [{url, bytes}]; fields=compact nu le trimite deloc
  Urls := TList<string>.Create;
  try
    Arr := JValue(AObj, 'images');
    if Arr is TJSONArray then
      for Item in TJSONArray(Arr) do
      begin
        if Item is TJSONObject then
          Url := JStr(TJSONObject(Item), 'url')
        else if Item is TJSONString then
          Url := Trim(Item.Value)
        else
          Url := '';
        if (Url <> '') and not Urls.Contains(Url) then
          Urls.Add(Url);
      end;
    Result.Images := Urls.ToArray;
  finally
    Urls.Free;
  end;

  Vars := TList<TScopVariation>.Create;
  try
    Arr := JValue(AObj, 'variations');
    if Arr is TJSONArray then
      for Item in TJSONArray(Arr) do
        if Item is TJSONObject then
        begin
          VObj := TJSONObject(Item);
          V := Default(TScopVariation);
          V.Code := JStr(VObj, 'code');
          V.Colour := JStr(VObj, 'colour');
          V.Barcode := JStr(VObj, 'barcode');
          V.Stock := Trunc(JFloat(VObj, 'stock'));
          V.StockExact := JBool(VObj, 'stock_exact', True);
          V.Price := JFloat(JObj(VObj, 'price'), 'value');
          V.Currency := UpperCase(JStr(JObj(VObj, 'price'), 'currency'));
          Vars.Add(V);
        end;
    Result.Variations := Vars.ToArray;
  finally
    Vars.Free;
  end;
end;

procedure TSCOPAPIClient.GetProducts(AProducts: TList<TScopProduct>; AInStockOnly, ACompact: Boolean;
  const AOnPage: TProc);
var
  Cursor, Path: string;
  Root, Meta: TJSONObject;
  Data, Item: TJSONValue;
  HasMore: Boolean;
  Pages: Integer;
begin
  Cursor := '';
  Pages := 0;
  repeat
    Path := '/catalog/products?limit=' + IntToStr(cPageLimit);
    if AInStockOnly then
      Path := Path + '&in_stock=1';
    if ACompact then
      Path := Path + '&fields=compact';
    if Cursor <> '' then
      Path := Path + '&cursor=' + TNetEncoding.URL.Encode(Cursor);

    Root := GetObject(Path, Format('catalogul, pagina %d', [Pages + 1]));
    try
      Data := JValue(Root, 'data');
      if not (Data is TJSONArray) then
        raise Exception.CreateFmt('API SCOP: pagina %d a catalogului nu contine "data".', [Pages + 1]);
      for Item in TJSONArray(Data) do
        if Item is TJSONObject then
          AProducts.Add(ParseProduct(TJSONObject(Item)));
      Meta := JObj(Root, 'meta');
      HasMore := JBool(Meta, 'has_more', False);
      Cursor := JStr(Meta, 'next_cursor');
    finally
      Root.Free;
    end;

    Inc(Pages);
    if Assigned(AOnPage) then
      AOnPage();
  until (not HasMore) or (Cursor = '') or (Pages >= cMaxPages);
end;

function TSCOPAPIClient.GetProduct(const ACode: string; out AProduct: TScopProduct): Boolean;
var
  Root: TJSONValue;
  Status: Integer;
  Data: TJSONObject;
begin
  AProduct := Default(TScopProduct);
  // un segment de cale: EncodePath ar pune un '/' in fata (-> //code, 404), Encode pune '+' la spatiu
  Root := Send('/catalog/products/' + StringReplace(TNetEncoding.URL.Encode(Trim(ACode)), '+', '%20',
    [rfReplaceAll]), nil, True, Status);
  try
    if Status = 404 then
      Exit(False);
    if (Status <> 200) or not (Root is TJSONObject) then
      raise Exception.Create(ApiErrorText('produsul ' + ACode, Status, Root));
    Data := JObj(TJSONObject(Root), 'data');
    Result := Assigned(Data);
    if Result then
      AProduct := ParseProduct(Data);
  finally
    Root.Free;
  end;
end;

function TSCOPAPIClient.FindBySku(const ASku: string): TArray<TScopProduct>;
var
  All, Found: TList<TScopProduct>;
  P: TScopProduct;
  Sku: string;
begin
  Sku := Trim(ASku);
  Result := nil;
  if Sku = '' then
    Exit;

  All := TList<TScopProduct>.Create;
  Found := TList<TScopProduct>.Create;
  try
    GetProducts(All, False, True);
    for P in All do
      if SameText(P.Sku, Sku) then
        Found.Add(P);
    // coduri vechi legate dupa articul (sku si articul difera la ~10% din produse)
    if Found.Count = 0 then
      for P in All do
        if SameText(P.Articul, Sku) then
          Found.Add(P);
    // poate e chiar codul 1C (inclusiv codul unei culori - deschide fisa produsului)
    if (Found.Count = 0) and GetProduct(Sku, P) then
      Found.Add(P);
    Result := Found.ToArray;
  finally
    Found.Free;
    All.Free;
  end;
end;

function TSCOPAPIClient.GetCategoryPaths: TDictionary<Integer, string>;
type
  TCat = record
    ParentID: Integer;
    Name: string;
  end;
var
  Root, CObj: TJSONObject;
  Data, Item: TJSONValue;
  Cats: TDictionary<Integer, TCat>;
  C: TCat;
  ID, Cur, Depth: Integer;
  Path: string;
begin
  Result := TDictionary<Integer, string>.Create;
  Cats := TDictionary<Integer, TCat>.Create;
  try
    Root := GetObject('/catalog/categories', 'categoriile');
    try
      Data := JValue(Root, 'data');
      if Data is TJSONArray then
        for Item in TJSONArray(Data) do
          if Item is TJSONObject then
          begin
            CObj := TJSONObject(Item);
            C.ParentID := Trunc(JFloat(CObj, 'parent_id'));
            C.Name := JLang(CObj, 'name', 'ro');
            Cats.AddOrSetValue(Trunc(JFloat(CObj, 'id')), C);
          end;
    finally
      Root.Free;
    end;

    for ID in Cats.Keys do
    begin
      Path := '';
      Cur := ID;
      Depth := 0;
      // arborele are 5 niveluri; Depth opreste o eventuala bucla
      while (Cur > 0) and (Depth < 10) and Cats.TryGetValue(Cur, C) do
      begin
        if C.Name <> '' then
          if Path = '' then
            Path := C.Name
          else
            Path := C.Name + ' / ' + Path;
        Cur := C.ParentID;
        Inc(Depth);
      end;
      Result.Add(ID, Path);
    end;
  finally
    Cats.Free;
  end;
end;

end.

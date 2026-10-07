unit NexDistributionUnit;

{
  Pricelist de la NEXPRIM SERVICE (CustomerID 275640) prin API-ul NexDistribution:
    GET https://api.nexdistribution.md/api/products?limit=<n>&page=<p>   (header api-token)

  Cheia API (header api-token) se cere de la API, cu contul b2b.nexdistribution.md, prin GraphQL
  (https://api.nexdistribution.md/graphql - acelasi flux ca pagina de profil din b2b):
    login(email, password) -> token de sesiune (Bearer) -> user.api_token / user.api_access;
    generateApiToken doar daca contul nu are inca o cheie.
  Datele din TS_API_CONFIG, API_CODE = 'NEXDISTRIBUTION' (meniul Setari > Configurari API):
    USERNAME (email), PASSWORD; optional API_TOKEN (folosit direct cand lipsesc USERNAME/PASSWORD)
    si BASE_URL.

  1. se descarca toate paginile (pagination.last_page) in 8 fire; produsele cu status = false se sar;
  2. intr-o singura tranzactie (totul sau nimic):
       TS_PRICELISTS                  - pricelist nou (FLAGS = 2 = FLG_API);
       TS_PRICELIST_ITEMS             - code -> SUPPLIER_GOODS_CODE (acelasi cod ca in
                                        TS_GOODS_FOREIGN: NF-... cu litere chirilice, NX-...),
                                        title.ro -> denumirea, article -> SUPPLIER_GOODS_MODEL,
                                        b2b_url -> PRODUCT_LINK, quantity -> STOCK_QTY,
                                        category.title.ro -> SUPPLIER_CATEGORY;
                                        preturile in MDL, ca in pricelisturile Nex introduse manual:
                                        PRICE0 = PRICE7 = price_mdl (cost), PRICE3 = rrp;
       TS_PRICELIST_ITEMS_DESCRIPTION - description.ro / .ru + tabelul din attributes (denumirea
                                        caracteristicii pe limba, valoarea vine doar in ro);
  3. imaginile (main_image + additional_images) se descarca in fire si se salveaza in PNG in
     TS_PRICELIST_ITEMS_IMAGES prin TMamicoContentLoader.RunForPriceItemsEx (aceeasi fereastra
     de progres ca la mamico.md / imperia.md).

  Neverificat live (tokenul din documentatie e doar un exemplu): moneda lui rrp. In exemplul din
  documentatie rrp (150) e apropiat de price_euro (130), nu de price_mdl (2544). Un rrp sub
  jumatate din price_mdl e considerat in EUR si convertit cu cursul furnizorului
  (price_mdl / price_euro) - TS_CURRENCY nu are EUR.
}

interface

uses
  System.SysUtils, System.Classes, IBC;

const
  cNexSupplierID = 275640;
  cNexApiCode = 'NEXDISTRIBUTION';

type
  TNexPriceListImport = class
  public
    // descarca catalogul, creeaza pricelistul (fara intrebari) si porneste descarcarea
    // imaginilor; intoarce PLID-ul creat. Arunca Exception la token lipsa/invalid sau raspuns
    // invalid - in acest caz nu se creeaza nimic.
    class function Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;

    // acelasi import fara interfata (WMSParsers, orice fir): rezumatul merge in AOnLog;
    // AWithImages = descarca imaginile articolelor fara continut, in AImageThreads fire.
    // Intoarce PLID-ul creat; la eroare arunca Exception si nu creeaza nimic.
    class function Import(AConnection: TIBCConnection; APriceCategoryID: Integer; AWithImages: Boolean;
      const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>; AImageThreads: Integer = 12): Integer;
  end;

implementation

uses
  System.JSON, System.Generics.Collections, System.Net.HttpClient, System.Net.URLClient,
  System.NetConsts, System.NetEncoding, System.Math, System.SyncObjs, System.UITypes, Data.DB, Vcl.Forms, Vcl.Controls,
  Vcl.Dialogs, IBCClasses, MamicoContentUnit;

const
  cDefaultBaseUrl = 'https://api.nexdistribution.md';
  cB2BBaseUrl = 'https://b2b.nexdistribution.md';
  cPageLimit = 100;
  cMaxPages = 1000;
  // fire pentru descarcarea paginilor catalogului (imaginile: cMamicoThreadCount, tot 8)
  cNexThreadCount = 8;
  cCurrencyMDL = 498;
  cFLG_API = 2;

type
  TNexAttribute = record
    TitleRo: string;
    TitleRu: string;
    Value: string;
  end;

  TNexProduct = record
    Code: string;
    Name: string;
    Article: string;
    B2BUrl: string;
    DescRo: string;
    DescRu: string;
    Category: string;
    Quantity: Integer;
    PriceMdl: Double;
    PriceEuro: Double;
    Rrp: Double;
    Attributes: TArray<TNexAttribute>;
    Images: TArray<string>;
  end;

  TNexImportStats = record
    Inactive: Integer;
    Duplicates: Integer;
    Descriptions: Integer;
    RrpConverted: Integer;
    WithImages: Integer;
  end;

  // rezultatul unei pagini a catalogului (produs de un fir de lucru)
  TNexPageResult = record
    Products: TArray<TNexProduct>;
    Inactive: Integer;
    Error: string;
  end;

  // filtrul dataset-ului dat lui RunForPriceItemsEx: doar articolele care au imagini in API
  TNexImageFilter = class
  public
    procedure FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  end;

var
  // code -> URL-urile imaginilor; completat inainte de pornirea firelor si doar citit din ele
  GNexImages: TDictionary<string, TArray<string>>;

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

// camp pe limbi {"ro": ..., "ru": ...}; un sir simplu e acceptat pentru orice limba
function JLang(AObj: TJSONObject; const AName, ALang: string): string;
var
  V: TJSONValue;
begin
  V := JValue(AObj, AName);
  if V is TJSONObject then
    Result := JStr(TJSONObject(V), ALang)
  else if (V <> nil) and not (V is TJSONArray) then
    Result := Trim(V.Value)
  else
    Result := '';
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
  else if V is TJSONNumber then
    Result := TJSONNumber(V).AsInt <> 0
  else if V is TJSONString then
    Result := SameText(V.Value, 'true') or (V.Value = '1')
  else
    Result := ADefault;
end;

function NormalizeImageUrl(const AUrl: string): string;
begin
  Result := Trim(AUrl);
  if Result.StartsWith('//') then
    Result := 'https:' + Result
  else if Result.StartsWith('/') then
    Result := cB2BBaseUrl + Result;
  Result := StringReplace(Result, ' ', '%20', [rfReplaceAll]);
end;

function ParseProduct(AObj: TJSONObject): TNexProduct;
var
  V, Item: TJSONValue;
  Obj: TJSONObject;
  Attr: TNexAttribute;
  Images: TStringList;
  Url: string;
begin
  Result := Default(TNexProduct);
  Result.Code := JStr(AObj, 'code');
  Result.Name := JLang(AObj, 'title', 'ro');
  if Result.Name = '' then
    Result.Name := JLang(AObj, 'title', 'ru');
  Result.Article := JStr(AObj, 'article');
  Result.B2BUrl := JStr(AObj, 'b2b_url');
  Result.DescRo := JLang(AObj, 'description', 'ro');
  Result.DescRu := JLang(AObj, 'description', 'ru');
  Result.Quantity := Max(0, Trunc(JFloat(AObj, 'quantity')));

  V := JValue(AObj, 'prices');
  if V is TJSONObject then
  begin
    Obj := TJSONObject(V);
    Result.PriceMdl := JFloat(Obj, 'price_mdl');
    Result.PriceEuro := JFloat(Obj, 'price_euro');
    Result.Rrp := JFloat(Obj, 'rrp');
  end;

  V := JValue(AObj, 'category');
  if V is TJSONObject then
    Result.Category := JLang(TJSONObject(V), 'title', 'ro');

  V := JValue(AObj, 'attributes');
  if V is TJSONArray then
    for Item in TJSONArray(V) do
      if Item is TJSONObject then
      begin
        Attr.TitleRo := JLang(TJSONObject(Item), 'title', 'ro');
        Attr.TitleRu := JLang(TJSONObject(Item), 'title', 'ru');
        if Attr.TitleRu = '' then
          Attr.TitleRu := Attr.TitleRo;
        Attr.Value := JStr(TJSONObject(Item), 'value');
        if (Attr.TitleRo <> '') and (Attr.Value <> '') then
          Result.Attributes := Result.Attributes + [Attr];
      end;

  // imaginea principala prima (ORDERNO 1), apoi cele suplimentare, fara dubluri
  Images := TStringList.Create;
  try
    Url := NormalizeImageUrl(JStr(AObj, 'main_image'));
    if Url <> '' then
      Images.Add(Url);
    V := JValue(AObj, 'additional_images');
    if V is TJSONArray then
      for Item in TJSONArray(V) do
        if (Item is TJSONString) then
        begin
          Url := NormalizeImageUrl(Item.Value);
          if (Url <> '') and (Images.IndexOf(Url) < 0) then
            Images.Add(Url);
        end;
    Result.Images := Images.ToStringArray;
  finally
    Images.Free;
  end;
end;

// descrierea in HTML (ca la ceilalti furnizori): textul din API + tabelul de caracteristici
function BuildDescription(const ADesc: string; const AAttributes: TArray<TNexAttribute>;
  ARussian: Boolean): string;
var
  Attr: TNexAttribute;
  Table, Title: string;
begin
  Result := Trim(ADesc);
  if Length(AAttributes) = 0 then
    Exit;
  Table := '<table>';
  for Attr in AAttributes do
  begin
    if ARussian then
      Title := Attr.TitleRu
    else
      Title := Attr.TitleRo;
    Table := Table + '<tr><td>' + TNetEncoding.HTML.Encode(Title) + '</td><td>' +
      TNetEncoding.HTML.Encode(Attr.Value) + '</td></tr>';
  end;
  Table := Table + '</table>';
  if Result <> '' then
    Result := Result + sLineBreak;
  Result := Result + Table;
end;

// PRICE3 in MDL - vezi comentariul de la inceputul unit-ului
function RrpInMdl(const AProduct: TNexProduct; out AConverted: Boolean): Double;
begin
  Result := AProduct.Rrp;
  AConverted := (AProduct.Rrp > 0) and (AProduct.PriceMdl > 0) and (AProduct.PriceEuro > 0) and
    (AProduct.Rrp < AProduct.PriceMdl * 0.5);
  if AConverted then
    Result := RoundTo(AProduct.Rrp * AProduct.PriceMdl / AProduct.PriceEuro, -2);
end;

{ ---------------------------------------------------------------------------- }
{ API                                                                            }
{ ---------------------------------------------------------------------------- }

// USERNAME / PASSWORD (contul b2b.nexdistribution.md), optional API_TOKEN si BASE_URL
procedure ReadApiConfig(AConnection: TIBCConnection; out AUser, APassword, AToken, ABaseUrl: string);
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
  Name: string;
begin
  AUser := '';
  APassword := '';
  AToken := '';
  ABaseUrl := '';

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
    q.ParamByName('API_CODE').AsString := cNexApiCode;
    q.Open;
    while not q.Eof do
    begin
      Name := Trim(q.FieldByName('PARAM_NAME').AsString);
      if SameText(Name, 'USERNAME') then
        AUser := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'PASSWORD') then
        APassword := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'API_TOKEN') then
        AToken := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'BASE_URL') then
        ABaseUrl := Trim(q.FieldByName('PARAM_VALUE').AsString);
      q.Next;
    end;
    q.Close;
    Tr.Commit;
  finally
    q.Free;
    Tr.Free;
  end;

  if ABaseUrl = '' then
    ABaseUrl := cDefaultBaseUrl;
  while ABaseUrl.EndsWith('/') do
    ABaseUrl := Copy(ABaseUrl, 1, Length(ABaseUrl) - 1);
end;

// cererea GraphQL (acelasi server, /graphql); erorile vin cu HTTP 200 in "errors",
// detaliile de validare in errors[].extensions.validation
function GraphQL(AHttp: THTTPClient; const ABaseUrl, AQuery: string; AVariables: TJSONObject;
  const ABearer: string): TJSONObject;
var
  Body: TJSONObject;
  Source: TStringStream;
  Headers: TNetHeaders;
  Response: IHTTPResponse;
  V, Err, Item, Line: TJSONValue;
  Msg: string;
  Pair: TJSONPair;
begin
  Body := TJSONObject.Create;
  try
    Body.AddPair('query', AQuery);
    if Assigned(AVariables) then
      Body.AddPair('variables', AVariables);   // Body devine proprietar
    Source := TStringStream.Create(Body.ToJSON, TEncoding.UTF8);
  finally
    Body.Free;
  end;

  try
    Headers := [TNetHeader.Create('Content-Type', 'application/json')];
    if ABearer <> '' then
      Headers := Headers + [TNetHeader.Create('Authorization', 'Bearer ' + ABearer)];
    Response := AHttp.Post(ABaseUrl + '/graphql', Source, nil, Headers);
  finally
    Source.Free;
  end;

  V := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8));
  if not (V is TJSONObject) then
  begin
    V.Free;
    raise Exception.CreateFmt('API NexDistribution (GraphQL): raspuns invalid, HTTP %d.', [Response.StatusCode]);
  end;
  Result := TJSONObject(V);

  Err := JValue(Result, 'errors');
  if (Err is TJSONArray) and (TJSONArray(Err).Count > 0) then
  begin
    Msg := '';
    for Item in TJSONArray(Err) do
      if Item is TJSONObject then
      begin
        Msg := Msg + JStr(TJSONObject(Item), 'message');
        V := JValue(TJSONObject(Item), 'extensions');
        if V is TJSONObject then
          V := JValue(TJSONObject(V), 'validation');
        if V is TJSONObject then
          for Pair in TJSONObject(V) do
            if Pair.JsonValue is TJSONArray then
              for Line in TJSONArray(Pair.JsonValue) do
                Msg := Msg + sLineBreak + '  ' + Line.Value;
        Msg := Msg + sLineBreak;
      end;
    Result.Free;
    raise Exception.Create('API NexDistribution (GraphQL): ' + Trim(Msg));
  end;
end;

function GraphQLData(ARoot: TJSONObject; const AField: string): TJSONValue;
begin
  Result := JValue(ARoot, 'data');
  if Result is TJSONObject then
    Result := JValue(TJSONObject(Result), AField)
  else
    Result := nil;
end;

// cheia API a contului, ca in b2b.nexdistribution.md: login -> user.api_token;
// generateApiToken doar daca contul nu are inca o cheie (generarea poate invalida cheia veche)
function ObtainApiToken(const ABaseUrl, AUser, APassword: string): string;
var
  Http: THTTPClient;
  Root: TJSONObject;
  V: TJSONValue;
  Session: string;
  HasAccess: Boolean;
begin
  Result := '';
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 60000;
    Http.Accept := 'application/json';

    // 1. login -> tokenul sesiunii
    Root := GraphQL(Http, ABaseUrl,
      'mutation Login($email: String!, $password: String!) { ' +
      'login(email: $email, password: $password) { status token } }',
      TJSONObject.Create.AddPair('email', AUser).AddPair('password', APassword), '');
    try
      V := GraphQLData(Root, 'login');
      if V is TJSONObject then
        Session := JStr(TJSONObject(V), 'token');
      if Session = '' then
        raise Exception.Create('API NexDistribution: autentificare esuata pentru ' + AUser + '.');
    finally
      Root.Free;
    end;

    // 2. cheia existenta a contului
    Root := GraphQL(Http, ABaseUrl, 'query User { user { api_access api_token } }', nil, Session);
    try
      V := GraphQLData(Root, 'user');
      if not (V is TJSONObject) then
        raise Exception.Create('API NexDistribution: nu s-au putut citi datele contului.');
      HasAccess := JBool(TJSONObject(V), 'api_access', True);
      Result := JStr(TJSONObject(V), 'api_token');
    finally
      Root.Free;
    end;
    if not HasAccess then
      raise Exception.Create('Contul ' + AUser + ' nu are acces la API (api_access = false).' + sLineBreak +
        'Accesul se cere de la NexDistribution.');

    // 3. contul nu are inca o cheie - se genereaza
    if Result = '' then
    begin
      Root := GraphQL(Http, ABaseUrl, 'mutation GenerateApiToken { generateApiToken }', nil, Session);
      try
        V := GraphQLData(Root, 'generateApiToken');
        if V <> nil then
          Result := Trim(V.Value);
      finally
        Root.Free;
      end;
    end;

    // sesiunea nu mai trebuie; o eroare la logout nu conteaza
    try
      GraphQL(Http, ABaseUrl, 'mutation Logout { logout }', nil, Session).Free;
    except
    end;
  finally
    Http.Free;
  end;

  if Result = '' then
    raise Exception.Create('API NexDistribution: contul nu are cheie API si nu s-a putut genera una.');
end;

function DownloadPage(AHttp: THTTPClient; const ABaseUrl: string; APage: Integer): TJSONObject;
var
  Response: IHTTPResponse;
  Body: string;
  V: TJSONValue;
begin
  Response := AHttp.Get(Format('%s/api/products?limit=%d&page=%d', [ABaseUrl, cPageLimit, APage]));
  Body := Response.ContentAsString(TEncoding.UTF8);
  case Response.StatusCode of
    200:
      ;
    401:
      raise Exception.Create('API NexDistribution: cheie API lipsa sau invalida (HTTP 401).' + sLineBreak +
        'Verificati datele de acces ' + cNexApiCode + ' in Setari > Configurari API.');
    403:
      raise Exception.Create('API NexDistribution: acces refuzat (HTTP 403).' + sLineBreak + Copy(Body, 1, 300));
  else
    raise Exception.CreateFmt('API NexDistribution: HTTP %d la pagina %d.%s%s',
      [Response.StatusCode, APage, sLineBreak, Copy(Body, 1, 300)]);
  end;

  V := TJSONObject.ParseJSONValue(Body);
  if not (V is TJSONObject) then
  begin
    V.Free;
    raise Exception.CreateFmt('API NexDistribution: raspuns invalid (nu e JSON) la pagina %d.', [APage]);
  end;
  Result := TJSONObject(V);
  if not JBool(Result, 'success', True) then
  begin
    Body := JStr(Result, 'message');
    Result.Free;
    raise Exception.CreateFmt('API NexDistribution: pagina %d - %s', [APage, Body]);
  end;
end;

function CreateNexHttp(const AToken: string): THTTPClient;
begin
  Result := THTTPClient.Create;
  Result.ConnectionTimeout := 15000;
  Result.ResponseTimeout := 60000;
  Result.Accept := 'application/json';
  Result.CustomHeaders['api-token'] := AToken;
end;

// produsele unei pagini (fara acces la baza si la VCL - ruleaza si in firele de lucru)
function ParsePage(ARoot: TJSONObject; APage: Integer; out ALastPage: Integer): TNexPageResult;
var
  V, Item: TJSONValue;
  List: TList<TNexProduct>;
  Product: TNexProduct;
begin
  Result := Default(TNexPageResult);
  ALastPage := 1;
  V := JValue(ARoot, 'pagination');
  if V is TJSONObject then
    ALastPage := Trunc(JFloat(TJSONObject(V), 'last_page'));

  V := JValue(ARoot, 'data');
  if not (V is TJSONArray) then
    raise Exception.CreateFmt('API NexDistribution: lipseste lista "data" la pagina %d.', [APage]);

  List := TList<TNexProduct>.Create;
  try
    for Item in TJSONArray(V) do
    begin
      if not (Item is TJSONObject) then
        Continue;
      if not JBool(TJSONObject(Item), 'status', True) then
      begin
        Inc(Result.Inactive);
        Continue;
      end;
      Product := ParseProduct(TJSONObject(Item));
      if Product.Code <> '' then
        List.Add(Product);
    end;
    Result.Products := List.ToArray;
  finally
    List.Free;
  end;
end;

// toate paginile: pagina 1 da last_page, restul in cNexThreadCount fire (fiecare cu
// THTTPClient propriu, paginile luate dintr-un contor comun); rezultatele se unesc in ordinea
// paginilor. Produsele inactive si codurile repetate se sar; o eroare pe orice pagina opreste tot.
procedure DownloadCatalog(const AToken, ABaseUrl: string; AProducts: TList<TNexProduct>;
  var AStats: TNexImportStats; const AOnIdle: TProc);
var
  Http: THTTPClient;
  Root: TJSONObject;
  First: TNexPageResult;
  Results: TArray<TNexPageResult>;
  Threads: TArray<TThread>;
  NextPage, Cancelled, LastPage, I: Integer;
  Codes: TDictionary<string, Boolean>;
  Product: TNexProduct;
begin
  Http := CreateNexHttp(AToken);
  try
    Root := DownloadPage(Http, ABaseUrl, 1);
    try
      First := ParsePage(Root, 1, LastPage);
    finally
      Root.Free;
    end;
  finally
    Http.Free;
  end;

  LastPage := EnsureRange(LastPage, 1, cMaxPages);
  SetLength(Results, LastPage);
  Results[0] := First;

  if LastPage > 1 then
  begin
    NextPage := 1;
    Cancelled := 0;
    SetLength(Threads, Min(cNexThreadCount, LastPage - 1));
    for I := 0 to High(Threads) do
    begin
      Threads[I] := TThread.CreateAnonymousThread(
        procedure
        var
          WorkerHttp: THTTPClient;
          PageRoot: TJSONObject;
          Page, Dummy: Integer;
        begin
          WorkerHttp := CreateNexHttp(AToken);
          try
            while TInterlocked.CompareExchange(Cancelled, 0, 0) = 0 do
            begin
              Page := TInterlocked.Increment(NextPage);
              if Page > LastPage then
                Break;
              try
                PageRoot := DownloadPage(WorkerHttp, ABaseUrl, Page);
                try
                  Results[Page - 1] := ParsePage(PageRoot, Page, Dummy);
                finally
                  PageRoot.Free;
                end;
              except
                on E: Exception do
                begin
                  Results[Page - 1].Error := E.Message;
                  TInterlocked.Exchange(Cancelled, 1);
                end;
              end;
            end;
          finally
            WorkerHttp.Free;
          end;
        end);
      Threads[I].FreeOnTerminate := False;
      Threads[I].Start;
    end;

    // firul apelant asteapta firele; AOnIdle (ex. ProcessMessages in WMS) tine fereastra vie
    for I := 0 to High(Threads) do
    begin
      while not Threads[I].Finished do
      begin
        if Assigned(AOnIdle) then
          AOnIdle();
        Sleep(20);
      end;
      Threads[I].Free;
    end;

    for I := 0 to High(Results) do
      if Results[I].Error <> '' then
        raise Exception.Create(Results[I].Error);
  end;

  Codes := TDictionary<string, Boolean>.Create;
  try
    for I := 0 to High(Results) do
    begin
      Inc(AStats.Inactive, Results[I].Inactive);
      for Product in Results[I].Products do
        if Codes.ContainsKey(Product.Code) then
          Inc(AStats.Duplicates)
        else
        begin
          Codes.Add(Product.Code, True);
          AProducts.Add(Product);
        end;
    end;
  finally
    Codes.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ baza                                                                           }
{ ---------------------------------------------------------------------------- }

function SavePriceList(AConnection: TIBCConnection; APriceCategoryID: Integer;
  AProducts: TList<TNexProduct>; var AStats: TNexImportStats): Integer;
var
  Tr: TIBCTransaction;
  qMaster, qItem, qDescr: TIBCQuery;
  Product: TNexProduct;
  DescRo, DescRu: string;
  Rrp: Double;
  Converted: Boolean;
begin
  Tr := TIBCTransaction.Create(nil);
  qMaster := TIBCQuery.Create(nil);
  qItem := TIBCQuery.Create(nil);
  qDescr := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConnection;
    Tr.StartTransaction;
    try
      qMaster.Connection := AConnection;
      qMaster.Transaction := Tr;
      qMaster.AutoCommit := False;
      qMaster.SQL.Text :=
        'insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, FLAGS, MENTIUNI) ' +
        'values (:SUPPLIERID, :PRICE_CATEGORYID, :FLAGS, :MENTIUNI) returning PLID';
      qMaster.ParamByName('SUPPLIERID').AsInteger := cNexSupplierID;
      qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := APriceCategoryID;
      qMaster.ParamByName('FLAGS').AsInteger := cFLG_API;
      qMaster.ParamByName('MENTIUNI').AsString := 'Import automat NexDistribution API';
      qMaster.Options.ReturnParams := True;
      qMaster.ParamCheck := True;
      qMaster.Execute;
      Result := qMaster.ParamByName('RET_PLID').AsInteger;

      qItem.Connection := AConnection;
      qItem.Transaction := Tr;
      qItem.AutoCommit := False;
      qItem.SQL.Text :=
        'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
        'SUPPLIER_GOODS_MODEL, STOCK_QTY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, ' +
        'CURRENCY7ID, SUPPLIER_CATEGORY, PRODUCT_LINK) ' +
        'values (:PLID, :SUPPLIER_GOODS_CODE, :SUPPLIER_GOODS_NAME, :SUPPLIER_GOODS_MODEL, ' +
        ':STOCK_QTY, :PRICE0, :CURRENCY0ID, :PRICE3, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, ' +
        ':SUPPLIER_CATEGORY, :PRODUCT_LINK)';

      qDescr.Connection := AConnection;
      qDescr.Transaction := Tr;
      qDescr.AutoCommit := False;
      qDescr.SQL.Text :=
        'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION ' +
        '  (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO, DESCRIPTION_RU, PRODUCT_CATEGORIES) ' +
        'values (:SUPPLIERID, :CODE, :DESCRIPTION_RO, :DESCRIPTION_RU, :PRODUCT_CATEGORIES) ' +
        'matching (SUPPLIERID, SUPPLIER_GOODS_CODE)';

      for Product in AProducts do
      begin
        Rrp := RrpInMdl(Product, Converted);
        if Converted then
          Inc(AStats.RrpConverted);

        qItem.ParamByName('PLID').AsInteger := Result;
        qItem.ParamByName('SUPPLIER_GOODS_CODE').AsString := Copy(Product.Code, 1, 128);
        qItem.ParamByName('SUPPLIER_GOODS_NAME').AsString := Copy(Product.Name, 1, 2048);
        qItem.ParamByName('SUPPLIER_GOODS_MODEL').AsString := Copy(Product.Article, 1, 255);
        qItem.ParamByName('STOCK_QTY').AsString := IntToStr(Product.Quantity);
        qItem.ParamByName('PRICE0').AsFloat := Product.PriceMdl;
        qItem.ParamByName('CURRENCY0ID').AsInteger := cCurrencyMDL;
        qItem.ParamByName('PRICE3').AsFloat := Rrp;
        qItem.ParamByName('CURRENCY3ID').AsInteger := cCurrencyMDL;
        qItem.ParamByName('PRICE7').AsFloat := Product.PriceMdl;
        qItem.ParamByName('CURRENCY7ID').AsInteger := cCurrencyMDL;
        qItem.ParamByName('SUPPLIER_CATEGORY').AsString := Copy(Product.Category, 1, 128);
        // SUPPLIER_CATEGORY / PRODUCT_LINK / PRODUCT_CATEGORIES: 512 octeti = 128 caractere UTF8
        qItem.ParamByName('PRODUCT_LINK').AsString := Copy(Product.B2BUrl, 1, 128);
        qItem.Execute;

        if Length(Product.Images) > 0 then
          Inc(AStats.WithImages);

        DescRo := BuildDescription(Product.DescRo, Product.Attributes, False);
        DescRu := BuildDescription(Product.DescRu, Product.Attributes, True);
        if (DescRo <> '') or (DescRu <> '') then
        begin
          qDescr.ParamByName('SUPPLIERID').AsInteger := cNexSupplierID;
          qDescr.ParamByName('CODE').AsString := Copy(Product.Code, 1, 128);
          qDescr.ParamByName('DESCRIPTION_RO').DataType := ftWideMemo;
          qDescr.ParamByName('DESCRIPTION_RO').Value := DescRo;
          qDescr.ParamByName('DESCRIPTION_RU').DataType := ftWideMemo;
          qDescr.ParamByName('DESCRIPTION_RU').Value := DescRu;
          qDescr.ParamByName('PRODUCT_CATEGORIES').AsString := Copy(Product.Category, 1, 128);
          qDescr.ExecSQL;
          Inc(AStats.Descriptions);
        end;
      end;

      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    qDescr.Free;
    qItem.Free;
    qMaster.Free;
    Tr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ imaginile (fire + fereastra de progres din MamicoContentUnit)                  }
{ ---------------------------------------------------------------------------- }

procedure TNexImageFilter.FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := GNexImages.ContainsKey(Trim(DataSet.FieldByName('SUPPLIER_GOODS_CODE').AsString));
end;

// ruleaza in firele de lucru: doar descarca imaginile deja cunoscute din API
function NexFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
var
  Urls: TArray<string>;
  I: Integer;
begin
  Result := TMamicoItemResult.Create(ACode);
  if not GNexImages.TryGetValue(ACode, Urls) or (Length(Urls) = 0) then
  begin
    Result.Log.Add(Format('%s: fara imagini in API', [ACode]));
    Exit;
  end;

  Result.ImageUrls := Urls;
  SetLength(Result.ImageData, Length(Urls));
  for I := 0 to High(Urls) do
  begin
    Result.ImageData[I] := ContentGetBytes(AHttp, Urls[I]);
    if Length(Result.ImageData[I]) = 0 then
      Result.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, Urls[I]]));
  end;
  Result.Found := True;
end;

procedure DownloadImages(AConnection: TIBCConnection; APLID: Integer; AProducts: TList<TNexProduct>);
var
  Product: TNexProduct;
  Filter: TNexImageFilter;
  Query: TIBCQuery;
begin
  GNexImages := TDictionary<string, TArray<string>>.Create;
  Filter := TNexImageFilter.Create;
  Query := TIBCQuery.Create(nil);
  try
    for Product in AProducts do
      if Length(Product.Images) > 0 then
        GNexImages.AddOrSetValue(Copy(Product.Code, 1, 128), Product.Images);
    if GNexImages.Count = 0 then
      Exit;

    Query.Connection := AConnection;
    Query.SQL.Text :=
      'select SUPPLIER_GOODS_CODE, PRODUCT_LINK from TS_PRICELIST_ITEMS ' +
      'where PLID = :PLID order by SUPPLIER_GOODS_CODE';
    Query.ParamByName('PLID').AsInteger := APLID;
    Query.OnFilterRecord := Filter.FilterRecord;
    Query.Filtered := True;
    Query.Open;

    TMamicoContentLoader.RunForPriceItemsEx(Query, AConnection, cNexSupplierID, NexFetch,
      'NexDistribution API');
  finally
    Query.Free;
    Filter.Free;
    FreeAndNil(GNexImages);
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TNexPriceListImport                                                            }
{ ---------------------------------------------------------------------------- }

// partea comuna a lui Run si Import: datele de acces, catalogul (8 fire) si pricelistul
function DoImport(AConnection: TIBCConnection; APriceCategoryID: Integer; AProducts: TList<TNexProduct>;
  var AStats: TNexImportStats; const AOnIdle: TProc): Integer;
var
  User, Password, Token, BaseUrl: string;
begin
  ReadApiConfig(AConnection, User, Password, Token, BaseUrl);
  if ((User = '') or (Password = '')) and (Token = '') then
    raise Exception.Create('Lipsesc datele de acces la API-ul NexDistribution.' + sLineBreak +
      'Adaugati in Setari > Configurari API, API_CODE = ' + cNexApiCode + ' (furnizor ' +
      IntToStr(cNexSupplierID) + '), parametrii USERNAME (email-ul contului b2b.nexdistribution.md) ' +
      'si PASSWORD.');

  // cheia API se cere de la API cu contul b2b; API_TOKEN din configurare e doar alternativa
  if (User <> '') and (Password <> '') then
    Token := ObtainApiToken(BaseUrl, User, Password);
  DownloadCatalog(Token, BaseUrl, AProducts, AStats, AOnIdle);
  if AProducts.Count = 0 then
    raise Exception.Create('API-ul NexDistribution nu a intors niciun produs activ.');
  Result := SavePriceList(AConnection, APriceCategoryID, AProducts, AStats);
end;

function StatsText(APLID: Integer; AProducts: TList<TNexProduct>; const AStats: TNexImportStats): string;
begin
  Result := Format('Pricelist NexDistribution #%d creat:' + sLineBreak +
    '  produse: %d (inactive sarite: %d, coduri repetate: %d)' + sLineBreak +
    '  descrieri RO/RU: %d' + sLineBreak +
    '  RRP convertit din EUR: %d' + sLineBreak +
    '  produse cu imagini: %d',
    [APLID, AProducts.Count, AStats.Inactive, AStats.Duplicates, AStats.Descriptions,
     AStats.RrpConverted, AStats.WithImages]);
end;

class function TNexPriceListImport.Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;
var
  Products: TList<TNexProduct>;
  Stats: TNexImportStats;
begin
  Stats := Default(TNexImportStats);
  Products := TList<TNexProduct>.Create;
  try
    Screen.Cursor := crHourGlass;
    // firele de descarcare ruleaza cu ProcessMessages - fereastra principala nu primeste clicuri
    if Assigned(Application.MainForm) then
      Application.MainForm.Enabled := False;
    try
      Result := DoImport(AConnection, APriceCategoryID, Products, Stats,
        procedure
        begin
          Application.ProcessMessages;
        end);
    finally
      if Assigned(Application.MainForm) then
        Application.MainForm.Enabled := True;
      Screen.Cursor := crDefault;
    end;

    MessageDlg(StatsText(Result, Products, Stats) + sLineBreak + sLineBreak +
      'Urmeaza descarcarea imaginilor.', mtInformation, [mbOK], 0);

    DownloadImages(AConnection, Result, Products);
  finally
    Products.Free;
  end;
end;

class function TNexPriceListImport.Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
  AWithImages: Boolean; const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>;
  AImageThreads: Integer): Integer;
var
  Products: TList<TNexProduct>;
  Stats: TNexImportStats;
  Product: TNexProduct;
  Codes, Links: TList<string>;
  Line: string;
begin
  Stats := Default(TNexImportStats);
  Products := TList<TNexProduct>.Create;
  try
    Result := DoImport(AConnection, APriceCategoryID, Products, Stats, nil);
    if Assigned(AOnLog) then
      for Line in StatsText(Result, Products, Stats).Split([sLineBreak]) do
        AOnLog(Line);

    if not AWithImages then
      Exit;
    // imaginile doar la articolele fara continut (descriere + imagine deja salvate = sarite)
    GNexImages := TDictionary<string, TArray<string>>.Create;
    Codes := TList<string>.Create;
    Links := TList<string>.Create;
    try
      for Product in Products do
        if Length(Product.Images) > 0 then
        begin
          GNexImages.AddOrSetValue(Copy(Product.Code, 1, 128), Product.Images);
          Codes.Add(Copy(Product.Code, 1, 128));
          Links.Add(Product.B2BUrl);
        end;
      TMamicoContentLoader.RunForItemsSilent(Codes.ToArray, Links.ToArray, AConnection, cNexSupplierID,
        NexFetch, True, AImageThreads, 0, AOnLog, AIsCancelled);
    finally
      Links.Free;
      Codes.Free;
      FreeAndNil(GNexImages);
    end;
  finally
    Products.Free;
  end;
end;

end.

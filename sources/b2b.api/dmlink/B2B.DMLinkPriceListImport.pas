unit B2B.DMLinkPriceListImport;

(* ============================================================================
   Import automat al catalogului DMLink (furnizor 229466) direct prin API-ul
   b2b.dmlink.md (THTTPClient) - fara B2BDMLInk.dll si fara DMLinkAPIClientUnit.

     POST /api/v1/auth/login   {email, password} -> token (Bearer)
     GET  /api/v2/products     {"data": [...]} - tot catalogul intr-un singur raspuns

   API-ul nu are paginare si nici filtre (page/offset/skip/category/brand sunt
   ignorate, doar limit = primele N), deci descarcarea ramine un singur request
   (~11 000 produse, ~35 MB, ~15 s generare pe server, fara gzip). Paralelismul e
   pe celelalte etape:
     1. descarcarea ruleaza intr-un fir separat; intre timp firul apelant citeste
        din baza imaginile existente ale furnizorului;
     2. raspunsul se imparte la nivel de octeti in elementele listei "data", iar
        elementele se parseaza (System.JSON) in pina la 8 fire;
     3. scrierea in baza: antetul TS_PRICELISTS se comite separat (FK-ul
        articolelor il vede doar dupa COMMIT), apoi 8 fire, fiecare cu conexiunea
        si tranzactia lui, scriu articolele, descrierile si URL-urile imaginilor
        in loturi IBDAC (Params.ValueCount + Execute(N) = EXECUTE BLOCK cu zeci de
        randuri pe drum). Totul sau nimic: COMMIT doar daca toate firele au reusit,
        altfel ROLLBACK peste tot si se sterge antetul (FK ON DELETE CASCADE).

   Tabele:
     TS_PRICELISTS                  - antetul (FLAGS = 2 = FLG_API)
     TS_PRICELIST_ITEMS             - sku -> SUPPLIER_GOODS_CODE, preturile ca in
                                      pricelisturile DMLink introduse manual:
                                      PRICE0 = nprice (cost, daca e dat) altfel sprice,
                                      PRICE7 = sprice (USD), PRICE3 = rprice (RRP, MDL)
     TS_PRICELIST_ITEMS_DESCRIPTION - description (altfel shortDescription) -> DESCRIPTION_RO
     TS_PRICELIST_ITEMS_IMAGES      - URL-urile imaginilor; se rescriu doar la produsele
                                      la care lista s-a schimbat, ca imaginile descarcate
                                      (IMAGE) sa nu se piarda la fiecare import

   Imaginile propriu-zise (IMAGE, PNG) se descarca separat, prin DownloadImages
   (fire + fereastra de progres din MamicoContentUnit), doar pentru randurile fara IMAGE.

   Produsele fara stoc (stock <= 0, ~55% din catalog) nu intra in pricelist: API-ul
   intoarce tot catalogul, inclusiv pozitiile epuizate (ex. QAU-00022, QAU-00083).

   Sku repetat in raspuns (ex. "Black" la mai multe produse): codul ambiguu nu poate
   fi legat de nomenclator, se sar toate aparitiile (PK = PLID + cod). Se numara doar
   produsele cu stoc, ca o copie epuizata sa nu blocheze codul.

   Credentialele (USERNAME/PASSWORD) vin din TS_API_CONFIG, API_CODE = 'DMLINK'
   (meniul Setari > Configurari API din SWN).

   Execute nu atinge VCL-ul: cit asteapta firele, apeleaza OnWait (ex.
   Application.ProcessMessages) si OnProgress (textul etapei curente).
   ============================================================================ *)

interface

uses
  System.SysUtils, System.Classes, IBC;

const
  cDMLinkSupplierID = 229466;

type
  TDMLinkImportResult = record
    PLID: Integer;
    ProductsImported: Integer;
    Descriptions: Integer;
    ProductsWithImages: Integer;
    // produse la care lista de URL-uri s-a schimbat (rescrise in TS_PRICELIST_ITEMS_IMAGES)
    ImagesChanged: Integer;
    ImageRows: Integer;
    // elemente din "data" care nu sint obiecte JSON valide sau nu au sku
    InvalidProducts: Integer;
    // produse sarite: acelasi sku la mai multe produse (ex. "Black" - DMLink pune uneori
    // culoarea in sku); un cod ambiguu nu poate fi legat de nomenclator, se sar toate aparitiile
    DuplicateProducts: Integer;
    DuplicateCodes: string;   // lista codurilor repetate, separate prin virgula
    // produse sarite: fara stoc la DMLink (stock <= 0; "transit" nu conteaza), ca la
    // celelalte importuri API (Accent, Triomac, Olis Grup) - 5 oct 2026
    OutOfStockProducts: Integer;
    ParseThreads: Integer;
    DbThreads: Integer;
    DownloadMs: Int64;
    ParseMs: Int64;
    SaveMs: Int64;
  end;

  TDMLinkPriceListImport = class
  private
    FConnection: TIBCConnection;
    FSupplierID: Integer;
    FPriceCategoryID: Integer;
    FOnWait: TProc;
    FOnProgress: TProc<string>;
    function ReadCredentials(out AUser, APassword: string): Boolean;
    procedure Idle(const AText: string);
    procedure WaitThreads(const AThreads: TArray<TThread>; const AText: TFunc<string>);
  public
    constructor Create(AConnection: TIBCConnection; ASupplierID: Integer = cDMLinkSupplierID; APriceCategoryID: Integer = 10);

    // Ruleaza importul complet (autentificare + catalog + insert-uri), totul sau nimic.
    // Arunca Exception pe orice esec (credentiale lipsa, login esuat, raspuns invalid,
    // eroare la scriere) - in acest caz nu ramine niciun pricelist.
    function Execute: TDMLinkImportResult;

    // descarca in fire imaginile articolelor din APLID care au in TS_PRICELIST_ITEMS_IMAGES
    // randuri fara IMAGE (fereastra de progres comuna cu mamico.md / NexDistribution)
    class procedure DownloadImages(AConnection: TIBCConnection; APLID: Integer;
      ASupplierID: Integer = cDMLinkSupplierID);

    // acelasi lucru fara interfata (WMSParsers, orice fir): AThreadCount fire, fiecare
    // descarca, converteste in PNG si scrie pe conexiunea lui; intoarce imaginile salvate
    class function DownloadImagesSilent(AConnection: TIBCConnection; APLID: Integer;
      const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>;
      ASupplierID: Integer = cDMLinkSupplierID; AThreadCount: Integer = 12): Integer;

    // apelat periodic de firul apelant cit asteapta firele de lucru
    property OnWait: TProc read FOnWait write FOnWait;
    // textul etapei curente (apelat din firul apelant)
    property OnProgress: TProc<string> read FOnProgress write FOnProgress;
  end;

implementation

uses
  System.JSON, System.Math, System.SyncObjs, System.Diagnostics,
  System.Generics.Collections, System.Net.HttpClient, System.Net.URLClient, System.NetConsts,
  Data.DB, DBAccess, IBCClasses, MamicoContentUnit;

const
  cBaseUrl = 'https://b2b.dmlink.md/api';
  cApiCode = 'DMLINK';
  cFLG_API = 2;
  cCurrencyUSD = 840;
  cCurrencyMDL = 498;
  cMaxParseThreads = 8;
  // fire de scriere in baza, fiecare cu conexiunea lui
  cDbThreadCount = 8;
  // produse luate odata de un fir de parsare / de scriere
  cParseChunk = 64;
  cDbChunk = 250;

type
  TDMLinkProduct = record
    SKU: string;
    Name: string;
    Description: string;
    Brand: string;
    Category: string;
    RPrice: Double;
    SPrice: Double;
    NPrice: Double;
    Stock: Integer;
    Warranty: Integer;
    Images: TArray<string>;
  end;

  TJsonSpan = record
    Offset: Integer;
    Length: Integer;
  end;

  // un fir de lucru: ruleaza AWork(AIndex), eroarea ramine in Error
  TDMLinkWorker = class(TThread)
  private
    FWork: TProc<Integer>;
    FIndex: Integer;
  protected
    procedure Execute; override;
  public
    Error: string;
    constructor Create(const AWork: TProc<Integer>; AIndex: Integer);
  end;

  // starea comuna a scrierii in baza
  TDMLinkSaveJob = class
  public
    Template: TIBCConnection;                 // doar citit din fire (Assign)
    Products: TArray<TDMLinkProduct>;
    ImagesChanged: TArray<Boolean>;           // paralel cu Products
    PLID: Integer;
    SupplierID: Integer;
    NextIndex: Integer;                       // TInterlocked
    Saved: Integer;                           // TInterlocked
    Descriptions: Integer;                    // TInterlocked
    ImageRows: Integer;                       // TInterlocked
    Failed: Integer;                          // 0/1, TInterlocked
    InsertPhaseLeft: TCountdownEvent;
    Decision: TEvent;                         // semnalat dupa ce toate firele au terminat INSERT-urile
    CommitAll: Boolean;                       // citit de fire abia dupa Decision
    Errors: TArray<string>;
    Committed: TArray<Boolean>;
    constructor Create(AThreadCount: Integer);
    destructor Destroy; override;
    function HasFailed: Boolean;
    procedure Work(AIndex: Integer);
  private
    procedure SaveChunk(AItem, ADescr, AImgDel, AImgIns: TIBCSQL; AFrom, ATo: Integer);
  end;

  // filtrul dataset-ului dat lui RunForPriceItemsEx: doar articolele cu imagini nedescarcate
  TDMLinkImageFilter = class
  public
    procedure FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  end;

var
  GInvariant: TFormatSettings;
  // cod -> URL-urile imaginilor (ordinea ORDERNO); completat inainte de pornirea firelor
  // din DownloadImages si doar citit din ele
  GDMLinkImages: TDictionary<string, TArray<string>>;

{ ---------------------------------------------------------------------------- }
{ JSON                                                                           }
{ ---------------------------------------------------------------------------- }

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if Assigned(AObj) and AObj.TryGetValue(AName, V) and not V.Null then
    Result := V.Value;
end;

function JFloat(AObj: TJSONObject; const AName: string): Double;
begin
  Result := StrToFloatDef(Trim(JStr(AObj, AName)), 0, GInvariant);
end;

// imaginile vin ca [["url"], ["url"]]; se accepta si "url" sau {"url": ...}
function JImageURL(AItem: TJSONValue): string;
var
  Obj: TJSONObject;
  V: TJSONValue;
begin
  Result := '';
  if AItem is TJSONString then
    Result := TJSONString(AItem).Value
  else if AItem is TJSONArray then
  begin
    for V in TJSONArray(AItem) do
    begin
      Result := JImageURL(V);
      if Result <> '' then
        Break;
    end;
  end
  else if AItem is TJSONObject then
  begin
    Obj := TJSONObject(AItem);
    Result := JStr(Obj, 'url');
    if Result = '' then
      Result := JStr(Obj, 'path');
    if Result = '' then
      Result := JStr(Obj, 'image');
    if Result = '' then
      Result := JStr(Obj, 'src');
  end;
  Result := Trim(Result);
end;

function ParseProduct(AObj: TJSONObject; out AProduct: TDMLinkProduct): Boolean;
var
  V, Item: TJSONValue;
  Images: TList<string>;
  Url: string;
begin
  AProduct := Default(TDMLinkProduct);
  AProduct.SKU := Trim(JStr(AObj, 'sku'));
  Result := AProduct.SKU <> '';
  if not Result then
    Exit;

  AProduct.Name := Trim(JStr(AObj, 'name'));
  AProduct.Description := Trim(JStr(AObj, 'description'));
  if AProduct.Description = '' then
    AProduct.Description := Trim(JStr(AObj, 'shortDescription'));

  if AObj.TryGetValue('brand', V) and (V is TJSONObject) then
    AProduct.Brand := Trim(JStr(TJSONObject(V), 'name'));
  if AObj.TryGetValue('category', V) and (V is TJSONObject) then
    AProduct.Category := Trim(JStr(TJSONObject(V), 'name'));

  AProduct.RPrice := JFloat(AObj, 'rprice');
  AProduct.SPrice := JFloat(AObj, 'sprice');
  AProduct.NPrice := JFloat(AObj, 'nprice');
  AProduct.Stock := Trunc(JFloat(AObj, 'stock'));
  AProduct.Warranty := Trunc(JFloat(AObj, 'warrantyPeriod'));

  if AObj.TryGetValue('images', V) and (V is TJSONArray) and (TJSONArray(V).Count > 0) then
  begin
    Images := TList<string>.Create;
    try
      for Item in TJSONArray(V) do
      begin
        Url := JImageURL(Item);
        if (Url <> '') and (Length(Url) <= 512) and (Images.IndexOf(Url) < 0) then
          Images.Add(Url);
      end;
      AProduct.Images := Images.ToArray;
    finally
      Images.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ impartirea raspunsului pe elemente (la nivel de octeti UTF-8: caracterele de     }
{ structura sint ASCII, octetii multi-byte sint toti >= $80)                     }
{ ---------------------------------------------------------------------------- }

function SkipWs(const B: TBytes; P, ALen: Integer): Integer;
begin
  while (P < ALen) and (B[P] in [9, 10, 13, 32]) do
    Inc(P);
  Result := P;
end;

// sfirsitul (exclusiv) valorii JSON care incepe la P
function SkipValue(const B: TBytes; P, ALen: Integer): Integer;
var
  Depth: Integer;
  InStr: Boolean;
begin
  if P >= ALen then
    Exit(ALen);
  case B[P] of
    34: // "
      begin
        Inc(P);
        while P < ALen do
        begin
          if B[P] = 92 then // \
            Inc(P, 2)
          else if B[P] = 34 then
            Exit(P + 1)
          else
            Inc(P);
        end;
        Result := ALen;
      end;
    91, 123: // [ {
      begin
        Depth := 0;
        InStr := False;
        while P < ALen do
        begin
          if InStr then
          begin
            if B[P] = 92 then
              Inc(P)
            else if B[P] = 34 then
              InStr := False;
          end
          else
            case B[P] of
              34:
                InStr := True;
              91, 123:
                Inc(Depth);
              93, 125:
                begin
                  Dec(Depth);
                  if Depth = 0 then
                    Exit(P + 1);
                end;
            end;
          Inc(P);
        end;
        Result := ALen;
      end;
  else
    while (P < ALen) and not (B[P] in [9, 10, 13, 32, 44, 93, 125]) do
      Inc(P);
    Result := P;
  end;
end;

// pozitia '[' a listei de produse: radacina e chiar lista sau un obiect cu cheia
// data / products / items
function FindProductsArray(const B: TBytes; ALen: Integer): Integer;
var
  P, KeyEnd: Integer;
  Key: string;
begin
  Result := -1;
  P := 0;
  if (ALen >= 3) and (B[0] = $EF) and (B[1] = $BB) and (B[2] = $BF) then
    P := 3;
  P := SkipWs(B, P, ALen);
  if P >= ALen then
    Exit;
  if B[P] = 91 then
    Exit(P);
  if B[P] <> 123 then
    Exit;

  Inc(P);
  while P < ALen do
  begin
    P := SkipWs(B, P, ALen);
    if (P >= ALen) or (B[P] = 125) then
      Exit;
    if B[P] = 44 then
    begin
      Inc(P);
      Continue;
    end;
    if B[P] <> 34 then
      Exit;
    KeyEnd := SkipValue(B, P, ALen);
    Key := TEncoding.UTF8.GetString(B, P + 1, Max(0, KeyEnd - P - 2));
    P := SkipWs(B, KeyEnd, ALen);
    if (P >= ALen) or (B[P] <> 58) then // :
      Exit;
    P := SkipWs(B, P + 1, ALen);
    if (P < ALen) and (B[P] = 91) and
       (SameText(Key, 'data') or SameText(Key, 'products') or SameText(Key, 'items')) then
      Exit(P);
    P := SkipValue(B, P, ALen);
  end;
end;

// limitele elementelor listei care incepe la AStart ('['); raspuns trunchiat = exceptie
function SplitArray(const B: TBytes; AStart, ALen: Integer): TArray<TJsonSpan>;
var
  List: TList<TJsonSpan>;
  P, E: Integer;
  Span: TJsonSpan;
  Closed: Boolean;
begin
  Closed := False;
  List := TList<TJsonSpan>.Create;
  try
    List.Capacity := 16384;
    P := AStart + 1;
    while P < ALen do
    begin
      P := SkipWs(B, P, ALen);
      if P >= ALen then
        Break;
      if B[P] = 93 then
      begin
        Closed := True;
        Break;
      end;
      if B[P] = 44 then
      begin
        Inc(P);
        Continue;
      end;
      E := SkipValue(B, P, ALen);
      if E <= P then
        Break;
      Span.Offset := P;
      Span.Length := E - P;
      List.Add(Span);
      P := E;
    end;
    if not Closed then
      raise Exception.Create('Raspuns incomplet de la API-ul DMLink (lista de produse nu se inchide).');
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ HTTP                                                                           }
{ ---------------------------------------------------------------------------- }

function ApiLogin(AHttp: THTTPClient; const AUser, APassword: string): string;
var
  Json: TJSONObject;
  Body: TStringStream;
  Response: IHTTPResponse;
  Text: string;
  V: TJSONValue;
begin
  Json := TJSONObject.Create;
  try
    Json.AddPair('email', AUser);
    Json.AddPair('password', APassword);
    Body := TStringStream.Create(Json.ToJSON, TEncoding.UTF8);
  finally
    Json.Free;
  end;
  try
    Response := AHttp.Post(cBaseUrl + '/v1/auth/login', Body);
  finally
    Body.Free;
  end;

  Text := Response.ContentAsString(TEncoding.UTF8);
  if (Response.StatusCode <> 200) and (Response.StatusCode <> 201) then
    raise Exception.CreateFmt('Autentificare esuata la API-ul DMLink (HTTP %d).%s%s',
      [Response.StatusCode, sLineBreak, Copy(Text, 1, 300)]);

  Result := '';
  V := TJSONObject.ParseJSONValue(Text);
  try
    if V is TJSONObject then
    begin
      Result := JStr(TJSONObject(V), 'token');
      if Result = '' then
        Result := JStr(TJSONObject(V), 'access_token');
    end;
  finally
    V.Free;
  end;
  if Result = '' then
    raise Exception.Create('Autentificare esuata la API-ul DMLink: raspunsul nu contine token.');
end;

// login + catalogul complet (octetii UTF-8 ai raspunsului)
function DownloadCatalog(const AUser, APassword: string): TBytes;
var
  Http: THTTPClient;
  Stream: TBytesStream;
  Response: IHTTPResponse;
  Size: Integer;
begin
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 30000;
    // catalogul complet se genereaza ~15 s pe server
    Http.ResponseTimeout := 300000;
    Http.Accept := 'application/json';
    Http.ContentType := 'application/json';
    Http.CustomHeaders['Authorization'] := 'Bearer ' + ApiLogin(Http, AUser, APassword);

    Stream := TBytesStream.Create;
    try
      Response := Http.Get(cBaseUrl + '/v2/products', Stream);
      if Response.StatusCode <> 200 then
        raise Exception.CreateFmt('API DMLink: HTTP %d la lista de produse.%s%s',
          [Response.StatusCode, sLineBreak,
           TEncoding.UTF8.GetString(Stream.Bytes, 0, Min(Integer(Stream.Size), 300))]);
      Size := Stream.Size;
      Result := Stream.Bytes;
    finally
      Stream.Free;
    end;
    SetLength(Result, Size);
  finally
    Http.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TDMLinkWorker                                                                  }
{ ---------------------------------------------------------------------------- }

constructor TDMLinkWorker.Create(const AWork: TProc<Integer>; AIndex: Integer);
begin
  FWork := AWork;
  FIndex := AIndex;
  inherited Create(False);
  FreeOnTerminate := False;
end;

procedure TDMLinkWorker.Execute;
begin
  try
    FWork(FIndex);
  except
    on E: Exception do
      Error := E.Message;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TDMLinkSaveJob                                                                 }
{ ---------------------------------------------------------------------------- }

constructor TDMLinkSaveJob.Create(AThreadCount: Integer);
begin
  inherited Create;
  InsertPhaseLeft := TCountdownEvent.Create(AThreadCount);
  Decision := TEvent.Create(nil, True, False, '');
  SetLength(Errors, AThreadCount);
  SetLength(Committed, AThreadCount);
end;

destructor TDMLinkSaveJob.Destroy;
begin
  Decision.Free;
  InsertPhaseLeft.Free;
  inherited;
end;

function TDMLinkSaveJob.HasFailed: Boolean;
begin
  Result := TInterlocked.CompareExchange(Failed, 0, 0) <> 0;
end;

// produsele [AFrom, ATo): fiecare instructiune se trimite ca lot (parametri-array)
procedure TDMLinkSaveJob.SaveChunk(AItem, ADescr, AImgDel, AImgIns: TIBCSQL; AFrom, ATo: Integer);
var
  K, M, N, J, Rows: Integer;
  Price0: Double;
begin
  // articolele
  N := ATo - AFrom;
  AItem.Params.ValueCount := N;
  for K := 0 to N - 1 do
  begin
    Price0 := Products[AFrom + K].NPrice;
    if Price0 <= 0 then
      Price0 := Products[AFrom + K].SPrice;
    AItem.Params[0][K].AsString := Copy(Products[AFrom + K].SKU, 1, 128);
    AItem.Params[1][K].AsString := Copy(Products[AFrom + K].Name, 1, 2048);
    AItem.Params[2][K].AsString := IntToStr(Products[AFrom + K].Stock);
    AItem.Params[3][K].AsFloat := Price0;
    AItem.Params[4][K].AsFloat := Products[AFrom + K].RPrice;
    AItem.Params[5][K].AsFloat := Products[AFrom + K].SPrice;
    AItem.Params[6][K].AsInteger := Products[AFrom + K].Warranty;
    AItem.Params[7][K].AsString := Copy(Products[AFrom + K].Brand, 1, 128);
    // SUPPLIER_CATEGORY are 512 octeti = 128 caractere UTF8 (vezi TriomacPriceListUnit)
    AItem.Params[8][K].AsString := Copy(Products[AFrom + K].Category, 1, 128);
  end;
  AItem.Execute(N);

  // descrierile
  Rows := 0;
  for K := AFrom to ATo - 1 do
    if Products[K].Description <> '' then
      Inc(Rows);
  if Rows > 0 then
  begin
    ADescr.Params.ValueCount := Rows;
    J := 0;
    for K := AFrom to ATo - 1 do
      if Products[K].Description <> '' then
      begin
        ADescr.Params[0][J].AsString := Copy(Products[K].SKU, 1, 128);
        ADescr.Params[1][J].AsString := Products[K].Description;
        Inc(J);
      end;
    ADescr.Execute(Rows);
    TInterlocked.Add(Descriptions, Rows);
  end;

  // imaginile: doar produsele la care lista de URL-uri s-a schimbat
  N := 0;
  Rows := 0;
  for K := AFrom to ATo - 1 do
    if ImagesChanged[K] then
    begin
      Inc(N);
      Inc(Rows, Length(Products[K].Images));
    end;
  if N > 0 then
  begin
    AImgDel.Params.ValueCount := N;
    J := 0;
    for K := AFrom to ATo - 1 do
      if ImagesChanged[K] then
      begin
        AImgDel.Params[0][J].AsString := Copy(Products[K].SKU, 1, 128);
        Inc(J);
      end;
    AImgDel.Execute(N);

    AImgIns.Params.ValueCount := Rows;
    J := 0;
    for K := AFrom to ATo - 1 do
      if ImagesChanged[K] then
        for M := 0 to High(Products[K].Images) do
        begin
          AImgIns.Params[0][J].AsString := Copy(Products[K].SKU, 1, 128);
          AImgIns.Params[1][J].AsString := Products[K].Images[M];
          AImgIns.Params[2][J].AsInteger := M + 1;
          Inc(J);
        end;
    AImgIns.Execute(Rows);
    TInterlocked.Add(ImageRows, Rows);
  end;

  TInterlocked.Add(Saved, ATo - AFrom);
end;

function CreateBatchSQL(AConnection: TIBCConnection; ATransaction: TIBCTransaction;
  const ASQL: string; const ATypes: array of TFieldType): TIBCSQL;
var
  I: Integer;
begin
  Result := TIBCSQL.Create(nil);
  Result.Connection := AConnection;
  Result.Transaction := ATransaction;
  Result.AutoCommit := False;
  Result.SQL.Text := ASQL;
  // tipurile inainte de valori: la loturi IBDAC declara parametrii EXECUTE BLOCK dupa ele
  for I := 0 to High(ATypes) do
    Result.Params[I].DataType := ATypes[I];
end;

procedure TDMLinkSaveJob.Work(AIndex: Integer);
var
  Connection: TIBCConnection;
  Tr: TIBCTransaction;
  qItem, qDescr, qImgDel, qImgIns: TIBCSQL;
  Index, Count: Integer;
  InsertPhaseSignaled: Boolean;
begin
  InsertPhaseSignaled := False;
  Connection := nil;
  Tr := nil;
  qItem := nil;
  qDescr := nil;
  qImgDel := nil;
  qImgIns := nil;
  try
    try
      Connection := TIBCConnection.Create(nil);
      Connection.Assign(Template);
      Connection.Params.Assign(Template.Params);
      Connection.LoginPrompt := False;
      Connection.Connect;

      Tr := TIBCTransaction.Create(nil);
      Tr.DefaultConnection := Connection;
      Tr.StartTransaction;

      qItem := CreateBatchSQL(Connection, Tr,
        'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
        'STOCK_QTY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, WARANTY, ' +
        'SUPPLIER_GOODS_BRAND, SUPPLIER_CATEGORY) ' +
        Format('values (%d, :CODE, :NAME, :STOCK, :PRICE0, %d, :PRICE3, %d, :PRICE7, %d, ',
          [PLID, cCurrencyUSD, cCurrencyMDL, cCurrencyUSD]) +
        ':WARANTY, :BRAND, :CATEGORY)',
        [ftWideString, ftWideString, ftWideString, ftFloat, ftFloat, ftFloat, ftInteger,
         ftWideString, ftWideString]);

      qDescr := CreateBatchSQL(Connection, Tr,
        'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO) ' +
        Format('values (%d, :CODE, :DESCRIPTION_RO) ', [SupplierID]) +
        'matching (SUPPLIERID, SUPPLIER_GOODS_CODE)',
        [ftWideString, ftWideMemo]);

      qImgDel := CreateBatchSQL(Connection, Tr,
        Format('delete from TS_PRICELIST_ITEMS_IMAGES where SUPPLIERID = %d ', [SupplierID]) +
        'and SUPPLIER_GOODS_CODE = :CODE',
        [ftWideString]);

      qImgIns := CreateBatchSQL(Connection, Tr,
        'insert into TS_PRICELIST_ITEMS_IMAGES (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL, PROCESS_DATE, ORDERNO) ' +
        Format('values (%d, :CODE, :URL, current_timestamp, :ORDERNO)', [SupplierID]),
        [ftWideString, ftWideString, ftInteger]);

      Count := Length(Products);
      while not HasFailed do
      begin
        Index := TInterlocked.Add(NextIndex, cDbChunk) - cDbChunk;
        if Index >= Count then
          Break;
        SaveChunk(qItem, qDescr, qImgDel, qImgIns, Index, Min(Index + cDbChunk, Count));
      end;
    except
      on E: Exception do
      begin
        Errors[AIndex] := E.Message;
        TInterlocked.Exchange(Failed, 1);
      end;
    end;

    // gata cu INSERT-urile; decizia (COMMIT/ROLLBACK) o ia firul apelant
    InsertPhaseLeft.Signal;
    InsertPhaseSignaled := True;
    Decision.WaitFor(INFINITE);

    if Assigned(Tr) and Tr.Active then
    try
      if CommitAll and (Errors[AIndex] = '') then
      begin
        Tr.Commit;
        Committed[AIndex] := True;
      end
      else
        Tr.Rollback;
    except
      on E: Exception do
        if Errors[AIndex] = '' then
          Errors[AIndex] := E.Message;
    end;
  finally
    if not InsertPhaseSignaled then
      InsertPhaseLeft.Signal;
    qImgIns.Free;
    qImgDel.Free;
    qDescr.Free;
    qItem.Free;
    Tr.Free;
    Connection.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TDMLinkPriceListImport                                                         }
{ ---------------------------------------------------------------------------- }

constructor TDMLinkPriceListImport.Create(AConnection: TIBCConnection; ASupplierID, APriceCategoryID: Integer);
begin
  inherited Create;
  FConnection := AConnection;
  FSupplierID := ASupplierID;
  FPriceCategoryID := APriceCategoryID;
end;

function TDMLinkPriceListImport.ReadCredentials(out AUser, APassword: string): Boolean;
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
begin
  AUser := '';
  APassword := '';

  Tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := FConnection;
    // nu prin Params: IBDAC pune deja isc_tpb_write in TPB, iar 'read' dupa el da eroare
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Tr.StartTransaction;

    q.Connection := FConnection;
    q.Transaction := Tr;
    q.SQL.Text := 'select PARAM_NAME, PARAM_VALUE from TS_API_CONFIG ' +
      'where API_CODE = ''' + cApiCode + ''' and FLG_ACTIVE = 1';
    q.Open;
    while not q.Eof do
    begin
      if SameText(Trim(q.FieldByName('PARAM_NAME').AsString), 'USERNAME') then
        AUser := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Trim(q.FieldByName('PARAM_NAME').AsString), 'PASSWORD') then
        APassword := Trim(q.FieldByName('PARAM_VALUE').AsString);
      q.Next;
    end;
    q.Close;
    Tr.Commit;
  finally
    q.Free;
    Tr.Free;
  end;

  Result := (AUser <> '') and (APassword <> '');
end;

procedure TDMLinkPriceListImport.Idle(const AText: string);
begin
  if Assigned(FOnProgress) and (AText <> '') then
    FOnProgress(AText);
  if Assigned(FOnWait) then
    FOnWait();
  Sleep(15);
end;

procedure TDMLinkPriceListImport.WaitThreads(const AThreads: TArray<TThread>; const AText: TFunc<string>);
var
  T: TThread;
begin
  for T in AThreads do
    while not T.Finished do
      if Assigned(AText) then
        Idle(AText())
      else
        Idle('');
end;

// URL-urile imaginilor deja salvate, pe cod (unite cu #10 in ordinea ORDERNO)
function LoadExistingImages(AConnection: TIBCConnection; ASupplierID: Integer): TDictionary<string, string>;
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
  Code, Urls: string;
begin
  Result := TDictionary<string, string>.Create;
  Tr := TIBCTransaction.Create(nil);
  q := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConnection;
    Tr.IsolationLevel := iblReadOnlyReadCommitted;
    Tr.StartTransaction;
    q.Connection := AConnection;
    q.Transaction := Tr;
    q.FetchAll := True;
    q.SQL.Text :=
      'select SUPPLIER_GOODS_CODE, IMAGE_URL from TS_PRICELIST_ITEMS_IMAGES ' +
      'where SUPPLIERID = :SUPPLIERID order by SUPPLIER_GOODS_CODE, ORDERNO';
    q.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
    q.Open;
    while not q.Eof do
    begin
      Code := Trim(q.Fields[0].AsString);
      if Result.TryGetValue(Code, Urls) then
        Result[Code] := Urls + #10 + Trim(q.Fields[1].AsString)
      else
        Result.Add(Code, Trim(q.Fields[1].AsString));
      q.Next;
    end;
    q.Close;
    Tr.Commit;
  finally
    q.Free;
    Tr.Free;
  end;
end;

function TDMLinkPriceListImport.Execute: TDMLinkImportResult;
var
  User, Password, DownloadError, Urls: string;
  Body: TBytes;
  BodyLen, ArrayStart, ParseCount, NextSpan, Invalid, I, J, K: Integer;
  Spans: TArray<TJsonSpan>;
  Parsed: TArray<TDMLinkProduct>;
  ParsedOk: TArray<Boolean>;
  Existing: TDictionary<string, string>;
  SkuCount: TDictionary<string, Integer>;
  Products: TList<TDMLinkProduct>;
  Dups: TStringList;
  Pair: TPair<string, Integer>;
  Threads: TArray<TThread>;
  Watch: TStopwatch;
  Job: TDMLinkSaveJob;
  Tr: TIBCTransaction;
  qMaster: TIBCQuery;
  AllCommitted: Boolean;
  Errors: string;
begin
  Result := Default(TDMLinkImportResult);

  if not ReadCredentials(User, Password) then
    raise Exception.Create('Lipsesc credentialele pentru API-ul DMLINK. Completati randurile ' +
      'USERNAME si PASSWORD in TS_API_CONFIG (meniul Setari > Configurari API).');

  Existing := nil;
  SkuCount := nil;
  Products := nil;
  try
    // 1. descarcarea in fir separat; intre timp imaginile existente din baza
    Watch := TStopwatch.StartNew;
    DownloadError := '';
    SetLength(Threads, 1);
    Threads[0] := TDMLinkWorker.Create(
      procedure(AIndex: Integer)
      begin
        Body := DownloadCatalog(User, Password);
      end, 0);
    try
      Idle('DMLink: descarcarea catalogului...');
      Existing := LoadExistingImages(FConnection, FSupplierID);
      WaitThreads(Threads,
        function: string
        begin
          Result := Format('DMLink: descarcarea catalogului... %d s', [Watch.ElapsedMilliseconds div 1000]);
        end);
      DownloadError := TDMLinkWorker(Threads[0]).Error;
    finally
      Threads[0].WaitFor;
      Threads[0].Free;
    end;
    if DownloadError <> '' then
      raise Exception.Create(DownloadError);
    Result.DownloadMs := Watch.ElapsedMilliseconds;

    // 2. parsarea, pe elemente, in fire
    Watch := TStopwatch.StartNew;
    Idle('DMLink: parsarea raspunsului...');
    BodyLen := Length(Body);
    ArrayStart := FindProductsArray(Body, BodyLen);
    if ArrayStart < 0 then
      raise Exception.Create('Nu s-a gasit lista de produse in raspunsul API-ului DMLink.' + sLineBreak +
        TEncoding.UTF8.GetString(Body, 0, Min(BodyLen, 300)));
    Spans := SplitArray(Body, ArrayStart, BodyLen);
    ParseCount := Length(Spans);
    SetLength(Parsed, ParseCount);
    SetLength(ParsedOk, ParseCount);
    NextSpan := 0;
    Result.ParseThreads := EnsureRange(TThread.ProcessorCount, 1, cMaxParseThreads);
    Result.ParseThreads := Min(Result.ParseThreads, Max(1, ParseCount div cParseChunk));

    SetLength(Threads, Result.ParseThreads);
    for I := 0 to High(Threads) do
      Threads[I] := TDMLinkWorker.Create(
        procedure(AIndex: Integer)
        var
          From, N: Integer;
          V: TJSONValue;
        begin
          while True do
          begin
            From := TInterlocked.Add(NextSpan, cParseChunk) - cParseChunk;
            if From >= ParseCount then
              Break;
            for N := From to Min(From + cParseChunk, ParseCount) - 1 do
            begin
              // al treilea parametru e pozitia de sfirsit (absoluta), nu lungimea
              V := TJSONObject.ParseJSONValue(Body, Spans[N].Offset, Spans[N].Offset + Spans[N].Length, True);
              try
                ParsedOk[N] := (V is TJSONObject) and ParseProduct(TJSONObject(V), Parsed[N]);
              finally
                V.Free;
              end;
            end;
          end;
        end, I);
    try
      WaitThreads(Threads, nil);
      for I := 0 to High(Threads) do
        if TDMLinkWorker(Threads[I]).Error <> '' then
          raise Exception.Create('Parsarea raspunsului DMLink: ' + TDMLinkWorker(Threads[I]).Error);
    finally
      for I := 0 to High(Threads) do
      begin
        Threads[I].WaitFor;
        Threads[I].Free;
      end;
    end;
    Body := nil;
    Spans := nil;

    // sku-urile repetate (PK TS_PRICELIST_ITEMS = PLID + cod); dupa Trim, pentru ca
    // Firebird ignora spatiile de la sfirsit la comparare ("Black" = "Black ")
    SkuCount := TDictionary<string, Integer>.Create;
    Invalid := 0;
    for I := 0 to ParseCount - 1 do
      if ParsedOk[I] and (Parsed[I].Stock > 0) then
      begin
        if SkuCount.TryGetValue(Parsed[I].SKU, J) then
          SkuCount[Parsed[I].SKU] := J + 1
        else
          SkuCount.Add(Parsed[I].SKU, 1);
      end
      else if not ParsedOk[I] then
        Inc(Invalid);
    Result.InvalidProducts := Invalid;

    Products := TList<TDMLinkProduct>.Create;
    Products.Capacity := ParseCount;
    for I := 0 to ParseCount - 1 do
      if ParsedOk[I] then
      begin
        if Parsed[I].Stock <= 0 then
          Inc(Result.OutOfStockProducts)
        else if SkuCount[Parsed[I].SKU] > 1 then
          Inc(Result.DuplicateProducts)
        else
          Products.Add(Parsed[I]);
      end;
    Parsed := nil;
    ParsedOk := nil;

    Dups := TStringList.Create;
    try
      Dups.Sorted := True;
      for Pair in SkuCount do
        if Pair.Value > 1 then
          Dups.Add(Format('%s (x%d)', [Pair.Key, Pair.Value]));
      Dups.StrictDelimiter := True;
      Dups.Delimiter := ',';
      Result.DuplicateCodes := StringReplace(Dups.DelimitedText, ',', ', ', [rfReplaceAll]);
    finally
      Dups.Free;
    end;

    if Products.Count = 0 then
      raise Exception.Create('API-ul DMLink nu a intors niciun produs.');
    Result.ParseMs := Watch.ElapsedMilliseconds;

    // 3. scrierea: antetul se comite separat (firele il vad prin FK doar dupa COMMIT)
    Watch := TStopwatch.StartNew;
    Idle('DMLink: crearea pricelistului...');
    Tr := TIBCTransaction.Create(nil);
    qMaster := TIBCQuery.Create(nil);
    try
      Tr.DefaultConnection := FConnection;
      Tr.StartTransaction;
      try
        qMaster.Connection := FConnection;
        qMaster.Transaction := Tr;
        qMaster.AutoCommit := False;
        qMaster.SQL.Text :=
          'insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, FLAGS, MENTIUNI) ' +
          'values (:SUPPLIERID, :PRICE_CATEGORYID, :FLAGS, :MENTIUNI) returning PLID';
        qMaster.ParamByName('SUPPLIERID').AsInteger := FSupplierID;
        qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := FPriceCategoryID;
        qMaster.ParamByName('FLAGS').AsInteger := cFLG_API;
        qMaster.ParamByName('MENTIUNI').AsString := 'Import automat DMLink API';
        qMaster.Options.ReturnParams := True;
        qMaster.ParamCheck := True;
        qMaster.Execute;
        Result.PLID := qMaster.ParamByName('RET_PLID').AsInteger;
        Tr.Commit;
      except
        if Tr.Active then
          Tr.Rollback;
        raise;
      end;
    finally
      qMaster.Free;
      Tr.Free;
    end;

    Result.DbThreads := cDbThreadCount;
    Job := TDMLinkSaveJob.Create(cDbThreadCount);
    try
      Job.Template := TIBCConnection.Create(nil);
      Job.Template.Assign(FConnection);
      Job.Template.Params.Assign(FConnection.Params);
      // evenimentele conexiunii principale (dialoguri, VCL) nu au ce cauta in fire
      Job.Template.LoginPrompt := False;
      Job.Template.ConnectDialog := nil;
      Job.Template.OnError := nil;
      Job.Template.OnLogin := nil;
      Job.Template.BeforeConnect := nil;
      Job.Template.AfterConnect := nil;
      Job.Template.BeforeDisconnect := nil;
      Job.Template.AfterDisconnect := nil;
      Job.PLID := Result.PLID;
      Job.SupplierID := FSupplierID;
      Job.Products := Products.ToArray;
      SetLength(Job.ImagesChanged, Length(Job.Products));
      for I := 0 to High(Job.Products) do
        if Length(Job.Products[I].Images) > 0 then
        begin
          Inc(Result.ProductsWithImages);
          if not Existing.TryGetValue(Job.Products[I].SKU, Urls) or
             (Urls <> string.Join(#10, Job.Products[I].Images)) then
          begin
            Job.ImagesChanged[I] := True;
            Inc(Result.ImagesChanged);
          end;
        end;

      SetLength(Threads, cDbThreadCount);
      for I := 0 to High(Threads) do
        Threads[I] := nil;
      try
        for I := 0 to High(Threads) do
          Threads[I] := TDMLinkWorker.Create(Job.Work, I);

        // progresul, pina cind toate firele termina INSERT-urile
        K := Length(Job.Products);
        while Job.InsertPhaseLeft.WaitFor(0) <> wrSignaled do
          Idle(Format('DMLink: salvare %d / %d (%d fire)',
            [TInterlocked.CompareExchange(Job.Saved, 0, 0), K, cDbThreadCount]));

        // totul sau nimic: COMMIT doar daca toate firele au reusit
        Job.CommitAll := not Job.HasFailed;
        Job.Decision.SetEvent;
        Idle('DMLink: COMMIT...');
      finally
        // la o exceptie neasteptata firele trebuie deblocate (ROLLBACK) inainte de eliberarea Job
        if Job.Decision.WaitFor(0) <> wrSignaled then
        begin
          Job.CommitAll := False;
          Job.Decision.SetEvent;
        end;
        for I := 0 to High(Threads) do
          if Assigned(Threads[I]) then
          begin
            Threads[I].WaitFor;
            Threads[I].Free;
          end;
      end;

      Errors := '';
      AllCommitted := True;
      for I := 0 to cDbThreadCount - 1 do
      begin
        if Job.Errors[I] <> '' then
          Errors := Errors + sLineBreak + Format('fir %d: %s', [I + 1, Job.Errors[I]]);
        AllCommitted := AllCommitted and Job.Committed[I];
      end;

      if not AllCommitted then
      begin
        // un fir a cazut (restul au dat ROLLBACK) sau un COMMIT a esuat - nu lasam pricelist partial
        Tr := TIBCTransaction.Create(nil);
        qMaster := TIBCQuery.Create(nil);
        try
          try
            Tr.DefaultConnection := FConnection;
            Tr.StartTransaction;
            qMaster.Connection := FConnection;
            qMaster.Transaction := Tr;
            qMaster.SQL.Text := 'delete from TS_PRICELISTS where PLID = :PLID';
            qMaster.ParamByName('PLID').AsInteger := Result.PLID;
            qMaster.Execute;
            Tr.Commit;
          except
            // eroarea initiala e mai importanta; pricelist-ul ramas se poate sterge manual
            if Tr.Active then
              Tr.Rollback;
          end;
        finally
          qMaster.Free;
          Tr.Free;
        end;
        raise Exception.Create('Pricelist-ul DMLink nu a fost creat.' + Errors);
      end;

      Result.ProductsImported := Job.Saved;
      Result.Descriptions := Job.Descriptions;
      Result.ImageRows := Job.ImageRows;
    finally
      Job.Template.Free;
      Job.Free;
    end;
    Result.SaveMs := Watch.ElapsedMilliseconds;
  finally
    Products.Free;
    SkuCount.Free;
    Existing.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ imaginile (fire + fereastra de progres din MamicoContentUnit)                  }
{ ---------------------------------------------------------------------------- }

procedure TDMLinkImageFilter.FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := GDMLinkImages.ContainsKey(Trim(DataSet.FieldByName('SUPPLIER_GOODS_CODE').AsString));
end;

// ruleaza in firele de lucru: doar descarca imaginile deja cunoscute din API
// Imaginile unui cod. Fiecare imagine are cDMLinkImageAttempts incercari: serverul DMLink
// pierde uneori cereri minute in sir (5 oct 2026, 14:15-14:21: ~2 200 de coduri ramase fara
// imagini). Daca nu vine nicio imagine, codul e raportat ca eroare (Found = False) si
// randurile lui nu se rescriu - raman nedescarcate pentru rularea urmatoare.
function DMLinkFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
const
  cDMLinkImageAttempts = 3;
var
  Urls: TArray<string>;
  I, Attempt, Loaded: Integer;
begin
  Result := TMamicoItemResult.Create(ACode);
  if not GDMLinkImages.TryGetValue(ACode, Urls) or (Length(Urls) = 0) then
  begin
    Result.Log.Add(Format('%s: fara imagini in API', [ACode]));
    Exit;
  end;

  Result.ImageUrls := Urls;
  SetLength(Result.ImageData, Length(Urls));
  Loaded := 0;
  for I := 0 to High(Urls) do
  begin
    for Attempt := 1 to cDMLinkImageAttempts do
    begin
      Result.ImageData[I] := ContentGetBytes(AHttp, Urls[I]);
      if Length(Result.ImageData[I]) > 0 then
        Break;
      if Attempt < cDMLinkImageAttempts then
        Sleep(1000 * Attempt);
    end;
    if Length(Result.ImageData[I]) > 0 then
      Inc(Loaded)
    else
      Result.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata (%d incercari)',
        [ACode, Urls[I], cDMLinkImageAttempts]));
  end;
  Result.Found := Loaded > 0;
  if not Result.Found then
    Result.Log.Add(Format('%s: EROARE nicio imagine descarcata - ramine pentru rularea urmatoare', [ACode]));
end;

// GDMLinkImages = cod -> URL-urile imaginilor (ordinea ORDERNO), doar codurile furnizorului cu
// cel putin un rand fara IMAGE
procedure LoadPendingImages(AConnection: TIBCConnection; ASupplierID: Integer);
var
  Query: TIBCQuery;
  Lists: TDictionary<string, TList<string>>;
  Pending: TDictionary<string, Boolean>;
  List: TList<string>;
  Code: string;
begin
  GDMLinkImages := TDictionary<string, TArray<string>>.Create;
  Lists := TDictionary<string, TList<string>>.Create;
  Pending := TDictionary<string, Boolean>.Create;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := AConnection;
    Query.FetchAll := True;
    Query.SQL.Text :=
      'select SUPPLIER_GOODS_CODE, IMAGE_URL, iif(IMAGE is null, 1, 0) as NO_IMAGE ' +
      'from TS_PRICELIST_ITEMS_IMAGES where SUPPLIERID = :SUPPLIERID ' +
      'order by SUPPLIER_GOODS_CODE, ORDERNO';
    Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
    Query.Open;
    while not Query.Eof do
    begin
      Code := Trim(Query.Fields[0].AsString);
      if not Lists.TryGetValue(Code, List) then
      begin
        List := TList<string>.Create;
        Lists.Add(Code, List);
      end;
      List.Add(Trim(Query.Fields[1].AsString));
      if Query.Fields[2].AsInteger = 1 then
        Pending.AddOrSetValue(Code, True);
      Query.Next;
    end;
    Query.Close;

    for Code in Pending.Keys do
      GDMLinkImages.Add(Code, Lists[Code].ToArray);
  finally
    Query.Free;
    for List in Lists.Values do
      List.Free;
    Lists.Free;
    Pending.Free;
  end;
end;

class procedure TDMLinkPriceListImport.DownloadImages(AConnection: TIBCConnection; APLID, ASupplierID: Integer);
var
  Filter: TDMLinkImageFilter;
  Query: TIBCQuery;
begin
  Filter := TDMLinkImageFilter.Create;
  Query := TIBCQuery.Create(nil);
  try
    LoadPendingImages(AConnection, ASupplierID);
    if GDMLinkImages.Count = 0 then
      Exit;

    Query.Connection := AConnection;
    Query.SQL.Text :=
      'select SUPPLIER_GOODS_CODE, PRODUCT_LINK from TS_PRICELIST_ITEMS ' +
      'where PLID = :PLID order by SUPPLIER_GOODS_CODE';
    Query.ParamByName('PLID').AsInteger := APLID;
    Query.OnFilterRecord := Filter.FilterRecord;
    Query.Filtered := True;
    Query.Open;

    // Query are deja doar codurile cu imagini nedescarcate (inclusiv cele cu o parte din imagini,
    // pe care modul "doar fara continut" le-ar sari); fisiere statice - fara pauza intre cereri
    TMamicoContentLoader.RunForPriceItemsEx(Query, AConnection, ASupplierID, DMLinkFetch, 'DMLink API',
      False, 0);
  finally
    Query.Free;
    Filter.Free;
    FreeAndNil(GDMLinkImages);
  end;
end;

class function TDMLinkPriceListImport.DownloadImagesSilent(AConnection: TIBCConnection; APLID: Integer;
  const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>; ASupplierID, AThreadCount: Integer): Integer;
var
  Query: TIBCQuery;
  Codes: TList<string>;
  Code: string;
begin
  Codes := TList<string>.Create;
  Query := TIBCQuery.Create(nil);
  try
    LoadPendingImages(AConnection, ASupplierID);
    // doar articolele pricelistului APLID care au imagini nedescarcate
    Query.Connection := AConnection;
    Query.FetchAll := True;
    Query.SQL.Text := 'select SUPPLIER_GOODS_CODE from TS_PRICELIST_ITEMS where PLID = :PLID';
    Query.ParamByName('PLID').AsInteger := APLID;
    Query.Open;
    while not Query.Eof do
    begin
      Code := Trim(Query.Fields[0].AsString);
      if GDMLinkImages.ContainsKey(Code) then
        Codes.Add(Code);
      Query.Next;
    end;
    Query.Close;
    // imaginile vin direct de pe b2b.dmlink.md (fisiere statice) - fara pauza intre cereri
    Result := TMamicoContentLoader.RunForItemsSilent(Codes.ToArray, nil, AConnection, ASupplierID,
      DMLinkFetch, False, AThreadCount, 0, AOnLog, AIsCancelled);
  finally
    Query.Free;
    Codes.Free;
    FreeAndNil(GDMLinkImages);
  end;
end;

initialization
  GInvariant := TFormatSettings.Invariant;

end.

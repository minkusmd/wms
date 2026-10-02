unit TriomacPriceListUnit;

(*
  Pricelist de la TRIOMAC SRL (CustomerID 209280) prin API-ul SCOP (https://api.scop.md):
    POST /api/account/login     {email, password}                -> accessToken
    POST /api/shop-products     {accessToken, Page, Limit}       (header Authorization: Bearer)
                                -> items[], pages, total

  Datele de acces din TS_API_CONFIG, API_CODE = 'SCOP' (meniul Setari > Configurari API):
    USERNAME (email), PASSWORD, optional BASE_URL.

  Se iau produsele cu stoc (stockQuantity > 0) si sku completat; intr-o singura tranzactie
  (totul sau nimic):
    TS_PRICELISTS       - pricelist nou (FLAGS = 2 = FLG_API);
    TS_PRICELIST_ITEMS  - sku -> SUPPLIER_GOODS_CODE, name, brand.name, stockQuantity,
                          categoriile (cale "A / B / C") -> SUPPLIER_CATEGORY;
                          calculatedProductPrice.priceUsd -> PRICE7 (USD);
                          rrpPrice.value/currency -> PRICE3 (MDL sau USD).

  PRICE0: regula este ca, daca furnizorul da un pret de cost separat, el se pune in PRICE0.
  API-ul SCOP NU are un astfel de camp (verificat 2 oct 2026 pe 1500 de produse: "price" la
  nivelul produsului e mereu 0, calculatedProductPrice are doar priceUsd/price si oldPriceUsd -
  pretul vechi la produsele in promotie), deci PRICE0 = PRICE7 = priceUsd.

  Inlocuieste fluxul din frame121APIScopUnit (citire in grid + parola scrisa in cod).
*)

interface

uses
  System.SysUtils, System.Classes, IBC;

const
  cTriomacSupplierID = 209280;
  cScopApiCode = 'SCOP';

type
  TTriomacPriceListImport = class
  public
    // descarca catalogul si creeaza pricelistul; intoarce PLID-ul creat.
    // Arunca Exception la date de acces lipsa, autentificare esuata sau raspuns invalid -
    // in acest caz nu se creeaza nimic.
    class function Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;
  end;

implementation

uses
  System.JSON, System.Generics.Collections, System.Net.HttpClient, System.Net.URLClient,
  System.UITypes, System.StrUtils, Vcl.Forms, Vcl.Controls, Vcl.Dialogs, IBCClasses;

const
  cDefaultBaseUrl = 'https://api.scop.md';
  // cu paginare (sort 'default') API-ul repeta produse intre pagini si sare altele (2 oct 2026:
  // 2014 distincte din 2238 la Limit=500); cu Limit=5000 vine tot catalogul intr-o pagina
  cPageLimit = 5000;
  cMaxPages = 200;
  cCurrencyMDL = 498;
  cCurrencyUSD = 840;
  cFLG_API = 2;

type
  TTriomacProduct = record
    Sku: string;
    Name: string;
    Brand: string;
    Category: string;
    Stock: Integer;
    PriceUsd: Double;
    Rrp: Double;
    RrpCurrencyID: Integer;
  end;

  TTriomacStats = record
    Total: Integer;
    NoStock: Integer;
    NoSku: Integer;
    Duplicates: Integer;
    DuplicateCodes: string;
    NoPrice: Integer;
    Promo: Integer;
  end;

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

// calea categoriilor, in ordinea din API ("PARINTE / COPIL / ...")
function CategoryPath(AObj: TJSONObject): string;
var
  V, Item: TJSONValue;
  Name: string;
begin
  Result := '';
  V := JValue(AObj, 'categories');
  if not (V is TJSONArray) then
    Exit;
  for Item in TJSONArray(V) do
    if Item is TJSONObject then
    begin
      Name := JStr(TJSONObject(Item), 'name');
      if Name <> '' then
        if Result = '' then
          Result := Name
        else
          Result := Result + ' / ' + Name;
    end;
end;

function RrpCurrencyID(const ACurrency: string): Integer;
begin
  if SameText(ACurrency, 'USD') or (ACurrency = '840') then
    Result := cCurrencyUSD
  else
    Result := cCurrencyMDL; // API-ul da "MDL"; frame121 presupunea tot 498 implicit
end;

{ ---------------------------------------------------------------------------- }
{ API                                                                            }
{ ---------------------------------------------------------------------------- }

procedure ReadApiConfig(AConnection: TIBCConnection; out AUser, APassword, ABaseUrl: string);
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
  Name: string;
begin
  AUser := '';
  APassword := '';
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
    q.ParamByName('API_CODE').AsString := cScopApiCode;
    q.Open;
    while not q.Eof do
    begin
      Name := Trim(q.FieldByName('PARAM_NAME').AsString);
      if SameText(Name, 'USERNAME') then
        AUser := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'PASSWORD') then
        APassword := Trim(q.FieldByName('PARAM_VALUE').AsString)
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

// POST cu corp JSON; intoarce obiectul JSON din raspuns (apelantul il elibereaza)
function PostJson(AHttp: THTTPClient; const AUrl: string; ABody: TJSONObject;
  const ABearer: string): TJSONObject;
var
  Source: TStringStream;
  Headers: TNetHeaders;
  Response: IHTTPResponse;
  Text: string;
  V: TJSONValue;
begin
  Source := TStringStream.Create(ABody.ToJSON, TEncoding.UTF8);
  try
    Headers := [TNetHeader.Create('Content-Type', 'application/json; charset=UTF-8'),
      TNetHeader.Create('Accept', 'application/json')];
    if ABearer <> '' then
      Headers := Headers + [TNetHeader.Create('Authorization', 'Bearer ' + ABearer)];
    Response := AHttp.Post(AUrl, Source, nil, Headers);
  finally
    Source.Free;
  end;

  Text := Response.ContentAsString(TEncoding.UTF8);
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt('API SCOP: %s -> HTTP %d %s' + sLineBreak + '%s',
      [AUrl, Response.StatusCode, Response.StatusText, Copy(Text, 1, 500)]);

  V := TJSONObject.ParseJSONValue(Text);
  if not (V is TJSONObject) then
  begin
    V.Free;
    raise Exception.CreateFmt('API SCOP: %s - raspunsul nu este un obiect JSON:' + sLineBreak + '%s',
      [AUrl, Copy(Text, 1, 500)]);
  end;
  Result := TJSONObject(V);
end;

function Login(AHttp: THTTPClient; const ABaseUrl, AUser, APassword: string): string;
var
  Body, Root: TJSONObject;
begin
  Body := TJSONObject.Create;
  try
    Body.AddPair('email', AUser);
    Body.AddPair('password', APassword);
    Root := PostJson(AHttp, ABaseUrl + '/api/account/login', Body, '');
    try
      Result := JStr(Root, 'accessToken');
    finally
      Root.Free;
    end;
  finally
    Body.Free;
  end;
  if Result = '' then
    raise Exception.Create('API SCOP: autentificarea nu a intors accessToken - verificati USERNAME / ' +
      'PASSWORD in Setari > Configurari API (API_CODE = ' + cScopApiCode + ').');
end;

procedure ParseItem(AItem: TJSONObject; AProducts: TList<TTriomacProduct>;
  ASeen: TDictionary<string, Boolean>; var AStats: TTriomacStats);
var
  P: TTriomacProduct;
  Price, Rrp: TJSONObject;
begin
  Inc(AStats.Total);
  P := Default(TTriomacProduct);
  P.Sku := JStr(AItem, 'sku');
  if P.Sku = '' then
  begin
    Inc(AStats.NoSku);
    Exit;
  end;
  P.Stock := Trunc(JFloat(AItem, 'stockQuantity'));
  if P.Stock <= 0 then
  begin
    Inc(AStats.NoStock);
    Exit;
  end;
  // SCOP are si sku generice (ex. 'Switch', 'Adapter') la produse diferite; ramane primul,
  // ca in importul vechi din frame121, iar codurile se arata in mesajul final
  if ASeen.ContainsKey(P.Sku) then
  begin
    Inc(AStats.Duplicates);
    if Pos(#13#10 + P.Sku + ';', #13#10 + AStats.DuplicateCodes) = 0 then
      AStats.DuplicateCodes := AStats.DuplicateCodes + P.Sku + ';' + #13#10;
    Exit;
  end;

  Price := JObj(AItem, 'calculatedProductPrice');
  P.PriceUsd := JFloat(Price, 'priceUsd');
  if P.PriceUsd <= 0 then
  begin
    Inc(AStats.NoPrice);
    Exit;
  end;
  if JFloat(Price, 'oldPriceUsd') > 0 then
    Inc(AStats.Promo);

  Rrp := JObj(AItem, 'rrpPrice');
  P.Rrp := JFloat(Rrp, 'value');
  P.RrpCurrencyID := RrpCurrencyID(JStr(Rrp, 'currency'));

  P.Name := JStr(AItem, 'name');
  P.Brand := JStr(JObj(AItem, 'brand'), 'name');
  P.Category := CategoryPath(AItem);

  ASeen.Add(P.Sku, True);
  AProducts.Add(P);
end;

procedure DownloadCatalog(const ABaseUrl, AUser, APassword: string; AProducts: TList<TTriomacProduct>;
  var AStats: TTriomacStats);
var
  Http: THTTPClient;
  Token: string;
  Body, Root: TJSONObject;
  Items: TJSONValue;
  Item: TJSONValue;
  Page, Pages: Integer;
  Seen: TDictionary<string, Boolean>;
begin
  Http := THTTPClient.Create;
  Seen := TDictionary<string, Boolean>.Create;
  try
    Http.ConnectionTimeout := 30000;
    Http.ResponseTimeout := 120000;
    Token := Login(Http, ABaseUrl, AUser, APassword);

    Page := 1;
    repeat
      Body := TJSONObject.Create;
      try
        Body.AddPair('accessToken', Token);
        Body.AddPair('Page', IntToStr(Page));
        Body.AddPair('Limit', IntToStr(cPageLimit));
        Root := PostJson(Http, ABaseUrl + '/api/shop-products', Body, Token);
      finally
        Body.Free;
      end;
      try
        Pages := Trunc(JFloat(Root, 'pages'));
        Items := JValue(Root, 'items');
        if not (Items is TJSONArray) then
          raise Exception.CreateFmt('API SCOP: pagina %d nu contine "items".', [Page]);
        for Item in TJSONArray(Items) do
          if Item is TJSONObject then
            ParseItem(TJSONObject(Item), AProducts, Seen, AStats);
      finally
        Root.Free;
      end;
      Inc(Page);
      Application.ProcessMessages;
    until (Page > Pages) or (Page > cMaxPages);
  finally
    Seen.Free;
    Http.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ baza                                                                           }
{ ---------------------------------------------------------------------------- }

function SavePriceList(AConnection: TIBCConnection; APriceCategoryID: Integer;
  AProducts: TList<TTriomacProduct>): Integer;
var
  Tr: TIBCTransaction;
  qMaster, qItem: TIBCQuery;
  P: TTriomacProduct;
begin
  Tr := TIBCTransaction.Create(nil);
  qMaster := TIBCQuery.Create(nil);
  qItem := TIBCQuery.Create(nil);
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
      qMaster.ParamByName('SUPPLIERID').AsInteger := cTriomacSupplierID;
      qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := APriceCategoryID;
      qMaster.ParamByName('FLAGS').AsInteger := cFLG_API;
      qMaster.ParamByName('MENTIUNI').AsString := 'Import automat SCOP API (Triomac)';
      qMaster.Options.ReturnParams := True;
      qMaster.ParamCheck := True;
      qMaster.Execute;
      Result := qMaster.ParamByName('RET_PLID').AsInteger;

      qItem.Connection := AConnection;
      qItem.Transaction := Tr;
      qItem.AutoCommit := False;
      qItem.SQL.Text :=
        'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
        'SUPPLIER_GOODS_BRAND, STOCK_QTY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, ' +
        'CURRENCY7ID, SUPPLIER_CATEGORY) ' +
        'values (:PLID, :SUPPLIER_GOODS_CODE, :SUPPLIER_GOODS_NAME, :SUPPLIER_GOODS_BRAND, ' +
        ':STOCK_QTY, :PRICE0, :CURRENCY0ID, :PRICE3, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, ' +
        ':SUPPLIER_CATEGORY)';

      for P in AProducts do
      begin
        qItem.ParamByName('PLID').AsInteger := Result;
        qItem.ParamByName('SUPPLIER_GOODS_CODE').AsString := Copy(P.Sku, 1, 128);
        qItem.ParamByName('SUPPLIER_GOODS_NAME').AsString := Copy(P.Name, 1, 2048);
        qItem.ParamByName('SUPPLIER_GOODS_BRAND').AsString := Copy(P.Brand, 1, 128);
        qItem.ParamByName('STOCK_QTY').AsString := IntToStr(P.Stock);
        // fara pret de cost in API: PRICE0 = indicativul (vezi comentariul din antet)
        qItem.ParamByName('PRICE0').AsFloat := P.PriceUsd;
        qItem.ParamByName('CURRENCY0ID').AsInteger := cCurrencyUSD;
        qItem.ParamByName('PRICE3').AsFloat := P.Rrp;
        qItem.ParamByName('CURRENCY3ID').AsInteger := P.RrpCurrencyID;
        qItem.ParamByName('PRICE7').AsFloat := P.PriceUsd;
        qItem.ParamByName('CURRENCY7ID').AsInteger := cCurrencyUSD;
        qItem.ParamByName('SUPPLIER_CATEGORY').AsString := Copy(P.Category, 1, 512);
        qItem.Execute;
      end;

      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  finally
    qItem.Free;
    qMaster.Free;
    Tr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TTriomacPriceListImport                                                        }
{ ---------------------------------------------------------------------------- }

class function TTriomacPriceListImport.Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;
var
  User, Password, BaseUrl: string;
  Products: TList<TTriomacProduct>;
  Stats: TTriomacStats;
begin
  ReadApiConfig(AConnection, User, Password, BaseUrl);
  if (User = '') or (Password = '') then
    raise Exception.Create('Lipsesc datele de acces la API-ul SCOP (Triomac).' + sLineBreak +
      'Adaugati in Setari > Configurari API, API_CODE = ' + cScopApiCode + ' (furnizor ' +
      IntToStr(cTriomacSupplierID) + '), parametrii USERNAME (email-ul contului scop.md) si PASSWORD.');

  Stats := Default(TTriomacStats);
  Products := TList<TTriomacProduct>.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      DownloadCatalog(BaseUrl, User, Password, Products, Stats);
      if Products.Count = 0 then
        raise Exception.CreateFmt('API-ul SCOP nu a intors niciun produs cu stoc si pret ' +
          '(produse citite: %d).', [Stats.Total]);
      Result := SavePriceList(AConnection, APriceCategoryID, Products);
    finally
      Screen.Cursor := crDefault;
    end;

    MessageDlg(Format('Pricelist Triomac (SCOP) #%d creat:' + sLineBreak +
      '  produse in pricelist: %d (din %d citite)' + sLineBreak +
      '  sarite: fara stoc %d, fara cod %d, fara pret %d, coduri repetate %d' + sLineBreak +
      '  in promotie la furnizor: %d',
      [Result, Products.Count, Stats.Total, Stats.NoStock, Stats.NoSku, Stats.NoPrice, Stats.Duplicates,
       Stats.Promo]) +
      IfThen(Stats.DuplicateCodes <> '', sLineBreak + sLineBreak +
        'Coduri (sku) folosite de mai multe produse in SCOP - s-a pastrat primul produs:' + sLineBreak +
        Copy(Stats.DuplicateCodes, 1, 2000), ''), mtInformation, [mbOK], 0);
  finally
    Products.Free;
  end;
end;

end.

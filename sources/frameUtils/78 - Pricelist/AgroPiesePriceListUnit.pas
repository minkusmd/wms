unit AgroPiesePriceListUnit;

(*
  Pricelist de la AgroPiese TGR Grup (CustomerID 14805) prin API-ul B2B al site-ului
  angro.agropiese.md:
    GET https://angro.agropiese.md/api/v1/products?api_token=...&page-length=500&page=N
  Raspunsul e o paginare Laravel: current_page, last_page, total, data[] - 13758 rinduri,
  28 pagini a cite 500 (20 oct 2026). Produsul: id, sku, name (denumirea, in rusa),
  price_retail, price_engros (ambele in lei), properties[] (param_id, param_name_ro/ru,
  value_ro/ru), images[] (uri pe api.agro.md). Nu exista stoc, categorie sau descriere text.

  Datele de acces din TS_API_CONFIG, API_CODE = 'AGROPIESE' (meniul Setari > Configurari API):
    API_TOKEN, optional BASE_URL (DB Model\agropiese_api_config.sql).

  Se descarca tot catalogul si intra produsele cu pret engros; intr-o singura tranzactie
  (totul sau nimic):
    TS_PRICELISTS       - pricelist nou (FLAGS = 2 = FLG_API);
    TS_PRICELIST_ITEMS  - sku -> SUPPLIER_GOODS_CODE, name -> SUPPLIER_GOODS_NAME,
                          proprietatea "Brand" (param 17; altfel "Producator", 304) -> SUPPLIER_GOODS_BRAND,
                          price_engros -> PRICE0 = PRICE7, price_retail -> PRICE3 (toate MDL).
  Apoi, separat (ca la Triomac, prin TOlisGrupContent.SaveForSupplier), pentru TOATE produsele
  unice din catalog (si cele fara pret engros - pot fi legate de produse):
    TS_PRICELIST_ITEMS_DESCRIPTION - tabelul HTML al proprietatilor, RO / RU;
    TS_PRICELIST_ITEMS_IMAGES      - URL-urile images[], rescrise doar la produsele la care
                                     lista s-a schimbat.
  Raspunsul brut (toate produsele din toate paginile, un singur JSON array) se salveaza la fiecare
  descarcare a catalogului in %TEMP%\WMS_Api\agropiese_products_<data_ora>.json (pentru analiza
  in afara WMS); calea apare in rezumatul importului si in TAgroPiesePriceListImport.LastJsonFile.

  In WMS (Run) urmeaza descarcarea imaginilor (PNG in TS_PRICELIST_ITEMS_IMAGES.IMAGE) si
  copierea lor + a descrierilor la produsele legate (TS_GOODS_IMAGE / TS_GOODS_DSC) prin
  TPriceListContentTransfer. Butonul de continut din frame78 reciteste catalogul (LoadContent)
  si face aceiasi pasi fara pricelist nou.

  Rinduri repetate: in catalog acelasi produs (acelasi id) apare de mai multe ori chiar in
  aceeasi pagina (1963 rinduri din 13758; probabil un produs pe fiecare categorie a lui) -
  se tine prima aparitie. Mai exista produse diferite (id diferit) cu acelasi sku (~860):
  ramine primul produs, codurile apar in rezumat.

  price_engros = 0 la ~jumatate din catalog (5.5 mii din 10.9 mii de produse unice) - fara pret
  de achizitie produsul nu intra in pricelist (ca "fara pret" la Triomac); continutul lui se
  salveaza totusi. PRICE0: API-ul nu da un pret de cost separat, deci PRICE0 = PRICE7.
*)

interface

uses
  System.SysUtils, System.Classes, IBC, OlisGrupContentUnit;

const
  cAgroPieseSupplierID = 14805;
  cAgroPieseApiCode = 'AGROPIESE';
  cAgroPieseDefaultBaseURL = 'https://angro.agropiese.md/api/v1';
  // gazda imaginilor (api.agro.md) - numele afisat in fereastra de descarcare
  cAgroPieseImageSite = 'agro.md';

type
  TAgroPiesePriceListImport = class
  public
    // fisierul JSON cu catalogul brut scris la ultima descarcare (gol daca nu s-a putut scrie)
    class var LastJsonFile: string;

    // descarca catalogul, creeaza pricelistul, salveaza descrierile si URL-urile imaginilor,
    // apoi descarca imaginile si le copiaza la produsele legate; intoarce PLID-ul creat.
    // Arunca Exception la token lipsa, autentificare esuata sau raspuns invalid -
    // in acest caz nu se creeaza nimic.
    class function Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;

    // pricelistul + descrierile + URL-urile imaginilor fara interfata (WMSParsers, orice fir);
    // descarcarea imaginilor ramine apelantului. Rezumatul merge in AOnLog
    class function Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
      const AOnLog: TProc<string>): Integer;

    // doar continutul (descrierile RO/RU + URL-urile imaginilor) recitit din API, pentru toate
    // produsele unice din catalog - butonul de continut din frame78, fara pricelist nou
    class function LoadContent(AConnection: TIBCConnection;
      const AOnPage: TProc = nil): TArray<TOlisContentItem>;
  end;

implementation

uses
  System.Generics.Collections, System.UITypes, System.StrUtils, System.Math, System.JSON,
  System.NetEncoding, System.Net.HttpClient, System.Net.URLClient, System.IOUtils, Data.DB, Vcl.Forms,
  Vcl.Controls, Vcl.Dialogs, IBCClasses, B2B.DMLinkPriceListImport, PriceListContentTransferUnit;

const
  cCurrencyMDL = 498;
  cFLG_API = 2;
  cUserAgent = 'WMS-NeuronGrup/5.5 (Delphi)';
  // maximul admis de API (20..500)
  cPageLength = 500;
  // plasa de siguranta pentru paginare (azi 28 pagini)
  cMaxPages = 500;
  cMaxAttempts = 4;
  // subfolderul din %TEMP% in care se salveaza catalogul brut
  cJsonFolder = 'WMS_Api';
  // randuri trimise odata (IBDAC le imparte mai departe in EXECUTE BLOCK-uri)
  cBatchRows = 500;
  // param_id-urile proprietatilor cu marca
  cParamBrand = '17';
  cParamProducer = '304';

type
  TAgroProperty = record
    ParamID: string;
    NameRo, ValueRo: string;
    NameRu, ValueRu: string;
  end;

  TAgroProduct = record
    ID: Integer;
    Sku: string;
    Name: string;
    PriceRetail: Double;
    PriceEngros: Double;
    Properties: TArray<TAgroProperty>;
    Images: TArray<string>;
    function Brand: string;
  end;

  TAgroRow = record
    Sku: string;
    Name: string;
    Brand: string;
    Price: Double;
    Rrp: Double;
  end;

  TAgroStats = record
    // rinduri in catalog (cu repetari)
    Total: Integer;
    // acelasi produs (id) repetat in catalog
    Repeated: Integer;
    // produse unice (id)
    Products: Integer;
    NoSku: Integer;
    NoPrice: Integer;
    // produse diferite cu acelasi sku - ramine primul
    Duplicates: Integer;
    DuplicateCodes: string;
    NoRrp: Integer;
    Content: TOlisContentStats;
    // catalogul brut salvat pe disc (vezi antetul)
    JsonFile: string;
  end;

  TAgroConfig = record
    Token: string;
    BaseURL: string;
  end;

{ ---------------------------------------------------------------------------- }
{ JSON                                                                           }
{ ---------------------------------------------------------------------------- }

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if AObj = nil then
    Exit;
  V := AObj.GetValue(AName);
  if (V <> nil) and not (V is TJSONNull) and not (V is TJSONObject) and not (V is TJSONArray) then
    Result := Trim(V.Value);
end;

function JFloat(AObj: TJSONObject; const AName: string): Double;
var
  V: TJSONValue;
  FS: TFormatSettings;
begin
  Result := 0;
  if AObj = nil then
    Exit;
  V := AObj.GetValue(AName);
  if V is TJSONNumber then
    Result := TJSONNumber(V).AsDouble
  else if (V <> nil) and not (V is TJSONNull) then
  begin
    FS := TFormatSettings.Invariant;
    Result := StrToFloatDef(StringReplace(Trim(V.Value), ',', '.', [rfReplaceAll]), 0, FS);
  end;
end;

function JArr(AObj: TJSONObject; const AName: string): TJSONArray;
var
  V: TJSONValue;
begin
  Result := nil;
  if AObj = nil then
    Exit;
  V := AObj.GetValue(AName);
  if V is TJSONArray then
    Result := TJSONArray(V);
end;

function HtmlText(const AText: string): string;
begin
  Result := TNetEncoding.HTML.Encode(Trim(AText));
end;

{ ---------------------------------------------------------------------------- }
{ TAgroProduct                                                                   }
{ ---------------------------------------------------------------------------- }

function TAgroProduct.Brand: string;
var
  P: TAgroProperty;
  Producer: string;
begin
  Result := '';
  Producer := '';
  for P in Properties do
    if (P.ParamID = cParamBrand) and (P.ValueRo <> '') then
      Exit(P.ValueRo)
    else if (P.ParamID = cParamProducer) and (Producer = '') then
      Producer := P.ValueRo;
  Result := Producer;
end;

function ParseProduct(AObj: TJSONObject): TAgroProduct;
var
  Arr: TJSONArray;
  V: TJSONValue;
  Props: TList<TAgroProperty>;
  Imgs: TList<string>;
  P: TAgroProperty;
  Uri: string;
begin
  Result := Default(TAgroProduct);
  Result.ID := Trunc(JFloat(AObj, 'id'));
  Result.Sku := JStr(AObj, 'sku');
  Result.Name := JStr(AObj, 'name');
  Result.PriceRetail := JFloat(AObj, 'price_retail');
  Result.PriceEngros := JFloat(AObj, 'price_engros');

  Props := TList<TAgroProperty>.Create;
  Imgs := TList<string>.Create;
  try
    Arr := JArr(AObj, 'properties');
    if Assigned(Arr) then
      for V in Arr do
        if V is TJSONObject then
        begin
          P.ParamID := JStr(TJSONObject(V), 'param_id');
          P.NameRo := JStr(TJSONObject(V), 'param_name_ro');
          P.ValueRo := JStr(TJSONObject(V), 'value_ro');
          P.NameRu := JStr(TJSONObject(V), 'param_name_ru');
          P.ValueRu := JStr(TJSONObject(V), 'value_ru');
          if P.NameRu = '' then
            P.NameRu := P.NameRo;
          if P.ValueRu = '' then
            P.ValueRu := P.ValueRo;
          if (P.NameRo <> '') and (P.ValueRo <> '') then
            Props.Add(P);
        end;
    Arr := JArr(AObj, 'images');
    if Assigned(Arr) then
      for V in Arr do
        if V is TJSONObject then
        begin
          Uri := JStr(TJSONObject(V), 'uri');
          if (Uri <> '') and (Imgs.IndexOf(Uri) < 0) then
            Imgs.Add(Uri);
        end;
    Result.Properties := Props.ToArray;
    Result.Images := Imgs.ToArray;
  finally
    Imgs.Free;
    Props.Free;
  end;
end;

// proprietatile ca tabel HTML (ca la alo.md / pernamea.md) - descrierea RO sau RU
function BuildDescription(const AProps: TArray<TAgroProperty>; ARussian: Boolean): string;
var
  P: TAgroProperty;
  Rows: string;
begin
  Rows := '';
  for P in AProps do
    if ARussian then
      Rows := Rows + '<tr><td>' + HtmlText(P.NameRu) + '</td><td>' + HtmlText(P.ValueRu) + '</td></tr>'
    else
      Rows := Rows + '<tr><td>' + HtmlText(P.NameRo) + '</td><td>' + HtmlText(P.ValueRo) + '</td></tr>';
  if Rows = '' then
    Result := ''
  else
    Result := '<table>' + Rows + '</table>';
end;

{ ---------------------------------------------------------------------------- }
{ API                                                                            }
{ ---------------------------------------------------------------------------- }

function ReadConfig(AConnection: TIBCConnection): TAgroConfig;
var
  Tr: TIBCTransaction;
  q: TIBCQuery;
  Name: string;
begin
  Result := Default(TAgroConfig);
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
    q.ParamByName('API_CODE').AsString := cAgroPieseApiCode;
    q.Open;
    while not q.Eof do
    begin
      Name := Trim(q.FieldByName('PARAM_NAME').AsString);
      if SameText(Name, 'API_TOKEN') then
        Result.Token := Trim(q.FieldByName('PARAM_VALUE').AsString)
      else if SameText(Name, 'BASE_URL') then
        Result.BaseURL := Trim(q.FieldByName('PARAM_VALUE').AsString);
      q.Next;
    end;
    q.Close;
    Tr.Commit;
  finally
    q.Free;
    Tr.Free;
  end;

  if Result.Token = '' then
    raise Exception.Create('Lipseste tokenul API-ului angro.agropiese.md (AgroPiese TGR Grup).' + sLineBreak +
      'Adaugati in Setari > Configurari API, API_CODE = ' + cAgroPieseApiCode + ' (furnizor ' +
      IntToStr(cAgroPieseSupplierID) + '), parametrul API_TOKEN (DB Model\agropiese_api_config.sql).');
  if Result.BaseURL = '' then
    Result.BaseURL := cAgroPieseDefaultBaseURL;
  if EndsText('/', Result.BaseURL) then
    Delete(Result.BaseURL, Length(Result.BaseURL), 1);
end;

function ApiErrorText(APage, AStatus: Integer; ARoot: TJSONValue): string;
var
  Msg: string;
begin
  Msg := '';
  if ARoot is TJSONObject then
    Msg := JStr(TJSONObject(ARoot), 'message');
  Result := Format('API AgroPiese: pagina %d - HTTP %d', [APage, AStatus]);
  if Msg <> '' then
    Result := Result + ': ' + Msg;
  if AStatus = 401 then
    Result := Result + sLineBreak + 'Verificati API_TOKEN in Setari > Configurari API (API_CODE = ' +
      cAgroPieseApiCode + ').';
end;

// o pagina a catalogului; arunca Exception la raspuns invalid
function DownloadPage(AHttp: THTTPClient; const AConfig: TAgroConfig; APage: Integer): TJSONObject;
var
  Attempt, Status, Wait: Integer;
  Response: IHTTPResponse;
  Root: TJSONValue;
  Url, Text: string;
begin
  Url := Format('%s/products?api_token=%s&page-length=%d&page=%d',
    [AConfig.BaseURL, TNetEncoding.URL.EncodeQuery(AConfig.Token), cPageLength, APage]);
  Status := 0;
  Text := '';
  for Attempt := 1 to cMaxAttempts do
  begin
    try
      Response := AHttp.Get(Url, nil, [TNetHeader.Create('Accept', 'application/json')]);
      Status := Response.StatusCode;
      Text := Response.ContentAsString(TEncoding.UTF8);
    except
      on E: ENetException do
      begin
        if Attempt = cMaxAttempts then
          raise Exception.CreateFmt('API AgroPiese: pagina %d - %s', [APage, E.Message]);
        Sleep(2000 * Attempt);
        Continue;
      end;
    end;
    // limita de cereri sau eroare temporara a serverului - reincercam
    if ((Status = 429) or (Status >= 500)) and (Attempt < cMaxAttempts) then
    begin
      Wait := StrToIntDef(Trim(Response.HeaderValue['Retry-After']), 3 * Attempt);
      Sleep(EnsureRange(Wait, 1, 65) * 1000);
      Continue;
    end;
    Break;
  end;

  Root := TJSONObject.ParseJSONValue(Text);
  if (Status <> 200) or not (Root is TJSONObject) or (JArr(TJSONObject(Root), 'data') = nil) then
  begin
    try
      raise Exception.Create(ApiErrorText(APage, Status, Root));
    finally
      Root.Free;
    end;
  end;
  Result := TJSONObject(Root);
end;

// catalogul brut (toate produsele, un JSON array) -> %TEMP%\WMS_Api\agropiese_products_<data_ora>.json;
// intoarce calea sau '' daca scrierea a esuat (analiza e optionala, importul nu se opreste)
function SaveCatalogJson(AData: TJSONArray): string;
var
  Dir: string;
begin
  Result := '';
  try
    Dir := TPath.Combine(TPath.GetTempPath, cJsonFolder);
    TDirectory.CreateDirectory(Dir);
    Result := TPath.Combine(Dir, FormatDateTime('"agropiese_products_"yyyymmdd"_"hhnnss".json"', Now));
    TFile.WriteAllText(Result, AData.ToJSON, TEncoding.UTF8);
  except
    Result := '';
  end;
  TAgroPiesePriceListImport.LastJsonFile := Result;
end;

// tot catalogul, in ordinea API-ului (cu rindurile repetate); AJsonFile = catalogul brut salvat
procedure DownloadCatalog(AConnection: TIBCConnection; AProducts: TList<TAgroProduct>;
  const AOnPage: TProc; out AJsonFile: string);
var
  Config: TAgroConfig;
  Http: THTTPClient;
  Page, LastPage: Integer;
  Root: TJSONObject;
  V: TJSONValue;
  Raw: TJSONArray;
begin
  AJsonFile := '';
  Config := ReadConfig(AConnection);
  Http := THTTPClient.Create;
  Raw := TJSONArray.Create;
  try
    Http.UserAgent := cUserAgent;
    Http.ConnectionTimeout := 15000;
    Http.ResponseTimeout := 120000;
    Http.HandleRedirects := True;

    Page := 1;
    LastPage := 1;
    while (Page <= LastPage) and (Page <= cMaxPages) do
    begin
      Root := DownloadPage(Http, Config, Page);
      try
        if Page = 1 then
          LastPage := Max(1, Trunc(JFloat(Root, 'last_page')));
        for V in JArr(Root, 'data') do
          if V is TJSONObject then
          begin
            AProducts.Add(ParseProduct(TJSONObject(V)));
            Raw.AddElement(V.Clone as TJSONValue);
          end;
      finally
        Root.Free;
      end;
      if Assigned(AOnPage) then
        AOnPage;
      Inc(Page);
    end;
    AJsonFile := SaveCatalogJson(Raw);
  finally
    Raw.Free;
    Http.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ catalog -> randuri                                                             }
{ ---------------------------------------------------------------------------- }

// ARows poate fi nil (doar continutul)
procedure BuildRows(AProducts: TList<TAgroProduct>; ARows: TList<TAgroRow>;
  var AContent: TArray<TOlisContentItem>; var AStats: TAgroStats);
var
  P: TAgroProduct;
  R: TAgroRow;
  C: TOlisContentItem;
  SeenID: TDictionary<Integer, Boolean>;
  // sku (majuscule) -> id-ul produsului care l-a ocupat
  SeenSku: TDictionary<string, Integer>;
  Content: TList<TOlisContentItem>;
begin
  SeenID := TDictionary<Integer, Boolean>.Create;
  SeenSku := TDictionary<string, Integer>.Create;
  Content := TList<TOlisContentItem>.Create;
  try
    for P in AProducts do
    begin
      Inc(AStats.Total);
      // acelasi produs listat de mai multe ori (vezi antetul)
      if SeenID.ContainsKey(P.ID) then
      begin
        Inc(AStats.Repeated);
        Continue;
      end;
      SeenID.Add(P.ID, True);
      Inc(AStats.Products);

      if P.Sku = '' then
      begin
        Inc(AStats.NoSku);
        Continue;
      end;
      // produse diferite cu acelasi sku: ramine primul, codul apare in rezumat
      if SeenSku.ContainsKey(UpperCase(P.Sku)) then
      begin
        Inc(AStats.Duplicates);
        if Pos(#13#10 + P.Sku + ';', #13#10 + AStats.DuplicateCodes) = 0 then
          AStats.DuplicateCodes := AStats.DuplicateCodes + P.Sku + ';' + #13#10;
        Continue;
      end;
      SeenSku.Add(UpperCase(P.Sku), P.ID);

      // continutul - pentru toate produsele unice, cu sau fara pret engros
      C := Default(TOlisContentItem);
      C.Code := P.Sku;
      C.DescRo := BuildDescription(P.Properties, False);
      C.DescRu := BuildDescription(P.Properties, True);
      if C.DescRu = C.DescRo then
        C.DescRu := '';
      C.Images := P.Images;
      if (C.DescRo <> '') or (C.DescRu <> '') or (Length(C.Images) > 0) then
        Content.Add(C);

      if ARows = nil then
        Continue;
      if P.PriceEngros <= 0 then
      begin
        Inc(AStats.NoPrice);
        Continue;
      end;
      R := Default(TAgroRow);
      R.Sku := P.Sku;
      R.Name := P.Name;
      R.Brand := P.Brand;
      R.Price := P.PriceEngros;
      R.Rrp := P.PriceRetail;
      if R.Rrp <= 0 then
        Inc(AStats.NoRrp);
      ARows.Add(R);
    end;
    AContent := Content.ToArray;
  finally
    Content.Free;
    SeenSku.Free;
    SeenID.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ baza                                                                           }
{ ---------------------------------------------------------------------------- }

function SavePriceList(AConnection: TIBCConnection; APriceCategoryID: Integer;
  ARows: TList<TAgroRow>): Integer;
var
  Tr: TIBCTransaction;
  qMaster: TIBCQuery;
  qItem: TIBCSQL;
  R: TAgroRow;
  From, N, K: Integer;
begin
  Tr := TIBCTransaction.Create(nil);
  qMaster := TIBCQuery.Create(nil);
  qItem := TIBCSQL.Create(nil);
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
      qMaster.ParamByName('SUPPLIERID').AsInteger := cAgroPieseSupplierID;
      qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := APriceCategoryID;
      qMaster.ParamByName('FLAGS').AsInteger := cFLG_API;
      qMaster.ParamByName('MENTIUNI').AsString := 'Import automat API angro.agropiese.md (AgroPiese TGR Grup)';
      qMaster.Options.ReturnParams := True;
      qMaster.ParamCheck := True;
      qMaster.Execute;
      Result := qMaster.ParamByName('RET_PLID').AsInteger;

      // articolele in loturi (parametri-array IBDAC = EXECUTE BLOCK cu zeci de randuri pe drum);
      // API-ul nu da stocul - STOCK_QTY ramine null
      qItem.Connection := AConnection;
      qItem.Transaction := Tr;
      qItem.AutoCommit := False;
      qItem.SQL.Text :=
        'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
        'SUPPLIER_GOODS_BRAND, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID) ' +
        Format('values (%d, :CODE, :NAME, :BRAND, :PRICE0, %d, :PRICE3, %d, :PRICE7, %d)',
          [Result, cCurrencyMDL, cCurrencyMDL, cCurrencyMDL]);
      qItem.ParamByName('CODE').DataType := ftWideString;
      qItem.ParamByName('NAME').DataType := ftWideString;
      qItem.ParamByName('BRAND').DataType := ftWideString;
      qItem.ParamByName('PRICE0').DataType := ftFloat;
      qItem.ParamByName('PRICE3').DataType := ftFloat;
      qItem.ParamByName('PRICE7').DataType := ftFloat;

      From := 0;
      while From < ARows.Count do
      begin
        N := Min(cBatchRows, ARows.Count - From);
        qItem.Params.ValueCount := N;
        for K := 0 to N - 1 do
        begin
          R := ARows[From + K];
          qItem.ParamByName('CODE')[K].AsString := Copy(R.Sku, 1, 128);
          qItem.ParamByName('NAME')[K].AsString := Copy(R.Name, 1, 2048);
          qItem.ParamByName('BRAND')[K].AsString := Copy(R.Brand, 1, 128);
          // fara pret de cost separat in API: PRICE0 = pretul engros (vezi antetul)
          qItem.ParamByName('PRICE0')[K].AsFloat := R.Price;
          qItem.ParamByName('PRICE3')[K].AsFloat := R.Rrp;
          qItem.ParamByName('PRICE7')[K].AsFloat := R.Price;
        end;
        qItem.Execute(N);
        Inc(From, N);
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
{ TAgroPiesePriceListImport                                                      }
{ ---------------------------------------------------------------------------- }

// partea comuna a lui Run si Import: catalogul, pricelistul, descrierile si URL-urile imaginilor
function DoImport(AConnection: TIBCConnection; APriceCategoryID: Integer; ARows: TList<TAgroRow>;
  var AStats: TAgroStats; const AOnPage: TProc): Integer;
var
  Products: TList<TAgroProduct>;
  Content: TArray<TOlisContentItem>;
begin
  Products := TList<TAgroProduct>.Create;
  try
    DownloadCatalog(AConnection, Products, AOnPage, AStats.JsonFile);
    BuildRows(Products, ARows, Content, AStats);
  finally
    Products.Free;
  end;

  if ARows.Count = 0 then
    raise Exception.CreateFmt('API-ul AgroPiese nu a intors niciun produs cu pret engros ' +
      '(rinduri citite: %d, produse unice: %d).', [AStats.Total, AStats.Products]);
  Result := SavePriceList(AConnection, APriceCategoryID, ARows);
  AStats.Content := TOlisGrupContent.SaveForSupplier(AConnection, cAgroPieseSupplierID, Content);
end;

function StatsText(APLID: Integer; ARows: TList<TAgroRow>; const AStats: TAgroStats): string;
begin
  Result := Format('Pricelist AgroPiese (angro.agropiese.md) #%d creat:' + sLineBreak +
    '  produse in pricelist: %d (din %d produse unice, %d rinduri in catalog)' + sLineBreak +
    '  sarite: fara pret engros %d, fara cod %d, coduri repetate %d; rinduri repetate ale aceluiasi produs: %d; ' +
    'fara pret retail (RRP): %d' + sLineBreak +
    '  descrieri RO/RU (caracteristici): %d; produse cu imagini: %d (liste noi/schimbate: %d, %d URL-uri)',
    [APLID, ARows.Count, AStats.Products, AStats.Total, AStats.NoPrice, AStats.NoSku, AStats.Duplicates,
     AStats.Repeated, AStats.NoRrp,
     AStats.Content.Descriptions, AStats.Content.ProductsWithImages, AStats.Content.ImagesChanged,
     AStats.Content.ImageRows]) +
    IfThen(AStats.JsonFile <> '', sLineBreak + '  catalogul brut (JSON): ' + AStats.JsonFile, '') +
    IfThen(AStats.DuplicateCodes <> '', sLineBreak + sLineBreak +
      'Coduri (sku) folosite de mai multe produse in catalog - s-a pastrat primul produs:' + sLineBreak +
      Copy(AStats.DuplicateCodes, 1, 2000), '');
end;

class function TAgroPiesePriceListImport.Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;
var
  Rows: TList<TAgroRow>;
  Stats: TAgroStats;
begin
  Stats := Default(TAgroStats);
  Rows := TList<TAgroRow>.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      Result := DoImport(AConnection, APriceCategoryID, Rows, Stats,
        procedure
        begin
          Application.ProcessMessages;
        end);
    finally
      Screen.Cursor := crDefault;
    end;

    MessageDlg(StatsText(Result, Rows, Stats) + sLineBreak + sLineBreak +
      'Urmeaza descarcarea imaginilor nedescarcate si copierea lor la produsele legate.',
      mtInformation, [mbOK], 0);
  finally
    Rows.Free;
  end;

  // ca la Triomac / Olis Grup: imaginile (PNG in TS_PRICELIST_ITEMS_IMAGES.IMAGE), apoi
  // copierea imaginilor si descrierilor la produsele legate, fara suprascriere
  TDMLinkPriceListImport.DownloadImages(AConnection, Result, cAgroPieseSupplierID, cAgroPieseImageSite);
  TPriceListContentTransfer.Run(AConnection, cAgroPieseSupplierID, Result);
end;

class function TAgroPiesePriceListImport.Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
  const AOnLog: TProc<string>): Integer;
var
  Rows: TList<TAgroRow>;
  Stats: TAgroStats;
  Line: string;
begin
  Stats := Default(TAgroStats);
  Rows := TList<TAgroRow>.Create;
  try
    Result := DoImport(AConnection, APriceCategoryID, Rows, Stats, nil);
    if Assigned(AOnLog) then
      // in jurnal lista codurilor repetate ramine pe un rind
      for Line in StringReplace(StatsText(Result, Rows, Stats), ';' + sLineBreak, '; ',
        [rfReplaceAll]).Split([sLineBreak]) do
        if Line <> '' then
          AOnLog(Line);
  finally
    Rows.Free;
  end;
end;

class function TAgroPiesePriceListImport.LoadContent(AConnection: TIBCConnection;
  const AOnPage: TProc): TArray<TOlisContentItem>;
var
  Products: TList<TAgroProduct>;
  Stats: TAgroStats;
begin
  Stats := Default(TAgroStats);
  Products := TList<TAgroProduct>.Create;
  try
    DownloadCatalog(AConnection, Products, AOnPage, Stats.JsonFile);
    BuildRows(Products, nil, Result, Stats);
  finally
    Products.Free;
  end;
end;

end.

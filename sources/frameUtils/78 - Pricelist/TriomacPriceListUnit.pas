unit TriomacPriceListUnit;

(*
  Pricelist de la TRIOMAC SRL (CustomerID 209280) prin API-ul de parteneri SCOP v2
  (https://scop.md/api/partner/v2, clientul SCOPAPIClientUnit). Din 15 oct 2026 vechiul
  API (api.scop.md, login cu e-mail + parola) e inlocuit de cheie + secret.

  Datele de acces din TS_API_CONFIG, API_CODE = 'SCOP' (meniul Setari > Configurari API):
    API_KEY, API_SECRET, optional BASE_URL.

  Se descarca tot catalogul (~2000 produse, 11 pagini a cite 200) si intra produsele cu stoc
  si pret; intr-o singura tranzactie (totul sau nimic):
    TS_PRICELISTS       - pricelist nou (FLAGS = 2 = FLG_API);
    TS_PRICELIST_ITEMS  - sku -> SUPPLIER_GOODS_CODE (cheia din TS_GOODS_FOREIGN, ca in API-ul
                          vechi), name.ro, brand, stocul, calea categoriei -> SUPPLIER_CATEGORY;
                          price.value -> PRICE0 = PRICE7 (valuta listei de preturi, azi USD);
                          rrp.value (mereu lei) -> PRICE3.
  Apoi, separat (ca la Olis Grup, OlisGrupContentUnit.SaveForSupplier):
    TS_PRICELIST_ITEMS_DESCRIPTION - description + specification (HTML), RO / RU;
    TS_PRICELIST_ITEMS_IMAGES      - URL-urile images[] (scop.md/media/...), rescrise doar la
                                     produsele la care lista s-a schimbat.
  In WMS (Run) urmeaza descarcarea imaginilor si copierea la produsele legate; in WMSParsers
  le face jobul triomac-pricelist dupa reevaluari.

  Stocul: peste prag (azi 10) API-ul da pragul ("10 si mai mult", stock_exact = false) - in
  STOCK_QTY ramine cifra pragului. La produsele cu culori (variations[]) stocul = suma culorilor;
  culorile nu se impart in rinduri separate: in TS_GOODS_FOREIGN produsul e legat dupa sku-ul
  fisei (codurile culorilor nu au sku propriu). Unele culori sint inca produse separate cu
  acelasi sku (ex. '128026', 4 produse) - la acelasi pret stocul lor se aduna intr-un rind.

  PRICE0: API-ul nu da un pret de cost separat de pretul contractului, deci PRICE0 = PRICE7.

  Descrierea RU: azi SCOP trimite in "ru" acelasi text romanesc ca in "ro" (verificat 17 oct
  2026 pe toate cele 1223 de produse cu stoc) - un text identic cu RO nu se scrie la RU.
*)

interface

uses
  System.SysUtils, System.Classes, IBC;

const
  cTriomacSupplierID = 209280;

type
  TTriomacPriceListImport = class
  public
    // descarca catalogul, creeaza pricelistul, salveaza descrierile si URL-urile imaginilor,
    // apoi descarca imaginile si le copiaza la produsele legate; intoarce PLID-ul creat.
    // Arunca Exception la date de acces lipsa, autentificare esuata sau raspuns invalid -
    // in acest caz nu se creeaza nimic.
    class function Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;

    // pricelistul + descrierile + URL-urile imaginilor fara interfata (WMSParsers, orice fir);
    // descarcarea imaginilor ramine apelantului. Rezumatul merge in AOnLog
    class function Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
      const AOnLog: TProc<string>): Integer;
  end;

implementation

uses
  System.Generics.Collections, System.UITypes, System.StrUtils, System.Math, Data.DB,
  Vcl.Forms, Vcl.Controls, Vcl.Dialogs, IBCClasses, SCOPAPIClientUnit, OlisGrupContentUnit,
  B2B.DMLinkPriceListImport, PriceListContentTransferUnit;

const
  cCurrencyMDL = 498;
  cCurrencyUSD = 840;
  cCurrencyEUR = 978;
  cFLG_API = 2;
  // randuri trimise odata (IBDAC le imparte mai departe in EXECUTE BLOCK-uri)
  cBatchRows = 500;

type
  TTriomacRow = record
    Sku: string;
    Name: string;
    Brand: string;
    Category: string;
    Stock: Integer;
    Price: Double;
    CurrencyID: Integer;
    Rrp: Double;
    RrpCurrencyID: Integer;
  end;

  TTriomacStats = record
    Total: Integer;
    NoStock: Integer;
    NoSku: Integer;
    Duplicates: Integer;
    DuplicateCodes: string;
    // produse cu sku repetat si acelasi pret, adunate la stocul primului
    Merged: Integer;
    NoPrice: Integer;
    StockAtThreshold: Integer;
    WithColours: Integer;
    NoRrp: Integer;
    Content: TOlisContentStats;
  end;

{ ---------------------------------------------------------------------------- }
{ conversii                                                                      }
{ ---------------------------------------------------------------------------- }

// 0 = valuta necunoscuta (produsul se sare)
function CurrencyID(const ACurrency: string): Integer;
begin
  if SameText(ACurrency, 'USD') then
    Result := cCurrencyUSD
  else if SameText(ACurrency, 'MDL') then
    Result := cCurrencyMDL
  else if SameText(ACurrency, 'EUR') then
    Result := cCurrencyEUR
  else
    Result := 0;
end;

function StripTags(const AHtml: string): string;
var
  I: Integer;
  InTag: Boolean;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    InTag := False;
    for I := 1 to Length(AHtml) do
      if AHtml[I] = '<' then
        InTag := True
      else if AHtml[I] = '>' then
      begin
        InTag := False;
        SB.Append(' ');
      end
      else if not InTag then
        SB.Append(AHtml[I]);
    Result := Trim(StringReplace(SB.ToString, '&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]));
  finally
    SB.Free;
  end;
end;

// specification la ~70% din produse e doar un link spre site-ul producatorului - nu e descriere
function IsOnlyLink(const AText: string): Boolean;
begin
  Result := (AText = '') or
    ((StartsText('http://', AText) or StartsText('https://', AText)) and (Pos(' ', AText) = 0));
end;

// description (la ~60% din produse = denumirea) + specification (HTML)
function BuildDescription(const ADescription, ASpecification, AName: string): string;
var
  Desc, Spec: string;
begin
  Desc := Trim(ADescription);
  if SameText(StripTags(Desc), Trim(AName)) then
    Desc := '';
  Spec := Trim(ASpecification);
  if IsOnlyLink(StripTags(Spec)) then
    Spec := '';
  if (Desc <> '') and (Spec <> '') then
    Result := Desc + '<br>' + sLineBreak + Spec
  else
    Result := Desc + Spec;
end;

{ ---------------------------------------------------------------------------- }
{ catalog -> randuri                                                             }
{ ---------------------------------------------------------------------------- }

procedure BuildRows(AProducts: TList<TScopProduct>; ACategories: TDictionary<Integer, string>;
  ARows: TList<TTriomacRow>; var AContent: TArray<TOlisContentItem>; var AStats: TTriomacStats);
var
  P: TScopProduct;
  R: TTriomacRow;
  C: TOlisContentItem;
  // sku (majuscule) -> indexul rindului din ARows
  Seen: TDictionary<string, Integer>;
  Content: TList<TOlisContentItem>;
  Index: Integer;
begin
  Seen := TDictionary<string, Integer>.Create;
  Content := TList<TOlisContentItem>.Create;
  try
    for P in AProducts do
    begin
      Inc(AStats.Total);
      if P.Sku = '' then
      begin
        Inc(AStats.NoSku);
        Continue;
      end;
      if P.TotalStock <= 0 then
      begin
        Inc(AStats.NoStock);
        Continue;
      end;
      R := Default(TTriomacRow);
      R.CurrencyID := CurrencyID(P.Currency);
      if (P.Price <= 0) or not P.PriceAvailable or P.CallForPricing or (R.CurrencyID = 0) then
      begin
        Inc(AStats.NoPrice);
        Continue;
      end;

      // sku repetat: '128026' sint 4 produse SCOP, cite unul pe culoare, cu acelasi pret - stocul
      // se aduna la rindul existent; la pret diferit ramine primul produs, codul apare in mesaj
      if Seen.TryGetValue(UpperCase(P.Sku), Index) then
      begin
        R := ARows[Index];
        if (R.CurrencyID = CurrencyID(P.Currency)) and SameValue(R.Price, P.Price, 0.001) then
        begin
          Inc(R.Stock, P.TotalStock);
          ARows[Index] := R;
          Inc(AStats.Merged);
        end
        else
        begin
          Inc(AStats.Duplicates);
          if Pos(#13#10 + P.Sku + ';', #13#10 + AStats.DuplicateCodes) = 0 then
            AStats.DuplicateCodes := AStats.DuplicateCodes + P.Sku + ';' + #13#10;
        end;
        Continue;
      end;

      R.Sku := P.Sku;
      R.Name := P.NameRo;
      if R.Name = '' then
        R.Name := P.NameRu;
      R.Brand := P.Brand;
      if not ACategories.TryGetValue(P.CategoryID, R.Category) then
        R.Category := '';
      R.Stock := P.TotalStock;
      R.Price := P.Price;
      R.Rrp := P.Rrp;
      R.RrpCurrencyID := CurrencyID(P.RrpCurrency);
      if R.RrpCurrencyID = 0 then
        R.RrpCurrencyID := cCurrencyMDL; // rrp e mereu in lei (documentatia SCOP)
      if R.Rrp <= 0 then
        Inc(AStats.NoRrp);
      if not P.TotalStockExact then
        Inc(AStats.StockAtThreshold);
      if Length(P.Variations) > 0 then
        Inc(AStats.WithColours);

      Seen.Add(UpperCase(P.Sku), ARows.Add(R));

      C := Default(TOlisContentItem);
      C.Code := P.Sku;
      C.DescRo := BuildDescription(P.DescriptionRo, P.SpecificationRo, R.Name);
      C.DescRu := BuildDescription(P.DescriptionRu, P.SpecificationRu, P.NameRu);
      if C.DescRu = C.DescRo then
        C.DescRu := '';
      C.Images := P.Images;
      if (C.DescRo <> '') or (C.DescRu <> '') or (Length(C.Images) > 0) then
        Content.Add(C);
    end;
    AContent := Content.ToArray;
  finally
    Content.Free;
    Seen.Free;
  end;
end;

procedure DownloadCatalog(AConnection: TIBCConnection; AProducts: TList<TScopProduct>;
  out ACategories: TDictionary<Integer, string>; const AOnPage: TProc);
var
  Client: TSCOPAPIClient;
begin
  ACategories := nil;
  Client := TSCOPAPIClient.CreateFromConfig(AConnection);
  try
    // tot catalogul, nu in_stock=1: la produsele cu culori stocul fisei e al unei singure
    // culori, deci filtrul API-ului ar putea scapa produse cu stoc doar pe alte culori
    Client.GetProducts(AProducts, False, False, AOnPage);
    ACategories := Client.GetCategoryPaths;
  finally
    Client.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ baza                                                                           }
{ ---------------------------------------------------------------------------- }

function SavePriceList(AConnection: TIBCConnection; APriceCategoryID: Integer;
  ARows: TList<TTriomacRow>): Integer;
var
  Tr: TIBCTransaction;
  qMaster: TIBCQuery;
  qItem: TIBCSQL;
  R: TTriomacRow;
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
      qMaster.ParamByName('SUPPLIERID').AsInteger := cTriomacSupplierID;
      qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := APriceCategoryID;
      qMaster.ParamByName('FLAGS').AsInteger := cFLG_API;
      qMaster.ParamByName('MENTIUNI').AsString := 'Import automat SCOP API v2 (Triomac)';
      qMaster.Options.ReturnParams := True;
      qMaster.ParamCheck := True;
      qMaster.Execute;
      Result := qMaster.ParamByName('RET_PLID').AsInteger;

      // articolele in loturi (parametri-array IBDAC = EXECUTE BLOCK cu zeci de randuri pe drum)
      qItem.Connection := AConnection;
      qItem.Transaction := Tr;
      qItem.AutoCommit := False;
      qItem.SQL.Text :=
        'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
        'SUPPLIER_GOODS_BRAND, STOCK_QTY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, ' +
        'CURRENCY7ID, SUPPLIER_CATEGORY) ' +
        Format('values (%d, :CODE, :NAME, :BRAND, :STOCK, :PRICE0, :CURRENCY0ID, :PRICE3, :CURRENCY3ID, ',
          [Result]) + ':PRICE7, :CURRENCY7ID, :CATEGORY)';
      qItem.ParamByName('CODE').DataType := ftWideString;
      qItem.ParamByName('NAME').DataType := ftWideString;
      qItem.ParamByName('BRAND').DataType := ftWideString;
      qItem.ParamByName('STOCK').DataType := ftWideString;
      qItem.ParamByName('PRICE0').DataType := ftFloat;
      qItem.ParamByName('CURRENCY0ID').DataType := ftInteger;
      qItem.ParamByName('PRICE3').DataType := ftFloat;
      qItem.ParamByName('CURRENCY3ID').DataType := ftInteger;
      qItem.ParamByName('PRICE7').DataType := ftFloat;
      qItem.ParamByName('CURRENCY7ID').DataType := ftInteger;
      qItem.ParamByName('CATEGORY').DataType := ftWideString;

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
          qItem.ParamByName('STOCK')[K].AsString := IntToStr(R.Stock);
          // fara pret de cost separat in API: PRICE0 = pretul contractului (vezi antetul)
          qItem.ParamByName('PRICE0')[K].AsFloat := R.Price;
          qItem.ParamByName('CURRENCY0ID')[K].AsInteger := R.CurrencyID;
          qItem.ParamByName('PRICE3')[K].AsFloat := R.Rrp;
          qItem.ParamByName('CURRENCY3ID')[K].AsInteger := R.RrpCurrencyID;
          qItem.ParamByName('PRICE7')[K].AsFloat := R.Price;
          qItem.ParamByName('CURRENCY7ID')[K].AsInteger := R.CurrencyID;
          // SUPPLIER_CATEGORY e declarata 512 caractere, dar are doar 512 octeti (RDB$FIELD_LENGTH) - in UTF8
          // Firebird permite deci doar 512 / 4 = 128 caractere (2 oct 2026: 'expected length 128, actual 131')
          qItem.ParamByName('CATEGORY')[K].AsString := Copy(R.Category, 1, 128);
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
{ TTriomacPriceListImport                                                        }
{ ---------------------------------------------------------------------------- }

// partea comuna a lui Run si Import: catalogul, pricelistul, descrierile si URL-urile imaginilor
function DoImport(AConnection: TIBCConnection; APriceCategoryID: Integer; ARows: TList<TTriomacRow>;
  var AStats: TTriomacStats; const AOnPage: TProc): Integer;
var
  Products: TList<TScopProduct>;
  Categories: TDictionary<Integer, string>;
  Content: TArray<TOlisContentItem>;
begin
  Products := TList<TScopProduct>.Create;
  Categories := nil;
  try
    DownloadCatalog(AConnection, Products, Categories, AOnPage);
    BuildRows(Products, Categories, ARows, Content, AStats);
  finally
    Categories.Free;
    Products.Free;
  end;

  if ARows.Count = 0 then
    raise Exception.CreateFmt('API-ul SCOP nu a intors niciun produs cu stoc si pret ' +
      '(produse citite: %d).', [AStats.Total]);
  Result := SavePriceList(AConnection, APriceCategoryID, ARows);
  AStats.Content := TOlisGrupContent.SaveForSupplier(AConnection, cTriomacSupplierID, Content);
end;

function StatsText(APLID: Integer; ARows: TList<TTriomacRow>; const AStats: TTriomacStats): string;
begin
  Result := Format('Pricelist Triomac (SCOP) #%d creat:' + sLineBreak +
    '  produse in pricelist: %d (din %d in catalog)' + sLineBreak +
    '  sarite: fara stoc %d, fara cod %d, fara pret %d, coduri repetate %d' + sLineBreak +
    '  stoc "%s si mai mult" (pragul SCOP): %d; produse cu culori (stoc insumat): %d; ' +
    'acelasi sku, stoc adunat: %d; fara RRP: %d' + sLineBreak +
    '  descrieri RO/RU: %d; produse cu imagini: %d (liste noi/schimbate: %d, %d URL-uri)',
    [APLID, ARows.Count, AStats.Total, AStats.NoStock, AStats.NoSku, AStats.NoPrice, AStats.Duplicates,
     '10', AStats.StockAtThreshold, AStats.WithColours, AStats.Merged, AStats.NoRrp,
     AStats.Content.Descriptions, AStats.Content.ProductsWithImages, AStats.Content.ImagesChanged,
     AStats.Content.ImageRows]) +
    IfThen(AStats.DuplicateCodes <> '', sLineBreak + sLineBreak +
      'Coduri (sku) folosite de mai multe produse in SCOP - s-a pastrat primul produs:' + sLineBreak +
      Copy(AStats.DuplicateCodes, 1, 2000), '');
end;

class function TTriomacPriceListImport.Run(AConnection: TIBCConnection; APriceCategoryID: Integer): Integer;
var
  Rows: TList<TTriomacRow>;
  Stats: TTriomacStats;
begin
  Stats := Default(TTriomacStats);
  Rows := TList<TTriomacRow>.Create;
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

  // ca la Olis Grup / DMLink: imaginile (PNG in TS_PRICELIST_ITEMS_IMAGES.IMAGE), apoi
  // copierea imaginilor si descrierilor la produsele legate, fara suprascriere
  TDMLinkPriceListImport.DownloadImages(AConnection, Result, cTriomacSupplierID, 'scop.md');
  TPriceListContentTransfer.Run(AConnection, cTriomacSupplierID, Result);
end;

class function TTriomacPriceListImport.Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
  const AOnLog: TProc<string>): Integer;
var
  Rows: TList<TTriomacRow>;
  Stats: TTriomacStats;
  Line: string;
begin
  Stats := Default(TTriomacStats);
  Rows := TList<TTriomacRow>.Create;
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

end.

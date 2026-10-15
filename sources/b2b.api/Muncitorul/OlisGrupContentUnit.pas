unit OlisGrupContentUnit;

(* ============================================================================
   Continutul produselor Olis Grup (furnizor 251465) din feed-ul muncitorul.md
   (https://price.muncitorul.md/api/products.json):

     textRO / textRU (HTML) + features  -> TS_PRICELIST_ITEMS_DESCRIPTION
       DESCRIPTION_RO / DESCRIPTION_RU = textul + tabelul de caracteristici
       (name_RO/value_RO, respectiv name_RU/value_RU), ca la NexDistribution;
     imagini (URL-uri)                  -> TS_PRICELIST_ITEMS_IMAGES
       doar URL-urile; se rescriu numai la produsele la care lista s-a schimbat,
       ca imaginile deja descarcate (IMAGE) sa nu se piarda la fiecare import
       (ca la DMLink).

   Folosit de ambele importuri Olis: dialogul din WMS (frmMuncitorulProgressUnit,
   frame78) si jobul olisgrup-pricelist din WMSParsers (OlisGrupPriceListUnit).
   Dupa Save urmeaza, ca la DMLink:
     TDMLinkPriceListImport.DownloadImages(Silent)(..., cOlisContentSupplierID) -
       descarcarea imaginilor (PNG in IMAGE), doar pentru randurile fara IMAGE;
     TPriceListContentTransfer - copierea la produsele legate (TS_GOODS_IMAGE /
       TS_GOODS_DSC), fara suprascriere.
   ============================================================================ *)

interface

uses
  System.SysUtils, System.JSON, IBC;

const
  cOlisContentSupplierID = 251465;

type
  TOlisContentItem = record
    Code: string;
    DescRo: string;
    DescRu: string;
    Images: TArray<string>;
  end;

  TOlisContentStats = record
    Descriptions: Integer;
    ProductsWithImages: Integer;
    // produse la care lista de URL-uri s-a schimbat (rescrise in TS_PRICELIST_ITEMS_IMAGES)
    ImagesChanged: Integer;
    ImageRows: Integer;
  end;

  TOlisGrupContent = class
  public
    // continutul unui produs (obiectul JSON al produsului din feed)
    class function FromJson(AObj: TJSONObject): TOlisContentItem;
    // tot feed-ul: doar produsele cu stoc > 0 (cele care intra in pricelist);
    // la un cod repetat se ia prima aparitie, ca la import
    class function ParseFeed(const AJson: string): TArray<TOlisContentItem>;
    // descarca feed-ul si il parseaza (butonul de continut din frame78, fara import nou)
    class function LoadFromFeed: TArray<TOlisContentItem>;
    // descrierile si URL-urile imaginilor, intr-o singura tranzactie (totul sau nimic)
    class function Save(AConnection: TIBCConnection;
      const AItems: TArray<TOlisContentItem>): TOlisContentStats;
  end;

implementation

uses
  System.Classes, System.Math, System.NetEncoding, System.Generics.Collections, System.Net.HttpClient,
  Data.DB, IBCClasses;

const
  cBatchRows = 250;
  cFeedUrl = 'https://price.muncitorul.md/api/products.json';

var
  GInvariant: TFormatSettings;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if Assigned(AObj) and AObj.TryGetValue(AName, V) and not V.Null then
    Result := Trim(V.Value);
end;

// textul din feed (HTML) + tabelul de caracteristici in limba data
function BuildDescription(AObj: TJSONObject; const ALang: string): string;
var
  Features: TJSONValue;
  F: TJSONValue;
  Name, Value, Table: string;
begin
  Result := JStr(AObj, 'text' + ALang);
  Table := '';
  if AObj.TryGetValue('features', Features) and (Features is TJSONArray) then
    for F in TJSONArray(Features) do
    begin
      if not (F is TJSONObject) then
        Continue;
      Name := JStr(TJSONObject(F), 'name_' + ALang);
      Value := JStr(TJSONObject(F), 'value_' + ALang);
      if (Name = '') or (Value = '') then
        Continue;
      Table := Table + '<tr><td>' + TNetEncoding.HTML.Encode(Name) + '</td><td>' +
        TNetEncoding.HTML.Encode(Value) + '</td></tr>';
    end;
  if Table = '' then
    Exit;
  if Result <> '' then
    Result := Result + sLineBreak;
  Result := Result + '<table>' + Table + '</table>';
end;

class function TOlisGrupContent.FromJson(AObj: TJSONObject): TOlisContentItem;
var
  Images, V: TJSONValue;
  Urls: TList<string>;
  Url: string;
begin
  Result.Code := JStr(AObj, 'code');
  Result.DescRo := BuildDescription(AObj, 'RO');
  Result.DescRu := BuildDescription(AObj, 'RU');
  Urls := TList<string>.Create;
  try
    if AObj.TryGetValue('imagini', Images) and (Images is TJSONArray) then
      for V in TJSONArray(Images) do
      begin
        Url := Trim(V.Value);
        if (Url <> '') and not Urls.Contains(Url) then
          Urls.Add(Url);
      end;
    Result.Images := Urls.ToArray;
  finally
    Urls.Free;
  end;
end;

class function TOlisGrupContent.ParseFeed(const AJson: string): TArray<TOlisContentItem>;
var
  Root, V: TJSONValue;
  Obj: TJSONObject;
  Items: TList<TOlisContentItem>;
  Seen: TDictionary<string, Boolean>;
  Code: string;
begin
  Items := TList<TOlisContentItem>.Create;
  Seen := TDictionary<string, Boolean>.Create;
  Root := TJSONObject.ParseJSONValue(AJson);
  try
    if not (Root is TJSONArray) then
      raise Exception.Create('Feed Olis Grup: raspunsul nu este o lista JSON de produse.');
    for V in TJSONArray(Root) do
    begin
      if not (V is TJSONObject) then
        Continue;
      Obj := TJSONObject(V);
      Code := JStr(Obj, 'code');
      if (Code = '') or Seen.ContainsKey(Code) or
         (StrToFloatDef(JStr(Obj, 'stoc'), 0, GInvariant) <= 0) then
        Continue;
      Seen.Add(Code, True);
      Items.Add(FromJson(Obj));
    end;
    Result := Items.ToArray;
  finally
    Root.Free;
    Seen.Free;
    Items.Free;
  end;
end;

class function TOlisGrupContent.LoadFromFeed: TArray<TOlisContentItem>;
var
  Http: THTTPClient;
  Response: IHTTPResponse;
  Json: string;
begin
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 30000;
    Http.ResponseTimeout := 300000;
    Http.Accept := 'application/json';
    Response := Http.Get(cFeedUrl);
    Json := Response.ContentAsString(TEncoding.UTF8);
    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('Feed Olis Grup: HTTP %d.%s%s', [Response.StatusCode, sLineBreak, Copy(Json, 1, 300)]);
  finally
    Http.Free;
  end;
  Result := ParseFeed(Json);
end;

// URL-urile deja salvate, pe cod (unite cu #10 in ordinea ORDERNO)
function LoadExistingImages(AConnection: TIBCConnection): TDictionary<string, string>;
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
    q.ParamByName('SUPPLIERID').AsInteger := cOlisContentSupplierID;
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

class function TOlisGrupContent.Save(AConnection: TIBCConnection;
  const AItems: TArray<TOlisContentItem>): TOlisContentStats;
var
  Existing: TDictionary<string, string>;
  Descr, Changed: TList<Integer>;
  Tr: TIBCTransaction;
  qDescr, qImgDel, qImgIns: TIBCSQL;
  Old: string;
  I, K, M, N, J, Rows, From: Integer;
begin
  Result := Default(TOlisContentStats);
  Descr := TList<Integer>.Create;
  Changed := TList<Integer>.Create;
  Existing := LoadExistingImages(AConnection);
  try
    for I := 0 to High(AItems) do
    begin
      if AItems[I].Code = '' then
        Continue;
      if (AItems[I].DescRo <> '') or (AItems[I].DescRu <> '') then
        Descr.Add(I);
      if Length(AItems[I].Images) = 0 then
        Continue;
      Inc(Result.ProductsWithImages);
      // feed-ul fara imagini nu sterge ce e deja salvat; se rescrie doar o lista schimbata
      if not Existing.TryGetValue(Copy(AItems[I].Code, 1, 128), Old) or
         (Old <> string.Join(#10, AItems[I].Images)) then
        Changed.Add(I);
    end;

    Tr := TIBCTransaction.Create(nil);
    qDescr := nil;
    qImgDel := nil;
    qImgIns := nil;
    try
      Tr.DefaultConnection := AConnection;
      Tr.StartTransaction;
      try
        qDescr := CreateBatchSQL(AConnection, Tr,
          'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION ' +
          '  (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO, DESCRIPTION_RU) ' +
          Format('values (%d, :CODE, :DESCRIPTION_RO, :DESCRIPTION_RU) ', [cOlisContentSupplierID]) +
          'matching (SUPPLIERID, SUPPLIER_GOODS_CODE)',
          [ftWideString, ftWideMemo, ftWideMemo]);
        qImgDel := CreateBatchSQL(AConnection, Tr,
          Format('delete from TS_PRICELIST_ITEMS_IMAGES where SUPPLIERID = %d ', [cOlisContentSupplierID]) +
          'and SUPPLIER_GOODS_CODE = :CODE',
          [ftWideString]);
        qImgIns := CreateBatchSQL(AConnection, Tr,
          'insert into TS_PRICELIST_ITEMS_IMAGES (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL, PROCESS_DATE, ORDERNO) ' +
          Format('values (%d, :CODE, :URL, current_timestamp, :ORDERNO)', [cOlisContentSupplierID]),
          [ftWideString, ftWideString, ftInteger]);

        // descrierile
        From := 0;
        while From < Descr.Count do
        begin
          N := Min(cBatchRows, Descr.Count - From);
          qDescr.Params.ValueCount := N;
          for K := 0 to N - 1 do
            with AItems[Descr[From + K]] do
            begin
              qDescr.Params[0][K].AsString := Copy(Code, 1, 128);
              qDescr.Params[1][K].AsString := DescRo;
              qDescr.Params[2][K].AsString := DescRu;
            end;
          qDescr.Execute(N);
          Inc(From, N);
        end;
        Result.Descriptions := Descr.Count;

        // imaginile: doar produsele la care lista de URL-uri s-a schimbat
        From := 0;
        while From < Changed.Count do
        begin
          N := Min(cBatchRows, Changed.Count - From);
          qImgDel.Params.ValueCount := N;
          Rows := 0;
          for K := 0 to N - 1 do
          begin
            qImgDel.Params[0][K].AsString := Copy(AItems[Changed[From + K]].Code, 1, 128);
            Inc(Rows, Length(AItems[Changed[From + K]].Images));
          end;
          qImgDel.Execute(N);

          qImgIns.Params.ValueCount := Rows;
          J := 0;
          for K := 0 to N - 1 do
            with AItems[Changed[From + K]] do
              for M := 0 to High(Images) do
              begin
                qImgIns.Params[0][J].AsString := Copy(Code, 1, 128);
                qImgIns.Params[1][J].AsString := Images[M];
                qImgIns.Params[2][J].AsInteger := M + 1;
                Inc(J);
              end;
          qImgIns.Execute(Rows);
          Inc(Result.ImageRows, Rows);
          Inc(From, N);
        end;
        Result.ImagesChanged := Changed.Count;

        Tr.Commit;
      except
        if Tr.Active then
          Tr.Rollback;
        raise;
      end;
    finally
      qImgIns.Free;
      qImgDel.Free;
      qDescr.Free;
      Tr.Free;
    end;
  finally
    Existing.Free;
    Changed.Free;
    Descr.Free;
  end;
end;

initialization
  GInvariant := TFormatSettings.Invariant;

end.

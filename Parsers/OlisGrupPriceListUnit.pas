unit OlisGrupPriceListUnit;

{ Pricelist Olis Grup (furnizor 251465) din feed-ul JSON muncitorul.md, fara interfata:
    GET https://price.muncitorul.md/api/products.json   (fara autentificare)

  Aceleasi reguli ca formularul din WMS (b2b.api\Muncitorul\frmMuncitorulProgressUnit):
    - doar produsele cu stoc > 0;
    - PRICE0 = PRICE7 = pret_online, PRICE3 = pret_vinz, toate in MDL (498);
    - titluRO -> denumirea, brand, categorieRO, guar_period -> garantia.
  Diferente: IBDAC in loc de FireDAC (conexiunea jobului, fara parola in .dfm), JSON citit
  direct (fara TFDMemTable) si articolele scrise in loturi IBDAC (EXECUTE BLOCK) intr-o
  singura tranzactie - totul sau nimic, fara fire de scriere separate.
  Un cod repetat in feed se ia o singura data (primul). }

interface

uses
  System.SysUtils, IBC;

const
  cOlisGrupSupplierID = 251465;

type
  TOlisGrupPriceListImport = class
  public
    // descarca feed-ul si creeaza pricelistul; intoarce PLID-ul. Rezumatul merge in AOnLog.
    // La eroare arunca Exception si nu ramine nimic in baza.
    class function Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
      const AOnLog: TProc<string>): Integer;
  end;

implementation

uses
  System.Classes, System.JSON, System.Math, System.Generics.Collections, System.Net.HttpClient,
  System.Net.URLClient, System.NetConsts, Data.DB, IBCClasses;

const
  cFeedUrl = 'https://price.muncitorul.md/api/products.json';
  cCurrencyMDL = 498;
  cBatchRows = 500;

type
  TOlisItem = record
    Code: string;
    Name: string;
    Brand: string;
    Category: string;
    Stock: Double;
    PriceOnline: Double;
    PriceVinz: Double;
    Warranty: Integer;
  end;

var
  GInvariant: TFormatSettings;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if AObj.TryGetValue(AName, V) and not V.Null then
    Result := Trim(V.Value);
end;

function JFloat(AObj: TJSONObject; const AName: string): Double;
begin
  Result := StrToFloatDef(JStr(AObj, AName), 0, GInvariant);
end;

function DownloadFeed: string;
var
  Http: THTTPClient;
  Response: IHTTPResponse;
begin
  Http := THTTPClient.Create;
  try
    Http.ConnectionTimeout := 30000;
    Http.ResponseTimeout := 300000;
    Http.Accept := 'application/json';
    Response := Http.Get(cFeedUrl);
    Result := Response.ContentAsString(TEncoding.UTF8);
    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('Feed Olis Grup: HTTP %d.%s%s', [Response.StatusCode, sLineBreak, Copy(Result, 1, 300)]);
  finally
    Http.Free;
  end;
end;

class function TOlisGrupPriceListImport.Import(AConnection: TIBCConnection; APriceCategoryID: Integer;
  const AOnLog: TProc<string>): Integer;
var
  Root, V: TJSONValue;
  Obj: TJSONObject;
  Items: TList<TOlisItem>;
  Seen: TDictionary<string, Boolean>;
  Item: TOlisItem;
  Total, NoStock, Duplicates, I, N, K: Integer;
  Tr: TIBCTransaction;
  qMaster: TIBCQuery;
  qItem: TIBCSQL;

  procedure Log(const S: string);
  begin
    if Assigned(AOnLog) then
      AOnLog(S);
  end;

begin
  Total := 0;
  NoStock := 0;
  Duplicates := 0;
  Items := TList<TOlisItem>.Create;
  Seen := TDictionary<string, Boolean>.Create;
  try
    Root := TJSONObject.ParseJSONValue(DownloadFeed);
    try
      if not (Root is TJSONArray) then
        raise Exception.Create('Feed Olis Grup: raspunsul nu este o lista JSON de produse.');
      for V in TJSONArray(Root) do
      begin
        if not (V is TJSONObject) then
          Continue;
        Obj := TJSONObject(V);
        Inc(Total);
        Item.Code := JStr(Obj, 'code');
        if Item.Code = '' then
          Continue;
        Item.Stock := JFloat(Obj, 'stoc');
        if Item.Stock <= 0 then
        begin
          Inc(NoStock);
          Continue;
        end;
        if Seen.ContainsKey(Item.Code) then
        begin
          Inc(Duplicates);
          Continue;
        end;
        Seen.Add(Item.Code, True);
        Item.Name := JStr(Obj, 'titluRO');
        Item.Brand := JStr(Obj, 'brand');
        Item.Category := JStr(Obj, 'categorieRO');
        Item.PriceOnline := JFloat(Obj, 'pret_online');
        Item.PriceVinz := JFloat(Obj, 'pret_vinz');
        Item.Warranty := Trunc(JFloat(Obj, 'guar_period'));
        Items.Add(Item);
      end;
    finally
      Root.Free;
    end;
    if Items.Count = 0 then
      raise Exception.CreateFmt('Feed-ul Olis Grup nu are produse cu stoc (produse citite: %d).', [Total]);

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
          'insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID, MENTIUNI) ' +
          'values (:SUPPLIERID, :PRICE_CATEGORYID, :MENTIUNI) returning PLID';
        qMaster.ParamByName('SUPPLIERID').AsInteger := cOlisGrupSupplierID;
        qMaster.ParamByName('PRICE_CATEGORYID').AsInteger := APriceCategoryID;
        qMaster.ParamByName('MENTIUNI').AsString := 'Import automat Olis Grup (WMSParsers)';
        qMaster.Options.ReturnParams := True;
        qMaster.ParamCheck := True;
        qMaster.Execute;
        Result := qMaster.ParamByName('RET_PLID').AsInteger;

        qItem.Connection := AConnection;
        qItem.Transaction := Tr;
        qItem.AutoCommit := False;
        qItem.SQL.Text :=
          'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, STOCK_QTY, ' +
          'PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, SUPPLIER_GOODS_BRAND, WARANTY, ' +
          'SUPPLIER_CATEGORY) ' +
          Format('values (%d, :CODE, :NAME, :STOCK, :PRICE0, %d, :PRICE3, %d, :PRICE7, %d, :BRAND, :WARANTY, ',
            [Result, cCurrencyMDL, cCurrencyMDL, cCurrencyMDL]) + ':CATEGORY)';
        qItem.ParamByName('CODE').DataType := ftWideString;
        qItem.ParamByName('NAME').DataType := ftWideString;
        qItem.ParamByName('STOCK').DataType := ftWideString;
        qItem.ParamByName('PRICE0').DataType := ftFloat;
        qItem.ParamByName('PRICE3').DataType := ftFloat;
        qItem.ParamByName('PRICE7').DataType := ftFloat;
        qItem.ParamByName('BRAND').DataType := ftWideString;
        qItem.ParamByName('WARANTY').DataType := ftInteger;
        qItem.ParamByName('CATEGORY').DataType := ftWideString;

        I := 0;
        while I < Items.Count do
        begin
          N := Min(cBatchRows, Items.Count - I);
          qItem.Params.ValueCount := N;
          for K := 0 to N - 1 do
          begin
            Item := Items[I + K];
            qItem.ParamByName('CODE')[K].AsString := Copy(Item.Code, 1, 128);
            qItem.ParamByName('NAME')[K].AsString := Copy(Item.Name, 1, 2048);
            qItem.ParamByName('STOCK')[K].AsString := Copy(FloatToStr(Item.Stock, GInvariant), 1, 16);
            // la Olis PRICE0 = PRICE7 = pret_online (ca in WMS)
            qItem.ParamByName('PRICE0')[K].AsFloat := Item.PriceOnline;
            qItem.ParamByName('PRICE3')[K].AsFloat := Item.PriceVinz;
            qItem.ParamByName('PRICE7')[K].AsFloat := Item.PriceOnline;
            qItem.ParamByName('BRAND')[K].AsString := Copy(Item.Brand, 1, 128);
            qItem.ParamByName('WARANTY')[K].AsInteger := Item.Warranty;
            // SUPPLIER_CATEGORY: 512 octeti = 128 caractere UTF8
            qItem.ParamByName('CATEGORY')[K].AsString := Copy(Item.Category, 1, 128);
          end;
          qItem.Execute(N);
          Inc(I, N);
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

    Log(Format('Pricelist Olis Grup #%d creat: %d produse cu stoc (din %d citite; fara stoc %d, coduri repetate %d)',
      [Result, Items.Count, Total, NoStock, Duplicates]));
  finally
    Seen.Free;
    Items.Free;
  end;
end;

initialization
  GInvariant := TFormatSettings.Invariant;

end.

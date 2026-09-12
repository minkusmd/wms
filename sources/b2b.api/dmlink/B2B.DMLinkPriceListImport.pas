unit B2B.DMLinkPriceListImport;

(* ============================================================================
   Import automat al catalogului DMLink (furnizor 229466) prin API-ul
   b2b.dmlink.md, folosind clientul TDMLinkAPIClient (SuppliersAPI\DMLinkAPIClientUnit).

   Creaza un pricelist nou:
     TS_PRICELISTS            - inregistrarea master (FLAGS = 2 = FLG_API)
     TS_PRICELIST_ITEMS       - produsele
     TS_PRICELIST_ITEMS_IMAGES       - imaginile (SUPPLIERID + SUPPLIER_GOODS_CODE)
     TS_PRICELIST_ITEMS_DESCRIPTION  - descrierea (SUPPLIERID + SUPPLIER_GOODS_CODE)

   Credentialele (USERNAME/PASSWORD) vin din TS_API_CONFIG, API_CODE = 'DMLINK'
   (meniul Setari > Configurari API din SWN).

   Clasa nu are nicio dependinta de VCL sau de datamodule-ul aplicatiei SWN -
   primeste conexiunea IBC gata deschisa in constructor, ca sa poata fi rulata
   si dintr-un alt proces (ex. un serviciu/thread separat de sincronizare
   zilnica), nu doar din interfata WMS.

   ATENTIE - presupuneri nc verificate live (nu a fost disponibil un raspuns
   real de la API in momentul scrierii):
     - GetAllProducts poate intoarce fie un array JSON simplu, fie un obiect cu
       cheia 'data'/'products'/'items' - toate 3 formele sunt tratate, dar daca
       API-ul foloseste alta cheie de paginare trebuie ajustat ExtractProductsArray.
     - Elementele din 'images' - se accepta atat siruri simple (URL), cat si
       obiecte cu cheia 'url'/'path'/'image'/'src' - de confirmat forma reala.
     - RPrice -> PRICE7 (indicativ), SPrice -> PRICE3, NPrice -> PRICE0 (cost) -
       prin analogie cu maparea folosita la Accent; de confirmat cu DMLink ce
       inseamna exact R/S/N.
     - Valuta preturilor DMLink nu e cunoscuta - s-a folosit USD (840), ca la
       ceilalti furnizori din TS_PRICELIST_ITEMS.
     - Descrierea DMLink e un singur camp ('description') - se scrie doar in
       DESCRIPTION_RO, DESCRIPTION_RU ramane necompletat.
   ============================================================================ *)

interface

uses
  System.SysUtils, System.JSON, IBC;

type
  TDMLinkImportResult = record
    PLID: Integer;
    ProductsImported: Integer;
    ImagesImported: Integer;
  end;

  TDMLinkPriceListImport = class
  private
    FConnection: TIBCConnection;
    FSupplierID: Integer;
    FPriceCategoryID: Integer;
    function ReadCredentials(out AUser, APassword: string): Boolean;
    function ExtractProductsArray(ARoot: TJSONValue): TJSONArray;
  public
    constructor Create(AConnection: TIBCConnection; ASupplierID: Integer = 229466; APriceCategoryID: Integer = 10);

    // Ruleaza importul complet (autentificare + catalog + insert-uri), intr-o
    // singura tranzactie (totul sau nimic). Arunca Exception pe orice esec
    // (credentiale lipsa, login esuat, raspuns JSON invalid).
    function Execute: TDMLinkImportResult;
  end;

implementation

uses
  DMLinkAPIClientUnit;

function JStr(AObj: TJSONObject; const AName: string): string;
var
  V: TJSONValue;
begin
  Result := '';
  if Assigned(AObj) and AObj.TryGetValue(AName, V) and not V.Null then
    Result := V.Value;
end;

function JImageURL(AItem: TJSONValue): string;
var
  Obj: TJSONObject;
begin
  Result := '';
  if AItem is TJSONString then
    Result := TJSONString(AItem).Value
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
end;

{ TDMLinkPriceListImport }

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
    Tr.Params.Add('read');
    Tr.Params.Add('read_committed');
    Tr.StartTransaction;

    q.Connection := FConnection;
    q.Transaction := Tr;
    q.SQL.Text := 'select PARAM_NAME, PARAM_VALUE from TS_API_CONFIG ' +
      'where API_CODE = ''DMLINK'' and FLG_ACTIVE = 1';
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

function TDMLinkPriceListImport.ExtractProductsArray(ARoot: TJSONValue): TJSONArray;
var
  DataValue: TJSONValue;
begin
  Result := nil;
  if ARoot is TJSONArray then
    Result := TJSONArray(ARoot)
  else if ARoot is TJSONObject then
  begin
    if TJSONObject(ARoot).TryGetValue('data', DataValue) and (DataValue is TJSONArray) then
      Result := TJSONArray(DataValue)
    else if TJSONObject(ARoot).TryGetValue('products', DataValue) and (DataValue is TJSONArray) then
      Result := TJSONArray(DataValue)
    else if TJSONObject(ARoot).TryGetValue('items', DataValue) and (DataValue is TJSONArray) then
      Result := TJSONArray(DataValue);
  end;
end;

function TDMLinkPriceListImport.Execute: TDMLinkImportResult;
var
  DMLinkUser, DMLinkPassword: string;
  API: TDMLinkAPIClient;
  RawJSON: string;
  RootValue: TJSONValue;
  ProductsArray: TJSONArray;
  DataValue: TJSONValue;
  I, J: Integer;
  ProductObj: TJSONObject;
  Tr: TIBCTransaction;
  qMaster, qItem, qDescr, qImgDel, qImgIns: TIBCQuery;
  PLID: Integer;
  SKU, ProductName, Description, BrandName, CategoryName: string;
  RPrice, SPrice, NPrice: Double;
  Stock, WarrantyPeriod: Integer;
  ImagesArray: TJSONArray;
  ImageURL: string;
begin
  FillChar(Result, SizeOf(Result), 0);

  if not ReadCredentials(DMLinkUser, DMLinkPassword) then
    raise Exception.Create('Lipsesc credentialele pentru API-ul DMLINK. Completati randurile ' +
      'USERNAME si PASSWORD in TS_API_CONFIG (meniul Setari > Configurari API).');

  API := TDMLinkAPIClient.Create;
  try
    if not API.Login(DMLinkUser, DMLinkPassword) then
      raise Exception.Create('Autentificare esuata la API-ul DMLink.');
    RawJSON := API.GetAllProducts(0);
  finally
    API.Free;
  end;

  RootValue := TJSONObject.ParseJSONValue(RawJSON);
  if not Assigned(RootValue) then
    raise Exception.Create('Raspuns invalid (JSON) de la API-ul DMLink.');

  try
    ProductsArray := ExtractProductsArray(RootValue);
    if not Assigned(ProductsArray) then
      raise Exception.Create('Nu s-a gasit lista de produse in raspunsul API-ului DMLink.');

    Tr := TIBCTransaction.Create(nil);
    qMaster := TIBCQuery.Create(nil);
    qItem := TIBCQuery.Create(nil);
    qDescr := TIBCQuery.Create(nil);
    qImgDel := TIBCQuery.Create(nil);
    qImgIns := TIBCQuery.Create(nil);
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
        qMaster.ParamByName('FLAGS').AsInteger := 2; // FLG_API
        qMaster.ParamByName('MENTIUNI').AsString := 'Import automat DMLink API';
        qMaster.Options.ReturnParams := True;
        qMaster.ParamCheck := True;
        qMaster.Execute;
        PLID := qMaster.ParamByName('RET_PLID').AsInteger;

        qItem.Connection := FConnection;
        qItem.Transaction := Tr;
        qItem.AutoCommit := False;
        qItem.SQL.Text :=
          'insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, ' +
          'STOCK_QTY, PRICE0, CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, WARANTY, ' +
          'SUPPLIER_GOODS_BRAND, SUPPLIER_CATEGORY) ' +
          'values (:PLID, :SUPPLIER_GOODS_CODE, :SUPPLIER_GOODS_NAME, :STOCK_QTY, :PRICE0, ' +
          ':CURRENCY0ID, :PRICE3, :CURRENCY3ID, :PRICE7, :CURRENCY7ID, :WARANTY, ' +
          ':SUPPLIER_GOODS_BRAND, :SUPPLIER_CATEGORY)';

        qDescr.Connection := FConnection;
        qDescr.Transaction := Tr;
        qDescr.AutoCommit := False;
        qDescr.SQL.Text :=
          'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO) ' +
          'values (:SUPPLIERID, :SUPPLIER_GOODS_CODE, :DESCRIPTION_RO) ' +
          'matching (SUPPLIERID, SUPPLIER_GOODS_CODE)';

        qImgDel.Connection := FConnection;
        qImgDel.Transaction := Tr;
        qImgDel.AutoCommit := False;
        qImgDel.SQL.Text :=
          'delete from TS_PRICELIST_ITEMS_IMAGES where SUPPLIERID = :SUPPLIERID ' +
          'and SUPPLIER_GOODS_CODE = :SUPPLIER_GOODS_CODE';

        qImgIns.Connection := FConnection;
        qImgIns.Transaction := Tr;
        qImgIns.AutoCommit := False;
        qImgIns.SQL.Text :=
          'insert into TS_PRICELIST_ITEMS_IMAGES (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL, PROCESS_DATE, ORDERNO) ' +
          'values (:SUPPLIERID, :SUPPLIER_GOODS_CODE, :IMAGE_URL, :PROCESS_DATE, :ORDERNO)';

        for I := 0 to ProductsArray.Count - 1 do
        begin
          if not (ProductsArray.Items[I] is TJSONObject) then
            Continue;
          ProductObj := TJSONObject(ProductsArray.Items[I]);

          SKU := JStr(ProductObj, 'sku');
          if SKU = '' then
            Continue;

          ProductName := JStr(ProductObj, 'name');
          Description := JStr(ProductObj, 'description');
          if Description = '' then
            Description := JStr(ProductObj, 'shortDescription');

          BrandName := '';
          if ProductObj.TryGetValue('brand', DataValue) and (DataValue is TJSONObject) then
            BrandName := JStr(TJSONObject(DataValue), 'name');

          CategoryName := '';
          if ProductObj.TryGetValue('category', DataValue) and (DataValue is TJSONObject) then
            CategoryName := JStr(TJSONObject(DataValue), 'name');

          RPrice := StrToFloatDef(JStr(ProductObj, 'rprice'), 0);
          SPrice := StrToFloatDef(JStr(ProductObj, 'sprice'), 0);
          NPrice := StrToFloatDef(JStr(ProductObj, 'nprice'), 0);
          Stock := StrToIntDef(JStr(ProductObj, 'stock'), 0);
          WarrantyPeriod := StrToIntDef(JStr(ProductObj, 'warrantyPeriod'), 0);

          qItem.ParamByName('PLID').AsInteger := PLID;
          qItem.ParamByName('SUPPLIER_GOODS_CODE').AsString := SKU;
          qItem.ParamByName('SUPPLIER_GOODS_NAME').AsString := ProductName;
          qItem.ParamByName('STOCK_QTY').AsString := IntToStr(Stock);
          qItem.ParamByName('PRICE0').AsFloat := NPrice;
          qItem.ParamByName('CURRENCY0ID').AsInteger := 840;
          qItem.ParamByName('PRICE3').AsFloat := SPrice;
          qItem.ParamByName('CURRENCY3ID').AsInteger := 840;
          qItem.ParamByName('PRICE7').AsFloat := RPrice;
          qItem.ParamByName('CURRENCY7ID').AsInteger := 840;
          qItem.ParamByName('WARANTY').AsInteger := WarrantyPeriod;
          qItem.ParamByName('SUPPLIER_GOODS_BRAND').AsString := BrandName;
          qItem.ParamByName('SUPPLIER_CATEGORY').AsString := CategoryName;
          qItem.ExecSQL;
          Inc(Result.ProductsImported);

          if Description <> '' then
          begin
            qDescr.ParamByName('SUPPLIERID').AsInteger := FSupplierID;
            qDescr.ParamByName('SUPPLIER_GOODS_CODE').AsString := SKU;
            qDescr.ParamByName('DESCRIPTION_RO').AsString := Description;
            qDescr.ExecSQL;
          end;

          if ProductObj.TryGetValue('images', DataValue) and (DataValue is TJSONArray) then
          begin
            ImagesArray := TJSONArray(DataValue);
            if ImagesArray.Count > 0 then
            begin
              qImgDel.ParamByName('SUPPLIERID').AsInteger := FSupplierID;
              qImgDel.ParamByName('SUPPLIER_GOODS_CODE').AsString := SKU;
              qImgDel.ExecSQL;

              for J := 0 to ImagesArray.Count - 1 do
              begin
                ImageURL := JImageURL(ImagesArray.Items[J]);
                if ImageURL = '' then
                  Continue;

                qImgIns.ParamByName('SUPPLIERID').AsInteger := FSupplierID;
                qImgIns.ParamByName('SUPPLIER_GOODS_CODE').AsString := SKU;
                qImgIns.ParamByName('IMAGE_URL').AsString := ImageURL;
                qImgIns.ParamByName('PROCESS_DATE').AsDateTime := Now;
                qImgIns.ParamByName('ORDERNO').AsInteger := J + 1;
                qImgIns.ExecSQL;
                Inc(Result.ImagesImported);
              end;
            end;
          end;
        end;

        Tr.Commit;
        Result.PLID := PLID;
      except
        if Tr.Active then
          Tr.Rollback;
        raise;
      end;
    finally
      qMaster.Free;
      qItem.Free;
      qDescr.Free;
      qImgDel.Free;
      qImgIns.Free;
      Tr.Free;
    end;
  finally
    RootValue.Free;
  end;
end;

end.

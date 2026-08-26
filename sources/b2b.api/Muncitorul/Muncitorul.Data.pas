unit Muncitorul.Data;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Def, FireDAC.DatS, FireDAC.Comp.Client,
  System.Net.HttpClient, System.Net.URLClient;

type
  {
    TMuncitorulData
    O clasă container care deține și gestionează seturile de date
    pentru Produse, Imagini și Caracteristici.
  }
  TMuncitorulData = class(TObject)
  private
    { --- Modificat --- }
    FProducts: TFDMemTable;
    FImages: TFDMemTable;
    FFeatures: TFDMemTable;
    { --- Sfârșit Modificare --- }

    { Sursă de date internă pentru relația master-detail }
    FDsProducts: TDataSource;

    { Metodă ajutătoare pentru a crea definițiile câmpurilor }
    // --- Modificat ---
    procedure AddField(AMemTable: TFDMemTable; const AName: string;
      ADataType: TFieldType; ASize: Integer = 0);
    // --- Sfârșit Modificare ---

    { Metodă ajutătoare pentru a configura structura seturilor de date }
    procedure SetupDatasets;


  public
    { Constructor și Destructor }
    constructor Create;
    destructor Destroy; override;

    { Metoda principală pentru a încărca datele dintr-un string JSON }
    procedure LoadFromJson(const AJsonString: string);
    function DownloadJsonAsString(const AURL: string): string;

    { Proprietăți publice pentru a accesa seturile de date }
    // --- Modificat ---
    property Products: TFDMemTable read FProducts;
    property Images: TFDMemTable read FImages;
    property Features: TFDMemTable read FFeatures;
    // --- Sfârșit Modificare ---
  end;

implementation



{==============================================================================}
{ TMuncitorulData }
{==============================================================================}

constructor TMuncitorulData.Create;
begin
  inherited Create;

  { --- Modificat --- }
  FProducts := TFDMemTable.Create(nil);
  FImages := TFDMemTable.Create(nil);
  FFeatures := TFDMemTable.Create(nil);
  { --- Sfârșit Modificare --- }

  { Inițializează sursa de date master }
  FDsProducts := TDataSource.Create(nil);

  { Configurează structura și relațiile }
  SetupDatasets;
end;

destructor TMuncitorulData.Destroy;
begin
  { Eliberează resursele în ordine inversă }
  FDsProducts.Free;
  FFeatures.Free;
  FImages.Free;
  FProducts.Free;

  inherited Destroy;
end;

function TMuncitorulData.DownloadJsonAsString(const AURL: string): string;
var
  LHttpClient: THTTPClient; // <-- MODIFICAT AICI
  LResponse: IHTTPResponse;
begin
  Result := ''; // Inițializăm rezultatul

  LHttpClient := THTTPClient.Create; // <-- MODIFICAT AICI
  try
    // 1. Efectuăm cererea GET
    LResponse := LHttpClient.Get(AURL);

    // 2. Verificăm dacă cererea a avut succes (ex: cod 200)
    if LResponse.StatusCode = 200 then
    begin
      // 3. Returnăm conținutul ca string
      Result := LResponse.ContentAsString;
    end
    else
    begin
      // 4. Aruncăm excepția. Acum va funcționa, deoarece ENetHTTPClient este vizibil
      raise ENetHTTPClientException.Create('Serverul a răspuns cu codul de stare: ' +
        LResponse.StatusCode.ToString);
    end;
  finally
    LHttpClient.Free;
  end;
end;

// --- Modificat ---
procedure TMuncitorulData.AddField(AMemTable: TFDMemTable;
  const AName: string; ADataType: TFieldType; ASize: Integer = 0);
// --- Sfârșit Modificare ---
begin
  var LFieldDef := AMemTable.FieldDefs.AddFieldDef;
  LFieldDef.Name := AName;
  LFieldDef.DataType := ADataType;
  if ASize > 0 then
    LFieldDef.Size := ASize;
end;

procedure TMuncitorulData.SetupDatasets;
begin
  { === 1. Configurare Produse (Master) === }
  AddField(FProducts, 'code', ftString, 50);
  AddField(FProducts, 'titluRO', ftString, 255);
  AddField(FProducts, 'titluRU', ftString, 255);
  AddField(FProducts, 'pret_vinz', ftCurrency);
  AddField(FProducts, 'pret_online', ftCurrency);
  AddField(FProducts, 'stoc', ftInteger);
  AddField(FProducts, 'tva', ftString, 50);
  AddField(FProducts, 'categorieRO', ftString, 255);
  AddField(FProducts, 'categorieRU', ftString, 255);
  AddField(FProducts, 'categorieID', ftString, 50);
  AddField(FProducts, 'categorieIMG', ftString, 500);
  AddField(FProducts, 'categorieParentID', ftString, 50);
  AddField(FProducts, 'categorieParentRO', ftString, 255);
  AddField(FProducts, 'categorieParentRU', ftString, 255);
  AddField(FProducts, 'categorieParentIMG', ftString, 500);
  AddField(FProducts, 'brand', ftString, 100);
  AddField(FProducts, 'brand_img', ftString, 500);
  AddField(FProducts, 'link_produs', ftString, 500);
  AddField(FProducts, 'guar_period', ftString, 50);

  { Setează 'code' ca cheie primară }
  FProducts.IndexDefs.Add('idxCode', 'code', [ixPrimary, ixUnique]);
  FProducts.CreateDataSet;
  FProducts.LogChanges := False; // Performanță mai bună la încărcare

  { === 2. Configurare Imagini (Detail) === }
  AddField(FImages, 'code', ftString, 50); // Cheia externă
  AddField(FImages, 'image_url', ftString, 500);

  { Index pe cheia externă pentru master-detail }
  FImages.IndexDefs.Add('idxCode', 'code', []);
  FImages.CreateDataSet;
  FImages.LogChanges := False;

  { === 3. Configurare Caracteristici (Detail) === }
  AddField(FFeatures, 'code', ftString, 50); // Cheia externă
  AddField(FFeatures, 'name_RO', ftString, 255);
  AddField(FFeatures, 'name_RU', ftString, 255);
  AddField(FFeatures, 'value_RO', ftString, 255);
  AddField(FFeatures, 'value_RU', ftString, 255);

  { Index pe cheia externă pentru master-detail }
  FFeatures.IndexDefs.Add('idxCode', 'code', []);
  FFeatures.CreateDataSet;
  FFeatures.LogChanges := False;

  { === 4. Configurare Relații Master-Detail === }
  FDsProducts.DataSet := FProducts;

  { Leagă Imagini de Produse }
  FImages.MasterSource := FDsProducts;
  FImages.MasterFields := 'code'; // Câmpul master (Products)
  FImages.IndexName := 'idxCode';    // Câmpul detail (Images)

  { Leagă Caracteristici de Produse }
  FFeatures.MasterSource := FDsProducts;
  FFeatures.MasterFields := 'code'; // Câmpul master (Products)
  FFeatures.IndexName := 'idxCode';    // Câmpul detail (Features)
end;

procedure TMuncitorulData.LoadFromJson(const AJsonString: string);
var
  LJsonArray: TJSONArray;
  LProductObj: TJSONObject;
  LImagesArray: TJSONArray;
  LFeaturesArray: TJSONArray;
  LCurrentCode: string;
begin
  { Parsează string-ul JSON într-un TJSONArray }
  try
    LJsonArray := TJSONObject.ParseJSONValue(AJsonString) as TJSONArray;
  except
    on E: Exception do
    begin
      // Gestionează eroarea de parsare (ex: afișează un mesaj)
      Exit;
    end;
  end;

  if LJsonArray = nil then
    Exit;

  try
    { Oprește controalele și logarea pentru o încărcare rapidă }
    FProducts.DisableControls;
    try
      { Golește datele existente (aceasta va goli și detaliile) }
      FProducts.EmptyDataSet;

      { Iterează prin fiecare obiect produs din array-ul JSON }
      for var LJsonProduct in LJsonArray do
      begin
        if not (LJsonProduct is TJSONObject) then
          Continue;

        LProductObj := LJsonProduct as TJSONObject;

        { === Adaugă Produsul === }
        FProducts.Append;
        LCurrentCode := LProductObj.GetValue<string>('code', ''); // Salvează codul
        FProducts.FieldByName('code').AsString := LCurrentCode;
        FProducts.FieldByName('titluRO').AsString := LProductObj.GetValue<string>('titluRO', '');
        FProducts.FieldByName('titluRU').AsString := LProductObj.GetValue<string>('titluRU', '');
        FProducts.FieldByName('pret_vinz').AsCurrency := LProductObj.GetValue<Double>('pret_vinz', 0);
        FProducts.FieldByName('pret_online').AsCurrency := LProductObj.GetValue<Double>('pret_online', 0);
        FProducts.FieldByName('stoc').AsInteger := LProductObj.GetValue<Integer>('stoc', 0);
        FProducts.FieldByName('tva').AsString := LProductObj.GetValue<string>('tva', '');
        FProducts.FieldByName('categorieRO').AsString := LProductObj.GetValue<string>('categorieRO', '');
        FProducts.FieldByName('categorieRU').AsString := LProductObj.GetValue<string>('categorieRU', '');
        FProducts.FieldByName('categorieID').AsString := LProductObj.GetValue<string>('categorieID', '');
        FProducts.FieldByName('categorieIMG').AsString := LProductObj.GetValue<string>('categorieIMG', '');
        FProducts.FieldByName('categorieParentID').AsString := LProductObj.GetValue<string>('categorieParentID', '');
        FProducts.FieldByName('categorieParentRO').AsString := LProductObj.GetValue<string>('categorieParentRO', '');
        FProducts.FieldByName('categorieParentRU').AsString := LProductObj.GetValue<string>('categorieParentRU', '');
        FProducts.FieldByName('categorieParentIMG').AsString := LProductObj.GetValue<string>('categorieParentIMG', '');
        FProducts.FieldByName('brand').AsString := LProductObj.GetValue<string>('brand', '');
        FProducts.FieldByName('brand_img').AsString := LProductObj.GetValue<string>('brand_img', '');
        FProducts.FieldByName('link_produs').AsString := LProductObj.GetValue<string>('link_produs', '');
        FProducts.FieldByName('guar_period').AsString := LProductObj.GetValue<string>('guar_period', '');
        FProducts.Post;

        { === Adaugă Imaginile (Detail) === }
        LImagesArray := LProductObj.GetValue<TJSONArray>('imagini');
        if LImagesArray <> nil then
        begin
          for var LJsonImage in LImagesArray do
          begin
            FImages.Append;
            FImages.FieldByName('code').AsString := LCurrentCode; // Link la master
            FImages.FieldByName('image_url').AsString := LJsonImage.Value;
            FImages.Post;
          end;
        end;

        { === Adaugă Caracteristicile (Detail) === }
        LFeaturesArray := LProductObj.GetValue<TJSONArray>('features');
        if LFeaturesArray <> nil then
        begin
          for var LJsonFeature in LFeaturesArray do
          begin
            if not (LJsonFeature is TJSONObject) then
              Continue;

            var LFeatureObj := LJsonFeature as TJSONObject;
            FFeatures.Append;
            FFeatures.FieldByName('code').AsString := LCurrentCode; // Link la master
            FFeatures.FieldByName('name_RO').AsString := LFeatureObj.GetValue<string>('name_RO', '');
            FFeatures.FieldByName('name_RU').AsString := LFeatureObj.GetValue<string>('name_RU', '');
            FFeatures.FieldByName('value_RO').AsString := LFeatureObj.GetValue<string>('value_RO', '');
            FFeatures.FieldByName('value_RU').AsString := LFeatureObj.GetValue<string>('value_RU', '');
            FFeatures.Post;
          end;
        end;

      end; // Sfârșit buclă produse

    finally
      { Repornește controalele și mergi la primul rând }
      FProducts.EnableControls;
      FProducts.First;
    end;
  finally
    LJsonArray.Free; // Eliberează obiectul JSON
  end;
end;

end.

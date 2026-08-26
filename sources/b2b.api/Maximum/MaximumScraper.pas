unit MaximumScraper;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.URLClient,
  System.Threading, System.RegularExpressions, System.Generics.Collections;

type
  // Structura în care vom stoca datele returnate
  TProductData = record
    ProductCode: string;
    OldPrice: string;
    NewPrice: string;
    // Acum stocăm un array de string-uri formatate ca "Cheie = Valoare"
    FeaturesRO: TArray<string>;
    FeaturesRU: TArray<string>;
    IsSuccess: Boolean;
    ErrorMessage: string;
  end;

  // Semnătura pentru evenimentul care se declanșează când datele sunt gata
  TOnScrapeComplete = reference to procedure(const ParsedData: TProductData);

  TMaximumScraper = class
  private
    FProductCode: string;
    FOnComplete: TOnScrapeComplete;
    FBaseURL: string;

    // Funcție ajutătoare pentru extragerea unui șir cu Regex
    function ExtractRegexGroup(const AText, APattern: string; AGroupIndex: Integer): string;
    // Noua funcție rafinată pentru extragerea structurată a caracteristicilor
    function ExtractFeaturesArray(const AHtmlBlock: string): TArray<string>;
    procedure ExecuteTask;
  public
    constructor Create(const AProductCode: string; AOnComplete: TOnScrapeComplete);
    procedure Start;
  end;

implementation

{ TMaximumScraper }

constructor TMaximumScraper.Create(const AProductCode: string; AOnComplete: TOnScrapeComplete);
begin
  FProductCode := AProductCode;
  FOnComplete := AOnComplete;
  FBaseURL := 'https://maximum.md';
end;

procedure TMaximumScraper.Start;
begin
  // Lansăm procesul pe un thread separat pe fundal
  TTask.Run(ExecuteTask);
end;

function TMaximumScraper.ExtractRegexGroup(const AText, APattern: string; AGroupIndex: Integer): string;
var
  Match: TMatch;
begin
  Result := '';
  // Folosim roMultiLine și roIgnoreCase pentru flexibilitate în HTML
  Match := TRegEx.Match(AText, APattern, [roMultiLine, roIgnoreCase]);
  if Match.Success and (Match.Groups.Count >= AGroupIndex) then
    Result := Trim(Match.Groups[AGroupIndex].Value);
end;

function TMaximumScraper.ExtractFeaturesArray(const AHtmlBlock: string): TArray<string>;
var
  Matches: TMatchCollection;
  Match: TMatch;
  Key, Value: string;
  ResultList: TList<string>;
begin
  ResultList := TList<string>.Create;
  try
    // Regex avansat pentru a găsi rândurile de caracteristici.
    // Presupunem că site-ul folosește un tag (span, div, dt) pentru Nume și altul pentru Valoare.
    // Căutăm tag-uri care conțin atribute cu cuvinte cheie gen "name", "title" pentru cheie
    // și "value", "val" pentru valoare.
    // Această expresie prinde majoritatea tabelelor standard de specificații.
    Matches := TRegEx.Matches(AHtmlBlock,
      '<[^>]+class="[^"]*(name|title|lbl)[^"]*"[^>]*>(.*?)</[^>]+>.*?<[^>]+class="[^"]*(value|val)[^"]*"[^>]*>(.*?)</[^>]+>',
      [roIgnoreCase, roSingleLine]);

    // Dacă structura este diferită (ex: <tr><td>Nume</td><td>Valoare</td></tr>),
    // folosim o a doua metodă de siguranță (fallback).
    if Matches.Count = 0 then
    begin
      Matches := TRegEx.Matches(AHtmlBlock, '<tr>\s*<t[dh][^>]*>(.*?)</t[dh]>\s*<t[dh][^>]*>(.*?)</t[dh]>\s*</tr>', [roIgnoreCase, roSingleLine]);
    end;

    for Match in Matches do
    begin
      // În funcție de Regex-ul folosit, indexul grupurilor capturate diferă
      if Match.Groups.Count >= 5 then // Pentru primul Regex
      begin
        Key := Match.Groups[2].Value;
        Value := Match.Groups[4].Value;
      end
      else if Match.Groups.Count >= 3 then // Pentru al doilea Regex (fallback cu <tr>)
      begin
        Key := Match.Groups[1].Value;
        Value := Match.Groups[2].Value;
      end
      else
        Continue;

      // 1. Eliminăm tag-urile HTML rămase în interiorul numelui și valorii
      Key := Trim(TRegEx.Replace(Key, '<[^>]+>', ''));
      Value := Trim(TRegEx.Replace(Value, '<[^>]+>', ''));

      // 2. Curățăm spațiile multiple sau tab-urile (transformăm în spațiu simplu)
      Key := TRegEx.Replace(Key, '\s+', ' ');
      Value := TRegEx.Replace(Value, '\s+', ' ');

      // 3. Adăugăm în listă doar dacă ambele au conținut
      if (Key <> '') and (Value <> '') then
        ResultList.Add(Key + ' = ' + Value);
    end;

    Result := ResultList.ToArray;
  finally
    ResultList.Free;
  end;
end;

procedure TMaximumScraper.ExecuteTask;
var
  ResultData: TProductData;
  HTTP: THTTPClient;
  SearchHtml, ProductUrlPart, ProductHtmlRO, ProductHtmlRU: string;
  FeaturesBlockRO, FeaturesBlockRU: string;
begin
  ResultData.ProductCode := FProductCode;
  ResultData.IsSuccess := False;

  HTTP := THTTPClient.Create;
  try
    try
      // 1. Căutăm produsul după cod
      SearchHtml := HTTP.Get(FBaseURL + '/ru/search?query=' + FProductCode).ContentAsString();

      // 2. Extragem URL-ul produsului
      ProductUrlPart := ExtractRegexGroup(SearchHtml, 'class="[^"]*product__item__image[^"]*".*?<a[^>]+href="([^"]+)"', 1);

      if ProductUrlPart = '' then
        raise Exception.Create('Produsul cu codul ' + FProductCode + ' nu a fost găsit.');

      // Curățăm prefixul de limbă din URL dacă există
      ProductUrlPart := TRegEx.Replace(ProductUrlPart, '^/(ru|ro)/', '/');

      // 3. Pagina în Română (RO)
      ProductHtmlRO := HTTP.Get(FBaseURL + '/ro' + ProductUrlPart).ContentAsString();

      // Prețuri
      ResultData.OldPrice := ExtractRegexGroup(ProductHtmlRO, 'class="[^"]*product__item__price__old[^"]*">([^<]+)<', 1);
      ResultData.NewPrice := ExtractRegexGroup(ProductHtmlRO, 'class="[^"]*current-price[^"]*">([^<]+)<', 1);

      // Caracteristici RO
      FeaturesBlockRO := ExtractRegexGroup(ProductHtmlRO, 'class="[^"]*product-view-features clearfix[^"]*">(.*?)</div>', 1);
      ResultData.FeaturesRO := ExtractFeaturesArray(FeaturesBlockRO);

      // 4. Pagina în Rusă (RU)
      ProductHtmlRU := HTTP.Get(FBaseURL + '/ru' + ProductUrlPart).ContentAsString();

      // Caracteristici RU
      FeaturesBlockRU := ExtractRegexGroup(ProductHtmlRU, 'class="[^"]*product-view-features clearfix[^"]*">(.*?)</div>', 1);
      ResultData.FeaturesRU := ExtractFeaturesArray(FeaturesBlockRU);

      ResultData.IsSuccess := True;
    except
      on E: Exception do
      begin
        ResultData.IsSuccess := False;
        ResultData.ErrorMessage := E.Message;
      end;
    end;
  finally
    HTTP.Free;

    // Trimitem rezultatul înapoi pe Thread-ul Principal
    TThread.Queue(nil,
      procedure
      begin
        if Assigned(FOnComplete) then
          FOnComplete(ResultData);
      end
    );
  end;
end;

end.

unit PWParserUnit;

{ WMSPriceWatch - extragerea produselor dintr-o pagina de categorie cu expresiile
  regulate ale site-ului (TWEB_COMPETITOR_SITES.*_REGEX):
    ITEM_REGEX     - un produs (blocul HTML); se aplica pe toata pagina, roSingleLine
    NAME_REGEX     - denumirea (grupul 1 sau tot ce s-a potrivit) in bloc
    URL_REGEX      - linkul produsului (grupul 1); poate fi relativ
    PRICE_REGEX    - pretul curent (grupul 1), "6 399", "3660.0000"...
    OLDPRICE_REGEX - pretul taiat (optional)
    CODE_REGEX     - codul produsului pe site (optional)
    STOCK_REGEX    - textul despre stoc (optional); NOSTOCK_WORDS = cuvinte (prin ;)
                     care inseamna "nu e in stoc", cautate in textul de stoc sau in bloc
    BLOCK_REGEX    - semne ca site-ul ne-a blocat (captcha, "Just a moment") }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, PWTypes;

type
  TPWParseResult = record
    Items: TArray<TPWSiteItem>;
    Blocked: Boolean;      // BLOCK_REGEX s-a potrivit si nu s-a gasit niciun produs
    Skipped: Integer;      // blocuri fara denumire / pret
    Error: string;         // regex gresit etc.
  end;

function PWParsePage(const ASite: TPWSite; const AHtml: string): TPWParseResult;
// curata HTML-ul dintr-un fragment: taguri, entitati, spatii multiple
function PWStripHtml(const S: string): string;
// URL absolut fata de BaseUrl ("pc-uri/..." sau "/pc-uri/..." -> "https://site/pc-uri/...")
function PWAbsoluteUrl(const ABaseUrl, AUrl: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding, System.StrUtils;

const
  cRx = [roIgnoreCase, roSingleLine];

function PWStripHtml(const S: string): string;
begin
  Result := TRegEx.Replace(S, '<[^>]*>', ' ', [roSingleLine]);
  Result := TNetEncoding.HTML.Decode(Result);
  Result := StringReplace(Result, #160, ' ', [rfReplaceAll]);
  Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
end;

function PWAbsoluteUrl(const ABaseUrl, AUrl: string): string;
var
  U, B: string;
begin
  U := Trim(TNetEncoding.HTML.Decode(AUrl));
  if (U = '') or StartsText('http://', U) or StartsText('https://', U) then
    Exit(U);
  if StartsText('//', U) then
    Exit('https:' + U);
  B := ABaseUrl;
  while (B <> '') and (B[Length(B)] = '/') do
    Delete(B, Length(B), 1);
  if (U <> '') and (U[1] = '/') then
    Result := B + U
  else
    Result := B + '/' + U;
end;

function FirstGroup(const ARegex, AText: string; out AValue: string): Boolean;
var
  M: TMatch;
begin
  AValue := '';
  if Trim(ARegex) = '' then
    Exit(False);
  M := TRegEx.Match(AText, ARegex, cRx);
  Result := M.Success;
  if Result then
  begin
    if M.Groups.Count > 1 then
      AValue := M.Groups[1].Value
    else
      AValue := M.Value;
  end;
end;

function HasNoStockWord(const ANoStockWords, AText: string): Boolean;
var
  Words: TArray<string>;
  W, T: string;
begin
  Result := False;
  if Trim(ANoStockWords) = '' then
    Exit;
  T := AText.ToLower;
  Words := ANoStockWords.Split([';']);
  for W in Words do
    if (Trim(W) <> '') and T.Contains(Trim(W).ToLower) then
      Exit(True);
end;

function PWParsePage(const ASite: TPWSite; const AHtml: string): TPWParseResult;
var
  Matches: TMatchCollection;
  M: TMatch;
  Block, Value, BlockText: string;
  Item: TPWSiteItem;
  List: TList<TPWSiteItem>;
begin
  Result := Default(TPWParseResult);
  List := TList<TPWSiteItem>.Create;
  try
    try
      if Trim(ASite.ItemRegex) = '' then
      begin
        Result.Error := 'ITEM_REGEX necompletat';
        Exit;
      end;
      Matches := TRegEx.Matches(AHtml, ASite.ItemRegex, cRx);
      for M in Matches do
      begin
        Block := M.Value;
        Item := Default(TPWSiteItem);

        if not FirstGroup(ASite.NameRegex, Block, Value) then
        begin
          Inc(Result.Skipped);
          Continue;
        end;
        Item.Title := PWStripHtml(Value);

        if FirstGroup(ASite.UrlRegex, Block, Value) then
          Item.Url := PWAbsoluteUrl(ASite.BaseUrl, Value);

        if FirstGroup(ASite.PriceRegex, Block, Value) then
          Item.Price := PWParseDouble(PWStripHtml(Value));
        if FirstGroup(ASite.OldPriceRegex, Block, Value) then
          Item.OldPrice := PWParseDouble(PWStripHtml(Value));
        if FirstGroup(ASite.CodeRegex, Block, Value) then
          Item.SiteCode := PWStripHtml(Value);

        if FirstGroup(ASite.StockRegex, Block, Value) then
          Item.StockText := PWStripHtml(Value);
        if Item.StockText <> '' then
          Item.InStock := not HasNoStockWord(ASite.NoStockWords, Item.StockText)
        else
        begin
          BlockText := PWStripHtml(Block);
          Item.InStock := not HasNoStockWord(ASite.NoStockWords, BlockText);
        end;

        if (Item.Title = '') or (Item.Price <= 0) or (Item.Url = '') then
        begin
          Inc(Result.Skipped);
          Continue;
        end;
        List.Add(Item);
      end;
      Result.Items := List.ToArray;

      if (Length(Result.Items) = 0) and (Trim(ASite.BlockRegex) <> '') then
        Result.Blocked := TRegEx.IsMatch(AHtml, ASite.BlockRegex, cRx);
    except
      on E: Exception do
        Result.Error := 'Regex: ' + E.Message;
    end;
  finally
    List.Free;
  end;
end;

end.

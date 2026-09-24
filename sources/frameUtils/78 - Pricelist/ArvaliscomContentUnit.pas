unit ArvaliscomContentUnit;

{
  Continut produse de la furnizorul ARVALISCOM (CustomerID 292145, arvaliscom.md),
  analog cu MamicoContentUnit / ImperiaContentUnit.

  Pentru fiecare articol din pricelist:
    1. cautare pe site dupa SUPPLIER_GOODS_CODE:
         https://arvaliscom.md/rezultatul-cautarii/?search=<cod>
       rezultatele sint blocuri "product__item" cu link-ul in location.href='...';
       se deschid pe rind (max. cMaxCandidates) si se accepta primul produs al carui
       "Articol" (primul rind din "Caracteristici principale") coincide cu codul;
    2. pagina RO e cea gasita; pagina RU se ia din comutatorul de limba
       (navbar__menu__language__list, link-ul "Ru" - slug-uri rusesti, fara prefix /ru/);
    3. imaginile: lista "image" din JSON-LD (imaginea principala + galeria), varianta
       /upload/gallery/ in loc de /upload/gallery/thumb/; imaginea principala coincide de
       obicei cu prima din galerie - dublurile se elimina dupa continut;
       fisierele sint JPEG cu extensia .png, conversia in PNG se face la salvare;
    4. descrierea se construieste din blocul "description__container":
       textul de descriere, particularitatile (titlu + text), listele (avantaje, set de
       livrare) si tabelul cu datele tehnice; se omit producatorul si eticheta de garantie.

  Firele de lucru, coada, salvarea si fereastra de progres sint cele din MamicoContentUnit
  (TMamicoContentLoader.RunForPriceItemsEx).
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, MamicoContentUnit;

const
  cArvaliscomSupplierID = 292145;

type
  TArvaliscomContentLoader = class
  public
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);
  end;

// functii pure de parsare (pot fi testate pe HTML salvat)
function ArvaliscomSearchResults(const AHtml: string): TArray<string>;
function ArvaliscomArticle(const AHtml: string): string;
function ArvaliscomRuUrl(const AHtml: string): string;
function ArvaliscomParseGallery(const AHtml: string): TArray<string>;
function ArvaliscomParseDescription(const AHtml: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding;

const
  cBaseUrl = 'https://arvaliscom.md/';
  cRx = [roIgnoreCase, roSingleLine];
  cMaxCandidates = 5;
  // "Artikul" in rusa
  cArticleRu = #$0410#$0440#$0442#$0438#$043A#$0443#$043B;
  // "Proizvoditel" in rusa
  cProducerRu = #$041F#$0440#$043E#$0438#$0437#$0432#$043E#$0434#$0438#$0442#$0435#$043B#$044C;

// doar literele si cifrele, majuscule - "DAHW-ABPR8" = "DAHWABPR8"
function NormCode(const S: string): string;
var
  C: Char;
begin
  Result := '';
  for C in UpperCase(S) do
    if CharInSet(C, ['A'..'Z', '0'..'9']) then
      Result := Result + C;
end;

function EncodePath(const APath: string): string;
var
  Bytes: TBytes;
  B: Byte;
begin
  Result := '';
  Bytes := TEncoding.UTF8.GetBytes(APath);
  for B in Bytes do
    if (B in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('0')..Ord('9')]) or
       (AnsiChar(B) in ['-', '_', '.', '~', '/', '(', ')', '%', '?', '=', '&']) then
      Result := Result + Char(B)
    else
      Result := Result + '%' + IntToHex(B, 2);
end;

function AbsoluteUrl(const AUrl: string): string;
var
  U: string;
begin
  U := Trim(TNetEncoding.HTML.Decode(AUrl));
  U := StringReplace(U, '\/', '/', [rfReplaceAll]);
  if U = '' then
    Result := ''
  else if U.StartsWith('http', True) then
    Result := U
  else
    Result := cBaseUrl + EncodePath(U.TrimLeft(['/']));
end;

function HtmlEscape(const S: string): string;
begin
  Result := StringReplace(S, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
end;

// textul simplu al unui fragment HTML (fara tag-uri, entitati decodate, spatii comprimate),
// gata de pus inapoi in HTML
function PlainText(const S: string): string;
var
  T: string;
begin
  T := TRegEx.Replace(S, '<[^>]*>', ' ');
  T := TNetEncoding.HTML.Decode(T);
  T := StringReplace(T, #$00A0, ' ', [rfReplaceAll]);
  T := Trim(TRegEx.Replace(T, '\s+', ' '));
  Result := HtmlEscape(T);
end;

// pe site unele cuvinte romanesti incep cu litera "C" chirilica (U+0421/U+0441), ex.
// titlul "Caracteristicile" - litera chirilica urmata de o litera latina devine "C"/"c" latin
function FixMixedC(const S: string): string;
var
  I: Integer;
  Buf: string;
begin
  Buf := S;
  for I := 1 to Length(Buf) - 1 do
    if CharInSet(Buf[I + 1], ['a'..'z', 'A'..'Z']) then
      if Buf[I] = #$0421 then
        Buf[I] := 'C'
      else if Buf[I] = #$0441 then
        Buf[I] := 'c';
  Result := Buf;
end;

function ArvaliscomSearchResults(const AHtml: string): TArray<string>;
var
  M: TMatch;
  List: TStringList;
  Url: string;
begin
  List := TStringList.Create;
  try
    for M in TRegEx.Matches(AHtml, 'class="product__item".*?location\.href=''([^'']+)''', cRx) do
    begin
      Url := AbsoluteUrl(M.Groups[1].Value);
      if (Url <> '') and (List.IndexOf(Url) < 0) then
        List.Add(Url);
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function ArvaliscomArticle(const AHtml: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(AHtml,
    '<p[^>]*>\s*(?:Articol|' + cArticleRu + ')\s*</p>\s*<p[^>]*>\s*<span[^>]*>([^<]*)</span>', cRx);
  if M.Success then
    Result := Trim(TNetEncoding.HTML.Decode(M.Groups[1].Value));
end;

function ArvaliscomRuUrl(const AHtml: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(AHtml, 'navbar__menu__language__list.*?<a\s+href="([^"]+)"\s*>\s*Ru\s*<', cRx);
  if M.Success then
    Result := AbsoluteUrl(M.Groups[1].Value);
end;

function ArvaliscomParseGallery(const AHtml: string): TArray<string>;
var
  M, U: TMatch;
  List: TStringList;

  procedure AddUrl(const S: string);
  var
    Url: string;
  begin
    Url := StringReplace(AbsoluteUrl(S), '/upload/gallery/thumb/', '/upload/gallery/', [rfIgnoreCase]);
    if (Url <> '') and (List.IndexOf(Url) < 0) then
      List.Add(Url);
  end;

begin
  List := TStringList.Create;
  try
    // JSON-LD: "image":["...", "..."] sau "image":"..."
    M := TRegEx.Match(AHtml, '"image"\s*:\s*\[(.*?)\]', cRx);
    if M.Success then
    begin
      for U in TRegEx.Matches(M.Groups[1].Value, '"([^"]+)"') do
        AddUrl(U.Groups[1].Value);
    end
    else
    begin
      M := TRegEx.Match(AHtml, '"image"\s*:\s*"([^"]+)"', cRx);
      if M.Success then
        AddUrl(M.Groups[1].Value);
    end;
    // fara JSON-LD - meta og:image
    if List.Count = 0 then
      for U in TRegEx.Matches(AHtml, '<meta\s+property="og:image"\s+content="([^"]+)"', cRx) do
        AddUrl(U.Groups[1].Value);
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function ArvaliscomParseDescription(const AHtml: string): string;
var
  P, Q, Ch, I: Integer;
  Block, Main, Chars, Seg, Title, Head, Part, Txt: string;
  Segs: TArray<string>;
  M: TMatch;
  First: Boolean;
  SB: TStringBuilder;
begin
  Result := '';
  P := Pos('description__container', AHtml);
  if P = 0 then
    Exit;
  Q := Pos('</section>', Copy(AHtml, P, MaxInt));
  if Q > 0 then
    Block := Copy(AHtml, P, Q)
  else
    Block := Copy(AHtml, P, 60000);

  Ch := Pos('characteristics__container', Block);
  if Ch > 0 then
  begin
    Main := Copy(Block, 1, Ch - 1);
    Chars := Copy(Block, Ch, MaxInt);
  end
  else
  begin
    Main := Block;
    Chars := '';
  end;

  SB := TStringBuilder.Create;
  try
    Segs := TRegEx.Split(Main, '<div\s+class="description__wrap"[^>]*>', [roIgnoreCase]);
    First := True;
    for I := 1 to High(Segs) do
    begin
      Seg := Segs[I];
      M := TRegEx.Match(Seg, '<h4[^>]*>(.*?)</h4>', cRx);
      Title := '';
      if M.Success then
        Title := PlainText(M.Groups[1].Value);

      // producatorul si eticheta de garantie nu intra in descriere
      if (Pos('description__wrap__label', Seg) > 0) or
         Title.StartsWith('Produc', True) or Title.StartsWith(cProducerRu, True) then
      begin
        First := False;
        Continue;
      end;

      Head := '';
      if Title <> '' then
        Head := '<h4>' + Title + '</h4>';
      Part := '';

      if Pos('description__wrap__list__item', Seg) > 0 then
      begin
        // particularitati: imagine + titlu + text
        for M in TRegEx.Matches(Seg,
          'description__wrap__list__item__text"[^>]*>\s*<h4[^>]*>(.*?)</h4>\s*<p[^>]*>(.*?)</p>', cRx) do
          Part := Part + '<p><strong>' + PlainText(M.Groups[1].Value) + '</strong><br>' +
            PlainText(M.Groups[2].Value) + '</p>';
        if Part <> '' then
          Part := Head + Part;
      end
      else if TRegEx.IsMatch(Seg, '<li[\s>]', [roIgnoreCase]) then
      begin
        // liste: avantaje, set de livrare
        for M in TRegEx.Matches(Seg, '<li[^>]*>(.*?)</li>', cRx) do
        begin
          Txt := PlainText(M.Groups[1].Value);
          if Txt <> '' then
            Part := Part + '<li>' + Txt + '</li>';
        end;
        if Part <> '' then
          Part := Head + '<ul>' + Part + '</ul>';
      end
      else
      begin
        // text simplu; primul bloc e descrierea propriu-zisa - fara titlul "Descriere"
        M := TRegEx.Match(Seg, 'description__wrap__text"[^>]*>(.*?)</div>', cRx);
        if M.Success then
        begin
          Txt := PlainText(M.Groups[1].Value);
          if Txt <> '' then
          begin
            if First then
              Part := '<p>' + Txt + '</p>'
            else
              Part := Head + '<p>' + Txt + '</p>';
          end;
        end;
      end;

      SB.Append(Part);
      First := False;
    end;

    // datele tehnice: perechi denumire / valoare
    if Chars <> '' then
    begin
      Part := '';
      for M in TRegEx.Matches(Chars,
        '<li[^>]*>\s*<p[^>]*>(.*?)</p>\s*<p[^>]*>\s*<span[^>]*>(.*?)</span>', cRx) do
        Part := Part + '<tr><td>' + PlainText(M.Groups[1].Value) + '</td><td>' +
          PlainText(M.Groups[2].Value) + '</td></tr>';
      if Part <> '' then
      begin
        M := TRegEx.Match(Chars, '<h4[^>]*>(.*?)</h4>', cRx);
        if M.Success and (PlainText(M.Groups[1].Value) <> '') then
          SB.Append('<h4>' + PlainText(M.Groups[1].Value) + '</h4>');
        SB.Append('<table>' + Part + '</table>');
      end;
    end;

    Result := FixMixedC(SB.ToString);
  finally
    SB.Free;
  end;
end;

function SameBytes(const A, B: TBytes): Boolean;
begin
  Result := (Length(A) = Length(B)) and (Length(A) > 0) and CompareMem(@A[0], @B[0], Length(A));
end;

{ TArvaliscomContentLoader }

class function TArvaliscomContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  R: TMamicoItemResult;
  Html, Search, HtmlRu, UrlRu: string;
  Links, Urls: TArray<string>;
  Data: TBytes;
  Found, Dup: Boolean;
  I, J, N: Integer;
begin
  R := TMamicoItemResult.Create(ACode);
  Result := R;
  Found := False;
  Html := '';

  if NormCode(ACode) = '' then
  begin
    R.Log.Add(Format('%s: cod gol', [ACode]));
    Exit;
  end;

  // 1. cautarea pe site dupa cod, verificarea fiecarui candidat dupa "Articol"
  try
    Search := ContentGetPage(AHttp, cBaseUrl + 'rezultatul-cautarii/?search=' +
      TNetEncoding.URL.Encode(Trim(ACode)));
    Links := ArvaliscomSearchResults(Search);
    for I := 0 to High(Links) do
    begin
      if I >= cMaxCandidates then
        Break;
      Html := ContentGetPage(AHttp, Links[I]);
      if NormCode(ArvaliscomArticle(Html)) = NormCode(ACode) then
      begin
        Found := True;
        Break;
      end;
    end;
    if not Found and (Length(Links) > 0) then
      R.Log.Add(Format('  %s: %d rezultate la cautare, niciunul cu acest articol', [ACode, Length(Links)]));
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe arvaliscom.md', [ACode]));
    Exit;
  end;

  // 2. pagina RU
  HtmlRu := '';
  UrlRu := ArvaliscomRuUrl(Html);
  if UrlRu <> '' then
  try
    HtmlRu := ContentGetPage(AHttp, UrlRu);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;

  R.DescRo := ArvaliscomParseDescription(Html);
  if HtmlRu <> '' then
    R.DescRu := ArvaliscomParseDescription(HtmlRu);

  // 3. imaginile - descarcate aici, fara dubluri de continut, convertite in PNG la salvare
  Urls := ArvaliscomParseGallery(Html);
  SetLength(R.ImageUrls, Length(Urls));
  SetLength(R.ImageData, Length(Urls));
  N := 0;
  for I := 0 to High(Urls) do
  begin
    Data := ContentGetBytes(AHttp, Urls[I]);
    if Length(Data) = 0 then
    begin
      R.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, Urls[I]]));
      Continue;
    end;
    Dup := False;
    for J := 0 to N - 1 do
      if SameBytes(R.ImageData[J], Data) then
      begin
        Dup := True;
        Break;
      end;
    if Dup then
      Continue;
    R.ImageUrls[N] := Urls[I];
    R.ImageData[N] := Data;
    Inc(N);
  end;
  SetLength(R.ImageUrls, N);
  SetLength(R.ImageData, N);

  R.Found := (N > 0) or (R.DescRo <> '') or (R.DescRu <> '');
  if not R.Found then
    R.Log.Add(Format('%s: pagina fara imagini si fara descriere', [ACode]));
end;

function ArvaliscomFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TArvaliscomContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TArvaliscomContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  TMamicoContentLoader.RunForPriceItemsEx(AItems, AConnection, ASupplierID, ArvaliscomFetch, 'arvaliscom.md');
end;

end.

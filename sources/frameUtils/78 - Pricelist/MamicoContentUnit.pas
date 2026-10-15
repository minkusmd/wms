unit MamicoContentUnit;

{
  Continut produse de la furnizorul mamico.md (Ad Web Invest SRL, CustomerID 315715).

  Pentru fiecare articol din pricelist:
    1. se cauta pe site dupa SUPPLIER_GOODS_CODE: https://mamico.md/ro/search/?q=<cod>
       - daca codul e gasit exact, site-ul redirectioneaza direct pe pagina produsului
         (og:type = product);
       - produsele epuizate NU apar in cautare - atunci se foloseste PRODUCT_LINK din pricelist;
       - daca pagina gasita are tabel de parametri si niciun parametru nu e egal cu codul,
         rezultatul cautarii e respins (alt produs) si se incearca PRODUCT_LINK;
    2. din pagina se iau link-urile hreflang ro-md / ru-md si se descarca ambele limbi;
    3. imaginile galeriei (cdn.mamico.md/i/?i=/i/products/...) -> TS_PRICELIST_ITEMS_IMAGES,
       in ordinea din galerie (ORDERNO 1 = imaginea principala), IMAGE convertit in PNG;
    4. descrierea (blocul catalog__item__mainDesc_inner) + tabelul de parametri, RO si RU ->
       TS_PRICELIST_ITEMS_DESCRIPTION (DESCRIPTION_RO / DESCRIPTION_RU).

  Paralelism: cMamicoThreadCount fire de lucru iau articolele dintr-un contor comun si fac
  DOAR partea de retea (cautare, pagini RO/RU, descarcarea imaginilor) + parsarea; fiecare fir
  are propriul THTTPClient. Rezultatele intra intr-o coada; firul principal le scoate, converteste
  imaginile WebP -> PNG (TWICImage) si scrie in baza - conexiunea IBDAC nu e folosita din fire.

  Imaginile unui articol se inlocuiesc complet (delete + insert), descrierea prin
  UPDATE OR INSERT - rularea repetata nu creeaza dubluri.
}

interface

uses
  System.SysUtils, System.Classes, Data.DB, IBC, Vcl.Graphics;

const
  cMamicoSupplierID = 315715;
  // latura maxima a imaginilor salvate in TS_PRICELIST_ITEMS_IMAGES (si copiate apoi in TS_GOODS_IMAGE)
  cMaxPriceListImageSide = 1200;
  cMamicoThreadCount = 8;

type
  // rezultatul descarcarii unui articol (produs de un fir de lucru, consumat de firul principal)
  TMamicoItemResult = class
  public
    Code: string;
    Found: Boolean;
    DescRo: string;
    DescRu: string;
    ImageUrls: TArray<string>;
    ImageData: TArray<TBytes>;   // continutul brut descarcat (WebP/JPG); gol = nedescarcata
    Log: TStringList;
    constructor Create(const ACode: string);
    destructor Destroy; override;
  end;

  // descarcarea unui articol de pe site-ul unui furnizor (ruleaza in firele de lucru;
  // AHttp = THTTPClient-ul firului). Folosita de RunForPriceItemsEx - vezi ImperiaContentUnit.
  TContentFetchFunc = function(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;

  TMamicoContentLoader = class
  public
    // descarca si parseaza un articol; fara acces la baza - poate rula in orice fir.
    // AHttp: THTTPClient propriu firului apelant
    class function FetchItem(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;

    // scrie rezultatul in baza (firul principal); intoarce numarul de imagini salvate
    class function SaveItem(AConnection: TIBCConnection; ASupplierID: Integer;
      AResult: TMamicoItemResult): Integer;

    // parcurge dataset-ul de articole (SUPPLIER_GOODS_CODE, PRODUCT_LINK) in
    // cMamicoThreadCount fire, cu fereastra de progres
    class procedure RunForPriceItems(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer);

    // acelasi mecanism (fire, coada, salvare in TS_PRICELIST_ITEMS_IMAGES / _DESCRIPTION,
    // fereastra de progres) pentru alt site: AFetch descarca un articol, ASiteName apare in mesaje.
    // AAskMode = False: fara intrebarea "doar fara continut / toate" - se iau toate articolele din
    // AItems (apelantul le-a filtrat deja). ADelayMs = pauza dupa fiecare articol, pe fir
    // (-1 = cea pentru site-uri, cDelayBetweenItemsMs; 0 pentru fisiere statice, ex. DMLink).
    class procedure RunForPriceItemsEx(AItems: TDataSet; AConnection: TIBCConnection;
      ASupplierID: Integer; AFetch: TContentFetchFunc; const ASiteName: string;
      const AAskMode: Boolean = True; const ADelayMs: Integer = -1);

    // acelasi lucru fara interfata (WMSParsers, poate rula in orice fir): ACodes / ALinks paralele;
    // AThreadCount fire, fiecare cu conexiunea lui (clona lui AConnection), descarca, converteste
    // in PNG si scrie - fara un fir unic de scriere. AOnlyMissing sare codurile care au deja
    // descriere si imagine. AOnLog e apelat sub lacat, din firele de lucru. Intoarce imaginile salvate.
    class function RunForItemsSilent(const ACodes, ALinks: TArray<string>; AConnection: TIBCConnection;
      ASupplierID: Integer; AFetch: TContentFetchFunc; AOnlyMissing: Boolean; AThreadCount, ADelayMs: Integer;
      const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>): Integer;
  end;

// functii HTTP comune (THTTPClient configurat ca pentru mamico, descarcare pagina / octeti)
function CreateContentHttp: TObject;
function ContentGetPage(AHttp: TObject; const AUrl: string): string;
function ContentGetBytes(AHttp: TObject; const AUrl: string): TBytes;

// Micsoreaza proportional imaginea daca o latura depaseste cMaxPriceListImageSide (inlocuieste AImage).
// NexDistribution trimite JPG-uri de 3213x5712 -> PNG-uri de 13-55 MB, care blocau frame78 la deschidere.
// True = imaginea a fost micsorata.
function ShrinkPriceListImage(var AImage: TWICImage): Boolean;

// functii pure de parsare (pot fi testate pe HTML salvat)
function MamicoIsProductPage(const AHtml: string): Boolean;
function MamicoAlternateUrl(const AHtml, AHrefLang: string): string;
function MamicoParseGallery(const AHtml: string): TArray<string>;
function MamicoParseParams(const AHtml: string): TArray<TArray<string>>;
function MamicoParseDescription(const AHtml: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding, System.Net.HttpClient, System.Net.URLClient,
  System.SyncObjs, System.Generics.Collections, System.UITypes, System.StrUtils, System.Math,
  Winapi.ActiveX, Winapi.GDIPOBJ, WebpHelpers, libwebp, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Dialogs;

const
  cBaseUrl = 'https://mamico.md';
  cUserAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' +
    '(KHTML, like Gecko) Chrome/124.0 Safari/537.36';
  cRx = [roIgnoreCase, roSingleLine];
  // pauza fiecarui fir intre doua articole, ca sa nu incarcam site-ul furnizorului
  cDelayBetweenItemsMs = 300;

function ShrinkPriceListImage(var AImage: TWICImage): Boolean;
var
  W, H: Integer;
  Scale: Double;
  Scaled: TWICImage;
begin
  Result := False;
  W := AImage.Width;
  H := AImage.Height;
  if (W <= cMaxPriceListImageSide) and (H <= cMaxPriceListImageSide) then
    Exit;
  Scale := cMaxPriceListImageSide / Max(W, H);
  Scaled := AImage.CreateScaledCopy(Max(1, Round(W * Scale)), Max(1, Round(H * Scale)), wipmHighQualityCubic);
  AImage.Free;
  AImage := Scaled;
  Result := True;
end;

{ ---------------------------------------------------------------------------- }
{ parsare                                                                        }
{ ---------------------------------------------------------------------------- }

// __VIEWSTATE e un base64 urias - il scoatem ca regex-urile sa nu treaca prin el
function StripViewState(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, 'value="/wE[^"]*"', 'value=""');
end;

function StripTags(const S: string): string;
begin
  Result := TRegEx.Replace(S, '<[^>]*>', ' ');
  Result := StringReplace(Result, '&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := TNetEncoding.HTML.Decode(Result);
  Result := StringReplace(Result, #$00A0, ' ', [rfReplaceAll]);
  Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
end;

function MamicoIsProductPage(const AHtml: string): Boolean;
begin
  Result := TRegEx.IsMatch(AHtml, 'og:type"\s+content="product"', cRx);
end;

function MamicoAlternateUrl(const AHtml, AHrefLang: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(AHtml, '<link\s+rel="alternate"\s+hreflang="' + AHrefLang +
    '"\s+href="([^"]+)"', cRx);
  if M.Success then
    Result := M.Groups[1].Value;
end;

function MamicoParseGallery(const AHtml: string): TArray<string>;
var
  Html, Url: string;
  P: Integer;
  M: TMatch;
  List: TStringList;
begin
  // galeria este inaintea descrierii; dupa descriere pot urma produse similare
  Html := AHtml;
  P := Pos('catalog__item__mainDesc', Html);
  if P > 0 then
    Html := Copy(Html, 1, P);

  List := TStringList.Create;
  try
    // doar imaginile in marime originala: fara "&w=..." si fara miniaturile /mini/
    for M in TRegEx.Matches(Html,
      'src="(https://cdn\.mamico\.md/i/\?i=/i/products/[^"&]+\.(?:jpg|jpeg|png|webp))"', cRx) do
    begin
      Url := M.Groups[1].Value;
      if Pos('/mini/', Url) > 0 then
        Continue;
      if List.IndexOf(Url) < 0 then
        List.Add(Url);
    end;
    Result := List.ToStringArray;
  finally
    List.Free;
  end;
end;

function MamicoParseParams(const AHtml: string): TArray<TArray<string>>;
var
  M, Block: TMatch;
  Items: TArray<TArray<string>>;
begin
  Items := nil;
  Block := TRegEx.Match(AHtml, 'id="ctl00_cphMain_divParameters"(.*?)(?:<div id="divVendor"|$)', cRx);
  if Block.Success then
    for M in TRegEx.Matches(Block.Groups[1].Value,
      '<span class="key">(.*?)</span>.*?<span class="val">(.*?)</span>', cRx) do
      Items := Items + [TArray<string>.Create(StripTags(M.Groups[1].Value), StripTags(M.Groups[2].Value))];
  Result := Items;
end;

function MamicoParseDescription(const AHtml: string): string;
var
  M: TMatch;
  Params: TArray<TArray<string>>;
  Pair: TArray<string>;
  Table: string;
begin
  Result := '';
  // <div class="catalog__item__mainDesc_inner shorted" itemprop="description"> ... </div>
  //   <span class="lnk ... catalog__item__lnk_mainDesc">
  // (ancorat pe clasa blocului: in antet exista si <meta itemprop="description">)
  M := TRegEx.Match(AHtml, '<div\s+class="catalog__item__mainDesc_inner[^"]*"[^>]*>(.*?)</div>\s*<span class="lnk', cRx);
  if M.Success then
  begin
    Result := M.Groups[1].Value;
    // atributele tehnice ale editorului site-ului nu ne trebuie
    Result := TRegEx.Replace(Result, '\s(?:data-[\w-]+|class|style|id)="[^"]*"', '', cRx);
    Result := Trim(TRegEx.Replace(Result, '\s+', ' '));
  end;

  Params := MamicoParseParams(AHtml);
  if Length(Params) > 0 then
  begin
    Table := '<table>';
    for Pair in Params do
      Table := Table + '<tr><td>' + TNetEncoding.HTML.Encode(Pair[0]) + '</td><td>' +
        TNetEncoding.HTML.Encode(Pair[1]) + '</td></tr>';
    Table := Table + '</table>';
    if Result <> '' then
      Result := Result + sLineBreak;
    Result := Result + Table;
  end;
end;

// pagina apartine codului cautat? Fara tabel de parametri nu avem cu ce compara - acceptam.
function PageMatchesCode(const AHtml, ACode: string): Boolean;
var
  Params: TArray<TArray<string>>;
  Pair: TArray<string>;
begin
  Params := MamicoParseParams(AHtml);
  if Length(Params) = 0 then
    Exit(True);
  for Pair in Params do
    if SameText(StringReplace(Pair[1], ' ', '', [rfReplaceAll]),
                StringReplace(ACode, ' ', '', [rfReplaceAll])) then
      Exit(True);
  Result := False;
end;


{ ---------------------------------------------------------------------------- }
{ HTTP (fiecare fir are clientul sau)                                            }
{ ---------------------------------------------------------------------------- }

function CreateMamicoHttp: THTTPClient;
begin
  Result := THTTPClient.Create;
  Result.UserAgent := cUserAgent;
  Result.ConnectionTimeout := 15000;
  Result.ResponseTimeout := 30000;
  Result.HandleRedirects := True;
  // limba se ia din URL (/ro/, /ru/), nu din cookie
  Result.AllowCookies := False;
end;

function GetPage(AHttp: THTTPClient; const AUrl: string): string;
var
  Response: IHTTPResponse;
begin
  Response := AHttp.Get(AUrl);
  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt('HTTP %d la %s', [Response.StatusCode, AUrl]);
  Result := StripViewState(Response.ContentAsString(TEncoding.UTF8));
end;

function GetBytes(AHttp: THTTPClient; const AUrl: string): TBytes;
var
  Stream: TBytesStream;
  Response: IHTTPResponse;
begin
  Result := nil;
  Stream := TBytesStream.Create;
  try
    try
      Response := AHttp.Get(AUrl, Stream);
      if (Response.StatusCode = 200) and (Stream.Size > 0) then
        Result := Copy(Stream.Bytes, 0, Stream.Size);
    except
      Result := nil;
    end;
  finally
    Stream.Free;
  end;
end;

function CreateContentHttp: TObject;
begin
  Result := CreateMamicoHttp;
end;

function ContentGetPage(AHttp: TObject; const AUrl: string): string;
begin
  Result := GetPage(AHttp as THTTPClient, AUrl);
end;

function ContentGetBytes(AHttp: TObject; const AUrl: string): TBytes;
begin
  Result := GetBytes(AHttp as THTTPClient, AUrl);
end;

{ ---------------------------------------------------------------------------- }
{ TMamicoItemResult                                                              }
{ ---------------------------------------------------------------------------- }

constructor TMamicoItemResult.Create(const ACode: string);
begin
  inherited Create;
  Code := ACode;
  Log := TStringList.Create;
end;

destructor TMamicoItemResult.Destroy;
begin
  Log.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
{ TMamicoContentLoader                                                           }
{ ---------------------------------------------------------------------------- }

class function TMamicoContentLoader.FetchItem(AHttp: TObject; const ACode,
  AProductLink: string): TMamicoItemResult;
var
  Http: THTTPClient;
  R: TMamicoItemResult;
  Html, HtmlRo, HtmlRu, UrlRo, UrlRu: string;
  Found: Boolean;
  I: Integer;
begin
  Http := AHttp as THTTPClient;
  R := TMamicoItemResult.Create(ACode);
  Result := R;
  Found := False;

  // 1. cautarea pe site dupa cod
  try
    Html := GetPage(Http, cBaseUrl + '/ro/search/?q=' + TNetEncoding.URL.Encode(ACode));
    if MamicoIsProductPage(Html) then
    begin
      if PageMatchesCode(Html, ACode) then
        Found := True
      else
        R.Log.Add(Format('  %s: cautarea a dus la alt articol - se incearca PRODUCT_LINK', [ACode]));
    end;
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la cautare: %s', [ACode, E.Message]));
  end;

  // 2. produsele epuizate nu apar in cautare - link-ul din pricelist
  if not Found and (Trim(AProductLink) <> '') then
  try
    Html := GetPage(Http, Trim(AProductLink));
    Found := MamicoIsProductPage(Html);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: eroare la PRODUCT_LINK: %s', [ACode, E.Message]));
  end;

  if not Found then
  begin
    R.Log.Add(Format('%s: nu a fost gasit pe mamico.md', [ACode]));
    Exit;
  end;

  // 3. ambele limbi (pagina gasita poate fi in oricare dintre ele)
  UrlRo := MamicoAlternateUrl(Html, 'ro-md');
  UrlRu := MamicoAlternateUrl(Html, 'ru-md');
  HtmlRo := '';
  HtmlRu := '';
  if UrlRo <> '' then
  try
    HtmlRo := GetPage(Http, UrlRo);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RO: %s', [ACode, E.Message]));
  end;
  if UrlRu <> '' then
  try
    HtmlRu := GetPage(Http, UrlRu);
  except
    on E: Exception do
      R.Log.Add(Format('  %s: pagina RU: %s', [ACode, E.Message]));
  end;
  if HtmlRo = '' then
    HtmlRo := Html;
  if HtmlRu = '' then
    HtmlRu := HtmlRo;

  R.DescRo := MamicoParseDescription(HtmlRo);
  R.DescRu := MamicoParseDescription(HtmlRu);

  // 4. imaginile - descarcate aici, convertite in PNG pe firul principal
  R.ImageUrls := MamicoParseGallery(HtmlRo);
  SetLength(R.ImageData, Length(R.ImageUrls));
  for I := 0 to High(R.ImageUrls) do
  begin
    R.ImageData[I] := GetBytes(Http, R.ImageUrls[I]);
    if Length(R.ImageData[I]) = 0 then
      R.Log.Add(Format('  %s: imaginea %s nu a putut fi descarcata', [ACode, R.ImageUrls[I]]));
  end;

  R.Found := (Length(R.ImageUrls) > 0) or (R.DescRo <> '') or (R.DescRu <> '');
  if not R.Found then
    R.Log.Add(Format('%s: pagina fara imagini si fara descriere', [ACode]));
end;

// RIFF....WEBP
function IsWebpBytes(const ABytes: TBytes): Boolean;
begin
  Result := (Length(ABytes) >= 12) and (ABytes[0] = Ord('R')) and (ABytes[1] = Ord('I')) and
    (ABytes[2] = Ord('F')) and (ABytes[3] = Ord('F')) and (ABytes[8] = Ord('W')) and
    (ABytes[9] = Ord('E')) and (ABytes[10] = Ord('B')) and (ABytes[11] = Ord('P'));
end;

// Incarca octetii unei imagini (JPG / PNG / WebP) in AWic. WIC citeste WebP doar cind codecul
// "WebP Image Extensions" e instalat in Windows; fara el (ex. imaginile .webp de pe ronixtools.com,
// furnizorul CILITRANS) LoadFromStream ridica EInvalidGraphic si imaginea ramine nesalvata.
// Atunci WebP-ul se decodeaza prin libwebp.dll -> GDI+ -> PNG (ca in frame115Megacom).
procedure LoadPriceListImage(const ABytes: TBytes; AWic: TWICImage);
var
  Raw, Png: TMemoryStream;
  WebpData: PByte;
  GpBmp: TGPBitmap;
begin
  Raw := TMemoryStream.Create;
  try
    Raw.WriteBuffer(ABytes[0], Length(ABytes));
    Raw.Position := 0;
    try
      AWic.LoadFromStream(Raw);
    except
      on E: Exception do
      begin
        if not IsWebpBytes(ABytes) then
          raise;
        WebpData := nil;
        GpBmp := nil;
        Png := TMemoryStream.Create;
        try
          WebpDecode(Raw, WebpData, GpBmp);
          if (WebpData = nil) or (GpBmp = nil) or (GpBmp.GetWidth = 0) then
            raise Exception.Create('WebP nedecodabil (libwebp): ' + E.Message);
          GpBmp.Save(TStreamAdapter.Create(Png, soReference), gPNG);
          if Png.Size = 0 then
            raise Exception.Create('WebP -> PNG (GDI+) a esuat: ' + E.Message);
          Png.Position := 0;
          AWic.LoadFromStream(Png);
        finally
          GpBmp.Free;
          if WebpData <> nil then
            WebPFree(WebpData);
          Png.Free;
        end;
      end;
    end;
  finally
    Raw.Free;
  end;
end;

class function TMamicoContentLoader.SaveItem(AConnection: TIBCConnection; ASupplierID: Integer;
  AResult: TMamicoItemResult): Integer;
var
  Tr: TIBCTransaction;
  Query: TIBCQuery;
  Png: TMemoryStream;
  Wic: TWICImage;
  I: Integer;
begin
  Result := 0;
  Tr := TIBCTransaction.Create(nil);
  Query := TIBCQuery.Create(nil);
  try
    Tr.DefaultConnection := AConnection;
    Query.Connection := AConnection;
    Query.Transaction := Tr;
    Query.UpdateTransaction := Tr;
    Query.AutoCommit := False;

    Tr.StartTransaction;
    try
      // descrierea RO + RU
      if (AResult.DescRo <> '') or (AResult.DescRu <> '') then
      begin
        Query.SQL.Text :=
          'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION ' +
          '  (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO, DESCRIPTION_RU) ' +
          'values (:SUPPLIERID, :CODE, :DESCRIPTION_RO, :DESCRIPTION_RU) ' +
          'matching (SUPPLIERID, SUPPLIER_GOODS_CODE)';
        Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
        Query.ParamByName('CODE').AsString := AResult.Code;
        Query.ParamByName('DESCRIPTION_RO').DataType := ftWideMemo;
        Query.ParamByName('DESCRIPTION_RO').Value := AResult.DescRo;
        Query.ParamByName('DESCRIPTION_RU').DataType := ftWideMemo;
        Query.ParamByName('DESCRIPTION_RU').Value := AResult.DescRu;
        Query.ExecSQL;
      end;

      // imaginile se inlocuiesc complet, ca ordinea sa fie cea din galeria site-ului
      if Length(AResult.ImageUrls) > 0 then
      begin
        Query.SQL.Text :=
          'delete from TS_PRICELIST_ITEMS_IMAGES ' +
          'where SUPPLIERID = :SUPPLIERID and SUPPLIER_GOODS_CODE = :CODE';
        Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
        Query.ParamByName('CODE').AsString := AResult.Code;
        Query.ExecSQL;

        Query.SQL.Text :=
          'insert into TS_PRICELIST_ITEMS_IMAGES ' +
          '  (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL, PROCESS_DATE, ORDERNO, IMAGE) ' +
          'values (:SUPPLIERID, :CODE, :URL, current_timestamp, :ORDERNO, :IMAGE)';

        for I := 0 to High(AResult.ImageUrls) do
        begin
          Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
          Query.ParamByName('CODE').AsString := AResult.Code;
          Query.ParamByName('URL').AsString := AResult.ImageUrls[I];
          Query.ParamByName('ORDERNO').AsInteger := I + 1;
          Query.ParamByName('IMAGE').DataType := ftBlob;
          Query.ParamByName('IMAGE').Clear;

          // CDN-ul intoarce WebP; in baza pastram PNG (ca la ceilalti furnizori)
          if Length(AResult.ImageData[I]) > 0 then
          begin
            Png := TMemoryStream.Create;
            Wic := TWICImage.Create;
            try
              try
                LoadPriceListImage(AResult.ImageData[I], Wic);
                ShrinkPriceListImage(Wic);
                Wic.ImageFormat := wifPng;
                Wic.SaveToStream(Png);
                Png.Position := 0;
                Query.ParamByName('IMAGE').LoadFromStream(Png, ftBlob);
                Inc(Result);
              except
                on E: Exception do
                  AResult.Log.Add(Format('  %s: imaginea %s nu a putut fi convertita: %s',
                    [AResult.Code, AResult.ImageUrls[I], E.Message]));
              end;
            finally
              Wic.Free;
              Png.Free;
            end;
          end;

          Query.ExecSQL;
        end;
      end;

      Tr.Commit;
    except
      Tr.Rollback;
      raise;
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ firele de lucru                                                                }
{ ---------------------------------------------------------------------------- }

type
  TMamicoWorkItem = record
    Code: string;
    Link: string;
  end;

  // starea comuna a unei rulari
  TMamicoJob = class
  public
    Items: TArray<TMamicoWorkItem>;
    NextIndex: Integer;                              // TInterlocked
    Cancelled: Integer;                              // 0/1, TInterlocked
    RunningWorkers: Integer;                         // TInterlocked
    Results: TThreadedQueue<TMamicoItemResult>;
    Fetch: TContentFetchFunc;
    SiteName: string;
    DelayMs: Integer;                                // pauza dupa fiecare articol, pe fir
    constructor Create;
    destructor Destroy; override;
    function IsCancelled: Boolean;
  end;

  TMamicoWorker = class(TThread)
  private
    FJob: TMamicoJob;
  protected
    procedure Execute; override;
  public
    constructor Create(AJob: TMamicoJob);
  end;

constructor TMamicoJob.Create;
begin
  inherited Create;
  // coada practic nelimitata; PopItem cu timeout mic ca firul principal sa ramina responsiv
  Results := TThreadedQueue<TMamicoItemResult>.Create(100000, INFINITE, 50);
end;

destructor TMamicoJob.Destroy;
var
  R: TMamicoItemResult;
begin
  while Results.QueueSize > 0 do
  begin
    R := Results.PopItem;
    R.Free;
  end;
  Results.Free;
  inherited;
end;

function TMamicoJob.IsCancelled: Boolean;
begin
  Result := TInterlocked.CompareExchange(Cancelled, 0, 0) <> 0;
end;

constructor TMamicoWorker.Create(AJob: TMamicoJob);
begin
  FJob := AJob;
  inherited Create(False);
  FreeOnTerminate := False;
end;

procedure TMamicoWorker.Execute;
var
  Http: THTTPClient;
  Index, Waited: Integer;
  R: TMamicoItemResult;
begin
  try
    Http := CreateMamicoHttp;
    try
      while not Terminated and not FJob.IsCancelled do
      begin
        Index := TInterlocked.Increment(FJob.NextIndex) - 1;
        if Index > High(FJob.Items) then
          Break;

        R := nil;
        try
          R := FJob.Fetch(Http, FJob.Items[Index].Code, FJob.Items[Index].Link);
        except
          on E: Exception do
          begin
            R := TMamicoItemResult.Create(FJob.Items[Index].Code);
            R.Log.Add(Format('%s: EROARE %s', [FJob.Items[Index].Code, E.Message]));
          end;
        end;
        FJob.Results.PushItem(R);

        Waited := 0;
        while (Waited < FJob.DelayMs) and not FJob.IsCancelled do
        begin
          Sleep(50);
          Inc(Waited, 50);
        end;
      end;
    finally
      Http.Free;
    end;
  finally
    TInterlocked.Decrement(FJob.RunningWorkers);
  end;
end;

{ ---------------------------------------------------------------------------- }
{ fereastra de progres                                                           }
{ ---------------------------------------------------------------------------- }

type
  TMamicoProgressForm = class(TForm)
  private
    FJob: TMamicoJob;
    procedure StopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    InfoLabel: TLabel;
    LogMemo: TMemo;
    StopButton: TButton;
    Finished: Boolean;
    constructor CreateProgress(AJob: TMamicoJob);
    procedure AddLog(const S: string);
  end;

constructor TMamicoProgressForm.CreateProgress(AJob: TMamicoJob);
begin
  CreateNew(Application);
  FJob := AJob;
  Caption := Format('%s - caracteristici si imagini (%d fire)', [AJob.SiteName, cMamicoThreadCount]);
  Width := 760;
  Height := 500;
  Position := poMainFormCenter;
  BorderIcons := [biSystemMenu];
  OnCloseQuery := FormCloseQuery;

  InfoLabel := TLabel.Create(Self);
  InfoLabel.Parent := Self;
  InfoLabel.Align := alTop;
  InfoLabel.AlignWithMargins := True;
  InfoLabel.Caption := '...';

  StopButton := TButton.Create(Self);
  StopButton.Parent := Self;
  StopButton.Align := alBottom;
  StopButton.AlignWithMargins := True;
  StopButton.Caption := 'Opreste';
  StopButton.OnClick := StopClick;

  LogMemo := TMemo.Create(Self);
  LogMemo.Parent := Self;
  LogMemo.Align := alClient;
  LogMemo.AlignWithMargins := True;
  LogMemo.ReadOnly := True;
  LogMemo.ScrollBars := ssVertical;
end;

procedure TMamicoProgressForm.AddLog(const S: string);
begin
  LogMemo.Lines.Add(FormatDateTime('hh:nn:ss ', Now) + S);
end;

procedure TMamicoProgressForm.StopClick(Sender: TObject);
begin
  if Finished then
    ModalResult := mrClose
  else
  begin
    TInterlocked.Exchange(FJob.Cancelled, 1);
    StopButton.Enabled := False;
    AddLog('Se opreste - se asteapta articolele in curs...');
  end;
end;

procedure TMamicoProgressForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // cit timp ruleaza, inchiderea ferestrei inseamna "Opreste"
  CanClose := Finished;
  if not Finished then
    StopClick(nil);
end;

{ ---------------------------------------------------------------------------- }
{ rularea                                                                        }
{ ---------------------------------------------------------------------------- }

// codurile care au deja si descriere si cel putin o imagine salvata
function LoadCodesWithContent(AConnection: TIBCConnection; ASupplierID: Integer): TStringList;
var
  Query: TIBCQuery;
begin
  Result := TStringList.Create;
  Result.CaseSensitive := True;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := AConnection;
    Query.SQL.Text :=
      'select D.SUPPLIER_GOODS_CODE from TS_PRICELIST_ITEMS_DESCRIPTION D ' +
      'where D.SUPPLIERID = :SUPPLIERID ' +
      '  and exists(select 1 from TS_PRICELIST_ITEMS_IMAGES I ' +
      '             where I.SUPPLIERID = D.SUPPLIERID and I.SUPPLIER_GOODS_CODE = D.SUPPLIER_GOODS_CODE ' +
      '               and I.IMAGE is not null)';
    Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
    Query.Open;
    while not Query.Eof do
    begin
      Result.Add(Query.Fields[0].AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

// lista de lucru se construieste pe firul principal - firele nu ating dataset-ul
function BuildWorkItems(AItems: TDataSet; AExisting: TStringList; out ASkipped: Integer): TArray<TMamicoWorkItem>;
var
  List: TList<TMamicoWorkItem>;
  Item: TMamicoWorkItem;
  Bookmark: TBookmark;
begin
  ASkipped := 0;
  List := TList<TMamicoWorkItem>.Create;
  Bookmark := AItems.GetBookmark;
  AItems.DisableControls;
  try
    AItems.First;
    while not AItems.Eof do
    begin
      Item.Code := Trim(AItems.FieldByName('SUPPLIER_GOODS_CODE').AsString);
      Item.Link := Trim(AItems.FieldByName('PRODUCT_LINK').AsString);
      if Item.Code <> '' then
      begin
        if Assigned(AExisting) and (AExisting.IndexOf(Item.Code) >= 0) then
          Inc(ASkipped)
        else
          List.Add(Item);
      end;
      AItems.Next;
    end;
    Result := List.ToArray;
  finally
    if AItems.BookmarkValid(Bookmark) then
      AItems.GotoBookmark(Bookmark);
    AItems.FreeBookmark(Bookmark);
    AItems.EnableControls;
    List.Free;
  end;
end;

function MamicoFetch(AHttp: TObject; const ACode, AProductLink: string): TMamicoItemResult;
begin
  Result := TMamicoContentLoader.FetchItem(AHttp, ACode, AProductLink);
end;

class procedure TMamicoContentLoader.RunForPriceItems(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer);
begin
  RunForPriceItemsEx(AItems, AConnection, ASupplierID, MamicoFetch, 'mamico.md');
end;

class procedure TMamicoContentLoader.RunForPriceItemsEx(AItems: TDataSet;
  AConnection: TIBCConnection; ASupplierID: Integer; AFetch: TContentFetchFunc;
  const ASiteName: string; const AAskMode: Boolean; const ADelayMs: Integer);
var
  Job: TMamicoJob;
  Workers: TArray<TMamicoWorker>;
  Form: TMamicoProgressForm;
  Existing: TStringList;
  Answer, I, Total, Done, Found, Failed, Skipped, Images: Integer;
  R: TMamicoItemResult;
  S, Summary: string;
begin
  if (AItems = nil) or not AItems.Active or AItems.IsEmpty then
  begin
    MessageDlg('Pricelist-ul nu are articole.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if AAskMode then
  begin
    Answer := MessageDlg('Descarcarea caracteristicilor si imaginilor de pe ' + ASiteName + '.' + sLineBreak +
      sLineBreak + 'Da - doar articolele fara continut' + sLineBreak +
      'Nu - toate articolele (continutul existent se inlocuieste)',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if Answer = mrCancel then
      Exit;
  end
  else
    Answer := mrNo; // toate articolele primite

  Job := TMamicoJob.Create;
  Job.Fetch := AFetch;
  Job.SiteName := ASiteName;
  if ADelayMs >= 0 then
    Job.DelayMs := ADelayMs
  else
    Job.DelayMs := cDelayBetweenItemsMs;
  Form := nil;
  try
    Existing := nil;
    try
      if Answer = mrYes then
        Existing := LoadCodesWithContent(AConnection, ASupplierID);
      Job.Items := BuildWorkItems(AItems, Existing, Skipped);
    finally
      Existing.Free;
    end;

    Total := Length(Job.Items);
    if Total = 0 then
    begin
      MessageDlg(Format('Nu sint articole de procesat (%d au deja continut).', [Skipped]),
        mtInformation, [mbOK], 0);
      Exit;
    end;

    Form := TMamicoProgressForm.CreateProgress(Job);
    Form.Show;
    if Assigned(Application.MainForm) then
      Application.MainForm.Enabled := False;
    try
      Form.AddLog(Format('%d articole de procesat in %d fire, %d sarite (au deja continut)',
        [Total, cMamicoThreadCount, Skipped]));

      Done := 0;
      Found := 0;
      Failed := 0;
      Images := 0;

      Job.RunningWorkers := cMamicoThreadCount;
      SetLength(Workers, cMamicoThreadCount);
      for I := 0 to High(Workers) do
        Workers[I] := TMamicoWorker.Create(Job);
      try
        // firul principal: scoate rezultatele, scrie in baza, actualizeaza fereastra
        while (TInterlocked.CompareExchange(Job.RunningWorkers, 0, 0) > 0) or
              (Job.Results.QueueSize > 0) do
        begin
          if Job.Results.PopItem(R) = wrSignaled then
          try
            Inc(Done);
            try
              if R.Found then
              begin
                Inc(Images, SaveItem(AConnection, ASupplierID, R));
                Inc(Found);
                R.Log.Add(Format('%s: %d imagini, descriere RO %d / RU %d caractere',
                  [R.Code, Length(R.ImageUrls), Length(R.DescRo), Length(R.DescRu)]));
              end
              else
                Inc(Failed);
            except
              on E: Exception do
              begin
                Inc(Failed);
                R.Log.Add(Format('%s: EROARE la salvare: %s', [R.Code, E.Message]));
              end;
            end;
            for S in R.Log do
              Form.AddLog(S);
          finally
            R.Free;
          end;

          Form.InfoLabel.Caption := Format('%d / %d   gasite: %d   imagini: %d   negasite/erori: %d   sarite: %d',
            [Done, Total, Found, Images, Failed, Skipped]);
          Application.ProcessMessages;
        end;
      finally
        // la o exceptie neasteptata firele trebuie oprite inainte de eliberarea Job
        TInterlocked.Exchange(Job.Cancelled, 1);
        for I := 0 to High(Workers) do
        begin
          Workers[I].WaitFor;
          Workers[I].Free;
        end;
      end;

      Summary := Format('%s: %d / %d   gasite: %d   imagini: %d   negasite/erori: %d   sarite: %d',
        [IfThen(Done < Total, 'Oprit', 'Gata'), Done, Total, Found, Images, Failed, Skipped]);
      Form.InfoLabel.Caption := Summary;
      Form.AddLog(Summary);
    finally
      if Assigned(Application.MainForm) then
        Application.MainForm.Enabled := True;
    end;

    // fereastra ramine deschisa cu jurnalul pina o inchide utilizatorul
    Form.Finished := True;
    Form.StopButton.Enabled := True;
    Form.StopButton.Caption := 'Inchide';
    Form.Hide;
    Form.ShowModal;
  finally
    Form.Free;
    Job.Free;
  end;
end;

class function TMamicoContentLoader.RunForItemsSilent(const ACodes, ALinks: TArray<string>;
  AConnection: TIBCConnection; ASupplierID: Integer; AFetch: TContentFetchFunc; AOnlyMissing: Boolean;
  AThreadCount, ADelayMs: Integer; const AOnLog: TProc<string>; const AIsCancelled: TFunc<Boolean>): Integer;
var
  Existing: TStringList;
  List: TList<TMamicoWorkItem>;
  Item: TMamicoWorkItem;
  Work: TArray<TMamicoWorkItem>;
  Template: TIBCConnection;
  Threads: TArray<TThread>;
  LogLock: TCriticalSection;
  NextIndex, Saved, Found, Failed, Done, Total, Skipped, I: Integer;
  // variabile (nu proceduri locale): metodele anonime ale firelor le pot captura
  Log: TProc<string>;
  Cancelled: TFunc<Boolean>;
  OnLog: TProc<string>;
  IsCancelled: TFunc<Boolean>;
begin
  Result := 0;
  OnLog := AOnLog;
  IsCancelled := AIsCancelled;
  Log :=
    procedure(S: string)
    begin
      if not Assigned(OnLog) then
        Exit;
      LogLock.Enter;
      try
        OnLog(S);
      finally
        LogLock.Leave;
      end;
    end;
  Cancelled :=
    function: Boolean
    begin
      Result := Assigned(IsCancelled) and IsCancelled();
    end;
  Skipped := 0;
  Existing := nil;
  List := TList<TMamicoWorkItem>.Create;
  try
    if AOnlyMissing then
      Existing := LoadCodesWithContent(AConnection, ASupplierID);
    for I := 0 to High(ACodes) do
    begin
      Item.Code := Trim(ACodes[I]);
      if Item.Code = '' then
        Continue;
      if Assigned(Existing) and (Existing.IndexOf(Item.Code) >= 0) then
      begin
        Inc(Skipped);
        Continue;
      end;
      if I <= High(ALinks) then
        Item.Link := Trim(ALinks[I])
      else
        Item.Link := '';
      List.Add(Item);
    end;
    Work := List.ToArray;
  finally
    List.Free;
    Existing.Free;
  end;

  Total := Length(Work);
  if Assigned(AOnLog) then
    AOnLog(Format('Imagini: %d articole de procesat in %d fire, %d sarite (au deja continut)',
      [Total, Min(AThreadCount, Total), Skipped]));
  if Total = 0 then
    Exit;

  NextIndex := 0;
  Saved := 0;
  Found := 0;
  Failed := 0;
  Done := 0;
  LogLock := TCriticalSection.Create;
  Template := TIBCConnection.Create(nil);
  try
    // doar proprietatile conexiunii; evenimentele (dialoguri, VCL) nu au ce cauta in fire
    Template.Assign(AConnection);
    Template.LoginPrompt := False;
    Template.ConnectDialog := nil;
    Template.OnError := nil;
    Template.OnLogin := nil;
    Template.BeforeConnect := nil;
    Template.AfterConnect := nil;
    Template.BeforeDisconnect := nil;
    Template.AfterDisconnect := nil;

    SetLength(Threads, Max(1, Min(AThreadCount, Total)));
    for I := 0 to High(Threads) do
    begin
      Threads[I] := TThread.CreateAnonymousThread(
        procedure
        var
          Http: THTTPClient;
          Conn: TIBCConnection;
          Index, N: Integer;
          R: TMamicoItemResult;
          Lines: TArray<string>;
          S: string;
        begin
          // TWICImage (conversia in PNG) are nevoie de COM in fiecare fir
          CoInitialize(nil);
          Http := nil;
          Conn := nil;
          try
            try
              Http := CreateMamicoHttp;
              Conn := TIBCConnection.Create(nil);
              Conn.Assign(Template);
              Conn.Connect;
              while not Cancelled do
              begin
                Index := TInterlocked.Increment(NextIndex) - 1;
                if Index >= Total then
                  Break;
                R := nil;
                try
                  try
                    R := AFetch(Http, Work[Index].Code, Work[Index].Link);
                    if R.Found then
                    begin
                      TInterlocked.Add(Saved, SaveItem(Conn, ASupplierID, R));
                      TInterlocked.Increment(Found);
                    end
                    else
                      TInterlocked.Increment(Failed);
                  except
                    on E: Exception do
                    begin
                      TInterlocked.Increment(Failed);
                      if R = nil then
                        R := TMamicoItemResult.Create(Work[Index].Code);
                      R.Log.Add(Format('%s: EROARE %s', [Work[Index].Code, E.Message]));
                    end;
                  end;
                  Lines := R.Log.ToStringArray;
                finally
                  R.Free;
                end;
                for S in Lines do
                  Log(S);
                N := TInterlocked.Increment(Done);
                if N mod 250 = 0 then
                  Log(Format('Imagini: %d / %d articole, %d imagini salvate', [N, Total,
                    TInterlocked.CompareExchange(Saved, 0, 0)]));
                if ADelayMs > 0 then
                  Sleep(ADelayMs);
              end;
            except
              on E: Exception do
                Log('Imagini: EROARE in firul de lucru: ' + E.Message);
            end;
          finally
            Conn.Free;
            Http.Free;
            CoUninitialize;
          end;
        end);
      Threads[I].FreeOnTerminate := False;
      Threads[I].Start;
    end;
    for I := 0 to High(Threads) do
    begin
      Threads[I].WaitFor;
      Threads[I].Free;
    end;
  finally
    Template.Free;
    LogLock.Free;
  end;

  Result := Saved;
  if Assigned(AOnLog) then
    AOnLog(Format('Imagini %s: %d / %d articole, gasite %d, imagini salvate %d, negasite/erori %d',
      [IfThen(Done < Total, 'oprit', 'gata'), Done, Total, Found, Saved, Failed]));
end;

end.

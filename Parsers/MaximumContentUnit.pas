unit MaximumContentUnit;

(* Imagini si caracteristici de pe maximum.md (furnizor 229873).
   Convertit din D:\Projects\pythonProject\2025\.venv\maximum.py.

   Pentru articolele din ultimul pricelist al furnizorului carora le lipsesc imaginile sau
   descrierea:
     1. produsul se cauta prin API-ul de sugestii -> "_id" (pagina: https://maximum.md/ro/<_id>/)
     2. din pagina RO: galeria, in ordinea reala, si caracteristicile
        din pagina RU: caracteristicile in rusa
     3. TS_PRICELIST_ITEMS_IMAGES       - URL-urile imaginilor cu ORDERNO = pozitia in galerie
        TS_PRICELIST_ITEMS_DESCRIPTION  - caracteristicile ca tabel HTML (DESCRIPTION_RO / _RU)
     4. imaginile fara continut (IMAGE is null) se descarca si se salveaza ca PNG

   Diferente fata de scriptul Python:
     - fara Selenium / Chrome: pagina produsului vine gata randata de la server, deci ajunge un
       client HTTP. Ordinea galeriei se ia tot din atributul data-img-name (0 = imaginea
       principala), nu din ordinea din DOM.
     - DESCRIPTION_RU primeste textul rusesc real de pe /ru/<_id>/ (scriptul punea textul
       romanesc in ambele coloane); daca pagina RU nu da nimic, ramine textul romanesc.
     - produsul se cauta cu MaximumFindProduct: primul rezultat, acceptat doar daca "Cod produs"
       de pe pagina lui e exact codul cautat (pagina RO descarcata pentru verificare se
       refoloseste mai jos).
     - caracteristicile se cauta si pentru produsele care au deja imagini, dar nu au descriere
       (scriptul le sarea). Valorile sint HTML-escapate in tabel.
     - cei doi pasi ai scriptului (1 = URL-uri + descrieri, 2 = conversie imagini) ruleaza
       unul dupa altul in acelasi job. *)

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, IBC, ParserJobUnit;

type
  TMaximumFeature = record
    Name: string;
    Value: string;
  end;

  TMaximumContentJob = class(TParserJob)
  public
    class function JobName: string; override;
    class function DisplayName: string; override;
    function Run: TParserJobResult; override;
  end;

// Interpretarea paginii produsului, separata de retea ca sa poata fi testata pe HTML salvat.

// URL-urile imaginilor din galerie, in ordinea reala, normalizate la varianta "original".
function MaximumParseGallery(const AHtml: string): TArray<string>;
function MaximumParseFeatures(const AHtml: string): TArray<TMaximumFeature>;
// <table><tr><td>nume</td><td>valoare</td></tr>...</table> - formatul scris si de scriptul Python
function MaximumFeaturesToHtml(const AFeatures: TArray<TMaximumFeature>): string;
function MaximumNormalizeCdnUrl(const AUrl: string): string;

implementation

uses
  System.RegularExpressions, System.NetEncoding, System.Net.HttpClient, System.Net.URLClient,
  Winapi.ActiveX, Vcl.Graphics, Vcl.Forms, Data.DB, MaximumPriceSourceUnit;

const
  cSupplierID = 229873;
  cBaseUrl = 'https://maximum.md';
  cDefaultDelayMs = 3000; // DELAY_SECONDS = 3 din scriptul Python
  cImageRetries = 3;
  cRx = [roIgnoreCase, roSingleLine];
  cCdnMarker = 'simpalsmedia.com/marketplace/products';

{ interpretarea paginii }

function StripTags(const AHtml: string): string;
begin
  Result := TRegEx.Replace(AHtml, '<[^>]*>', ' ');
  Result := TNetEncoding.HTML.Decode(Result.Replace('&nbsp;', ' ', [rfReplaceAll, rfIgnoreCase])).Replace(#$00A0, ' ');
  Result := TRegEx.Replace(Result, '\s+', ' ').Trim;
end;

function MaximumNormalizeCdnUrl(const AUrl: string): string;
var
  M: TMatch;
begin
  // thumbor: https://i.simpalsmedia.com/thumbor/NxN/i.simpalsmedia.com/marketplace/products/SIZE/HASH.jpg
  M := TRegEx.Match(AUrl,
    '^https://i\.simpalsmedia\.com/thumbor/\d+x\d+/i\.simpalsmedia\.com/marketplace/products/[^/]+/(.+)$', cRx);
  if M.Success then
    Exit('https://i.simpalsmedia.com/marketplace/products/original/' + M.Groups[1].Value);
  // direct: https://i.simpalsmedia.com/marketplace/products/SIZE/HASH.jpg
  M := TRegEx.Match(AUrl, '^(https://i\.simpalsmedia\.com/marketplace/products/)[^/]+(/.+)$', cRx);
  if M.Success then
    Exit(M.Groups[1].Value + 'original' + M.Groups[2].Value);
  Result := AUrl;
end;

function MaximumParseGallery(const AHtml: string): TArray<string>;
var
  Slides, Links: TMatchCollection;
  I, J, BlockEnd, Position: Integer;
  Block, Url: string;
  ByPosition: TDictionary<Integer, string>;
  Positions: TList<Integer>;
  Seen: TList<string>;
begin
  Result := nil;
  ByPosition := TDictionary<Integer, string>.Create;
  Positions := TList<Integer>.Create;
  Seen := TList<string>.Create;
  try
    // Fiecare slide din sliderul principal are data-img-name = pozitia lui (0 = principala).
    // Ordinea din DOM nu e de incredere: sliderul cloneaza si roteste slide-urile.
    Slides := TRegEx.Matches(AHtml, '<[^>]*\bdata-img-name="(\d+)"[^>]*>', cRx);
    for I := 0 to Slides.Count - 1 do
    begin
      Position := StrToIntDef(Slides[I].Groups[1].Value, -1);
      if (Position < 0) or ByPosition.ContainsKey(Position) then
        Continue;
      if I < Slides.Count - 1 then
        BlockEnd := Slides[I + 1].Index
      else
        BlockEnd := Slides[I].Index + 4000;
      Block := Copy(AHtml, Slides[I].Index, BlockEnd - Slides[I].Index);
      Links := TRegEx.Matches(Block, '<a\b[^>]*\bclass="[^"]*js-product-image[^"]*"[^>]*\bhref="([^"]+)"', cRx);
      if Links.Count = 0 then
        Links := TRegEx.Matches(Block, '<a\b[^>]*\bhref="([^"]+)"[^>]*\bclass="[^"]*js-product-image', cRx);
      for J := 0 to Links.Count - 1 do
      begin
        Url := TNetEncoding.HTML.Decode(Links[J].Groups[1].Value);
        if Pos(cCdnMarker, Url) > 0 then
        begin
          ByPosition.Add(Position, MaximumNormalizeCdnUrl(Url));
          Positions.Add(Position);
          Break;
        end;
      end;
    end;

    Positions.Sort;
    for I := 0 to Positions.Count - 1 do
    begin
      Url := ByPosition[Positions[I]];
      if not Seen.Contains(Url) then
        Seen.Add(Url);
    end;

    // rezerva: o singura imagine, fara slider
    if Seen.Count = 0 then
    begin
      Links := TRegEx.Matches(AHtml, '<a\b[^>]*\bclass="[^"]*js-product-image[^"]*"[^>]*\bhref="([^"]+)"', cRx);
      for J := 0 to Links.Count - 1 do
      begin
        Url := TNetEncoding.HTML.Decode(Links[J].Groups[1].Value);
        if Pos(cCdnMarker, Url) > 0 then
        begin
          Seen.Add(MaximumNormalizeCdnUrl(Url));
          Break;
        end;
      end;
    end;

    Result := Seen.ToArray;
  finally
    Seen.Free;
    Positions.Free;
    ByPosition.Free;
  end;
end;

function MaximumParseFeatures(const AHtml: string): TArray<TMaximumFeature>;
var
  P, PEnd: Integer;
  Block: string;
  Items: TMatchCollection;
  I: Integer;
  NameHtml, ValueHtml: string;
  Feature: TMaximumFeature;
  List: TList<TMaximumFeature>;
begin
  Result := nil;
  P := Pos('product-view-features', AHtml);
  if P = 0 then
    Exit;
  Block := Copy(AHtml, P, MaxInt);
  // containerul se termina la urmatorul tab al paginii
  PEnd := Pos('class="tabs_item"', Block);
  if PEnd > 0 then
    Block := Copy(Block, 1, PEnd);

  List := TList<TMaximumFeature>.Create;
  try
    Items := TRegEx.Matches(Block, '<li\b[^>]*\bclass="[^"]*feature-list-item[^"]*"[^>]*>(.*?)</li>', cRx);
    for I := 0 to Items.Count - 1 do
    begin
      // numele = primul <span> din partea stinga; restul partii stingi e butonul cu explicatia
      NameHtml := TRegEx.Match(Items[I].Groups[1].Value,
        'feature-list-item_left[^>]*>\s*<span[^>]*>(.*?)</span>', cRx).Groups[1].Value;
      ValueHtml := TRegEx.Match(Items[I].Groups[1].Value,
        'feature-list-item_right[^>]*>(.*?)</span>', cRx).Groups[1].Value;
      Feature.Name := StripTags(NameHtml);
      Feature.Value := StripTags(ValueHtml);
      if (Feature.Name <> '') or (Feature.Value <> '') then
        List.Add(Feature);
    end;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function MaximumFeaturesToHtml(const AFeatures: TArray<TMaximumFeature>): string;
var
  SB: TStringBuilder;
  F: TMaximumFeature;
begin
  if Length(AFeatures) = 0 then
    Exit('');
  SB := TStringBuilder.Create;
  try
    SB.Append('<table>');
    for F in AFeatures do
      SB.Append('<tr><td>').Append(TNetEncoding.HTML.Encode(F.Name)).Append('</td><td>')
        .Append(TNetEncoding.HTML.Encode(F.Value)).Append('</td></tr>');
    SB.Append('</table>');
    Result := SB.ToString;
  finally
    SB.Free;
  end;
end;

{ TMaximumContentJob }

class function TMaximumContentJob.JobName: string;
begin
  Result := 'maximum-content';
end;

class function TMaximumContentJob.DisplayName: string;
begin
  Result := Format('Imagini + caracteristici Maximum (maximum.md)  -  furnizor %d', [cSupplierID]);
end;

function TMaximumContentJob.Run: TParserJobResult;
type
  TCandidate = record
    GoodsID: Integer;
    Code: string;
    NeedImages: Boolean;
    NeedDescription: Boolean;
  end;
var
  Http: THTTPClient;
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  Candidates: TList<TCandidate>;
  Candidate: TCandidate;
  ComInitialized: Boolean;
  DelayMs: Integer;
  I, J: Integer;
  Found, NotFound, Errors, ImagesAdded, DescriptionsSaved, Downloaded, DownloadFailed: Integer;

  procedure Pause(const AMs: Integer);
  var
    Waited: Integer;
  begin
    Waited := 0;
    while (Waited < AMs) and not FCancelled do
    begin
      Sleep(100);
      Inc(Waited, 100);
      // doar pe firul principal: in WMSParsers joburile ruleaza in fire separate
      if (Application <> nil) and (TThread.CurrentThread.ThreadID = MainThreadID) then
        Application.ProcessMessages;
    end;
  end;

  function GetPage(const AUrl: string): string;
  var
    Response: IHTTPResponse;
  begin
    Response := Http.Get(AUrl);
    if Response.StatusCode <> 200 then
      raise Exception.CreateFmt('HTTP %d la %s', [Response.StatusCode, AUrl]);
    Result := Response.ContentAsString(TEncoding.UTF8);
  end;

  procedure LoadCandidates;
  begin
    Tr.StartTransaction;
    try
      Query.SQL.Text :=
        'select GF.GOODSID, PI.SUPPLIER_GOODS_CODE, ' +
        '  iif(not exists(select 1 from TS_GOODS_IMAGE GI where GI.GOODSID = GF.GOODSID) ' +
        '      and not exists(select 1 from TS_PRICELIST_ITEMS_IMAGES IM ' +
        '                     where IM.SUPPLIERID = P.SUPPLIERID and IM.SUPPLIER_GOODS_CODE = PI.SUPPLIER_GOODS_CODE ' +
        '                       and IM.IMAGE_URL <> ''''), 1, 0) NEED_IMAGES, ' +
        '  iif(not exists(select 1 from TS_PRICELIST_ITEMS_DESCRIPTION D ' +
        '                 where D.SUPPLIERID = P.SUPPLIERID and D.SUPPLIER_GOODS_CODE = PI.SUPPLIER_GOODS_CODE) ' +
        '      and not exists(select 1 from TS_GOODS_DSC GD where GD.GOODSID = GF.GOODSID), 1, 0) NEED_DESCRIPTION ' +
        'from TS_PRICELIST_ITEMS PI ' +
        'join TS_PRICELISTS P on P.PLID = PI.PLID ' +
        'join TS_GOODS_FOREIGN GF on GF.CUSTOMERID = P.SUPPLIERID and GF.GOODS_CODE = PI.SUPPLIER_GOODS_CODE ' +
        'where P.SUPPLIERID = :SUPPLIERID ' +
        '  and P.PLID = (select max(PLID) from TS_PRICELISTS where SUPPLIERID = :SUPPLIERID2) ' +
        '  and not exists(select 1 from TS_PRICELIST_EXCLUSIOINS PE ' +
        '                 where PE.SUPPLIERID = P.SUPPLIERID and PE.SUPPLIER_GOODS_CODE = PI.SUPPLIER_GOODS_CODE)';
      Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
      Query.ParamByName('SUPPLIERID2').AsInteger := cSupplierID;
      Query.Open;
      while not Query.Eof do
      begin
        Candidate.GoodsID := Query.FieldByName('GOODSID').AsInteger;
        Candidate.Code := Trim(Query.FieldByName('SUPPLIER_GOODS_CODE').AsString);
        Candidate.NeedImages := Query.FieldByName('NEED_IMAGES').AsInteger = 1;
        Candidate.NeedDescription := Query.FieldByName('NEED_DESCRIPTION').AsInteger = 1;
        if (Candidate.Code <> '') and (Candidate.NeedImages or Candidate.NeedDescription) then
          Candidates.Add(Candidate);
        Query.Next;
      end;
      Query.Close;
    finally
      if Tr.Active then
        Tr.Rollback;
    end;
  end;

  // Intoarce cite URL-uri noi au fost inserate
  function SaveImages(const ACode: string; const AUrls: TArray<string>): Integer;
  var
    K: Integer;
  begin
    Result := 0;
    Tr.StartTransaction;
    try
      for K := 0 to High(AUrls) do
      begin
        Query.SQL.Text :=
          'select count(*) from TS_PRICELIST_ITEMS_IMAGES ' +
          'where SUPPLIERID = :SUPPLIERID and SUPPLIER_GOODS_CODE = :CODE and IMAGE_URL = :URL';
        Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
        Query.ParamByName('CODE').AsString := ACode;
        Query.ParamByName('URL').AsString := AUrls[K];
        Query.Open;
        if Query.Fields[0].AsInteger = 0 then
        begin
          Query.Close;
          Query.SQL.Text :=
            'insert into TS_PRICELIST_ITEMS_IMAGES (SUPPLIERID, SUPPLIER_GOODS_CODE, IMAGE_URL, PROCESS_DATE, ORDERNO) ' +
            'values (:SUPPLIERID, :CODE, :URL, current_timestamp, :ORDERNO)';
          Inc(Result);
        end
        else
        begin
          // URL-ul exista deja: doar ii fixam pozitia din galerie
          Query.Close;
          Query.SQL.Text :=
            'update TS_PRICELIST_ITEMS_IMAGES set ORDERNO = :ORDERNO ' +
            'where SUPPLIERID = :SUPPLIERID and SUPPLIER_GOODS_CODE = :CODE and IMAGE_URL = :URL';
        end;
        Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
        Query.ParamByName('CODE').AsString := ACode;
        Query.ParamByName('URL').AsString := AUrls[K];
        Query.ParamByName('ORDERNO').AsInteger := K + 1;
        Query.Execute;
      end;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  end;

  procedure SaveDescription(const ACode, AHtmlRo, AHtmlRu: string);
  begin
    Tr.StartTransaction;
    try
      Query.SQL.Text :=
        'update or insert into TS_PRICELIST_ITEMS_DESCRIPTION (SUPPLIERID, SUPPLIER_GOODS_CODE, DESCRIPTION_RO, DESCRIPTION_RU) ' +
        'values (:SUPPLIERID, :CODE, :DESCRIPTION_RO, :DESCRIPTION_RU) matching (SUPPLIERID, SUPPLIER_GOODS_CODE)';
      Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
      Query.ParamByName('CODE').AsString := ACode;
      // BLOB text: tipul se fixeaza explicit, altfel parametrul ar merge ca VARCHAR (limita de lungime)
      Query.ParamByName('DESCRIPTION_RO').DataType := ftWideMemo;
      Query.ParamByName('DESCRIPTION_RO').Value := AHtmlRo;
      Query.ParamByName('DESCRIPTION_RU').DataType := ftWideMemo;
      Query.ParamByName('DESCRIPTION_RU').Value := AHtmlRu;
      Query.Execute;
      Tr.Commit;
    except
      if Tr.Active then
        Tr.Rollback;
      raise;
    end;
  end;

  procedure ProcessCandidate(const C: TCandidate);
  var
    ProductID: Int64;
    Price: Currency;
    Title, PageRo, PageRu, HtmlRo, HtmlRu: string;
    Urls: TArray<string>;
    Added: Integer;
  begin
    if not MaximumFindProduct(Http, C.Code, ProductID, Price, Title, PageRo) then
    begin
      Inc(NotFound);
      Log('NEGASIT  %s (produs %d) - %s', [C.Code, C.GoodsID, Title]);
      Exit;
    end;
    Inc(Found);

    // pagina RO e deja descarcata de MaximumFindProduct (verificarea codului)
    if PageRo = '' then
      PageRo := GetPage(Format('%s/ro/%d/', [cBaseUrl, ProductID]));

    if C.NeedImages then
    begin
      Urls := MaximumParseGallery(PageRo);
      if Length(Urls) = 0 then
        Log('FARA POZE %s (_id %d)  %s', [C.Code, ProductID, Title])
      else
      begin
        Added := SaveImages(C.Code, Urls);
        Inc(ImagesAdded, Added);
        Log('IMAGINI  %s (_id %d): %d in galerie, %d noi  %s', [C.Code, ProductID, Length(Urls), Added, Title]);
      end;
    end;

    if C.NeedDescription then
    begin
      HtmlRo := MaximumFeaturesToHtml(MaximumParseFeatures(PageRo));
      if HtmlRo = '' then
        Log('FARA CARACTERISTICI %s (_id %d)', [C.Code, ProductID])
      else
      begin
        HtmlRu := '';
        try
          PageRu := GetPage(Format('%s/ru/%d/', [cBaseUrl, ProductID]));
          HtmlRu := MaximumFeaturesToHtml(MaximumParseFeatures(PageRu));
        except
          on E: Exception do
            Log('  pagina RU nu a putut fi citita pentru %s: %s', [C.Code, E.Message]);
        end;
        if HtmlRu = '' then
          HtmlRu := HtmlRo;
        SaveDescription(C.Code, HtmlRo, HtmlRu);
        Inc(DescriptionsSaved);
        Log('CARACTERISTICI %s: salvate (RO %d caractere, RU %d)', [C.Code, Length(HtmlRo), Length(HtmlRu)]);
      end;
    end;
  end;

  // Pasul 2 al scriptului Python: imaginile fara continut se descarca si se salveaza ca PNG
  procedure DownloadImages;
  type
    TPending = record
      Code, Url: string;
    end;
  var
    Pending: TList<TPending>;
    Item: TPending;
    Raw, Png: TMemoryStream;
    Image: TWICImage;
    Response: IHTTPResponse;
    Attempt, K: Integer;
    Ok: Boolean;
    LastError: string;
  begin
    Pending := TList<TPending>.Create;
    try
      Tr.StartTransaction;
      try
        Query.SQL.Text :=
          'select SUPPLIER_GOODS_CODE, IMAGE_URL from TS_PRICELIST_ITEMS_IMAGES ' +
          'where SUPPLIERID = :SUPPLIERID and IMAGE is null and IMAGE_URL <> '''' ' +
          'order by SUPPLIER_GOODS_CODE, ORDERNO';
        Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
        Query.Open;
        while not Query.Eof do
        begin
          Item.Code := Query.Fields[0].AsString;
          Item.Url := Query.Fields[1].AsString;
          Pending.Add(Item);
          Query.Next;
        end;
        Query.Close;
      finally
        if Tr.Active then
          Tr.Rollback;
      end;

      if Pending.Count = 0 then
      begin
        Log('Imagini de descarcat: niciuna.');
        Exit;
      end;
      Log('Imagini de descarcat: %d.', [Pending.Count]);

      for K := 0 to Pending.Count - 1 do
      begin
        if FCancelled then
          Break;
        Item := Pending[K];
        Ok := False;
        LastError := '';
        Png := TMemoryStream.Create;
        try
          for Attempt := 1 to cImageRetries do
          begin
            Raw := TMemoryStream.Create;
            try
              try
                Response := Http.Get(Item.Url, Raw);
                if Response.StatusCode <> 200 then
                  raise Exception.CreateFmt('HTTP %d', [Response.StatusCode]);
                Raw.Position := 0;
                Png.Clear;
                Image := TWICImage.Create;
                try
                  Image.LoadFromStream(Raw);
                  Image.ImageFormat := wifPng;
                  Image.SaveToStream(Png);
                finally
                  Image.Free;
                end;
                Ok := Png.Size > 0;
              except
                on E: Exception do
                  LastError := E.Message;
              end;
            finally
              Raw.Free;
            end;
            if Ok or FCancelled then
              Break;
            Pause(2000 * Attempt);
          end;

          if not Ok then
          begin
            Inc(DownloadFailed);
            Log('IMAGINE ESUATA %s  %s: %s', [Item.Code, Item.Url, LastError]);
            Continue;
          end;

          Tr.StartTransaction;
          try
            Query.SQL.Text :=
              'update TS_PRICELIST_ITEMS_IMAGES set IMAGE = :IMAGE ' +
              'where SUPPLIERID = :SUPPLIERID and SUPPLIER_GOODS_CODE = :CODE and IMAGE_URL = :URL';
            Png.Position := 0;
            Query.ParamByName('IMAGE').LoadFromStream(Png, ftBlob);
            Query.ParamByName('SUPPLIERID').AsInteger := cSupplierID;
            Query.ParamByName('CODE').AsString := Item.Code;
            Query.ParamByName('URL').AsString := Item.Url;
            Query.Execute;
            Tr.Commit;
            Inc(Downloaded);
            if (K + 1) mod 25 = 0 then
              Log('... %d / %d imagini', [K + 1, Pending.Count]);
          except
            on E: Exception do
            begin
              if Tr.Active then
                Tr.Rollback;
              Inc(DownloadFailed);
              Log('IMAGINE NESALVATA %s: %s', [Item.Code, E.Message]);
            end;
          end;
        finally
          Png.Free;
        end;
        Pause(1000);
      end;
    finally
      Pending.Free;
    end;
  end;

begin
  Result := Default(TParserJobResult);
  Found := 0;
  NotFound := 0;
  Errors := 0;
  ImagesAdded := 0;
  DescriptionsSaved := 0;
  Downloaded := 0;
  DownloadFailed := 0;
  if FOptions.DelayMs > 0 then
    DelayMs := FOptions.DelayMs
  else
    DelayMs := cDefaultDelayMs;

  // TWICImage are nevoie de COM pe firul curent
  ComInitialized := Succeeded(CoInitializeEx(nil, COINIT_APARTMENTTHREADED));
  Http := MaximumCreateHttp;
  // site-ul tine limba intr-un cookie: dupa o cerere /ro/ ar servi romana si la /ru/
  Http.AllowCookies := False;
  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  Candidates := TList<TCandidate>.Create;
  try
    Tr.DefaultConnection := FConnection;
    Query.Connection := FConnection;
    Query.Transaction := Tr;

    LoadCandidates;
    Log('Articole din ultimul pricelist carora le lipsesc imagini sau descriere: %d.', [Candidates.Count]);

    for I := 0 to Candidates.Count - 1 do
    begin
      if FCancelled then
        Break;
      try
        ProcessCandidate(Candidates[I]);
      except
        on E: Exception do
        begin
          Inc(Errors);
          Log('EROARE   %s (produs %d): %s', [Candidates[I].Code, Candidates[I].GoodsID, E.Message]);
        end;
      end;
      if (I + 1) mod 25 = 0 then
        Log('... %d / %d articole', [I + 1, Candidates.Count]);
      if I < Candidates.Count - 1 then
        Pause(DelayMs);
    end;

    if not FCancelled then
      DownloadImages;

    J := Candidates.Count;
    Result.Summary := Format('articole %d, gasite %d, negasite %d, erori %d, URL-uri noi %d, descrieri %d, ' +
      'imagini descarcate %d, esuate %d', [J, Found, NotFound, Errors, ImagesAdded, DescriptionsSaved, Downloaded,
      DownloadFailed]);
    // site-ul pare cazut sau si-a schimbat structura
    Result.SiteSuspect := (J >= 10) and (Found * 2 < J) and not FCancelled;
    if FCancelled then
      Log('Oprit de utilizator.');
  finally
    Candidates.Free;
    Query.Free;
    Tr.Free;
    Http.Free;
    if ComInitialized then
      CoUninitialize;
  end;
end;

end.

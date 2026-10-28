unit TrisContentUnit;

{
  Anvelopele furnizorului TRIS (CustomerID 8606, tris.md -> trisauto.md), pricelistul PLID 6077:
  imaginile si caracteristicile (filtrele) anvelopelor care nu le au. Apelat din frame78
  (bbGoodsPropertiesDownloadClick); copierea imaginilor la produse o face apoi butonul
  "Imagini si descrieri -> produse" (TPriceListContentTransfer).

  Tintele si scrierea caracteristicilor - TyreContentCommonUnit. In tipul 479 sint si jante RC si
  buloane McGard - se sar: denumirea nu are dimensiune de anvelopa.

  Sursele:
    - denumirea din pricelist "SAILUN Elite 2 175/65 R-15 H84" (TrisParseTyreName): latimea,
      inaltimea profilului, diametrul, indicele de sarcina si de viteza. Indicii de pe site sint
      uneori gresiti (33728 Elite 205/65 R15: pricelist H 94, site T 99) - se iau din denumire;
    - trisauto.md: sezonul si imaginea modelului, prin scriptul Python
      Python\tris_tyres\tris_site.py (cautare dupa articol, o cerere la cTrisRequestIntervalSec,
      cache pe model, oprire la blocarea IP-ului de catre gazduire - detalii in script);
      comunicarea: <temp>\WMS_Tris\input.json -> result.json + imaginile descarcate.
  Imaginea -> TS_PRICELIST_ITEMS_IMAGES (TMamicoContentLoader.SaveItem, PNG), doar pentru
  produsele fara imagini.
}

interface

uses
  System.SysUtils, System.Classes, IBC, TyreContentCommonUnit;

const
  cTrisSupplierID = 8606;
  // pauza minima intre doua cereri la trisauto.md (gazduirea blocheaza IP-ul la rafale)
  cTrisRequestIntervalSec = 1.5;
  cTrisScriptRelPath = 'Python\tris_tyres\tris_site.py';

type
  TTrisContentLoader = class
  public
    // tot procesul pentru pricelistul APLID; False = anulat de utilizator
    class function RunForPriceList(AConnection: TIBCConnection; APLID, AUserID: Integer): Boolean;
  end;

// "SAILUN Elite 2 175/65 R-15 H84" -> valorile (fara Code/GoodsID/Season); Valid = e anvelopa
function TrisParseTyreName(const AName: string; out ATyre: TTyreTarget): Boolean;

implementation

uses
  System.RegularExpressions, System.Generics.Collections, System.UITypes, System.IOUtils,
  System.JSON, Vcl.Dialogs, MamicoContentUnit;

function Num(const S: string): string;
begin
  Result := StringReplace(Trim(S), ',', '.', [rfReplaceAll]);
end;

// "SAILUN Elite 2 175/65 R-15 H84", "SAILUN 4 SEASONS C 225/70 R-15C S112",
// "EVERGREEN EDM511 13 R-22.5 J156", "BRIDGESTONE G544R 140/90- 16 H71"
function TrisParseTyreName(const AName: string; out ATyre: TTyreTarget): Boolean;
var
  M: TMatch;
begin
  ATyre := Default(TTyreTarget);
  M := TRegEx.Match(Trim(AName),
    '^(.*?)\s(\d{2,3}(?:[.,]\d{1,2})?)(?:/(\d{2,3}(?:[.,]\d)?))?\s*(?:Z?R\s*-?|-)\s*' +
    '(\d{2}(?:[.,]\d)?)(C?)\s+([A-Z])\s?(\d{2,3}(?:/\d{2,3})?)\b');
  Result := M.Success;
  if not Result then
    Exit;
  ATyre.Model := Trim(M.Groups[1].Value);
  ATyre.Width := Num(M.Groups[2].Value);
  if M.Groups.Count > 3 then
    ATyre.Height := Num(M.Groups[3].Value);
  ATyre.Diameter := 'R' + Num(M.Groups[4].Value) + UpperCase(M.Groups[5].Value);
  ATyre.Speed := M.Groups[6].Value;
  ATyre.Load := M.Groups[7].Value;
end;

type
  // ce a gasit scriptul pentru un articol
  TTrisSiteItem = record
    Season: string;
    ImageUrl: string;
    ImageFile: string;
  end;

// ruleaza tris_site.py pentru tinte; ASite primeste ce s-a gasit; intoarce textul pentru sumar
function RunSiteScript(const ATargets: TArray<TTyreTarget>; ASite: TDictionary<string, TTrisSiteItem>;
  out ABlocked: Boolean): string;
var
  WorkDir, ScriptPath, InputPath, OutPath, StopPath, ImagesDir: string;
  Input, Res, ItemObj: TJSONObject;
  Items: TJSONArray;
  Item: TJSONObject;
  Value, ItemsValue: TJSONValue;
  T: TTyreTarget;
  SiteItem: TTrisSiteItem;
begin
  ABlocked := False;
  ScriptPath := FindPythonScript(cTrisScriptRelPath);
  if ScriptPath = '' then
    raise Exception.Create('Nu gasesc scriptul ' + cTrisScriptRelPath + '.');

  WorkDir := TPath.Combine(TPath.GetTempPath, 'WMS_Tris');
  ImagesDir := TPath.Combine(WorkDir, 'images');
  InputPath := TPath.Combine(WorkDir, 'input.json');
  OutPath := TPath.Combine(WorkDir, 'result.json');
  StopPath := TPath.Combine(WorkDir, 'stop.txt');
  if TDirectory.Exists(ImagesDir) then
    TDirectory.Delete(ImagesDir, True);
  ForceDirectories(ImagesDir);
  if FileExists(OutPath) then
    TFile.Delete(OutPath);

  Input := TJSONObject.Create;
  try
    Items := TJSONArray.Create;
    Input.AddPair('items', Items);
    for T in ATargets do
    begin
      Item := TJSONObject.Create;
      Item.AddPair('code', T.Code);
      Item.AddPair('need_image', TJSONBool.Create(not T.HasImages));
      Items.AddElement(Item);
    end;
    Input.AddPair('out', OutPath);
    Input.AddPair('images_dir', ImagesDir);
    Input.AddPair('stop_file', StopPath);
    Input.AddPair('interval', TJSONNumber.Create(cTrisRequestIntervalSec));
    TFile.WriteAllText(InputPath, Input.ToJSON, TEncoding.UTF8);
  finally
    Input.Free;
  end;

  RunPythonScriptModal(Format('trisauto.md - sezon si imagini pentru %d anvelope (Python)', [Length(ATargets)]),
    ScriptPath, InputPath, StopPath);

  if not FileExists(OutPath) then
    Exit('Scriptul nu a produs ' + OutPath + ' (vezi jurnalul).');

  Value := TJSONObject.ParseJSONValue(TFile.ReadAllText(OutPath, TEncoding.UTF8));
  try
    if not (Value is TJSONObject) then
      Exit('Rezultatul scriptului nu poate fi citit: ' + OutPath);
    Res := TJSONObject(Value);
    ABlocked := Res.GetValue<Boolean>('blocked', False);
    ItemsValue := Res.GetValue('items');
    if ItemsValue is TJSONObject then
      for T in ATargets do
      begin
        ItemObj := TJSONObject(ItemsValue).GetValue(T.Code) as TJSONObject;
        if (ItemObj = nil) or not ItemObj.GetValue<Boolean>('found', False) then
          Continue;
        SiteItem.Season := ItemObj.GetValue<string>('season', '');
        SiteItem.ImageUrl := ItemObj.GetValue<string>('image_url', '');
        SiteItem.ImageFile := ItemObj.GetValue<string>('image_file', '');
        ASite.AddOrSetValue(T.Code, SiteItem);
      end;
    Result := Format('trisauto.md: %d / %d articole procesate, gasite %d.',
      [Res.GetValue<Integer>('done', 0), Length(ATargets), ASite.Count]);
    if Res.GetValue<Boolean>('stopped', False) then
      Result := Result + ' Oprit de utilizator.';
  finally
    Value.Free;
  end;
end;

class function TTrisContentLoader.RunForPriceList(AConnection: TIBCConnection;
  APLID, AUserID: Integer): Boolean;
var
  Rows: TArray<TTyreTargetRow>;
  Row: TTyreTargetRow;
  Targets: TList<TTyreTarget>;
  Site: TDictionary<string, TTrisSiteItem>;
  SiteItem: TTrisSiteItem;
  T: TTyreTarget;
  R: TMamicoItemResult;
  I, NoImages, Skipped, Images: Integer;
  Blocked: Boolean;
  Summary, SiteSummary: string;
begin
  Result := True;
  Targets := TList<TTyreTarget>.Create;
  Site := TDictionary<string, TTrisSiteItem>.Create;
  try
    Rows := LoadTyreTargets(AConnection, cTrisSupplierID, APLID);
    NoImages := 0;
    Skipped := 0;
    for Row in Rows do
      // jantele / buloanele clasificate ca anvelope nu au dimensiune de anvelopa in denumire
      if TrisParseTyreName(Row.Name, T) then
      begin
        T.Code := Row.Code;
        T.GoodsID := Row.GoodsID;
        T.HasImages := Row.HasImages;
        Targets.Add(T);
        if not T.HasImages then
          Inc(NoImages);
      end
      else
        Inc(Skipped);

    if Targets.Count = 0 then
    begin
      MessageDlg('TRIS: nu sint anvelope fara imagini sau fara caracteristici in acest pricelist.',
        mtInformation, [mbOK], 0);
      Exit;
    end;

    Blocked := False;
    SiteSummary := '';
    Images := 0;
    case MessageDlg(Format('TRIS: %d anvelope fara imagini sau fara caracteristici ' +
      '(%d fara imagini; %d articole sarite - nu sint anvelope).'#13#10#13#10 +
      'Da - cauta sezonul si imaginea pe trisauto.md (script Python, o cerere la %.1f s, ~%d min), ' +
      'apoi completeaza caracteristicile din denumire + site'#13#10 +
      'Nu - doar caracteristicile din denumire, fara site (fara sezon)'#13#10 +
      'Renunta - nu face nimic',
      [Targets.Count, NoImages, Skipped, cTrisRequestIntervalSec,
       Round(Targets.Count * 1.3 * cTrisRequestIntervalSec / 60) + 1], TFormatSettings.Invariant),
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrCancel:
        Exit(False);
      mrYes:
        begin
          SiteSummary := RunSiteScript(Targets.ToArray, Site, Blocked);
          // imaginile -> TS_PRICELIST_ITEMS_IMAGES (PNG), doar pentru produsele fara imagini
          for T in Targets do
            if not T.HasImages and Site.TryGetValue(T.Code, SiteItem) and (SiteItem.ImageFile <> '') and
              FileExists(SiteItem.ImageFile) then
            begin
              R := TMamicoItemResult.Create(T.Code);
              try
                R.Found := True;
                R.ImageUrls := [SiteItem.ImageUrl];
                R.ImageData := [TFile.ReadAllBytes(SiteItem.ImageFile)];
                Inc(Images, TMamicoContentLoader.SaveItem(AConnection, cTrisSupplierID, R));
              finally
                R.Free;
              end;
            end;
        end;
    end;

    // sezonul de pe site
    for I := 0 to Targets.Count - 1 do
      if Site.TryGetValue(Targets[I].Code, SiteItem) then
      begin
        T := Targets[I];
        T.Season := SiteItem.Season;
        Targets[I] := T;
      end;

    Summary := FillTyreCharacteristics(AConnection, Targets.ToArray, AUserID);
    if SiteSummary <> '' then
      Summary := SiteSummary + Format(' Imagini salvate in pricelist: %d.', [Images]) +
        sLineBreak + Summary;
    if Blocked then
      Summary := 'ATENTIE: trisauto.md a blocat accesul in timpul cautarii - articolele ramase ' +
        'au primit doar caracteristicile din denumire; reluati mai tirziu.' + sLineBreak + sLineBreak + Summary;
    MessageDlg(Format('TRIS: %d anvelope.', [Targets.Count]) + sLineBreak + Summary + sLineBreak + sLineBreak +
      'Imaginile se copiaza la produse cu butonul "Imagini si descrieri -> produse".', mtInformation, [mbOK], 0);
  finally
    Site.Free;
    Targets.Free;
  end;
end;

end.

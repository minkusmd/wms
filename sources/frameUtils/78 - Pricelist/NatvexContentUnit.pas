unit NatvexContentUnit;

{
  Anvelopele furnizorului NATVEX-COM SRL (CustomerID 26743, site autoplanet.md), pricelistul
  PLID 6111: imaginile (TS_PRICELIST_ITEMS_IMAGES) si caracteristicile (filtrele) anvelopelor care
  nu le au. Apelat din frame78 (bbGoodsPropertiesDownloadClick); copierea imaginilor la produse o
  face apoi butonul "Imagini si descrieri -> produse" (TPriceListContentTransfer).

  Tintele si scrierea caracteristicilor - TyreContentCommonUnit (jantele, camerele, flipper-ele
  din pricelist se sar - denumirea nu e de anvelopa).

  Partea de site e scriptul Python\natvex_tyres\autoplanet_site.py (detalii in script), rulat in
  proces prin Python4Delphi; comunicarea: <temp>\WMS_Natvex\input.json -> result.json + imaginile.
  Fapte (verificate 25 oct 2026):
    - codul Natvex (GOODS_CODE) nu exista pe autoplanet.md - potrivirea e dupa denumire:
      "Anvelope OTANI 185/65R15 (88H WE1000) iarna" = "OTANI WE1000 185/65R15 88H";
    - scriptul citeste listele de categorii (titlu, link, imaginea modelului) - ~25 de pagini,
      pastrate 24 h in <temp>\WMS_Natvex\autoplanet_list.json - si descarca o imagine pe model;
    - autoplanet.md nu are descrieri (paginile produselor au doar campurile tehnice) -
      TS_PRICELIST_ITEMS_DESCRIPTION nu se completeaza;
    - caracteristicile vin din denumirea Natvex (parsata de script): dimensiunea, indicii, sezonul
      (iarna -> Iarna, vara -> Vara, a/s si m+s -> All Season, ca la produsele deja completate).
}

interface

uses
  System.SysUtils, System.Classes, IBC, TyreContentCommonUnit;

const
  cNatvexSupplierID = 26743;
  // pauza minima intre doua cereri la autoplanet.md (server lent, ~6 s pe pagina)
  cNatvexRequestIntervalSec = 5;
  cNatvexScriptRelPath = 'Python\natvex_tyres\autoplanet_site.py';

type
  TNatvexContentLoader = class
  public
    // tot procesul pentru pricelistul APLID; False = anulat de utilizator
    class function RunForPriceList(AConnection: TIBCConnection; APLID, AUserID: Integer): Boolean;
  end;

implementation

uses
  System.Generics.Collections, System.UITypes, System.IOUtils, System.JSON, Vcl.Dialogs,
  MamicoContentUnit;

type
  // ce a intors scriptul pentru un articol
  TNatvexItem = record
    Parsed: Boolean;
    Tyre: TTyreTarget;     // valorile din denumire (fara Code/GoodsID/HasImages)
    Matched: Boolean;
    ImageUrl: string;
    ImageFile: string;
  end;

function JStr(AObj: TJSONObject; const AName: string): string;
begin
  Result := Trim(AObj.GetValue<string>(AName, ''));
end;

class function TNatvexContentLoader.RunForPriceList(AConnection: TIBCConnection;
  APLID, AUserID: Integer): Boolean;
var
  Rows: TArray<TTyreTargetRow>;
  Row: TTyreTargetRow;
  WorkDir, ScriptPath, InputPath, OutPath, StopPath, ImagesDir, CacheFile, Summary: string;
  Input, Res, ItemObj, ParsedObj: TJSONObject;
  Items: TJSONArray;
  Item: TJSONObject;
  Value, ItemsValue: TJSONValue;
  Found: TDictionary<string, TNatvexItem>;
  NI: TNatvexItem;
  Targets: TList<TTyreTarget>;
  T: TTyreTarget;
  R: TMamicoItemResult;
  Answer, NoImages, Matched, Images, Skipped, SiteProducts: Integer;
  Offline, Blocked, Stopped: Boolean;
begin
  Result := True;
  Rows := LoadTyreTargets(AConnection, cNatvexSupplierID, APLID);
  if Length(Rows) = 0 then
  begin
    MessageDlg('NATVEX: nu sint anvelope fara imagini sau fara caracteristici in acest pricelist.',
      mtInformation, [mbOK], 0);
    Exit;
  end;
  NoImages := 0;
  for Row in Rows do
    if not Row.HasImages then
      Inc(NoImages);

  Answer := MessageDlg(Format('NATVEX: %d articole legate de anvelope fara imagini sau fara caracteristici ' +
    '(%d fara imagini).'#13#10#13#10 +
    'Da - imaginile de pe autoplanet.md (script Python: lista site-ului ~25 de pagini, o cerere la %d s, ' +
    'pastrata 24 h; apoi o imagine pe model, la 1,5 s) si caracteristicile din denumire'#13#10 +
    'Nu - doar caracteristicile din denumire, fara site'#13#10 +
    'Renunta - nu face nimic'#13#10#13#10 +
    'Codul Natvex nu exista pe autoplanet.md - potrivirea se face dupa denumire; site-ul nu are descrieri.',
    [Length(Rows), NoImages, cNatvexRequestIntervalSec]), mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if Answer = mrCancel then
    Exit(False);
  Offline := Answer = mrNo;

  ScriptPath := FindPythonScript(cNatvexScriptRelPath);
  if ScriptPath = '' then
    raise Exception.Create('Nu gasesc scriptul ' + cNatvexScriptRelPath + '.');
  WorkDir := TPath.Combine(TPath.GetTempPath, 'WMS_Natvex');
  ImagesDir := TPath.Combine(WorkDir, 'images');
  InputPath := TPath.Combine(WorkDir, 'input.json');
  OutPath := TPath.Combine(WorkDir, 'result.json');
  StopPath := TPath.Combine(WorkDir, 'stop.txt');
  CacheFile := TPath.Combine(WorkDir, 'autoplanet_list.json');
  if TDirectory.Exists(ImagesDir) then
    TDirectory.Delete(ImagesDir, True);
  ForceDirectories(ImagesDir);
  if FileExists(OutPath) then
    TFile.Delete(OutPath);

  Input := TJSONObject.Create;
  try
    Items := TJSONArray.Create;
    Input.AddPair('items', Items);
    for Row in Rows do
    begin
      Item := TJSONObject.Create;
      Item.AddPair('code', Row.Code);
      Item.AddPair('name', Row.Name);
      Item.AddPair('need_image', TJSONBool.Create(not Row.HasImages));
      Items.AddElement(Item);
    end;
    Input.AddPair('out', OutPath);
    Input.AddPair('images_dir', ImagesDir);
    Input.AddPair('stop_file', StopPath);
    Input.AddPair('cache_file', CacheFile);
    Input.AddPair('interval', TJSONNumber.Create(cNatvexRequestIntervalSec));
    Input.AddPair('offline', TJSONBool.Create(Offline));
    TFile.WriteAllText(InputPath, Input.ToJSON, TEncoding.UTF8);
  finally
    Input.Free;
  end;

  RunPythonScriptModal(Format('autoplanet.md - imagini si caracteristici pentru %d anvelope NATVEX (Python)',
    [Length(Rows)]), ScriptPath, InputPath, StopPath);

  if not FileExists(OutPath) then
  begin
    MessageDlg('Scriptul nu a produs ' + OutPath + ' (vezi jurnalul).', mtError, [mbOK], 0);
    Exit;
  end;

  Found := TDictionary<string, TNatvexItem>.Create;
  Targets := TList<TTyreTarget>.Create;
  try
    Value := TJSONObject.ParseJSONValue(TFile.ReadAllText(OutPath, TEncoding.UTF8));
    try
      if not (Value is TJSONObject) then
        raise Exception.Create('Rezultatul scriptului nu poate fi citit: ' + OutPath);
      Res := TJSONObject(Value);
      Blocked := Res.GetValue<Boolean>('blocked', False);
      Stopped := Res.GetValue<Boolean>('stopped', False);
      SiteProducts := Res.GetValue<Integer>('site_products', 0);
      ItemsValue := Res.GetValue('items');
      if ItemsValue is TJSONObject then
        for Row in Rows do
        begin
          ItemObj := TJSONObject(ItemsValue).GetValue(Row.Code) as TJSONObject;
          if ItemObj = nil then
            Continue;
          NI := Default(TNatvexItem);
          // "parsed": null pentru articolele care nu sint anvelope
          if ItemObj.GetValue('parsed') is TJSONObject then
          begin
            ParsedObj := TJSONObject(ItemObj.GetValue('parsed'));
            NI.Parsed := True;
            NI.Tyre.Model := Trim(JStr(ParsedObj, 'brand') + ' ' + JStr(ParsedObj, 'model'));
            NI.Tyre.Width := JStr(ParsedObj, 'width');
            NI.Tyre.Height := JStr(ParsedObj, 'height');
            NI.Tyre.Diameter := JStr(ParsedObj, 'diam');
            NI.Tyre.Load := JStr(ParsedObj, 'load');
            NI.Tyre.Speed := JStr(ParsedObj, 'speed');
            NI.Tyre.Season := JStr(ParsedObj, 'season');
          end;
          if ItemObj.GetValue('match') is TJSONObject then
          begin
            NI.Matched := True;
            NI.ImageUrl := JStr(TJSONObject(ItemObj.GetValue('match')), 'image_url');
          end;
          NI.ImageFile := JStr(ItemObj, 'image_file');
          Found.AddOrSetValue(Row.Code, NI);
        end;
    finally
      Value.Free;
    end;

    // imaginile -> TS_PRICELIST_ITEMS_IMAGES (PNG), doar pentru produsele fara imagini;
    // caracteristicile din denumire pentru toate anvelopele recunoscute
    Matched := 0;
    Images := 0;
    Skipped := 0;
    for Row in Rows do
    begin
      if not Found.TryGetValue(Row.Code, NI) or not NI.Parsed then
      begin
        Inc(Skipped);
        Continue;
      end;
      if NI.Matched then
        Inc(Matched);
      if not Row.HasImages and (NI.ImageFile <> '') and FileExists(NI.ImageFile) then
      begin
        R := TMamicoItemResult.Create(Row.Code);
        try
          R.Found := True;
          R.ImageUrls := [NI.ImageUrl];
          R.ImageData := [TFile.ReadAllBytes(NI.ImageFile)];
          Inc(Images, TMamicoContentLoader.SaveItem(AConnection, cNatvexSupplierID, R));
        finally
          R.Free;
        end;
      end;
      T := NI.Tyre;
      T.Code := Row.Code;
      T.GoodsID := Row.GoodsID;
      T.HasImages := Row.HasImages;
      Targets.Add(T);
    end;

    Summary := FillTyreCharacteristics(AConnection, Targets.ToArray, AUserID);
    if not Offline then
      Summary := Format('autoplanet.md: %d produse pe site, potrivite %d din %d anvelope, ' +
        'imagini salvate in pricelist: %d.', [SiteProducts, Matched, Targets.Count, Images]) +
        sLineBreak + Summary;
    if Stopped then
      Summary := 'Oprit de utilizator - imaginile ramase nu au fost descarcate.' + sLineBreak + Summary;
    if Blocked then
      Summary := 'ATENTIE: autoplanet.md a refuzat cererile - reluati mai tirziu.' + sLineBreak + Summary;
    MessageDlg(Format('NATVEX: %d anvelope (%d articole sarite - nu sint anvelope).',
      [Targets.Count, Skipped]) + sLineBreak + Summary + sLineBreak + sLineBreak +
      'Imaginile se copiaza la produse cu butonul "Imagini si descrieri -> produse".', mtInformation, [mbOK], 0);
  finally
    Targets.Free;
    Found.Free;
  end;
end;

end.

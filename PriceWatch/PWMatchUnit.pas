unit PWMatchUnit;

{ WMSPriceWatch - asocierea automata a produselor concurentilor cu produsele noastre.

  Denumirile sint normalizate (majuscule, litere chirilice asemanatoare -> latine,
  fara (TM)/(R)) si sparte in cuvinte. Conteaza "cuvintele-cheie": cele care contin
  cifre (12400F, 9800X3D, B760M-HDV, KF556C36BBEK2-16, SNV3S1000G, 5600) si nu sint
  unitati de masura (16GB, 3.6GHZ, 65W, 1700MHZ). Fiecare cuvint-cheie are o greutate
  IDF (rar in corpus = important). Scorul unei perechi = suma greutatilor cuvintelor
  comune; se accepta cel mai bun candidat daca scorul >= MIN_SCORE si exista cel putin
  un cuvint comun rar.

  Reguli de respingere (chiar la scor mare):
    - familia difera (i5 / i7, Ryzen 5 / Ryzen 7, Core Ultra 5 / 7, DDR4 / DDR5)
    - ambalajul difera (BOX / TRAY) daca ambele il spun
    - sufixul placii video difera (TI / SUPER / XT / XTX / GRE)
    - capacitatea difera (500GB / 1TB / 32GB) daca ambele o spun }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, PWTypes;

type
  TPWTokenSet = TDictionary<string, Boolean>;

  TPWMatchCandidate = record
    GoodsID: Integer;
    Score: Double;
    Shared: string;      // cuvintele comune (pentru jurnal)
  end;

  TPWMatcher = class
  private
    FGoods: TArray<TPWOurGoods>;
    FGoodsTokens: TArray<TPWTokenSet>;
    FGoodsNorm: TArray<string>;
    FIdf: TDictionary<string, Double>;
    FDocCount: Integer;
    FMinScore: Double;
    FRareIdf: Double;
    procedure BuildIdf(const AExtraTitles: TArray<string>);
    function TokenIdf(const AToken: string): Double;
  public
    constructor Create(const AOurGoods: TArray<TPWOurGoods>; const ASiteTitles: TArray<string>; AMinScore: Double);
    destructor Destroy; override;
    // cel mai bun produs al nostru pentru denumirea de pe site; False = niciunul acceptabil
    function BestMatch(const ATitle: string; out ACandidate: TPWMatchCandidate): Boolean;
    property MinScore: Double read FMinScore write FMinScore;
  end;

// denumire normalizata (majuscule, latine, fara simboluri)
function PWNormalizeTitle(const S: string): string;
// cuvintele-cheie ale unei denumiri (pentru MATCH_KEY si pentru scor)
function PWKeyTokens(const S: string): TArray<string>;
function PWMatchKey(const S: string): string;

implementation

uses
  System.RegularExpressions, System.StrUtils, System.Math, System.Character;

const
  // chirilice care arata ca litere latine (apar in titluri: "8P+12E" cu E chirilic)
  cCyr: array[0..11] of Char = (#1040, #1042, #1057, #1045, #1053, #1050, #1052, #1054, #1056, #1058, #1061, #1059);
  cLat: array[0..11] of Char = ('A', 'B', 'C', 'E', 'H', 'K', 'M', 'O', 'P', 'T', 'X', 'Y');

function PWNormalizeTitle(const S: string): string;
var
  I, J: Integer;
  C: Char;
  SB: TStringBuilder;
begin
  SB := TStringBuilder.Create;
  try
    for I := 1 to Length(S) do
    begin
      C := S[I];
      // (TM), (R), ghilimele tipografice, spatii speciale
      if CharInSet(C, [#8482, #174, #169, #8220, #8221, #8216, #8217, #171, #187]) or (C = #160) then
      begin
        SB.Append(' ');
        Continue;
      end;
      C := C.ToUpper;
      for J := 0 to High(cCyr) do
        if C = cCyr[J] then
        begin
          C := cLat[J];
          Break;
        end;
      if C.IsLetterOrDigit or CharInSet(C, ['-', '+', '.', '/']) then
        SB.Append(C)
      else
        SB.Append(' ');
    end;
    Result := TRegEx.Replace(SB.ToString, '\s+', ' ').Trim;
  finally
    SB.Free;
  end;
end;

const
  // unitati de masura care pot urma dupa un numar (cu sau fara spatiu): "16GB", "3.6 GHz", "65 W"
  cUnits = 'GB|MB|TB|KB|GHZ|MHZ|HZ|W|NM|BIT|BITI|MM|CM|KG|RPM|PIN|PINI|CH|MT|MTS|CL|PCS|PC|EC|BUC|LEI|MDL|ANI|AN|LUNI|' +
    'MAH|MS|FPS|DPI|ML|TH|NITS|LM';

// unitati / marimi: nu identifica un produs. Sufixele de model (7600X, 14600K, 3200G, 9950X3D)
// ramin cuvinte-cheie: X / K / G sint unitati doar dupa numere mici (2X, 4K, 16G).
function IsUnitToken(const T: string): Boolean;
begin
  Result := TRegEx.IsMatch(T, '^\d+([.,]\d+)?(' + cUnits + ')$')
    or TRegEx.IsMatch(T, '^\d{1,3}(C|T|P|E|V|A|G|L|M)$')   // 6C, 12T, 8P, 0E, 12V, 16G (dar 3200G, 5700G = modele)
    or TRegEx.IsMatch(T, '^\d{1,2}(X|K)$')                 // 2X, 4K (dar 245K, 7600X = modele)
    or TRegEx.IsMatch(T, '^\d+X\d+(GB|MB|G)?$')            // 2X8GB, 2X16
    or TRegEx.IsMatch(T, '^(\d+P\+\d+E|\d+C/\d+T|\d+C)$')  // 8P+12E, 6C/12T
    or TRegEx.IsMatch(T, '^\d{1,3}$')                      // numere mici
    or TRegEx.IsMatch(T, '^\d+[.,]\d+$')                   // frecvente / versiuni: 3.6, 5.3
    or TRegEx.IsMatch(T, '^(19|20)\d\d$');                 // ani
end;

function PWKeyTokens(const S: string): TArray<string>;
var
  Norm, T, Part: string;
  Raw: TArray<string>;
  Seen: TDictionary<string, Boolean>;
  List: TList<string>;

  procedure AddToken(const AToken: string);
  var
    K: string;
  begin
    K := AToken.Trim(['-', '+', '.', '/']);
    if (Length(K) < 3) or Seen.ContainsKey(K) then
      Exit;
    if not TRegEx.IsMatch(K, '\d') then
      Exit;
    if IsUnitToken(K) then
      Exit;
    Seen.Add(K, True);
    List.Add(K);
  end;

begin
  Norm := PWNormalizeTitle(S);
  // "3.6 GHz", "65 W", "1800 MHz" -> un singur cuvint-unitate, ca sa nu ramina numarul singur drept cheie
  Norm := TRegEx.Replace(Norm, '\b(\d+([.,]\d+)?)\s+(' + cUnits + ')\b', '$1$3');
  Raw := Norm.Split([' ']);
  Seen := TDictionary<string, Boolean>.Create;
  List := TList<string>.Create;
  try
    for T in Raw do
    begin
      AddToken(T);
      // B760M-HDV -> B760M, HDV; KF556C36BBEK2-16 -> KF556C36BBEK2; M.2 ramine unitate-like
      if TRegEx.IsMatch(T, '[-/]') then
        for Part in T.Split(['-', '/']) do
          AddToken(Part);
    end;
    Result := List.ToArray;
  finally
    List.Free;
    Seen.Free;
  end;
end;

function PWMatchKey(const S: string): string;
begin
  Result := string.Join(' ', PWKeyTokens(S));
end;

{ reguli de consistenta }

function FamilyOf(const ANorm: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(ANorm, '\b(I[3579]|RYZEN\s*[3579]|ULTRA\s*[3579]|ATHLON|PENTIUM|CELERON|XEON|THREADRIPPER|EPYC)\b');
  if M.Success then
    Result := StringReplace(M.Value, ' ', '', [rfReplaceAll]);
end;

function PackageOf(const ANorm: string): string;
begin
  if TRegEx.IsMatch(ANorm, '\bTRAY\b|\bOEM\b') then
    Result := 'TRAY'
  else if TRegEx.IsMatch(ANorm, '\bBOX\b|\bRETAIL\b') then
    Result := 'BOX'
  else
    Result := '';
end;

function DdrOf(const ANorm: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(ANorm, '\bDDR[345]\b');
  if M.Success then
    Result := M.Value;
end;

// variantele unui model (RTX 5060 vs 5060 TI, AS2280P4U vs AS2280P4U PRO): multimile trebuie sa coincida
function VariantsOf(const ANorm: string): string;
var
  M: TMatch;
  L: TStringList;
begin
  L := TStringList.Create;
  try
    L.Sorted := True;
    L.Duplicates := dupIgnore;
    // + seriile placilor video / de baza (AORUS MASTER vs WINDFORCE vs AERO sint SKU-uri diferite)
    for M in TRegEx.Matches(ANorm, '\b(TI|SUPER|XT|XTX|GRE|PRO|PLUS|LITE|EVO|OC|AORUS|MASTER|WINDFORCE|AERO|EAGLE|' +
        'GAMING|TUF|PRIME|DUAL|ROG|STRIX|VENTUS|SUPRIM|TRIO|PROART|NOCTUA|PULSE|NITRO|HELLHOUND|FIGHTER|TWIN|' +
        'GHOST|PHANTOM|INFINITY|SHADOW|VERTO|AMP|TRINITY|SOLID|ICE|STEEL|LEGEND|TAICHI|TOMAHAWK|MORTAR|CARBON|' +
        'EDGE|ACE|GODLIKE|UNIFY|FORCE|RIPTIDE|CHALLENGER|PHANTOM|VELOCITA|REAPER|HELLHOUND|RED DEVIL|TOXIC)\b') do
      L.Add(M.Value);
    Result := L.CommaText;
  finally
    L.Free;
  end;
end;

const
  // producatorii de placi / memorii / unitati de stocare; NU chip-urile (NVIDIA, AMD, INTEL)
  cBrands = 'ASUS|MSI|GIGABYTE|ASROCK|BIOSTAR|INNO3D|PALIT|ZOTAC|SAPPHIRE|POWERCOLOR|XFX|PNY|EVGA|GAINWARD|COLORFUL|' +
    'MAXSUN|AFOX|KINGSTON|SAMSUNG|WD|WESTERN DIGITAL|SEAGATE|TOSHIBA|CRUCIAL|ADATA|XPG|APACER|GOODRAM|VERBATIM|' +
    'TEAMGROUP|TEAM GROUP|PATRIOT|CORSAIR|G\.SKILL|GSKILL|HIKVISION|HIKSEMI|LEXAR|TRANSCEND|NETAC|SILICON POWER|' +
    'DELL|HP|LENOVO|SYNOLOGY|HGST|HITACHI|ULIKE|KINGSPEC|ORICO|DAHUA|GEIL|KLEVV|SANDISK|INTENSO|AXIOM|PQI|' +
    'EMTEC|GEMBIRD|QNAP|FUJITSU|SUPERMICRO|NZXT|THERMALTAKE|COOLER MASTER|DEEPCOOL';

// brandul din denumire (primul gasit)
function BrandOf(const ANorm: string): string;
var
  M: TMatch;
begin
  Result := '';
  M := TRegEx.Match(ANorm, '\b(' + cBrands + ')\b');
  if M.Success then
    Result := StringReplace(StringReplace(M.Value, ' ', '', [rfReplaceAll]), '.', '', [rfReplaceAll]);
end;

// capacitati: 1TB -> 1000GB, 2TB -> 2000GB; "500GB", "32GB"
function CapacitiesOf(const ANorm: string): string;
var
  M: TMatch;
  L: TStringList;
  V: Integer;
begin
  L := TStringList.Create;
  try
    L.Sorted := True;
    L.Duplicates := dupIgnore;
    // 1TB, 1.0TB, 500GB, 16GB, 2X16GB (-> 16GB)
    for M in TRegEx.Matches(ANorm, '(?<![\d.])(\d+(?:[.,]\d+)?)\s*(GB|TB)\b') do
    begin
      V := Round(StrToFloatDef(StringReplace(M.Groups[1].Value, ',', '.', []), 0, TFormatSettings.Invariant));
      if M.Groups[2].Value = 'TB' then
        V := V * 1000;
      if V > 0 then
        L.Add(IntToStr(V) + 'GB');
    end;
    Result := L.CommaText;
  finally
    L.Free;
  end;
end;

function Conflict(const A, B: string): Boolean;
begin
  Result := (A <> '') and (B <> '') and (A <> B);
end;

// ASiteNorm = denumirea de pe site; AOurNorm / AOurVendor = produsul nostru (VENDOR din TS_GOODS)
function Consistent(const ASiteNorm, AOurNorm, AOurVendor: string): Boolean;
var
  SiteBrand, OurBrand: string;
begin
  Result := not Conflict(FamilyOf(ASiteNorm), FamilyOf(AOurNorm))
    and not Conflict(PackageOf(ASiteNorm), PackageOf(AOurNorm))
    and not Conflict(DdrOf(ASiteNorm), DdrOf(AOurNorm))
    and (VariantsOf(ASiteNorm) = VariantsOf(AOurNorm))
    and not Conflict(CapacitiesOf(ASiteNorm), CapacitiesOf(AOurNorm));
  if not Result then
    Exit;
  // brandul: Gigabyte RTX 3050 nu e Biostar RTX 3050; la noi brandul poate lipsi din denumire (VENDOR)
  SiteBrand := BrandOf(ASiteNorm);
  OurBrand := BrandOf(AOurNorm);
  if OurBrand = '' then
    OurBrand := BrandOf(PWNormalizeTitle(AOurVendor));
  Result := not Conflict(SiteBrand, OurBrand);
end;

{ TPWMatcher }

constructor TPWMatcher.Create(const AOurGoods: TArray<TPWOurGoods>; const ASiteTitles: TArray<string>; AMinScore: Double);
var
  I: Integer;
  T: string;
begin
  inherited Create;
  FGoods := AOurGoods;
  FMinScore := AMinScore;
  FIdf := TDictionary<string, Double>.Create;
  SetLength(FGoodsTokens, Length(FGoods));
  SetLength(FGoodsNorm, Length(FGoods));
  for I := 0 to High(FGoods) do
  begin
    FGoodsTokens[I] := TPWTokenSet.Create;
    for T in PWKeyTokens(FGoods[I].Title + ' ' + FGoods[I].Code) do
      FGoodsTokens[I].AddOrSetValue(T, True);
    FGoodsNorm[I] := PWNormalizeTitle(FGoods[I].Title + ' ' + FGoods[I].Code);
  end;
  BuildIdf(ASiteTitles);
end;

destructor TPWMatcher.Destroy;
var
  I: Integer;
begin
  for I := 0 to High(FGoodsTokens) do
    FGoodsTokens[I].Free;
  FIdf.Free;
  inherited;
end;

procedure TPWMatcher.BuildIdf(const AExtraTitles: TArray<string>);
var
  Df: TDictionary<string, Integer>;
  I, N: Integer;
  T: string;
  Pair: TPair<string, Integer>;
  Tokens: TArray<string>;
begin
  Df := TDictionary<string, Integer>.Create;
  try
    for I := 0 to High(FGoodsTokens) do
      for T in FGoodsTokens[I].Keys do
      begin
        Df.TryGetValue(T, N);
        Df.AddOrSetValue(T, N + 1);
      end;
    for I := 0 to High(AExtraTitles) do
    begin
      Tokens := PWKeyTokens(AExtraTitles[I]);
      for T in Tokens do
      begin
        Df.TryGetValue(T, N);
        Df.AddOrSetValue(T, N + 1);
      end;
    end;
    FDocCount := Length(FGoodsTokens) + Length(AExtraTitles);
    if FDocCount < 2 then
      FDocCount := 2;
    FIdf.Clear;
    for Pair in Df do
      FIdf.AddOrSetValue(Pair.Key, Ln(FDocCount / Pair.Value));
    // "rar" = apare in cel mult ~12% din denumiri (dar cel putin ln(2) la corpusuri mici)
    FRareIdf := Max(Ln(2.0), Ln(FDocCount / Max(1.0, FDocCount * 0.12)));
  finally
    Df.Free;
  end;
end;

function TPWMatcher.TokenIdf(const AToken: string): Double;
begin
  if not FIdf.TryGetValue(AToken, Result) then
    Result := Ln(FDocCount);   // nemaivazut: cel mai rar
end;

function TPWMatcher.BestMatch(const ATitle: string; out ACandidate: TPWMatchCandidate): Boolean;
var
  Tokens: TArray<string>;
  Norm, T, Shared: string;
  I: Integer;
  Score, Best, Second, W: Double;
  BestIdx: Integer;
  HasRare, BestHasRare: Boolean;
  BestShared: string;
begin
  ACandidate := Default(TPWMatchCandidate);
  Result := False;
  Tokens := PWKeyTokens(ATitle);
  if Length(Tokens) = 0 then
    Exit;
  Norm := PWNormalizeTitle(ATitle);
  Best := 0;
  Second := 0;
  BestIdx := -1;
  BestHasRare := False;
  BestShared := '';
  for I := 0 to High(FGoods) do
  begin
    Score := 0;
    HasRare := False;
    Shared := '';
    for T in Tokens do
      if FGoodsTokens[I].ContainsKey(T) then
      begin
        W := TokenIdf(T);
        Score := Score + W;
        if W >= FRareIdf then
          HasRare := True;
        Shared := Shared + IfThen(Shared = '', '', ' ') + T;
      end;
    if Score <= 0 then
      Continue;
    if not Consistent(Norm, FGoodsNorm[I], FGoods[I].Vendor) then
      Continue;
    if Score > Best then
    begin
      Second := Best;
      Best := Score;
      BestIdx := I;
      BestHasRare := HasRare;
      BestShared := Shared;
    end
    else if Score > Second then
      Second := Score;
  end;
  if (BestIdx < 0) or (Best < FMinScore) or not BestHasRare then
    Exit;
  // doi candidati aproape la fel de buni = ambiguu (ex. acelasi model Box si Tray fara mentiune)
  if (Second > 0) and (Second >= Best * 0.95) then
    Exit;
  ACandidate.GoodsID := FGoods[BestIdx].GoodsID;
  ACandidate.Score := Best;
  ACandidate.Shared := BestShared;
  Result := True;
end;

end.

unit TyreContentCommonUnit;

{
  Partea comuna a loader-elor de anvelope din frame78 (TrisContentUnit - trisauto.md,
  NatvexContentUnit - autoplanet.md):

    - LoadTyreTargets: articolele pricelistului legate de un produs (TS_PRICELIST_ITEMS.GOODSID sau
      TS_GOODS_FOREIGN furnizor + cod, ID minim) de tip web 479 (anvelope), fara imagini sau carora
      le lipseste macar una din cele 6 caracteristici in TS_GOODS_DESCRIPTIONS / TS_GOODS_FILTERS;
    - FillTyreCharacteristics: scrie caracteristicile lipsa (1247 Latime, 1259 Inaltime profil,
      1249 Diametru, 1252 Sezonietate, 1258 Indice sarcina, 1256 Indice viteza) in
      TS_GOODS_DESCRIPTIONS (FLG_GROUP 0, FLAGS 1, ORDERNO 1..6) si TS_GOODS_FILTERS (ORDERNO 0,
      FLAGS 1), cu valorile din TS_FILTER_PARAMS in formatul existent ("225", "55 %", "R16C",
      "Vara", "99 (775 kg)", "H (210 km/h)", "K/L (110/120 km/h)"); valoarea lipsa din dictionar
      se creeaza. Ce exista nu se modifica; daca o caracteristica e doar intr-una din tabele,
      cealalta primeste aceeasi valoare. Sezonul lipsa se ia de la alt articol al aceluiasi model.
      Conventiile sint cele din Python/tyres_fill (apply.py, fill_in_price.py);
    - RunPythonScriptModal: scriptul Python al site-ului, in proces prin Python4Delphi
      (uPythonRunner, Python pe 32 de biti - WMS e Win32), cu fereastra de progres. Un singur
      interpretor pe aplicatie (reinitializarea nu e sigura). Oprirea e cooperativa (fisierul stop) -
      KeyboardInterrupt nu ajunge la firul scriptului.
}

interface

uses
  System.SysUtils, System.Classes, IBC;

const
  cTyreWebType = 479;
  // WMS e Win32 -> Python pe 32 de biti; daca lipseste, ultima versiune inregistrata
  cTyrePythonDll = 'C:\Python\Python313-32\python313.dll';
  // directorul de dezvoltare, daca scriptul nu e linga exe (<WMS>\exe\..\Python\...)
  cTyreScriptDevRoot = 'D:\Projects\MyProjects\WMS\';

type
  // un articol al pricelistului, legat de o anvelopa fara imagini sau fara caracteristici
  TTyreTargetRow = record
    Code: string;
    Name: string;
    GoodsID: Integer;
    HasImages: Boolean;
  end;

  // valorile caracteristicilor unei anvelope (gol = necunoscut, nu se scrie)
  TTyreTarget = record
    Code: string;
    GoodsID: Integer;
    HasImages: Boolean;
    Model: string;      // pentru sezonul pe model: "SAILUN Elite 2"
    Width: string;      // "175", "13", "10.5"; gol la flotation (26x10-14)
    Height: string;     // "65"; gol = fara profil
    Diameter: string;   // "R15", "R15C", "R22.5"
    Load: string;       // "84", "104/102", "173/176"
    Speed: string;      // "H", "K/L", "A8", "D/A8"
    Season: string;     // "Vara" / "Iarna" / "All Season"
  end;

function LoadTyreTargets(AConnection: TIBCConnection; ASupplierID, APLID: Integer): TArray<TTyreTargetRow>;
function FillTyreCharacteristics(AConnection: TIBCConnection; const ATargets: TArray<TTyreTarget>;
  AUserID: Integer): string;

// scriptul ARelPath ("Python\tris_tyres\tris_site.py") linga exe sau in directorul de dezvoltare
function FindPythonScript(const ARelPath: string): string;
// ruleaza scriptul cu argumentul AInputPath (sys.argv[1]) si asteapta, cu fereastra de progres;
// AStopFile se creeaza la "Opreste"
procedure RunPythonScriptModal(const ACaption, AScriptPath, AInputPath, AStopFile: string);

// functii pure (pot fi testate fara baza)
function TyreHeightValue(const AWidth, AHeight: string): string;
function TyreLoadValue(const ALoad: string; out ARu: string): string;
function TyreSpeedValue(const ASpeed: string; out ARu: string): string;
function TyreModelKey(const AModel: string): string;

implementation

uses
  System.RegularExpressions, System.Generics.Collections, System.UITypes, System.IOUtils,
  Data.DB, Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, uPythonRunner;

const
  cFilterWidth = 1247;
  cFilterHeight = 1259;
  cFilterDiameter = 1249;
  cFilterSeason = 1252;
  cFilterLoad = 1258;
  cFilterSpeed = 1256;
  // ordinea caracteristicilor (ORDERNO in TS_GOODS_DESCRIPTIONS = indexul + 1)
  cFilters: array[0..5] of Integer = (cFilterWidth, cFilterHeight, cFilterDiameter, cFilterSeason,
    cFilterLoad, cFilterSpeed);
  cFilterList = '1247, 1259, 1249, 1252, 1258, 1256';

  cSpeedLetters = 'FGJKLMNPQRSTUHVWY';
  cSpeedKmh: array[1..17] of Integer = (80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190,
    200, 210, 240, 270, 300);
  // indicele de sarcina -> kg (tabel ETRTO), de la cLoadFirst
  cLoadFirst = 30;
  cLoadKg: array[30..170] of Integer = (
    106, 109, 112, 115, 118, 121, 125, 128, 132, 136, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185,
    190, 195, 200, 206, 212, 218, 224, 230, 236, 243,
    250, 257, 265, 272, 280, 290, 300, 307, 315, 325, 335, 345, 355, 365, 375, 387, 400, 412, 425, 437,
    450, 462, 475, 487, 500, 515, 530, 545, 560, 580, 600, 615, 630, 650, 670, 690, 710, 730, 750, 775,
    800, 825, 850, 875, 900, 925, 950, 975, 1000, 1030, 1060, 1090, 1120, 1150, 1180, 1215, 1250, 1285,
    1320, 1360, 1400, 1450, 1500, 1550, 1600, 1650, 1700, 1750, 1800, 1850, 1900, 1950, 2000, 2060,
    2120, 2180, 2240, 2300, 2360, 2430, 2500, 2575, 2650, 2725, 2800, 2900, 3000, 3075, 3150, 3250,
    3350, 3450, 3550, 3650, 3750, 3875, 4000, 4125, 4250, 4375, 4500, 4625, 4750, 4875, 5000, 5150,
    5300, 5450, 5600, 5800, 6000);
  // "km/h" si "kg" in rusa (sursa ramine ASCII)
  cKmhRu = #$043A#$043C'/'#$0447;
  cKgRu = #$043A#$0433;

var
  // un singur interpretor Python pe aplicatie (reinitializarea nu e sigura)
  GRunner: TPythonRunner;

{ ---------------------------------------------------------------------------- }
{ valori                                                                         }
{ ---------------------------------------------------------------------------- }

// "65 %"; fara profil: "80 %" la latimea metrica (195 R14C), gol la cea in inch (13 R22.5)
function TyreHeightValue(const AWidth, AHeight: string): string;
begin
  if AHeight <> '' then
    Result := AHeight + ' %'
  else if TRegEx.IsMatch(AWidth, '^\d{3}$') then
    Result := '80 %'
  else
    Result := '';
end;

// "99" -> "99 (775 kg)"; "104/102" -> "104/102 (900/850 kg)"; in afara tabelului - doar numarul
function TyreLoadValue(const ALoad: string; out ARu: string): string;
var
  Parts: TArray<string>;
  Kg: string;
  I, L: Integer;
begin
  Result := ALoad;
  ARu := ALoad;
  if ALoad = '' then
    Exit;
  Parts := ALoad.Split(['/']);
  Kg := '';
  for I := 0 to High(Parts) do
  begin
    L := StrToIntDef(Parts[I], -1);
    if (L < cLoadFirst) or (L > High(cLoadKg)) then
      Exit;
    if Kg <> '' then
      Kg := Kg + '/';
    Kg := Kg + IntToStr(cLoadKg[L]);
  end;
  Result := Format('%s (%s kg)', [ALoad, Kg]);
  ARu := Format('%s (%s %s)', [ALoad, Kg, cKgRu]);
end;

// "H" -> "H (210 km/h)"; "K/L" -> "K/L (110/120 km/h)"; altfel ("A8", "D/A8") - textul ca atare
function TyreSpeedValue(const ASpeed: string; out ARu: string): string;
var
  Parts: TArray<string>;
  Kmh, S: string;
  P: Integer;
begin
  Result := UpperCase(ASpeed);
  ARu := Result;
  if Result = '' then
    Exit;
  Parts := Result.Split(['/']);
  Kmh := '';
  for S in Parts do
  begin
    P := Pos(S, cSpeedLetters);
    if (Length(S) <> 1) or (P = 0) then
      Exit;
    if Kmh <> '' then
      Kmh := Kmh + '/';
    Kmh := Kmh + IntToStr(cSpeedKmh[P]);
  end;
  ARu := Format('%s (%s %s)', [Result, Kmh, cKmhRu]);
  Result := Format('%s (%s km/h)', [Result, Kmh]);
end;

function TyreModelKey(const AModel: string): string;
begin
  Result := UpperCase(TRegEx.Replace(AModel, '[^0-9A-Za-z]', ''));
end;

{ ---------------------------------------------------------------------------- }
{ tintele                                                                        }
{ ---------------------------------------------------------------------------- }

function LoadTyreTargets(AConnection: TIBCConnection; ASupplierID, APLID: Integer): TArray<TTyreTargetRow>;
var
  Query: TIBCQuery;
  List: TList<TTyreTargetRow>;
  Seen: TDictionary<string, Boolean>;
  Row: TTyreTargetRow;
begin
  Query := TIBCQuery.Create(nil);
  List := TList<TTyreTargetRow>.Create;
  Seen := TDictionary<string, Boolean>.Create;
  try
    Query.Connection := AConnection;
    Query.FetchAll := True;
    Query.SQL.Text :=
      'select i.SUPPLIER_GOODS_CODE, i.SUPPLIER_GOODS_NAME, g.GOODSID, ' +
      '  iif(exists(select 1 from TS_GOODS_IMAGE m where m.GOODSID = g.GOODSID), 1, 0) as HAS_IMAGES ' +
      'from TS_PRICELIST_ITEMS i ' +
      'join TS_GOODS g on g.GOODSID = coalesce(i.GOODSID, ' +
      '  (select min(f.GOODSID) from TS_GOODS_FOREIGN f ' +
      '   where f.CUSTOMERID = :SUPPLIERID and f.GOODS_CODE = i.SUPPLIER_GOODS_CODE)) ' +
      'where i.PLID = :PLID and g.FLG_FOLDER = 0 and g.WEBGOODSTYPE_ID = :WEBTYPE ' +
      '  and (not exists(select 1 from TS_GOODS_IMAGE m where m.GOODSID = g.GOODSID) ' +
      '    or (select count(distinct x.FILTERID) from TS_GOODS_DESCRIPTIONS x ' +
      '        where x.GOODSID = g.GOODSID and coalesce(x.FLG_GROUP, 0) = 0 ' +
      '          and x.FILTERID in (' + cFilterList + ')) < 6 ' +
      '    or (select count(distinct y.FILTERID) from TS_GOODS_FILTERS y ' +
      '        where y.GOODSID = g.GOODSID and y.FILTERID in (' + cFilterList + ')) < 6) ' +
      'order by i.SUPPLIER_GOODS_NAME';
    Query.ParamByName('SUPPLIERID').AsInteger := ASupplierID;
    Query.ParamByName('PLID').AsInteger := APLID;
    Query.ParamByName('WEBTYPE').AsInteger := cTyreWebType;
    Query.Open;
    while not Query.Eof do
    begin
      Row.Code := Trim(Query.FieldByName('SUPPLIER_GOODS_CODE').AsString);
      Row.Name := Trim(Query.FieldByName('SUPPLIER_GOODS_NAME').AsString);
      Row.GoodsID := Query.FieldByName('GOODSID').AsInteger;
      Row.HasImages := Query.FieldByName('HAS_IMAGES').AsInteger = 1;
      if (Row.Code <> '') and not Seen.ContainsKey(Row.Code) then
      begin
        Seen.Add(Row.Code, True);
        List.Add(Row);
      end;
      Query.Next;
    end;
    Result := List.ToArray;
  finally
    Seen.Free;
    List.Free;
    Query.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ caracteristicile                                                               }
{ ---------------------------------------------------------------------------- }

type
  // valorile din TS_FILTER_PARAMS pentru cele 6 caracteristici; creeaza lipsurile
  TTyreParams = class
  private
    FQuery: TIBCQuery;
    FValues: TList<TPair<Integer, string>>;   // FILTERID -> PARAM_VALUE (upper)
    FIDs: TList<Integer>;                     // FILTERPARAMID paralel cu FValues
    FUserID: Integer;
  public
    Created: TStringList;
    constructor Create(AQuery: TIBCQuery; AUserID: Integer);
    destructor Destroy; override;
    // AMatch: expresie regulata pentru valorile echivalente deja existente ("^99\s?\(")
    function Get(AFilterID: Integer; const AValue, AValueRu, AMatch: string): Integer;
  end;

constructor TTyreParams.Create(AQuery: TIBCQuery; AUserID: Integer);
begin
  inherited Create;
  FQuery := AQuery;
  FUserID := AUserID;
  FValues := TList<TPair<Integer, string>>.Create;
  FIDs := TList<Integer>.Create;
  Created := TStringList.Create;
  FQuery.SQL.Text := 'select FILTERID, FILTERPARAMID, trim(PARAM_VALUE) from TS_FILTER_PARAMS ' +
    'where FILTERID in (' + cFilterList + ') order by FILTERPARAMID';
  FQuery.Open;
  while not FQuery.Eof do
  begin
    FValues.Add(TPair<Integer, string>.Create(FQuery.Fields[0].AsInteger, UpperCase(FQuery.Fields[2].AsString)));
    FIDs.Add(FQuery.Fields[1].AsInteger);
    FQuery.Next;
  end;
  FQuery.Close;
end;

destructor TTyreParams.Destroy;
begin
  FValues.Free;
  FIDs.Free;
  Created.Free;
  inherited;
end;

function TTyreParams.Get(AFilterID: Integer; const AValue, AValueRu, AMatch: string): Integer;
var
  I: Integer;
  Upper: string;
begin
  Upper := UpperCase(AValue);
  for I := 0 to FValues.Count - 1 do
    if (FValues[I].Key = AFilterID) and (FValues[I].Value = Upper) then
      Exit(FIDs[I]);
  if AMatch <> '' then
    for I := 0 to FValues.Count - 1 do
      if (FValues[I].Key = AFilterID) and TRegEx.IsMatch(FValues[I].Value, AMatch, [roIgnoreCase]) then
        Exit(FIDs[I]);

  FQuery.SQL.Text := 'select next value for SQ_TS_FILTER_PARAMS_ID from RDB$DATABASE';
  FQuery.Open;
  Result := FQuery.Fields[0].AsInteger;
  FQuery.Close;
  FQuery.SQL.Text := 'insert into TS_FILTER_PARAMS (FILTERID, FILTERPARAMID, PARAM_VALUE, PARAM_VALUE_RUS, CREATED_BY) ' +
    'values (:FILTERID, :FILTERPARAMID, :PARAM_VALUE, :PARAM_VALUE_RUS, :CREATED_BY)';
  FQuery.ParamByName('FILTERID').AsInteger := AFilterID;
  FQuery.ParamByName('FILTERPARAMID').AsInteger := Result;
  FQuery.ParamByName('PARAM_VALUE').AsString := AValue;
  FQuery.ParamByName('PARAM_VALUE_RUS').AsString := AValueRu;
  FQuery.ParamByName('CREATED_BY').AsInteger := FUserID;
  FQuery.ExecSQL;
  FValues.Add(TPair<Integer, string>.Create(AFilterID, Upper));
  FIDs.Add(Result);
  Created.Add(Format('%d: %s', [AFilterID, AValue]));
end;

function FillTyreCharacteristics(AConnection: TIBCConnection; const ATargets: TArray<TTyreTarget>;
  AUserID: Integer): string;
var
  Tr: TIBCTransaction;
  Query, Ins: TIBCQuery;
  Params: TTyreParams;
  ModelSeason: TDictionary<string, string>;
  HaveDesc, HaveFilt: TDictionary<Integer, Integer>;
  T: TTyreTarget;
  Values, ValuesRu, Matches: array[0..5] of string;
  NoSeason: TStringList;
  Season, Ru: string;
  I, PID, Goods, Descs, Filts, Incomplete: Integer;
  Changed: Boolean;
begin
  // sezonul pe model, de la articolele care il au (pentru celelalte din acelasi model)
  ModelSeason := TDictionary<string, string>.Create;
  HaveDesc := TDictionary<Integer, Integer>.Create;
  HaveFilt := TDictionary<Integer, Integer>.Create;
  NoSeason := TStringList.Create;
  Tr := TIBCTransaction.Create(nil);
  Query := TIBCQuery.Create(nil);
  Ins := TIBCQuery.Create(nil);
  Params := nil;
  try
    for T in ATargets do
      if (T.Season <> '') and (T.Model <> '') then
        ModelSeason.AddOrSetValue(TyreModelKey(T.Model), T.Season);

    Tr.DefaultConnection := AConnection;
    Query.Connection := AConnection;
    Query.Transaction := Tr;
    Query.UpdateTransaction := Tr;
    Ins.Connection := AConnection;
    Ins.Transaction := Tr;
    Ins.UpdateTransaction := Tr;
    Tr.StartTransaction;
    try
      Params := TTyreParams.Create(Ins, AUserID);
      Goods := 0;
      Descs := 0;
      Filts := 0;
      Incomplete := 0;
      for T in ATargets do
      begin
        // caracteristicile existente ale produsului
        HaveDesc.Clear;
        HaveFilt.Clear;
        Query.SQL.Text := 'select FILTERID, FILTERPARAMID from TS_GOODS_DESCRIPTIONS ' +
          'where GOODSID = :GOODSID and coalesce(FLG_GROUP, 0) = 0 and FILTERID in (' + cFilterList + ')';
        Query.ParamByName('GOODSID').AsInteger := T.GoodsID;
        Query.Open;
        while not Query.Eof do
        begin
          HaveDesc.AddOrSetValue(Query.Fields[0].AsInteger, Query.Fields[1].AsInteger);
          Query.Next;
        end;
        Query.Close;
        Query.SQL.Text := 'select FILTERID, FILTERPARAMID from TS_GOODS_FILTERS ' +
          'where GOODSID = :GOODSID and FILTERID in (' + cFilterList + ')';
        Query.ParamByName('GOODSID').AsInteger := T.GoodsID;
        Query.Open;
        while not Query.Eof do
        begin
          HaveFilt.AddOrSetValue(Query.Fields[0].AsInteger, Query.Fields[1].AsInteger);
          Query.Next;
        end;
        Query.Close;

        // valorile noi
        Season := T.Season;
        if (Season = '') and (T.Model <> '') then
          ModelSeason.TryGetValue(TyreModelKey(T.Model), Season);

        Values[0] := T.Width;
        ValuesRu[0] := Values[0];
        Matches[0] := '';
        if T.Width <> '' then
          Values[1] := TyreHeightValue(T.Width, T.Height)
        else
          Values[1] := '';
        ValuesRu[1] := Values[1];
        Matches[1] := '';
        Values[2] := T.Diameter;
        ValuesRu[2] := Values[2];
        Matches[2] := '';
        // sezonul exista in dictionar (Vara / Iarna / All Season) - rusa nu e folosita
        Values[3] := Season;
        ValuesRu[3] := Season;
        Matches[3] := '';
        Values[4] := TyreLoadValue(T.Load, Ru);
        ValuesRu[4] := Ru;
        // in baza exista si "111(1090 kg)" si "99 (775 kg)"
        if T.Load <> '' then
          Matches[4] := '^' + TRegEx.Escape(T.Load) + '\s?\('
        else
          Matches[4] := '';
        Values[5] := TyreSpeedValue(T.Speed, Ru);
        ValuesRu[5] := Ru;
        if T.Speed <> '' then
          Matches[5] := '^' + TRegEx.Escape(UpperCase(T.Speed)) + ' \('
        else
          Matches[5] := '';

        Changed := False;
        for I := 0 to High(cFilters) do
        begin
          if HaveDesc.ContainsKey(cFilters[I]) and HaveFilt.ContainsKey(cFilters[I]) then
            Continue;
          // valoarea din cealalta tabela are prioritate - cele doua raman la fel
          if not HaveDesc.TryGetValue(cFilters[I], PID) and not HaveFilt.TryGetValue(cFilters[I], PID) then
          begin
            if Values[I] = '' then
              Continue;
            PID := Params.Get(cFilters[I], Values[I], ValuesRu[I], Matches[I]);
          end;

          if not HaveDesc.ContainsKey(cFilters[I]) then
          begin
            Ins.SQL.Text := 'insert into TS_GOODS_DESCRIPTIONS ' +
              '(GOODSID, FLG_GROUP, FILTERID, FILTERPARAMID, FLAGS, ORDERNO, CREATED_BY) ' +
              'values (:GOODSID, 0, :FILTERID, :FILTERPARAMID, 1, :ORDERNO, :CREATED_BY)';
            Ins.ParamByName('GOODSID').AsInteger := T.GoodsID;
            Ins.ParamByName('FILTERID').AsInteger := cFilters[I];
            Ins.ParamByName('FILTERPARAMID').AsInteger := PID;
            Ins.ParamByName('ORDERNO').AsInteger := I + 1;
            Ins.ParamByName('CREATED_BY').AsInteger := AUserID;
            Ins.ExecSQL;
            Inc(Descs);
            Changed := True;
          end;
          if not HaveFilt.ContainsKey(cFilters[I]) then
          begin
            Ins.SQL.Text := 'insert into TS_GOODS_FILTERS ' +
              '(GOODSID, FILTERID, FILTERPARAMID, ORDERNO, FLAGS, CREATEDBY, CREATED_DATE) ' +
              'values (:GOODSID, :FILTERID, :FILTERPARAMID, 0, 1, :CREATEDBY, current_timestamp)';
            Ins.ParamByName('GOODSID').AsInteger := T.GoodsID;
            Ins.ParamByName('FILTERID').AsInteger := cFilters[I];
            Ins.ParamByName('FILTERPARAMID').AsInteger := PID;
            Ins.ParamByName('CREATEDBY').AsInteger := AUserID;
            Ins.ExecSQL;
            Inc(Filts);
            Changed := True;
          end;
        end;
        if Changed then
          Inc(Goods);
        if Season = '' then
          NoSeason.Add(Format('%s (%s)', [T.Code, T.Model]));
        for I := 0 to High(cFilters) do
          if (Values[I] = '') and not HaveDesc.ContainsKey(cFilters[I]) then
          begin
            Inc(Incomplete);
            Break;
          end;
      end;
      Tr.Commit;
    except
      Tr.Rollback;
      raise;
    end;

    Result := Format('Caracteristici: %d produse completate (%d descrieri, %d filtre), ' +
      '%d valori noi in dictionar; %d raman incomplete (valori care nu pot fi citite).',
      [Goods, Descs, Filts, Params.Created.Count, Incomplete]);
    if NoSeason.Count > 0 then
    begin
      Result := Result + sLineBreak + sLineBreak + Format('Fara sezon (%d): ', [NoSeason.Count]);
      for I := 0 to NoSeason.Count - 1 do
      begin
        if I = 15 then
        begin
          Result := Result + Format(', ... (+%d)', [NoSeason.Count - 15]);
          Break;
        end;
        if I > 0 then
          Result := Result + ', ';
        Result := Result + NoSeason[I];
      end;
    end;
  finally
    Params.Free;
    Ins.Free;
    Query.Free;
    Tr.Free;
    NoSeason.Free;
    HaveFilt.Free;
    HaveDesc.Free;
    ModelSeason.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ scriptul Python                                                                }
{ ---------------------------------------------------------------------------- }

function FindPythonScript(const ARelPath: string): string;
begin
  Result := TPath.GetFullPath(TPath.Combine(ExtractFilePath(ParamStr(0)), '..\' + ARelPath));
  if not FileExists(Result) then
    Result := cTyreScriptDevRoot + ARelPath;
  if not FileExists(Result) then
    Result := '';
end;

type
  TTyreScriptForm = class(TForm)
  private
    FStopFile: string;
    procedure StopClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  public
    InfoLabel: TLabel;
    LogMemo: TMemo;
    StopButton: TButton;
    Finished: Boolean;
    constructor CreateProgress(const ACaption, AStopFile: string);
    procedure AddLine(const S: string);
    procedure ScriptFinished;
  end;

constructor TTyreScriptForm.CreateProgress(const ACaption, AStopFile: string);
begin
  CreateNew(Application);
  FStopFile := AStopFile;
  Caption := ACaption;
  Width := 760;
  Height := 500;
  Position := poMainFormCenter;
  BorderIcons := [biSystemMenu];
  OnCloseQuery := FormCloseQuery;

  InfoLabel := TLabel.Create(Self);
  InfoLabel.Parent := Self;
  InfoLabel.Align := alTop;
  InfoLabel.AlignWithMargins := True;
  InfoLabel.Caption := 'Se porneste scriptul...';

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

procedure TTyreScriptForm.AddLine(const S: string);
begin
  if Trim(S) = '' then
    Exit;
  LogMemo.Lines.Add(FormatDateTime('hh:nn:ss ', Now) + S);
  InfoLabel.Caption := S;
end;

procedure TTyreScriptForm.ScriptFinished;
begin
  Finished := True;
  StopButton.Enabled := True;
  StopButton.Caption := 'Inchide (se scriu rezultatele)';
end;

procedure TTyreScriptForm.StopClick(Sender: TObject);
begin
  if Finished then
    ModalResult := mrClose
  else
  begin
    // scriptul verifica fisierul intre cereri si se opreste, pastrind ce a gasit
    TFile.WriteAllText(FStopFile, 'stop');
    StopButton.Enabled := False;
    AddLine('Se opreste - se asteapta cererea in curs...');
  end;
end;

procedure TTyreScriptForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // cit timp ruleaza scriptul, inchiderea ferestrei inseamna "Opreste"
  CanClose := Finished;
  if not Finished then
    StopClick(nil);
end;

procedure RunPythonScriptModal(const ACaption, AScriptPath, AInputPath, AStopFile: string);
var
  Form: TTyreScriptForm;
  DllPath: string;
begin
  if FileExists(AStopFile) then
    TFile.Delete(AStopFile);
  if GRunner = nil then
  begin
    if FileExists(cTyrePythonDll) then
      DllPath := cTyrePythonDll
    else
      DllPath := '';
    GRunner := TPythonRunner.Create(DllPath);
  end;

  Form := TTyreScriptForm.CreateProgress(ACaption, AStopFile);
  try
    GRunner.OnOutput :=
      procedure(const S: string)
      begin
        Form.AddLine(S);
      end;
    GRunner.OnFinished :=
      procedure(ExitCode: Integer)
      begin
        Form.ScriptFinished;
      end;
    GRunner.SetArgs([AScriptPath, AInputPath]);
    GRunner.Run(AScriptPath);
    // fereastra se inchide doar dupa terminarea scriptului (OnFinished vine dupa ultimul OnOutput)
    Form.ShowModal;
  finally
    GRunner.OnOutput := nil;
    GRunner.OnFinished := nil;
    Form.Free;
  end;
end;

initialization

finalization
  FreeAndNil(GRunner);

end.

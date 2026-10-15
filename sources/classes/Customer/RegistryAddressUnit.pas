unit RegistryAddressUnit;

{ Denumirea si adresa unei firme din registrele de stat, aduse la structura WMS:

    - Registrul fiscal (SFS, prin API-ul e-Factura): denumirea '"PRIME STORE" S.R.L.' si
      adresa cu localitatea la inceput, cu majuscule ('SEC.BOTANICA Dacia bd. nr.60');
    - Registrul de stat al unitatilor de drept (ASP, copia din CUSTOMERS_REGISTRU):
      adresa cu virgule ('mun. Chisinau, sec. Ciocana, str. Podul Inalt, 18, ap.(of.) 54').

  Localitatea si sectorul se cauta in nomenclatorul WMS (GET_CITIES, GET_CITY_DISTRICT);
  in TS_CUST_ADDR raman CITYID / DISTRICTID / STREET.
  Folosit de fisa clientului (frmCustomerEditorDlg) si de fisa companiei (frmCompanyCardDialog). }

interface

const
  cAddrTypeFizic = 7662;     // GET_ADDR_TYPES: 'Adresa fizica'
  cAddrTypeJuridic = 7663;   // GET_ADDR_TYPES: 'Adresa juridica'
  cCityChisinau = 2000;

type
  // adresa din registru, descompusa pe structura WMS (TS_CUST_ADDR)
  TRegistryAddress = record
    CityID: Integer;       // 0 = localitatea nu a fost gasita in nomenclator
    CityName: string;
    DistrictID: Integer;   // 0 = fara sector
    DistrictName: string;
    Street: string;
    function AsText: string;
  end;

{ Denumirea din Registrul fiscal in forma folosita in WMS: '"PRIME STORE" S.R.L.' -> 'PRIME STORE SRL'. }
function RegistryNameToWMS(const AName: string): string;

{ Denumire de localitate/sector comparabila: majuscule, fara diacritice, fara prefixe
  ("or.", "mun.", "s.", "sect." ...) si fara punctuatie. 'or. Chisinau' = 'CHISINAU'. }
function NormLocality(const S: string): string;

{ Adresa din Registrul fiscal (SFS). }
function ParseRegistryAddress(const AAddress: string): TRegistryAddress;

{ Adresa din registrul ASP (CUSTOMERS_REGISTRU.ADRESS). }
function ParseAspAddress(const AAddress: string): TRegistryAddress;

implementation

uses
  System.SysUtils, System.StrUtils, IBC, DataModuleDB;

function RegistryNameToWMS(const AName: string): string;
begin
  Result := StringReplace(StringReplace(AName, '"', '', [rfReplaceAll]), '''', '', [rfReplaceAll]);
  Result := UpperCase(Trim(Result));
  Result := StringReplace(Result, 'S.R.L.', 'SRL', [rfReplaceAll]);
  Result := StringReplace(Result, 'S.R.L', 'SRL', [rfReplaceAll]);
  Result := StringReplace(Result, 'S.A.', 'SA', [rfReplaceAll]);
  while Pos('  ', Result) > 0 do
    Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
end;

function NormLocality(const S: string): string;
var
  C: Char;
  R: string;
  Changed: Boolean;
  P: string;
begin
  R := '';
  for C in S do
    case C of
      #$0103, #$0102, #$00E2, #$00C2: R := R + 'A';
      #$00EE, #$00CE: R := R + 'I';
      #$0219, #$0218, #$015F, #$015E: R := R + 'S';
      #$021B, #$021A, #$0163, #$0162: R := R + 'T';
      'a'..'z', 'A'..'Z', '0'..'9': R := R + UpCase(C);
    else
      R := R + ' ';
    end;
  R := Trim(R);
  while Pos('  ', R) > 0 do
    R := StringReplace(R, '  ', ' ', [rfReplaceAll]);
  // prefixele administrative, oricite ar fi ("OR MUN ...")
  repeat
    Changed := False;
    for P in ['OR ', 'MUN ', 'S ', 'SAT ', 'SEC ', 'SECT ', 'SECTOR ', 'COM ', 'RAION ', 'R ', 'ORAS '] do
      if (Copy(R, 1, Length(P)) = P) and (Length(R) > Length(P)) then
      begin
        Delete(R, 1, Length(P));
        Changed := True;
      end;
  until not Changed;
  Result := R;
end;

function TRegistryAddress.AsText: string;
begin
  Result := CityName;
  if DistrictName <> '' then
    Result := Result + ', ' + DistrictName;
  if Street <> '' then
    Result := IfThen(Result = '', '', Result + ', ') + Street;
end;

{ Denumirea localitatii dupa CITYID; '' daca nu exista. }
function CityNameByID(ACityID: Integer): string;
var
  Q: TIBCQuery;
begin
  Result := '';
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := dmDB.IBCConnection;
    Q.SQL.Text := 'SELECT FIRST 1 TITLE FROM GET_CITIES WHERE CITYID = :CITYID';
    Q.ParamByName('CITYID').AsInteger := ACityID;
    Q.Open;
    if not Q.IsEmpty then
      Result := Trim(Q.Fields[0].AsString);
  finally
    Q.Free;
  end;
end;

{ Localitatea din nomenclator dupa denumirea normalizata (NormLocality). }
function FindCity(const AKey: string; out ACityName: string): Integer;
var
  Q: TIBCQuery;
begin
  Result := 0;
  ACityName := '';
  if AKey = '' then
    Exit;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := dmDB.IBCConnection;
    Q.SQL.Text := 'SELECT DISTINCT CITYID, TITLE FROM GET_CITIES';
    Q.Open;
    while not Q.Eof do
    begin
      if NormLocality(Q.Fields[1].AsString) = AKey then
      begin
        Result := Q.Fields[0].AsInteger;
        ACityName := Trim(Q.Fields[1].AsString);
        Break;
      end;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

{ Sectorul localitatii dupa denumirea normalizata; 0 daca nu e gasit. }
function FindDistrict(ACityID: Integer; const AKey: string; out ADistrictName: string): Integer;
var
  Q: TIBCQuery;
begin
  Result := 0;
  ADistrictName := '';
  if (ACityID <= 0) or (AKey = '') then
    Exit;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := dmDB.IBCConnection;
    Q.SQL.Text := 'SELECT * FROM GET_CITY_DISTRICT(:CITYID)';
    Q.ParamByName('CITYID').AsInteger := ACityID;
    Q.Open;
    while not Q.Eof do
    begin
      if NormLocality(Q.FieldByName('DISTRICT_NAME').AsString) = AKey then
      begin
        Result := Q.FieldByName('DISTRICTID').AsInteger;
        ADistrictName := Trim(Q.FieldByName('DISTRICT_NAME').AsString);
        Break;
      end;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

{ Registrul fiscal da adresa ca text, cu localitatea la inceput, cu majuscule si prefix:
    'SEC.BOTANICA Dacia bd. nr.60 bl.5 of.115'   -> Chisinau, sect. Botanica, 'Dacia bd. nr.60 bl.5 of.115'
    'OR.UNGHENI Burebista nr.17 of.403'          -> Ungheni, 'Burebista nr.17 of.403'
    'S.BACIOI str. INDEPENDENTEI nr.227'         -> Bacioi, 'str. INDEPENDENTEI nr.227'
  Numele localitatii se termina la primul cuvint care are litere mici (Dacia, str., bd.).
  Daca localitatea nu e in nomenclator, tot textul ramine in Street. }
function ParseRegistryAddress(const AAddress: string): TRegistryAddress;
var
  S, Prefix, Locality, W, Key: string;
  Words: TArray<string>;
  I, Dot: Integer;
  IsSector: Boolean;

  function HasLower(const X: string): Boolean;
  var
    C: Char;
  begin
    Result := False;
    for C in X do
      if C <> UpCase(C) then
        Exit(True);
  end;

begin
  Result := Default(TRegistryAddress);
  S := Trim(AAddress);
  Result.Street := S;
  if S = '' then
    Exit;

  // prefixul: SEC. / OR. / MUN. / S. / COM. (lipit de nume)
  Dot := Pos('.', S);
  Prefix := '';
  if (Dot > 1) and (Dot <= 5) and not HasLower(Copy(S, 1, Dot)) then
  begin
    Prefix := UpperCase(Copy(S, 1, Dot - 1));
    S := Trim(Copy(S, Dot + 1, MaxInt));
  end;

  Words := S.Split([' '], TStringSplitOptions.ExcludeEmpty);
  Locality := '';
  I := 0;
  while (I < Length(Words)) and not HasLower(Words[I]) do
  begin
    Locality := Trim(Locality + ' ' + Words[I]);
    Inc(I);
  end;
  W := '';
  while I < Length(Words) do
  begin
    W := Trim(W + ' ' + Words[I]);
    Inc(I);
  end;
  if Locality = '' then
    Exit;

  IsSector := (Prefix = 'SEC') or (Prefix = 'SECT');
  Key := NormLocality(Locality);
  if IsSector then
  begin
    // sector al Chisinaului
    Result.CityName := CityNameByID(cCityChisinau);
    if Result.CityName <> '' then
    begin
      Result.CityID := cCityChisinau;
      Result.DistrictID := FindDistrict(cCityChisinau, Key, Result.DistrictName);
    end;
  end
  else
    Result.CityID := FindCity(Key, Result.CityName);

  if Result.CityID > 0 then
    Result.Street := W;   // localitatea e in CITYID/DISTRICTID, in strada ramine restul
end;

{ Registrul ASP: parti despartite prin virgula, intii localitatea, apoi (in municipii)
  sectorul, apoi strada si numarul:
    'mun. Chisinau, sec. Ciocana, str. Podul Inalt, 18, ap.(of.) 54'
       -> Chisinau, sect. Ciocana, 'str. Podul Inalt, 18, ap.(of.) 54'
    'or. Ungheni, str. Burebista, 17'  -> Ungheni, 'str. Burebista, 17'
  Daca localitatea nu e in nomenclator, tot textul ramine in Street. }
function ParseAspAddress(const AAddress: string): TRegistryAddress;
var
  Parts: TArray<string>;
  I, First: Integer;
  W: string;
begin
  Result := Default(TRegistryAddress);
  Result.Street := Trim(AAddress);
  Parts := Result.Street.Split([','], TStringSplitOptions.ExcludeEmpty);
  if Length(Parts) < 2 then
    Exit;

  Result.CityID := FindCity(NormLocality(Parts[0]), Result.CityName);
  if Result.CityID <= 0 then
  begin
    Result.CityID := 0;
    Result.CityName := '';
    Exit;
  end;

  First := 1;
  if StartsText('sec', Trim(Parts[1])) then
  begin
    Result.DistrictID := FindDistrict(Result.CityID, NormLocality(Parts[1]), Result.DistrictName);
    First := 2;
  end;

  W := '';
  for I := First to High(Parts) do
    W := IfThen(W = '', '', W + ', ') + Trim(Parts[I]);
  Result.Street := W;
end;

end.

unit uZipDbfContentOnly;

interface

uses
  System.SysUtils, System.IOUtils, System.Zip, System.Generics.Collections;

type
  TZipDbfContentOnly = class
  private
    class function SanitizeAlphaNumUpper(const S: string): string; static;
    class function MakeUnique8Dot3Name(const TargetDir, Base6: string;
      Used: TDictionary<string, Boolean>): string; static;

    class function FindContentDbf(const ExtractDir: string): string; static;
  public
    /// Extrage ZIP, selectează DBF-ul care conține "_CONTENT", îl redenumește 8.3 în WorkDir
    /// Returnează calea către DBF-ul redenumit.
    class function ExtractContentDbfAsShortName(const ZipFileName: string; out
        ExtractDir: string; var WorkDir: string): string; static;
  end;

implementation

uses
  System.Types;
class function TZipDbfContentOnly.SanitizeAlphaNumUpper(const S: string): string;
var
  Ch: Char;
begin
  Result := '';
  for Ch in S do
    if CharInSet(Ch, ['A'..'Z','a'..'z','0'..'9']) then
      Result := Result + UpCase(Ch);
end;

class function TZipDbfContentOnly.MakeUnique8Dot3Name(
  const TargetDir, Base6: string; Used: TDictionary<string, Boolean>): string;
var
  Base: string;
  I: Integer;
  Candidate: string;
begin
  Base := Base6;
  if Length(Base) < 6 then
    Base := Base.PadRight(6, 'X')
  else if Length(Base) > 6 then
    Base := Copy(Base, 1, 6);

  for I := 0 to 99 do
  begin
    Candidate := Format('%s%.2d.dbf', [Base, I]); // 8.3
    if not Used.ContainsKey(Candidate) and
       (not TFile.Exists(TPath.Combine(TargetDir, Candidate))) then
    begin
      Used.Add(Candidate, True);
      Exit(TPath.Combine(TargetDir, Candidate));
    end;
  end;

  raise Exception.Create('Nu pot genera nume unic 8.3 (00..99 epuizat).');
end;

class function TZipDbfContentOnly.FindContentDbf(const ExtractDir: string): string;
var
  Files: TStringDynArray;
  F: string;
begin
  Files := TDirectory.GetFiles(ExtractDir, '*.dbf', TSearchOption.soAllDirectories);

  // alegem fisierul care contine "_CONTENT" (case-insensitive)
  for F in Files do
    if Pos('_CONTENT', UpperCase(TPath.GetFileNameWithoutExtension(F))) > 0 then
      Exit(F);

  // dacă nu găsim, raportăm clar
  raise Exception.Create('Nu am găsit niciun .dbf cu "_CONTENT" în denumire în ZIP.');
end;

class function TZipDbfContentOnly.ExtractContentDbfAsShortName(
  const ZipFileName: string;
  out ExtractDir: string;
  var WorkDir: string
): string;
var
  TmpRoot: string;
  Src: string;
  Used: TDictionary<string, Boolean>;
  Base6: string;
  Dst: string;
begin
  if not TFile.Exists(ZipFileName) then
    raise Exception.CreateFmt('ZIP inexistent: %s', [ZipFileName]);

  // Foldere temporare
  TmpRoot := TPath.Combine(TPath.GetTempPath,
    'DBFZIP_' + TGUID.NewGuid.ToString.Replace('{','').Replace('}',''));

  ExtractDir := TPath.Combine(TmpRoot, 'extract');
  if WorkDir = '' then
    WorkDir    := TPath.Combine(TmpRoot, 'work');

  TDirectory.CreateDirectory(ExtractDir);
  TDirectory.CreateDirectory(WorkDir);

  // Extract ZIP
  TZipFile.ExtractZipFile(ZipFileName, ExtractDir);

  // Găsește DBF-ul "_CONTENT"
  Src := FindContentDbf(ExtractDir);

  // Generează un nume scurt 8.3 și copiază
  Used := TDictionary<string, Boolean>.Create;
  try
    Base6 := SanitizeAlphaNumUpper(TPath.GetFileNameWithoutExtension(Src));
    if Base6 = '' then
      Base6 := 'DBF';

    Dst := MakeUnique8Dot3Name(WorkDir, Base6, Used);
    TFile.Copy(Src, Dst, True);
    Result := Dst;
  finally
    Used.Free;
  end;
end;

end.


program HtImageLoaderCli;

{ Executabil de consolă: echivalentul scriptului Python (main).

  Setările se citesc din HtImageLoaderCli.ini de lângă .exe. Parola nu este
  în cod: [Database] Password=... în .ini sau variabila de mediu HT_DB_PASSWORD. }

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.IniFiles,
  Winapi.Windows,
  HtScraper in 'HtScraper.pas',
  HtImageLoader in 'HtImageLoader.pas';

function LoadSettings: TLoaderSettings;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  try
    Result.Host := Ini.ReadString('Database', 'Host', '192.168.106.254');
    Result.Database := Ini.ReadString('Database', 'Database', 'sw');
    Result.User := Ini.ReadString('Database', 'User', 'SYSDBA');
    Result.Password := Ini.ReadString('Database', 'Password', '');
    Result.CharacterSet := Ini.ReadString('Database', 'CharacterSet', 'UTF8');
    Result.ClientLibrary := Ini.ReadString('Database', 'ClientLibrary', 'fbclient.dll');
    Result.SupplierId := Ini.ReadInteger('Loader', 'SupplierId', 262735);
    Result.RequestDelayMs := Ini.ReadInteger('Loader', 'RequestDelayMs', 250);
  finally
    Ini.Free;
  end;
  if Result.Password = '' then
    Result.Password := GetEnvironmentVariable('HT_DB_PASSWORD');
  if Result.Password = '' then
    raise Exception.Create('Parola bazei de date lipsește: setați [Database] Password ' +
      'în ' + ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini') +
      ' sau variabila de mediu HT_DB_PASSWORD.');
end;

var
  Loader: THtImageLoader;
  Stats: TLoaderStats;
begin
  SetConsoleOutputCP(CP_UTF8);
  SetTextCodePage(Output, CP_UTF8);
  try
    Loader := THtImageLoader.Create(LoadSettings);
    try
      Loader.OnLog := procedure(const AMessage: string)
        begin
          Writeln(AMessage);
        end;
      Stats := Loader.Run;
      Writeln;
      Writeln(Format('Gata: %d produse, %d imagini salvate, %d negăsite, %d erori.',
        [Stats.Total, Stats.Saved, Stats.NotFound, Stats.Failed]));
    finally
      Loader.Free;
    end;
  except
    on E: Exception do
    begin
      Writeln('Eroare: ', E.Message);
      ExitCode := 1;
    end;
  end;
end.

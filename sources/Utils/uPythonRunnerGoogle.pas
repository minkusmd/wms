unit uPythonRunnerGoogle;

interface

uses
  Winapi.Windows, Winapi.ShellApi, System.SysUtils, System.Classes,
  System.IOUtils, System.JSON;

/// <summary>
/// Executes python.exe with the specified script path in a hidden window and waits until completion.
/// </summary>
function RunPythonScriptAndWait(const APythonExe, AScriptPath: string; const AWorkingDir: string = ''): Boolean;

/// <summary>
/// Reads and parses the generated JSON file into Delphi.
/// </summary>
procedure ReadScrapedJson(const AJsonFilePath: string);

implementation

function RunPythonScriptAndWait(const APythonExe, AScriptPath: string; const AWorkingDir: string): Boolean;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CommandLine, WorkDir: string;
  ExitCode: DWORD;
begin
  Result := False;
  CommandLine := Format('"%s" "%s"', [APythonExe, AScriptPath]);

  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE; // Runs hidden without popping up a console window

  if AWorkingDir <> '' then
    WorkDir := AWorkingDir
  else
    WorkDir := ExtractFilePath(AScriptPath);

  if CreateProcess(
    nil,
    PChar(CommandLine),
    nil,
    nil,
    False,
    CREATE_NO_WINDOW,
    nil,
    PChar(WorkDir),
    StartupInfo,
    ProcessInfo
  ) then
  begin
    try
      // Wait for python process to complete
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
      Result := (ExitCode = 0);
    finally
      CloseHandle(ProcessInfo.hProcess);
      CloseHandle(ProcessInfo.hThread);
    end;
  end;
end;

procedure ReadScrapedJson(const AJsonFilePath: string);
var
  JsonText: string;
  JsonArray: TJSONArray;
  ItemVal, ImgVal: TJSONValue;
  Obj: TJSONObject;
  Denumire, Articol, PretNou, PretVechi, UrlProdus: string;
  ImagesArray: TJSONArray;
begin
  if not TFile.Exists(AJsonFilePath) then
    Exit;

  // Read UTF-8 JSON file
  JsonText := TFile.ReadAllText(AJsonFilePath, TEncoding.UTF8);
  JsonArray := TJSONObject.ParseJSONValue(JsonText) as TJSONArray;

  if Assigned(JsonArray) then
  begin
    try
      for ItemVal in JsonArray do
      begin
        Obj := ItemVal as TJSONObject;
        Denumire  := Obj.GetValue<string>('denumire', '');
        Articol   := Obj.GetValue<string>('articol', '');
        PretNou   := Obj.GetValue<string>('pret_nou', '');
        PretVechi := Obj.GetValue<string>('pret_vechi', '');
        UrlProdus := Obj.GetValue<string>('url_produs', '');

        // Extract list of image URLs
        ImagesArray := Obj.GetValue<TJSONArray>('url_imagini');
        if Assigned(ImagesArray) then
        begin
          for ImgVal in ImagesArray do
          begin
            // ImgVal.Value contains image URL
          end;
        end;

        // TODO: Insert or update your Delphi DataSet / DB tables here
      end;
    finally
      JsonArray.Free;
    end;
  end;
end;

end.

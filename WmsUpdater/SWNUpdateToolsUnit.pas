unit SWNUpdateToolsUnit;

interface

const
     cUPDATE_InfoFileName = 'SWNUpdate.info';  // additional files to download and post install actions
     cUPDATE_UpdaterFileName = 'SWNUpdater.exe';


type

  TFileVersionInfo = record
    MajorVersion:WORD;
    MinorVersion:WORD;
    Release:WORD;
    Build:WORD;
  end;


  function GetTempDir: String;
  function GetMyFileVersion(const FileName:String; var VersionInfo:TFileVersionInfo):Boolean;
  function FileVersionToStr(const VersionInfo:TFileVersionInfo):String;
  function DeleteAllFilesInDir(const Dir:String):Boolean;
  function DeleteDirectory(const Dir:String):Boolean;
  function FileVersionBigger(const VersionInfo1,VersionInfo2:TFileVersionInfo):Boolean;
  function RunSWNUpdater(const MainApp, ServerAddress:String; const RunBackMainApp:Boolean=True):Boolean;

implementation
Uses SysUtils, Windows, Forms, ShellApi;

const
     cUpdaterRunParam = '"%s" "%s"';   // 1-full path file name of main app, 2-Server update Adress, 3-to run back main app

function RunSWNUpdater(const MainApp, ServerAddress:String; const RunBackMainApp:Boolean=True):Boolean;
var UpdaterFilePathName:String;
    WorkingDir:String;
    Params:String;
begin
     WorkingDir:=IncludeTrailingPathDelimiter(ExtractFilePath(MainApp));
     UpdaterFilePathName:=WorkingDir+cUPDATE_UpdaterFileName;
     Params:=Format(cUpdaterRunParam,[MainApp,ServerAddress]);
     if RunBackMainApp then Params:=Params+' RUNAPP';
     Result:=ShellExecute(0,PWideChar('open'),PWideChar(UpdaterFilePathName),PWideChar(Params),PWideChar(WorkingDir),SW_SHOWNORMAL)>32;
end;

function FileVersionBigger(const VersionInfo1,VersionInfo2:TFileVersionInfo):Boolean;
var v1,v2:UInt64;
begin
     v1:=(VersionInfo1.MajorVersion shl 16) or VersionInfo1.MinorVersion;
     v1:=(v1 shl 16) or VersionInfo1.Release;
     v1:=(v1 shl 16) or VersionInfo1.Build;

     v2:=(VersionInfo2.MajorVersion shl 16) or VersionInfo2.MinorVersion;
     v2:=(v2 shl 16) or VersionInfo2.Release;
     v2:=(v2 shl 16) or VersionInfo2.Build;

     Result:=v1>v2;
end;

function DeleteAllFilesInDir(const Dir:String):Boolean;
var fos: TSHFileOpStruct;
    TargetDirFiles:String;
begin
     TargetDirFiles:=IncludeTrailingPathDelimiter(Dir)+'*.*';
     ZeroMemory(@fos, SizeOf(fos));
     fos.wFunc := FO_DELETE;
     fos.fFlags := FOF_SILENT or FOF_NOCONFIRMATION or FOF_FILESONLY;
     fos.pFrom := PWideChar(TargetDirFiles);
     Result:=ShFileOperation(fos)=0;
end;

function DeleteDirectory(const Dir:String):Boolean;
var fos: TSHFileOpStruct;
begin
     fos.wFunc := FO_DELETE;
     fos.fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
     fos.pFrom := PWideChar(Dir);
     Result:=ShFileOperation(fos)=0;
end;


function GetTempDir: String;
var
  Buffer: array[0..MAX_PATH] of WideChar;
begin
  GetTempPath(MAX_PATH - 1, Buffer);
  Result := StrPas(Buffer);
end;

function FileVersionToStr(const VersionInfo:TFileVersionInfo):String;
begin
     with VersionInfo do
     Result:=Format('%d.%d.%d.%d',[MajorVersion,MinorVersion,Release,Build]);
end;

function GetMyFileVersion(const FileName:String; var VersionInfo:TFileVersionInfo):Boolean;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
     Result:=False;

     VerInfoSize := GetFileVersionInfoSize(PWideChar(FileName), Dummy);
     if VerInfoSize >0 then
     begin
          GetMem(VerInfo, VerInfoSize);
          try
             GetFileVersionInfo(PWideChar(FileName), 0, VerInfoSize, VerInfo);
             VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
             if VerValue^.dwSignature=$feef04bd then // see Windows.pas
             begin
                  VersionInfo.MajorVersion:=VerValue^.dwFileVersionMS shr 16;      // MajorVersion
                  VersionInfo.MinorVersion:=(VerValue^.dwFileVersionMS and $FFFF); // MinorVersion
                  VersionInfo.Release:=VerValue^.dwFileVersionLS shr 16;           // Release
                  VersionInfo.Build:=(VerValue^.dwFileVersionLS and $FFFF);        // Build
                  Result:=True;
             end;
          finally
             FreeMem(VerInfo, VerInfoSize);
          end;
     end;
end;


end.

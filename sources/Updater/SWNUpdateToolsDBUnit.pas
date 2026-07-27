unit SWNUpdateToolsDBUnit;

interface

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
  function FileVersionBigger(const VersionInfo1,VersionInfo2:TFileVersionInfo):Boolean;
  function VersionStrToNum(const VersionStr:String; var VersionInfo:TFileVersionInfo):Boolean;
  function GetVersionNumber(const VersionInfo:TFileVersionInfo):UInt64;

implementation
Uses SysUtils, Windows;

const
     // TO DELETE
     cUpdaterRunParam = '"%s" "%s"';   // 1-full path file name of main app, 2-Server update Adress, 3-to run back main app

function VersionStrToNum(const VersionStr:String; var VersionInfo:TFileVersionInfo):Boolean;
var
    MajorVersion:WORD;
    MinorVersion:WORD;
    Release:WORD;
    Build:WORD;
    S:String;
    K,N:integer;
begin
     Result:=False;
     S:=VersionStr;
     K:=Pos('.',S);
     if K>0 then
     begin
          // MajorVersion
          N:=StrToIntDef(Copy(S,1,K-1),-1);
          if (N>=0) and (N<=$FFFF) then
          begin
               MajorVersion:=N;
               Delete(S,1,K);

               K:=Pos('.',S);
               if K>0 then
               begin
                    // MinorVersion
                    N:=StrToIntDef(Copy(S,1,K-1),-1);
                    if (N>=0) and (N<=$FFFF) then
                    begin
                         MinorVersion:=N;
                         Delete(S,1,K);

                         K:=Pos('.',S);
                         if K>0 then
                         begin
                              // Release
                              N:=StrToIntDef(Copy(S,1,K-1),-1);
                              if (N>=0) and (N<=$FFFF) then
                              begin
                                   Release:=N;
                                   Delete(S,1,K);

                                   if S<>'' then
                                   begin
                                        N:=StrToIntDef(S,-1);
                                        if (N>=0) and (N<=$FFFF) then
                                        begin
                                             // Build
                                             Build:=N;

                                             VersionInfo.MajorVersion:=MajorVersion;
                                             VersionInfo.MinorVersion:=MinorVersion;
                                             VersionInfo.Release:=Release;
                                             VersionInfo.Build:=Build;

                                             Result:=True;
                                        end;
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
     end;
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

function GetTempDir: String;
var Buffer: array[0..MAX_PATH] of WideChar;
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

function GetVersionNumber(const VersionInfo:TFileVersionInfo):UInt64;
begin
     Result:=UINT64(VersionInfo.MajorVersion) shl 48 +
             UINT64(VersionInfo.MinorVersion) shl 32 +
             UINT64(VersionInfo.Release) shl 16 + VersionInfo.Build;
end;

end.

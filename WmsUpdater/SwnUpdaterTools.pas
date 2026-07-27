unit SwnUpdaterTools;

interface
Uses Windows, Classes;

type

  TCheckProcessToFinishThread = class(TThread)
  private
    { private declarations }
  protected
    { protected declarations }
    fProcessExeName:String;
    function processExists:Boolean;
  public
    { public declarations }
    constructor Create(const ProcessExeName:String);reintroduce;
    procedure Execute;override;
  end;

  TCopyFilesThread = class;

  TOnCopyFileEvent = procedure (const CopyFilesThread:TCopyFilesThread; const FileName:String) of object;

  TCopyFilesThread = class(TThread)
  private
    fCopiedFiles: integer;
    FOnCopyFileOK: TOnCopyFileEvent;
    FOnCopyFileFAILED: TOnCopyFileEvent;
    FOnCopyProgress: TNotifyEvent;
    procedure SetOnCopyFileFAILED(const Value: TOnCopyFileEvent);
    procedure SetOnCopyFileOK(const Value: TOnCopyFileEvent);
    procedure SetOnCopyProgress(const Value: TNotifyEvent);
    { private declarations }
  protected
    { protected declarations }
    fSourceDir, fTargetDir: String;
    fFiles:TStrings;
    fCurrWorkingFile:String;
    fLastError:String;
    fProgressTimer:Cardinal;
    procedure FileWasCopied;
    procedure FileWasNOTCopied;
    procedure SyncProgress;
    procedure DoProgress;
  public
    { public declarations }
    constructor Create(const SourceDir,TargetDir:String; const ListOfFiles:TStrings);reintroduce;
    destructor Destroy;override;
    procedure Execute;override;

    property CopiedFiles:integer read fCopiedFiles;

    property OnCopyFileOK:TOnCopyFileEvent read FOnCopyFileOK write SetOnCopyFileOK;
    property OnCopyFileFAILED:TOnCopyFileEvent read FOnCopyFileFAILED write SetOnCopyFileFAILED;
    property OnCopyProgress:TNotifyEvent read FOnCopyProgress write SetOnCopyProgress;

  end;

  function ShellExecute_AndWait(const Operation, FileName, Parameter, Directory: string; const Show: Word; const bWait: Boolean = True): Longint;

implementation
Uses SysUtils, Forms, ShellApi, TlHelp32;

type
  PTOKEN_USER = ^TOKEN_USER;
  _TOKEN_USER = record
    User: TSidAndAttributes;
  end;
  TOKEN_USER = _TOKEN_USER;

function CopyProgressRoutine(TotalFileSize,TotalBytesTransferred,StreamSize,StreamBytesTransferred:LARGE_INTEGER;
                             dwStreamNumber,dwCallbackReason:DWORD; hSourceFile,hDestinationFile:THANDLE; lpData:Pointer ):DWORD;stdcall;
var CallingThread:TCopyFilesThread;
begin
     CallingThread:=TCopyFilesThread(lpData);
     CallingThread.SyncProgress;
     Result:=PROGRESS_CONTINUE;
end;


function ShellExecute_AndWait(const Operation, FileName, Parameter, Directory: string; const Show: Word; const bWait: Boolean = True): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
begin
     FillChar(Info, SizeOf(Info), Chr(0));
     Info.cbSize := SizeOf(Info);
     Info.fMask := SEE_MASK_NOCLOSEPROCESS;
     Info.lpVerb := PChar(Operation);
     Info.lpFile := PChar(FileName);
     Info.lpParameters := PChar(Parameter);
     Info.lpDirectory := PChar(Directory);
     Info.nShow := Show;
     bOK := Boolean(ShellExecuteEx(@Info));
     if bOK then
     begin
          if bWait then
          begin
               while (WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT) do Application.ProcessMessages;
               bOK := GetExitCodeProcess(Info.hProcess, DWORD(Result));
          end
          else Result := 0;
     end;
     if not bOK then Result := -1;
end;



function GetCurrentUserName:String;
var UserName: array[0..100] of WideChar;
    n:cardinal;
begin
     n:=100;
     if GetUserName(UserName,n) then Result:=UserName;
end;

function GetUserAndDomainFromPID(ProcessId: DWORD; var User, Domain: string): Boolean;
var hToken: THandle;
    cbBuf: Cardinal;
    ptiUser: PTOKEN_USER;
    snu: SID_NAME_USE;
    ProcessHandle: THandle;
    UserSize, DomainSize: DWORD;
    bSuccess: Boolean;
begin
     Result := False;
     ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION, False, ProcessId);
     if ProcessHandle <> 0 then
     begin
          //  EnableProcessPrivilege(ProcessHandle, 'SeSecurityPrivilege', True);
          if OpenProcessToken(ProcessHandle, TOKEN_QUERY, hToken) then
          begin
               bSuccess := GetTokenInformation(hToken, TokenUser, nil, 0, cbBuf);
               ptiUser  := nil;
               while (not bSuccess) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) do
               begin
                    ReallocMem(ptiUser, cbBuf);
                    bSuccess := GetTokenInformation(hToken, TokenUser, ptiUser, cbBuf, cbBuf);
               end;
               CloseHandle(hToken);

               if not bSuccess then
               begin
                    Exit;
               end;

               UserSize := 0;
               DomainSize := 0;
               LookupAccountSid(nil, ptiUser.User.Sid, nil, UserSize, nil, DomainSize, snu);
               if (UserSize <> 0) and (DomainSize <> 0) then
               begin
                    SetLength(User, UserSize);
                    SetLength(Domain, DomainSize);
                    if LookupAccountSid(nil, ptiUser.User.Sid, PChar(User), UserSize, PChar(Domain), DomainSize, snu) then
                    begin
                         Result := True;
                         User := StrPas(PChar(User));
                         Domain := StrPas(PChar(Domain));
                    end;
               end;

               if bSuccess then
               begin
                    FreeMem(ptiUser);
               end;
          end;

          CloseHandle(ProcessHandle);
     end;
end;


{ TCheckProcessToFinishThread }

constructor TCheckProcessToFinishThread.Create(const ProcessExeName: String);
begin
     inherited Create(True);
     FreeOnTerminate:=True;
     fProcessExeName:=UpperCase(ExtractFileName(ProcessExeName));
end;

procedure TCheckProcessToFinishThread.Execute;
var N:integer;
begin
     N:=0;
     while (Not Terminated) and (N<500) do
     begin
          Sleep(100);
          inc(N,100);
     end;

     while (Not Terminated) and processExists do
     begin
          N:=0;
          while (Not Terminated) and (N<1000) do
          begin
               Sleep(100);
               inc(N,100);
          end;
     end;
end;


function TCheckProcessToFinishThread.processExists: Boolean;
var ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
    CurrUserName:String;
    processUser,processDomain:String;
begin
     // check if process exists only in current user session

     CurrUserName:=GetCurrentUserName;

     Result := False;
     FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
     try
        FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
        ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
        while Integer(ContinueLoop) <> 0 do
        begin
             if GetUserAndDomainFromPID(FProcessEntry32.th32ProcessID, processUser, processDomain) then
             begin
                  if SameText(processUser,CurrUserName) then
                  begin
                       if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = fProcessExeName)
                       or (UpperCase(FProcessEntry32.szExeFile) = fProcessExeName)) then
                       begin
                            Result := True;
                            break;
                       end;
                  end;
             end;
             ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
        end;
     finally
        CloseHandle(FSnapshotHandle);
     end;
end;

{ TCopyFilesThread }


constructor TCopyFilesThread.Create(const SourceDir, TargetDir: String; const ListOfFiles: TStrings);
begin
     inherited Create(True);
     FreeOnTerminate:=True;

     fCopiedFiles:=0;
     fSourceDir:=SourceDir;
     fTargetDir:=TargetDir;
     fFiles:=TStringList.Create;
     fFiles.AddStrings(ListOfFiles);

     FOnCopyFileOK := nil;
     FOnCopyFileFAILED := nil;
     FOnCopyProgress := nil;
end;

destructor TCopyFilesThread.Destroy;
begin
     fFiles.Free;
     inherited;
end;

procedure TCopyFilesThread.DoProgress;
begin
     if (GetTickCount-fProgressTimer)>500 then
     begin
          if Assigned(FOnCopyProgress) then FOnCopyProgress(Self);
          fProgressTimer:=GetTickCount;
     end;
end;

procedure TCopyFilesThread.Execute;
var i:integer;
    sourceFile,targetFile:String;
    cancel:BOOL;
begin
     fProgressTimer:=GetTickCount;
     for i := 0 to fFiles.Count - 1 do
     begin
          if Terminated then break;
          fCurrWorkingFile:=fFiles[i];
          sourceFile:=fSourceDir+fCurrWorkingFile;
          targetFile:=fTargetDir+fCurrWorkingFile;
          fLastError:='';
          cancel:=False;
          if CopyFileEx(PWideChar(sourceFile),PWideChar(targetFile),@CopyProgressRoutine,Self,@cancel,0) then
          begin
               Inc(fCopiedFiles);
               Synchronize(FileWasCopied);
          end
          else
          begin
               fLastError:=SysErrorMessage(GetLastError);
               Synchronize(FileWasNOTCopied);
          end;
     end;
end;

procedure TCopyFilesThread.FileWasCopied;
begin
     if Assigned(FOnCopyFileOK) then FOnCopyFileOK(self,fCurrWorkingFile);
end;

procedure TCopyFilesThread.FileWasNOTCopied;
begin
     if Assigned(FOnCopyFileFAILED) then FOnCopyFileFAILED(self,fCurrWorkingFile+' ('+fLastError+')');
end;

procedure TCopyFilesThread.SetOnCopyFileFAILED(const Value: TOnCopyFileEvent);
begin
     FOnCopyFileFAILED := Value;
end;

procedure TCopyFilesThread.SetOnCopyFileOK(const Value: TOnCopyFileEvent);
begin
     FOnCopyFileOK := Value;
end;

procedure TCopyFilesThread.SetOnCopyProgress(const Value: TNotifyEvent);
begin
     FOnCopyProgress := Value;
end;

procedure TCopyFilesThread.SyncProgress;
begin
     Synchronize(DoProgress);
end;

end.

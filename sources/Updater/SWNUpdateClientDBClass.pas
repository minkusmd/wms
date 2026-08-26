unit SWNUpdateClientDBClass;

interface
uses Classes, SWNUpdateToolsDBUnit, IBC;

type

  TIntervalThread = class (TThread)
  private
    fIntervalDelay:integer;
    fCallProc:TNotifyEvent;
    fCounter:integer;
    procedure CallUserProc;
  public
    constructor Create(const IntervalDelayMin:integer; const CallProc:TNotifyEvent);reintroduce;
    procedure Execute;override;
    procedure Restart;
  end;


  TOnNewVersionExists = procedure (const NewVersion, WhatsNew:String; const Critical:Boolean) of object;

  TSWNUpdateDBClient = class
  private
    { private declarations }
    fAppHasVersion: Boolean;
    FOnNewVersionExists: TOnNewVersionExists;
    FOnNoVersionFound: TNotifyEvent;
    fAppVersion: TFileVersionInfo;
    function GetAppVersionStr: String;
    procedure SetOnNewVersionExists(const Value: TOnNewVersionExists);
    procedure SetOnNoVersionFound(const Value: TNotifyEvent);
  protected
    { protected declarations }
    fDBConnection:TIBCConnection;
    fCheckThread:TIntervalThread;
    fIsForcedCheck:Boolean;
    fNewVersionAvailable:Boolean;

    procedure WhenCheckForNewVersion(Sender:TObject);
    procedure NotifyNewVersion(const VersionStr,Changes:String; const Critical:Boolean);
    procedure NotifyNoNewVersion;
  public
    { public declarations }
    constructor Create(const DBConnection:TIBCConnection; const UpdateIntervalCheckMin:integer);
    destructor Destroy;override;

    property AppHasVersion:Boolean read fAppHasVersion;
    property AppVersion:TFileVersionInfo read fAppVersion;
    property AppVersionStr:String read GetAppVersionStr;

    property OnNewVersionExists:TOnNewVersionExists read FOnNewVersionExists write SetOnNewVersionExists;
    property OnNoVersionFound:TNotifyEvent read FOnNoVersionFound write SetOnNoVersionFound;

    procedure BeginCheckForNewVersions;
    procedure DoUpdateApplication(const UpdaterAppName:String);
    procedure CheckForUpdateNow(const Silent:Boolean=False);
  end;

  // Porneste updaterul aplicatiei.
  // Pe langa calea executabilului curent se transmite explicit si folderul in care
  // aplicatia isi tine fisierul .config (APPFOLDER=...). Este obligatoriu: updaterul
  // poate rula sub alt token de utilizator (elevare UAC pe Windows 10/11), caz in care
  // %LOCALAPPDATA% se rezolva la profilul administratorului si configul nu mai este gasit.
  function LaunchUpdater(const UpdaterAppName:String):Boolean;

implementation
Uses Windows, SysUtils, DB, Forms, ShellApi, SWNValueStorageUnit;

function LaunchUpdater(const UpdaterAppName:String):Boolean;
var updaterPath, params, configFolder:String;
begin
     // cale absoluta: ShellExecute cu nume relativ se rezolva prin directorul curent
     // al procesului, care nu este obligatoriu folderul aplicatiei
     updaterPath:=ExtractFilePath(Application.ExeName)+ExtractFileName(UpdaterAppName);
     if Not FileExists(updaterPath) then updaterPath:=UpdaterAppName;

     configFolder:=ExcludeTrailingPathDelimiter(globalPATH_LOCAL_APPDATA);

     params:='"'+Application.ExeName+'" RUNAPP';
     if configFolder<>'' then params:=params+' APPFOLDER="'+configFolder+'"';

     Result:=ShellExecute(0,PWideChar('open'),PWideChar(updaterPath),PWideChar(params),nil,SW_SHOWNORMAL)>32;
end;

{ TSWNUpdateDBClient }

procedure TSWNUpdateDBClient.BeginCheckForNewVersions;
begin
     fCheckThread.Restart;
end;

procedure TSWNUpdateDBClient.CheckForUpdateNow(const Silent:Boolean);
var needRestart:Boolean;
begin
     fIsForcedCheck:=Not Silent;
     needRestart:=Not fCheckThread.Suspended;
     if needRestart then fCheckThread.Restart;
     WhenCheckForNewVersion(Self);
     if needRestart then fCheckThread.Restart;
end;

constructor TSWNUpdateDBClient.Create(const DBConnection:TIBCConnection; const UpdateIntervalCheckMin:integer);
begin
     fDBConnection:=DBConnection;
     fCheckThread:=TIntervalThread.Create(UpdateIntervalCheckMin,WhenCheckForNewVersion);
     fIsForcedCheck:=False;
     fNewVersionAvailable:=False;

     fAppHasVersion := False;

     fAppVersion.MajorVersion:=0;
     fAppVersion.MinorVersion:=0;
     fAppVersion.Release:=0;
     fAppVersion.Build:=0;

     fAppHasVersion:=GetMyFileVersion(Application.ExeName,fAppVersion);
end;

destructor TSWNUpdateDBClient.Destroy;
begin
     if Not fCheckThread.Terminated then
     begin
          fCheckThread.Terminate;
          if fCheckThread.Suspended then fCheckThread.Start;
          fCheckThread.WaitFor;
     end;
     fCheckThread.Free;

     inherited;
end;

procedure TSWNUpdateDBClient.DoUpdateApplication(const UpdaterAppName:String);
begin
     if fNewVersionAvailable then
     begin
          if LaunchUpdater(UpdaterAppName) then
          begin
               // stop thread
               if Assigned(fCheckThread) then fCheckThread.Terminate;
               // forced close
               Application.Terminate;
          end;
     end;
end;

function TSWNUpdateDBClient.GetAppVersionStr: String;
begin
     Result:=FileVersionToStr(fAppVersion);
end;

procedure TSWNUpdateDBClient.NotifyNewVersion(const VersionStr, Changes: String; const Critical:Boolean);
begin
     fNewVersionAvailable:=True;
     if Assigned(FOnNewVersionExists) then FOnNewVersionExists(VersionStr, Changes, Critical);
end;

procedure TSWNUpdateDBClient.NotifyNoNewVersion;
begin
     if Assigned(FOnNoVersionFound) then FOnNoVersionFound(Self);
end;

procedure TSWNUpdateDBClient.SetOnNewVersionExists(const Value: TOnNewVersionExists);
begin
     FOnNewVersionExists := Value;
end;

procedure TSWNUpdateDBClient.SetOnNoVersionFound(const Value: TNotifyEvent);
begin
     FOnNoVersionFound := Value;
end;

procedure TSWNUpdateDBClient.WhenCheckForNewVersion(Sender: TObject);
var Query:TIBCQuery;
    CheckVersion:TFileVersionInfo;
    Critical:Boolean;
begin
     fNewVersionAvailable:=False;

     // fix exit error
     if Not Assigned(fDBConnection) or Not fDBConnection.Connected then Exit;

     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=fDBConnection;
        Query.SQL.Add('SELECT FIRST 1 "VERSION", VERSION_STR, (SELECT CHANGES FROM TAU_FILEVERSIONCHANGES WHERE TAU_FILEVERSIONCHANGES."VERSION"=TAU_FILEVERSIONS."VERSION"), FLG_CRITICAL');
        Query.SQL.Add('FROM TAU_FILEVERSIONS');
        Query.SQL.Add('ORDER BY TAU_FILEVERSIONS."VERSION" DESC');
        Query.ExecSQL;
        if Not Query.Eof then
        begin
             Critical:=Query.Fields[3].asInteger=1;
             if VersionStrToNum(Query.Fields[1].asString,CheckVersion) then
             begin
                  if FileVersionBigger(CheckVersion,fAppVersion)
                   then NotifyNewVersion(Query.Fields[1].asString,Query.Fields[2].asString, Critical)
                   else
                       if fIsForcedCheck then
                       begin
                            fIsForcedCheck:=False;
                            NotifyNoNewVersion;
                       end;
             end;
        end
        else
        if fIsForcedCheck then NotifyNoNewVersion;

        Query.Close;
     finally
        Query.Free;
     end;
end;

{ TIntervalThread }

procedure TIntervalThread.CallUserProc;
begin
     if Assigned(fCallProc) then fCallProc(Self);
end;

constructor TIntervalThread.Create(const IntervalDelayMin: integer; const CallProc: TNotifyEvent);
begin
     inherited Create(True);
     fIntervalDelay:=IntervalDelayMin*60*1000;
     fCallProc:=CallProc;
     fCounter:=0;
end;

procedure TIntervalThread.Execute;
begin
     while Not Terminated do
     begin
          fCounter:=0;
          while (fCounter<fIntervalDelay) and (Not Terminated) do
          begin
               Sleep(100);
               Inc(fCounter,100);
          end;
          if Not Terminated then Synchronize(CallUserProc);
     end;
end;

procedure TIntervalThread.Restart;
begin
     fCounter:=0;
     if Suspended then Start;
end;

end.

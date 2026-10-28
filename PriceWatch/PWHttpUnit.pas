unit PWHttpUnit;

{ WMSPriceWatch - descarcarea paginilor "cu grija": pauza aleatoare intre cereri
  (DELAY_MIN_MS..DELAY_MAX_MS ale site-ului), rotatia User-Agent-ului, antete de
  browser, proxy optional (al site-ului sau cel global), decompresie automata.
  O conexiune (THTTPClient) per site, refolosita intre cereri (cookie-urile raman). }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Net.HttpClient,
  System.Net.URLClient, PWTypes;

type
  TPWFetchResult = record
    Ok: Boolean;           // raspuns primit (indiferent de cod)
    StatusCode: Integer;   // 0 = exceptie de retea
    Body: string;
    Error: string;
    ElapsedMs: Integer;
  end;

  TPWFetcher = class
  private
    FClients: TObjectDictionary<Integer, THTTPClient>;
    FGlobalProxy: string;
    FUaIndex: Integer;
    FLog: TPWLogEvent;
    FCancelled: TFunc<Boolean>;
    FLastRequest: TDictionary<Integer, TDateTime>;
    FUseCurl: TDictionary<Integer, Boolean>;   // site-urile la care WinHTTP nu primeste raspuns -> curl.exe
    FCurrentUA: string;
    function ClientFor(const ASite: TPWSite): THTTPClient;
    function NextUserAgent: string;
    procedure ApplyProxy(AClient: THTTPClient; const AProxyUrl: string);
    procedure Sleep(AMs: Integer);
    function CurlGet(const ASite: TPWSite; const AUrl: string): TPWFetchResult;
    procedure Log(const AMessage: string);
  public
    constructor Create(const AGlobalProxy: string; const ALog: TPWLogEvent; const ACancelled: TFunc<Boolean>);
    destructor Destroy; override;
    // asteapta pauza site-ului (de la ultima cerere) si descarca pagina
    function Get(const ASite: TPWSite; const AUrl: string): TPWFetchResult;
    // pauza aleatoare in [DelayMin, DelayMax] a site-ului, masurata de la ultima cerere
    procedure WaitSiteDelay(const ASite: TPWSite);
    // site-ul se descarca prin curl.exe de la bun inceput (teste / site-uri care nu raspund la WinHTTP)
    procedure ForceCurl(ASiteID: Integer);
    property GlobalProxy: string read FGlobalProxy write FGlobalProxy;
  end;

// http://user:parola@host:port -> componente; Result = False daca nu e un URL de proxy
function PWParseProxyUrl(const AUrl: string; out AHost: string; out APort: Integer; out AUser, APass: string): Boolean;
// calea curl.exe (Windows 10+ il are in System32); '' = lipseste
function PWCurlPath: string;

implementation

uses
  Winapi.Windows, System.DateUtils, System.Math, System.NetEncoding, System.NetConsts, System.IOUtils;

function PWCurlPath: string;
var
  Buf: array[0..MAX_PATH] of Char;
begin
  if GetSystemDirectory(Buf, MAX_PATH) > 0 then
  begin
    Result := IncludeTrailingPathDelimiter(Buf) + 'curl.exe';
    if FileExists(Result) then
      Exit;
  end;
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'curl.exe';
  if not FileExists(Result) then
    Result := '';
end;

// ruleaza un program ascuns, intoarce stdout-ul si codul de iesire
function RunHidden(const ACmdLine: string; ATimeoutMs: Integer; out AStdOut: string; out AExitCode: Cardinal): Boolean;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  ReadPipe, WritePipe: THandle;
  Buf: array[0..4095] of AnsiChar;
  Read: DWORD;
  Raw: TBytes;
  Cmd: string;
  WaitRes: DWORD;
begin
  Result := False;
  AStdOut := '';
  AExitCode := 0;
  SA.nLength := SizeOf(SA);
  SA.bInheritHandle := True;
  SA.lpSecurityDescriptor := nil;
  if not CreatePipe(ReadPipe, WritePipe, @SA, 0) then
    Exit;
  try
    SetHandleInformation(ReadPipe, HANDLE_FLAG_INHERIT, 0);
    ZeroMemory(@SI, SizeOf(SI));
    SI.cb := SizeOf(SI);
    SI.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
    SI.wShowWindow := SW_HIDE;
    SI.hStdOutput := WritePipe;
    SI.hStdError := WritePipe;
    SI.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    Cmd := ACmdLine;
    UniqueString(Cmd);
    if not CreateProcess(nil, PChar(Cmd), nil, nil, True, CREATE_NO_WINDOW, nil, nil, SI, PI) then
      Exit;
    CloseHandle(WritePipe);
    WritePipe := 0;
    try
      // citim pina se inchide pipe-ul (procesul s-a terminat)
      while ReadFile(ReadPipe, Buf, SizeOf(Buf), Read, nil) and (Read > 0) do
      begin
        SetLength(Raw, Length(Raw) + Integer(Read));
        Move(Buf, Raw[Length(Raw) - Integer(Read)], Read);
      end;
      WaitRes := WaitForSingleObject(PI.hProcess, ATimeoutMs);
      if WaitRes = WAIT_TIMEOUT then
        TerminateProcess(PI.hProcess, 1);
      GetExitCodeProcess(PI.hProcess, AExitCode);
      AStdOut := TEncoding.UTF8.GetString(Raw);
      Result := WaitRes = WAIT_OBJECT_0;
    finally
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;
  finally
    if WritePipe <> 0 then
      CloseHandle(WritePipe);
    CloseHandle(ReadPipe);
  end;
end;

const
  cUserAgents: array[0..5] of string = (
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:131.0) Gecko/20100101 Firefox/131.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36');

function PWParseProxyUrl(const AUrl: string; out AHost: string; out APort: Integer; out AUser, APass: string): Boolean;
var
  S, Auth, HostPort: string;
  P: Integer;
begin
  Result := False;
  AHost := '';
  APort := 0;
  AUser := '';
  APass := '';
  S := Trim(AUrl);
  if S = '' then
    Exit;
  P := Pos('://', S);
  if P > 0 then
    S := Copy(S, P + 3, MaxInt);
  P := LastDelimiter('@', S);
  if P > 0 then
  begin
    Auth := Copy(S, 1, P - 1);
    HostPort := Copy(S, P + 1, MaxInt);
    P := Pos(':', Auth);
    if P > 0 then
    begin
      AUser := TNetEncoding.URL.Decode(Copy(Auth, 1, P - 1));
      APass := TNetEncoding.URL.Decode(Copy(Auth, P + 1, MaxInt));
    end
    else
      AUser := TNetEncoding.URL.Decode(Auth);
  end
  else
    HostPort := S;
  if (HostPort <> '') and (HostPort[Length(HostPort)] = '/') then
    Delete(HostPort, Length(HostPort), 1);
  P := LastDelimiter(':', HostPort);
  if P > 0 then
  begin
    AHost := Copy(HostPort, 1, P - 1);
    APort := StrToIntDef(Copy(HostPort, P + 1, MaxInt), 0);
  end
  else
  begin
    AHost := HostPort;
    APort := 8080;
  end;
  Result := (AHost <> '') and (APort > 0);
end;

{ TPWFetcher }

constructor TPWFetcher.Create(const AGlobalProxy: string; const ALog: TPWLogEvent; const ACancelled: TFunc<Boolean>);
begin
  inherited Create;
  FClients := TObjectDictionary<Integer, THTTPClient>.Create([doOwnsValues]);
  FLastRequest := TDictionary<Integer, TDateTime>.Create;
  FUseCurl := TDictionary<Integer, Boolean>.Create;
  FGlobalProxy := AGlobalProxy;
  FLog := ALog;
  FCancelled := ACancelled;
  Randomize;
  FUaIndex := Random(Length(cUserAgents));
end;

destructor TPWFetcher.Destroy;
begin
  FClients.Free;
  FLastRequest.Free;
  FUseCurl.Free;
  inherited;
end;

procedure TPWFetcher.Log(const AMessage: string);
begin
  if Assigned(FLog) then
    FLog(AMessage);
end;

procedure TPWFetcher.ForceCurl(ASiteID: Integer);
begin
  FUseCurl.AddOrSetValue(ASiteID, True);
end;

{ Aceeasi cerere prin curl.exe (alt stack TLS decit WinHTTP): la xstore.md WinHTTP ramine fara
  raspuns dupa serii de cereri (12002), curl trece. Codul HTTP vine pe stdout (-w), corpul in fisier. }
function TPWFetcher.CurlGet(const ASite: TPWSite; const AUrl: string): TPWFetchResult;
var
  CurlExe, TmpFile, Cmd, StdOut, Proxy, UA: string;
  ExitCode: Cardinal;
  T0: TDateTime;
begin
  Result := Default(TPWFetchResult);
  CurlExe := PWCurlPath;
  if CurlExe = '' then
  begin
    Result.Error := 'curl.exe lipseste';
    Exit;
  end;
  if ASite.UserAgent <> '' then
    UA := ASite.UserAgent
  else
  begin
    if FCurrentUA = '' then
      FCurrentUA := NextUserAgent;
    UA := FCurrentUA;
  end;
  Proxy := ASite.ProxyUrl;
  if Proxy = '' then
    Proxy := FGlobalProxy;
  TmpFile := TPath.Combine(TPath.GetTempPath, Format('pw_%d_%d.html', [GetCurrentProcessId, ASite.SiteID]));
  Cmd := Format('"%s" -s -S -L --compressed --max-time 40 -A "%s" -H "Accept-Language: ro-RO,ro;q=0.9,ru;q=0.8,en;q=0.6" ' +
    '-H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -e "%s/" -o "%s" -w "%%{http_code}" "%s"',
    [CurlExe, UA, ASite.BaseUrl, TmpFile, AUrl]);
  if Proxy <> '' then
    Cmd := Cmd + ' -x "' + Proxy + '"';
  T0 := Now;
  try
    if not RunHidden(Cmd, 60000, StdOut, ExitCode) then
    begin
      Result.Error := 'curl: nu a pornit sau a depasit timpul';
      Exit;
    end;
    StdOut := Trim(StdOut);
    Result.StatusCode := StrToIntDef(Copy(StdOut, Length(StdOut) - 2, 3), 0);
    if (ExitCode <> 0) or (Result.StatusCode = 0) then
    begin
      Result.Error := Format('curl: cod iesire %d, %s', [ExitCode, Copy(StdOut, 1, 200)]);
      Exit;
    end;
    Result.Ok := True;
    if FileExists(TmpFile) then
      Result.Body := TFile.ReadAllText(TmpFile, TEncoding.UTF8);
  finally
    if FileExists(TmpFile) then
      TFile.Delete(TmpFile);
    Result.ElapsedMs := MilliSecondsBetween(Now, T0);
  end;
end;

function TPWFetcher.NextUserAgent: string;
begin
  FUaIndex := (FUaIndex + 1) mod Length(cUserAgents);
  Result := cUserAgents[FUaIndex];
end;

procedure TPWFetcher.ApplyProxy(AClient: THTTPClient; const AProxyUrl: string);
var
  Host, User, Pass: string;
  Port: Integer;
begin
  if PWParseProxyUrl(AProxyUrl, Host, Port, User, Pass) then
    AClient.ProxySettings := TProxySettings.Create(Host, Port, User, Pass)
  else
    AClient.ProxySettings := TProxySettings.Create('', 0);
end;

function TPWFetcher.ClientFor(const ASite: TPWSite): THTTPClient;
var
  Proxy: string;
begin
  if not FClients.TryGetValue(ASite.SiteID, Result) then
  begin
    Result := THTTPClient.Create;
    Result.ConnectionTimeout := 15000;
    Result.ResponseTimeout := 40000;
    Result.HandleRedirects := True;
    Result.AutomaticDecompression := [THTTPCompressionMethod.Any];
    Result.AllowCookies := True;
    Result.SecureProtocols := [THTTPSecureProtocol.TLS12, THTTPSecureProtocol.TLS13];
    Result.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8';
    Result.AcceptLanguage := 'ro-RO,ro;q=0.9,ru;q=0.8,en-US;q=0.7,en;q=0.6';
    Result.CustomHeaders['Upgrade-Insecure-Requests'] := '1';
    Result.CustomHeaders['Cache-Control'] := 'no-cache';
    FClients.Add(ASite.SiteID, Result);
  end;
  if ASite.UserAgent <> '' then
    Result.UserAgent := ASite.UserAgent
  else if (Result.UserAgent = '') or (Random(4) = 0) then
    Result.UserAgent := NextUserAgent;   // schimbam agentul din cind in cind, nu la fiecare cerere
  Proxy := ASite.ProxyUrl;
  if Proxy = '' then
    Proxy := FGlobalProxy;
  ApplyProxy(Result, Proxy);
end;

procedure TPWFetcher.Sleep(AMs: Integer);
var
  Left: Integer;
begin
  Left := AMs;
  while Left > 0 do
  begin
    if Assigned(FCancelled) and FCancelled() then
      Exit;
    System.SysUtils.Sleep(Min(Left, 200));
    Dec(Left, 200);
  end;
end;

procedure TPWFetcher.WaitSiteDelay(const ASite: TPWSite);
var
  Last: TDateTime;
  Wanted, Passed: Integer;
begin
  Wanted := ASite.DelayMinMs + Random(Max(1, ASite.DelayMaxMs - ASite.DelayMinMs + 1));
  if FLastRequest.TryGetValue(ASite.SiteID, Last) then
  begin
    Passed := MilliSecondsBetween(Now, Last);
    if Passed < Wanted then
      Sleep(Wanted - Passed);
  end;
end;

function TPWFetcher.Get(const ASite: TPWSite; const AUrl: string): TPWFetchResult;
var
  Client: THTTPClient;
  Resp: IHTTPResponse;
  T0: TDateTime;
begin
  Result := Default(TPWFetchResult);
  WaitSiteDelay(ASite);
  if Assigned(FCancelled) and FCancelled() then
  begin
    Result.Error := 'oprit';
    Exit;
  end;
  T0 := Now;
  FLastRequest.AddOrSetValue(ASite.SiteID, T0);
  if FUseCurl.ContainsKey(ASite.SiteID) then
  begin
    Result := CurlGet(ASite, AUrl);
    FLastRequest.AddOrSetValue(ASite.SiteID, Now);
    Exit;
  end;
  Client := ClientFor(ASite);
  if ASite.BaseUrl <> '' then
    Client.CustomHeaders['Referer'] := ASite.BaseUrl + '/';
  try
    Resp := Client.Get(AUrl);
    Result.Ok := True;
    Result.StatusCode := Resp.StatusCode;
  except
    on E: Exception do
    begin
      // WinHTTP nu primeste raspuns (12002 "Error sending data"): aceeasi cerere prin curl.exe;
      // daca merge, site-ul ramine pe curl pina la repornirea programului
      Result.Error := E.ClassName + ': ' + E.Message;
      FClients.Remove(ASite.SiteID);
      if not (Assigned(FCancelled) and FCancelled()) and (PWCurlPath <> '') then
      begin
        Result := CurlGet(ASite, AUrl);
        if Result.Ok then
        begin
          FUseCurl.AddOrSetValue(ASite.SiteID, True);
          Log(Format('[%s] WinHTTP fara raspuns (%s) - trec pe curl.exe pentru acest site', [ASite.SiteCode, E.Message]));
          FLastRequest.AddOrSetValue(ASite.SiteID, Now);
          Exit;
        end
        else
          Result.Error := E.ClassName + ': ' + E.Message + '; ' + Result.Error;
      end;
    end;
  end;
  if Result.Ok then
  begin
    try
      Result.Body := Resp.ContentAsString;
    except
      // antet de charset lipsa / gresit: incercam UTF-8
      Result.Body := Resp.ContentAsString(TEncoding.UTF8);
    end;
  end
  else
    Result.StatusCode := 0;
  Result.ElapsedMs := MilliSecondsBetween(Now, T0);
  FLastRequest.AddOrSetValue(ASite.SiteID, Now);
end;

end.

unit PWMonitorThread;

{ WMSPriceWatch - firul care ruleaza non-stop: parcurge, la rind, categoriile active
  pe fiecare site activ (TWEB_COMPETITOR_CAT_URLS), scrie produsele si preturile
  (TWEB_COMPETITOR_ITEMS, istoricul il fac triggerele), face asocierea automata
  cu produsele noastre si tine jurnalul scanarilor. Intre doua parcurgeri complete
  sta CYCLE_PAUSE_MIN minute. Raportul Excel NU se face aici (are nevoie de VCL):
  fereastra principala il face pe firul ei, cind vine ora.

  Protectie la blocare: pauza aleatoare intre cereri (PWHttpUnit), iar la 403/429/503,
  la pagina de captcha (BLOCK_REGEX) sau la erori repetate site-ul e pus in asteptare
  (BLOCKED_UNTIL) cu un interval care creste: 10 min, 20, 40 ... maxim 6 ore. }

interface

uses
  System.SysUtils, System.Classes, System.SyncObjs, System.Generics.Collections,
  PWTypes, PWDbUnit, PWHttpUnit, PWParserUnit, PWMatchUnit;

type
  TPWStateEvent = reference to procedure(const AState: TPWMonitorState);

  TPWMonitorThread = class(TThread)
  private
    FConn: TPWConnParams;
    FLog: TPWLogEvent;
    FOnState: TPWStateEvent;
    FLock: TCriticalSection;
    FState: TPWMonitorState;
    FWake: TEvent;
    FDb: TPWDb;
    FFetcher: TPWFetcher;
    FConfig: TPWConfig;
    FLastError: string;
    procedure Log(const AMessage: string); overload;
    procedure Log(const AFormat: string; const AArgs: array of const); overload;
    procedure UpdateState(const AProc: TProc);
    function IsCancelled: Boolean;
    procedure WaitMinutes(AMinutes: Integer);
    procedure RunCycle;
    procedure ScanCategory(var ASite: TPWSite; const ACat: TPWCategory; const ACatUrl: TPWCatUrl;
      const AOurGoods: TArray<TPWOurGoods>);
    procedure BlockSite(var ASite: TPWSite; const AReason: string);
    function PageUrl(const ASite: TPWSite; const ABaseUrl: string; APage: Integer): string;
  protected
    procedure Execute; override;
  public
    constructor Create(const AConn: TPWConnParams; const ALog: TPWLogEvent; const AOnState: TPWStateEvent);
    destructor Destroy; override;
    // intrerupe pauza dintre cicluri: urmatorul ciclu porneste imediat
    procedure RunNow;
    procedure Stop;
    function GetState: TPWMonitorState;
    property Config: TPWConfig read FConfig;
    property LastError: string read FLastError;
  end;

implementation

uses
  System.DateUtils, System.Math, System.StrUtils;

{ TPWMonitorThread }

constructor TPWMonitorThread.Create(const AConn: TPWConnParams; const ALog: TPWLogEvent; const AOnState: TPWStateEvent);
begin
  inherited Create(True);
  FreeOnTerminate := False;
  FConn := AConn;
  FLog := ALog;
  FOnState := AOnState;
  FLock := TCriticalSection.Create;
  FWake := TEvent.Create(nil, False, False, '');
  FConfig := TPWConfig.Defaults;
end;

destructor TPWMonitorThread.Destroy;
begin
  FWake.Free;
  FLock.Free;
  inherited;
end;

procedure TPWMonitorThread.Log(const AMessage: string);
var
  Msg: string;
begin
  if not Assigned(FLog) then
    Exit;
  Msg := AMessage;
  TThread.Queue(nil,
    procedure
    begin
      FLog(Msg);
    end);
end;

procedure TPWMonitorThread.Log(const AFormat: string; const AArgs: array of const);
begin
  Log(Format(AFormat, AArgs));
end;

procedure TPWMonitorThread.UpdateState(const AProc: TProc);
var
  Copy: TPWMonitorState;
begin
  FLock.Enter;
  try
    AProc();
    Copy := FState;
  finally
    FLock.Leave;
  end;
  if Assigned(FOnState) then
    TThread.Queue(nil,
      procedure
      begin
        FOnState(Copy);
      end);
end;

function TPWMonitorThread.GetState: TPWMonitorState;
begin
  FLock.Enter;
  try
    Result := FState;
  finally
    FLock.Leave;
  end;
end;

function TPWMonitorThread.IsCancelled: Boolean;
begin
  Result := Terminated;
end;

procedure TPWMonitorThread.RunNow;
begin
  FWake.SetEvent;
end;

procedure TPWMonitorThread.Stop;
begin
  Terminate;
  FWake.SetEvent;
end;

procedure TPWMonitorThread.WaitMinutes(AMinutes: Integer);
var
  Deadline: TDateTime;
begin
  Deadline := IncMinute(Now, AMinutes);
  while (not Terminated) and (Now < Deadline) do
    if FWake.WaitFor(1000) = wrSignaled then
      Break;
end;

function TPWMonitorThread.PageUrl(const ASite: TPWSite; const ABaseUrl: string; APage: Integer): string;
begin
  if Trim(ASite.PageUrlTpl) = '' then
    Result := ABaseUrl
  else
  begin
    Result := StringReplace(ASite.PageUrlTpl, '{url}', ABaseUrl, [rfReplaceAll, rfIgnoreCase]);
    Result := StringReplace(Result, '{page}', IntToStr(APage), [rfReplaceAll, rfIgnoreCase]);
  end;
end;

procedure TPWMonitorThread.BlockSite(var ASite: TPWSite; const AReason: string);
var
  Minutes: Integer;
begin
  Inc(ASite.FailCount);
  Minutes := Min(10 * (1 shl Min(ASite.FailCount - 1, 6)), 6 * 60);   // 10, 20, 40, 80, 160, 320, 360 min
  ASite.BlockedUntil := IncMinute(Now, Minutes);
  Log('[%s] %s -> pauza %d min (esec nr. %d)', [ASite.SiteCode, AReason, Minutes, ASite.FailCount]);
  try
    FDb.SiteStatus(ASite.SiteID, Format('%s; pauza pina la %s', [AReason, FormatDateTime('dd.mm hh:nn', ASite.BlockedUntil)]),
      ASite.FailCount, ASite.BlockedUntil);
  except
    on E: Exception do
      Log('[%s] SiteStatus: %s', [ASite.SiteCode, E.Message]);
  end;
  UpdateState(procedure begin Inc(FState.Errors); end);
end;

procedure TPWMonitorThread.ScanCategory(var ASite: TPWSite; const ACat: TPWCategory; const ACatUrl: TPWCatUrl;
  const AOurGoods: TArray<TPWOurGoods>);
var
  ScanID, Page, Pages, NewCnt, Changes, I, Status: Integer;
  Started: TDateTime;
  Url, ErrorText: string;
  R: TPWFetchResult;
  P: TPWParseResult;
  Items: TList<TPWSiteItem>;
  SeenUrls: TDictionary<string, Boolean>;
  Titles: TArray<string>;
  Matcher: TPWMatcher;
  Up: TPWUpsertResult;
  Cand: TPWMatchCandidate;
  PageNew: Integer;
  MinScore: Double;
  Item: TPWSiteItem;
  SiteCode, CatTitle: string;   // copii locale: parametrii var/const nu pot fi capturati de metodele anonime
begin
  SiteCode := ASite.SiteCode;
  CatTitle := ACat.Title;
  Started := Now;
  Pages := 0;
  NewCnt := 0;
  Changes := 0;
  Status := 0;
  ErrorText := '';
  ScanID := FDb.ScanStart(ASite.SiteID, ACat.CatID);
  Items := TList<TPWSiteItem>.Create;
  SeenUrls := TDictionary<string, Boolean>.Create;
  try
    UpdateState(procedure
      begin
        FState.CurrentSite := SiteCode;
        FState.CurrentCategory := CatTitle;
        FState.CurrentPage := 0;
      end);

    { 1. paginile }
    Page := ASite.FirstPage;
    while not Terminated do
    begin
      Url := PageUrl(ASite, ACatUrl.Url, Page);
      UpdateState(procedure begin FState.CurrentPage := Page; end);
      R := FFetcher.Get(ASite, Url);
      UpdateState(procedure begin Inc(FState.Requests); end);
      if Terminated then
        Break;

      if not R.Ok then
      begin
        ErrorText := 'Retea: ' + R.Error;
        Log('[%s/%s] %s: %s', [ASite.SiteCode, ACat.Title, Url, ErrorText]);
        Status := 1;
        BlockSite(ASite, 'nu raspunde');
        Break;
      end;

      if (R.StatusCode = 404) and (Page > ASite.FirstPage) then
        Break;   // dupa ultima pagina (xstore)

      if (R.StatusCode = 403) or (R.StatusCode = 429) or (R.StatusCode = 503) then
      begin
        ErrorText := Format('HTTP %d', [R.StatusCode]);
        Status := 2;
        BlockSite(ASite, ErrorText);
        Break;
      end;

      if R.StatusCode <> 200 then
      begin
        ErrorText := Format('HTTP %d la %s', [R.StatusCode, Url]);
        Log('[%s/%s] %s', [ASite.SiteCode, ACat.Title, ErrorText]);
        Status := 1;
        Break;
      end;

      P := PWParsePage(ASite, R.Body);
      if P.Error <> '' then
      begin
        ErrorText := P.Error;
        Log('[%s/%s] %s', [ASite.SiteCode, ACat.Title, ErrorText]);
        Status := 1;
        Break;
      end;
      if P.Blocked then
      begin
        ErrorText := 'pagina de verificare (captcha / challenge)';
        Status := 2;
        BlockSite(ASite, ErrorText);
        Break;
      end;

      PageNew := 0;
      for Item in P.Items do
        if not SeenUrls.ContainsKey(LowerCase(Item.Url)) then
        begin
          SeenUrls.Add(LowerCase(Item.Url), True);
          Items.Add(Item);
          Inc(PageNew);
        end;
      Inc(Pages);
      Log('[%s/%s] pagina %d: %d produse (%d noi pe pagina, %d sarite), %d ms',
        [ASite.SiteCode, ACat.Title, Page, Length(P.Items), PageNew, P.Skipped, R.ElapsedMs]);

      // sfirsitul listei: pagina goala sau site-ul repeta ultima pagina
      if (Length(P.Items) = 0) or (PageNew = 0) then
        Break;
      if (Trim(ASite.PageUrlTpl) = '') or (Pages >= ASite.MaxPages) then
        Break;
      Inc(Page);
    end;

    if Terminated then
    begin
      Status := 1;
      ErrorText := 'oprit';
    end;

    { 2. scrierea + asocierea }
    if Items.Count > 0 then
    begin
      SetLength(Titles, Items.Count);
      for I := 0 to Items.Count - 1 do
        Titles[I] := Items[I].Title;
      MinScore := ACat.MinScore;
      if MinScore <= 0 then
        MinScore := FConfig.MinScore;
      Matcher := TPWMatcher.Create(AOurGoods, Titles, MinScore);
      try
        for I := 0 to Items.Count - 1 do
        begin
          Item := Items[I];
          Up := FDb.UpsertItem(ASite.SiteID, ACat.CatID, Item, PWMatchKey(Item.Title));
          if Up.IsNew then
            Inc(NewCnt);
          if Up.PriceChanged then
          begin
            Inc(Changes);
            Log('[%s/%s] pret schimbat %.0f -> %.0f: %s', [ASite.SiteCode, ACat.Title, Up.OldPriceValue, Item.Price, Item.Title]);
          end;
          // asocierile manuale (si cele respinse manual) nu se ating
          if not (Up.MatchType in [cPWMatchManual, cPWMatchRejected]) then
          begin
            if Matcher.BestMatch(Item.Title, Cand) then
            begin
              if (Up.GoodsID <> Cand.GoodsID) or (Up.MatchType <> cPWMatchAuto) then
                FDb.SetMatch(Up.ItemID, Cand.GoodsID, cPWMatchAuto, Cand.Score);
            end
            else if Up.GoodsID <> 0 then
              FDb.SetMatch(Up.ItemID, 0, cPWMatchNone, 0);
          end;
          if (I mod 50) = 49 then
            FDb.Commit;
        end;
        FDb.Commit;
      finally
        Matcher.Free;
      end;
      if Status = 0 then
      begin
        FDb.DeactivateMissing(ASite.SiteID, ACat.CatID, Started, Items.Count);
        FDb.Commit;
      end;
    end
    else if (Status = 0) and (Pages > 0) then
    begin
      // pagina a venit, dar fara produse: regex-ul nu se mai potriveste sau site-ul s-a schimbat
      Status := 2;
      ErrorText := 'niciun produs gasit - verificati ITEM_REGEX / URL-ul categoriei';
      Log('[%s/%s] %s', [ASite.SiteCode, ACat.Title, ErrorText]);
    end;

    if (Status = 0) and (ASite.FailCount > 0) then
    begin
      ASite.FailCount := 0;
      ASite.BlockedUntil := 0;
      FDb.SiteStatus(ASite.SiteID, 'OK', 0, 0);
    end
    else if Status = 0 then
      FDb.SiteStatus(ASite.SiteID, 'OK', 0, 0);

    Log('[%s/%s] gata: %d pagini, %d produse, %d noi, %d schimbari de pret, %s',
      [ASite.SiteCode, ACat.Title, Pages, Items.Count, NewCnt, Changes, IfThen(ErrorText = '', 'OK', ErrorText)]);
  finally
    try
      FDb.ScanFinish(ScanID, Pages, Items.Count, NewCnt, Changes, Status, ErrorText);
      FDb.CatUrlStatus(ACatUrl.CatUrlID, Items.Count, ErrorText);
    except
      on E: Exception do
        Log('[%s/%s] jurnal: %s', [ASite.SiteCode, ACat.Title, E.Message]);
    end;
    Items.Free;
    SeenUrls.Free;
  end;
end;

procedure TPWMonitorThread.RunCycle;
var
  Sites: TArray<TPWSite>;
  Cats: TArray<TPWCategory>;
  Urls: TArray<TPWCatUrl>;
  OurGoods: TArray<TPWOurGoods>;
  C: TPWCategory;
  U: TPWCatUrl;
  I: Integer;
begin
  FConfig := FDb.LoadConfig;
  FFetcher.GlobalProxy := FConfig.ProxyUrl;
  Sites := FDb.LoadSites(True);
  Cats := FDb.LoadCategories(True);
  Urls := FDb.LoadCatUrls(True);
  UpdateState(procedure
    begin
      Inc(FState.CycleNo);
      FState.LastCycleStart := Now;
      FState.LastCycleEnd := 0;
    end);
  Log('Ciclul %d: %d site-uri, %d categorii, %d URL-uri; pauza intre cereri = a site-ului, intre cicluri %d min',
    [GetState.CycleNo, Length(Sites), Length(Cats), Length(Urls), FConfig.CyclePauseMin]);

  for C in Cats do
  begin
    if Terminated then
      Exit;
    try
      OurGoods := FDb.LoadOurGoods(C.CatalogID);
    except
      on E: Exception do
      begin
        Log('[%s] produsele noastre: %s', [C.Title, E.Message]);
        Continue;
      end;
    end;
    Log('[%s] %d produse ale noastre active pe site', [C.Title, Length(OurGoods)]);
    for I := 0 to High(Sites) do
    begin
      if Terminated then
        Exit;
      if (Sites[I].BlockedUntil > 0) and (Sites[I].BlockedUntil > Now) then
      begin
        Log('[%s/%s] sarit: in pauza pina la %s', [Sites[I].SiteCode, C.Title,
          FormatDateTime('dd.mm hh:nn', Sites[I].BlockedUntil)]);
        Continue;
      end;
      for U in Urls do
        if (U.SiteID = Sites[I].SiteID) and (U.CatID = C.CatID) then
        begin
          try
            ScanCategory(Sites[I], C, U, OurGoods);
          except
            on E: Exception do
            begin
              Log('[%s/%s] EROARE: %s: %s', [Sites[I].SiteCode, C.Title, E.ClassName, E.Message]);
              FLastError := E.Message;
              UpdateState(procedure begin Inc(FState.Errors); end);
              try
                FDb.Rollback;
              except
              end;
            end;
          end;
          if Terminated then
            Exit;
        end;
    end;
  end;
  UpdateState(procedure
    begin
      FState.LastCycleEnd := Now;
      FState.CurrentSite := '';
      FState.CurrentCategory := '';
      FState.CurrentPage := 0;
    end);
end;

procedure TPWMonitorThread.Execute;
begin
  NameThreadForDebugging('PWMonitor');
  UpdateState(procedure begin FState.Running := True; end);
  try
    try
      FDb := TPWDb.Create(CreatePWConnection(FConn.Server, FConn.Port, FConn.Database, FConn.User, FConn.Password), True);
    except
      on E: Exception do
      begin
        FLastError := 'Conexiune: ' + E.Message;
        Log(FLastError);
        Exit;
      end;
    end;
    FFetcher := TPWFetcher.Create('', FLog, IsCancelled);
    try
      while not Terminated do
      begin
        try
          RunCycle;
        except
          on E: Exception do
          begin
            FLastError := E.Message;
            Log('Ciclu intrerupt: %s: %s', [E.ClassName, E.Message]);
            try
              FDb.Rollback;
            except
            end;
            // conexiunea pierduta: reincercam
            try
              if not FDb.Connection.Connected then
                FDb.Connection.Connected := True;
            except
              on E2: Exception do
                Log('Reconectare: %s', [E2.Message]);
            end;
          end;
        end;
        if Terminated then
          Break;
        Log('Ciclu terminat; urmatorul in %d min.', [FConfig.CyclePauseMin]);
        WaitMinutes(FConfig.CyclePauseMin);
      end;
    finally
      FFetcher.Free;
      FDb.Free;
    end;
  finally
    UpdateState(procedure
      begin
        FState.Running := False;
        FState.CurrentSite := '';
        FState.CurrentCategory := '';
      end);
    Log('Monitorul s-a oprit.');
  end;
end;

end.

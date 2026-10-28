unit PWDbUnit;

{ WMSPriceWatch - accesul la baza: conexiunea (aceleasi setari ca dmDB din WMS),
  configurarea, site-urile / categoriile / URL-urile, produsele noastre, scrierea
  produselor gasite, istoricul, jurnalul scanarilor si al rapoartelor.
  Fiecare fir isi face propriul TPWDb (propria conexiune). }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Data.DB, IBC, DBAccess, PWTypes;

type
  TPWUpsertResult = record
    ItemID: Integer;
    IsNew: Boolean;
    PriceChanged: Boolean;
    OldPriceValue: Double;
    GoodsID: Integer;        // asocierea existenta (0 = nu)
    MatchType: Integer;
  end;

  TPWItemRow = record
    ItemID: Integer;
    Title: string;
    MatchKey: string;
    GoodsID: Integer;
    MatchType: Integer;
    Price: Double;
  end;

  TPWDb = class
  private
    FConnection: TIBCConnection;
    FTransaction: TIBCTransaction;
    FQuery: TIBCQuery;
    FOwnsConnection: Boolean;
    procedure EnsureTransaction;
    function Q(const ASQL: string): TIBCQuery;
    function NextID(const ASequence: string): Integer;
  public
    constructor Create(AConnection: TIBCConnection; AOwnsConnection: Boolean);
    destructor Destroy; override;
    procedure Commit;
    procedure Rollback;

    function LoadConfig: TPWConfig;
    function LoadSites(AOnlyActive: Boolean): TArray<TPWSite>;
    function LoadCategories(AOnlyActive: Boolean): TArray<TPWCategory>;
    function LoadCatUrls(AOnlyActive: Boolean): TArray<TPWCatUrl>;
    function LoadOurGoods(ACatalogID: Integer): TArray<TPWOurGoods>;
    function LoadItems(ASiteID, ACatID: Integer; AOnlyActive: Boolean): TArray<TPWItemRow>;

    function UpsertItem(ASiteID, ACatID: Integer; const AItem: TPWSiteItem; const AMatchKey: string): TPWUpsertResult;
    procedure SetMatch(AItemID, AGoodsID, AMatchType: Integer; AScore: Double);
    // produsele care nu au mai aparut in scanarea curenta (LAST_SEEN inainte de AScanStarted)
    // devin inactive; ASeenCount = 0 (site-ul nu a raspuns) nu dezactiveaza nimic
    procedure DeactivateMissing(ASiteID, ACatID: Integer; AScanStarted: TDateTime; ASeenCount: Integer);

    function ScanStart(ASiteID, ACatID: Integer): Integer;
    procedure ScanFinish(AScanID, APages, AFound, ANew, AChanges, AStatus: Integer; const AError: string);
    procedure CatUrlStatus(ACatUrlID, AItems: Integer; const AError: string);
    procedure SiteStatus(ASiteID: Integer; const AStatus: string; AFailCount: Integer; ABlockedUntil: TDateTime);

    function ReportLog(const AFileName: string; AItems, AMatched, AChanges: Integer; ASent: Boolean;
      const AError: string): Integer;
    // tokenul botului + chat-ul canalului (TS_API_CONFIG / TELEGRAM, TELEGRAM_CHANNELS)
    procedure TelegramTarget(const AChannel: string; out AToken, AChatID: string; out AThreadID: Integer);
    procedure TelegramQueueText(const AChannel, AText: string);

    property Connection: TIBCConnection read FConnection;
  end;

// Conexiune cu aceleasi setari ca dmDB.IBCConnection din WMS. Apelantul o elibereaza.
function CreatePWConnection(const AServer: string; APort: Integer; const ADatabase, AUser, APassword: string): TIBCConnection;

implementation

uses
  System.Hash, System.StrUtils, SWNConst;

function CreatePWConnection(const AServer: string; APort: Integer; const ADatabase, AUser, APassword: string): TIBCConnection;
begin
  Result := TIBCConnection.Create(nil);
  try
    Result.Options.Charset := 'UTF8';
    Result.Options.UseUnicode := True;
    Result.Options.EnableMemos := True;
    Result.ClientLibrary := 'fbclient.dll';
    Result.LoginPrompt := False;
    Result.Database := Format('%s/%d:%s', [AServer, APort, ADatabase]);
    Result.Username := AUser;
    Result.Password := APassword;
    Result.Connected := True;
  except
    Result.Free;
    raise;
  end;
end;

{ TPWDb }

constructor TPWDb.Create(AConnection: TIBCConnection; AOwnsConnection: Boolean);
begin
  inherited Create;
  FConnection := AConnection;
  FOwnsConnection := AOwnsConnection;
  FTransaction := TIBCTransaction.Create(nil);
  FTransaction.DefaultConnection := FConnection;
  FQuery := TIBCQuery.Create(nil);
  FQuery.Connection := FConnection;
  FQuery.Transaction := FTransaction;
  FQuery.UpdateTransaction := FTransaction;
  FQuery.AutoCommit := False;
end;

destructor TPWDb.Destroy;
begin
  try
    if FTransaction.Active then
      FTransaction.Rollback;
  except
  end;
  FQuery.Free;
  FTransaction.Free;
  if FOwnsConnection then
    FConnection.Free;
  inherited;
end;

procedure TPWDb.EnsureTransaction;
begin
  if not FTransaction.Active then
    FTransaction.StartTransaction;
end;

function TPWDb.Q(const ASQL: string): TIBCQuery;
begin
  EnsureTransaction;
  FQuery.Close;
  FQuery.SQL.Text := ASQL;
  Result := FQuery;
end;

function TPWDb.NextID(const ASequence: string): Integer;
begin
  with Q('SELECT NEXT VALUE FOR ' + ASequence + ' FROM RDB$DATABASE') do
  begin
    Open;
    Result := Fields[0].AsInteger;
    Close;
  end;
end;

procedure TPWDb.Commit;
begin
  FQuery.Close;
  if FTransaction.Active then
    FTransaction.Commit;
end;

procedure TPWDb.Rollback;
begin
  FQuery.Close;
  if FTransaction.Active then
    FTransaction.Rollback;
end;

function TPWDb.LoadConfig: TPWConfig;
var
  PName, PValue: string;
  Qry: TIBCQuery;
begin
  Result := TPWConfig.Defaults;
  Qry := Q('SELECT UPPER(TRIM(PARAM_NAME)) AS PARAM_NAME, TRIM(PARAM_VALUE) AS PARAM_VALUE ' +
           'FROM TS_API_CONFIG WHERE API_CODE = :API AND COALESCE(FLG_ACTIVE, 1) = 1');
  Qry.ParamByName('API').AsString := cPWApiCode;
  Qry.Open;
  while not Qry.Eof do
  begin
    PName := Qry.FieldByName('PARAM_NAME').AsString;
    PValue := Qry.FieldByName('PARAM_VALUE').AsString;
    if PValue <> '' then
    begin
      if PName = 'REPORT_INTERVAL_MIN' then
        Result.ReportIntervalMin := StrToIntDef(PValue, Result.ReportIntervalMin)
      else if PName = 'CYCLE_PAUSE_MIN' then
        Result.CyclePauseMin := StrToIntDef(PValue, Result.CyclePauseMin)
      else if PName = 'TELEGRAM_CHANNEL' then
        Result.TelegramChannel := UpperCase(PValue)
      else if PName = 'PROXY_URL' then
        Result.ProxyUrl := PValue
      else if PName = 'MIN_SCORE' then
        Result.MinScore := StrToFloatDef(StringReplace(PValue, ',', '.', []), Result.MinScore, TFormatSettings.Invariant)
      else if PName = 'REPORT_DIR' then
        Result.ReportDir := PValue;
    end;
    Qry.Next;
  end;
  Qry.Close;
  if Result.ReportIntervalMin < 5 then
    Result.ReportIntervalMin := 5;
  if Result.CyclePauseMin < 1 then
    Result.CyclePauseMin := 1;
  Commit;
end;

function TPWDb.LoadSites(AOnlyActive: Boolean): TArray<TPWSite>;
var
  S: TPWSite;
  List: TList<TPWSite>;
begin
  List := TList<TPWSite>.Create;
  try
    with Q('SELECT * FROM TWEB_COMPETITOR_SITES ' + IfThen(AOnlyActive, 'WHERE FLG_ACTIVE = 1 ', '') +
           'ORDER BY SITE_CODE') do
    begin
      Open;
      while not Eof do
      begin
        S := Default(TPWSite);
        S.SiteID := FieldByName('SITEID').AsInteger;
        S.SiteCode := Trim(FieldByName('SITE_CODE').AsString);
        S.Title := Trim(FieldByName('TITLE').AsString);
        S.BaseUrl := Trim(FieldByName('BASE_URL').AsString);
        S.Active := FieldByName('FLG_ACTIVE').AsInteger = 1;
        S.DelayMinMs := FieldByName('DELAY_MIN_MS').AsInteger;
        S.DelayMaxMs := FieldByName('DELAY_MAX_MS').AsInteger;
        S.PageUrlTpl := Trim(FieldByName('PAGE_URL_TPL').AsString);
        S.FirstPage := FieldByName('FIRST_PAGE').AsInteger;
        S.MaxPages := FieldByName('MAX_PAGES').AsInteger;
        S.ProxyUrl := Trim(FieldByName('PROXY_URL').AsString);
        S.UserAgent := Trim(FieldByName('USER_AGENT').AsString);
        S.ItemRegex := FieldByName('ITEM_REGEX').AsString;
        S.NameRegex := FieldByName('NAME_REGEX').AsString;
        S.UrlRegex := FieldByName('URL_REGEX').AsString;
        S.PriceRegex := FieldByName('PRICE_REGEX').AsString;
        S.OldPriceRegex := FieldByName('OLDPRICE_REGEX').AsString;
        S.CodeRegex := FieldByName('CODE_REGEX').AsString;
        S.StockRegex := FieldByName('STOCK_REGEX').AsString;
        S.NoStockWords := FieldByName('NOSTOCK_WORDS').AsString;
        S.BlockRegex := FieldByName('BLOCK_REGEX').AsString;
        if not FieldByName('BLOCKED_UNTIL').IsNull then
          S.BlockedUntil := FieldByName('BLOCKED_UNTIL').AsDateTime;
        S.FailCount := FieldByName('FAIL_COUNT').AsInteger;
        if S.DelayMinMs <= 0 then
          S.DelayMinMs := 4000;
        if S.DelayMaxMs < S.DelayMinMs then
          S.DelayMaxMs := S.DelayMinMs;
        if S.MaxPages <= 0 then
          S.MaxPages := 40;
        if S.FirstPage <= 0 then
          S.FirstPage := 1;
        List.Add(S);
        Next;
      end;
      Close;
    end;
    Commit;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TPWDb.LoadCategories(AOnlyActive: Boolean): TArray<TPWCategory>;
var
  C: TPWCategory;
  List: TList<TPWCategory>;
begin
  List := TList<TPWCategory>.Create;
  try
    with Q('SELECT * FROM TWEB_COMPETITOR_CATEGORIES ' + IfThen(AOnlyActive, 'WHERE FLG_ACTIVE = 1 ', '') +
           'ORDER BY ORDERNO, CATID') do
    begin
      Open;
      while not Eof do
      begin
        C := Default(TPWCategory);
        C.CatID := FieldByName('CATID').AsInteger;
        C.CatalogID := FieldByName('CATALOGID').AsInteger;
        C.Title := Trim(FieldByName('TITLE').AsString);
        C.Active := FieldByName('FLG_ACTIVE').AsInteger = 1;
        if not FieldByName('MIN_SCORE').IsNull then
          C.MinScore := FieldByName('MIN_SCORE').AsFloat;
        List.Add(C);
        Next;
      end;
      Close;
    end;
    Commit;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TPWDb.LoadCatUrls(AOnlyActive: Boolean): TArray<TPWCatUrl>;
var
  U: TPWCatUrl;
  List: TList<TPWCatUrl>;
begin
  List := TList<TPWCatUrl>.Create;
  try
    with Q('SELECT * FROM TWEB_COMPETITOR_CAT_URLS ' + IfThen(AOnlyActive, 'WHERE FLG_ACTIVE = 1 ', '') +
           'ORDER BY SITEID, CATID, CATURLID') do
    begin
      Open;
      while not Eof do
      begin
        U := Default(TPWCatUrl);
        U.CatUrlID := FieldByName('CATURLID').AsInteger;
        U.SiteID := FieldByName('SITEID').AsInteger;
        U.CatID := FieldByName('CATID').AsInteger;
        U.Url := Trim(FieldByName('URL').AsString);
        U.Active := FieldByName('FLG_ACTIVE').AsInteger = 1;
        List.Add(U);
        Next;
      end;
      Close;
    end;
    Commit;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TPWDb.LoadOurGoods(ACatalogID: Integer): TArray<TPWOurGoods>;
var
  G: TPWOurGoods;
  List: TList<TPWOurGoods>;
begin
  List := TList<TPWOurGoods>.Create;
  try
    with Q('SELECT GOODSID, CODE, TITLE, VENDOR, PRICE1_LEI, DISCOUNT_MDL, OUR_PRICE ' +
           'FROM SP_COMPETITOR_OUR_GOODS(:CATALOGID)') do
    begin
      ParamByName('CATALOGID').AsInteger := ACatalogID;
      Open;
      while not Eof do
      begin
        G := Default(TPWOurGoods);
        G.GoodsID := FieldByName('GOODSID').AsInteger;
        G.Code := Trim(FieldByName('CODE').AsString);
        G.Title := Trim(FieldByName('TITLE').AsString);
        G.Vendor := Trim(FieldByName('VENDOR').AsString);
        G.Price1 := FieldByName('PRICE1_LEI').AsFloat;
        G.Discount := FieldByName('DISCOUNT_MDL').AsFloat;
        G.OurPrice := FieldByName('OUR_PRICE').AsFloat;
        List.Add(G);
        Next;
      end;
      Close;
    end;
    Commit;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TPWDb.LoadItems(ASiteID, ACatID: Integer; AOnlyActive: Boolean): TArray<TPWItemRow>;
var
  R: TPWItemRow;
  List: TList<TPWItemRow>;
begin
  List := TList<TPWItemRow>.Create;
  try
    with Q('SELECT ITEMID, TITLE, MATCH_KEY, GOODSID, MATCH_TYPE, PRICE FROM TWEB_COMPETITOR_ITEMS ' +
           'WHERE SITEID = :SITEID AND CATID = :CATID ' + IfThen(AOnlyActive, 'AND FLG_ACTIVE = 1 ', '')) do
    begin
      ParamByName('SITEID').AsInteger := ASiteID;
      ParamByName('CATID').AsInteger := ACatID;
      Open;
      while not Eof do
      begin
        R := Default(TPWItemRow);
        R.ItemID := FieldByName('ITEMID').AsInteger;
        R.Title := Trim(FieldByName('TITLE').AsString);
        R.MatchKey := Trim(FieldByName('MATCH_KEY').AsString);
        R.GoodsID := FieldByName('GOODSID').AsInteger;
        R.MatchType := FieldByName('MATCH_TYPE').AsInteger;
        R.Price := FieldByName('PRICE').AsFloat;
        List.Add(R);
        Next;
      end;
      Close;
    end;
    Commit;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TPWDb.UpsertItem(ASiteID, ACatID: Integer; const AItem: TPWSiteItem; const AMatchKey: string): TPWUpsertResult;
var
  Md5: string;
  Title: string;
begin
  Result := Default(TPWUpsertResult);
  Md5 := THashMD5.GetHashString(LowerCase(Trim(AItem.Url)));
  Title := Copy(Trim(AItem.Title), 1, 1000);

  with Q('SELECT ITEMID, PRICE, GOODSID, MATCH_TYPE FROM TWEB_COMPETITOR_ITEMS WHERE SITEID = :SITEID AND URL_MD5 = :MD5') do
  begin
    ParamByName('SITEID').AsInteger := ASiteID;
    ParamByName('MD5').AsString := Md5;
    Open;
    if not Eof then
    begin
      Result.ItemID := FieldByName('ITEMID').AsInteger;
      Result.OldPriceValue := FieldByName('PRICE').AsFloat;
      Result.GoodsID := FieldByName('GOODSID').AsInteger;
      Result.MatchType := FieldByName('MATCH_TYPE').AsInteger;
      Result.PriceChanged := Abs(Result.OldPriceValue - AItem.Price) >= 0.005;
    end;
    Close;
  end;

  if Result.ItemID = 0 then
  begin
    Result.IsNew := True;
    Result.PriceChanged := False;
    Result.ItemID := NextID('SQ_TWEB_COMPETITOR_ITEMS');
    with Q('INSERT INTO TWEB_COMPETITOR_ITEMS (ITEMID, SITEID, CATID, ITEM_URL, URL_MD5, SITE_CODE, TITLE, PRICE, OLD_PRICE, ' +
           'FLG_IN_STOCK, STOCK_TEXT, MATCH_KEY, MATCH_TYPE, FLG_ACTIVE, FIRST_SEEN, LAST_SEEN) ' +
           'VALUES (:ITEMID, :SITEID, :CATID, :URL, :MD5, :CODE, :TITLE, :PRICE, :OLD_PRICE, :IN_STOCK, :STOCK_TEXT, :MATCH_KEY, 0, 1, ' +
           'CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)') do
    begin
      ParamByName('ITEMID').AsInteger := Result.ItemID;
      ParamByName('SITEID').AsInteger := ASiteID;
      ParamByName('CATID').AsInteger := ACatID;
      ParamByName('URL').AsString := Copy(AItem.Url, 1, 1024);
      ParamByName('MD5').AsString := Md5;
      ParamByName('CODE').AsString := Copy(AItem.SiteCode, 1, 60);
      ParamByName('TITLE').AsString := Title;
      ParamByName('PRICE').AsFloat := AItem.Price;
      if AItem.OldPrice > 0 then
        ParamByName('OLD_PRICE').AsFloat := AItem.OldPrice
      else
        ParamByName('OLD_PRICE').Clear;
      ParamByName('IN_STOCK').AsInteger := Ord(AItem.InStock);
      ParamByName('STOCK_TEXT').AsString := Copy(AItem.StockText, 1, 128);
      ParamByName('MATCH_KEY').AsString := Copy(AMatchKey, 1, 1000);
      ExecSQL;
    end;
  end
  else
  begin
    with Q('UPDATE TWEB_COMPETITOR_ITEMS SET CATID = :CATID, ITEM_URL = :URL, SITE_CODE = :CODE, TITLE = :TITLE, ' +
           'PRICE = :PRICE, OLD_PRICE = :OLD_PRICE, FLG_IN_STOCK = :IN_STOCK, STOCK_TEXT = :STOCK_TEXT, ' +
           'MATCH_KEY = :MATCH_KEY, FLG_ACTIVE = 1, LAST_SEEN = CURRENT_TIMESTAMP WHERE ITEMID = :ITEMID') do
    begin
      ParamByName('CATID').AsInteger := ACatID;
      ParamByName('URL').AsString := Copy(AItem.Url, 1, 1024);
      ParamByName('CODE').AsString := Copy(AItem.SiteCode, 1, 60);
      ParamByName('TITLE').AsString := Title;
      ParamByName('PRICE').AsFloat := AItem.Price;
      if AItem.OldPrice > 0 then
        ParamByName('OLD_PRICE').AsFloat := AItem.OldPrice
      else
        ParamByName('OLD_PRICE').Clear;
      ParamByName('IN_STOCK').AsInteger := Ord(AItem.InStock);
      ParamByName('STOCK_TEXT').AsString := Copy(AItem.StockText, 1, 128);
      ParamByName('MATCH_KEY').AsString := Copy(AMatchKey, 1, 1000);
      ParamByName('ITEMID').AsInteger := Result.ItemID;
      ExecSQL;
    end;
  end;
end;

procedure TPWDb.SetMatch(AItemID, AGoodsID, AMatchType: Integer; AScore: Double);
begin
  with Q('UPDATE TWEB_COMPETITOR_ITEMS SET GOODSID = :GOODSID, MATCH_TYPE = :MT, MATCH_SCORE = :SCORE WHERE ITEMID = :ITEMID') do
  begin
    if AGoodsID > 0 then
      ParamByName('GOODSID').AsInteger := AGoodsID
    else
      ParamByName('GOODSID').Clear;
    ParamByName('MT').AsInteger := AMatchType;
    ParamByName('SCORE').AsFloat := AScore;
    ParamByName('ITEMID').AsInteger := AItemID;
    ExecSQL;
  end;
end;

procedure TPWDb.DeactivateMissing(ASiteID, ACatID: Integer; AScanStarted: TDateTime; ASeenCount: Integer);
begin
  // parcurgere fara produse = probabil site-ul nu a raspuns bine; nu dezactivam nimic
  if ASeenCount = 0 then
    Exit;
  with Q('UPDATE TWEB_COMPETITOR_ITEMS SET FLG_ACTIVE = 0 WHERE SITEID = :SITEID AND CATID = :CATID AND FLG_ACTIVE = 1 ' +
         'AND LAST_SEEN < :STARTED') do
  begin
    ParamByName('SITEID').AsInteger := ASiteID;
    ParamByName('CATID').AsInteger := ACatID;
    // ceasul serverului poate diferi putin de al nostru: o marja de un minut
    ParamByName('STARTED').AsDateTime := AScanStarted - (1 / (24 * 60));
    ExecSQL;
  end;
end;

function TPWDb.ScanStart(ASiteID, ACatID: Integer): Integer;
begin
  Result := NextID('SQ_TWEB_COMPETITOR_SCANS');
  with Q('INSERT INTO TWEB_COMPETITOR_SCANS (SCANID, SITEID, CATID, STARTED) VALUES (:SCANID, :SITEID, :CATID, CURRENT_TIMESTAMP)') do
  begin
    ParamByName('SCANID').AsInteger := Result;
    ParamByName('SITEID').AsInteger := ASiteID;
    ParamByName('CATID').AsInteger := ACatID;
    ExecSQL;
  end;
  Commit;
end;

procedure TPWDb.ScanFinish(AScanID, APages, AFound, ANew, AChanges, AStatus: Integer; const AError: string);
begin
  with Q('UPDATE TWEB_COMPETITOR_SCANS SET FINISHED = CURRENT_TIMESTAMP, PAGES = :PAGES, ITEMS_FOUND = :FOUND, ' +
         'ITEMS_NEW = :NEW_CNT, PRICE_CHANGES = :CHANGES, STATUS = :STATUS, ERROR_TEXT = :ERR WHERE SCANID = :SCANID') do
  begin
    ParamByName('PAGES').AsInteger := APages;
    ParamByName('FOUND').AsInteger := AFound;
    ParamByName('NEW_CNT').AsInteger := ANew;
    ParamByName('CHANGES').AsInteger := AChanges;
    ParamByName('STATUS').AsInteger := AStatus;
    if AError = '' then
      ParamByName('ERR').Clear
    else
      ParamByName('ERR').AsString := Copy(AError, 1, 1024);
    ParamByName('SCANID').AsInteger := AScanID;
    ExecSQL;
  end;
  Commit;
end;

procedure TPWDb.CatUrlStatus(ACatUrlID, AItems: Integer; const AError: string);
begin
  with Q('UPDATE TWEB_COMPETITOR_CAT_URLS SET LAST_SCAN = CURRENT_TIMESTAMP, LAST_ITEMS = :ITEMS, LAST_ERROR = :ERR WHERE CATURLID = :ID') do
  begin
    ParamByName('ITEMS').AsInteger := AItems;
    if AError = '' then
      ParamByName('ERR').Clear
    else
      ParamByName('ERR').AsString := Copy(AError, 1, 1000);
    ParamByName('ID').AsInteger := ACatUrlID;
    ExecSQL;
  end;
  Commit;
end;

procedure TPWDb.SiteStatus(ASiteID: Integer; const AStatus: string; AFailCount: Integer; ABlockedUntil: TDateTime);
begin
  with Q('UPDATE TWEB_COMPETITOR_SITES SET LAST_RUN = CURRENT_TIMESTAMP, LAST_STATUS = :ST, FAIL_COUNT = :FC, BLOCKED_UNTIL = :BU WHERE SITEID = :ID') do
  begin
    ParamByName('ST').AsString := Copy(AStatus, 1, 255);
    ParamByName('FC').AsInteger := AFailCount;
    if ABlockedUntil > 0 then
      ParamByName('BU').AsDateTime := ABlockedUntil
    else
      ParamByName('BU').Clear;
    ParamByName('ID').AsInteger := ASiteID;
    ExecSQL;
  end;
  Commit;
end;

function TPWDb.ReportLog(const AFileName: string; AItems, AMatched, AChanges: Integer; ASent: Boolean;
  const AError: string): Integer;
begin
  Result := NextID('SQ_TWEB_COMPETITOR_REPORTS');
  with Q('INSERT INTO TWEB_COMPETITOR_REPORTS (REPORTID, CREATED, FILE_NAME, ITEMS, MATCHED, CHANGES, FLG_SENT, ERROR_TEXT) ' +
         'VALUES (:ID, CURRENT_TIMESTAMP, :FN, :ITEMS, :MATCHED, :CHANGES, :SENT, :ERR)') do
  begin
    ParamByName('ID').AsInteger := Result;
    ParamByName('FN').AsString := Copy(AFileName, 1, 1000);
    ParamByName('ITEMS').AsInteger := AItems;
    ParamByName('MATCHED').AsInteger := AMatched;
    ParamByName('CHANGES').AsInteger := AChanges;
    ParamByName('SENT').AsInteger := Ord(ASent);
    if AError = '' then
      ParamByName('ERR').Clear
    else
      ParamByName('ERR').AsString := Copy(AError, 1, 1024);
    ExecSQL;
  end;
  Commit;
end;

procedure TPWDb.TelegramTarget(const AChannel: string; out AToken, AChatID: string; out AThreadID: Integer);
var
  DefaultChat: string;
begin
  AToken := '';
  AChatID := '';
  DefaultChat := '';
  AThreadID := 0;
  with Q('SELECT UPPER(TRIM(PARAM_NAME)) AS PARAM_NAME, TRIM(PARAM_VALUE) AS PARAM_VALUE ' +
         'FROM TS_API_CONFIG WHERE API_CODE = ''TELEGRAM'' AND COALESCE(FLG_ACTIVE, 1) = 1') do
  begin
    Open;
    while not Eof do
    begin
      if FieldByName('PARAM_NAME').AsString = 'BOT_TOKEN' then
        AToken := FieldByName('PARAM_VALUE').AsString
      else if FieldByName('PARAM_NAME').AsString = 'DEFAULT_CHAT_ID' then
        DefaultChat := FieldByName('PARAM_VALUE').AsString;
      Next;
    end;
    Close;
  end;
  with Q('SELECT CHAT_ID, THREAD_ID FROM TELEGRAM_CHANNELS WHERE CHANNEL_CODE = :CODE AND FLG_ACTIVE = 1') do
  begin
    ParamByName('CODE').AsString := UpperCase(Trim(AChannel));
    Open;
    if not Eof then
    begin
      AChatID := Trim(FieldByName('CHAT_ID').AsString);
      AThreadID := FieldByName('THREAD_ID').AsInteger;
    end;
    Close;
  end;
  if AChatID = '' then
    AChatID := DefaultChat;
  Commit;
end;

procedure TPWDb.TelegramQueueText(const AChannel, AText: string);
begin
  // SOURCE_TABLE -40 = WMSPriceWatch (vezi antetul telegram_messages.sql)
  with Q('EXECUTE PROCEDURE SP_TELEGRAM_SEND(:CH, :TXT, ''HTML'', -40, NULL, 0)') do
  begin
    ParamByName('CH').AsString := UpperCase(Trim(AChannel));
    ParamByName('TXT').AsString := Copy(AText, 1, 4096);
    ExecSQL;
  end;
  Commit;
end;

end.

unit PWTypes;

{ WMSPriceWatch - tipurile comune: site-urile concurentilor, categoriile, produsele
  gasite pe site, produsele noastre, configurarea (TS_API_CONFIG / COMPETITORS). }

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TPWLogEvent = reference to procedure(const AMessage: string);

  // TWEB_COMPETITOR_SITES
  TPWSite = record
    SiteID: Integer;
    SiteCode: string;
    Title: string;
    BaseUrl: string;
    Active: Boolean;
    DelayMinMs: Integer;
    DelayMaxMs: Integer;
    PageUrlTpl: string;      // '{url}?page={page}'; '' = o singura pagina
    FirstPage: Integer;
    MaxPages: Integer;
    ProxyUrl: string;        // '' = proxy-ul global / direct
    UserAgent: string;       // '' = rotatie
    ItemRegex: string;
    NameRegex: string;
    UrlRegex: string;
    PriceRegex: string;
    OldPriceRegex: string;
    CodeRegex: string;
    StockRegex: string;
    NoStockWords: string;    // separate prin ';'
    BlockRegex: string;
    BlockedUntil: TDateTime;
    FailCount: Integer;
  end;

  // TWEB_COMPETITOR_CATEGORIES
  TPWCategory = record
    CatID: Integer;
    CatalogID: Integer;      // TWEB_CATALOG
    Title: string;
    Active: Boolean;
    MinScore: Double;        // 0 = cel global
  end;

  // TWEB_COMPETITOR_CAT_URLS
  TPWCatUrl = record
    CatUrlID: Integer;
    SiteID: Integer;
    CatID: Integer;
    Url: string;
    Active: Boolean;
  end;

  // un produs de pe pagina unui concurent
  TPWSiteItem = record
    Url: string;
    SiteCode: string;        // codul produsului pe site (daca exista)
    Title: string;
    Price: Double;
    OldPrice: Double;
    InStock: Boolean;
    StockText: string;
  end;

  // produsul nostru (SP_COMPETITOR_OUR_GOODS)
  TPWOurGoods = record
    GoodsID: Integer;
    Code: string;
    Title: string;
    Vendor: string;
    Price1: Double;
    Discount: Double;
    OurPrice: Double;
  end;

  // TS_API_CONFIG, API_CODE = 'COMPETITORS'
  TPWConfig = record
    ReportIntervalMin: Integer;  // implicit 180
    CyclePauseMin: Integer;      // implicit 30
    TelegramChannel: string;     // implicit PRICELISTS
    ProxyUrl: string;
    MinScore: Double;            // implicit 2.5
    ReportDir: string;
    class function Defaults: TPWConfig; static;
  end;

  // parametrii conexiunii (fiecare fir isi deschide conexiunea lui)
  TPWConnParams = record
    Server: string;
    Port: Integer;
    Database: string;
    User: string;
    Password: string;
    UserID: Integer;       // utilizatorul WMS autentificat (0 = tehnic, /auto)
    UserName: string;
  end;

  // starea curenta a monitorului (pentru fereastra)
  TPWMonitorState = record
    Running: Boolean;
    CurrentSite: string;
    CurrentCategory: string;
    CurrentPage: Integer;
    CycleNo: Integer;
    LastCycleStart: TDateTime;
    LastCycleEnd: TDateTime;
    LastReport: TDateTime;
    NextReport: TDateTime;
    Requests: Integer;
    Errors: Integer;
  end;

const
  cPWAppTitle = 'WMS PriceWatch - monitorizarea preturilor concurentilor';
  cPWApiCode = 'COMPETITORS';
  // MATCH_TYPE
  cPWMatchNone = 0;
  cPWMatchAuto = 1;
  cPWMatchManual = 2;
  cPWMatchRejected = 3;   // asociere respinsa manual: nu se mai face automat

function PWParseDouble(const S: string): Double;

implementation

{ TPWConfig }

class function TPWConfig.Defaults: TPWConfig;
begin
  Result := Default(TPWConfig);
  Result.ReportIntervalMin := 180;
  Result.CyclePauseMin := 30;
  Result.TelegramChannel := 'PRICELISTS';
  Result.MinScore := 2.5;
end;

// "6 399", "6,399.00", "3660.0000", "4 356 lei", "1.299" -> 6399 / 6399 / 3660 / 4356 / 1299
function PWParseDouble(const S: string): Double;
var
  Clean, IntPart, FracPart: string;
  I, LastSep, Digits: Integer;
begin
  Clean := '';
  for I := 1 to Length(S) do
    if CharInSet(S[I], ['0'..'9', '.', ',']) then
      Clean := Clean + S[I];
  if Clean = '' then
    Exit(0);

  LastSep := 0;
  for I := Length(Clean) downto 1 do
    if CharInSet(Clean[I], ['.', ',']) then
    begin
      LastSep := I;
      Break;
    end;

  if LastSep = 0 then
    Exit(StrToFloatDef(Clean, 0, TFormatSettings.Invariant));

  Digits := Length(Clean) - LastSep;
  // exact 3 cifre dupa ultimul separator = separator de mii ("1.299", "6,399");
  // 1-2 cifre sau 4+ ("3660.0000") = partea decimala
  if Digits = 3 then
  begin
    IntPart := Clean;
    FracPart := '';
  end
  else
  begin
    IntPart := Copy(Clean, 1, LastSep - 1);
    FracPart := Copy(Clean, LastSep + 1, MaxInt);
  end;
  IntPart := StringReplace(StringReplace(IntPart, '.', '', [rfReplaceAll]), ',', '', [rfReplaceAll]);
  if FracPart <> '' then
    IntPart := IntPart + '.' + FracPart;
  Result := StrToFloatDef(IntPart, 0, TFormatSettings.Invariant);
end;

end.

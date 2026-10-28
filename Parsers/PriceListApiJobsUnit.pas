unit PriceListApiJobsUnit;

{ WMSParsers - importurile de pricelist prin API-urile furnizorilor (aceleasi ca butonul API din
  WMS, frame78PriceListUnit.bbAPISupplierClick), fara interfata:

    accent-pricelist    Accent Electronic   198     ApiAccentUnit (b2brestful.accent.md)
    dmlink-pricelist    DMLink              229466  B2B.DMLinkPriceListImport (b2b.dmlink.md)
    olisgrup-pricelist  Olis Grup           251465  OlisGrupPriceListUnit (price.muncitorul.md)
    nex-pricelist       NexDistribution     275640  NexDistributionUnit (api.nexdistribution.md)
    triomac-pricelist   Triomac (SCOP)      209280  TriomacPriceListUnit (scop.md/api/partner/v2)

  Fiecare job, in firul lui (ParserRunnerUnit.RunParserJobsParallel), cu conexiunea lui:
    1. pricelistul nou, in categoria ultimului pricelist al furnizorului;
    2. cele 4 reevaluari (PriceListReevaluationUnit), daca nu e /reevaluare:no;
    3. DMLink / Nex / Olis Grup / Triomac: imaginile nedescarcate, in fire (daca nu e /images:no) - la final, fiindca
       dureaza cel mai mult si reevaluarile nu depind de ele. }

interface

uses
  System.SysUtils, IBC, ParserJobUnit;

type
  TPriceListApiJob = class(TParserJob)
  protected
    class function SupplierID: Integer; virtual; abstract;
    class function SupplierName: string; virtual; abstract;
    // categoria folosita cind furnizorul nu are inca niciun pricelist cu categorie
    class function DefaultCategoryID: Integer; virtual; abstract;
    // creeaza pricelistul si intoarce PLID-ul
    function ImportPriceList(ACategoryID: Integer): Integer; virtual; abstract;
    // dupa reevaluari (imaginile); implicit nimic
    procedure AfterReevaluation(APLID: Integer); virtual;
    function IsCancelled: Boolean;
    function PriceListItemCount(APLID: Integer): Integer;
  public
    class function JobName: string; override;
    class function DisplayName: string; override;
    class function NotifyName: string; override;
    class function IsPriceJob: Boolean; override;
    function Run: TParserJobResult; override;
  end;

  TAccentPriceListJob = class(TPriceListApiJob)
  protected
    class function SupplierID: Integer; override;
    class function SupplierName: string; override;
    class function DefaultCategoryID: Integer; override;
    function ImportPriceList(ACategoryID: Integer): Integer; override;
  public
    class function JobName: string; override;
  end;

  TDMLinkPriceListJob = class(TPriceListApiJob)
  protected
    class function SupplierID: Integer; override;
    class function SupplierName: string; override;
    class function DefaultCategoryID: Integer; override;
    function ImportPriceList(ACategoryID: Integer): Integer; override;
    procedure AfterReevaluation(APLID: Integer); override;
  public
    class function JobName: string; override;
  end;

  TOlisGrupPriceListJob = class(TPriceListApiJob)
  protected
    class function SupplierID: Integer; override;
    class function SupplierName: string; override;
    class function DefaultCategoryID: Integer; override;
    function ImportPriceList(ACategoryID: Integer): Integer; override;
    procedure AfterReevaluation(APLID: Integer); override;
  public
    class function JobName: string; override;
  end;

  TNexPriceListJob = class(TPriceListApiJob)
  private
    FPLID: Integer;
  protected
    class function SupplierID: Integer; override;
    class function SupplierName: string; override;
    class function DefaultCategoryID: Integer; override;
    function ImportPriceList(ACategoryID: Integer): Integer; override;
    procedure AfterReevaluation(APLID: Integer); override;
  public
    class function JobName: string; override;
  end;

  TTriomacPriceListJob = class(TPriceListApiJob)
  protected
    class function SupplierID: Integer; override;
    class function SupplierName: string; override;
    class function DefaultCategoryID: Integer; override;
    function ImportPriceList(ACategoryID: Integer): Integer; override;
    procedure AfterReevaluation(APLID: Integer); override;
  public
    class function JobName: string; override;
  end;

implementation

uses
  System.Classes, System.Diagnostics, Data.DB, IBCClasses, ApiAccentUnit, B2B.DMLinkPriceListImport,
  OlisGrupPriceListUnit, NexDistributionUnit, TriomacPriceListUnit, PriceListReevaluationUnit,
  PriceListContentTransferUnit;

const
  // imaginile vin de pe serverele furnizorilor; 12 fire, fiecare descarca + converteste + scrie
  cImageThreads = 12;

{ TPriceListApiJob }

class function TPriceListApiJob.JobName: string;
begin
  Result := 'pricelist';
end;

class function TPriceListApiJob.DisplayName: string;
begin
  Result := Format('Pricelist API %s  -  furnizor %d (+ reevaluari)', [SupplierName, SupplierID]);
end;

class function TPriceListApiJob.NotifyName: string;
begin
  Result := Format('%s (%d)', [SupplierName, SupplierID]);
end;

class function TPriceListApiJob.IsPriceJob: Boolean;
begin
  Result := True;
end;

procedure TPriceListApiJob.AfterReevaluation(APLID: Integer);
begin
end;

// pentru rezumat (jurnal + Telegram); o eroare aici nu strica importul
function TPriceListApiJob.PriceListItemCount(APLID: Integer): Integer;
var
  Q: TIBCQuery;
begin
  Result := -1;
  Q := TIBCQuery.Create(nil);
  try
    try
      Q.Connection := FConnection;
      Q.SQL.Text := 'select count(*) from TS_PRICELIST_ITEMS where PLID = :PLID';
      Q.ParamByName('PLID').AsInteger := APLID;
      Q.Open;
      Result := Q.Fields[0].AsInteger;
      Q.Close;
      if FConnection.InTransaction then
        FConnection.Commit;
    except
      on E: Exception do
        Log('Numarul de pozitii nu s-a putut citi: ' + E.Message);
    end;
  finally
    Q.Free;
  end;
end;

function TPriceListApiJob.IsCancelled: Boolean;
begin
  Result := FCancelled;
end;

function TPriceListApiJob.Run: TParserJobResult;
var
  Q: TIBCQuery;
  CategoryID, PLID: Integer;
  Summary: TReevaluationSummary;
  Watch: TStopwatch;
  ImportMs: Int64;
begin
  Result := Default(TParserJobResult);
  Watch := TStopwatch.StartNew;

  // utilizatorul WMS in numele caruia se scrie (TS_PRICELISTS.CREATED_BY) + categoria
  CategoryID := DefaultCategoryID;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'select rdb$set_context(''USER_SESSION'', ''UserID'', :USERID) from rdb$database';
    Q.ParamByName('USERID').AsInteger := FOptions.UserID;
    Q.Open;
    Q.Close;
    Q.SQL.Text := 'select first 1 PRICE_CATEGORYID from TS_PRICELISTS ' +
      'where SUPPLIERID = :SUPPLIERID and PRICE_CATEGORYID > 0 order by PLID desc';
    Q.ParamByName('SUPPLIERID').AsInteger := SupplierID;
    Q.Open;
    if not Q.IsEmpty then
      CategoryID := Q.Fields[0].AsInteger;
    Q.Close;
    if FConnection.InTransaction then
      FConnection.Commit;
  finally
    Q.Free;
  end;

  Log('Import %s, categoria de pret %d...', [SupplierName, CategoryID]);
  PLID := ImportPriceList(CategoryID);
  ImportMs := Watch.ElapsedMilliseconds;
  Log('Pricelist %d creat in %.1f s.', [PLID, ImportMs / 1000]);
  Result.Summary := Format('pricelist %d (%d pozitii)', [PLID, PriceListItemCount(PLID)]);

  if FOptions.Reevaluation and not FCancelled then
  begin
    Summary := CreatePriceListReevaluations(FConnection, PLID, FOptions.FirmaID, FOptions.UserID,
      procedure(S: string)
      begin
        Log(S);
      end,
      IsCancelled, FOptions.ReevaluationTest);
    Result.Summary := Result.Summary + '; reevaluari ' + Summary.Text;
    if FOptions.ReevaluationTest then
      Result.Summary := Result.Summary + ' (TEST, anulate)';
  end;

  if FOptions.Images and not FCancelled then
    AfterReevaluation(PLID);
  Result.Summary := Result.Summary + Format('; total %.1f s', [Watch.ElapsedMilliseconds / 1000]);
end;

{ Accent }

class function TAccentPriceListJob.JobName: string;
begin
  Result := 'accent-pricelist';
end;

class function TAccentPriceListJob.SupplierID: Integer;
begin
  Result := 198;
end;

class function TAccentPriceListJob.SupplierName: string;
begin
  Result := 'Accent Electronic';
end;

class function TAccentPriceListJob.DefaultCategoryID: Integer;
begin
  Result := 5;
end;

function TAccentPriceListJob.ImportPriceList(ACategoryID: Integer): Integer;
var
  Q: TIBCQuery;
  RateUsd: Currency;
  Api: TApiAccent;
begin
  // ca dmDB.GetCurrencyExchangeValue(840, True): TRANSFER_RATE (folosit doar la marjele afisate)
  RateUsd := 1;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := FConnection;
    Q.SQL.Text := 'select TRANSFER_RATE from TS_CURRENCY where CURRENCYID = 840';
    Q.Open;
    if not Q.IsEmpty and (Q.Fields[0].AsCurrency > 0) then
      RateUsd := Q.Fields[0].AsCurrency;
    Q.Close;
  finally
    Q.Free;
  end;

  Api := TApiAccent.Create(FConnection, RateUsd, False);
  try
    if not Api.Connect then
      raise Exception.Create('Autentificare esuata la API-ul Accent.');
    Api.GetJSONProducts;
    Api.ParseJSON;
    Result := Api.GeneratePriceList(ACategoryID);
    Log('Accent: %d produse cu stoc in pricelist.', [Api.ItemsInserted]);
  finally
    Api.Free;
  end;
end;

{ DMLink }

class function TDMLinkPriceListJob.JobName: string;
begin
  Result := 'dmlink-pricelist';
end;

class function TDMLinkPriceListJob.SupplierID: Integer;
begin
  Result := cDMLinkSupplierID;
end;

class function TDMLinkPriceListJob.SupplierName: string;
begin
  Result := 'DMLink';
end;

class function TDMLinkPriceListJob.DefaultCategoryID: Integer;
begin
  Result := 10;
end;

function TDMLinkPriceListJob.ImportPriceList(ACategoryID: Integer): Integer;
var
  Importer: TDMLinkPriceListImport;
  R: TDMLinkImportResult;
  LastStage: string;
begin
  Importer := TDMLinkPriceListImport.Create(FConnection, cDMLinkSupplierID, ACategoryID);
  try
    LastStage := '';
    // doar schimbarile de etapa (progresul "salvare N / M" ar umple jurnalul)
    Importer.OnProgress :=
      procedure(AText: string)
      var
        Stage: string;
      begin
        Stage := AText;
        if Pos('...', Stage) > 0 then
          Stage := Copy(Stage, 1, Pos('...', Stage) + 2);
        if Pos('salvare', Stage) > 0 then
          Stage := 'salvare';
        if Stage <> LastStage then
        begin
          LastStage := Stage;
          Log(AText);
        end;
      end;
    R := Importer.Execute;
  finally
    Importer.Free;
  end;
  Log('DMLink: %d produse, %d descrieri, %d cu imagini (%d liste noi/schimbate); descarcare %.1f s, ' +
    'parsare %.1f s (%d fire), salvare %.1f s (%d fire); sarite: %d fara stoc, %d fara sku, %d sku repetat',
    [R.ProductsImported, R.Descriptions, R.ProductsWithImages, R.ImagesChanged, R.DownloadMs / 1000,
     R.ParseMs / 1000, R.ParseThreads, R.SaveMs / 1000, R.DbThreads, R.OutOfStockProducts, R.InvalidProducts,
     R.DuplicateProducts]);
  if R.DuplicateCodes <> '' then
    Log('DMLink: coduri repetate - ' + R.DuplicateCodes);
  Result := R.PLID;
end;

procedure TDMLinkPriceListJob.AfterReevaluation(APLID: Integer);
var
  Stats: TContentTransferStats;
begin
  TDMLinkPriceListImport.DownloadImagesSilent(FConnection, APLID,
    procedure(S: string)
    begin
      Log(S);
    end,
    IsCancelled, cDMLinkSupplierID, cImageThreads);
  if IsCancelled then
    Exit;
  // imaginile si descrierile ajung la produsele legate care nu au deja (nu se suprascrie nimic)
  Stats := TPriceListContentTransfer.Execute(FConnection, cDMLinkSupplierID, APLID);
  Log('DMLink: copiat la produse - %d produse cu imagini noi (%d imagini), %d descrieri (%d perechi produs-cod)',
    [Stats.GoodsImages, Stats.Images, Stats.Descriptions, Stats.Pairs]);
end;

{ Olis Grup }

class function TOlisGrupPriceListJob.JobName: string;
begin
  Result := 'olisgrup-pricelist';
end;

class function TOlisGrupPriceListJob.SupplierID: Integer;
begin
  Result := cOlisGrupSupplierID;
end;

class function TOlisGrupPriceListJob.SupplierName: string;
begin
  Result := 'Olis Grup';
end;

class function TOlisGrupPriceListJob.DefaultCategoryID: Integer;
begin
  Result := 17;
end;

function TOlisGrupPriceListJob.ImportPriceList(ACategoryID: Integer): Integer;
begin
  Result := TOlisGrupPriceListImport.Import(FConnection, ACategoryID,
    procedure(S: string)
    begin
      Log(S);
    end);
end;

procedure TOlisGrupPriceListJob.AfterReevaluation(APLID: Integer);
var
  Stats: TContentTransferStats;
begin
  // URL-urile si descrierile le-a salvat importul (OlisGrupContentUnit); aici, ca la DMLink,
  // descarcarea imaginilor si copierea la produsele legate
  TDMLinkPriceListImport.DownloadImagesSilent(FConnection, APLID,
    procedure(S: string)
    begin
      Log(S);
    end,
    IsCancelled, cOlisGrupSupplierID, cImageThreads);
  if IsCancelled then
    Exit;
  Stats := TPriceListContentTransfer.Execute(FConnection, cOlisGrupSupplierID, APLID);
  Log('Olis Grup: copiat la produse - %d produse cu imagini noi (%d imagini), %d descrieri (%d perechi produs-cod)',
    [Stats.GoodsImages, Stats.Images, Stats.Descriptions, Stats.Pairs]);
end;

{ NexDistribution }

class function TNexPriceListJob.JobName: string;
begin
  Result := 'nex-pricelist';
end;

class function TNexPriceListJob.SupplierID: Integer;
begin
  Result := cNexSupplierID;
end;

class function TNexPriceListJob.SupplierName: string;
begin
  Result := 'NexDistribution';
end;

class function TNexPriceListJob.DefaultCategoryID: Integer;
begin
  Result := 178;
end;

function TNexPriceListJob.ImportPriceList(ACategoryID: Integer): Integer;
begin
  // imaginile Nex se iau din raspunsul API-ului, deci se descarca odata cu importul; reevaluarile
  // nu depind de ele. Cu /images:no se sare descarcarea.
  Result := TNexPriceListImport.Import(FConnection, ACategoryID, FOptions.Images,
    procedure(S: string)
    begin
      Log(S);
    end,
    IsCancelled, cImageThreads);
  FPLID := Result;
end;

procedure TNexPriceListJob.AfterReevaluation(APLID: Integer);
begin
  // imaginile s-au descarcat in ImportPriceList
end;

{ Triomac }

class function TTriomacPriceListJob.JobName: string;
begin
  Result := 'triomac-pricelist';
end;

class function TTriomacPriceListJob.SupplierID: Integer;
begin
  Result := cTriomacSupplierID;
end;

class function TTriomacPriceListJob.SupplierName: string;
begin
  Result := 'Triomac (SCOP)';
end;

class function TTriomacPriceListJob.DefaultCategoryID: Integer;
begin
  Result := 26;
end;

function TTriomacPriceListJob.ImportPriceList(ACategoryID: Integer): Integer;
begin
  Result := TTriomacPriceListImport.Import(FConnection, ACategoryID,
    procedure(S: string)
    begin
      Log(S);
    end);
end;

procedure TTriomacPriceListJob.AfterReevaluation(APLID: Integer);
var
  Stats: TContentTransferStats;
begin
  // URL-urile (scop.md/media) si descrierile le-a salvat importul; aici, ca la Olis Grup,
  // descarcarea imaginilor si copierea la produsele legate
  TDMLinkPriceListImport.DownloadImagesSilent(FConnection, APLID,
    procedure(S: string)
    begin
      Log(S);
    end,
    IsCancelled, cTriomacSupplierID, cImageThreads);
  if IsCancelled then
    Exit;
  Stats := TPriceListContentTransfer.Execute(FConnection, cTriomacSupplierID, APLID);
  Log('Triomac: copiat la produse - %d produse cu imagini noi (%d imagini), %d descrieri (%d perechi produs-cod)',
    [Stats.GoodsImages, Stats.Images, Stats.Descriptions, Stats.Pairs]);
end;

end.

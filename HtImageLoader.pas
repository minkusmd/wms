unit HtImageLoader;

{ Completează imaginile lipsă din TS_GOODS_IMAGE pentru produsele unui furnizor,
  luând pozele de pe h-t.md (THtScraper) și salvându-le ca PNG în Firebird.

  Conectarea se face cu IBDAC (Devart). IBDAC folosește biblioteca client
  Firebird (fbclient.dll) de aceeași arhitectură ca aplicația; se poate indica
  explicit prin TLoaderSettings.ClientLibrary. }

interface

uses
  System.SysUtils, System.Classes, IBC, HtScraper;

type
  TLogProc = reference to procedure(const AMessage: string);

  TLoaderSettings = record
    Host: string;
    Database: string;        // cale sau alias de pe serverul Firebird
    User: string;
    Password: string;
    CharacterSet: string;    // gol = UTF8 (ca driverul Python)
    ClientLibrary: string;   // gol = fbclient.dll
    SupplierId: Integer;     // CUSTOMERID din TS_GOODS_FOREIGN
    RequestDelayMs: Integer; // pauză între produse, ca să nu încărcăm site-ul
  end;

  TLoaderStats = record
    Total: Integer;          // produse fără imagine găsite în bază
    Saved: Integer;
    NotFound: Integer;       // negăsite (sau fără poză) pe site
    Failed: Integer;         // erori de rețea / conversie / bază de date
  end;

  THtImageLoader = class
  private
    FSettings: TLoaderSettings;
    FScraper: THtScraper;
    FConnection: TIBCConnection;
    FInsert: TIBCSQL;
    FOnLog: TLogProc;
    procedure Log(const AMessage: string); overload;
    procedure Log(const AFormat: string; const AArgs: array of const); overload;
    procedure Connect;
    procedure SaveImage(AGoodsId: Int64; AImage: TStream);
  public
    constructor Create(const ASettings: TLoaderSettings);
    destructor Destroy; override;

    /// Procesează toate produsele fără imagine ale furnizorului.
    /// Erorile pe un produs sunt logate și nu opresc restul.
    function Run: TLoaderStats;

    property OnLog: TLogProc read FOnLog write FOnLog;
  end;

implementation

uses
  Data.DB;

const
  cSqlPending =
    'SELECT GF.GOODS_CODE, GF.GOODSID ' +
    'FROM TS_GOODS_FOREIGN GF ' +
    'WHERE GF.CUSTOMERID = :SUPPLIER AND GET_FLG_VALUE(GF.FLAGS, 3) = 1 ' +
    '  AND NOT EXISTS (SELECT 1 FROM TS_GOODS_IMAGE GI WHERE GI.GOODSID = GF.GOODSID) ' +
    'ORDER BY GF.GOODS_CODE';
  cSqlInsert =
    'INSERT INTO TS_GOODS_IMAGE (GOODSID, IMAGE) VALUES (:GOODSID, :IMAGE)';

type
  TPendingGoods = record
    Code: string;
    GoodsId: Int64;
  end;

{ THtImageLoader }

constructor THtImageLoader.Create(const ASettings: TLoaderSettings);
begin
  inherited Create;
  FSettings := ASettings;
  FScraper := THtScraper.Create;
end;

destructor THtImageLoader.Destroy;
begin
  FInsert.Free;
  FConnection.Free;
  FScraper.Free;
  inherited;
end;

procedure THtImageLoader.Log(const AMessage: string);
begin
  if Assigned(FOnLog) then
    FOnLog(AMessage);
end;

procedure THtImageLoader.Log(const AFormat: string; const AArgs: array of const);
begin
  Log(Format(AFormat, AArgs));
end;

procedure THtImageLoader.Connect;
begin
  FConnection := TIBCConnection.Create(nil);
  FConnection.LoginPrompt := False;
  if FSettings.ClientLibrary <> '' then
    FConnection.ClientLibrary := FSettings.ClientLibrary
  else
    FConnection.ClientLibrary := 'fbclient.dll';
  FConnection.Server := FSettings.Host;
  FConnection.Database := FSettings.Database;
  FConnection.Username := FSettings.User;
  FConnection.Password := FSettings.Password;
  if FSettings.CharacterSet <> '' then
    FConnection.Options.Charset := FSettings.CharacterSet
  else
    FConnection.Options.Charset := 'UTF8';
  FConnection.Options.UseUnicode := True;
  FConnection.Connect;

  FInsert := TIBCSQL.Create(nil);
  FInsert.Connection := FConnection;
  FInsert.SQL.Text := cSqlInsert;
end;

procedure THtImageLoader.SaveImage(AGoodsId: Int64; AImage: TStream);
begin
  AImage.Position := 0;
  FInsert.ParamByName('GOODSID').AsLargeInt := AGoodsId;
  FInsert.ParamByName('IMAGE').LoadFromStream(AImage, ftBlob);
  FInsert.Execute; // AutoCommit = True: fiecare INSERT se comite imediat
end;

function THtImageLoader.Run: TLoaderStats;
var
  Query: TIBCQuery;
  Pending: TArray<TPendingGoods>;
  Item: TPendingGoods;
  Product: TProductInfo;
  Png: TMemoryStream;
begin
  Result := Default(TLoaderStats);
  Connect;

  // Ca fetchall() din Python: se citește tot setul înainte de inserări,
  // ca să nu avem un SELECT deschis în paralel cu INSERT-urile.
  Query := TIBCQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := cSqlPending;
    Query.ParamByName('SUPPLIER').AsInteger := FSettings.SupplierId;
    Query.Open;
    while not Query.Eof do
    begin
      Item.Code := Query.FieldByName('GOODS_CODE').AsString.Trim;
      Item.GoodsId := Query.FieldByName('GOODSID').AsLargeInt;
      Pending := Pending + [Item];
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  Result.Total := Length(Pending);
  Log('Produse fără imagine: %d', [Result.Total]);

  Png := TMemoryStream.Create;
  try
    for Item in Pending do
    begin
      Log('');
      Log('Căutare: %s (ID: %d)', [Item.Code, Item.GoodsId]);
      try
        if FScraper.FindProduct(Item.Code, Product) then
        begin
          Png.Clear;
          FScraper.DownloadAsPng(Product.ImageUrl, Png);
          SaveImage(Item.GoodsId, Png);
          Inc(Result.Saved);
          Log('OK: imagine inserată pentru goodsid %d (%s, %s)',
            [Item.GoodsId, Product.Title, Product.Price]);
        end
        else
        begin
          Inc(Result.NotFound);
          Log('Nicio imagine găsită pentru: %s', [Item.Code]);
        end;
      except
        on E: Exception do
        begin
          Inc(Result.Failed);
          Log('Eroare procesare %s: %s', [Item.Code, E.Message]);
        end;
      end;
      if FSettings.RequestDelayMs > 0 then
        Sleep(FSettings.RequestDelayMs);
    end;
  finally
    Png.Free;
  end;
end;

end.

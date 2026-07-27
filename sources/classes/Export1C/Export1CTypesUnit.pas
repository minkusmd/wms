unit Export1CTypesUnit;

interface
Uses Classes;

type
  TExportCurrency = class
  public
    { public declarations }
    CurrencyID:integer;
    Title:String;
    ShortName:String;
  end;

  TExportSklad = class
  public
    { public declarations }
    StockID:integer;
    Title:String;
    StockType:String;
  end;

  TExportStavkaNDS = class
  public
    { public declarations }
    NDS:integer;
  end;


  TExportUM = class
  public
    { public declarations }
    UmID:integer;
    Title:String;
  end;


  // collections
  TExportCurrencyCollection=class
  private
    { Private declarations }
    fList:TList;
    procedure Clear;
    function getCount: integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;

    procedure Add(const CurrencyID:integer; const Title, ShortName:String);
    function GetCurrencyByID(const CurrencyID:integer):TExportCurrency;
  end;


  TExportSkladCollection = class
  private
    { Private declarations }
    fList:TList;
    procedure Clear;
    function getCount: integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;

    procedure Add(const StockID:integer; const Title:String);
    function GetStockByID(const StockID:integer):TExportSklad;
  end;


  TExportStavkaNDSCollection = class
  private
    { Private declarations }
    fList:TList;
    procedure Clear;
    function getCount: integer;
  public
    { public declarations }
    constructor Create;
    destructor Destroy;override;

    property Count:integer read getCount;

    procedure Add(const NDS:integer);
    function GetNDSByValue(const NDS:integer):TExportStavkaNDS;
  end;

implementation

{ TExportCurrencyCollection }

procedure TExportCurrencyCollection.Add(const CurrencyID: integer; const Title, ShortName: String);
var item:TExportCurrency;
begin
     item:=TExportCurrency.Create;
     item.CurrencyID:=CurrencyID;
     item.Title:=Title;
     item.ShortName:=ShortName;
     fList.Add(item);
end;

procedure TExportCurrencyCollection.Clear;
var i:integer;
begin
     for i := 0 to fList.Count-1 do TExportCurrency(fList[i]).Free;
     fList.Clear;
end;

constructor TExportCurrencyCollection.Create;
begin
     fList:=TList.Create;
end;

destructor TExportCurrencyCollection.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TExportCurrencyCollection.getCount: integer;
begin
     Result:=fList.Count;
end;

function TExportCurrencyCollection.GetCurrencyByID(const CurrencyID: integer): TExportCurrency;
var i:integer;
    item:TExportCurrency;
begin
     Result:=nil;
     for i := 0 to fList.Count-1 do
     begin
          item:=TExportCurrency(fList[i]);
          if (item.CurrencyID=CurrencyID) then
          begin
               Result:=item;
               break;
          end;
     end;
end;

{ TExportSkladCollection }

procedure TExportSkladCollection.Add(const StockID: integer; const Title: String);
var item:TExportSklad;
begin
     item:=TExportSklad.Create;
     item.StockID:=StockID;
     item.Title:=Title;
     fList.Add(item);
end;

procedure TExportSkladCollection.Clear;
var i:integer;
begin
     for i := 0 to fList.Count-1 do TExportSklad(fList[i]).Free;
     fList.Clear;
end;

constructor TExportSkladCollection.Create;
begin
     fList:=TList.Create;
end;

destructor TExportSkladCollection.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TExportSkladCollection.getCount: integer;
begin
     Result:=fList.Count;
end;

function TExportSkladCollection.GetStockByID(const StockID: integer): TExportSklad;
var i:integer;
    item:TExportSklad;
begin
     Result:=nil;
     for i := 0 to fList.Count-1 do
     begin
          item:=TExportSklad(fList[i]);
          if (item.StockID=StockID) then
          begin
               Result:=item;
               break;
          end;
     end;
end;

{ TExportStavkaNDSCollection }

procedure TExportStavkaNDSCollection.Add(const NDS: integer);
var item:TExportStavkaNDS;
begin
     item:=TExportStavkaNDS.Create;
     item.NDS:=NDS;
     fList.Add(item);
end;

procedure TExportStavkaNDSCollection.Clear;
var i:integer;
begin
     for i := 0 to fList.Count-1 do TExportStavkaNDS(fList[i]).Free;
     fList.Clear;
end;

constructor TExportStavkaNDSCollection.Create;
begin
     fList:=TList.Create
end;

destructor TExportStavkaNDSCollection.Destroy;
begin
     Clear;
     fList.Free;
     inherited;
end;

function TExportStavkaNDSCollection.getCount: integer;
begin
     Result:=fList.Count;
end;

function TExportStavkaNDSCollection.GetNDSByValue(const NDS: integer): TExportStavkaNDS;
var i:integer;
    item:TExportStavkaNDS;
begin
     Result:=nil;
     for i := 0 to fList.Count-1 do
     begin
          item:=TExportStavkaNDS(fList[i]);
          if (item.NDS=NDS) then
          begin
               Result:=item;
               break;
          end;
     end;
end;

end.

unit HiTechPriceSourceUnit;

{ Sursa de pret pentru Hi-Tech Moldova (h-t.md), furnizorul 262735.
  Cautarea propriu-zisa o face THiTechScraper.FindPrice (HiTechScraperUnit): pagina HTML a
  site-ului, cu verificarea ca SKU-ul de pe pagina este identic cu codul cautat. }

interface

uses
  System.SysUtils, SupplierPriceSyncUnit, HiTechScraperUnit;

type
  THiTechPriceSource = class(TSupplierPriceSource)
  private
    FScraper: THiTechScraper;
  public
    class function ParserName: string; override;
    class function DisplayName: string; override;
    class function SupplierID: Integer; override;
    constructor Create; override;
    destructor Destroy; override;
    function FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean; override;
  end;

implementation

class function THiTechPriceSource.ParserName: string;
begin
  Result := 'hitech';
end;

class function THiTechPriceSource.DisplayName: string;
begin
  Result := 'Hi-Tech (h-t.md)';
end;

class function THiTechPriceSource.SupplierID: Integer;
begin
  Result := 262735;
end;

constructor THiTechPriceSource.Create;
begin
  inherited;
  FScraper := THiTechScraper.Create;
end;

destructor THiTechPriceSource.Destroy;
begin
  FScraper.Free;
  inherited;
end;

function THiTechPriceSource.FindPrice(const ACode: string; out APrice: Currency; out ATitle: string): Boolean;
begin
  Result := FScraper.FindPrice(ACode, APrice, ATitle);
end;

end.

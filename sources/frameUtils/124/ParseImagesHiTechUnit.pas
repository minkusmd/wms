unit ParseImagesHiTechUnit;

{ Descarca de pe h-t.md poza produsului si o salveaza ca PNG in TS_GOODS_IMAGE.
  Cautarea pe site o face THiTechScraper (HiTechScraperUnit). }

interface

uses
  System.Classes, IBC, HiTechScraperUnit;

type
  TParseHiTechProductImages = class
  private
    FScraper: THiTechScraper;
    FPng: TMemoryStream;
    IBCQueryGoodsImage: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
  public
    constructor Create(AConnection: TIBCConnection);
    destructor Destroy; override;

    // Cauta produsul pe site si, daca il gaseste, ii insereaza poza in baza.
    // False daca produsul nu a fost gasit sau nu are poza; erorile de retea,
    // de conversie sau de baza de date se ridica sub forma de exceptie.
    function LoadImage(AGoodsID: Integer; const ASupplierCode: string;
      out AProduct: TProductInfo): Boolean;

    // Ultima poza descarcata (PNG), pentru previzualizare. Nu se elibereaza.
    property LastImage: TMemoryStream read FPng;
  end;

implementation

uses
  Data.DB;

constructor TParseHiTechProductImages.Create(AConnection: TIBCConnection);
begin
  inherited Create;
  FScraper := THiTechScraper.Create;
  FPng := TMemoryStream.Create;

  IBCTrUpdate := TIBCTransaction.Create(nil);
  IBCTrUpdate.DefaultConnection := AConnection;

  IBCQueryGoodsImage := TIBCQuery.Create(nil);
  IBCQueryGoodsImage.Connection := AConnection;
  IBCQueryGoodsImage.Transaction := IBCTrUpdate;
  IBCQueryGoodsImage.SQL.Text := 'insert into ts_goods_image (goodsid, image)' +
    'values(:goodsid, :image)';
end;

destructor TParseHiTechProductImages.Destroy;
begin
  IBCQueryGoodsImage.Free;
  IBCTrUpdate.Free;
  FPng.Free;
  FScraper.Free;
  inherited;
end;

function TParseHiTechProductImages.LoadImage(AGoodsID: Integer;
  const ASupplierCode: string; out AProduct: TProductInfo): Boolean;
begin
  Result := FScraper.FindProduct(ASupplierCode, AProduct);
  if not Result then
    Exit;

  FPng.Clear;
  FScraper.DownloadAsPng(AProduct.ImageUrl, FPng);
  FPng.Position := 0;

  if not IBCTrUpdate.Active then
    IBCTrUpdate.StartTransaction;
  try
    IBCQueryGoodsImage.ParamByName('goodsid').AsInteger := AGoodsID;
    IBCQueryGoodsImage.ParamByName('image').LoadFromStream(FPng, ftBlob);
    IBCQueryGoodsImage.Execute;
    IBCTrUpdate.Commit;
  except
    if IBCTrUpdate.Active then
      IBCTrUpdate.Rollback;
    raise;
  end;
  FPng.Position := 0;
end;

end.

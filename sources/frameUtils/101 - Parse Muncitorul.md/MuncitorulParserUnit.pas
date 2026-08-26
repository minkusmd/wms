unit MuncitorulParserUnit;

interface

uses
  System.Classes,
  SHDocVw,
  MSHTML,
  ActiveX,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.SysUtils,
  System.Variants;

type
  TWebProduct = class
  public
    ProductCode: string;
    NameRo: string;
    NameRu: string;
    ProductPrice: string;
    DescriptionRo: string;
    DescriptionRu: string;
    ProductUrlRo: string;
    ProductUrlRu: string;
    ImageList: TStringList;

    constructor Create(AProductCode: string); reintroduce;
    destructor Destroy; override;
  end;

  TOnParseProduct = procedure(Product: TWebProduct) of object;

  TOnParseSearch = procedure(ProductUrlRo, ProductUrlRu: string) of object;

  TCustomParser = class
  private
    FDocumentProductPage: IHTMLDocument2;
    FDocumentBody: OleVariant;
    FOnParseProduct: TOnParseProduct;
    FOnParseSearch: TOnParseSearch;
    htmlSource: TStringList;
    FPageURL: string;
    FProductCode: string;
    ImagePathList: TStringList;
    Product: TWebProduct;
    procedure SetOnParseSearch(const Value: TOnParseSearch);
    procedure PrepareData(APageURL: string);

  protected
    procedure LoadWebPage;
    procedure LoadDOM;
    procedure ParseProduct(Product: TWebProduct); dynamic;

  public
    constructor Create(APageURL: string); reintroduce;
    destructor Destroy; override;
    procedure ParseDetailPage; virtual; abstract;
    procedure ParseSearchResult(var ProductUrlRo, ProductUrlRu: string); virtual; abstract;
    property ProductCode: string read FProductCode write FProductCode;
    property OnParseSearch: TOnParseSearch read FOnParseSearch write SetOnParseSearch;
    property OnParseProduct: TOnParseProduct read FOnParseProduct write FOnParseProduct;
  end;

  {---------------------------------------------------------------------------------------}
  TMuncitorulParser = class(TCustomParser)
  public
    procedure ParseDetailPage; override;
    procedure ParseSearchResult(var ProductUrlRo, ProductUrlRu: string); override;
  end;


  // lumeainstrumentelor.md parser
  TLumeaInstrumentelorParser = class(TCustomParser)
  public
    procedure ParseDetailPage; override;
    procedure ParseSearchResult(var ProductUrlRo, ProductUrlRu: string); override;
  end;

implementation

uses
  Vcl.Dialogs;

{ TWebProduct }

constructor TWebProduct.Create(AProductCode: string);
begin
  ProductCode := AProductCode;
  ImageList := TStringList.Create;
end;

destructor TWebProduct.Destroy;
begin
  if Assigned(ImageList) then
    ImageList.Free;
  inherited;
end;

{ TCustomParser }

constructor TCustomParser.Create(APageURL: string);
begin
  PrepareData(APageURL);
end;

destructor TCustomParser.Destroy;
begin
  if Assigned(htmlSource) then
    htmlSource.Free;
  if Assigned(ImagePathList) then
    ImagePathList.Free;
  inherited;
end;

procedure TCustomParser.PrepareData(APageURL: string);
begin
  FPageURL := APageURL;
  htmlSource := TStringList.Create;
  ImagePathList := TStringList.Create;
  LoadWebPage;
  LoadDOM;
end;

procedure TCustomParser.LoadDOM;
var
  v: OleVariant;
begin
  FDocumentProductPage := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  FDocumentProductPage.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := htmlSource.Text;
  FDocumentProductPage.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  FDocumentBody := FDocumentProductPage.body;
end;

procedure TCustomParser.LoadWebPage;
var
  MS: TMemoryStream;
//  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.GET(FPageURL, MS);
    htmlSource.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    FreeAndNil(NetHTTPClient);
  end;
end;

procedure TCustomParser.ParseProduct(Product: TWebProduct);
begin
  if Assigned(FOnParseProduct) then
    FOnParseProduct(Product);
end;

procedure TCustomParser.SetOnParseSearch(const Value: TOnParseSearch);
begin
  FOnParseSearch := Value;
end;


{ TMuncitorulParser }

procedure TMuncitorulParser.ParseDetailPage;
var
  Tags: OleVariant;
  tags2: OleVariant;
  i: Integer;
  link_url: string;
//  MyDiv, HtmlElem1: IHTMLElement;
//  HtmlAnchor: IHTMLAnchorElement;
//  AnCol1, AnCol2: IHTMLElementCollection;
  j: Integer;
begin
  Product := TWebProduct.Create(FProductCode);
  try
    Tags := FDocumentBody.All.Tags('div');
    for i := 0 to Tags.length - 1 do
    begin
      if (Tags.item(i).ClassName = 'gallery-container') then
      begin
        tags2 := Tags.item(i).getElementsByTagName('a');
        for j := 0 to tags2.Length - 1 do
        begin
          if (tags2.item(j).ClassName = 'grouped_elements') then
          begin
            link_url := tags2.item(j).href;
            Product.ImageList.Add('https://www.muncitorul.md' + Copy(link_url, 7, Length(link_url)));
          end;
        end;

      end;
      if Tags.item(i).ClassName = 'buy__qty' then
      begin
        tags2 := Tags.item(i).getElementsByTagName('p');
        for j := 0 to tags2.Length - 1 do
        begin
          if tags2.item(j).ClassName = 'buy__price' then
          begin
            Product.ProductPrice := tags2.item(j).InnerText;
          end;
        end;
      end;

      if Tags.item(i).ClassName = 'product-description-text' then
      begin
        Product.DescriptionRo := UTF8Decode(Tags.item(i).InnerText);
      end;
    end;

    // event fire
    if Assigned(FOnParseProduct) then
      FOnParseProduct(Product);
  finally
    Product.Free;
  end;
end;

procedure TMuncitorulParser.ParseSearchResult(var ProductUrlRo, ProductUrlRu: string);
var
  h: string;
  i: Integer;
  Tags: OleVariant;
begin
 // 1. div class="card__img-wrap"
 // 2. a href product page
  PrepareData(FPageURL);
  ProductUrlRo := '';
  ProductUrlRu := '';
  try
    Tags := FDocumentBody.All.Tags('a');
    for i := 0 to Tags.length - 1 do
    begin
      if (Tags.item(i).ClassName = 'title_linck') then
      begin
        h := Tags.item(i).OuterHtml;
        ProductUrlRo := 'https://www.muncitorul.md' + Copy(Tags.item(i).href, 7, Length(Tags.item(i).href));
        ProductUrlRu := StringReplace(ProductUrlRo, '/ro/', '/ru/', []);
      end;
    end;

   // end of parsing
    if Assigned(FOnParseSearch) then
      OnParseSearch(ProductUrlRo, ProductUrlRu);
  finally
//    Product.Free;
  end;
end;

{ TLumeaInstrumentelorParser }

procedure TLumeaInstrumentelorParser.ParseDetailPage;
var
  Tags: OleVariant;
  tags2: OleVariant;
  i: Integer;
  link_url: string;
//  MyDiv, HtmlElem1: IHTMLElement;
//  HtmlAnchor: IHTMLAnchorElement;
//  AnCol1, AnCol2: IHTMLElementCollection;
  j: Integer;
  ss: string;
begin
  Product := TWebProduct.Create(FProductCode);
  try
    Tags := FDocumentBody.All.Tags('div');
    ss := FDocumentBody.All.Html;
    for i := 0 to Tags.length - 1 do
    begin
      if (Tags.item(i).ClassName = 'slick-track') then
      begin
        tags2 := Tags.item(i).getElementsByTagName('a');
        for j := 0 to tags2.Length - 1 do
        begin
          if (tags2.item(j).ClassName.contains('fancybox')) then
          begin
            link_url := tags2.item(j).href;
            Product.ImageList.Add('https://www.muncitorul.md' + Copy(link_url, 7, Length(link_url)));
          end;
        end;
        break;
      end;
      if Tags.item(i).ID = 'short_description_block' then
      begin
        Product.DescriptionRo := UTF8Decode(Tags.item(i).InnerText);
      end;

    end;

    // event fire
    if Assigned(FOnParseProduct) then
      FOnParseProduct(Product);
  finally
    Product.Free;
  end;
end;

procedure TLumeaInstrumentelorParser.ParseSearchResult(var ProductUrlRo, ProductUrlRu: string);
var
  allDivs, Elements: OleVariant;
  cc: Integer;
  i, j: Integer;
  productUrl: string;
  s: string;
begin
  PrepareData(FPageURL);
  allDivs := FDocumentBody.All.Tags('a');
  s := '';
  for j := 0 to allDivs.Length - 1 do
  begin
    cc := 0;
    if (allDivs.item(j).ClassName = 'product_img_link') then
    begin
      ProductUrlRo := allDivs.item(i).href;
//                ProductUrlRo := 'https://www.muncitorul.md' + Copy(Tags.item(i).href, 7, Length(Tags.item(i).href));
      ProductUrlRu := StringReplace(ProductUrlRo, '/ro/', '/ru/', []);
      Break;
    end;
  end;

    // event fire
  if Assigned(FOnParseProduct) then
    FOnParseProduct(Product);
end;

end.


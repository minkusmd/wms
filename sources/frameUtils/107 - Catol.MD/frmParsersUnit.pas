unit frmParsersUnit;

interface

uses
  System.Classes, MSHTML, ActiveX, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, SHDocVw, System.SysUtils, System.Variants;

type

  TCustomParser = class
  private
    htmlstrings: TStringlist;
    Doc: IHTMLDocument2;
    d: HTMLLIElement;
    body: OleVariant;

    FProductDetailUrl: string;
    FDescriptionRU: string;
    FDescriptionRO: string;
    FImagesUrl: TStringList;
    procedure SetDescriptionRO(const Value: string);
    procedure SetDescriptionRU(const Value: string);
    procedure SetImagesUrl(const Value: TStringList);
    procedure SetProductDetailUrl(const Value: string);
  public
    procedure DoParse;
    procedure DoParseDetailPageRO(url:string); virtual;
    procedure DoParseDetailPageRU(url: string); virtual;
    constructor Create(AOwner: TComponent; AUrl: string); overload;
    destructor Destroy; override;
    property DescriptionRO: string read FDescriptionRO write SetDescriptionRO;
    property DescriptionRU: string read FDescriptionRU write SetDescriptionRU;
    property ImagesUrl: TStringList read FImagesUrl write SetImagesUrl;
    property ProductDetailUrl: string read FProductDetailUrl write SetProductDetailUrl;
  end;

  TCatolParser = class
    fUrl: string;
    HtmlStrings: TStringList;
    Doc: IHTMLDocument2;
    d: HTMLLIElement;
    Body: OleVariant;
  private

    FDescriptionRO: string;
    FDescriptionRU: string;
    FImagesUrl: TStringList;
    FProductDetailUrl: string;
    procedure LoadDom(htmlcode: string);
    procedure LoadPage(URL: string);
    procedure SetDescriptionRO(const Value: string);
    procedure SetDescriptionRU(const Value: string);
    procedure SetImagesUrl(const Value: TStringList);
    procedure SetProductDetailUrl(const Value: string);

  public
    ProductName: string;
    ImageUrl: string;
    ProductStockInfo: string;
    ProductDescriptionRo: string;
    ProductDescriptionRu: string;
    procedure DoParse;
    procedure DoParseDetailPageRO(url:string); virtual;
    procedure DoParseDetailPageRU(url: string); virtual;
    constructor Create(AOwner: TComponent; AUrl: string); overload;
    destructor Destroy; override;
    property DescriptionRO: string read FDescriptionRO write SetDescriptionRO;
    property DescriptionRU: string read FDescriptionRU write SetDescriptionRU;
    property ImagesUrl: TStringList read FImagesUrl write SetImagesUrl;
    property ProductDetailUrl: string read FProductDetailUrl write
        SetProductDetailUrl;
  end;

implementation

{ TCatolParser }

constructor TCatolParser.Create(AOwner: TComponent; AUrl: string);
begin
  fUrl := AUrl;
  ImagesUrl := TStringlist.Create;
  HtmlStrings := TStringList.Create;
  LoadPage(AUrl);
  LoadDom(HtmlStrings.Text);
end;

destructor TCatolParser.Destroy;
begin
  HtmlStrings.Free;
  imagesUrl.Free;
  inherited;
end;

procedure TCatolParser.DoParse;
var
  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  dd: IHTMLElement;
  i, k: Integer;
  s: string;
  j: Integer;
  cnt: integer;
  _ClassName: string;
begin
  allDivs := Body.All.Tags('div');
  s := '';
  ImagesUrl.Clear;
  for j := 0 to allDivs.Length - 1 do begin
    if (allDivs.item(j).ClassName = 'product-card') then begin
      Elements := AllDivs.item(j).getElementsByTagName('div');
      cnt := Elements.Length - 1;
      for i := 0 to (Elements.Length - 1) do begin
        // get imagelink
        _ClassName := Elements.item(i).ClassName;
        if (_ClassName.Contains('swiper-slide')) then begin
          aHrefTags := Elements.item(i).getElementsByTagName('a');
          if aHrefTags.Length > 0 then begin
            s := aHrefTags.item(0).href;
            s := Copy(s, pos('about:', s) + 6, length(s));
            ProductDetailUrl := 'https://volta.md'+s;
          end;

          aHrefTags := Elements.item(i).getElementsByTagName('img');
          if aHrefTags.Length > 0 then begin
            s := aHrefTags.item(0).href;
            s := Copy(s, pos('&image=', s) + 7, length(s));
            s := 'https:' + s;
            ImagesUrl.Add(trim(s));
          end;
        end;
//        // DescriptionRO
//        s := Elements.item(i).ClassName;
//        if (Elements.item(i).ClassName = 'producttab') then begin
//          DescriptionRO := Elements.item(i).InnerText;
//        end;
      end;
    end;
  end;
end;

procedure TCatolParser.DoParseDetailPageRO(url:string);
var
  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  dd: IHTMLElement;
  i, k: Integer;
  s: string;
  j: Integer;
  cnt: integer;
  _ClassName: string;
begin
  LoadPage(url);
  loaddom(htmlstrings.Text);

  allDivs := Body.All.Tags('div');
  s := '';
  ImagesUrl.Clear;
  for j := 0 to allDivs.Length - 1 do begin
    if (allDivs.item(j).ClassName = 'about-item__description') then begin
      Elements := AllDivs.item(j).getElementsByTagName('div');
      cnt := Elements.Length - 1;
      for i := 0 to (Elements.Length - 1) do begin
        // get imagelink
        _ClassName := Elements.item(i).ClassName;
        if (_ClassName.Contains('wrapper')) then begin
          DescriptionRO := Elements.item(i).InnerText;
        end;
      end;
    end;
  end;
end;

procedure TCatolParser.DoParseDetailPageRU(url:string);
var
  aHrefTags: OleVariant;
  allDivs, Elements: OleVariant;
  dd: IHTMLElement;
  i, k: Integer;
  s: string;
  j: Integer;
  cnt: integer;
  _ClassName: string;
begin
  LoadPage(url);
  loaddom(htmlstrings.Text);

  allDivs := Body.All.Tags('div');
  s := '';
  ImagesUrl.Clear;
  for j := 0 to allDivs.Length - 1 do begin
    if (allDivs.item(j).ClassName = 'about-item__description') then begin
      Elements := AllDivs.item(j).getElementsByTagName('div');
      cnt := Elements.Length - 1;
      for i := 0 to (Elements.Length - 1) do begin
        // get imagelink
        _ClassName := Elements.item(i).ClassName;
        if (_ClassName.Contains('wrapper')) then begin
          DescriptionRU := Elements.item(i).InnerText;
        end;
      end;
    end;
  end;
end;

procedure TCatolParser.LoadPage(URL: string);
var
  MS: TMemoryStream;
  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.GET(URL, MS);
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    freeAndNil(NetHTTPClient);
  end;
end;

procedure TCatolParser.LoadDom(htmlcode: string);
var
  v: OleVariant;
begin
  Doc := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  Doc.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := htmlcode;
  Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  Body := Doc.body;
end;

procedure TCatolParser.SetDescriptionRO(const Value: string);
begin
  FDescriptionRO := Value;
end;

procedure TCatolParser.SetDescriptionRU(const Value: string);
begin
  FDescriptionRU := Value;
end;

procedure TCatolParser.SetImagesUrl(const Value: TStringList);
begin
  FImagesUrl := Value;
end;

procedure TCatolParser.SetProductDetailUrl(const Value: string);
begin
  FProductDetailUrl := Value;
end;

{ TCustomParser }

constructor TCustomParser.Create(AOwner: TComponent; AUrl: string);
begin

end;

destructor TCustomParser.Destroy;
begin

  inherited;
end;

procedure TCustomParser.DoParse;
begin

end;

procedure TCustomParser.DoParseDetailPageRO(url: string);
begin

end;

procedure TCustomParser.DoParseDetailPageRU(url: string);
begin

end;

procedure TCustomParser.SetDescriptionRO(const Value: string);
begin
  FDescriptionRO := Value;
end;

procedure TCustomParser.SetDescriptionRU(const Value: string);
begin
  FDescriptionRU := Value;
end;

procedure TCustomParser.SetImagesUrl(const Value: TStringList);
begin
  FImagesUrl := Value;
end;

procedure TCustomParser.SetProductDetailUrl(const Value: string);
begin
  FProductDetailUrl := Value;
end;

end.


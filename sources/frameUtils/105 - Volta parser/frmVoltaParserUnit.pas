unit frmVoltaParserUnit;

interface

uses
  System.Classes, MSHTML, ActiveX, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, SHDocVw, System.SysUtils, System.Variants;

type
  TVoltaParser = class
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

{ TVoltaParser }

constructor TVoltaParser.Create(AOwner: TComponent; AUrl: string);
begin
  fUrl := AUrl;
  ImagesUrl := TStringlist.Create;
  HtmlStrings := TStringList.Create;
  LoadPage(AUrl);
  LoadDom(HtmlStrings.Text);
end;

destructor TVoltaParser.Destroy;
begin
  HtmlStrings.Free;
  imagesUrl.Free;
  inherited;
end;

procedure TVoltaParser.DoParse;
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

procedure TVoltaParser.DoParseDetailPageRO(url:string);
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

procedure TVoltaParser.DoParseDetailPageRU(url:string);
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

procedure TVoltaParser.LoadPage(URL: string);
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

procedure TVoltaParser.LoadDom(htmlcode: string);
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

procedure TVoltaParser.SetDescriptionRO(const Value: string);
begin
  FDescriptionRO := Value;
end;

procedure TVoltaParser.SetDescriptionRU(const Value: string);
begin
  FDescriptionRU := Value;
end;

procedure TVoltaParser.SetImagesUrl(const Value: TStringList);
begin
  FImagesUrl := Value;
end;

procedure TVoltaParser.SetProductDetailUrl(const Value: string);
begin
  FProductDetailUrl := Value;
end;

end.


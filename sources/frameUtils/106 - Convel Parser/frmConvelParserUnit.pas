unit frmConvelParserUnit;

interface

uses
  System.Classes, MSHTML, ActiveX, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, SHDocVw, System.SysUtils, System.Variants;

const
  HostName = 'http://convel.md/';

type
  TConvelParser = class
    fUrl: string;
    HtmlStrings: TStringList;
    Doc: IHTMLDocument2;
    Body: OleVariant;
  private
    FImageUrl: string;
    FProductStockInfo: string;
    FProductDescriptionRo: string;
    FProductDescriptionRu: string;
    FProductName: string;
    procedure LoadDom(htmlcode: string);
    procedure LoadPage(URL: string);
    procedure SetImageUrl(const Value: string);
    procedure SetProductStockInfo(const Value: string);
    procedure SetProductDescriptionRo(const Value: string);
    procedure SetProductDescriptionRu(const Value: string);
    procedure SetProductName(const Value: string);
  public
    procedure DoParse;
    constructor Create(AOwner: TComponent; AUrl: string); overload;
    destructor Destroy; override;
    property ImageUrl: string read FImageUrl write SetImageUrl;
    property ProductStockInfo: string read FProductStockInfo write
        SetProductStockInfo;
    property ProductDescriptionRo: string read FProductDescriptionRo write SetProductDescriptionRo;
    property ProductDescriptionRu: string read FProductDescriptionRu write SetProductDescriptionRu;
    property ProductName: string read FProductName write SetProductName;
  end;

implementation

uses
  Vcl.Dialogs;

{ TConvelParser }

constructor TConvelParser.Create(AOwner: TComponent; AUrl: string);
begin
  fUrl := AUrl;
  HtmlStrings := TStringList.Create;
  LoadPage(AUrl);
  LoadDom(HtmlStrings.Text);
end;

destructor TConvelParser.Destroy;
begin
  HtmlStrings.Free;
  inherited;
end;

procedure TConvelParser.DoParse;
var
  containerTags, TitleTag, aHrefTags: OleVariant;
  Elements: OleVariant;
  i, k: Integer;
  j: Integer;
  s: string;
begin
  Elements := Body.All.Tags('div');
  s := '';
  ProductName := '';
  for i := 0 to Elements.Length - 1 do begin
    if (Elements.item(i).ClassName = 'product-info') then begin
      TitleTag := Elements.item(i).getElementsByTagName('h1');
      if TitleTag.Length > 0 then begin
        s := TitleTag.item(0).InnerHtml;
        ProductName := s;
//        ShowMessage(ProductName);
      end;

      containerTags := Elements.item(i).getElementsByTagName('div');

      for j := 0 to containerTags.Length -1 do begin
        if (containerTags.item(j).ClassName = 'stock-container info-container m-t-10') then begin
          ProductStockInfo := containerTags.item(j).InnerText;
//          ShowMessage(ProductStockInfo);
          break;
        end;
      end;
    end;

    if (Elements.item(i).ClassName = 'single-product-gallery-item') then begin
      aHrefTags := Elements.item(i).getElementsByTagName('a');
      if aHrefTags.Length > 0 then begin
        s := aHrefTags.item(0).Href;
        ImageUrl := HostName + copy(s, 7, s.Length);
//        ShowMessage(ImageUrl);
      end;
    end;

    if (Elements.item(i).ClassName = 'product-tab') then begin
      ProductDescriptionRo := Elements.item(i).InnerHtml;
    end;
  end;
end;

procedure TConvelParser.LoadPage(URL: string);
var
  MS: TMemoryStream;
  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);

  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36';
    NetHTTPClient.GET(URL, MS);
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    FreeAndNil(NetHTTPClient);
  end;
end;

procedure TConvelParser.LoadDom(htmlcode: string);
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

procedure TConvelParser.SetImageUrl(const Value: string);
begin
  FImageUrl := Value;
end;

procedure TConvelParser.SetProductStockInfo(const Value: string);
begin
  FProductStockInfo := Value;
end;

procedure TConvelParser.SetProductDescriptionRo(const Value: string);
begin
  FProductDescriptionRo := Value;
end;

procedure TConvelParser.SetProductDescriptionRu(const Value: string);
begin
  FProductDescriptionRu := Value;
end;

procedure TConvelParser.SetProductName(const Value: string);
begin
  FProductName := Value;
end;

end.


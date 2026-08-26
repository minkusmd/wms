unit EuroTermParserUnit;

interface

uses
  System.Classes, MSHTML, ActiveX, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, SHDocVw,
  System.SysUtils, System.Variants;

const
  HostName = 'http://euroterm.md/';

type
  TEurotermParser = class
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
    property ProductStockInfo: string read FProductStockInfo write SetProductStockInfo;
    property ProductDescriptionRo: string read FProductDescriptionRo write SetProductDescriptionRo;
    property ProductDescriptionRu: string read FProductDescriptionRu write SetProductDescriptionRu;
    property ProductName: string read FProductName write SetProductName;
  end;

implementation

uses
  Vcl.Dialogs;

{ TEurotermParser }

constructor TEurotermParser.Create(AOwner: TComponent; AUrl: string);
begin
  fUrl := AUrl;
  HtmlStrings := TStringList.Create;
  LoadPage(AUrl);
  LoadDom(HtmlStrings.Text);
end;

destructor TEurotermParser.Destroy;
begin
  HtmlStrings.Free;
  inherited;
end;

procedure TEurotermParser.DoParse;
var
  containerTags, TitleTag, aHrefTags: OleVariant;
  Elements: OleVariant;
  i, k: Integer;
  imgsrc: string;
  j: Integer;
  s: string;
  ta: OleVariant;
  timg: OleVariant;
begin
  Elements := Body.All.Tags('div');
  s := '';
  ProductName := '';
  for i := 0 to Elements.Length - 1 do
  begin
    ImageUrl := '';
    if (Elements.item(i).ClassName = 'products grid row') then
    begin
      ta := Elements.item(i).getElementsByTagName('a');
      for j := 0 to ta.Length - 1 do
      begin
        if ta.item(j).ClassName = 'product-image' then
        begin
          timg := ta.item(j).getElementsBytagName('img');
          ImageUrl := StringReplace(timg.item(0).src, 'thumb', 'original', []);
//          ShowMessage(imgsrc);
          if not ImageUrl.Equals('') then
          begin
            exit;
          end;
        end;
      end;
    end;
  end;
end;

procedure TEurotermParser.LoadPage(URL: string);
var
  MS: TMemoryStream;
  Resp: IHTTPResponse;
  NetHTTPClient: TNetHTTPClient;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);

  MS := TMemoryStream.Create;
  try
    NetHTTPClient.AcceptCharSet := 'utf-8';
    NetHTTPClient.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.88 Safari/537.36';
    NetHTTPClient.GET(URL, MS);
    HtmlStrings.LoadFromStream(MS);

  finally
    FreeAndNil(MS);
    FreeAndNil(NetHTTPClient);
  end;
end;

procedure TEurotermParser.LoadDom(htmlcode: string);
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

procedure TEurotermParser.SetImageUrl(const Value: string);
begin
  FImageUrl := Value;
end;

procedure TEurotermParser.SetProductStockInfo(const Value: string);
begin
  FProductStockInfo := Value;
end;

procedure TEurotermParser.SetProductDescriptionRo(const Value: string);
begin
  FProductDescriptionRo := Value;
end;

procedure TEurotermParser.SetProductDescriptionRu(const Value: string);
begin
  FProductDescriptionRu := Value;
end;

procedure TEurotermParser.SetProductName(const Value: string);
begin
  FProductName := Value;
end;

end.


unit SWNParseUtils;

interface

uses
  System.Classes, MSHTML, System.Net.HttpClientComponent, System.Variants;

type
  TSWNParse = class
    fDocument: IHTMLDocument2;
    fBody: OleVariant;
    fHtmlSource: TStringList;
  public
    procedure LoadPage(URL: string);
    function LoadDom: Olevariant;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Winapi.ActiveX, System.SysUtils, System.Net.HttpClient;

{constructor class initialization}
constructor TSWNParse.Create;
begin
  inherited;
  fHtmlSource := TStringList.Create;
end;

destructor TSWNParse.Destroy;
begin
  FreeAndNil(fHtmlSource);
  inherited;
end;

procedure TSWNParse.LoadPage(URL: string);
var
  ms: TMemoryStream;
  HttpClient: THTTPClient;
begin
  HttpClient := THTTPClient.Create;
  ms := TMemoryStream.Create;
  try
    HttpClient.UserAgent :=
      'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36';
    HttpClient.AcceptCharSet := 'utf-8';
    HttpClient.Get(URL, ms);
    ms.Position := 0;
    fHtmlSource.LoadFromStream(ms);
  finally
    FreeAndNil(ms);
    FreeAndNil(HttpClient);
  end;
end;

function TSWNParse.LoadDom: Olevariant;
var
  v: OleVariant;
  sHtmlSource: string;
begin
  fDocument := CoHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  fDocument.designMode := 'on';
  sHtmlSource := fHtmlSource.Text;
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := sHtmlSource;
  fDocument.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  Result := fDocument.body;
end;

end.


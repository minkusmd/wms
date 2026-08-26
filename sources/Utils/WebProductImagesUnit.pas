unit WebProductImagesUnit;

interface

uses
    System.Net.HttpClient, IBC, MSHTML, Winapi.ActiveX;

type
    TOnWebParseSync = procedure (AMessage: string) of object;

    TWebProductImages = class
    private
        FGoodsID: Integer;
        FSupplierCode: string;
        httpclient: ThttpClient;
        IBCQueryGoodsImage: TIBCQuery;
        IBCTrUpdate: TIBCTransaction;
        fOnWebParseSync: TOnWebParseSync;
        FSearchURL: string;
        procedure LoadDomFromHtml(htmlcode: string);
        procedure ParseDetailPage(GoodsID: Integer); virtual;
        procedure SetOnWebParseSync(const Value: TOnWebParseSync);
        procedure SetSearchURL(const Value: string);
    protected

    public
        Doc: IHTMLDocument2;
        body: OleVariant;
        property SearchURL: string read FSearchURL write SetSearchURL;
        property OnWebParseSync: TOnWebParseSync read fOnWebParseSync write SetOnWebParseSync;

        constructor Create(AConnection: TIBCConnection); overload;
        destructor Destroy; override;
        procedure LoadImages(AGoodsID: Integer; AGoodsCode: string);
    end;

implementation

uses
    System.Classes, System.SysUtils, System.Variants, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
    Vcl.Graphics, Data.DB;

constructor TWebProductImages.Create(AConnection: TIBCConnection);
begin
    httpclient := THttpClient.Create;
    httpclient.UserAgent :=
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36';
    ibctrUpdate := TIBCTransaction.Create(nil);
    IBCTrUpdate.DefaultConnection := AConnection;

    IBCQueryGoodsImage := TIBCQuery.Create(nil);
    IBCQueryGoodsImage.Transaction := ibcTrUpdate;
    IBCQueryGoodsImage.SQL.Text := 'insert into ts_goods_image (goodsid, image)' + 'values(:goodsid, :image)';
end;

destructor TWebProductImages.Destroy;
begin
    HttpClient.Free;
    IBCQueryGoodsImage.Free;
    IBCTrUpdate.Free;
    inherited;
end;

procedure TWebProductImages.LoadImages(AGoodsID: Integer; AGoodsCode: string);
var
    ms: TMemoryStream;
    htmlbody: TStringList;
begin
    FGoodsID := AGoodsID;
    FSupplierCode := AGoodsCode;
    ms := TMemoryStream.Create;
    htmlbody := TStringList.Create;
    try
        httpclient.Get(format('FSearchURL/%s', [AGoodsCode]), ms);
        ms.Position := 0;
        htmlbody.LoadFromStream(ms);
        LoadDomFromHtml(htmlbody.Text);
        ParseDetailPage(AGoodsID);
    finally
        ms.Free;
    end;
end;

procedure TWebProductImages.ParseDetailPage(GoodsID: Integer);
begin
 //
end;

procedure TWebProductImages.LoadDomFromHtml(htmlcode: string);
var
    v: OleVariant;
begin
    Doc := coHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
    Doc.designMode := 'on';
    v := VarArrayCreate([0, 0], varVariant);
    v[0] := htmlcode;
    Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
    body := Doc.body;
end;


procedure TWebProductImages.SetOnWebParseSync(const Value: TOnWebParseSync);
begin
  fOnWebParseSync := Value;
end;

procedure TWebProductImages.SetSearchURL(const Value: string);
begin
  FSearchURL := Value;
end;

end.


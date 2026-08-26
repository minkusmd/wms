unit ParseImagesMuncitorulUnit;

interface

uses
  System.Net.HttpClient, IBC, MSHTML, Winapi.ActiveX, parser;

type
  TParseMuncitorulProductImages = class
  private
    FGoodsID: Integer;
    FSupplierCode: string;
    httpclient: ThttpClient;
    IBCQueryGoodsImage: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    procedure LoadDomFromHtml(htmlcode: string);
    procedure ParseDetailPage(GoodsID: Integer);
  protected
  public
    Doc: IHTMLDocument2;
    body: OleVariant;
    constructor Create(AConnection: TIBCConnection); overload;
    destructor Destroy; override;
    procedure LoadImages(AGoodsID: Integer; ASupplierCode: string);
  end;

implementation

uses
  System.Classes, System.SysUtils, System.Variants, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Vcl.Graphics, Data.DB;

constructor TParseMuncitorulProductImages.Create(AConnection: TIBCConnection);
begin
  httpclient := THttpClient.Create;
  httpclient.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36';
  ibctrUpdate := TIBCTransaction.Create(nil);
  IBCTrUpdate.DefaultConnection := AConnection;

  IBCQueryGoodsImage := TIBCQuery.Create(nil);
  IBCQueryGoodsImage.Transaction := ibcTrUpdate;
  IBCQueryGoodsImage.SQL.Text := 'insert into ts_goods_image (goodsid, image)' + 'values(:goodsid, :image)';
end;

destructor TParseMuncitorulProductImages.Destroy;
begin
  HttpClient.Free;
  IBCQueryGoodsImage.Free;
  IBCTrUpdate.Free;
  inherited;
end;

procedure TParseMuncitorulProductImages.LoadImages(AGoodsID: Integer; ASupplierCode: string);
var
  ms: TMemoryStream;
  htmlbody: TStringList;
begin
  FGoodsID := AGoodsID;
  FSupplierCode := ASupplierCode;
  ms := TMemoryStream.Create;
  htmlbody := TStringList.Create;
  try
    httpclient.Get(format('https://muncitorul.md/ro/cautare/%s', [ASupplierCode]), ms);
    ms.Position := 0;
    htmlbody.LoadFromStream(ms);
    LoadDomFromHtml(htmlbody.Text);
    ParseDetailPage(AGoodsID);
  finally
    ms.Free;
  end;
end;

procedure TParseMuncitorulProductImages.LoadDomFromHtml(htmlcode: string);
var
  v: OleVariant;
begin
  Doc := coHTMLDocument.Create as IHTMLDocument2; // create IHTMLDocument2 instance
  Doc.designMode := 'on';
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := htmlcode;
  Doc.Write(PSafeArray(TVarData(v).VArray)); // write data from IdHTTP
  body := Doc.body;
//    Doc.Close;
end;

procedure TParseMuncitorulProductImages.ParseDetailPage(GoodsID: Integer);
var
  elCount: Integer;
  Elements: OleVariant;
  I: Integer;
  aTag, divTag: OleVariant;
  imagepath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJpegImage;
  bmpImage: TBitMap;
  html: string;
  pngImage: TPNGImage;
begin
  ImageStream := TMemoryStream.Create;

  try
    Elements := Body.All.Tags('div');
    elCount := Elements.Length - 1;
    for I := 0 to elCount do begin
      divTag := Elements.item(I);
      if divTag._className = 'img_link' then begin
        //        https://muncitorul.md/produse_img/02202001550959497021.jpg
        html := Elements.item(I).outerHTML;

//        imagepath := aTag.href;
//
//        httpclient.Get(imagepath, ImageStream);
//        ImageStream.Position := 0;
//        ImageStream.SaveToFile('tmp.jpeg');
//        jpegImage := TJPEGImage.Create;
//        bmpImage := TBitMap.Create;
//        pngImage := TPNGImage.Create;
//        try
//          jpegImage.loadfromFile('tmp.jpeg');
//          bmpImage.Assign(jpegImage);
//          pngImage.Assign(bmpImage);
//          pngImage.SaveToFile('tmp.png');
//        finally
//          jpegImage.Free;
//          bmpImage.Free;
//          pngImage.Free;
//        end;
//        IBCQueryGoodsImage.ParamByName('GOODSID').AsInteger := FGoodsID;
//        IBCQueryGoodsImage.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
//        IBCQueryGoodsImage.Execute;
//        // daca am gasit linkul nu mai alergam prin ciclu
//        break;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

end.


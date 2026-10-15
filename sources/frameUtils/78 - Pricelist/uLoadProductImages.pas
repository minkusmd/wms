unit uLoadProductImages;

{ TLoadBombaProductImages - incarcare de proba a imaginilor de pe bomba.md (URL fix, scria direct in
  TS_GOODS_IMAGE). Nu mai e folosit (13 oct 2026): codul e comentat, unit-ul ramine gol cit timp e
  inregistrat in SWN.dpr. Imaginile furnizorilor din pricelist: frame78 -> "Caracteristici si imagini". }

interface

(*

uses
    System.Net.HttpClient, IBC, MSHTML, Winapi.ActiveX;

type
    TOnParseStep = procedure (AMessage: string) of object;

    TLoadBombaProductImages = class
    private
        FGoodsID: Integer;
        FSupplierCode: string;
        httpclient: ThttpClient;
        IBCQueryGoodsImage: TIBCQuery;
        IBCTrUpdate: TIBCTransaction;
        fOnParseStep: TOnParseStep;
        procedure LoadDomFromHtml(htmlcode: string);
        procedure ParseDetailPage(GoodsID: Integer);
        procedure SetOnParseStep(const Value: TOnParseStep);
    protected

    public
        Doc: IHTMLDocument2;
        body: OleVariant;
        property OnParseStep: TOnParseStep read fOnParseStep write SetOnParseStep;
        constructor Create(AConnection: TIBCConnection); overload;
        destructor Destroy; override;
        procedure LoadImages(AGoodsID: Integer; AGoodsCode: string);
    end;

*)

implementation

(*

uses
    System.Classes, System.SysUtils, System.Variants, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
    Vcl.Graphics, Data.DB;

constructor TLoadBombaProductImages.Create(AConnection: TIBCConnection);
begin
    httpclient := THttpClient.Create;
    httpclient.UserAgent :=
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36';
    ibctrUpdate := TIBCTransaction.Create(nil);
    IBCTrUpdate.DefaultConnection := AConnection;

    IBCQueryGoodsImage := TIBCQuery.Create(nil);
    IBCQueryGoodsImage.Transaction := ibcTrUpdate;
    IBCQueryGoodsImage.SQL.Text := 'insert into ts_goods_image (goodsid, image)' + 'values(:goodsid, :image)';
end;

destructor TLoadBombaProductImages.Destroy;
begin
    HttpClient.Free;
    IBCQueryGoodsImage.Free;
    IBCTrUpdate.Free;
    inherited;
end;

procedure TLoadBombaProductImages.LoadImages(AGoodsID: Integer; AGoodsCode: string);
var
    ms: TMemoryStream;
    htmlbody: TStringList;
begin
    FGoodsID := AGoodsID;
    FSupplierCode := AGoodsCode;
    ms := TMemoryStream.Create;
    htmlbody := TStringList.Create;
    try
        var url := format('https://bomba.md/ro/product/%s', [AGoodsCode]);
        url := 'https://bomba.md/ro/product/frigider-heinner-hf-v242se-plus-plus-1051346/';
        httpclient.Get(url, ms);
        ms.Position := 0;
        htmlbody.LoadFromStream(ms);
        LoadDomFromHtml(htmlbody.Text);
        ParseDetailPage(AGoodsID);
    finally
        ms.Free;
    end;
end;

procedure TLoadBombaProductImages.LoadDomFromHtml(htmlcode: string);
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

procedure TLoadBombaProductImages.ParseDetailPage(GoodsID: Integer);
var
    elCount: Integer;
    Elements: OleVariant;
    I: Integer;
    atag: OleVariant;
    imagepath: string;
    ImageStream: TMemoryStream;
    jpegImage: TJpegImage;
    bmpImage: TBitMap;
    pngImage: TPNGImage;
    divTags : OleVariant;
begin
    ImageStream := TMemoryStream.Create;

    try
        Elements := Body.All.Tags('div');
        elCount := Elements.Length - 1;
        for I := 0 to elCount do
        begin
            if Elements.item(I).ClassName='swiper-wrapper' then
            begin
                divTags :=  Elements.item(I);

                atag := divTags.getElementsByTagName('a');
                for var j := 0 to integer(atag.Length-1) do
                    begin
                       if atag.item(j).ClassName = 'slide' then
                       begin
                           imagepath := atag.item(j).href;
                       end;

                    end;
            end;
//            if Assigned(fOnParseStep) then
//              fOnParseStep(string(atag.ClassName));
                imagepath := StringReplace(imagepath, 'about:', 'https://bomba.md', []);
            if Assigned(fOnParseStep) then
              fOnParseStep(imagepath);

                ImageStream.Clear;
                httpclient.Get(imagepath, ImageStream);
                ImageStream.Position := 0;
                ImageStream.SaveToFile('bomba.jpeg');
                jpegImage := TJPEGImage.Create;
                bmpImage := TBitMap.Create;
                pngImage := TPNGImage.Create;
                try
                    try
                    jpegImage.loadfromFile('bomba.jpeg');
                    bmpImage.Assign(jpegImage);
                    pngImage.Assign(bmpImage);
                    pngImage.SaveToFile('bomba.png');
                    except
                      if Assigned(fOnParseStep) then
                        fOnParseStep('Error on loading jpeg');
                    end;
                finally
                    jpegImage.Free;
                    bmpImage.Free;
                    pngImage.Free;
                end;
                IBCQueryGoodsImage.ParamByName('GOODSID').AsInteger := FGoodsID;
                IBCQueryGoodsImage.ParamByName('IMAGE').LoadFromFile('bomba.png', ftBlob);
                IBCQueryGoodsImage.Execute;
            end;
    finally
        ImageStream.Free;
    end;
end;

procedure TLoadBombaProductImages.SetOnParseStep(const Value: TOnParseStep);
begin
  fOnParseStep := Value;
end;

*)

end.

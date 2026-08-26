unit swnImages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, Vcl.Menus, cxButtons,
  MSHTML, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, System.IOUtils,
  System.Variants, Winapi.ActiveX, IBC;

type
  TCallback = procedure(Msg: string) of object;

  TSWNImages = class
  public
    procedure SaveFileToPng(trUpdate: TIBCTransaction; AGoodsID: Integer;
        AImageUrl, ANewFileName: string; ACallback: TCallback = nil);
    procedure SaveToDB(AGoodsID: Integer; UpdateTransaction: TIBCTransaction;
        ACallback: TCallback = nil);
  end;

implementation

uses
  Data.DB;

{ TSWNImages }

procedure TSWNImages.SaveFileToPng(trUpdate: TIBCTransaction; AGoodsID:
    Integer; AImageUrl, ANewFileName: string; ACallback: TCallback);
var
  imagePath: string;
  ImageStream: TMemoryStream;
  jpegImage: TJPEGImage;
  bmpImage: TBitMap;
  imgExt: string;
  pngImage: TPngImage;
  HttpClient: THTTPClient;
begin
  ImageStream := TMemoryStream.Create;
  pngImage := TPngImage.Create;
  jpegImage := TJPEGImage.Create;
  imagePath := Trim(AImageURL);
  httpclient:=THTTPClient.Create;
  try
    if imagePath <> '' then begin
      HTTPClient.Get(imagePath, ImageStream);
//      Application.ProcessMessages;

      ImageStream.Position := 0;
      imgExt := TPath.GetExtension(imagePath);
      if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
        try
          ImageStream.SaveToFile('tmp.jpeg');
          jpegImage.loadfromFile('tmp.jpeg');
        except
          on e: Exception do begin
            if assigned(ACallback) then
              ACallback(e.Message);
          end;
        end;
      end;

      if imgExt = '.png' then begin
        ImageStream.SaveToFile('tmp.png');
        pngImage := TPngImage.Create;
        pngImage.loadfromFile('tmp.png');
      end;

      bmpImage := TBitMap.Create;
      try
        bmpImage.Assign(jpegImage);
        try
          if (imgExt = '.jpeg') or (imgExt = '.jpg') then begin
            pngImage.Assign(bmpImage);
            pngImage.SaveToFile('tmp.png');
          end;
        except
          on e: Exception do begin
            if assigned(ACallback) then
              ACallback(e.Message);
//            Memo1.Lines.Add(e.Message);
          end;
        end;
        SaveToDB(AGoodsID, trUpdate, ACallback);
      finally
        bmpImage.Free;
      end;
    end;
  finally
//    Application.ProcessMessages;
    FreeAndNil(jpegImage);
    FreeAndNil(pngImage);
    ImageStream.Free;

  end;
end;

procedure TSWNImages.SaveToDB(AGoodsID: Integer; UpdateTransaction:
    TIBCTransaction; ACallback: TCallback);
var
  ibcSQL: TIBCSQL;
begin
    ibcSQL := TIBCSQL.Create(nil);
    try
    ibcSQL.Transaction := UpdateTransaction;
    if not UpdateTransaction.Active then
      UpdateTransaction.StartTransaction;
    try
      ibcSQL.sql.text := 'insert into ts_goods_image (goodsid, image) values(:goodsid, :image)';
      ibcSQL.ParamByName('GOODSID').AsInteger := AGoodsID;
      ibcSQL.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
      ibcSQL.Execute;
      UpdateTransaction.Commit;
      DeleteFile('tmp.png');
    except
      on e: Exception do begin
        if assigned(ACallback) then
          ACallback(e.Message);
        UpdateTransaction.Rollback;
      end;
    end;
    finally
      ibcSQL.Free;
    end;
end;

end.


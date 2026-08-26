unit frame119PernaMeaUnit;
{
  »Õ¬≈Õ“¿–»«¿÷»ﬂ. »Ì‚ÂÌÚ‡ËÁ‡ˆËˇ
  DocTypeID = 1968
  Frame Index = 118
}

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.UITypes, Vcl.Controls, Vcl.Forms,
    Vcl.Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox, cxCurrencyEdit,
    cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView,
    cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxSplitter,
    cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS,
    cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator,
    cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
    dxDateRanges, dxSpreadSheetReportDesignerActions,
    dxSpreadSheetConditionalFormattingRulesActions, dxSpreadSheetActions,
    dxPrinting, System.Actions, Vcl.ActnList, dxActions, System.ImageList,
    Vcl.ImgList, cxImageList, dxScrollbarAnnotations, Vcl.StdCtrls,
    System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
    Vcl.ExtActns, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
    IdHTTP, System.JSON, Data.DBXJSON, cxContainer, cxTextEdit, cxMaskEdit,
    cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc,
    Vcl.Menus, cxButtons, cxPC, cxProgressBar, ApiAccentUnit, cxImage,
    Generics.Collections, cxCalendar, dxUIAClasses;

type
    TProductPropertyRecord = record
        Id: integer;
        Hardcode: integer;
        PropertyCode: string;
        PropertyNameRus: string;
        PropertyNameRom: string;
        PropertyValue: string;
        PropertyParentCode: string;
        WebVisible: string;
        Description: string;
        DescriptionRom: string;
        TagName: string;
        TagNameRus: string;
        TagNameRom: string;
        SortOrder: string;
        TransactdionID: integer;
    end;

    Tframe119PernaMea = class(TSWNBaseFrame)
        IBCTrLocal: TIBCTransaction;
        IBCQueryGoods: TIBCQuery;
        IBCDataSourceGoods: TIBCDataSource;
        IBCQueryImages: TIBCQuery;
        IBCDataSourceImages: TIBCDataSource;
        Panel1: TPanel;
        cxGrid3: TcxGrid;
        cxGrid3DBTableView1: TcxGridDBTableView;
        cxGrid3Level1: TcxGridLevel;
        Memo1: TMemo;
        cxImage1: TcxImage;
        Panel2: TPanel;
        btnLoadImages: TButton;
        cxProgressBar2: TcxProgressBar;
        IBCQueryParseSupplierGoods: TIBCQuery;
        IBCDataSourceParseSupplierGoods: TIBCDataSource;
        cxGrid3DBTableView1GOODS_CODE: TcxGridDBColumn;
        cxGrid3DBTableView1TITLE_RO: TcxGridDBColumn;
        cxGrid3DBTableView1TITLE_RU: TcxGridDBColumn;
        cxGrid3DBTableView1IMAGES: TcxGridDBColumn;
        cxGrid3DBTableView1URL_RO: TcxGridDBColumn;
        cxGrid3DBTableView1URL_RU: TcxGridDBColumn;
        cxGrid3DBTableView1DESCRIPTIONS_RO: TcxGridDBColumn;
        cxGrid3DBTableView1DESCRIPTIONS_RU: TcxGridDBColumn;
        cxGrid3DBTableView1CARACTERISTICS_RO: TcxGridDBColumn;
        cxGrid3DBTableView1CARACTERISTICS_RU: TcxGridDBColumn;
        NetHTTPClient: TNetHTTPClient;
        Memo2: TMemo;
        procedure btnLoadImagesClick(Sender: TObject);
        procedure DoSyncSaveRecord(AIndex: integer);
    private
{ Private declarations }
//    fLastGoodsFolderID: Integer;
        myApiAccent: TApiAccent;
        ProductPropertiesList: TList<TProductPropertyRecord>;

        procedure GetImages;
// TODO: ConvertImageToPNGEx
//      procedure ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
    protected    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DeleteRecord; override;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;
    public    { Public declarations }

        function GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
        procedure SetupDefaultFocus; override;
    end;

implementation

{$R *.dfm}

uses
    SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors,
    DataModuleAdditions, SWNValueStorageUnit, IdFTP, Vcl.Imaging.pngimage,
    WebpHelpers, Winapi.GDIPOBJ, Vcl.Imaging.jpeg, System.IOUtils, libwebp,
    Vcl.Imaging.GIFImg, Vcl.WebpImage, Vcl.Clipbrd, dxGDIPlusClasses;

procedure Tframe119PernaMea.btnLoadImagesClick(Sender: TObject);
begin
    GetImages;
end;

procedure Tframe119PernaMea.DeleteRecord;
begin
end;

procedure Tframe119PernaMea.DoFrameHide;
begin
    IBCQueryGoods.Close;
    IBCQueryParseSupplierGoods.Close;
    CloseExternalData;
    inherited;
end;

procedure Tframe119PernaMea.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQueryParseSupplierGoods.Open;
end;

procedure Tframe119PernaMea.DoSyncSaveRecord(AIndex: integer);
begin
    cxProgressBar2.Position := AIndex;
end;

function Tframe119PernaMea.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [];
end;

function Tframe119PernaMea.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe119PernaMea.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe119PernaMea.InitFrameID: Integer;
begin
    Result := 119;
end;

procedure Tframe119PernaMea.ReadFrameStates;
begin
    try
        AppUserConfigStorage.OpenSection(Self.Name);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe119PernaMea.RefreshData;
begin
    inherited;
    IBCQueryParseSupplierGoods.Refresh;
end;

procedure Tframe119PernaMea.SaveFrameStates;
begin
    try
        AppUserConfigStorage.OpenSection(Self.Name);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe119PernaMea.SetupDefaultFocus;
begin
//    cxGrid3.SetFocus;
end;

procedure Tframe119PernaMea.GetImages;
var
    ImageFileNameList: TStringList;
    GoodsID: Integer;
    ms: TMemoryStream;
    ibcsql: TIBCSQL;
    ibcsqlPrice: TIBCSQL;
    trUpdate: TIBCTransaction;
    s: string;
    Response: IHTTPResponse;
    UrlArray: TArray<string>;
    p: string;
    GoodsNotFoundCount: integer;
begin
    ImageFileNameList := TStringList.Create;
    ImageFileNameList.Delimiter := ';';
    ibcsql := TIBCSQL.Create(nil);
    trUpdate := TIBCTransaction.Create(nil);

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    ibcsql.transaction := trUpdate;
    GoodsNotFoundCount := 0;
    var GoodsFound := 0;
    memo1.Lines.Clear;
    try
        if not trUpdate.Active then
            trUpdate.StartTransaction;

        cxProgressBar2.properties.Min := 0;
        cxProgressBar2.properties.Max := IBCQueryParseSupplierGoods.RecordCount;
        while not IBCQueryParseSupplierGoods.eof do
        begin
            GoodsID := GetGoodsID(IBCQueryParseSupplierGoods.FieldByName('goods_code').AsString, IBCQueryParseSupplierGoods.FieldByName('supplierid').AsInteger);
            if GoodsID = -1 then
            begin
                IBCQueryParseSupplierGoods.Next;
                inc(GoodsNotFoundCount);
                Memo2.Lines.Add(IBCQueryParseSupplierGoods.FieldByName('goods_code').AsString);
                Continue;
            end;

            ibcsqlPrice := TIBCSQL.Create(nil);
            try
                ibcsqlPrice.sql.text := 'Update ts_goods_foreign set price3 = :price3 where goodsid = :goodsid and customerid = :customerid';
                ibcsqlPrice.ParamByName('goodsid').AsInteger := GoodsID;
                ibcsqlPrice.ParamByName('customerid').AsInteger := IBCQueryParseSupplierGoods.FieldByName('supplierid').AsInteger;
                ibcsqlPrice.transaction := IBCTrLocal;
                ibcsqlPrice.Execute;
            finally
                ibcsqlPrice.Free;
            end;

            Application.ProcessMessages;

            s := IBCQueryParseSupplierGoods.FieldByName('images').AsString;
            UrlArray := s.Split([';']);
            ImageFileNameList.Clear;
            for p in UrlArray do
                ImageFileNameList.Add(p);

            dmdb.ExecuteQuery('delete from ts_goods_image where goodsid = :goodsid', [GoodsID]);

            ibcsql.AutoCommit := false;
            inc(GoodsFound);
            for var j := 0 to ImageFileNameList.Count - 1 do
            begin
                ms := TMemoryStream.Create;
                try
                    try
                        s := ImageFileNameList[j];
                        Response := NetHttpClient.Get(ImageFileNameList[j]);
                        if Response.StatusCode = 200 then
                        begin
                            var pngImage := TdxSmartImage.Create;
                            try
                                ms.LoadFromStream(Response.ContentStream);
                                ms.Position := 0;
                                cxImage1.Picture.LoadFromStream(ms);

                                var bitmap := TBitmap.Create;
                                try
                                    bitmap.Assign(cxImage1.Picture.Graphic);
                                    pngImage := TdxSmartImage.CreateFromBitmap(bitmap);
                                    var PNGImageStream := TMemoryStream.Create;
                                    try
                                        pngImage.SaveToStreamByCodec(PNGImageStream, TdxImageDataFormat.dxImagePng);
                                        PNGImageStream.Position := 0;
                                        PNGImageStream.SaveToFile('tmp.png');
                                    finally
                                        PNGImageStream.Free;
                                    end;
                                    application.ProcessMessages;
                                finally
                                    bitmap.Free;
                                end;
                            finally
                                pngImage.Free;
                            end;

                            ibcsql.sql.Clear;
                            ibcsql.sql.add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
                            ibcsql.sql.add('values (:goodsid, :image, :flg_need2recreate)');
                            ibcsql.Prepare;

                            ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
                            ibcsql.ParamByName('image').LoadFromFile('tmp.png', ftBlob);
                            ibcsql.ParamByName('flg_need2recreate').Asinteger := 1;
                            ibcsql.Execute;
                        end
                        else
                            memo1.lines.add('Bad response: ' + GoodsID.ToString + ';  Response code: ' + Response.StatusCode.ToString);
                    except
                        memo1.lines.add('Error on GoodsID: ' + GoodsID.ToString + ';  Path: ' + ImageFileNameList[j]);
                        Continue;
                    end;

                    Application.ProcessMessages;
                finally
                    ms.Free;
                end;
            end;
            cxProgressBar2.Position := IBCQueryParseSupplierGoods.RecNo;
            Memo1.Lines.Add('added images for goods: ' + GoodsID.ToString);
            Application.ProcessMessages;
            IBCQueryParseSupplierGoods.Next;
        end;
        trUpdate.Commit;
        Memo1.Lines.Add('Not linked goods: ' + GoodsNotFoundCount.ToString);
        Memo1.Lines.Add('UpdatedGoods: ' + GoodsFound.ToString);
    finally
        ibcsql.Free;
        trUpdate.Free;
        ImageFileNameList.Free;
    end;
end;

function Tframe119PernaMea.GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
var
    q: TIBCQuery;
begin
    q := TIBCQuery.Create(nil);
    try
        q.SQL.Text := 'select goodsid from ts_goods_foreign where customerid = :customerid and goods_code = :goods_code';
        q.ParamByName('goods_code').AsString := GoodsCode;
        q.ParamByName('customerid').AsInteger := SupplierID;
        q.Open;
    finally
        if q.RecordCount > 0 then
            Result := q.FieldByName('goodsid').AsInteger
        else
            Result := -1;
        q.Free;
    end;
end;

end.


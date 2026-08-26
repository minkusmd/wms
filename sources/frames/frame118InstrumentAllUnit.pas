unit frame118InstrumentAllUnit;
{
  »Õ¬≈Õ“¿–»«¿÷»ﬂ. »Ì‚ÂÌÚ‡ËÁ‡ˆËˇ
  DocTypeID = 1968
  Frame Index = 118
}

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNDataFiltering, SWNBaseFrameUnit, cxGraphics, cxControls, cxLookAndFeels,
    cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox,
    cxCurrencyEdit, cxLabel, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
    cxGridCustomView, cxGrid, cxSplitter, cxGridCustomPopupMenu, cxGridPopupMenu, dxBar, DBAccess, IBC, MemDS,
    cxGridBandedTableView, cxGridDBBandedTableView, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
    dxBarBuiltInMenu, dxDateRanges, dxSpreadSheetReportDesignerActions, dxSpreadSheetConditionalFormattingRulesActions,
    dxSpreadSheetActions, dxPrinting, System.Actions, Vcl.ActnList, dxActions, System.ImageList, Vcl.ImgList, cxImageList,
    dxScrollbarAnnotations, Vcl.StdCtrls, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
    Vcl.ExtActns, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON, Data.DBXJSON, cxContainer,
    cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalc, Vcl.Menus, cxButtons,
    cxPC, cxProgressBar, ApiAccentUnit, cxImage, Generics.Collections, cxCalendar, dxUIAClasses;

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

    Tframe118InstrumentAll = class(TSWNBaseFrame)
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
        procedure btnLoadImagesClick(Sender: TObject);
        procedure DoSyncSaveRecord(AIndex: integer);
    private
{ Private declarations }
//    fLastGoodsFolderID: Integer;
        myApiAccent: TApiAccent;
        ProductPropertiesList: TList<TProductPropertyRecord>;

        procedure GetImages;
        procedure ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
    protected    { Protected declarations }
        function InitFrameID: Integer; override;
        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;
        function GetFilterFields: TFrameFilterFields; override;
        function GetFrameButtons: TFrameButtons; override;
        procedure DeleteRecord; override;
        procedure PrepareData;
        procedure RefreshData; override;
        procedure SaveFrameStates; override;
        procedure ReadFrameStates; override;
        procedure SetupSecurityItems; override;
    public    { Public declarations }

        function GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
        procedure SetupDefaultFocus; override;
    end;

implementation

{$R *.dfm}

uses
    SWNSecurity, SWNSecurityFlags, DataModuleDB, SWNConst, SWNUtils, SWNDBErrors, DataModuleAdditions, SWNValueStorageUnit,
    IdFTP, Vcl.Imaging.pngimage, WebpHelpers, Winapi.GDIPOBJ, Vcl.Imaging.jpeg, System.IOUtils, libwebp, Vcl.Imaging.GIFImg,
    Vcl.WebpImage, Vcl.Clipbrd, dxGDIPlusClasses;

procedure Tframe118InstrumentAll.btnLoadImagesClick(Sender: TObject);
begin
    inherited;
    GetImages;
end;

procedure Tframe118InstrumentAll.DeleteRecord;
begin
end;

procedure Tframe118InstrumentAll.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    IBCQueryGoods.Close;
    IBCQueryParseSupplierGoods.Close;

    CloseExternalData;
//     // 1. De scos la griduri event handles for OnFocusedRecordChanged
//   cxGridDocsTable.OnFocusedRecordChanged := nil;

//
//     // 2. De deconectat sursele de date de la griduri
//   cxGridDocsTable.DataController.DataSource := nil;
//   cxGridInventDBTableView.DataController.DataSource := nil;

    inherited;
end;

procedure Tframe118InstrumentAll.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQueryParseSupplierGoods.Open;
end;

procedure Tframe118InstrumentAll.DoSyncSaveRecord(AIndex: integer);
begin
    cxProgressBar2.Position := AIndex;
end;

function Tframe118InstrumentAll.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [];
end;

function Tframe118InstrumentAll.GetFilterFields: TFrameFilterFields;
begin
    Result := [];
end;

function Tframe118InstrumentAll.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe118InstrumentAll.InitFrameID: Integer;
begin
    // Api InstrumentAll
    Result := 118
end;

procedure Tframe118InstrumentAll.ReadFrameStates;
begin
    AppUserConfigStorage.OpenSection(Self.Name);
    try
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe118InstrumentAll.RefreshData;
begin
    inherited;
    IBCQueryParseSupplierGoods.Refresh;
//     IBCQueryGoods.Refresh;
end;

procedure Tframe118InstrumentAll.SaveFrameStates;
begin
    try
        AppUserConfigStorage.OpenSection(Self.Name);
    finally
        AppUserConfigStorage.CloseSection;
    end;
end;

procedure Tframe118InstrumentAll.SetupDefaultFocus;
begin
    cxGrid3.SetFocus;
end;

procedure Tframe118InstrumentAll.SetupSecurityItems;
begin
//   fSECURITY_CanView := True;
//   fSECURITY_CanNew := True;
//   fSECURITY_CanEdit := True;
//   fSECURITY_CanDelete := True;
end;

procedure Tframe118InstrumentAll.GetImages;
var
    ImageFileNameList: TSTringlist;
    GoodsID: Integer;
    idFTP: TIdFTP;
    ms: TMemoryStream;
    ibcsql: TIBCSQL;
    trUpdate: TIBCTransaction;
    s: string;
    Response: IHTTPResponse;
    UrlArray: TArray<string>;
    p: string;
begin
    ImageFileNameList := TSTringList.Create;
    ImageFileNameList.Delimiter := ';';
    ibcsql := Tibcsql.Create(nil);
    trUpdate := TIBCTransaction.Create(nil);

    trUpdate.DefaultConnection := dmdb.IBCConnection;
    ibcsql.transaction := trUpdate;

    memo1.Lines.Clear;
//  ibcqueryImages.First;
    try

        trUpdate.StartTransaction;

        ibcsql.sql.add('insert into ts_goods_image (goodsid, image, flg_need2recreate)');
        ibcsql.sql.add('values (:goodsid, :image, :flg_need2recreate)');
        ibcsql.Prepare;


        while not IBCQueryParseSupplierGoods.eof do
        begin
            GoodsID := GetGoodsID(IBCQueryParseSupplierGoods.FieldByName('goods_code').AsString,
                                  IBCQueryParseSupplierGoods.FieldByName('supplierid').AsInteger);
            if GoodsID = -1 then
            begin
                IBCQueryParseSupplierGoods.Next;
                Continue;
            end;

            Application.ProcessMessages;


            s := IBCQueryParseSupplierGoods.FieldByName('images').AsString;
            UrlArray := s.Split([';']);
            ImageFileNameList.Clear;
            for p in urlArray do
                ImageFileNameList.Add(p);


//            ImageFileNameList.CommaText := s;

            dmdb.ExecuteQuery('delete from ts_goods_image where goodsid = :goodsid', [GoodsID]);

            ibcsql.AutoCommit := false;
            for var j := 0 to ImageFileNameList.Count - 1 do
            begin
                ms := TMemoryStream.Create;
                try
                    try
                        s := s.Replace(';', '', []);
                        Response := NetHttpClient.Get(ImageFileNameList[j]);
                        if Response.StatusCode = 200 then
                        begin
                            ms.LoadFromStream(Response.ContentStream);

                            ms.Position := 0;
                            cxImage1.Picture.LoadFromStream(ms);
                            if System.IOUtils.TPath.GetExtension(s) = '.jpg' then
                            begin
                                cxImage1.Picture.SaveToFile('tmp.jpg');
                                ConvertImageToPngEx('tmp.jpg', 'tmp.png');
                            end
                            else if System.IOUtils.TPath.GetExtension(s) = '.png' then
                                cxImage1.Picture.SaveToFile('tmp.png');

                            ibcsql.ParamByName('goodsid').AsInteger := GoodsID;
                            ibcsql.ParamByName('image').LoadFromFile('tmp.png', ftBlob);
                            ibcsql.ParamByName('flg_need2recreate').Asinteger := 1;
                            ibcsql.Execute;
                            Memo1.Lines.Add('added images for goods: '+Goodsid.ToString);
                        end;
                    except
                        memo1.lines.add('Error on GoodsID: ' + GoodsID.ToString + ';  Path: ' + ImageFileNameList[j]);
                        Continue;
                    end;

                    Application.ProcessMessages;
                finally
                    ms.Free;
                end;
            end;
            IBCQueryParseSupplierGoods.Next;
        end;
        trUpdate.Commit;
    finally
        ibcsql.Free;
        trUpdate.Free;
        ImageFileNameList.Free;
    end;
end;

procedure Tframe118InstrumentAll.ConvertImageToPNGEx(const ASourceFileName, ADestFileName: string);
var
    Image: TdxSmartImage;
    PNGImage: TPngImage;
//  MemoryStream: TMemoryStream;
begin
    Image := nil;
    PNGImage := nil;
//  MemoryStream := nil;

    try
    // Create appropriate TGraphic based on the file extension
        if SameText(ExtractFileExt(ASourceFileName), '.jpg') or SameText(ExtractFileExt(ASourceFileName), '.jpeg') then
            Image := TdxJPEGImage.Create
        else if SameText(ExtractFileExt(ASourceFileName), '.gif') then
            Image := TdxGIFImage.Create
//    else if SameText(ExtractFileExt(ASourceFileName), '.webp') then
//      Image := TWebPImage.Create
        else if SameText(ExtractFileExt(ASourceFileName), '.bmp') then
            Image := TdxBMPImage.Create
        else
            raise Exception.CreateFmt('Unsupported file extension: %s', [ExtractFileExt(ASourceFileName)]);

    // Load image from file
        Image.LoadFromFile(ASourceFileName);
    // Create PNG image and assign loaded image to it
        PNGImage := TPngImage.CreateBlank(COLOR_RGB, 8, Image.Width, Image.Height);
        PNGImage.Canvas.Draw(0, 0, Image);
        PNGImage.SaveToFile('tmp.png');
    // Save PNG image to file using a TMemoryStream
//    MemoryStream := TMemoryStream.Create;
//    PNGImage.SaveToStream(MemoryStream);
//    MemoryStream.SaveToFile(ADestFileName);
    finally
        Image.Free;
        PNGImage.Free;
//    MemoryStream.Free;
    end;
end;

function Tframe118InstrumentAll.GetGoodsID(GoodsCode: string; SupplierID: Integer): Integer;
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
    // TODO -cMM: Tframe118InstrumentAll.GetGoodsID default body inserted
end;

procedure Tframe118InstrumentAll.PrepareData;
begin
    IBCQueryParseSupplierGoods.Close;

//  if ckbNoImage.Checked then
//    ibcquerygoods.MacroByName('FlgNoImage').Value := ' and not exists (select * from ts_goods_image gi where gi.goodsid = GF.GoodsID)'
//  else
//    IBCQueryGoods.MacroByName('FlgNoImage').Value := '';
//
//  if ckbInPrice.Checked then
//    ibcquerygoods.MacroByName('FlgInPrice').Value := ' and get_flg_in_price(goodsid)=1'
//  else
//    IBCQueryGoods.MacroByName('FlgInPrice').Value := '';

    IBCQueryParseSupplierGoods.Open;

end;

end.


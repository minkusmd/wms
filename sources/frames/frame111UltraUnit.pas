unit frame111UltraUnit;

// Bomba.md Parser
// Frame Index = 111

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, System.UITypes, Dialogs, SWNDataFiltering,
    SWNBaseFrameUnit, cxGraphics, DB, cxDBData, cxGrid, dxBar, cxGridCustomPopupMenu, cxGridPopupMenu, Vcl.ExtCtrls, DBAccess,
    IBC, Vcl.StdCtrls, cxGridDBBandedTableView, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
    cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCheckBox, cxCurrencyEdit,
    cxLabel, dxBarBuiltInMenu, MemDS, cxClasses, cxGridBandedTableView, cxGridTableView, cxGridLevel, cxGridCustomTableView,
    cxGridDBTableView, cxGridCustomView, System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
    Vcl.Menus, cxButtons, MSHTML, cxContainer, Vcl.ComCtrls, dxUIAClasses;

type
    TProductDetailInfo = record
        cpf: string;
        DescriptionRo: string;
        Category: string;
        Brand: string;
        Model: string;
    end;

    Tframe111UltraMD = class(TSWNBaseFrame)
        IBCDataSourceAPI: TIBCDataSource;
        NetHTTPClient1: TNetHTTPClient;
        IBCSQL1: TIBCSQL;
        IBCtrLocalUpdate: TIBCTransaction;
        IBCSQLGoods: TIBCSQL;
        cxGridVolta: TcxGrid;
        cxGridVoltaDBTableView1: TcxGridDBTableView;
        cxGridVoltaDBTableView1GOODSID: TcxGridDBColumn;
        cxGridVoltaDBTableView1GOODS_CODE: TcxGridDBColumn;
        cxGridVoltaDBTableView1_GOODS_TITLE: TcxGridDBColumn;
        cxGridVoltaDBTableView1_FLG_IN_PRICE: TcxGridDBColumn;
        cxGridVoltaLevel1: TcxGridLevel;
        Panel1: TPanel;
        Memo1: TMemo;
        Panel2: TPanel;
        Label1: TLabel;
        IBCSQLDelete: TIBCSQL;
        cxButton2: TcxButton;
        Button1: TButton;
        IBCQueryAPI: TIBCQuery;
        ProgressBar1: TProgressBar;
        IBCQueryImages: TIBCQuery;
    sbGoodsImages: TStatusBar;
        procedure Button1Click(Sender: TObject);
        procedure cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    private    { Private declarations }
//    fSYS_Add, fSYS_Edit, fSYS_View, fSYS_Delete: Boolean;

        Doc: IHTMLDocument2;
//    d: HTMLLIElement;
        Body: OleVariant;

// TODO: WhenDocGrid_FocusedRecordChanged
//  procedure WhenDocGrid_FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
        procedure SelectionChanged;
        procedure SaveImagesToDB(var ImagesUrl: TStringList);
// TODO: SaveDescriptionToDB
//  procedure SaveDescriptionToDB(Parser: TVoltaParser; ProductDetailUrl: string);
        procedure DeleteCurrentImageFromDB(ImagesUrl: TStringList);
        procedure DoParseStep(AMessage: string);

    protected    { Protected declarations }
        function InitFrameID: Integer; override;

        function GetExternalDataSourceTypes: TFrameExternalDataSourceSet; override;
        procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
        procedure DoFrameHide; override;

        function GetFrameButtons: TFrameButtons; override;
        procedure RefreshData; override;

    public    { Public declarations }
        procedure deletecurrentimages(goodsid: Integer);
    end;

implementation

uses
    DataModuleDB, SWNUtils, SWNConst, DataModuleAdditions, SWNDBErrors, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags,
    frmCustomerCurrentDebtsDialog, frmCerereDePlataDialog, frmCerereDePlataDBDialog, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
    System.IOUtils, System.Variants, Winapi.ActiveX, frmVoltaParserUnit, Vcl.WebpImage, Winapi.GDIPOBJ, WebpHelpers, libwebp,
    uLoadProductImages;

{$R *.dfm}

const
     // numarul de ordine atribuit imaginilor al caror nume nu respecta conventia "<cod>_<nr>.<ext>"
    cUnknownImageIndex = 99999;
     // numarul de ordine al imaginii principale (MAINIMAGE din TAPI_ULTRA_NOMENCLATURE)
    cMainImageIndex = 0;
     // nici un produs nu are galerii mai mari de atat; peste acest prag numarul din nume
     // este de fapt un articol/cod, nu o pozitie in galerie (ex. "428032.jpg")
    cMaxGalleryImageIndex = 200;
     // cheia de sortare: 5 cifre (nr. imaginii) + '|' + 1 cifra (preferinta de format) + '|' + URL
    cImageSortKeyPrefixLen = 8;

// Ultra.md nu trimite un numar de ordine separat pentru imagini, dar numele fisierului are
// forma "<cod>_<nr>.<ext>", unde <nr> este pozitia imaginii in galeria furnizorului
// (1 = imaginea principala). Pentru o parte din produse (~2450) numele este doar numarul,
// fara prefixul cu codul ("1.png", "10.png") - si acesta trebuie recunoscut, altfel toate
// imaginile primesc cUnknownImageIndex si galeria ajunge sortata alfabetic dupa URL (UUID).
function GetImageIndexFromName(const AName: string): Integer;
var
    P, Idx: Integer;
    S: string;
begin
    Result := cUnknownImageIndex;
    S := ChangeFileExt(Trim(AName), '');
    P := LastDelimiter('_', S);
    if P > 0 then
    begin
        if TryStrToInt(Copy(S, P + 1, MaxInt), Idx) then
            if (Idx > 0) and (Idx < cUnknownImageIndex) then
                Result := Idx;
    end
    else if TryStrToInt(S, Idx) then
        if (Idx > 0) and (Idx <= cMaxGalleryImageIndex) then
            Result := Idx;
end;

// acelasi cadru vine si ca .png si ca .jpg - preferam .png (se salveaza direct, fara reconversie)
function GetImageFormatRank(const AUrl: string): Integer;
var
    Ext: string;
begin
    Ext := LowerCase(TPath.GetExtension(AUrl));
    if Ext = '.png' then
        Result := 0
    else if (Ext = '.jpg') or (Ext = '.jpeg') then
        Result := 1
    else if Ext = '.webp' then
        Result := 2
    else
        Result := 3;
end;

// AIsMain = randul indicat de TAPI_ULTRA_NOMENCLATURE.MAINIMAGE; are prioritate absoluta,
// pentru ca numele fisierului nu este intotdeauna un numar de ordine ("download (1).jpg")
function BuildImageSortKey(const AName, AUrl: string; AIsMain: Boolean): string;
var
    Idx: Integer;
begin
    if AIsMain then
        Idx := cMainImageIndex
    else
        Idx := GetImageIndexFromName(AName);
    Result := Format('%.5d|%d|%s', [Idx, GetImageFormatRank(AUrl), AUrl]);
end;

function GetImageIndexFromSortKey(const AKey: string): Integer;
begin
    Result := StrToIntDef(Copy(AKey, 1, 5), cUnknownImageIndex);
end;

function GetImageUrlFromSortKey(const AKey: string): string;
begin
    Result := Copy(AKey, cImageSortKeyPrefixLen + 1, MaxInt);
end;

procedure Tframe111UltraMD.Button1Click(Sender: TObject);
var
    fs: TFileStream;
    ms: TMemoryStream;
    bmp: TGPBitMap;
    dat: PByte;
    bmpImage: TbitMap;
    ImageURLs: TStringlist;
    SortedImages: TStringList;
    I, ImageIndex, LastImageIndex: Integer;
    ImageUrl, MainImageUuid: string;
begin
    IBCQueryAPI.Open;
    Application.ProcessMessages;
    ImageURLs := TStringlist.Create;
    SortedImages := TStringList.Create;
     // cheile identice (aceeasi imagine trimisa de doua ori) se ignora automat
    SortedImages.Sorted := True;
    SortedImages.Duplicates := dupIgnore;
    try
        ProgressBar1.Min := 0;
        ibcqueryapi.FetchAll := true;
        ProgressBar1.Max := ibcqueryapi.RecordCount - 1;
        var GoodsCount: integer := 0;
        sbGoodsImages.SimpleText := format('produse noi cu imagini: %d', [GoodsCount]);
        while not IBCQueryAPI.Eof do
        begin
            ibcqueryImages.Close;
            ibcqueryImages.ParamByName('uuid').AsString := IBCQueryAPI.FieldByName('uuid').AsString;
            ibcqueryImages.Open;
            ProgressBar1.Position := ibcqueryapi.RecNo;
            var foundImage : Boolean := false;
//            foundImage := false;
            if ibcqueryimages.recordcount>0 then
                deletecurrentimages(ibcqueryapi.FieldByName('goodsid').AsInteger);

             // TAPI_ULTRA_IMAGES nu are coloana de ordine, iar randurile vin in ordinea fizica
             // din baza (amestecata). Imaginile trebuie salvate in ordinea furnizorului, pentru ca
             // trigger-ul TRG_TS_GOODS_IMAGE_BI0 atribuie ORDERNO = MAX+1 la fiecare insert, iar
             // catalogul si pagina produsului iau imaginea principala dupa cel mai mic ORDERNO.
            SortedImages.Clear;
            MainImageUuid := Trim(IBCQueryAPI.FieldByName('MAINIMAGE').AsString);
            while not IbcQueryImages.Eof do
            begin
                SortedImages.Add(BuildImageSortKey(IBCQueryImages.FieldByName('NAME').AsString,
                    IBCQueryImages.FieldByName('PATHGLOBAL').AsString,
                    (MainImageUuid <> '') and
                    SameText(MainImageUuid, Trim(IBCQueryImages.FieldByName('UUID').AsString))));
                IBCQueryImages.Next;
            end;

            LastImageIndex := -1;
            for I := 0 to SortedImages.Count - 1 do
            begin
                ImageIndex := GetImageIndexFromSortKey(SortedImages[I]);
                 // acelasi cadru vine in mai multe formate (png/jpg) - pastram o singura varianta
                 // pentru fiecare numar de ordine, altfel galeria se dubleaza
                if (ImageIndex <> cUnknownImageIndex) and (ImageIndex = LastImageIndex) then
                    Continue;
                LastImageIndex := ImageIndex;

                ImageUrl := GetImageUrlFromSortKey(SortedImages[I]);
                Memo1.Lines.Add(ibcqueryapi.FieldByName('goodsid').AsString + ' ' + ImageUrl);
                ImageURLs.Text := ImageUrl;
                SaveImagesToDB(ImageURLs);
                FoundImage := True;
            end;

            if foundimage then
            begin
              inc(GoodsCount);
              sbGoodsImages.SimpleText := format('produse noi cu imagini: %d', [GoodsCount]);
              application.ProcessMessages;
            end;

            Application.ProcessMessages;
            ibcqueryAPI.Next;
        end;
    finally
        SortedImages.Free;
        ImageURLs.Free;
    end;
end;

procedure Tframe111UltraMD.DoParseStep(AMessage: string);
begin
    Memo1.Lines.Add(AMessage);
end;

procedure Tframe111UltraMD.cxGridVoltaDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    SWNUtils.ProcessCommonKeys(Self, cxGridVoltaDBTableView1, Key, Shift);
end;

procedure Tframe111UltraMD.DoFrameHide;
begin
     // inchidem sursele de date externe conform "GetExternalDataSourceTypes"
    CloseExternalData;
    IBCQueryAPI.Close;

    inherited;
end;

procedure Tframe111UltraMD.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;

     // 1. Legam grid-urile de datasource-sele

    IBCQueryAPI.Open;
     // 3. deschidem sursele de date externe conform "GetExternalDataSourceTypes"
    OpenExternalData(FrameDataFilterInfo);
    Memo1.Lines.Clear;

     // 4. Selection update
    SelectionChanged;
end;

function Tframe111UltraMD.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin
    Result := [fedsNONE];
end;

function Tframe111UltraMD.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe111UltraMD.InitFrameID: Integer;
begin
    Result := 111;
end;

procedure Tframe111UltraMD.DeleteCurrentImageFromDB(ImagesUrl: TStringList);
begin
//  if (cbUpdateAllImages.Checked and (ImagesUrl.Count - 1 > 0)) then begin
//    // daca sunt imagini pe site atunci stergem imaginile locale
//    Memo1.Lines.Add('delete current images...');
//    if not IBCSQLDelete.Transaction.Active then
//      IBCSQLDelete.Transaction.StartTransaction;
//    ibcsqldelete.SQL.Text := 'delete from ts_goods_image where goodsid = :goodsid';
//    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
//    ibcsqlDelete.Execute;
//    ibcsqldelete.SQL.Text := 'delete from ts_goods_dsc where goodsid = :goodsid';
//    ibcsqldelete.ParamByName('goodsid').AsInteger := ibcquery1.FieldByName('goodsid').AsInteger;
//    ibcsqlDelete.Execute;
//    ibcsqlDelete.Transaction.Commit;
//  end;
end;

procedure Tframe111UltraMD.deletecurrentimages(goodsid: Integer);
begin
    dmdb.ExecuteQuery('delete from ts_goods_image where goodsid = :goodsid', [Goodsid]);
end;

// TODO: SaveDescriptionToDB
//procedure Tframe110BombaAPI.SaveDescriptionToDB(Parser: TVoltaParser; ProductDetailUrl: string);
//begin
//if ProductDetailUrl <> '' then
//begin
//  Parser.DoParseDetailPageRO(ProductDetailUrl);
//  ProductDetailUrl := StringReplace(ProductDetailUrl, 'https://volta.md', 'https://volta.md/ru', []);
//  Parser.DoParseDetailPageRU(ProductDetailUrl);
//  if (Trim(Parser.DescriptionRo) <> '') then
//  begin
//    if not IBCtrLocalUpdate.Active then
//      IBCtrLocalUpdate.StartTransaction;
//    try
//      IBCSQLGoods.ParamByName('GOODSID').AsInteger := IBCQuery1.FieldByName('GOODSID').AsInteger;
//      IBCSQLGoods.ParamByName('DESCRIPTION_RO').AsString := UTF8ToString(Parser.DescriptionRO);
//      IBCSQLGoods.ParamByName('DESCRIPTION_RU').AsString := UTF8ToString(Parser.DescriptionRU);
//      Memo1.Lines.Add('Add descriptions...');
//      IBCSQLGoods.Execute;
//      IBCtrLocalUpdate.Commit;
//    except
//      IBCtrLocalUpdate.Rollback;
//    end;
//  end;
//end
//else
//  Memo1.Lines.Add('Product: ' + IBCQuery1.FieldByName('GOODS_CODE').AsString + ' not found on www.volta.md...');
//end;

procedure Tframe111UltraMD.SaveImagesToDB(var ImagesUrl: TStringList);
var
    I: Integer;
    pngImage: TPngImage;
    jpegImage: TJPEGImage;
//  webpImage: TWebpImage;
    imgExt: string;
    dat: PByte;
    bmp: TGPBitmap;
    bmpImage: TBitmap;
    ImageStream: TMemoryStream;
begin
    for I := 0 to ImagesUrl.Count - 1 do
    begin
    // convert image to png
        ImageStream := TMemoryStream.Create;
        pngImage := TPngImage.Create;
        jpegImage := TJPEGImage.Create;
//    webpImage := TWebpImage.Create(Panel2);
    //
        try
            if ImagesUrl[I] <> '' then
            begin
                NetHTTPClient1.Get(ImagesUrl[I], ImageStream);
                Application.ProcessMessages;
                ImageStream.Position := 0;
                imgExt := TPath.GetExtension(ImagesUrl[I]).tolower;
                 // format necunoscut: fara acest test s-ar insera "tmp.png" ramas de la imaginea
                 // precedenta, adica o imagine complet straina de produs
                if (imgExt <> '.jpeg') and (imgExt <> '.jpg') and (imgExt <> '.png') and (imgExt <> '.webp') then
                    Continue;
                 // pornim de la zero, ca un tmp.png vechi sa nu ajunga in baza daca conversia esueaza
                DeleteFile('tmp.png');

                if (imgExt = '.jpeg') or (imgExt = '.jpg') then
                begin
                    try
                        ImageStream.SaveToFile('tmp.jpeg');
                        jpegImage.loadfromFile('tmp.jpeg');
                    except
                        on e: Exception do
                        begin
                            Continue;
                        end;
                    end;
                end;
                if imgExt = '.png' then
                begin
                     // o imagine corupta nu trebuie sa opreasca tot importul
                    try
                        ImageStream.SaveToFile('tmp.png');
                        pngImage.loadfromFile('tmp.png');
                    except
                        on e: Exception do
                        begin
                            Continue;
                        end;
                    end;
                end;
                if imgExt = '.webp' then
                begin
                    try
                        ImageStream.SaveToFile('tmp.webp');
                        WebpDecode(ImageStream, dat, bmp);
                        try
                            bmp.Save('tmp.png', gPNG);
                        finally
                            bmp.Free;
                            WebPFree(dat);
                        end;
                    except
                        on e: Exception do
                        begin
                            Continue;
                        end;
                    end;
                end;
                bmpImage := TBitMap.Create;
                try
                    bmpImage.Assign(jpegImage);
                    try
                        if (imgExt = '.jpeg') or (imgExt = '.jpg') then
                        begin
                            pngImage.Assign(bmpImage);
                            pngImage.SaveToFile('tmp.png');
                        end;
                    except
                    end;
                finally
                    bmpImage.Free;
                end;
                if not IBCtrLocalUpdate.Active then
                    IBCtrLocalUpdate.StartTransaction;
                try
                    IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQueryApi.FieldByName('GOODSID').ASInteger;
                    IBCSQL1.ParamByName('IMAGE').LoadFromFile('tmp.png', ftBlob);
                    IBCSQL1.Execute;
                    IBCtrLocalUpdate.Commit;
                    DeleteFile('tmp.png');
                except
                    IBCtrLocalUpdate.Rollback;
                end;
            end;
        finally
            ImageStream.Free;
            FreeAndNil(jpegImage);
            FreeAndNil(pngImage);
        end;
    end;
end;

procedure Tframe111UltraMD.RefreshData;
begin
    inherited;
    IBCQueryAPI.Refresh;
end;

procedure Tframe111UltraMD.SelectionChanged;
var
    fCloseDoc, fOpenDoc, fCalcComs: Boolean;
begin
    ButtonStateChanged(fbtADD, false);
    ButtonStateChanged(fbtMODIFY, false);
    ButtonStateChanged(fbtDELETE, false);
end;

end.


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

     // descarca o singura imagine intr-un thread separat. Octetii bruti raman in FData pana cand
     // thread-ul principal ii preia prin ExtractData; la eroare FData devine nil si mesajul
     // ajunge in ErrorMessage. Fiecare thread are propriul THTTPClient, pentru ca o instanta
     // nu suporta cereri concurente.
    TImageDownloadThread = class(TThread)
    private
        FUrl: string;
        FData: TMemoryStream;
        FErrorMessage: string;
    protected
        procedure Execute; override;
    public
        constructor Create(const AUrl: string);
        destructor Destroy; override;
        function ExtractData: TMemoryStream;
        property Url: string read FUrl;
        property ErrorMessage: string read FErrorMessage;
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
        procedure DownloadImages(AImagesUrl: TStrings; var AImages: TArray<TMemoryStream>);
        function SaveImagesToDB(AImagesUrl: TStrings): Integer;
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
    uLoadProductImages, System.Generics.Collections;

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
     // cate imagini ale aceluiasi produs se descarca simultan (un thread per imagine)
    cMaxParallelImageDownloads = 8;
     // pauza dintre doua verificari ale thread-urilor de descarcare, in thread-ul principal
    cDownloadPollIntervalMs = 20;
    cHttpConnectionTimeoutMs = 15000;
    cHttpResponseTimeoutMs = 60000;

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

// format necunoscut: nu se descarca deloc - fara acest test in baza ar putea ajunge
// o imagine straina de produs
function IsSupportedImageUrl(const AUrl: string): Boolean;
var
    Ext: string;
begin
    Ext := LowerCase(TPath.GetExtension(AUrl));
    Result := (Ext = '.jpeg') or (Ext = '.jpg') or (Ext = '.png') or (Ext = '.webp');
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

// converteste octetii descarcati (png/jpg/webp) in PNG, in memorie. False = format
// neacceptat sau imagine corupta - o imagine stricata nu trebuie sa opreasca tot importul.
// Ruleaza in thread-ul principal: TBitmap/TJPEGImage nu sunt sigure in thread-uri secundare
// fara blocarea canvas-ului.
function ConvertImageToPng(ASource: TMemoryStream; const AExt: string; ADest: TMemoryStream): Boolean;
var
    PngImage: TPngImage;
    JpegImage: TJPEGImage;
    BmpImage: TBitmap;
    GpBitmap: TGPBitmap;
    Dat: PByte;
begin
    Result := False;
    ADest.Clear;
    ASource.Position := 0;
    try
        if AExt = '.png' then
        begin
             // doar validare - un PNG valid se salveaza asa cum a venit, fara reconversie
            PngImage := TPngImage.Create;
            try
                PngImage.LoadFromStream(ASource);
            finally
                PngImage.Free;
            end;
            ASource.Position := 0;
            ADest.CopyFrom(ASource, 0);
        end
        else if (AExt = '.jpg') or (AExt = '.jpeg') then
        begin
            JpegImage := TJPEGImage.Create;
            BmpImage := TBitmap.Create;
            PngImage := TPngImage.Create;
            try
                JpegImage.LoadFromStream(ASource);
                BmpImage.Assign(JpegImage);
                PngImage.Assign(BmpImage);
                PngImage.SaveToStream(ADest);
            finally
                PngImage.Free;
                BmpImage.Free;
                JpegImage.Free;
            end;
        end
        else if AExt = '.webp' then
        begin
            WebpDecode(ASource, Dat, GpBitmap);
            try
                GpBitmap.Save(TStreamAdapter.Create(ADest, soReference) as IStream, gPNG);
            finally
                GpBitmap.Free;
                WebPFree(Dat);
            end;
        end
        else
            Exit;
        Result := ADest.Size > 0;
    except
        on E: Exception do
            Result := False;
    end;
    ADest.Position := 0;
end;

{ TImageDownloadThread }

constructor TImageDownloadThread.Create(const AUrl: string);
begin
    inherited Create(True);
    FUrl := AUrl;
    FData := TMemoryStream.Create;
end;

destructor TImageDownloadThread.Destroy;
begin
    FData.Free;
    inherited;
end;

function TImageDownloadThread.ExtractData: TMemoryStream;
begin
    Result := FData;
    FData := nil;
end;

procedure TImageDownloadThread.Execute;
var
    Http: THTTPClient;
    Response: IHTTPResponse;
begin
    Http := THTTPClient.Create;
    try
        Http.ConnectionTimeout := cHttpConnectionTimeoutMs;
        Http.ResponseTimeout := cHttpResponseTimeoutMs;
        try
            Response := Http.Get(FUrl, FData);
            if Response.StatusCode <> 200 then
                FErrorMessage := Format('HTTP %d %s', [Response.StatusCode, Response.StatusText])
            else if FData.Size = 0 then
                FErrorMessage := 'raspuns gol';
        except
            on E: Exception do
                FErrorMessage := E.Message;
        end;
        if FErrorMessage <> '' then
            FreeAndNil(FData)
        else
            FData.Position := 0;
    finally
        Http.Free;
    end;
end;

{ Tframe111UltraMD }

procedure Tframe111UltraMD.Button1Click(Sender: TObject);
var
    ImageURLs: TStringlist;
    SortedImages: TStringList;
    I, ImageIndex, LastImageIndex: Integer;
    ImageUrl, MainImageUuid: string;
begin
     // importul pompeaza mesajele cat asteapta thread-urile - un al doilea click ar porni
     // un import paralel peste primul
    Button1.Enabled := False;
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

            ImageURLs.Clear;
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
                if IsSupportedImageUrl(ImageUrl) then
                    ImageURLs.Add(ImageUrl);
            end;

             // toate imaginile produsului se descarca in paralel, apoi se salveaza in ordine
            if SaveImagesToDB(ImageURLs) > 0 then
            begin
                inc(GoodsCount);
                sbGoodsImages.SimpleText := format('produse noi cu imagini: %d', [GoodsCount]);
            end;

            Application.ProcessMessages;
            ibcqueryAPI.Next;
        end;
    finally
        SortedImages.Free;
        ImageURLs.Free;
        Button1.Enabled := True;
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

// descarca in paralel toate imaginile din AImagesUrl - un TImageDownloadThread per imagine,
// cel mult cMaxParallelImageDownloads active simultan. AImages[I] corespunde lui AImagesUrl[I];
// nil = descarcarea a esuat (motivul ajunge in Memo1). Apelantul elibereaza stream-urile.
// Thread-ul principal nu se blocheaza in WaitFor, ci pompeaza mesajele cat timp asteapta,
// ca progresul si memo-ul sa se actualizeze.
procedure Tframe111UltraMD.DownloadImages(AImagesUrl: TStrings; var AImages: TArray<TMemoryStream>);
var
    Threads: TObjectList<TImageDownloadThread>;
    I, NextToStart, Running: Integer;
begin
    SetLength(AImages, AImagesUrl.Count);
    Threads := TObjectList<TImageDownloadThread>.Create(True);
    try
        for I := 0 to AImagesUrl.Count - 1 do
            Threads.Add(TImageDownloadThread.Create(AImagesUrl[I]));

        NextToStart := 0;
        repeat
            Running := 0;
            for I := 0 to NextToStart - 1 do
                if not Threads[I].Finished then
                    Inc(Running);
            while (Running < cMaxParallelImageDownloads) and (NextToStart < Threads.Count) do
            begin
                Threads[NextToStart].Start;
                Inc(NextToStart);
                Inc(Running);
            end;
            if (NextToStart = Threads.Count) and (Running = 0) then
                Break;
            Application.ProcessMessages;
            Sleep(cDownloadPollIntervalMs);
        until False;

        for I := 0 to Threads.Count - 1 do
        begin
             // Finished se seteaza inainte ca thread-ul sa se incheie de tot; WaitFor garanteaza
             // ca nu mai atinge FData cand il preluam
            Threads[I].WaitFor;
            AImages[I] := Threads[I].ExtractData;
            if Threads[I].ErrorMessage <> '' then
                Memo1.Lines.Add(Format('  eroare descarcare %s: %s', [Threads[I].Url, Threads[I].ErrorMessage]));
        end;
    finally
        Threads.Free;
    end;
end;

// descarca toate imaginile produsului curent in paralel, apoi le converteste in PNG si le
// insereaza secvential, in ordinea din AImagesUrl - ordinea conteaza, pentru ca trigger-ul
// TRG_TS_GOODS_IMAGE_BI0 atribuie ORDERNO = MAX+1 la fiecare insert. Conversia si insert-ul
// raman in thread-ul principal: conexiunea IBDAC nu se imparte intre thread-uri.
// Returneaza numarul de imagini salvate.
function Tframe111UltraMD.SaveImagesToDB(AImagesUrl: TStrings): Integer;
var
    I: Integer;
    Images: TArray<TMemoryStream>;
    PngStream: TMemoryStream;
    ImgExt: string;
begin
    Result := 0;
    if AImagesUrl.Count = 0 then
        Exit;

    DownloadImages(AImagesUrl, Images);
    PngStream := TMemoryStream.Create;
    try
        for I := 0 to AImagesUrl.Count - 1 do
        begin
            if Images[I] = nil then
                Continue;
            ImgExt := LowerCase(TPath.GetExtension(AImagesUrl[I]));
            if not ConvertImageToPng(Images[I], ImgExt, PngStream) then
            begin
                Memo1.Lines.Add(Format('  imagine ignorata (corupta sau format necunoscut): %s', [AImagesUrl[I]]));
                Continue;
            end;

            if not IBCtrLocalUpdate.Active then
                IBCtrLocalUpdate.StartTransaction;
            try
                IBCSQL1.ParamByName('GOODSID').AsInteger := IBCQueryApi.FieldByName('GOODSID').ASInteger;
                IBCSQL1.ParamByName('IMAGE').LoadFromStream(PngStream, ftBlob);
                IBCSQL1.Execute;
                IBCtrLocalUpdate.Commit;
                Inc(Result);
            except
                on E: Exception do
                begin
                    IBCtrLocalUpdate.Rollback;
                    Memo1.Lines.Add(Format('  eroare la salvare %s: %s', [AImagesUrl[I], E.Message]));
                end;
            end;
        end;
    finally
        PngStream.Free;
        for I := 0 to High(Images) do
            Images[I].Free;
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

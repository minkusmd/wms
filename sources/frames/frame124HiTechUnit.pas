unit frame124HiTechUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    SWNBaseFrameUnit, SWNDataFiltering, cxGraphics, dxUIAClasses, cxControls,
    cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
    cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
    dxScrollbarAnnotations, Data.DB, cxDBData, cxGridCustomTableView,
    cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
    cxGrid, DBAccess, IBC, MemDS, Vcl.Menus, Vcl.StdCtrls, cxButtons,
    cxContainer, cxImage, Vcl.ExtCtrls, cxTextEdit, cxMemo;

type
    Tframe124HiTech = class(TSWNBaseFrame)
        IBCQuerySupplierGoods: TIBCQuery;
        IBCDataSourceSupplierGoods: TIBCDataSource;
        cxGrid1DBTableView1: TcxGridDBTableView;
        cxGrid1Level1: TcxGridLevel;
        cxGrid1: TcxGrid;
        cxGrid1DBTableView1GOODS_CODE: TcxGridDBColumn;
        cxGrid1DBTableView1GOODSID: TcxGridDBColumn;
        cxButton1: TcxButton;
        cxImage1: TcxImage;
        cxGrid1DBTableView1GOODS_TITLE: TcxGridDBColumn;
        cxMemo1: TcxMemo;
        btnSyncPrices: TcxButton;
        procedure cxButton1Click(Sender: TObject);
        procedure btnSyncPricesClick(Sender: TObject);

    private
        procedure Log(const AMessage: string); overload;
        procedure Log(const AFormat: string; const AArgs: array of const); overload;

    protected
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
    end;

implementation

uses
    System.UITypes, DataModuleDB, HiTechScraperUnit, ParseImagesHiTechUnit, SupplierPriceSyncUnit,
    HiTechPriceSourceUnit;

{$R *.dfm}

const
    cRequestDelayMs = 250; // pauza intre produse, ca sa nu incarcam site-ul

{ Tframe124HiTech }

procedure Tframe124HiTech.Log(const AMessage: string);
begin
    cxMemo1.Lines.Add(AMessage);
end;

procedure Tframe124HiTech.Log(const AFormat: string; const AArgs: array of const);
begin
    Log(Format(AFormat, AArgs));
end;

procedure Tframe124HiTech.cxButton1Click(Sender: TObject);
var
    Loader: TParseHiTechProductImages;
    Product: TProductInfo;
    GoodsCode: string;
    GoodsID: Integer;
    Saved, NotFound, Failed: Integer;
begin
    Saved := 0;
    NotFound := 0;
    Failed := 0;
    cxMemo1.Lines.Clear;
    cxButton1.Enabled := False;
    Loader := TParseHiTechProductImages.Create(dmDB.IBCConnection);
    try
        IBCQuerySupplierGoods.First;
        while not IBCQuerySupplierGoods.Eof do
        begin
            GoodsCode := IBCQuerySupplierGoods.FieldByName('GOODS_CODE').AsString.Trim;
            GoodsID := IBCQuerySupplierGoods.FieldByName('GOODSID').AsInteger;
            try
                if Loader.LoadImage(GoodsID, GoodsCode, Product) then
                begin
                    Inc(Saved);
                    cxImage1.Picture.LoadFromStream(Loader.LastImage);
                    Log('OK %s (%d): %s, %s', [GoodsCode, GoodsID, Product.Title, Product.Price]);
                end
                else
                begin
                    Inc(NotFound);
                    Log('Nicio poza gasita pentru %s (%d)', [GoodsCode, GoodsID]);
                end;
            except
                on E: Exception do
                begin
                    Inc(Failed);
                    Log('Eroare la %s (%d): %s', [GoodsCode, GoodsID, E.Message]);
                end;
            end;
            IBCQuerySupplierGoods.Next;
            Application.ProcessMessages;
            Sleep(cRequestDelayMs);
        end;
        Log('');
        Log('Gata: %d poze salvate, %d negasite, %d erori.', [Saved, NotFound, Failed]);
    finally
        Loader.Free;
        cxButton1.Enabled := True;
    end;
    RefreshData;
end;

// Rularea manuala a sincronizarii zilnice de preturi (aceeasi logica o ruleaza
// WMSParsers.exe /auto din Task Scheduler - proiectul Parsers\): pentru articolele active,
// PRICE3 = pretul de pe h-t.md - RRP_DISCOUNT al furnizorului, scris direct in TS_GOODS_FOREIGN.
procedure Tframe124HiTech.btnSyncPricesClick(Sender: TObject);
var
    Sync: TSupplierPriceSync;
begin
    if MessageDlg('Se verifica preturile de pe h-t.md pentru articolele active si se actualizeaza PRICE3 in TS_GOODS_FOREIGN.' +
        sLineBreak + 'Dureaza citeva minute. Continuati?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
        Exit;
    cxMemo1.Lines.Clear;
    btnSyncPrices.Enabled := False;
    cxButton1.Enabled := False;
    Sync := TSupplierPriceSync.Create(dmDB.IBCConnection, THiTechPriceSource, dmDB.CurrentFirma);
    try
        Sync.OnLog :=
            procedure(const AMessage: string)
            begin
                Log(AMessage);
            end;
        try
            Sync.Run;
        except
            on E: Exception do
                Log('EROARE: %s', [E.Message]);
        end;
    finally
        Sync.Free;
        btnSyncPrices.Enabled := True;
        cxButton1.Enabled := True;
    end;
end;

procedure Tframe124HiTech.DeleteRecord;
begin
    inherited;

end;

procedure Tframe124HiTech.DoFrameHide;
begin
    inherited;
    IBCQuerySupplierGoods.Close;
end;

procedure Tframe124HiTech.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
    inherited;
    IBCQuerySupplierGoods.open;
end;

function Tframe124HiTech.GetExternalDataSourceTypes: TFrameExternalDataSourceSet;
begin

end;

function Tframe124HiTech.GetFilterFields: TFrameFilterFields;
begin

end;

function Tframe124HiTech.GetFrameButtons: TFrameButtons;
begin
    Result := [fbtREFRESH];
end;

function Tframe124HiTech.InitFrameID: Integer;
begin
    Result := 124;
end;

procedure Tframe124HiTech.PrepareData;
begin

end;

procedure Tframe124HiTech.ReadFrameStates;
begin
    inherited;

end;

procedure Tframe124HiTech.RefreshData;
begin
    IBCQuerySupplierGoods.Refresh;
end;

procedure Tframe124HiTech.SaveFrameStates;
begin
    inherited;

end;

end.

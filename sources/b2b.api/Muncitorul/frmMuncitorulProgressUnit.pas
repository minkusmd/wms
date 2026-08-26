unit frmMuncitorulProgressUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxActivityIndicator,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Muncitorul.Data;

type
  TfrmMuncitorulProgressDlg = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dxActivityIndicator1: TdxActivityIndicator;
    DsFeatures: TDataSource;
    DsImages: TDataSource;
    DsProducts: TDataSource;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDTrUpdate: TFDTransaction;
    FDTrSelect: TFDTransaction;
    FDConnection1: TFDConnection;
    lbTime: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FData: TMuncitorulData;
    FDownloadTime: Int64;
    FLoadTime: Int64;
    FJson: TStringList;
    FPLID: Integer;
    FPriceCategoryID: Integer;
    procedure FetchJsonToMemo;
    procedure ParseJsonFromMemoAndLoadDataSets;
    procedure AddToPriceListItems(Sender: TObject);
    function DownloadImage(ImageUrl: string): string;
    procedure SetPriceCategoryID(const Value: Integer);
    procedure UpsertImage(PLID: Integer; GoodsCode: string);
    procedure SaveImage(GoodsID: Integer; Stream: TMemoryStream);
    function DownloadImageStream(const ImageUrl: string): TMemoryStream;
    { Private declarations }
  public
    property PLID: Integer read FPLID write FPLID;
    property PriceCategoryID: Integer read FPriceCategoryID write
        SetPriceCategoryID;
    { Public declarations }
  end;

var
  frmMuncitorulProgressDlg: TfrmMuncitorulProgressDlg;

implementation

uses
  System.Diagnostics,
  System.IOUtils,
  System.Net.HttpClient;


{$R *.dfm}

procedure TfrmMuncitorulProgressDlg.FormDestroy(Sender: TObject);
begin
  FJson.Free;
  FData.Free;
end;

procedure TfrmMuncitorulProgressDlg.FormCreate(Sender: TObject);
begin
  FDConnection1.Connected := True;
  fJSon := TStringList.Create;
end;

procedure TfrmMuncitorulProgressDlg.FormShow(Sender: TObject);
var
  LTotalWatch: TStopwatch;
  LTotalTime: Int64;
begin
  // Ensure FData is created (it should be by FormCreate)
  Application.ProcessMessages;

  if not Assigned(FData) then
    FData := TMuncitorulData.Create;

  Application.ProcessMessages;

  LTotalWatch := TStopwatch.StartNew;

  { --- STEP 1: Get JSON and put it into MemoJson --- }
  // We pass the state of the checkbox to the method.
  FetchJsonToMemo;
  Application.ProcessMessages;

  { --- STEP 2: Parse JSON from Memo and load datasets --- }
  ParseJsonFromMemoAndLoadDataSets;
  Application.ProcessMessages;

  { Stop total timer }
  LTotalWatch.Stop;
  LTotalTime := LTotalWatch.ElapsedMilliseconds;

  { Afișăm timpii }
  // FDownloadTime and FLoadTime are set by the helper methods
  lbTime.Caption := Format('Acquire JSON: %d ms' + sLineBreak + 'Load JSON: %d ms' + sLineBreak + 'Total: %d ms', [FDownloadTime,
    FLoadTime, LTotalTime]);

  AddToPriceListItems(Sender);
  Close;
end;

procedure TfrmMuncitorulProgressDlg.FetchJsonToMemo;
var
  LWatch: TStopwatch;
  LDebugFile: string;
begin
  Assert(Assigned(FData), 'FData instance is missing in FetchJsonToMemo.');

  LWatch := TStopwatch.StartNew;
  try
    try
      { LIVE MODE: Download from URL }
      FJson.Text := FData.DownloadJsonAsString('https://price.muncitorul.md/api/products.json');
    except
      on E: Exception do
      begin
      // Show error in message and put it in the memo for inspection
        FJson.Text := Format('{"error": "Failed to fetch JSON: %s"}', [E.Message]);
        ShowMessage('Error fetching JSON: ' + E.Message);
      end;
    end;
  finally
    LWatch.Stop;
    { Store the time in the form's private field }
    FDownloadTime := LWatch.ElapsedMilliseconds;
  end;
end;

procedure TfrmMuncitorulProgressDlg.ParseJsonFromMemoAndLoadDataSets;
var
  LWatch: TStopwatch;
begin
  Assert(Assigned(FData), 'FData instance is missing in ParseAndLoadDataSets.');

  LWatch := TStopwatch.StartNew;
  try
    try
    { Măsurăm timpul de încărcare JSON }
      FData.LoadFromJson(FJson.Text);
    except
      on E: Exception do
      begin
        ShowMessage('Error parsing or loading JSON: ' + E.Message);
      end;
    end;
  finally
    LWatch.Stop;
    { Store the time in the form's private field }
    FLoadTime := LWatch.ElapsedMilliseconds;
  end;

  { Conectăm sursele de date la seturile de date din clasa noastră }
  // This is done even if parsing fails, so the grids show empty datasets
  // instead of keeping old data.
  DsProducts.DataSet := FData.Products;
  DsImages.DataSet := FData.Images;
  DsFeatures.DataSet := FData.Features;
end;

procedure TfrmMuncitorulProgressDlg.AddToPriceListItems(Sender: TObject);
var
  LNewPLID: Integer;
  q: TFDQuery;
begin
  q := TFDQuery.Create(self);
  try
    q.Connection := FDConnection1;

    LNewPLID := FDConnection1.ExecSQLScalar('insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID) ' +
      'values (:SUPPLIERID, :PRICE_CATEGORYID) ' + 'returning PLID', [251465, PriceCategoryID]);

    q.sql.Clear;
    q.SQL.Add('insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, STOCK_QTY, PRICE0,');
    q.SQL.Add('CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, SUPPLIER_GOODS_BRAND,');
    q.SQL.Add('SUPPLIER_GOODS_MODEL, waranty, ');
    q.SQL.Add('SUPPLIER_CATEGORY)');
    q.SQL.Add('values (:PLID, :SUPPLIER_GOODS_CODE, :SUPPLIER_GOODS_NAME, :STOCK_QTY, :PRICE0, :CURRENCY0ID, :PRICE3,');
    q.SQL.Add(':CURRENCY3ID, :PRICE7, :CURRENCY7ID, :SUPPLIER_GOODS_BRAND, :SUPPLIER_GOODS_MODEL,  :waranty, ');
    q.SQL.Add(':SUPPLIER_CATEGORY)');

    DsProducts.DataSet.Open;
    DsProducts.DataSet.First;
    Application.ProcessMessages;
    while not DsProducts.DataSet.Eof do
    begin
      { params prepare }
      q.ParamByName('PLID').AsInteger := LNewPLID;
      q.ParamByName('SUPPLIER_GOODS_CODE').AsString := DsProducts.DataSet.FieldByName('code').AsString;
      q.ParamByName('SUPPLIER_GOODS_NAME').AsString := DsProducts.DataSet.FieldByName('titluRO').AsString;
      q.ParamByName('STOCK_QTY').AsFloat := DsProducts.DataSet.FieldByName('stoc').AsFloat;

      q.ParamByName('PRICE0').AsFloat := DsProducts.DataSet.FieldByName('pret_online').AsFloat;
      q.ParamByName('CURRENCY0ID').AsInteger := 498;

      q.ParamByName('PRICE3').AsFloat := DsProducts.DataSet.FieldByName('pret_vinz').AsFloat;
      q.ParamByName('CURRENCY3ID').AsInteger := 498;

      q.ParamByName('PRICE7').AsFloat := DsProducts.DataSet.FieldByName('pret_online').AsFloat;
      q.ParamByName('CURRENCY7ID').AsInteger := 498;

      q.ParamByName('WARANTY').AsInteger := DsProducts.DataSet.FieldByName('guar_period').AsInteger;

      q.ParamByName('SUPPLIER_GOODS_BRAND').AsString := DsProducts.DataSet.FieldByName('brand').AsString;
//      q.ParamByName('SUPPLIER_GOODS_MODEL').AsString := Item.Model;

//      q.ParamByName('SUPPLIER_GOODSTYPE').AsString := Item.SupplierGoodsType;
//      q.ParamByName('GOODSTYPEID').AsInteger := Item.GoodsTypeID;

//      q.ParamByName('SYSTEM_VENDORID').AsInteger := Item.SystemVendorID;
//      q.ParamByName('PARENTGOODSID').AsInteger := Item.ParentGoodsID;

      q.ParamByName('SUPPLIER_CATEGORY').AsString := DsProducts.DataSet.FieldByName('categorieRO').AsString;

//      q.ParamByName('COMPATIBILITATE').AsString := Item.Compatibilitate; // text, poate fi NULL

//      q.ParamByName('FLG_PREORDER').AsInteger := Item.FlgPreorder; // 0/1

//      UpsertImage(LNewPLID, DsProducts.DataSet.FieldByName('code').AsString);
      if  DsProducts.DataSet.FieldByName('stoc').AsFloat > 0 then
        q.ExecSQL;

      DsProducts.DataSet.Next;
    end;
  finally
    q.Free;
  end;

end;

function TfrmMuncitorulProgressDlg.DownloadImage(ImageUrl: string): string;
var
  LHttpClient: THTTPClient;
  LResponse: IHTTPResponse;
begin
  Result := '';
  LHttpClient := THTTPClient.Create;
  try
    LResponse := LHttpClient.Get(ImageUrl);

    if LResponse.StatusCode = 200 then
    begin
      Result := LResponse.ContentAsString;
    end
    else
    begin
      raise ENetHTTPClientException.Create('Serverul a răspuns cu codul de stare: ' + LResponse.StatusCode.ToString);
    end;
  finally
    LHttpClient.Free;
  end;
end;

procedure TfrmMuncitorulProgressDlg.SetPriceCategoryID(const Value: Integer);
begin
  FPriceCategoryID := Value;
end;

function TfrmMuncitorulProgressDlg.DownloadImageStream(const ImageUrl: string): TMemoryStream;
var
  LHttpClient: THTTPClient;
  LResponse: IHTTPResponse;
begin
  Result := TMemoryStream.Create;
  LHttpClient := THTTPClient.Create;
  try
    LResponse := LHttpClient.Get(ImageUrl, Result);
    if LResponse.StatusCode = 200 then
      Result.Position := 0
    else
    begin
      Result.Free;
      raise ENetHTTPClientException.Create('Serverul a răspuns cu codul de stare: ' + LResponse.StatusCode.ToString);
    end;
  finally
    LHttpClient.Free;
  end;
end;

procedure TfrmMuncitorulProgressDlg.UpsertImage(PLID: Integer; GoodsCode: string);
begin
  var q := TFDQuery.Create(Self);
  q.Connection := FDConnection1;
  try
    q.SQL.Text := 'select goodsid from ts_goods_foreign where customerid = 251465 and goods_code = :code';
    q.ParamByName('code').AsString := GoodsCode;
    q.open;

    dsImages.DataSet.First;
    while not DsImages.DataSet.Eof do
    begin
      if q.RecordCount > 0 then
      begin
        var GoodsID := q.FieldByName('goodsid').AsInteger;
        if dsImages.DataSet.RecordCount > 0 then
        begin
          fdconnection1.ExecSQL('delete from ts_goods_image where goodsid = :goodsid', [GoodsID])
        end;

        var ImageStream := DownloadImageStream(DsImages.DataSet.FieldByName('image_url').AsString);

        ImageStream.Position := 0;
        SaveImage(GoodsID, ImageStream);
      end;

      dsImages.DataSet.Next;
    end;
  finally
    q.Free;
  end;
end;

procedure TfrmMuncitorulProgressDlg.SaveImage(GoodsID: Integer; Stream: TMemoryStream);
var
  q: TFDQuery;
begin
  q := TFDQuery.Create(nil);
  try
    q.Connection := FDConnection1;

    q.SQL.Text := 'insert into ts_goods_image (goodsid, image) ' + 'values (:goodsid, :image)';

    q.ParamByName('goodsid').AsInteger := GoodsID;

    // parametru BLOB
    q.ParamByName('image').LoadFromStream(Stream, ftBlob);

    q.ExecSQL;
  finally
    q.Free;
  end;
end;

end.


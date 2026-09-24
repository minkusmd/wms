unit frmMuncitorulProgressUnit;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.SyncObjs,
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

const
  cOlisSupplierID = 251465;
  cOlisThreadCount = 8;
  cOlisFeedUrl = 'https://price.muncitorul.md/api/products.json';

type
  { un rind de pricelist, copiat din dataset pe firul coordonator -
    firele de import nu ating memtable-urile }
  TOlisPriceItem = record
    Code: string;
    Name: string;
    Brand: string;
    Category: string;
    Stock: Double;
    PriceOnline: Double;
    PriceVinz: Double;
    Warranty: Integer;
  end;

  { starea comuna a importului: lista, indexul urmator, rezultatele }
  TOlisImportJob = class
  public
    Items: TArray<TOlisPriceItem>;
    PLID: Integer;
    ConnectionParams: TStringList;
    NextIndex: Integer;          // TInterlocked
    Inserted: Integer;           // TInterlocked
    Failed: Integer;             // 0/1, TInterlocked - un fir a cazut, restul se opresc
    InsertPhaseLeft: TCountdownEvent;
    Decision: TEvent;            // semnalat de coordonator dupa ce toate firele au terminat INSERT-urile
    CommitAll: Boolean;          // citit de fire abia dupa Decision
    constructor Create;
    destructor Destroy; override;
    function HasFailed: Boolean;
  end;

  { un fir de import: conexiune + tranzactie proprie; face INSERT-urile, apoi
    asteapta decizia coordonatorului si da COMMIT sau ROLLBACK - totul sau nimic }
  TOlisInsertWorker = class(TThread)
  private
    FJob: TOlisImportJob;
    FError: string;
    FCommitted: Boolean;
    procedure InsertItems(AConnection: TFDConnection);
  protected
    procedure Execute; override;
  public
    constructor Create(AJob: TOlisImportJob);
    property Error: string read FError;
    property Committed: Boolean read FCommitted;
  end;

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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FData: TMuncitorulData;
    FDownloadTime: Int64;
    FLoadTime: Int64;
    FImportTime: Int64;
    FJson: TStringList;
    FPLID: Integer;
    FPriceCategoryID: Integer;
    FRunner: TThread;
    FRunning: Boolean;
    procedure RunImport;
    procedure FinishImport(const AError: string);
    procedure ShowStep(ALabel: TLabel; const AText: string);
    procedure FetchJsonToMemo;
    procedure ParseJsonFromMemoAndLoadDataSets;
    function BuildPriceItems: TArray<TOlisPriceItem>;
    function AddToPriceListItems(const AItems: TArray<TOlisPriceItem>): Integer;
    procedure DeletePriceList(APLID: Integer);
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
  System.Math,
  System.Net.HttpClient;


{$R *.dfm}

{ ---------------------------------------------------------------------------- }
{ TOlisImportJob                                                                }
{ ---------------------------------------------------------------------------- }

constructor TOlisImportJob.Create;
begin
  inherited Create;
  ConnectionParams := TStringList.Create;
  InsertPhaseLeft := TCountdownEvent.Create(cOlisThreadCount);
  Decision := TEvent.Create(nil, True, False, '');
end;

destructor TOlisImportJob.Destroy;
begin
  Decision.Free;
  InsertPhaseLeft.Free;
  ConnectionParams.Free;
  inherited;
end;

function TOlisImportJob.HasFailed: Boolean;
begin
  Result := TInterlocked.CompareExchange(Failed, 0, 0) <> 0;
end;

{ ---------------------------------------------------------------------------- }
{ TOlisInsertWorker                                                             }
{ ---------------------------------------------------------------------------- }

constructor TOlisInsertWorker.Create(AJob: TOlisImportJob);
begin
  FJob := AJob;
  inherited Create(False);
  FreeOnTerminate := False;
end;

procedure TOlisInsertWorker.InsertItems(AConnection: TFDConnection);
var
  q: TFDQuery;
  Index: Integer;
begin
  q := TFDQuery.Create(nil);
  try
    q.Connection := AConnection;
    q.SQL.Add('insert into TS_PRICELIST_ITEMS (PLID, SUPPLIER_GOODS_CODE, SUPPLIER_GOODS_NAME, STOCK_QTY, PRICE0,');
    q.SQL.Add('CURRENCY0ID, PRICE3, CURRENCY3ID, PRICE7, CURRENCY7ID, SUPPLIER_GOODS_BRAND,');
    q.SQL.Add('SUPPLIER_GOODS_MODEL, waranty, ');
    q.SQL.Add('SUPPLIER_CATEGORY)');
    q.SQL.Add('values (:PLID, :SUPPLIER_GOODS_CODE, :SUPPLIER_GOODS_NAME, :STOCK_QTY, :PRICE0, :CURRENCY0ID, :PRICE3,');
    q.SQL.Add(':CURRENCY3ID, :PRICE7, :CURRENCY7ID, :SUPPLIER_GOODS_BRAND, :SUPPLIER_GOODS_MODEL,  :waranty, ');
    q.SQL.Add(':SUPPLIER_CATEGORY)');

    // fara Prepare explicit: primul ExecSQL pregateste cu tipurile date de AsXXX,
    // restul refolosesc instructiunea (SQL-ul nu se schimba)
    q.ParamByName('PLID').AsInteger := FJob.PLID;
    q.ParamByName('CURRENCY0ID').AsInteger := 498;
    q.ParamByName('CURRENCY3ID').AsInteger := 498;
    q.ParamByName('CURRENCY7ID').AsInteger := 498;
    q.ParamByName('SUPPLIER_GOODS_MODEL').DataType := ftString;
    q.ParamByName('SUPPLIER_GOODS_MODEL').Clear;

    while not Terminated and not FJob.HasFailed do
    begin
      Index := TInterlocked.Increment(FJob.NextIndex) - 1;
      if Index > High(FJob.Items) then
        Break;

      with FJob.Items[Index] do
      begin
        q.ParamByName('SUPPLIER_GOODS_CODE').AsString := Code;
        q.ParamByName('SUPPLIER_GOODS_NAME').AsString := Name;
        q.ParamByName('STOCK_QTY').AsFloat := Stock;
        // la Olis PRICE0 = PRICE7 = pret_online
        q.ParamByName('PRICE0').AsFloat := PriceOnline;
        q.ParamByName('PRICE3').AsFloat := PriceVinz;
        q.ParamByName('PRICE7').AsFloat := PriceOnline;
        q.ParamByName('WARANTY').AsInteger := Warranty;
        q.ParamByName('SUPPLIER_GOODS_BRAND').AsString := Brand;
        q.ParamByName('SUPPLIER_CATEGORY').AsString := Category;
      end;
      q.ExecSQL;
      TInterlocked.Increment(FJob.Inserted);
    end;
  finally
    q.Free;
  end;
end;

procedure TOlisInsertWorker.Execute;
var
  Connection: TFDConnection;
  InsertPhaseSignaled: Boolean;
begin
  InsertPhaseSignaled := False;
  Connection := nil;
  try
    try
      Connection := TFDConnection.Create(nil);
      Connection.Params.Assign(FJob.ConnectionParams);
      Connection.LoginPrompt := False;
      // fara cursorul de asteptare VCL - nu e voie din alt fir decit cel principal
      Connection.ResourceOptions.SilentMode := True;
      Connection.TxOptions.Isolation := xiReadCommitted;
      Connection.Connected := True;
      Connection.StartTransaction;

      InsertItems(Connection);
    except
      on E: Exception do
      begin
        FError := E.Message;
        TInterlocked.Exchange(FJob.Failed, 1);
      end;
    end;

    // gata cu INSERT-urile; decizia (COMMIT/ROLLBACK) o ia coordonatorul
    FJob.InsertPhaseLeft.Signal;
    InsertPhaseSignaled := True;
    FJob.Decision.WaitFor(INFINITE);

    if Assigned(Connection) and Connection.InTransaction then
    try
      if FJob.CommitAll and (FError = '') then
      begin
        Connection.Commit;
        FCommitted := True;
      end
      else
        Connection.Rollback;
    except
      on E: Exception do
        if FError = '' then
          FError := E.Message;
    end;
  finally
    if not InsertPhaseSignaled then
      FJob.InsertPhaseLeft.Signal;
    Connection.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{ TfrmMuncitorulProgressDlg                                                     }
{ ---------------------------------------------------------------------------- }

procedure TfrmMuncitorulProgressDlg.FormDestroy(Sender: TObject);
begin
  if Assigned(FRunner) then
  begin
    FRunner.WaitFor;
    TThread.RemoveQueuedEvents(FRunner);
    FRunner.Free;
  end;
  FJson.Free;
  FData.Free;
end;

procedure TfrmMuncitorulProgressDlg.FormCreate(Sender: TObject);
begin
  // conexiunea e folosita de firul coordonator - fara cursorul de asteptare VCL
  FDConnection1.ResourceOptions.SilentMode := True;
  FDConnection1.Connected := True;
  fJSon := TStringList.Create;
  OnCloseQuery := FormCloseQuery;
  Caption := Format('Olis Grup - import pricelist (%d fire)', [cOlisThreadCount]);
end;

procedure TfrmMuncitorulProgressDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // cit timp ruleaza importul fereastra nu se inchide
  CanClose := not FRunning;
end;

procedure TfrmMuncitorulProgressDlg.FormShow(Sender: TObject);
begin
  if FRunning or Assigned(FRunner) then
    Exit;

  if not Assigned(FData) then
    FData := TMuncitorulData.Create;

  FRunning := True;
  lbTime.Caption := '';
  dxActivityIndicator1.Active := True;

  // tot lucrul merge pe un fir separat, fereastra ramine responsiva
  FRunner := TThread.CreateAnonymousThread(RunImport);
  FRunner.FreeOnTerminate := False;
  FRunner.Start;
end;

procedure TfrmMuncitorulProgressDlg.ShowStep(ALabel: TLabel; const AText: string);
begin
  TThread.Queue(TThread.Current,
    procedure
    begin
      ALabel.Caption := AText;
    end);
end;

{ firul coordonator }
procedure TfrmMuncitorulProgressDlg.RunImport;
var
  LWatch: TStopwatch;
  LItems: TArray<TOlisPriceItem>;
  LError: string;
  LInserted: Integer;
begin
  LError := '';
  try
    { --- STEP 1: Get JSON --- }
    ShowStep(Label1, '1. Get product json...');
    FetchJsonToMemo;
    ShowStep(Label1, Format('1. Get product json - %d ms', [FDownloadTime]));

    { --- STEP 2: Parse JSON and load datasets --- }
    ShowStep(Label2, '2. Parse json...');
    ParseJsonFromMemoAndLoadDataSets;
    LItems := BuildPriceItems;
    ShowStep(Label2, Format('2. Parse json - %d ms, %d produse cu stoc', [FLoadTime, Length(LItems)]));

    { --- STEP 3: Import to PriceList, in cOlisThreadCount fire --- }
    LWatch := TStopwatch.StartNew;
    LInserted := AddToPriceListItems(LItems);
    FImportTime := LWatch.ElapsedMilliseconds;
    ShowStep(Label3, Format('3. Import to PriceList - %d ms, %d rinduri (%d fire)',
      [FImportTime, LInserted, cOlisThreadCount]));
  except
    on E: Exception do
      LError := E.Message;
  end;

  TThread.Queue(TThread.Current,
    procedure
    begin
      FinishImport(LError);
    end);
end;

procedure TfrmMuncitorulProgressDlg.FinishImport(const AError: string);
begin
  FRunning := False;
  dxActivityIndicator1.Active := False;

  { Afișăm timpii }
  lbTime.Caption := Format('Acquire JSON: %d ms' + sLineBreak + 'Load JSON: %d ms' + sLineBreak +
    'Import: %d ms (%d fire)', [FDownloadTime, FLoadTime, FImportTime, cOlisThreadCount]);

  if AError <> '' then
    ShowMessage('Importul Olis Grup nu s-a facut:' + sLineBreak + AError);

  Close;
end;

procedure TfrmMuncitorulProgressDlg.FetchJsonToMemo;
var
  LWatch: TStopwatch;
begin
  Assert(Assigned(FData), 'FData instance is missing in FetchJsonToMemo.');

  LWatch := TStopwatch.StartNew;
  try
    try
      { LIVE MODE: Download from URL }
      FJson.Text := FData.DownloadJsonAsString(cOlisFeedUrl);
    except
      on E: Exception do
        raise Exception.Create('Error fetching JSON: ' + E.Message);
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
        raise Exception.Create('Error parsing or loading JSON: ' + E.Message);
    end;
  finally
    LWatch.Stop;
    { Store the time in the form's private field }
    FLoadTime := LWatch.ElapsedMilliseconds;
  end;

  // LoadFromJson iese fara eroare si la un JSON invalid - atunci Products e gol
  if FData.Products.IsEmpty then
    raise Exception.Create('JSON-ul nu contine produse.');
end;

{ copia produselor cu stoc intr-un tablou - pe firul coordonator, inainte de a
  porni firele de import (memtable-urile nu se citesc din mai multe fire) }
function TfrmMuncitorulProgressDlg.BuildPriceItems: TArray<TOlisPriceItem>;
var
  LProducts: TFDMemTable;
  LCount: Integer;
  Item: TOlisPriceItem;
begin
  LProducts := FData.Products;
  SetLength(Result, LProducts.RecordCount);
  LCount := 0;
  LProducts.DisableControls;
  try
    LProducts.First;
    while not LProducts.Eof do
    begin
      if LProducts.FieldByName('stoc').AsFloat > 0 then
      begin
        Item.Code := LProducts.FieldByName('code').AsString;
        Item.Name := LProducts.FieldByName('titluRO').AsString;
        Item.Brand := LProducts.FieldByName('brand').AsString;
        Item.Category := LProducts.FieldByName('categorieRO').AsString;
        Item.Stock := LProducts.FieldByName('stoc').AsFloat;
        Item.PriceOnline := LProducts.FieldByName('pret_online').AsFloat;
        Item.PriceVinz := LProducts.FieldByName('pret_vinz').AsFloat;
        Item.Warranty := StrToIntDef(Trim(LProducts.FieldByName('guar_period').AsString), 0);
        Result[LCount] := Item;
        Inc(LCount);
      end;
      LProducts.Next;
    end;
    LProducts.First;
  finally
    LProducts.EnableControls;
  end;
  SetLength(Result, LCount);
end;

function TfrmMuncitorulProgressDlg.AddToPriceListItems(const AItems: TArray<TOlisPriceItem>): Integer;
var
  Job: TOlisImportJob;
  Workers: TArray<TOlisInsertWorker>;
  I, Total: Integer;
  Errors: string;
  AllCommitted: Boolean;
begin
  Total := Length(AItems);
  if Total = 0 then
    raise Exception.Create('Niciun produs cu stoc in JSON.');

  Job := TOlisImportJob.Create;
  try
    Job.Items := AItems;
    Job.ConnectionParams.Assign(FDConnection1.Params);

    // antetul se comite separat: firele il vad (FK) doar dupa COMMIT
    Job.PLID := FDConnection1.ExecSQLScalar('insert into TS_PRICELISTS (SUPPLIERID, PRICE_CATEGORYID) ' +
      'values (:SUPPLIERID, :PRICE_CATEGORYID) ' + 'returning PLID', [cOlisSupplierID, PriceCategoryID]);
    if FDConnection1.InTransaction then
      FDConnection1.Commit;

    SetLength(Workers, cOlisThreadCount);
    for I := 0 to High(Workers) do
      Workers[I] := TOlisInsertWorker.Create(Job);
    try
      // progresul, pina cind toate firele termina INSERT-urile
      while Job.InsertPhaseLeft.WaitFor(200) <> wrSignaled do
        ShowStep(Label3, Format('3. Import to PriceList - %d / %d (%d fire)',
          [TInterlocked.CompareExchange(Job.Inserted, 0, 0), Total, cOlisThreadCount]));

      // totul sau nimic: COMMIT doar daca toate firele au reusit
      Job.CommitAll := not Job.HasFailed;
      Job.Decision.SetEvent;
    finally
      // la o exceptie neasteptata firele trebuie deblocate inainte de eliberarea Job
      TInterlocked.Exchange(Job.Failed, IfThen(Job.CommitAll, 0, 1));
      Job.Decision.SetEvent;
      Errors := '';
      AllCommitted := True;
      for I := 0 to High(Workers) do
      begin
        Workers[I].WaitFor;
        if Workers[I].Error <> '' then
          Errors := Errors + sLineBreak + Format('fir %d: %s', [I + 1, Workers[I].Error]);
        AllCommitted := AllCommitted and Workers[I].Committed;
        Workers[I].Free;
      end;
    end;

    if not AllCommitted then
    begin
      // un fir a cazut (restul au dat ROLLBACK) sau un COMMIT a esuat - nu lasam pricelist partial
      DeletePriceList(Job.PLID);
      raise Exception.Create('Pricelist-ul nu a fost creat.' + Errors);
    end;

    FPLID := Job.PLID;
    Result := TInterlocked.CompareExchange(Job.Inserted, 0, 0);
  finally
    Job.Free;
  end;
end;

procedure TfrmMuncitorulProgressDlg.DeletePriceList(APLID: Integer);
begin
  try
    FDConnection1.ExecSQL('delete from TS_PRICELIST_ITEMS where PLID = :PLID', [APLID]);
    FDConnection1.ExecSQL('delete from TS_PRICELISTS where PLID = :PLID', [APLID]);
    if FDConnection1.InTransaction then
      FDConnection1.Commit;
  except
    // eroarea initiala e mai importanta; pricelist-ul ramas se poate sterge manual
    if FDConnection1.InTransaction then
      FDConnection1.Rollback;
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


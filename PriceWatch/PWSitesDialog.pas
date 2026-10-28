unit PWSitesDialog;

{ WMSPriceWatch - site-urile concurentilor (TWEB_COMPETITOR_SITES): lista + regex-urile
  de parsare ale site-ului ales. Un site nou = un rind nou, fara recompilare.
  "Testeaza" descarca o pagina (URL-ul dat) si arata ce produse scoate parserul cu
  regex-urile curente - cel mai rapid mod de a pune la punct un site nou.
  Modificarile se salveaza la OK (o tranzactie), Renunta le anuleaza. }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Data.DB, DBAccess, IBC, MemDS,
  PWBaseFormUnit, DialogTitle,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxClasses, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons, cxTextEdit, cxCheckBox,
  dxScrollbarAnnotations, dxDateRanges, PWTypes;

type
  TfrmPWSitesDlg = class(TPWBaseFormClass)
    dtDialogTitle: TDialogTitle;
    pnTop: TPanel;
    cxGridSites: TcxGrid;
    cxGridSitesTable: TcxGridDBTableView;
    cxGridSitesLevel: TcxGridLevel;
    colSITE_CODE: TcxGridDBColumn;
    colTITLE: TcxGridDBColumn;
    colBASE_URL: TcxGridDBColumn;
    colFLG_ACTIVE: TcxGridDBColumn;
    colDELAY_MIN_MS: TcxGridDBColumn;
    colDELAY_MAX_MS: TcxGridDBColumn;
    colPAGE_URL_TPL: TcxGridDBColumn;
    colMAX_PAGES: TcxGridDBColumn;
    colPROXY_URL: TcxGridDBColumn;
    colLAST_RUN: TcxGridDBColumn;
    colLAST_STATUS: TcxGridDBColumn;
    colFAIL_COUNT: TcxGridDBColumn;
    colBLOCKED_UNTIL: TcxGridDBColumn;
    splMain: TSplitter;
    pcDetails: TPageControl;
    tsRegex: TTabSheet;
    tsTest: TTabSheet;
    lbItemRegex: TLabel;
    mmItemRegex: TDBMemo;
    lbNameRegex: TLabel;
    edNameRegex: TDBEdit;
    lbUrlRegex: TLabel;
    edUrlRegex: TDBEdit;
    lbPriceRegex: TLabel;
    edPriceRegex: TDBEdit;
    lbOldPriceRegex: TLabel;
    edOldPriceRegex: TDBEdit;
    lbCodeRegex: TLabel;
    edCodeRegex: TDBEdit;
    lbStockRegex: TLabel;
    edStockRegex: TDBEdit;
    lbNoStockWords: TLabel;
    edNoStockWords: TDBEdit;
    lbBlockRegex: TLabel;
    edBlockRegex: TDBEdit;
    lbUserAgent: TLabel;
    edUserAgent: TDBEdit;
    lbNote: TLabel;
    edNote: TDBEdit;
    pnTestTop: TPanel;
    lbTestUrl: TLabel;
    edTestUrl: TcxTextEdit;
    btnTest: TcxButton;
    mmTest: TMemo;
    pnBottom: TPanel;
    btnAdd: TcxButton;
    btnDelete: TcxButton;
    btnUnblock: TcxButton;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    IBCQuerySites: TIBCQuery;
    IBCDataSourceSites: TIBCDataSource;
    IBCTransactionUpdate: TIBCTransaction;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUnblockClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure IBCQuerySitesNewRecord(DataSet: TDataSet);
    procedure IBCQuerySitesBeforePost(DataSet: TDataSet);
  private
    FGlobalProxy: string;
    function CurrentSite: TPWSite;
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
  public
    property GlobalProxy: string read FGlobalProxy write FGlobalProxy;
  end;

implementation

uses
  System.UITypes, System.StrUtils, PWHttpUnit, PWParserUnit, PWMatchUnit;

{$R *.dfm}

{ TfrmPWSitesDlg }

procedure TfrmPWSitesDlg.Prepare;
begin
  dtDialogTitle.Text := 'Fiecare site are regex-urile lui de parsare (vezi tab-ul Regex). ' +
    'Pauza intre cereri (ms) si proxy-ul (http://user:parola@host:port) sint pe site.';
  IBCQuerySites.Connection := FIBCConnection;
  IBCTransactionUpdate.DefaultConnection := FIBCConnection;
  IBCQuerySites.Transaction := IBCTransactionUpdate;
  IBCQuerySites.UpdateTransaction := IBCTransactionUpdate;
  if not IBCTransactionUpdate.Active then
    IBCTransactionUpdate.StartTransaction;
  IBCQuerySites.Open;
  pcDetails.ActivePage := tsRegex;
end;

function TfrmPWSitesDlg.IsFormDataPosted: Boolean;
begin
  Result := False;
  try
    if IBCQuerySites.State in dsEditModes then
      IBCQuerySites.Post;
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Commit;
    Result := True;
  except
    on E: Exception do
      MessageDlg('Nu s-a putut salva: ' + E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmPWSitesDlg.WhenCancelForm;
begin
  try
    if IBCQuerySites.State in dsEditModes then
      IBCQuerySites.Cancel;
    if IBCTransactionUpdate.Active then
      IBCTransactionUpdate.Rollback;
  except
  end;
end;

procedure TfrmPWSitesDlg.IBCQuerySitesNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('FLG_ACTIVE').AsInteger := 1;
  DataSet.FieldByName('DELAY_MIN_MS').AsInteger := 4000;
  DataSet.FieldByName('DELAY_MAX_MS').AsInteger := 9000;
  DataSet.FieldByName('PAGE_URL_TPL').AsString := '{url}?page={page}';
  DataSet.FieldByName('FIRST_PAGE').AsInteger := 1;
  DataSet.FieldByName('MAX_PAGES').AsInteger := 40;
  DataSet.FieldByName('FAIL_COUNT').AsInteger := 0;
  DataSet.FieldByName('BLOCK_REGEX').AsString := 'Just a moment|cf-challenge|captcha';
end;

procedure TfrmPWSitesDlg.IBCQuerySitesBeforePost(DataSet: TDataSet);
var
  Code: string;
begin
  Code := UpperCase(Trim(DataSet.FieldByName('SITE_CODE').AsString));
  if Code = '' then
    raise Exception.Create('Completati codul site-ului (ex. XSTORE).');
  DataSet.FieldByName('SITE_CODE').AsString := Code;
  if Trim(DataSet.FieldByName('BASE_URL').AsString) = '' then
    raise Exception.Create('Completati adresa site-ului (ex. https://xstore.md).');
  if Trim(DataSet.FieldByName('ITEM_REGEX').AsString) = '' then
    raise Exception.Create('Completati ITEM_REGEX (blocul unui produs).');
end;

procedure TfrmPWSitesDlg.btnAddClick(Sender: TObject);
begin
  IBCQuerySites.Append;
  cxGridSites.SetFocus;
end;

procedure TfrmPWSitesDlg.btnDeleteClick(Sender: TObject);
begin
  if IBCQuerySites.IsEmpty then
    Exit;
  if MessageDlg(Format('Stergeti site-ul %s? Se sterg si produsele gasite pe el si istoricul lor.',
      [IBCQuerySites.FieldByName('SITE_CODE').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;
  IBCQuerySites.Delete;
end;

procedure TfrmPWSitesDlg.btnUnblockClick(Sender: TObject);
begin
  if IBCQuerySites.IsEmpty then
    Exit;
  IBCQuerySites.Edit;
  IBCQuerySites.FieldByName('FAIL_COUNT').AsInteger := 0;
  IBCQuerySites.FieldByName('BLOCKED_UNTIL').Clear;
  IBCQuerySites.FieldByName('LAST_STATUS').AsString := 'deblocat manual';
  IBCQuerySites.Post;
end;

function TfrmPWSitesDlg.CurrentSite: TPWSite;
var
  D: TDataSet;
begin
  D := IBCQuerySites;
  Result := Default(TPWSite);
  Result.SiteID := D.FieldByName('SITEID').AsInteger;
  Result.SiteCode := Trim(D.FieldByName('SITE_CODE').AsString);
  Result.BaseUrl := Trim(D.FieldByName('BASE_URL').AsString);
  Result.DelayMinMs := 0;
  Result.DelayMaxMs := 0;
  Result.PageUrlTpl := Trim(D.FieldByName('PAGE_URL_TPL').AsString);
  Result.ProxyUrl := Trim(D.FieldByName('PROXY_URL').AsString);
  Result.UserAgent := Trim(D.FieldByName('USER_AGENT').AsString);
  Result.ItemRegex := D.FieldByName('ITEM_REGEX').AsString;
  Result.NameRegex := D.FieldByName('NAME_REGEX').AsString;
  Result.UrlRegex := D.FieldByName('URL_REGEX').AsString;
  Result.PriceRegex := D.FieldByName('PRICE_REGEX').AsString;
  Result.OldPriceRegex := D.FieldByName('OLDPRICE_REGEX').AsString;
  Result.CodeRegex := D.FieldByName('CODE_REGEX').AsString;
  Result.StockRegex := D.FieldByName('STOCK_REGEX').AsString;
  Result.NoStockWords := D.FieldByName('NOSTOCK_WORDS').AsString;
  Result.BlockRegex := D.FieldByName('BLOCK_REGEX').AsString;
end;

{ Descarca pagina si arata rezultatul parsarii cu regex-urile din grid (inclusiv cele
  needitate inca, deoarece citim din dataset dupa Post). }
procedure TfrmPWSitesDlg.btnTestClick(Sender: TObject);
var
  Site: TPWSite;
  Fetcher: TPWFetcher;
  R: TPWFetchResult;
  P: TPWParseResult;
  I: Integer;
  Url: string;
begin
  if IBCQuerySites.IsEmpty then
    Exit;
  if IBCQuerySites.State in dsEditModes then
    IBCQuerySites.Post;
  Url := Trim(edTestUrl.Text);
  if Url = '' then
  begin
    MessageDlg('Introduceti URL-ul unei pagini de categorie de pe acest site.', mtWarning, [mbOK], 0);
    Exit;
  end;
  Site := CurrentSite;
  if Trim(Site.PageUrlTpl) <> '' then
    Url := StringReplace(StringReplace(Site.PageUrlTpl, '{url}', Url, [rfReplaceAll, rfIgnoreCase]),
      '{page}', '1', [rfReplaceAll, rfIgnoreCase]);
  mmTest.Lines.Clear;
  mmTest.Lines.Add('GET ' + Url);
  Screen.Cursor := crHourGlass;
  Fetcher := TPWFetcher.Create(FGlobalProxy, nil, nil);
  try
    R := Fetcher.Get(Site, Url);
  finally
    Fetcher.Free;
    Screen.Cursor := crDefault;
  end;
  if not R.Ok then
  begin
    mmTest.Lines.Add('EROARE de retea: ' + R.Error);
    Exit;
  end;
  mmTest.Lines.Add(Format('HTTP %d, %d caractere, %d ms', [R.StatusCode, Length(R.Body), R.ElapsedMs]));
  if R.StatusCode <> 200 then
    Exit;
  P := PWParsePage(Site, R.Body);
  if P.Error <> '' then
  begin
    mmTest.Lines.Add('EROARE: ' + P.Error);
    Exit;
  end;
  if P.Blocked then
    mmTest.Lines.Add('ATENTIE: pagina arata ca o verificare anti-bot (BLOCK_REGEX s-a potrivit).');
  mmTest.Lines.Add(Format('%d produse extrase, %d blocuri sarite (fara denumire / pret / link)', [Length(P.Items), P.Skipped]));
  mmTest.Lines.Add('');
  for I := 0 to High(P.Items) do
  begin
    mmTest.Lines.Add(Format('%d. %s', [I + 1, P.Items[I].Title]));
    mmTest.Lines.Add(Format('    pret %.2f%s%s%s  | cheie: %s', [P.Items[I].Price,
      IfThen(P.Items[I].OldPrice > 0, Format(' (vechi %.2f)', [P.Items[I].OldPrice]), ''),
      IfThen(P.Items[I].SiteCode <> '', '  cod ' + P.Items[I].SiteCode, ''),
      IfThen(P.Items[I].InStock, '  in stoc', '  FARA STOC' + IfThen(P.Items[I].StockText <> '', ' (' + P.Items[I].StockText + ')', '')),
      PWMatchKey(P.Items[I].Title)]));
    mmTest.Lines.Add('    ' + P.Items[I].Url);
  end;
end;

end.

unit frmAddGoodsfromPrices;

interface

uses
  DBAccess,
  IBC,
  MemDS,
  SWNBaseUnit,
  SWNUtils,
  SWNValueStorageUnit,
  cxCheckBox,
  cxClasses,
  cxContainer,
  cxControls,
  cxCustomData,
  cxDBData,
  cxDBTL,
  cxData,
  cxDataStorage,
  cxEdit,
  cxFilter,
  cxFindPanel,
  cxGraphics,
  cxGrid,
  cxGridCustomTableView,
  cxGridCustomView,
  cxGridDBTableView,
  cxGridLevel,
  cxGridTableView,
  cxImageList,
  cxInplaceContainer,
  cxLookAndFeelPainters,
  cxLookAndFeels,
  cxMaskEdit,
  cxMemo,
  cxNavigator,
  cxStyles,
  cxTL,
  cxTLData,
  cxTLdxBarBuiltInMenu,
  cxTextEdit,
  dxBar,
  dxBarExtDBItems,
  dxBarExtItems,
  dxDateRanges,
  dxScrollbarAnnotations,
  dxStatusBar,
  dxUIAClasses,
  frmGoods,
  frmMergeGoodsDialogEx,
  Data.DB,
  System.Classes,
  System.ImageList,
  System.SysUtils,
  System.Variants,
  Vcl.Clipbrd,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.WinXCtrls,
  Winapi.Messages,
  Winapi.ShellAPI,
  Winapi.Windows;

type
  TcxGridTableControllerAccess = class(TcxGridTableController);

  TcxGridFindPanelAccess = class(TcxCustomFindPanel);

  TfrmAddGoodsFromPriceDlg = class(TSWNBaseFormClass)
    cxImageList1: TcxImageList;
    dxStatusBar1: TdxStatusBar;
    dxBarManager1: TdxBarManager;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    Panel1: TPanel;
    SearchBox1: TSearchBox;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    tvGoodsFounded: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    IBCQuerySearch: TIBCQuery;
    IBCDataSourceSearch: TIBCDataSource;
    tvGoodsFounded_GOODSID: TcxGridDBColumn;
    tvGoodsFounded_GOODSNAME: TcxGridDBColumn;
    tvGoodsFounded_CNT: TcxGridDBColumn;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    dxBarLookupCombo1: TdxBarLookupCombo;
    IBCQueryGoodsType: TIBCQuery;
    IBCDataSourceGoodsType: TIBCDataSource;
    bbNewLink: TdxBarButton;
    IBCTrLocal: TIBCTransaction;
    bbNewGoods: TdxBarButton;
    dxBarButton1: TdxBarButton;
    Panel2: TPanel;
    SearchGoodsMemo: TcxMemo;
    dxBarButton2: TdxBarButton;
    tvGoodsFoundedColumn1: TcxGridDBColumn;
    tvGoodsFounded_PRICE1LEI: TcxGridDBColumn;
    tvGoodsFounded_FLG_IN_PRICE: TcxGridDBColumn;
    tvGoodsFounded_PRICE7LEI: TcxGridDBColumn;
    tvGoodsFoundedPRICE7USD: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarButton3: TdxBarButton;
    bbMergeGoods: TdxBarButton;
    bbMergeSelectedGoods: TdxBarButton;
    tvGoodsFounded_GOODS_TYPE: TcxGridDBColumn;
    tvGoodsFoundedVendor: TcxGridDBColumn;
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure bbNewLinkClick(Sender: TObject);
    procedure bbNewGoodsClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure tvGoodsFoundedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxBarButton2Click(Sender: TObject);
    procedure tvGoodsFoundedDblClick(Sender: TObject);
    procedure dxBarButton3Click(Sender: TObject);
    procedure bbMergeGoodsClick(Sender: TObject);
    procedure bbMergeSelectedGoodsClick(Sender: TObject);
    procedure dxBarLookupCombo1Exit(Sender: TObject);
    procedure SearchGoodsMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    fMergeDialog: TfrmMergeGoodsDlgEx;
    procedure GoodsProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);
    procedure MergeSelectedGoods;
    function PrepareTextForSearch: string;
  protected
    procedure DoNewSupplierLink(AGoodsID: integer);
    procedure DoSearch;
    procedure Prepare; override;

  public
    GoodsID: Integer;
    SupplierGoodsCode: string;
    SupplierGoodsName: string;
    CurrencyRRP: Integer;
    Currency7ID: Integer;
    SupplierID: Integer;
    PriceRRP: Double;
    Price7: Double;
    Model: string;
    VendorName: string;
    VendorID: Integer;
    GoodsTypeName: string;
    GoodsTypeID: Integer;
  end;

var
  frmAddGoodsFromPriceDlg: TfrmAddGoodsFromPriceDlg;

implementation

uses
  DataModuleAdditions,
  DataModuleDB,
  System.Generics.Collections;

{$R *.dfm}

procedure TfrmAddGoodsFromPriceDlg.bbMergeGoodsClick(Sender: TObject);
begin
  if (IBCQuerySearch.RecNo > 0) then
  begin
    if ShowMergeGoodsDialog(ibcquerysearch.FieldByName('GOODSID').AsInteger) then
      IBCQuerySearch.Refresh;
  end
  else
    MessageDlg('Selectati un produs pentru a fuziona!', TMsgDlgType.mtError, [mbOK], 0);
end;

procedure TfrmAddGoodsFromPriceDlg.MergeSelectedGoods;
// var
// ARecordIndex: Integer;
// I: Integer;
// SelectedFilterParamID: string;
// SelectedFilterParamName: string;
begin
  fMergeDialog := TfrmMergeGoodsDlgEx.Create(Self, dmdb.IBCConnection);
  fMergeDialog.GoodsList := TObjectList<TMergeGoodsList>.Create();

  try
    tvGoodsFounded.DataController.ForEachRow(True, GoodsProcessing);
    if fMergeDialog.ShowModal = mrOK then
    begin
      tvGoodsFounded.DataController.RefreshExternalData;
    end;
  finally
    begin
      fMergeDialog.GoodsList.Free;
      fMergeDialog.Free;
    end;
  end;
end;

procedure TfrmAddGoodsFromPriceDlg.GoodsProcessing(ARowIndex: Integer; ARowInfo: TcxRowInfo);
var
  RowIndex: Integer;
    // outputVal: Variant;
begin
  fMergeDialog.GoodsList.Add(TMergeGoodsList.Create);
  RowIndex := ARowInfo.RecordIndex;
  fMergeDialog.GoodsList.Last.GoodsID := tvGoodsFounded.DataController.Values[RowIndex, tvGoodsFounded.DataController.GetItemByFieldName
    ('GoodsID').Index];
  fMergeDialog.GoodsList.Last.GoodsName := tvGoodsFounded.DataController.Values[RowIndex, tvGoodsFounded.DataController.GetItemByFieldName
    ('TITLE').Index];
  fMergeDialog.GoodsList.Last.VendorName := tvGoodsFounded.DataController.Values[RowIndex, tvGoodsFounded.DataController.GetItemByFieldName
    ('VENDOR').Index];
  fMergeDialog.GoodsList.Last.TipEvidenta := tvGoodsFounded.DataController.Values[RowIndex, tvGoodsFounded.DataController.GetItemByFieldName
    ('SERIAL_TYPE_NAME').Index];


end;

procedure TfrmAddGoodsFromPriceDlg.bbNewGoodsClick(Sender: TObject);
var
  AccountingCostFormationTypeID: Integer;
  dialog: TfrmGoodsBrowser;
  DefaultGoodsID: Integer;
  R: TGoodsWebInfoClass;
begin
  dialog := TfrmGoodsBrowser.Create(Self);
  try
    DefaultGoodsID := AppUserTempConfigStorage.IntValues.GetValue(Self.Name + '_LastGoodsID', -1);
    if dialog.SelectGoods(DefaultGoodsID, True) then
    begin
      if dialog.GoodsIsFolder then
      begin
        R := GetGoodsWebInfo(dialog.GoodsID);
        try
          if GoodsTypeID <= 0 then
            GoodsTypeID := R.GoodsTypeID;

          AccountingCostFormationTypeID := iif(R.AccountingCostFormationTypeID = -1, 4201, R.AccountingCostFormationTypeID);
          dmDB.CreateNewGoods(dialog.GoodsID, SupplierGoodsName, AccountingCostFormationTypeID, GoodsTypeID,
            SupplierGoodsCode, VendorID, SupplierID, R.CodeRO, R.BaseParamsRO, PriceRRP, CurrencyRRP, Price7, Currency7ID, 0);
        finally
          R.Free;
        end;
        AppUserTempConfigStorage.IntValues.SetValue(Self.Name + '_LastGoodsID', dialog.GoodsID);
      end
      else
      begin
            // produs care trebuie
        DoNewSupplierLink(dialog.GoodsID);
      end;
    end;
  finally
    dialog.Free;
  end;

  Close;
end;

procedure TfrmAddGoodsFromPriceDlg.bbNewLinkClick(Sender: TObject);
begin
  inherited;
  DoNewSupplierLink(IBCQuerySearch.FieldByName('GOODSID').AsInteger);
end;

procedure TfrmAddGoodsFromPriceDlg.DoNewSupplierLink(AGoodsID: integer);
var
  q: TIBCQuery;
begin
  if (MessageDlg('Adaugam produsul in baza de date conectat la :' + AGoodsID.ToString, mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
  begin

    GoodsID := AGoodsID;
    q := TIBCQuery.Create(Self);
    try
      IBCTrLocal.DefaultConnection := IBCConnection;
      q.Transaction := IBCTrLocal;
      q.SQL.Add('insert into TS_GOODS_FOREIGN (GOODSID, CUSTOMERID, GOODS_CODE, GOODS_TITLE, PRICE3, ');
      q.SQL.Add('CURRENCY3ID, currency4id, currency5id, currency6id, ');
      q.SQL.Add('                       PRICE7, CURRENCY7ID, FLAGS)');
      q.SQL.Add('values (:GOODSID, :CUSTOMERID, :GOODS_CODE, :GOODS_TITLE, :PRICE3, ');
      q.SQL.Add(':CURRENCY3ID, :CURRENCY4ID, :CURRENCY5ID, :CURRENCY6ID,');
      q.SQL.Add(':PRICE7, :CURRENCY7ID, SET_FLG_VALUE(0, 3, 0))');

      q.ParamByName('GOODSID').AsString := GoodsID.ToString;
      q.ParamByName('CUSTOMERID').AsString := SupplierID.ToString;
      q.ParamByName('GOODS_CODE').AsString := SupplierGoodsCode;
      q.ParamByName('GOODS_TITLE').AsString := SupplierGoodsName;

      if CurrencyRRP > 0 then
      begin
        q.ParamByName('CURRENCY3ID').AsString := CurrencyRRP.toString;
        q.ParamByName('CURRENCY4ID').AsString := CurrencyRRP.toString;
        q.ParamByName('CURRENCY5ID').AsString := CurrencyRRP.toString;
      end
      else
      begin
        q.ParamByName('CURRENCY3ID').AsString := '840';
        q.ParamByName('CURRENCY4ID').AsString := q.ParamByName('CURRENCY3ID').AsString;
        q.ParamByName('CURRENCY5ID').AsString := q.ParamByName('CURRENCY3ID').AsString;

      end;

      q.ParamByName('PRICE3').AsFloat := PriceRRP;
      if (CurrencyRRP = 498) and (PriceRRP = 0) then
        q.ParamByName('CURRENCY3ID').AsString := '840';

      if Price7 > 0 then
        q.ParamByName('PRICE7').AsFloat := Price7
      else
        Exception.Create('Eroare! <Pret 7> trebuie sa contina o valoare!');

      if Currency7ID > 0 then
      begin
        q.ParamByName('CURRENCY6ID').AsString := Currency7ID.toString;
        q.ParamByName('CURRENCY7ID').AsString := Currency7ID.ToString;
      end
      else
        Exception.Create('Eroare! <Valuta 7> trebuie sa contina una din valori (498, 840, 976)');

      q.ExecSQL;
    finally
      q.Free;
    end;
    Close;
  end;
end;

procedure TfrmAddGoodsFromPriceDlg.DoSearch;
begin
  IBCQuerySearch.Close;
  IBCQuerySearch.ParamByName('searchtext').AsString := SearchBox1.Text;
  IBCQuerySearch.ParamByName('goodstypeid').AsInteger := iif(dxBarLookupCombo1.Text <> '', IBCQueryGoodsType.FieldByName
    ('goodstypeid').AsInteger, -1);
  IBCQuerySearch.Open;
end;

procedure TfrmAddGoodsFromPriceDlg.dxBarButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmAddGoodsFromPriceDlg.dxBarButton2Click(Sender: TObject);
var
  url: string;
  paurl: PAnsiChar;
  isize: Integer;
begin
  url := 'https://www.google.com/search?q=' + SupplierGoodsName;
  ShellExecute(0, 'open', PChar(UrlDecode(url)), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAddGoodsFromPriceDlg.dxBarButton3Click(Sender: TObject);
begin
  if ibcquerysearch.Active then
  begin
    var d := TfrmGoodsBrowser.Create(Self);
    try
      d.BrowseGoods(ibcquerysearch.fieldbyname('goodsid').AsInteger);
    finally
      d.Free;
    end;
  end;
end;

procedure TfrmAddGoodsFromPriceDlg.bbMergeSelectedGoodsClick(Sender: TObject);
begin
  inherited;
  MergeSelectedGoods;
end;

{ TfrmAddGoodsFromPriceDlg }

procedure TfrmAddGoodsFromPriceDlg.Prepare;
begin
  inherited;
  IBCQueryGoodsType.Open;
//  IBCQueryGoods.Open;

  SearchBox1.Text := SupplierGoodsName;
  SearchGoodsMemo.Lines.Text := SupplierGoodsName;
  DoSearch
end;

procedure TfrmAddGoodsFromPriceDlg.SearchBox1InvokeSearch(Sender: TObject);
begin
  DoSearch;
end;

function CheckGridForGoodsIDValue(const Grid: TcxGridDBTableView; var GoodsID: Integer): Boolean;
var
  i: Integer;
  col: TcxGridDBColumn;
begin
  GoodsID := -1;
  Result := False;

  for i := 0 to Grid.ColumnCount - 1 do
  begin
    col := Grid.Columns[i];
    if (col.DataBinding.FieldName = 'GOODSID') and VarIsNumeric(Grid.DataController.Values[Grid.DataController.FocusedRecordIndex,
      col.Index]) then
    begin
      GoodsID := Grid.DataController.Values[Grid.DataController.FocusedRecordIndex, col.Index];
      Result := True;
      Break;
    end;
  end;
end;

procedure ShowGoodsBrowser(const GoodsID: Integer);
var
  dialog: TfrmGoodsBrowser;
begin
  dialog := TfrmGoodsBrowser.Create(Application);
  try
    dialog.GoodsID := GoodsID;
    dialog.ShowModal;
  finally
    dialog.Free;
  end;
end;

procedure TfrmAddGoodsFromPriceDlg.dxBarLookupCombo1Exit(Sender: TObject);
begin
  DoSearch;
end;

function TfrmAddGoodsFromPriceDlg.PrepareTextForSearch: string;
var
  SelectedText: string;
  Words: TArray<string>;
  I: Integer;
  CleanedText: string;
begin
  // 1. Obținerea textului (selectat sau tot)
  if SearchGoodsMemo.SelLength > 0 then
    SelectedText := SearchGoodsMemo.SelText
  else
    SelectedText := SearchGoodsMemo.Lines.Text;

  // 2. Pre-procesare: Înlocuim trecerile la rând nou cu spații
  // pentru a nu concatena cuvinte de pe linii diferite fără spațiu între ele
  CleanedText := StringReplace(SelectedText, #13#10, ' ', [rfReplaceAll]);
  CleanedText := StringReplace(CleanedText, #10, ' ', [rfReplaceAll]);
  CleanedText := StringReplace(CleanedText, #13, ' ', [rfReplaceAll]);

  // 3. Spargem textul în cuvinte individuale folosind spațiul ca delimitator
  // TStringSplitOptions.ExcludeEmpty elimină spațiile multiple dintre cuvinte
  Words := CleanedText.Split([' '], TStringSplitOptions.ExcludeEmpty);

  // 4. Reconstruim șirul adăugând '+' înaintea fiecărui cuvânt
  Result := '';
  for I := Low(Words) to High(Words) do
  begin
    if Result <> '' then
      Result := Result + ' ';

    Result := Result + '+' + Words[I];
  end;

  // Returnăm textul pregătit (ex: "+iPhone +15 +Pro")
  Result := Trim(Result);
end;

procedure TfrmAddGoodsFromPriceDlg.SearchGoodsMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  AFindPanel: TcxCustomFindPanel;
begin
  if (ssAlt in Shift) and (Key = ord('C')) then
  begin
   // Aflăm instanța FindPanel-ului prin controller
    AFindPanel := TcxGridTableControllerAccess(tvGoodsFounded.Controller).FindPanel;

    if Assigned(AFindPanel) then
    begin
      // Folosim clasa de acces pentru a scrie în FilterText (proprietate protected)
      TcxGridFindPanelAccess(AFindPanel).ApplyText(PrepareTextForSearch);

      // Opțional: Forțăm Grid-ul să aplice imediat filtrul
//      TcxGridFindPanelAccess(AFindPanel).ApplyFilter;
    end;

    // Punem în Clipboard pentru siguranță
    Clipboard.AsText := PrepareTextForSearch;

    // Consumăm tasta
    Key := 0;
  end;
end;

procedure TfrmAddGoodsFromPriceDlg.tvGoodsFoundedDblClick(Sender: TObject);
begin
  DoNewSupplierLink(IBCQuerySearch.fieldbyname('GOODSID').AsInteger);
end;

procedure TfrmAddGoodsFromPriceDlg.tvGoodsFoundedKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SWNUtils.ProcessCommonKeys(Self, tvGoodsFounded, Key, Shift);
end;

end.


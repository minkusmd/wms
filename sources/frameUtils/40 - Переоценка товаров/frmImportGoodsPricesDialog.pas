unit frmImportGoodsPricesDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Dialogs,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, DialogTitle, StdCtrls, cxClasses,
  dxBar, ExtCtrls, DB, MemDS, DBAccess, IBC, cxButtonEdit, cxBarEditItem, dxSpreadSheet, dxCore,
  dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetPrinting, dxSpreadSheetFormulas,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetClasses, dxSpreadSheetTypes,
  dxBarBuiltInMenu, dxBarExtItems, dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetContainers, dxSpreadSheetHyperlinks,
  dxSpreadSheetUtils, Vcl.Grids, cxPC, cxContainer, cxEdit, cxTextEdit, cxMemo,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetStyles,
  dxSpreadSheetFormattedTextUtils, dxSpreadSheetCoreFormulas, Vcl.Menus, cxButtons, cxLabel,
  dxOfficeSearchBox;

type
  TImportGoodsData = class
    GoodsID: Integer;
    ForeignID: string;
    Title: string;
    Price0: Variant;
//    Price1: variant;
//    Price2: variant;
    Price3: Variant;
//    Price4: variant;
//    Price5: variant;
//    Price6: variant;
    Price7: Variant;
    Currency3ID: Variant;
    Currency4ID: Variant;
    Currency7ID: Variant;
    Warranty: Variant;
    Qty: Variant;
    RowIndex: Integer;
    ByInternalGoodsID: Boolean;
    Checked: Boolean;
    SupplierStockFlag: Variant;
    SupplierGoodsCode: string;
    BarCode: string;
    flg_epp: Integer;
    constructor Create;
  end;

  TGoodsInfoItem = class
  private
    { Private declarations }
    fGoodsID: Integer;
    fTitle: string;
  public
    { Public declarations }
    constructor Create(const AGoodsID: Integer; const ATitle: string);
    property GoodsID: Integer read fGoodsID;
    property Title: string read fTitle;
  end;

  TImportGoodsTarget = (igtGoodsPrice,                        // TDB_GOODS_PRICE
    igtVhodnieSceta                       // TDB_JURNAL
);

  TfrmImportGoodsPricesDlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    pnButtons: TPanel;
    bbOpenFile: TdxBarButton;
    bbClearAll: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    bbCodeNeuron: TdxBarButton;
    bbCodeVendor: TdxBarButton;
    bbGridHeader: TdxBarButton;
    IBCQuery: TIBCQuery;
    bbGoods: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    Shape1: TShape;
    Label1: TLabel;
    beCustomer1: TcxBarEditItem;
    dxBarProgressItem1: TdxBarProgressItem;
    bbSaveAs: TdxBarButton;
    dxBarButton1: TdxBarButton;
    bbPaste: TdxBarButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet2: TcxTabSheet;
    cxSpreadSheet: TdxSpreadSheet;
    dxBarSubItem3: TdxBarSubItem;
    bb1: TdxBarButton;
    Shape2: TShape;
    lbInfoUnlink: TLabel;
    btnCancel: TcxButton;
    btnImport: TcxButton;
    Label3: TLabel;
    lbUnlinkedGoods: TcxLabel;
    lbNonIdenticalGoods: TcxLabel;
    cmbValuta4: TdxBarCombo;
    cmbValuta7: TdxBarCombo;
    Label2: TLabel;
    lbFoundGoods: TcxLabel;
    Shape3: TShape;
    bbGetCurrencyToSheet: TdxBarButton;
    dxBarButton2: TdxBarButton;
    bbRRPCurrency: TdxBarButton;
    bbCurrency7: TdxBarButton;
    procedure bbOpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cxSpreadSheetSetSelection(Sender: TObject; ASheet: TdxSpreadSheetTableView);
    procedure beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure bbSaveAsClick(Sender: TObject);
    procedure bb1Click(Sender: TObject);
    procedure bbRRPCurrencyClick(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure bbCurrency7Click(Sender: TObject);
  private
    { Private declarations }
    fGoodsList: TList;
    fDocID: Integer;
    fImportByInternalGoodsID: Boolean;
    fTempList: TList;
    fCustomerID: Integer;
    fImportGoodsTarget: TImportGoodsTarget;
    fCustomerName: string;
    fGetCurrencyToSheet: Boolean;
    FSupplierID: Integer;
    UnknownCodeList: TStringList;
    procedure ClearGoodsList;
    procedure DoOpenFile;
    procedure DoCheckGoods;
    procedure DoScanGoods(const ValidateByInternalGoodsID: Boolean);
    procedure ProcessGoodsDataFromCell_PereotenkaTovarov(const Sheet: TdxSpreadSheetTableView; const
      RowIndex: Integer; const Data: TImportGoodsData);
    procedure ProcessGoodsDataFromCell_VhodnieSceta(const Sheet: TdxSpreadSheetTableView; const
      RowIndex: Integer; const Data: TImportGoodsData);
    function CheckGoodsID(const GoodsID: Integer): Boolean;
    function CheckForeignCode(const Code, GoodsTitle: string; var GoodsID: Integer; var FlgEpp:
      boolean): Boolean;
    function DoImportGoodsDB_PereotenkaTovarov: Boolean;
    function DoImportGoodsDB_VhodnieSceta: Boolean;
    procedure SetDocID(const Value: Integer);
    function GetRecordDataByRowIndex(const RowIndex: Integer): TImportGoodsData;
    function GetCheckGoodsCount: Integer;
    procedure SelectionChanged;
//    function SeachNearestItemByTitle(const Title: string): TGoodsInfoItem;
    procedure ClearSeachList;
// TODO: ShowSelectCustomerDialog
//  procedure ShowSelectCustomerDialog;
    procedure LoadCustomerInfo;
    procedure SetImportGoodsTarget(const Value: TImportGoodsTarget);
    procedure PrepareGridView;
    procedure PrepareGridView_PereotenkaTovarov;
    procedure PrepareGridView_VhodnieSceta;
    procedure SetCustomerID(const Value: Integer);
    procedure SetCustomerName(const Value: string);
    procedure SetSupplierID(const Value: Integer);
    procedure CreateCell(FontSize: ShortInt; var cell: TdxSpreadSheetCell);
  protected
    procedure UpdateSheetGoodsCurrency(codeStr: string; SupplierID, GoodsID, rowIndex: Integer;
      Sheet: TdxSpreadSheetTableView);
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
    function ValidateGoodsPrices(codeStr: string; GoodsID: Integer; Sheet: TdxSpreadSheetTableView;
      RowIndex: Integer): Boolean;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const ACustomerID: Integer; const ACustomerName:
      string); reintroduce; virtual;
    procedure AddSupplierCodeToResultSheet(SupplierCode: string);
    property DocID: Integer read fDocID write SetDocID;
    property ImportGoodsTarget: TImportGoodsTarget read fImportGoodsTarget write SetImportGoodsTarget;
    property CustomerID: Integer read fCustomerID write SetCustomerID;
    property CustomerName: string read fCustomerName write SetCustomerName;
    property SupplierID: Integer read FSupplierID write SetSupplierID;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNDBErrors, frmGoods, frmCustomersDlg,
  SWNValueStorageUnit, Vcl.Clipbrd;

{$R *.dfm}
{ TfrmImportGoodsPricesDlg }

procedure TfrmImportGoodsPricesDlg.bb1Click(Sender: TObject);
begin
  DoCheckGoods;
  SelectionChanged;
  Clipboard.AsText := UnknownCodeList.Text;
end;

procedure TfrmImportGoodsPricesDlg.bbCurrency7Click(Sender: TObject);
var
  cell: TdxSpreadSheetCell;
  CurrencyID: string;
  i: Integer;
begin

  if InputQuery('Valuta', 'Introduceti codul valutei', CurrencyID) then
  begin
    for i := 1 to cxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
    begin
      cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(i, 6);
      cell.SetText(CurrencyID);
    end;
  end;
end;

procedure TfrmImportGoodsPricesDlg.bbOpenFileClick(Sender: TObject);
begin
  DoOpenFile;
end;

procedure TfrmImportGoodsPricesDlg.bbSaveAsClick(Sender: TObject);
var
  dialog: TFileSaveDialog;
  ft: TFileTypeItem;
begin
  dialog := TFileSaveDialog.Create(Self);
  try
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Excel files';
    ft.FileMask := '*.xlsx';

    if dialog.Execute then
      cxSpreadSheet.SaveToFile(dialog.FileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsPricesDlg.beCustomerPropertiesButtonClick(Sender: TObject; AButtonIndex:
  Integer);
begin
//  ShowSelectCustomerDialog;
end;

procedure TfrmImportGoodsPricesDlg.btnImportClick(Sender: TObject);
var
  count: Integer;
begin
  if bbCodeVendor.Down and (fCustomerID = -1) then
  begin
    ShowErrorDialog('Erroare', 'Alegeti furnizorul!');
    Exit;
  end;

  count := GetCheckGoodsCount;
  if count = 0 then
  begin
    ShowErrorDialog('Eroare', 'Nu sunt validate produsele.');
    Exit;
  end;

  if ShowAskDialog('Import preturi', Format('Doriti sa reevaluati preturile pentru %d produse?', [count]),
    Format('Total inregistrari: %d.', [fGoodsList.count])) = mrYes then
  begin
    case fImportGoodsTarget of
      igtGoodsPrice:
        begin
          if DoImportGoodsDB_PereotenkaTovarov then
          begin
            ShowInfoDialog('Reevaluare', 'Preturile au fost reevaluate.');
            ModalResult := mrOk;
          end;
        end;
      igtVhodnieSceta:
        begin
          if DoImportGoodsDB_VhodnieSceta then
          begin
            ShowInfoDialog('Import', 'Produsele au fost importate');
            ModalResult := mrOk;
          end;
        end;
    end;
  end;
end;

{  verificam daca exista asa cod produs furnizor CPF in tabela ts_goods_foreign }
// functia intoare True daca este gasit CPF
function TfrmImportGoodsPricesDlg.CheckForeignCode(const Code, GoodsTitle: string; var GoodsID:
  Integer; var FlgEpp: boolean): Boolean;
var
  S: string;
  GoodsTitle2: string;
  item: TGoodsInfoItem;
begin
  GoodsID := -1;
  FlgEpp := false;
  Result := False;

  ClearSeachList;
  GoodsTitle2 := StringReplace(GoodsTitle, '"', '', [rfReplaceAll]);
  GoodsTitle2 := StringReplace(GoodsTitle2, '''', '', [rfReplaceAll]);

  IBCQuery.Close;
  IBCQuery.SQL.Clear;
  IBCQuery.SQL.Add('SELECT GOODSID, get_flg_value(flags, 4) flg_epp FROM TMP$FOREIGN_GOODS WHERE (GOODS_CODE=:CODE)');
  IBCQuery.ParamByName('CODE').AsString := Code;
  IBCQuery.Open;

  FlgEpp := (IBCQuery.Fields[1].AsInteger = 1);

  if (ibcquery.RecordCount = 1) then
  begin
    Result := True;
    GoodsID := IBCQuery.Fields[0].AsInteger;
  end
  else if ibcquery.RecordCount > 1 then
    GoodsID := -2; // multi

//  while not IBCQuery.Eof do begin
//    S := StringReplace(GoodsTitle, '"', '', [rfReplaceAll]);
//    S := StringReplace(S, '''', '', [rfReplaceAll]);
//    fTempList.Add(TGoodsInfoItem.Create(IBCQuery.Fields[0].AsInteger, S));
//    IBCQuery.Next;
//  end;
//  IBCQuery.Close;
//
//  if (fTempList.count = 1) then begin
//    Result := True;
//    GoodsID := TGoodsInfoItem(fTempList[0]).fGoodsID;
//  end;
//
//  if (fTempList.count > 1) then begin
//    item := nil;
//    if Assigned(item) then begin
//      Result := True;
//      GoodsID := item.GoodsID;
//    end
//    else
//      GoodsID := -2; // multi
//
//  end;

//  ClearSeachList;
end;

function TfrmImportGoodsPricesDlg.CheckGoodsID(const GoodsID: Integer): Boolean;
begin
  IBCQuery.Close;
  IBCQuery.SQL.Text := 'SELECT GOODSID FROM TS_GOODS WHERE GOODSID=:id';
  IBCQuery.ParamByName('id').AsInteger := GoodsID;
  IBCQuery.ExecSQL;
  Result := not IBCQuery.Eof;
  IBCQuery.Close;
end;

procedure TfrmImportGoodsPricesDlg.ClearGoodsList;
var
  i: Integer;
begin
  for i := 0 to fGoodsList.count - 1 do
    TImportGoodsData(fGoodsList[i]).Free;
  fGoodsList.Clear;
end;

procedure TfrmImportGoodsPricesDlg.ClearSeachList;
var
  i: Integer;
begin
  for i := 0 to fTempList.count - 1 do
    TGoodsInfoItem(fTempList[i]).Free;
  fTempList.Clear;
end;

constructor TfrmImportGoodsPricesDlg.Create(const AOwner: TComponent; const ACustomerID: Integer;
  const ACustomerName: string);
begin
  inherited Create(AOwner);
  CustomerID := ACustomerID;
  CustomerName := ACustomerName
end;

procedure TfrmImportGoodsPricesDlg.AddSupplierCodeToResultSheet(SupplierCode: string);
begin
  UnknownCodeList.Add(SupplierCode);
end;

procedure TfrmImportGoodsPricesDlg.bbRRPCurrencyClick(Sender: TObject);
var
  cell: TdxSpreadSheetCell;
  CurrencyID: string;
  i: Integer;
begin

  if InputQuery('Valuta', 'Introduceti codul valutei', CurrencyID) then
  begin
    for i := 1 to cxSpreadSheet.ActiveSheetAsTable.Rows.LastIndex do
    begin
      cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(i, 5);
      cell.SetText(CurrencyID);
    end;
  end;
end;

procedure TfrmImportGoodsPricesDlg.CreateCell(FontSize: ShortInt; var cell: TdxSpreadSheetCell);
begin

end;

procedure TfrmImportGoodsPricesDlg.cxSpreadSheetSetSelection(Sender: TObject; ASheet:
  TdxSpreadSheetTableView);
begin
  SelectionChanged;
end;

procedure TfrmImportGoodsPricesDlg.DoCheckGoods;
begin
  fImportByInternalGoodsID := bbCodeNeuron.Down;
  fGetCurrencyToSheet := bbGetCurrencyToSheet.Down;
  if fImportByInternalGoodsID then
  begin
    if ShowAskDialog('Validarea produselor',
      'Incepem procedura de validare a codurilor dupa sistema?') = mrYes then
    begin
      try
        Screen.Cursor := crHourGlass;
        DoScanGoods(bbCodeNeuron.Down);
      finally
        Screen.Cursor := crDefault;
      end;
    end;
  end
  else
  begin

    if (fCustomerID = -1) then
    begin
      ShowErrorDialog('Eroare', 'Alageri furnizorul!');
      Exit;
    end;

    try
      Screen.Cursor := crHourGlass;
      DoScanGoods(bbCodeNeuron.Down);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

// reevaluarea bunurilor
function TfrmImportGoodsPricesDlg.DoImportGoodsDB_PereotenkaTovarov: Boolean;
var
  i: Integer;
  Data: TImportGoodsData;
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    try
      Query.Transaction.StartTransaction;
      for i := 0 to fGoodsList.count - 1 do
      begin
        Data := TImportGoodsData(fGoodsList[i]);
        if not Data.Checked then
          Continue;

        if (Data.ByInternalGoodsID) then
        begin
          Query.SQL.Text :=
            'EXECUTE PROCEDURE SP_IMPORT_GOODS_BY_GOODSID(:goodsID,:docID, :price0, ' + ' :price3, :price4, :price5,:price6, :price7, :war, :goodsname)';
          Query.ParamByName('goodsID').AsInteger := Data.GoodsID;
        end
        else
        begin
          Query.SQL.Clear;
          Query.SQL.Add('EXECUTE PROCEDURE SP_IMPORT_GOODS_BY_FOREIGNCODE(');
          Query.SQL.Add(':code,');
          Query.SQL.Add(':docID,');
          Query.SQL.Add(':price0,');
          Query.SQL.Add(':price3,');
          Query.SQL.Add(':price7,');
          Query.SQL.Add(':war,');
          Query.SQL.Add(':cust,');
          Query.SQL.Add(':currency3id,');
          Query.SQL.Add(':currency4id,');
          Query.SQL.Add(':currency7id,');
          Query.SQL.Add(':BARCODE,');
          Query.SQL.Add(':GOODSNAME,');
          Query.SQL.Add('1,');
          Query.SQL.Add(':flg_epp)');

          Query.ParamByName('CODE').AsString := Data.ForeignID;
          Query.ParamByName('CUST').AsInteger := fCustomerID;
          Query.ParamByName('CURRENCY3ID').AsInteger := Data.Currency3ID;
          Query.ParamByName('CURRENCY4ID').AsInteger := Data.Currency4ID;
          Query.ParamByName('CURRENCY7ID').AsInteger := Data.Currency7ID;
          Query.ParamByName('BARCODE').AsString := Data.BarCode;
          Query.ParamByName('FLG_EPP').AsInteger := iif(Data.Price3 > 0, 1, -1);
        end;

        Query.ParamByName('DOCID').AsInteger := fDocID;
        Query.ParamByName('PRICE0').Value := Data.Price0;
        Query.ParamByName('PRICE3').Value := Data.Price3;
        Query.ParamByName('PRICE7').Value := Data.Price7;
        Query.ParamByName('GOODSNAME').Value := Data.Title;
        Query.ParamByName('WAR').Value := Data.Warranty;
        try
          Query.Execute;
        except
          on e: Exception do
          begin
            ShowErrorDialog('Import produse', 'Produsul cu eroare: #' + Data.ForeignID + #13#10 + e.Message);
            raise;
          end;
        end;
      end;

      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;

  finally
    Query.Free;
  end;
end;

function TfrmImportGoodsPricesDlg.DoImportGoodsDB_VhodnieSceta: Boolean;
var
  i: Integer;
  Data: TImportGoodsData;
  Query: TIBCQuery;
begin
  Result := False;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    if (fImportByInternalGoodsID) then
    begin
      Query.SQL.Text := 'EXECUTE PROCEDURE SP_F19_IMPORT_GOODS_BY_GOODSID(:goodsID,:docID,:qty,:price0)';
    end
    else
    begin
      Query.SQL.Text :=
        'EXECUTE PROCEDURE SP_F19_IMPORT_GOODS_BY_FORECODE(:code,:docID,:qty,:price0,:cust)';
      Query.ParamByName('cust').AsInteger := fCustomerID;
    end;

    Query.ParamByName('DOCID').AsInteger := fDocID;

    try
      Query.Transaction.StartTransaction;
      for i := 0 to fGoodsList.count - 1 do
      begin
        Data := TImportGoodsData(fGoodsList[i]);
        if not Data.Checked then
          Continue;

        if (Data.ByInternalGoodsID) then
        begin
          Query.ParamByName('GOODSID').AsInteger := Data.GoodsID;
        end
        else
        begin
          Query.ParamByName('CODE').AsString := Data.ForeignID;
        end;

        Query.ParamByName('QTY').Value := Data.Qty;
        Query.ParamByName('PRICE0').AsFloat := Data.Price0;
        Query.ExecSQL;
      end;

      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        if not ProcessSWNError(E) then
          raise;
      end;
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmImportGoodsPricesDlg.DoOpenFile;
var
  dialog: TFileOpenDialog;
  ft: TFileTypeItem;
begin
  dialog := TFileOpenDialog.Create(Self);
  try
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Excel files';
    ft.FileMask := '*.xls;*.xlsx';

    if dialog.Execute then
      cxSpreadSheet.LoadFromFile(dialog.FileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportGoodsPricesDlg.DoScanGoods(const ValidateByInternalGoodsID: Boolean);
var
  i, j, N: Integer;
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  codeStr: string;
  nameStr: string;
  GoodsID: Integer;
  Checked: Boolean;
  Data, Data2: TImportGoodsData;
  FlgEpp: Boolean;
  FoundGoodsCnt: Integer;
  NewProductsCount: Integer;
  NonIdenticalProductsCount: Integer;
  q: TIBCQuery;
begin
  // init values
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  NonIdenticalProductsCount := 0;
  FoundGoodsCnt := 0;
  ClearGoodsList;
//  tm := 0;
  N := 0;
  NewProductsCount := 0;
  lbUnlinkedGoods.Caption := Format('%d ', [NewProductsCount]);

  dxBarProgressItem1.Max := Sheet.Rows.LastIndex;
  dxBarProgressItem1.Min := 0;

  //make visible progressbar
  dxBarProgressItem1.Visible := ivAlways;

  q := TIBCQuery.Create(Self);
  q.Connection := dmDB.IBCConnection;

  Sheet.BeginUpdate;
  if bbGridHeader.Down = True then
    N := 1;

  dmDB.ExecuteQuery('execute procedure sp_tmp$foreign_goods(:customerid)', [fCustomerID]);

  for i := N to Sheet.Rows.LastIndex do
  begin
    dxBarProgressItem1.Position := i;

    cell := Sheet.Cells[i, 0];
    if (cell = nil) then
      continue;

    codeStr := Trim(cell.DisplayValue.Text);
    if (pos('(multi) ', codeStr) > 0) then
      codeStr := Copy(codeStr, 9, Length(codeStr));
    if codeStr = '' then
      Continue;

    Checked := False;
    if (ValidateByInternalGoodsID) then
    begin
      // verify by GoodsID
      GoodsID := StrToIntDef(codeStr, -1);
      if GoodsID > -1 then
        Checked := CheckGoodsID(GoodsID)
    end
    else
    begin
      // veridicam dupa CPF
      if Assigned(Sheet.Cells[i, 1]) then
      begin
        cell := Sheet.Cells[i, 1]; // product title
        nameStr := cell.AsString;
      end;

      Checked := CheckForeignCode(codeStr, nameStr, GoodsID, FlgEpp);
      cell := Sheet.Cells[i, 11];
      if FlgEpp then
        if not assigned(Sheet.Cells[i, 11]) then
        begin
          cell := Sheet.CreateCell(i, 11);
          cell.SetText('*')
        end;

      if fGetCurrencyToSheet then
        UpdateSheetGoodsCurrency(codeStr, SupplierID, GoodsID, i, Sheet);

      ValidateGoodsPrices(codeStr, GoodsID, Sheet, i);
//      if not ValidateGoodsPrices(codeStr, GoodsID, Sheet, i) then
//      begin
//        Continue;
//      end;
    end;
    Application.ProcessMessages;
    Data := TImportGoodsData.Create;
    Data.GoodsID := GoodsID;
    Data.ForeignID := Trim(codeStr);
    Data.RowIndex := i;
    Data.ByInternalGoodsID := ValidateByInternalGoodsID;
    Data.Checked := Checked;
    fGoodsList.Add(Data);

    if Checked then
    begin
      case fImportGoodsTarget of
        igtGoodsPrice:
          ProcessGoodsDataFromCell_PereotenkaTovarov(Sheet, i, Data);

        igtVhodnieSceta:
          ProcessGoodsDataFromCell_VhodnieSceta(Sheet, i, Data);
      end;
      Inc(FoundGoodsCnt);
      lbFoundGoods.Caption := FoundGoodsCnt.ToString;
      Application.ProcessMessages;
    end
    else
    begin
      if GoodsID = -2 then
      begin
        // multiple goods found
        cell := Sheet.Cells[i, 0];
        if Assigned(cell) then
        begin
          cell.SetText(Format('(multi) %s', [cell.DisplayText]));
          cell.Style.Brush.BackgroundColor := clWebOrange;
          cell.Style.Font.Color := clBlack;
          Inc(NonIdenticalProductsCount);
        end;

        lbNonIdenticalGoods.Caption := Format('%d', [NonIdenticalProductsCount]);
        Application.ProcessMessages;
      end
      else
      begin
        for j := 0 to Sheet.Columns.LastIndex do
        begin
          cell := Sheet.Cells[i, j];
          if Assigned(cell) then
          begin
            cell.Style.Brush.BackgroundColor := clWhite;
            cell.Style.Font.Color := clRed;
            AddSupplierCodeToResultSheet(codeStr);
          end;

          // флаги найденного товара
          cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(i, 8);

          cell.Style.Brush.BackgroundColor := clWhite;
          cell.Style.Font.Color := clRed;
          cell.column.Size := 40;
          cell.SetText('нет');
        end;
        Inc(NewProductsCount);
        lbUnlinkedGoods.Caption := Format('%d', [NewProductsCount]);
      end;
    end;
  end;
  // /// /     ShowMessage(FloatToStr(tm));
  Application.ProcessMessages;
  // 2. verify if GoodsID is uniqe
  dxBarProgressItem1.Max := fGoodsList.count - 1;
  dxBarProgressItem1.Min := 0;
  dxBarProgressItem1.Position := 0;
  for i := 0 to fGoodsList.count - 1 do
  begin
    dxBarProgressItem1.Position := i;
    Data := TImportGoodsData(fGoodsList[i]);
    if (Data.Checked) then
      for j := 0 to fGoodsList.count - 1 do
      begin
        Data2 := TImportGoodsData(fGoodsList[j]);
        if (i <> j) and Data2.Checked then
          if (Data2.GoodsID = Data.GoodsID) and (Data2.ForeignID = Data.ForeignID) then
          begin
            cell := Sheet.Cells[Data2.RowIndex, 0];
            cell.Style.Brush.BackgroundColor := clWebPeachPuff;
            Inc(NonIdenticalProductsCount);
            Data2.Checked := False;
          end;
      end;
  end;
  dxBarProgressItem1.Visible := ivNever;
  Sheet.EndUpdate;

end;

procedure TfrmImportGoodsPricesDlg.dxBarButton2Click(Sender: TObject);
var
  i: Integer;
  Sheet: TdxSpreadSheetTableView;
  cell: TdxSpreadSheetCell;
begin
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  for i := 1 to Sheet.Rows.LastIndex do
  begin
    if not Assigned(Sheet.Cells[i, 9]) then
      cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(i, 9);

    if (Sheet.Cells[i, 9].AsString <> '') then
      Sheet.Cells[i, 9].SetText('')
    else
      Sheet.Cells[i, 9].SetText('*');
  end;
end;

procedure TfrmImportGoodsPricesDlg.FormCreate(Sender: TObject);
begin
  fGoodsList := TList.Create;
  fTempList := TList.Create;
  fImportGoodsTarget := igtGoodsPrice;
  UnknownCodeList := TStringList.Create;
end;

procedure TfrmImportGoodsPricesDlg.FormDestroy(Sender: TObject);
begin
  ClearGoodsList;
  fGoodsList.Free;
  fTempList.Free;
  UnknownCodeList.Free;
end;

function TfrmImportGoodsPricesDlg.GetCheckGoodsCount: Integer;
var
  i: Integer;
  Data: TImportGoodsData;
begin
  Result := 0;
  for i := 0 to fGoodsList.Count - 1 do
  begin
    Data := TImportGoodsData(fGoodsList[i]);
    if (Data.Checked) then
      Inc(Result);
  end;
end;

procedure TfrmImportGoodsPricesDlg.UpdateSheetGoodsCurrency(codeStr: string; SupplierID, GoodsID,
  rowIndex: Integer; Sheet: TdxSpreadSheetTableView);
var
  q: TIBCQuery;
  cell10, cell11: TdxSpreadSheetCell;
begin
  q := TIBCQuery.Create(Self);
  try
    q.SQL.Text := 'select currency3id, currency7id from ts_goods_foreign where ' +
      'customerid = :supplierid and goodsid = :goodsid and goods_code = :goods_code';
    q.ParamByName('supplierid').AsInteger := SupplierID;
    q.ParamByName('goodsid').AsInteger := GoodsID;
    q.ParamByName('goods_code').AsString := codeStr;
    q.Open;
    if q.RecordCount > 0 then
    begin
      cell10 := Sheet.CreateCell(rowIndex, 10);
      cell10.Asinteger := q.FieldByName('Currency3ID').AsInteger;

      cell11 := Sheet.CreateCell(rowIndex, 11);
      cell11.Asinteger := q.FieldByName('Currency7ID').AsInteger;
    end;
  finally
    q.Free;
  end;
end;

function TfrmImportGoodsPricesDlg.GetRecordDataByRowIndex(const RowIndex: Integer): TImportGoodsData;
var
  i: Integer;
  Data: TImportGoodsData;
begin
  Result := nil;
  for i := 0 to fGoodsList.count - 1 do
  begin
    Data := TImportGoodsData(fGoodsList[i]);
    if (Data.RowIndex = RowIndex) then
    begin
      Result := Data;
      Break;
    end;
  end;
end;

procedure TfrmImportGoodsPricesDlg.LoadCustomerInfo;
//var
//  Query: TIBCQuery;
begin
//  Query := TIBCQuery.Create(Self);
//  try
//    Query.Connection := dmDB.IBCConnection;
//    Query.SQL.Text := 'SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=:id';
//    Query.ParamByName('id').AsInteger := CustomerID;
//    Query.Open;
//    if Query.Eof then
//      fCustomerID := -1
//  finally
//    Query.Free;
//  end;
end;

procedure TfrmImportGoodsPricesDlg.LoadStates;
begin
end;

procedure TfrmImportGoodsPricesDlg.Prepare;
begin
  PrepareGridView;
end;

procedure TfrmImportGoodsPricesDlg.PrepareGridView;
begin
  case fImportGoodsTarget of
    igtGoodsPrice:
      begin
        cxPageControl1.ActivePageIndex := 0;
        PrepareGridView_PereotenkaTovarov;
      end;

    igtVhodnieSceta:
      begin
        cxPageControl1.ActivePageIndex := 0;
        PrepareGridView_VhodnieSceta;
      end;
  end;
end;

procedure TfrmImportGoodsPricesDlg.PrepareGridView_PereotenkaTovarov;
const
  FontSize = 9;
  FontName = 'Tahoma';
var
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
begin
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  cxSpreadSheet.Font.Name := FontName;
  cxSpreadSheet.Font.Size := FontSize;
  Sheet.Caption := 'Produse';

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 0);
  cell.column.Size := 100;
  cell.Style.Font.Style := [fsBold];
//  cell.Style.Font.Size := FontSize;
  cell.SetText('Cod furnizor');
  CreateCell(FontSize, cell);

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 1);
  cell.column.Size := 450;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Denumire Produs');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 2);
  cell.column.Size := 70;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Pret RRP');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 3);
  cell.column.Size := 70;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Pret 7');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 4);
  cell.column.Size := 70;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Garantia');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 5);
  cell.column.Size := 70;
  cell.Style.AlignHorz := ssahCenter;
  cell.Style.Brush.BackgroundColor := clcxLightGray;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Valuta RRP');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 6);
  cell.column.Size := 70;
  cell.Style.AlignHorz := ssahCenter;
  cell.Style.Brush.BackgroundColor := clcxLightGray;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Valuta 7');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 7);
  cell.column.Size := 100;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Barcode');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 8);
  cell.column.Size := 50;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Statut');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 9);
  cell.column.Size := 70;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Valuta 4');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 10);
  cell.column.Size := 70;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Pret 0');

  cell := cxSpreadSheet.ActiveSheetAsTable.CreateCell(0, 11);
  cell.column.Size := 50;
  cell.Style.Font.Style := [fsBold];
  cell.SetText('Flag RRP');

  cxSpreadSheet.ActiveSheetAsTable.Selection.SelectCell(1, 0);
end;

procedure TfrmImportGoodsPricesDlg.PrepareGridView_VhodnieSceta;
var
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
begin
  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  Sheet.Caption := 'Товары';

  cell := Sheet.CreateCell(0, 0);
  cell.column.Size := 120; // foreign code
  cell.SetText('Код поставщика');

  cell := Sheet.CreateCell(0, 1);
  cell.column.Size := 450; // title
  cell.SetText('Название товара');

  cell := Sheet.CreateCell(0, 2);
  cell.column.Size := 80; // QTY
  cell.SetText('Кол-во');

  cell := Sheet.CreateCell(0, 3);
  cell.column.Size := 80; // price 0
  cell.SetText('Цена 0');

  cxSpreadSheet.ActiveSheetAsTable.Selection.SelectCell(1, 0);
end;

procedure TfrmImportGoodsPricesDlg.ProcessGoodsDataFromCell_PereotenkaTovarov(const Sheet:
  TdxSpreadSheetTableView; const RowIndex: Integer; const Data: TImportGoodsData);
var
  j: Integer;
  cell: TdxSpreadSheetCell;
  tmpText: string;
  tmpValFloat: Double;
  CellValue: Variant;
begin
  Sheet.BeginUpdate;
  for j := 0 to Sheet.Columns.LastIndex do
  begin
    if Assigned(Sheet.Cells[RowIndex, j]) then
    begin
      cell := Sheet.Cells[RowIndex, j];
      if j > 1 then // TItle lasam intact
      begin
        cell.AsString := StringReplace(cell.AsString, ' ', '', [rfReplaceAll]);
        StrToFloatDef(cell.AsString, -1);
      end;
      try
        tmpText := UpperCase(Trim(cell.AsString));
        if tmpText <> '' then
        begin

          case j of
            0:
              Data.SupplierGoodsCode := cell.AsString;
            1:
              Data.Title := cell.AsString;
            2:
              begin
                Data.Price3 := cell.AsString;
                if (Sheet.Cells[RowIndex, j].AsString <> '') and (cell.AsString = '') then
                begin
                  cell.Style.Brush.BackgroundColor := clRed;
                  cell.Style.Font.Color := clYellow;
                end;
              end;
            3:
              Data.Price7 := cell.AsString;
            4:
              Data.Warranty := cell.AsString;
            5:
              Data.Currency3ID := cell.AsString;
            6:
              Data.Currency7ID := cell.AsString;
            7:
              Data.BarCode := cell.AsString;
            9:
              Data.Currency4ID := cell.AsString;
            10:
              begin
                if assigned(cell) then
                  Data.Price0 := cell.AsString
              end;
            11:
              Data.flg_epp := cell.AsInteger;
          end;
        end;
      except
        begin
            // incercam sa scoatem cei de prisos
          tmpText := UpperCase(Trim(cell.AsString));
          if Text <> '' then
          begin
            tmpText := Trim(StringReplace(tmpText, 'MDL', '', [rfReplaceAll]));
            tmpText := Trim(StringReplace(tmpText, 'MONTH', '', [rfReplaceAll]));
            tmpValFloat := StrToFloatDef(tmpText, -1);
            if (tmpValFloat > 0) then
            begin
              case j of
                0:
                  Data.SupplierGoodsCode := cell.AsString;
                1:
                  Data.Title := tmpText;
                2:
                  Data.Price3 := tmpValFloat;
                3:
                  Data.Price7 := tmpValFloat;
                4:
                  Data.Warranty := Trunc(tmpValFloat);
                5:
                  Data.Currency3ID := cell.AsString;
                6:
                  Data.Currency7ID := cell.AsString;
                7:
                  Data.BarCode := cell.AsString;
                9:
                  Data.Currency4ID := cell.AsString;
                10:
                  begin
                    if assigned(cell) then
                      Data.Price0 := cell.AsString
                  end;
                11:
                  Data.flg_epp := iif(Length(cell.AsString) > 0, 1, -1);
              end;
            end
            else
              cell.Style.Brush.BackgroundColor := clRed; // no value
          end
          else    // cell has no value
            cell.Style.Brush.BackgroundColor := clPurple; // no value
        end;
      end;
    end;
  end;
  Sheet.EndUpdate;
end;

procedure TfrmImportGoodsPricesDlg.ProcessGoodsDataFromCell_VhodnieSceta(const Sheet:
  TdxSpreadSheetTableView; const RowIndex: Integer; const Data: TImportGoodsData);
var
  j: Integer;
  cell: TdxSpreadSheetCell;
  cellprice7: TdxSpreadSheetCell;
  cellprice8: TdxSpreadSheetCell;
  tmpText: string;
  tmpValFloat: Double;
  ibcquery: TIBCQuery;
begin
  // check price columns
  ibcquery := TIBCQuery.Create(Self);
  Sheet.BeginUpdate;
  try
    for j := 2 to Sheet.Columns.count - 1 do
    begin
      cell := Sheet.Cells[RowIndex, j];
      if not Assigned(cell) then
        continue;
      cell.SetText(StringReplace(cell.AsString, ' ', '', [rfReplaceAll]));
      if VarIsNumeric(cell.AsFloat) then
      begin
        case j of
          2:
            Data.Qty := cell.AsFloat;
          3:
            begin
              Data.Price0 := cell.AsVariant;
              ibcquery.Close;
              ibcquery.SQL.Text := 'select price from get_goods_price7(:goodsid, :currency7id)';
              ibcquery.ParamByName('CURRENCY7ID').AsInteger := dmDB.ibcquerydocs.FieldByName('CURRENCYID').AsInteger;
              ibcquery.ParamByName('GOODSID').AsInteger := Data.GoodsID;
              ibcquery.Open;

              // add price7 to sheet
              cellprice7 := cxSpreadSheet.ActiveSheetAsTable.CreateCell(RowIndex, 4);
              cellprice7.AsFloat := ibcquery.FieldByName('PRICE').AsFloat;

              cellprice8 := cxSpreadSheet.ActiveSheetAsTable.CreateCell(RowIndex, 5);
              cellprice8.AsString := format('%0.2n', [Abs(1 - ibcquery.FieldByName('PRICE').AsFloat
                / Sheet.Cells[RowIndex, 3].AsFloat) * 100]) + '%';

              if ibcquery.FieldByName('PRICE').AsFloat < Data.Price0 then
              begin
                cell.Style.Brush.BackgroundColor := clWebOrange;
              end;
            end;
        end;
      end
      else
      begin
      // incercam sa scoatem cei de prisos
        tmpText := UpperCase(Trim(cell.AsString));
        if Text <> '' then
        begin
          tmpText := Trim(StringReplace(tmpText, 'MDL', '', [rfReplaceAll]));
          tmpText := Trim(StringReplace(tmpText, 'MONTH', '', [rfReplaceAll]));
          tmpValFloat := StrToFloatDef(tmpText, -1);
          if (tmpValFloat > 0) then
          begin
            case j of
              2:
                Data.Qty := Trunc(tmpValFloat);
              3:
                begin
                  Data.Price0 := tmpValFloat;
                end;
            end;
          end
          else
            cell.Style.Brush.BackgroundColor := clWebGreenYellow; // no value
        end
        else
          cell.Style.Brush.BackgroundColor := clWebOrange; // no value
      end;
    end;
  finally
    ibcquery.Free;
  end;
  Sheet.EndUpdate;
end;

procedure TfrmImportGoodsPricesDlg.SaveStates;
begin
//  AppUserConfigStorage.OpenSection(Self.Name);
//  try
//    AppUserConfigStorage.IntValues.SetValue('VendorID', fCustomerID);
//  finally
//    AppUserConfigStorage.CloseSection;
//  end;
end;

procedure TfrmImportGoodsPricesDlg.SelectionChanged;
var
  Data: TImportGoodsData;
begin
  Data := GetRecordDataByRowIndex(cxSpreadSheet.ActiveSheetAsTable.Selection.FocusedRow);
  bbGoods.Enabled := Assigned(Data);
end;

procedure TfrmImportGoodsPricesDlg.SetCustomerID(const Value: Integer);
begin
  fCustomerID := Value;
end;

procedure TfrmImportGoodsPricesDlg.SetCustomerName(const Value: string);
begin
  fCustomerName := Value;
end;

procedure TfrmImportGoodsPricesDlg.SetDocID(const Value: Integer);
begin
  fDocID := Value;
end;

procedure TfrmImportGoodsPricesDlg.SetImportGoodsTarget(const Value: TImportGoodsTarget);
begin
  fImportGoodsTarget := Value;
end;

procedure TfrmImportGoodsPricesDlg.SetSupplierID(const Value: Integer);
begin
  FSupplierID := Value;
end;

// TODO: ShowSelectCustomerDialog
//procedure TfrmImportGoodsPricesDlg.ShowSelectCustomerDialog;
//var
//dialog: TfrmCustomersDlg;
//begin
//dialog := TfrmCustomersDlg.Create(Self);
//try
//  if dialog.SelectCustomer(CustomerID, False, 0, 'Alegeti furnizorul:') then begin
//    CustomerID := dialog.CustomerID;
//  end;
//finally
//  dialog.Free;
//end;
//end;

function TfrmImportGoodsPricesDlg.ValidateGoodsPrices(codeStr: string; GoodsID: Integer; Sheet:
  TdxSpreadSheetTableView; RowIndex: Integer): Boolean;
var
  PriceRRP: Double;
  tmpPrice: string;
  FlgRrp: Boolean;
begin
  Result := True;
  PriceRRP := -1;
  FlgRrp := False;

  try
    // PRICE_RRP
    if Assigned(Sheet.cells[RowIndex, 2]) then
    begin
      tmpPrice := stringReplace(Sheet.cells[RowIndex, 2].AsString, ' ', '', [rfReplaceAll]);
      if tmpPrice <> '' then
        PriceRRP := tmpPrice.ToDouble;
    end;

    //FLG_EPP value
    if Assigned(Sheet.Cells[RowIndex, 11]) then
      FlgRrp := (Sheet.Cells[RowIndex, 11].AsString <> '');

  except
    on e: Exception do
    begin
      Result := False;
      Sheet.Cells[RowIndex, 2].Style.Brush.ForegroundColor := clRed;
      Sheet.Cells[RowIndex, 2].Style.Font.Color := clYellow;
    end;
  end;
//
  if (FlgRrp) and (PriceRRP <= 0) then
  begin
    Result := False;
    if not Assigned(Sheet.Cells[RowIndex, 2]) then
    begin
      var cell := Sheet.CreateCell(RowIndex, 2);
      cell.Style.Brush.ForegroundColor := clWebYellow;
      cell.Style.Font.Color := clBlack;
//    raise Exception.Create('Eroare! Produse cu FLG_RRP si pret_rrp = 0!');
    end;
  end;
end;

{ TImportGoodsData }

constructor TImportGoodsData.Create;
begin
  GoodsID := -1;
  ForeignID := '';
  Price0 := Null;
//  Price1 := Null;
//  Price2 := Null;
  Price3 := Null;
//  Price4 := Null;
//  Price5 := Null;
//  Price6 := Null;
  Price7 := Null;
  Warranty := Null;
  rowIndex := -1;
  ByInternalGoodsID := False;
  Checked := False;
  BarCode := '';
  flg_epp := -1;
end;

{ TGoodsInfoItem }

constructor TGoodsInfoItem.Create(const AGoodsID: Integer; const ATitle: string);
begin
  fGoodsID := AGoodsID;
  fTitle := ATitle;
end;

end.


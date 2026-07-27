unit frmZTK_ImportGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, DialogTitle, StdCtrls, cxClasses, dxBar, ExtCtrls, DB,
  MemDS, DBAccess, IBC, cxButtonEdit, cxBarEditItem, dxCore, dxCoreClasses,
  dxHashUtils, dxSpreadSheetCore, dxSpreadSheetPrinting, dxSpreadSheetFormulas,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetClasses,
  dxSpreadSheetTypes, dxBarBuiltInMenu, dxSpreadSheet, dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetContainers, dxSpreadSheetHyperlinks, dxSpreadSheetUtils,
  dxSpreadSheetCoreFormulas, dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetStyles,
  dxSpreadSheetFormattedTextUtils, Vcl.Menus, cxButtons;

type
  TImportGoodsData = class
    GoodsID: integer;
    ForeignID: string;
    Title: string;
    Qty: double;
    Price: variant;
    RowIndex: integer;
    constructor Create;
  end;

  TfrmZTKImportGoodsDlg = class(TSWNCustomForm)
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
    bbCheckGoods: TdxBarButton;
    bbGridHeader: TdxBarButton;
    IBCQuery: TIBCQuery;
    dxBarSubItem1: TdxBarSubItem;
    bbShowFormulas: TdxBarButton;
    beVENDOR: TcxBarEditItem;
    cxSpreadSheet: TdxSpreadSheet;
    btnCancel: TcxButton;
    btnImport: TcxButton;
    procedure bbOpenFileClick(Sender: TObject);
    procedure bbClearAllClick(Sender: TObject);
    procedure bbCheckGoodsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbShowFormulasClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure beVENDORPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
  private
    { Private declarations }
    fGoodsList: TList;
    fDocID: integer;
    fImportByNeuronCode: Boolean;
    fVendorID: integer;
    procedure ClearGoodsList;
    procedure DoOpenFile;
    procedure DoCheckGoods;
    procedure DoScanGoods(const NeuronCode: Boolean);
    function CheckGoodsID(const GoodsID: integer): Boolean;
    function CheckForeignCode(const Code: string; var GoodsID: integer): Boolean;
    function DoImportGoodsDB_ByGoodsID: Boolean;
    procedure SetDocID(const Value: integer);
    procedure CreateSheetDefaultInfo;
    procedure ClearVendor;
    procedure SelectVendor;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property DocID: integer read fDocID write SetDocID;
    procedure SetVendorInfo(const VendorID: integer; const VendorTitle: string);
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNDBErrors,
  frmCustomersDlg;

{$R *.dfm}
{ TfrmImportGoodsPricesDlg }

procedure TfrmZTKImportGoodsDlg.bbCheckGoodsClick(Sender: TObject);
begin
  DoCheckGoods;
end;

procedure TfrmZTKImportGoodsDlg.bbClearAllClick(Sender: TObject);
begin
  cxSpreadSheet.ClearAll;
  ;
end;

procedure TfrmZTKImportGoodsDlg.bbOpenFileClick(Sender: TObject);
begin
  DoOpenFile;
end;

procedure TfrmZTKImportGoodsDlg.bbShowFormulasClick(Sender: TObject);
begin
  // cxSpreadSheet.ShowFormulas:=bbShowFormulas.Down;
  if bbShowFormulas.Down then
    cxSpreadSheet.ActiveSheetAsTable.Options.ShowFormulas := bTrue;

end;

procedure TfrmZTKImportGoodsDlg.beVENDORPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  case AButtonIndex of
    0:
      ClearVendor;
    1:
      SelectVendor;
  end;
end;

procedure TfrmZTKImportGoodsDlg.btnImportClick(Sender: TObject);
begin
  if fGoodsList.Count = 0 then
    ShowErrorDialog('Ошибка', 'Нету проверенных товаров.')
  else if ShowAskDialog('Импорт количества и цены товаров', Format('Вы хотите импортировать данные для %d товаров ?', [fGoodsList.Count])) = mrYes then
  begin
    if DoImportGoodsDB_ByGoodsID then
    begin
      ShowInfoDialog('Импорт товаров', 'Товары импортированны.');
      ModalResult := mrOk;
    end;
  end;
end;

function TfrmZTKImportGoodsDlg.CheckForeignCode(const Code: string; var GoodsID: integer): Boolean;
var
  Count: integer;
begin
  GoodsID := -1;
  Count := 0;

  IBCQuery.Close;
  IBCQuery.SQL.Clear;
  IBCQuery.SQL.Add('SELECT GOODSID FROM TS_GOODS_FOREIGN WHERE GOODS_CODE=:code');
  if fVendorID > 0 then
    IBCQuery.SQL.Add(' AND CUSTOMERID=:ID');
  IBCQuery.ParamByName('code').AsString := Code;
  if fVendorID > 0 then
    IBCQuery.ParamByName('ID').AsInteger := fVendorID;
  IBCQuery.ExecSQL;
  while not IBCQuery.Eof do
  begin
    inc(Count);
    GoodsID := IBCQuery.Fields[0].AsInteger;
    IBCQuery.Next;
  end;
  Result := Count = 1;
  IBCQuery.Close;
end;

function TfrmZTKImportGoodsDlg.CheckGoodsID(const GoodsID: integer): Boolean;
begin
  IBCQuery.Close;
  IBCQuery.SQL.Text := 'SELECT GOODSID FROM TS_GOODS WHERE GOODSID=:id';
  IBCQuery.ParamByName('id').AsInteger := GoodsID;
  IBCQuery.ExecSQL;
  Result := not IBCQuery.Eof;
  IBCQuery.Close;
end;

procedure TfrmZTKImportGoodsDlg.ClearGoodsList;
var
  i: integer;
begin
  for i := 0 to fGoodsList.Count - 1 do
    TImportGoodsData(fGoodsList[i]).Free;
  fGoodsList.Clear;
end;

procedure TfrmZTKImportGoodsDlg.ClearVendor;
begin
  beVENDOR.EditValue := 'все поставщики';
  fVendorID := -1;
end;

procedure TfrmZTKImportGoodsDlg.CreateSheetDefaultInfo;
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
  cell.column.Size := 350; // title
  cell.SetText('Название товара');

  cell := Sheet.CreateCell(0, 2);
  cell.column.Size := 80; // price0
  cell.SetText('Кол-во');

  cell := Sheet.CreateCell(0, 3);
  cell.column.Size := 80; // price5
  cell.SetText('Цена');


  // cxSpreadSheet.Sheet.Cols.Size[0]:=120;  // foreign code
  // cxSpreadSheet.Sheet.Cols.Size[1]:=400;  // title
  // cxSpreadSheet.Sheet.Cols.Size[2]:=80;  // QTY
  // cxSpreadSheet.Sheet.Cols.Size[3]:=60;  // price

  // foreign code
  cell := Sheet.Cells[0, 0];
  cell.SetText('Код производителя*');
  // title
  cell := Sheet.Cells[0, 1];
  cell.SetText('Название товара');
  // price 0
  cell := Sheet.Cells[0, 2];
  cell.SetText('Количество*');
  // price 5
  cell := Sheet.Cells[0, 3];
  cell.SetText('Цена*');

  cxSpreadSheet.ActiveSheetAsTable.Selection.SelectCell(1, 0);
end;

procedure TfrmZTKImportGoodsDlg.DoCheckGoods;
var
  S: string;
begin
  fImportByNeuronCode := bbCodeNeuron.Down;
  if fImportByNeuronCode then
    S := 'из Неурона'
  else
  begin
    if fVendorID = -1 then
      S := 'от всех поставщиков'
    else
      S := Format('от поставщика "%s"', [beVENDOR.EditValue]);
  end;

  if ShowAskDialog('Проверка товаров', Format('Вы хотите проверить все товары по коду товара %s?', [S])) = mrYes then
    DoScanGoods(bbCodeNeuron.Down);
end;

function TfrmZTKImportGoodsDlg.DoImportGoodsDB_ByGoodsID: Boolean;
var
  i: integer;
  data: TImportGoodsData;
  Query: TIBCQuery;
begin
  Result := False;
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.SQL.Text := 'EXECUTE PROCEDURE SP_IMPORT_GOODS_ZTK(:docID,:goodsID,:qty,:price)';
    Query.ParamByName('docID').AsInteger := fDocID;

    try
      Query.Transaction.StartTransaction;
      for i := 0 to fGoodsList.Count - 1 do
      begin
        data := TImportGoodsData(fGoodsList[i]);
        Query.ParamByName('goodsID').AsInteger := data.GoodsID;
        Query.ParamByName('qty').AsFloat := data.Qty;
        Query.ParamByName('price').AsFloat := data.Price;

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

procedure TfrmZTKImportGoodsDlg.DoOpenFile;
var
  dialog: TFileOpenDialog;
  ft: TFileTypeItem;
begin
  dialog := TFileOpenDialog.Create(Self);
  try
    ft := dialog.FileTypes.Add;
    ft.DisplayName := 'Excel files';
    ft.FileMask := '*.xls';

    if dialog.Execute then
      cxSpreadSheet.LoadFromFile(dialog.FileName);
  finally
    dialog.Free;
  end;
end;

procedure TfrmZTKImportGoodsDlg.DoScanGoods(const NeuronCode: Boolean);
var
  i, j, N: integer;
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  codeStr: string;
  GoodsID: integer;
  hasCode, hasQTY, hasPrice: Boolean;
  data, data2: TImportGoodsData;
  errorCount: integer;
begin
  ClearGoodsList;

  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  N := 0;
  if bbGridHeader.Down then
    N := 1;

  errorCount := 0;
  for i := N to Sheet.Rows.Count - 1 do
  begin
    cell := Sheet.Cells[i, 0];
    codeStr := cell.AsString;
    if codeStr = '' then
    begin
      for j := 0 to Sheet.Columns.Count - 1 do
      begin
        cell := Sheet.Cells[i, j];
        cell.Style.Brush.BackgroundColor := 15;
        cell.Style.Font.Color := 1;
      end;
      Continue;
    end;

    hasCode := False;
    if NeuronCode then
    begin
      // verify by GoodsID
      GoodsID := StrToIntDef(codeStr, -1);
      if GoodsID > -1 then
        hasCode := CheckGoodsID(GoodsID)
    end
    else
    begin
      hasCode := CheckForeignCode(codeStr, GoodsID);
    end;

    hasQTY := True;
    hasPrice := True;

    if hasCode then
    begin
      data := TImportGoodsData.Create;
      data.GoodsID := GoodsID;
      data.ForeignID := codeStr;
      data.RowIndex := i;
      // check QTY
      cell := Sheet.Cells[i, 2];
      if VarIsFloat(cell.AsFloat) and (cell.AsFloat > 0) then
      begin
        data.Qty := cell.AsFloat;
      end
      else
        hasQTY := False;

      // check PRICE
      cell := Sheet.Cells[i, 3];
      if VarIsFloat(cell.AsFloat) and (cell.AsFloat > 0) then
      begin
        data.Price := cell.AsFloat;
      end
      else
        hasPrice := False;

      fGoodsList.Add(data);
    end;

    if (not hasCode) or (not hasQTY) or (not hasPrice) then
    begin
      inc(errorCount);
      for j := 0 to Sheet.Columns.count - 1 do
      begin
        cell := Sheet.Cells[i, j];
        if (j = 0) and (not hasCode) then
          cell.Style.Brush.BackgroundColor := 11
        else if (j = 2) and (not hasQTY) then
          cell.Style.Brush.BackgroundColor := 11
        else if (j = 3) and (not hasPrice) then
          cell.Style.Brush.BackgroundColor := 11
        else
          cell.Style.Brush.BackgroundColor := 8;
        cell.Style.Font.Color := 1;
      end;
    end;
  end;

  // 2. verify if GoodsID is uniqe
  for i := 0 to fGoodsList.Count - 1 do
  begin
    data := TImportGoodsData(fGoodsList[i]);
    for j := 0 to fGoodsList.Count - 1 do
      if (i <> j) then
      begin
        data2 := TImportGoodsData(fGoodsList[j]);
        if data2.GoodsID = data.GoodsID then
        begin
          cell := Sheet.Cells[data.RowIndex, 0];
          cell.Style.Brush.BackgroundColor := 45;
        end;
      end;
  end;

  if errorCount > 0 then
    ShowErrorDialog('Ошибка', Format('Есть ошибочные данные. Всего записей: %d', [errorCount]))
  else
    ShowInfoDialog('Данные проверенны', 'Данные проверенны. Можете смело импортировать.');
end;

procedure TfrmZTKImportGoodsDlg.FormCreate(Sender: TObject);
begin
  fGoodsList := TList.Create;
  ClearVendor;
end;

procedure TfrmZTKImportGoodsDlg.FormDestroy(Sender: TObject);
begin
  ClearGoodsList;
  fGoodsList.Free;
end;

procedure TfrmZTKImportGoodsDlg.Prepare;
begin
  CreateSheetDefaultInfo;
  if bbShowFormulas.Down then
    cxSpreadSheet.ActiveSheetAsTable.Options.ShowFormulas := bTrue;

end;

procedure TfrmZTKImportGoodsDlg.SelectVendor;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fVendorID, False, 0, 'Выберите поставщика для товаров в импорте') then
    begin
      fVendorID := dialog.CustomerID;
      beVENDOR.EditValue := dialog.CustomerTitle;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmZTKImportGoodsDlg.SetDocID(const Value: integer);
begin
  fDocID := Value;
end;

procedure TfrmZTKImportGoodsDlg.SetVendorInfo(const VendorID: integer; const VendorTitle: string);
begin
  fVendorID := VendorID;
  beVENDOR.EditValue := VendorTitle;
end;

{ TImportGoodsData }

constructor TImportGoodsData.Create;
begin
  GoodsID := -1;
  ForeignID := '';
  Title := '';
  Qty := 0;
  Price := Null;
end;

end.


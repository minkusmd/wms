unit frmImportForeignGoodsIntoTableDialog;
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, DialogTitle, StdCtrls,
  cxClasses, dxBar, ExtCtrls, DB, MemDS, DBAccess, IBC, cxContainer, cxEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxTextEdit, cxMaskEdit, cxCalendar,
  cxButtonEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxLabel, Menus, Buttons, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxNavigator, dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetPrinting, dxSpreadSheetFormulas,
  dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetClasses, dxSpreadSheetTypes, dxBarBuiltInMenu,
  dxSpreadSheet, dxSpreadSheetCoreHistory, dxSpreadSheetConditionalFormatting, dxSpreadSheetConditionalFormattingRules,
  dxSpreadSheetContainers, dxSpreadSheetHyperlinks, dxSpreadSheetUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs,
  dxSpreadSheetStyles, dxSpreadSheetFormattedTextUtils, dxDateRanges, dxSpreadSheetCoreFormulas, dxScrollbarAnnotations;

type

  TCheckGoodsInfo = record
    GoodsID: integer;
    SupplierID: integer; // CustomerID
    SupplierName: String; // Customer Name
    GoodsTitle: String; // Goods Title
  end;

  TImportGoodsData = class
    GoodsID: integer;
    ForeignID: string;
    SupplierID: integer;
    SupplierName: string;
    Title: String;
    Qty: double;
    Price: variant;
    QtyRealizatia: double;
    QtyOstatok: double;

    RowIndex: integer;
    Checked: Boolean;

    Processed: Boolean;

    constructor Create;

  end;

  TfrmImportForeignGoodsIntoTableDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    pnButtons: TPanel;
    btnCancel: TButton;
    bbOpenFile: TdxBarButton;
    bbClearAll: TdxBarButton;
    bbCheckGoods: TdxBarButton;
    bbGridHeader: TdxBarButton;
    IBCQuery: TIBCQuery;
    dxBarSubItem1: TdxBarSubItem;
    bbShowFormulas: TdxBarButton;
    bbGoods: TdxBarButton;
    Notebook: TNotebook;
    dxBarDockControl1: TdxBarDockControl;
    pnLegend: TPanel;
    Label2: TLabel;
    Shape4: TShape;
    lbCodeRepeated: TLabel;
    Shape2: TShape;
    lbNotFound: TLabel;
    Shape3: TShape;
    pnSettings: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    deSTART: TcxDateEdit;
    deEND: TcxDateEdit;
    btnNext: TButton;
    btnPrev: TButton;
    beCT: TcxButtonEdit;
    beSUPPLIER: TcxButtonEdit;
    cxGridSTable: TcxGridDBTableView;
    cxGridSLevel: TcxGridLevel;
    cxGridS: TcxGrid;
    IBCQuerySource: TIBCQuery;
    IBCDataSourceSource: TIBCDataSource;
    cxGridS_SUPPLIERID: TcxGridDBColumn;
    cxGridS_GOODSID: TcxGridDBColumn;
    cxGridS_TITLE: TcxGridDBColumn;
    cxGridS_QTY: TcxGridDBColumn;
    Label6: TLabel;
    cxGridRLevel: TcxGridLevel;
    cxGridR: TcxGrid;
    cxGridRTable: TcxGridTableView;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    bbExportExcel: TdxBarButton;
    cxGridR_GOODSID: TcxGridColumn;
    cxGridR_SUPPLIERGOODSID: TcxGridColumn;
    cxGridR_SELL_QTY: TcxGridColumn;
    cxGridR_SUPPLIER_QTY: TcxGridColumn;
    cxGridR_TITLE: TcxGridColumn;
    sbFirmsPresets: TSpeedButton;
    pmFirms: TPopupMenu;
    miFirms1: TMenuItem;
    sbWeekPresets: TSpeedButton;
    pmWeeks: TPopupMenu;
    miWeekPreset1: TMenuItem;
    miWeekPreset2: TMenuItem;
    dxBarDockControl3: TdxBarDockControl;
    dxBarManager1Bar3: TdxBar;
    bbCopySourceAll: TdxBarButton;
    cxGridS_FLG_SLD: TcxGridDBColumn;
    cxSpreadSheet: TdxSpreadSheet;
    procedure bbOpenFileClick(Sender: TObject);
    procedure bbClearAllClick(Sender: TObject);
    procedure bbCheckGoodsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbShowFormulasClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cxSpreadSheetSetSelection(Sender: TObject; ASheet: TdxSpreadSheetTableView);
    procedure bbGoodsClick(Sender: TObject);
    procedure beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure beSUPPLIERPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure cxGridRTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
    procedure miFirms1Click(Sender: TObject);
    procedure sbFirmsPresetsClick(Sender: TObject);
    procedure miWeekPreset2Click(Sender: TObject);
    procedure sbWeekPresetsClick(Sender: TObject);
    procedure bbExportExcelClick(Sender: TObject);
    procedure bbCopySourceAllClick(Sender: TObject);
    procedure cxGridSTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      out AStyle: TcxStyle);
  private
    { Private declarations }
    fGoodsList: TList;
    fDocID: integer;
    // fImportByNeuronCode:Boolean;
    fCT, fSupplierID: integer;

    procedure ClearGoodsList;
    procedure DoOpenFile;
    procedure DoCheckGoods;
    procedure DoScanGoods;

    // function CheckGoodsID(const GoodsID:integer):Boolean;
    function CheckForeignCode(const Code: String; var ResultInfo: TCheckGoodsInfo): Boolean;

    function DoImportGoodsDB: Boolean;
    procedure SetDocID(const Value: integer);

    function GetRecordDataByRowIndex(const RowIndex: integer): TImportGoodsData;
    function GetCheckGoodsCount: integer;

    procedure SelectionChanged;

    procedure CreateSheetDefaults;

    procedure SelectCT;
    procedure SelectSupplier;

    procedure SwitchToPage(const NextPage: integer; const IsBack: Boolean = false);

    function CheckInputParams: Boolean;
    procedure ReadSourceSQL;
    procedure LoadFirmsPreset(const CT, SupplierID: integer);

    function CheckXLSData: Boolean;
    procedure CreateResultGrid;
    function GetGoodsDataInfo(const GoodsID, SupplierID: integer): TImportGoodsData;

  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property DocID: integer read fDocID write SetDocID;
  end;

implementation

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNConst, SWNDBErrors, frmGoods, Math, frmCustomersDlg,
  DateUtils, cxGridExportLink, Vcl.Clipbrd;

{$R *.dfm}
{ TfrmImportGoodsPricesDlg }

procedure TfrmImportForeignGoodsIntoTableDlg.bbCheckGoodsClick(Sender: TObject);
begin
  DoCheckGoods;
  SelectionChanged;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbClearAllClick(Sender: TObject);
begin
  cxSpreadSheet.ClearAll;
  CreateSheetDefaults;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbCopySourceAllClick(Sender: TObject);
begin
  cxGridSTable.CopyToClipboard(True);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbExportExcelClick(Sender: TObject);
var
  dialog: TSaveDialog;
begin
  dialog := TSaveDialog.Create(Self);
  try
    dialog.DefaultExt := '.xls';
    dialog.Filter := 'Excel files|*.xls';
    if dialog.Execute then
      ExportGridToExcel(dialog.FileName, cxGridR);
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbGoodsClick(Sender: TObject);
var
  data: TImportGoodsData;
  dialog: TfrmGoodsBrowser;
  cell: TdxSpreadSheetCell;
  i: integer;

begin
  data := GetRecordDataByRowIndex(cxSpreadSheet.ActiveSheetAsTable.Rows.Count);
  if Assigned(data) then
  begin
    dialog := TfrmGoodsBrowser.Create(Self);
    try
      if data.Checked then
      begin
        dialog.GoodsID := data.GoodsID;
        dialog.ShowModal;
      end
      {
        else
        if dialog.SelectGoods(data.GoodsID,false,0,'Gasiti marfa corespunzatoare') then
        begin
        data.GoodsID:=dialog.GoodsID;
        data.ByNeuronCode:=true;
        data.Checked:=True;
        // colorize cells
        for i := 0 to 7 do
        begin
        cell:=cxSpreadSheet.Sheet.GetCellObject(i,cxSpreadSheet.Sheet.Row);
        cell.Style.Brush.BackgroundColor:=9;
        cell.Style.Font.FontColor:=1;
        end;
        end;
      }
    finally
      dialog.Free;
    end;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbOpenFileClick(Sender: TObject);
begin
  DoOpenFile;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.bbShowFormulasClick(Sender: TObject);
begin
  // cxSpreadSheet.ShowFormulas:=bbShowFormulas.Down;
  if bbShowFormulas.Down then
    cxSpreadSheet.ActiveSheetAsTable.Options.ShowFormulas := bTrue;

end;

procedure TfrmImportForeignGoodsIntoTableDlg.beCTPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectCT;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.beSUPPLIERPropertiesButtonClick(Sender: TObject; AButtonIndex: integer);
begin
  SelectSupplier;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.btnImportClick(Sender: TObject);
var
  Count: integer;
begin
  Count := GetCheckGoodsCount;
  if Count = 0 then
    ShowErrorDialog('Eroare', 'Nu sunt produse verificate.')
  else if ShowAskDialog('Import preturi produse', Format('Doriti sa importati preturile pentru %d produse ?', [Count]),
    Format('Total inregistrari: %d.', [fGoodsList.Count])) = mrYes then
  begin
    if DoImportGoodsDB then
    begin
      ShowInfoDialog('Import preturi produse', 'Preturile marfurilor au fost importate.');
      ModalResult := mrOk;
    end;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.btnNextClick(Sender: TObject);
begin
  SwitchToPage(Notebook.PageIndex + 1);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.btnPrevClick(Sender: TObject);
begin
  SwitchToPage(Notebook.PageIndex - 1, True);
end;

function TfrmImportForeignGoodsIntoTableDlg.CheckForeignCode(const Code: String; var ResultInfo: TCheckGoodsInfo): Boolean;
var
  Count: integer;
begin
  Count := 0;

  IBCQuery.Close;
  IBCQuery.SQL.Clear;
  IBCQuery.SQL.Add('SELECT GOODSID, CUSTOMERID,');
  IBCQuery.SQL.Add('(SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMERID=TS_GOODS_FOREIGN.CUSTOMERID),');
  IBCQuery.SQL.Add('(SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TS_GOODS_FOREIGN.GOODSID)');
  IBCQuery.SQL.Add('FROM TS_GOODS_FOREIGN WHERE UPPER(GOODS_CODE)=UPPER(:code)');
  IBCQuery.ParamByName('code').AsString := Code;
  IBCQuery.ExecSQL;
  while Not IBCQuery.Eof do
  begin
    inc(Count);
    ResultInfo.GoodsID := IBCQuery.Fields[0].AsInteger;
    ResultInfo.SupplierID := IBCQuery.Fields[1].AsInteger;
    ResultInfo.SupplierName := IBCQuery.Fields[2].AsString;
    ResultInfo.GoodsTitle := IBCQuery.Fields[3].AsString;
    IBCQuery.Next;
  end;
  Result := Count = 1;
  IBCQuery.Close;
end;

{
  function TfrmImportForeignGoodsIntoTableDlg.CheckGoodsID(const GoodsID: integer): Boolean;
  begin
  IBCQuery.Close;
  IBCQuery.SQL.Text:='SELECT GOODSID FROM TS_GOODS WHERE GOODSID=:id';
  IBCQuery.ParamByName('id').AsInteger:=GoodsID;
  IBCQuery.ExecSQL;
  Result:=Not IBCQuery.Eof;
  IBCQuery.Close;
  end;
}

function TfrmImportForeignGoodsIntoTableDlg.CheckInputParams: Boolean;
var
  ErrorStr: String;
begin
  ErrorStr := '';
  Result := false;

  if VarIsNullDate(deSTART.EditValue) or VarIsNullDate(deEND.EditValue) then
    AddErrorToStr(ErrorStr, 'Perioada de calcul!');
  if fCT = -1 then
    AddErrorToStr(ErrorStr, 'Firma!');
  if fSupplierID = -1 then
    AddErrorToStr(ErrorStr, 'Furnizor!');

  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr);
end;

function TfrmImportForeignGoodsIntoTableDlg.CheckXLSData: Boolean;
begin
  Result := True;
  if GetCheckGoodsCount = 0 then
  begin
    Result := false;
    ShowErrorDialog('Eroare', 'Nu sunt produse verificate.')
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.ClearGoodsList;
var
  i: integer;
begin
  for i := 0 to fGoodsList.Count - 1 do
    TImportGoodsData(fGoodsList[i]).Free;
  fGoodsList.Clear;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.CreateResultGrid;
var
  i, N: integer;
  data: TImportGoodsData;
  GoodsID: integer;
  SellQTY, SupplierQTY: double;
  S: String;
begin
  for i := 0 to fGoodsList.Count - 1 do
    TImportGoodsData(fGoodsList[i]).Processed := false;

  cxGridRTable.BeginUpdate;
  try
    cxGridRTable.Controller.SelectAll;
    cxGridRTable.DataController.DeleteSelection;

    // data from SQL
    for i := 0 to cxGridSTable.DataController.RecordCount - 1 do
    begin
      GoodsID := cxGridSTable.DataController.Values[i, cxGridS_GOODSID.Index];
      SellQTY := cxGridSTable.DataController.Values[i, cxGridS_QTY.Index];
      SupplierQTY := 0;

      data := GetGoodsDataInfo(GoodsID, fSupplierID);
      if Assigned(data) then
      begin
        SupplierQTY := data.Qty;
        data.Processed := True;
      end;

      N := cxGridRTable.DataController.AppendRecord;
      S := cxGridSTable.DataController.Values[i, cxGridS_SUPPLIERID.Index];
      cxGridRTable.DataController.Values[N, cxGridR_SUPPLIERGOODSID.Index] := S;
      cxGridRTable.DataController.Values[N, cxGridR_GOODSID.Index] := GoodsID;
      S := cxGridSTable.DataController.Values[i, cxGridS_TITLE.Index];
      cxGridRTable.DataController.Values[N, cxGridR_TITLE.Index] := S;
      cxGridRTable.DataController.Values[N, cxGridR_SELL_QTY.Index] := SellQTY;
      cxGridRTable.DataController.Values[N, cxGridR_SUPPLIER_QTY.Index] := SupplierQTY;
    end;

    // remaining data from XLS

    for i := 0 to fGoodsList.Count - 1 do
    begin
      data := TImportGoodsData(fGoodsList[i]);
      if (Not data.Processed) then
      begin
        N := cxGridRTable.DataController.AppendRecord;
        cxGridRTable.DataController.Values[N, cxGridR_SUPPLIERGOODSID.Index] := data.ForeignID;
        cxGridRTable.DataController.Values[N, cxGridR_GOODSID.Index] := data.GoodsID;
        cxGridRTable.DataController.Values[N, cxGridR_TITLE.Index] := data.Title;
        cxGridRTable.DataController.Values[N, cxGridR_SELL_QTY.Index] := 0; // data.QtyRealizatia;
        cxGridRTable.DataController.Values[N, cxGridR_SUPPLIER_QTY.Index] := data.Qty;
        data.Processed := True;
      end;
    end;

  finally
    cxGridRTable.EndUpdate;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.CreateSheetDefaults;
var
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
begin
  if bbShowFormulas.Down then
    cxSpreadSheet.ActiveSheetAsTable.Options.ShowFormulas := bTrue;

  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  Sheet.Caption := 'Marfuri';

  cell := Sheet.CreateCell(0, 0);
  cell.column.Size := 120; // foreign code
  cell.SetText('Codul furnizorului');

  cell := Sheet.CreateCell(0, 1);
  cell.column.Size := 350; // denumire
  cell.SetText('Denumirea produsului');

  cell := Sheet.CreateCell(0, 2);
  cell.column.Size := 60; // cantitate
  cell.SetText('cantitate');

  cell := Sheet.CreateCell(0, 3);
  cell.column.Size := 60; // pret
  cell.SetText('Pret');

  cell := Sheet.CreateCell(0, 4);
  cell.column.Size := 60; // cantitate realizata
  cell.SetText('cantitate realizata');

  cell := Sheet.CreateCell(0, 5);
  cell.column.Size := 60; // stoc
  cell.SetText('Stoc');

  // Sheet.Cols.Size[0]:=120;  // Codul furnizorului
  // Sheet.Cols.Size[1]:=350;  // Denumire
  // Sheet.Cols.Size[2]:=60;  // Cantitate
  // Sheet.Cols.Size[3]:=60;  // Pret
  // Sheet.Cols.Size[4]:=60;  // cantitate realizata
  // Sheet.Cols.Size[5]:=60;  // stoc

//  // Codul furnizorului
//  cell := Sheet.Cells[0, 0];
//  cell.SetText('Codul furnizorului');
//  // Denumire
//
//  cell := Sheet.Cells[0, 1];
//  cell.SetText('Denumire');
//  // Cantitate
//
//  cell := Sheet.Cells[0, 2];
//  cell.SetText('Cantitate');
//  // Pret
//
//  cell := Sheet.Cells[0, 3];
//  cell.SetText('Pret');
//  // cantitate realizata
//
//  cell := Sheet.Cells[0, 4];
//  cell.SetText('cantitate realizata');
//
//  // stoc
//  cell := Sheet.Cells[0, 5];
//  cell.SetText('stoc');

  cxSpreadSheet.ActiveSheetAsTable.Selection.SelectCell(1, 0);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.cxGridRTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  nQTY, sQTY: integer;
begin
  if Not VarIsNull(ARecord.Values[cxGridR_SELL_QTY.Index]) and Not VarIsNull(ARecord.Values[cxGridR_SUPPLIER_QTY.Index]) then
  begin
    nQTY := ARecord.Values[cxGridR_SELL_QTY.Index];
    sQTY := ARecord.Values[cxGridR_SUPPLIER_QTY.Index];
    if sQTY < nQTY then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.cxGridSTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
  if Not VarIsNull(ARecord.Values[cxGridS_FLG_SLD.Index]) then
  begin
    if ARecord.Values[cxGridS_FLG_SLD.Index] = 1 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.cxSpreadSheetSetSelection(Sender: TObject; ASheet: TdxSpreadSheetTableView);
begin
  SelectionChanged;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.DoCheckGoods;
begin
  if ShowAskDialog('Verificare marfa', 'Doriti sa verificati marfa dupa codul de la Furnizor?') = mrYes then
    DoScanGoods;
end;

function TfrmImportForeignGoodsIntoTableDlg.DoImportGoodsDB: Boolean;
var
  i: integer;
  data: TImportGoodsData;
  Query: TIBCQuery;
begin
  Result := false;

  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := false;
    Query.Connection := dmDB.IBCConnection;
    Query.Transaction := dmDB.IBCTrDefaultUpdate;

    Query.SQL.Add('INSERT INTO TDB_REALIZAREA (SUPPLIERID,GOODSID,SUPPLIERGOODSID,SELL_QTY,STOCK_QTY,SUPPLIER_QTY,SUPPLIER_PRICE)');
    Query.SQL.Add('VALUES (:SUPPLIERID,:GOODSID,:SUPPLIERGOODSID,:SELL_QTY,:STOCK_QTY,:SUPPLIER_QTY,:SUPPLIER_PRICE)');
    try
      Query.Transaction.StartTransaction;

      for i := 0 to fGoodsList.Count - 1 do
      begin
        data := TImportGoodsData(fGoodsList[i]);
        if Not data.Checked then
          Continue;

        Query.ParamByName('SUPPLIERID').AsInteger := data.SupplierID;
        Query.ParamByName('GOODSID').AsInteger := data.GoodsID;
        Query.ParamByName('SUPPLIERGOODSID').AsString := data.ForeignID;
        Query.ParamByName('SELL_QTY').AsFloat := data.QtyRealizatia;
        Query.ParamByName('STOCK_QTY').AsFloat := data.QtyOstatok;
        Query.ParamByName('SUPPLIER_QTY').AsFloat := data.Qty;
        Query.ParamByName('SUPPLIER_PRICE').Value := data.Price;

        Query.ExecSQL;
      end;

      Query.Transaction.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if Query.Transaction.Active then
          Query.Transaction.Rollback;
        if Not ProcessSWNError(E) then
          raise;
      end;
    end;

  finally
    Query.Free;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.DoOpenFile;
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

procedure TfrmImportForeignGoodsIntoTableDlg.DoScanGoods;
var
  i, j, N: integer;
  cell: TdxSpreadSheetCell;
  Sheet: TdxSpreadSheetTableView;
  codeStr: String;
  Checked: Boolean;
  data, data2: TImportGoodsData;
  CheckInfo: TCheckGoodsInfo;
  counter_NotFound: integer;
  counter_Repeated: integer;
begin
  ClearGoodsList;

  counter_NotFound := 0;
  counter_Repeated := 0;

  Sheet := cxSpreadSheet.ActiveSheetAsTable;
  N := 0;
  if bbGridHeader.Down then
    N := 1;

  for i := N to Sheet.Rows.Count - 1 do
  begin
    cell := Sheet.Cells[i, 0];
    // cell.Style.Format := 1;
    codeStr := UpperCase(cell.AsString);
    if codeStr = '' then
    begin
      for j := 0 to Min(5, Sheet.Columns.Count - 1) do
      begin
        cell := Sheet.Cells[i, j];
        cell.Style.Brush.BackgroundColor := 8;
        cell.Style.Font.Color := 1;
      end;

      Continue;
    end;

    Checked := CheckForeignCode(codeStr, CheckInfo);

    data := TImportGoodsData.Create;
    data.GoodsID := CheckInfo.GoodsID;
    data.Title := CheckInfo.GoodsTitle;
    data.ForeignID := codeStr;
    data.SupplierID := CheckInfo.SupplierID;
    data.SupplierName := CheckInfo.SupplierName;
    data.RowIndex := i;
    data.Checked := Checked;
    fGoodsList.Add(data);

    if Checked then
    begin
      for j := 0 to Min(1, Sheet.Columns.Count - 1) do
      begin
        cell := Sheet.Cells[i, j];
        cell.Style.Brush.BackgroundColor := 1;
        cell.Style.Font.Color := 0;
      end;

      // show SupplierID
      cell := Sheet.Cells[i, 6];
      cell.SetText(data.SupplierName);

      // check other columns
      for j := 2 to Min(5, Sheet.Columns.Count - 1) do
      begin
        cell := Sheet.Cells[i, j];
        // cell.Style.Format := 1;
        cell.SetText(StringReplace(cell.DisplayText, ' ', '', [rfReplaceAll]));
        // cell.Style.Format := 0;
        if VarIsNumeric(cell.AsFloat) then
        begin
          case j of
            2:
              data.Qty := cell.AsFloat;
            3:
              data.Price := cell.AsFloat;
            4:
              data.QtyRealizatia := cell.AsFloat;
            5:
              data.QtyOstatok := cell.AsFloat;
          end;

          cell.Style.Brush.BackgroundColor := 1;
          cell.Style.Font.Color := 0;
        end
        else
          cell.Style.Brush.BackgroundColor := 15; // no value
      end;
    end
    else
    begin
      inc(counter_NotFound);

      for j := 0 to Min(5, Sheet.Columns.Count - 1) do
      begin
        cell := Sheet.Cells[i, j];
        cell.Style.Brush.BackgroundColor := 8;
        cell.Style.Font.Color := 1;
      end;
    end;
  end;

  // 2. verify if GoodsID is uniqe
  for i := 0 to fGoodsList.Count - 2 do
  begin
    data := TImportGoodsData(fGoodsList[i]);
    if (data.Checked) then
      for j := i + 1 to fGoodsList.Count - 1 do
      begin
        data2 := TImportGoodsData(fGoodsList[j]);
        if (data2.Checked) and (data2.GoodsID = data.GoodsID) then
        begin
          inc(counter_Repeated);
          cell := Sheet.Cells[data.RowIndex, 0];
          cell.Style.Brush.BackgroundColor := 45;
          cell := Sheet.Cells[data2.RowIndex, 6];
          cell.Style.Brush.BackgroundColor := 45;
        end;
      end;
  end;
  // show summary
  lbCodeRepeated.Caption := Format('codul FANTASTIC se repeta - %d', [counter_Repeated]);
  lbNotFound.Caption := Format('nu a fost gasit - %d', [counter_NotFound]);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.FormCreate(Sender: TObject);
begin
  fGoodsList := TList.Create;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.FormDestroy(Sender: TObject);
begin
  ClearGoodsList;
  fGoodsList.Free;
end;

function TfrmImportForeignGoodsIntoTableDlg.GetCheckGoodsCount: integer;
var
  i: integer;
  data: TImportGoodsData;
begin
  Result := 0;
  for i := 0 to fGoodsList.Count - 1 do
  begin
    data := TImportGoodsData(fGoodsList[i]);
    if (data.Checked) then
      inc(Result);
  end;
end;

function TfrmImportForeignGoodsIntoTableDlg.GetGoodsDataInfo(const GoodsID, SupplierID: integer): TImportGoodsData;
var
  i: integer;
  data: TImportGoodsData;
begin
  Result := nil;
  for i := 0 to fGoodsList.Count - 1 do
  begin
    data := TImportGoodsData(fGoodsList[i]);
    if (data.GoodsID = GoodsID) and (data.SupplierID = SupplierID) then
    begin
      Result := data;
      break;
    end;
  end;
end;

function TfrmImportForeignGoodsIntoTableDlg.GetRecordDataByRowIndex(const RowIndex: integer): TImportGoodsData;
var
  i: integer;
  data: TImportGoodsData;
begin
  Result := nil;
  for i := 0 to fGoodsList.Count - 1 do
  begin
    data := TImportGoodsData(fGoodsList[i]);
    if (data.RowIndex = RowIndex) then
    begin
      Result := data;
      break;
    end;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.LoadFirmsPreset(const CT, SupplierID: integer);
begin
  fCT := CT;
  beCT.Text := dmDB.GetCustomerDisplayName(CT);
  fSupplierID := SupplierID;
  beSUPPLIER.Text := dmDB.GetCustomerDisplayName(SupplierID);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.Prepare;
var
  d: TDateTime;
begin
  CreateSheetDefaults;
  Notebook.PageIndex := 0; // go to 1st page

  fCT := -1;
  fSupplierID := -1;

  d := Now - DayOfTheWeek(Now) + 1;

  deSTART.EditValue := d;
  deEND.EditValue := d + 6;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.ReadSourceSQL;
begin
  IBCQuerySource.Close;
  IBCQuerySource.ParamByName('DATA1').AsDate := deSTART.EditValue;
  IBCQuerySource.ParamByName('DATA2').AsDate := deEND.EditValue;
  IBCQuerySource.ParamByName('CT').AsInteger := fCT;
  IBCQuerySource.ParamByName('SUPPLIERCODE').AsInteger := fSupplierID;
  IBCQuerySource.Active := True;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.sbFirmsPresetsClick(Sender: TObject);
var
  P: TPoint;
begin
  P.X := sbFirmsPresets.Left;
  P.Y := sbFirmsPresets.Top + sbFirmsPresets.Height;
  P := pnSettings.ClientToScreen(P);
  pmFirms.Popup(P.X, P.Y);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.SelectCT;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fCT, false, 0, 'Selectati firma') then
    begin
      beCT.Text := dialog.CustomerTitle;
      fCT := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.SelectionChanged;
var
  data: TImportGoodsData;
begin
  data := GetRecordDataByRowIndex(cxSpreadSheet.ActiveSheetAsTable.Rows.Count - 1);
  bbGoods.Enabled := Assigned(data);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.SelectSupplier;
var
  dialog: TfrmCustomersDlg;
begin
  dialog := TfrmCustomersDlg.Create(Self);
  try
    if dialog.SelectCustomer(fSupplierID, false, 0, 'Selectati furnizorul') then
    begin
      beSUPPLIER.Text := dialog.CustomerTitle;
      fSupplierID := dialog.CustomerID;
    end;
  finally
    dialog.Free;
  end;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.SetDocID(const Value: integer);
begin
  fDocID := Value;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.sbWeekPresetsClick(Sender: TObject);
var
  P: TPoint;
begin
  P.X := sbWeekPresets.Left;
  P.Y := sbWeekPresets.Top + sbWeekPresets.Height;
  P := pnSettings.ClientToScreen(P);
  pmWeeks.Popup(P.X, P.Y);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.SwitchToPage(const NextPage: integer; const IsBack: Boolean);
var
  AllowToChange: Boolean;
begin
  AllowToChange := True;
  case NextPage of
    0:
      begin
        // Input initial params

        // checks

        // buttons
        btnPrev.Enabled := false;
        btnNext.Enabled := True;
      end;
    1:
      begin
        // SQL select

        // checks
        if Not IsBack then
        begin
          AllowToChange := CheckInputParams;
          if AllowToChange then
          begin
            btnPrev.Enabled := True;
            btnNext.Enabled := True;
            ReadSourceSQL;
          end;
        end;
      end;
    2:
      begin
        // XLS
        btnPrev.Enabled := True;
        btnNext.Enabled := True;
      end;
    3:
      begin
        // Combine
        AllowToChange := CheckXLSData;
        if AllowToChange then
        begin
          btnPrev.Enabled := True;
          btnNext.Enabled := false;
          CreateResultGrid;
        end;
      end;
  end;
  if AllowToChange then
    Notebook.PageIndex := NextPage;
end;

procedure TfrmImportForeignGoodsIntoTableDlg.miFirms1Click(Sender: TObject);
var
  CT, SupplierID: integer;
begin
  CT := -1;
  SupplierID := -1;
  case TMenuItem(Sender).Tag of
    1:
      begin
        CT := 104366;
        SupplierID := 10401;
      end;
  end;
  if (CT <> -1) and (SupplierID <> -1) then
    LoadFirmsPreset(CT, SupplierID);
end;

procedure TfrmImportForeignGoodsIntoTableDlg.miWeekPreset2Click(Sender: TObject);
var
  D1, D2: TDateTime;
begin
  D1 := 0;
  D2 := 0;
  case TMenuItem(Sender).Tag of
    1:
      begin
        // previous week
        D1 := Now - DayOfTheWeek(Now) - 6;
        D2 := D1 + 6;
      end;
    2:
      begin
        // current week
        D1 := Now - DayOfTheWeek(Now) + 1;
        D2 := D1 + 6;
      end;
  end;
  deSTART.EditValue := D1;
  deEND.EditValue := D2;
end;

{ TImportGoodsData }

constructor TImportGoodsData.Create;
begin
  GoodsID := -1;
  ForeignID := '';
  Price := Null;
  Qty := 0;
  QtyRealizatia := 0;
  QtyOstatok := 0;
  RowIndex := -1;
  Checked := false;
  Processed := false;
end;

end.

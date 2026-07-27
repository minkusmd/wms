unit frmPrepareGoodsForImportUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheetCore, dxSpreadSheetCoreFormulas, dxSpreadSheetCoreHistory,
  dxSpreadSheetCoreStyles, dxSpreadSheetCoreStrs, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetClasses, dxSpreadSheetContainers, dxSpreadSheetFormulas,
  dxSpreadSheetHyperlinks, dxSpreadSheetFunctions, dxSpreadSheetStyles, dxSpreadSheetGraphics, dxSpreadSheetPrinting,
  dxSpreadSheetTypes, dxSpreadSheetUtils, dxSpreadSheetFormattedTextUtils, dxBarBuiltInMenu, dxBar, cxClasses,
  dxSpreadSheetFormulaBar, dxSpreadSheet, IBC;

type
  TfrmPrepareGoodsForImportDlg = class(TSWNBaseFormClass)
    dxSpreadSheet1: TdxSpreadSheet;
    dxSpreadSheetFormulaBar1: TdxSpreadSheetFormulaBar;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    bbFileOpen: TdxBarButton;
    bbFile: TdxBarSubItem;
    bbSave: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton2: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
  private
    FDataSet: TIBCQuery;
    procedure SetDataSet(const Value: TIBCQuery);
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure PrepareSpreadSheet;
    procedure PopulateSpreadSheet;
    procedure ValidateSupplierGoods;
  public
    SupplierName: string;
    SupplierID: integer;
    { Public declarations }
    property DataSet: TIBCQuery read FDataSet write SetDataSet;
    constructor Create(const AOwner: TComponent; const IBCConnection: TIBCConnection; const ADataSet: TIBCQuery); reintroduce;
  end;

var
  frmPrepareGoodsForImportDlg: TfrmPrepareGoodsForImportDlg;

implementation

{$R *.dfm}

constructor TfrmPrepareGoodsForImportDlg.Create(const AOwner: TComponent; const IBCConnection: TIBCConnection;
  const ADataSet: TIBCQuery);
begin
  inherited Create(AOwner, ibcconnection);
  DataSet := ADataSet;
end;

procedure TfrmPrepareGoodsForImportDlg.dxBarButton2Click(Sender: TObject);
begin
     ValidateSupplierGoods;
end;

procedure TfrmPrepareGoodsForImportDlg.FormCreate(Sender: TObject);
begin
   PrepareSpreadSheet;
   PopulateSpreadSheet;
end;

procedure TfrmPrepareGoodsForImportDlg.Prepare;
begin

end;

procedure TfrmPrepareGoodsForImportDlg.PrepareSpreadSheet;
var
   ATable: TdxSpreadSheetTableView;
begin
   ATable := dxSpreadSheet1.ActiveSheetAsTable;

   with ATable.CreateCell(0, 0) do
   begin
      AsString := 'Cod Furnizor';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 120;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 1) do
   begin
      AsString := 'Cod Intern';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 70;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 2) do
   begin
      AsString := 'Denumire produs furnizor';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 450;
      Style.WordWrap := True;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 3) do
   begin
      AsString := 'Denumire produs intern';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 450;
      Style.Font.Style := [fsBold];
      Style.WordWrap := True;
   end;

   with ATable.CreateCell(0, 4) do
   begin
      AsString := 'Tip produs';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 90;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 5) do
   begin
      AsString := 'Cod grupa';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 70;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 6) do
   begin
      AsString := 'Model';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 150;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 7) do
   begin
      AsString := 'Parametru de baza';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 150;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 8) do
   begin
      AsString := 'Detalii';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 150;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 9) do
   begin
      AsString := 'UM';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 60;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 10) do
   begin
      AsString := 'Cod Evidenta';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 90;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 10) do
   begin
      AsString := 'Cod Valuta';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 70;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 11) do
   begin
      AsString := 'Garantia';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 70;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 12) do
   begin
      AsString := 'Pret 0';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 90;
      Style.Font.Style := [fsBold];
   end;

   with ATable.CreateCell(0, 13) do
   begin
      AsString := 'Pret 7';
      Column.Style.AlignHorz := ssahCenter;
      Column.Size := 90;
      Style.Font.Style := [fsBold];
   end;
  //
end;

procedure TfrmPrepareGoodsForImportDlg.SetDataSet(const Value: TIBCQuery);
begin
   FDataSet := Value;
end;

procedure TfrmPrepareGoodsForImportDlg.PopulateSpreadSheet;
var
   ATable: TdxSpreadSheetTableView;
   ACell: TdxSpreadSheetCell;
   ARow: Integer;
begin
   ARow := 1;
   DataSet.Open;
   DataSet.First;
   dxSpreadSheet1.BeginUpdate();
   ATable := dxSpreadSheet1.ActiveSheetAsTable;
   while not DataSet.Eof do
   begin
        //  cod produs furnizor
      ACell := ATable.CreateCell(ARow, 0);
      ACell.AsString := DataSet.FieldByName('supplier_goods_code').AsString;
      // cod intern
      ACell := ATable.CreateCell(ARow, 1);
      ACell.AsInteger := 0;
        //  denumire produs furnizor
      ACell := ATable.CreateCell(ARow, 2);
      ACell.AsString := DataSet.FieldByName('Supplier_goods_name').AsString;
      ACell.Style.WordWrap := True;
        //  denumire produs intern
      ACell := ATable.CreateCell(ARow, 3);
      ACell.AsString := '';
        //  tip produs
      ACell := ATable.CreateCell(ARow, 4);
      ACell.AsString := '';
        //  cod grupa parinte
      ACell := ATable.CreateCell(ARow, 5);
      ACell.AsString := '';
        //  model
      ACell := ATable.CreateCell(ARow, 6);
      ACell.AsString := '';
        //  parametru de baza
      ACell := ATable.CreateCell(ARow, 7);
      ACell.AsString := '';
        //  detalii
      ACell := ATable.CreateCell(ARow, 8);
      ACell.AsString := '';
        //  Unitate Metrica
      ACell := ATable.CreateCell(ARow, 9);
      ACell.AsString := '';
        //  Tip evindente
      ACell := ATable.CreateCell(ARow, 10);
      ACell.AsString := '';
        //  Cod valuta
      ACell := ATable.CreateCell(ARow, 11);
      ACell.AsString := '';
        //  Garantia
      ACell := ATable.CreateCell(ARow, 12);
      ACell.AsString := DataSet.FieldByName('WARANTY').AsString;
        //  Pret 0
      ACell := ATable.CreateCell(ARow, 13);
      ACell.AsString := DataSet.FieldByName('PRICE0').AsString;
        //  Pret 7
      ACell := ATable.CreateCell(ARow, 14);
      ACell.AsString := DataSet.FieldByName('PRICE7').AsString;

      DataSet.Next;
      Inc(ARow);
   end;
   dxSpreadSheet1.EndUpdate;
end;

procedure TfrmPrepareGoodsForImportDlg.ValidateSupplierGoods;
var
   i: Integer;
   ATable: TdxSpreadSheetTableView;
   ACell: TdxSpreadSheetCell;
   Query: TIBCQuery;
begin
    ATable := dxSpreadSheet1.ActiveSheetAsTable;
    Query := TIBCQuery.Create(Self);
    try
    Query.Connection:= fIBCConnection;
    Query.Transaction := fIBCConnection.DefaultTransaction;

    Query.SQL.Clear;
    Query.SQL.Add('select GF.GOODSID, G.TITLE GOODSNAME');
    Query.SQL.Add('from TS_GOODS_FOREIGN GF');
    Query.SQL.Add('join TS_GOODS G on G.GOODSID = GF.GOODSID');
    Query.SQL.Add('where GF.CUSTOMERID = :SUPPLIERID and');
    Query.SQL.Add('GF.GOODS_CODE = :GOODS_CODE');
    Query.Prepare;

    for i := 1 to ATable.Rows.Count-1 do
    begin
      Query.ParamByName('supplierid').AsInteger := SupplierID;
      Query.ParamByName('GOODS_CODE').AsString := ATable.Cells[i, 0].AsString;
      Query.Open;
      if Query.RecordCount>0 then
      begin
      ATable.Cells[i, 1].AsString := Query.FieldByName('GoodsID').AsString;
      ATable.Cells[i, 3].AsString := Query.FieldByName('GOODSNAME').AsString;
      end
      else
      begin
         ATable.Rows[i].Style.Brush.BackgroundColor := clRed;
         ATable.Rows[i].Style.Brush.ForegroundColor:= clWhite;
      end;
      Query.Close;
    end;
    finally
       Query.Free;
    end;
end;


end.

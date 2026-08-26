unit frmImportGoodsConcurentsUnit;

interface

uses
  DBAccess, IBC, SWNBaseUnit, cxButtons, cxControls, cxGraphics, cxLookAndFeelPainters, cxLookAndFeels, dxBarBuiltInMenu,
  dxCore, dxCoreClasses, dxHashUtils, dxSpreadSheet, dxSpreadSheetClasses, dxSpreadSheetConditionalFormatting,
  dxSpreadSheetConditionalFormattingRules, dxSpreadSheetContainers, dxSpreadSheetCore, dxSpreadSheetCoreFormulas,
  dxSpreadSheetCoreHistory, dxSpreadSheetCoreStrs, dxSpreadSheetCoreStyles, dxSpreadSheetFormattedTextUtils,
  dxSpreadSheetFormulas, dxSpreadSheetFunctions, dxSpreadSheetGraphics, dxSpreadSheetHyperlinks, dxSpreadSheetPrinting,
  dxSpreadSheetStyles, dxSpreadSheetTypes, dxSpreadSheetUtils,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TfrmImportGoodsConcurentsDlg = class(TSWNCustomForm)
    dxSpreadSheet1: TdxSpreadSheet;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    IBCTrWrite: TIBCTransaction;
    procedure cxButton1Click(Sender: TObject);
  private
    FDocID: Integer;
    procedure DoImportGoods;
    procedure PrepareSpreadSheet;
    procedure SetDocID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    { Public declarations }
  published
    property DocID: Integer read FDocID write SetDocID;
  end;

var
  frmImportGoodsConcurentsDlg: TfrmImportGoodsConcurentsDlg;

implementation

uses System.UITypes;

{$R *.dfm}
{ TfrmImportGoodsConcurentsDlg }

procedure TfrmImportGoodsConcurentsDlg.cxButton1Click(Sender: TObject);
begin
  DoImportGoods;
end;

procedure TfrmImportGoodsConcurentsDlg.DoImportGoods;
var
  AGoodsID: string;
  ATable: TdxSpreadSheetTableView;
  I: Integer;
  ibcsql: TIBCSQL;
  Query: TIBCQuery;
begin
  ibcsql := TIBCSQL.Create(Self);
  Query := TIBCQuery.Create(Self);
  try
    ATable := dxSpreadSheet1.ActiveSheetAsTable;
    Query.SQL.Text := 'select price4_lei price4lei, price7 from SP_GET_TS_GOODS_M0(5213, :goodsid)';
    ibcsql.Transaction := IBCTrWrite;
    ibcsql.AutoCommit := False;
    ibcsql.SQL.Clear;
    ibcsql.SQL.Add('insert into TDB_DOCS_GOODS_CONCURENTS (DOCID, GOODSID, URL, PRICE4LEI, PRICE7)');
    ibcsql.SQL.Add('values (:DOCID, :GOODSID, :URL, :PRICE4LEI, :PRICE7)');
    ibcsql.Transaction := IBCTrWrite;

    if not IBCTrWrite.Active then
      IBCTrWrite.StartTransaction;

    ibcsql.Prepare;
    for I := 1 to ATable.Rows.Count - 1 do
    begin
      with ibcsql do
      begin
        ParamByName('DOCID').AsInteger := FDocID;
        try
        if Assigned(ATable.Cells[I, 0]) then
        begin
          ParamByName('GOODSID').AsString := ATable.Cells[I, 0].DisplayText;
          Query.ParamByName('GOODSID').AsString := ATable.Cells[I, 0].DisplayText;
          Query.Prepare;
          Query.Open;
          ParamByName('price4lei').AsString := Query.FieldByName('price4lei').AsString;
          ParamByName('price7').AsString := Query.FieldByName('price7').AsString;
          Query.Close;
        end;

        if Assigned(ATable.Cells[I, 1]) then
          ParamByName('URL').AsString := Copy(ATable.Cells[I, 1].DisplayText, 1, 1024);

          AGoodsID := ATable.Cells[I, 0].DisplayText;
          Execute;
        except
          on e: Exception do
          begin
            MessageDlg(Format('Eroare! '#13#10'Produs :#%s'#13#10'%s',[AGoodsID, e.Message]), mtError, [mbOK], 0);
            // raise;
          end;
        end;
        Application.ProcessMessages;
      end;
    end;

    try
      IBCTrWrite.Commit;
    except
      ShowMessage('GOODSID = ' + AGoodsID);
      IBCTrWrite.Rollback;
    end;
  finally
    ibcsql.Free;
    Query.Free;
  end;
end;

procedure TfrmImportGoodsConcurentsDlg.Prepare;
begin
  PrepareSpreadSheet;
end;

procedure TfrmImportGoodsConcurentsDlg.PrepareSpreadSheet;
var
  ATable: TdxSpreadSheetTableView;
begin

  ATable := dxSpreadSheet1.ActiveSheetAsTable;

  with ATable.CreateCell(0, 0) do
  begin
    AsString := 'Cod produs';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 80;
    Style.Font.Style := [fsBold];
  end;

  with ATable.CreateCell(0, 1) do
  begin
    AsString := 'URL';
    Column.Style.AlignHorz := ssahCenter;
    Column.Size := 500;
    Style.Font.Style := [fsBold];
  end;

end;

procedure TfrmImportGoodsConcurentsDlg.SetDocID(const Value: Integer);
begin
  FDocID := Value;
end;

end.

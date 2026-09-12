unit frameGoodsStockUnit;

interface

uses
  Windows, Forms, System.SysUtils, cxStyles,
  cxTL, cxTextEdit, Data.DB, IBC, cxInplaceContainer, System.Classes, Vcl.Controls,
  cxCalc, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, dxScrollbarAnnotations,
  cxTLdxBarBuiltInMenu, MemDS, DBAccess, cxFilter;

type
  TOnStockDblClick = procedure(const StockID: integer; const StockTitle: string) of object;

  TframeGoodsStock = class(TFrame)
    IBCQueryStockQTY: TIBCQuery;
    cxTree: TcxTreeList;
    cxTree_TITLE: TcxTreeListColumn;
    cxTree_QTY: TcxTreeListColumn;
    cxTree_STOCKID: TcxTreeListColumn;
    procedure cxTreeDblClick(Sender: TObject);
    procedure cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode;
      var AStyle: TcxStyle);
  private
    { Private declarations }
    FDataOpened: Boolean;
    FOnStockDblClick: TOnStockDblClick;
    procedure SetOnStockDblClick(const Value: TOnStockDblClick);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property DataOpened: Boolean read fDataOpened;
    procedure ShowStockForGoods(const GoodsID, DT: integer; const ShowExistingOnly: Boolean = False);
    procedure ClearView;
  public
    property OnStockDblClick: TOnStockDblClick read FOnStockDblClick write SetOnStockDblClick;
  end;

implementation

uses
  DataModuleAdditions, SWNConst, SWNValueStorageUnit, System.Variants;

{$R *.dfm}

{ TframeGoodsStock }

procedure TframeGoodsStock.ClearView;
begin
  cxTree.BeginUpdate;
  try
    cxTree.Clear;
  finally
    cxTree.EndUpdate;
    FDataOpened := False;
  end;
end;

constructor TframeGoodsStock.Create(AOwner: TComponent);
var
  qtyDigitsMode: Integer;
begin
  inherited;
  FDataOpened := False;
  FOnStockDblClick := nil;

     // Numarul de zecimale in QTY :
  qtyDigitsMode := AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits, cAppDefault_QtyDigits);
     // Stoc
  TcxCalcEditProperties(cxTree_QTY.Properties).DisplayFormat := cQTY_DigitsMask[qtyDigitsMode];
end;

procedure TframeGoodsStock.cxTreeDblClick(Sender: TObject);
var
  Node: TcxTreeListNode;
begin
  Node := cxTree.FocusedNode;
  if Assigned(Node) and (Node.Level = 1) and Assigned(FOnStockDblClick) then
  begin
    FOnStockDblClick(StrToInt(Node.Texts[2]), Node.Texts[0]);
  end;
end;

procedure TframeGoodsStock.cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode:
  TcxTreeListNode; var AStyle: TcxStyle);
begin
  if VarIsFloat(ANode.Values[1]) then
  begin
    if ANode.Values[1] > 0 then
      AStyle := dmAdditions.cxStyle_Bold
    else if ANode.Values[1] < 0 then
      AStyle := dmAdditions.cxStyle_TextColorRed;
  end
  else
    AStyle := dmAdditions.cxStyle_TextGray;
end;

procedure TframeGoodsStock.SetOnStockDblClick(const Value: TOnStockDblClick);
begin
  FOnStockDblClick := Value;
end;

procedure TframeGoodsStock.ShowStockForGoods(const GoodsID, DT: integer; const ShowExistingOnly: Boolean);
var
  Node, Node2: TcxTreeListNode;
begin
  IBCQueryStockQTY.ParamByName('GOODSID').AsInteger := GoodsID;
  IBCQueryStockQTY.ParamByName('DT').AsInteger := DT;
  if ShowExistingOnly then
    IBCQueryStockQTY.FilterSQL := 'QTY>0'
  else
    IBCQueryStockQTY.FilterSQL := '';

  cxTree.BeginUpdate;
  try
    cxTree.Clear;
    IBCQueryStockQTY.Open;
    while not IBCQueryStockQTY.Eof do
    begin
      if (IBCQueryStockQTY.FieldByName('FLG_FOLDER').AsInteger = 1) and (IBCQueryStockQTY.FieldByName('PARENTID').AsInteger
        = 0) then
      begin
        Node := cxTree.Add;
        Node.Values[0] := IBCQueryStockQTY.FieldByName('TITLE').AsString;
        Node.Values[1] := IBCQueryStockQTY.FieldByName('QTY').AsFloat;
        Node.Values[2] := IBCQueryStockQTY.FieldByName('STOCKID').AsInteger;
        Node.ImageIndex := 13;
        Node.SelectedIndex := 13;
      end;
      IBCQueryStockQTY.Next;
    end;
    if cxTree.Count > 0 then
    begin
      Node := cxTree.Items[0];

      if True then // Security = "Poate vede scladurile din subgrupe sau nu"
        while Node <> nil do
        begin
          IBCQueryStockQTY.First;
          while not IBCQueryStockQTY.Eof do
          begin
            if (IBCQueryStockQTY.FieldByName('FLG_FOLDER').AsInteger = 0) and (IBCQueryStockQTY.FieldByName('PARENTID').AsInteger
              = Node.Values[2]) then
            begin
              Node2 := cxTree.AddChild(Node);
              Node2.Values[0] := IBCQueryStockQTY.FieldByName('TITLE').AsString;
              Node2.Values[1] := IBCQueryStockQTY.FieldByName('QTY').AsFloat;
              Node2.Values[2] := IBCQueryStockQTY.FieldByName('STOCKID').AsInteger;
              Node2.ImageIndex := 27;
              Node2.SelectedIndex := 27;

              if IBCQueryStockQTY.FieldByName('QTY').AsFloat > 0 then
                Node.Expanded := True;
            end;
            IBCQueryStockQTY.Next;
          end;
          Node := Node.getNextSibling;
        end;
    end;

    if cxTree.Count = 0 then
    begin
             // no record, show info
      Node := cxTree.Add;
      Node.Values[0] := 'Nu este in stoc';
      Node.ImageIndex := -1;
      Node.SelectedIndex := -1;
      cxTree.OptionsView.ShowRoot := False;
      cxTree.Enabled := False;
    end
    else
    begin
      cxTree.OptionsView.ShowRoot := True;
      cxTree.Enabled := True;
    end;
  finally
    IBCQueryStockQTY.Close;
    cxTree.EndUpdate;
    FDataOpened := True;
  end;
end;

end.


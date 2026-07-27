unit frmWebGoodsPromoSortingDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxStyles, cxTL, cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu, dxBar, cxClasses, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxInplaceContainer, DialogTitle, Data.DB, MemDS, DBAccess, IBC,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxFilter,
  dxScrollbarAnnotations;

type
  TPromoRecord = record
    goodsid: Integer;
    orderno: Integer;
    name: string;
  end;
  PPromoRecord = ^TPromoRecord;

  TfrmWebGoodsPromoSortingDlg = class(TSWNBaseFormClass)
    dtDialogTitle: TDialogTitle;
    cxTree: TcxTreeList;
    cxTree_TITLE: TcxTreeListColumn;
    cxTree_ID: TcxTreeListColumn;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbMoveUp: TdxBarButton;
    bbMoveDown: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    IBCtrUpdate: TIBCTransaction;
    IBCQueryActiuni: TIBCQuery;
    procedure bbMoveUpClick(Sender: TObject);
    procedure bbMoveDownClick(Sender: TObject);
    procedure cxTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cxTreeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
  private
    FPromoActionID: Integer;
    procedure SetPromoActionID(const Value: Integer);
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    procedure MoveItem(const Dir: Integer);
    function SaveOrderNo: boolean;
    property PromoActionID: Integer read FPromoActionID write SetPromoActionID;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmWebPromoSortingActiuniDlg }

procedure TfrmWebGoodsPromoSortingDlg.MoveItem(const Dir: Integer);
var
  NodeSource, NodeTarget: TcxTreeListNode;
begin
  if Assigned(cxTree.FocusedNode) and (cxTree.Count > 1) then
  begin
    NodeSource := cxTree.FocusedNode;
    cxTree.BeginUpdate;
    try
      case Dir of
        1:
          begin
            // Up
            NodeTarget := NodeSource.getPrevSibling;
            if Assigned(NodeTarget) then
              NodeSource.MoveTo(NodeTarget, tlamInsert);
          end;
        2:
          begin
            // Down
            NodeTarget := NodeSource.getNextSibling;
            if Assigned(NodeTarget) then
              NodeTarget.MoveTo(cxTree.FocusedNode, tlamInsert);
          end;
        3:
          begin
            // Home
            NodeTarget := cxTree.Items[0];
            if Assigned(NodeTarget) then
              NodeSource.MoveTo(NodeTarget, tlamAddFirst);
          end;
        4:
          begin
            // End
            NodeTarget := cxTree.Items[cxTree.Count - 1];
            if Assigned(NodeTarget) then
              NodeSource.MoveTo(NodeTarget, tlamAdd);
          end;
      end;
    finally
      cxTree.EndUpdate;
      NodeSource.MakeVisible;
    end;
  end;
end;


procedure TfrmWebGoodsPromoSortingDlg.bbMoveDownClick(Sender: TObject);
begin
  MoveItem(2); // Move Down
end;

procedure TfrmWebGoodsPromoSortingDlg.bbMoveUpClick(Sender: TObject);
begin
  MoveItem(1); // Move Up
end;

procedure TfrmWebGoodsPromoSortingDlg.cxTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  tmpNode: TcxTreeListNode;
begin
  tmpNode := cxTree.GetNodeAt(X, Y);
  if Assigned(cxTree.DragNode) and Assigned(tmpNode) then
  begin
    // DragNode above tmpNode
    cxTree.DragNode.MoveTo(tmpNode, tlamInsert);
  end;
end;

procedure TfrmWebGoodsPromoSortingDlg.cxTreeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Sender = cxTree);
end;

function TfrmWebGoodsPromoSortingDlg.IsFormDataPosted: Boolean;
begin
  Result := SaveOrderNo;
end;

procedure TfrmWebGoodsPromoSortingDlg.Prepare;
var
  Node: TcxTreeListNode;
  PromoRec: PPromoRecord;
begin
  inherited;
  IBCQueryActiuni.ParamByName('PROMOACTIONID').AsInteger := PromoActionID;
  IBCQueryActiuni.Open;
  cxTree.Clear;
  while not IBCQueryActiuni.Eof do
  begin
    Node := cxTree.Add;
    new(promorec);

    PromoRec^.goodsid := IBCQueryActiuni.FieldByName('GOODSID').AsInteger;
    PromoRec^.orderno := IBCQueryActiuni.FieldByName('ORDERNO').AsInteger;
    PromoRec^.name := IBCQueryActiuni.FieldByName('GOODS_NAME').AsString;
    Node.Data := PromoRec;
    Node.Texts[1] := IBCQueryActiuni.FieldByName('GOODSID').AsString;
    Node.Texts[0] := IBCQueryActiuni.FieldByName('GOODS_NAME').AsString;
    IBCQueryActiuni.Next;
  end;
  cxTree.FocusedNode := cxTree.TopNode;
end;

function TfrmWebGoodsPromoSortingDlg.SaveOrderNo: boolean;
var
  N: Integer;
  Node: TcxTreeListNode;
begin
//  dmDB.ExecuteQuery('update VW_TWEB_PA_GOODS set FLG_ENABLED=0 where END_DATE < CURRENT_DATE',[]);
//  dmDB.ExecuteQuery('update VW_TWEB_PROMOS set ORDERNO=100 where FLG_ENABLED=0',[]);
  Result := False;
  try
    IBCtrUpdate.DefaultConnection := fIBCConnection;
    if not IBCtrUpdate.Active then
      IBCtrUpdate.StartTransaction;
    try
      IBCQueryActiuni.First;
      IBCQueryActiuni.DisableControls;
      N := 1;
      Node := cxTree.Items[0];
      while Node <> nil do
      begin
        if IBCQueryActiuni.Locate('goodsid',node.Values[1],[] ) then
        begin
          IBCQueryActiuni.Edit;
          IBCQueryActiuni.FieldByName('OrderNo').AsInteger := N;
          IBCQueryActiuni.Post;
        end;
        Inc(N);
        Node := Node.getNextSibling;
      end;

      if IBCtrUpdate.Active then
        IBCtrUpdate.Commit;
      Result := True;
    except
        IBCtrUpdate.Rollback;
      raise;
    end;
  finally
    IBCQueryActiuni.Close;
  end;
end;

procedure TfrmWebGoodsPromoSortingDlg.SetPromoActionID(const Value: Integer);
begin
  FPromoActionID := Value;
end;

procedure TfrmWebGoodsPromoSortingDlg.WhenCancelForm;
begin
  inherited;

end;

end.

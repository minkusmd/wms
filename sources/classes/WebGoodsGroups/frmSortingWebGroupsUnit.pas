unit frmSortingWebGroupsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxCustomData, cxStyles, cxTL, cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu, dxBar, cxClasses, Vcl.StdCtrls, Vcl.ExtCtrls,
  cxInplaceContainer, DialogTitle, Data.DB, MemDS, DBAccess, IBC,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations,
  cxFilter;

type
  TGGRecord = record
    GGID: Integer;
    Name: string;
    OrderNo: Integer;
  end;
  PGGRecord = ^TGGRecord;

  //TSWNBaseFormClass
  TfrmSortingWebGroupsDlg = class(TSWNBaseFormClass)
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
    { Private declarations }
  protected
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    { Public declarations }
    procedure MoveItem(const Dir: Integer);
    function SaveOrderNo: boolean;
  end;

implementation

uses
  DataModuleAdditions, DataModuleDB;

{$R *.dfm}

{ TfrmWebPromoSortingActiuniDlg }

procedure TfrmSortingWebGroupsDlg.MoveItem(const Dir: Integer);
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


procedure TfrmSortingWebGroupsDlg.bbMoveDownClick(Sender: TObject);
begin
  MoveItem(2); // Move Down
end;

procedure TfrmSortingWebGroupsDlg.bbMoveUpClick(Sender: TObject);
begin
  MoveItem(1); // Move Up
end;

procedure TfrmSortingWebGroupsDlg.cxTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
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

procedure TfrmSortingWebGroupsDlg.cxTreeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := (Sender = cxTree);
end;

function TfrmSortingWebGroupsDlg.IsFormDataPosted: Boolean;
begin
  Result := SaveOrderNo;
end;

procedure TfrmSortingWebGroupsDlg.Prepare;
var
  Node: TcxTreeListNode;
  GGRec: PGGRecord;
begin
  inherited;
  IBCQueryActiuni.Open;
  cxTree.Clear;
  while not IBCQueryActiuni.Eof do
  begin
    Node := cxTree.Add;
    new(ggrec);

    ggRec^.ggid := IBCQueryActiuni.FieldByName('GGID').AsInteger;
    ggRec^.orderno := IBCQueryActiuni.FieldByName('ORDERNO').AsInteger;
    ggRec^.name := IBCQueryActiuni.FieldByName('TITLE_RO').AsString;
    Node.Data := ggRec;
    Node.Texts[1] := IBCQueryActiuni.FieldByName('GGID').AsString;
    Node.Texts[0] := IBCQueryActiuni.FieldByName('TITLE_RO').AsString;
    IBCQueryActiuni.Next;
  end;
  cxTree.FocusedNode := cxTree.TopNode;
end;

function TfrmSortingWebGroupsDlg.SaveOrderNo: boolean;
var
  N: Integer;
  Node: TcxTreeListNode;
begin
  dmDB.ExecuteQuery('update TWEB_FP_GROUPS set ORDERNO=9999 where CURRENT_DATE > CAST(DATA2 AS DATE)',[]);
//  Result := False;
  try
    IBCtrUpdate.DefaultConnection := fIBCConnection;
    if not IBCtrUpdate.Active then
      IBCtrUpdate.StartTransaction;
    try
      IBCQueryActiuni.DisableControls;
      IBCQueryActiuni.First;
      N := 1;
      Node := cxTree.Items[0];
      while Node <> nil do
      begin
        if IBCQueryActiuni.Locate('GGID',node.Values[1],[] ) then
        begin
          IBCQueryActiuni.Edit;
          IBCQueryActiuni.FieldByName('OrderNo').AsInteger := N;
          IBCQueryActiuni.Post;
        end;
        Inc(N);
        Node := Node.getNextSibling;
      end;

      if IBCtrUpdate.Active then
      begin
        IBCQueryActiuni.ApplyUpdates;
        IBCQueryActiuni.CommitUpdates;
        IBCtrUpdate.Commit;
      end;

      IBCQueryActiuni.EnableControls;
      Result := True;
    except
        IBCtrUpdate.Rollback;
      raise;
    end;
  finally
    IBCQueryActiuni.Close;
  end;
end;

procedure TfrmSortingWebGroupsDlg.WhenCancelForm;
begin
  inherited;

end;

end.

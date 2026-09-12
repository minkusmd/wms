unit frmReportSelectDocTypeDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DialogTitle, cxStyles, cxTL, Menus,
  StdCtrls, cxButtons, cxInplaceContainer, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData,
  dxScrollbarAnnotations, cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu;

type
  TfrmReportSelectDocTypeDlg = class(TForm)
    dtDialogTitle: TDialogTitle;
    cxTreeList: TcxTreeList;
    cxTreeList1cxTreeListColumn1: TcxTreeListColumn;
    cxTreeList1cxTreeListColumn2: TcxTreeListColumn;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cxTreeListDblClick(Sender: TObject);
    procedure cxTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure cxTreeListStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode;
      var AStyle: TcxStyle);
    procedure cxTreeListDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
  private
    { Private declarations }
    FDocTypeID: integer;
    fDocType_Title: String;

    procedure LoadDocTypeStructure;
    function GetNodeByDocTypeID(const DocTypeID:Integer):TcxTreeListNode;
    procedure SetDocTypeID(const Value: integer);
  public
    { Public declarations }
    property DocTypeID:integer read FDocTypeID write SetDocTypeID;
    property DocType_Title:String read fDocType_Title;

    procedure SetCustomTitle(const Title,Text:String);
  end;


implementation

uses DataModuleAdditions, DataModuleDB, IBC;

{$R *.dfm}

type
    PItemData = ^TItemData;
    TItemData = record
      DocTypeID:integer;
      IsGroup:Boolean;
    end;

{ TfrmReportSelectDocTypeDlg }

procedure TfrmReportSelectDocTypeDlg.btnOkClick(Sender: TObject);
var Node:TcxTreeListNode;
    Data:PItemData;
begin
     Node:=cxTreeList.FocusedNode;
     if Assigned(Node) then
     begin
          Data:=Node.Data;
          fDocType_Title:=Node.Texts[0];
          FDocTypeID:=Data^.DocTypeID;
          ModalResult:=mrOk;
     end;
end;

procedure TfrmReportSelectDocTypeDlg.cxTreeListDblClick(Sender: TObject);
var Node:TcxTreeListNode;
    Data:PItemData;
begin
     Node:=cxTreeList.FocusedNode;
     if Assigned(Node) then
     begin
          Data:=Node.Data;
          if Not Data^.IsGroup then btnOkClick(btnOk);
     end;
end;

procedure TfrmReportSelectDocTypeDlg.cxTreeListDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
begin
     Dispose(ANode.Data);
end;

procedure TfrmReportSelectDocTypeDlg.cxTreeListFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode,
  AFocusedNode: TcxTreeListNode);
var Data:PItemData;
begin
     if Assigned(AFocusedNode) then
     begin
          Data:=AFocusedNode.Data;
          btnOk.Enabled:=Not Data^.IsGroup;
     end
     else btnOk.Enabled:=False;
end;

procedure TfrmReportSelectDocTypeDlg.cxTreeListStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode; var AStyle: TcxStyle);
var Data:PItemData;
begin
     if Assigned(ANode) then
     begin
          Data:=ANode.Data;
          if Data^.DocTypeID=-1 then AStyle:=dmAdditions.cxStyle_Bold;
     end;
end;

procedure TfrmReportSelectDocTypeDlg.FormCreate(Sender: TObject);
begin
     FDocTypeID := -1;
     fDocType_Title := '';
end;

procedure TfrmReportSelectDocTypeDlg.FormShow(Sender: TObject);
begin
     LoadDocTypeStructure;
end;

function TfrmReportSelectDocTypeDlg.GetNodeByDocTypeID(const DocTypeID: Integer): TcxTreeListNode;
var Node:TcxTreeListNode;
    Data:PItemData;
begin
     Result:=nil;
     //if cxTreeList.Count>0 then Node:=cxTreeList.Items[0];
     Node:=cxTreeList.Items[0];
     while Node<>nil do
     begin
          Data:=PItemData(Node.Data);
          if Data^.DocTypeID=DocTypeID then
          begin
               Result:=Node;
               Break;
          end;
          Node:=Node.getNextSibling;
     end;
end;

procedure TfrmReportSelectDocTypeDlg.LoadDocTypeStructure;
var Query:TIBCQuery;
    NodeR,NodeCh,SelNode:TcxTreeListNode;
    Data:PItemData;
begin
     SelNode:=nil;
     Query:=TIBCQuery.Create(Self);
     cxTreeList.BeginUpdate;
     try
        cxTreeList.Clear;

        // create null item
        New(Data);
        Data^.DocTypeID:=-1;
        Data^.IsGroup:=False;

        NodeR:=cxTreeList.Add;
        NodeR.Data:=Data;
        NodeR.Texts[0]:='Fara tip de document';
        NodeR.ImageIndex:=23;
        NodeR.SelectedIndex:=23;

        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT * FROM VW_TS_DOCTYPES WHERE (FLG_ACTION=0) AND (PARENTID=0) ORDER BY PARENTID, DOCTYPEID';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             // root node
             New(Data);
             Data^.DocTypeID:=Query.FieldByName('DOCTYPEID').AsInteger;
             Data^.IsGroup:=True;

             NodeR:=cxTreeList.Add;
             NodeR.Data:=Data;

             NodeR.Texts[0]:=Query.FieldByName('TITLE').AsString;
             NodeR.ImageIndex:=14;
             NodeR.SelectedIndex:=14;

             Query.Next;
        end;
        Query.Close;

        Query.SQL.Text:='SELECT * FROM VW_TS_DOCTYPES WHERE (FLG_ACTION=0) AND (PARENTID>0) ORDER BY PARENTID, DOCTYPEID';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             // child node
             NodeR:=GetNodeByDocTypeID(Query.FieldByName('PARENTID').AsInteger);
             if Assigned(NodeR) then
             begin
                  New(Data);
                  Data^.DocTypeID:=Query.FieldByName('DOCTYPEID').AsInteger;
                  Data^.IsGroup:=False;

                  NodeCh:=cxTreeList.AddChild(NodeR);
                  NodeCh.Data:=Data;
                  NodeCh.Texts[0]:=Query.FieldByName('TITLE').AsString;
                  NodeCh.Texts[1]:=IntToStr(Data^.DocTypeID);
                  NodeCh.ImageIndex:=16;
                  NodeCh.SelectedIndex:=16;

                  if FDocTypeID=Data^.DocTypeID then
                  begin
                       // select node
                       NodeR.Expanded:=True;
                       SelNode:=NodeCh;
                  end;
             end;
             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
        cxTreeList.EndUpdate;
     end;

     if Assigned(SelNode) then
     begin
          cxTreeList.Select(SelNode);
          cxTreeList.FocusedNode:=SelNode;
     end;
end;

procedure TfrmReportSelectDocTypeDlg.SetCustomTitle(const Title, Text: String);
begin
     dtDialogTitle.Title:=Title;
     dtDialogTitle.Text:=Text;
     Caption:=Title;
end;

procedure TfrmReportSelectDocTypeDlg.SetDocTypeID(const Value: integer);
begin
     FDocTypeID := Value;
end;

end.

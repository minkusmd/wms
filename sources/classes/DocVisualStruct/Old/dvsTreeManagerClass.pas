unit dvsTreeManagerClass;

interface
Uses Classes, dvsDocClass, IBC;

type

  TdvsTreeManagerClass = class
  private
    fRootNode: TdvsDocItemClass;
    { Private declarations }

  protected
    { Protected declarations }
    fNodes:TList;
    procedure ClearNodes;
    procedure FindRootNode;

    procedure ReadDocumentParentStructure(const DocID:integer; const Connection:TIBCConnection);
  public
    { Public declarations }

    constructor Create;
    destructor Destroy;override;

    property RootNode:TdvsDocItemClass read fRootNode;

    procedure ScanDocumentTree(const DocID:integer; const Connection:TIBCConnection);

  end;



implementation

{ TdvsTreeManagerClass }

procedure TdvsTreeManagerClass.ClearNodes;
var i:integer;
begin
     for i := 0 to fNodes.Count - 1 do
     TdvsDocItemClass(fNodes[i]).Free;
     fNodes.Clear;
end;

constructor TdvsTreeManagerClass.Create;
begin
     fNodes:=TList.Create;
     fRootNode:=nil;
end;

destructor TdvsTreeManagerClass.Destroy;
begin
     ClearNodes;
     fNodes.Free;
     inherited;
end;

procedure TdvsTreeManagerClass.FindRootNode;
var i:integer;
    Node:TdvsDocItemClass;
begin
     fRootNode:=nil;
     for i := 0 to fNodes.Count - 1 do
     begin
          Node:=TdvsDocItemClass(fNodes[i]);
          if (Node.ParentDocItem=nil) then
          begin
               fRootNode:=Node;
               Break;
          end;
     end;
end;

procedure TdvsTreeManagerClass.ReadDocumentParentStructure(const DocID: integer; const Connection: TIBCConnection);
var Query:TIBCQuery;
    Node:TdvsDocItemClass;
    PreviousNode:TdvsDocItemClass;
begin
     // construim copacul inapoi de la DocID
     PreviousNode:=nil;
     Query:=TIBCQuery.Create(nil);
     try
        Query.Connection:=Connection;
        Query.SQL.Text:='SELECT * FROM GET_DOC_TREE(:id)';
        Query.ParamByName('id').AsInteger:=DocID;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             Node:=TdvsDocItemClass.Create;
             Node.DocID:=Query.FieldByName('DOCID').AsInteger;
             Node.DocType:=Query.FieldByName('DOCTYPE_TITLE').AsString;
             Node.DocDateTime:=Query.FieldByName('DATA').AsDateTime;
             Node.Suma:=Query.FieldByName('SUMA').AsCurrency;
             Node.FLG_ACNT:=Query.FieldByName('FLG_ACNT').AsInteger=1;
             // add to node list
             fNodes.Add(Node);
             // create tree
             if (PreviousNode<>nil) then
             begin
                  PreviousNode.ParentDocItem:=Node;
                  Node.AddExistingChild(PreviousNode);
             end;

             Query.Next;

             PreviousNode:=Node;
        end;
     finally
        Query.Free;
     end;
end;

procedure TdvsTreeManagerClass.ScanDocumentTree(const DocID: integer; const Connection: TIBCConnection);
begin
     ClearNodes;
     ReadDocumentParentStructure(DocID,Connection);
     // in fNodes[0] se afla nodul pentru DocID indicat

     // temp
     FindRootNode;
end;

end.

unit frmChangeParentFolderDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, cxStyles, cxTL,
  DB, DBAccess, IBC, StdCtrls, ExtCtrls, cxInplaceContainer, DialogTitle,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, dxScrollbarAnnotations,
  cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu, Vcl.Menus, MemDS, cxFilter,
  cxContainer, cxEdit, Vcl.Buttons, cxMaskEdit, cxDropDownEdit, RzCmboBx,
  Vcl.NumberBox;

type
   TIDItem = class
     fID:integer;
     fTitle:String;
     constructor Create(const ID:integer; const Title:String);
   end;

  TDBTable = (dbtGOODS, dbtCUSTOMERS, dbtGOODSACNT, dbtSTOCKS, dbtFilters, dbtWebCatalog);

  TfrmChangeParentFolderDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxTree: TcxTreeList;
    trTree_GOODSID: TcxTreeListColumn;
    trTree_TITLE: TcxTreeListColumn;
    pnInfo: TPanel;
    cxLabel1: TLabel;
    edParentTitle: TEdit;
    cxLabel3: TLabel;
    edObjTitle: TEdit;
    edObjID: TEdit;
    edParentID: TEdit;
    IBCTrUpdate: TIBCTransaction;
    IBCQuery: TIBCQuery;
    IBCQueryTemp: TIBCQuery;
    pnBottom: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    cmbHistoryFolders: TcxComboBox;
    Label2: TLabel;
    nbParentID: TNumberBox;
    procedure cxTreeSelectionChanged(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxTreeDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
    procedure cxTreeExpanding(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
    procedure cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode;
      var AStyle: TcxStyle);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    FCurrentFirmaID: Integer;
    { Private declarations }
    fDBTable:TDBTable;
    fFolderObjectID: integer;
    fNewParentID:integer;
    fNewParentTitle:String;
    function ReadLevel(const ParentID:integer; const TreeParentNode:TcxTreeListNode):Boolean;
    procedure SetFolderObjectID(const Value: integer);
    procedure NavigateToFolderObjectID;
    function GetTreeNodeByID(const ParentID:integer; const ParentNode:TcxTreeListNode):TcxTreeListNode;
    function ExpandNode(const ANode:TcxTreeListNode):Boolean;
    procedure SetDBTable(const Value: TDBTable);
    function ProcessSQLTags(const SQLText:String):String;
    function SaveChanges:Boolean;
    function GetFullPath:String;
    procedure LoadHistoryFolders;
  protected
    { protected declarations }
    fList:TList;
    procedure Prepare;override;

    procedure LoadStates;override;
    procedure SaveStates;override;

    procedure ClearIDList;
    function GetFirstObjectID:integer;
  public
    property CurrentFirmaID: Integer read FCurrentFirmaID write FCurrentFirmaID;
    { Public declarations }
    property DBTable:TDBTable write SetDBTable;
    property FolderObjectID:integer read fFolderObjectID write SetFolderObjectID;
    procedure AddObjectInfo(const ID:integer; const Title:String);
  end;


implementation

uses DataModuleAdditions, SWNUtils, SWNValueStorageUnit, SWNClasses, System.StrUtils;

const
  cSQL_SelectLevel = 'SELECT <ID>, <TITLE>, '+  // ID,TITLE
                     ' (SELECT COUNT(<ID>) FROM <TABLE> G2 WHERE (G2.FLG_FOLDER=1) AND (G2.PARENTID=G1.<ID>)) AS CHILDCOUNT'+ // Table
                     ' FROM <TABLE> G1 '+
                     ' WHERE (FLG_FOLDER=1) and (PARENTID=:ParentID) and (<ID><>:ItemID)'+
                     ' <ORDERBY>';
  cSQL_GetTreeLevels = 'SELECT PARENTID FROM GET_TABLE_TREE_BY_ITEM(:dbTable,:dbKeyField,:ObjectID)';
  cSQL_UpdateParent = 'UPDATE <TABLE> SET PARENTID=:NewParentID WHERE <ID>=:ItemID';

type

  TGoodsItemType = (gitEmpty,gitFolder);

  PObjectItem=^TObjectItem;
  TObjectItem=record
    Loaded:Boolean;
    ParentID:integer;
    ItemID:integer;
    isItem:Boolean;
    isOriginalFolder:Boolean;
  end;

  TDBTableFieldsInfoRec=record
    DBTable:String;
    IDField:String;
    TitleField:String;
    OrderText:String;
    CustomSelectSQLIndex:integer;
  end;

const
     cDBTableFieldsInfo : array [TDBTable] of TDBTableFieldsInfoRec =
     (
      (DBTable:'TS_GOODS'; IDField:'GOODSID'; TitleField:'TITLE'; OrderText:'ORDER BY ORDERNO'; CustomSelectSQLIndex:-1),
      (DBTable:'VW_TS_CUSTOMER'; IDField:'CUSTOMERID'; TitleField:'DISPLAYNAME'; OrderText:'ORDER BY ORDERNO'; CustomSelectSQLIndex:-1),
      (DBTable:'TS_GOODS_ACNT'; IDField:'GOODS_ACNT_ID'; TitleField:'NAMEACNT'; OrderText:'ORDER BY ORDERNO'; CustomSelectSQLIndex:-1),
      (DBTable:'TS_STOCKS'; IDField:'STOCKID'; TitleField:'TITLE'; OrderText:''; CustomSelectSQLIndex:-1),
      (DBTable:'TS_FILTERS'; IDField:'FILTERID'; TitleField:'FILTERNAME_RUS'; OrderText:'ORDER BY ORDERNO'; CustomSelectSQLIndex:-1),
      (DBTable:'TWEB_CATALOG'; IDField:'CATALOGID'; TitleField:'TITLE_RUS'; OrderText:'ORDER BY ORDERNO'; CustomSelectSQLIndex:0)
     );

     cCustomSelectSQL : array [0..0] of String =
     (
      // TWEB_CATALOG. (nu are FLG_FOLDER)
      'SELECT <ID>, <TITLE>, '+  // ID,TITLE
      ' (SELECT COUNT(<ID>) FROM <TABLE> G2 WHERE (G2.PARENTID=G1.<ID>)) AS CHILDCOUNT'+ // Table
      ' FROM <TABLE> G1 WHERE (PARENTID=:ParentID) and (<ID><>:ItemID) AND (DT=:DT) <ORDERBY>'
     );


{$R *.dfm}

procedure TfrmChangeParentFolderDlg.btnOkClick(Sender: TObject);
var S:String;
begin
     if (fFolderObjectID=fNewParentID) and (nbParentID.ValueInt = 0) then ModalResult:=mrCancel // no changes
     else
     if (fFolderObjectID<>fNewParentID) or (nbParentID.ValueInt > 0) then
     begin
          if (nbParentID.ValueInt = 0) then
          begin
            if (fList.Count = 1)
               then S:='Trafera elementul'+#13#10+edObjTitle.Text+#13#10+'in mapa'+#13#10+GetFullPath+' ?'
               else S:='Transfera mapa cu '+IntToStr(fList.Count)+' elemente'+#13#10+'in mapa'+#13#10+GetFullPath+' ?';
          end
          else
            s := 'Transfera produsele selectate in mapa: '+ nbParentID.ValueInt.ToString + '?';

          if (ShowAskDialog('Modifica mapa parinte',S)=mrYes) then
            if SaveChanges then ModalResult:=mrOk;
     end;
end;

procedure TfrmChangeParentFolderDlg.ClearIDList;
var i:integer;
    obj:TIDItem;
begin
     for i := 0 to fList.Count - 1 do
     begin
          obj:=TIDItem(fList[i]);
          obj.Free;
     end;
     fList.Clear;
end;

procedure TfrmChangeParentFolderDlg.cxTreeDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
begin
     Dispose(ANode.Data);
end;

procedure TfrmChangeParentFolderDlg.cxTreeExpanding(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; var Allow: Boolean);
begin
     ExpandNode(ANode);
end;

procedure TfrmChangeParentFolderDlg.cxTreeSelectionChanged(Sender: TObject);
var Data:PObjectItem;
begin
     // display target info
     if Assigned(cxTree.FocusedNode) then
     begin
          Data:=PObjectItem(cxTree.FocusedNode.Data);
          fNewParentID:=Data^.ItemID;
          fNewParentTitle:=cxTree.FocusedNode.Texts[0];
     end
     else
     begin
          fNewParentID:=-1;
          fNewParentTitle:='';
     end;
end;

procedure TfrmChangeParentFolderDlg.cxTreeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn;
  ANode: TcxTreeListNode; var AStyle: TcxStyle);
var Data:PObjectItem;
begin
     if Assigned(ANode) and Assigned(ANode.Data) then
     begin
          Data:=PObjectItem(ANode.Data);
          if Data^.isOriginalFolder then AStyle:=dmAdditions.cxStyle_BoldYellowBack
          else
          if ANode.Selected or (Data^.ItemID=0) then AStyle:=dmAdditions.cxStyle_Bold;
     end;
end;

function TfrmChangeParentFolderDlg.ExpandNode(const ANode: TcxTreeListNode): Boolean;
var Data:PObjectItem;
    tmpNode2:TcxTreeListNode;
begin
     Result:=True;
     Data:=PObjectItem(ANode.Data);
     if (Not Data^.Loaded) and (ANode.Count>0) then
     begin
          cxTree.BeginUpdate;
          try
             ANode.DeleteChildren;
             if Not ReadLevel(Data^.ItemID,ANode) then
             begin
                  New(Data);
                  Data^.Loaded:=True;
                  Data^.isItem:=False;
                  tmpNode2:=cxTree.AddChild(ANode,Data);
                  tmpNode2.Texts[0]:='Eroare!';
                  tmpNode2.Texts[1]:='';
                  tmpNode2.ImageIndex:=-1;
                  tmpNode2.SelectedIndex:=-1;
                  Result:=False;
             end;
             Data^.Loaded:=True;
          finally
             cxTree.EndUpdate;
          end;
     end;
end;

procedure TfrmChangeParentFolderDlg.FormCreate(Sender: TObject);
var
  ComboBox: TComboBox;

begin
     fList:=TList.Create;

     fFolderObjectID:=-1;
     fNewParentID:=-1;
     fNewParentTitle:='';
end;

procedure TfrmChangeParentFolderDlg.FormDestroy(Sender: TObject);
begin
     ClearIDList;
     fList.Free;
end;

procedure TfrmChangeParentFolderDlg.Prepare;
var Node:TcxTreeListNode;
    obj:TIDItem;
begin
     if fList.Count>0 then
     begin
          if fList.Count=1 then
          begin
               obj:=TIDItem(fList[0]);
               edObjID.Text:=IntToStr(obj.fID);
               edObjTitle.Text:=obj.fTitle;
          end
          else
          begin
               edObjID.Text:='';
               edObjTitle.Text:=Format('Grupa de elemente. Total %d.',[fList.Count]);
          end;
     end;

     ReadLevel(0,nil);
     if fFolderObjectID>0 then NavigateToFolderObjectID
     else
     if fFolderObjectID=0 then
     begin
          Node:=GetTreeNodeByID(fFolderObjectID,nil);
          if Assigned(Node) then
          begin
               edParentID.Text:=Node.Texts[1];
               edParentTitle.Text:=Node.Texts[0];
               fNewParentID:=fFolderObjectID;
               Node.MakeVisible;
          end;
     end;

     LoadHistoryFolders;

end;

function TfrmChangeParentFolderDlg.ProcessSQLTags(const SQLText:String): String;
begin
     Result:=StringReplace(SQLText,'<ID>',cDBTableFieldsInfo[fDBTable].IDField,[rfReplaceAll, rfIgnoreCase]);
     Result:=StringReplace(Result,'<TITLE>',cDBTableFieldsInfo[fDBTable].TitleField,[rfReplaceAll, rfIgnoreCase]);
     Result:=StringReplace(Result,'<TABLE>',cDBTableFieldsInfo[fDBTable].DBTable,[rfReplaceAll, rfIgnoreCase]);
     Result:=StringReplace(Result,'<ORDERBY>',cDBTableFieldsInfo[fDBTable].OrderText,[rfReplaceAll, rfIgnoreCase]);
end;

function TfrmChangeParentFolderDlg.GetFirstObjectID: integer;
begin
     Result:=-1;
     if fList.Count>0 then Result:=TIDItem(fList[0]).fID;
end;

function TfrmChangeParentFolderDlg.GetFullPath: String;
var Node:TcxTreeListNode;
begin
     Result:='';
     Node:=cxTree.FocusedNode;
     while (Node<>nil) and (Node.Parent<>nil) do
     begin
          Result:=Node.Texts[0]+'\'+Result;
          Node:=Node.Parent;
     end;
end;

function TfrmChangeParentFolderDlg.GetTreeNodeByID(const ParentID: integer;
  const ParentNode: TcxTreeListNode): TcxTreeListNode;
var tmpNode:TcxTreeListNode;
    Data:PObjectItem;
begin
     Result:=nil;

     if ParentID=0 then
     begin
          Result:=cxTree.Items[0];
          Exit;
     end;

     if ParentNode=nil
      then tmpNode:=cxTree.Items[0].getFirstChild
      else tmpNode:=ParentNode.getFirstChild;

     while (tmpNode<>nil) do
     begin
          Data:=PObjectItem(tmpNode.Data);
          if Data^.ItemID=ParentID then
          begin
               Result:=tmpNode;
               break;
          end;

          tmpNode:=tmpNode.getNextSibling;
     end;
end;

procedure TfrmChangeParentFolderDlg.LoadStates;
begin
     if AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     if (fDBTable = dbtGOODS) then
       cmbHistoryFolders.Properties.Items.Text := AppUserConfigStorage.TextValues.GetValue('goodsChangeFolderHistory');

end;

procedure TfrmChangeParentFolderDlg.NavigateToFolderObjectID;
var tmpParentID,i:integer;
    tmpNode:TcxTreeListNode;
    IntList:TIntegerList;
begin
     IntList:=TIntegerList.Create;
     try
        try
           IBCQueryTemp.SQL.Text:=cSQL_GetTreeLevels;
           IBCQueryTemp.ParamByName('dbTable').AsString:=cDBTableFieldsInfo[fDBTable].DBTable;
           IBCQueryTemp.ParamByName('dbKeyField').AsString:=cDBTableFieldsInfo[fDBTable].IDField;
           IBCQueryTemp.ParamByName('ObjectID').AsInteger:=fFolderObjectID;
           IBCQueryTemp.ExecSQL;
           while Not IBCQueryTemp.Eof do
           begin
                IntList.Add(IBCQueryTemp.Fields[0].asInteger);
                IBCQueryTemp.Next;
           end;
        except on E:Exception do
           begin
                ShowErrorDialog('Eroare','Nu pot identifica mapa parinte!',E.Message);
                raise;
           end;
        end;

     finally
        IBCQueryTemp.Close;
     end;

     tmpNode:=nil;
      cxTree.BeginUpdate;
      try
         if IntList.Count>0 then
         for i :=IntList.Count-1 downto 0 do  // Reverse order: from ROOT to actual position
         begin
              tmpParentID:=IntList[i];
              tmpNode:=GetTreeNodeByID(tmpParentID,tmpNode);
              if Assigned(tmpNode) then
              begin
                   if ExpandNode(tmpNode)
                    then tmpNode.Expanded:=True
                    else break;
              end
              else break;
         end;
         // make focused
         tmpNode:=GetTreeNodeByID(fFolderObjectID,tmpNode);
      finally
         cxTree.EndUpdate;
      end;

      if Assigned(tmpNode) then
      begin
           fNewParentID:=fFolderObjectID;
           cxTree.TopVisibleNode:=tmpNode;
           cxTree.Select(tmpNode,[]);
           cxTree.FocusedNode:=tmpNode;
           edParentID.Text:=tmpNode.Texts[1];
           edParentTitle.Text:=tmpNode.Texts[0];
      end;

     IntList.Free;
end;

function TfrmChangeParentFolderDlg.ReadLevel(const ParentID: integer;
  const TreeParentNode: TcxTreeListNode): Boolean;
var tmpNode,tmpNode2,rootNode:TcxTreeListNode;
    Data:PObjectItem;
begin
     Result:=false;
     try
        cxTree.BeginUpdate;
        try
           rootNode:=TreeParentNode;
           if ParentID=0 then
           begin
                // Add Root item
                New(Data);
                Data^.ParentID:=0;
                Data^.ItemID:=0;
                Data^.isItem:=True;
                Data^.Loaded:=True;
                Data^.isOriginalFolder:=fFolderObjectID=0;

                rootNode:=cxTree.AddChild(nil,Data);
                rootNode.Texts[0]:='ROOT';
                rootNode.Texts[1]:='';
                rootNode.Expanded:=True;
                //tmpNode.Texts[1]:='';

                if Data^.isOriginalFolder
                 then rootNode.ImageIndex:=27
                 else rootNode.ImageIndex:=13;
                rootNode.SelectedIndex:=34;
           end;

           if (cDBTableFieldsInfo[fDBTable].CustomSelectSQLIndex=-1) then
              IBCQuery.SQL.Text:=ProcessSQLTags(cSQL_SelectLevel)
           else
           begin
              IBCQuery.SQL.Text:=ProcessSQLTags(cCustomSelectSQL[cDBTableFieldsInfo[fDBTable].CustomSelectSQLIndex]);
              IBCQuery.ParamByName('DT').AsInteger := CurrentFirmaID;
           end;

           IBCQuery.ParamByName('ParentID').AsInteger:=ParentID;
           IBCQuery.ParamByName('ItemID').AsInteger:=GetFirstObjectID;
           IBCQuery.ExecSQL;

           while Not IBCQuery.Eof do
           begin
                New(Data);
                Data^.ParentID:=ParentID;
                Data^.ItemID:=IBCQuery.FieldByName(cDBTableFieldsInfo[fDBTable].IDField).AsInteger;
                Data^.isItem:=True;
                Data^.Loaded:=False;
                Data^.isOriginalFolder:=Data^.ItemID=fFolderObjectID;

                tmpNode:=cxTree.AddChild(rootNode,Data);
                tmpNode.Texts[0]:=IBCQuery.FieldByName(cDBTableFieldsInfo[fDBTable].TitleField).AsString;;
                tmpNode.Texts[1]:=IntToStr(Data^.ItemID);

                if Data^.isOriginalFolder
                 then tmpNode.ImageIndex:=27
                 else tmpNode.ImageIndex:=13;
                tmpNode.SelectedIndex:=34;

                if IBCQuery.FieldByName('CHILDCOUNT').AsInteger>0 then
                begin
                     // add NULL child to show "expander"
                     New(Data);
                     Data^.Loaded:=False;
                     Data^.isItem:=False;
                     tmpNode2:=cxTree.AddChild(tmpNode,Data);
                     tmpNode2.Texts[0]:='Citire date...';
                     tmpNode2.Texts[1]:='';
                     tmpNode2.ImageIndex:=-1;
                     tmpNode2.SelectedIndex:=-1;
                end;

                IBCQuery.Next;
           end;
           Result:=True;
           if ParentID=0 then rootNode.Expanded:=True;
        except on E:Exception do
           ShowErrorDialog('Eroare','Eroare la citirea datelor!',E.Message);
        end;
     finally
        IBCQuery.Close;
        cxTree.EndUpdate;
     end;
end;

function TfrmChangeParentFolderDlg.SaveChanges: Boolean;
var i:integer;
  FocusedColumnIndex: Integer;
  FocusedNodeIndex: Integer;
  FullPath: String;
  GoodsID: string;
  obj:TIDItem;
begin
     Result:=False;
     IBCQueryTemp.Transaction:=IBCTrUpdate;
     IBCTrUpdate.StartTransaction;
     try
        IBCQueryTemp.SQL.Text:=ProcessSQLTags(cSQL_UpdateParent);
        if nbParentID.ValueInt > 0 then
          IBCQueryTemp.ParamByName('NewParentID').AsInteger:=nbParentID.ValueInt
        else
          IBCQueryTemp.ParamByName('NewParentID').AsInteger:=fNewParentID;

        for i := 0 to fList.Count - 1 do
        begin
             obj:=TIDItem(fList[i]);
             IBCQueryTemp.ParamByName('ItemID').AsInteger:=obj.fID;
             IBCQueryTemp.ExecSQL;
        end;

        IBCTrUpdate.Commit;
        FullPath := GetFullPath;
        GoodsID := cxTree.FocusedNode.Texts[1];

        cmbHistoryFolders.Properties.Items.AddPair(FullPath, GoodsID);

        Result:=True;
     except on E:Exception do
        begin
             IBCTrUpdate.Rollback;
             ShowErrorDialog('Eroare','Nu pot modifica mapa parinte!',E.Message);
        end;
     end;
end;

procedure TfrmChangeParentFolderDlg.SaveStates;
begin
     AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     if (fDBTable = dbtGOODS) then
       AppUserConfigStorage.TextValues.SetValue('goodsChangeFolderHistory', cmbHistoryFolders.Properties.Items.Text);
end;

procedure TfrmChangeParentFolderDlg.SetDBTable(const Value: TDBTable);
begin
     fDBTable:=Value;
end;

procedure TfrmChangeParentFolderDlg.SetFolderObjectID(const Value: integer);
begin
     fFolderObjectID := Value;
end;

procedure TfrmChangeParentFolderDlg.AddObjectInfo(const ID: integer; const Title: String);
var obj:TIDItem;
begin
     obj:=TIDItem.Create(ID,Title);
     fList.Add(obj);
end;

procedure TfrmChangeParentFolderDlg.LoadHistoryFolders;
begin
  // din

end;

procedure TfrmChangeParentFolderDlg.SpeedButton1Click(Sender: TObject);
begin
   cxTree.FullExpand;
end;

{ TIDItem }

constructor TIDItem.Create(const ID: integer; const Title: String);
begin
     fID:=ID;
     fTitle:=Title;
end;

end.

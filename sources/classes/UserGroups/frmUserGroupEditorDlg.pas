unit frmUserGroupEditorDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  SWNBaseUnit, Menus, cxButtonEdit, ComCtrls, RzTreeVw,
  ExtCtrls, StdCtrls, DialogTitle, cxDBEdit,
  cxTextEdit, Buttons, cxCheckListBox,
  cxDBCheckListBox, System.Types, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxCheckBox, cxCustomListBox, cxMaskEdit, cxCustomData, cxStyles, dxScrollbarAnnotations, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, Vcl.WinXCtrls, dxUIAClasses;

type
  TfrmUserGroupDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pmAccess: TPopupMenu;
    miSelectAll: TMenuItem;
    miClearAll: TMenuItem;
    N3: TMenuItem;
    pnClient: TPanel;
    cxLabel1: TLabel;
    edDBGroupName: TcxDBTextEdit;
    cxLabel3: TLabel;
    edDBGroupID: TcxDBMaskEdit;
    miClearSelected: TMenuItem;
    miSetSelected: TMenuItem;
    pmUserGroups: TPopupMenu;
    pcPageControl: TPageControl;
    tbsActions: TTabSheet;
    tbsStructure: TTabSheet;
    Tree: TRzCheckTree;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    lbRightsCount: TLabel;
    GroupBoxTools: TGroupBox;
    Label2: TLabel;
    sbImportRights: TSpeedButton;
    clbStructure: TcxDBCheckListBox;
    tbsServicePlus: TTabSheet;
    cbFLG_SERVICE: TcxDBCheckBox;
    cbFLG_SERVICE_ENGINER: TcxDBCheckBox;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    SpeedButton1: TSpeedButton;
    cxLabel4: TLabel;
    SearchBox1: TSearchBox;
    procedure miSelectAllClick(Sender: TObject);
    procedure pmAccessPopup(Sender: TObject);
    procedure miSetSelectedClick(Sender: TObject);
    procedure miClearSelectedClick(Sender: TObject);
    procedure TreeStateChange(Sender: TObject; Node: TTreeNode; NewState: TRzCheckState);
    procedure sbImportRightsClick(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    fCurrSearchNode: TTreeNode;
    fSearchText: string;
    FCreateNewGroup: Boolean;
    fRightsCount: Integer;
    fRightsTotal: Integer;
    fTreeItemsUpdating: Boolean;
    procedure CreateRightsTree2;
    procedure ReadTreeLevel0;
    procedure ReadTreeLevel1(const ParentNode: TTreeNode; const ParentID: Integer);
    procedure ReadTreeLevel2(const ParentNode: TTreeNode; const ParentID: Integer);
    procedure ReadStructure;
    function GetNodeByParentID(const ParentID: Integer): TTreeNode;
    procedure SavePrivilegies(const GroupID: Integer);
    procedure SelectAllTree(const Selected: Boolean);
    function CheckParams: Boolean;
    function DoNextSearch: Boolean;
    function StartNewSearch(const TextToFind: string): Boolean;
    function SearchInNode(const StartingNode: TTreeNode): TTreeNode;
    procedure SelectSubNodes(const StartingNode: TTreeNode; const State: TRzCheckState);
    procedure SetCreateNewGroup(const Value: Boolean);
    procedure CalcSelectedActions;
    procedure DisplayStatistics;
    procedure CreateUserGroupsList;
    procedure ImportGroupRights(const GroupID: Integer);
    procedure WhenImportGroupClick(Sender: TObject);
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
    property CreateNewGroup: Boolean read FCreateNewGroup write SetCreateNewGroup;
  end;

implementation

uses
  SWNUtils, SWNConst,
  IBC, DataModuleDB, SWNSecurity, ufrmListOfUserGroupsDialog;

{$R *.dfm}

type
  PTreeItemData = ^TTreeItemData;

  TTreeItemData = record
    DocTypeID: Integer;
    ParentID: Integer;
    Mask: Int64;
    isAction: Boolean;
  end;

  { TfrmUserGroupDlg }

procedure TfrmUserGroupDlg.CalcSelectedActions;
var
  Node0, Node1, Node2: TTreeNode;
begin
  fRightsCount := 0;
  fRightsTotal := 0;

  Node0 := Tree.Items.GetFirstNode;
  while Node0 <> nil do
  begin
    // LEVEL 0
    Node1 := Node0.getFirstChild;
    while Node1 <> nil do
    begin
      // LEVEL 1
      if Node1.HasChildren then
      begin
        Node2 := Node1.getFirstChild;
        while Node2 <> nil do
        begin
          // LEVEL 2
          Inc(fRightsTotal);

          if TRzCheckState(Node2.StateIndex) = csChecked then
            Inc(fRightsCount);
          Node2 := Node2.getNextSibling;
        end;
      end
      else
      begin
        Inc(fRightsTotal);
        if TRzCheckState(Node1.StateIndex) = csChecked then
          Inc(fRightsCount);
      end;

      Node1 := Node1.getNextSibling;
    end;

    Node0 := Node0.getNextSibling;
  end;
end;

function TfrmUserGroupDlg.CheckParams: Boolean;
var
  ErrorStr: string;
  N: Integer;
begin
  Result := False;

  if (fMasterDataSet.FieldByName('GROUPID').IsNull) then
  begin
    N := fMasterDataSet.FieldByName('GROUPID').AsInteger;
    if (N < 1) or (N > 64) then
      AddErrorToStr(ErrorStr, 'Cod grup (1-64)!');
  end;
  if (fMasterDataSet.FieldByName('NAME').IsNull) or (Trim(fMasterDataSet.FieldByName('NAME').AsString) = '') then
    AddErrorToStr(ErrorStr, 'Nume grupa!');
  if ErrorStr = '' then
    Result := True
  else
    ShowErrorDialog(cMSG_GeneralInputError_Title, cMSG_GeneralInputError_Text, ErrorStr, 'Setarea drepturilor de acțiune pentru grup.');
end;

procedure TfrmUserGroupDlg.CreateRightsTree2;
var
  AGroupID, i: Integer;
  Data: PTreeItemData;
  Node: TTreeNode;
begin
  if fMasterDataSet.FieldByName('GROUPID').IsNull then
    AGroupID := -1
  else
    AGroupID := fMasterDataSet.FieldByName('GROUPID').AsInteger;

  Tree.Items.BeginUpdate;
  fTreeItemsUpdating := True;
  try
    // clear tree
    Tree.Items.Clear;

    // starting with level 0 and its subitems
    ReadTreeLevel0;

    // check items matching to selected GroupID
    if AGroupID > 0 then // only for existing group
    begin
      for i := 0 to Tree.Items.Count - 1 do
      begin
        Node := Tree.Items[i];
        Data := Node.Data;
        if ((Data^.Mask shr AGroupID) and 1) = 1 then
          Tree.ChangeNodeCheckState(Node, csChecked)
        else
          Tree.ChangeNodeCheckState(Node, csUnchecked);
      end;

      // expand partially checked items
      // for i := 0 to Tree.Items.Count - 1 do
      // if (Tree.ItemState[i]=csPartiallyChecked) then Tree.Items[i].Expanded:=True;
    end
    else
    begin
      // for new group, expand 2 levels only
      for i := 0 to Tree.Items.Count - 1 do
        Tree.Items[i].Expanded := (Tree.Items[i].Level <= 1);
    end;

    DisplayStatistics;

  finally
    Tree.Items.EndUpdate;
    fTreeItemsUpdating := False;
  end;
end;

procedure TfrmUserGroupDlg.CreateUserGroupsList;
var
  Query: TIBCQuery;
  M: TMenuItem;
  N: Integer;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := fMasterDataSet.Connection;
    Query.SQL.Add('SELECT GROUPID, NAME, (SELECT COUNT(DOCTYPEID) FROM (');
    Query.SQL.Add('SELECT DOCTYPEID, GET_FLG_VALUE(FLAGS,0) IS_ACTION');
    Query.SQL.Add('FROM TS_DOCTYPES WHERE (DOCTYPEID>=0) )');
    Query.SQL.Add('WHERE (IS_ACTION=1) AND (GROUPID<>:group)');
    Query.SQL.Add(') RIGHTS_COUNT');
    Query.SQL.Add('FROM TS_USER_GROUPS');
    Query.SQL.Add('ORDER BY 1');

    Query.ParamByName('group').AsInteger := fMasterDataSet.FieldByName('GROUPID').AsInteger;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      N := Query.Fields[2].AsInteger;
      if N > 0 then
      begin
        M := TMenuItem.Create(pmUserGroups);
        M.Caption := Format('%s', [Query.Fields[1].AsString]);
        M.Tag := Query.Fields[0].AsInteger;
        M.OnClick := WhenImportGroupClick;
        pmUserGroups.Items.Add(M);
      end;
      Query.Next;
    end;
    Query.Close;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserGroupDlg.DisplayStatistics;
begin
  CalcSelectedActions;
  lbRightsCount.Caption := Format('%d din %d', [fRightsCount, fRightsTotal]);
end;

function TfrmUserGroupDlg.DoNextSearch: Boolean;
var
  Node, tmpNode: TTreeNode;
  checkCurrNode: Boolean;
begin
  Result := False;
  if Tree.Items.Count > 0 then
  begin
    checkCurrNode := False;
    if fCurrSearchNode = nil then
    begin
      fCurrSearchNode := Tree.Items[0];
      checkCurrNode := True;
    end;

    if checkCurrNode then
      Node := fCurrSearchNode
    else
    begin
      // get next child or next sibling
      if fCurrSearchNode.HasChildren then
        Node := fCurrSearchNode.getFirstChild
      else
        Node := fCurrSearchNode.getNextSibling;
      if not Assigned(Node) then
      begin
        // try upper level -1
        tmpNode := fCurrSearchNode.Parent;
        if Assigned(tmpNode) then
        begin
          // next sibling of the parent
          Node := tmpNode.getNextSibling;
          if not Assigned(Node) then
          begin
            // try upper levvel -2
            Node := tmpNode.Parent;
            Node := Node.getNextSibling;
          end;
        end;
      end;
    end;

    if Assigned(Node) then
      repeat
        // search in all sub children
        fCurrSearchNode := SearchInNode(Node);

        if Assigned(fCurrSearchNode) then
          break
        else
        begin
          // try next sibling
          tmpNode := Node.getNextSibling;
          if Assigned(tmpNode) then
            Node := tmpNode
          else
          begin
            // go up level -1
            tmpNode := Node.Parent;
            if Assigned(tmpNode) then
            begin
              Node := tmpNode.getNextSibling;
              if not Assigned(Node) then
              begin
                // go up level -2
                Node := tmpNode.Parent;
                Node := Node.getNextSibling;
              end;
            end
            else
              Node := nil;
          end;
        end;

      until not Assigned(Node)
    else
      fCurrSearchNode := nil;

    if Assigned(fCurrSearchNode) then
    begin
      Tree.Select(fCurrSearchNode, []);
      fCurrSearchNode.MakeVisible;
      fCurrSearchNode.Selected := True;
      Result := True;
    end;
  end;
end;

function TfrmUserGroupDlg.GetNodeByParentID(const ParentID: Integer): TTreeNode;
var
  Node: TTreeNode;
  Data: PTreeItemData;
begin
  Result := nil;
  Node := Tree.Items.GetFirstNode;
  while Node <> nil do
  begin
    Data := PTreeItemData(Node.Data);
    if (Data^.DocTypeID = ParentID) then
    begin
      Result := Node;
      break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TfrmUserGroupDlg.ImportGroupRights(const GroupID: Integer);
var
  Query: TIBCQuery;
  Data: PTreeItemData;
  DocTypeID, i: Integer;
  Node: TTreeNode;
begin
  Tree.Items.BeginUpdate;
  Query := TIBCQuery.Create(Self);
  try
    // clear current checks
    Tree.SetAllNodes(csUnchecked);

    Query.Connection := fMasterDataSet.Connection;
    Query.SQL.Add('SELECT DOCTYPEID FROM TS_DOCTYPES');
    Query.SQL.Add('WHERE (DOCTYPEID>=0) AND (GET_FLG_VALUE(ACC$FOLDERS,:group)=1)');

    Query.ParamByName('group').AsInteger := GroupID;
    Query.ExecSQL;
    // Update: Obtinem numai actiunele
    while not Query.Eof do
    begin
      DocTypeID := Query.Fields[0].AsInteger;

      for i := 0 to Tree.Items.Count - 1 do
      begin
        Node := Tree.Items[i];
        Data := PTreeItemData(Node.Data);
        if (Data^.DocTypeID = DocTypeID) and (not Node.HasChildren) then
          Tree.ChangeNodeCheckState(Node, csChecked);
      end;
      Query.Next;
    end;

  finally
    Query.Free;
    Tree.FullCollapse;
    Tree.Items.EndUpdate;
  end;
end;

procedure TfrmUserGroupDlg.BindingDataSource;
begin
  inherited;
  FCreateNewGroup := False;
  fCurrSearchNode := nil;
  edDBGroupName.DataBinding.DataSource := fMasterDataSource;
  edDBGroupID.DataBinding.DataSource := fMasterDataSource;
  clbStructure.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SERVICE.DataBinding.DataSource := fMasterDataSource;
  cbFLG_SERVICE_ENGINER.DataBinding.DataSource := fMasterDataSource;

  fTreeItemsUpdating := False;
  fRightsCount := 0;
  fRightsTotal := 0;
end;

function TfrmUserGroupDlg.IsFormDataPosted: Boolean;
begin
  if CheckParams then
  begin
    fMasterDataSet.Post;
    SavePrivilegies(fMasterDataSet.FieldByName('GROUPID').AsInteger);
    fMasterDataSet.UpdateTransaction.Commit;

    Result := True;
  end
  else
    Result := False;
end;

procedure TfrmUserGroupDlg.miClearSelectedClick(Sender: TObject);
begin
  Tree.ChangeNodeCheckState(Tree.Selected, csUnchecked);
end;

procedure TfrmUserGroupDlg.miSelectAllClick(Sender: TObject);
begin
  SelectAllTree(Sender = miSelectAll);
end;

procedure TfrmUserGroupDlg.miSetSelectedClick(Sender: TObject);
begin
  Tree.ChangeNodeCheckState(Tree.Selected, csChecked);
end;

procedure TfrmUserGroupDlg.pmAccessPopup(Sender: TObject);
begin
  miClearSelected.Enabled := Assigned(Tree.Selected) and (Tree.Selected.Level < 2);
  if miClearSelected.Enabled then
    miClearSelected.Caption := 'Ștergeți totul "' + Tree.Selected.Text + '"'
  else
    miClearSelected.Caption := 'Stergeti';

  miSetSelected.Enabled := Assigned(Tree.Selected) and (Tree.Selected.Level < 2);
  if miSetSelected.Enabled then
  begin
    miSetSelected.Caption := 'Alegeți toate dintre"' + Tree.Selected.Text + '"';
    miSetSelected.ImageIndex := Tree.Selected.ImageIndex;
  end
  else
  begin
    miSetSelected.Caption := 'Alegeti';
    miSetSelected.ImageIndex := -1;
  end;
end;

procedure TfrmUserGroupDlg.Prepare;
begin
  pcPageControl.ActivePage := tbsActions;

  fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if FCreateNewGroup then
    begin
      fMasterDataSet.Insert;
      fMasterDataSet.FieldByName('FLG_SERVICE').AsInteger := 0;
      fMasterDataSet.FieldByName('FLG_SERVICE_ENGINER').AsInteger := 0;
      fMasterDataSet.FieldByName('STRUCTURE_MASK').AsINteger := 0;
    end
    else
    begin
      fMasterDataSet.Edit;
      if fMasterDataSet.FieldByName('GROUPID').AsInteger = 1 then
        edDBGroupID.Enabled := False;
    end;
    CreateRightsTree2;
    CreateUserGroupsList;
    ReadStructure;
  except
    fMasterDataSet.Cancel;
    fMasterDataSet.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TfrmUserGroupDlg.ReadStructure;
var
  Query: TIBCQuery;
  // N:integer;
  // Mask:integer;
  item: TcxCheckListBoxItem;
begin
  // Mask:=fMasterDataSet.FieldByName('STRUCTURE_MASK').AsInteger;
  clbStructure.Items.BeginUpdate;

  // add default item
  item := clbStructure.Items.Add;
  item.Enabled := False;
  item.Text := 'Reserved';

  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'SELECT STRUCTUREID, TITLE FROM TS_STRUCTURE ORDER BY 1';
    Query.ExecSQL;
    while not Query.Eof do
    begin
      // N:=Query.Fields[0].AsInteger;
      item := clbStructure.Items.Add;
      item.Text := Query.Fields[1].AsString;

      Query.Next;
    end;
  finally
    Query.Free;
    clbStructure.Items.EndUpdate;
  end;
end;

procedure TfrmUserGroupDlg.ReadTreeLevel0;
var
  Query: TIBCQuery;
  Node: TTreeNode;
  Data: PTreeItemData;
  FLG_ACCESS_VISIBLE: Boolean;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT DOCTYPEID, TITLE, ACC$FOLDERS, FLG_ACCESS_VISIBLE');
    Query.SQL.Add('FROM VW_TS_DOCTYPES');
    Query.SQL.Add('WHERE (DOCTYPEID>=0) AND (PARENTID=0) AND (FLG_ACTION=0)');

    // ascundem elementele invisibile
    if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');
    Query.ExecSQL;
    while not Query.Eof do
    begin
      FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;

      New(Data);
      Data^.DocTypeID := Query.FieldByName('DOCTYPEID').AsInteger;
      Data^.ParentID := 0;
      Data^.Mask := Query.FieldByName('ACC$FOLDERS').Value; // AsInt64;
      Data^.isAction := False;

      Node := Tree.Items.AddChild(nil, Query.FieldByName('TITLE').AsString);
      Node.Data := Data;
      if FLG_ACCESS_VISIBLE then
      begin
        Node.ImageIndex := 14;
        Node.SelectedIndex := 14;
      end
      else
      begin
        Node.ImageIndex := 65;
        Node.SelectedIndex := 65;
      end;

      ReadTreeLevel1(Node, Data^.DocTypeID);

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserGroupDlg.ReadTreeLevel1(const ParentNode: TTreeNode; const ParentID: Integer);
var
  Query: TIBCQuery;
  Node: TTreeNode;
  Data: PTreeItemData;
  FLG_ACCESS_VISIBLE: Boolean;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT DOCTYPEID, TITLE, ACC$FOLDERS, FLG_ACCESS_VISIBLE');
    Query.SQL.Add('FROM VW_TS_DOCTYPES');
    Query.SQL.Add('WHERE (DOCTYPEID>=0) AND (PARENTID=:id) AND (FLG_ACTION=0)');

    // ascundem elementele invisibile
    if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');
    Query.ParamByName('id').AsInteger := ParentID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;

      New(Data);
      Data^.DocTypeID := Query.FieldByName('DOCTYPEID').AsInteger;
      Data^.ParentID := ParentID;
      Data^.Mask := Query.FieldByName('ACC$FOLDERS').Value; // AsInt64;
      Data^.isAction := False;

      Node := Tree.Items.AddChild(ParentNode, Query.FieldByName('TITLE').AsString);
      Node.Data := Data;
      if FLG_ACCESS_VISIBLE then
      begin
        Node.ImageIndex := 16;
        Node.SelectedIndex := 16;
      end
      else
      begin
        Node.ImageIndex := 66;
        Node.SelectedIndex := 66;
      end;

      ReadTreeLevel2(Node, Data^.DocTypeID);

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserGroupDlg.ReadTreeLevel2(const ParentNode: TTreeNode; const ParentID: Integer);
var
  Query: TIBCQuery;
  Node: TTreeNode;
  Data: PTreeItemData;
  FLG_ACCESS_VISIBLE: Boolean;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Add('SELECT DOCTYPEID, TITLE, ACC$FOLDERS, FLG_ACCESS_VISIBLE');
    Query.SQL.Add('FROM VW_TS_DOCTYPES');
    Query.SQL.Add('WHERE (DOCTYPEID>=0) AND (PARENTID=:id) AND (FLG_ACTION=1)');

    // ascundem elementele invisibile
    if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');
    Query.ParamByName('id').AsInteger := ParentID;
    Query.ExecSQL;
    while not Query.Eof do
    begin
      FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;

      New(Data);
      Data^.DocTypeID := Query.FieldByName('DOCTYPEID').AsInteger;
      Data^.ParentID := ParentID;
      Data^.Mask := Query.FieldByName('ACC$FOLDERS').Value; // AsInt64;
      Data^.isAction := True;

      Node := Tree.Items.AddChild(ParentNode, Query.FieldByName('TITLE').AsString);
      Node.Data := Data;
      if FLG_ACCESS_VISIBLE then
      begin
        Node.ImageIndex := 17;
        Node.SelectedIndex := 17;
      end
      else
      begin
        Node.ImageIndex := 67;
        Node.SelectedIndex := 67;
      end;

      Inc(fRightsTotal);

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmUserGroupDlg.SavePrivilegies(const GroupID: Integer);
var
  Query: TIBCQuery;
  i: Integer;
  Checked: Boolean;
  CheckState: TRzCheckState;
  Data: PTreeItemData;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := fMasterDataSet.Connection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Text := 'UPDATE TS_DOCTYPES SET ACC$FOLDERS=SET_FLG_VALUE_BG(ACC$FOLDERS,:bitIndex,:bitValue) WHERE (DOCTYPEID=:id)';
    Query.ParamByName('bitIndex').AsInteger := GroupID;

    for i := 0 to Tree.Items.Count - 1 do
    begin
      Data := PTreeItemData(Tree.Items[i].Data);
      CheckState := Tree.ItemState[i];
      Checked := (CheckState = csChecked) or (CheckState = csPartiallyChecked);

      Query.ParamByName('bitValue').AsInteger := Ord(Checked);
      Query.ParamByName('id').AsInteger := Data^.DocTypeID;

      Query.ExecSQL;
    end;
// -------------

  finally
    Query.Free;
  end;
end;

procedure TfrmUserGroupDlg.sbImportRightsClick(Sender: TObject);
var
  P: TPoint;
begin
  P := Point(pnClient.Left + GroupBoxTools.Left + sbImportRights.Left + sbImportRights.Width + 4, pnClient.Top + GroupBoxTools.Top + sbImportRights.Top);
  P := ClientToScreen(P);
  pmUserGroups.Popup(P.X, P.Y);
end;

procedure TfrmUserGroupDlg.SearchBox1InvokeSearch(Sender: TObject);
var
  Result: Boolean;
begin
  if Assigned(fCurrSearchNode) and (SearchBox1.Text = fSearchText) then
    Result := DoNextSearch
  else
  begin
    if Trim(SearchBox1.Text) <> '' then
    begin
      Result := StartNewSearch(SearchBox1.Text);
//      if Result then
//        beSearch.Properties.LookupItems.Add(fSearchText);
    end
    else
    begin
      ShowErrorDialog('Eroare', 'Pentru a căuta, tastați textul!');
      Result := True;
    end;
  end;

  if not Result then
    ShowInfoDialog('Căutarea s-a terminat.', 'Textul "' + fSearchText + '" nu se mai găsește în arborele de acțiune.');
end;

function TfrmUserGroupDlg.SearchInNode(const StartingNode: TTreeNode): TTreeNode;
var
  S: string;
  Node: TTreeNode;
begin
  Result := Nil;
  Node := StartingNode;
  while Node <> nil do
  begin
    S := WideLowerCase(Node.Text);
    if Pos(fSearchText, S) >= 1 then
    begin
      Result := Node;
      break;
    end
    else if Node.HasChildren then
    begin
      Result := SearchInNode(Node.getFirstChild);
      if Assigned(Result) then
        break;
    end;
    Node := Node.getNextSibling;
  end;
end;

procedure TfrmUserGroupDlg.SelectAllTree(const Selected: Boolean);
var
  Node: TTreeNode;
begin
  Tree.Items.BeginUpdate;
  try
    if Selected then
      Tree.SetAllNodes(csChecked)
    else
      Tree.SetAllNodes(csUnchecked);

    // collapse whole tree
    Node := Tree.Items.GetFirstNode;
    while (Node <> nil) do
    begin
      Node.Expanded := False;
      Node := Node.getNextSibling;
    end;
  finally
    Tree.Items.EndUpdate;
  end;

  DisplayStatistics;
end;

procedure TfrmUserGroupDlg.SelectSubNodes(const StartingNode: TTreeNode; const State: TRzCheckState);
var
  Node: TTreeNode;
begin
  Node := StartingNode;
  while Node <> nil do
  begin
    Tree.ChangeNodeCheckState(Node, State);
    if Node.HasChildren then
      SelectSubNodes(Node.getFirstChild, State);
    Node := Node.getNextSibling;
  end;
end;

procedure TfrmUserGroupDlg.SetCreateNewGroup(const Value: Boolean);
begin
  FCreateNewGroup := Value;
end;

procedure TfrmUserGroupDlg.SetupSecurityItems;
begin
  if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
  begin
    tbsServicePlus.TabVisible := False;
  end;
end;

procedure TfrmUserGroupDlg.SpeedButton1Click(Sender: TObject);
var
    dialog: TfrmListOfUserGroupsDialog;
    Data: PTreeItemData;
begin
    dialog := TfrmListOfUserGroupsDialog.Create(self, dmdb.IBCConnection);
    try
        Data := PTreeItemData(Tree.Items[Tree.Selected.Index].Data);
//        dialog.DialogTitle1.Text := 'DOCTYPEID:'+IntToStr(Data^.DocTypeID) +', mask:'+ IntToStr(Data^.Mask);
        dialog.SecurityFlagValue := Data^.Mask;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

function TfrmUserGroupDlg.StartNewSearch(const TextToFind: string): Boolean;
begin
  fSearchText := LowerCase(TextToFind);
  fCurrSearchNode := nil;
  Result := DoNextSearch;
end;

procedure TfrmUserGroupDlg.TreeStateChange(Sender: TObject; Node: TTreeNode; NewState: TRzCheckState);
begin
  if (not fTreeItemsUpdating) then
    DisplayStatistics;
end;

procedure TfrmUserGroupDlg.WhenCancelForm;
begin
  fMasterDataSet.Cancel;
  fMasterDataSet.UpdateTransaction.Rollback;
end;

procedure TfrmUserGroupDlg.WhenImportGroupClick(Sender: TObject);
var
  GroupID: Integer;
  title: string;
begin
  title := TMenuItem(Sender).Caption;
  GroupID := TMenuItem(Sender).Tag;
  if ShowAskDialog('Clonare drepturi', 'Copie drepturile din grupa "' + title + '"?') = mrYes then
  begin
    ImportGroupRights(GroupID);
    DisplayStatistics;
  end;
end;

end.


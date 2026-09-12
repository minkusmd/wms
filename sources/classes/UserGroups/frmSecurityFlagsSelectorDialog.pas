unit frmSecurityFlagsSelectorDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, Menus, cxLookAndFeelPainters, cxButtonEdit,
  ComCtrls, RzTreeVw, ExtCtrls, StdCtrls, DialogTitle, cxMaskEdit, cxDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxGraphics, cxLookAndFeels, Buttons, cxCheckListBox, cxDBCheckListBox, SWNClasses;

type
  TfrmSecurityFlagsSelectorDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    btnCancel: TButton;
    btnOk: TButton;
    pmAccess: TPopupMenu;
    miSelectAll: TMenuItem;
    miClearAll: TMenuItem;
    N3: TMenuItem;
    miClearSelected: TMenuItem;
    miSetSelected: TMenuItem;
    pnClient: TPanel;
    Tree: TRzCheckTree;
    rbSetValue: TRadioButton;
    rbClearValue: TRadioButton;
    Label1: TLabel;
    procedure miClearSelectedClick(Sender: TObject);
  private
    { Private declarations }
    procedure CreateRightsTree2;
    procedure ReadTreeLevel0;
    procedure ReadTreeLevel1(const ParentNode: TTreeNode; const ParentID: integer);
    procedure ReadTreeLevel2(const ParentNode: TTreeNode; const ParentID: integer);

    function ExistCheckedItems: Boolean;

    procedure SelectSubNodes(const StartingNode: TTreeNode; const State: TRzCheckState);

    function HasChoise: Boolean;

    function DoSave: Boolean;
    function DoSaveDB: Boolean;
  protected
    { Protected declarations }
    procedure Prepare; override;

    function IsFormDataPosted: Boolean; override;
  public
    { Public declarations }
  end;

implementation

Uses SWNSecurityUtils, SWNUtils, DataModuleAdditions, SWNConst, SWNSecurityFlags,
  IBC, DataModuleDB, SWNDBErrors, SWNSecurity;

{$R *.dfm}

type

  PTreeItemData = ^TTreeItemData;

  TTreeItemData = record
    DocTypeID: integer;
    ParentID: integer;
    Mask: Int64;
    isAction: Boolean;
  end;

  { TfrmUserGroupDlg }

procedure TfrmSecurityFlagsSelectorDlg.CreateRightsTree2;
begin
  Tree.Items.BeginUpdate;
  try
    // clear tree
    Tree.Items.Clear;
    // starting with level 0 and its subitems
    ReadTreeLevel0;
  finally
    Tree.Items.EndUpdate;
  end;
end;

function TfrmSecurityFlagsSelectorDlg.DoSave: Boolean;
begin
  Result := False;
  if rbSetValue.Checked then
  begin
    if ShowAskDialog('Setare flag-uri pentru toate grupurile de utilizatori', 'Doriti sa setati flag-urile selectate pentru toate grupurile de utilizatori?',
      'Vor fi afectate toate grupurile') = mrYes then
      Result := DoSaveDB;
  end
  else if rbClearValue.Checked then
  begin
    if ShowAskDialog('Stergere flag-uri din toate grupurile de utilizatori', 'Doriti sa eliminati flag-urile selectate din toate grupurile de utilizatori?',
      'Vor fi afectate toate grupurile') = mrYes then
      Result := DoSaveDB;
  end;
end;

function TfrmSecurityFlagsSelectorDlg.DoSaveDB: Boolean;
var
  Query: TIBCQuery;
  IDList: TIntegerList;
  i, j: integer;
  Data: PTreeItemData;
  CheckState: TRzCheckState;
begin
  Result := False;

  IDList := TIntegerList.Create;
  try
    // 1. get list of all user groups
    Query := TIBCQuery.Create(Self);
    try
      Query.Connection := fMasterDataSet.Connection;
      Query.SQL.Text := 'SELECT GROUPID FROM TS_USER_GROUPS';
      Query.ExecSQL;
      while Not Query.Eof do
      begin
        IDList.Add(Query.Fields[0].AsInteger);
        Query.Next;
      end;
    finally
      Query.Free;
    end;

    // 2. update in all groups
    Query := TIBCQuery.Create(Self);
    try
      Query.AutoCommit := False;
      Query.Connection := fMasterDataSet.Connection;
      Query.Transaction := fMasterDataSet.UpdateTransaction;
      Query.SQL.Text := 'UPDATE TS_DOCTYPES SET ACC$FOLDERS=SET_FLG_VALUE_BG(ACC$FOLDERS,:bitIndex,:bitValue) WHERE (DOCTYPEID=:id)';

      Query.Transaction.StartTransaction;
      try
        // iterate through each group
        for i := 0 to IDList.Count - 1 do
        begin
          Query.ParamByName('bitIndex').AsInteger := IDList[i];

          // and setup flags for it
          for j := 0 to Tree.Items.Count - 1 do
          begin
            Data := PTreeItemData(Tree.Items[j].Data);
            CheckState := Tree.ItemState[j];
            if (CheckState = csChecked) or (CheckState = csPartiallyChecked) then
            begin
              // for selected items only
              Query.ParamByName('bitValue').AsInteger := Ord(rbSetValue.Checked);
              Query.ParamByName('id').AsInteger := Data^.DocTypeID;

              Query.ExecSQL;
            end;
          end;
        end;

        // done
        Query.Transaction.Commit;
        Result := True;

      except
        on E: Exception do
        begin
          Query.Transaction.Rollback;
          if Not ProcessSWNError(E) then
            raise;
        end;
      end;
    finally
      Query.Free;
    end;
  finally
    IDList.Free;
  end;
end;

function TfrmSecurityFlagsSelectorDlg.ExistCheckedItems: Boolean;
var
  i: integer;
  CheckState: TRzCheckState;
begin
  Result := False;
  for i := 0 to Tree.Items.Count - 1 do
  begin
    CheckState := Tree.ItemState[i];
    if (CheckState = csChecked) or (CheckState = csPartiallyChecked) then
    begin
      Result := True;
      break;
    end;
  end
end;

function TfrmSecurityFlagsSelectorDlg.HasChoise: Boolean;
begin
  Result := False;
  if rbSetValue.Checked or rbClearValue.Checked then
    Result := True
  else
    ShowErrorDialog('Eroare', 'Selectati tipul operatiei: setare sau stergere flag-uri.');
end;

function TfrmSecurityFlagsSelectorDlg.IsFormDataPosted: Boolean;
begin
  Result := ExistCheckedItems and HasChoise and DoSave;
end;

procedure TfrmSecurityFlagsSelectorDlg.miClearSelectedClick(Sender: TObject);
begin
  Tree.ChangeNodeCheckState(Tree.Selected, csUnchecked);
end;

procedure TfrmSecurityFlagsSelectorDlg.Prepare;
begin
  CreateRightsTree2;
end;

procedure TfrmSecurityFlagsSelectorDlg.ReadTreeLevel0;
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
    if Not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');
    Query.ExecSQL;
    while Not Query.Eof do
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

procedure TfrmSecurityFlagsSelectorDlg.ReadTreeLevel1(const ParentNode: TTreeNode; const ParentID: integer);
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
    if Not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');

    Query.ParamByName('id').AsInteger := ParentID;
    Query.ExecSQL;
    while Not Query.Eof do
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

procedure TfrmSecurityFlagsSelectorDlg.ReadTreeLevel2(const ParentNode: TTreeNode; const ParentID: integer);
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
    if Not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
      Query.SQL.Add('AND (FLG_ACCESS_VISIBLE=1)');

    Query.SQL.Add('ORDER BY ORDERNO');
    Query.ParamByName('id').AsInteger := ParentID;
    Query.ExecSQL;
    while Not Query.Eof do
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

      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmSecurityFlagsSelectorDlg.SelectSubNodes(const StartingNode: TTreeNode; const State: TRzCheckState);
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

end.

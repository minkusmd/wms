unit frmDocTypesEditorBrowser;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, IBC, Dialogs,
    DialogTitle, cxGraphics, cxTL, cxCheckComboBox,
    cxImageComboBox, Menus, cxLookAndFeelPainters, dxBar, StdCtrls, cxButtons, cxInplaceContainer,
    cxControls, cxCheckBox, cxCheckListBox, cxLookAndFeels, cxCustomData, cxStyles, dxScrollbarAnnotations, cxLabel,
  cxTextEdit, cxTLdxBarBuiltInMenu, cxClasses, cxMaskEdit, cxFilter;

type
    TfrmDocTypesEditorDlg = class(TSWNCustomForm)
        dtDialogTitle: TDialogTitle;
        dxBarManager: TdxBarManager;
        dxBarManagerBar1: TdxBar;
        bbSecNewArea: TdxBarButton;
        bbSecNewItem: TdxBarButton;
        bbSecNewAction: TdxBarButton;
        bbSecDelete: TdxBarButton;
        bbSecModify: TdxBarButton;
        dxBarDockControl3: TdxBarDockControl;
        cxTreeActions: TcxTreeList;
        cxTreeActionscxTreeListColumn1: TcxTreeListColumn;
        btnOk: TcxButton;
        btnCancel: TcxButton;
        pmActions: TdxBarPopupMenu;
        bbCreateDDL: TdxBarButton;
        bbSubAdditional: TdxBarSubItem;
        dxBarButton1: TdxBarButton;
        dxBarButton2: TdxBarButton;
        cxTreeActionscxTreeListColumn2: TcxTreeListColumn;
        cxTreeActionscxTreeListColumn3: TcxTreeListColumn;
        cxTreeActions_IMAGEINDEX: TcxTreeListColumn;
        cxTreeActions_STRUCTMASK: TcxTreeListColumn;
        bbNewIDs: TdxBarButton;
        bbMoveUp: TdxBarButton;
        bbMoveDown: TdxBarButton;
        bbExportDocTypes: TdxBarButton;
        cxTreeActions_FLG_MONEY: TcxTreeListColumn;
        cxTreeActions_FLG_INVOICE: TcxTreeListColumn;
        cxTreeActions_FLG_DEBTS: TcxTreeListColumn;
        cxTreeActions_FLG_SIGN: TcxTreeListColumn;
        cxTreeActions_FLG_TRANSFER: TcxTreeListColumn;
        cxTreeActions_FLG_ACNT_INVOICE: TcxTreeListColumn;
        bbDocAnalytics: TdxBarButton;
        bbDocDefaults: TdxBarButton;
        cxTreeActions_FLG_SERVICE_QTY: TcxTreeListColumn;
        cxTreeActions_FLG_ASSEMBLE: TcxTreeListColumn;
        cxTreeActions_FLG_ACHITARI: TcxTreeListColumn;
        cxTreeActions_FLG_ACCESS_VISIBLE: TcxTreeListColumn;
        dxBarSubItem1: TdxBarSubItem;
        bbDocumentStates: TdxBarButton;
        cxTreeActions_FLG_URP_UCET: TcxTreeListColumn;
        cxTreeActions_FLG_BUH_UCET: TcxTreeListColumn;
        dxBarButton3: TdxBarButton;
        procedure bbSecModifyClick(Sender: TObject);
        procedure bbSecDeleteClick(Sender: TObject);
        procedure bbSecNewAreaClick(Sender: TObject);
        procedure bbSecNewItemClick(Sender: TObject);
        procedure bbSecNewActionClick(Sender: TObject);
        procedure btnOkClick(Sender: TObject);
        procedure dxBarButton1Click(Sender: TObject);
        procedure dxBarButton2Click(Sender: TObject);
        procedure cxTreeActions_STRUCTMASKGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure cxTreeActionscxTreeListColumn3GetDisplayText(Sender: TcxTreeListColumn; ANode:
            TcxTreeListNode; var Value: string);
        procedure cxTreeActionscxTreeListColumn5PropertiesStatesToEditValue(Sender: TObject; const
            ACheckStates: TcxCheckStates; out AValue: Variant);
        procedure cxTreeActionscxTreeListColumn5PropertiesEditValueToStates(Sender: TObject; const AValue:
            Variant; var ACheckStates: TcxCheckStates);
        procedure bbMoveUpClick(Sender: TObject);
        procedure bbMoveDownClick(Sender: TObject);
        procedure bbExportDocTypesClick(Sender: TObject);
        procedure cxTreeActionscxTreeListColumn1GetDisplayText(Sender: TcxTreeListColumn; ANode:
            TcxTreeListNode; var Value: string);
        procedure cxTreeActions_FLG_MONEYGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var
            Value: string);
        procedure cxTreeActions_FLG_DEBTSGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var
            Value: string);
        procedure cxTreeActions_FLG_INVOICEGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure cxTreeActions_FLG_TRANSFERGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure cxTreeActions_FLG_SIGNGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode; var
            Value: string);
        procedure cxTreeActionsDblClick(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure cxTreeActions_FLG_ACNT_INVOICEGetDisplayText(Sender: TcxTreeListColumn; ANode:
            TcxTreeListNode; var Value: string);
        procedure cxTreeActionsDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
        procedure cxTreeActionsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
        procedure cxTreeActionsFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode:
            TcxTreeListNode);
        procedure cxTreeActionsMoveTo(Sender: TcxCustomTreeList; AttachNode: TcxTreeListNode; AttachMode:
            TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean);
        procedure cxTreeActionsCustomDrawDataCell(Sender: TcxCustomTreeList; ACanvas: TcxCanvas; AViewInfo:
            TcxTreeListEditCellViewInfo; var ADone: Boolean);
        procedure bbDocAnalyticsClick(Sender: TObject);
        procedure bbDocDefaultsClick(Sender: TObject);
        procedure cxTreeActions_FLG_SERVICE_QTYGetDisplayText(Sender: TcxTreeListColumn; ANode:
            TcxTreeListNode; var Value: string);
        procedure cxTreeActions_FLG_ASSEMBLEGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure cxTreeActions_FLG_ACHITARIGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure bbDocumentStatesClick(Sender: TObject);
        procedure cxTreeActionsDragDrop(Sender, Source: TObject; X, Y: Integer);
        procedure cxTreeActions_FLG_BUH_UCETGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure cxTreeActions_FLG_URP_UCETGetDisplayText(Sender: TcxTreeListColumn; ANode: TcxTreeListNode;
            var Value: string);
        procedure dxBarButton3Click(Sender: TObject);
    private
    { Private declarations }
        fDeletedItems: TList;
        fManualDelete: Boolean;
        fAutoDeleteNodes: Boolean;
        fChanged: Boolean;
        procedure ClearDeletedItems;
        procedure LoadDocStrutures;
        procedure CreateImageList;
        procedure ScanActionsTree;
        procedure ReadLevel0Items;
        procedure ReadLevel1Items(const ParentID: Integer; const ParentNode: TcxTreeListNode);
        procedure ReadLevel2Items(const ParentID: Integer; const ParentNode: TcxTreeListNode);
        procedure SelectedActionChanged;
        procedure SelectedFilterVisibility;
        procedure CreateAction(const ParentNode: TcxTreeListNode; const Title: WideString);
        procedure SaveActionTreeAsNew;
        procedure ScanTreeLevelForSaveAs(const Query: TIBCQuery; const Level: Integer);
        procedure SaveActionTreeAsAppend;
        procedure CreateConstList;
        function GetWordsFirstLetters(const Phrase: WideString): WideString;
        function RemoveBadChars(const Text: string): string;
        function CreateNormalIdentifer(const Text: WideString): WideString;
        function CreateLevel1Identifer(const Level0, Level1: WideString): WideString;
        function CreateLevel2Identifer(const Level0, Level1, Level2: WideString): WideString;
        procedure CreateSimpleTreeList;
        procedure MoveSelectedItemUp;
        procedure MoveSelectedItemDown;
        function GetNextTabSheetIndex: Integer;
        procedure ApplyStructMaskToChildren(const Node: TcxTreeListNode);
        procedure CreateDocTypesList;
        procedure GetStructureItemsForArea(const CheckListBox: TcxCheckListBox);
        procedure GetStructureItemsForElement(const Node: TcxTreeListNode; const CheckListBox: TcxCheckListBox);
        procedure CreateNewArea(const Title: string; const ImageIndex, StructMask: Integer; const
            AccessVisible: Boolean);
        procedure CreateNewElement(const ParentNode: TcxTreeListNode; const Title, ShortName: string; const
            StructMask, FrameIndex, ImageIndex: Integer; const FLG_MONEY, FLG_DEBTS, FLG_INVOICE, FLG_SIGN,
            FLG_TRANSFER, FLG_ACNT_INVOICE, FLG_SERVICE_QTY, FLG_ASSEMBLE, FLG_ACHITARI, FLG_DBL_JURNAL,
            FLG_ACCESS_VISIBLE, FLG_UPR_UCET, FLG_BUH_UCET: Boolean; const CreateDefaultActions: Boolean);
        procedure CreateNewAction(const ParentNode: TcxTreeListNode; const Title: string; const
            FLG_ACCESS_VISIBLE: Boolean);
        procedure DoShowUserGroupRights(Node: TcxTreeListNode);
        procedure ShowAreaEditorDialog(const Node: TcxTreeListNode);
        procedure ShowElementEditorDialog(const ParentNode, Node: TcxTreeListNode);
        procedure ShowActionEditorDialog(const ParentNode, Node: TcxTreeListNode);
        procedure SaveData;
        procedure ShowDocumentDefaultsDialog(const DocTypeID: Integer; const DocTypeTitle: string);
        procedure ReComputeOrderNo;
    protected
    { protected declarations }
        procedure Prepare; override;
        procedure SetupSecurityItems; override;
    public
    { Public declarations }
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        procedure EditDocTypes;
    end;

implementation

uses
    DataModuleAdditions, DataModuleDB, frmDocTypesRegionEditorDialog, frmDocTypesElementEditorDialog,
    frmDocTypesActionEditorDialog, SWNUtils, SWNSecurityFlags, SWNSecurity, frmDocTypeAnalyticsDialog,
    frmDocTypeDefaultsDialog, ShellAPI, frmDocTypesViewCodeUnit, frmDocTypeStatesDialog,
    ufrmListOfUserGroupsDialog;

{$R *.dfm}

const
    cHeaderText = #9 + '// Security flags from TS_ACC$RIGHTS. Extract date: %s';
    cHeaderDelimiter = #9 + '//-------------------------------------------------------------------';
    cFooter = #9 + '//--- End of security flags -----------------------------------------';
    cMaskLevel1 = '%s_%s';
    cMaskLevel2 = '%s_%s_%s';
    cComments0 = #9 + '// %s';
    cComments1 = #9 + #9 + '// %s';
    cConstMask0 = #9 + 'cSecurityFlag_%s = %d;';
    cConstMask1 = #9 + 'cSecurityFlag_%s = %d;';
    cConstMask2 = #9 + 'cSecurityFlag_%s = %d;' + #9 + #9 + '// %s';

type
    PActionItem = ^TActionItem;

    TActionItem = record
        ID: Integer;
        ParentID: Integer;
        StructMask: int64;
        Title: string;
        ShortName: WideString;
        IsAction: Boolean;
        TabSheetIndex: Integer;
        ImageIndex: Integer;
        AccFolders: int64;
    // new fields
        FLG_MONEY: Boolean;
        FLG_DEBTS: Boolean;
        FLG_INVOICE: Boolean;
        FLG_SIGN: Boolean;
        FLG_TRANSFER: Boolean;
        FLG_ACNT_INVOICE: Boolean;
        FLG_SERVICE_QTY: Boolean;
        FLG_ASSEMBLE: Boolean;
        FLG_ACHITARI: Boolean;
        FLG_DBL_JURNAL: Boolean;
        OrderNo: Integer;
        FLG_ACCESS_VISIBLE: Boolean;
        FLG_UPR_UCET: boolean;
        FLG_BUH_UCET: Boolean;
        HasModified: Boolean;
    end;

  { TfrmActionEditorDialog }

procedure TfrmDocTypesEditorDlg.ApplyStructMaskToChildren(const Node: TcxTreeListNode);
var
    i, j: Integer;
    NodeCh, NodeCh2: TcxTreeListNode;
    mask: int64;
    newmask: int64;
begin
    mask := Node.Values[1];
    for i := 0 to Node.Count - 1 do
    begin
        NodeCh := Node.Items[i];
        if NodeCh.Values[1] = 0 then
            newmask := mask
        else
        begin
            newmask := NodeCh.Values[1] and mask;
            if newmask = 0 then
                newmask := mask;
        end;
        NodeCh.Values[1] := newmask;
        PActionItem(NodeCh.Data)^.StructMask := newmask;
        PActionItem(NodeCh.Data)^.HasModified := True;

        for j := 0 to NodeCh.Count - 1 do
        begin
            NodeCh2 := NodeCh.Items[j];
            NodeCh2.Values[1] := newmask;
            PActionItem(NodeCh2.Data)^.StructMask := newmask;
            PActionItem(NodeCh2.Data)^.HasModified := True;
        end;
    end;
end;

procedure TfrmDocTypesEditorDlg.bbDocAnalyticsClick(Sender: TObject);
var
    DataL1: PActionItem;
    dialog: TfrmDocTypeAnalyticsDlg;
begin
    if Assigned(cxTreeActions.FocusedNode) then
    begin
        DataL1 := cxTreeActions.FocusedNode.Data;
        if DataL1^.ID > 0 then
        begin
            dialog := TfrmDocTypeAnalyticsDlg.Create(Self);
            try
                dialog.DocTypeID := DataL1^.ID;
                dialog.DocTypeTitle := DataL1^.Title;
                dialog.ShowModal;
            finally
                dialog.Free;
            end;
        end;
    end;
end;

procedure TfrmDocTypesEditorDlg.bbDocDefaultsClick(Sender: TObject);
var
    DataL1: PActionItem;
begin
    if Assigned(cxTreeActions.FocusedNode) then
    begin
        DataL1 := cxTreeActions.FocusedNode.Data;
        if DataL1^.ID > 0 then
            ShowDocumentDefaultsDialog(DataL1^.ID, DataL1^.Title);
    end;
end;

procedure TfrmDocTypesEditorDlg.bbDocumentStatesClick(Sender: TObject);
var
    dialog: TfrmDocTypeStatesDlg;
    Node: TcxTreeListNode;
    Data: PActionItem;
begin
    dialog := TfrmDocTypeStatesDlg.Create(self);

    try
        Node := cxTreeActions.FocusedNode;
        if Assigned(Node) then
        begin
            Data := Node.Data;
            dialog.DocTypeID := Data^.ID;
            dialog.ShowModal;
        end;
    finally
        dialog.Free;
    end;

end;

procedure TfrmDocTypesEditorDlg.bbExportDocTypesClick(Sender: TObject);
begin
    CreateDocTypesList;
end;

procedure TfrmDocTypesEditorDlg.bbMoveDownClick(Sender: TObject);
begin
    MoveSelectedItemDown;
end;

procedure TfrmDocTypesEditorDlg.bbMoveUpClick(Sender: TObject);
begin
    MoveSelectedItemUp;
end;

procedure TfrmDocTypesEditorDlg.bbSecDeleteClick(Sender: TObject);
var
    Node: TcxTreeListNode;
    Data: PActionItem;
    S, S2: string;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        Data := Node.Data;
        S2 := '';
        case Node.Level of
            0:
                begin
                    S := 'Sterge inregistrarea "%s"?';
                    S2 := 'Atentie! Inregistrarea va fi stearsa.';
                end;
            1:
                begin
                    S := 'Sterge inregistrarea "%s"?';
                    S2 := 'Atentie! Inregistrarea va fi stearsa';
                end;
            2:
                S := 'Sterge inregistrarea "%s"?';
        end;
        S := Format(S, [Data^.Title]);
        if fAutoDeleteNodes or (ShowAskDialogVerification('Tipuri de documente', S, 'Nu mai intreba', S2,
            fAutoDeleteNodes) = mrYes) then
        begin
            fChanged := True;
            fManualDelete := True;
            cxTreeActions.DeleteSelection;
            fManualDelete := False;
        end;
    end;
end;

procedure TfrmDocTypesEditorDlg.bbSecModifyClick(Sender: TObject);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        case Node.Level of
            0:
                ShowAreaEditorDialog(Node);
            1:
                ShowElementEditorDialog(Node.Parent, Node);
            2:
                ShowActionEditorDialog(Node.Parent, Node);
        end;
    end;
end;

procedure TfrmDocTypesEditorDlg.bbSecNewActionClick(Sender: TObject);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        if Node.Level = 2 then
            Node := Node.Parent;
        ShowActionEditorDialog(Node, nil);
    end;
end;

procedure TfrmDocTypesEditorDlg.bbSecNewAreaClick(Sender: TObject);
begin
    ShowAreaEditorDialog(nil);
end;

procedure TfrmDocTypesEditorDlg.bbSecNewItemClick(Sender: TObject);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        if Node.Level = 1 then
            Node := Node.Parent;
        ShowElementEditorDialog(Node, nil);
    end;
end;

procedure TfrmDocTypesEditorDlg.btnOkClick(Sender: TObject);
begin
    SaveData;
    ModalResult := mrOk;
end;

procedure TfrmDocTypesEditorDlg.ClearDeletedItems;
var
    i: Integer;
begin
    for i := 0 to fDeletedItems.Count - 1 do
        Dispose(PActionItem(fDeletedItems[i]));
    fDeletedItems.Clear;
end;

constructor TfrmDocTypesEditorDlg.Create(AOwner: TComponent);
begin
    inherited;
    fDeletedItems := TList.Create;
    fManualDelete := False;
    fAutoDeleteNodes := False;
    fChanged := False;
end;

procedure TfrmDocTypesEditorDlg.CreateAction(const ParentNode: TcxTreeListNode; const Title: WideString);
var
    Data: PActionItem;
    Node, Node2: TcxTreeListNode;
begin
    New(Data);
    Data^.ID := -1;
    Data^.ParentID := 0;
    Data^.Title := Title;
    Data^.StructMask := 0;
    Data^.ShortName := '';
    Data^.IsAction := True;
    Data^.TabSheetIndex := -1;
    Data^.ImageIndex := -1;
    Data^.AccFolders := 0;
    Data^.FLG_MONEY := False;
    Data^.FLG_DEBTS := False;
    Data^.FLG_INVOICE := False;
    Data^.FLG_SIGN := False;
    Data^.FLG_TRANSFER := False;
    Data^.FLG_ACNT_INVOICE := False;
    Data^.FLG_SERVICE_QTY := False;
    Data^.FLG_ASSEMBLE := False;
    Data^.FLG_ACHITARI := False;
    Data^.FLG_DBL_JURNAL := False;
    Data^.FLG_ACCESS_VISIBLE := True;

    Node := cxTreeActions.AddChild(ParentNode);

  // compute OrderNo
    Node2 := Node.getPrevSibling;
    if Assigned(Node2) then
        Data^.OrderNo := PActionItem(Node2.Data)^.OrderNo + 1
    else
        Data^.OrderNo := Node.Index;

    Node.Data := Data;
    Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
    Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
    Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;

    Node.ImageIndex := 17;
    Node.SelectedIndex := 17;
end;

procedure TfrmDocTypesEditorDlg.CreateConstList;
var
    Node, Node1, Node2: TcxTreeListNode;
    i, j, k: Integer;
    Data, Parent0Data, Parent1Data: PActionItem;
    Text: TStrings;
    s: WideString;
    dialog: TfrmDocTypesViewCodeDialog;
begin
    Text := TStringList.Create;

    Text.Add(Format(cHeaderText, [FormatDateTime('dd.mm.yyyy, HH:MM', NOW)]));
    Text.Add(cHeaderDelimiter);
    Text.Add('');

    for i := 0 to cxTreeActions.Count - 1 do
    begin
        Node := cxTreeActions.Items[i];
        Data := PActionItem(Node.Data);
        Parent0Data := Data;
        s := WideFormat(cComments0, [Data^.Title]);
        Text.Add(Utf8ToAnsi(UTF8Encode(s)));
        s := Format(cConstMask0, [CreateNormalIdentifer(Data^.Title), Data^.ID]);
        Text.Add(Utf8ToAnsi(UTF8Encode(s)));

        for j := 0 to Node.Count - 1 do
        begin
            Node1 := Node.Items[j];
            Data := PActionItem(Node1.Data);
            Parent1Data := Data;
            s := WideFormat(cComments1, [Data^.Title]);
            Text.Add(Utf8ToAnsi(UTF8Encode(s)));
            s := #9 + WideFormat(cConstMask1, [CreateLevel1Identifer(Parent0Data^.Title, Data^.Title), Data^.ID]);
            Text.Add(Utf8ToAnsi(UTF8Encode(s)));

            for k := 0 to Node1.Count - 1 do
            begin
                Node2 := Node1.Items[k];
                Data := PActionItem(Node2.Data);
                s := #9 + #9 + WideFormat(cConstMask2, [CreateLevel2Identifer(Parent0Data^.Title, Parent1Data^.Title,
                    Data^.Title), Data^.ID, Data^.Title]);
                Text.Add(Utf8ToAnsi(UTF8Encode(s)));
            end;
            Text.Add('');
        end;
        Text.Add('');
    end;
    Text.Add('');
    Text.Add(cFooter);

    if not Assigned(dialog) then
    begin
        dialog := TfrmDocTypesViewCodeDialog.Create(Self);
        try
            dialog.GeneratedLines := Text;
            dialog.ShowModal;
        finally
            dialog.Free;
        end;
    end;


//     with TSaveDialog.Create(self) do
//     begin
//          FileName:='TS_DocTypes_Const.txt';
//          if Execute then Text.SaveToFile(FileName);
//          Free;
//     end;


    Text.Free;
end;

procedure TfrmDocTypesEditorDlg.CreateDocTypesList;
var
    Node, Node1: TcxTreeListNode;
    i, j: Integer;
    Data: PActionItem;
    Text: TStrings;
    S, s0: WideString;
begin
    Text := TStringList.Create;
    try
        for i := 0 to cxTreeActions.Count - 1 do
        begin
            Node := cxTreeActions.Items[i];
            Data := PActionItem(Node.Data);
            S := WideFormat(#9 + '// %s', [Data^.Title]);
            s0 := CreateNormalIdentifer(Data^.Title);
            Text.Add(Utf8ToAnsi(UTF8Encode(S)));

            for j := 0 to Node.Count - 1 do
            begin
                Node1 := Node.Items[j];
                Data := PActionItem(Node1.Data);
                S := WideFormat(#9 + 'cDBID_DocType_%s_%s = %d;' + #9#9 + '// %s', [s0, GetWordsFirstLetters(Data
                    ^.Title), Data^.ID, Data^.Title]);
                Text.Add(Utf8ToAnsi(UTF8Encode(S)));
            end;
            Text.Add('');
        end;

        with TSaveDialog.Create(Self) do
        begin
            FileName := 'TS_DocTypes_only.txt';
            if Execute then
                Text.SaveToFile(FileName);
            Free;
        end;

    finally
        Text.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.CreateImageList;
var
    i: Integer;
    Props: TcxImageComboBoxProperties;
    Item: TcxImageComboBoxItem;
begin
    Props := TcxImageComboBoxProperties(cxTreeActions_IMAGEINDEX.Properties);
    for i := 0 to dmAdditions.cxImageList_MainTabs.Count - 1 do
    begin
        Item := Props.Items.Add;
        Item.ImageIndex := i;
        Item.Value := i;
    end;
end;

function TfrmDocTypesEditorDlg.CreateLevel1Identifer(const Level0, Level1: WideString): WideString;
begin
    if Pos(' ', Level0) = 0 then
        Result := WideFormat(cMaskLevel1, [RemoveBadChars(Level0), CreateNormalIdentifer(Level1)])
    else
        Result := WideFormat(cMaskLevel1, [GetWordsFirstLetters(Level0), CreateNormalIdentifer(Level1)]);
end;

function TfrmDocTypesEditorDlg.CreateLevel2Identifer(const Level0, Level1, Level2: WideString): WideString;
var
    L0, L1: string;
begin
    if Pos(' ', Level0) = 0 then
        L0 := RemoveBadChars(Level0)
    else
        L0 := GetWordsFirstLetters(Level0);

    if Pos(' ', Level1) = 0 then
        L1 := RemoveBadChars(Level1)
    else
        L1 := GetWordsFirstLetters(Level1);

    Result := WideFormat(cMaskLevel2, [L0, L1, CreateNormalIdentifer(Level2)])
end;

procedure TfrmDocTypesEditorDlg.CreateNewAction(const ParentNode: TcxTreeListNode; const Title: string; const
    FLG_ACCESS_VISIBLE: Boolean);
var
    Node: TcxTreeListNode;
    Data: PActionItem;
begin
    cxTreeActions.BeginUpdate;
    try
        New(Data);
        Data^.ID := -1;
        Data^.ParentID := 0;
        Data^.Title := Title;
        Data^.StructMask := 0;
        Data^.ShortName := '';
        Data^.IsAction := True;
        Data^.TabSheetIndex := -1;
        Data^.ImageIndex := -1;
        Data^.AccFolders := 0;
        Data^.FLG_MONEY := False;
        Data^.FLG_DEBTS := False;
        Data^.FLG_INVOICE := False;
        Data^.FLG_SIGN := False;
        Data^.FLG_TRANSFER := False;
        Data^.FLG_ACNT_INVOICE := False;
        Data^.FLG_SERVICE_QTY := False;
        Data^.FLG_ASSEMBLE := False;
        Data^.FLG_ACHITARI := False;
        Data^.FLG_DBL_JURNAL := False;
        Data^.FLG_ACCESS_VISIBLE := FLG_ACCESS_VISIBLE;

        Node := ParentNode.GetLastChild;
        if (Node = nil) then
            Data^.OrderNo := 0
        else
            Data^.OrderNo := Node.Index + 1;

        Node := cxTreeActions.AddChild(ParentNode);
        Node.Data := Data;
        Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
        Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
        Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;

        Node.ImageIndex := 17;
        Node.SelectedIndex := 17;

        ParentNode.Expanded := True;
    finally
        cxTreeActions.EndUpdate;
    end;
    if Assigned(Node) then
        cxTreeActions.FocusedNode := Node;

end;

procedure TfrmDocTypesEditorDlg.CreateNewArea(const Title: string; const ImageIndex, StructMask: Integer;
    const AccessVisible: Boolean);
var
    Node: TcxTreeListNode;
    Data: PActionItem;
begin
    cxTreeActions.BeginUpdate;
    try
        Node := cxTreeActions.Add;

        New(Data);
        Data^.ID := -1;
        Data^.ParentID := 0;
        Data^.Title := Title;
        Data^.StructMask := StructMask;
        Data^.ShortName := '';
        Data^.IsAction := False;
        Data^.TabSheetIndex := -1;
        Data^.ImageIndex := ImageIndex;
        Data^.AccFolders := 0;
        Data^.FLG_MONEY := False;
        Data^.FLG_DEBTS := False;
        Data^.FLG_INVOICE := False;
        Data^.FLG_SIGN := False;
        Data^.FLG_TRANSFER := False;
        Data^.FLG_SERVICE_QTY := False;
        Data^.FLG_ASSEMBLE := False;
        Data^.FLG_ACHITARI := False;
        Data^.FLG_DBL_JURNAL := False;
        Data^.FLG_ACCESS_VISIBLE := AccessVisible;

        Node.Data := Data;
        Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
        Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
        Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := AccessVisible;

        Node.ImageIndex := 14;
        Node.SelectedIndex := 14;

    finally
        cxTreeActions.EndUpdate;
    end;
    if Assigned(Node) then
        cxTreeActions.FocusedNode := Node;
end;

procedure TfrmDocTypesEditorDlg.CreateNewElement(const ParentNode: TcxTreeListNode; const Title, ShortName:
    string; const StructMask, FrameIndex, ImageIndex: Integer; const FLG_MONEY, FLG_DEBTS, FLG_INVOICE,
    FLG_SIGN, FLG_TRANSFER, FLG_ACNT_INVOICE, FLG_SERVICE_QTY, FLG_ASSEMBLE, FLG_ACHITARI, FLG_DBL_JURNAL,
    FLG_ACCESS_VISIBLE, FLG_UPR_UCET, FLG_BUH_UCET: Boolean; const CreateDefaultActions: Boolean);
var
    Node, Node2: TcxTreeListNode;
    Data, DataParent: PActionItem;
begin
    New(Data);
    Data^.ID := -1;
    Data^.ParentID := 0;
    Data^.Title := Title;
    Data^.StructMask := StructMask;
    Data^.ShortName := ShortName;
    Data^.IsAction := False;
    Data^.TabSheetIndex := FrameIndex;
    Data^.ImageIndex := ImageIndex;
    Data^.AccFolders := 0;
    Data^.FLG_MONEY := FLG_MONEY;
    Data^.FLG_DEBTS := FLG_DEBTS;
    Data^.FLG_INVOICE := FLG_INVOICE;
    Data^.FLG_SIGN := FLG_SIGN;
    Data^.FLG_TRANSFER := FLG_TRANSFER;
    Data^.FLG_ACNT_INVOICE := FLG_ACNT_INVOICE;
    Data^.FLG_SERVICE_QTY := FLG_SERVICE_QTY;
    Data^.FLG_ASSEMBLE := FLG_ASSEMBLE;
    Data^.FLG_ACHITARI := FLG_ACHITARI;
    Data^.FLG_DBL_JURNAL := FLG_DBL_JURNAL;
    Data^.FLG_ACCESS_VISIBLE := FLG_ACCESS_VISIBLE;
    Data^.FLG_UPR_UCET := FLG_UPR_UCET;
    Data^.FLG_BUH_UCET := FLG_BUH_UCET;
    cxTreeActions.BeginUpdate;
    try
        Node := cxTreeActions.AddChild(ParentNode);
    // inherit same values from parent
        DataParent := PActionItem(ParentNode.Data);
        Data^.AccFolders := DataParent^.AccFolders;

    // compute orderNo
        Node2 := Node.getPrevSibling;
        if Assigned(Node2) then
            Data^.OrderNo := PActionItem(Node2.Data)^.OrderNo + 1
        else
            Data^.OrderNo := Node.Index;

        Node.Data := Data;
        Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
        Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
        Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;

        Node.ImageIndex := 16;
        Node.SelectedIndex := 16;

        ParentNode.Expanded := True;

    // add default actions
        if CreateDefaultActions then
        begin
            CreateAction(Node, 'Vizializare');
            CreateAction(Node, 'Inregistrarea noua');
            CreateAction(Node, 'Modifica inregistrarea');
            CreateAction(Node, 'Sterge inregistrarea');
//            CreateAction(Node, 'Tipar');
            Node.Expanded := True;
        end;

    finally
        cxTreeActions.EndUpdate;
    end;
    cxTreeActions.FocusedNode := Node;

end;

function TfrmDocTypesEditorDlg.CreateNormalIdentifer(const Text: WideString): WideString;
var
    k, K2: Integer;
begin
    Result := Text;
  // remove comments
    k := Pos(WideString('('), Result);
    if k > 0 then
    begin
        K2 := Pos(WideString(')'), Result);
        if K2 > k then
            Delete(Result, k, K2 - k + 1);
    end;
  // remove bad chars
    Result := Trim(RemoveBadChars(Result));
  // replace spaces
    Result := StringReplace(Result, ' ', '_', [rfReplaceAll]);
end;

procedure TfrmDocTypesEditorDlg.CreateSimpleTreeList;
var
    Node, Node1, Node2: TcxTreeListNode;
    i, j, k: Integer;
    Data: PActionItem;
    Text: TStrings;
    S: string;
begin
    Text := TStringList.Create;

    for i := 0 to cxTreeActions.Count - 1 do
    begin
        Node := cxTreeActions.Items[i];
        Data := PActionItem(Node.Data);
        S := Format('%4d' + #9 + '%4d' + #9 + '%s', [Data^.ID, Data^.ParentID, Data^.Title]);
        Text.Add(Utf8ToAnsi(UTF8Encode(S)));

        for j := 0 to Node.Count - 1 do
        begin
            Node1 := Node.Items[j];
            Data := PActionItem(Node1.Data);
            S := Format('%4d' + #9 + '%4d' + #9 + #9 + '%s', [Data^.ID, Data^.ParentID, Data^.Title]);
            Text.Add(Utf8ToAnsi(UTF8Encode(S)));

            for k := 0 to Node1.Count - 1 do
            begin
                Node2 := Node1.Items[k];
                Data := PActionItem(Node2.Data);
                S := Format('%4d' + #9 + '%4d' + #9 + #9 + #9 + '%s', [Data^.ID, Data^.ParentID, Data^.Title]);
                Text.Add(Utf8ToAnsi(UTF8Encode(S)));
            end;
        end;
        Text.Add('');
    end;

    with TSaveDialog.Create(Self) do
    begin
        FileName := 'TS_DocTypes_Simple.txt';
        if Execute then
            Text.SaveToFile(FileName);
        Free;
    end;

    Text.Free;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsCustomDrawDataCell(Sender: TcxCustomTreeList; ACanvas: TcxCanvas;
    AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
var
    Data: PActionItem;
begin
    Data := AViewInfo.Node.Data;
    case AViewInfo.Column.ItemIndex of
        0:
            if (AViewInfo.Node.Level = 0) then
                ACanvas.Font.Style := [fsBold];
        1:
            if (Data^.StructMask = 0) then
            begin
                ACanvas.Font.Color := clGrayText;
                ACanvas.Font.Style := [fsItalic];
            end; // areas
        3:
            if (Data^.TabSheetIndex = -1) then
                ACanvas.Font.Color := clGrayText; // tabindex
    end;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionscxTreeListColumn1GetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    Value := Format('%d. %s', [Data^.ID, Data^.Title]);
  // if (ANode.Level=1) and (Data^.ID>0)
  // then Value:=Format('%d. %s',[Data^.ID,Data^.Title])
  // else Value:=Data^.Title;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionscxTreeListColumn3GetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if ANode.Level <= 1 then
    begin
        if Data^.TabSheetIndex = -1 then
            Value := '' // Value:='nu exista'
        else
            Value := IntToStr(Data^.TabSheetIndex);
    end
    else
        Value := ''
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_STRUCTMASKGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
begin
    if ANode.Level > 1 then
        Value := '';
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionscxTreeListColumn5PropertiesEditValueToStates(Sender: TObject;
    const AValue: Variant; var ACheckStates: TcxCheckStates);
var
    i: Integer;
    Props: TcxCheckComboBoxProperties;
begin
    Props := TcxCheckComboBoxProperties(cxTreeActions_STRUCTMASK.Properties);
    for i := 0 to Props.Items.Count - 1 do
    begin
        if ((AValue shr Props.Items[i].Tag) and 1) = 1 then
            ACheckStates[i] := cbsChecked
        else
            ACheckStates[i] := cbsUnchecked;
    end;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionscxTreeListColumn5PropertiesStatesToEditValue(Sender: TObject;
    const ACheckStates: TcxCheckStates; out AValue: Variant);
var
    i: Integer;
    Value, bits: int64;
    Props: TcxCheckComboBoxProperties;
begin
    Value := 0;
    Props := TcxCheckComboBoxProperties(cxTreeActions_STRUCTMASK.Properties);
    for i := Low(ACheckStates) to High(ACheckStates) do
    begin
        if ACheckStates[i] = cbsChecked then
        begin
            bits := 1 shl Props.Items[i].Tag;
            Value := Value or bits;
        end;
    end;
    AValue := Value;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsDblClick(Sender: TObject);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) and (Node.Level = 2) and bbSecModify.Enabled and (bbSecModify.Visible = ivAlways) then
        ShowActionEditorDialog(Node.Parent, Node);
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsDeletion(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
var
    Data: PActionItem;
begin
    Data := PActionItem(ANode.Data);
    if Assigned(Data) then
    begin
        if (Data^.ID <> -1) and fManualDelete then
            fDeletedItems.Add(Data)
        else
            Dispose(Data);
    end;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsDragOver(Sender, Source: TObject; X, Y: Integer; State:
    TDragState; var Accept: Boolean);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.GetNodeAt(X, Y);
    if Assigned(Node) and (Node.Level = 0) and (cxTreeActions.DragNode.Level = 1) and (Node <> cxTreeActions.DragNode.Parent)
        then
    begin
    // if (Node<>cxTreeActions.DragNode.Parent) and (Not Node.Expanded) then Node.Expand(False);
        Accept := True;
    end
    else
        Accept := False;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode,
    AFocusedNode: TcxTreeListNode);
begin
    SelectedActionChanged;
    SelectedFilterVisibility;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsMoveTo(Sender: TcxCustomTreeList; AttachNode: TcxTreeListNode;
    AttachMode: TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean);
var
    S: string;
    Data0, Data: PActionItem;
begin
    Data0 := TcxTreeListNode(Nodes[0]).Data;
    Data := AttachNode.Data;
    S := 'Doriti sa mutati documentul' + #13#10 + '"' + Data0^.Title + '"' + #13#10 + 'in zona "' + Data^.Title
        + '"?';
    if ShowAskDialog('Transfer document', S) <> mrYes then
        Done := True;

end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_ACHITARIGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.FLG_ACHITARI then
        Value := '●'
    else
        Value := '';
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_ACNT_INVOICEGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.FLG_ACNT_INVOICE then
        Value := '●'
    else
        Value := '';
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_ASSEMBLEGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_ASSEMBLE then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_DEBTSGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_DEBTS then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_INVOICEGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_INVOICE then
        Value := '●';
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_MONEYGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_MONEY then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_SERVICE_QTYGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_SERVICE_QTY then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_SIGNGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else
    begin
        if Data^.FLG_SIGN then
            Value := '+'
        else
            Value := '-';
    end;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_TRANSFERGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_TRANSFER then
        Value := '●';
end;

destructor TfrmDocTypesEditorDlg.Destroy;
begin
    ClearDeletedItems;
    fDeletedItems.Free;
    inherited;
end;

procedure TfrmDocTypesEditorDlg.cxTreeActionsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  TargetNode, DragNode, OldParent: TcxTreeListNode;
  NewParentID, DocTypeID: Integer;
  DataDrag: PActionItem;
  q: TIBCQuery;

  procedure UpdateSiblingsOrderInDB(const ParentNode: TcxTreeListNode);
  var
    Sibling: TcxTreeListNode;
    OrderNo: Integer;
    Data: PActionItem;
  begin
    if not Assigned(ParentNode) then Exit;

    // Recalculează ordinea în memorie + scrie imediat în DB
    Sibling := ParentNode.GetFirstChild;
    OrderNo := 0;
    while Assigned(Sibling) do
    begin
      Data := PActionItem(Sibling.Data);
      if Assigned(Data) then
      begin
        Data^.OrderNo := OrderNo;
        Data^.HasModified := True;

        // Important: folosim view-ul ce permite UPDATE pe ORDERNO (conform codului existent)
        q.SQL.Text := 'update VW_TS_DOCTYPES set ORDERNO = :ORDERNO where DOCTYPEID = :ID';
        q.ParamByName('ORDERNO').AsInteger := OrderNo;
        q.ParamByName('ID').AsInteger      := Data^.ID;
        q.ExecSQL;
      end;

      Inc(OrderNo);
      Sibling := Sibling.GetNextSibling;
    end;
  end;

begin
  TargetNode := cxTreeActions.GetNodeAt(X, Y);
  DragNode   := cxTreeActions.DragNode;

  if Assigned(TargetNode)
     and (TargetNode.Level = 0)
     and Assigned(DragNode) and (DragNode.Level = 1)
     and (TargetNode <> DragNode.Parent) then
  begin
    OldParent   := DragNode.Parent;                 // păstrăm vechiul părinte
    NewParentID := PActionItem(TargetNode.Data)^.ID;
    DocTypeID   := PActionItem(DragNode.Data)^.ID;

    q := TIBCQuery.Create(nil);
    try
      q.Connection  := dmDB.IBCConnection;
      q.Transaction := dmDB.IBCTrDefaultUpdate;

      try
        if not q.Transaction.Active then
          q.Transaction.StartTransaction;

        // 1) Update PARENTID pentru nodul mutat
        q.SQL.Text := 'update TS_DOCTYPES set PARENTID = :NEW_PARENTID where DOCTYPEID = :DOCTYPEID';
        q.ParamByName('NEW_PARENTID').AsInteger := NewParentID;
        q.ParamByName('DOCTYPEID').AsInteger    := DocTypeID;
        q.ExecSQL;

        // 2) Mutare vizuală în arbore (ca ultim copil)
        DragNode.MoveTo(TargetNode, tlamAddChild);

        // 3) Actualizăm parentul și marcăm schimbarea în memorie
        DataDrag := PActionItem(DragNode.Data);
        DataDrag^.ParentID    := NewParentID;
        DataDrag^.HasModified := True;

        // 4) Recalculăm și scriem ORDERNO pentru frați:
        //    - întâi în vechiul părinte (lista s-a "strâns")
        //    - apoi în noul părinte (unde nodul a fost adăugat la sfârșit)
        UpdateSiblingsOrderInDB(OldParent);
        UpdateSiblingsOrderInDB(TargetNode);

        // 5) Commit
        q.Transaction.Commit;
      except
        q.Transaction.Rollback;
        raise;
      end;
    finally
      q.Free;
    end;

    // 6) Recompute în memorie pentru întreg arborele (opțional, pentru consistență UI)
    ReComputeOrderNo;

    fChanged := True;
    cxTreeActions.FocusedNode := DragNode;
  end;
end;

//
//procedure TfrmDocTypesEditorDlg.cxTreeActionsDragDrop(Sender, Source: TObject;
//    X, Y: Integer);
//var
//  TargetNode, DragNode: TcxTreeListNode;
//  NewParentID, DocTypeID: Integer;
//  DataDrag: PActionItem;
//  q: TIBCQuery;
//begin
//  TargetNode := cxTreeActions.GetNodeAt(X, Y);
//  DragNode   := cxTreeActions.DragNode;
//
//  if Assigned(TargetNode)
//     and (TargetNode.Level = 0)
//     and Assigned(DragNode) and (DragNode.Level = 1)
//     and (TargetNode <> DragNode.Parent) then
//  begin
//    // ID-urile reale sunt în structura PActionItem stocată în Node.Data
//    NewParentID := PActionItem(TargetNode.Data)^.ID;
//    DocTypeID   := PActionItem(DragNode.Data)^.ID;
//
//    // 1) Actualizează în DB
//    q := TIBCQuery.Create(nil);
//    try
//      q.Connection  := dmDB.IBCConnection;
//      q.Transaction := dmDB.IBCTrDefaultUpdate;
//
//      try
//        if not q.Transaction.Active then
//          q.Transaction.StartTransaction;
//
//        q.SQL.Text := 'update TS_DOCTYPES set PARENTID = :NEW_PARENTID where DOCTYPEID = :DOCTYPEID';
//        q.ParamByName('NEW_PARENTID').AsInteger := NewParentID;
//        q.ParamByName('DOCTYPEID').AsInteger    := DocTypeID;
//        q.ExecSQL;
//
//        q.Transaction.Commit;
//      except
//        q.Transaction.Rollback;
//        raise;
//      end;
//    finally
//      q.Free;
//    end;
//
//    // 2) Mută vizual nodul în arbore și actualizează modelul din memorie
//    DragNode.MoveTo(TargetNode, tlamAddChild); // sau tlamAddChild dacă preferi la început
//    DataDrag := PActionItem(DragNode.Data);
//    DataDrag^.ParentID    := NewParentID;
//    DataDrag^.HasModified := True;  // marchează că s-a schimbat poziția
//    fChanged              := True;  // pentru a permite salvarea ulterioară (ex. ordonarea)
//
//    // 3) Recalculează ordinea (ORDERNO) în memorie; se va persista la SaveData
//    ReComputeOrderNo;
//
//    // opțional: focus pe nodul mutat
//    cxTreeActions.FocusedNode := DragNode;
//  end;
//end;


procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_BUH_UCETGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_BUH_UCET then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.cxTreeActions_FLG_URP_UCETGetDisplayText(Sender: TcxTreeListColumn; ANode:
    TcxTreeListNode; var Value: string);
var
    Data: PActionItem;
begin
    Data := ANode.Data;
    if Data^.IsAction or (ANode.Level = 0) then
        Value := ''
    else if Data^.FLG_UPR_UCET then
        Value := '●'
end;

procedure TfrmDocTypesEditorDlg.DoShowUserGroupRights(Node: TcxTreeListNode);
var
    dialog: TfrmListOfUserGroupsDialog;
    Data: PActionItem;
begin
    Data := nil;
    if Assigned(Node) then
        Data := Node.Data;

    dialog := TfrmListOfUserGroupsDialog.Create(Self, dmdb.IBCConnection);
    try
//        dialog.DialogTitle1.Text := 'Cod operatie: '+IntToStr(Data^.ID) + ', valoarea:'+ IntToStr(Data^.AccFolders);
        dialog.SecurityFlagValue := Data^.ID;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.SaveData;
begin
    if fChanged then
    begin
        if bbNewIDs.Down then
            SaveActionTreeAsNew
        else
            SaveActionTreeAsAppend;
        fChanged := False;
    end;
end;

procedure TfrmDocTypesEditorDlg.ShowActionEditorDialog(const ParentNode, Node: TcxTreeListNode);
var
    dialog: TfrmDocTypesActionEditorDlg;
    Data: PActionItem;
begin
    Data := nil;
    if Assigned(Node) then
        Data := Node.Data;

    dialog := TfrmDocTypesActionEditorDlg.Create(Self);
    try
        if Assigned(Node) then
        begin
            dialog.Title := Data^.Title;
            dialog.FLG_ACCESS_VISIBLE := Data^.FLG_ACCESS_VISIBLE;
            dialog.dtDialogTitle.Text := 'Modifica inregistrarea';
        end
        else
            dialog.dtDialogTitle.Text := 'Creare inregistrare noua';

        if dialog.ShowModal = mrOk then
        begin
            fChanged := True;
            if Assigned(Node) then
            begin
                Data^.Title := dialog.Title;
                Data^.FLG_ACCESS_VISIBLE := dialog.FLG_ACCESS_VISIBLE;
                Data^.HasModified := True;

                Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;
            end
            else
                CreateNewAction(ParentNode, dialog.Title, dialog.FLG_ACCESS_VISIBLE);
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ShowAreaEditorDialog(const Node: TcxTreeListNode);
var
    dialog: TfrmDocTypesRegionEditorDlg;
    Data: PActionItem;
begin
    Data := nil;
    if Assigned(Node) then
        Data := Node.Data;

    dialog := TfrmDocTypesRegionEditorDlg.Create(Self);
    try
        GetStructureItemsForArea(dialog.clbStructure);

        if Assigned(Node) then
        begin
            dialog.Title := Data^.Title;
            dialog.StructMask := Data^.StructMask;
            dialog.ImageIndex := Data^.ImageIndex;
            dialog.dtDialogTitle.Text := 'Modifica inregistrarea';
            dialog.DocTypeID := Data^.ID;
            dialog.teOrderNo.Text := Data^.OrderNo.ToString;
            dialog.AccessVisible := Data^.FLG_ACCESS_VISIBLE;
        end
        else
            dialog.dtDialogTitle.Text := 'Crearea inregistrarii noi';

        if dialog.ShowModal = mrOk then
        begin
            fChanged := True;
            if Assigned(Node) then
            begin
                Data^.Title := dialog.Title;
                Data^.StructMask := dialog.StructMask;
                Data^.ImageIndex := dialog.ImageIndex;
                Data^.HasModified := True;
                Data^.FLG_ACCESS_VISIBLE := dialog.AccessVisible;
                Data^.OrderNo := StrToInt(dialog.teOrderNo.Text);

                Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
                Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
                Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;

                Node.Repaint(False);
                ApplyStructMaskToChildren(Node);
            end
            else
                CreateNewArea(dialog.Title, dialog.ImageIndex, dialog.StructMask, dialog.AccessVisible);
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ShowDocumentDefaultsDialog(const DocTypeID: Integer; const DocTypeTitle: string);
var
    dialog: TfrmDocTypeDefaultsDlg;
begin
    dialog := TfrmDocTypeDefaultsDlg.Create(Self);
    try
        dialog.DocTypeID := DocTypeID;
        dialog.DocTypeTitle := DocTypeTitle;
        dialog.ShowModal;
    finally
        dialog.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ShowElementEditorDialog(const ParentNode, Node: TcxTreeListNode);
var
    dialog: TfrmDocTypesElementEditorDlg;
    Data: PActionItem;
begin
    Data := nil;
    if Assigned(Node) then
        Data := Node.Data;

    dialog := TfrmDocTypesElementEditorDlg.Create(Self);
    try
        GetStructureItemsForElement(ParentNode, dialog.clbStructure);
        dialog.OnGetNextFrameIndex := GetNextTabSheetIndex;

        if Assigned(Node) then
        begin
            dialog.Title := Data^.Title;
            dialog.ShortName := Data^.ShortName;
            dialog.StructMask := Data^.StructMask;
            dialog.ImageIndex := Data^.ImageIndex;
            dialog.FrameIndex := Data^.TabSheetIndex;
            dialog.FLG_MONEY := Data^.FLG_MONEY;
            dialog.FLG_DEBTS := Data^.FLG_DEBTS;
            dialog.FLG_INVOICE := Data^.FLG_INVOICE;
            dialog.FLG_SIGN := Data^.FLG_SIGN;
            dialog.FLG_TRANSFER := Data^.FLG_TRANSFER;
            dialog.FLG_ACNT_INVOICE := Data^.FLG_ACNT_INVOICE;
            dialog.FLG_SERVICE_QTY := Data^.FLG_SERVICE_QTY;
            dialog.FLG_ASSEMBLE := Data^.FLG_ASSEMBLE;
            dialog.FLG_ACHITARI := Data^.FLG_ACHITARI;
            dialog.FLG_DBL_JURNAL := Data^.FLG_DBL_JURNAL;
            dialog.FLG_ACCESS_VISIBLE := Data^.FLG_ACCESS_VISIBLE;
            dialog.FLG_UPR_UCET := Data^.FLG_UPR_UCET;
            dialog.FLG_BUH_UCET := Data^.FLG_BUH_UCET;

            dialog.dtDialogTitle.Text := 'Modificare inregistrare';
            dialog.DocTypeID := Data^.ID;
        end
        else
        begin
            dialog.dtDialogTitle.Text := 'Creare element nou';
            dialog.cbCreateDefaultActions.Visible := True;
            dialog.cbCreateDefaultActions.Checked := False;
        end;

        if dialog.ShowModal = mrOk then
        begin
            fChanged := True;
            if Assigned(Node) then
            begin
                Data^.Title := dialog.Title;
                Data^.ShortName := dialog.ShortName;
                Data^.StructMask := dialog.StructMask;
                Data^.ImageIndex := dialog.ImageIndex;
                Data^.TabSheetIndex := dialog.FrameIndex;
                Data^.FLG_MONEY := dialog.FLG_MONEY;
                Data^.FLG_DEBTS := dialog.FLG_DEBTS;
                Data^.FLG_INVOICE := dialog.FLG_INVOICE;
                Data^.FLG_SIGN := dialog.FLG_SIGN;
                Data^.FLG_TRANSFER := dialog.FLG_TRANSFER;
                Data^.FLG_ACNT_INVOICE := dialog.FLG_ACNT_INVOICE;
                Data^.FLG_SERVICE_QTY := dialog.FLG_SERVICE_QTY;
                Data^.FLG_ASSEMBLE := dialog.FLG_ASSEMBLE;
                Data^.FLG_ACHITARI := dialog.FLG_ACHITARI;
                Data^.FLG_DBL_JURNAL := dialog.FLG_DBL_JURNAL;
                Data^.FLG_ACCESS_VISIBLE := dialog.FLG_ACCESS_VISIBLE;
                Data^.FLG_UPR_UCET := dialog.FLG_UPR_UCET;
                Data^.FLG_BUH_UCET := dialog.FLG_BUH_UCET;

                Data^.HasModified := True;

                Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := Data^.StructMask;
                Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := Data^.ImageIndex;
                Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := Data^.FLG_ACCESS_VISIBLE;

                Node.Repaint(False);
            end
            else
                with dialog do
                    CreateNewElement(ParentNode, Title, ShortName, StructMask, FrameIndex, ImageIndex,
                        FLG_MONEY, FLG_DEBTS, FLG_INVOICE, FLG_SIGN, FLG_TRANSFER, FLG_ACNT_INVOICE,
                        FLG_SERVICE_QTY, FLG_ASSEMBLE, FLG_ACHITARI, FLG_DBL_JURNAL, FLG_ACCESS_VISIBLE,
                        FLG_UPR_UCET, FLG_BUH_UCET, cbCreateDefaultActions.Checked);
        end;
    finally
        dialog.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.dxBarButton1Click(Sender: TObject);
begin
    CreateConstList;
end;

procedure TfrmDocTypesEditorDlg.dxBarButton2Click(Sender: TObject);
begin
    CreateSimpleTreeList;
end;

procedure TfrmDocTypesEditorDlg.dxBarButton3Click(Sender: TObject);
var
    Node: TcxTreeListNode;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        if Node.Level = 2 then
            DoShowUserGroupRights(Node);
    end;
end;

procedure TfrmDocTypesEditorDlg.EditDocTypes;
begin
    ShowModal;
end;

procedure TfrmDocTypesEditorDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if fChanged then
    begin
        if ShowAskDialog('Date modificate', 'Datele au fost modificate! Salvam modificarile?') = mrYes then
            SaveData;
    end;
end;

function TfrmDocTypesEditorDlg.GetNextTabSheetIndex: Integer;
var
    Node, Node1: TcxTreeListNode;
    i, j: Integer;
    Data: PActionItem;
begin
    Result := 0;
    for i := 0 to cxTreeActions.Count - 1 do
    begin
        Node := cxTreeActions.Items[i];
        for j := 0 to Node.Count - 1 do
        begin
            Node1 := Node.Items[j];
            Data := PActionItem(Node1.Data);
            if Data^.TabSheetIndex > Result then
                Result := Data^.TabSheetIndex;
        end;
    end;
    Inc(Result);
end;

function TfrmDocTypesEditorDlg.GetWordsFirstLetters(const Phrase: WideString): WideString;
var
    k: Integer;
    S: string;
begin
    Result := '';
    S := RemoveBadChars(WideUpperCase(Trim(Phrase)));
    k := Pos(' ', S);
    while (k > 0) do
    begin
        Result := Result + S[1];
        Delete(S, 1, k);
        k := Pos(' ', S);
    end;
    if S <> '' then
        Result := Result + S[1];
end;

procedure TfrmDocTypesEditorDlg.LoadDocStrutures;
var
    Query: TIBCQuery;
    cb: TcxCheckComboBoxItem;
    VisibleColumnProp: TcxCheckComboBoxProperties;
begin
    VisibleColumnProp := TcxCheckComboBoxProperties(cxTreeActions.Columns[1].Properties);

    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection; // fIBCConnection;
        Query.SQL.Text := 'SELECT STRUCTUREID,TITLE FROM TS_STRUCTURE ORDER BY STRUCTUREID';
        Query.ExecSQL;
        while not Query.Eof do
        begin
            cb := VisibleColumnProp.Items.Add;
            cb.Tag := Query.Fields[0].AsInteger;
            cb.Description := Query.Fields[1].AsString;

            Query.Next;
        end;
        Query.Close;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.MoveSelectedItemDown;
var
    Node, NextNode: TcxTreeListNode;
    DataPrev: PActionItem;
    Data: PActionItem;
begin
    if Assigned(cxTreeActions.FocusedNode) then
    begin
        Node := cxTreeActions.FocusedNode;
        NextNode := Node.getNextSibling;
        if Assigned(NextNode) then
        begin
            DataPrev := PActionItem(NextNode.Data);
            Data := PActionItem(Node.Data);

      // move Node
            NextNode.MoveTo(Node, tlamInsert);

      // update OrderNo
            DataPrev^.HasModified := True;
            Data^.HasModified := True;

            ReComputeOrderNo;

            fChanged := True;
        end;

        SelectedActionChanged;
    end;
end;

procedure TfrmDocTypesEditorDlg.MoveSelectedItemUp;
var
    Node, PrevNode: TcxTreeListNode;
    DataPrev: PActionItem;
    Data: PActionItem;
begin
    if Assigned(cxTreeActions.FocusedNode) then
    begin
        Node := cxTreeActions.FocusedNode;
        PrevNode := Node.getPrevSibling;
        if Assigned(PrevNode) then
        begin
            DataPrev := PActionItem(PrevNode.Data);
            Data := PActionItem(Node.Data);

      // move Node
            Node.MoveTo(PrevNode, tlamInsert);

      // update OrderNo
            DataPrev^.HasModified := True;
            Data^.HasModified := True;

            ReComputeOrderNo;

            fChanged := True;
        end;

        SelectedActionChanged;
    end;
end;

procedure TfrmDocTypesEditorDlg.Prepare;
begin
    SetupSecurityItems;

    CreateImageList;
    LoadDocStrutures;
    ScanActionsTree;

    SelectedActionChanged;
    SelectedFilterVisibility;
end;

procedure TfrmDocTypesEditorDlg.ReadLevel0Items;
var
    Query: TIBCQuery;
    Node: TcxTreeListNode;
    AI: PActionItem;
begin
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;

    // read elements Level 0
        Query.SQL.Text :=
            'SELECT * FROM VW_TS_DOCTYPES WHERE (DOCTYPEID>=0) AND (PARENTID=0) AND (FLG_ACTION=0) ORDER BY ORDERNO';
        Query.ExecSQL;
        while not Query.Eof do
        begin
            New(AI);
            AI^.ID := Query.FieldByName('DOCTYPEID').AsInteger;
            AI^.ParentID := Query.FieldByName('PARENTID').AsInteger;
            AI^.StructMask := Query.FieldByName('STRUCT$MASK').Value; // AsLargeInt;
            AI^.Title := Query.FieldByName('TITLE').AsWideString;
            AI^.ShortName := Query.FieldByName('SHORTNAME').AsWideString;
            AI^.IsAction := Query.FieldByName('FLG_ACTION').AsInteger = 1;
            AI^.TabSheetIndex := Query.FieldByName('TABSHEETINDEX').AsInteger;
            AI^.ImageIndex := Query.FieldByName('IMAGEINDEX').AsInteger;
            AI^.AccFolders := Query.FieldByName('ACC$FOLDERS').Value; // AsLargeInt;
            AI^.FLG_MONEY := Query.FieldByName('FLG_MONEY').AsInteger = 1;
            AI^.FLG_DEBTS := Query.FieldByName('FLG_DEBTS').AsInteger = 1;
            AI^.FLG_INVOICE := Query.FieldByName('FLG_INVOICE').AsInteger = 1;
            AI^.FLG_SIGN := Query.FieldByName('FLG_SIGN').AsInteger = 1;
            AI^.FLG_TRANSFER := Query.FieldByName('FLG_TRANSFER').AsInteger = 1;
            AI^.FLG_ACNT_INVOICE := Query.FieldByName('FLG_ACNT_INVOICE').AsInteger = 1;
            AI^.FLG_SERVICE_QTY := Query.FieldByName('FLG_SERVICE_QTY').AsInteger = 1;
            AI^.FLG_ASSEMBLE := Query.FieldByName('FLG_ASSEMBLE').AsInteger = 1;
            AI^.FLG_ACHITARI := Query.FieldByName('FLG_ACHITARI').AsInteger = 1;
            AI^.FLG_DBL_JURNAL := Query.FieldByName('FLG_DBL_JURNAL').AsInteger = 1;
            AI^.OrderNo := Query.FieldByName('ORDERNO').AsInteger;
            AI^.FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;
            AI^.FLG_UPR_UCET := Query.FieldByName('FLG_UPR_UCET').AsInteger = 1;
            AI^.FLG_BUH_UCET := Query.FieldByName('FLG_BUH_UCET').AsInteger = 1;
            AI^.HasModified := False;

            Node := cxTreeActions.Add;
            Node.Data := AI;
            Node.ImageIndex := 14;
            Node.SelectedIndex := 14;

            Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := AI^.StructMask;
            Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := AI^.ImageIndex;
            Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := AI^.FLG_ACCESS_VISIBLE;

      // read sub items
            ReadLevel1Items(AI^.ID, Node);

            Query.Next;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ReadLevel1Items(const ParentID: Integer; const ParentNode: TcxTreeListNode);
var
    Query: TIBCQuery;
    Node: TcxTreeListNode;
    AI: PActionItem;
begin
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;

    // read elements Level 0
        Query.SQL.Text :=
            'SELECT * FROM VW_TS_DOCTYPES WHERE (DOCTYPEID>=0) AND (PARENTID=:id) AND (FLG_ACTION=0) ORDER BY ORDERNO';
        Query.ParamByName('id').AsInteger := ParentID;
        Query.ExecSQL;
        while not Query.Eof do
        begin
            New(AI);
            AI^.ID := Query.FieldByName('DOCTYPEID').AsInteger;
            AI^.ParentID := Query.FieldByName('PARENTID').AsInteger;
            AI^.StructMask := Query.FieldByName('STRUCT$MASK').Value; // AsLargeInt;
            AI^.Title := Query.FieldByName('TITLE').AsWideString;
            AI^.ShortName := Query.FieldByName('SHORTNAME').AsWideString;
            AI^.IsAction := Query.FieldByName('FLG_ACTION').AsInteger = 1;
            AI^.TabSheetIndex := Query.FieldByName('TABSHEETINDEX').AsInteger;
            AI^.ImageIndex := Query.FieldByName('IMAGEINDEX').AsInteger;
            AI^.AccFolders := Query.FieldByName('ACC$FOLDERS').Value; // AsLargeInt;
            AI^.FLG_MONEY := Query.FieldByName('FLG_MONEY').AsInteger = 1;
            AI^.FLG_DEBTS := Query.FieldByName('FLG_DEBTS').AsInteger = 1;
            AI^.FLG_INVOICE := Query.FieldByName('FLG_INVOICE').AsInteger = 1;
            AI^.FLG_SIGN := Query.FieldByName('FLG_SIGN').AsInteger = 1;
            AI^.FLG_TRANSFER := Query.FieldByName('FLG_TRANSFER').AsInteger = 1;
            AI^.FLG_ACNT_INVOICE := Query.FieldByName('FLG_ACNT_INVOICE').AsInteger = 1;
            AI^.FLG_SERVICE_QTY := Query.FieldByName('FLG_SERVICE_QTY').AsInteger = 1;
            AI^.FLG_ASSEMBLE := Query.FieldByName('FLG_ASSEMBLE').AsInteger = 1;
            AI^.FLG_ACHITARI := Query.FieldByName('FLG_ACHITARI').AsInteger = 1;
            AI^.FLG_DBL_JURNAL := Query.FieldByName('FLG_DBL_JURNAL').AsInteger = 1;
            AI^.OrderNo := Query.FieldByName('ORDERNO').AsInteger;
            AI^.FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;
            AI^.FLG_UPR_UCET := Query.FieldByName('FLG_UPR_UCET').AsInteger = 1;
            AI^.FLG_BUH_UCET := Query.FieldByName('FLG_BUH_UCET').AsInteger = 1;
            AI^.HasModified := False;

            Node := cxTreeActions.AddChild(ParentNode);
            Node.Data := AI;
            Node.ImageIndex := 16;
            Node.SelectedIndex := 16;

            Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := AI^.StructMask;
            Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := AI^.ImageIndex;
            Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := AI^.FLG_ACCESS_VISIBLE;

      // read subItems
            ReadLevel2Items(AI^.ID, Node);

            Query.Next;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ReadLevel2Items(const ParentID: Integer; const ParentNode: TcxTreeListNode);
var
    Query: TIBCQuery;
    Node: TcxTreeListNode;
    AI: PActionItem;
begin
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;

    // read elements Level 0
        Query.SQL.Text :=
            'SELECT * FROM VW_TS_DOCTYPES WHERE (DOCTYPEID>=0) AND (PARENTID=:id) AND (FLG_ACTION=1) ORDER BY ORDERNO';
        Query.ParamByName('id').AsInteger := ParentID;
        Query.ExecSQL;
        while not Query.Eof do
        begin
            New(AI);
            AI^.ID := Query.FieldByName('DOCTYPEID').AsInteger;
            AI^.ParentID := Query.FieldByName('PARENTID').AsInteger;
            AI^.StructMask := Query.FieldByName('STRUCT$MASK').Value; // AsLargeInt;
            AI^.Title := Query.FieldByName('TITLE').AsWideString;
            AI^.ShortName := Query.FieldByName('SHORTNAME').AsWideString;
            AI^.IsAction := Query.FieldByName('FLG_ACTION').AsInteger = 1;
            AI^.TabSheetIndex := Query.FieldByName('TABSHEETINDEX').AsInteger;
            AI^.ImageIndex := Query.FieldByName('IMAGEINDEX').AsInteger;
            AI^.AccFolders := Query.FieldByName('ACC$FOLDERS').Value; // AsLargeInt;
            AI^.FLG_MONEY := Query.FieldByName('FLG_MONEY').AsInteger = 1;
            AI^.FLG_DEBTS := Query.FieldByName('FLG_DEBTS').AsInteger = 1;
            AI^.FLG_INVOICE := Query.FieldByName('FLG_INVOICE').AsInteger = 1;
            AI^.FLG_SIGN := Query.FieldByName('FLG_SIGN').AsInteger = 1;
            AI^.FLG_TRANSFER := Query.FieldByName('FLG_TRANSFER').AsInteger = 1;
            AI^.FLG_ACNT_INVOICE := Query.FieldByName('FLG_ACNT_INVOICE').AsInteger = 1;
            AI^.FLG_SERVICE_QTY := Query.FieldByName('FLG_SERVICE_QTY').AsInteger = 1;
            AI^.FLG_ASSEMBLE := Query.FieldByName('FLG_ASSEMBLE').AsInteger = 1;
            AI^.FLG_ACHITARI := Query.FieldByName('FLG_ACHITARI').AsInteger = 1;
            AI^.FLG_DBL_JURNAL := Query.FieldByName('FLG_DBL_JURNAL').AsInteger = 1;
            AI^.OrderNo := Query.FieldByName('ORDERNO').AsInteger;
            AI^.FLG_ACCESS_VISIBLE := Query.FieldByName('FLG_ACCESS_VISIBLE').AsInteger = 1;
            AI^.FLG_UPR_UCET := Query.FieldByName('FLG_UPR_UCET').AsInteger = 1;
            AI^.FLG_BUH_UCET := Query.FieldByName('FLG_BUH_UCET').AsInteger = 1;

            AI^.HasModified := False;

            Node := cxTreeActions.AddChild(ParentNode);
            Node.Data := AI;
            Node.ImageIndex := 17;
            Node.SelectedIndex := 17;

            Node.Values[cxTreeActions_STRUCTMASK.Position.ColIndex] := AI^.StructMask;
            Node.Values[cxTreeActions_IMAGEINDEX.Position.ColIndex] := AI^.ImageIndex;
            Node.Values[cxTreeActions_FLG_ACCESS_VISIBLE.Position.ColIndex] := AI^.FLG_ACCESS_VISIBLE;

            Query.Next;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ReComputeOrderNo;
var
    Node, Node1, Node2: TcxTreeListNode;
    order, order1, order2: Integer;
    Data, Data1, Data2: PActionItem;
begin
    order := 0;
    Node := cxTreeActions.Root.getFirstChild;
    while (Node <> nil) do
    begin
        Data := PActionItem(Node.Data);
        Data^.OrderNo := order;

    // level 1
        order1 := 0;
        Node1 := Node.getFirstChild;
        while (Node1 <> nil) do
        begin
            Data1 := PActionItem(Node1.Data);
            Data1^.OrderNo := order1;

      // level 2
            order2 := 0;
            Node2 := Node1.getFirstChild;
            while (Node2 <> nil) do
            begin
                Data2 := PActionItem(Node2.Data);
                Data2^.OrderNo := order2;
                Inc(order2);
                Node2 := Node2.getNextSibling;
            end;

            Inc(order1);
            Node1 := Node1.getNextSibling;
        end;

        Inc(order);
        Node := Node.getNextSibling;
    end;
end;

function TfrmDocTypesEditorDlg.RemoveBadChars(const Text: string): string;
var
    i: Integer;
    Txt: string;
begin
    Result := '';

    Txt := Text.Replace('-', '_');
    for i := 1 to Length(Txt) do
        if not CharInSet(txt[i], ['(', ')', '"', '\', '/', ',', '.', '[', ']', '#', '%', '$', '-']) then
            Result := Result + Txt[i];
end;

procedure TfrmDocTypesEditorDlg.SaveActionTreeAsAppend;
var
    Query: TIBCQuery;
    i: Integer;
    Node, Node1, Node2: TcxTreeListNode;
    NodeData, Node1Data, Node2Data: PActionItem;
  // -------------------------------------------------------------------------------------

    procedure SaveNodeAsNew(const Data: PActionItem);
    begin
        Query.SQL.Text := 'SELECT DOCTYPEID FROM CREATE_NEW_DOCTYPE(' +
            ':PARENTID, :"STRUCT$MASK", :TITLE, :SHORTNAME, :FLG_ACTION, :TABSHEETINDEX, :IMAGEINDEX, :"ACC$FOLDERS", ' +
            ':FLG_MONEY, :FLG_INVOICE, :FLG_DEBTS, :FLG_SIGN, :FLG_TRANSFER, :FLG_ACNT_INVOICE, :FLG_SERVICE_QTY, ' +
            ':FLG_ASSEMBLE, :FLG_ACHITARI, :FLG_DBL_JURNAL, :ORDERNO, :FLG_ACCESS_VISIBLE)';

        Query.ParamByName('PARENTID').AsInteger := Data^.ParentID;
        Query.ParamByName('STRUCT$MASK').AsLargeInt := Data^.StructMask;
        Query.ParamByName('TITLE').AsString := Data^.Title;
        Query.ParamByName('SHORTNAME').AsString := Data^.ShortName;
        Query.ParamByName('FLG_ACTION').AsInteger := Ord(Data^.IsAction);
        Query.ParamByName('TABSHEETINDEX').AsInteger := Data^.TabSheetIndex;
        Query.ParamByName('IMAGEINDEX').AsInteger := Data^.ImageIndex;
        Query.ParamByName('ACC$FOLDERS').AsLargeInt := Data^.AccFolders;

        Query.ParamByName('FLG_MONEY').AsInteger := Ord(Data^.FLG_MONEY);
        Query.ParamByName('FLG_DEBTS').AsInteger := Ord(Data^.FLG_DEBTS);
        Query.ParamByName('FLG_INVOICE').AsInteger := Ord(Data^.FLG_INVOICE);
        Query.ParamByName('FLG_SIGN').AsInteger := Ord(Data^.FLG_SIGN);
        Query.ParamByName('FLG_TRANSFER').AsInteger := Ord(Data^.FLG_TRANSFER);
        Query.ParamByName('FLG_ACNT_INVOICE').AsInteger := Ord(Data^.FLG_ACNT_INVOICE);
        Query.ParamByName('FLG_SERVICE_QTY').AsInteger := Ord(Data^.FLG_SERVICE_QTY);
        Query.ParamByName('FLG_ASSEMBLE').AsInteger := Ord(Data^.FLG_ASSEMBLE);
        Query.ParamByName('FLG_ACHITARI').AsInteger := Ord(Data^.FLG_ACHITARI);
        Query.ParamByName('FLG_DBL_JURNAL').AsInteger := Ord(Data^.FLG_DBL_JURNAL);
//    Query.ParamByName('FLG_UPR_UCET').AsInteger := Ord(Data^.FLG_UPR_UCET);
//    Query.ParamByName('FLG_BUH_UCET').AsInteger := Ord(Data^.FLG_BUH_UCET);

        Query.ParamByName('ORDERNO').AsInteger := Data^.OrderNo;
        Query.ParamByName('FLG_ACCESS_VISIBLE').AsInteger := Ord(Data^.FLG_ACCESS_VISIBLE);

        Query.ExecSQL;
        Data^.ID := Query.Fields[0].AsInteger;
        Query.Close;
    end;
// -------------------------------------------------------------------------------------

    procedure SaveNodeAsUpdate(const Data: PActionItem);
    begin
        Query.SQL.Text :=
            'UPDATE VW_TS_DOCTYPES SET STRUCT$MASK=:"STRUCT$MASK", TITLE=:TITLE, SHORTNAME=:SHORTNAME,' + ' PARENTID=:PARENTID, TABSHEETINDEX=:TABSHEETINDEX, IMAGEINDEX=:IMAGEINDEX,'
            + ' FLG_MONEY=:FLG_MONEY, FLG_INVOICE=:FLG_INVOICE, FLG_DEBTS=:FLG_DEBTS, FLG_SIGN=:FLG_SIGN, FLG_TRANSFER=:FLG_TRANSFER,'
            + ' FLG_ACNT_INVOICE=:FLG_ACNT_INVOICE, FLG_SERVICE_QTY=:FLG_SERVICE_QTY, FLG_ASSEMBLE=:FLG_ASSEMBLE, FLG_ACHITARI=:FLG_ACHITARI,'
            + ' FLG_DBL_JURNAL=:FLG_DBL_JURNAL, ORDERNO=:ORDERNO, FLG_ACCESS_VISIBLE=:FLG_ACCESS_VISIBLE, ' +
            ' FLG_UPR_UCET=:FLG_UPR_UCET, FLG_BUH_UCET = :FLG_BUH_UCET' + ' WHERE (DOCTYPEID=:DOCTYPEID)';

        Query.ParamByName('STRUCT$MASK').AsLargeInt := Data^.StructMask;
        Query.ParamByName('TITLE').AsString := Data^.Title;
        Query.ParamByName('SHORTNAME').AsString := Data^.ShortName;
        Query.ParamByName('TABSHEETINDEX').AsInteger := Data^.TabSheetIndex;
        Query.ParamByName('IMAGEINDEX').AsInteger := Data^.ImageIndex;
        Query.ParamByName('PARENTID').AsInteger := Data^.ParentID;

        Query.ParamByName('FLG_MONEY').AsInteger := Ord(Data^.FLG_MONEY);
        Query.ParamByName('FLG_DEBTS').AsInteger := Ord(Data^.FLG_DEBTS);
        Query.ParamByName('FLG_INVOICE').AsInteger := Ord(Data^.FLG_INVOICE);
        Query.ParamByName('FLG_SIGN').AsInteger := Ord(Data^.FLG_SIGN);
        Query.ParamByName('FLG_TRANSFER').AsInteger := Ord(Data^.FLG_TRANSFER);
        Query.ParamByName('FLG_ACNT_INVOICE').AsInteger := Ord(Data^.FLG_ACNT_INVOICE);
        Query.ParamByName('FLG_SERVICE_QTY').AsInteger := Ord(Data^.FLG_SERVICE_QTY);
        Query.ParamByName('FLG_ASSEMBLE').AsInteger := Ord(Data^.FLG_ASSEMBLE);
        Query.ParamByName('FLG_ACHITARI').AsInteger := Ord(Data^.FLG_ACHITARI);
        Query.ParamByName('FLG_DBL_JURNAL').AsInteger := Ord(Data^.FLG_DBL_JURNAL);
        Query.ParamByName('FLG_UPR_UCET').AsInteger := Ord(Data^.FLG_UPR_UCET);
        Query.ParamByName('FLG_BUH_UCET').AsInteger := Ord(Data^.FLG_BUH_UCET);

        Query.ParamByName('ORDERNO').AsInteger := Data^.OrderNo;

        Query.ParamByName('FLG_ACCESS_VISIBLE').AsInteger := Ord(Data^.FLG_ACCESS_VISIBLE);

        Query.ParamByName('DOCTYPEID').AsInteger := Data^.ID;

        Query.ExecSQL;
        Query.Close;
    end;

begin
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;

        try
            Query.Transaction.StartTransaction;

            if (fDeletedItems.Count > 0) then
            begin
        // 1. delete deleted items
                Query.SQL.Text := 'DELETE FROM VW_TS_DOCTYPES WHERE (DOCTYPEID=:DOCTYPEID)';
                for i := 0 to fDeletedItems.Count - 1 do
                begin
                    NodeData := PActionItem(fDeletedItems[i]);
                    Query.ParamByName('DOCTYPEID').AsInteger := NodeData^.ID;
                    Query.ExecSQL;
                end;
            end;

      // 2. update or create new nodes
            Node := cxTreeActions.Root.getFirstChild;
            while Node <> nil do
            begin
        // Level 0
                NodeData := PActionItem(Node.Data);
                if NodeData^.ID = -1 then
                    SaveNodeAsNew(NodeData)
                else if NodeData^.HasModified then
                    SaveNodeAsUpdate(NodeData);

                Node1 := Node.getFirstChild;
                while Node1 <> nil do
                begin
          // Level 1
                    Node1Data := PActionItem(Node1.Data);
                    if Node1Data^.ID = -1 then
                    begin
                        Node1Data^.ParentID := NodeData^.ID;
                        SaveNodeAsNew(Node1Data);
                    end
                    else if Node1Data^.HasModified then
                        SaveNodeAsUpdate(Node1Data);

                    Node2 := Node1.getFirstChild;
                    while Node2 <> nil do
                    begin
            // Level 2
                        Node2Data := PActionItem(Node2.Data);
                        if Node2Data^.ID = -1 then
                        begin
                            Node2Data^.ParentID := Node1Data^.ID;
                            SaveNodeAsNew(Node2Data);
                        end
                        else if Node2Data^.HasModified then
                            SaveNodeAsUpdate(Node2Data);

                        Node2 := Node2.getNextSibling;
                    end;
                    Node1 := Node1.getNextSibling;
                end;
                Node := Node.getNextSibling;
            end;

            Query.Transaction.Commit;
        except
            Query.Transaction.Rollback;
            raise;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.SaveActionTreeAsNew;
var
    Query: TIBCQuery;
    i, N: Integer;
begin
  // salveaza copacul de la zero.
  // >> sterge toate datele existente si inscrie copacul din nou
  // 1. pentru mape, ID-uri dela 1-100
  // 2. pentru documente, ID-uri dela 100-1000
  // 3. pentru actiuni, ID-uri dela 1000-..
    Query := TIBCQuery.Create(nil);
    try
        Query.Connection := dmDB.IBCConnection;
        Query.Transaction := dmDB.IBCTrDefaultUpdate;

        try
            Query.Transaction.StartTransaction;

      // Deleted old items
            Query.SQL.Text := 'DELETE FROM VW_TS_DOCTYPES WHERE DOCTYPEID>=0';
            Query.ExecSQL;

      // 2. Insert tree, level by level
            for i := 0 to 2 do
            begin
                case i of
                    0:
                        N := 0;
                    1:
                        N := 100;
                else
                    N := 1000;
                end;

                Query.SQL.Text := 'ALTER SEQUENCE SQ_TS_DOCTYPES_DOCTYPEID RESTART WITH ' + IntToStr(N);
                Query.ExecSQL;

                Query.SQL.Text :=
                    'SELECT DOCTYPEID FROM CREATE_NEW_DOCTYPE(:PARENTID,:"STRUCT$MASK",:TITLE,:SHORTNAME,:FLG_ACTION,:TABSHEETINDEX,:IMAGEINDEX,:"ACC$FOLDERS",' +
                    ':FLG_MONEY,:FLG_DEBTS,:FLG_INVOICE,:FLG_SIGN,:FLG_TRANSFER,:FLG_ACNT_INVOICE, :FLG_SERVICE_QTY,:FLG_ASSEMBLE,:FLG_ACHITARI,:FLG_DBL_JURNAL)';
                ScanTreeLevelForSaveAs(Query, i);
                Query.Close;
            end;
            Query.Transaction.Commit;
        except
            Query.Transaction.Rollback;
            raise;
        end;
    finally
        Query.Free;
    end;
end;

procedure TfrmDocTypesEditorDlg.ScanActionsTree;
begin
    cxTreeActions.BeginUpdate;
    try
        ReadLevel0Items;
    finally
        cxTreeActions.EndUpdate;
    end;
end;

procedure TfrmDocTypesEditorDlg.ScanTreeLevelForSaveAs(const Query: TIBCQuery; const Level: Integer);

    procedure InsertRecord(const Data: PActionItem);
    begin
        Query.ParamByName('PARENTID').AsInteger := Data^.ParentID;
        Query.ParamByName('STRUCT$MASK').AsLargeInt := Data^.StructMask;
        Query.ParamByName('TITLE').AsString := Data^.Title;
        Query.ParamByName('SHORTNAME').AsString := Data^.ShortName;
        Query.ParamByName('FLG_ACTION').AsInteger := Ord(Data^.IsAction);
        Query.ParamByName('ACC$FOLDERS').AsLargeInt := Data^.AccFolders;

        if Level = 2 then
        begin
            Query.ParamByName('TABSHEETINDEX').AsInteger := -1;
            Query.ParamByName('IMAGEINDEX').AsInteger := -1;
        end
        else
        begin
            Query.ParamByName('TABSHEETINDEX').AsInteger := Data^.TabSheetIndex;
            Query.ParamByName('IMAGEINDEX').AsInteger := Data^.ImageIndex;
        end;

        if Level = 1 then
        begin
            Query.ParamByName('FLG_MONEY').AsInteger := Ord(Data^.FLG_MONEY);
            Query.ParamByName('FLG_DEBTS').AsInteger := Ord(Data^.FLG_DEBTS);
            Query.ParamByName('FLG_INVOICE').AsInteger := Ord(Data^.FLG_INVOICE);
            Query.ParamByName('FLG_SIGN').AsInteger := Ord(Data^.FLG_SIGN);
            Query.ParamByName('FLG_TRANSFER').AsInteger := Ord(Data^.FLG_TRANSFER);
            Query.ParamByName('FLG_SERVICE_QTY').AsInteger := Ord(Data^.FLG_SERVICE_QTY);
            Query.ParamByName('FLG_ASSEMBLE').AsInteger := Ord(Data^.FLG_ASSEMBLE);
            Query.ParamByName('FLG_ACHITARI').AsInteger := Ord(Data^.FLG_ACHITARI);
            Query.ParamByName('FLG_DBL_JURNAL').AsInteger := Ord(Data^.FLG_DBL_JURNAL);
            Query.ParamByName('FLG_UPR_UCET').AsInteger := Ord(Data^.FLG_UPR_UCET);
            Query.ParamByName('FLG_BUH_UCET').AsInteger := Ord(Data^.FLG_BUH_UCET);

        end
        else
        begin
            Query.ParamByName('FLG_MONEY').AsInteger := 0;
            Query.ParamByName('FLG_INVOICE').AsInteger := 0;
            Query.ParamByName('FLG_DEBTS').AsInteger := 0;
            Query.ParamByName('FLG_SIGN').AsInteger := 0;
            Query.ParamByName('FLG_TRANSFER').AsInteger := 0;
            Query.ParamByName('FLG_SERVICE_QTY').AsInteger := 0;
            Query.ParamByName('FLG_ASSEMBLE').AsInteger := 0;
            Query.ParamByName('FLG_ACHITARI').AsInteger := 0;
            Query.ParamByName('FLG_DBL_JURNAL').AsInteger := 0;
            Query.ParamByName('FLG_UPR_UCET').AsInteger := Ord(Data^.FLG_UPR_UCET);
            Query.ParamByName('FLG_BUH_UCET').AsInteger := Ord(Data^.FLG_BUH_UCET);

        end;

        Query.ExecSQL;
        Data^.ID := Query.Fields[0].AsInteger;
    end;

var
    Node, Node1, Node2: TcxTreeListNode;
    i, j, k: Integer;
    Data, DataParent: PActionItem;
begin

    for i := 0 to cxTreeActions.Count - 1 do
    begin
        Node := cxTreeActions.Items[i];
        if (Node.Level = Level) then // Level 0
        begin
            Data := PActionItem(Node.Data);
            InsertRecord(Data);
        end
        else
            for j := 0 to Node.Count - 1 do
            begin
                Node1 := Node.Items[j];
                if (Node1.Level = Level) then // Level 1
                begin
                    DataParent := PActionItem(Node.Data);
                    Data := PActionItem(Node1.Data);
          // take values from parent
                    Data^.ParentID := DataParent^.ID;
                    InsertRecord(Data);
                end
                else
                    for k := 0 to Node1.Count - 1 do
                    begin
                        Node2 := Node1.Items[k];
                        if (Node2.Level = Level) then // Level 2
                        begin
                            DataParent := PActionItem(Node1.Data);
                            Data := PActionItem(Node2.Data);
                            Data^.ParentID := DataParent^.ID;
                            InsertRecord(Data);
                        end;
                    end;
            end;
    end;
end;

procedure TfrmDocTypesEditorDlg.SelectedActionChanged;
var
    f0, f1, f2, f, f3, f4: Boolean;
    Node: TcxTreeListNode;
    DataL1: PActionItem;
begin
    f0 := True;
    f1 := False;
    f2 := False;
    f := False;
    f3 := False;
    f4 := False;

    if Assigned(cxTreeActions.FocusedNode) then
    begin
        f := True;
        Node := cxTreeActions.FocusedNode;
        f0 := Node.Level = 0;
        f1 := Node.Level = 1;
        f2 := Node.Level = 2;

        f3 := not Node.IsFirst;
        f4 := not Node.IsLast;
    end;

    bbSecNewArea.Enabled := f0;
    bbSecNewItem.Enabled := f1 or (f0 and f);
    bbSecNewAction.Enabled := f2 or f1;

    bbSecModify.Enabled := f;
    bbSecDelete.Enabled := f;

    bbMoveUp.Enabled := f3;
    bbMoveDown.Enabled := f4;

    if f1 then
    begin
        DataL1 := cxTreeActions.FocusedNode.Data;
        if DataL1^.ID > 0 then
        begin
            bbDocAnalytics.Enabled := True;
            bbDocDefaults.Enabled := True;
        end
        else
        begin
            bbDocAnalytics.Enabled := False;
            bbDocDefaults.Enabled := False;
        end;
    end
    else
    begin
        bbDocAnalytics.Enabled := False;
        bbDocDefaults.Enabled := False;
    end;
end;

procedure TfrmDocTypesEditorDlg.SelectedFilterVisibility;
var
    Node: TcxTreeListNode;
    Prop: TcxCheckComboBoxProperties;
    i: Integer;
    parentBits: int64;
begin
    Node := cxTreeActions.FocusedNode;
    if Assigned(Node) then
    begin
        Prop := TcxCheckComboBoxProperties(cxTreeActions.Columns[1].Properties);
        if (Node.Level = 0) then
        begin
      // enable all flags
            for i := 0 to Prop.Items.Count - 1 do
                Prop.Items[i].Enabled := True;
        end
        else if (Node.Level = 1) then
        begin
      // disable items not selected in parent visibility flags
            parentBits := Node.Parent.Values[1];
            for i := 0 to Prop.Items.Count - 1 do
            begin
                Prop.Items[i].Enabled := ((parentBits shr Prop.Items[i].Tag) and 1) = 1;
            end;
        end;
    end;
end;

procedure TfrmDocTypesEditorDlg.SetupSecurityItems;
begin
    if not SWNSecurityManager.LoggedUser.IsSuperAdminUser then
    begin
        if not SecurityFlagEnabled(cSecurityFlag_Администрирование_ТД_Создать) then
        begin
            bbSecNewArea.Visible := ivNever;
            bbSecNewItem.Visible := ivNever;
            bbSecNewAction.Visible := ivNever;
        end;

        if not SecurityFlagEnabled(cSecurityFlag_Администрирование_ТД_Редактировать) then
        begin
            bbSecModify.Visible := ivNever;
            bbMoveUp.Visible := ivNever;
            bbMoveDown.Visible := ivNever;
            bbSubAdditional.Visible := ivNever;
        end;

        if not SecurityFlagEnabled(cSecurityFlag_Администрирование_ТД_Удалить) then
        begin
            bbSecDelete.Visible := ivNever;
        end;
    end;

    if dxBarManagerBar1.ItemLinks.VisibleItemCount = 0 then
    begin
        dxBarManagerBar1.Visible := False;
        dxBarDockControl3.Visible := False;
    end;

    if pmActions.ItemLinks.VisibleItemCount = 0 then
        cxTreeActions.PopupMenu := nil;

end;

procedure TfrmDocTypesEditorDlg.GetStructureItemsForArea(const CheckListBox: TcxCheckListBox);
var
    cb: TcxCheckComboBoxItem;
    cb2: TcxCheckListBoxItem;
    VisibleColumnProp: TcxCheckComboBoxProperties;
    i: Integer;
begin
    CheckListBox.Items.BeginUpdate;
    try
        CheckListBox.Items.Clear;
        VisibleColumnProp := TcxCheckComboBoxProperties(cxTreeActions.Columns[1].Properties);

        for i := 0 to VisibleColumnProp.Items.Count - 1 do
        begin
            cb := VisibleColumnProp.Items[i];

            cb2 := CheckListBox.Items.Add;
            cb2.Tag := cb.Tag;
            cb2.Text := cb.Description;
        end;

    finally
        CheckListBox.Items.EndUpdate;
    end;
end;

procedure TfrmDocTypesEditorDlg.GetStructureItemsForElement(const Node: TcxTreeListNode; const CheckListBox:
    TcxCheckListBox);
var
    cb: TcxCheckComboBoxItem;
    cb2: TcxCheckListBoxItem;
    VisibleColumnProp: TcxCheckComboBoxProperties;
    i: Integer;
    Data: PActionItem;
begin
    Data := Node.Data;

    CheckListBox.Items.BeginUpdate;
    try
        CheckListBox.Items.Clear;
        VisibleColumnProp := TcxCheckComboBoxProperties(cxTreeActions.Columns[1].Properties);

        for i := 0 to VisibleColumnProp.Items.Count - 1 do
        begin
            cb := VisibleColumnProp.Items[i];

            cb2 := CheckListBox.Items.Add;
            cb2.Tag := cb.Tag; // bit
            cb2.Text := cb.Description;
            cb2.Enabled := ((Data^.StructMask shr cb.Tag) and 1) = 1;
        end;

    finally
        CheckListBox.Items.EndUpdate;
    end;
end;

end.


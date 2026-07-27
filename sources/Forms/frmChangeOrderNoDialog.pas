unit frmChangeOrderNoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, ImgList,
  Dialogs, DialogTitle, cxTL, dxBar,
  DB, DBAccess, IBC, StdCtrls, ExtCtrls, cxInplaceContainer,

  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData, cxStyles,
  dxScrollbarAnnotations, cxTextEdit, cxLabel, cxTLdxBarBuiltInMenu, Vcl.Menus, cxClasses, MemDS,
  cxFilter;

type
  TChangeOrderTable = (cotGOODS, cotGOODS_COMPATIBLE, cotGOODSACNT, cotCUSTOMERS, cotREPORTS,
    cotReportGroups, cosCOMPLECTE, cosKIT, cosGoodsDescriptions, cosWebFiltersParams, cotWebCatalog,
    cotWebCatalogGoods, cosWebCatalogFilters, cosDescriptionTemplate, cosDescriptionTemplateStruct,
    cotFilters, cotFiltersFolders, cosWebDeliveryFirms, cotWebActiuni, cotSERVICE_Scop,
    cosNPSCBaseParamTemplate, cosNPSCAddParamsTemplate, cotGoodsBonus2, cotSqlRepository,
    cotPacheteProduse, cotPacheteProduseContinut);

  TfrmChangeOrderNoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxTree: TcxTreeList;
    cxTree_ID: TcxTreeListColumn;
    cxTree_TITLE: TcxTreeListColumn;
    IBCQuery: TIBCQuery;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbMoveUp: TdxBarButton;
    bbMoveDown: TdxBarButton;
    bbSortAscending: TdxBarButton;
    bbSortDescending: TdxBarButton;
    dxBarPopupMenu: TdxBarPopupMenu;
    bbMoveTop: TdxBarButton;
    bbMoveBottom: TdxBarButton;
    pnBottom: TPanel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure cxTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cxTreeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure btnOkClick(Sender: TObject);
    procedure cxTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bbMoveUpClick(Sender: TObject);
    procedure bbMoveDownClick(Sender: TObject);
    procedure bbSortAscendingClick(Sender: TObject);
    procedure bbSortDescendingClick(Sender: TObject);
    procedure bbMoveTopClick(Sender: TObject);
    procedure bbMoveBottomClick(Sender: TObject);
    procedure cxTreeMoveTo(Sender: TcxCustomTreeList; AttachNode: TcxTreeListNode; AttachMode:
      TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean);
    procedure cxTreeFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode, AFocusedNode:
      TcxTreeListNode);
  private
    { Private declarations }
    fTransaction: TIBCTransaction;
    fChanged: Boolean;
    FParentID: Integer;
    FDBTable: TChangeOrderTable;
    fInternalTransaction: Boolean;
    fWhereParam: string;
    procedure SetParentID(const Value: Integer);
    procedure SetDBTable(const Value: TChangeOrderTable);
    procedure SelectionChanged;
    function ProcessSQLTags(const SQLText: string): string;
    procedure ReadFolders;
    function SaveFolders: Boolean;
    procedure MoveItem(const Dir: Integer);
    procedure cxTreeCompareASC(Sender: TcxCustomTreeList; ANode1, ANode2: TcxTreeListNode; var
      ACompare: Integer);
    procedure cxTreeCompareDSC(Sender: TcxCustomTreeList; ANode1, ANode2: TcxTreeListNode; var
      ACompare: Integer);
    procedure DoSortItems(const Ascending: Boolean);
    procedure SetWhereParam(const Value: string);
  protected
    { protected declarations }
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    constructor Create(const AOwner: TComponent; const Transaction: TIBCTransaction = nil); reintroduce;
    destructor Destroy; override;
    property DBTable: TChangeOrderTable read FDBTable write SetDBTable;
    property ParentID: Integer read FParentID write SetParentID;
    property WhereParam: string read fWhereParam write SetWhereParam;
  end;

implementation

uses
  SWNUtils, SWNValueStorageUnit, DataModuleDB;

{$R *.dfm}

type
  TDBTableFieldsInfoRec = record
    DBTable: string;
    IDField: string;
    TitleField: string;
    ParentField: string;
    ImageIndexField: string;
    DialogTitle: string;
    CustomWHERE: string;
    ConfirmationQuestion: string;
  end;

const
  cDBTableFieldsInfo: array[TChangeOrderTable] of TDBTableFieldsInfoRec = ((
    DBTable: 'TS_GOODS';
    IDField: 'GOODSID';
    TitleField: 'TITLE';
    ParentField: 'PARENTID';
    ImageIndexField: '13';
    DialogTitle: 'Sortarea mapelor';
    CustomWHERE: 'FLG_FOLDER=1';
    ConfirmationQuestion: 'Modifica ordinea de sortarea a mapelor?'
  ), (
    DBTable: 'VW_TS_GOODS_COMPATIBLE';
    IDField: 'COMPATIBLE_GOODSID';
    TitleField: 'COMPATIBLE_GOODS_NAME';
    ParentField: 'GOODSID';
    ImageIndexField: 'COMPATIBLE_GOODS_TYPE_ID';
    DialogTitle: 'Sortarea produselor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica sortarea produselor?'
  ), (
    DBTable: 'TS_GOODS_ACNT';
    IDField: 'GOODS_ACNT_ID';
    TitleField: 'NAMEACNT';
    ParentField: 'PARENTID';
    ImageIndexField: '13';
    DialogTitle: 'Sortarea mapelor';
    CustomWHERE: 'FLG_FOLDER=1';
    ConfirmationQuestion: 'Modifica sortarea mapelor'
  ), (
    DBTable: 'VW_TS_CUSTOMER';
    IDField: 'CUSTOMERID';
    TitleField: 'DISPLAYNAME';
    ParentField: 'PARENTID';
    ImageIndexField: '13';
    DialogTitle: 'Sortarea mapelor';
    CustomWHERE: 'FLG_FOLDER=1';
    ConfirmationQuestion: 'Modifica sortarea mapelor?'
  ), (
    DBTable: 'VW_TS_REPORTS';
    IDField: 'REPORTID';
    TitleField: 'TITLE';
    ParentField: 'DOCTYPEID';
    ImageIndexField: '14';
    DialogTitle: 'Sortarea rapoartelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea rapoartelor?'
  ), (
    DBTable: 'TS_REPORT_GROUPS';
    IDField: 'REPORTGROUPID';
    TitleField: 'TITLE';
    ParentField: '';
    ImageIndexField: '14';
    DialogTitle: 'Sortarea grupelor de rapoarte';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea grupelor de rapoarte?'
  ), (
    DBTable: 'VW_TS_COMPLECTE';
    IDField: 'GOODSID';
    TitleField: 'GOODS_TITLE';
    ParentField: 'PARENTGOODS_ID';
    ImageIndexField: 'GOODS_TYPE_ID';
    DialogTitle: 'Sortarea produselor din complect';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea din complect?'
  ), (
    DBTable: 'VW_TS_KIT_TEMPLATE_ITEMS';
    IDField: 'GOODSID';
    TitleField: 'GOODS_NAME';
    ParentField: 'KITTEMPLATEID';
    ImageIndexField: 'GOODS_TYPE_ID';
    DialogTitle: 'Sortarea produselor in oferte';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de sortare in oferte?'
  ), (
    DBTable: 'TS_GOODS_DESCRIPTIONS';
    IDField: 'DESCRIPTIONID';
    TitleField:
      '(SELECT FILTERNAME_RUS || '' - '' || (SELECT PARAM_VALUE_RUS FROM TS_FILTER_PARAMS WHERE TS_FILTER_PARAMS.FILTERID=TS_GOODS_DESCRIPTIONS.FILTERID AND TS_FILTER_PARAMS.FILTERPARAMID = TS_GOODS_DESCRIPTIONS.FILTERPARAMID )' +
      ' FROM TS_FILTERS WHERE TS_FILTERS.FILTERID=TS_GOODS_DESCRIPTIONS.FILTERID)';
    ParentField: 'GOODSID';
    ImageIndexField: '26';
    DialogTitle: 'Sortarea caracteristicilor produselor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de sortare a caracteristicilor produselor?'
  ), (
    DBTable: 'TS_FILTER_PARAMS';
    IDField: 'FILTERPARAMID';
    TitleField: 'PARAM_VALUE';
    ParentField: 'FILTERID';
    ImageIndexField: '26';
    DialogTitle: 'Sortarea valorilor filtrelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea sortarii valorilor filtrelor?'
  ), (
    DBTable: 'TWEB_CATALOG';
    IDField: 'CATALOGID';
    TitleField: 'TITLE';
    ParentField: 'PARENTID';
    ImageIndexField: '13';
    DialogTitle: 'Sortare mape Web-Catalog';
    CustomWHERE: 'DT=$PARAM';
    ConfirmationQuestion: 'Modifica sortarea mapelor in Web-Catalot?'
  ), (
    DBTable: 'TWEB_CATALOG_ITEMS';
    IDField: 'GOODSPARENTID';
    TitleField: '(SELECT DETAILS FROM TS_GOODS WHERE GOODSID=GOODSPARENTID)';
    ParentField: 'CATALOGID';
    ImageIndexField: '12';
    DialogTitle: 'Sortare mape produse in Web Catalog';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea sortarii mapelor produselor in Web-Catalog?'
  ), (
    DBTable: 'TWEB_CATALOG_FILTERS';
    IDField: 'FILTERID';
    TitleField: '(SELECT FILTERNAME FROM TS_FILTERS WHERE TS_FILTERS.FILTERID=TWEB_CATALOG_FILTERS.FILTERID)';
    ParentField: 'CATALOGID';
    ImageIndexField: '12';
    DialogTitle: 'Sortare mape produse in Web Catalog';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica sortarea filtrelor in Web Catalog?'
  ),


    (
    DBTable: 'TS_DESCRIPTION_TEMPLATES';
    IDField: 'TEMPLATEID';
    TitleField: 'TITLE_RUS';
    ParentField: '';
    ImageIndexField: '12';
    DialogTitle: 'Sortarea sablonelor de descriere';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de sortare a sabloanelor de descriere?'
  ), (
    DBTable: 'TS_DESCRIPTION_TEMPLATE_INFO';
    IDField: 'STRUCTID';
    TitleField:
      '(SELECT FILTERNAME_RUS || '' - '' || (SELECT PARAM_VALUE_RUS FROM TS_FILTER_PARAMS WHERE TS_FILTER_PARAMS.FILTERID=TS_DESCRIPTION_TEMPLATE_INFO.FILTERID AND TS_FILTER_PARAMS.FILTERPARAMID = TS_DESCRIPTION_TEMPLATE_INFO.FILTERPARAMID )' +
      ' FROM TS_FILTERS WHERE TS_FILTERS.FILTERID=TS_DESCRIPTION_TEMPLATE_INFO.FILTERID)';
    ParentField: 'TEMPLATEID';
    ImageIndexField: '12';
    DialogTitle: 'Sortarea caracteristicilor in sabloanele de descriere';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea sortarii caracteristicilor in sabloanele de descriere?'
  ), (
    DBTable: 'TS_FILTERS';
    IDField: 'FILTERID';
    TitleField: 'FILTERNAME';
    ParentField: 'PARENTID';
    ImageIndexField: '26';
    DialogTitle: 'Sortarea filtrelor';
    CustomWHERE: 'FLG_FOLDER=0';
    ConfirmationQuestion: 'Modifica ordinea sortarii filtrelor?'
  ), (
    DBTable: 'TS_FILTERS';
    IDField: 'FILTERID';
    TitleField: 'FILTERNAME';
    ParentField: 'PARENTID';
    ImageIndexField: '13';
    DialogTitle: 'Sortarea filtrelor';
    CustomWHERE: 'FLG_FOLDER=1';
    ConfirmationQuestion: 'Modifica ordinea soratarii filtrelor?'
  ), (
    DBTable: 'TWEB_DELIVERY_FIRMS';
    IDField: 'CUSTOMERID';
    TitleField: 'TITLE_RUS';
    ParentField: 'NULL';
    ImageIndexField: '26';
    DialogTitle: 'Sortarea companiilor de transport';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica sortarea companiilor de transport?'
  ), (
    DBTable: 'TWEB_ACTIUNI';
    IDField: 'ACTIUNEID';
    TitleField: 'TITLE_RUS || '' ('' || START_DATE || '' - '' || END_DATE || '')''';
    ParentField: 'NULL';
    ImageIndexField: '26';
    DialogTitle: 'Sortarea actiunilor web';
    CustomWHERE: 'DT=$PARAM';
    ConfirmationQuestion: 'Modifica sortarea actiunilor web?'
  ), (
    DBTable: 'SC_REF_INCIDENT_SCOP';
    IDField: 'SCOPID';
    TitleField: 'TITLE';
    ParentField: 'PARENTID';
    ImageIndexField: 'IIF(FLG_FOLDER=1,1,58)';
    DialogTitle: 'Sortarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea sortarii elementelor?'
  ),

    // cosNPSCBaseParamTemplate
    (
    DBTable: 'NGS_NAM1_PARAMS';
    IDField: 'ID';
    TitleField: 'PARAM_NAME_RUS';
    ParentField: 'GOODSTYPEID';
    ImageIndexField: '50';
    DialogTitle: 'Aranjarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elementelor?'
  ),

    // cosNPSCAddParamsTemplate
    (
    DBTable: 'NGS_NAM2_PARAMS';
    IDField: 'ID';
    TitleField: 'PARAM_NAME_RUS';
    ParentField: 'GOODSTYPEID';
    ImageIndexField: '50';
    DialogTitle: 'Sortarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elementelor?'
  ),

    // cotGoodsBonus2
    (
    DBTable: 'TDB_GOODS_BONUS2';
    IDField: 'GBONUSID';
    TitleField: 'TITLE || '' ('' || BONUS_POINTS || '')''';
    ParentField: '';
    ImageIndexField: '58';
    DialogTitle: 'Aranjarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elemetelor?'
  ),

    // cotSqlRepository
    (
    DBTable: 'TDB_SQL_REPOSITORY';
    IDField: 'ID';
    TitleField: 'TITLE';
    ParentField: '';
    ImageIndexField: '58';
    DialogTitle: 'Sortarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elemetelor?'
  ),

    // cotPacheteProduse
    (
    DBTable: 'TWEB_PACHETE_PRODUSE';
    IDField: 'PACHET_ID';
    TitleField: 'TITLU';
    ParentField: '';
    ImageIndexField: '58';
    DialogTitle: 'Sortarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elemetelor??'
  ),
    // cotPacheteProduseContinut
    (
    DBTable: 'TWEB_PACHET_CONTINUT';
    IDField: 'GOODS_ID';
    TitleField: '(SELECT TITLE FROM TS_GOODS WHERE GOODSID=GOODS_ID)';
    ParentField: 'PACHET_ID';
    ImageIndexField: '58';
    DialogTitle: 'Sortarea elementelor';
    CustomWHERE: '';
    ConfirmationQuestion: 'Modifica ordinea de aranjare a elemetelor??'
  ));
  cSQL_SELECT =
    'SELECT <ID>,<TITLE>,<IMAGEINDEX> FROM <TABLE> WHERE (<PARENT>=:ParentID) <CUSTOMWHERE> ORDER BY ORDERNO';
  cSQL_SELECT_NULL = 'SELECT <ID>,<TITLE>,<IMAGEINDEX> FROM <TABLE> <CUSTOMWHERE> ORDER BY ORDERNO';
  cSQL_UPDATE = 'UPDATE <TABLE> SET ORDERNO=:OrderNo WHERE (<PARENT>=:ParentID) AND (<ID>=:ObjectID)';
  cSQL_UPDATE_NULL = 'UPDATE <TABLE> SET ORDERNO=:OrderNo WHERE (<ID>=:ObjectID)';

  { TfrmChangeOrderNoDlg }

procedure TfrmChangeOrderNoDlg.bbMoveBottomClick(Sender: TObject);
begin
  MoveItem(4);
end;

procedure TfrmChangeOrderNoDlg.bbMoveDownClick(Sender: TObject);
begin
  MoveItem(2);
end;

procedure TfrmChangeOrderNoDlg.bbMoveTopClick(Sender: TObject);
begin
  MoveItem(3);
end;

procedure TfrmChangeOrderNoDlg.bbMoveUpClick(Sender: TObject);
begin
  MoveItem(1);
end;

procedure TfrmChangeOrderNoDlg.bbSortAscendingClick(Sender: TObject);
begin
  DoSortItems(True);
end;

procedure TfrmChangeOrderNoDlg.btnOkClick(Sender: TObject);
begin
  if fChanged then
  begin
    if (ShowAskDialog(cDBTableFieldsInfo[FDBTable].DialogTitle, cDBTableFieldsInfo[FDBTable].ConfirmationQuestion)
      = mrYes) then
    begin
      SaveFolders;
      ModalResult := mrOk;
    end;
  end
  else
    ModalResult := mrCancel;
end;

constructor TfrmChangeOrderNoDlg.Create(const AOwner: TComponent; const Transaction: TIBCTransaction);
begin
  inherited Create(AOwner);

  FParentID := -1;
  fChanged := False;
  fInternalTransaction := False;

  if Assigned(Transaction) then
    IBCQuery.Transaction := Transaction
  else
  begin
    fTransaction := TIBCTransaction.Create(self);
    fTransaction.DefaultConnection := dmDB.IBCConnection;
    IBCQuery.Transaction := fTransaction;
    fInternalTransaction := True;
  end;
end;

procedure TfrmChangeOrderNoDlg.cxTreeCompareASC(Sender: TcxCustomTreeList; ANode1, ANode2:
  TcxTreeListNode; var ACompare: Integer);
begin
  ACompare := WideCompareText(ANode1.Texts[0], ANode2.Texts[0])
end;

procedure TfrmChangeOrderNoDlg.cxTreeCompareDSC(Sender: TcxCustomTreeList; ANode1, ANode2:
  TcxTreeListNode; var ACompare: Integer);
begin
  ACompare := -WideCompareText(ANode1.Texts[0], ANode2.Texts[0])
end;

procedure TfrmChangeOrderNoDlg.cxTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  tmpNode: TcxTreeListNode;
begin
  tmpNode := cxTree.GetNodeAt(X, Y);
  if Assigned(cxTree.DragNode) and Assigned(tmpNode) then
  begin
    // DragNode above tmpNode
    cxTree.DragNode.MoveTo(tmpNode, tlamInsert);
    fChanged := True;
  end;
end;

procedure TfrmChangeOrderNoDlg.cxTreeDragOver(Sender, Source: TObject; X, Y: Integer; State:
  TDragState; var Accept: Boolean);
begin
  Accept := Sender = cxTree;
end;

procedure TfrmChangeOrderNoDlg.cxTreeFocusedNodeChanged(Sender: TcxCustomTreeList; APrevFocusedNode,
  AFocusedNode: TcxTreeListNode);
begin
  SelectionChanged;
end;

procedure TfrmChangeOrderNoDlg.cxTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then
  begin
    case Key of
      35:
        begin
          MoveItem(4);
          Key := 0;
        end; // END
      36:
        begin
          MoveItem(3);
          Key := 0;
        end; // HOME
      38:
        begin
          MoveItem(1);
          Key := 0;
        end; // Up
      40:
        begin
          MoveItem(2);
          Key := 0;
        end; // Down
    end;
  end;
end;

procedure TfrmChangeOrderNoDlg.cxTreeMoveTo(Sender: TcxCustomTreeList; AttachNode: TcxTreeListNode;
  AttachMode: TcxTreeListNodeAttachMode; Nodes: TList; var IsCopy, Done: Boolean);
begin
  Done := True;
end;

destructor TfrmChangeOrderNoDlg.Destroy;
begin
  if fInternalTransaction then
    fTransaction.Free;
  inherited;
end;

procedure TfrmChangeOrderNoDlg.DoSortItems(const Ascending: Boolean);
begin
  cxTree.BeginUpdate;
  try
    if Ascending then
      cxTree.OnCompare := cxTreeCompareASC
    else
      cxTree.OnCompare := cxTreeCompareDSC;
    cxTree.Sorted := True;
    cxTree.Sorted := False;
  finally
    cxTree.OnCompare := nil;
    cxTree.EndUpdate;
    fChanged := True;
  end;
end;

procedure TfrmChangeOrderNoDlg.bbSortDescendingClick(Sender: TObject);
begin
  DoSortItems(False);
end;

procedure TfrmChangeOrderNoDlg.LoadStates;
begin
  if AppUserConfigStorage.FormPositions.ReadFormPos(self) then
    self.Position := poDesigned;
end;

procedure TfrmChangeOrderNoDlg.MoveItem(const Dir: Integer);
var
  NodeSource, NodeTarget: TcxTreeListNode;
begin
  if Assigned(cxTree.FocusedNode) and (cxTree.Count > 1) then
  begin
    NodeSource := cxTree.FocusedNode;
    cxTree.BeginUpdate;
    try
      fChanged := True;
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
      SelectionChanged;
    end;
  end;
end;

procedure TfrmChangeOrderNoDlg.Prepare;
begin
  ReadFolders;
  SelectionChanged;
end;

function TfrmChangeOrderNoDlg.ProcessSQLTags(const SQLText: string): string;
var
  S: string;
begin
  Result := StringReplace(SQLText, '<ID>', cDBTableFieldsInfo[FDBTable].IDField, [rfReplaceAll,
    rfIgnoreCase]);
  Result := StringReplace(Result, '<TITLE>', cDBTableFieldsInfo[FDBTable].TitleField, [rfReplaceAll,
    rfIgnoreCase]);
  Result := StringReplace(Result, '<TABLE>', cDBTableFieldsInfo[FDBTable].DBTable, [rfReplaceAll,
    rfIgnoreCase]);
  Result := StringReplace(Result, '<PARENT>', cDBTableFieldsInfo[FDBTable].ParentField, [rfReplaceAll,
    rfIgnoreCase]);
  Result := StringReplace(Result, '<IMAGEINDEX>', cDBTableFieldsInfo[FDBTable].ImageIndexField, [rfReplaceAll,
    rfIgnoreCase]);
  S := cDBTableFieldsInfo[FDBTable].CustomWHERE;
  if S <> '' then
  begin
    if Pos('$PARAM', S) > 0 then
      S := StringReplace(S, '$PARAM', fWhereParam, []);
    if Pos(' WHERE ', Result) = 0 then
      S := Format(' WHERE (%s)', [S])
    else
      S := Format(' AND (%s)', [S]);
  end;

  Result := StringReplace(Result, '<CUSTOMWHERE>', S, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmChangeOrderNoDlg.ReadFolders;
var
  tmpNode: TcxTreeListNode;
  N: Integer;
begin
  if fInternalTransaction then
    fTransaction.StartTransaction;
  try
    if (FParentID = -1) then
    begin
      // NULL
      IBCQuery.SQL.Text := ProcessSQLTags(cSQL_SELECT_NULL);
    end
    else
    begin
      IBCQuery.SQL.Text := ProcessSQLTags(cSQL_SELECT);
      IBCQuery.ParamByName('ParentID').AsInteger := FParentID;
    end;
    // if (FParentID=-1) and (cDBTableFieldsInfo[fDBTable].CustomWHERE<>'') then IBCQuery.FilterSQL:=cDBTableFieldsInfo[fDBTable].CustomWHERE;
    IBCQuery.ExecSQL;
    while not IBCQuery.Eof do
    begin
      tmpNode := cxTree.Add;
      tmpNode.Texts[0] := IBCQuery.Fields[1].AsString;
      tmpNode.Texts[1] := IBCQuery.Fields[0].AsString;
      N := dmDB.GetImageIndexByGoodsTypeID(IBCQuery.Fields[2].AsInteger);
      tmpNode.ImageIndex := N;
      tmpNode.SelectedIndex := N;
      IBCQuery.Next;
    end;
  finally
    if fInternalTransaction then
      fTransaction.Commit;
    IBCQuery.Close;
  end;
end;

function TfrmChangeOrderNoDlg.SaveFolders: Boolean;
var
  N: Integer;
  Node: TcxTreeListNode;
begin
//  SaveFolders := False;
  try
    if fInternalTransaction then
      fTransaction.StartTransaction;
    try
      if (FParentID = -1) then
      begin
        // NULL
        IBCQuery.SQL.Text := ProcessSQLTags(cSQL_UPDATE_NULL);
      end
      else
      begin
        IBCQuery.SQL.Text := ProcessSQLTags(cSQL_UPDATE);
        IBCQuery.ParamByName('ParentID').AsInteger := FParentID;
      end;
      N := 1;
      Node := cxTree.Items[0];
      while Node <> nil do
      begin
        IBCQuery.ParamByName('OrderNo').AsInteger := N;
        IBCQuery.ParamByName('ObjectID').AsInteger := StrToInt(Node.Texts[1]);
        IBCQuery.Prepare;
        IBCQuery.ExecSQL;

        Inc(N);
        Node := Node.getNextSibling;
      end;
      if fInternalTransaction then
        fTransaction.Commit;
      Result := True;
    except
      if fInternalTransaction then
        fTransaction.Rollback;
      raise;
    end;
  finally
    IBCQuery.Close;
  end;
end;

procedure TfrmChangeOrderNoDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(self);
end;

procedure TfrmChangeOrderNoDlg.SelectionChanged;
var
  f0, f1, f2, f3, f4: Boolean;
  Node: TcxTreeListNode;
begin
  f0 := True;
  f1 := False;
  f2 := False;
  f3 := False;
  f4 := False;
  if (cxTree.Count > 1) and Assigned(cxTree.FocusedNode) then
  begin
    // up
    Node := cxTree.FocusedNode.getPrevSibling;
    f1 := Assigned(Node);
    // down
    Node := cxTree.FocusedNode.getNextSibling;
    f2 := Assigned(Node);

    f3 := True;
    f4 := True;
  end;
//  bbSortOptions.Enabled := f0;
  bbMoveUp.Enabled := f1;
  bbMoveDown.Enabled := f2;
  bbMoveTop.Enabled := f3;
  bbMoveBottom.Enabled := f4;
end;

procedure TfrmChangeOrderNoDlg.SetDBTable(const Value: TChangeOrderTable);
begin
  FDBTable := Value;
  dtDialogTitle.Title := cDBTableFieldsInfo[FDBTable].DialogTitle;
  Caption := dtDialogTitle.Title;
end;

procedure TfrmChangeOrderNoDlg.SetParentID(const Value: Integer);
begin
  FParentID := Value;
end;

procedure TfrmChangeOrderNoDlg.SetWhereParam(const Value: string);
begin
  fWhereParam := Value;
end;

end.


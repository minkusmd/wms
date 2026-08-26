unit ufrmBankInOutDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls,
  cxCustomData, cxStyles, dxScrollbarAnnotations, cxTL, cxTLdxBarBuiltInMenu, dxBar, dxBarExtItems, cxClasses,
  cxSplitter, cxInplaceContainer, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, DialogTitle, cxTextEdit, Data.DB, DBAccess,
  IBC, MemDS, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxCalc, cxCheckBox, cxSchedulerStorage,
  cxSchedulerCustomControls, cxSchedulerDateNavigator, cxContainer, cxDateNavigator, cxMaskEdit, cxButtonEdit;

const
    bDocTypes = '119, 1199, 120, 121, 3036, 3088';
type
   PDocTypeItem = ^TDocTypeItem;

   TDocTypeItem = record
      isFolder: Boolean;
      DocTypeID: Integer;
   end;


  TfrmBankInOut = class(TSWNBaseFormClass)
    DialogTitle1: TDialogTitle;
    Panel1: TPanel;
    cxButton1: TcxButton;
    Panel2: TPanel;
    cxTreeList1: TcxTreeList;
    cxSplitter1: TcxSplitter;
    Panel3: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    cxTreeList1Column1: TcxTreeListColumn;
    cbIBAN: TdxBarCombo;
    IBCQueryIBAN: TIBCQuery;
    IBCDataSourceIBAN: TIBCDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    cxGrid1DBTableView1Column10: TcxGridDBColumn;
    IBCQueryDocs: TIBCQuery;
    IBCDataSourceDocs: TIBCDataSource;
    cxGrid1DBTableView1_DOCTYPE_NAME: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbCloseDocument: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbOpenDocument: TdxBarButton;
    cxGrid1DBTableView1_FLG_CLOSED: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    cxGrid1DBTableView1_IBAN: TcxGridDBColumn;
    bbCloneDocument: TdxBarButton;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxDateNavigator1: TcxDateNavigator;
    dxBarButton1: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    procedure cxTreeList1FocusedNodeChanged(Sender: TcxCustomTreeList;
        APrevFocusedNode, AFocusedNode: TcxTreeListNode);
    procedure bbNewClick(Sender: TObject);
    procedure cbIBANChange(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure cxTreeList1Collapsing(Sender: TcxCustomTreeList; ANode:
        TcxTreeListNode; var Allow: Boolean);
    procedure bbEditClick(Sender: TObject);
    procedure bbCloneDocumentClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure bbCloseDocumentClick(Sender: TObject);
    procedure cxDateNavigator1Click(Sender: TObject);
    procedure bbOpenDocumentClick(Sender: TObject);
  private
    FDT: Integer;
    procedure PopulateIBAN;
    procedure PopulateTreeList;
    function GetIBAN(Text: string): string;
    procedure PrepareData(nd: PDocTypeItem);
    procedure SetDT(const Value: Integer);
    { Private declarations }
  protected
    { Protected declaration }
    procedure Prepare; override;
    function IsFormDataPosted: Boolean; override;
    procedure WhenCancelForm; override;

  public
    property DT: Integer read FDT write SetDT;
    { Public declarations }
  end;

var
  frmBankInOut: TfrmBankInOut;

implementation

uses
    DataModuleAdditions, DataModuleDB, frmBankPDNSDialog, frmBPPLDialog, frmBankPDNSKDialog;

{$R *.dfm}

procedure TfrmBankInOut.bbCloneDocumentClick(Sender: TObject);
var
    NewDocID: integer;
begin
    if dmDB.CloneDocumentDB(IBCQueryDocs.FieldByName('DOCID').AsInteger, newDocID, 0, 1) then
    begin
        IBCQueryDocs.Refresh;
        IBCQueryDocs.Locate('DOCID', newDocID, []);
        bbEditClick(Sender);
    end;

end;

procedure TfrmBankInOut.bbCloseDocumentClick(Sender: TObject);
begin
  ibcquerydocs.First;
  while not ibcquerydocs.Eof do
  begin
    dmDB.ExecuteQuery('execute procedure SP_CLOSE_BPPL(:docid)', [IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    IBCQueryDocs.Next;
  end;

  IBCQueryDocs.Refresh;
end;

procedure TfrmBankInOut.bbDeleteClick(Sender: TObject);
begin
  inherited;
    if (MessageDlg('Sterg inregistrarea ?', mtConfirmation, [mbYes, mbNo],0)=mrYes) then
        IBCQueryDocs.Delete;
end;

procedure TfrmBankInOut.bbEditClick(Sender: TObject);
var
    DocTypeID: Integer;
    dialog: TSWNMasteredFormClass;
begin
    DocTypeID := PDocTypeItem(cxTreeList1.FocusedNode.Data)^.DocTypeID;

    case DocTypeID of
      119:  begin
                dialog := TfrmBPPLDlg.Create(self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with (dialog as TfrmBPPLDlg) do
                    begin
                        CreateNewDocument := False;
                        DocTypeID := 119;
                        IBAN := GetIBAN(cbIBAN.Text);
//                        DataDoc := dxBarDateCombo1.Date;
                        dialog.ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      1199: begin
            end;
      120:  begin
                dialog := TfrmBankPDNSDlg.Create(Self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with TfrmBankPDNSDlg(dialog) do
                    begin
                        CreateNewDocument := False;
                        DocTypeID := 120;
                        IBAN := GetIBAN(cbIBAN.Text);
                        ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      121:  begin
                dialog := TfrmBankPDNSKDlg.Create(self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with TfrmBankPDNSKDlg(dialog) do
                    begin
                         CreateNewDocument := False;
                         DocTypeID := 121;
                         IBAN := GetIBAN(cbIBAN.Text);
                         ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      3036: begin end;
      3088: begin end;
    end;
    IBCQueryDocs.Refresh;
end;
procedure TfrmBankInOut.bbNewClick(Sender: TObject);
var
    DocTypeID: Integer;
    dialog: TSWNMasteredFormClass;
begin
    DocTypeID := PDocTypeItem(cxTreeList1.FocusedNode.Data)^.DocTypeID;

    case DocTypeID of
      119:  begin
                dialog := TfrmBPPLDlg.Create(self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with (dialog as TfrmBPPLDlg) do
                    begin
                        CreateNewDocument := True;
                        DocTypeID := 119;
                        IBAN := GetIBAN(cbIBAN.Text);
                        DataDoc := cxDateNavigator1.Date;
                        dialog.ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      1199: begin
            end;
      120:  begin
                dialog := TfrmBankPDNSDlg.Create(Self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with TfrmBankPDNSDlg(dialog) do
                    begin
                        CreateNewDocument := True;
                        DocTypeID := 120;
                        IBAN := GetIBAN(cbIBAN.Text);
                        DateDoc := cxDateNavigator1.Date;
                        ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      121:  begin
                dialog := TfrmBankPDNSKDlg.Create(self, IBCQueryDocs, IBCDataSourceDocs);
                try
                    with TfrmBankPDNSKDlg(dialog) do
                    begin
                         CreateNewDocument := True;
                         DocTypeID := 121;
                         IBAN := GetIBAN(cbIBAN.Text);
                         DataDoc := cxDateNavigator1.Date;
                         ShowModal;
                    end;
                finally
                    dialog.Free;
                end;
            end;
      3036: begin end;
      3088: begin end;
    end;
    IBCQueryDocs.Refresh;
end;

procedure TfrmBankInOut.bbOpenDocumentClick(Sender: TObject);
begin
    dmDB.ExecuteQuery('execute procedure SP_OPEN_BPPL(:docid)', [IBCQueryDocs.FieldByName('DOCID').AsInteger]);
    IBCQueryDocs.Refresh;
end;

procedure TfrmBankInOut.cbIBANChange(Sender: TObject);
var
    nd: PDocTypeItem;
begin
    if Assigned(cxTreeList1.FocusedNode) then
    begin
      nd := PDocTypeItem(cxTreeList1.FocusedNode.Data);
      if nd^.isFolder=False then
          PrepareData(nd);
    end;
//    IBCQueryDocs.Close;
//    if IBCQueryDocs.FindParam('IBAN')<> nil then
//        IBCQueryDocs.ParamByName('IBAN').AsString := GetIBAN(cbIBAN.Text);
//    if IBCQueryDocs.FindParam('DATA') <> nil then
//    IBCQueryDocs.ParamByName('DATA').AsDate := cxDateNavigator1.Date;
//    IBCQueryDocs.Open;

end;

procedure TfrmBankInOut.cxDateNavigator1Click(Sender: TObject);
var
    nd: PDocTypeItem;
begin
    nd := PDocTypeItem(cxTreeList1.FocusedNode.Data);
    if nd^.isFolder=False then
        PrepareData(nd);
//    IBCQueryDocs.Close;
//    IBCQueryDocs.ParamByName('DATA').AsDate := cxDateNavigator1.Date;
//    if IBCQueryDocs.FindParam('IBAN')<> nil then
//        IBCQueryDocs.ParamByName('IBAN').AsString := GetIBAN(cbIBAN.Text);
//
//    IBCQueryDocs.Open;
end;

procedure TfrmBankInOut.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
    bbEditClick(Sender);
end;

procedure TfrmBankInOut.cxGrid1DBTableView1KeyDown(Sender: TObject; var Key:
    Word; Shift: TShiftState);
begin
//         ProcessCommonKeys(cxGrid1DBTableView1,Key,Shift);
end;

procedure TfrmBankInOut.cxTreeList1Collapsing(Sender: TcxCustomTreeList; ANode:
    TcxTreeListNode; var Allow: Boolean);
begin
  Allow := false;
end;

procedure TfrmBankInOut.cxTreeList1FocusedNodeChanged(Sender:
    TcxCustomTreeList; APrevFocusedNode, AFocusedNode: TcxTreeListNode);
var
    nd: PDocTypeItem;
begin
    nd := PDocTypeItem(AFocusedNode.Data);
    if nd^.isFolder=False then
    begin
        cxGrid1DBTableView1_DOCTYPE_NAME.Visible := False;
        PrepareData(nd);
    end
    else
    begin
        cxGrid1DBTableView1_DOCTYPE_NAME.Visible := True;
        IBCQueryDocs.Close;
//        IBCQueryDocs.SQL.Text := 'select d.*, dr.dt_cd from vw_tdb_docs d '+
//                                 'left outer join tdb_docs_rechizite dr on dr.docid = d.docid ';
//
//                                  if cbIBAN.Text <> 'Toate conturile'  then
//                                      IBCQueryDocs.MacroByName('IBAN').AsString := ' and dr.dt_cd = :IBAN';
//
//                                 IBCQueryDocs.SQL.Add(' where d.doctypeid in ('+bDocTypes+') and ');
//                                 IBCQueryDocs.SQL.Add('cast(d.data as date) = cast(:DATA as date) order by d.docid');
//
//        IBCQueryDocs.ParamByName('DATA').AsDate := cxDateNavigator1.Date;
//
//        if IBCQueryDocs.FindParam('IBAN') <> nil then
//            IBCQueryDocs.ParamByName('IBAN').AsString := GetIBAN(cbIBAN.Text);
//        IBCQueryDocs.Open;
    end;
end;

function TfrmBankInOut.GetIBAN(Text: string): string;
begin
   Result := Copy(Text, 0, pos(' ', Text)-1);
end;

function TfrmBankInOut.IsFormDataPosted: Boolean;
begin
   try
      if IBCQueryDocs.State in dsEditModes then
        IBCQueryDocs.Post;
      if IBCTrUpdate.Active then
        IBCTrUpdate.Commit;
      Result := True;
   except
   begin
       IBCTrUpdate.Rollback;
       raise;
   end
   end;
end;

procedure TfrmBankInOut.PopulateIBAN;
begin
  with IBCQueryIBAN do
  begin
    Close;
    ParamByName('DT').AsInteger := dmdb.CurrentFirma;
    Open;

    if IBCQueryIBAN.RecordCount>0 then
        cbIBAN.Items.Add('Toate conturile');

    while not IBCQueryIBAN.Eof do
    begin
        cbIBAN.Items.Add(IBCQueryIBAN.FieldByName('ACCOUNTNUMBER').AsString + ' - '+IBCQueryIBAN.FieldByName('ACCOUNTNAME').AsString);
        Next;
    end;
    if cbIBAN.Items.Count > 0 then
      cbIBAN.Text := GetIBAN(cbIBAN.Items[0]);
  end;
end;

procedure TfrmBankInOut.PopulateTreeList;
var
    q: TIBCQuery;
    node: TcxTreeListNode;
    rootNode: TcxTreeListNode;
    NodeData: PDocTypeItem;
begin
//    cxTreeList1.Clear;
//    i := 0;
    rootNode := cxTreeList1.AddChild(nil);
    rootNode.Expanded := True;
    rootNode.Texts[0] := 'Operatiuni bancare';
    New(NodeData);
    NodeData^.isFolder := True;
    NodeData^.DocTypeID := -1;
    rootNode.Data := NodeData;
    q := TIBCQuery.Create(self);

    try
        q.SQL.Text := 'select * from ts_doctypes where doctypeid in ('+bDocTypes+') order by orderno';
        q.Open;
        while not q.Eof do
        begin
//            Inc(i);
            node := cxTreeList1.AddChild(rootNode);
            node.Texts[0] := q.FieldByName('TITLE').AsString;
            New(NodeData);
            NodeData^.isFolder := false;
            NodeData^.DocTypeID := q.FieldByName('DOCTYPEID').AsInteger;
            node.Data :=  NodeData;
            q.Next;
        end;
    finally
        q.Free;
    end;
end;

procedure TfrmBankInOut.Prepare;
begin
  inherited;
  cxDateNavigator1.Date := Date;
  PopulateTreeList;
  PopulateIBAN;
  cxtreelist1.FocusedNode := cxTreeList1.Items[0];
  cxTreeList1.FocusedNode.Expand(true);
end;

procedure TfrmBankInOut.WhenCancelForm;
begin
  if IBCTrUpdate.Active then
        IBCTrUpdate.Rollback;
end;

procedure TfrmBankInOut.PrepareData(nd: PDocTypeItem);
begin
  IBCQueryDocs.Close;
//  IBCQueryDocs.SQL.Text := 'select d.*, dr.dt_cd from vw_tdb_docs d ' + 'inner join tdb_docs_rechizite dr on dr.docid = d.docid ';
//  IBCQueryDocs.SQL.Add(' where d.doctypeid = :doctypeid and ');
//  IBCQueryDocs.SQL.Add('cast(d.data as date) = cast(:DATA as date) order by d.docid');

  if (cbIBAN.Text <> 'Toate') and (QuotedStr(GetIBAN(cbIBAN.Text)) <> '') then
      IBCQueryDocs.MacroByName('IBAN').Value := ' and dr.dt_cd = '+QuotedStr(GetIBAN(cbIBAN.Text));
//  else
//      IBCQueryDocs.MacroByName('IBAN').AsString := '';
  IBCQueryDocs.ParamByName('DOCTYPEID').AsInteger := ND^.DocTypeID;
  IBCQueryDocs.ParamByName('DATA').AsDate := cxDateNavigator1.Date;
  IBCQueryDocs.ParamByName('DT').AsInteger := fDT;
  IBCQueryDocs.Open;
end;

procedure TfrmBankInOut.SetDT(const Value: Integer);
begin
  FDT := Value;
end;

end.

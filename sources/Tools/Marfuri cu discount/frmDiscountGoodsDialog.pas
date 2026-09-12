unit frmDiscountGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxClasses, dxBar, StdCtrls, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess,
  IBC, MemDS, cxImageComboBox, cxLabel, cxNavigator, cxCurrencyEdit, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmDiscountGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    pnGoods: TPanel;
    pnGroups: TPanel;
    pnButtons: TPanel;
    btnClose: TButton;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    cxGridGroupTable: TcxGridDBTableView;
    cxGridGroupLevel: TcxGridLevel;
    cxGridGroup: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    bbGroupNew: TdxBarButton;
    bbGroupEdit: TdxBarButton;
    bbGroupDelete: TdxBarButton;
    bbGoodsNew: TdxBarButton;
    bbGoodsEdit: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    cxGridGroup_GDISCOUNTID: TcxGridDBColumn;
    cxGridGroup_TITLE: TcxGridDBColumn;
    cxGridGroup_PERIOD: TcxGridDBColumn;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_TITLE: TcxGridDBColumn;
    IBCQueryGroups: TIBCQuery;
    IBCDataSourceGroups: TIBCDataSource;
    IBCDataSourceGoods: TIBCDataSource;
    IBCQueryGoods: TIBCQuery;
    cxGridGroup_START_DATE: TcxGridDBColumn;
    cxGridGroup_END_DATE: TcxGridDBColumn;
    IBCTrUpdate: TIBCTransaction;
    cxGridGoods_DISCOUNT_VALUE: TcxGridDBColumn;
    bbGoodsNewMore: TdxBarButton;
    cxGridGoods_IMG: TcxGridDBColumn;
    bbGoodsDeleteAll: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbCopyGoodsInActiune: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    bbGoodsNewFromFolder: TdxBarButton;
    cxGridGoodsTableColumn1: TcxGridDBColumn;
    procedure cxGridGroup_PERIODGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridGroupTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbGroupNewClick(Sender: TObject);
    procedure bbGroupEditClick(Sender: TObject);
    procedure bbGroupDeleteClick(Sender: TObject);
    procedure cxGridGroupTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsEditClick(Sender: TObject);
    procedure cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbGoodsNewMoreClick(Sender: TObject);
    procedure bbGoodsDeleteAllClick(Sender: TObject);
    procedure bbCopyGoodsInActiuneClick(Sender: TObject);
    procedure bbGoodsNewFromFolderClick(Sender: TObject);
  private
    { Private declarations }
    fLastDiscountValue:integer;
    fLastGoodsID:integer;
    procedure GroupSelectionChanged;
    procedure GoodsSelectionChanged;

    procedure ShowNewGroupDialog;
    procedure ShowEditGroupDialog;
    procedure ShowDeleteGroupDialog;

    procedure ShowAddGoodsDialog;
    procedure ShowAddMoreGoodsDialog;
    procedure ShowEditGoodsDialog;
    function ShowGoodsDeleteDialog(const GDiscountID:integer):Boolean;

    procedure WhenAddGoodsBurst(const GoodsID:integer; const GoodsTitle:String; var Added:Boolean; var Count:integer);
    function WhenCheckGoodsExists(const GoodsID:integer):Boolean;

    function GetDiscountType(const DiscountType:Integer):String;

    function DeleteAllGoods(const GDiscountID:integer):Boolean;
    procedure ShowCopyGoodsDialog(const GDiscountID:integer; const IDList:TStringList);
    function CopyGoodsToActiune(const GDiscountID, ACtiuneID:integer; const ToClearExistsing, CopyFromSelectionOnly: Boolean; const IDList:String):Boolean;
    procedure GetSelectionList(const IDList:TStringList);
    function AddGoodsFromFolder(const FolderID, DiscountID, DiscountValue:Integer):Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, DateUtils, SWNUtils, SWNDBErrors, frmDiscountGroupEditorDialog,
  frmGoods, frmDiscountGoodsEditorDialog, frmDiscountGoodsCopyToActiuneDialog, frmDiscountDefaultValueDialog;

{$R *.dfm}

function TfrmDiscountGoodsDlg.AddGoodsFromFolder(const FolderID, DiscountID, DiscountValue: Integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_ACTIUNE_ADDGOODSFROMFOLDER(:fid,:did,:disc)';
        Query.ParamByName('fid').AsInteger:=FolderID;
        Query.ParamByName('did').AsInteger:=DiscountID;
        Query.ParamByName('disc').AsInteger:=DiscountValue;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.bbCopyGoodsInActiuneClick(Sender: TObject);
var SelectionList:TStringList;
begin
     SelectionList:=TStringList.Create;
     try
        GetSelectionList(SelectionList);
        ShowCopyGoodsDialog(IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger,SelectionList);
     finally
        SelectionList.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.bbGoodsDeleteAllClick(Sender: TObject);
begin
     if ShowAskDialog('Stergere toate',Format('Doriti sa stergeti toate marfurile din grupul "%s"?',[IBCQueryGroups.FieldByName('TITLE').AsString]))=mrYes
        then if DeleteAllGoods(IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger) then IBCQueryGoods.Refresh;
end;

procedure TfrmDiscountGoodsDlg.bbGoodsDeleteClick(Sender: TObject);
begin
     if ShowGoodsDeleteDialog(IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger) then IBCQueryGoods.Refresh;
end;

procedure TfrmDiscountGoodsDlg.bbGoodsEditClick(Sender: TObject);
begin
     ShowEditGoodsDialog;
end;

procedure TfrmDiscountGoodsDlg.bbGoodsNewClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure TfrmDiscountGoodsDlg.bbGoodsNewFromFolderClick(Sender: TObject);
var dialog:TfrmGoodsBrowser;
    dialog2:TfrmDiscountDefaultValueDlg;
    GoodsID:integer;
begin
     GoodsID:=-1;

     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(fLastGoodsID,True,0,'Selectati grupul de marfuri pentru adaugare') then
        begin
             fLastGoodsID:=dialog.GoodsID;
             GoodsID:=dialog.GoodsID;
        end;
     finally
       dialog.Free;
     end;

     if GoodsID>0 then
     begin
          // ask to discount value for next goods
          dialog2:=TfrmDiscountDefaultValueDlg.Create(Self);
          try
             dialog2.DiscountValue:=fLastDiscountValue;
             if IBCQueryGroups.FieldByName('DISCOUNT_TYPE').AsInteger=2
               then dialog2.DiscountName:='lei'
               else dialog2.DiscountName:='%';
             if dialog2.ShowModal=mrOk then
             begin
                  fLastDiscountValue:=dialog2.DiscountValue;
                  if AddGoodsFromFolder(dialog.GoodsID,IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger,fLastDiscountValue) then IBCQueryGoods.Refresh;
             end;
          finally
             dialog2.Free;
          end;
     end;

end;

procedure TfrmDiscountGoodsDlg.bbGoodsNewMoreClick(Sender: TObject);
begin
     ShowAddMoreGoodsDialog;
end;

procedure TfrmDiscountGoodsDlg.bbGroupDeleteClick(Sender: TObject);
begin
     ShowDeleteGroupDialog;
end;

procedure TfrmDiscountGoodsDlg.bbGroupEditClick(Sender: TObject);
begin
     ShowEditGroupDialog;
end;

procedure TfrmDiscountGoodsDlg.bbGroupNewClick(Sender: TObject);
begin
     ShowNewGroupDialog;
end;

function TfrmDiscountGoodsDlg.CopyGoodsToActiune(const GDiscountID, ACtiuneID: integer; const ToClearExistsing, CopyFromSelectionOnly: Boolean; const IDList:String): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_COPY_GOODS_DISC_TO_ACTIUNE(:GID,:AID,:toClear,:fromSelection,:IdList)';
        Query.ParamByName('GID').AsInteger:=GDiscountID;
        Query.ParamByName('AID').AsInteger:=ACtiuneID;
        Query.ParamByName('toClear').AsInteger:=Ord(ToClearExistsing);
        Query.ParamByName('fromSelection').AsInteger:=Ord(CopyFromSelectionOnly);
        if CopyFromSelectionOnly
           then Query.ParamByName('IdList').AsString:=IDList
           else Query.ParamByName('IdList').Value:=Null;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.cxGridGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbGoodsEdit.Enabled then
     begin
          bbGoodsEditClick(bbGoodsEdit);
          AHandled:=True;
     end;
end;

procedure TfrmDiscountGoodsDlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

procedure TfrmDiscountGoodsDlg.cxGridGroupTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbGroupEdit.Enabled then
     begin
          bbGroupEditClick(bbGroupEdit);
          AHandled:=True;
     end;
end;

procedure TfrmDiscountGoodsDlg.cxGridGroupTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GroupSelectionChanged;
end;

procedure TfrmDiscountGoodsDlg.cxGridGroup_PERIODGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridGroup_START_DATE.Index]) and Not VarIsNull(ARecord.Values[cxGridGroup_END_DATE.Index])
        then AText:=Format('%s-%s',[DateToStr(ARecord.Values[cxGridGroup_START_DATE.Index]),DateToStr(ARecord.Values[cxGridGroup_END_DATE.Index])]);
end;

function TfrmDiscountGoodsDlg.DeleteAllGoods(const GDiscountID: integer):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='DELETE FROM TDB_GOODS_DISCOUNT WHERE GDISCOUNTID=:id';
        Query.ParamByName('id').AsInteger:=GDiscountID;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

function TfrmDiscountGoodsDlg.GetDiscountType(const DiscountType: Integer): String;
begin
     case DiscountType of
     1: Result:='%';
     2: Result:='LEI';
     end;
end;

procedure TfrmDiscountGoodsDlg.GetSelectionList(const IDList: TStringList);
var i,index:integer;
begin
     IDList.Clear;
     for i := 0 to cxGridGoodsTable.Controller.SelectedRecordCount - 1 do
     begin
          index:=cxGridGoodsTable.Controller.SelectedRecords[i].RecordIndex;
          IDList.Add(cxGridGoodsTable.DataController.Values[index,cxGridGoods_GOODSID.Index]);
     end;
end;

procedure TfrmDiscountGoodsDlg.GoodsSelectionChanged;
var fNew,fEdit,fDelete,fDeleteAllGoods:Boolean;
begin
     fNew:=False;
     fEdit:=False;
     fDelete:=False;
     fDeleteAllGoods:=False;

     if (cxGridGroupTable.DataController.RecNo>0) then
     begin
          fNew:=True;
          fDeleteAllGoods:=cxGridGoodsTable.DataController.RecordCount>0;
          if (cxGridGoodsTable.DataController.RecNo>0) then
          begin
               fEdit:=True;
               fDelete:=True;
          end;
     end;

     bbGoodsNew.Enabled:=fNew;
     bbGoodsNewFromFolder.Enabled:=fNew;
     bbGoodsNewMore.Enabled:=fNew;

     bbGoodsEdit.Enabled:=fEdit;
     bbGoodsDelete.Enabled:=fDelete;
     bbGoodsDeleteAll.Enabled:=fDeleteAllGoods;
end;

procedure TfrmDiscountGoodsDlg.GroupSelectionChanged;
var fNew,fEdit,fDelete,fCopyGoods:Boolean;
begin
     fNew:=True;
     fEdit:=False;
     fDelete:=False;
     fCopyGoods:=False;

     if (cxGridGroupTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
          fCopyGoods:=True;
     end;

     bbGroupNew.Enabled:=fNew;
     bbGroupEdit.Enabled:=fEdit;
     bbGroupDelete.Enabled:=fDelete;
     bbCopyGoodsInActiune.Enabled:=fCopyGoods;

     GoodsSelectionChanged;
end;

procedure TfrmDiscountGoodsDlg.Prepare;
begin
     fLastDiscountValue:=0;
     fLastGoodsID:=0;

     IBCQueryGroups.Active:=True;
     IBCQueryGoods.Active:=True;

     GroupSelectionChanged;

     cxGridGroup_TITLE.Focused:=True;
     cxGridGoods_TITLE.Focused:=True;
end;

procedure TfrmDiscountGoodsDlg.ShowAddGoodsDialog;
var dialog:TfrmDiscountGoodsEditorDlg;
begin
     dialog:=TfrmDiscountGoodsEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewGoods:=True;
        dialog.GoodsDiscountID:=IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger;
        dialog.SetDiscountType(GetDiscountType(IBCQueryGroups.FieldByName('DISCOUNT_TYPE').AsInteger),fLastDiscountValue);
        if dialog.ShowModal=mrOk then
        begin
             // save last values
             fLastDiscountValue:=IBCQueryGoods.FieldByName('DISCOUNT_VALUE').AsInteger;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowAddMoreGoodsDialog;
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.OnBurstAddGoods:=WhenAddGoodsBurst;
        dialog.OnCheckIfGoodsExists:=WhenCheckGoodsExists;
        dialog.BurstMode:=True;
        if dialog.SelectGoods(fLastGoodsID,False,0,'Selectati marfa cu discount') then
        begin
             if Not WhenCheckGoodsExists(dialog.GoodsID) then
             begin
                  IBCQueryGoods.UpdateTransaction.StartTransaction;
                  try
                     IBCQueryGoods.Insert;
                     IBCQueryGoods.FieldByName('GDISCOUNTID').AsInteger:=IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger;
                     IBCQueryGoods.FieldByName('GOODSID').AsInteger:=dialog.GoodsID;
                     IBCQueryGoods.FieldByName('DISCOUNT_VALUE').AsInteger:=fLastDiscountValue;
                     IBCQueryGoods.Post;
                     IBCQueryGoods.UpdateTransaction.Commit;
                     fLastGoodsID:=dialog.GoodsID;
                  except on E:Exception do
                     begin
                          IBCQueryGoods.Cancel;
                          IBCQueryGoods.UpdateTransaction.Rollback;
                          if Not ProcessSWNError(E) then raise;
                     end;
                  end;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowCopyGoodsDialog(const GDiscountID: integer; const IDList:TStringList);
var dialog:TfrmDiscountGoodsCopyToActiuneDlg;
    toClear:Boolean;
begin
     dialog:=TfrmDiscountGoodsCopyToActiuneDlg.Create(Self);
     try
        dialog.CopySelectedOnly:=IDList.Count>1;
        if dialog.ShowModal=mrOk then
        begin
             toClear:=False;
             if ShowAskDialogVerification('Copiere marfa in Actiune','Doriti sa copiati toate marfurile in actiune?','Stergeti marfurile existente din actiune?','',toClear)=mrYes then
             begin
                  if CopyGoodsToActiune(GDiscountID,dialog.ActiuneID,toClear,dialog.CopySelectedOnly,StringListToCommaText(IDList)) then ShowInfoDialog('Copiere marfa in Actiune','Toate marfurile au fost copiate!');
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowDeleteGroupDialog;
var S:String;
begin
     S:=IBCQueryGroups.FieldByName('TITLE').AsString;
     if ShowAskDialog('Stergere grup',Format('Doriti sa stergeti grupul "%s"?',[s]),'Toate marfurile vor fi sterse!')=mrYes then
     begin
          IBCQueryGroups.UpdateTransaction.StartTransaction;
          try
             IBCQueryGroups.Delete;
             IBCQueryGroups.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQueryGroups.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(e) then raise;
             end;
          end;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowEditGoodsDialog;
var dialog:TfrmDiscountGoodsEditorDlg;
begin
     dialog:=TfrmDiscountGoodsEditorDlg.Create(Self,IBCQueryGoods,IBCDataSourceGoods);
     try
        dialog.CreateNewGoods:=False;
        dialog.SetDiscountType(GetDiscountType(IBCQueryGroups.FieldByName('DISCOUNT_TYPE').AsInteger));
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowEditGroupDialog;
var dialog:TfrmDiscountGroupEditorDlg;
begin
     dialog:=TfrmDiscountGroupEditorDlg.Create(Self,IBCQueryGroups,IBCDataSourceGroups);
     try
        dialog.CreateNewGroup:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

function TfrmDiscountGoodsDlg.ShowGoodsDeleteDialog(const GDiscountID:integer):Boolean;
var Query:TIBCQuery;
    i,index:integer;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.AutoCommit:=False;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='DELETE FROM TDB_GOODS_DISC_LIST WHERE GDISCOUNTID=:id1 AND GOODSID=:id2';
        Query.ParamByName('id1').AsInteger:=GDiscountID;
        Query.Transaction.StartTransaction;
        try
           for i := 0 to cxGridGoodsTable.Controller.SelectedRecordCount-1 do
           begin
                index:=cxGridGoodsTable.Controller.SelectedRecords[i].RecordIndex;
                Query.ParamByName('id2').AsInteger:=cxGridGoodsTable.DataController.Values[index,cxGridGoods_GOODSID.Index];
                Query.ExecSQL;
           end;
           Query.Transaction.Commit;
           Result:=True;
        except on E:Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.ShowNewGroupDialog;
var dialog:TfrmDiscountGroupEditorDlg;
begin
     dialog:=TfrmDiscountGroupEditorDlg.Create(Self,IBCQueryGroups,IBCDataSourceGroups);
     try
        dialog.CreateNewGroup:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmDiscountGoodsDlg.WhenAddGoodsBurst(const GoodsID: integer; const GoodsTitle: String;
  var Added: Boolean; var Count: integer);
begin
     Added:=False;
     if WhenCheckGoodsExists(GoodsID) then Exit;

     IBCQueryGoods.UpdateTransaction.StartTransaction;
     try
        IBCQueryGoods.Insert;
        IBCQueryGoods.FieldByName('GDISCOUNTID').AsInteger:=IBCQueryGroups.FieldByName('GDISCOUNTID').AsInteger;
        IBCQueryGoods.FieldByName('GOODSID').AsInteger:=GoodsID;
        IBCQueryGoods.FieldByName('DISCOUNT_VALUE').AsInteger:=fLastDiscountValue;
        IBCQueryGoods.Post;
        IBCQueryGoods.UpdateTransaction.Commit;
        Added:=True;
        Count:=1;
        fLastGoodsID:=GoodsID;
     except on E:Exception do
        begin
             IBCQueryGoods.Cancel;
             IBCQueryGoods.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

function TfrmDiscountGoodsDlg.WhenCheckGoodsExists(const GoodsID: integer): Boolean;
var i:integer;
begin
     Result:=False;
     for i := 0 to cxGridGoodsTable.DataController.RecordCount-1 do
     if cxGridGoodsTable.DataController.Values[i,cxGridGoods_GOODSID.Index]=GoodsID then
     begin
          Result:=True;
          Break;
     end;
end;

end.

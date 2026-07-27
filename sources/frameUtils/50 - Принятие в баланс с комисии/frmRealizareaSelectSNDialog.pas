unit frmRealizareaSelectSNDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxImageComboBox, StdCtrls, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxContainer, cxTextEdit, cxDBEdit, Buttons, ExtCtrls, DialogTitle,
  SWNSNClasses, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type

  TfrmRealizareaSelectSNDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnGoods: TPanel;
    cxLabel1: TLabel;
    edGOODS_NAME: TcxDBTextEdit;
    cxLabel2: TLabel;
    edQTY: TcxDBTextEdit;
    Label3: TLabel;
    Label4: TLabel;
    cxGridAvSN: TcxGrid;
    cxGridAvSNLevel: TcxGridLevel;
    cxGridSelSN: TcxGrid;
    cxGridSelSNLevel: TcxGridLevel;
    sbAddSerials: TSpeedButton;
    sbRemoveSerials: TSpeedButton;
    sbAddAllSerials: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    edGOODSID: TcxDBTextEdit;
    cxGridAvSNTable: TcxGridTableView;
    cxGridAvSNTable_IMG: TcxGridColumn;
    cxGridAvSNTable_SN: TcxGridColumn;
    cxGridSelSNTable: TcxGridTableView;
    cxGridSelSNTable_IMG: TcxGridColumn;
    cxGridSelSNTable_SN: TcxGridColumn;
    sbRemoveAllSerials: TSpeedButton;
    lbInfo: TLabel;
    edQuickSearchAv: TEdit;
    Label1: TLabel;
    edQuickSearchSel: TEdit;
    Label2: TLabel;
    cxGridSelSN_USER_NAME: TcxGridColumn;
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridAvSNTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAvSNTableSelectionChanged(Sender: TcxCustomGridTableView);
    procedure sbAddAllSerialsClick(Sender: TObject);
    procedure sbAddSerialsClick(Sender: TObject);
    procedure IBCSetSerialsBeforeDelete(DataSet: TDataSet);
    procedure IBCSetSerialsAfterDelete(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbRemoveSerialsClick(Sender: TObject);
    procedure cxGridSelSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure sbRemoveAllSerialsClick(Sender: TObject);
    procedure cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQuickSearchAvChange(Sender: TObject);
    procedure edQuickSearchSelChange(Sender: TObject);
  private
    { Private declarations }
    fSerialsCount:integer;
    fOwnWarranty:integer;
    fSNtoDelete:String;
    fSNList:TSWNSNList;
    FReadOnly: Boolean;
    FDocsDataSet: TIBCQuery;

    procedure SelectionChanged;

    procedure ReadAvailableSerialsFromDB;
    procedure ReadSerialsInUseFromDB;
    procedure GetOwnWarranty;

    procedure DisplayAvailableSerials;
    procedure DisplaySerialsInUse;

    procedure AddSelectedSerialNumbers;
    procedure RemoveSelectedSerialNumbers;

    procedure LockGoods;
    function SaveSNtoDB:Boolean;

    procedure WhenGridDataChanged(Sender: TObject);
    procedure ShowInfoForUser;

    procedure CopyFocusedSNToClipboard(const Grid:TcxGridTableView; const ColumnIndex:integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetDocsDataSet(const Value: TIBCQuery);

    procedure DoQuickSearchAvailableSN(const Text:String);
    procedure DoQuickSearchSelectedSN(const Text:String);

  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare;override;

    procedure LoadStates;override;
    procedure SaveStates;override;
  public
    { Public declarations }
    property ReadOnly:Boolean read FReadOnly write SetReadOnly;
    property DocsDataSet:TIBCQuery read FDocsDataSet write SetDocsDataSet;
  end;

implementation

uses DataModuleAdditions, SWNUtils, SWNValueStorageUnit, DataModuleDB, SWNConst, ClipBrd, SWNDBErrors;

{$R *.dfm}

{ TfrmSelectSNDlg }

procedure TfrmRealizareaSelectSNDlg.btnOkClick(Sender: TObject);
begin
     if SaveSNtoDB then
     begin
          fMasterDataSet.UpdateTransaction.Commit;
          ModalResult:=mrOk;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     AddSelectedSerialNumbers;
     AHandled:=True;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridAvSNTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=65) and (Shift=[ssCtrl]) then cxGridAvSNTable.DataController.SelectAll // Ctrl+A
     else
     if (Key=VK_RETURN) then sbAddSerialsClick(sbAddSerials) // add selected only
     else
     if (Key=67) and (Shift=[ssCtrl]) then // Ctrl+C
     begin
          CopyFocusedSNToClipboard(cxGridAvSNTable,cxGridAvSNTable_SN.Index);
          Key:=0;
     end
     else
     if (Key=70) and (Shift=[ssCtrl]) then // Ctrl+F
     begin
          // search
          edQuickSearchAv.SetFocus;
          Key:=0;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridAvSNTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
     SelectionChanged;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridSelSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if (not FReadOnly) then
     begin
          RemoveSelectedSerialNumbers;
          AHandled:=True;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=65) and (Shift=[ssCtrl]) then cxGridSelSNTable.DataController.SelectAll
     else
     if (not FReadOnly) and (Key=VK_DELETE) then sbRemoveSerialsClick(sbRemoveSerials) // remove selected only
     else
     if (Key=67) and (Shift=[ssCtrl]) then // Ctrl+C
     begin
          CopyFocusedSNToClipboard(cxGridSelSNTable,cxGridSelSNTable_SN.Index);
          Key:=0;
     end
     else
     if (Key=70) and (Shift=[ssCtrl]) then // Ctrl+F
     begin
          // search
          edQuickSearchSel.SetFocus;
          Key:=0;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.DisplayAvailableSerials;
var i,N:integer;
    SNItem:TSWNSNItem;
begin
     cxGridAvSNTable.BeginUpdate;
     try
        for i := 0 to fSNList.Count-1 do
        begin
             SNItem:=fSNList[i];
             if SNItem.Status=snstNew then
             begin
                  N:=cxGridAvSNTable.DataController.AppendRecord;
                  cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_SN.Index]:=SNItem.SN;
             end;
        end;
     finally
        cxGridAvSNTable.EndUpdate;
     end;
     if cxGridAvSNTable.DataController.RecordCount>0 then
     begin
          cxGridAvSNTable.ViewData.Records[0].Selected:=True;
          cxGridAvSNTable.ViewData.Records[0].Focused:=True;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.DisplaySerialsInUse;
var i,N:integer;
    SNItem:TSWNSNItem;
begin
     cxGridSelSNTable.BeginUpdate;
     try
        for i := 0 to fSNList.Count-1 do
        begin
             SNItem:=fSNList[i];
             if SNItem.Status=snstInUse then
             begin
                  N:=cxGridSelSNTable.DataController.AppendRecord;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSN_USER_NAME.Index]:=SNItem.UserName;
             end;
        end;
     finally
        cxGridSelSNTable.EndUpdate;
     end;
     if cxGridSelSNTable.DataController.RecordCount>0 then
     begin
          cxGridSelSNTable.ViewData.Records[0].Selected:=True;
          cxGridSelSNTable.ViewData.Records[0].Focused:=True;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.DoQuickSearchAvailableSN(const Text: String);
var i,N:integer;
    S:String;
begin
     cxGridAvSNTable.Controller.ClearSelection;
     cxGridAvSNTable.BeginUpdate;
     try
        for i := 0 to cxGridAvSNTable.DataController.RecordCount - 1 do
        begin
             S:=UpperCase(cxGridAvSNTable.DataController.Values[i,cxGridAvSNTable_SN.Index]);
             if Pos(Text,S)>0 then
             begin
                  N:=cxGridAvSNTable.DataController.GetRowIndexByRecordIndex(i,true);
                  cxGridAvSNTable.Controller.FocusedRecordIndex:=i;
                  cxGridAvSNTable.DataController.SelectRows(N,N);
             end;
        end;
     finally
        cxGridAvSNTable.EndUpdate;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.DoQuickSearchSelectedSN(const Text: String);
var i,N:integer;
    S:String;
begin
     cxGridSelSNTable.Controller.ClearSelection;
     cxGridSelSNTable.BeginUpdate;
     try
        for i := 0 to cxGridSelSNTable.DataController.RecordCount - 1 do
        begin
             S:=UpperCase(cxGridSelSNTable.DataController.Values[i,cxGridSelSNTable_SN.Index]);
             if Pos(UpperCase(Text),S)>0 then
             begin
                  N:=cxGridSelSNTable.DataController.GetRowIndexByRecordIndex(i,true);
                  cxGridSelSNTable.DataController.FocusedRecordIndex:=i;
                  cxGridSelSNTable.DataController.SelectRows(N,N);
             end;
        end;
     finally
        cxGridSelSNTable.EndUpdate;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.edQuickSearchAvChange(Sender: TObject);
begin
     DoQuickSearchAvailableSN(edQuickSearchAv.Text);
end;

procedure TfrmRealizareaSelectSNDlg.edQuickSearchSelChange(Sender: TObject);
begin
     DoQuickSearchSelectedSN(edQuickSearchSel.Text);
end;

procedure TfrmRealizareaSelectSNDlg.AddSelectedSerialNumbers;
var i: Integer;
    N:integer;
    SNItem:TSWNSNItem;
    key:Word;
begin
     cxGridAvSNTable.BeginUpdate;
     cxGridSelSNTable.BeginUpdate;
     try
        for i := 0 to cxGridAvSNTable.Controller.SelectedRecordCount-1 do
        begin
             SNItem:=fSNList.Find(cxGridAvSNTable.Controller.SelectedRecords[i].Values[cxGridAvSNTable_SN.Index]);
             if Assigned(SNItem) then
             begin
                  if SNItem.Status=snstNew then SNItem.Status:=snstInUseNew
                  else
                  if SNItem.Status=snstInUseDeleted then SNItem.Status:=snstInUse;

                  N:=cxGridSelSNTable.DataController.AppendRecord;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSN_USER_NAME.Index]:=dmDB.CurrentUserFullName;
             end;
        end;
        cxGridAvSNTable.DataController.DeleteSelection;

        if cxGridAvSNTable.DataController.RecordCount>0 then
        begin
             Key:=32;
             cxGridAvSNTable.Controller.DoKeyDown(Key,[]);
             cxGridSelSNTable.Controller.DoKeyDown(Key,[]);
        end;
     finally
        cxGridSelSNTable.EndUpdate;
        cxGridAvSNTable.EndUpdate;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if ModalResult<>mrOk then
     begin
          if Not FReadOnly then fMasterDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.FormCreate(Sender: TObject);
begin
     fOwnWarranty:=0;
     fSNList:=TSWNSNList.Create;
end;

procedure TfrmRealizareaSelectSNDlg.FormDestroy(Sender: TObject);
begin
     fSNList.Free;
end;

procedure TfrmRealizareaSelectSNDlg.GetOwnWarranty;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.SQL.Add('SELECT WARRANTY FROM TS_GOODS WHERE GOODSID=:GOODSID');
        Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
        Query.ExecSQL;
        if Not Query.Eof then fOwnWarranty := Query.Fields[0].AsInteger;
     finally
        Query.Free;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.IBCSetSerialsAfterDelete(DataSet: TDataSet);
var N:integer;
begin
     N:=cxGridAvSNTable.DataController.AppendRecord;
     cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_SN.Index]:=fSNtoDelete;
end;

procedure TfrmRealizareaSelectSNDlg.IBCSetSerialsBeforeDelete(DataSet: TDataSet);
begin
     fSNtoDelete:=DataSet.FieldByName('SN').AsString;
end;

procedure TfrmRealizareaSelectSNDlg.BindingDataSource;
begin
     inherited;

     fSerialsCount:=fMasterDataSet.FieldByName('QTY').AsInteger;

     edGOODSID.DataBinding.DataSource:=fMasterDataSource;
     edGOODS_NAME.DataBinding.DataSource:=fMasterDataSource;
     edQTY.DataBinding.DataSource:=fMasterDataSource;
end;

procedure TfrmRealizareaSelectSNDlg.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then
     begin
          if AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.LockGoods;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;

        Query.SQL.Add('SELECT NULL FROM TDB_JURNAL_R');
        Query.SQL.Add('WHERE DOCID=:DOCID AND GOODSID=:GOODSID');
        Query.SQL.Add('FOR UPDATE WITH LOCK');
        Query.ParamByName('DOCID').Value:=fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('GOODSID').Value:=fMasterDataSet.FieldByName('GOODSID').Value;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.Prepare;
begin
     if FReadOnly then
     begin
          dtDialogTitle.Color:=cCOLOR_DocReadOnly;
          Caption:='Серийные номера';
          dtDialogTitle.Title:=Caption;
          dtDialogTitle.Text:='Просмотр серийных номеров товара';

          cxGridAvSN.Enabled:=False;

          btnOk.Visible:=False;
          btnCancel.Default:=True;
          btnCancel.Caption:='Закрыть';

          Label1.Visible:=False;
          edQuickSearchAv.Visible:=False;
          Label2.Visible:=False;
          edQuickSearchSel.Visible:=False;
     end;

     if Not FReadOnly then fMasterDataSet.UpdateTransaction.StartTransaction;
     try
        if Not FReadOnly then LockGoods;

        if Not FReadOnly then ReadAvailableSerialsFromDB;
        ReadSerialsInUseFromDB;
        if Not FReadOnly then GetOwnWarranty;

        if Not FReadOnly then DisplayAvailableSerials;
        DisplaySerialsInUse;

        if Not FReadOnly then cxGridSelSNTable.DataController.OnDataChanged:=WhenGridDataChanged;
        SelectionChanged;
        ShowInfoForUser;

     except
        if Not FReadOnly then fMasterDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.ReadAvailableSerialsFromDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     cxGridAvSNTable.BeginUpdate;
     try
        Query.Connection:=fIBCConnection;
        if FReadOnly then Query.Transaction:=fMasterDataSet.Transaction
        else
        begin
             Query.AutoCommit:=False;
             Query.Transaction:=fMasterDataSet.UpdateTransaction;
        end;
        Query.SQL.Text:='EXECUTE PROCEDURE GET_SN_DEP_GOODS_REALIZARE(:GOODSID,:DATA)';
        Query.ParamByName('GOODSID').AsInteger:=fMasterDataSet.FieldByName('GOODSID').AsInteger;
        Query.ParamByName('DATA').AsDate:=FDocsDataSet.FieldByName('DATA').AsDateTime;
        Query.ExecSQL;
        Query.SQL.Text:='SELECT SN FROM TMP_SN ORDER BY SN';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             fSNList.Add(Query.Fields[0].AsString);
             Query.Next;
        end;
        Query.Close;
     finally
        cxGridAvSNTable.EndUpdate;
        Query.Free;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.ReadSerialsInUseFromDB;
var Query:TIBCQuery;
    item:TSWNSNItem;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.Connection:=fIBCConnection;
        if FReadOnly then Query.Transaction:=fMasterDataSet.Transaction
        else
        begin
             Query.AutoCommit:=False;
             Query.Transaction:=fMasterDataSet.UpdateTransaction;
        end;
        Query.SQL.Add('SELECT SN, CREATED_BY, (SELECT FULL_NAME FROM TS_USERS WHERE TS_USERS.USERID=CREATED_BY) FROM TDB_SN_R');
        Query.SQL.Add('WHERE DOCID=:DOCID and GOODSID=:GOODSID');
        Query.ParamByName('DOCID').Value:=fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('GOODSID').Value:=fMasterDataSet.FieldByName('GOODSID').Value;
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             item:=fSNList.Add(Query.Fields[0].AsString);
             item.UserID:=Query.Fields[1].AsInteger;
             item.UserName:=Query.Fields[2].AsString;
             item.Status:=snstInUse;
             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.RemoveSelectedSerialNumbers;
var i: Integer;
    N:integer;
    SNItem:TSWNSNItem;
    Key:Word;
begin
     cxGridAvSNTable.BeginUpdate;
     cxGridSelSNTable.BeginUpdate;
     try
        for i := 0 to cxGridSelSNTable.Controller.SelectedRecordCount-1 do
        begin
             SNItem:=fSNList.Find2(cxGridSelSNTable.Controller.SelectedRecords[i].Values[cxGridSelSNTable_SN.Index],[snstInUseNew,snstInUse]);
             if Assigned(SNItem) then
             begin
                  if SNItem.Status=snstInUseNew then SNItem.Status:=snstNew
                  else
                  if SNItem.Status=snstInUse then SNItem.Status:=snstInUseDeleted;

                  N:=cxGridAvSNTable.DataController.AppendRecord;
                  cxGridAvSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
             end;
        end;
        cxGridSelSNTable.DataController.DeleteSelection;

        if cxGridSelSNTable.DataController.RecordCount>0 then
        begin
             Key:=32;
             cxGridAvSNTable.Controller.DoKeyDown(Key,[]);
             cxGridSelSNTable.Controller.DoKeyDown(Key,[]);
        end;
     finally
        cxGridSelSNTable.EndUpdate;
        cxGridAvSNTable.EndUpdate;
     end;
end;

function TfrmRealizareaSelectSNDlg.SaveSNtoDB:Boolean;
var Query:TIBCQuery;
    i:integer;
    SNItem:TSWNSNItem;
begin
     Result:=false;

     Query:=TIBCQuery.Create(self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fMasterDataSet.UpdateTransaction;
        try
           // delete items
           Query.SQL.Add('DELETE FROM TDB_SN_R');
           Query.SQL.Add('WHERE DOCID=:DOCID and GOODSID=:GOODSID and SN=:SN');
           Query.ParamByName('DOCID').Value:=fMasterDataSet.FieldByName('DOCID').Value;
           Query.ParamByName('GOODSID').Value:=fMasterDataSet.FieldByName('GOODSID').Value;

           for i := 0 to fSNList.Count - 1 do
           begin
                SNItem:=fSNList[i];
                if SNItem.Status=snstInUseDeleted then
                begin
                     Query.ParamByName('SN').asString:=SNItem.SN;
                     Query.ExecSQL;
                end;
           end;

           // add new items
           Query.SQL.Clear;
           Query.SQL.Add('INSERT INTO TDB_SN_R (DOCID,GOODSID,SN,CREATED_BY)');
           Query.SQL.Add('VALUES (:DOCID,:GOODSID,:SN,:CREATED_BY)');
           Query.ParamByName('DOCID').Value:=fMasterDataSet.FieldByName('DOCID').Value;
           Query.ParamByName('GOODSID').Value:=fMasterDataSet.FieldByName('GOODSID').Value;
           Query.ParamByName('CREATED_BY').asInteger:=UserID;

           for i := 0 to fSNList.Count - 1 do
           begin
                SNItem:=fSNList[i];
                if SNItem.Status=snstInUseNew then
                begin
                     Query.ParamByName('SN').asString:=SNItem.SN;
                     Query.ExecSQL;
                end;
           end;

           Result:=True;
        except on E:Exception do
           begin
                if Not ProcessSWNError(E) then raise;
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmRealizareaSelectSNDlg.sbAddAllSerialsClick(Sender: TObject);
begin
     cxGridAvSNTable.BeginUpdate;
     try
        cxGridAvSNTable.DataController.SelectAll;
        AddSelectedSerialNumbers;
     finally
        cxGridAvSNTable.EndUpdate;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.sbAddSerialsClick(Sender: TObject);
begin
     AddSelectedSerialNumbers;
end;

procedure TfrmRealizareaSelectSNDlg.sbRemoveAllSerialsClick(Sender: TObject);
begin
     cxGridSelSNTable.BeginUpdate;
     try
        cxGridSelSNTable.DataController.SelectAll;
        RemoveSelectedSerialNumbers;
     finally
        cxGridSelSNTable.EndUpdate;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.sbRemoveSerialsClick(Sender: TObject);
begin
     RemoveSelectedSerialNumbers;
end;

procedure TfrmRealizareaSelectSNDlg.CopyFocusedSNToClipboard(const Grid: TcxGridTableView; const ColumnIndex:integer);
var i:integer;
    S:String;
begin
     if Grid.Controller.SelectedRecordCount>0 then
     begin
          S:='';
          for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
          S:=S+Grid.Controller.SelectedRecords[i].Values[ColumnIndex]+#13#10;
          Clipboard.AsText:=S;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.SelectionChanged;
begin
     sbAddSerials.Enabled:=(not FReadOnly) and (cxGridAvSNTable.Controller.SelectedRecordCount>0);
     sbAddAllSerials.Enabled:=(not FReadOnly) and (cxGridAvSNTable.DataController.RecordCount>0);
     sbRemoveSerials.Enabled:=(not FReadOnly) and (cxGridSelSNTable.Controller.SelectedRecordCount>0);
     sbRemoveAllSerials.Enabled:=(not FReadOnly) and (cxGridSelSNTable.DataController.RecordCount>0);
end;

procedure TfrmRealizareaSelectSNDlg.SetDocsDataSet(const Value: TIBCQuery);
begin
     FDocsDataSet := Value;
end;

procedure TfrmRealizareaSelectSNDlg.SetReadOnly(const Value: Boolean);
begin
     FReadOnly := Value;
end;

procedure TfrmRealizareaSelectSNDlg.ShowInfoForUser;
var Count:integer;
begin
     if VarIsNumeric(cxGridSelSNTable.DataController.Summary.FooterSummaryValues[0])
      then Count:=cxGridSelSNTable.DataController.Summary.FooterSummaryValues[0]
      else Count:=0;
     if fSerialsCount=Count then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsOk;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsOk;
     end
     else
     if Count<fSerialsCount then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsLess;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsLess;
     end
     else
     begin
          lbInfo.Caption:=cMSG_SN_CountIsBigger;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsBigger;
     end;
end;

procedure TfrmRealizareaSelectSNDlg.WhenGridDataChanged(Sender: TObject);
begin
     ShowInfoForUser;
end;

end.

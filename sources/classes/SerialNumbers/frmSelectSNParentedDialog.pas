unit frmSelectSNParentedDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, SWNSNClasses,
  Dialogs, DialogTitle, cxCustomData, DB,
  StdCtrls, Buttons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridCustomView, cxGrid, DBAccess, IBC, cxDBEdit, ExtCtrls, cxDropDownEdit,

  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxFilter,
  cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, Vcl.Menus, cxMaskEdit,
  cxClasses, cxTextEdit;

type

  TfrmSelectSNParentedDlg = class(TSWNMasteredFormClass)
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
    edGOODSID: TcxDBTextEdit;
    cxGridAvSNTable: TcxGridTableView;
    cxGridAvSNTable_IMG: TcxGridColumn;
    cxGridAvSNTable_SN: TcxGridColumn;
    cxGridSelSNTable: TcxGridTableView;
    cxGridSelSNTable_IMG: TcxGridColumn;
    cxGridSelSNTable_SN: TcxGridColumn;
    sbRemoveAllSerials: TSpeedButton;
    Label1: TLabel;
    edMasterGOODS_NAME: TcxDBTextEdit;
    edMasterGOODSID: TcxDBTextEdit;
    Label2: TLabel;
    cmbKitSN: TcxComboBox;
    lbInfo: TLabel;
    edQuickSearchAv: TEdit;
    Label5: TLabel;
    cxGridSelSN_USER_NAME: TcxGridColumn;
    edQuickSearchSel: TEdit;
    Label6: TLabel;
    btnOk: TcxButton;
    btnCancel: TcxButton;
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
    procedure cmbKitSNPropertiesEditValueChanged(Sender: TObject);
    procedure cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQuickSearchAvChange(Sender: TObject);
    procedure edQuickSearchSelChange(Sender: TObject);
  private
    { Private declarations }
    fSerialsCount:integer;
    fOwnWarranty:integer;
    fSNtoDelete:String;
    fSNList:TSWNSNList;
    fChildDataSet:TCustomIBCDataSet;
    fChildDataSource:TIBCDataSource;
    fCurrentKitSN:String;
    FReadOnly: Boolean;

    procedure SelectionChanged;

    procedure ReadAvailableSerialsFromDB;
    procedure ReadKitSerials;
    procedure ReadSerialsInUseFromDB;
    procedure GetOwnWarranty;

    procedure DisplayAvailableSerials;
    procedure DisplaySerialsInUse(const KitSN:String);

    procedure AddSelectedSerialNumbers;
    procedure RemoveSelectedSerialNumbers;

    procedure LockGoods;
    procedure SaveSNtoDB;

    procedure WhenGridDataChanged(Sender: TObject);
    function GetTotalSelectedSNCount:integer;
    procedure ShowInfoForUser;

    procedure CopyFocusedSNToClipboard(const Grid:TcxGridTableView; const ColumnIndex:integer);
    procedure SetReadOnly(const Value: Boolean);

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
    constructor Create(const AOwner:TComponent; const MasterDataSet,ChildDataSet:TCustomIBCDataSet; const MasterDataSource,ChildDataSource:TIBCDataSource);reintroduce;

    property ReadOnly:Boolean read FReadOnly write SetReadOnly;
  end;

implementation

uses SWNValueStorageUnit, SWNConst, ClipBrd, SWNDBErrors;

{$R *.dfm}

{ TfrmSelectSNDlg }

procedure TfrmSelectSNParentedDlg.btnOkClick(Sender: TObject);
begin
     try
        SaveSNtoDB;
        fChildDataSet.UpdateTransaction.Commit;
        ModalResult:=mrOk;
     except on E:Exception do
        if Not ProcessSWNError(E) then raise;
     end;
end;

procedure TfrmSelectSNParentedDlg.cmbKitSNPropertiesEditValueChanged(Sender: TObject);
begin
     DisplaySerialsInUse(cmbKitSN.Text);
end;

procedure TfrmSelectSNParentedDlg.CopyFocusedSNToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
begin
     if Grid.Controller.FocusedRecordIndex>=0 then
     Clipboard.AsText:=Grid.DataController.Values[Grid.Controller.FocusedRecordIndex,ColumnIndex];
end;

constructor TfrmSelectSNParentedDlg.Create(const AOwner: TComponent; const MasterDataSet, ChildDataSet: TCustomIBCDataSet;
  const MasterDataSource, ChildDataSource: TIBCDataSource);
begin
     fChildDataSet:=ChildDataSet;
     fChildDataSource:=ChildDataSource;
     inherited Create(AOwner,MasterDataSet,MasterDataSource);
end;

procedure TfrmSelectSNParentedDlg.cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     AddSelectedSerialNumbers;
     AHandled:=True;
end;

procedure TfrmSelectSNParentedDlg.cxGridAvSNTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmSelectSNParentedDlg.cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmSelectSNParentedDlg.cxGridAvSNTableSelectionChanged(Sender: TcxCustomGridTableView);
begin
     SelectionChanged;
end;

procedure TfrmSelectSNParentedDlg.cxGridSelSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     RemoveSelectedSerialNumbers;
     AHandled:=True;
end;

procedure TfrmSelectSNParentedDlg.cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=65) and (Shift=[ssCtrl]) then cxGridSelSNTable.DataController.SelectAll // Ctrl+A
     else
     if (Key=VK_DELETE) then sbRemoveSerialsClick(sbRemoveSerials) // remove selected only
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

procedure TfrmSelectSNParentedDlg.DisplayAvailableSerials;
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

procedure TfrmSelectSNParentedDlg.DisplaySerialsInUse(const KitSN:String);
var i,N:integer;
    SNItem:TSWNSNItem;
begin
     fCurrentKitSN:=KitSN;
     cxGridSelSNTable.BeginUpdate;
     try
        cxGridSelSNTable.DataController.SelectAll;
        cxGridSelSNTable.DataController.DeleteSelection;

        for i := 0 to fSNList.Count-1 do
        begin
             SNItem:=fSNList[i];
             if (SNItem.Status in [snstInUse,snstInUseNew,snstInUseUpdate]) and (SNItem.Complect_SN=KitSN) then
             begin
                  N:=cxGridSelSNTable.DataController.AppendRecord;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSN_USER_NAME.Index]:='';
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

procedure TfrmSelectSNParentedDlg.DoQuickSearchAvailableSN(const Text: String);
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

procedure TfrmSelectSNParentedDlg.DoQuickSearchSelectedSN(const Text: String);
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

procedure TfrmSelectSNParentedDlg.edQuickSearchAvChange(Sender: TObject);
begin
     DoQuickSearchAvailableSN(edQuickSearchAv.Text);
end;

procedure TfrmSelectSNParentedDlg.edQuickSearchSelChange(Sender: TObject);
begin
     DoQuickSearchSelectedSN(edQuickSearchSel.Text);
end;

procedure TfrmSelectSNParentedDlg.AddSelectedSerialNumbers;
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
                  if SNItem.Status=snstNew then
                  begin
                       SNItem.Status:=snstInUseNew;
                       SNItem.Complect_SN:=fCurrentKitSN;
                  end
                  else
                  if SNItem.Status=snstInUseDeleted then
                  begin
                       if SNItem.Complect_SN_Initial=fCurrentKitSN
                        then SNItem.Status:=snstInUse
                        else SNItem.Status:=snstInUseUpdate;

                       SNItem.Complect_SN:=fCurrentKitSN;
                  end;

                  N:=cxGridSelSNTable.DataController.AppendRecord;
                  cxGridSelSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
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

procedure TfrmSelectSNParentedDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if ModalResult<>mrOk then
     begin
          if fChildDataSet.UpdateTransaction.Active then
               fChildDataSet.UpdateTransaction.Rollback;
     end;
end;

procedure TfrmSelectSNParentedDlg.FormCreate(Sender: TObject);
begin
     fOwnWarranty:=0;
     fSNList:=TSWNSNList.Create;
end;

procedure TfrmSelectSNParentedDlg.FormDestroy(Sender: TObject);
begin
     fSNList.Free;
end;

procedure TfrmSelectSNParentedDlg.GetOwnWarranty;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.SQL.Add('SELECT WARRANTY FROM TS_GOODS WHERE GOODSID=:GOODSID');
        Query.ParamByName('GOODSID').AsInteger := fChildDataSet.FieldByName('GOODSID').AsInteger;
        Query.ExecSQL;
        if Not Query.Eof then fOwnWarranty := Query.Fields[0].AsInteger;
     finally
        Query.Free;
     end;
end;

function TfrmSelectSNParentedDlg.GetTotalSelectedSNCount: integer;
var i:integer;
    SNItem:TSWNSNItem;
begin
     Result:=0;
     for i := 0 to fSNList.Count - 1 do
     begin
          SNItem:=fSNList[i];
          if SNItem.Status in [snstInUse,snstInUseNew,snstInUseUpdate] then Inc(Result);
     end;
end;

procedure TfrmSelectSNParentedDlg.IBCSetSerialsAfterDelete(DataSet: TDataSet);
var N:integer;
begin
     N:=cxGridAvSNTable.DataController.AppendRecord;
     cxGridAvSNTable.DataController.Values[N,cxGridAvSNTable_SN.Index]:=fSNtoDelete;
end;

procedure TfrmSelectSNParentedDlg.IBCSetSerialsBeforeDelete(DataSet: TDataSet);
begin
     fSNtoDelete:=DataSet.FieldByName('SN').AsString;
end;

procedure TfrmSelectSNParentedDlg.BindingDataSource;
begin
     inherited;

     FReadOnly:=False;
     fCurrentKitSN := '';
     fSerialsCount:=fChildDataSet.FieldByName('QTY').AsInteger;

     edGOODSID.DataBinding.DataSource:=fChildDataSource;
     edGOODS_NAME.DataBinding.DataSource:=fChildDataSource;
     edQTY.DataBinding.DataSource:=fChildDataSource;

     edMasterGOODSID.DataBinding.DataSource:=fMasterDataSource;
     edMasterGOODS_NAME.DataBinding.DataSource:=fMasterDataSource;
end;

procedure TfrmSelectSNParentedDlg.LoadStates;
begin
     AppUserConfigStorage.FormPositions.ReadFormPos(Self);
end;

procedure TfrmSelectSNParentedDlg.LockGoods;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fChildDataSet.UpdateTransaction;
        Query.SQL.Add('SELECT NULL FROM TDB_JURNAL');
        Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
        Query.SQL.Add('FOR UPDATE WITH LOCK');
        Query.ParamByName('DOCID').Value:=fChildDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value:=fChildDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value:=fChildDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').Value:=fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
        Query.ParamByName('GOODSID').Value:=fChildDataSet.FieldByName('GOODSID').Value;
        Query.ExecSQL;
     finally
        Query.Free;
     end;
end;

procedure TfrmSelectSNParentedDlg.Prepare;
begin
     if Not FReadOnly then fChildDataSet.UpdateTransaction.StartTransaction;
     try
        if Not FReadOnly then LockGoods;

        GetOwnWarranty;
        if Not FReadOnly then ReadAvailableSerialsFromDB;
        ReadSerialsInUseFromDB;
        ReadKitSerials;

        if FReadOnly then cmbKitSN.Enabled:=False;
        if cmbKitSN.Properties.Items.Count=0 then
        begin
             cxGridAvSN.Enabled:=False;
             cxGridSelSN.Enabled:=False;
             cmbKitSN.Enabled:=False;
             cmbKitSN.Properties.DropDownListStyle:=lsEditList;
             cmbKitSN.Text:='Нет серийного номера!';
        end;

        if FReadOnly then
        begin
             cxGridAvSN.Enabled:=False;
             btnOk.Visible:=False;
             btnCancel.Caption:='Закрыть';
             btnCancel.Default:=True;
             edQuickSearchAv.Enabled:=False;
             edQuickSearchSel.Enabled:=False;
             dtDialogTitle.Color:=cCOLOR_DocReadOnly;
             dtDialogTitle.Text:=cMSG_DIALOG_VIEWONLY_Serials;
        end
        else
        begin
             cxGridSelSNTable.DataController.OnDataChanged:=WhenGridDataChanged;
             DisplayAvailableSerials;
        end;

        SelectionChanged;
        ShowInfoForUser;
     except
        if Not FReadOnly then fChildDataSet.UpdateTransaction.Rollback;
        raise;
     end;
end;

procedure TfrmSelectSNParentedDlg.ReadAvailableSerialsFromDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     cxGridAvSNTable.BeginUpdate;
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fChildDataSet.UpdateTransaction;

        Query.SQL.Text:='EXECUTE PROCEDURE GET_SN_DEP_GOODS(:GOODSID,:DTDEP,:DT,(SELECT DATA FROM TDB_DOCS WHERE DOCID=:DOCID))';
        Query.ParamByName('GOODSID').AsInteger:=fChildDataSet.FieldByName('GOODSID').AsInteger;
        Query.ParamByName('DTDEP').AsInteger:=fChildDataSet.FieldByName('DTDEP').AsInteger;
        Query.ParamByName('DT').AsInteger:=FirmaID;
        Query.ParamByName('DOCID').AsInteger:=fMasterDataSet.FieldByName('DOCID').AsInteger;
        Query.ExecSQL;

        Query.SQL.Text:='SELECT SN, COUNTRYID, VENDORID FROM TMP_SN ORDER BY SN';
        Query.ExecSQL;
        while Not Query.Eof do
        begin
             fSNList.Add(Query.Fields[0].AsString,Query.Fields[1].AsInteger,Query.Fields[2].AsInteger);
             Query.Next;
        end;
        Query.Close;
     finally
        cxGridAvSNTable.EndUpdate;
        Query.Free;
     end;
end;

procedure TfrmSelectSNParentedDlg.ReadKitSerials;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     cmbKitSN.Properties.Items.BeginUpdate;
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fChildDataSet.UpdateTransaction;

        Query.SQL.Add('SELECT SN FROM TDB_SN');
        Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
        Query.ParamByName('DOCID').Value:=fMasterDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value:=fMasterDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value:=fMasterDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').asInteger:=-1;
        Query.ParamByName('GOODSID').Value:=fMasterDataSet.FieldByName('GOODSID').Value;

        Query.ExecSQL;

        while Not Query.Eof do
        begin
             cmbKitSN.Properties.Items.Add(Query.Fields[0].AsString);
             Query.Next;
        end;
        Query.Close;
     finally
        cmbKitSN.Properties.Items.EndUpdate;
        Query.Free;
     end;
     if cmbKitSN.Properties.Items.Count>0 then cmbKitSN.ItemIndex:=0;
end;

procedure TfrmSelectSNParentedDlg.ReadSerialsInUseFromDB;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fChildDataSet.UpdateTransaction;

        Query.SQL.Add('SELECT SN,COUNTRYID,VENDORID, COMPLECT_SN FROM TDB_SN');
        Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
        Query.ParamByName('DOCID').Value:=fChildDataSet.FieldByName('DOCID').Value;
        Query.ParamByName('DTDEP').Value:=fChildDataSet.FieldByName('DTDEP').Value;
        Query.ParamByName('CTDEP').Value:=fChildDataSet.FieldByName('CTDEP').Value;
        Query.ParamByName('GOODSCOMPLECT_ID').Value:=fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
        Query.ParamByName('GOODSID').Value:=fChildDataSet.FieldByName('GOODSID').Value;

        Query.ExecSQL;

        while Not Query.Eof do
        begin
             fSNList.Add(Query.Fields[0].AsString,Query.Fields[1].AsInteger,Query.Fields[2].AsInteger,snstInUse,Query.Fields[3].Value);
             Query.Next;
        end;
        Query.Close;
     finally
        Query.Free;
     end;
end;

procedure TfrmSelectSNParentedDlg.RemoveSelectedSerialNumbers;
var i: Integer;
    N:integer;
    SNItem:TSWNSNItem;
begin
     cxGridAvSNTable.BeginUpdate;
     cxGridSelSNTable.BeginUpdate;
     try
        for i := 0 to cxGridSelSNTable.Controller.SelectedRecordCount-1 do
        begin
             SNItem:=fSNList.Find(cxGridSelSNTable.Controller.SelectedRecords[i].Values[cxGridSelSNTable_SN.Index]);
             if Assigned(SNItem) then
             begin
                  if SNItem.Status=snstInUseNew then SNItem.Status:=snstNew
                  else
                  if SNItem.Status=snstInUse then SNItem.Status:=snstInUseDeleted;

                  SNItem.Complect_SN:=null;

                  N:=cxGridAvSNTable.DataController.AppendRecord;
                  cxGridAvSNTable.DataController.Values[N,cxGridSelSNTable_SN.Index]:=SNItem.SN;
             end;
        end;
        cxGridSelSNTable.DataController.DeleteSelection;

     finally
        cxGridSelSNTable.EndUpdate;
        cxGridAvSNTable.EndUpdate;
     end;

     if cxGridSelSNTable.DataController.RecordCount>0 then
     begin
          //Key:=32;
          //cxGridAvSNTable.Controller.DoKeyDown(Key,[]);
          //cxGridSelSNTable.Controller.DoKeyDown(Key,[]);
          cxGridAvSNTable.ViewData.Records[0].Selected:=True;
          cxGridAvSNTable.ViewData.Records[0].Focused:=True;
          cxGridSelSNTable.ViewData.Records[0].Selected:=True;
          cxGridSelSNTable.ViewData.Records[0].Focused:=True;
     end;
end;

procedure TfrmSelectSNParentedDlg.SaveSNtoDB;
var Query:TIBCQuery;
    i:integer;
    SNItem:TSWNSNItem;
begin
     Query:=TIBCQuery.Create(self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=fIBCConnection;
        Query.Transaction:=fChildDataSet.UpdateTransaction;

        // delete items
        if fSNList.HasItemsOfStatus(snstInUseDeleted) then
        begin
             Query.SQL.Add('DELETE FROM TDB_SN');
             Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID and SN=:SN');
             Query.ParamByName('DOCID').Value:=fChildDataSet.FieldByName('DOCID').Value;
             Query.ParamByName('DTDEP').Value:=fChildDataSet.FieldByName('DTDEP').Value;
             Query.ParamByName('CTDEP').Value:=fChildDataSet.FieldByName('CTDEP').Value;
             Query.ParamByName('GOODSCOMPLECT_ID').Value:=fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
             Query.ParamByName('GOODSID').Value:=fChildDataSet.FieldByName('GOODSID').Value;

             for i := 0 to fSNList.Count - 1 do
             begin
                  SNItem:=fSNList[i];
                  if SNItem.Status=snstInUseDeleted then
                  begin
                       Query.ParamByName('SN').asString:=SNItem.SN;
                       Query.ExecSQL;
                  end;

             end;
        end;

        // add new items
        if fSNList.HasItemsOfStatus(snstInUseNew) then
        begin
             Query.SQL.Clear;
             Query.SQL.Add('INSERT INTO TDB_SN (DOCID,DTDEP,CTDEP,GOODSCOMPLECT_ID,GOODSID,SN,COMPLECT_SN,VENDORWARRANTY,OWNWARRANTY,CREATED_BY,SUMA_ACCIZE,COUNTRYID,VENDORID)');
             Query.SQL.Add('VALUES (:DOCID,:DTDEP,:CTDEP,:GOODSCOMPLECT_ID,:GOODSID,:SN,:COMPLECT_SN,:VENDORWARRANTY,:OWNWARRANTY,:CREATED_BY,:SUMA_ACCIZE,:COUNTRYID,:VENDORID)');
             Query.ParamByName('DOCID').Value:=fChildDataSet.FieldByName('DOCID').Value;
             Query.ParamByName('DTDEP').Value:=fChildDataSet.FieldByName('DTDEP').Value;
             Query.ParamByName('CTDEP').Value:=fChildDataSet.FieldByName('CTDEP').Value;
             Query.ParamByName('GOODSCOMPLECT_ID').Value:=fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
             Query.ParamByName('GOODSID').Value:=fChildDataSet.FieldByName('GOODSID').Value;
             Query.ParamByName('VENDORWARRANTY').asInteger:=fChildDataSet.FieldByName('WARRANTY').AsInteger;;
             Query.ParamByName('OWNWARRANTY').asInteger:=fOwnWarranty;
             Query.ParamByName('CREATED_BY').asInteger:=UserID;
             Query.ParamByName('SUMA_ACCIZE').asInteger:=0;

             for i := 0 to fSNList.Count - 1 do
             begin
                  SNItem:=fSNList[i];
                  if SNItem.Status=snstInUseNew then
                  begin
                       Query.ParamByName('SN').asString:=SNItem.SN;
                       Query.ParamByName('COMPLECT_SN').Value:=SNItem.Complect_SN;
                       Query.ParamByName('COUNTRYID').AsInteger:=SNItem.CountryID;
                       Query.ParamByName('VENDORID').AsInteger:=SNItem.VendorID;
                       Query.ExecSQL;
                  end;
             end;
        end;

        if fSNList.HasItemsOfStatus(snstInUseUpdate) then
        begin
             Query.SQL.Clear;
             Query.SQL.Add('UPDATE TDB_SN SET COMPLECT_SN=:COMPLECT_SN');
             Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID and SN=:SN');
             Query.ParamByName('DOCID').Value:=fChildDataSet.FieldByName('DOCID').Value;
             Query.ParamByName('DTDEP').Value:=fChildDataSet.FieldByName('DTDEP').Value;
             Query.ParamByName('CTDEP').Value:=fChildDataSet.FieldByName('CTDEP').Value;
             Query.ParamByName('GOODSCOMPLECT_ID').Value:=fChildDataSet.FieldByName('GOODSCOMPLECT_ID').Value;
             Query.ParamByName('GOODSID').Value:=fChildDataSet.FieldByName('GOODSID').Value;

             for i := 0 to fSNList.Count - 1 do
             begin
                  SNItem:=fSNList[i];
                  if SNItem.Status=snstInUseUpdate then
                  begin
                       Query.ParamByName('SN').asString:=SNItem.SN;
                       Query.ParamByName('COMPLECT_SN').Value:=SNItem.Complect_SN;
                       Query.ExecSQL;
                  end;
             end;
        end;

     finally
        Query.Free;
     end;
end;

procedure TfrmSelectSNParentedDlg.SaveStates;
begin
     AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmSelectSNParentedDlg.sbAddAllSerialsClick(Sender: TObject);
begin
     cxGridAvSNTable.BeginUpdate;
     try
        cxGridAvSNTable.DataController.SelectAll;
        AddSelectedSerialNumbers;
     finally
        cxGridAvSNTable.EndUpdate;
     end;
end;

procedure TfrmSelectSNParentedDlg.sbAddSerialsClick(Sender: TObject);
begin
     AddSelectedSerialNumbers;
end;

procedure TfrmSelectSNParentedDlg.sbRemoveAllSerialsClick(Sender: TObject);
begin
     cxGridSelSNTable.BeginUpdate;
     try
        cxGridSelSNTable.DataController.SelectAll;
        RemoveSelectedSerialNumbers;
     finally
        cxGridSelSNTable.EndUpdate;
     end;
end;

procedure TfrmSelectSNParentedDlg.sbRemoveSerialsClick(Sender: TObject);
begin
     RemoveSelectedSerialNumbers;
end;

procedure TfrmSelectSNParentedDlg.SelectionChanged;
var B:Boolean;
begin
     B:=cxGridAvSN.Enabled and cxGridSelSN.Enabled;
     sbAddSerials.Enabled:=(cxGridAvSNTable.Controller.SelectedRecordCount>0) and B;
     sbAddAllSerials.Enabled:=(cxGridAvSNTable.DataController.RecordCount>0) and B;
     sbRemoveSerials.Enabled:=(cxGridSelSNTable.Controller.SelectedRecordCount>0) and B;
     sbRemoveAllSerials.Enabled:=(cxGridSelSNTable.DataController.RecordCount>0) and B;
end;

procedure TfrmSelectSNParentedDlg.SetReadOnly(const Value: Boolean);
begin
     FReadOnly := Value;
end;

procedure TfrmSelectSNParentedDlg.ShowInfoForUser;
var N:integer;
begin
     N:=GetTotalSelectedSNCount;

     if N<fSerialsCount then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsLess;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsLess;
     end
     else
     if N>fSerialsCount then
     begin
          lbInfo.Caption:=cMSG_SN_CountIsBigger;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsBigger;
     end
     else
     begin
          lbInfo.Caption:=cMSG_SN_CountIsOk;
          lbInfo.Color:=cCOLOR_PARTNO_CountIsOk;
     end
end;

procedure TfrmSelectSNParentedDlg.WhenGridDataChanged(Sender: TObject);
begin
     ShowInfoForUser;
end;

end.

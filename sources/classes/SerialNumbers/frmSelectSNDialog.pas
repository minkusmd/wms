unit frmSelectSNDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, DB, IBC, cxCustomData, StdCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxGrid, cxDBEdit, Buttons, ExtCtrls, DialogTitle, MemDS,
  DBAccess, cxGridDBTableView, Vcl.ActnList, cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxStyles, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxImageComboBox, cxDBData,
  Vcl.Menus, System.Actions, cxMemo, cxClasses, cxTextEdit, Vcl.Dialogs, dxUIAClasses;

type
  TfrmSelectSNDlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnGoods: TPanel;
    cxLabel1: TLabel;
    edGOODS_NAME: TcxDBTextEdit;
    cxLabel2: TLabel;
    edQTY: TcxDBTextEdit;
    cxGridAvSN: TcxGrid;
    cxGridAvSNLevel: TcxGridLevel;
    sbAddSerials: TSpeedButton;
    sbRemoveSerials: TSpeedButton;
    edGOODSID: TcxDBTextEdit;
    cxGridAvSNTable: TcxGridTableView;
    cxGridAvSNTable_IMG: TcxGridColumn;
    cxGridAvSNTable_SN: TcxGridColumn;
    lbInfo: TLabel;
    edQuickSearchAv: TEdit;
    Label1: TLabel;
    cxGrid1DBSN: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBSN_SN: TcxGridDBColumn;
    cxGrid1DBSN_CREATED_BY_NAME: TcxGridDBColumn;
    IBCDS_SN: TIBCDataSource;
    IBC_SN: TIBCQuery;
    cxGrid1DBSN_CREATED_DATE: TcxGridDBColumn;
    cxDBMemo1: TcxDBMemo;
    IBC_SN_COMMENTS: TIBCQuery;
    IBCDS_SN_COMMENTS: TIBCDataSource;
    IBCDS_AvSN: TIBCDataSource;
    cxGridAvSNDB: TcxGridDBTableView;
    cxGridAvSNDB_IMG: TcxGridDBColumn;
    cxGridAvSNDB_SN: TcxGridDBColumn;
    IBC_AvSN: TIBCQuery;
    cxGrid1DBSN_IMG: TcxGridDBColumn;
    ActionList1: TActionList;
    actAddSerialNumber: TAction;
    actRemoveSerialNumber: TAction;
    btnOk: TcxButton;
    btnCancel: TcxButton;
    procedure actAddSerialNumberExecute(Sender: TObject);
    procedure actRemoveSerialNumberExecute(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
      TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSelSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton:
      TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQuickSearchAvChange(Sender: TObject);
    procedure cxDBMemo1Exit(Sender: TObject);
    procedure cxGrid1DBSNDataControllerDataChanged(Sender: TObject);
    procedure cxDBMemo1Enter(Sender: TObject);
    procedure cxGridAvSNDBDblClick(Sender: TObject);
    procedure cxGrid1DBSNDblClick(Sender: TObject);
    procedure cxGrid1DBSNKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edQuickSearchAvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSerialsCount: integer;
    fOwnWarranty: integer;
    //fSNtoDelete: String;
    //fSNList: TSWNSNList;
    FReadOnly: Boolean;
    FDocsDataSet: TIBCQuery;
    procedure ReadAvailableSerialsFromDB;
    procedure AddSelectedSerialNumbers;
    procedure RemoveSelectedSerialNumbers;
    procedure LockGoods;
    function SaveSNtoDB: Boolean;
    procedure WhenGridDataChanged(Sender: TObject);
    procedure ShowInfoForUser;
    procedure CopyFocusedSNToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetDocsDataSet(const Value: TIBCQuery);
    procedure DoQuickSearchAvailableSN(const Text: string);
    procedure DoQuickSearchSelectedSN(const Text: string);
    procedure SetupSecurityItems; override;
  protected
    { Protected declarations }
    procedure BindingDataSource; override;
    procedure Prepare; override;
    procedure LoadStates; override;
    procedure SaveStates; override;
  public
    { Public declarations }
    property readonly: Boolean read FReadOnly write SetReadOnly;
    property DocsDataSet: TIBCQuery read FDocsDataSet write SetDocsDataSet;
  end;

implementation

uses
  SWNUtils, SWNValueStorageUnit, DataModuleDB, SWNConst, ClipBrd, SWNDBErrors, SWNSecurity, SWNSecurityFlags;

{$R *.dfm}

procedure TfrmSelectSNDlg.actAddSerialNumberExecute(Sender: TObject);
begin
  AddSelectedSerialNumbers;
end;

procedure TfrmSelectSNDlg.actRemoveSerialNumberExecute(Sender: TObject);
begin
  RemoveSelectedSerialNumbers;
end;

{ TfrmSelectSNDlg }

procedure TfrmSelectSNDlg.btnOkClick(Sender: TObject);
begin
  if SaveSNtoDB then
  begin
    try
      fMasterDataSet.UpdateTransaction.Commit;
      ModalResult := mrOk;
    except
      on E: Exception do
        if not ProcessSWNError(E) then
          raise;
    end;
  end;
end;

procedure TfrmSelectSNDlg.cxDBMemo1Enter(Sender: TObject);
begin
  if VarisNull(cxGrid1DBSN.DataController.Values[cxGrid1DBSN.DataController.FocusedRowIndex, cxGrid1DBSN_CREATED_BY_NAME.Index]) then
    ShowInfoDialog('Eroare', 'Pentru introducerea comentariilor, salvati datele!');
end;

procedure TfrmSelectSNDlg.cxDBMemo1Exit(Sender: TObject);
begin
  if IBC_SN_COMMENTS.State in [dsInsert, dsEdit] then
  begin
    IBC_SN_COMMENTS.Post;
  end;
end;

procedure TfrmSelectSNDlg.cxGrid1DBSNDataControllerDataChanged(Sender: TObject);
begin
  if (IBC_SN_COMMENTS.State in [dsEdit, dsInsert]) then
    IBC_SN_COMMENTS.Post;

  // daca numarul de serii corespunde cu qty din jurnal coloram panelul ibInfo!
  WhenGridDataChanged(Sender);
end;

procedure TfrmSelectSNDlg.cxGrid1DBSNDblClick(Sender: TObject);
begin
  actRemoveSerialNumberExecute(Sender);
end;

procedure TfrmSelectSNDlg.cxGrid1DBSNKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  q: TIBCQuery;
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
  // Ctrl+C
  begin
    CopyFocusedSNToClipboard(cxGrid1DBSN,      { cxGridSelSNTable, } cxGrid1DBSN_SN.Index);
    Key := 0;
  end;
//  else if (Key = 70) and (Shift = [ssCtrl]) then // Ctrl+F
//  begin
//    // search
//    edQuickSearchSel.SetFocus;
//    Key := 0;
//  end;
  if Key = VK_F6 then
  begin
    q := TIBCQuery.Create(Self);
    try
      q.sql.Text := 'select d.docid, d.data, d.ct,  c.name from tdb_sn s ' +
        'join tdb_jurnal j on j.docid = s.docid and j.goodsid = s.goodsid and j.dtdep = s.dtdep and j.ctdep = s.ctdep ' +
        'join tdb_docs d on d.docid = s.docid and d.doctypeid = 106 ' + 'join ts_customer c on c.customerid = d.ct ' + 'where sn = :SN ';
      q.ParamByName('SN').AsString := IBC_SN.FieldByName('SN').AsString;
      q.Open;
      MessageDlg('DOCID: '+ q.FieldByName('DOCID').AsString + #13#10 + 'Data: ' + q.FieldByName('Data').AsString + #13#10 + 'Furnizor: ' + q.FieldByName('NAME').AsString, mtInformation,
        [mbOK], 0);
    finally
      q.Free;
    end;
  end;

end;

procedure TfrmSelectSNDlg.cxGridAvSNDBDblClick(Sender: TObject);
begin
  actAddSerialNumberExecute(Sender);
end;

procedure TfrmSelectSNDlg.cxGridAvSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  AddSelectedSerialNumbers;
  AHandled := True;
end;

procedure TfrmSelectSNDlg.cxGridAvSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
  // Ctrl+C
  begin
    CopyFocusedSNToClipboard(cxGridAvSNDB, cxGridAvSNTable_SN.Index);
    Key := 0;
  end
  else if (Key = 70) and (Shift = [ssCtrl]) then // Ctrl+F
  begin
    // search
    edQuickSearchAv.SetFocus;
    Key := 0;
  end;


  if (Key = VK_RETURN) and (Shift = []) and sbAddSerials.Enabled then
  begin
      AddSelectedSerialNumbers;
      Key := 0;
  end;
//  else if (Key = VK_RETURN) and (Shift = [ssCtrl]) and sbAddAllPNs.Enabled then
//    sbAddAllPNsClick(sbAddAllPNs)
//  else if (Key = VK_F2) then
//    ShowSelectCustomNumberToAddDialog
//  else if (Key = VK_SPACE) then
//    FocusTheSameSelectedItem(cxGridAPartsTable, cxGridSPartsTable, cxGridAParts_PARTNO, cxGridSPartsTable_PARTNO)
//  else if (Key = 67) and (Shift = [ssCtrl]) then // Ctrl+C
//  begin
//    CopyFocusedPartNoToClipboard(cxGridAPartsTable, cxGridAParts_PARTNO.Index);
//    Key := 0;
//  end;

end;

procedure TfrmSelectSNDlg.cxGridSelSNTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if (not FReadOnly) then
  begin
    RemoveSelectedSerialNumbers;
    AHandled := True;
  end;
end;

procedure TfrmSelectSNDlg.cxGridSelSNTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = 67) and (Shift = [ssCtrl]) then
  // Ctrl+C
  begin
    CopyFocusedSNToClipboard(cxGrid1DBSN,      { cxGridSelSNTable, } cxGrid1DBSN_SN.Index);
    Key := 0;
  end
end;

procedure TfrmSelectSNDlg.DoQuickSearchAvailableSN(const Text: string);
var
  i, N: integer;
  S: string;
begin
  cxGridAvSNDB.Controller.ClearSelection;
  cxGridAvSNDB.BeginUpdate;
  try
    for i := 0 to cxGridAvSNDB.DataController.RecordCount - 1 do
    begin
      S := UpperCase(cxGridAvSNDB.DataController.Values[i, cxGridAvSNTable_SN.Index]);
      if Pos(Text, S) > 0 then
      begin
        N := cxGridAvSNDB.DataController.GetRowIndexByRecordIndex(i, True);
        cxGridAvSNDB.Controller.FocusedRecordIndex := i;
        cxGridAvSNDB.DataController.SelectRows(N, N);
      end;
    end;
  finally
    cxGridAvSNDB.EndUpdate;
  end;
end;

procedure TfrmSelectSNDlg.DoQuickSearchSelectedSN(const Text: string);
var
  i, N: integer;
  S: string;
begin
  cxGrid1DBSN.Controller.ClearSelection;
  cxGrid1DBSN.BeginUpdate;
  try
    for i := 0 to cxGrid1DBSN.DataController.RecordCount - 1 do
    begin
      S := UpperCase(cxGrid1DBSN.DataController.Values[i, cxGrid1DBSN_SN.Index]);
      if Pos(UpperCase(Text), S) > 0 then
      begin
        N := cxGrid1DBSN.DataController.GetRowIndexByRecordIndex(i, True);
        cxGrid1DBSN.DataController.FocusedRecordIndex := i;
        cxGrid1DBSN.DataController.SelectRows(N, N);
      end;
    end;
  finally
    cxGrid1DBSN.EndUpdate;
  end;
end;

procedure TfrmSelectSNDlg.edQuickSearchAvChange(Sender: TObject);
begin
  DoQuickSearchAvailableSN(edQuickSearchAv.Text);
end;

procedure TfrmSelectSNDlg.AddSelectedSerialNumbers;
begin

  IBC_SN.Insert;
  IBC_SN.fieldByName('DOCID').AsInteger := fMasterDataSet.FieldByName('DOCID').AsInteger;
  IBC_SN.fieldByName('SN').AsString := IBC_AvSN.fieldByName('SN').AsString;
  IBC_SN.fieldByName('GOODSID').AsInteger := fMasterDataSet.FieldByName('GOODSID').AsInteger;
  IBC_SN.fieldByName('CREATED_BY').AsInteger := dmdb.CurrentUserID;
  IBC_SN.fieldByName('CTDEP').Value := fMasterDataSet.fieldByName('CTDEP').Value;
  IBC_SN.fieldByName('DTDEP').Value := fMasterDataSet.fieldByName('DTDEP').Value;
  IBC_SN.fieldByName('goodscomplect_id').Value := fMasterDataSet.fieldByName('goodscomplect_id').Value;
  IBC_SN.fieldByName('vendorwarranty').Value := fMasterDataSet.fieldByName('WARRANTY').AsInteger;
  IBC_SN.fieldByName('ownwarranty').Value := fOwnWarranty;
  IBC_SN.fieldByName('COMPLECT_SN').Value := 'NONE';
  IBC_SN.fieldByName('suma_accize').Value := 0;
  IBC_SN.fieldByName('COUNTRYID').Value := IBC_AvSN.fieldByName('CountryID').AsInteger;
  IBC_SN.fieldByName('VENDORID').Value := IBC_AvSN.fieldByName('VendorID').AsInteger;
  IBC_SN.Post;

  // Delete from tmp_SN
  IBC_AvSN.Delete;
  // IBC_AvSN.Refresh;
end;

procedure TfrmSelectSNDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrOk then
  begin
    if not FReadOnly then
      fMasterDataSet.UpdateTransaction.Rollback;
  end;
end;

procedure TfrmSelectSNDlg.BindingDataSource;
var
  Query: TIBCQuery;
begin
  inherited;
  fSerialsCount := fMasterDataSet.fieldByName('QTY').AsInteger;
  Query := TIBCQuery.Create(self);
  try
    Query.Transaction := fMasterDataSet.Transaction;
    Query.SQL.Text := 'select warranty from ts_goods where goodsid=:goodsid';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.fieldByName('goodsid').Value;
    Query.Open;

    fOwnWarranty := Query.fieldByName('WARRANTY').AsInteger;

  finally
    Query.Free;
  end;

  edGOODSID.DataBinding.DataSource := fMasterDataSource;
  edGOODS_NAME.DataBinding.DataSource := fMasterDataSource;
  edQTY.DataBinding.DataSource := fMasterDataSource;
  IBC_SN.Open;
  IBC_SN_COMMENTS.Open;
end;

procedure TfrmSelectSNDlg.LoadStates;
begin
  AppUserConfigStorage.FormPositions.ReadFormPos(self);
end;

procedure TfrmSelectSNDlg.LockGoods;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(self);
  try
    Query.AutoCommit := False;
    Query.Connection := fIBCConnection;
    Query.Transaction := fMasterDataSet.UpdateTransaction;

    Query.SQL.Add('SELECT NULL FROM TDB_JURNAL');
    Query.SQL.Add('WHERE DOCID=:DOCID and DTDEP=:DTDEP and CTDEP=:CTDEP and GOODSCOMPLECT_ID=:GOODSCOMPLECT_ID and GOODSID=:GOODSID');
    Query.SQL.Add('FOR UPDATE WITH LOCK');
    Query.ParamByName('DOCID').Value := fMasterDataSet.fieldByName('DOCID').Value;
    Query.ParamByName('DTDEP').Value := fMasterDataSet.fieldByName('DTDEP').Value;
    Query.ParamByName('CTDEP').Value := fMasterDataSet.fieldByName('CTDEP').Value;
    Query.ParamByName('GOODSCOMPLECT_ID').Value := fMasterDataSet.fieldByName('GOODSCOMPLECT_ID').Value;
    Query.ParamByName('GOODSID').Value := fMasterDataSet.fieldByName('GOODSID').Value;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TfrmSelectSNDlg.Prepare;
begin
  if FReadOnly then
  begin
    dtDialogTitle.Color := cCOLOR_DocReadOnly;
    Caption := 'Numere de serii';
    dtDialogTitle.Title := Caption;
    dtDialogTitle.Text := 'Vizualizarea numerilor de serii';

    cxGridAvSN.Enabled := False;

    btnOk.Visible := False;
    btnCancel.Default := True;
    btnCancel.Caption := cMSG_ButtonClose;
  end;

  if not FReadOnly then
    fMasterDataSet.UpdateTransaction.StartTransaction;
  try
    if not FReadOnly then
      LockGoods;

    if not FReadOnly then
      ReadAvailableSerialsFromDB;

    ShowInfoForUser;
  except
    begin
      if not FReadOnly then
        fMasterDataSet.UpdateTransaction.Rollback;
      raise;
    end;
  end;
end;

procedure TfrmSelectSNDlg.ReadAvailableSerialsFromDB;
var
  Query: TIBCQuery;
begin
  IBC_AvSN.Close;
  Query := TIBCQuery.Create(self);
  try
    Query.Connection := fIBCConnection;
    if FReadOnly then
      Query.Transaction := fMasterDataSet.Transaction
    else
    begin
      Query.AutoCommit := False;
      Query.Transaction := fMasterDataSet.UpdateTransaction;
    end;
    Query.SQL.Text := 'EXECUTE PROCEDURE GET_SN_DEP_GOODS(:GOODSID,:DTDEP,:DT,:DATA)';
    Query.ParamByName('GOODSID').AsInteger := fMasterDataSet.fieldByName('GOODSID').AsInteger;
    Query.ParamByName('DTDEP').AsInteger := fMasterDataSet.fieldByName('DTDEP').AsInteger;
    Query.ParamByName('DT').AsInteger := DocsDataSet.fieldByName('DT').AsInteger; // FirmaID;
    Query.ParamByName('DATA').AsDate := DocsDataSet.fieldByName('DATA').AsDateTime;
    Query.ExecSQL;

    IBC_AvSN.Open;

  finally
    Query.Free;
  end;
end;

procedure TfrmSelectSNDlg.RemoveSelectedSerialNumbers;
begin
  try
    IBC_AvSN.InsertRecord([IBC_SN.fieldByName('SN').AsString, IBC_SN.fieldByName('COUNTRYID').AsInteger, IBC_SN.fieldByName('VENDORID').AsInteger]);

    IBC_SN.Delete;

  except
    on E: Exception do
      if not ProcessSWNError(E) then
        raise;
  end;
end;

function TfrmSelectSNDlg.SaveSNtoDB: Boolean;
begin
  Result := False;
  try
    IBC_SN.ApplyUpdates;
    IBC_SN.CommitUpdates;

    if IBC_SN_COMMENTS.State in [dsEdit, dsInsert] then
      IBC_SN_COMMENTS.Post;

    IBC_SN_COMMENTS.ApplyUpdates;
    IBC_SN_COMMENTS.CommitUpdates;

    Result := True;
  except
    on E: Exception do
    begin
      if not ProcessSWNError(E) then
        raise;
    end;
  end;
end;

procedure TfrmSelectSNDlg.SaveStates;
begin
  AppUserConfigStorage.FormPositions.SaveFormPos(self);
end;

procedure TfrmSelectSNDlg.CopyFocusedSNToClipboard(const Grid: TcxGridTableView; const ColumnIndex: integer);
var
  i: integer;
  S: string;
begin
  if Grid.Controller.SelectedRecordCount > 0 then
  begin
    S := '';
    for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
      S := S + Grid.Controller.SelectedRecords[i].Values[ColumnIndex] + #13#10;
    Clipboard.AsText := S;
  end;
end;

procedure TfrmSelectSNDlg.edQuickSearchAvKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    actAddSerialNumberExecute(Sender);

end;

procedure TfrmSelectSNDlg.SetDocsDataSet(const Value: TIBCQuery);
begin
  FDocsDataSet := Value;
end;

procedure TfrmSelectSNDlg.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TfrmSelectSNDlg.SetupSecurityItems;
begin
  inherited;
  actRemoveSerialNumber.Enabled := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_Rezervare_Excluderea_numerilor_de_serie_sau_partida);
//  sbRemoveSerials.Enabled := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_VINZARE_Rezervare_Excluderea_numerilor_de_serie_sau_partida);
end;

procedure TfrmSelectSNDlg.ShowInfoForUser;
begin
  if fSerialsCount = IBC_SN.RecordCount then
  begin
    lbInfo.Caption := cMSG_SN_CountIsOk;
    lbInfo.Color := cCOLOR_PARTNO_CountIsOk;
  end
  else if IBC_SN.RecordCount < fSerialsCount then
  begin
    lbInfo.Caption := cMSG_SN_CountIsLess;
    lbInfo.Color := cCOLOR_PARTNO_CountIsLess;
  end
  else
  begin
    lbInfo.Caption := cMSG_SN_CountIsBigger;
    lbInfo.Color := cCOLOR_PARTNO_CountIsBigger;
  end;
end;

procedure TfrmSelectSNDlg.WhenGridDataChanged(Sender: TObject);
begin
  ShowInfoForUser;
end;

end.


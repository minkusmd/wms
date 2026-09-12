unit frmBonusGoods2Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, Vcl.ExtCtrls,
  DialogTitle, Vcl.StdCtrls, SWNBaseUnit, dxBarExtItems, DBAccess, IBC, MemDS, cxImageComboBox, cxNavigator,
  dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations;

type
  TfrmBonusGoods2Dlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    pnClient: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    dxBarManager: TdxBarManager;
    Panel4: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDockControl2: TdxBarDockControl;
    dxBarDockControl3: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridGoodsTable: TcxGridDBTableView;
    cxGridGoodsLevel: TcxGridLevel;
    cxGridGoods: TcxGrid;
    cxGridAddonsTable: TcxGridDBTableView;
    cxGridAddonsLevel: TcxGridLevel;
    cxGridAddons: TcxGrid;
    dxBarManagerBar1: TdxBar;
    dxBarManagerBar2: TdxBar;
    dxBarManagerBar3: TdxBar;
    bbBonusAdd: TdxBarButton;
    bbBonusEdit: TdxBarButton;
    bbBonusDelete: TdxBarButton;
    bbGoodsNew: TdxBarButton;
    bbGoodsDelete: TdxBarButton;
    bbAddonsNew: TdxBarButton;
    bbAddonsDelete: TdxBarButton;
    btnClose: TButton;
    dxBarStatic1: TdxBarStatic;
    dxBarStatic2: TdxBarStatic;
    IBCQueryBonus: TIBCQuery;
    IBCDataSourceBonus: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_TITLE: TcxGridDBColumn;
    cxGrid_START_DATE: TcxGridDBColumn;
    cxGrid_END_DATE: TcxGridDBColumn;
    cxGrid_REQ_QTY: TcxGridDBColumn;
    cxGrid_BONUS_POINTS: TcxGridDBColumn;
    IBCQueryGoods: TIBCQuery;
    IBCDataSourceGoods: TIBCDataSource;
    cxGridGoods_GOODSID: TcxGridDBColumn;
    cxGridGoods_TITLE: TcxGridDBColumn;
    cxGridGoods_FLG_FOLDER: TcxGridDBColumn;
    IBCQueryAddons: TIBCQuery;
    IBCDataSourceAddons: TIBCDataSource;
    cxGridAddons_IMG: TcxGridDBColumn;
    cxGridAddons_GOODSID: TcxGridDBColumn;
    cxGridAddons_TITLE: TcxGridDBColumn;
    cxGridTable_ORDERNO: TcxGridDBColumn;
    bbBonusSort: TdxBarButton;
    cxGrid_FLG_OLD: TcxGridDBColumn;
    bbBonusTools: TdxBarSubItem;
    bbBonusCopySet: TdxBarButton;
    procedure bbBonusAddClick(Sender: TObject);
    procedure bbBonusEditClick(Sender: TObject);
    procedure bbBonusDeleteClick(Sender: TObject);
    procedure bbGoodsNewClick(Sender: TObject);
    procedure bbGoodsDeleteClick(Sender: TObject);
    procedure bbAddonsNewClick(Sender: TObject);
    procedure bbAddonsDeleteClick(Sender: TObject);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridAddonsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbBonusSortClick(Sender: TObject);
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure bbBonusCopySetClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_CanAdmin:Boolean;
    fLastGoodsID,fLastAddGoodsID:Integer;
    procedure BonusSelectionChanged;
    procedure GoodsSelectionChanged;
    procedure GoodsAddonSelectionChanged;


    procedure ShowAddNewBonusDialog;
    procedure ShowModifyBonusDialog;
    procedure DeleteBonus;
    procedure ShowSortDialog;

    procedure AddNewGoodsDialog;
    procedure DeleteGoods;
    procedure AddNewGoodsDB(const GoodsID:Integer);

    procedure AddGoodsAddonDialog;
    procedure DeleteGoodsAddon;
    procedure AddGoodsAddonDB(const GoodsID:Integer);

    function DoCopyBonusGroup(const GBonusGroupID:Integer):Integer;

  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, System.UITypes,
     SWNUtils, SWNDBErrors, frmBonusGoods2EditorDialog, frmGoods, frmChangeOrderNoDialog, SWNSecurity,
     SWNSecurityFlags;

{ TfrmBonusGoods2Dlg }

procedure TfrmBonusGoods2Dlg.AddGoodsAddonDB(const GoodsID: Integer);
begin
     IBCQueryAddons.UpdateTransaction.StartTransaction;
     try
        IBCQueryAddons.Insert;
        IBCQueryAddons.FieldByName('GBONUSID').AsInteger:=IBCQueryBonus.FieldByName('GBONUSID').AsInteger;
        IBCQueryAddons.FieldByName('GOODSID').AsInteger:=GoodsID;
        IBCQueryAddons.Post;
        IBCQueryAddons.UpdateTransaction.Commit;
     except on E:Exception do
        begin
             IBCQueryAddons.Cancel;
             IBCQueryAddons.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmBonusGoods2Dlg.AddGoodsAddonDialog;
var dialog:TfrmGoodsBrowser;
    N:Integer;
begin
     N:=fLastGoodsID;
     if N=0 then N:=IBCQueryAddons.FieldByName('GOODSID').AsInteger;

     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(N,True,0,'Selectati marfa sau folderul bonus pentru vanzare...') then
        begin
             AddGoodsAddonDB(dialog.GoodsID);
             fLastAddGoodsID:=dialog.GoodsID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoods2Dlg.AddNewGoodsDialog;
var dialog:TfrmGoodsBrowser;
    N:Integer;
begin
     N:=fLastGoodsID;
     if N=0 then N:=IBCQueryGoods.FieldByName('GOODSID').AsInteger;

     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        if dialog.SelectGoods(N,True,0,'Selectati marfa sau folderul pentru vanzare...') then
        begin
             AddNewGoodsDB(dialog.GoodsID);
             fLastGoodsID:=dialog.GoodsID;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoods2Dlg.AddNewGoodsDB(const GoodsID: Integer);
begin
     IBCQueryGoods.UpdateTransaction.StartTransaction;
     try
        IBCQueryGoods.Insert;
        IBCQueryGoods.FieldByName('GBONUSID').AsInteger:=IBCQueryBonus.FieldByName('GBONUSID').AsInteger;
        IBCQueryGoods.FieldByName('GOODSID').AsInteger:=GoodsID;
        IBCQueryGoods.Post;
        IBCQueryGoods.UpdateTransaction.Commit;
     except on E:Exception do
        begin
             IBCQueryGoods.Cancel;
             IBCQueryGoods.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmBonusGoods2Dlg.BonusSelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;

     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;

     bbBonusAdd.Enabled:=fAdd;
     bbBonusEdit.Enabled:=fEdit;
     bbBonusDelete.Enabled:=fDelete;
     bbBonusSort.Enabled:=cxGridTable.DataController.RecordCount>1;
     bbBonusCopySet.Enabled:=fEdit and fSECURITY_CanAdmin;

     GoodsSelectionChanged;
     GoodsAddonSelectionChanged;
end;

procedure TfrmBonusGoods2Dlg.cxGridAddonsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsAddonSelectionChanged;
end;

procedure TfrmBonusGoods2Dlg.cxGridGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     GoodsSelectionChanged;
end;

procedure TfrmBonusGoods2Dlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and (bbBonusEdit.Visible=ivAlways) and bbBonusEdit.Enabled then
     begin
          bbBonusEditClick(bbBonusEdit);
          AHandled:=True;
     end;
end;

procedure TfrmBonusGoods2Dlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGrid_FLG_OLD.Index]) then
     begin
          if (AViewInfo.GridRecord.Values[cxGrid_FLG_OLD.Index]=1) then
          begin
               ACanvas.Font.Style := ACanvas.Font.Style + [fsStrikeOut];
               if Not AViewInfo.Selected then ACanvas.Font.Color := clGrayText;
          end;
     end;
end;

procedure TfrmBonusGoods2Dlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     BonusSelectionChanged;
end;

procedure TfrmBonusGoods2Dlg.DeleteBonus;
begin
     if ShowAskDialog('Stergere grup',Format('Doriti sa stergeti grupul de bonusuri "%s"?',[IBCQueryBonus.FieldByName('TITLE').AsString]))=mrYes then
     begin
          IBCQueryBonus.UpdateTransaction.StartTransaction;
          try
             IBCQueryBonus.Delete;
             IBCQueryBonus.UpdateTransaction.Commit;
          except on E: Exception do
             begin
                  IBCQueryBonus.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmBonusGoods2Dlg.DeleteGoods;
var S1,S2:String;
begin
     if IBCQueryGoods.FieldByName('FLG_FOLDER').AsInteger=1 then
     begin
          S1:='Stergere folder';
          S2:=Format('Doriti sa stergeti grupul de marfuri "%s"?',[IBCQueryGoods.FieldByName('TITLE').AsString]);
     end
     else
     begin
          S1:='Stergere produs';
          S2:=Format('Doriti sa stergeti "%s"?',[IBCQueryGoods.FieldByName('TITLE').AsString]);
     end;

     if ShowAskDialog(S1,S2)=mrYes then
     begin
          IBCQueryGoods.UpdateTransaction.StartTransaction;
          try
             IBCQueryGoods.Delete;
             IBCQueryGoods.UpdateTransaction.Commit;
          except on E: Exception do
             begin
                  IBCQueryGoods.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmBonusGoods2Dlg.DeleteGoodsAddon;
begin
     if ShowAskDialog('Stergere marfa bonus',Format('Doriti sa stergeti marfa bonus "%s"?',[IBCQueryAddons.FieldByName('TITLE').AsString]))=mrYes then
     begin
          IBCQueryAddons.UpdateTransaction.StartTransaction;
          try
             IBCQueryAddons.Delete;
             IBCQueryAddons.UpdateTransaction.Commit;
          except on E: Exception do
             begin
                  IBCQueryAddons.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

function TfrmBonusGoods2Dlg.DoCopyBonusGroup(const GBonusGroupID: Integer): Integer;
var Query:TIBCQuery;
begin
     Result:=-1;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='SELECT NEW_GBONUSID FROM SP_BONUS2_COPY_GROUP(:ID)';
        Query.ParamByName('ID').AsInteger:=GBonusGroupID;
        Query.Transaction.StartTransaction;
        try
           Query.ExecSQL;
           Result:=Query.Fields[0].AsInteger;
           Query.Transaction.Commit;
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

procedure TfrmBonusGoods2Dlg.bbBonusAddClick(Sender: TObject);
begin
     ShowAddNewBonusDialog;
end;

procedure TfrmBonusGoods2Dlg.bbBonusCopySetClick(Sender: TObject);
var newGBonusID:Integer;
begin
     if ShowAskDialog('Copiere grup',Format('Doriti sa faceti o copie a grupului "%s"?',[IBCQueryBonus.FieldByName('TITLE').AsString]))<>mrYes then Exit;
     newGBonusID:=DoCopyBonusGroup(IBCQueryBonus.FieldByName('GBONUSID').AsInteger);
     if newGBonusID>0 then
     begin
          IBCQueryBonus.Refresh;
          IBCQueryBonus.Locate('GBONUSID',newGBonusID,[]);
          ShowInfoDialog('Copiere grup','Gata!');
     end;
end;

procedure TfrmBonusGoods2Dlg.bbBonusEditClick(Sender: TObject);
begin
     ShowModifyBonusDialog;
end;

procedure TfrmBonusGoods2Dlg.bbBonusSortClick(Sender: TObject);
begin
     ShowSortDialog;
end;

procedure TfrmBonusGoods2Dlg.bbBonusDeleteClick(Sender: TObject);
begin
     DeleteBonus;
end;

procedure TfrmBonusGoods2Dlg.bbGoodsNewClick(Sender: TObject);
begin
     AddNewGoodsDialog;
end;

procedure TfrmBonusGoods2Dlg.bbGoodsDeleteClick(Sender: TObject);
begin
     DeleteGoods;
end;

procedure TfrmBonusGoods2Dlg.bbAddonsNewClick(Sender: TObject);
begin
     AddGoodsAddonDialog;
end;

procedure TfrmBonusGoods2Dlg.bbAddonsDeleteClick(Sender: TObject);
begin
     DeleteGoodsAddon;
end;

procedure TfrmBonusGoods2Dlg.GoodsAddonSelectionChanged;
var fAdd,fDelete:Boolean;
begin
     fAdd:=False;
     fDelete:=False;

     if cxGridTable.DataController.RecNo>0 then
     begin
          fAdd:=True;
          if cxGridAddonsTable.DataController.RecNo>0 then
          begin
               fDelete:=True;
          end;
     end;

     bbAddonsNew.Enabled:=fAdd;
     bbAddonsDelete.Enabled:=fDelete;
end;

procedure TfrmBonusGoods2Dlg.GoodsSelectionChanged;
var fAdd,fDelete:Boolean;
begin
     fAdd:=False;
     fDelete:=False;

     if cxGridTable.DataController.RecNo>0 then
     begin
          fAdd:=True;
          if cxGridGoodsTable.DataController.RecNo>0 then
          begin
               fDelete:=True;
          end;
     end;

     bbGoodsNew.Enabled:=fAdd;
     bbGoodsDelete.Enabled:=fDelete;
end;

procedure TfrmBonusGoods2Dlg.Prepare;
begin
     fLastGoodsID:=0;
     fLastAddGoodsID:=0;

     IBCQueryBonus.Active:=True;
     IBCQueryGoods.Active:=True;
     IBCQueryAddons.Active:=True;

     BonusSelectionChanged;
end;

procedure TfrmBonusGoods2Dlg.SetupSecurityItems;
begin
     fSECURITY_CanAdmin:=True;
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_БТ_Администрировать) then
     begin
          fSECURITY_CanAdmin:=False;

          bbBonusAdd.Visible:=ivNever;
          bbBonusEdit.Visible:=ivNever;
          bbBonusDelete.Visible:=ivNever;
          bbBonusSort.Visible:=ivNever;
          bbBonusCopySet.Visible:=ivNever;
          bbBonusTools.Visible:=ivNever;

          bbGoodsNew.Visible:=ivNever;
          bbGoodsDelete.Visible:=ivNever;

          bbAddonsNew.Visible:=ivNever;
          bbAddonsDelete.Visible:=ivNever;

          dxBarManagerBar1.Visible:=False;

          dxBarStatic1.Align:=TdxBarItemAlign.iaLeft;
          dxBarStatic2.Align:=TdxBarItemAlign.iaLeft;
     end;
end;

procedure TfrmBonusGoods2Dlg.ShowAddNewBonusDialog;
var dialog:TfrmBonusGoods2EditorDlg;
begin
     dialog:=TfrmBonusGoods2EditorDlg.Create(Self,IBCQueryBonus,IBCDataSourceBonus);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoods2Dlg.ShowModifyBonusDialog;
var dialog:TfrmBonusGoods2EditorDlg;
begin
     dialog:=TfrmBonusGoods2EditorDlg.Create(Self,IBCQueryBonus,IBCDataSourceBonus);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoods2Dlg.ShowSortDialog;
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self);
     try
        dialog.DBTable:=cotGoodsBonus2;
        if dialog.ShowModal=mrOK then IBCQueryBonus.Refresh;
     finally
        dialog.Free;
     end;
end;

end.

unit frmWebPacheteProduseDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DialogTitle, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, dxBar, cxClasses, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, cxLabel, DBAccess, IBC, MemDS, cxCurrencyEdit,
  dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, dxScrollbarAnnotations;

type
  TfrmWebPacheteProduseDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    btnClose: TButton;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridPTable: TcxGridDBTableView;
    cxGridPLevel: TcxGridLevel;
    cxGridP: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGridP_PACHET_ID: TcxGridDBColumn;
    cxGridP_TITLU: TcxGridDBColumn;
    cxGridP_GOODS_TITLE: TcxGridDBColumn;
    cxGridP_DATA_INCHEPUT: TcxGridDBColumn;
    cxGridP_DATA_SFIRSIT: TcxGridDBColumn;
    cxGridP_CREATED_NAME: TcxGridDBColumn;
    cxGridP_GOODS_COUNT: TcxGridDBColumn;
    cxGridP_GOODS_ID: TcxGridDBColumn;
    IBCQueryPachete: TIBCQuery;
    IBCDataSourcePachete: TIBCDataSource;
    bbGoods: TdxBarButton;
    cxGridP_FLG_ENABLED: TcxGridDBColumn;
    cxGridPTable_SUMA: TcxGridDBColumn;
    cxGridPTable_SUMA_CATALOG: TcxGridDBColumn;
    cxGridPTable_SUMA_DIFF: TcxGridDBColumn;
    bbSort: TdxBarButton;
    cxGridPTable_ORDERNO: TcxGridDBColumn;
    procedure cxGridPTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure bbGoodsClick(Sender: TObject);
    procedure bbSortClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, frmWebPacheteEditorDialog, SWNUtils, SWNDBErrors, frmWebPacheteGoodsDialog, frmChangeOrderNoDialog,
  SWNSecurity, SWNSecurityFlags;

procedure TfrmWebPacheteProduseDlg.bbDeleteClick(Sender: TObject);
begin
     if ShowAskDialog('Ștergere pachet de produse',
                      Format('Doriți să ștergeți pachetul de produse "%s"?',[IBCQueryPachete.FieldByName('TITLU').AsString]))<>mrYes then Exit;

     IBCQueryPachete.UpdateTransaction.StartTransaction;
     try
        IBCQueryPachete.Delete;
        IBCQueryPachete.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryPachete.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmWebPacheteProduseDlg.bbEditClick(Sender: TObject);
var dialog:TfrmWebPacheteEditorDlg;
begin
     dialog:=TfrmWebPacheteEditorDlg.Create(Self,IBCQueryPachete,IBCDataSourcePachete);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPacheteProduseDlg.bbGoodsClick(Sender: TObject);
var dialog:TfrmWebPacheteGoodsDlg;
begin
     dialog:=TfrmWebPacheteGoodsDlg.Create(Self,IBCQueryPachete,IBCDataSourcePachete);
     try
        if dialog.ShowModal=mrOk then IBCQueryPachete.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPacheteProduseDlg.bbNewClick(Sender: TObject);
var dialog:TfrmWebPacheteEditorDlg;
begin
     dialog:=TfrmWebPacheteEditorDlg.Create(self,IBCQueryPachete,IBCDataSourcePachete);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmWebPacheteProduseDlg.bbSortClick(Sender: TObject);
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self);
     try
        dialog.DBTable:=cotPacheteProduse;
        if dialog.ShowModal=mrOk then IBCQueryPachete.Refresh;
    finally
        dialog.Free;
    end;
end;

procedure TfrmWebPacheteProduseDlg.cxGridPTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     if Not VarIsNull(AViewInfo.GridRecord.Values[cxGridP_FLG_ENABLED.Index]) then
     begin
          if (AViewInfo.GridRecord.Values[cxGridP_FLG_ENABLED.Index]=0) then ACanvas.Font.Color:=clGrayText;
     end;

     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then ACanvas.Brush.Color:=$E8E8E8;
end;

procedure TfrmWebPacheteProduseDlg.cxGridPTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmWebPacheteProduseDlg.Prepare;
begin
     cxGridP_TITLU.Focused:=True;
     IBCQueryPachete.Active:=True;
     SelectionChanged;
end;

procedure TfrmWebPacheteProduseDlg.SelectionChanged;
var fAdd,fEdit,fDelete,fGoods,fSort:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;
     fGoods:=False;
     fSort:=cxGridPTable.DataController.RecordCount>1;

     if (cxGridPTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
          fGoods:=True;
     end;

     bbNew.Enabled:=fAdd;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
     bbGoods.Enabled:=fGoods;
     bbSort.Enabled:=fSort;
end;

procedure TfrmWebPacheteProduseDlg.SetupSecurityItems;
begin
     if Not SecurityFlagEnabled(cSecurityFlag_Website_PDP_Создать) then bbNew.Visible:=ivNever;
     if Not SecurityFlagEnabled(cSecurityFlag_Website_PDP_Редактировать) then
     begin
          bbEdit.Visible:=ivNever;
          bbGoods.Visible:=ivNever;
          bbSort.Visible:=ivNever;
     end;
     if Not SecurityFlagEnabled(cSecurityFlag_Website_PDP_Удалить) then bbDelete.Visible:=ivNever;

     if (dxBarManager1Bar1.ItemLinks.VisibleItemCount=0) then
     begin
          dxBarManager1Bar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;

end;

end.

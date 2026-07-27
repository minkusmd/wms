unit frmGoodsTypeNPSC_APList_Editor_Dialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS, cxImageComboBox, cxCheckBox,
  dxDateRanges, dxScrollbarAnnotations;

type
  TfrmGoodsTypeNPSC_APList_Editor_Dlg = class(TSWNMasteredFormClass)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    btnClose: TButton;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    bbSort: TdxBarButton;
    IBCQueryParams: TIBCQuery;
    IBCDataSourceParams: TIBCDataSource;
    cxGridTableColumn1: TcxGridDBColumn;
    cxGridTableColumn2: TcxGridDBColumn;
    cxGridTableColumn3: TcxGridDBColumn;
    cxGridTableColumn4: TcxGridDBColumn;
    cxGridTableColumn5: TcxGridDBColumn;
    cxGridTableColumn6: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbSortClick(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowAddNewParamDialog;
    procedure ShowModifyParamDialog;
    procedure DeleteParam;
    procedure DoDeleteSelectedParam;
    procedure ShowSortParamsDialog;
  protected
    { protected declarations }
    procedure BindingDataSource;override;
    procedure Prepare;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNDBErrors, frmChangeOrderNoDialog, frmGoodsTypeNPSC_AP_Item_Editor_Dialog;

{ TForm2 }

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.bbDeleteClick(Sender: TObject);
begin
     DeleteParam;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.bbEditClick(Sender: TObject);
begin
     ShowModifyParamDialog;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.bbNewClick(Sender: TObject);
begin
     ShowAddNewParamDialog;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.bbSortClick(Sender: TObject);
begin
     ShowSortParamsDialog;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.DeleteParam;
begin
     if ShowAskDialog('Удаление параметра',Format('Вы хотите удалить парамет "%s"?',[IBCQueryParams.FieldByName('PARAM_NAME_RUS').asString]))=mrYes
       then DoDeleteSelectedParam;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.DoDeleteSelectedParam;
begin
     try
        IBCQueryParams.Delete;
     except on E:Exception do
        if Not ProcessSWNError(E) then raise;
     end;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.BindingDataSource;
begin
     IBCQueryParams.Transaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryParams.UpdateTransaction:=fMasterDataSet.UpdateTransaction;
     IBCQueryParams.MasterSource:=fMasterDataSource;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.Prepare;
begin
     IBCQueryParams.Active:=True;
     SelectionChanged;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.SelectionChanged;
var fSelected:Boolean;
begin
     fSelected:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fSelected:=True;
     end;

     bbNew.Enabled:=True;
     bbEdit.Enabled:=fSelected;
     bbDelete.Enabled:=fSelected;
     bbSort.Enabled:=cxGridTable.DataController.RecordCount>1;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.ShowAddNewParamDialog;
var dialog:TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg;
begin
     dialog:=TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.Create(Self,IBCQueryParams,IBCDataSourceParams);
     try
        dialog.CreateNewRecord:=True;
        dialog.GoodsTypeID:=fMasterDataSet.FieldByName('GOODSTYPEID').AsInteger;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.ShowModifyParamDialog;
var dialog:TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg;
begin
     dialog:=TfrmGoodsTypeNPSC_AP_Item_Editor_Dlg.Create(Self,IBCQueryParams,IBCDataSourceParams);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmGoodsTypeNPSC_APList_Editor_Dlg.ShowSortParamsDialog;
var dialog:TfrmChangeOrderNoDlg;
begin
     dialog:=TfrmChangeOrderNoDlg.Create(Self, IBCQueryParams.UpdateTransaction);
     try
        dialog.DBTable:=cosNPSCAddParamsTemplate;
        dialog.ParentID:=IBCQueryParams.FieldByName('GOODSTYPEID').AsInteger;
        if dialog.ShowModal=mrOk then
        begin
             IBCQueryParams.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

end.

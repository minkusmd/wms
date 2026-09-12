unit frmSalePlansDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid, dxBar, ExtCtrls, DBAccess, IBC, MemDS,
  cxImageComboBox, cxCurrencyEdit, StdCtrls, cxNavigator, dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmSalePlansDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGrid_DT: TcxGridDBColumn;
    cxGrid_DT_NAME: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_SUMA: TcxGridDBColumn;
    cxGrid_SUMA_SAL: TcxGridDBColumn;
    IBCQuerySal: TIBCQuery;
    IBCDataSourceSal: TIBCDataSource;
    cxGrid_IMAGE: TcxGridDBColumn;
    bbNew: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    bbCopy: TdxBarButton;
    btnClose: TcxButton;
    cxGrid_TRANSACTIONS_QTY: TcxGridDBColumn;
    cxGrid_NUMBER_OF_SELLERS: TcxGridDBColumn;
    procedure cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;var AText: string);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;var AHandled: Boolean);
    procedure bbCopyClick(Sender: TObject);

  private
    { Private declarations }
    procedure SelectionChanged;
    procedure ShowCreateNewPlanDialog;
    procedure ShowModifyPlanDialog;
    procedure DoDeleteRecord;
    procedure ShowCopyMonthDataDialog;

    function DoCopyDataDB(const Date1,Date2:TDateTime):Boolean;

  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;



implementation

uses DataModuleDB, DataModuleAdditions, DateUtils, SWNUtils, SWNDBErrors, frmSalePlansEditorDialog, frmSalePlansCopyDialog,
  SWNSecurityFlags;

{$R *.dfm}

procedure TfrmSalePlansDlg.bbCopyClick(Sender: TObject);
begin
     ShowCopyMonthDataDialog;
end;

procedure TfrmSalePlansDlg.bbDeleteClick(Sender: TObject);
begin
     DoDeleteRecord;
end;

procedure TfrmSalePlansDlg.bbModifyClick(Sender: TObject);
begin
     ShowModifyPlanDialog;
end;

procedure TfrmSalePlansDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewPlanDialog;
end;

procedure TfrmSalePlansDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     ShowModifyPlanDialog;
     AHandled:=True;
end;

procedure TfrmSalePlansDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmSalePlansDlg.cxGrid_DATAGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
var y,m,d:word;
    y2,m2,d2:word;
begin
     if Not VarIsNull(ARecord.Values[cxGrid_DATA.Index]) then
     begin
          DecodeDate(ARecord.Values[cxGrid_DATA.Index],y,m,d);
          DecodeDate(Now,y2,m2,d2);

          if (y2=y) and (m2=m) then AText:=Format('Luna curenta (%s)',[FormatDateTime('mmmm yyyy',ARecord.Values[cxGrid_DATA.Index])])
            else AText:=FormatDateTime('mmmm yyyy',ARecord.Values[cxGrid_DATA.Index]);
     end;
end;

function TfrmSalePlansDlg.DoCopyDataDB(const Date1, Date2: TDateTime): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCQuerySal.UpdateTransaction;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_BUGET_VINZARI_COPYDATA(:d1,:d2)';
        Query.ParamByName('d1').AsDate:=Date1;
        Query.ParamByName('d2').AsDate:=Date2;
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

procedure TfrmSalePlansDlg.DoDeleteRecord;
begin
     if ShowAskDialog('Stergere plan',Format('Doriti sa stergeti planurile pentru firma %s ?',[IBCQuerySal.FieldByName('DT_NAME').AsString]))=mrYes then
     begin
          IBCQuerySal.UpdateTransaction.StartTransaction;
          try
             IBCQuerySal.Delete;
             IBCQuerySal.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQuerySal.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmSalePlansDlg.Prepare;
begin
     IBCQuerySal.Active:=True;
     cxGridTable.DataController.Groups.FullExpand;
     SelectionChanged;
end;

procedure TfrmSalePlansDlg.SelectionChanged;
var fNew,fEdit,fDelete,fCopy:Boolean;
begin
     fNew:=True;
     fEdit:=False;
     fDelete:=False;
     fCopy:=False;

     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=True;
          fDelete:=True;
          fCopy:=True;
     end;

     bbNew.Enabled:=fNew;
     bbModify.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
     bbCopy.Enabled:=fCopy;
end;

procedure TfrmSalePlansDlg.SetupSecurityItems;
begin
     if Not SecurityFlagEnabled(cSecurityFlag_Инструменты_ПП_Администрировать) then
     begin
          IBCQuerySal.ReadOnly:=True;
          bbNew.Visible:=ivNever;
          bbModify.Visible:=ivNever;
          bbDelete.Visible:=ivNever;
          bbCopy.Visible:=ivNever;
          dxBarManagerBar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure TfrmSalePlansDlg.ShowCopyMonthDataDialog;
var dialog:TfrmSalePlansCopyDlg;
    S:string;
    d1,d2:TDateTime;
begin
     dialog:=TfrmSalePlansCopyDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then
        begin
             d1:=dialog.SourceData;
             d2:=dialog.TargetData;
             S:=Format('Doriti sa copiati din %s in %s ?',[FormatDateTime('mmmm yyyy',d1),FormatDateTime('mmmm yyyy',d2)]);
             if ShowAskDialog('Copiere date',S)=mrYes then
             begin
                  if DoCopyDataDB(d1,d2) then IBCQuerySal.Refresh;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSalePlansDlg.ShowCreateNewPlanDialog;
var dialog:TfrmSalePlansEditorDlg;
begin
     dialog:=TfrmSalePlansEditorDlg.Create(Self,IBCQuerySal,IBCDataSourceSal);
     try
        dialog.CreateNewPlan:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSalePlansDlg.ShowModifyPlanDialog;
var dialog:TfrmSalePlansEditorDlg;
begin
     if bbModify.Visible=ivNever then Exit;

     dialog:=TfrmSalePlansEditorDlg.Create(Self,IBCQuerySal,IBCDataSourceSal);
     try
        dialog.CreateNewPlan:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.

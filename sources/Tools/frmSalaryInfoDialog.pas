unit frmSalaryInfoDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, StdCtrls, ExtCtrls, cxClasses, dxBar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBAccess,
  IBC, MemDS, cxDBLookupComboBox, cxCalendar, cxCalc, cxLabel, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Vcl.Menus, cxButtons;

type
  TfrmSalaryInfoDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnButtons: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    IBCQuerySalary: TIBCQuery;
    IBCDataSourceSalary: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    bbCopyMonthData: TdxBarButton;
    pnClient: TPanel;
    cxGrid: TcxGrid;
    cxGridTable: TcxGridDBTableView;
    cxGrid_CUSTOMER_NAME: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_BASE_SALARY: TcxGridDBColumn;
    cxGrid_QTY_WORK_HOURS: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    cxGridNavTable: TcxGridDBTableView;
    cxGridNavLevel: TcxGridLevel;
    cxGridNav: TcxGrid;
    cxGridNav_DATA_YEAR: TcxGridDBColumn;
    cxGridNav_DATA_MONTH: TcxGridDBColumn;
    IBCQueryNav: TIBCQuery;
    IBCDataSourceNav: TIBCDataSource;
    pnNavigator: TPanel;
    pnCustomers: TPanel;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManagerBar2: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    cxGrid_CUSTOMERID: TcxGridDBColumn;
    cxGridTable_K_GRAD: TcxGridDBColumn;
    btnCancel: TcxButton;
    procedure bbCopyMonthDataClick(Sender: TObject);
    procedure cxGridNav_DATA_MONTHGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridNavTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    { Private declarations }
    procedure NavigatorSelectionChanged;
    procedure CustomerSelectionChanged;

    procedure ShowCreateNewCustomerDialog;
    procedure ShowModifyCustomerDialog;
    procedure ShowDeleteDialog;

    procedure ShowCopyMonthDataDialog;
    function DoCopyDataDB(const SourceYear,SourceMonth, TargetYear, TargetMonth:integer):Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNSecurityFlags, SWNDBErrors, SWNUtils,
     frmSalaryInfoCopyDialog, DateUtils, SWNValueStorageUnit, frmSalaryInfoEditorDialog, SWNDBEvents;

{$R *.dfm}

{ TfrmSalaryInfoDlg }

procedure TfrmSalaryInfoDlg.bbCopyMonthDataClick(Sender: TObject);
begin
     ShowCopyMonthDataDialog;
end;

procedure TfrmSalaryInfoDlg.bbDeleteClick(Sender: TObject);
begin
     ShowDeleteDialog;
end;

procedure TfrmSalaryInfoDlg.bbEditClick(Sender: TObject);
begin
     ShowModifyCustomerDialog;
end;

procedure TfrmSalaryInfoDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewCustomerDialog;
end;

procedure TfrmSalaryInfoDlg.CustomerSelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=False;
     fEdit:=False;
     fDelete:=False;

     if cxGridNavTable.DataController.RecNo>0 then
     begin
          fNew:=True;
          if (cxGridTable.DataController.RecNo>0) then
          begin
               fEdit:=True;
               fDelete:=True;
          end;
     end;
     bbNew.Enabled:=fNew;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmSalaryInfoDlg.cxGridNavTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     NavigatorSelectionChanged;
end;

procedure TfrmSalaryInfoDlg.cxGridNav_DATA_MONTHGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if VarIsNumeric(ARecord.Values[cxGridNav_DATA_MONTH.Index])
       then AText:=FormatSettings.LongMonthNames[Integer(ARecord.Values[cxGridNav_DATA_MONTH.Index])];
end;

procedure TfrmSalaryInfoDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if bbEdit.Enabled then
     begin
          bbEditClick(bbEdit);
          AHandled:=True;
     end;
end;

procedure TfrmSalaryInfoDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     CustomerSelectionChanged;
end;

function TfrmSalaryInfoDlg.DoCopyDataDB(const SourceYear, SourceMonth, TargetYear, TargetMonth:integer): Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.AutoCommit:=False;
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=IBCTrUpdate;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_SALARY_INFO_COPYDATA(:SY,:SM,:TY,:TM)';
        Query.ParamByName('SY').AsInteger:=SourceYear;
        Query.ParamByName('SM').AsInteger:=SourceMonth;
        Query.ParamByName('TY').AsInteger:=TargetYear;
        Query.ParamByName('TM').AsInteger:=TargetMonth;
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

procedure TfrmSalaryInfoDlg.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
end;

procedure TfrmSalaryInfoDlg.NavigatorSelectionChanged;
var fCopy:Boolean;
begin
     fCopy:=False;
     if (cxGridNavTable.DataController.RecNo>0) then
     begin
          fCopy:=True;
     end;
     bbCopyMonthData.Enabled:=fCopy;

     CustomerSelectionChanged;
end;

procedure TfrmSalaryInfoDlg.Prepare;
begin
     IBCQueryNav.Active:=True;
     IBCQuerySalary.Active:=True;
     cxGridNavTable.DataController.Groups.FullExpand;
     cxGrid_CUSTOMER_NAME.Focused:=True;

     NavigatorSelectionChanged;
end;

procedure TfrmSalaryInfoDlg.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
end;

procedure TfrmSalaryInfoDlg.SetupSecurityItems;
begin
end;

procedure TfrmSalaryInfoDlg.ShowCopyMonthDataDialog;
var dialog:TfrmSalaryInfoCopyDlg;
    S:string;
    d1,d2:String;
begin
     dialog:=TfrmSalaryInfoCopyDlg.Create(Self);
     try
        dialog.SourceMonth:=cxGridNavTable.Controller.FocusedRecord.Values[cxGridNav_DATA_MONTH.Index];
        dialog.SourceYear:=cxGridNavTable.Controller.FocusedRecord.Values[cxGridNav_DATA_YEAR.Index];
        if dialog.ShowModal=mrOk then
        begin
             d1:=Format('%s %d',[FormatSettings.LongMonthNames[dialog.SourceMonth],dialog.SourceYear]);
             d2:=Format('%s %d',[FormatSettings.LongMonthNames[dialog.TargetMonth],dialog.TargetYear]);
             S:=Format('Doriti sa copiati din %s in %s ?',[d1,d2]);
             if ShowAskDialog('Copiere date',S)=mrYes then
             begin
                  if DoCopyDataDB(dialog.SourceYear,dialog.SourceMonth,dialog.TargetYear,dialog.TargetMonth) then
                  begin
                       IBCQueryNav.Refresh;
                       IBCQuerySalary.Refresh;
                  end;
             end;
        end;
     finally
        dialog.Free;
     end;
end;


procedure TfrmSalaryInfoDlg.ShowCreateNewCustomerDialog;
var dialog:TfrmSalaryInfoEditorDlg;
    currYear,currMonth:integer;
    newYear,newMonth:integer;
begin
     currYear:=-1;
     currMonth:=-1;
     if cxGridNavTable.Controller.FocusedRecord.IsData then
     begin
          currYear:=cxGridNavTable.Controller.FocusedRecord.Values[cxGridNav_DATA_YEAR.Index];
          currMonth:=cxGridNavTable.Controller.FocusedRecord.Values[cxGridNav_DATA_MONTH.Index];
     end;

     dialog:=TfrmSalaryInfoEditorDlg.Create(Self,IBCQuerySalary,IBCDataSourceSalary);
     try
        dialog.CreateNewRecord:=True;
        if currYear<>-1 then dialog.DefaultYear:=currYear;
        if currMonth<>-1 then dialog.DefaultMonth:=currMonth;

        if dialog.ShowModal=mrOk then
        begin
             newYear:=dialog.NewYear;
             newMonth:=dialog.NewMonth;
             if (newMonth<>currMonth) or (newYear<>currYear) then
             begin
                  IBCQueryNav.Refresh;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmSalaryInfoDlg.ShowDeleteDialog;
begin
     if ShowAskDialog('Sterge inregistrarea',Format('Stergeti informatia despre salariu pentru "%s"?',[IBCQuerySalary.FieldByName('CUSTOMER_NAME').AsString]))=mrYes then
     begin
          IBCQuerySalary.UpdateTransaction.StartTransaction;
          try
             IBCQuerySalary.Delete;
             IBCQuerySalary.UpdateTransaction.Commit;
             IBCQueryNav.Refresh;
          except on E:Exception do
             begin
                  IBCQuerySalary.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmSalaryInfoDlg.ShowModifyCustomerDialog;
var dialog:TfrmSalaryInfoEditorDlg;
begin
     dialog:=TfrmSalaryInfoEditorDlg.Create(Self,IBCQuerySalary,IBCDataSourceSalary);
     try
        dialog.CreateNewRecord:=False;
        if dialog.ShowModal=mrOk then
        begin

        end;
     finally
        dialog.Free;
     end;
end;

end.

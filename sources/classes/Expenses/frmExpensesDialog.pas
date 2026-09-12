unit frmExpensesDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar,
  cxClasses, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.ExtCtrls, DBAccess, IBC, MemDS, Vcl.StdCtrls, cxNavigator, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmExpensesDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1Bar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCDataSourceExp: TIBCDataSource;
    IBCQueryExp: TIBCQuery;
    IBCTrUpdate: TIBCTransaction;
    btnClose: TButton;
    cxGrid_ADDEXPENSEID: TcxGridDBColumn;
    cxGrid_CREATED_DATE: TcxGridDBColumn;
    cxGrid_DT_NAME: TcxGridDBColumn;
    cxGrid_CT_NAME: TcxGridDBColumn;
    cxGrid_DETAILS: TcxGridDBColumn;
    cxGrid_SUMA: TcxGridDBColumn;
    cxGrid_CREATED_BY_NAME: TcxGridDBColumn;
    cxGrid_DOCTYPE_NAME: TcxGridDBColumn;
    cxGrid_DOCID: TcxGridDBColumn;
    cxGrid_ANALITICA_TITLE: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure cxGrid_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fSECURITY_New,fSECURITY_Modify,fSECURITY_View,fSECURITY_Delete:Boolean;

    procedure SelectionChanged;
    procedure ShowCreateNewExpenseDialog;
    procedure ShowModifyExpenseDialog;
    procedure DeleteExpense;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, frmExpenseEditorDialog, DataModuleDB, SWNUtils, SWNDBErrors, SWNSecurityFlags;

{ TForm2 }

procedure TfrmExpensesDlg.bbDeleteClick(Sender: TObject);
begin
     DeleteExpense;
end;

procedure TfrmExpensesDlg.bbEditClick(Sender: TObject);
begin
     ShowModifyExpenseDialog;
end;

procedure TfrmExpensesDlg.bbNewClick(Sender: TObject);
begin
     ShowCreateNewExpenseDialog;
end;

procedure TfrmExpensesDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmExpensesDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+C
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          // copy cell content in clipboard
          CopyGridCellTextToClipboard(cxGridTable);
          Key:=0;
          Shift:=[];
     end
end;

procedure TfrmExpensesDlg.cxGrid_CREATED_DATEGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGrid_CREATED_DATE.Index]) then
     begin
          AText:=FormatDateTime('dd.mm.yyyy HH:NN',ARecord.Values[cxGrid_CREATED_DATE.Index]);
     end;
end;

procedure TfrmExpensesDlg.DeleteExpense;
begin
     if ShowAskDialog('Stergere inregistrare',Format('Doriti sa stergeti cheltuiala "%s"?',[IBCQueryExp.FieldByName('DETAILS').AsString]))<>mrYes then Exit;

     IBCQueryExp.UpdateTransaction.StartTransaction;
     try
        IBCQueryExp.Delete;
        IBCQueryExp.UpdateTransaction.Commit;
     except on E: Exception do
        begin
             IBCQueryExp.UpdateTransaction.Rollback;
             if Not ProcessSWNError(E) then raise;
        end;
     end;
end;

procedure TfrmExpensesDlg.Prepare;
begin
     IBCQueryExp.Active:=True;
     SelectionChanged;
end;

procedure TfrmExpensesDlg.SelectionChanged;
var fNew,fEdit,fDelete:Boolean;
begin
     fNew:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;

     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=fSECURITY_Modify;
          fDelete:=fSECURITY_Delete;
     end;

     bbNew.Enabled:=fNew;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmExpensesDlg.SetupSecurityItems;
begin
     fSECURITY_New:=SecurityFlagEnabled(cSecurityFlag_Инструменты_ДР_Создать);
     fSECURITY_Modify:=SecurityFlagEnabled(cSecurityFlag_Инструменты_ДР_Редактировать);
     fSECURITY_View:=SecurityFlagEnabled(cSecurityFlag_Инструменты_ДР_Просмотр);
     fSECURITY_Delete:=SecurityFlagEnabled(cSecurityFlag_Инструменты_ДР_Удалить);

     if Not fSECURITY_New then bbNew.Visible:=ivNever;
     if Not fSECURITY_Modify then bbEdit.Visible:=ivNever;
     if Not fSECURITY_Delete then bbDelete.Visible:=ivNever;

     if dxBarManager1Bar1.ItemLinks.VisibleItemCount=0 then
     begin
          dxBarManager1Bar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure TfrmExpensesDlg.ShowCreateNewExpenseDialog;
var dialog:TfrmExpenseEditorDlg;
begin
     dialog:=TfrmExpenseEditorDlg.Create(Self,IBCQueryExp,IBCDataSourceExp);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmExpensesDlg.ShowModifyExpenseDialog;
var dialog:TfrmExpenseEditorDlg;
begin
     dialog:=TfrmExpenseEditorDlg.Create(Self,IBCQueryExp,IBCDataSourceExp);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.

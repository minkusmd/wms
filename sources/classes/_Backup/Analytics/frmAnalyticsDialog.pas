unit frmAnalyticsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, ExtCtrls, DBAccess, IBC, MemDS,
  cxImageComboBox, Menus, StdCtrls, cxButtons, cxLabel, cxCheckBox;

type
  TfrmAnalyticsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryAnalytics: TIBCQuery;
    IBCDataSourceAnalytics: TIBCDataSource;
    cxGridTable_ANALITICAID: TcxGridDBColumn;
    cxGridTable_FLG_FOLDER: TcxGridDBColumn;
    cxGridTable_TITLE: TcxGridDBColumn;
    cxGridTable_DESCRIPTION: TcxGridDBColumn;
    bbNewAnalytics: TdxBarSubItem;
    bbNewAnalyticsItem: TdxBarButton;
    bbNewAnalyticsFolder: TdxBarButton;
    bbModifyAnalytics: TdxBarButton;
    bbDeleteAnalytics: TdxBarButton;
    btnOk: TcxButton;
    bbNavPrev: TdxBarButton;
    bbNavNext: TdxBarButton;
    bbNavHome: TdxBarButton;
    cxGridTable_FLG_NOT_CHANGE_BALANS: TcxGridDBColumn;
    cxGridTable_FLG_CHANGE_BALANS: TcxGridDBColumn;
    cxGridTable_FLG_EXPENSES: TcxGridDBColumn;
    cxGridTable_FLG_CALC_SALDO: TcxGridDBColumn;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbNewAnalyticsItemClick(Sender: TObject);
    procedure bbNewAnalyticsFolderClick(Sender: TObject);
    procedure bbModifyAnalyticsClick(Sender: TObject);
    procedure bbDeleteAnalyticsClick(Sender: TObject);
    procedure bbNavNextClick(Sender: TObject);
    procedure bbNavPrevClick(Sender: TObject);
    procedure bbNavHomeClick(Sender: TObject);
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
  private
    { Private declarations }
    fCurrentParentID: integer;
    procedure NavigateToParent(const NewParentID:integer; const OldParentID: integer = -1);
    procedure NavigateForward;
    procedure NavigateBack;
    procedure NavigateToHome;

    procedure SelectionChanged;

    procedure ShowCreateNewAnalyticsDialog;
    procedure ShowCreateNewAnalyticsFolderDialog;
    procedure ShowModifyAnalyticsDialog;
    procedure ShowModifyAnalyticsFolderDialog;
    procedure ShowDeleteAnalyticsFolder;
    procedure ShowDeleteAnalytics;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent);override;
  end;

implementation

uses DataModuleDB, DataModuleAdditions, SWNUtils, SWNConst, SWNDBErrors, frmAnalyticsEditorDialog,
  frmAnalyticsFolderEditorDialog;

{$R *.dfm}

{ TfrmAnalyticsDlg }

procedure TfrmAnalyticsDlg.bbDeleteAnalyticsClick(Sender: TObject);
begin
     if Assigned(cxGridTable.Controller.FocusedRow) then
     begin
          if cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex,cxGridTable_FLG_FOLDER.Index]=1
            then ShowDeleteAnalyticsFolder
            else ShowDeleteAnalytics;
     end;
end;

procedure TfrmAnalyticsDlg.bbModifyAnalyticsClick(Sender: TObject);
begin
     if Assigned(cxGridTable.Controller.FocusedRow) then
     begin
          if cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex,cxGridTable_FLG_FOLDER.Index]=1
            then ShowModifyAnalyticsFolderDialog
            else ShowModifyAnalyticsDialog;
     end;
end;

constructor TfrmAnalyticsDlg.Create(AOwner: TComponent);
begin
     inherited;

end;

procedure TfrmAnalyticsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if (AButton=mbLeft) and (bbNavNext.Enabled) then
     begin
          bbNavNextClick(bbNavNext);
          AHandled:=True;
     end;
end;

procedure TfrmAnalyticsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmAnalyticsDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=13) and (Shift=[]) and (bbNavNext.Enabled) then NavigateForward
     else
     if (Key=8) and (Shift=[]) and (bbNavPrev.Enabled) then NavigateBack;
end;

procedure TfrmAnalyticsDlg.bbNavHomeClick(Sender: TObject);
begin
     NavigateToHome;
end;

procedure TfrmAnalyticsDlg.bbNavNextClick(Sender: TObject);
begin
     NavigateForward;
end;

procedure TfrmAnalyticsDlg.bbNavPrevClick(Sender: TObject);
begin
     NavigateBack;
end;

procedure TfrmAnalyticsDlg.bbNewAnalyticsFolderClick(Sender: TObject);
begin
     ShowCreateNewAnalyticsFolderDialog;
end;

procedure TfrmAnalyticsDlg.bbNewAnalyticsItemClick(Sender: TObject);
begin
     ShowCreateNewAnalyticsDialog;
end;

procedure TfrmAnalyticsDlg.NavigateBack;
var Query:TIBCQuery;
begin
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.SQL.Text:='SELECT PARENTID FROM TS_ANALYTICS WHERE ANALITICAID=:id';
        Query.ParamByName('id').AsInteger:=fCurrentParentID;
        Query.ExecSQL;
        if Query.Eof then NavigateToHome
        else
        begin
             NavigateToParent(Query.Fields[0].AsInteger, fCurrentParentID);
        end;
     finally
        Query.Free;
     end;

end;

procedure TfrmAnalyticsDlg.NavigateForward;
begin
     NavigateToParent(IBCQueryAnalytics.FieldByName('ANALITICAID').AsInteger);
end;

procedure TfrmAnalyticsDlg.NavigateToHome;
begin
     NavigateToParent(0);
end;

procedure TfrmAnalyticsDlg.NavigateToParent(const NewParentID: integer; const OldParentID: integer);
begin
     IBCQueryAnalytics.Close;
     IBCQueryAnalytics.ParamByName('ParentID').AsInteger := NewParentID;
     IBCQueryAnalytics.Active := true;
     if (OldParentID<>-1) then IBCQueryAnalytics.Locate('ANALITICAID',OldParentID,[]);
     fCurrentParentID := NewParentID;
     SelectionChanged;
end;

procedure TfrmAnalyticsDlg.Prepare;
begin
     inherited;

     NavigateToHome;
     SelectionChanged;
end;

procedure TfrmAnalyticsDlg.SelectionChanged;
var fHome, fPrev, fNext, fAdd, fModify, fDelete: Boolean;
    rowIndex: integer;
begin
     fHome:= fCurrentParentID>0;
     fPrev := fCurrentParentID>0;
     fNext := false;
     fAdd := true;
     fModify := false;
     fDelete := false;
     rowIndex := cxGridTable.Controller.FocusedRowIndex;
     if (rowIndex>=0) then
     begin
          fModify := true;
          fDelete := true;
          fNext := cxGridTable.DataController.Values[rowIndex, cxGridTable_FLG_FOLDER.Index]=1;
     end;
     bbNavHome.Enabled := fHome;
     bbNavPrev.Enabled := fPrev;
     bbNavNext.Enabled := fNext;
     bbNewAnalytics.Enabled := fAdd;
     bbModifyAnalytics.Enabled := fModify;
     bbDeleteAnalytics.Enabled := fDelete;
end;

procedure TfrmAnalyticsDlg.ShowCreateNewAnalyticsDialog;
var dialog: TfrmAnalyticsEditorDlg;
begin
     dialog:=TfrmAnalyticsEditorDlg.Create(Self,IBCQueryAnalytics,IBCDataSourceAnalytics);
     try
        dialog.CreateNewAnalytics:=True;
        dialog.ParentID:=fCurrentParentID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmAnalyticsDlg.ShowCreateNewAnalyticsFolderDialog;
var dialog: TfrmAnalyticsFolderEditorDlg;
begin
     dialog:=TfrmAnalyticsFolderEditorDlg.Create(Self,IBCQueryAnalytics,IBCDataSourceAnalytics);
     try
        dialog.CreateNewFolderAnalytics:=True;
        dialog.ParentID:=fCurrentParentID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmAnalyticsDlg.ShowDeleteAnalytics;
var s:string;
begin
     if Assigned(cxGridTable.Controller.FocusedRow) then
     begin
          s:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex,cxGridTable_TITLE.Index];
          if ShowAskDialog('Удаление аналитики',Format('Вы хотите удалить аналитику "%s"?',[s]))=mrYes then
          begin
               IBCQueryAnalytics.UpdateTransaction.StartTransaction;
               try
                  IBCQueryAnalytics.Delete;
                  IBCQueryAnalytics.UpdateTransaction.Commit;
               except on E:Exception do
                  begin
                       IBCQueryAnalytics.UpdateTransaction.Rollback;
                       if Not ProcessSWNError(E) then raise;
                  end;
               end;
          end;
     end;
end;

procedure TfrmAnalyticsDlg.ShowDeleteAnalyticsFolder;
var s:string;
begin
     if Assigned(cxGridTable.Controller.FocusedRow) then
     begin
          s:=cxGridTable.DataController.Values[cxGridTable.Controller.FocusedRowIndex,cxGridTable_TITLE.Index];
          if ShowAskDialog('Удаление группы аналитики',Format('Вы хотите удалить группу "%s"?',[s]),'Группа должна быть пустой!')=mrYes then
          begin
               IBCQueryAnalytics.UpdateTransaction.StartTransaction;
               try
                  IBCQueryAnalytics.Delete;
                  IBCQueryAnalytics.UpdateTransaction.Commit;
               except on E:Exception do
                  begin
                       IBCQueryAnalytics.UpdateTransaction.Rollback;
                       if Not ProcessSWNError(E) then raise;
                  end;
               end;
          end;
     end;
end;

procedure TfrmAnalyticsDlg.ShowModifyAnalyticsDialog;
var dialog: TfrmAnalyticsEditorDlg;
begin
     dialog:=TfrmAnalyticsEditorDlg.Create(Self,IBCQueryAnalytics,IBCDataSourceAnalytics);
     try
        dialog.CreateNewAnalytics:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmAnalyticsDlg.ShowModifyAnalyticsFolderDialog;
var dialog: TfrmAnalyticsFolderEditorDlg;
begin
     dialog:=TfrmAnalyticsFolderEditorDlg.Create(Self,IBCQueryAnalytics,IBCDataSourceAnalytics);
     try
        dialog.CreateNewFolderAnalytics:=false;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.

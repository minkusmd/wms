unit frmUserWorkBonusDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, DialogTitle, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ExtCtrls, Vcl.StdCtrls, DBAccess, IBC, MemDS, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  System.Actions, Vcl.ActnList;

type
  TfrmUserWorkBonusDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManagerBar1: TdxBar;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    btnClose: TButton;
    IBCQueryB: TIBCQuery;
    IBCDataSourceB: TIBCDataSource;
    IBCTrUpdate: TIBCTransaction;
    cxGrid_BONUSID: TcxGridDBColumn;
    cxGrid_DATA: TcxGridDBColumn;
    cxGrid_CT_NAME: TcxGridDBColumn;
    cxGrid_BONUS_VALUE: TcxGridDBColumn;
    cxGrid_DESCRIPTION: TcxGridDBColumn;
    cxGrid_CREATED_NAME: TcxGridDBColumn;
    cxGrid_CT: TcxGridDBColumn;
    ActionList1: TActionList;
    actModifyRecord: TAction;
    actDeleteRecord: TAction;
    procedure actDeleteRecordExecute(Sender: TObject);
    procedure actDeleteRecordUpdate(Sender: TObject);
    procedure actModifyRecordExecute(Sender: TObject);
    procedure actModifyRecordUpdate(Sender: TObject);
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure bbNewClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
  private
    { Private declarations }
    fSECURITY_New,fSECURITY_Edit,fSECURITY_Delete, fSECURITY_GridView:Boolean;
    procedure SelectionChanged;

    procedure ShowCreatNewRecordDialog;
    procedure ShowModifyRecordDialog;
    procedure DoDeleteRecord;

  protected
    { protected declarations }
    procedure Prepare;override;

    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNUtils, SWNDBErrors, SWNSecurity, SWNSecurityFlags,
     frmUserWorkBonusEditorDialog;

procedure TfrmUserWorkBonusDlg.actDeleteRecordExecute(Sender: TObject);
begin
   DoDeleteRecord;
end;

procedure TfrmUserWorkBonusDlg.actDeleteRecordUpdate(Sender: TObject);
begin
  actDeleteRecord.Enabled := (dmDB.CurrentUserID = IBCQueryB.FieldByName('CREATED_BY').AsInteger);
end;

procedure TfrmUserWorkBonusDlg.actModifyRecordExecute(Sender: TObject);
begin
  ShowModifyRecordDialog;
end;

procedure TfrmUserWorkBonusDlg.actModifyRecordUpdate(Sender: TObject);
begin
  actModifyRecord.Enabled := (dmDB.CurrentUserID = IBCQueryB.FieldByName('CREATED_BY').AsInteger);
end;

{ frmUserWorkBonusDlg }

procedure TfrmUserWorkBonusDlg.bbDeleteClick(Sender: TObject);
begin
  if SWNSecurityManager.isAdmin then
  begin
    if MessageDlg('Stergeti inregistrarea?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then
    begin
      if not IBCTrUpdate.Active then
        IBCTrUpdate.StartTransaction;

      IBCQueryB.Delete;
      IBCTrUpdate.Commit;
    end;
  end;
end;

procedure TfrmUserWorkBonusDlg.bbEditClick(Sender: TObject);
begin
  ShowModifyRecordDialog;
end;

procedure TfrmUserWorkBonusDlg.bbNewClick(Sender: TObject);
begin
     ShowCreatNewRecordDialog;
end;

procedure TfrmUserWorkBonusDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if fSECURITY_Edit and bbEdit.Enabled then
     begin
          actModifyRecordExecute(bbEdit);
//          bbEditClick(bbEdit);
          AHandled:=True;
     end;
end;

procedure TfrmUserWorkBonusDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmUserWorkBonusDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if Not VarIsNull(ARecord.Values[cxGrid_BONUS_VALUE.Index]) then
     begin
          if ARecord.Values[cxGrid_BONUS_VALUE.Index]<0 then AStyle:=dmAdditions.cxStyle_TextColorRed;
     end;
end;

procedure TfrmUserWorkBonusDlg.Prepare;
begin
     IBCQueryB.Active:=True;
//     cxGridTable.DataController.Groups.FullExpand;
     SelectionChanged;
     IBCQueryB.First;
end;

procedure TfrmUserWorkBonusDlg.SelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=fSECURITY_New;
     fEdit:=False;
     fDelete:=False;
     if (cxGridTable.DataController.RecNo>0) then
     begin
          fEdit:=fSECURITY_Edit;
          fDelete:=fSECURITY_Delete;
     end;
     bbNew.Enabled:=fAdd;
     bbEdit.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmUserWorkBonusDlg.SetupSecurityItems;
begin
     fSECURITY_New:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖШИБР_Создать);
     fSECURITY_Edit:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖШИБР_Редактировать);
     fSECURITY_Delete:=SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖШИБР_Удалить);

     fSECURITY_GridView := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ЖШИБР_Просмотр);

     if Not fSECURITY_New then bbNew.Visible:=ivNever;
     if Not fSECURITY_Edit then bbEdit.Visible:=ivNever;
     if Not fSECURITY_Delete then bbDelete.Visible:=ivNever;
     if dxBarManagerBar1.ItemLinks.VisibleItemCount<=0 then
     begin
          dxBarManagerBar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
     cxGrid.Visible := fSECURITY_GridView;

end;

procedure TfrmUserWorkBonusDlg.ShowCreatNewRecordDialog;
var dialog:TfrmUserWorkBonusEditorDlg;
begin
     dialog:=TfrmUserWorkBonusEditorDlg.Create(Self,IBCQueryB,IBCDataSourceB);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmUserWorkBonusDlg.DoDeleteRecord;
begin
     if ShowAskDialog('Stergere inregistrare',Format('Stergeti inregistrarea pentru "%s"?',[IBCQueryB.FieldByName('CT_NAME').asString]))<>mrYes then Exit;

     if IBCQueryB.FieldByName('CREATED_BY').AsInteger=dmDB.CurrentUserID then
     begin
       IBCQueryB.UpdateTransaction.StartTransaction;
       try
          IBCQueryB.Delete;
          IBCQueryB.UpdateTransaction.Commit;
       except on E:Exception do
          begin
               IBCQueryB.UpdateTransaction.Rollback;
               if Not ProcessSWNError(E) then raise;
          end;
       end;
     end
     else
     begin
        dmDB.SendSWNMail('salut@fantastic.md', 'Tendativa de stergere a amenzilor/bonusurilor',
              'Tendativa de stergere a amenzilor/bonusurilor de catre ' +
                  dmDB.CurrentUserFullName +' in suma de: ' +
                  IBCQueryB.FieldByName('BONUS_VALUE').AsString);
     end;
end;

procedure TfrmUserWorkBonusDlg.ShowModifyRecordDialog;
var dialog:TfrmUserWorkBonusEditorDlg;
begin
     dialog:=TfrmUserWorkBonusEditorDlg.Create(Self,IBCQueryB,IBCDataSourceB);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.


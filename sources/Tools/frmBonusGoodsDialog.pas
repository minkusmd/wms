unit frmBonusGoodsDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, DialogTitle, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, dxBar, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, ExtCtrls, DBAccess, IBC, MemDS, StdCtrls,
  cxLabel, cxNavigator, frmBonusGoodsImportGoodsDialog, cxImageComboBox, cxCalendar, cxBarEditItem, dxBarExtItems,
  dxDateRanges, dxScrollbarAnnotations, Vcl.Menus, cxButtons;

type
  TfrmBonusGoodsDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManagerBar1: TdxBar;
    bbAdd: TdxBarButton;
    bbModify: TdxBarButton;
    bbDelete: TdxBarButton;
    IBCQueryBonus: TIBCQuery;
    IBCDataSourceBonus: TIBCDataSource;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_GOODSNAME: TcxGridDBColumn;
    cxGridTable_DATA1: TcxGridDBColumn;
    cxGridTable_DATA2: TcxGridDBColumn;
    cxGridTable_BONUS: TcxGridDBColumn;
    pnButtons: TPanel;
    cxGridTable_FLG_EXPIRED: TcxGridDBColumn;
    cxGridTable_USER_FULL_NAME: TcxGridDBColumn;
    cxGridTable_SUMA_BONUS: TcxGridDBColumn;
    cxGridTable_PERCENT_BONUS: TcxGridDBColumn;
    cxGridTable_FLG_CALC_BY_SUMA: TcxGridDBColumn;
    bbImportGoods: TdxBarButton;
    cxGridTable_CURRENCY_TITLE: TcxGridDBColumn;
    cxGridTable_IMG: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    dxBarDateCombo: TdxBarDateCombo;
    btnClose: TcxButton;
    procedure cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbDeleteClick(Sender: TObject);
    procedure bbAddClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure bbImportGoodsClick(Sender: TObject);
    procedure cxGridTable_BONUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure dxBarButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure SelectionChanged;

    procedure ShowAddNewDialog;
    procedure ShowModifyDialog;
    procedure DoDeleteRecord;

    procedure ShowImportGoodsDialog;
    function ImportGoods(const ImportInfo:TImportBonusGoodsInfo):Boolean;
  protected
    { protected declarations }
    procedure Prepare;override;
    procedure SetupSecurityItems;override;
  public
    { Public declarations }
  end;


implementation

uses DataModuleDB, DataModuleAdditions, SWNSecurityFlags, frmBonusGoodsEditorDialog, SWNSecurity, SWNUtils,
  SWNDBErrors, SWNDBEvents;

{$R *.dfm}

{ TfrmBonusGoodsDlg }

procedure TfrmBonusGoodsDlg.bbAddClick(Sender: TObject);
begin
     ShowAddNewDialog;
end;

procedure TfrmBonusGoodsDlg.bbDeleteClick(Sender: TObject);
begin
     DoDeleteRecord;
end;

procedure TfrmBonusGoodsDlg.bbImportGoodsClick(Sender: TObject);
begin
     ShowImportGoodsDialog;
end;

procedure TfrmBonusGoodsDlg.bbModifyClick(Sender: TObject);
begin
     ShowModifyDialog;
end;

procedure TfrmBonusGoodsDlg.cxGridTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
     if SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_БТ_Администрировать) then
     begin
          bbModifyClick(bbModify);
          AHandled:=True;
     end;
end;

procedure TfrmBonusGoodsDlg.cxGridTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmBonusGoodsDlg.cxGridTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridTable_FLG_EXPIRED.Index]) then
     begin
          if ARecord.Values[cxGridTable_FLG_EXPIRED.Index]=1 then AStyle:=dmAdditions.cxStyle_TextGray;
     end;
end;

procedure TfrmBonusGoodsDlg.cxGridTable_BONUSGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
var n:double;
    s:string;
begin
     if VarIsNumeric(ARecord.Values[cxGridTable_FLG_CALC_BY_SUMA.Index])
        and VarIsFloat(ARecord.Values[cxGridTable_SUMA_BONUS.Index])
        and VarIsFloat(ARecord.Values[cxGridTable_PERCENT_BONUS.Index])
        and VarIsStr(ARecord.Values[cxGridTable_CURRENCY_TITLE.Index]) then
     begin
          if (ARecord.Values[cxGridTable_FLG_CALC_BY_SUMA.Index]=1) then
          begin
               n:=ARecord.Values[cxGridTable_SUMA_BONUS.Index];
               s:=ARecord.Values[cxGridTable_CURRENCY_TITLE.Index];
               AText:=Format('%2.2f %s',[n,s]);
          end
          else
          begin
               n:=ARecord.Values[cxGridTable_PERCENT_BONUS.Index];
               AText:=Format('%2.2f%%',[n]);
          end;
     end;
end;

procedure TfrmBonusGoodsDlg.DoDeleteRecord;
begin
     if ShowAskDialog('Stergere produs',Format('Doriti sa stergeti "%s" ?',[IBCQueryBonus.FieldByName('GOODSNAME').AsString]))=mrYes then
     begin
          IBCQueryBonus.UpdateTransaction.StartTransaction;
          try
             IBCQueryBonus.Delete;
             IBCQueryBonus.UpdateTransaction.Commit;
          except on E:Exception do
             begin
                  IBCQueryBonus.UpdateTransaction.Rollback;
                  if Not ProcessSWNError(E) then raise;
             end;
          end;
     end;
end;

procedure TfrmBonusGoodsDlg.dxBarButton1Click(Sender: TObject);
var
  i: integer;
  Query: TIBCQuery;
begin
      Query := TIBCQuery.Create(nil);
      Query.SQL.Text := 'update TDB_GOODS_BONUS set data2=:data where goodsid=:goodsid';
      Query.Transaction := dmDB.IBCTrDefaultUpdate;
      try
          for i := 0 to cxGridTable.Controller.SelectedRecordCount - 1 do
          begin
            Query.ParamByName('goodsID').AsInteger := cxGridTable.Controller.SelectedRecords[i].Values[cxGridTable_GOODSID.Index];
            Query.ParamByName('Data').AsDateTime := dxBarDateCombo.Date;
            Query.ExecSQL;
          end;
      finally
        Query.Free;
      end;
      IBCQueryBonus.Refresh;
end;

procedure TfrmBonusGoodsDlg.FormShow(Sender: TObject);
begin
  dxBarDateCombo.Date := Date;
end;

function TfrmBonusGoodsDlg.ImportGoods(const ImportInfo: TImportBonusGoodsInfo):Boolean;
var Query:TIBCQuery;
begin
     Result:=False;
     Query:=TIBCQuery.Create(Self);
     try
        Query.Connection:=dmDB.IBCConnection;
        Query.Transaction:=dmDB.IBCTrDefaultUpdate;
        Query.AutoCommit:=False;
        Query.SQL.Text:='EXECUTE PROCEDURE SP_GOODS_BONUS_IMPORT(:GOODS,:DT1,:DT2,:BT,:BV,:BC,:CP)';
        Query.ParamByName('GOODS').AsString:=ImportInfo.GoodsList;
        Query.ParamByName('DT1').AsDate:=ImportInfo.DateStart;
        Query.ParamByName('DT2').AsDate:=ImportInfo.DateEnd;
        Query.ParamByName('BT').AsInteger:=ImportInfo.BonusType;
        Query.ParamByName('BV').AsFloat:=ImportInfo.BonusValue;
        Query.ParamByName('BC').AsInteger:=ImportInfo.BonusCurrencyID;
        Query.ParamByName('CP').AsInteger:=Ord(ImportInfo.ClearPreviousGoods);
        Query.Transaction.StartTransaction;
        try
           Query.Execute;
           Query.Transaction.Commit;
           Result:=True;
        except on E: Exception do
           begin
                Query.Transaction.Rollback;
                if Not ProcessSWNError(E) then raise
           end;
        end;
     finally
        Query.Free;
     end;
end;

procedure TfrmBonusGoodsDlg.Prepare;
begin
     IBCQueryBonus.Active:=True;
     SelectionChanged;
     cxGridTable_GOODSNAME.Focused:=True;
end;

procedure TfrmBonusGoodsDlg.SelectionChanged;
var fAdd,fEdit,fDelete:Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;

     if cxGridTable.DataController.RecNo>0 then
     begin
          fEdit:=True;
          fDelete:=True;
     end;

     bbAdd.Enabled:=fAdd;
     bbImportGoods.Enabled:=fAdd;
     bbModify.Enabled:=fEdit;
     bbDelete.Enabled:=fDelete;
end;

procedure TfrmBonusGoodsDlg.SetupSecurityItems;
begin
     if Not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_БТ_Администрировать) then
     begin
          bbAdd.Visible:=ivNever;
          bbModify.Visible:=ivNever;
          bbDelete.Visible:=ivNever;
     end;

     if dxBarManagerBar1.ItemLinks.VisibleItemCount=0 then
     begin
          dxBarManagerBar1.Visible:=False;
          dxBarDockControl1.Visible:=False;
     end;
end;

procedure TfrmBonusGoodsDlg.ShowAddNewDialog;
var dialog:TfrmBonusGoodsEditorDlg;
begin
     dialog:=TfrmBonusGoodsEditorDlg.Create(Self,IBCQueryBonus,IBCDataSourceBonus);
     try
        dialog.CreateNewRecord:=True;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoodsDlg.ShowImportGoodsDialog;
var dialog:TfrmBonusGoodsImportGoodsDlg;
begin
     dialog:=TfrmBonusGoodsImportGoodsDlg.Create(Self);
     try
        if dialog.ShowModal=mrOk then
        begin
             if ImportGoods(dialog.GetImportInfo) then IBCQueryBonus.Refresh;
        end;
     finally
        dialog.Free;
     end;
end;

procedure TfrmBonusGoodsDlg.ShowModifyDialog;
var dialog:TfrmBonusGoodsEditorDlg;
begin
     dialog:=TfrmBonusGoodsEditorDlg.Create(Self,IBCQueryBonus,IBCDataSourceBonus);
     try
        dialog.CreateNewRecord:=False;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

end.

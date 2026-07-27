unit frmGoodsFromAcnt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, Menus,
  DBAccess, IBC, MemDS, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, DialogTitle, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxBar, SWNDBErrors, cxNavigator, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations,
  SWNUtils;

type
  TfmGoodsFromAcnt = class(TSWNCustomForm)
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dtDialogTitle: TDialogTitle;
    pnBottom: TPanel;
    btnCancel: TcxButton;
    IBCQueryGoods: TIBCQuery;
    IBCDSGoods: TIBCDataSource;
    cxGridDBTableGOODSID: TcxGridDBColumn;
    cxGridDBTableTITLE: TcxGridDBColumn;
    cxGridDBTable_Price1: TcxGridDBColumn;
    cxGridDBTable_Price0: TcxGridDBColumn;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddGoods: TdxBarButton;
    bbRemoveGoods: TdxBarButton;
    dxBarDockControl1: TdxBarDockControl;
    IBCLocalUpdate: TIBCTransaction;
    pnClient: TPanel;
    bbEditGoods: TdxBarButton;
    procedure bbAddGoodsClick(Sender: TObject);
    procedure bbRemoveGoodsClick(Sender: TObject);
    procedure cxGridDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure bbEditGoodsClick(Sender: TObject);
    procedure cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fGoodsAcntID : Integer;
    fLastGoodsID: Integer;
    procedure SetGoodsAcntID(const Value: integer);
    procedure SelectionChanged;
    procedure WhenAddGoodsBurst(const GoodsID:integer; const GoodsTitle:String; var Added:Boolean; var Count:integer);
  protected
    procedure Prepare;override;
    procedure LoadStates;override;
    procedure SaveStates;override;

  public
    { Public declarations }
    constructor Create(const AOwner:TComponent; const AGoodsAcntID: integer);reintroduce;
    procedure ShowAddGoodsDialog;

    property GoodsAcntID:integer read fGoodsAcntID write SetGoodsAcntID;
  end;

implementation

{$R *.dfm}

uses SWNValueStorageUnit, DataModuleDB, frmGoods, DataModuleAdditions, frmBSToolsCopyGridClipboardDialog;

procedure TfmGoodsFromAcnt.ShowAddGoodsDialog;
var dialog:TfrmGoodsBrowser;
    tmpAdded:Boolean;
    tmpCount:integer;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.BurstMode:=True;
        dialog.OnBurstAddGoods:=WhenAddGoodsBurst;
        if dialog.SelectGoods(fLastGoodsID,False,0,'Выберите товары для связывания с наименованием по накладной')
          then WhenAddGoodsBurst(dialog.GoodsID,dialog.GoodsTitle,tmpAdded,tmpCount);
     finally
        dialog.Free;
     end;
end;

procedure TfmGoodsFromAcnt.WhenAddGoodsBurst(const GoodsID: integer; const GoodsTitle: String; var Added: Boolean; var Count: integer);
var Query :TIBCQuery;
begin
     Query := TIBCQuery.Create(nil);
     try
       Query.Transaction := IBCLocalUpdate;
       Query.Transaction.StartTransaction;
       try
          Query.SQL.Text := 'update ts_goods set Goods_Acnt_ID =:goodsacntid where goodsid=:goodsid';
          Query.ParamByName('goodsacntid').AsInteger := GoodsAcntID;
          Query.ParamByName('GoodsID').AsInteger := GoodsID;
          Query.ExecSQL;
          Added:=True;
          fLastGoodsID:=GoodsID;
{
          if not Added then
          begin
              Query.SQL.Text := 'update ts_goods set Goods_Acnt_ID =:goodsacntid where goodsid=:goodsid';
              Query.ParamByName('goodsacntid').AsInteger := -1;
              Query.ParamByName('GoodsID').AsInteger := IBCQueryGoods.FieldByName('GoodsID').AsInteger;
              Query.ExecSQL;

          end;
 }
          IBCLocalUpdate.Commit;
       except on E:Exception do
          begin
               IBCLocalUpdate.Rollback;
               if Not ProcessSWNError(E) then raise;
          end;
       end;
       IBCQueryGoods.Refresh;
     finally
       FreeAndNil(Query);
     end;
end;



procedure TfmGoodsFromAcnt.bbAddGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure TfmGoodsFromAcnt.bbEditGoodsClick(Sender: TObject);
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.BrowseGoods(IBCQueryGoods.FieldByName('GoodsID').AsInteger);
        IBCQueryGoods.Refresh;
     finally
        dialog.Free;
     end;
end;

procedure TfmGoodsFromAcnt.bbRemoveGoodsClick(Sender: TObject);
var Query :TIBCQuery;
begin
     if ShowAskDialog('Удаление ссылки', 'Удалить ссылку на товар?')=mrYes then
     begin
          Query := TIBCQuery.Create(nil);
          try
             Query.Transaction := IBCLocalUpdate;
             Query.Transaction.StartTransaction;
             try
                Query.SQL.Text := 'update ts_goods set Goods_Acnt_ID = -1 where goodsid=:goodsid';
                Query.ParamByName('GoodsID').AsInteger := IBCQueryGoods.FieldByName('GoodsID').AsInteger;
                Query.ExecSQL;
                Query.Transaction.Commit;
               IBCQueryGoods.Refresh;
             except on E:Exception do
                begin
                     Query.Transaction.Rollback;
                     if Not ProcessSWNError(E) then raise;
                end;
             end
          finally
             Query.Free;
          end;
     end;
end;

constructor TfmGoodsFromAcnt.Create(const AOwner:TComponent; const AGoodsAcntID: integer);
begin
     inherited Create(AOwner);
     fGoodsAcntID:=AGoodsAcntID;
end;

procedure TfmGoodsFromAcnt.cxGridDBTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color := $E8E8E8;
     end;
end;

procedure TfmGoodsFromAcnt.cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfmGoodsFromAcnt.cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     // Ctrl+Alt+C - Copy grid to buffer
     if (key=67) and (Shift=[ssAlt,ssCtrl]) then
     begin
          ShowCopyGridContent(Self, cxGridDBTable);
     end
     else
     // Ctrl+C
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          // copy cell content in clipboard
          CopyGridCellTextToClipboard(cxGridDBTable);
          Key:=0;
          Shift:=[];
     end
end;

procedure TfmGoodsFromAcnt.Prepare;
begin
     SetupSecurityItems;
     dtDialogTitle.Text:=Format('%s №%d',[dtDialogTitle.Text, GoodsAcntID]);
     IBCQueryGoods.Close;
     IBCQueryGoods.ParamByName('goodsacntid').AsInteger := GoodsAcntID;
     IBCQueryGoods.Open;
     SelectionChanged;
end;

procedure TfmGoodsFromAcnt.SaveStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) then AppUserConfigStorage.FormPositions.SaveFormPos(Self);
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then AppUserConfigStorage.GridColumns.SaveGridStructure(cxGridDBTable);
end;

procedure TfmGoodsFromAcnt.SelectionChanged;
var fAdd, fEdit, fDelete: Boolean;
begin
     fAdd:=True;
     fEdit:=False;
     fDelete:=False;
     if Assigned(cxGridDBTable.Controller.FocusedRecord) then
     begin
          fEdit:=True;
          fDelete:=True;
     end;
     bbAddGoods.Enabled:=fAdd;
     bbEditGoods.Enabled:=fEdit;
     bbRemoveGoods.Enabled:=fDelete;
end;

procedure TfmGoodsFromAcnt.SetGoodsAcntID(const Value: integer);
begin
   fGoodsAcntID := Value;
end;

procedure TfmGoodsFromAcnt.LoadStates;
begin
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveFormPos) and AppUserConfigStorage.FormPositions.ReadFormPos(Self) then Self.Position:=poDesigned;
     if AppUserConfigStorage.BooleanValues.GetValue(cSETTINGS_UserSaveGridColumns) then AppUserConfigStorage.GridColumns.ReadGridStructure(cxGridDBTable);
end;




end.

unit frame13PromoGoodsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SWNBaseFrameUnit, DB, DBAccess, IBC, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  dxBar, cxClasses, MemDS, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView, cxGrid,
  cxLookAndFeels, cxLookAndFeelPainters;

type
  Tframe13PromoGoods = class(TSWNBaseFrame)
    IBCQueryPromoGoods: TIBCQuery;
    IBCDataSourcePromoGoods: TIBCDataSource;
    cxGridPromoGoodsTable: TcxGridDBTableView;
    cxGridPromoGoodsLevel: TcxGridLevel;
    cxGridPromoGoods: TcxGrid;
    cxGridPromoGoods_GOODS_NAME: TcxGridDBColumn;
    cxGridPromoGoods_DATA_START: TcxGridDBColumn;
    cxGridPromoGoods_DATA_END: TcxGridDBColumn;
    cxGridPromoGoods_DATA_GROUP: TcxGridDBColumn;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbAddPromoGoods: TdxBarButton;
    bbRemove: TdxBarButton;
    cxGridPromoGoods_QTY_AVAILABLE: TcxGridDBColumn;
    bbModify: TdxBarButton;
    cxGridPromoGoods_GOODSID: TcxGridDBColumn;
    dxBarPopupMenu: TdxBarPopupMenu;
    procedure cxGridPromoGoods_DATA_GROUPGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure cxGridPromoGoodsTableStylesGetGroupStyle(Sender: TcxGridTableView; ARecord: TcxCustomGridRecord;
      ALevel: Integer; out AStyle: TcxStyle);
    procedure cxGridPromoGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbAddPromoGoodsClick(Sender: TObject);
    procedure bbModifyClick(Sender: TObject);
    procedure cxGridPromoGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure bbRemoveClick(Sender: TObject);
    procedure cxGridPromoGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    fHasDefault:Boolean;
    fDefaultDateStart:TDate;
    fDefaultDateEnd:TDate;
    fLastGoodsID:integer;
    procedure SelectionChanged;
    procedure ShowAddGoodsDialog;
    procedure ShowModifyGoodsDialog;
    procedure DeleteSelectedGoods;
  protected
    { Protected declarations }
    function InitFrameID:integer;override;
    procedure DoFrameShow;override;
    procedure DoFrameHide;override;
    function GetFilterFields:TFrameFilterFields;override;
    function GetFrameButtons:TFrameButtons;override;
  public
    { Public declarations }
  end;

implementation

uses DataModuleDB, DataModuleAdditions, frmPromoGoodsAddGoodsDialog, SWNUtils;

{$R *.dfm}

{ Tframe13PromoGoods }

procedure Tframe13PromoGoods.bbAddPromoGoodsClick(Sender: TObject);
begin
     ShowAddGoodsDialog;
end;

procedure Tframe13PromoGoods.bbModifyClick(Sender: TObject);
begin
     ShowModifyGoodsDialog;
end;

procedure Tframe13PromoGoods.bbRemoveClick(Sender: TObject);
begin
     DeleteSelectedGoods;
end;

procedure Tframe13PromoGoods.cxGridPromoGoodsTableCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
     if bbModify.Enabled then
     begin
          ShowModifyGoodsDialog;
          AHandled:=True;
     end;
end;

procedure Tframe13PromoGoods.cxGridPromoGoodsTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure Tframe13PromoGoods.cxGridPromoGoodsTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     ProcessCommonKeys(cxGridPromoGoodsTable,Key,Shift);
end;

procedure Tframe13PromoGoods.cxGridPromoGoodsTableStylesGetGroupStyle(Sender: TcxGridTableView;
  ARecord: TcxCustomGridRecord; ALevel: Integer; out AStyle: TcxStyle);
begin
     if Assigned(ARecord) and (ALevel=0) and (Not VarIsNull(ARecord.Values[cxGridPromoGoods_DATA_GROUP.Index])) then
     case ARecord.Values[cxGridPromoGoods_DATA_GROUP.Index] of
     -1: AStyle:=dmAdditions.cxStyle_TextBoldRed;
     0:  AStyle:=dmAdditions.cxStyle_TextBoldGreen;
     1:  AStyle:=dmAdditions.cxStyle_Bold;
     end;
end;

procedure Tframe13PromoGoods.cxGridPromoGoods_DATA_GROUPGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
     if Not VarIsNull(ARecord.Values[cxGridPromoGoods_DATA_GROUP.Index]) then
     case ARecord.Values[cxGridPromoGoods_DATA_GROUP.Index] of
     -1: AText:='Прошедшие';
     0:  AText:='Текущие';
     1:  AText:='Будущие';
     end;
end;

procedure Tframe13PromoGoods.DeleteSelectedGoods;
begin
     if ShowAskDialog('Удаление товара','Удалить товар'+#13#10+IBCQueryPromoGoods.FieldByName('GOODS_NAME').AsString+#13#10+'из промо акции?')=mrYes then
     begin
          IBCQueryPromoGoods.UpdateTransaction.StartTransaction;
          try
             IBCQueryPromoGoods.Delete;
             IBCQueryPromoGoods.UpdateTransaction.Commit;
          except
             IBCQueryPromoGoods.UpdateTransaction.Rollback;
             raise;
          end;
     end;
end;

procedure Tframe13PromoGoods.DoFrameHide;
begin
     IBCQueryPromoGoods.Active:=False;

     inherited;
end;

procedure Tframe13PromoGoods.DoFrameShow;
begin
     inherited;

     fHasDefault:=False;
     fLastGoodsID:=-1;

     IBCQueryPromoGoods.Active:=True;
     cxGridPromoGoodsTable.DataController.Groups.FullExpand;
     SelectionChanged;
end;

function Tframe13PromoGoods.GetFilterFields: TFrameFilterFields;
begin
     Result:=[];
end;

function Tframe13PromoGoods.GetFrameButtons: TFrameButtons;
begin
     Result:=[];
end;

function Tframe13PromoGoods.InitFrameID: integer;
begin
     Result:=13; // АКЦИИ - Промо акции по товарам
end;

procedure Tframe13PromoGoods.SelectionChanged;
var f1,f2,f3:Boolean;
begin
     f1:=True; // Add Promo Goods + Security
     f2:=False;
     f3:=False;
     if cxGridPromoGoodsTable.DataController.RecNo>0 then
     begin
          f2:=True; // Modify + Security
          f3:=True; // Remove + Security
     end;
     bbAddPromoGoods.Enabled:=f1;
     bbModify.Enabled:=f2;
     bbRemove.Enabled:=f3;
end;

procedure Tframe13PromoGoods.ShowAddGoodsDialog;
var dialog:TfrmPromoGoodsAddGoodsDlg;
begin
     dialog:=TfrmPromoGoodsAddGoodsDlg.Create(Self,IBCQueryPromoGoods,IBCDataSourcePromoGoods);
     try
        dialog.CreateNewRecord:=True;
        if fHasDefault then
        begin
             dialog.DefaultDateStart:=fDefaultDateStart;
             dialog.DefaultDateEnd:=fDefaultDateEnd;
        end;
        dialog.LastGoodsID:=fLastGoodsID;
        if dialog.ShowModal=mrOk then
        begin
             fLastGoodsID:=dialog.LastGoodsID;
             if dialog.HasDefault then
             begin
                  fHasDefault:=True;
                  fDefaultDateStart:=dialog.DefaultDateStart;
                  fDefaultDateEnd:=dialog.DefaultDateEnd;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

procedure Tframe13PromoGoods.ShowModifyGoodsDialog;
var dialog:TfrmPromoGoodsAddGoodsDlg;
begin
     dialog:=TfrmPromoGoodsAddGoodsDlg.Create(Self,IBCQueryPromoGoods,IBCDataSourcePromoGoods);
     try
        dialog.CreateNewRecord:=False;
        if fHasDefault then
        begin
             dialog.DefaultDateStart:=fDefaultDateStart;
             dialog.DefaultDateEnd:=fDefaultDateEnd;
        end;
        if dialog.ShowModal=mrOk then
        begin
             fLastGoodsID:=dialog.LastGoodsID;
             if dialog.HasDefault then
             begin
                  fHasDefault:=True;
                  fDefaultDateStart:=dialog.DefaultDateStart;
                  fDefaultDateEnd:=dialog.DefaultDateEnd;
             end;
        end;
     finally
        dialog.Free;
     end;
end;

end.

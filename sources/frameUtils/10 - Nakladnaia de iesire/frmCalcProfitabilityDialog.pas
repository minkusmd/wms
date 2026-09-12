unit frmCalcProfitabilityDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  Dialogs, cxStyles, cxCustomData,
  DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridDBTableView, cxGrid, DialogTitle, StdCtrls, IBC,
  dxBar,
  cxButtons, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxCurrencyEdit, Vcl.Menus, cxClasses, DBAccess, MemDS,
  cxGridTableView, cxGridCustomView;

type
  TfrmCalcProfitabilityDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGridDBTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    IBCQueryProfit: TIBCQuery;
    IBCDataSourceProfit: TIBCDataSource;
    cxGridDBTable_GOODSID: TcxGridDBColumn;
    cxGridDBTable_GOODS_TITLE: TcxGridDBColumn;
    cxGridDBTable_SUMAMDL_IN: TcxGridDBColumn;
    cxGridDBTable_SUMAMDL_OUT: TcxGridDBColumn;
    cxGridDBTable_PROFIT_LEI: TcxGridDBColumn;
    cxGridDBTable_PROFIT_PROCENTE: TcxGridDBColumn;
    dxBarManager1: TdxBarManager;
    bbOpenGoods: TdxBarButton;
    btnCancel: TcxButton;
    procedure cxGridDBTableTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
    procedure bbOpenGoodsClick(Sender: TObject);
    procedure cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fDocID: integer;
    procedure SelectionChanged;
    procedure SetDocID(const Value: integer);
    procedure OpenGoods(const GoodsID:integer);

  protected
    { protected declarations }
    procedure Prepare;override;

  public
    { Public declarations }
    property DocID:integer read FDocID write SetDocID;
  end;


implementation

uses DataModuleAdditions, SWNUtils, frmGoods;

{$R *.dfm}

{ TfrmCalcProfitabilityDlg }

procedure TfrmCalcProfitabilityDlg.bbOpenGoodsClick(Sender: TObject);
begin
     OpenGoods(IBCQueryProfit.FieldByName('GOODSID').AsInteger);
end;

procedure TfrmCalcProfitabilityDlg.cxGridDBTableFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
     SelectionChanged;
end;

procedure TfrmCalcProfitabilityDlg.cxGridDBTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (Key=67) and (Shift=[ssCtrl]) then
     begin
          CopyGridCellTextToClipboard(cxGridDBTable);
          Key:=0;
          Shift:=[];
     end;
end;

procedure TfrmCalcProfitabilityDlg.cxGridDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var percent:integer;
begin
     if Not VarIsNull(ARecord.Values[cxGridDBTable_PROFIT_PROCENTE.Index]) then
     begin
          percent:=ARecord.Values[cxGridDBTable_PROFIT_PROCENTE.Index];
          if percent<0 then AStyle:=dmAdditions.cxStyle_CalcProfit_Red
          else
          if (percent>=0) and (percent<10) then AStyle:=dmAdditions.cxStyle_CalcProfitYellow
          else AStyle:=dmAdditions.cxStyle_CalcProfitGreen;
     end;
end;

procedure TfrmCalcProfitabilityDlg.cxGridDBTableTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
var n100,value:double;
    perc:integer;
begin
     if VarIsFloat(cxGridDBTable.DataController.Summary.FooterSummaryValues[1]) and VarIsFloat(cxGridDBTable.DataController.Summary.FooterSummaryValues[2]) then
     begin
          n100:=cxGridDBTable.DataController.Summary.FooterSummaryValues[1];
          if(n100<>0) then
          begin
               value:=cxGridDBTable.DataController.Summary.FooterSummaryValues[2];
               perc:=round((value*100/n100)-100);
               AText:=format('%d%%',[perc]);
          end
          else AText:='???';
     end;
end;

procedure TfrmCalcProfitabilityDlg.OpenGoods(const GoodsID: integer);
var dialog:TfrmGoodsBrowser;
begin
     dialog:=TfrmGoodsBrowser.Create(Self);
     try
        dialog.GoodsID:=GoodsID;
        dialog.ShowModal;
     finally
        dialog.Free;
     end;
end;

procedure TfrmCalcProfitabilityDlg.Prepare;
begin
     IBCQueryProfit.ParamByName('docID').AsInteger:=fDocID;
     IBCQueryProfit.Active:=true;
     cxGridDBTable_GOODS_TITLE.Focused:=True;
     SelectionChanged;
end;

procedure TfrmCalcProfitabilityDlg.SelectionChanged;
var fOpenGoods:Boolean;
begin
     fOpenGoods:=False;
     if (cxGridDBTable.DataController.RecNo>0) then
     begin
          fOpenGoods:=True;
     end;
     bbOpenGoods.Enabled:=fOpenGoods;
end;

procedure TfrmCalcProfitabilityDlg.SetDocID(const Value: integer);
begin
     fDocID := Value;
end;

end.

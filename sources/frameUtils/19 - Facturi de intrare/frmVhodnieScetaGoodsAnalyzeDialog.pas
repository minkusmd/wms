unit frmVhodnieScetaGoodsAnalyzeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS, cxImageComboBox, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmVhodnieScetaGoodsAnalyzeDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnBottom: TPanel;
    btnClose: TButton;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridTable_GOODSID: TcxGridDBColumn;
    cxGridTable_GOODS_TITLE: TcxGridDBColumn;
    cxGridTable_PRICE0_NEW: TcxGridDBColumn;
    cxGridTable_PRICE0_OLD: TcxGridDBColumn;
    cxGridTable_PRICE_DIFF: TcxGridDBColumn;
    IBCQueryData: TIBCQuery;
    IBCDataSourceData: TIBCDataSource;
    procedure cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    fDocID: Integer;
    procedure SetDocID(const Value: Integer);
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property DocID:Integer read FDocID write SetDocID;
  end;


implementation

{$R *.dfm}

uses DataModuleDB, DataModuleAdditions;

{ TfrmVhodnieScetaGoodsAnalyzeDlg }

procedure TfrmVhodnieScetaGoodsAnalyzeDlg.cxGridTableCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
     // highlight selected row
     if AViewInfo.RecordViewInfo.Focused and Not AViewInfo.Focused then
     begin
          ACanvas.Brush.Color:=$E8E8E8;
     end;
end;

procedure TfrmVhodnieScetaGoodsAnalyzeDlg.Prepare;
begin
     cxGridTable_GOODS_TITLE.Focused:=True;

     IBCQueryData.ParamByName('DOCID').asInteger:=fDocID;
     IBCQueryData.Active:=True;
end;

procedure TfrmVhodnieScetaGoodsAnalyzeDlg.SetDocID(const Value: Integer);
begin
     fDocID := Value;
end;

end.

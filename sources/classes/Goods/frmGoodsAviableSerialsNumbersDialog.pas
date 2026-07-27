unit frmGoodsAviableSerialsNumbersDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmGoodsAviableSerialsNumbersDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    btnClose: TButton;
    IBCQuerySN: TIBCQuery;
    IBCDataSourceSN: TIBCDataSource;
    cxGridTable_STOCK_TITLE: TcxGridDBColumn;
    cxGridTable_SN: TcxGridDBColumn;
    cxGridTable_COUNTRY_NAME: TcxGridDBColumn;
    cxGridTable_VENDOR_NAME: TcxGridDBColumn;
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
  private
    FGoodsTitle: String;
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsTitle(const Value: String);
    { Private declarations }
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:Integer read FGoodsID write SetGoodsID;
    property GoodsTitle:String read FGoodsTitle write SetGoodsTitle;
  end;


implementation

uses
  SWNUtils, DataModuleDB, DataModuleAdditions;

{$R *.dfm}


procedure TfrmGoodsAviableSerialsNumbersDlg.cxGridTableKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
  ProcessCommonKeys(self, cxGridTable, Key, Shift);
end;

{ TfrmGoodsAviableSerialsNumbersDlg }

procedure TfrmGoodsAviableSerialsNumbersDlg.Prepare;
begin
     inherited;

     dtDialogTitle.Text:=Format('Numere de serii disponibile pentru %s',[FGoodsTitle]);

     IBCQuerySN.ParamByName('FIRMA').AsInteger:=dmDB.CurrentFirma;
     IBCQuerySN.ParamByName('GOODSID').AsInteger:=FGoodsID;
     IBCQuerySN.Open;
end;

procedure TfrmGoodsAviableSerialsNumbersDlg.SetGoodsID(const Value: Integer);
begin
     FGoodsID := Value;
end;

procedure TfrmGoodsAviableSerialsNumbersDlg.SetGoodsTitle(const Value: String);
begin
     FGoodsTitle := Value;
end;

end.

unit frmGoodsAviablePartNumbersDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, SWNBaseUnit,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.StdCtrls, cxClasses, dxBar, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ExtCtrls, DialogTitle, DBAccess, IBC, MemDS, cxCalc,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxDateRanges, dxScrollbarAnnotations;

type
  TfrmGoodsAviablePartNumbersDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    pnClient: TPanel;
    dxBarManager1: TdxBarManager;
    dxBarDockControl1: TdxBarDockControl;
    cxGridTable: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    dxBarManager1Bar1: TdxBar;
    btnClose: TButton;
    IBCQueryPARTS: TIBCQuery;
    IBCDataSourcePARTS: TIBCDataSource;
    cxGridTable_STOCK_TITLE: TcxGridDBColumn;
    cxGridTable_PARTNO: TcxGridDBColumn;
    cxGridTable_COUNTRY_NAME: TcxGridDBColumn;
    cxGridTable_VENDOR_NAME: TcxGridDBColumn;
    cxGridTable_QTY: TcxGridDBColumn;
    procedure cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FGoodsTitle: String;
    FGoodsID: Integer;
    procedure SetGoodsID(const Value: Integer);
    procedure SetGoodsTitle(const Value: String);
    procedure SetupQtyFields;
  protected
    { protected declarations }
    procedure Prepare;override;
  public
    { Public declarations }
    property GoodsID:Integer read FGoodsID write SetGoodsID;
    property GoodsTitle:String read FGoodsTitle write SetGoodsTitle;
  end;


implementation

{$R *.dfm}

uses DataModuleAdditions, DataModuleDB, SWNConst, SWNValueStorageUnit, SWNUtils;

{ TfrmGoodsAviableSerialsNumbersDlg }

procedure TfrmGoodsAviablePartNumbersDlg.cxGridTableKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if (key=67) and (Shift=[ssAlt,ssCtrl]) then
     begin
          ShowCopyGridContent(Self, cxGridTable);
     end;
end;

procedure TfrmGoodsAviablePartNumbersDlg.Prepare;
begin
     inherited;
     SetupQtyFields;
     dtDialogTitle.Text:=Format('Partidele disponibile pentru %s',[FGoodsTitle]);

     IBCQueryPARTS.ParamByName('FIRMA').AsInteger:=dmDB.CurrentFirma;
     IBCQueryPARTS.ParamByName('GOODSID').AsInteger:=FGoodsID;
     IBCQueryPARTS.Open;
end;

procedure TfrmGoodsAviablePartNumbersDlg.SetGoodsID(const Value: Integer);
begin
     FGoodsID := Value;
end;

procedure TfrmGoodsAviablePartNumbersDlg.SetGoodsTitle(const Value: String);
begin
     FGoodsTitle := Value;
end;

procedure TfrmGoodsAviablePartNumbersDlg.SetupQtyFields;
var qtyDigitsMode:Integer;
begin
     // Numarul de zecimale in QTY :
     qtyDigitsMode:=AppUserTempConfigStorage.IntValues.GetValue(cSETTINGS_AppQtyDigits,cAppDefault_QtyDigits);
     // Остаток
     TcxCalcEditProperties(cxGridTable_QTY.Properties).DisplayFormat:=cQTY_DigitsMask[qtyDigitsMode];
     cxGridTable_QTY.Summary.FooterFormat:=cQTY_DigitsMask[qtyDigitsMode];
end;

end.

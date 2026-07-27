unit frmCalcProfitabilityContractDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DialogTitle, Vcl.StdCtrls,
  DBAccess, IBC, MemDS;

type
  TfrmCalcProfitabilityContractDlg = class(TSWNCustomForm)
    dtDialogTitle: TDialogTitle;
    cxGrid: TcxGrid;
    cxGridDBTable: TcxGridDBTableView;
    cxGridDBTable_GOODSID: TcxGridDBColumn;
    cxGridDBTable_GOODS_TITLE: TcxGridDBColumn;
    cxGridDBTable_SUMAMDL_IN: TcxGridDBColumn;
    cxGridDBTable_SUMAMDL_OUT: TcxGridDBColumn;
    cxGridDBTable_PROFIT_LEI: TcxGridDBColumn;
    cxGridDBTable_PROFIT_PROCENTE: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    btnCancel: TButton;
    IBCQueryProfit: TIBCQuery;
    IBCDataSourceProfit: TIBCDataSource;
    procedure
      cxGridDBTableTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(Sender:
      TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure cxGridDBTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
  private
    { Private declarations }
    fContractID: integer;
    procedure SetContractID(const Value: integer);
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property ContractID: integer read fContractID write SetContractID;
  end;

implementation

{$R *.dfm}

uses
  DataModuleAdditions;

{ TfrmCalcProfitabilityContractDlg }

procedure TfrmCalcProfitabilityContractDlg.cxGridDBTableStylesGetContentStyle(Sender:
  TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem:
  TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  percent: integer;
begin
  if not VarIsNull(ARecord.Values[cxGridDBTable_PROFIT_PROCENTE.Index]) then
  begin
    percent := ARecord.Values[cxGridDBTable_PROFIT_PROCENTE.Index];
    if percent < 0 then
      AStyle := dmAdditions.cxStyle_CalcProfit_Red
    else if (percent >= 0) and (percent < 10) then
      AStyle := dmAdditions.cxStyle_CalcProfitYellow
    else
      AStyle := dmAdditions.cxStyle_CalcProfitGreen;
  end;
end;

procedure TfrmCalcProfitabilityContractDlg.cxGridDBTableTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText
  (Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
  AText: string);
var
  n100, value: double;
  perc: integer;
begin
  if VarIsFloat(cxGridDBTable.DataController.Summary.FooterSummaryValues[1]) and
    VarIsFloat(cxGridDBTable.DataController.Summary.FooterSummaryValues[2]) then
  begin
    n100 := cxGridDBTable.DataController.Summary.FooterSummaryValues[1];
    if (n100 <> 0) then
    begin
      value := cxGridDBTable.DataController.Summary.FooterSummaryValues[2];
      perc := round((value * 100 / n100) - 100);
      AText := format('%d%%', [perc]);
    end
    else
      AText := '???';
  end;
end;

procedure TfrmCalcProfitabilityContractDlg.Prepare;
begin
  IBCQueryProfit.ParamByName('CONTRACTID').AsInteger := fContractID;
  IBCQueryProfit.Active := True;
end;

procedure TfrmCalcProfitabilityContractDlg.SetContractID(const Value: integer);
begin
  fContractID := Value;
end;

end.


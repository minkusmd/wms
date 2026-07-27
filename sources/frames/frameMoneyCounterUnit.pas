unit frameMoneyCounterUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, cxStyles, cxCustomData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGrid, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, dxScrollbarAnnotations, cxLabel, cxMaskEdit, cxClasses, cxGridCustomView, dxUIAClasses;

type
  TframeMoneyCounter = class(TFrame)
    cxGridBanknotes: TcxGrid;
    cxGridBanknotesTable: TcxGridTableView;
    cxGridBanknotesTableCol1: TcxGridColumn;
    cxGridBanknotesTableCol2: TcxGridColumn;
    cxGridBanknotesTableCol3: TcxGridColumn;
    cxGridBanknotesLevel: TcxGridLevel;
    procedure cxGridBanknotesTableCol3StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridBanknotesTableCol1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxGridBanknotesTableCol2PropertiesValidate(Sender: TObject; var DisplayValue: TcxEditValue;
      var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    FOnTotalSumChanged: TNotifyEvent;
    procedure SetOnTotalSumChanged(const Value: TNotifyEvent);
    function GetTotalSum: integer;
  public
    { Public declarations }
    property TotalSum:integer read GetTotalSum;
  published
    { Published declarations }
    property OnTotalSumChanged:TNotifyEvent read FOnTotalSumChanged write SetOnTotalSumChanged;
  end;

implementation

uses DataModuleAdditions;

{$R *.dfm}

procedure TframeMoneyCounter.cxGridBanknotesTableCol1StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if ARecord.Values[cxGridBanknotesTableCol2.Index]>0 then AStyle:=dmAdditions.cxStyle_Bold;
end;

procedure TframeMoneyCounter.cxGridBanknotesTableCol2PropertiesValidate(Sender: TObject; var DisplayValue: TcxEditValue;
  var ErrorText: TCaption; var Error: Boolean);
var
  Qty,Sum:integer;
begin
     Qty:=0;
     if Not VarIsNull(DisplayValue) then
     begin
          Qty:=StrToIntDef(DisplayValue,0);
          if Qty<0 then Qty:=0;
     end;
     Sum:=0;
     if VarIsNumeric(cxGridBanknotesTable.ViewData.EditingRecord.Values[0]) then
     begin
          Sum:=cxGridBanknotesTable.ViewData.EditingRecord.Values[0]*Qty;
     end;
     cxGridBanknotesTable.ViewData.EditingRecord.Values[2]:=Sum;
     if Assigned(FOnTotalSumChanged) then FOnTotalSumChanged(Self);
end;


procedure TframeMoneyCounter.cxGridBanknotesTableCol3StylesGetContentStyle(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
     if VarIsNumeric(ARecord.Values[cxGridBanknotesTableCol2.Index]) then
     begin
          if ARecord.Values[cxGridBanknotesTableCol2.Index]>0 then AStyle:=dmAdditions.cxStyle_MoneyCounter_Total;
     end;
end;

function TframeMoneyCounter.GetTotalSum: integer;
begin
     Result:=Integer(cxGridBanknotesTable.DataController.Summary.FooterSummaryValues[0]);
end;

procedure TframeMoneyCounter.SetOnTotalSumChanged(const Value: TNotifyEvent);
begin
     FOnTotalSumChanged := Value;
end;

end.

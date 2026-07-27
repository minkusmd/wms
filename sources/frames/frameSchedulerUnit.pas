unit frameSchedulerUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNDataFiltering,
  SWNBaseFrameUnit, Dialogs, Menus, cxScheduler, cxSchedulerCustomControls, cxSchedulerUtils,
  cxSchedulerDBStorage, Data.DB, IBC, cxGridDBTableView, cxGridLevel, cxGrid, dxBar, dxBarExtItems,
  cxGridDBChartView, cxGridDBCardView, cxPC, cxSplitter, Vcl.ExtCtrls, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxSchedulerStorage,
  cxSchedulerCustomResourceView, cxSchedulerDayView, cxSchedulerAgendaView, cxSchedulerDateNavigator,
  cxSchedulerHolidays, cxSchedulerTimeGridView, cxSchedulerWeekView, cxSchedulerYearView,
  cxSchedulerGanttView, cxSchedulerRecurrence, cxSchedulerTreeListBrowser,
  cxSchedulerRibbonStyleEventEditor, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  dxDateRanges, dxScrollbarAnnotations, cxDBData, cxCalc, cxLabel, cxCalendar, cxClasses, DBAccess,
  MemDS, cxGridChartView, cxGridCardView, cxGridCustomLayoutView, cxGridCustomTableView,
  cxGridTableView, cxGridCustomView, Vcl.StdCtrls, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxButtons, SQLThread, cxCustomPivotGrid, cxDBPivotGrid,
  cxCurrencyEdit, dxUIAClasses;

type
  TframeScheduler = class(TSWNBaseFrame)
    IBCQueryGeneralFinanceReport: TIBCQuery;
    IBCDataSource1: TIBCDataSource;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarDateCombo1: TdxBarDateCombo;
    dxBarDateCombo2: TdxBarDateCombo;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    IBCDataSource2: TIBCDataSource;
    IBCQuery2: TIBCQuery;
    IBCQueryByUser: TIBCQuery;
    IBCDataSourceByUser: TIBCDataSource;
    qCrediteNeinchise: TIBCQuery;
    dsCrediteNeinchise: TIBCDataSource;
    IBCDataSourceByWebUser: TIBCDataSource;
    IBCQueryByWebUser: TIBCQuery;
    dxBarManager1Bar2: TdxBar;
    bbRefreshUnpayedDocs: TdxBarButton;
    IBCQueryDocsUnpayed: TIBCQuery;
    IBCDataSourceDocsUnpayed: TIBCDataSource;
    IBCQueryBankPosEcomm: TIBCQuery;
    IBCDataSourceBankPosEcomm: TIBCDataSource;
    pcPageControl: TcxPageControl;
    tbsPersonal: TcxTabSheet;
    cxScheduler: TcxScheduler;
    tbsDelivery: TcxTabSheet;
    tbsGeneralInfo: TcxTabSheet;
    dxBarDockControl1: TdxBarDockControl;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    cxGrid3: TcxGrid;
    cxGrid3DBTableView1: TcxGridDBTableView;
    cxGrid3DBCardView1: TcxGridDBCardView;
    cxGrid3DBCardView1Row1: TcxGridDBCardViewRow;
    cxGrid3DBCardView1Row2: TcxGridDBCardViewRow;
    cxGrid3DBChartView1: TcxGridDBChartView;
    cxGrid3DBChartView1Series1: TcxGridDBChartSeries;
    cxGrid3DBChartView1Series2: TcxGridDBChartSeries;
    cxGrid3Level1: TcxGridLevel;
    cxGrid5: TcxGrid;
    cxgrdbtblvw1: TcxGridDBTableView;
    cxGridDBCardView1: TcxGridDBCardView;
    cxGridDBCardViewRow1: TcxGridDBCardViewRow;
    cxGridDBCardViewRow2: TcxGridDBCardViewRow;
    cxGridDBChartView1: TcxGridDBChartView;
    cxGridDBChartSeries1: TcxGridDBChartSeries;
    cxGridDBChartSeries2: TcxGridDBChartSeries;
    cxGridLevel2: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    tbsCredite: TcxTabSheet;
    Panel1: TPanel;
    cxGrid4: TcxGrid;
    cxGrid4DBTableView1: TcxGridDBTableView;
    cxGrid4DBTableView1CT_NAME: TcxGridDBColumn;
    cxGrid4DBTableView1SUMA: TcxGridDBColumn;
    cxGrid4DBTableView1SUMA_TRANSFER: TcxGridDBColumn;
    cxGrid4Level1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    tsDashboard: TcxTabSheet;
    Panel2: TPanel;
    Panel9: TPanel;
    Label39: TLabel;
    Panel11: TPanel;
    lbSellAmountUSD: TLabel;
    Label49: TLabel;
    lbSellLastMonth: TLabel;
    Panel10: TPanel;
    Label41: TLabel;
    lbBuyLastMonth: TLabel;
    Panel12: TPanel;
    lbProfitBrutAmountMDL: TLabel;
    Label44: TLabel;
    Panel13: TPanel;
    Label47: TLabel;
    lbAvgCecLastMonth: TLabel;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    cxButton1: TcxButton;
    lbSellAmountMDL: TLabel;
    lbSellLastYear: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label48: TLabel;
    Label52: TLabel;
    Label58: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    lbBuyLastYear: TLabel;
    lbBuyAmountMDL: TLabel;
    lbBuyAmountUSD: TLabel;
    Label40: TLabel;
    lbProfitBrutLastMonth: TLabel;
    lbProfitBrutLastYear: TLabel;
    Label64: TLabel;
    lbAvgCecLastYear: TLabel;
    lbSellsCount: TLabel;
    lbAvgCec: TLabel;
    lbCountLastMonth: TLabel;
    lbCountLastYear: TLabel;
    cxGrid4DBTableView1Column2: TcxGridDBColumn;
    cxGrid6Level1: TcxGridLevel;
    cxGrid6: TcxGrid;
    IBCQueryGoods1: TIBCQuery;
    IBCDataSourceGoods1: TIBCDataSource;
    cxGrid6TableView1: TcxGridTableView;
    cxGrid6TableView1Column1: TcxGridColumn;
    cxGrid6TableView1Column2: TcxGridColumn;
    cxGrid6TableView1Column3: TcxGridColumn;
    cxGridEComm: TcxGrid;
    cxGridEComm1: TcxGridDBTableView;
    cxGridEComm1_DATA: TcxGridDBColumn;
    cxGridEComm1_SumaPosTerminat: TcxGridDBColumn;
    cxGridEComm1_SUMA_ECOMM: TcxGridDBColumn;
    cxGridECommLevel1: TcxGridLevel;
    Label1: TLabel;
    tbsVinzariOperatori: TcxTabSheet;
    cxDBPivotGrid1: TcxDBPivotGrid;
    IBCQueryVinzariOperator: TIBCQuery;
    IBCDataSourceVinzariOperator: TIBCDataSource;
    cxDBPivotGrid1Field1: TcxDBPivotGridField;
    cxDBPivotGrid1Field2: TcxDBPivotGridField;
    cxDBPivotGrid1Field3: TcxDBPivotGridField;
    cxDBPivotGrid1Field4: TcxDBPivotGridField;
    cxDBPivotGrid1Field5: TcxDBPivotGridField;
    deVinzOper1: TcxDateEdit;
    deVinzOper2: TcxDateEdit;
    cxButton2: TcxButton;
    Panel3: TPanel;
    Label2: TLabel;
    ceNDays: TcxCalcEdit;
    Button1: TButton;
    cxGrid7DBTableView1: TcxGridDBTableView;
    cxGrid7Level1: TcxGridLevel;
    cxGrid7: TcxGrid;
    IBCQuerySupplerDebts: TIBCQuery;
    IBCDataSourceSupplierDebts: TIBCDataSource;
    btnRefreshSupplierDebts: TcxButton;
    cxGrid7DBTableView1CUSTOMERID: TcxGridDBColumn;
    cxGrid7DBTableView1CUSTOMER_NAME: TcxGridDBColumn;
    cxGrid7DBTableView1SUMA_TRANSFER: TcxGridDBColumn;
    MonthCalendar1: TMonthCalendar;
    IBCQueryHistoryCash: TIBCQuery;
    IBCDataSourceHistoryCash: TIBCDataSource;
    cxGridHistoryCash: TcxGrid;
    cxGridHistoryCashTable: TcxGridDBTableView;
    cxGridHistoryCash_DOCID: TcxGridDBColumn;
    cxGridHistoryCash_DATA: TcxGridDBColumn;
    cxGridHistoryCash_DOCTYPE_NAME: TcxGridDBColumn;
    cxGridHistoryCash_SUMA: TcxGridDBColumn;
    cxGridHistoryCash_CURRENCY_NAME: TcxGridDBColumn;
    cxGridHistoryCash_RATE: TcxGridDBColumn;
    cxGridHistoryCash_SUMA_USD: TcxGridDBColumn;
    cxGridHistoryCash_CREATED_BY: TcxGridDBColumn;
    cxGridHistoryCashLevel: TcxGridLevel;
    cxGrid8DBTableView1: TcxGridDBTableView;
    cxGrid8Level1: TcxGridLevel;
    cxGrid8: TcxGrid;
    IBCQueryAWB: TIBCQuery;
    IBCDataSourceAWB: TIBCDataSource;
    cxGrid8DBTableView1DOCID: TcxGridDBColumn;
    cxGrid8DBTableView1DATA: TcxGridDBColumn;
    cxGrid8DBTableView1CT_NAME: TcxGridDBColumn;
    cxGrid8DBTableView1AWB: TcxGridDBColumn;
    cxGrid8DBTableView1SUMA: TcxGridDBColumn;
    cxGrid8DBTableView1DATORIE: TcxGridDBColumn;
    dxBarPopupMenu1: TdxBarPopupMenu;
    bbGotoDocument: TdxBarButton;
    cxDBPivotGrid2: TcxDBPivotGrid;
    IBCQueryPivot1: TIBCQuery;
    IBCDataSourcePivot1: TIBCDataSource;
    dePivot1Begin: TcxDateEdit;
    dePivot1End: TcxDateEdit;
    cxButton3: TcxButton;
    cxDBPivotGrid2LUNA: TcxDBPivotGridField;
    cxDBPivotGrid2WEBGOODSTYPE_NAME: TcxDBPivotGridField;
    cxDBPivotGrid2VENIT: TcxDBPivotGridField;
    cxDBPivotGrid2RULAJ: TcxDBPivotGridField;
    cxDBPivotGrid2PROCENT: TcxDBPivotGridField;
    cxDBPivotGrid2QTY: TcxDBPivotGridField;
    IBCQueryByDate: TIBCQuery;
    cxGrid9Level1: TcxGridLevel;
    cxGrid9: TcxGrid;
    IBCDataSourceByDate: TIBCDataSource;
    cxGrid9DBChartView1: TcxGridDBChartView;
    cxGrid9DBChartView1Series1: TcxGridDBChartSeries;
    cxGrid9DBChartView1Series2: TcxGridDBChartSeries;
    cxGrid9DBChartView1DataGroup1: TcxGridDBChartDataGroup;
    cxGrid9DBChartView1DataGroup2: TcxGridDBChartDataGroup;
    cxGrid9DBChartView1DataGroup3: TcxGridDBChartDataGroup;
    procedure btnRefreshSupplierDebtsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tbsGeneralInfoHide(Sender: TObject);
    procedure cxGrid4DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxPageControl2Change(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxBarButton2Click(Sender: TObject);
    procedure tbsDelivery1Hide(Sender: TObject);
    procedure tbsDelivery1Show(Sender: TObject);
    procedure tbsUnpayedDocsHide(Sender: TObject);
    procedure tbsUnpayedDocsShow(Sender: TObject);
    procedure tsDashboardShow(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxGrid6TableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton2Click(Sender: TObject);
    procedure tbsVinzariOperatoriShow(Sender: TObject);
    procedure ceNDaysPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText:
      TCaption; var Error: Boolean);
    procedure cxGrid7DBTableView1SUMA_TRANSFERCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
      TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid8DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridHistoryCashTableKeyDown(Sender: TObject; var Key: Word; Shift:
        TShiftState);
    procedure pcPageControlEnter(Sender: TObject);
    procedure qCrediteNeinchiseAfterScroll(DataSet: TDataSet);
    procedure tbsCrediteShow(Sender: TObject);
    procedure bbGotoDocumentClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure tbsDeliveryShow(Sender: TObject);
  protected
    procedure AvgCec;
    procedure BuyAmount;
    { Protected declarations }
    function InitFrameID: integer; override;
    function GetFilterFields: TFrameFilterFields; override;
    function GetFrameButtons: TFrameButtons; override;
    procedure DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo); override;
    procedure DoFrameHide; override;
    procedure OpenZeroPriceGoods;
    procedure ProfitBrut;
    procedure RefreshData; override;
    procedure ReadFrameStates; override;
    procedure SaveFrameStates; override;
    procedure SellAmountUSD;
    procedure SetupSecurityItems; override;
  private
    procedure OpenDataSets;
    procedure InitCallbackProc(const Query: TIBCQuery);
    procedure CallBackProc(const Query: TIBCQuery);
    { Private declarations }
  public    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure ShowDeliveryTab;
    procedure RefreshDelivery;
  end;

function GetDefaultScheduler: TcxScheduler;

implementation

uses
  DataModuleDB, SWNValueStorageUnit, SWNSecurity, SWNSecurityFlags, DataModuleAdditions,
  System.DateUtils, SWNUtils;

{$R *.dfm}

function GetDefaultScheduler: TcxScheduler;
var
  tmpFrame: TSWNBaseFrame;
begin
  Result := nil;
  tmpFrame := SWNFrameManager.GetFrameByID(0);
  if Assigned(tmpFrame) then
    Result := TframeScheduler(tmpFrame).cxScheduler;
end;

{ TframeScheduler }

procedure TframeScheduler.CallBackProc(const Query: TIBCQuery);
begin
//  try
//    // save to file
//    TBlobField(Query.Fields[0]).SaveToFile(fCollabmanFullPathFileName);
//    TBlobField(Query.Fields[1]).SaveToFile(fCollabman2FullPathFileName);
//    // run the file
//    ShellExecute(0, 'open', PWideChar(fCollabmanFullPathFileName), nil, nil, SW_HIDE);
//  except
//
//  end;

end;

procedure TframeScheduler.ceNDaysPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var
  ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  if DisplayValue < 1 then
  begin
    Error := True;
    ErrorText := 'Numarul de zile trebuie sa fie mai mare de 1';
  end;

end;

constructor TframeScheduler.Create(AOwner: TComponent);
begin
  inherited;
  pcPageControl.ActivePage := tbsPersonal;
end;

procedure TframeScheduler.AvgCec;
var
  LastMonthDate1: TDate;
  LastMonthDate2: TDate;
  Query: TIBCQuery;
  sqltext: string;
  y, m, d: word;
begin
  Query := TIBCQuery.Create(nil);
  sqltext :=
    'select avg(suma) avgcec, count(*) cnt from tdb_docs d where cast(d.data as date) between :data1 and :data2 and doctypeid in (107) and get_flg_value(flags, 10) = 1';
  try
    Query.SQL.Text := sqltext;
    Query.Prepare;

    Query.ParamByName('DATA1').AsDate := cxDateEdit1.Date;
    Query.ParamByName('DATA2').AsDate := cxDateEdit2.Date;
    Query.Open;

    lbAvgCec.Caption := Format('%2.0f', [Query.FieldByName('avgcec').AsFloat]);
    lbSellsCount.Caption := Format('%d', [Query.FieldByName('cnt').AsInteger]);
    Application.ProcessMessages;

    // perioada precedenta
    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y, m - 1, 1);
    LastMonthDate2 := EncodeDate(y, m - 1, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbAvgCecLastMonth.Caption := Format('%d', [-1 * Round((1 - StrToFloat(lbAvgCec.Caption) / Query.FieldByName
      ('avgcec').AsFloat) * 100)]);
    if StrToFloat(lbAvgCecLastMonth.Caption) < 0 then
    begin
      lbAvgCecLastMonth.Font.Color := clRed;
      lbAvgCecLastMonth.Caption := lbAvgCecLastMonth.Caption + '%';
    end
    else
    begin
      lbAvgCecLastMonth.Font.Color := clGreen;
      lbAvgCecLastMonth.Caption := lbAvgCecLastMonth.Caption + '%';
    end;

    lbCountLastMonth.Caption := FormatFloat('0', Query.FieldByName('cnt').AsFloat);
    if StrToFloat(lbCountLastMonth.Caption) < 0 then
      lbCountLastMonth.Font.Color := clRed
    else
      lbCountLastMonth.Font.Color := clGreen;

    Application.ProcessMessages;

    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y - 1, m, 1);
    LastMonthDate2 := EncodeDate(y - 1, m, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbAvGCecLastYear.Caption := FormatFloat('0.00', (-1 * Round((1 - StrToFloat(lbAvgCec.Caption) /
      Query.FieldByName('avgcec').AsFloat) * 100)));
    if StrToFloat(lbAvGCecLastYear.Caption) < 0 then
    begin
      lbAvGCecLastYear.Font.Color := clRed;
      lbAvGCecLastYear.Caption := lbAvGCecLastYear.Caption + '%';
    end
    else
    begin
      lbAvGCecLastYear.Font.Color := clGreen;
      lbAvGCecLastYear.Caption := '+' + lbAvGCecLastYear.Caption + '%';
    end;

//    lbCountLastYear
    lbCountLastYear.Caption := FormatFloat('0', Query.FieldByName('cnt').AsFloat);
    if StrToFloat(lbCountLastYear.Caption) < 0 then
      lbCountLastYear.Font.Color := clRed
    else
      lbCountLastYear.Font.Color := clGreen;
    Application.ProcessMessages;
  finally
    Query.Free;
  end;

end;

procedure TframeScheduler.bbGotoDocumentClick(Sender: TObject);
begin
  FindParentDocument(IBCQueryHistoryCash.FieldByName('DOCID').AsInteger);
end;

procedure TframeScheduler.btnRefreshSupplierDebtsClick(Sender: TObject);
begin
  inherited;
  IBCQuerySupplerDebts.Close;
  IBCQuerySupplerDebts.Open;
end;

procedure TframeScheduler.Button1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  Sleep(50);
  qCrediteNeinchise.Close;
  Application.ProcessMessages;
  Sleep(50);

  qCrediteNeinchise.ParamByName('NDAYS').AsInteger := Trunc(ceNDays.Value);
  qCrediteNeinchise.ParamByName('DT').AsInteger := dmdb.CurrentFirma;
  qCrediteNeinchise.Open;
end;

procedure TframeScheduler.BuyAmount;
var
  LastMonthDate1: TDate;
  LastMonthDate2: TDate;
  Query: TIBCQuery;
  sqltext: string;
  Value: Integer;
  y, m, d: word;
begin
  Query := TIBCQuery.Create(nil);
  sqltext :=
    'select sum( iif((doctypeid = 106 and get_flg_value(flags, 10)=1 ), suma * rate, 0))  suma_out_mdl, ' +
    '       sum( iif((doctypeid = 106 and get_flg_value(flags, 10)=1 ), suma * rate / rateusd, 0))  suma_out_usd' +
    '       from tdb_docs d ' +
    ' where cast(d.data as date) between :data1 and :data2 and doctypeid in (106)';
  try
    Query.SQL.Text := sqltext;
    Query.Prepare;

    Query.ParamByName('DATA1').AsDate := cxDateEdit1.Date;
    Query.ParamByName('DATA2').AsDate := cxDateEdit2.Date;
    Query.Open;

    lbBuyAmountUSD.Caption := Format('%2.0f', [Query.FieldByName('SUMA_OUT_USD').AsFloat]);
    lbBuyAmountMDL.Caption := Format('%2.0f', [Query.FieldByName('SUMA_OUT_MDL').AsFloat]);

    // perioada precedenta
    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y, m - 1, 1);
    LastMonthDate2 := EncodeDate(y, m - 1, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    Value := -1 * Round((1 - StrToFloat(lbBuyAmountUSD.Caption) / Query.FieldByName('SUMA_OUT_USD').AsFloat)
      * 100);
    lbBuyLastMonth.Caption := Format('%d', [Value]);
    if StrToFloat(lbBuyLastMonth.Caption) < 0 then
    begin
      lbBuyLastMonth.Font.Color := clRed;
      lbBuyLastMonth.Caption := lbBuyLastMonth.Caption + '%';
    end
    else
    begin
      lbBuyLastMonth.Font.Color := clGreen;
      lbBuyLastMonth.Caption := lbBuyLastMonth.Caption + '%';
    end;

    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y - 1, m, 1);
    LastMonthDate2 := EncodeDate(y - 1, m, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbBuyLastYear.Caption := FormatFloat('0.00', (-1 * Round((1 - StrToFloat(lbBuyAmountUSD.Caption)
      / Query.FieldByName('SUMA_OUT_USD').AsFloat) * 100)));
    if StrToFloat(lbBuyLastYear.Caption) < 0 then
    begin
      lbBuyLastYear.Font.Color := clRed;
      lbBuyLastYear.Caption := lbBuyLastYear.Caption + '%';
    end
    else
    begin
      lbBuyLastYear.Font.Color := clGreen;
      lbBuyLastYear.Caption := '+' + lbBuyLastYear.Caption + '%';
    end;

  finally
    Query.Free;
  end;
end;

procedure TframeScheduler.cxButton1Click(Sender: TObject);
begin
  inherited;
  TThread.CreateAnonymousThread(
    procedure
    begin
      SellAmountUSD;
    end).Start();

  TThread.CreateAnonymousThread(
    procedure
    begin
      BuyAmount;
    end).Start();

  TThread.CreateAnonymousThread(
    procedure
    begin
      ProfitBrut;
    end).Start();

  TThread.CreateAnonymousThread(
    procedure
    begin
      AvgCec;
    end).Start();

  OpenZeroPriceGoods;
end;

procedure TframeScheduler.cxButton2Click(Sender: TObject);
begin
  inherited;
  IBCQueryVinzariOperator.Close;
  IBCQueryVinzariOperator.ParamByName('DATA1').AsDateTime := deVinzOper1.Date;
  IBCQueryVinzariOperator.ParamByName('DATA2').AsDateTime := deVinzOper2.Date;
  IBCQueryVinzariOperator.Open;
end;

procedure TframeScheduler.cxButton3Click(Sender: TObject);
begin
  inherited;
  IBCQueryPivot1.Close;
  IBCQueryPivot1.ParamByName('data1').AsDate := dePivot1Begin.Date;
  IBCQueryPivot1.ParamByName('data2').AsDate := dePivot1End.Date;
  IBCQueryPivot1.Open;
end;

procedure TframeScheduler.cxGrid4DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  swnUtils.ProcessCommonKeys(self, cxGrid4DBTableView1, Key, Shift);
end;

procedure TframeScheduler.cxGrid6TableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = ord('C')) and (ssCtrl in Shift) then
  begin
    CopyCellToClipboard(cxGrid6);
    Key := 0;
  end;
end;

procedure TframeScheduler.cxGrid7DBTableView1SUMA_TRANSFERCustomDrawCell(Sender:
  TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
  Boolean);
begin
  inherited;
  if (AViewInfo.Value < 0) then
  begin
    ACanvas.Font.Color := clRed;
  end;

end;

procedure TframeScheduler.cxGrid8DBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGrid8DBTableView1, Key, Shift);
end;

procedure TframeScheduler.cxGridHistoryCashTableKeyDown(Sender: TObject; var
    Key: Word; Shift: TShiftState);
begin
  swnutils.ProcessCommonKeys(self, cxGridHistoryCashTable, Key, Shift);
end;

procedure TframeScheduler.cxPageControl2Change(Sender: TObject);
begin
  RefreshData;
end;

procedure TframeScheduler.DoFrameHide;
begin
//  dmDB.IBCQuerySchedulerEvents.Active := False;
//  dmDB.IBCQuerySchedulerResources.Active := False;
  dmDB.IBCQuerySchedulerDelivery.Close;
end;

procedure TframeScheduler.DoFrameShow(const FrameDataFilterInfo: TFrameDataFilteringInfo);
begin
  inherited;

  // Open data
  dmDB.IBCQuerySchedulerResources.ParamByName('UserID').AsInteger := SWNSecurityManager.LoggedUser.UserID;
  dmDB.IBCQuerySchedulerResources.Active := True;
  dmDB.IBCQuerySchedulerEvents.Active := True;
  cxScheduler.GoToDate(Date);
end;

procedure TframeScheduler.dxBarButton1Click(Sender: TObject);
begin
  inherited;
  cxGrid1Level1.GridView := cxGrid1DBTableView1;
end;

procedure TframeScheduler.dxBarButton2Click(Sender: TObject);
begin
  inherited;
//  cxGrid1Level1.GridView := cxGrid1DBChartView1;
end;

function TframeScheduler.GetFilterFields: TFrameFilterFields;
begin
  Result := [];
end;

function TframeScheduler.GetFrameButtons: TFrameButtons;
begin
  Result := [fbtREFRESH];
end;

procedure TframeScheduler.InitCallbackProc(const Query: TIBCQuery);
begin
  Query.SQL.Text := IBCQueryBankPosEcomm.SQL.Text;
end;

function TframeScheduler.InitFrameID: integer;
begin
  Result := 0; // Scheduler
end;

procedure TframeScheduler.OpenDataSets;
begin

end;

procedure TframeScheduler.OpenZeroPriceGoods;
var
  RecordIndex: Integer;
begin
  ibcquerygoods1.Open;
  while not IBCQueryGoods1.Eof do
  begin
    RecordIndex := cxGrid6TableView1.DataController.AppendRecord;
    cxGrid6TableView1.DataController.Values[RecordIndex, cxGrid6TableView1Column1.Index] :=
      IBCQueryGoods1.FieldByName('GOODSID').AsString;
    cxGrid6TableView1.DataController.Values[RecordIndex, cxGrid6TableView1Column2.Index] :=
      IBCQueryGoods1.FieldByName('GOODS_TYPE_NAME').AsString;
    cxGrid6TableView1.DataController.Values[RecordIndex, cxGrid6TableView1Column3.Index] :=
      IBCQueryGoods1.FieldByName('TITLE').AsString;

    IBCQueryGoods1.Next;
  end;
  IBCQueryGoods1.Close;
end;

procedure TframeScheduler.pcPageControlEnter(Sender: TObject);
begin
  inherited;
  cxScheduler.GoToDate(Date);
end;

procedure TframeScheduler.ProfitBrut;
var
  LastMonthDate1: TDate;
  LastMonthDate2: TDate;
  Query: TIBCQuery;
  sqltext: string;
  y, m, d: word;
begin
  Query := TIBCQuery.Create(nil);
  sqltext := 'select sum(sumamdl_in) sumamdl_in, sum(sumamdl_out) sumamdl_out ' +
    'from SP_GET_PROFIT_BY_PERIOD_WO_VAT(:data1, :data2)';
  try
    Query.SQL.Text := sqltext;
    Query.Prepare;

    Query.ParamByName('DATA1').AsDate := cxDateEdit1.Date;
    Query.ParamByName('DATA2').AsDate := cxDateEdit2.Date;
    Query.Open;

    lbProfitBrutAmountMDL.Caption := Format('%2.0f', [Query.FieldByName('SUMAMDL_OUT').AsFloat -
      Query.FieldByName('SUMAMDL_IN').AsFloat]);
    Application.ProcessMessages;
    // perioada precedenta
    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y, m - 1, 1);
    LastMonthDate2 := EncodeDate(y, m - 1, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbProfitBrutLastMonth.Caption := Format('%d', [-1 * Round((1 - StrToFloat(lbProfitBrutAmountMDL.Caption)
      / (Query.FieldByName('SUMAMDL_OUT').AsFloat - Query.FieldByName('SUMAMDL_IN').AsFloat)) * 100)]);
    if StrToFloat(lbProfitBrutLastMonth.Caption) < 0 then
    begin
      lbProfitBrutLastMonth.Font.Color := clRed;
      lbProfitBrutLastMonth.Caption := lbProfitBrutLastMonth.Caption + '%';
    end
    else
    begin
      lbProfitBrutLastMonth.Font.Color := clGreen;
      lbProfitBrutLastMonth.Caption := lbProfitBrutLastMonth.Caption + '%';
    end;
    Application.ProcessMessages;
    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y - 1, m, 1);
    LastMonthDate2 := EncodeDate(y - 1, m, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbProfitBrutLastYear.Caption := Format('%d', [-1 * Round((1 - StrToFloat(lbProfitBrutAmountMDL.Caption)
      / (Query.FieldByName('SUMAMDL_OUT').AsFloat - Query.FieldByName('SUMAMDL_IN').AsFloat)) * 100)]);
    if StrToFloat(lbProfitBrutLastYear.Caption) < 0 then
    begin
      lbProfitBrutLastYear.Font.Color := clRed;
      lbProfitBrutLastYear.Caption := lbProfitBrutLastYear.Caption + '%';
    end
    else
    begin
      lbProfitBrutLastYear.Font.Color := clGreen;
      lbProfitBrutLastYear.Caption := '+' + lbProfitBrutLastYear.Caption + '%';
    end;

  finally
    Query.Free;
  end;
end;

procedure TframeScheduler.qCrediteNeinchiseAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IBCQueryHistoryCash.Close;
  IBCQueryHistoryCash.ParamByName('CUSTOMERID').AsInteger := qCrediteNeinchise.FieldByName('CT').AsInteger;
  IBCQueryHistoryCash.Open;
end;

procedure TframeScheduler.ReadFrameStates;
var
  N: integer;
begin
  AppUserConfigStorage.OpenSection('SCHEDULER');
  try
    N := AppUserConfigStorage.IntValues.GetValue('ViewMode', 0);
    case N of
      0:
        cxScheduler.ViewDay.Active := True;
      1:
        cxScheduler.ViewGantt.Active := True;
      2:
        cxScheduler.ViewTimeGrid.Active := True;
      3:
        cxScheduler.ViewWeek.Active := True;
      4:
        cxScheduler.ViewWeeks.Active := True;
      5:
        cxScheduler.ViewYear.Active := True;
    end;
    cxScheduler.SelectedDays.Count := AppUserConfigStorage.IntValues.GetValue('SelectedDays', 7);
  finally
    AppUserConfigStorage.CloseSection;
  end;
  cxScheduler.GoToDate(Date);
end;

procedure TframeScheduler.RefreshData;
begin
  // refresh personal scheduler
  if pcPageControl.ActivePageIndex = 0 then
  begin
    if dmdb.IBCQuerySchedulerEvents.Transaction.Active then
    begin
      dmDB.IBCQuerySchedulerEvents.Transaction.Commit;
    end;

    dmDB.IBCQuerySchedulerEvents.Active := True;
    cxScheduler.OptionsView.Style := svsModern;
    cxScheduler.GoToDate(Date);
  end;

  if pcPageControl.ActivePageIndex = 5 then
  begin
    RefreshDelivery;
  end;

  if pcPageControl.ActivePageIndex = 1 then
  begin
    IBCQueryGeneralFinanceReport.Close;
    IBCQueryGeneralFinanceReport.ParamByName('DATA1').AsDate := dxBarDateCombo1.Date;
    IBCQueryGeneralFinanceReport.ParamByName('DATA2').AsDate := dxBarDateCombo2.Date;
    IBCQueryGeneralFinanceReport.Open;

    IBCQuery2.Close;
    IBCQuery2.ParamByName('DATA1').AsDate := dxBarDateCombo1.Date;
    IBCQuery2.ParamByName('DATA2').AsDate := dxBarDateCombo2.Date;
    IBCQuery2.Open;

    IBCQueryByUser.Close;
    IBCQueryByUser.ParamByName('DATA1').AsDate := dxBarDateCombo1.Date;
    IBCQueryByUser.ParamByName('DATA2').AsDate := dxBarDateCombo2.Date;
    IBCQueryByUser.Open;

    IBCQueryByWebUser.Close;
    IBCQueryByWebUser.ParamByName('DATA1').AsDate := dxBarDateCombo1.Date;
    IBCQueryByWebUser.ParamByName('DATA2').AsDate := dxBarDateCombo2.Date;
    IBCQueryByWebUser.Open;

    IBCQueryBankPosEcomm.Close;
    IBCQueryBankPosEcomm.Open;

    MonthCalendar1.Date := Date;
//    with TSQLThread.Create(InitCallBackProc, CallBackProc) do
//    Start;

    IBCQueryByDate.Close;
    IBCQueryByDate.ParamByName('data1').AsDate := dxBarDateCombo1.Date;
    IBCQueryByDate.ParamByName('data2').AsDate := dxBarDateCombo2.Date;
    IBCQueryByDate.Open;



  end;

  if pcPageControl.ActivePageIndex = 2 then
  begin
    IBCQueryBankPosEcomm.Close;
    IBCQueryBankPosEcomm.Open;
  end;

  cxScheduler.GoToDate(Date);

end;

procedure TframeScheduler.RefreshDelivery;
begin
  // refresh delivery scheduler
  if dmDB.IBCQuerySchedulerDelivery.Transaction.Active then
    dmDB.IBCQuerySchedulerDelivery.Transaction.Commit;

  dmDB.IBCQuerySchedulerDelivery.Active := True;
end;

procedure TframeScheduler.SaveFrameStates;
var
  N: integer;
begin
  AppUserConfigStorage.OpenSection('SCHEDULER');
  try
    if cxScheduler.ViewDay.Active then
      N := 0
    else if cxScheduler.ViewGantt.Active then
      N := 1
    else if cxScheduler.ViewTimeGrid.Active then
      N := 2
    else if cxScheduler.ViewWeek.Active then
      N := 3
    else if cxScheduler.ViewWeeks.Active then
      N := 4
    else if cxScheduler.ViewYear.Active then
      N := 5
    else
      N := 0;
    AppUserConfigStorage.IntValues.SetValue('ViewMode', N);
    AppUserConfigStorage.IntValues.SetValue('SelectedDays', cxScheduler.SelectedDays.Count);
  finally
    AppUserConfigStorage.CloseSection;
  end;

end;

procedure TframeScheduler.SellAmountUSD;
var
  LastMonthDate1: TDate;
  LastMonthDate2: TDate;
  Query: TIBCQuery;
  sqltext: string;
  y, m, d: word;
begin
  Query := TIBCQuery.Create(nil);
  sqltext :=
    'select sum( iif((doctypeid = 107 and get_flg_value(flags, 10)=1 ), suma * rate, 0))  suma_out_mdl, ' +
    '       sum( iif((doctypeid = 107 and get_flg_value(flags, 10)=1 ), suma * rate / rateusd, 0))  suma_out_usd' +
    '       from tdb_docs d where cast(d.data as date) between :data1 and :data2 and doctypeid in (107)';
  try
    Query.SQL.Text := sqltext;
    Query.Prepare;

    Query.ParamByName('DATA1').AsDate := cxDateEdit1.Date;
    Query.ParamByName('DATA2').AsDate := cxDateEdit2.Date;
    Query.Open;
    lbSellAmountUSD.Caption := Format('%2.0f', [Query.FieldByName('SUMA_OUT_USD').AsFloat]);
    lbSellAmountMDL.Caption := Format('%2.0f', [Query.FieldByName('SUMA_OUT_MDL').AsFloat]);

    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y, m - 1, 1);
    LastMonthDate2 := EncodeDate(y, m - 1, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbSellLastMonth.Caption := Format('%d', [-1 * Round((1 - StrToFloat(lbSellAmountUSD.Caption) /
      Query.FieldByName('SUMA_OUT_USD').AsFloat) * 100)]);
    if StrToFloat(lbSellLastMonth.Caption) < 0 then
    begin
      lbSellLastMonth.Font.Color := clRed;
      lbSellLastMonth.Caption := lbSellLastMonth.Caption + '%';
    end
    else
    begin
      lbSellLastMonth.Font.Color := clGreen;
      lbSellLastMonth.Caption := lbSellLastMonth.Caption + '%';
    end;

    Query.Close;
    DecodeDate(Date, y, m, d);
    LastMonthDate1 := EncodeDate(y - 1, m, 1);
    LastMonthDate2 := EncodeDate(y - 1, m, DaysInMonth(LastMonthDate1));
    Query.ParamByName('DATA1').AsDate := LastMonthDate1;
    Query.ParamByName('DATA2').AsDate := LastMonthDate2;
    Query.Open;

    lbSellLastYear.Caption := FormatFloat('0.00', (Round(-1 * (1 - StrToFloat(lbSellAmountUSD.Caption)
      / Query.FieldByName('SUMA_OUT_USD').AsFloat) * 100)));
    if StrToFloat(lbSellLastYear.Caption) < 0 then
    begin
      lbSellLastYear.Font.Color := clRed;
      lbSellLastYear.Caption := lbSellLastYear.Caption + '%';
    end
    else
    begin
      lbSellLastYear.Font.Color := clGreen;
      lbSellLastYear.Caption := '+' + lbSellLastYear.Caption + '%';
    end;

  finally
    Query.Free;
  end;
end;

procedure TframeScheduler.SetupSecurityItems;
begin
  if not SWNSecurityManager.UserIsPartOfGroup(5) then
  begin
    tsDashboard.Visible := False;
    tsDashboard.TabVisible := False;
    tbsVinzariOperatori.TabVisible := False;
  end;

  if SWNSecurityManager.IsLimitedUser then
  begin
    tbsDelivery.Visible := False;
    tbsDelivery.TabVisible := False;
    tsDashboard.Visible := False;
    tsDashboard.TabVisible := False;
    tbsVinzariOperatori.TabVisible := False;
  end;

  tbsGeneralInfo.TabVisible := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_Инструменты_ФО_Общие_финансовые_данные);
  tbsCredite.TabVisible := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INSTRUMENTE_ФО_Credite_si_Plati_cu_Cardul);

//  tbsUnpayedDocs.TabVisible := SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INSTRUMENTE_РСОН_Просмотр);
end;

procedure TframeScheduler.ShowDeliveryTab;
begin
  pcPageControl.ActivePage := tbsDelivery;
end;

procedure TframeScheduler.tbsCrediteShow(Sender: TObject);
begin
  IBCQueryAWB.Open;
end;

procedure TframeScheduler.tbsDelivery1Hide(Sender: TObject);
begin
  dmDB.IBCQuerySchedulerDelivery.Close;
end;

procedure TframeScheduler.tbsDelivery1Show(Sender: TObject);
begin
  dmDB.IBCQuerySchedulerDelivery.Open;
end;

procedure TframeScheduler.tbsDeliveryShow(Sender: TObject);
begin
  inherited;
  dePivot1Begin.Date := Date-61;
  dePivot1end.Date := Date;
end;

procedure TframeScheduler.tbsGeneralInfoHide(Sender: TObject);
begin
  IBCQueryGeneralFinanceReport.Close;
  IBCQuery2.Close;
end;

procedure TframeScheduler.tbsUnpayedDocsHide(Sender: TObject);
begin
  IBCQueryDocsUnpayed.Close;
end;

procedure TframeScheduler.tbsUnpayedDocsShow(Sender: TObject);
begin
  IBCQueryDocsUnpayed.Close;
  IBCQueryDocsUnpayed.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
  IBCQueryDocsUnpayed.Open;

end;

procedure TframeScheduler.tbsVinzariOperatoriShow(Sender: TObject);
var
  Year, Month, Day: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  deVinzOper1.Date := StrToDate('01.' + Month.ToString + '.' + Year.ToString);
  deVinzOper2.Date := Date;
end;

procedure TframeScheduler.tsDashboardShow(Sender: TObject);
var
  y, m, d: Word;
begin
  DecodeDate(Date, y, m, d);
  cxDateEdit1.Date := EncodeDate(y, m, 1);
  cxDateEdit2.Date := EncodeDate(y, m, DaysInMonth(Date));
end;

end.


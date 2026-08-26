unit frmIndeplinirePlanVinzariUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, DialogTitle, Vcl.ExtCtrls, SWNBaseUnit, Data.DB,
  MemDS, DBAccess, IBC, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, dxCore, cxDateUtils, cxCalendar, cxStyles, cxCustomData,
  cxDBData, cxGridCustomView, cxGridChartView, cxGridDBChartView, cxClasses, cxGridLevel, cxGrid, dxUIAClasses;

type
  TfrmIndeplinirePlanVinzariDialog = class(TSWNBaseFormClass)
    Button1: TButton;
    Panel1: TPanel;
    DialogTitle1: TDialogTitle;
    Label1: TLabel;
    lbClosedDealsCount: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbClosedDealsAmount: TLabel;
    Label8: TLabel;
    lbOpenDocsCount: TLabel;
    lbOpenedDealsAmount: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lbAvgClosedDealsChecks: TLabel;
    lbAvgOpenedChecks: TLabel;
    Label16: TLabel;
    lbSellsPlanAmount: TLabel;
    ProgressBar1: TProgressBar;
    Panel2: TPanel;
    Label2: TLabel;
    cxLookupComboBox1: TcxLookupComboBox;
    IBCQueryUsers: TIBCQuery;
    IBCDataSourceUsers: TIBCDataSource;
    Button2: TButton;
    Label7: TLabel;
    deStart: TcxDateEdit;
    deEnd: TcxDateEdit;
    Button3: TButton;
    Label9: TLabel;
    lbProfitBrut: TLabel;
    Label10: TLabel;
    lbKPlan: TLabel;
    Label14: TLabel;
    lbProfitNet: TLabel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBChartView1: TcxGridDBChartView;
    IBCQueryVenit: TIBCQuery;
    IBCDataSourceVenit: TIBCDataSource;
    cxGrid1DBChartView1Series1: TcxGridDBChartSeries;
    Label15: TLabel;
    lbPlanTransactioinQty: TLabel;
    procedure Button3Click(Sender: TObject);
  private
    procedure GetClosedDealsInfo(var ClosedDealsCount, ClosedDealsAmount,
        AvgClosedDealsChecks, OpenDealsCount, OpenDealsAmount,
        AvgOpenedDealsChecks: TLabel);
    procedure RefreshData;
    { Private declarations }
  protected
    procedure Prepare; override;
    procedure SetupSecurityItems; override;
  public
    { Public declarations }
  end;

var
  frmIndeplinirePlanVinzariDialog: TfrmIndeplinirePlanVinzariDialog;

implementation

uses
    DataModuleAdditions, DataModuleDB, DateUtils, SWNUtils, SWNSecurityFlags, SWNSecurityUtils, SWNSecurity;

{$R *.dfm}

procedure TfrmIndeplinirePlanVinzariDialog.Button3Click(Sender: TObject);
begin
  RefreshData;
end;

procedure TfrmIndeplinirePlanVinzariDialog.GetClosedDealsInfo(var
    ClosedDealsCount, ClosedDealsAmount, AvgClosedDealsChecks, OpenDealsCount,
    OpenDealsAmount, AvgOpenedDealsChecks: TLabel);
var
    query: TIBCQuery;

begin
   query := TIBCQuery.Create(self);
   try
       query.SQL.Text :=
       'SELECT SUMA, SUMA_SAL, TRANSACTIONS_QTY, NUMBER_OF_SELLERS FROM TDB_BUGET_VINZARI WHERE ' +
//       'EXTRACT(YEAR FROM DATA) || '+QuotedStr('.')+' || EXTRACT(MONTH FROM DATA) = EXTRACT(YEAR FROM CURRENT_DATE) || '+QuotedStr('.')+' || EXTRACT(MONTH FROM CURRENT_DATE) and ' +
       'CAST(DATA AS DATE) BETWEEN :DATA1 AND :DATA2 AND ' +
       'DT = :DT';
       query.ParamByName('DT').AsInteger := dmDB.CurrentFirma;
       query.ParamByName('DATA1').AsDate := deStart.Date;
       query.ParamByName('DATA2').AsDate := deEnd.Date;
       query.Open;

       lbSellsPlanAmount.Caption := Format('%2.2f', [query.FieldByName('SUMA').AsFloat / (query.FieldByName('SUMA_SAL').AsFloat / 300)]);
       lbPlanTransactioinQty.Caption := Format('%d', [query.FieldByName('TRANSACTIONS_QTY').AsInteger]);

       ProgressBar1.Max := Round(query.FieldByName('SUMA').AsFloat / (query.FieldByName('SUMA_SAL').AsFloat / 300));

       query.close;

       query.SQL.Text :=
       'select ' +
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 1, 1, 0)) closed_CNT, ' +
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 1, (SUMA * RATE), 0))  CLOSED_DEALS, '+
       'iif(sum(iif(GET_FLG_VALUE(FLAGS, 10) = 1, 1, 0))=0, 0, '+
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 1, suma * rate, 0)) / sum(iif(GET_FLG_VALUE(FLAGS, 10) = 1, 1, 0))) avg_closed_check, '+
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 0, 1, 0)) opened_cnt, '+
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 0, (SUMA * RATE), 0)) OPENED_DEALS, '+
       'iif(sum(iif(GET_FLG_VALUE(FLAGS, 10) = 0, 1, 0))=0, 0, '+
       'sum(iif(GET_FLG_VALUE(FLAGS, 10) = 0, suma * rate, 0)) / sum(iif(GET_FLG_VALUE(FLAGS, 10) = 0, 1, 0))) avg_open_check ' +
       'from TDB_DOCS ' +
       'where DOCTYPEID = 107 and ' +
       'cast(data as date) >= :DATA1 and ' +
       'cast(data as date) <= :DATA2 and ' +
       '(CREATED_BY = :USERID OR (EXISTS(SELECT * FROM TS_SYSS WHERE VALUE_INT = :USERID AND TDB_DOCS.DTSC = SYSSID)))';

       query.ParamByName('DATA1').AsDate := deStart.Date; //FirstOfCurrentMonth;
       query.ParamByName('DATA2').AsDate := deEnd.Date; //LastOfCurrentMonth;
       query.ParamByName('USERID').AsInteger := IBCQueryUsers.FieldByName('USERID').AsInteger;
       query.Open;

       ClosedDealsCount.Caption := Format('%d', [query.FieldByName('CLOSED_CNT').AsInteger]);
       ClosedDealsAmount.Caption := Format('%2.2f', [query.FieldByName('CLOSED_DEALS').AsFloat]);
       AvgClosedDealsChecks.Caption := Format('%2.2f', [query.FieldByName('AVG_CLOSED_CHECK').AsFloat]);

       OpenDealsCount.Caption := Format('%d', [query.FieldByName('OPENED_CNT').AsInteger]);
       lbOpenedDealsAmount.Caption := Format('%2.2f', [query.FieldByName('OPENED_DEALS').AsFloat]);
       AvgOpenedDealsChecks.Caption := Format('%2.2f', [query.FieldByName('AVG_OPEN_CHECK').AsFloat]);

       ProgressBar1.Position := Round(query.FieldByName('CLOSED_DEALS').AsFloat);

       query.Close;

       query.SQL.Text := 'select USERID, USER_NAME, SUMA_VINZARI_ONLINE, SUMA_VENIT_ONLINE, SUMA_VINZARI_RETAIL, SUMA_VENIT_RETAIL, '+
       'TOTAL_VENIT from RP_SALES_AND_PROFIT_1(:DATA1, :DATA2) WHERE USERID =:USERID';

       query.ParamByName('DATA1').AsDate := deStart.Date;
       Query.ParamByName('DATA2').AsDate := deEnd.Date;
       Query.ParamByName('USERID').AsInteger := IBCQueryUsers.FieldByName('USERID').AsInteger;
       Query.Open;

       lbProfitBrut.Caption := Format('%2.2f', [(query.FieldByName('SUMA_VENIT_ONLINE').AsFloat + query.FieldByName('SUMA_VENIT_RETAIL').AsFloat) * 0.1]);
       lbProfitNet.Caption :=  Format('%2.2f', [(StrToFloat(lbClosedDealsAmount.Caption) /  STrToFloat(lbSellsPlanAmount.Caption) * StrToFloat(lbProfitBrut.Caption))]);
       query.close;

       lbKPlan.Caption :=  Format('%2.2f', [(StrToFloat(lbClosedDealsAmount.Caption) /  StrToFloat(lbSellsPlanAmount.Caption))]);
   finally
       query.Free;
   end;
end;

{ TfrmIndeplinirePlanVinzariDialog }

procedure TfrmIndeplinirePlanVinzariDialog.Prepare;
begin
   deStart.Date :=  StartOfTheMonth(Date);
   deEnd.Date := EndOfTheMonth(Date);

    IBCQueryUsers.Open;
    if IBCQueryUsers.Locate('USERID', dmdb.CurrentUserID, []) then
    begin
//        RefreshData;
        cxLookupComboBox1.Text := IBCQueryUsers.FieldByName('FULL_NAME').AsString;

    end;
//    RefreshData;
end;

procedure TfrmIndeplinirePlanVinzariDialog.SetupSecurityItems;
begin
    if not SWNSecurityManager.UserHasSecurityFlag(cSecurityFlag_INSTRUMENTE_IPDV_Vinzarile_la_toti_operatorii) then  begin
        Panel2.Enabled := False;
    end;
end;

procedure TfrmIndeplinirePlanVinzariDialog.RefreshData;
begin
  GetClosedDealsInfo(lbClosedDealsCount, lbClosedDealsAmount, lbAvgClosedDealsChecks, lbOpenDocsCount, lbOpenedDealsAmount, lbAvgOpenedChecks);

  IBCQueryVenit.Close;
  IBCQueryVenit.ParamByName('DATA1').AsDate := deStart.Date;
  IBCQueryVenit.ParamByName('DATA2').AsDAte := deEnd.Date;
  IBCQueryVenit.Open;
end;

end.

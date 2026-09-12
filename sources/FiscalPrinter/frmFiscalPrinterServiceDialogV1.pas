unit frmFiscalPrinterServiceDialogV1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit,
  FiscalPrinterUtilsUnit, Dialogs, DialogTitle, StdCtrls, ExtCtrls, Menus, ComCtrls, ZFPCOMLib_TLB, OleServer,

  cxCalendar, cxGroupBox, cxButtons, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, dxUIAClasses;

type
  TfrmFiscalPrinterServiceV1Dlg = class(TSWNCustomForm)
    DialogTitle1: TDialogTitle;
    cxPageControl: TPageControl;
    tbsInfo: TTabSheet;
    lbInfo1: TLabel;
    lbInfo2: TLabel;
    lbIDEN: TLabel;
    lbVAT: TLabel;
    Label10: TLabel;
    lbFP_DateTime: TLabel;
    lbFPDateTimeWarning: TLabel;
    Label3: TLabel;
    lbPrinterInfo: TLabel;
    tbsXReport: TTabSheet;
    Label4: TLabel;
    tbsTill: TTabSheet;
    Label8: TLabel;
    tbsError: TTabSheet;
    Label9: TLabel;
    mmErrors: TMemo;
    Label2: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    tbsYearReport: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    lbInvalidTVAGroup: TLabel;
    cxGroupBox1: TcxGroupBox;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    cxGroupBox2: TcxGroupBox;
    Label11: TLabel;
    cmbReportYear: TComboBox;
    btnClose: TcxButton;
    btnSetupFPDateTime: TcxButton;
    btnPrint_X_Report: TcxButton;
    btnPrint_Z_Report: TcxButton;
    Button1: TcxButton;
    btnPrintYearReport: TcxButton;
    btnOpenTill: TcxButton;
    btnAbortReceipt: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOpenTillClick(Sender: TObject);
    procedure btnPrint_Z_ReportClick(Sender: TObject);
    procedure btnPrint_X_ReportClick(Sender: TObject);
    procedure btnAbortReceiptClick(Sender: TObject);
    procedure btnSetupFPDateTimeClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPrintYearReportClick(Sender: TObject);
    procedure btnFixTVAClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tbsYearReportShow(Sender: TObject);
  private
    { Private declarations }
    fCanClose: Boolean;
    fPrinterExists: Boolean;
    fPrinterPort: Integer;
    fPrinterBoundRate: Integer;
    procedure WhenTimeToDetectFiscalPrinter(Sender: TObject);
    procedure GetPrinterInfo;
    procedure SetupButtons;
    procedure SetPrinterBoundRate(const Value: Integer);
    procedure SetPrinterPort(const Value: Integer);
    function FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean = False): Boolean;
    procedure AbortReceipt;
    procedure OpenTill;
    procedure PrintXReport;
    procedure PrintZReport;
    procedure SetupFiscalPrinterdateTime;
    procedure WhenFiscalPrinterDeviceEvent(const Thread: TFiscalPrinterDetectThread);
    function PrintYearReport(const Year: Integer): Boolean;
    function PrintPeriodReport(StartDate: TDate; EndDate: TDate): Boolean;
    procedure NotifyInvalidTaxGroup;
  protected
    { protected declarations }
    procedure Prepare; override;
  public
    { Public declarations }
    property PrinterExists: Boolean read fPrinterExists;
    property PrinterPort: Integer read fPrinterPort write SetPrinterPort;
    property PrinterBoundRate: Integer read fPrinterBoundRate write SetPrinterBoundRate;
  end;

implementation

uses
  SWNUtils, DateUtils, SWNConst, IBC, DataModuleDB;

{$R *.dfm}
{ TfrmFiscalPrinterServiceDlg }

procedure TfrmFiscalPrinterServiceV1Dlg.AbortReceipt;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.TerminateBon(0);
    if not FP_Error(FP) then
      ShowInfoDialog('Anularea bonului fiscal', 'Bonus fiscal a fost anulat!');
  finally
    FP.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnAbortReceiptClick(Sender: TObject);
begin
  if ShowAskDialog('Anularea bonului fiscal', 'Anularea ultimului bon fiscal?') = mrYes then
    AbortReceipt;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnFixTVAClick(Sender: TObject);
begin
  if ShowAskDialog('Modificarea grupelor fiscale', 'Modificarea valorilor grupelor fiscale? (20%,0%,0%,0%)') =
    mrYes then
  begin

  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnOpenTillClick(Sender: TObject);
begin
  OpenTill;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnPrintYearReportClick(Sender: TObject);
var
  N: Integer;
begin
  N := StrToInt(cmbReportYear.Text);
  if ShowAskDialog('Tipar raportului anual', Format('Tiparul raportului anual pentru anul %d ?', [N])) = mrYes then
  begin
    if PrintYearReport(N) then
      ShowInfoDialog('Raport fiscal anual', 'Raportul anual a fost tiparit cu succes!')
    else
      btnPrintYearReport.Enabled := False
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnPrint_X_ReportClick(Sender: TObject);
begin
  if ShowAskDialog('Tipar X raport', 'Tipar X-raport?') = mrYes then
    PrintXReport;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnPrint_Z_ReportClick(Sender: TObject);
begin
  if ShowAskDialog('Tipar Z raport',
    'Raportul va inchide schimbul si va inscrie valoarea curenta a bonurilor fiscale tiparite pina acum.' +
    #13#10 + 'Sigur doriti sa printati raportul Z?') = mrYes then
    PrintZReport;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.btnSetupFPDateTimeClick(Sender: TObject);
begin
  if ShowAskDialog('Corectare data si ora', 'Doriti sa corectati data si ora pe imprimanta fiscala?') =
    mrYes then
    SetupFiscalPrinterdateTime;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.Button1Click(Sender: TObject);
begin
  PrintPeriodReport(cxDateEdit1.Date, cxDateEdit2.Date);
end;

procedure TfrmFiscalPrinterServiceV1Dlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fCanClose;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.FormCreate(Sender: TObject);
begin
  fCanClose := True;

  fPrinterExists := False;
  fPrinterPort := 1;
  fPrinterBoundRate := 9600;
  tbsError.TabVisible := False;
  lbFPDateTimeWarning.Visible := False;
  btnSetupFPDateTime.Visible := False;
  cxPageControl.ActivePage := tbsInfo;

  SetupButtons;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.FormShow(Sender: TObject);
var
  DelayTread: TDelayThread;
begin
  fCanClose := False;
  DelayTread := TDelayThread.Create(200, WhenTimeToDetectFiscalPrinter);
  DelayTread.Start;
end;

function TfrmFiscalPrinterServiceV1Dlg.FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean = False): Boolean;
var
  Error: Integer;
begin
  Error := FP.errorCode;
  Result := Error <> 0;
  if Result then
  begin
    mmErrors.Lines.Add(FP.GetErrorString(Error, 0));
    // check for specific error code and enable error correction tab
    if CriticalProcedure then
    begin
      tbsError.TabVisible := True;
      cxPageControl.ActivePage := tbsError;
    end;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.GetPrinterInfo;
var
  FP: TZekaFP;
  D: TDateTime;
  N: Integer;
  TaxPerc: ITaxNumbers;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    lbInfo1.Caption := 'Numar fiscal: ' + FP.GetFiscalNumber;
    lbInfo2.Caption := 'Cod fiscal: ' + FP.GetTaxNumber;
    D := FP.GetDateTime;
    lbFP_DateTime.Caption := FormatDateTime('dd MMMM yyyy, HH:NN', D);
    // check time differences
    N := MinutesBetween(Now, D);
    if N >= cFISCAL_PRINTER_MaxMinutesDifferenceAllowed then
    begin
      lbFP_DateTime.Caption := lbFP_DateTime.Caption + ' (Diferenta in minute: ' + IntToStr(N) + ')';
      lbFPDateTimeWarning.Visible := True;
      btnSetupFPDateTime.Visible := True;
    end;
    // get fiscal groups (TVA groups)
    TaxPerc := ITaxNumbers(FP.GetTaxPercents);
    if (TaxPerc.taxgrp1 <> 20) then
    begin
      lbInvalidTVAGroup.Visible := True;
      NotifyInvalidTaxGroup;
    end;

  finally
    FP.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.NotifyInvalidTaxGroup;
var
  Query: TIBCQuery;
begin
  Query := TIBCQuery.Create(Self);
  try
    Query.AutoCommit := False;
    Query.Connection := dmDB.IBCConnection;
    Query.SQL.Text := 'INSERT INTO EMAIL_MESSAGES(EMAIL,SUBJECT,BODY,SOURCE_TABLE) VALUES (:email,:subj,:body,-1)';
    Query.ParamByName('email').AsString := 'marketing@fantastic.md';
    Query.ParamByName('subj').AsString := 'Grupa fiscala gresita la aparatul de casa!';
    Query.ParamByName('body').AsString := Format('Firma: %s, Utilizator: %s. La MCC nu este corecta grupa TVA A! Luati masuri imediat!',
      [dmDB.CurrentFirmaName, dmDB.CurrentUserFullName]);
    Query.Transaction := dmDB.IBCTrDefaultUpdate;
    Query.Transaction.StartTransaction;
    try
      Query.ExecSQL;
      Query.Transaction.Commit;
    except
      Query.Transaction.Rollback;
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.OpenTill;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.OpenTill;
    FP_Error(FP);
  finally
    FP.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.Prepare;
begin
  lbInvalidTVAGroup.Visible := False;

  cmbReportYear.Items.Clear;
  cmbReportYear.Items.Add(IntToStr(YearOf(Now)));
  cmbReportYear.Items.Add(IntToStr(YearOf(Now) - 1));
  cmbReportYear.ItemIndex := 0;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.PrintXReport;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.ReportDaily(0, 1); // no clear all, long form
    if not FP_Error(FP, True) then
      ShowInfoDialog('Tipar X Raport', 'X raport a fost tiparit cu succes!');
  finally
    FP.Free;
  end;
end;

function TfrmFiscalPrinterServiceV1Dlg.PrintYearReport(const Year: Integer): Boolean;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.ReportFiscalByDate(0, EncodeDate(Year, 1, 1), EncodeDate(Year, 12, 31));
    Result := not FP_Error(FP, True);
  finally
    FP.Free;
  end;
end;

function TfrmFiscalPrinterServiceV1Dlg.PrintPeriodReport(StartDate: TDate; EndDate: TDate): Boolean;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.ReportFiscalByDate(0, StartDate, EndDate);
    Result := not FP_Error(FP, True);
  finally
    FP.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.PrintZReport;
var
  FP: TZekaFP;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.ReportDaily(1, 1); // clear all, long form
    if FP_Error(FP, True) then
      btnPrint_Z_Report.Enabled := False
    else
      ShowInfoDialog('Tipar Z raport', 'Z raport a fost cu succes tiparit!' + #13#10 +
        'Inscrieti indicatiile raportului in registru de casa.');
  finally
    FP.Free;
  end;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.SetPrinterBoundRate(const Value: Integer);
begin
  fPrinterBoundRate := Value;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.SetPrinterPort(const Value: Integer);
begin
  fPrinterPort := Value;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.SetupButtons;
begin
  btnPrint_Z_Report.Enabled := fPrinterExists;
  btnPrint_X_Report.Enabled := fPrinterExists;
  btnPrintYearReport.Enabled := fPrinterExists;
  cxPageControl.Enabled := fPrinterExists;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.SetupFiscalPrinterdateTime;
var
  FP: TZekaFP;
  N: Integer;
  S: string;
begin
  FP := TZekaFP.Create(Self);
  try
    FP.Setup(fPrinterPort, fPrinterBoundRate, 3, 1000);
    FP.SetDateTime(Now);
    N := FP.errorCode;
    if N <> 0 then
    begin
      if N = 3 then
        S := 'Pentru setarea datei si orei este nevoie sa tipariti Z raport.'
      else
        S := FP.GetErrorString(N, 0);
      ShowErrorDialog('Eroare', 'Eroare la modificarea date si orei in aparatul fiscal' + #13#10 + S);
    end
    else
    begin
      lbFP_DateTime.Caption := FormatDateTime('dd MMMM yyyy, HH:NN', FP.GetDateTime);
      lbFPDateTimeWarning.Visible := False;
      btnSetupFPDateTime.Visible := False;
      ShowInfoDialog('Modificarea datei si orei', 'Data si ora a fost modificata cu succes!');
    end;
  finally
    FP.Free;
  end;

end;

procedure TfrmFiscalPrinterServiceV1Dlg.tbsYearReportShow(Sender: TObject);
var
  D, m, y: Word;
begin
  DecodeDate(Date, y, m, D);

  cxDateEdit1.Date := EncodeDate(y, 1, 1);
  cxDateEdit2.Date := EncodeDate(y, 12, 31);
end;

procedure TfrmFiscalPrinterServiceV1Dlg.WhenFiscalPrinterDeviceEvent(const Thread: TFiscalPrinterDetectThread);
begin
  case Thread.DeviceStatus of
    fpdsUnknown, fpdsNotFoundDriver:
      begin
        lbPrinterInfo.Font.Color := clRed;
        lbPrinterInfo.Caption := 'Nu este support de drivere!';
      end;
    fpdsNotFound:
      begin
        lbPrinterInfo.Font.Color := clRed;
        lbPrinterInfo.Caption := 'Imprimanta fiscala nu a fost gasita!';
      end;
    fpdsFound, fpdsFoundNew:
      begin
        fPrinterExists := True;
        lbPrinterInfo.Font.Color := clGreen;
        lbPrinterInfo.Caption := Thread.FPFactoryNumber + ' (' + Thread.FPVersion + ') pe COM' + IntToStr(Thread.PrinterPort);

        fPrinterPort := Thread.PrinterPort;
        fPrinterBoundRate := Thread.PrinterBoundRate;

        GetPrinterInfo;
      end;
  end;

  SetupButtons;

  fCanClose := True;
end;

procedure TfrmFiscalPrinterServiceV1Dlg.WhenTimeToDetectFiscalPrinter(Sender: TObject);
var
  FPT: TFiscalPrinterDetectThread;
begin
  FPT := TFiscalPrinterDetectThread.Create;
  FPT.PrinterPort := fPrinterPort;
  FPT.PrinterBoundRate := fPrinterBoundRate;
  FPT.OnDetectFinished := WhenFiscalPrinterDeviceEvent;
  FPT.Start;
end;

end.


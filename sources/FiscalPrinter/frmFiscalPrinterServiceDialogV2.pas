unit frmFiscalPrinterServiceDialogV2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SWNBaseUnit, FiscalPrinterUtilsUnit, Dialogs,
  DialogTitle, StdCtrls, ExtCtrls, Menus, ComCtrls, {ZFPCOMLib_TLB,} OleServer, cxCalendar, cxGroupBox, cxButtons, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, dxUIAClasses, Tremol.FP, Tremol.FP_core;

type
  TfrmFiscalPrinterServiceV2Dlg = class(TSWNCustomForm)
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
    procedure FormDestroy(Sender: TObject);
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
    fpc: FP;
    fCanClose: Boolean;
    fPrinterExists: Boolean;
    fPrinterPort: Integer;
    fPrinterBoundRate: Integer;
    procedure WhenTimeToDetectFiscalPrinter(Sender: TObject);
    procedure GetPrinterInfo;
    procedure SetupButtons;
    procedure SetPrinterBoundRate(const Value: Integer);
    procedure SetPrinterPort(const Value: Integer);

// TODO: FP_Error
//  function FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean = False): Boolean;
    procedure AbortReceipt;
    procedure OpenTill;
    procedure PrintXReport;
    procedure PrintZReport;
    procedure SetupFiscalPrinterdateTime;
    procedure WhenFiscalPrinterDeviceEvent(const Thread: TFiscalPrinterDetectThread);
    function PrintYearReport(const Year: Integer): Boolean;
    procedure PrintPeriodReport(StartDate: TDate; EndDate: TDate);
    procedure NotifyInvalidTaxGroup;
    procedure HandleException(ex: Exception);
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
  SWNUtils, DateUtils, SWNConst, IBC, DataModuleDB, SWNValueStorageUnit;

{$R *.dfm}

procedure TfrmFiscalPrinterServiceV2Dlg.HandleException(ex: Exception);
var
  sx: SException;
begin
  if ex.ClassType.InheritsFrom(SException) then
  begin
    sx := ex as SException;
               // Here are most important cases of errors
    case sx.ErrType of
      ServerAddressNotSet:
        ShowMessage('Specify server ServerAddress property ');
      ServerConnectionError:
        ShowMessage('Connection from this app to the server is not established');
      ServerDefsMismatch:
        ShowMessage('The current library version and server definitions version do not match');
      ServMismatchBetweenDefinitionAndFPResult:
        ShowMessage('The current library version and the fiscal device firmware is not matching');
      ServSockConnectionFailed:
        ShowMessage('When the server can not connect to the fiscal device');
      ServTCPAuth:
        ShowMessage('Wrong device �CP password');
      ServWaitOtherClientCmdProcessingTimeOut:
        ShowMessage('Proccessing of other clients command is taking too long');
      FPException:
        begin
                  //Check for the error is at the communication level
          if sx.FPLibErrorCode > $100 then
          begin

                    //Possible communication error reasons
            case sx.FPLibErrorCode of
              $109:
                ShowMessage('The fiscal device is missing');
              $10A:
                ShowMessage('The fiscal device is busy');
              $102:
                ShowMessage('Timeout while reading data from the fiscal device');
              $10F:
                ShowMessage('The connection with the device is not available');
              $110:
                ShowMessage('Out of paper');
              $111:
                ShowMessage('Fiscal device has already opened connection from another client');
              $112:
                ShowMessage('Wrong ZFP network password');
              $113:
                ShowMessage('Fiscal device is waiting for network password');
            end;
          end
                //The error is at the device command processing level
          else
          begin
    {
            Possible reasons:
            sx.STE1 =                                              sx.STE2 =
                $30 OK                                                   $30 OK
                $31 Out of paper, printer failure                        $31 Invalid command
                $32 Registers overflow                                   $32 Illegal command
                $33 Clock failure or incorrect date&time                 $33 Z daily report is not zero
                $34 Opened fiscal receipt                                $34 Syntax error
                $35 Payment residue account                              $35 Input registers overflow
                $36 Opened non-fiscal receipt                            $36 Zero input registers
                $37 Registered payment but receipt is not closed         $37 Unavailable transaction for correction
                $38 Fiscal memory failure                                $38 Insufficient amount on hand
                $39 Incorrect password                                   $3A No access
                $3a Missing external display
                $3b 24hours block � missing Z report
                $3c Overheated printer thermal head.
                $3d Interrupt power supply in fiscal receipt (one time until status is read)
                $3e Overflow EJ
                $3f Insufficient conditions
     }
            if (sx.ste1 = $30) and (sx.ste2 = $32) then
              ShowMessage('sx.STE1 = $30 - command is OK  AND  sx.STE2 = $32 - command is Illegal in current context');

            if (sx.ste1 = $30) and (sx.ste2 = $33) then
              ShowMessage('sx.STE1 = $30 - command is OK  AND sx.STE2 = $33 - make Z report');

            if (sx.ste1 = $34) and (sx.ste2 = $32) then
              ShowMessage('sx.STE1 = $34 - Opened fiscal receipt  AND  sx.STE2 = $32 - command is Illegal in current context');
          end;
        end
    else
      ShowMessage(sx.GetMessage);
    end;
  end
  else
    ShowMessage(ex.Message);
end;

procedure TfrmFiscalPrinterServiceV2Dlg.FormDestroy(Sender: TObject);
begin
    // eliberam MCC pentru celelalte calculatoare din retea
  if Assigned(fpc) then
  try
    fpc.ServerCloseDeviceConnection;
  except
      // serverul poate fi deja inaccesibil
  end;

  FreeAndNil(fpc);
end;

{ TfrmFiscalPrinterServiceDlg }

procedure TfrmFiscalPrinterServiceV2Dlg.AbortReceipt;
var
  fpc: FP;
begin

  try

    fpc.CancelReceipt;
    ShowInfoDialog('Anularea bonului fiscal', 'Bonus fiscal a fost anulat!');
  except
    on se: SException do
    begin
      HandleException(se);
      raise Exception.Create('Eroare la anularea bonului!');
    end;
  end;

end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnAbortReceiptClick(Sender: TObject);
begin
  if ShowAskDialog('Anularea bonului fiscal', 'Anularea ultimului bon fiscal?') = mrYes then
    AbortReceipt;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnFixTVAClick(Sender: TObject);
begin
  if ShowAskDialog('Modificarea grupelor fiscale', 'Modificarea valorilor grupelor fiscale? (20%,8%,10%,0%)') = mrYes then
  begin

  end;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnOpenTillClick(Sender: TObject);
begin
  OpenTill;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnPrintYearReportClick(Sender: TObject);
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

procedure TfrmFiscalPrinterServiceV2Dlg.btnPrint_X_ReportClick(Sender: TObject);
begin
  if ShowAskDialog('Tipar X raport', 'Tipar X-raport?') = mrYes then
    PrintXReport;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnPrint_Z_ReportClick(Sender: TObject);
begin
  if ShowAskDialog('Tipar Z raport',
    'Raportul va inchide schimbul si va inscrie valoarea curenta a bonurilor fiscale tiparite pina acum.' + #13#10 +
    'Sigur doriti sa tipariti Z raport??') = mrYes then
    PrintZReport;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.btnSetupFPDateTimeClick(Sender: TObject);
begin
  if ShowAskDialog('Modificare ora', 'Sunteti sigur ca doriti sa modificati data si ora in echipamentul fiscal?') = mrYes then
    SetupFiscalPrinterdateTime;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.Button1Click(Sender: TObject);
begin
  PrintPeriodReport(cxDateEdit1.Date, cxDateEdit2.Date);
end;

procedure TfrmFiscalPrinterServiceV2Dlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fCanClose;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.FormCreate(Sender: TObject);
var
  fpConnection: TTremolConnection;
  fpServer: TFiscalPrinterServer;
begin
  fCanClose := True;

  fPrinterExists := False;
  fPrinterPort := 0;
  fPrinterBoundRate := cFISCAL_PRINTER_DefaultBoundRateV2;
  tbsError.TabVisible := False;
  lbFPDateTimeWarning.Visible := False;
  btnSetupFPDateTime.Visible := False;
  cxPageControl.ActivePage := tbsInfo;

  // initializa fiscal printer - MCC poate fi si pe alt calculator din reteaua locala
  fpServer := GetFiscalPrinterServer(dmDB.FirmaInfo.FirmaID);

  fpc := FP.Create;
  fpc.ServerAddress := fpServer.ServerAddress;
  //Initializing server definitions
  try
    fpc.ApplyClientLibraryDefinitions();

    // portul COM nu se mai scrie in cod: pentru MCC locala se ia din setari, iar daca nu
    // raspunde nimic pe el - serverul ZFPLab cauta singur echipamentul (finddevice());
    // pentru MCC din retea portul vine din FP_DEVICES.
    fpConnection := ConnectTremolFiscalPrinter(fpc, fpServer);
    if fpConnection.Connected then
    begin
      fPrinterExists := True;
      fPrinterPort := StrToIntDef(Copy(fpConnection.Port, 4, Length(fpConnection.Port)), 0);
      fPrinterBoundRate := fpConnection.BaudRate;

      lbPrinterInfo.Caption := fpc.ReadSerialAndFiscalNums.SerialNum;
      GetPrinterInfo;
    end
    else
    begin
      lbPrinterInfo.Font.Color := clRed;
      lbPrinterInfo.Caption := 'MCC nu a fost gasita pe nici un port COM!';
    end;
  except
    on se: SException do
      HandleException(se);
  end;

  SetupButtons;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.FormShow(Sender: TObject);
begin
  // Tremol FP is already initialized in FormCreate via HTTP server.
  // ZFPCOM detect thread is intentionally NOT started here because ZFPCOM (ZFPCOMLib_TLB)
  // sends raw serial bytes using a different protocol (ZEKA/Datecs) directly to the COM port.
  // This conflicts with the Tremol FP server which manages the same port, causing the printer
  // to misinterpret the bytes as a command to open a non-fiscal receipt. That open receipt
  // then gets auto-closed (printed as "bon de serviciu") when the Z report command arrives.
end;

// TODO: FP_Error
//function TfrmFiscalPrinterServiceDlg.FP_Error(const FP: TZekaFP; const CriticalProcedure: Boolean = False): Boolean;
//var
//Error: Integer;
//begin
//Error := FP.errorCode;
//Result := Error <> 0;
//if Result then
//begin
//  mmErrors.Lines.Add(FP.GetErrorString(Error, 0));
//  // check for specific error code and enable error correction tab
//  if CriticalProcedure then
//  begin
//    tbsError.TabVisible := True;
//    cxPageControl.ActivePage := tbsError;
//  end;
//end;
//end;

procedure TfrmFiscalPrinterServiceV2Dlg.GetPrinterInfo;
var
  D: TDateTime;
  N: Integer;
//  TaxPerc: ITaxNumbers;
  VATRates: VATRatesRes;
begin
  lbInfo1.Caption := 'Numarul fiscal: ' + fpc.ReadSerialAndFiscalNums_V2.FMNum;
  lbInfo2.Caption := 'Numarul fiscalizat: ' + fpc.ReadSerialAndFiscalNums_V2.UniCode;
  D := fpc.ReadDateTime;
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
  VATRates := fpc.ReadVATrates;
  if (VATRates.VATrateA <> 20) then
  begin
    lbInvalidTVAGroup.Visible := True;
    NotifyInvalidTaxGroup;
  end;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.NotifyInvalidTaxGroup;
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

procedure TfrmFiscalPrinterServiceV2Dlg.OpenTill;
begin
  fpc.SafeBoxOpen;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.Prepare;
begin
  lbInvalidTVAGroup.Visible := False;

  cmbReportYear.Items.Clear;
  cmbReportYear.Items.Add(IntToStr(YearOf(Now)));
  cmbReportYear.Items.Add(IntToStr(YearOf(Now) - 1));
  cmbReportYear.ItemIndex := 0;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.PrintXReport;
begin
  fpc.PrintDailyReport(z_Without_zeroing); // no clear all, long form
end;

function TfrmFiscalPrinterServiceV2Dlg.PrintYearReport(const Year: Integer):
    Boolean;
begin
  try
    fpc.PrintBriefFMReportByDate(EncodeDate(Year, 1, 1), EncodeDate(Year, 12, 31));
    Result := True;
  except
    RESULT := false;
  end;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.PrintPeriodReport(StartDate: TDate;
    EndDate: TDate);
begin
  fpc.PrintBriefFMReportByDate(StartDate, EndDate);
end;

procedure TfrmFiscalPrinterServiceV2Dlg.PrintZReport;
begin
  fpc.PrintDailyReport(z_Zeroing); // no clear all, long form
end;

procedure TfrmFiscalPrinterServiceV2Dlg.SetPrinterBoundRate(const Value: Integer);
begin
  fPrinterBoundRate := Value;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.SetPrinterPort(const Value: Integer);
begin
  fPrinterPort := Value;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.SetupButtons;
begin
  fPrinterExists := True;
  btnPrint_Z_Report.Enabled := fPrinterExists;
  btnPrint_X_Report.Enabled := fPrinterExists;
  btnPrintYearReport.Enabled := fPrinterExists;
  cxPageControl.Enabled := fPrinterExists;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.SetupFiscalPrinterdateTime;
begin
  try
    fpc.SetDateTime(Now);
  except
    //Use "SException" which inherits "Exception" class to handle exceptions
    on se: SException do
      handleException(se);
  end;

  lbFP_DateTime.Caption := FormatDateTime('dd MMMM yyyy, HH:NN', fpc.ReadDateTime);
  lbFPDateTimeWarning.Visible := False;
  btnSetupFPDateTime.Visible := False;
  ShowInfoDialog('Modificarea datei si orei', 'Data si ora a fost modificata cu succes!');

end;

procedure TfrmFiscalPrinterServiceV2Dlg.tbsYearReportShow(Sender: TObject);
var
  D, m, y: Word;
begin
  DecodeDate(Date, y, m, D);

  cxDateEdit1.Date := EncodeDate(y, 1, 1);
  cxDateEdit2.Date := EncodeDate(y, 12, 31);
end;

procedure TfrmFiscalPrinterServiceV2Dlg.WhenFiscalPrinterDeviceEvent(const Thread: TFiscalPrinterDetectThread);
begin
  // rewrite entire procedure

//  case Thread.DeviceStatus of
//    fpdsUnknown, fpdsNotFoundDriver:
//      begin
//        lbPrinterInfo.Font.Color := clRed;
//        lbPrinterInfo.Caption := 'Nu este support de drivere!';
//      end;
//    fpdsNotFound:
//      begin
//        lbPrinterInfo.Font.Color := clRed;
//        lbPrinterInfo.Caption := 'Imprimanta fiscala nu a fost gasita!';
//      end;
//    fpdsFound, fpdsFoundNew:
//      begin
//        fPrinterExists := True;
//        lbPrinterInfo.Font.Color := clGreen;
//        lbPrinterInfo.Caption := Thread.FPFactoryNumber + ' (' + Thread.FPVersion + ') pe COM' + IntToStr(Thread.PrinterPort);
//
//        fPrinterPort := Thread.PrinterPort;
//        fPrinterBoundRate := Thread.PrinterBoundRate;
//
//        GetPrinterInfo;
//      end;
//  end;

  fPrinterPort := Thread.PrinterPort;
  fPrinterBoundRate := Thread.PrinterBoundRate;

  GetPrinterInfo;

  SetupButtons;

  fCanClose := True;
end;

procedure TfrmFiscalPrinterServiceV2Dlg.WhenTimeToDetectFiscalPrinter(Sender: TObject);
var
  FPT: TFiscalPrinterDetectThread;
begin
  FPT := TFiscalPrinterDetectThread.Create;
  FPT.PrinterPort := fPrinterPort;
  FPT.PrinterBoundRate := fPrinterBoundRate;
  FPT.OnDetectFinished := WhenFiscalPrinterDeviceEvent;
  FPT.Start;
  fCanClose := True;
end;

end.


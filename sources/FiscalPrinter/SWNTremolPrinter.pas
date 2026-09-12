unit SWNTremolPrinter;

interface

uses
  SysUtils, Tremol.FP, Tremol.FP_core;

type
  TSWNTremolPrinterStatus = (psNotFound, psFoundAndReady, psFoundWithError);

  TSWNTremolPrinter = class
  private
    { Private declarations }
    FTremolFP: FP;
    fPort: Word;
    fBoudrate: Word;
    fLastErrorCode: Word;
    fLastErrorText: string;
    function GetFiscalNumber: string;
    function GetTaxNumber: string;
  protected
// TODO: SaveLastError
//  { Protected declarations }
//  procedure SaveLastError;
    procedure HandleException(ex: Exception);
  public
    { Public declarations }
    constructor Create(ServerAdress: string = 'http:/localhost:4444');
    destructor Destroy; override;

    property TremolFP: FP read FTremolFP;
    property PrinterPort: Word read fPort;
    property PrinterBoudrate: Word read fBoudrate;
    property FiscalNumber: string read GetFiscalNumber;
    property TaxNumber: string read GetTaxNumber;

    property LastErrorCode: Word read fLastErrorCode;
    property LastErrorMessage: string read fLastErrorText;

    function GetPrinterStatus: TSWNTremolPrinterStatus;
// TODO: GetDeviceStatus
//  function GetDeviceStatus:IZFPStatus;

    function PrintXReport: Boolean;
    function PrintZReport: Boolean;
    function OpenCashDrawer: Boolean;
    function TerminateBon: Boolean;
    function SetCurrentDateTime: Boolean;
  end;

implementation

uses
  Vcl.Dialogs, WinApi.ActiveX;

{ TSWNZekaPrinter }

constructor TSWNTremolPrinter.Create(ServerAdress: string);
begin
  CoInitialize(Self);
  FTremolFP := FP.Create;
  FTremolFP.ServerAddress := ServerAdress;
//  FTremolFP.ServerSetDeviceSerialPortSettings('COM7', 115200);

  try
    FTremolFP.ApplyClientLibraryDefinitions();
  except
    on se: SException do
      HandleException(se);
  end;

end;

destructor TSWNTremolPrinter.Destroy;
begin
  FreeAndNil(FTremolFP);
  CoUninitialize;
  inherited;
end;

procedure TSWNTremolPrinter.handleException(ex: Exception);
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
        ShowMessage('Wrong device TCP password');
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
                $3b 24hours block – missing Z report
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
      begin
        ShowMessage(sx.GetMessage);
        fLastErrorCode := sx.FPLibErrorCode;
        fLastErrorText := sx.GetMessage;
      end;

    end;
  end
  else
    ShowMessage(ex.Message);
end;


// TODO: GetDeviceStatus
//function TSWNTremolPrinter.GetDeviceStatus: IZFPStatus;
//var status:IZFPStatus;
//begin
//   Result:=nil;
//   status:=IZFPStatus(FTremolFP.GetStatus);
//   if FTremolFP.errorCode=0 then Result:=status;
//end;

function TSWNTremolPrinter.GetFiscalNumber: string;
var
  RegInfo: RegistrationInfoRes;
begin
//     ReceiptInfo := fp.TremolFP.ReadCurrentRecInfo;

    {Provides information about the owner's numbers and registration date time.}
  RegInfo := FTremolFP.ReadRegistrationInfo;
  try
    Result := RegInfo.RegistrationNumber;
  except
    on se: SException do
      HandleException(se);
  end;
end;

function TSWNTremolPrinter.GetPrinterStatus: TSWNTremolPrinterStatus;
//var
// status:IZFPStatus;
//    N:Cardinal;
//    reScan:Boolean;
begin
//     CoInitialize(nil);
//     Result:=psNotFound;
//     repeat
//           reScan:=False;
//           // setup
//           FTremolFP.Setup(fPort,fBoudrate,1,1000);
//           // get status
//           status:=IZFPStatus(FTremolFP.GetStatus);
//           // is ok?
//           if FTremolFP.errorCode=0 then
//           begin
//                if (status.wrongTimer=1) or (status.wrongDate=1) or
//                   (status.paperOutPrinterError=1) or (status.OpenFiscalBon=1) or
//                   (status.fullFiscalMemory=1) or (status.printerOverheat=1) or
//                   (status.Blocked24HoursReport=1)
//                then Result:=psFoundWithError
//                else Result:=psFoundAndReady;
//           end
//           else
//           // not found message = 265
//           if (FTremolFP.errorCode=265) and not reScan then
//           begin
//                // incercam sa-l gasim
//                N:=FTremolFP.FindFirstFPCOM;
//                if N>0 then
//                begin
//                     fPort:=N and $0000FFFF;
//                     fBoudrate:=N shr 16;
//                     reScan:=True;
//                end;
//           end;
//     until Not reScan;
  Result := psFoundAndReady;
end;

function TSWNTremolPrinter.GetTaxNumber: string;
var
  RegInfo: RegistrationInfoRes;
begin
//     ReceiptInfo := fp.TremolFP.ReadCurrentRecInfo;

    {Provides information about the owner's numbers and registration date time.}
  RegInfo := FTremolFP.ReadRegistrationInfo;
  try
    Result := RegInfo.IDNum;
  except
    on se: SException do
      HandleException(se);
  end;


    {Provides information about the manufacturing number of the fiscal device, FM number and ECR Unique number.}
//    function ReadSerialAndFiscalNums(): SerialAndFiscalNumsRes;

end;

//function TSWNTremolPrinter.GetTaxNumber: String;
//begin
//     Result:=FTremolFP.GetTaxNumber;
//     if FTremolFP.errorCode<>0 then SaveLastError;
//end;

function TSWNTremolPrinter.OpenCashDrawer: Boolean;
begin
  try
    FTremolFP.CashDrawerOpen;
  except
    on se: SException do
      HandleException(se);
  end;
end;

function TSWNTremolPrinter.PrintXReport: Boolean;
begin
  try
    FTremolFP.PrintDailyReport(z_Without_zeroing); // no clear all, no long form
  except
    on se: SException do
      HandleException(se);
  end;
end;

function TSWNTremolPrinter.PrintZReport: Boolean;
begin
  try
    FTremolFP.PrintDailyReport(z_Zeroing);
  except
    on se: SException do
      HandleException(se);
  end;
end;

// TODO: SaveLastError
//procedure TSWNTremolPrinter.SaveLastError;
//begin
////     fLastErrorCode:=FTremolFP.errorCode;
////     fLastErrorText:=FTremolFP.GetErrorString(FTremolFP.errorCode,0);
//end;

function TSWNTremolPrinter.SetCurrentDateTime: Boolean;
begin
  try
    FTremolFP.SetDateTime(NOW);
  except
    on se: SException do
      HandleException(se);
  end;
end;

function TSWNTremolPrinter.TerminateBon: Boolean;
begin
  try
    FTremolFP.CloseReceipt;
  except
    on se: SException do
      HandleException(se);
  end;
end;

end.


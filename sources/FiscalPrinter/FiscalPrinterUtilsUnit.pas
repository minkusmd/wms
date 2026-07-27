unit FiscalPrinterUtilsUnit;

interface

Uses Windows, Classes, ZFPCOMLib_TLB;

type

  TFiscalPrinterDetectThread = class;

  TFiscalPrinterDeviceStatus = (fpdsUnknown,fpdsNotFound,fpdsNotFoundDriver,fpdsFound,fpdsFoundNew);
  TFiscalPrinterDeviceEvent = procedure (const Thread:TFiscalPrinterDetectThread) of object;

  TFiscalPrinterDetectThread = class (TThread)
  private
    { Private declarations }
    FPrinterPort: integer;
    FPrinterBoundRate: integer;
    fDeviceStatus: TFiscalPrinterDeviceStatus;
    fOnDetectFinished: TFiscalPrinterDeviceEvent;
    fFPVersion: String;
    fFPFactoryNumber: String;
    procedure SetPrinterBoundRate(const Value: integer);
    procedure SetPrinterPort(const Value: integer);
    procedure SetDetectFinished(const Value: TFiscalPrinterDeviceEvent);
    procedure CallUserProc;
  public
    { Public declarations }
    constructor Create;reintroduce;

    procedure Execute;override;

    property DeviceStatus:TFiscalPrinterDeviceStatus read fDeviceStatus;
    property PrinterPort:integer read FPrinterPort write SetPrinterPort;
    property PrinterBoundRate:integer read FPrinterBoundRate write SetPrinterBoundRate;
    property OnDetectFinished:TFiscalPrinterDeviceEvent read fOnDetectFinished write SetDetectFinished;

    property FPFactoryNumber:String read fFPFactoryNumber;
    property FPVersion:String read fFPVersion;

  end;


implementation

Uses ActiveX;

{ TFiscalPrinterDetectThread }

procedure TFiscalPrinterDetectThread.CallUserProc;
begin
     if Assigned(fOnDetectFinished) then fOnDetectFinished(Self);
end;

constructor TFiscalPrinterDetectThread.Create;
begin
     inherited Create(True);
     FreeOnTerminate:=True;

     FPrinterPort:=1; // COM1
     FPrinterBoundRate:=9600;
     fDeviceStatus:=fpdsUnknown;

     fOnDetectFinished := nil;

     fFPFactoryNumber := '';
     fFPVersion := '';
end;

procedure TFiscalPrinterDetectThread.Execute;
var FP:TZekaFP;
    N:cardinal;
    BaundRate:WORD;
    COMPort:Word;
begin
     fDeviceStatus:=fpdsUnknown;

     // 1. test for drivers
     CoInitialize(nil);


     try
        FP:=TZekaFP.Create(nil);
        try
           FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
           FP.GetFactoryNumber;
        finally
           FP.Free;
        end;
     except
        fDeviceStatus:=fpdsNotFoundDriver;
     end;

     // 2. test for device
     if fDeviceStatus<>fpdsNotFoundDriver then
     begin
          FP:=TZekaFP.Create(nil);
          try
             FP.Setup(fPrinterPort,fPrinterBoundRate,3,1000);
             fFPFactoryNumber:=FP.GetFactoryNumber;
             if FP.errorCode=0 then
             begin
                  fDeviceStatus:=fpdsFound;
                  fFPVersion:=FP.GetVersion;

             end
             else
             begin
                  // not found at default settings
                  fDeviceStatus:=fpdsNotFound;

                  // try to find on all ports
                  N:=FP.FindFirstFPCOM;
                  if N>0 then
                  begin
                       COMPort:=N and $0000FFFF;
                       BaundRate:=N shr 16;

                       FP.Setup(COMPort,BaundRate,3,1000);
                       fFPFactoryNumber:=FP.GetFactoryNumber;
                       if FP.errorCode=0 then
                       begin
                            fFPVersion:=FP.GetVersion;
                            // save found values
                            fDeviceStatus:=fpdsFoundNew;
                            fPrinterPort:=COMPort;
                            fPrinterBoundRate:=BaundRate;
                       end;
                  end;
             end;
          finally
             FP.Free;
          end;
     end;

     CoUninitialize;

     if Not Terminated then Synchronize(CallUserProc);
end;

procedure TFiscalPrinterDetectThread.SetDetectFinished(const Value: TFiscalPrinterDeviceEvent);
begin
     fOnDetectFinished := Value;
end;

procedure TFiscalPrinterDetectThread.SetPrinterBoundRate(const Value: integer);
begin
     FPrinterBoundRate := Value;
end;

procedure TFiscalPrinterDetectThread.SetPrinterPort(const Value: integer);
begin
     FPrinterPort := Value;
end;


end.

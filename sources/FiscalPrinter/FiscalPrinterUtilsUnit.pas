unit FiscalPrinterUtilsUnit;

interface

Uses Windows, Classes, ZFPCOMLib_TLB, Tremol.FP;

const
  // adresa serverului ZFPLab (ZFPLabServer) instalat local
  cTREMOL_ZFPLabServerAddress = 'http://localhost:4444/';

  // mesajul afisat cind echipamentul fiscal nu a fost gasit pe nici un port
  cFISCAL_PRINTER_NotFoundMessage = 'Nu este gasita MCC';

  // serverul ZFPLab nu raspunde: calculatorul cu MCC este oprit sau a schimbat adresa
  cFISCAL_PRINTER_ServerNotRespondingMessage = 'Serverul MCC nu raspunde';

type

  TFiscalPrinterDetectThread = class;

  // rezultatul conectarii la echipamentul fiscal Tremol (FP-15 si compatibile)
  TTremolConnection = record
    Connected: Boolean;
    ServerReachable: Boolean;
    Port: String;
    BaudRate: Integer;
  end;

  // unde se afla serverul ZFPLab care deserveste MCC pentru acest calculator.
  // IsRemote = True inseamna ca MCC este atasata la alt calculator din reteaua locala.
  TFiscalPrinterServer = record
    ServerAddress: String;
    Port: String;
    BaudRate: Integer;
    IsRemote: Boolean;
  end;

  // aparatul fiscal ales pentru firma si calculatorul curent (FP_DEVICES)
  TFiscalDeviceInfo = record
    Found: Boolean;          // exista un rind activ in FP_DEVICES
    FPID: Integer;
    DeviceType: Integer;     // FP_DEVICES.DEVICE_TYPE: 0 = MCC Tremol, 1 = ECC Fiscal Partner
    EccApiCode: String;      // TS_API_CONFIG.API_CODE al casei ECC
    Server: TFiscalPrinterServer;
  end;

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

// Numele acestui calculator (asa cum este inregistrat in WS_WORK_STATIONS.COMPUTER_NAME).
function GetCurrentComputerName: String;

// Inregistreaza calculatorul curent in WS_WORK_STATIONS, ca sa poata fi ales in dialogul
// "Acces la MCC". Se apeleaza la pornire, imediat ce se stie firma curenta.
// Daca statia este deja inregistrata nu se intimpla nimic.
procedure RegisterCurrentWorkStation(const AFirmaID: Integer);

// Adresa serverului ZFPLab pentru MCC pe care are voie sa o foloseasca acest calculator.
// Se cauta in FP_DEVICES: intii MCC atasata la calculatorul curent, apoi MCC partajate
// prin FP_DEVICE_ACCESS. Daca nu este configurat nimic - MCC locala (http://localhost:4444/).
function GetFiscalPrinterServer(const AFirmaID: Integer): TFiscalPrinterServer;

// Acelasi aparat ca GetFiscalPrinterServer, cu tipul lui (Tremol / ECC).
// Fara rind in FP_DEVICES: Found = False si MCC Tremol locala (comportamentul de pina acum).
function GetFiscalDeviceInfo(const AFirmaID: Integer): TFiscalDeviceInfo;

// Conecteaza obiectul Tremol FP la echipamentul fiscal fara a cere portul de la utilizator.
// Ordinea incercarilor:
//   1. portul din configurarea MCC, altfel cel memorat in setarile calculatorului;
//   2. finddevice() al serverului ZFPLab - serverul scaneaza singur toate porturile
//      seriale si toate vitezele si returneaza primul echipament fiscal gasit;
// Pasul 2 se face DOAR pentru MCC locala: pe un calculator strain scanarea tuturor
// porturilor seriale ar deranja celelalte echipamente conectate la el.
// Portul gasit este scris in setari, deci cautarea se face o singura data pe calculator.
// ATENTIE: AFP.ApplyClientLibraryDefinitions trebuie apelat INAINTE de aceasta functie,
// altfel serverul nu cunoaste comenzile folosite pentru verificarea portului.
function ConnectTremolFiscalPrinter(const AFP: FP; const AServer: TFiscalPrinterServer): TTremolConnection;

implementation

Uses ActiveX, SysUtils, IBC, DataModuleDB, SWNConst, SWNValueStorageUnit;

function GetCurrentComputerName: String;
var
  Buf: array[0..MAX_COMPUTERNAME_LENGTH] of Char;
  Size: DWORD;
begin
  Size := Length(Buf);
  if GetComputerName(Buf, Size) then
    SetString(Result, PChar(@Buf[0]), Size)
  else
    Result := '';
end;

// Adresa indica acest calculator? (localhost, 127.0.0.1 sau chiar numele lui)
function IsLocalServerAddress(const AAddress: String): Boolean;
var
  S: String;
  P: Integer;
begin
  S := LowerCase(Trim(AAddress));

  P := Pos('://', S);
  if P > 0 then
    Delete(S, 1, P + 2);

  P := Pos('/', S);
  if P > 0 then
    S := Copy(S, 1, P - 1);

  P := Pos(':', S);
  if P > 0 then
    S := Copy(S, 1, P - 1);

  Result := (S = '') or (S = 'localhost') or (S = '127.0.0.1') or (S = LowerCase(GetCurrentComputerName));
end;

procedure RegisterCurrentWorkStation(const AFirmaID: Integer);
var
  Query: TIBCQuery;
  Tr: TIBCTransaction;
  ComputerName: String;
begin
  if AFirmaID <= 0 then Exit;

  ComputerName := GetCurrentComputerName;
  if ComputerName = '' then Exit;

  Query := TIBCQuery.Create(nil);
  Tr := TIBCTransaction.Create(nil);
  try
    try
      Tr.DefaultConnection := dmDB.IBCConnection;
      Query.Connection := dmDB.IBCConnection;
      Query.Transaction := Tr;
      Tr.StartTransaction;
      try
        Query.SQL.Text := 'SELECT WS_ID FROM SP_REGISTER_WORKSTATION(:FIRMA_ID, :COMPUTER_NAME)';
        Query.ParamByName('FIRMA_ID').AsInteger := AFirmaID;
        Query.ParamByName('COMPUTER_NAME').AsString := ComputerName;
        Query.Open;
        Query.Close;
        Tr.Commit;
      except
        if Tr.Active then
          Tr.Rollback;
        raise;
      end;
    except
      // in bazele in care procedura inca nu exista inregistrarea pur si simplu nu se face -
      // nu este un motiv sa nu porneasca aplicatia
    end;
  finally
    Query.Free;
    Tr.Free;
  end;
end;

function GetFiscalPrinterServer(const AFirmaID: Integer): TFiscalPrinterServer;
begin
  Result := GetFiscalDeviceInfo(AFirmaID).Server;
end;

function GetFiscalDeviceInfo(const AFirmaID: Integer): TFiscalDeviceInfo;
const
  // coloanele DEVICE_TYPE / ECC_API_CODE vin din DB Model/ecc_fiscalpartner.sql;
  // intr-o baza fara ele se foloseste interogarea veche (doar Tremol)
  cDeviceColumns: array[Boolean] of String = (
    '0 AS DEVICE_TYPE, CAST(NULL AS VARCHAR(30)) AS ECC_API_CODE, ',
    'D.DEVICE_TYPE, D.ECC_API_CODE, ');
var
  Query: TIBCQuery;
  Address: String;
  WithDeviceType: Boolean;
begin
  Result.Found := False;
  Result.FPID := 0;
  Result.DeviceType := 0;
  Result.EccApiCode := '';
  Result.Server.ServerAddress := cTREMOL_ZFPLabServerAddress;
  Result.Server.Port := '';
  Result.Server.BaudRate := 0;
  Result.Server.IsRemote := False;

  for WithDeviceType := True downto False do
  begin
    Query := TIBCQuery.Create(nil);
    try
      try
        Query.Connection := dmDB.IBCConnection;
        // MCC se alege dupa firma curenta (FP_DEVICES.FIRMA_ID). Prioritatea:
        //   0 - MCC legata de calculatorul curent (WS_ID);
        //   1 - MCC partajata cu calculatorul curent prin FP_DEVICE_ACCESS;
        //   2 - MCC a firmei fara calculator indicat (WS_ID gol) - valabila pe orice statie.
        // MCC legata de alt calculator si nepartajata nu se foloseste: portul ei apartine acelui calculator.
        Query.SQL.Text :=
          'SELECT FIRST 1 D.FP_ID, D.SERVER_ADDRESS, D.COM_PORT, D.BAUD_RATE, ' +
          cDeviceColumns[WithDeviceType] +
          '  CASE WHEN UPPER(W.COMPUTER_NAME) = :COMPUTER_NAME THEN 0 ' +
          '       WHEN EXISTS(SELECT 1 FROM FP_DEVICE_ACCESS A ' +
          '                   INNER JOIN WS_WORK_STATIONS W2 ON W2.WS_ID = A.WS_ID ' +
          '                   WHERE (A.FP_ID = D.FP_ID) AND (UPPER(W2.COMPUTER_NAME) = :COMPUTER_NAME)) THEN 1 ' +
          '       ELSE 2 END AS WS_PRIORITY ' +
          'FROM FP_DEVICES D ' +
          'LEFT JOIN WS_WORK_STATIONS W ON W.WS_ID = D.WS_ID ' +
          'WHERE (D.FIRMA_ID = :FIRMA_ID) AND (D.FLG_ENABLED = 1) AND ' +
          '      ((D.WS_ID IS NULL) OR (UPPER(W.COMPUTER_NAME) = :COMPUTER_NAME) OR ' +
          '       EXISTS(SELECT 1 FROM FP_DEVICE_ACCESS A ' +
          '              INNER JOIN WS_WORK_STATIONS W2 ON W2.WS_ID = A.WS_ID ' +
          '              WHERE (A.FP_ID = D.FP_ID) AND (UPPER(W2.COMPUTER_NAME) = :COMPUTER_NAME))) ' +
          'ORDER BY 7, D.FP_ID';
        Query.ParamByName('FIRMA_ID').AsInteger := AFirmaID;
        Query.ParamByName('COMPUTER_NAME').AsString := UpperCase(GetCurrentComputerName);
        Query.Open;

        if not Query.Eof then
        begin
          Result.Found := True;
          Result.FPID := Query.FieldByName('FP_ID').AsInteger;
          Result.DeviceType := Query.FieldByName('DEVICE_TYPE').AsInteger;
          Result.EccApiCode := Trim(Query.FieldByName('ECC_API_CODE').AsString);
          Address := Trim(Query.FieldByName('SERVER_ADDRESS').AsString);
          if Address <> '' then
          begin
            // in FP_DEVICES adresa poate fi scrisa fara schema ("localhost:4444/") -
            // clientul HTTP (Indy) are nevoie de ea
            if Pos('://', Address) = 0 then
              Address := 'http://' + Address;
            // FP_Core lipeste comanda direct de adresa, deci "/" la sfirsit este obligatoriu
            if Address[Length(Address)] <> '/' then
              Address := Address + '/';
            Result.Server.ServerAddress := Address;
          end;
          Result.Server.Port := Trim(Query.FieldByName('COM_PORT').AsString);
          Result.Server.BaudRate := Query.FieldByName('BAUD_RATE').AsInteger;
        end;
        Break;
      except
        // MCC poate sa nu fie configurata in baza de date (sau coloanele inca lipsesc) -
        // in acest caz ramine MCC locala cu setarile memorate pe calculator
        Result.Found := False;
        Result.FPID := 0;
        Result.DeviceType := 0;
        Result.EccApiCode := '';
        Result.Server.ServerAddress := cTREMOL_ZFPLabServerAddress;
        Result.Server.Port := '';
        Result.Server.BaudRate := 0;
      end;
    finally
      Query.Free;
    end;
  end;

  Result.Server.IsRemote := not IsLocalServerAddress(Result.Server.ServerAddress);
end;

// Verifica daca pe portul indicat raspunde un echipament fiscal.
// ServerSetDeviceSerialPortSettings doar memoreaza setarile in server, de aceea
// este obligatorie si o comanda reala catre echipament.
function ProbeTremolPort(const AFP: FP; const APort: String; const ABaudRate: Integer): Boolean;
begin
  Result := False;
  if (APort = '') or (ABaudRate <= 0) then Exit;

  try
    AFP.ServerSetDeviceSerialPortSettings(APort, ABaudRate);
    Result := AFP.ReadSerialAndFiscalNums.SerialNum <> '';
  except
    Result := False;
  end;
end;

// Raspunde serverul ZFPLab? settings() este o comanda a serverului, nu a echipamentului
// fiscal, deci merge si atunci cind MCC este oprita.
function IsTremolServerAvailable(const AFP: FP): Boolean;
begin
  try
    AFP.ServerGetSettings;
    Result := True;
  except
    Result := False;
  end;
end;

function ConnectTremolFiscalPrinter(const AFP: FP; const AServer: TFiscalPrinterServer): TTremolConnection;
var
  Port: String;
  BaudRate: Integer;
  FoundDevice: TStringList;
begin
  Result.Connected := False;
  Result.ServerReachable := False;
  Result.Port := '';
  Result.BaudRate := 0;

  if AFP = nil then Exit;

  AFP.ServerAddress := AServer.ServerAddress;

    // daca serverul ZFPLab nu raspunde deloc (calculatorul cu MCC este oprit sau a schimbat
    // adresa) nu are rost sa incercam porturile - iar utilizatorul trebuie sa vada de ce
  Result.ServerReachable := IsTremolServerAvailable(AFP);
  if not Result.ServerReachable then Exit;

  // 1. portul din configurarea MCC
  Port := AServer.Port;
  BaudRate := AServer.BaudRate;

  // pentru MCC locala portul se memoreaza in setarile calculatorului;
  // pentru MCC din retea portul apartine altui calculator si vine doar din FP_DEVICES
  if not AServer.IsRemote then
  begin
    if Port = '' then
      Port := AppConfigStorage.TextValues.GetValue(cSETTINGS_AppFiscalPrinterComPortV2,
        cFISCAL_PRINTER_DefaultCOMportV2);

    if BaudRate <= 0 then
      BaudRate := AppConfigStorage.IntValues.GetValue(cSETTINGS_AppFiscalPrinterBoundRateV2,
        cFISCAL_PRINTER_DefaultBoundRateV2);
  end
  else if BaudRate <= 0 then
    BaudRate := cFISCAL_PRINTER_DefaultBoundRateV2;

  if ProbeTremolPort(AFP, Port, BaudRate) then
  begin
    Result.Connected := True;
    Result.Port := Port;
    Result.BaudRate := BaudRate;
    Exit;
  end;

  // 2. cautarea automata are voie sa scaneze doar porturile acestui calculator
  if AServer.IsRemote then Exit;

  FoundDevice := nil;
  try
    try
      FoundDevice := AFP.ServerFindDevice;
    except
      FoundDevice := nil;
    end;

    if (FoundDevice = nil) or (FoundDevice.Count < 2) then Exit;

    Port := FoundDevice[0];
    BaudRate := StrToIntDef(FoundDevice[1], cFISCAL_PRINTER_DefaultBoundRateV2);
  finally
    FoundDevice.Free;
  end;

  if not ProbeTremolPort(AFP, Port, BaudRate) then Exit;

  Result.Connected := True;
  Result.Port := Port;
  Result.BaudRate := BaudRate;

  // 3. memoram portul gasit pentru pornirile urmatoare
  AppConfigStorage.TextValues.SetValue(cSETTINGS_AppFiscalPrinterComPortV2, Port);
  AppConfigStorage.IntValues.SetValue(cSETTINGS_AppFiscalPrinterBoundRateV2, BaudRate);
end;

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

unit ServiceJobsUnit;

(* Job-uri Delphi rulate de SWNService in locul unei proceduri stocate.

   In SWNServiceManager se defineste o sarcina obisnuita (zi + interval, de ex.
   00:05 = la 5 minute), iar in cimpul "procedura stocata" se scrie numele
   job-ului cu "@" in fata. Numele job-urilor de mai jos sint recunoscute si fara
   "@" (nu exista proceduri stocate cu aceste nume) - o sarcina scrisa "ECC_ONLINE"
   nu mai ajunge in Firebird ca "EXECUTE PROCEDURE ECC_ONLINE" (-204, 3.10.2026).
   TSQLThread.DoSQLAction face PROC_USER_LOGIN, comite si cheama RunServiceJob pe
   aceeasi conexiune (proprie firului de lucru).

   Job-uri:
     @ECC_ONLINE     - fiscalizarea platilor online (card maib, MIA) pe casa ECC
                       Fiscal Partner a firmei comenzii (ECCOnlineFiscalUnit).
     @ECC_RECONCILE  - reconcilierea zilei precedente pe toate casele ECC active
                       (ECCReconcileUnit), cu reparare automata; de rulat noaptea.
     @ECC_DELIVERY   - urmarirea livrarilor trimise curierilor ECC: la finalizare
                       bonul + incasarea 116/120 (ECCDeliveryUnit); la 5 minute.

   Fiecare job scrie in <folderul de lucru>\<nume>.log; in Event Log ajunge
   doar eroarea (ca la procedurile stocate). *)

interface

uses
  IBC;

var
  // folderul de lucru al serviciului (unde stau settings.dat / tasks.dat)
  ServiceJobsLogDir: string;

function IsServiceJob(const AName: string): Boolean;
// '' = job-ul a rulat (rezultatul e in jurnalul lui); altfel textul erorii
function RunServiceJob(const AName: string; AConn: TIBCConnection; const AUserID: Integer): string;
procedure ServiceJobLog(const AJobName, AText: string);

implementation

uses
  System.SysUtils, System.Classes, System.SyncObjs, System.DateUtils, ECCOnlineFiscalUnit, ECCReconcileUnit, ECCDeliveryUnit;

const
  cKnownJobs: array[0..2] of string = ('@ECC_ONLINE', '@ECC_RECONCILE', '@ECC_DELIVERY');

var
  LogLock: TCriticalSection;

// '@NUME' cu majuscule; numele fara "@" primeste prefixul
function NormalizeJobName(const AName: string): string;
begin
  Result := UpperCase(Trim(AName));
  if not Result.StartsWith('@') then
    Result := '@' + Result;
end;

function IsKnownJob(const AName: string): Boolean;
var
  Job: string;
begin
  for Job in cKnownJobs do
    if NormalizeJobName(AName) = Job then
      Exit(True);
  Result := False;
end;

function IsServiceJob(const AName: string): Boolean;
begin
  Result := Trim(AName).StartsWith('@') or IsKnownJob(AName);
end;

procedure ServiceJobLog(const AJobName, AText: string);
var
  FileName: string;
  F: TextFile;
begin
  if ServiceJobsLogDir = '' then
    Exit;
  FileName := IncludeTrailingPathDelimiter(ServiceJobsLogDir) +
    LowerCase(StringReplace(Trim(AJobName), '@', '', [rfReplaceAll])) + '.log';
  LogLock.Enter;
  try
    try
      AssignFile(F, FileName);
      if FileExists(FileName) then
        Append(F)
      else
        Rewrite(F);
      try
        Writeln(F, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '  ' + AText);
      finally
        CloseFile(F);
      end;
    except
      // jurnalul nu are voie sa opreasca job-ul
    end;
  finally
    LogLock.Leave;
  end;
end;

// Ziua de ieri pe toate casele ECC active; problemele merg in ecc_reconcile.log.
procedure RunECCReconcile(AConn: TIBCConnection; const AJobName: string);
var
  Code: string;
  Res: TECCReconcileResult;
  Row: TECCReconcileRow;
  FromDT, ToDT: TDateTime;
begin
  ToDT := Today;
  FromDT := IncDay(ToDT, -1);
  for Code in ECCActiveApiCodes(AConn) do
    try
      Res := ECCReconcile(AConn, Code, FromDT, ToDT, True);
      ServiceJobLog(AJobName, Res.Summary);
      for Row in Res.Rows do
        if not (Row.Kind in [erkOk, erkInfo]) then
          ServiceJobLog(AJobName, Format('  %s: bon %d, Z %d, %s, ECC %s / WMS %s lei, document %d, %s, id %s',
            [ECCReconcileKindName(Row.Kind), Row.ReceiptNumber, Row.ZNumber,
             FormatDateTime('dd.mm.yyyy hh:nn', Row.DateTime), CurrToStrF(Row.EccTotal, ffFixed, 2),
             CurrToStrF(Row.WmsTotal, ffFixed, 2), Row.DocID, Row.Note, Row.TransId]));
    except
      on E: Exception do
        ServiceJobLog(AJobName, 'EROARE casa ' + Code + ': ' + E.Message);
    end;
end;

function RunServiceJob(const AName: string; AConn: TIBCConnection; const AUserID: Integer): string;
var
  Name: string;
begin
  Result := '';
  Name := NormalizeJobName(AName);
  try
    if Name = '@ECC_ONLINE' then
      RunECCOnlineFiscal(AConn, AUserID,
        procedure(Text: string)
        begin
          ServiceJobLog(Name, Text);
        end)
    else if Name = '@ECC_RECONCILE' then
      RunECCReconcile(AConn, Name)
    else if Name = '@ECC_DELIVERY' then
      ECCProcessDeliveries(AConn, AUserID,
        procedure(Text: string)
        begin
          ServiceJobLog(Name, Text);
        end)
    else
      Result := 'Job necunoscut: ' + AName;
  except
    on E: Exception do
    begin
      Result := Format('Job %s: %s: %s', [Name, E.ClassName, E.Message]);
      ServiceJobLog(Name, 'EROARE ' + Result);
    end;
  end;
end;

initialization
  LogLock := TCriticalSection.Create;

finalization
  LogLock.Free;

end.

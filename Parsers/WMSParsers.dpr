program WMSParsers;

{ WMS Parsers - parserele de preturi de pe site-urile furnizorilor, scoase din WMS.
  Pentru articolele active ale furnizorului (FLG_IN_PRICE = 1):
    PRICE3 = pretul de pe site - TS_CUSTOMER.RRP_DISCOUNT %
  Pretul de vinzare si protectiile ramin in triggerul TS_GOODS_FOREIGN_BIU.

  Joburi (numele din /parser:):
    hitech              preturi h-t.md, furnizor 262735
    maximum             preturi maximum.md, furnizor 229873
    maximum-content     imagini + caracteristici maximum.md -> TS_PRICELIST_ITEMS_IMAGES / _DESCRIPTION
    accent-pricelist    pricelist API Accent Electronic (198)        \
    dmlink-pricelist    pricelist API DMLink (229466)                 |  grupul "pricelists":
    olisgrup-pricelist  pricelist feed Olis Grup (251465)             |  pricelist nou + cele 4
    nex-pricelist       pricelist API NexDistribution (275640)        |  reevaluari (ca in WMS)
    triomac-pricelist   pricelist API SCOP - Triomac (209280)        /   + imaginile (DMLink, Nex)
  Un job nou: vezi antetul din ParserRunnerUnit.

  Joburile alese ruleaza IN PARALEL, fiecare in firul lui, cu conexiunea lui la baza.
  Inchiderile reevaluarilor (CLOSE_REEVALUARE) trec pe rind intre joburi.

  Fara parametri: fereastra (alegi parserele, Ruleaza / Stop, jurnal pe ecran).

  Mod automat, fara fereastra (Windows Task Scheduler):
    WMSParsers.exe /auto /parser:all
    WMSParsers.exe /auto /parser:hitech,maximum
    WMSParsers.exe /auto /parser:maximum-content
    WMSParsers.exe /auto /parser:pricelists          (de 2 ori pe zi, 09:00 si 14:00 -
                                                      vezi install-pricelist-task.ps1)

  Parametri optionali (valabili si pentru fereastra, ca valori initiale):
    /server:ADRESA   serverul Firebird (implicit cel din SWNConst)
    /user:ID         utilizatorul WMS in numele caruia se scrie (implicit 204)
    /mode:direct     UPDATE direct pe TS_GOODS_FOREIGN.PRICE3 (implicit)
    /mode:reeval     reevaluare noua (DOCTYPEID 1414) + CLOSE_REEVALUARE
                     (cere DB Model\site_price_reevaluation.sql rulat pe baza)
    /firma:ID        firma reevaluarii (doar /mode:reeval; implicit 307225)
    /delay:MS        pauza intre cererile catre site (implicit: cea a parserului)
    /log:DOSAR       dosarul jurnalelor (implicit "logs" linga exe); un fisier pe zi per parser
    /firma:ID        si firma reevaluarilor joburilor de pricelist (implicit 307225)
    /images:no       joburile de pricelist: fara descarcarea imaginilor
    /reevaluare:no   joburile de pricelist: doar pricelistul, fara cele 4 reevaluari
    /reevaluare:test joburile de pricelist: reevaluarile se fac pina la CLOSE_REEVALUARE inclusiv,
                     apoi se anuleaza (ROLLBACK) - verificare fara efect asupra preturilor
    /telegram:no     fara notificari Telegram. Implicit, la sfirsitul fiecarei rulari: rezultatul
                     joburilor de pret -> canalul PRICELISTS ("Online :: Fantastic"), erorile si
                     site-urile suspecte -> ERRORS (prin TELEGRAM_MESSAGES, trimise de SWNService;
                     DB Model	elegram_channel_pricelists.sql)

  Cod de iesire in modul automat: 0 = toate parserele au rulat; 1 = cel putin o eroare;
  2 = un site nu a raspuns cum trebuie (sub jumatate din articole gasite) si nu s-a scris nimic. }

uses
  Vcl.Forms,
  System.SysUtils,
  System.Classes,
  Winapi.ActiveX,
  IBC,
  SWNConst in '..\sources\SWNConst.pas',
  SupplierPriceSyncUnit in 'SupplierPriceSyncUnit.pas',
  HiTechScraperUnit in 'HiTechScraperUnit.pas',
  HiTechPriceSourceUnit in 'HiTechPriceSourceUnit.pas',
  MaximumPriceSourceUnit in 'MaximumPriceSourceUnit.pas',
  ParserJobUnit in 'ParserJobUnit.pas',
  MaximumContentUnit in 'MaximumContentUnit.pas',
  ApiAccentUnit in '..\sources\Tools\ApiAccent\ApiAccentUnit.pas',
  MamicoContentUnit in '..\sources\frameUtils\78 - Pricelist\MamicoContentUnit.pas',
  PriceListContentTransferUnit in '..\sources\frameUtils\78 - Pricelist\PriceListContentTransferUnit.pas',
  B2B.DMLinkPriceListImport in '..\sources\b2b.api\dmlink\B2B.DMLinkPriceListImport.pas',
  NexDistributionUnit in '..\sources\frameUtils\78 - Pricelist\NexDistributionUnit.pas',
  TriomacPriceListUnit in '..\sources\frameUtils\78 - Pricelist\TriomacPriceListUnit.pas',
  OlisGrupContentUnit in '..\sources\b2b.api\Muncitorul\OlisGrupContentUnit.pas',
  OlisGrupPriceListUnit in 'OlisGrupPriceListUnit.pas',
  PriceListReevaluationUnit in 'PriceListReevaluationUnit.pas',
  PriceListApiJobsUnit in 'PriceListApiJobsUnit.pas',
  ParserRunnerUnit in 'ParserRunnerUnit.pas',
  ParsersMainFormUnit in 'ParsersMainFormUnit.pas' {frmParsersMain};

{$R *.res}

// Parserele cerute prin /parser: ("all", "pricelists" sau lista separata prin virgula)
function RequestedParsers(out AUnknown: string): TArray<TParserJobClass>;
begin
  Result := ExpandParserNames(CommandLineValue('parser', 'all'), AUnknown);
end;

procedure RunAuto;
var
  Options: TParserRunOptions;
  Parsers: TArray<TParserJobClass>;
  Outcomes: TArray<TParserJobOutcome>;
  Unknown: string;
  MainLog: TParserFileLog;
  LogLock: TObject;
  I: Integer;
begin
  Options := TParserRunOptions.Defaults;
  Options.ReadCommandLine;
  MainLog := TParserFileLog.Create(Options.LogDir, 'wmsparsers');
  LogLock := TObject.Create;
  try
    try
      Parsers := RequestedParsers(Unknown);
      if Unknown <> '' then
      begin
        MainLog.Write('Parsere necunoscute in /parser: ' + Unknown);
        ExitCode := 1;
      end;
      if Length(Parsers) = 0 then
      begin
        MainLog.Write('Niciun parser de rulat.');
        ExitCode := 1;
        Exit;
      end;

      MainLog.Write(Format('Start: %d job(uri) in paralel, server %s.', [Length(Parsers), Options.Server]));
      // fiecare job isi scrie jurnalul lui; in cel comun doar inceputul / sfirsitul fiecaruia
      Outcomes := RunParserJobsParallel(Parsers, Options, nil,
        procedure(AJob: TParserJob)
        begin
          System.TMonitor.Enter(LogLock);
          try
            MainLog.Write('Pornit ' + AJob.JobName);
          finally
            System.TMonitor.Exit(LogLock);
          end;
        end,
        nil, nil);

      for I := 0 to High(Outcomes) do
        if Outcomes[I].Error <> '' then
        begin
          MainLog.Write(Outcomes[I].JobClass.JobName + ': EROARE ' + Outcomes[I].Error);
          ExitCode := 1;
        end
        else
        begin
          MainLog.Write(Outcomes[I].JobClass.JobName + ': ' + Outcomes[I].JobResult.Summary);
          if Outcomes[I].JobResult.SiteSuspect and (ExitCode = 0) then
            ExitCode := 2;
        end;
    except
      on E: Exception do
      begin
        MainLog.Write('EROARE: ' + E.ClassName + ': ' + E.Message);
        ExitCode := 1;
      end;
    end;
  finally
    LogLock.Free;
    MainLog.Free;
  end;
end;

begin
  if FindCmdLineSwitch('auto', ['/', '-'], True) then
  begin
    CoInitialize(nil);
    try
      RunAuto;
    finally
      CoUninitialize;
    end;
    Exit;
  end;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'WMS Parsers';
  Application.CreateForm(TfrmParsersMain, frmParsersMain);
  Application.Run;
end.

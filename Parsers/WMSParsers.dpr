program WMSParsers;

{ WMS Parsers - parserele de preturi de pe site-urile furnizorilor, scoase din WMS.
  Pentru articolele active ale furnizorului (FLG_IN_PRICE = 1):
    PRICE3 = pretul de pe site - TS_CUSTOMER.RRP_DISCOUNT %
  Pretul de vinzare si protectiile ramin in triggerul TS_GOODS_FOREIGN_BIU.

  Joburi (numele din /parser:):
    hitech           preturi h-t.md, furnizor 262735
    maximum          preturi maximum.md, furnizor 229873
    maximum-content  imagini + caracteristici maximum.md -> TS_PRICELIST_ITEMS_IMAGES / _DESCRIPTION
  Un job nou: vezi antetul din ParserRunnerUnit.

  Fara parametri: fereastra (alegi parserele, Ruleaza / Stop, jurnal pe ecran).

  Mod automat, fara fereastra (Windows Task Scheduler):
    WMSParsers.exe /auto /parser:all
    WMSParsers.exe /auto /parser:hitech,maximum
    WMSParsers.exe /auto /parser:maximum-content

  Parametri optionali (valabili si pentru fereastra, ca valori initiale):
    /server:ADRESA   serverul Firebird (implicit cel din SWNConst)
    /user:ID         utilizatorul WMS in numele caruia se scrie (implicit 204)
    /mode:direct     UPDATE direct pe TS_GOODS_FOREIGN.PRICE3 (implicit)
    /mode:reeval     reevaluare noua (DOCTYPEID 1414) + CLOSE_REEVALUARE
                     (cere DB Model\site_price_reevaluation.sql rulat pe baza)
    /firma:ID        firma reevaluarii (doar /mode:reeval; implicit 307225)
    /delay:MS        pauza intre cererile catre site (implicit: cea a parserului)
    /log:DOSAR       dosarul jurnalelor (implicit "logs" linga exe); un fisier pe zi per parser

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
  ParserRunnerUnit in 'ParserRunnerUnit.pas',
  ParsersMainFormUnit in 'ParsersMainFormUnit.pas' {frmParsersMain};

{$R *.res}

// Parserele cerute prin /parser: ("all" sau lista separata prin virgula)
function RequestedParsers(out AUnknown: string): TArray<TParserJobClass>;
var
  Names: TStringList;
  I: Integer;
  C: TParserJobClass;
  Value: string;
begin
  AUnknown := '';
  Value := CommandLineValue('parser', 'all');
  if SameText(Value, 'all') then
    Exit(ParserJobs);
  Result := nil;
  Names := TStringList.Create;
  try
    Names.CommaText := Value;
    for I := 0 to Names.Count - 1 do
    begin
      C := FindParserJob(Trim(Names[I]));
      if C = nil then
        AUnknown := Trim(AUnknown + ' ' + Names[I])
      else
        Result := Result + [C];
    end;
  finally
    Names.Free;
  end;
end;

procedure RunAuto;
var
  Options: TParserRunOptions;
  Parsers: TArray<TParserJobClass>;
  C: TParserJobClass;
  Connection: TIBCConnection;
  JobResult: TParserJobResult;
  Unknown: string;
  MainLog: TParserFileLog;
begin
  Options := TParserRunOptions.Defaults;
  Options.ReadCommandLine;
  MainLog := TParserFileLog.Create(Options.LogDir, 'wmsparsers');
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

      Connection := CreateParserConnection(Options.Server);
      try
        for C in Parsers do
          try
            JobResult := RunParserJob(Connection, C, Options, nil);
            if JobResult.SiteSuspect and (ExitCode = 0) then
              ExitCode := 2;
          except
            // detaliile sint in jurnalul parserului; continuam cu urmatorul
            on E: Exception do
            begin
              MainLog.Write(C.JobName + ': ' + E.Message);
              ExitCode := 1;
            end;
          end;
      finally
        Connection.Free;
      end;
    except
      on E: Exception do
      begin
        MainLog.Write('EROARE: ' + E.ClassName + ': ' + E.Message);
        ExitCode := 1;
      end;
    end;
  finally
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

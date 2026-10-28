program WMSPriceWatch;

{ WMS PriceWatch - monitorizarea preturilor concurentilor (xstore.md, neocomputer.md,
  geek.md, ... - lista in TWEB_COMPETITOR_SITES).

  Programul ruleaza non-stop: parcurge categoriile monitorizate (TWEB_COMPETITOR_CATEGORIES,
  legate de TWEB_CATALOG) pe fiecare site, cu pauze intre cereri (rotatie User-Agent,
  proxy optional), extrage produsele si preturile cu regex-urile din baza, le asociaza
  automat cu produsele noastre active de pe site si pastreaza istoricul. O data la
  REPORT_INTERVAL_MIN minute (implicit 180 = 3 ore) face un Excel si il trimite in
  Telegram, canalul PRICELISTS ("Online :: Fantastic").

  Schema: DB Model\competitor_prices.sql. Configurare: TS_API_CONFIG, API_CODE = COMPETITORS.

  Pornire:
    WMSPriceWatch.exe                 - dialog de autentificare WMS (CAN_USER_LOGIN2), apoi fereastra;
                                        monitorul se porneste cu butonul Start
    WMSPriceWatch.exe /auto           - fara autentificare (contul tehnic din SWNConst), monitorul
                                        porneste singur - pentru pornirea automata cu Windows
    /server:ADRESA                    - serverul Firebird (implicit cel din SWNConst)
    /report:N                         - primul raport la N minute dupa pornire (implicit: la
                                        REPORT_INTERVAL_MIN de la ultimul raport trimis)

  Interfata foloseste aceleasi biblioteci ca WMS (DevExpress, IBDAC, DialogTitle) si acelasi
  stil de forme (Prepare / IsFormDataPosted / WhenCancelForm din PWBaseFormUnit). }

uses
  Vcl.Forms,
  System.SysUtils,
  System.UITypes,
  Vcl.Dialogs,
  SWNConst in '..\sources\SWNConst.pas',
  SWNSecurityUtils in '..\sources\classes\Security\SWNSecurityUtils.pas',
  wms_md5hash in '..\sources\wms_md5hash.pas',
  TelegramApiUnit in '..\sources\Utils\TelegramApiUnit.pas',
  PWTypes in 'PWTypes.pas',
  PWDbUnit in 'PWDbUnit.pas',
  PWHttpUnit in 'PWHttpUnit.pas',
  PWParserUnit in 'PWParserUnit.pas',
  PWMatchUnit in 'PWMatchUnit.pas',
  PWMonitorThread in 'PWMonitorThread.pas',
  PWReportUnit in 'PWReportUnit.pas',
  PWBaseFormUnit in 'PWBaseFormUnit.pas',
  PWLoginDialog in 'PWLoginDialog.pas' {frmPWLoginDlg},
  PWSitesDialog in 'PWSitesDialog.pas' {frmPWSitesDlg},
  PWCategoriesDialog in 'PWCategoriesDialog.pas' {frmPWCategoriesDlg},
  PWMainFormUnit in 'PWMainFormUnit.pas' {frmPWMain};

{$R *.res}

var
  Conn: TPWConnParams;
  AutoMode: Boolean;

function CommandLineValue(const AName, ADefault: string): string;
var
  I: Integer;
  P: string;
begin
  Result := ADefault;
  for I := 1 to ParamCount do
  begin
    P := ParamStr(I);
    if (Length(P) > 1) and CharInSet(P[1], ['/', '-']) and SameText(Copy(P, 2, Length(AName) + 1), AName + ':') then
      Exit(Copy(P, Length(AName) + 3, MaxInt));
  end;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'WMS PriceWatch';

  Conn := Default(TPWConnParams);
  Conn.Server := CommandLineValue('server', cDATABASE_ConnectionServerDefault);
  Conn.Port := cDATABASE_ConnectionPortDefault;
  Conn.Database := cDATABASE_DBName;
  Conn.User := cDATABASE_UserLogin_UserName;
  Conn.Password := cDATABASE_UserLogin_UserPassword;

  AutoMode := FindCmdLineSwitch('auto', ['/', '-'], True);
  if AutoMode then
  begin
    Conn.UserID := 0;
    Conn.UserName := 'auto';
  end
  else if not PWLogin(Conn) then
    Exit;

  Application.CreateForm(TfrmPWMain, frmPWMain);
  frmPWMain.Setup(Conn, AutoMode, StrToIntDef(CommandLineValue('report', '0'), 0));
  Application.Run;
end.

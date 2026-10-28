unit PWMainFormUnit;

{ WMSPriceWatch - fereastra principala: Start / Stop monitor, starea curenta, raportul
  la cerere, setarile (site-uri, categorii), grid-urile cu rezumatul (SP_COMPETITOR_SUMMARY),
  produsele gasite la concurenti (cu asociere manuala) si jurnalul scanarilor.

  Raportul Excel + Telegram se face de aici (firul principal, VCL): la fiecare secunda
  tmTick verifica daca a venit ora (REPORT_INTERVAL_MIN de la ultimul raport). }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, DBAccess, IBC, MemDS, PWBaseFormUnit, DialogTitle,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxClasses, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxGridCustomView, cxGrid, cxButtons, cxCheckBox, dxScrollbarAnnotations,
  dxDateRanges, PWTypes, PWDbUnit, PWMonitorThread;

type
  TfrmPWMain = class(TPWCustomForm)
    dtDialogTitle: TDialogTitle;
    pnToolbar: TPanel;
    btnStart: TcxButton;
    btnStop: TcxButton;
    btnReportNow: TcxButton;
    btnSites: TcxButton;
    btnCategories: TcxButton;
    btnRefresh: TcxButton;
    lbState: TLabel;
    lbNextReport: TLabel;
    pcMain: TPageControl;
    tsSummary: TTabSheet;
    pnSummaryTop: TPanel;
    lbSummaryInfo: TLabel;
    cxGridSummary: TcxGrid;
    cxGridSummaryTable: TcxGridDBTableView;
    cxGridSummaryLevel: TcxGridLevel;
    colS_CAT_TITLE: TcxGridDBColumn;
    colS_GOODSID: TcxGridDBColumn;
    colS_CODE: TcxGridDBColumn;
    colS_TITLE: TcxGridDBColumn;
    colS_OUR_PRICE: TcxGridDBColumn;
    colS_MIN_PRICE: TcxGridDBColumn;
    colS_MIN_SITE: TcxGridDBColumn;
    colS_DIFF_LEI: TcxGridDBColumn;
    colS_DIFF_PCT: TcxGridDBColumn;
    colS_SITES_CNT: TcxGridDBColumn;
    tsItems: TTabSheet;
    pnItemsTop: TPanel;
    lbSite: TLabel;
    cbSite: TComboBox;
    lbCategory: TLabel;
    cbCategory: TComboBox;
    chkUnmatched: TCheckBox;
    btnItemsRefresh: TcxButton;
    btnMatchManual: TcxButton;
    btnReject: TcxButton;
    btnResetAuto: TcxButton;
    btnOpenUrl: TcxButton;
    cxGridItems: TcxGrid;
    cxGridItemsTable: TcxGridDBTableView;
    cxGridItemsLevel: TcxGridLevel;
    colI_SITE_CODE: TcxGridDBColumn;
    colI_CAT_TITLE: TcxGridDBColumn;
    colI_TITLE: TcxGridDBColumn;
    colI_PRICE: TcxGridDBColumn;
    colI_OLD_PRICE: TcxGridDBColumn;
    colI_PREV_PRICE: TcxGridDBColumn;
    colI_FLG_IN_STOCK: TcxGridDBColumn;
    colI_GOODSID: TcxGridDBColumn;
    colI_OUR_TITLE: TcxGridDBColumn;
    colI_MATCH_NAME: TcxGridDBColumn;
    colI_MATCH_SCORE: TcxGridDBColumn;
    colI_LAST_SEEN: TcxGridDBColumn;
    colI_LAST_PRICE_CHANGE: TcxGridDBColumn;
    colI_MATCH_KEY: TcxGridDBColumn;
    colI_OUR_PRICE: TcxGridDBColumn;
    colI_DIFF_LEI: TcxGridDBColumn;
    tsScans: TTabSheet;
    cxGridScans: TcxGrid;
    cxGridScansTable: TcxGridDBTableView;
    cxGridScansLevel: TcxGridLevel;
    colSC_STARTED: TcxGridDBColumn;
    colSC_FINISHED: TcxGridDBColumn;
    colSC_SITE_CODE: TcxGridDBColumn;
    colSC_CAT_TITLE: TcxGridDBColumn;
    colSC_PAGES: TcxGridDBColumn;
    colSC_ITEMS_FOUND: TcxGridDBColumn;
    colSC_ITEMS_NEW: TcxGridDBColumn;
    colSC_PRICE_CHANGES: TcxGridDBColumn;
    colSC_STATUS_NAME: TcxGridDBColumn;
    colSC_ERROR_TEXT: TcxGridDBColumn;
    tsLog: TTabSheet;
    mmLog: TMemo;
    pnHidden: TPanel;
    tmTick: TTimer;
    IBCConnection: TIBCConnection;
    IBCTransactionRead: TIBCTransaction;
    IBCQuerySummary: TIBCQuery;
    IBCDataSourceSummary: TIBCDataSource;
    IBCQueryItems: TIBCQuery;
    IBCDataSourceItems: TIBCDataSource;
    IBCQueryScans: TIBCQuery;
    IBCDataSourceScans: TIBCDataSource;
    cxStyleRepository: TcxStyleRepository;
    stRed: TcxStyle;
    stGreen: TcxStyle;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnReportNowClick(Sender: TObject);
    procedure btnSitesClick(Sender: TObject);
    procedure btnCategoriesClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnItemsRefreshClick(Sender: TObject);
    procedure btnMatchManualClick(Sender: TObject);
    procedure btnRejectClick(Sender: TObject);
    procedure btnResetAutoClick(Sender: TObject);
    procedure btnOpenUrlClick(Sender: TObject);
    procedure tmTickTimer(Sender: TObject);
    procedure cxGridSummaryTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxGridItemsTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure pcMainChange(Sender: TObject);
  private
    FConn: TPWConnParams;
    FAutoMode: Boolean;
    FReportAfterMin: Integer;
    FDb: TPWDb;
    FThread: TPWMonitorThread;
    FConfig: TPWConfig;
    FNextReport: TDateTime;
    FLastReport: TDateTime;
    FReportBusy: Boolean;
    FSiteIDs: TArray<Integer>;
    FCatIDs: TArray<Integer>;
    procedure AddLog(const AMessage: string);
    procedure WriteLogFile(const ALine: string);
    procedure OnMonitorState(const AState: TPWMonitorState);
    procedure StartMonitor;
    procedure StopMonitor;
    procedure DoReport(AManual: Boolean);
    procedure ScheduleNextReport;
    procedure OpenSummary;
    procedure OpenItems;
    procedure OpenScans;
    procedure FillFilters;
    procedure SetItemMatch(AGoodsID, AMatchType: Integer);
    function MonitorRunning: Boolean;
    procedure UpdateButtons;
  public
    // AReportAfterMin > 0: primul raport la atitea minute dupa pornire (/report:N), nu dupa ultimul raport din baza
    procedure Setup(const AConn: TPWConnParams; AAutoMode: Boolean; AReportAfterMin: Integer = 0);
  end;

var
  frmPWMain: TfrmPWMain;

implementation

uses
  System.UITypes, System.DateUtils, System.StrUtils, System.Math, System.IOUtils, System.Variants, Winapi.ShellAPI,
  PWReportUnit, PWSitesDialog, PWCategoriesDialog;

{$R *.dfm}

{ TfrmPWMain }

procedure TfrmPWMain.Setup(const AConn: TPWConnParams; AAutoMode: Boolean; AReportAfterMin: Integer);
begin
  FConn := AConn;
  FAutoMode := AAutoMode;
  FReportAfterMin := AReportAfterMin;
  Caption := cPWAppTitle;
  dtDialogTitle.Title := 'Monitorizarea preturilor concurentilor';
  dtDialogTitle.Text := Format('Server %s:%s, utilizator %s. Monitorul parcurge site-urile non-stop; raportul Excel pleaca in Telegram la fiecare %d minute.',
    [FConn.Server, FConn.Database, IfThen(FConn.UserName = '', 'tehnic', FConn.UserName), 180]);

  IBCConnection.Options.Charset := 'UTF8';
  IBCConnection.Options.UseUnicode := True;
  IBCConnection.Options.EnableMemos := True;
  IBCConnection.ClientLibrary := 'fbclient.dll';
  IBCConnection.LoginPrompt := False;
  IBCConnection.Database := Format('%s/%d:%s', [FConn.Server, FConn.Port, FConn.Database]);
  IBCConnection.Username := FConn.User;
  IBCConnection.Password := FConn.Password;
  try
    IBCConnection.Connected := True;
  except
    on E: Exception do
    begin
      MessageDlg('Nu ma pot conecta la baza de date: ' + E.Message, mtError, [mbOK], 0);
      Application.Terminate;
      Exit;
    end;
  end;
  FDb := TPWDb.Create(IBCConnection, False);
  try
    FConfig := FDb.LoadConfig;
  except
    on E: Exception do
    begin
      MessageDlg('Nu pot citi configurarea (TS_API_CONFIG / COMPETITORS). A fost rulat DB Model\competitor_prices.sql?' +
        sLineBreak + E.Message, mtError, [mbOK], 0);
      Application.Terminate;
      Exit;
    end;
  end;
  dtDialogTitle.Text := Format('Server %s:%s, utilizator %s. Monitorul parcurge site-urile non-stop; raportul Excel pleaca in Telegram (canalul %s) la fiecare %d minute.',
    [FConn.Server, FConn.Database, IfThen(FConn.UserName = '', 'tehnic', FConn.UserName), FConfig.TelegramChannel,
     FConfig.ReportIntervalMin]);

  AddLog(Format('Pornit. Utilizator %s (%d), server %s. Interval raport %d min, pauza intre cicluri %d min, scor minim %.1f, proxy %s.',
    [FConn.UserName, FConn.UserID, FConn.Server, FConfig.ReportIntervalMin, FConfig.CyclePauseMin, FConfig.MinScore,
     IfThen(FConfig.ProxyUrl = '', 'nu', 'da')]));

  FillFilters;
  OpenSummary;
  OpenItems;
  OpenScans;
  pcMain.ActivePage := tsLog;
  UpdateButtons;
  tmTick.Enabled := True;
  if FAutoMode then
    StartMonitor;
end;

procedure TfrmPWMain.FormDestroy(Sender: TObject);
begin
  tmTick.Enabled := False;
  if Assigned(FThread) then
  begin
    FThread.Stop;
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;
  FreeAndNil(FDb);
end;

procedure TfrmPWMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  if MonitorRunning then
  begin
    CanClose := MessageDlg('Monitorul ruleaza. Il opriti si inchideti programul?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    if CanClose then
      StopMonitor;
  end;
end;

{ jurnal }

procedure TfrmPWMain.WriteLogFile(const ALine: string);
var
  Dir, FileName: string;
  W: TStreamWriter;
begin
  try
    Dir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'logs';
    ForceDirectories(Dir);
    FileName := IncludeTrailingPathDelimiter(Dir) + 'pricewatch_' + FormatDateTime('yyyymmdd', Date) + '.log';
    W := TStreamWriter.Create(FileName, True, TEncoding.UTF8);
    try
      W.WriteLine(ALine);
    finally
      W.Free;
    end;
  except
    // jurnalul pe disc nu trebuie sa opreasca programul
  end;
end;

procedure TfrmPWMain.AddLog(const AMessage: string);
var
  Line: string;
begin
  Line := FormatDateTime('dd.mm hh:nn:ss', Now) + '  ' + AMessage;
  if mmLog.Lines.Count > 5000 then
    mmLog.Lines.Clear;
  mmLog.Lines.Add(Line);
  WriteLogFile(Line);
end;

{ monitor }

function TfrmPWMain.MonitorRunning: Boolean;
begin
  Result := Assigned(FThread) and not FThread.Finished;
end;

procedure TfrmPWMain.UpdateButtons;
begin
  btnStart.Enabled := not MonitorRunning;
  btnStop.Enabled := MonitorRunning;
  btnReportNow.Enabled := not FReportBusy;
end;

procedure TfrmPWMain.OnMonitorState(const AState: TPWMonitorState);
begin
  if AState.Running then
  begin
    if AState.CurrentSite <> '' then
      lbState.Caption := Format('Ciclul %d: %s / %s, pagina %d  |  cereri %d, erori %d',
        [AState.CycleNo, AState.CurrentSite, AState.CurrentCategory, AState.CurrentPage, AState.Requests, AState.Errors])
    else if AState.LastCycleEnd > 0 then
      lbState.Caption := Format('Ciclul %d terminat la %s; pauza pina la urmatorul  |  cereri %d, erori %d',
        [AState.CycleNo, FormatDateTime('hh:nn', AState.LastCycleEnd), AState.Requests, AState.Errors])
    else
      lbState.Caption := Format('Ciclul %d porneste...', [AState.CycleNo]);
  end
  else
    lbState.Caption := 'Monitorul este oprit.';
  UpdateButtons;
end;

procedure TfrmPWMain.ScheduleNextReport;
var
  Q: TIBCQuery;
  Last: TDateTime;
begin
  // de la ultimul raport trimis (TWEB_COMPETITOR_REPORTS), dar nu mai devreme de 10 min de acum
  Last := 0;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := IBCConnection;
    Q.Transaction := IBCTransactionRead;
    Q.SQL.Text := 'SELECT MAX(CREATED) FROM TWEB_COMPETITOR_REPORTS WHERE FLG_SENT = 1';
    Q.Open;
    if not Q.Fields[0].IsNull then
      Last := Q.Fields[0].AsDateTime;
    Q.Close;
    if IBCTransactionRead.Active then
      IBCTransactionRead.Commit;
  finally
    Q.Free;
  end;
  FLastReport := Last;
  if Last > 0 then
    FNextReport := Max(IncMinute(Last, FConfig.ReportIntervalMin), IncMinute(Now, 10))
  else
    FNextReport := IncMinute(Now, FConfig.ReportIntervalMin);
  lbNextReport.Caption := 'Urmatorul raport: ' + FormatDateTime('dd.mm hh:nn', FNextReport);
end;

procedure TfrmPWMain.StartMonitor;
begin
  if MonitorRunning then
    Exit;
  if Assigned(FThread) then
    FreeAndNil(FThread);
  FConfig := FDb.LoadConfig;
  FThread := TPWMonitorThread.Create(FConn, AddLog, OnMonitorState);
  FThread.Start;
  ScheduleNextReport;
  if FReportAfterMin > 0 then
  begin
    FNextReport := IncMinute(Now, FReportAfterMin);
    lbNextReport.Caption := 'Urmatorul raport: ' + FormatDateTime('dd.mm hh:nn', FNextReport);
    FReportAfterMin := 0;
  end;
  AddLog('Monitor pornit. Urmatorul raport: ' + FormatDateTime('dd.mm hh:nn', FNextReport));
  UpdateButtons;
end;

procedure TfrmPWMain.StopMonitor;
var
  T0: TDateTime;
begin
  if not Assigned(FThread) then
    Exit;
  AddLog('Oprire monitor...');
  FThread.Stop;
  T0 := Now;
  while (not FThread.Finished) and (SecondsBetween(Now, T0) < 60) do
  begin
    Application.ProcessMessages;
    Sleep(100);
  end;
  if FThread.Finished then
  begin
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;
  lbNextReport.Caption := '';
  UpdateButtons;
end;

procedure TfrmPWMain.btnStartClick(Sender: TObject);
begin
  StartMonitor;
end;

procedure TfrmPWMain.btnStopClick(Sender: TObject);
begin
  StopMonitor;
end;

procedure TfrmPWMain.tmTickTimer(Sender: TObject);
begin
  if MonitorRunning and (not FReportBusy) and (FNextReport > 0) and (Now >= FNextReport) then
    DoReport(False);
  if Assigned(FThread) and FThread.Finished and btnStop.Enabled then
    UpdateButtons;
end;

{ raport }

procedure TfrmPWMain.DoReport(AManual: Boolean);
var
  Info: TPWReportInfo;
  Err: string;
  Hours: Double;
begin
  if FReportBusy then
    Exit;
  FReportBusy := True;
  UpdateButtons;
  Screen.Cursor := crHourGlass;
  try
    try
      FConfig := FDb.LoadConfig;
      if FLastReport > 0 then
        Hours := Max(1, HoursBetween(Now, FLastReport))
      else
        Hours := FConfig.ReportIntervalMin / 60;
      AddLog(Format('Raport %s: construiesc Excel-ul (schimbari din ultimele %.0f h)...', [IfThen(AManual, 'manual', 'programat'), Hours]));
      Info := PWBuildReport(FDb, pnHidden, FConfig.ReportDir, Hours);
      AddLog(Format('Excel: %s (%d produse ale noastre, %d cu concurenta, %d mai scumpi, %d mai ieftini, %d schimbari, %d neasociate)',
        [Info.FileName, Info.OurGoods, Info.WithCompetition, Info.MoreExpensive, Info.Cheaper, Info.Changes, Info.Unmatched]));
      if PWSendReport(FDb, FConfig, Info, Hours, Err) then
      begin
        AddLog(Format('Trimis in Telegram, canalul %s.', [FConfig.TelegramChannel]));
        FLastReport := Now;
      end
      else
        AddLog('Telegram: NU s-a trimis - ' + Err);
    except
      on E: Exception do
        AddLog('Raport: EROARE ' + E.ClassName + ': ' + E.Message);
    end;
  finally
    Screen.Cursor := crDefault;
    FReportBusy := False;
    FNextReport := IncMinute(Now, FConfig.ReportIntervalMin);
    if MonitorRunning then
      lbNextReport.Caption := 'Urmatorul raport: ' + FormatDateTime('dd.mm hh:nn', FNextReport);
    UpdateButtons;
  end;
end;

procedure TfrmPWMain.btnReportNowClick(Sender: TObject);
begin
  DoReport(True);
end;

{ setari }

procedure TfrmPWMain.btnSitesClick(Sender: TObject);
var
  Dlg: TfrmPWSitesDlg;
begin
  Dlg := TfrmPWSitesDlg.Create(Self, IBCConnection);
  try
    Dlg.GlobalProxy := FConfig.ProxyUrl;
    if Dlg.ShowModal = mrOk then
      AddLog('Site-urile au fost modificate; monitorul le reciteste la urmatorul ciclu.');
  finally
    Dlg.Free;
  end;
  FillFilters;
end;

procedure TfrmPWMain.btnCategoriesClick(Sender: TObject);
var
  Dlg: TfrmPWCategoriesDlg;
begin
  Dlg := TfrmPWCategoriesDlg.Create(Self, IBCConnection);
  try
    if Dlg.ShowModal = mrOk then
      AddLog('Categoriile au fost modificate; monitorul le reciteste la urmatorul ciclu.');
  finally
    Dlg.Free;
  end;
  FillFilters;
end;

{ grid-uri }

procedure TfrmPWMain.FillFilters;
var
  Sites: TArray<TPWSite>;
  Cats: TArray<TPWCategory>;
  I, OldSite, OldCat: Integer;
begin
  OldSite := cbSite.ItemIndex;
  OldCat := cbCategory.ItemIndex;
  Sites := FDb.LoadSites(False);
  Cats := FDb.LoadCategories(False);
  cbSite.Items.BeginUpdate;
  cbCategory.Items.BeginUpdate;
  try
    cbSite.Items.Clear;
    cbSite.Items.Add('(toate site-urile)');
    SetLength(FSiteIDs, Length(Sites) + 1);
    FSiteIDs[0] := 0;
    for I := 0 to High(Sites) do
    begin
      cbSite.Items.Add(Sites[I].SiteCode);
      FSiteIDs[I + 1] := Sites[I].SiteID;
    end;
    cbCategory.Items.Clear;
    cbCategory.Items.Add('(toate categoriile)');
    SetLength(FCatIDs, Length(Cats) + 1);
    FCatIDs[0] := 0;
    for I := 0 to High(Cats) do
    begin
      cbCategory.Items.Add(Cats[I].Title);
      FCatIDs[I + 1] := Cats[I].CatID;
    end;
  finally
    cbSite.Items.EndUpdate;
    cbCategory.Items.EndUpdate;
  end;
  cbSite.ItemIndex := IfThen((OldSite >= 0) and (OldSite < cbSite.Items.Count), OldSite, 0);
  cbCategory.ItemIndex := IfThen((OldCat >= 0) and (OldCat < cbCategory.Items.Count), OldCat, 0);
end;

procedure TfrmPWMain.OpenSummary;
begin
  Screen.Cursor := crHourGlass;
  try
    IBCQuerySummary.Close;
    IBCQuerySummary.Connection := IBCConnection;
    IBCQuerySummary.Transaction := IBCTransactionRead;
    IBCQuerySummary.Open;
    lbSummaryInfo.Caption := Format('%d produse ale noastre in categoriile active (actualizat %s). Rosu = sintem mai scumpi decit cel mai mic pret gasit, verde = mai ieftini.',
      [IBCQuerySummary.RecordCount, FormatDateTime('hh:nn', Now)]);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPWMain.OpenItems;
var
  SiteID, CatID: Integer;
begin
  SiteID := 0;
  CatID := 0;
  if (cbSite.ItemIndex > 0) and (cbSite.ItemIndex <= High(FSiteIDs)) then
    SiteID := FSiteIDs[cbSite.ItemIndex];
  if (cbCategory.ItemIndex > 0) and (cbCategory.ItemIndex <= High(FCatIDs)) then
    CatID := FCatIDs[cbCategory.ItemIndex];
  IBCQueryItems.Close;
  IBCQueryItems.Connection := IBCConnection;
  IBCQueryItems.Transaction := IBCTransactionRead;
  // acelasi parametru de doua ori in SQL nu merge (IBDAC trimite 3 valori, serverul asteapta 5)
  IBCQueryItems.ParamByName('SITEID1').AsInteger := SiteID;
  IBCQueryItems.ParamByName('SITEID2').AsInteger := SiteID;
  IBCQueryItems.ParamByName('CATID1').AsInteger := CatID;
  IBCQueryItems.ParamByName('CATID2').AsInteger := CatID;
  IBCQueryItems.ParamByName('UNM').AsInteger := Ord(chkUnmatched.Checked);
  IBCQueryItems.Open;
end;

procedure TfrmPWMain.OpenScans;
begin
  IBCQueryScans.Close;
  IBCQueryScans.Connection := IBCConnection;
  IBCQueryScans.Transaction := IBCTransactionRead;
  IBCQueryScans.Open;
end;

procedure TfrmPWMain.btnRefreshClick(Sender: TObject);
begin
  if IBCTransactionRead.Active then
  begin
    IBCQuerySummary.Close;
    IBCQueryItems.Close;
    IBCQueryScans.Close;
    IBCTransactionRead.Commit;
  end;
  FConfig := FDb.LoadConfig;
  OpenSummary;
  OpenItems;
  OpenScans;
end;

procedure TfrmPWMain.pcMainChange(Sender: TObject);
begin
  if pcMain.ActivePage = tsScans then
    OpenScans
  else if pcMain.ActivePage = tsItems then
    OpenItems;
end;

procedure TfrmPWMain.btnItemsRefreshClick(Sender: TObject);
begin
  OpenItems;
end;

procedure TfrmPWMain.SetItemMatch(AGoodsID, AMatchType: Integer);
var
  ItemID: Integer;
begin
  if IBCQueryItems.IsEmpty then
    Exit;
  ItemID := IBCQueryItems.FieldByName('ITEMID').AsInteger;
  FDb.SetMatch(ItemID, AGoodsID, AMatchType, 0);
  FDb.Commit;
  IBCQueryItems.Refresh;
end;

procedure TfrmPWMain.btnMatchManualClick(Sender: TObject);
var
  S: string;
  GoodsID: Integer;
  Q: TIBCQuery;
  Title: string;
begin
  if IBCQueryItems.IsEmpty then
    Exit;
  S := IntToStr(IBCQueryItems.FieldByName('GOODSID').AsInteger);
  if S = '0' then
    S := '';
  if not InputQuery('Asociere manuala', 'GOODSID-ul produsului nostru pentru:' + sLineBreak +
      Copy(IBCQueryItems.FieldByName('TITLE').AsString, 1, 120), S) then
    Exit;
  GoodsID := StrToIntDef(Trim(S), 0);
  if GoodsID <= 0 then
    Exit;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := IBCConnection;
    Q.Transaction := IBCTransactionRead;
    Q.SQL.Text := 'SELECT TITLE FROM TS_GOODS WHERE GOODSID = :ID';
    Q.ParamByName('ID').AsInteger := GoodsID;
    Q.Open;
    if Q.Eof then
    begin
      MessageDlg(Format('Nu exista produsul %d in TS_GOODS.', [GoodsID]), mtWarning, [mbOK], 0);
      Exit;
    end;
    Title := Trim(Q.FieldByName('TITLE').AsString);
    Q.Close;
  finally
    Q.Free;
  end;
  if MessageDlg(Format('Asociati cu:' + sLineBreak + '%d  %s ?', [GoodsID, Title]), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    SetItemMatch(GoodsID, cPWMatchManual);
    AddLog(Format('Asociere manuala: item %d -> produsul %d (%s)', [IBCQueryItems.FieldByName('ITEMID').AsInteger, GoodsID, Title]));
  end;
end;

procedure TfrmPWMain.btnRejectClick(Sender: TObject);
begin
  if IBCQueryItems.IsEmpty then
    Exit;
  SetItemMatch(0, cPWMatchRejected);
end;

procedure TfrmPWMain.btnResetAutoClick(Sender: TObject);
begin
  if IBCQueryItems.IsEmpty then
    Exit;
  SetItemMatch(0, cPWMatchNone);
end;

procedure TfrmPWMain.btnOpenUrlClick(Sender: TObject);
var
  Url: string;
begin
  if IBCQueryItems.IsEmpty then
    Exit;
  Url := Trim(IBCQueryItems.FieldByName('ITEM_URL').AsString);
  if Url <> '' then
    ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmPWMain.cxGridSummaryTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  V: Variant;
begin
  if ARecord = nil then
    Exit;
  V := ARecord.Values[colS_DIFF_LEI.Index];
  if VarIsNull(V) then
    Exit;
  if V > 0.5 then
    AStyle := stRed
  else if V < -0.5 then
    AStyle := stGreen;
end;

procedure TfrmPWMain.cxGridItemsTableStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  Diff: Variant;
begin
  if ARecord = nil then
    Exit;
  Diff := ARecord.Values[colI_DIFF_LEI.Index];
  if VarIsNull(Diff) then
    Exit;
  if Diff > 0.5 then
    AStyle := stRed
  else if Diff < -0.5 then
    AStyle := stGreen;
end;

end.

unit frmECCDiagnosticDialog;

{ Casa ECC Fiscal Partner - dialog de diagnostic (faza 1 a planului
  Documents/plan-integrare-ecc-fiscalpartner-2026-09-24.md).

  Verifica pe o casa ECC configurata in TS_API_CONFIG (ECC_DEMO / ECC_<FirmaID>):
  starea serverului, bon de test, comanda pe terminalul bancar smart, depunere,
  retragere, raport X / Z, listele de bonuri si rapoarte, descarcarea si
  tiparirea PNG-ului. Nu scrie nimic in baza WMS.

  Apelurile HTTP ruleaza pe un fir separat (bonul se asteapta pina la 60 s);
  dialogul nu se inchide cit timp o operatie e in curs. }

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SWNBaseUnit, ECCApiClient, ECCConfigUnit, ECCTransactionStore,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxImage;

type
  TfrmECCDiagnosticDlg = class(TSWNCustomForm)
    pnTop: TPanel;
    lblApiCode: TLabel;
    cmbApiCode: TComboBox;
    btnReload: TButton;
    lblConfig: TLabel;
    btnStatus: TButton;
    btnXReport: TButton;
    btnZReport: TButton;
    btnListReceipts: TButton;
    btnListZ: TButton;
    btnJournal: TButton;
    btnPending: TButton;
    lblSum: TLabel;
    edSum: TEdit;
    cmbPayType: TComboBox;
    btnTestReceipt: TButton;
    btnOrderExt: TButton;
    btnCashIn: TButton;
    btnCashOut: TButton;
    lblDocId: TLabel;
    edDocId: TEdit;
    btnGetReceipt: TButton;
    btnShowDoc: TButton;
    btnPrintDoc: TButton;
    btnStopWait: TButton;
    btnReconcile: TButton;
    btnCouriers: TButton;
    pnBottom: TPanel;
    btnClose: TButton;
    memLog: TMemo;
    Splitter1: TSplitter;
    sbDoc: TScrollBox;
    imgDoc: TcxImage;
    procedure cmbApiCodeChange(Sender: TObject);
    procedure btnReloadClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnXReportClick(Sender: TObject);
    procedure btnZReportClick(Sender: TObject);
    procedure btnListReceiptsClick(Sender: TObject);
    procedure btnListZClick(Sender: TObject);
    procedure btnJournalClick(Sender: TObject);
    procedure btnPendingClick(Sender: TObject);
    procedure btnTestReceiptClick(Sender: TObject);
    procedure btnOrderExtClick(Sender: TObject);
    procedure btnCashInClick(Sender: TObject);
    procedure btnCashOutClick(Sender: TObject);
    procedure btnGetReceiptClick(Sender: TObject);
    procedure btnShowDocClick(Sender: TObject);
    procedure btnPrintDocClick(Sender: TObject);
    procedure btnStopWaitClick(Sender: TObject);
    procedure btnReconcileClick(Sender: TObject);
    procedure btnCouriersClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    fConfig: TECCConfig;
    fPreferredApiCode: string;
    fBusy: Boolean;
    fStopWait: Boolean;
    // jurnalul TFP_ECC_TRANSACTION: fJournal = tabela exista; fStore exista doar
    // pe durata unei operatii si e folosit numai de firul ei de lucru
    fJournal: Boolean;
    fStore: TECCTransactionStore;
    procedure JournalNew(const AId: string; const AKind: Integer; const ASuma: Currency;
      const APayType: Integer; const ARequestJSON: string);
    procedure JournalDo(const AAction: string; const AProc: TProc<TECCTransactionStore>);
    procedure JournalError(const AId: string; E: Exception);
    procedure LoadApiCodes;
    procedure LoadConfig;
    procedure Log(const AText: string);
    procedure LogAsync(const AText: string);
    procedure SetBusy(const ABusy: Boolean);
    procedure RunAsync(const ATitle: string; const AProc: TProc<TECCApiClient>);
    function ReadSum(out ASum: Currency): Boolean;
    function SelectedPayType: Integer;
    function BuildTestReceipt(const ASum: Currency): TECCReceiptRequest;
    function DocFileNameFromEdit: string;
    procedure SetDocAsync(const AId, ADocFileName: string);
    procedure LogReceiptAsync(const R: TECCReceipt);
    procedure LogReportAsync(const R: TECCReport);
    procedure DownloadAndShow(AClient: TECCApiClient; const ADocFileName: string; const ARetries: Integer = 1;
      const ATransId: string = '');
    procedure ShowPng(AStream: TStream);
    procedure CashMove(const ASign: Integer);
    procedure MakeReport(const AReportType: Integer);
  protected
    procedure Prepare; override;
  public
    // AApiCode: casa preselectata (FP_DEVICES.ECC_API_CODE); '' = prima din lista
    class procedure Execute(AOwner: TComponent; const AApiCode: string = '');
  end;

implementation

uses
  System.DateUtils, System.UITypes, Vcl.Printers, Vcl.Imaging.pngimage, DataModuleDB, frmECCReconcileDialog, frmECCCouriersDialog,
  ECCFiscalDevice;

{$R *.dfm}

const
  cPayTypes: array[0..2] of Integer = (eccPayCash, eccPayCard, eccPayOnline);

{ TfrmECCDiagnosticDlg }

class procedure TfrmECCDiagnosticDlg.Execute(AOwner: TComponent; const AApiCode: string);
var
  Dlg: TfrmECCDiagnosticDlg;
begin
  Dlg := TfrmECCDiagnosticDlg.Create(AOwner);
  try
    Dlg.fPreferredApiCode := UpperCase(Trim(AApiCode));
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;
end;

procedure TfrmECCDiagnosticDlg.Prepare;
begin
  inherited;
  cmbPayType.ItemIndex := 0;
  LoadApiCodes;
  fJournal := TECCTransactionStore.Available(dmDB.IBCConnection);
  btnJournal.Enabled := fJournal;
  btnPending.Enabled := fJournal;
  if fJournal then
    Log('Jurnalul TFP_ECC_TRANSACTION e activ: fiecare cerere se scrie in baza inainte de trimitere.')
  else
    Log('TFP_ECC_TRANSACTION nu exista (DB Model/ecc_fiscalpartner.sql nerulat) - operatiile nu se jurnalizeaza.');
end;

procedure TfrmECCDiagnosticDlg.LoadApiCodes;
var
  Codes: TArray<string>;
  Code, Old: string;
begin
  Old := cmbApiCode.Text;
  if (Old = '') and (fPreferredApiCode <> '') then
    Old := fPreferredApiCode;
  Codes := ListECCApiCodes(dmDB.IBCConnection);
  cmbApiCode.Items.Clear;
  for Code in Codes do
    cmbApiCode.Items.Add(Code);
  if cmbApiCode.Items.Count = 0 then
  begin
    fConfig := Default(TECCConfig);
    lblConfig.Caption := 'In TS_API_CONFIG nu exista niciun cod API activ care incepe cu "ECC". ' +
      'Adaugati in Setari > Configurari API codul ' + cECCDemoApiCode +
      ' cu BASE_URL, API_KEY, POS_ID, POS_NAME, CASHIER_NAME.';
    Exit;
  end;
  cmbApiCode.ItemIndex := cmbApiCode.Items.IndexOf(Old);
  if cmbApiCode.ItemIndex < 0 then
    cmbApiCode.ItemIndex := 0;
  LoadConfig;
end;

procedure TfrmECCDiagnosticDlg.LoadConfig;
var
  Err: string;
begin
  fConfig := LoadECCConfig(dmDB.IBCConnection, cmbApiCode.Text);
  Err := fConfig.Validate;
  lblConfig.Caption := Format('URL: %s   POS: %s (%s)   Casier: %s   Cheie: %s'#13#10'TVA: %s',
    [fConfig.BaseURL, fConfig.PosId, fConfig.PosName, fConfig.CashierName, fConfig.MaskedApiKey,
     fConfig.TaxMapText]);
  if fConfig.HasTerminal then
    lblConfig.Caption := lblConfig.Caption + Format('   Terminal smart: %s (%s), asteptare %d s',
      [fConfig.TerminalPosId, fConfig.TerminalPosName, fConfig.TerminalTimeoutSec])
  else
    lblConfig.Caption := lblConfig.Caption + '   Terminal smart: neconfigurat (comanda de test merge pe POS-ul casei)';
  if Err <> '' then
  begin
    lblConfig.Caption := lblConfig.Caption + #13#10 + Err;
    lblConfig.Font.Color := clRed;
  end
  else
    lblConfig.Font.Color := clWindowText;
end;

procedure TfrmECCDiagnosticDlg.cmbApiCodeChange(Sender: TObject);
begin
  LoadConfig;
end;

procedure TfrmECCDiagnosticDlg.btnReloadClick(Sender: TObject);
begin
  LoadApiCodes;
end;

procedure TfrmECCDiagnosticDlg.Log(const AText: string);
begin
  memLog.Lines.Add(FormatDateTime('hh:nn:ss', Now) + '  ' + AText);
end;

procedure TfrmECCDiagnosticDlg.LogAsync(const AText: string);
begin
  TThread.Queue(nil,
    procedure
    begin
      Log(AText);
    end);
end;

procedure TfrmECCDiagnosticDlg.SetBusy(const ABusy: Boolean);
var
  I: Integer;
begin
  fBusy := ABusy;
  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TButton) and (Components[I] <> btnStopWait) then
      TButton(Components[I]).Enabled := not ABusy;
  cmbApiCode.Enabled := not ABusy;
  btnStopWait.Enabled := ABusy;
  if ABusy then
    Screen.Cursor := crAppStart
  else
    Screen.Cursor := crDefault;
end;

procedure TfrmECCDiagnosticDlg.RunAsync(const ATitle: string; const AProc: TProc<TECCApiClient>);
var
  Err: string;
  Config: TECCConfig;
begin
  if fBusy then
    Exit;
  Err := fConfig.Validate;
  if Err <> '' then
  begin
    MessageDlg(Err, mtWarning, [mbOK], 0);
    Exit;
  end;
  Config := fConfig;
  // conexiunea jurnalului se deschide aici; dupa start o foloseste doar firul de lucru
  if fJournal then
    fStore := TECCTransactionStore.Create(
      TECCTransactionStore.CreateOwnConnection(dmDB.IBCConnection, UserID), True);
  fStopWait := False;
  SetBusy(True);
  Log('--- ' + ATitle);

  TThread.CreateAnonymousThread(
    procedure
    var
      Client: TECCApiClient;
    begin
      Client := nil;
      try
        try
          Client := Config.CreateClient;
          AProc(Client);
        except
          on E: Exception do
          begin
            LogAsync('EROARE: ' + E.Message);
            if Assigned(Client) and (Client.LastRequest <> '') then
            begin
              LogAsync('  cerere: ' + Client.LastRequest);
              LogAsync(Format('  raspuns HTTP %d: %s', [Client.LastHttpCode, Copy(Client.LastResponse, 1, 1000)]));
            end;
          end;
        end;
      finally
        Client.Free;
        FreeAndNil(fStore);
        TThread.Queue(nil,
          procedure
          begin
            SetBusy(False);
          end);
      end;
    end).Start;
end;

function TfrmECCDiagnosticDlg.ReadSum(out ASum: Currency): Boolean;
var
  D: Double;
begin
  Result := TryStrToFloat(StringReplace(Trim(edSum.Text), ',', '.', []), D, TFormatSettings.Invariant) and (D > 0);
  if Result then
    ASum := ECCRoundMoney(D)
  else
  begin
    MessageDlg('Introduceti o suma mai mare ca 0 (de ex. 1.00).', mtWarning, [mbOK], 0);
    edSum.SetFocus;
  end;
end;

function TfrmECCDiagnosticDlg.SelectedPayType: Integer;
begin
  if (cmbPayType.ItemIndex >= Low(cPayTypes)) and (cmbPayType.ItemIndex <= High(cPayTypes)) then
    Result := cPayTypes[cmbPayType.ItemIndex]
  else
    Result := eccPayCash;
end;

function TfrmECCDiagnosticDlg.BuildTestReceipt(const ASum: Currency): TECCReceiptRequest;
begin
  Result.Init(fConfig.PosId, fConfig.PosName, fConfig.CashierName);
  Result.AddLineTotal('Test integrare WMS', 1, ASum, fConfig.TaxCodeFor(20));
  Result.AddPayment(SelectedPayType, ASum);
end;

function TfrmECCDiagnosticDlg.DocFileNameFromEdit: string;
begin
  Result := Trim(edDocId.Text);
  if (Result <> '') and (Pos('/', Result) = 0) then
    Result := eccDocFiscalReceipt + '/' + Result;
end;

procedure TfrmECCDiagnosticDlg.SetDocAsync(const AId, ADocFileName: string);
begin
  TThread.Queue(nil,
    procedure
    begin
      if ADocFileName <> '' then
        edDocId.Text := ADocFileName
      else
        edDocId.Text := AId;
    end);
end;

// Ruleaza pe firul de lucru. Scrierea INAINTE de POST e obligatorie: daca
// jurnalul exista si insertul esueaza, exceptia opreste trimiterea.
procedure TfrmECCDiagnosticDlg.JournalNew(const AId: string; const AKind: Integer; const ASuma: Currency;
  const APayType: Integer; const ARequestJSON: string);
var
  T: TECCTransaction;
begin
  if not Assigned(fStore) then
    Exit;
  T := Default(TECCTransaction);
  T.TransId := AId;
  T.ApiCode := fConfig.ApiCode;
  T.FirmaID := FirmaID;
  T.Kind := AKind;
  T.SourceType := eccSrcDiagnostic;
  T.Suma := ASuma;
  T.PayType := APayType;
  T.CashierName := fConfig.CashierName;
  T.RequestJSON := ARequestJSON;
  fStore.AddNew(T);
end;

// Actualizarile de dupa POST nu au voie sa ascunda rezultatul din ECC:
// o eroare de jurnal se afiseaza, dar operatia continua.
procedure TfrmECCDiagnosticDlg.JournalDo(const AAction: string; const AProc: TProc<TECCTransactionStore>);
begin
  if not Assigned(fStore) then
    Exit;
  try
    AProc(fStore);
  except
    on E: Exception do
      LogAsync('ATENTIE jurnal (' + AAction + '): ' + E.Message);
  end;
end;

// 4xx = ECC a refuzat cererea, bonul nu exista -> eroare definitiva.
// Altfel (retea, timeout, 5xx) rezultatul e necunoscut: starea ramine, se verifica dupa id.
procedure TfrmECCDiagnosticDlg.JournalError(const AId: string; E: Exception);
var
  Final: Boolean;
  Msg: string;
begin
  Final := (E is EECCApiError) and (EECCApiError(E).HttpCode >= 400) and (EECCApiError(E).HttpCode < 500);
  Msg := E.Message;
  JournalDo('eroare',
    procedure(S: TECCTransactionStore)
    begin
      S.MarkError(AId, Msg, Final);
    end);
end;

procedure TfrmECCDiagnosticDlg.LogReceiptAsync(const R: TECCReceipt);
begin
  LogAsync(Format('Bon nr. %d, Z %d, nr. de la inceput %d, data %s, total %s, rest %s, plata %s, casier %s',
    [R.Number, R.ZReportNumber, R.NumberFromFirst, R.DateTimeText, ECCMoneyText(R.Total),
     ECCMoneyText(R.Change), ECCPayTypeName(R.PaymentType), R.CashierName]));
  LogAsync('  id: ' + R.Id);
  LogAsync('  MEV: ' + R.MevLink);
  LogAsync('  fisier: ' + R.DocFileName);
end;

procedure TfrmECCDiagnosticDlg.LogReportAsync(const R: TECCReport);
var
  Closed: string;
begin
  if R.CloseDateTime > 0 then
    Closed := FormatDateTime('dd.mm.yyyy hh:nn', R.CloseDateTime)
  else
    Closed := 'deschis';
  LogAsync(Format('%s nr. %d (Z %d): inceput %s, inchis %s, bonuri %d, total %s, depus %s, retras %s, in sertar %s',
    [R.ReportType, R.Number, R.ZReportNumber, FormatDateTime('dd.mm.yyyy hh:nn', R.StartDateTime), Closed,
     R.Receipts, ECCMoneyText(R.Total), ECCMoneyText(R.MoneyDeposited), ECCMoneyText(R.MoneyWithdrawn),
     ECCMoneyText(R.MoneyInDrawer)]));
  LogAsync('  id: ' + R.Id + '   fisier: ' + R.DocFileName);
end;

// Ruleaza pe firul de lucru. PNG-ul poate aparea cu intirziere dupa emitere,
// de aceea se reincearca de ARetries ori.
procedure TfrmECCDiagnosticDlg.DownloadAndShow(AClient: TECCApiClient; const ADocFileName: string;
  const ARetries: Integer; const ATransId: string);
var
  Ms: TMemoryStream;
  Attempt: Integer;
begin
  Ms := TMemoryStream.Create;
  try
    Attempt := 1;
    while True do
      try
        Ms.Clear;
        AClient.Download(ADocFileName, Ms);
        Break;
      except
        on E: EECCApiError do
        begin
          if (Attempt >= ARetries) or fStopWait then
            raise;
          Inc(Attempt);
          Sleep(1000);
        end;
      end;
    LogAsync(Format('PNG descarcat: %s (%d octeti)', [ADocFileName, Ms.Size]));
    if ATransId <> '' then
      JournalDo('PNG',
        procedure(S: TECCTransactionStore)
        begin
          S.SavePng(ATransId, Ms);
        end);
  except
    Ms.Free;
    raise;
  end;

  TThread.Queue(nil,
    procedure
    begin
      try
        ShowPng(Ms);
      finally
        Ms.Free;
      end;
    end);
end;

procedure TfrmECCDiagnosticDlg.ShowPng(AStream: TStream);
var
  Png: TPngImage;
begin
  Png := TPngImage.Create;
  try
    AStream.Position := 0;
    try
      Png.LoadFromStream(AStream);
    except
      on E: Exception do
      begin
        Log('Fisierul descarcat nu e PNG valid: ' + E.Message);
        Exit;
      end;
    end;
    imgDoc.Picture.Assign(Png);
  finally
    Png.Free;
  end;
end;

procedure TfrmECCDiagnosticDlg.btnStatusClick(Sender: TObject);
begin
  RunAsync('Stare server',
    procedure(C: TECCApiClient)
    begin
      if C.Status then
        LogAsync('Serverul ECC raspunde: status = true')
      else
        LogAsync('Serverul ECC raspunde, dar status = false');
      LogAsync('  ' + Copy(C.LastResponse, 1, 300));
    end);
end;

procedure TfrmECCDiagnosticDlg.btnTestReceiptClick(Sender: TObject);
var
  Sum: Currency;
  R: TECCReceiptRequest;
begin
  if not ReadSum(Sum) then
    Exit;
  R := BuildTestReceipt(Sum);
  if MessageDlg(Format('Se emite un bon fiscal de %s lei (%s) pe casa %s (%s).'#13#10'Continuati?',
    [ECCMoneyText(Sum), ECCPayTypeName(SelectedPayType), fConfig.ApiCode, fConfig.PosName]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  RunAsync('Bon de test',
    procedure(C: TECCApiClient)
    var
      Receipt: TECCReceipt;
    begin
      LogAsync('JSON: ' + R.ToJSON);
      JournalNew(R.Id, eccKindReceipt, R.Total, SelectedPayType, R.ToJSON);
      try
        C.PostReceipt(R);
      except
        on E: Exception do
        begin
          JournalError(R.Id, E);
          raise;
        end;
      end;
      JournalDo('trimis',
        procedure(S: TECCTransactionStore)
        begin
          S.MarkSent(R.Id);
        end);
      LogAsync(Format('Acceptat (HTTP %d), id %s. Astept bonul...', [C.LastHttpCode, R.Id]));
      SetDocAsync(R.Id, '');
      if not C.WaitReceipt(R.Id, Receipt, 60000, 500,
        function: Boolean
        begin
          Result := fStopWait;
        end) then
      begin
        LogAsync('Bonul nu a aparut in 60 s. Ramine "trimis" in jurnal; "In asteptare" il finalizeaza mai tirziu.');
        Exit;
      end;
      JournalDo('emis',
        procedure(S: TECCTransactionStore)
        begin
          S.MarkReceiptDone(R.Id, Receipt, C.LastResponse);
        end);
      LogReceiptAsync(Receipt);
      SetDocAsync(Receipt.Id, Receipt.DocFileName);
      DownloadAndShow(C, Receipt.DocFileName, 5, Receipt.Id);
    end);
end;

procedure TfrmECCDiagnosticDlg.btnOrderExtClick(Sender: TObject);
var
  Sum: Currency;
  R: TECCReceiptRequest;
begin
  if not ReadSum(Sum) then
    Exit;
  R := BuildTestReceipt(Sum);
  if fConfig.HasTerminal then
  begin
    R.PosId := fConfig.TerminalPosId;
    R.PosName := fConfig.TerminalPosName;
  end;
  if MessageDlg(Format('Se trimite pe terminalul bancar smart (POS %s) o comanda de %s lei, plata %s.'#13#10 +
    'Terminalul va emite bonul fiscal dupa plata. Continuati?',
    [R.PosName, ECCMoneyText(Sum), ECCPayTypeName(SelectedPayType)]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  RunAsync('Comanda pe terminalul smart',
    procedure(C: TECCApiClient)
    var
      St, OldSt: TECCOrderStatus;
      ResultText: string;
      Deadline: TDateTime;
      Receipt: TECCReceipt;
      StName: string;
      OC, Own: TECCApiClient;
    begin
      // terminalul poate avea cheie proprie (TERMINAL_API_KEY)
      Own := nil;
      OC := C;
      if fConfig.TerminalApiKey <> '' then
      begin
        Own := fConfig.CreateTerminalClient;
        OC := Own;
      end;
      try
      LogAsync('JSON: ' + R.ToOrderExtJSON);
      JournalNew(R.Id, eccKindOrderExt, R.Total, SelectedPayType, R.ToOrderExtJSON);
      try
        OC.NewOrderExt(R);
      except
        on E: Exception do
        begin
          JournalError(R.Id, E);
          raise;
        end;
      end;
      JournalDo('trimis',
        procedure(S: TECCTransactionStore)
        begin
          S.MarkSent(R.Id);
        end);
      LogAsync(Format('Comanda acceptata (HTTP %d), id %s. Astept plata pe terminal (max 3 min)...',
        [OC.LastHttpCode, R.Id]));
      SetDocAsync(R.Id, '');
      OldSt := eosUnknown;
      St := eosUnknown;
      Deadline := IncMinute(Now, 3);
      while Now < Deadline do
      begin
        St := OC.GetOrderExtStatus(R.Id, ResultText);
        if St <> OldSt then
        begin
          LogAsync('Stare: ' + ECCOrderStatusName(St) + ' ' + ResultText);
          StName := ECCOrderStatusName(St);
          JournalDo('stare comanda',
            procedure(S: TECCTransactionStore)
            begin
              S.SetOrderStatus(R.Id, StName);
            end);
          OldSt := St;
        end;
        if St in [eosProcessed, eosCompleted, eosCancelled] then
          Break;
        if fStopWait then
        begin
          if St = eosPending then
          begin
            OC.CancelOrderExt(R.Id);
            JournalDo('anulat',
              procedure(S: TECCTransactionStore)
              begin
                S.MarkCancelled(R.Id, 'Anulat din dialogul de diagnostic');
              end);
            LogAsync('Comanda anulata (DELETE).');
          end
          else
            LogAsync('Asteptarea oprita; comanda nu mai poate fi anulata in starea ' + ECCOrderStatusName(St) + '.');
          Exit;
        end;
        Sleep(1000);
      end;

      if St in [eosProcessed, eosCompleted] then
      begin
        if OC.WaitReceipt(R.Id, Receipt, 30000) then
        begin
          JournalDo('emis',
            procedure(S: TECCTransactionStore)
            begin
              S.MarkReceiptDone(R.Id, Receipt, OC.LastResponse);
            end);
          LogReceiptAsync(Receipt);
          SetDocAsync(Receipt.Id, Receipt.DocFileName);
          DownloadAndShow(OC, Receipt.DocFileName, 5, Receipt.Id);
        end
        else
          LogAsync('Comanda e procesata, dar bonul nu se gaseste inca dupa id.');
      end
      else if St = eosCancelled then
        JournalDo('anulat',
          procedure(S: TECCTransactionStore)
          begin
            S.MarkCancelled(R.Id, 'Anulat pe terminal');
          end)
      else
        LogAsync('Comanda nu s-a finalizat in 3 minute; ultima stare: ' + ECCOrderStatusName(St));
      finally
        Own.Free;
      end;
    end);
end;

procedure TfrmECCDiagnosticDlg.CashMove(const ASign: Integer);
var
  Sum: Currency;
  Title: string;
begin
  if not ReadSum(Sum) then
    Exit;
  if ASign > 0 then
    Title := 'Depunere'
  else
    Title := 'Retragere';
  if MessageDlg(Format('%s de %s lei pe casa %s. Continuati?', [Title, ECCMoneyText(Sum), fConfig.PosName]),
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  RunAsync(Title,
    procedure(C: TECCApiClient)
    var
      Id, Req, Resp: string;
    begin
      // id-ul bonului de serviciu il da serverul, deci jurnalul se scrie dupa raspuns
      Id := C.ServiceReceipt(fConfig.PosId, fConfig.PosName, fConfig.CashierName, ASign * Sum);
      LogAsync(Format('%s acceptata (HTTP %d), id %s', [Title, C.LastHttpCode, Id]));
      if IsValidECCId(Id) then
      begin
        Req := C.LastRequest;
        Resp := C.LastResponse;
        JournalDo('bon de serviciu',
          procedure(S: TECCTransactionStore)
          begin
            JournalNew(Id, eccKindService, ASign * Sum, eccPayCash, Req);
            S.MarkDone(Id, Resp);
          end);
      end;
      SetDocAsync(Id, eccDocServiceReceipt + '/' + Id);
      DownloadAndShow(C, eccDocServiceReceipt + '/' + Id, 10, Id);
    end);
end;

procedure TfrmECCDiagnosticDlg.btnCashInClick(Sender: TObject);
begin
  CashMove(1);
end;

procedure TfrmECCDiagnosticDlg.btnCashOutClick(Sender: TObject);
begin
  CashMove(-1);
end;

procedure TfrmECCDiagnosticDlg.MakeReport(const AReportType: Integer);
var
  Title: string;
begin
  if AReportType = eccReportZ then
  begin
    Title := 'Raport Z';
    if MessageDlg('Raportul Z inchide ziua fiscala pe casa ' + fConfig.PosName + '. Continuati?',
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
  end
  else
    Title := 'Raport X';

  RunAsync(Title,
    procedure(C: TECCApiClient)
    var
      Id, Req, Resp: string;
      Rep: TECCReport;
      Attempt, Kind: Integer;
    begin
      Id := C.Report(fConfig.PosId, fConfig.PosName, fConfig.CashierName, AReportType);
      LogAsync(Format('%s acceptat (HTTP %d), id %s', [Title, C.LastHttpCode, Id]));
      Req := C.LastRequest;
      if AReportType = eccReportZ then
        Kind := eccKindZReport
      else
        Kind := eccKindXReport;
      if IsValidECCId(Id) then
        JournalDo('raport',
          procedure(S: TECCTransactionStore)
          begin
            JournalNew(Id, Kind, 0, 0, Req);
            S.MarkSent(Id);
          end);
      for Attempt := 1 to 30 do
      begin
        if C.TryGetReport(Id, Rep) then
          Break;
        if fStopWait then
          Exit;
        Sleep(1000);
      end;
      if Rep.Id = '' then
      begin
        LogAsync('Raportul nu a aparut in 30 s.');
        Exit;
      end;
      Resp := C.LastResponse;
      JournalDo('raport emis',
        procedure(S: TECCTransactionStore)
        begin
          S.MarkReportDone(Id, Rep, Resp);
        end);
      LogReportAsync(Rep);
      SetDocAsync(Rep.Id, Rep.DocFileName);
      DownloadAndShow(C, Rep.DocFileName, 5, Id);
    end);
end;

procedure TfrmECCDiagnosticDlg.btnXReportClick(Sender: TObject);
begin
  MakeReport(eccReportX);
end;

procedure TfrmECCDiagnosticDlg.btnZReportClick(Sender: TObject);
begin
  MakeReport(eccReportZ);
end;

procedure TfrmECCDiagnosticDlg.btnListReceiptsClick(Sender: TObject);
begin
  RunAsync('Bonurile de azi',
    procedure(C: TECCApiClient)
    var
      List: TArray<TECCReceipt>;
      R: TECCReceipt;
    begin
      List := C.ListReceipts(Today, EndOfTheDay(Today));
      LogAsync(Format('%d bonuri azi (toate casele cheii)', [Length(List)]));
      for R in List do
        LogAsync(Format('  %s  nr. %d  Z %d  %s lei  %s  %s  id %s',
          [R.DateTimeText, R.Number, R.ZReportNumber, ECCMoneyText(R.Total), R.PosName, R.CashierName, R.Id]));
    end);
end;

procedure TfrmECCDiagnosticDlg.btnListZClick(Sender: TObject);
begin
  RunAsync('Rapoarte Z (7 zile)',
    procedure(C: TECCApiClient)
    var
      List: TArray<TECCReport>;
      R: TECCReport;
      Closed: Boolean;
    begin
      for Closed := False to True do
      begin
        List := C.ListZReports(IncDay(Today, -7), EndOfTheDay(Today), Closed);
        if Closed then
          LogAsync(Format('%d rapoarte Z inchise', [Length(List)]))
        else
          LogAsync(Format('%d rapoarte Z deschise', [Length(List)]));
        for R in List do
          LogReportAsync(R);
      end;
    end);
end;

procedure TfrmECCDiagnosticDlg.btnJournalClick(Sender: TObject);
begin
  RunAsync('Jurnal ' + fConfig.ApiCode,
    procedure(C: TECCApiClient)
    var
      List: TArray<TECCTransaction>;
      T: TECCTransaction;
    begin
      List := fStore.ListRecent(fConfig.ApiCode, 30);
      LogAsync(Format('%d rinduri (cele mai noi primele)', [Length(List)]));
      for T in List do
        LogAsync(Format('  %s  %-16s %-7s %8s lei  bon %d  Z %d  incerc. %d  %s  %s',
          [FormatDateTime('dd.mm hh:nn:ss', T.CreatedAt), ECCKindName(T.Kind), ECCStateName(T.State),
           ECCMoneyText(T.Suma), T.ReceiptNumber, T.ZNumber, T.Attempts, T.TransId, T.ErrorMsg]));
    end);
end;

// Recuperarea: bonurile ramase "nou" / "trimis" (WMS inchis, timeout) se cauta
// in ECC dupa id. Gasit = emis; 404 = ECC nu l-a primit (aici nu se retrimite nimic).
procedure TfrmECCDiagnosticDlg.btnPendingClick(Sender: TObject);
begin
  RunAsync('Tranzactii in asteptare ' + fConfig.ApiCode,
    procedure(C: TECCApiClient)
    var
      List: TArray<TECCTransaction>;
      T: TECCTransaction;
      Receipt: TECCReceipt;
    begin
      List := fStore.ListPending(fConfig.ApiCode);
      LogAsync(Format('%d tranzactii de finalizat', [Length(List)]));
      for T in List do
      begin
        if fStopWait then
          Exit;
        if not ((T.Kind = eccKindReceipt) or (T.Kind = eccKindOrderExt)) or (T.State = eccStateDone) then
        begin
          LogAsync(Format('  %s %s %s - de finalizat in WMS (inregistrare)',
            [T.TransId, ECCKindName(T.Kind), ECCStateName(T.State)]));
          Continue;
        end;
        if C.TryGetReceipt(T.TransId, Receipt) then
        begin
          fStore.MarkReceiptDone(T.TransId, Receipt, C.LastResponse);
          LogAsync(Format('  %s gasit in ECC: bon nr. %d, Z %d -> emis',
            [T.TransId, Receipt.Number, Receipt.ZReportNumber]));
        end
        else
          LogAsync(Format('  %s nu exista in ECC (stare %s, %d incercari)',
            [T.TransId, ECCStateName(T.State), T.Attempts]));
      end;
    end);
end;

procedure TfrmECCDiagnosticDlg.btnGetReceiptClick(Sender: TObject);
var
  Id: string;
begin
  Id := Trim(edDocId.Text);
  if Pos('/', Id) > 0 then
    Id := Copy(Id, LastDelimiter('/', Id) + 1, MaxInt);
  if not IsValidECCId(Id) then
  begin
    MessageDlg('Introduceti id-ul bonului (UUID).', mtWarning, [mbOK], 0);
    Exit;
  end;
  RunAsync('Citire bon ' + Id,
    procedure(C: TECCApiClient)
    var
      R: TECCReceipt;
    begin
      if C.TryGetReceipt(Id, R) then
      begin
        LogReceiptAsync(R);
        LogAsync('  JSON: ' + Copy(C.LastResponse, 1, 4000));
      end
      else
        LogAsync('Bonul nu exista (inca) pe server (HTTP 404).');
    end);
end;

procedure TfrmECCDiagnosticDlg.btnShowDocClick(Sender: TObject);
var
  Doc: string;
begin
  Doc := DocFileNameFromEdit;
  if Doc = '' then
  begin
    MessageDlg('Introduceti id-ul bonului sau doc_file_name (de ex. z_report/<id>).', mtWarning, [mbOK], 0);
    Exit;
  end;
  RunAsync('Descarcare ' + Doc,
    procedure(C: TECCApiClient)
    begin
      DownloadAndShow(C, Doc);
    end);
end;

procedure TfrmECCDiagnosticDlg.btnPrintDocClick(Sender: TObject);
var
  G: TGraphic;
begin
  G := imgDoc.Picture.Graphic;
  if (G = nil) or G.Empty then
  begin
    MessageDlg('Nu e niciun document afisat. Apasati intii "Arata PNG".', mtWarning, [mbOK], 0);
    Exit;
  end;
  // latimea unui bon de 80 mm, pe imprimanta implicita
  ECCPrintGraphic(G, 'ECC ' + Trim(edDocId.Text));
  Log('Trimis la imprimanta ' + Printer.Printers[Printer.PrinterIndex]);
end;

procedure TfrmECCDiagnosticDlg.btnCouriersClick(Sender: TObject);
begin
  TfrmECCCouriersDlg.Execute(Self, cmbApiCode.Text);
end;

procedure TfrmECCDiagnosticDlg.btnReconcileClick(Sender: TObject);
begin
  TfrmECCReconcileDlg.Execute(Self, cmbApiCode.Text);
end;

procedure TfrmECCDiagnosticDlg.btnStopWaitClick(Sender: TObject);
begin
  fStopWait := True;
  Log('Oprire ceruta...');
end;

procedure TfrmECCDiagnosticDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fBusy then
  begin
    CanClose := False;
    MessageDlg('O operatie ECC e in curs. Asteptati sfirsitul ei sau apasati "Opreste asteptarea".',
      mtInformation, [mbOK], 0);
  end;
end;

end.

unit TelegramServiceUnit;

(* TSWNTelegramService - firul SWNService care trimite coada TELEGRAM_MESSAGES
   in Telegram (DB Model/telegram_messages.sql, plan in
   Documents/telegram-service-plan-2026-10-03.md).

   - doua conexiuni proprii (date din settings.dat): una de lucru si una doar
     pentru TIBCAlerter ('NEW_TELEGRAM', postat de triggerul AI la COMMIT);
     EventHandler = ehNativeAlerter: evenimentul vine din firul intern IBDAC,
     fara fereastra/bucla de mesaje (ehWindowMessage nu merge intr-un serviciu);
   - pe linga eveniment, coada se verifica la fiecare 60 s (reincercari
     programate prin NEXT_SEND_TIME, evenimente pierdute la deconectare);
   - fiecare mesaj se marcheaza in tranzactia lui, imediat dupa trimitere;
   - reincercari: 1 / 5 / 15 / 60 min, dupa a 5-a esuare SENT_STATUS = 3;
     la 429 chat-ul asteapta retry_after fara sa consume o incercare;
     HTML respins de Telegram -> retrimis imediat ca text simplu;
     token gresit (401/404) -> randurile raman neatinse pina la corectare;
   - configurarea: TS_API_CONFIG (TELEGRAM: BOT_TOKEN, DEFAULT_CHAT_ID) +
     TELEGRAM_CHANNELS, recitite la 5 min;
   - jurnal: <folderul de lucru>\telegram.log (ServiceJobLog). *)

interface

uses
  System.Classes, System.SysUtils, System.SyncObjs, System.Generics.Collections,
  IBC, IBCAlerter, AppSettingsClass;

type
  TTelegramChannel = record
    ChatId: string;
    ThreadId: Integer;
    Silent: Boolean;
    Active: Boolean;
  end;

  TTelegramLocalMessage = record
    Channel: string;
    Text: string;
  end;

  TSWNTelegramService = class(TThread)
  private
    // copie a setarilor (obiectul serviciului nu e al acestui fir)
    fServer, fDBName, fUserName, fUserPass: string;
    fDBUserID: Integer;

    fWake: TEvent;
    fLocalLock: TCriticalSection;
    fLocalQueue: TList<TTelegramLocalMessage>;

    fConn: TIBCConnection;
    fTrans: TIBCTransaction;
    fAlertConn: TIBCConnection;
    fAlerter: TIBCAlerter;

    fToken: string;
    fDefaultChat: string;
    fTokenBroken: Boolean;
    fChannels: TDictionary<string, TTelegramChannel>;
    fConfigLoadedAt: TDateTime;
    fAlertCheckedAt: TDateTime;
    fChatPausedUntil: TDictionary<string, TDateTime>;
    fChatLastSend: TDictionary<string, UInt64>;
    fLastError: string;

    procedure Log(const AText: string);
    procedure LogOnce(const AText: string);
    function NewConnection: TIBCConnection;
    procedure Connect;
    procedure Disconnect;
    function Connected: Boolean;
    procedure CheckAlerter;
    procedure AlerterEvent(Sender: TObject; EventName: string; EventCount: Integer);
    procedure LoadConfig;
    function ResolveChat(const ACode: string; out AChannel: TTelegramChannel; out ASkipReason: string): Boolean;
    procedure FlushLocalQueue;
    procedure SendLocalDirect(const AMsg: TTelegramLocalMessage);
    function ProcessQueue: Integer;
    procedure ExecUpdate(const ASQL: string; const AID: Integer; const AParams: array of Variant);
    procedure WaitInterruptible(AMs: Cardinal);
  protected
    procedure Execute; override;
  public
    constructor Create(const ASettings: TSWNServiceManagerSettings);
    destructor Destroy; override;
    // thread-safe: mesaj generat de serviciu (eroare job etc.), text simplu
    procedure QueueLocal(const AChannel, AText: string);
    // Terminate + trezire + asteptare; False = firul nu s-a oprit in timp util
    function Shutdown(ATimeoutMs: Cardinal): Boolean;
  end;

const
  cTelegramEvent = 'NEW_TELEGRAM';
  cTelegramSourceService = -20;

implementation

uses
  Winapi.Windows, System.DateUtils, System.Variants, Data.DB, IBCClasses,
  ServiceJobsUnit, TelegramApiUnit;

const
  cJobName = '@TELEGRAM';
  cBatchSize = 50;
  cMaxAttempts = 5;
  cRetryDelaysMin: array[1..cMaxAttempts - 1] of Integer = (1, 5, 15, 60);
  cIdleWaitMs = 60000;
  cReconnectWaitMs = 30000;
  cConfigReloadMin = 5;
  cAlertCheckMin = 5;
  cMinChatIntervalMs = 1100;   // limita Telegram: ~1 mesaj/s pe chat, 20/min pe grup
  cMaxLocalQueue = 200;

  // SENT_STATUS
  stsSent = 1;
  stsRetry = 2;
  stsFailed = 3;
  stsIgnored = 4;

function NullIfEmpty(const S: string): Variant;
begin
  if S = '' then
    Result := Null
  else
    Result := S;
end;

{ TSWNTelegramService }

constructor TSWNTelegramService.Create(const ASettings: TSWNServiceManagerSettings);
begin
  fServer := ASettings.Server;
  fDBName := ASettings.DBName;
  fUserName := ASettings.UserName;
  fUserPass := ASettings.UserPass;
  fDBUserID := ASettings.DBUserID;

  fWake := TEvent.Create(nil, False, False, '');
  fLocalLock := TCriticalSection.Create;
  fLocalQueue := TList<TTelegramLocalMessage>.Create;
  fChannels := TDictionary<string, TTelegramChannel>.Create;
  fChatPausedUntil := TDictionary<string, TDateTime>.Create;
  fChatLastSend := TDictionary<string, UInt64>.Create;
  FreeOnTerminate := False;
  inherited Create(False);
end;

destructor TSWNTelegramService.Destroy;
begin
  inherited;   // asteapta Execute daca mai ruleaza
  fChatLastSend.Free;
  fChatPausedUntil.Free;
  fChannels.Free;
  fLocalQueue.Free;
  fLocalLock.Free;
  fWake.Free;
end;

function TSWNTelegramService.Shutdown(ATimeoutMs: Cardinal): Boolean;
begin
  Terminate;
  fWake.SetEvent;
  Result := WaitForSingleObject(Handle, ATimeoutMs) = WAIT_OBJECT_0;
end;

procedure TSWNTelegramService.Log(const AText: string);
begin
  ServiceJobLog(cJobName, AText);
end;

// aceeasi eroare repetata (baza cazuta) nu umple jurnalul
procedure TSWNTelegramService.LogOnce(const AText: string);
begin
  if AText <> fLastError then
    Log(AText);
  fLastError := AText;
end;

procedure TSWNTelegramService.QueueLocal(const AChannel, AText: string);
var
  M: TTelegramLocalMessage;
begin
  M.Channel := AChannel;
  M.Text := AText;
  fLocalLock.Enter;
  try
    if fLocalQueue.Count < cMaxLocalQueue then
      fLocalQueue.Add(M);
  finally
    fLocalLock.Leave;
  end;
  fWake.SetEvent;
end;

procedure TSWNTelegramService.WaitInterruptible(AMs: Cardinal);
begin
  // trezirea prin fWake (eveniment / oprire) scurteaza asteptarea
  if not Terminated then
    fWake.WaitFor(AMs);
end;

function TSWNTelegramService.NewConnection: TIBCConnection;
begin
  Result := TIBCConnection.Create(nil);
  Result.SQLDialect := 3;
  Result.ClientLibrary := 'fbclient.dll';
  Result.LoginPrompt := False;
  Result.Username := fUserName;
  Result.Password := fUserPass;
  Result.Server := fServer;
  Result.Database := fDBName;
  // baza SW e UTF8; textele mesajelor au diacritice, chirilice si emoji
  Result.Options.Charset := 'UTF8';
  Result.Options.UseUnicode := True;
end;

procedure TSWNTelegramService.Connect;
var
  Q: TIBCQuery;
begin
  Disconnect;

  fConn := NewConnection;
  fConn.Connect;
  fTrans := TIBCTransaction.Create(nil);
  fTrans.DefaultConnection := fConn;
  fTrans.IsolationLevel := iblReadCommitted;
  // fara 'read_committed'/'rec_version': pe Firebird 5 IBDAC pune read_consistency,
  // iar rec_version alaturi da "invalid parameter in transaction parameter block"
  fTrans.Params.Add('nowait');
  fConn.DefaultTransaction := fTrans;

  // contextul utilizatorului (UserID in triggere), ca in TSQLThread
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := fConn;
    Q.Transaction := fTrans;
    fTrans.StartTransaction;
    Q.SQL.Text := 'EXECUTE PROCEDURE PROC_USER_LOGIN(:UserID)';
    Q.ParamByName('UserID').AsInteger := fDBUserID;
    Q.Execute;
    fTrans.Commit;
  finally
    Q.Free;
  end;

  fAlertConn := NewConnection;
  fAlertConn.Connect;
  fAlerter := TIBCAlerter.Create(nil);
  fAlerter.Connection := fAlertConn;
  fAlerter.EventHandler := ehNativeAlerter;
  fAlerter.Events.Text := cTelegramEvent;
  fAlerter.OnEvent := AlerterEvent;
  fAlerter.Start;
  fAlertCheckedAt := Now;

  fConfigLoadedAt := 0;   // recitim configurarea dupa fiecare (re)conectare
  if fLastError <> '' then
    Log('Conectat din nou la baza.')
  else
    Log('Conectat la baza, ascult evenimentul ' + cTelegramEvent + '.');
  fLastError := '';
end;

procedure TSWNTelegramService.Disconnect;
begin
  if fAlerter <> nil then
  begin
    try
      fAlerter.Stop;
    except
    end;
    FreeAndNil(fAlerter);
  end;
  if fAlertConn <> nil then
  begin
    try
      fAlertConn.Disconnect;
    except
    end;
    FreeAndNil(fAlertConn);
  end;
  if fTrans <> nil then
  begin
    try
      if fTrans.Active then
        fTrans.Rollback;
    except
    end;
    FreeAndNil(fTrans);
  end;
  if fConn <> nil then
  begin
    try
      fConn.Disconnect;
    except
    end;
    FreeAndNil(fConn);
  end;
end;

function TSWNTelegramService.Connected: Boolean;
begin
  Result := (fConn <> nil) and fConn.Connected and (fAlerter <> nil);
end;

// conexiunea alerter-ului poate cadea fara semn; Ping la 5 min, altfel reconectare
procedure TSWNTelegramService.CheckAlerter;
begin
  if MinutesBetween(Now, fAlertCheckedAt) < cAlertCheckMin then
    Exit;
  fAlertCheckedAt := Now;
  try
    fAlertConn.Ping;
    fConn.Ping;
  except
    on E: Exception do
    begin
      Log('Conexiunea s-a pierdut (' + E.Message + '), reconectare.');
      Disconnect;
    end;
  end;
end;

procedure TSWNTelegramService.AlerterEvent(Sender: TObject; EventName: string; EventCount: Integer);
begin
  fWake.SetEvent;
end;

procedure TSWNTelegramService.LoadConfig;
var
  Q: TIBCQuery;
  Ch: TTelegramChannel;
  OldToken, Info: string;
begin
  OldToken := fToken;
  fToken := '';
  fDefaultChat := '';
  fChannels.Clear;

  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := fConn;
    Q.Transaction := fTrans;
    fTrans.StartTransaction;
    try
      Q.SQL.Text :=
        'SELECT UPPER(TRIM(PARAM_NAME)) AS PARAM_NAME, TRIM(PARAM_VALUE) AS PARAM_VALUE ' +
        'FROM TS_API_CONFIG WHERE API_CODE = ''TELEGRAM'' AND FLG_ACTIVE = 1';
      Q.Open;
      while not Q.Eof do
      begin
        if Q.FieldByName('PARAM_NAME').AsString = 'BOT_TOKEN' then
          fToken := Q.FieldByName('PARAM_VALUE').AsString
        else if Q.FieldByName('PARAM_NAME').AsString = 'DEFAULT_CHAT_ID' then
          fDefaultChat := Q.FieldByName('PARAM_VALUE').AsString;
        Q.Next;
      end;
      Q.Close;

      Q.SQL.Text := 'SELECT CHANNEL_CODE, CHAT_ID, THREAD_ID, FLG_SILENT, FLG_ACTIVE FROM TELEGRAM_CHANNELS';
      Q.Open;
      while not Q.Eof do
      begin
        Ch.ChatId := Trim(Q.FieldByName('CHAT_ID').AsString);
        Ch.ThreadId := Q.FieldByName('THREAD_ID').AsInteger;
        Ch.Silent := Q.FieldByName('FLG_SILENT').AsInteger = 1;
        Ch.Active := Q.FieldByName('FLG_ACTIVE').AsInteger = 1;
        fChannels.AddOrSetValue(UpperCase(Trim(Q.FieldByName('CHANNEL_CODE').AsString)), Ch);
        Q.Next;
      end;
      Q.Close;
      fTrans.Commit;
    except
      if fTrans.Active then
        fTrans.Rollback;
      raise;
    end;
  finally
    Q.Free;
  end;
  fConfigLoadedAt := Now;

  if fToken <> OldToken then
  begin
    fTokenBroken := False;
    if fToken = '' then
      Log('BOT_TOKEN lipseste (TS_API_CONFIG, TELEGRAM) - mesajele raman in coada.')
    else if TelegramGetMe(fToken, Info) then
      Log('Bot Telegram: ' + Info)
    else
    begin
      fTokenBroken := Pos('HTTP 401', Info) + Pos('HTTP 404', Info) > 0;
      Log('getMe a esuat: ' + Info);
    end;
  end;
end;

// False = nu se trimite acum (chat neconfigurat - randul ramine in coada,
// sau canal inactiv - ASkipReason <> '' si randul devine "ignorat")
function TSWNTelegramService.ResolveChat(const ACode: string; out AChannel: TTelegramChannel;
  out ASkipReason: string): Boolean;
begin
  ASkipReason := '';
  AChannel := Default(TTelegramChannel);
  AChannel.Active := True;
  if (ACode <> '') and fChannels.TryGetValue(UpperCase(ACode), AChannel) and not AChannel.Active then
  begin
    ASkipReason := 'canal inactiv: ' + ACode;
    Exit(False);
  end;
  // canal fara chat / necunoscut / gol -> chat-ul implicit
  if AChannel.ChatId = '' then
  begin
    AChannel.ChatId := fDefaultChat;
    AChannel.ThreadId := 0;
  end;
  Result := AChannel.ChatId <> '';
end;

procedure TSWNTelegramService.SendLocalDirect(const AMsg: TTelegramLocalMessage);
var
  Ch: TTelegramChannel;
  Skip: string;
begin
  if (fToken <> '') and ResolveChat(AMsg.Channel, Ch, Skip) then
    TelegramSendMessage(fToken, Ch.ChatId, Ch.ThreadId, AMsg.Text, '', Ch.Silent);
end;

// mesajele serviciului intra in TELEGRAM_MESSAGES (istoric, reincercari);
// daca baza nu raspunde, pleaca direct din memorie
procedure TSWNTelegramService.FlushLocalQueue;
var
  Items: TArray<TTelegramLocalMessage>;
  M: TTelegramLocalMessage;
  Q: TIBCQuery;
begin
  fLocalLock.Enter;
  try
    Items := fLocalQueue.ToArray;
    fLocalQueue.Clear;
  finally
    fLocalLock.Leave;
  end;
  if Length(Items) = 0 then
    Exit;

  if not Connected then
  begin
    for M in Items do
      SendLocalDirect(M);
    Exit;
  end;

  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := fConn;
    Q.Transaction := fTrans;
    Q.SQL.Text := 'EXECUTE PROCEDURE SP_TELEGRAM_SEND(:CH, :TXT, NULL, :SRC, NULL, 5)';
    for M in Items do
      try
        fTrans.StartTransaction;
        Q.ParamByName('CH').AsString := M.Channel;
        Q.ParamByName('TXT').AsString := Copy(M.Text, 1, cTelegramMaxTextLength);
        Q.ParamByName('SRC').AsInteger := cTelegramSourceService;
        Q.Execute;
        fTrans.Commit;
      except
        on E: Exception do
        begin
          if fTrans.Active then
            fTrans.Rollback;
          Log('Mesajul serviciului nu a intrat in coada (' + E.Message + '), trimis direct.');
          SendLocalDirect(M);
        end;
      end;
  finally
    Q.Free;
  end;
end;

procedure TSWNTelegramService.ExecUpdate(const ASQL: string; const AID: Integer; const AParams: array of Variant);
var
  Q: TIBCQuery;
  i: Integer;
begin
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := fConn;
    Q.Transaction := fTrans;
    Q.SQL.Text := ASQL;
    fTrans.StartTransaction;
    try
      for i := 0 to High(AParams) do
        if VarIsNull(AParams[i]) then
        begin
          Q.Params[i].DataType := ftString;
          Q.Params[i].Clear;
        end
        else
          Q.Params[i].Value := AParams[i];
      Q.ParamByName('ID').AsInteger := AID;
      Q.Execute;
      fTrans.Commit;
    except
      if fTrans.Active then
        fTrans.Rollback;
      raise;
    end;
  finally
    Q.Free;
  end;
end;

type
  TQueuedRow = record
    ID: Integer;
    Channel: string;
    Text: string;
    ParseMode: string;
    RetryCount: Integer;
    SourceTable: Integer;
    SourceID: Integer;
    HasText: Boolean;
  end;

// Trimite tot ce e scadent; intoarce numarul de randuri actualizate.
function TSWNTelegramService.ProcessQueue: Integer;
var
  Q: TIBCQuery;
  Rows: TList<TQueuedRow>;
  R: TQueuedRow;
  Ch: TTelegramChannel;
  Skip, Note, BuiltText: string;
  Res: TTelegramSendResult;
  Paused: TDateTime;
  LastTick: UInt64;
  Elapsed: UInt64;
  Updated, Attempt, DelaySec, Idx: Integer;
begin
  Result := 0;
  Rows := TList<TQueuedRow>.Create;
  Q := TIBCQuery.Create(nil);
  try
    Q.Connection := fConn;
    Q.Transaction := fTrans;
    repeat
      Rows.Clear;
      Updated := 0;

      fTrans.StartTransaction;
      try
        Q.SQL.Text :=
          'SELECT FIRST ' + IntToStr(cBatchSize) + ' TGMSGID, CHANNEL_CODE, MSG_TEXT, PARSE_MODE, ' +
          '  RETRY_COUNT, SOURCE_TABLE, SOURCE_ID ' +
          'FROM TELEGRAM_MESSAGES ' +
          'WHERE FLG_SENT = 0 AND SENT_STATUS IN (0, 2) AND NEXT_SEND_TIME <= CURRENT_TIMESTAMP ' +
          'ORDER BY PRIORITY DESC, TGMSGID';
        Q.Open;
        while not Q.Eof do
        begin
          R.ID := Q.FieldByName('TGMSGID').AsInteger;
          R.Channel := Trim(Q.FieldByName('CHANNEL_CODE').AsString);
          R.HasText := not Q.FieldByName('MSG_TEXT').IsNull;
          R.Text := Q.FieldByName('MSG_TEXT').AsString;
          R.ParseMode := Trim(Q.FieldByName('PARSE_MODE').AsString);
          R.RetryCount := Q.FieldByName('RETRY_COUNT').AsInteger;
          R.SourceTable := Q.FieldByName('SOURCE_TABLE').AsInteger;
          R.SourceID := Q.FieldByName('SOURCE_ID').AsInteger;
          Rows.Add(R);
          Q.Next;
        end;
        Q.Close;
        fTrans.Commit;
      except
        if fTrans.Active then
          fTrans.Rollback;
        raise;
      end;

      for Idx := 0 to Rows.Count - 1 do
      begin
        R := Rows[Idx];
        if Terminated or fTokenBroken then
          Break;

        // 1. destinatia
        if not ResolveChat(R.Channel, Ch, Skip) then
        begin
          if Skip <> '' then
          begin
            ExecUpdate('UPDATE TELEGRAM_MESSAGES SET SENT_STATUS = ' + IntToStr(stsIgnored) +
              ', LAST_ERROR = :ERR WHERE TGMSGID = :ID', R.ID, [Skip]);
            Inc(Updated);
          end
          else
            LogOnce('Lipseste chat-ul pentru canalul "' + R.Channel +
              '" si DEFAULT_CHAT_ID - mesajele raman in coada.');
          Continue;
        end;
        if fChatPausedUntil.TryGetValue(Ch.ChatId, Paused) and (Now < Paused) then
          Continue;

        // 2. textul (comenzi / finantari: construit acum, dupa commit)
        BuiltText := '';
        if not R.HasText then
        begin
          fTrans.StartTransaction;
          try
            Q.SQL.Text := 'SELECT B.MSG_TEXT, B.PARSE_MODE FROM SP_TELEGRAM_BUILD_TEXT(:ST, :SID) B';
            Q.ParamByName('ST').AsInteger := R.SourceTable;
            Q.ParamByName('SID').AsInteger := R.SourceID;
            Q.Open;
            if not Q.Eof then
            begin
              BuiltText := Q.FieldByName('MSG_TEXT').AsString;
              R.ParseMode := Trim(Q.FieldByName('PARSE_MODE').AsString);
            end;
            Q.Close;
            fTrans.Commit;
          except
            if fTrans.Active then
              fTrans.Rollback;
            raise;
          end;
          R.Text := BuiltText;
        end;
        if Trim(R.Text) = '' then
        begin
          ExecUpdate('UPDATE TELEGRAM_MESSAGES SET SENT_STATUS = ' + IntToStr(stsIgnored) +
            ', LAST_ERROR = :ERR WHERE TGMSGID = :ID', R.ID,
            ['Nimic de trimis (text gol sau document sters)']);
          Inc(Updated);
          Continue;
        end;

        // 3. ritmul pe chat
        if fChatLastSend.TryGetValue(Ch.ChatId, LastTick) then
        begin
          Elapsed := GetTickCount64 - LastTick;
          if Elapsed < cMinChatIntervalMs then
            Sleep(cMinChatIntervalMs - Elapsed);
        end;

        // 4. trimiterea
        Note := '';
        Res := TelegramSendMessage(fToken, Ch.ChatId, Ch.ThreadId, R.Text, R.ParseMode, Ch.Silent);
        if Res.IsParseError and (R.ParseMode <> '') then
        begin
          Note := 'HTML respins (' + Res.Description + '), trimis ca text simplu';
          Res := TelegramSendMessage(fToken, Ch.ChatId, Ch.ThreadId, TelegramStripHtml(R.Text), '', Ch.Silent);
        end;
        fChatLastSend.AddOrSetValue(Ch.ChatId, GetTickCount64);

        // 5. rezultatul
        if Res.Ok then
          ExecUpdate('UPDATE TELEGRAM_MESSAGES SET FLG_SENT = 1, SENT_STATUS = ' + IntToStr(stsSent) +
            ', TG_MESSAGE_ID = :MID, LAST_ERROR = :ERR, MSG_TEXT = COALESCE(MSG_TEXT, :TXT) ' +
            'WHERE TGMSGID = :ID', R.ID,
            [Res.MessageId, NullIfEmpty(Copy(Note, 1, 500)), NullIfEmpty(BuiltText)])
        else if (Res.HttpCode = 401) or (Res.HttpCode = 404) then
        begin
          // token gresit: nu ardem incercarile mesajelor, asteptam corectarea
          fTokenBroken := True;
          Log(Format('Token Telegram respins (HTTP %d: %s) - corectati BOT_TOKEN.', [Res.HttpCode, Res.Description]));
          Break;
        end
        else if (Res.HttpCode = 429) or (Res.ErrorCode = 429) then
        begin
          DelaySec := Res.RetryAfter;
          if DelaySec <= 0 then
            DelaySec := 30;
          fChatPausedUntil.AddOrSetValue(Ch.ChatId, IncSecond(Now, DelaySec));
          ExecUpdate('UPDATE TELEGRAM_MESSAGES SET SENT_STATUS = ' + IntToStr(stsRetry) +
            ', LAST_ERROR = :ERR, NEXT_SEND_TIME = DATEADD(' + IntToStr(DelaySec) +
            ' SECOND TO CURRENT_TIMESTAMP) WHERE TGMSGID = :ID', R.ID,
            ['429: ' + Copy(Res.Description, 1, 480)]);
        end
        else
        begin
          Attempt := R.RetryCount + 1;
          if Attempt >= cMaxAttempts then
          begin
            ExecUpdate('UPDATE TELEGRAM_MESSAGES SET RETRY_COUNT = :RC, SENT_STATUS = ' + IntToStr(stsFailed) +
              ', LAST_ERROR = :ERR WHERE TGMSGID = :ID', R.ID,
              [Attempt, Copy(Format('HTTP %d: %s', [Res.HttpCode, Res.Description]), 1, 500)]);
            Log(Format('Mesajul %d nu a putut fi trimis dupa %d incercari: HTTP %d %s',
              [R.ID, Attempt, Res.HttpCode, Res.Description]));
          end
          else
            ExecUpdate('UPDATE TELEGRAM_MESSAGES SET RETRY_COUNT = :RC, SENT_STATUS = ' + IntToStr(stsRetry) +
              ', LAST_ERROR = :ERR, NEXT_SEND_TIME = DATEADD(' + IntToStr(cRetryDelaysMin[Attempt]) +
              ' MINUTE TO CURRENT_TIMESTAMP) WHERE TGMSGID = :ID', R.ID,
              [Attempt, Copy(Format('HTTP %d: %s', [Res.HttpCode, Res.Description]), 1, 500)]);
        end;
        Inc(Updated);
      end;
      Inc(Result, Updated);
      // lot plin si s-a miscat ceva -> mai luam unul; altfel asteptam
    until Terminated or fTokenBroken or (Rows.Count < cBatchSize) or (Updated = 0);
  finally
    Q.Free;
    Rows.Free;
  end;
end;

procedure TSWNTelegramService.Execute;
var
  Sent: Integer;
begin
  NameThreadForDebugging('SWNTelegramService');
  Log('Pornit.');
  while not Terminated do
  begin
    try
      if not Connected then
        Connect
      else
        CheckAlerter;

      if Connected then
      begin
        if (fConfigLoadedAt = 0) or (MinutesBetween(Now, fConfigLoadedAt) >= cConfigReloadMin) then
          LoadConfig;
        FlushLocalQueue;
        if (fToken <> '') and not fTokenBroken then
        begin
          Sent := ProcessQueue;
          if Sent > 0 then
            Log(Format('Prelucrate %d mesaje.', [Sent]));
        end;
      end;
      WaitInterruptible(cIdleWaitMs);
    except
      on E: Exception do
      begin
        LogOnce('EROARE ' + E.ClassName + ': ' + E.Message);
        Disconnect;
        // erorile serviciului adunate intre timp pleaca direct
        try
          FlushLocalQueue;
        except
        end;
        WaitInterruptible(cReconnectWaitMs);
      end;
    end;
  end;
  Disconnect;
  Log('Oprit.');
end;

end.

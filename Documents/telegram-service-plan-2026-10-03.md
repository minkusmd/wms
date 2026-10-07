# TSWNTelegramService — plan (3 oct 2026)

Notificări Telegram pentru utilizatorii interni WMS: orice procedură/trigger din Firebird
adaugă un rând în `TELEGRAM_MESSAGES`, triggerul AI face `POST_EVENT 'NEW_TELEGRAM'`,
iar SWNService (prin `TIBCAlerter`) citește rândurile noi și le trimite în canalul Telegram
potrivit. Tiparul copiază `SMS_MESSAGES` (care are deja `post_event 'NEW_SMS'`).

## Stare implementare (3 oct 2026)

| Pas | Stare |
|---|---|
| `DB Model/telegram_messages.sql` (+ `_rollback.sql`) | testat pe bază locală cu stub-uri; **rulat pe SW 3 oct 2026** (verificat: obiecte active/valide, drepturi, canale WEB_ORDERS/ERRORS fără CHAT_ID, BOT_TOKEN gol, `SP_TELEGRAM_BUILD_TEXT` corect pe 2181201 / 2181108) |
| `sources/Utils/TelegramApiUnit.pas` | gata |
| `DB Service/TelegramServiceUnit.pas` + `ServiceMain.pas` | compilat (`SWNService.exe`), testat cap-coadă contra bazei locale și a unui server care imită Telegram: eveniment → trimis sub 1 s, restanța trimisă la pornire, HTML invalid → text simplu, 429, 500 → reîncercare, token greșit → coada neatinsă |
| `sources/classes/Telegram/frmTelegramDialog` + meniu Setări > Notificări Telegram | compilat; `SWN.exe` nelinkat (era deschis, F2039); netestat în UI |

Abateri față de planul de mai jos:
- Orice eroare Telegram în afară de 401/404 (token) și 429 trece prin schema de reîncercări, inclusiv 400 „chat not found” / 403. Asta lasă ~80 de minute pentru corectarea unui canal, fără să se piardă mesaje.
- 429 nu consumă o încercare. 401/404 nu ating rândurile: serviciul așteaptă corectarea tokenului (recitit la 5 minute).
- Tranzacția serviciului nu are `read_committed` / `rec_version` în TPB: pe FB5 intră în conflict cu `read_consistency` pus de IBDAC.
- În dialog există și butonul „Află chat ID” (`getUpdates`).
- Variabila `TelegramApiBaseUrl` permite testarea cu un server local.

## Decizii luate

| Subiect | Decizie |
|---|---|
| Unde rulează | Fir `TSWNTelegramService` (TThread) în **SWNService**, pornit/oprit din `ServiceStart`/`ServiceStop`; conexiunea din `settings.dat`; jurnal `<folder de lucru>\telegram.log` |
| Destinații | Mai multe canale pe cod: tabela `TELEGRAM_CHANNELS`; rândul de mesaj indică `CHANNEL_CODE` |
| Configurare | `TS_API_CONFIG`, `API_CODE = 'TELEGRAM'`: `BOT_TOKEN`, `DEFAULT_CHAT_ID` (cod lipsă → canalul implicit) |
| Format | `PARSE_MODE`: NULL = text simplu, `'HTML'` = HTML; dacă Telegram respinge HTML-ul, se retrimite automat ca text simplu |
| Reîncercări | 5 încercări, pauze 1 / 5 / 15 / 60 min; la 429 se respectă `retry_after`; apoi status „eșuat” + `LAST_ERROR` |
| Mesaje vechi | Se trimit **toate** cele netrimise, indiferent de vârstă |
| UI WMS | Dialog: canale + „Trimite test” + istoric cu filtru și „Retrimite” |
| Surse inițiale | Infrastructura + comenzi web/finanțări + alertă SMS netrimis + erori joburi serviciu |

## 1. Baza de date — `DB Model/telegram_messages.sql` (repetabil, testat local, rulat de DBA)

### `TELEGRAM_CHANNELS`
| Coloană | Tip | Note |
|---|---|---|
| `CHANNEL_CODE` | VARCHAR(32) PK | `WEB_ORDERS`, `ERRORS`, ... |
| `TITLE` | VARCHAR(128) | |
| `CHAT_ID` | VARCHAR(32) NOT NULL | ex. `-100xxxxxxxxxx` |
| `THREAD_ID` | INTEGER | topic într-un supergrup (opțional) |
| `FLG_SILENT` | DM_BOOLEAN_NN | `disable_notification` (ex. erori noaptea) |
| `FLG_ACTIVE` | DM_BOOLEAN_NN | inactiv → mesajele primesc status 4 „ignorat” |
| `NOTE` | VARCHAR(255) | |

Rânduri inițiale: `WEB_ORDERS`, `ERRORS` (CHAT_ID se completează din dialog).

### `TELEGRAM_MESSAGES` (după modelul `SMS_MESSAGES`)
| Coloană | Tip | Note |
|---|---|---|
| `TGMSGID` | DM_INTEGER_NN PK | `SQ_TELEGRAM_MESSAGES_ID` |
| `DATA_CREATED` | DM_DATETIME | din trigger |
| `CHANNEL_CODE` | VARCHAR(32) | NULL → `DEFAULT_CHAT_ID` |
| `MSG_TEXT` | VARCHAR(4000) | limita Telegram e 4096 caractere; NULL dacă textul se construiește la trimitere (vezi `SOURCE_*`) |
| `PARSE_MODE` | VARCHAR(10) | NULL / `'HTML'` |
| `NEXT_SEND_TIME` | DM_DATETIME | |
| `FLG_SENT` | DM_BOOLEAN_NN | |
| `RETRY_COUNT` | DM_SMALLINT_NN | |
| `DATA_DELIVERED` | DM_DATETIME | din trigger BU |
| `SENT_STATUS` | DM_INTEGER | 0 nou, 1 trimis, 2 de reîncercat, 3 eșuat, 4 ignorat |
| `LAST_ERROR` | VARCHAR(500) | |
| `TG_MESSAGE_ID` | BIGINT | `message_id` întors de Telegram |
| `SOURCE_TABLE` | DM_INTEGER | cine a creat (tip document / sursă) |
| `SOURCE_ID` | DM_INTEGER | ID-ul obiectului (ex. DOCID) |
| `CREATED_BY` | DM_INTEGER | din `RDB$GET_CONTEXT('USER_SESSION','UserID')` |
| `PRIORITY` | DM_INTEGER | default 0 |

- Index parțial (Firebird 5): `(NEXT_SEND_TIME) WHERE FLG_SENT = 0`.
- Triggere: `BI` (ID, dată, `RETRY_COUNT=0`, `NEXT_SEND_TIME`, `CREATED_BY`, `PRIORITY`) — **fără** deduplicarea ciudată din `TRG_SMS_MESSAGES_BI`; `BU` (`DATA_DELIVERED` la `FLG_SENT=1`); `AI` → `POST_EVENT 'NEW_TELEGRAM'`; `AU` → `POST_EVENT 'NEW_TELEGRAM'` când un rând e resetat la netrimis (butonul „Retrimite”).
- `POST_EVENT` ajunge la ascultători abia la COMMIT, deci serviciul vede doar rânduri comise.

### Proceduri
- `SP_TELEGRAM_SEND(CHANNEL_CODE, MSG_TEXT, PARSE_MODE = NULL, SOURCE_TABLE = NULL, SOURCE_ID = NULL, PRIORITY = 0)` — punctul unic de intrare pentru proceduri/triggere.
- `SP_TELEGRAM_BUILD_TEXT(SOURCE_TABLE, SOURCE_ID) RETURNS (MSG_TEXT, PARSE_MODE)` — chemată de serviciu când `MSG_TEXT IS NULL`. Textul se construiește **la trimitere** (după commit-ul tranzacției care a creat documentul), deci suma, liniile și clientul sunt deja completate; formatul se schimbă în baza fără recompilarea serviciului.

### `TS_API_CONFIG`
Rânduri `API_CODE='TELEGRAM'`: `BOT_TOKEN` (gol în script — tokenul nu intră în git), `DEFAULT_CHAT_ID`.

## 2. Client Telegram — `sources/Utils/TelegramApiUnit.pas` (nou, ASCII)

`TelegramBot.pas` existent rămâne neatins (aruncă excepție la orice cod ≠ 200, nu citește `retry_after`).
Unit nou, folosit și de serviciu, și de dialogul WMS:

```pascal
TTelegramSendResult = record
  Ok: Boolean;
  HttpCode, ErrorCode, RetryAfter: Integer;  // RetryAfter din parameters.retry_after (429)
  MessageId: Int64;
  Description: string;
  function IsRetryable: Boolean;             // retea, 5xx, 429
  function IsParseError: Boolean;            // 400 "can't parse entities"
end;

function TelegramSendMessage(const AToken, AChatId: string; AThreadId: Integer;
  const AText, AParseMode: string; ASilent: Boolean): TTelegramSendResult;
function TelegramGetMe(const AToken: string; out AInfo: string): Boolean;
function TelegramStripHtml(const AText: string): string;
function TelegramEscapeHtml(const AText: string): string;
```

`THTTPClient` (WinHTTP, TLS din Windows), POST JSON UTF-8, fără excepții spre apelant.

## 3. Serviciul — `DB Service/TelegramServiceUnit.pas` (nou, ASCII)

`TSWNTelegramService = class(TThread)`:

1. **Pornire**: conexiune de lucru (`settings.dat` + `PROC_USER_LOGIN`, ca `TSQLThread.DoSQLAction`) și o **a doua conexiune** doar pentru `TIBCAlerter` (`Events = NEW_TELEGRAM`, `EventHandler = ehNativeAlerter` — evenimentul vine din firul intern IBDAC; `ehWindowMessage` implicit nu merge într-un serviciu). `OnEvent` doar face `fWake.SetEvent`.
2. Citește `TS_API_CONFIG` (`TELEGRAM`) și `TELEGRAM_CHANNELS` (recitite la fiecare 5 min). Lipsă token / inactiv → scrie în jurnal și așteaptă, fără să oprească SWNService. `getMe` la pornire, rezultatul în jurnal.
3. **Bucla**: `ProcessQueue` → `fWake.WaitFor(60 s)`. Timeout-ul de 60 s acoperă reîncercările programate (`NEXT_SEND_TIME`) și evenimentele pierdute în timpul unei deconectări.
4. **ProcessQueue**: `SELECT FIRST 50 ... WHERE FLG_SENT = 0 AND SENT_STATUS IN (0,2) AND NEXT_SEND_TIME <= CURRENT_TIMESTAMP ORDER BY PRIORITY DESC, TGMSGID`; pentru fiecare: (text din `SP_TELEGRAM_BUILD_TEXT` dacă e NULL) → trimitere → `UPDATE` într-o tranzacție scurtă **per mesaj** (o cădere nu retrimite tot lotul). Repetă până nu mai sunt rânduri.
5. **Ritm**: max ~1 mesaj/s pe chat (limita Telegram ~20/min pe grup); la 429 se oprește chat-ul respectiv `retry_after` secunde.
6. **Erori**: rețea/5xx/429 → `RETRY_COUNT+1`, `SENT_STATUS=2`, `NEXT_SEND_TIME` +1/5/15/60 min; după a 5-a → `SENT_STATUS=3`. 400 la parsarea HTML → imediat retrimis ca text simplu (`TelegramStripHtml`). 400 „chat not found” / 403 „bot was kicked” → `SENT_STATUS=3` direct (nu are sens reîncercarea).
7. **Conexiune pierdută**: închide ambele conexiuni, pauză 30 s, reconectare, apoi `ProcessQueue` (prinde ce s-a adunat între timp).
8. **Oprire**: `Terminate` + `fWake.SetEvent`, așteptare cu timeout.
9. `QueueLocal(Channel, Text)` thread-safe: pentru mesaje generate de serviciu (erorile joburilor). Firul le inserează în `TELEGRAM_MESSAGES`; dacă baza nu răspunde, le trimite direct din memorie.

Modificări în proiect: `ServiceMain.pas` (creare/pornire/oprire fir, erorile spre `QueueLocal`), `SWNService.dpr` (`TelegramServiceUnit`, `TelegramApiUnit in '..\sources\Utils\...'`). Nicio schimbare în SWNServiceManager.

## 4. Surse de mesaje (prima iterație)

| Sursă | Canal | Implementare |
|---|---|---|
| Comandă web (134) / cerere de finanțare (1791) | `WEB_ORDERS` | trigger AI pe `TDB_DOCS` pentru tipurile 134/1791 → `SP_TELEGRAM_SEND('WEB_ORDERS', NULL, 'HTML', DOCTYPEID, DOCID)`; textul (nr., client, telefon, sumă, plată, sursă UTM) în `SP_TELEGRAM_BUILD_TEXT` |
| SMS netrimis | `ERRORS` | în `TRG_SMS_MESSAGES_AU0`, lângă emailul existent; **o singură dată pe SMS** (emailul pleacă de până la 4 ori) |
| Erori joburi / proceduri programate | `ERRORS` | `TServiceSWN.WhenActionThreadTerminated` → `QueueLocal` |

Alternativa respinsă pentru 134/1791: modificarea celor 4 proceduri (`WEB_CREATE_TRANSACTION3`, `..._2_ECOMM`, `..._PHONE2`, `SP_WEB_REGISTER_FINANTARE`) — corpuri mari, trăiesc doar în bază, risc de suprascriere.

## 5. WMS — `sources/classes/Telegram/frmTelegramDialog` (nou, ASCII)

- Tab **Canale**: grilă editabilă `TELEGRAM_CHANNELS` + „Trimite test” (direct prin `TelegramApiUnit`, cu tokenul din `TS_API_CONFIG`).
- Tab **Istoric**: grilă `TELEGRAM_MESSAGES` cu filtre perioadă / canal / status; „Retrimite” (reset `FLG_SENT=0, SENT_STATUS=0, RETRY_COUNT=0, NEXT_SEND_TIME=now` → triggerul AU trezește serviciul).
- Meniu: Setări, lângă „Configurări API”; unitul adăugat în `SWN.dpr`.

## 6. Ordinea lucrului

1. DDL + proceduri, testat pe baza locală (insert manual → `POST_EVENT` vizibil).
2. `TelegramApiUnit` + test cu un bot real.
3. `TelegramServiceUnit` + integrare în SWNService; compilare `SWNService.dproj`.
4. Surse: trigger `TDB_DOCS`, `SP_TELEGRAM_BUILD_TEXT`, alerta SMS, erori joburi.
5. Dialog WMS; compilare `SWN.dproj`.
6. Test local cap-coadă: insert → mesaj în ~1 s; rețea tăiată → reîncercări; HTML greșit → text simplu; repornire serviciu cu coadă plină.
7. DBA rulează scriptul pe SW; se instalează noul `SWNService.exe`.

## Pregătire din partea ta (Telegram)

1. Bot nou la @BotFather → token.
2. Canal/grup intern; botul adăugat ca **administrator** (în canal poate posta doar adminul).
3. Chat ID: un mesaj în canal, apoi `getUpdates` (sau „Trimite test” din dialog după ce e gata).
4. Tokenul și chat ID-urile se introduc din WMS, nu în cod.

## Puncte de verificat la implementare

- Serverul pe care rulează SWNService are acces HTTPS ieșire spre `api.telegram.org`.
- Doc. 134/1791 pot fi create și manual din WMS? Dacă da, triggerul filtrează după utilizatorul/sursa site-ului.
- `deals_web_order_info.sql` așteaptă încă DBA → `SP_TELEGRAM_BUILD_TEXT` nu se bazează pe coloanele noi din `TDB_DEALS`.
- `TRG_SMS_MESSAGES_AU0`: condiția exactă pentru „o singură dată”.

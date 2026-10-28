# PriceImport — import automat de pricelisturi (Python)

Se încarcă atunci când lucrul se face în `PriceImport/`. Regulile generale (codare, build Delphi) sunt în `CLAUDE.md` din rădăcină. Alături stă `AGENTS.md`, o copie identică: ține-le pe amândouă la fel.

Plan și decizii: `Documents/plan-import-automat-pricelisturi-2026-10-27.md`. **Acum e etapa 2 (aplicarea), oprită implicit.** Fără comutatoare, serviciul doar citește pricelisturile, le compară cu `TS_GOODS_FOREIGN`, aplică pragurile și trimite raportul (dry-run). Prețurile se aplică doar dacă **amândouă** comutatoarele sunt pornite:
- `PI_APPLY_ENABLED=true` (global);
- `TPI_SUPPLIER.FLG_AUTO_APPLY = 1` (per furnizor).

## Aplicarea (etapa 2)

- **Fluxul:** `apply.py` construiește rândurile (regulile `BuildRow` din `Parsers/PriceListReevaluationUnit.pas`, portate 1:1). Le pune în `TPI_APPLY_BATCH` / `TPI_APPLY_ROW`, iar `SP_PI_APPLY_KIND` (SQL SECURITY DEFINER) face câte un document 1414 per tip: 0 noi, 1 vechi, 2 mărite, 3 scăzute. Fiecare document trece prin `SP_CREATE_NEW_DOCUMENT` → `TDB_GOODS_PRICE` → `ADJUST_RRP_REEVALUATION` → `CLOSE_REEVALUARE`, iar produsul respins („goodscode: X [...]”) se scoate și închiderea se reia, ca în WMSParsers. Fiecare tip e o tranzacție. Închiderile trec pe rând (`APPLY_LOCK`).
- **Firma și utilizatorul documentelor:** `TPI_SUPPLIER.FIRMAID`, altfel `PI_DEFAULT_FIRMA_ID` (307225 PRIME STORE); utilizatorul `PI_WMS_USER_ID` (204), la fel ca WMSParsers.
- **Când se aplică:** doar rulările cu `TPI_RUN.BASELINE = 'gf'`. Baza `prev` (PLID deja prelucrat de WMS) nu se aplică niciodată și nu creează carantină. Un PLID cu `FLAGS` 16 se aplică doar dacă l-a prelucrat chiar PriceImport (aprobări ulterioare).
- **Adaptoarele native** scriu întâi pricelistul în `TS_PRICELISTS` (`FLAGS = 2`, `CREATED_BY` = utilizatorul WMS), apoi aplică din el. La final PLID-ul primește `FLAGS` bitul 4 (prelucrat).
- **Carantina** (`TPI_QUARANTINE`): rândurile cu motiv propriu (nu `ITEM_QUARANTINED`). O rulare nouă pe baza `gf` le marchează pe cele vechi `SUPERSEDED`. Aprobarea trece produsul întreg pe APPLY, iar aceeași valoare (coloană + preț nou + monedă) trece automat la rulările din următoarele 30 de zile. Produsele respinse de `CLOSE_REEVALUARE` intră în carantină cu `CLOSE_REJECTED`.
- **Anularea:** `rollback RUNID` creează un document 1414 compensatoriu cu valorile vechi, fără `ADJUST_RRP` (PRICE3 vechi e deja ajustat). Produsele schimbate de o rulare ulterioară se sar (`CHANGED_LATER`).
- **Alertele** din `ERRORS` sunt deduplicate în `TPI_ALERT_STATE` (cheia `RUN|furnizor|status|clasă`, cel mult o dată la `PI_ALERT_REPEAT_MIN`, „rezolvat” o singură dată). `SP_PI_WATCHDOG` e dead man's switch-ul (heartbeat + fereastră nerulată) și **trebuie programat în SWNService** la 15 minute.
- **Outbox pentru site:** `TPI_GOODS_EVENT` (GOODSID + PRICE/STOCK). Încă nu îl consumă nimeni (Yii2 cache / Meilisearch / Laravel).
- **DDL:** `DB Model/price_import_stage2.sql` (+ `_rollback.sql`, `price_import_stage2_grants.sql`). PRICEIMPORT nu primește UPDATE pe `TS_GOODS_FOREIGN`, `TDB_DOCS` sau `TDB_GOODS_PRICE`: testul de integrare verifică asta, ca utilizator PRICEIMPORT în mod embedded.

## Structură

- `src/priceimport/adapters/`: câte un adaptor per sursă, înregistrat în `adapters/__init__.py` (`ADAPTERS`, cheia = `TPI_SUPPLIER.ADAPTER_CODE`).
  - `external_plid` citește cel mai nou `TS_PRICELISTS` creat de WMSParsers, frame78 sau `ultra2_sync.py`.
  - `agropiese` e un adaptor nativ pe API (respectă regulile din `AgroPiesePriceListUnit.pas`).
  - `accent`, `dmlink`, `olisgrup`, `nex`, `triomac` sunt portate din WMSParsers (etapa 4c, vezi mai jos).
  - Clientul HTTP comun (`http.py`) are timeouts, retry cu backoff + jitter, `Retry-After`, rate limit, fără retry la 401/403 și ascunde token-urile din mesaje.
- `diff.py` reproduce cele 4 reevaluări WMS (baza `gf`). Când WMS a prelucrat deja PLID-ul (`TS_PRICELISTS.FLAGS` valoarea 16), compară cu pricelistul precedent (baza `prev`). RRP-ul se compară după `TS_CUSTOMER.RRP_DISCOUNT`, exact ca `ADJUST_RRP_REEVALUATION`. Un produs „dispărut” devine GONE abia la a doua lipsă.
- `thresholds.py` face carantina pe rând: prag ±, preț 0/negativ, monedă schimbată/greșită (factor ≈ curs), preț absurd. Cât timp o coloană a produsului e în carantină, tot produsul rămâne în carantină. Tot aici sunt gărzile de rulare (EMPTY, VOLUME, INVALID_ROWS, DUPLICATES, MASS_SHIFT) → statusul BLOCKED.
- `coordinator.py` rulează un furnizor: lacăt, etape, jurnal `TPI_RUN`, payload brut arhivat în `data/raw`. `preview_supplier` face aceeași analiză fără nicio scriere.
- `windows.py` gestionează ferestrele (ordine după prioritate și durată, maximum `PI_MAX_PARALLEL`, un adaptor per host, termene soft/hard) și trimite raportul. `service.py` conține scheduler-ul APScheduler + heartbeat-ul.
- `repo.py` adună **tot** SQL-ul. Biții: `TS_GOODS_FOREIGN.FLAGS` bitul 3 = în pricelist (valoarea 8), bitul 4 = EPP (16); `TS_PRICELISTS.FLAGS` valoarea 2 = API, 16 = prelucrat.

## Botul Telegram pentru furnizorii manuali (etapa 3)

- **Procesul:** `pi bot` (`bot/runner.py`, long polling peste `httpx`, fără aiogram). Offset-ul `getUpdates` stă în `TPI_BOT_STATE`, iar heartbeat-ul în `TPI_HEARTBEAT` cu `pi-bot`. Tokenul vine din `PI_BOT_TOKEN` / `PI_BOT_TOKEN_FILE` și trebuie să fie un **bot separat** de cel al SWNService, pentru că `getUpdates` acceptă un singur consumator. `log.mask_secrets` ascunde tokenul din URL-uri (`bot***`).
- **Accesul:** doar utilizatorii din `TPI_BOT_USER` (`pi bot-user ID NUME --role VIEW|APPLY`). Unui necunoscut i se răspunde cu ID-ul lui, ca să poată fi adăugat.
- **Fluxul unui fișier** (`bot/handler.py`):
  1. Se verifică extensia (`.xlsx .xls .xlsb .ods .csv`) și mărimea (≤ 20 MB).
  2. Fișierul se descarcă și se salvează în `data/inbox/<sha256>.<ext>` (numele pe disc nu vine de la utilizator), iar în `TPI_INBOX_FILE` primește un rând. Același `file_unique_id` sau același conținut = mesaj „primit deja”.
  3. `recognize.py` caută furnizorul: `#ID` în text decide singur; altfel se combină (noisy-or) regulile din `TPI_FILE_RULE` și suprapunerea codurilor cu `TS_GOODS_FOREIGN`. Decizia e automată doar la un scor ≥ 0.9 cu un câștigător clar și doar pentru furnizorii cu `ADAPTER_CODE = 'excel'`. Altfel botul pune butoane, sau se răspunde la mesajul lui cu `#ID`.
  4. Previzualizarea e `run_supplier(..., allow_apply=False, idempotency_key=furnizor|tg|sha256)`, plus mesajul de raport și fișierul .xlsx.
  5. Butonul „Aplică” (doar cu rolul APPLY, cu `PI_APPLY_ENABLED` și o previzualizare de ≤ `PI_PREVIEW_MAX_AGE_HOURS`) recitește fișierul și face `apply_items` (snapshot în `TS_PRICELISTS` + documentele 1414). „Doar raport” / „Anulează” nu schimbă prețuri.
  6. Semnătura antetului se învață automat (`HEADER_SIG`, `FLG_LEARNED = 1`).
- **Comenzi:** `/status`, `/carantina [ID]`, `/aproba QID…`, `/respinge QID…`, `/run ID` (furnizori cu API), `/mute ID [ore]`; deciziile cer rolul APPLY.
- **Excel (`excelparse.py`, adaptorul `excel`):**
  - Antetul se caută în primele 40 de rânduri, cu alias-uri RO/RU/EN: cod, denumire, preț cost / indicativ / RRP, stoc, monedă, brand, categorie, EAN. Se suprascriu din `suppliers/<id>.yaml` (`columns: {câmp: {header: regex}}` sau `{column: "C"}`, `currency`, `file.sheet.name_re`).
  - Șablonul `template: wms16` = cele 16 coloane fixe ale importului din frame78.
  - Rândurile-titlu (o singură celulă cu text, des chiar în coloana codului) devin categoria rândurilor de sub ele.
  - Un singur preț = PRICE0 = PRICE7 (convenția furnizorilor fără cost separat).
  - Produsele fără stoc și cele fără preț se sar; codurile repetate se numără.
  - Fișierele zip mai mari de 200 MB decomprimat se refuză.
- **Furnizor manual nou:** `pi supplier-add ID` (excel, B, fără ferestre, fără aplicare automată) → `pi mapping-suggest fișier.xlsx` → YAML în `suppliers/ID.yaml`, doar dacă alias-urile nu ajung. Fără bot: `pi import-file ID fișier.xlsx [--apply]`.

## Potrivirea produselor noi (etapa 4a)

- **Unde:** `matching.py` + `matchjob.py`. Codurile nelegate (NEW) din ultima rulare a fiecărui furnizor primesc până la 3 propuneri. Rulează zilnic la `PI_MATCH_TIME` (21:30), sau la cerere cu `pi match [ID]`.
- **Metode:**
  - `EAN`: același cod de bare la alt furnizor;
  - `CODE`: același cod normalizat la alt furnizor;
  - `MPN`: un cod de producător găsit în denumirea sau modelul unui singur produs din catalog;
  - `FUZZY`: denumirea seamănă (rapidfuzz), inclusiv RU ↔ RO.
- **Gărzile găsite pe datele reale din SW:**
  - **`CODE` / `MPN` cer brand sau cuvinte comune:** plăcuțele `B111152` nu sunt puzzle-ul `B-111152`.
  - **Măsurile nu trec drept coduri:** `114cm`, `2000W`, `80W90`, `R16`.
  - **Numerele din nume trebuie să se regăsească la produsul propus,** cu Jaccard ≥ 0.6. Cifra generației contează (Pilot Sport 5 ≠ Pilot Super Sport), la fel 12V ≠ 24V la becuri.
  - **Potrivirea după nume cere ≥ 2 cuvinte comune.** Denumirile fără numere, de 1–2 cuvinte („Фильтр воздушный”), nu se potrivesc deloc.
  - **Brandul diferit înmulțește scorul cu 0.6.**
  - **Se salvează doar propunerile cu scor ≥ 0.85** (`MIN_SCORE`). La prima rulare pe SW, cele sub prag erau mai mult greșite (alt model din aceeași gamă).
- **Indexul:** catalogul (~310 000 de produse, ~20 s) se construiește o dată per proces (`get_index`, TTL 6 h).
- **Nimic nu se leagă automat.** Propunerile stau în `TPI_MATCH_CANDIDATE` și se decid cu `pi match-accept / match-reject CANDID --by nume` sau din bot (`/potriviri`, ✓ / ✗, rolul APPLY).
- **Legarea:** `SP_PI_LINK_GOODS` (DEFINER) adaugă un rând în `TS_GOODS_FOREIGN` cu FLAGS = 0, adică în afara pricelistului și fără prețuri. Produsul intră în preț la următoarea rulare, ca „produs nou”. Respingerea rămâne memorată (nu se mai propune).
- **Raportul ferestrei** arată câte propuneri așteaptă o decizie.

## Adaptoarele portate din WMSParsers (etapa 4c)

- **Ce sunt:** cele 5 importuri API din `Parsers/PriceListApiJobsUnit.pas`, rescrise 1:1 (doar prețurile; descrierile și imaginile rămân la WMSParsers / frame78 până la etapa 4b). Regulile fiecărui furnizor sunt în docstring-ul modulului lui; câmpurile JSON se citesc cu `adapters/jsonval.py` (`JStr` / `JFloat` / `JLang` din Delphi: lipsă = "" sau 0).
  - `accent` (198): login `/loginuser/getid` → `guid` → `/hard/{guid}/catalogandstock/0`. Intră doar ce are `qty > 0`. PRICE0 = `price`, PRICE7 = `dprice1` (USD), PRICE3 = `promoprice` (mereu lei). Datele de acces erau scrise în `ApiAccentUnit.pas`: acum se citesc din `TS_API_CONFIG` `ACCENT`.
  - `dmlink` (229466): tot catalogul vine într-un singur răspuns (~35 MB, timeout 300 s). Produsele cu `stock <= 0` se sar. Un sku repetat între produsele cu stoc se sare **la toate aparițiile**. PRICE0 = `nprice`, altfel `sprice`.
  - `olisgrup` (251465): feed fără autentificare. PRICE0 = PRICE7 = `pret_online`, PRICE3 = `pret_vinz`. **Din ~14 oct 2026 feed-ul nu mai are `pret_online`**, deci prețul de achiziție e 0 la toate produsele (și la WMS). Adaptorul dă avertismentul `NO_COST_PRICE`, iar produsele legate ajung în carantină cu „preț 0”.
  - `nex` (275640): cheia `api-token` se obține prin GraphQL (login → `user.api_token`, iar `generateApiToken` doar dacă lipsește). Paginile se citesc secvențial. Un RRP sub jumătate din `price_mdl` e în EUR și se convertește.
  - `triomac` (209280): SCOP v2 (`/auth/token`, cursor). Stocul e suma culorilor. Un sku repetat la același preț adună stocul, altfel rămâne primul. **EUR se rezolvă după TITLE (976)**, nu 978 ca în Delphi.
- **Categoria pricelistului:** cea a ultimului pricelist al furnizorului (`PRICE_CATEGORYID > 0`), altfel `default_price_category` al adaptorului, ca în WMSParsers. Se aplică doar când `TPI_SUPPLIER.PRICE_CATEGORYID` ≤ 0.
- **Echivalența:** `pi compare-source ID --adapter X [--plid P]` descarcă prin adaptorul nou și compară câmp cu câmp cu un PLID creat de Delphi, fără nicio scriere. Pe SW (28 oct): prețurile, codurile și brandurile coincid. Diferențele vin din timpul scurs de la PLID-ul vechi și din diacriticele pierdute de importul vechi (`ș` → `?`).
- **Comutarea:** `DB Model/price_import_stage4c.sql` trece `TPI_SUPPLIER.ADAPTER_CODE` pe adaptoarele native. Accent se mută doar dacă parola e înlocuită în script. **Rulat pe SW pe 28 oct 2026** (toți 5 comutați, inclusiv Accent). Rollback: `_rollback.sql`, care revine la `external_plid`. **WMSParsers rămâne programat pentru prețuri** cât timp acești furnizori au `FLG_AUTO_APPLY = 0`: până atunci serviciul doar descarcă și raportează (adaptoarele native scriu pricelistul în `TS_PRICELISTS` doar când aplică).
- Coloanele pe care pricelistul nativ nu le mai scrie (`WARANTY`, `SUPPLIER_GOODSTYPE`, `PRODUCT_LINK`) nu sunt folosite de reevaluări.

## Conținutul produselor (etapa 4b)

- **Unde:** `content.py` (jobul) + `content_images.py` (descărcarea). Rulează la `PI_CONTENT_TIMES` (11:00 și 22:00, în afara ferestrelor de preț), sau la cerere cu `pi content [ID] [--dry]`. Intră furnizorii activi al căror adaptor are `has_content`: `dmlink`, `olisgrup`, `nex`, `triomac`. Accent nu intră: imaginile lui vin prin FTP, pe alt flux.
- **Sursa:** catalogul se descarcă din nou prin adaptor. Conținutul unei poziții vine din elementul `raw_payload[row_no - 1]` (`content_of`), deci se iau exact pozițiile pricelistului (cu stoc, fără coduri ambigue). Textul se construiește ca în Delphi: HTML, tabele de caracteristici cu `TNetEncoding.HTML.Encode` (doar `& < > "`), rânduri separate cu CRLF. DMLink scrie doar `DESCRIPTION_RO`.
- **Pașii:**
  1. **Staging-ul** (`TS_PRICELIST_ITEMS_DESCRIPTION` / `_IMAGES`): se scrie doar descrierea cu alt text (SHA-256 calculat în bază, `CRYPT_HASH`) și doar lista de URL-uri schimbată. Lista nouă se rescrie cu `IMAGE` null, ca în Delphi. Un furnizor care nu mai trimite text sau imagini nu șterge ce era.
  2. **Imaginile** se descarcă doar pentru codurile **legate de un produs fără nicio imagine**, singurele pe care pasul 3 le poate copia. Celelalte rămân cu URL-ul („amânate”) până devin utile; `PI_CONTENT_DOWNLOAD_ALL=true` le descarcă pe toate, ca WMSParsers.
     - Descărcarea: `PI_CONTENT_THREADS` fire, 3 încercări per imagine, PNG cu latura de cel mult 1200 px (Pillow).
     - Un cod se scrie doar dacă a venit măcar o imagine; altfel rămâne pentru rularea următoare.
     - Sunt acceptate doar URL-uri http(s) spre adrese publice, verificate și la fiecare redirect (anti-SSRF).
     - O imagine are cel mult 25 MB și cel mult 60 MP.
     - După `PI_CONTENT_MAX_MINUTES` descărcarea se oprește (`PARTIAL`).
  3. **Copierea în producție:** `SP_PI_CONTENT_TRANSFER(SUPPLIERID, COD, USERID)` (DEFINER), cod cu cod în ordine alfabetică, commit la 50. Regulile sunt cele din `PriceListContentTransferUnit.pas`:
     - imaginile ajung doar la produsele fără imagini, fără imaginile repetate (`HASH`);
     - descrierea creează un rând nou sau completează limba goală (sub 20 de caractere);
     - nu se suprascrie nimic.
- **Jurnalul și drepturile:** jurnalul e `TPI_CONTENT_RUN` (`pi content-status`). Serviciul nu primește drept de scriere pe `TS_GOODS_IMAGE` / `TS_GOODS_DSC`, doar `SELECT` pe `TS_GOODS_IMAGE`; testul de integrare verifică asta.

## DDL (le rulează DBA-ul)

`DB Model/price_import_stage4b.sql` (+ `_rollback`, `_grants`) = `TPI_CONTENT_RUN` + `SP_PI_CONTENT_TRANSFER`. `DB Model/price_import_stage4c.sql` (+ `_rollback`) = adaptoarele native pentru cei 5 furnizori WMSParsers + `TS_API_CONFIG` `ACCENT`. `DB Model/price_import_stage4.sql` (+ `_rollback`, `_grants`) = `TPI_MATCH_CANDIDATE` + `SP_PI_LINK_GOODS`. `DB Model/price_import_stage3.sql` (+ `_rollback`, `_grants`) = tabelele botului (`TPI_BOT_USER`, `TPI_INBOX_FILE`, `TPI_FILE_RULE`, `TPI_BOT_STATE`). `DB Model/price_import_stage1.sql` (tabelele `TPI_*`, canalul `PRICELIST_IMPORT` **inactiv**, furnizorii inițiali cu `FLG_AUTO_APPLY = 0`) + `_rollback.sql` + `price_import_grants.sql` (utilizatorul `PRICEIMPORT`, creat de DBA cu parola lui). Indexul parțial `UX_TPI_RUN_ACTIVE` (Firebird 5) garantează o singură rulare activă per furnizor. `SOURCE_TABLE = -50` în `TELEGRAM_MESSAGES`.

## Comenzi

```
.venv/Scripts/python -m pytest                       # 137 de teste; cele de integrare cer Firebird 5 local (embedded)
python -m priceimport preview 14805 --plid 6115      # analiză FĂRĂ scriere (merge și fără DDL)
python -m priceimport compare-wms 6115               # echivalența cu cele 4 interogări WMS (PLID neprelucrat)
python -m priceimport compare-source 229466 --adapter dmlink   # adaptorul nativ vs ultimul PLID Delphi, fără scriere
python -m priceimport check | run 198 | window 0 --only 198 | status | serve | health
python -m priceimport apply-test 14805               # rulare + aplicare de TEST (documente reale, apoi ROLLBACK)
python -m priceimport quarantine | approve 12 --by nume [--apply] | reject 12 --by nume | apply RUNID [--test] | rollback RUNID [--test] | mute 198 | watchdog
python -m priceimport bot | bot-user 397948500 Nume --role APPLY | supplier-add 74852 | mapping-suggest f.xlsx | import-file 74852 f.xlsx [--apply]
python -m priceimport match [ID] [--dry] | match-list | match-accept CANDID --by nume | match-reject CANDID --by nume
python -m priceimport content [ID] [--dry] [--no-download] [--no-transfer] | content-status
```

Configurarea e în variabile `PI_*` (vezi `.env.example`), iar parola în `PI_FB_PASSWORD` / `PI_FB_PASSWORD_FILE`. Parametrii unei surse stau în `suppliers/<id>.yaml`; cei operaționali (fereastră, praguri, activ) în `TPI_SUPPLIER`. Deploy-ul se face cu `compose.yaml` (Docker pe .240) sau `pi serve` sub NSSM.

## Capcane

- **EUR e 976 în `TS_CURRENCY`** (nu 978): monedele se rezolvă după `TITLE`, nu după codul ISO numeric.
- Comparația brută a RRP-ului (ca în WMS) arată la fiecare import „+RRP_DISCOUNT%” la toate produsele EPP. `compare-wms` o folosește intenționat, ca să rămână identic cu WMS.
- Pentru `external_plid`, WMSParsers/frame78 fac reevaluările imediat. După ele `TS_GOODS_FOREIGN` conține deja pricelistul, de unde vine și baza `prev`.
- Testele embedded: Firebird în mod embedded ține fișierul exclusiv, deci isql (DDL) rulează înainte de conexiunile Python, nu în paralel. `tests/schema/base_schema.sql` are un `CLOSE_REEVALUARE` **simplificat** (respinge codurile `BAD*`); procedura reală se verifică doar pe SW, cu `apply-test`.
- `httpx` scrie la INFO URL-ul complet, cu `api_token`: `log.setup_logging` îl oprește la WARNING și maschează secretele și în logurile bibliotecilor.
- Fișierele noi se scriu în UTF-8 (Python). DDL-ul din `DB Model/` rămâne ASCII.

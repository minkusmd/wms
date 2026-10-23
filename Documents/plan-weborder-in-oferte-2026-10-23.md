# Web-Order (134) → Ofertă (115) în loc: același document, alt DOCTYPEID

## Context

Azi „Creare ofertă" din Web-Order (`Tframe24WebZakaz.CreateConfigurator` → `dmDB.CreateConfiguratorDoc_DB` → `SP_CREATE_CONFIGURATOR` + `SP_CLOSE_WEBZAKAZ`) **copiază** comanda într-un document nou 115 cu `PARENTDOCID` = comanda, iar comanda rămâne închisă în Web-Order. Tot ce e legat de comandă (TWEB_TRANSACTION, plăți MIA, dosar credit TWEB_CERERE_FINANTARE, livrare, telefoane, UTM, deal) stă pe DOCID-ul vechi; oferta e o copie fără context.

Utilizatorul vrea un singur document: comanda se **mută** în Oferte prin schimbarea `DOCTYPEID` 134 → 115, păstrând DOCID. Cifre SW 2026: 1091 comenzi, 645 au ofertă (665 oferte), 425 fără urmași (422 închise direct).

Fapte verificate care fac ideea fezabilă:
- Nu există numerotare pe tip (DOCID global, `GETDOCNOBYDOCTYPE` comentat în `TRG_TDB_DOCS_BI`).
- `TDB_DOCS_AU_DEAL` reacționează deja la `DOCTYPEID` schimbat → `SP_DEAL_RECALC_STATES` (PIPE trece singur în `PIPE_IN_WORK`, deal-ul rămâne `SITE_CART_ORDER`).
- `TDB_DOCS_AU_ACNT` nu face nimic (TS_DOCTYPES.FLAGS = 0 pentru 134 și 115). `TRG_TDB_DOCS_BU0` tratează 115 și 134 la fel.
- Precedente de `UPDATE TDB_DOCS SET DOCTYPEID`: 107 ↔ 3425 (frame10 :760, frame129 :1867), 124 → 125 (frame31 :307).
- Ambele frame-uri folosesc aceleași datasete `dmDB.IBCQueryDocs` / `IBCQueryJurnal`; liniile au același model de preț.

Decizii luate (23 oct 2026): fără snapshot al liniilor inițiale; funcțiile web (Credit, Plata, MIA, cashback) merg în frame08 condiționat; Web-Order rămâne inbox (doar neprelucrate + refuzate); lansare cât mai repede, plan separat de faza 4 finanțare.

## Regula „comandă web" (înlocuiește `DOCTYPEID = 134` peste tot)

`CREATED_BY = 9` (user WEB SITE) **și** `DOCTYPEID IN (134, 115)`. Bitul 18 `FLG_WEBSHOP_ORDER` NU e bun ca marker: e pus doar pe 309 din 1071 comenzi 2026 (doar coșul, nu „1 click"). Ofertele deja copiate din comenzi au și ele `CREATED_BY = 9` (480 + 222 în 2026), deci regula e consistentă și pe istoric.

## Faza A — baza: `DB Model/weborder_to_offer.sql` (re-rulabil, + `_rollback.sql`)

Corpurile procedurilor existente se extrag cu `isql -x` de pe SW la momentul scrierii (ca la `finantare_weborder_faza2.sql`), se modifică punctual și se pun în script. Testare pe copia locală `D:\FBTestintest\SWMETA.FDB` (vezi memoria `finantare-weborder-merge-plan`).

1. **`SP_WEBORDER_TO_OFFER(A_DOCID, A_USERID, A_COMMENTS) RETURNS (DOCID)`** — nou:
   - verifică: există, `DOCTYPEID = 134`, `DELETED_DATE IS NULL`, `GET_FLG_VALUE(FLAGS,10) = 0` (comanda închisă/refuzată NU se mută; excepție `ERR_GENERAL_ERROR` cu mesaj clar);
   - `RDB$SET_CONTEXT('USER_TRANSACTION','RequireModifyDOC',1)` + `RDB$SET_CONTEXT('USER_TRANSACTION','WEBORDER_CONVERT',1)`;
   - `UPDATE TDB_DOCS SET DOCTYPEID = 115, STATEID = 1 /* Client - LID, ca orice ofertă nouă */, DATA = CURRENT_TIMESTAMP /* ca la copia de azi */, RESPONSIBLE_USERID = IIF(COALESCE(RESPONSIBLE_USERID,-1) <= 0, :A_USERID, RESPONSIBLE_USERID)`; FLAGS neschimbate (bit 10 rămâne 0, bit 18 se păstrează); liniile TDB_JURNAL rămân ca atare (nu se forțează CTDEP = -1 / FLAGS = 1 ca în copie);
   - comentariu opțional prin `SP_ADD_DOC_COMMENTS` (ca în `SP_CREATE_CONFIGURATOR`);
   - `SP_LOG_CREATE_NEW(docid, user, 'Web-Order mutat in Oferte')`;
   - `SUSPEND`.
   `SP_CREATE_CONFIGURATOR` rămâne neatins (1791 → 115 din frame51, clonare ofertă din frame08).

2. **Gardă în `TRG_TDB_DOCS_BU0`**: dacă `NEW.DOCTYPEID <> OLD.DOCTYPEID` și `OLD.DOCTYPEID IN (134,115)` și `NEW.DOCTYPEID IN (134,115)` și `RDB$GET_CONTEXT('USER_TRANSACTION','WEBORDER_CONVERT') IS NULL` → excepție „Tipul documentului se schimbă doar prin SP_WEBORDER_TO_OFFER". Motiv: `dmDB.IBCQueryDocsBeforeUpdateExecute` (DataModuleDB.pas:2090) scrie `DOCTYPEID := FCurrentDocTypeID` la orice salvare, iar `VW_TDB_DOCS_BU` îl propagă — un frame24 vechi cu rândul încărcat ar readuce documentul la 134.

3. **Proceduri cu 134 „pe sârmă"** → regula de mai sus:
   - `SP_APPLY_CASHBACK`: `SP_DOCS_INSPECTOR(...) WHERE DOCTYPEID IN (134,115) AND CREATED_BY... ` — inspectorul expune `flg_webshop_order`; condiția devine `doctypeid in (134,115) and flg_webshop_order = 1` (cashback-ul se dă doar la coș, deci bitul 18 e corect aici).
   - `SP_CANCEL_CASHBACK(FDOCID)`: azi caută copii 115 ale lui 134 și sub ele 107 cu sumă > 0. Nou: dacă documentul e el însuși 115 → verifică direct copiii 107 ai lui; altfel logica veche. Apoi `DELETE FROM TDB_DOCS_CASHBACK_USED WHERE DOCID = :FDOCID`.
   - `WEB_SET_DOC_PAYMENT_ANALYTIC` (`DB Model/payment_analytics.sql`): `DOCTYPEID IN (134, 115, 1791) AND CREATED_BY = 9`.
   - `WEB_SIGNUP_OFFER_STATUS` / `WEB_SIGNUP_OFFER_APPLY` (`DB Model/web_signup_offer.sql`): HAS_ORDERS = `DOCTYPEID IN (134,115) AND CREATED_BY = 9 AND CT = :CUSTOMERID`.
   - `SP_WEB_REGISTER_FINANTARE` D3 (`finantare_weborder_faza2.sql`): candidat = `DOCTYPEID IN (134,115) AND CREATED_BY = 9` deschis (bit 10 = 0), restul condițiilor neschimbate.
   - `SP_DEAL_RECALC_STATES`: `N_FIN` numără și `DOCTYPEID = 115 AND CREATED_BY = 9 AND DTSC IN (credit)`.
   - `SP_DEAL_SYNC_CONTACT` + `SP_DEAL_WEB_ORDER_INFO_BACKFILL` (`deals_web_order_info.sql`): `d.DOCTYPEID IN (134,115) AND d.CREATED_BY = 9`.
   - `SP_TELEGRAM_BUILD_TEXT`: când `SOURCE_TABLE = 134` și documentul a devenit deja 115, textul rămâne cel de „Comanda noua de pe site" (ramura `V_DOCTYPE = 134` devine `SOURCE_TABLE = 134`).
   - `SP_UPDATE_DATE_IN_DOCS`: nimic (115 se rulează doar cu bit 15, comportament acceptat).
   - `SP_CREATE_RASHOD`: închide părintele doar dacă e 134 → `IN (134, 115)` ca în `SP_CREATE_VINZARE_PARTENER` (oferta mutată se închide la vânzare, ca azi comanda).

4. **Granturi**: `GRANT EXECUTE ON PROCEDURE SP_WEBORDER_TO_OFFER TO PUBLIC` (după modelul celorlalte SP_* apelate din WMS; de confirmat în script cu `RDB$USER_PRIVILEGES`).

5. Fără backfill al istoricului (perechile 134 + 115 existente rămân; raportările folosesc `CREATED_BY = 9`).

## Faza B — WMS (`sources/`)

Atenție codare: `frame24WebZakazUnit.pas`, `DataModuleDB.pas`, `MainForm.pas` sunt cp1251 (editare pe octeți, numărat bytes ≥ 0x80 înainte/după); `frame08ConfigurationKonfiguratorUnit.pas` / `SWNDealsUnit.pas` — de verificat înainte. `.dfm`-uri ASCII.

1. **`DataModuleDB.pas`**
   - `MoveWebOrderToOffer_DB(const DocID: Integer; const Comments: string): Boolean` — `SELECT DOCID FROM SP_WEBORDER_TO_OFFER(:DOCID, :USERID, :CM)` în `IBCTrDefaultUpdate` cu Start/Commit/Rollback + `ProcessSWNError`, după modelul `CreateConfiguratorDoc_DB` (885-925). Fără `SP_CLOSE_WEBZAKAZ`.
   - `IBCQueryDocsBeforeUpdateExecute` (2090): pe UPDATE parametrul `DOCTYPEID` ia valoarea câmpului rândului (`Sender.FieldByName('DOCTYPEID')`), nu `FCurrentDocTypeID`; pe INSERT rămâne `FCurrentDocTypeID`. Gardă dublă cu BU0.

2. **`frame24WebZakazUnit.pas` / `.dfm`**
   - `CreateConfigurator` (369-395): confirmare „Mutarea comenzii în Oferte?", apoi `dmDB.MoveWebOrderToOffer_DB`, `FullRefresh`, mesaj „Comanda #N e acum în Oferte". UPDATE-ul de responsabil dispare (îl face procedura). Caption `bbAction_Configurator` (dfm :998) → 'Muta in "Oferte"...'.
   - `CreateRashodnaiaNakladnaia` / `CreateSciotNaOplatu` din frame24 rămân (comandă → vânzare directă fără ofertă).

3. **`frame08ConfigurationKonfiguratorUnit.pas` / `.dfm`** — funcțiile web, vizibile doar când rândul curent are `CREATED_BY = 9` (câmp existent în `IBCQueryDocs`; helper `IsWebOrderRow: Boolean`), cu aceleași drepturi ca în frame24 (`cSecurityFlag_WEB_Web_Order_Ecomm_transactii` 3250, `…Anulare_cashback` 3283, fila Credit 1792):
   - coloane noi în `cxGridBRKDBTable`: `PAYMENT_METHOD` (câmpul există deja în SQL-ul `IBCQueryDocs`), `DTSC_NAME`; rând verde deschis la credit (copie din frame24 `cxGridWZTableCustomDrawCell` 524-560);
   - MIA: `AddMiaColumn(cxGridBRKDBTable)` + `AddMiaButton(dxBarManager, popup, MiaPaymentClick)` + în `DeleteRecord` (1360) `ConfirmDeleteUnpaidMiaOrder` + `SaveMiaDeleteNote` (mutate din frame24 581-612 într-o metodă comună în `SWNMiaPaymentsDialogUnit` ca să nu se dubleze);
   - fila **Credit**: `tbsCredit` + grid + `IBCQueryCredit` (copie din frame24 dfm 576-…, 1124) în `cxPageControlComplect`; deschisă doar pe fila activă (`cxPageControlBottomChange` din frame24 816-822), `TabVisible` = drept 1792 și rând web;
   - meniu: `bbEcommInfo` (→ `ShowEcommInformation`, frame24 1184-1195), `bbCancelCashback` (frame24 300-…); vizibile doar pe rând web;
   - responsabil automat la deschidere (`AssignResponsibleOnOpen` din frame24) — doar pe rând web, în `ModifyRecord`;
   - filtru „Doar comenzi web" (checkbox, filtru `CREATED_BY = 9`) lângă filtrele existente; opțional „Doar pe credit" ca în frame24 877-878.

4. **`frmConfigurationDocDialog`** (`frameUtils/08 - Configurator/`): câmp read-only „Cashback folosit" din `TDB_DOCS_CASHBACK_USED` (ca `CASHBACK_USED` din `frmWebZakazDocDialog`), vizibil doar când există rând.

5. **`SWNDealsUnit.pas`**: `DealAnalyticsForDocType` (640-643) → `ADocTypeID in [134, 115]`.

6. **`MainForm.pas`**: nimic — indicatorul numără 134 deschise; comanda mutată iese singură din contor.

7. Fără unități noi → `SWN.dpr` neatins. Build: `msbuild sources/SWN.dproj /p:Config=Release /p:Platform=Win32`; verificat `.dfm` cu `convert.exe -b` pe copii (memoria `dfm-runtime-check-harness`).

## Faza C — site (`fantastic.web/`, UTF-8, git propriu)

- `controllers/MarketingController.php` (:19-27, :97, :163): rădăcini = `doctypeid = 134 OR (doctypeid = 115 AND created_by = 9 AND NOT EXISTS părinte 134)`; `$isRoot` după aceeași regulă; `DOCTYPE_CHILDREN` neschimbat. `vw_tdb_docs` expune `CREATED_BY`.
- Restul site-ului e pe DOCID sau prin proceduri (nimic de schimbat).

## Ordinea lansării

1. Script faza A pe copia locală → test (vezi mai jos) → **rulat pe SW** (procedura nouă nu e apelată de nimeni până la exe-ul nou; garda BU0 e inofensivă).
2. WMS compilat, **exe la toți** (un exe vechi primește eroarea din gardă dacă încearcă să salveze un rând mutat — fără corupere).
3. Deploy site (raport marketing).
4. Mesaj operatorilor: „Creare ofertă" a devenit „Mută în Oferte"; refuzul se face în Web-Order (închidere + motiv în deal), ca până acum.

## Verificare

- **Script** (copie locală): `SP_WEBORDER_TO_OFFER` pe un 134 deschis → `DOCTYPEID 115, STATEID 1, bit 10 = 0`, deal `PIPE_IN_WORK`, `SOURCE_CODE` neschimbat, `TDB_DEAL_LOG` gol; pe 134 închis → excepție; `UPDATE TDB_DOCS SET DOCTYPEID = 134` direct pe un 115 → excepția gărzii; `SP_CANCEL_CASHBACK` pe 115 cu 107 dedesubt → `ERR_CANT_DELETE_DOCUMENT`; `WEB_SIGNUP_OFFER_STATUS` pentru client cu doar 115 web → `HAS_ORDERS`.
- **WMS** (SW, comandă de probă): mutare din frame24 → dispare din Web-Order, apare în Oferte cu rând verde/Plata/MIA/fila Credit; editare preț și salvare → rămâne 115; „Vinzare" din ofertă → oferta se închide; ștergere cu MIA neplătită → dialog de confirmare; contorul roșu scade; mesajul Telegram pentru comanda nouă apare normal.
- **Site**: `/marketing/orders` arată comanda mutată ca rădăcină cu 107 dedesubt.
- Interogare de control după o săptămână: `SELECT COUNT(*) FROM TDB_DOCS WHERE DOCTYPEID = 115 AND CREATED_BY = 9 AND PARENTDOCID NOT IN (SELECT DOCID FROM TDB_DOCS WHERE DOCTYPEID = 134)` crește, iar perechile noi 134 → 115 nu mai apar.


## Stare (23 oct 2026, seara)

- **Faza A**: `DB Model/weborder_to_offer.sql` + `weborder_to_offer_rollback.sql` generate din sursele exacte de pe SW (`isql -x`), testate pe copia locală de metadate: mutare OK (115, STATEID 1, responsabil, deal → PIPE_IN_WORK, FIN păstrat), garda din `TRG_TDB_DOCS_BU0` blochează 134↔115 direct în ambele sensuri, comanda închisă și 1791 sunt refuzate, `SP_CANCEL_CASHBACK` / `WEB_SET_DOC_PAYMENT_ANALYTIC` / `SP_TELEGRAM_BUILD_TEXT` merg pe documentul mutat; rollback-ul compilează. **NERULAT pe SW.**
- **Faza B**: compilată (dcu 23 oct 21:53); `SWN.exe` **nelinkat** (F2039, aplicația era deschisă). Netestat în aplicație.
- **Faza C**: `MarketingController.php` + `views/marketing/_node.php` editate, `php -l` OK; necomis, nedeployat.
- Regula „comandă web" în proceduri: `CREATED_BY = 9` și `DOCTYPEID IN (134, 115)`; `SP_CREATE_RASHOD` închide părintele 115 doar dacă `CREATED_BY = 9` (ofertele manuale rămân deschise).

## Lansat (23 oct 2026, noaptea)

- Scriptul `weborder_to_offer.sql` **rulat pe SW** de S.M.; `SWN.exe` 7.6.4.8 construit din IDE (23:35).
- Test pe SW: comanda reală 2182069 mutată prin `SP_WEBORDER_TO_OFFER` → 115 deschisă, STATEID 1, responsabil 204, deal 3225 `PIPE_IN_WORK` (sursa `SITE_CART_ORDER` păstrată), linii și comentarii intacte, `TLOG_DOCS` are rândul „Web-Order mutat in Oferte", `TDB_DEAL_LOG` gol. **Verificat vizual în WMS de S.M.: merge.**
- Rămân: exe-ul la toți operatorii, deploy-ul site-ului (commit 3317ad3 în fantastic.web).

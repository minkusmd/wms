# PriceImport — import automat de pricelisturi (Python)

Se încarcă atunci când lucrul se face în `PriceImport/`. Regulile generale (codare, build Delphi) sunt în `CLAUDE.md` din rădăcină. Alături stă `AGENTS.md`, o copie identică: ține-le pe amândouă la fel.

Plan și decizii: `Documents/plan-import-automat-pricelisturi-2026-10-27.md`. **Acum e etapa 1 (dry-run)**: serviciul citește pricelisturile, le compară cu `TS_GOODS_FOREIGN`, aplică pragurile și trimite raportul. Scrie **doar** în `TPI_*` și în coada `TELEGRAM_MESSAGES`, nu creează documente 1414 și nu atinge prețurile.

## Structură

- `src/priceimport/adapters/`: câte un adaptor per sursă, înregistrat în `adapters/__init__.py` (`ADAPTERS`, cheia = `TPI_SUPPLIER.ADAPTER_CODE`).
  - `external_plid` citește cel mai nou `TS_PRICELISTS` creat de WMSParsers, frame78 sau `ultra2_sync.py`.
  - `agropiese` e un adaptor nativ pe API (respectă regulile din `AgroPiesePriceListUnit.pas`).
  - Clientul HTTP comun (`http.py`) are timeouts, retry cu backoff + jitter, `Retry-After`, rate limit, fără retry la 401/403 și ascunde token-urile din mesaje.
- `diff.py` reproduce cele 4 reevaluări WMS (baza `gf`). Când WMS a prelucrat deja PLID-ul (`TS_PRICELISTS.FLAGS` valoarea 16), compară cu pricelistul precedent (baza `prev`). RRP-ul se compară după `TS_CUSTOMER.RRP_DISCOUNT`, exact ca `ADJUST_RRP_REEVALUATION`. Un produs „dispărut” devine GONE abia la a doua lipsă.
- `thresholds.py` face carantina pe rând: prag ±, preț 0/negativ, monedă schimbată/greșită (factor ≈ curs), preț absurd. Cât timp o coloană a produsului e în carantină, tot produsul rămâne în carantină. Tot aici sunt gărzile de rulare (EMPTY, VOLUME, INVALID_ROWS, DUPLICATES, MASS_SHIFT) → statusul BLOCKED.
- `coordinator.py` rulează un furnizor: lacăt, etape, jurnal `TPI_RUN`, payload brut arhivat în `data/raw`. `preview_supplier` face aceeași analiză fără nicio scriere.
- `windows.py` gestionează ferestrele (ordine după prioritate și durată, maximum `PI_MAX_PARALLEL`, un adaptor per host, termene soft/hard) și trimite raportul. `service.py` conține scheduler-ul APScheduler + heartbeat-ul.
- `repo.py` adună **tot** SQL-ul. Biții: `TS_GOODS_FOREIGN.FLAGS` bitul 3 = în pricelist (valoarea 8), bitul 4 = EPP (16); `TS_PRICELISTS.FLAGS` valoarea 2 = API, 16 = prelucrat.

## DDL (le rulează DBA-ul)

`DB Model/price_import_stage1.sql` (tabelele `TPI_*`, canalul `PRICELIST_IMPORT` **inactiv**, furnizorii inițiali cu `FLG_AUTO_APPLY = 0`) + `_rollback.sql` + `price_import_grants.sql` (utilizatorul `PRICEIMPORT`, creat de DBA cu parola lui). Indexul parțial `UX_TPI_RUN_ACTIVE` (Firebird 5) garantează o singură rulare activă per furnizor. `SOURCE_TABLE = -50` în `TELEGRAM_MESSAGES`.

## Comenzi

```
.venv/Scripts/python -m pytest                       # 67 de teste; cele de integrare cer Firebird 5 local (embedded)
python -m priceimport preview 14805 --plid 6115      # analiză FĂRĂ scriere (merge și fără DDL)
python -m priceimport compare-wms 6115               # echivalența cu cele 4 interogări WMS (PLID neprelucrat)
python -m priceimport check | run 198 | window 0 --only 198 | status | serve | health
```

Configurarea e în variabile `PI_*` (vezi `.env.example`), iar parola în `PI_FB_PASSWORD` / `PI_FB_PASSWORD_FILE`. Parametrii unei surse stau în `suppliers/<id>.yaml`; cei operaționali (fereastră, praguri, activ) în `TPI_SUPPLIER`. Deploy-ul se face cu `compose.yaml` (Docker pe .240) sau `pi serve` sub NSSM.

## Capcane

- **EUR e 976 în `TS_CURRENCY`** (nu 978): monedele se rezolvă după `TITLE`, nu după codul ISO numeric.
- Comparația brută a RRP-ului (ca în WMS) arată la fiecare import „+RRP_DISCOUNT%” la toate produsele EPP. `compare-wms` o folosește intenționat, ca să rămână identic cu WMS.
- Pentru `external_plid`, WMSParsers/frame78 fac reevaluările imediat. După ele `TS_GOODS_FOREIGN` conține deja pricelistul, de unde vine și baza `prev`.
- Testele embedded: Firebird în mod embedded ține fișierul exclusiv, deci isql (DDL) rulează înainte de conexiunile Python, nu în paralel.
- Fișierele noi se scriu în UTF-8 (Python). DDL-ul din `DB Model/` rămâne ASCII.

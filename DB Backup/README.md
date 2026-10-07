# Backup incremental Firebird cu nbackup

Scripturi pentru baza SW (`d:\data\sw5.fdb`, Firebird 5) care rulează **pe serverul bazei** — nbackup citește direct fișierul bazei, deci nu poate rula de pe alt calculator.

| Nivel | Când | Conține |
|---|---|---|
| L0 | săptămânal (implicit duminică 01:00) | toată baza |
| L1 | zilnic (01:00) | modificările de la ultimul L0 |
| L2 | la fiecare oră fixă | modificările de la ultimul L1 |
| L3 | la 15 minute | modificările de la ultimul L2 |

O singură sarcină din Task Scheduler rulează `nbackup-sw.ps1` la 15 minute; scriptul alege singur nivelul. După un L0 urmează întâi L1, apoi L2, apoi L3 (nivelul nu sare niciodată peste „ultimul + 1”), așa că fiecare fișier are o bază clară și restaurarea e deterministă.

## De ce nu blochează baza

`nbackup -B` face `ALTER DATABASE BEGIN BACKUP`: fișierul principal devine doar-citire pentru server, scrierile utilizatorilor merg în `sw5.fdb.delta`, iar la final delta se îmbină **online** în bază. Nimeni nu e deconectat și nicio tranzacție nu așteaptă (testat: backup cu o tranzacție de scriere deschisă — 1 s, fără așteptare).

În plus, scriptul:
- pornește nbackup cu prioritate `BelowNormal` și `-DIRECT ON` (citirea bazei nu golește cache-ul Windows);
- nu pornește o rulare nouă cât timp cea precedentă încă merge (mutex + `IgnoreNew` în Task Scheduler) — un L0 de câteva ore doar face ca rulările de la 15 min din acel interval să fie sărite;
- dacă baza a rămas în modul backup după o rulare întreruptă (`MON$BACKUP_STATE = 1`, delta crește la nesfârșit), după 60 min face `nbackup -N` (END BACKUP) și continuă.

## Instalare pe server

1. Copiați folderul (de ex. în `C:\Scripts\nbackup`).
2. Ca Administrator:
   ```powershell
   cd C:\Scripts\nbackup
   .\install-nbackup-task.ps1 -Database d:\data\sw5.fdb -BackupRoot E:\Backup\nbackup\SW
   ```
   Cere parola SYSDBA și o salvează în `nbackup-sw.pwd` (acces doar SYSTEM + Administrators), face o rulare de probă `-DryRun` și înregistrează sarcina „Firebird nbackup SW” (ca SYSTEM, la 15 min).
3. Prima rulare face L0 complet (sau pornire imediată: `Start-ScheduledTask -TaskName 'Firebird nbackup SW'`).

Jurnal: `<BackupRoot>\logs\nbackup_<an-luna>.log`. La eroare sarcina se termină cu codul 1 (vizibil în „Last Run Result”).

Parametri utili (în `-ExtraArgs` la instalare): `-L0Weekday`, `-L0Hour`, `-L1Hour`, `-KeepChains` (implicit 2), `-KeepL2Days` (7), `-KeepL3Hours` (48), `-StalledMinutes` (60).

## Spațiu pe disc (baza are ~460 GB)

- Fiecare lanț săptămânal = un L0 (~460 GB) + incrementele. Cu `KeepChains = 2` rămân ~2 × 460 GB, iar în timpul unui L0 nou e nevoie temporar de încă ~460 GB (lanțul vechi se șterge doar după ce L0 nou a reușit). Dacă nu e loc (< mărimea bazei × 1.1), L0 nu pornește: scriptul scrie ERROR în jurnal și continuă lanțul curent cu incremente.
- Puneți `BackupRoot` pe **alt disc fizic** decât baza.
- Lângă bază trebuie loc pentru `sw5.fdb.delta` — crește cât se scrie în bază pe durata unui backup (la L0, câteva ore de lucru).
- Firebird 3+ ține pagini SCN, așa că incrementele nu recitesc toată baza. Urmăriți totuși în jurnal durata L3: dacă se apropie de 15 minute, rulările se vor sări una pe alta.

## Restaurare

```powershell
.\nbackup-sw-restore.ps1 -List                                   # ce fișiere s-ar folosi (ultima stare)
.\nbackup-sw-restore.ps1 -Target F:\restore\sw5.fdb              # ultima stare
.\nbackup-sw-restore.ps1 -Target F:\restore\sw5.fdb -PointInTime '2026-09-25 14:40'
```

Scriptul alege lanțul și fișierele (ultimul backup ≤ momentul cerut + bazele lui până la L0) și rulează `nbackup -R`. Restaurează **într-un fișier nou**, niciodată peste baza de lucru. Precizia: momentul de start al ultimului backup ales (în ultimele 48 h — 15 min; până la 7 zile — 1 oră; mai vechi — ziua).

Verificați baza restaurată (`gfix -v -full`) înainte de a o pune în locul celei de producție.

## Atenție

- **Nu rulați alte `nbackup -B` pe aceeași bază** (manual sau din alt program): nbackup își ia baza incrementului din `RDB$BACKUP_HISTORY` și lanțul acestor scripturi s-ar rupe. `gbak` se poate folosi în paralel fără probleme.
- La fiecare L0 se curăță `RDB$BACKUP_HISTORY` (`-CLEAN_HISTORY -KEEP`), păstrând cât acoperă lanțurile reținute.
- Testați o restaurare completă din când în când (de ex. lunar) pe alt disc.

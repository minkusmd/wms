# CLAUDE.md — CurieriWMS

Aplicația web pentru șoferi/curieri (pe telefon) a dispeceratului WMS: traseul zilei, preluarea de la furnizori (listă blocată + fotografii serie/partidă), livrarea către client, sosirea la depozit.
Dispecerul lucrează în WMS (Delphi, `../sources`); aplicația aceasta este doar interfața șoferului.

Planul funcțional și tehnic: `../Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md` (§9A–9E pentru aplicația web, §11 scenarii de acceptare).

Referință de interfață: aplicația existentă uno.md/app/curier (alt sistem, nu baza SW) — capturi și comparație cu planul în `docs/analiza-uno-curier-2026-10-10.md`.

## Design mobile-first (prioritatea principală)

Aplicația e destinată **în primul rând telefoanelor** șoferilor/curierilor. Orice ecran se proiectează întâi pentru telefon și se optimizează la maximum pentru comoditatea lor; desktopul e secundar.

- O singură coloană, butoane și zone de atingere mari, acțiunea principală ușor de atins cu o mână. Cât mai puțin text de tastat: alegeri, butoane, cameră.
- Informația esențială se vede fără zoom și fără derulare orizontală: numărul comenzii, adresa/oprirea, cantitatea, suma.
- Tiparele preluate din analiza uno.md: carduri mari, starea = punct colorat **și** text (nu doar culoare), rândurile cu excepții (retur, notă urgentă) pe fundal colorat, totalul la finalul opririi, file fixe sus cu contoare.
- Fiecare confirmare cere conexiune la internet (nu există coadă offline, plan §9A), așa că starea trimiterii și erorile trebuie să fie clare pe ecran.

## Stack (versiuni verificate 9 oct 2026)

| Componentă | Versiune |
|---|---|
| PHP | 8.5.11, imagine `php:8.5-fpm-trixie` (OPcache e static în 8.5 — nu se instalează ca extensie) |
| Laravel | 13.35 |
| Livewire | 4.4.7 (Alpine.js inclus de Livewire — nu se încarcă a doua oară) |
| Client Firebird | `libfbclient2` din Debian = Firebird 4.0, compatibil cu serverul 5 |
| Server Firebird | 5.0.4 (SW pe Windows Server 192.168.106.254; baza de test în container) |
| Nginx | 1.29-alpine |

## Rulare — doar prin Docker

PHP-ul instalat pe Windows (`C:\php`, 7.4) aparține de `fantastic.web`. **Nu rula `php`/`composer`/`artisan` pe host** — doar în container:

```powershell
docker compose up -d --build                                  # web http://localhost:8080 + baza de test
docker compose exec app php artisan curieri:verifica-firebird --scriere
docker compose exec app composer require ...
docker compose exec app vendor/bin/pint                       # stilul codului (--test = doar verificare)
docker compose exec app php artisan test                      # PHPUnit: tests/Unit + tests/Feature
docker compose exec app php artisan test --filter=NumeTest    # un singur test
docker compose --profile vite up -d vite                      # Vite cu reîncărcare (opțional)
docker compose run --rm vite sh -c "npm install && npm run build"   # compilează CSS/JS în public/build
docker compose down -v                                        # oprește și ȘTERGE baza de test (se recreează la up)
```

Prima pornire (`.env` din `.env.example`, `key:generate`, `migrate`): pașii sunt în `README.md`. Pe un bind mount Windows fișierele apar ca `root`; după o clonare nouă: `docker compose exec -u root app chmod -R a+rwX storage bootstrap/cache database`.

Testele PHPUnit nu ating Firebird (mesajele procedurilor, formatarea, redirecționarea la login). `phpunit.xml` mută SQLite-ul în memorie, dar **nu** suprascrie `FB_*` — un test care atinge `FirebirdConnection` ar lucra pe baza din `.env` (în dezvoltare = `firebird-test`) și ar modifica-o. Fluxurile cu baza se verifică cu `curieri:verifica-firebird` și în browser pe baza de test (conturile de test sunt în antetul `30-seed.sql`). Acțiunile cu `wire:confirm` deschid un dialog nativ: în testele automate apelează metoda direct (`Livewire.first().startPickup()`).

`docker/php/Dockerfile` are două target-uri: `dev` (codul montat din host, cu Composer; îl folosește compose) și `prod` (codul + Vite compilat în imagine, `composer install --no-dev`). Front-end: Tailwind 4 + Vite (`resources/css`, `resources/js`).

## Structura codului

- `app/Firebird/` — stratul de acces la WMS: `FirebirdConnection` (PDO `Pdo\Firebird`), `Blob`, `FirebirdException`. Configurarea e în `config/firebird.php` (conexiunea `wms`, `protected_databases`), iar înregistrarea `scoped` e în `AppServiceProvider`.
- `app/Console/Commands/VerificaFirebird.php` — `curieri:verifica-firebird` (opțiuni `--scriere`, `--sarcina=PICKUPID`, `--timeout=`); servește și ca exemplu de folosire a stratului (tranzacție, BLOB, două conexiuni în conflict).
- `app/Auth/` — curierul autentificat (`Courier`, nu Eloquent) și `CourierUserProvider` peste `TS_COURIER` + `TS_CUSTOMER` (guard `web`, provider `couriers` în `config/auth.php`). Prima parolă: cod de activare generat în WMS (`SP_COURIER_WEB_ACTIVATION`) → `App\Dispatch\CourierAccounts`.
- `app/Dispatch/` — `RouteRepository` (citiri, mereu filtrate pe curierul autentificat și pe plan publicat), `PickupService` (scrieri numai prin procedurile `SP_CW_*`, cu identificator unic de acțiune), `DispatchException` (mesajele procedurilor → text pentru șofer, cu diacritice).
- `app/Livewire/` — componente pe clase: `Auth\Login`, `Auth\Activate`, `Route\MyRoute` („Traseul meu”), `Route\StopShow` (oprirea: depozit / furnizor cu preluare și fotografii / client). View-uri în `resources/views/livewire/`, layout `layouts::app`.
- `resources/js/app.js` — `photoSlot` (Alpine): fotografia se micșorează în telefon (1600 px, JPEG) și se trimite cu `$wire.upload`; UID-ul încărcării rămâne același până la succes.
- Regulile de business (blocare, fotografii, crearea Intrării 106, idempotență) sunt în `../DB Model/dispatch_logistics.sql`, nu în PHP. Analiza și deciziile: `../Documents/analiza-dispecerat-2026-10-10.md`.
- `docker/firebird-test/init/` — scripturile bazei de test (vezi „Baze de date”).

## Accesul la Firebird (regulile importante)

- Datele operaționale rămân în baza WMS. Le accesezi prin `App\Firebird\FirebirdConnection` (injectat, `scoped` per request): `select`, `selectOne`, `scalar`, `execute`, `transaction`. Fără Eloquent pe tabelele WMS și fără SQL concatenat — numai parametri (`:nume` sau `?`). Un nume de parametru apare **o singură dată** în SQL (`:id1`, `:id2`).
- Baza Laravel locală (SQLite, `database/database.sqlite`) este doar pentru sesiuni, cache și cozi — nu pentru comenzi, sarcini sau solduri.
- Procedurile selectabile (`SELECT … FROM SP_…`) ridică excepțiile abia la `fetch`; `FirebirdConnection` le transformă și acolo în `FirebirdException`. O procedură care scrie se apelează într-o `transaction()` explicită, ca să se facă COMMIT.
- `pdo_firebird` pornește tranzacțiile cu `wait` **fără limită**, iar dialogurile WMS țin tranzacții deschise. De aceea fiecare conexiune execută `SET STATEMENT TIMEOUT` (`FB_STATEMENT_TIMEOUT`, implicit 10 s). Un rând blocat dă `FirebirdException` cu `isTimeout()` (`HY008 … Attachment level timeout expired`) sau `isLockConflict()` (`40001`). Tratează-le ca „alt utilizator modifică sarcina — reîncarcă”, nu ca eroare internă.
- `isBusinessRule()` recunoaște excepțiile `EXCEPTION ERR_*` ridicate din triggere/proceduri WMS: mesajul lor e destinat utilizatorului, nu e o eroare tehnică.
- Cheile rândurilor sunt **cu majuscule** (`PDO::CASE_UPPER`): `$row['PICKUPID']`, nu `$row['pickupid']`.
- În afara lui `transaction()` fiecare instrucțiune rulează în autocommit (read committed). Ce trebuie să fie atomic intră într-o singură `transaction()`; la orice excepție se face ROLLBACK.
- Atribuirile și confirmările se fac cu UPDATE condiționat pe valoarea veche (`… WHERE ID = :id AND DRIVERID IS NOT DISTINCT FROM :old`) și verificarea `rowCount`.
- BLOB text = string UTF-8; BLOB binar (fotografii) = `new App\Firebird\Blob($bytes)`.
- Două tranzacții concurente = două instanțe: `FirebirdConnection::fromConfig(null, [...override])`.
- Definițiile multor obiecte WMS (`VW_*`, `SP_*`) există doar în baza de date. Le citești din `RDB$VIEW_SOURCE` / `RDB$PROCEDURE_SOURCE`. DDL-ul nou merge în `../DB Model/*.sql`, scris re-rulabil, și îl rulează DBA-ul.

## Baze de date

- **Test** (`firebird-test` în compose, fus orar Europe/Chisinau ca SW): stub-uri minime WMS (`docker/firebird-test/init/10-stubs.sql`, fără triggerele WMS de stoc/perioadă) + `../DB Model/supplier_pickup.sql` și `../DB Model/dispatch_logistics.sql` montate direct + date fictive (`30-seed.sql`: plan publicat azi, traseu cu depozit / 2 furnizori / client, conturile de test) + `TCURIERI_PROBE` pentru BLOB-uri. Scripturile rulează numai la crearea volumului (`docker compose down -v` ca să le rulezi din nou). Din Windows: `localhost/3051:/var/lib/firebird/data/curieri_test.fdb`. Stub-urile conțin doar coloanele folosite, nu schema SW: când aplicația are nevoie de o tabelă sau coloană WMS nouă, o adaugi în `10-stubs.sql` (cu tipul din SW).
- **SW (producție)**: numai citiri din dezvoltare. Verificările cu scriere refuză bazele din `config('firebird.protected_databases')`, chiar dacă `FB_ALLOW_WRITE_PROBES=true`. O verificare doar-citire spre SW:
  ```powershell
  $env:FB_PASSWORD = $env:FIREBIRD_PASSWORD
  docker compose exec -e FB_HOST=192.168.106.254 -e FB_DATABASE=SW -e FB_USERNAME=SYSDBA -e FB_PASSWORD -e FB_ALLOW_WRITE_PROBES=false app php artisan curieri:verifica-firebird
  Remove-Item Env:FB_PASSWORD
  ```
  Pe server, aplicația va folosi un cont dedicat (nu SYSDBA). Contul încă nu e creat.
- **Variabile**: în mediul Windows al utilizatorului există `FIREBIRD_PASSWORD` = parola SW (pentru MCP). Docker Compose preferă variabilele din shell față de `.env`, așa că **nu folosi numele `FIREBIRD_*` în `compose.yaml`**. Aplicația folosește `FB_*`, iar containerul de test `FB_TEST_*`.

## Convenții

- Codificare UTF-8 fără BOM, LF. Regula cp1251 din WMS nu se aplică aici.
- Interfața e în limba română, cu diacritice. Identificatorii din cod și comentariile sunt fără diacritice, ca în restul codului (`VerificaFirebird`, `curieri:*`).
- Interfața e mobile-first: vezi secțiunea „Design mobile-first”.
- Stilul codului: Laravel Pint (`vendor/bin/pint`).
- `AGENTS.md` este o copie identică a acestui fișier. Când modifici unul, sincronizează-l și pe celălalt.

## Stadiu

- 9 oct 2026: schelet Laravel + Docker Compose + stratul Firebird; `curieri:verifica-firebird` trece pe baza de test (conexiune, UTF-8, citire sarcină, BLOB 200 KB text / 400 KB binar, tranzacție cu ROLLBACK, conflict de alocare: al doilea writer e refuzat după timeout) și, doar citire, pe SW.
- 10 oct 2026: analiza uno.md/app/curier + deciziile proprietarului (trecute în plan §1, §9F, scenariile 42–46): uno.md rămâne în paralel; returul la furnizor intră în prima versiune; depozitul propriu apare ca oprire de încărcare; șoferul vede prețul de achiziție (preț × cantitate, total pe oprire); interfața doar în română.
- 10 oct 2026, iterația 1: analiza schemei SW și a codului WMS (`../Documents/analiza-dispecerat-2026-10-10.md`); modelul de date + procedurile în `../DB Model/dispatch_logistics.sql` (testat pe baza de test, **nerulat pe SW**); în aplicație: autentificare + activare, „Traseul meu”, oprirea, preluarea completă la furnizor (blocare, cantități, fotografii, închidere cu Intrare marfă 106), livrarea doar de citit. Verificat în browser pe baza de test.
- 10 oct 2026, iterația 2 (etapa 4): forma Dispecerat în WMS (`../sources/classes/Dispatch/`) + procedurile `SP_DISPATCH_*`: atribuirea ridicărilor / retururilor / livrărilor pe curier și zi, gruparea în opriri, ordinea, problemele și publicarea planului. Traseele din aplicație vin acum din WMS, nu doar din `30-seed.sql`.
- Folderul `CurieriWMS/` nu e încă comis în repo-ul WMS (fără istoric git).
- Urmează: DBA rulează DDL-ul și creează userul `CURIERI`; repartizarea zonelor și fișa tipărită (restul etapei 4); livrarea cu autorizare și plata (9E), încărcarea la depozit și sosirea la bază (9D, 9F); seriile din 106 deschis (etapa 3).

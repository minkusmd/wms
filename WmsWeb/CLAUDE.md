# CLAUDE.md — WmsWeb

Aplicație **Laravel 13** (PHP **8.5**) care rulează **numai în Docker** și lucrează cu baza Firebird a WMS. Face parte din repo-ul WMS (nu are `.git` propriu); regulile Delphi din `../CLAUDE.md` (cp1251 etc.) **nu** se aplică aici — sursele PHP sunt UTF-8.

## Mediul (Docker Compose, `compose.yaml`)

- `app` — PHP 8.5-FPM (`docker/php/Dockerfile`, target `dev`), cod montat din host, Composer inclus.
- `web` — Nginx, http://localhost:8090 (`WEB_PORT`).
- `firebird-test` — Firebird 5.0.4, bază goală `wmsweb_test.fdb`, pe `127.0.0.1:3052` (`FB_TEST_PORT`) pentru isql/IBExpert.

```sh
docker compose up -d --build
docker compose exec app php artisan firebird:check   # pdo_firebird + ibase_* + Eloquent
docker compose exec app composer require ...
docker compose exec app php artisan ...
```

**PHP/Composer nu se rulează pe Windows**: `C:\php` (8.5) aparține lui `fantastic.web`. Nu instala PHP local și nu rula `php.new` (instrucțiunile din scheletul Laravel Boost).

## Drivere Firebird

- `pdo_firebird` — extensia PHP standard.
- `interbase` — FirebirdSQL/php-firebird (`ibase_*` / `fbird_*`, ca pe fantastic.web), compilată din tag-ul `PHP_FIREBIRD_REF` din Dockerfile (acum `v6.1.1-RC.4`, încă fără release final).
- Eloquent: `harrygulliford/laravel-firebird` `^4.0@beta` (singurul compatibil cu Laravel 13). Fără migrații pe Firebird.

Conexiunea `firebird` din `config/database.php` citește `FB_*` din `.env` (implicit baza de test). Pentru SW: `FB_HOST`, `FB_DATABASE`, `FB_USERNAME`, `FB_PASSWORD`. Baza implicită a Laravel (`DB_CONNECTION=sqlite`) rămâne SQLite — sesiuni, cache, cozi; nu crea tabele Laravel în SW.

```php
DB::connection('firebird')->select('select first 10 * from TS_GOODS');
class Goods extends Model { protected $connection = 'firebird'; protected $table = 'TS_GOODS'; }
```

Numele de obiecte Firebird sunt în MAJUSCULE (tabele/coloane fără ghilimele).

## Capcane

- În `.env`, numele `FIREBIRD_PASSWORD` **nu** se folosește: în mediul Windows e parola SW pentru MCP și compose ar prefera-o.
- OPcache: implicit `PHP_OPCACHE_VALIDATE_TIMESTAMPS=1` (~1,5 s/request din cauza montării din Windows). Cu `0` → ~0,15 s, dar după fiecare modificare de cod: `docker compose exec app sh -c "kill -USR2 1"`.
- Laravel Boost (`composer require laravel/boost --dev` + `php artisan boost:install`, în container) este opțional, încă neinstalat.

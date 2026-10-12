# CurieriWMS

Aplicația web (pe telefon) pentru șoferii/curierii dispeceratului WMS.
Laravel 13 + Livewire 4 + Alpine.js, PHP 8.5 în Docker, date în Firebird-ul WMS.

## Pornire (dezvoltare)

```powershell
copy .env.example .env          # completează FB_PASSWORD / FB_TEST_* (parole pentru baza de test)
docker compose up -d --build
docker compose exec app php artisan key:generate
docker compose exec -u root app chmod -R a+rwX storage bootstrap/cache database
docker compose exec app php artisan migrate
docker compose exec app php artisan curieri:verifica-firebird --scriere
```

Aplicația: http://localhost:8080. Baza Firebird de test: `localhost/3051`.

Detalii, reguli de acces la Firebird și stadiul lucrului: [CLAUDE.md](CLAUDE.md).
Planul: `../Documents/plan-dispecerat-achizitii-livrari-2026-10-08.md`.

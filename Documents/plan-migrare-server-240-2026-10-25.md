# Mutarea site-urilor de pe serverul vechi (.253) pe serverul Docker (.240)

Data: 25 oct 2026. Stare: **plan**, nimic executat. Inventarul de mai jos e verificat pe
servere in aceeasi zi (comenzi read-only).

Scop: pe `192.168.100.240` ajung fantastic.md (deja acolo, pe :8080), **curieri.fantastic.md,
octa.md, Meilisearch, cron-ul si HTTPS-ul**; IP-ul public `77.89.204.52` trece de pe serverul
vechi `192.168.106.253` pe .240, iar .253 se opreste.

Inlocuieste varianta din `fantastic.web/docker/COMUTARE.md` (nginx-ul vechi ramane in fata) -
acea varianta ramane valabila ca pas intermediar, daca e nevoie de o comutare rapida a lui
fantastic.md inainte de restul.

## 1. Ce e acum (inventar)

### Serverul vechi 192.168.106.253 (Debian, nginx + PHP-FPM, fara containere)

| Ce | Detalii | Se muta? |
|---|---|---|
| **fantastic.md** (+ `www`) | PHP 7.4, pool `fantastic.vpool`; cert. comercial `/etc/nginx/ssl/2020/fantastic-bundle.crt` (fantastic.md + www, expira **28 ian 2027**) | da - codul e deja pe .240 |
| **octa.md** (+ `www`) | acelasi cod ca fantastic (repo `fantastic-old/yii`, ramas la `da77fb7` din 8 sep 2026), **PHP 7.4**, FPM separat `php7.4-fpm-octa.service` (`/etc/php/7.4/fpm/octa/octa.pool`, `env[BRAND] = octa`, fara `config/brands/octa.php`), baza SW; 64 GB din care **63 GB `web/images/cache`** (se regenereaza); cert. Let's Encrypt (expira **15 dec 2026**), webroot `/var/www/letsencrypt` | da |
| **curieri.fantastic.md** | doar un substituent (`<h1>curieri.fantastic.md</h1>`, 20 KB); cert. Let's Encrypt (expira **11 ian 2027**), webroot `/home/curieri.fantastic.md/web`. Aplicatia reala (CurieriWMS, Laravel) **nu e inca in productie** | da - se pune CurieriWMS |
| **Meilisearch** | `meilisearch.service`, :7700, `/var/lib/meilisearch`; il foloseste doar fantastic.md | nu se muta datele - pe .240 exista deja containerul `meili` (v1.55.0), indexul se reconstruieste |
| **Cron (root)** | 12 linii, toate ale fantastic.md (MAIB `processpendingpayments` /10 min si `closeday` 23:59, sitemap, exporturi CSV/Facebook, MIA maib + MIA Victoriabank, reload php7.4-fpm, curatarea sesiunilor) | da - deja tradus in `fantastic.web/docker/cron/fantastic.cron` |
| **Redis** | 127.0.0.1:6379, sesiunile clientilor fantastic (db 2) | nu - .240 are Redis propriu; vezi decizia D6 |
| certbot | `certbot.timer` + `/etc/cron.d/certbot` | se reface pe .240 |
| dev.fantastic.md, dev2, extdev1 | site-uri de dezvoltare, PHP 7.4 / 8.1; dev.fantastic.md e in DNS pe .52 | decizia D4 |
| mebeli.md, neuron.md, plationline.md | vhost-uri moarte: mebeli.md e in DNS pe `77.95.113.16`, neuron.md pe `15.235.207.91`, plationline.md nu exista in DNS | **nu** |
| Samba `[content]` | arata spre `/home/fantastic.md/web/img/content`, care nu exista | **nu** |
| sendmail (doar localhost), Zabbix agent | site-urile trimit prin SMTP `mail.fantastic.md` | Zabbix: da (pasul 6.4) |

Protectia din nginx-ul vechi care trebuie pastrata: `bots-block.conf`, `bots.d/*` +
`conf.d/globalblacklist.conf` + `botblocker-nginx-settings.conf` (bad-bot-blocker),
`map $http_next_action $is_nextjs_bot` (nginx.conf), zonele `limit_req` pe cautare
(`search_ip`, `search_bots`, `octa_search_*`), `client_max_body_size 256m`, `server_tokens off`,
`location /status` cu lista de IP-uri permise.

### Serverul nou 192.168.100.240 (Ubuntu 26.04, 16 nuclee, 15 GB RAM, 213 GB liberi)

| Port | Cine |
|---|---|
| 80 | `uno_prod_nginx` - **uno.md** (in DNS prin Cloudflare). Nu se atinge. |
| 8080 | `fantastic-nginx-1` (fantastic.md pe PHP 8.5, testat) |
| 8888 | `agro-proxy` |
| 127.0.0.1:3306, :8081 | MySQL si nginx-ul uno.md |
| 443 / 8443 | **liber** - HTTPS nu exista inca |

Fara certbot. Containerele fantastic: `nginx`, `php` (8.5.12), `redis`, `meili`.
Schema dispeceratului pentru CurieriWMS (`TS_COURIER`, `TDB_DISPATCH_*`, `SP_CW_*`) **exista pe SW**.

## 2. Arhitectura tinta

```
internet --> 77.89.204.52 :80  --router--> 192.168.100.240:8080 +
             77.89.204.52 :443 --router--> 192.168.100.240:8443 +
                                                                v
                                      edge  (nginx, proiect Docker nou, TLS + boti + limite)
                                        |  retea Docker "edge" 172.30.0.0/24
           +----------------------------+-----------------------+---------------------+
           v                            v                       v                     v
   fantastic-nginx (:80)        octa-nginx (:80)        curieri web (:80)     (dev.fantastic.md - D4)
   php 8.5 / redis / meili      php 7.4 (D3)            app Laravel

uno.md ramane neschimbat pe 192.168.100.240:80 (Cloudflare).
```

- **edge** = un singur nginx in fata, cu certificatele, protectia anti-boti, limitele si
  redirectarile http -> https / fara-www -> www. Fiecare site isi pastreaza nginx-ul lui.
- Porturile pe .240: edge ia **8080** (http) si **8443** (https); `fantastic-nginx` pierde
  portul public (ramane `127.0.0.1:8082` pentru teste). uno.md nu se atinge.
- Certificate: **certbot pe host** (`apt install certbot`), webroot `/srv/edge/acme` montat in
  edge; `/etc/letsencrypt` montat read-only; deploy-hook `docker exec edge-nginx-1 nginx -s reload`.
  Certificatele octa.md si curieri se copiaza de pe .253 (valabile pana in dec/ian), deci HTTPS
  merge din prima secunda; reinnoirea merge dupa mutarea IP-ului.
- IP-ul real al clientului: edge trimite `X-Forwarded-For $remote_addr` (suprascris, nu adaugat) +
  `X-Forwarded-Proto https` si goleste `Client-IP` (ca in `docker/old-server/fantastic-proxy-params.conf`);
  site-urile au incredere doar in `172.30.0.0/24`.

## 3. Decizii de luat inainte

| # | Decizia | Propunerea mea |
|---|---|---|
| D1 | Cine schimba NAT-ul pe router si cand: `77.89.204.52:80 -> .240:8080`, `:443 -> .240:8443` | in fereastra de comutare (faza 5) |
| D2 | IP-ul de iesire spre banci: .240 iese cu **77.89.204.50**, .253 cu .52. MAIB (ecomm, closeday) si Victoriabank (MIA) pot avea lista alba | intai intrebam bancile daca accepta .50; altfel regula SNAT pe router doar pentru traficul .240 -> IP-urile bancilor = .52 (uno.md nu e afectat). **Nu** schimbam iesirea intregului .240 |
| D3 | octa.md: **A)** codul vechi asa cum e, in container PHP 7.4; **B)** codul actual fantastic (PHP 8.5) cu profil `config/brands/octa.php` | A pentru mutare (acelasi comportament, risc mic), B separat dupa aceea - PHP 7.4 nu mai primeste patch-uri |
| D4 | dev.fantastic.md, dev2, extdev1 | dev.fantastic.md ca al doilea proiect `fantastic` pe .240 (branch de dezvoltare), dev2/extdev1 se renunta - de confirmat |
| D5 | Certificatul fantastic.md dupa 28 ian 2027: reinnoit comercial sau Let's Encrypt | Let's Encrypt (gratuit, automat), trecut imediat dupa comutare |
| D6 | Sesiunile: clientii logati fara "tine-ma minte" se deconecteaza o data | acceptat (cosurile stau si in `TWEB_SHOP_CART`); optional mutarea cheilor `fantastic_sess_*` (DUMP/RESTORE) |
| D7 | Fereastra de comutare | noaptea, dar **nu 23:30-00:30** (closeday MAIB 23:59) si nu la :00/:10 (processpendingpayments) - ex. 02:15 |

## 4. Fazele

Fazele 1-4 nu au impact asupra clientilor (totul se testeaza pe .240 cu `curl --resolve`).

### Faza 1 - edge + HTTPS pe .240 (aprox. 2-3 h)

1. `apt install certbot`; `mkdir -p /srv/edge/{acme,ssl/fantastic} /home/docker/edge`.
2. De pe .253, copiate pe .240:
   - `/etc/letsencrypt/` intreg (live + archive + renewal pentru octa.md si curieri.fantastic.md;
     `bucatarii.fantastic.md` a expirat in 2019 - se sterge), apoi in `renewal/*.conf`
     `webroot_path` -> `/srv/edge/acme` si `deploy_hook` pentru reload-ul edge;
   - `/etc/nginx/ssl/2020/fantastic-bundle.crt` + cheia -> `/srv/edge/ssl/fantastic/` (chmod 600 pe cheie);
   - `bots-block.conf`, `bots.d/`, `conf.d/globalblacklist.conf`, `conf.d/botblocker-nginx-settings.conf`,
     blocul `map $is_nextjs_bot` din `nginx.conf`, zonele `limit_req` din `fantastic.conf` / `octa.conf`.
3. Proiectul `/home/docker/edge` (versionat in `fantastic.web/docker/edge/`):
   - `docker-compose.yml`: `nginx:1.28-alpine`, porturi `8080:80` si `8443:443`, reteaua `edge`
     (subnet fix `172.30.0.0/24`), volume pentru config, `/srv/edge`, `/etc/letsencrypt:ro`,
     loguri in `/var/log/edge`;
   - `conf.d/fantastic.conf`: `fantastic.md` -> 301 `https://www.fantastic.md`, `www.fantastic.md`
     -> `proxy_pass http://fantastic-nginx-1`, cu limitele pe cautare, botii si `/status`;
   - `conf.d/octa.conf`, `conf.d/curieri.conf` la fel, fiecare cu certificatul lui;
   - `conf.d/internal.conf`: `listen 80; server_name 192.168.100.240;` -> fantastic, **fara**
     redirect la https, `allow 192.168.100.0/24; deny all;` - pentru cron (gardele de IP din
     `closeday` / `processpendingpayments` cer `192.168.100.*`);
   - TLS doar 1.2 + 1.3 (vechiul server accepta si 1.0/1.1), OCSP stapling, HTTP/2.
4. fantastic (`fantastic.web/docker/`): `nginx` intra in reteaua `edge` (externa),
   `HTTP_PORT=127.0.0.1:8082` in `docker/.env`, in `nginx/default.conf`
   `set_real_ip_from 172.30.0.0/24` si `geo $fm_trusted_proxy` cu acelasi subnet (in locul lui
   192.168.106.253). Commit + deploy obisnuit.
5. Test de pe orice masina din retea:
   `curl -sk --resolve www.fantastic.md:443:192.168.100.240 https://www.fantastic.md:8443/ -o /dev/null -w "%{http_code}"`
   - si pentru `fantastic.md`, `www.octa.md` (dupa faza 2), `curieri.fantastic.md` (dupa faza 3),
   http -> https, IP-ul real in `runtime/logs`, botii blocati (`curl -A "MJ12bot"` -> 444).

### Faza 2 - octa.md pe .240 (aprox. 2-3 h, varianta A din D3)

1. `rsync -a --exclude=/web/images/cache/ root@192.168.106.253:/home/octa.md/ /home/octa.md/`
   (~1 GB; cache-ul de 63 GB se regenereaza singur).
2. Proiect `/home/docker/octa`: imagine `php:7.4-fpm` + `interbase` (client Firebird) + `gd` webp
   + `intl`/`zip`/`bcmath` - acelasi Dockerfile ca fantastic, alta baza; setarile din
   `octa.pool` (pm, `env[BRAND] = octa`, limite de upload) in `zz-octa-fpm.conf`; un nginx
   propriu cu `location`-urile din `octa.conf` (fara TLS); ambele in reteaua `edge`.
3. `config/local.php` de pe .253 copiat neschimbat (aceeasi baza SW). Utilizatorul procesului
   (`fantastic`/`web` pe .253) -> UID-ul din container; `runtime/` si `web/assets` scriibile.
4. Test prin edge cu `--resolve` (pagina principala, categorie, produs, imagini din cache).

### Faza 3 - CurieriWMS pe curieri.fantastic.md (aprox. 2 h)

1. `git clone https://github.com/minkusmd/curieri.git /home/docker/curieri` (repo privat: cheie de
   deploy read-only, ca la fantastic).
2. `.env` din `.env.production.example`: `APP_ENV=production`, `APP_DEBUG=false`,
   `APP_URL=https://curieri.fantastic.md`, `APP_KEY` nou (`php artisan key:generate --show`),
   `SESSION_SECURE_COOKIE=true`, `FB_HOST=192.168.106.254`, `FB_DATABASE=SW`, utilizatorul tehnic
   din `DB Model/dispatch_web_user.sql` (de verificat ca exista pe SW si are drepturile).
3. `compose.edge.yaml` pe server (sau versionat in repo): `web` fara port public (`ports: !reset []`)
   si in reteaua `edge`. `docker compose -f compose.prod.yaml -f compose.edge.yaml up -d --build`.
4. Test: login, "Traseul meu", o preluare cu fotografie pe un traseu de test; `trustProxies`
   accepta deja retelele private (HTTPS corect in linkuri).

### Faza 4 - Meilisearch si datele (aprox. 1 h)

1. Pe .240: `docker compose exec -T -u www-data php php yii search-index/settings` apoi
   `search-index/rebuild`; comparat numarul de documente cu indexul de pe .253
   (`GET /indexes/<index>/stats` cu cheia din `/etc/meilisearch/meilisearch.env`, respectiv
   `MEILI_MASTER_KEY` din `docker/.env`). Cautarea pe .240 nu trebuie sa raspunda `degraded: true`.
2. Copierea imaginilor si a fisierelor urcate (repetata si in faza 5, doar diferentele):
   `rsync -a --exclude=/cache/ /home/fantastic.md/web/images/ root@192.168.100.240:/home/fantastic.md/web/images/`
   si `.../uploads/`; la fel `/home/octa.md/uploads/`.
3. `config/brand.local.php` de productie (MIA Victoriabank activ) e pregatit in
   `/root/brand.local.prod.php` pe .240 - se activeaza doar dupa raspunsul bancilor (D2).

### Faza 5 - comutarea (fereastra D7, aprox. 30 min)

1. **-15 min**: ultimul `rsync` (imagini, uploads fantastic + octa).
2. **.253**: `crontab -l > /root/crontab.before-240`, apoi se comenteaza cele 12 linii fantastic.
3. **Router**: `77.89.204.52:80 -> 192.168.100.240:8080`, `:443 -> 192.168.100.240:8443`
   (+ SNAT spre banci daca asa s-a decis la D2).
4. **.240**: `install -m 644 /home/fantastic.md/docker/cron/fantastic.cron /etc/cron.d/fantastic`
   (URL-urile din el: `http://192.168.100.240:8080/...` -> serverul `internal.conf` din edge);
   MIA: `install -m 640 -g www-data /root/brand.local.prod.php /home/fantastic.md/config/brand.local.php`
   + `php yii mia-vb/preflight` (doar daca D2 e rezolvat).
5. Verificari (din afara retelei - date mobile):
   - fantastic.md: homepage, categorie, produs, cautare, cos, comanda cu numerar (anulata in WMS),
     `/credit` cu doua poze, plata maib cu card de test daca exista, `/nonexistent` -> 404;
   - octa.md: homepage, categorie, produs;
   - curieri.fantastic.md: login;
   - certificatele (`openssl s_client -connect www.octa.md:443 -servername www.octa.md`);
   - `tail -f /var/log/edge/*.log` si `runtime/logs/app.log`;
   - pe telefon: butonul "Detecteaza adresa dupa locatie" la finalizarea comenzii (cere HTTPS).
6. A doua zi dimineata: `closeday` (23:59) si `processpendingpayments` au rulat
   (`runtime/logs`), exporturile CSV/Facebook generate.

### Faza 6 - dupa comutare (1-2 saptamani)

1. `certbot renew --dry-run` pe .240 (octa.md expira 15 dec 2026); certificat Let's Encrypt
   pentru `fantastic.md` + `www` (D5), apoi edge trece pe el.
2. .253: `systemctl disable --now meilisearch php7.4-fpm php7.4-fpm-octa php8.1-fpm nginx redis-server smbd`
   **dupa 7 zile fara revenire**; backup complet al discului inainte de oprirea masinii.
3. Documentatia: `fantastic.web/CLAUDE.md` (sectiunea Docker), `docker/COMUTARE.md` marcat
   ca istoric, memoria proiectului.
4. Zabbix agent pe .240 (monitorizarea containerelor si a certificatelor).
5. octa.md varianta B (D3), daca se decide.

## 5. Revenirea (din faza 5)

1. Router: `77.89.204.52:80/443` inapoi spre `192.168.106.253`.
2. .253: `crontab /root/crontab.before-240`; .240: `rm /etc/cron.d/fantastic`.
3. Nimic altceva: pe .253 codul, PHP-ul, Meilisearch-ul si certificatele raman neatinse pana
   la faza 6. Comenzile plasate pe .240 intre timp sunt deja in SW (aceeasi baza);
   imaginile urcate in intervalul acela se copiaza inapoi cu `rsync`.

## 6. Riscuri

- **Bancile si IP-ul de iesire (D2)** - singurul blocaj extern; fara raspuns, plata cu cardul
  si MIA Victoriabank pot cadea dupa comutare (comenzile cu numerar merg).
- **closeday MAIB** dublat sau ratat: cron-ul se muta in acelasi minut (faza 5, pasii 2 si 4).
- **Gardele de IP** din `closeday` / `processpendingpayments` cred `X-Forwarded-For`: edge trebuie
  sa-l suprascrie (nu sa-l adauge), altfel oricine le poate apela.
- **octa.md pe PHP 7.4** - imagine fara patch-uri de securitate; izolata in container, dar varianta B
  ramane de facut.
- Sesiunile (D6) si cache-ul de imagini octa (primele vizite mai lente pana se regenereaza).
- Portul 80 al .240 ramane al lui uno.md: orice greseala in compose-ul edge care incearca `80:80`
  opreste uno.md - porturile edge sint doar 8080/8443.

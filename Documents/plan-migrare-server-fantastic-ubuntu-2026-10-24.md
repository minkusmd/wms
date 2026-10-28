# Migrare fantastic.md pe server nou (Ubuntu 24.04 LTS, PHP 8.4/8.5)

Data: 24 oct 2026. Stare: plan, nimic executat pe servere.

## De ce

- Serverul actual (`192.168.106.253`, `/home/fantastic.md`) ruleaza **Debian 9 stretch** (fara actualizari din 2022) cu **PHP 7.4.27** (fara actualizari din nov 2022) si `xdebug` incarcat pe productie.
- Depozitul Sury nu mai publica pachete pentru stretch: pe acest server nu se poate instala PHP > 8.1 din pachete (`apt-cache policy php8.4-interbase php8.5-interbase` = nimic).
- Codul site-ului e pregatit pentru PHP 8.5 (24 oct 2026): `composer.json` cere `php ^8.2`, Symfony Mailer in loc de SwiftMailer, Monolog 3, yii2-redis 2.1. Lock-ul se instaleaza pe 8.2-8.5.
- Site-ul proceseaza plati (MAIB, MIA Victoriabank) si copii de buletin -> un OS fara patch-uri de securitate nu e acceptabil.

Decizie: **server nou cu Ubuntu 24.04 LTS** (alternativ Debian 12; diferentele sunt notate). PHP **8.4** din `ppa:ondrej/php` (8.5 daca `php8.5-interbase` exista in PPA la momentul instalarii - verifica cu `apt-cache policy php8.5-interbase`).

Ce NU se schimba: baza Firebird `SW` ramine pe `10.64.128.1` / `192.168.106.254` (serverul web e doar client), WMS (Delphi) nu e atins.

---

## 0. Inventar pe serverul vechi (doar citire, inainte de orice)

Ruleaza pe `root@192.168.106.253` si pastreaza rezultatele:

```
nginx -T > /root/nginx-full.conf 2>&1          # configuratia nginx completa (server_name, root, fastcgi_pass, fastcgi_param YII_ENV, headere cache)
cat /etc/php/7.4/fpm/pool.d/fantastic.vpool    # valori pool: pm.*, post_max_size, upload_max_filesize, memory_limit, env
crontab -l; ls /etc/cron.d/                    # toate cron-urile (feed-uri, sitemap, index cautare, reconciliere MIA)
ls -la /etc/letsencrypt/live/ 2>/dev/null; ls /etc/ssl/ /etc/nginx/ssl 2>/dev/null   # certificate TLS si cum se reinnoiesc
systemctl list-units --type=service | grep -iE "meili|redis|php|nginx"
redis-cli info server | head -5; grep -E "^(requirepass|bind|port)" /etc/redis/redis.conf
cd /home/fantastic.md && git log -1 --oneline && git status --short
du -sh web/images web/font uploads runtime maib/logs maib_cert 2>/dev/null   # ce trebuie copiat (cache de imagini poate fi mare)
ls config/local.php config/brand.local.php maib_cert/                       # fisiere din afara git-ului
```

Verifica si:
- Cine raspunde pe IP-ul public `77.89.204.52`: NAT/port-forward pe router spre `192.168.106.253`? (atunci comutarea se face pe router, nu in DNS).
- Ce alte site-uri sint pe server: pool-urile `dev-fantastic.vpool`, `extdev1.vpool` - decide daca se muta si ele sau ramin pe vechiul server pina la decomisionare.
- Reguli de firewall de care depinde site-ul: iesire spre Firebird `3050`, SMTP `mail.fantastic.md:25`, API-uri MAIB (`api.maibmerchants.md`, `ecomm.maib.md`), Victoriabank MIA (`ips-api-pj.vb.md`), `graph.facebook.com`, Google reCAPTCHA; intrare 80/443.

Fisiere care nu sint in git si trebuie copiate (din `.gitignore`): `config/local.php`, `config/brand.local.php`, `maib_cert/`, `web/images/` (cache-ul generat de site: `images/cache/*`, bannere), `web/font/`, `uploads/`, `runtime/search-index/`, `maib/logs/` (optional), `web/robots.txt`, `web/sitemap*.xml` (se pot regenera).

---

## 1. Serverul nou

- Ubuntu 24.04 LTS Server, minim 2 vCPU / 4 GB RAM / 40 GB disc (cache-ul de imagini decide discul - vezi `du -sh web/images`).
- IP static in aceeasi retea (`192.168.106.x`), hostname `web2` (de exemplu), `timedatectl set-timezone Europe/Chisinau`.
- `apt update && apt full-upgrade -y && reboot`.
- `ufw allow OpenSSH; ufw allow 80,443/tcp; ufw enable`. SSH cu cheie: adauga cheia statiei de lucru in `~/.ssh/authorized_keys` (pe serverul vechi lipsea, de aceea Claude Code nu putea intra).
- Utilizator de deploy: codul ramine sub `root`/`www-data` ca acum sau un utilizator `deploy` in grupul `www-data` - alege si pastreaza consecvent.

---

## 2. Pachete

```
apt install -y nginx redis-server git unzip curl ca-certificates software-properties-common
add-apt-repository -y ppa:ondrej/php && apt update
apt-cache policy php8.5-interbase php8.4-interbase      # alege versiunea pentru care exista interbase
V=8.4   # sau 8.5
apt install -y php$V-fpm php$V-cli php$V-interbase php$V-gd php$V-intl php$V-mbstring php$V-curl php$V-xml php$V-zip php$V-bcmath php$V-opcache php$V-redis php$V-igbinary
php$V -m | grep -iE "interbase|pdo_firebird|gd|intl|mbstring|curl|redis|opcache"
```

- `php$V-interbase` instaleaza si `libfbclient2`. NU instala `xdebug` pe productie.
- Composer 2: `curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer`.
- Meilisearch (daca e folosit pe serverul vechi - `systemctl status meilisearch`): instalare oficiala, aceeasi cheie master in `config/local.php` (`meili.key`), reindexare dupa deploy cu comanda din `commands/SearchIndexController.php`.
- Certificate TLS: Let's Encrypt -> `apt install certbot python3-certbot-nginx`; certificate cumparate -> copiaza `.pem/.key` din inventar.

Debian 12 in loc de Ubuntu: `apt install lsb-release apt-transport-https`, `curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg`, `echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ bookworm main" > /etc/apt/sources.list.d/php.list`; restul identic.

Test de conectare la Firebird inainte de a merge mai departe (parola din `config/params.php`, user `WEBUSER`):

```
php$V -r '$c = ibase_connect("10.64.128.1:SW", "WEBUSER", "<parola>", "utf8"); var_dump($c !== false); echo ibase_errmsg();'
```

---

## 3. PHP-FPM

`/etc/php/$V/fpm/pool.d/fantastic.conf` (porneste de la `fantastic.vpool` de pe vechiul server, actualizeaza):

```
[fantastic]
user = www-data
group = www-data
listen = /run/php/php$V-fpm-fantastic.sock
listen.owner = www-data
listen.group = www-data
pm = dynamic
pm.max_children = 20        ; ajusteaza dupa RAM (fiecare worker ~60-120 MB)
pm.start_servers = 4
pm.min_spare_servers = 2
pm.max_spare_servers = 6
pm.max_requests = 500
php_admin_value[post_max_size] = 48M          ; pozele de buletin (2 poze de telefon)
php_admin_value[upload_max_filesize] = 40M
php_admin_value[memory_limit] = 512M
php_admin_value[max_execution_time] = 180     ; index.php seteaza si el 180
php_admin_value[date.timezone] = Europe/Chisinau
php_admin_value[opcache.enable] = 1
php_admin_value[opcache.memory_consumption] = 256
php_admin_value[opcache.max_accelerated_files] = 20000
php_admin_value[opcache.validate_timestamps] = 1
php_admin_value[opcache.revalidate_freq] = 60   ; dupa `git pull` fie astepti 60 s, fie `systemctl reload php$V-fpm`
php_admin_flag[display_errors] = off
php_admin_value[error_log] = /var/log/php/fantastic-error.log
env[YII_ENV] = prod
```

`mkdir -p /var/log/php && chown www-data /var/log/php`. Sterge/dezactiveaza `www.conf` implicit daca nu e folosit. `systemctl enable --now php$V-fpm`.

---

## 4. nginx

Porteaza server block-ul din `nginx-full.conf` (inventar). Punctele obligatorii pentru acest site:

```
server {
    listen 443 ssl http2;
    server_name www.fantastic.md fantastic.md;
    root /home/fantastic.md/web;
    index index.php;
    client_max_body_size 256m;

    location / { try_files $uri $uri/ /index.php?$args; }

    location ~ \.php$ {
        try_files $uri =404;
        include fastcgi_params;
        fastcgi_pass unix:/run/php/php8.4-fpm-fantastic.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param REMOTE_ADDR $remote_addr;   # OBLIGATORIU: SecurityGuard (IP-uri blocate), /clear-cache, lista de IP-uri de debug
        fastcgi_param YII_ENV prod;               # sursa de adevar pentru mediu (altfel cade pe config/local.php)
        fastcgi_read_timeout 180;
    }

    # statice cu cache ca in .htaccess-ul vechi (30 zile imagini/fonturi, 1 an images/cache cu hash in nume)
    location ~* \.(css|js)$            { expires 7d;  add_header Cache-Control "public"; }
    location ~* \.(png|jpe?g|webp|svg|ico|woff2?)$ { expires 30d; add_header Cache-Control "public"; }
    location ^~ /images/cache/        { expires 365d; add_header Cache-Control "public, immutable"; }

    location ~ /\.(git|ht|env) { deny all; }
    location ~ ^/(config|runtime|vendor|maib_cert|maib)/ { deny all; }
}
server { listen 80; server_name www.fantastic.md fantastic.md; return 301 https://www.fantastic.md$request_uri; }
```

- Pastreaza din vechea configuratie: redirectul `fantastic.md` -> `www.fantastic.md`, gzip, HSTS daca exista, orice `location` special (de ex. `/clear-cache` permis doar de pe `192.168.100.180`/localhost - regula e in cod, dar verifica ca nu e si in nginx).
- Al doilea brand (tehnomarket.md, `config/brands/tehnomarket.php`) daca e servit de acelasi cod: server block separat cu acelasi `root`, brandul se alege dupa `Host` / env `BRAND` (vezi `config/brand.php`).
- `nginx -t && systemctl reload nginx`.

---

## 5. Codul

```
cd /home && git clone <remote> fantastic.md && cd fantastic.md
git checkout master            # dupa ce upgrade-ul PHP 8.5 e comis si (ideal) mers in master; pina atunci ramura feature/php85
composer install --no-dev --optimize-autoloader --no-interaction
```

Apoi copiaza de pe serverul vechi (rsync peste SSH, pastrind drepturile):

```
rsync -a root@192.168.106.253:/home/fantastic.md/config/local.php        config/
rsync -a root@192.168.106.253:/home/fantastic.md/config/brand.local.php  config/   # daca exista
rsync -a root@192.168.106.253:/home/fantastic.md/maib_cert/              maib_cert/
rsync -a root@192.168.106.253:/home/fantastic.md/web/images/             web/images/
rsync -a root@192.168.106.253:/home/fantastic.md/web/font/               web/font/
rsync -a root@192.168.106.253:/home/fantastic.md/uploads/                uploads/
rsync -a root@192.168.106.253:/home/fantastic.md/runtime/search-index/   runtime/search-index/
rsync -a root@192.168.106.253:/home/fantastic.md/web/robots.txt root@...:/home/fantastic.md/web/sitemap*.xml web/
```

Drepturi de scriere pentru `www-data`: `runtime/`, `web/assets/`, `web/images/`, `uploads/`, `maib/logs/`, `web/` (feed-urile `facebook_export.csv`, `google_export.csv`, sitemap-urile se scriu in `web/`):

```
chown -R www-data:www-data runtime web/assets web/images uploads maib/logs
chmod -R u+rwX runtime web/assets web/images uploads maib/logs
```

In `config/local.php` verifica: `env => 'prod'` (fallback), `redis` (host/port/parola/database - Redis nou pleaca gol, cache-ul se reconstruieste), `firebird.password`, `smtp`, `meili`, `recaptcha`, cheile MAIB/MIA. `php8.4 yii` trebuie sa listeze comenzile fara erori.

---

## 6. Cron

Ia liniile exacte din `crontab -l` de pe vechiul server si pune-le pe cel nou cu binarul `php8.4` (sau `php`) si `cd /home/fantastic.md`. Comenzile existente in `commands/`: `export/*` (feed-uri Facebook/Google/DSA), `merchant-feed/*`, `sitemap/*`, `search-index/*` (Meilisearch - cronul lipsea pe vechiul server, de adaugat), `mia-qr-reconcile/*`, `mia-vb/*`, `product-redirect/*`, `security/*`, `convert-static-images/*`. Exemplu:

```
*/15 * * * * cd /home/fantastic.md && YII_ENV=prod php yii mia-qr-reconcile/run >> /var/log/php/cron-mia.log 2>&1
```

Nu porni cron-urile care trimit ceva in exterior (feed-uri publicate, reconcilieri MIA care schimba starea comenzilor) pe ambele servere in acelasi timp: pe cel nou le activezi doar dupa comutare.

---

## 7. Test pe hostul nou, inainte de comutare

De pe statia de lucru, fara a atinge DNS-ul: `curl -sk --resolve www.fantastic.md:443:<IP-nou> https://www.fantastic.md/...` sau o linie in `hosts` + browser. Parcurge:

1. Homepage, o categorie cu filtre si paginare, o pagina de produs, cautare, `/produse-noi`, `/promo/<id>`, `/sitemap`, `/robots.txt`, versiunea RU (`/change-language/ru`), 404.
2. Adaugare in cos (dialog AJAX), cos, checkout cu numerar pina la crearea comenzii de test (apoi anuleaz-o in WMS), oferta de bun venit.
3. Formular de credit cu 2 poze de telefon (testeaza `post_max_size` 48M), `/credit`.
4. Inregistrare + e-mail de confirmare, contact, recuperare parola -> verifica ca e-mailurile pleaca prin Symfony Mailer (`mail.fantastic.md:25`); la eroare vezi `runtime/logs/app.log`.
5. Login, profil, favorite, comparare.
6. Plata MIA: pagina `/plata-mia/<token>` pentru o comanda de test (sandbox daca e configurat); MAIB card online daca e activ.
7. `/clear-cache` de pe `192.168.100.180` -> 200 si cache golit; de pe alt IP -> 403.
8. Imagini: o imagine de produs inca necesata in cache (`web/images/cache/...`) se genereaza (drepturi de scriere + GD webp); headerele `Cache-Control` pe statice.
9. Consola: `php yii export/facebookfeed` (sau comanda folosita) scrie fisierul; `php yii search-index/...` reindexeaza Meilisearch.
10. Loguri curate: `runtime/logs/app.log`, `/var/log/php/fantastic-error.log`, `/var/log/nginx/error.log` - fara `Deprecated`/`Fatal`.
11. Performanta: `curl -o /dev/null -w "%{time_total}"` pe homepage/categorie, comparat cu vechiul server (opcache activ: `php8.4 -r 'var_dump(opcache_get_status()["opcache_enabled"]);'` din FPM, nu CLI).

---

## 8. Comutarea

1. Anunta un interval (seara/noapte), ingheata deploy-urile pe ambele servere.
2. Daca IP-ul public `77.89.204.52` e NAT pe router: schimba port-forward-ul 80/443 spre IP-ul nou (comutare instanta, rollback instant). Daca e DNS: cu 24 h inainte coboara TTL-ul la 300 s, apoi schimba A-record-ul.
3. Pe vechiul server opreste cron-urile (`crontab -r` dupa ce le-ai salvat) ca sa nu ruleze dublu.
4. Ultimul `rsync` pentru `web/images/`, `uploads/`, `runtime/search-index/` (si `config/local.php` daca s-a schimbat intre timp).
5. Comuta. Verifica de pe un telefon pe 4G: homepage, un produs, o adaugare in cos.
6. Activeaza cron-urile pe serverul nou.
7. Urmareste 24 h: `tail -f /var/log/nginx/access.log` pentru 5xx, `runtime/logs/app.log`, comenzile care intra in WMS (frame 24), Telegram `WEB_ORDERS`, Google Search Console (erori de crawl).
8. Rollback: port-forward/DNS inapoi spre `192.168.106.253`, cron-urile inapoi pe vechi. Vechiul server ramine pornit cel putin 2 saptamini.

---

## 9. Dupa comutare

- Actualizeaza memoria si `fantastic.web/CLAUDE.md`/`AGENTS.md`: IP-ul serverului, `php8.4`, calea pool-ului (`/etc/php/8.4/fpm/pool.d/fantastic.conf` in loc de `/etc/php/7.4/fpm/pool.d/fantastic.vpool`), comanda de deploy (`git pull --ff-only origin master && composer install --no-dev && systemctl reload php8.4-fpm`).
- Pe WMS: nimic de schimbat in cod; verifica doar orice referinta la `192.168.106.253` (scripturi, Telegram, DB Service) si lista alba de IP-uri din `web/index.php` (`$debugIPs`) daca s-a schimbat statia.
- Reinnoirea certificatelor (`certbot renew --dry-run`) si backup-ul zilnic pentru `config/local.php`, `maib_cert/`, `web/images/`, `uploads/`.
- Mergi `feature/php85` in `master`; serverul nou e primul loc unde codul ruleaza pe PHP 8.x in productie.
- Decomisionarea vechiului server (sau pastrarea lui doar pentru `dev-fantastic`/`extdev1` pina sint mutate si ele).

## Riscuri cunoscute

- `php8.5-interbase` poate lipsi din PPA la momentul instalarii: foloseste 8.4, codul si lock-ul merg identic.
- Redis gol dupa comutare: primele minute sint mai lente pina se reconstruieste cache-ul (homepage ~12 s la prima randare locala fara cache). Poti incalzi cache-ul inainte de comutare cu cateva `curl --resolve` pe homepage, categoriile mari si top produse.
- E-mail: Symfony Mailer e testat local doar la construirea transportului; prima trimitere reala se face pe serverul nou (pasul 7.4). Daca `mail.fantastic.md:25` cere STARTTLS cu certificat self-signed, adauga in `config/web.php` optiunea `'options' => ['verify_peer' => false]` in `transport`.
- Lista de IP-uri de debug din `web/index.php` include `127.0.0.1`: cu `fastcgi_param REMOTE_ADDR` lipsa, PHP ar vedea toate cererile ca locale (debug toolbar expus) - de aceea parametrul e obligatoriu.

# Imaginea WmsWeb: PHP 8.5-FPM + Composer + drivere Firebird (client Firebird pentru Linux).
#   pdo_firebird - PDO (Laravel / Eloquent prin pachetul din composer.json)
#   firebird     - functiile ibase_* / fbird_* (fosta extensie interbase, ca pe fantastic.web)
# Target "dev": codul se monteaza din host (compose.yaml).
FROM php:8.5-fpm-trixie AS base

# versiunea extensiei FirebirdSQL/php-firebird (tag git)
ARG PHP_FIREBIRD_REF=v6.1.1-RC.4

# opcache e inclus static in PHP 8.5, nu se mai instaleaza ca extensie
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        firebird-dev libfbclient2 \
        libicu-dev libzip-dev libpng-dev libjpeg62-turbo-dev libwebp-dev \
        unzip git; \
    docker-php-ext-configure gd --with-jpeg --with-webp; \
    docker-php-ext-install -j"$(nproc)" pdo_firebird intl zip gd bcmath exif pcntl; \
    git clone --depth 1 --branch "$PHP_FIREBIRD_REF" https://github.com/FirebirdSQL/php-firebird.git /usr/src/php-firebird; \
    cd /usr/src/php-firebird; \
    phpize; \
    CPPFLAGS=-I/usr/include/firebird ./configure --with-interbase=/usr; \
    make -j"$(nproc)"; \
    make install; \
    docker-php-ext-enable interbase; \
    cd /; rm -rf /usr/src/php-firebird; \
    rm -rf /var/lib/apt/lists/*; \
    php -m | grep -qi pdo_firebird; \
    php -m | grep -qiE '^(interbase|firebird)$'

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY docker/php/php.ini /usr/local/etc/php/conf.d/zz-wmsweb.ini

WORKDIR /var/www/html

# ---------------------------------------------------------------- dev
FROM base AS dev
ARG UID=1000
ARG GID=1000
RUN set -eux; \
    groupmod -o -g "$GID" www-data; \
    usermod -o -u "$UID" -g www-data www-data; \
    mkdir -p /var/www/.composer; chown -R www-data:www-data /var/www
USER www-data

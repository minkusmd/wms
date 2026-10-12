# Imaginea aplicatiei CurieriWMS: PHP 8.5-FPM + pdo_firebird (client Firebird pentru Linux).
#   target "dev"  - codul se monteaza din host, include Composer
#   target "prod" - codul si resursele compilate sunt incluse in imagine
FROM php:8.5-fpm-trixie AS base

# opcache e inclus static in PHP 8.5, nu se mai instaleaza ca extensie

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        firebird-dev libfbclient2 \
        libicu-dev libzip-dev libpng-dev libjpeg62-turbo-dev libwebp-dev \
        unzip git; \
    docker-php-ext-configure gd --with-jpeg --with-webp; \
    docker-php-ext-install -j"$(nproc)" pdo_firebird intl zip gd bcmath exif; \
    rm -rf /var/lib/apt/lists/*; \
    php -m | grep -qi pdo_firebird

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY docker/php/php.ini /usr/local/etc/php/conf.d/zz-curieri.ini

WORKDIR /var/www/html

# ---------------------------------------------------------------- dev
FROM base AS dev
ARG UID=1000
ARG GID=1000
RUN set -eux; \
    groupmod -o -g "$GID" www-data; \
    usermod -o -u "$UID" -g www-data www-data
USER www-data

# ---------------------------------------------------------------- assets (build Vite)
FROM node:24-alpine AS assets
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci || npm install
COPY . .
RUN npm run build

# ---------------------------------------------------------------- prod
FROM base AS prod
ENV APP_ENV=production
COPY --chown=www-data:www-data . /var/www/html
COPY --from=assets --chown=www-data:www-data /app/public/build /var/www/html/public/build
RUN set -eux; \
    composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader; \
    rm -f /usr/bin/composer
USER www-data

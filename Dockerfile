FROM php:8.2.18-fpm-bullseye

WORKDIR /app/

# Copy composer.phar
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
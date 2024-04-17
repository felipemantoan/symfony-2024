FROM php:8.2.18-fpm-bullseye

WORKDIR /app/

# Copy composer.phar
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# persistent / runtime deps
# hadolint ignore=DL3008
RUN apt update && apt install -y --no-install-recommends \
	acl \
	file \
	gettext \
	git libzip-dev libicu-dev \
    $PHPIZE_DEPS \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
	docker-php-ext-install opcache && \
	docker-php-ext-install zip

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

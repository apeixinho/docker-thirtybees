FROM php:8.1-fpm

# Instalar dependencias y módulos PHP necesarios
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    intl \
    pdo_mysql \
    soap \
    zip

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-enable gd

# Habilitar OPcache
RUN docker-php-ext-enable opcache

# Configurar el archivo de configuración de PHP
#COPY php.ini /usr/local/etc/php/conf.d/custom.ini

# Establecer permisos adecuados para el servidor web
RUN chown -R www-data:www-data /var/www/html/

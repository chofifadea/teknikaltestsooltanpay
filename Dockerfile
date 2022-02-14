#BASE IMAGE
FROM php:7.4-apache

#TIMEZONE
ENV TZ="Asia/Jakarta"

#INSTALL COMPOSER
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

#INSTALL TOOLS PEMBANTU
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    nano \
    libicu-dev \
    git \
    zip \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/*

#DEPEDENSI/EXTENSION UNTUK PROJECT PHP
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions bz2 \
    gettext \
    intl \
    exif \
    gd \
    zip \
    pdo_pgsql \
    pdo_mysql \
    bcmath


#SETTINGAN WEBSERVER APAHCHE2
COPY default.conf /etc/apache2/sites-enabled/000-default.conf
# COPY .env.example /app/.env

#Rewrite Module di WEBSERVER
RUN a2enmod rewrite

#WORKING DIR
WORKDIR /app

#COPY CODE TO APP
COPY . /app/

#run command
RUN composer install

#cleaning rootdir apache
RUN rm -Rf /var/www/html

#symlink project to webserver 
RUN ln -sFf /app/public /var/www/html

#change ownership
RUN chown www-data:www-data -R /app

#expose apache port
EXPOSE 80

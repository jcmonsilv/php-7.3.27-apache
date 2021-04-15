FROM php:7.3.27-apache

RUN apt-get clean
RUN apt-get update

# INSTALL PHP EXTENSIONS
RUN docker-php-ext-install pdo_mysql

# ANABLE APACHE MOD REWRITE
RUN a2enmod rewrite
# ANABLE APACHE MOD HEADER
RUN a2enmod headers

#install some basic tools
RUN apt-get install -y \
        git \
        tree \
        vim \
        wget \
        subversion \
        openssl \
        zip \
        unzip \
        libnss3 \
        libpng-dev \
        libzip-dev

#setup composer
RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
        
# Change www-data user to match the host system UID and GID and chown www directory
RUN usermod --non-unique --uid 1000 www-data \
  && groupmod --non-unique --gid 1000 www-data \
  && chown -R www-data:www-data /var/www
  
EXPOSE 80

WORKDIR /var/www/html

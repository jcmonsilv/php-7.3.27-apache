FROM php:7.3.27-apache

RUN apt-get clean
RUN apt-get update

#install some basic tools
RUN apt-get install -y \
        git \
        tree \
        vim \
        wget \
        subversion

#install some base extensions
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip

#setup composer
RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer


WORKDIR /var/www/

FROM php:7-apache


MAINTAINER Paul Redmond

COPY . /srv/app
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /srv/app \
    && a2enmod rewrite

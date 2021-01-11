FROM php:7.3-fpm
WORKDIR /app
COPY . /app

CMD php artisan serve --host=167.99.227.217 --port=8050

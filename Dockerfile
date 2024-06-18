FROM php:8.1-apache
RUN cd /etc/apache2/mods-enabled \
  && ln -s ../mods-available/rewrite.load
ADD deploy-config/docker-image/docker/www/000-default.conf /etc/apache2/sites-enabled/
#ADD php.ini /usr/local/etc/php/

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update \
  && apt-get -y install vim zip unzip \
  libzip-dev libpng-dev libpq-dev libfreetype6-dev libjpeg-dev libonig-dev \
 cron supervisor
RUN docker-php-ext-install pdo pdo_mysql mysqli zip exif
RUN docker-php-ext-configure gd \
  --with-freetype=/usr/include/ \
  --with-jpeg=/usr/include
RUN docker-php-ext-install -j$(nproc) gd

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN rm -rf node_modules
RUN apt-get install -y nodejs
RUN npm install npm -g n --save-dev cross-env
#RUN npm cache clear --force
RUN npm install webpack --save
#
#RUN pecl install xdebug \
#  && docker-php-ext-enable xdebug

WORKDIR /var/www

COPY . .

COPY deploy-config/docker-image/root/ /root
COPY deploy-config/docker-image/docker/www/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY deploy-config/docker-image/docker/www/crontab /etc/cron.d/ursula-cron

RUN echo installing composer..
RUN composer install --optimize-autoloader --no-dev
#RUN echo creating .env file..
#RUN cp .env.example .env
RUN echo generating app key
RUN php artisan key:generate
RUN echo install node modules..
RUN npm install --omit
RUN echo build node module..
RUN npm run build
RUN chmod -R 775 ./vendor/bin
RUN chmod -R 777 ./storage/ ./bootstrap/cache/

# copy_font.sh
# for TCPDF
RUN cp ./setup/fonts/*.z ./vendor/tecnickcom/tcpdf/fonts/
RUN cp ./setup/fonts/*.php ./vendor/tecnickcom/tcpdf/fonts/

# for MPDF
RUN mkdir ./vendor/mpdf/mpdf/tmp/mpdf
RUN chmod 777 ./vendor/mpdf/mpdf/tmp/mpdf
RUN cp ./setup/fonts/*.ttf ./vendor/mpdf/mpdf/ttfonts/

# Add permission file and run crontab
RUN chmod 0644 /etc/cron.d/ursula-cron
RUN crontab /etc/cron.d/ursula-cron

# Expose port 80 to access
EXPOSE 80

# Start Apache
#CMD ["apache2-foreground"]
CMD ["sh", "-c", "cron && supervisord -c /etc/supervisor/conf.d/supervisord.conf"]

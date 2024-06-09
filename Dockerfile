# Sử dụng image PHP chính thức với Apache và PHP 8.1
FROM php:8.1-apache
RUN cd /etc/apache2/mods-enabled \
  && ln -s ../mods-available/rewrite.load
ADD docker/000-default.conf /etc/apache2/sites-enabled/
#ADD php.ini /usr/local/etc/php/

RUN apt-get update \
  && apt-get -y install vim zip unzip \
  libzip-dev libpng-dev libpq-dev libfreetype6-dev libjpeg-dev libonig-dev
RUN docker-php-ext-install pdo pdo_mysql mysqli zip exif
RUN docker-php-ext-configure gd \
  --with-freetype=/usr/include/ \
  --with-jpeg=/usr/include
RUN docker-php-ext-install -j$(nproc) gd

# Tạo thư mục làm việc
WORKDIR /var/www

# Sao chép toàn bộ mã nguồn Laravel vào container
COPY . .

# Kích hoạt các module Apache
RUN a2enmod rewrite

# Expose cổng 80 để truy cập HTTP
EXPOSE 80

# Khởi động Apache
CMD ["apache2-foreground"]

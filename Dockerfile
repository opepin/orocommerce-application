FROM php:5.4-apache
MAINTAINER opepin <opepin@optaros.com>

RUN apt-get update 
RUN apt-get install -y libxml2-dev libmcrypt-dev libicu-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev php5-intl php5-apcu git vim \
    && docker-php-ext-install pdo_mysql iconv mcrypt json ctype intl mbstring soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

RUN apt-get install -y curl && curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - &&  apt-get install --yes nodejs

COPY composer.json /opt/oro/
 
WORKDIR /opt/oro

RUN  curl -s https://getcomposer.org/installer | php && \
php composer.phar install --prefer-source --no-scripts 

ENV TZ=UTC
RUN echo date.timezone=\"$TZ\" > /usr/local/etc/php/conf.d/oro.ini && \
echo memory_limit=512M >> /usr/local/etc/php/conf.d/oro.ini

COPY . /opt/oro/
RUN  php composer.phar run-script post-install-cmd 

RUN a2enmod rewrite && apt-get install -y mysql-client 
RUN rm -r /var/www/html && ln -s /opt/oro/web /var/www/html
EXPOSE 80
COPY infra/002-oro-commerce.conf /etc/apache2/sites-enabled/ 

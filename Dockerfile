FROM ubuntu:trusty

MAINTAINER Samuel ROZE <samuel.roze@gmail.com>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    curl \
    apache2 \
    apache2-utils \
    libapache2-mod-php5 \
    php5-intl \
    php5-mysql \
    php5-mcrypt \
    php5-gd \
    php5-curl \
    php5-xsl \
    php5-apcu \
    git \
    && /usr/sbin/php5enmod mcrypt \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Apache & PHP configuration
RUN a2enmod rewrite
COPY docker/apache/apache2.conf /etc/apache2/apache2.conf
COPY docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY docker/php/php.ini /etc/php5/apache2/php.ini
COPY docker/php/php.ini /etc/php5/cli/php.ini
RUN rm /etc/apache2/conf-enabled/other-vhosts-access-log.conf

# Add the application
ADD . /app
WORKDIR /app

CMD ["/app/docker/run.sh"]
#FROM debian:jessie
FROM ubuntu:16.04

RUN apt-get update 

# --- Libs & Tools ---
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y wget
RUN apt-get install -y apt-transport-https
RUN apt-get install -y locales
RUN apt-get install -y software-properties-common
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y git
RUN apt-get install -y net-tools
RUN apt-get install -y mysql-client
RUN apt-get install -y libzip-dev #require: pecl zip 
RUN apt-get install -y python-software-properties
RUN apt-get install -y zip

# --- Settings ---
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# --- Repositories ---
# PHP5
RUN add-apt-repository ppa:ondrej/php
# Update
RUN apt-get update

# --- Apache ---
RUN apt-get -y install apache2
# Enmod
RUN a2enmod rewrite
RUN a2enmod headers
# Config
COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# --- PHP ---
# PHP & Pecl
RUN apt-get install -y php5.6 php-pear php5.6-dev
RUN apt-get install -y libcurl3-openssl-dev
# PHP libs
RUN apt-get install -y php5.6-common php5.6-cgi php5.6-cli php5.6-mcrypt php5.6-intl php5.6-xsl php5.6-gd php5.6-mbstring php5.6-json php5.6-curl php5.6-zip php5.6-xml php5.6-soap php5.6-zip
RUN apt-get install -y libapache2-mod-php5.6
RUN a2enmod php5.6
# PHP DBs
RUN apt-get install -y php5.6-mysql php5.6-mssql php5.6-sybase php5.6-redis
#PHP Debug
RUN apt-get install -y php5.6-xdebug
#Config
COPY ./php.ini /etc/php/5.6/apache2/
#PHP Xdebug - Conf
RUN echo "xdebug.remote_enable=true" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_autostart=true" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_host=172.18.0.1" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_handler=dbgp" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_mode=req" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_port=9000" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "xdebug.remote_log=/tmp/xdebug.log" >> /etc/php/5.6/apache2/conf.d/20-xdebug.ini

# --- Linux ---
RUN usermod -u 1000 www-data
RUN usermod -G staff www-data
# Apache enviroment variables
#ENV APACHE_RUN_USER www-data
#ENV APACHE_RUN_GROUP www-data
#ENV APACHE_LOG_DIR /var/log/apache2
#ENV APACHE_LOCK_DIR /var/lock/apache2
#ENV APACHE_PID_FILE /var/run/apache2.pid

# --- PHP Packages ---
RUN curl --silent --show-error https://getcomposer.org/installer | php

# --- Start services ---
EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

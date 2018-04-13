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
RUN apt-get install -y iputils-ping
RUN apt-get install -y mysql-client
RUN apt-get install -y libzip-dev #require: pecl zip 
RUN apt-get install -y python-software-properties
RUN apt-get install -y zip
RUN apt-get install -y openssh-server

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
# Override default PHP version on PHP5.6
RUN ln -sf /usr/bin/php5.6 /etc/alternatives/php
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
RUN echo "zend_extension=xdebug.so\n\ 
xdebug.remote_enable=true\n\
xdebug.remote_autostart=true\n\
#xdebug.remote_host=172.20.5.0\n\
xdebug.remote_connect_back=1\n\
xdebug.remote_handler=dbgp\n\
xdebug.remote_mode=req\n\
xdebug.remote_port=9000\n\
xdebug.remote_log=/tmp/xdebug.log"\
> /etc/php/5.6/apache2/conf.d/20-xdebug.ini
RUN echo "zend_extension=xdebug.so\n\
xdebug.remote_enable=true\n\
xdebug.remote_autostart=true\n\
#xdebug.remote_host=172.20.5.0\n\
xdebug.remote_connect_back=1\n\
xdebug.remote_handler=dbgp\n\
xdebug.remote_mode=req\n\
xdebug.remote_port=9000\n\
xdebug.remote_log=/tmp/xdebug.log"\
> /etc/php/5.6/cli/conf.d/20-xdebug.ini
RUN echo "zend_extension=xdebug.so\n\
xdebug.remote_enable=true\n\
xdebug.remote_autostart=true\n\
#xdebug.remote_host=172.20.5.0\n\
xdebug.remote_connect_back=1\n\
xdebug.remote_handler=dbgp\n\
xdebug.remote_mode=req\n\
xdebug.remote_port=9000\n\
xdebug.remote_log=/tmp/xdebug.log"\
> /etc/php/5.6/cgi/conf.d/20-xdebug.ini

# Composer - Install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Composer - Packages
RUN composer global require --dev phpunit/phpunit 5.7.27

#Add composer to enviroment path
RUN echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc

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

# --- SSH server config ---
COPY ./sshd_config /etc/ssh/sshd_config

# --- Add aliases ---
RUN echo 'alias htmlDir="cd /var/www/html/"' >> ~/.bashrc

# --- Start services ---
EXPOSE 80
EXPOSE 443
EXPOSE 9000

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

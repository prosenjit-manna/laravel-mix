FROM ubuntu/apache2
LABEL maintainer="prosenjit@itobuz.com"
RUN apt-get update
RUN a2enmod rewrite && a2enmod headers && a2enmod expires
RUN apt install -y php libapache2-mod-php php-mysql
RUN apt install php-curl -y
RUN apt install php-dom -y
RUN apt-get install php-mbstring -y

RUN apt install zip unzip -y
RUN apt-get install php-zip -y
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y mysql-client

# Default appache config
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./default-ssl.conf /etc/apache2/sites-available/default-ssl.conf


RUN apt install nano -y
RUN a2enmod ssl
RUN a2ensite default-ssl.conf

# Composer install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# RUN apt install imagemagick  php-imagick -y
# RUN apt-get install -y webp

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs



# Enter in docker image
# docker exec -it laravel-mix_laravel-dev_1 /bin/bash 

# Go to root dir
# cd /var/www/html

# Install laravel 
# curl -s https://laravel.build/example-app | bash
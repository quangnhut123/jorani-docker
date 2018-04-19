FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install -y nano curl apt-utils wget unzip apache2 php libapache2-mod-php apache2-utils
RUN apt-get install -y php-mysql php-ldap php-mcrypt php-mbstring php-zip php-xml php-gd php-curl openssl
RUN phpenmod mcrypt
RUN wget https://github.com/bbalet/jorani/releases/download/v0.6.5/jorani-0.6.5.zip
RUN rm -Rf /var/www/html
RUN unzip jorani-0.6.5.zip
RUN mv /jorani /var/www/html/
RUN chown -R www-data:www-data /var/www/html
RUN a2enmod rewrite
COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY database.php /var/www/html/application/config/database.php
COPY email.php /var/www/html/application/config/email.php
ENV DEBIAN_FRONTEND teletype
# Configure Apache2
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
env APACHE_PID_FILE     /var/run/apache2.pid
env APACHE_RUN_DIR      /var/run/apache2
env APACHE_LOCK_DIR     /var/lock/apache2
env APACHE_LOG_DIR      /var/log/apache2
EXPOSE 80
ENTRYPOINT [ "/usr/sbin/apache2", "-DFOREGROUND" ]

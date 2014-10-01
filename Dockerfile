FROM ubuntu:14.04
MAINTAINER Aleksey Krasnobaev <alekseykrasnobaev@gmail.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 \
	libapache2-mod-php5 php5-mysql
# enable SSL
RUN a2enmod ssl; mkdir /etc/apache2/ssl;

# phpMyAdmin setup
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install phpmyadmin
RUN chmod 777 /var/lib/phpmyadmin/config.inc.php
ADD ./config.inc.php /etc/phpmyadmin/
ENV match <Directory \/usr\/share\/phpmyadmin>
ENV insert \tAllowOverride All
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen;        \
	sed -i "s/BLOWSECRET/$(pwgen -B -s 24 1)/g" /etc/phpmyadmin/config.inc.php;\
	sed -i "s/$match/$match\n$insert/" /etc/phpmyadmin/apache.conf; \
	sed -i "s/80/81/" /etc/phpmyadmin/phpmyadmin.service;           \
	echo session.save_path = "/tmp" >> /etc/php5/cli/php.ini
ADD ./sites-available/0081-phpmyadmin.conf /etc/apache2/sites-available/0081-phpmyadmin.conf
ADD ./sites-enabled/0081-phpmyadmin.conf /etc/apache2/sites-enabled/0081-phpmyadmin.conf

# dumper setup
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget unzip;      \
	wget https://sypex.net/files/SypexDumper_2011.zip -O sxd2011.zip;  \
	unzip sxd2011.zip -d /; mv /sxd /usr/share/dumper; rm sxd2011.zip; \
	chmod 777 /usr/share/dumper/backup;                                \
	chmod 666 /usr/share/dumper/cfg.php /usr/share/dumper/ses.php;
ADD ./sites-available/0082-dumper.conf /etc/apache2/sites-available/0082-dumper.conf
ADD ./sites-enabled/0082-dumper.conf /etc/apache2/sites-enabled/0082-dumper.conf

# phpPgAdmin setup
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install phppgadmin
RUN sed -i "s/extra_login_security'\] = true/extra_login_security'] = false/" /etc/phppgadmin/config.inc.php
ADD ./sites-available/0083-phppgadmin.conf /etc/apache2/sites-available/0083-phppgadmin.conf
ADD ./sites-enabled/0083-phppgadmin.conf /etc/apache2/sites-enabled/0083-phppgadmin.conf

# list open apache ports here
ADD ./ports.conf /etc/apache2/ports.conf
ADD ./index.html /var/www/html/index.html

ADD ./run.sh /run.sh
RUN chmod 755 /*.sh


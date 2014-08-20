FROM ubuntu:trusty
MAINTAINER Aleksey Krasnobaev <alekseykrasnobaev@gmail.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 \
	libapache2-mod-php5 php5-mysql
ADD ./ports.conf /etc/apache2/ports.conf
EXPOSE 80

# phpMyAdmin setup
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install phpmyadmin
ADD ./sites-available/0081-phpmyadmin.conf /etc/apache2/sites-available/0081-phpmyadmin.conf
ADD ./sites-enabled/0081-phpmyadmin.conf /etc/apache2/sites-enabled/0081-phpmyadmin.conf
RUN chmod 777 /var/lib/phpmyadmin/config.inc.php
ADD ./config.inc.php /etc/phpmyadmin/
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install pwgen;                \
	sed -i "s/SECRET/$(pwgen -B -s 24 1)/g" /etc/phpmyadmin/config.inc.php; \
	DEBIAN_FRONTEND=noninteractive apt-get -y install apache2-utils;        \
	htpasswd -bc /etc/phpmyadmin/htpasswd.setup admin qwerty;
EXPOSE 81

# dumper setup
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget unzip;      \
	wget https://sypex.net/files/SypexDumper_2011.zip -O sxd2011.zip;  \
	unzip sxd2011.zip -d /; mv /sxd /usr/share/dumper; rm sxd2011.zip; \
	chmod 777 /usr/share/dumper/backup;                                \
	chmod 666 /usr/share/dumper/cfg.php /usr/share/dumper/ses.php;
ADD ./sites-available/0082-dumper.conf /etc/apache2/sites-available/0082-dumper.conf
ADD ./sites-enabled/0082-dumper.conf /etc/apache2/sites-enabled/0082-dumper.conf
EXPOSE 82

ADD ./run.sh /run.sh
RUN chmod 755 /*.sh
CMD ["/run.sh"]


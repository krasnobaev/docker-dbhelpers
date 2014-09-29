#!/bin/bash
sed -i "s/MYSQL_PORT_3306_TCP_ADDR/$MYSQL_PORT_3306_TCP_ADDR/g" /etc/phpmyadmin/config.inc.php;
sed -i "s/MYSQL_PORT_3306_TCP_PORT/$MYSQL_PORT_3306_TCP_PORT/g" /etc/phpmyadmin/config.inc.php;
sed -i "s/MYSQL_PORT_3306_TCP_PROTO/$MYSQL_PORT_3306_TCP_PROTO/g" /etc/phpmyadmin/config.inc.php;
sed -i "s/MYSQL_ENV_MYSQL_ROOT_PASSWORD/$MYSQL_ENV_MYSQL_ROOT_PASSWORD/g" /etc/phpmyadmin/config.inc.php;

sed -i "s/  'my_host' => '',/  'my_host' => '$MYSQL_PORT_3306_TCP_ADDR',/g" /usr/share/dumper/cfg.php;

sed -i "s/'port'] = .*/'port'] = $POSTGRES_PORT_5432_TCP_PORT;/" /etc/phppgadmin/config.inc.php
sed -i "s/'host'] = .*/'host'] = '$POSTGRES_PORT_5432_TCP_ADDR';/" /etc/phppgadmin/config.inc.php

source /etc/apache2/envvars
exec apache2 -D FOREGROUND


<?php
/* Servers configuration */
$i = 0;

/* Server: localhost [1] */
$i++;
$cfg['Servers'][$i]['verbose'] = 'linkedMySQLcontainer';
$cfg['Servers'][$i]['host'] = 'MYSQL_PORT_3306_TCP_ADDR';
$cfg['Servers'][$i]['port'] = 'MYSQL_PORT_3306_TCP_PORT';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'MYSQL_PORT_3306_TCP_PROTO';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['user'] = 'root';
$cfg['Servers'][$i]['password'] = 'MYSQL_ENV_MYSQL_ROOT_PASSWORD';

/* End of servers configuration */

$cfg['blowfish_secret'] = 'BLOWSECRET';
$cfg['ServerDefault'] = 1;
$cfg['ForceSSL'] = true;
$cfg['PmaAbsoluteUri'] = 'https://SERVER_NAME:811/';
?>


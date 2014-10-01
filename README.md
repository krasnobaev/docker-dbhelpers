docker-dbhelpers
================

Docker image which runs DB helpers on different ports.
MySQL is installed separately.
[Oficial Docker repository](https://registry.hub.docker.com/_/mysql/).

What is included:
- ubuntu (14.04)
- phpMyAdmin (latest from apt-get)
- phpPgAdmin (latest from apt-get)
- sypex dumper (v2011)
- apache (latest from apt-get)

What is not included:
- MySQL
- PostgreSQL

In order to backup with dumper in your local directory (not container folder)
you should set `$DUMPERBACKUPFOLDER` environment variable which holds path to
your local directory.

If you want set custom apache homepache you should set `$OWNHOMEPAGE`
environment variable.

Building the base image
-----------------------

To create the base image `krasnobaev/dbhelpers`, execute the following commands:

```bash
git clone https://github.com/krasnobaev/docker-dbhelpers
cd docker-dbhelpers
sudo make build
```

where `make build` means

```bash
docker build -t krasnobaev/dbhelpers .
```

Prerequisites
-------------

mysql setup:
```bash
export MYSQL_ROOT_PASS=mysecretpassword
docker run -d --name some-mysql -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASS mysql
```

to check mysql root password:
```bash
docker run -it --rm --link some-mysql:mysql busybox printenv MYSQL_ENV_MYSQL_ROOT_PASSWORD
```

postgresql setup:
```bash
docker run -d --name some-postgres postgres
```

then you need to change default password:
```bash
docker run -it --rm --link some-postgres:postgres postgres sh -c 'exec psql -Upostgres -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT"'
\password postgres

\q
```

Run image
---------

System-wide setup
```bash
mkdir -p /var/dumper
echo export DUMPERBACKUPFOLDER=/var/dumper >> /etc/profile
```

```bash
sudo -E make run
```

which means

```bash
docker run -d --name dbhelpers                            \
    --link some-mysql:mysql --link some-postgres:postgres \
    -v $DUMPERBACKUPFOLDER:/usr/share/dumper/backup       \
    -p 80:80 -p 81:81 -p 82:82 -p 83:83                   \
    krasnobaev/dbhelpers
```

also available commands:
```bash
sudo -E make runwithownhomepage
sudo make runbash
```

Default container ports
-----------------------

- 80 - apache homepage
- 81 - phpMyAdmin
- 82 - sypex dumper
- 83 - phpPgAdmin

To-Do list
----------

- expand makefile
- add sedna helpers support


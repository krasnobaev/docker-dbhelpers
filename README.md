krasnobaev-dbhelpers
====================

Docker image which runs DB helpers on different ports.
MySQL is installed separately.

In order to backup with dumper in your local directory (not container folder) you should set `$DUMPERBACKUPFOLDER` environment variable which holds path to your local directory.

Building the base image
-----------------------

To create the base image `krasnobaev/dbhelpers`, execute the following commands:

	$git clone https://github.com/krasnobaev/docker-dbhelpers
	$cd docker-dbhelpers
	$sudo make build

where `make build` means

	docker build -t krasnobaev/dbhelpers .

Run image
---------

	$sudo make run

which means

	docker run --link some-mysql:mysql -d                      \
		-v $DUMPERBACKUPFOLDER:/usr/share/dumper/backup        \
		-p 50000:80 -p 50001:81 -p 50002:82 krasnobaev/dbhelpers

Default container ports
-----------------------

80 - apache homepage
81 - phpmyadmin
82 - sypex dumper

To-Do list
----------

- expand makefile
- add sedna helpers support
- change phpMyAdmin password


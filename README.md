krasnobaev-dbhelpers
====================

Docker image which runs DB helpers on different ports.
This image is intended to run on local machine.


Building the base image
-----------------------

To create the base image `krasnobaev/dbhelpers`, execute the following command on the krasnobaev-dbhelpers folder:

	docker build -t krasnobaev/dbhelpers .

Run
---

	docker run --link some-mysql:mysql -d -p 8081:80 -p 8082:81 -p 8083:82 krasnobaev/dbhelpers


Default ports
-------------

81 - phpmyadmin
82 - sypex dumper


To-Do list
----------

- shared folders
- add makefile
- rename dbhelpers image
- add sedna helpers support
- phpmyadmin dynamic ip


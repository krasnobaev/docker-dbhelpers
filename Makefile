build:
	docker build -t krasnobaev/dbhelpers .

run:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-p 80:80 -p 81:81 -p 82:82 -p 83:83                   \
		-p 811:811 -p 812:812 -p 813:813                      \
		krasnobaev/dbhelpers sh -c '/run.sh $(shell uname -n)'

runownhomepage:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-v $(OWNHOMEPAGE):/var/www/html/index.html            \
		-p 80:80 -p 81:81 -p 82:82 -p 83:83                   \
		-p 811:811 -p 812:812 -p 813:813                      \
		krasnobaev/dbhelpers sh -c '/run.sh $(shell uname -n)'

runwww:
	docker run -d --name dbhelpers                            \
		-v $(OWNHOME):/var/www/html/ -p 80:80                 \
		krasnobaev/dbhelpers sh -c '/run.sh $(shell uname -n)'

runbash:
	docker run -it --rm --name dbhelpers                      \
		--link some-mysql:mysql --link some-postgres:postgres \
		krasnobaev/dbhelpers /bin/bash

stop:
	docker stop dbhelpers
	docker rm dbhelpers


build:
	docker build -t krasnobaev/dbhelpers .

run:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-v $(WWWHOMEINDEX):/var/www/html/index.html           \
		-p 80:80 -p 50001:81 -p 50002:82 -p 50003:83          \
		krasnobaev/dbhelpers

runwithoutwwwhome:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-p 50001:81 -p 50002:82 -p 50003:83                   \
		krasnobaev/dbhelpers

runbash:
	docker run -it --name dbhelpers                           \
		--link some-mysql:mysql --link some-postgres:postgres \
		krasnobaev/dbhelpers /bin/bash


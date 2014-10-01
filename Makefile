build:
	docker build -t krasnobaev/dbhelpers .

run:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-v $(WWWHOMEINDEX):/var/www/html/index.html           \
		-p 80:80 -p 50001:81 -p 50002:82 -p 50003:83          \
		-p 811:811 -p 812:812 -p 813:813                      \
		krasnobaev/dbhelpers sh -c '/run.sh $(shell uname -n)'

runwithoutwwwhome:
	docker run -d --name dbhelpers                            \
		--link some-mysql:mysql --link some-postgres:postgres \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup     \
		-p 80:80 -p 50001:81 -p 50002:82 -p 50003:83          \
		-p 811:811 -p 812:812 -p 813:813                      \
		krasnobaev/dbhelpers sh -c '/run.sh $(shell uname -n)'

runbash:
	docker run -it --name dbhelpers                           \
		--link some-mysql:mysql --link some-postgres:postgres \
		krasnobaev/dbhelpers /bin/bash


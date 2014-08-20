all:
	docker build -t krasnobaev/dbhelpers .

run:
	docker run --link some-mysql:mysql -d                      \
		-v $(DUMPERBACKUPFOLDER):/usr/share/dumper/backup      \
		-p 50000:80 -p 50001:81 -p 50002:82 -d krasnobaev/dbhelpers


#! /bin/bash

#./build.sh &>/dev/null &

#can use in crontab
#./build.sh > /dev/null 2>&1

if [ -d "./target/" ]
then
	rm -r target/
fi

docker build -t build-jar-inside-docker-image .
docker create -it --name build-jar-inside-docker build-jar-inside-docker-image bash
docker cp build-jar-inside-docker:/target ./target
docker rm -f build-jar-inside-docker

result=$(docker ps -a -q --filter="name=openjdk")

if [[ -n "$result" ]]; then
    docker stop $(docker ps -a -q --filter="name=openjdk")
else
    echo 'No such container image'
fi

docker compose up

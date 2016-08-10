#!/bin/bash

service_name=lsc-piwik
piwik_service_name=$service_name
db_service_name=$service_name-db
db_password=123abcd
http_service_name=$service_name-http

docker run --name $db_service_name -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$db_password -v `pwd`/mysql/runtime:/var/lib/mysql -d mysql

docker run --name $piwik_service_name --link $db_service_name:db -p 9000:9000 -v `pwd`/config:/var/www/html/config -d piwik

sed "s/\$piwik_service_name/$piwik_service_name/g" nginx.conf.template > ./nginx.conf
docker run --name $http_service_name -p 8080:80 --link $piwik_service_name --volumes-from $piwik_service_name -d nginx
docker cp ./nginx.conf $http_service_name:/etc/nginx/nginx.conf
docker restart $http_service_name
rm ./nginx.conf

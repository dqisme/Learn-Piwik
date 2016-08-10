#!/bin/bash

service_name=lsc-piwik
piwik_service_name=$service_name
db_service_name=$service_name-db
db_password=123abcd
http_service_name=$service_name-http

docker run --name $db_service_name -p 3306:3306 -e MYSQL_ROOT_PASSWORD=$db_password -v `pwd`/database:/var/lib/mysql -d mysql

docker run --name $piwik_service_name --link $db_service_name:db -p 9000:9000 -v `pwd`/config:/var/www/html/config -d piwik

docker run --name $http_service_name -p 80:80 --link $piwik_service_name:app -v `pwd`/nginx.conf:/etc/nginx/nginx.conf:ro --volumes-from $piwik_service_name -d nginx

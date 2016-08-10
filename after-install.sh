#!/bin/bash

domain_name=localhost:8080
service_name=lsc-piwik
http_service_name=$service_name-http

docker exec $http_service_name sed -i "/trusted_hosts/s/localhost/$domain_name/" /var/www/html/config/config.ini.php

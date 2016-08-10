#!/bin/bash

service_name=lsc-piwik
for piwik_container in `docker ps -f "name=$service_name" -qa`; do docker stop $piwik_container; docker rm $piwik_container; done
rm -rf config/ mysql/

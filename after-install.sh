#!/bin/bash

domain_name=localhost:8080
sed "/trusted_hosts/s/localhost/$domain_name/" ./config/config.ini.php | tee ./config/config.ini.php

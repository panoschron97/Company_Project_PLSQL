#!/bin/bash

set -e

. ~/.bash_profile

echo "Enter Username"
read username
echo "Enter Password"
read password
echo "Enter database connection string : "
read db
echo "Enter full path or absolute path of sql script : "
read sqlscript
logfile='/home/oracle/Desktop/bash_scripts/logs/sample.log'

sqlplus -S ${username}/${password}@${db} @${sqlscript} >${logfile}


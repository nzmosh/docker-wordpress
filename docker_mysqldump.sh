#!/bin/bash

path=`pwd`
dir=`basename $path`

docker exec $dir sh -c "mysqldump -u root wordpress > /mysql.dump.sql" 


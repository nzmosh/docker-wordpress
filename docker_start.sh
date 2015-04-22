#!/bin/bash

path=`pwd`
dir=`basename $path`

docker ps -a -q | xargs docker rm -f

docker build -t $dir .

docker run -i -t -d -p 80:80 --name=$dir \
  -v $(pwd)/wp-content:/app/wp-content \
  -v $(pwd)/wp-config.php:/app/wp-config.php \
  -v $(pwd)/mysql.dump.sql:/mysql.dump.sql \
  $dir

echo "======================"
echo "Open $(boot2docker ip)"
echo "======================"

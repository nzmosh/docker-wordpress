#!/bin/bash

path=`pwd`
dir=`basename $path`

docker rm -f $dir
docker rmi -f $dir


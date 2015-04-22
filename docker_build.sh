#!/bin/bash

path=`pwd`
dir=`basename $path`

docker rm -f $dir
docker build -t $dir .

